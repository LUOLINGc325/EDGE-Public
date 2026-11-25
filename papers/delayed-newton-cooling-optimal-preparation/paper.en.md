---
title: "Full-history optimal preparation in delayed Newton cooling"
subtitle: "Pointwise dominance, strict uniqueness, and an exact certificate"
date: "Research manuscript v2 · 24 November 2026"
---

## Abstract and contribution boundary

For the scalar delayed cooling equation with delay $0<\tau\le 1/e$, bounded preparation baths and a common final cold bath, we prove a simultaneous pointwise comparison over the full class of histories at a fixed initial temperature difference. The minimizing history is the established synchronous two-reservoir protocol. Strict likelihood-ratio ordering then yields uniqueness of the globally optimal bath pair up to null sets. This addresses the general-history conjecture of Santos [1, Section 6.3], whose official arXiv v1 abstract and full text were checked on 24 November 2026.

The protocol, its trajectory formula, reversal window, balance prescription and rounded numerical optimum have prior sources [1–4]. Log-concavity, monotone likelihood ratios and the threshold comparison are classical tools [5,6]. The proposed contribution is the full-history pointwise theorem and its rigorous strictness consequences for this specific model, with an endpoint extension and a rational instance certificate. This is an internally checked research manuscript, not an externally peer-reviewed priority claim. The bounded literature audit found no earlier proof of the same full-class theorem; its exact corpus and limits are recorded in `NOVELTY_AUDIT.md`.

Optimal thermal preparation and reachable-state constraints already occur in other models [7–9]. Those papers optimize different dynamics or objectives. We do not claim the idea of bounded optimal preparation or an extremal-temperature protocol as new.

## 1. Exact target and scope

The model, in the source's dimensionless time units, is

\[
\dot T_X(t)=-T_X(t-\tau)+T_b^X(t),\qquad X\in\{A,B\},\qquad 0<\tau<e^{-1}.
\]

The common final bath is at temperature \(T_c\). For \(t<0\), each bath history is bounded by the same fixed interval \([T_c,T_h]\), with \(T_h>T_c\), and is constant sufficiently far in the past. Before its finite preparation interval, each sample is equilibrated with its initial bath. At \(t=0\), both bath temperatures are changed to \(T_c\) and remain there. The source allows continuous changes, discrete quenches, and their combinations. Bounded measurable histories will be covered here, a larger class.

Put

\[
x_X(t)=\frac{T_X(t)-T_c}{T_h-T_c},\quad
u_X(t)=\frac{T_b^X(t)-T_c}{T_h-T_c},\quad
\Delta(t)=x_A(t)-x_B(t).
\]

Then \(0\le u_X(t)\le1\) for \(t<0\), \(u_X(t)=0\) for \(t\ge0\), and

\[
x'_X(t)=-x_X(t-\tau)+u_X(t).
\]

For protocols with \(\Delta(0)>0\) and one later reversal of temperature ordering, the source's objective (its Eq. (25)) is

\[
\mathcal M=\min\left\{\Delta(0),-\min_{t\ge0}\Delta(t)\right\}.
\]

The conjecture is that its global maximum is attained by a synchronous two-reservoir preparation: for some waiting time \(w>0\), sample A is equilibrated at the hot bath and is changed to the cold bath at \(-w\); sample B is equilibrated at the cold bath and is changed to the hot bath at \(-w\); B is changed back to the cold bath at 0. The source establishes this only within a restricted family and gives numerical support for additional switching families. Our key claim is pointwise dominance over **all** bounded preparation histories with the same initial temperature difference.

We prove the result also at the endpoint \(\tau=e^{-1}\). This endpoint is an extension; it is not required to settle the source's stated conjecture. We do not address delays larger than \(e^{-1}\), nonlinear cooling, finite-rate bath changes imposed as a constraint, preparation-energy budgets, or the microscopic explanation of the Mpemba effect in water.

## 2. A positive log-concave fundamental response

Positivity/nonoscillation at the $1/e$ boundary and exponential integral supersolutions have classical precedents [10,11]. The specialized construction below is included to establish every kernel property used here, without a standalone priority claim for the method.

Write \(r(t)=0\) for \(t<0\). On \([0,\infty)\), the fundamental response is the unique locally absolutely continuous function satisfying

\[
r(0)=1,\qquad r'(t)=-r(t-\tau)\quad\text{for almost every }t>0. \tag{2.1}
\]

