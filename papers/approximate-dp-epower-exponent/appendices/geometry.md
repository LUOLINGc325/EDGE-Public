# Geometry and exact computation of the candidate rate

Written mathematical derivation; independent validation is not claimed.

Let P and Q be strictly positive probability vectors on a fixed finite alphabet. Write

\[
 F_\beta(R)=D(R\Vert P)+\beta\,t(R),\qquad
 t(R)=\tfrac12\sum_i|R_i-Q_i|,
 \quad L=\max_i\log(Q_i/P_i)-\min_i\log(Q_i/P_i).
\]

The pure-DP penalized problem and its clipped solution are prior work of Jacobsen et al. (2026). The statements below identify how that family solves the additional radius constraint; they do not claim a new invention of likelihood clipping or convex duality.

## 1. The penalized minimizer

For every beta >= 0, F_beta has exactly one minimizer R_beta on the probability simplex. Existence follows from compactness and continuity (0 log 0 = 0); uniqueness follows from strict convexity of relative entropy and convexity of TV. For beta = 0, R_beta = P.

For beta > 0 choose a > 0 with

\[
 R_{\beta,i}=P_i\min\{a e^\beta,\max\{a,Q_i/P_i\}\},\qquad \sum_iR_{\beta,i}=1. \tag{G1}
\]

The sum is a continuous nondecreasing function of a, tends to zero as a decreases to zero and tends to infinity as a increases to infinity, so a exists. The displayed vector is strictly positive. For each coordinate there is s_i in the subgradient of |R_i-Q_i| at R_beta,i such that

\[
 \log(R_{\beta,i}/P_i)+\frac\beta2s_i=\log a+\frac\beta2.
\]

On a lower clipped coordinate R_beta,i > Q_i take s_i = 1; on an upper clipped coordinate R_beta,i < Q_i take s_i = -1. On an unclipped coordinate choose the unique s_i in [-1,1] given by this equality. Convexity of the absolute value and the entropy identity give, for every R,

\[
 F_\beta(R)-F_\beta(R_\beta)\ \ge\ D(R\Vert R_\beta)\ \ge\ 0. \tag{G2}
\]

Indeed, expand D(R||P)-D(R_beta||P) as D(R||R_beta)+sum_i(R_i-R_beta,i)log(R_beta,i/P_i), add the subgradient inequality, and use sum_i(R_i-R_beta,i)=0. The last inequality is the elementary log-sum inequality. This proves (G1), including vectors R with zero coordinates.

For beta >= L, the minimizer is Q. For every R,

\[
 F_\beta(R)-D(Q\Vert P)
 =D(R\Vert Q)+\sum_i(R_i-Q_i)\log(Q_i/P_i)+\beta t(R)
 \ge D(R\Vert Q)+(\beta-L)t(R)\ge0. \tag{G3}
\]

The middle inequality uses that positive and negative parts of R-Q each have total mass t(R). Equality in relative entropy forces R=Q. For 0 <= beta < L, moving an infinitesimal amount of mass in Q from a coordinate with maximal log(Q_i/P_i) to one with minimal log(Q_i/P_i) has derivative beta-L < 0; Q is not a minimizer, so t(R_beta)>0.

## 2. Continuity and strict decrease of the radius

Put t_beta = t(R_beta). If beta_k -> beta, every convergent subsequence of the compact sequence R_beta_k minimizes F_beta by continuity. Uniqueness forces its limit to R_beta, proving continuity of R_beta and t_beta.

For beta_1 < beta_2, apply optimality twice and add to obtain

\[
 (\beta_2-\beta_1)(t_{\beta_2}-t_{\beta_1})\le0.
\]

If t_beta_1=t_beta_2, equality in one of the optimality comparisons and strict convexity force R_beta_1=R_beta_2. If this vector differs from Q, there are coordinates i,j with R_i>Q_i and R_j<Q_j. The subgradient optimality identities then imply

\[
 \log(R_j/P_j)-\log(R_i/P_i)=\beta_1=\beta_2,
\]

