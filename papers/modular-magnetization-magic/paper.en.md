---
title: "Magic under finite-resolution magnetization projection"
subtitle: "Uniform variational laws, phase offsets, and near-Dicke states"
author: "AI-assisted research manuscript"
date: "24 November 2026"
lang: en
---

## Abstract

We study the second stabilizer Rényi entropy of a spin-coherent product state after its excitation number has been restricted to a set of allowed values. The principal example is a measurement of excitation number modulo an integer $K$. For a product state with real nonnegative amplitudes, we prove a finite-size variational formula whose error is $O(\log N)$, uniformly over every nonempty set of allowed sectors, every modulus and residue, and every product-state latitude $p\in(0,1)$. The formula combines the known Dicke-state magic density with two distinct relative-entropy minimizations. One selects the sector controlling the norm; the other selects the sector controlling the fourth Pauli moment. On an arithmetic grid, each minimization requires at most two adjacent candidate sectors.

The proof uses the known Gowers-cube representation and triangle inequality for the fourth Pauli moment, a positivity comparison between sector contributions, and an explicit admissible type in a sixteen-column counting problem. The last step gives a uniform version of the known Dicke density without requiring a local central limit theorem. For arbitrary phases between sectors, polynomial number filters give an additional $O(N/K)$ error, which is subextensive whenever $K$ diverges. Root-of-unity filters separately determine the density for bounded moduli and arbitrary azimuthal offsets.

Every diverging sublinear modulus has the least coherent-branch magic density, whereas a linear modulus retains a finite-grid variational law. In particular, centered moduli satisfying $\sqrt N\ll K\ll N$ produce states converging in trace distance to a Dicke state while retaining a generally different magic density. The general sensitivity of stabilizer Rényi entropies is established prior work; our result identifies and quantifies its occurrence in this number-projection family. This manuscript gives analytic proofs and reproducible finite-size checks. It does not claim external peer review, a Lean certification, or global priority beyond the documented literature comparison.

## 1. The question and its scope

The excitation number of a collection of qubits can be fixed exactly, retained only modulo an integer, or restricted to a prescribed collection of values. These operations can produce states that are close in norm but have different distributions of Pauli expectation values. The distinction matters when nonstabilizerness is quantified by a high-order moment of those expectations.

Kwan [1] derived the thermodynamic second stabilizer Rényi entropy of Dicke states, together with sharper subleading terms at fixed filling. The same work represents a Dicke state as a Fourier projection of spin-coherent product states and asks how the magic density changes when only a finite number of phase branches is retained. Retaining $K$ equally spaced branches constrains excitation number modulo $K$, rather than fixing it exactly. We address that resolution question, with the phase convention and asymptotic regime stated explicitly.

The question has two separate aspects. First, which retained number sector controls the normalization of the projected state? Second, which sector controls the exponentially small fourth Pauli moment? The two answers need not coincide. A sector with a small norm weight can still dominate the moment if its intrinsic magic is sufficiently low. Our variational formula separates these effects.

Several mathematical ingredients are already known. The fourth Pauli moment is a Gowers-$3$ cube expression, and its eighth root obeys a triangle inequality; see Arunachalam and Dutt [2, Section 3, Eqs. (22) and (24)]. The Dicke density, its variational representation, and the sixteen-column count used below are due to Kwan [1]. We reproduce the parts needed for a self-contained argument and do not claim those identities or the underlying norm as new. Haug and Piroli [3] established sensitivity and monotonicity limitations of stabilizer entropies; we do not claim the first example of such sensitivity.

The results established here concern the projection-resolution law, its uniform finite-size control, its efficient scalar evaluation, and the distinction between norm-dominating and moment-dominating sectors in this concrete family. The strongest finite-size theorem assumes real nonnegative amplitudes. Arbitrary azimuthal offsets are treated by separate theorems, with different error bounds. No statement about the full resource-theoretic preparation cost or optimal distillation yield follows merely from the entropy formulas.

Related work on permutation-invariant systems already reduces Pauli sums to polynomially many symmetry types and gives coherent-state formulas [5]. Work on deterministic pure-state monotonicity treats a different operational question [6]; the analytic filters used here are not assumed to be free stabilizer operations. Spin-cat and metrological calculations [7] provide further context, but their state preparation and approximation regimes do not supply the uniform modular-projection estimate proved below. The accompanying novelty audit compares these assumptions and also distinguishes deterministic projection from random-superposition and phase-averaged quantities.

## 2. Definitions and principal result

### 2.1. Pauli moment and Dicke states

Let $\mathcal P_N=\{I,X,Y,Z\}^{\otimes N}$ be the Hermitian Pauli strings. For a normalized pure state $\lvert\psi\rangle$, define

$$
W_N(\psi)=2^{-N}\sum_{P\in\mathcal P_N}
\langle\psi\rvert P\lvert\psi\rangle^4,
\qquad M_2(\psi)=-\log_2 W_N(\psi).
\tag{1}
$$

This is the second stabilizer Rényi entropy introduced in [4]. All entropies and logarithms in the formulas below use base two unless explicitly indicated. Natural logarithms appear only in elementary analytic estimates.

The normalized Dicke state with $n$ excitations is

$$
\lvert D_n^N\rangle=\binom Nn^{-1/2}
\sum_{\substack{x\in\{0,1\}^N\\ |x|=n}}\lvert x\rangle.
\tag{2}
$$

For $0<p<1$, let $\lvert v_p\rangle=\sqrt{1-p}\lvert0\rangle+\sqrt p\lvert1\rangle$. Given any nonempty set $\Omega\subseteq\{0,\ldots,N\}$, define

$$
b_n=\binom Nn p^n(1-p)^{N-n},\qquad
Z_\Omega=\sum_{n\in\Omega}b_n,
\qquad
\lvert\Psi_{\Omega,p}\rangle=
Z_\Omega^{-1/2}\sum_{n\in\Omega}\sqrt{b_n}\,\lvert D_n^N\rangle.
\tag{3}
$$

