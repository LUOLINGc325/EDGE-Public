# One-bit guessing at growing moment orders

## Optimal high-moment powers, a half-erasure solution, and finite-block phase transitions

**Research manuscript, 26 November 2026.** The paper gives converses for all one-bit helpers, an exact solution at half erasure, and finite-block comparisons of two specified helpers. Proof-assistant verification and external peer review have not been completed.

## Abstract

A helper sees independent erasures of a uniform binary word and sends one bit before the word is guessed in posterior order. We connect arbitrary helper-dependent guess orders to small-set probabilities of two source copies with a common observation. Classical reverse hypercontractivity then yields a converse for every helper: if the erasure probability is \(\varepsilon\), the normalized positive rank moment is bounded below, uniformly in block length \(n\) and moment order \(s\), by a constant times \(\varepsilon^n+(s+1)^{-\max\{1,(1-\varepsilon)/\varepsilon\}}\). For \(0\lt\varepsilon\le1/2\), the optimized infinite-block cost has the exact high-moment power \((1-\varepsilon)/\varepsilon\); observed majority attains this power, with its optimal logarithmic correction left open below half erasure. At \(\varepsilon=1/2\), the common-observation copies can be independent, and the greedy first-observed-bit helper is globally optimal for every nondecreasing rank loss at every finite block length. Its rank has the law of the minimum of two independent uniform ranks. Away from this exact point, greedy and observed majority have distinct joint blocklength--moment behavior. We prove a uniform greedy cost of order \(\varepsilon^n+(s+1)^{-\log_2(1/\varepsilon)}\), exact logarithmic costs when \(\log s/n\to\theta\in(0,\log2)\), and a majority-to-greedy ratio tending to \(1+((1-\varepsilon)/\varepsilon)^2e^{-c}\) when \(s/2^n-\log n\to c\). We also determine the majority high-moment constant, the low-erasure greedy dyadic-periodic coefficient, and an exact finite-prefix counterexample. No global optimality of majority or exact optimized cost away from half erasure is asserted.

## 1. Problem, context, and contribution

### 1.1 Model

Let \(X_1,\ldots,X_n\) be independent fair bits, let \(R_1,\ldots,R_n\) be independent Bernoulli variables of mean \(h=1-\varepsilon\), independent of \(X^n\), and let
\[
Y_i=\begin{cases}X_i,&R_i=1,\\ \mathrm e,&R_i=0.\end{cases}
\]
Throughout \(0\lt \varepsilon\lt 1\). A helper sends \(B\in\{0,1\}\) as a function of \(Y^n\), with independent randomization permitted. For each received bit the guesser orders all \(N=2^n\) source words by decreasing conditional probability. This ordering minimizes every positive moment simultaneously: swapping an inverted pair changes its cost by the product of a nonnegative probability difference and a nonnegative rank-cost difference.

For a helper \(H\), write \(G_H\) for this optimal rank, and define
\[
R_H(n,s;\varepsilon)
 =\frac{\mathbb E[G_H^s]}{U_{N,s}},
 \qquad
U_{N,s}=\frac1N\sum_{r=1}^N r^s,\qquad s>0. \tag{1.1}
\]
The normalization is the cost without a helper. Write
\[
 R_*(n,s;\varepsilon)=\inf_H R_H(n,s;\varepsilon),
 \qquad \gamma_s(\varepsilon)=\lim_{n\to\infty}R_*(n,s;\varepsilon).
\]
The infimum is over all one-bit helpers, with their optimal decoders; the existence of the displayed limit is proved in Theorem 9.5. Our converses also allow arbitrary decoder orders and independent shared randomization. All logarithms are natural unless a base is displayed.

For explicit achievable costs we study two helpers:

* **Greedy, \(H=\mathrm g\):** report the first nonerased bit; if all bits are erased, use a fair coin.
* **Observed majority, \(H=\mathrm m\):** report 1 when the observed number of ones exceeds the observed number of zeros, report 0 in the opposite case, and use a fair coin on ties.

For majority, replacing all fair ties by the deterministic report 0 leaves the unconditional optimal guessing moment unchanged; this fact is proved in Lemma 2.2. The same invariance holds for the all-erased tie of greedy. The rational example in Section 8 therefore uses a fully deterministic helper.

### 1.2 What is and is not new

Weinberger and Shayevitz [WS20] introduced the fixed-bit guessing-ratio problem, analyzed greedy posterior ordering over the binary erasure channel, and proved the mutual-best-response property of greedy and lexicographic decoding for \(\varepsilon\le1/2\). Their Conjecture 1 posits greedy optimality for every positive moment. Their binary-symmetric-channel majority analysis already contains a related Gaussian integral. Gaussian approximation, the method of types, endpoint Laplace asymptotics, and Mellin periodization are established methods, not inventions of this paper.

An earlier unpublished companion study [I1] addresses strict finite-prefix improvements in the high-erasure interval and a fixed-moment limit as \(\varepsilon\uparrow1\). It explicitly leaves high-moment uniformity open. We do not count its high-erasure counterexample or its all-helper converse as new results here. Our contributions include this joint dependence on \(n\) and \(s\), a converse for every helper, the optimal low-erasure high-moment power, and the exact finite-block solution at half erasure. The high-erasure part of the universal-greedy-optimality classification in Corollary 9.6 remains an attributed consequence of [I1].

The positive-rate helper problem of Graczyk, Lapidoth, Merhav, and Pfister [GLMP22] optimizes an exponential-in-\(n\) guesswork criterion with \(nR\) message bits. The fixed-one-bit normalization and growing moment order here are different scales. The unreliable-oracle model of Ardimanov, Shayevitz, and Tamo [AST20] applies noise after a function of the source has been computed; here erasure precedes the helper's computation. Our theorems do not transfer their exact oracle optimum to this setting. The small-set questions of Ordentlich, Polyanskiy, and Shayevitz [OPS20] concern correlated binary strings. We use that model as an intermediate coupling, with its correlation parameter specified explicitly.

Mossel, O'Donnell, Regev, Steif, and Sudakov [MORSS06, Corollary 3.3 and Theorem 3.4] established the reverse-hypercontractive rectangle bound used here. Their Theorems 4.1--4.2 already combine reverse hypercontractivity and majority to determine a polynomial exponent for noninteractive correlation distillation, or equivalently high moments of a noise-smoothed Boolean function. We claim neither that inequality nor that method pattern. A BEC helper may depend on the full erasure pattern, and its guessing objective involves the two posterior rank orders rather than the high norm of a single BSC-smoothed Boolean function. Lemma 7.2 and Theorem 9.5 provide the bridge for this guessing problem. The correlated pair to which we apply the classical inequality is binary--binary with correlation \(1-2\varepsilon\); it is not the original binary--ternary BEC input-output pair. The latter has zero-probability cells and a different reverse-hypercontractivity region, studied by Nair and Wang [NW17]. We do not infer equivalence of the guessing and correlation-distillation objectives merely from an algebraic match of exponents.

### 1.3 Results in one place

Put
\[
\alpha=\frac{-\log\varepsilon}{\log2},
\qquad \beta=\frac{1-\varepsilon}{\varepsilon},
\qquad
I(p)=p\log(2p)+(1-p)\log(2(1-p)).
\]
For \(1/2\le p\le1\), define
\[
K_\varepsilon(p)
=-\inf_{t\le0}\left\{
p\log(\varepsilon+h e^t)+(1-p)\log(\varepsilon+h e^{-t})
\right\}. \tag{1.2}
\]
Its endpoint values are \(K_\varepsilon(1/2)=0\) and \(K_\varepsilon(1)=-\log\varepsilon\).

**Theorem A (uniform finite-block greedy cost).** There are constants \(0\lt c_\varepsilon\le C_\varepsilon\lt \infty\), depending only on \(\varepsilon\), such that for every integer \(n\ge1\) and every real \(s\ge1\),
\[
c_\varepsilon\{\varepsilon^n+(s+1)^{-\alpha}\}
\le R_{\mathrm g}(n,s;\varepsilon)
\le C_\varepsilon\{\varepsilon^n+(s+1)^{-\alpha}\}. \tag{1.3}
\]
No lexicographic-order assumption is imposed in this theorem.

