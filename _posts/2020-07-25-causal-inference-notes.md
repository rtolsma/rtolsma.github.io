---
layout: "post"
title: "Notes on Causal Inference"
categories: "statistics"
published: false
---


Over the course of this summer and as a part of my experience interning with [QuantCo](quantco.com), I've become rather interested in principled statistical modelling and in particular, causal inference. Here, I plan on maintaing and updating some technical notes for personal use as I continue to read through Susan Athey's course materials for Stanford's ECON293. 




# Basics: Potential Outcomes Framework, ATE, and Unconfoundedness

In the potential outcomes framework one observes a tuple $$(X_i, Y_i, W_i)$$ of feature, 
response, and treatment indicator variables such that $$Y_i = Y_i(W_i)$$. Causal effects
of a treatment are defined by the change in response variables $$Y_i(1) - Y_i(0)$$, and our typical goal is to estimate this average treatment effect (ATE) $$\tau = E[Y_i(1)-Y_i(0)]$$.


Typically, we don't observe both potential outcomes, so we estimate $$\tau$$ using averages
across the treated and controlled cohorts: i.e $$\hat{\tau} = \frac{\sum_{i:W_i=1}Y_i}{\vert \{i: W_i=1\}} -  \frac{\sum_{i:W_i=0}Y_i}{\vert \{i: W_i=0\}}$$. This is an extremely simple estimator, and satisifes certain desirable properties -- it is unbiased, consistent, asymptotically Gaussian, and efficient to calculate. However, one can achieve lower variance
by further conditioning on the covariates i.e $$\tau = E[Y_i(1) - Y_i(0) \vert X_i]$$ and using any standard out-of-box ML predictor optimized on minimizing L2 norm errors.


In small samples, hidden features with causal relations to the response variables may exaggerate or diminish the apparent treatment effects. To mitigate this, the traditional approach is to apply stratified sampling. However, simpler approaches need only rely on the existence of good estimators. For simplicity, let us define the conditional response surface as $$\mu_{(w)}(x) = E[Y_i \vert X_i=x, W_i=w]$$, in which case an oracle with access to the response surfaces could directly estimate $$\tau$$ via $$\overline{\tau} = \frac{1}{n}\sum_{i=1}^n (\mu_{(1)}(X_i) - \mu_{(0)}(X_i))$$. This motivates the naive approach: using standard ML methods, construct estimators $$\hat{\mu_{(0)}}, \hat{\mu_{(1)}}$$ and estimate the ATE as $$\hat{\tau} = \frac{1}{n}\sum_{i=1}^n (\hat{\mu_{(1)}}(X_i) - \hat{\mu_{(0)}(X_i)})$$. If these estimators are consistent (i.e converge in L2 norm to the true response surfaces), then the naive approach is asymptotically optimal.


The rest of this post is dedicated to various methods that improve upon this fundamental approach we have developed, aiming to improve performance in terms of efficiency and robustness across multiple domains.


# Doubly Robust Estimators: AIPW


# Double ML

# Generalized Random Forests and Honesty

In a typical supervised learning setting, Random Forest classifiers and regressors perform remarkably well with minimal required tuning. Each indivdual tree during the training process is grown to minimize the mean square error or net misclassification rates at the terminal leaf levels. While this works phenomenally well for the prediction task, our goals in causal inference are more heavily inclined towards estimation of heterogenous treatment effects, which is an altogether different target. Athey's Generalized Random Forest model (GRF) (TODO cite athey) provides an alternative optimization routine for growing trees more heavily inclined towards maximizing heterogeneity in treatment effects at each split. 

TODO MATH OF GRF (delta criterion, gradient approximations)

As treatment effects are unmeasured, Athey proposes growing her GRFs with half of the available data and estimating the actual treatment effects using the remainder. This data splitting mechanism produces the so called Honest Causal Tree which produces unbiased treatment effect estimations.


# Orthogonal Random Forests

# Deep IV









