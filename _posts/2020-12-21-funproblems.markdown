---
layout: post
title: "Fun Puzzles"
categories: math 
comments: true
published: true 
---

Here I present a trite collection of some of my favorite short (accesssible) probability or mathematical puzzles. Most of these are not particularly difficult, but rather have either non-intuitive results or very clever solutions.



### Random Walkers

You're standing along a street and a random stranger walks past. On expectation, how many people will have to walk past you in order for you to find someone taller?

### Optimal Probing

A fixed signal of unknown power $$p$$ is being transmitted. You are tasked with probing for this signal until it is found. If you probe at power $$x$$ then you pay a cost of $$x$$, and if $$x \geq p$$ you will observe the signal, otherwise you must continue probing. Find a deterministic algorithm which pays at most $$4p$$ (trivial), and then find a randomized algorithm with expected cost $$3p$$.



### N-Polygons

Consider an arbitrary $$N$$-Polygon in the plane and construct a new polygon by identifying vertices at the midpoints of the edges. Repeat this process iteratively. What is the limiting behavior of this process?


### Guessing Games 

#### Part 1

Two real numbers $$x,y$$ are sampled from unknown probability distributions with continuous support on $$\mathbb{R}$$ and written down in separate envelopes. A random envelope is opened and the value is revealed. Now, you are given the option to stick with the revealed value or instead go with the value hidden in the second envelope. Design a strategy to choose the larger of the two values with $$>\frac{1}{2}$$ probability. 

Hint: >! Think of strategies that work for known distributions and try to generalize


#### Part 2

Now, in addition, you are given the information that $$y = 2x$$. Does the strategy from Part 1 still apply? How do you reconcile the paradox of always wanting to swtich?


### Popularity

You belong to a social media site that enables you to connect with your friends. On expectation, do you have more friends than your friends on average do?


## Conclusion

I will try and update this post as I discover and remember similar kinds of puzzles. Hope everyone finds these as enjoyable as I do!