**Theorem B (exponential moment orders).** Suppose \(s_n>0\) and
\[
\frac{\log s_n}{n}\longrightarrow\theta\in(0,\log2).
\]
Let \(p_\theta\in(1/2,1)\) be the unique solution of \(I(p_\theta)=\theta\). Then
\[
-\frac1n\log R_{\mathrm g}(n,s_n;\varepsilon)\to\alpha\theta,
\qquad
-\frac1n\log R_{\mathrm m}(n,s_n;\varepsilon)\to K_\varepsilon(p_\theta).
\tag{1.4}
\]
For \(1/2\lt p\lt 1\), the function \(K_\varepsilon(p)/I(p)\) is strictly decreasing from \(\beta\) to \(\alpha\) if \(\varepsilon\lt 1/2\), strictly increasing between those endpoints if \(\varepsilon>1/2\), and identically 1 if \(\varepsilon=1/2\). Consequently
\[
\frac1n\log\frac{R_{\mathrm m}(n,s_n;\varepsilon)}
 {R_{\mathrm g}(n,s_n;\varepsilon)}
\longrightarrow
\alpha\theta-K_\varepsilon(p_\theta). \tag{1.5}
\]
This limit is negative below \(\varepsilon=1/2\), positive above it, and zero at it.

**Theorem C (last-rank transition and saturation).** Fix \(c\in\mathbb R\). If
\[
\frac{s_n}{2^n}-\log n\longrightarrow c,
\]
then
\[
\frac{R_{\mathrm g}(n,s_n;\varepsilon)}{\varepsilon^n}\to1,
\qquad
\frac{R_{\mathrm m}(n,s_n;\varepsilon)}{\varepsilon^n}
 \to 1+\beta^2e^{-c}. \tag{1.6}
\]
In particular the majority-to-greedy ratio tends to \(1+\beta^2e^{-c}\), for every fixed \(0\lt \varepsilon\lt 1\). If instead \(\log s_n/n\to\theta>\log2\), both costs are asymptotic to \(\varepsilon^n\), and their ratio tends to 1. The condition \(s_n/2^n\to\infty\) by itself is insufficient for this ratio conclusion.

Theorems A--C primarily compare two specified helpers. At \(\theta\ge\log2\), the all-erasure event also closes the optimized exponent, and above that boundary it closes the optimized relative asymptotic; see Proposition 5.1. This limited optimality statement does not extend to \(0\lt \theta\lt \log2\). Theorem C does not describe every relative-cost scaling at \(\theta=\log2\).


**Theorem D (exact half-erasure optimum).** At \(\varepsilon=1/2\), for every integer \(n\ge1\), every randomized one-bit helper and every decoder satisfy
\[
 \Pr(G_H>r)\ge\left(1-\frac rN\right)^2
             =\Pr(G_{\mathrm g}>r),\qquad r=0,\ldots,N.
 \tag{1.7}
\]
Thus greedy is globally optimal for every nondecreasing rank loss, and
\[
 R_*(n,s;1/2)
 =2+\frac1N-\frac{2}{N}
       \frac{\sum_{r=1}^N r^{s+1}}{\sum_{r=1}^N r^s},
 \qquad \gamma_s(1/2)=\frac2{s+2}. \tag{1.8}
\]
Section 7 proves the common-observation converse and attainment, and also solves a nonmodular additive-uniform observation model by the same method. Optimality here does not assert uniqueness of the optimal helper.

**Theorem E (all-helper converse and optimal high-moment power).** Put \(a_\varepsilon=\max\{2,1/\varepsilon\}\). For every integer \(n\ge1\), every real \(s>0\), and every \(0\lt\varepsilon\lt1\),
\[
 R_*(n,s;\varepsilon)\ge
 \frac{\varepsilon^n+(s+1)^{1-a_\varepsilon}}{2e+1},
 \qquad
 \gamma_s(\varepsilon)\ge
 \frac{\Gamma(a_\varepsilon+1)\Gamma(s+2)}
      {\Gamma(s+a_\varepsilon+1)}. \tag{1.9}
\]
The block limit defining \(\gamma_s\) exists. In particular, for every fixed \(0\lt\varepsilon\le1/2\),
\[
 \lim_{s\to\infty}\frac{-\log\gamma_s(\varepsilon)}{\log s}
 =\beta,\qquad
 \lim_{s\to\infty}\frac{\log(G_s(\varepsilon)/\gamma_s(\varepsilon))}{\log s}
 =\beta-\alpha. \tag{1.10}
\]
Here \(e\) in the numerical constant is the base of the natural logarithm. Section 9 proves the stronger finite rank-tail bound underlying (1.9). For \(0\lt\varepsilon\lt1/2\), the optimized logarithmic correction and leading constant remain undetermined. Theorem E does not identify the optimized joint exponent for \(0\lt\theta\lt\log2\) away from half erasure.

## 2. Ordering, ties, and the infinite-block curves

### 2.1 A common rank identity

For any binary helper define \(q(x)=\Pr(B=1\mid X^n=x)\). Because the source is uniform, output 0 is guessed by increasing \(q\), and output 1 by decreasing \(q\). If \(q_1\le\cdots\le q_N\) are the ordered values, the exact normalized cost is
\[
R_H(n,s)=
\frac{\sum_{r=1}^N\{(1-q_r)r^s+q_r(N+1-r)^s\}}
     {\sum_{r=1}^N r^s}. \tag{2.1}
\]
Equal probabilities may be ordered arbitrarily: their total cost is independent of the permutation within the tied block. If \(q_{N+1-r}=1-q_r\), (2.1) becomes
\[
R_H(n,s)=
\frac{2\sum_{r=1}^N q_r(N+1-r)^s}{\sum_{r=1}^N r^s}. \tag{2.2}
\]

**Lemma 2.1 (majority posterior order).** Majority's probability of reporting 1 is a strictly increasing function of the source Hamming weight \(k\), for every \(0\lt \varepsilon\lt 1\). Its optimal output-0 order is increasing Hamming weight, and its output-1 order is decreasing Hamming weight.

**Proof.** Represent observed signs by \(R_i(2X_i-1)\). Change one source zero to one while using the same erasure indicators and tie randomness. The observed sum increases by \(2R_i\), so the probability of report 1 cannot decrease. With positive probability the changed bit is retained and all other bits are erased; on this event the report changes from 0 to 1. Permutation invariance gives dependence only on \(k\). This also proves strict monotonicity for the deterministic tie-to-zero rule. \(\square\)

**Lemma 2.2 (tie-to-zero invariance).** Fair ties and deterministic ties to zero give the same unconditional optimal positive guessing moments for observed majority. Greedy has the analogous invariance for its all-erased tie.

**Proof.** Let \(q_>(k)=\Pr(S>0\mid k)\) and \(q_=(k)=\Pr(S=0\mid k)\), where \(S\) is the observed signed sum. Complementation gives
\[
q_>(n-k)=1-q_>(k)-q_=(k).
\]
The two message contributions attached to a Hamming block and its reflected block therefore have combined coefficient
\[
q_>(k)+1-q_>(n-k)=2q_>(k)+q_=(k),
\]
which is twice the fair-tie score. Both rules use the same Hamming blocks, each with the same rank-power sum. Summing proves equality. For greedy, changing the all-erased report adds a constant to every score; this does not change the ordering, and the resulting change in (2.1) is zero because the two rank-power sums coincide. \(\square\)

### 2.2 The majority curve

Let \(\Phi\) and \(\phi\) be the standard normal distribution and density, and define
\[
M_s(\varepsilon)=\lim_{n\to\infty}R_{\mathrm m}(n,s;\varepsilon)
\]
whenever the limit exists.

**Theorem 2.3 (majority block limit).** For each fixed \(0\lt \varepsilon\lt 1\) and \(s>0\), the limit exists and
\[
M_s(\varepsilon)=
2(s+1)\int_0^1 u^s
 \Phi\!\left(-\sqrt{\beta}\,\Phi^{-1}(u)\right)\,du. \tag{2.3}
\]

**Proof.** Set \(Z_n=n^{-1/2}\sum_i(2X_i-1)\) and
\(W_n=(hn)^{-1/2}\sum_iR_i(2X_i-1)\). The iid bivariate central limit theorem gives a centered Gaussian pair \((Z,W)\) with unit marginal variances and correlation \(\sqrt h\). For a source word of Hamming weight \(k\), its normalized rank in the increasing-weight order lies between the binomial distribution function immediately below and at \(k\). The binomial central limit theorem, uniform convergence of distribution functions to a continuous limit, and vanishing largest binomial atom imply that this rank differs from \(\Phi(Z_n)\) by \(o(1)\), uniformly over words. The reverse rank similarly differs from \(1-\Phi(Z_n)\) by \(o(1)\).

For fixed \(s\), all normalized power losses are bounded and uniformly continuous on \([0,1]\). The only discontinuity in the limiting decision is \(W=0\), a probability-zero event; the finite tie probability also vanishes by the univariate central limit theorem. Thus
\[
N^{-s}\mathbb E[G_{\mathrm m}^s]\to
\mathbb E\{\Phi(Z)^s\mathbf1_{W\lt 0}
 +(1-\Phi(Z))^s\mathbf1_{W>0}\}.
\]
Also \(U_{N,s}/N^s\to1/(s+1)\). Symmetry and the conditional Gaussian formula
\(\Pr(W\lt 0\mid Z=z)=\Phi(-\sqrt{h/\varepsilon}\,z)\) give (2.3). No interchange with a growing \(s\) has been made. \(\square\)

