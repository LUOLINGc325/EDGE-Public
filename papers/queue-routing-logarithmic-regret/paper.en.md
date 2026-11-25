---
title: "Completion Regret in Skill-Based Routing and a Symmetric Critical Learning Limit"
author: "Research manuscript"
date: "25 November 2026"
lang: en-US
toc: true
numbersections: true
---

# Abstract

We study learning unknown edge rewards while routing Poisson arrivals to heterogeneous exponential servers. A reward becomes observable only when its job completes. The comparator is the static routing linear program with a fixed, strictly positive capacity slack, and jobs may neither be abandoned nor rerouted. We give a horizon-free policy with expected completion-reward regret of order $\log T$ for a unique, nondegenerate optimal routing vertex and independent bounded rewards. A second certificate extends the result, with the same constants, to any known compact feasible routing subpolytope, allowing arbitrary primal and dual degeneracy and additional linear allocation constraints. It uses at most $2M+1$ linear optimization calls per slot, where $M$ is the number of allowed edges. The displayed constants depend polynomially, up to logarithms, on $M$ and the inverse vertex gap; they do not involve the number of feasible bases or the smallest positive routing rate. Both policies combine a robust objective certificate with sparse exploration from an edge-covering feasible allocation. We prove the original model's all-time expected departure constraint and the existence of the limiting expected backlog, rather than only a uniform backlog bound.

We also examine the lower-bound hypothesis in van Kempen, Sanders, Sloothaak, and Wolf (2026). On a fully admissible $K_{2,2}$ instance with Poisson rewards, we construct one nonanticipating policy that samples every optimal edge at an almost-sure linear rate at every parameter, yet has regret $\frac9{10}\log\log(e+T)+O(1)$ at a distinguished parameter. This contradicts the positive logarithmic lower coefficient asserted under the paper's displayed weak consistency condition. We verify graph size, nondegeneracy, the slack restriction, all-time capacity, and literal backlog convergence. Finally, we prove a replacement information lower bound under explicitly stronger uniform efficiency and predictable feasible routing rates, with legal alternatives restricted to the stated reward family.

For two symmetric types and servers with unknown Bernoulli reward direction, the predictable rate matrix induces independent physical queues and an action-independent corrected vote law. A single majority rule achieves the exact finite-horizon minimax regret. The limiting regret separates into a reflected Brownian maximum and an explicit Gaussian testing integral when load slack and reward gap both vanish at the critical scales.

# Introduction and scope

Learning from jobs that finish in queues differs from learning at assignment time. Observations are delayed by the same routing choices that the learner controls, pending jobs still contribute to physical congestion, and a proof about assigned utility need not imply the corresponding statement about completed utility. In the skill-based model of van Kempen et al. [VKSW26], each compatibility edge has an unknown expected reward. Their published upper bound is $O(\log^{2\beta}T)$ for every $\beta>1$. The analysis depends on a collection of routing bases and a positive minimum routing rate. Their lower bound is stated under a condition requiring every optimal edge to be sampled more than any fixed multiple of $\log T$, in probability, at every reward parameter.

This manuscript resolves two different issues for this fixed-slack setting. First, a sparse-certificate policy attains an explicit $O(\log T)$ completion bound while using edge observations directly. Second, the displayed weak consistency condition is insufficient for the claimed logarithmic lower bound. A policy may behave exceptionally well at a fixed design point and incur substantial regret elsewhere, while still sampling all optimal edges sufficiently often everywhere. This is not a new generic bandit phenomenon: Salomon, Audibert, and El Alaoui [SAE13] already study the failure of universal logarithmic bounds under weaker consistency notions, including Hannan consistency. Our counterexample addresses the particular displayed condition and all the physical and geometric hypotheses of the 2026 queueing theorem. The replacement lower theorem identifies a sufficient quantitative assumption: subpolynomial regret at every admissible parameter.

Several ingredients are established principles, and our claims are deliberately narrower than their general reinvention. Joulani, György, and Szepesvári [JGS13] analyze delayed learning through outstanding feedback, including logarithmic stochastic guarantees. Wang and Chen [WC17] allow infinite action spaces and optimization oracles, and remove inverse minimum triggering probabilities under their smoothness condition. The original queueing paper itself suggests both sample sharing and direct optimistic LP solution. Fu and Modiano [FM22] and Steiger, Li, and Lu [SLL24] already study learning with utility revealed after physical queueing delay. Recent delayed-bandit results include adaptive outcome-independent delays [SZM26]. Our contribution is the complete theorem for the stated physical queue model, its edge and gap dependence, the literal admissibility proof, and the precise separation and repair of the lower-bound hypothesis.

## Main results and their different reward domains

The results for fixed slack and the symmetric critical scaling use the following reward domains.

| Result | Reward domain | Policy class and claim |
|:--|:--|:--|
| Theorem 1 | Independent rewards in $[0,1]$ | One horizon-free feasible-rate FCFS policy has explicit logarithmic completion regret and the original queue admissibility properties. |
| Theorem 2 | Independent Poisson rewards, means in $[0,\infty)^4$ | One policy satisfies the source's weak consistency at every parameter but has $\log\log T$ regret at a fixed parameter. |
| Theorem 3 | A specified nonnegative reward family with legal finite-KL alternatives | Uniform efficiency and predictable feasible rates imply a logarithmic information lower bound. |
| Theorem 4 | Independent rewards in $[0,1]$ | The upper guarantee extends to any compact feasible subpolytope, allowing arbitrary degeneracy, using at most $2M+1$ LP calls per slot. |
| Theorems 5–6 | Two symmetric Bernoulli environments | For two types and two servers with predictable feasible rates, the same majority rule attains exact minimax completion regret and its simultaneous heavy-traffic/low-information limit. |

Theorem 1 does not establish the optimal logarithmic coefficient. Theorem 2 is a counterexample to a lower-bound hypothesis, not a uniformly efficient policy. Theorem 3 adds assumptions explicitly; it does not recover the original claim from weak consistency alone. Theorems 1–4 concern fixed strictly positive slack. Theorems 5–6 keep positive slack in each physical model and allow it to vanish along a sequence. The boundary computations with known rewards state their finite-horizon physical admissibility conditions separately.

# Model and notation

Let $\mathcal E$ be the edges of a finite bipartite graph with customer types $i\in\{1,\ldots,I\}$ and servers $j\in\{1,\ldots,J\}$; write $M=|\mathcal E|$. Type-$i$ customers arrive as independent Poisson processes of known rates $\lambda_i>0$. Server $j$ has independent exponential service times with known rate $\mu_j>0$, independent of type. Arrival, service, reward, and routing-randomization primitives are mutually independent before adaptation. The system starts empty.

An arriving customer is assigned once to a compatible server. It is retained until completion and never rerouted. Let $A_e(t)$ and $D_e(t)$ count assignments and completions on edge $e$, and let $Q_e(t)=A_e(t)-D_e(t)$ count pending jobs, including those in service. Write $Q_j=\sum_iQ_{ij}$ and $Q_i=\sum_jQ_{ij}$. An edge reward is independent of physical primitives and other rewards and is revealed only at completion. Its mean is $\theta_e\ge0$.

Fix $\epsilon>0$ with $c_j:=\mu_j-\epsilon>0$ and define

$$
\mathcal P=\left\{x\ge0:
\sum_{j:(i,j)\in\mathcal E}x_{ij}=\lambda_i\ \forall i,
\quad\sum_{i:(i,j)\in\mathcal E}x_{ij}\le c_j\ \forall j\right\}.
$$

Assume $\mathcal P$ is nonempty. It is compact. The fixed-slack benchmark is

$$
v^*(\theta)=\max_{x\in\mathcal P}\theta\cdot x,
\qquad
R_\pi^\theta(T)=T v^*(\theta)-\sum_e\theta_e\mathbb E_\theta D_e(T).
\tag{1}
$$

The latter is expected completed reward regret. Equivalently one may subtract the actual random sum of completed payoffs inside the expectation. A job's hidden reward cannot determine its own selection for completion, so the two definitions agree.

A **feasible-rate policy** chooses a predictable matrix $x(t)\in\mathcal P$ before observing the next arriving type and assigns a type-$i$ arrival to $j$ with probability $x_{ij}(t)/\lambda_i$. This is stronger than merely imposing an asymptotic average server constraint. Choosing separate feasible matrices after seeing different types would not imply the required aggregate rate bound and is not our policy class.

The admissibility requirements in [VKSW26, equations (7)--(8)] are, literally,

$$
\lim_{T\to\infty}\left(T\lambda_i-\sum_j\mathbb E_\theta D_{ij}(T)\right)
\text{ exists and is finite for every }i,
\tag{2}
$$

$$
\sum_i\mathbb E_\theta D_{ij}(T)\le c_jT
\quad\text{for every }j\text{ and every }T\ge0.
\tag{3}
$$

Because no arrivals are lost, the expression in (2) is $\mathbb E_\theta Q_i(T)$. A uniform bound on this expression alone would not prove (2).

For Theorem 1, assume the standard-form primal LP is nondegenerate: after adding one nonnegative capacity slack per server, every feasible basic solution has strictly positive basic coordinates. Assume that $x^*$ is the unique optimum. If there are at least two vertices, define the **vertex gap**

$$
\Delta=\min_{v\in\operatorname{vert}(\mathcal P),\ v\ne x^*}
\theta\cdot(x^*-v)>0.
\tag{4}
$$

This is not an infimum over all nonoptimal feasible points; that infimum would generally be zero. The upper proof does not need dual nondegeneracy at every empirical objective, connectedness, or the source's graph-size restriction. The counterexample to the source's lower theorem will nevertheless satisfy its stronger stated hypotheses.

# A sparse-certificate policy

## Initialization without vertex enumeration

For each edge $e$, solve the LP

$$
m_e=\max_{x\in\mathcal P}x_e,
\qquad x^{(e)}\in\arg\max_{x\in\mathcal P}x_e,
\qquad q^0=\frac1M\sum_{e\in\mathcal E}x^{(e)}.
\tag{5}
$$

Then $q^0\in\mathcal P$ and $q^0_e\ge m_e/M$. Forced-zero edges have $m_e=0$ and need no observations. Initialization uses $M$ LP solves and does not enumerate vertices. Let $\Lambda=\sum_i\lambda_i$; then $m_e\le\Lambda$.

Divide time into slots $[n-1,n)$, $n=1,2,\ldots$. The decision for slot $n$ uses only observations available at $n-1$ and fixes its routing matrix for the whole slot. Each server uses FCFS.

