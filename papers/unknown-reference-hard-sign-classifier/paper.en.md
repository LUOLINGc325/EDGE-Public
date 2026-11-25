---
title: "Optimal two-sample closeness testing with one hard classifier"
lang: en
abstract: |
  Consider testing equality of two unknown distributions on a finite alphabet against total variation separation. A classifier based on the larger training count at each symbol, with a fixed fair decision at ties, compresses each holdout observation to one bit. We prove that its difference in holdout acceptance rates achieves the unrestricted minimax rate throughout the sparse and dense regimes and at arbitrary confidence. The training analysis controls large-mass symbols by simultaneous estimation and controls small-mass symbols by a mean-dependent exponential inequality for the signed decision. We give a self-contained matching lower bound using an independent mixture of heavy and light symbol pairs. The lower bound holds for all tests with the same per-distribution sample budget.
---

## 1. Problem and result

For probability distributions \(p,q\) on \([k]=\{1,\ldots,k\}\), write
\[
\operatorname{TV}(p,q)=\frac12\sum_{i=1}^k |p_i-q_i|.
\]
The null is \(p=q\), with the common distribution unknown, and the alternative is \(\operatorname{TV}(p,q)\ge \varepsilon\). We use at most \(m\) independent observations from each distribution and require both worst-case errors at most \(\delta\). Here \(k\ge2\), \(0<\varepsilon\le1/16\), and \(0<\delta\le1/4\). A lower bound on \(m\) also applies to an adaptive test whose deterministic sample cap is \(m\) from each distribution, by supplying both streams in advance.

Put \(L=\log(1/\delta)\) and
\[
R(k,\varepsilon,\delta)
 =\frac{k^{2/3}L^{1/3}}{\varepsilon^{4/3}}
  +\frac{\sqrt{kL}}{\varepsilon^2}
  +\frac{L}{\varepsilon^2}.
\]

**Theorem 1.** The minimum per-distribution sample budget is between \(cR\) and \(CR\) for universal \(0<c<C<\infty\). The upper bound is attained by the following rule. It uses one fixed Boolean map \(i\mapsto \mathbf 1\{i\in S\}\) for both holdout streams on the original alphabet. The holdout test needs only their signed difference in empirical acceptance rates.

For the rule, take \(\ell=\log(16/\delta)\) and replace \(L\) by \(\ell\) in \(R\). Take \(n\) to be the ceiling of a sufficiently large universal multiple of the resulting expression.

1. Reserve \(2n\) training draws and \(n\) holdout draws from each law. Independently generate two lengths with distribution \(\mathrm{Poi}(n)\).
2. If either requested length exceeds \(2n\), set \(S=\varnothing\). Otherwise use the requested training prefixes, count occurrences \(X_i,Y_i\) of each symbol and put \(i\in S\) when \(X_i>Y_i\). Decide membership by an independent fair coin at each tied symbol and keep that decision fixed.
3. Reject equality if \(\widehat p(S)-\widehat q(S)>4\sqrt{\ell/n}\), where both empirical probabilities use only holdout observations.

Equivalently, with equal weighting of the two streams, twice the balanced classification accuracy minus one equals this signed difference. The training procedure requires neither the common law under the null nor an estimate of its large-mass symbols. One may store counts at observed symbols and preassign one independent random tied decision to each symbol.

## 2. The Poisson sign inequality

In ideal training use unlimited independent streams to honor both Poisson lengths. Poisson splitting makes the pairs \((X_i,Y_i)\) mutually independent, with
\[
X_i\sim\mathrm{Poi}(np_i),\qquad Y_i\sim\mathrm{Poi}(nq_i).
\]
Let \(B_i=\mathbf 1\{i\in S\}\) in this experiment. For one coordinate drop the subscript and let
\[
s=p_i+q_i,\quad u=p_i-q_i,\quad \lambda=ns,\quad
a=\frac{n}{\sqrt{\max(1,\lambda)}},\quad v=au,\quad
\mu=\mathbb E[u(B-1/2)].
\]
Absolute positive constants may change from line to line.

