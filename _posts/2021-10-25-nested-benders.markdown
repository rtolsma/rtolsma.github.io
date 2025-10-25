---
layout: post
title: "Wealth management with Nested Benders"
categories: thoughts
tags: [thinky]
comments: true
published: true
---

Spring 2020 was a strange time. Covid had just hit, classes went virtual, and I found myself starting a remote internship at Wealthfront from my childhood bedroom. Despite the chaos, I ended up working on one of the most intellectually engaging projects I've had -- building a completely automated roboadvisor for wealth management. The core challenge was solving a massive optimization problem in real-time, and my project centered on implementing a parallelized solver using nested Benders decomposition.

Looking back, it's wild how much of this experience has shaped my thinking about optimization and system design. The wealth management problem turned out to be a perfect testbed for understanding how to decompose complex decision-making into tractable subproblems, and Benders decomposition provided an elegant framework for doing exactly that.

## The Wealth Management Problem

Wealth management, at its core, is about helping people make better financial decisions over their lifetime. The objective function optimizes economic utility discounted by time and goals -- think retirement savings, buying a house, paying for college, or just maintaining your desired lifestyle. We add soft constraints for objectives like target retirement age, house purchases, college savings, and other life goals that matter to real people.

The input variables are straightforward but numerous: your income stream, monthly cash flows across lifestyle expenses, bills, taxes, and your various savings accounts like 401(k), Roth IRA, brokerage, checking, and savings accounts. Each of these accounts has different tax treatment, contribution limits, withdrawal penalties, and growth characteristics.

