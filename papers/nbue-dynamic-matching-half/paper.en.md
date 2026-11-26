# Optimal half guarantees for dynamic matching with NBUE lifetimes

**Research manuscript · 25 November 2026 · Written proof.**

This research manuscript has not undergone external peer review.

### Abstract

Consider a stochastic matching market with finitely many types, independent Poisson arrivals, hidden independent patience times, and nonnegative rewards that may depend on the arrival order of the endpoints. We prove that one deterministic static priority policy, chosen from arrival rates, mean patience and rewards alone, earns at least one half of the omniscient matching reward for every collection of new-better-than-used-in-expectation (NBUE) patience laws with those means. The result covers deterministic patience, arbitrary atoms, unbounded support and empty initialization. We transfer the fixed-point certificate of Arnosti, Niazadeh, Nuti and Simon by replacing exponential abandonment balance with a Palm occupation inequality. The same independent-clock inequality holds for every independent censoring time if and only if the lifetime law is NBUE. A marked-Poisson construction establishes the required stationary limit without a Markov state or an integrable regeneration time. An explicit three-type exponential family with finite positive parameters proves that the uniform factor one half cannot be improved by any online policy. The half barrier and algebraic certificate are inherited; the contribution is their rigorous distributional robustness over the entire NBUE class.

## 1. Contribution and relation to prior work

The central operational question is whether the optimal omniscient-competitive constant depends essentially on exponentially distributed patience. In the exponential model, [ANNS26] prove a one-half guarantee through static priorities, a deletion-based availability inequality and a finite-dimensional value certificate. Their §7 explicitly asks about more general sojourn distributions. This manuscript resolves that direction on the entire NBUE class while retaining the source's Poisson arrivals and reward model. It does not claim to solve the open direction for arbitrary patience distributions or arrival processes, and NBUE is our specified subclass rather than an author-named conjecture.

The new bridge has two parts. First, for the matching clock of an artificially immortal Palm arrival, NBUE gives mean occupation at least mean lifetime times abandonment probability. This is precisely the favorable inequality needed in the source certificate. Second, the source's exponential CTMC argument is replaced by construction from past empty epochs of the full marked-Poisson presence process, followed by coupling and uniform-integrability estimates. These steps preserve FCFS deletion consistency, atoms, unbounded lifetimes and the empty-start objective. Neither a density nor increasing hazard rate is assumed.

A closely related result is [LWY26], which studies fully online matching with general stochastic arrivals and unknown individual sojourn times, using only their expectations. Its official abstract states a 0.192 guarantee under mild conditions and extensions including Poisson arrivals. The variance-at-most-mean-squared condition for its Poisson guarantee and its symmetric-reward scope are reported explicitly in [ANNS26, footnote 3]. Proposition 4.2 shows that NBUE is contained in that moment class, so the present half guarantee improves the known constant on a substantial subclass; it does not replace [LWY26]'s result on all laws covered there. The final journal full text was not available in our retrieval, and an older author-hosted preprint is distinguished from the final paper. No missing proof from that article is used as a dependency here.

[ADSW25] analyze heterogeneous general patience with holding costs and large-arrival asymptotics, including priority structures that depend on patience shape. Their asymptotic/fluid framework and objective differ from a finite-market universal half guarantee against an omniscient matching. [HWX26] give longest-queue policies and high-volume guarantees, retaining exponential patience and a fluid benchmark. These works motivate distributional robustness but do not supply the statement proved here in the inspected versions.

The NBUE definition and layer-cake calculus are classical reliability theory [BCR00], and the Mecke, marking, Palm and compensation identities are standard Poisson-process tools [LP18]. We give the adapted calculations in full. The value map, threshold-prefix decomposition and factor-two certificate in §5 are from [ANNS26]; the sharp upper-bound idea of rare expensive and frequent inexpensive buyers is from [KSSW22]. Our explicit all-positive three-type family closes the limiting-model issue for the exact scope of this paper, without claiming the half barrier as a new discovery.

## 2. Model and main results

### 2.1 Model

Let I be a finite nonempty type set with a fixed order. Agents of type i arrive as a homogeneous Poisson process of rate 0<λ_i<∞, independently across types. Each arrival independently receives a nonnegative lifetime L_i of type law G_i, independently of all arrivals and all other lifetime marks. Its mean is 0&lt;m_i&lt;∞. An agent is present from its arrival until its latent expiration, irrespective of matching; it is available if present and not yet matched. An online policy observes arrivals, types, survival to the current time and abandonments, but not a future lifetime realization. It may randomize independently and match any two presently available agents, including agents of the same type. Each agent can be used at most once.

If a type-i agent arrived earlier than a type-j agent, their match has reward r_ij, where every r_ij is finite and nonnegative. Rewards do not change with matching time; asymmetric r_ij and r_ji are permitted. Forbidden pairs can be assigned zero reward and omitted. Arrivals are distinct almost surely. At an expiration/matching tie, expiration takes precedence. The policy constructed below only matches on arrivals and fixes FCFS among waiting agents of the selected type.

Write S_i(t)=Pr(L_i>t). The NBUE assumption is

$$ \int_t^\infty S_i(u)\,du\le m_i S_i(t)\qquad(t\ge0). \tag{2.1} $$

When S_i(t)>0, this says that the conditional expected remaining lifetime after waiting t is at most the original mean. If S_i(t)=0, the displayed formulation avoids a division by zero. It implies Pr(L_i=0)=0, as proved in Theorem 4.1. Atoms at strictly positive times are allowed.

For a horizon H>0, start the market empty at 0. Let OPT(H) be the maximum total weight of a matching using arrivals within [0,H] whose endpoints overlap in presence. Such a pair can always be matched at its later arrival, so this graph-based omniscient benchmark also describes the best foresighted temporal schedule. Let

$$ \mathrm{OMN}=\lim_{H\to\infty}\frac{\mathbb E\,\mathrm{OPT}(H)}H. \tag{2.2} $$

