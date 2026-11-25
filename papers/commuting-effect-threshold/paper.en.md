---
title: "Lüders coarse-graining can increase a measurement-order score"
subtitle: "An exact qubit family and a sharp threshold"
date: "24 November 2026"
lang: en-US
fontsize: 11pt
geometry: margin=23mm
colorlinks: true
---

## Abstract

We answer a specific question left open by Wu's measurement-order framework: whether merging POVM effects and implementing the Lüders instrument of each merged effect can increase the total-variation order score optimized over the common input state. We construct two three-outcome qubit POVMs, with all effects of the measurement being merged diagonal, and determine both optimized scores for an entire real parameter family. For $1/4\le s\le1$, the fine score is $(1-s^2)\sqrt5/10$, while the score after merging two outcomes is the maximum of this value and $(1-s)(3+8s)/20$. Strict increase occurs exactly for $(5\sqrt5-2)/22<s<1$. The rational instance $s=3/4$ gives $7\sqrt5/160<9/80$. The proof covers every complex density matrix, supplies positive square roots and optimal input states, and is accompanied by an exhaustive rational event certificate. Dimension two and three outcomes on the measurement being merged are minimal in the elementary senses stated below. The result concerns this optimized TV score for specified Lüders instruments; classical processing of completed records remains contractive. A concurrent internal construction gives the same general negative answer with a binary partner; the additional content here is the commuting fine-effect family and its exact parameter classification.

# 1. The precise question

Wu defines distances between the complete joint outcome records obtained by applying two measurements in opposite orders to the same input state [1, Definition 1, p. 3]. After Proposition 1(ii), the paper distinguishes processing an already produced classical record from merging measurement effects and then applying the Lüders instrument of the merged effect. Monotonicity under the latter operation is left unresolved [1, Sec. II.B, p. 4; Sec. VIII, p. 15]. We show that general nonincrease fails for the optimized total-variation score $T$.

This distinction is essential. If outcomes in a set $C$ are forgotten after a fine Lüders measurement, its unnormalized outcome operation is

$$
\rho\longmapsto\sum_{a\in C}\sqrt{A_a}\,\rho\,\sqrt{A_a}.
$$

If the effects are merged first, the new Lüders operation is

$$
\rho\longmapsto
\sqrt{\sum_{a\in C}A_a}\,\rho\,\sqrt{\sum_{a\in C}A_a}.
$$

These operations can differ. The comparison below uses the second operation for the coarse measurement. It does not infer an increase from that difference alone: an explicit construction and optimization over all states are needed.

# 2. Definitions and conventions

A finite POVM $A=(A_a)$ on $\mathbb C^2$ consists of positive semidefinite matrices summing to $I$. Its Lüders outcome operation is $\rho\mapsto\sqrt{A_a}\rho\sqrt{A_a}$, with the unique positive square root. For a second POVM $B=(B_b)$ define

$$
X_{ab}=\sqrt{A_a}B_b\sqrt{A_a},\qquad
Y_{ab}=\sqrt{B_b}A_a\sqrt{B_b},\qquad
D_{ab}=X_{ab}-Y_{ab}.
$$

The probabilities for the two orders are $p_{ab}=\operatorname{Tr}(\rho X_{ab})$ and $q_{ab}=\operatorname{Tr}(\rho Y_{ab})$. Labels are aligned by measurement identity $(a,b)$ in both records. In particular, reversing the measurement order does not swap the meaning of the outcome coordinates. Both records use the **same** input density matrix $\rho$.

We use Wu's score [1]:

$$
T(A,B)=\max_{\rho\succeq0,\ \operatorname{Tr}\rho=1}
\frac12\sum_{a,b}\left|\operatorname{Tr}(\rho D_{ab})\right|.
\tag{1}
$$

The optimization includes all complex density matrices. The maximum exists by continuity on the compact state space. Write

$$
H(x,z)=\begin{pmatrix}z&x\\x&-z\end{pmatrix}.
\tag{2}
$$

For later verification, Wu already gives the finite-event identity

$$
T(A,B)=\max_{S}\lambda_{\max}
\left(\sum_{(a,b)\in S}D_{ab}\right).
\tag{3}
$$