The positive number $Z_\Omega$ is the probability of the retained event in a binomial distribution. It must be kept even when it is exponentially small. Equation (3) specifies coherent projection followed by normalization; it is not an incoherent mixture of Dicke states.

The modular example is

$$
\Omega_{N,K,r}=\{n\in\{0,\ldots,N\}:n\equiv r\pmod K\},
\tag{4}
$$

where $K\ge1$ is an integer and the accessible set is required to be nonempty. If $K>N$, a nonempty set in (4) has one element and the normalized state is exactly a Dicke state.

### 2.2. The known Dicke density

Write

$$
h_2(f)=-f\log_2 f-(1-f)\log_2(1-f),
$$

with the usual endpoint convention. For $0<f<1$, let $\tau(f)>0$ solve

$$
(1-f)\tau^2+7(1-2f)\tau-f=0.
\tag{5}
$$

Set

$$
\mathcal H(f)=\log_2(1+14\tau(f)+\tau(f)^2)
-2f\log_2\tau(f),
\qquad
\alpha(f)=4h_2(f)-\mathcal H(f).
\tag{6}
$$

We use the continuous extension $\alpha(0)=\alpha(1)=0$. This is Kwan's Dicke magic density [1], not a new density function. Define also the Bernoulli relative entropy

$$
D(f\Vert p)=f\log_2\frac fp+(1-f)\log_2\frac{1-f}{1-p},
\tag{7}
$$

and the finite-grid expression

$$
V_{N,\Omega,p}=
\min_{n\in\Omega}\left\{\alpha(n/N)+4D(n/N\Vert p)\right\}
-4\min_{n\in\Omega}D(n/N\Vert p).
\tag{8}
$$

Both minima in (8) run over the actual accessible set. In particular, endpoint sectors absent from that set are not inserted by taking a formal continuum limit.

### 2.3. Uniform projection theorem

**Theorem 1 (uniform positive-amplitude law).** Let $N\ge28$, $0<p<1$, and let $\Omega\subseteq\{0,\ldots,N\}$ be nonempty. Put $m=|\Omega|$, $\ell_N=\log_2(N+1)$, and

$$
E_N=N h_2(14/N)+14\log_2 15+16\ell_N.
\tag{9}
$$

Then

$$
N V_{N,\Omega,p}-8\ell_N-8\log_2m
\le M_2(\Psi_{\Omega,p})
\le N V_{N,\Omega,p}+E_N+4\ell_N+4\log_2m.
\tag{10}
$$

Consequently,

$$
M_2(\Psi_{\Omega,p})=N V_{N,\Omega,p}+O(\log(N+1)),
\tag{11}
$$

with a constant independent of $p\in(0,1)$ and of the nonempty sector set. In particular, the bound is uniform in every admissible modulus and residue.

The constants are deliberately elementary. They establish uniformity rather than a sharp logarithmic correction. Small systems $N<28$ can be evaluated directly, and do not affect any limit below. At the latitude endpoints $p=0,1$, conditioning can have probability zero; those cases are excluded from the theorem and can be handled directly whenever the retained event has positive probability.

The proof occupies Sections 3--5. Sections 6--8 derive the resolution regimes, the phase-dependent extension, and the near-Dicke consequence.

## 3. Two fourth-moment comparisons

### 3.1. The positive cube formula

For any unnormalized complex amplitude vector $\psi(x)$, let $\widetilde W_N(\psi)$ denote the right-hand side of (1). This expression is homogeneous of degree eight in the modulus of a scalar multiplier, so

$$
W_N(\psi/\|\psi\|)=\widetilde W_N(\psi)/\|\psi\|^8.
$$

For the cube formula in this subsection, now assume the amplitudes are real. Represent a Hermitian Pauli by $P_{a,z}=i^{a\cdot z}X^aZ^z$, where $a,z\in\{0,1\}^N$ and the exponent is the integer dot product. The action on a basis vector is
$X^aZ^z\lvert y\rangle=(-1)^{z\cdot y}\lvert y\oplus a\rangle$.
Expanding the fourth power and summing over $z$ gives

$$
\widetilde W_N(\psi)=
\sum_a\sum_{y_1\oplus y_2\oplus y_3\oplus y_4=0}
\prod_{j=1}^4\psi(y_j)\psi(y_j\oplus a).
\tag{12}
$$

Indeed, the fourth power of $i^{a\cdot z}$ equals one, and the character average
$2^{-N}\sum_z(-1)^{z\cdot(y_1\oplus\cdots\oplus y_4)}$ enforces the XOR constraint. Equation (12) is the real-amplitude form of the known Gowers-cube identity [2]. The change of variables $y_1=x$, $y_2=x\oplus u$, $y_3=x\oplus v$, $y_4=x\oplus u\oplus v$ exhibits its eight cube vertices directly.

When every amplitude is nonnegative, every term in (12) is nonnegative. This elementary sign property is the reason for the stronger theorem in that setting. It cannot be assumed for generic phases.

### 3.2. Weighted triangle inequality

We record the relevant known norm inequality in the normalization used here.

**Lemma 2 (weighted branch comparison).** For normalized pure states $\phi_j$, complex coefficients $c_j$, and nonzero $\Phi=\sum_jc_j\phi_j$,

$$
W_N(\Phi/\|\Phi\|)^{1/8}
\le\frac{\sum_j|c_j|W_N(\phi_j)^{1/8}}{\|\Phi\|}.
\tag{13}
$$

This is the triangle inequality associated with the Gowers-$3$ representation [2]. It also follows by replacing the maximum-branch step in [1, Appendix A.1] by Hölder. For completeness, the following argument proves precisely the form needed here.

The operator $T_N=\sum_{P\in\mathcal P_N}P^{\otimes4}$ is positive semidefinite: for one qubit, $(I^{\otimes4}+X^{\otimes4}+Y^{\otimes4}+Z^{\otimes4})/4$ is an orthogonal projector, and tensoring gives the general case. For $V_I=\phi_{i_1}\otimes\cdots\otimes\phi_{i_4}$, positive-semidefinite Cauchy--Schwarz bounds

