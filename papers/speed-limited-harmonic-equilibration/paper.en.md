# Minimum work in a moving harmonic trap with a hard speed limit

*Exact protocols for fixed endpoints, a prescribed particle mean and a prescribed actuator position*

## Abstract

We determine the least expected work required to translate an overdamped Brownian particle in a harmonic trap whose centre has bounded velocity. The forward and reverse speed limits can differ. For fixed initial and final mean velocities in the actuator's invariant velocity interval, the optimal mean velocity is a constant clipped between two explicit reachable envelopes. This gives the entire displacement range and a global work-gap bound. From equilibrium, we obtain exact protocols both when the final mean is prescribed and the actuator is free, and when the final actuator position is prescribed and the mean is free. A free actuator brakes as the particle approaches its target; prescribing a positive actuator displacement instead gives a second forward push. We determine when the constant-velocity interval disappears and how the work approaches each positive displacement frontier. The proofs compare every admissible protocol and include the tight-speed regime.

## 1. The controlled observable

What does it cost to move a trapped Brownian particle by a prescribed distance before a deadline? Moving the trap by that distance and placing the particle in equilibrium at the new location impose different conditions. Muratore-Ginanneschi and Sanders formulate these distinctions for a finite trap-centre speed, leave the hard-bound equilibrium case untreated in detail, and use push and constant-speed segments, a large-speed expansion and numerical optimization for the free-final-actuator problem [1, §§4.1–4.4, Appendix B]. We give exact global solutions for finite speed limits and identify the reachable parameter ranges.

Let the potential be $\kappa(q-\lambda(t))^2/2$ with stiffness $\kappa>0$, friction $\gamma>0$ and relaxation rate $k=\kappa/\gamma$. The prescribed, absolutely continuous trap centre $\lambda$ has velocity $u$ satisfying
$$
-B\le u(t)=\dot\lambda(t)\le A\quad\text{almost everywhere},\qquad A,B>0,\quad 0\le t\le T.
$$
The experiment is isothermal. In the overdamped Langevin equation $dq_t=-k(q_t-\lambda(t))\,dt+\sqrt{2k_{\rm B}\Theta/\gamma}\,dW_t$, the mean $x(t)=\mathbb E q_t$ satisfies
$$
v=\dot x=k(\lambda-x),\qquad \dot v=k(u-v).                            \tag{1}
$$
Here $v$ is the velocity of the mean; individual Brownian trajectories have no instantaneous velocity. We may start with a Gaussian having the thermal variance $k_{\rm B}\Theta/\kappa$. That variance stays constant. An endpoint with $v=0$ is then in thermal equilibrium with its trap; nonzero $v$ describes a Gaussian displaced from the centre. Formula (1) also describes the mean for other initial laws with a finite mean, while the endpoint distribution then follows its own uncontrolled shape evolution.

The expected work performed **on** the system is
$$
\mathcal W=\kappa\int_0^T(\lambda-x)u\,dt
 =\gamma\int_0^T v^2\,dt+\frac{\gamma}{2k}\{v(T)^2-v(0)^2\}.           \tag{2}
$$
Indeed $u=v+\dot v/k$ almost everywhere. For $D=x(T)-x(0)$ and $L=\lambda(T)-\lambda(0)$ we have
$$
D=\int_0^T v\,dt,\qquad L=D+\{v(T)-v(0)\}/k.                         \tag{3}
$$
Once $v$ is known, $x(t)=x(0)+\int_0^t v$ and $\lambda(t)=x(t)+v(t)/k$ recover the laboratory protocol. Translating the spatial origin has no effect.

## 2. Prescribed endpoint lags and exact reachability

