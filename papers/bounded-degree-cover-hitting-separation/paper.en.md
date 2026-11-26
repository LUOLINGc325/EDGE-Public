# Hitting and cover-time robustness separate on bounded-degree graphs

**Research manuscript, 26 November 2026.** Mathematical research draft with written proofs and finite diagnostic checks. No external peer review or machine-checked verification is claimed.

## Abstract

We study worst-case hitting and cover times when an adversary changes the next-step distribution after observing the entire past. Let a fixed-degree regular graph with a fixed absolute spectral gap have a pendant path of length K attached at every vertex, and a further pendant path of length L attached at one root. For 1 ≤ K ≤ min{L,n}, L ≤ nK, and ε(K + log n) sufficiently small, we prove that the worst hitting time is comparable to nK S_L and the worst cover time to nK² log n + nK S_L, uniformly over the root and the expander core. Here S_L is the geometric sum with ratio (1 + ε)/(1 − ε). The same expression applies to both entrywise relative-error adversaries and the stronger edge-supported mixture adversary, with the original ε retained in the geometric sum. Choosing K = ⌈log n⌉ and L = ⌈K√log n⌉ gives hitting robustness of order 1/L and cover robustness of order log log n/L for every sufficiently large fixed multiplicative budget. Thus their ratio diverges even with uniformly bounded maximum degree. The argument combines a full-history trace comparison, a stopped occupation estimate, and a Bellman supersolution that controls the long path without multiplying incompatible worst-case estimates.

## 1. Question, prior work, and contribution

For a Markov chain, reaching the hardest single target and visiting all states are different objectives. Zuckerman [R1] introduced perturbation robustness for these objectives and conjectured that their tolerances are comparable. His framework explicitly allows a non-Markovian adversary to use all observations so far. A subsequent research candidate [R2] gives a separation using a complete graph, private leaves, and one long pendant path. That construction has unbounded degree; its Section 10 explicitly leaves bounded maximum degree open. We address that remaining case.

The mechanism of hiding a difficult endpoint below a larger cover-time workload is already present in [R2]. Pendant-path geometric sums, the Bellman verification principle, Matthews' cover-time argument, and decorated expander constructions are established tools. Our contribution is the uniform bounded-degree parameter theorem below, including its control of the history-dependent excursion clock, and the resulting matching-order separation. We do not claim to have invented those component methods.

Closely related algorithmic work by Olesker-Taylor, Sauerwald, and Sylvester [R3] studies robustness of weighted expanders and friendly time-dependent control that *minimizes* cover time. Their controller's objective and their graph class differ from our supremum over adversaries on the decorated graph. In particular, their accelerating policy is not an upper bound on our adversarial cover time. Zuckerman already observes constant-parameter comparability of the two adversary models at bounded degree. Our parameter theorem needs a more precise argument: simply rescaling ε by a degree factor would change S_L exponentially when εL grows.

The earlier diameter-robustness candidate [R4] also includes bounded-degree examples where both hitting and covering become fragile. It explicitly does not settle their mutual comparability. The graph decorations and excursion reductions used in the mixing-sensitivity literature [R7,R8] are further methodological predecessors, not the same robustness conclusion.

The proofs here do not assume the mathematical claims of the unrefereed candidates [R2,R4]. Those manuscripts supply the closest prior claims and the explicit remaining question. Our finite-graph comparisons are proved below. Priority comparisons are limited to the cited versions and accessible text.

### 1.1 Main parameter theorem

Fix an integer d ≥ 3 and γ ∈ (0,1). Let H be a connected simple d-regular graph on n vertices. Write P_H for its nonlazy simple-random-walk transition matrix and assume

$$
\max_{i\ge2}|\lambda_i(P_H)|\le 1-\gamma. \tag{1.1}
$$

Attach to every core vertex v a private path of K edges, with outer endpoint z_v. At a designated core root o, attach one further private path of L edges, written o = x_0,x_1,...,x_L. All new vertices are distinct. Call the resulting simple graph G = G(H,K,L,o), and call the graph with the long path deleted B. Put

$$
m_0=|E(B)|=dn/2+nK,\qquad m=|E(G)|=m_0+L,
\qquad N=|V(G)|=n(K+1)+L. \tag{1.2}
$$

The maximum degree of G is d+2. Its pendant endpoints have degree one, so G is not regular. For 0 ≤ ε < 1 define

$$
r=r(\varepsilon)=\frac{1+\varepsilon}{1-\varepsilon},\qquad
S_j(r)=\sum_{a=0}^{j-1}r^a\ (j\ge1),\qquad S_0(r)=0, \tag{1.3}
$$

and

$$
T_j(r)=\sum_{a=0}^{j-2}(j-1-a)r^a\ (j\ge2),\qquad T_1(r)=0. \tag{1.4}
$$

**Theorem 1.1 (uniform decorated-core comparison).** There are constants c > 0, a > 0, A < ∞ and n_0, depending only on d and γ, such that the following holds. Assume n ≥ n_0,

