# Exact indices for two-state collapsing bandits: global threshold structure and average-reward ties

**Wen Weixiang**  
**25 November 2026**  
Research manuscript. Formalization is pending; no Lean verification is claimed.

## Abstract

We study the stationary infinite-horizon two-state collapsing arm in which activation observes the current latent state before applying a state-dependent transition, whereas passivity supplies no observation. For all strictly positive, positively persistent transition matrices satisfying the original intervention-improvement assumptions, we prove existence of a single-threshold discounted optimal policy for every subsidy. Its orientation is determined by the difference between the active and passive transition slopes. A passive-value subtraction reduces the Bellman equation to an affine first-activation envelope. We then parameterize all subsidies by the zero of its active affine term. A positive two-by-two substochastic determinant proves strict subsidy monotonicity, independently of finite-state threshold arguments, and yields exact Whittle indices and a terminating rational evaluator. Equal transition slopes require a qualification of the historical conjecture: at one subsidy every policy is optimal, including dual-threshold policies. We derive the average-reward limit, identify a canonical bias, and distinguish its action ties from gain-only optimality and from alternative biases. Finally, the discounted construction extends to arbitrary finite affine mixtures of reset laws, without stochastic-order assumptions. The results concern a single relaxed arm; they do not assert global optimality of a multi-arm Whittle policy.

## 1. Introduction and relation to previous work

An intervention can both improve a system and reveal its current state. This combination appears in the collapsing-bandit model of Mate, Killian, Xu, Perrault and Tambe [R1]. Each arm has a binary latent state. An active decision observes that state and changes its transition law; a passive decision leaves the state unobserved. Although the latent state space has only two points, the controller's belief can follow arbitrarily long passive trajectories. An infinite-horizon analysis must therefore account for an infinite family of reachable beliefs.

The original paper established sufficient conditions for forward or reverse threshold optimality and proposed a conjecture excluding dual-threshold policies [R1, Conjecture 1]. Mate, Perrault and Tambe [R2] subsequently enlarged the sufficient region. In the perfect-observation, linear-reward specialization, their discount-dependent condition is

\[
\beta\bigl[(p_1-p_0)+(a_1-a_0)\bigr]\le1.
\tag{1.1}
\]

Our discounted theorem imposes no condition of this kind. In particular, it covers the high-persistence region in which (1.1) fails. The theorem is stated on the entire belief interval, and hence applies to the actual countable reachable set without a truncation convention.

Threshold existence and indexability are separate questions. Even after proving that a threshold policy is optimal for each subsidy, one must show that the passive-optimal set expands as the subsidy increases. The threshold theorem in [R1] is accompanied by a finite-state induction; its application to an unrestricted infinite belief set requires additional justification. We instead give a direct parameterization of the infinite-state Bellman solution. The derivative of the resulting subsidy map has a positive determinant numerator. This proves the required nesting, resolves all discounted action ties, and provides an explicit index evaluator.

The phrase “dual-threshold policies are never optimal” also needs an indifference qualification. When the two transition slopes agree, there is a subsidy at which every admissible policy is optimal. We give a rational example with a genuinely passive-active-passive pattern on reachable beliefs. The positive result is existence of a single-threshold optimal selector; outside the equal-slope surface the Bellman advantage is strictly monotone, so a nondegenerate dual active region cannot occur.

Average-reward reset-process indexability has substantial prior history. Liu, Weber and Zhao [R3] studied arbitrary two-observation reset sequences and proved an average-reward indexability result. After subtraction of an average passive potential, and a reversal of binary labels when needed, the reachable-chain version of our average problem fits their framework. We do not claim average indexability of two-observation reset processes as a new general principle. The average-reward part below supplies the explicit discount limit for the present model and carefully identifies bias-selected actions, including a critical subsidy at which normalized bias solutions need not be unique. These distinctions matter because gain-only optimality cannot distinguish a finite transient action change.

Other nearby results have different reset or observation conventions. Akbarzadeh and Mahajan [R4] analyze controlled-restart families with identical active transition rows. The treatment-adherence model of Niño-Mora and Pellitero García [R5] likewise has a state-independent active reset, and explicitly discusses the difference between transient-state bias rankings and recurrent average performance. The explicit continuous-bias classification, exceptional family and unique discount-selected bias below concern the present model with two distinct post-activation beliefs.

Recent partially observed bandit papers also give conditional structural results. Krishna, Meshram and Kaza [R6, Theorem 1 and Proposition 1] prove threshold structure when an immediate-reward difference margin dominates an additional Lipschitz continuation bound. Meshram, Krishna and Kaza [R7, Theorem 4 and Proposition 2] establish three-state indexability under subsidy-sensitivity assumptions and a discount-dependent sufficient inequality; their Theorem 3 treats an identical-row restart specialization. Jia and Liu [R8] use a common latent transition matrix across actions and develop finite-step index approximations. Their Theorem 1 assumes exact indexability, while Theorem 2 gives a limiting verification criterion through convergence of finite-step roots. These results do not supply the all-parameter finite affine-reset theorem proved here.

Niño-Mora [R9, Theorem 3.6] gives a conditional performance-metric characterization under optimal-action and regularity assumptions, positive marginal resources, and a marginal integration-by-parts identity. Monotonicity and continuity of the marginal-productivity index remain model-specific verification obligations. Its average transfer theorem [R9, Theorem 4.5] additionally assumes discounted partial-conservation-law indexability and the gain/bias, positivity, index and integral limits of its Assumption 4.4. Its applications concern web crawling, the classical noisy channel and a conditional scalar Kalman analysis. In particular, its Lipschitz compactness argument [R9, Lemma 4.2] is an existing method for vanishing-discount analysis; the corresponding argument below establishes its applicability to this model and supports the explicit complete bias classification.

These comparisons use original full texts, including the four recent preprints [R6–R9], whose full texts were recovered from their official indexed records during the final literature check. Immutable arXiv revision identifiers for those four texts were not independently pinned. Our comparison concerns the inspected versions and does not claim an exhaustive worldwide priority search.

Optimal-stopping reductions, potential subtraction and renewal equations are established tools. Our contribution is the complete result obtained from their particular affine interaction, together with the positive subsidy determinant, exact formulas and explicit limits. Section 7 shows that the determinant argument also covers arbitrary finite reset distributions whose mixture weights depend affinely on the current belief.

## 2. Model, conventions and verification

### 2.1. The original collapsing arm

Throughout Sections 2–6 assume

\[
0<p_0<p_1<1,\qquad 0<a_0<a_1<1,
\qquad p_0<a_0,\qquad p_1<a_1.
\tag{2.1}
\]

Here \(p_i\) and \(a_i\) are the probabilities that the next latent state is one, conditional on current state \(i\), under passive and active control respectively. Set

\[
\rho=p_1-p_0,\quad \alpha=a_1-a_0,\quad
\delta=\alpha-\rho,\quad d_0=a_0-p_0,
\quad s=\frac{p_0}{1-\rho}.
\tag{2.2}
\]

Thus \(0<\rho,\alpha,s<1\). The passive belief map and its iterates are

\[
\tau(b)=p_0+\rho b=s+\rho(b-s),\qquad
\tau^k(b)=s+\rho^k(b-s).
\tag{2.3}
\]