Let $v(0)=v_0$ and $v(T)=v_1$ belong to $[-B,A]$ and prescribe $D$. This range includes all endpoints reached from an equilibrium start. The endpoint lags are $v_0/k,v_1/k$. For $s\in\{-B,A\}$ define
$$
F_s(t)=s+(v_0-s)e^{-kt},\qquad H_s(t)=s+(v_1-s)e^{k(T-t)}.
$$
They solve (1) with constant $u=s$ from the initial or final endpoint. Put
$$
l(t)=\max\{F_{-B}(t),H_A(t)\},\qquad
h(t)=\min\{F_A(t),H_{-B}(t)\}.                                         \tag{4}
$$

**Theorem 1.** The data are feasible exactly when
$$
F_{-B}(T)\le v_1\le F_A(T),\qquad \int_0^T l\,dt\le D\le\int_0^T h\,dt. \tag{5}
$$
Choose any $c\in[-B,A]$ for which
$$
v_*(t)=\max\{l(t),\min(c,h(t))\},\qquad \int_0^T v_*\,dt=D.            \tag{6}
$$
This is the unique optimal mean-velocity path, including at the endpoints of the reachable interval. For every feasible competitor $v$,
$$
\mathcal W(v)-\mathcal W(v_*)\ge\gamma\int_0^T(v-v_*)^2dt.             \tag{7}
$$
The unique actuator velocity is understood up to changes on null sets.

**Proof.** Variation of constants in (1) forward and backward bounds every feasible $v$ between $l$ and $h$. If the first condition in (5) holds, a constant input $u=(v_1-v_0e^{-kT})/(1-e^{-kT})$ joins the velocity endpoints, showing $l\le h$. Both envelopes coincide with the prescribed endpoints there. Taking the minimum or maximum of absolutely continuous solutions of the differential inequalities $k(-B-v)\le\dot v\le k(A-v)$ preserves those inequalities. The derivative equals that of the active branch almost everywhere, including almost every tie. Each constant $c\in[-B,A]$ is also a solution of the inequalities. Thus (6) is feasible and has the right endpoints. In (6) the area depends continuously and monotonically on $c$. At $-B$ and $A$ it gives the two extreme areas because $l,h\in[-B,A]$. This proves (5).

For a competitor with the same area, expanding the quadratic cost in (2) gives its difference divided by $\gamma$ as
$$
\int_0^T(v-v_*)^2dt+2\int_0^T(v_*-c)(v-v_*)dt.
$$
The second integrand is nonnegative by projection onto the interval $[l(t),h(t)]$. Thus (7) holds. Equality forces identical continuous paths; (1) gives identical controls almost everywhere. A nonunique multiplier at a frontier still specifies the same unique path. $\square$

### 2.1. Equilibrium at both ends

Take $v_0=v_1=0$ and $D\ge0$. Write
$$
a(c)=\frac1k\log\frac{A}{A-c},\qquad
b(c)=\frac1k\log\frac{B+c}{B},\qquad P(c)=T-a(c)-b(c).
$$
For $0\le c\le p$, (6) launches at $u=A$ for $a(c)$, holds the particle mean speed $c$ with $u=c$ for $P(c)$, and brakes at $u=-B$ for $b(c)$. The peak when there is no time left for a plateau is
$$
p=\frac{AB(e^{kT}-1)}{A+Be^{kT}},
\qquad D_{\mathrm e}=-BT+\frac{A+B}{k}\log\frac{A+Be^{kT}}{A+B}.        \tag{8}
$$
Every $0\le D\le D_{\mathrm e}$ has a unique $c$ given by
$$
D(c)=Aa(c)+cP(c)-Bb(c),\qquad
\frac{\mathcal W_{\mathrm e}(D(c))}{\gamma}
 =A^2a(c)+c^2P(c)+B^2b(c)-\frac{(A+B)c}{k}.                          \tag{9}
$$
The areas follow from (3) with zero endpoint velocities; for work use $dt=dv/[k(A-v)]$ on the rising segment and $dt=-dv/[k(B+v)]$ on the falling segment of the trajectory. In (8), $p$ solves $a(p)+b(p)=T$, and substitution in (9) gives $D_{\mathrm e}$. If $A=B=M$, $D_{\mathrm e}=2M\log\cosh(kT/2)/k$. The least duration that can move an initially equilibrated particle a distance $D$ into equilibrium is therefore $2\operatorname{arcosh}(\exp(k|D|/(2M)))/k$.