$$
|\langle V_J,T_NV_I\rangle|
\le\langle V_I,T_NV_I\rangle^{1/2}
\langle V_J,T_NV_J\rangle^{1/2}.
$$

Hölder bounds the diagonal term by

$$
0\le\langle V_I,T_NV_I\rangle
\le\prod_{a=1}^4\left(\sum_P
|\langle\phi_{i_a}|P|\phi_{i_a}\rangle|^4\right)^{1/4}
=2^N\prod_{a=1}^4W_N(\phi_{i_a})^{1/4}.
$$

Expanding the eight coefficient factors and taking absolute values therefore gives
$\widetilde W_N(\Phi)\le(\sum_j|c_j|W_N(\phi_j)^{1/8})^8$.
Normalization proves (13).

### 3.3. Positive branches and a finite soft minimum

**Lemma 3 (positive-branch comparison).** Suppose the normalized states $\phi_1,\ldots,\phi_m$ have real nonnegative computational-basis amplitudes and $c_j>0$. Let $\Phi=\sum_jc_j\phi_j$, $Z=\|\Phi\|^2$, and $x_j=c_jW_N(\phi_j)^{1/8}$. Then

$$
Z^{-4}\sum_jx_j^8\le W_N(\Phi/\sqrt Z)
\le Z^{-4}\left(\sum_jx_j\right)^8
\le Z^{-4}m^7\sum_jx_j^8.
\tag{14}
$$

**Proof.** Substitute the sum of branches in each of the eight amplitude factors in (12). Retain the terms in which all eight branch indices are equal. Their total is $\sum_jc_j^8W_N(\phi_j)$, and every discarded term is nonnegative. This proves the first inequality. No orthogonality is required: when supports overlap, the retained terms are still distinct terms in the distributive expansion. The second inequality is Lemma 2. The last is Hölder, $(\sum_jx_j)^8\le m^7\sum_jx_j^8$. Normalization contributes $Z^{-4}$ throughout. $\square$

For the Dicke-sector superposition (3), define

$$
S_\Omega=-\log_2\sum_{n\in\Omega}b_n^4\,2^{-M_2(D_n^N)}
+4\log_2Z_\Omega.
$$

Lemma 3 yields the exact finite-size bound

$$
S_\Omega-7\log_2m\le M_2(\Psi_{\Omega,p})\le S_\Omega.
\tag{15}
$$

Equivalently, with $F_n=M_2(D_n^N)-4\log_2b_n$,

$$
\min_{n\in\Omega}F_n+4\log_2Z_\Omega-8\log_2m
\le M_2(\Psi_{\Omega,p})
\le\min_{n\in\Omega}F_n+4\log_2Z_\Omega.
\tag{16}
$$

Equation (15) is slightly sharper than (16). The latter exposes the two minimizations in the final density formula. For one sector, both inequalities are equalities.

## 4. A uniform estimate for Dicke states

Kwan [1] gives a more precise fixed-filling asymptotic expansion. To use (16) for sector sets that change with $N$, we need an estimate uniform over all $n$. The following proof supplies that estimate through one explicit multinomial type.

### 4.1. The sixteen-column count

Apply (12) to $D_n^N$. At each site, choose $a\in\{0,1\}$ and a four-bit string $y$ of even parity. This gives a column

$$
(y_1,y_2,y_3,y_4,y_1\oplus a,y_2\oplus a,y_3\oplus a,y_4\oplus a).
\tag{17}
$$

There are sixteen distinct columns: the zero column, the all-one column, and fourteen columns with four ones. Each of the eight coordinates is one in exactly seven of the fourteen middle columns. Let $C_N(n)$ count strings of $N$ such columns whose eight row sums are all $n$. Then

$$
W_N(D_n^N)=C_N(n)\binom Nn^{-4}.
\tag{18}
$$

This count is the one used in [1, Appendix B.1], which also identifies its earlier codeword-state antecedents. The following rounding construction concerns uniform control of this existing count.

### 4.2. Exponential tilt and an admissible rounded type

Fix $0<n<N$, set $f=n/N$, and use $\tau=\tau(f)$ from (5). Write $G=1+14\tau+\tau^2$. Assign probabilities

$$
q_0=G^{-1},\qquad q_8=\tau^2/G,\qquad q_m=\tau/G
\tag{19}
$$

to the zero column, all-one column, and each middle column. Denote this distribution by $Q_f$. Every coordinate has mean $q_8+7q_m=f$, and its entropy is $H(Q_f)=\mathcal H(f)$.

An admissible length-$N$ column string has probability $G^{-N}\tau^{2n}$ under $Q_f^{\otimes N}$, because its eight row sums total $8n$. Consequently,

$$
C_N(n)\le G^N\tau^{-2n}=2^{N\mathcal H(f)}.
\tag{20}
$$

For the lower bound, let $c=\lfloor Nq_m\rfloor$. Use $c$ copies of each middle column, together with

$$
a=N-n-7c\quad\hbox{zero columns},\qquad
b=n-7c\quad\hbox{all-one columns}.
\tag{21}
$$

These are nonnegative integers. Indeed, if $\delta=Nq_m-c\in[0,1)$, then
$a=Nq_0+7\delta$ and $b=Nq_8+7\delta$. Their total with the fourteen middle counts is $N$, and every row sum is exactly $b+7c=n$. Therefore

$$
C_N(n)\ge\frac{N!}{a!b!(c!)^{14}}.
\tag{22}
$$

Let $R$ be the empirical distribution in (21). Its total variation distance from $Q_f$ is $14\delta/N\le14/N$. For $N\ge28$, the classical entropy-continuity bound gives

$$
H(R)\ge H(Q_f)-h_2(14/N)-(14/N)\log_2 15.
\tag{23}
$$

One proof of the bound couples the two distributions with mismatch probability $\varepsilon$. Condition on the mismatch indicator: its entropy is at most $h_2(\varepsilon)$, and after a mismatch there are at most fifteen alternatives to the other value. This gives $|H(R)-H(Q_f)|\le h_2(\varepsilon)+\varepsilon\log_2 15$. The right side is increasing for $\varepsilon\le1/2$, giving (23).

