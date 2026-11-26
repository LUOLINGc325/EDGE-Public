---
title: "The least dissipation of linear relaxation: spectral determinacy and exact acceleration frontiers"
date: "2026-11-26"
lang: en
---

## Abstract

We minimize the steady entropy production of an Ornstein–Uhlenbeck process with fixed diffusion and stationary covariance under a prescribed lower bound on the real parts of its drift eigenvalues. We first characterize exactly when entropy production is determined by the drift spectrum: the fixed, whitened diffusion matrix must have at most two distinct eigenvalues. In that class, a cubic trace identity yields the complete dissipation frontier in every dimension and for arbitrary eigenvalue multiplicities. We identify every minimizing spectrum, the exact number of recruited modes, and the unavoidable Jordan structure of the optimizers. The same cost is the infimum under an exponential bound with a finite prefactor, but this infimum is generally not attained; an explicit construction also resolves the maximal-rate endpoint. For arbitrary positive diffusion matrices in dimension three, elementary nonnegative certificates give the complete frontier and its optimizers. The resulting curvature classification provides an exact rational counterexample to a self-published online conjecture asserting convexity of each fixed-support budget–rate arc. The optimization concerns the asymptotic spectral exponent; it does not assert an improved contraction rate with prefactor one.

## 1. Introduction

Nonreversible stationary currents can accelerate relaxation without changing the invariant distribution. For linear Gaussian diffusions, the largest possible slow spectral rate is the average of the reversible rates, and optimal drifts can be constructed explicitly [1]. That unlimited-budget result leaves a different question: what is the least thermodynamic dissipation required for each intermediate rate?

The distinction between possible costs matters. In their optimization of irreversible Langevin perturbations, Zhu, Marzouk, Spiliopoulos, and Zhang distinguish the quadratic quantities $\mathcal E_1=-\operatorname{tr}(JSJ)$ and $\mathcal E_2=-\operatorname{tr}(JSJS)$ [6, Sections 3.2–3.4]. Under the change of variables $D=S$ and $Q=S^{1/2}JS^{1/2}$, these become, respectively, the entropy production $\operatorname{tr}(Q^\top D^{-1}Q)$ studied here and the unweighted cost $\|Q\|_F^2$. Their closed-form spectral optimization concerns $\mathcal E_2$. The Schur–Horn realization and upper-triangular construction used in their proof are also useful here; neither construction is claimed as new. Our question concerns the thermodynamically weighted cost $\mathcal E_1$, throughout the feasible range of target rates.

The relation between irreversibility, eigenvectors, and relaxation has several complementary formulations. Duncan, Lelièvre, and Pavliotis study asymptotic variance reduction [2], an objective distinct from the slow spectral rate. Da Costa and Pavliotis give a general treatment of stationary diffusion entropy production and time reversal [3]. Fyodorov, Gudowska-Nowak, Nowak, and Tarnowski relate eigenvector nonorthogonality to fluctuation–dissipation relations and enhanced entropy production [4]. Nagayama, Kolchinsky, and Ito decompose OU entropy production into oscillatory and nonnormal contributions and derive an acceleration tradeoff [5]. Their analysis includes Schur decompositions and already suggests avoiding oscillatory dissipation when designing a relaxation speedup. Thus neither the importance of nonnormality nor the possible efficiency of real spectra is new. The questions addressed below are exact minimization, equality, and the structural boundary of a spectral description.

**Contribution.** We prove that entropy production is determined by the drift spectrum for every antisymmetric perturbation of a fixed positive diffusion matrix if and only if that diffusion matrix has at most two distinct eigenvalues. For arbitrary dimension and arbitrary multiplicities in this class, we derive the entire minimum-dissipation frontier, characterize every minimizing spectrum, and identify the exact recruitment thresholds and the unavoidable critical Jordan blocks. We determine the infimum and its attainment under finite-prefactor exponential relaxation, including the maximal-rate endpoint. Independently, we solve the complete three-dimensional problem for arbitrary positive diffusion spectra by explicit nonnegative certificates. The three-dimensional formula yields a necessary and sufficient curvature criterion for the second budget–rate arc and an exact rational counterexample to the conjecture that every fixed-support arc is convex.

The online collection of Cheong [8, Part XVI] provides concrete conjectures about sequential recruitment, an initial interval of exact two-mode optimality, and convexity of the budget–rate arcs. Its two-dimensional calibration is already explicit. Our three-dimensional theorem proves the first two properties in dimension three and disproves the convexity assertion for a simple diffusion spectrum. These statements concern that specified online conjecture; no broader dimensional recruitment law is asserted.

## 2. Model, objectives, and elementary spectral facts

All matrices are real unless otherwise indicated. Consider

$$
dX_t=-KX_t\,dt+\sqrt{2D}\,dW_t,
\qquad K=D+Q,\quad D=D^\top\gt 0,\quad Q^\top=-Q.
\tag{2.1}
$$

The stationary distribution is $\pi=N(0,I)$, since $K+K^\top=2D$. We use standard time reversal with every coordinate even. The stationary probability current is $-Qx\,\pi(x)$, so its entropy production rate, with the normalization in (2.1), is

$$
\sigma_D(Q)=
\int_{\mathbb R^n}(Qx)^\top D^{-1}(Qx)\,\pi(dx)
=\operatorname{tr}(Q^\top D^{-1}Q).
\tag{2.2}
$$

This is the usual stationary diffusion formula [3]. Define

