---
title: "Optimal identity testing with one hard classifier"
subtitle: "An original-alphabet classifier with confidence-optimal sample size"
date: "25 November 2026"
geometry: margin=0.9in
---

## Abstract

Classification-based identity testing fits a classifier on training data and compares its acceptance frequencies on two held-out samples. A prior log-free sparse test for a known reference uses fresh augmentation at prediction. We construct one binary classifier on the original alphabet and obtain worst-case sample size \(O((\sqrt{k\log(1/\delta)}+\log(1/\delta))/\epsilon^2)\) for alphabet size \(k\), total-variation separation \(\epsilon\), and error probability \(\delta\). Heavy reference symbols are treated jointly. The remaining symbols use a Poisson threshold within each reference-probability group. A separate training block chooses one fitted set before testing. A summability argument couples the number of relevant groups to the confidence scale. The resulting holdout statistic has the same minimax order as unrestricted identity testing.

## 1. Setting and result

Let \(p,q\) be probability distributions on \([k]\), where \(k\ge2\) and \(q\) is known. We test \(p=q\) against \(\operatorname{TV}(p,q)\ge\epsilon\), with \(0<\epsilon\le1\). A training algorithm outputs a single set \(A\subseteq[k]\) using observations and independent training randomness. On each fresh observation it predicts the binary label \(\mathbf1_A\). The testing statistic uses only the signed difference of that set's two empirical frequencies on independent holdouts from \(p\) and \(q\). The decision threshold can use the known reference mass \(q(A)\). The known law also permits simulated draws from \(q\).

Gerber, Han and Polyanskiy [1, §3.1.3, Proposition 12 and following discussion] leave open removal of an additional alphabet logarithm in classification-based testing. The known-reference sparse result in [2] achieves the optimal order by adding a fresh clone coordinate to each example, expressly leaving fixed original-alphabet hard classifiers open. We solve this fixed-classifier version for known-reference identity testing. The construction allows arbitrary \(q\), including zero coordinates, and applies across sparse and dense sample regimes.

**Theorem 1.** There is an absolute constant \(C\) with the following property. For \(0<\delta\le1/4\), set \(\ell=\log(64/\delta)\) and take an integer
\[
 n\ge C\frac{\sqrt{k\ell}+\ell}{\epsilon^2}.
 \qquad\text{(1)}
\]
There is a procedure using at most \(5n\) observations from \(p\) and \(n\) simulated observations from \(q\). It outputs one hard set \(A\) before accessing either holdout, and both error probabilities are at most \(\delta\). On the worst reference \(q\) and for \(0<\epsilon\le1/4\), unrestricted fixed-sample tests also require \(\Omega((\sqrt{k\log(1/\delta)}+\log(1/\delta))/\epsilon^2)\) observations from \(p\).

For \(\log(1/\delta)\le k\), the \(\sqrt{k\log(1/\delta)}\) term dominates. This includes the sparse range of [2]. The lower bound concerns the worst reference at small to moderate separation. The estimator of the labels can use different statistical methods on different parts of the alphabet, but a tested prediction always uses the one fixed indicator on the original symbol.

## 2. A one-symbol Poisson estimate

Let \(X\) have a Poisson law with mean \(\lambda+\sigma v\ge0\), where \(\lambda>0\) and \(\sigma=\sqrt{\max(1,\lambda)}\). When \(\lambda\le1\), let \(B=\mathbf1_{\{X\ge1\}}\). When \(\lambda>1\), let \(B=\mathbf1_{\{X\ge\lceil\lambda\rceil\}}\). Write \(\pi(v)=\mathbb E B\) and \(\pi_0=\pi(0)\). There are universal positive constants \(c_1,c_2\) such that
\[
 M(v):=v(\pi(v)-\pi_0)\ge c_1\min(v^2,|v|),
 \qquad
 \mathbb E e^{-s(vB-\mathbb E[vB])}\le e^{c_2s^2M(v)}
 \quad (0\le s\le1/8).
 \qquad\text{(2)}
\]