Equation (3) is an existing tool [1, Eq. (3)], not a contribution of this work. Our main proof can also be read without using it.

# 3. Exact family and main theorem

Fix the three-outcome POVM

$$
B_0=\begin{pmatrix}3/4&0\\0&0\end{pmatrix},\qquad
B_\epsilon=\begin{pmatrix}1/8&\epsilon/4\\\epsilon/4&1/2\end{pmatrix},
\quad \epsilon\in\{+1,-1\}.
\tag{4}
$$

For a real parameter $1/4\le s\le1$, set $d=1-s^2$ and

$$
\begin{aligned}
A_0(s)&=\frac{16s^2-1}{15}I,\\
A_1(s)&=\frac d{15}\begin{pmatrix}16&0\\0&1\end{pmatrix},\\
A_2(s)&=d\begin{pmatrix}0&0\\0&1\end{pmatrix}.
\end{aligned}
\tag{5}
$$

Merge outcomes $0$ and $1$, giving

$$
\bar A_0(s)=A_0(s)+A_1(s)=\operatorname{diag}(1,s^2),\qquad
\bar A_1(s)=A_2(s).
\tag{6}
$$

**Theorem 1.** The matrices in (4)--(6) are POVMs. Under their respective Lüders instruments,

$$
T(A(s),B)=\frac{(1-s^2)\sqrt5}{10},
\tag{7}
$$

$$
T(\bar A(s),B)=
\max\left\{\frac{(1-s^2)\sqrt5}{10},
\frac{(1-s)(3+8s)}{20}\right\}.
\tag{8}
$$

Consequently, over $s\in[1/4,1]$,

$$
T(\bar A(s),B)>T(A(s),B)
\quad\Longleftrightarrow\quad
\frac{5\sqrt5-2}{22}<s<1.
\tag{9}
$$

The equality region is $1/4\le s\le(5\sqrt5-2)/22$, together with the endpoint $s=1$. In particular, at $s=1$ both scores vanish; the endpoint is not included in the strict-increase region.

**Corollary 2 (rational counterexample).** At $s=3/4$,

$$
A_0=\frac8{15}I,\qquad
A_1=\operatorname{diag}(7/15,7/240),\qquad
A_2=\operatorname{diag}(0,7/16),
$$

and $\bar A_0=\operatorname{diag}(1,9/16)$. The exact optimized scores are

$$
\boxed{T(A,B)=\frac{7\sqrt5}{160}
<\frac9{80}=T(\bar A,B).}
\tag{10}
$$

This is a $3$-to-$2$ outcome merge on one side of a pair of three-outcome qubit POVMs. All three fine effects $A_a$ commute with one another.

# 4. Constructive proof

## 4.1. Valid measurements and positive square roots

On the parameter interval, $d\ge0$ and $(16s^2-1)/15\ge0$. Thus all $A_a$ are positive. Their two diagonal sums are both one. The matrices $B_b$ are positive rank-one matrices and sum to $I$. These statements also show that every effect is bounded above by $I$.

The positive roots of (5)--(6) are

$$
\begin{aligned}
\sqrt{A_0}&=\sqrt{(16s^2-1)/15}\,I,\\
\sqrt{A_1}&=\sqrt{d/15}\,\operatorname{diag}(4,1),\\
\sqrt{A_2}&=\sqrt d\,\operatorname{diag}(0,1),\\
\sqrt{\bar A_0}&=\operatorname{diag}(1,s),\qquad
\sqrt{\bar A_1}=\sqrt{A_2}.
\end{aligned}
\tag{11}
$$

Every displayed matrix is positive and squares to its effect, including at the endpoints. For each $B_b$, its positive trace $t_b$ is $3/4$ or $5/8$, and $B_b^2=t_bB_b$. Therefore

$$
\sqrt{B_b}=B_b/\sqrt{t_b},\qquad
\sqrt{B_b}E\sqrt{B_b}=B_bEB_b/t_b.
\tag{12}
$$

These formulas fix the instrument and remove scalar square roots from every sequential record effect.

## 4.2. Record matrices

For $\epsilon=\pm1$, multiplication of (11)--(12) gives