$$
\gamma_D(Q)=\min_{\lambda\in\operatorname{spec}(D+Q)}
\operatorname{Re}\lambda,
\qquad
F_D(g)=\inf_{\substack{Q^\top=-Q\\\gamma_D(Q)\ge g}}\sigma_D(Q),
\tag{2.3}
$$

with the infimum of the empty set equal to $+\infty$. Its budget counterpart is

$$
\Gamma_D(B)=
\max_{\substack{Q^\top=-Q\\\sigma_D(Q)\le B}}\gamma_D(Q),
\qquad B\ge0.
\tag{2.4}
$$

The maximum exists: the cost constraint is compact, because
$\sigma_D(Q)\ge\|Q\|_F^2/\lambda_{\max}(D)$, and the minimum real part of the spectrum is continuous in the matrix entries.

For a general prescribed stationary covariance $C\gt 0$ and diffusion $D_0\gt 0$, write the drift as $A=(D_0+Q_0)C^{-1}$, where $Q_0^\top=-Q_0$. The whitening transformation gives

$$
D=C^{-1/2}D_0C^{-1/2},\qquad
Q=C^{-1/2}Q_0C^{-1/2}.
\tag{2.5}
$$

It preserves the drift spectrum and transforms
$\operatorname{tr}(Q_0^\top D_0^{-1}Q_0C^{-1})$
into (2.2). Consequently, assumptions about the diffusion spectrum below concern the whitened matrix $D$.

**Lemma 2.1 (spectral interval and trace ceiling).** If $a$ and $b$ are the smallest and largest eigenvalues of $D$, every eigenvalue $\lambda$ of $K$ satisfies

$$
a\le\operatorname{Re}\lambda\le b,\qquad
\gamma_D(Q)\le\mu_D:=\frac{\operatorname{tr}D}{n}.
\tag{2.6}
$$

Moreover, $F_D(g)=0$ for $g\le a$, with unique minimizer $Q=0$, and $F_D(g)=+\infty$ for $g\gt \mu_D$.

*Proof.* For a complex eigenvector $v\ne0$,
$\operatorname{Re}\lambda=v^*Dv/(v^*v)$ because $Q^*=-Q$.
The sum of all eigenvalue real parts, counted with algebraic multiplicity, is $\operatorname{tr}D$. Finally, the cost is positive definite on the space of antisymmetric matrices, and $Q=0$ has slow rate $a$. $\square$

If $D=aI$, all spectral real parts equal $a$ for every $Q$. This scalar case is henceforth separated from the nondegenerate two-eigenvalue case.

## 3. Exactly when dissipation is a spectral quantity

Call $D$ **spectrally determinate for entropy production** if any two antisymmetric matrices $Q_1,Q_2$ for which $D+Q_1$ and $D+Q_2$ have the same eigenvalue multiset also satisfy $\sigma_D(Q_1)=\sigma_D(Q_2)$.

**Theorem 3.1 (spectral determinacy).** A positive definite symmetric matrix $D$ is spectrally determinate for entropy production if and only if it has at most two distinct eigenvalues. When those eigenvalues are $0\lt a\lt b$, set

$$
p(z)=z^3-3(a+b)z^2.
$$

Then, for every antisymmetric $Q$,

$$
\boxed{\displaystyle
\sigma_D(Q)=
\frac{\operatorname{tr}p(D+Q)-\operatorname{tr}p(D)}{3ab}.}
\tag{3.1}
$$

*Proof.* The trace identities

$$
\operatorname{tr}(D+Q)^2=\operatorname{tr}D^2+\operatorname{tr}Q^2,
\qquad
\operatorname{tr}(D+Q)^3=\operatorname{tr}D^3+
3\operatorname{tr}(DQ^2)
\tag{3.2}
$$

follow by expansion, cyclicity, and the vanishing trace of a product of a symmetric matrix with an antisymmetric matrix. Also $\operatorname{tr}Q^3=0$. If $D$ has eigenvalues $a,b$, then
$D^{-1}=((a+b)I-D)/(ab)$.
Substitution into (3.2) proves (3.1). Traces of matrix polynomials are sums of the corresponding eigenvalue polynomials even when the matrix is not diagonalizable. If $D=aI$, the analogous identity is
$\sigma_D(Q)=-\operatorname{tr}(K-aI)^2/a$.

Conversely, suppose $D$ has three different eigenvalues $0\lt a\lt b\lt c$. In an orthonormal eigenbasis, perturb only the corresponding three-dimensional block and put

$$
x=q_{12}^2,\qquad y=q_{13}^2,\qquad z=q_{23}^2,
\qquad x,y,z\gt 0.
$$

Its characteristic polynomial is

$$
\det(tI-K)=(t-a)(t-b)(t-c)
+x(t-c)+y(t-b)+z(t-a).
\tag{3.3}
$$

Thus it depends on $x,y,z$ only through $x+y+z$ and $cx+by+az$. Both quantities remain fixed along

$$
(x_\tau,y_\tau,z_\tau)
=(x,y,z)+\tau(b-a,-(c-a),c-b).
\tag{3.4}
$$

For sufficiently small $|\tau|$, all three coordinates stay positive and can be realized as squares of real couplings. The entropy production along this isospectral family has derivative

$$
\left(\frac1a+\frac1b\right)(b-a)
-\left(\frac1a+\frac1c\right)(c-a)
+\left(\frac1b+\frac1c\right)(c-b)
=-\frac{(b-a)(c-a)(c-b)}{abc}\ne0.
\tag{3.5}
$$