### 2.3 The greedy curve below half erasure

For \(u\in[0,1]\), write \(b_j(u)\) for its binary digits, choosing any consistent expansion at dyadic points, and set
\[
A_\varepsilon(u)=h\sum_{j\ge1}\varepsilon^{j-1}b_j(u). \tag{2.4}
\]
Endpoint values and the countable expansion ambiguity do not affect integrals.

For \(\varepsilon\le1/2\), the first unequal bit outweighs all later finite bits, so greedy's posterior order is lexicographic. Its exact finite score is
\[
q_n(x)=h\sum_{j=1}^n\varepsilon^{j-1}x_j+\frac{\varepsilon^n}{2}. \tag{2.5}
\]
Uniform convergence of (2.5), the uniform binary representation, and rank Riemann sums give, for fixed \(s>0\),
\[
G_s(\varepsilon):=\lim_nR_{\mathrm g}(n,s;\varepsilon)
=2(s+1)\int_0^1(1-u)^s A_\varepsilon(u)\,du. \tag{2.6}
\]
Here \(A_\varepsilon(1-u)=1-A_\varepsilon(u)\) almost everywhere has been used.

At \(\varepsilon=1/2\), \(A_{1/2}(u)=u\) almost everywhere, so
\[
G_s(1/2)=M_s(1/2)=\frac2{s+2}. \tag{2.7}
\]
This equality is an equality of infinite-block curves.

## 3. Uniform greedy bounds for every erasure probability

The proof of Theorem A must not assume lexicographic ordering when \(\varepsilon>1/2\).

**Lemma 3.1 (score tail and finite quantiles).** Let \(B_j\) be independent fair bits and
\[
V=h\sum_{j\ge1}\varepsilon^{j-1}B_j,\qquad
V_n=h\sum_{j=1}^n\varepsilon^{j-1}B_j+\varepsilon^n/2.
\]
If \(F\) is the distribution function of \(V\), then for \(0\lt x\le1\),
\[
\frac12x^{1/\alpha}\le F(x)\le h^{-1/\alpha}x^{1/\alpha}. \tag{3.1}
\]
Its increasing quantile \(Q(u)=\inf\{x:F(x)\ge u\}\), \(0\lt u\le1\), satisfies
\[
h u^\alpha\le Q(u)\le\varepsilon^{-1}u^\alpha. \tag{3.2}
\]
If \(q_{n,r}\) is the \(r\)-th smallest value of \(V_n\), with multiplicity, then
\[
\frac h2(r/N)^\alpha\le q_{n,r}
 \le(\varepsilon^{-1}+1/2)(r/N)^\alpha,\quad 1\le r\le N. \tag{3.3}
\]

**Proof.** Take \(k=\lceil\log x/\log\varepsilon\rceil\). Having the first \(k\) bits zero forces \(V\le\varepsilon^k\le x\), and its probability \(2^{-k}\) is at least \(x^{1/\alpha}/2\). If \(x\lt h\), the event \(V\le x\) forces the first
\(\lceil\log(x/h)/\log\varepsilon\rceil\) bits to be zero: any 1 in those positions contributes more than \(x\). This gives the upper bound in (3.1). For \(x\ge h\) that bound is trivial. Inversion yields (3.2).

Under the displayed coupling, \(|V-V_n|\le\varepsilon^n/2\). Distribution-function sandwiching implies the same sup-distance bound for their quantiles. In addition \(V_n\ge\varepsilon^n/2\). Hence
\[
Q_n(u)\ge\max\{Q(u)-\varepsilon^n/2,\varepsilon^n/2\}\ge Q(u)/2.
\]
At \(u=r/N\), \(Q_n(u)=q_{n,r}\) and \(N^{-\alpha}=\varepsilon^n\); the upper bound follows from \(Q_n(u)\le Q(u)+\varepsilon^n/2\). This proves (3.3), including the smallest ranks where a bare subtraction of the coupling error would be insufficient. \(\square\)

**Lemma 3.2 (discrete power kernel).** For fixed \(a>0\), uniformly over integers \(N\ge2\) and real \(s\ge1\),
\[
\frac{\sum_{r=1}^N r^a(1-(r-1)/N)^s}
     {\sum_{r=1}^N(r/N)^s}
\asymp_a 1+\left(\frac N{s+1}\right)^a. \tag{3.4}
\]

**Proof.** Write \(H=N/(s+1)\). Integral comparison gives
\[
\max(1,H)\le\sum_{r=1}^N(r/N)^s\le1+H.
\]
The numerator is at most \(\sum_{r\ge1}r^a e^{-s(r-1)/N}\), which is at most
\(C_a(1+H^{a+1})\). One way to see this is to split the positive axis into unit intervals, compare the terms with \((1+x)^a e^{-sx/N}\), and evaluate the resulting gamma integrals; \(s\) and \(s+1\) differ by at most a factor two. For the lower bound use \(r=1\) when \(H\le2\). When \(H>2\), the integers between \(H/2\) and \(H\) supply at least a fixed positive multiple of \(H\) terms of size at least a fixed multiple of \(H^a\), and the kernel is at least
\((1-1/(s+1))^s\ge e^{-1}\). Adjusting a constant covers the few endpoint rounding cases. Thus the numerator is comparable to \(1+H^{a+1}\). Finally
\((1+H^{a+1})/(1+H)\asymp_a1+H^a\). \(\square\)

**Proof of Theorem A.** Complementation makes the sorted greedy scores symmetric. Insert (3.3) into (2.2), divide numerator and denominator by \(N^s\), and apply Lemma 3.2 with \(a=\alpha\). The result is
\(R_{\mathrm g}\asymp_\varepsilon N^{-\alpha}+(s+1)^{-\alpha}\), exactly (1.3). \(\square\)

This proof also shows \(G_s(\varepsilon)\asymp_\varepsilon(s+1)^{-\alpha}\) for the infinite-block greedy curve at any erasure rate. Existence can be obtained by applying (2.1) to the quantile of \(V\), using the uniform quantile coupling and rank Riemann sums; its symmetry yields
\(G_s=2(s+1)\int_0^1(1-u)^sQ(u)\,du\).
At or below half erasure this quantile agrees almost everywhere with the binary-digit function (2.4).

## 4. The conditional error rate and its curvature

For a source word with \(k\) ones, let
\[
U\sim\operatorname{Bin}(k,h),\qquad
V\sim\operatorname{Bin}(n-k,h)
\]
be independent. Its majority error towards output 0, with fair ties, is
\[
e_{n,k}=\Pr(U\lt V)+\tfrac12\Pr(U=V). \tag{4.1}
\]

**Lemma 4.1 (conditional error exponent).** If \(k_n/n\to p\in(1/2,1)\), then
\[
-\frac1n\log e_{n,k_n}\to K_\varepsilon(p). \tag{4.2}
\]
Moreover \(e_{n,k}\le \exp[-nK_\varepsilon(k/n)]\) for \(k\ge n/2\).
The function \(K_\varepsilon\) is continuous on \([1/2,1]\) and strictly increasing on its interior.

**Proof.** For \(t\le0\), Markov's inequality applied to \(e^{t(U-V)}\) bounds
\(\Pr(U-V\le0)\) by
\[
(\varepsilon+h e^t)^k(\varepsilon+h e^{-t})^{n-k}.
\]
Optimize to obtain the upper bound.

For \(p\in(1/2,1)\), the strictly convex logarithmic moment generating function has a unique minimizer \(t_p\lt 0\). Exponential tilting makes the retained-positive and retained-negative counts have equal limiting count per original coordinate:
\[
a_p=
\frac{p h e^{t_p}}{\varepsilon+h e^{t_p}}
=
\frac{(1-p)h e^{-t_p}}{\varepsilon+h e^{-t_p}}
\in(0,1-p).
\]
Choose an integer \(\ell_n\) within one of \(na_{k_n/n}\). The event \(U=V=\ell_n\) has original probability
\(\exp[-nK_\varepsilon(k_n/n)-o(n)]\), by the two binomial type bounds and continuity of relative entropy on this interior compact neighborhood. The factor one half in (4.1) has no exponent. This supplies the matching lower bound. Explicitly the rate is
\[
\min_{0\le a\le1-p}
\left\{pD(a/p\|h)+(1-p)D(a/(1-p)\|h)\right\}, \tag{4.3}
\]
whose unique interior minimizer is \(a_p\). Here the standard binomial type estimate follows from
\((m+1)^{-1}e^{mH(j/m)}\le {m\choose j}\le e^{mH(j/m)}\).