At belief \(b\in[0,1]\), passivity earns expected reward \(b+m\) and moves to \(\tau(b)\). Activation earns expected reward \(b\), observes the current latent state, and moves to \(a_0\) or \(a_1\) with probabilities \(1-b\) and \(b\). The observation precedes the active transition. In particular, the reset beliefs are distinct, and the reward is earned under both actions.

Policies may use the complete available observation history and independent randomization. For discount \(0<\beta<1\), let \(V_{\beta,m}(b)\) be the supremum of their expected discounted rewards. The Bellman equation is

\[
V_{\beta,m}(b)=b+\max\left\{
m+\beta V_{\beta,m}(\tau(b)),\;
\beta[(1-b)V_{\beta,m}(a_0)+bV_{\beta,m}(a_1)]
\right\}.
\tag{2.4}
\]

The actual post-observation reachable set is

\[
\mathcal B=\{\tau^k(a_i):i\in\{0,1\},\ k\ge0\}.
\tag{2.5}
\]

We prove the results on \([0,1]\). They therefore include arbitrary initial beliefs, the set \(\mathcal B\), and its accumulation point \(s\). We do not replace the last state of a finite chain by an artificial absorbing state in any theorem.

**Proposition 2.1 (discounted verification).** Equation (2.4) has a unique bounded continuous solution. Any measurable stationary selector of a maximizing Bellman action attains that value against all causal randomized policies.

**Proof.** The Bellman operator is a contraction of modulus \(\beta\) in the sup norm on bounded functions. It preserves continuity, so iteration from zero converges uniformly to a continuous fixed point. For any action, the fixed point dominates the expected one-step reward plus the discounted next fixed-point value. Conditional expectation and iteration give the same upper bound for any history-dependent randomized policy over every finite number of steps. The terminal term is bounded in absolute value by \(\beta^n\|V\|_\infty\), which tends to zero. A stationary maximizing selector makes every inequality an equality. Its discounted return therefore equals the fixed point. The explicit selectors below are threshold rules and are measurable. \(\square\)

### 2.2. Action sets and the meaning of indexability

Let \(Q^p_{\beta,m}\) and \(Q^a_{\beta,m}\) denote the passive and active branches of (2.4), including the common reward \(b\). We use

\[
\mathcal P^w_{\beta}(m)=\{b:Q^p_{\beta,m}(b)\ge Q^a_{\beta,m}(b)\},
\quad
\mathcal P^s_{\beta}(m)=\{b:Q^p_{\beta,m}(b)>Q^a_{\beta,m}(b)\}.
\tag{2.6}
\]

The first set includes indifference; the second contains states where passivity is the unique Bellman-optimal action. We prove monotone expansion for both conventions. Define

\[
W_\beta(b)=\inf\{m:b\in\mathcal P^w_\beta(m)\}.
\tag{2.7}
\]

A forward threshold activates at smaller beliefs; a reverse threshold activates at larger beliefs. The always-active and always-passive policies are included as limiting thresholds.

## 3. The first-activation envelope

### 3.1. Subtracting the passive value

The value of remaining passive forever is

\[
L_{\beta,m}(b)=\frac{s+m}{1-\beta}
 +\frac{b-s}{1-\beta\rho}.
\tag{3.1}
\]

It satisfies \(L_{\beta,m}(b)=b+m+\beta L_{\beta,m}(\tau(b))\). Write \(H=V_{\beta,m}-L_{\beta,m}\), and put

\[
r_0=\frac{\beta d_0}{1-\beta\rho},\qquad
r_1=\frac{\beta\delta}{1-\beta\rho}.
\tag{3.2}
\]

Direct substitution in (2.4) gives

\[
H(b)=\max\left\{\beta H(\tau(b)),\;
r_0+r_1b-m+\beta[(1-b)H(a_0)+bH(a_1)]\right\}.
\tag{3.3}
\]

The transformed operator is again a contraction. Iteration from zero gives nonnegative iterates, so \(H\ge0\), consistently with the feasibility of the passive policy.

**Lemma 3.1 (orientation and first activation).** Suppose \(\delta\ne0\), and set \(\sigma=\operatorname{sign}(\delta)\). The function \(H\) is monotone in direction \(\sigma\). Its active branch is affine, say

\[
g(b)=A+B(b-s),\qquad
B=r_1+\beta[H(a_1)-H(a_0)],
\tag{3.4}
\]

with \(\sigma B>0\). Moreover,

\[
H(b)=\max\left\{0,\sup_{k\ge0}
\beta^k[A+B\rho^k(b-s)]\right\}.
\tag{3.5}
\]

**Proof.** If \(\delta>0\), the function \(r_0+r_1b\) is increasing. The transformed operator preserves nondecreasing functions: its passive branch composes with increasing \(\tau\), and its active branch has slope \(r_1+\beta[H(a_1)-H(a_0)]>0\). Starting from zero and passing to the uniform limit proves the claim. For \(\delta<0\), the same argument preserves nonincreasing functions and gives a strictly negative active slope.

Unrolling the equation \(H(b)=\max\{g(b),\beta H(\tau(b))\}\) for \(n\) steps gives the maximum of \(\beta^k g(\tau^k(b))\), \(0\le k<n\), and \(\beta^nH(\tau^n(b))\). The last term tends uniformly to zero. Substitution of (2.3) proves (3.5). The zero term is the option never to activate. A positive supremum is attained at a finite \(k\), since all finite-time terms tend to zero. \(\square\)

Before the first activation no new information arrives, so the passive trajectory is deterministic. Equation (3.5) is therefore also a first-activation representation with an optimal continuation after activation. It does not assume that activation occurs in finite time, and randomization over possible first activation times cannot increase their supremum.

### 3.2. Parameterizing exact Bellman solutions

For \(\delta\ne0\), retain \(\sigma\) and define, for every \(c\in\mathbb R\),

\[
F_c(b)=\max\left\{0,\sup_{k\ge0}
\beta^k\sigma(\tau^k(b)-c)\right\}.
\tag{3.6}
\]

Its elementary properties will supply both a solution and its subsidy order.

**Lemma 3.2 (envelope properties).** The function \(F_c\) is bounded for fixed \(c\), monotone in direction \(\sigma\) as a function of \(b\), and 1-Lipschitz in \(b\). As a function of \(c\), it is nonnegative, convex and 1-Lipschitz. It satisfies

\[
F_c(b)=\max\{\sigma(b-c),\beta F_c(\tau(b))\}.
\tag{3.7}
\]

**Proof.** The nonzero candidates in (3.6) are affine in \(b\), with slopes \(\sigma(\beta\rho)^k\), and affine in \(c\), with slopes \(-\sigma\beta^k\). Taking their supremum together with zero proves the monotonicity, Lipschitz and convexity assertions. Splitting the finite candidates into \(k=0\) and \(k\ge1\), while retaining the zero option, proves (3.7). \(\square\)

Define

\[
D_\beta(c)=1-\beta\sigma[F_c(a_1)-F_c(a_0)],\qquad
w_\beta(c)=\frac{|r_1|}{D_\beta(c)},
\tag{3.8}
\]