Taking a direct sum with the unchanged remaining coordinates completes the counterexample in every larger dimension. $\square$

For example, with $D=\operatorname{diag}(1,2,3)$, the squares
$(1+\tau,1-2\tau,1+\tau)$, $-1\lt \tau\lt 1/2$, give a constant characteristic polynomial and entropy production $11/3-\tau/3$.
Theorem 3.1 identifies the exact range of a purely spectral cost representation. It does not exclude other methods for matrices with three or more diffusion eigenvalues.

## 4. The complete frontier for two diffusion eigenvalues

Throughout this section assume

$$
D=bI-\delta P,\qquad
\delta=b-a\gt 0,\quad a\gt 0,\qquad
P=P^\top=P^2,\quad \operatorname{rank}P=r,\quad 1\le r\lt n.
\tag{4.1}
$$

Thus $a$ has multiplicity $r$, $b$ has multiplicity $n-r$, and
$\mu=b-r\delta/n$.

**Lemma 4.1 (spectral cost and packing).** Write the eigenvalues of $K$ as $\lambda_i=u_i+iv_i$ and set $s_i=b-u_i$. Then

$$
\sigma_D(Q)=
\frac{r\delta^2-\sum_i s_i^2}{b}
+\frac{r\delta^3-\sum_i s_i^3}{3ab}
+\sum_i\frac{a+b-u_i}{ab}v_i^2.
\tag{4.2}
$$

If $a\le g\le\mu$ and $\gamma_D(Q)\ge g$, put

$$
\varepsilon=b-g,\qquad
k=\left\lceil\frac{r\delta}{\varepsilon}\right\rceil,\qquad
m=k-1,\qquad
\rho=r\delta-m\varepsilon.
\tag{4.3}
$$

Then $r\le k\le n$, $0\lt \rho\le\varepsilon$, and the maximum of
$\sum_i(3as_i^2+s_i^3)$ subject to
$0\le s_i\le\varepsilon$, $\sum_i s_i=r\delta$
is achieved precisely by permutations of

$$
(\underbrace{\varepsilon,\ldots,\varepsilon}_{m},
\rho,\underbrace{0,\ldots,0}_{n-k}).
\tag{4.4}
$$

*Proof.* From (3.1),

$$
\operatorname{Re}p(u+iv)=p(u)+3(a+b-u)v^2,
\qquad p''(u)=6(u-a-b)\le-6a\lt 0
\quad(a\le u\le b).
\tag{4.5}
$$

Expanding $p(b-s)$ and using $\sum_i s_i=r\delta$ gives (4.2).
The constraints on the deficits follow from Lemma 2.1 and the target rate. The function $f(s)=3as^2+s^3$ is strictly convex for $s\ge0$. If two coordinates lie strictly between $0$ and $\varepsilon$, moving mass from the smaller to the larger, keeping their sum fixed, strictly increases $f(s_i)+f(s_j)$ until one coordinate reaches an endpoint. Every maximizer consequently has at most one interior coordinate. The sum constraint forces exactly (4.4). Conversely, such vectors are feasible and all have the same objective value. This argument also shows that (4.4) separately maximizes $\sum_i s_i^2$ and $\sum_i s_i^3$. $\square$

In particular, if $r\delta/\varepsilon$ is an integer, (4.3) gives $\rho=\varepsilon$, not zero. This convention counts the positive deficits correctly at every threshold.

**Lemma 4.2 (real spectral realization).** Every real vector $\ell=(\ell_1,\ldots,\ell_n)$ satisfying

$$
a\le\ell_i\le b,\qquad \sum_i\ell_i=\operatorname{tr}D
\tag{4.6}
$$

is the spectrum of $D+Q$ for some real antisymmetric $Q$.

*Proof.* Set $d_i=(b-\ell_i)/\delta$. Then $0\le d_i\le1$ and $\sum_i d_i=r$. The vector $d$ is majorized by the vector with $r$ entries equal to $1$ and the rest $0$: the sum of its largest $j$ entries is at most $j$ for $j\le r$ and at most $r$ for $j\gt r$. The real Schur–Horn theorem [7] supplies a rank-$r$ orthogonal projection $P'$ with diagonal $d$. Hence $H=bI-\delta P'$ is orthogonally similar to $D$ and has diagonal $\ell$.

Define $S_{ij}=H_{ij}$ for $i\lt j$, $S_{ji}=-H_{ij}$, and $S_{ii}=0$. Then $H+S$ is upper triangular with diagonal $\ell$. If $UHU^\top=D$, the choice $Q=USU^\top$ proves the claim. This is the standard triangular realization used in related drift optimization [6]. $\square$

**Theorem 4.3 (exact two-eigenvalue frontier and every optimal spectrum).** For $a\le g\le\mu$, with (4.3),

$$
\boxed{\displaystyle
F_D(g)=
\frac{r\delta^2-m\varepsilon^2-\rho^2}{b}
+\frac{r\delta^3-m\varepsilon^3-\rho^3}{3ab}.}
\tag{4.7}
$$

The infimum is attained. Every minimizing drift has precisely the real spectrum

$$
\boxed{
\{\,g\text{ with multiplicity }m,\quad
b-\rho,\quad
b\text{ with multiplicity }n-k\,\}.}
\tag{4.8}
$$

Conversely, any antisymmetric perturbation with spectrum (4.8) is a minimizer. When $\rho=\varepsilon$, the first two entries combine into multiplicity $k$. The branches $g\le a$ and $g\gt \mu$ are as in Lemma 2.1.

