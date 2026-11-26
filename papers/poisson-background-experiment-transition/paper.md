# Sharp deficiency and the size of least-favourable restrictions for Poisson signals

## Abstract

A Poisson count with a large known background can convey bounded information about a signal whose clean count becomes arbitrarily informative. We determine the first-order gap between the one-sided deficiency and one. Let \(n\) be the largest clean intensity, \(A_n\) the source background mean, and \(B_n\) the source exposure multiplier. If \(A_n^{-1/2}=o(\sqrt{\log n/n})\) and \(B_n n/\sqrt{A_n}\to\kappa\in[0,\infty)\), the gap is \(c_\kappa\sqrt{\log n/n}(1+o(1))\). The latter ratio measures the source signal range in background standard deviations. A scalar boundary-value equation gives \(c_\kappa\), and its solution specifies an asymptotically attaining simulator and a matching prior bound. More generally the source can follow a nondecreasing continuously differentiable path of exponential tilts of a positive continuous density on \(\mathbb R\), with its moment-generating function finite on an open interval containing the tilt range. The worst deficiency on at most \(k\) parameter states tends to \(1-1/k\) for each fixed \(k\). To recover the full deficiency within a prescribed multiple of its gap from one, the number of states must grow on the order of \(\sqrt{n/\log n}\). A separate finite-intensity example has an exact two-state least-favourable restriction with one interior intensity.

## Guide for readers

Imagine measuring a weak signal on top of a large, known background. A simulator sees one noisy count and tries to produce a count distributed as if it came from the clean signal. The deficiency is the smallest worst-case discrepancy that any simulator can achieve. A deficiency near one means that even the best simulator has very little uniform overlap with the clean count law.

The main theorem tells us how much overlap remains to first order as the largest clean intensity grows. Using the square root of intensity makes the natural comparison windows approximately equal in width. Section 2 constructs a simulator whose local output density is equal at every interior signal level and a prior that matches it in the limit. Sections 3 and 4 turn that calculation into matching bounds for Poisson counts, including signals close to zero. The finite-state results explain how densely the signal interval must be sampled to detect the same discrepancy.

## 1. Poisson comparison

For experiments \(F=(F_t)\) and \(E=(E_t)\) indexed by the same set, write
\[
 \delta(F,E)=\inf_K\sup_t\|KF_t-E_t\|_{\mathrm{TV}},
 \qquad \|Q-P\|_{\mathrm{TV}}=\sup_A |Q(A)-P(A)| .
\]
The infimum runs over all parameter-independent Markov kernels. For a subset \(S\) of the parameter space let \(\delta_S(F,E)\) be the same infimum with the supremum over \(S\). The kernel may depend on \(S\). Fix \(t\in[0,1]\) and consider
\[
 E^{(n)}_t=\operatorname{Pois}(nt^2),\qquad
 F^{(n)}_t=\operatorname{Pois}(A_n+B_nnt^2),\qquad
 \ell_n=\sqrt{\frac{\log n}{n}}.
\]
Here \(u=nt^2\) is the clean intensity, \(A_n>0\) is a known background, and \(B_n\ge0\) is a known exposure multiplier in the source.

**Theorem 1.** Suppose \(n\to\infty\), \(A_n^{-1/2}=o(\ell_n)\), and \(B_n n/\sqrt{A_n}\to\kappa\in[0,\infty)\). Then
\[
 1-\delta(F^{(n)},E^{(n)})\sim c_\kappa\,\ell_n.
 \tag{1}
\]
Writing \(\phi,\Phi\) for the standard normal density and distribution function, \(c_\kappa\) is the unique \(c\ge1\) for which the equation
\[
 U'(t)=c-2\kappa t\,\phi(\Phi^{-1}(U(t))),\qquad U(0)=0
 \tag{2}
\]
reaches \(U(1)=1\) and has \(0\lt U(t)\lt 1\) for \(0\lt t\lt 1\). The density term is interpreted as zero at 0 and 1. In particular, \(c_0=1\) and \(1\lt c_\kappa\le1+\kappa/\sqrt{2\pi}\) for \(\kappa>0\). If \(B_n\equiv B>0\), the condition on \(A_n^{-1/2}\) follows from the boundedness of \(B_n n/\sqrt{A_n}\).

