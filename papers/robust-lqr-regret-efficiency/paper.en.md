# The statistical price of robust LQR depends on its comparator

## Second-order minimax-regret sensitivity, a critical confidence radius, and a sharp comparator separation

**Research manuscript · 25 November 2026.** Written proofs and reproducible checks. No external peer review or Lean verification is claimed.

### Abstract

We study offline synthesis for the fully observed, discrete-time, infinite-horizon linear quadratic regulator (LQR), with unknown dynamics and fixed finite dimensions. For model-relative minimax regret on shrinking ellipsoids, we derive an explicit second-order optimizer coefficient when the leading sensitivity eigenvalue is positive and simple. Two active uncertainty branches and a nonsingular bordered system yield an even analytic expansion. An integrated shared contribution proves a quadratic displacement bound without a spectral-gap assumption. Consequently, below the $N^{1/4}$ threshold for the standardized confidence radius, the controller has the certainty-equivalent sampling law without spectral restrictions; under the simple-eigenvalue condition, a computable Gaussian shift appears at the threshold and a nonzero second-order coefficient dominates estimation error above it. A fully unknown scalar LQR example has an exact nonzero coefficient. The first-order equivalence also clarifies the fixed-dimensional interpretation of the conjecture of Fujinami, Lee, Matni and Pappas; first-order regret cancellation itself is already established in distributionally robust regret theory. For the different objective of worst total cost, we characterize regular bias, construct a fully identifiable fixed-total-excitation family asymptotically saturating the risk-ratio bound $1+\rho^2$, and give a nondegenerate zero-penalty instance. We also treat the zero-value-gradient boundary. Global localization, solver tolerances, fixed-confidence quantiles and a computable stability safeguard specify the statistical meaning of these results. The claims concern exact or explicitly accurate optimization and fixed-dimensional limits, not an efficient global synthesis algorithm or joint growing-dimension theory.

## 1. The question and its precise scope

Fujinami et al. [FLMP25, pp. 5, 9, 11] analyze a controller defined by minimizing the worst difference between a gain's cost and the optimal cost of **the same uncertain model**. They compare an upper bound involving parameter dimension times an operator norm with trace-type bounds for certainty equivalence and ask whether the resulting gap is intrinsic. Their definition is essential: subtracting a model-dependent optimum inside a supremum changes the optimization problem. Their controller uses model-relative minimax regret throughout this comparison.

Let $C(K,\theta)$ denote stationary LQR cost and $K_*(\theta)$ the optimal gain. For an uncertainty set $\mathcal E$, define

$$
\begin{aligned}
F_{\mathcal E}(K)&=\sup_{\theta\in\mathcal E}
   \{C(K,\theta)-C(K_*(\theta),\theta)\},\\
J_{\mathcal E}(K)&=\sup_{\theta\in\mathcal E}C(K,\theta),\\
K_{\rm MR}(\mathcal E)&\in\arg\min_KF_{\mathcal E}(K),\qquad
K_{\rm WC}(\mathcal E)\in\arg\min_KJ_{\mathcal E}(K).
\end{aligned}\tag{1}
$$

MR means model-relative minimax regret, and WC means worst total cost. These labels distinguish the objectives throughout. Certainty equivalence (CE) is $K_{\rm CE}=K_*(\widehat\theta)$. Regret in (1) is an offline synthesis loss, not accumulated online regret or comparison with a noncausal disturbance-dependent controller.

Our contributions are the following connected statements.

1. **Second-order MR sensitivity and a sharp statistical boundary.** Under a simple positive leading sensitivity eigenvalue, we solve explicitly for the second-order gain displacement on a general ellipsoid. The resulting three radius regimes have a fully unknown, identifiable LQR witness with a nonzero exact coefficient. Theorem 6D supplies the quadratic displacement rate and subcritical equivalence without a spectral gap. The explicit coefficient and critical law retain their stated spectral hypothesis.
2. **A sharp and resource-controlled comparator separation.** WC has a regular bias determined by value and gain sensitivities. An identifiable family with total input energy one asymptotically attains the universal $1+\rho^2$ limiting risk-ratio bound. A nondegenerate equality instance and the nonregular boundary prevent a universal strict-inefficiency interpretation.
3. **The exact source question and its qualifications.** The source's MR controller has the CE first-order sampling law at fixed confidence. Its spectral worst-case certificate and trace-type sampled risk are different quantities. We supply global localization, explicit near-minimizer control, fixed-confidence quantiles and legitimate mean limits. The cancellation mechanism, Chebyshev geometry and the $o(N^{-1})$ tolerance scale are attributed to their nearest general precedents rather than counted as independent inventions.
4. **Implementation and scope.** We include a shape criterion, a solver-tolerance obstruction, and a common-Lyapunov stability check. No polynomial-time exact solver for general robust LQR, global burn-in guarantee, or joint growing-dimension asymptotic theorem is asserted.

The analysis is pointwise in a fixed stabilizable instance, with fixed state and input dimensions before sample size tends to infinity. The dimension-dependent constructions are sequences of these fixed-instance limits. Proposition 9A has a fixed total excitation-energy budget; its smallest Fisher eigenvalue still decreases with dimension. Mean-risk statements have an additional local safety prior; distributional and fixed-confidence conclusions do not silently assume finite unguarded expectations. Section 9 distinguishes the results from the stronger recent priors [FB26, NK26] and the earlier second-order estimation example [EM03].

## 2. Model, conventions and established tools

Let $n,m\ge1$, $p=n(n+m)$, and $\theta=\operatorname{vec}[A\ B]\in\mathbb R^p$, with column vectorization. The dynamics and static feedback are

$$
x_{t+1}=Ax_t+Bu_t+w_t,\qquad u_t=Kx_t,\qquad
\mathbb E w_t=0,\quad\mathbb E w_tw_t^\top=W\succ0.\tag{2}
$$

The known cost matrices satisfy $Q\succ0$ and $R\succ0$. Write $F_K=A+BK$. If $F_K$ is Schur stable, define

$$
\Sigma_K=W+F_K\Sigma_KF_K^\top,\quad
P_K=Q+K^\top RK+F_K^\top P_KF_K,
\quad C(K,\theta)=\operatorname{tr}(P_KW).
\tag{3}
$$

Otherwise $C(K,\theta)=+\infty$. For a stabilizable pair, let $P_*$ be its stabilizing Riccati solution, $K_*$ its unique optimal gain, and $\Sigma_*\!:=\Sigma_{K_*}$. For a reference parameter $\theta_c$, abbreviate

$$
k_c=\operatorname{vec}K_*(\theta_c),\quad
\Psi_c=R+B_c^\top P_cB_c,\quad
H_c=2(\Sigma_c\otimes\Psi_c),\quad
D_c=\partial_\theta\operatorname{vec}K_*(\theta_c).
\tag{4}
$$

Thus $H_c$ is the Hessian in **gain** coordinates. The parameter Hessian of $\theta\mapsto C(K_*(\theta),\theta_c)$ at $\theta_c$ is $D_c^\top H_cD_c$; the quadratic expansion has one half of this matrix. Keeping these two Hessians distinct avoids a factor-of-two error in risk constants.

### Lemma 1. Performance difference, smoothness and global localization

In a neighborhood of a stabilizable $\theta_c$, $P_*,K_*$ and the stable cost are real analytic. For every stabilizing gain $K$ at a parameter $\theta$,

$$
\begin{aligned}
\mathcal R(K,\theta)&:=C(K,\theta)-C(K_*(\theta),\theta)\\
&=\operatorname{tr}\{\Sigma_K(\theta)
 (K-K_*(\theta))^\top\Psi(\theta)(K-K_*(\theta))\}\\
&\ge\mu\|K-K_*(\theta)\|_F^2,
\qquad \mu=\lambda_{\min}(W)\lambda_{\min}(R)>0.
\end{aligned}\tag{5}
$$

The same inequality holds in the extended sense for nonstabilizing gains.

**Proof.** Stationarity gives $RK_*+B^\top P_*F_*=0$. Subtract the Riccati identity from the Lyapunov identity to obtain

$$
P_K-P_*=(K-K_*)^\top\Psi(K-K_*)+
                 F_K^\top(P_K-P_*)F_K.\tag{6}
$$

Iterating and taking trace against $W$ proves (5), since $\Sigma_K\succeq W$ and $\Psi\succeq R$. The linearized Riccati equation at the stabilizing solution has the operator $X\mapsto X-F_*^\top XF_*$. Its inverse is the convergent Lyapunov series. The analytic implicit function theorem gives real analyticity on a sufficiently small neighborhood; the Riccati and Lyapunov equations are analytic there. Differentiating (5) twice in $k$ gives (4). These are standard LQR tools, included to expose the assumptions. $\square$

For reproducible sensitivity computation, a perturbation $(\dot A,\dot B)$ gives $\dot F_0=\dot A+\dot B K_*$ and

$$
\begin{aligned}
\dot P-F_*^\top\dot PF_*&=\dot F_0^\top P_*F_*+F_*^\top P_*\dot F_0,\\
\Psi\dot K&=-\dot B^\top P_*F_*-B^\top\dot PF_*-B^\top P_*\dot F_0.
\end{aligned}\tag{7}
$$

