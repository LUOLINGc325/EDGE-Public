# Sharp privacy conversion for finite bandit transcripts and fixed adaptive prefixes

**AI-assisted research preprint · Integrated mathematical version: 25 November 2026 · Not peer-reviewed.** The paper gives written proofs of its stated results. A separately assessed Lean supplement verifies the mathematical scope of Theorems A–C and their supporting claims; its precise coverage and execution records are described in Appendix A.

## Abstract

A finite-horizon bandit policy can protect every fixed reward stream while disclosing more information when its rewards are selected from a table by its own public actions. We determine the exact conversion between these two privacy requirements when the multiplicative privacy factor is held fixed. For $K\ge2$ actions, $T\ge2$ released actions, factor $\lambda\ge1$, and fixed-stream error $\delta\in[0,1]$, the least universal table error with arbitrary real rewards is $\min\{1,K^{T-1}\delta\}$. A finite-code policy attains this bound for every parameter value and protects even arbitrary pairs of fixed streams. The exponent $T-1$ follows from the order of interaction: the final reward arrives after the final disclosed action.

The reward alphabet changes the extremal conversion. For binary rewards, the exact error is
$$
\min\left\{1,\;2^{T-1}\delta,\;
\frac{\lambda-1+2^{T-1}\delta}{\lambda+1}\right\},
$$
independently of $K$ once $K\ge2$. Its upper bound combines a causal partition with a normalization constraint relating the two directed hockey-stick divergences. At $\lambda=1$, a reward alphabet of cardinality $q\ge2$ has exact error
$$
\min\{1,\;\min(K,q/2)\min(K,q)^{T-2}\delta\}.
$$
A crosspolytope construction with a noncentral singleton block attains the finite-alphabet bound, including odd $q$. These results distinguish action branching, alphabet size, and directional privacy slack. They concern the original fixed-table bandit interface at the same input and output factor; Sections 8–9 separately give a fixed adaptive-prefix computation for any target factor and a counterexample to using one set of prefix weights.

**Keywords:** differential privacy; bandit feedback; privacy conversion; hockey-stick divergence; total variation; finite alphabets.

## 1. Introduction

### 1.1. The conversion question

In a bandit interaction, an algorithm chooses an action and then receives a reward for that action. Privacy of the disclosed action sequence depends on how rewards enter the interaction. In the **View** experiment, the entire reward stream is fixed in advance. In the **Table** experiment, each individual supplies a row of potential rewards, one for every action, and the algorithm receives the entry indexed by its current action. The table is fixed in advance, but the realized reward stream depends on the disclosed actions.

Azize and Basu formalized this distinction and proved both a pure-DP equivalence and an approximate-DP conversion with additive allowance $K^T\delta$, where $K$ is the number of actions and $T$ is the horizon [AB24, Definition 3 and Proposition 1]. Their Appendix B-A contains a separating example, and the discussion following Proposition 1 asks for the best privacy-loss conversion. The question is also recorded in Azize's dissertation [A24, Chapter 9].

We study the exact additive allowance when the multiplicative factor is preserved. Write $\lambda=e^\varepsilon$. For a fixed reward space, the problem is to maximize the Table hockey-stick divergence at factor $\lambda$ over all causal policies satisfying View privacy at $(\lambda,\delta)$, and over all neighboring fixed tables. Both the policy class and the neighboring input pairs are unrestricted within this interface. In particular, a lower bound requires an actual causal policy whose privacy holds for every neighboring fixed stream, including changes to any reward used to control a disclosure gate.

### 1.2. Results and proof structure

Theorems A–C give three exact envelopes. With real rewards, the additive allowance is $\min\{1,K^{T-1}\delta\}$. With binary rewards, an additional relation between the two directed divergences produces a piecewise affine envelope independent of the number of actions. For an arbitrary finite alphabet at $\lambda=1$, the sensitive row contributes $\min(K,q/2)$, and each of the other $T-2$ influential rows contributes $\min(K,q)$.

The common upper-bound argument uses a pathwise identity: the probability of a table transcript equals the probability of the same transcript under the fixed reward stream that this path realizes. Grouping by the first $T-1$ actions gives the real-reward upper bound. For binary rewards, grouping instead by the common rewards outside the changed row controls the sum of both directed divergences. At $\lambda=1$, a finite $L^1$ selection inequality yields the alphabet-sensitive bound.

The constructions delay all reward-dependent behavior until the final action. Before that action, the policy samples independent public exploration actions and stores the received rewards. Fixed streams can activate only one exploration context, while a fixed table can match every realized context. The privacy calculation includes changes that deactivate one context and activate another. The finite-alphabet construction also specifies its terminal kernels at histories of probability zero, so it defines a policy on the entire history space.

Section 2 gives the model and precise theorem statements. Section 3 proves the common identities and the universal upper bound. Sections 4, 5, and 6 prove Theorems A, B, and C, respectively. Section 7 records consequences. Sections 8–9 solve the fixed adaptive-prefix optimization and separate it from the reward-independent prefix model. Appendix A describes the archived verification. Appendices B–E give the fixed-exploration utility bridge, a finite alphabet slice at positive privacy parameter, the sharp time exponent with regret control, and robustness within a fixed exploration law.

### 1.3. Relation to earlier work and scope

The comparison between nonadaptive and adaptive privacy extends beyond bandits. Denisov, McMahan, Rush, Smith, and Thakurta prove a pure-privacy transfer and study Gaussian matrix mechanisms [DMR+22, Proposition 2.1 and Theorem 2.1]. Their Appendix D.1 gives an additive-noise separation in which the second noise is conditionally Gaussian and its covariance depends on the first noise. The main Gaussian matrix-mechanism theorem and this conditional-noise example have different hypotheses.

Random challenges followed by disclosure on a matching input are established construction ingredients. Bun, Gaboardi, and Wagaman discuss such a mechanism in their comparison of oblivious and adaptive continual observation [BGW26, Section 1.3]; Henzinger, Safavi, and Vadhan also describe the ingredient [HSV26, p. 2, footnote 1]. The constructions below use this known idea. The contribution under study is the exact finite-parameter conversion in the specified bandit interface, including calibrated all-stream privacy and the binary and finite-alphabet classifications.

The later bandit work of Azize, Wu, Honda, Orabona, Ito, and Basu compares several privacy definitions and establishes pure-privacy equivalences [AWH+25, Appendix B]. The inspected version does not provide the approximate envelopes proved here. The comparison is limited to the versions and source locations recorded in the references and accompanying source ledger; it does not establish global priority.

The universal envelopes in Sections 2–7 preserve the multiplicative factor. Section 8 allows arbitrary output factors for a fixed causal prefix. The table selects its entries through the current action from rows fixed in advance. The utility guarantees in Appendices B and D use their own exploration and payoff assumptions.

## 2. Model and main results

### 2.1. Causal policies, streams, and tables

Let $\mathcal A$ be a finite action set with $|\mathcal A|=K\ge2$, let $\mathcal R$ be a nonempty reward space, and fix $T\ge2$. Throughout, write
$$
h=T-1.
$$
A causal policy consists of probability kernels
$$
\pi_t(a_t\mid a_1,r_1,\ldots,a_{t-1},r_{t-1}),
\qquad 1\le t\le T.
$$
Each kernel is a probability law on $\mathcal A$ for every history, including histories that occur with probability zero. At round $t$, action $A_t$ is sampled and disclosed before reward $r_t$ is received. The released output is the full transcript $X=(A_1,\ldots,A_T)$.

For $\mathcal R=\mathbb R$, we require the kernels to be Borel measurable in the reward coordinates. The upper bounds use only finite path probabilities and apply even to the larger class obtained by omitting this measurability requirement. Every real-reward policy constructed below has Borel-measurable kernels. For finite alphabets, use the discrete measurable structure.

For a fixed stream $r=(r_1,\ldots,r_T)\in\mathcal R^T$, its transcript law is
$$
V_r^\pi(a_1,\ldots,a_T)
=\prod_{t=1}^T
\pi_t(a_t\mid a_1,r_1,\ldots,a_{t-1},r_{t-1}).
\tag{2.1}
$$
A fixed table is a sequence $d=(d_1,\ldots,d_T)$, where
$d_t:\mathcal A\to\mathcal R$. Its transcript law is
$$
M_d^\pi(a_1,\ldots,a_T)
=\prod_{t=1}^T
\pi_t(a_t\mid a_1,d_1(a_1),\ldots,
                     a_{t-1},d_{t-1}(a_{t-1})).
\tag{2.2}
$$
Finite iteration of normalized kernels shows that these are probability laws. The final reward and final table row are absent from the products: neither can influence an already disclosed action. We retain them in the input spaces to match the original $T$-round interface, but only the first $h$ rewards are influential.

Two streams are neighbors, written $r\sim s$, if they differ in at most one coordinate. Two tables are neighbors, written $d\sim e$, if they differ in at most one whole row. Equality is included. For $\lambda\ge1$ and nonnegative additive error, this convention is equivalent to restricting privacy to distinct neighbors, because identical input laws automatically satisfy the inequality.

### 2.2. Privacy and the extremal envelope

For probability laws $P,Q$ on a finite set, define
$$
H_\lambda(P,Q)=\sum_x[P(x)-\lambda Q(x)]_+,
\qquad [z]_+=\max\{z,0\},
\qquad \lambda\ge1.
\tag{2.3}
$$
A policy is **View-$(\lambda,\delta)$ private** if
$H_\lambda(V_r^\pi,V_s^\pi)\le\delta$ for every ordered neighboring stream pair. It is **Table-$(\lambda,\Delta)$ private** if
$H_\lambda(M_d^\pi,M_e^\pi)\le\Delta$ for every ordered neighboring table pair. Ordered quantification imposes both directed inequalities. Lemma 3.1 identifies this definition with the usual all-event approximate-DP requirement.

For a fixed reward space, let
$$
\mathcal E_{\mathcal R}(K,T,\lambda,\delta)
=\sup_{\pi:\,\mathrm{ViewDP}(\lambda,\delta)}
  \ \sup_{d\sim e}H_\lambda(M_d^\pi,M_e^\pi).
\tag{2.4}
$$
The inner supremum is over ordered pairs. Thus $\mathcal E_{\mathcal R}$ is precisely the smallest universal additive Table allowance at the same factor. The upper bounds below hold for every policy in the indicated class. Matching constructions attain the displayed values for every parameter tuple, so no limit over policies is needed.

### 2.3. Three sharp conversion theorems

**Theorem A (arbitrary real rewards).** For every $K\ge2$, $T\ge2$, $\lambda\ge1$, and $\delta\in[0,1]$,
$$
\boxed{\mathcal E_{\mathbb R}(K,T,\lambda,\delta)
       =\min\{1,K^h\delta\}.}
\tag{A}
$$
The attaining policy uses only $2K$ distinct real reward symbols. For any prescribed $j\in\{1,\ldots,h\}$, its witness tables can differ only at row $j$. Moreover, the policy satisfies the View bound for every pair of fixed streams, whether neighboring or not.

**Theorem B (binary rewards).** For the same parameter range,
$$
\boxed{\mathcal E_{\{0,1\}}(K,T,\lambda,\delta)
 =B_{T,\lambda}(\delta)
 :=\min\left\{1,\;2^h\delta,\;
       \frac{\lambda-1+2^h\delta}{\lambda+1}\right\}.}
\tag{B}
$$
The attaining policy uses two actions; additional actions have probability zero. It also satisfies the stronger privacy requirement for all pairs of fixed binary streams.

**Theorem C (finite alphabets at factor one).** If $|\mathcal R|=q\ge2$, then for every $K\ge2$, $T\ge2$, and $\delta\in[0,1]$,
$$
\boxed{\mathcal E_{\mathcal R}(K,T,1,\delta)
 =\min\{1,\;\min(K,q/2)\min(K,q)^{h-1}\delta\}.}
\tag{C}
$$
Here $q/2$ is a real number, with no rounding. For every prescribed $j\le h$, an attaining pair of tables differs only at row $j$. The policy uses $q_0=\min(q,2K)$ active sensitive symbols, assigns any remaining symbols a baseline behavior, and protects all pairs of fixed streams.

At factor one, $H_1$ equals total variation:
$$
\operatorname{TV}(P,Q)=\frac12\sum_x|P(x)-Q(x)|.
\tag{2.5}
$$
Indeed, the coordinates of $P-Q$ sum to zero, so its positive and negative masses are equal. Equation (2.5) makes Theorem C a total-variation classification.

## 3. Finite privacy identities and the universal upper bound

### 3.1. Events and positive parts

**Lemma 3.1 (event formulation and cap).** For arbitrary real vectors $p,q$ on a finite set and any real $\lambda$,
$$
\max_E\left\{\sum_{x\in E}p_x-\lambda\sum_{x\in E}q_x\right\}
=\sum_x[p_x-\lambda q_x]_+.
\tag{3.1}
$$
For normalized nonnegative $p,q$ and $\lambda\ge0$, this quantity lies in $[0,1]$.

*Proof.* For any event $E$, replace each selected summand by its positive part, then include the remaining nonnegative summands. This gives the upper bound in (3.1). Equality is attained by
$E=\{x:p_x-\lambda q_x>0\}$. For nonnegative $q$ and $\lambda\ge0$,
$[p_x-\lambda q_x]_+\le p_x$, so summing yields the cap of one. Nonnegativity follows from the definition. $\square$

The cap uses normalized full laws. The restricted sums in later arguments are not treated as normalized conditional laws.

### 3.2. The pathwise identity

For an action prefix $u=(a_1,\ldots,a_h)$, define its realized active reward stream under $d$ by
$$
f_d(u)=(d_1(a_1),\ldots,d_h(a_h)).
$$
When writing $V_{f_d(u)}$, append an arbitrary common final reward; its value is immaterial.

**Lemma 3.2 (pathwise table identity).** For every complete transcript $x=(u,b)$,
$$
M_d(u,b)=V_{f_d(u)}(u,b).
\tag{3.2}
$$

*Proof.* The transcript probability is the product of its successive action-kernel probabilities. Along the particular path $(u,b)$, the table supplies exactly the rewards $f_d(u)$. Every factor in (2.2) therefore agrees with the corresponding factor in (2.1). Equivalently, induction over the $h$ feedback-bearing levels proves the identity, allowing arbitrary dependence on the observed history and zero transition probabilities. $\square$

If $d\sim e$, the streams $f_d(u)$ and $f_e(u)$ differ in at most the changed coordinate for every $u$. Their dependence on $u$ is permitted in the identity and is the source of the conversion loss.

### 3.3. Grouping by the influential action prefix

**Proposition 3.3 (universal prefix bound).** Every View-$(\lambda,\delta)$ private policy satisfies
$$
H_\lambda(M_d,M_e)\le \min\{1,K^h\delta\}
$$
for every ordered neighboring table pair.

*Proof.* Group the divergence by the first $h$ actions, leaving the final action inside each group. Lemma 3.2 gives
$$
\begin{aligned}
H_\lambda(M_d,M_e)
&=\sum_{u\in\mathcal A^h}\sum_{b\in\mathcal A}
 [V_{f_d(u)}(u,b)-\lambda V_{f_e(u)}(u,b)]_+\\
&\le\sum_{u\in\mathcal A^h}
 H_\lambda(V_{f_d(u)},V_{f_e(u)})\\
&\le\sum_{u\in\mathcal A^h}\delta
 =K^h\delta.
\end{aligned}
\tag{3.3}
$$
For each $u$, the first inequality enlarges a restricted sum of nonnegative defects to the full transcript space. The two selected fixed streams are neighbors, so View privacy gives the second inequality. Lemma 3.1 supplies the cap of one. $\square$

This argument never conditions on a prefix or divides by its probability. Such conditioning would require a separate privacy argument. The final action remains inside the fiber because the reward received after that action has no effect on the transcript. This is why the exponent is $h=T-1$. Proposition 3.3 proves the upper half of Theorem A.


## 4. Proof of Theorem A: a calibrated real-reward construction

Fix $K,T,\lambda,\delta$ in the range of Theorem A and a designated changed row $j\in\{1,\ldots,h\}$. Relabel the action set as $\mathcal A=\{0,\ldots,K-1\}$, and put
$$
M=K^h,\qquad
\eta=\min\{M\delta,1\},\qquad
c=\frac{\lambda-1}{2},\qquad
a=\frac{\eta+c}{\lambda+1}.
\tag{4.1}
$$
Then $0\le\eta\le1$, $c\ge0$, and $0\le a\le1/2$. The upper bound on $a$ follows from
$\eta+c\le1+c=(\lambda+1)/2$. The identity
$$
(\lambda+1)a-c=\eta
\tag{4.2}
$$
will calibrate the terminal privacy loss. All definitions are valid at the endpoints, including $\delta=0$ and $\eta=1$.

### 4.1. A family of sparse terminal perturbations

