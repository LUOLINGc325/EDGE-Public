# Sharp resource laws for ancilla-assisted detector calibration

Research manuscript.

## Abstract

How much can a retained quantum ancilla improve the calibration of a detector that returns only a classical outcome? We prove that an arbitrary fixed assisted experiment with an $m$-outcome detector admits a single recorded ordinary-probe ensemble whose entire Fisher information matrix dominates the assisted matrix up to the factor $m-1$. The ensemble is explicit and works simultaneously in all parameter directions. The coefficient is optimal for every integer $m$: a Clifford–simplex detector attains it at a regular point where every effect is proportional to the identity, and its ordinary and assisted optima are obtained throughout the full contrast interval. Together with the previously established readout-menu bound, a matching construction closes the joint worst-case frontier at $\min\{b,m-1\}$, where $b$ counts available conditional ancilla measurements. A finite-distance Pearson-divergence comparison has the same sharp outcome factor. To connect information to a decision task, we identify a class of noisy tight-projector detectors whose full adaptive quantum experiment is exactly equivalent to independent Bernoulli observations. For regular qubit polygons and $0 \lt h\le1/(8m^2)$, testing contrasts $1-h$ and $1-4h$ requires $\Theta(m/h)$ calls with adaptive ordinary probes and classical memory, but only $\Theta(1/h)$ with assistance, with explicit finite-sample constants. We also determine a sharp dimension-, rank-, and noise-dependent envelope over all finite tight-projector frames and construct finite approximations with a uniform error certificate. Finally, an erased-readout construction shows that arbitrarily small generalized incompatibility robustness can coexist with unbounded relative Fisher advantage. Known calibration architectures, the menu-only inequality, Haar techniques, qubit radial formulas, and environment-simulation methods are explicitly separated from the new operational conclusions.

## 1. Experiment, resource accounting, and contribution

Let $\{E_j(\boldsymbol\theta)\}_{j=1}^m$ be a differentiable positive-operator-valued measure on a finite-dimensional probe space $S$, defined on an open parameter domain. The detector returns only $j$; the interrogated system is discarded. Fix an interior nominal point $\boldsymbol\theta_0$. For an ordinary probe state $\rho$, write

```math
p_j(\rho)=\operatorname{tr}(\rho E_j),\qquad
\boldsymbol g_j(\rho)=\nabla_{\boldsymbol\theta}\operatorname{tr}(\rho E_j),\qquad
J(\rho)=\sum_{j:p_j>0}\frac{\boldsymbol g_j\boldsymbol g_j^{\mathsf T}}{p_j}.
```

All preparations, measurements, recorded randomization probabilities, and control rules are fixed when taking derivatives. A zero probability at an interior point has zero gradient; its summand is defined as zero. This is the classical Fisher matrix at that point, not an unstated limiting information convention. Full-rank effects will be assumed for the explicit witnesses and the finite-distance result, but are unnecessary for the universal local comparison.

An assisted experiment prepares a joint state $\omega_{SA}$, sends $S$ through the detector, and, after observing $j$, measures a trusted finite POVM $\{M_{j,r}\}_r$ on the retained ancilla $A$. The observed probabilities are

```math
q_{j,r}(\boldsymbol\theta)=\operatorname{tr}\bigl[\omega_{SA}(E_j(\boldsymbol\theta)\otimes M_{j,r})\bigr].
```

The model allows arbitrary finite ancilla dimension, mixed inputs, and recorded parameter-independent randomization. It does not grant access to an unobserved detector instrument or its discarded postmeasurement system. A recorded ordinary ensemble prepares $\rho_\ell$ with fixed probability $w_\ell$, keeps $\ell$, and observes the detector outcome. Its Fisher matrix is $J_{\rm mix}=\sum_\ell w_\ell J(\rho_\ell)$.

For a scalar parameter, let $F_{\rm u}$ be the supremum of ordinary Fisher information, $F_{\rm a}$ the supremum over assisted experiments, and $F_b$ the assisted supremum when the available readout menu contains at most $b$ distinct POVMs. Relabeling outcomes does not create a new menu item. A menu is fixed before the call, while the choice of its item may depend on $j$. Deterministic or randomized choices are allowed. Recorded ordinary randomization cannot increase the scalar optimum beyond $F_{\rm u}$. For several parameters we make no claim that a largest ordinary Fisher matrix exists.

### 1.1 Main resource statements

**Outcome replacement theorem.** For every fixed assisted experiment with $m\ge2$, one ordinary recorded ensemble satisfies

```math
J_{\rm assisted}\preceq(m-1)J_{\rm mix},\qquad
F_{\rm a}\le(m-1)F_{\rm u}. \tag{O1}
```

The ensemble is explicitly constructed at the nominal point and then frozen. In particular, every binary detector has no scalar single-call ancilla advantage, and three outcomes suffice for strict advantage. Across finite-dimensional full-rank detector models with $F_{\rm u}>0$,

```math
\sup_{\#E\le m}\frac{F_{\rm a}}{F_{\rm u}}=m-1,\qquad
\sup_{\#E\le m}\frac{F_b}{F_{\rm u}}=\min\{b,m-1\}. \tag{O2}
```

The same suprema hold with exactly $m$ nonzero outcomes. The first is attained for every $m$ at a full-rank interior point. The joint statement is a supremum; exact finite attainment is not asserted for every pair $(m,b)$.

The output-only bound improves the immediate menu estimate $F_{\rm a}\le mF_{\rm u}$ by one. That scalar improvement alone is not the claimed significance. The complete result supplies a common ensemble for the entire matrix, classifies the binary threshold, has sharp witnesses for every alphabet size, closes the two-budget frontier, and extends to finite-distance divergence. The finite-sample theorem below separately establishes a genuine testing consequence; it is not inferred by replacing sample complexity with inverse Fisher information.

### 1.2 Relation to the retained baseline

The predecessor manuscript already established $F_b\le bF_{\rm u}$, its menu-only sharpness, full-rank examples, and the exact regular-polygon formula. Those results are retained with their original provenance. We reproduce the menu proof in Section 4 and the polygon proof in Appendix A so this paper is mathematically self-contained. The earlier individual counterexamples and the diagnosis of a pure-state minimax interchange are preserved in the companion manuscripts; they are not counted again as new results here.

Ancilla calibration itself predates this work [D04, B12], as does an entanglement advantage in destructive measurement discrimination [D21]. Measurement outcome number has also been studied as a resource [ST20]. The question here is the sharp multiplicative information cost of replacing the ancilla in a specified detector experiment, with the detector alphabet and trusted readout menu counted separately. Section 9 compares the closest results and identifies known formulas and methods explicitly.

### 1.3 An elementary assisted upper bound

We will use the following standard logarithmic-derivative estimate, reproduced to fix its scope. For a scalar parameter, put $D_j=\partial_\theta E_j$. Suppose matrices $K_j$ satisfy

```math
K_j^\dagger E_j+E_jK_j=2D_j.
```

Then every assisted experiment satisfies

```math
F\le\operatorname{tr}\!\left[\rho_S\sum_jK_j^\dagger E_jK_j\right]
\le\lambda_{\max}\!\left(\sum_jK_j^\dagger E_jK_j\right). \tag{U1}
```

Indeed, for a joint outcome define
$U=(E_j^{1/2}\otimes M_{j,r}^{1/2})\omega^{1/2}$ and
$V=(E_j^{1/2}K_j\otimes M_{j,r}^{1/2})\omega^{1/2}$.
Its probability is $\|U\|_{\rm HS}^2$, and its derivative is
$\operatorname{Re}\operatorname{tr}(U^\dagger V)$. Hilbert–Schmidt Cauchy–Schwarz bounds the squared derivative by the probability times
$\operatorname{tr}[\omega(K_j^\dagger E_jK_j\otimes M_{j,r})]$.
Divide on positive probabilities and sum, using $\sum_rM_{j,r}=I$.
The zero-probability terms contribute zero under the convention above. This proves (U1). When $E_j>0$ and $[D_j,E_j]=0$, one may take $K_j=E_j^{-1}D_j$. We use the upper bound, not an unproved claim that it is always attained by an ordinary pure probe.

## 2. A common ordinary ensemble for the entire Fisher matrix

### 2.1 A classical complement identity

Let $p=(p_1,\ldots,p_m)$ be a differentiable probability vector at an interior point
of an open parameter domain in $\mathbb R^k$. Put $g_i = \nabla p_i$, so $\sum_i g_i=0$, and

```math
J(p)=\sum_{i:p_i>0}\frac{g_i g_i^{\mathsf T}}{p_i}.
```

For $0 < p_j < 1$, weighted Cauchy--Schwarz gives

```math
J(p)\succeq \frac{g_jg_j^{\mathsf T}}{p_j(1-p_j)}.                \tag{O3}
```

More precisely, with $s_i=g_i/p_i$ on positive probabilities,

```math
J(p)-\frac{g_jg_j^{\mathsf T}}{p_j(1-p_j)}
=\sum_{i\ne j:p_i>0}p_i
 \left(s_i+\frac{g_j}{1-p_j}\right)
 \left(s_i+\frac{g_j}{1-p_j}\right)^{\mathsf T}.                  \tag{O4}
```

To verify this, expand the right side and use $\sum_{i \ne  j} g_i=-g_j$
and $\sum_{i \ne  j}p_i=1-p_j$. It is a positive semidefinite sum. Equivalently,

```math
\frac{g_jg_j^{\mathsf T}}{p_j}\preceq(1-p_j)J(p).               \tag{O5}
```

The convention at $p_j=0$ is a zero left side. Indeed, a nonnegative
differentiable function has zero gradient at an interior zero. At $p_j=1$,
every other probability and every gradient is zero, so $J(p)=0$; (O5) is again
valid. These observations handle singular effects without a positivity
assumption on every detector outcome.

Equality in (O3), in a fixed scalar direction, occurs exactly when all positive
non-$j$ outcomes have the same score in that direction. In the matrix statement,
the full score vectors must be equal. This is an explicit equality condition,
not an assertion about source-level quantum commutativity.

### 2.2 Universal ordinary-ensemble replacement

Let $\omega$ be any state of probe $S$ and ancilla $A$. The detector effects are
$E_j(\theta)$. For output $j$, the ancilla readout is the finite POVM
$\{M_{j,r}\}_r$. Define positive unnormalized probe operators

