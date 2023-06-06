---
layout: post
title:  "Physics: Topological Fun Facts"
categories: physics
comments: true
published: true 
---


Within my broad interests in mathematics, topology is near and dear to my heart due to its enthralling intuitive nature and it endows an equally captivating aesthetic on the various fields it influences. Below, are two fun facts I appreciated from my sophomore Stanford Quantum courses (230, 330).

### Mathematical Prelude

Our first fun fact belongs to the category of Electricity and Magnetism, a subject in which topology is ubiquitious. The hallmark of classical E&M, Maxwell's equations, which in standard vector calculus notation are given as 

$$
\begin{align*}
\nabla\cdot E = \frac{\rho}{\epsilon_0} \quad \nabla\cdot B = 0 \quad \nabla\times E = -\frac{\partial B}{\partial t} \quad \nabla\times B = \mu_0\left(J + \epsilon_0\frac{\partial E}{\partial t}\right)
\end{align*}
$$


 actually possess a very fundamental connection and expression within the language of [differential forms](https://en.wikipedia.org/wiki/Differential_form). For those unfamiliar, differential forms are effectively the natural generalization of your standard derivatives to those that work on generic smooth manifolds, and form the basic building blocks of differential geometry. While the theory of differential forms is rather deep, for the purposes of this article, it's at most useful to know that the these forms, when utilized on a given manifold, exhibit some nice structures that directly convey information about the topological structure of the manifold[^1].

## Mobius Resistors

In an introductory E&M class, you learn that along a boundary of a surface with positive current flow, an induced magentic flux perpendicular to the loop will appear. This known as Faraday's Law, and within Maxwell's equations appears in the form of 

$$
\begin{align*}
\int_{\partial \Omega} E\cdot dl = -\frac{\partial}{\partial t}\int_\Omega B\cdot dA
\end{align*}
$$

where the left hand side represents our integral around the boundary of our surface (forming the circuit), and the right hand represents the time varying magnetic flux through the space enclosed. This makes a lot of sense if your surface is easy to assign directions to, like a closed copper circuit loop.

Now, taking $$\Omega$$ to be something a little more tricky like the Mobius Strip, we immediately run into an issue: the Mobius Strip is a non-orientable manifold, so how can we possible define a direction to integrate over on the right hand side? As a fun experiment, try taking a piece of paper and attaching opposite edges by applying a twist, and point upwards through the hole inside. If you can tell, as you trace along the boundary of your Mobius Strip, the relative directions of your upwards finger and the path you trace will change. It becomes clear now, that no matter what direction a magnetic field might be, there can be no net flux through the Mobius Strip! Thus, for an ideal mobius strip, in order for Faraday's Law to hold true, there can be no net current flow ever! This is a pretty remarkably valuable result, and is definitely one of the slickest topological tricks I've seen in physics. It turns out mathematically, this can be justified by more differential form theory, with which one can prove that integration is only defined on orientable manifolds.


## 2. Universal Rotational Symmetry

Some of the coolest results in quantum mechanics are from improving our understanding of the fundamental symmetries we find in our universe. One completely surprising discovery (for myself!), is that our world is not actually $$2\pi$$ symmetric. 

Fundamentally, when we zoom in at the particle level, there are two forms of angular momentum: standard angular momentum, and spin angular momentum. A rather famous result in quantum mechanics proves two particulary interesting properties of spin momentum: 


1. The values of spin are discrete taking on non-negative integer and half-integer values i.e $$0, \frac{1}{2}, 1, \frac{3}{2},\ldots$$

2. Particles with integral spin known as bosons have symmetric wavefunctions, while particles with half-integer spins are known as fermions and maintain antisymmetric wavefunctions under parity. 



Now, for the fun part, we want to understand how particles are affected when we rotate space. From classical mechanics, we know that standard angular momentum transforms under a rotation by simply rotating its own axis along with the rest of the transformation, so when we spin space around by $$2\pi$$, the momentum remains unchanged. However, in the case of a Fermion, as a consequence of its antisymmetric properties, the wavefunction actually incurs a negative sign after a $$2\pi$$ rotation. Therefore, we _actually_ need a $$4\pi$$ degree rotation in order for both forms of momentum to remain invariant! This is really non-intuitive result, our world is not $$2\pi$$ symmetric! Why do we not see these changes in our everyday life? It turns out, that the scale of the energies at which spin interacts is on the order of $$\hbar$$, which is extremely small in comparison to typical forces we see in our daily lives.


### Topological Explanation

The real reason these things happen has to do with the different symmetry groups representing bosons and fermions.

Recall that every 3D rotation of space can be described by a $$3\times 3$$ orthogonal matrix with positive determinant. In mathematics, we usually denote these sets of matrices by the term $$SO(3)$$ (the special orthogonal 3D matrices). However, we can also visualize each rotation as being given by its oriented axis of rotation which in turn (by just visualizing where the arrow reaches) can be identified with a point on a sphere. Hence, $$SO(3)$$ is a just a sphere! It turns out, using the physical intuition described previously, angular momentum operators can be exactly represented under the symmetries of $$SO(3)$$. Using some detailed expansions, one finds that the operators for angular spin are actually given by the symmetries of $$SU(2)$$ (the special unitary matrices in 2D), which is a double cover of the sphere (think of wrapping paper around a sphere twice). Thus, a $$2\pi$$ rotation in $$SU(2)$$ corresponds to traversing the first cover, and thus $$4\pi$$ is required to loop around both covers to reach the starting point. Similar interesting symmetries arise when examining other particles in QFT from examining their respective Lie group representations.


#### Footnotes

[^1] For the inclined, see [De Rham Cohomology](https://en.wikipedia.org/wiki/De_Rham_cohomology)