Constraints come in two flavors. Hard constraints encode the tax system to restrict actions (you can't over-contribute to your 401(k)), ensure solvency (you need to eat), and handle mandatory goals. Soft constraints capture preferences like "I want to buy a house in 5 years" that can be violated if necessary but incur penalties in the objective function.

The optimization spans a user's entire lifetime. In practice, we discretized this into quarterly decision periods and formed a branching tree model where branches represent changes in external environment variables. The key external variables are things like stock returns and bond rates -- uncertain factors that dramatically impact optimal allocation strategies. For a simplified example, consider a 4-node branching structure for 2 external variables (stocks and bonds). We'd take the 4 eigenvector directions that capture maximum variance at roughly 95% confidence using covariance matrices from historical data.

The action space at each time step is actually convex: you're choosing where to allocate your money across accounts to optimize the objective. This is crucial because it means each subproblem, conditional on a particular scenario, has nice properties. But the full problem across all scenarios and time periods? That's a different beast entirely.

## A Mixed Integer Programming Monster

Put it all together and you get a massive mixed integer program. The continuous variables handle account allocations and cash flows. The integer variables encode discrete decisions (shady big-M method?) -- should we buy a house this quarter? Should we retire? These binary decisions couple with the continuous optimization in complex ways that blow up the problem size.

For context, a typical user's lifetime optimization might involve 40 years × 4 quarters = 160 time steps, each with a branching factor of 4 scenarios, giving roughly $$4^{40}$$ paths through the tree (in practice, we branched less frequently or with fewer eigenectors). Each node in this tree has dozens of continuous and integer variables, resulting in a MIP too big to solve in real time using off-the-shelf solvers.

My project was implementing a solver that could actually handle this -- a generic parallelized tree-based algorithm using nested Benders decomposition to break the problem into manageable pieces.

## Nested Benders Decomposition

Benders decomposition is a classical technique for solving large optimization problems by exploiting structure. The idea is to decompose a hard problem into a master problem and one or more subproblems, solving them iteratively and passing information between them until convergence.

### Two-Stage Benders

Let's start with the simple two-stage case. Suppose we have decision variables $$x$$ (first stage) and $$y$$ (second stage) with the problem:

$$
\begin{align*}
\min_{x,y} \quad & c^T x + f^T y \\
\text{s.t.} \quad & A x \geq b \\
& B x + D y \geq d \\
& x \in X, \, y \in Y
\end{align*}
$$

The key insight is that once we fix $$x$$, the second-stage problem in $$y$$ decouples. We can write the second-stage problem as a value function:

$$
\begin{align*}
Q(x) = \min_{y} \quad & f^T y \\
\text{s.t.} \quad & D y \geq d - B x \\
& y \in Y
\end{align*}
$$

Now the master problem becomes:

$$
\begin{align*}
\min_{x, \theta} \quad & c^T x + \theta \\
\text{s.t.} \quad & A x \geq b \\
& \theta \geq Q(x) \\
& x \in X
\end{align*}
$$

Here $$\theta$$ is a scalar variable representing our approximation of the second-stage cost. The problem is that we don't know $$Q(x)$$ explicitly -- it's the optimal value of an optimization problem that depends on $$x$$, and in general it can be nonconvex and discontinuous when $$Y$$ includes integer variables.

Benders decomposition builds up an outer approximation of the constraint $$\theta \geq Q(x)$$ using cuts derived from solving the subproblem. Each iteration works as follows:

1. **Solve the master problem** with the current set of cuts to get candidate solution $$(\bar{x}, \bar{\theta})$$. This gives a lower bound $$LB = c^T \bar{x} + \bar{\theta}$$ on the optimal value.

2. **Solve the subproblem** $$Q(\bar{x})$$ by fixing $$x = \bar{x}$$. This gives us the true second-stage cost at $$\bar{x}$$, and we compute an upper bound $$UB = c^T \bar{x} + Q(\bar{x})$$ using the best feasible solution found so far.

3. **Generate a cut** based on the subproblem solution:
   - If the subproblem is **feasible**, we get an **optimality cut**. Let $$\lambda^*$$ be the optimal dual variables from the subproblem. Then $$Q(x) \geq f^T y^* + (\lambda^*)^T(d - Bx - Dy^*)$$ for any $$x$$, where $$y^*$$ is the optimal primal solution. Simplifying, this gives the cut:

   $$\theta \geq f^T y^* - (\lambda^*)^T(B\bar{x} + Dy^* - d) - (\lambda^*)^T B(x - \bar{x})$$

   Or more cleanly: $$\theta \geq Q(\bar{x}) - (\lambda^*)^T B(x - \bar{x})$$

   - If the subproblem is **infeasible**, we get a **feasibility cut**. Let $$\mu^*$$ be an extreme ray of the dual cone (Farkas ray) certifying infeasibility. This gives:

   $$0 \geq (\mu^*)^T(d - Bx)$$

   which eliminates the infeasible region from the master problem.

4. **Add the cut** to the master problem and repeat until $$UB - LB < \epsilon$$.

The beauty is that each cut tightens our approximation of $$Q(x)$$. For purely continuous problems, $$Q(x)$$ is convex and we get a polyhedral outer approximation that converges finitely. For MIPs, $$Q(x)$$ is generally nonconvex, but we still make progress by adding cuts at integer solutions -- this is essentially a form of branch-and-cut where Benders generates the cuts automatically from problem structure.

### Decomposing into a Tree

Now extend this to our branching tree structure. Each node $$n \in \mathcal{N}$$ represents a decision point at time $$t(n)$$ under scenario $$s(n)$$. Let $$\mathcal{C}(n)$$ denote the children of node $$n$$, representing possible future scenarios. For our wealth management problem, the decision variables at node $$n$$ are:

- $$x_n$$: allocation decisions (how much to move between accounts)
- $$z_n$$: state variables (account balances, age, etc.)
- $$u_n$$: binary variables (should we buy a house? retire?)

The full multistage problem has the structure:

$$
\begin{align*}
\min \quad & \sum_{n \in \mathcal{N}} c_n^T x_n + h_n^T u_n \\
\text{s.t.} \quad & A_n x_n + E_n u_n \geq b_n \quad \forall n \in \mathcal{N} \\
& z_{n'} = T_n x_n + S_n z_n + W_n u_n \quad \forall n' \in \mathcal{C}(n) \\
& x_n \in \mathbb{R}^{d_x}, \, u_n \in \{0,1\}^{d_u}, \, z_n \in \mathbb{R}^{d_z}
\end{align*}
$$

The constraint $$z_{n'} = T_n x_n + S_n z_n + W_n u_n$$ captures state evolution: the balances and state at child node $$n'$$ depend on the decisions made at parent node $$n$$. Different children get different realizations of random returns (encoded in the branching structure), but they all inherit the consequences of the parent's decisions.

This is where nested Benders shines. At each node $$n$$, we can treat the entire subtree rooted at $$n$$ as a two-stage problem: the current node is the "first stage" and everything below is the "second stage". Define the value-to-go function:

$$
\begin{align*}
V_n(z_n) = \min_{x_n, u_n} \quad & c_n^T x_n + h_n^T u_n + \sum_{n' \in \mathcal{C}(n)} p_{n'} V_{n'}(z_{n'}) \\
\text{s.t.} \quad & A_n x_n + E_n u_n \geq b_n \\
& z_{n'} = T_n x_n + S_n z_n + W_n u_n \quad \forall n' \in \mathcal{C}(n) \\
& x_n \in \mathbb{R}^{d_x}, \, u_n \in \{0,1\}^{d_u}
\end{align*}
$$

where $$p_{n'}$$ is the probability of transitioning to child $$n'$$. For leaf nodes, $$V_n(z_n) = 0$$.

The decomposition becomes a message passing algorithm. Each node $$n$$ maintains a master problem:

$$
\begin{align*}
\min_{x_n, u_n, \theta_n} \quad & c_n^T x_n + h_n^T u_n + \theta_n \\
\text{s.t.} \quad & A_n x_n + E_n u_n \geq b_n \\
& \theta_n \geq \sum_{n' \in \mathcal{C}(n)} p_{n'} V_{n'}(T_n x_n + S_n z_n + W_n u_n) \\
& x_n \in \mathbb{R}^{d_x}, \, u_n \in \{0,1\}^{d_u}
\end{align*}
$$

Just like in two-stage Benders, we approximate the constraint $$\theta_n \geq \sum_{n'} p_{n'} V_{n'}(\cdot)$$ using cuts. But now the cuts come from solving child subproblems, and those child subproblems recursively depend on *their* children's value functions.

**Optimality cuts from children**: When child node $$n'$$ solves its subproblem given state $$\bar{z}_{n'}$$, it obtains optimal value $$V_{n'}(\bar{z}_{n'})$$ and dual variables $$\lambda_{n'}^*$$ corresponding to the state evolution constraints. The child sends back to parent $$n$$ the optimality cut:

$$
V_{n'}(z_{n'}) \geq V_{n'}(\bar{z}_{n'}) + (\lambda_{n'}^*)^T (z_{n'} - \bar{z}_{n'})
$$

Substituting $$z_{n'} = T_n x_n + S_n z_n + W_n u_n$$, this becomes a cut on the parent's variables:

$$
\theta_{n'} \geq V_{n'}(\bar{z}_{n'}) + (\lambda_{n'}^*)^T (T_n x_n + S_n z_n + W_n u_n - \bar{z}_{n'})
$$

The parent aggregates cuts from all children: $$\theta_n \geq \sum_{n' \in \mathcal{C}(n)} p_{n'} \cdot \theta_{n'}$$.

**Feasibility cuts from children**: If a child subproblem is infeasible given $$\bar{z}_{n'}$$, it computes a Farkas ray $$\mu_{n'}^*$$ and sends the feasibility cut:

$$
0 \geq (\mu_{n'}^*)^T (T_n x_n + S_n z_n + W_n u_n - \bar{z}_{n'})
$$

This eliminates parent decisions that lead to infeasible child states -- crucial for ensuring the parent doesn't make promises the future can't keep (like over-withdrawing from retirement accounts).

The algorithm proceeds by iteratively solving subproblems at each node, generating cuts, passing them to parents, solving parent problems, and sending updated state values down to children. Convergence is achieved when all nodes' lower bounds (from their master problems) match their upper bounds (from feasible solutions).

### Why This Works for Mixed Integer Programs

The critical advantage of nested Benders for MIPs is that it decomposes the problem in a way that dramatically reduces the branching complexity. Solving the full problem with a standard MIP solver requires exploring the combinatorial space of all binary variables across all time periods and scenarios simultaneously. With $$T$$ time periods, $$S$$ scenarios per period, and $$k$$ binary variables per node, you're looking at a branching tree with $$O((2^k)^{ST})$$ nodes in the worst case. That's computationally hopeless.

Nested Benders breaks this down. At each node $$n$$, the master problem only involves the local binary variables $$u_n \in \{0,1\}^{d_u}$$ for that specific time-scenario pair. The solver explores $$2^{d_u}$$ combinations locally, but critically, it doesn't need to simultaneously explore combinations from other nodes. The coupling between nodes is handled through the cuts, not through explicit enumeration.

Here's the key: when we solve child node $$n'$$'s subproblem, we condition on the parent's state decision $$\bar{z}_{n'}$$. Given that state, the child optimizes over its own binary decisions independently. The child's binary variables are *completely decoupled* from the parent's binary variables in the branch-and-bound tree -- they only interact through the continuous state variables.

This means the effective branching is $$O(2^{d_u})$$ per node rather than $$O((2^{d_u})^{\vert \mathcal{N} \vert})$$ for the full tree. We've transformed an exponential problem in tree size to a linear problem in tree size with exponential work per node -- and when $$d_u$$ is small (as it often is for real applications), this is tractable.

Additionally, the cuts provide a form of learning across iterations. When we add an optimality cut from a child, we're encoding information about *all possible* future scenarios reachable from that child's subtree. A single cut can eliminate vast regions of the parent's decision space that would lead to poor outcomes downstream. This is far more efficient than explicitly enumerating those scenarios.

The convex action space (allocation decisions are continuous) is crucial here. It means that conditional on the binary decisions $$u_n$$, each node's problem is a convex LP or QP. Modern solvers crush these in milliseconds. The hard part is the combinatorial search over $$u_n$$, but with small $$d_u$$ and good cuts guiding the search, this remains feasible.

### Achieving Real-Time Performance

Raw Benders decomposition gives us tractability, but real-time performance requires parallelization. The scenario tree structure provides natural parallelism at multiple levels:

1. **Sibling independence**: Children of the same parent can solve their subproblems in parallel -- they depend on the same parent state but are otherwise independent.

2. **Subtree independence**: During backward passes (solving from leaves toward root), entire subtrees rooted at different children can process in parallel until they need to send cuts to their common ancestor.

3. **Iteration-level parallelism**: In some algorithmic variants, we can solve all nodes at a given tree level simultaneously using the current cuts, then propagate results up or down.

For our wealth management problem with $$\sim$$10,000 nodes in the scenario tree, this parallelism is essential. A sequential solve taking 1ms per node would require 10 seconds total -- unacceptable for an interactive application. But with 100-way parallelism, we're down to 100ms of wall-clock time, which is usable.

The cuts also reduce iteration counts dramatically. In early iterations, subproblems might return wildly suboptimal solutions because the parent's cuts are loose. But as cuts accumulate, the master problems produce better candidate solutions, child subproblems have less work to do (they're already near-optimal), and convergence accelerates. In practice, we'd often see convergence in 5-10 iterations for user updates to an existing solution, compared to hundreds of iterations starting cold.

Warm-starting is another huge win. When a user updates their income or adjusts a goal, most of the scenario tree structure is unchanged. We keep the accumulated cuts from the previous solve and only invalidate nodes whose parameters actually changed. The solver can often reuse solutions from 90%+ of the tree, solving only the affected subtrees from scratch.

### Parallelization Strategies

The tree structure opens up natural parallelization opportunities. Different subtrees can be solved independently (at least partially), and there are multiple algorithmic variants for how to orchestrate the message passing:

1. **Backwards-Always**: Start from the leaf nodes and work backwards up the tree. Each node waits for all children to send cuts before solving. Very stable, but sequential -- limited parallelism across tree levels.

2. **Forwards-Always**: Start from the root, solve, send parameters down to children, then solve children in parallel. Faster initially but can thrash if parent decisions keep changing.

3. **Backwards-Forwards**: Alternate between backward and forward passes. Combine the stability of backward passes with the speed of forward passes once you're close to convergence.

4. **Custom Tweaks**: Monitor convergence directions and adaptively sync directions with adjacent subtree (e.g. optimistically go backwards when adjacent is going backwards since it blocks on parents, otherwise go forwards). In parallelization constrained settings, there's an additional knapsack problem on which subtree problems to allocate across solvers. Solve time is predominantly correlated with problem size, and so you can employ heuristics to estimate which subtrees are likely to block others on sequencing for backwards movements and prioritize accordingly.

## Conclusion

The most satisfying part was seeing all of this actually work and drive 10x+ speedups (dependent on problem size). For an internship, this was the most fun I'd ever had, and definitely influenced my decision to move into quant post-grad -- these types of high impact, fun academic problems are my favoriite.
