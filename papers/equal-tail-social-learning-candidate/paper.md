# Sharp welfare concentration and belief-reversal instability in sequential social learning

Research manuscript, 26 November 2026. The results are written mathematical arguments, not proof-assistant certificates. This manuscript has not undergone external peer review.

## Abstract

We characterize the attainable concentration of the total number of incorrect actions in binary sequential social learning. Each agent receives one conditionally independent private signal and can observe all preceding binary actions; the policy may be history dependent, time varying, randomized, and unconstrained by incentives. For an atomless symmetric signal experiment with lower receiver operating characteristic \(\mathcal R\), and any increasing unbounded concave gauge \(\phi\) with increments \(d_n\), a policy with \(\mathbb E\exp(\lambda\phi(W))< \infty\) for some \(\lambda>0\) exists if and only if \(\sum_n\mathcal R(cd_n)< \infty\) for some \(c>0\). A deterministic policy using only the current action and its run length attains every feasible gauge. The proof combines a permanent-action path comparison with convex majorization and a regenerative construction. It implies a primitive efficiency dichotomy: some positive moment is attainable exactly when \(\int_0^\epsilon\log(1/F(x))\,dx< \infty\), and then one policy attains every positive moment. We derive sharp power and Gaussian concentration boundaries, including both logarithmic equality cases, and realize them using a single stationary perceived experiment. Finally, strictly positive smooth experiments show that arbitrarily small relative entropy in both directions can preserve almost-sure eventual correctness and all fixed-origin run moments while destroying every positive moment of total errors. The distinction between the number of runs and their random starting beliefs is essential.

## 1. Scope and contributions

The central object is the undiscounted cumulative error count \(W\), rather than a terminal agent's error probability, a belief-convergence rate, or discounted welfare. Throughout, a new agent acts once, its private signal is conditionally independent of all earlier signals, and information travels only through binary actions. A planner may prescribe arbitrary action policies using this history, but neither the planner nor another agent sees past raw private signals. Public and private randomization must be independent of the state before signals are observed.

**The contribution is a necessary-and-sufficient ROC criterion for every concave exponential gauge of total errors, valid over all causal binary-action policies, together with attaining policies, a primitive logarithmic efficiency boundary, and a smooth two-way-KL counterexample separating eventual learning from all welfare moments.**

The universal policy theorem does not impose Bayesian rationality or incentive compatibility. We separately prove that, for power-tail and Gaussian experiments, a single fixed Bayes-consistent perceived signal law attains the sharp concentration frontiers. This more restrictive realization is useful because it retains the homogeneous misspecification model of [1]. The counterexample also stays within that model. No result here covers agents that repeatedly accumulate private signals, extra state-related public messages, nonbinary states, or conditionally dependent signals.

All inherited ingredients are kept distinct from the claimed increment. Likelihood-ratio testing, convex majorization, geometric regeneration, belief overturning, and run decompositions are classical. The new statements concern their exact combination for cumulative-error feasibility and the failure of fixed-origin run criteria under random unbounded reversals.

### 1.1 Experiment

Let \(F\) be an atomless probability law on \((0,1)\), symmetric about \(1/2\). The private signal coordinate \(Q\) is its neutral-prior posterior. Conditional on the state \(\theta\in\{h,\ell\}\),

\[
 P_h(dq)=2q\,F(dq),\qquad P_\ell(dq)=2(1-q)\,F(dq).
\tag{1.1}
\]

Both are probability laws; they are mutually absolutely continuous. A density is not required, and support gaps are permitted. Put \(A(x)=P_\ell(Q\le x)\) and \(C(x)=P_h(Q\le x)\). The lower ROC curve is

\[
 \mathcal R(a)=C(A^{-1}(a)),\qquad 0\le a\le1.
\tag{1.2}
\]

Because \(A\) is continuous and takes every value in \([0,1]\), an appropriate generalized quantile exists. Its choice on a flat interval is immaterial: that interval also carries no \(P_h\) mass. The curve is continuous, increasing and convex, with \(\mathcal R(0)=0\), \(\mathcal R(1)=1\), and \(\mathcal R(a)>0\) when \(a>0\).

At date \(t\), agent \(t\) uses its own signal, the past binary action history, and allowed randomization to choose \(a_t\in\{h,\ell\}\). Conditional signals are iid. Set

\[
 W=\sum_{t\ge1}\mathbf1_{\{a_t\ne\theta\}}
 \in\mathbb N_0\cup\{\infty\}.
\tag{1.3}
\]

Every assertion about both conditional states is equivalent to the corresponding integrability assertion under a fixed nondegenerate prior. The construction below works for every such prior; moment constants need not be uniform over priors approaching zero or one.

### 1.2 Gauges and the exact frontier

A gauge is a finite-valued increasing unbounded sequence \(\phi:\mathbb N_0\to[0,\infty)\), with \(\phi(0)=0\), whose increments

\[
 d_n=\phi(n)-\phi(n-1)>0
\tag{1.4}
\]

are nonincreasing. We set \(\phi(\infty)=\infty\). The term concave always refers to this discrete condition, unless a real-variable extension is explicitly used. Gauges slower than \(\log n\) are allowed.

**Theorem 1 (complete policy frontier).** The following three statements are equivalent:

1. There are a causal binary-action policy and \(\lambda>0\) such that \(\mathbb E_\theta e^{\lambda\phi(W)}< \infty\) for both states.
2. For some \(c>0\) with \(cd_1< 1\),
   \[
   \sum_{n\ge1}\mathcal R(cd_n)< \infty.
   \tag{1.5}
   \]
3. Such a moment is attained by a symmetric deterministic cutoff policy depending only on the current action and its current run length.

The constants \(c\) and \(\lambda\) are existential and need not be equal. This is a result about one infinite-horizon policy; it does not optimize a different policy separately for each terminal horizon.

### 1.3 A primitive efficiency dichotomy

**Theorem 2 (logarithmic efficiency boundary).** Assume \(F(x)>0\) for every \(x>0\). The following are equivalent:

1. Some causal binary-action policy has \(\mathbb E_\theta W^p< \infty\) for both states and some \(p>0\).
2. For one, equivalently every sufficiently small, \(\epsilon>0\),
   \[
   \int_0^\epsilon\log\frac1{F(x)}\,dx< \infty.
   \tag{1.6}
   \]
3. One deterministic policy has \(\mathbb E_\theta W^p< \infty\) for both states and every \(p>0\).

If \(F\) vanishes on an endpoint neighborhood, interpret the integral as infinite; no policy has a positive moment finite in both states. Thus failure of (1.6) rules out even a single positive unconditional welfare moment under any policy. It does not rule out almost-sure eventual correctness with a heavier error-count tail.

For example, a continuous symmetric law with \(F(x)\asymp\exp(-x^{-s})\) near zero admits all positive moments under a suitable policy precisely when \(0< s< 1\). At \(s=1\), replacing \(x^{-1}\) by \([x(\log(1/x))^\gamma]^{-1}\) makes the boundary \(\gamma>1\). These are genuine CDF tails: each is increasing near zero and can be reflected and filled through the middle. They illustrate the complete criterion; they are not separate mechanisms.

### 1.4 Sharp concentration and a robustness failure

For \(F(x)\asymp x^\alpha\), \(\alpha>0\), Theorem 1 becomes \(\sum_n d_n^{(\alpha+1)/\alpha}< \infty\). In particular the supremal stretched-exponential power is \(1/(\alpha+1)\), and that uncorrected endpoint is unattainable. Section 5 gives both critical logarithmic corrections. For Gaussian private log likelihoods, Section 6 gives a different exact frontier with leading gauge \(\exp(\sqrt{2v\log n})\). Appendix A proves attainment of these sharp boundaries by one stationary perceived experiment, with arbitrarily small total-variation changes from any fixed full-endpoint-support perceived law.

The final theorem addresses a different question: stability at a fixed perceived experiment, rather than existence of a favorable policy.

**Theorem 3 (two-way-KL instability without loss of eventual learning).** There is a fixed true symmetric experiment with strictly positive \(C^\infty\) conditional log-likelihood densities, and a sequence of perceived experiments with the same properties, such that for \(\theta=h,\ell\),

\[
 D(P_\theta\Vert\widetilde P_\theta^{(R)})\to0,
 \qquad D(\widetilde P_\theta^{(R)}\Vert P_\theta)\to0.
\tag{1.7}
\]

Under correct specification, total errors have every positive moment finite. Under each perceived experiment, actions are eventually correct almost surely, the number of wrong runs has a geometric tail, and every wrong run started at any fixed finite aligned belief has all positive moments finite; nevertheless \(\mathbb E_\theta W^p=\infty\) for every \(p>0\). These conclusions hold for every nondegenerate prior. The relative entropies in (1.7) compare private-signal experiments, not complete action-history laws.

Appendix B gives the full construction. It also verifies the local step and quadrature assumptions used in fixed-origin integral tests. Thus a bounded-reset assumption cannot simply be deleted from those tests. The construction exploits rare reversals that start subsequent wrong runs at increasingly extreme beliefs; it does not create a positive probability of permanent incorrect learning.

## 2. Related work and precise comparison

Rosenberg and Vieille [2] study efficiency under rational social learning and compare observing the full action history with observing only the preceding action. Their earlier author manuscript [3], Section 3.3 and Theorem 8, constructs planner cutoff policies with finite expected errors under a polynomial lower-tail condition. Theorem 2 above replaces that sufficient tail class by a necessary-and-sufficient logarithmic primitive condition and gives the simultaneous all-positive-moment implication. Theorem 1 classifies arbitrary concave concentration gauges. These claims do not subsume the observation-structure comparison in [2]. The final main text of [2] remains unavailable in full in the present literature check; its official supplement and [3] were inspected. No theorem-by-theorem priority certification for the inaccessible final text is asserted.

Arieli et al. [1] analyze the same homogeneous model of correctly interpreting one's own signal while misspecifying others' signals. Their power-tail theorem already establishes that mild condescension can make learning efficient. Their deterministic paths, overturning and regenerative arguments are inherited. The stationary constructions here identify attainable concentration boundaries over all admissible policies, including logarithmic endpoints, and then show that one coherent perceived law attains those boundaries.

Frick, Iijima and Ishii [4] give general tools for convergence under misspecified learning. Their final published statements and appendices were inspected, including the relaxed continuity discussion following Theorem 2. Accordingly, failure of a boundary continuity assumption is not treated here as evidence that qualitative stability methods are unavailable. Theorem 3 instead preserves eventual correct learning and compares all positive cumulative-error moments under arbitrarily small two-way KL misspecification.

Their separate studies of social-learning fragility [8] and welfare comparisons for biased learning [9] are also close precedents. The former shows that small misspecifications can radically change long-run beliefs in a model with heterogeneous preferences and a richer state space. The latter compares dynamic welfare for a single agent directly observing repeated iid signals, including biases with the same limiting beliefs and examples in which a smaller bias performs worse. Thus neither small-misspecification fragility nor the distinction between limiting beliefs and dynamic welfare is new here. Theorem 3's specific increment is the joint separation, in binary-action social transmission with a fixed true experiment, of two-way KL closeness, eventual correctness, geometric run counts and all fixed-origin run moments from every positive total-error moment. It does not deliver the decision-problem welfare ranking of [9].

Brandl [5] obtains information-aggregation barriers over arbitrary strategies in networks with agents that repeatedly receive private signals. His proof includes a positive-probability finite-history and permanent-action continuation comparison across states. This is a direct methodological predecessor of the necessity argument below. The difference claimed here is the one-shot sequential setting, cumulative-error objective, exact ROC series for every concave gauge, and matching construction. The shared path argument is not claimed as new. The inspected author version is identified separately from the verified journal metadata.

Tay, Tsitsiklis and Win [6] establish subexponential terminal-error limitations for long tandem networks in which each agent receives a message from its immediate predecessor. Their terminal decision problem, policy quantifiers and information graph differ from the all-history cumulative-error problem considered here. Brandl, Huang and Jain [7] study disclosure and transfer budgets under incentive constraints; the current policy theorem deliberately allows the planner to prescribe actions. It does not provide an incentive-compatible implementation or a subsidy budget theorem.

The source comparison is bounded. It does not certify global priority, external peer review, journal acceptance, or uniform robustness of the constructed policies. Classical testing, convexity and renewal arguments are used explicitly rather than counted as independent contributions.

## 3. Proof of the complete policy frontier

### 3.1 The one-step testing inequality

