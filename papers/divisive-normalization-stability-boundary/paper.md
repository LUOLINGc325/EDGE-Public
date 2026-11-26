# Stability boundaries of divisive-normalization circuits: exact recurrence classifications and norm-one counterexamples

**Research draft — 26 November 2026.** The results below are written mathematical arguments, subject to independent scrutiny. External peer review and formal proof-assistant verification have not been completed.

## Abstract

We study the main ORGaNICs equation and its conjectured stable-equilibrium guarantee from unit spectral-norm recurrence. Positive dense rational counterexamples refute this guarantee through nonexistence or a unique unstable equilibrium, with full-parameter persistence. We then classify two exact architectural guarantees. For an arbitrary fixed real recurrent matrix, every choice of nonnegative pooling, positive baselines, heterogeneous positive time constants and real input has exactly one equilibrium, which is locally exponentially stable, if and only if recurrence is diagonal with entries in $(0,1]$. Every off-diagonal matrix admits an explicit hyperbolic saddle; the result does not classify the weaker universal existence of at least one stable equilibrium. For diagonal entries in $[0,1]$, a zero-coordinate feedback spectral radius gives the exact feasibility threshold, and an explicit parameter-only certificate bounds the full Jacobian's spectral abscissa. With shared uniform pooling and common time constants, recurrence may instead be any real normal matrix: the universal unique stable-equilibrium property holds exactly when its spectrum is nonzero and satisfies $\operatorname{Re}\lambda\geq|\lambda|^2$ and $|\operatorname{Im}\lambda|\leq\operatorname{Re}\lambda$. A strictly positive three-dimensional example has norm one, positive spectral real parts and positive input, yet a unique oscillatory unstable equilibrium. We also give the singular-input budget, all constant-input negative-mode branches, their nonlinear critical boundary, and a general-pooling obstruction for negative identity recurrence. All stability conclusions concern equilibria and local dynamics; no global attraction, periodic-orbit existence or learning-performance improvement is asserted.

## 1. Problem, model and contribution boundary

Let $n\geq1$, write $\mathbf1=(1,\ldots,1)^\top$, and let $a_+$ denote coordinatewise positive part. Products and powers of vectors are coordinatewise unless explicitly indicated. Vector norms are Euclidean, and $\|R\|_2$ is the induced Euclidean operator norm. We consider

$$
T_y\dot y=-y+u+D(\mathbf1-\sqrt{a_+})Ry,
\qquad
T_a\dot a=-a+c+W(a_+\odot y^2),                       \tag{1}
$$

where $y,a\in\mathbb R^n$, $T_y,T_a$ are positive diagonal matrices, $c_i>0$, $W_{ij}\geq0$, and $R$ is real. Here $D(v)$ is the diagonal matrix with diagonal $v$. In the source notation, $u=b\odot z$ and $c=b_0^2\odot\sigma^2$, with $b,b_0,\sigma$ strictly positive. There are no upper bounds on those positive parameters in the stated conjecture. Any finite input $u$ is representable with $\|z\|_2\leq1$: choose $b=B\mathbf1$ with $B\geq\max(1,\|u\|_2)$ and put $z=u/B$.

Rawat, Heeger and Martiniani [1, Eq. (15), Conjecture 5.3] ask whether $\|R\|_2=1$ and $\|z\|_2\leq1$ guarantee at least one asymptotically stable fixed point for all remaining admissible parameters. Their established identity-recurrence result and positive-scalar-recurrence results remain intact. We address their main equation (1), not the different recurrence-rectified vector field in their Appendix F.

**Lemma 1 (equilibrium positivity).** Every equilibrium of (1) satisfies $a_i\geq c_i>0$. If $W_{ii}>0$, it also satisfies

$$
|y_i|< W_{ii}^{-1/2},\qquad
a_i\geq\frac{c_i}{1-W_{ii}y_i^2}.                    \tag{2}
$$

*Proof.* At equilibrium, $a_i=c_i+\sum_jW_{ij}(a_j)_+y_j^2\geq c_i$. The rectifier can therefore be removed in all equilibrium equations. Keeping just the $j=i$ summand gives $(1-W_{ii}y_i^2)a_i\geq c_i>0$, which proves (2). In particular, the vector field is smooth in a neighborhood of every equilibrium. $\square$

Throughout, **locally exponentially stable** means exponential attraction for all sufficiently small perturbations of the full state $(y,a)$. A **Hurwitz** matrix has every eigenvalue in the open left half-plane. A positive-real-part eigenvalue implies Lyapunov instability of these smooth local systems. A zero eigenvalue alone implies neither stability nor instability.

For the spectral results in Sections 4–6 and 9, we also use the explicitly restricted shared-pooling family

$$
T_y=\tau_y I,\quad T_a=\tau_a I,\quad c=c_0\mathbf1,
\quad W=k\mathbf1\mathbf1^\top,\quad k=\frac wn,
\quad c_0,w,\tau_y,\tau_a>0.                         \tag{3}
$$

We subsequently write $c$ for the scalar $c_0$. This is still the full $2n$-state system: a common inhibitory state is an invariant manifold, not an assumption imposed on every initial condition. Theorems 5–8 and 15 use (3); Theorem 15 replaces symmetry by real normality. Theorems 11–14 return to the full arbitrary-pooling model (1), with unequal baseline coordinates and heterogeneous time constants. Theorem 4 allows general nearby parameters, and Theorem 10 uses general pooling under its own assumptions. In Theorems 14–15, “exactly one equilibrium, and it is stable” is not shorthand for “exactly one stable equilibrium.”

### 1.1 Relation to earlier work

The normalization architecture, its biological motivation and the identity-recurrence stability theorem belong to [1]; the earlier ORGaNICs framework is due to Heeger and Mackey [2]. The identity theorem already permits arbitrary nonnegative pooling and heterogeneous positive time constants. Theorem 14 extends that positive result to all diagonal entries in $(0,1]$ while retaining those parameter freedoms, and proves that this is the complete recurrent-matrix class for the stated universal uniqueness-and-stability property.

Morone et al. [3,4] already study instability, critical slowing and loss of normalization. Their Eq. (3) uses a shared inhibitor; the final accepted author manuscript and its complete associated supplement analyze symmetric Gaussian perturbations of identity and discuss a nonsymmetric stabilization mechanism qualitatively. Both that 2026 version and the earlier 2025 preprint were inspected. Shared inhibition, normalization-related instability and the use of spectra are not new. Our real-normal result supplies a deterministic necessary-and-sufficient complex-spectral region for a different, fully quantified property; it is not a new attribution of those mechanisms.

McClain et al. [5, Eqs. (2)–(8)] use eigenmode coordinates, active-mode branches and block Jacobians for a different shared-gain model: its gain is $1-a$, deterministic input is zero, and the analyzed positive leading-mode regime has $0< \sigma^2< 1$ and $a_*< 1$. Pal et al. [6] study hierarchical rectified circuits and communication subspaces. Other normalization models already have arrowhead Jacobians, stable input equilibria, single-pair global results, or trained slow-manifold analyses [10–12]; their rational-gain equations differ from (1). We make no priority claim for modal decomposition, shared pooling, local perturbation arguments or normalization-stability theory in general.

For the diagonal static map in Section 8, the general asymptotic-spectral-radius feasibility theorem and uniqueness principle are prior results [8, Proposition 4 and Fact 1]; geometric convergence of positive concave fixed-point iteration is also known [9, Proposition 3]. Those results do not themselves prove stability of the complete neural ODE. The contributions evaluated here are the precise conjecture refutation, the complete full-model universal architecture classification and its explicit off-diagonal obstruction, the parameter-only ODE spectral margin, the real-normal complex-spectral classification, and the stated nonlinear boundary results. The spectral theorem, positive-real and modulus comparisons, Perron–Frobenius theory, Brouwer's theorem, the implicit-function theorem and local ODE theory are classical tools, not proposed new general methods.

## 2. Two positive dense counterexamples

Let $J_2=\mathbf1\mathbf1^\top\in\mathbb R^{2\times2}$.

**Theorem 2 (two distinct failures within the conjectured domain).** Both of the following parameter choices satisfy $\|R\|_2=1$, $\|z\|_2< 1$, strict positivity of every entry of $R$ and $W$, and strict positivity of all required scalar parameters. Set $T_y=T_a=I$, $b=b_0=\sigma=\mathbf1$, so $u=z$ and $c=\mathbf1$.

**(a) No equilibrium.** Take

$$
R=\frac12J_2,\qquad W=16J_2,\qquad
z=\begin{pmatrix}3/4\\1/4\end{pmatrix}.              \tag{4}
$$

**(b) A unique unstable equilibrium.** Take

$$
R=\begin{pmatrix}1/4&3/4\\3/4&1/4\end{pmatrix},
\qquad W=30J_2,\qquad z=\frac12\mathbf1.             \tag{5}
$$

The only equilibrium in (b) is

$$
y_* =\frac18\mathbf1,\qquad a_*=16\mathbf1.          \tag{6}
$$

Its Jacobian has eigenvalues

$$
\frac12,\quad -1,\quad
\frac{-65+\sqrt{129}}{32},\quad
\frac{-65-\sqrt{129}}{32}.                           \tag{7}
$$

*Proof.* In both examples the pooling rows and baseline coordinates are equal. Every equilibrium therefore has $a=s^2\mathbf1$ for some $s>0$.

For (a), $R$ is the orthogonal projection onto the constant vectors. Projecting the first equilibrium equation onto $\ker R$ gives

$$
P_{\ker R}y=P_{\ker R}u=\tfrac14(1,-1)^\top.
$$

Hence $\|y\|_2^2\geq1/8$. The second equilibrium equation would require

$$
1=\frac1{s^2}+16\|y\|_2^2>2,
$$

an impossibility. The recurrence eigenvalues are $1,0$, and $\|z\|_2^2=5/8$.

For (b), write $y=x\mathbf1+r(1,-1)^\top$. The recurrence eigenvalues are $1,-1/2$, and the first equilibrium equation becomes

$$
sx=\tfrac12,\qquad \frac{3-s}{2}r=0.                \tag{8}
$$

