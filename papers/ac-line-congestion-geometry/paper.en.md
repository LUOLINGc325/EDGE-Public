# Exact Geometry and Uniform Recovery of Congestion Monotonicity on AC Lines

## Arbitrary path length, positive utility curvature, and explicit failure boundaries

**Research draft.** The results concern the simplified AC charging model specified below. Formal proof-assistant verification has not been completed.

## Abstract

We characterize and recover congestion monotonicity in the common resistance-to-reactance-ratio subclass of a simplified AC charging model. On the regular face where only terminal voltage is active, an explicit path Green function gives every entry of the geometric response kernel. For arbitrary path length, monotonicity over all positive utility curvatures is equivalent to $n-1$ scalar inequalities. We then prove two uniform recovery results. First, sufficiently high voltage restores monotonicity for every positive utility curvature under a bounded impedance ratio; the required voltage-deficit scale is optimal in order for fixed dimension. Second, a positive lower bound on relative utility curvature yields a voltage guarantee independent of both path length and impedance ratio, without a minimum-load assumption. In particular, a voltage floor of $0.95$ ensures strictly negative cross effects whenever relative curvature is at least $1/2$, including all positively weighted square-root utilities. Explicit three-load and four-load constructions locate the failure boundaries. The three-load uniform floor $3/4$ is sharp on the stated face. A four-load family has a unique common-alpha sign transition, with critical exponent proportional to the fourth power of the small line resistance, and supplies counterexamples above every voltage floor below nominal voltage. A supporting quadratic certifies the reference and perturbed allocations as unique global optima over the entire second-order-cone relaxation. Classical inverse-M-matrix and one-dimensional Green-function tools underlie the proofs; the results concern the AC comparative-statics structure and its quantitative recovery. They do not classify changes of active sets or the unrestricted complex AC equations.

**Keywords:** network utility maximization; electric-vehicle charging; comparative statics; distribution networks; inverse M-matrices; voltage constraints.

## 1. Introduction

An increase in the number of users need not reduce every user's service rate when network capacity is curved. On a power-distribution line, the dependence of losses and voltage drops on the operating point makes this question different from allocating a single fixed amount of power. The relevant monotonicity is componentwise: if population vector $z'$ dominates $z$, must the optimal charging rate per vehicle satisfy $p(z')\leq p(z)$?

Aveklouris's doctoral thesis states this conjecture for line networks in Section 5.6 and proves a two-load result in Section 5.12 [Ave20]. The first arXiv version of the subsequent fluid-model paper repeats the line conjecture in Section 6 [AVZ20]. The 2022 published article omits that section [AVZ22]. We therefore address the archived 2020 conjecture, rather than attribute it to the published 2022 text. The separate Lipschitz-regularity question retained in the published article is not addressed here.

We study one vehicle class at each load node and strictly inactive station and per-vehicle power caps. This is a subclass of the original allocation problem, so a counterexample within it disproves the unrestricted line conjecture. All operating points satisfy a common resistance-to-reactance ratio, strictly positive aggregate loads, and strict upper-voltage feasibility. Only the lower voltage bound at the terminal node is active. The same local face is used for both the counterexamples and the recovery theorems.

The negative answer to the unrestricted conjecture leaves a more useful structural question: which geometric or utility conditions restore the expected congestion response? Our answer separates three issues. An exact path representation determines when the geometry is monotone for every positive utility curvature. Controlling the impedance ratio gives a uniform neighborhood of nominal voltage with that property. Controlling relative utility curvature gives a different uniform neighborhood that works for every positive impedance profile and every finite path length.

The principal conclusions are as follows.

1. For an arbitrary $n$-load line, every geometric cross entry is the product of an upstream and a downstream factor, with one additional term for adjacent nodes. Thus the all-curvature property is equivalent to $n-1$ explicit scalar tests. A violated test is realized by admissible finite-at-zero weighted common-alpha utilities.
2. If $r_{\max}/r_{\min}\leq\kappa$, the explicit voltage condition $v\geq1-1/(8n^2\kappa)$ guarantees strictly negative cross effects for every positive utility curvature. A sharper bound retains the actual resistance profile. Four-load examples show that the dependence on $\kappa^{-1}$ has the correct order for fixed dimension.
3. If every relative utility curvature $\gamma_i=-p_i u_i''(p_i)/u_i'(p_i)$ is at least $\alpha>0$, the condition $\alpha>8v^2(1-v)/(2v-1)^3$ guarantees strictly negative cross effects for every finite path length and every positive impedance profile. No minimum load or load ratio is required. At $v=0.95$, the sufficient relative-curvature threshold is strictly below $1/2$.
4. The three-load voltage floor $3/4$ is sharp on the stated face. In a four-load family, the common-alpha response has one exact positive critical exponent, with $\alpha_\star\sim(2v+1)\varepsilon^4/v^3$ at fixed $v$. A joint approach to nominal voltage has $\alpha_\star/(1-v)^4\to1/432$.
5. All sensitivity statements concern actual global optima. A supporting-price quadratic controls the full SOC feasible set and persists under small population perturbations.

The sufficient dimension-free voltage bound and the fourth-power failure curve quantify different classes and are not asserted to match as sharp universal bounds. The unrestricted high-voltage counterexamples vary both the impedance profile and the allowed utility curvature. The recovery theorems state precisely what is protected when either of these sources of variation is controlled.

### 1.1. Relation to prior work

Population sensitivity in utility-maximizing networks is already developed in Reed and Zwart [RZ14, Section 3]. The source thesis itself extends the perturbation analysis to its nonpolyhedral AC capacity setting [Ave20, Section 5.11]. Thus neither differentiation of a KKT system nor its application to AC allocations is introduced here. Our exact path sign classification, uniform recovery bounds, and explicit transitions are the additional claims.

Gan, Li, Topcu, and Low [GLL15] give structural conditions for exact convex relaxation of radial optimal power flow. That problem differs from the sign of population comparative statics, although both require a global certificate. Our certificate is proved directly for the narrower source model. The stability-region comparisons of Christianen et al. [CCJ23] and the power-flow-model comparisons of Christianen, Vlasiou, and Zwart [CVZ24] concern stability scales, feasibility or aggregate performance, rather than the signs of individual population derivatives.

High-voltage power-flow monotonicity also predates the present work. Dvijotham, Mallada, and Simpson-Porco [DMS17] study high-voltage solutions and prove monotonicity of voltage with respect to reactive-power injections under their assumptions. Their parameters are prescribed injections. Our response instead differentiates optimized charging power per vehicle with respect to user populations and contains both feasible-boundary curvature and utility curvature. The inverse and Green structure of tridiagonal matrices is classical; see Meurant [Meurant92]. We use this structure to obtain the particular AC response factors in Section 7 and the uniform estimates in Sections 8--9.

The utility-maximization allocation, simplified AC constraints, and monotonicity question come from [Ave20, AVZ20, AVZ22]. The earlier stochastic resource-sharing paper [AVZ19] uses monotonicity as a hypothesis in its dynamical analysis; it does not prove the AC line conjecture. The two-load argument in [Ave20, Section 5.12] concerns one feeder and two load nodes, a single vehicle class, and a convex feasible aggregate-load set after the per-vehicle polyhedral caps are removed. We retain this counting convention throughout: the feeder is not a load node.

Sensitivity formulas for regular constrained optima follow from the implicit-function theorem. Likewise, inverse positivity of positive-definite Z-matrices and diagonal closure of inverse-M-matrix classes are established matrix theory. In particular, Johnson's Theorem 3 [Johnson82] gives a relevant nonnegative-diagonal-addition closure result. The one-dimensional Dirichlet Green formula used below is also classical; we verify it directly by its differences. We do not claim a new matrix closure theorem or a new Green function. The contributions are the exact AC path sign structure, its admissible-utility realization, the two uniform recovery mechanisms, and the explicit failure and transition results with global certificates.

## 2. Allocation model and notation

### 2.1. Populations, utilities, and monotonicity

There are $n$ load nodes. At node $i$, the population is $z_i>0$, aggregate power is $\lambda_i\geq0$, and power per vehicle is

$$
p_i=\frac{\lambda_i}{z_i}.
\tag{2.1}
$$

For a feasible aggregate-load set, the allocation maximizes

$$
F_z(\lambda)=\sum_{i=1}^n z_i u_i(\lambda_i/z_i).
\tag{2.2}
$$

Unless otherwise stated, $u_i$ is finite and continuous on $[0,\infty)$, twice continuously differentiable on $(0,\infty)$, strictly increasing, and strictly concave, with $u_i'(0+)=+\infty$. At every operating point to which a strict comparative-statics assertion is applied, we additionally assume $u_i''(p_i)<0$. Strict concavity by itself does not imply strictly negative second derivative at every point. The source model requires strictly increasing and concave utilities, with the stated positive-axis smoothness and Inada condition [AVZ20, Section 2.4]. Our stricter curvature assumptions select an admissible subclass.

Station caps $\lambda_i\leq M_i$ and per-vehicle caps $\lambda_i\leq z_i c_i^{\max}$ may be imposed. They are strictly inactive at the operating points considered here and remain so in the local neighborhoods used in the proofs. The common single-class cap can be obtained by choosing all $c_i^{\max}$ equal and sufficiently large.

The allocation is componentwise congestion-monotone on a population domain if

$$
z'\geq z\quad\Longrightarrow\quad p(z')\leq p(z).
\tag{2.3}
$$

A strictly positive derivative $\partial p_i/\partial z_j$ at a differentiable interior population point disproves (2.3): a sufficiently small increase in $z_j$ then increases $p_i$.

### 2.2. The simplified AC path

The nodes form the path $0,1,\ldots,n$, with normalized feeder-voltage magnitude $V_0=1$. Edge $i$ joins $i-1$ to $i$ and has resistance $r_i>0$ and reactance $x_i>0$. We use the simplified AC model of [AVZ20, Section 2.4], which neglects voltage-angle differences and retains quadratic line losses. It is not the unrestricted complex AC model.

Assume the ratios $r_i/x_i$ are identical. All examples below take $x_i=r_i$. In this subclass, the nodal form of the simplified AC equations is

$$
\begin{aligned}
\lambda_i
&=V_i\left(\frac{V_{i-1}-V_i}{r_i}
          -\frac{V_i-V_{i+1}}{r_{i+1}}\right),
&&1\leq i \lt n,\\
\lambda_n
&=V_n\frac{V_{n-1}-V_n}{r_n}.
\end{aligned}
\tag{2.4}
$$

Let $g_i=1/r_i$, and let $L$ be the grounded path Laplacian:

$$
L_{ii}=
\begin{cases}
g_i+g_{i+1},&i \lt n,\\
g_n,&i=n,
\end{cases}
\qquad
L_{i,i+1}=L_{i+1,i}=-g_{i+1}.
\tag{2.5}
$$

All other entries are zero. With $\mathbf1=(1,\ldots,1)^\mathsf T$, define

$$
h=L\mathbf1=(g_1,0,\ldots,0)^\mathsf T,\qquad
\tau(V)=h-LV,\qquad
\Lambda(V)=\operatorname{diag}(V)\tau(V).
\tag{2.6}
$$

Thus (2.4) is $\lambda=\Lambda(V)$. The vector $\tau$ is the nodal current-demand vector.

For completeness, the corresponding edge-matrix formulation uses $W_{00}=1$, diagonal entries $W_{ii}=V_i^2$, and edge entries $W_{i-1,i}=V_{i-1}V_i$. Equation (2.4) becomes the linear relation

$$
\begin{aligned}
\lambda_i
&=g_i(W_{i-1,i}-W_{ii})
  -g_{i+1}(W_{ii}-W_{i,i+1}),&&i \lt n,\\
\lambda_n&=g_n(W_{n-1,n}-W_{nn}).
\end{aligned}
\tag{2.7}
$$

The second-order-cone relaxation replaces the rank-one edge relations by

$$
\begin{pmatrix}
W_{i-1,i-1}&W_{i-1,i}\\
W_{i-1,i}&W_{ii}
\end{pmatrix}\succeq0.
\tag{2.8}
$$

