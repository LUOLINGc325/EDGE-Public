# Transient learning at a common reward threshold in finite-state Markov decision processes

## Abstract

A known threshold can be attained with bounded expected cumulative loss in each weakly communicating finite MDP whose optimum reaches it. Randomly screening deterministic stationary policies preserves a positive expected linear surplus in every model strictly above threshold. If the given threshold is the infimum of the optimal gains and only finitely many kernels achieve it, the robust transient value is bounded below. This bound takes the horizon limit separately in each model. For a known finite model list, posterior hysteresis supplies computable, simultaneous finite-horizon bounds even for multichain and periodic transitions. An exactly solvable example shows why mixing and bias-span bounds alone do not bound the learning constant.

## 1. Problem, observations, and assumptions

Let $S$ and $A$ be finite nonempty sets, and let $m\ge1$. Model $i\in\{1,\ldots,m\}$ has transition probabilities $P_i(y\mid s,a)$. Rewards are the shared, known function $r:S\times A\to[0,1]$. An adversary chooses one model $i$ before time zero and uses it throughout.

The initial distribution $\mu$ is the same in all models. At time $t$, the controller observes $S_t$, selects $A_t$ using its past observations and independent randomization, receives $r(S_t,A_t)$, and observes $S_{t+1}$. In particular, selected actions are part of the observed history.

For each candidate $j$, a stationary randomized policy $\pi_j(a\mid s)$ is supplied. Fix a threshold $g\in[0,1]$. The sole reward-feasibility assumption is

$$
 \lim_{T\to\infty}\frac1T
 \mathbb E_s^{j,\pi_j}\sum_{t=0}^{T-1}r(S_t,A_t)\ \ge g
 \quad\text{for every }j\text{ and }s.                 \tag{1}
$$

The limit exists for a finite Markov reward chain, including periodic and multichain chains. Equivalently, every recurrent class of $P_j^{\pi_j}$ has mean reward at least $g$. The policies are allowed to differ across models. Assumption (1) does not assume that one policy works in all models, or that the controller can identify the model at zero cost.

For a controller $\pi$, define the signed expected cumulative deficit

$$
 D_i^\pi(T)=\mathbb E_i^\pi\sum_{t=0}^{T-1}
       \bigl(g-r(S_t,A_t)\bigr).                     \tag{2}
$$

We control (2), not its positive part on each realized path, nor the sum of the positive parts of its individual increments. The distinction permits surplus reward to compensate earlier losses. We assume the supplied finite model list and policies are available exactly for the theorem; finite-precision implementation is a separate question.

## 2. Controller and computable theorem

Let $L_i(t)$ be the likelihood of the observed transitions through time $t$ under model $i$, with $L_i(0)=1$. Define

$$
 W_i(t)=\frac{L_i(t)}{\sum_{k=1}^mL_k(t)}.           \tag{3}
$$

Conditional action probabilities cancel in this expression because the controller is the same history-dependent rule under every model. The action-conditioned transition probabilities must still be used in $L_i$. Averaging over unobserved actions would describe a different experiment.

Choose $0<\ell<1/m$. Select a posterior maximizer $J_0$. For $t\ge1$, retain $J_{t-1}$ if $W_{J_{t-1}}(t)\ge\ell$; otherwise choose any posterior maximizer as $J_t$. Resolve ties by a fixed rule. Sample $A_t$ from $\pi_{J_t}(\cdot\mid S_t)$. At a history impossible under every model, define the rule arbitrarily; such histories have probability zero under every stated environment.

For each ordered pair $i,j$, write

$$
\begin{aligned}
 K_{ij}(s,y)&=\sum_a\pi_j(a\mid s)P_i(y\mid s,a),\\
 a_j(s)&=g-\sum_a\pi_j(a\mid s)r(s,a),\\
 d_{ij}(s)&=
 1-\sum_a\pi_j(a\mid s)\sum_y
       \sqrt{P_i(y\mid s,a)P_j(y\mid s,a)}.
\end{aligned}                                                     \tag{4}
$$

Here $a_j$ is signed and $0\le d_{ij}\le1$. A pairwise certificate consists of $c_{ij}\ge0$ and a vector $b_{ij}\in\mathbb R^S$ satisfying the componentwise inequalities