On terminal outputs $0,1$, with coordinates in that order, let
$$
B_0=(1/2,1/2),\qquad
B_+=(1/2+a,1/2-a),\qquad
B_-=(1/2-a,1/2+a).
\tag{4.3}
$$
Let $\mathcal Z$ be a set of cardinality $M$. A baseline law $P_\bot$ on $\mathcal Z\times\{0,1\}$ has a uniform first marginal and terminal law $B_0$ at every $z$. For $z_*\in\mathcal Z$ and $s\in\{+,-\}$, let $P_{z_*,s}$ have the same uniform first marginal, terminal law $B_s$ at $z_*$, and terminal law $B_0$ elsewhere.

**Lemma 4.1 (terminal-channel defects).** Set
$u=(a-c)_+$ and $v=(\lambda a-c)_+$. Then
$$
H_\lambda(B_+,B_-)=H_\lambda(B_-,B_+)=\eta,
\tag{4.4}
$$
$$
H_\lambda(B_s,B_0)=u,\qquad
H_\lambda(B_0,B_s)=v
\quad(s\in\{+,-\}),
\tag{4.5}
$$
and
$$
u+v\le\eta.
\tag{4.6}
$$

*Proof.* For the first ordered pair in (4.4), the signed coordinate differences are
$(\lambda+1)a-c=\eta$ and $-(\lambda+1)a-c\le0$; the reverse pair exchanges their positions. For (4.5), the differences are $a-c,-a-c$ in the active-to-baseline direction and $\lambda a-c,-\lambda a-c$ in the reverse direction, again with positions exchanged for the other sign. Identical laws have defect zero because $(1-\lambda)p\le0$ coordinatewise.

To prove (4.6), account for every possible positive-part case. If both $u,v$ vanish, use $\eta\ge0$. If only $u$ is positive, then $\eta-u=\lambda a\ge0$. If only $v$ is positive, then $\eta-v=a\ge0$. If both are positive, then
$u+v=(\lambda+1)a-2c=\eta-c\le\eta$.
Zero arguments of either positive part are included in these cases. $\square$

**Lemma 4.2 (privacy of every pair of sparse laws).** For all ordered pairs $P,Q$ in
$$
\{P_\bot\}\cup
 \{P_{z,s}:z\in\mathcal Z,\ s\in\{+,-\}\},
$$
one has
$$
H_\lambda(P,Q)\le\frac{\eta}{M}.
\tag{4.7}
$$

*Proof.* Positive parts scale by the nonnegative factor $1/M$. Two baseline laws give zero. If exactly one law has an active location, the defect is $u/M$ or $v/M$, each bounded by $\eta/M$ using (4.6). If both active locations agree, equal signs give zero and opposite signs give $\eta/M$ by (4.4). If their active locations differ, one contributes $u/M$, the other contributes $v/M$, independently of the signs. All other locations contribute zero, and (4.6) applies. $\square$

Opposite signs at the same active location attain (4.7). The different-location case is necessary: a change in a reward used as a matching label can move the active location.

### 4.2. Implementation on the entire real reward space

Use the codebook
$$
\mathcal C=\{0,1,\ldots,2K-1\}\subset\mathbb R,
\qquad x=2i+b,\quad i\in\mathcal A,\ b\in\{0,1\}.
$$
Every $x\in\mathcal C$ has a unique decoded label $i$ and parity $b$. Every real number outside $\mathcal C$ is invalid. Only the parity at coordinate $j$ affects the terminal sign; both parities are allowed at other coordinates.

At each round $t\le h$, independently sample $A_t$ uniformly from $\mathcal A$, irrespective of the rewards already observed. At time $T=h+1$, the policy has received all $r_1,\ldots,r_h$. For an observed action prefix $z\in\mathcal A^h$, set
$$
\Pr(A_T=0\mid A_{1:h}=z,r_{1:h})=
\begin{cases}
1/2+a,
 &\text{if every }r_t=2z_t+b_t\in\mathcal C
    \text{ and }b_j=1,\\
1/2-a,
 &\text{if every }r_t=2z_t+b_t\in\mathcal C
    \text{ and }b_j=0,\\
1/2,&\text{otherwise}.
\end{cases}
\tag{4.8}
$$
Action 1 has the complementary probability, and terminal actions $2,\ldots,K-1$, if present, have probability zero. Earlier actions still use all $K$ labels. Equation (4.8) specifies a normalized terminal kernel at every history.

For a fixed real stream, at most one action prefix matches all decoded labels. If an active reward is invalid, there is no matching prefix. Its transcript law is therefore exactly one of the laws in Lemma 4.2, with $\mathcal Z=\mathcal A^h$, embedded into $\mathcal A^T$ by assigning zero mass to unused terminal actions. The final reward $r_T$ is ignored. The reward tests in (4.8) use finitely many singleton sets, so every kernel is Borel measurable.

### 4.3. Privacy for all fixed stream pairs

**Proposition 4.3 (global fixed-stream bound).** For any two streams $r,s\in\mathbb R^T$, including nonneighbors,
$$
H_\lambda(V_r,V_s)\le\frac{\eta}{M}\le\delta.
\tag{4.9}
$$

*Proof.* Lemma 4.2 gives the first inequality. The second follows from
$\eta\le M\delta$ and $M>0$. This argument covers changed parity bits, changed decoded labels, invalid rewards, multiple changed coordinates, and the irrelevant final reward. $\square$

The maximum View defect is exactly $\eta/M$: choose a fixed label vector and two valid streams with those labels, identical parities outside $j$, and opposite parity at $j$. These neighboring streams activate the same prefix with opposite signs. Thus the privacy verification is not restricted to a table witness or a particular class of neighboring changes.

### 4.4. Neighboring tables and exact attainment

For $i\in\mathcal A$, define
$$
d^+_t(i)=d^-_t(i)=2i\quad(t\le h,\ t\ne j),
\qquad
d^+_j(i)=2i+1,\quad d^-_j(i)=2i.
\tag{4.10}
$$
Give the tables an identical arbitrary final row. They differ only at row $j$. Under both tables every observed label matches the action that selected it, so every action prefix activates the terminal perturbation. The terminal law is $B_+$ under $d^+$ and $B_-$ under $d^-$, with a common uniform prefix.

Summing the $M$ equal prefix contributions in (4.4) yields
$$
H_\lambda(M_{d^+},M_{d^-})
=H_\lambda(M_{d^-},M_{d^+})
=\eta.
\tag{4.11}
$$
The forward maximizing event is $\{A_T=0\}$, and the reverse event is $\{A_T=1\}$. Equations (4.9) and (4.11) give the lower bound $\mathcal E_{\mathbb R}\ge\min\{1,K^h\delta\}$. Proposition 3.3 supplies the matching upper bound, proving Theorem A. $\square$

### 4.5. Endpoints and the size of the separation

At $\delta=0$, one has
$a=(\lambda-1)/(2(\lambda+1))$, and every relevant defect at factor $\lambda$ is zero. At $\lambda=1$, one has $a=\eta/2$ and the different-location calculation gives $u+v=\eta$. If $M\delta\ge1$, then $a=1/2$; the witness terminal actions are deterministic and distinct, so the cap of one is attained.

For $0<\delta<1$ and $M>1$, the witness error
$\eta=\min\{M\delta,1\}$ is strictly larger than $\delta$. Consequently there is no positive small-$\delta$ interval on which universal same-parameter View-to-Table equivalence is restored for real rewards. The construction uses $2K$ real symbols and equality tests. Its conclusion does not impose smoothness on the reward response or extend the same separation to every restricted alphabet.


## 5. Proof of Theorem B: the binary envelope

The binary upper bound uses both directions of privacy before converting their sum into a bound on either direction. This step extracts information from probability normalization that is unavailable to an arbitrary collection of restricted transcript sums.

### 5.1. A directional normalization constraint

**Lemma 5.1.** For probability laws $P,Q$ and $\lambda\ge1$, put
$u=H_\lambda(P,Q)$ and $v=H_\lambda(Q,P)$. Then
$$
\lambda u\le v+\lambda-1,\qquad
\lambda v\le u+\lambda-1.
\tag{5.1}
$$
Consequently, if $u+v\le s$, then
$$
\max\{u,v\}
\le\min\left\{1,\;s,\;\frac{\lambda-1+s}{\lambda+1}\right\}.
\tag{5.2}
$$

*Proof.* Let $E=\{x:P(x)>\lambda Q(x)\}$, so
$u=P(E)-\lambda Q(E)$ by Lemma 3.1. The reverse defect evaluated on $E^c$ gives
$$
\begin{aligned}
v&\ge Q(E^c)-\lambda P(E^c)\\
 &=\lambda u-(\lambda-1)+(\lambda^2-1)Q(E)\\
 &\ge\lambda u-(\lambda-1).
\end{aligned}
$$
Interchange $P,Q$ for the other inequality. For (5.2), use the cap of one, $u,v\ge0$, and
$$
(\lambda+1)u\le u+v+\lambda-1\le s+\lambda-1,
$$
with the corresponding inequality for $v$. $\square$

A pointwise proof of (5.1), useful for finite-sum verification, starts from
$$
\lambda[x-\lambda y]_+
\le[y-\lambda x]_++\lambda x-y
\qquad(x,y\ge0).
\tag{5.3}
$$
If $x\ge\lambda y$, the right side minus the left side is at least
$(\lambda^2-1)y\ge0$. Otherwise the left side is zero and the right side is
$[y-\lambda x]_+-(y-\lambda x)\ge0$.
Summing (5.3) over coordinates and using
$\sum_xP(x)=\sum_xQ(x)=1$ proves the first inequality in (5.1).

### 5.2. A midpoint estimate

**Lemma 5.2.** For $C=(P+Q)/2$ and $\lambda\ge1$,
$$
\begin{aligned}
&H_\lambda(P,C)+H_\lambda(C,P)
 +H_\lambda(Q,C)+H_\lambda(C,Q)\\
&\hspace{35mm}\le H_\lambda(P,Q)+H_\lambda(Q,P).
\end{aligned}
\tag{5.4}
$$

*Proof.* Positive-part convexity and $H_\lambda(P,P)=H_\lambda(Q,Q)=0$ give
$$
H_\lambda(P,C)\le\tfrac12H_\lambda(P,Q),
\qquad
H_\lambda(C,Q)\le\tfrac12H_\lambda(P,Q).
$$
The two remaining terms are each at most
$H_\lambda(Q,P)/2$. Summing proves (5.4). No common-support or strict-positivity assumption is needed. $\square$

### 5.3. The binary upper bound

Fix neighboring binary tables $d,e$. If their only changed row is $T$, their transcript laws coincide. Otherwise let $j\in\{1,\ldots,h\}$ be the changed row. For each transcript $x=(a_1,\ldots,a_T)$, collect its rewards at the unchanged influential rows, in increasing time order:
$$
z(x)=\bigl(d_t(a_t):1\le t\le h,\ t\ne j\bigr)
\in\{0,1\}^{h-1}.
$$
The same vector is obtained from $e$. For each $z$, let $r(z,0)$ and $r(z,1)$ be fixed streams obtained by inserting the indicated sensitive bit at $j$, using $z$ at the other active coordinates, and choosing a common arbitrary final reward. These streams are neighbors.

Consider a transcript with $z(x)=z$. If $d_j(a_j)=e_j(a_j)$, the two table products agree and both directed positive parts vanish. Otherwise the sensitive bits are 0 and 1 in one of two orders. Lemma 3.2 identifies
$(M_d(x),M_e(x))$ with
$(V_{r(z,0)}(x),V_{r(z,1)}(x))$ in that order or the reverse order. In either case the bilateral contribution is
$$
[V_{r(z,0)}(x)-\lambda V_{r(z,1)}(x)]_+
+[V_{r(z,1)}(x)-\lambda V_{r(z,0)}(x)]_+.
$$
Sum over the transcripts in each group and enlarge each nonnegative restricted sum to the full transcript space. View privacy gives
$$
\begin{aligned}
&H_\lambda(M_d,M_e)+H_\lambda(M_e,M_d)\\
&\quad\le\sum_{z\in\{0,1\}^{h-1}}
 \left\{H_\lambda(V_{r(z,0)},V_{r(z,1)})
       +H_\lambda(V_{r(z,1)},V_{r(z,0)})\right\}\\
&\quad\le 2^{h-1}\cdot2\delta=2^h\delta.
\end{aligned}
\tag{5.5}
$$
The full table laws are normalized, so Lemma 5.1 applied with $s=2^h\delta$ gives the upper bound in Theorem B.

No group has been conditioned upon or normalized. Later feedback may depend on earlier actions, action probabilities may be nonuniform, and the orientation of the two sensitive bits may depend on the selected action. Grouping both directions before applying normalization accommodates all these possibilities.

### 5.4. A matching policy and privacy at every coordinate

Set
$$
\beta=B_{T,\lambda}(\delta),\qquad
g=2^{h-1},\qquad
\nu=[\lambda\beta-(\lambda-1)]_+,
\tag{5.6}
$$
and use the terminal laws
$$
Q=\operatorname{Bernoulli}(\beta),\qquad
R=\operatorname{Bernoulli}(0),\qquad
C=\operatorname{Bernoulli}(\beta/2).
\tag{5.7}
$$
A Bernoulli law here assigns its parameter to action 1 and the complementary probability to action 0. Direct calculation gives
$$
H_\lambda(Q,R)=\beta,\qquad
H_\lambda(R,Q)=\nu,\qquad C=(Q+R)/2.
\tag{5.8}
$$

At each round $t\le h$, sample $A_t$ as an independent fair bit, ignoring all observed rewards. Store the rewards and define the gate
$$
G=\{A_t=r_t\text{ for all }1\le t<h\}.
\tag{5.9}
$$
At round $T$, use terminal law $Q$ if $G$ holds and $A_h=r_h$; use $R$ if $G$ holds and $A_h\ne r_h$; and use $C$ if the gate fails. All required rewards have arrived before this terminal action. For $T=2$, there are $h-1=0$ gate coordinates, so $G$ is the empty conjunction and always holds.

Fix a binary reward stream. Exactly one of the $g$ equally likely first-$(h-1)$-action prefixes satisfies the gate. At that prefix the fair action $A_h$ selects $Q,R$ in opposite orders as $r_h$ changes. Every possible neighboring change is covered by the following cases.

1. A change to $r_T$ affects no released action and has zero defect.
2. A change to $r_h$ preserves the successful gate prefix and swaps $Q,R$ in its two $A_h$ blocks. Each direction has defect
   $(\beta+\nu)/(2g)$.
3. A change to an earlier reward $r_s$, $s<h$, moves the successful gate to a different prefix. At the old prefix an active law becomes $C$; at the new prefix $C$ becomes an active law. Each prefix contains two equally weighted $A_h$ blocks carrying $Q,R$. Hence the defect in either direction is
$$
\begin{aligned}
\frac1{2g}\bigl\{&
 H_\lambda(Q,C)+H_\lambda(C,Q)\\
 &+H_\lambda(R,C)+H_\lambda(C,R)\bigr\}
 \le\frac{\beta+\nu}{2g},
\end{aligned}
\tag{5.10}
$$
by Lemma 5.2.

The definition of $\beta$ gives
$\beta\le2g\delta$ and
$(\lambda+1)\beta-(\lambda-1)\le2g\delta$. Therefore
$$
\beta+\nu
=\max\{\beta,(\lambda+1)\beta-(\lambda-1)\}
\le2g\delta.
\tag{5.11}
$$
Equations (5.10)–(5.11) prove View privacy at every coordinate. The exact maximum over neighboring fixed streams is
$(\beta+\nu)/(2g)$, attained by case 2. In particular, the rewards defining the gate have been checked explicitly.

### 5.5. The stronger all-stream property

The same policy satisfies this bound for arbitrary pairs of fixed streams. Group $(A_h,A_T)$ into a block and let $P_b$ be the block law in which the public fair bit $A_h$ selects $Q$ when $A_h=b$ and $R$ otherwise. Then
$$
H_\lambda(P_0,P_1)=H_\lambda(P_1,P_0)
=\frac{\beta+\nu}{2}=:\eta.
\tag{5.12}
$$
The inactive block law is
$C_2=(P_0+P_1)/2$, since its conditional terminal law is $C$ for either public bit. Positive-part convexity yields
$$
H_\lambda(P_b,C_2)\le\eta/2,\qquad
H_\lambda(C_2,P_b)\le\eta/2
\quad(b=0,1).
\tag{5.13}
$$

Two fixed streams either activate the same gate prefix or distinct ones. In the first case, the only possible difference has cost at most $\eta/g$. In the second case, the two disjoint prefixes contribute at most
$(\eta/2+\eta/2)/g$. The unused final reward has no effect. Thus, for every ordered pair of fixed binary streams,
$$
H_\lambda(V_r,V_s)\le\eta/g
=\frac{\beta+\nu}{2g}\le\delta.
\tag{5.14}
$$
This proves the additional assertion in Theorem B without relying only on coordinatewise adjacency.

### 5.6. Table attainment and embedding into larger action sets

