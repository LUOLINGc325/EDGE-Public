---
title: "Sharp Spectral Dissipation and Unstable Thermodynamic Identification"
subtitle: "Cycle geometry, reversible samples, and exact finite embedding fibers"
date: "26 November 2026"
lang: en
geometry: margin=25mm
fontsize: 10pt
---

## Abstract

We establish a sharp nonlinear relation between entropy production, total exit rate, oscillation frequency, and the girth of a finite Markov network with uniform stationary distribution. The argument retains the current weights in a cycle decomposition and applies to every eigenmode, including nonnormal generators. A uniformly driven cycle attains the bound. For a reversible sampled transition matrix, the discrete frequencies of its matrix logarithms turn this inequality into a positive, observable dissipation gap. We then solve the entire reversible-observation fiber within the homogeneous two-layer abelian model: the symmetric rates are uniquely determined, and the remaining generators are a finite set of truncated integer resonances with specified parity. Finally, on a fixed ten-state Petersen network we construct an exact observation with a finite set of compatible positive entropy production rates, while every positive-radius observation neighborhood allows unbounded entropy. The topology, symmetric rates, stationary law, total rate, and a positive mixing bound remain fixed. Consequently every uniformly valid finite-sample entropy upper confidence limit is infinite with at least its nominal coverage probability at that exact observation. We compute the nonzero observation derivative and the exact Fisher information, derive the optimal fixed-risk sample complexity proportional to $e^{4E/s}$ for specified hypotheses, and obtain a sharp logarithmic divergence law for the robust upper entropy envelope at its critical observation radius. Along this explicit family, $H$ exact entropy values coexist with inverse Fisher information growing doubly exponentially in $H$, while a positive mixing bound persists. Classical spectral, cycle, matrix-logarithm, and statistical tools and the inherited four-topology classification are distinguished from these extensions.

## 1. Problem, principal conclusions, and prior work

An irreducible continuous-time Markov chain can be irreversible even when its transition matrix at one positive observation time is reversible. This complicates thermodynamic inference: a symmetric observed kernel does not by itself prove that the underlying entropy production vanishes. We ask which quantitative information survives, first for general uniformly stationary networks and then for a structured class where every exact compatible generator can be identified.

Our principal result is the bound (3.1). It holds for any connected finite support of girth $g$, with no normality or simple-spectrum assumption. Here $T=-\operatorname{tr}Q$ is the sum of all exit rates, $T/n$ is the stationary mean activity, and $\omega$ is the largest absolute imaginary part of a generator eigenvalue. The cycle constant $\kappa_g$ is explicit. Equality occurs on a uniformly driven $g$-cycle. In particular, without information about girth the optimal quadratic coefficient is $24/n$ in $\sigma T>24\omega^2/n$ for $\omega>0$; the strict inequality has that sharp infimum. The nonlinear bound is stronger and records the rate-feasibility boundary.

For a symmetric positive definite observation $P=e^{\Delta Q}$, every nonreversible embedding has an imaginary eigenvalue of magnitude at least $2\pi/\Delta$. Equations (4.1)--(4.2) therefore give a positive entropy gap using $-\log\det P$, $n$, and $\Delta$, with a stronger version when a girth constraint is genuinely imposed on the alternative embeddings. If the principal logarithm is not a Markov generator, every compatible finite-entropy generator lies above this positive gap. These conclusions do not require enumeration of all logarithms.

Sections 5--7 identify the exact finite fiber of every reversible observation arising from the homogeneous two-layer model of Appendix A. Sections 8--10 then show a sharp distinction between exact and statistical upper inference: a finite exact entropy set can coexist with an infinite upper envelope in every nonzero error ball and a corresponding obstruction to uniformly valid finite-sample upper confidence limits. The exact support and the symmetric part are known in that construction. Section 11 provides the exact local testing crossover, its entropy-dependent sample size, and the distinction between capped and uncapped composite alternatives. Section 12 determines the sharp upper-envelope divergence when observation error approaches the critical radius from below.

### 1.1 Technical comparison and attribution

Bauer, Seifert, and van der Meer [1] formulate generator-based thermodynamic inference from stroboscopic observations, give operational rate information and branch constraints, and discuss both extra topological information and the thermodynamic cost of embeddability as future directions. Our results address specific aspects of those directions; their paper does not state the four-graph classification as an explicit open conjecture.

Ohga, Ito, and Kolchinsky [2] prove cycle-affinity constraints on cross-correlation asymmetry and oscillation coherence. Kolchinsky, Ohga, and Ito [3] bound spectral changes and imaginary eigenvalues using entropy production and normalized edge traffic. Their Eq. (19), combined only with the inequality that maximum edge traffic is at most total traffic, gives $\sigma T\ge8\omega^2/n$ in the uniform case. Retaining current conservation in the spectral step yields the sharp coefficient $24/n$, the complete nonlinear refinement, and the girth dependence. This comparison is to that stated parameter reduction, not a claim that every bound in [3] is weaker for every generator.

The recent preprint by Kolchinsky, Ohga, and Ito [4] localizes eigenvalues using certifying-cycle affinities, winding, and maximum exit rate. Its Theorems 3--4 cover arbitrary stationary distributions and settle a cycle-localization problem. We do not claim a first cycle decomposition, a first topology-dependent spectral result, or the resolution of that problem. Our bound retains the magnitudes of the conserved currents and controls a total entropy rate at fixed total exit rate. A maximum cycle affinity is not bounded by those totals alone: a cycle with very small flow can have a very large affinity. Consequently a comparison based merely on the presence of cycles or on the common uniform-cycle equality example is insufficient to identify the two theorems.

Nishiyama and Hasegawa [5] derive entropy upper bounds when a maximum rate ratio is known. Divergence as a reverse rate vanishes is already explicit in their work. Our upper-inference result concerns a stricter conjunction: the same known finite topology and symmetric rates, a finite exact compatible entropy set, unbounded entropy in every observation error ball, and a uniform finite-sample consequence at the finite-entropy exact aliases. The boundary criterion in Section 8 states precisely why fixed positive edge traffic is needed.

Jia [6] proves the classical reversible-embedding uniqueness and principal-logarithm criterion used in Section 7. Multi-time generator uniqueness and multirate alias removal are established in [7,8]; no claim of novelty is made for them. The four-topology classification and the original Pell constructions in Appendix A are retained from the preceding manuscript [9]. Prior three-state entropy-fiber and observation-error results [10] are also acknowledged; we do not count the exact three-state entropy interval as a new contribution.

The nonlinear current--traffic aggregation used in Section 3 is already implicit in [13, Eq. (15)]; its short Jensen proof is retained for completeness. The novel optimization claim concerns its combination with the sharp girth-dependent circulation norm. Xu et al. [14] give a thermodynamic ellipse for the entire numerical range under arbitrary stationary laws. Gu [15] bounds dissipation through mode coherence and a mode-uniformity factor, while Jia [16] studies power-spectrum peak efficiency using relaxation and stationary probabilities. Their cycle and spectral methods are relevant prior work; the total-trace, girth, and maximum-frequency envelope is the specific comparison made here. We do not assert universal domination of these different bounds.

The confidence obstruction in Section 10 is explicitly attributed to the Gleser--Hwang mechanism [11,12]. Exponential statistical costs for information estimation also predate this work [17]. The quantitative result below concerns two specified sampled Markov hypotheses and a fixed finite-dimensional class, with a model-specific Fisher constant; it is not a new general principle of exponential sample complexity.

Xu and Meng [20] give a recent single-cycle frequency bound based on geometric mean directional rates and winding. Its kinetic information and single-cycle scope differ from the total-trace/girth entropy envelope used here. The detailed supplement cited in that main text was unavailable in the obtained source archive, so that comparison is limited to the read main text.

The source comparison is restricted to the versions and statements explicitly cited. It does not certify global priority. All theorems below are written mathematical claims; no proof-assistant verification or external peer-review certification is asserted.

## 2. Uniform stationarity and cycle geometry

Use a row generator $Q=(q_{ij})$ on $n \ge  3$ states. Its off-diagonal entries are
nonnegative and its row sums vanish. Assume the uniform distribution is
stationary, so its column sums also vanish. Every supported edge is
bidirectional: $q_{ij} > 0$ iff $q_{ji} > 0$. The support is connected. Missing edges
are omitted from sums. Write

\[
T=-\operatorname{tr}Q=\sum_{i< j}(q_{ij}+q_{ji}),\qquad
\sigma=\frac1n\sum_{i< j}(q_{ij}-q_{ji})\log\frac{q_{ij}}{q_{ji}},
\]

\[
s_{ij}=q_{ij}+q_{ji},\quad j_{ij}=q_{ij}-q_{ji},\quad
M=\sum_{i< j}|j_{ij}|,\quad
\omega=\max_{\lambda\in\operatorname{spec}Q}|\operatorname{Im}\lambda|.
\]

Here $T$ is the sum of all escape rates, not the stationary average activity.
The latter is $T/n$. Let $g$ be the undirected girth of the support. If the graph
is a tree, stationarity forces all $j_{ij}=0$, so $\sigma=\omega=0$; the nontrivial
statements concern finite $g \ge  3$.

For an integer $k \ge  3$ define

\[
\kappa_k=\frac{2}{k}\max_{0\le r< k}\left|\sin\frac{2\pi r}{k}\right|.
\]

In particular $\kappa_3=1/\sqrt{3}$, $\kappa_4=1/2$,
$\kappa_5=2 \sin(2\pi/5)/5$, and $\kappa_6=\sqrt{3}/6$.

### 2.1 Circulation and the cycle constant

### Lemma 2.1: monotonicity of the cycle constant

$\kappa_k$ is strictly decreasing for integers $k \ge  3$.

**Proof.** Direct evaluation proves the comparisons from 3 through 6. For
$k \ge  6$, the grid point nearest $\pi/2$ or $3\pi/2$ has distance at most $\pi/k$,
so

\[
\kappa_k\ge\frac{2\cos(\pi/k)}k.
\]

Using $\cos x \ge  1-x^2/2$ and $\pi^2 <  10$,

\[
\cos(\pi/k)>1-\frac5{k^2}\ge\frac{k}{k+1}\quad(k\ge6),
\]

because $k^2 \ge  5(k+1)$ for $k \ge  6$. Consequently
$\kappa_k > 2/(k+1) \ge  \kappa_{k+1}$. The comparisons 3--4 and 4--5 are immediate;
for 5--6 one may square the exact expressions. QED.

### Lemma 2.2: current decomposition and a sharp operator bound

For the real skew-symmetric matrix $J=(j_{ij})$,

\[
\|J\|_2\le\kappa_g M,\qquad
\omega\le\frac12\kappa_g M.
\tag{2.1}
\]

**Proof.** Uniform stationarity gives $\sum_j j_{ij}=0$. Orient each edge in the
direction of its positive current and assign the magnitude of the current as
its weight. This is a nonnegative circulation. A finite nonnegative
circulation is a finite positive sum of directed simple cycles: follow positive
edges until a vertex repeats, subtract the minimum edge weight on the resulting
cycle, and repeat. At least one positive edge disappears at each step.

There are no two-cycles in this oriented graph. Every directed cycle of length
$k$ has $k \ge  g$. If $J_C$ is its skew adjacency matrix with entries $+1$ along
the cycle and $-1$ in the reverse direction, then

\[
J=\sum_C a_C J_C,\quad a_C>0,\quad
M=\sum_C a_C|C|.
\]

No cancellation occurs in the last identity, because every component uses the
fixed orientation of the positive current. On a cycle of length $k$, Fourier
diagonalization gives eigenvalues $2i \sin(2\pi r/k)$, hence
$\Vert J_C\Vert _2 = k \kappa_k \le  k \kappa_g$. The operator triangle inequality proves
the first inequality in (2.1).

Write $Q=S+A$ with $S=(Q+Q^T)/2$ real symmetric and $A=J/2$ real
skew-symmetric. For any complex unit eigenvector $v$ of $Q$,
$\operatorname{Im}\lambda = \Im(v^* A v)$, so $|\operatorname{Im}\lambda| \le  \Vert A\Vert _2$. This proves the second
inequality. No normality, diagonalizability, or eigenvector condition number is
assumed. QED.

## 3. Sharp nonlinear entropy--activity--frequency frontier

### Theorem 3.1

Under the assumptions of Section 2, if $\omega>0$, then

\[
T>\frac{2\omega}{\kappa_g},\qquad
\boxed{\displaystyle
\sigma\ge\frac{4\omega}{n\kappa_g}
\operatorname{artanh}\!\left(\frac{2\omega}{\kappa_g T}\right)}.
\tag{3.1}
\]

In particular,

\[
\sigma T>\frac{8\omega^2}{n\kappa_g^2}.
\tag{3.2}
\]

With no information about girth other than $g \ge  3$, this gives

\[
\boxed{\displaystyle
\sigma\ge\frac{4\sqrt3\omega}{n}
\operatorname{artanh}\!\left(\frac{2\sqrt3\omega}{T}\right)},
\qquad
\sigma T>\frac{24\omega^2}{n}.
\tag{3.3}
\]

For $\omega=0$ the right side is defined by continuity as zero. This does not
assert that a real-spectrum generator is reversible.

**Proof.** On each edge set $z_{ij}=|j_{ij}|/s_{ij}$, so $0 \le  z_{ij} <  1$ and

\[
\sigma=\frac2n\sum_{i< j}s_{ij}z_{ij}\operatorname{artanh}z_{ij}.
\]

This current--traffic aggregation is an established entropy inequality; it also follows from [13, Eq. (15)] and Cauchy--Schwarz. We include its short derivation. The new step used with it is the sharp circulation operator bound (2.1).