$$
\begin{aligned}
X_{1,\epsilon}&=\frac d{30}
\begin{pmatrix}4&2\epsilon\\2\epsilon&1\end{pmatrix},&
Y_{1,\epsilon}&=\frac d{30}
\begin{pmatrix}1&2\epsilon\\2\epsilon&4\end{pmatrix},\\
X_{2,\epsilon}&=\frac d2
\begin{pmatrix}0&0\\0&1\end{pmatrix},&
Y_{2,\epsilon}&=\frac d{10}
\begin{pmatrix}1&2\epsilon\\2\epsilon&4\end{pmatrix}.
\end{aligned}
\tag{13}
$$

For the merged outcome,

$$
\bar X_{0,\epsilon}=
\begin{pmatrix}1/8&\epsilon s/4\\\epsilon s/4&s^2/2\end{pmatrix},\qquad
\bar Y_{0,\epsilon}=\frac{1+4s^2}{40}
\begin{pmatrix}1&2\epsilon\\2\epsilon&4\end{pmatrix}.
\tag{14}
$$

The $B_0$ column has zero difference because its effects commute with all $A_a$. The scalar $A_0$ row also has zero difference. The other coarse row equals the fine $A_2$ row.

Define

$$
z=\frac{1-s^2}{10},\qquad k=2z,\qquad
\ell=\frac{(1-s)(4s-1)}{20}.
\tag{15}
$$

The complete difference tables are as follows.

| Fine $D_{ab}$ | $B_0$ | $B_+$ | $B_-$ |
|:--|:--:|:--:|:--:|
| $A_0$ | $0$ | $0$ | $0$ |
| $A_1$ | $0$ | $H(0,z)$ | $H(0,z)$ |
| $A_2$ | $0$ | $H(-k,-z)$ | $H(k,-z)$ |

| Coarse $\bar D_{ab}$ | $B_0$ | $B_+$ | $B_-$ |
|:--|:--:|:--:|:--:|
| $\bar A_0$ | $0$ | $H(\ell,z)$ | $H(-\ell,z)$ |
| $\bar A_1$ | $0$ | $H(-k,-z)$ | $H(k,-z)$ |

Throughout the parameter interval,

$$
z\ge0,\qquad 0\le\ell\le k=2z,
\qquad k-\ell=\frac{1-s}{4}.
\tag{16}
$$

## 4.3. Every complex input state is covered

An arbitrary complex qubit density matrix has the form

$$
\rho=\begin{pmatrix}a&c+it\\c-it&1-a\end{pmatrix},
\qquad a,c,t\in\mathbb R.
$$

Positivity implies $0\le a\le1$ and $c^2+t^2\le a(1-a)$. With

$$
X=2c,\qquad Z=2a-1,
$$

we have $X^2+Z^2\le1$ and

$$
\operatorname{Tr}(\rho H(x,z))=xX+zZ.
\tag{17}
$$

The imaginary entry has not been excluded: its contribution to positivity only tightens this disk constraint. Conversely, the witness states below are positive density matrices and so belong to the full optimization domain.

## 4.4. Exact optimization

For real $u,v$,

$$
|u+v|+|u-v|=2\max(|u|,|v|).
\tag{18}
$$

Apply (18) to the two tables. Writing $V_{\mathrm f}(\rho)$ and $V_{\mathrm c}(\rho)$ for the unoptimized TV distances gives

$$
V_{\mathrm f}(\rho)
=z|Z|+\max(k|X|,z|Z|)
=\max\{k|X|+z|Z|,\,2z|Z|\},
\tag{19}
$$

and

$$
\begin{aligned}
V_{\mathrm c}(\rho)
&=\max(\ell|X|,z|Z|)+\max(k|X|,z|Z|)\\
&=\max\{(k+\ell)|X|,\,k|X|+z|Z|,\,2z|Z|\}.
\end{aligned}
\tag{20}
$$

The last equality uses $\ell\le k$ to discard the dominated term $\ell|X|+z|Z|$. Cauchy--Schwarz and (17) yield

$$
k|X|+z|Z|\le\sqrt{k^2+z^2}=\sqrt5\,z.
$$