For any measurable randomized decision \(D:(0,1)\to[0,1]\),

\[
 \mathbb E_hD(Q)\ge\mathcal R(\mathbb E_\ell D(Q)).
\tag{3.1}
\]

To verify this directly, let \(a=\mathbb E_\ell D(Q)\in(0,1)\), select \(x\in(0,1)\) with \(A(x)=a\), and write \(L(q)=q/(1-q)\). Pointwise,

\[
 [L(q)-L(x)]\,[D(q)-\mathbf1_{\{q\le x\}}]\ge0.
\]

Integrating under \(P_\ell\), the term multiplying \(L(x)\) vanishes, and the remaining inequality is (3.1). The cases \(a=0,1\) follow by equivalence of the two conditional measures. Randomizing two cutoff tests shows convexity of the optimal value \(\mathcal R\); continuity also follows from the continuous conditional CDFs. Reflection gives the same curve for the reverse-state comparison. This is the usual likelihood-ratio testing argument, stated here to cover singular continuous laws and support gaps explicitly.

### 3.2 Necessity: a permanent-action path and weak majorization

First suppose the policy is deterministic. A finite exponential gauge moment implies \(W< \infty\) almost surely. In state \(h\), the event of eventual permanent \(h\) actions is the countable union, over finite binary histories \(z\), of events consisting of \(z\) followed by an infinite all-\(h\) continuation. Select a history for which this event has positive probability. Its finite-prefix probability \(p_\ell=P_\ell(z)\) in state \(\ell\) is also positive: the finite product signal measures in the two states are equivalent, and the same deterministic functions generate the actions.

Along the prescribed continuation, put

\[
 c_k=P_h(a_{m+k}=\ell\mid z h^{k-1}),\qquad
 a_k=P_\ell(a_{m+k}=\ell\mid z h^{k-1}),
\]

where \(m\) is the length of \(z\). Fresh-signal independence and (3.1) imply

\[
 \prod_{k\ge1}(1-c_k)>0,
 \qquad
 \sum_{k\ge1}\mathcal R(a_k)\le\sum_{k\ge1}c_k< \infty.
\tag{3.2}
\]

Hence \(a_k\to0\). Every \(a_k< 1\), since \(a_k=1\) would force \(c_k=1\) by equivalence and contradict the positive product.

In state \(\ell\), this same prefix followed by \(n\) high actions entails at least \(n\) mistakes. If \(M=\mathbb E_\ell e^{\lambda\phi(W)}< \infty\), Markov's inequality yields

\[
 p_\ell\prod_{k=1}^n(1-a_k)
 \le M e^{-\lambda\phi(n)}.
\tag{3.3}
\]

Therefore \(\sum_{k\le n}-\log(1-a_k)\ge\lambda\phi(n)-\log(M/p_\ell)\). Because \(-\log(1-a_k)\le2a_k\) for all sufficiently large \(k\), a finite constant \(K\) gives

\[
 \sum_{k\le n}a_k\ge(\lambda/2)\phi(n)-K.
\tag{3.4}
\]

Delete the zeros preceding the first positive \(a_k\), and call the resulting sequence \(x_k\). It still has \(\sum_k\mathcal R(x_k)< \infty\), and its partial sums satisfy (3.4) with the same or a smaller lower bound, since \(\phi\) is increasing. For large \(n\) they exceed \((\lambda/4)\phi(n)\). Every remaining initial partial sum is positive. Thus, by decreasing a positive constant to cover finitely many initial indices, there is \(\eta>0\), with \(\eta d_1< 1\), such that

\[
 \sum_{k=1}^n x_k\ge\eta\phi(n)=\sum_{k=1}^n\eta d_k
 \quad(n\ge1).
\tag{3.5}
\]

Fix \(N\). Sorting \(x_1,\ldots,x_N\) in decreasing order can only increase each initial partial sum. Since the sequence \((\eta d_k)\) is already decreasing, the sorted vector weakly majorizes \((\eta d_1,\ldots,\eta d_N)\). Consequently

\[
 \sum_{k=1}^N\mathcal R(x_k)
 \ge\sum_{k=1}^N\mathcal R(\eta d_k).
\tag{3.6}
\]

For completeness, this convex implication does not require equal total sums. For every \(t\ge0\), the sum \(\sum_k(x_k-t)_+\) is the maximum, over \(0\le j\le N\), of the first \(j\) sorted entries minus \(jt\). By (3.5) it dominates

\[
 \max_{0\le j\le N}\{\eta\phi(j)-jt\}
 =\sum_{k=1}^N(\eta d_k-t)_+.
\]

Represent the continuous increasing convex function \(\mathcal R\) as its nonnegative right derivative at zero times its argument, plus the integral of these positive-part functions against its nonnegative second-derivative measure. The partial-sum inequality at \(N\) controls the linear term. Integrating the displayed inequalities gives (3.6); all arguments lie strictly below one, so endpoint derivative issues are irrelevant. Letting \(N\to\infty\) proves (1.5).

For a randomized policy, collect its public and private exogenous randomization into a seed \(U\) independent of the state and all private signals. Conditional on a seed, all prescribed action functions are deterministic, and the signals retain their original conditional iid laws. Finiteness of the two unconditional gauge moments implies finiteness of both conditional moments for almost every common seed. Choose one such seed and apply the deterministic argument. The resulting \(\eta\) need not be uniform in the seed, because (1.5) is existential. This covers correlated and history-dependent use of state-independent randomization without introducing a state-related side channel.

### 3.3 Sufficiency: an attaining run-age cutoff policy

Suppose (1.5) holds. Decrease \(c\) so that \(a_n=cd_n\le1/2\) for all \(n\); monotonicity of \(\mathcal R\) preserves convergence. Choose \(x_n\) with \(A(x_n)=a_n\). At the first date use the cutoff \(1/2\). After a run of \(h\) actions of length \(n\), switch to \(\ell\) exactly when \(Q\le x_n\); after a run of \(\ell\) actions of length \(n\), switch to \(h\) exactly when \(Q\ge1-x_n\). At each switch the run length resets to one.

Under either state a wrong run switches at age \(n\) with probability \(a_n\), and a correct run switches with probability \(\mathcal R(a_n)\). A wrong-run length \(L\), including its first action, therefore satisfies

\[
 P(L>n)=\prod_{k=1}^n(1-a_k)\le e^{-c\phi(n)},\qquad n\ge0.
\tag{3.7}
\]

Because \(\sum_n a_n=c\phi(\infty)=\infty\), every wrong run terminates almost surely. Each correct run is permanent with the same probability

\[
 \delta=\prod_{n\ge1}(1-\mathcal R(a_n))>0.
\tag{3.8}
\]

The correct-run failure count has a geometric bound.

For every \(0< \lambda< c\), a wrong run has \(M(\lambda)=\mathbb E e^{\lambda\phi(L)}< \infty\). An exact tail sum proves this even when \(\phi\) grows more slowly than \(\log n\):

\[
 M(\lambda)=1+\sum_{n\ge0}
 [e^{\lambda\phi(n+1)}-e^{\lambda\phi(n)}]P(L>n).
\tag{3.9}
\]

Since the gauge increments are bounded by \(d_1\),

\[
 [e^{\lambda\phi(n+1)}-e^{\lambda\phi(n)}]e^{-c\phi(n)}
 \le\lambda e^{cd_1}
 \int_{\phi(n)}^{\phi(n+1)}e^{-(c-\lambda)y}\,dy.
\tag{3.10}
\]

The integration intervals partition \([0,\infty)\). This gives finiteness and, by dominated convergence at any fixed \(\lambda_0< c\), \(M(\lambda)\to1\) as \(\lambda\downarrow0\).

Discrete concavity with \(\phi(0)=0\) implies subadditivity: summing decreasing increments gives \(\phi(j+k)\le\phi(j)+\phi(k)\). Conditional on the state, fresh signals after each run give a regenerative construction with the same wrong-run law and the same permanent-correct-run probability. More explicitly, iterated conditioning on run endpoints bounds the exponential cost of the first \(j\) wrong runs by \(M(\lambda)^j\), multiplied by \((1-\delta)^{j-1}\) for reaching those runs. Hence

\[
 \mathbb E e^{\lambda\phi(W)}
 \le1+\sum_{j\ge1}(1-\delta)^{j-1}M(\lambda)^j< \infty
\tag{3.11}
\]

when \(\lambda>0\) is small enough that \((1-\delta)M(\lambda)< 1\). This completes Theorem 1.

## 4. Proof of the logarithmic efficiency boundary

Apply Theorem 1 to \(\phi(n)=\log(n+1)\). Its increments are \(d_n=\log(1+1/n)\asymp1/n\). Monotonicity of \(\mathcal R\), the integral test, and a change of variables show that for every fixed \(c>0\),

\[
 \sum_{n\text{ large}}\mathcal R(c/n)< \infty
 \quad\Longleftrightarrow\quad
 \int_0^{a_0}\frac{\mathcal R(a)}{a^2}\,da< \infty.
\tag{4.1}
\]

Convergence is independent of the positive scale \(c\). The equivalence uses only a tail of the series, where \(c/n\le1\); no expression is evaluated outside the ROC domain.

Choose \(\epsilon\in(0,1/2)\) and \(a_0=A(\epsilon)>0\). Tonelli's theorem applied to \(\mathcal R(a)=\int_{(0,a]}d\mathcal R(s)\) gives the extended-value identity

\[
 \int_0^{a_0}\frac{\mathcal R(a)}{a^2}\,da
 =\int_{(0,a_0]}\left(\frac1s-\frac1{a_0}\right)d\mathcal R(s)
 =2\int_{(0,\epsilon]}x
 \left(\frac1{A(x)}-\frac1{a_0}\right)dF(x).
\tag{4.2}
\]

The last equality is the change of variables through the continuous conditional CDF and the relation \(dC(x)=2x\,dF(x)\). It remains valid for a singular continuous \(F\) and for support gaps. Since

\[
 2(1-\epsilon)F(x)\le A(x)\le2F(x),\qquad0< x\le\epsilon,
\]

the finiteness of (4.2) is equivalent to \(\int_{(0,\epsilon]}x\,dF(x)/F(x)< \infty\). The continuous Stieltjes chain rule gives \(d\log F=dF/F\) on compact subintervals of \((0,\epsilon]\). A second Tonelli identity, followed by monotone convergence, gives

\[
 \int_0^\epsilon\log\frac{F(\epsilon)}{F(x)}\,dx
 =\int_{(0,\epsilon]}x\,d\log F(x).
\tag{4.3}
\]

No unverified endpoint term from integration by parts is used. This proves the equivalence of (1.6) with the existence of some positive moment. If the endpoint support is bounded away from zero, the likelihood ratio on that side is bounded below by a positive constant. Then \(\mathcal R(a)\ge\kappa a\), and every series in (4.1) diverges, as does the stated primitive integral.

It remains to produce one policy with every positive moment when (4.1) converges. For each positive integer \(k\), choose increasing integers \(N_k\), with \(N_k\ge2k\), such that

\[
 \sum_{n\ge N_k}\mathcal R(k/n)\le2^{-k}.
\tag{4.4}
\]

This is possible by (4.1). On \(N_k\le n< N_{k+1}\), prescribe the wrong-run switch probability \(a_n=k/n\); use any fixed probabilities in \((0,1/2]\) for the finite initial indices. The cutoff is selected through \(A^{-1}\), and reflected for the opposite action, exactly as in Theorem 1. This run-age sequence need not be monotone; monotonicity is not a restriction on the policy class.

Equation (4.4) implies \(\sum_n\mathcal R(a_n)< \infty\), so each correct run has a uniform positive probability of being permanent. For every \(K>0\), the inequalities \(a_n\ge K/n\) hold for all sufficiently large \(n\). Consequently

\[
 \frac{\sum_{j=1}^na_j}{\log n}\longrightarrow\infty,
 \qquad
 \Pr(L>n)\le\exp\left(-\sum_{j=1}^na_j\right).
\tag{4.5}
\]

The length \(L\) of a wrong run has all positive moments. There are geometrically many wrong runs. For \(0< p\le1\), subadditivity controls the moment of their sum. For \(p>1\), choose \(z\in(0,1)\) close enough to one that \((1-\delta)z^{1-p}< 1\), where \(\delta\) is the uniform permanent-correct-run probability. Weighted Holder gives