Continuity also follows from (4.3), with its compact feasible intervals, or from the explicit saddle solution below; the endpoint values follow directly. For \(t\lt 0\),
\(-p\log(\varepsilon+h e^t)-(1-p)\log(\varepsilon+h e^{-t})\)
is strictly increasing in \(p\). At every interior \(p\) its optimizing \(t\) is negative. Thus \(K_\varepsilon\) is strictly increasing. \(\square\)

**Lemma 4.2 (curvature identity and sharp rate ratio).** Use \(m=2p-1\) to view \(K_\varepsilon\) and \(I\) as functions on \([0,1]\). Then, for \(0\lt m\lt 1\),
\[
\frac{K_\varepsilon''(m)}{I''(m)}
 =\frac{\beta}{\sqrt{1+(\beta^2-1)m^2}},
 \qquad I''(m)=\frac1{1-m^2}. \tag{4.4}
\]
Consequently \(K_\varepsilon/I\) has the monotonicity and endpoint limits stated in Theorem B.

**Proof.** Write the minimizer as \(t=-u\), \(u>0\). The first-order condition is
\[
m=\frac{\sinh u}{\cosh u+\beta}. \tag{4.5}
\]
It increases bijectively from 0 to 1, because its derivative is
\((1+\beta\cosh u)/(\cosh u+\beta)^2>0\).
The envelope derivative gives
\[
K_\varepsilon'(m)
=\frac12\log\frac{1+\beta e^u}{1+\beta e^{-u}}.
\]
Differentiating this expression and (4.5), and using
\[
\sqrt{1+(\beta^2-1)m^2}
=\frac{1+\beta\cosh u}{\cosh u+\beta},
\]
proves (4.4). These derivatives are with respect to \(m\), not \(p\).

For completeness, the elementary monotone-ratio principle used twice here is as follows. If \(f(0)=g(0)=0\), \(g'>0\), and \(f'/g'\) is strictly decreasing, then \(f(x)/g(x)\) is its \(g'\)-weighted average on \((0,x)\) and is strictly decreasing. The increasing version is identical. Apply the principle first to \(K'\) and \(I'\), then to \(K\) and \(I\); both values and first derivatives vanish at zero. The right side of (4.4) is strictly decreasing for \(\beta>1\), increasing for \(\beta\lt 1\), and constant for \(\beta=1\). At zero the ratio tends to \(\beta\) by the second derivatives. At one it tends to
\(K_\varepsilon(1)/I(1)=-\log\varepsilon/\log2=\alpha\).
For \(\beta=1\), the identical second derivatives and zero initial data give \(K_\varepsilon=I\). \(\square\)

The curvature computation is useful because it compares the whole continuum of exponentially small source tails, not just the Gaussian neighborhood \(p=1/2\).

## 5. Exponential moment orders: proof of Theorem B

Let \(K_n=\sum_iX_i\), let \(F_n(k)=\Pr(K_n\le k)\), and put
\(a_k=\sum_{j=0}^k{n\choose j}\), \(a_{-1}=0\).
For fair majority, complement symmetry and Lemma 2.1 yield the exact expression
\[
R_{\mathrm m}(n,s)=
\frac{2\sum_{k=0}^n e_{n,k}
 \sum_{r=a_{k-1}+1}^{a_k}r^s}
 {\sum_{r=1}^{N}r^s}. \tag{5.1}
\]
This avoids choosing a fictitious independent rank within a Hamming layer.

Suppose \(\log s_n/n\to\theta\in(0,\log2)\). Since \(s_n/N\to0\), integral comparison gives
\[
\sum_{r=1}^N r^{s_n}
 =\frac{N^{s_n+1}}{s_n+1}(1+o(1)). \tag{5.2}
\]
For every fixed \(p\in(1/2,1)\), binomial type bounds give
\[
-\frac1n\log\Pr(K_n\ge\lceil np\rceil)\to I(p), \tag{5.3}
\]
and the same rate holds with a strict tail or a single layer.

**Upper bound on the risk.** Choose fixed \(1/2\lt p_-\lt p_\theta\). Every source word with \(k\le\lfloor np_-\rfloor\) has increasing-order rank at most
\(N[1-\Pr(K_n>\lfloor np_-\rfloor)]\).
Its normalized power is at most
\[
\exp[-s_n\Pr(K_n>\lfloor np_-\rfloor)],
\]
which decays faster than \(\exp(-Ln)\) for every \(L>0\), since \(I(p_-)\lt \theta\).
For the remaining layers, bound each normalized rank power by 1 and use
the conditional Chernoff bound in Lemma 4.1. Since \(I\) and \(K_\varepsilon\) increase on \((1/2,1)\), the type upper bounds and a sum over at most \(n+1\) layers give
\[
\sum_{k>\lfloor np_-\rfloor}\Pr(K_n=k)e_{n,k}
\le \exp[-n\{I(p_-)+K_\varepsilon(p_-)-o(1)\}].
\]
The factor from (5.2) contributes \(\exp(n\theta+o(n))\).
Hence
\[
\liminf_n-\frac1n\log R_{\mathrm m}
\ge I(p_-)+K_\varepsilon(p_-)-\theta.
\]
Let \(p_-\uparrow p_\theta\).

**Lower bound on the risk.** Choose \(p_\theta\lt p_+\lt 1\), and use only the layer
\(k_n=\lceil np_+\rceil\). Every rank in it is at least
\(N[1-\Pr(K_n\ge k_n)]\). By (5.3), the product of this tail probability with \(s_n\) tends to zero exponentially, so the smallest normalized rank power in the layer tends to 1. Its total source probability has exponent \(I(p_+)\), and Lemma 4.1 gives error exponent \(K_\varepsilon(p_+)\). Equation (5.2) now gives
\[
\limsup_n-\frac1n\log R_{\mathrm m}
\le I(p_+)+K_\varepsilon(p_+)-\theta.
\]
Let \(p_+\downarrow p_\theta\), proving the majority limit in (1.4).

Theorem A gives the greedy limit because \(\alpha\theta\lt -\log\varepsilon\).
Lemma 4.2 gives the sign comparison and (1.5). This proves Theorem B. \(\square\)

The exponential rate equality at \(\varepsilon=1/2\) is not an equality of finite-block costs. Section 7 gives their exact ordering there.

**Proposition 5.1 (all-erasure floor and the boundary exponent).** Let
\(R_*(n,s;\varepsilon)=\inf_H R_H(n,s;\varepsilon)\), where the infimum is over all binary helpers with any independent randomization. For every \(n\ge1,s>0\),
\[
R_*(n,s;\varepsilon)\ge\varepsilon^n. \tag{5.4}
\]
If \(\log s_n/n\to\theta\ge\log2\), with finite \(\theta\), then all three logarithmic rates, for \(R_*\), \(R_{\mathrm g}\), and \(R_{\mathrm m}\), equal \(-\log\varepsilon\). If \(\theta>\log2\), then \(R_*\sim\varepsilon^n\) as well.

**Proof.** On the event that all observations are erased, the source remains uniform and independent of the helper's message. Every guessing permutation then has conditional expected cost \(U_{N,s}\). This event has probability \(\varepsilon^n\), proving (5.4).

At \(\theta=\log2\), fix \(p_-\in(1/2,1)\). The low-layer part of the upper-risk argument above is still superexponentially small. The normalization is bounded above by \(s_n+1\) after expressing the numerator as an average normalized-rank power, since \(\sum_r r^{s_n}\ge N^{s_n+1}/(s_n+1)\). Thus the same high-layer estimate gives
\[
\liminf_n-\frac1n\log R_{\mathrm m}
\ge I(p_-)+K_\varepsilon(p_-)-\log2.
\]
Letting \(p_-\uparrow1\) yields \(-\log\varepsilon\); the all-erasure floor gives the reverse inequality. Theorem A gives the same greedy rate. The inequalities \(\varepsilon^n\le R_*\le R_{\mathrm g}\) squeeze the optimized rate. For \(\theta>\log2\), Section 6 proves \(R_{\mathrm g},R_{\mathrm m}\sim\varepsilon^n\), and the same squeeze proves the relative statement for \(R_*\). \(\square\)

## 6. The last-rank window: proof of Theorem C

Write \(t=s/N\) and
\[
D_{N,s}=\sum_{\ell=0}^{N-1}(1-\ell/N)^s.
\]
For \(t\to\infty\),
\[
1\le D_{N,s}\le1+\frac{e^{-t}}{1-e^{-t}}\longrightarrow1. \tag{6.1}
\]

### 6.1 Greedy near its last rank