```math
\tau_{j,r}=\operatorname{tr}_A\!\left[
 (I\otimes M_{j,r}^{1/2})\,\omega\,(I\otimes M_{j,r}^{1/2})
 \right],\qquad
\pi_{j,r}=\operatorname{tr}\tau_{j,r}.
```

They are independent of the unknown parameter. For each $j$,

```math
\sum_r\tau_{j,r}=\rho_S,\qquad \sum_r\pi_{j,r}=1.                \tag{O6}
```

When $\pi_{j,r}>0$, let $\rho_{j,r}=\tau_{j,r}/\pi_{j,r}$. Terms with zero $\pi$ have
zero joint probability for all parameters and can be dropped. The actual
joint probability and its gradient are

```math
q_{j,r}=\pi_{j,r}p_j(\rho_{j,r}),\quad
\nabla q_{j,r}=\pi_{j,r}g_j(\rho_{j,r}),
```

where $p_i(\rho)=\operatorname{tr}(\rho E_i)$ and $g_i(\rho)=\operatorname{tr}(\rho \nabla E_i)$. Consequently,

```math
J_{\rm assisted}
=\sum_{j,r:\pi_{j,r}>0}\pi_{j,r}
 \frac{g_j(\rho_{j,r})g_j(\rho_{j,r})^{\mathsf T}}
 {p_j(\rho_{j,r})},                                             \tag{O7}
```

with zero-probability summands omitted. Apply (O5) separately to the entire
ordinary output distribution of every $\rho_{j,r}$. This gives

```math
J_{\rm assisted}\preceq
\sum_{j,r}\pi_{j,r}[1-p_j(\rho_{j,r})]J(\rho_{j,r}).              \tag{O8}
```

The nonnegative coefficients in this sum add up to exactly $m-1$:

```math
\begin{aligned}
\sum_{j,r}\pi_{j,r}[1-p_j(\rho_{j,r})]
 &=m-\sum_j\operatorname{tr}(\rho_S E_j)\\
 &=m-1.                                                        \tag{O9}
\end{aligned}
```

Thus choose the ordinary probe $\rho_{j,r}$ with probability

```math
w_{j,r}=\frac{\pi_{j,r}[1-p_j(\rho_{j,r})]}{m-1},               \tag{O10}
```

record its preparation label, and use the same unknown detector once. Compute
these weights at the nominal point, and keep them fixed during parameter
differentiation. Its Fisher matrix is $J_{\rm mix}=\sum w_{j,r}J(\rho_{j,r})$, proving
(O1). This is a constructive local statistical comparison; it does not require
finding the assisted optimum, an SLD, or a semidefinite program.

Random preparations or conditional randomized readouts are covered by keeping
their parameter-independent seed as an extra label. Revealing that seed can
only increase Fisher information; conditional application of the construction
and mixing establishes the same result when the seed is discarded.

For one parameter, $J(\rho_{j,r}) \le  F_{\rm u}$. Equation (O8) therefore proves
(O1) for every assisted protocol; taking its supremum proves the optimal bound.
If $F_{\rm u}=0$, all the same inequalities yield $F_{\rm a}=0$. A single ordinary probe
can approximate $F_{\rm u}$, so $F_{\rm a} \ge  F_{\rm u}$. For $m=2$ both inequalities coincide.

### 2.3 Explicit matrix deficit

For $0 \lt p_j(\rho_{j,r})<1$, insert (O4) into (O8). The excess
$(m-1)J_{\rm mix} - J_{\rm assisted}$ is exactly a sum of within-complement score covariance
matrices, weighted by $\pi_{j,r}(1-p_j)$. At $p_j=0$, the positive remainder is
$\pi_{j,r}J(\rho_{j,r})$; at $p_j=1$, it is zero. This supplies a direct certificate
for equality or strictness of the simulation bound on a given protocol.

## 3. Clifford–simplex witnesses at every alphabet size

Set $n=m-1$. Choose traceless Hermitian matrices $\Gamma_1,\ldots,\Gamma_n$ with

```math
\Gamma_a\Gamma_b+\Gamma_b\Gamma_a=2\delta_{ab}I_d.               \tag{O11}
```

They can be constructed using Pauli matrices. For
$q=\max\{1,\lfloor n/2\rfloor\}$, use the first $n$ matrices from

```math
Z^{\otimes(k-1)}\otimes X\otimes I^{\otimes(q-k)},\quad
Z^{\otimes(k-1)}\otimes Y\otimes I^{\otimes(q-k)}\quad(1\le k\le q),
\qquad Z^{\otimes q}.
```

Thus $d=2^q$ suffices; for $m\ge 3$, this is $2^{\lfloor(m-1)/2\rfloor}$. No minimal-dimension
claim is made. Pauli multiplication proves (O11), and each listed matrix is
traceless. Distinct matrices are Hilbert--Schmidt orthogonal. For every real
vector $u$,

```math
\Gamma(u):=\sum_a u_a\Gamma_a,\qquad
\Gamma(u)^2=\|u\|^2I_d.                                        \tag{O12}
```

If $r_a=\operatorname{tr}(\rho \Gamma_a)$ for an arbitrary density matrix, then

```math
\|r\|^2=\operatorname{tr}[\rho\Gamma(r)]\le\|r\|,
\quad\text{and hence}\quad \|r\|\le1.                           \tag{O13}
```

Conversely, every $r$ in this unit ball is realized by the positive density
matrix $(I+\Gamma(r))/d$. This uses the trace identities and (O12), and is useful
for checking that an extremizer in the ball corresponds to a real probe.

Let $v_1,\ldots,v_m$ be a regular simplex of unit vectors in $\mathbb R^n$:

```math
\sum_jv_j=0,\qquad
v_i\cdot v_j=\begin{cases}1&i=j,\\-1/n&i\ne j,\end{cases}
\qquad \sum_jv_jv_j^{\mathsf T}=\frac mn I_n.                    \tag{O14}
```

An explicit formula is obtained by taking any orthonormal basis of the
hyperplane perpendicular to $(1,\ldots,1)$ in $\mathbb R^m$, taking its $m$ row vectors,
and multiplying by $\sqrt{m/n}$. Set $N_j=\Gamma(v_j)$. Equations (O11)--(O14) give
$N_j^2=I$, $\operatorname{tr} N_j=0$, and $\sum_j N_j=0$.

Consider the one-parameter detector

```math
E_j(c)=\frac{I_d+cN_j}{m},\qquad -1 \lt c<1.                         \tag{O15}
```

It is a full-rank POVM throughout this open interval, with all effect
eigenvalues $(1+c)/m$ or $(1-c)/m$. In particular $c=0$ is an interior regular
point. Here $c$ is a signed contrast parameter, not a nonnegative parameter
whose endpoint is being treated as regular.

### 3.1 Complete one-parameter optimum

For every $m\ge 2$ and $|c|<1$,

```math
\boxed{
F_{\rm a}(c)=\frac1{1-c^2},\qquad
F_{\rm u}(c)=\frac1{(1-|c|)(m-1+|c|)},\qquad
\frac{F_{\rm a}(c)}{F_{\rm u}(c)}=
\frac{m-1+|c|}{1+|c|}.
}                                                               \tag{O16}
```

At $c=0$, the ratio is precisely $m-1$, proving (O2). The minimum normalized
effect eigenvalue $m \lambda_{\min}(E_j)$ equals one at this point. For any fixed
$|c|<1$, the gain still grows linearly with $m$ while this normalized noise floor
stays fixed. The quantum dimension of this particular family grows with $m$.

#### Assisted upper bound and attainment

Write $D_j=\partial_c E_j=N_j/m$. Since $E_j$ and $D_j$ commute,

```math
K_j=E_j^{-1}D_j=\frac{N_j-cI}{1-c^2},\qquad
\sum_jD_jE_j^{-1}D_j=\frac{I_d}{1-c^2}.                          \tag{O17}
```

Hilbert--Schmidt Cauchy--Schwarz gives, for any joint input and conditional
readout, the upper bound $F \le  \operatorname{tr}[\rho_S \sum_j D_j E_j^{-1}D_j]$. One can verify
this directly on each joint outcome using the positive weight $E_j \otimes M$.
Equation (O17) bounds all assisted schemes by $1/(1-c^2)$.

Prepare $\Phi_d=d^{-1/2}\sum_k|k,k\rangle$. After detector result $j$, measure the
ancilla using

```math
M_{j,t}=\frac{I+tN_j^{\mathsf T}}2,\qquad t\in\{-1,1\}.
```

The transpose is in the Bell basis. The Bell trace identity gives

```math
q_{j,t}(c)=\frac{1+tc}{2m},\qquad
\partial_cq_{j,t}=\frac{t}{2m}.                                \tag{O18}
```

Their classical Fisher information is $1/(1-c^2)$. The POVMs and the Bell input
are independent of $c$, so this is an actual single-call experiment, not an
optimization that differentiates its own readout. The scheme uses at most $m$
different two-outcome ancilla readouts.

#### Ordinary upper bound, full equality conditions

By symmetry $c<0$ is reduced to $c>0$ by replacing $r$ with $-r$. Put
$x_j=v_j \cdot r$. Equations (O13)--(O14) yield

```math
\frac1m\sum_jx_j=0,\quad
\frac1m\sum_jx_j^2=\frac{\|r\|^2}{n}\le\frac1n,\quad
-1\le x_j\le1,
```

and the ordinary information is

```math
F(r)=\frac1m\sum_j\frac{x_j^2}{1+cx_j}.                         \tag{O19}
```

Set $a=1/n$, $A=1/[(1-c)(1+ca)^2]$, and

```math
Q(x)=Ax^2+cA[(1-c)a^2-2a]x+cAa^2.
```

The following rational identity is exact:

```math
Q(x)-\frac{x^2}{1+cx}
=\frac{cA(x+1)(x-a)^2}{1+cx}\ge0\qquad(-1\le x\le1).          \tag{O20}
```

Taking the average and using $A>0$ gives

```math
F(r)\le A\frac1n+cAa^2
=\frac1{(1-c)(n+c)}.                                           \tag{O21}
```

For $r=-v_l$, the scalar products are $x_l=-1$ and $x_j=1/n$ for $j\ne l$.
Every term in (O20) vanishes and the variance is maximal. Thus (O21) is attained.
The actual probe $(I-N_l)/d$ is one example.