$$
 a_j\ \le\ c_{ij}d_{ij}+b_{ij}-K_{ij}b_{ij}.         \tag{5}
$$

Let $\operatorname{sp}(b)=\max_s b(s)-\min_s b(s)$, and let
$B_i=\max_j\operatorname{sp}(b_{ij})$.

**Theorem 1 (finite-model exact-threshold control).**
Under (1), certificates (5) exist for every ordered pair. The controller above satisfies, for every model $i$, every $T\ge1$, and every common initial distribution,

$$
 D_i^\pi(T)\ \le\
 \ell^{-1/2}\sum_{j=1}^m c_{ij}
 +\left(1+\frac{m-1}{1/m-\ell}\right)B_i.            \tag{6}
$$

In particular, $\ell=1/(2m)$ gives the explicit bound

$$
 D_i^\pi(T)\le
 C_i:=\sqrt{2m}\sum_jc_{ij}
       +\bigl(1+2m(m-1)\bigr)B_i.                  \tag{7}
$$

No irreducibility, aperiodicity, common-support condition, unique optimal action, or complete model identifiability is required. These omissions are part of the statement, not implicit assumptions.

For fixed $\ell$, a smaller certified right-hand side can be obtained by minimizing over the inequalities (5) and span bounds. Additive shifts of each $b_{ij}$ do not affect (5). This is a finite linear feasibility/optimization problem once the probabilities and the square-root coefficients in (4) are supplied. For rational input, these coefficients are real algebraic numbers. We make no polynomial bit-complexity claim.

## 3. A finite-chain certificate and its exact feasibility criterion

We first isolate the deterministic Markov-chain algebra.

**Lemma 2 (Poisson certificate criterion).**
Let $K$ be a finite stochastic matrix, $a$ any real vector, and $d\ge0$. For each recurrent irreducible class $C$, let $\nu_C$ be its stationary probability vector. There exist $c\ge0$ and $b$ with

$$
 a\le cd+(I-K)b                                      \tag{8}
$$

if and only if

$$
 \nu_Cd=0\quad\Longrightarrow\quad\nu_Ca\le0
 \quad\text{for every recurrent class }C.             \tag{9}
$$

Moreover the smallest possible $c$ is attained and is

$$
 c_*=\max\left(0,\
       \max_{C:\nu_Cd>0}\frac{\nu_Ca}{\nu_Cd}\right),  \tag{10}
$$

with the second maximum omitted if its index set is empty.

*Proof.* Multiplying (8) by $\nu_C$ proves (9) and the lower bound (10).

For sufficiency, let

$$
 \Pi=\lim_{n\to\infty}\frac1n\sum_{t=0}^{n-1}K^t
$$

be the finite-chain Cesàro projection. It is stochastic and satisfies
$\Pi^2=\Pi$, $K\Pi=\Pi K=\Pi$. Its row at a state is the mixture of recurrent-class stationary laws weighted by absorption probabilities from that state.

Set $y=a-c_*d$. Conditions (9) and (10) imply that every recurrent-class mean of $y$ is nonpositive, hence $\Pi y\le0$. The matrix $I-K+\Pi$ is invertible. Indeed, if it annihilates $v$, applying $\Pi$ gives $\Pi v=0$, and then $Kv=v$. The Cesàro definition implies $\Pi v=v$, so $v=0$. Finite dimensionality proves invertibility.

Choose $b=(I-K+\Pi)^{-1}y$. Applying $\Pi$ gives $\Pi b=\Pi y$, and therefore

$$
 (I-K)b=y-\Pi y\ge y.
$$

This is (8). The use of Cesàro projection rather than an unqualified infinite sum of $K^t$ handles periodic classes. $\square$

The projection and Poisson argument are standard finite Markov reward algebra. Their role here is a checkable bridge from local statistical discrepancy to long-run and transient loss, not a claim to a new theory of Poisson equations.

**Lemma 3 (feasibility transfers on a zero-information class).**
Under (1), the pair $K_{ij},a_j,d_{ij}$ satisfies (9).

*Proof.* Let $C$ be a recurrent class of $K_{ij}$ with $\nu_Cd_{ij}=0$. Positivity of the stationary weights on $C$, together with $d_{ij}\ge0$, implies $d_{ij}(s)=0$ for every $s\in C$.