## Confidence box and exact certificate

Let $d_e=D_e(n-1)$ and let $\widehat\theta_e$ be the empirical mean of its completed rewards, with $\widehat\theta_e=0$ if $d_e=0$. Set

$$
\ell_n=\log(n+2),\qquad
r_e(n)=\min\left\{1,\sqrt{\frac{8\ell_n}{d_e\vee1}}\right\},
\tag{6}
$$

$$
\mathcal C_n=\prod_e
\left[\max(0,\widehat\theta_e-r_e),\min(1,\widehat\theta_e+r_e)\right].
\tag{7}
$$

Solve the empirical objective LP and obtain a feasible optimal vertex basis $B$. In standard form $Az=d$, $z=(x,s)\ge0$, and objective $\widetilde c(\zeta)=(\zeta,0)$, its nonbasic reduced cost is

$$
\rho_k(\zeta)=\widetilde c_k(\zeta)
-\widetilde c_B(\zeta)^\top A_B^{-1}A_k.
\tag{8}
$$

This is a known affine function of the edge objective coordinates. Its maximum over $\mathcal C_n$ is obtained by selecting the upper endpoint for a positive coefficient and the lower endpoint for a negative coefficient. Certify $B$ if these maxima are nonpositive for all nonbasic $k$. A stricter negative test is also valid. Repeated occurrences of an objective coordinate must first be collected into one coefficient; naive interval arithmetic that treats them as independent need not yield the exact test.

The certificate proves optimality for every objective in the box. A mathematical implementation uses exact LP and sign oracles. A numerical implementation may conservatively refuse a certificate when its sign is uncertain. Such refusal preserves soundness, but by itself does not preserve the regret bound: a numerical implementation must additionally be proved to accept on the positive-margin event established below. An implementation that always refuses can explore too long. Declaring an uncertified sign negative with a floating-point tolerance is not covered by the theorem. The per-slot operations are one LP solve and polynomial basis algebra; no bit-complexity claim for an arbitrary floating-point solver is made.

## Decision rule

Fix any finite $\beta\ge1$ and a feasible default vertex. Define independent coins for every slot, independently of the physical and reward primitives, with success probabilities

$$p_n=\min\{1,\beta/\sqrt{n+1}\}.$$

1. Form the completion-based confidence box and run the exact robust test.
2. If the test succeeds, use its vertex for the current slot and record the current slot as the latest successful certificate time, even when the vertex has not changed.
3. If the test fails and the slot's coin succeeds, use $q^0$.
4. Otherwise use the most recently certified vertex, or the default vertex if there is none.

A previously stored certificate is not assumed to stay valid for the expanding clock-time confidence requirement. Its vertex is only an exploitation choice until a fresh test succeeds. The policy uses neither $T$ nor $\Delta$ nor the constants in the analysis.

# Logarithmic completion regret

**Theorem 1 (explicit upper bound and literal admissibility).** Suppose rewards are independent and supported on $[0,1]$, the model assumptions above hold, and $\mathcal P$ is nondegenerate with at least two vertices and unique optimum $x^*$. Define

$$
h=\max_j\frac1{\log(\mu_j/c_j)},\qquad b_0=12h+2,
$$

$$
b=\lceil2e\Lambda+20\rceil,\qquad
C_{\rm conf}=2M(b+1)+1,
$$

$$
K=1+\frac{4096M^3\Lambda}{\Delta^2}
+\frac{32M^2(b_0+64)}{\Delta},\qquad
C=C_{\rm conf}+M+J,
\tag{9}
$$

$$
N_0=\left\lceil\bigl(128K\log(128K)\bigr)^2\right\rceil.
\tag{10}
$$

The sparse-certificate policy, for any fixed finite $\beta\ge1$, satisfies for all $T\ge0$,

$$
R_\pi^\theta(T)\le
\Lambda\left[K\log(T+3)+N_0+4C+2^{16}C_{\rm conf}+2052\right]
+\sum_j\frac{c_j}{\epsilon}.
\tag{11}
$$

It retains and eventually completes every assigned job almost surely. It satisfies (3) for every real $T$, and

$$
\lim_{T\to\infty}\mathbb E_\theta Q_i(T)
=\sum_j\frac{x^*_{ij}}{\mu_j-\sum_kx^*_{kj}}<\infty.
\tag{12}
$$

If the polytope has a single vertex, using that vertex forever has regret at most $\sum_jc_j/\epsilon$ and the same limit (12); no empty minimum in (4) is needed.

The logarithmic coefficient and the additive constants contain no vertex-count factor and no inverse minimum positive routing rate. The leading coefficient has linear dependence on $h\le\max_j\mu_j/\epsilon$. The complete bound is not linear in inverse slack: $N_0$ is quadratic in $K$ up to logarithms, and the vertex gap itself may change when the slack changes.

## Queue domination for adaptive feasible rates

We first justify the physical realization rather than treating adaptive server arrivals as homogeneous Poisson processes. At each server $j$, take an independent proposal Poisson process of rate $c_j$ and an independent potential-service Poisson process of rate $\mu_j$. At a proposal time $t$, accept the proposal as type $i$ with probability $x_{ij}(t)/c_j$; otherwise it is a phantom. Use independent marks. At a potential-service event, complete the actual head job precisely if the actual queue is nonempty.

The accepted type-$i$ point process has predictable intensity $\sum_jx_{ij}(t)=\lambda_i$. The vector of accepted type counts has no simultaneous jumps and deterministic component intensities. The point-process characterization, or its conditional increment generating function, therefore gives independent Poisson type processes of the required rates. This characterization also holds conditional on fixed full service-clock and reward-stream realizations: the routing remains predictable in the proposal history and its type intensities remain deterministic. Thus the accepted exogenous arrivals have the required independence from those primitives. Conditional on a type-$i$ event, the server probabilities are $x_{ij}/\lambda_i$. The policy ignores phantom events. This realizes the original model in law without asserting that accepted arrivals to a given server remain homogeneous under adaptation.

Let $Z_j$ accept every server proposal and use the same potential-service clock. Initialize it in its stationary geometric distribution,

$$
\Pr(Z_j(0)=k)=(1-\rho_j)\rho_j^k,
\qquad\rho_j=c_j/\mu_j<1.
$$

Since the actual queue starts empty, monotonicity of common births and deaths gives $Q_j(t)\le Z_j(t)$ pathwise. Consequently,

$$
\sup_t\mathbb E Q_j(t)\le\frac{c_j}{\epsilon},\qquad
\sup_t\mathbb E Q_j(t)^2
\le\frac{\rho_j(1+\rho_j)}{(1-\rho_j)^2}.
\tag{13}
$$

Conservation and the predictable assignment compensator imply

$$
\mathbb E D_j(t)\le\mathbb E A_j(t)
=\mathbb E\int_0^t\sum_i x_{ij}(s)\,ds\le c_jt,
\tag{14}
$$

which proves (3), including the transient. FCFS, a finite number of preceding jobs, and finite service times imply eventual completion of every job. The geometric envelope also visits zero infinitely often.

## Confidence at random completion counts

Preassign independent iid reward streams to the edges in assignment order. FCFS makes the same-edge completion order equal its assignment order, although completions on different edges interleave adaptively. Thus observed rewards on each edge form a prefix of its stream. For any fixed positive prefix length $d$, Hoeffding's inequality gives

$$
\Pr\left(\left|\overline Y_{e,d}-\theta_e\right|
>\sqrt{8\ell_n/d}\right)\le2(n+2)^{-16}.
$$

The sample count itself need not be independent of rewards. We do not apply a fixed-sample law conditional on that count. Let $N(t)$ count all exogenous arrivals. Since $N(n-1)$ is Poisson with mean $\Lambda(n-1)$, exponential Markov at parameter one gives

$$
\Pr\{N(n-1)>b(n+2)\}
\le\exp((e-1)\Lambda n-b(n+2))
\le e^{-20(n+2)}\le(n+2)^{-15}.
$$

Every completion count is at most $N(n-1)$. Union over $M$ edges and the at most $b(n+2)$ positive prefix lengths. If the radius is clipped at one, the interval already contains all means in $[0,1]$. Writing $G_n=\{\theta\in\mathcal C_n\}$, we obtain

$$\Pr(G_n^c)\le C_{\rm conf}(n+2)^{-15}.$$

This finite truncation is essential; union over all infinitely many possible counts with a clock-only failure bound would be invalid.

## Arrival concentration in adaptively selected exploration slots

Let $E_k$ indicate that slot $k$ is actually used for exploration, and let $S_n=\sum_{k<n}E_k$. Let $A_e^0(n)$ count assignments to edge $e$ in those completed exploration slots. Their selection depends on past rewards and queues; conditional on the random total $S_n$, these arrivals need not be Poisson.

Instead, for $q=q_e^0$, use the nonnegative exponential martingale

$$
\mathcal M_n=
\exp\left[-(\log2)A_e^0(n)+\frac q2S_n\right].
$$

Once an exploration slot has been chosen, its rate is frozen at $q^0$. Its edge count $X$ is conditionally Poisson with mean $q$ and
$\mathbb E[2^{-X}e^{q/2}]=1$. A nonexploration increment is one. Thus $\mathbb E\mathcal M_n=1$. On the event $A_e^0(n)<qS_n/2$ and $S_n\ge s$,

$$
\mathcal M_n\ge
\exp\left(\frac{1-\log2}{2}qs\right)\ge e^{qs/8}.
$$

It follows that

$$
\Pr\{A_e^0(n)<qS_n/2,\ S_n\ge s\}\le e^{-qs/8}.
\tag{15}
$$

## A certificate after logarithmically many exploration slots

The stationary geometric tail and (13) imply

$$
\Pr\{\exists j:Q_j(n-1)>b_0\ell_n\}
\le J(n+2)^{-12}.
\tag{16}
$$

Call edge $e$ large if $m_e>\Delta/(16M)$. For each such edge,
$q_e^0\ge m_e/M>\Delta/(16M^2)$ and $q_e^0K\ge128$.
Using (15) with $s=K\ell_n$, the probability that any large edge violates $A_e^0(n)\ge q_e^0S_n/2$ while $S_n\ge K\ell_n$ is at most $M(n+2)^{-16}$.

Suppose these arrival inequalities, the complementary event in (16), and $G_n$ all hold. If $S_n\ge K\ell_n$, then for a large edge $e=(i,j)$,