For an alphabet of size $s$, the multinomial type bounds are

$$
(N+1)^{-s}2^{NH(R)}
\le\binom{N}{NR_1,\ldots,NR_s}\le2^{NH(R)}.
\tag{24}
$$

For clarity, the lower bound follows by sampling from the empirical distribution $R$. Its own integer type is a mode: if another count vector has an excess at coordinate $j$ and a deficit at coordinate $i$, moving one count from $j$ to $i$ weakly increases its probability, since $R_i/(k_i+1)\ge1/N$ and $k_j/R_j> N$. Repeating reaches the empirical type. There are at most $(N+1)^s$ types, so the modal type has probability at least $(N+1)^{-s}$. Dividing by its probability per string, $2^{-NH(R)}$, proves the lower bound. Zero coordinates can be omitted. The upper bound follows because a type's probability is at most one.

Applying (24) with $s=16$ to (22) proves

$$
N\mathcal H(f)-E_N\le\log_2C_N(n)\le N\mathcal H(f),
\tag{25}
$$

where $E_N$ is (9). Since $N h_2(14/N)=O(\log N)$, the error is logarithmic and independent of the filling. No local central limit theorem has been used.

### 4.3. Uniform Dicke entropy

For binary types there are exactly $N+1$ possible counts. Thus the same modal-type argument used in (24) gives the sharper binary bound

$$
Nh_2(f)-\ell_N\le\log_2\binom Nn\le Nh_2(f).
$$

Combining this with (18) and (25) proves the required estimate.

**Lemma 4 (uniform Dicke estimate).** For $N\ge28$ and every $0\le n\le N$,

$$
N\alpha(n/N)-4\ell_N
\le M_2(D_n^N)\le N\alpha(n/N)+E_N.
\tag{26}
$$

The endpoints are immediate: $D_0^N$ and $D_N^N$ are computational-basis stabilizer states. Equation (26) includes fillings tending to zero or one. It does not replace the sharper subleading expansion of [1]; it supplies the different uniformity needed here.

## 5. Proof and evaluation of the variational law

### 5.1. Proof of Theorem 1

The binomial type bounds imply, uniformly in $p\in(0,1)$,

$$
-ND(n/N\Vert p)-\ell_N\le\log_2b_n
\le-ND(n/N\Vert p).
\tag{27}
$$

Let $A=\min_{n\in\Omega}[\alpha(n/N)+4D(n/N\Vert p)]$ and $B=\min_{n\in\Omega}D(n/N\Vert p)$. By (26)--(27),

$$
NA-4\ell_N\le\min_n F_n\le NA+E_N+4\ell_N.
\tag{28}
$$

Retaining a minimizing term in $Z_\Omega$, and bounding all its terms by the largest, gives

$$
-NB-\ell_N\le\log_2Z_\Omega\le-NB+\log_2m.
\tag{29}
$$

Insert (28)--(29) in (16). Since $V=A-4B$, this is exactly (10). In particular, $m\le N+1$ gives the simpler bound

$$
NV-16\ell_N\le M_2(\Psi_{\Omega,p})
\le NV+E_N+8\ell_N.
\tag{30}
$$

The argument establishes uniformity before any thermodynamic limit is taken. This order is essential when an allowed sector approaches an endpoint or has an exponentially small binomial weight.

### 5.2. The two continuous minimizers

Define the least coherent-branch density

$$
a(p)=-\log_2\left[(1-p)^4+14p^2(1-p)^2+p^4\right]
=-\log_2[1-4p(1-p)+16p^2(1-p)^2].
\tag{31}
$$

The known Dicke density satisfies [1]

$$
\alpha(f)=\sup_{q\in(0,1)}[a(q)-4D(f\Vert q)].
\tag{32}
$$

This holds for $f\in[0,1]$. The supremum is attained in the interior when $0<f<1$; for $f=0,1$ it is approached at the corresponding latitude endpoint.

For fixed $p$, put $t=(p/(1-p))^2$ and

$$
g(p)=\frac{7t+t^2}{1+14t+t^2}.
\tag{33}
$$

We shall use

$$
\min_{f\in[0,1]}[\alpha(f)+4D(f\Vert p)]=a(p),
\qquad
\min_{f\in[0,1]}D(f\Vert p)=0.
\tag{34}
$$

The first lower bound follows by choosing $q=p$ in (32). Equality follows by setting $f=g(p)$: then $\tau(f)=t$, and direct substitution in (6)--(7) gives $a(p)$. The second equality holds at $f=p$.

The minimizers differ except at special latitudes. The norm is controlled by $p$, while the fourth moment is controlled by $g(p)$. This is the precise distinction behind the projection-resolution effects.

### 5.3. At most two adjacent candidates for each minimum

Both objective functions in (8) are strictly convex in $f\in(0,1)$. This is familiar for $D(f\Vert p)$. For the other, write

$$
J_p(f)=\alpha(f)+4D(f\Vert p)
=-\mathcal H(f)-4f\log_2p-4(1-f)\log_2(1-p).
$$

Differentiating the tilted entropy gives

$$
J_p'(f)=2\log_2\tau(f)-4\log_2\frac p{1-p}.
\tag{35}
$$

The map $\tau\mapsto(7\tau+\tau^2)/(1+14\tau+\tau^2)$ has derivative
$(7+2\tau+7\tau^2)/(1+14\tau+\tau^2)^2>0$. Thus $J_p'$ is strictly increasing, and its unique zero is $g(p)$. The unique zero of the relative-entropy derivative is $p$.

On any ordered finite set, a function decreasing up to one point and increasing thereafter attains its minimum at one of the two set elements bracketing that point, or at the nearest available endpoint if no bracketing pair exists. Therefore the first minimum in (8) requires only the accessible neighbors of $g(p)$, and the second only the accessible neighbors of $p$.