*Proof.* In (4.2) the imaginary-part coefficient is at least $1/b\gt 0$. Lemma 4.1 therefore gives the lower bound (4.7), and equality requires both $v_i=0$ for every $i$ and the packed deficit multiset (4.4). Lemma 4.2 realizes the corresponding real spectrum (4.8), so the bound is attained. Formula (3.1) shows that every realization of this spectrum has the same cost. At $g=a$, $k=r$ and $\rho=\delta$, giving zero cost and $Q=0$. At $g=\mu$, $k=n$ and $\rho=\varepsilon$, giving the constant real spectrum $\mu$. $\square$

There is also an exact error certificate. Put $S_j^*=m\varepsilon^j+\rho^j$. For every feasible $Q$,

$$
\sigma_D(Q)-F_D(g)=
\frac{S_2^*-\sum_i s_i^2}{b}
+\frac{S_3^*-\sum_i s_i^3}{3ab}
+\sum_i\frac{a+b-u_i}{ab}v_i^2.
\tag{4.9}
$$

All three terms are nonnegative. In particular,

$$
\sigma_D(Q)\ge F_D(g)+\frac1b\sum_i v_i^2.
\tag{4.10}
$$

The coefficient $1/b$ is sharp in instances with at least two unused $b$ directions: adding an independent planar rotation of frequency $\omega$ on two such directions increases the cost by $2\omega^2/b$. No claim of sharpness of this simplified coefficient is needed when those directions are absent.

**Corollary 4.4 (thresholds, saturation, and budget inversion).** Define

$$
g_j=b-\frac{r\delta}{j},\qquad j=r,\ldots,n.
\tag{4.11}
$$

Thus $g_r=a$ and $g_n=\mu$. The formula has $k$ positive deficits on $g_{k-1}\lt g\le g_k$. The function $F_D$ is continuous and strictly increasing on $[a,\mu]$, and

$$
F_D(\mu)=
\frac{r\delta^2-r^2\delta^2/n}{b}
+\frac{r\delta^3-r^3\delta^3/n^2}{3ab}.
\tag{4.12}
$$

Moreover,

$$
\Gamma_D(B)=
\begin{cases}
F_D^{-1}(B),&0\le B\lt F_D(\mu),\\
\mu,&B\ge F_D(\mu).
\end{cases}
\tag{4.13}
$$

*Proof.* At adjacent thresholds the two packed descriptions are permutations of the same vector, proving continuity. On a fixed open phase, differentiation gives

$$
F_D'(g)=
\frac{(k-1)(\varepsilon-\rho)(2a+\varepsilon+\rho)}{ab}\gt 0,
\tag{4.14}
$$

and

$$
F_D''(g)=-(k-1)
\left(\frac{2k}{b}+
\frac{2\varepsilon+2(k-1)\rho}{ab}\right)\lt 0.
\tag{4.15}
$$

These imply strict increase, including across thresholds. Substitution at $\mu$ gives (4.12). By Theorem 4.3 a target $g$ is affordable exactly when $F_D(g)\le B$, which proves (4.13). $\square$

At an interior threshold $g_j$, the left derivative of $F_D$ is zero, while

$$
F_D'(g_j+)=\frac{r\delta(2a+r\delta/j)}{ab}\gt 0.
\tag{4.16}
$$

Thus the cost is strictly concave within phases and has upward derivative jumps; it is generally neither globally convex nor globally concave. For fixed $a,b,r,g$, its value is independent of the ambient dimension once $n\ge k$. This statement concerns added unused directions, not a physical change of diffusion at no cost. For budgets strictly below saturation, every budget optimizer uses the full budget and has spectrum (4.8). Above saturation, budget optimizers need not minimize dissipation and need not have a real spectrum.

At the small-gain endpoint, (4.14) gives the sharper scaling

$$
F_D(a+\eta)=\frac{r(b-a)(a+b)}{ab}\eta+O(\eta^2)
\qquad(\eta\downarrow0).
\tag{4.17}
$$

Indeed, the first open phase has $k=r+1$, $\varepsilon=\delta-\eta$, and $\rho=r\eta$, so substitution in (4.14) gives the stated positive derivative. The general acceleration lower bound in [5, equation (15)] is quadratic in the gain. Formula (4.17) identifies the actual linear cost at fixed nonscalar two-eigenvalue diffusion, rather than only improving the constant in that general bound.

## 5. Recruitment, Jordan blocks, and finite-prefactor relaxation

The equality spectrum has a stronger implication than the existence of one convenient triangular optimizer.

**Proposition 5.1 (inactive directions and critical multiplicity).** Suppose $a\lt g\le\mu$ and $Q$ minimizes (2.3) for the two-eigenvalue matrix (4.1). The $b$ eigenspace is an $(n-k)$-dimensional common reducing subspace of $D,Q,K$, and $Q$ vanishes there. On its $k$-dimensional orthogonal complement, $D$ has eigenvalues $a,b$ with multiplicities $r,k-r$. For every real $\lambda\in(a,b)$,

$$
\dim\ker(K-\lambda I)\le\min(r,k-r).
\tag{5.1}
$$

Consequently, every minimizer has a nontrivial Jordan block at the slow eigenvalue $g$, except when $r=1$ and $a\lt g\lt (a+b)/2$.

*Proof.* If $Kv=bv$, equality in the Rayleigh bound gives $Dv=bv$, and then $Qv=0$ and $K^*v=bv$. Thus this eigenspace and its orthogonal complement reduce all the matrices. It is semisimple: a generalized eigenvector with $(K-bI)w=v\ne0$ would give $v^*(K-bI)w=0=\|v\|^2$, a contradiction. Its dimension is therefore the multiplicity $n-k$ in (4.8).