$$
D_e(n-1)\ge A_e^0(n)-Q_j(n-1)
\ge(q_e^0K/2-b_0)\ell_n.
$$

The constants satisfy

$$
q_e^0K/2-b_0
\ge\frac{2048M^2m_e^2}{\Delta^2}+64.
\tag{17}
$$

Indeed, the $\Delta^{-2}$ term of $K$ contributes at least
$2048M^2m_e\Lambda/\Delta^2\ge2048M^2m_e^2/\Delta^2$; its $\Delta^{-1}$ term contributes more than $b_0+64$ by the definition of a large edge. Therefore $m_er_e\le\Delta/(16M)$. A small edge satisfies the same inequality from $r_e\le1$. In particular,

$$\sum_e m_er_e\le\Delta/8.$$

For every $\zeta\in\mathcal C_n$, goodness of the box gives $|\zeta_e-\theta_e|\le2r_e$. For every other vertex $v$, $|x_e^*-v_e|\le m_e$, so

$$
\zeta\cdot(x^*-v)
\ge\Delta-2\sum_e m_er_e\ge3\Delta/4>0.
\tag{18}
$$

Thus $x^*$ is the unique optimizer throughout the box. It is also the empirical optimizer. At its nondegenerate basis, each nonbasic direction permits a positive feasible step. Unique optimality therefore makes every reduced cost strictly negative. Each reduced cost is continuous, and the box is compact, so its maximum is negative. The exact robust test succeeds.

Let $F_n$ be the union of the confidence failure, the queue failure in (16), and the large-edge arrival failures restricted to $S_n\ge K\ell_n$. We have proved

$$
\Pr(F_n)\le C(n+2)^{-12},\qquad
\{S_n\ge K\ell_n,\ \text{no current certificate}\}\subseteq F_n.
\tag{19}
$$

Small-capacity edges need no observations precise enough to introduce an inverse $m_e$. This is the reason (9) has no minimum-positive-rate term.

## Expected exploration and wrong exploitation

Fix an integer horizon $N$. At most $\lceil K\log(N+2)\rceil$ exploration increments occur before the preceding count reaches that threshold. Every later exploration slot $n\le N$ has $S_n\ge K\ell_n$ and no current certificate; by (19) it lies in $F_n$. Hence

$$
\mathbb E\sum_{n\le N}E_n
\le K\log(N+2)+1+2C.
\tag{20}
$$

Let $\tau_n$ be the latest successful certificate slot available for slot $n$, taking zero if there is none. A wrong certificate at $k$ entails $G_k^c$. A union bound therefore gives

$$
\Pr\{\text{some wrong certificate in }[\lceil n/2\rceil,n]\}
\le2^{15}C_{\rm conf}(n+2)^{-14}.
\tag{21}
$$

On $\{\tau_n<n/2\}$ every slot from $\lceil n/2\rceil$ to $n-1$ lacked a successful current certificate. All the independently predefined exploration coins in that interval were therefore eligible. For $n\ge2$ their sum has mean at least $\sqrt n/4$: there are $\lfloor n/2\rfloor$ coins, each with probability at least $1/\sqrt n$. Chernoff's inequality implies

$$
\Pr\{\text{that coin sum}<\sqrt n/16\}\le e^{-\sqrt n/32}.
\tag{22}
$$

For $n\ge N_0$, the explicit definition (10) ensures
$\sqrt n/16\ge K\log(n+2)$. At $N_0$ this follows from
$\log(N_0+2)\le8\log(128K)$; thereafter
$\sqrt n/\log(n+2)$ is increasing. If the old-certificate event holds and the coin sum is not small, (19) applies to its failing current certificate. Therefore

$$
\Pr\{\tau_n<n/2\}
\le C(n+2)^{-12}+e^{-\sqrt n/32}
\quad(n\ge N_0).
\tag{23}
$$

Any wrong exploitation slot uses either an old/default vertex or a recent wrong certificate. Equations (21)--(23), and
$\sum_{n\ge1}e^{-\sqrt n/32}\le\int_0^\infty e^{-\sqrt x/32}dx=2048$,
give

$$
\mathbb E[\text{total wrong exploitation slots}]
\le N_0+2C+2^{16}C_{\rm conf}+2049.
\tag{24}
$$

Refreshing the timestamp after every successful test is necessary for this argument. It is not sufficient to refresh it only when the optimum changes.

## Conversion to the completion objective

Conservation and the assignment compensator give the exact expectation identity

$$
R_\pi^\theta(T)=
\mathbb E_\theta\int_0^T[v^*(\theta)-\theta\cdot x(t)]\,dt
+\sum_e\theta_e\mathbb E_\theta Q_e(T).
\tag{25}
$$

The identity is not asserted pathwise for the realized reward sum: arrival and reward martingales would then remain. Since $\theta_e\in[0,1]$, the feasible instantaneous assignment loss is in $[0,\Lambda]$, and it is zero for an exploitation slot using $x^*$. The pending contribution is at most $\sum_jc_j/\epsilon$ by (13). Apply (20) and (24) to $N=\lceil T\rceil$; the harmless endpoint constants yield (11).

## Convergence of expected type backlogs

The previous bounds also give, for all sufficiently large $n$,

$$
\Pr\{x_n\ne x^*\}\le p_n+C(n+2)^{-12}
+2^{15}C_{\rm conf}(n+2)^{-14}+e^{-\sqrt n/32}\longrightarrow0.
\tag{26}
$$

The exploration probabilities need not be summable, so this statement does not imply eventual permanent optimal routing. We use a finite-window coupling instead.

For fixed routing $x^*$, put $a_j^*=\sum_ix^*_{ij}$. A stationary FCFS server has geometric queue length of mean $a_j^*/(\mu_j-a_j^*)$ and iid type marks with probabilities $x^*_{ij}/a_j^*$, independent of its length. Thus the stationary mean type backlog is the right side of (12); zero-arrival servers contribute zero.

Fix $H>0$ and large $t$, and set $u=t-H$. At $u$, start an independent stationary marked $x^*$ system, then drive it with the same future proposal marks and service clocks as the actual system. For each server start an envelope from the maximum of the two initial queue lengths, accepting all future proposals. Both initial lengths are stochastically bounded by the geometric law with parameter $\rho_j=c_j/\mu_j$. With

$$
\alpha_j=\log(\mu_j/c_j),\qquad
\kappa_j=(\sqrt{\mu_j}-\sqrt{c_j})^2>0,
$$

the envelope's initial exponential moment is at most four. Indeed, the geometric moment at $\alpha_j/2$ is $1+\sqrt{\rho_j}\le2$, and the exponential of a maximum is at most the sum of the two exponentials. Before the envelope first hits zero, the birth-death generator satisfies

$$\mathcal L e^{\alpha_jq/2}=-\kappa_je^{\alpha_jq/2}.$$

Stopping the corresponding nonnegative exponential supermartingale gives

$$
\Pr\{\text{envelope has not emptied during }[u,t]\}
\le4e^{-\kappa_jH}.
\tag{27}
$$

If every intersecting slot uses $x^*$, actual and reference systems receive identical marked arrivals during the window. Once an envelope empties, both underlying server queues are empty and their complete FCFS lists agree thereafter. Their state-disagreement probability at $t$ is consequently bounded by

$$
\sum_{n:\,[n-1,n)\cap[u,t]\ne\varnothing}\Pr\{x_n\ne x^*\}
+4\sum_j e^{-\kappa_jH}.
\tag{28}
$$

For fixed $H$ the first term tends to zero by (26). The uniform second moments in (13), also valid for the reference, imply by Cauchy--Schwarz that state coupling transfers to convergence of expected type counts. Let $t\to\infty$ and then $H\to\infty$. This proves (12), and therefore the literal condition (2). Theorem 1 is proved.

# A counterexample to the displayed weak-consistency lower bound

The consistency condition in [VKSW26, equation (24)] is

$$
\text{for every admissible }\xi,\ e\in\mathcal O(\xi),\ b>0,
\qquad
\Pr_\xi\{D_e(T)<b\log T\}\longrightarrow0,
\tag{29}
$$

where $\mathcal O(\xi)$ is the support of the optimal routing at $\xi$. We now give a policy that satisfies (29), (2), and (3) everywhere in its reward family, but violates the stated positive logarithmic lower bound at one parameter. The reward domain in this section is Poisson, not bounded.

**Theorem 2 (fully admissible weak-consistency separation).** There is a connected $K_{2,2}$ instance satisfying the graph-size, primal/dual nondegeneracy, and fixed-slack restrictions of [VKSW26, Theorem 1], and one nonanticipating retained-job policy $\pi$, such that (2), (3), and (29) hold for every $\xi\in[0,\infty)^4$. At the distinguished parameter $\theta^0$ below,

$$
R_\pi^{\theta^0}(T)
=\frac9{10}\log\log(e+T)+C_\pi+\frac{71}{52}+o(1),
\tag{30}
$$

where $0\le C_\pi<\infty$. In particular $R_\pi^{\theta^0}(T)/\log T\to0$, whereas the coefficient asserted by the cited theorem is strictly positive on this instance. A fully explicit, conservative bound is

$$
0\le R_\pi^{\theta^0}(T)
\le\frac9{10}\log\log(e+T)+\frac{19052}{5}.
\tag{31}
$$

## Exact instance and source assumptions

Take all four edges, and set

$$
(\lambda_1,\lambda_2)=(2/5,3/5),\qquad
\mu_1=\mu_2=3,\qquad\epsilon=1.
\tag{32}
$$

Thus $c_1=c_2=2$ and $\Lambda=1$. The graph has $4>I+J-1=3$ edges, and the source's strict load inequalities hold. Every row-feasible allocation sends at most one unit of aggregate rate to either server, so the two capacity inequalities are strictly slack.

Each reward is $\operatorname{Poi}(\theta_e)$, independently, with $\theta_e\ge0$. This is one common nonnegative discrete family. For $0\le a<b$,

$$
\operatorname{KL}(\operatorname{Poi}(a),\operatorname{Poi}(b))
=a\log(a/b)+b-a\in(0,\infty),
\tag{33}
$$

using $0\log0=0$. Fix the design parameter and two routings

$$
\theta^0=\begin{pmatrix}4&1\\2&3\end{pmatrix},\qquad
x^0=\begin{pmatrix}2/5&0\\0&3/5\end{pmatrix},\qquad
q=\begin{pmatrix}1/5&1/5\\3/10&3/10\end{pmatrix}.
\tag{34}
$$