$$
1\le K\le\min\{L,n\},\qquad L\le nK,\qquad
\varepsilon(K+\log n)\le c. \tag{1.5}
$$

For either adversary class A ∈ {standard, strong} defined in Section 2,

$$
a\,nK S_L(r)\le t_{\rm hit}^{+,A}(\varepsilon)
\le A\,nK S_L(r), \tag{1.6}
$$

$$
a\bigl(nK^2\log n+nK S_L(r)\bigr)
\le t_{\rm cov}^{+,A}(\varepsilon)
\le A\bigl(nK^2\log n+nK S_L(r)\bigr). \tag{1.7}
$$

The constants are uniform over the core H, the designated root, K, L, ε, initial vertex, and every allowed history-dependent policy. The capital A used for a comparison constant in (1.6)-(1.7) is unrelated to the superscript denoting an adversary class.

At ε=0 the theorem gives

$$
t_{\rm hit}\asymp_{d,\gamma}nKL,\qquad
t_{\rm cov}\asymp_{d,\gamma}nK^2\log n+nKL. \tag{1.8}
$$

### 1.2 Bounded-degree separation

All logarithms are natural. Set

$$
K_n=\lceil\log n\rceil,\qquad
L_n=\lceil K_n\sqrt{\log n}\rceil. \tag{1.9}
$$

For a fixed multiplicative budget C > 1 and R ∈ {hit,cov}, define

$$
\rho_R^A(G;C)=\sup\{\varepsilon\in[0,1):
t_R^{+,A}(\varepsilon)\le C t_R\}. \tag{1.10}
$$

**Theorem 1.2 (matching robustness orders).** There is C_0=C_0(d,γ)>1 such that, for every fixed C ≥ C_0 and every unbounded family of cores satisfying (1.1), the graphs in (1.9) obey, for both adversary classes,

$$
\rho_{\rm hit}^A(G_n;C)\asymp_{d,\gamma,C}\frac1{L_n},
\qquad
\rho_{\rm cov}^A(G_n;C)\asymp_{d,\gamma,C}
\frac{\log\log n}{L_n}. \tag{1.11}
$$

Consequently,

$$
\frac{\rho_{\rm cov}^A(G_n;C)}{\rho_{\rm hit}^A(G_n;C)}
\asymp_{d,\gamma,C}\log\log N_n\longrightarrow\infty. \tag{1.12}
$$

The same divergent order holds if two different fixed budgets, both at least C_0, are used in the numerator and denominator. These are sufficiently-large-fixed-budget statements; neither a sharp constant nor the special budget C=2 is asserted. They address the usual robustness convention in [R1], where the omitted multiplicative constant may be sufficiently large.

Fixed-degree, nonbipartite absolute expanders exist by classical results. For example, Friedman's theorem [R5] supplies simple 4-regular families with a fixed positive absolute random-walk spectral gap. Thus the hypotheses are nonvacuous and a maximum degree bound of six can be used. We use only that standard existence consequence; we do not claim a new proof of expander existence or the existence of cores for every arbitrary pair (d,γ).

## 2. Adversaries, stopping times, and verification

Let P be simple random walk on a finite connected graph. A policy is causal: after the entire history X_0,...,X_t and its own past randomization, it chooses a probability row q_t supported on the neighbors of X_t. Randomized causal policies are allowed. A standard ε policy satisfies

$$
(1-\varepsilon)P(X_t,y)\le q_t(y)
\le(1+\varepsilon)P(X_t,y). \tag{2.1}
$$

A strong ε policy chooses

$$
q_t=(1-\varepsilon)P(X_t,\cdot)+\varepsilon b_t, \tag{2.2}
$$

where b_t is any probability row supported on actual neighbors. It cannot teleport and cannot remove the baseline probability (1−ε)P. This is not a total-variation-ball model. For ε>0 every row in (2.1) is in (2.2), by setting b_t=(q_t−(1−ε)P)/ε; at ε=0 both reduce to P. On a degree-two path vertex the two admissible sets coincide exactly: each directional probability belongs to [(1−ε)/2,(1+ε)/2]. At a degree-one endpoint the next step is forced.

Write τ_z = inf{t ≥ 0:X_t=z} and τ_cov for the first time all vertices, including X_0, have been visited. Define

$$
t_{\rm hit}^{+,A}(\varepsilon)=\max_{x,z}\sup_\pi
\mathbb E_x^\pi\tau_z,\qquad
t_{\rm cov}^{+,A}(\varepsilon)=\max_x\sup_\pi
\mathbb E_x^\pi\tau_{\rm cov}. \tag{2.3}
$$

At ε=0 omit the superscript. These expectations are finite for each fixed graph and ε<1: every required edge has a positive uniform lower transition probability, and from any history a prescribed walk visiting all vertices has a uniformly positive probability of occurring within a fixed finite block. Repeating blocks gives a geometric tail. This finiteness assertion is not used as a quantitative bound uniform in n.