In every gate row $t<h$, set
$d_t(a)=e_t(a)=a$ for $a\in\{0,1\}$. At the sensitive row, set
$$
d_h(a)=a,\qquad e_h(a)=1-a.
\tag{5.15}
$$
Choose a common arbitrary final row. The tables differ only at row $h$, and every realized prefix satisfies the gate. Under $d$, the final action always has law $Q$; under $e$, it always has law $R$. The preceding action prefixes have a common uniform distribution. Consequently,
$$
H_\lambda(M_d,M_e)=\beta,\qquad
H_\lambda(M_e,M_d)=\nu.
\tag{5.16}
$$
This matches the upper bound from Section 5.3.

For $K>2$, identify two actions with $0,1$, give every additional action probability zero at each sampling step, and fill its table entries arbitrarily. On histories containing an unused exploration action, define the terminal law to be $C$; these histories occur with probability zero for every input. This specifies a valid kernel everywhere and leaves every law in the calculation unchanged. Theorem B follows. $\square$

### 5.7. Phase boundaries

For $\lambda>1$, put $D=2^h$. The equality of the first two nonconstant terms in (B) occurs at
$\delta=(\lambda-1)/(\lambda D)$, and the affine term reaches one at $\delta=2/D$. Thus
$$
B_{T,\lambda}(\delta)=
\begin{cases}
D\delta,
 &0\le\delta\le(\lambda-1)/(\lambda D),\\
(\lambda-1+D\delta)/(\lambda+1),
 &(\lambda-1)/(\lambda D)\le\delta\le2/D,\\
1,&2/D\le\delta\le1.
\end{cases}
\tag{5.17}
$$
The expressions agree at shared endpoints. For $\lambda=1$, (B) reduces to
$$
B_{T,1}(\delta)=\min\{1,2^{h-1}\delta\}.
\tag{5.18}
$$
Hence binary feedback at $T=2$ has no total-variation amplification. For every $\lambda>1$, the initial small-$\delta$ slope is $2^h$; the interval supporting that slope shrinks to zero as $\lambda\downarrow1$, consistently with continuity of the envelope. At $\delta=0$ the value is zero for every $\lambda$, and the construction attains the saturation endpoint whenever it is reached.


## 6. Proof of Theorem C: finite alphabets in total variation

Let $|\mathcal R|=q\ge2$, and write
$$
m=\min(K,q),\qquad q_0=\min(q,2K).
\tag{6.1}
$$
Only equality of reward symbols is used; the alphabet need not have numerical values. We first separate the alphabet constraint at the sensitive row from the number of contexts generated by the other $h-1$ influential rows.

### 6.1. A finite selection inequality

**Lemma 6.1 (scalar diameter inequality).** For real numbers $v_1,\ldots,v_q$ and indices $a,b\in\{1,\ldots,q\}$,
$$
2(q-1)|v_a-v_b|
\le\sum_{u=1}^q\sum_{v=1}^q|v_u-v_v|.
\tag{6.2}
$$

*Proof.* If $a=b$, the left side is zero. Otherwise retain from the double sum both orientations of $\{a,b\}$ and both orientations of $\{a,c\}$ and $\{b,c\}$ for every $c\notin\{a,b\}$. Their sum is
$$
2|v_a-v_b|
+2\sum_{c\notin\{a,b\}}
 \bigl(|v_a-v_c|+|v_b-v_c|\bigr).
$$
Each parenthesis is at least $|v_a-v_b|$ by the triangle inequality, and there are $q-2$ such terms. Every omitted summand is nonnegative, proving (6.2). $\square$

**Corollary 6.2 (coordinatewise selection).** Suppose $P_1,\ldots,P_q$ are probability vectors on a common finite set and
$\operatorname{TV}(P_u,P_v)\le\delta$ for every pair. For arbitrary index choices $a(x),b(x)$,
$$
\sum_x|P_{a(x)}(x)-P_{b(x)}(x)|\le q\delta.
\tag{6.3}
$$

*Proof.* Apply (6.2) separately at every coordinate and sum. Each of the $q(q-1)$ nondiagonal ordered pairs has full $L^1$ distance at most $2\delta$. The diagonal terms vanish. Dividing the resulting inequality by $2(q-1)>0$ gives (6.3). $\square$

The selected endpoints may depend on the coordinate. The selected arrays themselves need not be probability laws. This elementary finite $L^1$ estimate is used here as an ingredient; the claim being studied is its sharp application to the causal conversion problem.

### 6.2. The alphabet-sensitive upper bound

Fix neighboring tables $d,e$ with changed row $j\le h$; a change only at $T$ has zero effect. At each active row $t\ne j$, the common table row takes at most $m$ distinct values. For each possible vector $z$ of these rewards, listed in increasing time order, let $B_z$ consist of the transcripts realizing $z$. The sets $B_z$ partition the transcript space, and at most $m^{h-1}$ of them are nonempty.

For $y\in\mathcal R$, let $r_z^y$ be the fixed stream with reward $y$ at $j$, rewards $z$ at the other active rows, and a common arbitrary final reward. In the remainder of this paragraph, write $P_y=V_{r_z^y}$. Every pair $P_y,P_v$ has total variation at most $\delta$, since the streams differ in at most coordinate $j$. For $x=(a_1,\ldots,a_T)\in B_z$, Lemma 3.2 gives
$$
M_d(x)=P_{d_j(a_j)}(x),\qquad
M_e(x)=P_{e_j(a_j)}(x).
\tag{6.4}
$$
Apply Corollary 6.2 using these coordinate-dependent indices and restrict its nonnegative sum to $B_z$. Then
$$
\sum_{x\in B_z}|M_d(x)-M_e(x)|\le q\delta.
\tag{6.5}
$$

A second bound follows by splitting $B_z$ into the $K$ classes determined by $a_j$. On each class the two selected fixed streams in (6.4) are fixed, so its restricted $L^1$ difference is at most their full distance $2\delta$. Thus the left side of (6.5) is also at most $2K\delta$. Summing over the at most $m^{h-1}$ groups and dividing by two gives
$$
\operatorname{TV}(M_d,M_e)
\le\min(K,q/2)m^{h-1}\delta.
\tag{6.6}
$$
The cap of one follows from normalization of the full table laws. This argument allows arbitrary causal feedback dependence and any affected row before the final action. No group is treated as a conditional probability law.

### 6.3. A sharp two-round channel, including odd alphabets

Use $q_0$ active symbols of $\mathcal R$. If $q_0=2r$, use $r$ sensitive-row actions $i=1,\ldots,r$, each with probability
$w_i=2/q_0$, and associate symbols $+i,-i$ with action $i$. If $q_0=2r+1$, use these $r$ paired actions with the same weights and one further action $*$ with weight $w_*=1/q_0$, associated with the remaining symbol $+*$. Give every unused action weight zero.

This needs at most $K$ actions. For even $q_0$, the count is $q_0/2\le K$. For odd $q_0$, the integer inequality $q_0\le2K-1$ gives $(q_0+1)/2\le K$. Since $q_0\ge2$, at least one paired action exists, including in the odd case.

We specify joint laws on the sensitive-row action and a terminal bit $b\in\{0,1\}$. The common center $C$ has, on each paired action,
$$
C(i,0)=C(i,1)=1/q_0.
$$
In the odd case, its singleton block is
$$
C(*,0)=0,\qquad C(*,1)=1/q_0.
$$
All unused action blocks have zero mass. Thus $C$ is normalized and has marginal $w_i$ on the sensitive action. The singleton center is an endpoint, which will allow exact saturation.

Choose $c\in[0,1/q_0]$. For each paired action $i$, define the active laws by changing only its block:
$$
\begin{array}{c|cc}
& (i,0)&(i,1)\\ \hline
P_{+i}&1/q_0-c&1/q_0+c\\
P_{-i}&1/q_0+c&1/q_0-c.
\end{array}
\tag{6.7}
$$
Every other block equals its block in $C$. In the odd case, let $P_{+*}$ change only the singleton block to
$$
P_{+*}(*,0)=c,\qquad
P_{+*}(*,1)=1/q_0-c.
\tag{6.8}
$$
Assign every alphabet symbol outside these $q_0$ active symbols the law $C$.

All displayed masses are nonnegative. Every modification transfers mass within one action block, so all $P_y$ are normalized and have the same action marginal $w$. They therefore define a genuine two-round causal policy: sample action $i$ with probability $w_i$, observe symbol $y$, and use terminal kernel
$$
\Pr(B=b\mid i,y)=P_y(i,b)/w_i
\quad\text{when }w_i>0.
\tag{6.9}
$$
When $w_i=0$, define this kernel to be any fixed bit law, for example the point mass at 0. Such a sensitive-action history has probability zero under every input; assigning it a law completes the policy definition without altering any transcript probability. The same convention applies to the center kernel $C(i,b)/w_i$.

Each active law is at total variation $c$ from $C$. Any two distinct active laws are at distance $2c$: opposite symbols on one paired action make opposite transfers, while symbols attached to different actions modify disjoint two-outcome blocks. An inactive center symbol is at distance $c$ from an active law. Consequently the diameter of the entire family is at most $2c$.

For the witness tables, assign symbol $+i$ in $d$ and $-i$ in $e$ at each paired action $i$. At the singleton action, if present, assign $+*$ in $d$ and any paired symbol in $e$. The latter law leaves the singleton block at $C$. Fill unused-action entries arbitrarily. Each paired action contributes $2c$ to the table total variation; the singleton contributes $c$. Hence
$$
\operatorname{TV}(M_d,M_e)
=2rc+\mathbf 1_{\{q_0\ {\rm odd}\}}c=q_0c.
\tag{6.10}
$$
One forward maximizing event selects terminal bit 1 on every paired sensitive action and terminal bit 0 on the singleton action. These directions differ, but the sensitive action is part of the disclosed transcript, so this is a valid event. Its complement gives the reverse total-variation defect.

The ratio between (6.10) and the family diameter $2c$ is $q_0/2=\min(K,q/2)$ when $c>0$. At $c=1/q_0$, the table distance is one. The endpoint center in (6.8) permits this conclusion for odd $q_0$ as well as even $q_0$.

### 6.4. Amplification through the other feedback rows

Fix any designated sensitive row $j\le h$, and put
$$
N=m^{h-1}.
\tag{6.11}
$$
Choose a set $S\subseteq\mathcal A$ of $m$ actions and an injective labeling
$\gamma:S\to\mathcal R$. At each active row $t\ne j$, independently choose an action uniformly from $S$, receive the reward, and store whether it equals $\gamma(A_t)$. At row $j$, independently choose the sensitive action using $w$ from Section 6.3 and store its reward symbol $y$. Each of the first $h$ action kernels uses its prescribed fixed law irrespective of the reward history, and the exploration draws are mutually independent.

At the final action, if every gate comparison succeeded, use the conditional law in (6.9); otherwise use the center conditional law. Encode the two output bits as any two designated actions in $\mathcal A$. On a history with a zero-weight sensitive action, use the fixed terminal law already specified. An unused gate action can be declared to fail its comparison. These conventions define the kernel on every history, including those of probability zero.

A **gate-action vector** means the $h-1$ actions at times in
$\{1,\ldots,h\}\setminus\{j\}$, enumerated in increasing time order. It is not required to be an initial segment of the chronological transcript. There are $N$ equally likely such vectors, independent of the sensitive action. Reordering the coordinates for analysis identifies the released transcript on its support with a gate-action vector and a block consisting of the sensitive action and terminal bit; this is a bijection and preserves total variation.

For any fixed reward stream, at most one gate-action vector matches all its gate rewards. If one gate reward lies outside $\gamma(S)$, none matches. At each inactive vector the sensitive-action/terminal-bit block has law $C$; at the possible active vector it has law $P_y$. Thus arbitrary pairs of fixed streams satisfy the following alternatives:

- If the active vector is the same, its two block laws have distance at most $2c$, giving total distance at most $2c/N$.
- If the active vectors differ, each modification has distance at most $c$ from its center on a disjoint vector, giving total distance at most $2c/N$.
- If one or both streams have no active vector, the distance is no larger.

This proves the stronger all-stream bound
$$
\operatorname{TV}(V_r,V_s)\le2c/N
\quad\text{for every }r,s\in\mathcal R^T.
\tag{6.12}
$$
An active sensitive symbol mapped to $C$ only reduces these distances.

In the witness tables, set the reward at every gate row to $\gamma(i)$ for each selected action $i\in S$, with arbitrary common values on unused actions. At row $j$, use the two assignments of Section 6.3. Give the tables an identical final row. Every realized gate-action vector now activates, and the tables agree outside $j$. Their common uniform gate marginal and (6.10) give table total variation $q_0c$.

Finally choose
$$
c=\min\{1/q_0,\;N\delta/2\}.
\tag{6.13}
$$
Then $2c/N\le\delta$, and
$$
q_0c
=\min\{1,(q_0/2)N\delta\}
=\min\{1,\min(K,q/2)\min(K,q)^{h-1}\delta\}.
\tag{6.14}
$$
The construction remains causal when $j$ is early: the sensitive symbol and subsequent gate results are stored and used only for the final action. For $T=2$, the gate-action vector is empty, $N=1$, and the argument reduces to Section 6.3. For $\delta=0$, all modifications vanish. For the saturation range, (6.13) chooses the endpoint $c=1/q_0$. Equations (6.6) and (6.14) prove Theorem C in all stated cases. $\square$


## 7. Consequences, consistency, and remaining questions

The three envelopes separate different restrictions on how a fixed table can activate transcript-dependent behavior. Theorem A permits a distinct reward label for every action at every influential time, and its exact factor is $K^h$. Theorem C shows how a finite alphabet constrains this behavior: the unchanged influential rows admit at most $\min(K,q)^{h-1}$ contexts, while the changed row contributes $\min(K,q/2)$. For binary rewards and $\lambda>1$, Theorem B additionally accounts for unequal forward and reverse hockey-stick defects.

Several checks follow directly from the formulas:

| Setting | Exact envelope |
| --- | --- |
| Binary rewards, $\lambda=1$ | $\min\{1,2^{T-2}\delta\}$, from both B and C |
| $q\ge2K$, $\lambda=1$ | $\min\{1,K^{T-1}\delta\}$, from both A and C |
| $T=2$, finite $q$, $\lambda=1$ | $\min\{1,\min(K,q/2)\delta\}$ |
| $\delta=0$, in every stated model | $0$ |

Thus binary total variation has no amplification at $T=2$, whereas three reward symbols already permit a factor $3/2$ when $K\ge2$. For odd $q<2K$, the sensitive-row factor is a half-integer. Section 6 attains this value without rounding the alphabet size or discarding the singleton symbol.

At $\delta=0$, Proposition 3.3 gives the View-to-Table pure-privacy implication for every reward space. The reverse implication follows by representing a fixed stream as a table whose rows are constant across actions. This recovers the pure-privacy equivalence in the present interface. The stronger all-stream properties of the lower-bound policies also show that the approximate separations do not result solely from restricting the View comparison to single-coordinate neighbors.

The nondegenerate assumptions delimit the formulas. If $K=1$, the transcript is deterministic. If $T=1$, the only disclosed action precedes every reward. If $|\mathcal R|=1$, every admissible stream and table produces the same input along every path. In each case the maximal privacy defect is zero. A change only to row $T$ has zero effect for every policy even in the nondegenerate regime.

The unrestricted conversion when the output factor differs from the input factor and the general intermediate-alphabet classification at $\lambda>1$ remain open here. Sections 8–9 solve the conversion conditional on a fixed causal prefix. Appendix C treats one finite-positive slice. The extremal quantity (2.4) has no utility constraint; Appendices B and D study separately specified exploration classes and regret objectives.

## 8. Exact conversion for a fixed adaptive prefix

Let the reward alphabet be finite and hold fixed the causal rule producing the first $h=T-1$ actions. The matrix of prefix probabilities is $w_r(a)$ indexed by fixed effective reward streams $r\in\mathcal R^h$ and action prefixes $a\in\mathcal A^h$. It does not depend on the final effective reward $r_h$. Write $r_d(a)=(d_{i,a_i})_{i=1}^h$ for a table $d$. By the causal path identity, the prefix has mass $w_{r_d(a)}(a)$ under $d$.