For the arithmetic grid, let $r_0$ be the representative of the residue in $\{0,\ldots,K-1\}$. Its indices are $j=0,\ldots,\lfloor(N-r_0)/K\rfloor$. The candidates around a target $u$ have indices obtained by clipping the floor and ceiling of $(Nu-r_0)/K$ to this interval. Hence evaluating (8) needs at most four scalar objective evaluations. This is a statement about the number of candidates; it is not a claim of constant bit complexity for exact transcendental comparisons.

### 5.4. A relative-entropy form of the moment objective

Let $Q_f$ be the sixteen-column distribution (19), with $Q_0$ and $Q_1$ defined as point masses on the all-zero and all-one columns, respectively. Let $Q_{g(p)}$ have tilt $t=(p/(1-p))^2$. Direct calculation gives

$$
D(Q_f\Vert Q_{g(p)})
=-\mathcal H(f)+\log_2(1+14t+t^2)-2f\log_2t.
$$

Using (31), this becomes

$$
J_p(f)=a(p)+D(Q_f\Vert Q_{g(p)}).
\tag{36}
$$

Thus the first term in (8) is a closest-point problem in the tilted sixteen-column family. The norm term is a different closest-point problem in a Bernoulli family. Equation (36) also proves nonnegativity of the excess over the unconstrained moment minimum and identifies its equality case.

## 6. Resolution regimes

### 6.1. Sublinear moduli

**Corollary 5.** Fix $0<p<1$. For any admissible residue sequence and any integer sequence $K_N=o(N)$,

$$
\lim_{N\to\infty}\frac{M_2(\Psi_{\Omega_{N,K_N,r_N},p})}{N}=a(p).
\tag{37}
$$

**Proof.** For sufficiently large $N$, the arithmetic grid contains an element within $K_N/(2N)$ of $p$ and one within that distance of $g(p)$; both targets are in the interior of $[0,1]$. By continuity and (34), the two discrete minima converge to $0$ and $a(p)$. The uniform error in (11), divided by $N$, vanishes. $\square$

This includes fixed moduli and moduli growing faster than $\sqrt N$. A resolution sufficient to isolate the typical binomial sector in norm need not isolate the sector controlling the fourth moment.

### 6.2. Linear grids and actual accessible sets

Let $F_N=\{n/N:n\in\Omega_{N,K_N,r_N}\}\subset[0,1]$. Suppose these nonempty compact sets converge in Hausdorff distance to a nonempty compact set $F$. Since both objective functions in (8) are continuous on $[0,1]$ for fixed $p\in(0,1)$, uniform continuity gives convergence of their minima. Therefore

$$
\lim_{N\to\infty}\frac{M_2(\Psi)}N
=\min_{f\in F}[\alpha(f)+4D(f\Vert p)]
-4\min_{f\in F}D(f\Vert p).
\tag{38}
$$

When $K_N/N\to\kappa>0$, there are only finitely many accessible sectors, and (38) is a finite-grid resolution law. For a centered choice $n_N/N\to f_0$ with residue $n_N\pmod{K_N}$, the formal candidates are $f_0+j\kappa$ in $[0,1]$. Interior candidates are eventually unambiguous. A candidate exactly at an endpoint, however, may be absent at finite $N$ because of rounding. Equation (38) uses the limit of the actual sets, rather than silently including every formal endpoint.

If a sequence of accessible sets does not converge, (38) applies to its convergent subsequences. The entropy density is not asserted to have a limit for every oscillating modulus or residue sequence.

### 6.3. Exact-sector regime

If the accessible set contains only $n_N$, then $Z=b_{n_N}$ and the normalized state is $D_{n_N}^N$. Equation (8) reduces exactly to $\alpha(n_N/N)$; the two relative-entropy penalties cancel. This includes every nonempty residue class with $K>N$, as well as some smaller moduli near an edge of the interval. If $n_N/N\to f$, the density tends to $\alpha(f)$, including the endpoint value zero.

### 6.4. A sharp linear-resolution threshold at quarter filling

Fix $p=1/4$ and consider the centered limiting grid
$S_\kappa=\{p+j\kappa\in[0,1]:j\in\mathbb Z\}$ for $\kappa>0$. Since $p$ belongs to the grid, the norm penalty vanishes. Define its density by

$$
v(\kappa)=\min_{f\in S_\kappa}J_p(f),
\qquad J_p(f)=\alpha(f)+4D(f\Vert p).
$$

The unique continuous minimizer is $g(p)=4/13>p$. There is a unique positive number $\kappa_c$ satisfying

$$
J_{1/4}(1/4+\kappa_c)=J_{1/4}(1/4)=\alpha(1/4),
\qquad
\frac{3}{52}<\kappa_c<\frac34.
\tag{38a}
$$

For this number,

$$
v(\kappa)<\alpha(1/4)\quad(0<\kappa<\kappa_c),
\qquad
v(\kappa)=\alpha(1/4)\quad(\kappa\ge\kappa_c).
\tag{38b}
$$

**Proof.** The function $J_p$ strictly decreases up to $g(p)$ and strictly increases afterwards. Hence $J_p(p+\kappa)-J_p(p)$ is negative for $0<\kappa\le g(p)-p=3/52$, and is strictly increasing thereafter. At $p+\kappa=1$, its value is positive because $J_{1/4}(1)=8>\alpha(1/4)$. The latter inequality follows, for example, from $\alpha(1/4)\le1$, which is also immediate from (26) and $M_2\le N$. The intermediate-value theorem and strict increase give the unique root in (38a).

If $0<\kappa<\kappa_c$, the first point to the right, $p+\kappa$, is available and has objective strictly smaller than $J_p(p)$. If $\kappa\ge\kappa_c$, every available point to the left of $p$ has larger objective, while every available point to the right is at least $p+\kappa_c>g(p)$ and has objective at least $J_p(p)$. If there are no right-hand points, the same conclusion holds directly. At the threshold, the points $p$ and $p+\kappa_c$ tie. $\square$