If $s\ne3$, then $r=0$ and $s^2=1+60(1/2)^2=16$, which gives (6). If $s=3$, then $x=1/6$ and the second equation would imply

$$
9=1+60\cdot9(x^2+r^2)=16+540r^2,
$$

again impossible. This proves uniqueness over the entire state space, not only over positive $y$.

At (6), the common-inhibitor and constant-response block of the Jacobian is

$$
\begin{pmatrix}-4&-1/64\\240&-1/16\end{pmatrix},     \tag{9}
$$

with characteristic polynomial $t^2+(65/16)t+4$. The response-difference eigenvalue is $1/2$ and the inhibitor-difference eigenvalue is $-1$. This gives (7). Finally $\|z\|_2^2=1/2$ in (b). All remaining assertions are visible in (4)–(5). $\square$

The second example has a positive, nonsingular recurrent matrix. Its destabilizing mode is a negative **eigenvalue**, not a negative matrix entry. Equal input gains and baseline gains are already present: $b=b_0=1$. These examples disprove the original existence conjecture without altering the source model or its input-norm constraint.

## 3. Robustness in the full parameter space

The rank-one pooling and exact symmetry in (5) permit an explicit calculation. They are not necessary for the obstruction to persist.

**Lemma 3 (uniform compactness of all equilibria).** Consider any set of parameters in (1) for which

$$
0< c_-\leq c_i\leq c_+,\quad
0< m\leq W_{ij}\leq M,\quad
\sigma_{\min}(R)\geq r_0>0,\quad \|u\|_2\leq U.
                                                               \tag{10}
$$

Put $\eta=m/M$ and

$$
T=1+\frac{1+\sqrt{2M}\,U}{r_0},\qquad
C=\max\{2c_+,\,2T^2/\eta\}.                         \tag{11}
$$

Every equilibrium belongs to the same compact box

$$
|y_i|\leq m^{-1/2},\qquad c_-\leq a_i\leq C.         \tag{12}
$$

*Proof.* The response bound follows from Lemma 1. Let $A=\max_i a_i$ and $Q=\sum_j a_jy_j^2$. The equilibrium equations give $A\leq c_++MQ$ and $\min_i a_i\geq c_-+mQ$. Therefore, if $A>2c_+$,

$$
\min_i a_i\geq c_-+\eta(A-c_+)>\eta A/2.             \tag{13}
$$

Suppose also that $A>2T^2/\eta$. Then $s_{\min}:=\min_i\sqrt{a_i}>T>1$. The first equilibrium equation is

$$
D(\sqrt a-\mathbf1)Ry=u-y.
$$

Consequently

$$
[r_0(s_{\min}-1)-1]\|y\|_2\leq U.                   \tag{14}
$$

If $U>0$, (11)–(14) imply $M\|y\|_2^2< 1/2$. If $U=0$, the positive coefficient in (14) gives $y=0$, so the same strict inequality holds. But then

$$
A\leq c_++MA\|y\|_2^2< c_++A/2,
$$

contradicting $A>2c_+$. Thus $A\leq C$. $\square$

**Theorem 4 (an open family with no stable equilibrium).** Fix $n=2$. There is a neighborhood of the parameters (5) in the full parameter space of (1) such that every system in that neighborhood has exactly one equilibrium and that equilibrium is hyperbolic with one unstable and three stable directions. The neighborhood permits nonsymmetric recurrence, unequal baselines, arbitrary positive dense pooling and heterogeneous positive time constants. Its intersection with $\|R\|_2=1$ and $\|z\|_2< 1$ is a nonempty relative-open family of counterexamples to Conjecture 5.3.

*Proof.* Strict positivity and invertibility at (5) allow a sufficiently small parameter neighborhood satisfying common bounds (10), as well as uniform positive lower and finite upper bounds on the time constants and gains. Lemma 3 bounds **every** equilibrium of every such system in a common compact subset of $a_i>0$.

The full vector field is smooth on that subset. Its state derivative at (6) is nonsingular by (7). The implicit-function theorem therefore gives a unique nearby equilibrium for every sufficiently close parameter vector. Suppose there were additional equilibria for parameters converging to (5). Compactness would yield a convergent subsequence. Continuity makes its limit an equilibrium of the base system, hence (6) by Theorem 2. Eventually that subsequence lies in the neighborhood of uniqueness given by the implicit-function theorem, a contradiction. Thus the nearby equilibrium is the only one.

Hyperbolicity and the count of eigenvalues in the right half-plane persist under sufficiently small matrix perturbations. This proves the stated instability. The original source parameters map continuously to $(u,c,T_y,T_a,R,W)$, and the base input lies strictly inside its unit ball. Intersect the neighborhood with the exact spectral-norm constraint. This relative-open set contains nonsymmetric and non-rank-one pooling perturbations: for instance, small arbitrary recurrence perturbations can be rescaled by their positive spectral norm, and sufficiently small positive pooling perturbations preserve positivity. $\square$

This proof establishes the existence of a neighborhood. It does not certify a numerical perturbation radius. It also does not claim divergence, oscillation, or chaos for every trajectory.

## 4. Shared pooling: the exact reduction

Assume (3). The inhibitor differences satisfy the exact identities

$$
\tau_a\frac{d}{dt}(a_i-a_j)=-(a_i-a_j).              \tag{15}
$$

Thus all equilibria have $a=s^2\mathbf1$, with $s\geq\sqrt c$, and the common-inhibitor manifold is invariant. At equilibrium,

$$
K(s)y=u,\qquad
K(s):=I-(1-s)R,\qquad
1=\frac c{s^2}+k\|y\|_2^2.                         \tag{16}
$$

Assume now that $R=R^\top$ and $\|R\|_2\leq1$. Choose an orthonormal eigenbasis and write its eigenvalues as $\lambda_j\in[-1,1]$ and input coordinates as $u_j$. The scalar multipliers of $K(s)$ are

$$
g_j(s)=1-\lambda_j+\lambda_j s.                     \tag{17}
$$

When $0\leq\lambda_j\leq1$, $g_j(s)>0$ for $s>0$. A negative eigenvalue has exactly one positive zero,

$$
s_\lambda=1-\frac1\lambda\geq2.                    \tag{18}
$$

The quotient dynamics (15) contributes $n-1$ eigenvalues $-1/\tau_a$ to every equilibrium linearization. This statement concerns an invariant subspace and its quotient; no invariance of its orthogonal complement is being assumed. On the common-inhibitor manifold, the Jacobian is

$$
\mathcal J=
\begin{pmatrix}
-K(s)/\tau_y&-Ry/(2s\tau_y)\\
2ks^2y^\top/\tau_a&-c/(s^2\tau_a)
\end{pmatrix}.                                    \tag{19}
$$

The last entry follows from the equilibrium identity in (16).

## 5. Positive spectra and the exact kernel-drive budget

**Theorem 5 (sharp semidefinite criterion).** Under (3), let $R$ be symmetric positive semidefinite with $\|R\|_2\leq1$, and let $P_0$ be its orthogonal kernel projection. Define

$$
\beta=k\|P_0u\|_2^2.                               \tag{20}
$$

If $\beta\geq1$, the system has no equilibrium. If $\beta< 1$, it has exactly one equilibrium, and this equilibrium is locally exponentially stable in the full $2n$-state system for every pair $\tau_y,\tau_a>0$. It is obtained from the unique root $s\geq\sqrt c$ of

$$
F(s):=\frac c{s^2}+
k\sum_{j=1}^n\frac{u_j^2}{(1-\lambda_j+\lambda_js)^2}=1,
\qquad y_j=\frac{u_j}{1-\lambda_j+\lambda_js}.       \tag{21}
$$

*Proof of existence and uniqueness.* Each denominator is positive. The term $c/s^2$ is strictly decreasing, and all other terms are nonincreasing. Hence $F$ is strictly decreasing. Its value at $\sqrt c$ is at least one, with equality exactly when $u=0$. Its limit at infinity is $\beta$. If $\beta< 1$, the intermediate-value theorem gives one and only one root, including $s=\sqrt c$ when $u=0$. Conversely, projecting $K(s)y=u$ onto the kernel gives $P_0y=P_0u$, so every equilibrium must satisfy

$$
1=\frac c{s^2}+k\|y\|_2^2>\beta.
$$

This rules out equality as well as supercritical budgets.

*Proof of local stability.* Work in the eigenbasis of $R$ in (19). A zero-eigenvalue coordinate has upper coupling to the common inhibitor equal to zero and its own eigenvalue $-1/\tau_y$. After separating those coordinates the matrix is block triangular, leaving the positive-eigenvalue coordinates and the common inhibitor.

For each $\lambda_j>0$, choose

$$
p_j=\frac{4ks^3\tau_y}{\lambda_j\tau_a}>0,
\qquad p_a=1.                                     \tag{22}
$$

The diagonal matrix $P$ with these entries cancels every response–inhibitor off-diagonal pair in $P\mathcal J+\mathcal J^\top P$. Its diagonal entries are

$$
-\frac{2p_jg_j(s)}{\tau_y}< 0,
\qquad -\frac{2c}{s^2\tau_a}< 0.                     \tag{23}
$$

Thus this remaining block is Hurwitz by the strict quadratic Lyapunov criterion. The separated zero modes and inhibitor quotient modes are also strictly stable. Smooth nonlinear linearization then proves local exponential stability. The proof allows $u_j=0$ without division by that coordinate and also covers $R=0$ with an empty positive-eigenvalue block. $\square$

For $R=0$ the threshold reduces to $k\|u\|_2^2< 1$, with $y=u$ and $s^2=c/(1-k\|u\|_2^2)$. At the threshold the missing equilibrium is not a finite nonhyperbolic point; no finite equilibrium exists.

**Theorem 6 (universal spectral classification).** Fix a real symmetric $R$ with $\|R\|_2\leq1$. The following are equivalent:

1. $R$ is positive definite.
2. For every $u\in\mathbb R^n$ and every $c,w,\tau_y,\tau_a>0$, the system (1), (3) has exactly one equilibrium, and this equilibrium is locally exponentially stable.
3. For every such parameter choice, the system has at least one asymptotically stable equilibrium.

