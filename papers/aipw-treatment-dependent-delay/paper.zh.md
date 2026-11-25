# 处理相关延迟下实用 AIPW 的时间一致误差与积压周转前沿

## Sharp error rates and observable calibration for entry-frozen AIPW with treatment-dependent delays

**Research manuscript, 25 November 2026.** The results below are ordinary mathematical proofs. This version has no Lean certificate and is not an externally peer-reviewed publication. Full formalization is a separate, still-required delivery.

## 通俗摘要

随机实验中，入组与结果返回通常并不同步，而且处理本身可能改变返回时间。提前预测每个单位的最终结果，有助于减少估计误差；但尚未返回的单位形成一个持续变化的队列。即使最终预测完全准确，另一实验组的潜在返回状态仍不可见，因而预测准确并不等于当前累计效果已知。

本文固定一个可以实际计算的增强逆概率加权估计器，完整刻画其最坏时间一致误差的数量级。误差由预测残差和待完成队列两部分组成；队列项除了当前平方负载，还必须支付反复换批扫描的代价。我们进一步构造只依赖已观测事件和入组记录的置信带，分别校准未观测的队列负载和累计参与质量，并证明：在真实误差恒为零的基准表上，任何必须对所有潜在表诚实的可观测规则仍有不可消除的对数置信度成本。该成本同时出现在隐藏结果与纯隐藏延迟两种机制中。新增的历史最大负载校准进一步使同一个不输入真实预算的规则，在残差预算不超过积压预算、积压预算至少达到置信度对数的整个非零区域，达到可观测全路径最大半径的匹配最优阶。

证明覆盖任意有限样本量、分数预测、极小置信概率、同时发生的入组与事件，以及永不发生的事件。固定估计器的误差下界，不被解释为所有估计器的误差下界。所述非零区域之外的完整适应最优性，以及逐时当前负载上的最优性，仍是开放问题。

## 1. Problem, information and contribution

Lindon and Kallus [LK26, Sections 5 and 7] develop design-based continuous monitoring with staggered entry and treatment-dependent outcomes and discuss prediction augmentation, including an implementability gap for practical prediction-enhanced bounds. Related sequential AIPW and prediction-powered methods already exist [CMR24; H21; HBLT26; KCC25]. Delayed selective-audit inference with a pending-outcome correction also exists [Ao26, EC.5]. Our question is narrower than a general theory of prediction-powered inference: what is the complete worst-case error order of a specified, implementable center when its pending predictions can repeatedly turn over, and what can be certified from observed histories?

The contribution has four parts. **FC-1** determines the fixed-center deterministic radius over a finite weighted-calendar class, including the small-weight and extreme-confidence regimes. **OBS-1** constructs a genuinely observed-data confidence band and proves a comparison in terms of three hidden oracle clocks; the clocks describe performance and are never algorithm inputs. **CAL-1** matches the necessary adaptation cost at the zero-oracle boundary, separately for hidden residuals and hidden delays. **CAL-2** gives a distinct interval-length lower bound allowing any center. The added **OBS-2/WIDTH-1** results prove matching observable maximal-radius rates throughout a nonzero parameter region, attained by the same budget-free rule that retains the sharp zero-oracle comparison. Standard exponential inequalities, chaining, stitching and indistinguishability are tools, not claims of newly invented general probability principles.

### 1.1 Fixed randomization model

Fix an integer \(N\ge1\) and \(\epsilon\in(0,1/2]\). Unit \(i\) has a finite deterministic entry time \(E_i\). Its two potential event times satisfy \(T_i(a)\in[E_i,\infty]\), and its potential eventual outcomes and predictions satisfy \(y_i(a),m_i(a)\in[0,1]\), for \(a\in\{0,1\}\). Assignments are independent across units, with deterministic probabilities \(p_i(a)\in[\epsilon,1-\epsilon]\). Potential tables are fixed under this randomization distribution. External training data may be conditioned on, provided the predictions remain independent of the entire experimental assignment vector.

Only finite calendar times are reported. An event at infinity never occurs. At a tied time, process all entries and immediate events before reporting. An event record includes its occurrence flag even when its numerical outcome is zero. This distinguishes an observed zero from an unreturned event. Extra unmodelled logging delays are outside the theorem.

Fix one arm and suppress \(a\). Write \(I_i=\mathbf1\{A_i=a\}\), \(Z_i=I_i/p_i-1\), and \(d_i=y_i-m_i\). The target and the entry-frozen AIPW center are

\[
R(t)=\sum_{E_i\le t}y_i\mathbf1\{T_i\le t\},\qquad
\widehat R(t)=\sum_{E_i\le t}
\left[m_i+\frac{I_i}{p_i}
\left(y_i\mathbf1\{T_i\le t\}-m_i\right)\right].
\tag{M1}
\]

The target is cumulative potential reward, not the eventual mean outcome. Dividing both target and band by a specified positive deterministic normalizer gives a normalized version; no normalization is implicit here. For \(I_i=0\), the product containing a hidden event or outcome is evaluated as zero without querying that hidden variable.

The exact error decomposition is

\[
\widehat R(t)-R(t)=A_t-P_t,\quad
A_t=\sum_{T_i\le t}Z_i d_i,\quad
P_t=\sum_{E_i\le t<T_i}Z_i m_i.
\tag{M2}
\]

Define three different deterministic, generally unobserved clocks:

\[
V_t=\sum_{T_i\le t}d_i^2,\qquad
Q_t=\sum_{E_i\le t<T_i}m_i^2,\qquad
D_t=\sum_{E_i\le t,\ E_i<T_i}m_i^2.
\tag{M3}
\]

Here \(V_t\) counts completed residuals, \(Q_t\) is the current pending squared load, and \(D_t\) retains the mass of every nonempty interval that has entered, including intervals that have already ended. They cannot be interchanged.

For \(v,q\in[0,N]\), let \(\mathcal C_\epsilon(N,v,q)\) contain all such two-arm designs satisfying, in the target arm,

\[
\sum_{i=1}^{N}d_i^2\le v,\qquad \sup_{t<\infty}Q_t\le q.
\tag{M4}
\]

This class is nonempty for every allowed budget. The residual budget includes units whose potential events never occur. Define

\[
r_\star=\inf\left\{r\ge0:
\sup_{\mathcal D\in\mathcal C_\epsilon(N,v,q)}
\Pr_{\mathcal D}\!\left(\sup_{t<\infty}
|\widehat R(t)-R(t)|>r\right)\le\alpha\right\}.
\tag{M5}
\]

All suprema in time reduce to finitely many fixed calendar states. No stochastic-filtration martingale property is asserted for the total AIPW error or for its pending component.

## 2. The complete fixed-center rate

**Theorem FC-1.** Let \(0<\alpha\le1/4\), \(L=\log(1/\alpha)\), and

\[
F=\sqrt{v\min\{N,L\}},\qquad
G=\sqrt{q\min\{N,L+\log(eN/(1\vee q))\}},
\tag{M6}
\]

where \(G=0\) at \(q=0\). Uniformly over all \(N,v,q,\alpha\) in the stated ranges,

\[
\frac{F+G}{256}\ \le\ r_\star\
\le\frac1\epsilon
\left[
\min\left\{\sqrt{Nv},\sqrt{\tfrac12v\log(4/\alpha)}\right\}
+\min\left\{\sqrt{Nq},
7\sqrt{q[\log(2/\alpha)+\log(eN/(1\vee q))]}\right\}
\right].
\tag{M7}
\]

Thus \(r_\star\asymp_\epsilon F+G\). If \(v=q=0\), it is exactly zero. Constants are uniform in the four displayed parameters; their dependence on \(\epsilon\) is not claimed sharp.

**Proof structure.** Appendix A proves the upper inequality. After ordering finite potential events, the residual component is a subsequence of independent centered partial sums. The pending component is a weighted interval-incidence process: each coordinate enters once and leaves at most once. Its finite state path has total squared variation at most \(2N\min(1,q)\) under load bound \(q\). A direct chaining argument yields the logarithm in (M7). Appendix B proves the lower inequality with explicit Rademacher designs for residuals, confidence saturation, and disjoint queue batches. Separate valid designs establish the three terms; a single design need not attain all of them simultaneously.

The turnover factor is necessary. At fixed confidence, \(v=0\), \(q=1\), the worst-case radius grows as \(\sqrt{\log(eN)}\), despite every pending state having squared load at most one. When \(0<q<1\), fractional predictions allow batches of many small coefficients, and the logarithm is \(\log(eN)\), not \(\log(eN/q)\). The caps \(\sqrt{Nv}\) and \(\sqrt{Nq}\) preserve the valid extreme-confidence behavior.

## 3. An implementable band

Define observable statistics

\[
U_t=\sum_{T_i\le t}\frac{I_i d_i^2}{p_i^2},\quad
\widehat Q_t=\sum_{E_i\le t<T_i}\frac{I_i m_i^2}{p_i},\quad
W_t=\sum_{E_i\le t<T_i}\frac{I_i m_i^2}{p_i^2},\quad
\widehat D_t=\sum_{E_i\le t,\ E_i<T_i}\frac{I_i m_i^2}{p_i}.
\tag{M8}
\]

Each nonzero summand uses only the assigned arm's event history. The flag \(E_i<T_i\) is recorded at entry after processing immediate events and is retained thereafter. No counterfactual endpoint is required by (M8).

Put \(\delta=\alpha/5\), \(\lambda_j=(\epsilon/2)2^{-j}\), and, for \(u,w\ge0\),

\[
\mathcal B_R(u,\delta)=
\inf_{j\ge0}\left\{\lambda_j u+
\lambda_j^{-1}\log\frac{2(j+1)(j+2)}{\delta}\right\},
\tag{M9}
\]

\[
\mathcal B_F(w,N,\delta)=
\inf_{j\ge0}\left\{\lambda_j w+
\lambda_j^{-1}\log\frac{2(2N+1)(j+1)(j+2)}{\delta}\right\}.
\tag{M10}
\]

Both infima are computable by a finite search: once the increasing lower bound obtained by dropping the first summand exceeds the best objective found, all later indices can be discarded.

For \(b\ge1\), \(0<x\le b\), set

\[
\mathcal A(b,x,\delta)=
\log\frac{18eb}{\delta x}+2\log\log(eb),\qquad
H_b(x)=\sqrt{x\mathcal A(b,x,\delta)},\quad H_b(0)=0,\quad
K=14/\epsilon.
\tag{M11}
\]

The observed mass envelope, upper inverse and pending radius are

\[
B_t=1+2\widehat D_t+(2/\epsilon)\log(1/\delta),
\]
\[
q_t^+=\max\{x\in[0,B_t]:x\le\widehat Q_t+K H_{B_t}(x)\},
\qquad \mathcal B_P(t)=K H_{B_t}(q_t^+).
\tag{M12}
\]

The feasible set is a nonempty compact interval. Its endpoint is either \(B_t\) or the unique positive crossing of a convex scalar function. Bisection retaining the upper bracket gives a conservative numerical approximation in exact arithmetic. The supplied floating-point research implementation is not a certified outward-rounded numerical routine.

Finally, let

\[
S_t=\sum_{T_i\le t}I_i y_i,\qquad
n_{0,t}=\sum_{E_i\le t}(1-I_i),\qquad
\mathcal B_{\mathrm{det}}(t)=
\max\{|\widehat R(t)-S_t|,\,
|\widehat R(t)-S_t-n_{0,t}|\}.
\tag{M13}
\]

Every compatible target lies in \([S_t,S_t+n_{0,t}]\). Define

\[
b_t=\min\left\{\mathcal B_{\mathrm{det}}(t),\
\mathcal B_R(U_t,\delta)+
\min\{\mathcal B_P(t),\mathcal B_F(W_t,N,\delta)\}\right\}.
\tag{M14}
\]

**Theorem OBS-1 (coverage and oracle comparison).** For every fixed table in the full model, with no budgets supplied to the algorithm,

\[
\Pr\{\forall t<\infty:\ |\widehat R(t)-R(t)|\le b_t\}\ge1-\alpha.
\tag{M15}
\]

To state its performance comparison, let

\[
J(u)=\left\lceil\tfrac12\log_2(1+u)\right\rceil,\quad
\ell(u,\delta)=\log\frac{2(J(u)+1)(J(u)+2)}{\delta},
\]
\[
\Lambda_t=\ell(V_t/\epsilon^2,\delta),\quad
B_t^\star=1+(2/\epsilon)[D_t+\log(1/\delta)],\quad
a_t=\mathcal A(B_t^\star,1\vee Q_t,\delta).
\tag{M16}
\]

There is a constant \(C_\epsilon\), independent of the table and confidence level, such that pathwise

\[
b_t\le
\min\left\{\frac N\epsilon,\
C_\epsilon\left[
\sqrt{V_t\Lambda_t}+\Lambda_t+
\sqrt{Q_ta_t}+a_t\right]\right\}.
\tag{M17}
\]

For the whole class (M4), put
\(B_q=1+(2/\epsilon)[N\min(1,q)+\log(1/\delta)]\) and
\(\Lambda_v=\ell(v/\epsilon^2,\delta)\). A valid uniform comparison is

\[
b_t\le\min\left\{\frac N\epsilon,\
C_\epsilon\left[
\sqrt{v\Lambda_v}+\Lambda_v+
\sqrt{q\mathcal A(B_q,1\vee q,\delta)}
+\mathcal A(B_q,1,\delta)\right]\right\}.
\tag{M18}
\]

The additive term uses second argument **one**: \(\mathcal A(b,x,\delta)\) decreases in \(x\), although \(x\mathcal A(b,x,\delta)\) increases. Substituting \(1\vee q\) into that additive term would be unjustified.

**Proof.** Appendix C gives the scalar exponential inequality, the two computable grid boundaries, the three simultaneous calibration events behind (M12), and their probability allocation. In particular, \(\widehat D_t\) first upper-calibrates \(D_t\); interval localization then controls both \(P_t\) and \(\widehat Q_t-Q_t\); only afterwards is the upper inverse applied. This order is necessary because both oracle clocks contain counterfactual times. The deterministic support cap is always valid. Five failure events, each of probability at most \(\delta\), prove (M15), without an independence assumption between these events. Appendix C proves (M17) by bounding the inverse separately in its small and large root regimes; monotonicity and \(D_t\le N\min(1,q)\) give (M18).

The slowly varying and additive terms are explicit. We do not claim that this observable band is optimal on every nonzero-error table, that its constants are practically small, or that its mass-scale log-log term is necessary. The finite-state alternative (M10) can improve constants. Dropping that alternative and setting \(\delta=\alpha/4\) leaves a valid stochastic construction without using \(N\).

## 4. Sharp calibration at an oracle-zero table

**Theorem CAL-1.** Suppose the *global* budgets satisfy \(\sum_i d_i^2=0\) and \(\sup_t Q_t=0\). Then (M14) satisfies, on every assignment,