The function $f(z)=z \operatorname{artanh} z$ has
$f''(z)=2/(1-z^2)^2>0$ on $[0,1)$. Jensen with weights $s_{ij}/T$ gives

\[
\sigma\ge\frac{2T}{n}\frac MT\operatorname{artanh}\frac MT
=\frac{2M}{n}\operatorname{artanh}\frac MT.
\tag{3.4}
\]

The function $u \to  u \operatorname{artanh}(u/T)$ is increasing on $[0,T)$. Strict
bidirectionality gives $M< T$; Lemma 2.2 gives $M \ge  2\omega/\kappa_g$. Substitution
proves (3.1) and the necessary strict domain condition. Finally
$\operatorname{artanh} x > x$ for $0< x< 1$ proves (3.2). QED.

### Exact equality and sharp constants

Take the uniform bidirectional cycle on $g$ states, with rate $a+b$ clockwise
and $a-b$ anticlockwise, where $a>b>0$. More generally view the cycle as a closed
component of an $n$-state generator with uniform invariant law when discussing
limits. Its nonzero currents are all $2b$, all edge traffics are $2a$, and

\[
T=2ga,\quad \omega=g\kappa_g b,\quad
\sigma=\frac{4gb}{n}\operatorname{artanh}\frac ba.
\tag{3.5}
\]

For $n=g$, this is an irreducible generator and equality holds exactly in
(3.1). For every $T>2\omega/\kappa_g$ choose
$a=T/(2g)$ and $b=\omega/(g \kappa_g)$ to attain the frontier. Thus the constant
$\kappa_g$ and the full nonlinear function cannot be improved over the class of
all connected uniform-stationary chains of girth $g$.

For a fixed larger $n$, a cycle with arbitrarily weak symmetric tree
attachments has the same girth and approaches equality; this last sentence
asserts a limiting sharpness statement with the invariants converging to their
prescribed cycle values. It does not claim an unproved exact optimizer on every
fixed graph.

Taking $b/a \to  0$ in (3.5) gives
$\sigma T / \omega^2 \to  8/(n \kappa_g^2)$, showing sharpness of the quadratic
constant. The strict inequality in (3.2) is compatible with sharpness as an
infimum.

### Important limits of this result

The uniform stationary assumption is substantive. The proof uses divergence
of unweighted currents $q_{ij}-q_{ji}$ and does not extend unchanged to general
stationary laws. The bound is a frequency constraint, not a lower bound on
entropy from the real part of the spectrum. Equality of the spectral frontier
on a cycle does not automatically prove equality of its *sampling* corollary:
all relevant imaginary frequencies would also need the required integer
commensurabilities.

## 4. Reversible observations give a quantized entropy gap

Let $\Delta>0$ and suppose $P=\exp(\Delta Q)$ is symmetric. Irreducibility of $Q$
implies $P$ is entrywise positive and has a unique stationary law, namely the
uniform law. Write

\[
L=-\log\det P=\Delta T>0.
\]

### Lemma 4.1: frequency obstruction

If $P$ is positive definite, then either $Q=(\log P)/\Delta$ is symmetric or
$\omega \ge  2\pi/\Delta$. If $P$ has a negative eigenvalue, then
$\omega \ge  \pi/\Delta$ and no reversible generator can produce $P$.

**Proof.** $Q$ commutes with its exponential and hence preserves each real
eigenspace $E_\rho$ of the symmetric matrix $P$. On this space
$\exp(\Delta Q_\rho)=\rho I$. In a complex Jordan normal form, exponentiation of a
nonzero nilpotent Jordan part cannot equal a scalar identity: in
$\exp(\Delta N)-I=N(\Delta I+\Delta^2 N/2!+...)$, the second factor is invertible.
Thus each block is diagonalizable. If $\rho>0$, its eigenvalues are
$\log(\rho)/\Delta + 2\pi i k/\Delta$ with integer $k$. If all $k=0$, the restriction
is exactly scalar $\log(\rho)/\Delta I$, yielding the principal logarithm on the
entire space. Otherwise the asserted frequency is present. For $\rho< 0$, an
eigenvalue has imaginary part $(2k+1)\pi/\Delta$. The exponential of a real
symmetric matrix is positive definite, proving the final assertion. QED.

### Corollary 4.2: positive definite case

Every finite-entropy nonreversible compatible generator with support girth at least $g$
satisfies

\[
L>\frac{4\pi}{\kappa_g},\qquad
\boxed{\displaystyle
\sigma\ge\frac{8\pi}{n\kappa_g\Delta}
\operatorname{artanh}\!\left(\frac{4\pi}{\kappa_g L}\right)}.
\tag{4.1}
\]

The alternative is $\sigma=0$ and the unique reversible matrix logarithm. In
particular, without topological information the positive branch starts at

\[
\sigma\ge\frac{8\sqrt3\pi}{n\Delta}
\operatorname{artanh}\!\left(\frac{4\sqrt3\pi}{L}\right)
>\frac{96\pi^2}{n\Delta L}.
\tag{4.2}
\]

An embedding with a one-way supported edge has $\sigma=+\infty$ by
convention. Such embeddings cannot lower an entropy infimum; the strict
feasibility conditions in (4.1)--(4.3) are asserted for finite-entropy embeddings.

If the principal logarithm has a negative off-diagonal entry, the zero branch
is impossible, so every finite-entropy Markov embedding is covered by (4.2), including
embeddings on supports different from the one originally used.

If one is only willing to assume a known support with girth $g$, use (4.1).
If the support is unknown, use $g=3$. Do not apply the original graph's girth to
an unrestricted alternative embedding.

### Corollary 4.3: negative sampled eigenvalues

For finite-entropy embeddings, if $P$ has a negative eigenvalue, replace $2\pi/\Delta$ by $\pi/\Delta$:

\[
L>\frac{2\pi}{\kappa_g},\qquad
\sigma\ge\frac{4\pi}{n\kappa_g\Delta}
\operatorname{artanh}\!\left(\frac{2\pi}{\kappa_g L}\right).
\tag{4.3}
\]

These conclusions have no simple-spectrum assumption and do not enumerate
matrix logarithms.

### Three-state sharpness, attributed as prior territory

On a three-state cycle, set $b=2\pi/(\sqrt{3} \Delta)$ and choose $a>b$. The symmetric
and skew parts commute and the skew exponential at $\Delta$ is the identity.
Thus $P$ is symmetric positive definite and equality holds in (4.2). For larger
$n$, add symmetric complete-graph rates $\epsilon$ and set
$a_\epsilon=(T-n(n-1)\epsilon)/6$ on the triangle. The extra symmetric Laplacian
commutes with the triangle current; for small $\epsilon>0$ the generator is
strictly positive, $T$ remains fixed, $\omega=2\pi/\Delta$, the sample stays
symmetric positive definite, and its entropy approaches (4.2).

This proves sharpness of the no-topology positive-branch bound over all
uniform-stationary chains. These sharpness samples do possess a reversible
embedding. Sharpness within the narrower class of samples having *no*
reversible embedding is not claimed.

## 5. What any homogeneous two-layer observation identifies exactly

Return to the finite abelian group model in Appendix A, with base group $A$ of order $N=|A|$, labelled steps
$a,b$, and symmetric spoke rate $c>0$. Let $\Delta>0$ be known. The assumptions
$\operatorname{ord}(a),\operatorname{ord}(b)\ge 5$ and $b \ne  \pm a$ are sufficient here; reversibility of $P$ is
not needed.

Let $P_\chi$ denote the $2\times2$ Fourier block of the observed matrix. For the
trivial character,

\[
P_1=\exp\left[\Delta c
\begin{pmatrix}-1&1\\1&-1\end{pmatrix}\right].
\]

Its nontrivial eigenvalue $\eta$ is in $(0,1)$, and

\[
c=-\frac{\log\eta}{2\Delta}.
\tag{5.1}
\]

Set $f_\chi=\log|\det P_\chi|$. The determinant identity gives, without any branch
choice,

\[
f_\chi=\Delta\{s_0[\Re\chi(a)-1]+s_1[\Re\chi(b)-1]-2c\}.
\]

Character orthogonality and $a \ne  \pm b$ give

\[
\boxed{\displaystyle
s_0=\frac{2}{N\Delta}\sum_\chi f_\chi\Re\chi(a),\qquad
s_1=\frac{2}{N\Delta}\sum_\chi f_\chi\Re\chi(b)}.
\tag{5.2}
\]

For clarity, $\sum \Re \chi(a)=0$,
$\sum (\Re \chi(a))^2=N/2$, and
$\sum \Re \chi(a) \Re \chi(b)=0$; these follow by expanding each real part into two
characters and checking the possible group sums $2a,2b,a+b,a-b$ are nonzero.
All directional totals and the spoke rate are therefore identifiable from one
observation even when the directional drifts are not.

This is an identity within the specified labelled homogeneous model; no claim
of arbitrary-topology rate reconstruction is made.

## 6. Entire reversible-observation fibers on the four classified supports

Use the four-topology classification and exact rate criteria in Appendix A, Sections A2--A5. For the Petersen graph choose the normalized
branch of the table below; the other branch is its explicitly stated layer and
orientation change. Put $\theta=2\pi/5$, $\varphi=(1+\sqrt{5})/2$.

| Graph | Required totals and drifts | $h$ | $D$ | Strict cutoff $\lvert h\rvert< B$ |
| --- | --- | --- | --- | --- |
| $G(5,2)$ | $s_1=\varphi^2 s_0$, $d_1=\varphi d_0$ | $\Delta d_0 \sin(\theta)/(2\pi)$ | 5 | $B=\Delta s_0 \sin(\theta)/(2\pi)$ |
| $G(8,3)$ | $s_1=s_0=s$, $d_1=d_0=d$ | $\Delta d/(\sqrt{2}\pi)$ | 2 | $B=\Delta s/(\sqrt{2}\pi)$ |
| $G(12,5)$ | $s_1=s_0=s$, $d_1=d_0=d$ | $\Delta d/(2\pi)$ | 3 | $B=\Delta s/(2\pi)$ |
| $\mathbb Z_6\times\mathbb Z_2$ | $s_1=s_0=s$, $d_1=d_0=d$ | $\sqrt{3}\Delta d/(2\pi)$ | 1 | $B=\sqrt{3}\Delta s/(2\pi)$ |

Define the already observed real number

\[
K=(\Delta c/\pi)^2.
\]

For any nonzero-drift reversible realization, $K$ is a positive integer and the
candidate fiber consists of

\[
h\in\mathbb Z\setminus\{0\},\quad |h|< B,\quad
\ell\in\mathbb Z_{>0},\qquad D h^2-\ell^2=K,
\tag{6.1}
\]

subject to the sign bits of the given Fourier blocks. For the Petersen graph
the single sign is $(-1)^{h+\ell}$ on the resonant blocks; the other nontrivial
blocks have positive phase. For the other three graphs the resonant blocks have sign $(-1)^\ell$.
The representative scalar-shift mode has sign $(-1)^h$: use mode $1$ on
$G(8,3)$ and $G(12,5)$, and a nonzero-sine mode in the nontrivial order-two
sector on the product graph. On $G(8,3)$ all odd modes have this sign. On
$G(12,5)$ modes $1,5,7,11$ have this sign while modes $3,9$ have phase $+1$.
On the product graph all nonzero-sine scalar modes have sign $(-1)^h$;
zero-sine modes are positive. These representative sign bits are
read from the observed real definite blocks, not chosen afresh for each
candidate.

Every pair satisfying these conditions yields the same observed matrix, and
every generator in this fixed labelled model yielding the observed reversible
matrix occurs in this set. To verify the first direction, use the explicit
Fourier block exponentials from Appendix A, Section A5: after the
totals, $c$, and sign bits are fixed, every block exponential is independent of
the magnitudes of the integer indices. For the converse use the reconstruction
identities, then the necessary classification and rate criteria of Appendix A.

The fiber is finite because the strict upper bound on $|h|$ is finite, and
$\ell=\sqrt{Dh^2-K}>0$ is uniquely determined by $|h|$. Both signs of $h$ occur;
they give transpose generators and the same entropy. For an SPD sample the
required signs are positive: $h+\ell$ even in the Petersen case, and both $h,\ell$
even in the remaining cases. In every SPD case $K$ is divisible by four.

### Zero drift is a separate, identifiable case

If both drifts vanish, the homogeneous generator is uniquely determined by
(5.1)--(5.2). It cannot share its reversible observation with an irreversible
generator in this model. Indeed, its character exponentials have a nonzero
off-diagonal in every block because $c>0$ and the block is real symmetric,
whereas every nonzero-drift reversible realization on the four graphs has
at least one resonant block whose sampled off-diagonal is zero.

Thus an observed reversible matrix arising from this model has either one
zero-drift realization or a finite nonzero-drift fiber, never both. It is not
claimed that every reversible stochastic matrix has a realization in this
model.

### Exact thermodynamic inference within the model

For each candidate $h$, reconstruct $d_0,d_1$ from the table. Its entropy is

\[
\sigma(h)=\frac12\sum_{i=0}^1d_i(h)
\log\frac{s_i+d_i(h)}{s_i-d_i(h)}.
\tag{6.2}
\]

This function is even and strictly increasing in $|h|$ on the positive-rate
domain, because $u \to  u \log[(s+u)/(s-u)]$ is even and has strictly positive
derivative for $0< u< s$. Therefore the set of attainable entropy values is
exactly the finite list indexed by allowed positive $|h|$; its minimum and
maximum occur at the smallest and largest allowed positive index. These are
sharp attained bounds, not bounds obtained by relaxing the fiber.