Differentiation gives $D'(c)=P(c)$ and $d\mathcal W_{\mathrm e}/dD=2\gamma c$ for $0<D<D_{\mathrm e}$. The response at the reachability frontier is nonanalytic. Define
$$
g=\frac{A+B}{k(A-p)(B+p)},\qquad \delta=D_{\mathrm e}-D\downarrow0 .
$$
Then
$$
\mathcal W_{\mathrm e}(D)
=\mathcal W_{\mathrm e}(D_{\mathrm e})-2\gamma p\,\delta+
  \frac{4\gamma}{3}\sqrt{\frac2g}\,\delta^{3/2}+O(\delta^2).            \tag{10}
$$
Indeed $P(c)=g(p-c)+O((p-c)^2)$, so $\delta=g(p-c)^2/2+O((p-c)^3)$. Integrating the marginal cost proves (10). Thus the marginal work stays finite while the second derivative diverges. For negative displacement, reflect the coordinates and interchange $A$ and $B$ in all positive-displacement formulas.

## 3. Prescribed final particle mean and a free actuator

Again set $v_0=0$. The target is the mean displacement $D\ge0$ with no prescribed final trap location. In this case the terminal energy in (2) affects the optimizer.

**Theorem 2.** The largest reachable positive displacement is
$$
D_{\mathrm f}=A\left[T-\frac{1-e^{-kT}}{k}\right].                    \tag{11}
$$
For $0\le D<D_{\mathrm f}$ choose a scalar $c\ge0$. Define $Q=B+2c$ and
$$
m=\min\left\{c,\frac{A+Q-\sqrt{(A-Q)^2+4AQe^{-kT}}}{2}\right\},\qquad
s=\frac{m(2c-m)}{Q}.                                                    \tag{12}
$$
With
$$
a=\frac1k\log\frac A{A-m},\qquad b=\frac1k\log\frac Q{Q-m},\qquad P=T-a-b,
$$
the unique optimum uses $u=A$ for $a$, $u=m$ for $P$, and $u=-B$ for $b$. It reaches mean speed $m$ at the first switch and terminal mean speed $s$. The scalar $c$ is determined uniquely by
$$
D=Aa+mP-Bb-\frac{s}{k}.
$$
The minimum work is
$$
\frac{\mathcal W_{\mathrm f}}{\gamma}
 =A^2a+m^2P+B^2b-\frac{(A+B)m}{k}+\frac{Bs}{k}.                       \tag{13}
$$
For $0<c<c_0$ there is a positive-length plateau, where $c_0$ is the unique solution in $(0,A)$ of
$$
\frac1k\log\frac A{A-c_0}+\frac1k\log\frac{B+2c_0}{B+c_0}=T.         \tag{14}
$$
At and beyond $c_0$ the profile switches directly from $+A$ to $-B$. At $D=D_{\mathrm f}$ the unique control is $+A$ throughout. Negative $D$ is obtained by reflection.

**Construction.** The maximum possible path from equilibrium is $F_A(t)=A(1-e^{-kt})$, proving (11) and uniqueness there. For a fixed $c$, penalize the objective by $-2\gamma c\,D$. Seek a rising capped arc up to $m\le c$, an optional constant arc at $c$, and a descending capped arc of length $b$ ending at $s$. On the last arc $v_*=-B+(B+s)e^{k(T-t)}$. The scalar terminal balance needed in the global comparison is
$$
\frac{s}{k}+2\int_{T-b}^T(v_*-c)e^{k(T-t)}\,dt=0.                    \tag{15}
$$
Writing $E=e^{kb}$, the moment identity on the descending arc is $(B+s)E=B+m$. Multiplying (15) by $k$ gives $(B+s)E^2-2(B+c)E+B+2c=0$. These equations yield $E=Q/(Q-m)$ and the value of $s$ in (12). The rising and descending times together are strictly increasing as functions of $m\in[0,\min(A,Q))$. If they exhaust $T$, the smaller root of $(A-m)(Q-m)=AQe^{-kT}$ gives $m$. If reaching $m=c$ leaves time to spare, holding there fills the horizon. This establishes (12), $P\ge0$ and the criterion (14). When $c\ge A$ there is always a direct switch. At $c=0$ the optimum is the zero path.

