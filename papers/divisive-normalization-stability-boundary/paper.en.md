# Stability boundaries of divisive-normalization circuits: norm-one counterexamples and sharp spectral repairs

**Research draft — 26 November 2026.**  The results below are written mathematical arguments, subject to independent scrutiny. External peer review and formal proof-assistant verification have not been completed.

## Abstract

We study the main ORGaNICs differential equation of Rawat, Heeger and Martiniani and its conjectured existence of an asymptotically stable equilibrium under a unit spectral-norm constraint on recurrence. Two rational examples with strictly positive dense recurrent and normalization matrices disprove that conjecture: one has no equilibrium, while the other has a unique hyperbolic unstable equilibrium despite positive input and positive equilibrium coordinates. The second obstruction persists in a relative-open set of the full admissible parameter space. For symmetric contractive recurrence with shared uniform pooling and common time constants, we prove an exact replacement: universal existence of a unique locally exponentially stable equilibrium is equivalent to positive definiteness of recurrence. For singular positive semidefinite recurrence, an exact input-energy budget in its kernel is necessary and sufficient. For recurrence fixing the constant vector and a constant input, we classify every equilibrium, including negative-eigenspace spheres, and obtain a sharp stable-equilibrium threshold. Its equality case is nonlinearly unstable. Finally, a coordinate threshold excludes every stable equilibrium for negative identity recurrence with arbitrary nonnegative pooling of positive diagonal and arbitrary positive heterogeneous time constants. These are equilibrium and local stability statements; no claim of global attraction or improved learning performance is made.

## 1. Problem, model and contribution boundary

Let $n\geq1$, write $\mathbf1=(1,\ldots,1)^\top$, and let $a_+$ denote coordinatewise positive part. Products and powers of vectors are coordinatewise unless explicitly indicated. We consider

$$
T_y\dot y=-y+u+D(\mathbf1-\sqrt{a_+})Ry,
\qquad
T_a\dot a=-a+c+W(a_+\odot y^2),                       \tag{1}
$$

where $y,a\in\mathbb R^n$, $T_y,T_a$ are positive diagonal matrices, $c_i>0$, $W_{ij}\geq0$, and $R$ is real. Here $D(v)$ is the diagonal matrix with diagonal $v$. In the source notation, $u=b\odot z$ and $c=b_0^2\odot\sigma^2$, with $b,b_0,\sigma$ strictly positive. There are no upper bounds on those positive parameters in the stated conjecture. Any finite input $u$ is representable with $\|z\|_2\leq1$: choose $b=B\mathbf1$ with $B\geq\max(1,\|u\|_2)$ and put $z=u/B$.

Rawat, Heeger and Martiniani [1, Eq. (15), Conjecture 5.3] ask whether $\|R\|_2=1$ and $\|z\|_2\leq1$ guarantee at least one asymptotically stable fixed point for all remaining admissible parameters. Their established identity-recurrence result and positive-scalar-recurrence results remain intact. We address their main equation (1), not the different recurrence-rectified vector field in their Appendix F.

**Lemma 1 (equilibrium positivity).** Every equilibrium of (1) satisfies $a_i\geq c_i>0$. If $W_{ii}>0$, it also satisfies

$$
|y_i| \lt W_{ii}^{-1/2},\qquad
a_i\geq\frac{c_i}{1-W_{ii}y_i^2}.                    \tag{2}
$$

*Proof.* At equilibrium, $a_i=c_i+\sum_jW_{ij}(a_j)_+y_j^2\geq c_i$. The rectifier can therefore be removed in all equilibrium equations. Keeping just the $j=i$ summand gives $(1-W_{ii}y_i^2)a_i\geq c_i>0$, which proves (2). In particular, the vector field is smooth in a neighborhood of every equilibrium. $\square$

Throughout, **locally exponentially stable** means exponential attraction for all sufficiently small perturbations of the full state $(y,a)$. A **Hurwitz** matrix has every eigenvalue in the open left half-plane. A positive-real-part eigenvalue implies Lyapunov instability of these smooth local systems. A zero eigenvalue alone implies neither stability nor instability.