**Lemma 2.** Uniformly in these parameters,
\[
\mu\ge c\min(a u^2,|u|).
\]
For every \(0\le t\le1/8\),
\[
\log\mathbb E\exp[-t(vB-\mathbb E[vB])]\le C t^2 a\mu .
\]

**Proof.** When \(u=0\) both statements are immediate. By symmetry it suffices to analyze \(u>0\). Given the pooled count \(N=X_i+Y_i=b\), the count from \(p\) is binomial with parameters \(b\) and \(\vartheta=(1+u/s)/2\). The majority decision with fair ties has nonnegative bias above one half for \(\vartheta\ge1/2\). When \(0<\lambda\le1\), the event \(N=1\) alone gives bias at least \((\lambda/e)u/(2s)=v/(2e)\), and \(v\le1\).

When \(\lambda\ge1\), the second moment of \(N\) and the Paley--Zygmund inequality give \(\Pr(N\ge\lambda/2)\ge1/8\). For an odd integer \(b=2j+1\), the derivative of the majority probability as a function of \(\vartheta\) is
\[
 b\binom{2j}{j} \vartheta^j(1-\vartheta)^j.
\]
This follows by differentiating the binomial tail and telescoping its interior terms. The central binomial bound \(\binom{2j}{j}\ge c\,4^j/\sqrt{j+1}\) and
\(\vartheta(1-\vartheta)=\tfrac14-(\vartheta-\tfrac12)^2\)
bound the derivative below by \(c\sqrt b\) on \(0\le\vartheta-1/2\le(4\sqrt b)^{-1}\). Integrating and then using monotonicity yields bias at least \(c\min(\sqrt b(\vartheta-1/2),1)\). For even \(b\ge2\), remove a uniformly chosen trial before deciding. This leaves a majority unchanged outside a tie and breaks a tie with probability one half in either direction. The resulting probability is the odd majority probability with \(b-1\ge b/2\) trials. Using \(N\ge\lambda/2\) now gives \(\mathbb E[B]-1/2\ge c\min(v,1)\). The mean claim follows.

For \(|v|\le1\), Hoeffding's lemma gives log moment at most \(t^2v^2/8\), which is at most \(Ct^2a\mu\). For \(|v|>1\), necessarily \(\lambda>1\). By the Poisson Chernoff bound,
\[
\Pr(X_i\le Y_i)
 \le \exp[-(\sqrt{np_i}-\sqrt{nq_i})^2]
 \le \exp(-v^2/2) \qquad (u>0).
\]
The first bound follows by minimizing \(\mathbb E e^{-\gamma(X_i-Y_i)}\) over \(\gamma\ge0\), including the limit when \(q_i=0\). The second uses \((\sqrt{np_i}+\sqrt{nq_i})^2\le2\lambda\). For \(u<0\) interchange the streams. Let \(D\) be the indicator of a decision against the sign of \(u\). Then
\[
\begin{aligned}
\log\mathbb E\exp[-t(vB-\mathbb E[vB])]
 &=\log\mathbb E\exp[t|v|(D-\mathbb E D)]\\
 &\le \mathbb E D\,(\exp(t|v|)-1-t|v|)\\
 &\le \tfrac12 t^2|v|^2\exp(-v^2/2+t|v|).
\end{aligned}
\]
For \(t\le1/8\), the last line is at most \(Ct^2|v|\), and \(a\mu\ge c|v|\). This proves the lemma.

## 3. Training concentration and holdout testing

Write \(u_i=p_i-q_i\), \(s_i=p_i+q_i\), and \(V_J=\sum_{i\in J}|u_i|\) for \(J\subseteq[k]\). Because \(\sum_i u_i=0\), the population holdout contrast is
\[
\Delta=p(S)-q(S)=\sum_i u_i(B_i-1/2).
\]
For analysis let \(H=\{i:s_i>1/\ell\}\) and \(J=[k]\setminus H\). Thus \(|H|\le2\ell\). The algorithm uses the same decision for every symbol.