This finite-fiber result concerns the homogeneous model only. A degenerate
sample may admit continuous families of embeddings on other supports or with
inhomogeneous rates; the older three-state examples make this distinction
essential.

## 7. Absence of reversible embeddings on every support

The preceding classification [9] proves this obstruction for its four exhibited
families. The same calculation proves it for *every* reversible sample with
nonzero drift in the model.

If the sample is not positive definite, a reversible generator is already
impossible. Suppose it is SPD. On a scalar-shift nonresonant character, the
positive sign makes the principal logarithm equal to the real zero-drift block.
On a resonant character, the principal logarithm is its real scalar mean,
removing the off-diagonal $c$. Hence in the original, unscaled time units,

\[
\frac1\Delta\log P=Q_0-c\,\Pi_R\otimes X,
\tag{7.1}
\]

where $Q_0$ has the recovered totals and zero drifts, $X$ exchanges the layers,
and $\Pi_R$ is the character projector onto the same resonant modes as in Appendix A, Section A6.4. This identity depends only on the sign bits being positive,
not on the selected Pell indices.

The principal logarithm has a negative cross-layer entry away from the spoke:

* for the normalized Petersen branch, at displacement 2,
  $\Pi_R(2)=(2/5) \cos(8\pi/5)>0$;
* for $G(8,3)$ and $G(12,5)$, at displacement $N/2$, every resonant character
  has value 1, so $\Pi_R(N/2)=|R|/N>0$;
* for the product-group graph, at displacement $(0,1)$,
  $\Pi_R(0,1)=4/12>0$.

The other Petersen branch is obtained by the same relabelling as the rate
classification, so it has the same obstruction. The underlying $Q_0$ has zero
cross-layer rates at these displacements, making the corresponding entries of
(7.1) strictly negative.

Any generator with the positive matrix $P$ as its exponential shares the unique
stationary law of $P$. To see this without assuming irreducibility of that
generator in advance, let $\pi_Q$ be a stationary probability of it; then
$\pi_Q P=\pi_Q$, hence $\pi_Q$ is uniform. Also $\exp(\Delta Q)=P>0$ forces
irreducibility of $Q$. A reversible compatible generator is therefore
symmetric, whose exponential has the unique real symmetric logarithm
$(\log P)/\Delta$. Its negative entry contradicts the generator condition.

Consequently the topology-free bound (4.2) applies to every finite-entropy compatible
generator of such an SPD sample. The stronger $g=5$ or $g=6$ bound applies when
the original support (or that girth lower bound) is imposed on the candidate.


## 8. The exact observation radius for upper boundedness

Let $G=(V,E)$ be a fixed connected undirected graph on $n$ vertices. For each edge $e=\{i,j\}$, fix a strictly positive traffic $s_e$. Fix an orientation of $E$ and a linear subspace $V_0$ of divergence-free edge currents. Define

\[
K=\{j\in V_0:|j_e|\le s_e\text{ for all }e\},\qquad
K^\circ=\{j\in V_0:|j_e|< s_e\text{ for all }e\}.
\]

The superscript denotes strict rate feasibility. The zero current belongs to $K^\circ$. On an oriented edge put $q_{ij}=(s_e+j_e)/2$ and $q_{ji}=(s_e-j_e)/2$, and choose the diagonal to give zero row sums. Every generator has uniform stationary law, the same symmetric part, and total exit rate $T=\sum_e s_e$. Every strictly feasible generator is irreducible and bidirectional. For $j\in K^\circ$ its entropy production is

\[
\sigma(j)=\frac1n\sum_e j_e\log\frac{s_e+j_e}{s_e-j_e}.
\]

Fix a sampling time $t>0$, write $\Phi(j)=e^{tQ(j)}$, and fix any matrix norm. Let $B=K\setminus K^\circ$ be the rate boundary and define

\[
d(P)=\min_{j\in B}\|\Phi(j)-P\|,
\]

with value $+\infty$ if $B$ is empty.

### Theorem 8.1: the robust upper-boundedness radius

For every matrix $P$ and every radius $0\le\varepsilon< d(P)$, entropy production is bounded above on

\[
\{j\in K^\circ:\|\Phi(j)-P\|\le\varepsilon\}.
\]

For every $\varepsilon>d(P)$ its supremum on that set is infinite. In particular, this upper supremum is infinite in every positive-radius observation ball if and only if the closed exact fiber $\Phi^{-1}(P)$ intersects $B$. No assertion at $\varepsilon=d(P)>0$ is made.

**Proof.** Both $K$ and $B$ are compact. If $\varepsilon< d(P)$, the closed set

\[
K\cap\{j:\|\Phi(j)-P\|\le\varepsilon\}
\]

is compact and disjoint from $B$. If it is nonempty, every $s_e-|j_e|$ has a common positive lower bound there. The entropy function is continuous and bounded on this set. If the set is empty the assertion is vacuous.

For the converse take $j_*\in B$ attaining $d(P)$ and set $j_\eta=(1-\eta)j_*$ for $0< \eta< 1$. These currents belong to $K^\circ$ and $\Phi(j_\eta)\to\Phi(j_*)$. On any edge where $|j_{*,e}|=s_e$, the entropy contribution is

\[
\frac{s_e}{n}(1-\eta)\log\frac{2-\eta}{\eta}\longrightarrow+\infty.
\]

All other contributions are nonnegative. Thus, for $\varepsilon>d(P)$, this sequence eventually lies in the observation ball and has unbounded entropy. Finally $d(P)=0$ is equivalent to an exact boundary preimage by compactness. If $d(P)>0$, the first assertion gives a positive radius with a finite upper bound. QED.

Fixed positive edge traffic is essential to this criterion. In a general compact rate family, both opposite rates may vanish while their ratio diverges fast enough to make the entropy term diverge. A nonzero one-way limiting current need not exist in that broader setting.

## 9. A finite exact entropy set with infinite robust upper uncertainty

Use the Petersen graph on $\mathbb Z_5\times\{0,1\}$ with layer steps $1,2$. Put $\varphi=(1+\sqrt5)/2$, $\theta=2\pi/5$, and $c=2\pi$. Fix an integer $H\ge1$. Starting at $(\ell_1,k_1)=(1,1)$, generate $H+1$ pairs by

\[
(\ell,k)\longmapsto
\left(\frac{3\ell+5k}{2},\frac{\ell+3k}{2}\right).
\tag{9.1}
\]

These are increasing positive integer solutions of

\[
\ell_r^2-5k_r^2=-4,
\qquad 0< k_1< \cdots< k_{H+1}.
\]

Indeed the transformation preserves the displayed norm. The norm equation modulo four forces $\ell$ and $k$ to have the same parity, so each transformed pair is integral and again has that property. The first pairs are $(1,1),(4,2),(11,5),(29,13)$. This denser sequence is used for convenience; the odd subsequence of Appendix A6.1 would also suffice.

Set

\[
d_r=\frac{2\pi k_r}{\sin\theta},\qquad
s=d_{H+1},\qquad s_0=s,\quad s_1=\varphi^2s,
\]

and let $Q(d)$ have drifts $d_0=d$ and $d_1=\varphi d$. Its strict parameter interval is $|d|< s$; the second-layer condition $\varphi|d|< \varphi^2s$ then follows automatically. This fixes all symmetric rates before varying $d$.

### Theorem 9.1: finite exact identification and infinite robust upper uncertainty

For every $H\ge1$, the preceding known ten-state model has one symmetric positive definite, entrywise positive sample $P$ at time one with all the following properties:

1. Exactly $H$ distinct finite positive entropy production rates are exactly compatible with $P$, from $d=d_1,\ldots,d_H$. Their generators are pairwise noncommuting.
2. The entire exact generator fiber in the fixed-rate one-parameter class consists of exactly $2H$ generators, so its entropy set has a finite maximum. It contains no zero-entropy generator.
3. Every positive-radius neighborhood of $P$ contains samples from that strict class with entropy production as large as desired.
4. All strictly feasible generators used here have the same support, stationary law, total exit rate, and symmetric part. Their $L^2$ convergence rates have a common strictly positive lower bound.

**Proof.** Section 6 and Appendix A5 show that every $d=d_r$ produces the same positive definite sample: $5k_r^2-\ell_r^2=4=(c/\pi)^2$, and $k_r+\ell_r$ is even. The matrix exponential identity remains valid at $d=s=d_{H+1}$. At this boundary, only the reverse edges of layer zero disappear; the forward cycle and the spokes still make the chain irreducible. Thus $P=e^{Q(s)}$ is entrywise positive. For $r\le H$ all rates are strictly positive on the prescribed support. The commutator calculation of Appendix A6.4 and entropy monotonicity in Section 6 prove the first assertion.

Every nonzero $d$ that gives this reversible sample must satisfy

\[
h=\frac{d\sin\theta}{2\pi}\in\mathbb Z\setminus\{0\},
\qquad |h|< k_{H+1},\qquad 5h^2-\ell^2=4
\tag{9.2}
\]

for a positive integer $\ell$. Conversely every such integer pair gives $P$, since the equation forces $h+\ell$ even. The elementary descent in Section 11.9 proves that the positive solutions of (9.2) are exactly $k_1,\ldots,k_H$; their negative partners yield exactly $2H$ generators and $H$ entropy values. Zero drift cannot give $P$: at character indices $2,3$ its sample has a nonzero off-diagonal, whereas $P$ is scalar in those blocks. This proves the second assertion and positivity of every exact entropy value.

Set $d=s-\varepsilon$ and let $\varepsilon\downarrow0$. The generators are strictly feasible and converge to $Q(s)$, so their samples converge to $P$. Their entropy is

\[
\sigma(d)=\frac d2\log\frac{s+d}{s-d}
+\frac{\varphi d}{2}\log\frac{\varphi^2s+\varphi d}{\varphi^2s-\varphi d}.
\tag{9.3}
\]

The second term has a finite limit, hence

\[
\sigma(s-\varepsilon)=\frac{s}{2}\log\frac1\varepsilon+C_s+o(1),
\quad
C_s=\frac{s}{2}\log(2s)
+\frac{\varphi s}{2}\log\frac{\varphi+1}{\varphi-1}.
\tag{9.4}
\]

Time has been normalized to one; rates in (9.4) are in those units. The difference $Q(s-\varepsilon)-Q(s)$ is block diagonal and skew-symmetric, with spectral norm at most $\varphi\varepsilon$. All these generators have uniform stationary law, so their semigroups are $L^2$ contractions. Duhamel's identity gives

\[
\|e^{tQ(s-\varepsilon)}-e^{tQ(s)}\|_2
\le t\varphi\varepsilon.
\tag{9.5}
\]

Their common symmetric part $S=Q(0)$ is the generator of an irreducible symmetric chain. Let $\gamma>0$ be the least positive eigenvalue of $-S$ on the mean-zero space. For $f\perp\mathbf1$,

\[
\frac{d}{dt}\|e^{tQ(d)}f\|_2^2
=2\langle e^{tQ(d)}f,S e^{tQ(d)}f\rangle
\le-2\gamma\|e^{tQ(d)}f\|_2^2.
\]

Writing $\Pi=\mathbf1\mathbf1^{\mathsf T}/10$, integration proves
$\|e^{tQ(d)}-\Pi\|_2\le e^{-\gamma t}$ uniformly in $d$. QED.

The assertion is stronger than entropy divergence at a vanishing reverse rate, which is standard [5,13]. The finite exact fiber and all the fixed structural constraints are essential to the separation established here.

## 10. Uniform finite-sample upper confidence limits

Observe one stationary path $(X_0,\ldots,X_N)$ with transition matrix $e^{Q(d)}$ in the fixed model of Theorem 9.1. Here $N$ is any fixed finite number of sampled transitions. Additional parameter-independent randomization in a statistic is allowed.

### Corollary 10.1: a Gleser--Hwang obstruction at a finite exact fiber

Let $0< \alpha< 1$. If $U_N$ takes values in $\mathbb R\cup\{+\infty\}$ and satisfies

\[
\Pr_{Q(d)}\{U_N\ge\sigma(Q(d))\}\ge1-\alpha
\quad\text{for every } |d|< s,
\]

then, under the common sampled law $P$ of Theorem 9.1,

\[
\Pr_P\{U_N=+\infty\}\ge1-\alpha.
\tag{10.1}
\]

This conclusion holds under every strictly feasible finite-entropy alias giving $P$. It is an application of the classical Gleser--Hwang mechanism [11,12], not a new general statistical impossibility principle.

**Proof.** For two kernels with the same initial law, path total-variation distance is at most $N$ times the largest row total-variation distance. This follows by maximally coupling each transition until a first mismatch. By (9.5),

\[
\max_i\frac12\sum_j|(P_\varepsilon-P)_{ij}|
\le\frac{\sqrt{10}}{2}\|P_\varepsilon-P\|_2
\le\frac{\sqrt{10}\varphi}{2}\varepsilon.
\]

Thus the finite sampled path laws converge in total variation, including any independent randomization. For any fixed real $M$, eventually $\sigma(Q(s-\varepsilon))>M$. Uniform coverage and total-variation convergence imply $\Pr_P\{U_N>M\}\ge1-\alpha$. Let $M\to+\infty$ and use continuity from above. QED.

The quantifier is uniform coverage over a class with no known positive lower bound on reverse rates. The conclusion does not rule out inference with such a lower bound, a bounded rate ratio, a different sampling design, or a smaller model. A finite exact identified entropy maximum alone does not justify a finite uniformly valid statistical upper limit.

## 11. Sharp statistical resolution of a boundary alias