Our structural theorems use the explicitly restricted shared-pooling family

$$
T_y=\tau_y I,\quad T_a=\tau_a I,\quad c=c_0\mathbf1,
\quad W=k\mathbf1\mathbf1^\top,\quad k=\frac wn,
\quad c_0,w,\tau_y,\tau_a>0.                         \tag{3}
$$

We subsequently write $c$ for the scalar $c_0$. This is still the full $2n$-state system: a common inhibitory state is an invariant manifold, not an assumption imposed on every initial condition. Theorems 5–8 require (3). Theorem 4 allows general nearby parameters, and Theorem 10 allows arbitrary positive heterogeneous time constants and general pooling as stated there.

### 1.1 Relation to earlier work

The normalization architecture, its biological motivation and the identity-recurrence stability theorem belong to [1]; the earlier ORGaNICs framework is due to Heeger and Mackey [2]. Morone et al. [3,4] already study instability, critical slowing and loss of normalization. In particular, [4, Eq. (3)] has the same shared-inhibitor reduction as (3), with symmetric random recurrent perturbations. Its full preprint and supplement were examined; the final publication [3] was available only at abstract, metadata and reference level. Thus neither shared inhibition nor the observation that normalization may coexist with instability is new.

McClain et al. [5, Eqs. (2)–(8)] use eigenmode coordinates, active-mode branches and block Jacobians for a different shared-gain model: its gain is $1-a$, deterministic input is zero, and the analyzed positive leading-mode regime has $0<\sigma^2<1$ and $a_*<1$. Those spectral methods are close predecessors. Pal et al. [6] study hierarchical rectified circuits and communication subspaces, with numerically determined fixed points. These works do not supply the particular finite-dimensional norm-one counterexamples or necessary-and-sufficient statements proved here in the sources inspected. Our proposed increments are the exact conjecture's refutation, the kernel-energy budget, the universal positive-definiteness classification, and the complete negative-mode boundary under their stated hypotheses. No priority claim is made for shared pooling, modal decomposition or instability in general. The spectral theorem, Perron–Frobenius theory, Brouwer's theorem, the implicit-function theorem and elementary local ODE theory are classical tools, not claimed contributions.

## 2. Two positive dense counterexamples

Let $J_2=\mathbf1\mathbf1^\top\in\mathbb R^{2\times2}$.

**Theorem 2 (two distinct failures within the conjectured domain).** Both of the following parameter choices satisfy $\|R\|_2=1$, $\|z\|_2<1$, strict positivity of every entry of $R$ and $W$, and strict positivity of all required scalar parameters. Set $T_y=T_a=I$, $b=b_0=\sigma=\mathbf1$, so $u=z$ and $c=\mathbf1$.

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
0 \lt c_-\leq c_i\leq c_+,\quad
0 \lt m\leq W_{ij}\leq M,\quad
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

If $U>0$, (11)–(14) imply $M\|y\|_2^2<1/2$. If $U=0$, the positive coefficient in (14) gives $y=0$, so the same strict inequality holds. But then

$$
A\leq c_++MA\|y\|_2^2 \lt c_++A/2,
$$

contradicting $A>2c_+$. Thus $A\leq C$. $\square$

**Theorem 4 (an open family with no stable equilibrium).** Fix $n=2$. There is a neighborhood of the parameters (5) in the full parameter space of (1) such that every system in that neighborhood has exactly one equilibrium and that equilibrium is hyperbolic with one unstable and three stable directions. The neighborhood permits nonsymmetric recurrence, unequal baselines, arbitrary positive dense pooling and heterogeneous positive time constants. Its intersection with $\|R\|_2=1$ and $\|z\|_2<1$ is a nonempty relative-open family of counterexamples to Conjecture 5.3.

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

If $\beta\geq1$, the system has no equilibrium. If $\beta<1$, it has exactly one equilibrium, and this equilibrium is locally exponentially stable in the full $2n$-state system for every pair $\tau_y,\tau_a>0$. It is obtained from the unique root $s\geq\sqrt c$ of

