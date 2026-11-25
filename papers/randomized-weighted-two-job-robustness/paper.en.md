---
title: "Sharp randomized robustness for two weighted nonclairvoyant jobs"
lang: en
geometry: margin=1in
---

# Abstract

Consider two jobs with positive weights and unknown positive sizes, released together on a single preemptive machine. For the weighted sum of completion times, we find the exact randomized robustness against arbitrary size predictions:
\[
 1+\frac{1}{2(w_1/w_2+w_2/w_1)+1}.
\]
An optimal policy mixes the two serial orders and weighted processor sharing. Its expected competitive ratio is the same on every input. A lower bound averages two fixed size shapes over a logarithmic scale window and applies to every randomized policy, including those whose allocation changes with time and predictions. At optimal robustness, almost every pre-completion path has limiting cumulative shares as virtual time tends to zero and to infinity. The limits at both ends have the unique optimal three-mode distribution. We also determine the opposite endpoint, the least robustness compatible with exact optimality on every correct prediction.

# 1. Model and statements

There are two jobs released at time zero, with known weights \(w_1,w_2>0\), unknown sizes \(x_1,x_2>0\), and arbitrary positive size predictions \(y_1,y_2\). A unit-speed machine may preempt and divide its processing rate between jobs, with total rate at most one. A policy knows weights, predictions, elapsed time, its own processing, and observed completions. Its independent random seed is drawn after the input and predictions are fixed. The objective is \(w_1 C_1+w_2 C_2\), where \(C_i\) is completion time. Competitive comparisons use expected cost on each fixed instance. **Robustness** is the supremum of the expected competitive ratio over sizes and predictions; **consistency** is that supremum over correct predictions.

Let
\[
 u=w_2x_1,\quad v=w_1x_2,\qquad
 A=w_1/w_2,\quad B=w_2/w_1,\quad D=2(A+B)+1.
\]
Use \(\operatorname{OPT}=Au+Bv+\min(u,v)\). This is the offline optimum, since processing the job with smaller Smith ratio \(x_i/w_i\) first makes the additional waiting cost \(\min(u,v)\). Section 2 also verifies this expression directly for all fractional schedules.

**Theorem 1.** The minimum randomized robustness is \(1+1/D\). The bound holds with any single prediction vector fixed. An attaining policy chooses job 2 first with probability \(B/D\), job 1 first with probability \(A/D\), and weighted processor sharing with probability \((A+B+1)/D\). In the sharing mode both jobs receive rates proportional to their weights until the first completion. In all modes the remaining job then runs at full speed. This policy has competitive ratio exactly \(1+1/D\) on every size vector, in expectation.

**Theorem 2.** Fix a prediction vector for a policy attaining the robustness in Theorem 1. Along its path before seeing any completion, let \(q_i(t)\) be the cumulative transformed progress of job \(i\) in virtual time \(t=q_1+q_2\), with \(q_1=w_2p_1,\ q_2=w_1p_2\) for physical progress \(p_i\). For almost every seed, \(q_1(t)/t\) has limits at zero and at infinity. Each limit takes values \(0,1,1/2\) with the respective probabilities \(B/D,A/D,(A+B+1)/D\). In particular the optimal law of a fixed virtual share is unique.

**Theorem 3.** The smallest robustness compatible with consistency one is \(1+\max(A,B)\). The policy that runs the jobs in their predicted Smith order attains it.

For equal weights the two endpoint robustness values are \(6/5\) and \(2\), respectively. The analysis below treats those endpoints for all weight ratios.

# 2. Virtual time and the first completion

Fix weights, predictions and a seed. Until observing a completion the policy follows a deterministic path \(p_1,p_2\), given by its allocations under the history with no completion. A policy with finite robustness must, for almost every seed, have unbounded total service along that path. To see this, hold the predictions fixed and consider true sizes \((k,k)\) for all positive integers \(k\). Each instance completes in finite time almost surely, so there is a common full-probability set of seeds for which the no-completion path reaches a total service of at least \(k\) for every \(k\). On that set, the continuous nondecreasing virtual clock \(w_2p_1+w_1p_2\) has full range \([0,\infty)\). On a flat interval both progress coordinates are constant, so it defines the virtual functions \(q_i(t)\). They are nondecreasing and \(1\)-Lipschitz, and sum to \(t\).

