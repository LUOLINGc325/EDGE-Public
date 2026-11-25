# Constructive achievability: truncated root-lattice noise

**Status:** independently derived constructive proof notes, 2026-11-25. These notes establish the lower bound for the frozen finite-alphabet problem. They do not establish the all-mechanism converse or certify academic priority. The truncated geometric/K-norm mechanism is an ingredient, not a claimed original contribution. Existing truncated Laplace, discrete geometric, and Tulap work must be credited in the final related-work discussion.

## A. Setup and exact finite-sample privacy

Let \(m\ge2\), \(\varepsilon>0\), and let \(P,Q\) be strictly positive probability vectors on \([m]\). Adjacency means replacement of one record in \([m]^n\). Put

\[
\Lambda=\{z\in\mathbb Z^m:\sum_i z_i=0\},\qquad
k(z)=\tfrac12\sum_i|z_i|,\qquad B_r=\{z\in\Lambda:k(z)\le r\}.
\]

The value \(k(z)\) is an integer. Write \(s_m(k)=|\{z\in\Lambda:k(z)=k\}|\), with \(s_m(0)=1\). For every integer \(k\ge1\), decomposition into disjoint nonempty positive and negative supports gives the exact formula

\[
s_m(k)=\sum_{a,b\ge1,\ a+b\le m}
\frac{m!}{a!b!(m-a-b)!}
{k-1\choose a-1}{k-1\choose b-1}.
\tag{A.1}
\]

Binomial coefficients with impossible indices are zero. Hence, with \(d=m-2\),

\[
s_m(k)\le3^m k^d. \tag{A.2}
\]

Indeed, choosing the signs of the coordinates has at most \(3^m\) possibilities, and the two positive-composition factors are at most \(k^{a+b-2}\le k^{m-2}\). In particular,

\[
C_\infty=\sum_{k\ge0}s_m(k)e^{-\varepsilon k}<\infty,
\qquad M_1=\sum_{k\ge0}k\,s_m(k)e^{-\varepsilon k}<\infty.
\tag{A.3}
\]

For a nonnegative integer \(r\), draw a noise vector independent of the data with law

\[
g_r(z)=C_r^{-1}e^{-\varepsilon k(z)}\mathbf1_{B_r}(z),
\qquad C_r=\sum_{z\in B_r}e^{-\varepsilon k(z)}.
\tag{A.4}
\]

Release \(W=h(X)+Z_r\), where \(h(X)\) is the count histogram. The output alphabet is the set of integer vectors whose coordinates sum to \(n\); negative coordinates are allowed. This choice is essential to keep the noise normalizer independent of the database. Clamping afterwards is permissible but is not used in this proof.

### Proposition A.1: exact privacy loss

For every neighboring histogram shift \(v=e_i-e_j\),

\[
\sum_z[g_r(z)-e^\varepsilon g_r(z-v)]_+
=\frac{e^{-\varepsilon r}}{C_r}
\bigl|\{z\in\Lambda:k(z)=r,\ k(z-v)=r+1\}\bigr|
\le \frac{s_m(r)e^{-\varepsilon r}}{C_r}.
\tag{A.5}
\]

For \(r=0\), interpret the right side as one. For \(r\ge1\), the final upper bound is at most \(3^m r^d e^{-\varepsilon r}\).

**Proof.** The triangle inequality gives \(|k(z)-k(z-v)|\le1\). Whenever both noise probabilities are positive,

\[
g_r(z)\le e^\varepsilon g_r(z-v).
\]

Only points in \(B_r\setminus(v+B_r)\) can contribute to the positive part. Such points necessarily have \(k(z)=r\) and \(k(z-v)=r+1\); on them the second probability is zero. For countable distributions, the displayed positive-part sum is exactly the supremum over all output events of \(M_h(A)-e^\varepsilon M_{h+v}(A)\). All ordered pairs \((i,j)\) are included, so the assertion holds in both directions and for every database in the full input domain. ∎

