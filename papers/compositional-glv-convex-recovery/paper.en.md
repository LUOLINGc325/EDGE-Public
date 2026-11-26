# Global and Stable Recovery of Compositional Lotka–Volterra Dynamics

## Abstract

We study a generalized Lotka–Volterra system when only the relative abundance of every species is observed. For every number of species $n\ge3$, we prove that a single positive trajectory generically determines all growth rates, all interaction coefficients, and the state trajectory up to one positive population scale. Competing realizations need not satisfy a genericity condition. The proof settles the arbitrary-community-size structural-identifiability conjecture stated by Remien, Eckwright, and Ridenhour and supplies a constructive inverse: a lifted linear system has a one-dimensional kernel; observable path integrals then define a clock and state primitives; the remaining parameters are the unique minimizer of an explicitly given strictly convex function. The algorithm uses path values and integrals, without observed derivatives or nonlinear fitting of the original differential equation.

We further prove a deterministic discrete-observation guarantee. On precisely conditioned classes, a quasi-uniform mesh $h$ and composition errors bounded by $\epsilon$ yield parameter and trajectory error at most $C(\epsilon+h^2+\epsilon^2/h)$, with additional controlled integration and optimization errors. Thus $h\asymp\sqrt\epsilon$ achieves error of order $\epsilon$. A two-point argument shows that this noise order cannot be improved uniformly on a nontrivial well-conditioned parameter neighborhood. This is a deterministic noise statement; the joint mesh dependence is not claimed optimal. Finally, with unknown constant species-specific detection efficiencies, we determine the full positive diagonal equivalence class and prove the exact rank criterion for absolute calibration. In particular, $n$ scalar total-biomass measurements at suitably chosen times are necessary and sufficient, whereas known relative efficiencies leave only one scalar calibration. All statements concern the specified deterministic, fully observed species model. Degenerate trajectories and conditioning limitations are stated explicitly.

# 1. Introduction and contribution boundary

Population interaction models use absolute abundances, while sequencing commonly reports compositions. A positive time-dependent scale is therefore hidden in the observation map. This creates an inverse problem before sampling noise, optimization, or biological misspecification is considered: can different interaction networks generate exactly the same composition trajectory?

Remien et al. [Remien2021] computed structural-identifiability relations for two through five species and explicitly conjectured the same positive-scale conclusion for arbitrary community size. Their work also explained the distinction between identifiability in principle and estimation from imperfect data. BEEM [Li2019] had already coupled biomass and interaction estimation from relative abundances, using the same logarithmic-ratio identity that underlies our algebra. The subsequent iLV method [Huang2025] combined iterative linear approximations with nonlinear optimization. Its corrections [Sun2026, PLOS2026Correction] acknowledge BEEM and repair the correction notice's reference list. These methods and prior low-dimensional calculations motivate, but do not provide, the general global recovery and discrete stability theorem proved here.

The main contribution is the complete chain from a single compositional trajectory to a globally identifiable quotient and a stable computation on that quotient. The unknown population scale is eliminated in a lifted linear kernel. The missing common growth rate and common interaction row are then recovered by convex moment matching. The latter step is essential: simply reconstructing a scale from a numerical derivative would not establish the path-value observation guarantee.

We distinguish four contributions from the components on which they rely:

| Component | Prior or elementary ingredient | Result established here |
|---|---|---|
| Global information content | Positive-scale symmetry and low-dimensional calculations | A single-trajectory, all-competitor theorem for every $n\ge3$, with a nonzero polynomial genericity certificate |
| Constructive recovery | Logarithmic ratios and biomass regression | Exact one-dimensional lifted kernel followed by a globally unique convex reconstruction from path integrals |
| Discrete observations | Linear algebra perturbation and convexity | An end-to-end bound with no derivative oracle, including path roughness, cumulative moments, minimizer existence, and physical reconstruction |
| Detection bias | Fixed multiplicative efficiency models | The complete dynamic diagonal equivalence class and sharp scalar calibration rank criterion |

The source conjecture concerns identifiability; the constructive, discrete, and calibration statements are explicit further questions posed in this manuscript. Ordinary logarithmic transformations, singular-vector estimates, positivity of an exponential Hessian, and the existence of multiplicative bias are not claimed as independent inventions. Nor does the method claim superior empirical performance on biological data: the included calculations check algebraic recovery and finite numerical behavior only.

General differential-algebraic identification methods provide broader decision procedures [Audoly2001, Hong2020]. Linear input-output theory also distinguishes coefficients of output equations from genuinely identifiable quantities [Ovchinnikov2023]. We address one nonlinear family with a special projective observation map and produce a direct inverse with an explicit observation-error regime. We do not claim a generic replacement for those methods. The recent structural functional-identifiability work [Loman2026] treats unknown observation functions, including a two-species Lotka–Volterra example with a different observation map and a family of initial conditions; its theorem is not the single-trajectory compositional statement considered here.

Other nearby results use different information models. The microbial structural-analysis study [DiazSeoane2023] examines finite-dimensional configurations and local rank conditions; the dynamic-modeling workflow [ParedesVazquez2025] treats absolute or partially observed states. The conservative multispecies sampled-data method [Semenov2024] assumes absolute states and derivatives at sampling times. The stochastic framework [ZapienCampos2024] uses a process-noise model and information beyond a single deterministic composition path. None of these distinctions is an empirical performance ranking. The source-access statement in Section 10 records the materials actually checked and the remaining access limitations.

# 2. Model, observations, and principal theorem

Write $x=(x_1,\ldots,x_n)^{\mathsf T}$ and consider

$$
 x_i'=x_i\left(r_i+\sum_{j=1}^n A_{ij}x_j\right),\qquad
 p_i=\frac{x_i}{N},\qquad N=\sum_jx_j. \tag{M1}
$$

The coefficients $r\in\mathbb R^n$ and $A\in\mathbb R^{n\times n}$ are unrestricted. All coordinates of the state are positive on a finite interval. The reference species is $n$, and

$$
 a_i=r_i-r_n,\quad B_i=A_i-A_n,\quad
 \ell_i=\log(p_i/p_n),\qquad 1\le i \lt n. \tag{M2}
$$

The observation is of all $n$ species with their labels preserved. There is no external input and no unobserved species. The time coordinate is observed in fixed units. A comparison realization may use any real coefficients and any positive initial state, but must use the same model family and the same observation map.

The unavoidable ambiguity is

$$
 (r,A,x)\longmapsto(r,A/c,cx),\qquad c>0. \tag{M3}
$$

For the recovery algorithm we use the equivalent convention $U=\kappa B$, $\widehat A=\kappa A$, $\widehat x=x/\kappa$. The lifted kernel vector $(U,C)$ is normalized to Euclidean norm one and oriented so that the recovered clock increases. This fixes a local and globally consistent positive gauge whenever the stated kernel condition holds. Matrix errors below use the Frobenius norm; state errors use the supremum Euclidean norm. The results do not depend on the numerical choice of these finite-dimensional norms.

**Theorem M1 (principal result).** For each integer $n\ge3$, there is a nonzero real polynomial in $(r,A,x(0))$ such that, away from its zero set and for positive initial states, the following assertions hold on every nontrivial positive interval.

1. Every other positive GLV realization with the same composition trajectory is related by (M3). In particular all growth rates are uniquely determined.
2. Finitely many composition path integrals determine a one-dimensional linear kernel. From that kernel, further observable path integrals and a strictly convex finite-dimensional objective recover a representative $(r,\widehat A,\widehat x)$ of the entire realization. No observed derivative is used in this path formulation.
3. Around each such model one can select a nondegenerate observation window and a conditioned parameter neighborhood on which the discrete estimator of Section 6 is well defined. If the observation nodes form a quasi-uniform mesh $h$, the composition error is at most $\epsilon$, and $\epsilon\le c h$, then, for sufficiently small total error,

$$
 \|\widetilde r-r\|+\|\widetilde A-\widehat A\|
 +\|\widetilde x-\widehat x\|_\infty
 \le C\left(h^2+\epsilon+\frac{\epsilon^2}{h}+q+e\right). \tag{M4}
$$

Here the state supremum is over the selected recovery interval $I$. The symbol $q$ is the controlled aggregate integration error and $e$ the controlled optimization residual in the units specified in Section 6. Constants depend on the stated positivity, excitation, spectral-gap, and local compactness bounds. They are not uniform across degeneracies. With $q+e=O(\epsilon)$ and $h\asymp\sqrt\epsilon$, the noise order is $O(\epsilon)$. On an interior conditioned parameter neighborhood, no estimator based on the same discrete compositions has uniformly smaller order under adversarial sup-norm observation errors.
4. Under the constant-efficiency observation map (P1), the complete equivalence class is (P2), and the calibration criterion is exactly $\operatorname{rank}Z=n$ in (P3).

**Proof organization.** The polynomial excitation and kernel arguments in Section 3 prove the first assertion. Sections 4–5 establish the path construction and unique convex minimizer. Section 6 proves (M4), existence and uniqueness after perturbation, and the two-point lower bound. Section 7 proves the calibration assertion. The fixed two-species calculation is supplied separately in Appendix A and is not needed for the arbitrary-dimensional path algorithm. $\square$

The exact-data statements distinguish continuum path values from a finite list of derivative observations. Both are discussed, but only the discrete theorem supplies a guarantee from finitely many noisy abundance values. It does not claim that an arbitrary fixed coarse set of noiseless abundance values exactly identifies every admissible model.

In the exact formulation, integration and linear algebra have their usual mathematical meanings. A finite exact-rank statement is not a claim that zero testing for arbitrary real oracles is decidable. The discrete formulation uses quantitative gaps and prescribed numerical accuracy instead.

# 3. Exact identification and reconstruction for three or more species

## Model, observations, and conventions

Fix an integer $n\ge 3$. A generalized Lotka–Volterra realization consists of a vector $r\in\mathbb R^n$, a matrix $A\in\mathbb R^{n\times n}$, and a solution of

```math
\dot x_i(t)=x_i(t)\left(r_i+\sum_{j=1}^n A_{ij}x_j(t)\right),\qquad i=1,\ldots,n. \tag{C.1}
```

We work on connected open intervals on which every coordinate is strictly positive. The observed quantities are all labelled proportions

```math
N(t)=\sum_{j=1}^n x_j(t),\qquad p_i(t)=\frac{x_i(t)}{N(t)}. \tag{C.2}
```

The time coordinate is observed with its original scale. Initial absolute abundances are unknown. No equilibrium, sparsity, sign pattern, conserved total abundance, or known interaction coefficient is assumed. Results concern the intervals of existence of the positive solutions; global existence for all future times is not required.

Write $m=n-1$, and use row-vector notation

```math
a_i=r_i-r_n,\qquad b_i=A_i-A_n,\qquad
B=\begin{pmatrix}b_1\\\vdots\\b_m\end{pmatrix}.
```

The logarithmic ratios and their derivatives satisfy

```math
\ell_i=\log(p_i/p_n),\qquad
q_i=\dot\ell_i=a_i+b_i x=a_i+N b_i p. \tag{C.3}
```