\[
M_\beta(c)=r_0+w_\beta(c)[\sigma c+\beta F_c(a_0)].
\tag{3.9}
\]

**Proposition 3.3 (exact parametric solution).** For every real \(c\),

\[
1-\beta\alpha\le D_\beta(c)\le1,
\qquad
H_{\beta,M_\beta(c)}(b)=w_\beta(c)F_c(b).
\tag{3.10}
\]

**Proof.** Lemma 3.2 gives \(0\le\sigma[F_c(a_1)-F_c(a_0)]\le\alpha\), proving the denominator bound. Substitute \(H=w_\beta F_c\) and \(m=M_\beta(c)\) into the active branch of (3.3). Its coefficient of \(b\) becomes

\[
r_1+\beta w_\beta[F_c(a_1)-F_c(a_0)]=w_\beta\sigma,
\]

and its constant term becomes \(-w_\beta\sigma c\). The branch is exactly \(w_\beta\sigma(b-c)\). Equation (3.7) verifies (3.3); contraction uniqueness identifies the solution. \(\square\)

## 4. Subsidy monotonicity and exact discounted indices

### 4.1. The positive determinant

The next theorem is the step that converts a threshold representation into indexability.

**Theorem 4.1 (global subsidy order).** If \(\delta\ne0\), the map \(M_\beta:\mathbb R\to\mathbb R\) in (3.9) is a continuous bijection, strictly increasing for \(\sigma=1\) and strictly decreasing for \(\sigma=-1\). For \(c_2>c_1\),

\[
\sigma[M_\beta(c_2)-M_\beta(c_1)]
\ge |r_1|(1-\beta)^2(c_2-c_1)>0.
\tag{4.1}
\]

**Proof.** Write \(F_i(c)=F_c(a_i)\). These functions are convex and Lipschitz, hence differentiable almost everywhere and absolutely continuous on compact intervals. At a common differentiability point, if \(F_i(c)>0\), choose a finite maximizing time \(k_i\) and put

\[
e_i=\beta^{k_i},\qquad z_i=\tau^{k_i}(a_i).
\]

Then \(F_i=e_i\sigma(z_i-c)\) and \(F_i'=-\sigma e_i\). The derivative assertion follows because an affine candidate attaining a differentiable convex envelope has the same derivative there. If \(F_i(c)=0\), nonnegativity and differentiability give \(F_i'=0\); take \(e_i=0\) and any \(z_i\in[0,1]\). This covers the infinite waiting alternative. Distinct finite maximizing times have distinct slopes and can only coexist at an exceptional nondifferentiability point.

Let \(U=\sigma c+\beta F_0\) and \(D=D_\beta(c)\). Almost everywhere,

\[
U'=\sigma(1-\beta e_0),\qquad D'=\beta(e_1-e_0).
\]

Differentiating (3.9) cancels all occurrences of \(c\) in the numerator:

\[
\frac{\sigma M_\beta'(c)}{|r_1|}
=\frac{N}{D^2},
\quad
N=1-\beta[e_0(1-z_0)+e_1z_1]
 +\beta^2e_0e_1(z_1-z_0).
\tag{4.2}
\]

The crucial sign is transparent in the identity

\[
\begin{aligned}
N={}&(1-\beta e_0)(1-\beta e_1)
 +\beta e_0z_0(1-\beta e_1)\\
 &+\beta e_1(1-z_1)(1-\beta e_0)
\ge (1-\beta)^2>0.
\end{aligned}
\tag{4.3}
\]

Equivalently, \(N=\det(I-\beta Q)\), where row \(i\) of the substochastic matrix \(Q\) is \(e_i(1-z_i,z_i)\). The explicit expansion establishes positivity without a spectral assumption.

By (3.10), \(D\le1\). Thus \(\sigma M_\beta'\ge |r_1|(1-\beta)^2\) almost everywhere. The denominator is bounded away from zero, so (3.9) is locally absolutely continuous. Integration proves (4.1), including across switching points and accumulating waiting times. Continuity and the positive global slope bound imply opposite infinite limits at the two ends of the real line. Therefore \(M_\beta\) is onto and one-to-one. \(\square\)

This is an infinite-state argument. Neither a finite reachable-state list nor an unproved implication from threshold existence to indexability is used.

### 4.2. The boundary parameter and all discounted ties

Define

\[
C_\beta(b)=
\begin{cases}
b,&\sigma(b-s)\ge0,\\[2mm]
\dfrac{b-\beta\tau(b)}{1-\beta},&\sigma(b-s)<0.
\end{cases}
\tag{4.4}
\]

The expressions agree at \(b=s\); the two slopes are 1 and \((1-\beta\rho)/(1-\beta)>0\).

**Lemma 4.2 (activation boundary).** Under subsidy \(M_\beta(c)\), activation is Bellman-optimal at \(b\) exactly when \(\sigma(C_\beta(b)-c)\ge0\). Equality gives a tie between the two actions; either strict inequality determines a unique maximizing action. The active-minus-passive Bellman advantage is strictly monotone in direction \(\sigma\).

**Proof.** Set \(x=\sigma(b-s)\), \(y=\sigma(s-c)\). The stopping candidates are \(f_k=\beta^k(y+\rho^kx)\). If \(x\ge0\),

\[
f_0-f_k=(1-\beta^k)(y+x)+\beta^k(1-\rho^k)x.
\]

Hence immediate activation is optimal exactly when \(y+x\ge0\). At equality, it ties with the zero option, and passivity also has value zero. Strict positivity makes immediate activation strictly better than every delayed or infinite choice; strict negativity makes it strictly worse than passivity.

If \(x<0\), comparison with each \(k\ge1\) requires

\[
y\ge -x\frac{1-(\beta\rho)^k}{1-\beta^k}.
\]

The largest ratio occurs at \(k=1\), because

\[
\frac{1-(\beta\rho)^k}{1-\beta^k}
=\frac{1-\beta\rho}{1-\beta}
\frac{\sum_{j=0}^{k-1}(\beta\rho)^j}{\sum_{j=0}^{k-1}\beta^j}
\le\frac{1-\beta\rho}{1-\beta},
\]

strictly for \(k>1\). The resulting condition is precisely \(\sigma(C_\beta(b)-c)\ge0\). At equality, \(f_0=f_1>0\) and all later candidates are smaller. Thus both Bellman actions tie. On the two strict sides their values are strictly ordered.

For the final assertion, the advantage is \(\mathcal A_c(b)=w_\beta(c)[\sigma(b-c)-\beta F_c(\tau(b))]\). Directional monotonicity and the Lipschitz bound in Lemma 3.2 give, whenever \(b_2>b_1\),

\[
\sigma[\mathcal A_c(b_2)-\mathcal A_c(b_1)]
\ge w_\beta(c)(1-\beta\rho)(b_2-b_1)>0.
\tag{4.4a}
\]

This proves strict monotonicity of the advantage itself. \(\square\)

**Theorem 4.3 (exact indexability and threshold direction).** For \(\delta\ne0\),

\[
\boxed{W_\beta(b)=M_\beta(C_\beta(b)).}
\tag{4.5}
\]

For every belief \(b\) and subsidy \(m\), activation is uniquely optimal if \(m<W_\beta(b)\), both actions tie if \(m=W_\beta(b)\), and passivity is uniquely optimal if \(m>W_\beta(b)\). Consequently,

\[
\mathcal P^w_\beta(m)=\{b:W_\beta(b)\le m\},\qquad
\mathcal P^s_\beta(m)=\{b:W_\beta(b)<m\}.
\tag{4.6}
\]

Both sets expand from empty to all of \([0,1]\). The index is continuous and strictly increasing when \(\delta>0\), and continuous and strictly decreasing when \(\delta<0\). A reverse threshold is optimal in the first case and a forward threshold in the second.

**Proof.** Theorem 4.1 supplies a unique \(c\) for every \(m\). Combining its strict directional order with Lemma 4.2 proves the three action comparisons and (4.5). Strict monotonicity of \(C_\beta\) gives the index orientation. Continuity bounds the index on the compact belief interval, proving the stated extreme passive sets. Threshold selectors attain the value by Proposition 2.1. \(\square\)

### 4.3. Equal slopes and the literal dual-policy exception

**Proposition 4.4 (flat case).** If \(\delta=0\), then

\[
H_{\beta,m}(b)=\frac{(r_0-m)_+}{1-\beta},\qquad W_\beta(b)=r_0.
\tag{4.7}
\]

Below \(r_0\) activation is uniquely optimal everywhere; above it passivity is uniquely optimal everywhere. At equality, every admissible policy is optimal.

**Proof.** The displayed constant solves (3.3) and is unique by contraction. At equality either action satisfies Bellman equality at every belief; the verification proof applies to every randomized history-dependent policy. \(\square\)

For a concrete in-scope example, take

\[
(p_0,p_1,a_0,a_1,\beta,m)
=\left(\frac1{10},\frac12,\frac15,\frac35,\frac12,\frac1{16}\right).
\tag{4.8}
\]

Then \(\rho=\alpha=2/5\), and both Bellman branches equal

\[
V_{\beta,m}(b)=\frac14+\frac54b.
\tag{4.9}
\]

The policy activating exactly on \((3/10,2/5)\) is optimal. It is passive at \(a_0=1/5\), active at \(\tau(a_1)=17/50\), and passive at \(a_1=3/5\), all reachable beliefs. Thus universal exclusion of optimal dual-threshold policies is literally false without excluding indifference. Existence of a single-threshold optimal policy remains true, and Theorem 4.3 rules out such a nondegenerate action pattern when \(\delta\ne0\).

## 5. Exact computation without an infinite-state truncation

**Proposition 5.1 (terminating rational evaluation).** If the model parameters, \(\beta\) and query belief are rational, formula (4.5) is computable by a finite sequence of exact rational operations and comparisons. Infinite passive waiting is decided explicitly.

**Proof.** For fixed \(c,x\), put

\[
M=\max\{0,\sigma(x-c),\sigma(s-c)\}.
\]

Every passive iterate lies between \(x\) and \(s\). If \(M=0\), all candidates in (3.6) are nonpositive, so \(F_c(x)=0\). If \(M>0\), some finite candidate is positive. This remains true when positivity occurs only at the limit endpoint \(s\), by convergence of the finite iterates.

After evaluating \(0\le k<K\), let \(L_K\) be their maximum together with zero. The unevaluated tail is at most \(\beta^KM\). Therefore

\[
L_K\le F_c(x)\le\max\{L_K,\beta^KM\}.
\tag{5.1}
\]

When \(L_K\ge\beta^KM\), the finite maximum is certified exactly. This eventually occurs because a positive candidate appears and the tail bound tends to zero. The quantities in (3.8), (3.9) and (4.4) are then rational, with a positive denominator. \(\square\)

At an index query \(b\), an even shorter evaluator is available. Set \(c=C_\beta(b)\). If \(\sigma(b-s)\ge0\), then

\[
F_c(x)=[\sigma(x-b)]_+.
\tag{5.2}
\]

Otherwise, the first maximizing time from \(x\) is

\[
n(x,b)=\min\{k\ge0:\sigma(\tau^k(x)-b)\ge0\}.
\tag{5.3}
\]

It is finite because the passive fixed point lies strictly on the active side of the boundary. The value is \(\beta^{n(x,b)}\sigma(\tau^{n(x,b)}(x)-c)\). At an equality crossing, the next time ties, but choosing the first time gives the same exact value. These statements follow from Lemma 4.2 applied along the passive orbit.

For error-certified evaluation, stop (5.1) at a prescribed interval width and propagate the head-value intervals through (3.8)–(3.9), intersecting the denominator interval with \([1-\beta\alpha,1]\). This yields a shrinking index interval. The result is a terminating exact rational algorithm, or a controlled-precision evaluator, rather than a claim of a uniform polynomial bit-complexity bound as \(\beta\) tends to one.

**Corollary 5.2 (effective approximation, without a real equality oracle).** If admissible model parameters and a belief are supplied by effective approximation oracles, together with the promise that the stated inequalities hold, the index admits certified approximation to any prescribed positive error. No exact decision of \(\delta=0\) or \(b=s\) is required. This assertion also holds for the finite reset data of Theorem 7.1 when the number of atoms is given and their locations and weights have such oracles.

**Proof.** For a known nonzero sign \(\sigma\), write the boundary continuously as

\[
C_\beta(b)=b+\sigma\frac{\beta(1-\rho)}{1-\beta}
\min\{0,\sigma(b-s)\}.
\tag{5.4}
\]

Thus approximation does not require deciding whether \(b=s\). Interval versions of the finite maxima and geometric tail bound (5.1) approximate each envelope without deciding a maximizing-time tie. A certified upper bound \(\beta<\beta_+<1\) is found after finitely many oracle refinements, because \(\beta<1\) is promised. Denominators have an effective positive lower bound: at least \(1-\beta\) in the general class and at least \(1-\beta\alpha\) in the original model.

To handle a possibly zero \(r_1\), observe that \(|C_\beta(b)|\le1/(1-\beta)\), \(F_c(x)\le1+|c|\), and consequently

\[
|W_\beta(b)-r_0|\le\frac{2|r_1|}{(1-\beta)^2}.
\tag{5.5}
\]

This uses the weaker denominator bound \(1-\beta\) and therefore applies to both classes. Refine the oracle for \(r_1\) until either its sign is certified or the right side of (5.5) is smaller than the requested error after allowing for the approximation of \(r_0\). If \(r_1\ne0\), the first alternative eventually holds; if \(r_1=0\), the second eventually holds. Interval propagation then supplies the requested certificate. Arbitrary real inputs without effective approximation access have mathematical index formulas, not a computational guarantee. \(\square\)

The accompanying exact-arithmetic reproduction checks use rational Bellman substitutions and geometric tail certificates. An independent implementation compares rational index queries with ordinary floating-point value iteration on long passive chains. The latter is a diagnostic with stated residuals and tail estimates; it is not treated as a proof of the infinite-state theorem.

## 6. Average reward, continuous biases and the discount limit

The average-reward statements require an optimality convention. We consider expected long-run average reward against all causal randomized policies. An action is called Bellman-optimal relative to a specified bias when it attains the corresponding average optimality equation. This does not assert an independently defined Blackwell or bias-comparison refinement.

Write

\[
\eta=1-\rho,\qquad \bar r_0=\frac{d_0}{\eta},\qquad
\bar r_1=\frac{\delta}{\eta}.
\tag{6.1}
\]

The original average-reward optimality equation is

\[
g+h(b)=b+\max\{m+h(\tau(b)),\;(1-b)h(a_0)+bh(a_1)\}.
\tag{6.2}
\]

Normalize \(h(s)=0\), and substitute

\[
g=s+m+\gamma,\qquad h(b)=\frac{b-s}{\eta}+u(b),\qquad u(s)=0.
\]

Equation (6.2) becomes

\[
\gamma+u(b)=\max\{u(\tau(b)),\;
\bar r_0+\bar r_1b-m+(1-b)u(a_0)+bu(a_1)\}.
\tag{6.3}
\]

The potential \((b-s)/\eta\) is bounded. Its contribution to a finite-horizon reward sum telescopes, and its contribution per unit time tends to zero. Thus the transformed problem has passive reward zero, active reward \(\bar r_0+\bar r_1b-m\), and optimal gain \(\gamma\ge0\).

### 6.1. Existence and verification on the infinite belief space

**Proposition 6.1 (uniform relative-value bound and average verification).** Let \(\kappa=\max\{\rho,\alpha\}<1\). For every \(\beta,m\),

\[
\operatorname{Lip}(V_{\beta,m})\le\frac1{1-\beta\kappa}
\le\frac1{1-\kappa}.
\tag{6.4}
\]

For each fixed subsidy, equation (6.2) admits a bounded continuous normalized solution. Every such solution has the same gain \(g_m\), which is optimal from every initial belief against all causal randomized policies. A Borel stationary maximizing selector attains this gain. Moreover,

\[
(1-\beta)V_{\beta,m}(b)\longrightarrow g_m
\quad\text{uniformly in }b\in[0,1].
\tag{6.5}
\]

**Proof.** If \(f\) is \(L\)-Lipschitz, the two branches of its discounted Bellman image have Lipschitz constants at most \(1+\beta\rho L\) and \(1+\beta\alpha L\). Their maximum has the common upper bound \(1+\beta\kappa L\). Iterating from zero and summing the geometric series proves (6.4).

The functions \(h_{\beta,m}=V_{\beta,m}-V_{\beta,m}(s)\) are uniformly bounded and equicontinuous. The numbers \(g_{\beta,m}=(1-\beta)V_{\beta,m}(s)\) are bounded for fixed \(m\), since one-stage rewards are bounded. Arzelà–Ascoli and passage to the normalized Bellman equation give a subsequential limit satisfying (6.2).

For any bounded continuous solution \((g,h)\), the Bellman inequality and conditional expectation imply, for every policy,

\[
\mathbb E\sum_{t=0}^{n-1}r_m(b_t,A_t)
\le ng+h(b_0)-\mathbb E h(b_n).
\tag{6.6}
\]

The rightmost two terms divided by \(n\) tend to zero. A maximizing selector is Borel because both branches are continuous, and makes (6.6) an equality. Hence its expected average reward converges to \(g\) from every initial belief, while every policy's limsup is at most \(g\). All such solutions therefore have the same gain. Every convergent subsequence of \(g_{\beta,m}\) has this limit. Finally \((1-\beta)h_{\beta,m}\to0\) uniformly, proving (6.5). \(\square\)

### 6.2. An exhaustive continuous-bias classification

For \(\delta\ne0\), keep \(\sigma=\operatorname{sign}(\delta)\). Define, for \(z>0\),

\[
G_z(x)=\max_{k\ge0}\{\sigma\rho^k(x-s)-kz\},\quad
D_z=1-\sigma[G_z(a_1)-G_z(a_0)],\quad
L_z=\frac{|\bar r_1|}{D_z},
\tag{6.7}
\]

\[
M_+(z)=\bar r_0+L_z[\sigma s+G_z(a_0)-z].
\tag{6.8}
\]

The maximum is finite and attained, since the candidates tend to minus infinity. For \(c\) with \(\sigma(c-s)\ge0\), also define

\[
J_c(x)=[\sigma(x-c)]_+,\quad
D_c^0=1-\sigma[J_c(a_1)-J_c(a_0)],\quad
L_c^0=\frac{|\bar r_1|}{D_c^0},
\tag{6.9}
\]

\[
M_0(c)=\bar r_0+L_c^0[\sigma c+J_c(a_0)],\qquad m_*=M_0(s).
\tag{6.10}
\]

All denominators in (6.7) and (6.9) belong to \([1-\alpha,1]\).

**Theorem 6.2 (all continuous normalized ACOE biases).** Under (2.1), all continuous solutions of (6.3) with \(u(s)=0\) are as follows.

If \(\delta=0\), the unique solution is \(u=0\), \(\gamma=(\bar r_0-m)_+\). If \(\delta\ne0\), the map \(M_+\) is a continuous strictly decreasing bijection from \((0,\infty)\) onto \((-\infty,m_*)\). At \(m=M_+(z)\), the unique solution is

\[
\gamma=L_zz>0,\qquad u=L_zG_z.
\tag{6.11}
\]

At \(m\ge m_*\), the solutions are precisely

\[
\gamma=0,\qquad u=L_c^0J_c,
\qquad \sigma(c-s)\ge0,\quad M_0(c)=m.
\tag{6.12}
\]

The solution is unique except when \(\delta>0\), \(a_0>s\) and

\[
m=m_*=\bar r_0+\frac{\bar r_1a_0}{1-\alpha}.
\tag{6.13}
\]

In this exceptional case, all solutions are

\[
u_c(b)=\frac{\bar r_1}{1-\alpha}(b-c)_+,
\qquad s\le c\le a_0.
\tag{6.14}
\]

For (6.11), the active-minus-passive advantage has the sign of \(\eta\sigma(b-s)+z\); for (6.12), it has the sign of \(\sigma(b-c)\). In the flat case the sign is that of \(\bar r_0-m\).

**Proof.** Write the active affine continuation in (6.3) as

\[
K(b)=A+B(b-s),\qquad B=\bar r_1+u(a_1)-u(a_0).
\]

Unrolling the passive branch for \(n\) steps gives

\[
u(b)=\max\left\{
\max_{0\le k<n}\{K(\tau^k(b))-(k+1)\gamma\},
\ u(\tau^n(b))-n\gamma\right\}.
\tag{6.15}
\]

If \(\gamma>0\), equation (6.3) at \(s\) gives \(A=\gamma\); boundedness sends the last term to minus infinity. Therefore

\[
u(b)=\sup_{k\ge0}\{B\rho^k(b-s)-k\gamma\}.
\tag{6.16}
\]

If \(\gamma=0\), continuity at \(s\) sends the last term to zero and gives \(A\le0\). The affine passive-orbit values lie between their endpoint values, so

\[
u(b)=[A+B(b-s)]_+.
\tag{6.17}
\]

Both representations make \(u\) monotone in the direction of \(B\) and \(|B|\)-Lipschitz. Consequently \(u(a_1)-u(a_0)\) has the same weak sign as \(B\) and magnitude at most \(\alpha|B|\). The defining identity for \(B\) forces \(B=0\) when \(\bar r_1=0\), and otherwise forces its sign to be \(\sigma\). The flat solution follows immediately.

In (6.16), put \(z=\gamma/|B|\). The slope identity forces \(|B|=L_z\), and the constant identity forces \(m=M_+(z)\). Conversely,

\[
G_z(b)=\max\{G_z(\tau(b))-z,\sigma(b-s)\}
\]

verifies (6.11) in (6.3). Similarly, (6.17) must have the form \(|B|J_c\) with \(\sigma(c-s)\ge0\); the two affine coefficient identities give (6.9)–(6.12). These candidates satisfy (6.3), so the representations omit no continuous normalized solution. Their denominator bounds follow from directional monotonicity and the 1-Lipschitz bounds of \(G_z,J_c\).

It remains to determine the multiplicities. Successive candidates in \(G_z(x)\) differ by \(-\eta\sigma\rho^k(x-s)-z\). Thus a first maximizing integer is

\[
n(x;z)=\min\{k\ge0:\sigma\rho^k(x-s)\ge-z/\eta\}.
\tag{6.18}
\]

It is finite. Write \(n_i=n(a_i;z)\), \(t_i=\tau^{n_i}(a_i)\); then \(G_z(a_i)=\sigma(t_i-s)-n_i z\). On each interval with fixed maximizing integers, differentiating (6.8) and canceling the terms in \(z\) gives

\[
M_+'(z)=-\frac{|\bar r_1|}{D_z^2}
\bigl[(n_0+1)(1-t_1)+(n_1+1)t_0\bigr]<0.
\tag{6.19}
\]

The strict sign uses \(0<t_i<1\). Only finitely many maximizing integers occur on a compact subinterval of \((0,\infty)\), and the formulas agree at ties. Hence \(M_+\) is strictly decreasing everywhere. For large \(z\), both integers are zero and \(M_+(z)\to-\infty\). As \(z\downarrow0\), \(G_z(x)\to[\sigma(x-s)]_+\): the latter is an upper bound, and a fixed sufficiently large waiting time supplies the matching lower limit. Thus \(M_+(z)\to m_*\).

For the zero-gain family, set \(t=\sigma(c-s)\ge0\). The map \(M_0\) is continuous, starts at \(m_*\), and tends to infinity as \(t\to\infty\). For \(\sigma=1\), its derivative in \(t=c-s\) is zero when \(s<c<a_0\) if this interval is nonempty, is \(|\bar r_1|(1-a_1)/(1-a_1+c)^2\) when \(a_0<c<a_1\), and is \(|\bar r_1|\) above \(a_1\). For \(\sigma=-1\), its derivative in \(t=s-c\) is \(|\bar r_1|a_0/(1-c+a_0)^2\) when \(a_0<c\le s\), and \(|\bar r_1|\) below \(a_0\). Here \(a_1>p_1>s\), so no negative-orientation plateau is possible. The sole constant interval is therefore (6.13), and substitution gives exactly (6.14).

The action comparisons in this classification are explicit. On the positive-gain branch the active-minus-passive advantage divided by \(L_z\) is

\[
z+\sigma(b-s)-G_z(\tau(b))
=\inf_{j\ge1}\{(1-\rho^j)\sigma(b-s)+jz\}.
\tag{6.20}
\]

Its sign is the sign of \(\eta\sigma(b-s)+z\). At equality, the \(j=1\) term is zero and every later term is positive; below it the first term is negative; above it the infimum is a positive minimum. On the zero-gain branch, putting \(y=\sigma(b-s)\) and \(t=\sigma(c-s)\) gives the scaled advantage

\[
(y-t)-[\rho y-t]_+,
\tag{6.21}
\]

whose sign is exactly that of \(\sigma(b-c)\). Thus every specified continuous bias has a single threshold of Bellman-optimal actions, although distinct biases can have different thresholds at the critical subsidy. The flat-case comparison is immediate from (6.3). \(\square\)

### 6.3. Exact average indices and the pointwise discount limit

Define \(\overline W(b)\) as the subsidy for which there exists a continuous normalized ACOE bias making the two actions tie at \(b\). The next theorem proves that this subsidy exists uniquely and identifies its connection to the discounted index.

**Theorem 6.3 (all-belief average index and discount limit).** For \(\delta=0\), \(\overline W(b)=\bar r_0\). For \(\delta\ne0\) and \(\sigma(b-s)\ge0\), put \(f_i=[\sigma(a_i-b)]_+\). Then

\[
\boxed{\overline W(b)=\bar r_0+|\bar r_1|
\frac{\sigma b+f_0}{1-\sigma(f_1-f_0)}.}
\tag{6.22}
\]

For \(\sigma(b-s)<0\), define the finite integers

\[
n_i=\min\{k\ge0:\sigma(\tau^k(a_i)-b)\ge0\},\qquad
 t_i=\tau^{n_i}(a_i),
\tag{6.23}
\]

and set

\[
N=t_0+\eta(b-s)(n_0+1),\qquad
D=1-t_1+t_0+\eta(b-s)(n_0-n_1).
\]

Then

\[
\boxed{\overline W(b)=\bar r_0+\bar r_1\frac ND,
\qquad D\ge1-\alpha>0.}
\tag{6.24}
\]

For every fixed admissible model and every \(b\in[0,1]\),

\[
\lim_{\beta\uparrow1}W_\beta(b)=\overline W(b).
\tag{6.25}
\]

**Proof.** Equations (6.20)–(6.21) place a tie at \(c=b\) on the zero-gain branch and at \(z=-\eta\sigma(b-s)\) on the positive-gain branch. Theorem 6.2 proves uniqueness of the associated subsidy, including the plateau, where several different values of \(c\) have the same subsidy. Substitution gives (6.22) and (6.24). The first-passage times (6.23) coincide with (6.18); they are finite because \(s\) lies strictly on the opposite side of \(b\) from the inactive region.

For (6.25), the flat case is immediate. On the noncrossing side, (5.2) holds for every \(\beta\), so taking limits in (4.5) gives (6.22). On the crossing side, write

\[
c_\beta=C_\beta(b)=s+\frac{1-\beta\rho}{1-\beta}(b-s).
\]

Successive discounted stopping candidates from \(a_i\) differ by
\(-\beta^k(1-\beta\rho)\sigma(\tau^k(a_i)-b)\). Hence the integers in (6.23) maximize the envelope for every \(\beta\), and \(F_{c_\beta}(a_i)=\beta^{n_i}\sigma(t_i-c_\beta)\). Substitution into (4.5) yields the cancellation identity

\[
W_\beta(b)=r_0+r_1
\frac{c_\beta(1-\beta^{n_0+1})+\beta^{n_0+1}t_0}
{1-\beta(\beta^{n_1}t_1-\beta^{n_0}t_0)
 +\beta c_\beta(\beta^{n_1}-\beta^{n_0})}.
\tag{6.26}
\]

Here \(r_0,r_1\) retain their discounted definitions (3.2). Using \((1-\beta^n)/(1-\beta)\to n\) in this expression gives exactly \(N,D\). The denominator is \(D_\beta(c_\beta)\ge1-\beta\alpha\); its limit proves the lower bound in (6.24). Thus all apparently divergent terms cancel before the limit is taken. \(\square\)

### 6.4. Canonical bias selection and the exceptional tie semantics

**Theorem 6.4 (full relative-value limit and canonical indexability).** For every real subsidy,

\[
V_{\beta,m}(b)-V_{\beta,m}(s)
\longrightarrow h_m^{\mathrm{vd}}(b)
=\frac{b-s}{\eta}+u_m^{\mathrm{vd}}(b)
\quad\text{uniformly in }b.
\tag{6.27}
\]

The transformed canonical bias \(u_m^{\mathrm{vd}}\) is the unique solution in Theorem 6.2 except in (6.13), where

\[
u_{m_*}^{\mathrm{vd}}(b)
=\frac{\bar r_1}{1-\alpha}(b-a_0)_+.
\tag{6.28}
\]

The weak passive set of its ACOE is \(\{b:\overline W(b)\le m\}\). Its strict passive set is \(\{b:\overline W(b)<m\}\), except at (6.13), where it is

\[
\{b:\overline W(b)<m_*\}\ \cup\ [s,a_0).
\tag{6.29}
\]

Both canonical passive sets expand monotonically from empty to full, and their infimum passivity subsidies are \(\overline W\).

**Proof.** Proposition 6.1 makes every sequence of relative values precompact. Outside (6.13), Theorem 6.2 gives only one possible normalized limit, so the full sequence converges. In the exceptional case, the exact discounted formula at \(a_0\) gives

\[
W_\beta(a_0)=r_0+\frac{r_1a_0}{1-\beta\alpha}<m_*.
\tag{6.30}
\]

Both terms increase strictly to their average counterparts, since their coefficients are positive. At subsidy \(m_*\), passivity is therefore strictly discounted-optimal at \(a_0\) for every \(\beta<1\), and remains weakly optimal in any subsequential ACOE limit. Among (6.14), the active advantage at \(a_0\) is strictly positive if \(c<a_0\), and zero only if \(c=a_0\). Thus (6.28) is the only possible limit, proving full convergence there as well.

For \(\delta=0\), the passive-set statements follow directly from the flat case of Theorem 6.2. Assume \(\delta\ne0\) for the remaining comparisons. For \(m<m_*\), the signed tie threshold is \(\sigma(b_m-s)=-z/\eta\), which increases with the subsidy by strict decrease of \(M_+\). For \(m\ge m_*\), the signed threshold \(\sigma(c-s)\) also increases, by the order of \(M_0\). At (6.13) the canonical threshold jumps from its left limit \(s\) to \(a_0\). Equations (6.20)–(6.24) now give the stated weak and strict sets, including (6.29). Their extreme limits are constant policies. \(\square\)

**Proposition 6.5 (indifference across biases and the gain-only distinction).** For any belief \(b\), if \(m<\overline W(b)\), activation is strict for every continuous normalized ACOE bias; if \(m>\overline W(b)\), passivity is strict for every such bias; at equality at least one such bias makes the actions tie. At the exceptional subsidy (6.13), for \(b\in[s,a_0)\), canonical passivity is already strict when \(m=\overline W(b)\), and no subsidy gives a canonical ACOE tie at that belief. In contrast, either action can be the first action of a gain-optimal causal policy at every belief and every subsidy.

**Proof.** The first assertions follow from the exhaustive classification, its action signs and the parameter orders. At the critical plateau choose \(c=b\) for a tie; other admissible biases can give a strict preference. The canonical threshold jumps to \(a_0\), so beliefs in \([s,a_0)\) change directly from strict activation to strict passivity without a canonical tie.

For the last assertion, start with either action and then use a stationary selector attaining (6.2). Equation (6.6) with equality bounds the continuation's reward error relative to \(ng_m\) uniformly in its random initial belief. A finite reward prefix and a bounded terminal bias do not change the limiting average. Thus the resulting causal policy is gain-optimal. \(\square\)

Replacing bias-relative Bellman actions by this gain-only criterion would therefore make an average Whittle index meaningless. The general transient-state distinction is already present in [R3] and [R5]; here its exact consequences are given by (6.13)–(6.14), (6.28)–(6.29) and Proposition 6.5.

**Example 6.6 (an exact canonical strict-passivity plateau).** Take

\[
(p_0,p_1,a_0,a_1)=\left(\frac1{10},\frac15,\frac15,\frac12\right).
\]

Then \(s=1/9\), \(\bar r_0=1/9\), \(\bar r_1=2/9\), and

\[
m_*=\frac{11}{63},\qquad
\overline W(b)=\frac{11}{63}\quad(1/9\le b\le1/5).
\tag{6.31}
\]

All transformed normalized biases at this subsidy are \(u_c(b)=(20/63)(b-c)_+\), \(c\in[1/9,1/5]\). Vanishing discount selects \(c=1/5\). At \(b=3/20\), its active-minus-passive advantage is exactly \(-1/63\), although the subsidy equals the index. Choosing the equally valid bias with \(c=3/20\) instead gives a tie. This is an exact rational phenomenon on the full belief interval.


## 7. Arbitrary finite affine reset laws

The discounted determinant does not require activation to have only two possible next beliefs. Fixed reset points with affine observation probabilities already appear in [R2, Section 5.1, equation (10)]. Theorem 7.1 supplies an unrestricted discounted structural result on this existing model class, allowing arbitrary finite supports without stochastic ordering.

**Theorem 7.1 (finite affine-reset indexability).** Let \(b\in[0,1]\), \(0<\beta<1\), \(0\le\rho<1\), and \(0\le s\le1\). Passivity earns zero and moves to \(\tau(b)=s+\rho(b-s)\). Activation earns \(r_0+r_1b-m\) and draws its next state from

\[
K_b=(1-b)\mu_0+b\mu_1,
\tag{7.1}
\]

where \(\mu_0,\mu_1\) are arbitrary probability measures with finite support in \([0,1]\). For \(r_1\ne0\), set \(\sigma=\operatorname{sign}(r_1)\) and define \(F_c\) by (3.6). Write

\[
G_i(c)=\int F_c(x)\,\mu_i(dx),\quad
D(c)=1-\beta\sigma[G_1(c)-G_0(c)],
\tag{7.2}
\]

\[
w(c)=\frac{|r_1|}{D(c)},\qquad
M(c)=r_0+w(c)[\sigma c+\beta G_0(c)].
\tag{7.3}
\]

Then \(H_{M(c)}=w(c)F_c\) is the unique bounded discounted value. The map \(M\) is a continuous strictly \(\sigma\)-monotone bijection, and the exact index is \(W_\beta(b)=M(C_\beta(b))\), with \(C_\beta\) defined by (4.4). The action classification and the weak and strict passive sets are exactly those in Theorem 4.3. If \(r_1=0\), the constant index is \(r_0\).

**Proof.** The range of a 1-Lipschitz function on \([0,1]\) has diameter at most one. Thus

\[
|G_1-G_0|\le1,\qquad 1-\beta\le D\le1+\beta.
\tag{7.4}
\]

The substitution in Proposition 3.3 applies unchanged, replacing the two head values by their expectations. It remains to prove that the subsidy map has the required order.

Outside the union of the atom-wise differentiability exceptions, choose a maximizing finite time at each atom whose envelope value is positive. Set \(e(x)=\beta^{k(x)}\), \(z(x)=\tau^{k(x)}(x)\); take \(e(x)=0\) when the envelope value is zero. Put

\[
e_i=\int e(x)\,\mu_i(dx),\qquad
v_i=\int e(x)z(x)\,\mu_i(dx).
\]

Since there are finitely many atoms, differentiation and finite summation give

\[
G_i=\sigma(v_i-ce_i),\qquad G_i'=-\sigma e_i,
\qquad 0\le v_i\le e_i\le1.
\]

Differentiating (7.3),

\[
\frac{\sigma M'(c)}{|r_1|}
=\frac{1-\beta(e_0-v_0+v_1)+\beta^2(e_0v_1-e_1v_0)}{D^2}.
\tag{7.5}
\]

If \(e_i>0\), set \(z_i=v_i/e_i\); otherwise set \(z_i=0\). The numerator is exactly the positive expression in (4.3). Combining this fact with (7.4) yields

\[
\sigma M'(c)\ge |r_1|\frac{(1-\beta)^2}{(1+\beta)^2}>0
\quad\text{almost everywhere}.
\]

Local absolute continuity, integration and the positive global lower bound prove strict monotonicity and surjectivity. The boundary comparison in Lemma 4.2 depends only on the passive orbit and the affine active term, so it supplies the index and all ties. The case \(r_1=0\) follows by substituting the constant value \((r_0-m)_+/(1-\beta)\). \(\square\)

No stochastic-order relation between \(\mu_0\) and \(\mu_1\) was assumed. If one is available, the denominator bound can improve. In particular, if \(\mu_0\) is stochastically dominated by \(\mu_1\), a monotone coupling and the Lipschitz property give

\[
0\le\sigma(G_1-G_0)\le
\int x\,\mu_1(dx)-\int x\,\mu_0(dx)=:\alpha_\mu.
\tag{7.6}
\]

Thus \(D\ge1-\beta\alpha_\mu\). Without ordering, any coupling bounds \(|G_1-G_0|\) by its mean transport distance. These observations are denominator estimates, not an additional average-reward theorem for the larger class.

For rational finite supports and rational weights, evaluating \(F_c\) at each atom by Proposition 5.1 makes the entire index computation exact. The case \(\rho=0\) is included: the envelope on the noncrossing side remains (5.2), while on the crossing side the first hit is finite because the next passive state is exactly \(s\). A passive orbit can hit a tie at \(s=b\) after one step; no claim that every such waiting time is infinite is needed. The extension covers fixed reset distributions with affine observation probabilities. It does not cover a general Bayesian posterior reset whose location depends on the incoming belief. That dependence would destroy the affine active continuation used in the proof.

## 8. Scope and reproducibility

All discounted statements preserve the original observation timing and compare against arbitrary causal randomized policies. The original model is treated on a continuous belief interval and its actual countable reachable subset. Average statements distinguish an optimal gain from a chosen solution of the bias equation; the two notions cannot be interchanged at transient states or critical subsidies.

The argument does not address arbitrary three-state latent models, negative passive persistence, nonlinear belief rewards, belief-dependent posterior reset locations, or time-dependent finite-horizon policies. Indexability of a relaxed arm does not itself establish optimality or asymptotic optimality of a constrained multi-arm allocation rule; such conclusions require separate assumptions and analysis.

The accompanying code uses exact rational arithmetic for its index formulas and finite certificates. Separate floating-point Bellman diagnostics are labeled as such. The manuscript's proofs are mathematical arguments, and the future formalization must cover their full stated scope, including ties, infinite waiting, positive denominators and average-reward qualifications. No formal proof code or external peer-review certification is claimed here.

## References

**[R1]** Aditya Mate, Jackson A. Killian, Haifeng Xu, Andrew Perrault and Milind Tambe. *Collapsing Bandits and Their Application to Public Health Interventions*. Advances in Neural Information Processing Systems 33, 2020. [Primary paper](https://proceedings.neurips.cc/paper/2020/file/b460cf6b09878b00a3e1ad4c72344ccd-Paper.pdf); [arXiv:2007.04432](https://arxiv.org/abs/2007.04432).

**[R2]** Aditya Mate, Andrew Perrault and Milind Tambe. *Risk-Aware Interventions in Public Health: Planning with Restless Multi-Armed Bandits*. Proceedings of AAMAS 2021, pp. 880–888. [Primary paper](https://ifaamas.csc.liv.ac.uk/Proceedings/aamas2021/pdfs/p880.pdf).

**[R3]** Keqin Liu, Richard Weber and Qing Zhao. *Indexability and Whittle Index for Restless Bandit Problems Involving Reset Processes*. Proceedings of the 50th IEEE Conference on Decision and Control and European Control Conference, 2011, pp. 7690–7696. [DOI:10.1109/CDC.2011.6160533](https://doi.org/10.1109/CDC.2011.6160533); [primary proceedings PDF](https://skoge.folk.ntnu.no/prost/proceedings/cdc-ecc-2011/data/papers/0640.pdf).

**[R4]** Nima Akbarzadeh and Aditya Mahajan. *Two families of indexable partially observable restless bandits and Whittle index computation*. Performance Evaluation, 2024. [DOI:10.1016/j.peva.2023.102394](https://doi.org/10.1016/j.peva.2023.102394); [author-hosted full text](https://adityam.github.io/files/projects/bandits/journal/pomdp-bandits.pdf).

**[R5]** José Niño-Mora and Ángel Pellitero García. *A belief-state restless bandit model for treatment adherence: Whittle indexability via partial conservation laws*. Mathematical Methods of Operations Research, 2026. [DOI:10.1007/s00186-026-00943-5](https://doi.org/10.1007/s00186-026-00943-5); [arXiv:2601.06976](https://arxiv.org/abs/2601.06976).

**[R6]** Anu Krishna, Rahul Meshram and Kesav Ram Kaza. *Optimal Threshold Type Policies for Partially Observable Restless Bandits*. 2026. [arXiv:2609.13886](https://arxiv.org/abs/2609.13886). Primary indexed full text inspected; immutable arXiv revision identifier not independently pinned.

**[R7]** Rahul Meshram, Anu Krishna and Kesav Ram Kaza. *Whittle Index Policy for Three State Collapsing Bandits*. 2026. [arXiv:2610.36733](https://arxiv.org/abs/2610.36733). Primary indexed full text inspected; immutable arXiv revision identifier not independently pinned.

**[R8]** Qizhen Jia and Keqin Liu. *From Relaxed Indexability to Exact Indexability: A t-Step Approach for Partially Observable Restless Bandits*. 2026. [arXiv:2608.24167](https://arxiv.org/abs/2608.24167). Primary indexed full text inspected; immutable arXiv revision identifier not independently pinned.

**[R9]** José Niño-Mora. *Threshold-indexability of restless bandits with real interval state spaces: a performance-metric verification framework and long-run average analysis*. 2026. [arXiv:2607.22557](https://arxiv.org/abs/2607.22557). Primary indexed full text inspected; immutable arXiv revision identifier not independently pinned.