Its smallest score is exactly \(q_{n,1}=\varepsilon^n/2\). By (3.3),
\(q_{n,r}\le C_\varepsilon\varepsilon^n r^\alpha\).
Using (2.2),
\[
\frac{R_{\mathrm g}(n,s)}{\varepsilon^n}
=\frac{1+E_{n,s}}{D_{N,s}},\qquad
0\le E_{n,s}\le C_\varepsilon'
 \sum_{r=2}^{\infty}r^\alpha e^{-t(r-1)}. \tag{6.2}
\]
The series is \(O_\varepsilon(e^{-t})\) for \(t\ge1\).
Thus greedy alone satisfies
\[
R_{\mathrm g}(n,s_n)/\varepsilon^n\to1
\quad\text{whenever }s_n/N\to\infty. \tag{6.3}
\]

### 6.2 The exceptional majority shell

For the all-one source, the output-0 error is \(\varepsilon^n/2\), coming only from complete erasure. Its contribution together with the reflected all-zero source gives coefficient \(\varepsilon^n\) at rank \(N\).

For a source with exactly one zero, enumerate the possibilities leading to an output-0 report. With the exceptional zero erased, an error occurs only if all ones are erased, followed by a tie. With that zero retained, either no one is retained (a strict error) or exactly one one is retained (a tie). Consequently
\[
e_{n,n-1}
=\frac{\varepsilon^n}{2}
 +h\varepsilon^{n-1}
 +\frac{n-1}{2}h^2\varepsilon^{n-2}
=\frac{\varepsilon^n}{2}A_n,
\quad
A_n=1+2\beta+(n-1)\beta^2. \tag{6.4}
\]
The \(n\) words in this shell have ranks \(N-n,\ldots,N-1\).
Therefore
\[
\frac{R_{\mathrm m}(n,s)}{\varepsilon^n}
=\frac{1+A_n\sum_{\ell=1}^{n}(1-\ell/N)^s+T_{n,s}}
 {D_{N,s}}, \tag{6.5}
\]
where
\[
0\le T_{n,s}\le
2\varepsilon^{-n}
 \frac{e^{-t(n+1)}}{1-e^{-t}}. \tag{6.6}
\]
The bound uses only that every remaining two-message score is at most 2 and all remaining rank deficits are at least \(n+1\).

If \(t_n=\log n+c+o(1)\), then
\[
\sum_{\ell=1}^{n}(1-\ell/N)^{s_n}
\sim e^{-t_n}\sim e^{-c}/n. \tag{6.7}
\]
Indeed the first term is asymptotic to \(e^{-t_n}\), since \(t_n/N\to0\);
the rest is bounded by \(e^{-2t_n}/(1-e^{-t_n})\).
Equations (6.1), (6.4)--(6.7), and \(A_n/n\to\beta^2\) give the majority limit in (1.6). Equation (6.2) gives the greedy limit.

For clarity about the inadequacy of \(t_n\to\infty\), take
\(t_n=c_0\log n\) with any fixed \(0\lt c_0\lt 1\). The same estimates give
\[
\frac{R_{\mathrm m}(n,s_n)}{R_{\mathrm g}(n,s_n)}
\sim\beta^2 n^{1-c_0}\longrightarrow\infty. \tag{6.8}
\]

Finally, if \(\log s_n/n\to\theta>\log2\), then \(t_n\) grows exponentially. For either helper, the last-rank coefficient is \(\varepsilon^n\), and the contribution of all smaller ranks, after dividing by \(N^s\), is at most
\(2e^{-t_n}/(1-e^{-t_n})\).
It is \(o(\varepsilon^n)\). Together with (6.1), this proves saturation and completes Theorem C. \(\square\)

## 7. Common observations and the exact half-erasure solution

**Theorem 7.1 (half-erasure averaging).** If \(\varepsilon=1/2\), \(n\ge2\), and \(s>0\), then
\[
R_{\mathrm g}(n,s;1/2)\lt R_{\mathrm m}(n,s;1/2).
\tag{7.1}
\]
For \(n=1\) they are equal. Nevertheless their fixed-\(s\) limits agree as in (2.7).

**Proof.** Greedy's ordered score is the uniform mid-rank grid
\(q_r=(r-1/2)/N\). Conditional on a source of Hamming weight \(k\), write the observed signed sum as
\[
\operatorname{Bin}(k,1/2)-\operatorname{Bin}(n-k,1/2)
\ \stackrel{d}{=}\ \operatorname{Bin}(n,1/2)-(n-k).
\]
Thus the fair-majority score in its increasing-weight block is exactly the midpoint of that block's binomial cumulative-probability interval. It is the average of greedy's grid scores over the block.

In (2.2) the weight \(w_r=(N+1-r)^s\) is strictly decreasing and greedy's \(q_r\) is strictly increasing. Replacing \(q_r\) on a block by its mean increases \(\sum q_rw_r\): explicitly, for a block of size \(d\), the difference is
\[
-\frac1d\sum_{i\lt j}(q_j-q_i)(w_j-w_i)\ge0,
\]
strictly positive when the block has at least two ranks. For \(n\ge2\) at least one Hamming block is nontrivial. This proves (7.1). Lemma 2.2 covers deterministic ties. \(\square\)


**Lemma 7.2 (common-observation rank converse).** Let \(\Omega\) be a finite source alphabet of size \(N\). Suppose \((X,Z,Y)\) is a coupling for which both \((X,Y)\) and \((Z,Y)\) have the prescribed uniform-source channel law. The two sources need not be independent or conditionally independent. Let a one-bit helper observe \(Y\), and let its two decoder permutations have last-\(N-r\) sets \(A_0,A_1\). For deterministic rules,
\[
 \Pr(G_H>r)\ge\Pr(X\in A_0,Z\in A_1).
 \tag{7.2}
\]
If every pair of sets of size \(N-r\) has coupled probability at least \(L_r\), then every helper, including randomized helpers and decoders, satisfies \(\Pr(G_H>r)\ge L_r\).

**Proof.** For deterministic rules, use the same report \(B=B(Y)\) in the coupling. Pointwise,
\[
 \mathbf1_{\{B=0,X\in A_0\}}+
 \mathbf1_{\{B=1,Z\in A_1\}}
 \ge\mathbf1_{\{X\in A_0,Z\in A_1\}}.
\]
The expectation of the left side is the actual guessing tail: the first term uses the prescribed \((X,Y)\) marginal, and the second uses the equal \((Z,Y)\) marginal. This proves (7.2). Realize all independent random choices by a seed independent of \((X,Z,Y)\) and condition on that seed. The sets and the report rule are then deterministic, and the uniform lower bound \(L_r\) applies for every seed. Integrating proves the randomized statement. There is no conditioning on the source-correlated observation to infer independence. \(\square\)

**Theorem 7.3 (attainment at half erasure).** The claims of Theorem D hold, and greedy's exact rank law is
\[
 \Pr(G_{\mathrm g}=r)=\frac{2(N-r)+1}{N^2},
 \qquad r=1,\ldots,N. \tag{7.3}
\]
This is the law of the minimum of two independent uniform ranks.

**Proof.** Draw independent uniform binary words \(X^n,Z^n\). At each coordinate let \(Y_i\) be their common bit if they agree, and let it be erased otherwise. Given either source word, agreement events are independent with probability \(1/2\), so both source-observation marginals are exactly the BEC with erasure \(1/2\). Lemma 7.2 and the unconditional independence of the two sources give
\(\Pr(G_H>r)\ge((N-r)/N)^2\).

For greedy, (2.5) gives \(q_r=(r-1/2)/N\) in increasing lexicographic order. Its two opposite decoder orders yield
\[
 \Pr(G_{\mathrm g}=r)=\frac{(1-q_r)+q_{N+1-r}}{N}
                    =\frac{2(N-r)+1}{N^2}.
\]
Summing gives equality of every rank tail. A deterministic all-erased report adds a constant to all scores; this constant cancels from the displayed rank probabilities. For any nondecreasing loss \(\psi\), use the finite identity
\[
 \mathbb E\psi(G)=\psi(1)+
 \sum_{r=1}^{N-1}[\psi(r+1)-\psi(r)]\Pr(G>r).
 \tag{7.4}
\]
Its increments are nonnegative, establishing simultaneous optimality. Summing \(r^s\) against (7.3) gives (1.8); ordinary Riemann sums give its block limit. \(\square\)

For \(\varepsilon>1/2\), independently erase each agreement bit in this coupling with probability \(2\varepsilon-1\). The retained probability given either source is then \(1-\varepsilon\), so the quadratic rank-tail lower bound remains valid, without an attainment assertion. Conversely, such an independent-two-source representation of a binary BEC requires \(1-\varepsilon\le\Pr(X_i=Z_i)=1/2\), because a nonerased output must agree with both sources. This identifies the exact threshold for this representation, not the complete class of optimal helpers.