An optional explicit description of the cap is useful for testing: for \(v=e_1-e_2\), the conditions on the right side are precisely \(k(z)=r,z_1\le0,z_2\ge0\). For \(m=2\), its cardinality is one for \(r\ge1\); for \(m=3\), it is \(2r+1\). The full shell cardinalities are respectively \(2\) and \(6r\).

The exact cap cardinality, including \(r=0\), is

\[
b_m(r)=\sum_{a,b\ge0,\ a+b\le m-2}
\frac{(m-2)!}{a!b!(m-2-a-b)!}{r\choose a}{r\choose b}. \tag{A.5a}
\]

To verify it independently, choose the positive and negative supports among the last \(m-2\) coordinates. Positive mass \(r\) must be distributed into \(a\) strictly positive coordinates and the nonnegative second coordinate, giving \({r\choose a}\); negative mass gives \({r\choose b}\). The first two coordinates cannot have the opposite signs, so this enumeration is disjoint and exhaustive. Its leading polynomial coefficient is \({2d\choose d}/d!>0\), where \(d=m-2\).

### Choosing the radius

Let \(a_n=\log(1/\delta_n)\), where \(0<\delta_n<1/2\). Fix an integer \(r_0>\max(1,d/\varepsilon)\), and take the least integer \(r_n\ge r_0\) such that

\[
\varepsilon r_n-d\log r_n\ge a_n+m\log3. \tag{A.6}
\]

This radius exists, and Proposition A.1 proves \((\varepsilon,\delta_n)\)-DP. Moreover, for constants depending only on \(m,\varepsilon\),

\[
r_n=\frac{a_n+O(\log(a_n+2))}{\varepsilon}. \tag{A.7}
\]

To see the upper estimate, the left side of (A.6) is eventually at least \(\varepsilon r/2\), so first \(r_n=O(a_n+1)\). Minimality then implies \(\varepsilon r_n\le a_n+m\log3+\varepsilon+d\log r_n\), except for the harmless bounded case \(r_n=r_0\). The lower estimate follows directly from (A.6). Thus if \(a_n/n\to\rho<\infty\), then \(r_n/n\to\rho/\varepsilon\); if \(a_n/n\to\infty\), then \(r_n/n\to\infty\).

This argument does not assume that \(\delta_n\) is monotone or tends to zero when \(\rho=0\).

For implementation, a less conservative choice is the smallest integer \(r\ge0\) satisfying

\[
b_m(r)e^{-\varepsilon r}\le\delta_n C_r. \tag{A.8}
\]

All terms are rational when \(e^{-\varepsilon}\) and \(\delta_n\) are rational. This choice does not require noise-vector enumeration. Since \(b_m(r)=c_m r^d(1+O(1/r))\) and \(C_r\to C_\infty>0\), its minimal crossing satisfies
\(\varepsilon r-d\log r=a_n+O(1)\) as \(a_n\to\infty\). Consequently it has the same radius limit and the more precise expansion

\[
r=\frac{a_n+d\log a_n}{\varepsilon}+O_{m,\varepsilon}(1).
\tag{A.9}
\]

For \(d=0\), the logarithmic correction is absent. Eventual strict decrease of the leakage follows from the successive ratio tending to \(e^{-\varepsilon}<1\); finitely many early radii do not affect this asymptotic. The conservative radius (A.6) also has expansion (A.9).

**Calibration counterexample.** It is incorrect to drop the polynomial boundary factor and simply use \(r=\lceil a_n/\varepsilon\rceil\). With \(m=3\), \(\varepsilon=\log2\), \(r=10\), and \(\delta=1/1024\), the exact leakage is \(21/13240>1/1024\). The smallest corrected radius in (A.8) is eleven. This counterexample is included in the code checks.

## B. Exact type bounds and the output rate