The unique optimum is $x^0$, with value $17/5$. The full-support routing $q$ has value $5/2$, so its gap is $9/10$.

All primal vertices have one positive routing edge per row and both server slack variables positive. These four coordinates form an invertible basis. Conversely, because both capacity slacks must be positive at every feasible point, any feasible basis includes them; the remaining two basic variables must include one flow per row. This enumerates exactly four feasible bases, all nondegenerate. They remain feasible as $\epsilon$ changes from zero to one. The source's equation (12) gives one-server subtree bounds drawn from $\{2,12/5,13/5,3\}$, with minimum two over all these bases. Thus $0<\epsilon=1<2$ satisfies its required strict restriction.

For completeness, the dual in free row potentials $v_1,v_2$ and nonnegative capacity prices $w_1,w_2$ is
$v_i+w_j\ge\theta^0_{ij}$, $w_j\ge0$.
At a vertex at least one $w_j$ is zero: otherwise shifting both $v_i$ down and both $w_j$ up, or the reverse, gives a nontrivial feasible local direction. If both $w_j=0$, the only vertex is $(4,3,0,0)$. If $w_1=0<w_2$, three reward inequalities must be active; only the row-2 double equality is possible, giving $(4,2,0,1)$. If $w_2=0<w_1$, only the row-1 double equality is possible, giving $(1,3,3,0)$. Each of these three vertices has exactly four independent active inequalities. Both rows cannot be simultaneously double-tight because they would require $w_1-w_2=3$ and $w_1-w_2=-1$. Thus all dual vertices at the distinguished parameter are nondegenerate. The exact-arithmetic script independently reproduces these finite checks.

At other parameter vectors ties and dual degeneracy may occur. The policy and consistency proof below still apply to all of them under any choice of optimal support. Hence they also apply to every intended nondegenerate subclass of the source's parameter domain; we do not assert that every mean vector has a nondegenerate dual.

## Policy with frozen priority episodes

Let

$$
p(t)=\frac1{(e+t)\log(e+t)},\qquad
H(T)=\int_0^Tp(t)dt=\log\log(e+T).
\tag{35}
$$

Write $\widehat\theta_e(n)$ for the mean of the first $n$ completed edge rewards. At sample level $n\ge1$, flag an edge as bad when

$$B_e(n)=\{|\widehat\theta_e(n)-\theta^0_e|>n^{-1/4}\}.$$

The zero-sample flag is good. The numerical entries of $\theta^0$ are fixed policy design constants, used under every true parameter; the learner is not given the unknown environment.

In **inactive mode**, route by $x(t)=(1-p(t))x^0+p(t)q$ and use FCFS at both servers. Immediately after a completion, if any current flag is bad, select the lexicographically first bad edge $e=(i,j)$ and start an **active episode**. During this episode freeze routing at $q$, and give nonpreemptive strict priority to type $i$ at server $j$, retaining FCFS within each type. The other server uses FCFS. A service already begun is not interrupted. End this episode at the next completion on its particular target edge. Completions elsewhere update their observations but cannot change the target. On ending, update the target's flag and retest all flags: start a new episode if any is bad, otherwise return to inactive mode.

All decisions use revealed information. The target stays fixed until its completion. This detail prevents unrelated bad flags from prolonging an episode and is essential to the expected-time proof. Let $U(t)$ denote the active-mode indicator.

## Stable domination and infinitely many samples

For each server construct a dominating queue $Z_j$ that receives a birth at every system arrival, of total rate one, and uses the actual rate-three potential-service clock. Start each marginal dominator in its stationary geometric law with ratio $1/3$. Their common arrivals may make the dominators dependent, which does not affect the argument. Total queue length is unaffected by the identity selected under a work-conserving priority discipline. Thus

$$
Q_j(t)\le Z_j(t),\qquad
\sup_t\mathbb E Q_j(t)\le\frac12,\qquad
\sup_t\mathbb E Q_j(t)^2<\infty.
\tag{36}
$$

Each dominator visits zero infinitely often almost surely. At those times the actual queue is empty, so every assigned job completes in finite time even though priorities can change.

In both modes, the conditional routing probability from each type to either server is at least $p(t)/2$. Realize the server choice by an independent uniform mark. The deterministic intervals $[0,p(t)/2]$ and $[1-p(t)/2,1]$ always lead to servers one and two respectively. For each edge they supply a nonhomogeneous Poisson subset of assignments of deterministic rate $\lambda_i p(t)/2$. Its integrated intensity diverges, hence every edge receives infinitely many jobs almost surely. Eventual service then proves

$$D_e(t)\longrightarrow\infty\quad\text{almost surely for every edge.}$$

This proof precedes and does not assume flag stabilization. Moreover, geometric tails give $\sum_n\Pr(Z_j(n)>\eta n)<\infty$ for every $\eta>0$. Between integers the queue is bounded by its initial length plus that interval's total Poisson arrivals; the latter also have summable linear-threshold tails. Borel--Cantelli yields

$$Q_j(t)/t\longrightarrow0\quad\text{almost surely.}$$

## Classification and consistency at every parameter

Fix any true $\theta$. When $\theta_e=\theta^0_e$, Poisson Chernoff inequalities imply

$$
\Pr_\theta(B_e(n))
\le2\exp\left(-\frac{\sqrt n}{2(\theta^0_e+1)}\right).
\tag{37}
$$

Here is a direct bound sufficient for (37). For $u>0$, the upper-tail rate
$(\theta+u)\log(1+u/\theta)-u$
is $\int_0^u\log(1+s/\theta)ds\ge u^2/[2(\theta+u)]$.
The lower-tail rate for $u\le\theta$ is at least $u^2/(2\theta)$; for $u>\theta$ the lower event is impossible. Apply these at $u=n^{-1/4}\le1$ and $\theta=\theta_e^0\ge1$. The resulting probabilities are summable, so equal-coordinate flags are eventually good at every sample level.

For a differing coordinate, the iid strong law gives
$|\widehat\theta_e(n)-\theta_e^0|\to|\theta_e-\theta_e^0|>0$;
its shrinking threshold means the flag is eventually bad at every sample level. There are only four coordinates and all counts tend to infinity. After an almost-surely finite time the current flags have their permanent correct classification, and any episode in progress then finishes in finite time.

It follows that at $\theta^0$ the policy eventually remains inactive. At every $\theta\ne\theta^0$, it eventually routes exactly by $q$ and always targets the lexicographically first differing coordinate, with its corresponding fixed priority rule.

For clarity, rate convergence does not require conditioning at this last stabilization time. For any edge its assignment count $A_e$ has predictable compensator $I_e(t)=\int_0^tx_e(s)ds$ and martingale $M_e=A_e-I_e$, with $\mathbb E M_e(t)^2\le\lambda_i t$. Doob's inequality gives

$$
\Pr\left\{\sup_{s\le2^k}|M_e(s)|>\eta2^k\right\}
\le\frac{\lambda_i}{\eta^2 2^k}.
$$

The series converges, so a dyadic comparison gives $M_e(t)/t\to0$ almost surely. The eventual routing regimes and $p(t)\to0$ imply

$$
\frac{D_e(t)}t\longrightarrow
\begin{cases}
x_e^0,&\theta=\theta^0,\\
q_e>0,&\theta\ne\theta^0,
\end{cases}
\qquad\text{almost surely},
\tag{38}
$$

using $D_e=A_e-Q_e$ and the sublinear backlog. At $\theta^0$ both optimal edges have positive limits, and at every other parameter all four edges do. Therefore (29) holds, and indeed its under-sampling event eventually fails almost surely for every fixed $b$.

## Finite expected active occupation at the distinguished parameter

An episode targeting edge $e=(i,j)$ at observed sample count $n$ can be charged to the pair $(e,n)$. Such a pair is selected at most once, because the episode ends with a new target completion and counts never decrease. Its selection event is contained in the fixed-stream event $B_e(n)$.

Conditional on the observed history at the episode's stopping-time start, its expected duration is at most

$$C_e=1/q_e+2/\mu_j.$$

If no target-type job is present, wait for its next Poisson arrival, of mean $1/q_e$, under the frozen routing. At most one non-target residual service can precede the target, with mean at most $1/\mu_j$ by exponential memorylessness, followed by one target service of mean $1/\mu_j$. If a target is already present or in service the bound only decreases. The target freeze is what makes this bound independent of future flags and the initial backlog.

Condition at the episode start and then sum by Tonelli. No independence of flag and episode selection is assumed. Equation (37) yields

$$
\mathbb E_{\theta^0}\int_0^\infty U(t)dt
\le\sum_e C_e\sum_{n\ge1}\Pr_{\theta^0}(B_e(n))
\le\frac{12688}{3}.
\tag{39}
$$

For the last constant, put $a_e=1/[2(\theta^0_e+1)]$ and use
$\sum_{n\ge1}2e^{-a_e\sqrt n}\le4/a_e^2$.
The type-one edges have $C_e=17/3$ and the type-two edges have $C_e=4$. Thus the finite sum equals
$16\sum_eC_e(\theta_e^0+1)^2=12688/3$.

## Literal limiting expected backlog at every parameter

For $\theta=\theta^0$, take a fixed reference policy with routing $x^0$ and FCFS. For $\theta\ne\theta^0$, take routing $q$ with the fixed priority determined by the first differing coordinate. Each reference system is a stable finite-class queue with total arrival rate strictly less than three per server. Its empty state is regenerative, with finite mean cycles; from empty its distribution converges to the stationary law. The geometric domination gives convergence of first moments as well.

Start reference and adaptive systems empty at time zero, driven by common system arrivals, routing marks, and potential-service clocks. Both are dominated by the same stationary $Z_j$ from (36). Let $S$ be the almost-surely finite time after which the limiting routing and service regime identified above holds. It need not be a stopping time, and we make no strong Markov assertion at $S$.

Fix $H>0$. The probability $\Pr(S>T-H)$ tends to zero. On its complement, at $\theta\ne\theta^0$ both systems' rules agree throughout $[T-H,T]$. At $\theta^0$ the service rules agree, and their routing can disagree only on sparse-mixture marks, with expected number at most $\int_{T-H}^Tp(t)dt\to0$. If each $Z_j$ visits zero during this window and there are no rule or routing disagreements, each actual/reference pair is simultaneously empty at that visit and its entire labelled state agrees thereafter.