The limit exists by Lemma 2.3 below. For our constructed policy π, let V(π)=lim_{H→∞}E[reward_π(H)]/H; Proposition 3.1 proves existence. For an arbitrary online policy in the upper-bound theorem, its limiting superior is enough.

### Theorem 2.1 (mean-only optimal half guarantee)

For every (I,λ,m,r) as above there is a deterministic static priority policy π, with FCFS within each type, depending only on λ, m and r, such that simultaneously for every collection of independent NBUE lifetime laws with mean vector m,

$$ V(\pi)\ge\frac12\mathrm{OMN}. \tag{2.3} $$

The statement includes arbitrary compatibility, asymmetric rewards, self-type matches, atoms, unbounded support and empty initialization. No lifetime-shape parameter or observed future departure signal is used by the policy. If all rewards are zero, the guarantee is the corresponding equality of zero rewards.

### Theorem 2.2 (optimal constant and exact scope of the scalar condition)

For every c>1/2, there is a finite three-type instance with finite positive arrival rates and positive exponential mean lifetimes on which every online policy earns less than c times OMN in limiting superior expected reward. Hence one half is the optimal uniform factor on the NBUE class, even with symmetric rewards. Separately, NBUE is necessary and sufficient for E[min(L,T)]≥E[L]Pr(L≤T) to hold for every independent censoring clock T∈[0,∞]. This scalar characterization is not a necessary-condition theorem for all possible half-competitive matching policies.

Theorem 4.1 proves the scalar assertion, §5 proves Theorem 2.1 from the stochastic inputs of §§3–4, and §6 proves the optimality assertion with a fully nondegenerate family.

### Lemma 2.3 (benchmark limit and presence relaxation)

Define ρ_i=λ_i m_i and ρ(S)=Σ_{i∈S}ρ_i. Let U be the maximum of Σ_ij r_ij y_ij over nonnegative y satisfying

$$ \sum_j(y_{ij}+y_{ji})\le\lambda_i\quad(i\in I), \tag{2.4} $$

$$ \sum_{i\in S}y_{ij}\le\lambda_j(1-e^{-\rho(S)})
\quad(j\in I,\ \varnothing\ne S\subseteq I). \tag{2.5} $$

Then the limit (2.2) exists, is finite, and obeys OMN≤U for all independent finite-mean lifetimes, with no NBUE assumption.

**Proof.** Set f(H)=E OPT(H). The union of optimal matchings restricted to two disjoint consecutive time blocks is feasible, so independent stationary arrival increments give f(H+K)≥f(H)+f(K). Also 0≤f(H)≤RΛH/2, where R=max_ij r_ij and Λ=Σ_iλ_i. For every fixed a>0, partition H into floor(H/a) full blocks to obtain liminf f(H)/H≥f(a)/a. Taking the supremum over a proves convergence to sup_{a>0}f(a)/a, since every ratio is bounded by that same supremum. This proves finiteness and existence without any assumed stationary prophet policy.

For a fixed H choose a maximum matching, with a deterministic tie rule, and let y_ij be its expected number of ordered (i,j) matches divided by H. Each type-i arrival is used at most once, giving (2.4), including the factor two for y_ii. Charge every (i,j) match to its later type-j arrival. Before that arrival at s, some earlier type in S must still be present, even if no matching were ever done. Under the marked-Poisson input, these unmatched-presence counts are independent Poisson variables with means λ_i∫_0^s S_i(u)du≤ρ_i. Inserting a type-j arrival into the input does not alter its strictly earlier presence population. Campbell's formula therefore bounds the expected number of charged arrivals by λ_j H(1−e^{−ρ(S)}), proving (2.5). This argument bounds a foresighted matching by full presence; it does not apply online-state PASTA to a prophet's anticipatory decisions. The feasible polytope is nonempty and compact by (2.4), so U exists. Since f(H)/H≤U for every H, the limit satisfies OMN≤U. ∎

## 3. General lifetimes: construction and availability

### Proposition 3.1 (stationary causal construction and an empty start)

For independent Poisson arrivals and independent positive finite-mean lifetimes, every deterministic static type-priority policy with FCFS within a type has a stationary causal realization. Its empty-start count vector converges by coupling to this realization, in distribution and in first moments. Its expected reward per unit time converges to the stationary reward intensity. No Markov assumption or finite expected coupling time is required.

**Proof.** On the entire real line let the type-i arrivals, with their independent lifetime marks, form a Poisson random measure of intensity λ_i ds G_i(dℓ). Write P_i(t) for the number of these agents present at t when matches are ignored: their arrival is s<t and s+ℓ>t. The marking theorem gives independent Poisson counts with means ρ_i=λ_i m_i. At a fixed integer time the total presence is zero with probability exp(−Σ_iρ_i)>0. The marked Poisson input is ergodic under a unit time shift: for bounded-window events the disjoint-window independence gives mixing, and approximation by such cylinder events extends this to its sigma field. A factor, including the presence process, is ergodic. The ergodic theorem therefore gives infinitely many presence-empty integer times in each time direction, almost surely.

To define the policy up to any time t, start empty at any such time e< t and apply the finite event history between e and t. The number of arrivals on a bounded interval is finite. Each agent has a finite lifetime almost surely, and there are finitely many relevant abandonment events in this construction. Starting at an earlier presence-empty time gives the same result: at the later empty time no input agent can be present, so both policies must be empty. Consequently the definition is independent of the chosen empty time. This also proves time-translation equivariance (any past empty time, not its integer label, may be used), stationarity, and consistency between different target times. The rule only uses observed arrivals, ages and abandonments, so it is causal. The random measure construction is measurable, as can also be seen by simulation from −k and eventual agreement at every rational target time.