The density below the threshold need not vary monotonically with resolution. Whenever $\kappa=(3/52)/j$ for a positive integer $j$, the grid contains $g(p)$ exactly and attains the unrestricted minimum $a(p)$. Thus the finite grid, rather than the distance from the central sector alone, determines the density.

For actual centered sequences with $N$ divisible by four, $r_N=N/4\pmod{K_N}$, and $K_N/N\to\kappa$, the same threshold conclusion holds. The points relevant to the strict comparison below the threshold lie in the interior, and the above-threshold argument rules out every other sector directly. Endpoint rounding therefore cannot change this particular threshold conclusion, even though it must be considered for the general formula (38).

A high-precision numerical evaluation gives $\kappa_c\approx0.1138283909273401$. This decimal is an illustration of the analytically defined unique root, not an interval-arithmetic certification of its displayed digits. The proof of the threshold does not use the numerical approximation.

## 7. Arbitrary phases and bounded-modulus offsets

The positivity assumption in Theorem 1 is substantive. We now treat phases without extending its stronger finite-size estimate beyond its proof.

### 7.1. Pauli coefficient norm and a linear filter

For an operator $F=\sum_{A\in\mathcal P_N}f_AA$, set $\|F\|_{\mathcal P,1}=\sum_A|f_A|$. Products of Pauli strings are phase multiples of Pauli strings, so this norm is submultiplicative.

If $\psi$ is normalized, $s=\|F\psi\|^2>0$, and $\eta=F\psi/\sqrt s$, then

$$
s^4W_N(\eta)\le\|F\|_{\mathcal P,1}^8 W_N(\psi).
\tag{39}
$$

To prove it, expand
$s\langle\eta|Q|\eta\rangle=\sum_{A,B}\overline f_Af_B\langle\psi|AQB|\psi\rangle$.
For fixed $A,B$, the map $Q\mapsto AQB$ permutes Pauli strings up to phases. Minkowski for the vector indexed by $Q$ therefore bounds its $\ell^4$ norm by $\|F\|_{\mathcal P,1}^2$ times the input norm. Taking fourth powers proves (39).

These filters are algebraic proof devices. Their use does not claim a free physical operation or an uncharged distillation protocol.

### 7.2. Number-sector filters

Consider a normalized state $\psi=\sum_{j=0}^{m-1}c_jD_{n_j}^N$ on the full nonempty modular progression $n_j=n_0+jK$, with arbitrary complex phases and $q_j=|c_j|^2>0$. Define $H_j=M_2(D_{n_j}^N)-4\log_2q_j$ and $H_* =\min_jH_j$. The weighted branch inequality gives $M_2(\psi)\ge H_*-8\log_2m$.

Let $\widehat N=\frac12\sum_{i=1}^N(I-Z_i)$ and

$$
F_j=\prod_{i\ne j}\frac{\widehat N-n_iI}{n_j-n_i}.
\tag{40}
$$

On the occupied sector span, $F_j\psi=c_jD_{n_j}^N$, so $s=q_j$ in (39). Moreover,
$\|\widehat N-n_iI\|_{\mathcal P,1}=|N/2-n_i|+N/2\le N$. Writing $d=m-1$, submultiplicativity gives

$$
\|F_j\|_{\mathcal P,1}\le\frac{(N/K)^d}{j!(d-j)!}
\le\left(\frac{2eN}{Kd}\right)^d
\quad(d\ge1).
\tag{41}
$$

The second step uses $a!\ge(a/e)^a$ and convexity of $a\log a$. Since $d\le N/K$, the logarithm of the last expression is at most $(N/K)\log_2(2e)$. Taking a minimizing sector in (39) proves

$$
H_*-8\log_2m\le M_2(\psi)
\le H_*+8(N/K)\log_2(2e).
\tag{42}
$$

For $m=1$, equality holds without any error. For binomial squared magnitudes $q_j=b_{n_j}/Z$, combine (42) with (26)--(29). This gives

$$
\frac{M_2(\psi)}N
=V_{N,\Omega,p}+O\left(\frac{\log(N+1)}N+\frac1K\right),
\tag{43}
$$

uniformly over the phases. Thus every sequence $K\to\infty$ obeys the same asymptotic finite-grid formula, even if the phases depend arbitrarily on the sector and on $N$.

### 7.3. Fixed moduli and azimuthal offsets

For a spin-coherent product with offset $\theta$, the Fourier projection is proportional to

$$
\frac1K\sum_{j=0}^{K-1}e^{-ir(\theta+2\pi j/K)}
\left(\sqrt{1-p}|0\rangle+e^{i(\theta+2\pi j/K)}\sqrt p|1\rangle\right)^{\otimes N}.
\tag{44}
$$

Its squared sector magnitudes remain $b_n/Z$, while its sector phases are $e^{i\theta(n-r)}$. Define $u=p(1-p)$ and

$$
h(p,\varphi)=1-4u+16u^2-4u^2\sin^2(2\varphi),
\qquad
a_K(p,\theta)=-\log_2\max_{0\le j<K}h(p,\theta+2\pi j/K).
\tag{45}
$$

This is the least magic among the actual single-qubit phase branches. Let $j_*$ attain that minimum. Use $K-1$ normalized one-qubit bras, one orthogonal to each branch other than $j_*$. Their tensor product annihilates all the unwanted branches exactly. The identity
$\prod_{j=1}^{K-1}(1-e^{2\pi ij/K})=K$ shows that the surviving unnormalized amplitude has modulus $u^{(K-1)/2}$. The norm square on the normalized input is therefore $s=u^{K-1}/Z$.

We need one estimate for discarding the measured qubits. If a normalized bra on $m$ qubits maps a normalized state $\psi$ to $\sqrt s\eta$ on $N-m$ qubits, then

$$
s^4 W_{N-m}(\eta)\le2^mW_N(\psi).
\tag{46}
$$

To verify this, write $v_A=\langle\chi|A|\chi\rangle$ and $r_{AB}=\langle\psi|A\otimes B|\psi\rangle$. Then $s r_B(\eta)=2^{-m}\sum_Av_A r_{AB}$. Hölder gives a factor $(\sum_A|v_A|^{4/3})^3$, which is at most $2^{4m}$ because there are $4^m$ coefficients and $\sum_Av_A^2=2^m$. Summing over $B$ with the two Pauli normalizations gives (46).