Our hitting time allows t=0, whereas [R1, Section 1.4] uses a strictly positive first-visit time when the start equals the target. The ordinary maximum over distinct start and target is identical under these conventions. Their worst-policy maxima differ by at most one: a positive return consists of one initial step followed by a hitting problem bounded by (2.3), uniformly over the resulting complete history. Thus this convention does not change the orders or the sufficiently-large-fixed-budget conclusions proved here; no exact finite-budget equality is asserted.

**Lemma 2.1 (Bellman upper certificate).** If h ≥ 0 vanishes on a target set Z and, outside Z,

$$
h(x)\ge1+\sup_{q\in\mathcal Q(x)}\sum_yq(y)h(y), \tag{2.4}
$$

then E_x^π τ_Z ≤ h(x) for every causal policy.

**Proof.** Conditional on the full past, (2.4) implies that h(X_{t∧τ_Z})+t∧τ_Z is a supermartingale. Taking expectations at deterministic t and using h≥0 gives E(t∧τ_Z)≤h(x). Monotone convergence gives the conclusion. No stationary distribution for the adversarial process is assumed. If a fixed policy attains equality and h is bounded, stopping and dominated convergence also give equality for that policy. This is the usual robust dynamic-programming verification argument, included to specify the history quantifier. ∎

Both admissible sets increase with ε. Hence both robust times are nondecreasing in ε. Once one parameter violates a fixed budget, every larger parameter violates it. We use this fact when passing from time estimates to (1.10).

## 3. One-dimensional estimates with the original perturbation parameter

Consider a path 0,1,...,j with 0 absorbing for the present calculation and with reflection from j to j−1. Put p=(1+ε)/2 and q=(1−ε)/2, so r=p/q.

**Lemma 3.1 (return-time barrier).** For either adversary class, the largest expected return time to 0 is attained by always using probability p away from 0 at interior vertices. If w_i is its expected time from i, then

$$
w_1=M_j(\varepsilon)
=r^{j-1}+\frac2{1-\varepsilon}S_{j-1}(r),\qquad
0\le w_i\le jM_j(\varepsilon). \tag{3.1}
$$

For 0≤ε≤1/2,

$$
M_j(\varepsilon)\le5S_j(r). \tag{3.2}
$$

At ε=0, w_i=i(2j−i), M_j=2j−1, and max_i w_i=j².

**Proof.** Let a_i=w_i−w_{i−1}. The endpoint equation is a_j=1, and the interior equations give a_i=q^{-1}+r a_{i+1}. Backward substitution gives (3.1), with a_i>0 and a_i≤a_1. Thus w is increasing; its maximizing strong row always places the extra ε on the outward neighbor. It therefore satisfies the Bellman equations for all allowed rows, and Lemma 2.1 proves optimality even against history-dependent policies. Since q^{-1}≤4, r^{j−1}≤S_j, and S_{j−1}≤S_j, (3.2) follows. At ε=0 the difference sequence is 2(j−i)+1, whose sum is the stated quadratic. ∎

For ε>0 the same return value can be written

$$
M_j(\varepsilon)=\frac{(1-\varepsilon)r^j-1}{\varepsilon}; \tag{3.3}
$$

(3.1), rather than division by ε, defines the zero-perturbation endpoint.

**Lemma 3.2 (probability of reaching the outer endpoint).** Starting at 1 and stopping at {0,j}, every admissible policy reaches j with probability at least 1/S_j(r). The constant inward bias attains equality.

**Proof.** The increasing function f(i)=S_i(r)/S_j(r) has boundary values 0 and 1. It is harmonic for the inward-biased row, whose forward probability is q. Every other admissible row gives conditional expectation at least f(i). Stopping this bounded submartingale at {0,j} gives the lower bound. The stopping time is almost surely finite by the finite-path lower transition bound. Equality follows for the harmonic policy. The case j=1 is immediate. ∎

When εK≤c and ε≤1/2, log r≤3ε and therefore

$$
S_K(r)\le K\exp(3\varepsilon K)\le C K. \tag{3.4}
$$

Accordingly, a short-path excursion from its first vertex has conditional expected duration at most CK, its worst initial return duration is at most CK², and its endpoint success probability is at least c'/K. Constants in the rest of the manuscript depend only on d and γ after choosing the small constant in (1.5).

## 4. The core trace under complete-history control

Start at a core vertex. Let σ_0=0. After σ_j, delete all pendant excursions returning to the same core vertex, and let σ_{j+1} be the time of the next move across an edge of H. Set Y_j=X_{σ_j} and let F_j contain the *entire* physical history through σ_j, including elapsed times, visited sets, and controller randomization. The trace need not be Markovian. An excursion eventually returns, and each return to the core has probability at least (1−ε)d/(d+2) of taking a core edge. Hence all σ_j are finite almost surely.

### 4.1 Conditional rows and transition bounds

**Lemma 4.1 (trace-row comparison).** For ε≤1/2 and a constant b_d depending only on d, the conditional trace row satisfies

