---
layout: post
title: "Python: Single Forward Pass Gradients"
categories: thoughts
comments: true
published: true 
---

# Single Forward Pass Gradients

I learned this trick to compute gradients of a locally smooth function $$f: \mathbb{R} \to \mathbb{R}$$ a long time ago in a numerical physics class at Stanford. 
The primary insight being that you can analytically extend $$f$$ to the complex plane in a local region $$f:\mathbb{C}\to\mathbb{C}$$ and then noting that 

$$
\begin{align*}
f(x + ih) \approx f(x) + ih f'(x)
\end{align*}
$$

$$
\begin{align*}
\implies f'(x) \approx \frac{1}{h}\text{Im}[f(x+ih)]
\end{align*}
$$

For sufficiently small $$h$$, this shows a simple single $$f$$ evaluation can be utilized to obtain the derivative at a point. Conveniently, `numpy` and many other
numerical Python libraries support complex number types with overridden functionality, meaning this trick can often work without any requiring any additional
code changes. Unfortunately, it's not very numerically stable due to the dependence on $$\frac{1}{h}$$, but it's still neat nonetheless.