\[
 \left(\sum_{j\ge1}L_j\right)^p
 \le\left(\sum_{j\ge1}z^j\right)^{p-1}
 \sum_{j\ge1}z^{j(1-p)}L_j^p.
\tag{4.6}
\]

At the start of each wrong run its conditional \(p\)-moment is the same finite number, while the probability that it is reached is geometrically bounded. Taking expectations in (4.6) proves the result for each \(p>1\). The policy did not depend on \(p\), so all moments are finite under that single policy. This completes Theorem 2.

## 5. Power-tail experiments: the exact concentration threshold

Assume

\[
 c_-x^\alpha\le F(x)\le c_+x^\alpha
 \quad\text{for all sufficiently small }x>0,
 \qquad\alpha>0.
\tag{5.1}
\]

No density or limiting tail constant is required. The inequalities \(A(x)\asymp x^\alpha\) follow directly from (1.1). For the lower bound on \(C\), choose \(z\in(0,1)\) with \(c_+z^\alpha\le c_-/2\). Then

\[
 C(x)\ge2zx[F(x)-F(zx)]\ge zc_-x^{\alpha+1}.
\]

The upper bound \(C(x)\le2xF(x)\) is immediate. Thus

\[
 \mathcal R(a)\asymp a^q,\qquad
 q=\frac{\alpha+1}{\alpha}>1.
\tag{5.2}
\]

**Corollary 4 (all concave gauges for power tails).** Under (5.1), a policy has a finite exponential \(\phi\)-moment for some positive coefficient if and only if

\[
 \sum_{n\ge1}[\phi(n)-\phi(n-1)]^q< \infty.
\tag{5.3}
\]

For the gauges in the following table, modify only a bounded initial interval to obtain an increasing concave gauge with value zero at zero. Such a modification changes neither the series convergence nor existence of a positive exponential moment. Put

\[
 \beta_*=(\alpha+1)^{-1},\qquad
 \gamma_*=\alpha/(\alpha+1),
 \qquad
 \phi(n)=\frac{n^\beta}{(\log n)^\gamma(\log\log n)^\zeta},\quad0< \beta< 1.
\tag{5.4}
\]

| Parameters | Finite \(\mathbb E e^{\lambda\phi(W)}\) achievable for some \(\lambda>0\) |
|---|---|
| \(\beta< \beta_*\) | Yes, for all \(\gamma,\zeta\) |
| \(\beta>\beta_*\) | No |
| \(\beta=\beta_*,\ \gamma>\gamma_*\) | Yes, for all \(\zeta\) |
| \(\beta=\beta_*,\ \gamma< \gamma_*\) | No |
| \(\beta=\beta_*,\ \gamma=\gamma_*\) | Yes exactly when \(\zeta>\gamma_*\) |

Indeed the increments are asymptotic to \(\beta\phi(n)/n\), and (5.3) is the usual power-log-loglog summability test. In particular no admissible policy has \(\mathbb E e^{\lambda W^{\beta_*}}< \infty\) under a nondegenerate prior for any \(\lambda>0\). The negative claims concern all causal binary-action policies, even when incentives are absent. The positive claims in this table can be attained by one stationary perceived experiment, as proved in Appendix A.

## 6. Gaussian experiments: a different sharp endpoint

Let the true private log-likelihood ratio satisfy

\[
 Z\mid h\sim N(v/2,v),\qquad
 Z\mid\ell\sim N(-v/2,v),\qquad v>0.
\tag{6.1}
\]

Writing \(\bar\Phi=1-\Phi\), its ROC is exactly

\[
 \mathcal R(a)=\bar\Phi(\bar\Phi^{-1}(a)+\sqrt v).
\tag{6.2}
\]

For \(z=\bar\Phi^{-1}(a)\), the normal-tail estimates give

\[
 \frac{\mathcal R(a)}a
 =\frac z{z+\sqrt v}
 \exp(-\sqrt v z-v/2)(1+O(z^{-2})).
\]

The quantile expansion has \(z=\sqrt{2\log(1/a)}+o(1)\). Therefore

\[
 \mathcal R(a)=a\exp\{-\sqrt{2v\log(1/a)}-v/2\}(1+o(1)).
\tag{6.3}
\]

In particular \(\mathcal R(ca)/\mathcal R(a)\to c\) for every fixed \(c>0\). Consider

\[
 \phi(n)=\frac{\exp(\kappa\sqrt{\log n})}
 {(\log n)^\gamma(\log\log n)^\zeta},\qquad\kappa>0,
\tag{6.4}
\]

again with a finite initial concave extension. Such an extension exists because the displayed function is eventually increasing and strictly concave, with a positive derivative tending to zero. Its increments satisfy

\[
 d_n\sim\frac\kappa2\frac{\phi(n)}{n\sqrt{\log n}}.
\tag{6.5}
\]

For \(t=\log n\),

\[
 \log(1/d_n)=t-\kappa\sqrt t+(\gamma+1/2)\log t
 +\zeta\log\log t+O(1),
\]

so

\[
 \sqrt{2v\log(1/d_n)}
 =\sqrt{2v}\sqrt t-\kappa\sqrt{2v}/2+o(1).
\]

Substitution in (6.3) yields, for each fixed \(c>0\),

\[
 \mathcal R(cd_n)\asymp
 \frac{\exp[(\kappa-\sqrt{2v})\sqrt{\log n}]}
 {n(\log n)^{\gamma+1/2}(\log\log n)^\zeta}.
\tag{6.6}
\]

**Corollary 5 (Gaussian sharp concentration).** A finite exponential moment of the gauge (6.4) is achievable exactly in the following parameter region:

| Parameters | Achievable |
|---|---|
| \(\kappa< \sqrt{2v}\) | Yes, for every \(\gamma,\zeta\) |
| \(\kappa>\sqrt{2v}\) | No |
| \(\kappa=\sqrt{2v},\ \gamma>1/2\) | Yes, for every \(\zeta\) |
| \(\kappa=\sqrt{2v},\ \gamma< 1/2\) | No |
| \(\kappa=\sqrt{2v},\ \gamma=1/2\) | Yes exactly when \(\zeta>1\) |

Theorem 1 and the integral test prove both directions, including failure at the final equality \(\zeta=1\). Appendix A also realizes every affirmative entry by a single fixed perceived distribution. The result concerns the number of wrong actions, not elapsed time to the final wrong action. These variables need not have the same integrability.

## 7. Interpretation and limits

Theorems 1 and 2 separate the private experiment's informational limits from restrictions imposed by an individual action policy. A planner can sometimes restore every polynomial welfare moment even when rational learning is inefficient, but it cannot exceed the ROC concentration frontier. This does not identify an incentive-compatible optimum, a minimal expected error constant, or a policy robust to estimation error in the private experiment.

The stationary constructions show pointwise attainability arbitrarily near a given perceived experiment in total variation. Their allowable moment coefficient and welfare constants can deteriorate as the altered tail moves farther out. They do not give uniform performance over any neighborhood. Theorem 3 establishes a stronger contrasting obstruction for a fixed true experiment: even two-way KL closeness and unchanged eventual correctness do not control a single positive cumulative-error moment.

The proof of Theorem 3 and its positive weighted-reversal lemma are in Appendix B. Supporting finite algebra checks are diagnostics of stated finite computations, not substitutes for the infinite-horizon arguments. The literature comparison is limited to the identified sources and versions. The policy feasibility theorem preserves the distinction between endogenous misspecified Bayesian updating and an externally prescribed policy.

## Appendix A. Stationary perceived experiments attaining concentration bounds

This appendix constructs a single perceived signal experiment that attains
the concentration frontiers for power posterior tails and Gaussian private
log-likelihood ratios. The agents correctly interpret their own signals and
use the same perceived experiment to interpret all preceding actions. The
construction therefore belongs to a narrower class than the causal policies
in Theorem 1.

### A.1. Bayesian action dynamics and runs

Let \(F\) be a continuous probability distribution on \([0,1]\), symmetric
under \(x\mapsto1-x\), with no endpoint atoms and with positive probability
in every endpoint neighborhood. The signal coordinate \(Q\) is the private
posterior under the neutral prior. Its true conditional distributions are

\[
 F_h(x)=2\int_{[0,x]}t\,dF(t),\qquad
 F_\ell(x)=2\int_{[0,x]}(1-t)\,dF(t).
 \tag{A.1}
\]

The same construction from a continuous symmetric distribution
\(\widetilde F\), also with positive endpoint tails and no endpoint atoms,
defines the perceived conditional distributions \(\widetilde F_h\) and
\(\widetilde F_\ell\). Both pairs are probability distributions, and their
likelihood ratio at signal coordinate \(x\in(0,1)\) is \(x/(1-x)\). Thus the
perceived tails below specify coherent experiments, rather than independent
assignments of transition probabilities.

Fix a nondegenerate prior \(\pi\in(0,1)\). Conditional on the true state,
private signals are iid with the true conditional law. If \(r\) denotes the
perceived public log odds, an agent chooses \(h\) precisely when its correctly
interpreted private posterior exceeds \(q(r)=(1+e^r)^{-1}\). Ties have
probability zero. The agent updates the public log odds from actions using
the perceived experiment. Define, for \(r\ge0\),

\[
 \begin{aligned}
 u(r)&=\log\frac{1-\widetilde F_h(q(r))}
                    {1-\widetilde F_\ell(q(r))},\\
 b(r)&=-\log(1-F_\ell(q(r))),\\
 g(r)&=-\log(1-F_h(q(r))).
 \end{aligned}
 \tag{A.2}
\]

The same expression for \(u\) is defined at every finite real \(r\). A high
action and a low action update the public log odds by

\[
 H(r)=r+u(r),\qquad L(r)=-H(-r),
 \qquad r_{\mathrm{initial}}=\log\frac\pi{1-\pi}.
 \tag{A.3}
\]

The conditional mean of the perceived likelihood ratio over
\(Q>q(r)\) strictly exceeds \(q(r)/(1-q(r))=e^{-r}\), because the upper tail
has positive mass strictly above the threshold. Consequently \(H(r)>0\).
The corresponding lower-tail argument gives \(L(r)< 0\). Thus, after every
action, the public log odds have the sign of that action. This is the
overturning property needed below.

On \([0,\infty)\), the functions \(u,b,g\) are positive, continuous and
nonincreasing. For \(b,g\) this follows from monotonicity of the CDFs. For
\(u\), the ratio inside the logarithm is the conditional mean of the
increasing likelihood ratio \(x/(1-x)\) under \(\widetilde F_\ell\), given
\(x>q(r)\). This mean increases with its truncation threshold, which decreases
with \(r\).

A high-action run beginning at aligned log odds \(s\ge0\) follows the
deterministic orbit

\[
 r_0(s)=s,\qquad r_{n+1}(s)=r_n(s)+u(r_n(s)).
 \tag{A.4}
\]

The orbit tends to infinity: a finite limit would have a strictly positive
increment by continuity of \(u\). In state \(\ell\), the high action is
wrong, and the survival probability of \(n\) further high actions is

\[
 S_s(n)=\exp\left\{-\sum_{k=0}^{n-1}b(r_k(s))\right\}.
 \tag{A.5}
\]

In state \(h\), the probability of the same continuation replaces \(b\) by
\(g\). Reflection gives the identical statements for low-action runs.

We will use a uniform bound for correct runs. On each orbit cell,
monotonicity and its length \(u(r_k)\) give

\[
 g(r_{k+1})
 \le\int_{r_k}^{r_{k+1}}\frac{g(r)}{u(r)}\,dr.
\]

Therefore, if \(\int_0^\infty g/u< \infty\), every correct run starting at
any aligned \(s\ge0\) has probability at least

\[
 \delta_0:=
 \exp\left[-g(0)-\int_0^\infty\frac{g(r)}{u(r)}\,dr\right]>0
 \tag{A.6}
\]

of continuing forever. This follows from
\(\sum_{k\ge0}g(r_k(s))\le g(s)+\int_s^\infty g/u\). If every wrong run
ends almost surely, successive correct-run attempts then show that eventual
correctness occurs almost surely. They also give a geometric upper bound on
the number of wrong runs, without requiring independence between their
lengths.

### A.2. Transfer of exponential gauge moments to total mistakes

Let \(\psi:[0,\infty)\to[0,\infty)\) be increasing, unbounded and concave,
with \(\psi(0)=0\). Its restriction to the nonnegative integers is sufficient
for this section. Let \(W\) be the total number of wrong actions.