$$
(1-b_d\varepsilon)P_H(Y_j,y)
\le\mathbb P(Y_{j+1}=y\mid F_j)
\le(1+b_d\varepsilon)P_H(Y_j,y), \tag{4.1}
$$

provided the left coefficient is positive.

**Proof.** At a core vertex of full degree D∈{d+1,d+2}, put u=(1−ε)/D. For any attempt to exit along a core edge, each core-neighbor probability lies between u and u+ε and the sum of the d core probabilities lies between du and du+ε. Conditional on that attempt using a core edge, each neighbor's probability is therefore between u/(du+ε) and (u+ε)/(du). Relative to 1/d these bounds are 1−O_d(ε) and 1+O_d(ε). The eventual exit row is a mixture of such conditional rows, weighted by the histories of earlier unsuccessful attempts and excursions. The total exit weight is one. Thus the same bounds survive every adaptive excursion decision. For example b_d=4(d+2) is sufficient after decreasing the permitted ε. ∎

Let ρ=1−γ and

$$
t_0=\left\lceil\frac{\log(2n)}{-\log\rho}\right\rceil. \tag{4.2}
$$

Choose c in (1.5) small enough that b_d ε t_0≤1/4 and b_d ε≤1/2. By the spectral theorem,

$$
|P_H^s(x,y)-1/n|\le\rho^s. \tag{4.3}
$$

**Lemma 4.2 (full-history heat-kernel bounds).** There are constants c_1,C_1>0 such that, conditionally on any F_j, for every s≥1,

$$
\mathbb P(Y_{j+s}=y\mid F_j)
\le C_1(1/n+\rho^s), \tag{4.4}
$$

and for s≥t_0,

$$
\frac{c_1}{n}\le\mathbb P(Y_{j+s}=y\mid F_j)
\le\frac{C_1}{n}. \tag{4.5}
$$

**Proof.** For s≤t_0, multiply (4.1) along each core path and sum over paths. Iterated conditioning on full histories is legitimate even though hidden excursion histories change the conditional rows. The resulting path probabilities lie between (1−b_d ε)^s and (1+b_d ε)^s times the corresponding probabilities for P_H. These factors are bounded above and away from zero. Equation (4.3) gives (4.4) and, at s=t_0, the two-sided bound (4.5). For longer s, apply the t_0-step estimate conditionally at F_{j+s−t_0}, then average. Its upper bound C_1/n also implies (4.4) for those s. ∎

### 4.2 Hitting a core vertex without losing a logarithm

**Lemma 4.3 (uniform core hitting and return bound).** From every complete history, the expected additional number of trace steps to hit a specified core vertex is at most C_2 n. A strictly positive return to that vertex has expected trace length at most 1+C_2 n.

**Proof.** Increase n_0 so that t_0≤n/2. In the next n trace steps, count visits to a fixed v at times t_0,...,n−1:

$$
Z=\sum_{s=t_0}^{n-1}{\bf1}_{\{Y_{j+s}=v\}}.
$$

By (4.5), E(Z|F_j) is bounded above and below by positive constants. For s&lt;t, condition at F_{j+s} and use (4.4). Summing the bounds 1/n+ρ^{t−s} gives

$$
\mathbb E(Z^2\mid F_j)
\le\mathbb E(Z\mid F_j)
\left[1+2C_1\left(1+\sum_{a\ge1}\rho^a\right)\right]
\le C_3. \tag{4.6}
$$

Cauchy-Schwarz yields P(Z>0|F_j)≥p_0>0, uniformly over the complete history. Repeating blocks of n trace steps, conditional on failure so far, gives a geometric tail and mean at most n/p_0. For a positive return, take one trace step and apply this bound from the resulting history. This uses every trace time in a block; sampling only at multiples of the mixing time would give an unnecessary logarithmic factor. ∎

### 4.3 Short endpoints and stopped occupation

**Lemma 4.4 (collecting short-path endpoints in trace time).** Let ν_v be the number of completed trace stages by which the endpoint z_v has been visited, and let τ be the number of completed stages by which every short endpoint has been visited. Then, from any complete core history,

$$
\mathbb E\nu_v\le C_4 nK,\qquad
\mathbb E\tau\le C_5 nK\log n. \tag{4.7}
$$

Already-visited endpoints may either be omitted or collected again for these upper bounds.

**Proof.** At each visit to v, the probability that the very next physical step enters its short path is at least (1−ε)/(d+2). Conditional on entering, Lemma 3.2 and (3.4) give probability at least c'/K of visiting z_v before returning to v. This event occurs before the next core-edge exit. Thus each visit is an attempt with conditional success probability at least p/K. The expected number of attempts is at most K/p, by the conditional geometric-tail argument; independence is not needed. Initial arrival and inter-attempt return times have conditional trace means at most Cn by Lemma 4.3. Summing their conditional expectations, with one step to finish the successful stage, gives the first bound.