Couple the stationary system with a system begun empty at 0 using all subsequent arrivals and marks. Both available populations are subsets of the full stationary presence population. At the first nonnegative integer τ at which that population is empty they coincide, and thereafter they coincide forever. We proved τ<∞ almost surely; we do not assert Eτ<∞. Thus the probability of disagreement at t tends to zero. The square moment E[P_i(t)^2]=ρ_i+ρ_i² is constant in t. Cauchy–Schwarz bounds the count difference, and any count times a bounded function of the count vector, on the disagreement event by a quantity tending to zero. This gives the stated count convergence and the uniform integrability needed below.

Let R=max_ij r_ij and Λ=Σ_iλ_i. The instantaneous expected reward density of either policy is bounded by ΛR. Poisson compensation applied to its predictable prearrival state shows that the difference of their expected reward densities at t has absolute value at most ΛR Pr(τ>t). Its time average tends to zero by Cesàro convergence. The stationary reward density is constant, proving the expected long-run reward assertion. All count statements at a deterministic time ignore a null set of event coincidences; processing abandonment before a simultaneous match fixes any remaining boundary convention. ∎

### Lemma 3.2 (deletion and marked-Poisson inequality)

Let N(t) be the empty-start available count vector, and let h be any bounded nonnegative function on the count vectors. Then

$$
\mathbb E[N_i(t)h(N(t)-e_i)]
\le \lambda_i\left(\int_0^t S_i(u)\,du\right)\mathbb E[h(N(t))]. \tag{3.1}
$$

The expression is zero when N_i(t)=0. In the stationary realization,

$$
\mathbb E[N_i h(N-e_i)]\le \rho_i\mathbb E[h(N)]. \tag{3.2}
$$

**Proof.** First fix a finite event history with distinct arrival times, as holds almost surely, and process abandonment before a simultaneous matching decision. If an added agent a is still available at t, it could not have matched on arrival or at any subsequent arrival. Delete it from the history. Induct on subsequent arrivals and abandonments. Every selected other agent remains selected: static type priorities are unchanged, and deleting an unselected member of an FCFS list does not change its selected member. The other agents consequently have exactly the same status in both histories. This is the deletion property; it does not assert that all within-type rules have identical laws.

Sum h of the count vector with each available type-i agent removed. By deletion, the resulting vector is the policy state in the history with that arrival omitted. The Mecke formula for the marked intensity λ_i ds G_i(dℓ), rather than a density assumption on G_i, gives

$$
\mathbb E[N_i(t)h(N(t)-e_i)]
=\lambda_i\int_0^t\int\mathbb E[Q_{s,\ell}(t)h(N(t))]G_i(d\ell)\,ds.
$$

Here Q is the indicator that the added agent remains available in the augmented system; the N inside the integrand is the state of the unaugmented input. Necessarily Q≤1{ℓ>t−s}. The latter bound is deterministic for the inserted mark. Pulling out E[h(N(t))] proves (3.1), with atoms in G_i allowed. Proposition 3.1, the boundedness of h, the count uniform integrability, and monotone convergence of the survival integral give (3.2). This adapts the deletion–Mecke proof of ANNS, Appendix C.2, to an arbitrary mark law; the mechanism is inherited. ∎

### Lemma 3.3 (availability without exponential lifetimes)

For every nonempty type subset S, put ρ(S)=Σ_{i∈S}ρ_i and γ_S=(1−exp(−ρ(S)))/ρ(S). Then the stationary policy satisfies

$$
\Pr(N_S>0)\ge\gamma_S\mathbb E N_S,
\qquad N_S=\sum_{i\in S}N_i. \tag{3.3}
$$

**Proof.** Use h(n)=1{Σ_{i∈S}n_i=k} in (3.2) and sum over i∈S. For p_k=Pr(N_S=k),

$$ (k+1)p_{k+1}\le\rho(S)p_k\qquad(k\ge0). \tag{3.4} $$

Let q_k be the mass function of a Poisson variable Z of mean ρ(S). Its recurrence holds with equality, so p_k/q_k is nonincreasing in k. If Pr(N_S>0)=0, (3.3) is immediate. Otherwise, for every j≥2, the ratio average over k≥j is at most its average over 1≤k< j. Cross-multiplication (or truncation followed by monotone convergence for the infinite sums) gives the following comparison; at j=1 both conditional tail probabilities equal one:

$$ \Pr(N_S\ge j\mid N_S>0)\le\Pr(Z\ge j\mid Z>0). $$

Summing these tail inequalities yields E[N_S|N_S>0]≤ρ(S)/(1−e^{−ρ(S)}), which is (3.3). This likelihood-ratio argument also belongs to ANNS; here it follows after the general-law construction replaces their CTMC limit. ∎

## 4. The precise lifetime certificate

### Theorem 4.1 (NBUE is exactly the independent-clock condition)

Let L be nonnegative with 0<m=E L<∞, and S(t)=Pr(L>t). The following statements are equivalent:

1. ∫_t^∞ S(u)du≤mS(t) for every finite t≥0 (NBUE).
2. E[min(L,T)]≥m Pr(L≤T) for every independent T taking values in [0,∞], with abandonment taking precedence at equality.

**Proof.** For deterministic finite t, the layer-cake identity yields

$$
\mathbb E\min(L,t)-m\Pr(L\le t)
=mS(t)-\int_t^\infty S(u)\,du. \tag{4.1}
$$

Thus statement 2 for constant clocks implies statement 1. Conversely, (4.1) is nonnegative under statement 1. For t=∞ both sides of the desired inequality equal m, since L is finite almost surely. Conditional integration over an independent T proves statement 2. At t=0, NBUE implies Pr(L=0)=0; there is no unmentioned instantaneous-lifetime case. ∎

### Proposition 4.2 (examples, moments, and the limit of the characterization)

Deterministic positive lifetimes and every Erlang lifetime are NBUE. Every NBUE law satisfies E L²≤2m² and hence Var(L)≤m². The positive two-point law Pr(L=1/4)=Pr(L=7/4)=1/2 has mean 1 and variance 9/16 but is not NBUE: at T=1/4 the independent-clock inequality reads 1/4≥1/2 and fails.