\[
\sup_t b_t\le C_\epsilon\min\{N,\log(1/\alpha)\}.
\tag{M19}
\]

Conversely, let a single nonnegative, observable AIPW-centered radius rule be honest with coverage \(1-\alpha\) on every fixed table in the full model, without receiving the true budgets. On each of the following two oracle-zero baseline tables, its radius \(r_0\) at time zero obeys

\[
\Pr_0\left\{r_0\ge
\frac{\min\{N,\log(1/\alpha)\}}{16}\right\}\ge\frac14,
\qquad
\mathbb E_0r_0\ge\frac{\min\{N,\log(1/\alpha)\}}{64}.
\tag{M20}
\]

Both baselines take \(p_i=1/2\) and \(E_i=T_i=0\). The first has \(m_i=y_i=0\). Its alternatives change only outcomes on fixed subsets. The second has \(m_i=y_i=1\). Its alternatives retain perfect predictions and change only event times on fixed subsets. Thus the second lower bound remains valid even in the model where perfect eventual prediction is known.

The upper bound follows because all \(d_i\) and all nonempty-interval prediction weights vanish; hence the observable square clocks and participation clock vanish. The remaining envelope and grid penalties have order \(\log(1/\alpha)\), capped by the deterministic support bound. For the lower bound, if a changed subset \(S\) is entirely unassigned to the target arm, its data are indistinguishable from the baseline while the fixed-center error equals \(|S|\). Averaging this fact over subsets yields the exact constraint

\[
\mathbb E_0\left[
\mathbf1\{r_0<k\}
\frac{\binom Mk}{\binom Nk}\right]\le\alpha,\qquad
M=\#\{i:I_i=0\}\sim\mathrm{Bin}(N,1/2).
\tag{M21}
\]

Appendix B proves the complete-range constants in (M20). This is an adaptation statement. It does not apply when the rule is explicitly told that both true budgets are zero. Also, \(V_t=Q_t=0\) at just one time does not imply (M19), because past nonempty intervals can make \(D_t>0\).

**Theorem CAL-2 (arbitrary-center interval length).** For any observable interval rule that is honest on every table, with any center, each of the same baselines satisfies

\[
\Pr_0\left\{\operatorname{length}(I_0)\ge
\frac{\min\{N,\log(1/\alpha)\}}{16}\right\}\ge\frac14,
\qquad 0<\alpha\le1/8.
\tag{M22}
\]

The proof uses baseline coverage as well as alternative-table coverage. The stated numerical probability is not extended to \(\alpha\in(1/8,1/4]\). This interval-length result is separate from FC-1; it is not an all-estimator oracle error theorem.

## 5. Boundaries and two-arm contrasts

| Situation | Valid conclusion |
| --- | --- |
| No delay is a known model restriction | \(P_t\equiv0\); use \(\mathcal B_R\) alone at the full confidence budget, recovering prediction-residual adaptation. |
| No delay has merely been observed | Hidden counterfactual delays remain possible; CAL-1 prohibits inferring a zero radius solely from those observations. |
| Perfect eventual predictions | \(A_t=0\), but \(P_t\) can be nonzero. Arbitrary pending turnover still matters. |
| No event occurs at finite times | \(A_t=0\), the target is zero, and the estimate's error is exactly \(-P_t\). This is a valid boundary, not a claim about an optimal alternative estimator. |
| An event is immediate | Its interval is empty; it contributes no pending or participation mass. |
| An event has value zero | Its occurrence must still be recorded; it is not indistinguishable from a missing event in the observation model. |
| Ties, reordering and treatment-dependent delays | All are allowed. The proof uses fixed potential calendars and independent assignments, without independence of delay and outcome. |
| Unknown infinite population or adaptive assignment | Not covered by the finite frozen model. No extension is silently asserted. |

For \(\Delta(t)=R_1(t)-R_0(t)\), compute each arm's band at level \(\alpha/2\). A union bound gives

\[
\Pr\left\{\forall t<\infty:
|\widehat R_1(t)-\widehat R_0(t)-\Delta(t)|
\le b_{1,t}+b_{0,t}\right\}\ge1-\alpha.
\tag{M23}
\]

Independence between arms is neither true nor needed. Since the event is simultaneous in time, it remains valid at a data-dependent reporting or stopping time.

## 6. Relation to prior work and limits

| Primary source | Shared subject or tool | Specific difference of the proved claims |
| --- | --- | --- |
| [LK26], Sections 3–5, 7 | Design-based cumulative-reward inference with delayed outcomes and prediction augmentation | FC-1 studies the entry-frozen observable center over explicit residual/load budgets; OBS-1 calibrates its hidden clocks rather than using an oracle endpoint process. |
| [Ao26], EC.5 | Prediction-powered inference with delayed selective labels/audits | Its superpopulation inference and pending correction do not state the fixed-potential-table \(N,v,q,\alpha\) error frontier, fractional-load scan regimes, or the two oracle-zero adaptation families proved here. |
| [CMR24], Theorem 5 | Sequential AIPW and finite-sample validity | AIPW plus time-uniform inference is established; our new target is treatment-dependent calendar geometry and the observable/oracle gap. |
| [H21] and [MP09] | Time-uniform concentration, empirical variance calibration | These supply the methodological background. Generic stitching and calibration are not novelty claims. |
| [vVW11] and [WP22] | Local maximal inequalities and multiscale scanning | Chaining and scan penalties are classical. The transposed interval-incidence class, its complete small-weight/saturation rate, and integration with hidden-calendar calibration are the objects proved here. |
| [HBLT26], [KCC25] | Design-based and prediction-assisted sequential inference | General sequential prediction augmentation is prior work; differences are limited to the precise finite-sample model and actual statements checked. |

The novelty conclusion is bounded by the primary documents and locations actually inspected. The manuscript makes no worldwide priority claim. Full-text availability and unresolved bibliographic leads are recorded in the accompanying novelty audit. No conclusion about an inaccessible theorem is inferred from a title.

The finite randomization model excludes predictors fitted using this same assignment vector, adaptive propensities, unbounded rewards and unknown measurement latency. The \(\epsilon\)-dependence is not matched. FC-1 gives the order of a fixed center's deterministic error quantile, not the minimax risk over all estimators. OBS-1 has a precise performance comparison and CAL-1 has a sharp boundary adaptation order; Section 9 adds a matching full-path observable-width theorem on a stated nonzero region. Adaptation optimality outside that region and the zero-oracle boundary remains unproved.

## 7. Verification and formalization scope

The full mathematical arguments are in Appendices A–E. Finite enumeration checks strict Rademacher tails, scan constructions and subset-incidence identities. These checks diagnose arithmetic and edge cases; they do not replace the all-parameter proofs. Separate research implementations evaluate (M14) and the enhanced historical-maximum rule from observed records and check that hidden potential endpoints cannot enter their APIs. The latter requires complete observed state histories rather than sparse reporting snapshots.

Formalization has not started in this delivery. The entire manuscript, including all auxiliary claims used in the proofs, is intended for a version-bound task board. The absence of Lean here is an explicit task boundary, not a certification and not a waiver of the repository's full-formalization requirement.

## 8. References

