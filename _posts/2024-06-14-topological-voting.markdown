---
layout: post
title: "Topological Problems in Voting"
categories: thoughts
tags: [math]
comments: true
published: true
---

Back in college, I developed an interest in unexpected impossibility proofs applied to real world systems. The fact that certain abstract mathematical structures inherently have limitations which profoundly impact actual applications is both captivating and sobering. Here's a cute instance of topological properties applied to voting systems a friend shared with me through [this video](https://youtu.be/v5ev-RAg7Xs?si=X1LY6Qc_s-HDqI3S) (we'll take a slightly different approach).

## Background: Arrow's Theorem

Arrow's Theorem[^1] is the most famous impossibility theorem applied to voting systems -- lots of articles and papers have spent time introducing and discussing its implications. In essence, Arrow's Theorem states that a voting process which ranks candidates in an absolute total order cannot simultaneously satisfy:

1. Non-Dictatorship - no single voter dominates the output preferences

2. Pareto Efficiency - if all voters rank candidate A over B, then the resulting rankings support $$A \succcurlyeq B$$

3. Independence of Irrelevant Alternatives - if $$A \succcurlyeq B$$ and a new candidate C is introduced, then the new ranking still requires $$A \succcurlyeq B$$

While this applies to discrete rankings and voter preferences, one might wonder if it's a unique property of its discrete nature in how candidates are only ranked by ordering. Instead of discrete rankings, could a continuous preference ranking satisfy similar conditions? Unfortunately, a similarly flavored impossibility result holds even in the continuous setting! It seems there's no getting around the fact that voting is pretty hard to get right.

## Chichilnisky Impossibility Theorem

The Chichilnisky Theorem [^2] extends Arrow's Theorem to the continuous setting, but with slightly different constraints.

Suppose that you have a set of $$K$$ voters choosing between $$N$$ candidates. Considering only relative preferences, we can represent the preference profile of each voter over the candidates $$p_k \in S^{n-1}$$ as a unit vector on the sphere, with each coordinate $$(p_k)_i$$ representing the allotted relative preference for candidate $$i$$. Denoting $$P = S^{n-1}$$ as our preference space, then our voting function $$\phi$$ becomes a map $$\phi: P^K \to P$$ taking some set of preferences $$\phi(p_1,\ldots, p_K) \to u$$ to a resulting unit vector preference profile.

The Chichilnisky Theorem states the following cannot be jointly satisfied:

1. $$\phi$$ is smooth [^3] - small changes in voter preferences should result in small changes to $$u$$

2. $$\phi$$ respects anonymity - e.g $$\phi(p_1, \ldots, p_K) = \phi(p_{\sigma(1)}, \ldots, p_{\sigma(K)})$$

3. $$\phi$$ respects unanimity -  if $$p_1 = \cdots = p_K= u$$ then $$\phi(p_1,\ldots,p_K) = u$$

### Topological Proof

We'll prove the simplest case of two voters and two candidates, which can be naturally generalized. In this scenario our preference space $$P = S^1$$ forms a unit circle and $$\phi: S^1\times S^1 \to S^1$$ maps the torus to a circle. The high level idea, is to form two different paths along the torus that have different degrees modulo 2 under $$\phi$$ and show that these paths can actually map onto one another forming a contradiction.

For the first path, consider the diagonal $$D = \left \{ (\alpha, \alpha) : \alpha \in S^1 \right\}$$ which visually loops around the torus at an angle, such that it rotates along the inner and outer loops exactly once by the time it closes. If we restrict $$\phi \vert_D$$, then by the unanimity condition we know that $$\phi\vert_D(\alpha,\alpha)=\alpha$$ is one-to-one which satisfies $$\deg \phi\vert_D = 1$$.

For our second path, let's take $$A = \{\alpha\} \cup S^1$$ and its symmetric counterpart $$B = S^1 \cup \{\alpha\}$$ for some $$\alpha\in S^1$$ which form an orthogonal figure-eight, with $$A,B$$ representing circles rotating directly on the outer and inner loop respectively. If we look at the restriction $$\phi \vert_{A\cup B}$$, then again by symmetry, we see that $$\deg \phi \vert_{A\cup B} = 0\ \text{mod}\ 2$$ at any regular value by pairing points in the preimage from both components of the figure-eight. Clearly $$A$$ and $$B$$ intersect at just the one point $$(\alpha,\alpha)\in D$$ non-smoothly but otherwise form a connected path. So if we take a small $$\epsilon$$ sized smooth deformation at $$D\cap (A\cup B)$$ to shift away from the intersection at $$(\alpha,\alpha)$$ to form a non self-intersecting loop $$L$$, then $$\deg \phi \vert_L = 0 \ \text{mod}\ 2$$ at all of its regular points as well.

Finally, we can find a homotopy to smoothly deform $$L$$ into $$D$$ (they're both just loops now) which produces a contradiction as $$\deg \phi\vert_D \neq \deg\phi\vert_L$$!

This notion of taking the diagonal and paths in $$P^K$$ naturally generalizes when you look at degree mod 2. Here, we had to rely on smoothness for our path homotopy invariants to apply, but some heavy machinery homological approaches also extend this result to continuous settings.

#### Footnotes

[^1]: [Arrow's Theorem](https://en.wikipedia.org/wiki/Arrow%27s_impossibility_theorem)

[^2]: [Chichilnisky Theorem](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=1367741)

[^3]: Only continuity is actually required, but you can approximate the continuous map arbitrarily closely with a smooth one, and this simplifies the proof
