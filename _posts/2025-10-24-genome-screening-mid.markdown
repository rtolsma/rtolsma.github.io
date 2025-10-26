---
layout: post
title: "IVF Selection is Mid"
categories: thoughts
tags: [thinky]
comments: true
published: true
---

IVF embryo selection is having a moment. Companies like Orchid Health are pitching parents on the promise of optimizing their future kids for IQ, height, disease resistance, and other desirable phenotypes with celebs and politicians (quietly) leaning in. The tech is real and improving, but the actual upside and long-term vision is limited by some pretty basic math.

The ceiling on selection power is ... low. There's fundamental constraints on what you can do with $$N$$ samples from a highly polygenic distribution.

### Selection Power Grows Logarithmically

In a typical egg harvest, you get maybe 10-15 viable embryos if you're lucky, rarely more than 50-100 even in aggressive scenarios.

With IVF selection effectively choosing the max of $$N$$ samples based on some objective function, and given our sample sizing that translates to just 3-7 bits of selection power.

But it gets worse when you account for how these traits actually work genetically. Height is controlled by thousands of genetic variants. IQ is even more polygenic. They're sums of thousands of small effects with few if any big hitters. We can model each embryo's genetic potential distribution $$X$$ for a polygenic trait as a sum of $$K$$ i.i.d variables contributing to the phenotype effect, which by the Central Limit Theorem implies $$X$$ can be modeled as a normal distribution. Depending on the polygeneity of the phenotype, the variance of $$X$$ can already be quite small across samples, as $$\sigma \sim O(\frac{1}{\sqrt{k}})$$.

The question then becomes, can we improve on $$E[X]$$? How much better can we do by selecting $$N$$ samples from $$X$$?


Rescaling $$X\sim N(0,1)$$, take $$X_1, X_2, \ldots, X_N \stackrel{\text{i.i.d}}{\sim} N(0,1)$$, we want to understand $$\mathbb{E}[Z]$$ where $$Z = \max(X_1, \ldots, X_N)$$.

To bound $$E[Z]$$ we can use the CDF:

$$
\begin{align*}
P(Z \leq z) &= P(X_1 \leq z, \ldots, X_N \leq z) \\
&= \Phi(z)^N
\end{align*}
$$

where $$\Phi$$ is the standard normal CDF. For the tail bound, note that for large $$z$$:

$$P(X_i > z) \approx \frac{1}{\sqrt{2\pi}z}e^{-z^2/2}$$

By union bound: $$P(Z > z) \leq N \cdot P(X_1 > z)$$. Setting $$z = \sqrt{2\log N}$$:

$$
\begin{align*}
P(Z > \sqrt{2\log N}) &\leq N \cdot \frac{1}{\sqrt{4\pi \log N}} e^{-\log N} \\
&= \frac{1}{\sqrt{4\pi \log N}} \to 0
\end{align*}
$$

Similarly, we can show concentration below this threshold is exponentially small, giving us that $$Z$$ concentrates around $$\sqrt{2\log N}$$ and therefore $$\mathbb{E}[Z] \approx \sqrt{2\log N}$$.

The math here is unforgiving. Selection power scales incredibly slowly as $$\sqrt{2\log N}$$, and you're at best getting a tiny constant factor improvement on $$\sigma$$ which is low from $$\frac{1}{\sqrt{K}}$$.

### Conclusion

Selection upside is fundamentally limited by information theory and biology. The traits you sample are highly concentrated due to polygenic effects and you can't improve on it by scaling sampling.

The technology right now shines at screening out rare genetic diseases, which are extremley sparsely distributed, requiring very few bits of selection power to remove.

For polygenic trait optimization -- smarter, taller, more athletic kids -- the ceiling is low and already here.