$$
F(s):=\frac c{s^2}+
k\sum_{j=1}^n\frac{u_j^2}{(1-\lambda_j+\lambda_js)^2}=1,
\qquad y_j=\frac{u_j}{1-\lambda_j+\lambda_js}.       \tag{21}
$$

*Proof of existence and uniqueness.* Each denominator is positive. The term $c/s^2$ is strictly decreasing, and all other terms are nonincreasing. Hence $F$ is strictly decreasing. Its value at $\sqrt c$ is at least one, with equality exactly when $u=0$. Its limit at infinity is $\beta$. If $\beta<1$, the intermediate-value theorem gives one and only one root, including $s=\sqrt c$ when $u=0$. Conversely, projecting $K(s)y=u$ onto the kernel gives $P_0y=P_0u$, so every equilibrium must satisfy

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
-\frac{2p_jg_j(s)}{\tau_y}<0,
\qquad -\frac{2c}{s^2\tau_a}<0.                     \tag{23}
$$

Thus this remaining block is Hurwitz by the strict quadratic Lyapunov criterion. The separated zero modes and inhibitor quotient modes are also strictly stable. Smooth nonlinear linearization then proves local exponential stability. The proof allows $u_j=0$ without division by that coordinate and also covers $R=0$ with an empty positive-eigenvalue block. $\square$

For $R=0$ the threshold reduces to $k\|u\|_2^2<1$, with $y=u$ and $s^2=c/(1-k\|u\|_2^2)$. At the threshold the missing equilibrium is not a finite nonhyperbolic point; no finite equilibrium exists.

**Theorem 6 (universal spectral classification).** Fix a real symmetric $R$ with $\|R\|_2\leq1$. The following are equivalent:

1. $R$ is positive definite.
2. For every $u\in\mathbb R^n$ and every $c,w,\tau_y,\tau_a>0$, the system (1), (3) has a unique locally exponentially stable equilibrium.
3. For every such parameter choice, the system has at least one asymptotically stable equilibrium.

*Proof.* If $R$ is positive definite, $P_0=0$, so Theorem 5 gives statement 2; statement 2 implies statement 3.

For the converse, first suppose $R$ is positive semidefinite but singular. Choose a nonzero $u\in\ker R$ and choose $w$ so that $k\|u\|_2^2\geq1$. Theorem 5 gives no equilibrium, contradicting statement 3.

If $R$ has a negative eigenvalue, choose

$$
\sqrt c>\max_{\lambda_j<0}(1-1/\lambda_j),\qquad u=0. \tag{24}
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

This sphere has dimension $m_\lambda-1$, with two points when $m_\lambda=1$. If $s_\lambda=s_0$, (28) contributes only (27). If $s_\lambda \lt s_0$, it contributes no equilibrium.

*Proof.* Equations (16)–(18) apply. The component of $y$ in the direction of $\mathbf1$ is always $(u_0/s)\mathbf1$. Every orthogonal component vanishes unless $g_j(s)=0$. Such a zero is possible only at a negative pole, and distinct negative eigenvalues have distinct poles. At $s=s_\lambda$, the extra component belongs exactly to $E_\lambda$ and is orthogonal to $\mathbf1$. Substitution into the second equation of (16) gives (28). In the absence of such a component it gives $s=s_0$. This lists every possibility, including repeated eigenvalues and equality cases. $\square$

**Theorem 8 (sharp stable-equilibrium boundary and unstable branches).** Under (25), set

$$
s_* =
\begin{cases}
1-1/\lambda_{\min}(R),&\lambda_{\min}(R)<0,\\
+\infty,&\lambda_{\min}(R)\geq0.
\end{cases}                                       \tag{29}
$$

An asymptotically stable equilibrium exists if and only if $s_0 \lt s_*$. When it exists, it is (27) and is locally exponentially stable. Every nonsynchronous equilibrium is unstable. At $s_0=s_*<\infty$, the synchronous equilibrium is **nonlinearly Lyapunov unstable**.

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