The log-ratio reduction in (C.3), and biomass regression when $a,B$ are given, are established constructions in [Li et al. (2019)](https://doi.org/10.1186/s40168-019-0729-z). Our arguments below concern uniqueness and a complete reconstruction, rather than claiming this transformation itself as new.

For every $c>0$, the realization

```math
\widetilde r=r,\qquad\widetilde A=cA,\qquad
\widetilde x(t)=x(t)/c \tag{C.4}
```

has exactly the same proportions. We call (C.4) the common positive scale ambiguity. It is already described by [Remien, Eckwright, and Ridenhour (2021)](https://doi.org/10.1098/rsos.201378). The issue is whether additional ambiguities remain.

For an integer $d\ge1$, let $Q_d$ be the space of real polynomials in $X_1,\ldots,X_n$ with zero constant coefficient and total degree at most $d$. A trajectory has **polynomial excitation of degree $d$** on an interval $J$ if

```math
P\in Q_d,\quad P(x(t))=0\text{ for every }t\in J
\quad\Longrightarrow\quad P=0. \tag{C.5}
```

This is a sufficient information condition, not a characterization of every identifiable nongeneric trajectory. We prove below that the condition required here holds outside a proper algebraic exceptional set of GLV parameters and initial states.

## Algebraic preliminaries

**Lemma C1 (affine excitation and restriction of the observation interval).**
Suppose a positive GLV trajectory has polynomial excitation of degree at least two on a nonempty open interval $J$. Then no nonzero affine polynomial vanishes on the whole trajectory on $J$. Moreover, the same polynomial excitation holds on every nonempty open subinterval of $J$.

*Proof.* If $F(X)=v_0+v^T X$ vanishes along the trajectory, then $X_1F\in Q_2$ does too. Polynomial excitation gives $X_1F=0$ as a polynomial. Since the real polynomial ring is an integral domain and $X_1\ne0$, we obtain $F=0$.

The GLV vector field is polynomial, so its solutions are real analytic on their intervals of existence, by the analytic local existence theorem for ordinary differential equations. If a polynomial composed with the solution vanishes on an open subinterval, the identity theorem for real analytic functions makes it vanish on the connected interval $J$. Equation (C.5) then applies. $\square$

**Lemma C2 (collinearity of linear maps).**
Let $B,U:\mathbb R^n\to\mathbb R^m$ be linear maps with $\operatorname{rank}B\ge2$. If

```math
(BX)_i(UX)_j-(BX)_j(UX)_i=0
\quad\text{for every }X\in\mathbb R^n\text{ and every }i \lt j,
```

then $U=cB$ for a unique scalar $c\in\mathbb R$.

*Proof.* Choose $v,w\in\mathbb R^n$ so that $Bv,Bw$ are linearly independent. The hypothesis implies $Uv=\alpha Bv$ and $Uw=\beta Bw$. Applying it at $v+w$, and comparing the independent vectors $Bv,Bw$, gives $\alpha=\beta=:c$.

If $Bz\ne0$, then $Bz$ is independent of at least one of $Bv,Bw$. Applying the same argument to that pair gives $Uz=cBz$. If $Bz=0$, applying the hypothesis at $z+v$ shows that $Uz\in\operatorname{span}\{Bv\}$; applying it at $z+w$ shows that $Uz\in\operatorname{span}\{Bw\}$. Thus $Uz=0=cBz$. This holds for all $z$. Since $B\ne0$, the scalar is unique. $\square$

**Lemma C3 (injectivity of the intercept equations).**
If $\operatorname{rank}U\ge2$, the linear map

```math
T_U:\mathbb R^m\longrightarrow
\prod_{1\le i \lt j\le m}\mathbb R^n,
\qquad (T_U v)_{ij}=v_iU_j-v_jU_i
```

is injective.

*Proof.* Suppose $T_Uv=0$ and $v_i\ne0$ for some $i$. For every $j$, the corresponding equation gives $U_j=(v_j/v_i)U_i$. All rows of $U$ are proportional, contradicting its rank. Hence $v=0$. $\square$

## A one-dimensional lift and the complete ambiguity class

Introduce unknowns

```math
U\in\mathbb R^{m\times n},\qquad
V=(V_{ij})_{1\le i \lt j\le m},\quad V_{ij}\in\mathbb R^n,
```

and the linear observation operator

```math
\mathcal L_{p,q}(U,V)_{ij}(t)
=q_i(t)U_jp(t)-q_j(t)U_ip(t)-V_{ij}p(t). \tag{C.6}
```

The number of scalar unknowns is

```math
K=mn+n\binom m2=\frac{n^2(n-1)}2. \tag{C.7}
```

Here the kernel of the continuous operator means that every component in (C.6) vanishes for every time in the observation interval. Define

```math
C_{ij}=a_i b_j-a_jb_i. \tag{C.8}
```

**Theorem C4 (exact kernel of the lifted observation operator).**
Let $x$ be a positive GLV solution on a nonempty open interval $J$. If it has polynomial excitation of degree two on $J$, and $\operatorname{rank}B\ge2$, then

```math
\ker\mathcal L_{p,q}
=\{c(B,C):c\in\mathbb R\}. \tag{C.9}
```

In particular, the kernel is exactly one-dimensional, and every nonzero vector in it has a matrix component of rank at least two.

*Proof.* Substituting (C.3) shows directly that $(B,C)$ belongs to the kernel. Conversely, let $(U,V)$ belong to the kernel. Multiplying (C.6) by the positive scalar $N(t)$ yields

```math
(a_i+b_i x)(U_jx)-(a_j+b_jx)(U_ix)-V_{ij}x=0. \tag{C.10}
```

The left side is the evaluation of a polynomial in $Q_2$. Polynomial excitation makes it a polynomial identity. Its homogeneous quadratic part gives

```math
(b_iX)(U_jX)-(b_jX)(U_iX)=0
\quad\text{for every }X.
```

Lemma C2 implies $U=cB$. The homogeneous linear part of (C.10) then gives

```math
V_{ij}=a_iU_j-a_jU_i=cC_{ij}.
```

Thus every kernel vector is of the asserted form. Since $B\ne0$, the kernel generator is nonzero; if the kernel vector is nonzero, then $c\ne0$ and $\operatorname{rank}U=\operatorname{rank}B\ge2$. $\square$

**Theorem C5 (global identification against arbitrary competing realizations).**
Let $x$ be a positive $n$-species GLV solution on a connected open interval $I$, and suppose it has polynomial excitation of degree two and $\operatorname{rank}B\ge2$. Let $y$ be any other positive $n$-species GLV solution, with parameters $r^*,A^*$, on a connected open interval $I^*$. If the labelled proportions of $x$ and $y$ agree on a nonempty open subinterval of $I\cap I^*$, then there is a unique $c>0$ such that

```math
r^*=r,\qquad A^*=cA,\qquad y(t)=x(t)/c
\quad(t\in I\cap I^*). \tag{C.11}
```

No genericity, rank, or excitation hypothesis is imposed on the competing realization.

*Proof.* Restrict first to the open interval $J$ of equal observations. Lemma C1 transfers excitation to $J$. The data $p,q$ coincide for the two realizations. Put $a_i^*=r_i^*-r_n^*$, $b_i^*=A_i^*-A_n^*$, and $C_{ij}^*=a_i^*b_j^*-a_j^*b_i^*$. Every GLV realization of $p$ satisfies the lifted equation, so $(B^*,C^*)\in\ker\mathcal L_{p,q}$. By Theorem C4,

```math
B^*=cB,\qquad C^*=cC
```

for some real $c$. This scalar cannot be zero. If $B^*=0$, then (C.3) for the competing model makes $q=a^*$ constant; for the true model, $a+Bx=a^*$. Lemma C1 forces $B=0$, a contradiction.

After dividing the equations for $C^*$ by $c\ne0$, we have $T_B(a^*-a)=0$. Lemma C3 gives $a^*=a$. Consequently,

```math
N(t)Bp(t)=N^*(t)cBp(t). \tag{C.12}
```

The vector $Bp(t)$ is nonzero at some time. Otherwise each row of $B$ would vanish along $x=Np$, contrary to excitation and the rank hypothesis. Choose a small open subinterval $J_0\subset J$ on which $Bp\ne0$. Equation (C.12) gives $N^*=N/c$ there. Both totals are positive, so $c>0$, and $y=x/c$ on $J_0$.

On this interval the coordinatewise logarithmic derivatives agree. Hence

```math
r_i+A_ix=r_i^*+(A_i^*/c)x,\qquad i=1,\ldots,n.
```

These are affine identities along the true trajectory on $J_0$. Lemma C1 yields $r^*=r$ and $A^*=cA$. The function $x/c$ and $y$ now solve the same GLV equation and agree at one point of $J_0$. Uniqueness for the polynomial ODE extends their equality to the common interval $I\cap I^*$, which is connected. Finally, $x(t)>0$ at any common time makes the scalar $c$ unique. $\square$

## Polynomial certificates for generic excitation

The following lemma concerns the proof of genericity only. It is not an instruction to compute high-order derivatives of data.

**Lemma C6 (a nonzero Lie–Wronskian polynomial).**
Fix integers $n\ge1$ and $d\ge1$, a reference time $t_0$, and let

```math
M_d=\binom{n+d}{d}-1.
```

List the monomials $\phi_\alpha(X)=X^\alpha$ with $1\le|\alpha|\le d$ in any fixed order. For the vector field $f_i(X)=X_i(r_i+A_iX)$, define

```math
W_d(r,A,x_0)
=\det\big[(L_f^k\phi_\alpha)(x_0)\big]
_{0\le k \lt M_d,\ 1\le|\alpha|\le d}, \tag{C.13}
```

where $L_fP=\nabla P\cdot f$. Then $W_d$ is a nonzero polynomial in $r,A,x_0$. For each fixed $x_0\in(0,\infty)^n$, it remains a nonzero polynomial in $r,A$. If $W_d(r,A,x_0)\ne0$, the solution through $x_0$ at $t_0$ has polynomial excitation of degree $d$ on its whole positive existence interval and every nonempty open subinterval.

*Proof.* Lie differentiation maps polynomials in $X,r,A$ to polynomials of the same variables, so every matrix entry, and therefore its determinant, is polynomial in $r,A,x_0$.

Take $A=0$ and $r_i=(d+1)^{i-1}$. The solution is $x_i(t)=x_{0i}e^{r_i(t-t_0)}$. For each listed multi-index,

```math
\phi_\alpha(x(t))=x_0^\alpha
e^{\lambda_\alpha(t-t_0)},\qquad
\lambda_\alpha=\sum_i\alpha_i(d+1)^{i-1}.
```

The numbers $\lambda_\alpha$ are distinct: all digits $\alpha_i$ lie between zero and $d$, so uniqueness of base-$(d+1)$ expansion applies. At this parameter point,

```math
W_d=\left(\prod_\alpha x_0^\alpha\right)
\det[\lambda_\alpha^k]_{k,\alpha},
```

which is a nonzero Vandermonde determinant times positive column factors. This works for every fixed positive $x_0$, proving both nonvanishing claims.

If $P=\sum_\alpha c_\alpha\phi_\alpha$ vanishes along the solution on an interval containing $t_0$, its first $M_d$ time derivatives at $t_0$ give the linear system in (C.13) with right side zero. Nonvanishing of the determinant implies every $c_\alpha=0$. If the vanishing interval does not contain $t_0$, analyticity first extends the identity to $t_0$. This proves the stated excitation and restriction properties. $\square$

**Theorem C7 (generic global identification in every dimension $n\ge3$).**
For every $n\ge3$, the parameter space

```math
\mathcal P_n=\mathbb R^n\times\mathbb R^{n\times n}\times(0,\infty)^n
```

contains a relatively Zariski-open dense subset, with Lebesgue-null complement, on which every realization is globally identifiable from its full labelled proportion trajectory up to (C.4). The assertion also holds for every fixed positive initial state, with genericity taken only over $r,A$. It remains dense and of full measure in every nonempty open parameter region, including open sign-constrained regions.

*Proof.* Let $\Delta(A)$ be the determinant of the submatrix of $B$ using its first two rows and first two columns. It is a nonzero polynomial: $A=I_n$ gives $\Delta=1$. By Lemma C6, $W_2$ is nonzero, also for each fixed positive initial state. The polynomial ring over the reals is an integral domain, so $W_2\Delta$ is nonzero. Its nonvanishing defines the desired relatively Zariski-open set. The zero set of a nonzero real polynomial has empty interior and Lebesgue measure zero; these properties persist after restricting to any nonempty open region.

On this set, $W_2\ne0$ gives the required excitation, and $\Delta\ne0$ gives $\operatorname{rank}B\ge2$. Theorem C5 then identifies the true realization against all positive competing realizations, not merely other points of this generic set. $\square$

The theorem does not assert genericity inside an arbitrary lower-dimensional constrained model, such as a prescribed conservation law or a forced rank-one interaction structure. Those submodels require their own analysis. The exceptional set used in the proof is sufficient, and need not equal the full set of unidentifiable realizations.

## Finite nodes and the exact role of derivatives

**Lemma C8 (finite evaluation of an excited trajectory).**
If a trajectory has polynomial excitation of degree $d$ on an open interval $J$, there are $M_d$ distinct times $t_1,\ldots,t_{M_d}\in J$ for which

```math
\Phi_{s,\alpha}=x(t_s)^\alpha,
\qquad1\le|\alpha|\le d, \tag{C.14}
```

is invertible. For a GLV trajectory, the successful ordered tuples form an open dense subset of the ordered distinct-time domain, and their complement there has Lebesgue measure zero.

*Proof.* The evaluation vectors $\phi(x(t))\in\mathbb R^{M_d}$, as $t$ varies, span the full space. Otherwise a nonzero vector orthogonal to their span would define a nonzero polynomial in $Q_d$ that vanishes along the whole trajectory. Choose $M_d$ evaluation vectors forming a basis. Their times must be distinct, since repeated times give identical rows.

For GLV, the determinant in (C.14) is a real analytic function of the time tuple and is not identically zero. It is nonzero on an open set. The identity theorem implies that its zero set has no interior on each ordered domain; permutation of the selected tuple supplies a nonzero point in each such domain. The standard zero-set theorem for nonzero real analytic functions gives measure zero for the exceptional tuples. $\square$

For degree two, set

```math
D=M_2=\frac{n(n+3)}2.
```

**Theorem C9 (finite first-derivative lift and effective nodes).**
Suppose $D$ true state nodes $x(t_s)$ have an invertible $Q_2$ evaluation matrix (C.14), and $\operatorname{rank}B\ge2$. Stack (C.6) over these nodes to obtain a finite matrix $L$ with $K$ columns. Then $\operatorname{rank}L=K-1$, and its kernel is generated by $(B,C)$. It is obtained from $p(t_s),p'(t_s)$ alone.

For any nonzero kernel vector $(U,V)=c(B,C)$, let an effective node mean one with $Up(t_s)\ne0$. The effective nodes have an affine state design matrix $[1,x(t_s)^T]$ of full column rank $n+1$. In particular, at least $n+1$ effective nodes exist.

*Proof.* A kernel vector makes every polynomial (C.10) vanish at all $D$ state nodes. Invertibility of the evaluation matrix makes these polynomial identities, so the proof of Theorem C4 applies without modification. The entries of $L$ use $p$ and $q_i=p_i'/p_i-p_n'/p_n$, hence only first-derivative data.

To prove the final assertion, suppose an affine polynomial $F$ vanishes at every effective node. Choose any nonzero row of $B$, and let $\lambda(X)=b_iX$ be its nonzero linear polynomial. At an ineffective node, $Up=0$; since $U=cB$ with $c\ne0$ and $N>0$, this implies $Bx=0$, and hence $\lambda(x)=0$. At an effective node, $F(x)=0$. Consequently $\lambda F\in Q_2$ vanishes at all $D$ nodes. The evaluation matrix makes $\lambda F=0$ as a polynomial. Its integral-domain property gives $F=0$. Thus no nonzero affine relation holds on the effective nodes, proving the rank assertion. $\square$

**Theorem C10 (complete finite-jet reconstruction and uniqueness).**
Under the assumptions of Theorem C9, the following data determine the entire GLV realization up to common positive scale: $p,p'$ at all $D$ nodes, together with $p''$ at any $n+1$ effective nodes with full affine state rank. Such $n+1$ nodes can be selected after the first stage. Every other positive GLV realization matching these jets has the same parameters and trajectory up to (C.4).

*Proof.* Compute a nonzero kernel vector $(U,V)=c(B,C)$. By Lemma C3 the linear equations

```math
\widehat a_iU_j-\widehat a_jU_i=V_{ij} \tag{C.15}
```

have the unique solution $\widehat a=a$. At any effective node define $u=Up$ and

```math
\widehat N=\frac{u^T(q-a)}{u^Tu}. \tag{C.16}
```

Equation (C.3) gives $\widehat N=N/c$. All these values have the same nonzero sign. Reverse the sign of $(U,V)$, if necessary, so that $c>0$, and set $\widehat x=\widehat Np=x/c$. Theorem C9 supplies $n+1$ effective nodes with full rank for $[1,\widehat x^T]$.

At the selected nodes, the second-derivative data give

```math
q_i'=\frac{p_i''}{p_i}-\left(\frac{p_i'}{p_i}\right)^2
-\frac{p_n''}{p_n}+\left(\frac{p_n'}{p_n}\right)^2.
```

With $u'=Up'$, differentiating the true identity (C.16) yields the explicit formula

```math
\widehat N'
=\frac{(u')^T(q-a)+u^Tq'}{u^Tu}
-\frac{2(u^Tu')u^T(q-a)}{(u^Tu)^2}. \tag{C.17}
```

All denominators are nonzero at effective nodes. Thus the data determine

```math
\eta_i=\frac{p_i'}{p_i}+\frac{\widehat N'}{\widehat N}
=\frac{\widehat x_i'}{\widehat x_i}
=r_i+(cA)_i\widehat x. \tag{C.18}
```

The full-rank affine design identifies $r_i,(cA)_i$ uniquely for each $i$. This is an exact linear solve, not a nonlinear fit.

It remains to check uniqueness against a possibly degenerate competing realization. Its $(B^*,C^*)$ lies in the same finite kernel. This vector cannot be zero: if $B^*=0$, all observed $q(t_s)$ would be one constant vector $q_0$. But then every matrix $U$, with $V_{ij}=(q_0)_iU_j-(q_0)_jU_i$, would belong to the finite kernel. Its dimension would be at least $mn>1$, contradicting Theorem C9. Therefore the competing row-difference matrix is a nonzero scalar multiple of the recovered $U$, and (C.15) fixes the same $a$. Formulae (C.16)–(C.18), using the shared jets, then recover the same positive scale representative of the parameters and the states at every selected effective node. ODE uniqueness extends this equality, up to the common scale, over the common connected existence interval. $\square$

Theorem C10 is a theorem about finite **jets**, not about finitely many values of $p$ without derivatives. Nor does it claim that noisy numerical differentiation is well conditioned. The reconstruction below removes observation differentiation by using the whole path instead.

# 4. Integration of the lift

Fix a compact observation interval $[s_0,s_1]$ of positive length inside $I$. Since $p_i>0$ and the trajectory is smooth, $p_i$ has a positive minimum there and each $\ell_i$ has bounded variation. Every integral below against $d\ell_i$ is a Riemann–Stieltjes integral. Its definition uses function-value increments of the observed path; no pointwise observation derivative is needed to define or evaluate the integral in the exact-path limit.

For $t\in[s_0,s_1]$, define

```math
\begin{split}
\mathcal H_t(U,V)_{ij}
={}&\sum_{k=1}^n U_{jk}\int_{s_0}^t p_k\,d\ell_i
-\sum_{k=1}^n U_{ik}\int_{s_0}^t p_k\,d\ell_j\\
&-\sum_{k=1}^n V_{ij,k}\int_{s_0}^t p_k\,ds.
\end{split} \tag{C.19}
```

**Theorem C11 (integrated lift and a finite linear certificate).**
Under the hypotheses of Theorem C4, the common kernel of $\mathcal H_t$ for all $t\in[s_0,s_1]$ is exactly $\operatorname{span}\{(B,C)\}$. At most $K-1$ prefix endpoints suffice to form a stacked integral matrix of rank $K-1$.

*Proof.* For the smooth true data, the fundamental theorem of calculus for the Stieltjes integrals gives

```math
\frac{d}{dt}\mathcal H_t(U,V)_{ij}
=\mathcal L_{p,q}(U,V)_{ij}(t).
```

Thus vanishing of all prefixes is equivalent to vanishing of the pointwise operator; the initial prefixes are zero. Lemma C1 and Theorem C4 identify the common kernel as asserted.

The annihilator of the span of all scalar rows of all $\mathcal H_t$ is this one-dimensional kernel. Therefore those rows span a $K-1$-dimensional subspace of $\mathbb R^K$. Select a basis of $K-1$ such rows. The times attached to the selected rows give at most $K-1$ distinct prefix endpoints and a matrix with the stated rank. $\square$

The finite certificate in Theorem C11 consists of finitely many **path integrals**. Each such integral uses a whole prefix of the trajectory. Its finite matrix size must not be confused with a claim of exact recovery from finitely many raw abundance measurements.

# 5. A positive scale clock and a strictly convex recovery

Choose a nonzero vector $(U,V)$ in the kernel of a successful integrated matrix from Theorem C11. One may normalize its Euclidean norm to one; only its sign then remains free. By that theorem $(U,V)=c(B,C)$ for some $c\ne0$. Solve (C.15) for $a$.

There exists a compact interval $[s_*,s^*]\subset(s_0,s_1)$, with $s_* \lt s^*$, such that

```math
\|u(t)\|\ge\delta_u>0,\qquad
p_n(t)\ge\delta_p>0,
\qquad u(t)=Up(t). \tag{C.20}
```

Indeed, $Bp$ is not identically zero, and continuity supplies such an interval around a nonzero point. The second inequality follows from positivity and compactness. This interval is selected after the linear lift is recovered.

**Lemma C12 (observable clock and integrated scaled states).**
On an interval satisfying (C.20), define the signed measure

```math
d\tau(t)
=\sum_{i=1}^m\frac{u_i(t)}{\|u(t)\|^2}\,d\ell_i(t)
-\frac{u(t)^Ta}{\|u(t)\|^2}\,dt. \tag{C.21}
```

For true GLV data it has the continuous density

```math
\tau'(t)=N(t)/c. \tag{C.22}
```

Consequently its total mass on $[s_*,s^*]$ is nonzero and has constant sign. Choosing the kernel-vector sign to make that mass positive ensures $c>0$ and makes $d\tau$ a strictly positive measure. With $\tau(s_*)=0$ and

```math
J_j(t)=\int_{s_*}^t p_j(s)\,d\tau(s),\qquad
\widehat x=x/c,\quad\widehat A=cA, \tag{C.23}
```

one has $J'=\widehat x$ and $\dot{\widehat x}_i=\widehat x_i(r_i+\widehat A_i\widehat x)$.

*Proof.* By (C.3), $q-a=NBp=(N/c)u$. Using $d\ell=q\,dt$ only to verify the identity, (C.21) gives

```math
d\tau=\frac{u^T(q-a)}{\|u\|^2}\,dt=\frac Nc\,dt.
```

Since $N>0$, the density has one strict sign. Replacing $(U,V)$ by its negative leaves the solution $a$ of (C.15) unchanged and negates $u,d\tau,c$. The claimed sign choice follows. Finally, differentiating (C.23) in the proof gives $J_j'=p_jN/c=x_j/c$, and the scaled GLV equation follows by substitution. $\square$

The identity (C.22) uses the fact that the path is generated by a true GLV model. For an arbitrary path, positivity of the total mass alone would not certify positivity on every subinterval. All subsequent statements retain the true-model assumption.

Define the observed feature vector

```math
g(t)=\big(1,t-s_*,J_1(t),\ldots,J_n(t)\big)^T
\in\mathbb R^{n+2}. \tag{C.24}
```

**Lemma C13 (independence of the integrated features).**
Under the foregoing excitation hypotheses, the components of $g$ are linearly independent as functions on $[s_*,s^*]$. In particular,

```math
G=\int_{s_*}^{s^*}g(t)g(t)^T\,dt
```

is positive definite.

*Proof.* If $v^Tg(t)=0$ for all $t$, differentiation in the proof gives

```math
v_t+\sum_{j=1}^n v_{J_j}\widehat x_j(t)=0.
```

By Lemma C1 on this subinterval, no nonzero affine polynomial can vanish along $x$, and the same holds after positive constant scaling. Hence $v_t=0$ and every $v_{J_j}=0$; the original identity then gives $v_0=0$. For nonzero $v$, the continuous function $v^Tg$ is therefore nonzero on an open subinterval. Its squared integral is positive, proving the Gram assertion. $\square$

**Theorem C14 (strictly convex exact recovery without observation derivatives).**
Using only the path-integral quantities just defined, consider $F:\mathbb R^{n+2}\to\mathbb R$,

```math
F(\theta)=\int_{s_*}^{s^*}\frac{\exp(\theta^Tg(t))}{p_n(t)}\,dt
-\theta^T\int_{s_*}^{s^*}g(t)\,d\tau(t). \tag{C.25}
```

This function is finite and smooth for every finite $\theta$, its Hessian is positive definite everywhere, and it has the unique global minimizer

```math
\theta_*=\big(\log\widehat x_n(s_*),r_n,
\widehat A_{n1},\ldots,\widehat A_{nn}\big)^T. \tag{C.26}
```

Together with $a,U$, this minimizer reconstructs the full positive-scale representative by

```math
\begin{aligned}
r_i&=r_n+a_i, &\widehat A_i&=\widehat A_n+U_i \quad(i \lt n),\\
\widehat x_n(t)&=\exp(\theta_*^Tg(t)),
&\widehat x_i(t)&=\frac{p_i(t)}{p_n(t)}\exp(\theta_*^Tg(t)).
\end{aligned} \tag{C.27}
```

The state formula holds on $[s_*,s^*]$; the recovered differential equation and any one recovered state extend it uniquely to the full observed existence interval. None of the defining computations (C.19), (C.21), (C.23), (C.25), and (C.27) requires a pointwise derivative of $p$.

*Proof.* Integrating the $n$-th equation of the scaled GLV model gives

```math
\log\widehat x_n(t)
=\log\widehat x_n(s_*)+r_n(t-s_*)+\widehat A_nJ(t)
=\theta_*^Tg(t). \tag{C.28}
```

By (C.22), $p_n=\widehat x_n/\tau'$. Hence

```math
\frac{\exp(\theta_*^Tg(t))}{p_n(t)}=\tau'(t). \tag{C.29}
```

On the compact interval, $g$ is bounded and $p_n$ is bounded away from zero. Differentiation under the integral with respect to finite-dimensional $\theta$ is thus justified locally by bounded domination. We obtain

```math
\begin{split}
\nabla F(\theta)
&=\int g\,\frac{\exp(\theta^Tg)}{p_n}\,dt-\int g\,d\tau,\\
\nabla^2F(\theta)
&=\int gg^T\frac{\exp(\theta^Tg)}{p_n}\,dt.
\end{split} \tag{C.30}
```

Equation (C.29) gives $\nabla F(\theta_*)=0$. For any nonzero $v$, Lemma C13 makes $v^Tg$ nonzero on an open subinterval, and the weight $\exp(\theta^Tg)/p_n$ is strictly positive. Therefore

```math
v^T\nabla^2F(\theta)v
=\int(v^Tg)^2\frac{\exp(\theta^Tg)}{p_n}\,dt>0.
```

Thus $F$ is strictly convex on all of $\mathbb R^{n+2}$. Its existing stationary point is its unique global minimizer. Existence follows here from the true parameter vector; no additional coercivity assertion is required. Strict positivity at each point is not a parameter-uniform strong-convexity bound.

The last $n+1$ coordinates of (C.26) give $r_n,\widehat A_n$. Since $U=cB$, the row differences give (C.27), including all diagonal interactions. Equation (C.28) and the ratios $p_i/p_n$ recover the scaled positive state. Polynomial-ODE uniqueness gives the extension. Finally, all quantities defining the reconstruction are ordinary integrals, Stieltjes integrals of observed path increments, finite-dimensional linear algebra, and the strictly convex minimization (C.25); observation derivatives were used only in proofs of identities. $\square$

**Corollary C15 (an observable sufficient certificate).**
Suppose a positive smooth proportion path on $[s_0,s_1]$ is generated by at least one positive GLV realization. Assume a finite integrated matrix from (C.19) has kernel dimension one. Let its nonzero generator be $(U,V)$, assume $\operatorname{rank}U\ge2$, and recover $a$ from (C.15). Choose a nontrivial compact subinterval on which $Up\ne0$, orient the generator by the positive total mass in (C.21), and form $J,g$. If the observable Gram matrix $\int gg^Tdt$ is positive definite, then (C.25)–(C.27) recover the unique common-positive-scale class of all positive GLV realizations of the full observed path.

*Proof.* For a true realization, $(B,C)$ belongs to the kernel. It cannot be zero. Otherwise $B=0$, so $q$ is constant, and every $U_0$, with $V_{0,ij}=q_i(U_0)_j-q_j(U_0)_i$, satisfies every integrated equation; the kernel would have dimension at least $mn>1$. Hence the true $(B,C)$ is a nonzero multiple of $(U,V)$, so its row-difference rank is at least two. Lemma C3 proves consistency and uniqueness of (C.15), and the calculation in Lemma C12 gives a positive orientation and the true scaled integrals. Positive definiteness of the observed Gram matrix supplies exactly the independence used in Theorem C14. That theorem then applies without needing an externally checked hidden-state excitation condition.

Any competing positive realization satisfies the same integral equations, cannot have zero row-difference matrix for the same reason, and yields the same oriented representative, the same $a,J,g$, and a stationary point of the same strictly convex objective. Its parameter vector therefore equals the unique minimizer, and its reconstructed state agrees. ODE uniqueness completes the claim. $\square$

## Scope of the exact results

The information conditions cannot simply be dropped. For example, with $n=3$, $r=(1,1,1)$, $A=-I_3$, and $x(0)=(1,1,1)$, the row-difference matrix has rank two, but the trajectory is constant. The model $r^*=(2,2,2)$, $A^*=-2I_3$, with the same initial state, gives the same constant proportions and is not related by (C.4), because the growth vector changes. Polynomial excitation fails in this example.

The results assume observed labels, a known time scale, all species present and measured, and the exact GLV model. Hidden species, zeros of the observed proportions, taxon-dependent observation bias, or an unknown time reparameterization are separate models. The continuous-path reconstruction does not imply exact recovery from finitely many derivative-free samples. The finite-jet reconstruction expressly requires the indicated derivatives. Small lift singular gaps, small $\|Up\|$, or a nearly singular feature Gram matrix can cause severe conditioning. The exact results alone make no statistical-risk or empirical biological-performance claim.

# 6. Stability from noisy compositional samples

This section proves the complete discrete-observation error bound. Its observation errors are deterministic; no statistical sampling model is assumed.

## S1. Observation model, normalization, and conditioning

Let a positive solution of the autonomous generalized Lotka–Volterra system

```math
 \dot x_i=x_i(r_i+A_i x),\qquad i=1,\ldots,n,\quad n\geq3,
 \tag{S1.1}
```

be defined on a compact observation interval $I_0=[0,T_0]$, and let
$p_i=x_i/\sum_jx_j$. Species labels and the time coordinate are known.
Put $m=n-1$,

```math
 a_i=r_i-r_n,\quad B_i=A_i-A_n,\quad
 C^0_{ij}=a_iB_j-a_jB_i\quad (i \lt j).
```

We use the following fixed normalization of the identifiable scale orbit:

```math
 \kappa=\bigl(\|B\|_F^2+\|C^0\|_F^2\bigr)^{-1/2}>0,
 \quad U=\kappa B,\quad C=\kappa C^0,
 \quad v=(U,C),\quad\|v\|_2=1.
 \tag{S1.2}
```

The sign is chosen so that the recovered measure below has positive total
mass. Thus

```math
 \widehat x=x/\kappa,\qquad \widehat A=\kappa A.
 \tag{S1.3}
```

Growth rates $r$ are invariant under this normalization. The Frobenius
norms in (S1.2) mean the Euclidean norms of the listed real coefficients;
each unordered pair $i \lt j$ is included once.

Fix finitely many integration windows $W_\ell\subset I_0$. Their endpoints
need not coincide with observation times. For
$\ell_i=\log(p_i/p_n)$, the exact integrated matrix $M$ represents

```math
 (U,C)\longmapsto
 \left(
 \sum_kU_{jk}\int_{W_\ell}p_k\,d\ell_i
 -\sum_kU_{ik}\int_{W_\ell}p_k\,d\ell_j
 -\sum_kC_{ij,k}\int_{W_\ell}p_k\,dt
 \right)_{\ell,i \lt j}.
 \tag{S1.4}
```

Assume the exact-data conditions proved in the core section hold:

1. $\ker M=\operatorname{span}\{v\}$, and the smallest nonzero singular
   value of $M$ is $\sigma>0$.
2. The linear map
   $T_U b=(b_iU_j-b_jU_i)_{i \lt j}$ has smallest singular value
   $\chi>0$. In particular, $\operatorname{rank}U\geq2$.
3. On a positive-length compact recovery interval
   $I=[t_*,t_*+T]\subset I_0$,
   $\|Up(t)\|\geq\zeta>0$.
4. With local time $t-t_*$ renamed $t$, the exact paths

   ```math
   d\tau=\frac{Up\cdot(d\ell-a\,dt)}{\|Up\|^2},\qquad
   J_j(t)=\int_0^tp_j\,d\tau,
   \qquad g(t)=(1,t,J_1(t),\ldots,J_n(t))
   \tag{S1.5}
   ```

   satisfy
   $G=\int_0^Tg(t)g(t)^Tdt\succ0$.

These are sufficient conditions, not a classification of every degenerate
model. The core results give them under the stated generic excitation
conditions and provide directly observable exact-data rank certificates.

The observed input consists only of noisy relative-abundance samples:

```math
 0=t_0<\cdots \lt t_N=T_0,\qquad
 \alpha h\leq t_j-t_{j-1}\leq h,\qquad
 \|\widetilde p_j-p(t_j)\|\leq\varepsilon,
 \tag{S1.6}
```

where $0<\alpha\leq1$ is fixed. The vectors $\widetilde p_j$ are
positive compositions. A sufficiently small perturbation preserving the
sum of the coordinates has this property because the exact path is
strictly positive. Let $p_h$ and $\widetilde p_h$ be the polygonal
interpolants of the exact and noisy samples respectively. Only
$\widetilde p_h$ is used by the algorithm. Values at window endpoints
are its interpolated values, not additional exact observations.

Throughout the main stability theorem,

```math
 \varepsilon\leq c_0h
 \tag{S1.7}
```

for a fixed finite $c_0$. This is one sufficient way to keep the noisy
path's variation bounded. It can be replaced by an independently supplied
uniform variation bound with the corresponding changes in constants.

All constants may depend on the fixed model and intervals, the number of
windows, $n,\alpha,c_0$, a positive lower bound on $p_i$, bounds on
$p,p',p''$, and the positive margins $\sigma,\chi,\zeta$ and
$\lambda_{\min}G$. They do not depend on $h$ or $\varepsilon$.
Uniform statements hold on any compact family with the same windows and
recovery interval and with these bounds and margins uniform. The true
path, its derivatives, and the true conditioning margins enter only the
analysis of constants. They are not algorithm inputs or derivative
oracles.

## S2. A quantitative line-integral lemma

We first record the elementary estimate responsible for the noise scale.
Use Euclidean norms on the augmented path $\gamma(t)=(t,p(t))$.
For a one-form $\omega$, $\|\omega\|$ is its operator norm as a
linear functional and $\|d\omega\|$ is the operator norm of the
associated alternating bilinear form.

**Lemma S2 (ribbon estimate, including every prefix).**
Let $\gamma_0,\gamma_1:[0,T]\to\mathbb R^d$ be continuous,
piecewise $C^1$ paths. Set $\Delta=\gamma_1-\gamma_0$,
$a=\|\Delta\|_\infty$, and assume the straight homotopy
$H(t,s)=\gamma_0(t)+s\Delta(t)$ lies in an open set where
$\omega$ is $C^1$. If

```math
 L_0=\sup_H\|\omega\|,\qquad L_1=\sup_H\|d\omega\|,
```

then, for every $t\in[0,T]$,

```math
\begin{aligned}
 \left|\int_0^t\omega(d\gamma_1)-\int_0^t\omega(d\gamma_0)\right|
 &\leq L_0\bigl(\|\Delta(0)\|+\|\Delta(t)\|\bigr)\\
 &\quad+L_1a\left[\operatorname{TV}(\gamma_0;[0,t])
          +\tfrac12\operatorname{TV}(\Delta;[0,t])\right].
 \tag{S2.1}
\end{aligned}
```

In particular the same bound with endpoint term $2L_0a$ and full
variations is uniform over all prefixes.

*Proof.* Write $\omega=\sum_kf_k\,dz_k$. Differentiating
$\int f_k(H)\partial_tH_kdt$ with respect to $s$, and integrating
the term containing $\partial_t\Delta_k$ by parts, gives

```math
\begin{aligned}
 \int_0^t\omega(d\gamma_1)-\int_0^t\omega(d\gamma_0)
 &=\int_0^1[\omega_{H(u,s)}(\Delta(u))]_{u=0}^{u=t}\,ds\\
 &\quad+\int_0^1\int_0^t
   d\omega_{H(u,s)}(\Delta(u),\partial_uH(u,s))\,du\,ds.
 \tag{S2.2}
\end{aligned}
```

For polygonal paths this identity is applied on the finitely many smooth
pieces; interior endpoint terms cancel. Bound
$\|\partial_uH\|\leq\|\gamma_0'\|+s\|\Delta'\|$ and integrate
$s$ from zero to one. This proves (S2.1). No assumption that the path
endpoints agree was made. $\square$

**Corollary S3 (polygonal observations).**
Let $\gamma=(t,p(t))$, with $\|p''\|_\infty\leq B_2$,
$V=\operatorname{TV}(\gamma)$, and let the mesh and noise satisfy
(S1.6). Suppose all relevant ribbons stay in a region with the bounds
$L_0,L_1$. Put $a_h=B_2h^2/8$. Then

```math
\begin{aligned}
 \sup_t\left|\int_0^t\omega(d\widetilde\gamma_h)
                   -\int_0^t\omega(d\gamma)\right|
 \leq&\ 2L_0(a_h+\varepsilon)\\
 &+L_1\left[a_h\left(V+\tfrac12T_0B_2h\right)
       +\varepsilon\left(V+\frac{T_0\varepsilon}{\alpha h}\right)
       \right].
 \tag{S3.1}
\end{aligned}
```

Consequently the error is
$O(h^2+\varepsilon+\varepsilon^2/h)$, uniformly for every prefix
and every fixed subwindow.

*Proof.* Linear interpolation of a $C^2$ vector-valued path gives
$\|\gamma_h-\gamma\|_\infty\leq B_2h^2/8$ and
$\operatorname{TV}(\gamma_h-\gamma)\leq T_0B_2h$. The latter follows
by comparing the segment slope with the derivative at a point in the
same segment, whose distance is at most $h$.
Furthermore $\operatorname{TV}(\gamma_h)\leq V$.
The interpolated noise has supremum norm at most $\varepsilon$ and

```math
 \operatorname{TV}(\widetilde\gamma_h-\gamma_h)
 \leq\sum_{j=1}^N\|e_j-e_{j-1}\|
 \leq2N\varepsilon\leq\frac{2T_0\varepsilon}{\alpha h}.
 \tag{S3.2}
```

Apply Lemma S2 successively to $\gamma,\gamma_h$ and to
$\gamma_h,\widetilde\gamma_h$. A subwindow integral is a difference
of two prefixes, costing at most an additional factor two. $\square$

The $O(\varepsilon)$ endpoint term in (S3.1) is necessary when endpoint
observations are noisy. Small uniform noise without a variation control
does not by itself control integrals of nonexact one-forms.

**Lemma S4 (perturbing the coefficients of a one-form).**
Suppose $\omega_\eta$ is a family of one-forms and, on a fixed
neighborhood,

```math
 \|\omega_{\eta_1}-\omega_{\eta_0}\|_\infty
 \leq L_{\mathrm{par}}\|\eta_1-\eta_0\|.
```

For any continuous path $z$ of bounded variation in that neighborhood,

```math
 \sup_t\left|\int_0^t
       (\omega_{\eta_1}-\omega_{\eta_0})(dz)\right|
 \leq L_{\mathrm{par}}\|\eta_1-\eta_0\|\operatorname{TV}(z).
 \tag{S4.1}
```

*Proof.* Apply the defining bound for the Riemann–Stieltjes integral on
each piece and sum. $\square$

For our rational/logarithmic forms, $L_0,L_1,L_{\mathrm{par}}$ are obtained
by taking suprema of explicit continuous derivatives on a compact
neighborhood with $p_i\geq\rho/2$ and, for the recovery forms,
$\|Up\|\geq\zeta/2$. This gives a concrete dependence of all
constants on positivity and nonvanishing margins.

## S5. Stability of the integrated kernel and the growth contrasts

Define

```math
 \delta_0=h^2+\varepsilon+\varepsilon^2/h.
 \tag{S5.1}
```

Construct the matrix $\widetilde M$ from $\widetilde p_h$ by
(S1.4). This construction uses integrals of its known polygonal segments.
For example,

```math
 p_k\,d\ell_i=p_k\left(\frac{dp_i}{p_i}-\frac{dp_n}{p_n}\right)
```

is a smooth one-form in the positive simplex, including along a segment
where some coordinates have zero slope.

**Proposition S5.** For sufficiently small $h,\varepsilon$,

```math
 \|\widetilde M-M\|\leq C_M\delta_0.
 \tag{S5.2}
```

If $M$ has $R_M$ rows and $K$ columns, one may take
$C_M=2\sqrt{R_MK}\,C_\omega$, where $C_\omega\delta_0$ is any
common prefix bound from (S3.1) for the finitely many coefficient forms.
Let $\widetilde v=(\widetilde U,\widetilde C)$ be a unit least-right-
singular vector of $\widetilde M$, with the sign near $v$. Then

```math
 \|\widetilde v-v\|\leq C_v\delta_0,
 \qquad \|\widetilde a-a\|\leq C_a\delta_0,
 \tag{S5.3}
```

where $\widetilde a$ is the least-squares solution of
$T_{\widetilde U}b=\widetilde C$. The constants depend in particular
on $\sigma^{-1}$ and $\chi^{-1}$.

*Proof.* The matrix bound follows entry by entry from Corollary S3 and
the Frobenius bound on operator norm. Put
$e=\|\widetilde M-M\|$. Since $Mv=0$,
$\sigma_{\min}(\widetilde M)\leq e$, and therefore

```math
 \|M\widetilde v\|\leq
 \|(M-\widetilde M)\widetilde v\|
   +\|\widetilde M\widetilde v\|\leq2e.
```

Write $\widetilde v=bv+w$, where $w\perp v$, and choose its sign
so $b\geq0$. Then $\sigma\|w\|\leq2e$. For small $e$,
normalization implies $\|\widetilde v-v\|\leq\sqrt2\|w\|$, giving
the first estimate. The least singular direction is unique up to sign
when $e<\sigma/2$, because its singular value is at most $e$,
whereas the next one is at least $\sigma-e$.

The map $U\mapsto T_U$ is linear in a fixed finite dimension.
Consequently $\|T_{\widetilde U}-T_U\|\leq L_T\|\widetilde U-U\|$
for a dimension-dependent finite constant $L_T$. Its smallest singular
value remains at least $\chi/2$. Since $T_Ua=C$, the least-squares
solution satisfies

```math
 \|\widetilde a-a\|
 \leq\frac{2}{\chi}
 \left(\|\widetilde C-C\|
             +L_T\|\widetilde U-U\|\|a\|\right).
 \tag{S5.4}
```

This proves the second estimate. No claim that the noisy equations are
exactly consistent is required. $\square$

The local sign convention is implementable without knowing $v$: form
the measure for either sign and select the sign with positive total mass
on the recovery interval. Indeed $T_{-U}b=-C$ has the same solution
$a$, while the recovered measure changes sign. Its true total mass is
strictly positive, and the next proposition shows this rule persists
under small perturbations. It is unnecessary to force every noisy
increment to be positive.

## S6. Reconstructed measures, cumulative states, and moments

Use $\widetilde U,\widetilde a$ and the noisy polygon to define

```math
 d\widetilde\tau=
 \frac{\widetilde U\widetilde p_h\cdot
       (d\widetilde\ell-\widetilde a\,dt)}
      {\|\widetilde U\widetilde p_h\|^2},
 \quad
 \widetilde J_j(t)=\int_0^t\widetilde p_{h,j}\,d\widetilde\tau,
 \quad \widetilde g=(1,t,\widetilde J),
 \quad \widetilde b=\int_0^T\widetilde g\,d\widetilde\tau.
 \tag{S6.1}
```

These are ordinary Riemann–Stieltjes integrals of known piecewise smooth
paths. The resulting $\widetilde\tau$ can be signed. In contrast,
$d\tau=(\sum_i x_i/\kappa)dt$ is positive for the exact model.

**Proposition S6.** Under (S1.7), for sufficiently small $h,\varepsilon$,

```math
\begin{gathered}
 \inf_I\|\widetilde U\widetilde p_h\|\geq\zeta/2,
 \qquad \operatorname{TV}(\widetilde\tau)
             +\operatorname{TV}(\widetilde J)\leq C,\\
 \|\widetilde\tau-\tau\|_\infty
   +\|\widetilde J-J\|_\infty
   +\|\widetilde b-b\|\leq C\delta_0,
 \quad b=\int_0^Tg\,d\tau.
 \tag{S6.2}
\end{gathered}
```

*Proof.* Uniform interpolation and sample errors give
$\|\widetilde p_h-p\|_\infty\leq\varepsilon+B_2h^2/8$.
Together with Proposition S5 this preserves the denominator margin.
On the resulting compact neighborhood the form

```math
 \omega_\tau(U,a)=
 \frac{Up\cdot\left((dp_i/p_i-dp_n/p_n)_{i \lt n}-a\,dt\right)}
      {\|Up\|^2}
 \tag{S6.3}
```

and the forms $p_j\omega_\tau(U,a)$ have uniformly bounded smooth
coefficients and coefficient derivatives. Moreover

```math
 \operatorname{TV}(\widetilde\gamma_h)
 \leq V+2T_0\varepsilon/(\alpha h)
 \leq V+2T_0c_0/\alpha.
 \tag{S6.4}
```

Corollary S3 controls changing the path for the fixed exact coefficients,
and Lemma S4 controls changing $(U,a)$, with an $O(\delta_0)$
coefficient difference by Proposition S5. This proves the two uniform
cumulative bounds. The coefficient bounds and (S6.4) directly bound the
variations of $\widetilde\tau$ and $\widetilde J$.

For the moment vector, split

```math
 \widetilde b-b
 =\int_0^T(\widetilde g-g)\,d\widetilde\tau
   +\int_0^Tg\,d(\widetilde\tau-\tau).
 \tag{S6.5}
```

The first term is at most
$\|\widetilde g-g\|_\infty\operatorname{TV}(\widetilde\tau)$.
Integration by parts bounds the second by

```math
 \|\widetilde\tau-\tau\|_\infty
 \left(\|g(0)\|+\|g(T)\|+\operatorname{TV}(g)\right).
```

This proves the moment bound. Uniform convergence alone would not justify
(S6.5) for arbitrary oscillatory paths; the variation estimates supply the
required control. $\square$

## S7. A nearby minimizer exists and is the unique global minimizer

The exact and perturbed convex functions are

```math
\begin{aligned}
 F(\theta)&=\int_0^T\frac{e^{\theta\cdot g(t)}}{p_n(t)}dt
                   -\theta\cdot b,\\
 \widetilde F(\theta)&=
   \int_0^T\frac{e^{\theta\cdot\widetilde g(t)}}
                    {\widetilde p_{h,n}(t)}dt
                   -\theta\cdot\widetilde b.
 \tag{S7.1}
\end{aligned}
```

Let

```math
 \theta_*=(\log\widehat x_n(t_*),r_n,
              \widehat A_{n1},\ldots,\widehat A_{nn}).
 \tag{S7.2}
```

The exact identity
$\tau'=e^{\theta_*\cdot g}/p_n$ gives $\nabla F(\theta_*)=0$.

**Theorem S7 (stability of convex recovery).** For all sufficiently small
$h,\varepsilon$ satisfying (S1.7), the function $\widetilde F$ has
a unique global minimizer $\widetilde\theta_*\in\mathbb R^{n+2}$,
and

```math
 \|\widetilde\theta_*-\theta_*\|\leq C\delta_0.
 \tag{S7.3}
```

No known prior box for $\theta_*$ and no global strong-convexity
assumption are required for this perturbative existence statement.

*Proof.* On any fixed compact parameter ball around $\theta_*$,
Proposition S6, the positive denominator bound, and the elementary mean
value estimate for the exponential give uniform $O(\delta_0)$
differences between the two functions, their gradients, and their
Hessians. In particular

```math
 \|\nabla\widetilde F(\theta_*)\|\leq C_1\delta_0.
 \tag{S7.4}
```

For example, if $\|\theta\|\leq R$ and
$\|g\|_\infty,\|\widetilde g\|_\infty\leq G_0$, the
exponential factors and their first two parameter derivatives are bounded
by constants formed from $e^{RG_0},G_0,\rho^{-1}$ and $T$. These,
together with the constants in Proposition S6, are valid explicit
dependencies for the derivative-error bounds.

The perturbed unweighted Gram matrix
$\widetilde G=\int\widetilde g\widetilde g^Tdt$ differs from
$G$ by $O(\delta_0)$, so it is positive definite. For every fixed
finite $\theta$,

```math
 \nabla^2\widetilde F(\theta)=
 \int_0^T\frac{e^{\theta\cdot\widetilde g}}
                  {\widetilde p_{h,n}}
                  \widetilde g\widetilde g^Tdt\succ0.
 \tag{S7.5}
```

Thus $\widetilde F$ is strictly convex on all of $\mathbb R^{n+2}$.
Signed increments of $\widetilde\tau$ occur only in the linear term
and do not affect this conclusion.

Choose a fixed ball $B(\theta_*,r_0)$. On this ball (S7.5) has a
uniform lower bound $\lambda I$ for small $\delta_0$. One may
choose $\lambda$ from half the least eigenvalue of $G$, multiplied
by a lower bound for $e^{\theta\cdot\widetilde g}/\widetilde p_{h,n}$
on the ball; for example the numerator is at least
$e^{-(\|\theta_*\|+r_0)G_0}$, and the denominator has a finite upper
bound. Let $r=2C_1\delta_0/\lambda \lt r_0$. For
$w=\theta-\theta_*$ with $\|w\|=r$,

```math
 w\cdot\nabla\widetilde F(\theta)
 \geq\lambda r^2-C_1\delta_0r>0.
 \tag{S7.6}
```

The continuous function $\widetilde F$ attains a minimum on the closed
ball of radius $r$. Equation (S7.6) excludes its boundary, because
moving inward there decreases the objective. Hence there is an interior
stationary point. Global strict convexity makes it the unique global
minimizer. Finally strong monotonicity of the gradient on this ball gives

```math
 \lambda\|\widetilde\theta_*-\theta_*\|^2
 \leq-\nabla\widetilde F(\theta_*)
               \cdot(\widetilde\theta_*-\theta_*)
 \leq C_1\delta_0\|\widetilde\theta_*-\theta_*\|,
```

which proves (S7.3). $\square$

The final rows are reconstructed as
$\widetilde r_i=\widetilde r_n+\widetilde a_i$ and
$\widetilde{\widehat A}_i=
 \widetilde{\widehat A}_n+\widetilde U_i$. A positive recovered state
path can be returned without differentiating the noisy observations:

```math
 \widetilde{\widehat x}_i(t)=
 \widetilde p_{h,i}(t)
 \frac{\exp(\widetilde\theta_*\cdot\widetilde g(t))}
      {\widetilde p_{h,n}(t)}.
 \tag{S7.7}
```

Propositions S5–S6 and Theorem S7 imply

```math
 \|\widetilde r-r\|+
 \|\widetilde{\widehat A}-\widehat A\|_F+
 \|\widetilde{\widehat x}-\widehat x\|_\infty
 \leq C\delta_0.
 \tag{S7.8}
```

This is an error bound in the specified normalized scale representative.
It is not an absolute-abundance calibration theorem.

## S8. Quadrature and optimization tolerances

The integrals and minimization above define an ideal algorithm on the
observed polygon. They do not require true abundances, true derivatives,
or any exact latent quantity. The following explicit computational error
budgets allow their numerical evaluation.

Let $q_{\mathrm{num}}\geq0$ bound, in consistent fixed-dimensional norms:

- the operator error in evaluating the polygonal matrix;
- the excess residual of the chosen unit kernel vector above the least
  singular residual;
- the residual of the normal equations for the growth-contrast
  least-squares solve;
- uniform errors of the cumulative functions $\widetilde\tau$ and
  $\widetilde J$, including the total mass used to choose the sign,
  and the error in the separately evaluated moment vector
  $\widetilde b$;
- uniform gradient and Hessian quadrature errors on the fixed local
  parameter ball used in the proof.

The cumulative approximations must be continuous, or piecewise continuous
with the integrals interpreted accordingly, and the moment vector must be
computed to its stated error independently. A supremum bound on an
arbitrary oscillatory approximate cumulative path alone is not a
variation bound and must not be used to justify a Stieltjes moment.
One implementation is to evaluate the ideal polygonal cumulatives and
their moments directly to certified quadrature tolerances. Their
variation is already controlled by Proposition S6.

More precisely, if $g^{\mathrm{num}}$ and $b^{\mathrm{num}}$ are the
computed cumulative regressor and moment, the mathematical objective is

```math
 F^{\mathrm{num}}(\theta)=
 \int_0^T\frac{\exp(\theta\cdot g^{\mathrm{num}}(t))}
                    {\widetilde p_{h,n}(t)}dt
 -\theta\cdot b^{\mathrm{num}}.
 \tag{S8.1}
```

Small uniform cumulative errors preserve the positive regressor Gram
matrix, so this objective is strictly convex. Gradient and Hessian
quadrature are numerical oracles for (S8.1); they are not allowed to
replace it by an arbitrary nonconvex function. A positive-weight
quadrature objective is another option, provided its regressor Gram
matrix is certified positive definite and its local derivative errors
obey the same budget.

Let $s_{\mathrm{opt}}$ bound the gradient residual at the final parameter
iterate for (S8.1); if the computed gradient has quadrature error at that
iterate, include its certified error in $s_{\mathrm{opt}}$. The certificate
at the final iterate is needed even when it lies outside the local ball
used for the perturbation estimates.
The preceding proofs then give

```math
 \|\widetilde r-r\|+
 \|\widetilde{\widehat A}-\widehat A\|_F+
 \|\widetilde{\widehat x}-\widehat x\|_\infty
 \leq C\left(h^2+\varepsilon+\frac{\varepsilon^2}{h}
                   +q_{\mathrm{num}}+s_{\mathrm{opt}}\right).
 \tag{S8.2}
```

Here all budgets must be small enough to retain the stated margins. To
see the kernel dependence explicitly, the exact-matrix residual becomes
at most $2\|\Delta M\|+q_{\mathrm{num}}$, so the same singular-gap
argument applies. A residual $q_{\mathrm{num}}$ in the contrast normal
equations changes their solution by at most
$4q_{\mathrm{num}}/\chi^2$. Uniform cumulative and moment errors enter
the objective derivative estimates linearly.

For completeness, a small final gradient residual does not secretly
assume that the iterate is already near the unknown true parameter.
The local strong-convexity ball in Theorem S7 has fixed radius $r_0$.
Along any ray from $\theta_*$, convexity makes the radial derivative
nondecreasing. At radius $r_0$ that derivative is at least
$\lambda r_0-O(\delta_0+q_{\mathrm{num}})$. Therefore an iterate with
gradient norm below this positive number cannot lie outside the ball.
Within it, strong monotonicity gives the linear error in
$s_{\mathrm{opt}}$ stated in (S8.2). Thus the residual stopping rule is
expressed entirely in computed quantities, while true margins govern
only its theoretical small-error threshold.

There is no assertion here of an arithmetic operation bound uniform over
arbitrarily ill-conditioned instances. Segment quadrature, evaluation of
the objective, and minimization use only the supplied polygon and the
chosen accuracy budgets.

## S9. A matching deterministic noise scale

**Theorem S9 (two-point lower bound).** Fix any model in the open
well-conditioned set of S1, and consider a sufficiently small parameter
neighborhood that preserves its positivity, interval of existence, and
conditioning margins. There are constants $c,\varepsilon_0>0$ such
that, for every $0<\varepsilon<\varepsilon_0$, any estimator of the
normalized scale orbit from any fixed grid of noisy relative-abundance
observations has worst-case growth-rate error at least
$c\varepsilon$ over that neighborhood and admissible deterministic
node errors of size $\varepsilon$.

*Proof.* Perturb one growth coordinate, say
$r_i(s)=r_i(0)+s$, keeping the remaining physical coefficients and
the positive initial condition fixed. Growth coordinates are unchanged
by every common abundance scale transformation, so the two models are
separated by $|s|$ in an identifiable coordinate of the quotient.
Their normalized interaction representatives may also change, which
cannot reduce this growth-coordinate separation.

On a compact neighborhood of the base trajectory, the polynomial vector
field and its parameter derivatives are uniformly bounded and locally
Lipschitz. The integral equation for the two solutions and Grönwall's
inequality give
$\sup_{I_0}\|x_s-x_0\|\leq K|s|$. The normalization map
$x\mapsto x/\sum_jx_j$ has bounded derivative there, so for a finite
$L\geq1$,

```math
 \sup_{I_0}\|p_s-p_0\|\leq L|s|.
 \tag{S9.1}
```

The parameter neighborhood can be reduced so all the S1 margins persist
along this family. Take $s=2\varepsilon/L$ and provide the estimator
the common observations

```math
 z_j=\tfrac12\bigl(p_0(t_j)+p_s(t_j)\bigr).
```

They are positive compositions, and by (S9.1) they lie within
$\varepsilon$ of each of the two exact paths at every node. For the
same observed data a deterministic estimator returns the same growth
estimate. The triangle inequality forces error at least
$|s|/2=\varepsilon/L$ in one of the two models. A randomized estimator
has the same output law under the two models; taking expectations in the
same triangle inequality gives the identical lower bound for its
worst-case expected error. This is independent of the number and
placement of grid points. $\square$

If $h^2\leq C_0\varepsilon$, $\varepsilon\leq c_0h$, and the
numerical budgets are $O(\varepsilon)$, the upper bound (S8.2) is
$O(\varepsilon)$, matching this local deterministic noise lower bound.
For example, an asymptotic choice $h\asymp\sqrt\varepsilon$ lies in
this regime. This is noise-order optimality on a well-conditioned local
family. It is not joint optimality in $(h,\varepsilon)$, a statistical
minimax assertion, or a lower bound of order $h^2$. The $h^2$ term
is the interpolation error of this particular polygonal integration
method and is not claimed to be an information-theoretic obstruction.

## S10. Scope of the stability result

The result concerns a fixed deterministic gLV model class, positive
observations of all labelled species, known time, and explicit
conditioning margins. It makes no claim for hidden species, unknown
time reparameterizations, arbitrary model misspecification, stochastic
process noise, or a rank-degenerate trajectory. The constants may
diverge as a positivity, excitation, kernel, or convexity margin tends
to zero. Unknown constant sequencing biases are handled by the separate
gauge and calibration results; they are not silently treated as small
measurement errors here.

In particular the procedure obtains its reconstruction from noisy
relative sample values by interpolation, path integration, linear
algebra, and convex minimization. Neither $N$, $N'$, $p'$, nor
$p''$ is queried by the algorithm. Their boundedness or exact
identities appear solely in the proof of its error bound.

# 7. Unknown detection efficiencies and absolute calibration

The observation model in this section is

$$
 p_i(t)=\frac{d_i x_i(t)}{\sum_j d_jx_j(t)},\qquad d_i>0,
 \tag{P1}
$$

where the efficiencies are constant in time and unknown. Multiplicative detection bias and its overall scale ambiguity are established observation models [McLaren2019, Williamson2022]. The contribution here is the exact dynamic equivalence class and its consequences for scalar biomass calibration, after the recovery theorem has identified the observable GLV realization. No statement concerns time-varying bias, contamination, omitted species, or process noise.

## Proposition P1 (the complete positive diagonal equivalence class)

Assume that the efficiency-weighted state $z=\operatorname{diag}(d)x$ satisfies the hypotheses of the global recovery theorem. Let $(r,\widehat A,\widehat z)$ denote the normalized realization recovered from $p$, so that $\widehat z'=\operatorname{diag}(\widehat z)(r+\widehat A\widehat z)$ and $p_i=\widehat z_i/\sum_j\widehat z_j$. Then all physical realizations compatible with the complete observed path are exactly

$$
 x=\operatorname{diag}(v)\widehat z,\qquad
 A=\widehat A\operatorname{diag}(v)^{-1},\qquad
 d_i=\frac{k}{v_i},\qquad v\in(0,\infty)^n,
 \quad k>0. \tag{P2}
$$

The growth vector is the same $r$ in every realization. The scalar $k$ remains unobservable even if every physical abundance is known.

**Proof.** For a physical realization, $z_i=d_ix_i$ obeys a GLV equation with growth vector $r$ and matrix $A\operatorname{diag}(d)^{-1}$. The global theorem applies to this state and all alternative realizations. Consequently, $z=k\widehat z$ for some $k>0$, with coefficient matrix $\widehat A/k$. Set $v_i=k/d_i$. Substitution gives exactly (P2). Conversely, for any positive $v,k$, differentiating $x_i=v_i\widehat z_i$ gives

$$
 \frac{x_i'}{x_i}=r_i+\sum_j\widehat A_{ij}\widehat z_j
 =r_i+\sum_j\frac{\widehat A_{ij}}{v_j}x_j.
$$

Moreover $d_ix_i=k\widehat z_i$, so normalization gives the same $p$. This proves sufficiency as well as necessity. Multiplying every efficiency by the same positive scalar changes no normalized measurement, which proves the last assertion. Positive diagonal changes of coordinates preserve the excitation hypothesis and the rank of the row-difference matrix; thus no extra genericity assumption on a competing physical realization was used. $\square$

## Corollary P2 (what is identifiable before calibration)

The directed zero pattern and the sign of every interaction coefficient are identifiable. Within each fixed column, ratios of two nonzero entries are identifiable. The entire growth vector is identifiable. Absolute abundance, the overall interaction magnitude in each column, and the individual absolute efficiencies are not identifiable in general.

**Proof.** Every entry in column $j$ is divided by the same strictly positive $v_j$ in (P2). This preserves zeros, signs, and within-column ratios. Independent choices of $v_j$ produce the asserted ambiguities. The growth vector is unchanged by (P2). These are statements inside the specified deterministic GLV model, and are not causal assertions robust to model misspecification. $\square$

## Theorem P3 (sharp calibration rank criterion)

Suppose $m$ scalar physical measurements are available in addition to $p$:

$$
 b_\ell=w_\ell^{\mathsf T}x(t_\ell),\qquad
 w_\ell\in\mathbb R^n\text{ known},\quad 1\le\ell\le m.
$$

Define the completely determined matrix

$$
 Z_{\ell j}=w_{\ell j}\widehat z_j(t_\ell). \tag{P3}
$$

The compatible physical realizations are parametrized precisely by

$$
 \{v>0:Zv=b\}, \tag{P4}
$$

and an arbitrary common efficiency multiplier $k>0$. In particular, physical state and interaction matrix together are uniquely identified if and only if $\operatorname{rank}Z=n$. If the rank is $q \lt n$, the set (P4) has local dimension $n-q$ at the true positive vector. Consequently fewer than $n$ scalar measurements cannot identify the full physical realization. For ordinary total biomass measurements, $w_\ell=\mathbf1$, $n$ suitably chosen times suffice under the excitation hypothesis, and $n$ is sharp. Relative efficiency ratios are recovered by $d_i/d_j=v_j/v_i$; their common multiplier is not recovered.

**Proof.** Inserting (P2) into each measurement yields $Zv=b$, and no other restriction is imposed. If $Z$ has full column rank there is at most one $v$, and the true vector supplies existence. If its rank is $q \lt n$, let $v_*$ be the true vector. The affine solution set is $v_*+\ker Z$. As the positive orthant is open and $v_*>0$, a neighborhood of $v_*$ in this affine space remains positive and has dimension $n-q$. Different vectors give different strictly positive state trajectories, even in a special case where some zero interaction columns happen not to change. Thus the full physical realization is not unique.

For total biomass, the functions $\widehat z_1,\ldots,\widehat z_n$ are linearly independent by excitation. Their value vectors therefore span $\mathbb R^n$: otherwise a nonzero orthogonal vector would define a vanishing linear polynomial on the trajectory. Choose $n$ times giving a basis. The resulting $Z$ is invertible. No matrix with fewer than $n$ rows can have full column rank. The ratio formula follows from (P2). $\square$

This lower bound also covers a finite adaptive sequence of noiseless scalar measurements whose times and weights are selected from the observed path and the previously obtained scalar values. For a fixed realized sequence, all sufficiently small perturbations in the final kernel of $Z$ reproduce the same preceding values; inductively the selection rule then selects the same times and weights. Adaptation does not remove the remaining affine family. This does not count a vector-valued abundance assay as one scalar measurement.

## Corollary P4 (known relative efficiencies require one biomass value)

If the ratios $d_i/d_j$ are known, then $v$ is known up to a common positive multiplier. A single positive total biomass value determines that multiplier. In particular this applies to unbiased compositional measurements, where all efficiencies are equal. The one-calibration principle in this case was already discussed by Remien et al. [Remien2021]; the distinction here is the exact loss of that principle when all species-specific efficiencies are unknown.

**Proof.** Write $v=c v_0$ for a known positive vector $v_0$. At any time, $b=c\sum_jv_{0j}\widehat z_j>0$ determines $c$ uniquely. $\square$

## Proposition P5 (calibration perturbation)

Let $\sigma=\sigma_{\min}(Z)>0$, and suppose estimates obey $\|\widetilde Z-Z\|_2\le e_Z<\sigma$ and $\|\widetilde b-b\|_2\le e_b$. For the least-squares solution $\widetilde v=\widetilde Z^+\widetilde b$,

$$
 \|\widetilde v-v\|_2
 \le\frac{e_b+e_Z\|v\|_2}{\sigma-e_Z}. \tag{P5}
$$

On classes where $v_j\ge v_0>0$, this estimate and the recovery bound of Section 6 give corresponding local bounds for physical $x$, $A$, and all relative efficiencies. If the right side of (P5) is below $v_0/2$, the estimated vector is itself positive.

**Proof.** The least singular value of $\widetilde Z$ is at least $\sigma-e_Z$. Since it has full column rank,

$$
 \widetilde v-v
 =\widetilde Z^+(\widetilde b-\widetilde Z v),
$$

which proves (P5). The remaining maps are products and divisions by coordinates bounded away from zero. Their derivatives are bounded on the indicated compact region, so the stated perturbation estimates follow from the mean-value inequality. No uniform bound is asserted as $\sigma$ or $v_0$ approaches zero. $\square$

# 8. Scope and degeneracy

## Proposition P6 (two exact obstructions)

Neither arbitrary positive trajectories nor observation over an arbitrarily long interval guarantees identification without excitation and structural hypotheses.

1. At a fixed positive equilibrium $x_*$, every matrix $A$ paired with $r=-Ax_*$ produces the same constant composition. The ambiguity is much larger than a common scale.
2. If all rows of $A$ are equal, write $A=\mathbf1 b^{\mathsf T}$. The observed path obeys

$$
 \frac{d}{dt}\log\frac{p_i}{p_n}=r_i-r_n,
$$

independently of $b$, the initial total abundance, and a common additive change of all growth rates. These different parameter choices give the same composition on any shared interval of positive existence.

**Proof.** The first statement follows by substitution. For the second, the identical interaction rows cancel in the logarithmic ratios. For any positive initial total, the scalar equation

$$
 N'=N\left(\sum_i p_i r_i+N b^{\mathsf T}p\right)
$$

has a positive local solution. Combined with the common observed composition this supplies the corresponding GLV realization. A common additive change of $r$ also cancels from all ratios. $\square$

The rank-two condition is sufficient and generic for $n\ge3$; it is not claimed to be necessary in every exceptional model. The separate two-species argument in Appendix A uses additional algebraic information. The deterministic observation theorem controls approximation on fixed conditioned classes. It supplies neither a statistical sampling distribution nor a guarantee of stable estimation near an equilibrium, a vanishing species, a vanishing kernel gap, or a singular calibration design. It does not establish robustness to demographic or environmental process noise, hidden taxa, changing detection efficiencies, unobserved external forcing, or the correctness of GLV as a biological model.

# 9. Reproducible finite checks

The proofs above establish the general statements. Two separate computations test algebraic identities and the proposed path computation on explicit inputs. Neither is a replacement for the proofs, a proof-assistant certificate, or an evaluation on biological data. The scripts and complete result records accompany this manuscript.

## 9.1 Exact rational finite-jet example

The script `code/verify_exact.py` uses exact rational and symbolic arithmetic. Set $r=(1,3,9)$, $A=-I_3$, and $x(0)=(1/2,1,3)$. With $z=e^t$, the positive solution is

$$
 x_1=\frac{z}{z+1},\qquad
 x_2=\frac{3z^3}{z^3+2},\qquad
 x_3=\frac{9z^9}{z^9+2}.
$$

At $z=1+k/4$, $k=0,\ldots,8$, the nine nonconstant monomials of degree at most two have a nonsingular evaluation matrix. The observation lift is a $9\times9$ matrix of rank eight. All nine nodes are effective, and the first four have full affine state rank. A rational normalization $U_{11}=-2$, oriented by positive recovered total, gives $a=(-8,-6)$, $r=(1,3,9)$, and $\widehat A=-2I_3$. All state and parameter comparisons are exact. This example deliberately uses a rational scale, rather than the unit Euclidean gauge needed for the stability estimates.

The script independently constructs the observation derivatives by symbolic $z\,d/dz$ and by the quotient rule, and checks that they agree. It also verifies the two-species factor identity (C.32) and the nonzero witness $E=16$. The complete rational determinants and matrix hashes appear in `results/exact_certificate.json`. This calculation tests the finite-jet theorem, which explicitly requires derivatives. It does not test derivative-free recovery from only nine proportion values.

## 9.2 Recovery using composition values alone

The function `recover(t,p)` in `code/verify_path_recovery.py` receives only sample times and positive composition vectors. Its construction follows Sections 4–6: integrate coefficient one-forms along the observed polygon, find a least singular direction, solve the growth contrasts, construct the clock and cumulative states, and minimize a positive-weight quadrature version of the exponential objective. The implementation whitens its feature Gram matrix to improve numerical conditioning. Neither the generating parameters nor true derivatives are supplied to this function.

For an interacting three-species example we use

$$
 A=\begin{pmatrix}
 -0.12&-1.10&0.90\\
 0.90&-0.15&-1.00\\
 -1.00&0.90&-0.10
 \end{pmatrix},\quad
 r=(0.32,0.25,0.20),\quad
 x(0)=(0.25,2.00,1.20),\quad T=16.
$$

An ODE solver creates the test observations. It is outside the recovery procedure and is used again only to measure errors. The code uses eighteen approximately equal, disjoint observation windows and eight-point Gauss–Legendre quadrature on polygon segments. The noisy inputs use a fixed pseudorandom seed, zero-sum coordinate perturbations, and maximum Euclidean node error $\epsilon$. The state error in the table is the maximum Euclidean error at sampled nodes; it is not a separately certified continuum supremum.

| Mesh $h$ | Noise bound $\epsilon$ | Growth error | Scaled interaction error | Maximum state node error |
|---:|---:|---:|---:|---:|
| $0.0100$ | $0$ | $3.5536\,10^{-5}$ | $7.6407\,10^{-6}$ | $2.5001\,10^{-4}$ |
| $0.0050$ | $0$ | $8.8837\,10^{-6}$ | $1.9101\,10^{-6}$ | $6.2513\,10^{-5}$ |
| $0.0025$ | $0$ | $2.2207\,10^{-6}$ | $4.7751\,10^{-7}$ | $1.5628\,10^{-5}$ |
| $0.0100$ | $10^{-4}$ | $3.5898\,10^{-3}$ | $6.5309\,10^{-4}$ | $6.8305\,10^{-3}$ |
| $0.0050$ | $2.5\,10^{-5}$ | $5.8415\,10^{-4}$ | $1.0609\,10^{-4}$ | $1.5866\,10^{-3}$ |
| $0.0025$ | $6.25\,10^{-6}$ | $1.5731\,10^{-4}$ | $2.9473\,10^{-5}$ | $4.1033\,10^{-4}$ |

In the three noiseless runs, halving the mesh reduces the errors by approximately a factor of four, consistent with the interpolation term in the theorem. All six runs report successful numerical minimization, with whitened gradient norms below $10^{-11}$. The smallest observed proportion is about $0.0676$, the next-to-smallest lift singular value about $0.0277$, and the minimum sampled projection norm about $0.096$. These finite diagnostics indicate that this particular example is not close to those numerical degeneracies; they do not provide rigorous lower bounds for the whole path or for other models.

The quadrature and floating-point linear algebra are not interval certified. Therefore these runs do not certify the budgets $q_{\mathrm{num}},s_{\mathrm{opt}}$ of Section S8. The noisy table is a fixed numerical check, not a statistical risk estimate, a worst-case experiment, or a comparison with BEEM or iLV. The proof of the error bound and its deterministic lower bound is independent of the chosen simulation.

# 10. Interpretation and limitations

The global identifiability statement resolves the arbitrary-dimension extension of the source conjecture in the stated generic sense. The constructive contribution is a factorization of the inverse problem: a linear observation kernel determines contrasts and a scale clock, and a strictly convex exponential moment problem determines the missing common row and growth rate. The discrete theorem supplies a local conditioned guarantee for this same inverse from sample values, including a finite perturbed minimizer and the return map to parameters and states.

The mathematical result leaves several different questions open. Optimal joint dependence on mesh spacing and bounded noise is not determined. Constants and sample requirements can be unfavorable near poorly excited trajectories, and no dimension-uniform complexity bound is given. Count sampling, process noise, unmeasured species, changing efficiencies, and departures from GLV dynamics require different observation and model analyses. A future comparison with biological data or existing software would have to address those issues on its own terms.

## Source-access and verification statement

The bibliography and this statement describe the primary texts consulted and the limits of access. The Remien et al. main text was read, but its supplementary Mathematica calculations were not independently executed. BEEM's main text and eleven-page supplementary figures were read; the supplementary data workbooks and software were not fully audited. Both iLV correction notices were read; their paired PDF versions were not compared word by word. The 2025 dynamic-modeling workflow's main text was read, but its S1 supplement was unavailable. McLaren et al. was checked through accessible primary indexed passages on the mathematical bias model and calibration, while direct publisher access was restricted. The other cited claims rely on the primary material identified in the bibliography. These limitations do not constitute evidence that an unread source lacks a related result.

This manuscript is a research draft with complete written proofs and separate computational checks. It has not undergone external journal peer review. No theorem here has been verified by a proof-assistant kernel.

# Appendix A: the two-species information boundary

This appendix supplies a direct proof for two species so that the dimension statement is self-contained. Two-species identifiability up to a common positive scale was already established in [Remien, Eckwright, and Ridenhour (2021)](https://doi.org/10.1098/rsos.201378); that information conclusion is not counted as a new contribution here. The rank-two lifted reconstruction and convex recovery in Theorems C4–C15 are asserted only for $n\ge3$. The appendix does not extend that algorithm to two species.

Use the two-species GLV vector field

```math
f_1(X,Y)=X(r_1+A_{11}X+A_{12}Y),\qquad
f_2(X,Y)=Y(r_2+A_{21}X+A_{22}Y).
```

Put

```math
a=r_1-r_2,\qquad b_1=A_{11}-A_{21},\qquad b_2=A_{12}-A_{22},
```

and define the explicit polynomial

```math
E(r,A)=b_1b_2(r_1-r_2)
\big(b_1r_1A_{22}-b_2r_2A_{11}\big). \tag{C.31}
```

The trajectory excitation condition is (C.5) with $n=2$ and $d=3$, so it concerns the nine nonconstant monomials of total degree at most three.

**Lemma C16 (exclusion of an affine factor).**
Assume $E(r,A)\ne0$. For every real $v$, the polynomial

```math
L_v(X,Y)=v+b_1X+b_2Y
```

does not divide the polynomial $F=b_1f_1+b_2f_2$.

*Proof.* The definitions of $b_1,b_2$ give the exact identity

```math
F=(b_1X+b_2Y)(A_{11}X+A_{22}Y)
+b_1r_1X+b_2r_2Y. \tag{C.32}
```

Indeed, the mixed quadratic coefficients agree because
$b_1(A_{12}-A_{22})+b_2(A_{21}-A_{11})=0$.

The condition $E\ne0$ implies $b_1b_2\ne0$. If $L_v$ divided $F$, there would be an affine quotient
$c_0+c_1X+c_2Y$, since $L_v$ has degree one and $F$ has degree at most two. Comparing the $X^2$ and $Y^2$ coefficients in (C.32) forces
$c_1=A_{11}$ and $c_2=A_{22}$. Comparing the remaining coefficients gives

```math
vc_0=0,\qquad
b_1c_0+vA_{11}=b_1r_1,\qquad
b_2c_0+vA_{22}=b_2r_2. \tag{C.33}
```

If $v=0$, these equations imply $c_0=r_1=r_2$, contradicting the factor $r_1-r_2$ in (C.31). If $v\ne0$, the constant equation gives $c_0=0$, and the two linear equations imply
$b_1r_1A_{22}=b_2r_2A_{11}$, contradicting the last factor in (C.31). Both possibilities are excluded. $\square$

**Theorem C17 (two-species global identification).**
Let $x$ be a positive two-species GLV solution on a connected open interval $I$. Suppose it has polynomial excitation of degree three on $I$ and $E(r,A)\ne0$. Let $y$ be any positive two-species GLV solution with parameters $r^*,A^*$ on a connected open interval $I^*$. If the two labelled proportion paths agree on a nonempty open interval in $I\cap I^*$, then there is a unique $c>0$ such that

```math
r^*=r,\qquad A^*=cA,\qquad y(t)=x(t)/c
\quad (t\in I\cap I^*). \tag{C.34}
```

There is no genericity or excitation assumption on the competing realization.

*Proof.* Work first on an open interval $J$ of equal proportions. Positivity gives a positive smooth scalar function $h$ such that $y=h x$. Write

```math
a^*=r_1^*-r_2^*,\qquad
b^*=(A_{11}^*-A_{21}^*,A_{12}^*-A_{22}^*),\qquad v=a-a^*.
```

Equality of the logarithmic ratio derivatives gives, along the true trajectory,

```math
L(x)=hM(x),\qquad
L(X)=v+bX,\qquad M(X)=b^*X. \tag{C.35}
```

Here $X=(X,Y)^T$ in matrix expressions. Let

```math
F=b f,\quad G=b^* f,\quad
d=r_2^*-r_2,\quad R(X)=A_2X,\quad S(X)=A_2^*X.
```

The second coordinate equation of the two models gives

```math
\frac{h'}h=d-R(x)+hS(x). \tag{C.36}
```

Differentiating (C.35), multiplying by $M(x)$, and substituting (C.35)–(C.36) yields

```math
F(x)M(x)-G(x)L(x)
=(d-R(x))L(x)M(x)+L(x)^2S(x). \tag{C.37}
```

This derivation does not divide by $M(x)$, so it is valid even at its zeros. Every term of the difference between the two sides is a polynomial of degree at most three with zero constant coefficient: $f(0)=M(0)=R(0)=S(0)=0$. Excitation of degree three, transferred to $J$ by analyticity as in Lemma C1, therefore makes (C.37) an identity in the polynomial ring $\mathbb R[X,Y]$.

The polynomial $M$ is not zero. Otherwise (C.35) would make the nonzero affine polynomial $L=v+bX$ vanish along the true trajectory, contradicting affine excitation and $b_1b_2\ne0$.

Suppose $L$ and $M$ are not proportional. Two nonproportional nonconstant affine linear polynomials are relatively prime. Reducing the polynomial identity (C.37) modulo $L$ shows that $L$ divides $FM$. Euclid's lemma in $\mathbb R[X,Y]$, together with $\gcd(L,M)=1$, forces $L$ to divide $F$. Lemma C16 excludes this. Consequently $L=\gamma M$ for some nonzero real constant $\gamma$. The zero constant coefficient of $M$ gives $v=0$.

The linear polynomial $M$ cannot vanish along the whole trajectory, by excitation. There is therefore a nonempty open subinterval $J_0\subset J$ with $M(x)\ne0$. Equation (C.35) gives $h=\gamma$ on this interval. Since $h>0$, $\gamma>0$. Thus $y=\gamma x$ there, and equality of the coordinatewise logarithmic derivatives gives

```math
r_i+A_ix=r_i^*+\gamma A_i^*x,\qquad i=1,2.
```

Affine excitation on $J_0$ implies $r^*=r$ and $A^*=A/\gamma$. Set $c=1/\gamma>0$. The functions $y$ and $x/c$ solve the same polynomial differential equation and agree at any point of $J_0$, so ODE uniqueness extends their equality over the connected intersection $I\cap I^*$. Positivity of $x$ makes $c$ unique. $\square$

**Corollary C18 (generic identification for every $n\ge2$).**
For two species, the conclusion of Theorem C17 holds on a relatively Zariski-open dense subset of
$\mathbb R^2\times\mathbb R^{2\times2}\times(0,\infty)^2$, with Lebesgue-null complement. For every fixed positive initial state, it also holds for generic $r,A$. Together with Theorem C7, positive GLV models are generically globally identifiable from the full labelled proportion trajectory up to a common positive scale in every dimension $n\ge2$.

*Proof.* Lemma C6 gives a nonzero polynomial $W_3(r,A,x_0)$, including after any fixed positive $x_0$ is substituted. The polynomial $E(r,A)$ is also nonzero: at

```math
r=(1,3)^T,\qquad
A=\begin{pmatrix}1&2\\3&4\end{pmatrix}
```

its value is $16$. Hence $W_3E$ is a nonzero polynomial. Its nonvanishing ensures both hypotheses of Theorem C17. The usual empty-interior and measure-zero properties of a nonzero polynomial's zero set prove the genericity assertions, exactly as in Theorem C7. $\square$

For one species, the observed proportion is identically one for every positive trajectory, so growth and interaction parameters cannot be identified from this observation. Thus the generic information conclusion begins at two species, while the lifted linear and strictly convex reconstruction proved here begins at three species.

# References

**[Audoly2001]** S. Audoly, G. Bellu, L. D'Angiò, M. P. Saccomani, and C. Cobelli. Global identifiability of nonlinear models of biological systems. *IEEE Transactions on Biomedical Engineering* **48**(1), 55–65 (2001). DOI: [10.1109/10.900248](https://doi.org/10.1109/10.900248).

**[DiazSeoane2023]** S. Díaz-Seoane, E. Sellán, and A. F. Villaverde. Structural identifiability and observability of microbial community models. *Bioengineering* **10**(4), article 483 (2023). DOI: [10.3390/bioengineering10040483](https://doi.org/10.3390/bioengineering10040483).

**[Hong2020]** H. Hong, A. Ovchinnikov, G. Pogudin, and C. Yap. Global identifiability of differential models. *Communications on Pure and Applied Mathematics* **73**(9), 1831–1879 (2020). DOI: [10.1002/cpa.21921](https://doi.org/10.1002/cpa.21921). See also [Hong2024Erratum].

**[Hong2024Erratum]** H. Hong, A. Ovchinnikov, G. Pogudin, and C. Yap. Erratum for “Global Identifiability of Differential Models”. *Communications on Pure and Applied Mathematics* **77**(3), 2177–2179 (2024; first published online 22 September 2023). DOI: [10.1002/cpa.22163](https://doi.org/10.1002/cpa.22163).

**[Huang2025]** Y. Huang, T. Tang, X. Dai, and F. Sun. Quantifying microbial interactions based on compositional data using an iterative approach for solving generalized Lotka-Volterra equations. *PLOS Computational Biology* **21**(11), e1013691 (2025). DOI: [10.1371/journal.pcbi.1013691](https://doi.org/10.1371/journal.pcbi.1013691). See the corrections [Sun2026] and [PLOS2026Correction].

**[Li2019]** C. Li, K. R. Chng, J. S. Kwah, T. V. Av-Shalom, L. Tucker-Kellogg, and N. Nagarajan. An expectation-maximization algorithm enables accurate ecological modeling using longitudinal microbiome sequencing data. *Microbiome* **7**, article 118 (2019). DOI: [10.1186/s40168-019-0729-z](https://doi.org/10.1186/s40168-019-0729-z).

**[Loman2026]** T. E. Loman, A. P. Browning, and R. E. Baker. Structural functional identifiability of unknown differential equation observation maps. *arXiv preprint* arXiv:2611.22018v1 (17 November 2026). [Author manuscript](https://arxiv.org/pdf/2611.22018v1). No journal publication is asserted here.

**[McLaren2019]** M. R. McLaren, A. D. Willis, and B. J. Callahan. Consistent and correctable bias in metagenomic sequencing experiments. *eLife* **8**, e46923 (2019). DOI: [10.7554/eLife.46923](https://doi.org/10.7554/eLife.46923).

**[Ovchinnikov2023]** A. Ovchinnikov, G. Pogudin, and P. Thompson. Input-output equations and identifiability of linear ODE models. *IEEE Transactions on Automatic Control* **68**(2), 812–824 (2023). DOI: [10.1109/TAC.2022.3145571](https://doi.org/10.1109/TAC.2022.3145571). [Author accepted manuscript, arXiv:1910.03960v5](https://arxiv.org/html/1910.03960v5).

**[ParedesVazquez2025]** A. Paredes-Vázquez, E. Balsa-Canto, and J. R. Banga. Identification of dynamic models of microbial communities: A workflow addressing identifiability and modeling pitfalls. *PLOS Computational Biology* **21**(12), e1013204 (2025). DOI: [10.1371/journal.pcbi.1013204](https://doi.org/10.1371/journal.pcbi.1013204).

**[PLOS2026Correction]** The PLOS Computational Biology Staff. Correction: Correction: Quantifying microbial interactions based on compositional data using an iterative approach for solving generalized Lotka-Volterra equations. *PLOS Computational Biology* **22**(2), e1013971 (2026). DOI: [10.1371/journal.pcbi.1013971](https://doi.org/10.1371/journal.pcbi.1013971).

**[Remien2021]** C. H. Remien, M. J. Eckwright, and B. J. Ridenhour. Structural identifiability of the generalized Lotka–Volterra model for microbiome studies. *Royal Society Open Science* **8**(7), article 201378 (2021). DOI: [10.1098/rsos.201378](https://doi.org/10.1098/rsos.201378).

**[Semenov2024]** A. Semenov and A. Fradkov. Identification of parameters of conservative multispecies Lotka-Volterra system based on sampled data. *Mathematics* **12**(2), article 248 (2024). DOI: [10.3390/math12020248](https://doi.org/10.3390/math12020248).

**[Sun2026]** F. Sun, Y. Huang, T. Tang, and X. Dai. Correction: Quantifying microbial interactions based on compositional data using an iterative approach for solving generalized Lotka-Volterra equations. *PLOS Computational Biology* **22**(1), e1013876 (2026). DOI: [10.1371/journal.pcbi.1013876](https://doi.org/10.1371/journal.pcbi.1013876).

**[Williamson2022]** B. D. Williamson, J. P. Hughes, and A. D. Willis. A multiview model for relative and absolute microbial abundances. *Biometrics* **78**(3), 1181–1194 (2022; first published online in 2021). DOI: [10.1111/biom.13503](https://doi.org/10.1111/biom.13503).

**[ZapienCampos2024]** R. Zapién-Campos, F. Bansept, and A. Traulsen. Stochastic models allow improved inference of microbiome interactions from time series data. *PLOS Biology* **22**(11), e3002913 (2024). DOI: [10.1371/journal.pbio.3002913](https://doi.org/10.1371/journal.pbio.3002913).