For probability vectors $p,q$, their square-root affinity is at most one, with equality exactly when $p=q$. Thus, for every $s\in C$ and every action having $\pi_j(a\mid s)>0$, the rows $P_i(\cdot\mid s,a)$ and $P_j(\cdot\mid s,a)$ coincide. Consequently $K_{ij}$ and $K_{jj}$ coincide on $C$. The class is closed and irreducible for $K_{jj}$ as well. Starting in $C$, reference policy $\pi_j$ in model $j$ has class mean reward at least $g$ by (1). This says exactly $\nu_Ca_j\le0$. Lemma 2 applies. $\square$

A candidate need not reveal which model is true on such a class. It is enough that indistinguishability there entails a satisfactory reward.

## 4. Expected switches: one bounded-martingale argument

Let $Q=m^{-1}\sum_i P_i^\pi$ be the law obtained by first selecting the true model uniformly. The posterior coordinates $W_j(t)$ are bounded $Q$-martingales.

Let $N_T$ count candidate changes at times $1,\ldots,T-1$. Put $u=1/m$. At the beginning of every uninterrupted candidate interval, its posterior is at least $u$. At the end of a completed interval it is below $\ell$.

Consider the predictable martingale transform

$$
 G_T=-\sum_{t=0}^{T-1}
           \bigl(W_{J_t}(t+1)-W_{J_t}(t)\bigr).       \tag{11}
$$

Its expectation under $Q$ is zero. On each completed candidate interval, the corresponding telescoping contribution is at least $u-\ell$. The final unfinished interval contributes at least $u-1$. Hence, pathwise,

$$
 G_T\ge (u-\ell)N_T+u-1.
$$

It follows that

$$
 \mathbb E_QN_T\le\frac{1-u}{u-\ell}.                \tag{12}
$$

For any nonnegative variable measurable from the finite history,
$\mathbb E_i Z\le m\mathbb E_Q Z$. Therefore

$$
 \mathbb E_iN_T\le
       \frac{m-1}{1/m-\ell}.                        \tag{13}
$$

Monotone convergence extends (13) to the total number of switches over the infinite run. In particular, that number is finite almost surely in each model. This does not say the final candidate equals the true model.

The proof controls all candidate intervals together. It does not add separate, possibly loose downcrossing bounds for each posterior coordinate.

## 5. Information occupation without support assumptions

Fix the true model $i$ and another candidate $j$. On histories of positive true-model probability let $R_{ij}(t)=L_j(t)/L_i(t)$, starting from one. The true likelihood is positive almost surely. The other likelihood may become zero and stay zero.

Conditional on the history and selected action $a$,

$$
 \mathbb E_i\!\left[\sqrt{R_{ij}(t+1)}\mid H_t,A_t=a\right]
 =\sqrt{R_{ij}(t)}
       \sum_y\sqrt{P_i(y\mid S_t,a)P_j(y\mid S_t,a)}. \tag{14}
$$

Terms with $P_i=0$ contribute zero, so (14) requires no common support. Averaging the action and telescoping gives a nonnegative drift budget of at most one. Restricting this budget to times at which $J_t=j$ yields

$$
 \sum_{t<T}\mathbb E_i
 \left[{\bf1}_{\{J_t=j\}}\sqrt{R_{ij}(t)}
                   d_{ij}(S_t)\right]\le1.          \tag{15}
$$

At every active time, $W_j(t)\ge\ell$; because $W_i(t)\le1$,

$$
 R_{ij}(t)=W_j(t)/W_i(t)\ge\ell.
$$

Thus

$$
 \mathbb E_i\sum_{t<T}{\bf1}_{\{J_t=j\}}d_{ij}(S_t)
       \le \ell^{-1/2}.                             \tag{16}
$$

The loss normalization is $1-\text{affinity}$, not twice this quantity. Formula (16) is uniform in $T$, even though the selected policy adapts to the entire past.

## 6. Completing the reward bound

Conditional on $H_t$, the expected reward deficit at time $t$ is $a_{J_t}(S_t)$, and the conditional next-state kernel is $K_{iJ_t}$. Applying (5) and taking expectations gives

