---
title: "Sparse Audits under Adversarial Missingness"
subtitle: "Sharp information asymptotics and the statistical cost of discarding provenance"
date: "Research manuscript v1 - 24 November 2026"
---

**Public research draft.** The written proofs received a separate internal review, with strict rational certificates for 18 finite instances. The official full texts of the two related OpenReview submissions [10, 11] remain unavailable to this review, so their theorems and appendices have yet to be compared. Priority is unresolved. External peer review and Lean verification remain pending.

## Abstract

A reporting mechanism can make binary outcomes missing as a function of their values. We study a bounded missingness model in which a hidden outcome is independently recovered with probability $a$, and the observation records whether its label was reported initially or obtained by recovery. For fixed thresholds $0<p<q<1$ and a hidden probability cap $0<\rho<\min(q,1-p)$, we determine the minimum relative entropy between the two observed-law families as $a$ tends to zero. It is linear in $a$ when $q-p<\rho$, equals $(\rho/2)a\log(1/a)+O(a)$ when $q-p=\rho$, and equals its positive unaudited value plus $\rho a\log(1/a)+O(a)$ when $q-p>\rho$. The linear coefficient is expressed through the classical sharp Pinsker/Vajda curve. We also solve the corresponding information problem when the source marker is discarded. At the critical boundary and fixed false-alarm level, retaining the marker gives minimax expected sample size $\Theta(a^{-1})$, whereas the genuinely coarsened record requires $\Theta(a^{-2})$, with an exact leading constant for the latter. Complete proofs, a finite-alphabet sequential-testing appendix, and 18 rationally certified finite instances are provided.


## Introduction and reading guide

A good error rate among the labels that happened to be observed need not describe the entire population. Some outcomes are harder to verify, and the difficulty itself may depend on whether the outcome is a success or a failure. Random follow-up of initially missing outcomes is a classical response to this problem [1]. The question here is more specific: how much statistical evidence remains in the least favorable reporting mechanism when that follow-up becomes rare?

The model has five observable categories and three external parameters. This makes the problem tractable without removing the main asymmetry: the reporting mechanism may depend on the current outcome, but it cannot anticipate the fresh recovery coin. We allow different unknown mechanisms under the null and alternative. In the sequential interpretation they may change in response to the past, subject to the same conditional missingness cap.

Two different limits matter. A minimum KL value describes optimal long-run log-evidence growth in a fixed experiment. Expected stopping time at a fixed false-alarm level can behave differently when the experiment itself becomes increasingly sparse. We prove both statements and retain the overshoot term needed to distinguish them. This prevents the erroneous conclusion that a vanishing expected number of recovered labels can support a high-power test.

The candidate contribution is the **specific singular value function and its operational comparison**, not a new missing-data design or a new general testing principle. Double sampling and its identification result [1], the tight Pinsker/Vajda curve [2], convex-family adversarial testing [3,8], and growth-optimal e-values [4] are prior tools. Section 4 proves the three-regime formula; Sections 6-8 determine what is lost by removing the source marker. Appendix A states and proves the finite-dimensional sequential machinery needed for interpretation. Section 9 describes reproducible numerical certificates.

All logarithms are natural. Write

\[
d(s\|t)=s\log(s/t)+(1-s)\log((1-s)/(1-t))
\]

for binary relative entropy. Relative entropy on a finite alphabet uses the conventions \(0\log(0/v)=0\) and \(u\log(u/0)=+\infty\) for \(u>0\).

## 1. Model, scope, and the information quantity

Fix parameters

\[
0<p<q<1,\qquad 0<\rho<\min\{q,1-p\},\qquad \delta=q-p.
\tag{1}
\]

The bound in (1) is a substantive restriction of the theorem, not a claim about all possible parameter choices. It ensures that a mechanism can hide mass \(\rho\) of positive outcomes under \(q\) and mass \(\rho\) of negative outcomes under \(p\), while the relevant reported probabilities remain strictly positive.

A binary outcome \(Y\) has success probability \(\theta\). A reporting mechanism may depend on the outcome. Let

\[
h_1=\Pr(Y=1,\text{initially hidden}),\qquad
h_0=\Pr(Y=0,\text{initially hidden}).
\]

The admissible mechanisms form the compact polytope

\[
\mathcal H_\theta=
\{(h_1,h_0):0\le h_1\le\theta,
0\le h_0\le1-\theta,
h_1+h_0\le\rho\}.
\tag{2}
\]

After the initial reporting decision has been made, every hidden outcome is independently verified with probability \(a\). Verification is truthful, and the verification coin is independent of the outcome and reporting decision. The observed record retains whether a label was initially reported or obtained by verification. Thus its five categories are reported one, reported zero, verified one, verified zero, and still hidden. Their probabilities are

\[
P^a_\theta(h)=
(\theta-h_1,\ 1-\theta-h_0,\ ah_1,\ ah_0,\ (1-a)(h_1+h_0)).
\tag{3}
\]

The per-round constraint is a probability-mass bound on initial missingness. It is **not** a pathwise bound on the realized number of missing observations, and the theory does not silently replace it by one. The initial mechanism can be missing-not-at-random. In the sequential application, (2) and the independent-verification condition must hold conditionally on the past at every round.

For \(0<a<1\), define

\[
I_a=\min_{h^P\in\mathcal H_p,\ h^Q\in\mathcal H_q}
D(P^a_q(h^Q)\|P^a_p(h^P)).
\tag{4}
\]

This is a four-variable jointly convex optimization problem over compact polytopes. The objective is lower semicontinuous. A finite feasible value exists, for instance by choosing strictly positive hidden and reported masses. Consequently the minimum is attained. The null and alternative mechanisms in (4) may differ: this is a robust composite comparison, not a model with a known common selection mechanism.

### Basic checks

For every \(a>0\), the five-category law identifies its latent parameter through

\[
\theta=P^a_\theta(h)_1+a^{-1}P^a_\theta(h)_3.
\tag{5}
\]

Therefore the two compact sets of laws in (4) are disjoint. If \(I_a=0\), attainment and equality in the nonnegativity of relative entropy would give a common law, contradicting (5). Hence \(I_a>0\). The identification principle in (5) is an elementary special case of classical double sampling [1].

At complete verification, \(I_1=d(q\|p)\). The lower bound follows by forgetting provenance and recovering \(Y\). Equality is attained by hiding an independent fraction \(\rho\) of both labels under each hypothesis, namely \(h=(\rho\theta,\rho(1-\theta))\).

## 2. Exact decomposition

For a mechanism pair let \(m_P=h^P_1+h^P_0\) and \(m_Q=h^Q_1+h^Q_0\), and define their unaudited laws

\[
B_P=(p-h^P_1,1-p-h^P_0,m_P),\qquad
B_Q=(q-h^Q_1,1-q-h^Q_0,m_Q).
\]

Let \(F=D(B_Q\|B_P)\). Whenever the relevant expressions are finite and \(m_P,m_Q>0\), the chain rule gives

\[
D(P^a_q(h^Q)\|P^a_p(h^P))=F+aJ,
\tag{6}
\]