For $c>0$, equality requires $\|r\|=1$ and every $x_j$ to equal $-1$ or $1/n$.
The zero-mean condition forces exactly one $-1$, which implies $r=-v_l$.
Equivalently, the complete ordinary maximizing set consists of all density
matrices supported in the negative eigenspace of some $N_l$. For $c<0$, use
the positive eigenspaces. At $c=0$, (O19) is exactly $\|r\|^2/n$, so all and only
states with $\|r\|=1$ maximize it.

This proof establishes the optimum over all mixed, complex, internally
entangled probe states, not just over a selected trial family.

### 3.2 Low-dimensional examples

For $m=3$, choose two Pauli matrices and a planar trine: the fully regular point
$c=0$ gives $F_{\rm u}=1/2$, $F_{\rm a}=1$. For $m=4$, choose all three Pauli matrices and a
tetrahedron, giving $F_{\rm u}=1/3$, $F_{\rm a}=1$. These show that qubit probes already
attain the sharp outcome bound for three and four outcomes. The retained
polygon formula also approaches the trine ratio two as contrast tends to zero;
the present contribution is the **universal impossibility of a larger gain**,
the all-$m$ construction, and the complete simplex noise curve.

## 4. Sharp joint outcome and readout-menu law


### 4.1 Retained menu inequality, with proof

The bound $F_b\le bF_{\rm u}$ was proved in the predecessor manuscript and is not new here. Fix a single ancilla POVM and hypothetically use it after every detector outcome. Measuring it before the detector produces an ordinary conditional-state ensemble, because the two subsystem measurements commute. The ancilla outcome distribution is independent of the parameter. Keeping that label, the complete experiment has information equal to an average of ordinary input informations, at most $F_{\rm u}$.

For a deterministic choice of readout depending on $j$, partition the actual Fisher-information sum by the chosen menu item. Each part contains a subset of the nonnegative terms from its hypothetical fixed-readout experiment, so each is at most $F_{\rm u}$. There are at most $b$ parts. For randomized inputs or choices, reveal a parameter-independent seed specifying all choices. Conditional application gives the same bound, and forgetting the seed cannot increase classical information. Outcome relabeling leaves the sum unchanged. An ordinary probe is itself an admissible one-menu experiment, so $F_1=F_{\rm u}$.

### 4.2 Matching construction under both budgets

The retained argument gives $F_b \le  b F_{\rm u}$. Together with (O1),
this proves the upper bound in (O2). Here is a matching construction requiring
only $b+1$ outcomes for every $b\le m-1$.

Choose $b$ traceless Clifford involutions $\Gamma_1,\ldots,\Gamma_b$. Fix
$0 \lt p<1/b$ and $p_0=1-bp$. Define

```math
E_a(t)=p(I+t\Gamma_a)\quad(1\le a\le b),\qquad
E_0(t)=p_0I-pt\sum_{a=1}^b\Gamma_a.                             \tag{O22}
```

Their sum is $I$. They are full rank on the open neighborhood

```math
|t|<\min\{1,p_0/(p\sqrt b)\},
```

because $(\sum_a \Gamma_a)^2=bI$. At the nominal point $t=0$, an arbitrary
ordinary probe with expectation vector $r$ has information

```math
F(r)=p\|r\|^2+\frac{p^2}{p_0}\left(\sum_a r_a\right)^2
\le p+\frac{bp^2}{p_0}=\frac p{p_0}.                           \tag{O23}
```

The unit vector $r=(1,\ldots,1)/\sqrt b$ is realizable and attains this value.
Hence $F_{\rm u}=p/p_0$.

Use a Bell input and the $b$ readouts $\Gamma_a^T$. On detector result $a\ge 1$,
choose readout $\Gamma_a^T$; on result zero, choose $\Gamma_1^T$. In each of the
first $b$ branches the two joint probabilities are $p/2$ and their derivatives
are $+p/2,-p/2$, contributing $p$ to Fisher information. In branch zero, the
probabilities are $p_0/2$, and the derivatives are $-p/2,+p/2$, contributing
$p^2/p_0$. Thus

```math
\frac{F_b}{F_{\rm u}}\ge
\frac{bp+p^2/p_0}{p/p_0}
=bp_0+p=b-(b^2-1)p\longrightarrow b.                           \tag{O24}
```

As $p\downarrow0$, both the ordinary information and the achieved assisted information tend to zero in the $t$ coordinate; the limiting statement concerns their ratio.

All models in this sequence are full rank on a nonempty two-sided parameter
interval. Only the supremum is claimed. If exactly $m>b+1$ nonzero outcomes are
required, split effect $E_0$ into $m-b$ equal effects and use the same readout on
each. Both ordinary and assisted Fisher information are unchanged.

For $b\ge m$, the simplex construction (O15) uses at most $m$ readouts and attains
ratio $m-1$ at $c=0$. The case $b=m-1$ is already covered by (O22)--(O24).
This proves (O2), including $b=1$ and $m=2$.

The construction does not establish finite-sample error ratios merely by
identifying a Fisher-information ratio. It does not claim all optimal menus
for a fixed detector, or a minimum ancillary dimension for the general bounds.

## 5. A nonlocal Pearson-information comparison

For a full-rank reference, the affine path $E(t)=E^0+t(E^1-E^0)$ is a valid detector on a two-sided neighborhood of zero. For any fixed protocol its Fisher information in $t$ at zero is exactly $\chi^2(P\Vert Q)$. Thus the comparisons in this section are exact corollaries of Sections 2–4, with no small-separation limit, rather than an independent second method. We give the finite-probability proof to exhibit the reference-dependent ensemble and the sharp witnesses directly. Quantum chi-squared information, measurement optimization, and its relation to Fisher information have established precedents [TV15]; fixed-channel contraction and tensorization [CL19] address a different comparison.

### 5.1 Two fixed detectors and one fixed protocol

Let $E^0=\{E_j^0\}_{j=1}^m$ and $E^1=\{E_j^1\}_{j=1}^m$ be two POVMs on the same
finite-dimensional probe space, with $m\ge 2$. Assume every reference effect
$E_j^0$ is positive definite. No differentiability, local parameterization, or
small separation between the two detectors is assumed. Alternative effects
need only be positive semidefinite.

A protocol prepares one joint probe--ancilla state $\omega$ and, after detector
result $j$, uses a finite trusted ancilla POVM $\{M_{j,r}\}_r$. The preparation,
readouts, and any classical randomization are **identical under both
hypotheses**. Only the unknown detector changes. The detector's quantum output
is discarded. The two actual joint distributions are

```math
Q_{j,r}=\operatorname{tr}[\omega(E_j^0\otimes M_{j,r})],\qquad
P_{j,r}=\operatorname{tr}[\omega(E_j^1\otimes M_{j,r})].            \tag{C1}
```

For discrete distributions, use the Pearson divergence in the specified
direction

```math
\chi^2(P\Vert Q)=\sum_{z:Q_z>0}\frac{(P_z-Q_z)^2}{Q_z}.          \tag{C2}
```

If $P_z>0=Q_z$, the divergence is infinite; a common zero contributes zero.
Our full-rank reference assumption ensures that every zero in (C1) is a
common zero, so this divergence is finite. Indeed the conditional probe
operator below is positive, and a zero trace against $E_j^0>0$ forces
that operator to vanish.

For an ordinary probe $\rho$, write

```math
q_j(\rho)=\operatorname{tr}(\rho E_j^0),\quad
p_j(\rho)=\operatorname{tr}(\rho E_j^1),\quad
C(\rho)=\chi^2(p(\rho)\Vert q(\rho)),\quad
C_{\rm u}=\max_\rho C(\rho).                                  \tag{C3}
```

Every $q_j(\rho)$ lies strictly between zero and one. Continuity and compactness
give the maximum in (C3). Allowing a labeled random choice of ordinary probes
does not increase this maximum: its Pearson divergence is the weighted
average of the individual divergences.

Write $C_{\rm a}$ for the supremum of (C2) over the allowed assisted protocols, and
$C_b$ for the same supremum when there are at most $b$ available ancillary
POVMs, selected after observing $j$. These are comparisons of two specified
detectors, not derivatives or Fisher information.

### 5.2 One ensemble for every alternative

**Theorem C1 (constructive Pearson-information domination).**

For every fixed protocol and fixed full-rank reference detector, there is one
labeled ordinary-probe ensemble $W$ such that

```math
\chi^2(P\Vert Q)\le(m-1)
\chi^2(P_W\Vert Q_W).                                          \tag{C4}
```

The ensemble depends only on the protocol and the reference detector. In
particular the **same ensemble** satisfies (C4) for every alternative POVM on
the same outcome alphabet, provided that the original assisted protocol is
held fixed. It follows that

```math
C_a\le(m-1)C_u.                                                \tag{C5}
```

**Proof.** For ordinary distributions set $\delta_i=p_i-q_i$. Then
$\sum_i \delta_i=0$, and weighted Cauchy--Schwarz gives

```math
C(\rho)\ge
\frac{\delta_j(\rho)^2}{q_j(\rho)[1-q_j(\rho)]}.                 \tag{C6}
```

An exact remainder identity is

```math
C(\rho)-\frac{\delta_j^2}{q_j(1-q_j)}
=\sum_{i\ne j}q_i
 \left(\frac{\delta_i}{q_i}+\frac{\delta_j}{1-q_j}\right)^2
\ge0.                                                         \tag{C7}
```

All denominators are positive by the reference assumption. This calculation
does not use a parameter derivative.

Form the positive unnormalized conditional probe states

```math
\tau_{j,r}=\operatorname{tr}_A[
(I\otimes M_{j,r}^{1/2})\omega(I\otimes M_{j,r}^{1/2})],\quad
\pi_{j,r}=\operatorname{tr}\tau_{j,r}.
```

For each $j$, $\sum_r \tau_{j,r}=\rho_S$ and $\sum_r \pi_{j,r}=1$. When $\pi>0$, put
$\rho_{j,r}=\tau_{j,r}/\pi_{j,r}$; zero-$\pi$ terms vanish under both hypotheses.
The joint distributions obey $Q_{j,r}=\pi_{j,r}q_j(\rho_{j,r})$ and
$P_{j,r}=\pi_{j,r}p_j(\rho_{j,r})$. Thus

```math
\begin{aligned}
\chi^2(P\Vert Q)
 &=\sum_{j,r}\pi_{j,r}
   \frac{\delta_j(\rho_{j,r})^2}{q_j(\rho_{j,r})}\\
 &\le\sum_{j,r}\pi_{j,r}[1-q_j(\rho_{j,r})]C(\rho_{j,r}).        \tag{C8}
\end{aligned}
```