Let \(\tau(u,v)\) denote the first virtual time when \(q_1\) reaches \(u\) or \(q_2\) reaches \(v\). It satisfies \(\tau(u,v)\le u+v\). If job \(i\) finishes first and \(j\) is the other job, write \(p_j\) for job \(j\)'s physical progress then. The first physical completion time is at least \(x_i+p_j\), and the last is at least \(x_1+x_2\). The weighted cost is at least
\[
 w_i(x_i+p_j)+w_j(x_1+x_2)
   = Au+Bv+w_jx_i+w_i p_j
   = Au+Bv+\tau(u,v).
\]
In a simultaneous completion either label can be counted first. The inequalities are equalities for a work-conserving schedule. Since the first virtual time is at least \(\min(u,v)\), and the corresponding serial order can attain it, this also proves the expression for \(\operatorname{OPT}\).

# 3. Optimal policy

A fixed virtual share \(\lambda\in[0,1]\) gives \(q_1(t)=\lambda t,\ q_2(t)=(1-\lambda)t\) and
\[
 \tau_\lambda(u,v)=\min(u/\lambda,v/(1-\lambda)),
\]
where division by zero means \(+\infty\). It is implemented work-conservingly by physical rates proportional to \(\lambda/w_2\) and \((1-\lambda)/w_1\). Thus shares \(0,1,1/2\) have first virtual times \(v,u,2\min(u,v)\). Mix them with probabilities \(B/D,A/D,(A+B+1)/D\). These sum to one. For every pair of sizes,
\[
 \mathbb E\tau(u,v)
   =\frac{Au+Bv+2(A+B+1)\min(u,v)}{D}
   =\min(u,v)+\frac{\operatorname{OPT}}{D}.
\]
Adding the base cost proves the upper bound in Theorem 1.

# 4. A lower bound over logarithmic scale

Fix the predictions throughout. Suppose a policy has expected competitive ratio at most \(1+\beta\) for every pair of sizes at these predictions, with \(\beta\) finite. Section 2 gives for all \(u,v>0\)
\[
 \mathbb E\tau(u,v)\le \min(u,v)+\beta\bigl(Au+Bv+\min(u,v)\bigr).
\]
Test the two shapes \((u,v)=(z,3z),(3z,z)\) at each scale \(z\), giving them equal weight. Their mean virtual time is at most \((1+\beta D)z\).

At any fixed virtual time \(t>0\) and seed, let \(\lambda=q_1(t)/t\). The survival events \(\tau(z,3z)>t\) and \(\tau(3z,z)>t\) hold exactly when \(z\) exceeds, respectively,
\[
 m_1=\max(q_1(t),q_2(t)/3),\qquad m_2=\max(q_1(t)/3,q_2(t)).
\]
Each threshold is in \([t/4,t]\). The reciprocal kernel is
\[
 K(\lambda)=\frac{t}{2}\left(\frac{1}{m_1}+\frac{1}{m_2}\right)
  =\begin{cases}
      2/(1-\lambda),&0\le\lambda\le1/4,\\
      1/[2\lambda(1-\lambda)],&1/4\le\lambda\le3/4,\\
      2/\lambda,&3/4\le\lambda\le1 .
    \end{cases}
\]
It is at least two, with equality precisely at \(0,1/2,1\).

For \(0<L<H/4\), integrate the mean of the two expected virtual times against \(dz/z^2\) over \([L,H]\). The robustness bound gives an upper bound \((1+\beta D)\log(H/L)\). For a lower bound, express each virtual time as the integral of its survival indicator, apply Tonelli's theorem, and keep only \(t\in[4L,H]\). In this window \(m_1,m_2\) are both in \([L,H]\). Integration in \(z\) of each indicator gives \(1/m_i-1/H\). Therefore
\[
 (1+\beta D)\log(H/L)
 \ge \int_{4L}^{H}\mathbb E K(q_1(t)/t)\,\frac{dt}{t}
       -1+\frac{4L}{H}.                                                  \tag{1}
\]
This holds for every fixed prediction vector and every window. Using \(K\ge2\) gives the finite-window bound
\[
 \beta D\ \ge\
 1-\frac{2\log4+1-4L/H}{\log(H/L)} .
\]
Let the ratio \(H/L\) tend to infinity. This proves \(\beta\ge1/D\), completing Theorem 1.

# 5. Limiting shares of optimal policies

For a fixed-share randomized policy, \(\lambda\) is sampled once and does not depend on time after the seed and predictions are fixed. The mean of the normalized virtual times on the two test shapes is \(K(\lambda)\) for each fixed share. At optimal robustness its expectation must be at most two, so the law is supported on \(0,1/2,1\). Write \(p_0,p_{1/2},p_1\) for the probabilities. The expected virtual time at any \(u,v\) is \(p_0v+p_1u+2p_{1/2}\min(u,v)\). The robustness bound for \(u/v\) tending to zero gives \(p_0\le B/D\). The opposite limit gives \(p_1\le A/D\), and \(u=v\) gives \(p_{1/2}\le(A+B+1)/D\). As the three upper bounds sum to one, all are attained. This argument uses only the virtual-time bounds, so it also applies to any law of \(\lambda\) inheriting them.