Also $|X|,|Z|\le1$ and $2z\le\sqrt5z$. Thus

$$
V_{\mathrm f}(\rho)\le\sqrt5z,\qquad
V_{\mathrm c}(\rho)\le\max\{\sqrt5z,k+\ell\}
\tag{21}
$$

for every complex density matrix.

Both needed lower bounds are constructive. Let

$$
\rho_{\mathrm f}=\frac12
\begin{pmatrix}1+1/\sqrt5&2/\sqrt5\\2/\sqrt5&1-1/\sqrt5\end{pmatrix},
\qquad
\rho_+=\frac12\begin{pmatrix}1&1\\1&1\end{pmatrix}.
\tag{22}
$$

Each is positive, has trace one and determinant zero. The first has $(X,Z)=(2/\sqrt5,1/\sqrt5)$. Its four fine expectations are $z/\sqrt5,z/\sqrt5,-5z/\sqrt5,3z/\sqrt5$, giving $V_{\mathrm f}(\rho_{\mathrm f})=\sqrt5z$. Equation (20) gives $V_{\mathrm c}(\rho_{\mathrm f})\ge\sqrt5z$. The state $\rho_+$ has coarse expectations $\ell,-\ell,-k,k$, giving $V_{\mathrm c}(\rho_+)=k+\ell$. Hence

$$
T(A(s),B)=\sqrt5z,\qquad
T(\bar A(s),B)=\max\{\sqrt5z,k+\ell\}.
$$

Substituting (15) proves (7)--(8). These are optimized equalities, not comparisons of selected input states.

## 4.5. Sharp boundary and rational instance

For $s<1$, strict increase is equivalent to

$$
3+8s>2\sqrt5(1+s).
$$

Both sides are positive. Squaring gives $44s^2+8s-11>0$, equivalently $(22s+2)^2>125$. Since $22s+2>0$ on the domain, the threshold is $(5\sqrt5-2)/22$. At $s=1$, $z=k=\ell=0$, proving the separate endpoint assertion and completing Theorem 1.

At $s=3/4$, $(z,k,\ell)=(7/160,7/80,1/40)$. The coarse branch is $k+\ell=9/80$; it exceeds $7\sqrt5/160$ because $18^2=324>245=(7\sqrt5)^2$. This proves Corollary 2. On the same state $\rho_+$, the fine TV is $7/80$ and the coarse TV is $9/80$; the all-state fine upper bound is what makes (10) the stronger optimized claim.

# 5. Mechanism, minimality and scope

The construction isolates the instrument change even though the fine $A_a$ commute. For the unnormalized operation associated with the merged label, the fine instrument with its internal label discarded multiplies an off-diagonal entry of $\rho$ by

$$
\gamma_{\mathrm f}=\frac{1+4s^2}{5},
$$

whereas the merged Lüders operation multiplies it by $\gamma_{\mathrm c}=s$. Their diagonal action is the same, and

$$
\gamma_{\mathrm c}-\gamma_{\mathrm f}
=\frac{(1-s)(4s-1)}5=4\ell.
$$

Thus merging effects changes how coherence is retained, producing the extra off-diagonal differences in the coarse table. No classical data-processing inequality is violated. For any common stochastic map $K$, the triangle inequality still gives $\operatorname{TV}(Kp,Kq)\le\operatorname{TV}(p,q)$. In our experiment the coarse forward record is generally not $Kp$ for the label-erasure map.

Two modest minimality statements follow directly. In dimension one all effects are scalars, so $\sqrt{A_a}B_b\sqrt{A_a}=A_aB_b=\sqrt{B_b}A_a\sqrt{B_b}$ and every order score is zero. Therefore dimension two is minimal. A nontrivial deterministic merge of a two-outcome POVM produces the sole effect $I$. Its order score with any other Lüders POVM is zero, so a strict increase requires at least three fine outcomes on the measurement being merged. Our example attains both bounds.

We make no minimality claim for the partner measurement's number of outcomes, the total number of outcomes, the rational coefficient size, or the achievable gap. The theorem concerns general POVMs and $T$ only. It does not settle the corresponding questions for projective-only measurements, Jensen--Shannon scores, or squared Hellinger scores, and it does not alter the other inequalities or conjectures in [1]. Nor does it claim that coarse-graining creates effect-level measurement incompatibility: compatibility is preserved by classical outcome processing [4, Sec. II.C].

