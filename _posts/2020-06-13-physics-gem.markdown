---
layout: "post"
title:  "Demistiyfing Schrodinger's Equation"
categories: physics
comments: true
---

Sometimes I find myself so enthralled by aesthetic theoretical machinery that I can't resist sharing. These types of posts are usually geared towards those with basic to advanced
undergraduate understandings of mathematics, and are moreso exposition than anything else. Here are two fun tidbits I'd like to share from Stanford's Graduate Quantum Mechanics class
I took last year under the amazing professor [Patrick Hayden](https://sitp.stanford.edu/people/patrick-hayden). Note, this will require some exposure to basic calculus and linear algebra
in order to follow along.


## Schrodinger's Equation

Quantum mechanics more than any other subject is distorted by popular media and science fiction claims imbuing this vague sense of mystery, and at the heart of all this is
Schrodinger's Equation. The derivation of this equation, however, could not be simpler, and it arises immediately from a couple [basic axioms](https://en.wikipedia.org/wiki/Dirac%E2%80%93von_Neumann_axioms#:~:text=In%20mathematical%20physics%2C%20the%20Dirac,John%20von%20Neumann%20in%201932.) we set in place when studying
quantum mechanics.



### Axiom 1: Hilbert Spaces

The first relevant axiom to our derivation, asserts that any state of our system should be represented by a unit vector in a [Hilbert Space](https://en.wikipedia.org/wiki/Hilbert_space). Hilbert
Spaces likely inlude most widely vector spaces, such as real vector spaces $$\mathbb{R}^n$$, complex vector space $$\mathbb{C}^n$$, finite fields $$F_p$$, and can extend to even infinite dimensional spaces as well. Mathematically, Hilbert Spaces correspond to complete inner product spaces. For our uses here, there are two important properties of this definition: for any two vectors $$x,y \in \mathbb{H}$$ in any Hilbert Space, there exists some inner product function  $$\langle x, y \rangle$$ to $$\mathbb{R}$$ that satisfies some certain properties -- notably linearity and conjugate symmetry; and likewise, for any vector $$z \in \mathbb{H}$$ we have that $$\vert z\vert^2 = \langle z, z \rangle < \infty$$, which is only really applied in the infinite dimensional case. Our states will correspond to vectors of
these Hilbert Spaces that satisfy $$\vert z \vert^2 = 1$$.

Due to the prevalent use of the inner product $$\langle \cdot ,\cdot \rangle$$ in quantum mechanics, a special notation called Dirac's Bra-ket notation is used make writings clearer. Under this notation,
we write $$\vert \varphi \rangle$$ (a Ket) to represent a vector $$\varphi \in \mathbb{H}$$, and we use $$\langle \psi \vert$$ (a Bra) to represent the complex transpose[^1] of $$\psi \in \mathbb{H}$$. The purpose of this notation is seen when writing Bra's and Ket's in conjunction: $$\langle \psi \vert$$ joined next to $$\vert \varphi \rangle$$ is instead joined together to read $$\langle \psi \vert \varphi \rangle$$ meaning to take the inner product function applied to both vectors.

### Axiom 2: Observables are Real


In quantum mechanics, we associate observable properties -- position, momentum, spin -- to operators that act on states on our Hilbert Space. In practice, we can view these operators as 
(sometimes infinite-dimensional) matrices acting as vectors as in standard linear algebra. Measurable values of these observables -- like a particle moving at 0.99c -- correspond to eigenvalues
of their corresponding operator. I won't go into any of the philosophy of _why_ we choose this framework, but I encourage the interested reader to engage in other (likely more well-versed) sources.
Since eigenvalues correspond to actual measurements, we want to ensure that these values are real and not complex. Enforcing matrices to only maintain real eigenvalues by the [Spectral Theorem]()
directly corresponds to a property called self-adjointness (also known as Hermitian): a self-adjoint/Hermitian matrix $$M$$ is required to satisfy $$M^\dagger = M$$ where $$M^\dagger$$ denotes the complex-conjugate transpose. So in brief, Axiom 2 just asserts that all operators need to be self-adjoint in order to have meaningful observations.


Note: The complex conjugate transpose relations between Bra's and Ket's also applies to operators. So for a state $$M\vert z \rangle$$ its norm would be given by $$\vert Mz\vert^2 = \langle Mz, Mz \rangle = \langle z \vert M^\dagger M \vert z \rangle $$.
### Setup and Derivation


If we consider a system that evolves over time, we can represent its state by some time-varying state vector $$\vert \varphi(t) \rangle $$. Since time-evolution is a continuous process, and operators are
self-adjoint, we can pose the evolution via an equation $$\vert \varphi(t) \rangle = U(t)\vert \varphi(0)\rangle$$ where $$U(t)$$ represents a time varying self-adjoint operator with $$U(0) = I$$ the identity matrix. Now, since our states must be unit norm, we see that 

$$\begin{align*} \vert \varphi(t)\vert^2 &= \langle \varphi(t)\vert \varphi(t) \rangle \\ &= \langle \varphi(0)\vert U^\dagger(t)U(t)\vert \varphi(0)\rangle \end{align*}$$ 

which implies that $$U^\dagger(t)U(t) = I$$ for all $$t$$ -- a property known as unitarity.

Now, we've derived an interesting property of how our state evolves according to $$U(t)$$, using a simple Taylor Expansion we can derive more information about this evolution: 

$$
\begin{align*} I &= U^\dagger(dt)U(dt) \\
&= (U(0) + U'(0)dt + O(dt^2))^\dagger (U(0) + U'(0) + O(dt^2)) \\
&= U(0)^\dagger U(0) + (U'(0) + U'\dagger(t))dt + O(dt^2) \quad \text{ since } U(0)=I \\
&= I + (U'(0) + U'^\dagger(0))dt + O(dt^2)
\end{align*}
$$

Subtracting $$I$$ from both sides, and noting that the $$O(dt^2)$$ term vanishes, we see that this implies $$U'(0) = - U'^\dagger(0)$$ which is a property known as being anti-Hermitian. For convenience, we can introduce a new operator $$H = i\hbar U'$$ (where $$\hbar$$ is a conventional unit scaling constant) which by the anti-Hermitian properties of $$U$$ makes $$H$$ self-adjoint. If we now
look at how our system's state changes in the infinitesimal we see that 

$$i\hbar(\vert \varphi(dt)\rangle  - \vert \varphi(0)\rangle) = Hdt \vert \varphi(0)\rangle$$

Dividing the $$dt$$ on both sides, and noting that the left-hand side resembles the definition of a derivative, we gracefully witness the form

$$i\hbar \frac{d}{dt}\vert \varphi(0) \rangle = H\vert \varphi(0)\rangle$$

Applying the exact same process more generally, we ultimately discover that

$$i\hbar \frac{d}{dt}\vert \varphi(t)\langle = H(t) \vert \varphi(t)\rangle $$ for $$H(t) = i\hbar U'(t)$$

Now this here is Schrodinger's complete equation in all its glory. A simple elegant formula describing how our reality continuously evolves.


### Time Independent Equation

A lot of people have probably heard of two versions of Schrodinger's: the time independent, and the time dependent. The exposition above focused on the time dependent, as the slightly more
interesting version in my opinion. The time independent Schrodinger equation is merely an eigenvalue-eigenvector equation: $$H\vert \varphi \rangle = E_n \vert \varphi \rangle$$. For reasons
better understood via a thorough treatment of classical mechanics, the operator $$H(t)$$ we referred to is the classical analog of the Hamiltonian matrix, whose eigenvalues correspond
to the possible energy levels of a system. The time independent Schrodinger's equation thus corresponds to finding the steady-state solutions of a system.

<br/><br/>

Please feel free to reach out to me at rtolsma@stanford.edu if you have any thoughts about these topics, I always enjoy learning from other knowledgeable perspectives.
Thanks for reading the post!



#### Footnotes

[^1]: This isn't technically exact, albeit it's functionally true. The correct terminology here is best phrased in the language of [duality theory](https://en.wikipedia.org/wiki/Dual_space). This has deeper implications into PDE solutions in Schrodinger's equation as duals in the form of tempered distributions instead of as a function.