**Proposition 7.4 (an exact additive-uniform observation model).** Let \(X,Z\) be independent uniform variables on \(\{1,\ldots,N\}\), with any integer \(N\ge1\), and let the helper observe the ordinary integer sum \(Y=X+Z\). Reporting 1 above \(N+1\), 0 below \(N+1\), with any fixed randomization on equality, attains (7.3). It is globally optimal for every nondecreasing rank loss among all one-bit functions of the sum.

**Proof.** The sum is a common observation for the two independent, identically distributed sources, so Lemma 7.2 gives the quadratic tail lower bound. If the equality report is 1 with probability \(\tau\in[0,1]\), its posterior score is
\[
 q_x=\frac{x-1+\tau}{N}.
\]
Increasing and decreasing decoder orders give
\(((1-q_r)+q_{N+1-r})/N=(2(N-r)+1)/N^2\), independently of \(\tau\), and hence attain the lower bound. The operation here is not modular addition. \(\square\)

The two exact models are linked explicitly. In the half-erasure coupling, let \(a(X)=\sum_i2^{n-i}X_i\). The observation determines \(a(X)+a(Z)\): an erased coordinate contributes one bit-weight, a retained 0 contributes zero, and a retained 1 contributes twice its weight. Comparing this sum to \(N-1\) is decided by the first retained bit, because its weight exceeds the sum of all later weights. Greedy is therefore the corresponding sum-threshold rule, even though the BEC observation contains more detail than the sum alone.

## 8. A finite-prefix rational witness

The following result provides a short deterministic witness in the original fixed-\(s\), large-\(n\) model.

**Lemma 8.1 (fixed-prefix lift).** Let a helper depend only on \(k\) source-channel coordinates. Set \(m=2^k\), and order its report-1 likelihoods as \(q_0\le\cdots\le q_{m-1}\). Extend it to length \(n\ge k\) by ignoring the remaining coordinates. Then for every fixed \(s>0\),
\[
\lim_{n\to\infty}R_H(n,s)
=\frac1{m^{s+1}}\sum_{j=0}^{m-1}
\left[
(1-q_j)\{(j+1)^{s+1}-j^{s+1}\}
+q_j\{(m-j)^{s+1}-(m-j-1)^{s+1}\}
\right]. \tag{8.1}
\]

**Proof.** Each prefix score is repeated exactly \(2^{n-k}\) times in the full posterior ordering. The normalized ranks in that group fill an interval of length \(1/m\), in forward order for message 0 and reverse order for message 1. Fixed-\(s\) Riemann sums and the normalization \(U_{N,s}/N^s\to1/(s+1)\) give (8.1). Equal scores cause no change because their interval contributions add. No symmetry or unbiasedness of the helper is assumed. \(\square\)

**Theorem 8.2 (31-bit deterministic certificate).** At \(\varepsilon=1/10\) and \(s=10\), let the helper report whether the first 31 coordinates contain strictly more retained ones than retained zeros; on a tie report 0. Its lifted cost \(L_{10}^{(31)}\) satisfies
\[
L_{10}^{(31)}\lt \frac3{250},\qquad
G_{10}(1/10)=\frac{7155499291}{569986224658}>\frac1{80}.
\tag{8.2}
\]
Thus \(G_{10}(1/10)-L_{10}^{(31)}>1/2000\).

**Proof and exact certificate.** For a prefix with \(w\) ones, its report-1 likelihood has denominator \(10^{31}\) and numerator
\[
a_w=\sum_{i=0}^{w}\sum_{j=0}^{31-w}
\mathbf1_{\{i>j\}}{w\choose i}{31-w\choose j}9^{i+j}.
\tag{8.3}
\]
Use \(q_w=a_w/10^{31}\), with multiplicity \({31\choose w}\), in (8.1). Monotonicity follows from Lemma 2.1, so only 32 Hamming blocks need be summed. The accompanying standard-library integer/rational program records all \(a_w\) and verifies the first inequality by cross multiplication.

For an independently checkable greedy evaluation define
\(I_t=\int_0^1u^t A_\varepsilon(u)\,du\), for integers \(t\ge0\). The dyadic equations
\(A(u/2)=\varepsilon A(u)\) and
\(A((1+u)/2)=1-\varepsilon+\varepsilon A(u)\) give
\[
(1-\varepsilon2^{-t})I_t
=\frac{(1-\varepsilon)(1-2^{-t-1})}{t+1}
+\varepsilon2^{-t-1}\sum_{j=0}^{t-1}{t\choose j}I_j. \tag{8.4}
\]
This includes \(I_0=1/2\), with an empty sum. Since
\(G_t=2-2(t+1)I_t\), rational evaluation at \(t=10,\varepsilon=1/10\) gives the fraction in (8.2). The exact program also checks its strict inequality and
\(1/80-3/250=1/2000\). The result does not assert that 31 is the minimum prefix length or that this helper is optimal. \(\square\)

For orientation only, the two costs are approximately \(0.0117842029463665\) and \(0.0125538109193663\); the strict proof is the rational inequality, not the displayed decimals.

## 9. Precise sequential high-moment asymptotics

This section concerns \(n\to\infty\) at fixed \(s\), followed by \(s\to\infty\). It is complementary to, not a substitute for, Theorems B and C.

### 9.1 Majority's Gaussian tail constant

**Theorem 9.1 (majority high-moment constant).** For every fixed \(0\lt \varepsilon\lt 1\),
\[
M_s(\varepsilon)\sim
\frac{2\Gamma(\beta+1)(4\pi)^{(\beta-1)/2}}{\sqrt\beta}\,
s^{-\beta}(\log s)^{(\beta-1)/2}. \tag{9.1}
\]

**Proof.** Put \(v=1-u\), \(z=\Phi^{-1}(1-v)\), and
\(L(v)=\Phi(-\sqrt\beta\,z)\). The normal Mills estimates give
\(v\sim\phi(z)/z\), \(z\sim\sqrt{2\log(1/v)}\), and
\[
L(v)\sim
\frac{(4\pi)^{(\beta-1)/2}}{\sqrt\beta}\,
v^\beta(\log(1/v))^{(\beta-1)/2}. \tag{9.2}
\]
For example, (9.2) follows by dividing
\(\phi(\sqrt\beta\,z)/(\sqrt\beta\,z)\)
by \((\phi(z)/z)^\beta\).

Insert (9.2) into (2.3) and substitute \(x=sv\).
For a fixed \(x>0\), the rescaled power kernel tends to \(e^{-x}\) and the slowly varying logarithmic ratio tends to 1. Dominated convergence applies after splitting \(v\) at a fixed small number: outside that interval the contribution is exponentially small; inside it, the elementary bounds for powers of \(\log(1/v)\) are bounded by \(C_\delta\max(x^\delta,x^{-\delta})\) after rescaling, with \(0\lt \delta\lt \beta+1\). The remaining integral is
\(\int_0^\infty e^{-x}x^\beta dx=\Gamma(\beta+1)\).
The factor \(2(s+1)\) in (2.3) gives (9.1). \(\square\)

### 9.2 Greedy's dyadic oscillation

**Theorem 9.2 (nonconstant periodic leading coefficient).** Fix \(0\lt \varepsilon\lt 1/2\), so \(\alpha>1\). Define
\[
P_\varepsilon(\vartheta)
=\frac{1-2\varepsilon}{\varepsilon}
\sum_{r\in\mathbb Z}
\frac{(2^{\vartheta-r})^\alpha}
     {\sinh(2^{\vartheta-r})}. \tag{9.3}
\]
This is a positive continuous one-periodic function, and
\[
s^\alpha G_s(\varepsilon)
=P_\varepsilon(\log_2s)+O_\varepsilon(s^{-1}). \tag{9.4}
\]
It is not constant. With \(\omega_k=2\pi k/\log2\), its Fourier coefficients are
\[
\widehat P_\varepsilon(k)=
\frac{2(1-2\varepsilon)(1-\varepsilon)}
 {\varepsilon\log2}
\Gamma(\alpha-i\omega_k)\zeta(\alpha-i\omega_k). \tag{9.5}
\]

**Proof.** At each dyadic \(j/2^m\), \(j\) odd and \(1\le j\lt 2^m\), the right-continuous version of \(A_\varepsilon\) has jump
\((1-2\varepsilon)\varepsilon^{m-1}\).
The total of all jumps is
\[
(1-2\varepsilon)\sum_{m\ge1}(2\varepsilon)^{m-1}=1.
\]
The function is increasing with total increment 1, so its distributional derivative consists precisely of these atoms, with no residual continuous part. Integration by parts in (2.6) gives
\[
G_s=2(1-2\varepsilon)
\sum_{m\ge1}\varepsilon^{m-1}
\sum_{\substack{1\le j\lt 2^m\\j\ {\rm odd}}}
(1-j2^{-m})^{s+1}. \tag{9.6}
\]