The coefficients add to

```math
\sum_{j,r}\pi_{j,r}[1-q_j(\rho_{j,r})]
=m-\sum_j\operatorname{tr}(\rho_S E_j^0)=m-1.                   \tag{C9}
```

Choose probe $\rho_{j,r}$ with probability

```math
w_{j,r}=\frac{\pi_{j,r}[1-q_j(\rho_{j,r})]}{m-1}                \tag{C10}
```

and retain the preparation label. These weights are calculated once from the
reference and used unchanged under both hypotheses. The resulting labeled
ordinary distributions have Pearson divergence
$\sum_{j,r}w_{j,r}C(\rho_{j,r})$, proving (C4). Neither $\tau$ nor these weights
uses $E^1$, proving simultaneous applicability to alternative detectors.
Equation (C5) follows by bounding each ordinary divergence by $C_{\rm u}$ and taking
the assisted supremum. $\square$

The inequality is an information comparison relative to one reference. It
does **not** assert that a stochastic map turns the ordinary experiment into
the assisted experiment, nor that one ordinary ensemble reproduces every
joint probability.

### 5.3 Menu bound and sharp joint resource frontier

**Theorem C2 (menu and outcome bounds).**

For every fixed pair of detectors as above and every integer $b\ge 1$,

```math
C_b\le\min\{b,m-1\}C_u.                                       \tag{C11}
```

Over all such detector pairs having at most $m$ outcomes and $C_{\rm u}>0$, the best
constant is exactly

```math
\sup_{(E^0,E^1)}\frac{C_b}{C_u}=\min\{b,m-1\}.                 \tag{C12}
```

The same holds if exactly $m$ nonzero outcomes are required.

**Menu upper bound.** Fix one ancillary readout and hypothetically use it
after every detector outcome. Measuring this ancilla first produces a
parameter-independent ordinary-state ensemble, so its joint Pearson
divergence is an average of ordinary divergences and is at most $C_{\rm u}$.
For a deterministic readout-selection policy, partition the actual
nonnegative summands in (C2) by the menu item used. Each group's summands form
a subset of those for the corresponding hypothetical fixed-readout
experiment. Each group therefore contributes at most $C_{\rm u}$, giving
$C_b\le b C_{\rm u}$. Combine with Theorem C1.

For randomized selection or input preparation, reveal a hypothesis-independent
random seed specifying the deterministic choices. The revealed divergence is
the average of the conditional divergences. Forgetting the seed cannot
increase Pearson divergence: weighted Cauchy--Schwarz gives
$(\sum_z K(y|z)(P_z-Q_z))^2/(\sum_z K(y|z)Q_z) \le  \sum_z K(y|z)(P_z-Q_z)^2/Q_z$, and summing over $y$ proves the claim. This
also verifies that arbitrary randomization respects the same upper bound.

The sharpness constructions appear in Sections 5.4–5.5. No derivative limit is
used in either one. $\square$

### 5.4 Exact nonlocal simplex witnesses

Use the traceless Clifford matrices and the regular simplex constructed in Section 3, with $n=m-1$. Thus $N_j=\Gamma(v_j)$, $N_j^2=I$, $\operatorname{tr}N_j=0$, $\sum_jN_j=0$, and $\sum_jv_jv_j^{\mathsf T}=mI/(m-1)$. This includes the binary case with dimension two.

For each $h$ with $-1 \lt h<1$, compare the fixed reference and alternative

```math
E_j^0=I/m,\qquad E_j^h=(I+hN_j)/m.                             \tag{C13}
```

Both are full rank. For any ordinary state, set $r_a=\operatorname{tr}(\rho \Gamma_a)$ and
$x_j=v_j \cdot r$. The Clifford relation gives $\|r\|\le 1$, and every unit $r$ is
realized by the state $(I+\sum_a r_a \Gamma_a)/d$. Its reference probabilities
are $1/m$, and its alternative probabilities are $(1+h x_j)/m$. Therefore

```math
C(\rho)=\frac{h^2}{m}\sum_jx_j^2
=\frac{h^2}{m-1}\|r\|^2,
\qquad C_u=\frac{h^2}{m-1}.                                    \tag{C14}
```

Prepare the maximally entangled state $\Phi_d$ and, on detector outcome $j$, use
the fixed auxiliary readout $(I+t N_j^T)/2$, $t=+1,-1$. The two-hypothesis
probabilities are

```math
Q_{j,t}=\frac1{2m},\qquad P^h_{j,t}=\frac{1+th}{2m}.             \tag{C15}
```

Direct substitution in (C2) gives $\chi^2(P^h\Vert Q)=h^2$. The universal bound
$C_{\rm a}\le (m-1)C_{\rm u}=h^2$ proves

```math
\boxed{\quad C_a=h^2,\qquad C_u=h^2/(m-1).\quad}               \tag{C16}
```

For every nonzero $h$ in $(-1,1)$, the ratio is exactly $m-1$. At $h=0$ both
information quantities are zero; no ratio is defined. The readouts in (C15)
are independent of $h$, so a single assisted protocol establishes these
equalities for the entire interval. Its $m$ readouts also prove sharpness of
(C12) when $b\ge m$.

The witness works at finite, fixed separation, for example $h=1/2$; it is not
obtained by taking $h$ to zero.

### 5.5 Matching witnesses when the menu is the limiting resource

For $1\le b\le m-1$, take $b$ traceless Clifford involutions. Fix
$0 \lt p<1/(2b)$, put $p_0=1-bp$, and choose the same fixed contrast $h=1/2$
for every member of the sequence. Define the reference and alternative via

```math
E_a(t)=p(I+t\Gamma_a)\;(1\le a\le b),\qquad
E_0(t)=p_0I-pt\sum_{a=1}^b\Gamma_a,
\qquad (E^0,E^1)=(E(0),E(h)).                                  \tag{C17}
```

The effects sum to $I$ and are positive definite at both hypotheses:
$p_0>1/2$ and $p h \sqrt{b}<1/(4 \sqrt{b})\le 1/4$ guarantee positivity of $E_0(h)$;
the other effects have eigenvalues $p(1\pm h)>0$.

For a probe with Clifford expectation vector $r$,

```math
C(\rho)=h^2\left[p\|r\|^2+
\frac{p^2}{p_0}\left(\sum_a r_a\right)^2\right],\qquad
C_u=h^2 p/p_0.                                                 \tag{C18}
```

The upper value is attained at $r=(1,\ldots,1)/\sqrt{b}$. With a Bell input, use
menu readout $\Gamma_a^T$ on result $a\ge 1$ and $\Gamma_1^T$ on result zero.
At the reference the two joint probabilities in branch $a\ge 1$ are $p/2$,
and their finite changes are $+hp/2,-hp/2$; branch zero has reference
probabilities $p_0/2$ and changes $-hp/2,+hp/2$. Thus its divergence is
$h^2(bp+p^2/p_0)$ and

```math
\frac{C_b}{C_u}\ge b-(b^2-1)p\longrightarrow b
\quad\text{as }p\downarrow0.                                  \tag{C19}
```

Only $b+1$ outcomes are used. If exactly $m>b+1$ outcomes are required, split
$E_0(t)$ into $m-b$ equal effects and use the same readout on each. Pearson
information under both hypotheses is unchanged. Equations (C19) and (C16)
complete the proof of (C12), including $b=m-1$. For the limiting construction,
only the supremum is claimed; each finite pair itself is full rank.
Although the coordinate $h$ stays fixed, this particular rare-branch sequence
has $C_{\rm u}=h^2 p/p_0 -> 0$ and assisted divergence of order $p$. Thus it does
not establish joint-menu sharpness at a uniformly positive statistical
distance. The simplex witness in Section 5.4 separately has fixed positive
assisted divergence $h^2$ for every nonzero fixed $h$.


The limiting menu construction has both ordinary and achieved assisted Pearson divergence tending to zero as $p\downarrow0$, even at the fixed separation $h=1/2$. This information ratio is not asserted to equal a Bayes-error, minimax-risk, or sample-complexity ratio. Section 6 proves its testing statements independently.

## 6. Exact experiments and finite-sample separation

### 6.1 Recovering the classical experiment

Let $d\ge2$ and $1\le r \lt d$. Let Π_j be rank-r orthogonal projectors and w_j>0 satisfy

```math
\sum_j w_j=1,\qquad \sum_jw_j\Pi_j={r\over d}I_d.
```

For c in (-r/(d-r),1), define the full-rank detector

```math
E_j(c)=w_j\left[(1-c)I_d+{cd\over r}\Pi_j\right],
\qquad q={d-r\over d}(1-c)\in(0,1).
\tag{R1}
```

The detector produces only the classical label j. A memoryless use means the usual measurement channel, discarding the interrogated system. Arbitrary finite-dimensional retained quantum memory, entangled inputs, adaptive intermediate channels, and final measurements are permitted in the assisted n-use experiment. All controls and processing are parameter independent.

**Theorem R1 (finite-$n$ experiment equivalence).** For every n, every final classical outcome distribution of any assisted n-use strategy for (R1) is a parameter-independent stochastic postprocessing of n independent Bernoulli(q) variables. Conversely, n independent Bernoulli(q) variables can be obtained exactly using n independent maximally entangled pairs and a two-outcome conditional ancilla measurement per use. Consequently, for every parameter set, prior, action space, and bounded loss, the optimal assisted n-use decision risk equals the optimal risk in the classical experiment Ber(q)^{⊗n}.

**Proof.** Define two parameter-independent POVMs

```math
F_j^+={d\over r}w_j\Pi_j,\qquad
F_j^-={d\over d-r}w_j(I_d-\Pi_j).
```

Their sums are I_d, by the tight-frame identity. Direct substitution gives

```math
E_j(c)=(1-q)F_j^+ +qF_j^-.
\tag{R2}
```

Thus each call can be simulated by drawing T∼Ber(q), applying the fixed measurement channel F^+ or F^- according to T, and discarding T. This equality is an equality of channels, including their actions on an input entangled with arbitrary retained memory. Replacing the n calls in any adaptive protocol by these simulators leaves a circuit whose only parameter dependence is the product distribution of T_1,…,T_n. Conditional on that string the complete quantum circuit and its final measurement are fixed. Its final classical output is therefore a stochastic postprocessing of the n coins.

For the converse, prepare |Φ_d⟩=d^{-1/2}∑_a|a,a⟩. After label j, the unnormalized retained state is E_j(c)^T/d. Measure the two projectors Π_j^T and I_d-Π_j^T. Their joint probabilities are