**Proof.** For L=m deterministically, its tail integral is (m−t)^+ and is bounded by m1{t<m}. For Erlang shape k≥1 and rate a>0,

$$S(t)=e^{-at}\sum_{r=0}^{k-1}\frac{(at)^r}{r!},\qquad
\int_t^\infty S(u)du=\frac{e^{-at}}a\sum_{r=0}^{k-1}(k-r)\frac{(at)^r}{r!}\le\frac{k}{a}S(t).$$

Its mean is k/a. Integrating the NBUE inequality over t and applying Tonelli gives E L²/2≤m∫_0^∞S(t)dt=m², even without initially assuming a second moment. The two-point calculations are direct. The failure of this scalar certificate does not prove that a matching instance admits no half-competitive policy; no such converse is asserted. ∎

### Lemma 4.3 (Palm occupation versus abandonment)

Let n_i=E N_i and let d_i be the stationary intensity of unmatched abandonments of type i under the static policy. With NBUE lifetimes,

$$ n_i\ge m_i d_i. \tag{4.2} $$

If x_ij denotes the stationary rate at which an earlier type-i agent matches an arriving type-j agent, then

$$ d_i+\sum_j(x_{ij}+x_{ji})=\lambda_i,
\qquad \frac{n_i}{m_i}+\sum_j(x_{ij}+x_{ji})\ge\lambda_i. \tag{4.3} $$

Self-type matches correctly count twice in these sums.

**Proof.** Insert a Palm type-i arrival at time 0 into an independent stationary background. Its state immediately before arrival is determined by the past and is independent of the inserted lifetime L_i. In a counterfactual run, give this tagged agent infinite lifetime and preserve every other arrival and lifetime mark. Start from the same full available-agent configuration at time 0, including identities, arrival ages and preserved other-agent marks, not just a count vector. Let T_i be the time to its first match in this counterfactual system, setting T_i=0 for a match on arrival and T_i=∞ if it never matches. This construction is measurable from the background, other marks and fixed rule; it does not use L_i. Thus T_i is independent of L_i. It remains well-defined on every finite interval even if the added immortal agent prevents subsequent presence-empty epochs.

Until the first of tagged abandonment and its counterfactual match, the real and counterfactual histories coincide. The tagged waiting duration is U_i=min(L_i,T_i), and it abandons unmatched precisely on {L_i≤T_i}. This is a pathwise comparison before the first differing event, not a conditioning-on-survival argument.

Stationary Campbell mass transport gives

$$ n_i=\lambda_i\mathbb E U_i,
\qquad d_i=\lambda_i\Pr(L_i\le T_i). \tag{4.4} $$

For the first equality, each Palm arrival sends unit occupation mass along [0,U_i); integrate its indicator and use Tonelli. For the second, each abandoning arrival sends one unit to its abandonment time. Translation invariance and integration of 1{s+L_i∈[0,1)} over s give one unit per abandoning Palm arrival. All quantities are finite since U_i≤L_i and m_i<∞. Theorem 4.1 proves (4.2). Expected count conservation on a stationary interval gives the first identity of (4.3), or the same identity follows by splitting Palm arrivals into matched and abandoned arrivals. Combining it with (4.2) proves the second. The inequality has this direction; the inventory n_i is not replaced by m_i d_i. ∎

### Lemma 4.4 (prefix arrival rates)

For any nonempty prefix S of the positive priority scores for an arriving type j,

$$ \sum_{i\in S}x_{ij}=\lambda_j\Pr(N_S>0)
\ge\lambda_j\gamma_S\sum_{i\in S}n_i. \tag{4.5} $$

**Proof.** The arrival matches some available agent in S exactly when N_S>0, because S precedes all other acceptable types. Poisson compensation for the causal prearrival state gives the equality. The tagged incoming agent is not included in N_S. Lemma 3.3 gives the inequality. ∎

## 5. A mean-only policy and its value certificate

The construction and algebra in this section are inherited from [ANNS26, §§5.1–5.3]. The stochastic inputs proved above are the extension.

Let $I$ be a finite nonempty type set. For every $i\in I$, let $\lambda_i,m_i>0$, and let $r_{ij}\geq0$ be the reward when type $i$ is the earlier endpoint and type $j$ the later endpoint. All rewards are finite. Define, for nonempty $S\subseteq I$,

$$
\rho_S=\sum_{i\in S}\lambda_i m_i,
\qquad
\gamma_S=\frac{1-e^{-\rho_S}}{\rho_S}.
\tag{5.1}
$$

Thus $0<\gamma_S\leq1$. For $v\in[0,\infty)^I$, put

$$
u_{ij}(v)=(r_{ij}-v_i-v_j)^+,
\tag{5.2}
$$

and, using $\max\varnothing=0$,

$$
Z_{Sj}(v)=\left(\min_{i\in S}u_{ij}(v)
       -\max_{i\in I\setminus S}u_{ij}(v)\right)^+.
\tag{5.3}
$$

Define the map

$$
F_i(v)=m_i\sum_{j\in I}\lambda_j
               \sum_{\substack{\varnothing\ne S\subseteq I\\i\in S}}
                    \gamma_S Z_{Sj}(v).
\tag{5.4}
$$

These are precisely the unrestricted equations (17)–(18) of the cited paper after the parameter substitution $\mu_i=1/m_i$.

### Lemma 5.1 (telescoping and prefix support)

For every $v\geq0$,

$$
\sum_{\substack{\varnothing\ne S\subseteq I\\i\in S}}
Z_{Sj}(v)=u_{ij}(v).
\tag{5.5}
$$

For a fixed $j$, every set with $Z_{Sj}(v)>0$ is a prefix of any order that lists the positive scores $u_{ij}(v)$ in decreasing order. Equal scores may be ordered by a fixed ordering of type labels.