where

\[
J=m_Q\,d\left(\frac{h^Q_1}{m_Q}\Big\|\frac{h^P_1}{m_P}\right)\ge0.
\tag{7}
\]

Equivalently,

\[
J=h^Q_1\log\frac{h^Q_1}{h^P_1}
  +h^Q_0\log\frac{h^Q_0}{h^P_0}
  -m_Q\log\frac{m_Q}{m_P}.
\tag{8}
\]

Equation (6) is the ordinary relative-entropy chain rule, applied to splitting the hidden category. At boundaries it can be interpreted by the corresponding conditional-divergence convention; all uses of (7) in the limiting proofs below occur in neighborhoods with both hidden masses bounded away from zero. In particular, no invalid global continuity claim at \(m_P=m_Q=0\) is needed.

The quantity \(I_a\) is nondecreasing in \(a\) and concave as a function of \(a\): it is the infimum of the affine functions \(F+aJ\), whose slopes are nonnegative. These are structural checks, not claims of an additional new inequality.

## 3. The unaudited problem

Define

\[
I_0=\min_{h^P\in\mathcal H_p,\ h^Q\in\mathcal H_q}F.
\]

### Proposition 1: intersection and strict separation

If \(\delta\le\rho\), then \(I_0=0\). If \(\delta>\rho\), then

\[
I_0=(q-\rho)\log\frac{q-\rho}{p}
 +(1-q)\log\frac{1-q}{1-p-\rho}>0.
\tag{9}
\]

When \(\delta\ge\rho\), the unique minimizing mechanism pair is

\[
h^{P,*}=(0,\rho),\qquad h^{Q,*}=(\rho,0).
\tag{10}
\]

#### Proof when the two unaudited sets intersect

Equality \(B_Q=B_P\) requires a common hidden mass \(m\) and

\[
h^P=(x,m-x),\qquad h^Q=(x+\delta,m-x-\delta).
\tag{11}
\]

Under (1), these are feasible exactly when

\[
\delta\le m\le\rho,\qquad 0\le x\le m-\delta.
\tag{12}
\]

The component upper bounds in (2) follow automatically: for example \(x\le\rho-\delta<p\), \(m-x\le\rho<1-p\), \(x+\delta\le\rho<q\), and \(m-x-\delta\le\rho-\delta<1-q\). Thus an intersection exists precisely when \(\delta\le\rho\). At \(\delta=\rho\), (12) forces \(m=\rho,x=0\), establishing the uniqueness assertion at the boundary.

#### Proof in the strictly separated case

Put

\[
A=q-\rho,\quad B=1-q,\quad S=1-p-\rho,
\quad R_1=A/p>1,\quad R_0=B/S<1.
\]

For any feasible pair, write

\[
x=h^P_1,\quad y=h^Q_0,\quad
u=\rho-m_P,\quad v=\rho-m_Q.
\tag{13}
\]

All four variables are nonnegative, and

\[
B_P=(p-x,S+u+x,\rho-u),\qquad
B_Q=(A+v+y,B-y,\rho-v).
\tag{14}
\]

The reference point \(x=y=u=v=0\) has strictly positive three-category probabilities. Joint convexity of relative entropy, with its tangent at this reference point, gives

\[
F-I_0^{\rm ref}\ge
x(R_1-R_0)+y\log(R_1/R_0)
 +u(1-R_0)+v\log R_1,
\tag{15}
\]

where \(I_0^{\rm ref}\) is the expression in (9). For completeness, the derivatives in the alternative probabilities are \(\log(Q_i/P_i)+1\), and those in the null probabilities are \(-Q_i/P_i\); inserting (14) gives (15). Every coefficient is strictly positive. The feasible reference pair therefore achieves the global minimum, and equality forces \(x=y=u=v=0\). This proves both (9) and uniqueness. \(\square\)

## 4. Main small-verification-rate theorem

For \(0<d<1\), define the classical sharp Pinsker/Vajda function in the convention \(\operatorname{TV}(P,Q)=\tfrac12\|P-Q\|_1\):

\[
L(d)=\min_{0<t<1-d}d(t+d\|t).
\tag{16}
\]

This function is already known in information theory [2]. Some references use \(\|P-Q\|_1\), without the factor \(1/2\); their argument is then \(2d\). We use (16) to eliminate any normalization ambiguity.

### Theorem 2: three regimes

Under (1), as \(a\downarrow0\), with \(p,q,\rho\) fixed,

\[
I_a=
\begin{cases}
a\rho L(\delta/\rho)+o(a), & 0<\delta<\rho,\\[3pt]
\dfrac{\rho}{2}\,a\log(1/a)+O(a), & \delta=\rho,\\[6pt]
I_0+\rho\,a\log(1/a)+O(a), & \delta>\rho.
\end{cases}
\tag{17}
\]

The constants implicit in the remainder terms may depend on the fixed parameters. The statement is not uniform as parameters themselves approach the regime boundary or the endpoints of (1).

### 4.1. Proof below the boundary

On the set \(F=0\), parameterized by (11)-(12),

\[
J=\Phi_m(x):=(x+\delta)\log\frac{x+\delta}{x}
 +(m-x-\delta)\log\frac{m-x-\delta}{m-x}.
\tag{18}
\]

The smallest such value occurs at \(m=\rho\). To see this without assuming saturation for the full \(a>0\) problem, take any common-law pair with \(m<\rho\), and add the same positive vector \((c_1,c_0)\), \(c_1+c_0=\rho-m\), to both hidden-label vectors. Their total masses become \(\rho\); (12) ensures feasibility, for example with \(c_1=c_0=(\rho-m)/2\). The log-sum inequality, separately in each coordinate, yields

\[
\sum_j(h^Q_j+c_j)\log\frac{h^Q_j+c_j}{h^P_j+c_j}
\le\sum_jh^Q_j\log\frac{h^Q_j}{h^P_j}.
\]

Thus adding common hidden mass cannot increase (18). In fact it decreases it strictly for a finite value because the two original hidden-label vectors differ by \((\delta,-\delta)\).

It follows that

\[
C:=\min_{F=0}J
=\min_{0<x<\rho-\delta}\Phi_\rho(x)
=\rho L(\delta/\rho),
\tag{19}
\]

and \(0<C<\infty\). The minimizer is interior and unique. Indeed, \(\Phi_\rho(x)\to\infty\) as \(x\downarrow0\), its derivative tends to \(+\infty\) as \(x\uparrow\rho-\delta\), and

\[
\Phi_\rho''(x)=
\frac{\delta^2}{x^2(x+\delta)}
 +\frac{\delta^2}{(\rho-x)^2(\rho-x-\delta)}>0.
\tag{20}
\]

Using a minimizer from (19) in (6) gives \(I_a\le aC\). Let \((h_a^P,h_a^Q)\) be any minimizer of (4). Then \(0\le F_a\le I_a\le aC\), so every convergent subsequence of the mechanism pairs has a limit with \(F=0\), by compactness and lower semicontinuity of finite-alphabet relative entropy. Such a limit has \(m_P=m_Q=m\ge\delta>0\). In its neighborhood (7) is a continuous composition of the masses with lower-semicontinuous binary relative entropy, and is therefore lower semicontinuous, including a possible zero component. Consequently