```math
\Pr(j,+)=w_j(1-q),\qquad \Pr(j,-)=w_jq.
\tag{R3}
```

So j has the fixed law w independently of the observed Bernoulli variable. Repeating on independent pairs yields n independent coins. Simulation and recovery give both risk inequalities and hence equality. No limit, local normality approximation, or Cramér–Rao argument is used. ∎

**Attribution.** The simulation-and-recovery principle is the existing environment-parametrized/environment-seizable channel method, not a newly invented statistical equivalence theorem. See Wilde–Berta–Hirche–Kaur, *Amortized channel divergence for asymptotic quantum channel discrimination*, Letters in Mathematical Physics 110 (2020), 2277–2336, DOI 10.1007/s11005-020-01297-7, Definition 36 and Theorem 37; and Wang–Wilde, *Resource theory of asymmetric distinguishability for quantum channels*, Physical Review Research 1 (2019), 033169, DOI 10.1103/PhysRevResearch.1.033169, §III.A, equations (5)–(12). The detector identification (R1)–(R3), and especially the classical-memory separation proved below, are the concrete contributions to assess.

Taking d=2, r=1, w_j=1/m and Π_j=(I+n_j·σ)/2 yields exactly the balanced qubit visibility family in the retained baseline. The admissible interval above is simply the positivity interval of the two detector eigenvalues; both endpoints are excluded.

### 6.2 A uniform, finite-sample linear separation

Fix m≥3 and the regular planar directions

```math
\boldsymbol n_j=(\cos(2\pi j/m),\sin(2\pi j/m),0),\quad
E_j(h)={I+(1-h)\boldsymbol n_j\cdot\boldsymbol\sigma\over m}.
\tag{R4}
```

Compare the two fully specified hypotheses H_0:h and H_1:4h, where

```math
0 \lt h\le {1\over8m^2}.
\tag{R5}
```

All effects at both hypotheses are positive definite. A **classical-memory ordinary strategy** prepares a fresh qubit density matrix at each call as an arbitrary function of the entire previous classical transcript and of retained parameter-independent randomness, sends it into the detector, and retains no quantum system correlated with that call. Arbitrary randomized final decisions are allowed. There is no restriction to fixed probes or nonadaptive policies.

Let N_u(m,h) be the least fixed number of calls for which such an ordinary strategy has both type-I and type-II errors at most 1/4. Let N_a(m,h) be the corresponding quantity when arbitrary quantum memory and all assisted strategies of Theorem R1 are allowed.

**Theorem R2 (uniform finite-sample advantage).**

```math
\boxed{\frac{2m}{27h}\le N_u(m,h)\le\left\lceil\frac{4m}{h}\right\rceil,
\qquad
\frac{2}{9h}\le N_a(m,h)\le\left\lceil\frac8h\right\rceil.}
\tag{R6}
```

In particular, N_u/N_a=Θ(m), with constants uniform over (R5). A sufficient lower ratio constant is N_u/N_a≥m/112. The assisted strategy needs only one probe qubit and one retained ancilla qubit per call; independent pairs already achieve the assisted upper bound.

#### 6.2.1 Uniform ordinary information bound

We use the retained ordinary Fisher-information formula proved in Appendix A for the parameter θ, with c=cos θ and s=sin θ:

```math
F_u^{(\theta)}(s)=
{s\coth((m/2)\operatorname{artanh}s)-s^2\over1-s^2}.
\tag{R7}
```

For 0<s≤1/m,

```math
F_u^{(\theta)}(s)\le {3\over m}.
\tag{R8}
```

Indeed, coth x≤1/x+x for x>0. To check this without an external inequality, the function g(x)=(1+x²)sinh x−x cosh x vanishes at zero and has derivative x sinh x+x²cosh x≥0. Also s≤atanh s≤s/(1-s²), by integrating 1/(1-t²). With x=(m/2)atanh s,

```math
s\coth x\le {2\over m}+{ms^2\over2(1-s^2)}.
```

Dropping the negative term −s² in (R7), using ms²≤1/m and 1-s²≥8/9, gives

```math
F_u^{(\theta)}(s)
\le{1\over m}\left(2+{9\over16}\right){9\over8}
={369\over128m}<{3\over m}.
```

#### 6.2.2 Ordinary adaptive lower bound

For any chosen Bloch vector r with |r|≤1, put x_j=n_j·r. At h and 4h, the single-call laws are

```math
p_j={1+(1-h)x_j\over m},\qquad
q_j={1+(1-4h)x_j\over m}.
```

The elementary log u≤u−1 inequality yields D(p∥q)≤χ²(p∥q). Hence

```math
D(p\Vert q)
\le {9h^2\over m}\sum_j{x_j^2\over1+(1-4h)x_j}
=\frac{9h^2}{s_1^2}F^{(\theta)}(\boldsymbol r;s_1),
\qquad s_1^2=1-(1-4h)^2=8h-16h^2.
\tag{R9}
```

Condition (R5) implies s_1≤1/m and s_1²≥4h. Equations (R8)–(R9) therefore give the uniform conditional bound

```math
D(p\Vert q)\le {27h\over4m}.
\tag{R10}
```

Given any past transcript, an ordinary adaptive policy chooses the same conditional probe under the two hypotheses. Its own randomized actions introduce no conditional relative entropy. The KL chain rule, including the policy's recorded random seed, therefore bounds the complete n-call transcript by 27nh/(4m). Forgetting the seed or other labels cannot increase this divergence.

If both testing errors are ≤1/4, the total variation distance of the two transcript laws must be at least 1/2. Pinsker's inequality TV≤√(D/2) then forces D≥1/2, proving N_u≥2m/(27h). Equivalently this is the standard binary testing lower bound applied after the uniform controlled-experiment KL estimate. The quantum memory excluded in the ordinary definition is essential: this lower bound is not asserted for entangled multi-call inputs.

#### 6.2.3 Ordinary upper bound

Always use the pure probe with Bloch vector −n_0 and record whether the detector returns j=0. The resulting indicators are iid Ber(h/m) under H_0 and Ber(4h/m) under H_1. Let K be their count and set μ=nh/m. Decide H_1 if K≥2μ, H_0 otherwise. Chebyshev's inequality gives

```math
\Pr_0(K\ge2\mu)\le1/\mu,\qquad
\Pr_1(K<2\mu)\le1/\mu.
```

The first variance is at most μ, the second at most 4μ; the deviations from the two means are μ and 2μ. Therefore n≥4m/h suffices.

#### 6.2.4 Assisted bounds

By Theorem R1 the full assisted experiment is equivalent to n iid Ber(h/2) observations under H_0 and n iid Ber(2h) under H_1. For the lower bound,

```math
D(\operatorname{Ber}(h/2)\Vert\operatorname{Ber}(2h))
\le { (3h/2)^2\over 2h(1-2h)}
\le {9h\over4},
```

since h≤1/4. The same testing/Pinsker argument yields n≥2/(9h), covering arbitrary quantum-adaptive protocols by the exact simulation.

For the upper bound, observe the negative Bell readout indicator on each independent use. Its count K has mean nh/2 under H_0 and 2nh under H_1. Decide H_1 iff K≥nh. The two Chebyshev bounds are each ≤2/(nh), so n≥8/h suffices. This proves (R6).

For the explicit ratio, ceil(8/h)≤(8+h)/h≤(33/4)/h, so N_u/N_a≥8m/891>m/112. The matching upper bound N_u/N_a≤19m follows from the opposite two bounds. ∎

**Statistical scope.** This result is about the fixed binary calibration task, not an invocation of inverse-Fisher-information asymptotics. The lower bound already includes adaptive ordinary probe preparation. Both endpoints are full-rank experiments. The advantage increases while the classical detector alphabet grows and h decreases; the theorem does not claim such divergence under a fixed spectral floor or fixed alphabet. Taking h=m^{-4} (m≥3) gives assisted complexity Θ(m^4) and ordinary complexity Θ(m^5).

## 7. Sharp dimension, rank, and noise envelopes

The exact classical experiment of Section 6 has a further consequence: it separates a universal assisted optimum from the geometry-dependent ordinary optimum. Let $d\ge2$, $1\le r \lt d$, and let positive weights and rank-$r$ orthogonal projectors obey

```math
\sum_jw_j=1,\qquad \sum_jw_jP_j=\frac rd I_d.
```

Consider the entire class of finite detectors

```math
E_j(c)=w_j\left[(1-c)I_d+c\frac dr P_j\right],\qquad 0\le c<1. \tag{N0}
```

Local derivatives at $c=0$ are taken in the legitimate open extension
$-r/(d-r) \lt c<1$. Geometry, weights, and rank remain fixed as $c$ varies.
The number of outcomes is allowed to vary across the class in this section.

### 7.1 Exact assisted value and ordinary Haar envelope

**Theorem N1.** Every such frame has

```math
F_{\rm a}(c)=J_{d,r}(c):=
\frac{d-r}{(1-c)[r+(d-r)c]}. \tag{N1}
```

This follows directly from the Bernoulli equivalence with
$q=(d-r)(1-c)/d$. It can also be checked with (U1). Writing
$a=1+c(d/r-1)$ and $\varepsilon=1-c$, simultaneous eigenspaces give

```math
\begin{aligned}
\sum_jD_jE_j^{-1}D_j
&=\sum_jw_j\left[\frac{(d/r-1)^2}{a}P_j+
\frac1\varepsilon(I-P_j)\right]\\
&=J_{d,r}(c)I_d.
\end{aligned}
```

A maximally entangled pair and the conditional ancilla projections
$\{P_j^{\mathsf T},I-P_j^{\mathsf T}\}$ attain this bound with the fixed Born probabilities in (R3). The two-eigenvalue state-information calculation is standard. In particular, the rank-one value already occurs in depolarizing-channel estimation [F11]; its numerical expression is not claimed as new.

Let $T\sim\operatorname{Beta}(r,d-r)$ and define

```math
H_{d,r}(c)=\mathbb E\frac{[(d/r)T-1]^2}{1-c+c(d/r)T},\qquad
R_{d,r}(c)=\frac{J_{d,r}(c)}{H_{d,r}(c)}. \tag{N2}
```

**Theorem N2.** Every finite weighted rank-$r$ tight frame satisfies
$F_{\rm u}(c)\ge H_{d,r}(c)$. Moreover, over all such finite frames,