For \(i\in H\), when the sign decision is wrong, \(|(X_i-Y_i)/n-u_i|\ge |u_i|\), also when a tie is decided against the sign. Hence
\[
\sum_{i\in H}u_i(B_i-1/2)
 \ \ge\ V_H/2-\sum_{i\in H}|(X_i-Y_i)/n-u_i|.
\]
To control the absolute sum, express its product with \(n\) as the maximum over \(2^{|H|}\) signed sums of the centered variables \(X_i-Y_i-nu_i\). Each signed sum \(Z\) has \(\log\mathbb E e^{tZ}\le Cnt^2\) for \(0\le t\le1\). Indeed, each independent centered Poisson count enters with coefficient \(1\) or \(-1\), the sum of its rates is at most \(2n\), and \(e^{\pm t}-1\mp t\le Ct^2\). Taking \(t=c\sqrt{\ell/n}\) with \(n\ge\ell\), a Chernoff bound and a union bound give
\[
\sum_{i\in H}u_i(B_i-1/2)\ge V_H/2-C\sqrt{\ell/n}
\]
with probability at least \(1-e^{-\ell}\). Here the threshold constant absorbs \(2\log 2\) from the logarithm of the number of signs.

On \(J\), \(a_i\ge a_*=\sqrt{n\ell}\). Let \(M_J=\sum_{i\in J}\mu_i\). Apply Lemma 2 with \(t=r/a_i\), then multiply moments by independence. For \(r=\gamma a_*\) with \(\gamma>0\) sufficiently small and universal, the log moment of minus \(r\) times the centered light contrast is at most
\[
 C r^2 \sum_{i\in J}\mu_i/a_i \le rM_J/2.
\]
Markov's inequality now gives
\[
\sum_{i\in J}u_i(B_i-1/2)\ge M_J/2-\gamma^{-1}\sqrt{\ell/n}
\]
with probability at least \(1-e^{-\ell}\). This bound remains valid when \(M_J=0\).

On the alternative \(V_H+V_J\ge2\varepsilon\). If \(V_H\ge\varepsilon\), choosing \(n\varepsilon^2/\ell\) sufficiently large ensures \(\Delta\ge8\sqrt{\ell/n}\) on both good events. Otherwise \(V_J\ge\varepsilon\). For the portion of \(J\) with \(a_i|u_i|>1\), Lemma 2 gives a mean proportional to its absolute mass. If that mass is below \(\varepsilon/2\), the other portion has absolute mass at least \(\varepsilon/2\), and Cauchy--Schwarz gives a mean at least \(c\varepsilon^2/(\sum_i 1/a_i)\). Since
\[
\sum_i \frac1{a_i}\le \frac{k+\sqrt{2nk}}{n},
\]
the light mean is at least \(c\min(n\varepsilon^2/(k+\sqrt{2nk}),\varepsilon)\). Its ratio to \(\sqrt{\ell/n}\) can be made arbitrarily large by increasing the universal multiplier in \(n\). The first two terms of \(R\) ensure respectively \(n^{3/2}\varepsilon^2\ge Ck\sqrt{\ell}\) and \(n\varepsilon^2\ge C\sqrt{k\ell}\). The third ensures \(\varepsilon\ge C\sqrt{\ell/n}\). Thus the same contrast conclusion holds in this case.

The actual training and ideal training agree whenever both requested lengths are at most \(2n\). Each overflow probability is at most \(\exp(-(2\log2-1)n)\). Given any trained set, the difference of the holdout averages has upper and lower tail bounds \(\exp(-nt^2)\) at distance \(t\) from \(\Delta\), by Hoeffding's inequality for \(2n\) independent terms each with range length \(1/n\). Under the null \(\Delta=0\) for every set. Under the alternative the established contrast and the overflow bound, together with \(\ell=\log(16/\delta)\) and large enough \(n\), give type II error at most \(\delta\). This proves the upper bound.

## 4. Unrestricted lower bound