**Global optimality.** Given any competing path $v$ with the same initial velocity, expand the penalized cost about $v_*$. Besides $\gamma\int(v-v_*)^2+\gamma(v(T)-s)^2/(2k)$, the difference divided by $\gamma$ contains the first-variation expression
$$
2\int_0^T(v_*-c)(v-v_*)\,dt+\frac{s}{k}(v(T)-s).                      \tag{16}
$$
On launch, $v\le F_A=v_*$ and $v_*\le c$. On a positive-length plateau $v_*=c$. On the terminal arc, the lower bound $u\ge-B$ gives
$$
v(t)-v_*(t)\le (v(T)-s)e^{k(T-t)} .
$$
Since $v_*\le c$ on this arc as well, (16) is bounded below by $v(T)-s$ times the vanishing left side of (15). Thus (16) is nonnegative. This proves global minimality and uniqueness whenever the prescribed displacement equals the area of the exhibited path.

**Coverage and cost.** In the direct-switch case $m$ strictly increases with $c$ because the sum of the two times increases with $m$ and decreases with $Q$ at each fixed $m>0$. On the plateau branch $m=c$. The function $s=m(2c-m)/(B+2c)$ is strictly increasing in $c$ for $c>0$: its partial $c$ derivative is $2m(B+m)/(B+2c)^2$ and its partial $m$ derivative is $2(c-m)/(B+2c)\ge0$. The full profile is
$$
\min\{F_A(t),c,-B+(B+s)e^{k(T-t)}\}.
$$
These functions give a continuous, pointwise nondecreasing family; its terminal value strictly increases, so its area strictly increases. As $c\to\infty$, $m\to A(1-e^{-kT})$, $b\to0$ and the profile tends to $F_A$. This proves there is exactly one $c$ for every interior target. Integrating the controls in (3) gives the displayed area. Integrating $v_*^2$ on the two exponential arcs and adding the terminal energy gives (13).

For every $0<D\le D_{\mathrm e}$ the terminal $s$ here is positive. Thus the free-terminal optimum uses strictly less work than the unique equilibrium-return optimum at the same mean displacement. At the larger frontier $D_{\mathrm f}$ the marginal cost diverges. With $v_M=A(1-e^{-kT})$ and $\delta=D_{\mathrm f}-D$,
$$
\mathcal W_{\mathrm f}(D_{\mathrm f})-\mathcal W_{\mathrm f}(D)
 =\gamma v_M\sqrt{\frac{2(A+B)}k}\,\sqrt{\delta}+O(\delta).            \tag{17}
$$
Near this frontier the control differs from an all-$+A$ drive only on the final brake of length $b$. Hence
$\delta=(A+B)[b-(1-e^{-kb})/k]$ and
$v_M-s=(A+B)(1-e^{-kb})$. The difference of the running integrals of $v^2$ is $O(b^2)$ since the velocities differ only for length $b$ and by $O(b)$. The leading term comes from the terminal energy in (2), proving (17).

## 4. Prescribed final actuator position and a free particle mean

A different experiment specifies only $L=\lambda(T)-\lambda(0)$. Continue to assume $v_0=0$ and consider $L\ge0$. The cap gives $0\le L\le AT$ for any such feasible positive displacement.

