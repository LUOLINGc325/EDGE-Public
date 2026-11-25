---
title: "Exact and local minimax stopping costs for critical sparse audits"
lang: en
---

## Abstract

Binary labels may be selectively hidden under a predictable probability limit. Hidden labels are independently audited with probability \(a\), and the observation distinguishes reports from audits. We derive the optimal worst-case expected number of raw rounds when false-alarm probability is controlled over the entire horizon and every alternative must alarm almost surely. At the contact boundary, fixed confidence gives \((1-\alpha)/(\rho a)\) to leading order, whereas vanishing \(\alpha=a^{\gamma+o(1)}\) produces audit-count steps. When the positive gap has scale \(\sqrt{a\log(1/a)}\), the limiting passage law has Poisson jumps and deterministic drift. We calculate its atoms, density and second moment, and identify a local minimax survival curve with Gaussian transitions at every positive atom. In a separate fixed-confidence regime with a gap of order \(\sqrt a\), a stopped likelihood power and a gated first-audit comparison give the exact interpolation between the no-report and report-information limits. The upper bounds hold for adaptive outcome and hiding laws.

## 1. Model and claims

Fix \(0<p<q<1\), and put \(\rho=q-p\). At round \(s\), a binary outcome has conditional success probability \(\theta_s\), given the full observed past and previous procedural randomization. Write \(h_{1s}\) and \(h_{0s}\) for the conditional probabilities of an initially hidden positive and negative. They satisfy
\[
 0\le h_{1s}\le\theta_s,\qquad
 0\le h_{0s}\le1-\theta_s,\qquad h_{1s}+h_{0s}\le\rho.
\]
Once the initial hiding decision has been made, a hidden label is independently and correctly recovered with probability \(a\in(0,1)\). The five observable categories are reported positive, reported negative, audited positive, audited negative, and still hidden. The null permits \(\theta_s\le p\) every round. The alternative permits \(\theta_s\ge q\) every round. The conditional reporting and outcome laws may depend on the observed history, within the given constraints. The reporter cannot use the current audit coin. The observed categories match [1, §7.1].

An alarm time \(\tau\) may take value \(\infty\), with \(\tau=0\) allowed using independent procedural randomization. A level-\(\alpha\), power-one rule alarms with probability at most \(\alpha\) under every null process and probability one under every alternative process. Its cost is the maximum in the sense of a supremum of \(\mathbb E_Q\tau\) over the alternative processes. Let \(T_a(\alpha)\) be the infimum of that cost over all such rules. The count is in raw rounds, including those without an observed label.

The sparse-audit study [1, Theorem 6] proved the \(a^{-1}\) order at fixed \(\alpha\), leaving the constant open in §10 and excluding a joint-limit conclusion in §7.2. We work at its critical boundary. The all-negative and all-positive hidden masses used at that boundary are feasible since \(\rho<\min(q,1-p)\).

**Theorem 1.** For \(\alpha\in(0,1)\) fixed,
\[
 \lim_{a\downarrow0}aT_a(\alpha)=\frac{1-\alpha}{\rho}.
 \qquad\text{(1)}
\]
If \(\alpha=\alpha(a)\to0\) with \(\log\alpha(a)/\log a\to0\), then the limit is \(1/\rho\). If
\(\log\alpha(a)/\log a\to\gamma>0\) and \(2\gamma\) is not an integer, then
\[
 \lim_{a\downarrow0}aT_a(\alpha(a))=\frac{\lceil2\gamma\rceil}{\rho}.
 \qquad\text{(2)}
\]
At a positive half-integer \(\gamma=m/2\), \(m\in\mathbb N\), the \(\liminf\) is at least \(m/\rho\), and the \(\limsup\) is at most \((m+1)/\rho\).

## 2. Two lower bounds

Let \(Q\) be the iid alternative with probability \(q\) and hidden masses \((\rho,0)\). The iid null with probability \(p\) and masses \((0,\rho)\) has identical probabilities for the three categories other than audited labels. The audit arrives with probability \(a\rho\) each round under \(Q\). Consequently any procedure has the same probability under this pair of alarming before the first audited label. Its null level bounds that probability by \(\alpha\). Under \(Q\), power one and predictable summation of audited-label indicators give
\[
 a\rho\,\mathbb E_Q\tau
 =\mathbb E_Q[\text{audited labels through }\tau]\ge1-\alpha.
 \qquad\text{(3)}
\]
This is the lower bound in [1, Theorem 6] specialized to criticality, including procedural randomization.

For smaller \(\alpha\), keep \(Q\) but change the iid null to \(P_a\) with probability \(p\) and masses \((\eta,\rho-\eta)\), where \(\eta=\sqrt a\) for sufficiently small \(a\). The two report probabilities are \(p,1-q\) under \(Q\) and \(p-\eta,1-q+\eta\) under \(P_a\). Both laws have still-hidden probability \((1-a)\rho\). Audited positives have probabilities \(a\rho,a\eta\), respectively. An audited negative is impossible under \(Q\). Thus the log likelihood along a \(Q\)-path of length \(t\) is
\[
 \Lambda_t=A_t\log(\rho/\eta)+\sum_{s=1}^t \xi_s,
\]
where \(A_t\) counts audited positives and \(\xi_s\) is the reported-category log likelihood, with value zero on an unreported observation. Under \(Q\), \(\xi_s\) is iid with absolute value at most \(C\eta\), mean \(O(\eta^2)\), and variance \(O(\eta^2)\). Indeed the two report contributions to its mean have first-order terms \(+\eta\) and \(-\eta\). For each fixed \(H>0\), the expected cumulative mean and the cumulative variance are bounded through \(\lfloor H/a\rfloor\). The \(L^2\) martingale maximal inequality therefore yields
\[
 \max_{t\le H/a}\left|\sum_{s=1}^t\xi_s\right|=O_{Q}(1),
\]
where \(O_Q(1)\) means bounded in probability as \(a\downarrow0\).

Let \(S_k\) be the time of the kth audited positive under \(Q\). For a fixed integer \(k\ge1\), suppose \(\gamma>(k-1)/2\). Take \(\varepsilon>0\) with \((k-1)/2+\varepsilon<\gamma\). On \(\{\tau<S_k,\,\tau\le H/a\}\), the audit count at \(\tau\) is at most \(k-1\). Apart from an event of \(Q\)-probability \(o(1)\), the likelihood ratio there is at most \(a^{-((k-1)/2+\varepsilon)}\), uniformly over procedures. Stopped change of measure on the event with this likelihood bound gives \(Q\)-probability at most \(\alpha(a)a^{-((k-1)/2+\varepsilon)}=o(1)\). This use of change of measure follows by summing over disjoint finite stopping times, including zero, and admitting the same independent procedure coins under both laws. Hence
\[
 Q(\tau<S_k,\ \tau\le H/a)=o(1).
\]
The time \(S_k\) is a sum of \(k\) geometric waiting times with success probability \(a\rho\), independently of the test's choice to stop observing. Therefore \(aS_k\) converges in distribution to the sum of \(k\) independent rate-\(\rho\) exponentials. Comparing the expectations of \(a\tau\) and \(aS_k\) truncated at \(H\) costs at most \(H Q(\tau<S_k,\tau\le H/a)\). First let \(a\downarrow0\) and then \(H\to\infty\). This proves
\[
 \liminf_{a\downarrow0}aT_a(\alpha(a))\ge k/\rho
 \quad\text{if}\quad \gamma>(k-1)/2 .
 \qquad\text{(4)}
\]
The \(o(1)\) bounds used for each fixed \(H\) are uniform in the test.