**Proof.** List the types having positive score as $i_1,\ldots,i_k$, with scores $a_1\geq\cdots\geq a_k>0$, set $a_{k+1}=0$, and put $P_\ell=\{i_1,\ldots,i_\ell\}$. Formula (5.3) assigns $Z_{P_\ell,j}=a_\ell-a_{\ell+1}$; intermediate prefixes within a tied block have weight zero. A non-prefix set has some outside score at least as large as its smallest inside score, so its weight is zero. Any set containing a zero-score type has weight zero as well. For $i=i_q$, summing the weights of prefixes containing $i$ gives $\sum_{\ell=q}^k(a_\ell-a_{\ell+1})=a_q$. If $u_{ij}=0$, every set containing $i$ has zero weight. This proves both assertions. $\square$

### Lemma 5.2 (fixed point and deterministic mean-only selection)

The map $F$ has a fixed point $v\in[0,\infty)^I$.

**Proof.** Each $Z_{Sj}$, and hence $F$, is continuous because it is formed from finitely many continuous positive-part, minimum, and maximum operations. By (5.5) and $\gamma_S\leq1$, for $v\geq0$,

$$
0\leq F_i(v)
\leq m_i\sum_j\lambda_j u_{ij}(v)
\leq m_i\sum_j\lambda_j r_{ij}.
$$

Consequently $F$ maps the nonempty compact convex box

$$
B=\prod_{i\in I}\left[0,\,1+m_i\sum_j\lambda_jr_{ij}\right]
$$

into itself. Brouwer's fixed-point theorem gives the result. $\square$

For a deterministic choice depending only on $(\lambda,m,r)$, one may fix a type order and choose the lexicographically least fixed point in $B$. Such a point exists: the fixed-point set is nonempty and compact, and successive minimization of the finitely many coordinates preserves nonempty compactness. This selection is used only to specify a deterministic parameter-based policy; no efficient-computation assertion is needed. Alternatively, the uniqueness theorem proved in the cited paper may be imported with its original attribution.

Fix this $v$ from now on, and write $z_{Sj}=Z_{Sj}(v)$. The fixed-point identity is

$$
\frac{v_i}{m_i}
=\sum_j\lambda_j\sum_{S\ni i}\gamma_S z_{Sj}.
\tag{5.6}
$$

### 5.1 Policy definition and its verified stochastic inputs

For each arriving type $j$, accept exactly the waiting types $i$ with $u_{ij}(v)>0$. Order them by decreasing score, break type ties by the fixed type order, and select the oldest waiting individual of the selected type. If no accepted type is available, the arrival waits. The individual rule is fixed and stable under deletion of an unselected individual. The priorities use $(\lambda,m,r)$ only.

Let $M\subseteq I\times I$ be its accepted ordered pairs, and let $\mathcal P_j$ be the nonempty prefixes of type $j$'s accepted-type list. All positive weights $z_{Sj}$ are supported on $\mathcal P_j$. Let $n_i\geq0$ be its mean available inventory and $x_{ij}\geq0$ its long-run ordered match rates, with $x_{ij}=0$ outside $M$. The following are the exact inputs needed by the algebra:

$$
\frac{n_i}{m_i}+\sum_j(x_{ij}+x_{ji})\geq\lambda_i
\qquad(i\in I),
\tag{5.7}
$$

$$
\sum_{i\in S}x_{ij}
\geq\lambda_j\gamma_S\sum_{i\in S}n_i
\qquad(S\in\mathcal P_j).
\tag{5.8}
$$

Lemma 4.3 produces (5.7) from $n_i\geq m_i d_i$ and $d_i+\sum_j(x_{ij}+x_{ji})=\lambda_i$. Lemma 4.4 produces (5.8) from the exact prefix-match identity

$$
\sum_{i\in S}x_{ij}
=\lambda_j\Pr\!\left\{\sum_{i\in S}N_i>0\right\}
$$

and $\Pr\{\sum_{i\in S}N_i>0\}\geq\gamma_S\sum_{i\in S}n_i$.

No substitution of $n'_i=m_i d_i$ is required. In particular, the actual inventory vector enters (5.7) and (5.8) simultaneously. This avoids changing availability constraints or priority weights.

### Proposition 5.3 (policy lower certificate)

If (5.7)–(5.8) hold, then the policy reward $V=\sum_{ij}r_{ij}x_{ij}$ satisfies

$$
V\geq\sum_i\lambda_i v_i.
\tag{5.9}
$$

**Proof.** For an accepted pair, (5.2) and (5.5) give

$$
r_{ij}=v_i+v_j+\sum_{S\ni i}z_{Sj}.
$$

The rates outside $M$ vanish. Regroup the resulting finite sums, apply (5.7) using $v_i\geq0$, and apply (5.8) using $z_{Sj}\geq0$:

$$
\begin{aligned}
V
&=\sum_i v_i\sum_j(x_{ij}+x_{ji})
 +\sum_j\sum_{S\in\mathcal P_j}z_{Sj}\sum_{i\in S}x_{ij}\\
&\geq\sum_i v_i\left(\lambda_i-\frac{n_i}{m_i}\right)
 +\sum_j\sum_{S\in\mathcal P_j}
       z_{Sj}\lambda_j\gamma_S\sum_{i\in S}n_i\\
&=\sum_i\lambda_i v_i
 +\sum_i n_i\left(-\frac{v_i}{m_i}
        +\sum_j\lambda_j\sum_{S\ni i}\gamma_Sz_{Sj}\right)\\
&=\sum_i\lambda_i v_i,
\end{aligned}
$$

where the last equality is (5.6). Diagonal pairs $i=j$ cause no exception: their match flow appears twice, exactly as their two agents and two value terms do. $\square$

This is the dual certificate of Section 5.1 in the cited paper, written directly as an algebraic proof. The one-sided balance (5.7), rather than exponential equality, is all it uses.

### 5.2 Prophet relaxation

Define the finite-dimensional polytope of ordered match flows $y\geq0$ by