Extend \(A_\varepsilon\) to \((0,\infty)\) by dyadic homogeneity,
\(\widetilde A(2u)=2^\alpha\widetilde A(u)\), retaining its values on \((0,1)\).
It satisfies \(c_\varepsilon u^\alpha\le\widetilde A(u)\le C_\varepsilon u^\alpha\).
Its derivative has the same jump rule at every positive dyadic point, now with
\(m\in\mathbb Z\) and every positive odd numerator.

Let \(v=s+1\). Replacing the compact power kernel \((1-u)_+^v\) by \(e^{-vu}\) in
\(2\int(1-u)_+^v\,d\widetilde A(u)\) changes the integral by
\(O_\varepsilon(v^{-\alpha-1})\).
Here is an explicit bound: on \(0\le u\le1/2\),
\[
0\le e^{-vu}-(1-u)^v
 \le v u^2e^{-vu};
\]
on \(u>1/2\) both tails are exponentially small after integration against a measure whose cumulative mass grows at most polynomially. Integration by parts, or a decomposition into intervals of length \(1/v\), bounds
\(\int u^2e^{-vu}\,d\widetilde A(u)\) by \(C_\varepsilon v^{-\alpha-2}\).
The exponential replacement therefore has the asserted error.

Summing the exponential atoms, using
\(\sum_{j\ge1,\ j\text{ odd}}e^{-jx}=1/(2\sinh x)\), gives
\[
2v^\alpha\int_0^\infty e^{-vu}\,d\widetilde A(u)
=\frac{1-2\varepsilon}{\varepsilon}
\sum_{m\in\mathbb Z}\frac{(v2^{-m})^\alpha}{\sinh(v2^{-m})}
=P_\varepsilon(\log_2v). \tag{9.7}
\]
The series and its first derivative converge locally uniformly: at zero the summand is of order \(x^{\alpha-1}\), and at infinity it decays exponentially. Reindexing proves period one. Thus replacing \(v=s+1\) by \(s\) incurs only \(O_\varepsilon(s^{-1})\), proving (9.4).

Absolute convergence permits periodization and the Mellin change of variables:
\[
\widehat P_\varepsilon(k)
=\frac{1-2\varepsilon}{\varepsilon\log2}
\int_0^\infty\frac{x^{\alpha-i\omega_k-1}}{\sinh x}\,dx.
\]
Expand \(1/\sinh x=2\sum_{\ell\ge0}e^{-(2\ell+1)x}\).
For \(\Re z>1\) the integral is
\(2\Gamma(z)(1-2^{-z})\zeta(z)\).
At \(z=\alpha-i\omega_k\), \(2^{-z}=\varepsilon\), giving (9.5).
The gamma function has no zeros, and the absolutely convergent Euler product of zeta is nonzero in \(\Re z>1\); thus, in particular,
\(\widehat P_\varepsilon(1)\ne0\). Hence \(P_\varepsilon\) is nonconstant. \(\square\)

The standard Mellin/log-periodic framework is discussed in [K20]. Our contribution is its exact application to the greedy guessing ratio, including the coefficient and its nonconstancy. The formula (9.3) is not asserted at \(\varepsilon=1/2\); the direct formula (2.7) applies there.

### 9.3 Consequences and the order of limits

**Corollary 9.3 (unbounded low-erasure loss of greedy).** For every fixed \(0\lt \varepsilon\lt 1/2\),
\[
\frac{M_s(\varepsilon)}{G_s(\varepsilon)}\to0.
\tag{9.8}
\]
For \(\varepsilon>1/2\) the same ratio tends to infinity. At \(\varepsilon=1/2\) it is exactly 1 for all \(s>0\).

**Proof.** For \(\varepsilon\lt 1/2\), Lemma 4.2 gives \(\beta>\alpha\);
for \(\varepsilon>1/2\), it gives \(\beta\lt \alpha\).
Combine the two-sided greedy power law following Theorem A with (9.1).
The logarithmic factor cannot offset a strict difference of powers. Use (2.7) at equality. \(\square\)

In particular, since the optimized one-bit cost is at most \(M_s\), greedy does not admit a finite factor, depending only on a fixed low erasure probability, that approximates the optimized cost uniformly over all positive moment orders. The all-helper converse below identifies the optimized power, while leaving its logarithmic correction open below half erasure.

**Proposition 9.4 (fixed-block reverse limit).** For fixed \(n\ge1\) and fixed \(0\lt \varepsilon\lt 1\),
\[
\lim_{s\to\infty}R_{\mathrm g}(n,s;\varepsilon)
=\lim_{s\to\infty}R_{\mathrm m}(n,s;\varepsilon)
=\varepsilon^n,
\qquad
\lim_{s\to\infty}\frac{R_{\mathrm m}(n,s;\varepsilon)}
 {R_{\mathrm g}(n,s;\varepsilon)}=1. \tag{9.9}
\]

**Proof.** Divide the exact finite sums by \(N^s\).
Every rank below \(N\) disappears. For both fair-tie helpers the two last-rank conditional likelihoods sum to \(\varepsilon^n\); the denominator tends to 1.
Tie invariance gives the same result for deterministic ties. \(\square\)

Thus the sequential limit in (9.8) cannot be read as a fixed-block claim.
Theorems B and C specify two quantitatively different joint regimes between these limiting procedures.


### 9.4 The optimal high-moment power over all helpers

**Theorem 9.5 (all-helper tail and moment converses).** For every \(0\lt\varepsilon\lt1\), put \(a=\max\{2,1/\varepsilon\}\). For all block lengths and all one-bit helpers with any decoder,
\[
 \Pr(G_H>r)\ge\left(1-\frac rN\right)^a,
 \qquad r=0,\ldots,N. \tag{9.10}
\]
The limits and inequalities in Theorem E follow.

**Proof.** Suppose first that \(0\lt\varepsilon\lt1/2\). Draw a uniform binary word \(X^n\), and obtain \(Z^n\) by independent bit flips with probability \(\varepsilon\). The binary correlation parameter is \(\rho=1-2\varepsilon\in(0,1)\). Emit their common bit at each agreeing coordinate and erase at each disagreement. Both \((X^n,Y^n)\) and \((Z^n,Y^n)\) are the prescribed BEC source-observation pair: reversibility of the uniform bit-flip channel gives the same conditional law from either source.

The classical reverse-hypercontractive rectangle inequality [MORSS06, Corollary 3.3 and Theorem 3.4; OPS20, equation (3)] states for two such \(\rho\)-correlated uniform binary words and any two sets of equal uniform mass \(\delta\) that
\[
 \Pr(X^n\in A,Z^n\in C)\ge\delta^{2/(1-\rho)}.
 \tag{9.11}
\]
Indeed, the reverse inequality for functions has equal norm parameters \(p=q=1-\rho\); applying it to indicators gives the exponent \(2/(1-\rho)\). Here that exponent is \(1/\varepsilon\). Applying Lemma 7.2 to the two decoder tail sets proves (9.10). At \(\varepsilon\ge1/2\), use the independent-source coupling, with additional thinning when necessary, from Section 7. This gives exponent 2. No reverse-hypercontractive inequality is applied directly to the BEC input-output pair.

For the finite moment bound, let \(V\) have survival function \(\Pr(V>v)=(1-v)^a\), \(0\le v\le1\), and set \(T_N=\lceil NV\rceil\). Then \(G_H\) stochastically dominates \(T_N\). For \(s>0\), an integral comparison yields
\[
 U_{N,s}\le\frac{N^s}{s+1}+N^{s-1}. \tag{9.12}
\]
If \(N\ge s+1\), then
\[
 \mathbb E V^s\ge
 \left(\frac{s}{s+1}\right)^s
 \Pr\!\left(V\ge\frac{s}{s+1}\right)
 \ge e^{-1}(s+1)^{-a}.
\]
Together with \(T_N\ge NV\) and (9.12), this gives
\(R_H\ge(2e)^{-1}(s+1)^{1-a}\).
If \(N\lt s+1\), (9.10) at \(r=N-1\) gives \(\Pr(G_H=N)\ge N^{-a}\), while (9.12) gives \(U_{N,s}\le2N^{s-1}\). Hence
\(R_H\ge N^{1-a}/2\ge(s+1)^{1-a}/2\).
Proposition 5.1 also gives \(R_H\ge\varepsilon^n\). The elementary inequality
\(\max\{x,y/(2e)\}\ge(x+y)/(2e+1)\)
establishes the finite bound in (1.9), including every real \(s>0\).

