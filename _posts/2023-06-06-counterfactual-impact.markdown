---
layout: post
title: "Modelling Counterfactual Impact"
categories: thoughts
comments: true
published: true 
---

You're a bright young kid striving to change the world. As a pure bred rationalist, you of course seek to maximize our counterfactual altruistic impact, but in practice, what does that mean?

I'll attempt to convince you, based on a simplified mathematical model, that seeking counterfactual impact implies prioritizing fields which have opportunities for heavy-tailed contributions regardless of the talent distribution.


# Modelling Counterfactual Impact
{: .bigh}

Let's start with a simple model of the world. For a given altruistic field $$F$$ (e.x medicine), assume talent is distributed from some underlying distribution $$\mathcal{D}$$, and that $$F$$ is supplied constrained with a fixed number $$N$$ of contributors.

Let $$X_1, \ldots, X_N \stackrel{\text{i.i.d}}{\sim} \mathcal{D}$$ represent the impact of the $$N$$ contributors to $$F$$, and being humble for now, we assume that in expectation we're identical to everyone else throwing their hat in the ring, letting $$X_{N+1}\sim \mathcal{D}$$ represent our own impact. What is the counterfactual impact in this scenario?


Well, taking the difference between the worlds where do and don't contribute, we see that the impact is expressed as:

$$
\begin{align*}
I &= \mathbb{E}[ \sum_{i=1}^{N+1} X_i - \min(X_1, \ldots, X_{N+1}) ] - \mathbb{E}[ \sum_{i=1}^{N} X_i ] \\
&= \mathbb{E}[ X_{N+1} - \min(X_1, \ldots, X_{N+1}) ]
\end{align*}
$$


When is this value large? 

Well, if the distribution $$\mathcal{D}$$ has a heavy left tail, then the difference between the average and minimum values will be large, and so the counterfactual impact will be large. But, generally speaking, impact is a non-negative quantity, so the counterfactual impact here is upper bounded by $$\mathbb{E}[X_{N+1}]$$, which naively represents a maximum relative change of $$\frac{1}{N}$$ percent to the field! 

For any significantly sized field, this implies that your counterfactual impact is negligible if you don't expect to significantly outperform the average.

## Being the Best

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

\implies F^{-1}(x) &= \frac{1}{(1-x)^\alpha}
\end{align*}
$$

Now since we can view $$X_1,\ldots,X_{N+1}\sim \mathcal{D}_\alpha$$ as first sampling uniformly in _percentile_ space, and then applying the inverse CDF, this gives us a very simple route to determining the counterfactual impact for a given $$N$$ and $$\alpha$$. From properties of the uniform distribution, we know that $$F(\max(X_1,\ldots, X_{N})) = 1 - \frac{1}{N}$$, and so applying some harmless trickery (to avoid real math), we see that

$$
\begin{align*}
I &= \max(X_1,\ldots, X_{N+1}) - \min(X_1,\ldots, X_{N+1}) \\
&= F^{-1}(F(\max(X_1,\ldots, X_{N+1}))) - F^{-1}(F(\max(X_1,\ldots, X_N))) \\
&= F^{-1}(1 - \frac{1}{N+1}) - F^{-1}(1 - \frac{1}{N}) \\
&= (N+1)^\alpha - N^\alpha \\
&> \alpha N
\end{align*}
$$


Surprisingly, even for the Pareto Distribution we see that for $$ N \geq \frac{\alpha}{\alpha-1}$$ that it becomes _better_ for us to choose fields with larger $$N$$!



# Conclusion

These are pretty simplified models, but still further advance my intuition towards seeking tail upside opportunities (confirmation bias, possibly?). Reality is, however, that most of the time, tail events aren't particularly accessible to any given individual. Realistic extensions would probably include modelling one's self at the $$z$$-th percentile instead of at _the_ max, or sampling $$K$$ people applying to join field $$F$$ and only choosing the top $$N$$ -- both of which likely further compress the relative impact bounds.


#### Footnotes
[^1]: [Pareto Distribution](https://en.wikipedia.org/wiki/Pareto_distribution)