These equations follow by differentiating the identities just used; they define every column of $D$ through linear solves. No differentiability of a nonsmooth robust objective is assumed.

## 3. A deterministic theorem for model-relative regret

Let $\mathcal B\subset\mathbb R^p$ be nonempty, compact, bounded by a fixed constant, contain zero, and satisfy $\mathcal B=-\mathcal B$. Convexity is not needed in this section. Set

$$
\mathcal E_\varepsilon=\theta_c+\varepsilon\mathcal B,
\quad F_\varepsilon=F_{\mathcal E_\varepsilon},
\quad V_\varepsilon=\inf_K F_\varepsilon(K),
\quad M_c(\mathcal B)=\tfrac12\max_{h\in\mathcal B}\|D_ch\|_{H_c}^2,
\tag{8}
$$

where $\|v\|_H^2=v^\top Hv$. A global $\eta$-near-minimizer satisfies $F_\varepsilon(K_\eta)\le V_\varepsilon+\eta$.

### Theorem 2. Uniform global near-minimizer bound

Fix $a<\infty$. For sufficiently small $\varepsilon>0$, an exact global minimizer exists. Uniformly for $0\le\eta\le a\varepsilon^2$, there is a finite constant $\Lambda$ such that

$$
|V_\varepsilon-\varepsilon^2M_c(\mathcal B)|\le\Lambda\varepsilon^3,
\tag{9}
$$

$$
\|\operatorname{vec}K_\eta-k_c\|_{H_c}^2
 \le4\Lambda\varepsilon^3+2\eta.
\tag{10}
$$

The constants can be chosen uniformly over centers in a sufficiently small compact neighborhood of any fixed stabilizable truth, and over all shapes with the stated uniform norm bound. No assumption $D_c\ne0$ or nonzero value gradient is needed.

**Proof.** A neighborhood of $(K_*(\theta_c),\theta_c)$ is jointly stable. Smoothness of $K_*$ and (5) therefore give a CE feasible bound $F_\varepsilon(K_c)\le U\varepsilon^2$ for a uniform $U$. Because $0\in\mathcal B$, (5) implies for every global near-minimizer

$$
\|K_\eta-K_c\|_F\le\sqrt{(U+a)/\mu}\,\varepsilon.
\tag{11}
$$

This establishes localization before applying any local expansion. A minimizing sequence lies in this shrinking ball. Its closure is inside a jointly stable neighborhood for small $\varepsilon$, where $F_\varepsilon$ is continuous by compactness of $\mathcal B$. It has a convergent subsequence attaining the infimum.

Put $v=\operatorname{vec}K-k_c$. Expanding $K_*(\theta_c+\varepsilon h)=k_c+\varepsilon D_ch+O(\varepsilon^2)$ in (5), and the other matrices to first order, gives uniformly on the ball (11)

$$
\mathcal R(k_c+v,\theta_c+\varepsilon h)
 =\tfrac12\|v-\varepsilon D_ch\|_{H_c}^2+E,
\qquad |E|\le\Lambda\varepsilon^3.
\tag{12}
$$

Choose a maximizer $h_0$ in (8). Its negative also belongs to $\mathcal B$. Averaging the two corresponding quadratic losses yields

$$
\sup_{h\in\mathcal B}\tfrac12\|v-\varepsilon D_ch\|_{H_c}^2
\ge\tfrac14\|v-\varepsilon D_ch_0\|_{H_c}^2
 +\tfrac14\|v+\varepsilon D_ch_0\|_{H_c}^2
=\tfrac12\|v\|_{H_c}^2+\varepsilon^2M_c(\mathcal B).
\tag{13}
$$

At $v=0$, the supremum equals $\varepsilon^2M_c(\mathcal B)$. Combining (12) with the lower bound (13), and then comparing a near-minimizer with CE, proves (9) and (10). Compact neighborhoods give the stated uniformity. $\square$

### Corollary 3. The CE objective certificate and correct remainder orders

For the same sets,

$$
0\le F_\varepsilon(K_c)-V_\varepsilon\le2\Lambda\varepsilon^3.
\tag{14}
$$

For exact MR minimizers the gain difference is $O(\varepsilon^{3/2})$. If $\|\theta_0-\theta_c\|\le c\varepsilon$, their actual excess costs at $\theta_0$ differ by $O(\varepsilon^{5/2})$. These are different orders from the $O(\varepsilon^3)$ **objective** error. Indeed smoothness and stationarity at $K_*(\theta_0)$ give

$$
|\mathcal R(k_c+v,\theta_0)-\mathcal R(k_c,\theta_0)|
\le L(\|\theta_c-\theta_0\|\|v\|+\|v\|^2).
\tag{15}
$$

If $D_c=0$, (5) instead directly gives $F_\varepsilon(K_c)=O(\varepsilon^4)$ and $\|K_\eta-K_c\|=O(\varepsilon^2+\sqrt\eta)$. This latter pointwise improvement is not assumed uniform at random nearby centers. Without further structure this argument does not prove an $O(\varepsilon^2)$ gain error. For ellipsoids, Theorem 6A gives an explicit coefficient under its spectral hypothesis, while Theorem 6D proves the sharper rate without that hypothesis and gives the required uniform neighborhood bound when $D_{\theta_0}=0$.

### Proposition 4. Sharp general order of solver accuracy

The condition $\eta_N=o(N^{-1})$ suffices for first-order equivalence when $\varepsilon=N^{-1/2}$. An $O(N^{-1})$ tolerance cannot guarantee it for **every** allowed near-minimizer.

**Proof of obstruction.** At the fully unknown scalar LQR point $a=0,b=1,Q=R=W=1$, (7) gives $H=4$ and $D=(-1/2,0)$. For a unit Euclidean parameter ball and a deterministic centered estimate, the quadratic MR objective at $k=\varepsilon t$ is

$$
\varepsilon^2\,2(|t|+1/2)^2.
\tag{16}
$$

Its minimum is $\varepsilon^2/2$. For any fixed $t\ne0$, (12) shows that the candidate is within $c_t\varepsilon^2$ of the true optimum for some finite $c_t$, but its gain differs from CE by $\varepsilon t$. Thus an order-$\varepsilon^2$ objective tolerance admits a nonvanishing first-order displacement in an actual LQR model. This is a uniform guarantee obstruction, not a claim that all solvers at this tolerance fail. $\square$

## 4. Sampling laws, critical confidence radii and the original conjecture

Collect $N$ independent trajectories of a fixed length $T$, with independent Gaussian excitation of positive definite covariance and independent Gaussian process noise of covariance $W$. Use a fixed deterministic initial state, for example zero. All entries of $A,B$ are estimated by least squares. Let $z_t=\operatorname{col}(x_t,u_t)$ and

$$
I=\mathbb E\left[\sum_{t=1}^Tz_tz_t^\top\right]\otimes W^{-1}\succ0,
\quad \widehat I_N=N^{-1}\sum_{i=1}^N\sum_{t=1}^Tz_t^iz_t^{i\top}\otimes W^{-1},
\quad S=I^{-1}.
\tag{17}
$$

For a singular empirical Gram matrix, define the estimator and controllers arbitrarily; its probability tends to zero, and Section 8 specifies a safe operational convention. The likelihood scores are $\psi_i=\sum_{t=1}^T(z_t^i\otimes W^{-1})w_t^i$. These scores are iid across trajectories, centered, and have covariance $I$: cross-time terms vanish by conditional mean-zero noise. The weighting by $W^{-1}$ is essential for this information identity. The ordinary iid central limit theorem and law of large numbers, followed by inversion, give

$$
\sqrt N(\widehat\theta_N-\theta_0)\Rightarrow Z\sim N(0,S),
\qquad\widehat I_N\longrightarrow I\quad\text{in probability}.
\tag{18}
$$

The source's ellipsoid, for fixed $0<\delta<1$, is exactly

$$
\mathcal E_N=\widehat\theta_N+
 \frac{\rho}{\sqrt N}\widehat I_N^{-1/2}\mathbb B_p,
\qquad \rho^2=16\{p+\log(2/\delta)\}.
\tag{19}
$$

The conclusions below also hold for any fixed positive radius $\rho$ and consistently estimated positive definite shape, with estimator covariance kept distinct if it differs from that shape. For the risk formulas we use the matched shape $S$ in (19).

### Theorem 5. MR and CE have the same first-order statistical law

For any measurable global MR selection with $\eta_N=o_P(N^{-1})$,

$$
\sqrt N(k_{{\rm MR},N}-k_{{\rm CE},N})\longrightarrow0
\quad\text{in probability},
\tag{20}
$$

$$
\sqrt N(k_{{\rm MR},N}-k_0)\Rightarrow DZ,
\qquad N\mathcal R(K_{{\rm MR},N},\theta_0)
\Rightarrow\tfrac12 Z^\top D^\top HDZ.
\tag{21}
$$

CE has the same limits. Here and below $D,H$ without subscripts are evaluated at the truth. On the event that the local problem exists, a measurable selection exists, for example by minimizing continuously over a fixed local compact gain ball and using a measurable tie rule. Outside that event an arbitrary definition does not affect (20)--(21).