```math
\inf F_{\rm u}(c)=H_{d,r}(c),\qquad
\sup\frac{F_{\rm a}(c)}{F_{\rm u}(c)}=R_{d,r}(c). \tag{N3}
```

These are an infimum and a supremum. The continuous Haar projector experiment attains them exactly. At $c=0$ a finite second-moment cubature also attains them; finite attainment for every positive $c$ is not claimed.

**Proof.** For a pure ordinary input $\psi$, put $t_j=\langle\psi,P_j\psi\rangle$. Direct differentiation yields

```math
F(\psi)=\sum_jw_jf_c(t_j),\qquad
f_c(t)=\frac{[(d/r)t-1]^2}{1-c+c(d/r)t}.
```

Classical information is convex in the input density matrix, so a maximum can be taken on pure states. Haar averaging the state makes each $t_j$ have the same beta law, independently of the frame. For completeness, a Haar vector can be obtained by normalizing independent complex Gaussian coordinates; the sums of squared moduli in the $r$-dimensional range and its $(d-r)$-dimensional orthogonal complement are independent gamma variables. Their normalized ratio has the stated beta density. Thus the Haar average of $F(\psi)$ is $H_{d,r}$, and its maximum is at least that average. If instead the projectors themselves are Haar distributed, unitary invariance makes the integral equal to $H_{d,r}$ for every pure input. The finite construction below converges uniformly to this value, proving (N3) within finite detectors. $\square$

### 7.2 A finite-outcome approximation certificate

**Theorem N3.** Fix $0 \lt c<1$ and an integer $t\ge1$, and set

```math
z=\frac{cd}{r+(d-r)c}\in(0,1).
```

There is a positive weighted finite rank-$r$ tight frame with at most
$\binom{d^2+t}{t}$ outcomes for which

```math
H_{d,r}(c)\le F_{\rm u}(c)
\le H_{d,r}(c)+\frac{z^{t+1}}{(1-c)c^2}. \tag{N4}
```

Consequently its advantage lies between
$J_{d,r}/[H_{d,r}+z^{t+1}/((1-c)c^2)]$ and $R_{d,r}$.

**Proof.** Regard Hermitian projectors as points in $\mathbb R^{d^2}$ and record all real coordinate monomials of total degree at most $t$. The Haar average of this vector lies in its compact convex hull. The constant coordinate is one, so Carathéodory's theorem gives a positive cubature with at most $\binom{d^2+t}{t}$ nodes after zero weights are removed. Its first moment is tight, and it matches every degree-at-most-$t$ polynomial in $\langle\psi,P\psi\rangle$, simultaneously for all $\psi$.

The tight first moment and elementary polynomial division give

```math
F(\psi)=\frac1{c^2}\left[\sum_j\frac{w_j}{1-c+c(d/r)t_j}-1\right].
```

For $u=1-t_j\in[0,1]$, the reciprocal is

```math
\frac1{a(1-zu)}=\frac1a\sum_{k=0}^t z^ku^k+\mathcal R_t(u),
\qquad
0\le\mathcal R_t(u)\le\frac{z^{t+1}}{a(1-z)}
=\frac{z^{t+1}}{1-c}.
```

The finite and Haar polynomial integrals coincide. Both remainder integrals lie between zero and the same upper bound, so their difference in absolute value is at most that bound. This is uniform in $\psi$. Combine with Theorem N2. When $c=0$, $f_0$ is quadratic, and a degree-two cubature is already exact. $\square$

The theorem supplies a sufficient finite outcome budget and an existence certificate. It neither determines the minimum required budget nor gives an efficient general node-finding algorithm. A separate necessary constraint follows from the outcome theorem: a finite detector attaining a ratio $G$ must have $m\ge G+1$. No interchange of a fixed-alphabet limit with a growing-alphabet limit is used.

For qubits an explicit construction avoids the general convex-hull existence step. Take $L=\lceil(t+1)/2\rceil$ Gauss–Legendre nodes $x_\ell$ with positive weights $a_\ell$ on $[-1,1]$, and $K=t+1$ equally spaced azimuths. Define

```math
\begin{aligned}
\boldsymbol n_{\ell,k}&=
\left(\sqrt{1-x_\ell^2}\cos\frac{2\pi k}{K},
\sqrt{1-x_\ell^2}\sin\frac{2\pi k}{K},x_\ell\right),\\
P_{\ell,k}&=\frac{I+\boldsymbol n_{\ell,k}\cdot\boldsymbol\sigma}{2},
\qquad w_{\ell,k}=\frac{a_\ell}{2K}.
\end{aligned}
```

There are $LK$ outcomes. Azimuthal averaging annihilates every nonzero Fourier frequency of magnitude at most $t$. Each surviving monomial is a polynomial in $x$ of degree at most $t$, and Gauss–Legendre quadrature integrates it exactly. Thus all spherical polynomials of degree at most $t$ match Haar measure and (N4) applies. This is an explicit sufficient construction, without a claim of optimal support size.

### 7.3 Rank-dependent noise behavior

**Theorem N4.** At the central point,

```math
H_{d,r}(0)=\frac{d-r}{r(d+1)},\qquad
J_{d,r}(0)=\frac{d-r}{r},\qquad R_{d,r}(0)=d+1. \tag{N5}
```

As $\varepsilon=1-c\downarrow0$, with $d,r$ fixed,

```math
R_{d,1}(1-\varepsilon)\sim\frac1{\varepsilon\log(1/\varepsilon)},
\qquad
R_{d,r}(1-\varepsilon)\sim\frac{r-1}{\varepsilon}\quad(r\ge2). \tag{N6}
```

**Proof.** The beta mean and variance give (N5). For $c>0$, let
$I(c)=\mathbb E[1/(1-c+c(d/r)T)]$; then $H=(I-1)/c^2$.
For $r=1$, the density of $X=dT$ is continuous at zero with value $(d-1)/d$. Split the integral at a fixed small positive point. On the lower part the density is arbitrarily close to its value at zero; the remaining integral is bounded. Since integrating $1/(\varepsilon+cX)$ on a fixed interval gives a leading $\log(1/\varepsilon)$,
$I(c)/\log(1/\varepsilon)\to(d-1)/d$. Together with
$J\sim(d-1)/(d\varepsilon)$, this proves the first asymptotic.
For $r\ge2$, $\mathbb E(1/T)=(d-1)/(r-1)$. When $c\ge1/2$, the reciprocal integrand is bounded by $2r/(dT)$, an integrable function. Dominated convergence gives
$I\to r(d-1)/[d(r-1)]$, hence
$H\to(d-r)/[d(r-1)]$. Since
$J\sim(d-r)/(d\varepsilon)$, the second claim follows. $\square$

For $d=2,r=1$, direct integration gives

```math
H_{2,1}(c)=\frac{\operatorname{artanh}(c)/c-1}{c^2},\qquad
R_{2,1}(c)=\frac{c^2}{(1-c^2)[\operatorname{artanh}(c)/c-1]},
\quad R_{2,1}(0)=3. \tag{N7}
```

The same radial expression occurs in Eq. (4) of Okamoto et al. [O15]; neither this closed form nor its logarithmic singularity is claimed as newly discovered. The contribution of this section is the optimization over all finite tight-projector detector frames, its exact assisted operational interpretation, the finite approximation certificate, and the fixed-rank classification. Haar symmetrization, beta overlap laws, quadrature, and moment cubature are standard methods. The theorem does not cover arbitrary detector parameter paths, changing projector directions, or outcome-dependent noise.

## 8. Compatibility and the limits of robustness

For a finite ancilla measurement menu M={M_{a|x}}, define generalized incompatibility robustness by

```math
R_g(M)=\inf\{t\ge0:\ (M_{a|x}+tN_{a|x})/(1+t)\text{ is jointly measurable for some POVM menu }N\}.
\tag{R11}
```

The noise menu N has the same setting and outcome sets. Zero effects are allowed. This is the convention of Skrzypczyk–Šupić–Cavalcanti, PRL 122, 130403 (2019), equation (6).

**Lemma R3.** If the available ancilla menu is jointly measurable, every result-conditioned single-call strategy has Fisher information at most F_u, for every detector and every joint probe-ancilla input.

**Proof.** A compatible menu has a parent POVM G_λ and stochastic maps p(a|x,λ). Measure G before the detector (the two subsystems commute), keeping λ. It prepares a parameter-independent ensemble of ordinary probe states. After observing detector label j, the original choice x(j) and map p(a|x(j),λ) generate the desired joint law. Its information is bounded by that of (λ,j), which is an average of ordinary probe informations and hence at most F_u. Randomized setting choice is another parameter-independent postprocessing. ∎

**Theorem R4 (arbitrarily small robustness, unbounded Fisher advantage).** For every ε>0 and every B<∞ there are a full-rank single-parameter qubit detector, a two-qubit input, and a finite menu M of three-outcome ancilla POVMs satisfying R_g(M)≤ε, for which the actually obtained Fisher information exceeds B F_u. There is also an explicit sequence with R_g→0 and obtained Fisher-information ratio→∞. Therefore no locally bounded nondecreasing function of R_g alone can upper-bound this metrological gain, even at fixed probe and ancilla dimension two.

**Proof.** Take the existing regular 2b-gon visibility detector. Its Bell strategy uses b distinct two-outcome projective measurements P_{±|x}; opposite detector directions only exchange their labels. For a fixed 0<α≤1, replace each menu item by the three-outcome lossy measurement

```math
M^\alpha_{+|x}=\alpha P_{+|x},\qquad
M^\alpha_{-|x}=\alpha P_{-|x},\qquad
M^\alpha_{e|x}=(1-\alpha)I.
\tag{R12}
```

The erasure is retained as a visible outcome. Choose the legitimate noise POVM

```math
N_{+|x}=P_{-|x},\quad N_{-|x}=P_{+|x},\quad N_{e|x}=0.
```

Then (M^α+αN)/(1+α) has setting-independent scalar effects

```math
{\alpha\over1+\alpha}I,\quad
{\alpha\over1+\alpha}I,\quad
{1-\alpha\over1+\alpha}I.
```

They are jointly measurable, so R_g(M^α)≤α. On the Bell input, the erasure's joint probability with detector j is (1−α)/(2b), independent of the unknown visibility parameter. The nonerasure probabilities and their derivatives are both multiplied by α. Their Fisher information is therefore exactly α times that of the original Bell experiment, namely F=α in the θ parameterization. The ordinary optimum is unchanged. At fixed b its limit as θ↓0 is F_u→1/b. For any fixed α>0, increasing b and then taking a positive sufficiently small θ yields arbitrarily large F/F_u while R_g≤α.