More explicitly, if J_m is the stage index of the m-th attempt, its failure is measurable in F_{J_m+1}, after that stage has completed. Apply the return bound from this later history, and sum it weighted by the already observed failure event. Each attempt itself costs one trace stage. This justifies the conditional summation without conditioning a pre-attempt return estimate on a future failure.

The same bound holds after every complete trace history, including histories in which z_v has not yet been seen. Put M=C_4 nK. At each block of ⌈2M⌉ additional stages, conditional Markov's inequality gives failure probability at most 1/2. Hence P(ν_v>m⌈2M⌉)≤2^{-m}. A union bound over n endpoints gives P(τ>m⌈2M⌉)≤min{1,n2^{-m}}. Summing block tails proves the second bound. The event that collection is unfinished at the start of a stage is F_j-measurable, so τ is a trace stopping time. ∎

**Lemma 4.5 (occupation before an adaptive stopping time).** For every integrable F_j-stopping time T and every core vertex v,

$$
\mathbb E\sum_{j \lt T}{\bf1}_{\{Y_j=v\}}
\le t_0+\frac{C_1}{n}\mathbb E T. \tag{4.8}
$$

**Proof.** For j≥t_0, {T>j}⊂{T>j−t_0}, and the latter event belongs to F_{j−t_0}. Equation (4.5), conditioned there, gives

$$
\mathbb P(T>j,Y_j=v)
\le\frac{C_1}{n}\mathbb P(T>j-t_0).
$$

Sum over j≥t_0 and add at most t_0 for the initial terms. This shifted stopping-time argument is essential: a deterministic-time marginal bound alone cannot be multiplied by E T. ∎

## 5. The physical clock and the long-path certificate

### 5.1 Excursion clock

Let D_j=σ_{j+1}−σ_j. At every return to a core vertex the conditional chance of taking a core edge is bounded below by a positive constant. The conditional expected number of pendant excursions before that exit is therefore bounded by a constant. Lemma 3.1 gives, for each complete F_j,

$$
\mathbb E(D_j\mid F_j)
\le C_6 K+C_6 S_L(r){\bf1}_{\{Y_j=o\}}. \tag{5.1}
$$

This bound allows the adversary to change direction during an excursion or between excursions. One may obtain it by summing over successive core attempts: each excursion has the applicable uniform conditional mean bound, and the probability that the a-th attempt is needed decays geometrically.

For an integrable trace stopping time T, {j&lt;T} is F_j-measurable. Tonelli's theorem, conditional expectation, (5.1), and (4.8) give

$$
\mathbb E\sigma_T
\le C_6K\mathbb ET+
C_6S_L(r)\left(t_0+\frac{C_1}{n}\mathbb ET\right). \tag{5.2}
$$

An initial state off the core incurs an additional return cost at most CK² on a short path or 5L S_L(r) on the long path. Under (1.5), both are at most C nK S_L(r). In particular, the arbitrary-start long-path cost is not incorrectly replaced by the smaller first-vertex excursion cost.

### 5.2 A base hit-root potential

**Lemma 5.1 (base potential).** On B, let g(x) be the supremum of the expected time to hit o over strong ε policies, and put g(o)=0. Then

$$
0\le g(x)\le C_7nK. \tag{5.3}
$$

For x≠o,

$$
g(x)=1+\sup_{q\in\mathcal Q_B(x)}\sum_yq(y)g(y). \tag{5.4}
$$

**Proof.** With no long path, (5.1) is simply E(D_j|F_j)≤CK. Lemma 4.3 and conditional summation give a physical expected hit-root time at most CnK from any core point. From a short-path starting point add at most CK²≤CnK. Thus the supremum is finite and uniformly bounded. The dynamic-programming identity follows by first-step conditioning: every continuation is bounded by g of the next state, and after a chosen first row one can choose arbitrarily near-optimal continuations separately for its finitely many possible next states. Past history does not restrict the future admissible rows. ∎

### 5.3 Hitting the long endpoint without an extra geometric factor

**Lemma 5.2 (long-endpoint upper bound).** From any state and any complete history on G,

$$
\sup_\pi\mathbb E^\pi\tau_{x_L}\le C_8nK S_L(r). \tag{5.5}
$$

**Proof.** Let M=max_B g, let u=(1−ε)/(d+2), and choose

$$
\delta_1=\frac{1+M}{u},\qquad
\delta_{j+1}=r\delta_j+\frac2{1-\varepsilon}\quad(1\le j \lt L),
\qquad a_0=\sum_{j=1}^L\delta_j. \tag{5.6}
$$

Define h(x)=a_0+g(x) for x∈B and

$$
h(x_j)=a_0-\sum_{i=1}^j\delta_i\quad(1\le j\le L). \tag{5.7}
$$

All δ_i are positive, so h≥0 and h(x_L)=0. Away from o in B, (5.4) proves the Bellman condition for h. At o, the probability of x_1 is at least u, while all other neighbors have excess g(y)≤M above a_0. Hence

$$
\sum_yq(y)h(y)-a_0\le M-u\delta_1=-1. \tag{5.8}
$$