We use distributional lower bounds in which the test may be randomized. For a null mixture \(P_0\), an alternative experiment \(P_1\), and a decision with rejection probabilities \(P_0(\mathrm{reject})\le\delta\) and \(P_1(\mathrm{reject})\ge b\), Cauchy--Schwarz gives
\[
 b^2\le\delta\,\mathbb E_0[(dP_1/dP_0)^2].
 \qquad\text{(1)}
\]
A randomized decision can be treated as a test on an enlarged space with common independent randomization, leaving the likelihood ratio unchanged.

### 4.1 Dense and binary terms

Let \(h=\lfloor k/2\rfloor\) and use only the first \(2h\) symbols. Fix \(q\) uniform there. For independent uniform \(\sigma_j\in\{-1,1\}\), give \(p\) the probabilities
\[
p_{2j-1}=(1+2\varepsilon\sigma_j)/(2h),\qquad
p_{2j}=(1-2\varepsilon\sigma_j)/(2h).
\]
Each such \(p\) has \(\operatorname{TV}(p,q)=\varepsilon\). Under the null \(p=q\). The \(q\) stream is identical and independent under both mixtures. For \(m\) fixed draws from \(p\), the likelihood second moment is
\[
\begin{aligned}
\mathbb E_0[(dP_1/dP_0)^2]
 &=\mathbb E_{\sigma,\tau}
 \Big(1+\frac{4\varepsilon^2}{h}\sum_{j=1}^h \sigma_j\tau_j\Big)^m\\
 &\le \cosh(4m\varepsilon^2/h)^h
 \le \exp(8m^2\varepsilon^4/h).
\end{aligned}
\]
The first line follows by computing the single-draw inner product of the two likelihood ratios and multiplying by independence. The inequalities use \(1+x\le e^x\) and \(\log\cosh x\le x^2/2\). Equation (1) with \(b=1-\delta\) implies \(m\ge c\sqrt{kL}/\varepsilon^2\).

On two symbols take \(q=(1/2,1/2)\) and compare the alternative \(p=(1/2+\varepsilon,1/2-\varepsilon)\) with \(p=q\) under the null. The single-sample relative entropy is at most \(\chi^2(p,q)=4\varepsilon^2\). Additivity and decision data processing yield
\[
 4m\varepsilon^2\ge (1-2\delta)\log((1-\delta)/\delta).
 \qquad\text{(2)}
\]
This gives \(m\ge c L/\varepsilon^2\); it also gives \(m\ge36\) on the stated parameter range.

### 4.2 Sparse term

Suppose \(m\le h/4\), and put \(\eta=m/h\) and \(\theta=8\varepsilon\le1/2\). The following prior specifies two unnormalized positive measures on \(h\) pairs of symbols. Independently give each pair a heavy type with probability \(\eta\). A heavy pair has mass \(1/m\) under each measure; a light pair has mass \(1/h\) under each measure. Within heavy pairs, split the mass uniformly under both hypotheses. Under the null split light pairs uniformly too. Under the alternative, in each light pair draw an independent uniform sign \(\sigma\). Split its mass proportionally to \((1+\theta\sigma,1-\theta\sigma)\) in the first measure and to \((1-\theta\sigma,1+\theta\sigma)\) in the second.

If \(G\) is the number of heavy pairs, both measures have mass
\[
D=1+G(1/m-1/h)\ge1.
\]
On \(G\le2m\), \(D\le3\) and at least \(h/2\) pairs are light. Upon division by \(D\) the null measures coincide and the alternatives on this event have total variation \(\theta(h-G)/(hD)\ge\theta/6\ge\varepsilon\). Since \(G\sim\mathrm{Bin}(h,\eta)\) with mean \(m\), \(\Pr(G>2m)\le \exp(-(2\log2-1)m)\).

Now observe independent counts at each symbol and for each law, with rate \(4m\) times the corresponding unnormalized mass. Conditional on the measures, each stream total is \(\mathrm{Poi}(4mD)\), and uniform ordering of its observed labels yields independent observations from the corresponding normalized law, conditional on the stream total. Therefore any test with budget \(m\) can be simulated by taking the first \(m\) labels from each stream, or accepting when either total is below \(m\). Each low-total probability is at most \(\exp(-9m/8)\), by the multiplicative Poisson lower-tail bound and \(D\ge1\). This simulated test rejects with probability at most \(\delta\) under the Poisson null mixture. Under the Poisson alternative mixture it rejects with probability at least
\[
 1-\delta-\exp(-(2\log2-1)m)-2\exp(-9m/8)\ge2/3 ,
\]
using \(m\ge36\) from (2). The validity of this reduction does not require independence between the normalization event and the sample counts.