For a positive probability vector \(A\), let \(\mu_{A,n}^{(r)}\) denote the output law under \(A^n\). Let

\[
\mathcal T_n=\{h/n:h\in\mathbb Z_{\ge0}^m,\sum_i h_i=n\},
\qquad N_n=|\mathcal T_n|={n+m-1\choose m-1}.
\]

For any output \(w\) in the support, define

\[
J_{A,n}^{(r)}(w)=
\min_{R\in\mathcal T_n:\operatorname{TV}(R,w/n)\le r/n}
\{D(R\Vert A)+\varepsilon\operatorname{TV}(R,w/n)\}.
\tag{B.1}
\]

Here \(\operatorname{TV}(u,v)=\|u-v\|_1/2\) remains a norm distance even if \(w/n\) has negative coordinates. The feasible set in (B.1) is nonempty on the output support.

### Proposition B.1: finite-sample type sandwich

For every such \(w\),

\[
nJ_{A,n}^{(r)}(w)+\log C_r-\log N_n
\le -\log\mu_{A,n}^{(r)}(w)
\le nJ_{A,n}^{(r)}(w)+\log C_r+\log N_n.
\tag{B.2}
\]

**Proof.** For a type \(R=h/n\), the multinomial probability satisfies

\[
N_n^{-1}e^{-nD(R\Vert A)}
\le \Pr_A\{h(X)=h\}
\le e^{-nD(R\Vert A)}. \tag{B.3}
\]

A short self-contained justification is as follows. Factoring the probability gives
\(\Pr_A(h)=\Pr_R(h)e^{-nD(R\Vert A)}\). The type \(h\) is a mode of the multinomial law with parameter \(R=h/n\): for another histogram \(g\) supported where \(h_i>0\),

\[
\frac{\Pr_R(g)}{\Pr_R(h)}
=\prod_i h_i^{g_i-h_i}\frac{h_i!}{g_i!}\le1.
\]

Every factor is at most one, whether \(g_i\ge h_i\) or \(g_i<h_i\); types using a zero coordinate of \(h\) have probability zero. Thus \(1/N_n\le\Pr_R(h)\le1\). Finally,

\[
\mu_{A,n}^{(r)}(w)=C_r^{-1}
\sum_{h:\,k(w-h)\le r}\Pr_A(h)e^{-\varepsilon k(w-h)}.
\]

Use a minimizing type for the lower probability bound and sum at most \(N_n\) terms for the upper probability bound. ∎

### Proposition B.2: deterministic rate limit

For \(b\in[0,\infty]\), define

\[
I_{A,\varepsilon}(Q,b)=
\inf_{R\in\Delta_m:\operatorname{TV}(R,Q)\le b}
\{D(R\Vert A)+\varepsilon\operatorname{TV}(R,Q)\},
\tag{B.4}
\]

with no constraint when \(b=\infty\). Suppose \(r_n/n\to b\) and \(w_n/n\to Q\), with \(\sum_i w_{n,i}=n\) and integer coordinates. Then

\[
J_{A,n}^{(r_n)}(w_n)\longrightarrow I_{A,\varepsilon}(Q,b),
\qquad
-n^{-1}\log\mu_{A,n}^{(r_n)}(w_n)\longrightarrow I_{A,\varepsilon}(Q,b).
\tag{B.5}
\]

The expressions are defined for all sufficiently large \(n\).

**Proof.** Positivity of \(Q\) ensures that \(w_n\) is eventually a nonnegative histogram; hence choosing \(R=w_n/n\) makes the finite feasible set nonempty. Continuity of \(D(\cdot\Vert A)\) on the closed simplex follows from positivity of \(A\), with \(0\log0=0\).

For finite \(b\), any convergent subsequence of finite minimizers has a feasible limit and gives the lower-limit inequality by compactness and continuity. When \(b=0\), every feasible type tends to \(Q\); the choice \(R=w_n/n\) gives the matching upper limit \(D(Q\Vert A)\).