**Lemma A.1 (run-to-total transfer).** Suppose every wrong run is finite
almost surely; after each wrong run the ensuing correct run is permanent
with conditional probability at least \(\delta>0\), uniformly in the past;
and the conditional lengths \(L_s\ge1\) of wrong runs, at their starts,
satisfy

\[
 \sup_s\mathbb E_s e^{c_0\psi(L_s)}< \infty
 \quad\text{for some }c_0>0.
 \tag{A.7}
\]

Then \(\mathbb E e^{c\psi(W)}< \infty\) for some \(c>0\). An initial correct
run or a finite collection of additional initial starting values does not
change this conclusion.

*Proof.* Put \(M(c)=\sup_s\mathbb E_s e^{c\psi(L_s)}\). For
\(0\le c\le c_0\), convexity of the exponential as a function of its
coefficient gives

\[
 1\le M(c)\le1+\frac c{c_0}(M(c_0)-1).
 \tag{A.8}
\]

Choose \(c>0\) so small that \((1-\delta)M(c)< 1\). Let \(V_m\) be the
supremum, over admissible histories at a wrong-run start, of the expectation
of the exponential of \(c\) times the sum of the next at most \(m\)
wrong-run gauge costs. Since \(V_{m-1}\ge1\), conditioning first at the end
of the current wrong run and then at the next wrong-run start yields

\[
 V_m\le M(c)\{\delta+(1-\delta)V_{m-1}\},
 \qquad V_0=1.
 \tag{A.9}
\]

The right-hand recurrence has a finite fixed point
\(M(c)\delta/[1-(1-\delta)M(c)]\ge1\). Thus \(V_m\) is uniformly bounded.
Monotone convergence gives a finite exponential moment of the sum of all
wrong-run gauge costs. Concavity and \(\psi(0)=0\) imply subadditivity:
for \(x,y\ge0\), each of \(\psi(x)\) and \(\psi(y)\) bounds its respective
proportion of \(\psi(x+y)\). Hence
\(\psi(W)\le\sum_j\psi(L_j)\), proving the result. All conditioning is
performed after fixing the true state. ∎

A useful sufficient condition for (A.7) is a uniform tail bound

\[
 \mathbb P_s(L_s>n)\le C e^{-a\psi(n)},\qquad n\ge0,
 \tag{A.10}
\]

with positive constants \(C,a\). This implication holds even for very slowly
growing gauges. Indeed, for \(0< c< a\), the exact tail-sum formula and
\(\psi(n+1)-\psi(n)\le\psi(1)\) give

\[
 \begin{aligned}
 \mathbb E_s e^{c\psi(L_s)}
 &=1+\sum_{n\ge0}
   (e^{c\psi(n+1)}-e^{c\psi(n)})\mathbb P_s(L_s>n),\\
 (e^{c\psi(n+1)}-e^{c\psi(n)})e^{-a\psi(n)}
 &\le c e^{a\psi(1)}
   \int_{\psi(n)}^{\psi(n+1)}e^{-(a-c)y}\,dy.
 \end{aligned}
 \tag{A.11}
\]

The integration intervals cover \([0,\infty)\), so their sum is finite.

### A.3. Absolute cell errors for deterministic belief paths

The Gaussian construction will require a bounded additive error in the
wrong-run cumulative hazard. A multiplicative comparison of cumulative
hazards would not justify its endpoint calculation.

**Lemma A.2 (cell comparison).** Let \(u,b\) be positive, continuous,
nonincreasing functions on \([0,\infty)\). Suppose

\[
 K:=\sup_{r\ge0}\frac{u(r)}{u(r+u(r))}< \infty,
 \qquad A(r):=-\log u(r),\qquad
 Q_b:=\int_{[0,\infty)}b(r)\,dA(r)< \infty.
 \tag{A.12}
\]

For an orbit (A.4), abbreviate \(u_k=u(r_k)\), \(b_k=b(r_k)\), and put
\(I_k=\int_{r_k}^{r_{k+1}}b/u\). Then

\[
 \begin{aligned}
 I_k-b_k&\ge-(b_k-b_{k+1}),\\
 I_k-b_k&\le
 K\int_{[r_k,r_{k+1}]}b(r)\,dA(r)
   +K\log K\,(b_k-b_{k+1}),
 \end{aligned}
 \tag{A.13}
\]

and consequently

\[
 \sum_{k\ge0}|I_k-b_k|
 \le(1+K\log K)b(s)
       +K\int_{[s,\infty)}b(r)\,dA(r)< \infty.
 \tag{A.14}
\]

With \(B(r)=\int_0^r b/u\), this implies

\[
 \sum_{k< n}b(r_k(s))
   =B(r_n(s))-B(s)+O(1),
 \tag{A.15}
\]

where the error is uniform on every compact set of starting points. It in
fact has a finite limit as \(n\to\infty\).

Moreover, if \(T(r)=1+\int_0^r1/u\), then

\[
 n\le T(r_n(s))-T(s)\le Kn.
 \tag{A.16}
\]