$$
 D_i^\pi(T)\le
 \sum_j c_{ij}\,
   \mathbb E_i\sum_{t<T}{\bf1}_{\{J_t=j\}}d_{ij}(S_t)
 +\mathbb E_i\sum_{t<T}
       \bigl[b_{iJ_t}(S_t)-b_{iJ_t}(S_{t+1})\bigr].  \tag{17}
$$

There is no hidden optional-stopping step in (17): it follows at the deterministic times $0,\ldots,T-1$ by conditional expectation. The last sum telescopes separately on each uninterrupted candidate interval. Each interval contributes at most $B_i$, so its entire value is at most $B_i(N_T+1)$, pathwise.

Substituting (13) and (16) into (17) proves (6), hence (7). This proves Theorem 1.

An equivalent proof may stop individual candidate intervals. The deterministic-time derivation is preferable because it immediately makes all integrability requirements transparent.

## 7. Consequences and exact limits of the result

### 7.1 Finite weakly communicating robust MDPs

Suppose a finite model class consists of weakly communicating MDPs with optimal gains $g_i$. Choose an average-optimal stationary policy for each model and set $g_*=\min_i g_i$. Each selected policy meets threshold $g_*$ from every state in its own model.

Theorem 1 gives a single controller with

$$
 \mathbb E_i\sum_{t<T}(r_t-g_*)\ge-C_i
 \quad\text{for all }i,T.
$$

Its robust average value is $g_*$: the lower bound follows by division by $T$, while an environment attaining the smallest classical optimal gain supplies the upper bound. Its robust transient value satisfies

$$
 \min_i\liminf_{T\to\infty}\mathbb E_i
                  \sum_{t<T}(r_t-g_*)\ge-\max_i C_i. \tag{18}
$$

This is a finite-ambiguity-set result. It is not the entire possibly infinite-set target in Wang–Si Remark 3.

### 7.2 Equal gains and classical regret

If $g_i=g$ for all $i$, expression (2) is the ordinary expected gain-based regret in each model; (7) bounds it. If the gains differ, (7) is only relative to $g_*=\min_i g_i$. It does not assert bounded regret against the better model-specific gain in a non-worst environment.

### 7.3 Exact-threshold feasibility and multichain models

The main theorem does not need weak communication at all. It applies whenever the supplied policies satisfy (1), including equality at the threshold and models with multiple recurrent classes. This statement concerns a known finite hypothesis class. It does not supply an algorithm for an unrestricted unknown MDP, nor does it imply a positive-part or high-probability deficit bound.

## 8. Exact information-cost example

Let $S=\{0,1\}$, $A=\{-1,+1\}$, $r(s,a)=s$, and let the fixed hidden model be $\theta\in\{-1,+1\}$. For $0<\delta<1$,

$$
 P_\theta(S_{t+1}=1\mid s,a)=\frac{1+a\theta\delta}{2}. \tag{19}
$$

Both models have gain $g=(1+\delta)/2$ and Bellman bias $h(s)=s$, with span one. Write $Z_t=A_t(2S_{t+1}-1)$. Under either model these are iid signs with
$P_\theta(Z_t=1)=(1+\theta\delta)/2$, regardless of the controller. The initial state and exogenous random seed carry no model-label information. Conditional on either model, the signs are independent of them; the interaction history is reconstructible from the initial state, the random seed, and the signs.

Let $W_n=\sum_{t<n}Z_t$ and

$$
 e_n=P_+(W_n<0)+\tfrac12P_+(W_n=0).
$$

With the two model labels equally likely, this is the least error probability at time $n$. The sign rule, with fair ties, achieves it in both models. The rule and its finite-horizon minimax optimality are established in the symmetric-bandit literature, including Kobzar–Kohn, Lemma 3.1. We supply the following exact occupation calculation and its robust-control interpretation.

Set $p=(1+\delta)/2$, $q=(1-\delta)/2$. For the biased walk, its Green function satisfies

$$
 G(0)=\sum_{k\ge0}{2k\choose k}(pq)^k=\frac1\delta,\qquad
 G(-j)=\frac1\delta(q/p)^j,\quad j\ge1.
$$

The second identity follows by hitting $-j$ and then using the strong Markov property. Tonelli's theorem and a geometric sum give

$$
 \sum_{n\ge0}e_n=\frac12G(0)+\sum_{j\ge1}G(-j)
              =\frac1{2\delta^2}.                   \tag{20}
$$

Because the state reward is received one step after the generating action,