$$
\sum_j(y_{ij}+y_{ji})\leq\lambda_i
\qquad(i\in I),
\tag{5.10}
$$

$$
\sum_{i\in S}y_{ij}\leq\lambda_j(1-e^{-\rho_S})
\qquad(j\in I,\ \varnothing\ne S\subseteq I).
\tag{5.11}
$$

Write $U$ for the maximum of $\sum_{ij}r_{ij}y_{ij}$ over this polytope. With Poisson arrivals and arbitrary independent finite-mean lifetimes, the mean no-matching presence is $\lambda_i m_i$; the marked-Poisson presence argument therefore gives the same omniscient upper bound $\mathrm{OMN}\leq U$. Lemma 2.3 proved this stochastic upper bound directly for histories starting empty. It does not require NBUE.

### Proposition 5.4 (prophet upper certificate)

$$
U\leq2\sum_i\lambda_i v_i.
\tag{5.12}
$$

**Proof.** By (5.2) and (5.5), for every ordered pair, accepted or not,

$$
r_{ij}\leq v_i+v_j+\sum_{S\ni i}z_{Sj}.
$$

Thus every feasible $y$ obeys

$$
\begin{aligned}
\sum_{ij}r_{ij}y_{ij}
&\leq\sum_i v_i\sum_j(y_{ij}+y_{ji})
 +\sum_j\sum_S z_{Sj}\sum_{i\in S}y_{ij}\\
&\leq\sum_i\lambda_i v_i
 +\sum_j\sum_S z_{Sj}\lambda_j(1-e^{-\rho_S})\\
&=\sum_i\lambda_i v_i
 +\sum_i\lambda_i m_i
       \sum_j\lambda_j\sum_{S\ni i}\gamma_S z_{Sj}\\
&=2\sum_i\lambda_i v_i.
\end{aligned}
$$

Here the second line uses (5.10)–(5.11), the third uses
$1-e^{-\rho_S}=\gamma_S\rho_S$, and the last uses (5.6). Taking the maximum proves (5.12). $\square$

### 5.3 Proof of Theorem 2.1

By (5.7), (5.8), Proposition 3.1 for the long-run interpretation of $n,x,V$ for empty initialization, and Lemma 2.3 for $\mathrm{OMN}\leq U$, Propositions 5.3–5.4 give

$$
V\geq\sum_i\lambda_i v_i\geq\frac U2\geq\frac{\mathrm{OMN}}2.
\tag{5.13}
$$

The distribution of each lifetime enters the selected policy only through its mean $m_i$. Hence the same fixed priority lists work for all independent NBUE lifetime laws with that mean vector, including laws with atoms and unbounded support, by the marked-process inputs proved in §§3–4. The certificate does not require a density, increasing hazard, or an exponential residual-lifetime identity.

This proof intentionally makes no claim that NBUE is necessary for every half-competitive matching policy. Its necessity concerns only the separate independent-censoring occupation certificate. It also makes no claim about non-Poisson arrivals, correlated lifetimes, rewards that vary with waiting time, estimation of unknown parameters, or bit complexity.

## 6. Sharpness with finite rates and positive lifetimes

The half barrier and rare-high/frequent-low idea are from [KSSW22]. The following explicit family and estimates keep every parameter inside our model, without an unproved limiting-buyer reduction.

### 6.1 Three-type family

Fix $0<\varepsilon\leq1$. Use three types $G,H,L$, with independent Poisson arrival processes and independent exponential lifetimes as follows:

| Type | Arrival rate | Mean lifetime |
|---|---:|---:|
| Good $G$ | $\varepsilon$ | $1$ |
| High buyer $H$ | $\varepsilon$ | $\varepsilon$ |
| Low buyer $L$ | $1/\varepsilon$ | $\varepsilon$ |

Only a good and a buyer generate positive reward. The symmetric rewards are

$$
r_{GH}=r_{HG}=h:=1+\frac1\varepsilon,
\qquad r_{GL}=r_{LG}=1;
\tag{6.1}
$$

all other rewards are zero. One may equivalently forbid the zero-reward pairs. Every arrival rate and lifetime mean is finite and strictly positive. Every lifetime distribution is exponential and therefore NBUE. The system starts empty.

### Lemma 6.1 (all-online finite-horizon upper bound)

Let an online policy be arbitrary: it may be randomized, depend on the whole observed history, and delay a match while its agents remain available. It may not see a future lifetime or future arrival. For a horizon $T$, let $M_H(T),M_L(T)$ count its positive-reward matches with high and low buyers, respectively. Let $N_G(t),N_H(t)$ be its available counts, and let $D_G(T)$ count unmatched good abandonments.

Because the mean good lifetime is one and its departure time remains hidden until abandonment, the good-abandonment counting process has predictable intensity $N_G(t-)$. Integrability follows by domination by the no-matching presence process. Thus

$$
\mathbb E D_G(T)=\int_0^T\mathbb E N_G(t)\,dt.
\tag{6.2}
$$

Good flow conservation, allowing additional nonnegative consumption by any zero-reward matches, yields

$$
\mathbb E[M_H(T)+M_L(T)]
\leq\varepsilon T-\int_0^T\mathbb E N_G(t)\,dt
                  -\mathbb E N_G(T).
\tag{6.3}
$$

The following later-arrival charging bound does not require matching immediately upon arrival. Charge each actual good–high-buyer match to the later of its endpoints' arrivals. If the high buyer arrived later, its good partner was still available immediately before that high arrival: the good is matched to this buyer only at the eventual match time. If the good arrived later, its high-buyer partner was still available immediately before that good arrival. Different matches have different charged arrivals. Therefore, pathwise,

$$
M_H(T)\leq
\#\{H\text{ arrivals by }T\text{ seeing }N_G>0\}
+\#\{G\text{ arrivals by }T\text{ seeing }N_H>0\}.
$$

The state immediately before each arrival is predictable for a nonanticipating policy. Poisson compensation gives