If \(u\) is differentiable eventually and \(u'(r)\to0\), then

\[
 T(r_n(s))/n\longrightarrow1,
 \tag{A.17}
\]

uniformly for \(s\) in any fixed compact interval.

*Proof.* Since the cell length is \(u_k\), monotonicity gives
\(b_{k+1}\le I_k\le b_k u_k/u_{k+1}\). Let
\(a_k=A(r_{k+1})-A(r_k)\in[0,\log K]\). The upper excess is at most
\(b_k(e^{a_k}-1)\le Kb_ka_k\), and

\[
 b_ka_k
 =\int_{[r_k,r_{k+1}]}b\,dA
   +\int_{[r_k,r_{k+1}]}(b_k-b(r))\,dA
 \le\int_{[r_k,r_{k+1}]}b\,dA
    +(\log K)(b_k-b_{k+1}).
\]

There are no endpoint atoms in \(dA\) because \(u\) is continuous. This
proves (A.13). Taking absolute values and summing telescopes the differences
\(b_k-b_{k+1}\), proving (A.14) and (A.15).

The same cell bounds with numerator one give
\(1\le\int_{r_k}^{r_{k+1}}1/u\le K\), proving (A.16). If \(u'\to0\),
the ratio \(u(r)/u(r+u(r))\to1\): for a tail bound \(|u'|\le\varepsilon< 1\),
the denominator is at least \((1-\varepsilon)u(r)\). Thus each tail cell has
\(\int1/u=1+o(1)\), and summation proves (A.17). Uniformity on compact
starting sets follows because all these orbits escape a bounded interval
in uniformly finitely many steps: while \(r_k\le R\), its increment is at
least \(u(R)>0\). The finite initial time offsets are uniformly bounded. ∎

### A.4. Power posterior tails without a density assumption

Assume the true distribution satisfies the two-sided condition

\[
 F(x)\asymp x^\alpha\quad(x\downarrow0),\qquad
 \alpha>0,\qquad Q_\alpha:=\frac{\alpha+1}{\alpha}.
 \tag{A.18}
\]

The notation \(\asymp\) means comparison by fixed positive constants. No
density or limiting tail constant is required.

**Theorem A.1 (stationary attainment for regularly varying gauges).** Let
\(\psi\) be eventually positive, continuously differentiable, increasing
and concave, and suppose

\[
 \frac{t\psi'(t)}{\psi(t)}\longrightarrow\delta\in(0,1),
 \qquad
 \int_1^\infty\left(\frac{\psi(t)}t\right)^{Q_\alpha}dt< \infty.
 \tag{A.19}
\]

There is a single continuous symmetric perceived distribution
\(\widetilde F\) such that, for every fixed nondegenerate prior, the induced
Bayesian action dynamics satisfy

\[
 W< \infty\quad\text{almost surely},\qquad
 \mathbb E_\theta e^{c\psi(W)}< \infty
 \quad(\theta=h,\ell)
 \tag{A.20}
\]

for some \(c>0\). The coefficient may depend on the prior. A change of
\(\psi\) on a bounded interval is understood in (A.20); it has no effect on
the existence of a positive coefficient.

*Proof.* The derivative condition in (A.19) implies regular variation with
index \(\delta\), by integrating the logarithmic derivative. For large \(t\)
define

\[
 \mathcal D(t)=\frac t{\psi(t)},\qquad
 N(r)=\mathcal D^{-1}(e^{\alpha r}),\qquad
 \lambda=\frac\alpha{1-\delta}.
 \tag{A.21}
\]

The function \(\mathcal D\) is eventually strictly increasing to infinity.
Differentiating its inverse yields

\[
 \frac{N'(r)}{N(r)}
 =\frac{\alpha}
 {1-N(r)\psi'(N(r))/\psi(N(r))}
 \longrightarrow\lambda>\alpha.
 \tag{A.22}
\]

For sufficiently small \(x\), prescribe the perceived neutral-posterior tail

\[
 \widetilde F(x)=\frac a{\mathcal D^{-1}(x^{-\alpha})},
 \qquad a>0.
 \tag{A.23}
\]

It is positive and increasing in \(x\), tends to zero at zero, and satisfies
\(x\widetilde F'(x)/\widetilde F(x)\to\lambda\). It can be joined to a
continuous symmetric distribution through the middle. The joining can be
chosen as in Section A.6.

We first record the true conditional-tail bounds. If
\(c_Fx^\alpha\le F(x)\le C_Fx^\alpha\), choose a fixed \(z\in(0,1)\)
such that \(C_Fz^\alpha\le c_F/2\). Then
\(F_h(x)\ge2zx(F(x)-F(zx))\ge zc_Fx^{\alpha+1}\), while
\(F_h(x)\le2xF(x)\). Also
\(2(1-x)F(x)\le F_\ell(x)\le2F(x)\). Therefore

\[
 b(r)\asymp e^{-\alpha r},\qquad
 g(r)\asymp e^{-(\alpha+1)r}.
 \tag{A.24}
\]

For the constructed perceived tail, Stieltjes integration by parts and
\(x\widetilde F'/\widetilde F\to\lambda\) give

\[
 \begin{aligned}
 \widetilde F_\ell(x)&\sim2\widetilde F(x),\\
 \widetilde F_h(x)
 &=2\left(x\widetilde F(x)-\int_0^x\widetilde F(t)dt\right)
 \sim\frac{2\lambda}{\lambda+1}x\widetilde F(x).
 \end{aligned}
 \tag{A.25}
\]

For example, the integral ratio follows directly by differentiating
\(\int_0^x\widetilde F(t)dt\) and \(x\widetilde F(x)\), both of which
tend to zero. It follows that

\[
 u(r)\sim\frac{2a}{N(r)},\qquad
 -\frac{u'(r)}{u(r)}\longrightarrow\lambda,
 \qquad u'(r)\longrightarrow0.
 \tag{A.26}
\]

Here replacing \(q(r)\) by \(e^{-r}\) has relative error tending to zero,
since their logarithms differ by \(O(e^{-r})\) and (A.22) bounds the
logarithmic derivative of \(N\).

Let \(T(r)=1+\int_0^r1/u\). Equations (A.22) and (A.26), or the ratio of
their derivatives, give \(T(r)\sim N(r)/(2a\lambda)\). The time conclusion
of Lemma A.2 consequently yields

\[
 T(r_n(s))/n\longrightarrow1,\qquad
 N(r_n(s))\sim2a\lambda n,
 \tag{A.27}
\]

uniformly for \(s\) in a compact interval. The local-ratio assumption used
for this time conclusion follows from \(u'\to0\) on the tail and positivity
and continuity on the remaining compact interval.
The other hypothesis of Lemma A.2 also holds: by (A.24) and (A.26),
\(\int b\,d[-\log u]\) has an exponentially integrable tail, and its
integral over a compact interval is finite.

By construction \(e^{-\alpha r}=\psi(N(r))/N(r)\). Combining this identity
with (A.24), (A.27), and regular variation gives

\[
 b(r_n(s))\asymp\frac{\psi(n)}n,\qquad
 g(r_n(s))\asymp
       \left(\frac{\psi(n)}n\right)^{Q_\alpha},
 \tag{A.28}
\]

uniformly on compact starting sets. Since \(\delta>0\), summation of
\(\psi(n)/n\) is comparable to \(\psi(n)\). This follows also by integrating
the eventually comparable derivative \(\psi'(t)\sim\delta\psi(t)/t\).
Thus, after absorbing finitely many initial terms, there are positive
constants such that

\[
 c_1\psi(n)\le\sum_{k< n}b(r_k(s))\le c_2\psi(n).
 \tag{A.29}
\]

In particular every wrong run ends almost surely, and its survival has the
uniform upper bound (A.10) on compact starting sets.

To obtain a permanent-correct-run bound uniform over all aligned starting
beliefs, use the change of variables \(t=N(r)\). Equations (A.24) and
(A.26) give the tail comparison

\[
 \begin{aligned}
 \int^\infty\frac{g(r)}{u(r)}dr
 &\asymp\int^\infty e^{-(\alpha+1)r}N(r)dr\\
 &=\frac1\alpha\int^\infty
       \left(\frac{\psi(t)}t\right)^{Q_\alpha}
       \left(1-\frac{t\psi'(t)}{\psi(t)}\right)dt< \infty.
 \end{aligned}
 \tag{A.30}
\]

The final factor tends to \(1-\delta>0\). Section A.1 therefore supplies
the uniform positive probability (A.6).

It remains to bound the starts of successive wrong runs. Symmetry gives
the aligned magnitude after a switch from a run of opposite magnitude \(r\):

\[
 H(-r)=-r+\log\frac{\widetilde F_\ell(q(r))}
                           {\widetilde F_h(q(r))}
 \longrightarrow\log\frac{\lambda+1}{\lambda}.
 \tag{A.31}
\]

The limit follows from (A.25) and \(q(r)e^r\to1\). Continuity on bounded
intervals shows that all post-switch magnitudes belong to one compact
interval. For the fixed initial prior, the possible first-action magnitudes
are the two finite numbers \(H(r_{\mathrm{initial}})\) and
\(H(-r_{\mathrm{initial}})\), so enlarging the compact interval includes
both states' first wrong runs.

The tail estimate (A.29), (A.11), and the uniform correct-run probability
now verify every assumption of Lemma A.1. An eventual concave gauge can be
extended to zero by a linear segment from a sufficiently large point:
\(t\psi'(t)/\psi(t)< 1\) ensures the joining slope is at least the
right-hand derivative there. This proves (A.20). ∎

For the usual power-logarithmic gauges

\[
 \psi(t)=t^\delta(\log t)^{-\gamma}(\log\log t)^{-\eta},
 \quad0< \delta< 1,
 \tag{A.32}
\]

one may equivalently prescribe, with a positive coefficient on a sufficiently
small tail interval,

\[
 \widetilde F(x)
 \asymp x^{\alpha/(1-\delta)}
       (\log(1/x))^{\gamma/(1-\delta)}
       (\log\log(1/x))^{\eta/(1-\delta)}.
 \tag{A.33}
\]

In particular, at \(\delta=1/(\alpha+1)\) the correct-run integral is
comparable to \(\int^\infty r^{-k}(\log r)^{-\ell}dr\), where
\(k=(\alpha+1)\gamma/\alpha\) and
\(\ell=(\alpha+1)\eta/\alpha\). Its sharp convergence criterion is
\(k>1\), or \(k=1\) and \(\ell>1\). This verifies stationary attainment
at the logarithmic boundaries supplied by Theorem 1, not only at strictly
subcritical stretched-exponential powers.

### A.5. Gaussian critical concentration bounds

Suppose the true private log-likelihood ratio satisfies

\[
 Z\mid h\sim N(v/2,v),\qquad
 Z\mid\ell\sim N(-v/2,v),\qquad v>0.
 \tag{A.34}
\]

Let \(a_v(r)=\mathbb P_\ell(Z\le-r)\) and
\(c_v(r)=\mathbb P_h(Z\le-r)\). Normal-tail integration by parts gives

\[
 a_v(r)\sim C_v r^{-1}e^{-r^2/(2v)+r/2},\qquad
 \frac{c_v(r)}{a_v(r)}\sim e^{-r},\qquad
 C_v=\frac{\sqrt v}{\sqrt{2\pi}}e^{-v/8}.
 \tag{A.35}
\]

In the notation of Section A.1, \(b\sim a_v\) and \(g\sim c_v\).

**Theorem A.2 (stationary Gaussian attainment).** For large \(t\), let

\[
 \psi(t)=\frac{\exp(\kappa\sqrt{\log t})}
                  {(\log t)^\gamma(\log\log t)^\eta},
 \qquad\kappa>0,\quad\gamma,\eta\in\mathbb R.
 \tag{A.36}
\]

A single continuous symmetric perceived experiment attains
\(\mathbb E_\theta e^{c\psi(W)}< \infty\), for both states and some \(c>0\),
for every fixed nondegenerate prior, in each of the following ranges:
\(\kappa< \sqrt{2v}\); or \(\kappa=\sqrt{2v}\) and \(\gamma>1/2\); or
\(\kappa=\sqrt{2v}\), \(\gamma=1/2\), and \(\eta>1\).

*Proof.* Put
\(D=\kappa/\sqrt{2v}\), \(k=2\gamma\), and \(\ell=\eta\). In the stated
ranges \(0< D\le1\). On a sufficiently small posterior-tail interval,
using the exact inverse \(r=\log((1-x)/x)\), prescribe

\[
 \widetilde F(x)=d\,a_v(r)e^{-Dr}r^k(\log r)^\ell,
 \qquad d>0.
 \tag{A.37}
\]

Choose the interval so that \(r>e\). The logarithmic derivative of this
profile with respect to \(r\) is \(-r/v+O(1)\), so it decreases in \(r\)
and increases in \(x\). It tends to zero at the endpoint and can be joined
and reflected to form the required distribution.

The induced perceived low-state tail is asymptotic to \(2\widetilde F(x)\),
and its high-state tail is negligible in comparison. Differentiating the
constructed profile and the exact conditional-tail integrals therefore gives

\[
 u(r)\sim2d\,a_v(r)e^{-Dr}r^k(\log r)^\ell,\qquad
 -\frac{u'(r)}{u(r)}=\frac rv+O(1),\qquad u'(r)\to0.
 \tag{A.38}
\]

In particular the local-ratio constant in (A.12) is finite. Moreover,
\(\int b\,d[-\log u]\) is finite, because its tail is bounded by a
constant times \(\int(1+r)b(r)dr\), and \(b\) has Gaussian decay. Lemma A.2
is thus applicable.

The primitive hazard ratios are

\[
 \frac{b(r)}{u(r)}\sim\frac1{2d}e^{Dr}r^{-k}(\log r)^{-\ell},\qquad
 \frac{g(r)}{u(r)}\sim\frac1{2d}e^{(D-1)r}r^{-k}(\log r)^{-\ell}.
 \tag{A.39}
\]

The correct-run integral is finite for \(D< 1\), for any real \(k,\ell\).
For \(D=1\), it is finite precisely when \(k>1\), or \(k=1\) and
\(\ell>1\), exactly the stated parameter ranges.

Define \(B(r)=\int_0^r b/u\) and \(T(r)=1+\int_0^r1/u\). Endpoint
integration, justified also by differentiation of the displayed equivalents,
gives

\[
 \begin{aligned}
 B(r)&\sim\frac1{2dD}e^{Dr}r^{-k}(\log r)^{-\ell},\\
 T(r)&\sim\frac v{2dC_v}
     e^{r^2/(2v)+(D-1/2)r}r^{-k}(\log r)^{-\ell}.
 \end{aligned}
 \tag{A.40}
\]

The polynomial power in the second line includes the factor \(1/r\)
from endpoint integration. It is required for the critical logarithmic
boundary.

By (A.15) and (A.17), uniformly on compact starting sets,

\[
 \sum_{j< n}b(r_j(s))=B(r_n(s))-B(s)+O(1),\qquad
 T(r_n(s))/n\longrightarrow1.
 \tag{A.41}
\]

Taking logarithms in (A.40) and inverting the quadratic term yields

\[
 r_n(s)=\sqrt{2v\log n}-v(D-1/2)+o(1).
 \tag{A.42}
\]

For clarity, the terms \(k\log r\) and \(\ell\log\log r\) in this
inversion change \(r\) by at most
\(O(\log\log n/\sqrt{\log n})=o(1)\); the multiplicative time error
in (A.41) has logarithm \(o(1)\). Thus these terms cannot produce a missing
unbounded shift in (A.42). Substituting (A.42) into the first line of (A.40)
gives a positive constant \(K_0\) such that

\[
 B(r_n(s))\sim K_0
 \frac{\exp(D\sqrt{2v\log n})}
 {(\log n)^{k/2}(\log\log n)^\ell}
 =K_0\psi(n).
 \tag{A.43}
\]

Consequently wrong-run survival obeys (A.10), uniformly for compact starting
sets, and every wrong run terminates almost surely.

To check the reset bound, observe from the constructed tail that
\(x\widetilde F'(x)/\widetilde F(x)\to\infty\). Differentiating numerator
and denominator shows
\(\int_0^x\widetilde F(t)dt/[x\widetilde F(x)]\to0\). The conditional-tail
identity in (A.25) therefore gives

\[
 \frac{\widetilde F_h(x)}{x\widetilde F_\ell(x)}\longrightarrow1,\qquad
 H(-r)\longrightarrow0.
 \tag{A.44}
\]

Continuity supplies the global bound on post-switch magnitudes. The initial
prior again contributes only the two finite starting values specified in
Section A.4. Equation (A.39) and (A.6) give a uniform positive probability
of a permanent correct run.

Finally, the gauge (A.36) is eventually increasing and concave. Its first
derivative is asymptotic to
\(\kappa\psi(t)/(2t\sqrt{\log t})>0\), and its second derivative is
asymptotic to \(-\kappa\psi(t)/(2t^2\sqrt{\log t})< 0\). It has an
increasing concave extension with value zero at zero. Applying (A.11) and
Lemma A.1 proves the desired moment bound for total mistakes. ∎

This perceived family changes the tail shape, rather than only the variance
parameter inside the Gaussian family. Thus its attainment does not assert
that a misspecified Gaussian precision parameter has the same property.

### A.6. Realization arbitrarily close to a given perceived experiment

The tails in (A.23) and (A.37) can be prescribed while altering an arbitrarily
small portion of a baseline experiment.

**Proposition A.3 (tail splicing).** Let \(F_0\) be a continuous symmetric
baseline neutral-posterior distribution with no endpoint atoms and with
positive probability in every endpoint neighborhood. For each
\(\varepsilon>0\), each affirmative construction above can be realized by a
perceived distribution \(\widetilde F\) which agrees with \(F_0\) on a
central interval and whose neutral law is within total variation
\(\varepsilon\) of the baseline law. The induced conditional laws are within
total variation \(2\varepsilon\).

*Proof.* Let \(f(x)\) denote the positive increasing tail profile from the
chosen construction, without its arbitrary positive coefficient. Choose
\(x_0\in(0,1/2)\) small enough that the profile is defined and increasing
on \((0,x_0]\), and
\(0< m:=F_0(x_0)< \varepsilon/2\). This is possible by the baseline endpoint
assumptions. Define

\[
 \widetilde F(x)=
 \begin{cases}
  m f(x)/f(x_0),&0\le x\le x_0,\\
  F_0(x),&x_0\le x\le1-x_0,\\
  1-\widetilde F(1-x),&1-x_0\le x\le1.
 \end{cases}
 \tag{A.45}
\]

The definition is consistent at both joining points, increasing, continuous
and symmetric. It gives an actual atomless probability law with the required
endpoint tails. Multiplying the prescribed tail by a positive constant
changes none of the convergence criteria proved above, although the
available moment coefficient and finite constants can change.

Write \(\mu_0,\widetilde\mu\) for the neutral laws, with
\(\|\mu-\nu\|_{\mathrm{TV}}=\sup_E|\mu(E)-\nu(E)|\). The laws agree
on the central interval and give each endpoint interval the same mass \(m\).
On each tail the signed difference has positive and negative masses at most
\(m\). Hence

\[
 \|\widetilde\mu-\mu_0\|_{\mathrm{TV}}\le2m< \varepsilon,\qquad
 \|\widetilde P_\theta-P_{0,\theta}\|_{\mathrm{TV}}
 \le2\|\widetilde\mu-\mu_0\|_{\mathrm{TV}}
 < 2\varepsilon.
 \tag{A.46}
\]

The conditional-law bound follows by multiplying the neutral signed
measure by \(2x\) or \(2(1-x)\), each bounded by two; symmetry ensures that
both resulting conditional measures have total mass one. ∎

Proposition A.3 is an existence statement in every such total-variation
neighborhood. It makes no uniform claim about the admissible exponential
coefficient or the size of the resulting moment as the neighborhood shrinks.

## Appendix B. The smooth two-way-relative-entropy counterexample

### B.1. Model and notation

There are two states, \(h\) and \(\ell\). Conditional on the state, private signals are independent and identically distributed. We use the private log-likelihood ratio \(Z\) as the signal coordinate. The true conditional densities satisfy \(p_h(z)=e^zp_\ell(z)\), and the perceived conditional densities satisfy the same likelihood-ratio identity. Both experiments are symmetric: \(p_h(z)=p_\ell(-z)\), with the analogous identity for the perceived experiment. An agent interprets their own signal correctly but uses the common perceived experiment to infer the state from preceding actions. A fixed nondegenerate prior has finite public log odds \(r_\pi=\log(\pi/(1-\pi))\). At public log odds \(r\), the agent chooses \(h\) exactly when \(Z+r>0\). All laws constructed below have strictly positive smooth densities, so ties have probability zero.

For \(r\ge0\), put

\[
a(r)=P_\ell(Z\le-r),\qquad c(r)=P_h(Z\le-r),
\tag{B.1}
\]

and use tildes for the perceived tails. Define the perceived increment and the two true logarithmic hazards by

\[
u(r)=\log\frac{1-\widetilde c(r)}{1-\widetilde a(r)},\qquad
b(r)=-\log(1-a(r)),\qquad
g(r)=-\log(1-c(r)).
\tag{B.2}
\]

These functions are positive, continuous, and nonincreasing. The high-action update, defined for every real \(r\), and its symmetric low-action counterpart are

\[
H(r)=r+\log\frac{\widetilde P_h(Z>-r)}{\widetilde P_\ell(Z>-r)},
\qquad L(r)=-H(-r).
\tag{B.3}
\]

In particular \(H(r)=r+u(r)\) for \(r\ge0\). Bayes consistency and full support imply \(H(r)>0\) and \(L(r)< 0\) for every finite \(r\): the likelihood ratio conditional on \(Z>-r\) has mean strictly greater than \(e^{-r}\). Thus the public belief after an action is aligned with that action. The aligned belief after reversing an action at magnitude \(r\ge0\) is

\[
d(r):=H(-r)=-r+\log\frac{\widetilde a(r)}{\widetilde c(r)}>0.
\tag{B.4}
\]

For an aligned starting belief \(s\ge0\), let

\[
r_0(s)=s,\qquad r_{n+1}(s)=r_n(s)+u(r_n(s)),\qquad
S_s(n)=\exp\!\left[-\sum_{j=0}^{n-1}b(r_j(s))\right].
\tag{B.5}
\]

The orbit increases to infinity. The quantity \(S_s(n)\) is the survival probability of \(n\) further incorrect actions when the current action is incorrect and its aligned post-action belief is \(s\). If \(A_s\) is the number of those further incorrect actions before the first correct action, then \(P(A_s\ge n)=S_s(n)\); the complete incorrect-run length is \(L_s=1+A_s\). Let \(W\) denote the total number of incorrect actions and \(N\) the number of incorrect runs, allowing infinite values initially.

The continuous primitives are

\[
B(r)=\int_0^r\frac{b(x)}{u(x)}\,dx,\qquad
G(r)=\int_0^r\frac{g(x)}{u(x)}\,dx,\qquad
T(r)=1+\int_0^r\frac{dx}{u(x)}.
\tag{B.6}
\]

For \(p>0\), define

\[
J_p=\int_0^\infty T(r)^{p-1}e^{-B(r)}\frac{dr}{u(r)}.
\tag{B.7}
\]

We use the following conditions, with the integral in (Q) understood in the Lebesgue–Stieltjes sense:

\[
\begin{array}{ll}
\mathrm{(L)}&\displaystyle
\sup_{r\ge0}\frac{u(r)}{u(r+u(r))}< \infty,\\[4pt]
\mathrm{(Q)}&\displaystyle
\int_{[0,\infty)}b(r)\,d[-\log u(r)]< \infty,\\[4pt]
\mathrm{(R)}&\displaystyle
\sup_{r\ge0}d(r)< \infty.
\end{array}
\tag{B.8}
\]

The construction below satisfies (L), (Q), \(G(\infty)< \infty\), and every test \(J_p< \infty\), but fails (R). The resulting failure concerns total mistakes, even though every fixed-origin incorrect run has all positive moments.

### B.2. The separation theorem

**Theorem B.1.** There is one fixed symmetric binary experiment \((P_h,P_\ell)\), with strictly positive smooth log-likelihood densities on the whole real line, and a family of similarly regular perceived experiments \((\widetilde P_h^{(R)},\widetilde P_\ell^{(R)})\), such that

\[
D(P_\theta\Vert\widetilde P_\theta^{(R)})\longrightarrow0,
\qquad
D(\widetilde P_\theta^{(R)}\Vert P_\theta)\longrightarrow0,
\qquad \theta\in\{h,\ell\}.
\tag{B.9}
\]

For every fixed nondegenerate prior, the correctly specified model satisfies \(\mathbb E[W^p]< \infty\) for every \(p>0\). For each member of the perceived family, all of the following instead hold, conditional on either state and hence under the prior mixture:

1. Conditions (L) and (Q) hold, and
   
   \[
   G(\infty)< \infty,\qquad J_p< \infty\quad\text{for every }p>0.
   \tag{B.10}
   \]

2. Every incorrect run started at a fixed finite aligned belief has finite moments of every positive order.
3. Actions are eventually correct almost surely, and the number of incorrect runs has a geometric tail.
4. Nevertheless,
   
   \[
   \mathbb E[W^p]=\infty\quad\text{for every }p>0.
   \tag{B.11}
   \]

The true and perceived log-likelihood ratios also possess finite polynomial moments of every order. No constants controlling welfare moments are asserted to be uniform over the perceived family.

The point of this theorem is its joint separation, rather than the general observation that small misspecification can damage dynamic welfare. In comparison with the general dynamic-welfare fragility results of Frick, Iijima and Ishii (2024) [9], the construction keeps almost-sure eventual correctness, a geometrically controlled number of incorrect runs, and all fixed-origin run moments, while total mistakes lose every positive moment. Its two relative-entropy limits concern the private-signal experiments, not distributions of complete action histories. It does not turn qualitative failure of learning into an infinite welfare cost.

### B.3. A weighted condition that permits unbounded reversals

We first establish the positive result used to control the correctly specified benchmark. It also isolates the cost that bounded reversal hides.

For a fixed \(p>0\), define

\[
V_p(s)=e^{B(s)}T(s)^{(1-p)_+},\qquad
h_p(r)=c(r)V_p(d(r)),\qquad
\overline h_p(r)=\sup_{t\ge r}h_p(t).
\tag{B.12}
\]

The tail envelope is nonnegative, nonincreasing, and measurable. Consider the weighted reversal condition

\[
\overline h_p(0)< \infty,\qquad
\int_0^\infty\frac{\overline h_p(r)}{u(r)}\,dr< \infty.
\tag{B.13}
\]

**Proposition B.2.** Suppose (L), (Q), \(G(\infty)< \infty\), and \(J_p< \infty\) hold. If (B.13) holds, then \(\mathbb E[W^p]< \infty\) for every fixed nondegenerate prior. Condition (R) is not required.

**Proof.** Write \(T_s(r)=T(r)-T(s)+1\) for \(r\ge s\), and let \(K\ge1\) be the constant in (L). Lemma A.2, applies with an error bound controlled by \(b(0)\), \(K\), and the full integral in (Q). Its constants are therefore uniform over all \(s\ge0\); in particular \(S_s(n)\le C e^{B(s)-B(r_n(s))}\) with one such constant \(C\). On each cell \([r_n(s),r_{n+1}(s)]\), monotonicity and (L) give \(1\le\int dr/u(r)\le K\). At every point of this cell,

\[
n+1\le T_s(r)\le1+K(n+1),\qquad
0\le B(r)-B(r_n(s))\le Kb(0).
\]

Consequently

\[
T_s(r)^{p-1}\ge
\min\{1,(K+1)^{p-1}\}(n+1)^{p-1}.
\]

For \(p\ge1\) this uses the lower bound on \(T_s\); for \(0< p< 1\) it uses the upper bound, with the inequality reversed when the negative power is taken. Multiplying by \(e^{-B(r)}\) and integrating over the cell shows that its integral dominates a fixed positive multiple of \((n+1)^{p-1}e^{-B(r_n(s))}\). Finally, the exact tail identity (B.40), with \((n+1)^p-n^p\le C_p(n+1)^{p-1}\), gives

\[
\mathbb E[L_s^p]
\le C_p\left[1+e^{B(s)}
\int_s^\infty T_s(r)^{p-1}e^{-B(r)}\frac{dr}{u(r)}\right].
\tag{B.14}
\]

If \(p\ge1\), then \(T_s(r)^{p-1}\le T(r)^{p-1}\). If \(0< p< 1\), the identity

\[
T(s)T_s(r)-T(r)=(T(s)-1)(T(r)-T(s))\ge0
\tag{B.15}
\]

shows that \(T_s(r)^{p-1}\le T(s)^{1-p}T(r)^{p-1}\). Consequently

\[
\mathbb E[L_s^p]\le C_p(1+J_p)V_p(s),\qquad s\ge0.
\tag{B.16}
\]

Start a correct run at an arbitrary aligned belief \(s\). At its \(n\)th orbit value, the probability of the first incorrect action is its correct survival probability times \(c(r_n(s))\). The ensuing incorrect run starts at \(d(r_n(s))\). By conditional independence of future signals after that stopping time, (B.16) bounds the \(p\)th moment of this next incorrect run, set to zero if it never starts, by

\[
C_p(1+J_p)\sum_{n\ge0}c(r_n(s))V_p(d(r_n(s)))
\le C_p(1+J_p)\sum_{n\ge0}\overline h_p(r_n(s)).
\tag{B.17}
\]

For every nonnegative nonincreasing function \(v\), monotonicity of \(u\) on each orbit cell gives

\[
\sum_{n\ge0}v(r_n(s))
\le v(s)+\int_s^\infty\frac{v(r)}{u(r)}\,dr.
\tag{B.18}
\]

Indeed, the integral over \([r_n,r_{n+1}]\) is at least \(v(r_{n+1})\), because the cell length is \(u(r_n)\). Equations (B.13), (B.17), and (B.18) give a bound on the next incorrect-run \(p\)th moment that is uniform over the starting belief of the correct run.

Applying (B.18) to \(g\) shows that every correct run has probability at least

\[
\delta:=\exp[-g(0)-G(\infty)]>0
\tag{B.19}
\]

of continuing forever, uniformly over its starting belief. Moreover, (B.14) and \(J_p< \infty\) imply that every incorrect run starting at a finite belief ends almost surely. Thus the probability of reaching the \(j\)th correct-run attempt decreases geometrically. If \(Y_j\) is the subsequent incorrect-run length, set to zero when it does not occur, then \(\mathbb E[Y_j^p]\le C_p(1-\delta)^{j-1}\). A possible initial incorrect run has a fixed finite starting belief and finite \(p\)th moment.

For \(0< p\le1\), subadditivity now proves finiteness of the total moment. For \(p>1\), choose \(z\in(0,1)\) sufficiently close to one that \((1-\delta)z^{1-p}< 1\), and use

\[
\left(\sum_{j\ge1}Y_j\right)^p
\le\left(\sum_{j\ge1}z^j\right)^{p-1}
\sum_{j\ge1}z^{j(1-p)}Y_j^p.
\tag{B.20}
\]

Taking expectations finishes the proof. No independence between runs is assumed. \(\square\)

When (R) holds, \(V_p(d(r))\) is bounded and \(\overline h_p(r)\le C_pc(r)\le C_pg(r)\). Thus (B.13) follows from \(G(\infty)< \infty\). Proposition B.2 includes bounded reversal as a special case; it is only a sufficient condition and is not asserted to characterize all unbounded-reversal models.

### B.4. Bayes-consistent smooth signal generators

Let \(f:[0,\infty)\to(0,\infty)\) be integrable. Define

\[
Z_f=\int_0^\infty(1+e^{-x})f(x)\,dx,\qquad k_f=Z_f^{-1},
\tag{B.21}
\]

and set, for \(x\ge0\),

\[
p_{\ell,f}(-x)=k_ff(x),\qquad
p_{\ell,f}(x)=k_fe^{-x}f(x),\qquad
p_{h,f}(z)=e^zp_{\ell,f}(z).
\tag{B.22}
\]

Both conditional densities integrate to one, and \(p_{h,f}(z)=p_{\ell,f}(-z)\). The likelihood ratio is exactly \(e^z\). The induced neutral-prior posterior \(e^Z/(1+e^Z)\) therefore has a continuous CDF symmetric about \(1/2\). Its conditional tails are

\[
a_f(r)=k_f\int_r^\infty f(x)\,dx,\qquad
c_f(r)=k_f\int_r^\infty e^{-x}f(x)\,dx,
\qquad 0< c_f(r)\le e^{-r}a_f(r).
\tag{B.23}
\]

In particular, for all sufficiently large \(r\),

\[
\tfrac12\widetilde a(r)\le u(r)\le2\widetilde a(r),\qquad
a(r)\le b(r)\le2a(r),\qquad c(r)\le g(r)\le2c(r).
\tag{B.24}
\]

Fix a smooth cutoff \(\chi\) equal to zero on \([0,1]\), equal to one on \([2,\infty)\), and valued in \([0,1]\). The one true generator used throughout this appendix is

\[
f(x)=(1-\chi(x))e^{x/2-x^2}
+\chi(x)\frac{e^{-\sqrt{x+1}}}{2\sqrt{x+1}}.
\tag{B.25}
\]

It is strictly positive, smooth, and integrable. Near zero, the two branches in (B.22) combine into \(k_fe^{-z/2-z^2}\), so the conditional densities are smooth at zero as well. For \(r\ge2\), its tail is explicit.

To define the perceived tail, choose \(t_0\ge16\) and put

\[
t_{k+1}=t_k^3,\qquad
\mu_k=e^{-t_{k-1}^{3/4}},\quad k\ge1.
\tag{B.26}
\]

Let \(\psi\) be a nonnegative smooth function supported in \([0,1]\), positive on \((0,1)\), and with integral one. For example, one can normalize \(\exp[-1/(x(1-x))]\) on \((0,1)\) and set it to zero outside. Write

\[
\begin{aligned}
\zeta&=\int_0^1e^{-x}\psi(x)\,dx\in(e^{-1},1),\qquad
g_0(x)=e^{x/2-x^4},\\
\widetilde f(x)&=g_0(x)+\sum_{k\ge1}\mu_k\psi(x-t_k).
\end{aligned}
\tag{B.27}
\]

The sum is locally finite, the supports of its summands are disjoint, and \(\sum_k\mu_k< \infty\). Thus \(\widetilde f\) is positive, smooth, and integrable. Near zero, its conditional low-state density is a multiple of \(e^{-z/2-z^4}\), proving smoothness across zero. The positive baseline removes all support gaps. Moreover, for every fixed \(m>0\), \(\sum_k\mu_kt_k^m< \infty\), because \(t_{k-1}^{3/4}\) dominates \(3m\log t_{k-1}\). Both experiments therefore have finite polynomial log-likelihood moments of every order.

### B.5. Tail estimates and large reversals

For the fixed true generator in (B.25), there are constants \(C_1,c_1>0\) such that, for \(r\ge2\),

\[
\begin{aligned}
a(r)&=k_fe^{-\sqrt{r+1}},\\
c_1\frac{e^{-r-\sqrt{r+2}}}{\sqrt{r+2}}
&\le c(r)\le C_1e^{-r-\sqrt{r+1}}.
\end{aligned}
\tag{B.28}
\]

The lower bound follows by restricting the integral defining \(c\) to \([r,r+1]\); the upper bound follows from (B.23).

Put \(a_0(r)=\int_r^\infty g_0(x)\,dx\) and \(c_0(r)=\int_r^\infty e^{-x}g_0(x)\,dx\). On a gap \(t_k+1\le r\le t_{k+1}\), the perceived tails are exactly

\[
\begin{aligned}
\widetilde a(r)&=k_{\widetilde f}\left[a_0(r)+\sum_{j\ge k+1}\mu_j\right],\\
\widetilde c(r)&=k_{\widetilde f}\left[c_0(r)+\zeta\sum_{j\ge k+1}\mu_je^{-t_j}\right].
\end{aligned}
\tag{B.29}
\]

For large \(r\), endpoint integration gives \(a_0(r)+c_0(r)\le Ce^{-r^4/2}\). On the displayed gap, the ratio of this bound to the first bump contribution to the smaller tail \(\widetilde c\) is at most

\[
C\exp\left[-\tfrac12t_k^4+t_k^3+t_k^{3/4}\right]\longrightarrow0.
\tag{B.30}
\]

Consecutive bump masses have ratio tending to zero, so each sum in (B.29) lies between its first term and twice that term for all large \(k\). Together with (B.24), this proves, uniformly on the entire gap,

\[
\begin{aligned}
c_2\mu_{k+1}&\le u(r)\le C_2\mu_{k+1},\\
\left|d(r)-(t_{k+1}-r)\right|&\le C_3.
\end{aligned}
\tag{B.31}
\]

In particular \(d(t_k+2)\to\infty\), so (R) fails. Comparing the baseline with the smaller \(\widetilde c\) tail is essential: controlling only \(\widetilde a\) would not establish the reversal estimate. Formula (B.30) shows that the strictly positive smooth extension has the same large reversals as the sparse-bump model without a baseline.

### B.6. Local regularity, summable cell error, and correct-run survival

For any smooth perceived generator, differentiation gives

\[
u'(r)=-k_{\widetilde f}\widetilde f(r)
\left[\frac1{1-\widetilde a(r)}-
\frac{e^{-r}}{1-\widetilde c(r)}\right]\le0.
\tag{B.32}
\]

The bracket is nonnegative and bounded for all sufficiently large \(r\). On a distant bump the generator is bounded by \(g_0(r)+\mu_k\|\psi\|_\infty\), and off the bumps it equals \(g_0(r)\). Hence \(u'(r)\to0\) globally. Eventually \(|u'(r)|\le1/2\), so \(u(r+u(r))\ge u(r)/2\). Compactness and positivity cover the remaining interval. This proves (L). In particular, the rapid relative change in a small perceived tail does not violate the local step condition.

For (Q), first consider the bump \([t_k,t_k+1]\). Monotonicity of \(b\), (B.28), and the endpoint values \(u(t_k)\asymp\mu_k\), \(u(t_k+1)\asymp\mu_{k+1}\) give

\[
\int_{t_k}^{t_k+1}b(r)\,d[-\log u(r)]
\le b(t_k)\log\frac{u(t_k)}{u(t_k+1)}
\le Ce^{-\sqrt{t_k+1}}(1+t_k^{3/4}).
\tag{B.33}
\]

These bounds are summable. On the gap following that bump, (B.31) and (B.32) give the separate baseline bound

\[
\int_{t_k+1}^{t_{k+1}}b(r)\,d[-\log u(r)]
\le C\mu_{k+1}^{-1}\int_{t_k+1}^{t_{k+1}}g_0(r)\,dr
\le C e^{t_k^{3/4}-t_k^4/2}.
\tag{B.34}
\]

This series also converges. The initial compact interval contributes a finite amount, proving (Q).

For \(r\in[t_k,t_{k+1}]\), the perceived tail contains the entire \((k+1)\)st bump. Consequently \(u(r)\ge c\mu_{k+1}\). Using (B.24) and (B.28),

\[
\int_{t_k}^{t_{k+1}}\frac{g(r)}{u(r)}\,dr
\le Ce^{t_k^{3/4}}\int_{t_k}^\infty e^{-r}\,dr
=Ce^{-t_k+t_k^{3/4}}.
\tag{B.35}
\]

Thus \(G(\infty)< \infty\). Applying the cell comparison (B.18) to \(g\) shows that every correct run, from every finite aligned starting belief, has probability at least the same \(\delta\) in (B.19) of continuing forever.

### B.7. All fixed-origin moments and all integral tests are finite

We verify the integral tests and the fixed-origin moments separately.

First, in the unit interval \([t_{k-1}+2,t_{k-1}+3]\), (B.28) and (B.31) give, for large \(k\),

\[
B(t_k)\ge \Lambda_k,\qquad
\Lambda_k:=c\exp\left[t_{k-1}^{3/4}-\sqrt{t_{k-1}+4}\right].
\tag{B.36}
\]

For every \(r\in[t_k,t_{k+1}]\), monotonicity of \(u\) yields

\[
\begin{aligned}
\frac1{u(r)}&\le Ce^{t_k^{3/4}},\qquad B(r)\ge\Lambda_k,\\
T(r)&\le1+\frac r{u(r)}\le Ct_{k+1}e^{t_k^{3/4}}.
\end{aligned}
\tag{B.37}
\]

If \(q=\max(p,1)\), then

\[
\int_{t_k}^{t_{k+1}}T(r)^{p-1}e^{-B(r)}\frac{dr}{u(r)}
\le C_p t_{k+1}^{q}\exp\left[qt_k^{3/4}-\Lambda_k\right].
\tag{B.38}
\]

Because \(t_k=t_{k-1}^3\), the positive part of the exponent and the logarithm of the prefactor are polynomial or logarithmic in \(t_{k-1}\). In contrast, \(\Lambda_k\) grows exponentially in \(t_{k-1}^{3/4}\). For each fixed \(p\), the right side is eventually bounded by \(C_pe^{-t_k}\). The finite initial region is integrable, and therefore \(J_p< \infty\) for every \(p>0\).

For a direct discrete argument, fix any finite starting value \(s\). Its increasing orbit eventually crosses every unit interval \([t_{k-1}+2,t_{k-1}+3]\). The steps there are at most \(C\mu_k\). Since all sufficiently remote steps are smaller than \(1/4\), the orbit enters the gap before this unit interval and has at least \(c/\mu_k\) values inside it. At each such value the wrong-run logarithmic hazard is at least \(ce^{-\sqrt{t_{k-1}+4}}\). Thus, for all sufficiently large \(k\), depending on \(s\), and every orbit index \(n\) with \(r_n(s)\ge t_k\),

\[
S_s(n)\le e^{-\Lambda'_k},\qquad
\Lambda'_k=c\exp\left[t_{k-1}^{3/4}-\sqrt{t_{k-1}+4}\right].
\tag{B.39}
\]

While \(r_n(s)\le t_{k+1}\), each preceding step is at least \(c\mu_{k+1}\), so \(n\le Ct_{k+1}e^{t_k^{3/4}}\), after omitting a finite number of initial blocks if necessary. The exact identity

\[
\mathbb E[(1+A_s)^p]
=1+\sum_{n\ge1}\big[(n+1)^p-n^p\big]S_s(n)
\tag{B.40}
\]

can now be partitioned according to the blocks containing \(r_n(s)\). Equations (B.39) and the step-count bound give a summable upper bound of the same form as (B.38). This proves every positive moment of every fixed-origin incorrect run directly, without an integral approximation.

In particular every incorrect run ends almost surely. After it ends, the newly initiated correct run has probability at least \(\delta\) of continuing forever, uniformly over its possibly unbounded starting belief. Conditional independence of future signals at these stopping times gives

\[
P(N\ge j)\le(1-\delta)^{j-1},\qquad j\ge1.
\tag{B.41}
\]

No incorrect run can be infinite, and infinitely many completed incorrect runs have probability zero by (B.41). Hence actions are eventually correct almost surely. This also proves \(W< \infty\) almost surely, despite the moment divergence established next.

### B.8. Random reversals make every total-error moment infinite

Fix state \(h\). From any fixed nondegenerate prior, the event that the first action is correct has strictly positive probability: \(P_h(Z>-r_\pi)>0\). On that event its post-action public belief \(s=H(r_\pi)\) is finite and positive. We condition on this first action and follow the deterministic all-high orbit from \(s\). This finite-prefix conditioning is legitimate for every prior in the theorem.

For large \(k\), let \(E_k\) be the event that the first low action of this correct run occurs at an orbit value in \(I_k=[t_k+2,t_k+3]\). The orbit has at least \(c/\mu_{k+1}\) values in \(I_k\). At every such value its probability of having survived correctly is at least \(\delta\), and its conditional probability of switching is \(c(r)\), not the logarithmic hazard \(g(r)\). Summing the disjoint first-switch probabilities and using (B.28) gives

\[
P(E_k\mid\text{first action correct})
\ge c\frac{\exp[-t_k-\sqrt{t_k+5}+t_k^{3/4}]}{\sqrt{t_k+5}}.
\tag{B.42}
\]

On \(E_k\), the first incorrect action produces the aligned belief \(d(r)\). The uniform reversal estimate in (B.31) implies

\[
d(r)\ge t_{k+1}-t_k-3-C_3\ge\tfrac12t_{k+1}
\tag{B.43}
\]

for all sufficiently large \(k\).

An incorrect run starting at belief \(v\) has all subsequent aligned beliefs at least \(v\). Its one-step probability of ending is therefore at most \(a(v)\). For \(a(v)\le1/4\), put \(m=\lfloor1/(2a(v))\rfloor\). Then \(m\ge1/(4a(v))\) and

\[
P(A_v\ge m)\ge(1-a(v))^m\ge e^{-1},\qquad
\mathbb E[L_v^p]\ge c_pa(v)^{-p}\ge c'_pe^{p\sqrt v}.
\tag{B.44}
\]

These estimates apply conditionally on each actual switch history, because future private signals remain independent of that history after conditioning on the state. The total mistake count dominates this ensuing run. Combining (B.42)–(B.44), and including the positive probability of the first correct action, gives

\[
\mathbb E[W^p]\ge
c_p\frac{\exp[(p/\sqrt2)t_k^{3/2}-t_k-\sqrt{t_k+5}+t_k^{3/4}]}
{\sqrt{t_k+5}}.
\tag{B.45}
\]

For every fixed \(p>0\), the right side tends to infinity as \(k\to\infty\). Thus \(\mathbb E[W^p]=\infty\). Reflection proves the same conclusion under state \(\ell\), and a nondegenerate prior mixture preserves it. The argument does not assume independence of different run lengths or of the run count and those lengths.

### B.9. The correctly specified fixed experiment has all total-error moments

Now use the fixed true generator \(f\) in (B.25) as the perceived generator as well. Its large-\(r\) tails satisfy

\[
\begin{aligned}
a(r)&=k_fe^{-\sqrt{r+1}},\qquad u(r)\sim a(r),\\
c(r)&\sim k_f\frac{e^{-r-\sqrt{r+1}}}{2\sqrt{r+1}}.
\end{aligned}
\tag{B.46}
\]

For the middle asymptotic, write the tail integral defining \(c(r)\) as

\[
c(r)=k_fe^{-r}f(r)\int_0^\infty e^{-y}\frac{f(r+y)}{f(r)}\,dy.
\]

For each fixed \(y\) the ratio tends to one, while it is at most one on the eventual decreasing tail of \(f\). Dominated convergence proves (B.46).

At correct specification \(u=b-g\) exactly. Consequently

\[
\begin{aligned}
G(\infty)&< \infty,\qquad B(r)=r+G(r)=r+O(1),\\
T(r)&\sim\frac2{k_f}\sqrt r\,e^{\sqrt r}.
\end{aligned}
\tag{B.47}
\]

Differentiating the explicit tails gives \(u'(r)\to0\) and \(b(r)(-u'(r)/u(r))=O(e^{-\sqrt r}/\sqrt r)\). Thus (L) and (Q) hold. For each fixed \(p>0\), the integrand defining \(J_p\) is bounded by a polynomial in \(r\) times \(e^{p\sqrt r-r}\), so \(J_p< \infty\).

This benchmark itself does not satisfy (R). Instead, (B.46) yields

\[
\begin{aligned}
d(r)&=\log(2\sqrt r)+o(1),\qquad B(d(r))=O(\log r),\\
\log T(d(r))&=O(\sqrt{\log r}+\log\log r).
\end{aligned}
\tag{B.48}
\]

It follows that \(h_p(r)\le C_pe^{-r/2}\) eventually. The nonincreasing tail envelope has the same bound, and \(1/u(r)=O(e^{\sqrt r})\). Hence the weighted reversal condition (B.13) holds for every \(p>0\). Proposition B.2, rather than a bounded-reversal argument, proves that the correctly specified total mistake count has every positive moment.

### B.10. Tail splicing and convergence in both relative-entropy directions

To make misspecification arbitrarily small while keeping the true experiment fixed, let \(\chi_R\) be a smooth cutoff equal to one on \([0,R]\), equal to zero on \([R+1,\infty)\), and valued in \([0,1]\). For \(R\ge14\), set \(t_0=R+2\), use (B.26), and define only the perceived generator by

\[
\widetilde f_R(x)=\chi_R(x)f(x)+(1-\chi_R(x))g_0(x)
+\sum_{k\ge1}\mu_k\psi(x-t_k).
\tag{B.49}
\]

The true generator remains exactly the fixed function in (B.25). The new perceived generator is positive and smooth, agrees with \(f\) on \([0,R]\), and has precisely the tail used in Sections B.5–B.8 beyond a finite initial interval. All conclusions in those sections therefore hold for every fixed \(R\); constants may depend on \(R\). Smoothness at zero follows from agreement with the fixed true generator there. The signal log-likelihood moments remain finite for all orders.

The generator difference satisfies

\[
\int_0^\infty|\widetilde f_R(x)-f(x)|\,dx
\le\int_R^\infty(f(x)+g_0(x))\,dx+\sum_{k\ge1}\mu_k
\longrightarrow0.
\tag{B.50}
\]

The sum is bounded by twice its first term for all sufficiently large \(R\). Since \(1+e^{-x}\in[1,2]\), the perceived normalizers \(Z_R:=Z_{\widetilde f_R}\) converge to the positive constant \(Z_f\).

For two positive generators \(f_1,f_2\), direct substitution into (B.22) gives

\[
D(P_{\ell,f_1}\Vert P_{\ell,f_2})
=\log\frac{Z_{f_2}}{Z_{f_1}}
+\frac1{Z_{f_1}}\int_0^\infty(1+e^{-x})f_1(x)
\log\frac{f_1(x)}{f_2(x)}\,dx.
\tag{B.51}
\]

The high-state divergence is identical by reflection. Bounds on the positive part of the integral suffice; the negative part is integrable by \(x\log(x/y)\ge-y/e\).

For all sufficiently large \(R\), \(f(x)\ge g_0(x)\) on \([R,\infty)\). Hence \(\widetilde f_R(x)\ge g_0(x)\) there, while \(\widetilde f_R=f\) on \([0,R]\). The true tail in (B.25) therefore implies

\[
\begin{aligned}
\left[\log\frac{f(x)}{\widetilde f_R(x)}\right]_+
&\le C+x^4\quad(x>R),\\
D(P_{\ell,f}\Vert P_{\ell,\widetilde f_R})
&\le\left|\log\frac{Z_R}{Z_f}\right|
+C\int_R^\infty(1+x^4)f(x)\,dx\longrightarrow0.
\end{aligned}
\tag{B.52}
\]

The last integral vanishes because the fixed stretched-exponential generator has all polynomial moments. On any remaining bounded initial interval, positivity and continuity make the entropy integral finite. Thus the forward divergence is finite for each fixed member of the family.

For the reverse divergence, outside the distant bump supports and above \(R\), the perceived generator is at most \(f\). On the \(k\)th bump, boundedness of \(\psi\), \(\mu_k\le1\), and the explicit true tail imply

\[
\left[\log\frac{\widetilde f_R(x)}{f(x)}\right]_+\le C(1+\sqrt x),\qquad
x\in[t_k,t_k+1].
\tag{B.53}
\]

The positive part of the reverse entropy integral is thus bounded by a constant times

\[
\int_R^\infty(1+\sqrt x)g_0(x)\,dx
+\sum_{k\ge1}\mu_k(1+\sqrt{t_k+1})\longrightarrow0.
\tag{B.54}
\]

The baseline integral vanishes. For the series, put \(y_k=t_{k-1}^{3/4}\), so \(y_{k+1}=y_k^3\) and \(\mu_k\sqrt{t_k}=e^{-y_k}y_k^2\). For sufficiently large \(y_k\), this is at most \(e^{-y_k/2}\). The resulting series is bounded by a constant times \(e^{-t_0^{3/4}/2}\), which tends to zero. Combining (B.51), (B.54), and \(Z_R\to Z_f\) proves the reverse limit. Reflection supplies both limits for state \(h\).

Sections B.6–B.8 establish the misspecified claims for every member of the family, Section B.9 establishes the correctly specified comparison for the one fixed true experiment, and (B.52)–(B.54) establish the two relative-entropy limits. This proves Theorem B.1. \(\square\)

## References and inspected versions

[1] Itai Arieli, Yakov Babichenko, Stephan Müller, Farzad Pourbabaee, and Omer Tamuz. “The hazards and benefits of condescension in social learning.” *Theoretical Economics* 20 (2025), 27–56. [doi:10.3982/TE5743](https://doi.org/10.3982/TE5743). Complete author version inspected: [arXiv:2301.11237v3](https://arxiv.org/abs/2301.11237v3), especially the model, main tail theorem and run arguments.

[2] Dinah Rosenberg and Nicolas Vieille. “On the Efficiency of Social Learning.” *Econometrica* 87(6) (2019), 2141–2168. [doi:10.3982/ECTA15845](https://doi.org/10.3982/ECTA15845). The final main-paper metadata, abstract and publisher preview of p.2141 were inspected; the full final main paper was unavailable. The [official final supplement](https://www.econometricsociety.org/publications/econometrica/2019/11/01/efficiency-social-learning/supp/ecta200075-sup-0001-Supplement.pdf) was inspected separately.

[3] Dinah Rosenberg and Nicolas Vieille. “On the efficiency of social learning.” Author manuscript dated 3 November 2017, 41 pages. [University-hosted manuscript](https://intranet.royalholloway.ac.uk/economics/documents/pdf/seminars/social-learning-4.pdf). The planner statements in Section 3.3, Theorem 8, Proposition 6 and footnote 23 were inspected in this version; its separate planner-proof supplement was unavailable. Theorem numbers and assumptions are not silently transferred to [2].

[4] Mira Frick, Ryota Iijima, and Yuhta Ishii. “Belief Convergence under Misspecified Learning: A Martingale Approach.” *Review of Economic Studies* 90(2) (2023), 781–814. [doi:10.1093/restud/rdac040](https://doi.org/10.1093/restud/rdac040). [Final journal PDF](https://economics.yale.edu/sites/default/files/2023-03/rdac040.pdf), including Theorems 1–2, Propositions 1 and 4 and their stated assumptions.

[5] Florian Brandl. “The Social Learning Barrier.” *Econometrica* 94(6) (2026), 1991–2024. [doi:10.3982/ECTA24769](https://doi.org/10.3982/ECTA24769). Journal metadata verified separately; the inspected [complete author manuscript](https://brandlf.com/docs/network-learning.pdf) is dated 30 April 2026. In particular, Section 7.1 and Appendix C provide the permanent-action path comparison discussed here. The final journal text was not acquired.

[6] Wee Peng Tay, John N. Tsitsiklis, and Moe Z. Win. “On the Subexponential Decay of Detection Error Probabilities in Long Tandems.” *IEEE Transactions on Information Theory* 54(10) (2008), 4767–4771. [doi:10.1109/TIT.2008.929032](https://doi.org/10.1109/TIT.2008.929032). [Published paper](https://web.mit.edu/people/jnt/Papers/J113-08-tandem.pdf), including the observation structure and Propositions 1–3.

[7] Florian Brandl, Wanying Huang, and Atulya Jain. “On the Inefficiency of Social Learning.” Working paper, [arXiv:2602.08812](https://arxiv.org/abs/2602.08812). The inspected [author manuscript](https://brandlf.com/docs/coarse.pdf) is dated 3 October 2026; older cached snippets at this URL are not treated as the same version.

[8] Mira Frick, Ryota Iijima, and Yuhta Ishii. “Misinterpreting Others and the Fragility of Social Learning.” *Econometrica* 88(6) (2020), 2281–2328. [doi:10.3982/ECTA16981](https://doi.org/10.3982/ECTA16981). The model and main result were inspected in the [public final author manuscript](https://drive.google.com/file/d/19KwRUQNwn8Uu65fffJfHwSYkygVN70ke/view) dated 2 June 2020, linked from the author's website.

[9] Mira Frick, Ryota Iijima, and Yuhta Ishii. “Welfare Comparisons for Biased Learning.” *American Economic Review* 114(6) (2024), 1612–1649. [doi:10.1257/aer.20210410](https://doi.org/10.1257/aer.20210410). The model, dynamic comparison and relevant main statements were inspected in the [public final author manuscript](https://drive.google.com/file/d/1tXSkfcuzcbiAMt6pM_ZAYhIuH0MHmaOa/view) dated 7 January 2024. This is distinct from the earlier Cowles discussion paper and from the publisher's typeset version.