**Theorem 3.** For every $0\le L\le AT$, let
$$
0\le c\le A(1-e^{-kT/2}),\qquad
a=\frac1k\log\frac{A}{A-c},\qquad P=T-2a,\qquad L=2Aa+cP.
$$
The unique optimal control first pushes at $+A$ for $a$, holds $c$ for $P$, then pushes again at $+A$ for $a$. It ends with
$$
s=2c-c^2/A,\qquad D=L-s/k,\qquad
\frac{\mathcal W_\lambda}{\gamma}=2A^2a+c^2P-As/k.                    \tag{18}
$$
The reverse speed cap $B$ does not enter these positive-displacement formulas. Reflection gives the negative-displacement version.

**Proof.** Penalize (2) by $-2\gamma c(\int v+v(T)/k)$ using (3). Launch to $c$ and hold it as above. On the terminal push $v_*=A+(s-A)e^{k(T-t)}\ge c$. The conditions $e^{ka}=A/(A-c)$ and $s=2c-c^2/A$ ensure both continuity at the final switch and
$$
\frac{s-2c}{k}+2\int_{T-a}^T(v_*-c)e^{k(T-t)}dt=0.
$$
Indeed the integral times $2k$ equals $(s-c)^2/(A-s)$, and $s-2c+(s-c)^2/(A-s)=0$. The initial and plateau variations are nonnegative as before. The upper cap $u\le A$ now gives $v-v_*\ge(v(T)-s)e^{k(T-t)}$ on the terminal push. The first variation therefore has a lower bound of zero by the last identity, and the quadratic remainder proves uniqueness. The displacement function has derivative $T-2a+2/k>0$ and spans $[0,AT]$. The two positive pushes advance the speed from $0$ to $c$ and then from $c$ to $s$ along the same constant-input differential equation. Integrating the running cost over those velocity ranges and adding the terminal term proves (18). $\square$

## 5. Relation to earlier work

Schmiedl and Seifert [2] solved a finite-time translated-trap problem allowing jumps in the actuator. The jumps describe the no-cap limit of appropriate endpoint conditions. Aurell, Mejía-Monasterio and Muratore-Ginanneschi [3] penalized squared current acceleration as a running cost and derived boundary-layer profiles. Sanders and Muratore-Ginanneschi [4] treated an underdamped oscillator with force and stiffness controls under physical limitations. Bounded-force trajectories with a constant-speed singular segment also occur in deterministic vehicle control, for example in the quadratic-drag rendezvous model of Sciarretta and Guzzella [5]. These results precede the qualitative switching pattern. The exact finite actuator-speed reachability intervals, the two different terminal controls and the corresponding global work certificates above pertain to the fixed-stiffness overdamped problem in [1]. They do not optimize feedback controls, variable stiffness or underdamped phase-space distributions.

[1] P. Muratore-Ginanneschi and J. Sanders, *What is a minimum work transition in stochastic thermodynamics?* (2026). Sections 4.1–4.4 and Appendix B of the revision dated 21 November 2026. [arXiv:2603.11995v2](https://arxiv.org/abs/2603.11995v2).

[2] T. Schmiedl and U. Seifert, *Optimal finite-time processes in stochastic thermodynamics*, Physical Review Letters **98**, 108301 (2007). [Article](https://doi.org/10.1103/PhysRevLett.98.108301).

[3] E. Aurell, C. Mejía-Monasterio and P. Muratore-Ginanneschi, *Boundary layers in stochastic thermodynamics*, Physical Review E **85**, 020103(R) (2012). [Article](https://doi.org/10.1103/PhysRevE.85.020103).

[4] J. Sanders and P. Muratore-Ginanneschi, *Optimal control of engineered swift equilibration of nanomechanical oscillators*, New Journal of Physics **28**, 064604 (2026). [Article](https://doi.org/10.1088/1367-2630/ae799c).

[5] A. Sciarretta and L. Guzzella, *Fuel-optimal control of rendezvous maneuvers for passenger cars*, at – Automatisierungstechnik **53** (2005), 244–250. [Article](https://doi.org/10.1524/auto.53.6.244.65604).