On the complement, write again $D=bI-\delta P$, now with projection ranks $r,k-r$. On the eigenspace for $\lambda\in(a,b)$, both $P$ and $I-P$ are injective. Indeed, a nonzero vector in the kernel of either projection would have Rayleigh quotient $b$ or $a$, whereas its quotient must be $\lambda$. This proves (5.1).

The algebraic multiplicity $M$ of $g$ is $k-1$ if $\rho\lt \varepsilon$ and $k$ if $\rho=\varepsilon$. At a threshold $M\gt \min(r,k-r)$. Off thresholds, the same inequality holds for $k\ge3$, because $k-1\gt \lfloor k/2\rfloor$. Since $g\gt a$ implies $k\ge r+1$, the only remaining case is $r=1,k=2,\rho\lt \varepsilon$, precisely the interval stated. There the spectrum $g,a+b-g,b,\ldots,b$ is semisimple: its two active eigenvalues are distinct and the $b$ eigenspace is already reducing and semisimple. $\square$

The dimension $k$ is the size of the active reducing block, not the rank of $Q$, whose rank is necessarily even. The largest critical Jordan block has size at least
$\lceil M/\min(r,k-r)\rceil$, since the number of its blocks is the geometric multiplicity.

For $r=1$, (5.1) gives an exact classification. On $g_{k-1}\lt g\lt g_k$, $k\ge3$, there is one Jordan block of size $k-1$ at $g$ and a simple eigenvalue $b-\rho\gt g$. At $g=g_k$, $k\ge2$, there is one block of size $k$. The other eigenvalues are the semisimple inactive $b$ modes. At $g=a$, the unique optimizer is $Q=0$.

To distinguish an asymptotic exponent from a bound at that exponent, define

$$
G_D(g)=\inf\left\{\sigma_D(Q):
Q^\top=-Q,\ \exists C\lt \infty\
\forall t\ge0,\ 
\|e^{-(D+Q)t}\|_2\le Ce^{-gt}\right\}.
\tag{5.2}
$$

The constant $C$ may depend on $Q$ and $g$; it is not prescribed.

**Lemma 5.2 (critical semisimplicity).** The bound in (5.2) holds if and only if every eigenvalue has real part at least $g$ and every eigenvalue with real part exactly $g$ is semisimple. Moreover,

$$
\lim_{t\to\infty}-\frac1t\log\|e^{-Kt}\|_2
=\gamma_D(Q).
\tag{5.3}
$$

*Proof.* In a Jordan basis a block of size $h$ contributes $e^{-\lambda t}$ times a matrix polynomial of degree $h-1$. A strict real-part margin absorbs the polynomial, whereas a nonconstant polynomial at real part $g$ is unbounded after multiplication by $e^{gt}$. An eigenvalue below $g$ also violates the bound. These observations prove both directions of the first assertion. They give the upper asymptotic estimate in (5.3), while the spectral radius of $e^{-Kt}$, equal to $e^{-\gamma_D(Q)t}$, gives the reverse estimate. $\square$

**Theorem 5.3 (the same infimum, different attainment).** Under (4.1), $G_D(g)=F_D(g)$ for every real $g$, including the infeasible range. The common finite value is attained under the constraint (5.2) precisely when either $g\le a$, or

$$
r=1,\qquad a\lt g\lt \frac{a+b}{2}.
\tag{5.4}
$$

In particular, at the maximal rate $\mu$ the infimum is finite but is not attained.

*Proof.* The envelope constraint implies the spectral constraint, so $G_D(g)\ge F_D(g)$. The cases $g\le a$ and $g\gt \mu$ follow from Lemmas 2.1 and 5.2. For $a\lt g\lt \mu$, choose $h\gt g$ decreasing to $g$ and take a spectral minimizer at rate $h$. Lemma 5.2 makes it feasible for (5.2) at rate $g$, irrespective of its Jordan structure. Continuity of $F_D$ gives $G_D(g)\le F_D(g)$.

The endpoint $g=\mu$ requires a separate construction. By Lemma 4.2 choose an orthogonal conjugate $H$ of $D$ with every diagonal entry equal to $\mu$. Let $S_0$ be its triangular realization, so $H+S_0$ has all eigenvalues $\mu$ and cost $F_D(\mu)$ after conjugation back.

Partition the coordinates into consecutive pairs and, if necessary, one singleton. For pair $j$, write $h_j$ for the corresponding off-diagonal entry of $H$. Choose positive, pairwise distinct frequencies $\omega_j$ and set

$$
q_j=\operatorname{sgn}_+(h_j)\sqrt{h_j^2+\omega_j^2},
\qquad
\operatorname{sgn}_+(h)=
\begin{cases}\operatorname{sgn}(h),&h\ne0,\\1,&h=0.\end{cases}
\tag{5.5}
$$

Replace only the within-pair entry of $S_0$ by $q_j$, retaining antisymmetry and all cross-pair entries. The resulting $H+S_\omega$ is block upper triangular, with diagonal blocks

$$
\begin{pmatrix}
\mu&h_j+q_j\\
h_j-q_j&\mu
\end{pmatrix}
\tag{5.6}
$$