Now let the policy have an arbitrary pre-completion path and achieve robustness \(1+1/D\). Subtract the baseline kernel two in (1) to get
\[
 \int_{4L}^{H}\mathbb E\bigl[K(q_1(t)/t)-2\bigr]\frac{dt}{t}
 \le 2\log4+1-\frac{4L}{H}.
\]
As \(L\) decreases to zero and \(H\) increases to infinity, monotone convergence and Tonelli give an expected global integral at most \(2\log4+1\). In particular the global integral is finite for almost every seed. Put \(\lambda(t)=q_1(t)/t\). For \(0<t_1<t_2\), monotonicity and the \(1\)-Lipschitz bound of \(q_1\) give
\[
 |\lambda(t_2)-\lambda(t_1)|\le (t_2-t_1)/t_2\le\log(t_2/t_1).
\]
Also \(K\) is Lipschitz on \([0,1]\). On the logarithmic time line \(s=\log t\), the nonnegative function \(K(\lambda(e^s))-2\) is thus Lipschitz and integrable for almost every seed. It must tend to zero at both ends, since a sequence of values bounded away from zero would, by the Lipschitz bound, yield disjoint positive contributions to the integral. Hence the distance of \(\lambda(e^s)\) from \(\{0,1/2,1\}\) tends to zero at both ends. Continuity forces \(\lambda(e^s)\) eventually into a single disjoint neighborhood of one of these points at each end. It then converges to that point. Denote the two limits by \(\lambda_0,\lambda_\infty\).

Fix a shape \(u,v>0\) and let \(z\) tend to zero or infinity. At virtual time \(zt\) for fixed \(t>0\), the vector \((q_1(zt),q_2(zt))/z\) tends to \((\lambda_*t,(1-\lambda_*)t)\) for the corresponding limit \(\lambda_*\). At times strictly below the first fixed-share crossing, both coordinates are strictly below their thresholds. At a time strictly above it, at least one is strictly above. This proves
\[
 \tau(zu,zv)/z\ \longrightarrow\ \tau_{\lambda_*}(u,v)
\]
for almost every seed, including the zero-share endpoints. The normalized virtual time is bounded by \(u+v\). Dominated convergence therefore shows that the law of \(\lambda_*\) satisfies the optimal virtual-time bound for every fixed shape. The uniqueness argument above identifies this law at both ends. This proves Theorem 2.

# 6. Perfect consistency

Consider a correct prediction vector with strict Smith order, with job \(i\) first and \(j\) second. If consistency is one, the policy is offline optimal almost surely on that input: each realized cost is at least the offline optimum. The strict order and the waiting-cost expression in Section 2 imply that job \(i\) must finish first and that \(p_j=0\) at that time. The physical lower bound also forces zero idle time before this first completion. Thus the policy serves job \(i\) exclusively until physical time \(y_i\).

Keep these predictions and job \(i\)'s true size fixed, but take the true size of job \(j\) down to zero. It remains positive, so it cannot complete on the same pre-completion path without service. The first completion is still job \(i\) at time \(y_i\) almost surely. The actual waiting cost is at least \(w_jy_i\) while the offline waiting cost tends to zero, so the limit inferior of the competitive ratio is at least \(1+w_j/w_i\). Both strict predicted orders are possible, giving the lower bound \(1+\max(A,B)\).

For the upper bound, always run the indicated Smith order serially. This is offline optimal on correct predictions. If job 1 runs first when job 2 should have run first, the normalized excess cost is
\[
 \frac{u-v}{Au+Bv+v}\le B .
\]
If job 2 runs first when job 1 should have run first, the bound is \(A\). The resulting robustness is exactly the claimed endpoint.

# 7. Pinned comparison and scope

The pinned repository manuscript gives the exact unweighted deterministic frontier for a fixed number of jobs. Its scope excludes randomization and weights. The present result gives the randomized robustness optimum for two jobs with arbitrary positive weights, a scale-window lower bound against all prediction-dependent policies, the limiting law of their cumulative shares at optimal robustness, and the exact endpoint at consistency one. The intermediate randomized consistency–robustness frontier and larger job sets remain outside the statements proved here. The comparison is to the pinned repository source.
