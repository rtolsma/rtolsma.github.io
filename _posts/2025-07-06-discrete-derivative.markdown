---
layout: post
title: "Fun Derivative Eigenfunctions"
categories: thoughts
comments: true
published: true 
---

I came across [this article](https://thenumb.at/Functions-are-Vectors/) today on top of Hackernews which reminded me of some quant interview questions requiring some clever discrete derivative matrix tricks. I realized after reading the article, that you can construct a new clever proof that $$\frac{d}{dx} \phi(x) = a\phi(x) \iff \phi(x) = e^{ax}$$ in the discrete perspective.

The article takes a different basis approach, representing functions as vectors of polynomial coefficients, which simplifies the picture. However, with a cute reframing you can generalize this to the standard positional basis, where functions are infinite-dimensional vectors with coordinates representing evaluations $$f_n = f(x_n), x_n \in \mathbb{R}$$.


To start, consider a circular permutation matrix of dimension $$N$$:

$$P_N = \begin{pmatrix} 
0 & 1 & 0 & 0 & \cdots & 0 \\
0 & 0 & 1 & 0 & \cdots & 0 \\
0 & 0 & 0 & 1 & \cdots & 0 \\
\vdots & \vdots & \vdots & \vdots & \ddots & \vdots \\
0 & 0 & 0 & 0 & \cdots & 1 \\
1 & 0 & 0 & 0 & \cdots & 0
\end{pmatrix}$$

As a permutation matrix of size $$N$$, the eigenvalues are the $$N$$ roots of unity $$\varphi_a$$ and the eigenvectors from the single permutation cycle are represented by the $$N$$ periodic Fourier Modes $$v_a = \frac{1}{N}\left(1, \omega^a, \omega^{2a}, \ldots, \omega^{(N-1)a} \right)$$ where $$\omega = \exp\left(\frac{2\pi i}{N}\right)$$. 


Now, let's view the derivative as an infinite dimensional operator 


$$\begin{align*} A  = \frac{d}{dx} = \frac{1}{\epsilon}\begin{pmatrix} 
1 & -1 & 0 & 0 & \cdots \\
0 & 1 & -1 & 0 & \cdots \\
0 & 0 & 1 & -1 & \cdots \\
0 & 0 & 0 & 1 & \cdots \\
\vdots & \vdots & \vdots & \vdots & \ddots
\end{pmatrix} \end{align*}$$


where, in the linearized view, "rows" correspond to discrete evaluations of a functional at a point, spaced $$\epsilon$$ apart as we take $$\lim \epsilon \to 0$$.


Next, note that we can decompose $$A$$ into the following:

$$
\begin{align*}
A =  \lim_{\epsilon\to 0}\frac{1}{\epsilon}\left(I - P_\infty \right)
\end{align*}
$$

where $$P_\infty$$ is the operator of all ones above the diagonal, and satisfies convergence in operator norm $$\lim_{N\to\infty}\|P_\infty - P_N\| = 0$$ to the permutation operator in $$\mathbb{L^2}$$.

Then, it becomes clear that the eigenvectors of $$A$$ are exactly the eigenvectors of $$P_\infty$$ which map exactly onto the Fourier Modes now continuously indexed by $$a$$, which directly corresponds to the eigenfunction basis $$e^{ax}$$.