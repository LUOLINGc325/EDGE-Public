# A Sharp Tail Criterion and Starting-Point Cutoff for Radial Stereographic Bouncy Particle Sampling

## Abstract

We study the stereographic bouncy particle sampler on a sphere with a radial target and constant-rate uniform velocity refreshment. On the invariant full-measure phase space with nonzero polar angular momentum, we prove that a density which is nonincreasing near the north pole gives a uniformly ergodic process if and only if its one-dimensional meridional integral is finite. This yields the sharp Student threshold $\nu>d-1$ and distinguishes logarithmic corrections at its boundary. For the matched-scale Student family $q_a(\theta)=(1-\cos\theta)^{-a/2}$, every $0<\nu=d-a$ gives geometric convergence on this phase space. In the nonuniform regime $1 \lt a \lt d$, we additionally prove starting-point cutoff for the actual joint position-velocity law: from a position at polar distance $r\downarrow0$ with a fresh uniform tangent velocity, the cutoff time is $\log(1/r)/(\lambda\mu_{a,d})$, where $\mu_{a,d}$ is an explicit positive difference of digamma functions. The proof derives the actual exponential-refresh kernel, rather than postulating instantaneous equilibration of fast orbits, and controls both unobserved excursions and the phase distribution at exit. Parameters are fixed throughout. We do not construct entrance laws at the poles, settle the nonradial conjecture, identify a cutoff window, or claim a cutoff at $a=1$.

# 1. Problem, prior work, and main results

Stereographic projection turns large Euclidean radii into small distances from a pole of a compact sphere. Compactness alone does not settle mixing: the transformed density can be singular at the missing pole, and a piecewise deterministic trajectory can execute many small radial excursions there. Yang, Łatuszyński, and Roberts introduced stereographic MCMC and established an SBPS uniform-ergodicity sufficient condition corresponding, for a matched-scale Student target, to $\nu>d-1/2$ [1, Theorem 2.2]. Their Remark 2.2 conjectures the larger range $\nu>d-1$. We address the radial restriction of that problem and then quantify convergence from extreme initial points in the regime where uniform convergence fails.

The distinction between algorithms matters. Adaptive stereographic MCMC still uses the earlier SBPS sufficient condition [2, Assumption 3.4]. Sub-Cauchy projection and the recent rapid-mixing results concern discrete projection Metropolis samplers [3,4]. Their dimension-dependent bounds do not establish the continuous-time SBPS result below. Tempered Euclidean BPS has exponential $L^2$ convergence guarantees for broad nonradial heavy-tailed targets [8]; its position-dependent Gaussian velocity law and linear flights differ from the spherical unit-speed dynamics studied here, and its initial-density bounds do not give the point-position cutoff below. We do not claim the first exponential or quantitative convergence guarantee for heavy-tailed PDMP sampling. The general connection between starting-point cutoff and hitting-time concentration is existing theory [5]. Our contribution is the sharp radial criterion, an explicit actual-refresh limit, and verification of the continuous-time hitting, entrance, and mixing conditions for this singular nonreversible process. The geometric-ergodicity implication of a Foster drift is also existing theory [6,7], whose hypotheses are checked here.

Let $d\ge2$, $\lambda>0$, and $\mathbb S^d\subset\mathbb R^{d+1}$. Write $N=e_{d+1}$ and $\theta(z)=\arccos z_{d+1}$. The radial surface density $q$ is positive on $(0,\pi]$, is $C^1$ away from $N$, extends smoothly and positively at the south pole, and satisfies

$$
0 \lt Z_q:=|\mathbb S^{d-1}|\int_0^\pi q(\theta)\sin^{d-1}\theta\,d\theta<\infty.
\tag{1.1}
$$

Normalization of $q$ will not matter. Denote uniform probability on the unit tangent sphere at $z$ by $\sigma_z$. The target phase probability is

$$
\Pi_q(dz,dv)=Z_q^{-1}q(\theta(z))\,d\mathrm{vol}(z)\,\sigma_z(dv).
\tag{1.2}
$$

The process follows unit-speed spherical geodesics, reflects the radial velocity component at the usual positive-part potential-gradient rate, and independently redraws its velocity from $\sigma_z$ at rate $\lambda$. Its precise domain is

$$
E_*:=\{(z,v): |z|=|v|=1,\ z\cdot v=0,\ b^2:=1-z_{d+1}^2-v_{d+1}^2>0\}.
\tag{1.3}
$$

Total variation means $\|\mu-\nu\|_{\mathrm{TV}}=\sup_A|\mu(A)-\nu(A)|\in[0,1]$. We call a process uniformly ergodic when $\sup_{y\in E_*}\|P_t(y,\cdot)-\Pi_q\|_{\mathrm{TV}}\le C e^{-\gamma t}$ for finite positive $C,\gamma$.

**Theorem 1.1 (sharp meridional criterion).** Suppose additionally that $q$ is nonincreasing on $(0,\delta]$ for some $\delta<\pi/2$. The SBPS is well defined on $E_*$, preserves $\Pi_q$, and is uniformly ergodic if and only if

$$
J_\delta:=\int_0^\delta q(r)\,dr<\infty.
\tag{1.4}
$$

If this integral is infinite, then for every finite $T\ge0$,

$$
\sup_{y\in E_*}\|P_T(y,\cdot)-\Pi_q\|_{\mathrm{TV}}=1.
\tag{1.5}
$$

Thus the obstruction is a fixed-time trapping statement, stronger than divergence of an expected escape time. The criterion uses a meridional integral, not the surface integrability in (1.1).

**Theorem 1.2 (Student classification).** Let $\pi_\nu(x)\propto(1+|x|^2/\nu)^{-(d+\nu)/2}$ on $\mathbb R^d$, with $\nu>0$, and use stereographic scale $R=\sqrt\nu$. Put $a=d-\nu \lt d$. The spherical density is proportional to

$$
q_a(\theta)=(1-\cos\theta)^{-a/2}.
\tag{1.6}
$$

On $E_*$ the corresponding SBPS is uniformly ergodic exactly when $\nu>d-1$. It is geometrically ergodic for every $\nu>0$: there are finite positive $C,\gamma$ and a finite function $H\ge1$ on $E_*$ such that

$$
\|P_t(y,\cdot)-\Pi_a\|_{\mathrm{TV}}\le C H(y)e^{-\gamma t}.
\tag{1.7}
$$

For $1\le a \lt d$ one can choose a sufficiently small $\kappa\in(0,\min(1,d-1))$ so that, at every position with $0<\theta<\pi$,

$$
\int H(z,v)\,\sigma_z(dv)\le C(\sin\theta)^{-\kappa}.
\tag{1.8}
$$

**Theorem 1.3 (physical-time starting-point cutoff).** Fix $1 \lt a \lt d$ and $\lambda>0$. Choose any $z_r$ with $\theta(z_r)=r$, initialize $v$ independently from $\sigma_{z_r}$, and let $D_r(t)=\|\delta_{z_r}\sigma_{z_r}P_t-\Pi_a\|_{\mathrm{TV}}$. Define