In particular, $W_{i-1,i}\leq\sqrt{W_{i-1,i-1}W_{ii}}$. Voltage bounds are imposed on the diagonal entries. The following elimination establishes (2.7) directly for the source equations and for their SOC relaxation.

We use voltage magnitudes throughout. Thus a common magnitude floor $v$ means $W_{ii}\geq v^2$ in the squared-voltage formulation.

### Lemma 2.1. Nodal elimination of the source branch equations

Let $\kappa=x_i/r_i$ be constant along the path, and write
$\Delta W_i=W_{i-1,i-1}+W_{ii}-2W_{i-1,i}$.
The source's active and reactive edge losses are

$$
\ell_i^P=\frac{r_i}{r_i^2+x_i^2}\Delta W_i,\qquad
\ell_i^Q=\frac{x_i}{r_i^2+x_i^2}\Delta W_i.
\tag{2.9}
$$

For real charging demands $\lambda_i$, its downstream balances and voltage relation are

$$
\begin{aligned}
P_i&=\sum_{j=i}^n\lambda_j+\sum_{k=i+1}^n\ell_k^P,\qquad
Q_i=\sum_{k=i+1}^n\ell_k^Q,\\
W_{i-1,i}-W_{ii}&=r_iP_i+x_iQ_i.
\end{aligned}
\tag{2.10}
$$

These equations are equivalent, after eliminating the branch variables, to (2.7). The elimination does not require rank-one edge matrices.

**Proof.** Since $x_k=\kappa r_k$,

$$
\ell_k^P+\kappa\ell_k^Q=\frac{\Delta W_k}{r_k}.
\tag{2.11}
$$

Consequently (2.10), divided by $r_i$, becomes

$$
S_i:=\frac{W_{i-1,i}-W_{ii}}{r_i}
=\sum_{j=i}^n\lambda_j+\sum_{k=i+1}^n\frac{\Delta W_k}{r_k}.
\tag{2.12}
$$

For $i \lt n$, subtracting the equation for $S_{i+1}$ gives
$\lambda_i=S_i-S_{i+1}-\Delta W_{i+1}/r_{i+1}$.
Since
$S_{i+1}+\Delta W_{i+1}/r_{i+1}=(W_{ii}-W_{i,i+1})/r_{i+1}$,
this is (2.7); its terminal equation is $S_n=\lambda_n$. Conversely, summing the consecutive identities recovers (2.12), and the branch variables in (2.10) then satisfy the voltage relation. All steps are linear identities in the entries of $W$, so they apply to every SOC-feasible point. At a rank-one point, $\Delta W_i=(V_{i-1}-V_i)^2$; its coefficient $1/r_i$ in (2.11) represents the combined active and scaled reactive loss, not the active loss alone. $\square$

### 2.3. The regular terminal-voltage face

Our AC operating points satisfy

$$
\frac12 \lt v=V_n \lt V_{n-1}<\cdots \lt V_1<1,
\qquad
\tau(V)>0.
\tag{2.13}
$$

Every node has lower voltage bound $v$ and an upper bound at least one. Only the terminal lower bound is active. The free voltage coordinates are $(V_1,\ldots,V_{n-1})$.

For a symmetric matrix, $\succ0$ and $\succeq0$ mean positive definite and positive semidefinite. A Z-matrix has nonpositive off-diagonal entries. Every matrix norm below is the Euclidean operator norm. The vector $e_i$ is the $i$th coordinate vector. Products and inequalities between vectors without a matrix operator are componentwise.

## 3. Capacity geometry and utility curvature

This section states the local sensitivity result independently of the power model. It will then be applied using a direct AC global-support certificate.

### Theorem 3.1. Regular-boundary response formula

Let $\mathcal K\subset\mathbb R_+^n$ be compact, convex, and full dimensional. Suppose a neighborhood of $\lambda^*>0$ in $\partial\mathcal K$ is a $C^2$ embedded hypersurface with local parametrization $X:U\to\partial\mathcal K$, where $U\subset\mathbb R^{n-1}$ is open and $X(\theta^*)=\lambda^*$. Write

$$
A=DX(\theta^*),\qquad
B=-\sum_{i=1}^n q_i D^2X_i(\theta^*).
\tag{3.1}
$$

Assume $A$ has full column rank, $q>0$ is an outward supporting normal at $\lambda^*$, and $B\succ0$. Let $z^*>0$, $p_i^*=\lambda_i^*/z_i^*$, and let the utilities satisfy the conditions in Section 2.1 and

$$
u_i'(p_i^*)=q_i,\qquad
D_i=-\frac{u_i''(p_i^*)}{z_i^*}>0.
\tag{3.2}
$$

Set $D=\operatorname{diag}(D_1,\ldots,D_n)$ and

$$
K(D)=A(B+A^\mathsf TDA)^{-1}A^\mathsf T.
\tag{3.3}
$$

Then $\lambda^*$ is the unique global maximizer of (2.2) over $\mathcal K$. In a neighborhood of $z^*$, the unique global optimizer lies on the same boundary patch and is continuously differentiable in $z$. At $z^*$,

$$
\frac{\partial p_i}{\partial z_j}
=\frac{D_jp_j^*}{z_i^*}K(D)_{ij}
 -\mathbf1_{\{i=j\}}\frac{p_i^*}{z_i^*}.
\tag{3.4}
$$

In particular, $\partial p_i/\partial z_i<0$ for every $i$, and the sign of a cross effect is the sign of $K(D)_{ij}$.

**Proof.** The supporting inequality $q^\mathsf T(\lambda-\lambda^*)\leq0$ and the strictly concave tangent inequality give

$$
F_{z^*}(\lambda)-F_{z^*}(\lambda^*)
\leq q^\mathsf T(\lambda-\lambda^*)\leq0.
\tag{3.5}
$$

Strict concavity of $F_{z^*}$ makes the maximizer unique.

The first-order equation on the patch is