*Proof.* If $R$ is positive definite, $P_0=0$, so Theorem 5 gives statement 2; statement 2 implies statement 3.

For the converse, first suppose $R$ is positive semidefinite but singular. Choose a nonzero $u\in\ker R$ and choose $w$ so that $k\|u\|_2^2\geq1$. Theorem 5 gives no equilibrium, contradicting statement 3.

If $R$ has a negative eigenvalue, choose

$$
\sqrt c>\max_{\lambda_j< 0}(1-1/\lambda_j),\qquad u=0. \tag{24}
$$

At every possible equilibrium $s\geq\sqrt c$, so no $g_j(s)$ vanishes. Equations (16) force $y=0$, $s=\sqrt c$: this is the unique equilibrium. Every negative eigenvalue of $R$ gives a strictly positive eigenvalue $-g_j(\sqrt c)/\tau_y$ of the full Jacobian. All other modes are strictly negative. Hence no stable equilibrium exists.

This converse does not intrinsically rely on zero input. For the same choice (24), every denominator has fixed sign and nondecreasing absolute value on $s\geq\sqrt c$, strictly increasing off the kernel. Consequently the left side of (21) is strictly decreasing to $k\|P_0u\|_2^2$, with strict decrease already supplied by $c/s^2$. For all sufficiently small $u$ that limit is below one, giving one unique equilibrium continuously approaching the hyperbolic unstable point just found. Its instability persists. One can in particular take $u=\varepsilon\mathbf1$ with sufficiently small $\varepsilon>0$. In the singular semidefinite case one can also choose a strictly positive input with nonzero kernel projection, then increase $w$: the positive orthant spans $\mathbb R^n$, so it cannot be contained in the proper subspace $(\ker R)^\perp$. $\square$

The classification concerns fixed **symmetric contractive** recurrence with shared uniform pooling and common time constants. It is not a theorem that positive definiteness alone stabilizes every normalization matrix or every nonsymmetric circuit.

## 6. Complete equilibrium geometry for constant inputs

Assume (3) and additionally

$$
R=R^\top,\quad R\mathbf1=\mathbf1,\quad \|R\|_2\leq1,
\qquad u=u_0\mathbf1,\quad u_0\in\mathbb R.        \tag{25}
$$

These conditions include every symmetric stochastic matrix; entrywise nonnegativity is not needed for the theorem. Since one is an eigenvalue, the spectral norm in (25) equals one. Let

$$
s_0=\sqrt{c+wu_0^2},\qquad
E_\lambda=\ker(R-\lambda I),\quad m_\lambda=\dim E_\lambda.
                                                               \tag{26}
$$

**Theorem 7 (all equilibrium components).** The complete equilibrium set consists of the synchronous point

$$
y_0=\frac{u_0}{s_0}\mathbf1,\qquad a_0=s_0^2\mathbf1, \tag{27}
$$

and, for each distinct negative eigenvalue $\lambda$ with $s_\lambda>s_0$, the sphere

$$
a=s_\lambda^2\mathbf1,\qquad
y=\frac{u_0}{s_\lambda}\mathbf1+v,\quad v\in E_\lambda,
\qquad
\frac{\|v\|_2^2}{n}
=\frac{s_\lambda^2-s_0^2}{w s_\lambda^2}>0.          \tag{28}
$$

This sphere has dimension $m_\lambda-1$, with two points when $m_\lambda=1$. If $s_\lambda=s_0$, (28) contributes only (27). If $s_\lambda< s_0$, it contributes no equilibrium.

*Proof.* Equations (16)–(18) apply. The component of $y$ in the direction of $\mathbf1$ is always $(u_0/s)\mathbf1$. Every orthogonal component vanishes unless $g_j(s)=0$. Such a zero is possible only at a negative pole, and distinct negative eigenvalues have distinct poles. At $s=s_\lambda$, the extra component belongs exactly to $E_\lambda$ and is orthogonal to $\mathbf1$. Substitution into the second equation of (16) gives (28). In the absence of such a component it gives $s=s_0$. This lists every possibility, including repeated eigenvalues and equality cases. $\square$

**Theorem 8 (sharp stable-equilibrium boundary and unstable branches).** Under (25), set

$$
s_* =
\begin{cases}
1-1/\lambda_{\min}(R),&\lambda_{\min}(R)< 0,\\
+\infty,&\lambda_{\min}(R)\geq0.
\end{cases}                                       \tag{29}
$$

An asymptotically stable equilibrium exists if and only if $s_0< s_*$. When it exists, it is (27) and is locally exponentially stable. Every nonsynchronous equilibrium is unstable. At $s_0=s_*< \infty$, the synchronous equilibrium is **nonlinearly Lyapunov unstable**.

*Synchronous spectrum.* The common-inhibitor and constant-response block is

$$
J_2=\begin{pmatrix}
-s_0/\tau_y&-x_0/(2s_0\tau_y)\\
2ws_0^2x_0/\tau_a&-c/(s_0^2\tau_a)
\end{pmatrix},\qquad x_0=u_0/s_0.                   \tag{30}
$$

It has negative trace and determinant $s_0/(\tau_y\tau_a)>0$. One copy of the eigenvalue $1$ of $R$ is represented in this block. Every remaining eigenvalue $\mu$ contributes

$$
\alpha_\mu(s_0)/\tau_y,
\qquad \alpha_\mu(s)=-1+(1-s)\mu.                  \tag{31}
$$

Additional copies of $\mu=1$ are therefore stable, as are all nonnegative modes. A negative mode is stable exactly when $s_0< s_\mu$. Together with the inhibitor quotient (15), this proves the strict stability and strict instability claims for the synchronous point, apart from the first-pole equality case addressed below.

*Nonsynchronous branches.* At (28), choose $\nu\in E_\lambda$ with $\|\nu\|_2^2=n$ and write $v=r\nu$, $r>0$. The subspace

$$
a=A\mathbf1,\qquad y=x\mathbf1+r\nu
$$

is invariant. Its equations are

$$
\tau_y\dot x=-\sqrt A\,x+u_0,\qquad
\tau_y\dot r=[-1+(1-\sqrt A)\lambda]r,\qquad
\tau_a\dot A=c-A+wA(x^2+r^2).                       \tag{32}
$$

At the branch equilibrium, with $s=s_\lambda$, its Jacobian is

$$
J_3=\begin{pmatrix}
-s/\tau_y&0&-x/(2s\tau_y)\\
0&0&-\lambda r/(2s\tau_y)\\
2ws^2x/\tau_a&2ws^2r/\tau_a&-c/(s^2\tau_a)
\end{pmatrix}.                                    \tag{33}
$$

Its determinant is $(-\lambda)ws^2r^2/(\tau_y^2\tau_a)>0$. Thus $\det(tI-J_3)$ is negative at zero and positive for sufficiently large positive $t$, proving a positive real eigenvalue and instability in the full system.

For completeness, this block has exactly one positive eigenvalue and two eigenvalues with negative real parts. Indeed, put

$$
L=s/\tau_y,\quad d=c/(s^2\tau_a),\quad
g=wsx^2/(\tau_y\tau_a),\quad h=(-\lambda)wsr^2/(\tau_y\tau_a).
$$

Then $L,d,h>0$, $g\geq0$, and its characteristic polynomial is

$$
t^3+(L+d)t^2+(Ld+g-h)t-Lh.                          \tag{34}
$$

Its coefficient sequence has exactly one sign change, so Descartes' rule gives one positive real root. The other two roots have positive product and negative sum, hence negative real parts. All remaining response directions decouple, giving the full characteristic polynomial

$$
(t+1/\tau_a)^{n-1}\det(tI-J_3)
\prod_{\mu\in\operatorname{spec}(R)\setminus\{1,\lambda\}}
\left(t-\frac{\mu/\lambda-1}{\tau_y}\right),         \tag{35}
$$

where one copy of each indicated eigenvalue is deleted. If $q_\lambda$ counts eigenvalues $\mu< \lambda$ with multiplicity, a branch point has $q_\lambda+1$ unstable eigenvalues, $m_\lambda-1$ zero tangent eigenvalues and $2n-q_\lambda-m_\lambda$ stable eigenvalues. When $m_\lambda>1$ the points are not individually hyperbolic; the zero directions are tangent to their equilibrium sphere.

*The critical equality case.* Suppose $s_0=S=s_*=1-1/\lambda_*$ with $\lambda_*< 0$ minimal. Choose any $\nu\in E_{\lambda_*}$ of squared norm $n$ and restrict to (32). Set $s=\sqrt A$ and $x_0=u_0/S$. The equations become

$$
\dot x=\frac{-sx+u_0}{\tau_y},\qquad
\dot r=\frac{-\lambda_*}{\tau_y}(s-S)r,\qquad
\dot s=\frac{c-s^2+ws^2(x^2+r^2)}{2\tau_a s}.        \tag{36}
$$

We give an elementary first-exit proof, including the nonhyperbolic boundary. Put $\theta=(-\lambda_*)/\tau_y>0$, $A_2=-wx_0/2$, $B_2=wS/2>0$ and $\kappa=\theta B_2>0$. Use the explicit smooth coordinates

$$
z_1=x-x_0-A_2r^2,\qquad z_2=s-S-B_2r^2.           \tag{37}
$$

The linear block in $(x-x_0,s-S)$ is

$$
M=\begin{pmatrix}-S/\tau_y&-x_0/\tau_y\\
wSx_0/\tau_a&-c/(\tau_aS^2)\end{pmatrix}.
$$

Since $c=S^2(1-wx_0^2)>0$, substitution in (36) cancels the pure $r^2$ terms and yields

$$
\dot z=Mz+F(r,z),\qquad
\dot r=\kappa r^3+\theta z_2r,\qquad
\|F(r,z)\|\leq C(r^4+r^2\|z\|+\|z\|^2)            \tag{38}
$$

on a sufficiently small neighborhood with $s\geq S/2$. Here $C$ is finite. To verify the remainder, the original $(x,s)$ field is smooth and even in $r$; its pure quadratic terms cancel because

$$
SA_2+x_0B_2=0,\qquad
2wS^2x_0A_2-2S(1-wx_0^2)B_2+wS^2=0.
$$