$$
\begin{split}
\mu_{a,d}&=\frac12\left[\psi(a/2)-\psi((a-1)/2)
                   +\psi((d-1)/2)-\psi(d/2)\right]>0,\\
t_r&=\frac{\log(1/r)}{\lambda\mu_{a,d}}.
\end{split}
\tag{1.9}
$$

Here $\psi=(\log\Gamma)'$. Then

$$
\lim_{r\downarrow0}D_r(c t_r)=
\begin{cases}
1,&0 \lt c<1,\\
0,&c>1.
\end{cases}
\tag{1.10}
$$

The same cutoff holds for the position marginal. Longitude does not affect the conclusion. This is an initial-position limit for fixed $d,a,\lambda$, with fresh initial velocity; it is not a worst-velocity statement or a joint high-dimensional limit.

# 2. Construction, geometry, and safe-region mixing

## 2.1 Regular domain and invariant probability

Let $s=\dot\theta=-v_{d+1}/\sin\theta$. On a geodesic,

$$
\dot z=v,\qquad \dot v=-z,\qquad
\dot\theta=s,\qquad \dot s=(1-s^2)\cot\theta.
\tag{2.1}
$$

For $U=-\log q$, the bounce intensity is $(U'(\theta)s)_+$, and a radial bounce sends $s$ to $-s$. At a zero of $U'$ choose any value of the reflection map, since the bounce rate is zero. Both the flow and reflection conserve

$$
b=\sin\theta\sqrt{1-s^2}=\sqrt{1-z_{d+1}^2-v_{d+1}^2}.
\tag{2.2}
$$

Between refreshments, $b>0$ confines $\theta$ to $[\arcsin b,\pi-\arcsin b]$. Rates are bounded on that orbit, so there are almost surely finitely many bounces on each finite interval. There are finitely many refreshes on such an interval; at a refresh, $b_{\mathrm{new}}=\sin\theta\,W>0$ almost surely, where $W=\sqrt{1-S^2}$ and $S$ is a coordinate of a uniform point on $\mathbb S^{d-1}$. This proves nonexplosion and invariance of the domain. When $b=1$ the no-refresh motion is a great circle on the equator; it is nonsingular and handled directly. Turning-point formulas below use $b<1$.

For completeness, invariance does not require a finite stationary mean bounce rate. For each $\eta>0$, the no-refresh flow and reflections preserve the compact set $\{b\ge\eta\}$. On it all rates are bounded. Liouville invariance of geodesic volume and the reflection identity cancel transport and bounce terms in the generator integral against $q(\theta)\,d\mathrm{vol}(z)\,\sigma_z(dv)$: the difference of opposite bounce rates is $U'(\theta)s$, while the derivative of $q$ along the flow is $-qU'(\theta)s$. Consequently the finite measure $\Pi_q\mathbf1_{\{b\ge\eta\}}$ is invariant for this bounded-rate no-refresh process. Exhausting $E_*$ as $\eta\downarrow0$ gives invariance of $\Pi_q$ for its no-refresh semigroup $P_t^0$. A uniform velocity refresh separately preserves (1.2). Concatenating these invariant kernels at the finitely many independent Poisson times proves invariance for $P_t$.

The finite-event PDMP construction supplies a conservative Borel right Markov process. The required regularity can also be checked by localization. On $b\ge\eta$, the geodesic flow, rates, and effective reflection kernel are continuous and bounded, so the event construction preserves continuity of bounded continuous test functions. On a compact initial set, $b\ge b_0>0$, and each refresh satisfies $b_{\mathrm{new}}\ge b_{\mathrm{old}}W$. For any $0<\xi \lt d-1$, $\mathbb E W^{-\xi}<\infty$. For a finite horizon $t$, the probability of leaving $b\ge\eta$ is therefore at most

$$
(\eta/b_0)^\xi\exp\{\lambda t(\mathbb E W^{-\xi}-1)\},
\tag{2.3}
$$

by the compound-Poisson product bound. This tends to zero uniformly on that initial compact set. Localization gives the weak Feller property $P_t C_b(E_*)\subset C_b(E_*)$. Approximating a stopping time from above by discrete stopping times, right continuity of the paths and this continuity of $P_tf$ give the strong Markov identity for bounded continuous $f$; a monotone-class argument extends it to bounded Borel functions. This verifies the right-process regularity used below on the locally compact separable domain. No $C_0$-Feller assertion is needed: refreshment can bring phases approaching the excluded boundary back to a compact regular set with nonvanishing probability.

The complement of $E_*$ has $\Pi_q$ measure zero. Nevertheless both poles, including the south pole corresponding to Euclidean $x=0$, are excluded. A uniform initial velocity at a nonpolar position is regular almost surely; randomizing velocity at a pole does not remove that exception. No pole entrance construction is used in this paper.

## 2.2 A common time-window minorization

**Lemma 2.1 (safe-region minorization).** For every $\delta>0$ and every finite window length $L$, there exist $t_0>0$, $\epsilon>0$, and a probability $\zeta$ supported in a regular phase chart such that

$$
P_t(y,A)\ge\epsilon\zeta(A),\qquad
\theta(y)\ge\delta,\quad t\in[t_0,t_0+L],\quad y\in E_*.
\tag{2.4}
$$

Every compact subset of $E_*$ is petite. The process is irreducible and aperiodic.

**Proof.** We give the smoothing and controllability details. Write $\Phi_t$ for geodesic flow. From a fixed position $z$, consider two flights with an intervening refresh:

$$
F(v_1,u,v_2)=\Phi_{T-u}(\exp_z(u v_1),v_2).
\tag{2.5}
$$

For $0 \lt u<\pi$, denote the incoming velocity at the middle vertex by $v_{\mathrm{in}}$ and assume $v_2\ne v_{\mathrm{in}}$. Pulling the derivative back by $D\Phi_{T-u}$, variations of $v_1$ give the $d-1$ position directions perpendicular to $v_{\mathrm{in}}$. Variation of $u$ gives position component $v_{\mathrm{in}}-v_2$, whose inner product with $v_{\mathrm{in}}$ is positive. Variations of $v_2$ give the remaining $d-1$ vertical directions. Frame changes only add vertical terms. Thus $F$ has rank $2d-1$, the phase dimension. The submersion theorem gives a transition density bounded below on a small endpoint chart when these directions and times range over sufficiently small coordinate boxes.

Choose a common regular endpoint $y_*$ away from $N$. From any phase with $\theta\ge\delta$, first take a short flight of length less than $\delta/4$, accommodating its prescribed initial velocity. Refresh, then follow a finite polygon of short geodesics avoiding $N$ to $y_*$. The punctured sphere is path connected; for $d\ge2$ these polygons can be chosen with a genuine final corner, as needed in (2.5). The endpoint velocity can be specified by the last refreshed direction. A final short two-flight segment gives the nondegenerate density calculation above. Back-and-forth flights in a safe ball add a continuously adjustable amount of duration without changing the desired endpoint phase. By adding sufficiently many such flights, paths can be prescribed for every total time in $[t_0,t_0+L]$ with a common sufficiently large $t_0$.

Take small tubes around these controlled paths. All lie away from $N$, so their bounce intensities are bounded. Requiring no bounces has uniformly positive probability on each tube. Prescribed refresh times have density $\lambda^n e^{-\lambda t}$ and the direction charts have positive uniform-sphere density. Hence the submersion lower bound is positive and stable under small changes of initial phase and total time. The closure of $\{\theta\ge\delta\}$ in the full unit tangent bundle is compact. A finite subcover of its product with the time window, followed by shrinking the finitely many endpoint neighborhoods to one chart around $y_*$, yields (2.4). Excluded limiting phases cause no difficulty here: the prescribed finite paths stay in the smooth region, and each post-refresh regularity exception is a direction-null set.

The same construction with endpoint charts covering arbitrary regular open sets proves irreducibility with respect to smooth phase volume: for a positive-volume set, choose a chart where it has positive volume and use the density lower bound. Every compact regular set has a positive lower bound on $\theta$, so (2.4) makes it small for suitable time kernels and thus petite. Minorization on an interval of times, including safe return paths to an endpoint chart, excludes a time-periodic decomposition and supplies aperiodicity. These are the hypotheses required by the continuous-time Foster theorem used in Section 6. $\square$

# 3. Exact cap renewal and the uniform criterion

Fix a monotone cap $0<\delta<\pi/2$. For $b<\sin\delta$ put $\beta=\arcsin b$ and define

$$
h_\beta(r)=\arccos\frac{\cos r}{\cos\beta},\qquad
k_\beta(r)=h'_\beta(r)=\frac{\sin r}{\sqrt{\sin^2r-\sin^2\beta}}.
\tag{3.1}
$$

The outbound path from the north turning point is $\theta_\beta(t)=\arccos(\cos\beta\cos t)$. For $\beta\le r\le\delta$, one has $h_\beta(r)\le r$, $k_\beta(r)\ge1$, and $\theta_\beta(t)\ge t$. The last inequality follows because $0\le t\le\delta<\pi/2$ and $\cos\beta\cos t\le\cos t$.

Since $q$ decreases, bounces occur only on outward travel. If $R$ is the first outbound maximum, its survival before the cap edge is

$$
\mathbb P_\beta(R\ge r)=q(r)/q(\beta).
\tag{3.2}
$$

A failed outward excursion returns to $\beta$ without a bounce and starts a new independent radial cycle. Angular coordinates need not renew: the radial future depends only on $b$ and the independent bounce clock.

**Lemma 3.1 (exact exit formulas).** Let $\tau_\delta^0$ be the cap exit time for the no-refresh process started at its north turning point. With $H_\beta=h_\beta(\delta)$,

$$
\mathbb E_\beta\tau_\delta^0
=\frac{2}{q(\delta)}\int_\beta^\delta q(r)k_\beta(r)\,dr-H_\beta,
\tag{3.3}
$$

and, for $u>0$,

$$
\mathbb E_\beta e^{-u\tau_\delta^0}
=\frac{q(\delta)e^{-uH_\beta}}
 {q(\delta)e^{-2uH_\beta}
   +2u\int_\beta^\delta e^{-2u h_\beta(r)}q(r)k_\beta(r)\,dr}.
\tag{3.4}
$$

**Proof.** Success on a cycle has probability $p=q(\delta)/q(\beta)$ and takes $H_\beta$. Failure at height $R<\delta$ takes $2h_\beta(R)$ and renews. Thus the transform equals

$$
\frac{p e^{-uH_\beta}}
 {1-\mathbb E[e^{-2u h_\beta(R)};R<\delta]}.
$$

Integration by parts using (3.2) gives (3.4). The corresponding renewal equation for the mean, or differentiation at $u=0$, gives (3.3). For fixed $\beta>0$ all cycle times are bounded and $p>0$, so these operations are legitimate. Flat portions of $q$ simply contribute zero bounce density. $\square$

## 3.1 Sufficiency

The time parametrization gives the useful sharp bound

$$
\int_\beta^\delta q(r)k_\beta(r)\,dr
=\int_0^{H_\beta}q(\theta_\beta(t))\,dt
\le\int_0^\delta q(t)\,dt=J_\delta.
\tag{3.5}
$$

An arbitrary regular phase inside the cap either exits during its first outbound segment or reaches its north turning point after at most $2\delta$. Consequently, when $J_\delta<\infty$,

$$
\sup_{\theta<\delta}\mathbb E_y\tau_\delta^0
\le M_\delta:=2\delta+2J_\delta/q(\delta)<\infty.
\tag{3.6}
$$

With probability at least $\frac12e^{-2\lambda M_\delta}$, the no-refresh path exits within $2M_\delta$ and no refresh occurs before that deterministic time. The same lower bound therefore applies to exiting the cap by that time for the full process. For a phase already outside the cap take the hitting time to be zero. Use Lemma 2.1 with window length $2M_\delta$, then apply the strong Markov property at this first hit. At the common time $T=2M_\delta+t_0$,

$$
P_T(y,\cdot)\ge\tfrac12e^{-2\lambda M_\delta}\epsilon\zeta(\cdot)
\quad\text{for every }y\in E_*.
\tag{3.7}
$$

Iteration of this Doeblin bound contracts total variation geometrically at multiples of $T$; invariance and contraction handle the intervening times. This proves sufficiency in Theorem 1.1.

## 3.2 Necessity, including finite refreshment

Suppose $J_\delta=\infty$. Then $q(\varepsilon)\to\infty$. From (3.4), $H_\beta\le\delta$, and $k_\beta\ge1$,

$$
\mathbb E_\beta e^{-u\tau_\delta^0}
\le\frac{q(\delta)e^{2u\delta}}{2u\int_\beta^\delta q(r)\,dr}.
\tag{3.8}
$$

For an arbitrary phase with $\theta\le\varepsilon$, an initially outward segment escapes before its first bounce with probability at most $q(\delta)/q(\varepsilon)$. Otherwise it reaches a turning point $\beta\le\varepsilon$; dropping elapsed time only increases its remaining Laplace transform. Thus for every fixed $T,u>0$,

$$
\sup_{\theta(y)\le\varepsilon}
\mathbb P_y(\tau_\delta^0\le T)
\le e^{uT}\left[\frac{q(\delta)}{q(\varepsilon)}
+\frac{q(\delta)e^{2u\delta}}{2u\int_\varepsilon^\delta q(r)\,dr}\right]
\longrightarrow0.
\tag{3.9}
$$

This bound is uniform in every regular velocity, even when $b/\theta$ is arbitrarily small.

To include refreshment, truncate the Poisson number of refreshes by a fixed $n$, with arbitrarily small discarded probability. There are at most $n+1$ no-refresh segments before $T$. For a desired error $\eta$, choose nested radii $0 \lt r_0 \lt r_1<\cdots \lt r_{n+1}=\delta$ backwards so that the no-refresh probability of reaching $r_{j+1}$ within $T$ from any phase with $\theta\le r_j$ is below $\eta/(n+1)$; this is possible by (3.9). A conditional union bound over segments then gives

$$
\lim_{r\downarrow0}\sup_{\theta(y)\le r}
\mathbb P_y(\tau_\delta\le T)=0
\tag{3.10}
$$

for the full process. Hence at time $T$, an initial state sufficiently near $N$ remains in the $\delta$ cap with probability arbitrarily close to one. Its stationary cap mass tends to zero as $\delta\downarrow0$ by (1.1). Taking the two limits proves (1.5), and completes Theorem 1.1.

## 3.3 Boundary examples and the Student threshold

If, near zero, $q(\theta)=\theta^{-1}(\log(1/\theta))^{-p}$, with any smooth positive radial extension away from the cap, it satisfies (1.1) for every real $p$ when $d\ge2$. It is eventually decreasing and (1.4) holds exactly when $p>1$. Thus a power exponent alone cannot classify the critical boundary.

For stereographic scale $R$, $|x|=R\cot(\theta/2)$. The change-of-variables factor from sphere area to Euclidean volume is proportional to $(1-\cos\theta)^{-d}$. With $R^2=\nu$, the Student density contributes $(1-\cos\theta)^{(d+\nu)/2}$, giving (1.6). For $a>0$, $q_a(\theta)\asymp\theta^{-a}$ and Theorem 1.1 gives uniform ergodicity exactly for $a<1$. If $a\le0$, no bounce occurs on an outbound segment inside a sufficiently small cap. An inbound segment either reflects and leaves or first reaches its turning point and then leaves, all within $2\delta$. The same safe-region argument proves uniform ergodicity. This establishes the uniform part of Theorem 1.2 for every $\nu>0$.

# 4. The actual exponential-refresh kernel

Fix $1 \lt a \lt d$ for now. The whole no-refresh radial orbit has $\theta\in[\beta,\pi-\beta]$. Starting at the north turn, let $R_\beta$ be its outbound maximum. Then

$$
\mathbb P(R_\beta\ge x)=q_a(x)/q_a(\beta),\qquad
\beta\le x\le\pi-\beta.
\tag{4.1}
$$

There is an atom at $\pi-\beta$, corresponding to reaching the natural south turn without a bounce. A complete cycle returns to the north turn and has duration $C_\beta=2h_\beta(R_\beta)\le2\pi$. Radial cycles are independent. For every nonnegative measurable $f$, Tonelli gives the exact occupation identity

$$
\mathbb E\int_0^{C_\beta}f(\theta_t)\,dt
=\frac{2}{q_a(\beta)}\int_\beta^{\pi-\beta}q_a(x)f(x)k_\beta(x)\,dx.
\tag{4.2}
$$

In particular this includes the south-turn atom, rather than discarding a rare long excursion.

## 4.1 Complete-cycle asymptotics and discount control

Define, for $t>1$,

$$
J_t=\int_1^\infty\frac{y^{1-t}}{\sqrt{y^2-1}}\,dy
=\frac{\sqrt\pi\,\Gamma((t-1)/2)}{2\Gamma(t/2)}.
\tag{4.3}
$$

For every $p \lt a-1$,

$$
A_{\beta,p}:=\mathbb E\int_0^{C_\beta}(\theta_t/\beta)^pdt
\sim2\beta J_{a-p},\qquad
\mathbb E C_\beta\sim2\beta J_a.
\tag{4.4}
$$

Here is the domination needed in (4.4). In $x\le\delta<\pi/4$ put $x=\beta y$. The density ratio is bounded by $C y^{-a}$, and $k_\beta(\beta y)\le C y/\sqrt{y^2-1}$. The limiting integrand $y^{p+1-a}/\sqrt{y^2-1}$ is integrable precisely for $p \lt a-1$. On $x\ge\delta$, $q_a(x)x^p$ is bounded and $\int k_\beta\le\pi$, so the contribution is $O(\beta^{a-p})=o(\beta)$. This controls the south-end square-root singularity without falsely bounding $k_\beta$ there pointwise.

Since $1-\cos x$ is comparable to $x^2$ on $[0,\pi]$, (4.1) implies $\mathbb P(R_\beta>x)\le C(\beta/x)^a$. Therefore, for $m>0$,

$$
\mathbb E R_\beta^m=
\begin{cases}
O(\beta^m),&m \lt a,\\
O(\beta^a\log(1/\beta)),&m=a,\\
O(\beta^a),&m>a.
\end{cases}
\tag{4.5}
$$

Also $C_\beta\le4R_\beta$, so $\mathbb E C_\beta^2/\mathbb E C_\beta\to0$.

Let $T_\lambda$ be an independent exponential time of rate $\lambda$. Exact renewal with exponential memorylessness gives

$$
K_{\lambda,p}(\beta):=
\mathbb E_\beta(\theta_{T_\lambda}/\beta)^p
=\frac{\lambda\mathbb E\int_0^{C_\beta}e^{-\lambda t}(\theta_t/\beta)^pdt}
 {1-\mathbb E e^{-\lambda C_\beta}}.
\tag{4.6}
$$

The denominator is asymptotic to $\lambda\mathbb E C_\beta$. In the occupation integral in the numerator, removing the discount costs $o(\beta)$: for $p<0$, the scaled integrand is at most one and this integral error is bounded by $\lambda\mathbb E C_\beta^2$; for $p\ge0$ it is at most $16\lambda\beta^{-p}\mathbb E R_\beta^{p+2}$, which is $o(\beta)$ by (4.5) and $p \lt a-1$. Multiplying by the outer fixed $\lambda$ preserves this order. Hence

$$
K_{\lambda,p}(\beta)\longrightarrow J_{a-p}/J_a,
\qquad p \lt a-1.
\tag{4.7}
$$

All estimates are uniform when $\lambda$ ranges in a compact subset of $(0,\infty)$. This is a result at the actual next independent refresh time, derived from an exact resolvent.

## 4.2 The initial incomplete cycle

Initialize at $\theta=r$ immediately after a uniform velocity refresh. Then

$$
W^2\sim\mathrm{Beta}((d-1)/2,1/2),\qquad
\beta=\arcsin(\sin r\,W),\qquad
\beta/r=W(1+O(r^2)),
\tag{4.8}
$$

uniformly in $0 \lt W\le1$. The moment $\mathbb E W^p$ is finite exactly for $p>-(d-1)$.

Let $\tau_0$ be the first north-turn time for the no-refresh path from this initial phase. For an inward velocity, $\tau_0\le r$. For an outward velocity with first maximum $R_0$, $\tau_0\le4R_0$ and $\mathbb P(R_0>x)\le C(r/x)^a$. Thus $\mathbb E[\tau_0\mid S]\le Cr$ uniformly in the initial radial speed $S$. Splitting at $\tau_0$ yields

$$
\begin{split}
\mathbb E[(\theta_{T_\lambda}/r)^p\mid S]
&=\mathbb E[e^{-\lambda\tau_0}\mid S](\beta/r)^pK_{\lambda,p}(\beta)
+B_{r,p}(S),\\
B_{r,p}(S)&=\lambda\mathbb E\int_0^{\tau_0}e^{-\lambda t}(\theta_t/r)^pdt.
\end{split}
\tag{4.9}
$$

For $0\le p \lt a-1$, the initial tail bound gives $B_{r,p}(S)\le4\lambda r^{-p}\mathbb E R_0^{p+1}\le Cr$. For $p<0$, $\theta_t\ge\beta$ before $\tau_0$, so $B_{r,p}(S)\le CrW^p$. These estimates also hold for an initially inward phase. Thus the early term vanishes after averaging whenever $p>-(d-1)$; it is not discarded merely because its probability is small.

**Lemma 4.1 (actual-refresh Mellin limit).** With fresh initial velocity at $\theta=r$,

$$
\mathbb E_r(\theta_{T_\lambda}/r)^p\longrightarrow M_{a,d}(p),
\qquad -(d-1) \lt p \lt a-1,
\tag{4.10}
$$

where

$$
\begin{split}
M_{a,d}(p)=
&\frac{\Gamma((d-1+p)/2)\Gamma(d/2)}
       {\Gamma((d-1)/2)\Gamma((d+p)/2)}\\
&\quad\times
\frac{\Gamma((a-p-1)/2)\Gamma(a/2)}
       {\Gamma((a-p)/2)\Gamma((a-1)/2)}.
\end{split}
\tag{4.11}
$$

The moments in (4.10) are locally uniformly bounded in $r$ and uniformly in refresh rates in compact positive intervals. The ratio in law tends to $WY$, with independent factors $W^2\sim\mathrm{Beta}((d-1)/2,1/2)$ and $Y^{-2}\sim\mathrm{Beta}((a-1)/2,1/2)$.

**Proof.** Substitute (4.7) and (4.8) into (4.9). For negative $p$, $K_{\lambda,p}\le1$ and $W^p$ is integrable; for positive $p$, the turn limit is uniformly bounded for all sufficiently small $\beta\le r$. Dominated convergence applies in both cases. The limit is $\mathbb E W^p J_{a-p}/J_a$, which is (4.11). For the distributional assertion, use the same split with bounded continuous test functions; the turn law converges uniformly as $\beta\le r\to0$, giving the independent product representation. $\square$

# 5. Logarithmic drift and the critical endpoint

Moment bounds at one positive and one negative exponent give a uniform exponential moment of $|\log(\theta_{T_\lambda}/r)|$ for all sufficiently small $r$. Consequently the first two log moments converge to those of $\log W+\log Y$. Differentiating the beta identities gives the mean $\mu_{a,d}$ in (1.9) and variance

$$
\sigma_{a,d}^2=\frac14\left[
\psi_1((a-1)/2)-\psi_1(a/2)
+\psi_1((d-1)/2)-\psi_1(d/2)\right],
\tag{5.1}
$$

where $\psi_1=\psi'$. The function $x\mapsto\psi(x+1/2)-\psi(x)$ is strictly decreasing: use its integral representation with positive integrand, or the strictly decreasing trigamma function. Since $(a-1)/2<(d-1)/2$, (1.9) is strictly positive. Thus $M(0)=1$, $M'(0)=\mu_{a,d}>0$, and

$$
M_{a,d}(-\kappa)<1
\quad\text{for all sufficiently small }\kappa>0.
\tag{5.2}
$$

One also checks $M_{a,d}(a-d)=1$ directly from (4.11). Strict convexity of $\log M$ gives $M(-\kappa)<1$ for $0<\kappa \lt d-a$. We only need a small such exponent below one. Formula (5.1) describes an increment variance; it does not by itself prove a physical-time central limit theorem.

At $a=1$, the same exact cycle identities give

$$
\mathbb E C_\beta\sim2\beta\log(1/\beta),\quad
\mathbb E C_\beta^2=O(\beta),\quad
A_{\beta,p}\sim2\beta J_{1-p}\quad(p<0).
\tag{5.3}
$$

For example, the logarithm in the first expression follows by integrating the asymptotic $\beta/x$ occupation tail over $\beta\ll x\ll1$; the remaining regions contribute $O(\beta)$. The discount error in the denominator remains negligible. The numerator in (4.6) is bounded above by $\lambda A_{\beta,p}$, so $K_{\lambda,p}(\beta)\to0$ for $p<0$. Now $\mathbb E[\tau_0\mid S]\le Cr\log(1/r)$, and the negative-power early term is at most $Cr\log(1/r)W^p$. It follows that

$$
\mathbb E_r(\theta_{T_\lambda}/r)^p\longrightarrow0,
\qquad -(d-1) \lt p<0,
\tag{5.4}
$$

uniformly over compact positive refresh-rate intervals. This endpoint contracts a negative moment, but its log-increment law is not the finite-mean limit used in Theorem 1.3.

# 6. A Lyapunov function for the actual continuous-time process

We now prove the remaining geometric claim in Theorem 1.2 for $1\le a \lt d$. A north-only weight $\theta^{-\kappa}$ is insufficient for the global argument: initial positions close to the south pole also have very small angular momentum and can reach the north trap before refreshing. Use

$$
V(\theta)=(\sin\theta)^{-\kappa},\qquad
0<\kappa<\min(1,d-1,d-a)
\tag{6.1}
$$

when $a>1$, and $0<\kappa<\min(1,d-1)$ at $a=1$.

## 6.1 Both pole limits and the weighted refresh drift

Replacing $\theta/\beta$ by $\sin\theta/\sin\beta$ in the turn calculation gives

$$
(\sin\beta)^\kappa\mathbb E_\beta V(\theta_{T_\lambda})
\longrightarrow m_\kappa:=J_{a+\kappa}/J_a>0
\quad(a>1).
\tag{6.2}
$$

To justify the south contribution, the substitution $t=h_\beta(x)$ gives
$\sin^2x=\sin^2\beta+\cos^2\beta\sin^2t$. Splitting $t$ near $0,\pi$ and away from them shows

$$
\sup_{\beta<\beta_0}\int_\beta^{\pi-\beta}(\sin x)^{-\kappa}k_\beta(x)\,dx<\infty
\quad(\kappa<1).
\tag{6.3}
$$

In the north cap the previous scaled domination applies. Away from it the additional normalization makes the contribution vanish. The discounted scaled integrand is at most one, so the earlier second-cycle-moment bound controls discounting. At $a=1$ the left side of (6.2) tends to zero and is bounded above and below by positive constants times $1/\log(1/\beta)$, using (5.3) and $C_\beta\le2\pi$.

The incomplete-cycle argument at the north pole still applies. Thus $\mathbb E_r V(\theta_{T_\lambda})/V(r)\to M(-\kappa)$ for $a>1$, and tends to zero at $a=1$.

At a freshly initialized south position $\theta=\pi-\varepsilon$, $\beta=\arcsin(\sin\varepsilon W)$. The time to the first north turn lies in $[\pi-\varepsilon,\pi+\varepsilon]$: an initially inward path takes $h_\beta(\pi-\varepsilon)$; an initially outward path takes $2h_\beta(R_0)-h_\beta(\pi-\varepsilon)$ with $R_0\in[\pi-\varepsilon,\pi-\beta]$. Before that turn each radial interval is traversed at most twice, and (6.3) bounds its $V$ occupation uniformly. Dividing this early contribution by $V(\pi-\varepsilon)$ makes it vanish. Dominated convergence with $\mathbb E W^{-\kappa}<\infty$ gives

$$
\frac{\mathbb E_{\pi-\varepsilon}V(\theta_{T_\lambda})}{V(\pi-\varepsilon)}
\longrightarrow e^{-\lambda\pi}M(-\kappa)
\quad(a>1),
\tag{6.4}
$$

and zero at $a=1$. On any closed middle annulus, $V(\theta_t)\le b^{-\kappa}$ before refreshing, whose fresh-velocity mean is uniformly bounded.

For $0 \lt c<\lambda$ the exact exponential tilt is

$$
\mathbb E[e^{cT_\lambda}f(\theta_{T_\lambda})]
=\frac{\lambda}{\lambda-c}\mathbb E[f(\theta_{T_{\lambda-c}})].
\tag{6.5}
$$

All pole limits above are uniform in nearby rates. Choose $c>0$ small enough that $\lambda M(-\kappa)/(\lambda-c)<1$ when $a>1$; at $a=1$ both pole limits are zero. There are then $\rho<1$ and $B<\infty$ with

$$
Q_cV(\theta):=\mathbb E_{\text{fresh at }\theta}
 [e^{cT_\lambda}V(\theta_{T_\lambda})]
\le\rho V(\theta)+B,
\qquad0<\theta<\pi.
\tag{6.6}
$$

## 6.2 Resolvent transfer and Foster-Harris conclusion

Put $\alpha=\lambda-c$ and define a function on full phase space by

$$
H(y)=\lambda\int_0^\infty e^{-\alpha t}P_t^0V(y)\,dt.
\tag{6.7}
$$

It obeys $1\le\lambda/\alpha\le H(y)\le(\lambda/\alpha)b^{-\kappa}$, and is continuous and locally bounded: on a compact regular set, $b$ is bounded below along every no-refresh orbit, so dominated convergence applies. The localized resolvent martingale gives the no-refresh extended-generator identity

$$
L_0H=\alpha H-\lambda V.
\tag{6.8}
$$

Indeed all terms are bounded after restricting to $b\ge\eta$, which the no-refresh dynamics preserve; exhaustion yields the extended-generator identity. The fresh-velocity average of $H$ equals $Q_cV$. The full jump term is integrable by (6.6), and hence

$$
LH=L_0H+\lambda(Q_cV-H)
=-cH+\lambda(Q_cV-V)
\le-cH+\lambda B.
\tag{6.9}
$$

For small $b$, any no-refresh initial phase reaches its north turn within $2\pi$. Strong Markov at that time gives $H(y)\ge e^{-2\pi\alpha}H(\mathrm{turn}_\beta)$. By (6.2), the latter is bounded below by $C b^{-\kappa}$ if $a>1$, and by $C b^{-\kappa}/\log(1/b)$ if $a=1$. Thus $H(y)\to\infty$ as $b\to0$. Its sublevel sets are compact subsets of $E_*$. The equatorial case $b=1$ has $H=\lambda/\alpha$ and does not affect coercivity.

Let $K$ be a sufficiently high compact sublevel set. From (6.9),

$$
LH\le-(c/2)H+\lambda B\mathbf1_K.
\tag{6.10}
$$

Lemma 2.1 makes $K$ petite and provides irreducibility and aperiodicity. Section 2.1 gives nonexplosion and a Borel right process on a locally compact separable space. Thus the continuous-time Foster-Harris theorem of Down, Meyn, and Tweedie [7, Theorem 5.2], in the form stated in [6, Theorem A], applies to (6.10). It gives $H$-uniform convergence, in particular (1.7). Averaging (6.7) in the initial fresh velocity and using (6.6) gives (1.8). For $a<1$ the already proved uniform convergence is stronger, completing Theorem 1.2. Notice that this proof never treats the number of refreshes as independent of the sampled position chain.

# 7. Passage times and the deterministic physical clock

Let $T_0=0$ and $T_n=E_1+\cdots+E_n$ be the actual refresh times, with iid $E_i\sim\mathrm{Exp}(\lambda)$. Record $r_n=\theta(Z_{T_n})$ before drawing the new independent velocity used on the next segment. The radial sequence is a Markov chain with the kernel in Lemma 4.1. Its holding times and endpoints are dependent.

Put $Y_n=-\log r_n\ge-\log\pi$. Lemma 4.1 and log uniform integrability imply

$$
D(y):=\mathbb E[Y_{n+1}-Y_n\mid Y_n=y]\longrightarrow-\mu_{a,d},
\qquad
\sup_{y\ge h_0}\mathbb E[(Y_{n+1}-Y_n)^2\mid Y_n=y]<\infty.
\tag{7.1}
$$

Choose a small fixed $\delta$ so that $D(y)\le-m<0$ for $y>-\log\delta$, and let $N_\delta=\inf\{n\ge0:r_n\ge\delta\}$.

**Lemma 7.1 (observed exit concentration).** As $r_0\downarrow0$,

$$
\frac{N_\delta}{\log(1/r_0)}\longrightarrow\frac1{\mu_{a,d}},\qquad
\frac{T_{N_\delta}}{\log(1/r_0)}\longrightarrow\frac1{\lambda\mu_{a,d}}
\quad\text{in probability}.
\tag{7.2}
$$

**Proof.** Write $y_0=Y_0$. Fix $0<\epsilon<\mu_{a,d}$ and choose a large fixed $h$ so that $D(y)\in[-\mu-\epsilon,-\mu+\epsilon]$ for $y>h$. Let $\tau_h=\inf\{n:Y_n\le h\}$. The stopped martingale

$$
M_n=Y_{n\wedge\tau_h}-y_0-
\sum_{k \lt n\wedge\tau_h}D(Y_k)
\tag{7.3}
$$

has $\mathbb E M_{\lfloor A y_0\rfloor}^2\le C A y_0$ for fixed $A$. Doob's inequality gives $\max_{n\le A y_0}|M_n|/y_0\to0$ in probability. If $c<1/(\mu+\epsilon)$, an exit by $cy_0$ would imply $Y_{\tau_h}\ge y_0-(\mu+\epsilon)cy_0-o(y_0)>h$, a contradiction. If $c>1/(\mu-\epsilon)$, failing to exit by $cy_0$ would imply $Y_{\lfloor cy_0\rfloor}\le y_0-(\mu-\epsilon)\lfloor cy_0\rfloor+o(y_0) \lt h$, also a contradiction.

To reach the fixed cap edge, stop the negative-drift inequality at $n\wedge N_\delta$. The global lower bound $Y\ge-\log\pi$ gives

$$
\mathbb E_y N_\delta\le(y+\log\pi)/m
\quad(y>-\log\delta).
\tag{7.4}
$$

All finite stopped expectations are integrable by the conditional second-moment bound; monotone convergence gives (7.4). At $\tau_h$ the chain is either already outside the cap or has $Y_{\tau_h}\le h$. Its remaining expected exit time is therefore at most $(h+\log\pi)/m$, uniformly in $y_0$. Dividing this remainder by $y_0$ and sending $\epsilon\downarrow0$ proves the first assertion in (7.2). No assumption preventing returns to a deeper cap was made.

For the clock, $T_n/n\to1/\lambda$ almost surely. This remains true in probability at the dependent index $N_\delta\to\infty$: for $n_0$ fixed, the exceptional probability is at most

$$
\mathbb P(N_\delta \lt n_0)+
\mathbb P\!\left(\sup_{n\ge n_0}|T_n/n-1/\lambda|>\eta\right).
$$

First let $r_0\to0$ and then $n_0\to\infty$. Multiplication by the first limit proves the second. $\square$

## 7.1 Excursions missed by the refresh observations

An observed exit time alone cannot prove the lower total-variation bound, since the path might leave and return between refreshes. Formula (3.8) at $u=\lambda$, together with $q_a(r)\asymp r^{-a}$, gives

$$
\sup_{\theta(y)\le r}\mathbb P_y(\tau_\delta^0 \lt T_\lambda)
\le C_\delta r^{a-1}
\quad\text{for small }r.
\tag{7.5}
$$

The initial outbound escape contributes $O(r^a)$; after a return to its turn, the transform is $O(\beta^{a-1})\le O(r^{a-1})$. This is uniform over all regular initial velocities.

Fix $0 \lt c<1$, choose $c \lt c'<1$, put $y=\log(1/r_0)$, $t_y=cy/(\lambda\mu)$, and $n_y=\lceil c'y/\mu\rceil$. The refresh count up to $t_y$ is Poisson of mean $cy/\mu$, so it exceeds $n_y$ with probability tending to zero. Choose $0 \lt e<1-c'$. Apply the martingale argument (7.3) stopped on $Y_n\le ey$. The entire pre-stopping region recedes to infinity, so its drift is uniformly $-\mu+o(1)$ and the second moments stay bounded. It follows that

$$
\mathbb P(\min_{n\le n_y}Y_n\le ey)\longrightarrow0.
\tag{7.6}
$$

A conditional union bound using (7.5) gives at most $(n_y+1)C_\delta e^{-(a-1)ey}\to0$ for any interval among these whose starting position is at most $e^{-ey}$ to exit the fixed cap before its next refresh. This conditions only on each interval's starting history, never on its future endpoint. Thus the continuous path stays in the cap through $t_y$ with probability tending to one.

Since $\Pi_a(\theta<\delta)=O(\delta^{d-a})$, the cap event separates the two laws with asymptotic total variation at least $1-\Pi_a(\theta<\delta)$. Letting $\delta\downarrow0$ proves the lower limit in (1.10), for both phase and position laws.

# 8. Entrance-law control and the upper cutoff

The set $\{\theta\ge\delta\}\cap E_*$ is not compact in $E_*$ and has unbounded $H$. We therefore control the distribution at the first observed exit, rather than declaring every outside-cap phase uniformly mixing.

**Lemma 8.1 (south-cap exponential observation).** For the no-refresh Student process and every fixed $\lambda>0$,

$$
\sup_{y\in E_*}\mathbb P_y(\theta_{T_\lambda}>\pi-\varepsilon)
\le C\varepsilon
\quad\text{for sufficiently small }\varepsilon>0.
\tag{8.1}
$$

**Proof.** Fix $\eta<\pi/8$ and write $S_u=\{\pi-\theta \lt u\}$. The bounce intensity is bounded by a constant $G$ on $S_\eta$. A buffered visit starts on entry into $S_{\eta/2}$ and ends on the next exit from $S_\eta$, including an initial partial visit. Consecutive visits require travel of at least $\eta/2$, so at most $1+2t/\eta$ start by time $t$. Divide each visit at its bounces inside $S_\eta$. A great-circle segment spends at most $2\varepsilon$ in $S_\varepsilon$ before exiting the buffer. Hence its total occupation up to $t$ is bounded by

$$
A_\varepsilon(t)\le2\varepsilon
 [N_{S_\eta}(t)+1+2t/\eta].
\tag{8.2}
$$

The compensator gives $\mathbb E N_{S_\eta}(t)\le Gt$. Integrating occupation against the exponential density and using Tonelli,

$$
\mathbb P_y(\theta_{T_\lambda}\in S_\varepsilon)
=\lambda^2\int_0^\infty e^{-\lambda t}\mathbb E_y A_\varepsilon(t)\,dt
\le2\varepsilon(\lambda+G+2/\eta).
\tag{8.3}
$$

High bounce rates outside the buffer do not enter this bound. $\square$

**Lemma 8.2 (uniform exit weight).** For the $N_\delta$ in Section 7 and any $0<\kappa<1$,

$$
\sup_{0 \lt r_0<\delta}\mathbb E(\sin r_{N_\delta})^{-\kappa}<\infty.
\tag{8.4}
$$

For the full phase $X_{T_{N_\delta}}$ immediately after its fresh velocity is drawn,

$$
\sup_{0 \lt r_0<\delta}\mathbb E H(X_{T_{N_\delta}})<\infty.
\tag{8.5}
$$

**Proof.** From any regular phase $y$ inside the north cap, let $\tau_\delta^0$ be the no-refresh first exit and set $L_y=\mathbb E_y e^{-\lambda\tau_\delta^0}$. At that exit its radial speed is nonnegative. Choose $0 \lt h<\delta$ with $2\delta<\pi/2$. With no bounce during the next $h$ time units, the geodesic remains in $\delta\le\theta\le\delta+h$; even zero initial radial speed moves outward on this interval. The bounce rate there is bounded by $G_\delta$. Memorylessness gives

$$
\mathbb P_y(\theta_{T_\lambda}\ge\delta)\ge p_\delta L_y,
\qquad p_\delta=(1-e^{-\lambda h})e^{-G_\delta h}>0.
\tag{8.6}
$$

To be observed in a south cap, the path must first exit the north cap. Strong Markov at that exit and Lemma 8.1 imply

$$
\mathbb P_y(\theta_{T_\lambda}>\pi-\varepsilon)
\le C\varepsilon L_y
\le C_\delta\varepsilon\mathbb P_y(\theta_{T_\lambda}\ge\delta).
\tag{8.7}
$$

Average over the initial fresh velocity to obtain the same inequality for the radial kernel $K$. Sum it over the disjoint events specifying the first observed exit index; all terms are nonnegative and $N_\delta<\infty$ by (7.4). The result is

$$
\mathbb P(\pi-r_{N_\delta}<\varepsilon)\le C_\delta\varepsilon.
\tag{8.8}
$$

There is no factor of $\mathbb E N_\delta$, because the sum on the right is exactly the total probability of first exit. On the middle annulus the weight is bounded. Near the south pole, integration of (8.8) gives $\mathbb E[(\pi-r_{N_\delta})^{-\kappa};\pi-r_{N_\delta}<\eta]\le C\eta^{1-\kappa}/(1-\kappa)$, proving (8.4). The new velocity at the exit refresh is independent and uniform conditional on the exit position and its past: that stopping event is determined before this velocity is drawn. Averaging $H$ by (6.6) gives (8.5). $\square$

**Proof of the upper limit in Theorem 1.3.** Fix $c>1$, choose $1 \lt c_1 \lt c$, and put $t_y=cy/(\lambda\mu)$, $u_y=c_1y/(\lambda\mu)$, $S_\delta=T_{N_\delta}$. Strong Markov at this actual physical stopping time, (1.7), and (8.5) give

$$
\begin{split}
\|\delta_{z_{r_0}}\sigma_{z_{r_0}}P_{t_y}-\Pi_a\|_{\mathrm{TV}}
&\le\mathbb P(S_\delta>u_y)
 +C e^{-\gamma(t_y-u_y)}\mathbb E H(X_{S_\delta})\\
&\le\mathbb P(S_\delta>u_y)+C' e^{-\gamma(t_y-u_y)}\longrightarrow0.
\end{split}
\tag{8.9}
$$

The first term vanishes by Lemma 7.1 and the second because $t_y-u_y\to\infty$. Projection contracts total variation, so the upper limit also holds for the position marginal. Together with Section 7.1 this proves Theorem 1.3. $\square$

# 9. Interpretation, diagnostics, and limits

The sharp uniform criterion identifies exactly when the singular north cap has a uniformly bounded return mechanism. Its failure does not mean a fixed regular initial point cannot converge geometrically. Theorem 1.2 separates these two notions. For $1 \lt a \lt d$, Theorem 1.3 further identifies how the nonuniform prefactor manifests at remote initial points: the leading burn-in time is logarithmic in inverse angular distance, with an explicit coefficient determined by the true refresh law.

Since $|x_0|=R\cot(r/2)$, one has $\log(1/r)=\log(|x_0|/R)-\log2+o(1)$. Thus the same first-order constant multiplies $\log|x_0|$ in Euclidean coordinates. This does not bound computational cost in bounce events. Very small angular momentum can generate many events per unit physical time; time cutoff and implementation runtime are different quantities.

The reproducibility directory checks independent beta-integral and gamma-function expressions for $M$, the derivative giving $\mu$, the identity $M(a-d)=1$, exact cycle identities, and discounted renewal asymptotics. In particular at $a=2$,

$$
\mathbb E C_\beta=2\pi\tan(\beta/2),
\tag{9.1}
$$

obtained by integrating $1/(1-\cos\beta\cos t)$ on $[0,\pi]$. Numerical evaluations are diagnostics only. They do not certify the infinite-dimensional Markov arguments, the total-variation limits, or novel priority. The analytic arguments above, rather than simulations, support those statements.

The limitations are substantive. The target is globally radial; the nonradial condition in [1, Remark 2.2] remains open here. The process is asserted only on $E_*$; pole or exactly meridional entrance extensions require separate work. Cutoff is proved for fixed parameters, $1 \lt a \lt d$, and a uniform initial tangent velocity. Neither a cutoff window/profile, a central limit theorem, critical $a=1$ cutoff, optimal refresh tuning, robustness to nonradial perturbations, nor dimension-uniform constants is claimed.

# References

1. J. Yang, K. Łatuszyński, and G. O. Roberts (2024). *Stereographic Markov Chain Monte Carlo*. **Annals of Statistics 52**(6), 2692-2713. DOI: [10.1214/24-AOS2426](https://doi.org/10.1214/24-AOS2426). Author version: [arXiv:2205.12112v2](https://arxiv.org/html/2205.12112v2), including supplementary proofs. Relevant locations: Theorem 2.2, Remark 2.2, Sections S8.4 and S8.6.

2. C. Bell, K. Łatuszyński, and G. O. Roberts (2026). *Adaptive Stereographic MCMC*. [arXiv:2408.11780v3](https://arxiv.org/html/2408.11780v3), 7 July 2026. Annals of Applied Probability, accepted 1 July 2026 according to the Warwick repository. Relevant location: Assumption 3.4 and the Student sufficient condition.

3. S. Grazzi, S. Liu, G. O. Roberts, and J. Yang (2026). *Sub-Cauchy Sampling: Escaping the Dark Side of the Moon*. [arXiv:2601.11066v1](https://arxiv.org/html/2601.11066v1), 16 January 2026. Relevant distinction: discrete projection Metropolis sampling.

4. F. Milinanni, T. Farghly, and J. Yang (2026). *Rapid Mixing of Stereographic MCMC for Heavy-Tailed Sampling*. [arXiv:2610.18513v1](https://arxiv.org/html/2610.18513v1), 13 October 2026. Relevant locations: Sections 2 and 3, SPS/SCPS mixing bounds and algorithm definitions.

5. D. Ledvinka and J. S. Rosenthal (2025). *Equivalence of starting point cutoff and the concentration of hitting times on a general state space*. **Electronic Communications in Probability 30**, paper 15. DOI: [10.1214/25-ECP663](https://doi.org/10.1214/25-ECP663). Theorem 2.6 concerns a discrete-time regular kernel; it is cited for conceptual attribution, not applied as an unchecked continuous-time theorem.

6. G. Deligiannidis, A. Bouchard-Côté, and A. Doucet (2019). *Exponential ergodicity of the bouncy particle sampler*. **Annals of Statistics 47**(3), 1268-1287. DOI: [10.1214/18-AOS1714](https://doi.org/10.1214/18-AOS1714). Theorem A states the continuous-time drift criterion used here.

7. D. Down, S. P. Meyn, and R. L. Tweedie (1995). *Exponential and uniform ergodicity of Markov processes*. **Annals of Probability 23**(4), 1671-1691. DOI: [10.1214/aop/1176987798](https://doi.org/10.1214/aop/1176987798). Theorem 5.2 supplies the Foster-Harris implication.

8. A. Mijatović and V. Niraj (2026). *Hypocoercivity of Tempered Bouncy Particle Samplers for Heavy-Tailed Targets*. [arXiv:2608.29657](https://arxiv.org/abs/2608.29657). First submitted 30 August 2026; the retrieved full text is dated 16 October 2026. Relevant locations: Section 1.1, Theorem 1.1, Remark 1.2, and Corollary 1.3. This is a different Euclidean process with state-dependent velocity tempering and $L^2$-based mixing estimates.
