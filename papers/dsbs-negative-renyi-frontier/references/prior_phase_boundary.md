# A globally evaluable negative-order DSBS phase boundary

This note concerns Yu's scalar upper-bound functional. Their operational interpretation depends explicitly on (OP) below, which must be proved separately for arbitrary block codes. No numerical experiment is used as a proof.

## 1. Inputs, notation, and dependency

All logarithms are base two, except for the explicitly written constant \(\ln 2\). Set

\[
 h(x)=-x\log_2x-(1-x)\log_2(1-x),\qquad 0\log_2 0=0.
\]

Fix \(e\in(0,1/2)\). Write

\[
 s=\sqrt{1-2e},\quad a=\frac{1-s}{2},\quad
 w=C_W(e)=1+h(e)-2h(a),\quad k=1-e,
\]

and let \(h_-^{-1}:[0,1]\to[0,1/2]\) be the increasing inverse of binary entropy. For \(0\le r\le e\), define

\[
 b(r)=\frac{(1-\sqrt{1-2r})^2}{4(1-r)},\qquad
 F(r,q)=2h((1-r)q+r/2)-(1-r)h(q)-r-h(r).
\]

**Attributed inputs.** Yu, arXiv:2407.06132v1, Proposition 1 gives the relaxed-Wyner formula

\[
 C(r,t)=
 \begin{cases}
 (1-r)(1-h(q)),&0\le t\lt 1-h(r),\quad
 F(r,q)=t,\quad q\in[b(r),1/2),\\
 0,&t\ge1-h(r).
 \end{cases}
\]

At \(r=0\), this is \(C(0,t)=\max\{0,1-t\}\). Proposition 2 gives, for \(\beta\in(0,\infty]\),

\[
 \Gamma_{-\beta}^{\mathrm{UB}}(e)
 =\max_{0\le r\le e}C\bigl(r,c_\beta D(r\|e)\bigr),
 \qquad c_\beta=1+1/\beta,\quad 1/\infty=0,
\tag{1}
\]

where

\[
 D(r\|e)=r\log_2\frac r e+(1-r)\log_2\frac{1-r}{1-e}.
\]

The maximum formulation will also follow from the monotonicity and continuity facts below. Neither the relaxed-Wyner formula nor the DSBS scalar reduction is claimed as new.

The operational dependency is

\[
 \widetilde T_{-\beta}(\pi_e)=T_{-\beta}(\pi_e)
 =\Gamma_{-\beta}^{\mathrm{UB}}(e)
 \quad\text{for all }e\in(0,1/2),\ \beta\in(0,\infty].
\tag{OP}
\]

Here (OP) must cover the unrestricted local block kernels of the synthesis model; it cannot be inferred from (1). Every operational conclusion in this file is conditional on that separate theorem.

## 2. Explicit one-dimensional boundary function

Define, for \(0\le r\le e\),

\[
 q_e(r)=h_-^{-1}\!\left(1-\frac{w}{1-r}\right),\qquad
 m_e(r)=(1-r)q_e(r)+r/2,
\tag{2}
\]

\[
 \tau_e(r)=F(r,q_e(r))
 =w-1+2h(m_e(r))-h(r).
\tag{3}
\]

The second expression in (3) follows because \((1-r)h(q_e(r))=1-r-w\). It is useful for evaluation and differentiation. Put

\[
 K_e(r)=\frac{\tau_e(r)}{D(r\|e)}\qquad(0\le r\lt e).
\tag{4}
\]

Its continuous endpoint values are explicit:

\[
 K_e(0)=\frac{1-w}{\log_2(1/(1-e))},
\tag{5}
\]

\[
 K_e(e)=\frac{1-e}{e}
 \left(1-\sqrt{1-2e}\,
 \frac{\log_2((1-e)/e)}{\log_2((1-a)/a)}\right)^2.
\tag{6}
\]

Finally define

\[
 K_*(e)=\max_{r\in[0,e]}K_e(r).
\tag{7}
\]

The following statements will be proved below.