**Theorem D.** For any ordered adjacent tables $d,e$, View privacy $(\lambda,\delta)$, and requested Table factor $\lambda'\ge1$, the maximal defect over all legal terminal-action extensions of this fixed prefix is the finite linear program
$$
\max_u\sum_a (u_{r_d(a),a}-\lambda' u_{r_e(a),a}),\qquad
0\le u_{r,a}\le w_r(a),
$$
with one row of constraints for every ordered adjacent fixed-stream pair:
$$
\sum_a\left([u_{r,a}-\lambda u_{s,a}]_+
+[(w_r(a)-u_{r,a})-\lambda(w_s(a)-u_{s,a})]_+\right)\le\delta.
$$
The positive parts are implemented by nonnegative auxiliary variables bounding each summand. The polytope is feasible exactly when the prefix itself is View private. Taking the maximum of these linear programs over ordered neighboring tables yields the complete envelope for the fixed prefix.

For the proof, take any admissible terminal strategy and any maximizing event in the Table divergence. Postprocess the last action at each publicly observed prefix $a$ onto two designated actions, indicating whether that action at $a$ belongs to the event. By privacy postprocessing all View constraints are preserved. The probability of output one at each $(r,a)$ is $u_{r,a}$; the probability of output zero is $w_r(a)-u_{r,a}$. The event's value is now the displayed linear objective. Conversely, at a terminal history $(a,r)$, output one with probability $u_{r,a}/w_r(a)$, with arbitrary behavior on a zero-mass history. Coupling equal histories in fixed-stream and fixed-table experiments gives the objective on the event of output one. A constant terminal action establishes the sufficient feasibility direction, and ignoring the terminal action proves necessity. The finite constrained maximum is attained.

For $\lambda=1$, writing $d_a=w_r(a)-w_s(a)$, the View row also equals
$$
\operatorname{TV}(w_r,w_s)+\sum_a
\operatorname{dist}\bigl(u_{r,a}-u_{s,a},[\min(0,d_a),\max(0,d_a)]\bigr)\le\delta .
$$
Use the identity $|x|+|d-x|=|d|+2\operatorname{dist}(x,[\min(0,d),\max(0,d)])$ and the half-$\ell_1$ expression for total variation.

## 9. Exponential separation at identical observed prefix weights

Fix $h\ge2$, $K\ge2$ and at least $2K$ reward symbols. Choose a marker $g$ dividing the alphabet into two nonempty groups, and designate one first action $*$. With probability $\delta$, take $*$ and let subsequent prefix action $i+1$ record $g(r_i)$ for $1\le i<h$, using any two different actions. Otherwise choose the first action uniformly from the other $K-1$ actions, then take independent uniformly random actions through time $h$. This prefix alone has View TV at most $\delta$.

Whenever neighboring streams change an early marker, the special branch has disjoint support of mass $\delta$ on each side. It consumes the entire View TV allowance, so for any legal extension the ordinary branch's full subprobability transcript law must be identical on those two streams. At each early coordinate the cross-marker neighbor graph is connected and complete bipartite; equality propagates along it. Thus at fixed $r_h$ the ordinary sublaw is independent of all earlier reward symbols. If an early table row changes, the ordinary branch probabilities are consequently unchanged at every action outcome. If the last effective row changes, split the ordinary outcomes into $K$ groups by their action at time $h$. For each group we may freeze one common earlier stream and compare the two corresponding time-$h$ fixed rewards, costing at most one $\delta$ by View privacy. The special branch adds at most $\delta$, so the envelope is at most $(K+1)\delta$.

Under every fixed table there is exactly one special prefix, of mass $\delta$, and $(K-1)K^{h-1}$ ordinary prefixes, each of mass $(1-\delta)/[(K-1)K^{h-1}]$. Choose $\delta=1/N$ for $N=1+(K-1)K^{h-1}$. The $N$ prefix weights under any particular table are all equal. A reward-independent policy can pre-sample precisely this distribution from that same table's prefix law without observing rewards. Its exact same-factor conversion envelope is one by the fixed exploration theorem in Appendix B. The adaptive prefix's envelope is at most $(K+1)/N$. For fixed $K$ this is exponentially smaller in $h$, even though both prefixes give identical weights under the comparison table.

For the original target factor, or for any $\lambda'\ge\lambda$, every single-sided Table defect still obeys
$$
H_{\lambda'}(M_d,M_e)\le\sum_a\min\{w_{r_d(a)}(a),\delta\}.
$$
For each fixed $a$, slice the event by that prefix and apply the View bound between $r_d(a)$ and $r_e(a)$. The positive slice contribution is also at most the first measure's prefix mass. Summing proves the result. The fixed-prefix linear program allows smaller target factors as well, with its own exact constraints.

The causal partition and postprocessing use the original Azize–Basu interface [AB24, Definition 3 and Proposition 1]. Sections 8–9 address how a fixed causal prefix can use the View budget before the terminal action, which cannot be read from the weights on one table alone. They retain finite action and reward alphabets and one terminal release.


## Appendix A. Reproducibility, AI assistance, and formalization status

### A.1. Role of finite computations

The universal conclusions depend on the written arguments in Sections 3–6. Finite computations check implementations and selected instances; they do not replace quantification over real parameters, all causal policies, or all neighboring inputs.

For the real-reward construction, [code/verify_rich_lower.py](evidence/code/verify_rich_lower.py) enumerates every ordered pair of induced fixed-stream law classes, including the invalid-input baseline, at each recorded rational parameter choice. It checks probability normalization and nonnegativity, the codebook decoder, and witnesses at every influential row. The archived [rich-lower verification record](evidence/results/rich_lower_verification.json) reports 212 parameter cases, 146,036 ordered class-pair checks, and 452 row-witness checks, using exact integer and rational arithmetic. The finite class reduction is justified by Section 4.2.

For the binary construction, [code/binary_verify.py](evidence/code/binary_verify.py) uses exact rational arithmetic. Its archived [binary verification record](evidence/results/binary_verification.json) contains 129 parameter choices with horizons 2 through 5 and factors $1,3/2,2,5$, including phase boundaries, zero error, and saturation. It checks 9,120 directed neighboring fixed-stream pairs and all 49,680 ordered fixed-stream pairs in those instances, along with normalization and the table witnesses. A separate check of nine randomly generated causal policies at horizons 2 through 4 covers 11,232 directed neighboring-table pairs and tests both (5.5) and the resulting directional bound.

An exploratory realization-plan mixed-integer linear program at
$K=2,T=3,\lambda=2,\delta=1/5$ examined twelve table-pair symmetry classes and returned approximately $0.6000000000000123$, consistent with the exact value $3/5$. This floating-point calculation is exploratory evidence and is not used in any proof.

These are archived execution results. This manuscript revision does not claim that every archived computation was rerun during editing. Reproduction details and machine-readable records accompany the source.

### A.2. Formal supplement and verified coverage

The separately assessed Lean supplement covers the mathematical scope of Theorems A–C, their supporting lemmas, boundary cases, exact channel calculations, and attaining-policy claims. The final modular build contains 34 source modules. A fresh build and an audit of every local declaration examined 1,059 declarations, including private declarations, instances, and compiler-generated auxiliaries. All transitive axiom dependencies belong to the set `Classical.choice`, `Quot.sound`, and `propext`; no local declaration is exempted from that check.

The standalone source combines the same mathematical source bodies in dependency order. It was separately compiled from an empty local build directory and its complete compiled environment was separately audited, covering 966 declarations. The different counts reflect generated auxiliary declarations in the modular and single-file environments; they are not counts of research contributions. The source mapping and both actual reports accompany the supplement. These are native Lean 4.19.0 executions with the recorded Mathlib revision, not a claim that a separate vendor or isolated product pipeline executed.

The verified scope includes normalized causal policy laws; View and Table privacy over all finite output events; all real-valued fixed inputs in the real-reward result; the full universal upper bounds; actual attaining policies on arbitrary given finite action and reward sets; real-input Borel measurability; all-stream protection of the stated witnesses; strictly changed prescribed rows where asserted; exact maximizing events and channel geometry; and the single-action, single-reward, single-round, pure-privacy, and positive-small-error boundary claims. The full-horizon interface retains all disclosed actions and explicitly proves that the final reward cannot affect their law.

There are harmless coordinate differences between the hand proofs and their implementations. The real-reward code uses an equivalent finite bijection in place of the displayed numerical labeling. The binary formal witness places its sensitive reward at the first exploration coordinate, whereas Section 5 places it at the last; all exploration actions are reward independent and the stored rewards are first used in the terminal decision. The finite-alphabet singleton block uses the opposite endpoint with a compensating terminal-label convention. Definitions on unreachable histories may also differ. The audited statements preserve the manuscript's input spaces, causal interface, privacy quantifiers, exact defects, and attainment claims; literal equality of every displayed kernel under the original coordinate names is not asserted.

The strict audit initially rejected runtime-only compiler artifacts carrying additional dependencies. Explicitly marking mathematical definitions and instances `noncomputable`, followed by two equivalent recursor rewrites, removed those artifacts without relaxing the three-axiom criterion. The failed runs and repairs are retained alongside the final successful reports. The verification driver, modular report, single-file report, and independent scope and hostile review record the evidence and its boundaries.

Later research notes in `extensions/` have separate mathematical and computational reviews and are not included in this A–C Lean certificate. Neither the certificate nor internal mathematical review establishes external peer review, worldwide priority, or a dissertation-level scholarly-value judgment.

### A.3. Research and review disclosure

AI systems assisted the derivations, verification code, manuscript preparation, and internal review. This document is an AI-assisted research preprint and has not undergone external peer review. The manuscript, finite-computation records, formal supplement, source comparison, and internal review records provide different kinds of evidence and should be evaluated separately. The source ledger records inspected versions and locations, and the novelty comparison records the scope of the literature check.

## References

**[AB24]** Achraf Azize and Debabrota Basu. *Concentrated Differential Privacy for Bandits*. IEEE Conference on Secure and Trustworthy Machine Learning (SaTML), 2024. [arXiv:2309.00557v3](https://arxiv.org/html/2309.00557v3), revised 15 April 2024. Relevant locations: Section III-C, Definition 3, Proposition 1 and the following discussion; Appendix B-A.

**[A24]** Achraf Azize. *Privacy-Utility Trade-offs in Sequential Decision-Making under Uncertainty*. Doctoral dissertation, Université de Lille, 2024. [Author copy](https://achraf-azize.github.io/PhD_thesis.pdf); [institutional copy](https://pepite-depot.univ-lille.fr/LIBRE/EDMADIS/2024/2024ULILB029.pdf). Relevant location: Chapter 9, Perspectives, discussion of privacy definitions, printed p. 167.

**[DMR+22]** Sergey Denisov, H. Brendan McMahan, Keith Rush, Adam Smith, and Abhradeep Thakurta. *Improved Differential Privacy for SGD via Optimal Private Linear Operators on Adaptive Streams*. Advances in Neural Information Processing Systems (NeurIPS), 2022. [Official proceedings](https://proceedings.neurips.cc/paper_files/paper/2022/hash/271ec4d1a9ff5e6b81a6e21d38b1ba96-Abstract-Conference.html); [arXiv:2202.08312](https://arxiv.org/abs/2202.08312). Relevant locations: Proposition 2.1, Theorem 2.1, and the official supplement, Appendix D.1, Propositions D.1–D.2.

**[AWH+25]** Achraf Azize, Yulian Wu, Junya Honda, Francesco Orabona, Shinji Ito, and Debabrota Basu. *Optimal Regret of Bernoulli Bandits under Global Differential Privacy*. [arXiv:2505.05613v1](https://arxiv.org/html/2505.05613v1), 8 May 2025. Relevant location: Appendix B, especially Remark 13, Proposition 14, Reduction 1, and the discussion of approximate privacy following the proof.

**[BGW26]** Mark Bun, Marco Gaboardi, and Connor Wagaman. *Separating Oblivious and Adaptive Differential Privacy under Continual Observation*. 7th Symposium on Foundations of Responsible Computing (FORC), 2026. [DOI:10.4230/LIPIcs.FORC.2026.22](https://doi.org/10.4230/LIPIcs.FORC.2026.22); [arXiv:2603.11029v1](https://arxiv.org/html/2603.11029v1). Relevant location: Section 1.3 of the full version.

**[HSV26]** Monika Henzinger, Roodabeh Safavi, and Salil Vadhan. *Concurrent Composition for Differentially Private Continual Mechanisms*. [arXiv:2411.03299v4](https://arxiv.org/abs/2411.03299), version of 16 March 2026; [author-hosted version 4](https://salil.seas.harvard.edu/sites/g/files/omnuum4266/files/2026-04/HenzigerSaVa2024v4.pdf). Relevant locations: p. 2, footnote 1; Theorems 1.4–1.5; Section 5.



## Appendix B. Fixed exploration and the utility bridge

This appendix records the fixed-exploration utility bridge, with its external pure-private regret theorem stated separately.

### 1. Main finding

There is a black-box transformation of any two-arm pure-View-private bandit policy into an approximate-View-private policy whose table laws can be mutually singular, while preserving the original policy's leading stochastic-regret coefficient. No known reward gap is required.

The mechanism uses a public action transcript to estimate the better arm, and randomizes the positions of a small prescribed number of exploratory actions. This provides a large number of equally likely gate contexts at a small expected regret cost. The later gate is a randomized function of the earlier **public actions**, fresh random bits, and the later rewards. Earlier private rewards and hidden state are discarded.

For a concrete horizon-dependent choice, the new View error is

$$
\delta_T=\exp\!\left[-(1+o(1))\frac{(\log T)^2}{\log\log T}\right],
$$

while the additional regret is $o(\log T)$ on each fixed nondegenerate two-arm Bernoulli instance whenever the base regret is $O(\log T)$. Nevertheless, for one fixed neighboring table pair, both directed table hockey-stick divergences equal one at **every finite output privacy factor**.

The conclusion concerns the strength of privacy requirements inside a low-regret policy class. It does not compare the minimum achievable regrets under View privacy and Table privacy, and it does not assert that the unmodified base algorithms have a privacy defect.

### 2. Notation and privacy interface

There are two actions, labeled $0,1$, and binary rewards. An action precedes the reward at the same round. Every action is public. The last reward therefore cannot affect the transcript. Neighboring streams or tables differ in at most one coordinate or row, respectively.

For finite probability laws,

$$
H_\lambda(P,Q)=\sum_x[P(x)-\lambda Q(x)]_+,
\qquad \lambda=e^\varepsilon\ge1.
$$

An $(\varepsilon,\delta)$-View guarantee means this divergence is at most $\delta$ for every ordered neighboring pair of fixed reward streams. Pure View privacy means $\delta=0$. These are the interfaces of Azize and Basu [AB24, Definition 3 and Proposition 1]; the extension keeps their fixed-table interpretation.

For stochastic utility, fix a two-arm Bernoulli environment $\nu=(\operatorname{Ber}(\mu_0),\operatorname{Ber}(\mu_1))$. Write $\mu^*=\max(\mu_0,\mu_1)$, $\Delta=|\mu_1-\mu_0|$, and

$$
R_n(\pi,\nu)=\mathbb E_\nu\sum_{t=1}^n(\mu^*-\mu_{A_t}).
$$

All asymptotic claims below keep $\nu$, the base privacy parameter, and any base algorithm tuning parameters fixed. No bound uniform in vanishing gaps or vanishing $\varepsilon$ is inferred.

### 3. The core gate lemma: privacy is controlled by maximum context mass

Let $M\ge0$, and let $v$ be any probability distribution on $\{0,1\}^M$. Consider the following block of $M+2$ actions.

1. Draw a fair sensitive action $U\in\{0,1\}$, and observe its reward $s$.
2. Independently draw a gate-action vector $Z\sim v$. Play its coordinates in chronological order. These action choices do not use the gate rewards. Let $G$ mean that each gate reward equals the gate action that selected it.
3. If $G$ holds, take terminal action $1$ exactly when $U=s$. If $G$ fails, take a fresh fair terminal action. The reward at this terminal action is ignored.

Drawing the vector in advance is a valid causal policy: equivalently, use the conditional next-coordinate law of $v$ given the already played action prefix, with any law on a zero-probability prefix. No future reward is used.

### Lemma 1. Exact conditional View error and complete Table separation

For every finite $\lambda\ge1$, the maximum directed View defect of this block, even over all pairs of fixed streams, is

$$
\|v\|_\infty=\max_z v(z).
\tag{1}
$$

The maximum is already attained by streams differing only at the sensitive reward. There are neighboring fixed tables for which both directed table defects are one at every finite factor $\kappa\ge1$.

**Proof.** Reorder the output as $(Z,U,A_{\mathrm{terminal}})$. On the sensitive-action/terminal-action pair define

$$
P_s(u,b)=\tfrac12\mathbf1\{b=\mathbf1\{u=s\}\},
\qquad C(u,b)=\tfrac14.
$$

The laws $P_0,P_1$ have disjoint supports, and $C=(P_0+P_1)/2$. Thus $H_\lambda(P_0,P_1)=H_\lambda(P_1,P_0)=1$. By convexity in each argument and $H_\lambda(P_s,P_s)=0$,

$$
H_\lambda(P_s,C)\le\tfrac12,
\qquad H_\lambda(C,P_s)\le\tfrac12.
\tag{2}
$$

A fixed gate-reward vector $z$ activates only the gate-action vector $z$. At that vector the block law is $v(z)P_s$; at every other vector it is $v(y)C$. Two fixed streams with the same gate vector therefore have defect either zero or $v(z)$. With different gate vectors $z,z'$, their defect is at most $(v(z)+v(z'))/2$. Zero-mass gate vectors cause no difficulty. These bounds prove the upper bound in (1); flipping the sensitive bit at a maximum-mass gate vector proves equality with adjacent streams.

For the tables, put the identity row $a\mapsto a$ at every gate round in both tables. At the sensitive round use $a\mapsto a$ in the first table and $a\mapsto1-a$ in the second. Every gate succeeds for every action vector. The terminal action is then identically one in the first experiment and identically zero in the second. The terminal-action events prove both defects equal one. The tables agree elsewhere, including the irrelevant final row. $\square$

For a uniform law on $N$ allowed gate vectors, (1) is exactly $1/N$. It depends on the largest atom of the law, rather than on a product representation or independence among its gate actions.

### 4. A finite-horizon black-box transformation

Fix integers

$$
B\ge1,\quad M\ge1,\quad 0\le k\le M,\quad T=B+M+2.
$$

Let $\mathcal B_B$ be any causal two-arm policy for $B$ rounds that is pure $\varepsilon$-View-private on binary reward streams. The base may have arbitrary internal state and arbitrary reward-dependent actions.

Construct $\mathcal W_{B,M,k}(\mathcal B)$ as follows.

- Run $\mathcal B_B$ for the first $B$ actions, and publish those actions as usual.
- Let $\widehat a$ be the most frequently played arm in this public transcript. Resolve ties by a fixed public rule. Discard all other base state, including rewards and private random state.
- Run the block in Lemma 1. Its sensitive action is fair and independent. Its $M$ gate actions are sampled uniformly among all schedules that play $1-\widehat a$ exactly $k$ times and $\widehat a$ exactly $M-k$ times. Use fresh randomness independent of the base.

There are $N=\binom Mk$ equally likely schedules for either value of $\widehat a$. The last base reward, at round $B$, is discarded: it comes after the last action of the base and is not used by the wrapper.

### Theorem 2. Utility-preserving separation, finite parameters

For every such base policy:

**Privacy.** The wrapper is $(\varepsilon,\binom Mk^{-1})$-View-private. No additional multiplicative privacy loss is required.

**Failure of Table privacy.** Some neighboring fixed tables give both directed divergences exactly one at every finite $\kappa\ge1$. Thus the wrapper is not $(\varepsilon',\delta')$-Table-private for any finite $\varepsilon'\ge0$ and any $\delta'<1$.

**Stochastic regret.** On every two-arm Bernoulli instance, writing $R_B=R_B(\mathcal B_B,\nu)$,

$$
R_T(\mathcal W,\nu)
\le\left(1+\frac{2(M-2k)_+}{B}\right)R_B+\Delta(k+1)
\le\left(1+\frac{2M}{B}\right)R_B+\Delta(k+1).
\tag{3}
$$

The conclusion is uniform over the base policies satisfying the stated privacy condition. The wrapper does not know $\mu_0,\mu_1$, $\Delta$, or a lower bound on $\Delta$.

### Proof of privacy at every coordinate

Let $a$ denote the public base action transcript, $p_r(a)$ its probability on the base reward stream, and $W_s^{\operatorname{maj}(a)}(x)$ the challenge-block output law on the later fixed reward stream $s$. The joint full output law is

$$
p_r(a)W_s^{\operatorname{maj}(a)}(x).
\tag{4}
$$

This factorization uses the reset and fresh randomness, and it is valid for every fixed input stream, not only on stochastic inputs.

If neighboring full streams differ in the base portion, then $s$ is the same. Pure View privacy gives $p_r(a)\le e^\varepsilon p_{r'}(a)$ for every $a$; multiplying by the common kernel in (4) proves pure $\varepsilon$ privacy for this coordinate. In particular, any data-dependent choice of the estimate is already accounted for because it is a deterministic function of the public base transcript.

If the changed reward lies in the challenge block, then $p_r$ is the same. Summing over the disjoint public base transcripts gives

$$
\begin{aligned}
&H_{e^\varepsilon}\bigl(p_r(a)W_s^{\operatorname{maj}(a)}(x),
                         p_r(a)W_{s'}^{\operatorname{maj}(a)}(x)\bigr)\\
&\qquad=\sum_a p_r(a)
  H_{e^\varepsilon}(W_s^{\operatorname{maj}(a)},W_{s'}^{\operatorname{maj}(a)})
\le\binom Mk^{-1},
\end{aligned}
$$

by Lemma 1. The block lemma protects arbitrary pairs of block streams, so every challenge coordinate is included. The discarded rewards at rounds $B$ and $T$ have zero influence. This proves the same-$\varepsilon$ statement; applying sequential composition with $2\varepsilon$ would lose a fact supplied by the coordinate-disjoint construction.

This argument does **not** imply an all-pairs fixed-stream guarantee for the entire wrapper: the base is only assumed private for neighboring streams.

### Proof of Table failure

Use any common fixed table on the first $B$ rounds, so the base public transcript has the same distribution in both table experiments. Use Lemma 1's fixed identity gate rows and identity/complement sensitive rows after the base. These rows do not depend on the estimate or on the base transcript. Every schedule chosen after either estimate passes every gate. The last action is identically one versus identically zero. This is a single pair of fixed neighboring tables, not an adaptive table adversary.

### Proof of regret

If $\Delta=0$, every regret is zero. Assume $\Delta>0$. Let $E$ be the event that the public majority estimate is suboptimal. On $E$, at least $B/2$ base actions are suboptimal, including the possible tie. Therefore

$$
\Pr(E)\le\frac{2\mathbb E N_{\mathrm{sub}}(B)}B
         =\frac{2R_B}{B\Delta}.
\tag{5}
$$

The expected number of suboptimal gate actions is exactly

$$
k+(M-2k)\Pr(E).
\tag{6}
$$

The sensitive action costs $\Delta/2$. For completeness, the terminal action also costs at most $\Delta/2$, although a bound of $\Delta$ would suffice for the conclusion. Write $d=\mu_1-\mu_0$ and $p=(1+d)/2$. The probability that the sensitive fair action matches its reward is $p$. The gate-success event depends on the base and the later gate draws and rewards, and is independent of this sensitive action/reward pair. If $g$ is its probability, then

$$
\Pr(A_T=1)=\tfrac12+g(p-\tfrac12),
$$

so the expected terminal reward is $(\mu_0+\mu_1)/2+g d^2/2$. Its expected regret is $\Delta/2-g\Delta^2/2$. Combining this identity, (5), and (6) proves (3). In fact,

$$
R_T=R_B+\Delta\{k+1+(M-2k)\Pr(E)\}-\tfrac12\Delta^2 g.
\tag{7}
$$

The independence used here concerns fresh observations of a fixed stochastic bandit environment. It is not assumed in the privacy proof, which treats arbitrary fixed streams. $\square$

### 5. Vanishing View error with preservation of the leading coefficient

Let the base policies form a horizon-indexed family, and let $L_T=M_T+2$, $B_T=T-L_T$. Choose feasible integer parameters satisfying

$$
L_T=o(T),\qquad k_T=o(\log T).
\tag{8}
$$

On an instance where $R_n(\mathcal B_n,\nu)=O(\log n)$, (3) gives

$$
R_T(\mathcal W_T,\nu)\le R_{B_T}(\mathcal B_{B_T},\nu)+o(\log T).
\tag{9}
$$

Since $\log B_T/\log T\to1$, a leading **upper bound** $\limsup R_n/\log n\le C$ is preserved. If the stronger actual limit $R_n/\log n\to C$ is known, the wrapper has the same limit: its regret is also at least $R_{B_T}$, because every later expected gap is nonnegative. These two claims should not be conflated.

### Explicit scales

For sufficiently large integers $T$, take

$$
L_T=\left\lceil\frac T{\log T}\right\rceil,
\quad M_T=L_T-2,
\quad k_T=\left\lceil\frac{\log T}{\log\log T}\right\rceil.
\tag{10}
$$

The finite theorem applies exactly when $B_T\ge1$ and $0\le k_T\le M_T$; these conditions hold eventually. For useful nontrivial privacy one may impose the stronger explicit check $1\le k_T\le M_T/2$, which also holds eventually. All logarithms in this section are natural.

Using

$$
\left(\frac Mk\right)^k\le\binom Mk\le\left(\frac{eM}k\right)^k
\qquad(1\le k\le M),
$$

we obtain

$$
\log\binom{M_T}{k_T}
=(1+o(1))\frac{(\log T)^2}{\log\log T}.
\tag{11}
$$

The additional regret in (3) is $O(1)+O(\log T/\log\log T)=o(\log T)$. For every fixed $c>0$, the resulting $\delta_T$ is eventually smaller than $T^{-c}$, yet the table defect is one at every horizon for which the finite construction is used.

Another valid choice is $L_T=\lceil T^a\rceil$, $k_T=\lceil\sqrt{\log T}\rceil$, for fixed $0<a<1$. Then

$$
\delta_T=\exp[-(a+o(1))(\log T)^{3/2}],
\qquad R_T-R_{B_T}=o(\log T).
$$

These are horizon-indexed wrappers. No single anytime implementation with the same schedule and all stated rates is claimed.

### 6. A verified external base policy

The final NeurIPS 2025 paper by Azize, Wu, Honda, Orabona, Ito, and Basu [AWH+25] supplies a direct instantiation. Its Proposition 2 proves pure $\varepsilon$-global privacy of DP-IMED and DP-KLUCB for fixed rewards in $[0,1]$. Its Theorem 2, under $\mu^*<1$ and geometric batch ratio $\alpha>1$, gives for a fixed two-arm Bernoulli instance with positive gap

$$
R_n\le \frac{\alpha\Delta}{d_\varepsilon(\mu_{\mathrm{sub}},\mu^*)}\log n
      +o(\log n),
\quad
d_\varepsilon(x,y)=\inf_{z\in[x,y]}\{\varepsilon(z-x)+\operatorname{kl}(z,y)\}.
\tag{12}
$$

Use a fixed $\varepsilon>0$, fixed $\alpha>1$, and, for a conservative direct instance class, $0<\mu_{\mathrm{sub}}<\mu^*<1$. The positive denominator is finite. The wrapper preserves the coefficient in (12) while having the errors in (11) and complete Table separation. The cited theorem supplies a leading upper coefficient for each fixed $\alpha>1$; it is not used here as a theorem that the exact optimal constant is attained at $\alpha=1$.

**Version check.** The May 2025 arXiv v1 is titled *Optimal Regret of Bernoulli Bandits under Global Differential Privacy* and numbers the same privacy/regret statements Proposition 8 and Theorem 9. The published title is *Optimal Regret of Bandits under Differential Privacy*, with Proposition 2 and Theorem 2. The published PDF was directly consulted at the URLs below.

### 7. The initially proposed short-prefix construction

The simpler arrangement also works: put a uniform binary gate block of $L\ge2$ actions before an independently restarted pure-$\varepsilon$ base policy. Here there are $L-2$ gate coordinates, so Lemma 1 gives

$$
\delta_L=2^{2-L}.
\tag{13}
$$

If $m$ instead counts the influential exploration actions, the block has $L=m+1$ actions and this is $2^{-(m-1)}$. This resolves the possible off-by-one ambiguity.

The same-$\varepsilon$ privacy proof follows by the exact product law on fixed streams: a neighboring coordinate changes only one block. The complete table separation survives because the prefix terminal action remains public. The regret satisfies

$$
R_T\le R_{T-L}(\mathcal B,\nu)+L\Delta/2
$$

for two Bernoulli arms, with a nonnegative improvement to this bound from the terminal gate. Taking $L=2+\lceil c\log_2T\rceil$ gives $\delta_L\le T^{-c}$ and $O(\log T)$ regret, but generally adds a nonzero leading regret coefficient. The black-box construction in Sections 4–5 improves this limitation.

The threshold (13) is exact for complete binary Table separation at block length $L$, for every $\lambda\ge1$. The binary theorem gives the bilateral bound $u+v\le2^{L-1}\delta$. A directed defect of one between probability laws implies mutual singularity, hence both defects are one; therefore $\delta\ge2^{2-L}$. Equivalently the affine term in the sharp binary envelope reaches one exactly when $2^{L-1}\delta\ge2$. The threshold does not shrink for $\lambda>1$.

### 8. Why fixed-count random schedules help

For a prescribed gate distribution, Lemma 1 says that the View error of the completely separating block is exactly its maximum atom, or $\exp[-H_\infty(v)]$.

If the better arm were known and exactly $k$ of $M$ gate actions were assigned to the worse arm, uniform random ordering would have regret $k\Delta$ and error $1/\binom Mk$. Independent exploration with probability $k/M$ has the same expected number of worse-arm choices, but for $k\le M/2$ its largest atom is $(1-k/M)^M$. For $k/M\to0$, its logarithm is $-k+O(k^2/M)$; in particular, the atom equals $e^{-k}(1+o(1))$ if $k^2/M\to0$. Fixed-count randomization instead gives maximum atom approximately $k!/M^k$ for fixed $k$. Independence between exploration actions is therefore not optimal for this privacy-separation objective.

The unknown-best-arm obstruction is real: prescribing a mostly fixed arm without estimating it can cause linear regret on the environment where that arm is worse. Theorem 2 resolves precisely this obstruction using the base's public transcript. It pays only the correction in (5), multiplied by a later block of length $o(T)$.

### 9. A separate exact profile for arbitrary reward-independent prefix laws

The following result concerns rich rewards and delayed terminal decisions. It is a structural extension of the uniform-prefix proof; it is not required for Theorem 2.

Fix $K\ge2$, $h\ge1$, an arbitrary distribution $w$ on $\mathcal A^h$, and a reward alphabet containing at least $2K$ symbols. Consider actual causal policies whose first $h$ actions have a prescribed joint law $w$ independent of rewards, followed by one unrestricted reward-dependent terminal action. Correlation between the exploration actions is allowed. With real rewards, the finite-code realization below is Borel measurable.

### Theorem 3. Exact conversion with prescribed exploration law

For $\lambda\ge1$ and $\delta\ge0$, the least universal table error inside this policy class is

$$
\Psi_w(\delta)=\sum_{z\in\mathcal A^h}\min\{w(z),\delta\}.
\tag{14}
$$

An attaining policy protects every pair of fixed streams. Its neighboring witness tables can have any prescribed influential row as their sole differing row.

**Upper bound.** For a prefix $z$, neighboring tables induce two reward streams $r^z,s^z$ differing at at most their changed row. The contribution of outputs with prefix $z$ to their View defect is at most $\delta$, since all other contributions are nonnegative. That contribution is also at most $w(z)$, by normalization and nonnegativity of the conditional terminal laws. The contribution equals the corresponding Table contribution, because the prefix law is reward independent. Sum over $z$. A change only to the final row gives zero.

**Lower bound.** Choose an injection $c:\mathcal A\times\{0,1\}\to\mathcal R$. For $w(z)>0$, let $\eta_z=\min\{1,\delta/w(z)\}$; for zero weight set $\eta_z=0$. Define

$$
a_z=\frac{\eta_z+(\lambda-1)/2}{\lambda+1},\quad
P_z^+=\operatorname{Bern}(1/2+a_z),\quad
P_z^-=\operatorname{Bern}(1/2-a_z),\quad C=\operatorname{Bern}(1/2).
$$

Then $0\le a_z\le1/2$, both directed defects between $P_z^+,P_z^-$ equal $\eta_z$, and both directed defects between either law and $C$ are at most $\eta_z/2$, by the midpoint argument.

Sample the prefix according to $w$, independently of rewards. At the terminal action, use $P_z^+$ or $P_z^-$ if every reward is a valid code whose action label matches the corresponding action in $z$, with sign given by the code bit at the prescribed sensitive row. Otherwise use $C$. For any fixed stream, at most one prefix is activated. If two streams activate the same prefix, their defect is at most $w(z)\eta_z\le\delta$. If they activate different prefixes, the defect is at most

$$
\tfrac12 w(z)\eta_z+\tfrac12w(z')\eta_{z'}\le\delta.
$$

Invalid streams only remove an active prefix and obey the same bound. The terminal laws use two designated actions, with zero probability on all others.

For witness tables, use $c(a,0)$ at all nonsensitive rows, and $c(a,1)$ versus $c(a,0)$ at the sensitive row. Every prefix activates; the terminal laws are $P_z^+$ versus $P_z^-$. The table defect is therefore $\sum_z w(z)\eta_z=\Psi_w(\delta)$.

Every finite joint law $w$ is causally realizable by its next-action conditional probabilities, using arbitrary distributions on zero-mass partial prefixes. Thus realizability is part of the construction, not an additional hypothesis. $\square$

Uniform $w$ on $N$ supported prefixes gives $\min\{N\delta,1\}$. In general, saturation occurs exactly at $\delta\ge\max_z w(z)$. This statement is restricted to the specified reward-independent exploration class and a rich enough alphabet; it is not a formula for arbitrary reward-dependent policies or arbitrary finite alphabets.

### An exact exploration-cost optimization inside this class

Let $c_z$ be the deterministic regret cost of exploration prefix $z$, with the means supplied for the purpose of this optimization. To permit complete separation at View error $\delta$, (14) requires and suffices that $w(z)\le\delta$ for all $z$. Therefore the smallest exploration cost is the finite linear program

$$
\min\left\{\sum_z c_z w(z):\sum_z w(z)=1,\ 0\le w(z)\le\delta\right\}.
\tag{15}
$$

Order the $N$ prefix costs as $c_1\le\cdots\le c_N$. For $\delta\in[1/N,1]$, put $q=\lceil1/\delta\rceil$. An optimizer fills the $q-1$ cheapest prefixes with mass $\delta$, puts mass $1-(q-1)\delta$ on the next, and puts zero on the rest. Its value is

$$
\delta\sum_{i=1}^{q-1}c_i+[1-(q-1)\delta]c_q.
\tag{16}
$$

An exchange of mass from a more expensive occupied prefix to a cheaper unsaturated prefix proves optimality. This is a known-means design calculation, not an unknown-means learning algorithm. The public-estimate argument in Theorem 2 is the separate device that yields an unknown-instance low-regret guarantee.

### 10. Limits and value of the extension

- The black-box theorem is about two Bernoulli arms and a fixed-table privacy interface. It makes no claim about general adaptive-adversary privacy or arbitrary numbers of arms.
- The whole wrapper has the neighboring-stream View guarantee. Its challenge block has an all-stream guarantee, but the base need not.
- The transformation retains the base's first-order regret upper coefficient under the stated schedules; it need not preserve finite-horizon lower-order constants or regret on adversarial environments.
- A complete table failure on worst-case deterministic tables is compatible with excellent average stochastic regret. This establishes that leading stochastic performance alone cannot repair the View/Table distinction. It does not establish a minimax utility gap between the best algorithms in the two privacy classes.
- These constructions intentionally introduce a privacy failure. They are mathematical witnesses for a class separation, not recommended algorithm modifications.
- The fixed-count schedule and public-estimate argument supply an additional mathematical reason for the separation beyond a constant-size padding observation. Whether this extension, together with the frozen classification, meets the requested academic-value threshold requires the separate value review.
- No absence-of-prior-art or global-priority claim follows from the targeted primary-source checks. Further review is needed before a publication-level novelty assertion.

### 11. Exact finite verification

The companion `utility_bridge_verify.py` uses exact rational arithmetic and directly enumerates the finite output laws. Its recorded successful run covers 88 gate-law/factor cases and 9,088 ordered fixed-stream pairs, four concrete wrappers and all 5,376 directed neighboring full-stream pairs, 16 table-witness/factor checks, 180 directly enumerated Bernoulli regret identities, and 80 prescribed-prefix rich-reward cases with 4,400 ordered induced-law pairs. The wrapper check includes a nontrivial pure-$\log2$ randomized-response base and the public-majority-dependent schedule. The results are recorded in `utility_bridge_verification.json` with source hashes. They do not replace the universal proofs or certify the external base regret analysis.

### References and source checks

**[AB24]** Achraf Azize and Debabrota Basu. *Concentrated Differential Privacy for Bandits.* arXiv:2309.00557v3, 2024. Definition 3, Proposition 1, and the discussion of View/Table conversion. Primary full text: <https://arxiv.org/html/2309.00557v3>.

**[AWH+25]** Achraf Azize, Yulian Wu, Junya Honda, Francesco Orabona, Shinji Ito, and Debabrota Basu. *Optimal Regret of Bandits under Differential Privacy.* NeurIPS 2025. Final published Proposition 2 (PDF page 8), Theorem 2 (PDF page 9), and Appendix E. Primary publication record: <https://proceedings.neurips.cc/paper_files/paper/2025/hash/a70522d112322111cbf19c69e927eaf2-Abstract-Conference.html>. Primary full PDF: <https://proceedings.neurips.cc/paper_files/paper/2025/file/a70522d112322111cbf19c69e927eaf2-Paper-Conference.pdf>. Earlier arXiv version, with different title and numbering: <https://arxiv.org/html/2505.05613v1>.

The external source is used only for the base privacy/regret statement. Lemmas 1 and Theorems 2–3, their proofs, and the parameter choices are deductions in this research note. The frozen manuscript's binary envelope is used in Section 7 solely to identify the optimal short-block saturation threshold.


## Appendix C. Sharp finite-positive parameters for three reward symbols

### Status and scope

This is a separate extension of the frozen results A–C. It is not part of their Lean-certified scope. The argument below proves a complete two-round classification for two actions, three reward symbols, and hockey-stick parameter $\lambda=2$. Its finite certificates have been verified independently with exact rational arithmetic. The independent internal mathematical review is recorded separately; no external peer review is claimed.

The parameter is $\delta\in[0,1]$. Action and reward symbols can be renamed by arbitrary bijections, so the theorem applies to any specified alphabets of sizes two and three. The policy is causal, both actions are released, and both rewards can be retained as inputs: the second reward is unused by causality. All fixed-stream pairs are protected by the attaining policy.

### 1. The exact answer

For distributions on a finite set, write

$$
H_2(P,Q)=\sum_x [P(x)-2Q(x)]_+.
$$

Consider every two-round causal policy with action alphabet $\{0,1\}$ and reward alphabet $\{0,1,2\}$. Suppose its released-action distribution satisfies

$$
H_2(P_r,P_s)\le\delta\qquad(r,s\in\{0,1,2\}),
\tag{1}
$$

where $r$ is the fixed first reward. Then every ordered neighboring table pair satisfies

$$
H_2(P_D,P_E)\le F(\delta),\qquad
\boxed{F(\delta)=\min\left\{2\delta,\frac7{12}+\frac23\delta,1\right\}.}
\tag{2}
$$

For every $\delta\in[0,1]$, one actual policy and a strictly different first-row table pair attain equality. The same policy satisfies (1) for all six ordered distinct reward pairs; the unused second reward can differ arbitrarily.

Equivalently,

$$
F(\delta)=
\begin{cases}
2\delta,&0\le\delta\le7/16,\\
7/12+2\delta/3,&7/16\le\delta\le5/8,\\
1,&5/8\le\delta\le1.
\end{cases}
\tag{3}
$$

This frontier is concave. Its successive slopes are $2,2/3,0$. An early nonconcavity conjecture was disproved during certificate refinement; it is recorded only in `research_log.md`.

### Why the original full interface reduces to (1)

There is only one influential reward in two rounds. Changing the final reward changes no released action law. Conversely, every pair of first-reward symbols can occur in adjacent full streams by fixing the same final reward. Therefore adjacent-stream View privacy in the full interface is equivalent to (1), which in this two-round setting also implies privacy for arbitrary full fixed-stream pairs.

A table's influential first row is a function from two first actions to three reward symbols. Two such rows give two directed edges $(d_a,e_a)$, one for each disclosed first action $a$. If only the unused final table row changes, the table defect is zero. Thus the first-row edge model covers all table neighbors, including strict changes and zero-loss cases.

### 2. An explicit attaining causal policy

Draw the first action uniformly. Conditional on first action $a$ and observed reward $r$, choose terminal action 1 with probability $2x_{ar}$, where

$$
(x_{ar})=
\begin{pmatrix}
u&0&v\\
u&v&0
\end{pmatrix}.
\tag{4}
$$

Here $x_{ar}$ is the joint mass of the first action $a$ and terminal action 1, rather than a conditional probability. Set

| Budget interval | $u$ | $v$ |
|---|---:|---:|
| $[0,7/16]$ | $\delta$ | $5\delta/7$ |
| $[7/16,5/8]$ | $7/24+\delta/3$ | $1/6+\delta/3$ |
| $[5/8,1]$ | $1/2$ | $3/8$ |

Every entry lies in $[0,1/2]$, so this is a valid actual policy. The formulas agree at both breakpoints. The policy does not inspect the second reward.

Choose the first table rows

$$
D=(0,0),\qquad E=(1,2),
$$

and give both tables the same unused second row. Under $E$, terminal action 1 has probability zero in both first-action blocks. Under $D$, its total mass is $2u$. The complementary atom differences are nonpositive, hence

$$
H_2(P_D,P_E)=P_D(A_2=1)-2P_E(A_2=1)=2u=F(\delta).
\tag{5}
$$

The first rows are strictly different even at $\delta=0$, where the attaining defect is zero.

### Exact verification of all fixed-stream directions

For a block of mass $1/2$, put

$$
h(x,y)=\max\{0,x-2y,-1/2-x+2y\}.
$$

For (4), let $D_{rs}=H_2(P_r,P_s)$. Direct expansion gives

$$
\begin{aligned}
D_{01}=D_{02}&=u+h(u,v),\\
D_{10}=D_{20}&=[2u-1/2]_++[2u-v-1/2]_+,\\
D_{12}=D_{21}&=v+[2v-1/2]_+.
\end{aligned}
\tag{6}
$$

In the middle interval, $h(u,v)=0$, the first pair equals $u\le\delta$, and each of the other four directions equals $\delta$. At $\delta=5/8$, the six values are $1/2,1/2,5/8,5/8,5/8,5/8$, in the order displayed in (6); the same law is feasible for every larger budget.

On the first interval, (4) is the affine interpolation of its law at $\delta=0$ and its law at $\delta=7/16$. Each directed hockey-stick defect is a sum of positive parts of affine functions and therefore is convex in this interpolation parameter. The endpoint values satisfy (1), so all intermediate budgets do as well. Equivalently, insert $u=\delta,v=5\delta/7$ in (6); the resulting inequalities hold on the whole interval. The independent verifier checks the endpoint laws and the exact affine parameterization, without numerical sampling.

### 3. Exact reduction to a finite linear program

### 3.1 Action-dependent terminal events lose no objective

For a fixed ordered table pair, choose, in each disclosed first-action block, the terminal outcomes with positive $P_D-2P_E$. Map the terminal action to the indicator of this chosen event, separately in each first-action block. This is a deterministic postprocessing of the released transcript. For every fixed-stream pair, it cannot increase the sum of positive differences: for any group of atoms, the positive part of their sum is at most the sum of their positive parts.

For the designated table pair this postprocessing preserves the defect exactly. A block's chosen event has nonnegative signed difference; its complement has nonpositive signed difference. Since there are only two terminal actions, the indicator is again a valid terminal action on the same two-element action alphabet. Empty events and zero first-action weights are included.

Let $w_a$ be the first-action mass, and let $x_{ar}$ be the joint mass of block $a$ and the chosen terminal event when the reward is $r$. Causality gives the same $w_a$ for every reward. The probability constraints are precisely

$$
w_a\ge0,\quad w_0+w_1=1,\quad0\le x_{ar}\le w_a.
\tag{7}
$$

For each ordered pair $r\ne s$, introduce $z_{a,rs}\ge0$, with

$$
\begin{aligned}
x_{ar}-2x_{as}&\le z_{a,rs},\\
-w_a-x_{ar}+2x_{as}&\le z_{a,rs},\\
z_{0,rs}+z_{1,rs}&\le\delta.
\end{aligned}
\tag{8}
$$

The two atom differences in a block sum to $-w_a\le0$, so at most one is positive. Consequently the block defect is exactly the maximum of zero and the first two left sides in (8). A single $z_{a,rs}$ bounded below by those three values therefore gives an exact epigraph, not a relaxation.

For ordered witness edges $G=((d_0,e_0),(d_1,e_1))$, maximize

$$
L_G=\sum_{a=0}^1(x_{a,d_a}-2x_{a,e_a}).
\tag{9}
$$

Every actual policy and table witness maps to a feasible point with (9) equal to its table defect. Conversely, every feasible point defines an actual causal policy by first-action probabilities $w_a$ and terminal event probability $x_{ar}/w_a$ when $w_a>0$. If $w_a=0$, all $x_{ar}=0$, and the unused conditional law can be chosen arbitrarily. Its actual table defect is at least (9). Taking maxima in both directions proves equality between the LP optimum and the actual-policy optimum for a fixed graph. No sign assumption on arbitrary feasible LP objectives is needed for that equivalence.

### 3.2 Loops, duplicates, and orientations

A loop $d_a=e_a$ contributes zero to the table defect. After choosing its maximizing event, that block may be made constantly zero for every reward, which preserves its zero table contribution and contracts all View defects. Its witness edge can then be changed to any nonloop edge without changing its law or objective.

If both nonzero blocks have the same directed witness edge, first perform the event reduction above. Their event differences are individually nonnegative. Merge the disclosed first-action blocks, adding their joint event masses and their weights. The merged event difference is exactly their sum and the merged complement difference remains nonpositive, so the table defect is preserved. Merging is postprocessing for every fixed-stream pair and hence preserves the privacy upper bound. Implement the merged law on one action, give the other action weight zero, and assign the latter any different nonloop witness edge.

It is therefore sufficient, without loss for the global optimum, to study two distinct nonloop directed edges. Of the six possible directed edges on three symbols, there are fifteen unordered two-edge subsets. Relabeling rewards and exchanging first-action blocks gives exactly these four types:

| Type | Representative edges | Number of labeled unordered graphs |
|---|---|---:|
| Outgoing star | $0\to1,\ 0\to2$ | 3 |
| Reciprocal pair | $0\to1,\ 1\to0$ | 3 |
| Directed path | $0\to1,\ 1\to2$ | 6 |
| Incoming star | $0\to1,\ 2\to1$ | 3 |

No reversal of all edges is assumed to preserve the objective. In particular, incoming and outgoing stars remain distinct. Including loops and repeated edges gives 81 ordered edge pairs: 45 have a loop, 6 repeat a nonloop edge, and 30 are ordered versions of the fifteen distinct-edge graphs. The verifier independently enumerates these counts and all reward permutations.

### 4. Short dual proofs of the upper bounds

Write $a_r=x_{0r}$, $b_r=x_{1r}$, and $D_{rs}=z_{0,rs}+z_{1,rs}\le\delta$. Every graph has the immediate bounds

$$
L_G\le2\delta,\qquad L_G\le w_0+w_1=1.
\tag{10}
$$

For the first bound, dominate each selected block difference by its $z$ and then by the corresponding $D$. For the second, use $x_{a,d_a}\le w_a$ and $x_{a,e_a}\ge0$.

The following weighted inequalities supply every nontrivial affine face:

$$
\begin{aligned}
L_{\rm out}+\tfrac32(a_1+b_2)
&\le\tfrac7{12}+\tfrac14(D_{10}+D_{20})+\tfrac1{12}(D_{12}+D_{21}),\tag{11}\\
L_{\rm reciprocal}+a_1+b_0
&\le\tfrac13+\tfrac13(D_{01}+D_{10}),\tag{12}\\
L_{\rm path}+\tfrac56a_1+\tfrac43b_2
&\le\tfrac12+\tfrac16(D_{01}+D_{02}+D_{10})+\tfrac13D_{21},\tag{13}\\
L_{\rm path}+a_1+\tfrac32b_2
&\le\tfrac7{12}+\tfrac14(D_{01}+D_{21})+\tfrac1{12}(D_{02}+D_{20}),\tag{14}\\
L_{\rm in}
&\le\tfrac16+\tfrac12(D_{01}+D_{21})+\tfrac16(D_{02}+D_{20}).\tag{15}
\end{aligned}
$$

All extra terms on the left are nonnegative. These are elementary sums of (7)–(8), with no appeal to a numerical optimizer. To make their derivation directly checkable, define the primitive left sides

$$
U_a(rs)=a_r-2a_s,\quad V_a(rs)=-w_0-a_r+2a_s,\quad E_a(r)=a_r-w_0,
$$

and define $U_b,V_b,E_b$ analogously. Every $U$ and $V$ is bounded by its matching $z$, and every $E\le0$. Add the following expressions and divide by the displayed denominator:

| Inequality | Weighted primitive sum | Denominator |
|---|---|---:|
| (11) | $3V_a(10)+V_a(12)+3V_a(20)+U_a(21)+3V_b(10)+U_b(12)+3V_b(20)+V_b(21)$ | 12 |
| (12) | $U_a(01)+V_a(10)+V_b(01)+U_b(10)$ | 3 |
| (13) | $2E_a(0)+U_a(01)+U_a(02)+V_a(10)+2U_a(21)+V_b(01)+U_b(02)+2V_b(21)$ | 6 |
| (14) | $6E_a(0)+3U_a(01)+U_a(02)+V_a(20)+3U_a(21)+3V_b(01)+U_b(02)+V_b(20)+3V_b(21)$ | 12 |
| (15) | $3U_a(01)+U_a(02)+V_a(20)+3U_a(21)+3U_b(01)+V_b(02)+U_b(20)+3U_b(21)$ | 6 |

Use $w_0+w_1=1$. For (13), also use $z_{0,10}\le D_{10}$; the exact nonnegative residual includes $z_{1,10}/6$. The semantic certificate contains precisely these multipliers and their full residual vectors.

The outgoing star and the path satisfy the middle bound in (2) directly by (11) and (14). The reciprocal bound (12) is stronger because $1/3<7/12$. For the incoming star, average (15), after replacing $D$ by $\delta$, with $L_{\rm in}\le1$:

$$
L_{\rm in}\le\tfrac12\left(\tfrac16+\tfrac43\delta\right)+\tfrac12
=\tfrac7{12}+\tfrac23\delta.
$$

Together with (10), this proves the global upper bound (2). Section 2 supplies an attaining policy, completing the original-model theorem.

### 5. Complete classification of the four graph LPs

The exact graph optima are

$$
\begin{array}{ll}
F_{\rm out}(\delta)&=\min\{2\delta,\ 7/12+2\delta/3,\ 1\},\\
F_{\rm reciprocal}(\delta)&=\min\{2\delta,\ 1/3+2\delta/3\},\\
F_{\rm path}(\delta)&=\min\{2\delta,\ 1/2+5\delta/6,\ 7/12+2\delta/3,\ 1\},\\
F_{\rm in}(\delta)&=\min\{2\delta,\ 1/6+4\delta/3,\ 1\}.
\end{array}
\tag{16}
$$

Their internal breakpoints are respectively $(7/16,5/8)$, $(1/4)$, $(3/7,1/2,5/8)$, and $(1/4,5/8)$. The extra path face after $\delta=1/2$ is essential.

For completeness, the following actual joint-mass laws attain every nontrivial breakpoint. Each row lists $w_0$; $w_1=1-w_0$. The triples are $(a_0,a_1,a_2)$ and $(b_0,b_1,b_2)$.

| Graph | $\delta$ | $w_0$ | $a$ | $b$ | Table defect |
|---|---:|---:|---|---|---:|
| Outgoing | $7/16$ | $1/2$ | $(7/16,0,5/16)$ | $(7/16,5/16,0)$ | $7/8$ |
| Outgoing | $5/8$ | $1/2$ | $(1/2,0,3/8)$ | $(1/2,3/8,0)$ | 1 |
| Reciprocal | $1/4$ | $1/2$ | $(1/4,0,0)$ | $(0,1/4,1/8)$ | $1/2$ |
| Path | $3/7$ | $3/7$ | $(3/7,0,1/7)$ | $(2/7,3/7,0)$ | $6/7$ |
| Path | $1/2$ | $1/2$ | $(1/2,0,1/6)$ | $(1/3,5/12,0)$ | $11/12$ |
| Path | $5/8$ | $1/2$ | $(1/2,0,1/8)$ | $(3/8,1/2,0)$ | 1 |
| Incoming | $1/4$ | $1/2$ | $(1/4,0,0)$ | $(0,0,1/4)$ | $1/2$ |
| Incoming | $5/8$ | $1/2$ | $(1/2,0,1/8)$ | $(1/8,0,1/2)$ | 1 |

At $\delta=0$, use $w=(1,0)$ and all event masses zero. At $\delta=1$, all four chosen representatives can use $w=(1,0)$, $a=(1,0,1/2)$, $b=(0,0,0)$, with objective 1. Thus the table and these common endpoint laws give sixteen endpoint certificates.

For each interval in (16), interpolate the two endpoint joint laws and weights. Nonnegativity and normalization remain valid. Every fixed-stream hockey-stick defect is convex under this interpolation, hence stays below the interpolated budget. The linear witness objective interpolates exactly between the matching endpoint values. The corresponding dual bound is affine on the whole interval. Therefore the endpoint certificates and the dual inequalities prove (16) for every real budget in the interval, including irrational budgets.

The outgoing star dominates the other graph curves pointwise; Sections 2 and 4 already prove this without relying on a plotted envelope.

### 6. Reproducible evidence and limitations

Run the independent checker with the Python standard library:

```bash
python verify_exact_certificate.py --self-test
```

The checked semantic certificate is `lambda2_q3_K2_certificate.json`. The output `lambda2_q3_K2_verification.json` records:

- All four graph classes and all 81 ordered witness-edge cases, with the written reduction handling loops and duplicates.
- Sixteen exact endpoint laws and 96 directed endpoint privacy checks.
- Twelve nonnegative dual multiplier certificates; eight certified endpoint laws have a zero-weight action block.
- The three affine pieces of the explicit actual policy (4).
- Six negative controls rejecting a corrupt dual, an invalid probability, a missing orientation class, a wrong global face, the omitted path-facet correction, and a law that passes the two outgoing privacy checks but violates a reverse direction.

The checker imports neither the optimizer nor its matrix builder. It reconstructs constraints from semantic names, verifies primal channels directly as four-atom released-action distributions, and computes only with `fractions.Fraction`. SciPy was used to discover candidates, not to validate the final inequalities. The hand proof in Sections 3–5 supplies the original-policy reduction and the real-parameter interpolation argument.

The extension does not classify general $\lambda>1$, general finite $q$, or longer horizons. It does establish a complete positive-epsilon instance with a nontrivial intermediate affine regime and an orientation-sensitive graph classification. At $\delta=1/2$, for example, the ternary optimum is $11/12$, between the already established binary optimum $2/3$ and the unrestricted-reward optimum 1. No claim about the novelty of this extension or the overall work's doctoral-thesis quality is inferred solely from these certificates; those require independent literature and value review.


## Appendix D. Optimal time exponent with bounded utility loss

This appendix establishes the sharp time exponent via a finite private test and a pause-and-resume transformation of a base bandit policy.

### 1. Result and scope

A two-arm pure-private bandit algorithm can be transformed into an approximate-View-private algorithm with nearly complete Table privacy failure, while preserving its leading stochastic-regret coefficient. The View error has the optimal exponential rate:

$$
\delta_T=2^{-T+O(\log^2T)},
\qquad H_{e^\varepsilon}(M_{D_T},M_{E_T})\longrightarrow1.
\tag{1}
$$

The algorithm does not know the reward means or their gap. It runs a base algorithm for a short initial segment, performs a private test that rarely triggers on stationary Bernoulli rewards, and normally resumes the saved base state. On a worst-case fixed table, the test triggers with probability approaching one and enables a long binary disclosure gate.

The comparison with the base is precise. If the base is configured for $N=T-O(\log T)$ internal rounds, then on every fixed Bernoulli instance on which its regret is $O(\log N)$,

$$
R_T(\text{wrapper},\nu)=R_N(\text{base},\nu)+O(1).
\tag{2}
$$

This preserves a leading upper coefficient, or an actual leading limit when the base has one. It does not assert a constant additive difference from the same base configured for $T$ rounds: an arbitrary horizon-dependent family need not have that regularity.

The privacy interface uses fixed streams and fixed neighboring tables, with all actions released and action-before-reward timing. The construction is a horizon-indexed family. Section 10 proves why a single projectively consistent anytime policy with fixed $\varepsilon$ and View errors tending to zero cannot exhibit the proposed separation.

### 2. Parameters and a finite private test

There are two actions and binary rewards, both labeled $0,1$. Write

$$
H_\lambda(P,Q)=\sum_x[P(x)-\lambda Q(x)]_+,
\quad \lambda=e^\varepsilon,
\quad \varepsilon>0.
$$

Fix a number $r$ satisfying

$$
1<r\le\min\{e^\varepsilon,2\}.
\tag{3}
$$

One may choose a fixed rational $r$ strictly between one and this upper endpoint. Thus the new randomization can be a finite kernel with rational probabilities. Its use does not require sampling continuous noise.

Let $m\ge1$ be an integer and $P=4m$. Prespecify an alternating target string $c_1,\ldots,c_P$, with exactly $P/2$ zeros and $P/2$ ones. For a pilot reward string $x$, define

$$
S(x)=\sum_{i=1}^P\mathbf1\{x_i=c_i\},
\quad
t_s=\frac{r^s}{r^s+r^{3m}}\quad(0\le s\le P).
\tag{4}
$$

Generate one flag $F$ with $\Pr(F=1\mid x)=t_{S(x)}$. The flag is then encoded by one public action. Define

$$
p_m=t_P=\frac{r^m}{1+r^m},
\qquad \beta_r=\frac{(1+r)^4}{16r^3}.
\tag{5}
$$

### Lemma 1. Test privacy and its two operating regimes

The flag mechanism is pure $\log r$-private under replacement of one pilot reward. Its largest probability of outputting one on a fixed binary input string is $p_m$.

If the pilot samples are independent $\operatorname{Ber}(\mu)$ rewards for any fixed $\mu\in[0,1]$, then

$$
\Pr(F=1)\le\beta_r^m,
\qquad 0<\beta_r<1,
\qquad 1-p_m\le\beta_r^m.
\tag{6}
$$

**Proof.** Replacing one input changes the integer score by at most one. Directly,

$$
\frac{t_{s+1}}{t_s}
=\frac{r(r^s+r^{3m})}{r^{s+1}+r^{3m}}\le r,
\quad
\frac{1-t_s}{1-t_{s+1}}
=\frac{r^{s+1}+r^{3m}}{r^s+r^{3m}}\le r.
$$

The ratios in the other directions are at most one. Both flag outcomes therefore satisfy the pure privacy inequalities. The score is at most $P$, $t_s$ is increasing, and the target string itself attains score $P$, proving the maximum assertion.

For the stochastic bound, pair a zero target with a one target. The generating function of their two match indicators is

$$
(1-\mu+\mu r)(\mu+(1-\mu)r)
=r+\mu(1-\mu)(r-1)^2
\le\frac{(1+r)^2}{4}.
$$

Independence and the balanced targets imply

$$
\mathbb E r^S\le\left(\frac{1+r}{2}\right)^{4m}.
$$

Since $t_s\le r^{s-3m}$, this gives $\Pr(F=1)\le\beta_r^m$. To verify strict contraction, use

$$
16r^3-(1+r)^4
=(r-1)(-r^3+11r^2+5r+1)>0
$$

for $1<r\le2$; the second factor is at least $9r^2+5r+1$. Finally, $(1+r)^2\ge4r$ gives $\beta_r\ge1/r$, and therefore

$$
1-p_m=\frac1{1+r^m}\le r^{-m}\le\beta_r^m.
$$

This is a finite generating-function proof; no simulated noise or concentration approximation is used. $\square$

The test is not asserted to recognize all nonstationary inputs. Only its uniform small trigger probability on stationary Bernoulli samples and its large trigger probability on one explicit fixed input are needed.

### 3. The causal pause-and-resume algorithm

Fix integers $B\ge1$, $L\ge0$, and $m\ge1$. Set

$$
P=4m,\quad N=B+L+2,\quad T=N+P+1=B+P+L+3.
\tag{7}
$$

Let $\mathcal A_N$ be any $N$-round causal two-arm policy that is pure $\varepsilon$-View-private for every fixed binary reward stream. The base may have private state and correlated internal randomness. Its internal round counter will be paused together with its state.

The wrapper executes the following steps, whose physical time boundaries are fixed in advance.

1. **Base prefix, rounds $1,\ldots,B$.** Run the first $B$ internal rounds of $\mathcal A_N$. Collect reward $R_B$ as usual and retain the entire base state needed to resume internal round $B+1$. Let $J$ be the most frequent arm in the public action prefix, with a fixed tie rule.
2. **Pilot, rounds $B+1,\ldots,B+P$.** Pause the base, including its internal clock. Play arm $J$ in every pilot round. Record the match score against the predetermined balanced target string. Do not feed these rewards or actions to the base.
3. **Flag, round $B+P+1$.** Draw $F$ by (4), using fresh randomness, and take action $F$, thereby publishing the flag. Ignore this round's reward.
4. **Suffix, rounds $B+P+2,\ldots,T$.** If $F=0$, resume the saved base state for its remaining $L+2$ internal rounds, without supplying it the pilot or flag observations. If $F=1$, discard the saved state and run the following independent binary block of $L+2$ actions.
5. **Challenge block on $F=1$.** Its first action $U$ is a fair bit; store its reward $s$. Its next $L$ actions are independent fair bits, sampled independently of all preceding random choices. A gate succeeds when each of these $L$ rewards equals the action that selected it. At the terminal action, output $\mathbf1\{U=s\}$ if the gate succeeded, and a fresh fair bit otherwise. Ignore the final reward.

Every action in every stage is released. No random seed, noisy score, or hidden base state is released. The public flag is essential to the exact Table calculations below.

### 4. Exact fixed-stream law and privacy

For a fixed full reward stream $x\in\{0,1\}^T$, delete the pilot and flag coordinates to obtain the projected base stream

$$
x^{\mathrm{base}}
=(x_1,\ldots,x_B,x_{B+P+2},\ldots,x_T)\in\{0,1\}^N.
\tag{8}
$$

In particular, reward $x_B$ is retained by the base, whereas the flag reward is discarded. Let $Q_x(a,z)$ be the law of the **complete latent baseline output** on this projected stream, split into its first $B$ actions $a$ and last $L+2$ actions $z$. Let $q_x(a)=\sum_zQ_x(a,z)$ be its prefix marginal. Let $C_s(z)$ be the challenge-block law on the fixed suffix reward stream $s$.

The pilot action string is determined by $a$. Thus the full public output can be represented injectively by $(a,f,z)$; the omitted repeated pilot actions can be reconstructed from $a$. Put $\theta_x=t_{S(x_{\mathrm{pilot}})}$. Then the wrapper law is exactly

$$
W_x(a,0,z)=(1-\theta_x)Q_x(a,z),
\qquad
W_x(a,1,z)=\theta_x q_x(a)C_s(z).
\tag{9}
$$

This identity includes saved private state. On $F=0$, pausing and resuming produces the same base path as running the base directly on (8). On $F=1$, the future latent base path is not released and is marginalized out. Crucially, for a **fixed reward stream** the pilot score depends only on its fixed pilot rewards and fixed target string; it does not depend on $J$ or the hidden base state. Therefore the flag weights in (9) are scalars, independent of the latent base path. The challenge uses fresh randomness.

The challenge law satisfies, for every $\kappa\ge1$,

$$
\max_{s,s'}H_\kappa(C_s,C_{s'})=2^{-L},
\tag{10}
$$

and an adjacent pair already attains this maximum. One proof is the gate lemma in `utility_bridge.md`: condition on the uniform gate-action vector, which has $2^L$ possibilities. At the single vector matching a fixed gate-reward string the sensitive-action/terminal-action pair has one of two mutually singular laws; elsewhere it has their common midpoint. Equal gates cost at most $2^{-L}$; different gates cost at most two half contributions. Flipping only the sensitive reward at the same gate gives equality.

### Theorem 2. Exact View error with no multiplicative composition loss

The wrapper is $(\varepsilon,p_m2^{-L})$-View-private. Moreover,

$$
\max_{x\sim x'}H_{e^\varepsilon}(W_x,W_{x'})=p_m2^{-L}.
\tag{11}
$$

In particular, $2^{-L}$ is a valid larger View budget. The same exact maximum holds at every fixed factor $\kappa\ge e^\varepsilon$.

**Proof.** Let $\lambda=e^\varepsilon$. We partition the possible changed input coordinate.

**A coordinate among the first $B$ rewards.** The projected base streams are adjacent, the pilot weights are equal, and the challenge reward stream is equal. Pure base privacy gives $Q_x\le\lambda Q_{x'}$ pointwise and hence $q_x\le\lambda q_{x'}$. Each branch of (9) obeys the pure privacy inequality, so the defect is zero.

**A pilot coordinate.** The projected base stream and challenge stream are equal; only $\theta_x$ changes. Lemma 1 gives the two inequalities $\theta_x\le\lambda\theta_{x'}$ and $1-\theta_x\le\lambda(1-\theta_{x'})$. Multiplication by the common branch laws in (9) again gives zero defect. No private conditional law of the base is being assumed here.

**The ignored flag reward.** All quantities in (9) agree, so the defect is zero.

**A suffix coordinate.** The projected base streams are adjacent, so the $F=0$ branch has zero defect by pure base privacy. By causality the prefix marginals are identical, $q_x=q_{x'}$, and the pilot weights are equal. Because the public flag separates the two branches,

$$
H_\lambda(W_x,W_{x'})
=\theta_x\sum_aq_x(a)H_\lambda(C_s,C_{s'})
\le p_m2^{-L}.
$$

The final reward is ignored by both possible suffix policies and gives zero. These cases prove the upper bound at every coordinate, including the retained reward at round $B$.

For equality, set the fixed pilot stream equal to its target string, giving $\theta_x=p_m$. Choose any common base reward prefix and a fixed gate-reward string, and change only the first, sensitive, suffix reward. Equation (10) is attained; the $F=0$ branch still has zero defect. Thus equality holds in (11). The same proof works for every $\kappa\ge\lambda$, because pure $\lambda$ privacy implies pure $\kappa$ privacy. $\square$

This proof does not claim that arbitrary conditioning preserves differential privacy. It uses the complete base law in (9); the only marginal equality invoked for a suffix change follows directly from causality.

### 5. One fixed neighboring Table witness

Choose any common table for the first $B$ rounds. At pilot round $i$, assign reward $c_i$ to **both** actions in both tables. Give the flag round the same arbitrary row. At the first suffix round use the identity row $a\mapsto a$ in table $D$ and the complement row $a\mapsto1-a$ in table $E$. At every gate round use the identity row in both tables. Give the final round a common arbitrary row.

These are fixed tables differing in exactly one row. Their entries do not depend on the majority estimate, hidden state, random seed, flag, or future actions. On either table every pilot match succeeds, so the flag probability is exactly $p_m$, independently of the entire base path.

On $F=1$, every gate succeeds. The terminal action is deterministically one under $D$ and zero under $E$. On $F=0$, however, the resumed base may observe the changed suffix reward. This branch is **not asserted to have identical laws**.

Let $D^0,E^0$ be the neighboring $N$-row tables obtained by deleting the pilot and flag rows, and write $M^{\mathcal A}_{D^0},M^{\mathcal A}_{E^0}$ for the base table laws. The repeated pilot actions are a deterministic function of the public base prefix, so embedding them preserves defects. The public flag then yields the exact identity, for every finite $\kappa\ge1$,

$$
H_\kappa(M_D^W,M_E^W)
=p_m+(1-p_m)H_\kappa(M^{\mathcal A}_{D^0},M^{\mathcal A}_{E^0}).
\tag{12}
$$

The reversed identity holds too. Hence both wrapper defects are at least $p_m$ for every finite $\kappa\ge1$.

For $\kappa\ge e^\varepsilon$, both defects are **exactly** $p_m$. Indeed, pure View privacy implies pure Table privacy for the base [AB24, Proposition 1]. A short direct proof is also useful: for each full action path, the two fixed tables induce adjacent fixed reward streams along that path; their path probabilities agree with the corresponding View path probabilities. Apply the pure View inequality pointwise and sum over action paths. Thus the baseline term in (12) vanishes for $\kappa\ge e^\varepsilon$.

This distinguishes the factors correctly: no exact-$p_m$ claim is made for $1\le\kappa<e^\varepsilon$.

### 6. Stochastic regret with retained state

Fix a stationary two-arm Bernoulli instance $\nu$, with means $\mu_0,\mu_1$, optimum $\mu^*$, and gap $\Delta=|\mu_1-\mu_0|$. Let $R_N=R_N(\mathcal A_N,\nu)$, and let $R_{N,B}$ be the regret of its first $B$ internal rounds. It is important that this is the prefix of the $N$-horizon base, not a fresh $B$-horizon run. Since gaps are nonnegative, $R_{N,B}\le R_N$.

Conditional on the public base prefix, every pilot sample has distribution $\operatorname{Ber}(\mu_J)$, independently of the other fresh pilot samples. The target string remains balanced whichever arm $J$ is selected. Lemma 1 therefore gives the uniform bound

$$
q:=\Pr_\nu(F=1)\le\overline q:=\beta_r^m.
\tag{13}
$$

The flag can be correlated with the estimate and the counterfactual base future; no independence between these variables is required below.

### Theorem 3. Finite regret comparison

For every fixed Bernoulli instance,

$$
R_N-(N-B)\Delta\overline q
\le R_T(W,\nu)
\le R_N+\frac{2P}{B}R_{N,B}+\Delta+(N-B)\Delta\overline q
\le R_N+\frac{2P}{B}R_N+\Delta+(N-B)\Delta\overline q.
\tag{14}
$$

**Proof.** The zero-gap case is immediate. For $\Delta>0$, a wrong public-majority estimate implies at least $B/2$ suboptimal base-prefix actions. Consequently

$$
\Pr(J\text{ is suboptimal})
\le\frac{2R_{N,B}}{B\Delta}.
\tag{15}
$$

All pilot actions are $J$, giving expected pilot regret at most $2P R_{N,B}/B$. The flag action contributes at most $\Delta$.

For the remaining comparison, couple a complete latent $N$-round stochastic base trajectory with fresh pilot observations, flag randomness, and a fresh challenge trajectory. On $F=0$, the saved state resumes along the latent base suffix. On $F=1$, that suffix is discarded and replaced by the challenge. This coupling is valid because pilot and flag observations are never supplied to the base and stationary future reward samples are fresh. If the base has private randomness already in its saved state, the latent path uses that same randomness.

The only base regret that can be removed is the latent suffix cost on $F=1$, bounded on every trajectory by $(N-B)\Delta$. The extra challenge cost on the same event is bounded by the same quantity. Therefore deleting or inserting this branch changes expected regret by at most $(N-B)\Delta q$ in the respective direction. Adding the nonnegative pilot and flag costs proves (14), using (13). The proof never replaces a conditional base law by an independently restarted algorithm. $\square$

### 7. Exponential rate and preservation of the leading coefficient

Fix $\varepsilon>0$ and one $r$ satisfying (3), and use natural logarithms below. For sufficiently large integer horizons define

$$
m_T=\left\lceil\frac{3\log T}{-\log\beta_r}\right\rceil,
\quad P_T=4m_T,
\quad B_T=\lceil(\log T)^2\rceil,
$$

$$
N_T=T-P_T-1,
\qquad L_T=N_T-B_T-2.
\tag{16}
$$

The finite feasibility condition is $B_T\ge1$ and $T\ge P_T+B_T+3$; it holds eventually. On smaller horizons the asymptotic family can simply use the base policy, with no claim of the Table witness on those exceptional horizons.

By Lemma 1,

$$
\overline q_T\le T^{-3},
\qquad p_{m_T}\ge1-T^{-3}.
\tag{17}
$$

The exact View error and the same-factor Table witness are

$$
\delta_T=p_{m_T}2^{-L_T},
\qquad
H_{e^\varepsilon}(M_{D_T}^W,M_{E_T}^W)
=H_{e^\varepsilon}(M_{E_T}^W,M_{D_T}^W)=p_{m_T}.
\tag{18}
$$

Since $L_T=T-O_\varepsilon(\log^2T)$,

$$
\frac{\log(1/\delta_T)}{T}\longrightarrow\log2.
\tag{19}
$$

On every fixed instance where $R_n(\mathcal A_n,\nu)=O(\log n)$, the pilot overhead in (14) is $O(1)$, and the rare-branch term is at most $\Delta T^{-2}$. Thus (2) holds. As $\log N_T/\log T\to1$,

$$
\limsup_{n\to\infty}\frac{R_n(\mathcal A_n,\nu)}{\log n}\le C
\quad\Longrightarrow\quad
\limsup_{T\to\infty}\frac{R_T(W_T,\nu)}{\log T}\le C.
\tag{20}
$$

If the base has an actual limit equal to $C$, (14) gives the same limit for the wrapper. No reward-gap lower bound is used by the algorithm or this implication. Constants in the asymptotic regret statement may depend on the fixed instance and fixed privacy parameter.

### A checked baseline instantiation

Azize, Wu, Honda, Orabona, Ito, and Basu [AWH+25] prove pure $\varepsilon$-global privacy of DP-IMED and DP-KLUCB in their published Proposition 2. Their Definition 3 and the following discussion identify pure global privacy with the equivalent pure View and Table notions; Appendix E proves the View path-probability inequality directly. This is precisely the pure-View assumption imposed on the base in Section 3. Their published Theorem 2 gives, for fixed $\alpha>1$, $\mu^*<1$, and a two-arm Bernoulli instance with positive gap,

$$
R_n\le\frac{\alpha\Delta}{d_\varepsilon(\mu_{\mathrm{sub}},\mu^*)}\log n+o(\log n),
\quad
d_\varepsilon(x,y)=\inf_{z\in[x,y]}\{\varepsilon(z-x)+\operatorname{kl}(z,y)\}.
$$

For a direct safe instantiation take fixed $\varepsilon>0$, fixed $\alpha>1$, and $0<\mu_{\mathrm{sub}}<\mu^*<1$. Formula (20) preserves this leading upper coefficient. It does not reinterpret the cited theorem as an exact optimal-constant statement at $\alpha=1$.

### 8. Why the exponential rate is optimal

For any two-action, $T$-round causal policy with View error $\delta$ at a fixed factor $\lambda$,

$$
H_\lambda(M_D,M_E)\le2^{T-1}\delta
\tag{21}
$$

for neighboring fixed tables. This weaker form of the frozen manuscript's sharp binary theorem suffices for the rate converse, and has a short independent proof.

Partition the released action sequence by its first $T-1$ actions $z$. For each $z$, use the two fixed reward streams obtained by reading the tables along $z$, and append an arbitrary common final reward. They are neighboring. On outputs with action prefix $z$, the Table and these View masses agree pathwise. The positive-part sum restricted to this prefix is at most the complete View defect, hence at most $\delta$. Summing over the $2^{T-1}$ possible prefixes proves (21). A change only to the last table row has no effect.

Now consider any horizon-indexed family with a valid same-factor View budget $\widetilde\delta_T$ and table witness defect $\rho_T\to1$. For all large $T$, (21) yields

$$
\widetilde\delta_T\ge\rho_T2^{-(T-1)},
\qquad
\limsup_{T\to\infty}\frac{\log(1/\widetilde\delta_T)}T\le\log2.
\tag{22}
$$

Equation (19) attains this rate while retaining the base's leading stochastic-regret coefficient. This is an optimal **exponential rate**, not a claim of a sharp finite-horizon privacy-versus-regret frontier or a multiplicatively sharp prefactor: the construction still has $O(\log^2 T)$ rounds of overhead in its exponent.

### 9. Continuous-noise implementation as an alternative

The same law (9) and regret proof also work with the originally proposed Laplace flag. For even pilot length $P$, set $F=\mathbf1\{S+Z\ge3P/4\}$, where $Z\sim\operatorname{Lap}(1/\varepsilon)$ is independent. Sensitivity one and the Laplace density ratio give pure $\varepsilon$ privacy [DR14, Theorem 3.6]. At score $P$,

$$
p=1-\tfrac12e^{-\varepsilon P/4}.
$$

Under a stationary Bernoulli pilot, the match indicators are independent, bounded in $[0,1]$, and their means sum to $P/2$, even if $J$ is wrong. Splitting at $S=5P/8$ and noise $P/8$ gives

$$
q\le e^{-P/32}+\tfrac12e^{-\varepsilon P/8}
$$

by the bounded-sum inequality [H63, Theorem 2] and the Laplace tail. Taking even $P\ge\max\{96,24/\varepsilon\}\log T$ gives $q\le1.5T^{-3}$, $p\ge1-0.5T^{-6}$. This is an alternative implementation of the same private-test framework; it is not counted as another conceptual contribution. The finite logistic version is used for the main theorem and exact verification.

### 10. An obstruction for a single anytime policy

### Proposition 4. Vanishing horizon errors force pure privacy

Let $\pi$ be one causal infinite-horizon policy whose released outputs are its action prefixes. Assume a nonempty reward space and finite action set. Fix finite $\varepsilon$. Suppose every $T$-round prefix mechanism is $(\varepsilon,\delta_T)$-View-private and $\delta_T\to0$. Then every finite prefix is pure $\varepsilon$-View-private and pure $\varepsilon$-Table-private.

**Proof.** Fix a finite horizon $t$, neighboring reward streams $x,x'$ of length $t$, and an event $E$ involving the first $t$ actions. For every $T\ge t$, extend the streams with the same arbitrary rewards. Projective consistency and causality identify their first-$t$-action laws with those of the original $t$-round mechanism. Applying privacy at horizon $T$ and projecting the output gives

$$
\Pr_x(E)\le e^\varepsilon\Pr_{x'}(E)+\delta_T.
$$

Letting $T\to\infty$ proves the pure inequality. Apply it in both directions and to every event. The pathwise argument after (12) converts pure View privacy into pure Table privacy at each finite horizon. $\square$

In fact a subsequence of unbounded horizons with $\delta_T\to0$ suffices. The horizon-indexed wrappers above avoid this obstruction because changing the requested horizon changes the whole policy, including its pause point and test length. A fixed finite $\varepsilon$, projectively consistent outputs, and the same policy across horizons are essential hypotheses of this proposition.

### 11. Interpretation and boundaries

- The wrapper is private on all neighboring **fixed** binary streams, without assuming stationarity in that claim. Stationarity is used only to bound the frequency of the expensive challenge for regret.
- The constructed tables are fixed before interaction. No witness depends on the majority estimate or on the learner's random seed.
- Retained private state is handled by the complete projected base law, not by an invalid blanket claim that conditional privacy is automatic.
- The exact same-factor View error is $p_m2^{-L}$. The same-factor Table witness defect is $p_m$; for factors below $e^\varepsilon$, the displayed witness has at least this defect and need not have exactly this defect.
- The first-order regret statement is for fixed two-arm stationary Bernoulli instances and fixed positive $\varepsilon$. No vanishing-gap uniform rate, adversarial-regret guarantee, $\varepsilon=0$ learning guarantee, or single-anytime construction is asserted.
- This is a separation inside a class satisfying a stringent utility benchmark. It is not a separation between the optimal achievable regret values of the View-private and Table-private classes; the original pure-private base remains an available algorithm in the latter class.
- The new rate statement removes the earlier restriction to subexponential inverse View errors. It does not resolve the optimal finite-horizon correction to the exponent, or the best attainable tradeoff under additional restrictions on the algorithm's design.
- The finite testing rule and elementary concentration arguments are standard ingredients. A broader priority check of the combined construction is still needed before any publication-level claim of novelty.

### 12. Exact finite verification

`private_test_bridge_verify.py` independently executes a finite causal base with a saved private next-action state. The state is updated by randomized response to each consumed reward, including reward $B$ immediately before the pause. The script compares direct pause/resume execution against the complete-baseline mixture (9) on every fixed stream at three small parameter settings, using exact rational arithmetic throughout.

The successful record covers 15 flag-parameter cases, 720 adjacent-score probability inequalities, 105 stationary-test generating-function cases, 2,304 full-stream causal/mixture identities, all 22,528 directed neighboring full-stream pairs in those settings, 2,304 checks involving the retained boundary reward, 30 directed table/factor checks, and 180 exact stochastic-regret comparisons. In the table checks, factors below the base privacy factor do produce a strictly larger defect than $p_m$, explicitly testing the distinction in (12).

Representative exact maxima are:

| $B,m,L,T$ | Flag parameter $r$ | Base factor | Maximum View defect | Same-factor Table defect |
| --- | --- | --- | --- | --- |
| $1,1,0,8$ | $3/2$ | $2$ | $3/5$ | $3/5$ |
| $2,1,1,10$ | $2$ | $2$ | $1/3$ | $2/3$ |
| $2,1,1,10$ | $3/2$ | $3$ | $3/10$ | $3/5$ |

The [machine-readable record](evidence/extensions/private_test_bridge_verification.json) binds the exact historical audit source and note hashes. The checks cover the finite identities listed above.

### References

**[AB24]** Achraf Azize and Debabrota Basu. *Concentrated Differential Privacy for Bandits.* arXiv:2309.00557v3, 2024. Definition 3 and Proposition 1. Primary text: <https://arxiv.org/html/2309.00557v3>.

**[AWH+25]** Achraf Azize, Yulian Wu, Junya Honda, Francesco Orabona, Shinji Ito, and Debabrota Basu. *Optimal Regret of Bandits under Differential Privacy.* NeurIPS 2025. Published Definition 3 and the following global-privacy discussion; Proposition 2 and Theorem 2, PDF pages 8–9; Appendix E. Primary PDF: <https://proceedings.neurips.cc/paper_files/paper/2025/file/a70522d112322111cbf19c69e927eaf2-Paper-Conference.pdf>. The earlier arXiv v1 has a different title and numbers these statements Proposition 8 and Theorem 9: <https://arxiv.org/html/2505.05613v1>.

**[DR14]** Cynthia Dwork and Aaron Roth. *The Algorithmic Foundations of Differential Privacy.* 2014. Theorem 3.6. Author-hosted primary text: <https://www.cis.upenn.edu/~aaroth/Papers/privacybook.pdf>.

**[H63]** Wassily Hoeffding. *Probability Inequalities for Sums of Bounded Random Variables.* Journal of the American Statistical Association 58(301), 13–30, 1963. Theorem 2. DOI: <https://doi.org/10.1080/01621459.1963.10500830>. University-hosted scan of the original article: <https://www.cs.rpi.edu/academics/courses/spring06/random/hoefding.pdf>.


## Appendix E. Robustness to error in a fixed exploration law

The total-variation ball below is over probability laws on the same fixed finite set of $m$ exploration patterns.

For a reward-independent prefix with known finite pattern labels, write $F_\delta(w)=\sum_i\min\{w_i,\delta\}$ for the sharp envelope in Appendix B. If the true pattern law is only known to be within total variation $\eta$ of the center $w$, the maximal envelope is
$$
\min\{1,m\delta,F_\delta(w)+\eta\}.
$$
Moving one unit of probability mass can increase the clipped sum by at most one. The clipped sum never exceeds one or $m\delta$. Transfer mass from entries above $\delta$ to entries below $\delta$ until the TV budget, the donor total $1-F_\delta(w)$, or the recipient total $m\delta-F_\delta(w)$ is exhausted. Each moved unit increases the clipped sum by one, proving attainment.

Full Lean formalization of the integrated mathematical claims will be delivered separately. Previously checked scopes remain recorded in Appendix A and the source archive.
