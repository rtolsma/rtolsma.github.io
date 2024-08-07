---
layout: post
title: "Some Thoughts on Robotics"
categories: thoughts
comments: true
published: true
---

Last fall, I spent a couple of months actively researching the robotics space for problems to solve or good companies to join. My background from working on RL research with Dorsa and Chelsea's labs during undergrad, and the rapid capability improvements we've witnessed in the last three years had me pretty excited. A lot has changed, but I thought it would be useful to share with others a draft of some of the high-level insights and frameworks I arrived at after talking to researchers, founders, VCs, suppliers, and clients in the industry before deciding for myself not to re-enter the field yet.

## Draft Notes

### Where can a VC scale business be built in robotics?

Like in any industry, you drive by scale by finding broad horizontal problems with sufficient pain to warrant pricing, or select verticals with large enough scope to integrate into. Large verticals that are currently viable for robotics mostly include manufacturing, warehouse logistics, big agriculture, precision surgical/medicine, and fast-food restaurants. This list is constantly expanding as the tech improves and pushes COGs lower, increasing the surface area of accessible markets.

### What can be solved horizontally?

At a high level, you need broadly replicable pain points that are also not viewed by companies as core competencies. Core competencies will be brought in-house eventually (case studies: Scale AI AV labeling, Applied Intuition simulation infra sales, Zendesk AI agents, Tecton, and other marginal ML ops providers) and will be resilient to durable sales relations.

### What are the high-level problems robotics startups face?

I've sorted the following list by my personal opinion of most to least solved and labeled whether it's primarily a vertical or horizontally solved problem:

1. **Distribution** (Vertical)

    - For most companies, this is likely to be viewed as a core competency and remain so in the future. The playbook here feels similar to the wave of vertical SaaS OpenAI wrapper companies, where distribution and domain expertise are the primary moats and value drivers.

    - An additional differentiator to AI SaaS providers is that the hardware stack for robotics is not unified across use-cases, which prevents distribution from scaling horizontally well in general.

2. **Hardware** (Vertical now, Horizontal in ~5-10 years)

    - Outside of large verticals where the hardware stack is likely to unify, this is typically viewed as a core competency by most incumbents and new players in the space.
    - As better general use-case hardware develops, this will decrease in relative importance from a core function ("we need custom hardware to solve the problem") to a competitive operational advantage ("we need custom hardware to reduce costs or drive efficiency compared to competitors"). Similar to the open-source platform and AI model communities, once more effective general use-case hardware hits the markets, the cost scaling benefits of standardized manufacturing will eventually dramatically drive down the marginal value of custom hardware.

    - Together, hardware production and physical distribution are the two main components contributing to fragmentation and stickiness of distribution. Lack of standardization contributes heavily to higher switching costs, both from physical replacements and the operational adjustments required to integrate it (ever tried the same prompt and swapping GPT and Claude?). This has implications for centralization (like any fab-style production: GPUs, CPUs, LLM pre-training, etc.) unless effective horizontal platforms and OSS communities develop (everyone is still custom hacking ROS internally...).

3. **Perception** (Horizontal)

    - Vision models have gotten surprisingly good at the edge over the last three years, and edge compute and specialized chips are really pushing the frontier on what robots can now do in real time.

    - Other modalities of perception (LiDAR, radar, ultrasonic sensors, and infrared cameras) have less accessible public data, which might be limiting useful adoption from new players.

    - Outside of niche applications and modalities, perception is a pretty well-understood problem, and the majority of recent focus has been on tail edge cases. Finding instances of serviceable edge-cases seems like a promising approach to sourcing customers. For example, real-time vision safety modules to help prevent heavy machinery/robotics accidents in factory environments.

    - Currently, perception seems primarily internalized as it's heavily coupled with hardware choice and power/latency tradeoffs and linked to safety, which has severe downside risks if not appropriately managed internally. I expect this to change over the next couple of years as horizontal providers reach acceptable thresholds/tradeoffs in both, as it's clearly not viewed as a defendable moat.

4. **Data** (Vertical but with horizontal infra plays)

    - As LLMs have started to dominate media, it's growing awfully apparent that data will become a core competency and moat for traditional platforms.

    - In robotics, data has significant barriers to access. It's coupled to your hardware sensors and on-policy control procedures, and can require time-consuming physical interactions to extract realistic environments.

    - The real2sim gap still exists but is slowly getting better. The reality of long-tail edge cases, however, limits the effectiveness of iterating too reliantly on simulations as your ability to safely extrapolate to real-world deployments is dubious at best.

    - Simulations are clearly horizontal infrastructure, and I'm optimistic that in the near term new players can exist somewhere in-between to augment or curate physically gathered data (i.e., through data augmentation, scene analysis filtering) in a way that doesn't compete with the existing bloated field of traditional ML ops providers.

5. **Control** (Vertical now, Horizontal in ~5-10 years)

- Control is by far the least resolved component in the technical stack and might better be referenced as environment modeling in its current state. In the short term, this is a strongly differentiated capability (Waymo vs. everyone else?), but I suspect like with most software/algorithmic progress eventually this will change or centralize like in the case of foundation model labs.

- Traditional control methods work extremely well as functional primitives, supplied with environment model inputs and called with intent from an intelligent orchestrator (often a tokenized action transformer). A primary bottleneck is gathering sufficient data to test automated control on the long tail of edge cases. For this reason, controlled environments or those with limited human interaction are currently the primary targets.

- Compared to the other components, this is the purest "algorithmic" problem with low capital barriers to access. The physical economies of scale associated with distribution, hardware development/production, and data gathering might not necessarily apply here if algorithmic unlocks can be found.

### Conclusion

There's a ton to expand on here across the stack, including a lot of key components I'm leaving out, but I'm hoping that others interested in starting or evaluating robotics companies will find this useful. While I'm not currently involved or actively looking right now, I'm still very excited and interested in the five-year horizon, and would love to hear any pushback or new insights you might have.