# 6. Related work and bounded novelty statement

The distinction between an order-record score and other disturbance or incompatibility quantities matters for interpreting this result. Mandayam and Srinivas compare the distribution of a second measurement after a first measurement with that second measurement's distribution without the first [2]. Their optimized marginal disturbance is a different functional from the complete opposite-order joint-record distance in (1).

Gao et al. study mutual eigenspace disturbance for projective measurements. Their Supplemental Proposition 1 proves a coarse-graining inequality under the condition that the state commute with the observable being coarse-grained; the maximally mixed state used in their default construction satisfies that condition [3, combined PDF p. 6]. Their functional, measurement class and state quantifier differ from those of Theorem 1.

Nonmonotonicity under processing has already appeared for other incompatibility quantifiers. Designolle, Farkas and Kaniewski analyze several robustness quantities and give a random-robustness counterexample obtained by splitting a qubit measurement outcome [4, Appendix A, Counterexample 3]. That example is not a computation of (1) under a three-to-two merged-effect Lüders operation. Robustness frameworks [4,5] and classifications of compatibility under processing [6] also address distinct questions.

The independent literature check dated 24 November 2026 read the original papers [1]--[6] and inspected the declared scope of a concurrent report on angular monotonicity of Wu's binary sharp-qubit Jensen--Shannon score [7]. That report concerns a different score and operation; its external Lean project was not recompiled in this check. A final repository check located a concurrent internal draft [8] with a different three-to-two merge, noncommuting fine effects, and a binary partner. Its optimized scores are $1/30$ and $9/250$, so it gives the same general negative answer. We do not count the shared refutation as two distinct problem resolutions or claim priority between the parallel drafts. The additional content of this manuscript is the family with pairwise commuting fine effects, its exact optimized values for every parameter, and the sharp threshold. Within the recorded sources, no equivalent all-parameter formulas and sharp threshold for this explicit commuting-effect family were located. This bounded check is not a guarantee of worldwide priority. The TV event identity and classical contractivity remain attributed existing tools.

# 7. Reproducibility and verification status

The accompanying script `code/exact_certificate.py` uses Python standard-library rational arithmetic. It checks positivity and normalization of the rational effects, the rank-one sandwich identities, both difference tables, and all $2^9=512$ fine and $2^6=64$ coarse events for the instance $s=3/4$. Its largest event squared norms are exactly $49/5120$ and $81/6400$. It also checks the same-state witnesses and nine rational parameter values, including both endpoints. Explicit checks remain active with Python optimization enabled. From the case directory, run

```sh
python3 -B -O code/exact_certificate.py
```

The expected record is `results/exact_certificate.json`. These finite checks are independently reproducible arithmetic evidence. The proof of Theorem 1, including its continuous parameter and all-complex-state quantifiers, is the analytic argument above; checking finitely many parameters alone would not establish it.

**Formal verification status.** Full Lean certification and the repository's mandatory isolated public-release gate have not been completed. The supplied Lean source is a development artifact; a foundation module compiled separately, which does not certify the whole manuscript. Actual build attempts, scope findings and remaining requirements are recorded alongside the source. The result is supported by the complete analytic proof and independent exact checks above. This is an AI-assisted research manuscript without external peer review.

# Appendix A. Complete finite-event certificate

For $H(x,z)$, direct multiplication gives $H(x,z)^2=(x^2+z^2)I$, so its maximum eigenvalue is $\sqrt{x^2+z^2}$. For equal-mass probability records, $\tfrac12\sum_j|p_j-q_j|=\max_S\sum_{j\in S}(p_j-q_j)$. Maximizing over states and the finite event set gives (3), reproducing the known formula in this particular setting.

Both difference tables have only four potentially nonzero entries. Put

$$
v_0=(\ell,z),\quad v_1=(-\ell,z),\quad
v_2=(-k,-z),\quad v_3=(k,-z).
$$

The coarse table uses (15), and the fine table is the specialization $\ell=0$. Membership of zero entries does not change an event sum. The full list is

