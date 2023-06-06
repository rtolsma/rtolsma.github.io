---
layout: post
title: "Modelling Counterfactual Impact"
categories: thoughts
comments: true
published: true 
---

You're a bright young kid striving to change the world. As a pure bred rationalist, you of course seek to maximize your counterfactual altruistic impact, but in practice, what does that mean?

I'll attempt to convince you, based on a simplified mathematical model, that seeking counterfactual impact implies prioritizing fields which have opportunities for heavy-tailed contributions regardless of the talent distribution.


# Being Average

Let's start with a simple model of the world. For a given altruistic field $$F$$ (e.x medicine), assume talent is distributed from some underlying distribution $$\mathcal{D}$$, and that $$F$$ is supplied constrained with a fixed number $$N$$ of contributors.

Let $$X_1, \ldots, X_N \stackrel{\text{i.i.d}}{\sim} \mathcal{D}$$ represent the impact of the $$N$$ contributors to $$F$$, and being humble for now, we assume that in expectation we're identical to everyone else throwing their hat in the ring, letting $$X_{N+1}\sim \mathcal{D}$$ represent our own impact. What is the counterfactual impact in this scenario?


Well, taking the difference between the worlds where you do and don't contribute, we see that the counterfactual impact $$I$$ is expressed as:

$$
\begin{align*}
I &= \mathbb{E}[ \sum_{i=1}^{N+1} X_i - \min(X_1, \ldots, X_{N+1}) ] - \mathbb{E}[ \sum_{i=1}^{N} X_i ] \\
&= \mathbb{E}[ X_{N+1} - \min(X_1, \ldots, X_{N+1}) ]
\end{align*}
$$


When is this value large? 

Well, if the distribution $$\mathcal{D}$$ has a heavy left tail, then the difference between the average and minimum values will be large, and so the counterfactual impact will be large. But, generally speaking, impact is a non-negative quantity, so the counterfactual impact here is upper bounded by $$\mathbb{E}[X_{N+1}]$$, which naively represents a maximum relative change of $$\frac{1}{N}$$ percent to the field! 

For any significantly sized field, this implies that your _relative_ counterfactual impact is negligible if you don't expect to significantly outperform the average. For many, relative impact is also a proxy for how much pride and value you can derive from your work, so this is a fairly pretty depressing result when the peer group is $$F$$ itself.

# Being the Best

Well now, of course no self-respecting ambitious altruist aims to achieve _just_ an average impact. So, let's graciously assume that we're the top of the top, best of the pack, and implicitly condition on $$X_{N+1} = \max(X_1,\ldots, X_{N+1})$$. What does this imply for our counterfactual impact?

Again, taking the difference between the worlds where we do and don't contribute we find:

$$
\begin{align*}
I &= \mathbb{E}[ \sum_{i=1}^{N+1} X_i - \min(X_1, \ldots, X_{N+1}) ] - \mathbb{E}[ \sum_{i=1}^{N} X_i ] \\
&= \mathbb{E}[ \sum_{i=1}^{N+1} X_i - \min(X_1, \ldots, X_{N+1}) ] - \mathbb{E}[\sum_{i=1}^{N+1} X_i - \max(X_1,\ldots, X_{N+1})] \\
&= \mathbb{E}[ \max(X_1,\ldots, X_{N+1})  - \min(X_1,\ldots, X_{N+1})] \\
&\leq \mathbb{E}[\max(X_1, \ldots, X_{N+1})] \quad \text{since  } X_i \geq 0
\end{align*}
$$


As expected, our counterfactual impact in this scenario is strictly greater now that we're the best. Intuitively, distributions for which this maximum can be large relative to average is what we're looking for -- effectively, heavy right-tailed distributions. Here, we easily see that the relative impact is now instead given by 

$$\begin{align*}\frac{\mathbb{E}[\max(X_1, \ldots, X_{N+1})]}{N \mathbb{E}[X_i]}\end{align*}$$

Interestingly, for distributions in which 

$$
\begin{align*}
\lim_{N\to \infty} \max(X_1, \ldots, X_{N+1}) - \max(X_1, \ldots, X_N) > \mathbb{E}[X_i]
\end{align*}
$$

we see that it's actually better to choose fields with _larger_ $$N$$, where our assumption of being the best is stronger and utilized with greater effect.


To help give some intuition, consider $$\mathcal{D}$$ explicitly as the Pareto Distribution[^1], which is widely used for modelling talent and real world output distributions, with parameter $$\alpha$$. For $$\alpha > 1$$ (required for finite mean), a quick lookup indicates that $$\mathbb{E}[X_i] \sim \mathcal{D}_\alpha = \frac{\alpha}{\alpha-1}$$ and the CDF and inverse CDF are given by