having eigenvalues $\mu\pm i\omega_j$. A singleton contributes $\mu$. These eigenvalues are all distinct, so the matrix is diagonalizable over $\mathbb C$ and satisfies a finite-prefactor envelope at rate $\mu$. Conjugation back gives a feasible $Q_\omega$ for the original $D$. Formula (4.2) evaluates its cost exactly:

$$
\sigma_D(Q_\omega)=F_D(\mu)
+\frac{2(a+b-\mu)}{ab}\sum_j\omega_j^2.
\tag{5.7}
$$

Letting the frequencies tend to zero with distinct positive ratios proves equality of the infima at $\mu$.

For attainment in the interior, a matrix attaining $G_D(g)=F_D(g)$ must be a spectral minimizer. Proposition 5.1 and Lemma 5.2 exclude all cases except (5.4), where the semisimple two-mode minimizer attains the value. At $\mu$, equality in Theorem 4.3 forces the constant real spectrum $\mu$. The envelope would then require the entire matrix to be semisimple, hence $K=\mu I$. Its symmetric part would give $D=\mu I$, contradicting (4.1). $\square$

The constants in the endpoint approximations need not remain bounded as $\omega\to0$. This is consistent with the loss of attainment. The basic importance of prefactors is already explicit in [1]; Theorem 5.3 determines the exact dissipation infimum and equality obstruction for the present constrained problem.

For completeness, if $D=aI$, then $e^{-(aI+Q)t}=e^{-at}e^{-Qt}$ and $e^{-Qt}$ is orthogonal. Hence $G_D(g)=F_D(g)=0$ for $g\le a$, attained by $Q=0$, and both values are $+\infty$ for $g\gt a$.

Finally, no antisymmetric perturbation improves the Euclidean contraction rate when the prefactor must equal one. Indeed,

$$
\frac{d}{dt}\|e^{-Kt}x\|^2
=-2(e^{-Kt}x)^\top D(e^{-Kt}x)
\le-2a\|e^{-Kt}x\|^2,
\tag{5.8}
$$

so $\|e^{-Kt}\|_2\le e^{-at}$. Conversely, the derivative at $t=0$ along an $a$ eigenvector equals $-2a\|x\|^2$, ruling out such a bound with any exponent larger than $a$. For Gaussian initial data $N(m_0,I)$ the relative entropy to $\pi$ is $\|e^{-Kt}m_0\|^2/2$, so the same observation rules out a universal prefactor-one relative-entropy rate larger than $2a$.

## 6. The complete three-dimensional frontier

Now let $D=\operatorname{diag}(a,b,c)$ with $0\lt a\le b\le c$ and $c\gt a$. Set

$$
h=\frac{a+b}{2},\qquad
\mu=\frac{a+b+c}{3},\qquad
w_{12}=\frac1a+\frac1b,\quad
w_{13}=\frac1a+\frac1c,\quad
w_{23}=\frac1b+\frac1c.
\tag{6.1}
$$

Orthogonal conjugation covers every positive definite three-dimensional diffusion matrix.

**Theorem 6.1 (three-dimensional frontier).** For $a\le g\le\mu$,

$$
\boxed{
F_D(g)=
\begin{cases}
F_1(g):=w_{12}(g-a)(b-g),&a\le g\le h,\\[1mm]
F_2(g):=\displaystyle
w_{12}\frac{(g-a)^2(b+c-2g)}{c-a}
+w_{23}\frac{(c-g)^2(2g-a-b)}{c-a},
&h\le g\le\mu.
\end{cases}}
\tag{6.2}
$$

Both minima are attained. Writing $x=q_{12}^2$, $y=q_{13}^2$, $z=q_{23}^2$, one minimizing choice is

$$
(x,y,z)=((g-a)(b-g),0,0)
\quad(a\le g\le h),
\tag{6.3}
$$

and

$$
(x,y,z)=
\left(
\frac{(g-a)^2(b+c-2g)}{c-a},\
0,\
\frac{(c-g)^2(2g-a-b)}{c-a}
\right)
\quad(h\le g\le\mu).
\tag{6.4}
$$

The respective spectra are $\{g,a+b-g,c\}$ and
$\{g,g,a+b+c-2g\}$. If $a\lt b\lt c$, every minimizer has exactly the squares (6.3) or (6.4), including the endpoints; the nonzero signs are arbitrary. The value formulas remain valid when diffusion eigenvalues coincide, but coordinatewise uniqueness is not asserted then.

*Proof.* Put

$$
\alpha=a-g,\qquad \beta=b-g,\qquad \chi=c-g,
$$

$$
V=\alpha\beta+\alpha\chi+\beta\chi+x+y+z,\qquad
W=\alpha\beta\chi+\chi x+\beta y+\alpha z.
\tag{6.5}
$$

The characteristic polynomial of the shifted drift is

$$
\det(sI+K-gI)=
s^3+(a+b+c-3g)s^2+Vs+W.
\tag{6.6}
$$

Every feasible matrix has $V,W\ge0$. To see this without a stability criterion, let the eigenvalues of $K-gI$ be considered directly. If all three are real, they are nonnegative and so are their pairwise-product sum and product. Otherwise they are $t,u+iv,u-iv$ with $t,u\ge0$, and
$V=2tu+u^2+v^2\ge0$, $W=t(u^2+v^2)\ge0$.

For the first interval, direct expansion gives

$$
\sigma_D(Q)-F_1(g)=
\frac{w_{12}}{\chi}W+
\left(w_{13}-\frac{w_{12}\beta}{\chi}\right)y+
\left(w_{23}-\frac{w_{12}\alpha}{\chi}\right)z.
\tag{6.7}
$$

