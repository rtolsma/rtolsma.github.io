---
layout: post
title:  "Productionizing Productivity"
categories: thoughts
comments: true
---


Last year, I had the privilege of spending my summer in the beautiful city of London toiling away as an intern at a proprietary trading firm. Besides
learning the day to day skills and operations, I greatly benefitted from engaging in banter and discussions with talented coworkers who dramatically
impacted and shaped my approach to life and problem solving. For those unfamiliar with the industry, quants tend to engage, for better or worse, in a _particular_ occupation-influenced mindset that centers on hyper rationalism in a competitive environment that is inherently uncertain (see [Von Neumman-Morgenstern Utility](https://en.wikipedia.org/wiki/Von_Neumann%E2%80%93Morgenstern_utility_theorem)) [^1]. 
In this framework, the ultimate goal of any investor or trader is to optimize for risk-adjusted expected returns across each asset class. The Sharpe Ratio, defined by $$\frac{E[R] - R_f}{\sigma_R}$$, measures the ratio between expected portfolio returns above the risk free rate and the portfolio volatility and is often used as a first order metric to compare different funds' performances.


So why write about all of this? Despite the pervasive (and successful) applications of this versatile risk-conscious returns optimization framework in finance, its prevalence in common corporate and personal career decision making is disproportionately limited: pre-market startup employees consistently take on excess risk without receiving proportionate equity upside, public corporations pressured
by stockholder influence often exhibit too low-risk tolerance inhibiting growth [^2], and talented students aiming to pursue graduate studies in popular subjects fail to sufficiently account for market timing risk [^3]. These types of contexts have been occupying my mind a lot recently, and after some extensive consideration, it has become inexplicably clear to me that the largest singular inefficiency in skilled market places is human capital and understanding the relations between value and productivity.

Human capital comprises the majority of expenditures and investment in any skilled services corporation, yet it is by far the least well measured and optimized. Industry veterans or rockstars in tech often exceed the productivity of talented new graduates by one or two order of magnitudes, yet their compensations will likely differ by no more than 3-4x in any given company. It's startling to me how comfortable
employers are divulging precious funds into these highly volatile assets with incredibly weak signals on expected performance. Would any sound investor engage in highly illiquid asset classes, with sub-yearly updates and incomplete balance sheets? Yet everyday, employees reduce years of experience, projects and growth to single lines on resumes and utilize biased "professional" accounts of
their performance from managers or coworkers with close personal relations to signal credibility to future employers. In tandem, risk-averse corporations settle for conducting critical interviews across a mere few hours of phone calls and onsite interviews before deciding to execute these recurring six figure investments. 

The blatant inefficiencies of this ubiquitous routine can be isolated into two components: 
employees have limited means of providing accurate signals of aptitude and capability, and in the face of noisy information, characteristically risk-averse employers are forced to adopt standardized, inaccurate interviews in desperate attempts to minimize the resource consuming process of filtering candidates rather than optimizing for them. In essence, corporations fixate on reducing false positives, optimizing their Sharpe Ratio by solely minizing the variance on their hires $$\sigma_R$$ [^4] rather than maximizing their talent base $$E[R]$$, leading to sub-optimal hiring decisions for many qualified
applicants. As a side effect, this hiring process yields poor indicators of true capability leading to an inequitable compensation scheme. Since employers cannot distinguish between good, better, and great
employees, they err towards safety and offer less scalable and diverse compensation levels. Interviewees on the other hand, tend to have very little leverage in these negotiations; rarely does any worker
understand their value beyond relative performance to immediate coworkers and at best maintain some foggy insight into their contributions[^5] towards a company's bottom line on which to justify their asking price. 

Fortunately, startups can often relieve the fair-value seeking employee's woes. By their very nature, startups are lean and risk-taking and can afford to spend greater care and detail
with an individualized hiring process as these investments represent greater impact on likelihood of success. Due to these refined measurements, and the urgent desires for talent and productivity in earlier
stages, startups are often capable of offering higher risk-adjusted returns. However, this unfortunately does not significantly improve the situation. Employees now are faced with two 
contrasting decisions: low-risk sub-optimal risk-adjusted careers on one end, or high risk fairer risk-adjusted returns. For most people, responsibilities and dependents prevent the latter
from ever posing a real option, and for this reason startups are inhibited from exuding necessary upwards pressure on the compensation delivered by larger competitors.



Now, to be clear, none of these insights are necessarily novel, but I believe this type of thinking should be brought into the broader discussion. History shows us that accurate measurements
of value and productivity lead to greater efficiency in both production and decison-making. Fast food chains can run on razor-thin margins in a competitive space because they understand each 
aspect of their business -- human capital especially -- in fine detail. Automobile production lines began seamless operation and explosive growth upon embracing the predictable and 
measurable assembly line. Massive online retail sellers demonstrated phenomenal growth and capacity, exceeding expectations as their carefully optimized networks for distribution proved resilient
to the dramatic shifts in demand. While each of these examples represents fields characterized by low-skilled, low-variance labor, the commoditization of human output -- which some may find
dehumanizing -- inarguably leads to higher outputs. In order to operate efficiently and effectively, companies need to understand their costs of production, and in the skilled service sector, that
begins with accurately measuring employee outputs.

$420/hr

￼

What can we do? For employees, personal websites and
social network profiles like LinkedIn afford the opportunity to provide greater detail insights into projects and work experiences, but these methods suffer from embellishment and
personal biases rather often. What we need are better platforms and processes for gathering metrics over time, data that can illustrate trajectories and growth in addition to 
performance. Internally, large bureaucratic corporations can foster these forms of analysis over time, tracking employee reviews and key performance indicators in a rigorous manner for continuous
analysis and managerial insights over time. However, issues with data privacy and the lack of centralized, employee focused platforms for verified data collection
will obstruct market-wide scaling of these methods and prevent accurate and efficient external candidate evaluations for the forseeable future. Facing low-quality information, corporations will have no choice but to continue to require costly[^6] and rigid sub-optimal hiring processes offering sub-optimal and inefficient employee compensation in perpetuity.



Please feel free to reach out to me at rtolsma@stanford.edu if you have any thoughts about these topics, I'd love to discuss other perspectives. Most of my ideas originated in isolation, so I'd appreciate
any examples or data that can offer better insights. Thanks for reading the post!


### Footnotes
[^1]: For those interested in alternative decision making frameworks, a personal favorite of mine is [regret minimization](https://en.wikipedia.org/wiki/Regret_(decision_theory))
[^2]: A favorite of mine _The Innovator's Dilemma_ and the sequel _The Innovator's Solution_ discusses this in depth.
[^3]: Look at all of the aerospace graduate students at the end of the Cold War.
[^4]: Technically, this more analagous to minimzing $$\sigma_R$$ given a baseline cutoff constraint on $$E[R]$$. See [mean variance portfolio optimization](https://en.wikipedia.org/wiki/Modern_portfolio_theory#Risk_and_expected_return) for more details if you are interested.
[^5]: More precisely, I mean counterfactual contributions here. If a salesperson signs a 1,000,000$ worth of contracts, but given the company's brand, products, and reputation, any random kid off the block could sell 900,000$, then it's fairly clear the salesperson's contribution is less significant. Measuring the true contribution requires either broad experimentation (by means of acquiring accurate baselines) or a more sophisticated analysis of the other factors in play. Check out [Shapley Values](https://en.wikipedia.org/wiki/Shapley_value) for understanding some relevant theory.
[^6]: Some firms like TripleByte or CodeSignal in the tech industry attempt to reduce costs by centralizing user data from the technical interview process. However, this is little more than cost indirection, and still leads to gamable noisy signals (LeetCode anyone?) with the addition of incentives which reduce effectiveness -- recruiters only want to source successful hires, but then most people they want to/do work with were probably capable or successful independently to begin with.