## 3. An adaptive upper bound

Let \(R_s\) indicate an originally reported positive, \(I_s\) indicate an audited positive, and write \(r_s=\mathbb E[R_s\mid\mathcal F_{s-1}]=\theta_s-h_{1s}\). Put
\[
 D_t=\sum_{s\le t}(R_s-p),\qquad
 M_t=\sum_{s\le t}(R_s-r_s),\qquad
 C_t=\sum_{s\le t}h_{1s}.
\]
Here \(M_t\) is a martingale with increments of absolute value at most one, \(D_t\) is observable, and \(C_t\) is used in the proof. Let \(N\) be a deterministic horizon, \(b>0\) a boundary, and \(k\) a positive integer. During rounds \(1,\ldots,N\), alarm as soon as \(D_t\ge b\), or after the kth audited positive observed on a round with \(D_{s-1}\ge-b\). If there is no alarm by \(N\), start a fresh fallback test. The fallback is the label-thinning rule of [1, Theorem 6], at level \(\beta\): use every audited label and independently use each originally reported label with probability \(a\). Multiplying Bernoulli likelihood factors for retained labels gives level \(\beta\) and conditional worst expected additional cost at most \(F/(a)\), where
\[
 F=\frac{\log(1/\beta)+\log(q/p)}{d(q\|p)} .
\]
The bound follows from the positive drift of the bounded log factors under the alternative. It holds after any foreground history, since the class constraints remain conditional.

Use the two-sided maximal Azuma inequality in the form
\[
 \epsilon:=2e^{-b^2/(2N)},\qquad
 \Pr\bigl(\max_{t\le N}|M_t|\ge b\bigr)\le\epsilon.
\]
Write \(G\) for the event \(\max_{t\le N}|M_t|<b\). In the analysis the raw process may be continued after an alarm; the foreground rule uses only its observed prefix.

### 3.1. Null level

Under any null process, \(r_s-p\le-h_{1s}\), so \(D_t\le M_t-C_t\). On \(G\), the report-only boundary is never reached. Every eligible audit round has \(C_{s-1}\le2b\). For the probability bound, count only audited positives on rounds with \(C_{s-1}\le2b\), using a predictable mask. This auxiliary count dominates the foreground gated count on \(G\). Its conditional occurrence probabilities \(u_s=a h_{1s}\mathbf1_{\{C_{s-1}\le2b\}}\) sum pathwise to at most \(u=a(2b+1)\), because \(C\) is nondecreasing with increments at most one.

For a predictable Bernoulli count with such a bound, its exponential with parameter \(\lambda>0\), divided by the product of the conditional moment factors \(1+(e^\lambda-1)u_s\), is a nonnegative martingale of mean one. The product is at most \(\exp[(e^\lambda-1)u]\). Markov's inequality, at \(\lambda=\log(k/u)\) when \(u<k\), then bounds the chance of \(k\) or more counts by \((eu/k)^k\). The whole rule has level at most
\[
 \epsilon+\left(\frac{ea(2b+1)}{k}\right)^k+\beta
 \qquad\text{when } a(2b+1)<k.
 \qquad\text{(5)}
\]
The fallback term is valid without a restriction on the chance of reaching it.

### 3.2. Expected foreground cost

Under any alternative process \(r_s\ge q-\rho=p\), so \(D_t\ge M_t\). On \(G\), the audit gate stays open throughout. Let \(S\le N\) be the first foreground alarm or \(N\) if no alarm occurs earlier. On \(G\) at most \(k\) audited positives are seen through \(S\). In all cases \(D_S\le b+1\) because the report increment is at most one and the test stops on its first threshold crossing. The alternative constraint \(\theta_s\ge q\) implies \(h_{1s}\ge\rho-(r_s-p)\). On \(G\) it follows that
\[
 C_S\ge \rho S-D_S+M_S\ge \rho S-2b-1.
\]
On \(G^c\) use \(C_S\ge0\) and the raw bound of \(N\) for the number of audits. By predictable summation \(\mathbb E A_S=a\mathbb E C_S\) for \(A_t=\sum_{s\le t}I_s\), since \(S\) is bounded. Combining these bounds gives
\[
 a\rho\,\mathbb E S
 \le k+a(2b+1)+(1+a\rho)N\epsilon .
 \qquad\text{(6)}
\]

### 3.3. Fallback cost

On \(G\) and no foreground alarm, \(A_N\le k-1\) and \(C_N\ge\rho N-2b\) by the same drift argument. For \(z\in(0,1)\),
\[
 Z_t=\frac{z^{A_t}}{\prod_{s\le t}[1-(1-z)a h_{1s}]}
\]
is a nonnegative martingale with expectation one. The denominator is at most \(\exp[-(1-z)a C_t]\). On the specified event, \(Z_N\ge z^{k-1}\exp[(1-z)a(\rho N-2b)]\). This yields
\[
 \Pr(\text{fallback})
 \le \epsilon+z^{-(k-1)}\exp[-(1-z)a(\rho N-2b)].
 \qquad\text{(7)}
\]
In particular the cost of the fallback, in \(a\)-scaled rounds, is at most \(F\) times this probability, uniformly over alternatives.

## 4. Taking the limits

With \(L=\log(1/a)\), put \(K=8/\rho\), \(N=\lceil KL/a\rceil\), and \(b=4\sqrt{K(k+2)}L/\sqrt a\). For each fixed \(k\), \(\epsilon=O(a^{4(k+2)})\) for sufficiently small \(a\). Also \(a(2b+1)=O(\sqrt a L)\). With \(z=1/2\) the exponential term in (7) is \(O(a^4)\). Thus the fallback contributes \(o(1)\) in scaled cost if \(\log(1/\beta)=O(L)\), and the foreground contributes at most \(k/\rho+o(1)\).

For \(\alpha(a)\to0\), \(\log\alpha(a)/\log a\to\gamma\), choose \(\beta=\alpha(a)/2\). If \(\gamma<k/2\), the first two terms in (5) are \(o(\alpha(a))\). This gives the upper bound \(k/\rho\). For \(0<\gamma\) outside positive half-integers, take \(k=\lceil2\gamma\rceil\) and combine with (4). At a half-integer \(\gamma=m/2\), use \(k=m+1\) for the upper bound and \(k=m\) in (4). For \(\gamma=0\) with \(\alpha(a)\to0\), use \(k=1\) and the lower bound (3).

At fixed \(\alpha\), use the level-\(\varepsilon_a\) test just constructed for \(\varepsilon_a=a^{1/4}\), whose worst expected scaled cost is at most \(1/\rho+o(1)\). For sufficiently small \(a\), alarm at time zero with independent probability \((\alpha-\varepsilon_a)/(1-\varepsilon_a)\), and otherwise run that test. The total level is at most \(\alpha\), power is one, and the cost is multiplied by \((1-\alpha)/(1-\varepsilon_a)\). Combine with (3) to obtain (1).

## 5. Approaching the contact boundary from either side

Keep \(p\) and \(\rho\) fixed and write \(q_a=p+\rho+\Delta_a\), with \(\Delta_a\to0\). Let \(T_a(\alpha;q_a)\) be the same minimax cost at this alternative threshold. Put \(s_0=1-p-\rho>0\) and \(L=\log(1/a)\).

**Theorem 2.** The following limits hold. In its moving-confidence assertions, \(\log\alpha(a)/\log a\to\gamma>0\).