Here $\chi\gt 0$, $\alpha\le0$, and

$$
w_{13}-\frac{w_{12}\beta}{\chi}
=\frac{(c-b)(bc+ag)}{abc(c-g)}\ge0,\qquad
w_{23}-\frac{w_{12}\alpha}{\chi}\gt 0.
\tag{6.8}
$$

Thus (6.7) is a nonnegative lower-bound certificate. The squares (6.3) yield the displayed real spectrum, which is feasible because $g\le h$ and $c\ge g$, and their cost is $F_1(g)$.

For the second interval there is the identity

$$
\boxed{
\sigma_D(Q)-F_2(g)=
\frac{ac+bg}{abc}V+\frac1{ac}W+
\frac{(b-a)(c-b)}{abc}y.}
\tag{6.9}
$$

It follows by substituting (6.5) and collecting the coefficients of $x,y,z$ and the constant term. All coefficients are nonnegative, and the first two are strictly positive. The proposed squares (6.4) are nonnegative since $b+c-2g\gt 0$ and $2g-a-b\ge0$. They give $V=W=0$, so (6.6) becomes $s^2(s+a+b+c-3g)$. This proves feasibility and equality throughout the closed interval, including $g=\mu$. No limiting argument at that endpoint is required.

If $a\lt b\lt c$, equality in (6.7) forces $y=z=0$ and $W=0$, hence (6.3). Equality in (6.9) forces $y=V=W=0$; the two remaining linear equations determine $x,z$ uniquely because their coefficient determinant is $a-c\ne0$. This gives (6.4), also at $\mu$. Each choice of signs is feasible because the characteristic polynomial depends only on the squares. For repeated diffusion eigenvalues the same nonnegative certificates remain valid, while one reduced coefficient may vanish. $\square$

For simple diffusion spectra, the first optimizer acts only on the two slowest eigendirections. At $g=h$ this block has a double eigenvalue and a nontrivial Jordan block. For $h\lt g\lt \mu$, both $x,z$ in (6.4) are positive, and $K-gI$ has rank two: its first and third rows are independent since $\alpha\ne0$ and $\chi\ne0$. Thus the double eigenvalue $g$ has one Jordan block of size two. At $g=\mu$ the same rank calculation gives one block of size three.

The two formulas agree at $h$. Their derivatives are

$$
F_1'(g)=w_{12}(a+b-2g),\qquad
F_2'(g)=
\frac{2(ac+bg)(a+b+c-3g)}{abc}.
\tag{6.10}
$$

Consequently $F_D$ is continuous and strictly increasing on $[a,\mu]$, and the budget frontier is given by the inverse and saturation formula (4.13), with the present $F_D,\mu$. The first recruitment budget is

$$
B_1=F_D(h)=\frac{(a+b)(b-a)^2}{4ab}.
\tag{6.11}
$$

For $a\lt b\lt c$, every optimizer at $0\lt B\lt B_1$ has exactly two-mode support. For $B_1\lt B\le F_D(\mu)$ it has the three-mode path support (6.4). Beyond saturation one may retain a minimum-cost maximal-rate optimizer. Thus sequential recruitment and an exact initial two-mode interval, as stated in Conjectures 287 and 289 of [8], hold in dimension three. The two-mode formula itself is the existing pair calibration in [8]; the new assertion here is its global optimality against every three-dimensional perturbation and its continuation through the second phase.

## 7. Curvature classification and a rational counterexample

Assume $0\lt a\lt b\lt c$. At budgets below saturation, $\Gamma_D=F_D^{-1}$. For an open phase,