**Proof.** With probability tending to one, the center is in the uniform neighborhood of Theorem 2 and $\widehat I_N^{-1/2}$ has bounded norm. Take $\varepsilon=N^{-1/2}$ and use (10). Multiplication by $N$ gives an upper bound $O_P(N^{-1/2})+2N\eta_N=o_P(1)$ for the squared normalized gain difference. The delta method applies to $K_*$ in (18). Finally (5), or its second-order expansion at the truth, gives the loss limit (21). $\square$

Let

$$
M=S^{1/2}D^\top HD S^{1/2},\quad
\lambda_1,\ldots,\lambda_q>0
\quad\text{be its nonzero eigenvalues}.
\tag{22}
$$

If $D\ne0$, the common limit is $\frac12\sum_{j=1}^q\lambda_j\chi^2_{1,j}$ with independent terms. Its distribution is continuous and strictly increasing on $(0,\infty)$. Hence for every fixed $\alpha\in(0,1)$ the $\alpha$-quantiles of the scaled losses converge to the same quantile. This follows directly by bracketing that quantile at two continuity points and using convergence of distribution functions. When $D=0$ both limits vanish; no nonzero risk ratio or higher-order efficiency claim follows.

For exact solvers under the safeguard of Section 8, the expected losses also satisfy

$$
\lim_{N\to\infty}N\,\mathbb E\mathcal R(K_{{\rm MR},N},\theta_0)
=\lim_{N\to\infty}N\,\mathbb E\mathcal R(K_{{\rm CE},N},\theta_0)
=\tfrac12\operatorname{tr}M.
\tag{23}
$$

### Corollary 6. Spectral certificate, trace risk, and increasing radii

The robust objective itself has

$$
N V_N\longrightarrow\tfrac12\rho^2\lambda_{\max}(M)
\quad\text{in probability}.
\tag{24}
$$

Thus a dimension-dependent spectral worst-case certificate is compatible with an unchanged sampled risk law. The theorem rejects an intrinsic fixed-instance leading-coefficient inefficiency of the exact MR controller in the source model. It does **not** invalidate the source's upper bound or establish uniform growing-dimension bounds.

For radii $\rho_N$ with $\rho_N\ge c>0$ and $\rho_N=o(N^{1/6})$, apply (10) with $\varepsilon_N=\rho_N/\sqrt N$ and the normalized shape $\widehat I_N^{-1/2}\mathbb B_p$. Then

$$
\sqrt N\|k_{{\rm MR},N}-k_{{\rm CE},N}\|
=O_P(\rho_N^{3/2}N^{-1/4})+O_P(\sqrt{N\eta_N})=o_P(1).
\tag{25}
$$

This covers $\rho_N\asymp\sqrt{\log N}$. It is the coarse bound obtained from the general compact-shape argument; Theorem 6D improves the ellipsoidal condition to $\rho_N=o(N^{1/4})$ without a spectral gap. These assertions concern fixed-level sampling limits, not accuracy of Gaussian extreme-tail quantiles at levels $\alpha_N\to0$ or $1$.

### Theorem 6A. An explicit second-order optimizer coefficient

Fix an invertible ellipsoid factor $L$ and consider $\mathcal E_\varepsilon=\theta_c+\varepsilon L\mathbb B_p$. Use $H=H_c$, $D=D_c$ in this theorem and write

$$
E=DL,\qquad \mathscr M=E^\top HE.
\tag{25a}
$$

Assume its largest eigenvalue $\lambda>0$ is simple, with unit eigenvector $u$. Put $y=Eu$, $\Pi=I-uu^\top$, and let $\mathscr Q$ be the inverse of $\lambda I-\mathscr M$ on $u^\perp$, extended by zero on $u$. Thus $\mathscr Q=\Pi\mathscr Q\Pi\succeq0$. Define the cubic polynomial

$$
\mathscr T(v,h)=\frac16\,\mathrm d^3\mathcal R_{(k_c,\theta_c)}
 [(v,Lh),(v,Lh),(v,Lh)],\quad
t=\mathscr T(0,u),
\tag{25b}
$$

and the matrices and vector

$$
\mathscr W=H+HE\mathscr Q E^\top H\succ0,\qquad
r=\mathscr T_v(0,u)-HE\mathscr Q\mathscr T_h(0,u).
\tag{25c}
$$

For all sufficiently small positive $\varepsilon$, the global MR minimizer is unique and

$$
k_{\rm MR}(\theta_c,L,\varepsilon)-k_c
 =\varepsilon^2 w(\theta_c,L)+O(\varepsilon^4),
\tag{25d}
$$

where

$$
w=-\mathscr W^{-1}r+
 \mathscr W^{-1}Hy\,
 \frac{t+y^\top H\mathscr W^{-1}r}
      {y^\top H\mathscr W^{-1}Hy}.
\tag{25e}
$$

The denominator is strictly positive. The coefficient is invariant under $u\mapsto-u$, is real analytic locally in the center and shape with a continuous eigenvector choice, and the remainder is uniform on sufficiently small compact neighborhoods preserving the spectral gap. A global $\eta$-near-minimizer with $\eta\le a\varepsilon^2$ differs from this unique minimizer by $O(\sqrt\eta)$.

**Proof.** Let $k=k_c+\varepsilon v$ and normalize the regret by

$$
f_\varepsilon(v,h)=\varepsilon^{-2}\mathcal R(k_c+\varepsilon v,
                      \theta_c+\varepsilon Lh).
\tag{25f}
$$

The apparent singularity at zero is removable: the constant and linear Taylor coefficients of regret vanish, and its analytic expansion starts at degree two. Therefore, locally in $v,h,\varepsilon$,

$$
f_\varepsilon(v,h)=\tfrac12\|v-Eh\|_H^2
                  +\varepsilon\mathscr T(v,h)+O(\varepsilon^2).
\tag{25g}
$$

At $(v,\varepsilon)=(0,0)$ the only maximizers over the ball are $h=\pm u$. Their outward radial derivative is $\lambda>0$, and the constrained tangent Hessian is $\mathscr M-\lambda I$, negative definite on $u^\perp$. Compactness first localizes every nearby global maximizer into two disjoint neighborhoods of these points. Positive radial derivative forces it onto the sphere. The implicit function theorem for the sphere's stationary equations then gives precisely two analytic maximizing branches $h_+(v,\varepsilon)$ and $h_-(v,\varepsilon)$. Write their values as $f_+(v,\varepsilon)$ and $f_-(v,\varepsilon)$. The local normalized objective is their maximum.

Theorem 2 implies that every global optimizing gain has $v\to0$. At zero the branch gradients are $-Hy$ and $Hy$, both nonzero. Thus a nearby optimum cannot have only one active branch. The equality of both values and the convex-hull stationarity condition give, with a weight $\alpha\to1/2$,

$$
\alpha\nabla_v f_++(1-\alpha)\nabla_v f_-=0,
\qquad f_+-f_-=0.
\tag{25h}
$$

To calculate the derivatives, differentiate the inner sphere equations. At either branch,

$$
\partial_vh_\pm=-\mathscr Q E^\top H,\qquad
\partial_\varepsilon h_\pm=\mathscr Q\mathscr T_h(0,u).
\tag{25i}
$$

The second identity uses the evenness of $\mathscr T_h(0,h)$ in $h$. The envelope derivative now yields $\partial_v^2f_\pm=\mathscr W$ and $\partial_\varepsilon\partial_vf_\pm=r$ at zero. The Jacobian of (25h) in $(v,\alpha)$ is the bordered matrix

$$
\begin{pmatrix}
\mathscr W&-2Hy\\-2y^\top H&0
\end{pmatrix}.
\tag{25j}
$$

It is nonsingular: $\mathscr W\succ0$ and $y\ne0$. Another analytic implicit function theorem gives a unique branch $(v(\varepsilon),\alpha(\varepsilon))$. Conversely this branch has positive active weights for small $\varepsilon$. The gain Hessians of the underlying costs are uniformly positive definite in a convex neighborhood of $k_c$. Their supremum is therefore strongly convex there. Thus the stationary branch is its unique minimizer; global localization shows it is the unique global minimizer of the original problem. The same local strong convexity gives the asserted $O(\sqrt\eta)$ distance for near-minimizers.

Differentiate (25h) at zero. Since $\mathscr T(0,-u)=-t$, one obtains

$$
\mathscr W v'(0)-2Hy\alpha'(0)+r=0,
\qquad y^\top H v'(0)=t.
\tag{25k}
$$

Solving this bordered linear system yields (25e) with $w=v'(0)$. The original ellipsoid is unchanged by $\varepsilon\mapsto-\varepsilon$, so uniqueness makes its optimal gain an even analytic function. Hence $v(\varepsilon)$ is odd and (25d) has a fourth-order remainder. Uniform analyticity and the preserved spectral gap give the local uniform statement. Reversing $u$ reverses both $y$ and $t$ while leaving $r,\mathscr W$ unchanged, proving sign invariance. $\square$

This result requires a simple positive leading eigenvalue. The first-order theorem did not require it. A repeated leading eigenvalue or $D=0$ is not covered by this second-order coefficient; an apparent singular inverse in (25e) cannot be used at such a point.

### Corollary 6B. The critical confidence-radius regimes