For \(\lambda\le1\), the activation probability is \(1-e^{-(\lambda+v)}\), and its derivative is bounded below by \(e^{-5/4}\) on the intersection of the domain with \(|v|\le1/4\). For \(\lambda>1\), let \(h=\lceil\lambda\rceil-1\). Differentiation of the Poisson tail gives
\(\pi'(v)=\sqrt\lambda\,\Pr(\operatorname{Pois}(\lambda+\sqrt\lambda v)=h)\).
For \(|v|\le1/4\), put \(x=\lambda+\sqrt\lambda v\). Then \(h\in[\lambda/2,\lambda]\), \(x\ge3\lambda/4\), and \(|x-h|\le(5/4)\sqrt\lambda\). Stirling's bound yields
\[
 \Pr(\operatorname{Pois}(x)=h)
 \ \ge\ c h^{-1/2}
       \exp[-h(x/h-1-\log(x/h))]\ \ge\ c'/\sqrt\lambda .
\]
The second inequality holds because \(x/h\) stays in a fixed compact positive interval and \((x-h)^2/h=O(1)\). Integrating the derivative up to signed distance \(\min(1/4,|v|)\), and using monotonicity beyond it, proves the first inequality in (2).

When \(|v|\le1\), the centered Bernoulli term has magnitude at most \(|v|\). The exponential remainder bound \(e^u-1-u\le u^2 e^{|u|}/2\) gives log moment \(O(s^2v^2)\). When \(v>1\), let the adverse indicator be \(D=1-B\); when \(v<-1\), use \(D=B\). In both cases \(-s(vB-\mathbb E[vB])=s|v|(D-\mathbb E D)\). For \(\lambda\le1\) the positive tail \(\mathbb E D=e^{-(\lambda+v)}\), and the negative case is outside the domain. For \(\lambda>1\), the Poisson lower-tail bound for \(v>1\) gives
\(\mathbb E D\le\exp[-v^2/(2(1+v/\sqrt\lambda))]\le e^{-v/4}\).
For \(v<-1\), the upper-tail bound to threshold \(\lceil\lambda\rceil\le2\lambda\) gives \(\mathbb E D\le e^{-v^2/4}\). These bounds also apply if the Poisson mean is zero, with the adverse event then impossible on the negative side. Writing \(w=\mathbb E D\), the log moment of \(s|v|(D-w)\) is at most \(w(e^{s|v|}-1-s|v|)=O(s^2|v|^2 e^{-|v|/8})=O(s^2|v|)\). The first inequality in (2) gives the second.

For a finite group of \(N\) symbols with a reference upper mass \(u>0\), let \(\lambda=nu\), \(a=n/\sqrt{\max(1,\lambda)}\), and \(v_i=a(p_i-q_i)\). If their observed training counts are independent Poisson variables of means \(np_i\), adding independent Poisson counts of means \(n(u-q_i)\) gives the above model. The set \(S\) comprises symbols with threshold indicator one. Let \(G\) be the group, \(\Delta(E)=p(E)-q(E)\), and let \(V=\sum_{i\in G}|p_i-q_i|\). The centered training contrast
\[
 J=\Delta(S)-\pi_0\Delta(G),\qquad \mu=\mathbb E J,
\]
satisfies
\[
 \mu\ge c\min(aV^2/N,V),\qquad
 \Pr(J<\mu/2)\le e^{-c a\mu}.
 \qquad\text{(3)}
\]
Indeed \(aJ=\sum_i v_i(B_i-\pi_0)\). Either the summands with \(|v_i|\le1\) carry at least half the total absolute mass, in which case Cauchy–Schwarz applies to their squares, or the larger terms carry at least half. This proves the first inequality. For the second use (2) by independence, and apply exponential Markov with any fixed \(s>0\) small enough that \(c_2s^2<s/4\).

## 3. Training candidates and selecting one set

Use three independent portions from \(p\) before testing: \(n\) observations for heavy symbols, \(2n\) for Poisson counts, and \(n\) for candidate selection. Use \(n\) additional observations for the holdout. Fix a large absolute \(K\), say \(4096\), let \(u_H=K/(n\epsilon^2)\), and write \(H=\{i:q_i>u_H\}\).

From the first portion estimate each \(p_i\) by its sample proportion for \(i\in H\). The two candidate sets on \(H\) are the nonnegative and the negative empirical deviations from \(q_i\). For the other symbols use a light group \(G_0=\{i:q_i\le\min(u_H,1/k)\}\) with upper mass \(u_0=\min(u_H,1/k)\). If \(u_H>1/k\), further use the nonempty intervals \(u_j/2<q_i\le u_j\), \(u_j=2^j/k\), intersected with \(H^c\), indexed by \(1\le j\le J_{\max}=\lceil\log_2(k\min(u_H,1))\rceil\). When \(u_H\le1/k\) put \(J_{\max}=0\). Denote all the groups by \(G_j\), their sizes by \(N_j\), and their nominal error logarithms by \(\ell_j=\ell+2j+4\). Use \(\ell_H=\ell+4\) for each heavy candidate.

Draw \(L_0\sim\operatorname{Pois}(n)\) independently. If \(L_0>2n\), designate the empty set as the classifier. Otherwise count symbols in the first \(L_0\) observations of the Poisson portion, and use the padding and thresholds of Section 2 within each group. Add the resulting learned set \(S_j\) and the whole group \(G_j\) to the candidates. The analysis can first use an infinite auxiliary sequence, whose first \(L_0\) observations give independent Poisson counts across all symbols. On \(L_0\le2n\) the actual candidate list agrees with this ideal list. The overflow probability is at most \(e^{-n/3}\). Using (1), this is at most \(e^{-\ell}\) with a large enough constant.

For a candidate \(E\) with log parameter \(v\), define
\[
 R_v(E)=\sqrt{q(E)v/n}+v/n.
\]
On the selection portion compute the empirical \(p\)-frequency \(\widehat p(E)\). Select any candidate with \(|\widehat p(E)-q(E)|\ge40 R_v(E)\) in a predetermined order, or the empty set if none passes. By Bernstein and \(\sqrt{2|\Delta|v/n}\le|\Delta|/4+2v/n\), for each candidate independently of its construction,
\[
 |\widehat p(E)-p(E)|\le3R_v(E)+|\Delta(E)|/4
 \qquad\text{(4)}
\]
with conditional probability at least \(1-2e^{-v}\). This is a statement for a candidate fixed by the preceding training history. A union bound covers the whole list using at most \(6e^{-\ell}\) of error probability. On this event any candidate with \(|\Delta(E)|\ge60 R_v(E)\) passes, and any passing candidate satisfies \(|\Delta(E)|\ge29 R_v(E)\).

If the selected candidate \(E\) has negative validation contrast, use its complement as the final classifier set \(A\); otherwise use \(A=E\). On the good selection event, the validation sign agrees with the true sign for every passing candidate by (4). Thus the final signed contrast is \(\Delta(A)=|\Delta(E)|\ge29R_v(E)\). The empty fallback is retained without complementation.

The set \(A\) is fixed before both holdouts. Put
\[
 R_\ell^*(A)=\sqrt{\min(q(A),1-q(A))\,\ell/n}+\ell/n.
\]
Reject when the signed empirical difference satisfies
\[
 \widehat p_{\mathrm{test}}(A)-\widehat q_{\mathrm{test}}(A)
 \ge 12 R_\ell^*(A).
 \qquad\text{(5)}
\]
With one class label for \(p\) and the other for \(q\), this statistic is twice the balanced held-out accuracy minus one. Conditional on \(A\), apply (4) with \(v=\ell\) to its smaller side in \(q\)-mass, for both holdouts. Passing to the complement only negates the empirical difference and the true contrast. The sum of their exceptional probabilities is at most \(4e^{-\ell}\). On the good holdout event, the estimated difference differs from \(\Delta(A)\) by at most \(6R_\ell^*(A)+|\Delta(A)|/4\). Under the null this cannot trigger (5). Under the alternative \(R_\ell^*(A)\le R_v(E)\), so any passing candidate on the good selection event clears (5). We prove that the list contains at least one sufficiently strong candidate next.

## 4. There is a sufficiently strong candidate

If \(H\) carries at least \(\epsilon\) of absolute deviation, then one of its candidates is strong with probability at least \(1-e^{-\ell}\). In fact \(|H|\le n\epsilon^2/K\), so the expected sum \(\sum_{i\in H}|\widehat p_i-p_i|\) is at most \(\sqrt{|H|/n}\le\epsilon/\sqrt K\). Bounded differences, with per-sample change \(2/n\), puts this sum below \(\epsilon/16\) with probability at least \(1-e^{-c n\epsilon^2}\). Using the estimated signs loses at most twice this sum in the true signed contrast. Thus one of the two heavy candidates has absolute contrast at least \(7\epsilon/16\). By (1), \(60 R_{\ell_H}(E)\le7\epsilon/16\), since \(q(E)\le1\). The probability claim also follows from (1).

For a nonempty group abbreviate \(u=u_j\), \(N=N_j\), \(v=\ell_j\), \(G=G_j\), and \(V=\sum_{i\in G}|p_i-q_i|\). Write
\[
 T_j=\begin{cases}
 u\sqrt{Nv}+v/n, & nu\le1,\\[2pt]
 \sqrt{Nu\,v/n}+v\sqrt{u/n}, & nu>1.
 \end{cases}
 \qquad\text{(6)}
\]
Put \(a_j=n/\sqrt{\max(1,nu_j)}\). For an absolute constant \(C_1\), a sufficient condition for this group to produce a candidate with contrast at least \(60 R_v\) is
\[
 V\ \ge\ C_1\left(T_j+\sqrt{N_jT_j/a_j}\right).
 \qquad\text{(7)}
\]
The conclusion holds in the ideal count experiment with probability at least \(1-2e^{-v}\).

To prove (7), the whole-group candidate is already strong if \(|\Delta(G)|\ge60 R_v(G)\). Otherwise \(|\Delta(G)|<60(\sqrt{Nu\,v/n}+v/n)\), so \(n\,p(G)\le C(nNu+v)\). In the sparse case \(nu\le1\), the total padded count has Poisson mean \(nNu+n\Delta(G)\le C'(nNu+v)\). With probability at least \(1-e^{-v}\) its value is at most \(2C'(nNu+v)+2v\), by the exponential moment at parameter \(1/2\). Since the number of occupied symbols cannot exceed this count, \(q(S)\le C''u(nNu+v)\) there. This yields \(R_v(S)=O(T_j)\), using \(\sqrt{u/n}\le1/n\). Moreover \(\pi_0\le nu\) implies
\(\pi_0|\Delta(G)|=O(u\sqrt{Nv}+v/n)=O(T_j)\).
In the dense case \(nu>1\) use directly \(q(S)\le q(G)\le Nu\) and \(\pi_0\le1\). They imply \(R_v(S)+\pi_0|\Delta(G)|=O(T_j)\), since \(v/n\le v\sqrt{u/n}\). In both cases \(T_j\ge v/a_j\). Formula (3) and (7) make \(\mu\) exceed a sufficiently large constant times \(T_j\), and \(J\ge\mu/2\) except with probability \(e^{-v}\). Then \(\Delta(S)=J+\pi_0\Delta(G)\ge60 R_v(S)\). This proves (7).

We now bound the sum of the right sides in (7). The groups satisfy \(N_j\le2k/2^j\) for \(j\ge1\), \(N_0\le k\), \(u_j\le2u_H\), and \(\sum_j N_j u_j\le3\), because the light group contributes at most one and the other groups have \(N_j u_j\le2q(G_j)\). If \(\ell\le k\), equation (1) gives
\[
 J_{\max}\le C_K+\tfrac12\log_2(k/\ell).
\]
For \(\ell>k\) it gives \(J_{\max}\le C_K\). Let \(M=\sqrt{k\ell}+\ell\). Then
\[
 \sum_{j=0}^{J_{\max}}\ell_j\le C_K' M,\qquad
 \ell+J_{\max}+1\le C_K' M.
 \qquad\text{(8)}
\]
For example, at \(\ell\le k\) the numerator in the first bound is \(O_K(\ell(1+\log(k/\ell))+(1+\log(k/\ell))^2)\). After division by \(\sqrt{k\ell}\) the first term is bounded by a constant using \(\sqrt{x}(1+\log(1/x))\), \(x=\ell/k\). The second is bounded by \((1+\log k)^2/\sqrt k\) times a constant, since \(\ell\ge1\). Both functions are bounded on their required domains.

For both regimes, the square-root term in (7) has a contribution at most
\[
 \frac{N_j^{3/4}\sqrt{u_j}\,\ell_j^{1/4}}{\sqrt n}.
\]
Its sum is \(O(k^{1/4}\ell^{1/4}/\sqrt n)\), by the geometric bound \(N_j^{3/4}\sqrt{u_j}\le 2^{3/4}k^{1/4}2^{-j/4}\), including the light group. The other square-root contribution is \(\sqrt{N_j\ell_j}/n\) in the sparse case and \(\sqrt{N_j u_j\ell_j/n}\) in the dense case. Their sums are respectively \(O(\sqrt{k\ell}/n)\) by geometric summation and \(O(\sqrt{M/n})\) by Cauchy–Schwarz and (8). In (6), the sparse term \(u_j\sqrt{N_j\ell_j}\) is no larger than \(\sqrt{N_j u_j\ell_j/n}\), and the same bound describes the corresponding dense term. The sum of sparse \(\ell_j/n\) is \(O_K(M/n)\). In the dense term \(\ell_j\sqrt{u_j/n}\) the upper masses grow geometrically and end at most at \(2u_H\); hence their sum is \(O_K((\ell+J_{\max}+1)/(n\epsilon))=O_K(M/(n\epsilon))\), also for the single light group. In total, for fixed \(K,C_1\), taking the constant \(C\) in (1) sufficiently large makes the sum of all thresholds in (7) less than \(\epsilon\).

If the alternative has \(\operatorname{TV}(p,q)\ge\epsilon\), the sum of absolute deviations is at least \(2\epsilon\). Either the heavy absolute deviation is at least \(\epsilon\), or the other groups have sum at least \(\epsilon\) and some group satisfies (7). This choice of a group for the proof depends only on \(p,q\), so its training failure probability is bounded by \(2e^{-\ell}\) without a data-dependent choice. Add the Poisson overflow, selection, and holdout exceptional probabilities. They sum to less than \(\delta\). Type I control was conditional on the selected set and holds for every training outcome. This proves the upper bound in Theorem 1.

## 5. Matching lower bounds

For the \(\sqrt{k\log(1/\delta)}\) term, put \(h=\lfloor k/2\rfloor\) and take \(q\) uniform on \(2h\) symbols organized in pairs. In each pair give the two symbols probabilities \(q_i(1\pm2\epsilon\sigma_j)\), where \(\sigma_j\) is an independent symmetric sign. Every resulting law has total variation \(\epsilon\) from \(q\). Extra symbols, if any, have probability zero. For \(m\) observations from \(p\), let \(D\) be the likelihood ratio of the mixture over the signs relative to \(q^{\otimes m}\). Independence of samples under each sign vector gives
\[
 \mathbb E_q D^2
 = \mathbb E_{\sigma,\sigma'}
 \left(1+\frac{4\epsilon^2}{h}\sum_{j=1}^h\sigma_j\sigma'_j\right)^m
 \le \exp(8m^2\epsilon^4/h).
\]
Use \(1+x\le e^x\) and \(\cosh z\le e^{z^2/2}\). Any test with both errors at most \(\delta\) rejects with mixture probability at least \(1-\delta\). Cauchy–Schwarz and its null error bound give \((1-\delta)^2\le \delta\,\mathbb E_qD^2\), also after including independent procedural randomness and observations from \(q\). Since \(\delta\le1/4\), this implies \(m\ge c\sqrt{k\log(1/\delta)}/\epsilon^2\).

For the other term, use a two-symbol reference with probabilities \(1/2,1/2\) and alternative \(1/2+\epsilon,1/2-\epsilon\). Its one-sample relative entropy is \(O(\epsilon^2)\) for \(0<\epsilon\le1/4\). Data processing onto the decision under the two product laws gives a relative-entropy lower bound of order \(\log(1/\delta)\), since the rejection probabilities are at least \(1-\delta\) and at most \(\delta\). Thus \(m\ge c'\log(1/\delta)/\epsilon^2\). The maximum of these two lower bounds is at least a constant times their sum.

## 6. Relation to previous work

The null-equalization idea is shared with [2]. There it creates a single occupied set on a cloned alphabet with fresh randomized prediction on the original example. Here padding and thresholding are applied only in training. On the original alphabet a single group retains its own scale, and the whole-group candidate absorbs a group-mass deviation that could cancel its learned contrast. A heavy-set estimator compresses the remaining scale range in proportion to the confidence requirement. That compression and the summability in (8) prevent the candidate-selection penalties from contributing an alphabet logarithm. The final classifier has exactly one fitted set over the original symbols. It uses the known reference both to generate training noise and to choose confidence thresholds.

This resolves the known-reference part of the fixed-hard-classifier problem. Unknown-reference closeness and tests with a prescribed training rule are separate questions. The bounds concern sample complexity. The finite reproduction checks supplied with the paper illustrate the classifier protocol and verify representative exact count calculations, while the preceding proof gives the uniform probability bound.

## References

[1] Patrik R. Gerber, Yanjun Han and Yury Polyanskiy. *Minimax optimal testing by classification*. COLT 2023, PMLR 195:5395–5432, especially §1.1, §3.1.3 and Proposition 12. <https://proceedings.mlr.press/v195/gerber23a.html>.

[2] earlier research manuscript. *Log-free sparse goodness-of-fit by one augmented binary classifier*. Fixed archive bb30fe2, especially §§2–5.

[3] Liam Paninski. *A coincidence-based test for uniformity given very sparsely sampled discrete data*. IEEE Transactions on Information Theory 54(10), 4750–4755 (2008). The paired-sign construction in Section 5 is the standard uniformity-testing mixture.