**Phase theorem.** The functions in (2) are well-defined. The extension (4)–(6) is positive and continuous on \([0,e]\), so (7) is finite and attained. For every \(\beta\in(0,\infty]\),

\[
 \Gamma_{-\beta}^{\mathrm{UB}}(e)>w
 \quad\Longleftrightarrow\quad c_\beta\lt K_*(e),
\tag{8}
\]

\[
 \Gamma_{-\beta}^{\mathrm{UB}}(e)=w
 \quad\Longleftrightarrow\quad c_\beta\ge K_*(e).
\tag{9}
\]

Consequently, under (OP), these are exactly the operational strict-gap and equality regions, for both normalized and unnormalized negative-order common information.

For an equivalent order-threshold convention, let

\[
 \beta_c(e)=
 \begin{cases}
 (K_*(e)-1)^{-1},&K_*(e)>1,\\
 +\infty,&K_*(e)\le1.
 \end{cases}
\tag{10}
\]

Then the strict region is \(\beta>\beta_c(e)\), and equality holds for \(\beta\le\beta_c(e)\), with the usual extended order on \((0,\infty]\). In particular:

- If \(K_*(e)>1\), the finite critical order itself belongs to the equality region and \(\beta=\infty\) belongs to the strict region.
- If \(K_*(e)\le1\), every order, including \(\beta=\infty\), belongs to the equality region.

No monotonicity of \(K_*(e)\) in \(e\), no single critical crossover probability, and no location of its maximizing \(r\) are assumed.

## 3. Domains and strict monotonicity

For a generic \(r\in(0,1/2)\), put

\[
 s_r=\sqrt{1-2r},\quad a_r=(1-s_r)/2,\quad
 L_x=h'(x)=\log_2((1-x)/x).
\]

The entropy identity

\[
 2h(a_r)=h(r)+r+(1-r)h(b(r))
\]

can be checked by grouping the four probabilities of two independent Bernoulli-\(a_r\) bits according to their parity. It gives

\[
 C_W(r)=(1-r)(1-h(b(r))).
\tag{11}
\]

Also

\[
 C_W'(r)=L_r-\frac{L_{a_r}}{s_r}\lt 0.
\tag{12}
\]

Indeed \(L_r=2\operatorname{atanh}(s_r^2)/\ln2\) and
\(L_{a_r}=2\operatorname{atanh}(s_r)/\ln2\), while
\(s_r\operatorname{atanh}(s_r^2)\lt \operatorname{atanh}(s_r)\) for \(0\lt s_r\lt 1\).
By continuity, \(C_W(0)=1\), \(C_W(1/2)=0\), so \(0\lt w\lt 1\). Equation (11) moreover gives \(0\lt w\lt 1-e\).

It follows that \(0\lt 1-w/(1-r)\lt 1\) for every \(r\in[0,e]\). Thus \(q_e(r)\in(0,1/2)\). Comparing (11) with (2), strict decrease of \(C_W\) yields

\[
 q_e(e)=b(e),\qquad q_e(r)>b(r)\quad(0\le r\lt e).
\tag{13}
\]

For \(0\lt r\lt 1/2\), direct differentiation gives

\[
 F_q(r,q)=(1-r)\left[2h'((1-r)q+r/2)-h'(q)\right].
\tag{14}
\]

This derivative vanishes at \(q=b(r)\), is strictly positive for \(b(r)\lt q\lt 1/2\), and vanishes again at \(q=1/2\). To verify the strict sign, set \(u=1-2q\) and \(v=1-r\). The required inequality becomes

\[
 2\operatorname{atanh}(vu)>\operatorname{atanh}(u).
\]

Since \(\tanh\) is strictly increasing, this is equivalent to
\(2v/(1+v^2u^2)>1\), or

\[
 u^2\lt \frac{1-2r}{(1-r)^2}.
\]

That is exactly \(q>b(r)\); the case \(u=0\) is the endpoint equality. At \(r=0\), simply \(F(0,q)=h(q)\), which is strictly increasing on \([0,1/2]\).

The boundary identities are