Return to (17)--(18), but let $\rho_N\ge c>0$ be deterministic with $\rho_N=o(\sqrt N)$ and use $L_N=\widehat I_N^{-1/2}$. Assume the simple positive eigenvalue condition at $(\theta_0,S^{1/2})$, and let $w_0=w(\theta_0,S^{1/2})$. For exact global MR minimizers,

$$
k_{{\rm MR},N}-k_{{\rm CE},N}
=\frac{\rho_N^2}{N}\{w_0+o_P(1)\}
 +O_P(\rho_N^4/N^2).
\tag{25l}
$$

There are three regimes:

1. If $\rho_N=o(N^{1/4})$, (20)--(21) hold.
2. If $\rho_N/N^{1/4}\to\kappa\in(0,\infty)$, then

$$
\sqrt N(k_{{\rm MR},N}-k_0)\Rightarrow DZ+\kappa^2w_0,
\quad
N\mathcal R(K_{{\rm MR},N},\theta_0)
\Rightarrow\tfrac12(DZ+\kappa^2w_0)^\top H(DZ+\kappa^2w_0).
\tag{25m}
$$

3. If $\rho_N/N^{1/4}\to\infty$ and $w_0\ne0$, then

$$
\frac{N^2}{\rho_N^4}\mathcal R(K_{{\rm MR},N},\theta_0)
\longrightarrow\tfrac12w_0^\top Hw_0>0
\quad\text{in probability}.
\tag{25n}
$$

In the third regime $N\mathcal R$ diverges in probability. For global near-minimizers with $\eta_N=o_P(N^{-1})$, add an $O_P(\sqrt{\eta_N})$ gain error to (25l); this preserves all three sampling-regime conclusions. At the critical scale, under the local safeguard of Section 8, the exact-solvers' mean limit is

$$
\lim_N N\mathbb E\mathcal R(K_{{\rm MR},N},\theta_0)
=\tfrac12\operatorname{tr}M+\tfrac12\kappa^4w_0^\top Hw_0.
\tag{25o}
$$

**Proof.** Apply the uniform form of (25d) at the consistent random center and shape, with $\varepsilon_N=\rho_N/\sqrt N$. Continuity of $w$ gives (25l). At or below the critical scale the remainder multiplied by $\sqrt N$ vanishes. The delta method for CE then proves the first two statements. Above that scale, divide the gain error by $\rho_N^2/N$; the CE error is $O_P(N^{-1/2})=o_P(\rho_N^2/N)$, the normalized remainder tends to zero because $\rho_N=o(\sqrt N)$, and the resulting limit is $w_0$. Expanding regret at the truth gives (25n). Near-minimizer error is $O_P(\sqrt{\eta_N})$, negligible in each stated normalization. For (25o), on a fixed small neighborhood of both the center and information matrix preserving the spectral gap, the local bound becomes $\|K_N-K_0\|\le C(\|\widehat\theta_N-\theta_0\|+\rho_N^2/N)$. The fourth-moment proof of Theorem 15 applies there for $\rho_N=O(N^{1/4})$. Gram and score concentration make its complement exponentially unlikely, including accepted samples outside that smaller neighborhood; the common stability prior bounds their unscaled costs. Hence the same $L^2$ argument proves uniform integrability. The centered Gaussian cross term has zero mean. This does not extend the growing-radius mean assertion to WC. $\square$

The critical shifted quadratic law has continuous nontrivial fixed-level quantiles, by the same continuity argument as after (22). It is not a moderate-deviation approximation to changing tail levels. The threshold is sharp on the simple-eigenvalue class because the following instance has $w_0\ne0$; if $w_0=0$, higher orders can determine a later transition.

### Proposition 6C. A full-parameter LQR witness with an exact nonzero coefficient

Take $a=b=1$, $Q=R=W=1$, with both $a,b$ unknown and two-step experiments from zero with unit input variance. Here $S=I_2/2$. Let $H=3+7\sqrt5/5$, $L=I_2/\sqrt2$ and choose

$$
u=\frac{(-3,1)^\top}{\sqrt{10}},\quad
h=Lu=\frac{(-3,1)^\top}{2\sqrt5},\quad
y=Dh=\frac{\sqrt5-1}{2}.
\tag{25p}
$$

The gain is scalar and $D\ne0$, so $L^\top D^\top HDL$ has one simple positive eigenvalue. Its second-order MR coefficient is

$$
w_0=-\frac18-\frac{7\sqrt5}{40}\ne0,
\qquad \tfrac12Hw_0^2=\frac{13}{32}+\frac{147\sqrt5}{800}.
\tag{25q}
$$

Thus the critical mean constant is $1/2+3\sqrt5/10+\kappa^4(13/32+147\sqrt5/800)$, strictly larger than CE's constant for every $\kappa>0$.

**Proof.** At this center the Riccati root and derivatives are the $m=1$ case of (37)--(38). Along the parameter direction $h$, implicit differentiation twice gives

$$
z=\frac{\mathrm d^2}{\mathrm ds^2}K_*(\theta_0+sh)\bigg|_{s=0}
=\frac34-\frac{11\sqrt5}{20}.
\tag{25r}
$$

Hold the gain at $k_0$ and put $B(s)=\Psi(\theta_0+sh)\Sigma_{k_0}(\theta_0+sh)$. Direct differentiation of the scalar Lyapunov and Riccati formulas gives $B(0)=H/2$ and $B'(0)=-7/5-3\sqrt5/5$. By the exact identity (5),