At an interior long-path vertex, h is decreasing toward x_L. The maximizing strong row has backward probability (1+ε)/2 and forward probability (1−ε)/2. Recurrence (5.6) gives exactly

$$
1+\frac{1+\varepsilon}{2}\delta_j
-\frac{1-\varepsilon}{2}\delta_{j+1}=0. \tag{5.9}
$$

Thus h is a Bellman upper certificate for every complete-history policy, even if the policy switches between delaying a first arrival and prolonging a return excursion. Summing (5.6),

$$
a_0=\delta_1 S_L(r)+\frac2{1-\varepsilon}T_L(r)
\le C(nK+L)S_L(r)\le CnK S_L(r), \tag{5.10}
$$

where T_L≤L S_L, u is bounded below, and L≤nK. Also max_B g≤CnK. Lemma 2.1 proves (5.5). The calculation uses the original ε on degree-two path vertices; it never substitutes a degree-multiplied ε in r. ∎

### 5.4 Upper bounds in Theorem 1.1

First return an arbitrary starting state to the core, paying at most CnK S_L as above. To hit any point of a short path, or its core root, it suffices from the core to visit the corresponding short endpoint. Apply (5.2) with T=ν_v and (4.7):

$$
\mathbb E\sigma_{\nu_v}
\le CnK^2+C S_L(r)(\log n+K)
\le CnK S_L(r). \tag{5.11}
$$

Here S_L≥L≥K and log n+K≤CnK. To hit any point of the long path from the core, use Lemma 5.2 and the fact that reaching x_L traverses that point. This proves the upper hitting bound, including starting points that lie beyond a target on the same pendant path; the initial core return is what handles that case.

For coverage, let T=τ collect every short endpoint. Equations (4.7) and (5.2) give

$$
\mathbb E\sigma_\tau
\le CnK^2\log n+C S_L(r)(\log n+K\log n)
\le CnK^2\log n+CnK S_L(r). \tag{5.12}
$$

After σ_τ the walk is on the core. Apply Lemma 5.2 conditional on that complete history and then visit x_L. Every vertex of G has now been visited. Add the initial core return cost. This proves the upper cover bound. Reaching the long endpoint earlier, or entering the long path repeatedly while collecting short endpoints, is already allowed and charged by (5.2). No independence between endpoint collection and long excursions is assumed.

## 6. Matching lower bounds

### 6.1 Exact endpoint obstruction

Consider a stationary policy that leaves every transition on B and at o unchanged, and uses probability (1+ε)/2 toward o and (1−ε)/2 toward x_L at each interior long-path vertex. The degree-one endpoint is unchanged. This policy is admissible for both adversary classes at the *same* ε.

**Lemma 6.1 (fixed-policy endpoint formula).** For this policy,

$$
\mathbb E_o\tau_{x_L}
=(2m_0+1)S_L(r)+\frac2{1-\varepsilon}T_L(r). \tag{6.1}
$$

**Proof.** Let v(y)=E_y^B τ_o for the unperturbed walk on B. Multiplying its Poisson equations by degrees and summing over y≠o gives

$$
\sum_{y\sim_B o}v(y)=2m_0-\deg_B(o)=2m_0-(d+1). \tag{6.2}
$$

Indeed, all terms involving v cancel except those omitted from the root's neighbor sum; v(o)=0. Before a walk in B first hits o it cannot enter the long path, so its endpoint value equals its root endpoint value plus v(y). Since o has degree d+2 in G, the root first-step equation gives the first decrement δ_1=2m_0+1. On the long path the decrements obey δ_{j+1}=rδ_j+2/(1−ε), and the endpoint value is zero. Summing these decrements gives (6.1). These bounded solutions equal the expected hitting times by the finite-state first-step equations or Lemma 2.1 with equality. ∎

Since m_0≥nK, (6.1) is at least 2nK S_L(r). This lower bounds both the worst hitting time and the worst cover time.

### 6.2 The short-endpoint cover workload

We include the needed classical Matthews lower argument [R6] to keep the quantitative comparison explicit.

**Lemma 6.2 (subset cover lower bound).** Let S contain s≥2 states of a finite irreducible Markov chain, and put h_* = min_{u≠v in S} E_u τ_v. The maximum expected time to visit every state of S is at least h_* H_{s−1}, where H_j=∑_{a=1}^j 1/a.

**Proof.** Start at any fixed u_0∈S, independently choose a uniformly random ordering V_1,...,V_{s−1} of S\{u_0}, and let θ_k be the first time V_1,...,V_k have all been visited; θ_0=0. If V_k is unvisited at θ_{k−1}, the current state is in S and differs from V_k, so the conditional expected increment θ_k−θ_{k−1} is at least h_*. Otherwise the increment is zero. For each fixed complete chain trajectory, the first-visit order of any selected k states has no ties. Symmetry of the independent random ordering makes V_k the last first-visited among V_1,...,V_k with probability 1/k. This is precisely the event of being unvisited at θ_{k−1}. The strong Markov property of the unperturbed chain therefore gives E(θ_k−θ_{k−1})≥h_*/k. Summing from k=1 to s−1 proves the claim. The ordering is only a proof device, not an adversarial policy. ∎