The derivative of the subtracted quadratic graph is $2(A_2,B_2)r\dot r$, of order $r^4+r^2\|z\|$. All remaining terms have the order bounded in (38). A Taylor bound exists on a compact neighborhood because the only denominator $s$ stays positive.

The positive diagonal matrix $P=\operatorname{diag}(wS\tau_y,\tau_a)$ satisfies the exact identity

$$
M^\top P+PM=\operatorname{diag}(-2wS^2,-2c/S^2)\prec0.
$$

Set $\rho=(z^\top Pz)^{1/2}$ and $\alpha=\min\{S/\tau_y,c/(S^2\tau_a)\}>0$. At $\rho>0$, (38) gives a finite $C_1$ such that

$$
\dot\rho\leq-\alpha\rho+C_1(r^4+r^2\rho+\rho^2).
$$

Choose a sufficiently small fixed $\varepsilon>0$ so that the region $0< r\leq\varepsilon$, $\rho\leq r^3$ stays in that neighborhood, $\varepsilon\leq B_2\sqrt{\tau_a}/2$, and $C_1(\varepsilon+\varepsilon^2+\varepsilon^3)< \alpha/2$. Inside this region, $|z_2|\leq r^3/\sqrt{\tau_a}$ and therefore $\dot r\geq(\kappa/2)r^3>0$. On its lateral boundary $\rho=r^3>0$,

$$
\frac{d}{dt}(\rho-r^3)
\leq-\frac\alpha2 r^3-3r^2\dot r< 0.
$$

A trajectory starting at $z=0$ and any $0< r_0< \varepsilon$ cannot exit through that side or through $r=0$. Before reaching $r=\varepsilon$, it stays in a compact smooth region, so local existence and continuation apply. But $d(r^{-2})/dt\leq-\kappa$ forces it to reach $r=\varepsilon$ in finite time. The physical starting points $x=x_0+A_2r_0^2$, $s=S+B_2r_0^2$, $y=x\mathbf1+r_0\nu$ approach the equilibrium as $r_0\downarrow0$. At exit the $\nu$ component of $y-y_0$ has norm $\sqrt n\,\varepsilon$, independent of $r_0$. This proves Lyapunov instability. Differentiation of $\rho$ is used on the lateral boundary only, where $\rho>0$; the initial $z=0$ creates no differentiability gap.

This proof never divides by $u_0$ and includes $u_0=0$. Repeated $\lambda_*$ causes no difficulty because one invariant radial subsystem already supplies escaping trajectories. At any later pole a more negative mode already has a positive eigenvalue. This completes the proof. $\square$

The branches (28) lie on the side of their collision where the associated $\lambda$ response mode of the synchronous point is stable; other more negative modes may already be unstable. Every branch has an unstable radial direction. Equations (28) and (38) give this subcritical orientation directly, without a claim that an arbitrary perturbation preserves the same symmetric bifurcation diagram.

## 7. Arbitrary pooling with negative identity recurrence

The spectral classifications above depend on shared uniform pooling. A separate obstruction needs neither that assumption nor common time constants.

Define, for $c,d>0$,

$$
H(c,d)=\frac2{\sqrt d}
\left[1-(c/4)^{1/3}\right]_+^{3/2}.                 \tag{39}
$$

**Lemma 9 (positive-response input ceiling).** For $c,d>0$, the supremum over $0< q< d^{-1/2}$ of the positive part of

$$
h(q)=q\left(2-\frac{\sqrt c}{\sqrt{1-dq^2}}\right)
$$

is $H(c,d)$. For $0< c< 4$, its positive maximum is attained at

$$
q_*=d^{-1/2}\sqrt{1-(c/4)^{1/3}}.                   \tag{40}
$$

*Proof.* The derivative is $h'(q)=2-\sqrt c(1-dq^2)^{-3/2}$. If $c\geq4$, the function is nonpositive for $q>0$. If $c< 4$, its derivative decreases strictly from a positive value to negative infinity and vanishes exactly at (40). Substitution gives (39). $\square$

**Theorem 10 (general-pooling all-equilibria obstruction).** In (1), set $R=-I$. Assume $u_i,c_i>0$, $W\geq0$ entrywise, $W_{ii}>0$, and arbitrary positive diagonal $T_y,T_a$. If

$$
u_i>H(c_i,W_{ii})\quad\hbox{for every }i,             \tag{41}
$$

then at least one equilibrium exists, and every equilibrium has $y_i< 0$, $a_i>4$ and is linearly unstable. Its spectral abscissa obeys

$$
\alpha(J)\geq\max_i\frac{\sqrt{a_i}-2}{\tau_{y,i}}
>\max_i\frac{u_i\sqrt{W_{ii}}}{\tau_{y,i}}>0.         \tag{42}
$$

*Exclusion of nonnegative responses.* At equilibrium,

$$
u_i=(2-\sqrt{a_i})y_i.                              \tag{43}
$$

No $y_i$ can be zero. If $y_i>0$, Lemma 1 bounds the right side by the function in Lemma 9 with $d=W_{ii}$, contradicting (41). Hence $y_i< 0$ and (43) gives $\sqrt{a_i}>2$.

*Instability of every equilibrium.* The Jacobian blocks are

$$
\begin{aligned}
A&=T_y^{-1}D(\sqrt a-2\mathbf1),&
B&=T_y^{-1}D(y/(2\sqrt a)),\\
C&=2T_a^{-1}W D(a\odot y),&
D_0&=T_a^{-1}[-I+W D(y^2)].
\end{aligned}                                     \tag{44}
$$

The conjugation by $\operatorname{diag}(I,-I)$ makes $J$ a Metzler matrix: all off-diagonal entries are nonnegative. For a Metzler matrix $M$, shift by a sufficiently large scalar $q$ so that $M+qI\geq0$. Perron–Frobenius theory gives $\alpha(M)=\rho(M+qI)-q\geq\max_i M_{ii}$ [7]. Applying this to the positive response diagonal gives the first inequality in (42). Equation (2) and (43) imply $\sqrt{a_i}-2=u_i/|y_i|>u_i\sqrt{W_{ii}}$, giving the strict lower bound.

*Existence.* In fact, existence of a negative-response equilibrium holds for every positive $u,c$ under the pooling assumptions, without (41). Put $x=-y>0$ and $a_i=(2+u_i/x_i)^2$. The first equilibrium equation is automatic, and the second is equivalent to

$$
F_i(x)=(2+u_i/x_i)^2-c_i-\sum_jW_{ij}(2x_j+u_j)^2=0. \tag{45}
$$

Write $u_-=\min_i u_i$, $u_+=\max_i u_i$, $c_+=\max_i c_i$, $d_-=\min_i W_{ii}>0$, and $L=\max_i\sum_jW_{ij}$. Choose

$$
U=1+\frac{3+u_+}{2\sqrt{d_-}},\quad
K=1+c_++L(2U+u_+)^2,\quad
\ell=\min\{U/2,\,u_-/(2\sqrt K)\}.                 \tag{46}
$$

On the face $x_i=U$, (45) satisfies

$$
F_i(x)\leq(2+u_+)^2-d_-(2U)^2< 0.
$$

On $x_i=\ell$, it satisfies

$$
F_i(x)\geq u_-^2/\ell^2-c_+-L(2U+u_+)^2>0.
$$

Apply Brouwer's fixed-point theorem to $G_i(x)=\operatorname{clip}_{[\ell,U]}(x_i+F_i(x))$. Strict face signs exclude boundary fixed points. An interior fixed point has $F(x)=0$. Reconstructing $(y,a)$ proves existence and completes the argument. $\square$

Condition (41) is sufficient for general coupled pooling; it is not claimed necessary there. For a scalar circuit the ceiling in Lemma 9 is exact. To see the strict regimes, assume $0< c< 4$, $w>0$ and $u>0$. The graph $u=h(y)$ on $|y|< 1/\sqrt w$ has one negative root for every $u$, and two positive roots exactly when $0< u< H(c,w)$. At the smaller positive root, both Jacobian diagonal entries are negative and

$$
\det J=\frac{1-wy^2}{\tau_y\tau_a}
\left[2-\sqrt c(1-wy^2)^{-3/2}\right]>0,             \tag{47}
$$

so it is locally exponentially stable. The larger positive root and the negative root have negative determinant and are saddles. For $u>H(c,w)$, only the negative saddle remains. For $c\geq4$, every $u>0$ has only that negative saddle. We make no scalar fold-equality stability claim here; the independent critical equality result of Theorem 8 concerns its own specified family.

## 8. Arbitrary pooling: a complete universal architecture classification

We now return to the full model (1): $c$ again denotes a positive baseline vector, all time constants may differ, and $W$ is any entrywise nonnegative matrix. No shared-pool reduction is imposed. We characterize the stronger property that **exactly one equilibrium exists and that equilibrium is locally exponentially stable**. This is not the weaker assertion that at least one stable equilibrium exists.

### 8.1 Exact feasibility and full-state stability for diagonal recurrence

**Theorem 11 (arbitrary-pool diagonal criterion).** Let $R=D(r)$ with $0\leq r_i\leq1$, and set $Z=\{i:r_i=0\}$. For every $u\in\mathbb R^n$, $c\gg0$, $W\geq0$, and positive diagonal $T_y,T_a$, an equilibrium exists if and only if

$$
\rho\!\left(W_{ZZ}D(u_Z^2)\right)< 1.                 \tag{48}
$$

The spectral radius of the empty matrix is defined here as zero. If (48) holds, the full $2n$-state system has exactly one equilibrium and it is locally exponentially stable. At or above the threshold there is no finite equilibrium. No irreducibility, symmetry or positive diagonal of $W$ is required.

*Existence and uniqueness.* By Lemma 1 every equilibrium has $a\geq c\gg0$. Put

$$
\alpha_i=1-r_i,\quad g_i(t)=\alpha_i+r_i\sqrt t,\quad
f_i(t)=\frac{t u_i^2}{g_i(t)^2}\quad(t>0).
$$

The equilibrium equations are equivalent, in both directions, to $a=T(a):=c+Wf(a)$ and $y_i=u_i/g_i(a_i)$. All denominators are positive. Direct differentiation and scaling give

