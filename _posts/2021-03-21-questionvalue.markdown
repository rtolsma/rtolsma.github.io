---
layout: post
title: "The Value of a Question"
categories: math
comments: true
published: True 
---



This past quarter I was able to take a class at Stanford on [Information Theory](http://web.stanford.edu/class/ee276/outline.html) which had some really interesting material. While the class ended up not covering any significant applications to statistics or machine learning, I was able to glean some some small insights here and there after some contemplation. Below, I present in the form of an approachable gamified series of questions, a relatively interesting and intuitively insightful result at the intersection of statistics and information theory that I came across while musing around a couple days ago.


## Gambler's 20 Questions

I figured the header needed a catchy name so I'll present the results in a form of gambling scenario. A certain online platform is hosting a prediction contest! The rules are as follows: the contest hosts will randomly sample $$N$$ variables $$X_i \sim N(0, \sigma^2)$$ and take their sum $$Y = \sum_{i=1}^N X_i$$. Each participant submits a prediction $$\hat{Y}$$ and receives reward linearly proportional to the negative squared error $$-(Y-\hat{Y})^2$$.

1. Compute the entropy $$H(Y)$$. 
    
    
2. Which predictor is optimal in this scenario? What is your expected reward?
    
    
3. You have an insider on the contest who's willing to help you out. You can ask them a single yes or no question to help you decide on your predictor. What is an optimal question to ask? Denote the random variable $$Z$$ as the answer to your question. Compute $$H(Y\vert Z)$$ and your expected reward conditioning on this information. Hint: The expected value of the half-normal distribution is given by $$E[A \vert A > 0] = \sigma \sqrt{\f{2}{\pi}}$$ where $$A\sim N(0, \sigma^2)$$.
    
    
4. Is there another question you could have asked, $$Z'$$, that gives you the same amount of information, but yields lower reward?
    
    
5. Instead of asking a question, the insider now proposes a deal: for each $$c$$ units of reward you pay, they will give you the value of one of the variables $$X_i$$ (i.e $$kc$$ units of reward gives you the first $$k$$ variable values). How much should you pay to optimize the expected rewards?
    
    
6. Compute the marginal information gained from the $$m$$-th payment. Is it increasing or decreasing in $$m$$? Analyze the ratio of cost to marginal information gained. Is this quantity bounded in $$m$$ under the asymptotic limit $$N\to \infty$$? 
    
    
7. Given the choice between learning the first $$m$$ variable values, or the ability to ask $$k$$ yes or no questions in succession, which should you choose? Describe your answers in terms of $$m,k$$ and the given variables. Hint: You may want to check out the [Truncated Normal](https://en.wikipedia.org/wiki/Truncated_normal_distribution) and try writing some code as this part can get messy.

8. Does the optimal series of $$k$$ questions satisfy $$H(Z_k) = 1$$?