For a fixed integer \(k\ge1\), define \(\delta_{n,k}=\sup_{1\le |S|\le k}\delta_S(F^{(n)},E^{(n)})\). Then \(\delta_{n,k}\to1-1/k\). For each fixed \(\alpha>0\), let \(m_n(\alpha)\) be the smallest cardinality of a finite \(S\subset[0,1]\) for which
\[
 \delta(F^{(n)},E^{(n)})-\delta_S(F^{(n)},E^{(n)})\le \alpha\ell_n .
 \tag{3}
\]
For all sufficiently large \(n\) such a set exists. Moreover
\[
 \liminf_{n\to\infty} m_n(\alpha)\ell_n\ge \frac{1}{c_\kappa+\alpha},
 \qquad
 \limsup_{n\to\infty} m_n(\alpha)\ell_n\lt \infty .
 \tag{4}
\]
Thus no uniform finite cardinality can capture the full deficiency in this affine Poisson class. Equations (1) and (4) concern the direction from the background count to the clean count, and the regime of bounded \(B_n n/\sqrt{A_n}\).

## 2. A scalar construction for smooth source experiments

The constant arises from a construction that applies beyond the Gaussian source. Let \(g\) be a strictly positive continuous probability density on \(\mathbb R\). Suppose its moment generating function is finite on an open interval containing the range of a nondecreasing \(C^1\) function \(\eta:[0,1]\to\mathbb R\). Set
\[
 f_t(x)=g(x)e^{\eta(t)x-b(\eta(t))},\qquad b(a)=\log\int g(x)e^{ax}\,dx.
\]
Write \(F_t(x)\) for the distribution function, \(Q_t(u)\) for its quantile, and \(\bar x_t=b'(\eta(t))\) for the mean. Define for \(0\lt u\lt 1\)
\[
 H_t(u)=\int_{-\infty}^{Q_t(u)}(\bar x_t-x)f_t(x)\,dx .
\]
This is positive in the interior, since the mean of the lower part of a distribution with positive density is strictly less than the full mean. Extend \(H_t\) by zero for \(u\notin(0,1)\).

**Proposition 2.** There is a unique \(c\ge1\) such that the solution of
\[
 U'(t)=c-\eta'(t)H_t(U(t)),\qquad U(0)=0
 \tag{5}
\]
satisfies \(U(1)=1\). The function \(M(t)=Q_t(U(t))\) on \(0\lt t\lt 1\) is increasing, maps that interval onto \(\mathbb R\), and satisfies
\[
 M'(t)f_t(M(t))=c.
 \tag{6}
\]
There is a continuous positive density \(w(t)\) on \([0,1]\) such that
\[
 w(M^{-1}(x))\,f_{M^{-1}(x)}(x)=\sup_{0\le t\le1}w(t) f_t(x),
 \qquad
 \int_{\mathbb R}\sup_{0\le t\le1} w(t) f_t(x)\,dx=c.
 \tag{7}
\]
The law under \(f_r\) of \(T(X)=M^{-1}(X)\) has density
\[
 \rho_r(t)=M'(t)f_r(M(t)),\qquad \rho_t(t)=c .
 \tag{8}
\]

**Proof.** Exponential moments are uniformly bounded on the parameter path for some positive exponential rate in both tails. It follows that \(H\) is jointly continuous on \([0,1]\times\mathbb R\), bounded, and uniformly small near \(u=0,1\). In the interior \(\partial_u H_t(u)=\bar x_t-Q_t(u)\). The quantile is continuous and locally bounded for \(t\in[0,1]\) and \(u\in(0,1)\), by strict positivity and continuity of the distribution functions. The exponential tail bounds also give \(|Q_t(u)|\le C(1+|\log u|+|\log(1-u)|)\).

For each \(c\ge1\) the continuous bounded right side of (5) gives a solution on \([0,1]\). Near \(u=0\) or \(1\) its derivative is positive and at least \(1/2\) uniformly in \(t\). Two solutions starting at zero satisfy \(u\ge t/2\) for small positive \(t\), with the quantile bound giving a uniform Lipschitz coefficient \(C(1+|\log t|)\) along the interval between them. Its integral near zero is finite, so Gronwall's inequality gives uniqueness there. Ordinary local uniqueness applies away from the boundary values. A solution stays positive after time zero and, after reaching one, increases linearly, since the extended \(H\) vanishes above one. These facts give uniqueness up to time one. Bounded derivatives, subsequence compactness and uniqueness give continuous dependence at time one on \(c\). For \(c'>c\) the corresponding solutions satisfy \(U_{c'}(t)>U_c(t)\) for \(t>0\). It holds initially by their initial derivatives, and at a putative first crossing their derivative difference would be \(c'-c>0\). At \(c=1\) the terminal value is at most one, since \(H\ge0\). At \(c=1+\sup_{t,u}\eta'(t)H_t(u)\) the derivative is at least one. This proves existence and uniqueness of the desired \(c\). For this solution, \(U(t)/t\to c\) and \((1-U(t))/(1-t)\to c\) at the respective endpoints.

Differentiating \(U(t)=F_t(M(t))\), the partial \(t\)-derivative of \(F_t(x)\) at \(x=M(t)\) is \(-\eta'(t)H_t(U(t))\). Equation (6) follows. It also gives \(M'>0\), and the limits of the quantiles are \(-\infty\) and \(+\infty\) at the respective endpoints. Define
\[
 w(t)=\frac{\exp\{-\int_0^t\eta'(v)(M(v)-\bar x_v)\,dv\}}
 {\int_0^1\exp\{-\int_0^s\eta'(v)(M(v)-\bar x_v)\,dv\}\,ds}.
 \tag{9}
\]
The quantile bound and the endpoint behaviour of \(U\) make the integrand integrable. For fixed \(x\), the derivative of \(\log(w(t)f_t(x))\) is \(\eta'(t)(x-M(t))\). The function therefore attains its maximum at \(M^{-1}(x)\), also if \(\eta\) is locally flat. Changing variables in the integral of the maximum and using (6) gives (7). The same change of variables gives (8). \(\square\)

The Gaussian experiment \(N(\kappa t^2,1)\) has \(g=\phi\) and \(\eta(t)=\kappa t^2\). Integration of the centered standard normal density gives \(H_t(u)=\phi(\Phi^{-1}(u))\). Integrating (5) over \(t\) yields
\[
 c_\kappa=1+\int_0^1 2\kappa t\,\phi(\Phi^{-1}(U(t)))\,dt,
\]
giving the bounds in Theorem 1. The same construction for \(N(a t,1)\), \(a\ge0\), gives the simpler formula \(1=\int_0^1[c-a\phi(\Phi^{-1}(u))]^{-1}du\) with \(c>a/\sqrt{2\pi}\). Indeed a solution to the autonomous equation that reaches one cannot cross an interior zero of its right side. The formula follows by separation of variables.

## 3. Sharp simulation with a Poisson target

**Theorem 3.** Fix a source family \(f_t\) as in Proposition 2. With \(f_t\) in place of \(F_t^{(n)}\), the conclusions (1), (3), and (4), and the fixed-\(k\) limit in Theorem 1, hold with the constant \(c\) from (5). The same conclusions hold for a sequence of source densities \(f_{n,t}\) satisfying
\[
 \int_{\mathbb R}\sup_t |f_{n,t}(x)-f_t(x)|\,dx\longrightarrow0,\qquad
 \sup_{t,\;x\in J}|f_{n,t}(x)-f_t(x)|\longrightarrow0
 \quad\text{for every compact }J\subset\mathbb R .
 \tag{10}
\]
All the families in (10) are assumed jointly measurable. No rate of convergence in (10) is needed.

**Proof of the upper bound on overlap.** For a simulator \(K\), let \(q_t\) be its count output distribution and \(p_{n,t}\) the target mass function. Its overlap at \(t\) is
\[
 O_t(K)=\sum_{j\ge0}\min(p_{n,t}(j),q_t(j)).
\]
Thus \(1-\delta=\sup_K\inf_t O_t(K)\). For \(\varepsilon>0\), put
\[
 D_{n,t}=\{j:|\sqrt{j/n}-t|\le (1+\varepsilon)\ell_n/2\}.
\]
On any fixed \([d,1-d]\subset(0,1)\), the target probability outside \(D_{n,t}\) is \(o(\ell_n)\) uniformly. To see this, if \(Y\sim\operatorname{Pois}(\lambda)\) with \(\lambda=nt^2\), the two boundary deviations in the count coordinate have size at least \((1+\varepsilon-o(1))\sqrt{\lambda\log n}\). The exponential Markov bound for a Poisson count at a deviation \(z=o(\lambda)\) has exponent \(-z^2(1+O(z/\lambda))/(2\lambda)\), by Taylor expansion of the Poisson rate function at its mean. Here \(\lambda\ge nd^2\), so both tails are \(o(\ell_n)\).

Take \(w\) from (9), and put \(W_d=\int_d^{1-d}w(t)\,dt\). Nonnegativity and the bound \(O_t(K)\le (Kf_{n,t})(D_{n,t})+o(\ell_n)\) yield
\[
 \begin{split}
 W_d\inf_t O_t(K)
 &\le \sum_{j\ge0}\int_{\mathbb R} K(x,\{j\})
       \int_d^{1-d}\mathbf 1_{\{j\in D_{n,t}\}}\,w(t)f_{n,t}(x)\,dt\,dx
       +o(\ell_n)\\
 &\le (1+\varepsilon)\ell_n\int_{\mathbb R}\sup_t w(t)f_{n,t}(x)\,dx +o(\ell_n).
 \end{split}
 \tag{11}
\]
In the last step, the band at a given \(j\) has length at most \((1+\varepsilon)\ell_n\) in \(t\), and the row probabilities sum to one. The integral converges to \(c\) by (7) and (10). Send \(n\to\infty\), then \(d,\varepsilon\downarrow0\) to get the upper bound in (1).

**Proof of the lower bound on overlap.** Let \(I_{n,j}=[\sqrt{j/n},\sqrt{(j+1)/n})\). Fix small \(d>0\), \(0\lt \varepsilon\lt 1\), and let \(L_n=(\log n)^3\). We will use target counts whose bins are wholly contained in the narrower band
\[
 [t-(1-\varepsilon)\ell_n/2,\ t+(1-\varepsilon)\ell_n/2].
 \tag{12}
\]
Uniformly for \(L_n\le\lambda=nt^2\le n\), the eligible bins have total length \((1-\varepsilon)\ell_n+o(\ell_n)\). The left end of the band is positive for large \(n\). Each bin meeting it has length \(O((n\lambda)^{-1/2})=o(\ell_n)\), so at most the two end bins are lost. Also
\[
 \inf_{\substack{L_n\le nt^2\le n\\ I_{n,j}\text{ contained in }(12)}}
 \frac{p_{n,t}(j)}{|I_{n,j}|}\ \longrightarrow\ \infty .
 \tag{13}
\]
In fact, such indices satisfy
\[
 \frac{|j-\lambda|}{\sqrt\lambda}
 \le (1-\varepsilon)\sqrt{\log n}+O\!\left(\frac{\log n}{\sqrt\lambda}\right),
 \qquad j/\lambda\longrightarrow1
\]
uniformly. Stirling's formula and \(j\log(j/\lambda)-j+\lambda=(j-\lambda)^2(1+o(1))/(2\lambda)\) give \(p_{n,t}(j)\ge C_\varepsilon\lambda^{-1/2}n^{-(1-\varepsilon/2)^2/2}\) for all sufficiently large \(n\). Division by the bin length proves (13).

Use the source observation to output \(\lfloor nT(X)^2\rfloor\) with \(T=M^{-1}\), reserving a small probability for two additional outputs. First, take the pushforward, by \(s\mapsto\lfloor ns^2\rfloor\), of the subprobability density \(c\) on \([0,2d]\cup[1-2d,1+2d]\). This uses mass \(6cd\) for \(d\lt 1/4\). Second, assign mass \(c\ell_n\) to every integer from 0 to \(\lceil 2L_n\rceil\), using total mass \(o(1)\). Use the main rule with the remaining probability \(1-6cd-o(1)>0\) for fixed small \(d\). Both reserves are parameter independent.

For \(d\le t\le1-d\), on every eligible bin the density of \(T(X)\) for the main rule is at least \(c-o(1)\) uniformly. Indeed, it is \(M'(s)f_{n,t}(M(s))\), converges uniformly to \(M'(s)f_t(M(s))\) on a fixed compact subinterval of \(0\lt s\lt 1\), and (8) gives the diagonal value \(c\). Uniform continuity and \(|s-t|\le(1-\varepsilon)\ell_n/2\) finish the estimate. Equation (13) shows that each eligible bin contributes at least \((1-6cd-o(1))(c-o(1))\) times its length to the overlap. If \(t\le d\) or \(t\ge1-d\) and \(\lambda\ge L_n\), the eligible bins lie in the first reserve for large \(n\), so each contributes at least \(c\) times its length by (13). If \(\lambda\le L_n\), the target has probability at least \(1/2\) on the first \(\lceil 2L_n\rceil+1\) integers by Markov's inequality. The second reserve guarantees overlap at least \(c\ell_n\) there, since \(\sum_j\min(a_j,h)\ge\min(\sum_j a_j,h)\) for nonnegative \(a_j,h\). Thus the infimum of the overlap is at least
\[
 (1-6cd-o(1))(c-o(1))(1-\varepsilon)\ell_n
\]
up to an \(o(\ell_n)\) bin error. Sending \(d,\varepsilon\downarrow0\) gives the lower bound in (1), including the degenerate clean state at zero.

**Proof of the restriction statements.** For \(k\) states, a constant simulator using the uniform mixture of their \(k\) target laws has overlap at least \(1/k\) at every state. This bounds \(\delta_{n,k}\) by \(1-1/k\). For the matching limit, choose \(k\) states with \(t_i=t_0+i n^{-1/4}\) for a fixed \(0\lt t_0\lt 1\). For each fixed \(k\), their source laws approach each other in total variation by (10) and continuity of \(f_t\) in \(L^1\). Their targets concentrate on pairwise disjoint count sets \(D_{n,t_i}\), with errors \(o(1)\), by the preceding tail bound. For every kernel the average probability of outputting in those \(k\) sets is at most \(1/k+o(1)\): replace its input law at each selected state by the same law at \(t_0\), using contraction of total variation, and sum the resulting probabilities of disjoint events. The average overlap is at most \(1/k+o(1)\). This proves the fixed-\(k\) claim.

For (4), a set of \(k\) states obeying (3) must satisfy \(1/k\le 1-\delta+\alpha\ell_n\), giving the lower bound. For the upper bound repeat (11) on a midpoint grid in \([d,1-d]\) of spacing \(h_n\le b\ell_n\), taking the mass at each midpoint \(t_i\) equal to \(h_n w(t_i)\). Choose equal subintervals with the smallest integer number making the spacing at most \(b\ell_n\), so the number is \(O(1/\ell_n)\). Total mass tends to \(W_d\). At each count \(j\), the number of admissible grid points times \(h_n\) is at most \((1+\varepsilon)\ell_n+h_n\). The same estimate now gives
\[
 1-\delta_S\le \bigl(c(1+\varepsilon+b)/W_d+o(1)\bigr)\ell_n .
\]
Choose fixed \(d,\varepsilon,b>0\) sufficiently small that the coefficient is strictly below \(c+\alpha\). Together with (1) this yields (3) and the upper bound in (4). \(\square\)

## 4. Transfer to the Poisson source

Set \(\kappa_n=B_n n/\sqrt{A_n}\). Adding independent uniform noise on \((-1/2,1/2)\) to a Poisson source count, then centering at \(A_n\) and scaling by \(\sqrt{A_n}\), produces a law within \(O(A_n^{-1/2})\) in total variation of
\[
 N\!\left(\kappa_n t^2,\,1+\frac{\kappa_n t^2}{\sqrt{A_n}}\right)
\]
uniformly in \(t\), by Ouimet's jittered Poisson bound (Theorems 3.1 and 3.2). Replacing the variance by one adds \(O(A_n^{-1/2})\), by the explicit normal relative entropy and Pinsker's inequality, since \(\kappa_n\) is bounded. Rounding the inverse affine transform to the nearest nonnegative integer exactly inverts jittering on the original count, so the reverse approximation has the same total variation bound. Composing either kernel with any simulator into \(E^{(n)}\) proves that its optimal deficiency changes by at most \(O(A_n^{-1/2})=o(\ell_n)\), for the full parameter set and for every restriction. The normal densities \(f_{n,t}\) satisfy (10) with \(f_t\) of \(N(\kappa t^2,1)\), by uniform continuity on compacts and an integrable Gaussian tail envelope for bounded means. Applying Theorem 3 proves all assertions of Theorem 1. For (3), choose the grid in the proof with strict margin in its coefficient to absorb the transfer error.

## 5. Relation to experiment comparison and small-tolerance estimation

Ouimet proves Poisson-to-normal and normal-to-Poisson approximation when the mean is large. This comparison supplies the source approximation in Section 4. The clean experiment has a degenerate endpoint and ranges over means from zero to \(n\). Its effect on the leading deficiency is obtained directly from the Poisson masses and the two simulator reserves in Section 3. [Ouimet, Journal of Mathematical Analysis and Applications 499(1), 125033, 2021](https://doi.org/10.1016/j.jmaa.2021.125033) · [Author text](https://arxiv.org/abs/2010.05146).

Axelrod, Garg, Han, Sharan and Valiant formulate sample amplification in Le Cam's total variation simulation framework. Their §3 and Example A.14 give rate-optimal product-Poisson amplification by combining sufficient statistics and a learned increment. Their simulator appends observations from the same unknown law. The source here has a competing background. The leading overlap, its matching prior, and the number of parameter states required to certify it are the subject of (1)–(4). [Axelrod et al., Annals of Statistics 52(6), 2024, DOI 10.1214/24-AOS2444](https://doi.org/10.1214/24-AOS2444) · [Author text, §3 and Example A.14](https://arxiv.org/html/2201.04315v2).

Zeytinoglu and Mintz study optimal fixed-size confidence procedures for a bounded location parameter under monotone likelihood ratios. Kamberova and Mintz develop equalizer and Bayes constructions under fixed-tolerance zero–one loss for a wider class of bounded location families. Our comparison with the 1984 paper uses its accessible abstract. The diagonal identity (8) concerns shrinking tolerance and a path of exponential tilts. For example, if the loss is \(\mathbf1_{\{|\hat t-t|>h\}}\) in the source experiment of Proposition 2, the maximal minimax success probability is \(2ch(1+o(1))\) as \(h\downarrow0\). To verify this, prior averaging over \(w(t)\,dt\) bounds the success probability by \(2h\int\sup_t w(t)f_t(x)\,dx=2ch\). For the reverse bound use \(T=M^{-1}\) and reserve a parameter-independent density \(c\) on \([-d,2d]\cup[1-2d,1+d]\), of mass \(6cd\). On the interior \([d,1-d]\), the main rule has density \(c+o(1)\) uniformly on the success window by (8), and for the two boundary strips the reserve covers the full window for small \(h\). Let \(h\downarrow0\) then \(d\downarrow0\). Clipping estimates to the parameter interval can only increase success if that action space is required. In (1), the window size comes from the intersection of the simulated density and the target count mass. The Poisson tail contributes the extra \(\sqrt{\log n}\) factor. [Zeytinoglu and Mintz, Annals of Statistics 12(3), 1984](https://doi.org/10.1214/aos/1176346713) · [Kamberova and Mintz, Journal of Statistical Planning and Inference 79(2), 205–221, 1999](https://doi.org/10.1016/S0378-3758(98)00237-7).

The finite example in the appendix has a two-state least-favourable restriction that includes a strict interior state. Equations (3)–(4) quantify a contrasting phenomenon elsewhere in the same affine count family. Binary trade-off comparisons and ordered thinning remain applicable to their respective restrictions and parameter regimes. [Laourine and Wagner, IEEE Transactions on Information Theory 58(12), 2012, Lemma 1](https://doi.org/10.1109/TIT.2012.2217191) · [Pandey, Maleki and Kulkarni, Sections 2.1 and 4, Lemma 21 and Theorem 13](https://arxiv.org/abs/2512.00734v1).

## Appendix. Exact comparison on a finite-intensity interval

To keep the two-state result in the same notation as the main theorem, parameterize here by the clean intensity (u) itself. The argument uses a finite rational certificate for strict inequalities between smooth functions on a compact interval.

### A.1. Statement

Write $E_u=\operatorname{Pois}(u)$ and $F_u=\operatorname{Pois}(2+2u)$. The directional deficiency is
\[
\delta(F,E)=\inf_K\sup_{0\le u\le1}\sup_{A\subseteq\mathbb Z_{\ge0}}
              |(KF_u)(A)-E_u(A)|,
\]
where $K$ ranges over all parameter-independent Markov kernels between count observations. For $\gamma\in[0,1]$ put
\[
\lambda(u)=2+2u,\qquad
h_\gamma(u)=1-e^{-\lambda(u)}
\left(\sum_{j=0}^3\frac{\lambda(u)^j}{j!}+\gamma\frac{\lambda(u)^4}{24}\right),
\qquad
f_\gamma(u)=1-e^{-u}-h_\gamma(u).
\]

**Theorem.** There is a unique $\gamma_*\in(266/1000,267/1000)$ solving
\[
h_{\gamma_*}(0)=\max_{u\in[0,1]} f_{\gamma_*}(u).
\tag{A.1}
\]
The maximum on the right is attained at a unique $s_*\in(909/1000,910/1000)$. The deficiency is exactly $\delta(F,E)=h_{\gamma_*}(0)$, approximately $0.11879834$. The restriction to $\{0,s_*\}$ has this same deficiency, and the restriction to $\{0,1\}$ has strictly smaller deficiency.

A minimax kernel outputs zero for input $x\le3$, outputs zero with probability $\gamma_*$ for $x=4$, and has positive output otherwise. Conditional on a positive output, it gives one with probability $7/10$ and two with probability $3/10$.

### A.2. The threshold and the lower bound

Differentiation gives
\[
h'_\gamma(u)=2e^{-\lambda(u)}
 \left((1-\gamma)\frac{\lambda(u)^3}{6}
             +\gamma\frac{\lambda(u)^4}{24}\right).
\]
The ratio $h'_\gamma(u)/e^{-u}$ has strictly positive logarithmic derivative
\[
-1+\frac6{\lambda(u)}+\frac{2\gamma}{4(1-\gamma)+\gamma\lambda(u)}>0
\quad(0\le u\le1).
\]
Thus, when $f_\gamma'$ changes sign from positive to negative, the unique stationary point maximizes $f_\gamma$. Write $l=909/1000$ and $r=910/1000$. At both endpoints of the specified $\gamma$ interval, $f_\gamma'(l)>0>f_\gamma'(r)$. For $\gamma=266/1000$,
\[
f_\gamma(l)+(r-l)f_\gamma'(l) \lt  h_\gamma(0).
\]
This is an upper bound on the maximum of $f_\gamma$, since its positive derivative on $[l,r]$ is at most $f_\gamma'(l)$ by the ratio monotonicity. For $\gamma=267/1000$, $f_\gamma(r)>h_\gamma(0)$. Appendix A.4 verifies these strict inequalities. The derivative signs extend to the entire $\gamma$ interval by affinity. The maximum of $f_\gamma$ is continuous and nondecreasing in $\gamma$ while $h_\gamma(0)$ is strictly decreasing. These facts give (A.1) and the stated bracket.

Let $s=s_*$ and $D=h_{\gamma_*}(0)$. The probability that the proposed kernel gives a positive count at $u$ is $h_{\gamma_*}(u)$. On the pair $(F_0,F_s)$ the likelihood ratio at $x$ is
\[
L(x)=e^{-2s}(1+s)^x .
\]
It is strictly increasing, so the randomized testing rule $k_*$ with output probability $0$ up to $3$, $1-\gamma_*$ at $4$, and $1$ from $5$ onwards maximizes $E_{F_s} k$ subject to $E_{F_0}k\le D$. Indeed, $(F_s(x)-L(4)F_0(x))(k(x)-k_*(x))\le0$ for every $x$, and summing proves the claim. A kernel with error strictly below $D$ at both states, applied to the event of positive output, would give a rule with $E_{F_0}k \lt  D$ and $E_{F_s}k>1-e^{-s}-D=h_{\gamma_*}(s)$. Therefore even the pair has deficiency at least $D$.

### A.3. Continuous upper bound

Let $h=h_{\gamma_*}$ and $p_j(u)=e^{-u}u^j/j!$. The proposed output law has vector $(1-h,7h/10,3h/10)$ on $\{0,1,2\}$. Total variation is the largest signed surplus of output over target on any subset of these three indices. For $\{0\}$ it is $f_{\gamma_*}(u)\le D$. The nontrivial surplus on $\{1,2\}$ is $h-p_1-p_2$. On $0\le u\le1/50$, we have
\[
h'(u)\le 2e^{-2}(51/25)^3/6 \lt  2/5,\qquad
(p_1+p_2)'(u)=e^{-u}(1-u^2/2)>9/10.
\]
Consequently this surplus is at most its value $D$ at zero throughout that interval.

For all five other nonempty subsets and for $\{1,2\}$ on $[1/50,1]$, a finite rational certificate gives a uniform bound strictly below $1187/10000 \lt   D$. An event probability for the target is 1-Lipschitz in $u$ by the independent-increment coupling. The derivative of $h$ is at most 2, so all the surpluses are 3-Lipschitz. They are affine in $\gamma$ at fixed $u$. It therefore suffices at both rational endpoints of the $\gamma$ interval to verify a bound of $1187/10000-3/1000$ on the mesh $u=j/1000$, starting at $j=20$ for $\{1,2\}$. Appendix A.4 verifies precisely those inequalities. This proves the upper bound at every real $u\in[0,1]$.

On $\{0,1\}$, $f_{\gamma_*}(1) \lt  D$ by strict maximization at $s_*$. Increase $\gamma_*$ slightly, keeping $0 \lt  \gamma \lt  1$, so $h_\gamma(0) \lt  D$ and $|f_\gamma(1)| \lt  D$. The second strict inequality holds at $\gamma_*$ initially because $0 \lt  f_{\gamma_*}(1) \lt  D$ (also verified in Appendix A.4). Replace the conditional positive output distribution by $E_1$ conditioned on positivity. At zero the error is then $h_\gamma(0)$, and at one it equals $|f_\gamma(1)|$. Both are strictly smaller than $D$.

### A.4. Rational certificate

For nonnegative rational $x$, use the bounds
\[
\sum_{k=0}^{33}\frac{(-x)^k}{k!}\le e^{-x}
   \le \sum_{k=0}^{32}\frac{(-x)^k}{k!}.
\]
Taylor's theorem gives both signs, including equality at zero. Generate enclosures of $h_\gamma$, $f_\gamma$ and $f'_\gamma$ by substitution with sign-aware interval endpoints. The accompanying rational certificate `check-finite.py` makes the rational tests in Appendices A.2 and A.3. Its procedure can be reproduced directly from the following pseudocode. It uses only exact integer and rational arithmetic.

1. At both $\gamma$ endpoints test the signs of $f_\gamma'(l)$, $f_\gamma'(r)$, and $f_\gamma(1)$ via their enclosures. Test the two sign inequalities for (A.1) with upper bounds for left sides in the less-than comparisons and lower bounds for right sides.
2. Test $h_{267/1000}(0)>1187/10000$ and the two derivative inequalities in Appendix A.3 with the enclosures for $e^{-2}$ and $e^{-1/50}$.
3. For each $j=0,\ldots,1000$ at each endpoint $\gamma$, form an upper bound for each surplus by summing upper output coordinate masses and subtracting lower $p_i(j/1000)$ for included indices. For the whole set $\{0,1,2\}$ the upper output mass is one. Omit $\{0\}$ and omit $\{1,2\}$ when $j \lt  20$. Check that each upper bound plus $3/1000$ is below $1187/10000$.

The finite verification concerns inequalities within a proved continuum envelope. It avoids optimizing a discretized Markov kernel or assuming that a parameter mesh contains the worst case.

### A.5. Persistence under changes in exposure and background

Keep $E_u=\operatorname{Pois}(u)$ and put $F^{A,B}_u=\operatorname{Pois}(A+Bu)$ with $A,B>0$. There is an open neighborhood of $(A,B)=(2,2)$ on which the formula in (A.1) remains exact after replacing $\lambda(u)$ by $A+Bu$ in $h_\gamma$. The same count threshold and positive output distribution achieve it. The optimal randomization and the interior least-favourable intensity vary smoothly with $(A,B)$.

Indeed the ratio $h_\gamma'(u)/e^{-u}$ now has log derivative
\[
1-B+\frac{3B}{A+Bu}+
       \frac{\gamma B}{4(1-\gamma)+\gamma(A+Bu)}.
\]
Its minimum is strictly positive at $(2,2)$ on the compact rectangle of $u$ and $\gamma$ used above, so it remains positive nearby. The stationarity brackets and both inequalities bracketing (A.1) are strict. The latter inequalities continue to bracket the maximum: the upper proof uses only the known derivative signs and positive ratio monotonicity. The derivative inequality for $h-p_1-p_2$ on $[0,1/50]$ is also strict and uniform. In Appendix A.4 the last comparison remains strict if $3/1000$ is replaced by $4/1000$ (the rational test includes this margin). For $B \lt  3$, the surplus Lipschitz constants are at most $1+B \lt  4$. Thus finite-grid continuity and the original argument prove the full continuum upper bound throughout some neighborhood. The testing argument still applies because the likelihood ratio on $(0,s)$ is strictly increasing when $Bs>0$. Strict maximization and positivity of $f_\gamma(1)$ preserve the separation from the two endpoints.

Finally apply the implicit function theorem to $f_\gamma(s)-h_\gamma(0)=0$ and $f_\gamma'(s)=0$. The derivative of the first with respect to $\gamma$ is the sum of the positive count-four masses at intensities $A+Bs$ and $A$, and its derivative with respect to $s$ is zero there. The derivative of the second with respect to $s$ is $f_\gamma''(s) \lt  0$ by strict ratio monotonicity. The Jacobian in $(\gamma,s)$ is therefore nonsingular.

### A.6. Relation to binary Poisson comparison

Thinning plus independent Poisson superposition is a classical comparison for ordered signal and background parameters, as in Laourine and Wagner, Lemma 1. Binary testing characterizations of Poisson experiment comparison appear in Pandey, Maleki and Kulkarni, Sections 2.1 and 4, Lemma 21 and Theorem 13. Here the signal increase and background increase point in opposite directions, and the deficiency is positive. A new issue is to justify a single kernel across a continuum of intensity values. The finite positive-output distribution makes this possible, while the worst-state proof selects an interior intensity. In a first-moment fiber on $[0,1]$, every $u$ occurs as the mean and the family can equivalently be indexed by the underlying mixing law. The pair here is the clean unit-exposure limit and the competing source with exposure multiplier two and total background mean two. The local persistence result does not classify all exposure and background regimes.

- A. Laourine and A. B. Wagner. *The degraded Poisson wiretap channel*. IEEE Transactions on Information Theory 58(12), 7073–7085 (2012). [DOI](https://doi.org/10.1109/TIT.2012.2217191)
- A. Pandey, A. Maleki and S. Kulkarni. *Infinitely divisible privacy and beyond I: resolution of the $s^2=2k$ conjecture*. Sections 2.1 and 4, Lemma 21 and Theorem 13. [Author preprint](https://arxiv.org/abs/2512.00734)