For \(0<b<\infty\), choose a minimizer \(R_*\) in (B.4). To handle a possible active boundary without assuming the wrong one-sided limit, first replace it by \(R_\theta=(1-\theta)R_*+\theta Q\), \(\theta>0\). Its distance from \(Q\) is strictly less than \(b\). Round \(R_\theta\) to types with \(\ell_1\) error at most \(2(m-1)/n\); these are feasible for all sufficiently large \(n\). Taking \(n\to\infty\), then \(\theta\downarrow0\), proves the upper limit. If the chosen minimizer already has strict slack, the mixing step is unnecessary.

For \(b=\infty\), every fixed rounded simplex point is eventually feasible. Compactness still gives the lower limit, now with the unrestricted infimum. Finally, (B.2), \(1\le C_r\le C_\infty\), and \(\log N_n=O_m(\log n)\) prove the output-probability limit. ∎

## C. Achieved KL and valid private e-values

The radius family has a uniform first-moment bound:

\[
\mathbb E k(Z_{r_n})
=C_{r_n}^{-1}\sum_{k\le r_n}k s_m(k)e^{-\varepsilon k}
\le M_1. \tag{C.1}
\]

Under \(Q^n\), the law of large numbers and (C.1) imply \(W_n/n\to Q\) in probability. Applying Proposition B.2 with \(A=P\) and \(A=Q\) gives

\[
\frac1n\log\frac{\mu_{Q,n}^{(r_n)}(W_n)}{\mu_{P,n}^{(r_n)}(W_n)}
\longrightarrow I_{P,\varepsilon}(Q,b)
\quad\text{in probability}. \tag{C.2}
\]

The deterministic sequential statement in Proposition B.2 gives this probability statement by contradiction: if convergence failed on outputs tending in probability to \(Q\), choose a violating subsequence of outputs whose normalized distance to \(Q\) tends to zero. The \(Q\)-rate equals zero because \(R=Q\) is feasible and all terms in (B.4) are nonnegative.

Convergence in probability alone is not enough to exchange expectations. Full support supplies the missing uniform bound. For **any** common output kernel \(K\),

\[
e^{n\ell}\le\frac{(Q^nK)(w)}{(P^nK)(w)}\le e^{nu},
\qquad
\ell=\min_i\log\frac{Q_i}{P_i},\quad
u=\max_i\log\frac{Q_i}{P_i}.
\tag{C.3}
\]

This follows by multiplying the corresponding bounds on the input likelihood ratio by the nonnegative kernel and summing. Therefore the normalized logarithm in (C.2) is uniformly bounded, including on rare outputs. Its expectations converge, proving

\[
\boxed{
\lim_{n\to\infty}\frac1nD\bigl(\mu_{Q,n}^{(r_n)}\Vert\mu_{P,n}^{(r_n)}\bigr)
=\inf_{R:\operatorname{TV}(R,Q)\le\rho/\varepsilon}
\{D(R\Vert P)+\varepsilon\operatorname{TV}(R,Q)\}.}
\tag{C.4}
\]

Define the scalar output

\[
E_n(W_n)=\frac{\mu_{Q,n}^{(r_n)}(W_n)}{\mu_{P,n}^{(r_n)}(W_n)}. \tag{C.5}
\]

The two output laws have identical support because \(P,Q\) are both positive. Thus (C.5) is finite and strictly positive on every possible output, has \(\mathbb E_{P^n}E_n=1\), and is \((\varepsilon,\delta_n)\)-DP by postprocessing. Its expected log under \(Q^n\) is exactly the KL in (C.4). This proves the claimed constructive liminf for the supremum over all private e-value mechanisms.

### Endpoints

