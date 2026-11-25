# Sharp local cooling capacity of resonant finite machines

The fixed-system results concern two-weight qutrit machines. The optimized-system realization applies to every finite full-support machine. Lean verification is delivered separately.

# Abstract

For a nondegenerate system and a three-level machine with two distinct reference weights, the optimal ratio of system to joint Fisher displacement is a function of the longest resonance chain. We give its exact formula, attain it by a three-cycle or alternating transpositions, and compute the effect of preserving the repeated machine population under perturbation. A separate exact formula handles degenerate systems in the absence of cross-weight resonances.

For any fixed full-support machine with at least two labels, we determine the supremum over all finite systems, allowing arbitrary level multiplicities. It is the largest generalized eigenvalue taken over the vertices of a finite polytope of stationary mixtures of deterministic row maps. A resonant-shell construction realizes any such mixture in quadratic performance. At machine spectrum $(2,2,1)/5$, allowing degenerate systems increases the exact supremum to $(7+\sqrt{37})/20$, strictly beyond the supremum along nondegenerate chains.

# 1. Problem, provenance, and contribution

The quadratic cost of cooling with finite machines is sensitive to the resonances of the system and machine reference spectra. Mishra and Senthilkumar [1, Theorem 2 and equation (7)] prove a machine-dimension dissipation bound for a maximally mixed system, and for every system state when the machine is a qubit. They conjecture its extension to every temperature for larger machines. Their Appendix S11 expresses the proposed bound as a comparison between system and joint Fisher displacements. This gives a precise, finite-dimensional target inside a broader thermodynamic problem.

The earlier continuation draft [2] already contains an unreviewed proposed proof of the constant $2/3$ for a three-level machine with two distinct reference populations and a nondegenerate system of arbitrary dimension. Its six-permutation shell classification and alternating-run argument are the starting point of this work. We retain that provenance: the universal-bound idea is not presented as a new discovery here. Related repository cases establish the qubit-system bound for arbitrary machine dimension [3] and the arbitrary-spectrum qutrit-system bound [4].

Our addition is the **exact optimum for each fixed pair of reference states**, including its finite-chain dependence and explicit attaining collisions. The argument both verifies the continuation's universal bound and replaces its dimension-independent estimate by a sharp one. We also distinguish unrestricted machine perturbations from perturbations that preserve the repeated population. Neither the original conjecture nor the other repository cases state this finite-chain formula.

The fixed-system formula addresses the exact-resonance conjecture in the nondegenerate subclass. Sections 10 and 11 study larger families. Section 10 fixes the system and permits repeated system populations when distinct system levels cannot share a joint shell. Section 11 takes a supremum over all finite systems and permits repeated populations, resonances, and arbitrary finite machine spectra.