**Lemma 6.3 (pairwise short-tip hitting times).** In ordinary simple random walk on G, for distinct short endpoints z_v,z_w,

$$
\mathbb E_{z_v}\tau_{z_w}
=2mK+\mathbb E_v\tau_w\ge2mK. \tag{6.3}
$$

**Proof.** Returning from z_v to v costs exactly K² by Lemma 3.1 at ε=0. Delete the K-edge path at w and apply the root-decrement calculation in Lemma 6.1, now with target distance K and base edge count m−K. It yields E_w τ_{z_w}=2mK−K². Every trajectory from v to z_w passes through w. The strong Markov property adds these three segments and cancels K². ∎

Apply Lemma 6.2 to the n short endpoints. Since m≥nK and H_{n−1} is comparable to log n,

$$
t_{\rm cov}\ge2mK H_{n-1}\ge c_2nK^2\log n. \tag{6.4}
$$

The unperturbed policy is admissible at every ε. Combining (6.4) and (6.1), the robust cover time is at least the maximum of their two lower bounds, and hence at least half their sum. The two lower bounds need not be attained by the same policy. Together with Section 5, this completes the proof of Theorem 1.1. ∎

## 7. Deriving the robustness scales

Use K_n,L_n from (1.9). Then K_n∼log n, L_n∼(log n)^{3/2}, K_n≤n, and L_n≤nK_n for all sufficiently large n. Equation (1.8) becomes

$$
t_{\rm hit}\asymp nK_nL_n,\qquad
t_{\rm cov}\asymp nK_n^2\log n, \tag{7.1}
$$

because L_n/(K_n log n)∼1/√log n→0.

### 7.1 Single-target robustness

For any fixed a≥0, put ε=a/L_n. The condition in (1.5) holds eventually, uniformly over the core. Since L_n log r→2a, the geometric sum is a Riemann sum:

$$
\frac{S_{L_n}(r(a/L_n))}{L_n}\longrightarrow
g(a)=\int_0^1e^{2at}\,dt
=\begin{cases}(e^{2a}-1)/(2a),&a>0,\\1,&a=0.\end{cases} \tag{7.2}
$$

In particular, taking a=1 in the upper estimate (1.6) and using the lower baseline estimate in (7.1) gives a fixed budget C_h, independent of n and the core, for which ε=1/L_n is feasible for all sufficiently large n. Conversely, g(a) tends to infinity. For any fixed C, choose a sufficiently large constant a_C so that the lower bound in (1.6), divided by the upper baseline bound, exceeds C at ε=a_C/L_n for all sufficiently large n. Monotonicity from Section 2 then gives

$$
1/L_n\le\rho_{\rm hit}^A(G_n;C)\le a_C/L_n
\quad\text{for every fixed }C\ge C_h. \tag{7.3}
$$

Comparison constants can be enlarged to absorb the finite starting range; the assertion is asymptotic along the core family. No particular numerical value of C_h is claimed.

### 7.2 Coverage robustness

Fix b>0 and put ε=b log log n/L_n. Then ε(K_n+log n)→0. Also

$$
L_n\log r=2b\log\log n+o(1),\qquad
r-1\sim\frac{2b\log\log n}{L_n}. \tag{7.4}
$$

The remainder in the first identity follows from L_n ε³→0. Thus

$$
\frac{S_{L_n}(r)}{K_n\log n}
\sim\frac{(\log n)^{2b-1/2}}{2b\log\log n}. \tag{7.5}
$$

For b=1/8 this tends to zero. The upper bound (1.7), compared with (6.4), therefore gives a fixed budget C_c such that b log log n/L_n is feasible for every C≥C_c and all sufficiently large n. For b=1/2 the expression in (7.5) tends to infinity. The endpoint lower bound (6.1) then exceeds every fixed multiple of the ordinary cover time at ε=(log log n)/(2L_n). Monotonicity implies

$$
\frac{\log\log n}{8L_n}
\le\rho_{\rm cov}^A(G_n;C)
\le\frac{\log\log n}{2L_n}
\quad\text{for every fixed }C\ge C_c, \tag{7.6}
$$

once n is sufficiently large depending on C,d,γ. These bounds are convenient constants proving the order, not sharp leading constants for the tolerance.

Take C_0 larger than both C_h and C_c. Equations (7.3) and (7.6) prove (1.11). Finally N_n=n(K_n+1)+L_n∼n log n, so log log N_n∼log log n. This proves (1.12), including the claim with different sufficiently large fixed budgets. ∎

## 8. Verification scope and limitations

The argument is an analytic proof for all parameters in (1.5), not a conclusion drawn from finite simulation. Accompanying exact finite calculations check the pendant-path formulas, fixed-policy endpoint equations, row admissibility, and finite Bellman certificates. Any accompanying floating-point illustration only displays quantities already defined analytically. These checks do not establish the universal quantifiers and are not Lean verification.