Additional copies of $\mu=1$ are therefore stable, as are all nonnegative modes. A negative mode is stable exactly when $s_0 \lt s_\mu$. Together with the inhibitor quotient (15), this proves the strict stability and strict instability claims for the synchronous point, apart from the first-pole equality case addressed below.

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

where one copy of each indicated eigenvalue is deleted. If $q_\lambda$ counts eigenvalues $\mu<\lambda$ with multiplicity, a branch point has $q_\lambda+1$ unstable eigenvalues, $m_\lambda-1$ zero tangent eigenvalues and $2n-q_\lambda-m_\lambda$ stable eigenvalues. When $m_\lambda>1$ the points are not individually hyperbolic; the zero directions are tangent to their equilibrium sphere.

*The critical equality case.* Suppose $s_0=S=s_*=1-1/\lambda_*$ with $\lambda_*<0$ minimal. Choose any $\nu\in E_{\lambda_*}$ of squared norm $n$ and restrict to (32). Set $s=\sqrt A$ and $x_0=u_0/S$. The equations become

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

Choose a sufficiently small fixed $\varepsilon>0$ so that the region $0 \lt r\leq\varepsilon$, $\rho\leq r^3$ stays in that neighborhood, $\varepsilon\leq B_2\sqrt{\tau_a}/2$, and $C_1(\varepsilon+\varepsilon^2+\varepsilon^3)<\alpha/2$. Inside this region, $|z_2|\leq r^3/\sqrt{\tau_a}$ and therefore $\dot r\geq(\kappa/2)r^3>0$. On its lateral boundary $\rho=r^3>0$,

$$
\frac{d}{dt}(\rho-r^3)
\leq-\frac\alpha2 r^3-3r^2\dot r<0.
$$

A trajectory starting at $z=0$ and any $0 \lt r_0<\varepsilon$ cannot exit through that side or through $r=0$. Before reaching $r=\varepsilon$, it stays in a compact smooth region, so local existence and continuation apply. But $d(r^{-2})/dt\leq-\kappa$ forces it to reach $r=\varepsilon$ in finite time. The physical starting points $x=x_0+A_2r_0^2$, $s=S+B_2r_0^2$, $y=x\mathbf1+r_0\nu$ approach the equilibrium as $r_0\downarrow0$. At exit the $\nu$ component of $y-y_0$ has norm $\sqrt n\,\varepsilon$, independent of $r_0$. This proves Lyapunov instability. Differentiation of $\rho$ is used on the lateral boundary only, where $\rho>0$; the initial $z=0$ creates no differentiability gap.

This proof never divides by $u_0$ and includes $u_0=0$. Repeated $\lambda_*$ causes no difficulty because one invariant radial subsystem already supplies escaping trajectories. At any later pole a more negative mode already has a positive eigenvalue. This completes the proof. $\square$

The branches (28) lie on the side of their collision where the associated $\lambda$ response mode of the synchronous point is stable; other more negative modes may already be unstable. Every branch has an unstable radial direction. Equations (28) and (38) give this subcritical orientation directly, without a claim that an arbitrary perturbation preserves the same symmetric bifurcation diagram.

## 7. Arbitrary pooling with negative identity recurrence

The spectral classifications above depend on shared uniform pooling. A separate obstruction needs neither that assumption nor common time constants.

Define, for $c,d>0$,

$$
H(c,d)=\frac2{\sqrt d}
\left[1-(c/4)^{1/3}\right]_+^{3/2}.                 \tag{39}
$$

**Lemma 9 (positive-response input ceiling).** For $c,d>0$, the supremum over $0 \lt q \lt d^{-1/2}$ of the positive part of

$$
h(q)=q\left(2-\frac{\sqrt c}{\sqrt{1-dq^2}}\right)
$$

is $H(c,d)$. For $0 \lt c<4$, its positive maximum is attained at

$$
q_*=d^{-1/2}\sqrt{1-(c/4)^{1/3}}.                   \tag{40}
$$