The original near-neighbor audit accessed the primary abstract of *Cooling more while dissipating less: anomalous tradeoffs from thermodynamic geometry*. Section 11.4 gives the closest original energy-shell realization and the difference needed for quadratic row performance. [Thermodynamic geometry preprint](https://arxiv.org/abs/2610.27948)

# 2. Model and exact optimum

## 2.1 Reference states and local displacement

Let $p=(p_x)_{x\in X}$ be a probability vector with finitely many, pairwise distinct, strictly positive entries. The system dimension $d=|X|\ge2$ is arbitrary. Let the three machine labels have reference populations $q_H$ and $q_L$, with

$$
q_H>q_L>0,\qquad
a q_H+b q_L=1,\qquad \{a,b\}=\{1,2\}.
\tag{1}
$$

Here $a$ is the multiplicity of the higher population and $b$ that of the lower one. Set

$$
s=\frac{q_L}{q_H}\in(0,1),\qquad
D=a+bs,\qquad q_H=\frac1D,\quad q_L=\frac sD.
\tag{2}
$$

We write $q$ for this reference vector. A permutation $P$ of the product configurations $(x,y)\in X\times\{1,2,3\}$ is **exactly resonant** when it preserves every reference product weight $p_xq_y$. For
$(x',y')=P^{-1}(x,y)$, define

$$
\Delta_x(y)=\psi_{y'}-\psi_y,\qquad
\delta_x=p_x\sum_yq_y\Delta_x(y),
\tag{3}
$$

$$
E(P,\psi)=\sum_{x,y}p_xq_y\Delta_x(y)^2,
\qquad
F(P,\psi)=\sum_x\frac{\delta_x^2}{p_x},
\qquad Q=\frac{E-F}{2}.
\tag{4}
$$

Both $E$ and $F$ are dimensionless quadratic displacements, rather than an energy measured in physical units. For the perturbation
$q_y(\epsilon)=q_y+\epsilon q_y\psi_y$, normalized by
$\sum_yq_y\psi_y=0$, the system changes by $\epsilon\delta$, and $Q$ is its quadratic dissipation coefficient [1, equations (3) and (S11.1)]. Since every reference population is positive, such a tangent gives a physical machine state for all sufficiently small $|\epsilon|$.

**The two-population condition in Sections 2–10 applies to the reference state.** Unless stated otherwise, the two labels sharing a reference population may have independent perturbations and their populations may split at nonzero $\epsilon$. Section 7 solves the additional restriction that they remain equal to first order. Adding a constant to every $\psi_y$ leaves (3)--(4) unchanged, so the tangent normalization can always be restored after choosing the differences.

## 2.2 Resonance chains

Join two system labels when their probabilities have ratio $s$. Pairwise distinctness makes every component a finite path, which can be indexed as

$$
p_i=p_0s^i,\qquad i=0,\ldots,n.
\tag{5}
$$

Indeed each probability has at most one successor with ratio $s$, at most one predecessor with ratio $1/s$, and a directed cycle is impossible for $0<s<1$. Let $L$ be the maximum number of edges in any component. An isolated system label has a component with zero edges.

For positive integers $k$, define $\rho_1(s)=0$ and

$$
\rho_{2r}(s)=(1+s)\sqrt{s}\,
\frac{1-s^{2r-1}}{1-s^{2r}},\qquad r\ge1,
\tag{6}
$$

$$
\rho_{2r+1}(s)=(1+s)\sqrt{s}\,
\sqrt{\frac{1-s^{2r}}{1-s^{2r+2}}},\qquad r\ge0.
\tag{7}
$$

The formula at $r=0$ agrees with $\rho_1=0$.

## Theorem 1. Exact capacity for fixed reference states

If $L=0$, every exactly resonant permutation has $F=0$. If $L\ge1$, then

$$
\boxed{
\max_{P,\psi:\,E(P,\psi)>0}\frac{F(P,\psi)}{E(P,\psi)}
=C_L(s;a,b)
=\max\left\{\frac{2(1+s)}{3D},
\frac{1+s+\rho_L(s)}{2D}\right\}.}
\tag{8}
$$

The maximum is over all exactly resonant permutations and all normalized machine tangents, with $p$ and $q$ fixed. It is attained: the first expression is realized by one three-cycle in one mixed shell; the second is realized, when $L\ge2$, by alternating transpositions along one longest chain. All other shells can be left unchanged. These are attaining constructions, not a classification of all optimizers.

In particular, the absolute probability scale and number of resonance components do not affect the optimum. What matters about $p$ is its longest exact chain. At $L=1$, the first expression is strictly larger than the second.

# 3. From product configurations to a weighted path

Call a set of product configurations with one common reference weight a *shell*. A resonant permutation acts independently inside each shell. A shell containing two different system labels must have one high-weight machine configuration side and one low-weight side. Nondegeneracy of $p$ implies that there is only one system label on each side. Thus it contains exactly three configurations, with multiplicities $a$ and $b$, and corresponds to one edge of (5).

Set the perturbation of the singleton machine label to zero by the additive gauge freedom. Write the perturbations of the two repeated-weight labels as $u,v$. In a mixed shell, let $x$ be the perturbation increment of the singleton-label configuration, and let $w$ be the common product weight. Direct enumeration of its six permutations gives:

| Shell permutation | Singleton increment $x$ | Joint displacement $E_{\rm shell}/w$ |
| --- | --- | --- |
| Identity | $0$ | $0$ |
| Exchange the repeated labels | $0$ | $2(u-v)^2$ |
| Exchange singleton with the $u$-label | $u$ | $2u^2$ |
| Exchange singleton with the $v$-label | $v$ | $2v^2$ |
| Three-cycle with $u$ entering singleton | $u$ | $u^2+v^2+(u-v)^2$ |
| Three-cycle with $v$ entering singleton | $v$ | $u^2+v^2+(u-v)^2$ |

For example, a three-cycle can send the source values $(u,v,0)$ into the target positions whose original values are $(0,u,v)$. Its increment vector is $(u,v-u,-v)$, giving the fifth row. This verifies the cycle's cost and the meaning of the singleton increment without any relaxation of permutation bijectivity.

A shell with just one system label has zero total system increment, because a permutation preserves the sum of its configuration populations. Its contribution to $E$ is nonnegative. Such shells can therefore be ignored for an upper bound, and set to the identity in an attaining construction.

On a component (5), the mixed shell between $i$ and $i+1$ has

$$
w_i=p_iq_L=p_{i+1}q_H,\qquad i=0,\ldots,n-1.
\tag{9}
$$

Its net increment into system label $i$ is
$A_i=\varsigma w_ix_i$, where $x_i\in\{0,u,v\}$ and the sign
$\varsigma\in\{1,-1\}$ is the same on every component and shell. It is positive when the singleton machine label is the low-weight one, and negative when it is the high-weight one. The other system label receives $-A_i$.

Using $A_{-1}=A_n=0$, the system increments are
$\delta_i=A_i-A_{i-1}$. Expanding (4), including both endpoint terms, gives

$$
F_{\mathrm{path}}=q_L^2\left[
(1+s^{-1})\sum_{i=0}^{n-1}p_ix_i^2
-2s^{-1}\sum_{i=1}^{n-1}p_ix_ix_{i-1}
\right].
\tag{10}
$$

The sign $\varsigma$ cancels. Different components have disjoint system labels, so their $F$ values add. Formula (10) is the only place where the coupling of adjacent shells enters the proof.

# 4. A sharp alternating-run inequality

For a run of $k\ge2$ alternating nonzero symbols $u,v$, with $uv<0$, remove its common geometric prefix factor and write

$$
A_k=\sum_{\substack{0\le j<k\\j\ {\rm even}}}s^j,
\quad
B_k=\sum_{\substack{0\le j<k\\j\ {\rm odd}}}s^j,
\quad
T_k=\sum_{j=1}^{k-1}s^j.
\tag{11}
$$

Its squared-displacement sum is $A_ku^2+B_kv^2$, with $u,v$ interchanged if the run starts with $v$. Its negative adjacent cross sum is $T_k|uv|$. Therefore

$$
T_k|uv|\le
\frac{T_k}{2\sqrt{A_kB_k}}
(A_ku^2+B_kv^2)
=\frac{\rho_k(s)}2(A_ku^2+B_kv^2).
\tag{12}
$$

The geometric sums in (11) yield (6)--(7). Equality in (12), for a run beginning with $u$, holds when $|u|/|v|=\sqrt{B_k/A_k}$. A one-symbol run has zero cross sum and corresponds to $\rho_1=0$.

## Lemma 2. Strict monotonicity in run length

For every $0<s<1$,

$$
0=\rho_1(s)<\rho_2(s)<\cdots<(1+s)\sqrt{s},
\qquad
\lim_{k\to\infty}\rho_k(s)=(1+s)\sqrt{s}.
\tag{13}
$$

**Proof.** Divide (6)--(7) by $(1+s)\sqrt{s}$. For the odd-to-even comparison, the required inequality is

$$
(1-s^{2r})(1-s^{2r+2})
<(1-s^{2r+1})^2,
\tag{14}
$$

whose right side minus left side equals $s^{2r}(1-s)^2>0$, also covering $r=0$. For the even-to-odd comparison, put $z=s^{2r-1}$, $r\ge1$. The relevant difference factors as

$$
(1-sz)^3-(1-z)^2(1-s^3z)
=z(1-s)^2\big[(s+2)-z(2s+1)\big]>0.
\tag{15}
$$

Here $0<z\le s<1$, so the bracket is at least $2(1-s^2)>0$. Finally, taking limits in (6)--(7) proves the limit and the strict upper bound. $\square$

For an arbitrary sequence $x_i\in\{0,u,v\}$, $uv<0$, split its nonzero entries into maximal alternating runs, cutting at zeros and at adjacent equal symbols. Cross terms at zeros vanish. A cut between equal nonzero symbols has a nonpositive contribution to the *negative* cross sum, so omitting it can only increase that sum. Apply (12) to every run and then (13). On every path of at most $L$ edges this gives

$$
-\sum_{i=1}^{n-1}p_ix_ix_{i-1}
\le\frac{\rho_L(s)}2\sum_{i=0}^{n-1}p_ix_i^2.
\tag{16}
$$

The argument allows zeros, arbitrarily many runs, and either initial symbol. It does not assume that the actual optimal permutation has one alternating run; the one-run construction will instead establish attainability of the resulting bound.

# 5. Proof of Theorem 1

## 5.1 Same-sign perturbation differences

Suppose $uv\ge0$. Every $x_ix_{i-1}$ in (10) is nonnegative. The shell table also gives

$$
E_i\ge\frac32 w_ix_i^2.
\tag{17}
$$

For a three-cycle with $x_i=u$, the identity

$$
u^2+v^2+(u-v)^2-\frac32u^2
=2(v-u/2)^2
\tag{18}
$$

proves (17); the $x_i=v$ case is symmetric, and the transposition cases are immediate. Summing over all mixed shells, dropping nonpositive cross terms from (10), and including any additional nonnegative pure-shell energy gives

$$
\frac FE\le
\frac{q_L^2(1+s^{-1})}{(3/2)q_L}
=\frac{2(1+s)}{3D}.
\tag{19}
$$

If the sum of mixed-shell $w_ix_i^2$ is zero, then $F=0$ directly; no division by it is needed.

For attainment, choose any mixed shell, use the three-cycle whose singleton increment is $u$, and set $u=2$, $v=1$. Make every other shell the identity. Equality holds in (18), there are no adjacent nonzero shell increments, and every inequality in (19) is equality. The physical tangent normalization is restored by subtracting $\sum_yq_y\psi_y$ from all three $\psi_y$, which leaves the increments unchanged.

## 5.2 Opposite-sign perturbation differences

Now suppose $uv<0$. Every row of the shell table gives the stronger estimate

$$
E_i\ge2w_ix_i^2.
\tag{20}
$$

For a three-cycle with singleton increment $u$, the excess over $2u^2$ is $2v(v-u)>0$; the other cycle is symmetric. Replacing such a three-cycle by the singleton transposition with the same increment preserves all system changes and decreases $E$.

Combining (10), (16), and (20), and summing over the disjoint components, yields

$$
\frac FE\le
\frac{q_L^2\big[1+s^{-1}+s^{-1}\rho_L(s)\big]}{2q_L}
=\frac{1+s+\rho_L(s)}{2D}.
\tag{21}
$$

For $L\ge2$, choose one longest chain. On its shells use singleton--$u$ and singleton--$v$ transpositions alternately, and set

$$
u=\sqrt{B_L},\qquad v=-\sqrt{A_L}.
\tag{22}
$$

This chain is one alternating run, (12) is equality, and (20) is equality in every active shell. All other shells are the identity. Thus (21) is attained for the fixed reference vector $p$, with no change to its probabilities. The common factor $p_0$ cancels from the ratio.

For $L=1$, the right side of (21) is $(1+s)/(2D)$, below the attained value in (19). If $L=0$, every shell has just one system label, hence all system changes vanish. These cases complete the proof of (8). $\square$

# 6. Dissipation bounds and the mechanism switch

## Corollary 3. Exact-reference subclass of the all-temperature bound

For $L\ge1$, every permutation and tangent in the model satisfy

$$
Q\ge\frac{1-C_L}{2C_L}F>\frac14F
\qquad\text{whenever }F>0.
\tag{23}
$$

In particular $F\le2E/3$, so the proposed three-level-machine constant of [1, equation (7)] holds throughout this subclass.

**Proof.** By (13),

$$
C_L\le C_\infty(s;a,b)
:=\frac{1+s}{D}
\max\left\{\frac23,\frac{1+\sqrt{s}}2\right\}.
\tag{24}
$$

The first branch is strictly below $2/3$ since $D>1+s$. For the second branch, $D\ge1+2s$, and

$$
4(1+2s)-3(1+s)(1+\sqrt{s})
=(1-\sqrt{s})(3s-2\sqrt{s}+1)>0.
\tag{25}
$$

The last quadratic is positive: with $y=\sqrt{s}$,
$3y^2-2y+1=3(y-1/3)^2+2/3$. Hence $C_L\le C_\infty<2/3$. Equation (23) follows from $Q=(E-F)/2$. The assertion also holds without strictness at $F=0$. $\square$

The constant $2/3$ cannot be replaced by a smaller constant uniform over this entire subclass. Take $a=1$, $b=2$, use a single mixed shell, and let $s\downarrow0$. The exact first branch in (8) tends to $2/3$. This is a limit through positive probabilities, not a claim at a rank-deficient reference state.

For arbitrary finite system dimension, the supremum is exactly (24). When the first branch dominates, one shell already attains it. When $s>1/9$, the alternating branch dominates, and increasingly long geometric chains approach it; no finite chain attains that dimension-unrestricted second-branch supremum. The two expressions in (24) coincide at $s=1/9$. This is a switch of optimizing collision mechanism, not a thermodynamic phase transition.

## Proposition 4. Finite-chain transition

For every $L\ge2$, there is a unique $s_L\in(0,1)$ satisfying

$$
\frac{\rho_L(s_L)}{1+s_L}=\frac13.
\tag{26}
$$

The three-cycle branch is larger below $s_L$, and the alternating branch is larger above it. Moreover $s_L$ strictly decreases to $1/9$. Two explicit cases are

$$
s_2=\frac{7-3\sqrt5}{2}\approx0.145898,
\qquad
s_3=\frac{9-\sqrt{77}}2\approx0.112518.
\tag{27}
$$

**Proof.** Let $f_L(s)=\rho_L(s)/(1+s)$, and write $s=e^{-t}$, $t>0$. Equations (6)--(7) become

$$
f_L(e^{-t})=
\begin{cases}
\dfrac{\sinh((L-1)t/2)}{\sinh(Lt/2)},&L\text{ even},\\[6pt]
\sqrt{\dfrac{\sinh((L-1)t/2)}{\sinh((L+1)t/2)}},&L\text{ odd}.
\end{cases}
\tag{28}
$$

For $0<A<B$, the logarithmic derivative of $\sinh(At)/\sinh(Bt)$ is
$A\coth(At)-B\coth(Bt)<0$. To verify the sign, $x\coth x$ is strictly increasing on $x>0$, since its derivative has the sign of $\sinh x\cosh x-x>0$. Thus $f_L$ is strictly increasing in $s$. Its limits at zero and one are respectively zero and
$(L-1)/L$ for even $L$, or $\sqrt{(L-1)/(L+1)}$ for odd $L$. The latter limits exceed $1/3$, proving uniqueness.

Lemma 2 implies strict decrease of $s_L$. For finite $L$, $f_L(s)<\sqrt{s}$, so $s_L>1/9$. For every fixed $s>1/9$, equation (13) eventually gives $f_L(s)>1/3$, forcing $s_L<s$. Hence $s_L\to1/9$. Substitution in the $L=2,3$ formulas gives (27). $\square$

The numerical values in (27) are rounded; all threshold statements are established by the exact radical expressions and the proof, rather than by numerical root finding.

# 7. If the repeated population must remain equal

The freedom to split the repeated population is essential to the main optimum. Suppose the machine perturbation is constrained to keep the two repeated reference populations equal to first order. Because those two reference weights coincide, this constraint is exactly $u=v$ in the chosen gauge.

## Proposition 5. Capacity under the equality-preserving tangent restriction

For fixed reference states with $L\ge1$,

$$
\boxed{
\max_{P,\psi:\,u=v,\ E>0}\frac FE
=\frac{1+s}{2D}.}
\tag{29}
$$

For $L=0$, every equality-preserving tangent has $E=F=0$: there is no movable direction, and the ratio optimization restricted to $E>0$ has an empty feasible set. No maximum over that empty set is asserted.

**Proof.** When $u=v$, every nonzero shell increment is the same value. The shell table gives $E_i\ge2w_ix_i^2$, and all adjacent cross products in (10) are nonnegative. Consequently the ratio is at most the right side of (29). A singleton--repeated-label transposition on one mixed shell, with $u=v=1$ and every other shell fixed, attains it. $\square$

The unrestricted capacity is at least $4/3$ times the restricted capacity, by comparing the first branch of (8) with (29). This comparison concerns the ratio $F/E$; the corresponding dissipation-per-Fisher-displacement comparison must use $(1-C)/(2C)$. A machine whose reference populations coincide but whose controls can split them therefore has a different local optimization problem from one constrained to preserve that coincidence.

# 8. Physical interpretation and limits

The two mechanisms use the same reference machine but different tangent patterns. A single three-cycle distributes one net system transfer between the repeated configurations, yielding the $3/2$ local quadratic cost in (17). Alternating transpositions use opposite-sign perturbation differences on successive shells. The shell flows then add in the intermediate system displacement, creating the positive cross contribution to (10). The finite geometric sums determine exactly how much that second mechanism gains.

Theorem 1 optimizes over the resulting local system direction. Its maximizing direction need not equal the tangent of a prescribed Gibbs cooling curve. A bound valid for every direction is useful for that curve, but an attained largest-direction ratio does not establish an optimal cooling protocol along it. The theorem also does not optimize a finite number of collisions or control costs.


The result is for **exact resonance at a fixed reference input**. Perturbing the system probabilities can break a resonance chain; a generic nonresonant vector has $L=0$ for a fixed two-weight machine. Thus no continuity statement under reference-spectrum error is implicit in (8). The points $s=0$ and $s=1$ are excluded: the former loses full rank, and the latter changes the machine and potentially system degeneracy structure. Repeated system probabilities may create larger mixed shells and invalidate the path classification.

The collision reduction in [1, Theorem 1] supplies a separate route to near-dissipationless coherent collisions at the same fixed reference input. If that theorem is applied under its stated hypotheses, its convex mixture of resonant permutation displacements preserves any common bound $Q_k\ge\kappa F_k$:

$$
Q_{\rm coh}\ge\sum_k\lambda_kQ_k
\ge\kappa\sum_k\lambda_k\|\delta_k\|_F^2
\ge\kappa\left\|\sum_k\lambda_k\delta_k\right\|_F^2.
\tag{30}
$$

Taking $\kappa=(1-C_L)/(2C_L)$ transfers the lower bound. Equation (30) explicitly identifies the external reduction being used; the present manuscript independently proves the permutation theorem, not that coherent-collision reduction. Collisions with a simultaneous displacement of the reference input from a resonance manifold remain outside the claim.

# 9. Reproducible finite verification

The proof of Theorem 1 is analytic and applies to every finite dimension and every $0<s<1$. The accompanying computation has a different role: it independently checks the product-configuration definitions, the sharp constants, and the constructions over the finite scope recorded in its certificate.

`code/verify_product.py` groups the exact rational product probabilities $p_xq_y$, enumerates every weight-preserving permutation in each listed model, and computes the two quadratic forms $E,F$ directly from (3)--(4). It does not use the path identity (10) or the six-row table to compute them. For each permutation it verifies that $C_LE-F$ is positive semidefinite by checking the principal minors of its symmetric $2\times2$ matrix. All comparisons use rational numbers and exact signs in a real quadratic field; floating-point eigenvalues are not used as certificates.

The archived run checks 48 models and 38,024 permutations. They include geometric systems of dimensions two through five at
$s\in\{1/25,1/9,1/4,4/9,9/10\}$, both multiplicity orders, disconnected chains with an isolated label, and systems with no mixed shell. The same exhaustive forms also verify the equality-preserving-tangent bound (29). The 490 direct product-configuration witnesses cover chains through $L=16$, both multiplicity orders, and disconnected systems. The certificate records all individual inputs.

The independently written verifier in the case computes the original matrices separately, without importing the author's implementation. Its archived run covers 30 models and 32,488 weight-preserving permutations, checking the whole real tangent space in exact quadratic arithmetic and verifying positive-energy equality directions. A third script checks the six symbolic shell permutations, 12 polynomial identities, and 441 exact finite geometric-sum instances. These finite scopes remain separate from the analytic proof.

The author's script refuses optimized Python mode because assertions are part of its checks. From the [reproduction directory](evidence/README.md), run it with an explicit output path:

~~~sh
python3 -B code/verify_product.py --output /tmp/two-weight-product-certificate.json
~~~

Independent mathematical review, further independently written checks, build records, and the exact scope of any formalization are recorded with the case. Finite enumeration is not substituted for the all-dimension proof.

# 10. Degenerate systems without cross-weight resonance

Keep the two-valued three-label machine of §2, with repeated population $h$. Now the system may have repeated probabilities. Assume there are no joint-weight ties between different numerical system probabilities. If at least one system probability has multiplicity at least two, the exact maximum of $F/E$ over positive-cost resonant permutations and all machine tangents is $h$.

Indeed the joint shells are contained in single system weight layers. The singleton-machine shell contributes zero. Write $D$ for the difference of the scores of the two repeated machine labels. In a row of system probability $p_*$, the output cells for the repeated labels use $r\in\{0,1,2\}$ source cells of the first repeat label. Its conditional mean change is $h(r-1)D$. If $r\ne1$, at least one repeated cell undergoes score change $\pm D$, so $F_x=p_* h^2(r-1)^2D^2\le h E_x$. If $r=1$, then $F_x=0$. Sum across rows. For attainment choose two equal-$p_*$ rows and exchange a first-repeat cell of one with a second-repeat cell of the other. Only those two cells change scores, and both rows give equality when $D\ne0$. Perturbations preserving equality of the two repeated populations have $D=0$, so all costs and gains vanish in this model.

# 11. Fixed-machine capacity over arbitrary finite systems

Fix a full-support machine spectrum with $m\ge2$ and write it as $q=(q_1,\ldots,q_m)$. Allow a finite full-support system of arbitrary dimension, including repeated levels. Write $C_*(q)$ for the supremum of $F/E$ over full-support system spectra, exactly weight-preserving permutations, and real machine scores, with $E>0$. We give a finite formula for this number for every $q$, together with physical resonant systems approaching it. The converse realization is the essential point: stationarity alone is generally insufficient to implement prescribed row transitions on a given system.

For each map $f:[m]\to[m]$ write $u_f=f_\# q-q$ and, for a score $g$, $d_{fi}=g_{f(i)}-g_i$. Let
$$
 \mathcal L(q)=\{l\ge0:\sum_fl_f=1,\ \sum_f l_fu_f=0\}.
$$
For a vertex $l$ define on scores modulo constants
$$
 F_l(g)=\sum_fl_f(\sum_iq_i d_{fi})^2,\qquad
 E_l(g)=\sum_fl_f\sum_iq_i d_{fi}^2.
$$
**Theorem.** $C_*(q)$ equals the maximum of the largest generalized eigenvalue of $(F_l,E_l)$ over these finitely many vertices (restrict to the range of $E_l$, omitting zero forms). Each vertex uses at most $m$ maps. In particular a three-level machine of any two weights has a finite formula of constant size as its weight ratio varies. Actual level multiplicities are unbounded. This is an optimization over all system dimensions and reference spectra. Section 2 instead optimizes a collision and tangent for a previously fixed system.

## 11.1 The finite upper bound

 In each target system row record the source machine label $f(i)$ of each target cell $i$. The target row probability is its weight in the map mixture. The full permutation preserves the equilibrium product law, so the source labels have marginal $q$. Thus $l\in\mathcal L(q)$ exactly. For fixed $g$ the ratio of the mixture's linear forms cannot exceed the largest vertex ratio, since zero-cost vertices have zero gain. Maximizing in the $m-1$ score coordinates is the stated eigenvalue problem; subtracting a constant can always normalize the tangent. The rank of the equality constraints is at most $m$ since $\sum_i (u_f)_i=0$.

## 11.2 Physical realization for the reverse bound

 Fix any feasible $l$, any score $g$, and integers $L,T$. For each vector $n\in\{1,\ldots,L\}^m$ introduce $N_n=\lceil T/w(n)\rceil$ rows of common unnormalized system weight $w(n)=\prod_i q_i^{n_i}$. Each index group has total mass $T+O(1)$ before normalization; hence the group distribution tends to uniform for fixed $L$. Some groups may share energy; they retain distinct row labels. Round the type weights $N_n l_f$ to integer row counts of sum $N_n$, each with bounded additive error, prescribing the desired map on each row. Give cell $(n,i)$ formal shell label $k=n+e_i$; each copy of that cell has exactly weight $w(k)$. Equal weights from different formal shells may be kept separate by the permutation.

On an interior shell where every $k-e_i$ lies in the box, there are $N_{k-e_i}=Tq_i/w(k)+O(1)$ source cells bearing label $i$. The target cells of type $i$ request $j=f(i)$ in counts $(T/w(k))q_i\sum_{f:f(i)=j}l_f+O_m(1)$. The total requested count for $j$ is $Tq_j/w(k)+O_m(1)$ by stationarity. Demands and supplies have equal totals. Change a bounded number of requested labels from surplus categories to deficit categories; now biject the requested cells to actual source cells of that label in the very same shell. This gives an exactly resonant permutation, even for irrational $q$. For fixed $L$, the equilibrium-weight fraction of corrected target cells tends to zero as $T\to\infty$, since only finitely many shells occur. A changed cell belongs to a row of at most $1/\min_i q_i$ times its cell mass, so squared row gains also change by a vanishing amount.

On remaining boundary shells use the identity. Only rows with some coordinate $1$ or $L$ can be touched. Their total equilibrium mass in the limit $T\to\infty$ is at most $2m/L$. The score range bounds each row's energy and gain uniformly. Sending $T\to\infty$ first, then $L\to\infty$, makes the two physical quadratic forms converge to $E_l(g)$ and $F_l(g)$. For nonzero cost their ratio converges as well. The synthetic shell index avoids any rational dependence condition on logarithms of machine weights. A slice of the construction approximating any desired ratio has finite dimension. Attainment of the limiting optimal number on one finite system is not required.

## 11.3 A sharp change caused by multiplicity

 For $q=(2,2,1)/5$ the exact unrestricted-system supremum is
$$
 C_*=\frac{7+\sqrt{37}}{20}.
$$
Use equal masses on the three row maps $001,011,122$ in 0-based notation. Their average output is $q$. At scores $(0,1,1+t)$ the ratio is $(3t^2+6t+4)/(10(1+t^2))$, whose largest value is the displayed generalized eigenvalue. For the reverse bound use integer masses $Q=(2,2,1)$. Two coordinates record flows across the two cuts of the ordered labels. A triple weights its cost and gain matrices by the three signed two-by-two minors, oriented to make all nonnegative when possible. A two-map vertex is also obtained this way by adjoining a noncollinear column. Every zero-flow singleton has zero gain. For each resulting pair $E,F$, check the two diagonals and determinant of $(7+\sqrt{37})E-20F$. The attached standard-library verifier generates all 25 nonzero-flow columns and checks 723 nonempty triples using integer signs in $\mathbb Q(\sqrt{37})$; its $E,F$ are multiplied by a common positive factor. Thus exact matching holds. The earlier nondegenerate-system supremum at the same spectrum is $\max\{2/5,3(1+1/\sqrt2)/10\}=3(1+1/\sqrt2)/10$, strictly below even the equal-spacing score value $13/20$. Consequently simple-spectrum chains cannot exhaust the physical optimum even by growing arbitrarily long. [Integer certificate, SHA-256 18a4d9b554680fdd911600126dde46e0c39927105fe4b19b767f55b63a356884](evidence/r01/rational_spectrum.py)

## 11.4 Closest realization methods and interpretation

Mishra–Senthilkumar Appendix S11 already obtains stationary machine-label row maps from a weight-preserving permutation. Shiraishi §3.4, equations (36)–(38), realizes Gibbs-preserving stochastic matrices approximately by using an energy-lattice box, integer degeneracies approaching uniform block masses, and exact common-energy shells. It also allows coincident physical energies to remain in separate formal shell classes. The finite realization above uses this energy-shell method and matches entire deterministic row maps by replicating row types and repairing bounded integer requests inside each shell. A Gibbs-preserving transition matrix retains only aggregated label transitions, while $F$ squares the conditional row mean before averaging. A realization of the aggregated transition matrix thus need not match $F$. The row-level limit controls both forms and gives a sharp fixed-machine value when the system is optimized. A full closed-form classification in the continuously varying two-weight ratio and a fixed-system formula with simultaneous resonance and multiplicity remain open. [Mishra–Senthilkumar, Appendix S11](https://arxiv.org/pdf/2610.40709#page=10) · [Shiraishi, §3.4, equations (36)–(38)](https://arxiv.org/pdf/2004.14751#page=12)

# References

1. A. Mishra and A. Senthilkumar. *Finite-resource cooling of qudits beyond thermodynamic length*. arXiv:2610.40709v1 (2026), especially equations (3), (7), Theorems 1--2, and Appendix S11. [Fixed-version primary text](https://arxiv.org/html/2610.40709v1).

2. *Continuation: two-weight three-level machines and nondegenerate systems*. Unpublished draft, 24 November 2026. Pre-existing candidate derivation.

3. *Second-order dissipation bound for a two-level system with an arbitrary-dimensional thermal machine*. Earlier related manuscript; the system there has two levels.

4. *Second-order cooling dissipation bound for arbitrary three-level system and machine spectra*. Earlier related manuscript; that case treats three system levels.

5. P. Taranto et al. *Efficiently Cooling Quantum Systems with Finite Resources: Insights from Thermodynamic Geometry*. Physical Review Letters **134**, 070401 (2025). [Primary article](https://doi.org/10.1103/PhysRevLett.134.070401).