$$
G(\theta,z)=DX(\theta)^\mathsf T
 \left(u_i'(X_i(\theta)/z_i)\right)_{i=1}^n=0.
\tag{3.6}
$$

At the operating point, its derivative with respect to $\theta$ is

$$
D_\theta G=-B-A^\mathsf TDA\prec0.
\tag{3.7}
$$

The implicit-function theorem gives a unique $C^1$ stationary branch $\theta(z)$. At nearby points, the positive objective-gradient vector remains a normal to the boundary patch. Its orientation remains outward by continuity. On a convex body every outward normal to a differentiable boundary point is supporting. The tangent argument (3.5) therefore proves that this branch remains the unique global optimum.

At fixed $\theta$, differentiation of (3.6) with respect to $z_j$ gives $A^\mathsf T e_jD_jp_j^*$. Hence

$$
\frac{\partial\theta}{\partial z_j}
=(B+A^\mathsf TDA)^{-1}A^\mathsf T e_jD_jp_j^*.
\tag{3.8}
$$

Differentiating $p_i=X_i(\theta(z))/z_i$ proves (3.4).

Let $a_i$ denote row $i$ of $A$ and let
$M_{-i}=B+\sum_{\ell\ne i}D_\ell a_\ell^\mathsf Ta_\ell\succ0$.
If $t=a_iM_{-i}^{-1}a_i^\mathsf T\geq0$, rank-one inversion gives
$D_iK(D)_{ii}=D_it/(1+D_it)<1$. The diagonal assertion follows from (3.4). $\square$

### Lemma 3.2. Coordinate invariance and the geometric kernel

Under the geometric assumptions of Theorem 3.1, define

$$
K_0=AB^{-1}A^\mathsf T.
\tag{3.9}
$$

The matrices $K_0$ and $K(D)$ do not depend on the chosen local coordinates, provided the supporting normal $q$ is kept fixed. Moreover,

$$
K_0\succeq0,\qquad
\operatorname{rank}K_0=n-1,\qquad
\ker K_0=\operatorname{span}\{q\}.
\tag{3.10}
$$

For every positive diagonal $D$,

$$
\begin{aligned}
K(D)&=K_0(I+DK_0)^{-1}\\
&=D^{-1/2}\left[I-(I+D^{1/2}K_0D^{1/2})^{-1}\right]D^{-1/2}.
\end{aligned}
\tag{3.11}
$$

**Proof.** Under a coordinate change with invertible derivative $T$, the Jacobian becomes $AT$. The second-derivative terms containing the second derivative of the coordinate change vanish after contraction with $q$, because $q^\mathsf TA=0$. Thus $B$ becomes $T^\mathsf TBT$, proving invariance. Positive semidefiniteness, rank, and kernel follow from $B\succ0$ and the rank and normal assumptions on $A$. The two identities in (3.11) follow by multiplying by $I+DK_0$, or by the matrix inversion lemma. They require no inverse of the singular matrix $K_0$. $\square$

### Theorem 3.3. An exact criterion over all positive curvatures

Under the assumptions of Lemma 3.2, the following are equivalent.

1. For every positive diagonal $D$, every off-diagonal entry of $K(D)$ is nonpositive.
2. Every off-diagonal entry of $K_0$ is nonpositive.

If these equivalent conditions hold, every off-diagonal entry of $K(D)$ is in fact strictly negative for every positive diagonal $D$. If $(K_0)_{ij}>0$ for some $i\ne j$, then $K(\delta I)_{ij}>0$ for all sufficiently small $\delta>0$.

**Proof.** If $K_0$ is a Z-matrix, then
$I+D^{1/2}K_0D^{1/2}$ is a symmetric positive-definite Z-matrix. Its inverse is entrywise nonnegative. One direct proof writes the matrix as $sI-N$ with $N\geq0$ and $s>\rho(N)$, then expands its inverse in a convergent nonnegative Neumann series. The off-diagonal signs in (3.11) are therefore nonpositive.

The off-diagonal graph of $K_0$ is connected. Indeed, if it had two or more connected components, the restriction of $K_0q=0$ to each component would give a nonzero kernel vector supported there, contradicting (3.10). The Neumann-series argument is consequently strictly positive between all pairs. Formula (3.11) gives the strict conclusion.

Conversely, $K(\delta I)\to K_0$ as $\delta\downarrow0$. A strictly positive entry of $K_0$ remains strictly positive for small positive $\delta$. $\square$

The sign-preservation mechanism in this proof is classical inverse-M-matrix theory; see [Johnson82, Theorem 3] for the related diagonal-addition closure. The utility interpretation below is needed to turn a geometric failure into an admissible allocation counterexample. No linear utility or zero-curvature operating utility is used.

### Lemma 3.4. Realization of every positive local curvature

For any $p^*,q,z,d>0$, there is a utility satisfying Section 2.1 such that

$$
u'(p^*)=q,\qquad -u''(p^*)/z=d.
\tag{3.12}
$$

In particular, every positive diagonal curvature matrix in Theorem 3.3 is realizable while preserving the supporting prices and operating allocation.

**Proof.** Set

$$
a=\min\left\{\frac12,\frac{zdp^*}{2q}\right\},
\qquad
b=\frac{zd}{q}-\frac{a}{p^*},
\tag{3.13}
$$

and define, for $p>0$,

$$
f(p)=q\left(\frac{p^*}{p}\right)^a e^{-b(p-p^*)},
\qquad
u(p)=\int_0^p f(s)\,ds,\quad u(0)=0.
\tag{3.14}
$$

Here $0 \lt a\leq1/2$. If the second branch attains the minimum in (3.13), then $b=zd/(2q)>0$; otherwise $zdp^*/q\geq1$ and $b\geq1/(2p^*)>0$. The singularity $p^{-a}$ is integrable at zero. Thus $u$ is finite and continuous there, with $u'(0+)=+\infty$. Since
$f'(p)=-f(p)(a/p+b)<0$, the utility $u$ is strictly increasing and strictly concave and is $C^2$ on the positive axis. At $p^*$, $f(p^*)=q$ and $-f'(p^*)=q(a/p^*+b)=zd$. $\square$

### Proposition 3.5. A common fairness exponent realizes every positive geometric entry

Suppose $(K_0)_{ij}=k>0$ at a regular operating point. Write

$$
T=\operatorname{tr}K_0,\qquad
m=\max_\ell\frac{q_\ell}{\lambda_\ell^*},\qquad
\alpha=\min\left\{\frac12,\frac{k}{4mT^2}\right\}.
\tag{3.15}
$$

Then $\alpha>0$ and the weighted common-alpha utilities

$$
u_\ell(p)
=\frac{q_\ell(p_\ell^*)^\alpha}{1-\alpha}p^{1-\alpha},
\qquad p\geq0,
\tag{3.16}
$$

satisfy all conditions of Section 2.1, preserve the operating prices, and give $K(D)_{ij}\geq3k/4>0$. Hence $\partial p_i/\partial z_j>0$.

**Proof.** The induced curvature is
$D_\ell=\alpha q_\ell/\lambda_\ell^*>0$. Another form of the inversion identity is

$$
K(D)-K_0
=-K_0D^{1/2}(I+D^{1/2}K_0D^{1/2})^{-1}D^{1/2}K_0.
\tag{3.17}
$$

The central inverse has norm at most one. Since $K_0\succeq0$,

$$
\|K(D)-K_0\|
\leq\|D\|\|K_0\|^2
\leq \alpha mT^2\leq k/4.
\tag{3.18}
$$

The utilities in (3.16) have the required marginal values and are finite at zero because $0<\alpha\leq1/2<1$. Equation (3.4) proves the derivative assertion. $\square$

The exponent in (3.16) is common to all nodes; the weights generally differ. Proposition 3.5 does not assert failure for an externally prescribed exponent.

## 4. A global certificate for the simplified AC line

The hypotheses in (2.13) give the regularity and global support needed above. We prove these properties directly, including the SOC relaxation.

### Lemma 4.1. Positive supporting prices and positive curvature

Assume (2.13). Let

$$
J=D\Lambda(V)=\operatorname{diag}(\tau)-\operatorname{diag}(V)L,
\tag{4.1}
$$

and let $A$ contain the first $n-1$ columns of $J$. There is a unique positive vector $q$, normalized by $q_n=1$, and a number $\mu>0$ such that

$$
J^\mathsf Tq=-\mu e_n,\qquad A^\mathsf Tq=0.
\tag{4.2}
$$

The symmetric matrix

$$
C=\operatorname{diag}(q)L+L\operatorname{diag}(q)
\tag{4.3}
$$

is positive definite. The free-coordinate curvature in (3.1) is exactly

$$
B=C_{\{1,\ldots,n-1\},\{1,\ldots,n-1\}}\succ0.
\tag{4.4}
$$

**Proof.** The matrix $J$ is irreducible and Metzler. Using $L\mathbf1=h$ and $LV=h-\tau$ gives

$$
J(\mathbf1-V)=\tau\,(1-2V)<0.
\tag{4.5}
$$

Thus $Q=-J$ is an irreducible Z-matrix with $Q(\mathbf1-V)>0$. Positive column scaling by $\operatorname{diag}(\mathbf1-V)$ makes it strictly row diagonally dominant with positive diagonal. Its inverse is nonnegative by the convergent Neumann-series proof; irreducibility makes every entry strictly positive. Therefore $Q^{-\mathsf T}e_n>0$. Normalizing this vector to have terminal entry one proves (4.2). Invertibility of $J$ also implies that $A$ has full column rank.

Equation (4.2) yields

$$
CV=\operatorname{diag}(q)h+\mu e_n.
\tag{4.6}
$$

Let $S=\operatorname{diag}(V)C\operatorname{diag}(V)$. Its off-diagonal entries along the path are strictly negative. Its row-sum vector is
$S\mathbf1=\operatorname{diag}(V)(\operatorname{diag}(q)h+\mu e_n)$,
which is nonnegative and strictly positive at the endpoints. For every real vector $y$,

$$
y^\mathsf TSy
=\sum_{i \lt j}(-S_{ij})(y_i-y_j)^2
 +\sum_i(S\mathbf1)_iy_i^2.
\tag{4.7}
$$

Connectivity of the path and the positive endpoint row sums make this expression strictly positive for $y\ne0$. Hence $C\succ0$. Finally,
$q^\mathsf T\Lambda(U)=q^\mathsf T\operatorname{diag}(h)U-\tfrac12U^\mathsf TCU$,
so its negative Hessian in the free coordinates is (4.4). $\square$

### Theorem 4.2. Global support over the AC and SOC feasible sets

Under Lemma 4.1, for every real vector $U$ with $U_n\geq v$,

$$
q^\mathsf T[\Lambda(U)-\Lambda(V)]
=-\mu(U_n-v)-\frac12(U-V)^\mathsf TC(U-V)
\leq0,
\tag{4.8}
$$

with equality only when $U=V$. The same $q$ supports the aggregate allocation $\Lambda(V)$ over the full SOC relaxation (2.7)--(2.8) with terminal lower bound $W_{nn}\geq v^2$ and nonnegative diagonal entries.

Consequently, if the utilities have $u_i'(\Lambda_i(V)/z_i)=q_i$ and satisfy Section 2.1, then $\Lambda(V)$ is the unique global optimum over either feasible set, provided the chosen voltage and power caps make it feasible.

**Proof.** The weighted load is a quadratic polynomial with Hessian $-C$ and gradient $J^\mathsf Tq=-\mu e_n$ at $V$. Its exact Taylor formula is (4.8), and $C\succ0$ gives the equality condition.

Now take any feasible relaxed edge matrix and put $U_i=\sqrt{W_{ii}}$, with $U_0=1$. The coefficient of the feeder edge $W_{01}$ in $q^\mathsf T\lambda(W)$ is $q_1g_1>0$, and the coefficient of each internal edge $W_{i,i+1}$ is $(q_i+q_{i+1})g_{i+1}>0$. Replacing each edge entry by $U_iU_{i+1}$ can therefore only increase the weighted load. Thus

$$
q^\mathsf T\lambda(W)
\leq q^\mathsf T\Lambda(U)
\leq q^\mathsf T\Lambda(V).
\tag{4.9}
$$

The rank-one voltage point attains equality. The strictly concave utility tangent inequality proves optimality and uniqueness of its aggregate allocation. This argument controls every relaxed feasible point and requires no numerical relaxation-exactness assumption. $\square$

### Proposition 4.3. Local comparative statics remain globally valid

At any point in (2.13) with strict power-cap slack and utilities as in Theorem 4.2 with strictly positive $D_i$, the optimal allocation is $C^1$ in a neighborhood of the positive population vector. Formula (3.4) holds with

$$
K_0=AB^{-1}A^\mathsf T,\qquad
K(D)=A(B+A^\mathsf TDA)^{-1}A^\mathsf T,
\tag{4.10}
$$

where $A$ and $B$ are given by Lemma 4.1. Each nearby solution is the unique global optimum of the SOC problem and the simplified AC problem.

**Proof.** Apply the implicit-function theorem to the free-voltage stationarity equations, as in (3.6). The Jacobian is $-B-A^\mathsf TDA\prec0$. The resulting local voltage and price vectors remain positive, all nonterminal voltage bounds and power caps remain strict, and $V_n=v$. Equation (4.2), including $\mu>0$, persists: stationarity gives the first $n-1$ zero entries, while the final entry remains negative by continuity. Alternatively, Lemma 4.1 applied to the nearby voltage identifies the normal up to its positive scale. Theorem 4.2 therefore certifies every nearby point globally. Differentiating the stationarity equations gives (3.4). $\square$

This proposition also handles the population dependence of the per-vehicle caps: the branch remains feasible because those finitely many inequalities are strict at the reference point. Its global support applies to all feasible competitors whether their caps are active or inactive.

## 5. Three load nodes: complete local signs

Consider $n=3$, write $V=(s,t,u)$, and assume

$$
1>s>t>u>\frac12,\qquad \tau(V)>0.
\tag{5.1}
$$

Use $R=1/r_1$, $H=1/r_2$, and $G=1/r_3$. The free-voltage Jacobian has rows

$$
A=
\begin{pmatrix}
a&b\\c&d\\0&e
\end{pmatrix},
\tag{5.2}
$$

where

$$
\begin{aligned}
a&=(1-2s)R+(t-2s)H,& b&=sH,&c&=tH,\\
d&=(s-2t)H+(u-2t)G,&e&=uG.
\end{aligned}
\tag{5.3}
$$

Let $\Delta=ad-bc$. Lemma 4.1, or its principal M-matrix minors, gives

$$
a<0,\quad d<0,\quad b,c,e>0,\quad \Delta>0,
\qquad
q=\left(\frac{ce}{\Delta},-\frac{ae}{\Delta},1\right)^\mathsf T.
\tag{5.4}
$$

Let $B=C_{\{1,2\},\{1,2\}}$, let $a_i$ denote row $i$ of $A$, and define

$$
\beta_{ij}=a_i\operatorname{adj}(B)a_j^\mathsf T,
\qquad M=B+A^\mathsf TDA.
\tag{5.5}
$$

### Theorem 5.1. Exact three-load cross-effect classification

At every operating point satisfying (5.1), with the regularity and slack conditions of Proposition 4.3,

$$
\begin{aligned}
\det(M)K(D)_{12}&=\beta_{12}+D_3e^2ac,\\
\det(M)K(D)_{13}&=\beta_{13}-D_2ec\Delta,\\
\det(M)K(D)_{23}&=\beta_{23}+D_1ea\Delta.
\end{aligned}
\tag{5.6}
$$

All three curvature coefficients on the right are strictly negative. Therefore these formulas give necessary and sufficient local sign conditions, including equality at a threshold. In particular, positive cross effects are possible at a fixed geometry exactly for pairs with $\beta_{ij}>0$ and sufficiently small curvature at the remaining node.

**Proof.** The adjugate of a two-by-two matrix is linear in its entries, so

$$
\operatorname{adj}(M)=\operatorname{adj}(B)
 +\sum_{\ell=1}^3D_\ell\operatorname{adj}(a_\ell^\mathsf Ta_\ell).
\tag{5.7}
$$

In the bilinear expression $a_i\operatorname{adj}(M)a_j^\mathsf T$, the terms $\ell=i$ and $\ell=j$ vanish. For $\ell=3$ the remaining $(1,2)$ term is $e^2ac$. For $\ell=2$, using the orthogonal row $(d,-c)$ gives the $(1,3)$ term $-ec(ad-bc)$. For $\ell=1$, the orthogonal row $(b,-a)$ gives the $(2,3)$ term $ea(ad-bc)$. This proves (5.6); all sign assertions follow from (5.4) and $\det(M)>0$. $\square$

### Lemma 5.2. The first adjacent pair has negative geometric sign

Under (5.1), $\beta_{12}<0$.

**Proof.** Direct substitution from (5.3)--(5.5) gives $-t\beta_{12}/q_1=P_{12}$, where

$$
\begin{aligned}
P_{12}={}&2H^3(s-t)^2(2s+t)\\
&+H^2G[4su(s-t)+2t^3]\\
&+2H^2R[s^3-3s(1-s)(s-t)+(s-t)^2]\\
&+HGR[u(8s^2-4st-4s+t)+2t^2]\\
&+HR^2s(2s-1)^2+GR^2u(2s-1)^2.
\end{aligned}
\tag{5.8}
$$

We give an explicit positivity argument for the two brackets whose signs are less immediate. Put $t=1/2+x$ and $s=t+y$, with $x,y\geq0$. The bracket multiplying $2H^2R$ is

$$
x^3+6x^2y+\frac32x^2+9xy^2+3xy+\frac34x
 +4y^3+\frac52y^2+\frac18>0.
\tag{5.9}
$$

For the bracket multiplying $HGR$, write

$$
f=8s^2-4st-4s+t=(4s-1)(s-t)+4s^2-3s.
\tag{5.10}
$$

If $f\geq0$, then $uf+2t^2>0$. If $f<0$, the inequality $u\leq t$ gives

$$
uf+2t^2
\geq t\big[(4s-1)(s-t)+4s^2-3s+2t\big]>0,
\tag{5.11}
$$

because $2t\geq1$ and $4s^2-3s+1>0$ for all real $s$. All other terms in (5.8) are nonnegative, and the $H^2G$ term is strictly positive. Thus $P_{12}>0$ and $\beta_{12}<0$. $\square$

### Lemma 5.3. Remote-pair and second-adjacent-pair bounds

Under (5.1), set $\eta=R/H=r_2/r_1$. Then

$$
\frac{\beta_{13}}{e}
=\frac{q_1H^2}{t}
\left\{t(\eta+t)-[\eta(1-2s)+t-2s]^2\right\}.
\tag{5.12}
$$

If $s\geq3/4$, then $\beta_{13}<0$. Moreover,

$$
\frac{\beta_{23}}{eq_1}
=RH[4(s-t)-1]+4H^2(s-t)-2(2t-u)G(R+H),
\tag{5.13}
$$

and $\beta_{23}<0$ whenever $t\geq3/4$.

**Proof.** Identities (5.12) and (5.13) follow by inserting (5.3) and (5.4) into (5.5). To prove the first sign, let

$$
P_{13}(s,t,\eta)
=t(\eta+t)-[\eta(1-2s)+t-2s]^2.
\tag{5.14}
$$

At fixed $s,\eta$,

$$
\frac{\partial P_{13}}{\partial t}
=\eta(4s-1)+4s>0.
\tag{5.15}
$$

Using $t\leq s$ therefore gives

$$
P_{13}(s,t,\eta)
\leq \eta\big[s(3-4s)-\eta(2s-1)^2\big]<0
\quad\text{if }s\geq3/4.
\tag{5.16}
$$

For the second pair, positivity of the first current demand says
$H(s-t) \lt R(1-s)$. Substitution in (5.13) yields

$$
\frac{\beta_{23}}{eq_1}
 \lt RH(3-4t)-2(2t-u)G(R+H)<0
\quad\text{if }t\geq3/4.
\tag{5.17}
$$

Here $2t-u>0$ follows from $t>u>0$. $\square$

### Theorem 5.4. The three-load voltage guarantee

For a three-load line satisfying Proposition 4.3, if $V_2\geq3/4$ and $V_3>1/2$, then

$$
\frac{\partial p_i}{\partial z_j}<0
\qquad\text{for every }i,j\in\{1,2,3\}
\tag{5.18}
$$

for every utility family with strictly positive operating curvatures. In particular, a uniform voltage floor $v\geq3/4$ ensures (5.18) on the regular terminal-voltage face.

**Proof.** Lemmas 5.2 and 5.3 give all three strictly negative geometric numerators, because $V_1>V_2$. Equation (5.6) makes all cross numerators still smaller. The diagonal derivatives are strictly negative by Theorem 3.1 or Proposition 4.3. $\square$

This is a local derivative guarantee for the stated face. It also yields monotonicity along any componentwise nondecreasing, continuously differentiable population path whose optimizers remain on that face and satisfy the hypotheses throughout, by integrating the derivative. It does not by itself control transitions to other active sets. A condition only on $V_1$ would not establish the sign of the $(2,3)$ pair.

### Theorem 5.5. Sharpness of the uniform three-quarter threshold

For every $v\in(1/2,3/4)$, there is a three-load line with common resistance-to-reactance ratio, strictly positive loads, all voltage magnitudes at least $v$, only the terminal lower voltage bound active, and slack finite power caps, whose unique global allocation has

$$
\frac{\partial p_3}{\partial z_1}>0.
\tag{5.19}
$$

The utilities may be chosen finite at zero and weighted common-alpha with one exponent $\alpha\in(0,1/2]$.

**Proof.** For sufficiently small $\varepsilon>0$, set

$$
r=x=(1,\varepsilon,1),\qquad
V=(v+2\varepsilon^2,v+\varepsilon^2,v).
\tag{5.20}
$$

The current demands are

$$
\tau=(1-v-2\varepsilon^2-\varepsilon,\,
        \varepsilon-\varepsilon^2,\,
        \varepsilon^2)>0.
\tag{5.21}
$$

All conditions of Lemma 4.1 hold for small enough $\varepsilon$. In (5.14), substitute
$s=v+2\varepsilon^2$, $t=v+\varepsilon^2$, and $\eta=\varepsilon$. Polynomial expansion gives

$$
\lim_{\varepsilon\downarrow0}
\frac{P_{13}(v+2\varepsilon^2,v+\varepsilon^2,\varepsilon)}
{\varepsilon}
=v(3-4v)>0.
\tag{5.22}
$$

Thus $\beta_{13}>0$ and $(K_0)_{13}>0$ for small $\varepsilon$. Choose $z=\mathbf1$ and apply Proposition 3.5 to realize this entry using weighted common-alpha utilities. Theorem 4.2 and Proposition 4.3 certify global optimality and its persistence under a small population change. Symmetry of $K(D)$ gives (5.19). Finite caps can be chosen strictly above the operating powers. $\square$

Theorems 5.4 and 5.5 establish sharpness of the uniform voltage threshold within this three-load, regular-face problem. They do not assert that every geometry below $3/4$ reverses the monotone direction.

### Example 5.6. A rational counterexample with finite-at-zero utilities

Take

$$
r=x=\left(\frac14,\frac14,\frac52\right),\qquad
V=\left(\frac35,\frac7{12},\frac{13}{25}\right),\qquad
z=(1,1,1).
\tag{5.23}
$$

Use the common voltage floor $v=13/25$, upper bound one, and any station and per-vehicle caps strictly above the displayed powers. The exact vectors are

$$
\begin{aligned}
\tau&=\left(\frac{23}{15},\frac{31}{750},\frac{19}{750}\right),\\
\lambda&=\left(\frac{23}{25},\frac{217}{9000},\frac{247}{18750}\right),\\
q&=\left(\frac{390}{2129},\frac{546}{2129},1\right).
\end{aligned}
\tag{5.24}
$$

The terminal normal is

$$
(J^\mathsf Tq)_3=-\frac{196123}{1596750}<0.
\tag{5.25}
$$

The leading principal minors of the unhalved matrix $C$ in (4.3) are

$$
\frac{6240}{2129},\qquad
\frac{15964416}{4532641},\qquad
\frac{100232086656}{48249963445},
\tag{5.26}
$$

which are positive. Define

$$
\alpha=\left(\frac12,\frac1{100},\frac12\right),
\qquad
u_i(p)=\frac{q_i\lambda_i^{\alpha_i}}{1-\alpha_i}
p^{1-\alpha_i}.
\tag{5.27}
$$

These particular utilities use different exponents to keep the witness fractions compact. All are finite at zero, strictly increasing, strictly concave, and Inada. Exact rational substitution into (3.4) gives

$$
\frac{\partial p_3}{\partial z_1}
=\frac{1709054997}{1920098879500}>0.
\tag{5.28}
$$

The reproducibility script verifies (5.24)--(5.28) using rational arithmetic. This witness lies below typical near-nominal voltage ranges; the next section gives a separate construction for arbitrarily high voltage floors.

### Remark 5.7. Why two load nodes behave differently

On the corresponding regular face with two loads, $A$ is a nonzero two-by-one column and $A^\mathsf Tq=0$ with $q>0$. Its two entries have opposite signs. Since $B>0$, the only off-diagonal entry of $K_0=AB^{-1}A^\mathsf T$ is negative, and Theorem 3.3 gives strict negative cross effects for every positive curvature. This elementary local observation agrees with, but is narrower than, the two-load convex-capacity argument in [Ave20, Section 5.12].

## 6. Four load nodes: failure above every nontrivial voltage floor

### Theorem 6.1. An explicit positive geometric cross effect

Fix any $v\in(1/2,1)$ and choose

$$
0<\varepsilon\leq\frac{1-v}{6}.
\tag{6.1}
$$

Consider the four-load line

$$
r=x=(1,\varepsilon,\varepsilon,\varepsilon),
\qquad
V=(v+6\varepsilon^2,\,
    v+3\varepsilon^2,\,
    v+\varepsilon^2,\,
    v).
\tag{6.2}
$$

Its loads are strictly positive, its voltages satisfy (2.13), and its geometric kernel, normalized by $q_4=1$, satisfies

$$
(K_0)_{24}>0.
\tag{6.3}
$$

For each fixed $v$,

$$
\lim_{\varepsilon\downarrow0}
\frac{(K_0)_{24}}{\varepsilon}
=\frac{2v+1}{4}.
\tag{6.4}
$$

**Proof.** The current demands are exactly

$$
\tau=(1-v-3\varepsilon-6\varepsilon^2,\,
      \varepsilon,\varepsilon,\varepsilon).
\tag{6.5}
$$

Write $a_0=1-v\in(0,1/2)$. From (6.1),
$3\varepsilon+6\varepsilon^2\leq a_0/2+a_0^2/6<7a_0/12 \lt a_0$.
Also $6\varepsilon^2 \lt a_0$, so the first current demand is positive and $V_1<1$. All remaining conditions of (2.13) are immediate.

We prove the sign by an explicit cofactor calculation. Temporarily normalize the supporting vector by $\widetilde q_1=1$. Write
$s=V_1$, $t=V_2$, $u=V_3$, and $w=V_4=v$. The rows of $A$ are

$$
(a,b,0),\quad(c,d,e),\quad(0,f,g),\quad(0,0,h_0),
\tag{6.6}
$$

where

$$
\begin{aligned}
a&=(1-2s)+(t-2s)/\varepsilon,&b&=s/\varepsilon,\\
c&=t/\varepsilon,&d&=(s+u-4t)/\varepsilon,&e&=t/\varepsilon,\\
f&=u/\varepsilon,&g&=(t+w-4u)/\varepsilon,&h_0&=w/\varepsilon.
\end{aligned}
\tag{6.7}
$$

The equations $A^\mathsf T\widetilde q=0$ recursively give

$$
\widetilde q_2=-a/c,\qquad
\widetilde q_3=-(b+d\widetilde q_2)/f,\qquad
\widetilde q_4=-(e\widetilde q_2+g\widetilde q_3)/h_0.
\tag{6.8}
$$

All prices are positive by Lemma 4.1. Let $\widetilde B$ be the free principal block of the curvature matrix formed with $\widetilde q$. Its diagonal and off-diagonal entries are

$$
\widetilde B=
\begin{pmatrix}
A_0&B_0&0\\
B_0&C_0&D_0\\
0&D_0&E_0
\end{pmatrix},
\quad
\begin{array}{lll}
A_0=2(1+1/\varepsilon),&
B_0=-(1+\widetilde q_2)/\varepsilon,&
C_0=4\widetilde q_2/\varepsilon,\\
D_0=-(\widetilde q_2+\widetilde q_3)/\varepsilon,&
E_0=4\widetilde q_3/\varepsilon.&
\end{array}
\tag{6.9}
$$

Only one column of its adjugate is needed:

$$
[A\operatorname{adj}(\widetilde B)A^\mathsf T]_{24}
=h_0\{D_0(cB_0-dA_0)+e(A_0C_0-B_0^2)\}.
\tag{6.10}
$$

Substituting (6.2), (6.7), and (6.8), and collecting powers of $\varepsilon$, gives the identity

$$
D_0(cB_0-dA_0)+e(A_0C_0-B_0^2)
=\frac{P(\varepsilon,v)}
{\varepsilon(\varepsilon^2+v)(3\varepsilon^2+v)},
\tag{6.11}
$$

where the complete polynomial is

$$
\begin{aligned}
P(\varepsilon,v)={}&4v^2+2v\\
&+\varepsilon(32v^2-22v)\\
&+\varepsilon^2(24v^2+50v+5)\\
&+\varepsilon^3(288v-48)\\
&+\varepsilon^4(192v+60)
 +432\varepsilon^5+288\varepsilon^6.
\end{aligned}
\tag{6.12}
$$

Equation (6.11) is a rational identity that can be checked by multiplying its positive denominators and expanding. Its sign is elementary: for $1/2 \lt v<1$, the constant coefficient is greater than two, the linear coefficient is at least $-3$, and every coefficient of degree at least two is positive. Since $\varepsilon<1/12$,

$$
P(\varepsilon,v)>2-3\varepsilon>0.
\tag{6.13}
$$

The denominator in (6.11), $h_0$, and $\det\widetilde B$ are positive. Thus the $(2,4)$ entry of $A\widetilde B^{-1}A^\mathsf T$ is positive. Changing normalization from $\widetilde q_1=1$ to $q_4=1$ divides $\widetilde B$ by $\widetilde q_4$ and multiplies the kernel by the positive number $\widetilde q_4$. This proves (6.3).

For the asymptotic, (6.8) gives $\widetilde q_i\to1$ as $\varepsilon\downarrow0$. If $N$ denotes the right side of (6.11), then

$$
\varepsilon N\longrightarrow\frac{4v^2+2v}{v^2},
\qquad
\varepsilon h_0\longrightarrow v,
\qquad
\widetilde q_4\longrightarrow1.
\tag{6.14}
$$

Moreover,

$$
\varepsilon\widetilde B\longrightarrow
2\begin{pmatrix}
1&-1&0\\-1&2&-1\\0&-1&2
\end{pmatrix},
\qquad
\varepsilon^3\det\widetilde B\longrightarrow8.
\tag{6.15}
$$

Combining (6.10), (6.14), and (6.15), with the normalization factor, gives
$v(4v^2+2v)/(8v^2)=(2v+1)/4$, proving (6.4). $\square$

### Theorem 6.2. Globally optimal common-alpha counterexamples at arbitrarily high voltage

For every prescribed magnitude floor $\bar v<1$, there is a four-load simplified AC line with every operating voltage strictly above $\bar v$, common resistance-to-reactance ratio, positive loads, and slack finite station and per-vehicle power caps, together with weighted common-alpha utilities finite at zero, such that the optimal rates at $z=\mathbf1$ satisfy

$$
\frac{\partial p_4}{\partial z_2}>0.
\tag{6.16}
$$

The reference allocation and all sufficiently nearby perturbed allocations are unique global optima of both the simplified AC problem and its SOC relaxation.

**Proof.** Choose $v\in(\max\{\bar v,1/2\},1)$ and any $\varepsilon$ satisfying (6.1). Theorem 6.1 gives $(K_0)_{24}>0$. Normalize $q_4=1$, set $z=\mathbf1$, and choose the common exponent by (3.15). Use the weighted common-alpha utilities (3.16), with $p_i^*=\Lambda_i(V)$. Proposition 3.5 gives a strictly positive kernel entry. Equation (3.4), symmetry, and positivity of all factors give (6.16). The global assertions follow from Theorem 4.2 and Proposition 4.3. Choose finite caps strictly above the operating powers; these inequalities remain strict in a sufficiently small neighborhood. $\square$

It follows that no voltage floor strictly below feeder voltage guarantees the archived line monotonicity statement uniformly over all admissible utilities and line impedances. The use of four load nodes is substantive: it contrasts with the three-load guarantee of Theorem 5.4.

### Proposition 6.3. A simple asymptotic choice of the common exponent

Fix $v\in(1/2,1)$ and use the family (6.2), normalized by $q_4=1$, at $z=\mathbf1$. Set $\alpha=\varepsilon^5$ in (3.16). For all sufficiently small positive $\varepsilon$,

$$
K(D)_{24}>0,
\qquad
\lim_{\varepsilon\downarrow0}
\frac{K(D)_{24}}{\varepsilon}
=\frac{2v+1}{4},
\tag{6.17}
$$

and

$$
\lim_{\varepsilon\downarrow0}
\frac{\partial p_4/\partial z_2}{\varepsilon^6}
=\frac{2v+1}{4}.
\tag{6.18}
$$

**Proof.** By (6.5), $\lambda_1\to v(1-v)>0$ and $\lambda_i/\varepsilon\to v$ for $i=2,3,4$. The normalized prices tend to one. Thus
$m=\max_i(q_i/\lambda_i)=O(\varepsilon^{-1})$ and
$\|D\|=\alpha m=O(\varepsilon^4)$.
Equation (6.15) and the scaling $A=O(\varepsilon^{-1})$ give
$\operatorname{tr}K_0=O(\varepsilon^{-1})$.
The perturbation bound (3.18) therefore gives
$\|K(D)-K_0\|=O(\varepsilon^2)$.
Theorem 6.1 proves (6.17). Finally, at $z=\mathbf1$,

$$
\frac{\partial p_4}{\partial z_2}
=D_2\lambda_2K(D)_{42}
=\alpha q_2K(D)_{24},
\tag{6.19}
$$

which proves (6.18). $\square$

The asymptotic choice $\alpha=\varepsilon^5$ is asserted for sufficiently small $\varepsilon$ at fixed $v$. The quantitative choice (3.15) works at every parameter pair in Theorem 6.1. The small magnitude in (6.18) matters for interpretation: the result refutes a universal qualitative sign claim and does not assert a large operational effect.

### Example 6.4. An exact near-nominal witness

Take $v=999/1000$, $\varepsilon=1/10000$, and $\alpha=\varepsilon^5=10^{-20}$. For this reproducibility example only, normalize $q_1=1$, as in the exact certificate. Multiplying all prices by a common positive factor scales $K(D)$ inversely and leaves the allocation derivative unchanged. These values satisfy (6.1). Every voltage magnitude exceeds $0.999$ except the terminal voltage, which equals $0.999$. The exact verification script checks positive current demands, positive supporting prices and terminal multiplier, positive leading principal minors of $C$, and the positive rational sign of $\partial p_4/\partial z_2$. For readability only, the resulting values are approximately

$$
K(D)_{24}=0.000074915027156572,\qquad
\frac{\partial p_4}{\partial z_2}
=7.4922515660\times10^{-25}.
\tag{6.20}
$$

The full rational fraction is stored in the accompanying certificate. The proof of Theorem 6.2 is analytic and does not depend on this particular sample.

### Theorem 6.5. An exact common-alpha sign transition

Use the four-load family (6.2) with (6.1), and normalize $q_1=1$ throughout this theorem. Retain the coefficients in (6.7) and (6.9), and write $\lambda_i=\Lambda_i(V)$. For weighted common-alpha utilities at $z=\mathbf1$, let $D_i=\alpha q_i/\lambda_i$ and $M=B+A^\mathsf TDA$. Define

$$
\begin{aligned}
N_0&=D_0(cB_0-dA_0)+e(A_0C_0-B_0^2),\\
F_1&=D_0(cab-da^2)+e(A_0b^2+C_0a^2-2B_0ab),\\
F_3&=fg(cB_0-dA_0)+eA_0f^2,\\
F_{13}&=fg(cab-da^2)+ea^2f^2,\\
N_1&=F_1/\lambda_1+F_3q_3/\lambda_3,\qquad
N_2=F_{13}q_3/(\lambda_1\lambda_3).
\end{aligned}
\tag{6.21}
$$

Then

$$
\frac{\det(M)}{h_0}K(D)_{24}
=N(\alpha):=N_0+N_1\alpha+N_2\alpha^2,
\qquad N_0>0,\quad N_2<0.
\tag{6.22}
$$

There is exactly one positive critical exponent,

$$
\alpha_\star
=\frac{2N_0}{\sqrt{N_1^2-4N_0N_2}-N_1}>0.
\tag{6.23}
$$

For every algebraic parameter $\alpha>0$, the kernel entry $K(D)_{24}$ is positive below $\alpha_\star$, zero at it, and negative above it. For actual finite-at-zero isoelastic utilities, the same sign classification applies to $\partial p_4/\partial z_2$ on the admissible interval $0<\alpha<1$. A zero-derivative instance in this utility class is asserted only when $\alpha_\star<1$.

**Proof.** A rank-one curvature addition at either queried row leaves the cross numerator unchanged. Indeed, replacing $M$ by $M+d a_i^\mathsf Ta_i$ multiplies its determinant by $1+dK_{ii}$ and divides $K_{ij}$ by the same factor. The factors cancel. Thus the numerator for pair $(2,4)$ is independent of $D_2,D_4$ and can be computed using only $D_1,D_3$.

The resulting tridiagonal free Hessian has entries

$$
\begin{aligned}
A'&=A_0+D_1a^2,& B'&=B_0+D_1ab,\\
C'&=C_0+D_1b^2+D_3f^2,&
D'&=D_0+D_3fg.
\end{aligned}
\tag{6.24}
$$

Substitute these into the cofactor formula (6.10). The $D_1^2$ term cancels, and collecting the remaining terms gives (6.21)--(6.22), since $D_1=\alpha/\lambda_1$.

The positive constant $N_0$ is (6.11). The quadratic coefficient has the factorization

$$
F_{13}=-af\det
\begin{pmatrix}
a&b&0\\c&d&e\\0&f&g
\end{pmatrix}<0.
\tag{6.25}
$$

Here $a<0$, $f>0$, and the displayed determinant is negative: it is the leading three-by-three principal minor of $J$, whereas the corresponding principal minor of the nonsingular M-matrix $-J$ is positive. Hence $N_2<0$. The two roots of the quadratic have opposite signs, and rationalizing its positive root gives (6.23). Positivity of $h_0$, $\det(M)$, and the response prefactor in (3.4) proves the sign classification. The same supporting prices certify the operating point for every such $\alpha$. $\square$

### Proposition 6.6. The fourth-power transition scale

For fixed $v\in(1/2,1)$,

$$
\lim_{\varepsilon\downarrow0}
\frac{\alpha_\star}{\varepsilon^4}
=\frac{2v+1}{v^3}.
\tag{6.26}
$$

For any fixed $\theta>0$, set $\alpha=\theta\varepsilon^4$. Then, with either $q_1=1$ or $q_4=1$ for the kernel,

$$
\begin{aligned}
\lim_{\varepsilon\downarrow0}\frac{K(D)_{24}}{\varepsilon}
&=\frac{2v+1-v^3\theta}{4},\\
\lim_{\varepsilon\downarrow0}
\frac{\partial p_4/\partial z_2}{\varepsilon^5}
&=\frac{\theta(2v+1-v^3\theta)}4.
\end{aligned}
\tag{6.27}
$$

**Proof.** The recursive prices tend to one. Direct leading terms of the short formulas in (6.21) give

$$
\varepsilon N_0\longrightarrow\frac{2(2v+1)}v,\qquad
\varepsilon^5N_1\longrightarrow-2v^2,\qquad
\varepsilon^6N_2\longrightarrow-\frac{v^3}{1-v}.
\tag{6.28}
$$

We detail the potentially sensitive orders. Each term of $F_1$ is $O(\varepsilon^{-4})$, so $\varepsilon^5F_1\to0$, while $\lambda_1\to v(1-v)>0$. The leading terms in $F_3$ give
$\varepsilon^4F_3\to-2v^3$, and $\lambda_3/\varepsilon\to v$. Finally, (6.25) gives $\varepsilon^5F_{13}\to-v^5$. These observations establish (6.28) without expanding a large polynomial.

For $\alpha=\theta\varepsilon^4$,

$$
\varepsilon N(\alpha)\longrightarrow
\frac{2(2v+1)}v-2v^2\theta.
\tag{6.29}
$$

Testing fixed $\theta$ on both sides of the unique zero of this linear expression, and using the unique positive root in Theorem 6.5, proves (6.26).

For this scaling, $D=O(\varepsilon^3)$ and $A=O(\varepsilon^{-1})$, so $\varepsilon M$ has the same limit as $\varepsilon B$ in (6.15). Thus $\varepsilon^3\det(M)\to8$. Combining this with $\varepsilon h_0\to v$ and (6.29) proves the first limit in (6.27). The price-normalization factor tends to one. The second limit follows from $\partial p_4/\partial z_2=\alpha q_2K(D)_{24}$. $\square$

At $\theta=(2v+1)/v^3$, the leading term in (6.27) vanishes; the exact quadratic, rather than this first-order limit, determines the sign. The leading positive derivative coefficient is largest at $\theta=(2v+1)/(2v^3)$ and equals $(2v+1)^2/(16v^3)$.

### Corollary 6.7. A joint approach to nominal voltage

Set $v=1-6\varepsilon$ and let $\varepsilon\downarrow0$. Then the family remains admissible and

$$
\frac{\alpha_\star}{\varepsilon^4}\longrightarrow3,\qquad
\frac{\alpha_\star}{(1-v)^4}\longrightarrow\frac1{432}.
\tag{6.30}
$$

For $\alpha=\theta\varepsilon^4$,

$$
\frac{K(D)_{24}}{\varepsilon}\longrightarrow\frac{3-\theta}{4},
\qquad
\frac{\partial p_4/\partial z_2}{\varepsilon^5}
\longrightarrow\frac{\theta(3-\theta)}4.
\tag{6.31}
$$

**Proof.** Substitute $v=1-6\varepsilon$ into the exact formulas (6.21). Here $\lambda_1/\varepsilon\to3$ and $\lambda_i/\varepsilon\to1$ for $i=2,3,4$. The corresponding coefficient limits are

$$
\varepsilon N_0\to6,\qquad
\varepsilon^5N_1\to-2,\qquad
\varepsilon^7N_2\to-\frac13.
\tag{6.32}
$$

For the middle limit, the apparent contribution from $F_1/\lambda_1$ still vanishes: its fourth-order leading terms cancel, so $F_1=O(\varepsilon^{-3})$ uniformly along this substitution. This follows directly from (6.21); the two fourth-order contributions are $-2v^3$ and $2v^3$. The remaining term has the limit already used in (6.28). The quadratic contribution to $\varepsilon N(\theta\varepsilon^4)$ now has order $\varepsilon^2$ and still vanishes. Thus its limit is $6-2\theta$. The root argument and determinant scaling from Proposition 6.6 give (6.30)--(6.31). Since $(1-v)^4=6^4\varepsilon^4$, the second limit in (6.30) is $3/6^4=1/432$. $\square$

The fourth-power transition is exact for this family. It is not asserted to be the sharp voltage-curvature boundary over every path and impedance profile.

## 7. Exact geometric signs for an arbitrary path length

The three-load calculations suggest that capacity geometry, rather than voltage alone, determines the range of monotonicity. We now give a complete geometric classification for every $n\geq2$. Throughout Sections 7--9, assume the regular-face hypotheses (2.13), normalize $q_n=1$, and use $J,A,C,B,K_0$ from Section 4.

### Lemma 7.1. Supporting prices increase along the path

Put

$$
\mathcal S=L-\operatorname{diag}(\tau_i/V_i),\qquad
\mathcal H=\mathcal S^{-1},\qquad
y=\operatorname{diag}(V)q.
\tag{7.1}
$$

Then $\mathcal S$ is a symmetric positive-definite Z-matrix,
$\mathcal Sy=\mu e_n$, and, with $q_0=y_0=0$,

$$
0=q_0 \lt q_1<\cdots \lt q_n=1,\qquad
q_i-q_{i-1}\geq\mu r_i.
\tag{7.2}
$$

**Proof.** Since $-J=\operatorname{diag}(V)\mathcal S$ and $-J$ has a positive-vector M-matrix certificate in Lemma 4.1, the symmetric Z-matrix $\mathcal S$ has a positive vector whose image is positive. Positive diagonal scaling and the energy argument imply $\mathcal S\succ0$. The supporting-normal equation gives $\mathcal Sy=\mu e_n$, hence
$Ly=\operatorname{diag}(\tau_i/V_i)y+\mu e_n$.
Summing this path balance from node $i$ to the terminal node yields

$$
\frac{y_i-y_{i-1}}{r_i}
=\mu+\sum_{j=i}^n\frac{\tau_j}{V_j}y_j>\mu.
\tag{7.3}
$$

Thus $y_i$ strictly increases. Because $V_i$ strictly decreases and is at most one, $q_i=y_i/V_i$ strictly increases and its increment is at least $\mu r_i$. $\square$

The value $q_0=0$ is an auxiliary endpoint convention, not a feeder utility price. Define transformed edge resistances and their cumulative sums by

$$
\rho_i=\frac{r_i}{(q_{i-1}+q_i)V_{i-1}V_i},\qquad
T_i=\sum_{k=1}^i\rho_k,\qquad T_0=0,\qquad T=T_n.
\tag{7.4}
$$

Also define

$$
\begin{aligned}
b_i&=\frac1{q_{i-1}+q_i}-\frac1{q_i+q_{i+1}}>0,
&&i \lt n,\\
b_n&=\frac1{q_{n-1}+q_n}>0,\\
\ell_i&=2\lambda_iT_i-b_i,&&i \lt n,\\
\zeta_j&=2\lambda_j(T-T_j)+b_j,&&j \lt n,\qquad
\zeta_n=b_n.
\end{aligned}
\tag{7.5}
$$

Every downstream factor $\zeta_j$ is strictly positive.

### Lemma 7.2. The transformed curvature Green function

Let $D_V=\operatorname{diag}(V_1,\ldots,V_{n-1})$. Then $D_VBD_V$ is the path Laplacian on the free nodes with Dirichlet endpoints $0,n$ and edge conductances $1/\rho_i$. Consequently,

$$
(B^{-1})_{ij}
=V_iV_j\frac{T_{\min(i,j)}(T-T_{\max(i,j)})}{T},
\qquad 1\leq i,j \lt n.
\tag{7.6}
$$

**Proof.** Its off-diagonal entries are
$-(q_i+q_{i+1})V_iV_{i+1}/r_{i+1}=-1/\rho_{i+1}$.
The identity $CV=\operatorname{diag}(q)h+\mu e_n$ shows that the diagonal at each free interior node is the sum of the two incident transformed conductances. At the first node, the omitted root contribution is $q_1V_1/r_1=1/\rho_1$; at the last free node, the omitted terminal contribution is $(q_{n-1}+q_n)V_{n-1}V_n/r_n=1/\rho_n$. This proves the Laplacian representation, also when there is only one free node.

The classical one-dimensional Dirichlet Green function is
$T_{\min(i,j)}(T-T_{\max(i,j)})/T$.
To verify it directly, fix $j$. On either side of $j$, its first difference divided by $\rho_i$ is constant. Its endpoint values are zero, and the drop in that constant across $j$ is one. Applying the Dirichlet Laplacian therefore gives $e_j$. Multiplication by the two voltage diagonals proves (7.6). $\square$

### Theorem 7.3. Every geometric cross entry

For every $1\leq i \lt j\leq n$,

$$
(K_0)_{ij}
=\frac{\ell_i\zeta_j}{T}
-\mathbf1_{\{j=i+1\}}\frac{V_iV_j}{r_j(q_i+q_j)}.
\tag{7.7}
$$

Thus all nonadjacent geometric cross entries in a fixed upstream row have the sign of the single scalar $\ell_i$.

**Proof.** Extend the Green matrix from Lemma 7.2, before multiplication by the voltage factors, by zero at endpoints $0,n$. The Jacobian stencils can then also be extended to the endpoints without changing their product with this zero-extended Green matrix. For indices $a\leq b$, the Green value is the separated product $T_a(T-T_b)/T$.

For any scalar profile $f$, the algebraically extended Jacobian satisfies

$$
[J_{\mathrm{ext}}(Vf)]_i
=2\lambda_i f_i
-V_i\sum_{k\sim i}\frac{V_k}{r_{ik}}(f_i-f_k).
\tag{7.8}
$$

This follows by expanding the product and using the extended nodal equation $L_{\mathrm{ext}}V=-\tau$ on the load rows. The left profile $f_i=T_i$ gives

$$
[J_{\mathrm{ext}}(VT)]_i=\ell_i,\qquad i \lt n,
\tag{7.9}
$$

and the right profile $f_i=T-T_i$ gives

$$
[J_{\mathrm{ext}}(V(T-T_\cdot))]_j=\zeta_j,\qquad j\geq2.
\tag{7.10}
$$

Both identities use
$V_iV_{i-1}\rho_i/r_i=1/(q_{i-1}+q_i)$.

If $j\geq i+2$, all pairs in the two tridiagonal stencils have $a\leq b$. The left stencil does not meet the terminal endpoint, and the right stencil does not meet the root. Applying the stencils to the separated product gives $\ell_i\zeta_j/T$.

If $j=i+1$, exactly one pair crosses this order: $a=i+1,b=i$. Its actual symmetric Green value differs from the separated continuation by $-\rho_{i+1}$. The two transformed Jacobian coefficients are both $V_iV_{i+1}/r_{i+1}$, so the correction is

$$
-\rho_{i+1}\left(\frac{V_iV_{i+1}}{r_{i+1}}\right)^2
=-\frac{V_iV_{i+1}}{r_{i+1}(q_i+q_{i+1})}.
\tag{7.11}
$$

This includes the terminal adjacent pair: for $a=n,b=n-1$, the true zero-extended Green value is zero, whereas its separated continuation is $\rho_n$. The correction therefore also accounts for the nonzero terminal value of the separated left profile. This proves (7.7) at every pair. $\square$

### Corollary 7.4. Exact all-curvature classification

At a regular operating geometry, every strictly positive utility-curvature vector gives strictly negative cross effects if and only if

$$
\ell_i\leq0\quad(1\leq i\leq n-2),\qquad
\ell_{n-1}\leq T\frac{V_{n-1}V_n}{r_n}.
\tag{7.12}
$$

If any inequality fails, a finite-at-zero weighted common-alpha utility family at the same physical geometry has a positive cross derivative.

**Proof.** For every $i\leq n-2$, the terminal nonadjacent entry is $\ell_i b_n/T$, so the first inequalities are necessary for $K_0$ to be a Z-matrix. If they hold, all entries in these upstream rows are nonpositive, and their adjacent entries are strictly negative. The only remaining pair is $(n-1,n)$; formula (7.7) makes its nonpositivity equivalent to the last inequality in (7.12). Theorem 3.3 gives the strict response conclusion for every positive curvature. If a test fails, the corresponding geometric entry is positive, and Proposition 3.5 realizes it using admissible common-alpha utilities. Theorem 4.2 retains the global certificate. $\square$

This criterion concerns all positive utility curvatures at one fixed physical geometry. A particular utility family may remain monotone even when a test fails. Section 9 gives a uniform condition ensuring that outcome.

## 8. Uniform recovery under controlled impedance ratios

### Corollary 8.1. Strict signs at the nominal geometry

Let

$$
s_i=\sum_{k=1}^i r_k,\qquad s_0=0,\qquad S=s_n.
\tag{8.1}
$$

At the limiting geometry $V=\mathbf1,\tau=0$,

$$
q_i=s_i/S,\qquad
\rho_i^0=\frac{Sr_i}{s_{i-1}+s_i},\qquad
T^0=\sum_i\rho_i^0.
\tag{8.2}
$$

Define

$$
a_i=S\left(\frac1{s_{i-1}+s_i}-\frac1{s_i+s_{i+1}}\right)>0
\quad(i \lt n),\qquad
a_n=\frac{S}{s_{n-1}+S}>0.
\tag{8.3}
$$

Then, for $i \lt j$,

$$
(K_0^{\mathrm{nom}})_{ij}
=-\frac{a_i a_j}{T^0}
-\mathbf1_{\{j=i+1\}}\frac{\rho_j^0}{r_j^2}<0.
\tag{8.4}
$$

**Proof.** At the nominal geometry, $J=-L$ and $Lq=e_n/S$, giving (8.2). The Green representation remains valid there. In (7.5), $\ell_i=-a_i$ and $\zeta_i=a_i$, so (7.7) gives (8.4). $\square$

This zero-load point is a geometric limit, not a positive-load operating allocation. For four unit resistances, (8.4) gives $(K_0^{\mathrm{nom}})_{24}=-1/22$. We next quantify a neighborhood in which positive-load allocations retain the negative signs.

Write

$$
\delta=1-v,\qquad
r_{\min}=\min_i r_i,\qquad
\mathscr H=\sum_{i=1}^n\frac{r_i}{s_{i-1}+s_i}.
\tag{8.5}
$$

The first summand of $\mathscr H$ is one, and

$$
1\leq\mathscr H
\leq\min\left\{n,\;1+\frac12\log(S/r_1)\right\}.
\tag{8.6}
$$

Indeed, each summand is at most one; for the logarithmic bound, sum
$(b-a)/(b+a)\leq\tfrac12\log(b/a)$ over consecutive positive cumulative resistances from edge two onward.

### Lemma 8.2. Green and price bounds without a minimum load

Let $\mathcal G=L^{-1}$ and retain $\mathcal H$ from (7.1). With $\eta=\delta/v<1$,

$$
\mathcal G_{ij}=s_{\min(i,j)},\qquad
\mathcal G\leq\mathcal H\leq\frac{\mathcal G}{1-\eta}
\quad\text{entrywise}.
\tag{8.7}
$$

Moreover,

$$
\mu\geq\frac{2v-1}{S},\qquad
\frac{(2v-1)s_i}{S}\leq q_i
\leq\frac{v s_i}{(2v-1)S},
\tag{8.8}
$$

and, for $i \lt n$,

$$
b_i\geq
\frac{(2v-1)^3S(r_i+r_{i+1})}
{v^2(s_{i-1}+s_i)(s_i+s_{i+1})},
\quad
T_i\leq\frac{S\mathscr H}{v^2(2v-1)},
\quad
\lambda_i\leq\frac{\delta}{s_i}.
\tag{8.9}
$$

**Proof.** The minimum formula for $\mathcal G$ follows by weighted first differences. Since $V=\mathbf1-\mathcal G\tau$,

$$
\delta=\sum_i s_i\tau_i.
\tag{8.10}
$$

Put $E_0=\operatorname{diag}(\tau_i/V_i)$ and
$a_0=\sum_i s_i\tau_i/V_i\leq\eta$.
The minimum formula implies
$\mathcal G_{ik}\mathcal G_{kj}\leq s_k\mathcal G_{ij}$.
Thus $\mathcal GE_0\mathcal G\leq a_0\mathcal G$ entrywise. The maximum row sum of the nonnegative matrix $\mathcal GE_0$ equals $a_0<1$, since its final row dominates every other row. Its Neumann series converges, and induction gives

$$
\mathcal H=\sum_{m\geq0}(\mathcal GE_0)^m\mathcal G
\leq\frac{\mathcal G}{1-a_0}
\leq\frac{\mathcal G}{1-\eta}.
\tag{8.11}
$$

The zeroth term proves the lower bound in (8.7).

Since $y=\mu\mathcal He_n$ and $y_n=v$,
$v(1-\eta)/S\leq\mu\leq v/S$.
The lower price bound follows from (7.3) and $V_i\leq1$. The upper follows from (8.7), $\mu\leq v/S$, and $V_i\geq v$. This proves (8.8).

The increment bound in (7.2) gives
$q_{i+1}-q_{i-1}\geq\mu(r_i+r_{i+1})$.
Use the upper price bounds in the denominator of

$$
b_i=\frac{q_{i+1}-q_{i-1}}
{(q_{i-1}+q_i)(q_i+q_{i+1})}
\tag{8.12}
$$

and the lower bound for $\mu$ to obtain the first inequality in (8.9). For the second, use $q_i\geq\mu s_i$ and $V_{i-1}V_i\geq v^2$ in (7.4). The final inequality follows from (8.10) and $\lambda_i=V_i\tau_i\leq\tau_i$. $\square$

### Theorem 8.3. A voltage guarantee for all positive curvatures

If

$$
4(1-v)S\mathscr H \lt r_{\min}(2v-1)^4,
\tag{8.13}
$$

then every off-diagonal entry of $K_0$ is strictly negative. Consequently every strictly positive operating utility-curvature vector gives strictly negative cross derivatives.

An explicit sufficient condition, including its boundary, is

$$
v\geq1-\frac{r_{\min}}{8S\mathscr H}.
\tag{8.14}
$$

In particular, if $r_{\max}/r_{\min}\leq\kappa$, then

$$
v\geq1-\frac1{8n^2\kappa}
\tag{8.15}
$$

is sufficient. No lower bound on relative utility curvature or positive load ratios is required.

**Proof.** For every $i \lt n$, (8.9) gives

$$
\begin{aligned}
\frac{2\lambda_iT_i}{b_i}
&\leq
\frac{2\delta\mathscr H(s_{i-1}+s_i)(s_i+s_{i+1})}
{(2v-1)^4s_i(r_i+r_{i+1})}\\
&\leq\frac{4\delta S\mathscr H}{(2v-1)^4r_{\min}}.
\end{aligned}
\tag{8.16}
$$

The second inequality uses
$(s_{i-1}+s_i)(s_i+s_{i+1})\leq4s_iS$
and $r_i+r_{i+1}\geq2r_{\min}$.
Under (8.13), each $\ell_i<0$. Formula (7.7) then gives strictly negative entries, and Theorem 3.3 gives the curvature assertion.

Under (8.14), $\delta\leq r_{\min}/(8S\mathscr H)\leq1/16$, since $n\geq2$. Hence $(2v-1)^4\geq(7/8)^4>1/2$, while
$4\delta S\mathscr H/r_{\min}\leq1/2$.
Thus (8.13) is strict even when (8.14) is an equality.
Finally, $S\leq nr_{\max}$ and $\mathscr H\leq n$ prove (8.15). $\square$

The profile-dependent bound (8.14) can be substantially stronger than (8.15). Using (8.6), one may replace $n^2\kappa$ in the denominator of (8.15) by
$n\kappa\min\{n,1+\tfrac12\log(n\kappa)\}$.

### Corollary 8.4. The inverse-impedance-ratio scale cannot be improved in order

For fixed dimension four, a uniform all-curvature voltage guarantee over impedance ratios at most $\kappa$ has the scale $\kappa^{-1}$, up to constants.

**Proof.** Theorem 8.3 guarantees the property whenever the voltage deficit is at most $1/(128\kappa)$. For the converse order, take $\kappa>12$, $\varepsilon=1/\kappa$, $v=1-6/\kappa$, and the family (6.2). Its impedance ratio is exactly $\kappa$ and its admissibility bound (6.1) holds with equality. Theorem 6.1 gives a positive geometric entry, and Proposition 3.5 realizes it by a finite-at-zero weighted common-alpha family. Thus failure occurs at voltage deficit $6/\kappa$. The two bounds establish the same dependence on $\kappa$; no optimal-constant claim is made. $\square$

## 9. Recovery from positive relative curvature, without dimension or impedance bounds

The preceding guarantee controls the resistance profile and allows arbitrarily small positive utility curvature. We now prove a complementary result: a positive relative-curvature lower bound removes every dependence on the path length, resistance ratio, and minimum load.

At the operating point define

$$
\gamma_i=-\frac{p_i u_i''(p_i)}{u_i'(p_i)}>0.
\tag{9.1}
$$

Multiplying all utilities by the same positive constant changes neither the allocation nor $\gamma_i$, so we normalize their supporting marginal prices by $q_n=1$. Retain $S=\sum_i r_i$, $\delta=1-v$, $\eta=\delta/v$, and the matrices $\mathcal S,\mathcal H,\mathcal G$ from Sections 7--8.

### Lemma 9.1. Monotonicity of the perturbed Green columns

Every column of $\mathcal H$ is strictly increasing down the path. In particular,

$$
\mathcal H_{ij}\leq\mathcal H_{in},\qquad
\mathcal H_{ij}\leq\mathcal H_{nj}.
\tag{9.2}
$$

**Proof.** Fix a column $x=\mathcal He_j>0$, with $x_0=0$. Summing $\mathcal Sx=e_j$ over rows $k,\ldots,n$ gives

$$
\frac{x_k-x_{k-1}}{r_k}
=\mathbf1_{\{j\geq k\}}
 +\sum_{\ell=k}^n\frac{\tau_\ell}{V_\ell}x_\ell>0.
\tag{9.3}
$$

Thus each column strictly increases. Symmetry gives both inequalities in (9.2). $\square$

### Lemma 9.2. A full normalized curvature bound

Let $R_V=\operatorname{diag}(V)$ and $Q=\operatorname{diag}(q)$, and define

$$
\mathcal C=J^{-\mathsf T}CJ^{-1}\succ0,\qquad
\mathcal E=Q^{-1}\mathcal C Q^{-1}\succ0.
\tag{9.4}
$$

Then $A^\mathsf T\mathcal C A=B$, and every entry satisfies

$$
0<\mathcal E_{ij}\leq\frac{2S}{(2v-1)^2}=:b.
\tag{9.5}
$$

**Proof.** Since $J^{-1}=-\mathcal HR_V^{-1}$ and $J^{-1}A$ is the embedding of the first $n-1$ coordinates, the identity $A^\mathsf T\mathcal C A=B$ follows directly. The supporting-price equation gives

$$
\mu=\frac{v}{\mathcal H_{nn}},\qquad
q_i=\frac{\mu\mathcal H_{in}}{V_i},\qquad
\mu\geq\frac{v(1-\eta)}S.
\tag{9.6}
$$

Let $E_0=\operatorname{diag}(\tau_i/V_i)$. Using
$L=\mathcal S+E_0$ and $\mathcal H\mathcal S=I$,

$$
\mathcal H C\mathcal H
=\mathcal HQ+Q\mathcal H+2\mathcal HQE_0\mathcal H.
\tag{9.7}
$$

Consequently,

$$
\mathcal E_{ij}
=\frac{(q_i+q_j)\mathcal H_{ij}
 +2\sum_k\mathcal H_{ik}q_k(\tau_k/V_k)\mathcal H_{kj}}
{\mu^2\mathcal H_{in}\mathcal H_{jn}}>0.
\tag{9.8}
$$

By Lemma 9.1 and (9.6), the first summand is at most $2/(\mu v)$. For the second, each ratio
$\mathcal H_{ik}\mathcal H_{kj}/(\mathcal H_{in}\mathcal H_{jn})$
is at most one. Moreover,

$$
\sum_kq_k\frac{\tau_k}{V_k}
=\mu\sum_k\mathcal H_{kn}\frac{\tau_k}{V_k^2}
\leq\frac{\mu}{v^2}(\mathcal H\tau)_n,
\qquad
(\mathcal H\tau)_n\leq\frac{\delta}{1-\eta},
\tag{9.9}
$$

where the final bound follows from (8.7) and (8.10). Thus

$$
\begin{aligned}
\mathcal E_{ij}
&\leq\frac2{\mu v}
 +\frac{2\delta}{\mu v^2(1-\eta)}
=\frac2{\mu v(1-\eta)}\\
&\leq\frac{2S}{v^2(1-\eta)^2}
=\frac{2S}{(2v-1)^2}.
\end{aligned}
\tag{9.10}
$$

This proves (9.5), including cases with arbitrarily small price or load components. $\square$

### Lemma 9.3. A weighted constrained-inverse estimate

Let $E$ be a symmetric positive-semidefinite $n$-by-$n$ matrix with $|E_{ij}|\leq b$. Let $w_i>0$, $W=\operatorname{diag}(w)$, $w_+=\sum_iw_i$, and $t=bw_+<1/4$. Define

$$
Z=(W^{-1}+E)^{-1},\qquad
\mathcal R=Z-\frac{Z\mathbf1\mathbf1^\mathsf TZ}
{\mathbf1^\mathsf TZ\mathbf1}.
\tag{9.11}
$$

For $i\ne j$,

$$
\mathcal R_{ij}
\leq-(1-4t)\frac{w_iw_j}{w_+}<0.
\tag{9.12}
$$

**Proof.** The maximum absolute row sum of $EW$ is at most $t$, so
$Z=W\sum_{m\geq0}(-EW)^m$.
For $m\geq1$, each absolute entry of $W(EW)^m$ is at most
$w_iw_jb\,t^{m-1}$. Therefore

$$
|Z_{ij}-w_i\mathbf1_{\{i=j\}}|
\leq\frac{bw_iw_j}{1-t}.
\tag{9.13}
$$

Put $h=Z\mathbf1$ and $r=t/(1-t)<1$. Summing (9.13) gives

$$
w_i(1-r)\leq h_i\leq w_i(1+r),\qquad
\mathbf1^\mathsf TZ\mathbf1\leq w_+(1+r).
\tag{9.14}
$$

In particular, all $h_i>0$. For $i\ne j$, use these inequalities in (9.11):

$$
\begin{aligned}
\mathcal R_{ij}
&\leq\frac{w_iw_j}{w_+}
\left[\frac{t}{1-t}-\frac{(1-r)^2}{1+r}\right]\\
&=\frac{w_iw_j}{w_+}\,
\frac{t-(1-2t)^2}{1-t}
=-(1-4t)\frac{w_iw_j}{w_+}.
\end{aligned}
\tag{9.15}
$$

The estimate retains the product $w_iw_j$ at every step, which avoids a minimum-weight assumption. $\square$

### Theorem 9.4. Uniform recovery for every finite path and positive impedance profile

Suppose every operating relative curvature satisfies $\gamma_i\geq\alpha>0$. If

$$
\alpha>\frac{8v^2(1-v)}{(2v-1)^3},
\tag{9.16}
$$

then

$$
\frac{\partial p_i}{\partial z_j}<0
\quad\text{for all }i,j.
\tag{9.17}
$$

The conclusion holds for every finite path length and every positive resistance profile under the regular-face assumptions. It requires no bound on resistance ratios, minimum loads, or load ratios.

**Proof.** The actual utility curvature is

$$
D_i=\frac{\gamma_iq_i}{\lambda_i}.
\tag{9.18}
$$

Set $w_i=q_i\lambda_i/\gamma_i>0$ and $W=\operatorname{diag}(w)$. Then
$D+\mathcal C=Q(W^{-1}+\mathcal E)Q$.
The free Jacobian has image $q^\perp$, and
$A^\mathsf T(D+\mathcal C)A=A^\mathsf TDA+B$.
The constrained-inverse identity therefore gives

$$
\begin{aligned}
K(D)
&=(D+\mathcal C)^{-1}\\
&\quad-\frac{(D+\mathcal C)^{-1}qq^\mathsf T(D+\mathcal C)^{-1}}
{q^\mathsf T(D+\mathcal C)^{-1}q}.
\end{aligned}
\tag{9.19}
$$

This identity can be verified by annihilation of $q$ and the inverse action of the bilinear form $D+\mathcal C$ on $q^\perp$. Diagonal transformation gives

$$
QK(D)Q=\mathcal R
\tag{9.20}
$$

for the matrix in Lemma 9.3 with $E=\mathcal E$.

It remains to bound its dimensionless perturbation size. By (9.6), (9.9), and $\mathcal H_{nn}\geq S$,

$$
\begin{aligned}
w_+
&\leq\frac1\alpha\sum_iq_i\lambda_i
=\frac\mu\alpha(\mathcal H\tau)_n\\
&\leq\frac{v\delta}{\alpha S(1-\eta)}
=\frac{v^2\delta}{\alpha S(2v-1)}.
\end{aligned}
\tag{9.21}
$$

With $b$ from (9.5),

$$
t=bw_+\leq
\Theta:=\frac{2v^2(1-v)}{\alpha(2v-1)^3}<\frac14.
\tag{9.22}
$$

Lemma 9.3 gives strictly negative geometric-response entries. More quantitatively,

$$
K(D)_{ij}
\leq-(1-4\Theta)
\frac{\lambda_i\lambda_j}{\gamma_i\gamma_jw_+}<0
\qquad(i\ne j).
\tag{9.23}
$$

The positive prefactor in (3.4) proves the cross-derivative assertion, and the diagonal assertion follows from Theorem 3.1. Proposition 4.3 ensures these are derivatives of unique global optima. $\square$

### Corollary 9.5. Explicit voltage regimes

The hypotheses of Theorem 9.4 are satisfied in each of the following cases:

1. $v\geq0.95$ and every $\gamma_i\geq1/2$;
2. $v\geq11/12$ and every $\gamma_i\geq1$;
3. $v\geq\max\{3/4,1-\alpha/40\}$ and every $\gamma_i\geq\alpha>0$.

All conclusions are strict, including the displayed voltage endpoints.

**Proof.** The right side of (9.16) is strictly decreasing on $(1/2,1)$. At $v=19/20$, it equals $361/729<1/2$; at $v=11/12$, it equals $121/125<1$. These prove the first two cases. For the third, the decreasing function $2v^2/(2v-1)^3$ equals nine at $v=3/4$. Hence $\Theta\leq9(1-v)/\alpha\leq9/40<1/4$. $\square$

The first case includes every positively weighted square-root utility, since its relative curvature is exactly $1/2$ and it is finite at zero. The second case is a statement about operating relative curvatures and does not require adding logarithmic utilities to our finite-at-zero convention. Lemma 3.4 can realize such positive local curvatures within that convention.

These guarantees remain local to the stated regular face. They integrate along componentwise nondecreasing population paths that preserve the hypotheses. They do not address arbitrary active-set transitions.

## 10. Interpretation, scope, and reproducibility

The main distinction is between geometric and utility protection. Corollary 7.4 exactly characterizes the physical operating geometries at which every positive utility curvature gives the expected congestion response. Theorem 8.3 guarantees that property near nominal voltage when the impedance profile is controlled, with an explicit bound requiring no load balance. Theorem 9.4 instead fixes a positive lower relative curvature and obtains a voltage guarantee that is independent of path length and every impedance ratio. Its $0.95$ voltage corollary includes all positively weighted square-root utilities.

The examples identify the limits of these conclusions. Two load nodes have negative cross effects on the regular face for all positive utility curvatures. The three-load uniform floor $3/4$ is sharp in that dimension. Four-load examples fail above every voltage floor below one if both impedance ratios and allowable utility curvature may vary. Their critical common exponent has an exact fourth-power scale. With no curvature lower bound, the impedance-ratio dependence of the recovery theorem has the correct order for fixed dimension, as shown by Corollary 8.4. The $n^2$ factor and the sufficient constants are not asserted to be optimal.

The common-ratio restriction places every construction inside the archived source model. It also meets the nonincreasing ratio condition stated in the published model, because equality is allowed. The utility constructions have stricter smoothness and curvature properties than needed for a counterexample to the source's general admissible class. They do not rely on the ambiguity of a logarithmic utility at zero.

Our global-support argument is independent of numerical optimization. It proves that the reference allocation dominates every feasible SOC competitor under the constructed positive prices. Strict concavity then identifies the unique global aggregate allocation. The implicit-function theorem is used only after this certificate has established the reference solution, and a persistent certificate establishes the perturbed solutions. This avoids confusing a stationary voltage perturbation with an optimizer perturbation.

There are several boundaries to the conclusions. We do not classify changes of active sets, binding station or per-vehicle caps, multiple vehicle classes at one node, arbitrary resistance-to-reactance profiles, or unrestricted complex AC power flow. The fixed-relative-curvature theorem gives a sufficient high-voltage regime, not a necessary threshold for each prescribed fairness exponent or fixed physical line. The dimension-free sufficient bound is proportional to the voltage deficit near nominal voltage, whereas the displayed failure family's critical exponent has fourth-power scaling. No matching universal curvature-voltage threshold is claimed. The local comparative statics do not by themselves settle convergence or uniqueness questions for the full stochastic charging dynamics.

The accompanying exact-arithmetic materials check algebraic identities and rational witnesses from the proofs. The script code/verify_exact.py and its output results/exact_certificate.json verify the rational three-load witness, its three curvature-numerator identities, positivity certificates for the three-load bound, the sharpness limit, the four-load polynomial and asymptotic, the utility-realization identities, and a rational common-alpha near-nominal witness. The path Green identities, constrained-inverse estimates, and uniform inequalities are proved explicitly in Sections 7--9. Computation is used to check algebra and endpoints; it does not replace those inequalities or the global-optimality argument. No numerical optimizer or random search is needed for the stated conclusions.

The secondary script, code/verify_secondary.py, and results/secondary_certificate.json separately check the arbitrary-path Green identities and endpoints, the diagonal scalings and constrained-inverse identity used in the relative-curvature proof, and the exact common-alpha numerator, its independent fixed-voltage and joint limits, and rational examples on both sides of the transition. The finite examples test indexing and algebra rather than establish the universal inequalities. Both scripts use exact symbolic or rational assertions.

## References

**[Ave20]** A. Aveklouris. *Layered stochastic networks with limited resources*. Doctoral thesis, Eindhoven University of Technology, 2020. ISBN 978-90-386-4966-5. The line conjecture is in Section 5.6, following Definition 5.6.1; the two-load proof is in Section 5.12. [Official thesis PDF](https://pure.tue.nl/ws/portalfiles/portal/145233555/20200128_Aveklouris.pdf).

**[AVZ19]** A. Aveklouris, M. Vlasiou, and B. Zwart. A stochastic resource-sharing network for electric vehicle charging. *IEEE Transactions on Control of Network Systems* **6**(3):1050--1061, 2019. DOI: [10.1109/TCNS.2019.2915651](https://doi.org/10.1109/TCNS.2019.2915651). [Author preprint](https://arxiv.org/pdf/1711.05561).

**[AVZ20]** A. Aveklouris, M. Vlasiou, and B. Zwart. A fluid model of an electric vehicle charging network. arXiv:2004.05637v1, 12 April 2020. The simplified AC allocation is specified in Section 2.4, and the line-network conjecture appears in Section 6. [Version-specific preprint](https://arxiv.org/pdf/2004.05637v1).

**[AVZ22]** A. Aveklouris, M. Vlasiou, and B. Zwart. A fluid model of an electric vehicle charging network. *Stochastic Systems* **12**(2):151--180, 2022. DOI: [10.1287/stsy.2021.0084](https://doi.org/10.1287/stsy.2021.0084). [Institutional full-text deposit](https://ris.utwente.nl/ws/portalfiles/portal/283186164/stsy.2021.0084.pdf). The archived preprint's invariant-analysis and monotonicity-conjecture section is absent from this published version.

**[Johnson82]** C. R. Johnson. Inverse M-matrices. *Linear Algebra and its Applications* **47**:195--216, 1982. DOI: [10.1016/0024-3795(82)90238-5](https://doi.org/10.1016/0024-3795(82)90238-5). Theorem 3 provides the relevant diagonal-addition closure precedent. [Publisher record](https://www.sciencedirect.com/science/article/pii/0024379582902385).


**[RZ14]** J. Reed and B. Zwart. Limit theorems for Markovian bandwidth-sharing networks with rate constraints. *Operations Research* **62**(6):1453--1466, 2014. DOI: [10.1287/opre.2014.1321](https://doi.org/10.1287/opre.2014.1321). [Complete author manuscript](https://pages.stern.nyu.edu/~jreed/papers/paper14.pdf).

**[GLL15]** L. Gan, N. Li, U. Topcu, and S. H. Low. Exact convex relaxation of optimal power flow in radial networks. *IEEE Transactions on Automatic Control* **60**(1):72--87, 2015. DOI: [10.1109/TAC.2014.2332712](https://doi.org/10.1109/TAC.2014.2332712). [Author-hosted version of record](https://smart.caltech.edu/papers/exactconvexrelaxation.pdf).

**[CCJ23]** M. H. M. Christianen, J. Cruise, A. J. E. M. Janssen, S. Shneer, M. Vlasiou, and B. Zwart. Comparison of stability regions for a line distribution network with stochastic load demands. *Queueing Systems* **103**:187--239, 2023. DOI: [10.1007/s11134-023-09873-z](https://doi.org/10.1007/s11134-023-09873-z).

**[CVZ24]** M. H. M. Christianen, M. Vlasiou, and B. Zwart. Comparing power flow models in tree networks with stochastic load demands. In *Operations Research and Enterprise Systems*, Communications in Computer and Information Science **1985**, pp. 138--167, 2024 (first online 15 December 2023). DOI: [10.1007/978-3-031-49662-2_8](https://doi.org/10.1007/978-3-031-49662-2_8). [Institutional version of record](https://pure.tue.nl/ws/portalfiles/portal/344989898/978-3-031-49662-2_8.pdf).

**[Meurant92]** G. Meurant. A review on the inverse of symmetric tridiagonal and block tridiagonal matrices. *SIAM Journal on Matrix Analysis and Applications* **13**(3):707--728, 1992. DOI: [10.1137/0613045](https://doi.org/10.1137/0613045). [Author-hosted full text](https://gerard-meurant.fr/blocktridiag_1992.pdf).

**[DMS17]** K. Dvijotham, E. Mallada, and J. W. Simpson-Porco. High-voltage solution in radial power networks: existence, properties, and equivalent algorithms. *IEEE Control Systems Letters* **1**(2):322--327, 2017. DOI: [10.1109/LCSYS.2017.2717578](https://doi.org/10.1109/LCSYS.2017.2717578). [Author-hosted full text](https://www.control.utoronto.ca/~jwsimpson/papers/2017d.pdf).