For an explicit sequence, let α_b=b^{-1/2}, m=2b and s_b=sin θ_b=b^{-2}. Then m s_b→0, so the already proved polygon formula gives F_u∼1/b. Thus

```math
R_g(M^{\alpha_b})\le b^{-1/2}\longrightarrow0,
\qquad {F\over F_u}\sim\sqrt b\longrightarrow\infty.
\tag{R13}
```

The obtained absolute $\theta$-information is $\alpha_b\to0$; only the ratio diverges. Every detector effect in this sequence is strictly positive. All erased events are kept; there is no uncharged postselection. ∎

**Exact compatibility threshold for (R12).** If the b projective axes are pairwise distinct up to sign, the menu (R12) is compatible iff αb≤1. For necessity, use a deterministic parent with one declared output for every x. If a parent outcome declares a nonerasure result at two distinct axes, its positive effect lies below two nonproportional rank-one projectors and must vanish. Hence every nonzero parent effect contributes to at most one nonerasure setting, and summing all 2b conclusive marginal effects gives αb I≤I. For sufficiency, take parent effects αP_{±|x} for each pair (x,±) and (1−αb)I for an all-erasure outcome. At setting x, declare the sign only on its own pair and erasure otherwise. Thus the menus in (R13) are indeed incompatible for b>1, consistent with Lemma R3.

**Why this is compatible with earlier resource theorems.** Generalized incompatibility robustness exactly controls an optimized positive state-discrimination payoff ratio (PRL 122, 130403, equation (5)). Fisher information is a quadratic derivative divided by a probability, and the noise decomposition need not control those small denominators. The present no-go concerns result-conditioned detector calibration and a resource-only multiplicative bound. Tan–Narasimhachar–Regula, PRL 127, 200402 (2021), Theorem 2 gives an existence/lower-bound result using generalized robustness, not a resource-only upper bound for every task. Their Theorem 3 upper bound instead assumes binary decoding, uses standard robustness, and includes task-dependent derivative sensitivity. The surrounding discussion explicitly leaves more general task-independent upper bounds in question. These differences prevent a contradiction. Measurement-noise sensitivity of Fisher information is also known (Kurdziałek–Demkowicz-Dobrzański, PRL 130, 160802, 2023); the construction here makes a specific failure of uniform incompatibility-robustness control explicit.

## 9. Positioning, operational meaning, and limitations

### 9.1 What is and is not new

The central result is a constructive comparison for every fixed detector-assisted experiment, followed by exact resource laws over all finite detector models. It does not claim a new measurement architecture or a new general information inequality. The complement identity is elementary, and Clifford generators are standard. Their use here produces one legal ordinary ensemble for the full Fisher matrix, with exact normalization $m-1$, and permits sharp witnesses and a closed joint alphabet/menu frontier. The finite-distance extension shows that the outcome factor is not solely a differential artifact. The separate finite-sample theorem quantifies actual errors in an adaptive testing experiment.

The following comparisons fix the scope of this claim.

| Closest prior work | Established result or method | Relation to this manuscript |
|---|---|---|
| D'Ariano–Maccone–Lo Presti [D04]; Brida et al. [B12] | Ancilla-assisted detector calibration and experimental reconstruction | The conditional-ancilla architecture and earlier statistical benefits are credited. The present results optimize ordinary versus assisted information and count two separate classical resources. |
| Das et al. [D26] | Extended detector information bound; a claimed universal single-parameter ordinary attainability statement | We retain the valid upper-bound method. The simplex witnesses violate the claimed universal ordinary attainability for every $m\ge3$. For binary detectors our universal theorem proves $F_{\rm a}=F_{\rm u}$; it does not by itself prove that the extended upper bound is attained. |
| Shi–Tang [ST20] | Outcome-number resource theory; discrimination advantage relative to measurements simulable with fewer effective outcomes | Their payoff and free-measurement class differ. We compare probe strategies for the same destructive detector, and bound Fisher/Pearson information by its observed alphabet and conditional-readout menu. Outcome count as a resource is not itself a new idea. |
| Datta et al. [D21] | Entanglement-assisted destructive measurement discrimination and a steering interpretation | We do not claim the first measurement-discrimination advantage or steering mechanism. The universal $m-1$ information replacement and finite-sample polygon separation have different objectives and quantifiers. |
| Albarelli–Demkowicz-Dobrzański [AD22] | Costs of using one probe for different parameter directions or random channels | Their resource factor counts parameters or channels. Our ensemble replaces one assisted experiment and works in every parameter direction at once; its factor counts detector outputs. |
| Skrzypczyk–Šupić–Cavalcanti [SSC19] | Exact operational meaning of incompatibility robustness in optimized discrimination success | This is a close resource-law comparison, not a theorem about detector Fisher information. Section 8 shows that generalized robustness alone cannot uniformly upper-bound our information ratio. |
| Tan–Narasimhachar–Regula [TNR21]; Kurdziałek–Demkowicz-Dobrzański [KD23] | Universal Fisher resource witnesses; measurement-noise susceptibility | Existence of advantageous tasks and Fisher sensitivity to noise are known. Our no-go is for a particular resource-only multiplicative upper bound, with visible erasures and no omitted trials. |
| Frey–Collins–Gerlach [F11]; Okamoto et al. [O15] | Depolarized-state information and the qubit Haar radial expression | Their formulas are credited explicitly. The new frame theorem supplies a detector-operational sharp envelope, finite-outcome approximation, and rank-dependent classification. |
| Wilde–Berta–Hirche–Kaur [WBHK20]; Wang–Wilde [WW19] | Environment-parametrized and environment-seizable channels | Simulation and recovery are established methods. Section 6 identifies the particular detector class, proves the exact Bernoulli experiment directly, and uses it in the ordinary-versus-assisted sample comparison. |
| Kwon–Lie–Jiang [KLJ26] | Fisher-matrix bounds for small-error maximum-likelihood learning, including Pauli-channel entanglement and classical-register comparisons | The connection between Fisher information and learning-resource separations is established. Our polygon result is a specified two-point test with uniform finite-sample constants in $0 \lt h\le1/(8m^2)$ and an arbitrary classical-feedback ordinary lower bound; it does not claim the first such general connection. |
| Yang–Xiao–Zhu [YXZ26]; Taherpour–Taherpour–Khattab [TTK26] | Projective-design Fisher guarantees; Haar minimax qubit direction readout | Moment matching, Haar averaging, and finite-support approximation have close precedents. Those works study pure-state tangent information or direction at fixed Bloch length; our noise parameter changes the detector's radial contrast and is compared with retained-ancilla strategies. |

The bounded source audit read the fixed v2 text of [D26], including Methods V.1.3 and Supplement II.F. The output-count expression in its multiparameter identifiability discussion is not the same theorem as (O1): it counts how many probe configurations are needed to identify a vector parameter. The published assertion challenged here concerns ordinary attainability despite permission for outcome-conditioned ancilla readout. We do not invalidate its logarithmic-derivative upper bound, common-eigenbasis special cases, or unrelated multiparameter conclusions. The historical minimax diagnosis remains in the companion manuscript and is not needed for any proof above. No response from the original authors or journal has been obtained in this work.

The source comparison was updated through 25 November 2026. The official full text of [TTK26] was inspected, including its outcome-degree identifiability count and finite-support appendices. For [YXZ26], official metadata was retrieved but official full-text access failed; the available original manuscript was inspected through a mirror, and that access limitation is recorded in the source ledger. No equivalent sharp outcome replacement or joint budget theorem was found in the primary material inspected. This is a bounded novelty audit, not a certificate of worldwide priority.

### 9.2 Distinct resources and limits

The results separate three mechanisms that should not be conflated. The Clifford–simplex family has ratio $m-1$ at $c=0$, with normalized minimum effect eigenvalue $m\lambda_{\min}(E_j)=1$; its quantum dimension increases with $m$. The qubit polygon uses fixed quantum dimension, a growing classical alphabet, and a shrinking spectral floor. The frame envelope instead fixes dimension and rank, then optimizes over all finite alphabets at a specified noise level. Each model remains finite and full rank at every asserted operating point.

The joint menu frontier is a worst-case supremum across detector models. In its limiting witness $p\downarrow0$, both ordinary and achieved assisted Fisher information tend to zero in the specified parameter coordinate. A large ratio is therefore not a claim of large absolute sensitivity. Likewise the erased-menu sequence has assisted $\theta$-information $\alpha_b\to0$, even though its ratio diverges. The explicit sample theorem addresses absolute call counts for its own specified task and does not transfer those counts to all witnesses.

The matrix theorem compares one local assisted Fisher matrix with one local ordinary ensemble. It does not assert Blackwell simulation of an arbitrary detector experiment, simultaneous attainment of multiparameter quantum bounds, or a uniform global ensemble independent of the nominal point. The exact all-loss statistical equivalence is proved only for the tight fixed-rank family in Section 6. Pearson-divergence bounds are not universal ratios of testing errors or Bayes risks. The ordinary lower bound in the polygon testing theorem allows classical adaptation but excludes quantum memory and entangled multi-call inputs; the assisted lower bound includes them through the exact simulation.

The present work does not determine the minimum Hilbert-space dimension needed for every budget pair, all optimal menus for a fixed detector, necessary cubature support sizes, or whether every incompatible menu is useful in this restricted detector task. These are outside the proved scope. This manuscript has not undergone external peer review.

## Appendix A. Retained exact polygon formula

This appendix reproduces the predecessor result needed for the finite-sample and robustness theorems. It is retained evidence, not a new result of the present continuation.

Let $m\ge3$, $0<\theta<\pi/2$, $c=\cos\theta$, $s=\sin\theta$, and

```math
\boldsymbol n_j=(\cos(2\pi j/m),\sin(2\pi j/m),0),\qquad
E_j(\theta)=\frac{I+c\boldsymbol n_j\cdot\boldsymbol\sigma}{m}.
```

Then, with $t=c/(1+s)=\exp[-\operatorname{artanh}s]$,

```math
F_{\rm u}^{(\theta)}(s)=
\frac{s(1+t^m)/(1-t^m)-s^2}{1-s^2}
=\frac{s\coth[(m/2)\operatorname{artanh}s]-s^2}{1-s^2},
\qquad F_{\rm a}^{(\theta)}=1. \tag{A1}
```