1. If \(\Delta_a\le0\), then at fixed \(\alpha\in(0,1)\), \(aT_a(\alpha;q_a)\to(1-\alpha)/\rho\). For moving confidence put \(w_a=-\Delta_a+\sqrt a\) and suppose \(\log w_a/\log a\to\lambda\in[0,1/2]\). If \(\lambda>0\), \(\log\alpha(a)/\log a\to\gamma>0\), and \(\gamma/\lambda\) is nonintegral, then \(aT_a(\alpha(a);q_a)\to\lceil\gamma/\lambda\rceil/\rho\). If instead \(\lambda=0\), then \(aT_a(\alpha(a);q_a)\sim\log(1/\alpha(a))/[\rho\log(1/w_a)]\).
2. If \(0\le\Delta_a=o(\sqrt{aL})\), the moving-confidence result in Theorem 1 holds with \(q_a\). For \(0\le\Delta_a=o(\sqrt a)\), the fixed-\(\alpha\) result in Theorem 1 also holds with \(q_a\).
3. At a positive integer \(\gamma/\lambda=m\) in either staircase, the exponent specifies the adjacent bounds \(m/\rho\) and \((m+1)/\rho\). Both bounds are attained by some confidence sequences with that same exponent, for each given gap sequence in the stated regimes.

**Proof.** First take \(\Delta_a=-d\le0\). Under the least-favorable alternative used for the lower bounds, the \(Q\)-report probabilities are \(p-d,s_0+d\). A null at \(p\) with hidden masses \((d+\sqrt a,\rho-d-\sqrt a)\) offsets the reported probabilities by \(-\sqrt a,+\sqrt a\), preserving their sum and the still-hidden probability. For small enough \(a\), this is feasible. The bounded-horizon report log likelihood remains \(O_Q(1)\), by the same cancellation and maximal inequality as in Section 2. Each audited positive contributes exactly \(\log(\rho/w_a)\). The argument in (4) therefore applies when \(\gamma>(k-1)\lambda\). For the fixed-confidence lower bound a null with \(h_1=d\) instead makes the report probabilities identical, so (3) applies without change.

For the upper bound replace the audit gate by \(D_{s-1}\ge-b-d(s-1)\). The null estimate \(D_t\le M_t-C_t\) still holds, so the auxiliary predictable audit count can be masked at \(C_{s-1}\le2b+dN\). Its total hazard is at most \(a(2b+dN+1)\). Under the alternative \(D_t\ge M_t-dt\), so the gate stays open on \(G\). The bounds (6) and (7) follow with \(\rho-d\) in place of \(\rho\), since \(h_{1s}\ge \rho-d-(r_s-p)\). Taking \(K=16/\rho\) and otherwise using the scales in Section 4 gives a foreground level \(O((w_a L)^k)+O(a^{4(k+2)})\), and scaled cost \(k/\rho+o(1)\).

When \(\lambda=0\), set \(m_a=\log(1/w_a)\), so \(m_a\to\infty\) and \(m_a=o(L)\). The same iid pair has per-round relative entropy \(a\rho m_a+O(a)\), by the report mean bound and audit log factor. The stopped relative-entropy inequality proved below in Section 6 gives \(aT_a\ge(1+o(1))\log(1/\alpha)/(\rho m_a)\). For the reverse bound, fix \(\varepsilon>0\) and take \(k=\lceil(1+\varepsilon)\log(1/\alpha)/m_a\rceil\). Then \(k\to\infty\), \(k=o(L)\). Use \(N=\lceil K L/a\rceil\) with \(K=16/\rho\) and a boundary \(b=C L/\sqrt a\) with a fixed sufficiently large \(C\) so the maximal-martingale error is \(O(a^{\gamma+3})\). The null hazard in (5) is \(O(w_a L)\). Its ratio to \(k\) is \(O(w_a m_a)\), so the \(k\)-count contribution is at most \(\exp[-k(m_a-\log m_a-O(1))]=o(\alpha)\). Equation (6) gives scaled foreground cost at most \((k+o(1))/(\rho-d)\). In (7) the factor \(2^{k-1}=\exp(o(L))\) is offset by the exponential in \(a(\rho-d)N\), so the scaled fallback cost still vanishes at level \(\alpha/2\). Let \(\varepsilon\downarrow0\).

The fixed-confidence upper bound also works for \(d\to0\) arbitrarily slowly. Write \(L_w=\log(1/w_a)\), use \(k=1\) and replace \(L\) by \(L_w\) in the horizon and boundary. Then the null audit hazard is \(O(w_a L_w)\), and \(\epsilon=O(w_a^{4(k+2)})\). To control the audited count on \(G^c\), note that its conditional occurrence probabilities are bounded by \(a\rho\). For \(i<j\), \(\mathbb E[I_i I_j]\le(a\rho)^2\) by conditioning before round \(j\). Thus \(\mathbb E[A_N^2]\le a\rho N+(a\rho N)^2\). Cauchy–Schwarz gives \(\mathbb E[A_S\mathbf1_{G^c}]=O(L_w\sqrt\epsilon)=o(1)\), and the remaining error \(a(\rho-d)N\epsilon\) in (6) is \(o(1)\). Choose fallback level \(\sqrt{w_a}/2\). Its contribution to the scaled cost vanishes by (7), while the whole test has level at most \(\sqrt{w_a}\) for small \(a\). The time-zero randomization in Section 4 gives the claimed fixed-confidence upper bound.

For \(\Delta_a\ge0\) apply the original gate. The alternative estimates only improve, so all its upper bounds hold. For the moving-confidence lower bound use the null with \(h_1=\sqrt a\) and total initial hiding \(\rho\). The report probability displacements are now \(\pm(\Delta_a+\sqrt a)\). On \(H/a\) rounds the report log likelihood's cumulative mean is \(O((\Delta_a+\sqrt a)^2/a)=o(L)\). Its centered maximum is \(O_Q((\Delta_a+\sqrt a)/\sqrt a)\) by the same \(L^2\) maximal inequality. Audited positives still contribute \(\tfrac12 L+\log\rho\). This gives (4) at its original thresholds. If \(\Delta_a=o(\sqrt a)\) for fixed \(\alpha\), use \(h_1=0\) under the null. On histories before the first audit the report log likelihood is now \(o_Q(1)\), uniformly through \(n=\lfloor H/a\rfloor\). Stopped change of measure yields \(Q(\tau<S_1,\tau\le n)\le\alpha+o(1)\). The bounded-time compensator gives
\[
 a\rho\,\mathbb E_Q(\tau\wedge n)\ge
 1-Q(S_1>n)-\alpha-o(1).
\]
Let \(a\downarrow0\) and then \(H\to\infty\).

At \(\gamma=m\lambda\), take \(k=m\) in the lower bound and \(k=m+1\) in the upper bound. To show that the exponent alone does not select a limit, in the first regime use
\[
 \alpha_\pm(a)=w_a^m e^{\pm\sqrt L}.
\]
For \(\alpha_+\), the \(m\)-audit rule's false-alarm cost fits its level because \(e^{\sqrt L}/L^m\to\infty\). For \(\alpha_-\), apply the change-of-measure proof with \(k=m+1\), bounding the report contribution through \(H/a\) by \(\sqrt L/2\) with probability tending to one. This forces \(m+1\) audits to leading order. In the nonnegative-gap regime take \(w_a=\sqrt a\), keep \(\alpha_+\), and use \(\alpha_-=w_a^m e^{-r_a}\), with
\[
 r_a=\sqrt{L\bigl(1+(\Delta_a+\sqrt a)^2/a\bigr)}.
\]
Then \(r_a=o(L)\), \(r_a\to\infty\), and the bounded-horizon report contribution is \(o_Q(r_a)\) by the preceding mean and maximal estimates. The same likelihood argument applies. Taking \(\Delta_a=0\) in this construction also proves sharpness of the adjacent bounds in Theorem 1. \(\square\)