$$
 D_\theta^\pi(T)=g-\mathbb E S_0+
       \delta\sum_{n=0}^{T-2}P_\theta(A_n\ne\theta). \tag{21}
$$

For each model the sum is nondecreasing. Thus its limit exists, and no unjustified interchange of a model infimum and a limit is used. Equal-prior decision lower bounds and the equal-risk sign policy give

$$
 \sup_\pi\min_\theta\liminf_T
 \mathbb E_\theta^\pi\sum_{t<T}(S_t-g)
 =\mathbb E S_0-\frac{1+\delta}{2}-\frac1{2\delta}.   \tag{22}
$$

For $0<\delta\le1/2$, all transition probabilities are at least $1/4$. Under every stationary policy the Dobrushin coefficient is at most $\delta\le1/2$, and the expected hitting time of either prescribed state is at most four. Nevertheless (22) tends to minus infinity as $\delta\downarrow0$.

This disproves a uniform bound based only on these fixed structural parameters after uniqueness of the worst model is removed. It does not disprove a finite constant for each fixed multi-model instance.

The certificate upper bound has the right inverse-gap order on this family. For a wrong candidate, its chain has stationary mean deficit $\delta$, while
$d=1-\sqrt{1-\delta^2}$. Its least $c$ in (10) is

$$
 \frac{\delta}{1-\sqrt{1-\delta^2}}
 =\frac{1+\sqrt{1-\delta^2}}{\delta}.
$$

The pairwise potentials have span one. For $m=2$, (7) is therefore of order $1/\delta$, matching the order of (22), but not its exact leading constant. This is a family-specific sharpness statement, not a general matching lower bound.

## 9. Exact certificates and verification scope

The original manuscript describes a standard-library Python controller and exact finite witnesses; the programs and raw outputs are not included in this edition. A three-state, three-model example has deterministic transitions and two recurrent classes under every cross-model candidate policy. In this example a loss may occur at a state with zero immediate discrepancy; the Poisson correction in (5) is essential.

A four-state extension adds an isolated reward-one absorbing state. Reference policies themselves then have multiple recurrent classes, and the whole model is no longer weakly communicating, while (1) still holds.

The certificate program verifies rows, feasibility, Bellman identities where used, and every component of (5), using integers and rational arithmetic. A separate finite-history calculation checks the implemented controller on stated horizons. These checks validate examples and implementation; they do not replace the general proof above.

No full Lean verification is claimed; the Lean sources are not included in this edition. No finite example certificate is presented as formalization of Theorem 1.

## 10. Related work, originality, and value

Wang and Si [1, Definition 3 and Theorem 3] define the unweighted transient value and establish a constant-order lower bound under Assumption 2 and a unique worst kernel. Its additional hypothesis allows either identifiability on the closed class or irreducibility of the optimal induced chain. Their Remark 3 explicitly identifies finitely many worst kernels as a further extension. Their epoch strategy uses a known worst-case policy, sequential likelihood testing, and a learning fallback. Section 12 meets their transient criterion with a different controller under finitely many worst kernels. Theorem 1 provides a separate quantitative bound for a supplied finite candidate list.

Agrawal, Teneketzis, and Anantharam (1989) already prove bounded loss in an important finite-parameter controlled-Markov case. Their stated framework has shared support, irreducibility and aperiodicity for stationary controls, and a unique-optimum simplification. We do not claim that finite-model bounded regret is new.

Kim (2017), and Gimelfarb and Kim (2023), study finite-parameter Thompson sampling. The latter author manuscript explicitly discusses the former's informative-action condition and its relaxation. We compare against the passages actually obtained; the 2017 full paper was not available in this run.

Boone and Gaujal (COLT 2025), Appendix G, characterize bounded regret in a convex product ambient model under non-degeneracy conditions. Hajiabolhassan and Ortner study satisficing with a different regret definition and learning setting. These are substantive neighbors, not evidence that the present theorem is the first bounded-regret result.

## 11. Exact aggregation of a microstate family