a contradiction. Thus t_beta is strictly decreasing on [0,L] when P != Q and is zero on [L,infinity).

## 3. Radius constraint, saturation and derivatives

Fix epsilon > 0 and define

\[
 V(u)=\min_{t(R)\le u}F_\varepsilon(R),\qquad u\ge0.
\]

If epsilon >= L then V(u)=D(Q||P) for every u. Suppose epsilon < L and put u_* = t_epsilon > 0. For u >= u_* the unconstrained minimizer R_epsilon is feasible, so V(u)=F_epsilon(R_epsilon). For 0<u<u_* there is exactly one beta(u) in (epsilon,L) satisfying t_beta(u)=u. For every feasible R,

\[
 F_\varepsilon(R)=F_{\beta(u)}(R)-(\beta(u)-\varepsilon)t(R)
 \ge F_{\beta(u)}(R_{\beta(u)})-(\beta(u)-\varepsilon)u
 =F_\varepsilon(R_{\beta(u)}). \tag{G4}
\]

The minimizer is unique. At u=0 the only feasible vector is Q. Consequently, the proposed operational rate has the following explicit solution if the probabilistic theorem is established:

\[
 J_\varepsilon(\rho)=
 \begin{cases}
 D(Q\Vert P),&\rho=0,\\
 D(R_{\beta(\rho/\varepsilon)}\Vert P)+\rho,
       &0<\rho<\rho_*,\\
 D(R_\varepsilon\Vert P)+\varepsilon t_\varepsilon,
       &\rho\ge\rho_*,
 \end{cases}
 \qquad \rho_* =\varepsilon t_\varepsilon. \tag{G5}
\]

The special case epsilon >= L has rho_*=0 and the same constant value throughout. For 0<rho<rho_*, beta is continuous and strictly decreasing as a function of rho. Comparing the optimal value at two radii with the two supporting multipliers epsilon-beta gives

\[
 J_\varepsilon'(\rho)=1-\frac{\beta(\rho/\varepsilon)}\varepsilon. \tag{G6}
\]

Thus J is continuous and convex, strictly decreasing and strictly convex on its nonconstant part. Its right derivative at zero is min{0,1-L/epsilon}; when epsilon<L, its left derivative at the positive saturation threshold is zero. These derivative statements follow from the supporting-line inequalities and continuity of beta, rather than differentiating across unknown active-set boundaries. At P=Q every value and t_epsilon is zero.

The exact dual formula is

\[
 V(u)=\sup_{\lambda\ge0}\left\{\min_R F_{\varepsilon+\lambda}(R)-\lambda u\right\}. \tag{G7}
\]

Weak duality is immediate; (G4) gives equality and attainment in the active range, lambda=0 gives equality in the saturated range, and any lambda with epsilon+lambda>=L gives equality at u=0. This supplies nested scalar bisection without a general nonlinear optimizer.

## 4. Binary benchmark (not claimed as new binary mechanism theory)

Let Q=Bernoulli(q), P=Bernoulli(p), q>p, and epsilon<log(q(1-p)/(p(1-q))). Define

\[
 r_\varepsilon=\frac{p e^\varepsilon}{1-p+p e^\varepsilon},\qquad
 \rho_* =\varepsilon(q-r_\varepsilon).
\]

Then the constrained optimizer is r=q-rho/epsilon before saturation and r=r_epsilon after saturation. The rate is

\[
 J_\varepsilon(\rho)=
 \begin{cases}
 d(q-\rho/\varepsilon\Vert p)+\rho,&0\le\rho\le\rho_*,\\
 \varepsilon q-\log(1-p+p e^\varepsilon),&\rho\ge\rho_*.
 \end{cases}
\]

The opposite ordering is obtained by exchanging the Bernoulli labels. Awan--Slavkovic's finite-n UMP/Tulap result is a stronger binary mechanism precedent; this calculation is a reproducible check and an explanation of the general rate formula, not an independent priority claim.