## 6. The logarithmic transition and the report-dominated regime

Let \(\Delta_a=d>0\) tend to zero and write
\[
 A=\tfrac12(1/p+1/s_0),\qquad
 J(d)=(p+d)\log(1+d/p)+(s_0-d)\log(1-d/s_0).
\]
Taylor expansion gives \(J(d)\sim A d^2\).

**Theorem 3.** If \(d/\sqrt{aL}\to c\in(0,\infty)\) and \(\log(1/\alpha(a))/L\to\gamma>0\), then
\[
 \lim_{a\downarrow0}aT_a(\alpha(a);q_a)
 =\int_0^\infty\Pr\!\left(Ac^2 t+\tfrac12 N_\rho(t)<\gamma\right)\,dt,
 \qquad\text{(8)}
\]
where \(N_\rho\) is a Poisson process of rate \(\rho\). In particular, for \(v=Ac^2\) the right-hand side is
\[
 \frac1\rho\sum_{j\in\mathbb Z,\ 0\le j<2\gamma}
 \left[1-e^{-x_j}\sum_{\ell=0}^j\frac{x_j^\ell}{\ell!}\right],
 \qquad x_j=\frac{\rho(\gamma-j/2)}v.
 \qquad\text{(9)}
\]
If instead \(d/\sqrt{aL}\to\infty\) and \(\alpha(a)\) is bounded away from one, then
\[
 \lim_{a\downarrow0}
 \frac{d^2T_a(\alpha(a);q_a)}{\log(1/\alpha(a))}
 =\frac1A.
 \qquad\text{(10)}
\]

**Proof of the upper bound in (8).** Use one likelihood factor per round, with values
\[
 1+d/p,\quad 1-d/s_0,\quad
 1+d(1/p+1/s_0)/a,\quad 1,\quad 1
\]
in order for reported positive, reported negative, audited positive, audited negative, and still hidden. In any null law the first two probabilities are bounded by \(r_1\le p-h_1\) and \(r_0\ge s_0+h_1\). Their contributions to the conditional factor mean minus one are at most \(-d(1/p+1/s_0)h_1\). The audited-positive factor contributes exactly the opposite amount. The product is therefore a nonnegative supermartingale. Stop when it reaches \(1/\alpha\). Under the alternative, finite mean and power one follow from the drift and tail bound below.

Let \(X_n\) be the sum of the report log factors, \(A_n\) the number of audited positives, and \(\ell_a=\log[1+d(1/p+1/s_0)/a]\). In each alternative law, the report probabilities satisfy \(r_1\ge p+d+(\rho-h_1)\) and \(r_0\le s_0-d\). The conditional mean of a report log increment is thus at least
\[
 J(d)+\log(1+d/p)(\rho-h_1).
 \qquad\text{(11)}
\]
Write \(M_n'\) for the report log sum minus its predictable mean. Its martingale differences are bounded in absolute value by a constant times \(d\). For each fixed \(t>0\), put \(n=\lfloor t/a\rfloor\). Azuma gives \(M_n'=o_P(L)\) uniformly over alternative processes, since \(nd^2=O(L)\). For example one may use a deterministic error window \(L^{3/4}\) whose bad probability tends to zero. On the surviving paths in this good event, \(X_n+\ell_a A_n<\log(1/\alpha)\). As \(\ell_a\ge0\) and \(J(d)>0\), (11) then implies
\[
 a\sum_{s\le n}(\rho-h_{1s})\le C_t a L/d=o(1).
 \qquad\text{(12)}
\]

We compare \(A_n\) with an ideal binomial count while preserving all adaptive laws. Enlarge each round by an independent auxiliary randomization. Given the actual audit indicator and its predictable probability \(a h_{1s}\), generate a uniform variable \(U_s\) on \([0,a h_{1s}]\) if the indicator is one and on \([a h_{1s},1]\) otherwise. Null-probability branches can be set arbitrarily. Conditional on the enlarged past, \(U_s\) is uniform on \([0,1]\), and \(\mathbf1_{\{U_s\le a\rho\}}\) forms an iid Bernoulli stream. The preceding auxiliary draws do not feed the policy or reporting mechanism. Conditional on the enlarged past the latter still uses the same original probabilities, because the draws were made from independent randomness based only on that past. The ideal indicator dominates the actual one, and the conditional probability of a difference is \(a(\rho-h_{1s})\). Mask differences on rounds where the cumulative preceding difference hazard exceeds the right-hand bound in (12). The masked cumulative hazard is at most that bound plus \(a\rho\) on every path. In the good survival event no differences were masked. Therefore, uniformly over alternatives, except on a set of probability \(o(1)\), survival implies that the two counts agree through \(n\).