An ordinary optimizer has Bloch vector $-\boldsymbol n_j$. An assisted optimizer uses a Bell pair and the spectral measurement of $(\boldsymbol n_j\cdot\boldsymbol\sigma)^{\mathsf T}$ after outcome $j$, with the transpose in the Bell basis. The assisted value follows from (R3), with $q=(1-\cos\theta)/2$; alternatively (U1) gives the matching upper bound.

For completeness, an arbitrary Bloch vector $\boldsymbol r$ gives

```math
F(\boldsymbol r)=\frac{s^2}{m}\sum_j
\frac{(\boldsymbol n_j\cdot\boldsymbol r)^2}{1+c\boldsymbol n_j\cdot\boldsymbol r}.
```

Only the planar component matters. At fixed angle write its length as $a\in[0,1]$ and $x_j=\cos(\phi-2\pi j/m)$. Every summand increases with $a$, because

```math
\frac{d}{da}\frac{a^2x_j^2}{1+cax_j}
=\frac{ax_j^2(2+cax_j)}{(1+cax_j)^2}\ge0.
```

It suffices to use $a=1$. Since $\sum_jx_j=0$,

```math
F(\phi)=\frac{s^2}{c^2}[A_m(\phi)-1],\qquad
A_m(\phi)=\frac1m\sum_j\frac1{1+c\cos(\phi-2\pi j/m)}.
```

The absolutely convergent Poisson-kernel series is

```math
\frac1{1+c\cos x}
=\frac1s\left[1+2\sum_{k\ge1}(-t)^k\cos(kx)\right].
```

Polygon averaging removes all frequencies except multiples of $m$, so

```math
A_m(\phi)=\frac1s\frac{1-t^{2m}}{1-2(-t)^m\cos(m\phi)+t^{2m}}.
```

Its maximum is $s^{-1}(1+t^m)/(1-t^m)$, attained when
$\cos(m\phi)=(-1)^m$, or $\phi=\pi+2\pi j/m$. Substitution proves (A1). For fixed $m$, the limit as $s\downarrow0$ is $2/m$. More generally, whenever $m\to\infty$ and $ms\to0$,

```math
mF_{\rm u}^{(\theta)}(s)\longrightarrow2. \tag{A2}
```

Indeed, put $z_m=(m/2)\operatorname{artanh}s$. Then $z_m\to0$,
$ms/z_m\to2$, $z_m\coth z_m\to1$, and $ms^2\to0$, proving (A2). At fixed $s>0$, by contrast, the ordinary value tends to $s/(1+s)$. These distinct regimes explain why alphabet growth at a fixed noise floor is different from the joint small-noise scaling used in Section 6.

## Appendix B. Verification and proof scope

The accompanying deterministic programs evaluate the complete Born distributions, exact rational identities, Clifford constructions, sharp ordinary states, multiparameter matrix comparisons, cubature moments and error bounds, and finite-sample binomial probabilities. They also record numerical tolerances and dependency versions. An independently written audit tests singular-probability matrix boundaries and an adaptive three-call quantum-memory simulation. The reproduction guide gives executable commands and exact output locations.

These computations are finite consistency checks. The all-dimensional, all-parameter, and all-strategy assertions rest on the analytic proofs above. Neither numerical sampling nor symbolic verification of one identity is presented as a proof of the full quantum experiment. This manuscript has no completed Lean formalization.

## References

- **[D04]** G. M. D'Ariano, L. Maccone, and P. Lo Presti, *Quantum Calibration of Measurement Instrumentation*, Physical Review Letters **93**, 250407 (2004). DOI [10.1103/PhysRevLett.93.250407](https://doi.org/10.1103/PhysRevLett.93.250407). [Primary preprint](https://arxiv.org/abs/quant-ph/0408116).
- **[B12]** G. Brida et al., *Ancilla-Assisted Calibration of a Measuring Apparatus*, Physical Review Letters **108**, 253601 (2012). DOI [10.1103/PhysRevLett.108.253601](https://doi.org/10.1103/PhysRevLett.108.253601). [Author-institution record and paper](https://www.nist.gov/publications/ancilla-assisted-calibration-measuring-apparatus).
- **[D26]** A. Das et al., *Precision bounds for characterising quantum measurements*, Nature Communications **17**, 1821 (2026). DOI [10.1038/s41467-026-68529-7](https://doi.org/10.1038/s41467-026-68529-7). [Fixed arXiv v2](https://arxiv.org/html/2512.20091v2), Methods V.1.3 and Supplement II.F.
- **[ST20]** W. Shi and C. Tang, *Number of quantum measurement outcomes as a resource*, Quantum Information Processing **19**, 393 (2020). DOI [10.1007/s11128-020-02899-9](https://doi.org/10.1007/s11128-020-02899-9). [Primary preprint](https://arxiv.org/pdf/2005.02722), Proposition 1 and Eqs. (5)–(8).
- **[D21]** C. Datta, T. Biswas, D. Saha, and R. Augusiak, *Perfect discrimination of quantum measurements using entangled systems*, New Journal of Physics **23**, 043021 (2021). DOI [10.1088/1367-2630/abecaf](https://doi.org/10.1088/1367-2630/abecaf). [Primary preprint](https://arxiv.org/abs/2012.07069v2).
- **[AD22]** F. Albarelli and R. Demkowicz-Dobrzański, *Probe Incompatibility in Multiparameter Noisy Quantum Metrology*, Physical Review X **12**, 011039 (2022). DOI [10.1103/PhysRevX.12.011039](https://doi.org/10.1103/PhysRevX.12.011039). [Primary preprint](https://arxiv.org/pdf/2104.11264), Eqs. (7)–(9).
- **[SSC19]** P. Skrzypczyk, I. Šupić, and D. Cavalcanti, *All Sets of Incompatible Measurements Give an Advantage in Quantum State Discrimination*, Physical Review Letters **122**, 130403 (2019). DOI [10.1103/PhysRevLett.122.130403](https://doi.org/10.1103/PhysRevLett.122.130403). [Primary preprint](https://arxiv.org/pdf/1901.00816), Eqs. (5)–(6).
- **[TNR21]** K. C. Tan, V. Narasimhachar, and B. Regula, *Fisher Information Universally Identifies Quantum Resources*, Physical Review Letters **127**, 200402 (2021). DOI [10.1103/PhysRevLett.127.200402](https://doi.org/10.1103/PhysRevLett.127.200402). [Author copy](https://bartoszregula.me/pdf/PhysRevLett.127.200402.pdf), Theorems 1–3.
- **[KD23]** S. Kurdziałek and R. Demkowicz-Dobrzański, *Measurement Noise Susceptibility in Quantum Estimation*, Physical Review Letters **130**, 160802 (2023). DOI [10.1103/PhysRevLett.130.160802](https://doi.org/10.1103/PhysRevLett.130.160802). [Primary preprint](https://arxiv.org/abs/2206.12430).
- **[F11]** M. Frey, D. Collins, and K. Gerlach, *Probing the qudit depolarizing channel*, Journal of Physics A: Mathematical and Theoretical **44**, 205306 (2011). DOI [10.1088/1751-8113/44/20/205306](https://doi.org/10.1088/1751-8113/44/20/205306). [Primary preprint](https://arxiv.org/pdf/1008.1557), Eqs. (9)–(10).
- **[O15]** R. Okamoto, S. Oyama, K. Yamagata, A. Fujiwara, and S. Takeuchi, *Experimental demonstration of adaptive quantum state estimation for single photonic qubits*, Physical Review A **96**, 022124 (2017). DOI [10.1103/PhysRevA.96.022124](https://doi.org/10.1103/PhysRevA.96.022124). [APS accepted manuscript](https://link.aps.org/accepted/10.1103/PhysRevA.96.022124), Eq. (4).
- **[WBHK20]** M. M. Wilde, M. Berta, C. Hirche, and E. Kaur, *Amortized channel divergence for asymptotic quantum channel discrimination*, Letters in Mathematical Physics **110**, 2277–2336 (2020). DOI [10.1007/s11005-020-01297-7](https://doi.org/10.1007/s11005-020-01297-7). [Primary preprint](https://arxiv.org/abs/1808.01498), Definition 36 and Theorem 37.
- **[WW19]** X. Wang and M. M. Wilde, *Resource theory of asymmetric distinguishability for quantum channels*, Physical Review Research **1**, 033169 (2019). DOI [10.1103/PhysRevResearch.1.033169](https://doi.org/10.1103/PhysRevResearch.1.033169), Section III.A, Eqs. (5)–(12).
- **[YXZ26]** Z. Yang, B. Xiao, and H. Zhu, *Sharp Uniform Fisher Information Bounds from Projective Designs*, [arXiv:2611.17288v1](https://arxiv.org/abs/2611.17288) (2026). No journal publication was verified. Sections II.C, III.B, and VI were inspected in the original manuscript through a mirror after official full-text access failed; see the source ledger.
- **[TTK26]** A. Taherpour, A. Taherpour, and T. Khattab, *Global Minimax Readout of a Qubit Direction*, [arXiv:2608.16840v1](https://arxiv.org/html/2608.16840v1) (2026). No journal publication was verified. The fixed-direction task, outcome-degree discussion, and finite-support appendices provide the closest geometric comparison.
- **[KLJ26]** H. Kwon, S. H. Lie, and L. Jiang, *Universal Sample Complexity Bounds in Quantum Learning Theory via Fisher Information Matrix*, PRX Quantum **7**, 033063 (2026). DOI [10.1103/8k5v-ddtw](https://doi.org/10.1103/8k5v-ddtw). [Primary preprint v2](https://arxiv.org/html/2602.21510v2), Section III.3 and Eqs. (68)–(79); the official journal metadata and small-error maximum-likelihood scope were also checked.
- **[TV15]** K. Temme and F. Verstraete, *Quantum chi-squared and goodness of fit testing*, Journal of Mathematical Physics **56**, 012202 (2015). DOI [10.1063/1.4905843](https://doi.org/10.1063/1.4905843). [Primary preprint](https://arxiv.org/pdf/1112.6343), Lemma 5 and Theorem 6.
- **[CL19]** Y. Cao and J. Lu, *Tensorization of the strong data processing inequality for quantum chi-square divergences*, Quantum **3**, 199 (2019). DOI [10.22331/q-2019-10-28-199](https://doi.org/10.22331/q-2019-10-28-199). [Primary preprint](https://arxiv.org/abs/1904.06562v2).