$$
f_i'(t)=\frac{\alpha_i u_i^2}{g_i(t)^3}\geq0,
\qquad f_i(\theta t)\leq\theta f_i(t)\quad(\theta>1).
$$

Define $d_i=u_i^2$ on $Z$ and $d_i=0$ off $Z$, and set $L=WD(d)$. Define $m_i=0$ on $Z$ and $m_i=u_i^2/r_i^2$ off $Z$. Then $f(a)=D(d)a+v(a)$, where $0\leq v(a)\leq m$. After ordering $Z$ first, $L$ has blocks $\left(\begin{smallmatrix}W_{ZZ}D(u_Z^2)&0\\ *&0\end{smallmatrix}\right)$; thus its spectral radius is the one in (48).

At any fixed point, $La\leq a-c< a$. In the weighted supremum norm with weights $a_i>0$, the operator norm of $L$ is at most $\max_i(La)_i/a_i< 1$. Applying this bound to complex eigenvectors proves $\rho(L)< 1$, including exclusion of equality.

Conversely, if $\rho(L)< 1$, the convergent nonnegative Neumann series gives $(I-L)^{-1}\geq I$. Set

$$
\bar a=(I-L)^{-1}(c+Wm)\geq c\gg0.
\quad c\leq T(a)\leq c+L\bar a+Wm=\bar a
\quad\hbox{for }a\in[c,\bar a].                    \tag{49}
$$

Starting with $a^{(0)}=c$ and iterating $a^{(j+1)}=T(a^{(j)})$ produces a coordinatewise increasing sequence bounded by $\bar a$. Its coordinatewise limit is a fixed point by continuity on this strictly positive compact box. This is a static fixed-point iteration; no convergence of the neural ODE is inferred from it.

For $\theta>1$, positivity of $c$ makes the scaling inequality strict:
$T(\theta a)\leq\theta T(a)-(\theta-1)c< \theta T(a)$.
If $a,b$ were two different positive fixed points, interchange them if needed so that $\theta=\max_i a_i/b_i>1$. Monotonicity would give $a=T(a)\leq T(\theta b)< \theta b$, contradicting equality in a coordinate attaining the maximum. The fixed point and reconstructed response are unique. This argument includes linear coordinates $r_i=0$, constant coordinates $r_i=1$, and zero input coordinates.

*Full-state stability.* Write $a_i=s_i^2$, $g_i=\alpha_i+r_i s_i$, and $Q=WD(y^2)$. The equilibrium equation gives $Qa=a-c< a$. The complete Jacobian has blocks

$$
J_{yy}=-T_y^{-1}D(g),\quad
J_{ya}=-T_y^{-1}D\!\left(\frac{r\odot y}{2s}\right),\quad
J_{ay}=2T_a^{-1}WD(a\odot y),\quad
J_{aa}=T_a^{-1}(-I+Q).
$$

Suppose $z$ were an eigenvalue with $\operatorname{Re}z\geq0$ and eigenvector $(\xi,\zeta)\neq0$. Each response denominator $z\tau_{y,j}+g_j$ has positive real part. Elimination of $\xi$ from the full eigenvalue equations gives the exact identity

$$
(1+z\tau_{a,i})\zeta_i
=\sum_j Q_{ij}
\frac{z\tau_{y,j}+\alpha_j}{z\tau_{y,j}+g_j}\,\zeta_j.
                                                               \tag{50}
$$

No division by $y_j$, $u_j$ or $r_j$ was used. Because $g_j\geq\alpha_j\geq0$,

$$
|z\tau_{y,j}+g_j|^2-|z\tau_{y,j}+\alpha_j|^2
=(g_j-\alpha_j)(2\tau_{y,j}\operatorname{Re}z+g_j+\alpha_j)\geq0.
$$

Also $|1+z\tau_{a,i}|\geq1$. Hence (50) implies $|\zeta_i|\leq\sum_jQ_{ij}|\zeta_j|$. If $\zeta=0$, the response equations force $\xi=0$, impossible. At an index maximizing $M=\max_j|\zeta_j|/a_j>0$, the inequality gives $Ma_i\leq M(Qa)_i=M(a_i-c_i)< Ma_i$, a contradiction. Thus the full Jacobian is Hurwitz. Local smoothness and the nonlinear linearization theorem prove local exponential stability. $\square$

The static existence/uniqueness component is an application of established standard-interference theory: $T$ has asymptotic mapping $T_\infty(x)=Lx$, so (48) specializes [8, Proposition 4 and Fact 1]. We supplied the elementary model-specific argument to make all boundary cases explicit. The general geometric convergence theorem for positive concave fixed-point iterations belongs to [9, Proposition 3]. Neither general fixed-point principle is claimed as new; neither alone establishes stability of the coupled continuous-time system proved using (50).

**Corollary 12 (a parameter-based spectral margin).** Under (48), define

$$
\gamma=\min_i\frac{c_i}{\bar a_i}\in(0,1],\qquad
\eta=\min\left\{
\min_i\frac{1-r_i+r_i\sqrt{c_i}}{2\tau_{y,i}},
\frac{\gamma}{2\max_i\tau_{a,i}}\right\}>0.
                                                               \tag{51}
$$

Then the equilibrium Jacobian satisfies $\alpha(J)< -\eta$. These quantities can be computed from parameters before solving for the equilibrium.

*Proof.* The equilibrium lies in $[c,\bar a]$, so $g_i\geq g_i(c_i)$ and $c_i/a_i\geq\gamma$. If $\operatorname{Re}z\geq-\eta$, then $\operatorname{Re}(z\tau_{y,j}+g_j)\geq g_j/2>0$ and
$2\tau_{y,j}\operatorname{Re}z+g_j+\alpha_j\geq\alpha_j\geq0$.
Thus the transfer ratios in (50) still have modulus at most one. Now $|1+z\tau_{a,i}|\geq1-\gamma/2$, whereas the same weighted maximum bounds the right side by $(1-\gamma)Ma_i$. The resulting inequality $(1-\gamma/2)Ma_i\leq(1-\gamma)Ma_i$ is impossible. $\square$

This margin concerns the linearized spectrum for a fixed parameter instance. It does not assert a parameter-uniform nonlinear basin or global attraction.

### 8.2 Every off-diagonal recurrence has an explicit obstruction

**Lemma 13 (an off-diagonal instability witness).** For any fixed real $R$ with $R_{j\ell}\neq0$, $j\neq\ell$, there are admissible parameters with $\|u\|_2=1/2$ and a hyperbolic equilibrium having one unstable direction. No spectral, symmetry or contraction assumption on $R$ is needed.

*Proof.* Define

$$
q=\frac{R_{jj}+3}{R_{j\ell}},\qquad
\varepsilon=\frac1{2\sqrt{1+q^2}},\qquad
u=y=\varepsilon(e_j-qe_\ell),\qquad a=\mathbf1,
$$
$$
T_y=T_a=I,\qquad W=\frac1{2\varepsilon^2}e_je_j^\top,
\qquad c=\mathbf1-\frac12e_j.                         \tag{52}
$$

The response recurrent gain vanishes at $a=\mathbf1$, so $y=u$ solves its equation. The only pooling term is $W_{jj}y_j^2=1/2$, giving the inhibitor equation. Also $(Ry)_j=-3\varepsilon$. The four full-Jacobian blocks are $-I$, $-D(Ry)/2$, $\varepsilon^{-1}e_je_j^\top$, and $-I+e_je_j^\top/2$. All are diagonal. In paired coordinate order, the $j$-th block is
$\left(\begin{smallmatrix}-1&3\varepsilon/2\\1/\varepsilon&-1/2\end{smallmatrix}\right)$,
with eigenvalues $1/2,-2$. Every other block is
$\left(\begin{smallmatrix}-1&-(Ry)_i/2\\0&-1\end{smallmatrix}\right)$;
its possibly nonzero upper-right entry must be retained but contributes only the repeated eigenvalue $-1$. Thus

$$
\det(tI-J)=(t-1/2)(t+2)(t+1)^{2n-2}.                  \tag{53}
$$

This proves hyperbolicity and instability. The source representation uses $b=b_0=\mathbf1$, $z=u$, $\sigma_i=\sqrt{c_i}$, so all required source scalars are positive. $\square$

With $R,c,u,T_y,T_a$ fixed, the implicit-function theorem at this nonsingular Jacobian continues the equilibrium when $W$ is replaced by $W+\delta\mathbf1\mathbf1^\top$ for all sufficiently small $\delta>0$. The new pooling matrix is strictly positive and dense; the equilibrium remains in $a\gg0$ and its unstable eigenvalue persists. This is a local persistence assertion, without a claimed numerical radius or exclusion of other equilibria.

**Theorem 14 (complete universal architecture classification).** Fix any real matrix $R$. The following are equivalent:

1. For every real input $u$, every $c\gg0$, every $W\geq0$ and every positive diagonal $T_y,T_a$, (1) has exactly one equilibrium, and it is locally exponentially stable.
2. For every such parameter choice, an equilibrium exists and every equilibrium is locally exponentially stable.
3. $R=D(r)$ with $0< r_i\leq1$ for all $i$.

The equivalence remains valid if pooling is restricted to strictly positive dense matrices, or if inputs are restricted to the Euclidean unit ball.

*Proof.* Condition 3 makes $Z$ empty, so Theorem 11 gives condition 1, which implies condition 2. If $R$ has an off-diagonal entry, Lemma 13 contradicts both conditions 1 and 2: the exhibited unstable equilibrium either is the only equilibrium or already violates uniqueness if another exists. This argument does not assert that no stable equilibrium exists elsewhere.

For diagonal $R$, take $W=0$, $u=0$, $T_y=T_a=I$ and $a=c$. The response eigenvalues are $-1+r_i(1-\sqrt{c_i})$. To exclude $r_j< 0$, choose $\sqrt{c_j}>1-1/r_j$; to exclude $r_j>1$, choose $0< \sqrt{c_j}< 1-1/r_j$. Set every other $c_i=1$. In either case the zero-response equilibrium is unique and has a positive eigenvalue; all other eigenvalues are $-1$. If $r_j=0$, instead choose $u=e_j/2$, $W=4e_je_j^\top$ and $c=\mathbf1$. Every possible equilibrium would have $y_j=1/2$ and $a_j=1+4a_jy_j^2=1+a_j$, a contradiction.