*Proof.* The derivative is $h'(q)=2-\sqrt c(1-dq^2)^{-3/2}$. If $c\geq4$, the function is nonpositive for $q>0$. If $c<4$, its derivative decreases strictly from a positive value to negative infinity and vanishes exactly at (40). Substitution gives (39). $\square$

**Theorem 10 (general-pooling all-equilibria obstruction).** In (1), set $R=-I$. Assume $u_i,c_i>0$, $W\geq0$ entrywise, $W_{ii}>0$, and arbitrary positive diagonal $T_y,T_a$. If

$$
u_i>H(c_i,W_{ii})\quad\text{for every }i,             \tag{41}
$$

then at least one equilibrium exists, and every equilibrium has $y_i<0$, $a_i>4$ and is linearly unstable. Its spectral abscissa obeys

$$
\alpha(J)\geq\max_i\frac{\sqrt{a_i}-2}{\tau_{y,i}}
>\max_i\frac{u_i\sqrt{W_{ii}}}{\tau_{y,i}}>0.         \tag{42}
$$

*Exclusion of nonnegative responses.* At equilibrium,

$$
u_i=(2-\sqrt{a_i})y_i.                              \tag{43}
$$

No $y_i$ can be zero. If $y_i>0$, Lemma 1 bounds the right side by the function in Lemma 9 with $d=W_{ii}$, contradicting (41). Hence $y_i<0$ and (43) gives $\sqrt{a_i}>2$.

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
F_i(x)\leq(2+u_+)^2-d_-(2U)^2<0.
$$

On $x_i=\ell$, it satisfies

$$
F_i(x)\geq u_-^2/\ell^2-c_+-L(2U+u_+)^2>0.
$$

Apply Brouwer's fixed-point theorem to $G_i(x)=\operatorname{clip}_{[\ell,U]}(x_i+F_i(x))$. Strict face signs exclude boundary fixed points. An interior fixed point has $F(x)=0$. Reconstructing $(y,a)$ proves existence and completes the argument. $\square$

Condition (41) is sufficient for general coupled pooling; it is not claimed necessary there. For a scalar circuit the ceiling in Lemma 9 is exact. To see the strict regimes, assume $0 \lt c<4$, $w>0$ and $u>0$. The graph $u=h(y)$ on $|y|<1/\sqrt w$ has one negative root for every $u$, and two positive roots exactly when $0 \lt u \lt H(c,w)$. At the smaller positive root, both Jacobian diagonal entries are negative and

$$
\det J=\frac{1-wy^2}{\tau_y\tau_a}
\left[2-\sqrt c(1-wy^2)^{-3/2}\right]>0,             \tag{47}
$$

so it is locally exponentially stable. The larger positive root and the negative root have negative determinant and are saddles. For $u>H(c,w)$, only the negative saddle remains. For $c\geq4$, every $u>0$ has only that negative saddle. We make no scalar fold-equality stability claim here; the independent critical equality result of Theorem 8 concerns its own specified family.

## 8. Reproducible certificates and interpretation

The two counterexamples use rational coefficients. Their equilibrium obstructions and the full characteristic polynomial in (7) can be verified using exact arithmetic. The accompanying certificate script checks those identities, the shared-pool projection budget, the characteristic polynomial of (33), the cancellation in (22)–(23), the quadratic-coordinate cancellation and Lyapunov identity in (37)–(38), and the threshold derivative in Lemma 9. A separate numerical program samples positive semidefinite recurrences and several negative spectral configurations to check the predicted finite-dimensional equilibria and eigenvalue counts. Finite numerical diagnostics illustrate the claims; the general proofs are those above.

The relevant distinction is between an upper bound on singular values and control over the entire recurrent spectrum. A zero mode leaves an unattenuated input component; that component can exceed the exact pooling budget. A negative mode can reverse the effect of the gain factor $1-\sqrt a$, turning an otherwise suppressive feedback into amplification. In the shared symmetric family, positive definiteness removes both mechanisms, while the kernel budget in Theorem 5 gives the exact exception allowed for singular recurrence.