\[
 F(r,b(r))=0,\qquad F(r,1/2)=1-h(r).
\tag{15}
\]

Consequently \(F(r,\cdot)\) maps \([b(r),1/2]\) continuously and strictly increasingly onto \([0,1-h(r)]\). The formula for \(C(r,t)\) is therefore continuous and strictly decreasing from \(C_W(r)\) to zero on that range, with the stated zero extension. In particular,

\[
 0\lt \tau_e(r)\lt 1-h(r)\quad(r\lt e),\qquad \tau_e(e)=0,
\tag{16}
\]

and for every \(t\ge0\), \(r\lt e\),

\[
 C(r,t)>w\iff t\lt \tau_e(r),\qquad
 C(r,t)\le w\iff t\ge\tau_e(r).
\tag{17}
\]

The continuity in the source parameter needed for (1) also follows from these formulas: the increasing inverses depend continuously on their parameters, including \(r=0\), and at saturation the value tends to zero.

## 4. Removable singularity at the right endpoint

The numerator and denominator in (4) both vanish quadratically at \(r=e\). This section computes their ratio rather than substituting into a zero-over-zero expression.

For \(r>0\), (15) and (14) give

\[
 F(r,b(r))=F_q(r,b(r))=0.
\]

The second derivative at that point is

\[
 F_{qq}(r,b(r))
 =\frac{4(1-r)^2(1-2r)}{r^2\ln2}.
\tag{18}
\]

For completeness, \((1-r)b(r)+r/2=a_r\),
\(a_r(1-a_r)=r/2\), and
\(b(r)(1-b(r))=r^2/[4(1-r)^2]\). Substitution in

\[
 F_{qq}=(1-r)\{2(1-r)h''((1-r)q+r/2)-h''(q)\},
 \qquad h''(x)=-\frac1{\ln2\,x(1-x)},
\]

proves (18).

The identity \((1-r)(1-h(q_e(r)))=w\) implies

\[
 q_e'(r)=-\frac{w}{(1-r)^2h'(q_e(r))}.
\tag{19}
\]

Differentiating (11) at \(r=e\), and comparing with (19), gives

\[
 q_e'(e)-b'(e)
 =\frac{C_W'(e)}{(1-e)h'(b(e))}.
\tag{20}
\]

All functions here are smooth in a neighborhood of \(r=e\). Taylor expansion in the \(q\) coordinate around \(b(r)\), with (18) and (20), therefore gives

\[
 \tau_e(r)=\frac12 F_{qq}(e,b(e))
 \left(\frac{C_W'(e)}{(1-e)h'(b(e))}\right)^2(r-e)^2
 +o((r-e)^2).
\tag{21}
\]

Meanwhile,

\[
 D(r\|e)=\frac{(r-e)^2}{2\ln2\,e(1-e)}+o((r-e)^2).
\tag{22}
\]

The identity \(h'(b(e))=2h'(a)=2L_a\), together with (12), simplifies the ratio of the coefficients to