Let a known map send microstates to a finite macrostate space. Suppose rewards on actions used by the macro policies depend only on macrostate and action. Suppose for each microkernel there is one fixed macro candidate such that each used row, aggregated on destination macroblocks, equals that candidate's row. The macro implementation of the posterior controller then has exactly the same reward and action trajectory law as that candidate from the mapped initial state: conditional on every microhistory, the next macrostate has the indicated macro row, so induction gives equality on every finite history. Bound (7) holds on every horizon, even for an infinite microfamily. This is strong lumpability on the policy support in the sense of the row conditions of Dean and Givan [9, §2]; the next result does not require this property.

## 12. Infinite ambiguity families with finitely many worst kernels

**Theorem.** Consider finite state and action spaces with the shared observed reward function $r$ from Section 1. There is a single policy for all weakly communicating kernels whose optimal gains are at least a known $g$. Under each fixed such kernel $P$ its expected cumulative reward minus $gT$ is bounded below uniformly in $T$ by a constant depending on $P$. If $g_P>g$ its lower limiting expected average reward is strictly above $g$. In particular, suppose $g=\inf_{P\in\mathcal P}g_P$ for a nonempty ambiguity family $\mathcal P$ and the set of attained worst kernels is finite. For every common initial distribution $\mu$, the controller achieves the robust average gain $g$, and its transient value in the sense of [1, Definition 3],

$$
\inf_{P\in\mathcal P}\liminf_{T\to\infty}\mathbb E_\mu^{P}\sum_{t<T}(r(S_t,A_t)-g),
$$

is bounded below when a worst kernel exists. If the infimum is unattained, every model has a positive surplus drift and the extended-real transient value in the same formula is $+\infty$. The worst kernels need not possess irreducible optimal policies. There is no uniform finite-time assertion over the whole infinite family.

**Algorithm.** Independently at each trial draw a deterministic stationary policy uniformly from the finite list of all such policies, and independently draw a nonnegative integer allowance $K$ with $\Pr(K\ge j)=2^{-j}$. Start fresh counts at the actual current state. Follow the policy until the first positive integer $n$ at which its cumulative surplus is less than $-K-n^{2/3}$; then start the next trial. Continue forever if this test never fires. Unused hypothetical future randomness of a trial can be sampled independently for analysis.

**A fixed-chain estimate.** Fix $P$ and any list policy. Up to the first entry $\tau$ into a closed irreducible class its finite Markov chain has geometrically decaying transient time uniformly over initial states: a common finite path length and a strictly positive minimum probability of hitting the closed classes in that many steps give the geometric-block bound. In an entered class $C$ with mean $m_C$, cumulative surplus on the next $l$ steps is
$$
(m_C-g)l + b(S_0)-b(S_l)+M_l ,
$$
where $(I-P_C)b=r-m_C$, and $M_l$ is the sum of bounded centered next-state bias increments. This identity also holds at bounded stopping times in expectation without the martingale term. Classwise increments and bias spans have a finite common bound since the lists for fixed $P$ are finite. Periodicity does not affect the Poisson equation.

Consider a trial with its hypothetical chain continued even after rejection. Its expected number of executed steps in classes with $m_C<g$ is uniformly finite. Indeed let $\Delta$ be the smallest strictly positive $g-m_C$ on these finitely many classes (omit the bound if none). Having run $n+1$ steps and entered a bad class by time $\tau\le c n$ requires cumulative surplus at $n$ at least $-K-n^{2/3}$. If $K\le cn$ and $c>0$ is small enough (e.g. $c=\Delta/16$), this requires $M_{n-\tau}\ge\Delta n/2$ for sufficiently large $n$. Before entry the surplus is at most $\tau$; after entry the absolute bias boundary is bounded. Conditional on the entry time, class and state, Azuma bounds the last event by $2e^{-c_P n}$, uniformly. The exceptions $\tau>cn$ and $K>cn$ themselves have exponential tails. Summation gives the asserted finite bound, including a bounded stopping horizon anywhere inside the trial. Transient steps have uniformly bounded expected total as well.

**A positive chance of staying.** In a finite weakly communicating MDP an optimal deterministic stationary policy has all recurrent class means equal to $g_P$, from every state (finite average-reward optimality). Under this policy the random variable
$$
Z=\sup_{n\ge1}\{-n^{2/3}-\text{surplus through }n\}
$$
is finite almost surely: the transient is finite, the recurrent drift is nonnegative and Azuma plus Borel–Cantelli gives $M_l=o(l^{2/3})$ by applying the summable bound to every rational positive multiple of $l^{2/3}$. The independent geometric allowance dominates this finite variable with positive probability. The initial state is one of finitely many, so conditionally on any entire trial-start history the probability of choosing this policy and never rejecting is at least some $p_P>0$. Thus expected number of started trials is at most $1/p_P$. No parameter in the controller uses $p_P$.