We next justify existence of the optimized block limit, without interchanging optimization with a limit. For a helper and decoder, introduce an independent uniform \(U\) on \([0,1]\) and the jittered normalized moment
\[
 J_{n,H}=\mathbb E\left[\left(\frac{G_H-1+U}{2^n}\right)^s\right],
 \qquad j_n=\inf_H J_{n,H}, \tag{9.13}
\]
where optimal posterior orders minimize this increasing loss as well. Extend a length-\(n\) helper to length \(n+1\) by ignoring the last coordinate. Each posterior source probability is repeated twice. Choose the two suffixes consecutively in each posterior rank block. Conditional on the prefix and report, the ignored source bit is fair, and the new jittered within-block position is uniform. Consequently this extension has exactly the same \(J\), and \(j_{n+1}\le j_n\). The sequence is nonnegative, so it has a limit. For every helper, the difference between \(\mathbb E(G_H/N)^s\) and \(J_{n,H}\) is bounded in absolute value by the modulus of continuity of \(x^s\) on \([0,1]\) at distance \(1/N\). This bound tends to zero uniformly in the helper. Since \(U_{N,s}/N^s\to1/(s+1)\), it follows that
\(\gamma_s=(s+1)\lim_n j_n\) exists.

Taking the block limit in the bound using \(T_N/N\to V\) gives
\[
 \gamma_s(\varepsilon)\ge(s+1)\mathbb E V^s
 =\frac{\Gamma(a+1)\Gamma(s+2)}{\Gamma(s+a+1)}.
 \tag{9.14}
\]
For \(0\lt\varepsilon\lt1/2\), \(a=\beta+1\), so the right side is asymptotic to \(\Gamma(\beta+2)s^{-\beta}\). On the other hand, \(\gamma_s\le M_s\), and Theorem 9.1 gives
\[
 \Gamma(\beta+2)s^{-\beta}(1+o(1))
 \le\gamma_s(\varepsilon)
 \le\frac{2\Gamma(\beta+1)(4\pi)^{(\beta-1)/2}}{\sqrt\beta}
       s^{-\beta}(\log s)^{(\beta-1)/2}(1+o(1)).
 \tag{9.15}
\]
The powers match, proving the first limit in (1.10). Theorem A or Theorem 9.2 gives \(-\log G_s/\log s\to\alpha\), proving the second limit. At \(\varepsilon=1/2\), both limits follow from the exact solution (1.8). This completes Theorem E. \(\square\)

**Corollary 9.6 (when greedy is universally optimal).** Within \(0\lt\varepsilon\lt1\), greedy is globally optimal for every block length and every positive rank moment if and only if \(\varepsilon=1/2\).

**Proof.** Theorem D proves the positive direction. Below half erasure, Corollary 9.3 first supplies a fixed sufficiently large moment \(s\) with \(M_s\lt G_s\). The fixed-\(s\) block limits then supply finite block lengths for which majority is strictly better.

Above half erasure, we recall the finite-prefix perturbation from [I1, Section 4], supplying its short finite-block argument to make the implication explicit. Choose an integer \(m\) with \(\varepsilon^m\lt2\varepsilon-1\), and let \(u=01^{m-1}\), \(v=10^{m-1}\). Equation (2.5) gives
\[
 q(u)=\varepsilon-\varepsilon^m/2>1/2,
 \qquad q(v)=1-q(u)\lt1/2.
\]
Change greedy's report only on the two fully observed words: report 1 on \(u\) and 0 on \(v\). This raises \(q(u)\) and lowers \(q(v)\) by \(h^m>0\). In greedy's original increasing-score decoder, their ranks satisfy \(r_u>r_v\). The coefficient of a score in (2.1) is
\(w(r)=(N+1-r)^s-r^s\), strictly decreasing for every \(s>0\). Using the old two decoder orders, the cost numerator changes by
\(h^m[w(r_u)-w(r_v)]\lt0\). Reoptimizing the decoder can only lower it further. This is the predecessor's high-erasure mechanism, not a new result claimed here. \(\square\)

The low-erasure negative direction chooses \(s\) before a sufficiently large block length. It does not say that greedy fails at every low-erasure moment, and no optimality of majority away from half erasure follows from the classification.

## 10. Verification, scope, and remaining questions

The paper's proofs are analytic. The accompanying exact certificate verifies the finite-prefix witness by integer and rational arithmetic; it is not a proof of the general rate theorems. Numerical evaluations of the rate function and posterior sums provide independent checks of signs, constants, and the critical window. The source audit records the exact primary literature and the unpublished predecessor used for comparison. It does not certify global priority.

The following questions remain open in this work:

* Away from half erasure, the optimal normalized cost over all binary helpers is not characterized in the interior exponential regime. Proposition 5.1 gives the saturation-region exponent and supercritical equivalence. For the sequential limit, Theorem E determines the low-erasure power, but leaves its logarithmic correction and leading constant open; it does not determine the high-erasure optimized power.
* The finite-block majority-to-greedy ratio is not determined for every \(n,s,\varepsilon\).
* At \(\log s_n/n\to\log2\), Theorem C treats its stated last-rank window and does not cover every subexponential offset.
* No claim is made that the 31-bit witness has minimum size.
* The dyadic-periodic coefficient is derived only for \(\varepsilon\lt 1/2\). The uniform greedy bounds apply to all \(0\lt \varepsilon\lt 1\).
* The constants in the two-sided greedy bounds and the asymptotic expansions may depend on a fixed \(\varepsilon\). Uniformity of those expansions as erasure tends to 0, \(1/2\), or 1 is not claimed. The numerical constant \(1/(2e+1)\) in Theorem E is universal.
* There is no proof-assistant verification, external peer review, or claim of worldwide novelty certification.

The exact half-erasure solution concerns every nondecreasing loss; the low-erasure optimality result concerns a power exponent after taking the block limit first. These conclusions do not replace the distinct finite-block strategy comparisons.

## References

[WS20] N. Weinberger and O. Shayevitz, “Guessing with a Bit of Help,” *Entropy* 22(1), 39 (2020). DOI: [10.3390/e22010039](https://doi.org/10.3390/e22010039). Publisher full text and Conjecture 1, Proposition 3, and Theorem 2 inspected.

[GLMP22] R. Graczyk, A. Lapidoth, N. Merhav, and C. Pfister, “Guessing Based on Compressed Side Information,” *IEEE Transactions on Information Theory* 68(7), 4244--4256 (2022). DOI: [10.1109/TIT.2022.3158475](https://doi.org/10.1109/TIT.2022.3158475). Official institutional metadata and the complete author manuscript inspected.

[AST20] N. Ardimanov, O. Shayevitz, and I. Tamo, “Minimum Guesswork with an Unreliable Oracle,” *IEEE Transactions on Information Theory* 66(12), 7528--7538 (2020). DOI: [10.1109/TIT.2020.3033305](https://doi.org/10.1109/TIT.2020.3033305). Official institutional metadata and arXiv:1811.08528v2 inspected.

[OPS20] O. Ordentlich, Y. Polyanskiy, and O. Shayevitz, “A Note on the Probability of Rectangles for Correlated Binary Strings,” *IEEE Transactions on Information Theory* 66(12), 7878--7886 (2020). DOI: [10.1109/TIT.2020.3018232](https://doi.org/10.1109/TIT.2020.3018232). Official institutional metadata and complete arXiv author manuscript inspected.

[K20] P. Kevei, “Regularly log-periodic functions and some applications,” *Probability and Mathematical Statistics* 40(1), 159--182 (2020). DOI: [10.37190/0208-4147.40.1.10](https://doi.org/10.37190/0208-4147.40.1.10). Publisher full text inspected for the established transform framework.

[I1] “One-Bit Guessing over Erasure Channels: finite-prefix instability and the sharp high-erasure optimum,” unpublished companion manuscript, 25 November 2026. Sections 4 and 7--8 inspected. Its high-erasure results predate the present study and are not claimed as contributions of this manuscript.

[MORSS06] E. Mossel, R. O'Donnell, O. Regev, J. E. Steif, and B. Sudakov, “Non-interactive correlation distillation, inhomogeneous Markov chains, and the reverse Bonami--Beckner inequality,” *Israel Journal of Mathematics* 154, 299--336 (2006). DOI: [10.1007/BF02773611](https://doi.org/10.1007/BF02773611). Author full text inspected, including Corollary 3.3 and Theorems 3.4, 4.1, and 4.2.

[NW17] C. Nair and Y. N. Wang, “Reverse hypercontractivity region for the binary erasure channel,” *2017 IEEE International Symposium on Information Theory*, 938--942 (2017). DOI: [10.1109/ISIT.2017.8006666](https://doi.org/10.1109/ISIT.2017.8006666). Author full text inspected for the original BEC input-output reverse-hypercontractivity region, especially Lemma 1 and Theorem 3.