| Event $S$ | $\sum_{j\in S}v_j$ |
|:--|:--:|
| $\varnothing$ | $(0,0)$ |
| $\{0\}$ | $(\ell,z)$ |
| $\{1\}$ | $(-\ell,z)$ |
| $\{2\}$ | $(-k,-z)$ |
| $\{3\}$ | $(k,-z)$ |
| $\{0,1\}$ | $(0,2z)$ |
| $\{0,2\}$ | $(\ell-k,0)$ |
| $\{0,3\}$ | $(\ell+k,0)$ |
| $\{1,2\}$ | $(-\ell-k,0)$ |
| $\{1,3\}$ | $(k-\ell,0)$ |
| $\{2,3\}$ | $(0,-2z)$ |
| $\{0,1,2\}$ | $(-k,z)$ |
| $\{0,1,3\}$ | $(k,z)$ |
| $\{0,2,3\}$ | $(\ell,-z)$ |
| $\{1,2,3\}$ | $(-\ell,-z)$ |
| $\{0,1,2,3\}$ | $(0,0)$ |

Under (16) the largest length is

$$
\max\{\sqrt{\ell^2+z^2},\sqrt{k^2+z^2},2z,k+\ell\}
=\max\{\sqrt5z,k+\ell\}.
$$

For $\ell=0$ this is $\sqrt5z$. This provides a second exact derivation of both scores and a complete certificate for the finite enumeration used by the script.

# References

1. S. Wu, *Measurement-order dependence bounds uncertainty, contextuality, steering, and Bell nonlocality*, arXiv:2611.24604v1 (18 November 2026). [Versioned source](https://arxiv.org/abs/2611.24604v1). Relevant locations: Definition 1 and Eq. (3), p. 3; Sec. II.B after Proposition 1(ii), p. 4; Sec. VIII, p. 15.

2. P. Mandayam and M. D. Srinivas, *Measures of disturbance and incompatibility for quantum measurements*, Physical Review A **89**, 062112 (2014). [arXiv:1402.0810v3](https://arxiv.org/abs/1402.0810v3); [DOI](https://doi.org/10.1103/PhysRevA.89.062112).

3. N. Gao, D. Li, A. Mishra, J. Yan, K. Simonov and G. Chiribella, *Measuring incompatibility and clustering quantum observables with a quantum switch*, Physical Review Letters **130**, 170201 (2023). [arXiv:2208.06210v4](https://arxiv.org/abs/2208.06210v4); [DOI](https://doi.org/10.1103/PhysRevLett.130.170201). Supplemental Proposition 1 is on p. 6 of the combined PDF.

4. S. Designolle, M. Farkas and J. Kaniewski, *Incompatibility robustness of quantum measurements: a unified framework*, New Journal of Physics **21**, 113053 (2019). [arXiv:1906.00448v5](https://arxiv.org/abs/1906.00448v5); [DOI](https://doi.org/10.1088/1367-2630/ab5020).

5. T. Heinosaari, J. Kiukas and D. Reitzner, *Noise robustness of the incompatibility of quantum measurements*, Physical Review A **92**, 022115 (2015). [arXiv:1501.04554v3](https://arxiv.org/abs/1501.04554v3); [DOI](https://doi.org/10.1103/PhysRevA.92.022115).

6. A. K. Das, S. Mukherjee, D. Saha, D. Das and A. S. Majumdar, *Classifying Measurement Incompatibility under Classical Pre- and Post-Processing Operations*, Proceedings of the Royal Society A **482**, 20250045 (2026). [arXiv:2401.01236v3](https://arxiv.org/abs/2401.01236v3); [DOI](https://doi.org/10.1098/rspa.2025.0045).

7. the-omega-institute/trureturing, *Monotonicity of Wu's qubit Jensen--Shannon order score*, repository report, inspected 24 November 2026. [Declared problem and result](https://the-omega-institute.github.io/trureturing-mdbook/Problems/wu-2026-qubit-order-score-monotonicity.html). The accompanying source manifest records the inspected commit and its declared scope.

8. Related unpublished research draft, 24 November 2026; not an established priority claim.