### 11.1. Fixed model, experiment, and the claim

All observations below are made at time intervals of one. All logarithms are
natural. Fix

\[
\varphi=\frac{1+\sqrt5}{2},\quad \theta=\frac{2\pi}{5},\quad
a=\sin\theta,\quad c=2\pi.
\]

Choose a positive integer solution
\[
\ell_*^2-5k_*^2=-4,\qquad k_*\ge2,
\]
and set \(s=2\pi k_*/a\). The Pell equation implies that \(\ell_*\) and
\(k_*\) have the same parity. On the Petersen graph with vertices
\((u,i)\in\mathbb Z_5\times\{0,1\}\), layer steps 1 and 2, and symmetric
spoke rate \(c\), fix
\[
s_0=s,\quad s_1=\varphi^2s,\quad d_0=d,\quad d_1=\varphi d.
\]
Thus the two directed rates in layer \(i\) are \((s_i\pm d_i)/2\).
The strict parameter interval is \(|d|< s\). Write \(Q(d)\) for its row
generator. Every \(Q(d)\) has the uniform stationary law \(\pi_i=1/10\).

The boundary generator \(Q_*=Q(s)\) is still irreducible: only the reverse
edges in layer zero have disappeared. Consequently
\[
P_*=e^{Q_*}
\]
is an entrywise positive stochastic matrix. The Fourier identities of Theorem 9.1
show that it is symmetric and positive definite. Fix any strictly feasible
alias \(d_{\mathrm a}\) with \(e^{Q(d_{\mathrm a})}=P_*\); the solution
\((\ell,k)=(1,1)\) supplies one whenever \(k_*\ge2\).

For \(\varepsilon\ge0\) define
\[
Q_\varepsilon=Q(s-\varepsilon),\qquad
P_\varepsilon=e^{Q_\varepsilon},\qquad P_0=P_*.
\]
Only small nonnegative \(\varepsilon\) will be used. The observed experiment
is one stationary sampled path \(X_0,\ldots,X_N\), containing \(N\)
transitions, with initial distribution \(\pi\). Denote its law by
\(\mathbb P_{\varepsilon,N}\). Under the null, the actual continuous-time
generator can be the strictly feasible \(Q(d_{\mathrm a})\); its sampled
law is exactly \(\mathbb P_{0,N}\). No boundary generator needs to belong
to the statistical parameter space.

The principal conclusions are:

1. The observation derivative \(D=P_\varepsilon'|_{\varepsilon=0}\) is
   nonzero, and its Fisher information per transition is a strictly
   positive, explicitly computable number \(\mathcal I\).
2. For this fixed model, both directed path relative entropies are
   \(N\mathcal I\varepsilon^2/2+O(N\varepsilon^3)\).
3. Testing the specified null against the specified alternative has
   optimal sample size asymptotic to a known constant times
   \(\varepsilon^{-2}\). Expressed in the alternative's entropy
   production \(E\), the exact exponential scale is \(\exp(4E/s)\).
4. A truncated one-dimensional composite alternative has the same order
   of sample complexity. An alternative allowing arbitrarily large
   entropy has no uniformly successful test at any fixed finite sample
   size.

These statements concern a known one-dimensional rate family and this
specified observation design. They do not claim a general minimax
complexity over all generators, supports, or unknown symmetric rates.
Constants are model dependent and are not uniform in the number of
Pell aliases.

### 11.2. Exact derivative and computable Fisher information

The generator has the affine form
\[
Q_\varepsilon=Q_*-\varepsilon B,\qquad
B=\frac{\partial Q(d)}{\partial d}.
\]
The layer-zero block of \(B\) has the two directed entries \(1/2,-1/2\);
the layer-one block has \(\varphi/2,-\varphi/2\); its spoke and diagonal
entries vanish. In particular \(B\) is skew symmetric. Matrix
differentiation gives the completely general formula
\[
D=-\int_0^1 e^{(1-t)Q_*}B e^{tQ_*}\,dt.                 \tag{11.2.1}
\]
This is useful for direct computation, but Fourier blocks prove
nonvanishing without a numerical condition check.

Use the characters \(u\mapsto e^{2\pi iru/5}\), \(r=0,\ldots,4\). Put
\[
x=\cos\theta,\qquad y=\cos2\theta,\qquad
R_1=
\begin{pmatrix}
s(x-1)-c&c\\
c&\varphi^2s(y-1)-c
\end{pmatrix},\qquad U=e^{R_1}.
\]
Since \(\varphi\sin2\theta=\sin\theta=a\), the first character block is
\[
Q_1(d)=R_1+iadI.
\]
At the boundary \(as=2\pi k_*\), so
\[
(P_*)_1=U,\qquad D_1=-iaU\ne0,\qquad
D_4=\overline{D_1}.                                  \tag{11.2.2}
\]
This is a nonresonant block; no cancellation at the resonant blocks can
cancel it under the unitary Fourier transform.

For completeness all remaining blocks also have explicit formulas. Put
\[
\beta=\frac a2,\quad \gamma=\frac{\sqrt5\,a}{2},\quad
r=s(y-1)-c,\quad w_*=\pi\ell_*,
\]
\[
X=\begin{pmatrix}0&1\\1&0\end{pmatrix},\quad
Z=\begin{pmatrix}1&0\\0&-1\end{pmatrix},\quad
C(d)=cX+i\gamma d Z.
\]
Then \(Q_2(d)=rI-i\beta dI+C(d)\). Near \(d=s\),
\[
e^{Q_2(d)}
=e^r e^{-i\beta d}
\left\{\cos w(d)\,I+\frac{\sin w(d)}{w(d)}C(d)\right\},
\qquad
w(d)=\sqrt{\gamma^2d^2-c^2}.
\]
The Pell relation gives \(w(s)=w_*\), and the parity relation gives
\((-1)^{k_*+\ell_*}=1\). Differentiating with \(d=s-\varepsilon\) yields
\[
(P_*)_2=(P_*)_3=e^rI,\qquad
D_2=e^r\left\{i\beta I-\frac{\gamma^2s}{w_*^2}C(s)\right\},
\qquad D_3=\overline{D_2}.                            \tag{11.2.3}
\]
The trivial block is
\[
(P_*)_0=\frac12
\begin{pmatrix}
1+e^{-2c}&1-e^{-2c}\\1-e^{-2c}&1+e^{-2c}
\end{pmatrix},\qquad D_0=0.                          \tag{11.2.4}
\]
Also \((P_*)_4=(P_*)_1=U\).

The physical entries follow from the inverse Fourier transform:
\[
D_{(u,i),(v,j)}
=\frac15\sum_{r=0}^4(D_r)_{ij}e^{-2\pi ir(v-u)/5},   \tag{11.2.5}
\]
and the same formula holds for \(P_*\). All these entries are real.
Equations (11.2.2)--(11.2.5) are a finite exact prescription for every number
used below; no optimization over embeddings is required.

Define the row information and stationary information by
\[
J_i=\sum_j\frac{D_{ij}^2}{(P_*)_{ij}},\qquad
\mathcal I=\frac1{10}\sum_iJ_i.                      \tag{11.2.6}
\]
Here an index \(i\) in (11.2.6) denotes a physical state, not a layer.
Every \(J_i\) is strictly positive. Indeed, Parseval gives, for a physical
row in layer \(h\),
\[
\sum_{v,j}|D_{(u,h),(v,j)}|^2
=\frac15\sum_{r=0}^4\sum_j|(D_r)_{hj}|^2
\ge\frac{2a^2}{5}\sum_jU_{hj}^2>0.                  \tag{11.2.7}
\]
The final inequality follows from invertibility of \(U=e^{R_1}\).
Entrywise positivity of \(P_*\) now proves \(J_i>0\) and
\(\mathcal I>0\). Let \(J_{\min}=\min_iJ_i>0\).

The information in (11.2.6) is the information per transition in a stationary
path, without an additional autocorrelation correction. To see this,
write
\[
S(i,j)=\frac{D_{ij}}{(P_*)_{ij}}.
\]
Under the null,
\[
\mathbb E_0[S(X_m,X_{m+1})\mid X_0,\ldots,X_m]
=\sum_jD_{X_mj}=0.
\]
The transition scores are martingale differences, and their sum has
variance exactly \(N\mathcal I\). The common initial distribution
contributes no information.

### 11.3. Relative entropy, Hellinger affinity, and order of sample size

Analyticity of the matrix exponential gives, entrywise,
\[
P_\varepsilon=P_*+\varepsilon D+\frac{\varepsilon^2}{2}F
+O(\varepsilon^3),                                  \tag{11.3.1}
\]
where \(F=P_\varepsilon''|_0\). Every derivative has zero row sums.
Because the finite matrix \(P_*\) has strictly positive entries, the
logarithms and square roots appearing below have ordinary Taylor
expansions on a fixed neighborhood \(0\le\varepsilon\le\varepsilon_0\).
All remainder constants depend only on the fixed model.

#### Proposition 11.3.1: exact path factorization and quadratic information

For every integer \(N\ge1\),
\[
\begin{split}
D_{\rm KL}(\mathbb P_{0,N}\Vert\mathbb P_{\varepsilon,N})
&=N\frac1{10}\sum_{i,j}(P_*)_{ij}
 \log\frac{(P_*)_{ij}}{(P_\varepsilon)_{ij}}\\
&=\frac{N\mathcal I}{2}\varepsilon^2+O(N\varepsilon^3).
\end{split}                                        \tag{11.3.2}
\]
The reverse relative entropy has the same leading term. In particular,
for sufficiently small positive \(\varepsilon\), both are
\(\Theta(N\varepsilon^2)\), with constants independent of \(N\).

**Proof.** The path likelihood ratio is a product of the transition
likelihood ratios because the initial distribution is common. Under
either law each time marginal is uniform, yielding the first equality
and its reversed counterpart. Expansion (11.3.1), followed by the expansion
of \(\log(1+z)\), eliminates the linear terms and the terms involving
the row sums of \(F\). The remaining quadratic term is (11.2.6).
Finite dimensionality makes the Taylor remainder uniform across entries.
There is an exact factor \(N\), so no condition on \(N\varepsilon^3\)
is needed to assert the relative \(1+O(\varepsilon)\) expansion. QED.

The classical Markov-path affinity identity [18,19] gives the Hellinger affinity and its matrix representation as
\[
A_N(\varepsilon)
=\sum_{\text{paths}}\sqrt{\mathbb P_{0,N}\mathbb P_{\varepsilon,N}}
=\pi^\top M_\varepsilon^N\mathbf1,\qquad
(M_\varepsilon)_{ij}=\sqrt{(P_*)_{ij}(P_\varepsilon)_{ij}}. \tag{11.3.3}
\]
Thus our convention for squared Hellinger distance is \(2(1-A_N)\).
The row sums of \(M_\varepsilon\) are
\[
\sum_j(M_\varepsilon)_{ij}
=1-\frac{\varepsilon^2J_i}{8}+O(\varepsilon^3).
\]
Shrinking \(\varepsilon_0\) if necessary gives the useful finite bound
\[
A_N(\varepsilon)
\le(1-J_{\min}\varepsilon^2/16)^N
\le e^{-NJ_{\min}\varepsilon^2/16}.                 \tag{11.3.4}
\]

The minimum sum of type I and type II errors for a simple pair equals
\(1-\operatorname{TV}(\mathbb P_{0,N},\mathbb P_{\varepsilon,N})\).
It is at most the affinity, since \(\min(p,q)\le\sqrt{pq}\).
Conversely Pinsker's inequality and (11.3.2) give
\[
\operatorname{TV}(\mathbb P_{0,N},\mathbb P_{\varepsilon,N})
\le\sqrt{\tfrac12D_{\rm KL}(\mathbb P_{0,N}\Vert
                              \mathbb P_{\varepsilon,N})}.
                                                               \tag{11.3.5}
\]
For fixed target errors \(\alpha,\beta>0\) with \(\alpha+\beta< 1\),
(11.3.5) requires at least \(C_1\varepsilon^{-2}\) transitions, and
(11.3.4) supplies a test with at most \(C_2\varepsilon^{-2}\) transitions.
For example, choosing the likelihood-ratio threshold one and
\[
N\ge\frac{16}{J_{\min}\varepsilon^2}
       \log\frac1{\min(\alpha,\beta)}
                                                               \tag{11.3.6}
\]
ensures that each error is at most its target. These finite bounds
establish the claimed order without invoking a limit theorem.

### 11.4. Exact local likelihood limit and optimal asymptotic constant

The normal limit can also be proved by a finite-matrix calculation. Put
\[
L_N=\log\frac{d\mathbb P_{\varepsilon,N}}{d\mathbb P_{0,N}},
\qquad
K_\varepsilon(t)_{ij}
=(P_*)_{ij}^{\,1-t}(P_\varepsilon)_{ij}^{\,t}.
\]
For bounded complex \(t\), use the real logarithm of each positive entry
to define these powers. Then
\[
\mathbb E_0e^{tL_N}=\pi^\top K_\varepsilon(t)^N\mathbf1. \tag{11.4.1}
\]
Let \(V_{ij}=D_{ij}^2/(P_*)_{ij}\). Expansion (11.3.1) gives
\[
K_\varepsilon(t)
=P_*+t\varepsilon D
 +\frac{\varepsilon^2}{2}\{tF+t(t-1)V\}
 +O(\varepsilon^3).                                 \tag{11.4.2}
\]

The eigenvalue 1 of the strictly positive stochastic matrix \(P_*\)
is simple, and its other eigenvalues have modulus strictly below one.
The isolated eigenvalue and its eigenprojection continue analytically
for small \(\varepsilon\); this follows, for example, by solving the
eigenvector equation with normalization \(\pi^\top v=1\) by the
finite-dimensional implicit function theorem. The restriction of
\(I-P_*\) to \(\pi^\perp\) is invertible, which is precisely the needed
nondegeneracy.

Write this eigenvalue as \(\lambda_\varepsilon(t)\). Since
\(D\mathbf1=F\mathbf1=0\), its first derivative is zero and the first
derivative of its normalized right eigenvector is zero. Differentiating
the eigenvalue equation a second time therefore gives
\[
\lambda_\varepsilon(t)
=1+\frac{\mathcal I}{2}t(t-1)\varepsilon^2
 +O(\varepsilon^3).                                 \tag{11.4.3}
\]
The coefficient of its spectral projection in (11.4.1) tends to one.
The remaining spectral part is bounded by \(C\rho^N\) for some
\(\rho< 1\), uniformly for \(t\) in each fixed compact set and small
enough \(\varepsilon\). This follows by a spectral contour separated
from the other eigenvalues; no diagonalizability assumption is needed.

#### Theorem 11.4.1: local crossover

If \(\varepsilon\downarrow0\) and \(N\varepsilon^2\to r\in(0,\infty)\),
and \(v=r\mathcal I\), then
\[
L_N\ \Longrightarrow\
\begin{cases}
\mathcal N(-v/2,v),&\text{under }\mathbb P_{0,N},\\
\mathcal N(+v/2,v),&\text{under }\mathbb P_{\varepsilon,N}.
\end{cases}                                        \tag{11.4.4}
\]
Moreover,
\[
A_N(\varepsilon)\longrightarrow e^{-v/8},\qquad
\operatorname{TV}(\mathbb P_{0,N},\mathbb P_{\varepsilon,N})
\longrightarrow2\Phi(\sqrt v/2)-1.                 \tag{11.4.5}
\]
Here \(\Phi\) is the standard normal distribution function.

**Proof.** By (11.4.1)--(11.4.3),
\[
\mathbb E_0e^{tL_N}
\longrightarrow\exp\{\tfrac12v\,t(t-1)\}.
\]
Indeed \(N\varepsilon^3\to0\), and the other spectral contribution
vanishes. Taking \(t\) purely imaginary and using the characteristic
function continuity theorem proves the first normal limit. Under the
alternative, change of measure gives
\(\mathbb E_\varepsilon e^{tL_N}=\mathbb E_0e^{(t+1)L_N}\),
which proves the second. Taking \(t=1/2\) proves the affinity limit.
For the likelihood-ratio test with threshold one, each limiting error
is \(\Phi(-\sqrt v/2)\). This test minimizes their sum, proving the
total-variation limit. The limiting distributions have no atom at
the threshold, so tie conventions are immaterial. QED.

This is a one-sided local likelihood limit at the sampled law of an
interior alias. It does not require interpreting negative
\(\varepsilon\) as feasible continuous-time rates.

#### Corollary 11.4.2: minimal number of transitions

Fix \(0< \alpha,\beta< 1/2\). Allow randomized tests, and let
\(N_{\min}(\varepsilon;\alpha,\beta)\) be the smallest number of
transitions for which some test of this known simple pair has type I
error at most \(\alpha\) and type II error at most \(\beta\).
Write \(z_q=\Phi^{-1}(q)\). Then
\[
\boxed{\quad
\varepsilon^2N_{\min}(\varepsilon;\alpha,\beta)
\longrightarrow
\frac{(z_{1-\alpha}+z_{1-\beta})^2}{\mathcal I}.
\quad}                                             \tag{11.4.6}
\]

**Proof.** The most powerful level-\(\alpha\) test is the
Neyman--Pearson likelihood-ratio test. By (11.4.4), at
\(N\varepsilon^2\to r\), its limiting type II error is
\[
\Phi\{z_{1-\alpha}-\sqrt{r\mathcal I}\}.
\]
Continuity and strict monotonicity of the normal distribution yield
convergence of the required null quantile, including a randomized
finite-sample quantile if needed. The limiting error is below
\(\beta\) if
\(r>(z_{1-\alpha}+z_{1-\beta})^2/\mathcal I\), and above it if
the inequality is reversed. Apply these statements to
\(N=\lfloor r/\varepsilon^2\rfloor\) on each side of this constant.
The optimum cannot worsen when an additional observation is available,
because a test may discard it. These two comparisons establish the
limit. QED.

For comparison, if \(N\varepsilon^2\to0\), total variation tends to
zero by (11.3.2), and the hypotheses are asymptotically indistinguishable.
If \(N\varepsilon^2\to\infty\), (11.3.4) gives consistent tests. Thus the
quadratic scale separates the two regimes exactly.

### 11.5. Expressing resolution in entropy production

In the fixed Petersen family,
\[
\sigma_\varepsilon
=\frac{s-\varepsilon}{2}
  \log\frac{2s-\varepsilon}{\varepsilon}
+\frac{\varphi(s-\varepsilon)}2
 \log\frac{\varphi^2s+\varphi(s-\varepsilon)}
          {\varphi^2s-\varphi(s-\varepsilon)}.
                                                               \tag{11.5.1}
\]
The second summand tends to
\((3\varphi s/2)\log\varphi\), because
\((\varphi+1)/(\varphi-1)=\varphi^3\). Consequently, with the
dimensionless distance \(\eta=\varepsilon/s\),
\[
\frac{\sigma_\varepsilon}{s}
=\frac12\log\frac1\eta
 +\frac12\log2+\frac{3\varphi}{2}\log\varphi+o(1).
                                                               \tag{11.5.2}
\]
The entropy is strictly increasing as \(\varepsilon\) decreases near
zero, since each positive-current entropy summand is strictly
increasing in its drift. Thus for sufficiently large \(E\) there is a
unique \(\varepsilon(E)\) with \(\sigma_{\varepsilon(E)}=E\), and
\[
\varepsilon(E)
=2s\varphi^{3\varphi}e^{-2E/s}(1+o(1)).              \tag{11.5.3}
\]
Combining (11.4.6) and (11.5.3) gives the full fixed-model asymptotic
\[
\boxed{\quad
N_{\min}(E;\alpha,\beta)
\sim
\frac{(z_{1-\alpha}+z_{1-\beta})^2}
     {4s^2\varphi^{6\varphi}\mathcal I}
\,e^{4E/s}.
\quad}                                             \tag{11.5.4}
\]

The limit in (11.5.4) fixes the boundary index, all rates other than
\(\varepsilon\), the sampling interval, and the two target errors,
and then lets \(E\to\infty\). Changing the number of exact aliases
changes both \(s\) and \(\mathcal I\). In particular the prefactor can
be extremely large. The formula must not be presented as a uniform
guarantee across Pell families.

### 11.6. A stronger but restricted composite statement

Let
\[
M=\max_{i,j}|S(i,j)|< \infty,\qquad
S(i,j)=D_{ij}/(P_*)_{ij}.
\]
Taylor expansion and finite dimensionality allow a fixed
\(\varepsilon_0>0\) small enough that every physical row satisfies
\[
\mu_i(\varepsilon)
:=\sum_j(P_\varepsilon)_{ij}S(i,j)
=\varepsilon J_i+O(\varepsilon^2)
\ge\frac12J_{\min}\varepsilon
\quad(0< \varepsilon\le\varepsilon_0).               \tag{11.6.1}
\]
In particular, there is no further exact alias along this small
punctured boundary segment.

Consider the known-model composite test
\[
H_0:P=P_*,\qquad
H_1:P=P_\varepsilon,\quad
\varepsilon\in[\varepsilon_{\min},\varepsilon_0],
\qquad 0< \varepsilon_{\min}\le\varepsilon_0.
\]
Use the statistic \(T_N=\sum_{m=0}^{N-1}S(X_m,X_{m+1})\) and reject
when
\[
T_N\ge \frac14N J_{\min}\varepsilon_{\min}.          \tag{11.6.2}
\]
Under the null, \(T_N\) is a martingale with increments bounded by
\(M\). Under every alternative in the interval,
\[
T_N-\sum_{m=0}^{N-1}\mu_{X_m}(\varepsilon)
\]
is a martingale with increments bounded by \(2M\), while its
predictable drift is at least
\(NJ_{\min}\varepsilon_{\min}/2\). The two one-sided
Azuma--Hoeffding bounds therefore give, conservatively,
\[
\max\left\{\Pr_0(\text{reject}),
 \sup_{\varepsilon\in[\varepsilon_{\min},\varepsilon_0]}
 \Pr_\varepsilon(\text{accept})\right\}
\le
\exp\left\{-\frac{N J_{\min}^2\varepsilon_{\min}^2}{128M^2}\right\}.
                                                               \tag{11.6.3}
\]
The simple alternative \(\varepsilon=\varepsilon_{\min}\) supplies
the matching order lower bound from Section 11.3. Hence, for fixed
errors and the fixed model,
\[
N_{\min}^{\rm composite}(\varepsilon_{\min})
=\Theta(\varepsilon_{\min}^{-2}).                   \tag{11.6.4}
\]
Equivalently, if the composite interval is capped at entropy
\(E_{\max}=\sigma_{\varepsilon_{\min}}\), with its lower entropy
endpoint fixed by \(\varepsilon_0\), its sample complexity is
\(\Theta(e^{4E_{\max}/s})\). This is an order statement, not a claim
that the simple-pair constant (11.5.4) is the composite minimax constant.

The upper endpoint on entropy is essential. For the untruncated
alternative \(0< \varepsilon\le\varepsilon_0\), let a test have
type I error at most \(\alpha\). For every fixed \(N\),
\(\mathbb P_{\varepsilon,N}\to\mathbb P_{0,N}\) in total variation
as \(\varepsilon\downarrow0\). Therefore its rejection probability
along the alternative tends to a value at most \(\alpha\). Its
worst-case type II error is at least \(1-\alpha\). Thus no finite
sample size permits a uniformly nontrivial test against this entire
high-entropy family. Parameter-independent randomization does not
alter this conclusion.

### 11.7. Numerical scale and verification notes

Equations (11.2.2)--(11.2.6), evaluated at high precision, give:

| Boundary pair \((k_*,\ell_*)\) | \(s\) | \(\min_{ij}(P_*)_{ij}\) | \(\mathcal I\) |
| --- | ---: | ---: | ---: |
| \((2,4)\) | \(13.2130639967765\) | \(0.0999996357351120\) | \(3.18166993286713\,10^{-13}\) |
| \((5,11)\) | \(33.0326599919412\) | \(0.0999996512657597\) | \(1.70000099586939\,10^{-25}\) |
| \((13,29)\) | \(85.8849159790472\) | \(0.0999996512657644\) | \(2.24998232757132\,10^{-57}\) |

These are illustrative evaluations, not interval-certified inequalities;
the proofs use the exact formulas. The extremely small information in
these examples comes from suppressed nontrivial Fourier modes, despite
every sampled transition probability being close to \(1/10\). It does
not come from a small minimum sampled transition probability.

For the smallest displayed boundary model the two row-information
values, according to layer, are
\[
J_0=6.27888576503853\,10^{-13},\qquad
J_1=8.44541006957269\,10^{-15}.
\]
Their mean is the displayed \(\mathcal I\). The entropy-scale
prefactor without normal quantiles is
\[
\frac1{4s^2\varphi^{6\varphi}\mathcal I}
=4.21097998262042\,10^7
\quad\text{for }(k_*,\ell_*)=(2,4).
\]
Consequently even the asymptotic constant, before its exponential
dependence on entropy, is substantial.

The companion script verify_statistical_resolution.py constructs the
physical ten-state generator independently, checks its exponential
against the inverse-Fourier sample, and checks the derivative against
the upper-right block of
\[
\exp\begin{pmatrix}Q_*&-B\\0&Q_*\end{pmatrix}.
\]
At 120 decimal digits, the absolute sample and derivative residuals
were below \(10^{-100}\) for all three displayed boundary pairs.
It also evaluates the relative entropy directly at
\(\varepsilon=10^{-3},10^{-4}\) and records its ratio to
\(\mathcal I\varepsilon^2/2\). The output is saved in
statistical_resolution_verification.json. This checks algebraic
transcription and numerical scale; it does not replace the proofs.

### 11.8. Scope of the mathematical contribution

Quadratic Fisher information, likelihood-ratio testing, and local
normal experiments are standard statistical structures. Their use
here is not claimed as a new general statistical principle. The
specific new calculation is that the boundary Pell alias has a
nonvanishing derivative with a computable information constant, so
the qualitative robust-upper-inference obstruction in Corollary 10.1 has the
precise entropy-resolution scale (11.5.4). The full Fourier calculation,
the local testing crossover, and the distinction between capped and
uncapped composite entropy classes make that strengthening explicit
and checkable.

### 11.9. Information loss as the exact-alias count grows

There is also an explicit asymptotic for the information across the
Pell family. This concerns this particular construction, not a
universal relationship between the number of embeddings and statistical
information.

Write
\[
A_0=1-\cos\theta=\frac{5-\sqrt5}{4},\qquad
B_0=\varphi^2(1-\cos2\theta),\qquad
\Delta_0=B_0-A_0=\frac{5\varphi}{2}.
\]
The larger eigenvalue of \(R_1\) is
\[
\lambda_+(s)
=-c-\frac{A_0+B_0}{2}s
 +\sqrt{\frac{\Delta_0^2s^2}{4}+c^2}.                \tag{11.9.1}
\]
As \(s\to\infty\) along the admissible boundary Pell sequence,
\[
\boxed{\quad
\mathcal I(s)
=\frac{2a^2}{1+e^{-2c}}e^{2\lambda_+(s)}
 \{1+O(s^{-2})\}
\sim\frac{2a^2}{e^{2c}+1}
       e^{-(5-\sqrt5)s/2}.
\quad}                                             \tag{11.9.2}
\]

**Proof.** The limit of \(P_*(s)\) retains only its trivial Fourier
block. Its entries, for any positions in layers \(h,j\), are
\[
\bar p_{hj}=
\begin{cases}
(1+e^{-2c})/10,&h=j,\\
(1-e^{-2c})/10,&h\ne j.
\end{cases}                                        \tag{11.9.3}
\]
In particular this limiting matrix remains entrywise positive. It is
not exactly the uniform kernel, since the observation interval and
the spoke rate are fixed. Equations (11.2.2)--(11.2.4) give
\[
\max_{ij}|(P_*(s))_{ij}-\bar p_{\mathrm{layer}(i),
                                      \mathrm{layer}(j)}|
=O(e^{\lambda_+(s)}).
\]
Here the resonant block is smaller: its exponent is
\(r=-c-(1-\cos2\theta)s\), and
\(r-\lambda_+(s)\sim-(\sqrt5/2)s\).

The denominators in (11.2.6) may therefore be replaced by (11.9.3) with
relative error \(O(e^{\lambda_+(s)})\). Parseval applies separately
to each layer pair, since the replaced denominator does not depend
on the base-group displacement. The two nonresonant derivative blocks
give
\[
\frac{a^2}{5}\sum_{h,j=0}^1\frac{U_{hj}^2}{\bar p_{hj}},
                                                               \tag{11.9.4}
\]
and the two resonant blocks contribute \(O(e^{2r})\). The coefficient
matrix multiplying \(e^r\) in (11.2.3) is uniformly bounded as \(s\)
grows, because \(w_*^2=\gamma^2s^2-c^2\).

A unit eigenvector of \(R_1\) for \(\lambda_+(s)\) is
\((1+O(s^{-2}),O(s^{-1}))^\top\). The other eigenvalue is smaller
by \(\Delta_0s+O(s^{-1})\). Thus
\[
U_{00}=e^{\lambda_+}\{1+O(s^{-2})\},\quad
U_{01}=O(e^{\lambda_+}/s),\quad
U_{11}=O(e^{\lambda_+}/s^2)+O(e^{\lambda_-}).
\]
Substitution in (11.9.4) gives
\[
\frac{a^2}{5\bar p_{00}}e^{2\lambda_+}
\{1+O(s^{-2})\}.
\]
All discarded exponential errors are smaller than this polynomial
relative error. Since \(a^2/(5\bar p_{00})=2a^2/(1+e^{-2c})\),
this proves the first part of (11.9.2). Finally,
\[
\lambda_+(s)=-c-A_0s+\frac{c^2}{\Delta_0s}+O(s^{-3}),
\]
which proves the equivalent leading asymptotic. QED.

For the consecutive norm-minus-four solutions
\[
(\ell_1,k_1)=(1,1),\qquad
(\ell_{r+1},k_{r+1})
=\left(\frac{3\ell_r+5k_r}{2},
       \frac{\ell_r+3k_r}{2}\right),
\]
one has \(k_r=F_{2r-1}\), where \(F_m\) is the Fibonacci sequence.
This identity follows from \(k_1=1,k_2=2\) and
\(k_{r+2}=3k_{r+1}-k_r\). There are no omitted positive Pell
solutions: for any solution with \(k\ge2\), the inverse map
\[
(\ell,k)\longmapsto
\left(\frac{3\ell-5k}{2},\frac{3k-\ell}{2}\right)
\]
has positive integer entries, preserves the norm, and strictly
reduces \(k\). Positivity follows from
\(5k/3< \ell< 3k\) for \(k\ge2\); integrality follows from common
parity. Descent ends at \((1,1)\). Therefore choosing the boundary
at \(r=H+1\) leaves exactly \(H\) positive strict solutions, and
their negative partners; the sample parity condition is automatic.
The zero-current sample differs from \(P_*\). Thus this fixed-rate
family has exactly \(2H\) strict sampled generators and \(H\)
distinct entropy values.

For these boundary choices \(s_H=2\pi F_{2H+1}/a\), (11.9.2) gives
\[
\log\frac1{\mathcal I_H}
=\frac{\pi(5-\sqrt5)}{a}F_{2H+1}
 +\log\frac{e^{4\pi}+1}{2a^2}+o(1),                 \tag{11.9.5}
\]
and hence
\[
\lim_{H\to\infty}
\frac{\log(1/\mathcal I_H)}{\varphi^{\,2H+1}}
=\frac{\pi(5-\sqrt5)}{a\sqrt5}.                     \tag{11.9.6}
\]
The inverse information therefore grows doubly exponentially in
\(H\), in the explicit sense (11.9.6). For the relative boundary
distance \(\eta=\varepsilon/s_H\), the information is
\(s_H^2\mathcal I_H\); multiplying by this factor, polynomial in $s_H$, does
not change (11.9.6).

Equation (11.4.6), first at fixed \(H\) as \(\varepsilon\downarrow0\),
shows that the local optimal sample-size coefficient has exactly
this deterioration as \(H\) is subsequently increased. The
entropy-scale coefficient in (11.5.4) also has the same logarithmic
leading growth, because its additional factor is proportional to
\(s_H^{-2}\). No uniform two-parameter limit in \(H\) and
\(\varepsilon\), and no universal multiplicity lower bound outside
this explicit family, is asserted.

The mixing lower bound can also be chosen uniformly over this sequence of models. The symmetric part at $s_H$ equals that at $s_1$ plus $(s_H-s_1)$ times a symmetric generator supported on the two layers. Its negative is positive semidefinite. The variational characterization of the spectral gap therefore gives $\gamma_H\ge\gamma_1>0$. The total rate budget increases with $H$; it is fixed only within each individual model. This distinction prevents a claim of arbitrary alias multiplicity at a fixed total rate budget.

## 12. The sharp divergence rate from the robustly bounded side

Theorem 8.1 gives a general boundary-distance criterion. In the one-parameter Petersen class it also admits a sharp quantitative refinement. Use the Frobenius norm in this section. Both parameter endpoints have the same sample: $e^{Q(-s)}=e^{Q(s)^{\mathsf T}}=P_*$, since $P_*$ is symmetric. Thus the rate boundary has the single observation image $P_*$.

Fix a sufficiently small $\delta>0$, and let $P_\delta=e^{Q(s-\delta)}$ be a strictly feasible observation. Set

\[
r_\delta=\|P_\delta-P_*\|_F>0,
\qquad
M_\delta(\eta)=\sup\{\sigma(Q(d)): |d|< s,
\ \|e^{Q(d)}-P_\delta\|_F\le\eta\}.
\]

### Proposition 12.1: the logarithmic boundary law

For every sufficiently small fixed $\delta>0$, $M_\delta(\eta)$ is finite for $0\le\eta< r_\delta$, is infinite for $\eta\ge r_\delta$, and satisfies

\[
\boxed{\displaystyle
M_\delta(\eta)=\frac{s}{2}\log\frac1{r_\delta-\eta}+O(1)
\quad\text{as }\eta\uparrow r_\delta.}
\tag{12.1}
\]

The bounded remainder may depend on the fixed model and on $\delta$.

**Proof.** Section 11 proves that $D=\left.\partial_\varepsilon P_\varepsilon\right|_0$ is nonzero, and $P_\delta-P_*=\delta D+O(\delta^2)$. Hence $r_\delta>0$ for small $\delta$ and

\[
c_\delta=
\frac{\langle P_\delta-P_*,D\rangle_F}{r_\delta}
\longrightarrow\|D\|_F>0.
\]

For such a fixed $\delta$, differentiability of the norm away from zero gives

\[
\|P_\varepsilon-P_\delta\|_F
=r_\delta-c_\delta\varepsilon+O(\varepsilon^2).
\tag{12.2}
\]

Put $z=r_\delta-\eta>0$. For small $z$, the choice $\varepsilon=2z/c_\delta$ lies in the observation ball by (12.2). Equation (9.4) then gives

\[
M_\delta(\eta)\ge\frac{s}{2}\log\frac1z+O(1).
\]

For the reverse bound, analyticity on the compact parameter interval supplies a finite Lipschitz constant $L_0>0$. Comparing each parameter with its nearest endpoint yields

\[
\|e^{Q(d)}-P_*\|_F\le L_0(s-|d|).
\]

If $d$ is feasible for the observation ball, the triangle inequality implies

\[
z\le\|e^{Q(d)}-P_*\|_F\le L_0(s-|d|).
\]

The entropy is even in $d$, its second-layer term stays bounded on $[-s,s]$, and (9.3) implies, uniformly in the strict interval,

\[
\sigma(Q(d))\le\frac{s}{2}\log\frac1{s-|d|}+C_0
\]

for some finite $C_0$. Consequently $M_\delta(\eta)\le(s/2)\log(1/z)+O(1)$, proving (12.1). Finiteness below $r_\delta$ also follows directly from Theorem 8.1. At $\eta=r_\delta$, (12.2) puts every sufficiently small positive $\varepsilon$ inside the ball, while its entropy diverges. Larger balls contain this ball and also have infinite upper envelope. QED.

This resolves the critical radius for these particular observation centers; it does not add an endpoint assertion to the general Theorem 8.1. Together with Section 11, it gives a deterministic logarithmic divergence law and a matching statistical exponential resolution law in one explicitly identified model.


## 13. Scope and unresolved extensions

The general sharp frontier requires a uniform stationary law. A sharp analogue depending on an arbitrary specified stationary distribution is not established here. The girth-based spectral frontier is attained on cycles; this does not assert that all frequencies of a long cycle can simultaneously satisfy the resonances of a symmetric sample. Sharpness of the topology-free positive sampling gap and sharpness of the general spectral bound have therefore been stated separately.

The finite exact fiber is a theorem about the labelled homogeneous two-layer model. It does not turn the unrestricted logarithm fiber into a finite set. The statistical obstruction assumes uniform coverage over a strict-rate class with no known lower bound on reverse rates. It is not an impossibility statement for better-resolved observations, rate-ratio priors, or all possible observation schemes. The critical positive error radius itself is deliberately excluded from Theorem 8.1.

The unequal-spoke classification and stability of exact topology selection remain unresolved. We preserve the original symmetric-spoke problem rather than treating preliminary necessary conditions for a larger model as a completed classification.

## References

1. M. T. Bauer, U. Seifert, and J. van der Meer. *Stroboscopic measurements in Markov networks: exact generator reconstruction vs. thermodynamic inference*. Journal of Physics A: Mathematical and Theoretical **58**, 125001 (2025). DOI: [10.1088/1751-8121/adbc52](https://doi.org/10.1088/1751-8121/adbc52). Compared full preprint [arXiv:2412.15642v2](https://arxiv.org/html/2412.15642v2), especially Sections 3 and 5.
2. N. Ohga, S. Ito, and A. Kolchinsky. *Thermodynamic Bound on the Asymmetry of Cross-Correlations*. Physical Review Letters **131**, 077101 (2023). DOI: [10.1103/PhysRevLett.131.077101](https://doi.org/10.1103/PhysRevLett.131.077101). Compared full author-hosted published text, Eqs. (3), (8), and Application 1.
3. A. Kolchinsky, N. Ohga, and S. Ito. *Thermodynamic bound on spectral perturbations, with applications to oscillations and relaxation dynamics*. Physical Review Research **6**, 013082 (2024). DOI: [10.1103/PhysRevResearch.6.013082](https://doi.org/10.1103/PhysRevResearch.6.013082). Compared full author-hosted published text, especially Eqs. (5), (18), and (19).
4. A. Kolchinsky, N. Ohga, and S. Ito. *Cycle affinity and winding localize eigenvalues of Markov generators*. [arXiv:2605.15884v3](https://arxiv.org/html/2605.15884v3), 8 October 2026. Compared full HTML, especially Theorems 3--4 and the cycle-extraction proof. This reference is a preprint, not a claimed journal publication.
5. T. Nishiyama and Y. Hasegawa. *Upper bound for entropy production in Markov processes*. Physical Review E **108**, 044139 (2023). DOI: [10.1103/PhysRevE.108.044139](https://doi.org/10.1103/PhysRevE.108.044139). Compared full [arXiv:2306.15251v2](https://arxiv.org/html/2306.15251v2), especially Eqs. (8)--(9).
6. C. Jia. *A solution to the reversible embedding problem for finite Markov chains*. [arXiv:1605.03502v1](https://arxiv.org/abs/1605.03502), 2016. Compared Section 3 on reversible-logarithm uniqueness and the principal-logarithm condition.
7. D. Crommelin and E. Vanden-Eijnden. *Data-based inference of generators for Markov jump processes using convex optimization*. Multiscale Modeling & Simulation (2009). [Author-hosted text](https://ir.cwi.nl/pub/14723/14723B.pdf). The discussion of two incommensurate sampling intervals predates the present work.
8. F. Ding, L. Qiu, and T. Chen. *Reconstruction of continuous-time systems from their non-uniformly sampled discrete-time systems*. Automatica **45**, 324--332 (2009). DOI: [10.1016/j.automatica.2008.08.007](https://doi.org/10.1016/j.automatica.2008.08.007). Multirate logarithm alias removal is prior methodology, not an asserted contribution here.
9. *Which two-layer abelian networks have reversible sampled dynamics? A complete topology classification at girth at least five*. Preceding research manuscript, 25 November 2026. The complete classification proof and original constructions used here are reproduced in Appendix A. No new priority claim is attached to those retained results.
10. *Three-state entropy compatibility under finite-resolution stroboscopic observation*; and *Exact entropy-production fibers for nonuniform stationary three-state sampling*. Earlier research manuscripts, November 2026. Their exact-center entropy ranges are treated as prior results; none is needed as an unproved input to the present theorems.


11. L. J. Gleser and J. T. Hwang. *The nonexistence of 100(1-alpha)% confidence sets of finite expected diameter in errors-in-variables and related models*. Annals of Statistics **15**, 1351--1362 (1987). DOI: [10.1214/aos/1176350597](https://doi.org/10.1214/aos/1176350597). Historical attribution; the full proof checked for the present comparison is the generalization in [12].
12. J. Moss. *Infinite diameter confidence sets in Hedges' publication bias model*. Journal of the Korean Statistical Society **51**, 946--960 (2022). DOI: [10.1007/s42952-022-00169-1](https://doi.org/10.1007/s42952-022-00169-1). Compared Theorem 4 and its appendix proof, including Eqs. (4.1)--(4.2).
13. M. Baiesi, T. Nishiyama, and G. Falasco. *Effective estimation of entropy production with lacking data*. Communications Physics **7**, 264 (2024). DOI: [10.1038/s42005-024-01742-2](https://doi.org/10.1038/s42005-024-01742-2). Compared full [arXiv:2305.04657v3](https://arxiv.org/html/2305.04657v3), especially Eq. (15), the current--traffic aggregation, and missing reverse-jump data.
14. G.-H. Xu, A. Kolchinsky, J.-C. Delvenne, and S. Ito. *Thermodynamic Geometric Constraint on the Spectrum of Markov Rate Matrices*. Physical Review Letters **135**, 257102 (2025). DOI: [10.1103/z4t2-18cx](https://doi.org/10.1103/z4t2-18cx). Compared the full published text, ellipse theorem and Eqs. (4)--(5).
15. J. Gu. *Dissipation-coherence tradeoff for stochastic oscillations*. Physical Review E **113**, 064130 (2026). DOI: [10.1103/zxw1-zdb7](https://doi.org/10.1103/zxw1-zdb7). Compared the complete original [arXiv:2606.05498v1](https://arxiv.org/abs/2606.05498), especially Eqs. (10), (32), and Appendix A. The proof applies to an arbitrary nonreal eigenpair, not merely a slowest mode.
16. C. Jia. *Fundamental Bounds on the Oscillation Efficiency of Markov Networks*. [arXiv:2610.23310v1](https://arxiv.org/abs/2610.23310), 16 October 2026. Compared the eight-page main text, Eqs. (17), (27)--(29), and the cycle argument in the End Matter. No claim about an unread supplementary statement is made.
17. D. McAllester and K. Stratos. *Formal Limitations on the Measurement of Mutual Information*. Proceedings of AISTATS, PMLR **108**, 875--884 (2020). [Primary paper](https://proceedings.mlr.press/v108/mcallester20a.html). Compared Theorem 3.1; its distribution-free information-estimation setting differs from the fixed Markov hypotheses considered here.
18. D. Kazakos. *The Bhattacharyya distance and detection between Markov chains*. IEEE Transactions on Information Theory **24**, 747--754 (1978). DOI: [10.1109/TIT.1978.1055967](https://doi.org/10.1109/TIT.1978.1055967). Historical attribution of the path-affinity identity; its proof was checked in [19].
19. C. Daskalakis, N. Dikkala, and N. Gravin. *Testing Symmetric Markov Chains From a Single Trajectory*. Proceedings of COLT, PMLR **75**, 385--409 (2018). [Primary paper](https://proceedings.mlr.press/v75/daskalakis18a.html). Compared Lemma 5 and Appendix B: the affinity identity itself applies to arbitrary Markov kernels, although the paper's main testing algorithms focus on symmetric chains.
20. R. Xu and C. Meng. *Kinetic heterogeneity tightens thermodynamic bounds on spectra of Markov cycles*. [arXiv:2608.22934v2](https://arxiv.org/abs/2608.22934), 3 October 2026. Compared the six-page main text, Theorem 1, Eqs. (6), (8), and Corollary 2. The source archive obtained for this version did not include the separately cited detailed supplement; no verification of that absent supplement is claimed.

# Appendix A. Retained four-topology classification and constructions

This appendix retains the mathematical content of the preceding classification [9], including its assumptions and proof. Its role is to make the two-layer results in Sections 5--12 self-contained. The new work is identified in Section 1.

## A1. Model and results

Let $A$ be a finite abelian group written additively, generated by $a,b\in A$. The vertices are $(x,0),(x,1)$ for $x\in A$. An undirected layer edge joins $x$ to $x+a$ in layer zero and to $x+b$ in layer one. The spokes join $(x,0)$ to $(x,1)$. We require this support to be simple cubic of undirected girth at least five. In particular $a,b$ have order at least five, and $b\ne \pm a$. For sums $s_0,s_1>0$ and drifts $d_0,d_1$ with $|d_i|< s_i$, assign the rates $(s_i+d_i)/2$ and $(s_i-d_i)/2$ to the positive and negative step of layer $i$. Each spoke has rate $c>0$ in both directions. These assumptions yield an irreducible generator with uniform stationary law. It is irreversible exactly when at least one drift is nonzero. Since each column sum is zero, a reversible sampled transition is a symmetric matrix.

We classify the underlying graphs for which such a nonzero drift can produce a reversible $P=e^{\Delta Q}$ at some $\Delta>0$. Rescaling rates by $\Delta$ permits $\Delta=1$. An earlier fixed-topology construction underlying [9] treated $G(8,3)$; the complete four-topology classification retained here is the result of [9]. The present restriction to abelian two-layer graphs is fixed throughout. The fixed-topology construction is rederived in Section A6.2.

**Theorem.** Exactly the following four underlying graphs admit a reversible sample with at least one nonzero drift.

| Base group | Layer steps, up to choices of coordinates and orientations |
| --- | --- |
| $\mathbb Z_5$ | $1,2$ |
| $\mathbb Z_8$ | $1,3$ |
| $\mathbb Z_{12}$ | $1,5$ |
| $\mathbb Z_6\times\mathbb Z_2$ | $(1,0),(-1,1)$ |

All four graphs admit, for every integer $H\ge1$, one symmetric positive definite sample with at least $H$ strictly positive supported generators whose pairwise commutators are nonzero and whose stationary entropy production rates are distinct. The four exhibited families can also be chosen so that the samples admit no reversible generator on any support.

For cyclic group $\mathbb Z_N$ the graph with steps $1,k$ is the generalized Petersen graph $G(N,k)$. The two order-24 graphs in the table are distinct. Section A7 verifies girth and distinguishes them by the number of six-cycles.

## A2. Necessary character conditions

For a character $\chi$ of $A$, write $\chi(a)=e^{i\alpha}$ and $\chi(b)=e^{i\beta}$. The Fourier block of the generator is complex symmetric. Its diagonals are
$$s_0(\cos\alpha-1)-c+i d_0\sin\alpha,\qquad
s_1(\cos\beta-1)-c+i d_1\sin\beta,$$
and its off-diagonal entries are $c$. Write it as $mI+C$ with $C=cX+zZ$, where $X$ has ones off diagonal, $Z=\operatorname{diag}(1,-1)$, and $z$ is half the diagonal difference. Then $C^2=(c^2+z^2)I$. The exponential has the form $e^m(FI+HC)$, with $F=\cosh w$, $H=\sinh(w)/w$, $w^2=c^2+z^2$, and $H=1$ when $w=0$.

If the sampled matrix is symmetric, its unitary Fourier blocks are Hermitian. Each block exponential is also symmetric under transpose, so it is real. If its off-diagonal is nonzero, the ratio of its diagonal difference to twice its off-diagonal equals $z/c$ and is real. In that case $z$ is real. If the off-diagonal vanishes, $H=0$, so $w$ is a nonzero integer multiple of $i\pi$ and $z$ is purely imaginary. Thus for every character at least one of the following holds:
$$
\begin{aligned}
X(\chi)&:\quad s_0(1-\cos\alpha)=s_1(1-\cos\beta),\\
Y(\chi)&:\quad d_0\sin\alpha=d_1\sin\beta .
\end{aligned}
$$
When $Y(\chi)$ holds, the imaginary diagonal is scalar. The real symmetric part has positive definite exponential, so reversibility in that block additionally requires $d_0\sin\alpha\in\pi\mathbb Z$.

Both drifts must be nonzero. Suppose for example $d_0=0$ and $d_1\ne0$. Select a character with $\chi(b)=\zeta$ of primitive order $\operatorname{ord}(b)\ge5$. Such a character exists because the dual group separates points and the restricted image on a cyclic group has full order. For $\chi,\chi^2$, the sine of the second angle is nonzero, hence both must satisfy $X$. Dividing the two equations uses $(1-\cos2t)/(1-\cos t)=2(1+\cos t)$ and gives $\chi(a)\in\{\zeta,\zeta^{-1}\}$. Replacing $\chi$ with $\chi\psi$ for every character trivial on $b$ gives the same restriction. The possible values of $(\chi\psi)(a)$ form a coset of a finite subgroup of the circle. This coset cannot contain both listed values: a subgroup of order two would require $\zeta^2=-1$, which contradicts $\operatorname{ord}(\zeta)\ge5$. Hence every character trivial on $b$ is trivial on $a$. Characters of the quotient separate points, so $a\in\langle b\rangle$. As $a,b$ generate, $\chi(b)$ is primitive on $A$, and $\chi(a)=\zeta^{\pm1}$ implies $a=\pm b$. Such support has a four-cycle. The case $d_1=0$ exchanges the layers.

Now let $\chi(a)=1$. If $\chi(b)$ is neither $1$ nor $-1$, neither character condition holds, since $d_1\ne0$ and $s_1>0$. Thus $\chi(2b)=1$ for all $\chi$ trivial on $a$, implying $2b\in\langle a\rangle$. Likewise $2a\in\langle b\rangle$. Since $a,b$ generate, each cyclic subgroup has index at most two.

## A3. Necessity on cyclic groups

If $A$ is cyclic, one of $a,b$ generates it. Otherwise both generate the unique index-two subgroup and cannot generate $A$ jointly. Exchange the layers to use $a=1$ in $\mathbb Z_N$. Reorient the second step to take $b=k$, $1\le k\le N/2$. The case $k=1$ gives four-cycles, and $k=N/2$ gives order two, so it suffices to analyze $1< k< N/2$. Write $\theta=2\pi/N$, $x=\cos\theta>0$, $y=\cos(k\theta)< x$, and let $X_j,Y_j$ be the conditions of Section A2 for angles $j\theta,jk\theta$.

The pairs $X_1,X_2$ and $X_1,X_3$ are incompatible. For the first pair divide the ratios using $2(1+x)$. For the second use $(1-\cos3t)/(1-\cos t)=(1+2\cos t)^2$ and $|1+2y|< 1+2x$ for $-1< y< x$ and $x>0$. The pair $Y_1,Y_2$ is incompatible by the double-angle sine identity and the nonzero sine at $j=1$.

First suppose $x^2\ne y^2$. Additionally $X_2,X_4$, $Y_1,Y_3$ and $Y_2,Y_4$ are incompatible. The identities used respectively are
$$
\frac{1-\cos4t}{1-\cos2t}=4\cos^2t,\quad
\frac{\sin3t}{\sin t}=4\cos^2t-1,\quad
\frac{\sin4t}{\sin2t}=2\cos2t.
$$
For the last pair the denominators are nonzero whenever $Y_2$ holds, since $\sin(2\theta)\ne0$ and both drifts are nonzero.

If $X_1$ holds, $Y_2,Y_3$ must hold. Write $U=d_0\sin\theta$, $V=d_1\sin(k\theta)$. The two equations are $Ux=Vy$ and $U(4x^2-1)=V(4y^2-1)$. Eliminating $U,V$ gives $(x-y)(4xy+1)=0$, hence $xy=-1/4$. The incompatibility with $Y_4$ implies $X_4$. Dividing $X_4$ by $X_1$ yields $x^2(1+x)=y^2(1+y)$. Dividing the difference by $x-y$, and substituting $xy=-1/4$, gives $(x+y+1/2)^2=0$.

If $X_1$ fails, $Y_1$ holds, forcing $X_2,X_3$ and then $Y_4$. Dividing $X_3$ by $X_2$ gives equality of $(1+2x)^2/(1+x)$ and its value at $y$. The identity $(1+2x)^2/(1+x)=4x+1/(1+x)$ reduces this to $4(1+x)(1+y)=1$. The conditions $Y_1,Y_4$ give equality of $4x(2x^2-1)$ and its value at $y$, hence $2(x^2+xy+y^2)=1$. Together they again yield $x+y=-1/2$ and $xy=-1/4$. In both branches $x=(\sqrt5-1)/4=\cos(2\pi/5)$ and $y=-(\sqrt5+1)/4=\cos(4\pi/5)$, giving $N=5,k=2$.

It remains to consider $y=-x$, since $y=x$ is excluded. This entails $k=N/2-1$ and $N$ even. If $X_1$ holds, $Y_2,Y_3$ still give $xy=-1/4$, forcing $N=6,k=2$. That graph has triangles in its second layer. In the other case $Y_1$ gives $d_0=d_1\ne0$. The condition $Y_2$ fails, so $X_2$ gives $s_0=s_1$. For odd $j$ the two sine values agree, so reversibility requires $d_0\sin(j\theta)\in\pi\mathbb Z$. Taking $j=1,3$ shows that $\sin(3\theta)/\sin\theta=1+2\cos(2\theta)$ is rational. The number $2\cos(2\theta)$ is an algebraic integer, being a sum of roots of unity. A rational algebraic integer is an integer. For even $N\ge6$ this permits only $N=6,8,12$, because the angle $4\pi/N$ is between zero and $2\pi/3$. The girth constraint removes $N=6$. The cyclic argument up to removal of $G(6,2)$ uses only the character conditions, the rates and $1< k< N/2$. We use that algebraic statement in a quotient below.

## A4. Necessity on noncyclic groups

If $A$ is noncyclic, both $\langle a\rangle,\langle b\rangle$ have index two, with common order $N$. Since $b$ maps to a nontrivial element of order two modulo $\langle a\rangle$, $N$ is even. Also $2b=h a$ for some $h$, where $\gcd(h,N)=2$ because the order of $2b$ is $N/2$. Write $h=2k\bmod N$. The element $t=b-ka$ has order two and lies outside $\langle a\rangle$. Thus $A=\mathbb Z_N\times\mathbb Z_2$ and $a=(1,0),b=(k,1)$. Choosing the other solution of $2k=h$ and reorienting $b$ permits $0\le k\le N/4$, with $k=0$ excluded by the layer order. Also $N\ge6$ by the girth assumption.

Restrict to characters trivial on the $\mathbb Z_2$ factor. They see the cyclic steps $1,k$. If $k>1$, the algebraic cyclic analysis permits only $(N,k)=(5,2),(6,2),(8,3),(12,5)$. None has both even $N$ and $k\le N/4$. Therefore $k=1$.

In the other character sector, let $\theta=2\pi/N$. The character with index $j$ has angles $j\theta$ and $j\theta+\pi$. For $j=1$ and $j=1+N/2$ the two $X$ equations have swapped, unequal cosine values, so they cannot both hold. Both sine values are nonzero. At least one $Y$ equation therefore forces $d_0=-d_1$. The trivial sector at $j=1$ now has equal nonzero sines and opposite nonzero drifts, so it must satisfy $X$, giving $s_0=s_1$. In the other sector the imaginary shifts agree for all $j$. Reversibility at $j=1,2$ makes $2\cos\theta=\sin(2\theta)/\sin\theta$ rational. As above this value must be integral, and even $N\ge6$ must be $N=6$. Reorienting $b$ gives the last steps in the table.

## A5. Rate criteria on the four supports

Here we state the exact criterion for reversibility of the sample within the model, including the parameter restrictions suppressed in the graph-only statement. Use time one as above. With both drifts zero every sample is symmetric positive definite for all positive layer totals and spoke rate. The following criteria concern nonzero drift. Put $\varphi=(1+\sqrt5)/2$. For $G(5,2)$ a layer interchange and reorientation if needed gives $s_1=\varphi^2s_0$ and $d_1=\varphi d_0$. Indeed, the $Y_1$ branch in Section A3 yields the drift relation directly, and $X_2$ yields the ratio of the real totals. The $X_1$ branch yields the reciprocal total ratio and $d_1=-d_0/\varphi$ from $Y_2$. Exchanging the layers and taking the new second step in its opposite orientation converts those relations into the displayed ones. For the other three supports the preceding necessity proof gives equal sums and equal drifts in the table's orientations.

Let $d=d_0$ and define $h$ by the following table. The sample is reversible exactly when $h$ is a nonzero integer and there is a positive integer $\ell$ such that the indicated equation holds. The final column additionally characterizes positive definiteness.

| Graph | $h$ | Reversibility equation | Positive definite if and only if |
| --- | --- | --- | --- |
| $G(5,2)$ | $d\sin(2\pi/5)/(2\pi)$ | $(c/\pi)^2=5h^2-\ell^2$ | $h+\ell$ is even |
| $G(8,3)$ | $d/(\sqrt2\pi)$ | $(c/\pi)^2=2h^2-\ell^2$ | $h,\ell$ are even |
| $G(12,5)$ | $d/(2\pi)$ | $(c/\pi)^2=3h^2-\ell^2$ | $h,\ell$ are even |
| Product-group graph | $\sqrt3d/(2\pi)$ | $(c/\pi)^2=h^2-\ell^2$ | $h,\ell$ are even |

To verify the criteria, first take $G(5,2)$. At modes $1,4$ the imaginary term is scalar with magnitude $|d\sin(2\pi/5)|$. At modes $2,3$ the real diagonals coincide and the imaginary half-difference has magnitude $\sqrt5|d\sin(2\pi/5)|/2$, with scalar imaginary magnitude $|d\sin(2\pi/5)|/2$. The half-difference is nonzero. By the block calculation in Section A2, reversibility in these modes requires the off-diagonal exponential to vanish. This gives a resonant square root $i\ell\pi$ with $\ell\ge1$. The scalar phase at those modes is real exactly when the scalar imaginary magnitude is a multiple of $\pi$. This imposes the claimed integrality of $h$ and also makes the phase at modes $1,4$ equal to one. The two resonant signs multiply to $(-1)^{h+\ell}$.

For $G(8,3)$ and $G(12,5)$, the odd modes have scalar imaginary diagonals and require $h$ integral by mode $1$. In either graph, every other such phase is an integer multiple of $\pi h$. The even modes with nonzero sine have equal real diagonals and opposite imaginary diagonals. Their imaginary half-difference has magnitude $\sqrt2\pi|h|$ and $\sqrt3\pi|h|$, respectively. The same vanishing condition for the off-diagonal exponential gives the indicated equation. The signs in mode $1$ and the resonant modes are $(-1)^h$ and $(-1)^\ell$. For the product-group graph use the sector nontrivial on the order-two factor for the scalar condition and the trivial sector for the resonant condition. The scalar and half-difference magnitudes are both $\pi|h|$ whenever the sine is nonzero. Modes with zero sine are real symmetric and need no phase restriction. These verifications prove necessity, sufficiency, and the positive-definiteness column.

## A6. Realization and many noncommuting embeddings

All constructions below take time one. The rate totals are chosen large enough to meet the strict positivity inequalities for every chosen finite family. They are held fixed within that family.

### A6.1 Petersen graph

Set $\varphi=(1+\sqrt5)/2$, $\theta=2\pi/5$, $s_0=s$, $s_1=\varphi^2s$, $d_0=d$, $d_1=\varphi d$ and $c=2\pi$. Choose $d\sin\theta=2\pi k$ where $\ell,k$ are positive odd integers with $\ell^2-5k^2=-4$. The initial pair $(1,1)$ generates an infinite increasing sequence via multiplication of $\ell+k\sqrt5$ by $9+4\sqrt5$, which preserves the norm and oddness.

At indices $1,4$, the imaginary diagonal is scalar because $\sin(2\theta)=\sin\theta/\varphi$. Its exponential is one. At indices $2,3$, the real diagonals agree because $(1-\cos(2\theta))/(1-\cos\theta)=\varphi^2$. The mean imaginary term has magnitude $\pi k$ and half-difference magnitude $\pi\sqrt5 k$. Thus the traceless block has square $-\pi^2\ell^2 I$. Its exponential is $(-1)^\ell I$, and together with the mean phase the sign is $(-1)^{k+\ell}=1$. The zero mode is independent of $d$. The resulting positive definite sample is the same across all the chosen Pell indices.

### A6.2 Eight- and twelve-index cyclic graphs

For $G(8,3)$ take equal layer sums, equal drifts $d=\sqrt2(2\pi)k$ and $c=2\pi$. Use the positive solutions to $\ell^2-2k^2=-1$ from $(1,1)$ by multiplying $\ell+k\sqrt2$ by $3+2\sqrt2$. The odd blocks have equal imaginary diagonals with phases that are integer multiples of $2\pi$. At even indices with nonzero sine the real diagonals coincide and the imaginary diagonals are opposite. The traceless block squares to $-(2\pi\ell)^2I$, giving scalar exponential one. At zero-sine indices the blocks are independent of drift. These are the previous construction's samples.

For $G(12,5)$ take equal layer sums, equal drifts $d=4\pi k$ and $c=2\pi\sqrt2$. Use $\ell^2-3k^2=-2$, starting at $(1,1)$ and multiplying $\ell+k\sqrt3$ by $2+\sqrt3$. On odd indices the sines agree and are $\pm1/2$ or $\pm1$, so the scalar phases are integer multiples of $2\pi$. At even nonzero-sine indices the sines are opposite of magnitude $\sqrt3/2$, the cosines agree, and the square of the traceless block is $-(2\pi\ell)^2I$. Again the sample is independent of the chosen index.

### A6.3 Product-group graph

Take steps $(1,0),(-1,1)$, equal layer sums and equal drifts. For any $L\ge0$ put $D=3^{2L+1}$, and let $c=2\pi\sqrt D$. For each integer $0\le r\le L$, take $p=3^r$, $q=D/p$, $k=p+q$ and $\ell=q-p$. Both $k,\ell$ are positive even, $k^2-\ell^2=4D$, and all $k$ are distinct because $p+D/p$ decreases strictly while $p< \sqrt D$. Set $d=2\pi k/\sqrt3$.

In the sector trivial on the order-two factor, the cosines agree and the sines are opposite. At a nonzero-sine mode the imaginary half-difference has magnitude $\pi k$, so the square of the traceless block is $-\pi^2\ell^2 I$ and its exponential is $I$. In the sector nontrivial on the order-two factor the sines agree, with possible nonzero magnitude $\sqrt3/2$. The scalar imaginary phases are $\pm\pi k$ and exponentiate to one. Thus all $L+1$ choices give the same positive definite sample.

### A6.4 Entropy, commutation, and reversible embeddings

In each construction at a resonant nonzero-sine block a common real scalar is accompanied by $cX+i\eta Z$ and possibly a scalar imaginary term. Distinct positive drift parameters have distinct $\eta$. Their commutator there is $ic(\eta'-\eta)[X,Z]\ne0$. If the base group has order $N$, each of the two layers has $N$ undirected edges, and stationarity is uniform on $2N$ vertices. The entropy is
$$\sigma=\tfrac12 \sum_{i=0}^1 d_i\log\frac{s_i+d_i}{s_i-d_i}.$$
Each term is even and strictly increasing in the magnitude of its drift for fixed positive sum. In every construction both drift magnitudes increase with its positive parameter. This proves pairwise distinct stationary entropy production.

For each displayed family the real symmetric principal logarithm is the zero-drift generator minus $cX$ on the resonant modes where the traceless exponential was scalar. Write $\Pi$ for the Fourier projector onto those modes in the base group, so the correction is $-c\Pi\otimes X$. Positive definiteness and symmetry follow directly from the real symmetric exponentials describing all sampled blocks. Strict positivity of the sample follows from irreducibility and the exponential series after a diagonal shift.

A reversible generator with that sample would have the uniform stationary law and would be symmetric. For a symmetric generator the real exponential is injective on the eigenvalues, so it must be the principal logarithm. In each case this logarithm has a negative entry across the layers at a displacement different from the spoke displacement zero. For $G(5,2)$ take displacement $2$, where the projector on modes $2,3$ has value $(2/5)\cos(8\pi/5)>0$. For $G(8,3)$ and $G(12,5)$ take displacement $N/2$, for which the projector has value equal to the number of resonant modes divided by $N$, since all resonant indices are even. For the product-group graph take displacement $(0,1)$, where all four resonant characters are trivial on the order-two factor and the projector value is $4/12$. Subtracting this positive quantity times $c$ from an entry that was zero at zero drift proves the obstruction on every allowed support.

## A7. Graph checks and scope

Each listed graph is connected and cubic. In every case the two step sets $\{\pm a\},\{\pm b\}$ are disjoint. A cycle with two spokes and only two layer edges would require a step shared by the layers, so a mixed four-cycle is impossible. A simple cycle with four or more spokes has length at least eight, since between two consecutive spokes it must contain a layer edge. A mixed three-cycle is excluded by the same counting. The order-10 graph has a five-cycle within a layer. Each of the other graphs is bipartite, by the parity of the cyclic coordinate and the opposite choice in the other layer. The order-16 and order-24 cyclic examples have mixed six-cycles with two layer edges in each layer because $2b=-2a$. The product-group example has cycles of length six within each layer.

For the two graphs of order 24, a mixed six-cycle consists of two spokes and layer runs of lengths $r,s$ with $r+s=4$ and $r,s\ge1$. It requires $ra=\pm sb$. For the cyclic steps this holds only for $(r,s)=(2,2)$, as can be read modulo twelve. The product-group case requires even $s$ from the second coordinate, so again only $(2,2)$ works. Each gives one cycle for each of the twelve possible oriented positive starts of the first-layer length-two run. There are twelve mixed six-cycles in each graph. The cyclic graph has no six-cycle within its length-twelve layers. The product-group graph has two length-six cycles on each layer, giving sixteen six-cycles in total. This distinguishes the two graphs.

In every cubic graph of girth at least five, the radius-two ball of any vertex has ten distinct vertices. The three neighbors are distinct, and their other two neighbors each cannot coincide with vertices already counted without making a triangle or a quadrilateral. Therefore the Petersen construction achieves the minimum graph order in this cubic girth regime.

The classification covers the underlying graph in the connected finite-abelian two-layer translation model with homogeneous rates along each signed layer step and symmetric spokes. The table classifies every nonzero-drift homogeneous rate choice on the four displayed supports that gives reversible sampling. Previous work gave the exact supported embedding fiber of a specific $G(8,3)$ sample. Here the character necessity rules out every other graph in the stated model, and the four realizing families show that the obstruction is sharp. The expanded source comparison is in Section 1.1. This appendix provides a written proof and makes no formal-verification claim.