- If \(\rho=0\), then \(r_n=o(n)\), including constant privacy-failure budgets. The ball in (C.4) collapses to \(Q\), and the achieved rate is \(D(Q\Vert P)\). Data processing is also a universal upper bound at this endpoint.
- If \(\rho=\infty\), the constraint disappears and the rate is the pure-DP variational value \(\inf_R[D(R\Vert P)+\varepsilon\operatorname{TV}(R,Q)]\). The finite-radius construction above remains valid. Alternatively, use the untruncated law \(g_\infty(z)=C_\infty^{-1}e^{-\varepsilon k(z)}\), which is pure \(\varepsilon\)-DP and hence satisfies every positive \(\delta_n\); the same type argument has no support constraint.
- If \(P=Q\), the e-value is identically one and all displayed rates are zero. No strict alternative separation is needed for the construction.

## D. One explicit finite-sample lower certificate

This bound is optional for the asymptotic proof and is not a replacement for the all-mechanism converse. Put

\[
T_{m,\varepsilon}(t)=\sum_{k>t}s_m(k)e^{-\varepsilon k},
\quad
\beta_n(\eta)=2m\exp\!\left(-\frac{2n\eta^2}{m^2}\right)
+T_{m,\varepsilon}(\lfloor n\eta/2\rfloor).
\]

For \(\eta>0\), a coordinatewise Hoeffding bound and the noise tail imply

\[
\Pr_{Q^n}\{\operatorname{TV}(W_n/n,Q)\le\eta\}
\ge [1-\beta_n(\eta)]_+. \tag{D.1}
\]

For an output in this event, every feasible type in (B.1) has distance at most \(r_n/n+\eta\) from \(Q\). The reverse triangle inequality consequently gives

\[
J_{P,n}^{(r_n)}(w)\ge
\left[I_{P,\varepsilon}(Q,r_n/n+\eta)-\varepsilon\eta\right]_+.
\tag{D.2}
\]

Globally \(J\ge0\). Moreover,

\[
H(W_n)\le H(h(X))+H(Z_{r_n})\le\log N_n+H(Z_{r_n}),
\]

where the noise entropy is exactly

\[
H(Z_r)=\log C_r+\frac{\varepsilon}{C_r}\sum_{k\le r}k s_m(k)e^{-\varepsilon k}
\le\log C_\infty+\varepsilon M_1. \tag{D.3}
\]

Combining the lower half of (B.2), (D.1), and (D.2), with the nonnegative \(\log C_r\) term safely dropped, proves

\[
\frac1nD(\mu_{Q,n}^{(r_n)}\Vert\mu_{P,n}^{(r_n)})
\ge [1-\beta_n(\eta)]_+
\left[I_{P,\varepsilon}(Q,r_n/n+\eta)-\varepsilon\eta\right]_+
-\frac{2\log N_n+H(Z_{r_n})}{n}. \tag{D.4}
\]

One can always take the maximum of this expression and zero. The quantities are finite and explicit. A numerical minimizer without a rigorous lower enclosure of the infimum in (D.4) is not, by itself, a rigorous numerical certificate for the right side.

Retaining \(\log C_r\) and using its exact cancellation in (D.3) improves the error term in (D.4) from \((2\log N_n+H(Z_{r_n}))/n\) to \((2\log N_n+\varepsilon\mathbb E k(Z_{r_n}))/n\). Either bound is valid; the latter has a uniformly bounded noise constant without a normalizer term.

## E. Reproduction scope

`code/mechanism.py` uses rational probabilities and rational \(t=e^{-\varepsilon}\) to enumerate finite binary and ternary instances. Its main implementation calibrates by (A.8), and it separately records the conservative radius (A.6). It checks the exact directed privacy divergences for every histogram-neighbor direction, the exact shell and cap count formulas, the full finite-output type sandwich, equality \(\mathbb E_P E=1\), and output-law normalization. KL values and variational comparisons use floating-point logarithms and are explicitly marked numerical. Finite checks support implementation correctness; Propositions A.1–B.2 and (C.1)–(C.5) supply the all-\(n\), all-output constructive proof.