Now \(nJ(d)/L\to vt\) with \(v=Ac^2\), and \(\ell_a/L\to1/2\). The binomial ideal count converges to a Poisson variable of mean \(\rho t\). The survival implication and (11) show, at every \(t>0\) with \(\gamma-vt\notin\{0,1/2,1,\ldots\}\), that
\[
 \limsup_{a\downarrow0}\ \sup_Q Q(a\tau>t)
 \ \le\ \Pr(vt+N_\rho(t)/2<\gamma).
\]
To integrate uniformly, fix \(H\) large enough that \(nJ(d)\ge2\log(1/\alpha)\) for \(n\ge H/a\) and all small \(a\). Survival at such times implies \(M_n'\le-nJ(d)/2\). Azuma bounds this probability by \(\exp(-c_1 n d^2)\) for some fixed \(c_1>0\). These bounds both give finite expectation for the rule and dominate the scaled tails by an integrable exponential on \([H,\infty)\), since \(d^2\) is at least a positive multiple of \(aL\). Integrating the uniform bounds yields the upper bound in (8).

**Proof of the lower bound in (8).** Use the iid \(Q\) with hidden masses \((\rho,0)\) and the iid null at \(p\) with hidden masses \((\sqrt a,\rho-\sqrt a)\). The \(Q\)-report probabilities are \(p+d,s_0-d\); the null counterparts are \(p-\sqrt a,s_0+\sqrt a\). At a fixed time \(n=\lfloor t/a\rfloor\), the count of audited positives under \(Q\) is binomial with parameter \(a\rho\). In its log likelihood relative to the null each audited positive contributes \(\log(\rho/\sqrt a)\sim L/2\). The report increments have mean \(J_*(a)\sim A d^2\), by Taylor expansion about the null's reported probabilities and \(d/\sqrt a\to\infty\). Their variance is \(O(d^2)\). The centered report sum, maximized over all earlier times up to \(n\), is \(o_Q(L)\) by the \(L^2\) maximal inequality. In particular \(J_*(a)\) is eventually positive. The audit count is nondecreasing, so at all times through \(n\) the log likelihood is at most \(nJ_*(a)+A_n\log(\rho/\sqrt a)+o_Q(L)\), with one common remainder. If the leading expression is less than \((\gamma-\eta)L\) for some fixed \(\eta>0\), any alarm through \(n\), outside the remainder event, has likelihood ratio at most \(e^{(\gamma-\eta/2)L}\). Stopped change of measure bounds the \(Q\)-probability of such an alarm by \(e^{(\gamma-\eta/2)L}\alpha(a)=o(1)\), uniformly over rules. Convergence of the binomial count, followed by \(\eta\downarrow0\), gives the matching lower bound on \(Q(a\tau>t)\) at the same nonboundary times. Nonnegative integration, or Fatou's lemma along arbitrary sequences of nearly minimizing rules, gives (8). Integrating each of the finitely many Poisson probabilities over \(0\le t<(\gamma-j/2)/v\) gives (9).

**Proof of (10).** For the upper bound use the two report factors alone, setting all other factors to one. They remain valid under the null, and the alternative log drift is at least \(J(d)\). The positive overshoot is at most \(\log(1+d/p)\). Predictable summation at bounded stopping times and then monotone convergence prove that the cost is at most \((\log(1/\alpha)+\log(1+d/p))/J(d)\).

For the lower bound change the preceding iid null's positive hidden mass to \(a\), keeping total hiding \(\rho\). The full relative entropy per round is the report relative-entropy contribution plus \(a\rho\log(\rho/a)\). The report contribution is asymptotic to \(A d^2\), since \(a=o(d)\). The latter audit term is \(O(aL)=o(d^2)\). With \(D_a\) the total per-round relative entropy, any power-one level-\(\alpha\) alarm satisfies \(D_a\,\mathbb E_Q\tau\ge\log(1/\alpha)\). Indeed, waiting only to \(\tau\wedge n\) makes the expected stopped log likelihood equal to \(D_a\mathbb E_Q(\tau\wedge n)\). Data processing onto the alarm event by \(n\) gives a binary relative-entropy lower bound. As \(n\to\infty\), the alternative alarm probability tends to one and the null probability remains at most \(\alpha\), yielding the inequality. This proves (10). \(\square\)

## 7. Atoms, Gaussian profiles, and local minimax survival

Throughout this section take the logarithmic transition regime of Theorem 3, \(d_a/\sqrt{aL}\to c>0\) and \(H/L\to\gamma>0\), with \(L=\log(1/a)\), \(H=\log(1/\alpha(a))\), and \(v=Ac^2\). Define \(\mathsf T=\inf\{t:vt+N_\rho(t)/2\ge\gamma\}\).

### 7.1. The law of the limiting passage time

For each integer \(0\le j<2\gamma\), let \(t_j=(\gamma-j/2)/v\). Then \(\mathsf T\) has mass \(e^{-\rho t_j}(\rho t_j)^j/j!\) at \(t_j\). At other times \(0<t<\gamma/v\), write \(k=\lceil2(\gamma-vt)\rceil\). Its density is \(\rho e^{-\rho t}(\rho t)^{k-1}/(k-1)!\). Its second moment is
\[
 \mathbb E\mathsf T^2
 =\frac{2}{\rho^2}\sum_{0\le j<2\gamma}(j+1)
 \left[1-e^{-\rho t_j}\sum_{\ell=0}^{j+1}
             \frac{(\rho t_j)^\ell}{\ell!}\right].
 \tag{13}
\]
The survival function is \(\Pr(N_\rho(t)<2(\gamma-vt))\), because the process is increasing. Differentiating its Poisson sum between adjacent \(t_j\) gives the density. Each \(t_j\) drops the \(j\)-th term of that sum and therefore carries exactly the stated mass. There is no mass at zero. Integrating \(2t\) against each of the summands \(\mathbf1_{\{0<t<t_j\}}e^{-\rho t}(\rho t)^j/j!\) gives (13). If \(0<\gamma\le1/2\), this reduces to the law of the minimum of an exponential variable of rate \(\rho\) and \(\gamma/v\).

### 7.2. The law near each positive atom

Let \(Q_*\) be the iid alternative with positive hidden mass \(\rho\) and no hidden negatives, for the current \(a,d_a\). Use \(J=J(d_a)\) and \(\ell_a=\log(1+d_a(1/p+1/s_0)/a)\) as in §6. The product test of that section first alarms when \(X_n+\ell_a A_n\ge H\), where \(A_n\) counts positive audits and \(X_n\) accumulates just the report log factors \(\log(1+d_a/p)\), \(\log(1-d_a/s_0)\). For \(0\le j<2\gamma\), define the exact center
\[
 t_{j,a}=a(H-j\ell_a)/J,\qquad
 n_{j,a}(z)=\left\lfloor(t_{j,a}+z/\sqrt L)/a\right\rfloor ,
 \tag{14}
\]
which is eventually positive for every fixed \(z\in\mathbb R\). Define
\[
 \mathcal S_a(n)
 =\inf_{\tau\text{ level }\alpha(a),\ \text{power one}}
       \sup_{Q\text{ admissible}} Q(\tau>n).
\]

**Theorem 4 (local minimax survival).** For each \(j,z\) as above, with \(N_j\sim\mathrm{Pois}(\rho t_j)\),
\[
 \lim_{a\downarrow0}\mathcal S_a(n_{j,a}(z))
 =\Pr(N_j<j)+\Pr(N_j=j)\Phi\!\left(-\frac{vz}{\sqrt{2v t_j}}\right).
 \tag{15}
\]
The product test attains this limit on the entire admissible alternative class at every such \(j,z\), and its local law under \(Q_*\) has the same limit. The exact centers in (14) matter because the first-order parameter limits impose no rates of convergence on the \(\sqrt L\) scale.

First analyze the product test under \(Q_*\). With \(n(t)=\lfloor t/a\rfloor\), write \(W_a(t)=(X_{n(t)}-n(t)J)/\sqrt L\). On any fixed bounded time interval its centered independent increments converge to \(\sqrt{2v}\) times standard Brownian motion by the triangular-array functional central limit theorem. The increments have size \(O(d_a/\sqrt L)\), and their variances sum to \(2vt+o(1)\) on \([0,t]\). Jointly \(A_{n(t)}\) converges to an independent rate-\(\rho\) Poisson process. To verify independence, test one step of the scaled centered report score and the audit indicator by fixed Fourier arguments \(w,u\). Their joint characteristic function minus the product of marginals is
\[
 (e^{iu}-1)a\rho
 \left[e^{-iwJ/\sqrt L}-\mathbb E e^{iw(\Delta X-J)/\sqrt L}\right].
\]
This follows from mutual exclusivity of a report and an audit. Its magnitude is \(O(a d_a/\sqrt L)=o(a)\). Products over \(O(1/a)\) steps therefore have the same factorized limit. Disjoint blocks have independent increments. Marginal tightness gives joint tightness in the product of the two path spaces, and the Brownian component has a continuous limit.

Put \(n=n_{j,a}(z)\). The deterministic-plus-count part \(D_k=kJ+\ell_a A_k\) is increasing. For \(a(n-k)\ge L^{-1/4}\) its deficit from \(D_n\) is at least \(J L^{-1/4}/a\), of order \(L^{3/4}\). This exceeds the tight report fluctuations of size \(\sqrt L\). For the remaining \(k\), the continuous Brownian limit gives a vanishing modulus in a window of width \(L^{-1/4}\). Consequently the running score maximum up to \(n\) equals \(X_n+\ell_a A_n+o_{Q_*}(\sqrt L)\). The terminal score minus \(H\), scaled by \(\sqrt L\), is
\[
 vz+o(1)+ W_a(an)+\frac{\ell_a}{\sqrt L}(A_n-j).
 \tag{16}
\]
Here \(a n\to t_j\) and \(\ell_a/L\to1/2\). Counts below \(j\) and above \(j\) force the limiting sign in opposite directions. The \(j\)-count branch has the Brownian limit with variance \(2v t_j\) independently of that count. There is no atom at the centered score threshold in that branch. Thus the terminal and running-max survival probabilities give (15) for the product test under \(Q_*\).

For a bound on **all** valid rules, take an iid null with hidden positive mass \(h=\sqrt a/L\) and hidden negative mass \(\rho-h\) at true probability \(p\). It is admissible for small \(a\) and dominates \(Q_*\) in absolute continuity on finite histories. Let \(\Lambda_k\) be the log likelihood of \(Q_*\) relative to this null. On \(Q_*\)-paths the report step corrections to \(X_k\) are \(-\log(1-h/p)\) and \(-\log(1+h/s_0)\). Their conditional mean under \(Q_*\) is \(O(d_a h+h^2)\) because the baseline linear terms cancel, and their variance is \(O(h^2)\). Summed to \(n=O(1/a)\) the deterministic mean is \(o(\sqrt L)\) and the centered maximum is \(O_P(h/\sqrt a)=o(\sqrt L)\). The audit correction per positive is \(\log(\rho/h)-\ell_a=O(\log L)\) and the count is \(O_P(1)\). Hence uniformly over \(k\le n\),
\[
 \max_{k\le n}|\Lambda_k-(X_k+\ell_a A_k)|=o_{Q_*}(\sqrt L).
 \tag{17}
\]
For any fixed \(\varepsilon>0\) and any legitimate rule, its probability of alarming through \(n\) on \(\{\max_{k\le n}\Lambda_k<H-\varepsilon\sqrt L\}\) is at most \(e^{-\varepsilon\sqrt L}\). Indeed enlarge to the event with the same constraint at the particular alarm time and change measure at each of its disjoint finite values, including zero. The new null probability is at most \(\alpha(a)=e^{-H}\). By (16)–(17) and the maximum approximation, all counts below \(j\) and the normal part below the shifted threshold at count \(j\) give a uniform lower bound on survival. Letting \(\varepsilon\downarrow0\) gives the right side of (15) as a lower bound.

For the uniform upper bound, over any adaptive alternative the report-positive probability satisfies \(r_1\ge p+d_a+(\rho-h_1)\), and \(r_0\le s_0-d_a\) for report negatives. Couple its record round by round to an iid \(Q_*\) record. First use their common mass \(a h_1\) for matched positive audits. On the remaining mass, normalize and couple the negative, zero, and positive report-score increments by their ordered quantiles. Removing equal zero-score mass preserves both tail inequalities, so the actual report increment is always at least the ideal one. Refine each zero score to its actual observation categories using their residual probabilities. Actual positive audits are matched and the predictable probability of an additional ideal positive audit is \(a(\rho-h_1)\). The ideal conditional law is the same at each step regardless of the enlarged history, hence iid. The auxiliary random draws do not change the actual predictable transition probabilities.

Along an actual path that survives through \(n\), the nonnegative audit score and the drift bound in (11) give control of the summed hazard. To spell this out, the report martingale at time \(n\) exceeds \(L^{3/4}\) in absolute value with probability \(o(1)\), uniformly, since its variance is \(O(n d_a^2)=O(L)\). On the complementary survival paths,
\[
 a\textstyle\sum_{s\le n}(\rho-h_{1s})
 \le b_a:=a(H+L^{3/4})/\log(1+d_a/p)=o(1).
\]
Count mismatches only until the preceding cumulative hazard exceeds \(b_a\). Their total counted predictable probability is at most \(b_a+a\rho\) pathwise, so no counted mismatch occurs except on an event of probability \(o(1)\). On the good survival paths every mismatch would be counted, and otherwise actual and ideal audit counts agree and the actual terminal score dominates the ideal one. Thus
\[
 \sup_Q Q(\tau_{\rm product}>n)
 \le Q_*(X_n+\ell_a A_n<H)+o(1).
\]
Applying (16) completes the proof of (15). This is a pointwise survival law at all indicated windows.

For \(p=s_0=\rho=1/3\), \(c=1/\sqrt3\) and \(\gamma=1\), we have \(v=1\). At \(z=0\), the two atom-window survival limits for \(j=0,1\) are \(e^{-1/3}/2\) and \(13e^{-1/6}/12\). For \(j=0\) and \(z=-1,0,1\), the values are \(e^{-1/3}\Phi(1/\sqrt2)\), \(e^{-1/3}/2\) and \(e^{-1/3}\Phi(-1/\sqrt2)\), respectively.

### 7.3. First-order rigidity of expected-optimal procedures

Let \(\widehat\tau_a\) be any legitimate family with \(a\sup_Q E_Q\widehat\tau_a\to E\mathsf T\). Under the same iid \(Q_*\), the laws of \(a\widehat\tau_a\) converge in \(1\)-Wasserstein distance to the law of \(\mathsf T\). The uniform tail lower bound from the proof of (8) applies to every such rule at all continuity points of the limiting law. Bounded means give tightness. Any weak subsequential limit is stochastically at least \(\mathsf T\) by the tail bound, first at common continuity points and then by right continuity. Nonnegative lower semicontinuity of the mean gives the reverse mean inequality, so equal means force identical laws. The same mean bounds and Fatou give convergence of first moments, hence \(1\)-Wasserstein convergence. For the specific product rule, the exponential late-time bound in §6 furthermore gives convergence of every fixed positive moment under \(Q_*\). The rigidity result for arbitrary optimal rules concerns first-order scale. Formula (15) identifies the locally minimax survival curves.

## 8. Fixed confidence on the square-root gap scale

Keep \(p,\rho\) fixed with \(s_0=1-p-\rho>0\) and the alternative threshold \(q_a=p+\rho+d_a\) as in §5. This section takes a fixed \(0<\alpha<1\) and \(d_a/\sqrt a\to c\in(0,\infty)\). Write
\[
 I=Ac^2,\qquad
 \kappa=\frac{1+\sqrt{1+4\rho/I}}2,\qquad A=\frac12(1/p+1/s_0).
\]

**Theorem 5 (fixed-confidence stopping cost).** In this regime,
\[
 \lim_{a\downarrow0}aT_a(\alpha;q_a)
 =\frac{1-\alpha^{\,1-1/\kappa}}{\rho}.
 \tag{18}
\]

### 8.1. A finite-sample lower bound by stopping a power of the likelihood ratio

Write \(d=d_a\), \(f_1=1+d/p\), and \(f_0=1-d/s_0\). For \(0<d<s_0\), let \(X_t\) again be the cumulative report-only log score with increments \(\log f_1,\log f_0,0\) for reported positive, reported negative, and all other outcomes, respectively. Take iid laws \(P_*,Q_*\) with the following observable probabilities:
\[
 \begin{array}{c|cc|ccc}
 &\text{reported positive}&\text{reported negative}&\text{audited positive}
 &\text{audited negative}&\text{still hidden}\\ \hline
 P_* &p&s_0&0&a\rho&(1-a)\rho\\
 Q_* &p+d&s_0-d&a\rho&0&(1-a)\rho .
 \end{array}
\]
Their true positive probabilities are \(p\) and \(q_a\), and both initially hide mass \(\rho\). Both are admissible. Let \(S\) be the first audit of either sign. There is a unique \(\kappa_a>1\) satisfying
\[
 p(f_1^{\kappa_a}-1)+s_0(f_0^{\kappa_a}-1)=a\rho.
 \tag{19}
\]
The left side is strictly convex, is zero at exponents 0 and 1, and is strictly increasing to infinity beyond 1. Taylor expansion of the left side at fixed exponent \(k\), divided by \(a\), converges uniformly on each compact \(k\)-interval to \(I k(k-1)\). The linear terms in \(d\) cancel, and \(d^3/a\to0\). Bracketing the root at two fixed exponents around \(\kappa\) proves \(\kappa_a\to\kappa\).

Under \(P_*\) the process \(M_t=\mathbf1_{\{t<S\}}e^{\kappa_a X_t}\) is a nonnegative mean-one martingale by (19). Bounded stopping followed by Fatou gives \(\mathbb E_{P_*}[e^{\kappa_a X_\tau}\mathbf1_{\{\tau<S\}}]\le1\) for any admissible alarm. On \(B=\{\tau<S\}\) the stopped likelihood ratio is \(e^{X_\tau}\), by summing the probability change on the disjoint finite values of \(\tau\), with any time-zero randomization included. Hölder's inequality and the null level give
\[
 Q_*(B)\le
 \big(\mathbb E_{P_*}[e^{\kappa_a X_\tau}\mathbf1_B]\big)^{1/\kappa_a}
 P_*(B)^{1-1/\kappa_a}\le\alpha^{\,1-1/\kappa_a}.
\]
Under \(Q_*\), the audit rate is \(a\rho\) at every round. Predictable summation through \(\tau\) gives \(a\rho\,\mathbb E_{Q_*}\tau\ge Q_*(S\le\tau)\), including the possibility of stopping at zero. Thus for every finite \(a\) with \(0<d<s_0\),
\[
 a T_a(\alpha;q_a)\ge (1-\alpha^{\,1-1/\kappa_a})/\rho.
 \tag{20}
\]

### 8.2. A report boundary and an audit gate

Choose fixed \(0<\alpha_0<\alpha\), \(0<\varepsilon<\alpha-\alpha_0\) and \(H_0>0\). Define \(N=\lfloor H_0/a\rfloor\), \(b=\log(1/\alpha_0)/\kappa_a\), \(w=a^{-2/3}\), and \(D_t=\sum_{s\le t}(R_s-p)\), where \(R_s\) marks a reported positive. The first phase stops at \(\nu=T_b\wedge S\wedge N\) with \(T_b=\inf\{t:X_t\ge b\}\). It alerts at a report crossing or on a positive first audit whose preceding history satisfies \(D_{S-1}\ge-w\). Other exits start a fresh fallback at level \(\varepsilon\), after the observed prefix. The report crossing and an audit cannot happen on the same round. A qualifying event at round \(N\) still triggers its prescribed alarm.

For any conditional null define nonnegative \(u=\rho-h_1-h_0\), \(y=p-\theta\), and \(v'=h_1\). Compared with the mean-one multiplier under \(P_*\), the conditional multiplier of \(M_t\) minus one on an alive path is
\[
 u[a+f_0^{\kappa_a}-1]-(y+v')(f_1^{\kappa_a}-f_0^{\kappa_a}).
\]
The first bracket is eventually nonpositive, because \(f_0^{\kappa_a}-1=-\kappa_a d/s_0+O(d^2)\) and \(d\asymp\sqrt a\). The second term is also nonpositive. Hence \(M_t\) is a nonnegative supermartingale uniformly over the null class, and the probability of a report crossing before the first audit is at most \(e^{-\kappa_a b}=\alpha_0\).

Let \(r_t=\mathbb E[R_t\mid\mathcal F_{t-1}]\) and \(U_t=\sum_{s\le t}(R_s-r_s)\). Doob's maximal inequality and bounded increments give \(\Pr(\max_{t\le N}|U_t|>w)\le4N/w^2=O_{H_0}(a^{1/3})\) on every admissible law. Under the null \(r_t-p\le-h_{1t}\), so on the good event the gate can open only while the previous cumulative hidden-positive mass is at most \(2w\). Count positive audits only on rounds satisfying that predictable condition. Their total conditional probability sum is at most \(a(2w+1)\) on every path. The gated false alarm probability is thus \(O_{H_0}(a^{1/3})\).

For the fallback retain each reported label independently with probability \(a\), and use every audited label. The conditional probabilities for observing a retained positive or negative are \(a\theta\) and \(a(1-\theta)\). A Bernoulli likelihood product with null \(p\) and alternative \(p+\rho\) is a null supermartingale. It stops at the first crossing of \(1/\varepsilon\), giving null level \(\varepsilon\) after any first-phase prefix. The conditional log drift under every alternative is at least \(a D_{\rm KL}(\mathrm{Ber}(p+\rho)\Vert\mathrm{Ber}(p))\), and the log overshoot is bounded by \(\log((p+\rho)/p)\). Bounded stopping and monotone convergence give a uniform conditional expected cost \(C_\varepsilon/a\) and power one. The whole rule has level at most \(\alpha_0+\varepsilon+O_{H_0}(a^{1/3})\le\alpha\) for small \(a\).

### 8.3. Uniform comparison and the exact ideal cost

For an arbitrary adaptive alternative let \(v_t=\rho-h_{1t}\ge h_{0t}\). Its positive report probability is at least \(p+d+v_t\) and its negative report probability is at most \(s_0-d\), so the log report drift is at least \(J(d)+v_t\log f_1\). The value \(J(d)\ge0\) is the relative entropy of the three-category report score under \(Q_*,P_*\). At \(\nu\) the score never exceeds \(b+\log f_1\). By bounded optional summation,
\[
 a \mathbb E\sum_{t\le\nu}v_t
 \le \frac{a(b+\log f_1)}{\log f_1}=O(\sqrt a).
 \tag{21}
\]
The report-positive drift of \(D_t\) is at least \(d\), so its gate fails with probability at most \(O_{H_0}(a^{1/3})\) through \(N\). Use the joint report/audit coupling of §7.2. It preserves the actual and ideal marginal laws, makes actual report increments at least ideal ones, gives ideal-only positive audits of conditional probability \(av_t\), and leaves actual negative audits of conditional probability at most \(av_t\). By (21) the probability of either mismatch through the actual \(\nu\) is \(O(\sqrt a)\). Without mismatch every earlier ideal audit also stops the actual first phase, and each earlier ideal report crossing has an actual score at least as high. Thus \(\nu\le\xi\wedge N\) there, where \(\xi\) denotes the ideal minimum of the report crossing and the first audit. Boundedness by \(N\) gives \(a\mathbb E\nu\le a\mathbb E_{Q_*}(\xi\wedge N)+H_0O(\sqrt a)\). Without mismatch or gate failure, fallback implies no ideal audit through \(N\), so its probability is at most \((1-a\rho)^N+O_{H_0}(a^{1/3}+\sqrt a)\).

Consider \(\xi=T_b\wedge S\) under each ideal iid law. These stopping times are almost surely finite because \(S\) is geometric. The martingale \(M_{t\wedge\xi}\) under \(P_*\) is bounded above by \(e^{\kappa_a(b+\log f_1)}\). On \(B_*=\{T_b<S\}\) the score at the report crossing lies in \([b,b+\log f_1]\). Thus optional stopping and the pre-audit change of measure give
\[
 \begin{split}
 e^{-\kappa_a(b+\log f_1)}&\le P_*(B_*)\le e^{-\kappa_a b},\\
 e^{b}P_*(B_*)&\le Q_*(B_*)\le e^{b+\log f_1}P_*(B_*).
 \end{split}
\]
Hence \(Q_*(B_*)\to\alpha_0^{\,1-1/\kappa}\). At \(\xi\) the total audit count is exactly the indicator of the complement of \(B_*\), so the predictable sum gives \(a\rho\,\mathbb E_{Q_*}\xi=1-Q_*(B_*)\).

Combine the first-phase comparison and the conditional fallback bound. For fixed \(\alpha_0,\varepsilon,H_0\), take \(a\downarrow0\), giving the upper limit \((1-\alpha_0^{1-1/\kappa})/\rho+C_\varepsilon e^{-\rho H_0}\). Let \(H_0\to\infty\), then \(\alpha_0\uparrow\alpha\) with \(\varepsilon<\alpha-\alpha_0\) at each choice. This matches (20) and proves (18). The argument uses only discrete stopped likelihoods and bounded first-phase comparisons.

For \(p=s_0=\rho=1/3\), \(d_a=\sqrt{a/18}\) gives \(I=\rho/2\) and \(\kappa_a=\kappa=2\), as is checked by substitution in (19). At \(\alpha=1/4\), the scaled limit and the finite-\(a\) lower bound both equal \(3/2\). As a function of \(c>0\), the constant in (18) tends to \((1-\alpha)/\rho\) as \(c\downarrow0\), and is asymptotic to \(\log(1/\alpha)/I\) as \(c\to\infty\). The former is the contact constant from Theorems 1 and 2. The latter agrees with the report-information scale at that endpoint.

## 9. Comparison with fixed-query auditing

[2] gives a closely related power frontier for a single frozen cohort. We inspected all 54 pages of its formal ICLR 2027 submission, including Appendices A–T, as linked by the public OpenReview note \(\texttt{GbjWLX2uUE}\). The checked note has modification timestamp 2026-10-05 19:59:28 UTC. Its title, ID and full abstract agree with the recovered PDF text. The public academic corpus snapshot and precise extraction are listed below. A later discussion mention of a revision was visible, while its exact revised PDF was unavailable. The conclusions here apply to the pinned submission.

In [2, §2], all \(n\) labels have realized before a single prescribed deadline. The selection kernel reads the entire latent vector and commits a full report ledger with exactly \(b_n\) pending positions. Then a query policy chooses up to \(k\) distinct pending identities, without new reports. Its risk conditions refer to the latent order, or in §6 to terminal count tails and cumulative predictable risk. Its performance criterion is a randomized terminal test with worst-case power at size \(\delta\). Theorem 1 and Corollary 1 show a binomial Neyman–Pearson frontier and a truthful one-query effect at contact. Theorem 2 and Appendix P at a root-\(n\) offset combine a single Gaussian report-count statistic with the ROC of a fixed number of noisy queries. Theorems 3–4 compare alternate risk contracts and reliability envelopes under that same deadline and fixed query protocol.

In the present model the observed filtration receives new reports and independent Bernoulli audits on every raw round. The next law may depend on the previously observed history. The audit count is random and interleaved with the report sequence. The false-alarm event is a single event over an unbounded horizon, and every alternative must alarm almost surely. [2, Appendix F.4] pads a committed pending set to a supplied fixed upper bound, and Appendix P.1 pads unused queries to a fixed \(k\). Both preserve the terminal experiment. A bound at one terminal time might bound the chance of an alarm by that time after establishing an experiment comparison, but it supplies no common causal rule satisfying all alarm-time constraints. In particular the single Gaussian input of Theorem 2 cannot identify the running maximum in (15) or the expected cost of the first-audit race in (18). [2, §9] specifies the scope with fixed gap, positive size and query count, and leaves vanishing gap, vanishing size, growing query count and repeated error control open. The same high-level source distinction between native reports and audited outcomes motivates both experiments.

[3, Theorem 4 and §5] use targeted reward recovery to shrink a joint off-policy identification region and policy contrast width under common Markov reward completions. This estimand and its audit allocation differ from a false-alarm-constrained stopping time. [4, Appendix B.4] already uses previously known counts to adjust decision boundaries in finite-population auditing without replacement. Its time variable counts inspected items sampled from a fixed population. [5, §5.3] gives the classical exponential-martingale method for first passage of Brownian motion. The exponential root in (19) is its discrete killed-score counterpart. Theorem 5 also requires a finite-sample lower bound for all rules and a comparison to a single legal rule on the full adaptive family.

## 10. Scope and reproducibility

Theorems 1–3 give the critical and neighboring mean stopping-time regimes. Theorem 4 determines the locally minimax survival curve for the moving-confidence transition and proves a first-order law for every expected-optimal family under an iid hard alternative. Theorem 5 gives a different, fixed-confidence constant on the square-root gap scale. A second-order expansion for the minimax expected stopping time in Theorem 3 remains open. The results retain the original fixed-\(a\) information theorem of [1].

The historical code checks exact rational foreground bounds and the transition expression (9). The formulas for the limiting variance and the atom examples are independently checkable directly. The binomial-to-Poisson, stopped-likelihood and uniform-error arguments are proved in the text. [Historical exact checker](evidence/code/verify_exact.py) · [Pinned nearest-source record](evidence/SOURCES.md)

## References

[1] earlier research manuscript. *Sparse Audits under Adversarial Missingness: Sharp information asymptotics and the statistical cost of discarding provenance*. 24 November 2026, §§7–8 and 10. Fixed public version

[2] Anonymous ICLR 2027 submission 24926. *How Many More Labels Are Needed? Minimax Evaluation under Selective Labels*. OpenReview forum \(\texttt{GbjWLX2uUE}\). The pinned corpus revision is \(\texttt{4c9e09931a7814d7500630ffd064b74f1c01bcf3}\), with the original OpenReview note and complete 54-page PDF text. [OpenReview](https://openreview.net/forum?id=GbjWLX2uUE) · [Pinned note archive](https://huggingface.co/datasets/latkes/ai-research-index-iclr-openreview/blob/4c9e09931a7814d7500630ffd064b74f1c01bcf3/raw/iclr2027.jsonl) · [Pinned full-text archive](https://huggingface.co/datasets/latkes/ai-research-index-iclr-openreview/blob/4c9e09931a7814d7500630ffd064b74f1c01bcf3/extracted_text/iclr-2027/iclr-2027.jsonl)

[3] Anonymous ICLR 2027 submission. *Audited Partial Identification for Off-Policy Evaluation under Nonignorable Feedback*. OpenReview forum \(\texttt{MXy9kwESeo}\). The same corpus revision preserves its complete 47-page text. [OpenReview](https://openreview.net/forum?id=MXy9kwESeo) · [Pinned full-text archive](https://huggingface.co/datasets/latkes/ai-research-index-iclr-openreview/blob/4c9e09931a7814d7500630ffd064b74f1c01bcf3/extracted_text/iclr-2027/iclr-2027.jsonl)

[4] M. Kato and K. Nakagawa. *Sequential Audit Sampling for Finite Populations with Exact and Simulation-based Guarantee*. Appendix B.4. [arXiv:2604.06116v2](https://arxiv.org/pdf/2604.06116v2)

[5] S. Lalley. *Brownian Motion*. §5.3, Example 2 and Exercise 8. [Lecture notes](https://galton.uchicago.edu/~lalley/Courses/385/BrownianMotion.pdf#page=25)