For stationary positive recurrent $Z_j$, the probability of no zero visit in an interval of length $H$ tends to zero as $H\to\infty$. Thus, first taking $T\to\infty$ at fixed $H$, then $H\to\infty$, proves that the coupled states disagree with probability tending to zero. Their uniform second moments and Cauchy--Schwarz give convergence of expected type backlogs. This proves (2) for every parameter, not just boundedness.

At $\theta^0$, the reference has type one only at server one and type two only at server two, so

$$
\lim_T\mathbb E Q_1(T)=\frac{2/5}{3-2/5}=\frac2{13},\qquad
\lim_T\mathbb E Q_2(T)=\frac{3/5}{3-3/5}=\frac14.
\tag{40}
$$

The expected pending counts on the two unpreferred edges tend to zero.

## Capacity and exact regret asymptotics

In either mode every server's assigned intensity is at most $3/5$. Consequently, for every parameter and every $T$,

$$\mathbb E D_j(T)\le\mathbb E A_j(T)\le(3/5)T\le2T,$$

which is (3). At $\theta^0$, identity (25) gives exactly

$$
R_\pi^{\theta^0}(T)=
\frac9{10}\,\mathbb E\int_0^T
\bigl[U(t)+(1-U(t))p(t)\bigr]dt
+\sum_e\theta_e^0\mathbb E Q_e(T).
\tag{41}
$$

The weighted pending term is at most four by (36). Equations (35) and (39) therefore give (31), since
$(9/10)(12688/3)+4=19052/5$.
Moreover, monotone convergence and (40) imply

$$
C_\pi:=\frac9{10}\,\mathbb E\int_0^\infty U(t)(1-p(t))dt<\infty,
$$

$$
\sum_e\theta_e^0\mathbb E Q_e(T)\longrightarrow
4\cdot\frac2{13}+3\cdot\frac14=\frac{71}{52}.
$$

Substitution into (41) proves (30).

## Comparison with the asserted coefficient

At $\theta^0$, the optimal dual is $v=(4,3)$ and $w=(0,0)$. The inactive-edge reduced-cost gaps are $\phi_{12}=3$ and $\phi_{21}=1$. Changing only mean $\theta_{12}$ makes that edge optimal when the new mean exceeds four; changing only $\theta_{21}$ does so when its new mean exceeds three. Taking the KL infima at the thresholds gives

$$
K_{12}=3-\log4>0,\qquad
K_{21}=1-2\log(3/2)>0.
$$

Sequences approaching these thresholds can avoid isolated dual-degenerate alternative values, so imposing the intended nondegenerate subclass does not change the infima. The coefficient in [VKSW26, Theorem 1] is consequently

$$
\frac3{3-\log4}+\frac1{1-2\log(3/2)}>0.
\tag{42}
$$

Equation (30) has a zero limiting logarithmic coefficient. This is a counterexample to the stated theorem under its displayed condition, and also to a version with a liminf conclusion. The argument is not merely an observation of a gap in a published proof; it supplies the full policy and verifies all the relevant model assumptions. Theorem 2 is proved.

The same construction works for any deterministic measurable $p(t)\in(0,1]$ with $p(t)\to0$, $H(T)=\int_0^Tp(t)dt\to\infty$, and $H(T)=o(\log T)$. Its active-time bound is unchanged and $R_\pi^{\theta^0}(T)=(9/10)H(T)+O(1)$. The failure is therefore not specific to $\log\log T$. At other parameters this policy can have linear regret, as permitted by (29). It does not satisfy the efficiency condition used next.

# A replacement information lower bound

The preceding counterexample shows why a rate-free sampling condition cannot supply the quantitative likelihood comparison needed for a logarithmic lower bound. The general distinction between weak consistency and uniform efficiency is classical [SAE13]. We give the queue-specific argument, including the pending-job correction and the observed-history likelihood.

## Assumptions and statement

Allow known server slacks $\epsilon_j>0$ and write $c_j=\mu_j-\epsilon_j\in(0,\mu_j)$. Let $\mathcal P$ be the corresponding feasible routing polytope. A policy chooses predictable $x(t)\in\mathcal P$, retains all jobs, and uses nonanticipating work-conserving service. Rewards are nonnegative independent edge draws, independent of physical primitives, and are revealed only on completion. The reward family and its admissible parameter set $\Theta$ are fixed in advance. Assume the optima under the parameters considered below are unique.

The additional requirement is **uniform efficiency**:

$$
R_\pi^\xi(T)=o(T^a)
\quad\text{for every }\xi\in\Theta\text{ and every }a>0.
\tag{43}
$$

At the true $\theta$, fix a strictly complementary optimal dual and let $\phi_e>0$ be its reduced-cost gap for an inactive edge, meaning $x_e^\theta=0$. Define

$$
\operatorname{Alt}_e(\theta)=
\{\xi\in\Theta:\xi_f=\theta_f\ (f\ne e),\
x_e^\xi>0,\ x^\xi\text{ is the unique optimum}\},
$$

$$
K_e=\inf_{\xi\in\operatorname{Alt}_e(\theta)}
\operatorname{KL}(P_{\theta_e},P_{\xi_e}),
\qquad\inf\varnothing=\infty.
\tag{44}
$$

For alternatives used in the comparison assume the one-observation divergence is positive and finite and that the sequential reward likelihood is integrable. Poisson and interior Bernoulli alternatives satisfy the required factorization and integrability. If some alternatives have infinite divergence, omitting them does not improve the lower bound. All alternatives must remain within the chosen family; a Bernoulli mean cannot be increased beyond one.

**Theorem 3 (uniformly efficient feasible-rate lower bound).** Under these assumptions, for each inactive edge,

$$
\liminf_{T\to\infty}\frac{\mathbb E_\theta D_e(T)}{\log T}
\ge\frac1{K_e},
\tag{45}
$$

and

$$
\liminf_{T\to\infty}\frac{R_\pi^\theta(T)}{\log T}
\ge\sum_{e:\,x_e^\theta=0}\frac{\phi_e}{K_e}.
\tag{46}
$$

Here $1/\infty=0$ and $1/0=+\infty$; if $K_e=0$ the right side of (45) is infinite. No strict positivity is claimed when admissible confusing alternatives are absent. This theorem does not assert that (43) is the weakest sufficient condition.

## Nonnegative regret and true-environment under-sampling

The compensator and conservation identity (25) holds with nonnegative rewards. Both terms are nonnegative. If $v_i,w_j$ are optimal row potentials and capacity prices, duality gives for every feasible $x$,

$$
v^*(\theta)-\theta\cdot x
=\sum_e\phi_ex_e+\sum_jw_j\left(c_j-\sum_ix_{ij}\right)
\ge\sum_{e:\,x_e^\theta=0}\phi_ex_e.
$$

It follows that

$$
R_\pi^\theta(T)
\ge\sum_{e:\,x_e^\theta=0}\phi_e\mathbb E_\theta A_e(T)
\ge\sum_{e:\,x_e^\theta=0}\phi_e\mathbb E_\theta D_e(T).
\tag{47}
$$

Thus (43) implies $\mathbb E_\theta D_e(T)=o(T^a)$ for every $a>0$ on an inactive edge.

## Quantitative under-sampling probability under an alternative

Fix $\xi\in\operatorname{Alt}_e(\theta)$ and put $x'=x^\xi$, $x'_e>0$. The finite vertex set and uniqueness imply the existence of a finite constant $B$ such that