$$
\begin{align*}
F(x) &= 1 - \frac{1}{x^\alpha} \\

\implies F^{-1}(x) &= \frac{1}{(1-x)^\alpha} \quad \text{Convex on } [0,1]
\end{align*}
$$

Now since we can view $$X_1,\ldots,X_{N+1}\sim \mathcal{D}_\alpha$$ as first sampling uniformly in _percentile_ space, and then applying the inverse CDF $$F^{-1}$$, this gives us a very simple route to determining the counterfactual impact for a given $$N$$ and $$\alpha$$. From properties of the uniform distribution, we know that $$\mathbb{E}[\max(F(X_1),\ldots, F(X_{N}))] = 1 - \frac{1}{N}$$, and so applying some harmless trickery (to avoid real math), we see that

$$
\begin{align*}
I &= \mathbb{E}[ \max(X_1, \ldots, X_{N+1}) - \min(X_1,\ldots, X_{N+1})] \\
&= \mathbb{E}[ \max(F^{-1}(F(X_1)),\ldots, F^{-1}(F(X_{N+1}))) - \min( F^{-1}(F(X_1)),\ldots, F^{-1}(F(X_{N+1})))] \\
&= \mathbb{E}[ F^{-1}(\max(F(X_1)),\ldots, F(X_{N+1})) - F^{-1}(\min( F(X_1),\ldots, F(X_{N+1})))] \\
&\geq F^{-1}(\mathbb{E}[ \max(F(X_1)),\ldots, F(X_{N+1})])- F^{-1}(\mathbb{E}[\min( F(X_1),\ldots, F(X_{N+1}))]) \quad \text{ by Jensen's} \\
&= F^{-1}(1 - \frac{1}{N+1}) - F^{-1}(1 - \frac{1}{N}) \\
&= (N+1)^\alpha - N^\alpha \\
&> \alpha N
\end{align*}
$$


Surprisingly, even for the Pareto Distribution we see that for $$ N \geq \frac{\alpha}{\alpha-1}$$ that it becomes _better_ for us to choose fields with larger $$N$$ in terms of relative impact! Notably, for most reasonable values of $$\alpha$$ this phase transition begins at surprisingly low values of $$N$$.


# Being the z-th Percentile

Now, sticking with the Pareto Distribution, let's consider a slightly more realistic scenario . Suppose that we're not the best, but instead the $$z$$-th percentile of the field, and we enter regardless of whether or not we're worse than everyone else. What does this imply for our counterfactual impact?

To start, note that this implies $$F(X_{N+1}) = z$$. Manipulating our previous result to use $$F^{-1}(z)$$ instead of $$\max(X_1,\ldots,X_{N+1})$$, it's easy to see that the counterfactual impact is now given by

$$
\begin{align*}
I &= F^{-1}(z) - \mathbb{E}[ \min(X_1,\ldots, X_{N})] \\
&\geq \frac{1}{(1-z)^\alpha} - F^{-1}(1-\frac{1}{N}) \\
&= \frac{1}{(1-z)^\alpha} - N^\alpha 
\end{align*}
$$

So in terms of $$N$$, the phase transition at which it becomes better to choose fields with larger $$N$$ for maximizing relative impact is specified by

$$
\begin{align*}
\frac{1}{(1-z)^\alpha} - N^\alpha  &> \frac{\alpha}{\alpha-1} \\
\implies z &> 1 - \left( \frac{1}{N^\alpha + \frac{\alpha}{\alpha - 1}} \right)^\frac{1}{\alpha} \\
&> 1 - \frac{1}{N} \quad \text{ for } \alpha > 1
\end{align*}
$$

which effectively equates to being the best in the field. This has the surprising conclusion, that unless you really are going to be the best at what you do, the relative impact of your work will be maximized in smaller, less competitive fields.



# Conclusion

These are pretty simplified models, but still further advance my intuition towards seeking tail upside opportunities (confirmation bias, possibly?) to maximize net impact, and pursuing less competitive, smaller contexts to maximize relative impact. Reality is, however, that most of the time, tail opportunities and performance aren't particularly accessible to most and aren't nearly as random as I'd like, and so these insights should be taken with a grain of salt. 

In the future, some simple extensions of this model to that would be fun to look into include: sampling $$K$$ people applying to join field $$F$$ and only choosing the top $$N$$, introducing multiple competitive fields to choose from, and adding uncertainty to your own performance estimates.


#### Footnotes
[^1]: [Pareto Distribution](https://en.wikipedia.org/wiki/Pareto_distribution)