$$
\begin{aligned}
\mathbb E M_H(T)
&\leq\varepsilon\int_0^T\Pr(N_G(t)>0)\,dt
 +\varepsilon\int_0^T\Pr(N_H(t)>0)\,dt\\
&\leq\varepsilon\int_0^T\mathbb E N_G(t)\,dt+\varepsilon^3T.
\end{aligned}
\tag{6.4}
$$

For the last inequality, the available high count is bounded by the number of high buyers that would remain present if never matched. Starting empty, that count has mean
$\varepsilon^2(1-e^{-t/\varepsilon})\leq\varepsilon^2$.

Let $R_\pi(T)$ denote the expected reward. Since $h-1=1/\varepsilon$, (6.3)–(6.4) cancel the inventory integral:

$$
\begin{aligned}
R_\pi(T)
&=\mathbb E[M_L(T)+M_H(T)]
       +\frac1\varepsilon\mathbb E M_H(T)\\
&\leq\varepsilon T-\int_0^T\mathbb E N_G(t)\,dt
        -\mathbb E N_G(T)
        +\int_0^T\mathbb E N_G(t)\,dt+\varepsilon^2T\\
&\leq\varepsilon(1+\varepsilon)T.
\end{aligned}
\tag{6.5}
$$

In particular, every admissible online policy, with no stationarity assumption, has long-run expected reward at most $\varepsilon(1+\varepsilon)$.

### Lemma 6.2 (feasible prophet lower bound)

For every arriving good, make a private interval beginning at its arrival and ending at the earlier of its latent expiration and the next good arrival. These intervals are pairwise disjoint. Within an interval, the omniscient matching chooses the first high-buyer arrival if there is one; otherwise it chooses the first low-buyer arrival, if any. The chosen match is scheduled at that buyer's arrival. Consequently both endpoints are present, and disjoint intervals prevent reuse of a buyer or good. Knowing that no later high buyer occurs in an interval is permitted for the omniscient benchmark.

Under the Palm distribution at a good arrival, the interval length $W$ is the minimum of an independent $\operatorname{Exp}(1)$ lifetime and $\operatorname{Exp}(\varepsilon)$ time to the next good. Thus $W\sim\operatorname{Exp}(a)$, where $a=1+\varepsilon$, independently of both buyer streams. Write $\Gamma=1/\varepsilon$. The expected reward per complete private interval is

$$
\begin{aligned}
q_\varepsilon
&=h\Pr\{H\text{ arrives during }W\}
 +\Pr\{\text{no }H\text{ but some }L\text{ during }W\}\\
&=h\frac{\varepsilon}{a+\varepsilon}
 +\frac{a}{a+\varepsilon}
 -\frac{a}{a+\varepsilon+\Gamma}\\
&=(1+\varepsilon)\left[
       \frac2{1+2\varepsilon}
       -\frac1{1+2\varepsilon+1/\varepsilon}
      \right].
\end{aligned}
\tag{6.6}
$$

The second line follows by conditioning on $W$: the two relevant conditional probabilities are $1-e^{-\varepsilon W}$ and $e^{-\varepsilon W}(1-e^{-\Gamma W})$.

For a finite horizon $T$, consider these full intervals for goods arriving by $T$. Campbell's formula gives expected total selected reward $\varepsilon Tq_\varepsilon$, even though the last selection may depend on events after $T$. Every interval except possibly that of the last good arriving by $T$ ends by $T$, because its next good arrival is already within the horizon. Delete the last selection if its match lies after $T$. This loses at most $h$ on every sample path and leaves a valid matching among agents arriving by $T$. Hence

$$
\mathrm{OMN}_\varepsilon(T)
\geq\varepsilon q_\varepsilon-\frac hT,
\qquad
\mathrm{OMN}_\varepsilon
\geq\varepsilon q_\varepsilon.
\tag{6.7}
$$

Here $\mathrm{OMN}_\varepsilon(T)$ is the expected optimal reward divided by $T$, and $\mathrm{OMN}_\varepsilon$ is its limit, whose existence was proved in Lemma 2.3. This is an empty-start finite-horizon argument, so no interchange of a stationary limit with $\varepsilon\downarrow0$ is being assumed.

### Corollary 6.3 (explicit ratio and proof of Theorem 2.2)

Combining (6.5) and (6.7), every online policy satisfies, with V_π interpreted as limiting superior for this sentence, on this fixed finite instance,

$$
\frac{V_\pi}{\mathrm{OMN}_\varepsilon}
\leq
\frac{\varepsilon(1+\varepsilon)}{\varepsilon q_\varepsilon}
=\frac{(1+2\varepsilon)(1+\varepsilon+2\varepsilon^2)}
       {2+\varepsilon+2\varepsilon^2}.
\tag{6.8}
$$

The right side tends to one half as $\varepsilon\downarrow0$. More explicitly,

$$
\frac{(1+2\varepsilon)(1+\varepsilon+2\varepsilon^2)}
       {2+\varepsilon+2\varepsilon^2}
-\frac12
=\frac{\varepsilon(5+6\varepsilon+8\varepsilon^2)}
       {4+2\varepsilon+4\varepsilon^2}
\leq2\varepsilon
\qquad(0<\varepsilon\leq1).
\tag{6.9}
$$

The last inequality is equivalent to $2\varepsilon\leq3$. Given any proposed uniform factor $c>1/2$, choose a strictly positive $\varepsilon<\min\{1,(c-1/2)/2\}$. This single valid instance defeats the factor $c$ for every online policy, including policies that know its entire distributional parameters. Together with the NBUE lower guarantee, the optimal uniform competitive ratio on the full NBUE class is exactly one half.

The proof does not claim that the one-half upper bound is newly discovered; the explicit finite-parameter estimate closes a model-boundary detail needed for the stated extension.

## 7. Interpretation, evidence and limits