\[
 \lim_{r\uparrow e}K_e(r)
 =\frac{(1-e)(1-2e)}e\left(\frac{C_W'(e)}{L_a}\right)^2
 =\frac{1-e}e\left(1-s\frac{L_e}{L_a}\right)^2.
\]

This is (6), and it is strictly positive by (12). At the left endpoint, \(F(0,q)=h(q)\), \(h(q_e(0))=1-w\), and \(D(0\|e)=\log_2(1/(1-e))>0\), proving (5).

Equations (4)–(6) thus define a positive continuous function on a compact interval. Its finite maximum exists. The map \((e,z)\mapsto K_e(ez)\) is also continuous on \((0,1/2)\times[0,1]\). At \(z=1\), this follows from the preceding Taylor argument locally uniformly for \(e\) in any compact subinterval of \((0,1/2)\); elsewhere it follows directly from the formulas. Consequently \(K_*(e)\) is continuous on \((0,1/2)\), since on each such compact subinterval

\[
 |K_*(e)-K_*(e')|
 \le\sup_{0\le z\le1}|K_e(ez)-K_{e'}(e'z)|\longrightarrow0.
\]

## 5. Proof of the phase theorem and boundary convention

At \(r=e\), the value in (1) is \(C(e,0)=w\), so \(\Gamma^{\mathrm{UB}}_{-\beta}(e)\ge w\).

For \(r\lt e\), the divergence is positive. Applying (17),

\[
 C(r,c_\beta D(r\|e))>w
 \iff c_\beta D(r\|e)\lt \tau_e(r)
 \iff c_\beta\lt K_e(r).
\tag{23}
\]

If \(c_\beta\ge K_*(e)\), (23) excludes a value above \(w\) at every \(r\lt e\), and the value at \(e\) is exactly \(w\). This proves equality.

If \(c_\beta\lt K_*(e)\), a maximizer of the extended \(K_e\) either lies in \([0,e)\), immediately providing a witness in (23), or lies only at \(e\). In the latter case, continuity gives points \(r\lt e\) with \(K_e(r)>c_\beta\). Hence the maximum in (1) is strictly above \(w\). This proves (8)–(9), including the case where the supremum over the half-open interval is not attained.

At \(c_\beta=K_*(e)\), the inequality in (23) is never strict, so the phase boundary itself is assigned to equality. This proves (10) and all of its endpoint conventions. Notice that the use of the compact extension does not turn the artificial endpoint ratio into an actual strict witness; continuity supplies the required genuine witness whenever the threshold inequality is strict.

## 6. Small-crossover asymptotic and a purely analytic strict rectangle

The right-endpoint expression alone already implies a finite-order strict region. Precisely,

\[
 \boxed{\displaystyle
 \lim_{e\downarrow0}e\log_2^2(1/e)\,K_e(e)=1.}
\tag{24}
\]

To prove this, let \(L=\log_2(1/e)\). Since \(a=e/(1+s)\),

\[
 a/e\to1/2,\qquad L_a/L\to1.
\]

Moreover

\[
 L_a-sL_e=(L_a-L_e)+(1-s)L_e\longrightarrow1.
\]

The first difference tends to \(\log_2 2=1\), because
\((1-a)e/[a(1-e)]\to2\). The second term tends to zero: \(1-s=2e/(1+s)\) and \(e\log_2(1/e)\to0\). Substitution in (6) proves (24).

In particular \(K_*(e)\ge K_e(e)\to\infty\). Therefore, for every fixed \(\beta_0>0\), there exists \(e_0>0\) such that

\[
 \Gamma_{-\beta}^{\mathrm{UB}}(e)>C_W(e)
 \quad\text{for all }0\lt e\le e_0,
 \quad\beta\in[\beta_0,\infty].
\tag{25}
\]

This assertion includes every fixed finite \(\beta>0\) by choosing \(\beta_0=\beta\); under (OP), it resolves the operational small-crossover separation with that explicit quantifier order. It does not interchange the limits \(e\downarrow0\) and \(\beta\downarrow0\).

A concrete rectangle can be proved without evaluating any transcendental quantity numerically. For \(0\lt e\le1/4\), the identities \(e=2a(1-a)\), \(b(e)=a^2/(1-e)\) imply

\[
 e/2\le a\le e,\qquad b(e)\le\frac{e^2}{1-e}\le\frac1{12}.
\]

Consequently,

\[
 L_a-sL_e\ge L_a-L_e
 =\log_2(2(1-b(e)))
 \ge\log_2(11/6)>1/2,
\]

where the final inequality follows from \((11/6)^2>2\). Also
\(L_a\le\log_2(2/e)=L+1\) and \(1-e\ge3/4\). Formula (6) gives

\[
 K_e(e)\ge\frac{3}{16e(\log_2(1/e)+1)^2}.
\tag{26}
\]

The function \(g(e)=e(\log_2(1/e)+1)^2\) is increasing on \((0,1/8]\), since

\[
 g'(e)=(L+1)(L+1-2/\ln2)>0
\]

there; \(L+1\ge4\) and \(\ln2>1/2\) suffice. Thus for \(0\lt e\le2^{-11}\),

\[
 K_*(e)\ge K_e(e)
 \ge\frac{3\,2^{11}}{16\cdot12^2}
 =\frac83>2.
\]

As \(c_\beta\le2\) whenever \(\beta\ge1\), (8) proves

\[
 \boxed{\quad
 0\lt e\le2^{-11},\quad\beta\in[1,\infty]
 \quad\Longrightarrow\quad
 \Gamma^{\mathrm{UB}}_{-\beta}(e)>C_W(e).
 \quad}
\tag{27}
\]

Under (OP), the same rectangle is strictly separated for both operational common informations.

More generally, given any \(\beta_0>0\), choose an integer \(N\ge3\) satisfying

\[
 \frac{3\,2^N}{16(N+1)^2}>1+1/\beta_0.
\tag{28}
\]

Such an integer exists for every real \(\beta_0>0\). Taking \(e_0=2^{-N}\), (26) and monotonicity of \(g\) prove (25) with this explicit dyadic choice. When \(\beta_0\) is computable, a suitable \(N\) can also be found by a certified search for the strict inequality (28). These constants are conservative; no sharp crossover threshold is claimed.

## 7. Certified global evaluability, not just a numerical maximum

The boundary (7) contains one bounded real maximization of explicit elementary functions and a single increasing entropy inverse. This section additionally supplies a finite approximation procedure with proved error control. It does not promise that finite-precision arithmetic can decide exact equality of arbitrary real inputs with the boundary.

Fix a rational, or otherwise computable, \(e\in(0,1/2)\), and a requested positive rational absolute error \(\eta>0\). All constants defined below are finite and computable from \(e\). Quantities can be enclosed using interval evaluation of logarithms and square roots, and the entropy inverse can be enclosed by bisection with a positive derivative lower bound on its relevant compact subinterval.

Write \(b=b(e)\), \(Q=q_e(0)\), and

\[
 \ell=h'(Q)>0,\quad H_1=h'(b),\quad
 H_2=\frac1{\ln2\,b(1-b)},\quad
 H_3=\frac1{\ln2\,b^2(1-b)^2}.
\]

Equation (19) implies \(b\le q_e(r)\le Q\lt 1/2\). Also \(b\le m_e(r)\lt 1/2\). Therefore \(H_j\) bound the absolute values of the corresponding first three entropy derivatives at both \(q_e(r)\) and \(m_e(r)\); \(\ell\) is a lower bound on \(h'(q_e(r))\).

For \(j=1,2,3\), the absolute derivatives of
\(\theta(r)=1-w/(1-r)\) are bounded by

\[
 Z_1=w/k^2,\qquad Z_2=2w/k^3,\qquad Z_3=6w/k^4.
\]

Define

\[
 Q_1=Z_1/\ell,\quad
 Q_2=(Z_2+H_2Q_1^2)/\ell,\quad
 Q_3=(Z_3+H_3Q_1^3+3H_2Q_1Q_2)/\ell,
\]

\[
 M_1=Q_1+1/2,\qquad M_2=Q_2+2Q_1,\qquad M_3=Q_3+3Q_2.
\]

Implicit differentiation of \(h(q_e(r))=\theta(r)\) shows that \(Q_j\) bound \(|q_e^{(j)}|\). Differentiating \(m_e=(1-r)q_e+r/2\) shows that \(M_j\) bound \(|m_e^{(j)}|\).

### 7.1 Left half of the interval

Let \(d_0=D(e/2\|e)>0\). On \([0,e/2]\), \(D(r\|e)\ge d_0\) and \(0\le\tau_e(r)\le1\). For two points at distance at most \(\delta\le e/2\), entropy concavity gives
\(|h(x)-h(y)|\le h(\delta)\) for \(x,y\in[0,e]\). Formula (3) and the bound on \(m_e'\) give

\[
 |\tau_e(x)-\tau_e(y)|\le2H_1M_1\delta+h(\delta),
\]

\[
 |D(x\|e)-D(y\|e)|\le L_e\delta+h(\delta).
\]

Thus a valid modulus for \(K_e\) on the left half is

\[
 \omega_L(\delta)=
 \frac{2H_1M_1\delta+h(\delta)}{d_0}
 +\frac{L_e\delta+h(\delta)}{d_0^2}.
\tag{29}
\]

### 7.2 Right half, including the removable endpoint

On \([e/2,e]\), put

\[
 R_2=\frac2{\ln2\,e k},\qquad
 R_3=\frac4{\ln2\,e^2k^2},
\]

\[
 A_2=2(H_2M_1^2+H_1M_2)+R_2,
\]

\[
 A_3=2(H_3M_1^3+3H_2M_1M_2+H_1M_3)+R_3.
\]

Differentiating (3) shows \(|\tau_e''|\le A_2\) and \(|\tau_e'''|\le A_3\). Also \(|D'''(r\|e)|\le R_3\) and \(D''(r\|e)\ge4/\ln2\).

Because \(\tau_e(e)=\tau_e'(e)=D(e\|e)=D'(e\|e)=0\), the integral Taylor formula gives the nonsingular representation

\[
 K_e(r)=\frac{A(r)}{B(r)},\quad
 A(r)=\int_0^1(1-u)\tau_e''(e+u(r-e))\,du,
\]

\[
 B(r)=\int_0^1(1-u)D''(e+u(r-e)\|e)\,du,
\tag{30}
\]

valid also at \(r=e\) by continuity. With \(b_0=2/\ln2\),

\[
 B\ge b_0,\quad |A|\le A_2/2,\quad
 |A'|\le A_3/6,\quad |B'|\le R_3/6.
\]

A valid Lipschitz constant on this half is consequently

\[
 L_R=\frac{A_3}{6b_0}+\frac{A_2R_3}{12b_0^2}.
\tag{31}
\]

### 7.3 Finite procedure and error guarantee

Choose a positive mesh size \(\delta\le e/2\) such that
\(\omega_L(\delta)\le\eta/2\) and \(L_R\delta\le\eta/2\). Such a choice can be found by decreasing a rational mesh, since both bounds tend to zero. Make separate finite grids on \([0,e/2]\) and \([e/2,e]\), each with spacing at most \(\delta\) and including its endpoints. Enclose every grid value in an interval \([l_i,u_i]\) of width at most \(\eta/2\). Use (5)–(6) at the endpoints, avoiding a zero-over-zero evaluation.

Then

\[
 \max_i l_i\ \le\ K_*(e)\ \le\ \max_i u_i+\eta/2,
\]

and the enclosing interval has width at most \(\eta\). All grids and precision choices are finite. The bounds are deliberately loose and establish evaluability, rather than numerical efficiency. Adaptive interval subdivision may improve performance without changing the theorem.

This provides a certified approximation of the entire global maximum, not merely a local stationary point or an endpoint comparison. For a computable input \(c_\beta\), whenever \(c_\beta\ne K_*(e)\), sufficiently precise enclosures certify the correct side. Exact equality is assigned analytically by (9); no claim of a general terminating equality test is made. The phase theorem itself holds for all real parameters; the computability restriction concerns only algorithm inputs.

## 8. Scope and attribution summary

The new phase-analysis content is the explicit crossover-dependent threshold (2)–(10), its removable endpoint (6), the compact global criterion with exact boundary assignment, its certified evaluation argument, and the small-crossover results (24)–(28). The relaxed-Wyner expression and DSBS reduction remain Yu's inputs.

This proof does not establish (OP), does not restrict arbitrary synthesis codes, and does not claim that the maximum in (7) is always attained at \(r=e\). In particular it does not promote the approximate numerical crossover value in Yu's discussion to a proved sharp operational threshold. The operational interpretation requires the separate arbitrary-block operational matching theorem and the stated inputs.

Primary source: Lei Yu, *Rényi Common Information for Doubly Symmetric Binary Sources*, arXiv:2407.06132v1, especially Propositions 1–2 and Conjecture 1: https://arxiv.org/html/2407.06132v1.