\[
\liminf_{a\downarrow0}\frac{I_a}{a}
\ge\liminf_{a\downarrow0}J_a\ge C.
\]

This argument is applied to a subsequence attaining the lower limit; every further compact subsequence has the stated property. Together with the upper bound it proves the first line of (17). Notice that only the limiting common-law problem is shown to saturate the missingness bound; the proof makes no claim that both optimal mechanisms at an arbitrary positive \(a\) have hidden mass \(\rho\).

### 4.2. A local lower bound for verification information

For both remaining regimes the unique unaudited minimizer is (10). Use coordinates (13). Define

\[
t=x+y+u+v\quad\text{in the strictly separated case},
\]

and

\[
t=x+y+\max\{u,v\}\quad\text{at the boundary}.
\tag{21}
\]

In either case, \(x\le t\), \(m_P,m_Q\in[\rho-t,\rho]\), and \(h^Q_1=\rho-v-y\ge\rho-t\). Suppose \(0<t<\min\{\rho/2,1\}\). From (8), and the elementary inequality \(r\log(r/s)\ge-s/e\),

\[
J\ge(\rho-t)\log(1/t)-2/e-\log2
\ge\rho\log(1/t)-K,
\tag{22}
\]

with, for instance, \(K=3/e+\log2\). To verify the first inequality explicitly: write the first term as \(h^Q_1\log(1/x)+h^Q_1\log h^Q_1\), use \(x\le t\) and \(h^Q_1\ge\rho-t\), bound the second summand below by \(-1/e\), bound the term involving \(h^Q_0\) below by \(-1/e\), and use \(m_Q/m_P\le2\). If \(x=0\), then \(J=+\infty\) in this neighborhood and the bound remains valid. Finally \(t\log(1/t)\le1/e\).

### 4.3. Upper bounds and convergence of minimizers

For small \(s>0\), use the feasible mechanism pair

\[
h^P=(s,\rho-s),\qquad h^Q=(\rho,0).
\tag{23}
\]

At this pair,

\[
J=\rho\log(\rho/s),
\qquad
F(s)=A\log\frac A{p-s}+B\log\frac B{S+s}.
\tag{24}
\]

If \(\delta>\rho\), Taylor expansion around the positive reference probabilities gives

\[
F(s)=I_0+(R_1-R_0)s+O(s^2).
\]

Taking \(s=a\) proves

\[
I_a\le I_0+\rho a\log(1/a)+O(a).
\tag{25}
\]

At \(\delta=\rho\), \(A=p\), \(S=B=1-q\), and the linear term vanishes:

\[
F(s)=\frac12\left(\frac1p+\frac1{1-q}\right)s^2+O(s^3).
\]

Taking \(s=\sqrt a\) gives

\[
I_a\le\frac\rho2 a\log(1/a)+O(a).
\tag{26}
\]

These upper bounds, together with \(F\le F+aJ\), show that the unaudited divergence at an \(I_a\)-minimizer tends to \(I_0\). Every cluster point of minimizers minimizes \(F\), by lower semicontinuity and compactness. Proposition 1 makes this cluster point unique in both regimes; hence all minimizing pairs converge to (10). In particular, (22) applies to every minimizing pair for sufficiently small \(a\). This supplies the localization needed for the lower bounds, rather than assuming it.

### 4.4. Lower bound at the boundary

If \(\delta=\rho\), subtracting the two three-category laws in (14) gives

\[
B_Q-B_P=(x+y+v,-x-y-u,u-v).
\]

Their total variation distance is exactly

\[
\frac12\|B_Q-B_P\|_1=x+y+\max\{u,v\}=t.
\]

Pinsker's inequality therefore gives \(F\ge2t^2\). At a minimizer, (22) yields

\[
I_a\ge2t^2+a\rho\log(1/t)-aK.
\]

For arbitrary \(c,r>0\), elementary minimization shows

\[
\inf_{t>0}\{ct^r+a\rho\log(1/t)\}
=\frac{a\rho}{r}\left[1+\log\frac{cr}{a\rho}\right].
\tag{27}
\]

Apply (27) with \(c=2,r=2\), and combine with (26). This proves the second line of (17), including its \(O(a)\) remainder.

### 4.5. Lower bound beyond the boundary

If \(\delta>\rho\), let \(c>0\) be the smallest of the four strictly positive coefficients in (15). Then \(F\ge I_0+ct\), where now \(t=x+y+u+v\). Applying (22) and (27) with \(r=1\) gives

\[
I_a\ge I_0+\rho a\log(1/a)+O(a).
\]

Combine with (25) to obtain the final line of (17). \(\square\)

### Why the singular coefficients differ

At the boundary, moving the null mechanism away from complete one-sided hiding costs quadratically in the unaudited divergence. Beyond the boundary, that move costs linearly. Verification imposes a term \(a\rho\log(1/t)\). Balancing a quadratic cost against that term puts \(t\) on the \(\sqrt a\) scale and produces the factor \(1/2\); balancing a linear cost puts \(t\) on the \(a\) scale and produces the factor \(1\). The distinction between linear and square-root barrier scales has classical precedents [9]. Here the argument determines the coefficients and remainder for the specified audit experiment.

## 5. One-sided composite hypotheses

Define the observed-law families

\[
\mathcal P_{0,a}=\{P^a_\theta(h):0\le\theta\le p,\ h\in\mathcal H_\theta\},
\]

\[
\mathcal P_{1,a}=\{P^a_\theta(h):q\le\theta\le1,\ h\in\mathcal H_\theta\}.
\]

They are compact convex polytopes, since the latent parameters and hidden masses satisfy linear inequalities and the map to observed probabilities is affine.

### Proposition 3: endpoint reduction

For every \(0<a<1\),

\[
\min_{P\in\mathcal P_{0,a},Q\in\mathcal P_{1,a}}D(Q\|P)=I_a.
\tag{28}
\]

#### Proof

Take any \(\theta_0\le p<q\le\theta_1\), and set

\[
v=\frac{q-p}{\theta_1-\theta_0},\qquad u=p-v\theta_0.
\]

Then \(0<v\le1\), \(0\le u\le1-v\), and the binary stochastic channel