A positive dense matrix can have a negative eigenvalue, and a positive dense matrix can be singular. Entrywise positivity and spectral-norm normalization therefore do not repair the conjecture. Conversely, Theorem 6 does not prescribe a universal stability test for an arbitrary learned nonsymmetric network. It supplies a proved design condition in one precisely defined family and shows why the general norm-only statement is insufficient.

## 9. Limitations and open directions

The shared-pooling positive-definiteness classification requires real symmetric contraction, equal baseline coordinates and one common time constant per neuronal population. It does not extend automatically to general normalization matrices, heterogeneous time constants or nonsymmetric recurrence. The open-family counterexample does allow small perturbations in all those directions; that negative result and the positive classification have different scopes.

All stability assertions concern equilibria and their local dynamics. We do not prove global convergence, global boundedness, absence of periodic attractors, robustness to arbitrary input variation, or a numerical basin of attraction. No biological experiment, learning benchmark improvement, or training-code failure is inferred from these theorems. The main equation and the separately rectified model must remain distinct.

The original source and its conjecture were inspected in the official NeurIPS publication and the full author version. The final novelty comparison includes the 2026 PNAS follow-up and the 2026 hierarchical ORGaNICs work. Any unavailable final text or supplement is documented individually in the accompanying source record; no global priority or exhaustive-literature claim is made. Proposed further problems are a deterministic nonsymmetric stability classification, sharp general-pooling positive criteria, and quantitative perturbation radii for Theorem 4. They are not used as evidence for results claimed here.

## References

1. S. Rawat, D. J. Heeger and S. Martiniani. *Unconditional stability of a recurrent neural circuit implementing divisive normalization*. Advances in Neural Information Processing Systems **37** (NeurIPS 2024, Main Conference Track), 14712–14750. DOI: [10.52202/079017-0470](https://doi.org/10.52202/079017-0470). Author version: [arXiv:2409.18946v3](https://arxiv.org/html/2409.18946v3), 15 January 2025. The model and target conjecture are Eq. (15) and Conjecture 5.3.
2. D. J. Heeger and W. E. Mackey. *Oscillatory recurrent gated neural integrator circuits (ORGaNICs), a unifying theoretical framework for neural dynamics*. Proceedings of the National Academy of Sciences **116** (2019), 22783–22794. DOI: [10.1073/pnas.1911633116](https://doi.org/10.1073/pnas.1911633116).
3. F. Morone, S. Rawat, D. J. Heeger and S. Martiniani. *Stabilization of recurrent neural networks through divisive normalization*. Proceedings of the National Academy of Sciences **123**(30) (2026), e2601841123. DOI: [10.1073/pnas.2601841123](https://doi.org/10.1073/pnas.2601841123).
4. F. Morone, S. Rawat, D. J. Heeger and S. Martiniani. *Stabilization of recurrent neural networks through divisive normalization*. Author preprint, 2025. DOI: [10.1101/2025.05.16.654567](https://doi.org/10.1101/2025.05.16.654567). This is an earlier version of [3], not an independent discovery.
5. K. McClain, S. Rawat, M. Morrell, S. Martiniani, D. J. Heeger and F. Morone. *A minimal mechanism to generate long timescales without fine tuning*. Author preprint, 2026. [arXiv:2608.21586v1](https://arxiv.org/abs/2608.21586v1), 21 August 2026.
6. A. Pal, S. Rawat, D. J. Heeger and S. Martiniani. *Hierarchical neural circuit theory of normalization and inter-areal communication*. eLife **15**, RP111297, Version of Record, 17 November 2026. DOI: [10.7554/eLife.111297](https://doi.org/10.7554/eLife.111297).
7. A. Berman and R. J. Plemmons. *Nonnegative Matrices in the Mathematical Sciences*. Classics in Applied Mathematics **9**, SIAM, 1994. DOI: [10.1137/1.9781611971262](https://doi.org/10.1137/1.9781611971262). Used only for classical nonnegative-matrix spectral facts.