All these inputs lie in the unit ball. For strictly positive dense pooling, use the preceding perturbation in the off-diagonal case. The out-of-range diagonal case keeps $y=0,a=c$ and its Jacobian for every $W$ because all terms containing $y$ vanish. The zero diagonal case remains impossible after adding $\delta\mathbf1\mathbf1^\top$ to $W$, since its equation then gives $a_j\geq1+a_j$. Sufficiency already permits every nonnegative $W$. $\square$

If the assertion requires only that **every existing equilibrium** be locally exponentially stable, without requiring existence, the exact class is instead $R=D(r)$ with $0\leq r_i\leq1$. Theorem 11 proves sufficiency; the same off-diagonal and out-of-range witnesses prove necessity. This separates an existence obstruction from instability without silently changing the quantifier.

### 8.3 A positive-definite recurrence need not stabilize arbitrary pooling

For a fully rational illustration, take

$$
R=\begin{pmatrix}3/4&1/4\\1/4&3/4\end{pmatrix},\quad
W=\begin{pmatrix}512&1\\1&1\end{pmatrix},\quad
u=y=\frac1{32}(1,-15)^\top,\quad a=\mathbf1,
$$
$$
c=(287/1024,399/512)^\top,\qquad T_y=T_a=I.            \tag{54}
$$

Both matrices are strictly positive entrywise, $R$ is positive definite with spectrum $\{1,1/2\}$ and norm one, and $\|u\|_2^2=113/512< 1$. Direct multiplication gives $c+Wy^2=\mathbf1$ and $Ry=(-3,-11)^\top/32$, verifying the equilibrium. Direct differentiation and expansion give

$$
\det(tI-J)=\frac{1}{1048576}
\left(1048576t^4+3439616t^3+2738463t^2-387008t-987376\right).
                                                               \tag{55}
$$

Its value at zero is $-61711/65536< 0$, while it tends to positive infinity on the positive real axis. A positive real eigenvalue follows by the intermediate-value theorem. Thus the positive-definiteness repair for shared uniform pooling cannot be extended to arbitrary pooling and unequal baselines. This example establishes instability of the displayed equilibrium; it makes no uniqueness claim.

## 9. Real normal recurrence and a sharp complex-spectral criterion

We return to the shared uniform pooling architecture (3), with $k=w/n$, equal baseline coordinates and one time constant per population. The recurrence is now an arbitrary real normal matrix, $RR^\top=R^\top R$; contractivity is not assumed. Inputs range over all $u\in\mathbb R^n$. Define the closed region

$$
\mathcal D=\{\lambda\in\mathbb C:
\operatorname{Re}\lambda\geq|\lambda|^2,
\quad |\operatorname{Im}\lambda|\leq\operatorname{Re}\lambda\}.
\tag{56}
$$

This is the intersection of the disk $|\lambda-1/2|\leq1/2$ and the sector $|\operatorname{Im}\lambda|\leq\operatorname{Re}\lambda$. Every nonzero element has positive real part and modulus at most one.

Normality permits rotational response modes that are absent from the symmetric analysis. Orthogonal modal coordinates remain compatible with shared pooling because the pool depends on the Euclidean response energy. The resulting existence test depends on the attenuation of each mode, whereas stability also depends on the phase of its feedback through the common inhibitor. These two requirements lead to the separate disk and sector inequalities in (56).

**Theorem 15 (normal-recurrence classification).** Fix a real normal matrix $R\in\mathbb R^{n\times n}$, $n\geq1$. The following are equivalent: (i) $R$ is invertible and $\operatorname{spec}(R)\subset\mathcal D$; (ii) for every real input $u$ and every $c,w,\tau_y,\tau_a>0$, the system (1), (3) has exactly one equilibrium, and that equilibrium is locally exponentially stable in the full $2n$-dimensional state space.

More generally, suppose every nonzero eigenvalue belongs to $\mathcal D$, allowing a nontrivial kernel. Let $P_0$ be the orthogonal kernel projection and set

$$
\beta_0=k\|P_0u\|_2^2.                              \tag{57}
$$

If $\beta_0\geq1$, there is no equilibrium. If $\beta_0< 1$, there is exactly one equilibrium and it is locally exponentially stable for every pair of positive time constants. Both spectral boundaries in (56) are included. Stability constants may depend on the fixed parameter instance.

*Existence and uniqueness.* The shared-pool identities (15), (16), and the reduced Jacobian (19) do not require symmetry. Every equilibrium has $a=s^2\mathbf1$, $s\geq\sqrt c>0$. The inhibitor quotient contributes $n-1$ eigenvalues $-1/\tau_a$ to the full linearization.

Indeed, subtracting two inhibitor equations gives $\tau_a(\dot a_i-\dot a_j)=-(a_i-a_j)$. Thus the shared-inhibitor manifold is invariant, and the induced linear map on its quotient is $-I/\tau_a$. If $J_{\rm sh}$ denotes the restriction to the tangent space of that manifold, the full characteristic polynomial factors as $(z+1/\tau_a)^{n-1}\det(zI-J_{\rm sh})$. This uses an invariant subspace and its quotient; an invariant orthogonal complement is unnecessary. When $n=1$, the quotient has dimension zero. On the part with $a=A\mathbf1$, $A>0$, the pooled energy is $kA\|y\|_2^2$, so orthogonal response coordinates preserve the reduced dynamics.

A real normal matrix has an orthogonal decomposition into real scalar blocks and two-dimensional blocks $R_j=\alpha_j I+\gamma_j J$, where $J^\top=-J$ and $J^2=-I$. The latter represent conjugate eigenvalues $\alpha_j\pm i\gamma_j$. For one block write

$$
\begin{aligned}
q&=\alpha^2+\gamma^2,&g&=1+\alpha(s-1),\\
h&=g^2+\gamma^2(s-1)^2,&B&=\alpha+(s-1)q,\\
C&=2\alpha g-B=\alpha+(s-1)(\alpha^2-\gamma^2).
\end{aligned}                                                     \tag{58}
$$

For a real scalar block take $\gamma=0$. Here $K(s)=I+(s-1)R$. Since $K_j(s)^\top K_j(s)=h_j(s)I$, its response energy is $\|y_j\|_2^2=\|u_j\|_2^2/h_j(s)$ whenever the block is invertible. A zero block has $h=1$. Repeated eigenvalues produce further orthogonal blocks; summing their energies makes the formula independent of the chosen orthonormal basis within each repeated spectral subspace.

The disk inequality gives $\alpha\geq q>0$ for every nonzero block, hence $0< \alpha\leq1$, $g>0$, and $B=(\alpha-q)+qs>0$ for all $s>0$. Thus $K(s)$ is invertible and $h'(s)=2B>0$. Consequently the complete equilibrium equation is

$$
F(s):=\frac c{s^2}+k\sum_j\frac{\|u_j\|_2^2}{h_j(s)}=1,
\qquad y=K(s)^{-1}u,\qquad s\geq\sqrt c.             \tag{59}
$$

The sum is over orthogonal real blocks, with each complex pair counted once through its two-dimensional energy. The function is continuous and strictly decreasing, with $F(\sqrt c)\geq1$, equality exactly when $u=0$, and limit $\beta_0$ at infinity. This proves existence and uniqueness when $\beta_0< 1$. Conversely, normality makes the kernel a reducing subspace, so every equilibrium satisfies $P_0y=P_0u$ and $1=c/s^2+k\|y\|_2^2>\beta_0$. This excludes equality as well as larger budgets. The existence argument uses only the disk inequality.

For completeness, strict decrease is supplied by the baseline term even when some modal inputs vanish. Each nonzero spectral denominator grows quadratically at infinity, so its input contribution tends to zero; kernel contributions remain constant. If the limiting budget is below one, a finite right endpoint with value below one exists, and the intermediate-value theorem applies between that endpoint and $\sqrt c$. Strict decrease then proves uniqueness, including a root at the left endpoint for zero input. Recovering $y=K(s)^{-1}u$ gives a unique physical state, not merely a unique value of the inhibitor.

The kernel projection used in the converse is justified directly by normality: $\|Rx\|_2=\|R^\top x\|_2$, hence $\ker R=\ker R^\top$. Consequently the kernel and its orthogonal complement are invariant, and projection annihilates the recurrent contribution. No assumption that the input avoids the kernel is hidden in the reduction.

*Stability.* Put $d=c/s^2>0$ and $p=\tau_y z$. In the coordinates $(\delta y,\delta A)$, the full $(n+1)$-dimensional shared-inhibitor block in (19) is

$$
J_{\rm sh}=\begin{pmatrix}
-K(s)/\tau_y&-Ry/(2s\tau_y)\\
2ks^2y^\top/\tau_a&-d/\tau_a
\end{pmatrix}.
$$

For $\operatorname{Re}z\geq0$, every $pI+K_j(s)$ is invertible because its poles have real part $-g_j< 0$. Applying the Schur complement, a possible eigenvalue must satisfy

$$
\tau_a z+d+ks\sum_j\|y_j\|_2^2H_j(\tau_y z)=0,
\qquad H_\lambda(p)=\frac{\alpha p+B}{p^2+2gp+h}.
\tag{60}
$$

Indeed, $y_j^\top(pI+K_j)^{-1}R_jy_j=\|y_j\|_2^2H_j(p)$: the antisymmetric term vanishes because $y_j^\top Jy_j=0$. For a real scalar block, the expression reduces to $\alpha/(p+g)$; for a zero block it is zero. No division by a response coordinate is used.

To check the signs and scaling in this feedback equation, the upper coupling in (19) is $-Ry/(2s\tau_y)$ and the lower coupling is $2ks^2y^\top/\tau_a$. Multiplying the Schur complement by $\tau_a$ therefore produces the positive coefficient $ks$ in (60). Within a two-dimensional block, the inverse of $pI+K_j$ has denominator $p^2+2gp+h$; the coefficient of its symmetric product with $R_j$ is precisely $\alpha p+B$. Thus complex eigenvalues are handled by real block identities, rather than by treating complex coordinates as independent real populations.