Equivalently, it satisfies \(r(t)=1-\int_0^t r(s-\tau)\,ds\) for every \(t\ge0\). The method of steps gives uniqueness: \(r=1\) on \([0,\tau]\), and values on each next delay interval are obtained by integrating values on the preceding interval.

### Lemma 1

For \(0<\tau\le e^{-1}\), \(r\) is positive, nonincreasing and log-concave on \([0,\infty)\). It is integrable, with

\[
\int_0^\infty r(s)\,ds=1.
\]

If \(\kappa\in(1,e]\) is the smallest positive solution of \(\kappa=e^{\kappa\tau}\) (the two positive roots coincide when \(\tau=e^{-1}\)), its negative logarithmic derivative \(h=-r'/r\) satisfies \(0\le h\le\kappa\), is zero before \(\tau\), and is strictly increasing on \([\tau,\infty)\).

**Proof.** The solution \(\kappa\) exists because \(\log\kappa/\kappa\) increases from 0 to \(1/e\) on \([1,e]\). Define \(h_0(t)=0\) on the whole real line, and recursively

\[
h_{n+1}(t)=
\begin{cases}
0,&t<\tau,\\
\displaystyle\exp\!\left(\int_{t-\tau}^{t}h_n(s)\,ds\right),&t\ge\tau.
\end{cases} \tag{2.2}
\]

Inductively, each \(h_n\) is nondecreasing in \(t\): the integral of a nondecreasing function over a fixed-length moving interval is nondecreasing, and the transition from 0 to the exponential is upward. The sequence is also nondecreasing in \(n\). Finally \(h_n\le\kappa\), since the integral in (2.2) is at most \(\kappa\tau\) and \(e^{\kappa\tau}=\kappa\). Therefore \(h=\lim_n h_n\) exists, is bounded and nondecreasing, and dominated convergence gives

\[
h(t)=0\;(t<\tau),\qquad
h(t)=\exp\!\left(\int_{t-\tau}^{t}h(s)\,ds\right)\;(t\ge\tau). \tag{2.3}
\]

Define

\[
\rho(t)=\exp\!\left(-\int_0^t h(s)\,ds\right),\qquad t\ge0.
\]

It is positive and locally absolutely continuous. For \(t<\tau\), \(\rho'=0\). For \(t>\tau\), (2.3) gives

\[
h(t)\rho(t)=\rho(t-\tau),\qquad \rho'(t)=-\rho(t-\tau).
\]

Thus \(\rho=r\) by uniqueness for (2.1). Since \(h\) is nonnegative and nondecreasing, \(r\) is nonincreasing and \(\log r\) is concave. Moreover \(h(t)\ge1\) for \(t\ge\tau\), so

\[
r(t)\le e^{-(t-\tau)}\quad(t\ge\tau).
\]

Consequently \(r(t)\to0\), and integrating (2.1) gives \(\int_0^\infty r=1\).

For strictness, (2.3) makes \(h\) continuous and locally Lipschitz on \((\tau,\infty)\), and

\[
h'(t)=h(t)\bigl(h(t)-h(t-\tau)\bigr)\quad\text{a.e. on }(\tau,\infty). \tag{2.4}
\]

There is no constant interval inside \([\tau,\infty)\). Indeed, if \(h=c>0\) on a nonempty interval above \(\tau\), (2.4) forces \(h=c\) also on its translate by \(-\tau\), up to endpoints and null sets. Repeating this implication, and using continuity away from \(\tau\), eventually gives a nonempty interval below \(\tau\) on which \(h=c\), contradicting \(h=0\) there. Equivalently, the first interval \((\tau,2\tau)\) has \(h'=h^2>0\), and any later plateau propagates backwards into this interval. A nondecreasing function without a constant interval is strictly increasing. \(\square\)

### Corollary 2

Define the relaxation function

\[
E(t)=\int_t^\infty r(s)\,ds\quad(t\ge0),\qquad E(t)=1\quad(t<0).
\]

Then

\[
E(t)=r(t+\tau),\quad E(0)=1,\quad E'(t)=-r(t)=-E(t-\tau),\quad E(t)\downarrow0. \tag{2.5}
\]

In particular, \(E\) is strictly decreasing and strictly log-concave on \([0,\infty)\), and

\[
e^{-\kappa t}\le E(t)\le e^{-t}\qquad(t\ge0). \tag{2.6}
\]

**Proof.** Integrating (2.1) from \(t+\tau\) to infinity gives the first identity. Strict decrease follows from \(r>0\). The logarithmic derivative is \(-h(t+\tau)\), strictly decreasing by Lemma 1. Integrating \(1\le h(t+\tau)\le\kappa\) gives (2.6). \(\square\)

Since \(h\) is nondecreasing and bounded by \(\kappa\), it has a limit \(\ell\le\kappa\). Taking the limit in (2.3) gives \(\ell=e^{\tau\ell}\). The definition of \(\kappa\) as the smallest positive solution implies \(\ell=\kappa\). Consequently, for each fixed \(w>0\),

\[
\frac{E(t+w)}{E(t)}\downarrow e^{-\kappa w}\quad(t\to\infty), \tag{2.7}
\]

and the ratio is strictly above its limit at every finite time.

The log-concavity fact is used here as a proved tool, without a priority claim. The next rearrangement is a standard monotone-likelihood-ratio/bathtub argument. The proposed contribution is their application to the entire admissible preparation class in the specified recent conjecture.

## 3. Correct treatment of prehistory

### Lemma 3

For a bounded bath history \(u\) constant sufficiently far in the past, with the sample equilibrated there, the unique sample solution is

\[
x(t)=\int_0^\infty r(a)u(t-a)\,da. \tag{3.1}
\]

If \(u(t)=0\) for \(t\ge0\), then

\[
x(t)=\int_0^\infty r(t+s)u(-s)\,ds\qquad(t\ge0). \tag{3.2}
\]

**Proof.** The integral is absolutely convergent. Far before preparation, \(u\) is constant and (3.1) equals that constant because \(\int r=1\), so it gives the required equilibrium prehistory. Differentiating the convolution in the distributional sense, and using the unit jump of the causal kernel at 0 and (2.1), gives

\[
x'(t)=u(t)-\int_0^\infty r(a-\tau)u(t-a)\,da=u(t)-x(t-\tau).
\]

For bounded measurable inputs this identity holds almost everywhere and the solution is locally absolutely continuous; for piecewise smooth inputs it is the usual classical identity away from the bath switches. Uniqueness follows by the method of steps from the equilibrium history before preparation. Formula (3.2) is a change of variables in (3.1), using that the future input is zero. \(\square\)

For two baths put \(v(s)=u_A(-s)-u_B(-s)\). Then \(-1\le v\le1\), \(v\) is eventually constant, and

\[
\Delta_v(t)=\int_0^\infty r(t+s)v(s)\,ds,\qquad
m:=\Delta_v(0)=\int_0^\infty r(s)v(s)\,ds. \tag{3.3}
\]

Any original Mpemba comparison has \(0<m<1\). If \(m=1\), positivity of \(r\) would force \(v=1\) almost everywhere, and then \(\Delta_v(t)=E(t)>0\), with no reversal.

## 4. Pointwise dominance: the main theorem

### Theorem 4

Fix \(0<\tau\le e^{-1}\) and any measurable \(v:[0,\infty)\to[-1,1]\) satisfying \(m=\int r v\in(0,1)\). There is a unique \(w>0\) such that

\[
2E(w)-1=m. \tag{4.1}
\]

Define

\[
v_w(s)=\begin{cases}-1,&0\le s<w,\\+1,&s>w.\end{cases}
\]

Then, simultaneously for every \(t\ge0\),

\[
\boxed{\ \Delta_v(t)\ge\Delta_w(t):=2E(t+w)-E(t),\qquad \Delta_v(0)=\Delta_w(0)=m.\ } \tag{4.2}
\]

The function \(v_w\) is exactly the synchronous two-reservoir bath difference.

**Proof.** Existence and uniqueness of \(w\) follow from continuity and strict decrease of \(E\) from 1 to 0. The threshold history has initial difference

\[
\int r(s)v_w(s)\,ds=2\int_w^\infty r(s)\,ds-1=2E(w)-1=m.
\]

For fixed \(t\ge0\), set

\[
q_t(s)=\frac{r(t+s)}{r(s)}.
\]

Log-concavity of \(r\) implies that \(q_t\) is nonincreasing. This can also be read directly from

\[
q_t(s)=\exp\left(-\int_s^{s+t}h(a)\,da\right)
\]

and the monotonicity of \(h\). Let \(\delta=v-v_w\). It is nonnegative below \(w\) and nonpositive above \(w\), and \(\int r\delta=0\). Therefore

\[
\begin{aligned}
\Delta_v(t)-\Delta_w(t)
&=\int_0^\infty r(s)q_t(s)\delta(s)\,ds\\
&=\int_0^\infty r(s)\bigl(q_t(s)-q_t(w)\bigr)\delta(s)\,ds\ge0.
\end{aligned}
\]

The last integrand is nonnegative on both sides of \(w\). Finally,

\[
\Delta_w(t)=\int_w^\infty r(t+s)\,ds-\int_0^w r(t+s)\,ds=2E(t+w)-E(t).
\]

No discretization, restriction on switch count, or assumption about the future minimizer was used. \(\square\)

### Admissibility and resolution of the source's conjecture

Take the actual bath histories

\[
u_A(t)=\begin{cases}1,&t<-w,\\0,&t\ge-w,\end{cases}\qquad
u_B(t)=\begin{cases}0,&t<-w,\\1,&-w<t<0,\\0,&t\ge0.\end{cases}
\]

Both are equilibrated before the finite preparation interval \([-w,0]\), and they use exactly the same extrema 0 and 1 as the original normalized temperature range. For \(t\ge0\),

\[
x_A(t)=E(t+w)>0,\qquad x_B(t)=E(t)-E(t+w)>0.
\]

Thus neither sample overshoots the final cold bath. Their derivatives are nonpositive because \(r\) is nonincreasing. Furthermore

\[
\frac{\Delta_w(t)}{E(t)}=2\frac{E(t+w)}{E(t)}-1
\]

is strictly decreasing in \(t\), by strict log-concavity of \(E\). Hence the temperature difference crosses zero at most once. If the original history exhibits a negative difference at any later time, (4.2) ensures that the synchronous history does too; because its initial difference is \(m>0\), it has exactly one positive-to-negative crossing.

Consequently every original admissible Mpemba protocol is dominated by an admissible synchronous two-reservoir protocol with the same initial temperature difference and a reversal at least as deep:

\[
\mathcal M(v)\le\mathcal M(v_w).
\]

This proves the full-history optimality statement formulated in Section 6.3 of [1] under the hypotheses above. The argument is presented as a research manuscript pending external review. It covers even comparisons whose original trajectories have multiple crossings; their dominating synchronous comparison has one crossing whenever they have any reversal.

## 5. Unique global optimum and balance equations

The reversal window, the minimum-time identity, and the balancing prescription already appear in Santos (2024), Section III and Figure 11 [2]; later treatments include [1,4]. Their role below is inherited. We supply the strict analytic existence and uniqueness argument and combine it with the full-history dominance theorem.

Let \(w_0\) be the unique number with \(E(w_0)=1/2\). Then

\[
\frac{\log2}{\kappa}\le w_0\le\log2.
\]

More precisely, writing \(w_c=(\log2)/\kappa\), we have \(w_c<w_0\). By (2.7), a synchronous preparation has a positive initial difference and a later reversal **if and only if**

\[
w_c<w<w_0. \tag{5.0}
\]

At \(w=w_c\), the normalized difference stays positive at every finite time and its ratio to \(E(t)\) tends to zero. Thus the critical endpoint is not a finite-time crossing.

For \(0\le w\le w_0\), define

\[
a(w)=2E(w)-1,\qquad
b(w)=\sup_{t\ge0}\{E(t)-2E(t+w)\}. \tag{5.1}
\]

The supremum is at least 0 because the expression tends to 0 as \(t\to\infty\). Its positive values are attained at finite times. Extend the magnitude as \(M(w)=\min\{a(w),b(w)\}\), including histories without an actual reversal by magnitude zero when \(b=0\).

### Theorem 5

There is a unique \(w_*\in(w_c,w_0)\) satisfying

\[
\boxed{\quad 2E(w_*)-1=\sup_{t\ge0}\{E(t)-2E(t+w_*)\}.\quad} \tag{5.2}
\]

It uniquely maximizes \(M(w)\), and therefore gives the global optimum among all bounded preparation histories. Its magnitude \(M_*=2E(w_*)-1\) is positive.

**Proof.** The function \(a\) is continuous and strictly decreasing from 1 to 0. The function \(b\) is nondecreasing, since \(E(t+w)\) decreases with \(w\). Since \(|E'|=r\le1\),

\[
|b(w)-b(z)|\le2|w-z|,
\]

so \(b\) is continuous. We have \(b(0)=0\). Strict log-concavity and \(E(0)=1\) give, for \(t,w>0\),

\[
E(t+w)<E(t)E(w).
\]

At \(w=w_0\), this makes \(E(t)-2E(t+w_0)>0\) for every \(t>0\), hence \(b(w_0)>0\). Therefore the continuous function \(a-b\), strictly decreasing, has exactly one zero \(w_*\) in the interior, and its common value is positive. On the right of \(w_*\), the objective is smaller because \(a\) is strictly decreasing. On its left, if \(b(w)=0\), the objective is zero; otherwise a finite maximizer \(t_w\) gives

\[
b(w_*)\ge E(t_w)-2E(t_w+w_*)>E(t_w)-2E(t_w+w)=b(w).
\]

Thus no other waiting time attains the optimum. \(\square\)

### Corollary 6: two scalar equations

Let \(c_*>0\) be the unique zero of \(\Delta_{w_*}\). Before time 0, this synchronous difference is positive, since it starts at 1 and decreases only to \(a(w_*)>0\). The delay equation gives \(\Delta'_{w_*}(t)=-\Delta_{w_*}(t-\tau)\). Therefore the unique global minimum occurs at \(t_*=c_*+\tau\). The optimum is characterized by

\[
\begin{cases}
2E(c_*+w_*)=E(c_*),\\
2E(w_*)-1=E(c_*+\tau)-2E(c_*+\tau+w_*).
\end{cases} \tag{5.3}
\]

The crossing and balance equations are computational consequences, not replacements for the proof of global optimality.

## 6. Exact equality condition and a quantitative deficit

The proof of Theorem 4 yields the exact nonnegative identity

\[
\Delta_v(t)-\Delta_w(t)=
\int_0^\infty r(s)|q_t(s)-q_t(w)|\,|v(s)-v_w(s)|\,ds. \tag{6.1}
\]

For \(t>\tau\), \(q_t\) is strictly decreasing: its logarithmic derivative is \(h(s)-h(s+t)<0\) almost everywhere, using \(h=0\) before \(\tau\) and strict increase thereafter. Consequently equality in (4.2), at any one time \(t>\tau\), forces \(v=v_w\) almost everywhere.

In particular, the globally optimal original bath pair is unique up to null sets in the bath histories, after the cold/hot normalization and choice of labels. To see this, any attaining pair must have \(m=M_*\): an initial difference below \(M_*\) directly lowers its objective, and an initial difference above \(M_*\) corresponds to \(w<w_*\) and has maximal possible reversal \(b(w)<M_*\). Its negative minimum is attained at a finite time. Pointwise dominance and the uniqueness of the synchronous minimum force this time to be \(t_*=c_*+\tau>\tau\), with equality in (4.2). Thus \(v=v_{w_*}\) a.e. Since \(0\le u_A,u_B\le1\), the difference \(+1\) forces \((u_A,u_B)=(1,0)\), and \(-1\) forces \((u_A,u_B)=(0,1)\).

For an explicit fixed-initial-difference robustness bound, choose \(0<\varepsilon<w\), \(t>\tau\), and let

\[
C=\min\{q_t(w-\varepsilon)-q_t(w),\ q_t(w)-q_t(w+\varepsilon)\}>0.
\]

Then

\[
\Delta_v(t)-\Delta_w(t)\ge
C\int_{|s-w|\ge\varepsilon} r(s)|v(s)-v_w(s)|\,ds. \tag{6.2}
\]

This bounds the penalty at a specified observation time for deviations separated from the optimal switching instant. It is not, by itself, a uniform bound on the loss in the maximized magnitude when the initial difference is allowed to change.

## 7. A certified approximation route

The rounded optimum at \(\tau=0.36\) is already reported in [1,4]. Additional digits are not a primary novelty claim; the certificate below isolates the algebraic root with exact arithmetic.

Equations (5.2) and (5.3) provide small numerical problems, but the following elementary estimates allow a rigorous fallback without trusting a nonlinear solver.

For \(F_w(t)=E(t)-2E(t+w)\),

\[
F_w(t)\le E(t)\le e^{-t},\qquad
|\partial_t F_w(t)|=|-r(t)+2r(t+w)|\le1.
\]

Choose \(T>0\), and a grid including 0 and \(T\) with spacing at most \(\eta\). Let

\[
L(w)=\max\bigl(0,\max_{\text{grid }t} F_w(t)\bigr).
\]

Then

\[
L(w)\le b(w)\le\max\{L(w)+\eta,\ e^{-T}\}. \tag{7.1}
\]

Replacing \(\eta\) by half the maximum grid spacing is valid when each point of \([0,T]\) is within that distance of a grid point. Interval evaluations of \(E\), combined with (7.1), supply rigorous signs for \(a-b\), hence bisection enclosures for \(w_*\). The explicit method-of-steps formula is

\[
E(t)=1+\sum_{n=0}^{\lfloor t/\tau\rfloor}
\frac{(n\tau-t)^{n+1}}{(n+1)!},\qquad t\ge0. \tag{7.2}
\]

Cancellation in this formula at large times requires sufficient precision or interval arithmetic. It is not necessary to evaluate large times if the tail estimate in (7.1) is used.

Exploratory 60-digit arithmetic solving (5.3) gives:

| Delay \(\tau\) | Waiting time \(w_*\) | Crossing \(c_*\) | Magnitude \(M_*\) |
|---:|---:|---:|---:|
| 0.05 | 0.658271092130 | 0.014802406258 | 0.000690690888 |
| 0.10 | 0.623097846810 | 0.029917513441 | 0.003088105910 |
| 0.15 | 0.588023061675 | 0.045332597425 | 0.007883785264 |
| 0.20 | 0.553918697105 | 0.061051316163 | 0.016205555778 |
| 0.25 | 0.522275442055 | 0.077374026369 | 0.029579347913 |
| 0.30 | 0.494396783510 | 0.094897773964 | 0.048996542419 |
| 0.36 | 0.465843984113 | 0.118758150767 | 0.079514980747 |

These are high-precision floating-point computations, not interval certificates. The \(\tau=0.36\) values match the original paper's rounded \(w\simeq0.466\), \(M\simeq0.080\). They validate transcription and the computational consequences; the analytic proof carries the global conclusion.

### 7.1 An exact algebraic certificate at \(\tau=9/25\)

For this delay, the relevant method-of-steps branches allow an exact reduction to a quartic. Put \(z=c+w-\tau\). The crossing equation in (5.3) is identically satisfied by

\[
w=z^2-z+1-\tau,\qquad c=-z^2+2z+2\tau-1. \tag{7.3}
\]

On the branch \(\tau<w<2\tau\), \(0<c<\tau\), and \(0<z<\tau\), substitution into the balance equation gives

\[
\begin{aligned}
&2E(w)-1+2E(c+\tau+w)-E(c+\tau)\\
&\qquad=\frac{18\tau^2-12\tau z^2+12\tau z-6\tau+3z^4-2z^3-12z^2+12z-3}{6}.
\end{aligned} \tag{7.4}
\]

For \(\tau=9/25\), this is \(P(z)/3750\), where

\[
P(z)=1875z^4-1250z^3-10200z^2+10200z-1767. \tag{7.5}
\]

Let

\[
L=\frac{22460213487983754014}{10^{20}},\qquad
U=\frac{22460213487983754015}{10^{20}}.
\]

Exact rational arithmetic gives \(P(L)<0<P(U)\). Moreover on \([0.224,0.225]\),

\[
P'(z)=7500z^3-3750z^2-20400z+10200
\ge10200-3750(0.225)^2-20400(0.225)>0.
\]

Thus there is exactly one root \(z_*\in(L,U)\). Formulas (7.3) imply all the stated branch inequalities. The corresponding positive initial difference, unique crossing, and balance equation identify it with the unique global optimum from Theorem 5, so no other roots of the quartic have been silently accepted. Exact monotonic evaluation of (7.3) and \(M=1-2w+(w-\tau)^2\), followed by outward decimal rounding, yields

\[
\begin{aligned}
0.465843984112743194806115&<w_*<0.465843984112743194811624,\\
0.118758150767094345328376&<c_*<0.118758150767094345343885,\\
0.0795149807473722442049649&<M_*<0.0795149807473722442148149.
\end{aligned} \tag{7.6}
\]

The accompanying `certificate_tau_9_25.py` uses Python's exact `Fraction` arithmetic and directed decimal rounding to check the root-isolating signs, monotonicity bound, branch ranges, and displayed enclosures. These are rigorous numerical enclosures, unlike the exploratory table. The global infinite-dimensional conclusion still comes from the analytic proof.

## 8. What is established, and what is not

The proposed result is a pointwise lower envelope for the entire bounded-history control class, a proof of global optimality and uniqueness of the synchronous two-reservoir protocol, and a unique one-dimensional balance characterization of its optimal waiting time. It directly targets the source's explicit conjecture. The log-concavity construction and bathtub comparison are supplied in full, but their use does not imply that either is historically new as a standalone mathematical technique.

No statement here proves a microscopic mechanism for real water, a universal theorem for all thermal-memory models, or any claim about optimality under additional finite switching-speed, energy, or preparation-time constraints. A reusable abstract extension is available: Theorem 4 works verbatim for any positive normalized log-concave causal response kernel, with its survival function in place of \(E\); the delay identity is needed only for the special location \(t_*=c_*+\tau\) of the minimum and for the proof that this particular physical model has such a kernel.





## Appendix A. An exact criterion for general response kernels

This reformulation of the classical translation-family monotone-likelihood-ratio characterization [5, Proposition 2.3] and threshold principle [6] explains which part of the argument transfers to
other linear response models. It is included with a proof, without claiming historical
novelty for the underlying rearrangement principle. The physical admissibility of a
different model must still be checked separately.

### Proposition A1 (classical ordering reformulation)

Let \(k:[0,\infty)\to(0,\infty)\) be continuous with
\(\int_0^\infty k(s)\,ds=1\), and put \(K(w)=\int_w^\infty k(s)\,ds\).
For each \(m\in(-1,1)\), let \(w_m>0\) satisfy \(2K(w_m)-1=m\), and define
\(v_m=-1\) below \(w_m\) and \(v_m=1\) above \(w_m\).
The following statements are equivalent:

1. \(k\) is log-concave on \([0,\infty)\).
2. For every \(m\in(-1,1)\), every measurable \(v:[0,\infty)\to[-1,1]\)
   with \(\int kv=m\), and every \(t\ge0\),

\[
\int_0^\infty k(t+s)v(s)\,ds
\ \ge\ \int_0^\infty k(t+s)v_m(s)\,ds.
\]

The same equivalence holds if the test histories in statement 2 are required to be
eventually constant.

**Proof.** If \(k\) is log-concave, \(q_t(s)=k(s+t)/k(s)\) is nonincreasing.
For \(\delta=v-v_m\), we have \(\int k\delta=0\), \(\delta\ge0\) below
the threshold, and \(\delta\le0\) above it. Thus

\[
\int_0^\infty k(s+t)\delta(s)\,ds
=\int_0^\infty k(s)[q_t(s)-q_t(w_m)]\delta(s)\,ds\ge0.
\]

Conversely, suppose statement 2 holds. Fix \(t>0\). If \(q_t\) were not
nonincreasing, continuity would give \(x<y\), a threshold \(w\in(x,y)\),
and disjoint bounded intervals \(I<w<J\) with
\(\sup_I q_t<\inf_J q_t\). By shrinking intervals, their positive \(k\)-masses
can be made equal to a common \(\mu>0\). Choose \(m=2K(w)-1\) and perturb the
threshold history by \(v=v_m+\mathbf1_I-\mathbf1_J\). The bounds
\(-1\le v\le1\) and the weighted mean are preserved, whereas

\[
\int_0^\infty k(s+t)(v-v_m)(s)\,ds
\le\mu(\sup_I q_t-\inf_J q_t)<0,
\]

a contradiction. The perturbation is eventually constant. Therefore \(q_t\)
is nonincreasing for every \(t>0\). With \(f=\log k\), taking consecutive
increments of length \(t\) gives

\[
2f(x+t)\ge f(x)+f(x+2t).
\]

Continuous midpoint-concavity implies concavity, so \(k\) is log-concave.
\(\square\)

The reverse implication requires **all** \(m\in(-1,1)\), not only the positive
initial differences used in the cooling application. Nor does ordinary
log-concavity alone imply a unique optimizing history: uniqueness requires
strict likelihood-ratio ordering at a relevant observation time.


## Verification and formalization scope

The analytic proof above establishes the response-kernel properties, the representation of complete prehistories, feasibility, existence and strict uniqueness. The companion exact-rational script certifies the quartic instance at $\tau=9/25$. An independently implemented LP check covers 160 exactly integrated finite control families, including their infinite constant tails; its floating-point comparison is numerical corroboration. The high-precision method-of-steps calculation is also corroboration rather than a continuum proof.

The Lean project formalizes the centered integral comparison, threshold sign argument, exact nonnegative deficit and an almost-everywhere equality consequence under explicit integrability and ordering hypotheses. Actual build results, standard axiom dependencies and the precise boundary are in `formalization/README.md` and `formalization/verification_status.json`. The delayed equation, kernel log-concavity, the global scalar optimization and the full physical theorem are not claimed to be end-to-end Lean formalized.

## References

1. A. Santos, *The role of preparation protocols in the Mpemba effect under time-delayed Newton cooling*, arXiv:2611.12328v1 (2026). Official full text: <https://arxiv.org/pdf/2611.12328v1>. Target: Section 6.3, pp. 13–14; general history representation: Appendix, Eq. (A5), p. 16. The preprint's journal-template placeholders are not evidence of journal acceptance.
2. A. Santos, *Mpemba meets Newton: Exploring the Mpemba and Kovacs effects in the time-delayed cooling law*, Physical Review E **109**, 044149 (2024). <https://doi.org/10.1103/PhysRevE.109.044149>; audited version <https://arxiv.org/pdf/2401.03550v2>. Section III contains the synchronous protocol, reversal bounds, minimum-time identity and balance criterion.
3. A. Santos, *Time-delayed Newton's law of cooling with a finite-rate thermal quench: Impact on the Mpemba and Kovacs effects*, Physical Review E **111**, 055402 (2025). <https://doi.org/10.1103/PhysRevE.111.055402>; audited version <https://arxiv.org/pdf/2502.13665v2>.
4. A. Santos, *The Mpemba effect in the Descartes protocol: a time-delayed Newton's law of cooling approach*, Journal of Physics A **59**, 145201 (2026). <https://doi.org/10.1088/1751-8121/ae57ed>; audited version <https://arxiv.org/pdf/2602.03790v2>, especially Section II.4.3.
5. A. Saumard and J. A. Wellner, *Log-concavity and strong log-concavity: a review*, Statistics Surveys **8**, 45–114 (2014). <https://doi.org/10.1214/14-SS107>, Proposition 2.3.
6. J. Neyman and E. S. Pearson, *On the problem of the most efficient tests of statistical hypotheses*, Philosophical Transactions of the Royal Society A **231**, 289–337 (1933). <https://doi.org/10.1098/rsta.1933.0009>. Classical threshold-comparison background; the precise inequality needed here is proved directly.
7. C. Ríos-Monje, A. Patrón-Castro, C. A. Plata, B. Sánchez-Rey and A. Prados, *Optimal preparation and reachable-state constraints in the Mpemba effect*, arXiv:2607.12955v1 (2026). <https://arxiv.org/pdf/2607.12955v1>. Nonlinear granular-fluid preparation and terminal-state optimization.
8. A. Gal and O. Raz, *Precooling Strategy Allows Exponentially Faster Heating*, Physical Review Letters **124**, 060602 (2020). <https://doi.org/10.1103/PhysRevLett.124.060602>; audited preprint <https://arxiv.org/pdf/1909.06113v1>.
9. M. Peluso, R. Egger and A. Nava, *Optimal speed-up of multi-step Pontus-Mpemba protocols*, arXiv:2602.17296v2 (2026). <https://arxiv.org/pdf/2602.17296v2>. Time-dependent Lindblad dynamics and a different speed-up objective.
10. V. Malygina and K. Chudinov, *Explicit conditions for the nonoscillation of difference equations with several delays*, Electronic Journal of Qualitative Theory of Differential Equations, No. 46, 1–12 (2013). <https://www.math.u-szeged.hu/ejqtde/p2412.pdf>, p. 3, Theorem 1 (continuous-delay background cited there).
11. L. Berezansky and E. Braverman, *On Oscillation of a Differential Equation with Infinite Number of Delays*, Zeitschrift für Analysis und ihre Anwendungen **21**(3), 803–816 (2002). <https://doi.org/10.4171/ZAA/1109>, Theorem 2 and Eq. (11), pp. 807–809.