We next compute the likelihood second moment of the original Poisson counts, before any ordering or truncation. Under each mixture the data in distinct pairs are independent. In a single pair let \(b\) be the pooled count from both streams and both symbols. Its common law is
\[
 w_b=\eta F_8(b)+(1-\eta)F_{8\eta}(b),\qquad
 F_z(b)=e^{-z}z^b/b!.
\]
Under the null the four labels conditional on \(b\) have equal probabilities, for either pair type. For a light alternative pair, conditional on the random sign and on \(b\), the four-label probabilities are proportional to two instances of \(1+\theta\sigma\) and two of \(1-\theta\sigma\) in a fixed ordering. Relative to the null the resulting conditional likelihood of the light mixture has second moment minus one
\[
v_b=\tfrac12[(1+\theta^2)^b+(1-\theta^2)^b]-1.
\]
Indeed, two copies of the random sign yield single-label likelihood inner product \(1+\theta^2\sigma\tau\), whose \(b\)-th power is averaged over both signs. This calculation applies to label counts because the likelihood depends only on those counts. In particular \(v_0=v_1=0\), and \(v_b\le2^b\theta^4\) for \(b\ge2\) by the binomial expansion and \(0\le\theta\le1/2\).

The conditional likelihood departure from one is the light-mixture departure weighted by \((1-\eta)F_{8\eta}(b)/w_b\). Consequently the pair's \(\chi^2\) divergence is bounded by
\[
\begin{aligned}
 \sum_b \frac{(1-\eta)^2 F_{8\eta}(b)^2}{w_b} v_b
 &\le \eta^{-1} e^8\theta^4\sum_{b\ge2}\frac{(16\eta^2)^b}{b!}
 \le C\theta^4\eta^3.
\end{aligned}
\]
In the first inequality we used \(w_b\ge\eta F_8(b)\). In the second, \(16\eta^2\le1\), so the tail sum is at most a constant times \(\eta^4\). Multiplying the pairwise second moments gives
\[
\mathbb E_0[(dP_1/dP_0)^2]\le \exp(C h\theta^4\eta^3)
 \le \exp(C'm^3\varepsilon^4/h^2).
\]
Equation (1) with \(b=2/3\) and \(\delta\le1/4\) implies \(m\ge c h^{2/3}L^{1/3}/\varepsilon^{4/3}\).

For \(m>h/4\), denote the sparse target by \(A=h^{2/3}L^{1/3}/\varepsilon^{4/3}\) and the dense target by \(B=\sqrt{hL}/\varepsilon^2\). If \(A\le B\), the dense lower bound already controls \(A\). If \(A>B\), then \(h\varepsilon^4>L\), so \(A<h\) and \(m>h/4\ge A/4\). Since \(h\ge k/3\) and the sum of three nonnegative terms is at most three times their maximum, the three lower bounds together establish Theorem 1.

## 5. Relation to the documented open direction

The archived *Classification Accuracy Augmented Goodness-of-Fit* case identifies extensions to testing two unknown distributions in Section 5. Its supplement *Confidence-optimal identity testing with one original-alphabet hard classifier* supplies the known-reference single-classifier result. Here independent counts from both unknown laws determine the classifier and two holdout streams estimate its contrast. The dense and binary lower bounds use the usual rare-alternative second-moment and two-point arguments, with proofs included; the heavy/light calculation supplies the additional sparse-regime lower bound in the two-unknown experiment. The claim concerns the fixed-map holdout protocol and the stated parameter range. The training stream remains on the original alphabet, and ordered iid samples are assumed. The archival comparison is documented in the accompanying source and novelty records.