Writing $p=x+i\omega$, $x\geq0$, direct multiplication gives

$$
\operatorname{Re}H_\lambda(p)=
\frac{(\alpha x+B)(x^2+2gx+h)+(\alpha x+C)\omega^2}
{|p^2+2gp+h|^2}.                                  \tag{61}
$$

The sector inequality makes $D=\alpha^2-\gamma^2$ lie in $[0,\alpha]$, so $C=\alpha-D+sD>0$. Together with $g,h,B>0$, this proves strict positivity in (61) for every nonzero block. The real part of the left side of (60) is therefore at least $d>0$, excluding every eigenvalue in the closed right half-plane. Adding the strictly stable inhibitor quotient proves that the full Jacobian is Hurwitz. Lemma 1 supplies a smooth positive-$a$ neighborhood, so nonlinear linearization gives local exponential stability.

In particular, all inhibitor coordinates equal the strictly positive number $s^2$ at equilibrium. A sufficiently small neighborhood therefore uses the ordinary smooth square-root branch, and every rectifier agrees with the identity. The stability conclusion requires smoothness only on this neighborhood; no differentiability assertion at zero inhibition enters the proof.

This argument includes repeated blocks, vanishing input coordinates and an empty nonzero spectral part. On the disk boundary, $B=qs>0$; on the sector boundary, $C=\alpha>0$. For $R=0$, it recovers $y=u$ and $s^2=c/(1-k\|u\|_2^2)$ when the budget is subcritical. Invertibility removes the kernel budget for every input, proving sufficiency of (i).

*Necessity.* An unstable equilibrium already refutes (ii), even if other equilibria coexist: either uniqueness fails or the unique equilibrium is unstable. If $R$ has a kernel, choose a nonzero kernel input and increase $k$ until (57) is at least one.

Next consider an eigenvalue $\lambda=\alpha+i\gamma$. At zero input, $(y,a)=(0,c\mathbf1)$ is always an equilibrium, and its response eigenvalues are $-[1+(s-1)\lambda]/\tau_y$, $s=\sqrt c$. If $\alpha< 0$, choose $s=1-2/\alpha$; if $\alpha>1$, choose $s=(\alpha-1)/(2\alpha)$. In either case $g< 0$, giving an unstable equilibrium. No uniqueness assertion is needed for this step.

It remains to consider $0\leq\alpha\leq1$. Suppose first that $q>\alpha$. Choose

$$
s=\min\{1/2,(q-\alpha)/(2q)\},\qquad
d=\frac{-sB}{2(h-sB)}.
$$

Then $g,h>0$, $B< 0$, and $0< d< 1/2$. This case necessarily involves a nonreal pair. Choose a unit response vector supported on its real two-dimensional block, put $k=1-d$, $c=ds^2$, and set $u=K(s)y$. These choices produce an actual equilibrium. For this block and the common inhibitor, with $\mu=\tau_y/\tau_a$, the characteristic polynomial in $p$ is

$$
\begin{aligned}
P(p)&=(p+\mu d)(p^2+2gp+h)
       +\mu s(1-d)(\alpha p+B)\\
&=p^3+A_1p^2+A_2p+A_3,\\
A_1&=2g+\mu d,\\
A_2&=h+2\mu dg+\mu s(1-d)\alpha,\\
A_3&=\mu[dh+s(1-d)B].
\end{aligned}                                                     \tag{62}
$$

The chosen $d$ makes $A_3=\mu sB/2< 0$. Thus $P$ has a positive real root. The activated response block and common inhibitor form an invariant subsystem, so this proves instability in the full system. It does not exclude additional stable equilibria.

The construction is in real coordinates throughout. If $Q$ is the orthogonal modal matrix, choose a real unit vector $v$ in the offending two-dimensional block and set $y=Qv$. Then $u=K(s)Qv$ is a real admissible effective input and $w=n(1-d)>0$. The inhibitor balance follows from $c/s^2+k\|y\|_2^2=d+(1-d)=1$. Unused response blocks have zero equilibrium coordinates, so their first-order coupling to the common inhibitor vanishes. The active cubic therefore gives genuine eigenvalues of the full Jacobian, with algebraic multiplicities retained by the characteristic-polynomial factorization.

Finally, assume the disk condition holds throughout the spectrum but some pair has $|\gamma|>\alpha>0$. Set $D=\gamma^2-\alpha^2>0$ and $s=2+\alpha/D$, so $C=-D< 0$. Use the same unit-response construction, now choosing $d$ and $\mu$ below. All coefficients in (62) are positive. Their decisive difference is

$$
\Delta:=A_1A_2-A_3
=2gh+\mu[4dg^2+s(1-d)C]
 +\mu^2d[2dg+s(1-d)\alpha].                         \tag{63}
$$

First fix $\mu=4gh/(-sC)$, a finite positive number. At the auxiliary limit $d=0$, (63) equals $-2gh$. Next put

$$
E=\mu(4g^2-sC)+2\mu^2g,
\qquad d=\min\{1/2,gh/E\}>0.
$$

For this fixed $\mu$, expansion of (63) reads

$$
\Delta=-2gh+d\{\mu(4g^2-sC)+\mu^2s\alpha\}
       +d^2\mu^2(2g-s\alpha).
$$

Since $2g-s\alpha=2(1-\alpha)+s\alpha>0$ and $d^2\leq d$, it follows that $\Delta\leq-2gh+dE\leq-gh< 0$. All chosen parameters are finite and strictly positive. The auxiliary value $d=0$ is used only to guide their selection. This order matters: sending $\mu$ to infinity with fixed positive $d$ would eventually make its positive quadratic term dominate.

Positive coefficients exclude nonnegative real roots. If all three roots were negative real numbers, their coefficient products would give $\Delta>0$. Otherwise write the roots as $-t$ and $r\pm i\omega$, with $t>0$ and $\omega\ne0$. Direct expansion gives $\Delta=-2r[(t-r)^2+\omega^2]$, so $r>0$. Thus the equilibrium has an unstable conjugate pair. The disk condition and zero kernel projection of the constructed input make this equilibrium unique by (59). The choices above have $c,k>0$, and one may take $\tau_y=1$, $\tau_a=1/\mu$.

These cases prove necessity for arbitrary real normal $R$. The resulting sufficient spectral condition itself implies $\|R\|_2\leq1$. The equivalence concerns a unique equilibrium together with its stability; it does not establish a universal classification for the weaker requirement of at least one asymptotically stable equilibrium. $\square$

The real-input quantifier is consistent with a bounded stimulus in the source parametrization. For any constructed $u$, choose $L\geq\max\{1,\|u\|_2\}$ and set $b=L\mathbf1$, $z=u/L$. Then $b\odot z=u$ and $\|z\|_2\leq1$, with strictly positive gains. This scaling preserves the effective dynamics. The necessity arguments use the full signed-input class; they do not assert that every forbidden spectrum admits the same obstruction when inputs are restricted to be strictly positive.

**Proposition 16 (positive dense normal recurrence with oscillatory instability).** Take shared pooling $W=k\mathbf1\mathbf1^\top$ and

$$
\begin{gathered}
R=\frac1{15}\begin{pmatrix}7&7&1\\1&7&7\\7&1&7\end{pmatrix},
\quad k=\frac{499800}{217},\quad c=1,
\quad\tau_y=1,\quad\tau_a=\frac1{500},\\
u=\frac1{15000}(7432,67,1)^\top,
\qquad y_* =\frac1{1000}(12,11,-13)^\top,
\qquad a_*=2500\mathbf1.
\end{gathered}                                                     \tag{64}
$$

Every entry of $R,W,u$ is strictly positive, $R$ is normal with induced norm one, and $\|u\|_2< 1$. All eigenvalues of $R$ have positive real parts. Nevertheless, $(y_*,a_*)$ is the unique equilibrium and has exactly two right-half-plane eigenvalues, a nonreal conjugate pair.

*Proof.* The circulant recurrence is normal, with spectrum $1,(1+i\sqrt3)/5,(1-i\sqrt3)/5$. For a real normal matrix, the induced Euclidean operator norm equals the largest eigenvalue modulus. Here the real eigenvalue has modulus one and the complex pair has modulus $2/5$, proving the asserted norm exactly. The complex pair satisfies $\alpha=1/5>4/25=|\lambda|^2$, but $|\gamma|>\alpha$. Direct rational calculation gives

$$
K(50)y_*=u,\qquad
k\|y_*\|_2^2=\frac{2499}{2500},\qquad
\|u\|_2^2=\frac{9206519}{37500000}< 1.
$$

These identities verify the equilibrium. Every spectral block satisfies the disk condition, so the strict monotonicity argument for (59) proves uniqueness. The source parameters may be chosen $b=b_0=\sigma=\mathbf1$, $z=u$. The negative third response coordinate is allowed in the source main model.

The full characteristic polynomial is

$$
\det(zI-J)=\frac{(z+500)^2}{3875}
\left(3875z^4+278225z^3+31126185z^2
+1852976389z+38964384450\right).                    \tag{65}
$$

For an explicit modal verification, the projection of $y_*$ onto the eigenvalue-one subspace is $\mathbf1/300$, with energy $e_0=1/30000$. Its orthogonal rotational component has energy $e_c=601/1500000$. At $s=50$, the rotational block has

$$
g=\frac{54}{5},\qquad h=\frac{10119}{25},\qquad
B=\frac{201}{25},\qquad C=-\frac{93}{25},\qquad d=\frac1{2500}.
$$

Clearing the two response denominators in (60) gives the monic quartic directly:

$$
\begin{aligned}
Q(z)={}&(z+50)(z^2+2gz+h)(z+1/5)\\
&+500ks\,e_0(z^2+2gz+h)\\
&+500ks\,e_c(z/5+B)(z+50).
\end{aligned}
$$

Expansion yields the quartic in (65), divided by $3875$; the two inhibitor-difference directions supply the remaining factors. Both response energies are nonzero in this example. Thus the polynomial retains the coupling of the mean response and rotational response to the same inhibitor, as required by the strictly positive input vector.