$$
(x'_e-x_e)_+\le B[v^*(\xi)-\xi\cdot x]
\quad\text{for all }x\in\mathcal P.
\tag{48}
$$

For example take the maximum, over nonoptimal vertices $v$, of
$(x'_e-v_e)_+/[v^*(\xi)-\xi\cdot v]$, and extend by convexity. This maximum is positive because the original optimum has zero $e$ coordinate and is nonoptimal under $\xi$.

Let $I_e(T)=\int_0^Tx_e(t)dt$ and
$G(T)=\int_0^T[v^*(\xi)-\xi\cdot x(t)]dt$.
If $I_e(T)<3x'_eT/4$, integration of (48) gives
$G(T)>x'_eT/(4B)$. Hence

$$
\Pr_\xi\{I_e(T)<3x'_eT/4\}
\le\frac{4B R_\pi^\xi(T)}{x'_eT}.
\tag{49}
$$

For the assignment count with compensator $I_e$, the process
$\exp[-sA_e+(1-e^{-s})I_e]$ is a nonnegative supermartingale. At $s=\log(3/2)$,

$$
\Pr_\xi\{A_e(T)\le x'_eT/2,\ I_e(T)\ge3x'_eT/4\}
\le e^{-\kappa x'_eT},
\quad\kappa=\tfrac14-\tfrac12\log(3/2)>0.
\tag{50}
$$

The feasible-rate domination used for (13) applies to total queue length under any nonanticipating work-conserving discipline, since service is type-independent exponential. In particular $\mathbb E_\xi Q_e(T)\le B_Q<\infty$ uniformly. From $D_e=A_e-Q_e$, (49)--(50), and Markov's inequality,

$$
\Pr_\xi\{D_e(T)\le x'_eT/4\}
\le\frac{4B R_\pi^\xi(T)}{x'_eT}
+\frac{4B_Q}{x'_eT}+e^{-\kappa x'_eT}
=o(T^{a-1})
\tag{51}
$$

for every $a>0$. The $O(T^{-1})$ queue term is $o(T^{a-1})$ for each such $a$. This quantitative probability bound is the step that weak condition (29) does not supply.

## Revealed-history change of measure

Let $E_T=\{D_e(T)\le x'_eT/4\}$. Equation (47) and Markov's inequality imply $\Pr_\theta(E_T)\to1$. Equation (51) gives the required polynomially small probability under $\xi$.

Only edge $e$'s revealed reward law changes between the two environments. All service, arrival, and policy kernels are identical conditional on the revealed history. Each next reward is exposed after the decision to complete its job, and its hidden value cannot have affected that decision. Sequential likelihood factorization and its expectation therefore yield

$$
\operatorname{KL}\bigl(\mathcal L_\theta(\mathcal H_T),
\mathcal L_\xi(\mathcal H_T)\bigr)
=\mathbb E_\theta D_e(T)
\operatorname{KL}(P_{\theta_e},P_{\xi_e}).
\tag{52}
$$

The history $\mathcal H_T$ contains actions, arrival and completion events, and revealed rewards. It excludes all unrevealed values in the analysis-only infinite reward streams. Inserting those latent streams into the likelihood would invalidate the finite-observation identity. The expected number of observations is finite because completions are bounded by exogenous arrivals; the assumed likelihood integrability justifies the conditional-expectation sum, or equivalently truncation followed by convergence. The physical delay contributes no extra likelihood factor.

Apply data processing to $\mathbf1_{E_T}$ and the binary-entropy bound to obtain

$$
\mathbb E_\theta D_e(T)\operatorname{KL}(P_{\theta_e},P_{\xi_e})
\ge\Pr_\theta(E_T)\log\frac1{\Pr_\xi(E_T)}-\log2.
\tag{53}
$$

For any $0<a<1$, divide by $\log T$ and use (51). The right side has liminf at least $1-a$. Let $a\downarrow0$, then optimize over legal alternatives. This proves (45), including its empty-set and zero-infimum conventions. Finally use (47) and the finite sum of nonnegative terms to get (46). Theorem 3 is proved.

# An extension allowing arbitrary degeneracy and additional constraints

The basis certificate in Theorem 1 uses nondegeneracy to turn a unique vertex optimum into strict negativity of every reduced cost of its chosen basis. A degenerate vertex can have different optimal bases for different objectives, even when the primal point stays optimal. We now replace the basis test by a sufficient certificate that fixes only the common primal optimizer. It allows arbitrary degeneracy without changing the sample threshold or regret constants.

Robust optimality for uncertain LP objectives and outer approximation are established subjects; Gao and Inuiguchi [GI23] study these questions directly. We use an elementary enclosing cross-polytope as a certificate within the queue-learning theorem, not as a claim to invent geometric robust optimality.

## Extended theorem and certificate

Let $\mathcal F$ be any known nonempty compact polytope contained in the physical routing polytope $\mathcal P$. It may impose additional linear allocation constraints and may be lower-dimensional or arbitrarily degenerate. Assume the true objective has a unique maximizing vertex $x^*$ over $\mathcal F$. Define its vertex gap $\Delta$ over the other vertices of $\mathcal F$, and define $m_e$, $x^{(e)}$, and $q^0$ as in (5), with optimization over $\mathcal F$. If $\mathcal F$ has one vertex, use it forever as before.

At a decision time write $a=\widehat\theta$ and choose an empirical maximizing vertex $v\in\mathcal F$. Keep exactly the confidence radii and box from (6)--(7). For each edge $e$ and sign $\sigma\in\{-1,1\}$, form the objective

$$
c^{e,\sigma}=a+\sigma M r_e u_e,
\tag{54}
$$

where $u_e$ is the coordinate unit vector. Solve the $2M$ LPs maximizing these objectives over $\mathcal F$. Certify $v$ if and only if

$$
\max_{x\in\mathcal F}c^{e,\sigma}\cdot x
=c^{e,\sigma}\cdot v
\quad\text{for every }e,\sigma.
\tag{55}
$$

Different tests may use different optimal bases and different dual witnesses. Some coordinates of $c^{e,\sigma}$ may be negative or exceed one; these are optimization objectives used for certification, not reward parameters. If numerical exactness cannot be established, the test must refuse certification. Replace only the certificate step of the previous policy by (55); retain the same coins, exploration matrix, stored vertex, and timestamp refresh rule.

**Theorem 4 (degenerate feasible-subpolytope upper bound).** Under the physical and bounded-reward assumptions of Theorem 1, let $\mathcal F\subseteq\mathcal P$ be as above, without any primal or dual nondegeneracy hypothesis. The policy using (54)--(55) satisfies exactly bound (11), with $\Delta$ and the optimum taken over $\mathcal F$. The comparator is $\max_{x\in\mathcal F}\theta\cdot x$. It satisfies the all-time physical capacity constraint (3), retains every job, and has the same literal expected-backlog limit (12). Initialization uses $M$ linear optimization calls over $\mathcal F$; each slot uses at most $2M+1$ calls. There is no enumeration of vertices or dependence on the smallest positive basic coordinate or routing rate.

The oracle count describes arithmetic optimization operations. It is not a claim of bounded rational bit complexity for irrational confidence radii or arbitrary numerical solvers. The theorem uses exact optimization and equality certificates. A conservative numerical refusal rule guarantees soundness only; to inherit the regret bound it must also be proved to accept on the positive-margin event in (58), for example by verified primal-dual certificates. The test is sufficient for robust optimality over the original box; it need not be necessary.

## Soundness of the enclosing certificate

The full unclipped box $\{a+d:|d_e|\le r_e\}$ lies in

$$
\operatorname{conv}\{a+\sigma M r_e u_e:
e\in\mathcal E,\ \sigma\in\{-1,1\}\}.
\tag{56}
$$

To verify this directly, put $t_e=d_e/r_e$ and
$w_e^+=\max(t_e,0)/M$, $w_e^-=\max(-t_e,0)/M$.
These weights sum to $M^{-1}\sum_e|t_e|\le1$; the weighted displacement from $a$ is exactly $d$. Put any remaining weight on $a$, which itself is the midpoint of either opposite pair of axis points. This produces a convex combination of the points in (56). Our radii are positive at every finite decision time. If a different implementation admits zero radii, the corresponding displacements and weights are zero; if all radii are zero, the empirical LP alone suffices.

If $v$ maximizes each objective in (56), then for every $x\in\mathcal F$ its optimality inequalities may be multiplied by the convex weights and summed. Hence it maximizes every objective in their convex hull, and therefore every objective in the clipped box $\mathcal C_n$. A successful certificate on $G_n$ is thus truly optimal, regardless of how many bases represent $v$.

## Success at the unchanged sample threshold

The proof of (17) actually gives the coordinatewise inequalities

$$
m_er_e\le\frac{\Delta}{16M}\quad\text{for every edge},
\qquad\sum_e m_er_e\le\frac{\Delta}{16},
\tag{57}
$$

on the good event when $S_n\ge K\log(n+2)$. The argument uses only $q_e^0\ge m_e/M$, $m_e\le\Lambda$, geometric queue domination, and the vertex gap. All hold for $\mathcal F\subseteq\mathcal P$.

On $G_n$, $|a_e-\theta_e|\le r_e$. For every other vertex $w\in\operatorname{vert}(\mathcal F)$ and each axis objective,

$$
\begin{aligned}
c^{e,\sigma}\cdot(x^*-w)
&\ge\theta\cdot(x^*-w)-\sum_fm_fr_f-Mm_er_e\\
&\ge\Delta-\Delta/16-\Delta/16
=7\Delta/8>0.
\end{aligned}
\tag{58}
$$

The same inequality without its last loss term makes $x^*$ the unique empirical optimum. Thus the empirical vertex selected in the first LP is $v=x^*$, and all $2M$ axis tests succeed. This argument uses the finite vertex representation of a compact polytope only in the proof; it does not enumerate vertices in the algorithm and does not require any feasible direction associated with a degenerate basis.

## Transfer of the stochastic argument

We spell out exactly what is reused. Every allocation remains in $\mathcal F\subseteq\mathcal P$, so its row sums and server intensity caps are unchanged. The proposal-process construction, geometric domination, prefix confidence bound, and adaptive exploration martingale therefore apply with the same constants. The two certificate implications used in (19) are:

1. A successful certificate on $G_n$ is truly optimal.
2. On the combined good event, $S_n\ge K\ell_n$ forces a successful current certificate.

The convex-hull proof establishes the first; (57)--(58) establish the second. Thus the same event $F_n$ has probability at most $C(n+2)^{-12}$. The pathwise exploration count (20), recent-wrong-certificate estimate (21), and independent-coin freshness argument (22)--(24) depend on no further feature of a basis, and give the same bounds. The completion identity (25) is physical and unchanged, proving (11) for the new comparator. Finally (26) still gives convergence in probability to the unique $x^*$; the finite-window coupling (27)--(28) and uniform second moments prove (12). This proves Theorem 4 with all assumptions and constants specified.

## Optimizing the exploration coverage

The dimension factor in the exploration coverage can be replaced by a property of the feasible polytope. After obtaining $m_e$, let $\mathcal E_+=\{e:m_e>0\}$ and solve one additional LP:

$$
\eta^*=\max\{\eta:q\in\mathcal F,\ q_e\ge\eta m_e
\text{ for all }e\in\mathcal E_+\},
\qquad\kappa=1/\eta^*.
\tag{59}
$$

The set $\mathcal E_+$ is nonempty because the total arrival rate is positive. The averaged allocation (5) proves $\eta^*\ge1/M$, while $q_e\le m_e$ proves $\eta^*\le1$. Hence $1\le\kappa\le M$. Use an optimizing $q$ as the exploration allocation instead of the coordinatewise average.

**Corollary 4.1 (optimized feasible exploration).** All statistical and queue conclusions of Theorem 4 hold after the replacement below. Initialization now uses $M+1$ LP calls, including the coverage optimization (59); each slot still uses at most $2M+1$ calls. Replace $K$ everywhere, including its occurrence in $N_0$, by

$$
K_\kappa=1+\frac{4096\kappa M^2\Lambda}{\Delta^2}
+\frac{32\kappa M(b_0+64)}{\Delta}.
\tag{60}
$$

**Proof.** The only coverage property required for the completion threshold is $q_e\ge m_e/\kappa$. The first principal term of $q_eK_\kappa/2$ is at least
$2048M^2m_e\Lambda/\Delta^2\ge2048M^2m_e^2/\Delta^2$.
On a large edge the second term is
$16M m_e(b_0+64)/\Delta>b_0+64$.
These imply both (17) and $q_eK_\kappa\ge128$, which were precisely the two inequalities used in the arrival and radius bounds. All confidence, queue, exploration-count, and freshness estimates are otherwise unchanged. This proves the claim.

The coverage optimum also has the exact minimax characterization

$$
\eta^*=\min_{p\in\mathcal D(\mathcal E_+)}
\max_{q\in\mathcal F}\sum_{e\in\mathcal E_+}p_e\frac{q_e}{m_e},
\tag{61}
$$

where $\mathcal D$ denotes the probability simplex. For fixed $q$, the minimum over $p$ is $\min_e q_e/m_e$. The compact convex feasible sets and bilinear payoff permit interchange of minimum and maximum by finite-dimensional minimax, equivalently LP duality. This proves (61). It identifies the least-covered relative coordinate of the best feasible exploration allocation. Neither this classical max-min LP nor the minimax principle is claimed as new, and $K_\kappa$ is not asserted to be a statistically optimal regret coefficient.

## An exact degenerate instance

Take $K_{2,2}$, $\lambda_1=\lambda_2=1/2$, $\mu_1=\mu_2=3/2$, and $\epsilon=1/2$, so each server cap is one. The physical routing polytope contains

$$
v=(x_{11},x_{12},x_{21},x_{22})=(1/2,0,1/2,0).
$$

Its standard-form equality matrix has rank four and six nonnegative variables: four flows and two slacks. At this point only $x_{11},x_{21},s_2=1$ are positive. Consequently every basis representing it is degenerate. For
$a=(4/5,1/5,7/10,1/10)$ it is the unique optimum, of value $3/4$. Let every radius be $1/100$. Each of the eight axis objectives changes a row advantage by at most $4/100$, whereas both initial row advantages are $3/5$. Therefore every test retains server one as the preferred server for both types and (55) passes. This example shows a case covered by Theorem 4 beyond the assumptions of Theorem 1. Exact rational feasibility, primal-dual objective equality, and the rank/support calculation can be checked independently of simulation.

# Exact minimax completion regret in a symmetric learning queue

## Model and exact value

Let two independent arrival types have rate \(c=\mu-\eta>0\) each, and let both independent exponential servers have service rate \(\mu\), with \(0<\eta<\mu\). All edges are available. The system starts empty, service is work-conserving FCFS at each server, routing is irrevocable, and a job's reward is disclosed upon completion. The rate matrix is chosen predictably, before observing the next type, with row sums \(c\) and column caps \(c\). The constraints make it \(c\) times a \(2\times2\) doubly stochastic matrix, of the form
\[
c\begin{pmatrix}p&1-p\\1-p&p\end{pmatrix},\qquad 0\le p\le1.
\]
An unknown \(s\in\{-1,+1\}\) determines independent Bernoulli rewards. The diagonal mean is \((1+s\Delta)/2\) and the off-diagonal mean is \((1-s\Delta)/2\), where \(0\le \Delta\le1\). Let \(\theta_+=(1+\Delta)/2\). The benchmark is \(2cT\theta_+\), the optimal static reward rate multiplied by \(T\).

For a physical arrival at \(\tau\), let \(\xi\) be its completion time. Let \(D(t)\) and \(Q(t)\) be total completions and pending jobs. For \(\ell\) independent samples, define the equal-prior majority error
\[
e_\Delta(\ell)=\Pr\{\operatorname{Bin}(\ell,\theta_+)<\ell/2\}
+\tfrac12\Pr\{\operatorname{Bin}(\ell,\theta_+)=\ell/2\}.
\]

**Theorem 5 (finite time).** The minimal worst-case expected completion regret over the two reward environments, within the predictable, pointwise feasible FCFS class, equals
\[
R^*(T)=\theta_+\,\mathbb E Q(T)
       +\Delta\,\mathbb E\!\sum_{\tau\le T:\,\xi\le T}
                         e_\Delta(D(\tau-)).
\]
Choose the better direction by majority of the corrected completed rewards, with a fair random tie. This strategy does not use \(\Delta\) or \(T\) and satisfies the original expected backlog and departure conditions.

**Proof.** View the combined arrivals as a rate-\(2c\) Poisson process. At each arrival select a server uniformly and independently, then select its type conditionally so the probability of matching that server's label is \(p\). The resulting conditional joint law of type and server is exactly the joint law obtained by first drawing an independent uniform type and using the prescribed rate matrix. This holds for the full history by iterating the conditional identity, because \(p\) is predictable. Consequently the unlabelled queues are two independent \(M/M/1(c,\mu)\) queues. Given their arrivals and service primitives, FCFS determines who completes at time \(T\), regardless of routing direction or reward.

For a diagonal job use its reward \(Y\) as the corrected vote, and for an off-diagonal job use \(1-Y\). Either orientation leads to a \(\operatorname{Bernoulli}((1+s\Delta)/2)\) vote. Draw these votes independently of the unlabelled physical processes, indexed by physical job or by its predetermined completion order, to construct the required joint law. Conditional on the full unlabelled path, the likelihood of the observed history under each \(s\) factors into the likelihood of its completed votes and common conditional factors for past orientations, types, and auxiliary randomness. The unlabelled path carries no likelihood factor depending on \(s\). In particular it gives no privileged information when using it to identify the jobs that finish before \(T\).

Under equal prior odds on \(s\), each such job has a minimum conditional misrouting risk achieved by choosing the direction with higher posterior probability; the rule is majority of the already completed corrected votes, with randomized ties. A feasible \(p\) mixes these two directions and cannot improve on a majority decision. The same rule attains every jobwise minimum without using future information. The averaged probability of error at sample count \(\ell\) is \(e_\Delta(\ell)\). For every strategy, each job still pending loses \(\theta_+\) relative to the fluid benchmark, and the extra expected loss of a completed but misrouted job is \(\Delta\). Taking expectations uses the arrival mean \(2cT\). Swapping one side's labels sends \(s\) to \(-s\), reverses the votes and interchanges majority decisions, so the majority strategy has equal risk in the two environments. Its Bayes risk is therefore its minimax risk.

Each server has at most its own cumulative arrivals as completed jobs, giving the required expectation bound \(cT\). Interchanging both server and type labels preserves the parameter and the majority rule, so the expected backlog of each type is \(\mathbb E Q(T)/2\) at all times. With \(c<\mu\), starting each queue below its stationary geometric version in the same-clock coupling gives uniform integrability and convergence of expected backlog. At \(\Delta=0\) the formula reduces to \(\mathbb E Q(T)/2\); at zero available votes the error is \(1/2\). \(\square\)

## Simultaneous congestion and information scaling

**Theorem 6 (two critical scales).** Along a sequence with \(t=\mu T\to\infty\), \(\eta\sqrt{T/\mu}\to b\in[0,\infty)\), and \(\Delta\sqrt{\mu T}\to d\in[0,\infty)\), the same model has
\[
\frac{R^*(T)}{\sqrt{\mu T}}
\longrightarrow \mathbb E\sup_{0\le z\le1}(\sqrt{2}\,W_z-bz)
+2d\int_0^1\Phi(-d\sqrt{2z})\,dz .
\]
Here \(W\) is standard Brownian motion, \(\Phi\) is the standard normal distribution function, and \(b=0\) is permitted as a limit along positive slacks.

**Proof.** At each server, reflect the difference of independent arrival and potential service Poisson clocks. On the rescaled time interval both centered Poisson clocks have asymptotic variance rate one, and the net drift tends to \(-b\). The functional Poisson limit and continuity of reflection give convergence of the endpoint queue length. The supremum is bounded in second moment by Doob's inequality applied to the centered noise, with bounded rescaled drift. Thus the expected endpoint queue length also converges. By reversal of Brownian increments, the reflected endpoint has the law of the displayed maximum. The two servers and \(\theta_+\to1/2\) yield the first term.

For each fixed \(z>0\), conservation and the same Poisson scaling give \(D(Tz)/t\to2z\) in probability. The conditional binomial standardized mean shift tends to \(d\sqrt{2z}\), with a vanishing tie atom. The binomial central limit theorem and the bound \(0\le e_\Delta\le1\) imply convergence in mean of \(e_\Delta(D(Tz))\) to \(\Phi(-d\sqrt{2z})\). Changing the sum to all arrivals by \(T\) has expected cost difference at most \(\Delta\mathbb EQ(T)\), which vanishes after division by \(\sqrt t\). Since \(e_\Delta(D(\tau-))\) is predictable, the expected sum over arrivals is \(2c\int_0^T\mathbb E e_\Delta(D(v-))\,dv\). Bounded convergence and \(c/\mu\to1\) give the second term. \(\square\)

The predictable instantaneous feasible set is essential to the independent server split. The result concerns two symmetric reward laws and does not extend to arbitrary reward vectors or compatibility graphs. The status of the source model's hypotheses at exact zero slack differs from the positive-slack regime in Theorem 5. The next section treats zero slack and a separate broader physical routing class for known all-one rewards.

# Pure congestion at the boundary

## The single critical server

With one arrival type and one exponential server, both rates equal to \(\lambda>0\), known unit completion rewards and an initially empty system, impose no losses and compare with the fluid benchmark \(\lambda T\). For finite-horizon physical scheduling,
\[
\inf_{\pi}\{\lambda T-\mathbb E D_\pi(T)\}
\sim 2\sqrt{\lambda T/\pi}.
\]
On the same arrival and potential service clocks, serving whenever possible maximizes the cumulative departure count. The reflected net count \(X(t)=A(t)-S(t)\) has at time \(T\) the same law as \(\sup_{s\le T}X(s)\) by reversal of stationary independent increments. The Poisson functional limit and Doob's maximal inequality give convergence of the rescaled expectation. The reflection principle gives mean \(\sqrt{2/\pi}\) for the maximum of a unit Brownian motion on \([0,1]\). Conservation gives the stated constant. In particular there can be no admissible policy at exact criticality if finite limiting expected backlog is also required.

## Two irrevocable queues with known unit rewards

Consider two rate-\(\mu\) servers with aggregate arrival rate \(\lambda_T=2\mu-\eta_T>0\), arbitrary Poisson types compatible with both servers, and irreversible routing. Assume \(0\le\eta_T\le\mu/2\), with rates fixed within each system. Here actions may depend on queue lengths, with the original departure and finite-limiting-backlog requirements used for positive slack. The zero-slack endpoint uses finite-horizon physical rules. Let \(U(t)\) be the reflection of the aggregate arrival count minus the two independent potential completion counts. Then
\[
\mathbb E U(T) \le \inf_\pi R_\pi(T)\le R_{\mathrm{JSQ}}(T)
\le \mathbb E U(T)+O_\mu(\log(2+T)).
\]
Here JSQ routes to a shortest queue with fair ties. The pooled reflection is a pathwise lower bound for all physical backlog with no losses: the unused opportunity count is a nondecreasing regulator for the same net process. For JSQ, the difference \(Z=|Q_1-Q_2|\), when positive, has upward jump rate at most \(\mu\) and downward rate at least \(2\mu\). The optional stopping bound for \(2^Z\) gives probability at most \(1/(2^k-1)\) for an excursion from one to reach \(k\). Excursions launch at rate at most \(4\mu\), so summing the tail gives \(\mathbb E\sup_{s\le T}Z(s)=O_\mu(\log(2+T))\). At the last unused opportunity before \(T\), at least one queue is empty, so aggregate backlog there is \(Z\). After it, the physical regulator is constant and the pooled one is nondecreasing. This proves the sandwich by conservation.

For each positive slack, the generator applied to \(q_1^2+q_2^2\) is at most \(2\lambda_T\min(q_1,q_2)-2\mu(q_1+q_2)+4\mu\), which is at most \(-\eta_T(q_1+q_2)+4\mu\). The associated nonexplosive countable-state chain is positive recurrent on the class reached from zero with finite first moment. A same-clock coupling, including common tie preferences, preserves coordinatewise order, so the stationary version dominates the process started empty. Expected backlog converges by uniform integrability; class labels are independent of the unlabelled queues and their service, and exchangeability gives per-server expected departures at most \(\lambda_T T/2\).

When \(\eta_T\sqrt T\to a\ge0\), reversal, the Poisson functional limit and the above error bound yield
\[
\frac{\inf_\pi R_\pi(T)}{\sqrt T}\to
\mathbb E\sup_{0\le u\le1}(2\sqrt{\mu}\,B_u-au).
\]
For \(x=a/(2\sqrt{\mu})>0\), integrating the drifted Brownian reflection formula gives \(2\sqrt{\mu}[\varphi(x)-x\Phi(-x)+(2\Phi(x)-1)/(2x)]\). At \(a=0\) the value is \(2\sqrt{2\mu/\pi}\). If instead \(\eta_T\to0\), \(\eta_T\sqrt T\to\infty\), and \(\eta_T\log(2+T)\to0\), the all-time maximum of the input walk gives the upper bound \(2\mu\) for \(\limsup\eta_T\inf_\pi R_\pi(T)\), by the exact geometric hitting probability \((\lambda_T/(2\mu))^k\). For the lower bound restrict to the first \(L/\eta_T^2\) time units, take the Brownian scaling limit, and then \(L\to\infty\); the maximum of variance-rate-\(4\mu\) Brownian motion with drift \(-1\) has mean \(2\mu\). This gives the same limit. These classical pooled and JSQ comparisons for known rewards give a point of reference for the two independent physical queues under the predictability constraint of Theorem 5.

# Relation to earlier results and verification evidence

## What changes, and what is already known

The published queue paper's upper bound is polylogarithmic rather than exact logarithmic, and its discussion already identifies edge observation sharing and LP implementation as promising. Our theorem proves the completion objective, the edge and gap dependence, and the original limiting-backlog condition for a single anytime policy. These combined guarantees, rather than the LP oracle alone, are the claim.

The abstract description of learning under queue-induced delay also predates this manuscript. Fu--Modiano [FM22] give an $O(\log^5T\log\log T)$ learned bound in a different queueing setup; their known-parameter result and broad abstract wording should not be confused with an exact learned $O(\log T)$ theorem in our setting. Their policy includes discarding queues when a forest changes. Steiger--Li--Lu [SLL24] explicitly handle correlated queue-induced delay with additional constraints and square-root-order guarantees. Comparing rates without the respective benchmarks, gaps, slack, and no-discard requirements would be misleading.

The delayed-UCB outstanding-feedback mechanism [JGS13], the no-delay triggering-probability argument and infinite action oracle [WC17], and the recent adaptive-delay linear-bandit guarantee [SZM26] establish substantial portions of the surrounding methodology. They do not alone prove the predictable-intensity queue realization, the completion conversion, or the literal expected-backlog limit used here. We make no generic claim to have introduced delayed logarithmic regret, endogenous delays, or action-oracle bandits.

Similarly, the role of consistency strength in information lower bounds is classical [SAE13]. Our priority construction verifies the exact physical admissibility and geometric assumptions of one recent theorem, at a nondegenerate Poisson instance with its explicitly positive claimed coefficient. Theorem 3 is an application of standard information principles with the queue-specific rate and pending-job details made explicit. We do not claim a new general theory of statistical superefficiency.

## Reproducibility and formal scope

The [reproduction instructions](evidence/README.md) locate the certified deterministic examples and original case programs. [`code/check_counterexample_bases.py`](evidence/code/check_counterexample_bases.py) enumerates the small witness's primal and dual bases in exact rational arithmetic and checks its slack restriction. [`code/robust_certificate.py`](evidence/code/robust_certificate.py) implements the affine reduced-cost box maximum using exact rational inputs and does not enumerate all routing vertices. [`code/simulate.py`](evidence/code/simulate.py) realizes arrival and service events, completion-only rewards, frozen priority episodes, and flow conservation. Its `mean_weighted_completion_regret_path` records the benchmark minus mean-weighted realized completion counts, not the realized sum of sampled rewards. The latter is used for learning, but the displayed count-based diagnostic still has arrival and completion fluctuations and need not equal integrated assignment loss plus pending reward pathwise. Its expectation has the identity (25). Simulation is a diagnostic of implementation and finite-horizon behavior; it proves neither the asymptotic order nor the theorem's generality. The reproduction notes document the code's zero-based slot convention and its finite indexing shift from the one-based presentation here.

The formalization directory contains Lean statements for deterministic confidence-box algebra, perturbation inequalities, completion accounting, the witness optimum, and rational witness constants. Its logs and axiom report specify which declarations were compiled. A proof of these components is not a formal proof of the stochastic concentration, adaptive queue coupling, expected occupation, or change-of-measure results. Those remain explicit full-formalization obligations. No theorem in this manuscript is represented as fully Lean-verified merely because a bound was included as an assumed structure field.

The dated literature audit is a targeted search for collisions, not a proof of worldwide priority. The repository's independent reviews record mathematical objections and their resolution, and separate research value from correctness. The source papers themselves are referenced rather than republished in the case.

# Limitations and further questions

The upper bound has deliberately conservative constants and does not match the coefficient in Theorem 3. A sharper allocation of exploration among information constraints could substantially improve $M$ and $\Delta$ dependence, but would require a separate proof. No claim is made that the inverse-gap exponent or the finite-time transient is optimal. The fixed-slack bound uses geometric domination. The two critical-scale results concern the specified symmetric submodel, and the zero-slack endpoint uses finite-horizon physical scheduling. An all-graph transition with unknown edge means remains open.

Theorem 4 removes the nondegeneracy restriction and permits additional known linear allocation constraints, but retains a unique optimal vertex. Multiple optimal vertices would require a different convergence target and a replacement for the positive vertex gap. Service-rate learning, type-dependent service, heavy-tailed rewards, and nonexponential service also require new hypotheses or analysis. The counterexample's priority episodes are used only to obtain a uniform expected target-completion time; both upper-bound policies remain FCFS throughout.

The old deterministic Lean coverage is recorded with the source archive. Full Lean formalization of the integrated manuscript will be delivered separately.

# References

**[VKSW26]** Sanne van Kempen, Jaron Sanders, Fiona Sloothaak, and Maarten G. Wolf. *Learning Payoffs While Routing in Skill-Based Queues*. Stochastic Systems 16(2):140--164, 2026. DOI: [10.1287/stsy.2024.0095](https://pubsonline.informs.org/doi/full/10.1287/stsy.2024.0095). [Official supplementary material](https://pubsonline.informs.org/doi/suppl/10.1287/stsy.2024.0095/suppl_file/stsy.2024.0095.sm1.pdf). The publication supplies the equation numbering used here; the earlier author preprint is [arXiv:2412.10168](https://arxiv.org/abs/2412.10168).

**[JGS13]** Pooria Joulani, András György, and Csaba Szepesvári. *Online Learning under Delayed Feedback*. Proceedings of ICML, PMLR 28(3):1453--1461, 2013. [Original paper](https://proceedings.mlr.press/v28/joulani13.pdf).

**[WC17]** Qinshi Wang and Wei Chen. *Improving Regret Bounds for Combinatorial Semi-Bandits with Probabilistically Triggered Arms and Its Applications*. Advances in Neural Information Processing Systems, 2017. [Original paper](https://proceedings.neurips.cc/paper_files/paper/2017/file/a8e864d04c95572d1aece099af852d0a-Paper.pdf).

**[FM22]** Xinzhe Fu and Eytan Modiano. *Joint Learning and Control in Stochastic Queueing Networks with Unknown Utilities*. Proceedings of the ACM on Measurement and Analysis of Computing Systems 6(3), Article 58, 2022. DOI: [10.1145/3570619](https://doi.org/10.1145/3570619). [Author-hosted paper](https://www.mit.edu/~modiano/papers/CV_J_130.pdf).

**[SLL24]** Juaren Steiger, Bin Li, and Ning Lu. *Backlogged Bandits: Cost-Effective Learning for Utility Maximization in Queueing Networks*. IEEE INFOCOM, 2024. DOI: [10.1109/INFOCOM52122.2024.10621295](https://doi.org/10.1109/INFOCOM52122.2024.10621295). [Author-hosted paper](https://bpb-us-e1.wpmucdn.com/sites.psu.edu/dist/a/136919/files/2024/02/INFOCOM2024_QueueingBandit-268c16c4723624dc.pdf).

**[SAE13]** Antoine Salomon, Jean-Yves Audibert, and Issam El Alaoui. *Lower Bounds and Selectivity of Weak-Consistent Policies in Stochastic Multi-Armed Bandit Problem*. Journal of Machine Learning Research 14:187--207, 2013. [Original paper](https://jmlr.org/papers/volume14/salomon13a/salomon13a.pdf).

**[SZM26]** Ofir Schlisselberg, Mengxiao Zhang, and Yishay Mansour. *Near-Optimal Stochastic Linear Bandits with Delay*. arXiv:2606.16656, 2026. [Primary manuscript](https://arxiv.org/abs/2606.16656). Cited as a preprint; no conference-acceptance claim is made.

**[GI23]** Zhenzhong Gao and Masahiro Inuiguchi. *Robust optimality analysis for linear programming problems with uncertain objective function coefficients: an outer approximation approach*. Kybernetika 59(1):64--87, 2023. DOI: [10.14736/kyb-2023-1-0064](https://www.kybernetika.cz/content/2023/1/64). [Original paper](https://www.kybernetika.cz/content/2023/1/64/paper.pdf).


**[FS78]** Gerard J. Foschini and Jack Salz. *A Basic Dynamic Routing Problem and Diffusion*. IEEE Transactions on Communications 26(3), 1978. Classical shortest-queue routing and diffusion comparison. [DOI](https://doi.org/10.1109/TCOM.1978.1094075).

**[FR24]** Lasse Fischer and Aaditya Ramdas. *Improving Wald’s (approximate) sequential probability ratio test by avoiding overshoot*. [Author manuscript, §1](https://arxiv.org/html/2410.16076v4). The present proof uses only the classical likelihood-ratio rule for independent votes at a given sample count.
