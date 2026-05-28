---
layout: post
title: "Symmetry Representations and Fourier Transforms"
categories: thoughts
tags: [math]
comments: true
published: true
---

I've always found Fourier transforms to be one of those mathematical tools that is often taught in a way that feels more computational than conceptual. You learn that complicated functions can be decomposed into sums of sines and cosines, and then after enough exposure it becomes natural that heat equations, wave equations, signal processing, and harmonic functions all mysteriously want to be written in this basis. But there's a sharper way to cut through: Fourier analysis is what happens when you diagonalize translation symmetry.

The underlying object to look at is the translation operator. For a function $$f:\mathbb{R}\to \mathbb{C}$$, define

$$
T(a)f(x) = f(x-a)
$$

where $$a\in\mathbb{R}$$ represents the amount we shift our function. These operators form a Lie group under composition, since $$T(a)T(b)=T(a+b)$$ and $$T(0)=I$$. So before saying anything about Fourier transforms, we already have a continuous group acting on our function space. The natural representation-theoretic question is: what are the irreducible modes of this group action?

## The Generator of Translations

Since translations vary continuously with $$a$$, they should have an infinitesimal generator. Expanding around $$a=0$$, we get

$$
\begin{align*}
T(a)f(x) &= f(x-a) \\
&= f(x) - a\frac{d}{dx}f(x) + O(a^2)
\end{align*}
$$

which suggests that the translation operator can be written as

$$
T(a) = \exp\left(-a\frac{d}{dx}\right)
$$

so $$\frac{d}{dx}$$ is, up to sign convention, the generator of the translation group. Now that we have the generator, to understand how translations operate, it suffices to understand the eigenfunctions of $$\frac{d}{dx}$$. These are exactly (using the arbitrary factor of $$ik$$ instead of a different constant, because I like physics)

$$
\frac{d}{dx}e^{ikx} = ik e^{ikx}
$$

and therefore

$$
T(a)e^{ikx} = e^{-ika}e^{ikx}
$$

meaning each Fourier mode (with eigenvalue $$e^{-ika}$$) is an eigenfunction of every translation operator. Notably, you immediately derive through the eigendecomposition (since translations are an $$L^2$$ operator) that the Fourier modes are an orthogonal basis.

With this new basis, for a generic function $$f$$, the Fourier transform is just computing its coordinates in this diagonal basis:

$$
\hat{f}(k) = \int_{\mathbb{R}} f(x)e^{-ikx}dx
$$

with the inverse transform reconstructing the original function by summing over translation eigenmodes:

$$
f(x) = \frac{1}{2\pi}\int_{\mathbb{R}}\hat{f}(k)e^{ikx}dk
$$

## Commuting with Symmetry

The representation-theoretic payoff comes when we look at other operators that respect translation symmetry. Suppose $$L$$ is some linear operator acting on functions and it commutes with translations:

$$
\left[L, T(a)\right] = 0
$$

for every $$a$$. By the general philosophy behind Schur's lemma, an operator that commutes with a group action preserves the irreducible pieces of that representation. On each irreducible piece, it acts by a scalar; when multiple equivalent copies appear, it can only mix those degenerate copies. So once we've decomposed into translation eigenfunctions, $$L$$ acts by scalar multiplication on each mode, up to the usual degeneracies.

This is why translation-invariant operators are diagonalized by the Fourier basis. If $$L$$ commutes with all $$T(a)$$, and $$e^{ikx}$$ spans an irreducible translation mode, then $$L e^{ikx}$$ must transform under translations in the same way as $$e^{ikx}$$. So $$L e^{ikx}$$ is proportional to $$e^{ikx}$$:

$$
L e^{ikx} = \lambda(k)e^{ikx}
$$

This principle more broadly applies to any form of operator symmetry. The irreducible representations form subspaces over which we can cleanly diagonalize and understand the operator's behavior over. For example, in quantum mechanics, you frequently utilize the symmetries of the system to decompose the Hamiltonian over the corresponding irreducible representations, which lets us more tangibly understand dynamics within those subspaces.

### Example: Harmonics Want Fourier Modes

We can apply these insights to the Laplacian, an operator that's frequently found in common PDEs:

$$
\nabla^2 = \sum_i \frac{\partial^2}{\partial x_i^2}
$$

which commutes with translations in Euclidean space. Shifting a function and then taking its second derivatives gives the same result as taking its second derivatives and then shifting. So by the symmetry argument above, the Laplacian must be diagonal in the translation eigenbasis.

Indeed, for plane waves $$e^{ik\cdot x}$$, we have

$$
\nabla^2 e^{ik\cdot x} = -\vert k\vert^2 e^{ik\cdot x}
$$

which is exactly the diagonalization. In Fourier space, differential equations involving the Laplacian become algebraic equations involving $$-\vert k\vert^2$$. This is why harmonic analysis, PDEs, and Fourier transforms are so tightly bound together. The method works because the operator and the geometry share the same symmetry.
