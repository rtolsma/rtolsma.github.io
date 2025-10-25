---
layout: post
title: "Modelling Breadth vs. Depth"
categories: thoughts
tags: [thinky]
comments: true
published: false
---

# TODO TODO THIS INTRO SOUNDS BAD
It's been a while since my last post, and so I thought it might be fun to try exploring a question that's been on my mind a lot since graduation: the classic career breadth vs. depth tradeoff. A few questions I'd like to answer:


- How should one allocate their time optimally to drive impact?

    - Here, impact is implicitly vague, and can either mean to be some specific individual's utility function or some form of framework derived utility function -- like market value in the context of a capitalism.

- How much variance can effort explain on impact distributions? 

- How do increases/decreases in diversity of opportunities affect an individuals' relative contributions? i.e 

- 

While these questions are TODO

### Assumptions 

How can we start to build up a framework for answering these questions? Well for starters, TODO


1. We decompose talent along different types of fundamental "aptitudes". If we let $A$ represent the set of aptitudes, then $a\in A$ will represent a single type of aptitude e.g visual art, music, math, memorization, empathy, etc. 


2. For each aptitude $a\in A$, an individual has some talent for this given by $\theta_a$ which is Exponentially distributed $\theta_a \sim Exp(1)$. TODO TODO comment on light tail for talent


3. To start simple, every individual has the same fixed time capacity $T$ to invest in learning skills. For each aptitude $a\in A$, an individual can allocate time $t_a$ to acquire skill $S_a = t_a \theta_a$ under the constraint that $\sum_{a\in A} t_a=T$. 
Note the linear relation in each fixed variable: clearly time is a linear input function in reality (you get roughly twice as much done if you work twice as long at it), while the non-linear relation with respect to natural talent is embedded in our assumption on the distributions of $\theta_a$. 


4. Each industry $i\in I$ has some natural set of factors that are required for success. For example, a product designer role at a tech startup incorporates a wide variety of skills (art, strategic planning, communication, engineering, etc.).
We represent these alignments by unit vectors $V_i \in \R^{\vert A\vert}$ where each index $(V_i)_a$ represents the proportion that aptitude $a$ is weighted for being in successful in this industry. For an individual, their utility impact in an industry (let's call this $U_i$) can be taken as the strength of their skillset along the skills an industry values e.g $U_i = \sum_{a\in A} S_a (V_i)_a$.


5. Impact within an industry is power law distributed among those who participate in it. If, for example, our power law is the 20-80 rule, then this means that the top 20% of an industry will capture 80% of the generated value. Let's set $\mu_i$ to be the exponent parameter for the power law scaling in each industry.



6. In order to avoid the complexity of career changes, let's stick with forcing each individual to only belong to a single industry.


### Experiment Setup



### Simulation


### Results


### Extensions

There are a ton of interesting things to explore within this model along with external research to help better inform our assumptions. Some extensions that would be fun to see:


- How do results change if the aptitudes we decompose along are correlated?

- TODO Time in industry is temporal choice rather than static?