There are several deliberate limits. The decorated graphs have bounded maximum degree, but are not regular. The robustness orders are proved for sufficiently large fixed budgets; the profile for each C>1 and a sharp tolerance constant remain outside the claim. The small-perturbation condition involves the short path and core mixing scale, while εL may grow; outside this parameter range (1.6)-(1.7) are not asserted. The maximum possible separation across all bounded-degree graphs and a general comparison in the reverse direction are not determined. No practical network-scale gain is implied by the asymptotic theorem.

Expander existence is a credited classical input [R5]; the new estimates require only (1.1). The references identify the published records and the preprint or accepted-manuscript versions consulted. Two nearest preceding candidates are explicitly unrefereed, and one older decorated-expander source was inspected only at abstract/metadata level. That availability limit is disclosed; no theorem in this paper depends on its unavailable details.

## References

- **[R1]** David Zuckerman. *Markov Chain Robustness*. ITCS 2026, LIPIcs 362, 118:1-118:22. DOI: [10.4230/LIPIcs.ITCS.2026.118](https://doi.org/10.4230/LIPIcs.ITCS.2026.118). Definitions of the two adversaries and robustness; Conjecture 1.17. Official full text: [DROPS HTML](https://drops.dagstuhl.de/storage/00lipics/lipics-vol362-itcs2026/html/LIPIcs.ITCS.2026.118/LIPIcs.ITCS.2026.118.html).
- **[R2]** Anonymous. *Cover-time robustness can stay positive while hitting-time robustness vanishes*. Evidence Press, version 0.1.0-candidate, 4 November 2026. DOI: [10.5281/zenodo.23934558](https://doi.org/10.5281/zenodo.23934558). Unrefereed research candidate; high-degree separation and Section 10 bounded-degree question. [Fixed manuscript](https://github.com/ipitchford/cover-time-robustness-separation/blob/a41d17adc423af10e5662b434c6343a58d92ba17/markov_robustness/manuscript.md).
- **[R3]** Sam Olesker-Taylor, Thomas Sauerwald, and John Sylvester. *Time-Biased Random Walks and Robustness of Expanders*. Proceedings of SODA 2026, 2928-2941. DOI: [10.1137/1.9781611978971.109](https://doi.org/10.1137/1.9781611978971.109). [Author accepted manuscript](https://api.repository.cam.ac.uk/server/api/core/bitstreams/32740bdd-e2af-42e8-bf37-f5063283bc87/content); [arXiv:2412.13109](https://arxiv.org/abs/2412.13109).
- **[R4]** Anonymous. *Small diameter does not control hitting-time robustness*. Evidence Press, version 1.0.0-candidate, 22 October 2026. DOI: [10.5281/zenodo.23575572](https://doi.org/10.5281/zenodo.23575572). Unrefereed research candidate, including cover-fragility consequences that explicitly leave Conjecture 1.17 unsettled. [Research release](https://evidencepress.org/releases/diameter-hitting-time-robustness/).
- **[R5]** Joel Friedman. *A Proof of Alon's Second Eigenvalue Conjecture and Related Problems*. Memoirs of the American Mathematical Society 195 (910), 2008. DOI: [10.1090/memo/0910](https://doi.org/10.1090/memo/0910). Author preprint [arXiv:cs/0405020](https://arxiv.org/abs/cs/0405020). Used only for classical existence of a simple fixed-degree absolute expander family.
- **[R6]** Peter Matthews. *Covering Problems for Markov Chains*. The Annals of Probability 16 (1988), 1215-1228. DOI: [10.1214/aop/1176991686](https://doi.org/10.1214/aop/1176991686). The subset lower bound used here is proved in Lemma 6.2.
- **[R7]** Jian Ding and Yuval Peres. *Sensitivity of mixing times*. Electronic Communications in Probability 18 (2013), article 88, 1-6. DOI: [10.1214/ECP.v18-2765](https://doi.org/10.1214/ECP.v18-2765). Decorations and mixing sensitivity under bounded conductance changes; not the hitting/cover robustness separation. The published article was consulted.
- **[R8]** Itai Benjamini, Gady Kozma, and Nicholas Wormald. *The mixing time of the giant component of a random graph*. Random Structures & Algorithms 45(3) (2014), 383-407. DOI: [10.1002/rsa.20539](https://doi.org/10.1002/rsa.20539). Decorated-expander methodology; only abstract and original metadata inspected.
- **[R9]** John Haslegrave, Thomas Sauerwald, and John Sylvester. *Time Dependent Biased Random Walks*. ACM Transactions on Algorithms 18(2) (2022), article 12. DOI: [10.1145/3498848](https://doi.org/10.1145/3498848). [arXiv:2006.02475v2](https://arxiv.org/abs/2006.02475v2). Friendly control and bounded-degree complexity gadgets; not the present worst-policy comparison.