The same priority lists work for exponential, deterministic, Erlang and all other NBUE laws with the same type means. This is a distributional-robustness guarantee at every fixed finite market size, followed only by the time-average limit. It is not exact stochastic optimality, an optimality claim within each instance, or a high-volume asymptotic claim. Knowing a full patience distribution may still improve instance-specific performance.

The scalar characterization identifies exactly when this occupation certificate works for all independent clocks. It does not characterize the largest lifetime class admitting a half-competitive policy. Proposition 4.2 in fact gives a non-NBUE law inside the variance class used by the nearest published comparison, so the new half guarantee and that paper's broader general-law guarantee have different domains. Extending the half guarantee to that larger domain remains unresolved here.

Poisson arrivals are used for independent marking, insertion/compensation and the availability bound. Independent hidden lifetimes are used both for the Palm clock and the hardness compensation. Time-independent nonnegative rewards permit the prophet presence relaxation and the static score construction. Arbitrary renewal arrivals, dependent marks, advance departure announcements, waiting-time-dependent rewards, holding costs and learning unknown parameters are outside the theorem. We do not assert a running-time bound, fixed-point uniqueness, an efficient exact-real implementation or a finite-horizon half ratio. The empty-start guarantee is a long-run expected ratio; the hardness upper bound is valid at every finite horizon.

### 7.1 Scope of the literature check

The inspected sources include [ANNS26] §§2.3, 3, 5, 7 and Appendix C.2, [HWX26]'s model and main guarantees, the full publisher text of [ADSW25], the official abstract/metadata of [LWY26], the §5 hardness proof in the technical preprint [KSSW22], and the indicated standard results in [LP18]. Public-topic searches covered NBUE matching, general patience/sojourn laws, static priorities and half guarantees. No exact overlap was identified in that scope; this is not a global priority certification.

Two access limitations remain explicit. The available author PDF for [LWY26] is an older 34-page manuscript with a different title and an obsolete two-thirds upper bound; it is not treated as the final journal text. Separately, SSRN record 7587238 reports a 22 October 2026 revision of [ANNS26], but its PDF could not be retrieved. The current arXiv record and current author-linked institutional PDF identify v1 and retain exponential patience; byte identity with the inaccessible SSRN revision is not asserted. These limitations affect the completeness of novelty screening, not the self-contained new proof above.

### 7.2 Reproducibility and verification scope

The mathematical conclusions are supported by the written proofs, including the non-Markov construction, general-mark Mecke calculation, independent-clock equivalence and explicit finite-parameter hardness. The accompanying reproduction directory contains exact finite arithmetic checks and separately labeled numerical diagnostics. A finite sample or a small fixed-point residual does not certify the universal theorem.

This manuscript contains written proofs. Formal proof-assistant verification has not been completed.

## References

**[ANNS26]** Nick Arnosti, Rad Niazadeh, Pranav Nuti and Felipe Simon. *Dynamic Matching with Abandonment: Optimal Guarantees via Static Priority Policies*. arXiv:2610.12991v1, 9 October 2026. [Primary full text](https://arxiv.org/html/2610.12991v1). Exponential-model half theorem, static priorities, deletion availability, value certificate and explicit general-sojourn future direction. This is a non-peer-reviewed preprint.

**[LWY26]** Zihao Li, Hao Wang and Zhenzhen Yan. *Fully Online Matching with General Stochastic Arrivals and Departures*. Operations Research 74(2), 752–769 (2026); first online 10 November 2025. [DOI:10.1287/opre.2023.0190](https://doi.org/10.1287/opre.2023.0190). Final publisher abstract/metadata inspected; final full-text access limitation stated above. [Older author manuscript, explicitly not the final article](https://haowang.site/files/main_OR.pdf).

**[ADSW25]** Angelos Aveklouris, Levi DeValve, Maximiliano Stock and Amy R. Ward. *Matching Impatient and Heterogeneous Demand and Supply*. Operations Research 73(3), 1637–1658 (2025); first online 15 May 2024. [DOI:10.1287/opre.2022.0005](https://doi.org/10.1287/opre.2022.0005). Publisher text inspected for general patience, the fluid regime and priority dependence.

**[HWX26]** Siqi He, Yehua Wei and Jiaming Xu. *Longest-Queue Policies in Dynamic Matching with Abandonments*. arXiv:2611.01431v1, 1 November 2026. [Primary full text](https://arxiv.org/html/2611.01431v1). Exponential patience, queue-dependent policies and high-volume fluid comparison; not the NBUE theorem.

**[KSSW22]** Kristen Kessel, Amin Saberi, Ali Shameli and David Wajc. *The Stationary Prophet Inequality Problem*. [Technical preprint arXiv:2107.10516v1](https://arxiv.org/abs/2107.10516v1), 22 July 2021, especially §5. A short proceedings entry appeared at EC 2022, DOI [10.1145/3490486.3538374](https://doi.org/10.1145/3490486.3538374); the technical source used is the full preprint. The rare-high/frequent-low construction and the half barrier are attributed to this work.

**[LP18]** Günter Last and Mathew Penrose. *Lectures on the Poisson Process*. Cambridge University Press, 2018. DOI [10.1017/9781316104477](https://doi.org/10.1017/9781316104477). [Author manuscript dated 21 August 2017](https://stoch.math.kit.edu/img/Last/lastpenrose2017.pdf). Theorem 4.1 (Mecke), Theorem 5.6 (marking), §8.4 (mixing/ergodicity) and §9.2 (Poisson Palm insertion); marked mixing follows by the same disjoint-window argument supplied in Proposition 3.1.

**[BCR00]** Félix Belzunce, José Candel and José M. Ruiz. *Testing mean residual alternatives by dispersion of residual lives*. Journal of Statistical Planning and Inference 86(1), 113–127 (2000). DOI [10.1016/S0378-3758(99)00167-6](https://doi.org/10.1016/S0378-3758(99)00167-6). Publisher abstract and definition excerpts support the classical NBUE terminology; none of its testing results is used in the proof.