\[
\Pr(Y'=1\mid Y=0)=u,\qquad
\Pr(Y'=1\mid Y=1)=u+v
\]

maps success probabilities \(\theta_0,\theta_1\) to \(p,q\), respectively. To check the channel bounds, \(u\ge0\) is equivalent to \(p\theta_1\ge q\theta_0\), and \(u+v\le1\) follows from

\[
(1-p)\theta_1-(1-q)\theta_0\ge(1-p)q-(1-q)p=q-p.
\]

Apply the same channel to label values in the reported and verified categories, preserving the category provenance, and leave the still-hidden category unchanged. If the original hidden vector is \(h\), its image has

\[
h'_1=um+vh_1,\qquad h'_0=m-h'_1,
\quad m=h_1+h_0.
\]

Thus the hidden mass bound is unchanged, and the verification structure (3) is preserved. The two transformed observed laws belong to the endpoint families in (4). Data processing gives \(D(Q\|P)\ge I_a\). The reverse inequality follows because endpoint families are included in the composite families. \(\square\)

The general connection between the minimum divergence of closed convex law families and growth-optimal or adversarial sequential testing is established prior theory. Appendix A gives the precise finite-alphabet duality and stopping bounds used here, as an application of established theory [3,4,8].

## 6. What is lost by discarding provenance?

Suppose the analyst merges initially reported and verified labels, keeping only one, zero, and still hidden. The resulting observed law is

\[
\bar P^a_\theta(h)=
(\theta-(1-a)h_1,\ 1-\theta-(1-a)h_0,\ (1-a)(h_1+h_0)).
\tag{29}
\]

Let \(\bar I_a\) be the analogue of (4) using these three-category laws, and put \(r=(1-a)\rho\).

### Proposition 4: exact coarsened frontier

Under (1), for \(0\le a\le1\),

\[
\bar I_a=
\begin{cases}
0,&\delta\le r,\\[2pt]
(q-r)\log\dfrac{q-r}{p}
 +(1-q)\log\dfrac{1-q}{1-p-r},&\delta>r.
\end{cases}
\tag{30}
\]

In particular, if \(\delta<\rho\), coarsened data remain nonidentifying throughout

\[
0\le a\le1-\delta/\rho,
\tag{31}
\]

even though the provenance-retaining five-category record has \(I_a>0\) for every \(a>0\).

#### Proof

The effective hidden vector in (29) is \((1-a)h\), whose total mass is at most \(r\). Therefore its laws lie in the ordinary no-verification erasure families with cap \(r\). These effective vectors have extra component bounds, so one must not simply identify the two families without checking attainability.

When \(\delta>r\), Proposition 1 applied to the larger erasure families gives the lower bound in (30). It is attained in the actual coarsened families by the original feasible mechanisms \(h^P=(0,\rho)\), \(h^Q=(\rho,0)\), whose effective hidden vectors are \((0,r)\) and \((r,0)\). Thus the extra component restrictions do not change the minimum.

When \(\delta\le r\) and \(a<1\), set \(c=\delta/(1-a)\le\rho\). The feasible mechanisms \(h^P=(0,c)\) and \(h^Q=(c,0)\) induce the same coarsened law \((p,1-q,\delta)\). Hence the minimum is zero. Conversely, equality of coarsened laws would require \(\delta=(1-a)(h^Q_1-h^P_1)\le r\). This proves the exact intersection condition. At \(a=1\), all labels are known and the second line of (30) reduces to \(d(q\|p)\). \(\square\)

### Corollary 5: quadratic versus logarithmically enhanced information at the boundary

At \(\delta=\rho\), Taylor expansion of (30) yields

\[
\bar I_a=
\frac{\rho^2}{2}\left(\frac1p+\frac1{1-q}\right)a^2+O(a^3),
\tag{32}
\]

whereas Theorem 2 gives \(I_a=(\rho/2)a\log(1/a)+O(a)\). Thus

\[
\frac{I_a}{\bar I_a}
\sim\frac{p(1-q)}{\rho(1-\rho)}\frac{\log(1/a)}a.
\tag{33}
\]

The comparison concerns a specified loss of the reporting-versus-verification marker. It does not claim that random verification cannot identify the full distribution when that marker is retained; the latter identification result is classical.

## 7. Fixed confidence and a vanishing verification probability

This section addresses a different limit from the fixed-\(a\), small-error information-rate interpretation in Appendix A. It makes precise why the critical term \(a\log(1/a)\) does not by itself give a fixed-confidence sample requirement of order \(1/[a\log(1/a)]\). The argument was independently checked against the sequential appendix.

### 7.1. Sequential model and the quantity being bounded

Let \(\mathcal F_{t-1}\) contain the entire observed past and all previous randomization used by the procedure. At raw observation \(t\), the conditional joint law of \(Y_t\) and its initial hiding indicator has success probability \(\theta_t\) and hidden masses in \(\mathcal H_{\theta_t}\). Once hiding has been decided, its verification coin is conditionally independent of \(Y_t\) and that decision and has probability \(a\). The current coin is unavailable when the reporting decision is made. The five-category record is then observed.

The null class consists of all such processes with \(\theta_t\le p\) almost surely at every round. The alternative class has \(\theta_t\ge q\) almost surely at every round. Thus both the outcome probability and the outcome-dependent reporting mechanism may adapt to the past, provided these conditional bounds hold. Neither class is being defined by a marginal-mean bound alone.

A procedure raises an alarm at a stopping time \(\tau\in\{0,1,2,\ldots\}\cup\{\infty\}\). It has level \(\alpha\) if \(\Pr_P(\tau<\infty)\le\alpha\) for every null process, and power one if \(\Pr_Q(\tau<\infty)=1\) for every alternative process. No finite stopping under the null is required. Define the minimax expected number of raw observations by

\[
T_a(\alpha)=\inf_{\tau}\sup_Q\mathbb E_Q\tau,
\tag{34}
\]

where the infimum ranges over these level-\(\alpha\), power-one alarm procedures, and the supremum ranges over the stated conditional alternative class. Independent randomization by the procedure is allowed. Here \(a\) is fixed during a stream; it is not an audit probability selected by the procedure.

### Theorem 6: fixed-confidence raw-sample complexity

Assume (1), \(\delta\le\rho\), and \(\alpha\in(0,1)\). For every \(0<a<1\),

\[
\frac{1-\alpha}{a\rho}
\le T_a(\alpha)
\le\frac{\log(1/\alpha)+\log(q/p)}{a\,d(q\|p)}.
\tag{35}
\]

Consequently, for fixed \(p,q,\rho,\alpha\),

\[
T_a(\alpha)=\Theta(a^{-1})\qquad(a\downarrow0),
\tag{36}
\]

including at the critical boundary \(\delta=\rho\).

#### Lower bound: a common law before the first verified label

Choose \(x\in[0,\rho-\delta]\), and use the feasible iid mechanism pair

\[
h^P=(x,\rho-x),\qquad
h^Q=(x+\delta,\rho-x-\delta).
\tag{37}
\]

It has hidden mass \(\rho\) under both hypotheses and the same unaudited law. At the critical boundary this is necessarily \(x=0\). The probabilities of the three categories that do not reveal a verified hidden value are exactly the same under both laws:

\[
p-x,\qquad 1-p-\rho+x,\qquad (1-a)\rho.
\tag{38}
\]

Therefore any finite observation history containing no verified hidden value has the same probability under the two laws. The assertion also holds when independent procedural randomization is included: condition on the random seed, or integrate identical randomization kernels along the same histories.

Let \(N_t\) count verified hidden labels through time \(t\), and let

\[
A=\{\tau<\infty,\ N_\tau=0\}.
\]

For each \(n\), the event \(\{\tau=n,N_n=0\}\) is determined by a length-\(n\) history of the form just described. These disjoint events have equal probabilities under the two laws, including \(n=0\) if the procedure can alarm immediately. Hence

\[
\Pr_Q(A)=\Pr_P(A)\le\Pr_P(\tau<\infty)\le\alpha.
\]

Power one gives

\[
\mathbb E_QN_\tau\ge\Pr_Q(N_\tau\ge1)\ge1-\alpha.
\tag{39}
\]

Under the iid alternative in (37), each raw observation contains a verified hidden label with conditional probability \(a\rho\). Since \(\{\tau\ge t\}\in\mathcal F_{t-1}\), predictable summation and Tonelli's theorem give, also for infinite expectations,

\[
\mathbb E_QN_\tau
=\sum_{t\ge1}\mathbb E_Q\!\left[\mathbf1_{\{\tau\ge t\}}
 \mathbf1_{\{\text{verified hidden label at }t\}}\right]
=a\rho\sum_{t\ge1}\Pr_Q(\tau\ge t)
=a\rho\mathbb E_Q\tau.
\tag{40}
\]

Equations (39)-(40) prove the lower bound for this feasible iid alternative, and therefore for the worst case over the larger conditional class. An infinite expectation already satisfies the bound.

#### Upper bound: equalize the probability of using each label

Use every verified hidden label. For each initially reported label, independently retain it for testing with probability \(a\), using a fresh coin; discard the other reported labels from the test statistic. The raw observations themselves remain counted. If \(R_t\) denotes whether a label is retained by this rule, then, conditional on the past, the current outcome, and its initial hiding decision,

\[
\Pr(R_t=1\mid\mathcal F_{t-1},Y_t,\text{initial hiding decision})=a.
\tag{41}
\]

For hidden labels, retention occurs through the independent verification coin; for reported labels, it occurs through the fresh thinning coin. Thus \(\Pr(R_t=1,Y_t=1\mid\mathcal F_{t-1})=a\theta_t\) and \(\Pr(R_t=1,Y_t=0\mid\mathcal F_{t-1})=a(1-\theta_t)\). No claim that the retained stream is iid is needed or made when \(\theta_t\) varies adaptively.

Set

\[
L_t=
\begin{cases}
q/p,&R_t=1,Y_t=1,\\
(1-q)/(1-p),&R_t=1,Y_t=0,\\
1,&R_t=0.
\end{cases}
\tag{42}
\]

Under any conditional null law,

\[
\mathbb E[L_t\mid\mathcal F_{t-1}]
=1-a+a\left[\theta_t\frac qp+(1-\theta_t)\frac{1-q}{1-p}\right]\le1.
\tag{43}
\]

The inequality follows because the bracket is increasing in \(\theta_t\) and equals one at \(\theta_t=p\). Therefore the product of (42) is a nonnegative supermartingale starting at one. Put \(b=\log(1/\alpha)\), \(S_n=\sum_{t=1}^n\log L_t\), and stop at \(\tau=\inf\{n:S_n\ge b\}\). Ville's inequality gives level \(\alpha\).

Under every conditional alternative law,

\[
\mathbb E[\log L_t\mid\mathcal F_{t-1}]
=a\left[\theta_t\log\frac qp+(1-\theta_t)\log\frac{1-q}{1-p}\right]
\ge a\,d(q\|p)>0.
\tag{44}
\]

Here the inequality, rather than equality, is required for the composite alternative; equality holds at \(\theta_t=q\). The positive log increment is at most \(\log(q/p)\). For every deterministic \(n\), predictable summation gives

\[
a\,d(q\|p)\,\mathbb E_Q(\tau\wedge n)
\le\mathbb E_QS_{\tau\wedge n}
\le b+\log(q/p).
\tag{45}
\]

The last inequality is pathwise: before crossing, the sum is below \(b\), and a crossing overshoots by at most the largest positive increment. The increments at finite \(n\) are bounded, so no unverified optional-stopping integrability assumption is involved. Letting \(n\to\infty\) and using monotone convergence proves the upper bound in (35), uniformly over the conditional alternative class. Its finiteness also proves power one. \(\square\)

### 7.2. Interpretation and the order of limits

At the critical boundary, Theorem 2 describes a minimax KL information rate of order \(a\log(1/a)\). Theorem 6 describes a minimax expected stopping time of order \(1/a\) when the desired error probability is held fixed. The statements are consistent. A rare verified label can produce a large amount of log evidence, so the largest log increment and the overshoot of a fixed evidence threshold need not remain bounded as \(a\downarrow0\) for a growth-optimal rule. The first-verification lower bound (39)-(40) supplies a direct reason why expected verified-label counts cannot vanish in the overlapping regime.

In particular, the provenance comparison (32)-(33) is a comparison of **KL information rates**. Its logarithmic ratio is not a ratio of fixed-\(\alpha\) expected sample sizes. The next section gives a separate stopping-time analysis for the genuinely coarsened experiment. Statements about \(\log(1/\alpha)/I_a\) should specify the order of limits and retain their overshoot bound. No additional joint-limit crossover claim is made here.

The thinning construction and the supermartingale argument use established statistical tools. The role of (35) is to delimit the operational meaning of the singular information-rate theorem in this explicitly stated observation model.

## 8. Fixed-confidence cost of a genuinely coarsened record

The comparison in this section concerns a downstream analyst who sees **only** the final three-category observation in (29), together with its own independent procedural randomization. The analyst receives no initial missingness flag, verification indicator, query log, earlier snapshot, timing information, or other side information from which reported-versus-verified provenance could be recovered. The audit probability \(a\), missingness bound \(\rho\), and hypothesis thresholds \(p,q\) are known. Merely merging two columns in a data table does not produce this experiment if the analyst still has the original audit log.

Use the same conditional outcome and hiding constraints as in Section 7, but restrict alarm stopping times to this three-category observation filtration. Define \(\bar T_a(\alpha)\) as in (34) with this restriction. The iid least-favorable mechanisms used below belong to the model whether the conditional constraints are stated relative to the full internal process history or only the analyst's observed history. The upper bound uses only the conditional constraints relative to the analyst's history, which also follow by conditioning from the stronger full-history constraints.

### Theorem 7: the operational provenance separation at criticality

Suppose (1) holds and \(q-p=\rho\). Fix \(\alpha\in(0,1)\), put \(b=\log(1/\alpha)\), and let \(0<a<1\). Then

\[
\frac{b}{\bar I_a}
\le\bar T_a(\alpha)
\le\frac{b+\log(1+a\rho/p)}{\bar I_a},
\tag{46}
\]

where \(\bar I_a\) is given exactly by (30). Consequently, at fixed \(p,q,\rho,\alpha\),

\[
\bar T_a(\alpha)
\sim\frac{b}{\bar I_a}
\sim\frac{2p(1-q)\,b}{\rho^2(1-\rho)}\,a^{-2}.
\tag{47}
\]

Together with Theorem 6, this gives

\[
T_a(\alpha)=\Theta(a^{-1}),\qquad
\bar T_a(\alpha)=\Theta(a^{-2})
\qquad(q-p=\rho).
\tag{48}
\]

In particular, the ratio of the two minimax raw-sample costs is \(\Theta(1/a)\), rather than the information-rate ratio \(\Theta(\log(1/a)/a)\) from (33).

#### Upper bound: an explicit valid three-category likelihood factor

The construction works whenever \(\delta>r=(1-a)\rho\), which holds at criticality for every \(a>0\). Define

\[
e_1=\frac{q-r}{p}>1,\qquad
e_0=\frac{1-q}{1-p-r}<1,\qquad
e_{?}=1.
\tag{49}
\]

At a round with latent success probability \(\theta\), let \(g_i=(1-a)h_i\). Then \(g_1+g_0\le r\), and the conditional law of the coarsened observation is \((\theta-g_1,1-\theta-g_0,g_1+g_0)\).

For every conditional null law, \(\theta\le p\),

\[
\begin{aligned}
\mathbb E[e_Z\mid\text{past}]
&=\theta e_1+(1-\theta)e_0+g_1(1-e_1)+g_0(1-e_0)\\
&\le\theta e_1+(1-\theta-r)e_0+r\\
&\le p e_1+(1-p-r)e_0+r=1.
\end{aligned}
\tag{50}
\]

For every conditional alternative law, \(\theta\ge q\),

\[
\begin{aligned}
\mathbb E[\log e_Z\mid\text{past}]
&=\theta\log e_1+(1-\theta)\log e_0
 -g_1\log e_1-g_0\log e_0\\
&\ge(\theta-r)\log e_1+(1-\theta)\log e_0\\
&\ge(q-r)\log e_1+(1-q)\log e_0
=\bar I_a.
\end{aligned}
\tag{51}
\]

The inequalities use only \(e_1>1>e_0\), the hidden-mass bound, and the one-sided bounds on \(\theta\). Thus (49) is valid without knowing the particular outcome-dependent reporting mechanism.

Stop when the sum of the log factors in (49) first reaches \(b\). Equation (50) and Ville's inequality give level \(\alpha\). Equation (51) and the stopped-drift argument in (45) give expected raw-sample size at most \((b+\log e_1)/\bar I_a\), uniformly over the adaptive alternative class, and ensure power one. At criticality, \(q-r=p+a\rho\), so the maximum log increment is exactly

\[
\log e_1=\log(1+a\rho/p),
\tag{52}
\]

which tends to zero as \(a\downarrow0\). This proves the upper bound in (46).

#### Lower bound: the least-favorable iid pair

The mechanisms \(h^P=(0,\rho)\) and \(h^Q=(\rho,0)\) give the three-category iid laws

\[
P^*=(p,1-p-r,r),\qquad
Q^*=(q-r,1-q,r),
\tag{53}
\]

with \(D(Q^*\|P^*)=\bar I_a\). For \(0<a<1\) these laws have strictly positive coordinates, and their likelihood-ratio vector is (49).

Take any level-\(\alpha\), power-one coarsened alarm procedure, including a randomized one. If \(\mathbb E_{Q^*}\tau=\infty\), the lower bound is immediate. Otherwise, let \(\tau_n=\tau\wedge n\). The relative entropy between the two stopped experiments, including the common procedural randomization and whether the alarm has occurred, is

\[
D(Q^*_{\rm stopped,n}\|P^*_{\rm stopped,n})
=\bar I_a\,\mathbb E_{Q^*}\tau_n.
\tag{54}
\]

To verify (54), the likelihood ratio of a stopped history is the product of the per-observation ratios through \(\tau_n\); identical procedural randomization kernels cancel. The expected log product under \(Q^*\) is computed by summing conditional expectations with the predictable indicators \(\mathbf1_{\{\tau\ge t\}}\). At the bounded time \(n\), all log ratios are bounded and the identity has no integrability difficulty.

Let \(u_n=\Pr_{Q^*}(\tau\le n)\) and \(v_n=\Pr_{P^*}(\tau\le n)\). Data processing from the stopped history to its alarm indicator gives

\[
\bar I_a\,\mathbb E_{Q^*}\tau_n\ge d(u_n\|v_n).
\]

Power one gives \(u_n\to1\), while level \(\alpha\) gives \(v_n\le\alpha\). For all sufficiently large \(n\), \(u_n>\alpha\), so \(d(u_n\|v_n)\ge d(u_n\|\alpha)\to b\). Monotone convergence therefore gives \(\mathbb E_{Q^*}\tau\ge b/\bar I_a\). Taking the worst case over alternatives and then the infimum over procedures proves the lower bound in (46).

Finally, \(\log(1+a\rho/p)=o(1)\) and \(b>0\) is fixed, so (46) implies \(\bar T_a(\alpha)\bar I_a/b\to1\). Substituting the expansion (32), and using \(p+(1-q)=1-\rho\), proves (47). Equation (48) follows from Theorem 6. \(\square\)

### Scope of the operational conclusion

The gain in (48) comes from preserving the sampling-status information in an explicitly specified sequential observation experiment. It does not compare arbitrary practical audit systems, does not allow noisy or adversary-visible verification coins, and does not assert that the thinning rule achieves the best constant for the full five-category experiment. It establishes its \(1/a\) order with matching lower and upper bounds. For the three-category experiment, (46) additionally establishes the exact leading constant at criticality and fixed confidence.


## 9. Reproducible finite-instance certificates

The analytic proof is independent of numerical optimization. We also solve 18 finite instances with $p=0.2$, $q=0.5$, $\rho\in\{0.2,0.3,0.4\}$, and $a\in\{10^{-1},10^{-2},\ldots,10^{-6}\}$. A high-precision root finder proposes feasible mechanisms and five log scores. A separate program then establishes a primal upper bound and a dual lower bound using rational arithmetic.

For a proposed rational log-score vector $z$, the verifier encloses every $\exp(z_i)$ by a rational interval. It evaluates the upper expected factor at every vertex of the full composite null polytope, and divides by a rational upper normalizer. This yields an actually valid positive factor $e_i=\exp(z_i)/c$. The minimum alternative expected log factor is checked at every alternative vertex. A feasible rational mechanism pair supplies the KL upper bound. Rational Taylor/atanh-series remainder bounds and outward rounding control all exponential and logarithmic evaluations. Exported results include the exact rational endpoints.

All 18 certificates passed. The largest certified primal-dual gap is below $4.33\times10^{-65}$. This is a finite collection of certificates, not a machine proof of the asymptotic theorem. The candidate generator explores two active-set patterns on this documented grid; it is not advertised as a complete general-purpose solver. Acceptance is determined by the certificate checker.

*Figure: Three information regimes. The dots come from certified finite instances; dashed lines are the limits in Theorem 2. The parameters are fixed while the audit probability decreases.*

There are two important implementation checks. First, at some positive audit probabilities the least favorable null does not use its entire hidden budget. For $(p,q,\rho,a)=(0.2,0.5,0.4,0.1)$ its numerical hidden mass is approximately $0.39468765$, strictly below $0.4$. Second, some alternative hidden masses become exponentially small. Setting a corresponding betting factor to zero invalidates its claimed worst-case log growth. The certificate instead defines positive factors through their log scores, even when their numerical exponent would underflow.

The critical fixed-confidence comparison is illustrated below. These are analytic bounds, not simulated stopping times or measurements from a deployed system. For $p=0.2$, $q=0.5$, $\rho=0.3$, $\alpha=0.05$, and $a=0.01$, the minimax expected raw-sample count with provenance lies between approximately $316.7$ and $1753.2$. The coarsened minimax value lies between approximately $95550.0$ and $96024.9$. The exact formulas are (35) and (46); displayed decimals are rounded summaries.

*Figure: At criticality, retaining provenance gives a minimax cost of order $a^{-1}$; discarding it gives order $a^{-2}$. The teal band shows the proved full-record lower and upper bounds, while the orange lines show the coarsened bounds.*

Run `python code/verify_certificates.py` to check the stored certificates using the Python standard library. Candidate regeneration additionally uses `mpmath`; figure regeneration uses `numpy` and `matplotlib`. The detailed command sequence is in `REPRODUCTION.md`.

## 10. Related work, novelty boundary, and limitations

The observation design is a binary specialization of double sampling for informatively missing data [1]. Independent recovery and the source indicator already appear there. Prediction-powered e-values [5] and risk control under selective observation [7] provide related ways to use randomized label collection; their collection and ignorability assumptions differ from the unknown outcome-dependent first-stage mechanism studied here. Design-based delayed-outcome inference [6] targets calendar-time realized rewards rather than the latent binary parameter used here.

The general minimum-KL and sequential-testing tools have prior sources [3,4,8]. The subcritical coefficient uses an established entropy-versus-total-variation function [2]. The linear/square-root distinction in boundary perturbations is also familiar from log-barrier analysis [9]. The manuscript therefore claims only a **candidate model-specific theorem**: the exact three-regime information expansion, its provenance-discarding counterpart, and the fixed-confidence order separation with the stated constants and assumptions.

Two recent submissions are close enough to require direct full-text comparison [10,11]. During this audit their primary pages and PDFs returned verification or access failures. Their searchable abstracts are insufficient to rule out overlap, especially in an appendix or under an equivalent parametrization. They remain explicit publication blockers. The full search ledger, including versions, sections actually inspected, inaccessible items, and comparisons with additional sources, is in `NOVELTY_AUDIT.md` and `SOURCES.json`.

The probability cap is a per-round conditional constraint, not a realized finite-cohort count. Recovery labels are correct; the current random audit decision is not visible to the reporter beforehand. The small-$a$ statements hold at fixed interior parameters and are not uniform across the contact boundary. We do not treat noisy recovery, a shared known reporting mechanism, constrained total audit counts, covariate-dependent costs, or arbitrary distribution shifts. The full-record stopping theorem proves the optimal order but does not identify its exact leading constant. The coarsened comparison applies only when no side record recovers the discarded source information.

No full Lean formalization is supplied. The central proof uses finite-dimensional relative entropy, compactness, convex duality and stopped probability experiments. A small unrelated algebraic Lean lemma would not verify those steps. The complete written proof, independent audit, and finite-instance rational certificates are supplied with their distinct scopes stated explicitly.

## Appendix A. Sequential testing for the finite convex families

The following general principles are included for completeness and attribution [3,4,8]. They are not claimed as new. The families used here are the one-sided composite families from Section 5.

### A.1. Finite-alphabet theorem

Let \(\mathcal P,\mathcal Q\) be nonempty compact convex sets of probability vectors on a finite alphabet of size \(d\). Assume each set contains a full-support distribution. Define

\[
I=\min_{P\in\mathcal P,Q\in\mathcal Q}D(Q\|P).
\]

Then

\[
\boxed{
I=\max_{e>0:\ \sup_{P\in\mathcal P}P\cdot e\le1}
\inf_{Q\in\mathcal Q}Q\cdot\log e.}
\tag{S1}
\]

There is a maximizing vector \(e^*\) with all coordinates positive and finite, and it satisfies \(\sup_P P\cdot e^*=1\).

**Proof of the equality.** For \(e\in(0,\infty)^d\), define

\[
\mathcal L(e,P,Q)=Q\cdot\log e-P\cdot e+1.
\]

It is concave and continuous in \(e\), and affine and continuous in \((P,Q)\). Sion's minimax theorem applies with the compact convex set \(\mathcal P\times\mathcal Q\), giving

\[
\sup_{e>0}\inf_{P,Q}\mathcal L
=\inf_{P,Q}\sup_{e>0}\mathcal L
=\inf_{P,Q}D(Q\|P).
\]

The last equality is the coordinatewise variational representation of KL, with the usual extended-real conventions. To convert the left side to valid e-factors, fix a positive shape \(f\), write \(e=tf\), and put \(B=\sup_P P\cdot f>0\). Then

\[
\inf_{P,Q}\mathcal L(tf,P,Q)
=\log t+\inf_Q Q\cdot\log f-tB+1.
\]

Optimizing the scale gives \(t=1/B\) and value

\[
\inf_Q Q\cdot\log(f/B),
\]

with \(f/B\) a valid normalized e-factor. Conversely, a valid positive e-factor with \(\sup_P P\cdot e<1\) can be scaled up to improve every expected logarithm. This proves (S1).

**Proof of positive bounded attainment.** Pick full-support \(\bar P\in\mathcal P\) and \(\bar Q\in\mathcal Q\). Every feasible nonnegative vector satisfies

\[
0\le e_i\le1/\bar P_i.
\]

The feasible set is compact. Its objective \(\inf_Q Q\cdot\log e\) is upper semicontinuous with \(\log0=-\infty\). The vector \(e=1\) has value zero. If any coordinate tends to zero, \(\bar Q\cdot\log e\to-\infty\), since every other coordinate is uniformly bounded above. A maximizing vector consequently has strictly positive coordinates. This proves attainment and boundedness without assuming that every member of the uncertainty sets has full support.

For the five-category audit model, the assumptions hold for every fixed \(0<a<1\): choose small positive hidden masses under both parameters, leaving both reported categories positive. The endpoints can be handled on their reduced alphabets. For \(a>0\), the two sets are disjoint because the parameter is recovered from the observation law by

\[
\theta=P(\text{reported 1})+P(\text{recovered 1})/a.
\]

Compactness and strict positivity of KL away from equality imply \(I=I_a>0\).

### A.2. Anytime validity under adaptive reporting

Fix \(a\in(0,1)\) and a maximizing \(e^*\). Let

\[
E_n=\prod_{t=1}^n e^*(O_t),\qquad S_n=\log E_n.
\]

If the conditional observation law given the past lies in \(\mathcal P\) at every time, then \(E_n\) is a nonnegative supermartingale starting at one. Consequently, for \(b=\log(1/\alpha)>0\),

\[
\Pr_0\{\exists n:E_n\ge e^b\}\le e^{-b}=\alpha.
\tag{S2}
\]

This permits the reporter to adapt to past observations, subject to the same conditional set constraint. The fresh audit coin must remain independent after each hiding decision.

### A.3. Expected stopping time and power under adaptive alternatives

Let

\[
\tau=\inf\{n\ge1:S_n\ge b\},\qquad
M=\max_i e_i^*.
\]

If the conditional law at each time lies in \(\mathcal Q\), (S1) implies

\[
\mathbb E[\log e^*(O_t)\mid\mathcal F_{t-1}]\ge I.
\]

All increments are bounded because \(e^*\) is positive and finite. For every integer \(n\), predictable stopping gives

\[
I\mathbb E(\tau\wedge n)
\le\mathbb E S_{\tau\wedge n}\le b+\log M.
\]

The pathwise upper bound holds because before crossing the log-evidence is less than \(b\), and the crossing increment is at most \(\log M\). Monotone convergence yields

\[
\boxed{\mathbb E\tau\le\frac{b+\log M}{I},\qquad \Pr(\tau<\infty)=1.}
\tag{S3}
\]

This proof establishes integrability rather than assuming it in an optional-stopping step.

### A.4. Information lower bound for every power-one procedure

Take any pair \((P^*,Q^*)\) attaining the minimum KL. Consider iid observations from that pair, with the same fixed audit probability. Let any possibly randomized sequential rejection procedure have type-I rejection probability at most \(\alpha\) under every null and reject eventually with probability one under every alternative. Let \(\tau\) be its rejection time under \(Q^*\).

If \(\mathbb E_{Q^*}\tau=\infty\), the desired lower bound is immediate. Otherwise, the stopped-transcript likelihood identity and Wald's identity on this finite alphabet give

\[
D(\mathsf Q^{\rm stop}\|\mathsf P^{\rm stop})
=\mathbb E_{Q^*}\!\left[\sum_{t=1}^{\tau}\log\frac{Q^*(O_t)}{P^*(O_t)}\right]
=I\mathbb E_{Q^*}\tau.
\]

The transcript includes a no-rejection outcome under the null when needed. Independent algorithmic randomization has the same law under both hypotheses and contributes no relative entropy. Data processing to the event of eventual rejection gives

\[
D(\mathsf Q^{\rm stop}\|\mathsf P^{\rm stop})
\ge\operatorname{kl}(1\|\mathsf P^{\rm stop}\{\text{reject}\})
\ge\log(1/\alpha)=b.
\]

Therefore

\[
\boxed{\mathbb E_{Q^*}\tau\ge b/I.}
\tag{S4}
\]

This is a lower bound for tests observing the specified fixed-\(a\) experiment. It does not cover a procedure allowed to change the audit experiment without charging for those changes.

### A.5. The order of limits must not be interchanged

For each fixed \(a>0\), (S3) and (S4) show first-order optimality as \(\alpha\downarrow0\), since \(b\to\infty\) while \(M\) remains fixed. A joint limit needs at least

\[
\log M_a=o(b)
\]

to infer that the minimax worst-case expected stopping time is asymptotic to \(b/I_a\) from these bounds. This equivalence also holds for the displayed growth-optimal procedure under a least-favorable i.i.d. alternative; it is not an equality for every easier alternative.

The formula \(b/I_a\) must not be interpreted as a uniform fixed-confidence stopping-time approximation as \(a\downarrow0\). In particular, combining the critical \(a\log(1/a)\) law with such an invalid approximation can falsely suggest that high-power discrimination requires a vanishing expected number of audits. Rare recovered events have large likelihood increments; the overshoot term \(\log M_a\) is precisely the term that cannot be discarded in that regime. The theorem is about information per observation and fixed-experiment small-error efficiency, not a zero-audit high-power certificate.



## References

[1] A. W. Levis, R. Mukherjee, R. Wang, H. Fischer and S. Haneuse. *Double sampling for informatively missing data in electronic health record-based comparative effectiveness research*. Statistics in Medicine 43 (2024), 6086-6098. [doi:10.1002/sim.10298](https://doi.org/10.1002/sim.10298). [Preprint v2](https://arxiv.org/abs/2204.02432v2).

[2] A. A. Fedotov, P. Harremoes and F. Topsoe. *Refinements of Pinsker's inequality*. IEEE Transactions on Information Theory 49 (2003), 1491-1498. [doi:10.1109/TIT.2003.811927](https://doi.org/10.1109/TIT.2003.811927). The variational definition used here is explicit; no inaccessible parametrization theorem is assumed.

[3] F. G. S. L. Brandao, A. W. Harrow, J. R. Lee and Y. Peres. *Adversarial hypothesis testing and a quantum Stein's lemma for restricted measurements*. IEEE Transactions on Information Theory 66 (2020), 5037-5054; early version ITCS 2014. [Author manuscript](https://homes.cs.washington.edu/~jrl/papers/pdf/bhlp.pdf).

[4] A. Saha and A. Ramdas. *Huber-robust likelihood ratio tests for composite nulls and alternatives*. \
[arXiv:2408.14015v8](https://arxiv.org/abs/2408.14015v8), 24 December 2025. Theorem 2.1 and Sections 2-4.

[5] D. Csillag, C. J. Struchiner and G. T. Goedert. *Prediction-Powered E-Values*. ICML 2025, PMLR 267, 11493-11514. [Proceedings](https://proceedings.mlr.press/v267/csillag25a.html).

[6] M. Lindon and N. Kallus. *Design-Based Anytime-Valid Inference for Randomized Experiments with Delayed Outcomes and Staggered Entry*. [arXiv:2603.25971v2](https://arxiv.org/abs/2603.25971v2), 29 May 2026.

[7] S. Bai, Z. Fang and J. Chen. *Risk-Controlling Predictive Sets for Time-Series Events Under Selective Observation with Finite-Sample Guarantees*. Axioms 15 (2026), 706. [DOI](https://doi.org/10.3390/axioms15090706).

[8] E. Modak, M. Bakshi, B. K. Dey and V. M. Prabhakaran. *Sequential Adversarial Hypothesis Testing*. [arXiv:2511.10181v1](https://arxiv.org/abs/2511.10181v1), 13 November 2025. Its common-support assumptions are distinguished from the finite-convex proof in Appendix A.

[9] S. J. Wright and D. Orban. *Properties of the log-barrier function on degenerate nonlinear programs*. Mathematics of Operations Research 27 (2002), 585-613. [doi:10.1287/moor.27.3.585.312](https://doi.org/10.1287/moor.27.3.585.312). [Public manuscript](https://optimization-online.org/wp-content/uploads/2001/06/339.pdf).

[10] *How Many More Labels Are Needed? Minimax Evaluation under Selective Labels*. ICLR 2027 submission. [OpenReview GbjWLX2uUE](https://openreview.net/forum?id=GbjWLX2uUE). Primary full text not obtained during this audit; priority comparison unresolved.

[11] *Audited Partial Identification for Off-Policy Evaluation under Nonignorable Feedback*. ICLR 2027 submission. [OpenReview MXy9kwESeo](https://openreview.net/forum?id=MXy9kwESeo). Primary full text not obtained during this audit; priority comparison unresolved.