Let $m=K-1\le N$. Lemma 2 and the root filter give the exact sandwich

$$
Na_K(p,\theta)+4\log_2Z
\le M_2(\Psi)
\le(N-m)a_K(p,\theta)+m-4m\log_2u+4\log_2Z.
\tag{47}
$$

For fixed $p$ and $K=o(N)$, an accessible number lies within $K/2$ of $pN$ for all sufficiently large $N$. Equation (27) then gives $\log Z=o(N)$. Consequently,

$$
\frac{M_2(\Psi)}N-a_K(p,\theta)\longrightarrow0,
\tag{48}
$$

even for varying residues and offsets. In particular, for fixed $K$ and $\theta$, the density is exactly the phase-grid value $a_K(p,\theta)$.

For an explicit expression, put $s_K=K/\gcd(K,4)$ and
$\delta=\operatorname{dist}(2\theta,(\pi/s_K)\mathbb Z)$. The phase grid modulo the period of $\sin^2$ gives

$$
a_K(p,\theta)=-\log_2[1-4u+16u^2-4u^2\sin^2\delta].
\tag{49}
$$

Since $\delta\le2\pi/K$ and every pure one-qubit fourth moment is at least $2/3$, we have
$0\le a_K(p,\theta)-a(p)\le3\pi^2/(2K^2\ln2)$.
Thus diverging sublinear moduli have density $a(p)$ independently of offset; bounded moduli can retain a phase dependence.

### 7.4. A scope check and complete asymptotic classification

The offset restriction cannot be dropped from the strongest positive-amplitude theorem. For $K=1$, there is no projection. At $p=1/4$, the exact product-state moments are

$$
W_N(v_{1/4,0}^{\otimes N})=(13/16)^N,
\qquad
W_N(v_{1/4,\pi/4}^{\otimes N})=(43/64)^N.
\tag{50}
$$

For example, at $N=96$ their entropies are $96\log_2(16/13)$ and $96\log_2(64/43)$. The difference is extensive along the product-state sequence. The fixed-offset formula (48) captures it; a phase-independent bounded-modulus density formula would not.

There is also a direct finite counterexample to extending the positive-term lower bound in Lemma 3 to arbitrary phases. Take $N=96$, $p=1/2$, $K=1$, and $\theta=\pi/4$. The state is a product of $T$ states and has $W=(3/4)^{96}$. In the central Dicke sector $n=48$, the sixteen-column count contains the admissible type with six copies of each column. Hence its purported diagonal contribution is at least

$$
b_{48}^4W_{96}(D_{48}^{96})
=2^{-384}C_{96}(48)
\ge2^{-384}\frac{96!}{(6!)^{16}}
>\left(\frac34\right)^{96}.
\tag{50a}
$$

The strict inequality is the exact integer comparison $96!/(6!)^{16}>3^{96}2^{192}$, reproduced in the accompanying certificate. Thus even one retained diagonal contribution can exceed the complete moment when phases allow cancellation. This identifies the precise failed step, rather than merely displaying a difference between phase choices.

Together, (43) and (48) cover all asymptotic modulus regimes. Bounded moduli use the actual phase-grid minimum. Diverging moduli use the finite-sector variational law. If the modulus sequence oscillates, apply these statements on subsequences instead of presuming a single limiting density. A concise unified formulation, for fixed $p\in(0,1)$, is

$$
\frac{M_2(\Psi_{N,K_N,r_N,p,\theta_N})}{N}
-\left[V_{N,\Omega_{N,K_N,r_N},p}
+a_{K_N}(p,\theta_N)-a(p)\right]\longrightarrow0.
\tag{51}
$$

To prove (51), any putative subsequence with nonvanishing error has either a further subsequence with $K_N\to\infty$, where (43) and the $O(K_N^{-2})$ phase-grid bound apply, or one with bounded $K_N$, where (48) and the dense-grid limit $V\to a(p)$ apply. Both are contradictions. No limit of $K_N$ or $\theta_N$ is assumed. The stronger uniform logarithmic error belongs to the nonnegative case; (51) is not stated with that error for arbitrary phases.

## 8. States close to Dicke states with a different magic density

### 8.1. A quantitative trace-distance estimate

Assume $n=pN$ is an integer, take the centered residue $r=n\pmod K$, and use zero offset. Let $b(w)=\binom Nw p^w(1-p)^{N-w}$. For $1\le t\le N-n$,

$$
\frac{b(n+t)}{b(n)}
=\prod_{j=1}^{t}\frac{1-(j-1)/(N-n)}{1+j/n}
\le\exp[-t(t+1)/(2N)].
\tag{52}
$$

The numerator factors are at most one, while $\log(1+x)\ge x/(1+x)$ and $n+j\le N$ bound the denominator factors. The analogous left-tail product gives the same estimate for $b(n-t)/b(n)$.

Let $R$ be the total relative weight of retained sectors other than $n$, and put $v=K^2/(2N)$. Then

$$
R=\sum_{\substack{w\ne n\\w\equiv n\pmod K}}\frac{b(w)}{b(n)}
\le2\sum_{j\ge1}e^{-j^2v}
\le\frac{2e^{-v}}{1-e^{-3v}}.
\tag{53}
$$

The last step uses $j^2\ge1+3(j-1)$ for $j\ge1$. The squared overlap of the normalized projected state with $D_n^N$ is $1/(1+R)$. Therefore the half trace distance of their pure-state density matrices is

$$
T=\frac12\left\|\lvert\Psi\rangle\langle\Psi\rvert-
\lvert D_n^N\rangle\langle D_n^N\rvert\right\|_1
=\sqrt{\frac R{1+R}}.
\tag{54}
$$

It tends to zero whenever $K/\sqrt N\to\infty$.

### 8.2. The density separation