$$
\mathcal R(k_0,\theta_0+sh)
=\tfrac12Hy^2s^2+
 \{\tfrac12Hyz+y^2B'(0)\}s^3+O(s^4).
\tag{25s}
$$

Therefore $t=-19/20-9\sqrt5/20$. In one gain dimension the constraint $yHw=t$ in (25k) alone determines $w=t/(Hy)$, giving (25q). The sample design has positive definite Fisher matrix $2I_2$; neither parameter is treated as known. The exact algebra and optimization over the full ellipse, rather than only two preselected parameter points, are checked by the accompanying reproduction code. $\square$

### Theorem 6D. Quadratic displacement without a spectral gap

Fix a stabilizable truth $\theta_0$. Let $\theta_c$ vary in a sufficiently small compact neighborhood and let the invertible ellipsoid factors $L$ vary in a compact set of invertible matrices. For $\mathcal E_\varepsilon=\theta_c+\varepsilon L\mathbb B_p$, the exact global MR minimizer is unique for sufficiently small $\varepsilon$. If $D_{\theta_0}\ne0$, uniformly over these centers and factors,

$$
\|k_{\rm MR}-k_c\|\le C\varepsilon^2.
\tag{25t}
$$

No singular-value multiplicity, rank, or leading-eigenvalue gap is assumed. If instead $D_{\theta_0}=0$, the uniform statement is

$$
\|k_{\rm MR}-k_c\|
\le C\{\varepsilon\|\theta_c-\theta_0\|+\varepsilon^2\}.
\tag{25u}
$$

For the global near-minimizers of Theorem 2, add $C\sqrt\eta$ to the corresponding bound. In particular, in (17)--(18), for any $\rho_N\ge c>0$ with $\rho_N=o(N^{1/4})$ and $\eta_N=o_P(N^{-1})$, MR and CE have the same first-order gain and loss laws, including when $D_{\theta_0}=0$. For fixed $\rho$, exact minimizers satisfy a gain difference $O_P(N^{-1})$ and true excess-cost difference $O_P(N^{-3/2})$. The latter difference is defined on the common stable event, whose probability tends to one, and extended by any finite value on its complement; alternatively use the globally stable safeguarded controllers of Section 8. No subtraction of two infinite costs is intended.

**Proof.** By global localization, every exact minimizer lies in a common stable gain ball. On a sufficiently small such convex ball, each model-relative regret has a uniformly positive gain Hessian; its supremum is therefore uniformly strongly convex. This gives uniqueness, and also the $C\sqrt\eta$ near-minimizer distance. All constants below are uniform in the stated compact sets.

First suppose $D_{\theta_0}\ne0$. Put $T_c=H_c^{1/2}/\sqrt2$ and $\mathscr L=T_cD_cL$. For $k=k_c+\varepsilon T_c^{-1}z$ and $\theta=\theta_c+\varepsilon Lu$, the normalized loss has the expansion

$$
g_\varepsilon(z,u)
=\varepsilon^{-2}\mathcal R(k_c+\varepsilon T_c^{-1}z,\theta_c+\varepsilon Lu)
=\|z-\mathscr Lu\|^2+\varepsilon R_\varepsilon(z,u),
\qquad \|u\|\le1.
\tag{25v}
$$

Analyticity and the removable quadratic zero give uniformly bounded $R_\varepsilon$ and its first two derivatives on bounded $z$ sets. Theorem 2 makes the optimizing $z$ uniformly bounded. Write $F=\max_{\|u\|\le1}g_\varepsilon(z,u)$ at that optimizer. Danskin's formula and finite-dimensional convexity give active directions $u_i$ and weights $p_i\ge0$, $\sum_i p_i=1$, with at most $nm+1$ terms. For $v_i=\mathscr Lu_i$,

$$
\bar v:=\sum_i p_iv_i=z+O(\varepsilon).
\tag{25w}
$$

The norms $\|\mathscr L\|$ are bounded below by a positive constant. Every active $u_i$ is on the unit sphere: at an interior maximum the Hessian in a top right-singular direction would have to be nonpositive, whereas (25v) makes it $2\|\mathscr L\|^2+O(\varepsilon)>0$. Normalize the sphere multiplier by $\nabla_u g_\varepsilon(z,u_i)=2\lambda_i u_i$. Multiplying this equation by $\mathscr L$, and separately taking its inner product with $u_i$, gives

$$
\begin{aligned}
\lambda_iv_i&=\mathscr L\mathscr L^\top(v_i-z)+O(\varepsilon),\\
\lambda_i&=\|v_i\|^2-z^\top v_i+O(\varepsilon)
          =c+z^\top v_i+O(\varepsilon),\qquad c=F-\|z\|^2.
\end{aligned}
\tag{25x}
$$

The last equality uses activity and (25v). Both $c$ and $v_i$ are uniformly bounded. Average the first line with the weights $p_i$ and use (25w) to make its right side $O(\varepsilon)$. Substituting the second line then yields

$$
\left[cI+\sum_i p_iv_iv_i^\top\right]z=O(\varepsilon).
\tag{25y}
$$

Pairing a top right-singular vector $u$ with $-u$ in the maximum in (25v) gives $c\ge\|\mathscr L\|^2-C\varepsilon$. The matrix in (25y) is consequently bounded below by a fixed positive multiple of the identity. Thus $z=O(\varepsilon)$ and (25t) follows. The active directions and weights may change with $\varepsilon$; no differentiability of either was used, and their convex averages preserve the uniform remainders.

When $D_{\theta_0}=0$, do not divide by $\|\mathscr L\|$. At $k_c$, uniformly for $\|u\|\le1$,

$$
\nabla_k\mathcal R(k_c,\theta_c+\varepsilon Lu)
=-\varepsilon H_cD_cLu+O(\varepsilon^2),\qquad
\|D_c\|\le C\|\theta_c-\theta_0\|.
\tag{25z}
$$

Every active convex combination at $k_c$ has norm at most the right side of (25u). Strong monotonicity of the subgradient of the locally strongly convex supremum, applied between $k_c$ and its minimizer, gives (25u).

Finally, $\widehat\theta_N-\theta_0=O_P(N^{-1/2})$ and $L_N=\widehat I_N^{-1/2}$ lies in a fixed compact invertible neighborhood with probability tending to one. Set $\varepsilon_N=\rho_N/\sqrt N$. Both cases imply

$$
\sqrt N\|k_{{\rm MR},N}-k_{{\rm CE},N}\|
=O_P\!\left(\frac{\rho_N^2+\rho_N}{\sqrt N}\right)
 +O_P(\sqrt{N\eta_N})=o_P(1).
\tag{25aa}
$$

Theorem 5's loss expansion then gives the same first-order law. For fixed $\rho$ and exact minimizers, (25t)--(25u) give $O_P(N^{-1})$ displacement, and (15) gives $O_P(N^{-3/2})$ true-cost difference. Those finer rates also hold when $\eta_N=O_P(N^{-2})$; the weaker $o_P(N^{-1})$ condition alone guarantees only first-order equivalence. Expectation statements still require the safeguard and uniform integrability of Section 8. This proof does not identify a second-order coefficient at a repeated leading eigenvalue. $\square$

## 5. The exact role of uncertainty-set shape

Central symmetry is sufficient but not necessary. For a general nonempty compact $\mathcal B$ containing zero, define the $H_c$-Chebyshev center of the sensitivity image by

$$
v_{\mathcal B}=\arg\min_v\max_{h\in\mathcal B}
                     \tfrac12\|v-D_ch\|_{H_c}^2.
\tag{26}
$$

### Theorem 7. Shape criterion

For exact MR minimizers,

$$
k_{\rm MR}=k_c+\varepsilon v_{\mathcal B}+O(\varepsilon^{3/2}),
\tag{27}
$$

with an additional $O(\sqrt\eta)$ term for near-minimizers satisfying the localization bound. Let $\mathcal A$ be the set of farthest image points $D_ch$ from zero. Then

$$
v_{\mathcal B}=0\quad\Longleftrightarrow\quad
       0\in\operatorname{conv}\mathcal A.
\tag{28}
$$

**Proof.** The objective in (26), minus $\frac12\|v\|_{H_c}^2$, is a supremum of affine functions, so it is strongly convex and coercive. Its unique minimizer lies in the convex hull of the compact image. The Taylor and localization arguments of Theorem 2 apply also at $k_c+\varepsilon v_{\mathcal B}$. Comparing the true objective with its quadratic approximation and using strong convexity gives (27). At zero its subdifferential is $\operatorname{conv}\{-H_c y:y\in\mathcal A\}$. Since $H_c$ is invertible, its containing zero is equivalent to (28). $\square$

This is classical Chebyshev-center geometry applied to LQR sensitivities. Asymmetry in a direction annihilated by $D_c$ has no first-order effect. Conversely a one-sided interval whose image is a nontrivial line segment has a nonzero midpoint and can create an MR bias. We do not attribute these general convex-geometric facts to this work.

## 6. Worst-total-cost synthesis: regular bias and sharp realizable separation

Define

$$
g=\partial_\theta C(k_0,\theta_0)
 =\partial_\theta C(K_*(\theta),\theta)|_{\theta_0},
\quad G=\partial^2_{k\theta}C(k_0,\theta_0),\quad D=-H^{-1}G.
\tag{29}
$$

The equality for $g$ is the envelope identity, since $\partial_k C=0$ at the optimum. It is a gradient of total optimal value, and is absent from model-relative regret's leading quadratic objective.

### Theorem 8. Regular total-cost law

If $g\ne0$, then along centers $\theta_c\to\theta_0$, positive definite shapes $S_c\to S$, and radii $\rho_c\to\rho>0$,

$$
k_{\rm WC}(\theta_c+\varepsilon\rho_c S_c^{1/2}\mathbb B_p)
=k_c+\varepsilon b+o(\varepsilon),
\quad b=\rho D\frac{Sg}{\sqrt{g^\top Sg}}.
\tag{30}
$$

The global minimizer exists and is unique for sufficiently small sets. For (18)--(19),

$$
\sqrt N(k_{{\rm WC},N}-k_0)\Rightarrow DZ+b,
\quad N\mathcal R(K_{{\rm WC},N},\theta_0)
\Rightarrow\tfrac12(DZ+b)^\top H(DZ+b).
\tag{31}
$$

Under Section 8's safeguard its mean coefficient is

$$
c_{\rm WC}=\tfrac12\operatorname{tr}M+
 \frac{\rho^2}{2}\frac{g^\top S D^\top HD Sg}{g^\top Sg}.
\tag{32}
$$

Consequently the regular mean penalty is zero if and only if $DSg=0$. For $\operatorname{tr}M>0$, writing $v=S^{1/2}g/\sqrt{g^\top Sg}$,

$$
1\le\frac{c_{\rm WC}}{c_{\rm CE}}
=1+\rho^2\frac{v^\top Mv}{\operatorname{tr}M}
\le1+\rho^2\frac{\lambda_{\max}(M)}{\operatorname{tr}M}
\le1+\rho^2.
\tag{33}
$$

**Proof.** CE gives a total-cost robust value converging to $C(K_0,\theta_0)$. Since the center is in the set, (5) forces all global minimizing sequences into a neighborhood of $K_0$. Cost is lower semicontinuous with value $+\infty$ at instability; this can also be seen as the increasing limit of finite partial Lyapunov sums with nonnegative terms. Coercivity follows from $C(K,\theta_c)\ge\lambda_{\min}(R)\lambda_{\min}(W)\|K\|_F^2$. Compact sublevels give existence. In a sufficiently small convex gain neighborhood every $C(\cdot,\theta)$ has a uniformly positive Hessian, so the maximum is strongly convex there and the global minimizer is unique.

At that interior minimizer zero lies in the convex hull of gradients of active models. Each gradient differs from the center-model gradient by $O(\varepsilon)$ uniformly. Strong convexity then gives $\|k_{\rm WC}-k_c\|=O(\varepsilon)$, an improvement over the preliminary $O(\sqrt\varepsilon)$ cost-value bound.

Uniformly on this localized set, the first-order model dependence is $\varepsilon\rho g^\top S^{1/2}u$. On the unit ball it has the unique maximizer $u_*=S^{1/2}g/\sqrt{g^\top Sg}$. Compactness implies convergence of every active model direction to $u_*$. Expanding the active gain gradients and taking their convex combination gives

$$
0=H(k_{\rm WC}-k_c)+\varepsilon G\rho Sg/\sqrt{g^\top Sg}+o(\varepsilon).
\tag{34}
$$

This proves (30). The delta method and the quadratic loss expansion give (31). Uniform integrability from Section 8 permits passage to expectations, where the centered Gaussian cross term vanishes, proving (32). Positive definiteness of $H$ proves the equality criterion; Rayleigh quotient bounds prove (33). $\square$

The sensitivity mechanism underlying (30) is established in robust optimization, including [BDOW21]. Our claim is its precise LQR comparison with Theorem 5, the realizable examples below and the nonregular boundary, rather than invention of a general robust-optimizer derivative formula.

### Proposition 9. A fully identifiable dimension-proportional separation

For each $m\ge1$, let the state be scalar, the input have dimension $m$, and

$$
a=1,\quad b=e_1,\quad Q=W=1,\quad R=I_m.
\tag{35}
$$

All $m+1$ entries of $(a,b)$ remain unknown. Run two-step independent trajectories from $x_1=0$, with input covariance $\operatorname{diag}(1,V,\ldots,V)$ and $V=m^2$. At the truth $x_2=u_{1,1}+w_1$, independent of $u_2$. Therefore

$$
I=\operatorname{diag}(2,2,2V,\ldots,2V),\quad
S=\operatorname{diag}(1/2,1/2,1/(2V),\ldots,1/(2V)).
\tag{36}
$$

Writing $\varphi=(1+\sqrt5)/2$, $k=-1/\varphi$ and $f=1+k=1/\varphi^2$, we have

$$
P=\varphi,\quad K_0=ke_1,\quad\Sigma=(1-f^2)^{-1},
\quad H=2\Sigma\operatorname{diag}(\varphi^2,1,\ldots,1),
\tag{37}
$$

$$
\begin{aligned}
D_a&=(-3/2+3\sqrt5/10)e_1=d_a e_1,\\
D_{b_1}&=(1/2-\sqrt5/10)e_1=d_b e_1,\\
D_{b_j}&=k e_j\quad (j\ge2),\qquad d_a+kd_b=-1.
\end{aligned}\tag{38}
$$

The exact guarded risk constants are

$$
c_{\rm MR}=c_{\rm CE}=\frac12+\frac{3\sqrt5}{10}
                 +\frac{\sqrt5}{10}\frac{m-1}{V},
\tag{39}
$$

$$
c_{\rm WC}=c_{\rm CE}+\rho^2\left(\frac{11}{20}+\frac{\sqrt5}{4}\right).
\tag{40}
$$

For the radius (19), at fixed $\delta$, their WC/CE ratio is $\Theta(m)=\Theta(p)$, while the MR/CE ratio is exactly one at this limiting order.

**Proof.** The scalar-state Riccati polynomial, with $\beta=\|b\|^2$, is $\beta P^2+(1-a^2-\beta)P-1=0$, and $K=-aPb/(1+\beta P)$. Implicit differentiation at $(a,\beta)=(1,1)$ gives $P_a=2\varphi/\sqrt5$ and $P_{b_1}=-2/\sqrt5$ and then (38). The value gradient is $g=c(1,k,0,\ldots,0)^\top$ with $c=2Pf\Sigma>0$, so $DSg=-(c/2)e_1$ and $g^\top Sg=(c^2/2)(1+k^2)$. Substitution into (23) and (32) gives (39)--(40). The algebra is independently reproducible over $\mathbb Q(\sqrt5)$.

For the score in (36), $\psi=(0,u_1)w_1+(x_2,u_2)w_2$. Its cross term vanishes because $w_2$ is independent and centered, despite dependence between $x_2$ and $w_1$. Thus no independence error is hidden in the information computation. The scaling is per trajectory: the multiplier is $N$, not the number $2N$ of transitions. $\square$

The order of limits is first $N\to\infty$ for each fixed $m$, and only then $m\to\infty$ in these explicit constants. The extra channels use excitation variance $m^2$. The following stronger construction removes that energy growth while retaining the same order of limits.

### Proposition 9A. Fixed total energy and asymptotic attainment of the upper bound

For each $m\ge2$, let $a_m=m^{-2}$, $b=e_1$, $Q=W=1$, $R=I_m$, and collect two-step independent trajectories with input covariance $I_m/m$. Thus every one of the $m+1$ dynamics coefficients is unknown and $\mathbb E\|u_t\|^2=1$. The exact inverse Fisher matrix is

$$
S=\operatorname{diag}(s_a,s_b,\ldots,s_b),\qquad
s_a=\frac m{m+1},\quad s_b=\frac m2.
\tag{40a}
$$

Let $c_{{\rm CE},m}$ and $c_{{\rm WC},m}$ denote the fixed-instance guarded mean constants and define $\beta_m=(c_{{\rm WC},m}-c_{{\rm CE},m})/\rho_m^2$. Then

$$
c_{{\rm CE},m}=\tfrac12s_a+O(m^{-2}),\qquad
\beta_m=\tfrac12s_a+O(m^{-3}),\qquad
\frac{c_{{\rm WC},m}/c_{{\rm CE},m}-1}{\rho_m^2}\longrightarrow1.
\tag{40b}
$$

Consequently the universal upper bound $1+\rho_m^2$ in (33) is asymptotically attained. For (19) with fixed $\delta$, $c_{{\rm WC},m}/(m c_{{\rm CE},m})\to16$, whereas $c_{{\rm MR},m}=c_{{\rm CE},m}$ at every fixed $m$.

**Proof.** For temporary $a>0$ and $b=e_1$ set

$$
\Delta=\sqrt{a^4+4},\quad P=\frac{a^2+\Delta}{2},\quad
k=-\frac{aP}{1+P},\quad f=\frac a{1+P},\quad
\Sigma=(1-f^2)^{-1}.
\tag{40c}
$$

Differentiating the Riccati polynomial used in Proposition 9 gives

$$
d_a=-\frac{P}{1+P}-\frac{2a^2P}{\Delta(1+P)^2},\qquad
d_b=\frac{aP(P-1)}{(1+P)^2}\left(1+\frac2\Delta\right),
\quad D_{b_j}=k e_j\ (j\ge2).
\tag{40d}
$$

These derivatives include the change in $\|b\|^2$; setting the other nominal input coefficients to zero does not remove them from the statistical or control problem. Taylor expansion at $a=0$ gives

$$
\begin{aligned}
P&=1+a^2/2+O(a^4),& k&=-a/2-a^3/8+O(a^7),\\
d_a&=-1/2-3a^2/8+O(a^6),&d_b&=a^3/4+O(a^5),\\
\Sigma&=1+a^2/4+O(a^4).
\end{aligned}\tag{40e}
$$

Again $g=c(1,k,0,\ldots,0)$ with $c=2Pf\Sigma>0$. Therefore

$$
\begin{aligned}
c_{{\rm CE},m}
 &=\Sigma(1+P)(s_a d_a^2+s_b d_b^2)
       +\Sigma(m-1)s_b k^2,\\
\beta_m
 &=\Sigma(1+P)\frac{(s_a d_a+s_b k d_b)^2}{s_a+s_b k^2}.
\end{aligned}\tag{40f}
$$

At $a=m^{-2}$, the state, distinguished-input and other-input contributions in the first line are respectively $s_a/2+O(a^2)$, $O(ma^6)$ and $O(m^2a^2)$. In the second line the numerator is $s_a^2/2+O(a^2+ma^4)$ and the denominator is $s_a+O(ma^2)$, bounded away from zero. These bounds prove (40b). A useful exact nonnegative shortfall identity is

$$
c_{{\rm CE},m}-\beta_m
=\Sigma(1+P)\frac{s_as_b(d_b-kd_a)^2}{s_a+s_b k^2}
 +\Sigma(m-1)s_bk^2.
\tag{40g}
$$

It is strictly positive for every $m\ge2$, so the bound is approached rather than attained at any finite member. The Fisher eigenvalues are $1+1/m$ and $2/m$ with multiplicity $m$. Also $d_a<0$ and $k\ne0$, so $D$ has full row rank $m$. All coordinates are identifiable and every orthogonal input coefficient changes the optimal gain to first order. This is not dimension inflation by statistically invisible or control-irrelevant parameters. $\square$

For a concrete safety prior, take an outer parameter ball of radius $1/10$ about $(a_m,e_1)$, an inner ball of radius $1/20$, the gain ball $\|K\|\le2/5$, and anchor zero. Every outer model/gain pair has closed-loop magnitude at most $1/4+2/5+\sqrt{1+(2/5)^2}/10<4/5$. In the inner ball the Riccati formula yields $\|K_*\|\le|a|/\|b\|\le6/19<2/5$. Thus the guarded mean realization has explicit uniform stability margins. Statistical information lower bounds and concentration constants may depend on $m$. The limit is still $N\to\infty$ first at each fixed $m$; $a_m\to0$ does not grant a uniform interchange with the nonregular boundary.

### Proposition 10. Nondegenerate regular equality is possible

For scalar $a=b=1/2$, $Q=R=W=1$, the same two-step design with input variance

$$
v=\frac4{47+24\sqrt5}
\tag{41}
$$

has $g\ne0$, $D\ne0$, $I\succ0$, but $DSg=0$. Indeed

$$
\begin{gathered}
P=\sqrt5-1,\quad k=2-\sqrt5,\\
d_a=-6+12\sqrt5/5=3d_b,\qquad d_b=-2+4\sqrt5/5,\\
s_a=(1+v/4)^{-1},\quad s_b=(2v)^{-1},\quad s_b/s_a=6+3\sqrt5=-3/k.
\end{gathered}\tag{42}
$$

Again $g=c(1,k)$ with $c\ne0$, so $DSg=c(s_a d_a+s_b k d_b)=0$. These quantities follow from the same Riccati polynomial and score calculation as Proposition 9. This excludes a universal strict-inefficiency statement even for regular WC synthesis.

## 7. The zero-value-gradient boundary

### Proposition 11. Location of the boundary

For the full unknown-$(A,B)$ parameterization,

$$
g=0\quad\Longleftrightarrow\quad A=0.
\tag{43}
$$

**Proof.** At an optimum, differentiating (3) while holding the gain fixed gives

$$
\nabla_A C=2P_*F_*\Sigma_*,\qquad
\nabla_B C=2P_*F_*\Sigma_*K_*^\top.
\tag{44}
$$

The first matrix vanishes precisely when $F_*=0$, since $P_*,\Sigma_*$ are invertible. Stationarity $RK_*+B^\top P_*F_*=0$ then gives $K_*=0$ and hence $A=0$. Conversely $A=0$ gives $K_*=0,P_*=Q,F_*=0$. The equivalence uses the full parameterization and is not asserted for structured parameter submodels. $\square$

### Theorem 12. Nonregular total-cost limit

At $A=0$, suppose (18) holds, and let $Z_A$ be the matrix-shaped $A$-block of $Z$, with covariance block $S_{AA}$ under vectorization. Define the explicit finite-dimensional convex problem

$$
\begin{aligned}
\mathcal L(U;Z_A)=&\operatorname{tr}(U^\top RUW)\\
&+\max_{\|v\|_2\le\rho}
 \left\|Q^{1/2}\{Z_A+BU+\operatorname{mat}(S_{AA}^{1/2}v)\}W^{1/2}\right\|_F^2,
\qquad U_*(Z_A)=\arg\min_U\mathcal L(U;Z_A).
\end{aligned}\tag{45}
$$

Its minimizer is unique, continuous in $Z_A$, and grows at most linearly in $\|Z_A\|+\rho$. For WC synthesis,

$$
\sqrt N K_{{\rm WC},N}\Rightarrow U_*(Z_A),\qquad
N\mathcal R(K_{{\rm WC},N},\theta_0)
\Rightarrow\operatorname{tr}\{U_*^\top(R+B^\top QB)U_*W\}.
\tag{46}
$$

The corresponding mean limit follows with Section 8's safeguard. Equation (45) is a convex quadratic uncertainty problem with known coefficients, not a closed-form solution for arbitrary matrix dimensions. The MR result in Theorem 5 remains valid at this boundary without modification.

**Proof.** With $\varepsilon=N^{-1/2}$, put $K=\varepsilon U$, $A=\varepsilon(Z_A+E_A)+o(\varepsilon)$, and $B_N=B+O(\varepsilon)$. The closed-loop matrix is $\varepsilon(Z_A+E_A+BU)+o(\varepsilon)$. Expanding the Lyapunov series gives, uniformly on compact scaled sets,

$$
C(\varepsilon U,\theta)=\operatorname{tr}(QW)+\varepsilon^2
 \left[\operatorname{tr}(U^\top RUW)+
 \|Q^{1/2}(Z_A+E_A+BU)W^{1/2}\|_F^2\right]+o(\varepsilon^2).
\tag{47}
$$

The projection of a positive definite ellipsoid onto the $A$ block is exactly the ellipsoid with shape $S_{AA}$, as follows by taking the support function in every $A$ direction. Terms involving perturbations of $B$ multiply $K$ and are higher order. The candidate $K=0$ bounds the robust total cost above its baseline by $O(\varepsilon^2)$ on compact $Z_A$ sets. Since $C(K,\theta)\ge\operatorname{tr}(QW)+\operatorname{tr}(K^\top RKW)$ for every stable model, all minimizing scaled gains are bounded. This is global localization in this nonregular case. Uniform convergence of (47) therefore reduces the minimization to (45).

The first term of (45) is strongly convex; the second is a maximum of convex quadratics. Thus the minimizer is unique. Compactness and uniqueness prove continuity. Comparing with $U=0$ bounds its norm by a constant times $\|Z_A\|+\rho$. The compact argmin argument and (18) yield (46); at the truth the quadratic form is obtained by setting $Z_A+E_A=0$ in (47). $\square$

### Corollary 13. Scalar nonlinear law and its exact mean

Take $a=0$, scalar $b\ne0$, $Q=q>0,R=r>0,W=1$, and write $Z_A=\sigma X$ with $X\sim N(0,1)$. Set $\gamma=qb^2/r$, $\zeta=\gamma/(1+\gamma)$ and $t=\gamma\rho$. Then

$$
U_*(z)=-\frac{\operatorname{sgn}z}{b}
       \min\{|z|,\zeta(|z|+\rho\sigma)\}.
\tag{48}
$$

Let $\phi$ and $\overline\Phi$ be the standard normal density and upper tail. Define

$$
\begin{aligned}
\mathcal M(\gamma,\rho)=1
&-2(1-\zeta^2)\{t\phi(t)+\overline\Phi(t)\}\\
&+4\zeta^2\rho\phi(t)+2\zeta^2\rho^2\overline\Phi(t).
\end{aligned}\tag{49}
$$

The guarded mean coefficients are

$$
c_{{\rm WC},0}=\frac{(r+qb^2)\sigma^2}{b^2}\mathcal M(\gamma,\rho),
\qquad c_{{\rm CE},0}=c_{{\rm MR},0}
=\frac{(r+qb^2)\sigma^2}{b^2}\zeta^2.
\tag{50}
$$

For every $\rho>0$, the WC coefficient is strictly larger.

**Proof.** The scalar objective is $ru^2+q(|z+bu|+\rho\sigma)^2$. In the positive or negative residual region, differentiation gives the second branch in (48); it is feasible exactly when $|z|>\gamma\rho\sigma$. Otherwise the unique minimum has residual zero, $u=-z/b$. Strong convexity handles the junction. Integrating the square of (48) uses

$$
\mathbb E[X^2 1_{|X|>t}]=2\{t\phi(t)+\overline\Phi(t)\},
\qquad \mathbb E[|X|1_{|X|>t}]=2\phi(t),
\tag{51}
$$

which follow by elementary integration by parts. This gives (49)--(50). Both entries in the minimum in (48) are strictly larger than $\zeta|z|$ for $z\ne0$ when $\rho>0$, proving the strict inequality. At $a=b=0$ the $N$-scaled limiting coefficients vanish; finer rates at this doubly degenerate point are outside our claim. $\square$

## 8. Stability certification and legitimate expectation limits

### Proposition 14. A computable common-Lyapunov check

For a stable nominal closed loop $F_c=A_c+B_cK_c$, solve $F_c^\top LF_c-L=-I$, $L\succ0$. Suppose $\|A-A_c\|\le d_A$, $\|B-B_c\|\le d_B$ and $\|K-K_c\|\le s$. Put

$$
d_F=d_A+d_B\|K_c\|+(\|B_c\|+d_B)s.
\tag{52}
$$

If

$$
2\|F_c^\top L\|d_F+\|L\|d_F^2<1,
\tag{53}
$$

the entire parameter and gain set is jointly Schur stable with a uniform margin. Expand $(F_c+E)^\top L(F_c+E)-L$ and bound its quadratic form by $-[1-2\|F_c^\top L\|d_F-\|L\|d_F^2]I$. This proves the claim. Failure of (53) means only failure of this sufficient certificate.

### Theorem 15. An implementable local safeguard gives the mean constants

For expectation statements assume an additional **known local safety prior**: compact parameter neighborhoods $\Theta_{\rm in}\subset\operatorname{int}\Theta_{\rm out}$, a compact convex gain set $\mathcal K$, and a known anchor $K_a\in\mathcal K$. Every pair in $\Theta_{\rm out}\times\mathcal K$ has a common strict stability certificate, and $K_*(\theta)\in\operatorname{int}\mathcal K$ for $\theta\in\Theta_{\rm in}$. The truth is in the interior of $\Theta_{\rm in}$. Such local sets exist around any stabilizable nominal pair by continuity and (53); their knowledge is an extra operational assumption, not a consequence of a confidence set containing the truth with high probability.

Choose a deterministic information threshold below half the minimum information eigenvalue over a sufficiently small prior neighborhood. Return $K_a$ if the empirical information fails this threshold, the estimate is outside $\Theta_{\rm in}$, or its ellipsoid is not contained in $\Theta_{\rm out}$. Otherwise compute CE or an exact MR/WC minimizer restricted to $\mathcal K$. Use the same safeguard for every method. This algorithm always deploys a gain stable at every parameter in the prior.

For fixed dimension, fixed $T$ and fixed $\rho$, its scaled excess costs are uniformly integrable. Thus (23), (32) and the mean assertion in (46) hold.

**Proof.** Each trajectory's state is linear in finitely many Gaussian variables. Gram and score entries are quadratic Gaussian polynomials, iid across trajectories; their moment-generating functions exist near zero. A finite union of scalar Chernoff bounds shows exponentially small probabilities of fixed Gram or score deviations. Since the true parameter is an interior point and the information is positive definite, safeguard rejection has probability at most $Ce^{-cN}$ for large $N$.

On acceptance, inversion is bounded and

$$
\|\widehat\theta_N-\theta_0\|
\le C\left\|N^{-1}\sum_{i=1}^N\psi_i\right\|,
\qquad
\mathbb E\left\|N^{-1}\sum_{i=1}^N\psi_i\right\|^4\le C'N^{-2}.
\tag{54}
$$

The fourth-moment inequality follows by expanding coordinatewise: only paired or fourfold equal indices survive, since scores are iid and centered. The previously proved localization yields $\|K_N-K_0\|\le C(\|\widehat\theta_N-\theta_0\|+N^{-1/2})$ on the accepted local event. Stable cost smoothness then gives $\mathcal R(K_N,\theta_0)\le C\|K_N-K_0\|^2$. This bounds the second moment of $N\mathcal R$ there. The remaining accepted events outside a fixed small neighborhood have exponentially small probability by the same concentration bounds; compact common stability bounds their unscaled cost. The rejected event also has uniformly bounded unscaled cost, so its contribution to the scaled second moment is at most $C N^2e^{-cN}$. Hence the scaled costs are bounded in $L^2$.

For centers approaching the truth and shrinking ellipsoids, all unrestricted global minimizers are in the interior of $\mathcal K$ by the localization proofs, so restriction is asymptotically inactive. The same applies to CE. Uniform integrability and the distributional limits now imply the asserted expectations. This proof is for exact solvers; an approximate solver needs an explicit corresponding moment bound on $N\eta_N$, not merely convergence in probability. $\square$

For Proposition 9 an explicit safety example is the parameter ball $\|\theta-(1,e_1)\|\le1/10$, the gain ball $\|K+(4/5)e_1\|\le1/4$, and anchor $K_a=-e_1$. Gain norms are at most $21/20$. The nominal closed-loop magnitude is at most $9/20$ and parameter perturbations add at most $\sqrt{1+(21/20)^2}/10<3/20$. Thus the magnitude is strictly below $3/5$ for every pair. A smaller inner neighborhood contains the nominal truth and keeps its optimal gain in the interior. This is a concrete safe realization of the family, not an assumption of finite cost on unstable events.

## 9. Related work, attribution and reproducibility

The motivating LQR question is [FLMP25], whose comparator and confidence ellipsoid are used exactly as specified. Existing CE theory [MTR19, DMT+20] supplies context and standard perturbation tools. The comparison in [DTP23] concerns direct data-driven LQR formulations and robustness to noise. Our statistical object is instead the excess cost of the controller produced by shrinking model sets. That distinction does not replace or subsume those synthesis guarantees.

**First-order regret cancellation is prior theory.** Fiechtner--Blanchet [FB26, Theorem 3 and Appendix B.7] prove a second-order regret-value expansion and $o(\delta)$ optimizer displacement for $o(\delta^2)$-optimal decisions in smooth Wasserstein regret optimization. Their proof uses the same symmetric-center mechanism. In our notation $G=-HD$, the point-reference support seminorm is $\gamma(z)=\sup_{h\in\mathcal B}z^\top Gh$. Its quadratic envelope becomes

$$
\begin{aligned}
\sup_z\{z^\top Hv-\tfrac12z^\top Hz+\gamma(z)\}
 &=\sup_{h\in\mathcal B}\tfrac12\|v+H^{-1}Gh\|_H^2\\
 &=\sup_{h\in\mathcal B}\tfrac12\|v-Dh\|_H^2.
\end{aligned}\tag{55}
$$

Their finite-order Wasserstein setting differs from a hard model ellipsoid, and infinite-horizon LQR needs global stable localization, but these differences do not make the cancellation mechanism or solver-tolerance scale new. Our additional claim is the explicit second-order **optimizer** coefficient (25e), its spectral condition and the critical sampling laws (25m)--(25n). The standard implicit-function and KKT tools themselves are not new.

**Even a nonzero quadratic correction has earlier special cases.** Eldar--Merhav [EM03, Theorem 1 and equation (20)] obtain such a correction for minimax-regret linear estimation with simultaneously diagonalizable covariance matrices and separate eigenvalue intervals. We therefore do not claim the qualitative phenomenon for the first time. Theorem 6A addresses general smooth LQR ellipsoids and gives the tensor coefficient and sampling transition, rather than that structured estimation formula. The precise comparison uses the inspected 2003 author paper; metadata of its 2004 journal extension was checked, but its inaccessible full text is not used to support a theorem claim.

**Comparator-dependent dimension losses are also prior concepts.** Nietert--Kuhn [NK26, Theorems 2.2 and 3.4] study Wasserstein-robust multivariate regression, including a local condition-number regret value and dimension-dependent suboptimality of worst-loss DRO. Our loss is true-model LQR cost under a specified identification experiment, not adversarial distribution-shift regret. Proposition 9A adds exact attainable LQR statistical constants and fixed-energy saturation of (33); changing the comparator's name is not counted as novelty. General regular robust-optimizer shifts and statistical calibration are already analyzed in [BDOW21, GKL21]. The generic shift mechanism of Theorem 8 is attributed accordingly.

**Related companion manuscript.** The gap-free displacement argument in Theorem 6D, the overlapping scalar second-order examples, and the critical-radius boundary are shared results with *The Exact Statistical Price of a Robust-Regret Certificate in LQR*. The full displacement proof is given in Theorem 6D. The general tensor coefficient in Theorem 6A and the fixed-total-energy saturation in Proposition 9A are additional results of this manuscript.

Within the cited literature and versions examined, no equivalent result for the combined general second-order LQR coefficient and critical-radius sampling law was found. This is not global priority certification. The [FLMP25] finite-sample upper bound remains valid and compatible with the more precise local characterization.

The accompanying code checks exact Riccati derivatives and algebraic constants, finite geometric inequalities, the nonregular scalar optimum and Gaussian integrals, and the second-order coefficient against optimization over the full Fisher ellipse. These checks supplement the proofs; numerical optimization is not a global certificate, and no Lean verification is claimed.

### Limits that remain open

No uniform theorem is proved when dimensions grow with $N$. Proposition 9A controls total input energy, but not a dimension-uniform information lower bound or sample-size onset. Theorem 6D proves the quadratic MR displacement rate without a spectral gap, but the explicit second-order coefficient and critical shifted law still exclude repeated leading eigenvalues; when the coefficient vanishes, later transitions are not characterized. General computational complexity of exact MR or WC synthesis and optimal low-data burn-in remain open. The convex characterization at $A=0$ is not a general matrix closed form. We make no higher-order sampling-efficiency claim when $D=0$, no uniform extreme-tail claim for changing confidence quantiles, and no unconditional finite-mean assertion for an unguarded controller.

## References

**[FLMP25]** T. Fujinami, B. D. Lee, N. Matni and G. J. Pappas. *Domain Randomization is Sample Efficient for Linear Quadratic Control*. Proceedings of L4DC, PMLR 283:907--919, 2025. [Official conference page](https://proceedings.mlr.press/v283/fujinami25a.html); [extended version](https://arxiv.org/abs/2502.12310).

**[MTR19]** H. Mania, S. Tu and B. Recht. *Certainty Equivalence is Efficient for Linear Quadratic Control*. Advances in Neural Information Processing Systems, 2019. [Author manuscript](https://arxiv.org/abs/1902.07826).

**[DMT+20]** S. Dean, H. Mania, N. Matni, B. Recht and S. Tu. *On the Sample Complexity of the Linear Quadratic Regulator*. Foundations of Computational Mathematics 20:633--679, 2020. [DOI](https://doi.org/10.1007/s10208-019-09426-y).

**[DTP23]** F. Dörfler, P. Tesi and C. De Persis. *On the Certainty-Equivalence Approach to Direct Data-Driven LQR Design*. IEEE Transactions on Automatic Control 68(12):7989--7996, 2023. [DOI](https://doi.org/10.1109/TAC.2023.3253787).

**[BDOW21]** D. Bartl, S. Drapeau, J. Obłój and J. Wiesel. *Sensitivity analysis of Wasserstein distributionally robust optimization problems*. Proceedings of the Royal Society A 477:20210176, 2021. [DOI](https://doi.org/10.1098/rspa.2021.0176).

**[GKL21]** J.-Y. Gotoh, M. J. Kim and A. E. B. Lim. *Calibration of Distributionally Robust Empirical Optimization Models*. Operations Research 69(5):1630--1650, 2021. [DOI](https://doi.org/10.1287/opre.2020.2041).

**[FB26]** L.-B. Fiechtner and J. Blanchet. *Wasserstein Distributionally Robust Regret Optimization*. arXiv:2504.10796v5, revised 9 August 2026. [Inspected version](https://arxiv.org/abs/2504.10796v5). Preprint; first submitted in 2025.

**[NK26]** S. Nietert and D. Kuhn. *Regret-Optimal Wasserstein-Robust Linear Regression*. arXiv:2610.42109v1, 30 October 2026. [Inspected version](https://arxiv.org/abs/2610.42109v1). Used as an inspected preprint, not as a DOI-bearing published benchmark.

**[EM03]** Y. C. Eldar and N. Merhav. *Robust Linear Estimation with Covariance Uncertainties*. IEEE Workshop on Statistical Signal Processing, 2003, pp. 478--481. [DOI](https://doi.org/10.1109/SSP.2003.1289451); [inspected author paper](https://webee.technion.ac.il/Sites/People/YoninaEldar/Download/EM03c.pdf).
