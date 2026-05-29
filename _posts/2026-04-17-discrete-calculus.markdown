---
layout: post
title: "Fun Discrete Calculus Tricks"
categories: thoughts
tags: [math]
comments: true
published: true
---

I'm not sure why, but high school calculus traditionally jumps straight into the continuous setting completely ignoring the fact that most of the computational methods have clear discrete analogues.

### Discrete Derivatives and Integrals

For discrete functions $$f: \mathbb{Z} \to \mathbb{R}$$ the derivative is pointwise defined as

$$
\Delta f(x) = f(x) - f(x-1)
$$

Like $$\frac{d}{dx}$$ the $$\Delta$$ is linear, $$\Delta(af + bg) = a\,\Delta f + b\,\Delta g$$, and kills constants, $$\Delta c = 0$$. 


Looking at monomials, we  see that
$$
\Delta x^n = x^n - (x-1)^n
$$

expands out into an ugly sum of terms through binomial expansion. This isn't that nice to work with, and so instead we can look at a better set of monomials that behave more like the continuous versions. These are the rising factorials:

$$
x^{\overline{n}} = x(x+1)(x+2)\cdots(x+n-1) \quad (n \text{ factors})
$$

which when we apply $$\Delta$$ we get

$$
\Delta x^{\overline{n}} = x^{\overline{n}} - (x-1)^{\overline{n}} = \big[x(x+1)\cdots(x+n-2)\big]\big[(x+n-1) - (x-1)\big] = n\, x^{\overline{n-1}}
$$

just like with $$\frac{d}{dx}$$. There's a product rule too, with one discrete wrinkle, just requiring a shift on the second factor: $$\Delta(uv) = v\,\Delta u + u(x{-}1)\,\Delta v$$. Summing both sides gives summation by parts, the analogue of integration by parts: $$\sum_{x=a}^{b} v\,\Delta u = uv\big\rvert_{a-1}^{b} - \sum_{x=a}^{b} u(x{-}1)\,\Delta v$$, which resolves terms like $$\sum x\,2^x$$ exactly the way $$\int x e^x\,dx$$ yields to parts.

The chain rule is the one place the analogy breaks: $$\Delta f(g(x)) = f(g(x)) - f(g(x-1))$$ won't factor unless $$g$$ is affine (e.g shifting $$g(x) = x+c$$ just reindexes, $$\Delta g(x+c) = (\Delta g)(x+c)$$) since differences care about integer steps and most $$g$$ don't preserve them.

### Integration Is Just Summation

Suppose we want $$\sum_{x=a}^{b} g(x)$$. The trick is to find an _antidifference_, a function $$F$$ with $$\Delta F = g$$, just as we'd hunt for an antiderivative. The sum telescopes:

$$
\sum_{x=a}^{b} \Delta F(x) = \sum_{x=a}^{b} \big[F(x) - F(x-1)\big] = F(b) - F(a-1)
$$

Every interior term is added once and subtracted once; only the ends survive, an analogue of the fundamental theorem of discrete calculus:

$$
\sum_{x=a}^{b} g(x) = F(b) - F(a-1), \qquad \text{where } \Delta F = g
$$

And we already have the antidifference of a rising factorial. Reading the power rule backwards:

$$
\Delta\!\left(\frac{x^{\overline{n+1}}}{n+1}\right) = x^{\overline{n}}
$$

which is the discrete twin of $$\int x^n\,dx = \frac{x^{n+1}}{n+1}$$.

#### Quick Applications

Once you have the power rule and the fundamental theorem, a surprising amount falls out with no cleverness required.

**Power sums.** For $$\sum_{x=1}^N x$$ we have $$g(x) = x = x^{\overline{1}}$$, so the antidifference is $$x^{\overline{2}}/2 = x(x+1)/2$$ and

$$
\sum_{x=1}^{N} x = \frac{x(x+1)}{2}\Big|_{x=0}^{N} = \frac{N(N+1)}{2}
$$

For higher powers, we just rewrite the monomial in the rising-factorial basis. e.g. for $$k=2$$ we get $$x^{\overline{2}} = x^2 + x$$, and $$x^2 = x^{\overline{2}} - x^{\overline{1}}$$, and antidifferencing each piece gives

$$
\sum_{x=1}^{N} x^2 = \left(\frac{x^{\overline{3}}}{3} - \frac{x^{\overline{2}}}{2}\right)\Bigg|_{x=0}^{N} = \frac{N(N+1)(N+2)}{3} - \frac{N(N+1)}{2} = \frac{N(N+1)(2N+1)}{6}
$$

The same recipe handles $$\sum x^k$$ for any $$k$$: expand $$x^k$$ in rising factorials (the coefficients turn out to be the Stirling numbers) and integrate term by term.

**Geometric series.** In ordinary calculus the exponential is special because it's nearly its own derivative; the same is true here. For a constant $$c$$, $$\Delta c^x = c^x - c^{x-1} = c^x\!\left(\frac{c-1}{c}\right)$$, so $$c^x$$ is its own difference up to a constant, with antidifference $$c^{x+1}/(c-1)$$. The fundamental theorem then hands you the geometric series for free:

$$
\sum_{x=1}^{N} c^x = \frac{c^{x+1}}{c-1}\Bigg|_{x=0}^{N} = \frac{c^{N+1} - c}{c-1} = \frac{c\,(c^N - 1)}{c-1}
$$

**Recurrences, and solving Fibonacci.**  Recurrence formulas are the discrete analogues of ODEs:
$$
\Delta a_n = g(n) \quad\Longleftrightarrow\quad a_n = a_{n-1} + g(n),
$$

To solve a constant-coefficient ODE in school you're taught to guess $$e^{\lambda x}$$ and solve a characteristic polynomial; since $$c^x$$ is the discrete exponential, the discrete move is to guess $$a_n = r^n$$. Take Fibonacci, $$F_n = F_{n-1} + F_{n-2}$$. Substituting $$r^n$$ and dividing by $$r^{n-2}$$ leaves the characteristic equation

$$
r^2 = r + 1 \quad\Longrightarrow\quad r = \frac{1 \pm \sqrt{5}}{2},
$$

the golden ratio $$\varphi$$ and its conjugate $$\psi$$. The general solution is $$F_n = A\varphi^n + B\psi^n$$, and the initial conditions $$F_0 = 0$$, $$F_1 = 1$$ pin down $$A = -B = 1/\sqrt{5}$$ to give Binet's formula

$$
F_n = \frac{\varphi^n - \psi^n}{\sqrt{5}}
$$