If also $K/N\to0$, Corollary 5 gives projected density $a(p)$, while Lemma 4 gives Dicke density $\alpha(p)$. These are generally different. From (32), the derivative with respect to $q$ at $q=p$ is $a'(p)$. Thus

$$
\alpha(p)>a(p)
\quad\text{if}\quad
p\notin\left\{\frac12,\frac{1-1/\sqrt2}{2},\frac{1+1/\sqrt2}{2}\right\}.
\tag{55}
$$

Indeed, away from those three stationary latitudes, moving a small distance from $q=p$ in the derivative's direction strictly improves the objective. The exceptional latitudes are obtained by differentiating (31).

A concrete sequence uses $p=1/4$, $N$ divisible by four, and $K=\lceil N^{2/3}\rceil$. Equation (53) gives

$$
T=O\!\left(e^{-N^{1/3}/4}\right),
\qquad
\lim\frac{M_2(\Psi)}N=\log_2\frac{16}{13}
<\alpha(1/4)=\lim\frac{M_2(D_{N/4}^N)}N.
\tag{56}
$$

For scale, the two densities are approximately $a(1/4)=0.2995602818589078$ and $\alpha(1/4)=0.3378005814790638$ bits per qubit, a difference of approximately $0.0382402996201559$. Strict separation does not depend on floating-point evaluation. Choosing $q=1/5$ in the established variational expression (32) gives the exact certificate

$$
\alpha(1/4)-a(1/4)
\ge a(1/5)-4D(1/4\Vert1/5)-a(1/4)
=\log_2\frac{1024}{999}>0.
\tag{56a}
$$

The separation does not contradict finite-dimensional continuity. The dimension grows with $N$, and the logarithm in $M_2$ probes an exponentially small fourth moment. General sensitivity of stabilizer entropies is already known [3]. The contribution in (56) is a quantified realization within a natural projection family, with an explicit modulus window and trace-distance bound.

### 8.3. Why the small sectors matter

At $p=1/4$, (33) gives $g(p)=4/13$, which differs from the norm center $p=1/4$. A dense retained grid has a sector near $4N/13$ even when its binomial norm weight is exponentially small. The fourth moment rewards that sector through its intrinsic Dicke entropy. Equation (36) makes the compensation exact at the exponential scale.

Consequently, discarding all numerically small number sectors before evaluating a logarithmic moment can change the leading entropy density. Equations (15), (26), and (30) give analytic controls that do not depend on retaining those sectors in floating-point arithmetic. Numerical checks in the accompanying code evaluate finite systems and test these identities; they are consistency checks for the proofs, not substitutes for the thermodynamic argument.

## 9. Conclusions and remaining scope

For real nonnegative spin-coherent amplitudes, finite-resolution number projection has the uniform variational law (10). The result applies to every nonempty sector set and yields a particularly simple description for modular projections. The two objective functions are strictly convex and have different minimizers, making both the mathematical mechanism and the required scalar computation explicit.

For arbitrary phase offsets, bounded moduli retain the phase-grid minimum, while diverging moduli obey the same finite-sector variational density as the nonnegative case. The proof keeps the finite-size error bounds distinct. The exact-sector and endpoint cases are included without appealing to an uncontrolled limiting grid.

The analysis concerns $M_2$, coherent projection of the specified product states, and exact arithmetic sector selection. It does not determine optimal state-preparation cost, operational distillation yield, higher Rényi orders, or sharp finite-size constants for all moduli. Those are separate problems. In particular, the analytic filters used to prove phase-insensitive asymptotics are not asserted to be free stabilizer operations.

The density of exact Dicke states, the Gowers-cube framework, and the general sensitivity of stabilizer entropy remain attributed to the cited works. The claim supported here is the projection-resolution theorem and its explicit consequences, subject to the literature coverage recorded with the accompanying research package.

## References

1. Y. H. Kwan, *Magic of Dicke states: density, cost and yield*, arXiv:2611.17623v1 (2026). [Primary manuscript](https://arxiv.org/html/2611.17623v1). The open resolution direction is stated in Section IV; the Dicke density, branch comparison, and column count are in Sections II and Appendices A--B.

2. S. Arunachalam and A. Dutt, *Polynomial-time tolerant testing stabilizer states*, arXiv:2408.06289v3 (2024). [Primary manuscript](https://arxiv.org/html/2408.06289v3). Section 3 develops the Gowers-norm representation used for the moment identity and triangle inequality.

3. T. Haug and L. Piroli, *Stabilizer entropies and nonstabilizerness monotones*, Quantum **7**, 1092 (2023). [DOI: 10.22331/q-2023-08-28-1092](https://doi.org/10.22331/q-2023-08-28-1092). [arXiv:2303.10152](https://arxiv.org/abs/2303.10152).

4. L. Leone, S. F. E. Oliviero, and A. Hamma, *Stabilizer Rényi entropy*, Physical Review Letters **128**, 050402 (2022). [DOI: 10.1103/PhysRevLett.128.050402](https://doi.org/10.1103/PhysRevLett.128.050402).

5. G. Passarelli, R. Fazio, and P. Lucignano, *Nonstabilizerness of permutationally invariant systems*, Physical Review A **110**, 022436 (2024). [arXiv:2402.08551v2](https://arxiv.org/html/2402.08551v2). [DOI: 10.1103/PhysRevA.110.022436](https://doi.org/10.1103/PhysRevA.110.022436).

6. L. Leone and L. Bittel, *Stabilizer entropies are monotones for magic-state resource theory*, Physical Review A **110**, L040403 (2024). [arXiv:2404.11652v3](https://arxiv.org/html/2404.11652v3). [DOI: 10.1103/PhysRevA.110.L040403](https://doi.org/10.1103/PhysRevA.110.L040403).

7. T. Hernández-Yanes et al., *Non-stabilizerness in quantum-enhanced metrological protocols*, Physical Review A **113**, 012416 (2026). [arXiv:2510.01380v2](https://arxiv.org/html/2510.01380v2). [DOI: 10.1103/tmf9-fyc2](https://doi.org/10.1103/tmf9-fyc2).