- **[LK26]** Michael Lindon and Nathan Kallus. *Design-Based Anytime-Valid Inference for Randomized Experiments with Delayed Outcomes and Staggered Entry*. ICML 2026, PMLR 306. [Official proceedings](https://proceedings.mlr.press/v306/lindon26a.html); [arXiv v2 full text](https://arxiv.org/html/2603.25971v2).
- **[Ao26]** Ruicheng Ao, Hongyu Chen, Siyang Gao, Hanwei Li and David Simchi-Levi. *Designing Service Systems from Textual Evidence*. arXiv:2601.21471, v2, 5 November 2026. [Primary record](https://arxiv.org/abs/2601.21471); [full paper and electronic companion](https://arxiv.org/pdf/2601.21471).
- **[CMR24]** Thomas Cook, Alan Mishler and Aaditya Ramdas. *Semiparametric Efficient Inference in Adaptive Experiments*. CLeaR 2024, PMLR 236, 1033–1064. [Official proceedings and paper](https://proceedings.mlr.press/v236/cook24a.html).
- **[H21]** Steven R. Howard, Aaditya Ramdas, Jon McAuliffe and Jasjeet Sekhon. *Time-uniform, nonparametric, nonasymptotic confidence sequences*. Annals of Statistics 49(2), 1055–1080, 2021. DOI: 10.1214/20-AOS1991. [Primary full text](https://arxiv.org/html/1810.08240v10).
- **[MP09]** Andreas Maurer and Massimiliano Pontil. *Empirical Bernstein Bounds and Sample Variance Penalization*. COLT 2009. [Official paper](https://www.learningtheory.org/colt2009/papers/012.pdf).
- **[vVW11]** Aad van der Vaart and Jon A. Wellner. *A local maximal inequality under uniform entropy*. Electronic Journal of Statistics 5, 192–203, 2011. DOI: 10.1214/11-EJS605. [Author-hosted paper](https://sites.stat.washington.edu/jaw/JAW-papers/jaw-vdv.EJS.2011.pdf).
- **[WP22]** Guenther Walther and Andrew Perry. *Calibrating the scan statistic: finite sample performance versus asymptotics*. Journal of the Royal Statistical Society, Series B 84(5), 1608–1639, 2022. DOI: 10.1111/rssb.12549. [Primary preprint](https://arxiv.org/abs/2008.06136).
- **[HBLT26]** Dae Woong Ham, Iavor Bojinov, Michael Lindon and Martin Tingley. *Design-Based Confidence Sequences: A General Approach to Risk Mitigation in Panel Experiments*. arXiv:2210.08639, v4, 20 August 2026. DOI: 10.1287/mnsc.2024.08235. [Primary record](https://arxiv.org/abs/2210.08639).
- **[KCC25]** Valentin Kilian, Stefano Cortinovis and Francois Caron. *Anytime-valid, Bayes-assisted, Prediction-Powered Inference*. NeurIPS 2025. DOI: 10.52202/085713-0033. [Official proceedings abstract](https://proceedings.neurips.cc/paper_files/paper/2025/hash/01830c92c6558179fa6d7fb1edff692c-Abstract-Conference.html). Only the official abstract was used for this comparison.


- **[HS]** Sariel Har-Peled and Micha Sharir. *Relative (p,epsilon)-Approximations in Geometry*. arXiv:0909.0717. [Primary author-hosted paper](https://www.math.tau.ac.il/~michas/relativefin.pdf), Definition 2.3 and Theorem 2.11.

## 9. Sharp observable widths on a nonzero parameter region

The first-round results establish a sharp oracle error law and a sharp adaptation cost at zero oracle error. We now add a different conclusion: on an entire nonzero parameter region, a **single** observed-history rule that does not know either budget attains the same order as the oracle law. The performance criterion is the maximum band radius over the whole observed path, not optimality relative to the current load at every separate time.

### 9.1 A historical maximum carries calibration information

The following elementary calibration fact applies to any fixed finite ordered family of vectors \(w(s)\in[0,1]^N\). Write
\(Q_s=\sum_iw_i(s)\), \(\widehat Q_s=\sum_i I_iw_i(s)/p_i\),
\(Q_s^\star=\max_{u\le s}Q_u\) and
\(\widehat M_s=\max_{u\le s}\widehat Q_u\).
For \(0<\delta<1\),

\[
\Pr\!\left\{\forall s:\quad
Q_s^\star\le
\max\left\{\frac8\epsilon\log\frac2\delta,\,
4\widehat M_s\right\}\right\}\ge1-\delta.
\tag{M24}
\]

There is no factor depending on the number of states. To prove this, a fixed-state multiplicative lower-tail bound gives
\(\Pr(\widehat Q_s<Q_s/2)\le e^{-\epsilon Q_s/8}\).
Apply it only at the deterministic first crossings of true levels
\(2^j(8/\epsilon)\log(2/\delta)\). Their total failure probability is at most
\(\sum_{j\ge0}(\delta/2)^{2^j}\le\delta\).
The observed maximum retains the evidence at each crossing. Appendix D provides every step.

Relative approximations of all ranges have a different, stronger objective [HS]. This is not a guarantee of relative accuracy for each individual state, and it is not simultaneous over vectors chosen from the realized assignments. Chernoff bounds and geometric peeling are established methods [H21]; the calibration is used here to obtain the statistical width theorem below, rather than claimed as a new general concentration principle.

In the original delayed experiment use \(w_i(t)=m_i^2\mathbf1\{E_i\le t<T_i\}\), and maintain

\[
\widehat M_t=\sup_{s\le t}\widehat Q_s,\qquad
J_t=\sum_{T_i\le t}\frac{I_i}{p_i}(y_i-m_i)^2.
\tag{M25}
\]

Both are observable. **Update \(\widehat M_t\) after every observed entry/event group, with all same-time events processed together.** Updating only at selected reporting times can miss a transient peak and does not satisfy the input requirement. A complete event history suffices; hidden endpoints at which no observed term changes leave \(\widehat Q\) unchanged.

### 9.2 An enhanced band, with no budget inputs

For an error level \(0<\beta\le1/4\), put \(\delta=\beta/4\), and define

\[
\overline q_t=\min\left\{N,\,
\max\left\{\frac8\epsilon\log\frac2\delta,\,
4\widehat M_t\right\}\right\},\qquad
\overline v_t=\min\left\{N,\,
2J_t+\frac2\epsilon\log\frac1\delta\right\}.
\tag{M26}
\]

Equation (M24) calibrates \(Q_t\). The fixed event-order exponential argument used for the entry-mass lemma calibrates \(V_t\le\overline v_t\) simultaneously. Set

\[
h_{N,\delta}(x)=
\sqrt{x\left[\log(1/\delta)+\log\frac{eN}{1\vee x}\right]},
\qquad x\in[0,N],
\tag{M27}
\]

with value zero at zero, and

\[
b_{\mathrm{new}}(t;\beta)=
\min\left\{\mathcal B_{\mathrm{det}}(t),\
\frac{14}{\epsilon}
\left[h_{N,\delta}(\overline v_t)+
h_{N,\delta}(\overline q_t)\right]\right\}.
\tag{M28}
\]

Use the localized interval inequality from Appendix A for the pending intervals and for the residual intervals \([T_i,\infty)\), omitting infinite \(T_i\). Together with the two calibration events, these four events prove simultaneous coverage at level \(1-\beta\). No true \(v,q,V_t,Q_t,D_t\) is supplied to (M28).

Let \(b_{\mathrm{old}}\) be (M14). For \(0<\alpha\le1/8\), define one combined rule

\[
b^\dagger_t=
\min\{b_{\mathrm{old}}(t;\alpha/2),\
b_{\mathrm{new}}(t;\alpha/2)\}.
\tag{M29}
\]

Both components use the same center. Their joint good event proves full-model coverage at least \(1-\alpha\).

**Theorem OBS-2 (simultaneous attainability on a nonzero region).** Let \(L=\log(1/\alpha)\) and \(G\) be (M6). On every table in

\[
0\le v\le q\le N,\qquad q\ge L,\qquad 0<\alpha\le1/8,
\tag{M30}
\]

every assignment path satisfies

\[
\sup_t b^\dagger_t
\le \frac{56\sqrt{20/\epsilon}}{\epsilon}\,G.
\tag{M31}
\]

The same rule also has the zero-oracle bound
\(\sup_tb^\dagger_t\le C_\epsilon\min\{N,L\}\).
The rule itself never receives the region restrictions or the budgets as inputs.

For (M31), set \(\beta=\alpha/2\), so \(\delta=\alpha/8\).
Pathwise \(J_t\le v/\epsilon\) and \(\widehat M_t\le q/\epsilon\). In (M30) both envelopes are at most \(\min\{N,(20/\epsilon)q\}\).
For \(c\ge1\),
\(h_{N,\delta}(\min\{N,cq\})\le\sqrt c\,h_{N,\delta}(q)\).
Moreover \(L\le q\le N\) ensures
\(h_{N,\delta}(q)\le2G\), including the saturation in (M6).
Substitution into (M28) proves the displayed constant. The zero-oracle claim follows from the old component. The constants are conservative; their dependence on \(\epsilon\) is not sharp.

### 9.3 Matching lower bounds for honest observable width

Fix \(N,\epsilon,\alpha\). Let \(\mathcal H_\alpha\) consist of all nonnegative observed-history radius rules for the specified AIPW center that have simultaneous coverage at least \(1-\alpha\) on **every** table of the original full model. Define

\[
\mathfrak W_\epsilon(N,v,q,\alpha)
=\inf_{b\in\mathcal H_\alpha}
\inf\left\{r\ge0:
\sup_{\mathcal D\in\mathcal C_\epsilon(N,v,q)}
\Pr_{\mathcal D}\!\left(\sup_t b_t>r\right)\le\alpha\right\}.
\tag{M32}
\]

An empty inner set has infimum +infinity. The overall feasible family is nonempty and the displayed quantity is finite, because the deterministic support-envelope rule is honest and bounded by N/epsilon. The definition allows the infimum for different classes to choose different members of \(\mathcal H_\alpha\). The upper bound is stronger: the same explicit rule (M29), with no budget inputs, attains all the stated comparisons.

**Theorem WIDTH-1 (global lower bound and a sharp nonzero frontier).** For every \(N\ge1\), \(v,q\in[0,N]\) and \(0<\alpha\le1/8\),

\[
\mathfrak W_\epsilon(N,v,q,\alpha)\ge
\max\left\{
\frac{\sqrt{2/3}}{256}(F+G),\
\frac{\min\{N,L\}}{16}\right\}.
\tag{M33}
\]

On the entire region (M30),

\[
\mathfrak W_\epsilon(N,v,q,\alpha)
\asymp_\epsilon F+G
\asymp_\epsilon G,
\tag{M34}
\]

and at \(v=q=0\),

\[
\mathfrak W_\epsilon(N,0,0,\alpha)
\asymp_\epsilon\min\{N,L\}.
\tag{M35}
\]

To see the error-to-width conversion, take an honest rule and a class width bound \(r\). If coverage holds and \(\sup_tb_t\le r\), then \(\sup_t|\widehat R(t)-R(t)|\le r\). A union bound gives fixed-center error probability at most \(2\alpha\), so
\(\mathfrak W_\epsilon\ge r_\star(N,v,q,2\alpha)\).
For \(\alpha\le1/8\), \(\log(1/(2\alpha))\ge(2/3)L\); FC-1 yields the first term of (M33).
Every budget class contains the two zero-oracle baselines, and their CAL-1 probability \(1/4\) exceeds the permitted width-tail probability \(\alpha\). This proves the second term.
In (M30), \(F\le G\) and \(G\ge L\), so (M31) matches the lower bound. The old zero-oracle bound proves (M35). Appendix E gives the complete quantifiers and infimum argument.

This lower bound is for honest widths centered at the specified estimator. The explicit coverage-to-width argument is necessary; an error lower bound is not merely relabeled a width lower bound. CAL-2 remains a separate arbitrary-center interval-length statement. Neither (M34) nor (M35) proves optimal adaptation on the remaining regimes \(v>q\) or \(0<q<L\), or optimality at each individual current load after a larger historical load.


## Appendix A. Upper bounds and interval localization

The generic interval lemmas below write V_t^c for their active squared coefficient energy; this is distinct from the completed-residual clock V_t in (M3). The residual process is A_t throughout.

### A.1. Notation and result

Fix one arm. Let independently `I_i ~ Bernoulli(p_i)`, with
`epsilon <= p_i <= 1-epsilon`, and put

\[
 Z_i=I_i/p_i-1,\qquad d_i=y_i-m_i.
\]

All entries, potential times, outcomes and predictions are deterministic under
the randomization distribution. Assume finite real entry times `E_i`, extended
event times `T_i in [E_i,infinity]`, and `0 <= y_i,m_i <= 1`. For finite `t`, put

\[
 A_t=\sum_{T_i\le t}Z_i d_i,\qquad
 P_t=\sum_{E_i\le t<T_i}Z_i m_i,\qquad
 Q_t=\sum_{E_i\le t<T_i}m_i^2.
\]

The error of the practical estimator is exactly `A_t-P_t`. If `T_i=infinity`,
its residual never enters `A_t`; its pending contribution remains active after
entry. If `T_i=E_i`, the pending interval is empty and contributes nothing to
`P_t` or `Q_t`.

For `N>=1`, `v,q in [0,N]`, `alpha in (0,1/4]`, define

\[
 F_v=\sqrt{v\min\{N,\log(1/\alpha)\}},
\]
\[
 G_q=\sqrt{q\min\{N,\log(1/\alpha)+
              \log(eN/(1\vee q))\}}.
\]

At `v=0` or `q=0`, the corresponding expression is zero.

**Theorem U1 (uniform class upper bound).** If

\[
 \sum_i d_i^2\le v,\qquad \sup_t Q_t\le q,
\]

then, with probability at least `1-alpha`,

\[
\begin{split}
\sup_t|A_t-P_t|\le
&\frac1\epsilon\min\left\{\sqrt{Nv},
        \sqrt{\tfrac12v\log(4/\alpha)}\right\}\\
&+\frac1\epsilon\min\left\{\sqrt{Nq},
        7\sqrt{q[\log(2/\alpha)+\log(eN/(1\vee q))]}\right\}.
\tag{U1}
\end{split}
\]

In particular there is an absolute numerical constant `C` such that the
smallest deterministic class-valid radius is at most

\[
 \frac C\epsilon\,(F_v+G_q).
\tag{U2}
\]

The constant is independent of `N,v,q,alpha`; `epsilon` is kept fixed in the
frozen rate question. The caps in (U1) are pathwise and must be retained for
very small `alpha` and small `N`.

**Theorem U2 (localized pending bound).** For arbitrary deterministic
intervals and coefficients `c_i` with `|c_i|<=1`, let

\[
 X_t=\sum_i Z_i c_i\mathbf1\{E_i\le t<T_i\},\qquad
 V_t^c=\sum_i c_i^2\mathbf1\{E_i\le t<T_i\}.
\]

For `delta in (0,1/4]`, with probability at least `1-delta`, simultaneously
for every finite `t`,

\[
 |X_t|\le \frac{14}{\epsilon}
 \sqrt{V_t^c[\log(1/\delta)+\log(eN/(1\vee V_t^c))]}.
\tag{U3}
\]

The right hand side is zero when `V_t^c=0`. It can be intersected with the
deterministic bound `epsilon^{-1} sqrt(N V_t^c)`. No lower bound on a nonzero
coefficient is required, and no `log log(1/V_t^c)` term occurs for small `V_t^c`.

This is still an oracle statement because `V_t^c` contains counterfactual
endpoints. It supplies the probability inequality needed for a separate,
explicit observed-data calibration. It is not by itself a confidence band.

### A.2. Exact error decomposition

For each entered unit,

\[
 \left[m_i+\frac{I_i}{p_i}
   (y_i\mathbf1\{T_i\le t\}-m_i)\right]
   -y_i\mathbf1\{T_i\le t\}
 =Z_i\left(y_i\mathbf1\{T_i\le t\}-m_i\right).
\]

For an entered unit the bracket on the right is `d_i` after its potential
event and `-m_i` before that event. Summing gives `A_t-P_t`. This algebra does
not replace potential times by realized times in the opposite arm.

### A.3. Elementary sub-Gaussian lemma

For any deterministic vector `a in R^N`, independence gives

\[
 \mathbb E\exp\left(\lambda\sum_i a_i Z_i\right)
 \le \exp\left(\frac{\lambda^2}{8\epsilon^2}
                         \sum_i a_i^2\right),\qquad \lambda\in\mathbb R.
\tag{SG}
\]

One direct proof is to let
`f(lambda)=log E exp(lambda a_i (I_i/p_i-1))`. Then `f(0)=f'(0)=0` and
`f''(lambda)` is the variance of a two-point variable whose values differ by
`|a_i|/p_i`, under an exponentially tilted Bernoulli distribution. A two-point
variance is at most one quarter of its squared range. Hence
`f''(lambda)<=a_i^2/(4p_i^2)`. Integrating twice gives
`f(lambda)<=lambda^2 a_i^2/(8p_i^2)`. Summing and using `p_i>=epsilon`
proves (SG).

Consequently, for coefficient vectors `a,b`, with Euclidean distance
`d(a,b)=||a-b||_2`,

\[
 \Pr\{|X(a)-X(b)|>u\}
 \le2\exp[-2\epsilon^2u^2/d(a,b)^2],
 \quad X(a)=\sum_i Z_i a_i.
\tag{SG-tail}
\]

If `d(a,b)=0`, the difference is zero and no tail estimate is needed.

### A.4. Residual maximal inequality and deterministic saturation

Order all finite potential event times, breaking ties in a deterministic
way. The process `A_t` is a subsequence of partial sums of the independent,
centered variables `Z_i d_i`. For each fixed `lambda`, (SG) makes

\[
 \exp\left(\lambda\sum_{i\le k}Z_i d_i
    -\frac{\lambda^2}{8\epsilon^2}\sum_{i\le k}d_i^2\right)
\]

a nonnegative supermartingale. Stop at its first upper threshold crossing,
or at the finite terminal index if no crossing occurs. The finite stopped
expectation is at most one, which proves the usual maximal exponential
bound. In particular, since the sum of squared coefficients is at most `v`,

\[
 \Pr\{\max_t A_t>x\}
 \le\exp[-2\epsilon^2x^2/v].
\]

Apply the same argument to `-A_t` and use a union bound:

\[
 \Pr\{\sup_t|A_t|>x\}
 \le2\exp[-2\epsilon^2x^2/v].
\tag{R}
\]

When `v=0`, `A_t` vanishes identically. Otherwise setting
`x=epsilon^{-1} sqrt(v log(2/beta)/2)` gives failure probability at most
`beta`.

Also, `|Z_i|<=1/epsilon`, so at every sample point,

\[
 \sup_t|A_t|\le\epsilon^{-1}\sum_i|d_i|
                  \le\epsilon^{-1}\sqrt{Nv}.
\tag{R-cap}
\]

No relation between the arrival order and entry order is used.

### A.5. Interval path geometry

Discard empty intervals and zero coefficients. Process the finitely many
finite endpoint times in chronological order. At a tied time, remove all
ending coordinates before adding all starting coordinates. This produces
vectors `a^0,...,a^M`, where `a^0=0`, `M<=2N`, and each coordinate changes
from zero to its fixed coefficient and, at most once, back to zero.

All actual states occur in this sequence. The added intermediate states are
only a proof device. If the actual squared norms are bounded by `q`, the
intermediate squared norms are also bounded by `q`: removals decrease the
norm and additions increase it up to the final tied-time norm.

Let

\[
 s_0=0,\qquad s_k=\sum_{\ell=1}^k
                     \|a^\ell-a^{\ell-1}\|_2^2,\qquad S=s_M.
\]

For all `k<l`,

\[
 \|a^l-a^k\|_2^2\le s_l-s_k.
\tag{path}
\]

Indeed, a coordinate whose endpoint values differ has changed at least once
inside that subpath, contributing its squared coefficient to the right hand
side. Coordinates that change twice have zero net difference and contribute
nonnegatively only to the right hand side. Thus cancellation causes no
problem.

Each coordinate changes at most twice. If `|c_i|<=1`, then `S<=2N`. If the
whole path has squared norm at most `q`, every nonempty coordinate satisfies
`c_i^2<=q`, so the stronger estimate is

\[
 S\le2N\min\{1,q\}.
\tag{budget}
\]

The stronger bound applies only to coordinates whose interval is nonempty;
empty intervals were already discarded.

### A.6. A finite-path chaining lemma, proved explicitly

Consider any finite family of selected states from the interval path,
including zero, such that every selected state has squared norm at most
`q>0`. Suppose the total full-path change budget satisfies `S<=2Kq` for a
number `K>=1`. The selected states need not form a consecutive subpath.

**Lemma C.** For `beta in (0,1)`, with probability at least `1-beta`,

\[
 \sup_{a\text{ selected}}|X(a)|
 \le \frac{7}{\epsilon}
       \sqrt{q[\log(1/\beta)+\log(eK)]}.
\tag{C}
\]

#### Proof

Put `r_j=2^{-j} sqrt(q)` for `j>=1`. Partition the cumulative-change axis
`[0,S]` into half-open bins of width `r_j^2` and choose the first selected
state in every occupied bin. Let the resulting net be `A_j`; let `A_0={0}`.
For a selected state `a^k`, let `pi_j(a^k)` be the representative in its bin.
By (path),

\[
 \|a^k-\pi_j(a^k)\|_2\le r_j.
\]

Furthermore,

\[
 n_j=|A_j|\le1+S/r_j^2
             \le1+2K4^j\le3K4^j.
\]

Since `A_0={0}` and all selected norms are at most `sqrt(q)`, every link
`pi_j(a)-pi_{j-1}(a)` has norm at most `r_j+r_{j-1}=3r_j`. There are at most
`n_j n_{j-1}<=9K^2 16^j` possible actual links at level `j` (this loose
estimate also covers `j=1`). Set

\[
 u_j=\frac{3r_j}{\epsilon\sqrt2}
       \sqrt{\log(18K^2/\beta)+j\log32}.
\]

By (SG-tail) and a union bound, the probability that some level-`j` link has
absolute increment exceeding `u_j` is at most

\[
 2(9K^2 16^j)
 \exp[-\log(18K^2/\beta)-j\log32]
 =\beta 2^{-j}.
\]

Summing over `j>=1` bounds the failure probability by `beta`. On the good
event, telescope from zero to each selected state. This is a finite
telescoping sum for all sufficiently fine levels, because there are only
finitely many positive endpoint weights. Equivalently one can pass to the
eventually constant net representations. Jensen's inequality, with weights
`2^{-j}` whose sum is one and weighted mean of `j` is two, yields

\[
\begin{split}
 \sup|X(a)|
 &\le\frac{3\sqrt q}{\epsilon\sqrt2}
    \sum_{j\ge1}2^{-j}
          \sqrt{\log(18K^2/\beta)+j\log32}\\
 &\le\frac{3\sqrt q}{\epsilon\sqrt2}
    \sqrt{\log(1/\beta)+2\log K+\log18432}\\
 &\le\frac7\epsilon
    \sqrt{q[\log(1/\beta)+\log(eK)]}.
\end{split}
\]

For the last step, `log18432<10` and
`log(1/beta)+2log K+log18432 <= 10[log(1/beta)+1+log K]`, while
`3 sqrt(10/2)<7`. This proves (C). No independence between different path
increments is assumed; independence is only across the original Bernoulli
coordinates, exactly as used in (SG). QED.

### A.7. Global pending bound and proof of U1

When `sup_t Q_t<=q`, the whole virtual path is selected and (budget) gives

\[
 S\le 2q\,\frac{N}{1\vee q}.
\]

Since `q<=N`, `K=N/(1 vee q)>=1`. Apply Lemma C with this value of `K`.
This proves the second probabilistic term in (U1) with `beta=alpha/2`.

Pathwise, by Cauchy-Schwarz,

\[
 |P_t|\le\epsilon^{-1}\sum_{i:E_i\le t<T_i}m_i
       \le\epsilon^{-1}\sqrt{NQ_t}
       \le\epsilon^{-1}\sqrt{Nq}.
\tag{P-cap}
\]

For `q=0` the pending process is identically zero. Combining (R) at
`beta=alpha/2`, Lemma C at `beta=alpha/2`, both deterministic caps, and the
triangle inequality proves (U1). For `alpha<=1/4`, the added constants
`log2` and `log4` are absorbed into `log(1/alpha)`, proving (U2).

The addition of the two components is harmless for a rate statement because
the sum and maximum of two nonnegative quantities differ by at most two.
The matching lower bound is proved separately in Appendix B.

### A.8. Localization without a small-weight peeling penalty

Here the complete path need not satisfy any bound smaller than `N`.
The global change budget is always at most `2N`.

#### A.8.1 Local sublevel bound for any fixed q>=1

Select only states satisfying `V_t^c<=q`, together with zero. The representatives
in Lemma C are chosen among these selected states, so their norms are at
most `sqrt(q)` even when the path between them visits much larger norms.
The path-distance inequality still applies across that intervening path.
Take `K=N/q` in Lemma C. For any `q in [1,N]`,

\[
 \Pr\left\{\sup_{t:V_t^c\le q}|X_t|>
  \frac7\epsilon\sqrt{q[\log(1/\beta)+\log(eN/q)]}\right\}
 \le\beta.
\tag{sublevel}
\]

This argument avoids an unjustified assertion that deleting high-variance
states preserves an interval representation: it only uses the original
full path to build the nets.

#### A.8.2 States with 0<V_t^c<1

There are at most `M+1<=2N+1<=3N` actual or virtual states. Apply (SG-tail)
to each individual state, using its own squared norm `V_t^c`, and a union
bound. With probability at least `1-delta/2`, simultaneously at all these
states,

\[
 |X_t|\le\epsilon^{-1}
       \sqrt{\tfrac12 V_t^c\log(12N/\delta)}
 \le\epsilon^{-1}
       \sqrt{V_t^c[\log(1/\delta)+\log(eN)]}.
\tag{small}
\]

The last inequality follows for `delta<=1/4` because
`log(12N/delta) <= 2[log(1/delta)+log(eN)]`.
This is already the desired scale for all `V_t^c<1`, however tiny they are.
No infinite downward peeling is performed. States with `V_t^c=0` have
`X_t=0` deterministically.

#### A.8.3 States with V_t^c>=1

Let `J=floor(log_2 N)`, and `q_j=N 2^{-j}` for `0<=j<=J`.
For each level use (sublevel) with

\[
 \beta_j=\delta q_j/(4N).
\]

The sum of these failure probabilities is at most `delta/2`. Every
`V_t^c in [1,N]` lies below a level `q_j` satisfying `V_t^c<=q_j<2V_t^c`, except
that equality at `N` is harmless. On the simultaneous good event,

\[
\begin{split}
 |X_t|&\le\frac7\epsilon
  \sqrt{q_j[\log(1/\delta)+2\log(N/q_j)+1+\log4]}\\
 &\le\frac{14}{\epsilon}
  \sqrt{V_t^c[\log(1/\delta)+\log(eN/V_t^c)]}.
\end{split}
\]

Indeed `q_j<2V_t^c`, `log(N/q_j)<=log(N/V_t^c)`, and

\[
 L+2A+1+\log4\le2(L+A+1)
\]

for `L=log(1/delta)>=log4` and `A=log(N/V_t^c)>=0`.
Combining with (small) proves (U3).

### A.9. Consequence for pending-energy calibration

Define the observed arm-specific pending-energy estimate

\[
 \widehat Q_t=\sum_i\frac{I_i}{p_i}m_i^2
                    \mathbf1\{E_i\le t<T_i\}.
\]

Although `Q_t` uses latent counterfactual intervals, `Qhat_t` is observable:
only units actually assigned to the arm contribute, and their event status
is observed. Its error is the same interval process with coefficients
`c_i=m_i^2`, whose squared coefficient energy is

\[
 Q_t^{(4)}=\sum_i m_i^4\mathbf1\{E_i\le t<T_i\}\le Q_t.
\]

For fixed `L=log(1/delta)>0`, the function

\[
 h_N(x)=\sqrt{x[L+\log(eN/(1\vee x))]},\quad x\in[0,N],
\]

is increasing. Its square is linear for `x<=1`; for `x>1` its derivative
is `L+log(N/x)>0`. Thus (U3), applied to the squared coefficients, implies
simultaneously

\[
 |\widehat Q_t-Q_t|\le\frac{14}{\epsilon}h_N(Q_t).
\tag{calibration}
\]

This supports one-dimensional confidence-set inversion for Q_t. Appendix C uses the mass-localized refinement below to prove the complete observed-data band.

### A.10. Pure total-mass localized inequality

The following refinement supplies a mass budget independent of the ambient
population size. It may be intersected with (U3); neither dominates the
other for every deterministic weighted calendar.

For the general interval process in Theorem U2 define

\[
 M_*=\sum_{i:E_i<T_i}c_i^2.
\]

Empty intervals do not count, including units whose event is immediate at
entry. Let `M>=M_*` be any deterministic finite upper bound.

**Theorem U3 (pure mass localization).** If `M>0` and
`delta in (0,1/4]`, then with probability at least `1-delta`, for all `t`
with `V_t^c>0`,

\[
 |X_t|\le\frac{14}{\epsilon}
   \sqrt{V_t^c[\log(1/\delta)+\log(eM/V_t^c)]}.
\tag{U4}
\]

At `V_t^c=0` the error is zero. If `M=0`, the whole process is identically
zero. No lower cutoff such as `V_t^c>=1` is imposed. The coefficient bound
`|c_i|<=1` is not necessary for this pure-mass assertion, although it is
retained for the subsequent entry-prefix application.

#### Proof

The complete path has squared-change budget at most `2M`. At every scale
`q in (0,M]`, restrict to states with squared norm at most `q` and apply
Lemma C with `K=M/q`. This yields the sublevel bound

\[
 \sup_{t:V_t^c\le q}|X_t|\le
 \frac7\epsilon\sqrt{q[\log(1/\beta)+\log(eM/q)]}
\]

outside an event of probability `beta`.

Choose `q_j=M2^{-j}` and `beta_j=delta 2^{-j}/2` for all integers `j>=0`.
The error probabilities sum to `delta`. Every positive `V_t^c<=M` admits a
level with `V_t^c<=q_j<2V_t^c`. On the good event, write
`L=log(1/delta)` and `A=log(M/V_t^c)>=0`. The bracket at the chosen level is
at most `L+1+log2+2A`, which is at most `2(L+1+A)` for the stated confidence
range. Multiplying by `q_j<2V_t^c` and taking square roots proves (U4).

Although the sequence of scales is infinite, the union bound is countable
with finite total error probability. There is no claim that arbitrarily
small norms can be localized for free: the term `log(M/V_t^c)` explicitly
accounts for them. QED.

### A.11. Localization by entered nonempty-interval mass

Assume again `|c_i|<=1`. Define the deterministic cumulative participation
mass

\[
 D_t^{c}=\sum_{i:E_i\le t,\ E_i<T_i}c_i^2,
 \qquad d_t^{c}=1\vee D_t^{c}.
\]

This mass is nondecreasing, and includes each nonempty interval after its
entry even if that interval has already ended. In particular
`V_t^c<=D_t^c<=N`.

**Theorem U4 (entry-prefix mass localization).** For
`delta in (0,1/4]`, with probability at least `1-delta`, simultaneously for
every `t` with `V_t^c>0`,

\[
 |X_t|\le\frac{14}{\epsilon}\sqrt{V_t^c\,A(d_t^c,V_t^c,\delta)},
\tag{U5}
\]

where, for `d>=1` and `0<x<=d`,

\[
 A(d,x,\delta)=
 \log\!\left(\frac{18e d}{\delta x}\right)
   +2\log\log(e d).
\tag{A}
\]

At `V_t^c=0`, set the right side to zero by continuity. In particular if
`D_t^c=0`, there is exactly zero pending error, not a positive confidence
penalty. The formula contains a slowly varying mass-scale adaptation term;
it does not claim this term is necessary or sharp.

#### Definition of the fixed prefix-capped processes

Order coordinates by deterministic entry times, with a deterministic tie
break. Write `w_i=c_i^2 1{E_i<T_i}` in that order and
`W_k=sum_{i<=k}w_i`. For a deterministic cap `u>=1`, include exactly those
coordinates `i` with `W_i<=u`; discard all other coordinates. This is a fixed
deterministic subset of the original coordinates, not a data-dependent
selection. Its total nonempty-interval mass is at most `u`.

Let `X_t^[u]` be the interval process on that subset. Whenever
`D_t^c<=u`, every coordinate entered by `t` belongs to the subset, up to
zero-weight coordinates whose inclusion is irrelevant. Future entries
contribute nothing at time `t`. Hence

\[
 X_t^{[u]}=X_t,\qquad V_t^{c,[u]}=V_t^c
 \quad\text{whenever }D_t^c\le u.
\tag{prefix identity}
\]

Tied entry times cause no problem: if the total mass after the tied group is
at most `u`, every partial cumulative mass in that group is also at most
`u`. No interval is cut in time and no fractional coordinate is used.

#### Proof of the entry-prefix bound

For `j=0,1,2,...`, apply Theorem U3 to the fixed process with cap `u_j=2^j`,
using total-mass upper bound `M=u_j` and error probability

\[
 \delta_j=\frac{\delta}{(j+1)(j+2)}.
\]

These probabilities sum to `delta`, and each is within the confidence range
needed by Theorem U3. For a time with `D_t^c>0`, choose

\[
 j=\max\{0,\lceil\log_2 D_t^c\rceil\}.
\]

Then `D_t^c<=2^j<=2d_t^c` (a non-strict upper inequality is sufficient),
and `j+2<=3+log_2 d_t^c<=3 log(e d_t^c)`. The simultaneous good event and the
prefix identity give

\[
\begin{split}
 |X_t|
 &\le\frac{14}{\epsilon}
  \sqrt{V_t^c[\log(1/\delta)+\log((j+1)(j+2))
                           +\log(e2^j/V_t^c)]}\\
 &\le\frac{14}{\epsilon}
  \sqrt{V_t^c[\log(1/\delta)+2\log3+2\log\log(e d_t^c)
                           +\log(2e d_t^c/V_t^c)]},
\end{split}
\]

which is precisely (U5). For `D_t^c=0`, all active coefficients are zero.
This completes the proof.

#### Monotonicity useful for calibration

For fixed `delta in (0,1/4]`, the function

\[
 (d,x)\longmapsto x A(d,x,\delta)
\]

is nondecreasing in either coordinate throughout `d>=1, 0<x<=d`.
Its `x` derivative is `A-1>0`; its `d` derivative is
`x[d^{-1}+2/(d log(e d))]>0`. Its value tends to zero as `x` decreases to
zero. Thus one may replace both a hidden participation mass and a hidden
local squared-load by valid larger bounds, as long as the resulting local
load does not exceed the participation envelope.

For the pending-energy error, use coefficients `c_i=m_i^2`. Its own local
energy is `sum pending m_i^4<=Q_t`, and its own participation mass is at
most

\[
 D_t=\sum_{i:E_i\le t,E_i<T_i}m_i^2.
\]

Monotonicity therefore gives, with probability at least `1-delta`,

\[
 |\widehat Q_t-Q_t|\le
 \frac{14}{\epsilon}\sqrt{Q_t A(1\vee D_t,Q_t,\delta)}
 \quad\text{for all }t.
\tag{local mass calibration}
\]

This conclusion is not obtained by asserting that the fourth-power
calendar equals the second-power calendar in mass; only the proven
coordinatewise upper bounds and monotonicity are used.

### A.12. An observable entry-mass envelope with no ambient log N

The following calibration controls the hidden participation mass using observed records.
For the original nonnegative predictions, put

\[
 w_i=m_i^2\mathbf1\{E_i<T_i\},\quad
 D_t=\sum_{E_i\le t}w_i,\quad
 \widehat D_t=\sum_{E_i\le t}\frac{I_i}{p_i}w_i.
\]

For a unit assigned to the arm, the indicator `1{E_i<T_i}` is observable at
entry after processing all events at that same time: either its result
arrives immediately or it does not. For a unit assigned to the other arm,
its contribution to `Dhat` is zero. Consequently `Dhat_t` is observable
under the frozen event-observation model, although `D_t` is not.

The entries' simultaneous-arrival convention must be stated explicitly in
the implementation: an immediate event is included before deciding whether
the interval was nonempty. The result does not license predicting immediate
event status before that entry's observed information is available.

**Lemma E.** For any `delta in (0,1)`, with probability at least `1-delta`,

\[
 D_t\le2\widehat D_t+\frac2\epsilon\log(1/\delta)
 \quad\text{for all }t.
\tag{entry envelope}
\]

#### Proof

At a coordinate in the fixed entry ordering, `0<=w_i<=1` and
`x=epsilon w_i/p_i<=1`. The elementary inequality
`exp(-x)<=1-x+x^2/2` for `x>=0` gives

\[
\begin{split}
 \mathbb E\exp[-\epsilon I_iw_i/p_i]
 &=1-p_i+p_i e^{-x}\\
 &\le1-\epsilon w_i+\frac{\epsilon^2w_i^2}{2p_i}
 \le1-\frac\epsilon2w_i.
\end{split}
\]

Since `exp(a)(1-a)<=1` for `0<=a<=1/2`, it follows that

\[
 \mathbb E\exp[(\epsilon/2)w_i-\epsilon I_iw_i/p_i]\le1.
\]

Independence makes
`exp[(epsilon/2)D_k-epsilon Dhat_k]` a nonnegative supermartingale in the
entry ordering. The finite maximal inequality bounds its probability of
ever exceeding `1/delta` by `delta`. Rearranging the exponent proves the
lemma. All calendar-time states are among the fixed-order states; ties and
arbitrary potential endpoint ordering do not alter the argument. QED.

For example,

\[
 B_t=1+2\widehat D_t+(2/\epsilon)\log(1/\delta)
\]

is an observable upper bound on `1 vee D_t` on this event. It can be reduced
using any additional deterministic upper bound without harming validity.
Combining this envelope with (U5) and the local mass calibration avoids
charging a global `log N` solely because many unrelated units entered the
experiment. Appendix C supplies the inverse, failure-probability allocation and residual calibration for the full confidence-band construction.

## Appendix B. Matching lower bounds and indistinguishability

### B.1. Model and conclusions

Fix one arm, suppress its label, and write

\[
\xi_i=\mathbf 1\{A_i=a\}/p_i-1,\qquad d_i=y_i-m_i.
\]

The error of the specified observable AIPW center is exactly

\[
Z(t)=\widehat R(t)-R(t)
=\sum_{T_i\le t}\xi_i d_i
-\sum_{E_i\le t<T_i}\xi_i m_i.\tag{1}
\]

For all lower constructions take `p_i=1/2`, which is allowed for every fixed `epsilon in (0,1/2]`; then the `xi_i` are independent Rademacher variables. The other arm can have arbitrary identical, fixed outcomes and schedules across any compared tables. Thus every construction is a valid two-arm experiment.

Let `r_star(N,v,q,alpha)` denote the infimum of deterministic radii `r>=0` satisfying the frozen uniform error guarantee for this fixed center. Set

\[
L=\log(1/\alpha),\quad
A=\sqrt{v\min\{N,L\}},\quad
B=\begin{cases}
\sqrt{q\min\{N,L+\log(eN/(q\vee1))\}},&q>0,\\
0,&q=0.
\end{cases}
\]

**Theorem 1 (fixed-center lower bound, complete parameter range).** For every integer `N>=1`, `v,q in [0,N]`, and `0<alpha<=1/4`,

\[
\boxed{r_\star(N,v,q,\alpha)\ \ge\ \frac{A+B}{256}.}\tag{2}
\]

If `v=q=0`, equation (1) vanishes identically, so `r_star=0`. Constants in (2) are deliberately conservative. The matching upper bound in Appendix A establishes the complete order including saturation and fractional predictions.

**Theorem 2 (cost of adapting an observable radius to unknown tables).** Consider a single observable nonnegative radius rule that gives coverage at least `1-alpha` for the fixed AIPW center on every table in the full model, without being supplied the true residual or queue budgets. At a single time, for each of the two zero-error baseline tables described in Section 5,

\[
\boxed{\Pr_0\!\left\{r_0\ge\frac{\min\{N,\log(1/\alpha)\}}{16}\right\}\ge\frac14.}\tag{3}
\]

This holds for every `N>=1` and `0<alpha<=1/4`. The two baselines both have zero global residual budget and zero supremum pending budget. One construction varies only unknown residual outcomes and keeps `Q=0`; the other preserves perfect predictions (`V=0`) and varies only counterfactual event delays. Consequently a logarithmic calibration cost, capped at `N`, cannot in general be removed by observing an empirical residual sum of zero or by assuming perfect predictions while leaving counterfactual delays unknown.

Theorems 1 and 2 have different quantifiers. Theorem 1 concerns deterministic error radii of the specified center over a known class `C_epsilon(N,v,q)`. Theorem 2 concerns one observable rule required to be honest over unknown tables. It does **not** apply to a rule told in advance that `V=Q=0`.

### B.2. A uniform Rademacher quantile lemma

Let `S_n` be a sum of `n>=1` independent signs, and let `0<delta<=1/4`. Then

\[
\Pr\!\left\{|S_n|>\frac1{32}\sqrt{n\min\{n,\log(1/\delta)\}}\right\}>\delta.\tag{4}
\]

This statement deliberately uses a strict tail and covers `n=1`, confidence `delta=1/4`, and arbitrarily small confidence levels.

**Proof.** The elementary moments are

\[
\mathbb ES_n^2=n,\qquad \mathbb ES_n^4=3n^2-2n\le3n^2.
\]

The Paley--Zygmund inequality, whose usual one-line Cauchy--Schwarz proof applies to `S_n^2`, gives

\[
\Pr\{|S_n|\ge\sqrt{n/8}\}\ge\frac{(1-1/8)^2}{3}
=\frac{49}{192}>\frac14.
\]

By symmetry the positive-tail probability at the same threshold is at least `49/384>1/8`.

Write `D=log(1/delta)` and `a=log 8<4`. Choose

\[
k=\max\{1,\min\{n,\lfloor D/(2a)\rfloor\}\}.
\]

Partition the signs into `k` groups of sizes differing by at most one. Each group has size at least `n/(2k)`. If every group sum is at least the square root of one eighth of its size, the full sum is at least

\[
\sum_{j=1}^k\sqrt{n_j/8}\ge\frac14\sqrt{nk}.
\]

The analogous all-negative event is disjoint. For `k>=2`, their combined probability is strictly greater than `2*8^{-k}`, which is at least `2 exp(-D/2)>delta`. For `k=1`, the direct moment argument already gives a probability strictly greater than `1/4>=delta`.

For all `D>=log 4`,

\[
k\ge\frac{\min\{n,D\}}{4a}.
\]

Indeed, when `D<4a` the right side is at most one; otherwise `floor(D/(2a))>=D/(4a)`, and taking a minimum with `n` preserves the displayed bound. Hence the event just constructed has

\[
|S_n|\ge\frac{\sqrt{n\min\{n,D\}}}{8\sqrt a}
>\frac1{16}\sqrt{n\min\{n,D\}},
\]

which strictly exceeds the threshold in (4). This proves (4). `□`

We also need the following immediate consequence. If `S_k^(1),...,S_k^(b)` are independent copies, for all integers `k,b>=1`,

\[
\Pr\!\left\{\max_{j\le b}|S_k^{(j)}|
>\frac1{32}\sqrt{k\min\{k,\log(eb)\}}\right\}>\frac14.\tag{5}
\]

For `b=1`, use (4) with `delta=1/4` and `log 4>1`. For `b>=2`, use (4) with `delta=1/(3b)`, noting `log(3b)>log(eb)`. Independence makes the displayed tail greater than `1-(1-1/(3b))^b>1-exp(-1/3)>1/4`.

### B.3. Three constructions proving Theorem 1

#### B.3.1 Residual component

Set `m_i=0`, `y_i=sqrt(v/N)`, and `E_i=T_i=0` for every unit. The predictions and outcomes lie in `[0,1]`; the squared residual sum is exactly `v`; the queue budget is zero. At time zero,

\[
Z(0)=\sqrt{v/N}\,S_N.
\]

If `v>0`, (4) proves that the tail exceeds `alpha` at radius `A/32`. If `v=0`, the lower assertion for this component is vacuous.

#### B.3.2 Pending component: confidence and saturation

Set `m_i=y_i=sqrt(q/N)`, `E_i=0`, and `T_i=1`. There is no residual error; before time one the queue squared mass is exactly `q`. At time zero,

\[
Z(0)=-\sqrt{q/N}\,S_N.
\]

For `q>0`, (4) proves a lower bound `sqrt(q min(N,L))/32`. In particular, when `L` is comparable to or exceeds `N`, this gives the correct deterministic-envelope scale `sqrt(Nq)`. It does not rely on a Gaussian approximation that fails in the extreme-confidence regime.

#### B.3.3 Pending component: repeated scans and fractional predictions

Assume `q>0` and define

\[
H=\log(eN/(q\vee1)),\quad
k=\lceil\max\{q,H\}\rceil,\quad
b=\lfloor N/k\rfloor,\quad w=\sqrt{q/k}.
\]

Because `1<=H<=N` and `q<=N`, one has `1<=k<=N`, `b>=1`, and `0<w<=1`. Use `b` batches of `k` units each. Every unit in batch `j` has `m_i=y_i=w`, entry time `2j`, and event time `2j+1`. Remaining units, if any, have `m_i=y_i=0`. Batches have disjoint active time intervals.

For all time the residual sum is zero and the pending squared mass is at most `kw^2=q`. During batch `j`, equation (1) equals `-w S_k^(j)`; completed batches contribute exactly zero. These batch peaks are independent.

The elementary geometry of this construction satisfies

\[
\log(eb)\ge H/8,\qquad k\ge H.\tag{6}
\]

To see this, put `s=q vee 1`. Then `k<=2 max(q,H)<=2sH` and `b>=N/(2k)`, so

\[
\log(eb)\ge H-\log(4H).
\]

When `H>=8`, `log(4H)<=H/2`. When `1<=H<=8`, the trivial `log(eb)>=1` gives `log(eb)>=H/8`. This proves (6).

Apply (5), multiply by `w`, and use (6). The supremum error is larger than

\[
\frac{1}{32\sqrt8}\sqrt{qH}
\]

with probability strictly greater than `1/4`, and hence strictly greater than or equal to the required `alpha`, with strictness still present when `alpha=1/4`.

This construction handles `0<q<1`: choose batches of about `log(eN)` units, each with a fractional prediction. A queue budget below one does not restrict the queue to a single unit. The relevant logarithm is `log(eN/(q vee 1))`; replacing it by `log(eN/q)` would introduce a spurious divergence as `q` tends to zero for fixed `N`. Nor can one impose a universal `sqrt(q)` envelope: the valid deterministic envelope is `sqrt(Nq)`.

#### B.3.4 Combining the components

Put `B_L=sqrt(q min(N,L))` and `B_H=sqrt(qH)` when `q>0`. Since `H<=N`,

\[
B^2=q\min\{N,L+H\}\le B_L^2+B_H^2.
\]

The three constructions prove

\[
r_\star\ge\frac{1}{32\sqrt8}\max\{A,B_L,B_H\}
\ge\frac1{128}\max\{A,B\}
\ge\frac{A+B}{256}.
\]

Each lower bound uses a valid table in the same class; no single table needs to attain all components simultaneously. When `q=0`, the residual construction alone proves (2). This completes Theorem 1. `□`

### B.4. Interpretation of the lower bounds

1. **Turnover is necessary.** For example, at fixed confidence with `v=0` and `q=1`, the worst-case radius is at least a constant times `sqrt(log(eN))`. A bound based only on the current squared queue mass and the confidence level cannot hold uniformly over the number of disjoint queue episodes.
2. **Fractional predictions are essential to the small-budget behavior.** For binary predictions and `q<1`, all pending predictions would vanish; that is a different class. The frozen class permits all real predictions in `[0,1]`.
3. **Saturation is explicit.** Both terms stop at their `N`-sign deterministic envelopes, `sqrt(Nv)` and `sqrt(Nq)`. No restriction such as `alpha>=exp(-cN)` is imposed.
4. **Ties and zero delay are legitimate.** The constructions use tied times and zero delays allowed by the frozen model. The scan construction uses finite delays. No assumption of independent or treatment-invariant potential event times is needed.
5. **This is a lower bound for a fixed center.** These examples by themselves do not prove an oracle minimax lower bound over all estimators. In particular, knowledge available to a different estimator or a narrower subclass must be separately specified before making such a claim.

### B.5. Exact indistinguishability inequality for observable radii

Assume a radius rule, measurable from allowed observations (and possibly independent internal randomization), satisfies the fixed-center coverage guarantee for every full-model table. It suffices to examine time zero. Let

\[
U=\{i:A_i\ne a\},\quad M=|U|\sim\operatorname{Bin}(N,1/2).
\]

For either baseline below, let `r_0` denote the radius output on its observed data.

#### Family R: unobserved residuals, queue identically zero

The baseline has `m_i=y_i=0` and `E_i=T_i=0` for all units. Thus both global budgets are zero, target and center both equal zero. For every fixed subset `S` of size `k`, change the arm-a outcomes to `y_i=1{i in S}`, retaining `m_i=0` and all times. This alternative has `V=k` and `Q=0`.

On `S subset U`, no changed outcome is observed. The entire observed dataset is identical to that of the baseline, the center equals zero, and the true target equals `k`. Thus the fixed center has error `k` on an event whose data are indistinguishable from the zero-error baseline.

#### Family P: unobserved pending events with perfect predictions

The baseline has `m_i=y_i=1` and `E_i=T_i=0` for all units, again with both global budgets zero. Its target and center both equal `N`. For every fixed subset `S` of size `k`, keep `m_i=y_i=1` but change `T_i` from zero to one for `i in S`. This alternative has `V=0` and `Q=k`.

On `S subset U`, the changed counterfactual event times are never observed. The observed data are identical to the baseline, the center is still `N`, while the time-zero target is `N-k`. The fixed-center error is again `k`. This family demonstrates the calibration obstruction even if perfect outcome predictions are assumed known.

#### Exact inequality

For every fixed subset `S`, honesty on its alternative implies

\[
\Pr_0\{r_0<k,\ S\subset U\}\le\alpha.
\]

Averaging over the `binom(N,k)` subsets yields, for every integer `1<=k<=N`,

\[
\boxed{
\mathbb E_0\!\left[
\mathbf1\{r_0<k\}
\frac{\binom{M}{k}}{\binom Nk}
\right]\le\alpha.}\tag{7}
\]

The binomial coefficient is interpreted as zero when `M<k`. Equation (7) is exact, not asymptotic. The expectation may include an algorithm's independent randomization. It uses coverage on a family of fixed tables; the average is a proof device and does not make the potential-outcome table random in the model.

### B.6. A complete-range calibration lower bound

First take `k=1` in (7). Since `E(M/N)=1/2` and `M/N<=1`,

\[
\Pr_0\{r_0\ge1\}\ge\frac12-\alpha\ge\frac14.\tag{8}
\]

For the growing lower bound, suppose `N>=8` and `L=log(1/alpha)>=2 log 8`. Put

\[
k=\left\lfloor\min\{N/8,L/(2\log8)\}\right\rfloor.
\]

Then `k>=1` and

\[
k\ge\frac{\min\{N,L\}}{16}.\tag{9}
\]

On the event `G={M>=N/4}`, because `k<=N/8`,

\[
\frac{\binom Mk}{\binom Nk}
=\prod_{j=0}^{k-1}\frac{M-j}{N-j}
\ge8^{-k}\ge e^{-L/2}=\sqrt\alpha.
\]

Equation (7) therefore implies `Pr_0(r_0<k,G)<=sqrt(alpha)`. The elementary sign-sum Chernoff bound gives

\[
\Pr_0(G^c)\le e^{-N/8}.
\]

For completeness, apply `E exp(lambda xi)=cosh(lambda)<=exp(lambda^2/2)` to the centered sum `2M-N`, then minimize the resulting bound at `lambda=1/2` for the event `2M-N<-N/2`.

Consequently

\[
\Pr_0\{r_0\ge k\}\ge1-e^{-N/8}-\sqrt\alpha
\ge1-e^{-1}-\frac18>\frac12.\tag{10}
\]

When the displayed assumptions fail, either `N<8` or `L<2 log8`, so `min(N,L)/16<1`; (8) proves (3). Equations (9)--(10) prove (3) in the remaining cases. This completes Theorem 2. `□`

### B.7. What extends to arbitrary confidence intervals

There is also a separate interval statement, which must not be conflated with Theorem 1. Let `I` be any observable interval, with any center, that covers the target with probability at least `1-alpha` on every table. Let `theta_0` be the baseline target (zero for Family R, `N` for Family P), and write `length(I)` for its diameter. The same alternatives give

\[
\mathbb E_0\!\left[
\mathbf1\{\theta_0\in I,\ \operatorname{length}(I)<k\}
\frac{\binom Mk}{\binom Nk}
\right]\le\alpha.\tag{11}
\]

Since baseline coverage implies `Pr_0(theta_0 notin I)<=alpha`, equation (11) yields

\[
\Pr_0\{\operatorname{length}(I)\ge1\}\ge\frac12-2\alpha.
\]

For the large-`N,L` choice of `k` in Section 6 it similarly yields

\[
\Pr_0\{\operatorname{length}(I)\ge k\}
\ge1-e^{-N/8}-\sqrt\alpha-\alpha.
\]

Combining the two branches, for every `0<alpha<=1/8`,

\[
\Pr_0\!\left\{\operatorname{length}(I)
\ge\frac{\min\{N,\log(1/\alpha)\}}{16}\right\}\ge\frac14.\tag{12}
\]

Equation (12) is a genuine lower bound for every honest interval rule in the stated adaptation setting. It concerns interval length, not the error of every possible estimator. This proof does not claim the same numerical probability constant for `alpha in (1/8,1/4]`; (11) remains valid in that range.


## Appendix C. Observable construction and oracle comparison

### C.1. Observable quantities and notation

Fix an arm, write I_i=1{A_i=a}, p_i=pi_i(a), Z_i=I_i/p_i-1, and d_i=y_i-m_i. Only finite calendar times are considered. At a tied entry/event time all events at that time are processed before reporting the state. T_i=infinity never counts as an event.

Let A_t=sum_{T_i<=t} Z_i d_i and P_t=sum_{E_i<=t<T_i} Z_i m_i. The AIPW error is A_t-P_t. Distinguish the hidden clocks

V_t=sum_{T_i<=t}d_i^2,
Q_t=sum_{E_i<=t<T_i}m_i^2,
D_t=sum_{E_i<=t,E_i<T_i}m_i^2.

The following statistics use only the assigned arm's observed events and entry records:

U_t=sum_{T_i<=t} I_i d_i^2/p_i^2,
Qhat_t=sum_{E_i<=t<T_i} I_i m_i^2/p_i,
W_t=sum_{E_i<=t<T_i} I_i m_i^2/p_i^2,
Dhat_t=sum_{E_i<=t,E_i<T_i} I_i m_i^2/p_i.

An I_i=0 summand is evaluated as zero without querying its latent T_i or y_i. For I_i=1 the nonempty-interval flag 1{E_i<T_i} is known at entry: either the outcome is an observed immediate event, or it has not arrived. Keep that flag after the event returns. Dhat_t is cumulative participation, not the current pending mass. Event records must distinguish an observed zero-valued event from an event that has not occurred. All immediate events at an entry time are processed before this flag is frozen.

### C.2. A self-normalized scalar inequality

For p>=epsilon, I~Bernoulli(p), |c|<=1, and |lambda|<=epsilon/2,

E exp[lambda (I/p-1)c - lambda^2 I c^2/p^2] <=1.   (O1)

Indeed u=lambda c/p is in [-1/2,1/2]. The inequality exp(u-u^2)<=1+u on this interval follows from log(1+u)-u+u^2>=0: its derivative is u(1+2u)/(1+u), and its value at zero is zero. Therefore

E exp[lambda Ic/p-lambda^2 I c^2/p^2]
=1-p+p exp(u-u^2)<=1+lambda c<=exp(lambda c).

This proves (O1). It applies to both signs without needing the sign of c.

Order the finite potential events deterministically. Independence and (O1) make exp(lambda A_t-lambda^2 U_t) a nonnegative supermartingale in that virtual order. No martingale assertion in the experimenter's full calendar filtration is needed: the resulting event is simultaneous for all t, and consequently also holds at every data-dependent reported time.

For j>=0 set lambda_j=(epsilon/2)2^{-j}. For delta in (0,1), define

B_R(u,delta)=inf_{j>=0} {lambda_j u + lambda_j^{-1} log[2(j+1)(j+2)/delta]}.   (O2)

Allocate delta/[2(j+1)(j+2)] to each sign at each j. Their total is delta. The finite Ville inequality gives

P(for all t, |A_t|<=B_R(U_t,delta))>=1-delta.   (O3)

When u=0, B_R(0,delta)=(2/epsilon)log(4/delta). The infimum is effectively computable: the j-th objective is bounded below by lambda_j^{-1}log(4/delta), a quantity increasing to infinity. Once this lower bound exceeds the best objective already found, all later j may be discarded. Thus the formula never requires an infinite numerical loop.

A useful explicit comparison is the following. Set J(u)=ceil[(1/2)log_2(1+u)] and a(u,delta)=log[2(J(u)+1)(J(u)+2)/delta]. A dyadic lambda within a factor two of min{epsilon/2,sqrt(a/u)} yields

B_R(u,delta)<=3 sqrt[u a(u,delta)]+4a(u,delta)/epsilon.   (O4)

For the capped case lambda=epsilon/2, lambda u<=a/lambda; for the other case the two summands are at most sqrt(au) and 2sqrt(au). The selected j is at most J(u). At u=0 the direct formula applies. In particular U_t<=V_t/epsilon^2 deterministically gives residual-adaptive width of order_epsilon sqrt[V_t Lambda(V_t,delta)]+Lambda(V_t,delta), with Lambda of order log(1/delta)+log log(e+V_t). This is standard stitching behavior, not a new generic concentration principle.

### C.3. Finite-state empirical pending bound

The pending coefficient vector changes at at most 2N endpoint times, so there are at most 2N+1 states. At each fixed state, (O1) and independence give the exponential inequality for P_t with observed square clock W_t. A union bound over states, signs and the same lambda grid yields

B_F(w,N,delta)=inf_{j>=0}{lambda_j w+lambda_j^{-1}log[2(2N+1)(j+1)(j+2)/delta]},

P(for all t, |P_t|<=B_F(W_t,N,delta))>=1-delta.   (O5)

Unobserved potential endpoint times are used only to count a deterministic proof index set. They are not inputs to B_F. This bound can be numerically better at moderate N than the conservative constants in the rate-optimal localization argument; it is not asserted to achieve the sharp oracle logarithm for every q.

### C.4. Calibrating total participation and local pending energy

The entry-mass lemma from Appendix A gives, with error probability delta,

D_t<=2Dhat_t+(2/epsilon)log(1/delta) for all t.

Define the observable envelope

B_t=1+2Dhat_t+(2/epsilon)log(1/delta).   (O6)

On that event B_t>=1 vee D_t>=Q_t. Its deterministic comparison is

B_t<=B*_t:=1+(2/epsilon)[D_t+log(1/delta)],   (O7)

because Dhat_t<=D_t/epsilon on every assignment.

Write K=14/epsilon, and for b>=1, 0<x<=b define

H_b(x)=sqrt{x A(b,x,delta)},
A(b,x,delta)=log[18 e b/(delta x)]+2log log(e b),
H_b(0)=0.

Both b and x increase H_b on its domain. Apply the entry-prefix mass inequality first to coefficients m_i and then to m_i^2. The second process is Qhat_t-Q_t, with local fourth-power energy at most Q_t and participation mass at most D_t. On two events each of probability at least 1-delta,

|P_t|<=K H_{1 vee D_t}(Q_t),
|Qhat_t-Q_t|<=K H_{1 vee D_t}(Q_t),

simultaneously at all t. Hence, after intersecting with the entry-envelope event,

Q_t<=Qhat_t+K H_{B_t}(Q_t).

Define a single real-valued inverse using only observable data:

qplus_t=max{x in [0,B_t]: x<=Qhat_t+K H_{B_t}(x)}.   (O8)

The set is nonempty and compact. It contains the true Q_t on the good event. For numerical evaluation note that H_b is concave (x A(b,x,delta) is nonnegative concave, and square root is increasing and concave). Therefore x-KH_b(x) is convex and its sublevel set at a nonnegative level is an interval containing zero. If the inequality holds at B_t, take qplus_t=B_t; otherwise use bisection for the unique positive crossing, retaining the upper bracket to avoid rounding downward.

Set B_P(t)=K H_{B_t}(qplus_t). Then, on the three simultaneous events just described,

|P_t|<=B_P(t) for all t.   (O9)

This does not plug a point estimate into an oracle inequality. Both hidden clocks have their own simultaneous calibration argument before substitution.

### C.5. Complete observable band

Let alpha in (0,1/4], and set delta=alpha/5 in all preceding formulas. Let S_t=sum_{E_i<=t} I_i y_i 1{T_i<=t} and n0_t=sum_{E_i<=t}(1-I_i). Every compatible target obeys S_t<=R(t)<=S_t+n0_t. Thus

B_det(t)=max{|hatR(t)-S_t|, |hatR(t)-S_t-n0_t|}

is an observable deterministic radius, bounded by N/epsilon. Define

b_t=min{B_det(t), B_R(U_t,delta)+min[B_P(t), B_F(W_t,N,delta)]}.   (O10)

The five failure events are: residual stitched inequality; entry-mass envelope; pending mass localization; local-energy calibration; finite-state empirical pending inequality. A union bound gives exactly

P(for all finite t, |hatR(t)-R(t)|<=b_t)>=1-alpha.   (O11)

There is no independence assertion between these events, arms or the two error components. If the finite-state fallback is omitted, delta=alpha/4 suffices and N need not be used by the stochastic part of the band. For a two-arm contrast, construct each arm's band at alpha/2 and use b_1(t)+b_0(t). The arms need not be independent.

### C.6. Precise oracle comparisons and scope of optimality

The exact data-dependent formula (O10) is the primary constructive statement. A convenient simplified comparison follows without claiming that every adaptation term is optimal.

For any b>=1, h>=0 define u=max{x in [0,b]:x<=h+K H_b(x)}. Suppose h<=Q/epsilon and 0<=Q<=b. Put

a=A(b,1 vee Q,delta).

If u<=2(Q vee 1)/epsilon, monotonicity of xA(b,x,delta), the identity A(b,x,delta)=a+log[(Q vee 1)/x], and x log[(Q vee 1)/x]<= (Q vee 1)/e give

K H_b(u)<= C_epsilon (sqrt{Q a}+a).

For completeness this assertion is interpreted with x capped by b; the elementary bound H_b(x)^2<=x a+(Q vee 1)/e applies for all x in [0,b]. If u>2(Q vee 1)/epsilon, the defining inequality gives u/2<=K H_b(u), while A(b,u,delta)<=a. Hence u<=4K^2 a and K H_b(u)<=2K^2 a. Combining cases proves

B_P(t)<=C_epsilon [sqrt{Q_t a_t}+a_t]   (O12)

on every assignment for which the true hidden quantities are defined, using h=Qhat_t<=Q_t/epsilon and b=B_t<=B*_t, where

a_t=A(B*_t,1 vee Q_t,delta).

The domain condition Q_t<=B*_t holds deterministically; if B_t<Q_t off the envelope event, compare directly to the larger feasible interval [0,B*_t], which can only enlarge qplus and the bound. Thus (O12) can be stated pathwise using B*_t, or just on the common coverage event, either of which suffices.

Together with (O4), the band is bounded by

C_epsilon {sqrt[V_t Lambda_t]+Lambda_t+sqrt[Q_t a_t]+a_t},

and by the deterministic cap N/epsilon. Here Lambda_t=a(V_t/epsilon^2,delta), while a_t depends on cumulative nonempty participation D_t, current pending energy Q_t, and confidence. These clocks are used only to describe the oracle comparison; the algorithm takes the observed statistics in O1.

For a design in C_epsilon(N,v,q), V_t<=v, Q_t<=q, and D_t<=N min{1,q}. The last fact holds because each nonempty interval has m_i^2<=q. Put B_q=1+(2/epsilon)[N min{1,q}+log(1/delta)] and Lambda_v=a(v/epsilon^2,delta). A valid whole-class comparison is C_epsilon{sqrt(v Lambda_v)+Lambda_v+sqrt[q A(B_q,1 vee q,delta)]+A(B_q,1,delta)}, intersected with N/epsilon. The additive A term uses second argument 1: A decreases with its second argument, so replacing it by 1 vee q would be invalid. The square-root term is monotone because x A(B_q,1 vee x,delta) is increasing. These slowly varying and additive terms remain visible. The sharp oracle theorem concerns the smallest deterministic error radius for the fixed center with known class budgets. We do not claim that (O10) is the minimax data-dependent band over every nondegenerate design, nor that the displayed log-log mass factor is necessary. Such a stronger assertion is not used in proving (O11).

### C.7. Sharp unavoidable calibration at the zero-oracle boundary

If the global budgets v=sum_i d_i^2 and q=sup_t Q_t both equal zero, every nonempty interval has m_i=0 and every d_i=0, hence D_t=U_t=Qhat_t=Dhat_t=W_t=0 at every t. This is a statement about the whole table, not merely V_t=Q_t=0 at one time. Equations (O2), (O6)-(O10) give

sup_t b_t<=C_epsilon min{N,log(1/alpha)}.   (O13)

Indeed B_t=1+(2/epsilon)log(5/alpha), qplus_t<=B_t, and H_{B_t}(B_t)^2=B_t[log(18e/delta)+2loglog(eB_t)], which is O_epsilon(log(1/alpha)^2). The deterministic cap handles small N and extreme confidence.

The hidden-subset lower bound in Appendix B establishes that every observable AIPW-centered band honest over all potential tables has, on an oracle-zero baseline, probability at least 1/4 of radius at least c min{N,log(1/alpha)}. It applies both to hidden residuals and, with m=y=1 maintained, to hidden delayed events. Together with that proved lower bound, (O13) matches the boundary adaptation order. A zero oracle error does not identify a zero-error table from partially observed data.

If absence of delay is a known structural design assumption, P_t is identically zero for every allowed table and B_R alone is valid; the usual residual variance benefit is recovered. If no delay is merely observed on the assigned arms, the hidden-calendar calibration cost cannot be removed on that basis. These are different statistical model statements, not a technical caveat.

## Appendix D. Historical maxima and the enhanced band

### D.1. A running-maximum calibration for a fixed finite weight family

Let `s=0,...,K` index a finite totally ordered family of deterministic
vectors `w(s) in [0,1]^N`. Coordinates of each vector may overlap arbitrarily
and may change nonmonotonically with `s`. Independently let
`I_i ~ Bernoulli(p_i)` with fixed `p_i>=epsilon>0`. Define

\[
 Q_s=\sum_{i=1}^Nw_i(s),\qquad
 \widehat Q_s=\sum_{i=1}^N\frac{I_i}{p_i}w_i(s),
\]
\[
 Q_s^*=\max_{u\le s}Q_u,\qquad
 \widehat M_s=\max_{u\le s}\widehat Q_u.
\]

The vectors are fixed independently of the entire assignment vector. The
statement below is for each such fixed family; it is not a simultaneous
guarantee over a family chosen after observing assignments.

**Proposition S1 (running-maximum calibration).** For any `0<delta<1`, put

\[
 a_0=\frac8\epsilon\log\frac2\delta.
\]

Then

\[
 \Pr\!\left\{\forall s:\quad
 Q_s^*\le\max\{a_0,4\widehat M_s\}\right\}\ge1-\delta.
\tag{S1}
\]

In particular, neither `K` nor the number of distinct weight vectors enters
the threshold. This is a lower calibration of the largest observed mass
for the largest true mass so far. It does not establish a simultaneous
relative approximation `Qhat_s approximately Q_s` at every individual
state.

#### Proof: one deterministic state

Set `theta=epsilon/2`. For `0<=w<=1`, `p>=epsilon`, and
`x=theta w/p<=1/2`, the inequality `e^{-x}<=1-x+x^2/2` gives

\[
\begin{split}
 \mathbb E e^{-\theta Iw/p}
 &=1-p+pe^{-x}\\
 &\le1-\frac\epsilon2w+\frac{\epsilon^2}{8p}w^2
 \le1-\frac{3\epsilon}{8}w
 \le\exp\left(-\frac{3\epsilon}{8}w\right).
\end{split}
\]

Independence across `i` therefore yields, at each fixed state,

\[
 \mathbb E\exp[-(\epsilon/2)\widehat Q_s]
 \le\exp[-3\epsilon Q_s/8].
\]

Exponential Markov gives

\[
 \Pr\{\widehat Q_s<Q_s/2\}
 \le\exp[-\epsilon Q_s/8].
\tag{S2}
\]

The implication also holds when `Q_s=0`, in which case the event on the left
is impossible.

#### Proof: deterministic first crossings of true levels

Set `a_j=2^j a_0` for `j>=0`. If the family ever attains mass at least
`a_j`, let `tau_j` be the first such index. Each existing `tau_j` is a
deterministic index, since the true vectors are deterministic. Thus it is
legitimate to apply (S2) at `tau_j`; no optional-stopping inference from a
pointwise bound is being made.

Except on an event of probability at most

\[
\begin{split}
 \sum_{j\ge0}\exp[-\epsilon a_j/8]
 &=\sum_{j\ge0}(\delta/2)^{2^j}\\
 &\le\sum_{j\ge0}(\delta/2)^{j+1}
 =\frac{\delta}{2-\delta}\le\delta,
\end{split}
\tag{S3}
\]

every existing crossing satisfies `Qhat_{tau_j}>=Q_{tau_j}/2`.
Nonexisting crossings are simply omitted; bounding by the infinite sum is
only a convenient upper bound for the finite experiment.

On this event, fix any index `s`. If `Q_s^*<a_0`, (S1) is immediate. If
`Q_s^*>=a_0`, choose `j` with `a_j<=Q_s^*<2a_j`. Then `tau_j<=s`, and

\[
 \widehat M_s\ge\widehat Q_{\tau_j}
 \ge\frac12Q_{\tau_j}\ge\frac12a_j>\frac14Q_s^*.
\]

This implies (S1), including level equalities. QED.

#### Necessary interpretation and limitation

The nonnegativity of the weights and the use of the running maximum are
essential to this argument. It makes no claim about a signed sum. It also
does not apply to assignment-dependent weights. For example, choosing
`w_i=1{I_i=0}` after seeing the assignments can make `Qhat=0` with positive
true mass; such a selection violates the fixed-family hypothesis.

### D.2. Observable implementation of the historical maximum

For the delayed AIPW experiment, let

\[
 w_i(t)=m_i^2\mathbf1\{E_i\le t<T_i\}.
\]

Under the fixed potential table, these form a finite deterministic ordered
family of states. There are at most `2N+1` actual states, although this count
is not used in (S1). Define

\[
 \widehat M_t=\sup_{s\le t}
 \sum_i\frac{I_i}{p_i}m_i^2\mathbf1\{E_i\le s<T_i\}.
\tag{S4}
\]

This historical maximum is observable. A summand with `I_i=0` is zero and
does not require its potential endpoint to be known. A summand with `I_i=1`
changes only at its observed entry or observed event. Potential endpoint
states at which no such observed summand changes leave `Qhat` unchanged.

**The algorithm must update the maximum after every observed entry/event
group, not merely at selected reporting times.** All simultaneous events
are processed as one calendar-time group before updating the state. In
particular an immediate event `T_i=E_i` never creates a positive pending
interval. A historical log of those observed groups is an equivalent input.
If a short-lived observed queue peak is omitted between reports, the
quantity supplied is not (S4), and the claimed calibration is not justified.

The same grouping is useful for the pathwise comparison below: inserting
an artificial transient queue for immediate events may enlarge the
computed maximum and destroy the claimed width comparison, even though
enlarging a valid envelope alone cannot harm coverage.

By (S1), with probability at least `1-delta`, simultaneously at all times,

\[
 Q_t\le Q_t^*\le\overline q_t,
 \qquad
 \overline q_t=\min\!\left\{N,
 \max\!\left\{\frac8\epsilon\log\frac2\delta,
                         4\widehat M_t\right\}\right\}.
\tag{S5}
\]

The cap at `N` is valid because `0<=m_i^2<=1`.

### D.3. Residual energy has an observed entry-order analogue

Write `d_i=y_i-m_i`, so `|d_i|<=1`, and define

\[
 V_t=\sum_{T_i\le t}d_i^2,
 \qquad J_t=\sum_{T_i\le t}\frac{I_i}{p_i}d_i^2.
\tag{S6}
\]

Here `J_t` is observable: only target-arm units with observed completed
events contribute. The order of finite potential event times is a fixed
deterministic ordering; tie breaks can also be fixed. Coordinates whose
potential event is infinite never enter this sequence.

The entry-energy argument from Appendix A, now
applied to weights `d_i^2` in this fixed event order, gives

\[
 \Pr\!\left\{\forall t:\quad
 V_t\le\overline v_t\right\}\ge1-\delta,
 \qquad
 \overline v_t=\min\!\left\{N,
       2J_t+\frac2\epsilon\log\frac1\delta\right\}.
\tag{S7}
\]

For completeness, the one-coordinate calculation is

\[
 \mathbb E\exp[(\epsilon/2)w-\epsilon Iw/p]\le1,
 \qquad 0\le w\le1,
\]

because `x=epsilon w/p<=1`,
`1-p+pe^{-x}<=1-epsilon w/2`, and
`e^{epsilon w/2}(1-epsilon w/2)<=1`.
Products yield a nonnegative supermartingale in the fixed event ordering.
Its finite maximal inequality gives (S7). The cap is again deterministic.

The event-order filtration is a proof device. No claim is made that the
completed residual process is a martingale in the full observed calendar
filtration.

### D.4. A new observed-data band

For `x in [0,N]`, set

\[
 h_{N,\delta}(x)=
 \begin{cases}
 \sqrt{x\left[\log(1/\delta)+
                     \log(eN/(1\vee x))\right]},&x>0,\\
 0,&x=0.
 \end{cases}
\tag{S8}
\]

This function is increasing. Its square is linear for `x<=1`; for `x>1`
the derivative is `log(1/delta)+log(N/x)>0`.

The first-round localized interval inequality states that, for a fixed
interval family with coefficients `c_i in [-1,1]`, its centered weighted
sum `X_t` satisfies

\[
 |X_t|\le(14/\epsilon)h_{N,\delta}
       \left(\sum_i c_i^2\mathbf1\{t\text{ belongs to interval }i\}\right)
 \quad\forall t
\tag{S9}
\]

with failure probability at most `delta<=1/4`. Its explicit proof in
Appendix A, Theorem U2, covers signed
coefficients, fractional weights, ties, and arbitrary overlap.

Apply (S9) twice:

- to pending intervals `[E_i,T_i)` with coefficients `m_i`, giving the
  local energy `Q_t`;
- to intervals `[T_i,infinity)` with coefficients `d_i`, omitting infinite
  `T_i`, giving the local energy `V_t`.

Thus two events, each with failure probability at most `delta`, give

\[
 |P_t|\le(14/\epsilon)h_{N,\delta}(Q_t),\qquad
 |A_t|\le(14/\epsilon)h_{N,\delta}(V_t)
 \quad\forall t.
\tag{S10}
\]

The original center still satisfies `hatR(t)-R(t)=A_t-P_t` exactly.

Let the requested error probability for this new band be `beta`, with
`0<beta<=1/4`, and set `delta=beta/4`. Define

\[
 b_{\mathrm{new}}(t;\beta)=\min\!\left\{B_{\mathrm{det}}(t),
 \frac{14}{\epsilon}\left[
 h_{N,\delta}(\overline v_t)+h_{N,\delta}(\overline q_t)
 \right]\right\}.
\tag{S11}
\]

Here `B_det` is the observed support-envelope radius from Appendix C.5: if `S_t` is the sum of realized target-arm rewards and
`n_{0,t}` the number of entered units assigned to the other arm, every
compatible target lies in `[S_t,S_t+n_{0,t}]`, and

\[
 B_{\mathrm{det}}(t)=
 \max\{|\widehat R(t)-S_t|,
       |\widehat R(t)-S_t-n_{0,t}|\}.
\]

All inputs to (S11) are observable: `J_t`, the recorded running maximum
`Mhat_t`, the center, support-envelope data, and the fixed constants
`N,epsilon,beta`. Neither true class budget `v` nor `q` is an input.

**Theorem S2 (honesty of the new band).**

\[
 \Pr\!\left\{\forall t:\quad
 |\widehat R(t)-R(t)|\le b_{\mathrm{new}}(t;\beta)\right\}\ge1-\beta.
\tag{S12}
\]

**Proof.** Intersect the four events (S5), (S7), and the two events in
(S10). Their total failure probability is at most `4delta=beta`.
On the intersection, use monotonicity of `h` and the error decomposition,
then intersect with the pathwise support radius. No independence between
these four events is required. QED.

### D.5. A complete nonzero region with a sharp width comparison

This section proves a uniform-width statement on an entire parameter
region, not merely a fixed example or a pointwise improvement. It also
states explicitly what region is not covered by this optimality claim.

Let the final target error level be `0<alpha<=1/8` and let

\[
 L=\log(1/\alpha),\qquad
 G(N,q,\alpha)=
 \sqrt{q\min\{N,L+\log(eN/(1\vee q))\}}.
\tag{S13}
\]

Consider the original frozen class with

\[
 0\le v\le q\le N,\qquad q\ge L.
\tag{region}
\]

Use the new band at error level `beta=alpha/2`, so its internal
`delta=alpha/8`. Put `C=20/epsilon`.

**Theorem S3 (uniform pathwise width on the nonzero region).** For every
fixed table in this region, every assignment vector, and every time,

\[
 b_{\mathrm{new}}(t;\alpha/2)
 \le \frac{56\sqrt{20/\epsilon}}\epsilon\,
                   G(N,q,\alpha).
\tag{S14}
\]

The rule has not been supplied `v` or `q`. The assertion is pathwise: it
does not require the good coverage event to occur.

#### Proof: deterministic comparisons for the observed clocks

On every assignment vector,

\[
 J_t\le V_t/\epsilon\le v/\epsilon,
 \qquad
 \widehat M_t\le q/\epsilon.
\tag{S15}
\]

The second inequality uses the true class bound at every past state, and
the correct observed-state running maximum from S2. Since
`L>=log8`,

\[
 \log(1/\delta)=L+\log8\le2L,
 \qquad
 \log(2/\delta)=L+\log16\le(7/3)L.
\]

Using `v<=q` and `L<=q` gives

\[
 \overline v_t\le\min\{N,6q/\epsilon\},
 \qquad
 \overline q_t\le\min\{N,(56/(3\epsilon))q\}
                 \le\min\{N,Cq\}.
\tag{S16}
\]

The same bound `min(N,Cq)` covers `vbar_t`.

#### Proof: scaling, confidence conversion, and saturation

For any `c>=1` and `0<q<=N`,

\[
 h_{N,\delta}(\min\{N,cq\})
 \le\sqrt c\,h_{N,\delta}(q).
\tag{S17}
\]

Indeed `h(x)^2/x=log(1/delta)+log(eN/(1 vee x))` is nonincreasing, and the
ratio `min(N,cq)/q` is at most `c`.

Next, `log(1/delta)<=2L` gives

\[
 h_{N,\delta}(q)\le\sqrt2\,h_{N,\alpha}(q).
\]

Finally, `L<=q<=N` and
`log(eN/(1 vee q))<=1+log N<=N` imply

\[
 h_{N,\alpha}(q)\le\sqrt2\,G(N,q,\alpha).
\tag{S18}
\]

This step explicitly handles the `min(N,...)` saturation in the original
oracle law. Combining (S16)–(S18), each `h` term in (S11) is at most
`2 sqrt(C) G`. Their sum times `14/epsilon` is (S14). QED.

#### Relation to the proved oracle lower bound

In the region (region), the original residual component

\[
 F(N,v,\alpha)=\sqrt{v\min\{N,L\}}
\]

satisfies `F<=G`. The independently proved fixed-center lower bound is
`r_star >= (F+G)/256`, and the first-round upper bound matches this order.
Thus `F+G` is comparable to `G` here. Theorem S3 gives an observed-data band
with a deterministic width upper bound of this oracle order over the whole
region. All constants may depend on the fixed positivity constant
`epsilon`; the explicit constant in (S14) is conservative.

For precision, this is a minimax-order comparison of a uniform width
guarantee for the specified center. If an honest fixed-center band had a
smaller deterministic width cap on every assignment in this class, that
cap would itself be a valid deterministic error radius, contradicting the
fixed-center lower bound. It is not a statement that every realized band
radius must be large at every data point, or that an arbitrary different
estimator has the same oracle error lower bound.

No claim is made here that (S11) is optimally adaptive when `v>q` or when
`q<L`. In particular, the new ambient-`N` local bound alone can be costly at
the zero-oracle boundary. That boundary is handled by the already proved
mass-based band, as follows.

### D.6. One band with both proved adaptation properties

Let `b_old(t;gamma)` denote the first-round observable band (O10), evaluated
at error level `gamma`. It uses the same practical AIPW center as (S11).
Define

\[
 b_{\mathrm{combined}}(t;\alpha)=
 \min\{b_{\mathrm{old}}(t;\alpha/2),
       b_{\mathrm{new}}(t;\alpha/2)\}.
\tag{S19}
\]

**Corollary S4 (single honest band with two adaptation guarantees).** For
`0<alpha<=1/8`, the interval with center `hatR(t)` and radius (S19) covers
the true target simultaneously at all times with probability at least
`1-alpha`. It satisfies both:

1. On every table in (region), the pathwise width bound (S14), hence the
   oracle fixed-center width order throughout that nonzero region.
2. If the original global budgets satisfy `v=q=0`, the pathwise bound
   `C_epsilon min(N,log(1/alpha))`, matching the separately proved
   hidden-table calibration lower bound in its stated probability sense.

**Proof.** Each component is honest with failure probability `alpha/2`.
On their intersection the common center's error is bounded by their minimum.
The union bound gives total failure probability at most `alpha`.
Property 1 follows by taking the minimum with the new component. Property 2
follows by taking the minimum with the old component, using
`log(2/alpha)<= (4/3)log(1/alpha)` for `alpha<=1/8`.

The first-round zero-oracle lower bound applies to any single observable
fixed-center radius rule honest over all potential tables. It therefore
also applies to this combined rule; the comparison is not restricted to a
rule that is told in advance that its table has zero budgets. QED.


## Appendix E. Honest observable-width lower bounds and matching rates

### E.1. Precise statistical object

The original potential-table model, target and AIPW center remain unchanged. The new upper construction is proved in Appendix D, Propositions/Theorems S1--S4. This note verifies the width criterion and lower bound and audits the interpretation of its matching region.

Fix an integer `N>=1`, `epsilon in (0,1/2]`, and a confidence level `0<alpha<=1/8`. Let `D_N,epsilon` be the entire frozen model of deterministic potential tables and independent treatment assignments. The supplied entry records, fixed propensities and external predictions are allowed inputs; unobserved potential outcomes and event times are not. Let

\[
Z_D(t)=\widehat R_D(t)-R_D(t)
\]

be the error of the prescribed entry-frozen AIPW center. Write `C(N,v,q)` for the original class, with the fixed `epsilon` suppressed.

An **admissible band rule** is a single rule producing a nonnegative radius `b_D(t)` from the allowed observed history and the fixed constants `N,epsilon,alpha`. It may use independent internal randomization. The relevant supremum events must be measurable; finite observed-event-state rules used in the construction satisfy this automatically. A rule may retain past observations and running maxima. Its interval is

\[
[\widehat R_D(t)-b_D(t),\widehat R_D(t)+b_D(t)].
\]

Thus the quantity called width below is the **radius**; full interval length is twice that quantity. This factor does not change any rate statement.

Define the set of globally honest rules

\[
\mathcal H_\alpha=
\left\{b:\ 
\sup_{D\in\mathcal D_{N,\epsilon}}
\Pr_D\!\left(\exists t:|Z_D(t)|>b_D(t)\right)
\le\alpha\right\}.
\tag{W1}
\]

For a fixed rule and a class, define its upper-tail radius quantile

\[
\mathcal W_\alpha(b;N,v,q)=
\inf\left\{r\ge0:\ 
\sup_{D\in C(N,v,q)}
\Pr_D\!\left(\sup_t b_D(t)>r\right)\le\alpha\right\}.
\tag{W2}
\]

The width benchmark is

\[
\boxed{
W^*(N,v,q,\alpha)=
\inf_{b\in\mathcal H_\alpha}\mathcal W_\alpha(b;N,v,q).
}
\tag{W3}
\]

Equivalently, take the infimum over pairs `(b,r)` satisfying both displayed constraints. Infima need not be attained. The deterministic support-envelope band from the original manuscript belongs to `H_alpha` and has radius at most `N/epsilon`, so this benchmark is finite.

#### Quantifiers that matter

1. Honesty is required on the **entire model**, not merely on the class at which the width is assessed. Alternatives outside a small-budget class therefore remain relevant to adaptation lower bounds.
2. The infimum in `W^*(N,v,q,alpha)` is taken separately for each class. It can select different fixed tuning rules for different classes, provided every selected rule is globally honest and its evaluations use only permitted inputs. The upper theorem below is stronger: one displayed rule, with no `v,q` input, attains the rate throughout the region simultaneously.
3. Both suprema over time and over tables are essential. This is a quantile of the largest reported radius over the experiment, not an expected width, a conditional-on-coverage width, or a guarantee involving only the current `Q_t`.
4. The center remains fixed. The infimum ranges over observable **radius rules** around that center, not over all estimators or every possible interval center.

### E.2. Honesty plus a width quantile gives an oracle error radius

Let `r_star(N,v,q,beta)` be the original smallest deterministic radius for the fixed center's supremum error at tail probability `beta`. The following elementary reduction is exact.

**Lemma W1 (coverage/width reduction).** For two error levels `alpha_c,alpha_w>0`, any rule globally honest at error `alpha_c` and any `r` satisfying a class-width tail bound `alpha_w` obey

\[
\sup_{D\in C(N,v,q)}
\Pr_D\!\left(\sup_t|Z_D(t)|>r\right)
\le\alpha_c+\alpha_w.
\tag{W4}
\]

**Proof.** For a fixed table define

\[
E_D=\{\forall t:|Z_D(t)|\le b_D(t)\},\qquad
F_D(r)=\{\forall t:b_D(t)\le r\}.
\]

On `E_D intersect F_D(r)`, the supremum error is at most `r`. Hence

\[
\{\sup_t|Z_D(t)|>r\}\subseteq E_D^c\cup F_D(r)^c.
\]

Take probabilities, apply the two hypotheses, and then take the supremum over the class. No independence of the events is required. `□`

In the balanced definition (W3), every feasible pair therefore has

\[
r\ge r_\star(N,v,q,2\alpha).
\]

Taking infima preserves the inequality even if no feasible minimum is attained:

\[
\boxed{W^*(N,v,q,\alpha)\ge r_\star(N,v,q,2\alpha).}\tag{W5}
\]

This direction cannot be reversed merely by choosing a deterministic oracle radius: such a radius may be valid only on its known class and fail global honesty outside it.

### E.3. Confidence conversion and a global lower bound

Write

\[
L=\log(1/\alpha),\quad
F=\sqrt{v\min\{N,L\}},
\]

\[
G=\begin{cases}
\sqrt{q\min\{N,L+\log(eN/(1\vee q))\}},&q>0,\\
0,&q=0.
\end{cases}
\tag{W6}
\]

Because `alpha<=1/8`, the original lower theorem applies at `2alpha<=1/4`. Moreover,

\[
L_2=\log(1/(2\alpha))=L-\log2\ge\frac23L.
\]

For `c in [0,1]` and `x>=0`, `min(N,cx)>=c min(N,x)`. Since the scan logarithm is nonnegative, it follows that

\[
F(N,v,2\alpha)\ge\sqrt{2/3}\,F,
\qquad
G(N,q,2\alpha)\ge\sqrt{2/3}\,G.
\]

The original fixed-center lower bound and (W5) therefore give

\[
\boxed{
W^*(N,v,q,\alpha)
\ge\frac{\sqrt{2/3}}{256}\,(F+G).
}\tag{W7}
\]

This includes all `N>=1`, `v,q in [0,N]`, and the confidence range just stated. Small populations, vanishing budgets and the saturation caps remain in the formula.

#### Calibration is also a global width floor

The original hidden-subset argument shows that every globally honest fixed-center rule has, at each of its two `V=Q=0` baselines,

\[
\Pr_0\left\{b_0(0)\ge
\frac{\min\{N,L\}}{16}\right\}\ge\frac14.
\tag{W8}
\]

Both baseline tables belong to every class `C(N,v,q)`, because the classes use upper budgets. If `r<min(N,L)/16`, equation (W8) implies

\[
\sup_{D\in C(N,v,q)}
\Pr_D\{\sup_t b_D(t)>r\}\ge\frac14>\alpha.
\]

Such an `r` is infeasible in (W3). Thus

\[
\boxed{
W^*(N,v,q,\alpha)\ge\frac{\min\{N,L\}}{16}.
}\tag{W9}
\]

The strict `>r` width convention causes no atomic ambiguity: the argument is for every `r` strictly below the threshold, and then takes an infimum. It does not need to exclude feasibility at exactly the threshold.

Combining (W7) and (W9) gives the complete lower statement currently established:

\[
\boxed{
W^*(N,v,q,\alpha)\ge
\max\!\left\{
\frac{\sqrt{2/3}}{256}(F+G),\
\frac{\min\{N,L\}}{16}
\right\}.
}\tag{W10}
\]

In particular it is bounded below by a universal constant times
`F+G+min(N,L)`. This is a lower bound throughout the original parameter space; a matching upper bound throughout that space has **not** been established here.

The fixed-center requirement in (W8) is satisfied exactly. The alternative pure-delay family keeps `m=y=1` throughout, so its obstruction remains even if perfect outcome predictions are a known model property while counterfactual delays remain unknown. The separate all-center interval-length lower bound from the first round is not needed for (W10).

### E.4. Matching width throughout a nonzero-oracle region

The upper construction in Appendix D provides a globally honest band `b_new(t;beta)`. With `beta=alpha/2`, its internal error allocation is `delta=alpha/8`. On every table with

\[
0\le v\le q\le N,\qquad q\ge L,
\tag{R}
\]

that note proves the following **pathwise** inequality, requiring no successful-coverage event:

\[
\sup_t b_{\mathrm{new}}(t;\alpha/2)
\le C_\epsilon G,
\qquad
C_\epsilon=\frac{56\sqrt{20/\epsilon}}\epsilon.
\tag{W11}
\]

For clarity, its ingredients are the observed historical maximum of the pending squared prediction load, the observed completed squared residual load, and the original local interval error bound. The band is not supplied `v` or `q`.

The pathwise comparison is legitimate because, on every assignment,

\[
\widehat M_t\le q/\epsilon,\qquad
J_t\le v/\epsilon.
\]

The calibrated budgets consequently satisfy
`vbar_t,qbar_t<=min(N,(20/epsilon)q)` on (R). The local bound function obeys the scaling inequality

\[
h_{N,\delta}(\min\{N,cq\})
\le\sqrt c\,h_{N,\delta}(q),\qquad c\ge1,
\]

because its squared value divided by its argument is nonincreasing. Here `L<=q<=N` and `log(eN/(1 vee q))<=N`, so the unsaturated local expression is at most a constant times the correctly saturated `G`. This checks that no extreme-confidence or small-population saturation is silently dropped.

Since `b_new(alpha/2)` is globally honest at the stronger level `alpha/2`, it belongs to `H_alpha`. Equation (W11) makes the width-tail probability zero at `r=C_epsilon G`, proving `W*<=C_epsilon G` on (R). Also `F<=G` there. Therefore:

**Theorem W2 (class-width frontier on (R)).** For every `N>=1`, `epsilon in (0,1/2]`, `0<alpha<=1/8`, and every `(v,q)` satisfying (R),

\[
\boxed{
\frac{\sqrt{2/3}}{256}\,G
\le W^*(N,v,q,\alpha)
\le\frac{56\sqrt{20/\epsilon}}\epsilon\,G.
}\tag{W12}
\]

All constants are independent of `N,v,q,alpha`; only the upper constant depends on the fixed positivity bound `epsilon`. If `L>N`, the region (R) is empty, rather than an unaddressed parameter case. If it is nonempty, `G>=L`, so the calibration floor in (W9) is absorbed in this rate.

### E.5. A single rule attains this region and the zero-oracle boundary

Let `b_old(t;gamma)` be the original fully observable band, and define

\[
b_{\mathrm{comb}}(t;\alpha)
=\min\{b_{\mathrm{old}}(t;\alpha/2),
         b_{\mathrm{new}}(t;\alpha/2)\}.
\tag{W13}
\]

Both component intervals have the same AIPW center. On the intersection of their coverage events, the center error is bounded by their minimum. A union bound proves that this **one rule** belongs to `H_alpha` on the full model.

On (R), (W11) continues to hold for the combined radius. On the entire zero-oracle class `C(N,0,0)`, the original construction gives the pathwise bound

\[
\sup_t b_{\mathrm{comb}}(t;\alpha)
\le C'_\epsilon\min\{N,L\}.
\tag{W14}
\]

Together with (W9), this proves

\[
\boxed{
\frac1{16}\min\{N,L\}
\le W^*(N,0,0,\alpha)
\le C'_\epsilon\min\{N,L\}.
}\tag{W15}
\]

The same rule obtains (W12) and (W15), without being told which class contains the table. This simultaneous adaptation assertion is stronger than merely taking the infimum in (W3) separately for each class.

The zero-oracle theorem is not contradicted by `r_star(N,0,0,alpha)=0`: the latter oracle guarantee is required only on a known zero-budget class, whereas (W1) requires the observed-data band to cover alternatives outside that class as well.

### E.6. Audit of the running-maximum step

The upper note's Proposition S1 concerns a fixed finite deterministic path of nonnegative weight vectors. Its proposed level crossings are deterministic functions of that path. Applying a pointwise Chernoff bound at those indices is therefore valid without optional stopping in an observed filtration. Nonexistent levels are omitted, and jumps over several levels do not create a problem. The bound concerns

\[
\max_{u\le s}Q_u
\quad\text{versus}\quad
\max_{u\le s}\widehat Q_u,
\]

not simultaneous relative accuracy of `Qhat_s` for every individual `Q_s`. This distinction is why a path-complexity-free multiplicative comparison can coexist with classical range-approximation complexity and the necessary scan logarithm for the signed AIPW error.

For implementation, the maximum must include every observed entry/event group, including observed peaks between reporting times. An immediate event is processed together with its entry and never creates an artificial pending interval. No unassigned arm's potential event time is queried. The fixed-table assumption is indispensable: choosing weights after observing assignments, such as `w_i=1-I_i`, can make every sampled load zero while the true load is large.

### E.7. Scope and remaining gaps

- **Proved benchmark:** worst-case upper quantile of the supremum radius, for all globally honest observed-data bands around the specified AIPW center.
- **Proved matching classes:** (R) and the zero-budget class, attained by one displayed rule.
- **Not proved:** optimal adaptation for every nonzero `(v,q)` outside (R); a pointwise-in-current-queue width optimum; a minimax oracle error theorem over arbitrary centers or estimators; an optimal dependence on `epsilon` or numerical constants.
- **Method attribution:** weighted Chernoff concentration, geometric peeling, empirical variance calibration, scan control and hidden-subset lower bounds remain established proof tools.

The mathematical statements (W5), (W7), (W9), and (W10) are proved directly in this note. The upper and matching statements (W11)--(W15) use the independently supplied upper construction and its pathwise comparisons as identified above. No Lean code or formal-verification claim is included.
