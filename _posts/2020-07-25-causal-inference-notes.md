---
layout: "post"
title: "Notes on Causal Inference"
categories: "statistics"
tags: [math]
published: true
---


Over the course of this summer and as a part of my experience interning with [quantco](https://www.quantco.com/), I've become rather interested in principled statistical modelling and in particular, causal inference. Here, I plan on maintaining and updating some technical notes for personal use as I continue to read through Susan Athey's course materials for Stanford's ECON293. 




# Basics: Potential Outcomes Framework, ATE, and Unconfoundedness

In the potential outcomes framework one observes a tuple $$(X_i, Y_i, W_i)$$ of feature, 
response, and treatment indicator variables such that $$Y_i = Y_i(W_i)$$. Causal effects
of a treatment are defined by the change in response variables $$Y_i(1) - Y_i(0)$$, and our typical goal is to estimate this average treatment effect (ATE) $$\tau = E[Y_i(1)-Y_i(0)]$$.


Typically, we don't observe both potential outcomes, so we estimate $$\tau$$ using averages
across the treated and controlled cohorts: i.e $$\hat{\tau} = \frac{\sum_{i:W_i=1}Y_i}{\vert \{i: W_i=1\}} -  \frac{\sum_{i:W_i=0}Y_i}{\vert \{i: W_i=0\}}$$. This is an extremely simple estimator, and satisfies certain desirable properties -- it is unbiased, consistent, asymptotically Gaussian, and efficient to calculate. However, one can achieve lower variance
by further conditioning on the covariates i.e $$\tau = E[Y_i(1) - Y_i(0) \vert X_i]$$ and using any standard out-of-box ML predictor optimized on minimizing L2 norm errors.


In small samples, hidden features with causal relations to the response variables may exaggerate or diminish the apparent treatment effects. To mitigate this, the traditional approach is to apply stratified sampling. However, simpler approaches need only rely on the existence of good estimators. For simplicity, let us define the conditional response surface as $$\mu_{(w)}(x) = E[Y_i \vert X_i=x, W_i=w]$$, in which case an oracle with access to the response surfaces could directly estimate $$\tau$$ via $$\overline{\tau} = \frac{1}{n}\sum_{i=1}^n (\mu_{(1)}(X_i) - \mu_{(0)}(X_i))$$. This motivates the naive approach: using standard ML methods, construct estimators $$\hat{\mu_{(0)}}, \hat{\mu_{(1)}}$$ and estimate the ATE as $$\hat{\tau} = \frac{1}{n}\sum_{i=1}^n (\hat{\mu_{(1)}}(X_i) - \hat{\mu_{(0)}(X_i)})$$. If these estimators are consistent (i.e converge in L2 norm to the true response surfaces), then the naive approach is asymptotically optimal.


The rest of this post is dedicated to various methods that improve upon this fundamental approach we have developed, aiming to improve performance in terms of efficiency and robustness across multiple domains.


# Doubly Robust Estimators: AIPW

The naive approach we developed earlier suffers from a critical flaw: it's entirely dependent on the quality of our response surface estimators $$\hat{\mu_{(0)}}, \hat{\mu_{(1)}}$$. If either estimator is biased or poorly calibrated, our treatment effect estimates will be similarly flawed. This motivates the development of _doubly robust_ estimators, which remain consistent if _either_ the response surface or the propensity score model is correctly specified.

The Augmented Inverse Propensity Weighting (AIPW) estimator achieves this by combining the response surface approach with inverse propensity weighting. Let $$e(x) = P(W_i=1 \vert X_i=x)$$ denote the propensity score (the probability of treatment given covariates). The AIPW estimator is given by:

$$
\begin{align*}
\hat{\tau}_{AIPW} = \frac{1}{n}\sum_{i=1}^n \left[ \hat{\mu_{(1)}}(X_i) - \hat{\mu_{(0)}}(X_i) + \frac{W_i(Y_i - \hat{\mu_{(1)}}(X_i))}{\hat{e}(X_i)} - \frac{(1-W_i)(Y_i - \hat{\mu_{(0)}}(X_i))}{1-\hat{e}(X_i)} \right]
\end{align*}
$$

The key insight here is that the weighting terms correct for misspecification in the response surfaces. If $$\hat{\mu_{(w)}}$$ are correctly specified, the weighted residual terms vanish in expectation. Conversely, if the propensity score $$\hat{e}(x)$$ is correct, the inverse weighting removes confounding bias even when the response surfaces are misspecified. 

# Double ML

While AIPW provides robustness, it still requires careful attention to regularization when using modern ML methods. The Double Machine Learning (DML) framework, developed by Chernozhukov et al., provides a systematic approach to debiasing treatment effect estimates when using flexible ML methods for nuisance parameters.

The core problem DML addresses is _regularization bias_. When we use regularized ML methods (like LASSO, random forests, or neural networks) to estimate nuisance functions like $$\mu_{(w)}(x)$$ or $$e(x)$$, the regularization that makes these methods work well for prediction introduces bias in our causal estimates. This bias doesn't necessarily vanish even with large samples. DML solves this through a clever combination of orthogonalization and sample splitting. 

Start with a score function $$\psi(W, Y, X; \theta, \eta)$$ that is Neyman-orthogonal with respect to nuisance parameters $$\eta$$. For ATE estimation, this might look like:

$$
\psi(W, Y, X; \tau, \eta) = (Y - \mu_{(W)}(X)) \cdot (W - e(X)) + \mu_{(1)}(X) - \mu_{(0)}(X) - \tau
$$

The orthogonality condition ensures that first-order errors in estimating $$\eta$$ don't affect our estimate of $$\tau$$. We can then split our data into $$K$$ folds and train nuisance parameter estimators $$\hat{\eta}_{-k}$$ on all folds except $$k$$. Then we can evaluate the score function on fold $$k$$ using $$\hat{\eta}_{-k}$$ and average across all folds to get the final estimate.

This cross-fitting procedure prevents overfitting bias -- we never use the same data to both estimate nuisance parameters and evaluate our causal estimator. The result is a $$\sqrt{n}$$-consistent, asymptotically normal estimator for $$\tau$$ even when using highly flexible ML methods, as long as these methods achieve certain convergence rates.

The beauty of DML is that it gives us rigorous theoretical guarantees while still leveraging the full power of modern ML for modeling complex response surfaces and propensity scores.

# Generalized Random Forests and Honesty

In a typical supervised learning setting, Random Forest classifiers and regressors perform remarkably well with minimal required tuning. Each individual tree during the training process is grown to minimize the mean square error or net misclassification rates at the terminal leaf levels. While this works phenomenally well for the prediction task, our goals in causal inference are more heavily inclined towards estimation of heterogeneous treatment effects, which is an altogether different target. Athey and Wager's Generalized Random Forest model (GRF) provides an alternative optimization routine for growing trees more heavily inclined towards maximizing heterogeneity in treatment effects at each split.

The core idea is reframing tree-growing as a local moment estimation problem. For each potential split, we consider the treatment effect estimates we'd obtain in the resulting child nodes. The split criterion then aims to maximize the variance of treatment effects across children, effectively finding splits that separate high and low treatment effect regions.

At each node, we consider splitting on feature $$j$$ at threshold $$t$$. Let $$L$$ and $$R$$ denote the left and right children. The splitting criterion is:

$$
\Delta(j, t) = \frac{n_L n_R}{n_L + n_R} (\hat{\tau}_L - \hat{\tau}_R)^2
$$

where $$\hat{\tau}_L$$ and $$\hat{\tau}_R$$ are the estimated treatment effects in the left and right children, and $$n_L, n_R$$ are the sample sizes. This is essentially a weighted variance criterion that seeks to maximize treatment effect heterogeneity.

A critical idea here is the concept of _honesty_. As treatment effects are unmeasured, we face a fundamental challenge: if we use the same data to both choose our splits and estimate treatment effects within leaves, we'll overfit and introduce bias. The solution is sample splitting at the tree level.

For each honest tree:
1. Split the available training data into two disjoint sets: $$S_{split}$$ and $$S_{est}$$
2. Use $$S_{split}$$ to determine the tree structure (choosing splits via the $$\Delta$$ criterion)
3. Use $$S_{est}$$ to estimate treatment effects within each leaf

This separation ensures that the data used for estimation hasn't been "peeked at" during the tree-growing process, producing unbiased estimates of treatment effects in each leaf. When combined with the standard random forest aggregation procedure, honest GRFs provide consistent estimates of conditional average treatment effects $$\tau(x) = E[Y_i(1) - Y_i(0) \vert X_i = x]$$ with valid confidence intervals.


# Orthogonal Random Forests

Orthogonal Random Forests extend the GRF framework by incorporating ideas from the Double ML approach. The key insight is that we can improve efficiency and reduce bias by explicitly orthogonalizing with respect to nuisance parameters before growing our forest.

Rather than directly estimating $$\tau(x)$$ from $$(Y_i, W_i)$$, we first estimate and residualize out the main effects. For each observation, we compute:

$$
\begin{align*}
\tilde{Y}_i &= Y_i - \hat{m}(X_i) \\
\tilde{W}_i &= W_i - \hat{e}(X_i)
\end{align*}
$$

where $$\hat{m}(x) = E[Y_i \vert X_i = x]$$ is the unconditional response surface and $$\hat{e}(x) = P(W_i=1 \vert X_i=x)$$ is the propensity score. We then grow an honest random forest to estimate $$\tau(x)$$ using the residualized variables $$(\tilde{Y}_i, \tilde{W}_i)$$.

This orthogonalization has several benefits:
1. It removes confounding variation that might otherwise obscure treatment effect heterogeneity
2. It provides the same regularization bias protection as Double ML
3. It often results in tighter confidence intervals by reducing noise in the estimation process

The combination of honesty (for unbiasedness) and orthogonalization (for efficiency and debiasing) makes orthogonal random forests particularly powerful for heterogeneous treatment effect estimation in observational studies.

# Deep IV

Up to this point, we've assumed _unconfoundedness_ -- that all confounders are observed and included in $$X$$. In practice, this is a strong and often unrealistic assumption. Instrumental variables (IV) methods provide an alternative identification strategy when we have access to an instrument $$Z$$ that affects treatment $$W$$ but only affects outcome $$Y$$ through its effect on $$W$$.

Traditional IV methods (2SLS, GMM) work well in linear settings but struggle with complex, nonlinear relationships. Deep IV, developed by Hartford et al., leverages deep learning to handle flexible nonlinear IV problems.

The setup is simple: we observe $$(Z_i, X_i, W_i, Y_i)$$ where $$Z$$ is our instrument. The Deep IV approach uses a two-stage procedure. First, model the treatment mechanism $$W \vert Z, X$$ using a flexible neural network. Critically, rather than producing a point prediction, we model the full conditional distribution $$p(W \vert Z, X)$$, often using mixture density networks or similar flexible density estimators.

Next, estimate the outcome model $$h(W, X)$$ by solving a minimax problem:

$$
\min_h \max_g E[(Y - h(W,X)) \cdot g(Z,X)]
$$

where $$g$$ is an adversarial network. The adversary $$g$$ tries to find violations of the IV moment condition, while $$h$$ tries to satisfy them.

The beauty of this approach is that it combines the identification power of instrumental variables with the flexibility of deep learning. The first stage captures complex treatment heterogeneity and selection, while the adversarial second stage ensures we're leveraging the IV exclusion restriction properly.

In practice, Deep IV can uncover treatment effects in settings where traditional methods fail -- think nonlinear price elasticity estimation, returns to education with complex selection, or treatment effect heterogeneity in the presence of unobserved confounding. The main limitation is that, like all IV methods, you need a valid instrument, and the approach requires substantial sample sizes to train the neural networks effectively.


# Conclusion

Causal inference methods are uniquely suitable for the real-world statistical applications we built at QuantCo. It's interesting studying both the theoretical foundations of these black box methods and contrasting with their efficacy in practice. Longer term, I'm interested in learning and comparing
methods from Pearl's causality frameworks, taking a much more structured, but computationally difficult, Bayes approach.