**Cumulative comparison.** At any deterministic horizon, decompose the realized surplus into transient steps and stopped recurrent segments of the trials. Conditional on each start, transient expected absolute contribution is bounded uniformly. After the entry, stop at rejection or the remaining horizon and use optional sampling of the bounded-increment martingale at this bounded time. Boundary loss is at most one bias span per trial. Negative recurrent drift has bounded expected absolute total per trial by the preceding estimate. Thus, retaining all positive recurrent drifts, expected surplus is at least their expected total minus $B_P/p_P$, for finite $B_P$ independent of horizon and initial state. Summing at a finite horizon only requires at most $T$ trials. If $g_P>g$, on the event that the first trial chooses the stated optimal policy and is never rejected (probability at least $p_P$), the positive drift contribution is $(g_P-g)(T-\tau)_+$. Its expectation divided by $T$ has liminf at least $p_P(g_P-g)$, by dominated convergence. Crucially this last use of an event concerns the drift alone; no martingale has been stopped conditional on never rejecting. Kernels strictly above threshold therefore have lower limiting expected cumulative surplus $+\infty$. The finitely many kernels at threshold give the common post-limit lower bound by taking the maximum of their finite constants.

Hajiabolhassan and Ortner, Theorem 2 and Corollary 1, use a threshold strictly below the gain and an episode-based notion of satisficing regret. Bubeck–Perchet–Rigollet §1.2 describe antecedents of bounded instance-dependent regret with a known optimal mean in bandits. Boone–Gaujal Theorem 36 imposes an ambient product class and efficiency against each model's own optimum. The present threshold claim is pointwise in the horizon limit before taking the model infimum. Enumeration can be exponential, and no uniform transient bound is given over near-critical nonworst kernels.

## Formalization scope

Full Lean formalization remains incomplete.

## References

1. Shengbo Wang and Nian Si. *Non-Rectangular Average-Reward Robust MDPs: Optimal Policies and Their Transient Values*. arXiv:2603.00945v3, 2026. https://arxiv.org/html/2603.00945v3
2. R. Agrawal, D. Teneketzis, and V. Anantharam. *Asymptotically Efficient Adaptive Allocation Schemes for Controlled Markov Chains: Finite Parameter Space*. IEEE Transactions on Automatic Control, 1989. https://web.eecs.umich.edu/~teneket/pubs/AsymptoticallyEfficientMarkovChains-1989.pdf
3. Michael Jong Kim. *Thompson Sampling for Stochastic Control: The Finite Parameter Case*. IEEE Transactions on Automatic Control, 2017. The original full text was not obtained; its assumptions are discussed through reference 4.
4. Michael Gimelfarb and Michael Jong Kim. *Thompson Sampling for Parameterized Markov Decision Processes with Uninformative Actions*. arXiv:2305.07844. https://arxiv.org/abs/2305.07844
5. Victor Boone and Bruno Gaujal. *Logarithmic Regret of Exploration in Average Reward Markov Decision Processes*. COLT 2025; arXiv:2502.06480. https://arxiv.org/abs/2502.06480
6. Hossein Hajiabolhassan and Ronald Ortner. *Online Regret Bounds for Satisficing in Markov Decision Processes*. Mathematics of Operations Research. https://doi.org/10.1287/moor.2023.0275
7. Sébastien Bubeck, Vianney Perchet, and Philippe Rigollet. *Bounded regret in stochastic multi-armed bandits*. COLT 2013, PMLR 30:122–134. https://proceedings.mlr.press/v30/Bubeck13.html
8. Vladimir A. Kobzar and Robert V. Kohn. *A PDE-Based Analysis of the Symmetric Two-Armed Bernoulli Bandit*. arXiv:2202.05767. https://arxiv.org/abs/2202.05767
9. Thomas Dean and Robert Givan. *Model Minimization in Markov Decision Processes*. AAAI-97, pp. 106–111. https://cdn.aaai.org/AAAI/1997/AAAI97-017.pdf