The quotient factors are strictly stable. Let the remaining monic quartic be $Q(z)=z^4+A_1z^3+A_2z^2+A_3z+A_4$. Its coefficients are positive, and exact arithmetic gives

$$
\Delta_3:=A_1A_2A_3-A_3^2-A_1^2A_4
=-\frac{70752700680468784}{15015625}< 0.             \tag{66}
$$

An elementary argument determines its unstable root count. Positive coefficients exclude nonnegative real roots. A nonzero imaginary root $i\omega$ would require $\omega^2=A_3/A_1$, with the remaining real equation equivalent to $\Delta_3=0$; also $A_4>0$ excludes zero. Thus no root lies on the imaginary axis.

If all roots lay in the open left half-plane, pairing negative real roots and conjugate pairs would give a real factorization

$$
Q(z)=(z^2+pz+q)(z^2+rz+v),\qquad p,q,r,v>0.
$$

But expansion yields

$$
\Delta_3=pr\left[(q-v)^2+(p+r)(pv+rq)\right]>0,
$$

contradicting (66). Hence a nonreal conjugate pair lies in the right half-plane. Four such roots are impossible because their real parts sum to $-A_1< 0$. Exactly two roots are therefore unstable; together with the quotient factors, the full system has two unstable and four stable directions. $\square$

The example satisfies the spectral condition governing uniqueness while violating the additional sector condition governing stability for arbitrary time constants. The disk inequality controls the decrease of the equilibrium budget as inhibition grows. The sector inequality controls the real part of the dynamic feedback transfer; its failure permits an oscillatory instability even when the equilibrium budget remains strictly monotone. Positive matrix entries and positive spectral real parts therefore do not replace this dynamic condition. The theorem uses normality, shared uniform pooling and common population time constants; it does not extend these positive guarantees to general nonnormal recurrence or arbitrary pooling.

## 10. Reproducible certificates and interpretation

The counterexamples use rational coefficients. Their equilibrium obstructions and full characteristic polynomials can be verified using exact arithmetic. The accompanying certificates check the shared-pool projection budget, the characteristic polynomial of (33), the cancellation in (22)–(23), the quadratic-coordinate cancellation and Lyapunov identity in (37)–(38), and the threshold derivative in Lemma 9. Further exact checks cover the arbitrary-pool elimination identity, the off-diagonal witness, the parameter-only spectral margin, the normal-block energy and positive-real identities, and the cubic and quartic instability certificates. Numerical programs examine the complete Jacobian at admissible diagonal, symmetric and normal instances, including boundary spectra and vanishing inputs. Analytically excluded equilibria are recorded as such; a root solver's failure is not used as a nonexistence argument. Finite numerical diagnostics illustrate the claims; the general proofs are those above.

The relevant distinction is between an upper bound on singular values and control over the entire recurrent spectrum. A zero mode leaves an unattenuated input component; that component can exceed the exact pooling budget. A negative mode can reverse the effect of the gain factor $1-\sqrt a$, turning an otherwise suppressive feedback into amplification. In the shared symmetric family, positive definiteness removes both mechanisms, while the kernel budget in Theorem 5 gives the exact exception allowed for singular recurrence.

A positive dense matrix can have a negative eigenvalue, and a positive dense matrix can be singular. Entrywise positivity and spectral-norm normalization therefore do not repair the conjecture. Conversely, Theorem 6 does not prescribe a universal stability test for an arbitrary learned nonsymmetric network. It supplies a proved design condition in one precisely defined family and shows why the general norm-only statement is insufficient.

The additional classifications distinguish coordinate structure from spectral structure. Under arbitrary pooling, even a positive definite recurrence can be destabilized: the off-diagonal entries permit a pooling-dependent local feedback obstruction, and Theorem 14 identifies the exact class that survives every admissible pool. Under shared uniform pooling, orthogonal modal structure is compatible with the common energy feedback. For real normal recurrence, the disk inequality controls static attenuation and uniqueness, while the sector inequality controls the dynamic phase response. Proposition 16 separates these two roles using a positive-input, positive-matrix example with a unique equilibrium and a nonreal unstable pair.

## 11. Limitations and open directions

The architecture classifications have different parameter quantifiers. Theorem 14 permits arbitrary real recurrence, nonnegative pooling, positive vector baselines and heterogeneous positive time constants, but classifies exactly-one-equilibrium stability and universal stability of all equilibria with existence. It does not classify universal existence of at least one stable equilibrium. Theorem 15 allows real normal, potentially nonsymmetric recurrence, but requires shared uniform pooling, a scalar baseline and common time constants within each neuronal population. It is not a criterion for general nonnormal networks. Theorem 6 proves the additional weaker-existence equivalence only in its symmetric shared-pool family. Neither universal classification restricts its input quantifier to strictly positive vectors; the explicitly positive-input counterexamples have the separate properties stated for them.

All stability assertions concern equilibria and their local dynamics. We do not prove global convergence, global boundedness, absence of periodic attractors, robustness to arbitrary input variation, or a numerical basin of attraction. No biological experiment, learning benchmark improvement, or training-code failure is inferred from these theorems. The main equation and the separately rectified model must remain distinct.

The original source and conjecture were inspected in the official NeurIPS publication and author version. The 2026 PNAS follow-up was checked in its official accepted author manuscript and complete associated supplement, released through the public Europe PMC archive; the publisher-typeset version was not obtained. The 2025 preprint was not substituted for that final author manuscript. The 2026 hierarchical ORGaNICs paper, the listed neighboring circuit models and the directly applicable fixed-point theory were also compared. These are documented source comparisons, not a global priority or exhaustive-literature certification. Remaining problems include a general nonnormal shared-pool classification, the full-model universal existence of at least one stable equilibrium, and quantitative perturbation radii for the robust counterexample. None is counted as a completed result.

## References

1. S. Rawat, D. J. Heeger and S. Martiniani. *Unconditional stability of a recurrent neural circuit implementing divisive normalization*. Advances in Neural Information Processing Systems **37** (NeurIPS 2024, Main Conference Track), 14712–14750. DOI: [10.52202/079017-0470](https://doi.org/10.52202/079017-0470). Author version: [arXiv:2409.18946v3](https://arxiv.org/html/2409.18946v3), 15 January 2025. The model and target conjecture are Eq. (15) and Conjecture 5.3.
2. D. J. Heeger and W. E. Mackey. *Oscillatory recurrent gated neural integrator circuits (ORGaNICs), a unifying theoretical framework for neural dynamics*. Proceedings of the National Academy of Sciences **116** (2019), 22783–22794. DOI: [10.1073/pnas.1911633116](https://doi.org/10.1073/pnas.1911633116).
3. F. Morone, S. Rawat, D. J. Heeger and S. Martiniani. *Stabilization of recurrent neural networks through divisive normalization*. Proceedings of the National Academy of Sciences **123**(30) (2026), e2601841123. DOI: [10.1073/pnas.2601841123](https://doi.org/10.1073/pnas.2601841123).
4. F. Morone, S. Rawat, D. J. Heeger and S. Martiniani. *Stabilization of recurrent neural networks through divisive normalization*. Author preprint, 2025. DOI: [10.1101/2025.05.16.654567](https://doi.org/10.1101/2025.05.16.654567). This is an earlier version of [3], not an independent discovery.
5. K. McClain, S. Rawat, M. Morrell, S. Martiniani, D. J. Heeger and F. Morone. *A minimal mechanism to generate long timescales without fine tuning*. Author preprint, 2026. [arXiv:2608.21586v1](https://arxiv.org/abs/2608.21586v1), 21 August 2026.
6. A. Pal, S. Rawat, D. J. Heeger and S. Martiniani. *Hierarchical neural circuit theory of normalization and inter-areal communication*. eLife **15**, RP111297, Version of Record, 17 November 2026. DOI: [10.7554/eLife.111297](https://doi.org/10.7554/eLife.111297).
7. A. Berman and R. J. Plemmons. *Nonnegative Matrices in the Mathematical Sciences*. Classics in Applied Mathematics **9**, SIAM, 1994. DOI: [10.1137/1.9781611971262](https://doi.org/10.1137/1.9781611971262). Used only for classical nonnegative-matrix spectral facts.


8. R. L. G. Cavalcante, Q. Liao and S. Stańczak. *Connections between spectral properties of asymptotic mappings and solutions to wireless network problems*. IEEE Transactions on Signal Processing **67**(10), 2747–2760 (2019). DOI: [10.1109/TSP.2019.2908147](https://doi.org/10.1109/TSP.2019.2908147). [Author version, arXiv:1903.09793v3](https://arxiv.org/html/1903.09793v3), Proposition 4 and Fact 1.
9. T. Piotrowski and R. L. G. Cavalcante. *The fixed point iteration of positive concave mappings converges geometrically if a fixed point exists: implications to wireless systems*. IEEE Transactions on Signal Processing **70**, 4697–4710 (2022). DOI: [10.1109/TSP.2022.3207291](https://doi.org/10.1109/TSP.2022.3207291). [Author version, arXiv:2110.11055v6](https://arxiv.org/html/2110.11055v6), Proposition 3.
10. J. Su, W. Wang, Z. Gu, D. Wang and T. Qian. *A Unified Cortical Circuit Model with Divisive Normalization and Self-Excitation for Robust Representation and Memory Maintenance*. [arXiv:2508.12702v1](https://arxiv.org/html/2508.12702v1), 18 August 2025.
11. T. LoFaro, K. Louie, R. Webb and P. W. Glimcher. *The Temporal Dynamics of Cortical Normalization Models of Decision-making*. Letters in Biomathematics **1**(2), 209–220 (2014). DOI: [10.1080/23737867.2014.11414481](https://doi.org/10.1080/23737867.2014.11414481).
12. Z. Gu, J. Su, W. Wang, C. Liu, T. Qian and D. Wang. *Divisive Normalization Shapes Low-Rank Slow Manifolds for Continuous Working Memory*. [arXiv:2608.01947v2](https://arxiv.org/html/2608.01947v2), 22 August 2026. The comparison uses this accessible author version.