$$
\Gamma_D''(B)=
-\frac{F_D''(g)}{(F_D'(g))^3},
\qquad g=\Gamma_D(B).
\tag{7.1}
$$

The first arc is strictly convex, since $F_1''=-2w_{12}\lt 0$. The second arc admits a complete classification.

**Theorem 7.1 (curvature of the three-mode arc).** Define

$$
\Xi=c(b-3a)-2b(a+b),\qquad
g_0=\frac{b(a+b+c)-3ac}{6b}.
\tag{7.2}
$$

If $\Xi\le0$, $\Gamma_D$ is strictly convex throughout
$F_D(h)\lt B\lt F_D(\mu)$.
If $\Xi\gt 0$, then $h\lt g_0\lt \mu$ and $\Gamma_D$ is strictly concave for
$F_D(h)\lt B\lt F_D(g_0)$ and strictly convex for
$F_D(g_0)\lt B\lt F_D(\mu)$, with zero second derivative at the separating budget.

*Proof.* Differentiating (6.10) gives

$$
F_2''(g)=
\frac{2[b(a+b+c)-3ac-6bg]}{abc}
=\frac{12(g_0-g)}{ac}.
\tag{7.3}
$$

Its sign changes at most once. Also
$6b(g_0-h)=\Xi$ and
$6b(\mu-g_0)=b(a+b+c)+3ac\gt 0$.
Combining these facts with (7.1) and $F_2'(g)\gt 0$ proves the classification. $\square$

Equivalently, a concave segment exists exactly when
$b\gt 3a$ and $c\gt 2b(a+b)/(b-3a)$.
The active set remains all three coordinates across the inflection point. Hence this is a change in returns to dissipation within one optimizer architecture.

**Corollary 7.2 (failure of fixed-support convexity).** The fixed-support convexity assertion in Conjecture 288 of Cheong [8] is false, already for $D=\operatorname{diag}(1,4,100)$.

*Proof.* Here $h=5/2$, $\mu=35$, and $g_0=5$. Theorem 7.1 already gives a strictly concave budget–rate segment for target rates $5/2\lt g\lt 5$. An independent exact midpoint certificate follows directly from Theorem 6.1:

| Target $g$ | $q_{12}^2$ | $q_{23}^2$ | Minimum cost $F_D(g)$ |
|---:|---:|---:|---:|
| $3$ | $392/99$ | $9409/99$ | $1483/50$ |
| $4$ | $96/11$ | $3072/11$ | $2088/25$ |
| $5$ | $1504/99$ | $45125/99$ | $275/2$ |

In every row $q_{13}=0$, and the two displayed couplings are strictly positive throughout $3\le g\le5$. However,

$$
\frac{F_D(3)+F_D(5)}2=\frac{4179}{50}
\gt \frac{4176}{50}=F_D(4).
\tag{7.4}
$$

Strict monotonicity therefore gives

$$
\Gamma_D\!\left(\frac{F_D(3)+F_D(5)}2\right)
\gt 4=
\frac{\Gamma_D(F_D(3))+\Gamma_D(F_D(5))}{2},
\tag{7.5}
$$

contradicting convexity on this single fixed-support arc. $\square$

This counterexample concerns the convexity clause of the cited conjecture. In the three-dimensional problem, continuity, finite saturation, and downward resets of the marginal budget gain at recruitment and saturation still hold: (6.10) gives a zero left derivative of $F_D$ at $h$, a positive right derivative there, and a zero left derivative at $\mu$. The second phase itself may nevertheless begin with diminishing marginal gains.

## 8. Scope and implications

The classification in Theorem 3.1 explains why the two-eigenvalue problem admits a spectral optimization without additional eigenvector data, while the three-eigenvalue problem generally does not. The exact three-dimensional certificates then show how non-spectral coupling information can restore solvability beyond that class. For general heterogeneous diffusion spectra in dimensions greater than three, this paper gives neither a full frontier nor a sequential recruitment theorem.

Real spectra minimize dissipation in the two-eigenvalue problem, but their repeated slow eigenvalues usually force nontrivial Jordan blocks. The resulting polynomial factors do not change the asymptotic spectral exponent. They do change attainability when an exponential envelope is demanded at precisely that exponent. Theorem 5.3 quantifies this distinction without assuming a uniform bound on the allowed prefactor.

The trace ceiling, the standard entropy-production normalization, and the Schur–Horn realization are established ingredients. The conclusions obtained here are the spectral-determinacy classification, the exact constrained thermodynamic frontiers and their equality structure, the finite-prefactor infimum classification, and the curvature obstruction exhibited above. A complete machine-checked formalization of these results has not been provided.

## References

[1] T. Lelièvre, F. Nier, and G. A. Pavliotis. Optimal non-reversible linear drift for the convergence to equilibrium of a diffusion. *Journal of Statistical Physics* **152**, 237–274 (2013). [doi:10.1007/s10955-013-0769-x](https://doi.org/10.1007/s10955-013-0769-x). [Author manuscript](https://arxiv.org/abs/1212.0876).

[2] A. B. Duncan, T. Lelièvre, and G. A. Pavliotis. Variance reduction using nonreversible Langevin samplers. *Journal of Statistical Physics* **163**, 457–491 (2016). [doi:10.1007/s10955-016-1491-2](https://doi.org/10.1007/s10955-016-1491-2). [Author manuscript](https://arxiv.org/abs/1506.04934).

[3] L. Da Costa and G. A. Pavliotis. The entropy production of stationary diffusions. *Journal of Physics A: Mathematical and Theoretical* **56**, 365001 (2023). [doi:10.1088/1751-8121/acdf98](https://doi.org/10.1088/1751-8121/acdf98). [Author manuscript](https://arxiv.org/abs/2212.05125).

[4] Y. V. Fyodorov, E. Gudowska-Nowak, M. A. Nowak, and W. Tarnowski. Nonorthogonal eigenvectors, fluctuation-dissipation relations, and entropy production. *Physical Review Letters* **134**, 087102 (2025). [doi:10.1103/PhysRevLett.134.087102](https://doi.org/10.1103/PhysRevLett.134.087102).

[5] R. Nagayama, A. Kolchinsky, and S. Ito. Oscillatory-nonnormal decomposition of dissipation in Ornstein–Uhlenbeck processes. *arXiv:2606.07263v2* (2026). [Full text](https://arxiv.org/html/2606.07263v2).

[6] Q. J. Zhu, Y. Marzouk, K. Spiliopoulos, and B. Zhang. Optimizing irreversible perturbations of the unadjusted Langevin algorithm. *arXiv:2606.05324v1* (2026), Sections 3.2–3.4 and Appendix C.2. [Full text](https://arxiv.org/html/2606.05324v1).

[7] A. Horn. Doubly stochastic matrices and the diagonal of a rotation matrix. *American Journal of Mathematics* **76**, 620–630 (1954). [doi:10.2307/2372705](https://doi.org/10.2307/2372705).

[8] B. Cheong. *Conjecture Engine: Four hundred fifty-nine conjectures in mathematics*. Self-published online collection (2026), Part XVI, pair-calibration proposition and Conjectures 287–289. [Online text](https://translorentz.github.io/conjecture-engine/), accessed 26 November 2026. [Fixed source version](https://github.com/translorentz/conjecture-engine/blob/d31e1a2fcd5a1932ad595525da4df762f2108f5b/paper/conjectures.tex).
