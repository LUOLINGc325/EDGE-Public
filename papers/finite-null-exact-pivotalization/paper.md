# Exact pivotalization for finite composite tests
## Finite-sample guarantees and minimax-optimal universal adaptation

Research manuscript, 26 November 2026. Written mathematical results; no proof-assistant verification has been performed. All logarithms are natural.

## Abstract

Consider a fixed finite collection of null distributions and a specified alternative. An e-variable is exact and pivotal when its mean is one under each null and its entire null distribution is independent of which null is true. We give an explicit construction with quantitative efficiency. For pairwise distinct probability measures $P_1,\ldots,P_L,Q$ on a standard Borel space, suppose $Q\ll P_i$ and $D(Q\Vert P_i)\lt \infty$. With a common independent randomization source, let $\ell_n$ be the optimal exact-pivotal expected log e-value and $V_n$ the ordinary valid optimum for the null set $\{P_i^{\otimes n}\}$. Writing $T_n=\min_i\log(q^{\otimes n}/p_i^{\otimes n})$, we construct an exact-pivotal e-variable with expected logarithm at least $\mathbb E_QT_n-\varepsilon_n$, where an explicit Hellinger-affinity bound gives $\varepsilon_n=O(nh^{n/2})$, $h\lt 1$. Consequently $0\le V_n-\ell_n\le\log L+\varepsilon_n$.

The construction preserves high likelihood scores and compensates their null output laws inside regions that identify the separate nulls. A finite matrix inverse makes the compensation nonnegative and exact. No likelihood-ratio moment generating function is needed for the main bound. Finite second moments yield the same Gaussian-maximum second-order term for exact-pivotal and ordinary e-power. We characterize when that term vanishes, give a sufficient condition for exponential convergence to the single-nearest-null oracle, and establish a local near-tie transition on fixed finite alphabets. An implementation based on empirical types has polynomial arithmetic cost in sample size when alphabet size and the number of nulls are fixed. The additive constant $\log L$ is an upper bound, not asserted to be sharp.

On a fixed finite alphabet of size $K$ with full-support nulls, we further construct one exact-pivotal statistic that does not know the alternative. For every fixed alternative outside the null family, its regret relative to the alternative-specific ordinary optimum is at most $\log L+\log C_{n,K}+o(1)$, where $C_{n,K}$ is the classical multinomial normalized-maximum-likelihood constant and $\log C_{n,K}=(K-1)\log n/2+O(1)$. On every full-dimensional compact cube contained in one strict KL nearest-null region and avoiding the nulls, a matching lower bound applies to all ordinary valid randomized statistics. The entire common null law therefore imposes no additional leading minimax learning cost.

## 1. The question and the contribution

An ordinary e-variable $E\ge0$ satisfies $\mathbb E_{P_i}E\le1$ for every null. Large observed values provide evidence against the null family. Its expected logarithm under a specified alternative is commonly called e-power, the growth-rate objective studied in [5,10]. Exactness strengthens the inequalities to equalities. Pivotality requires one common distribution under all nulls, not merely equal means.

Zhang, Ramdas and Wang [1] developed existence and construction theory for these requirements, including the SHINE procedure and special symmetric Gaussian solutions. Their Section 6 also characterizes existence against finite composite alternatives; existence alone does not quantify the regret of one statistic over an unknown alternative. He and Cheng [2] subsequently proved first-order asymptotic losslessness for fixed finite families under joint atomlessness, including support configurations and infinite-divergence cases beyond our assumptions. Their argument uses the large-sample matrix-majorization theorem of Farooq et al. [9] and does not state a quantitative sample threshold or the finite-sample envelope bound considered here. We address that quantitative gap. The first-order limit itself is prior work.

The principal contribution is Theorem 2.1: a finite-sample, whole-distribution calibration construction for general finite-KL experiments. It bounds the additional exact-pivotal restriction relative to the ordinary optimum by a constant independent of sample size, with an exponentially vanishing remainder and an explicit threshold. The positive measure compensation in Lemma 3.1 is the reusable part of the argument. The central-limit and likelihood-max mechanisms used subsequently are classical; the new connection is their transfer to the exact-pivotal optimum through this quantitative construction.

A second principal contribution is the universal construction and matching minimax comparison in Theorems 8.2–8.3. One statistic, independent of the unknown alternative, is exact and has an identical entire distribution under all nulls while attaining the classical optimal logarithmic learning coefficient. The result concerns arbitrary fixed finite collections of full-support nulls, with a substantive pivotality constraint when $L\ge2$. Normalized maximum likelihood, information-radius lower bounds and the coefficient itself are classical [12–14,17]. Ordinary universal inference [15] and simple-null relative-GROW/NML theory [16] already provide alternative adaptation without this multiple-null distribution constraint.

Combining a common null law with alternative learning also has important structured precedents. Henzi and Law [18] use randomized sequential ranks to reduce the composite independence null to a common uniform law, then apply multinomial prediction; their Remark 2 discusses Jeffreys-prior growth optimality and universal coding. Pérez-Ortiz et al. [19] establish absolute and relative GROW optimality of maximal-invariant likelihood ratios in suitable group models. Our added result is the quantitative guarantee for an arbitrary fixed finite null family without such rank or group structure, measured against its original-experiment, alternative-specific ordinary optimum. We do not claim the general idea of learning after a pivotal reduction as new.

Recent work on infinite-family binary pivots [3], growing Gaussian grids [4], ordinary log-optimal e-values [5], constrained e-values [6], and GROW duality [7] concerns adjacent constraints or optimization problems. None of the results inspected in those sources supplies the fixed-family construction and bound proved below. Pan, Li and Tan [8] study second-order composite sequential testing and a central limit theorem for a maximized log-likelihood statistic. Their Proposition 6 in arXiv v2 has a scalar normal limit under its regularity assumptions; we do not attribute the tied-minimizer coefficient below to that proposition. The literature comparison is bounded by the versions and material recorded in [the accompanying source record](results/academic-evidence.json); it is not a universal priority claim.

### 1.1 Experiment and randomization

Fix $L\ge1$ and pairwise distinct probability measures $P_1,\ldots,P_L,Q$ on a standard Borel space $\mathcal X$. Repeated copies of a null are removed. Throughout the main theorem,

$$
Q\ll P_i,\qquad 0\lt d_i:=D(Q\Vert P_i)\lt \infty,
\qquad r:=\min_i d_i. \tag{1.1}
$$

The observation is $X^n=(X_1,\ldots,X_n)$, iid under the applicable distribution. We explicitly allow $U\sim\operatorname{Unif}[0,1]$, independent of $X^n$ under every hypothesis. All e-variables may be measurable functions of $(X^n,U)$. Standard Borel kernels can therefore be implemented as randomized statistics. This is not an assertion about deterministic statistics on an arbitrary finite sample space. Under the stronger joint-atomlessness condition of [1,2,11], the same construction can use the common random source encoded in the experiment; ordinary atomlessness alone is not that condition.

The null family at sample size $n$ is precisely

$$
\mathcal P_n=\{P_1^{\otimes n},\ldots,P_L^{\otimes n}\}. \tag{1.2}
$$

The results also hold for mixtures of these complete product laws. They do not automatically hold for iid sampling from every member of $\operatorname{conv}\{P_i\}$ or for arbitrary switching between nulls over time. The constructions in Sections 2–7 use the specified alternative; Section 8 treats an unknown alternative under finite-alphabet assumptions. A convex mixture of product laws and a product of a convex mixture are different experiments.

Define

$$
\begin{aligned}
V_n&=\sup\{\mathbb E_{Q^{\otimes n}\otimes U}\log E:
 E\ge0,\ \mathbb E_{P_i^{\otimes n}\otimes U}E\le1\ \forall i\},\\
\ell_n&=\sup\{\mathbb E_{Q^{\otimes n}\otimes U}\log E:
 E\text{ is exact and has the same law under every }P_i^{\otimes n}\otimes U\}.
\end{aligned} \tag{1.3}
$$

Use $\log0=-\infty$; statistics of expected log value $-\infty$ cause no difficulty. The positive log parts in (1.3) are integrable under (1.1), as proved below. The constant statistic one is feasible, so both suprema are nonnegative. We make no general attainment claim for either supremum.

Take a common dominating probability measure, for example the average of the $L+1$ measures, and write its densities as $p_i,q$. Product densities are denoted $p_i^{(n)},q^{(n)}$. Put

$$
S_{i,n}=\log\frac{q^{(n)}}{p_i^{(n)}},\qquad
T_n=\min_i S_{i,n},\qquad B_n=\mathbb E_{Q^{\otimes n}}T_n. \tag{1.4}
$$

On the $Q^{\otimes n}$-null set where a ratio is not defined, choose any measurable version; for the construction set $T_n=-\infty$ wherever $q^{(n)}=0$. Such conventions do not change $B_n$.

## 2. The finite-sample theorem

For probability measures $R,S$, let

$$
H(R,S)=\int\sqrt{\frac{dR}{d\mu}\frac{dS}{d\mu}}\,d\mu
$$

be their Hellinger affinity, independent of the choice of dominating measure. It is at most one, equals one exactly when $R=S$, and tensorizes: $H(R^{\otimes n},S^{\otimes n})=H(R,S)^n$. For the fixed tuple $\mathcal F=\{Q,P_1,\ldots,P_L\}$, define

$$
h=\max\bigl( e^{-1},\max_{R\ne S\in\mathcal F}H(R,S)\bigr),
\qquad b=-\log h\in(0,1]. \tag{2.1}
$$

For each positive integer $n$, write

$$
a_n=nb,\quad \rho_n=2Lh^n,\quad \eta_n=Lh^{n/2},\quad
c_n=\frac{1-\rho_n}{1-2\rho_n}. \tag{2.2}
$$

The latter quantity is used only when $\rho_n\lt 1/2$. A sufficient explicit sample threshold is

$$
n_0=\left\lceil\frac{\max\{\log(8L),\,2\log(eL),\,1\}}{b}\right\rceil. \tag{2.3}
$$

**Theorem 2.1 (quantitative exact pivotalization).** Under (1.1), for every integer $n\ge n_0$, there is an explicitly specified randomized exact-pivotal e-variable $E_n$ satisfying

$$
\mathbb E_Q\log E_n\ge B_n-\varepsilon_n,
\qquad
\varepsilon_n=\log c_n+\eta_n\left(a_n+\log\frac1{\eta_n}\right). \tag{2.4}
$$

Here and below $\mathbb E_Q$ on a sample statistic includes the product sample law and any common randomization. In particular,

$$
B_n-\varepsilon_n\le\ell_n\le V_n
\le\min\{nr,\ B_n+\log L\}, \tag{2.5}
$$

and

$$
0\le V_n-\ell_n\le\log L+\varepsilon_n,
\qquad \varepsilon_n=O(nh^{n/2}). \tag{2.6}
$$

Constants and $n_0$ depend on the fixed experiment. In particular they need not remain controlled when distinct nulls approach one another or when $L$ grows. The exponent in (2.4) concerns the difference from $B_n$. It does not assert exponential convergence to $nr$ in every model.

**Lemma 2.2 (integrability and ordinary upper bounds).** Each $S_{i,n}$ and $T_n$ is $Q^{\otimes n}$-integrable. Every ordinary valid e-variable has integrable positive log part and obeys the two upper bounds in (2.5).

*Proof.* For one observation,

$$
\int_{q\lt p_i}q\log\frac{p_i}{q}\,d\mu\le\frac1e\int p_i\,d\mu=\frac1e.
$$

Thus finite relative entropy implies absolute integrability of each log ratio. Finite sums and minima preserve integrability here, since $|\min_i z_i|\le\sum_i|z_i|$.

Let $R=d(Q^{\otimes n}\otimes U)/d(P_i^{\otimes n}\otimes U)$. On the alternative support,

$$
\log^+E\le\log^+R+\log^+(E/R),\qquad
\mathbb E_Q\log^+(E/R)\le\mathbb E_Q(E/R)\le1.
$$

Jensen's inequality for the logarithm, also valid with an infinite negative part, gives $\mathbb E_Q\log(E/R)\le0$. Therefore $\mathbb E_Q\log E\le nd_i$. Apply the same argument to the complete-sample null mixture $\bar P_n=L^{-1}\sum_iP_i^{\otimes n}$, under which $E$ is valid. Its density is at least $\max_i p_i^{(n)}/L$, so

$$
\mathbb E_Q\log E\le D(Q^{\otimes n}\Vert\bar P_n)
\le\mathbb E_Q T_n+\log L.
$$

Taking suprema proves the upper bounds. $\square$

## 3. Positive compensation of complete output laws

The following finite-experiment lemma is stated for measures rather than a finite output table. All matrix norms in this section are induced infinity norms, namely maximum absolute row sums.

**Lemma 3.1 (positive compensation).** Let $A,D_1,\ldots,D_L$ be a measurable partition of an experiment's sample space. On $A$, a measurable map emits a value in a standard Borel space $Y$. Its output subprobability measures under the nulls and alternative are $\nu_1,\ldots,\nu_L,\nu_Q$. Let

$$
M_{ki}=P_k(D_i),\qquad \|M-I\|_\infty\le\rho\lt \tfrac12,
\qquad c=\frac{1-\rho}{1-2\rho}. \tag{3.1}
$$

Set $\lambda=\sum_i\nu_i$, choose $u_i=d\nu_i/d\lambda$, and define the envelope measure $\omega$ by

$$
\frac{d\omega}{d\lambda}=m:=\max_i u_i.
$$

If $\lambda=0$, take all these densities and $\omega$ to be zero. Suppose

$$
\nu_Q\ll\lambda,\qquad \sigma:=\omega(Y)\le\frac{1-2\rho}{2}. \tag{3.2}
$$

There exist nonnegative measures $Z_i$ on $Y$, each of mass at most $1/2$, defined by

$$
\begin{pmatrix}Z_1\\\vdots\\Z_L\end{pmatrix}
=M^{-1}\left(c\omega\mathbf1-
\begin{pmatrix}\nu_1\\\vdots\\\nu_L\end{pmatrix}\right). \tag{3.3}
$$

Retain the original output on $A$. On $D_i$, output according to the subprobability measure $Z_i$, and output a distinct dummy symbol $\partial$ with the remaining probability. The resulting Markov kernel has one common null law

$$
\pi|_Y=c\omega,\qquad \pi\{\partial\}=1-c\sigma\ge\tfrac12. \tag{3.4}
$$

Its alternative law $R_Q$ is

$$
R_Q|_Y=\nu_Q+\sum_iQ(D_i)Z_i,\qquad
R_Q\{\partial\}=1-R_Q(Y). \tag{3.5}
$$

In particular $R_Q\ll\pi$, and $E=dR_Q/d\pi$, evaluated at the kernel output, is exact and pivotal. Its e-power is $D(R_Q\Vert\pi)$, with the usual extended-value convention.

*Proof.* The Neumann series gives

$$
\|M^{-1}\|_\infty\le\frac1{1-\rho},\qquad
\|M^{-1}-I\|_\infty\le\theta:=\frac\rho{1-\rho}.
$$

At almost every output point, let $d=cm\mathbf1-u$. Each coordinate lies between $(c-1)m$ and $cm$. For $z=M^{-1}d$,

$$
z_i\ge[(c-1)-\theta c]m=0,
\qquad z_i\le\frac{cm}{1-\rho}=\frac m{1-2\rho}. \tag{3.6}
$$

These pointwise densities define the nonnegative measures (3.3); their masses are at most $\sigma/(1-2\rho)\le1/2$. Thus the proposed kernel is a probability kernel. Under null $P_k$, its measure on $Y$ is

$$
\nu_k+\sum_iM_{ki}Z_i=c\omega.
$$

The dummy probability is the complement. Since $c\sigma\le(1-\rho)/2\le1/2$, (3.4) holds. Every $Z_i$ is dominated by $\omega$; assumption (3.2) also implies $\nu_Q\ll\omega$. The dummy mass is positive, so $R_Q\ll\pi$. The RN derivative may be defined as zero on exceptional $\pi$-null sets. Its null expectation is $\int(dR_Q/d\pi)d\pi=1$, and its null law is common because the underlying output law is common. Formula (3.5) gives the claimed log expectation. $\square$

The construction solves one $L\times L$ linear system, but its inputs include probability measures or integrals. “Explicit” in this lemma means a specified mathematical kernel, not a polynomial-time numerical method for arbitrary continuous distributions.

## 4. Hellinger separation supplies the compensation regions

We now prove Theorem 2.1. Fix $n\ge n_0$ and abbreviate $a=a_n$, $\rho=\rho_n$, $\eta=\eta_n$, and $c=c_n$.

**Lemma 4.1 (rare high scores and null classification).** Let

$$
A=\{T_n\ge a\}.
$$

On $A^c$, assign each sample to the index maximizing $p_i^{(n)}$, breaking ties by the smallest index, and call the resulting sets $D_i$. Then

$$
P_i^{\otimes n}(A)\le h^n,\qquad Q^{\otimes n}(A^c)\le\eta,
\qquad \|M-I\|_\infty\le\rho, \tag{4.1}
$$

where $M_{ki}=P_k^{\otimes n}(D_i)$.

*Proof.* On $A$, every $p_i^{(n)}\le e^{-a}q^{(n)}$; integration gives the first inequality. For the alternative, Markov's inequality gives

$$
Q^{\otimes n}(S_{i,n}\lt a)
\le e^{a/2}\mathbb E_Q\exp(-S_{i,n}/2)
\le e^{a/2}H(Q,P_i)^n.
$$

The last expectation can integrate over the alternative support only; it is bounded by the full affinity even without $P_i\ll Q$. A union bound, $a=-n\log h$, and (2.1) yield $Q(A^c)\le Lh^{n/2}$.

Under $P_i^{\otimes n}$, a wrong maximum-likelihood classification requires $p_j^{(n)}\ge p_i^{(n)}$ for some $j\ne i$. Another half-likelihood Markov bound gives probability at most $H(P_i,P_j)^n$. Excluding $A$ therefore loses at most $Lh^n$, so $M_{ii}\ge1-Lh^n$. Each matrix row sums to at most one. Consequently its absolute deviation from the corresponding identity row is at most $2(1-M_{ii})\le2Lh^n$. $\square$

**Lemma 4.2 (the score envelope).** On $A$, emit the score $s=T_n\in Y=[a,\infty)$. The resulting measures satisfy

$$
\nu_i(ds)\le e^{-s}\nu_Q(ds),\qquad
\omega(ds)\le e^{-s}\nu_Q(ds),\qquad \sigma\le h^n. \tag{4.2}
$$

Moreover, $\nu_i$ and $\nu_Q$ are equivalent on the score output space, unless both are zero.

*Proof.* For every nonnegative measurable $f$, restricting to $A\subset\{q^{(n)}>0\}$ gives

$$
\int f(s)\,\nu_i(ds)
=\mathbb E_Q\left[\frac{p_i^{(n)}}{q^{(n)}}f(T_n)\mathbf1_A\right]
\le\mathbb E_Q[e^{-T_n}f(T_n)\mathbf1_A].
$$

This proves the first measure domination. Taking densities relative to a common dominating measure and their pointwise maximum proves the second. Its integral is at most $e^{-a}Q(A)\le h^n$. On $A$, the positive $q^{(n)}$ density implies $P_i^{\otimes n}|_A\ll Q^{\otimes n}|_A$. The reverse domination follows from $Q\ll P_i$. Pushforward preserves these two absolute-continuity relations. $\square$

By (2.3), $\rho\le1/4$, $\eta\le e^{-1}$, $a\ge\log(8L)$, and $h^n\le1/(8L)$. In particular

$$
\sigma\le\frac18\le\frac{1-2\rho}{2},\qquad
c\le\frac32,\qquad a>\log c. \tag{4.3}
$$

Lemmas 3.1 and 4.2 therefore produce the required kernel and e-variable.

**Lemma 4.3 (log-power retained by the score).** The constructed statistic satisfies (2.4).

*Proof.* On $Y$, write $R=R_Q|_Y$. Equations (3.5) and (4.2) give

$$
\pi|_Y=c\omega\le c e^{-s}\nu_Q\le c e^{-s}R.
$$

Hence $\log(dR/d\pi)(s)\ge s-\log c\ge0$, almost everywhere for $R$. Since $R\ge\nu_Q$,

$$
\int_Y\log\frac{dR}{d\pi}\,dR
\ge\int_Y(s-\log c)\,d\nu_Q
\ge\mathbb E_Q[T_n\mathbf1_A]-\log c. \tag{4.4}
$$

Let $u=R_Q\{\partial\}$. The kernel only emits the dummy on $A^c$, so $0\le u\le Q(A^c)\le\eta$. Its log contribution obeys

$$
u\log\frac u{\pi\{\partial\}}\ge u\log u\ge\eta\log\eta, \tag{4.5}
$$

where $0\log0=0$ and the last step uses $\eta\le e^{-1}$. Finally, $T_n\lt a$ on $A^c$; negative values only improve the following bound:

$$
\mathbb E_Q[T_n\mathbf1_A]\ge B_n-a\eta. \tag{4.6}
$$

Combining (4.4)–(4.6) proves (2.4). There is no undefined difference of infinite log integrals: the positive part is integrable by Lemma 2.2 because the constructed statistic is valid, while the negative part is confined to the single dummy atom. Equivalently, data processing gives $D(R_Q\Vert\pi)\le nD(Q\Vert P_i)\lt \infty$. Lemma 2.2 now supplies (2.5) and (2.6). As $\rho_n=2Lh^n$, $\log c_n=O(h^n)$, and $\log(1/\eta_n)=nb/2-\log L$, the stated exponential remainder follows. $\square$

**Corollary 4.4 (first-order limit, recovered with attribution).** Under (1.1), $\ell_n/n\to r$ and $V_n/n\to r$.

*Proof.* The iid $L^1$ law of large numbers gives $S_{i,n}/n\to d_i$ in $L^1$. The inequality $|\min_i x_i-\min_i y_i|\le\sum_i|x_i-y_i|$ gives $B_n/n\to r$. Apply (2.5). This is a quantitative route to the finite-KL part of the first-order result in [2], not a new first-order claim. $\square$

## 5. Gaussian competition and the oracle comparison

In this section assume, in addition to (1.1),

$$
\mathbb E_Q\left|\log(q/p_i)\right|^2\lt \infty\quad\text{for all }i. \tag{5.1}
$$

Let $I=\{i:d_i=r\}$, and for all indices define the centered variables

$$
Z_i=\log(p_i/q)+d_i,\qquad
W_{n,i}=\frac1{\sqrt n}\sum_{t=1}^n Z_i(X_t).
$$

Let $G=(G_i)_{i\in I}$ be a centered Gaussian vector with covariance $\operatorname{Cov}_Q(Z_i,Z_j)$, allowing singular covariance, and put $\kappa=\mathbb E\max_{i\in I}G_i$.

**Theorem 5.1 (second-order e-power).** Under (1.1) and (5.1),

$$
\ell_n=nr-\sqrt n\,\kappa+o(\sqrt n),\qquad
V_n=nr-\sqrt n\,\kappa+o(\sqrt n). \tag{5.2}
$$

*Proof.* Exactly,

$$
T_n=nr-\sqrt n\max_{1\le i\le L}
\{W_{n,i}-\sqrt n(d_i-r)\}. \tag{5.3}
$$

Fix $i_0\in I$. The difference between the maximum in (5.3) and $\max_{i\in I}W_{n,i}$ is nonnegative and at most

$$
\sum_{j\notin I}(W_{n,j}-W_{n,i_0}-\sqrt n(d_j-r))_+.
$$

For $t>0$, $(x-t)_+\le x^2/(4t)$. Each centered difference has a variance independent of $n$, so the expectation of this display is $O(n^{-1/2})$, in particular $o(1)$. The multivariate iid CLT gives $W_{n,I}\Rightarrow G$. Further,

$$
\sup_n\mathbb E\max_{i\in I}|W_{n,i}|^2
\le\sum_{i\in I}\mathbb E_Q Z_i^2\lt \infty.
$$

Thus the maxima are uniformly integrable, and their expectations converge to $\kappa$. Formula (5.3) yields the expansion for $B_n$. Both optimizers differ from $B_n$ by quantities lying between $-\varepsilon_n$ and $\log L$, so (5.2) follows. $\square$

The same second-order coefficient for $V_n$ is essential to the interpretation: the $\sqrt n$ term is the competition between null likelihoods. It is not an additional cost caused by exactness or pivotality. We do not assert a general $O(1)$ remainder in (5.2).

**Proposition 5.2 (zero and positive competition).** The coefficient $\kappa$ is nonnegative. It is zero exactly when all active null densities agree $Q$-almost surely:

$$
p_i=p_j\quad Q\text{-almost surely for every }i,j\in I. \tag{5.4}
$$

If $I=\{i,j\}$, then

$$
\kappa=\sqrt{\frac{\operatorname{Var}_Q\log(p_i/p_j)}{2\pi}}. \tag{5.5}
$$

*Proof.* A maximum dominates each centered coordinate, giving nonnegativity. If a pair has positive difference variance, then

$$
\mathbb E\max(G_i,G_j)
=\tfrac12\mathbb E|G_i-G_j|
=\sqrt{\operatorname{Var}(G_i-G_j)/(2\pi)}>0.
$$

Conversely, if $\kappa=0$, for each active $i$ the nonnegative random variable $\max_jG_j-G_i$ has mean zero. All Gaussian coordinates therefore agree almost surely, so $\operatorname{Var}_Q\log(p_i/p_j)=0$. Equal active KL divergences give mean zero for this log ratio, proving (5.4). That condition conversely makes all active coordinates identical. The two-coordinate calculation gives (5.5). $\square$

For pairwise distinct finite-alphabet nulls, if the entire experiment including $Q$ has full support, (5.4) fails whenever there is more than one active null. For general dominated experiments, distinct measures can differ only outside the alternative support; the condition cannot be omitted.

**Theorem 5.3 (an exponential oracle regime).** Suppose $i_*$ is the unique KL minimizer. For each $j\ne i_*$, suppose there is $t_j>0$ such that

$$
b_j:=\mathbb E_Q\exp\{t_j\log(p_j/p_{i_*})\}\lt 1. \tag{5.6}
$$

Then, for $n\ge n_0$,

$$
0\le nr-\ell_n\le\varepsilon_n+\sum_{j\ne i_*}\frac{b_j^n}{t_j}. \tag{5.7}
$$

The same bound holds with $V_n$ in place of $\ell_n$. Condition (5.6) holds for every full-support finite-alphabet model with a unique minimizer.

*Proof.* Put $Y_j=\log(p_j/p_{i_*})$, whose $Q$-mean is $d_{i_*}-d_j\lt 0$. Pointwise,

$$
S_{i_*,n}-T_n
=\max\left(0,\max_{j\ne i_*}\sum_{t=1}^nY_j(X_t)\right)
\le\sum_{j\ne i_*}\left(\sum_{t=1}^nY_j(X_t)\right)_+.
$$

Use $x_+\le e^{tx}/t$, independence, and (5.6) to bound the expectation by $\sum_jb_j^n/t_j$. Now apply (2.5). On a finite full-support alphabet each $Y_j$ is bounded, its moment generating function is differentiable at zero with negative derivative, and a sufficiently small positive $t_j$ satisfies (5.6). $\square$

When $L=1$, the usual likelihood ratio is already exact and trivially pivotal, and both optima equal $nd_1$ for every $n$. Without (5.6) or a substitute concentration argument, uniqueness of the KL minimizer alone does not supply (5.7).

## 6. A local near-tie transition

Consider a triangular family on one fixed finite alphabet: $Q_n,P_{1,n},\ldots,P_{L,n}$ converge coordinatewise to pairwise distinct full-support distributions $Q_0,P_{1,0},\ldots,P_{L,0}$. The number of nulls and the alphabet are fixed. Their probabilities are therefore uniformly bounded away from zero for all sufficiently large $n$. In row $n$, the experiment consists of $n$ iid observations from that row's distribution.

Write $d_{i,n}=D(Q_n\Vert P_{i,n})$, $r_n=\min_i d_{i,n}$, and suppose each

$$
\delta_{i,n}=\sqrt n(d_{i,n}-r_n)\longrightarrow\delta_i\in[0,\infty]. \tag{6.1}
$$

Let $J=\{i:\delta_i\lt \infty\}$. It is nonempty, and at least one $\delta_i$ is zero. For $i\in J$, let $G_i$ be jointly centered Gaussian with the limiting covariance of $\log(p_{i,n}/q_n)+d_{i,n}$ under $Q_n$.

**Theorem 6.1 (local competition law).** For the row-wise ordinary and exact-pivotal optima,

$$
\frac{nr_n-\ell_n}{\sqrt n}\longrightarrow
\mathbb E\max_{i\in J}(G_i-\delta_i),
\qquad
\frac{nr_n-V_n}{\sqrt n}\longrightarrow
\mathbb E\max_{i\in J}(G_i-\delta_i). \tag{6.2}
$$

*Proof.* Continuity of the finite-alphabet affinities and distinct limiting distributions give one $\bar h\lt 1$ that bounds all row affinities eventually. Use $\bar h$ in the construction of Theorem 2.1. Its sample threshold and exponentially small remainder are then uniform across these rows.

The row-centered log vectors are uniformly bounded, their covariance matrices converge, and the iid triangular-array CLT applies. One may see this directly by expanding the one-row characteristic function at $t/\sqrt n$: the linear term is zero, the quadratic term converges to the limiting covariance, and the bounded third-order remainder multiplied by $n$ vanishes. The scaled sum therefore converges to the stated Gaussian vector, including singular covariance cases. Uniform second moments give uniform integrability of its maximum.

The exact identity (5.3) holds with row-dependent divergences. Indices with $\delta_{i,n}\to\infty$ can be removed in expectation: compare to an index with finite limiting offset and apply $(x-t)_+\le x^2/(4t)$ once their offset difference is positive and diverging. For the remaining finite set, continuous mapping and uniform integrability give the shifted Gaussian maximum in (6.2). The uniform version of (2.5) completes the proof. $\square$

**Corollary 6.2 (two competitors).** If $J=\{1,2\}$, $\delta_1=0$, $\delta_2=\delta\ge0$, and $s^2=\operatorname{Var}(G_2-G_1)>0$, the limiting coefficient is

$$
s\varphi(\delta/s)-\delta\Phi(-\delta/s), \tag{6.3}
$$

where $\varphi,\Phi$ are the standard normal density and cdf.

*Proof.* The maximum is $G_1+(G_2-G_1-\delta)_+$. Its expectation is the positive-part integral of a centered normal with variance $s^2$; direct integration gives (6.3). At $\delta=0$ it is $s/\sqrt{2\pi}$; it tends to zero as $\delta\to\infty$. $\square$

This theorem concerns competing KL distances while the underlying distributions remain separated. It does not address coalescing null distributions or growing null grids.

## 7. Finite types, examples, and verification

**Proposition 7.1 (type-based implementation).** On an alphabet of size $K$, all likelihood ratios, the retention set, and null maximum-likelihood classification depend only on the empirical count vector. The construction can be computed from at most

$$
N_{n,K}=\binom{n+K-1}{K-1} \tag{7.1}
$$

types. Computing their probabilities, the classification matrix, the compensation columns, and the alternative output law requires $O(LKn+LK N_{n,K}+L^3+L^2N_{n,K})$ arithmetic operations using precomputed powers and multinomial factors. Thus the operation count is polynomial in $n$ for fixed $K,L$.

*Proof.* A type with counts $k_1,\ldots,k_K$ has probability $n!\prod_x r_x^{k_x}/\prod_xk_x!$ under distribution $R$. Its multinomial factor cancels in every likelihood ratio. The type count is the stars-and-bars count (7.1). After enumerating types, sum the corresponding probabilities to form $M$ and $Q(D_i)$, invert $M$ once, and apply that inverse to one compensation column for each retained type. These steps have the stated arithmetic cost. Keeping the type itself as output is permissible in Lemma 3.1; its likelihood ratios are constant, so $q_j/\max_i p_{ij}=\exp(T_n(j))$. The proof of the log bound is unchanged. $\square$

This is not a complexity bound uniform in $K,L$, nor a generic finite-precision certificate for continuous probability integrals. If input probabilities and the likelihood retention threshold are rational, the table, its measured matrix norm, $c$, compensation probabilities, and e-values can all be checked with rational arithmetic. The logarithms used to display e-power remain real quantities.

### 7.1 A two-null Bernoulli illustration

Take $P_1=\operatorname{Bern}(1/10)$, $P_2=\operatorname{Bern}(9/10)$, and $Q=\operatorname{Bern}(1/2)$. If $K_n=\sum_t X_t$, direct calculation gives

$$
r=\log(5/3),\qquad
T_n=nr-\log9\,|K_n-n/2|,\qquad
\kappa=\frac{\log9}{\sqrt{2\pi}}. \tag{7.2}
$$

These formulas illustrate the general theorem; symmetry examples and the Gaussian-max mechanism are not claimed as new principles. For $Q_n=\operatorname{Bern}(1/2+t/\sqrt n)$ with fixed $t$, the two local offsets differ by $2|t|\log9$, and (6.3) becomes

$$
\log9\,[\varphi(2|t|)-2|t|\Phi(-2|t|)]. \tag{7.3}
$$

The absolute KL gap is $|2q_n-1|\log9$, and the limiting variance of the log-null ratio is $(\log9)^2$, proving (7.3).

### 7.2 Distinct tied nulls can have zero penalty

On the alphabet $\{a,b,c\}$, take

$$
Q=(1,0,0),\quad P_1=(1/2,1/2,0),\quad P_2=(1/2,0,1/2).
$$

Both KL divergences are $\log2$, yet the active null densities agree on the alternative support. The statistic

$$
E_n=2^n\mathbf1\{X_1=\cdots=X_n=a\} \tag{7.4}
$$

has the same two-point distribution and mean one under both nulls. Under $Q$ it is always $2^n$, so $\ell_n=V_n=n\log2$ by Lemma 2.2. This verifies the zero-penalty boundary in Proposition 5.2. It does not extend to arbitrary point-mass alternatives with unequal null masses.

### 7.3 A small-sample obstruction

At $n=1$ on a two-point alphabet, let $P_1=(9/10,1/10)$, $P_2=(1/10,9/10)$, and $Q=(1,0)$. For any randomized statistic, denote its conditional output laws by $K_0,K_1$. Pivotality says $(9/10)K_0+(1/10)K_1=(1/10)K_0+(9/10)K_1$, so $K_0=K_1$. Its alternative law equals the common null law. If exact, Jensen gives e-power at most zero. Hence $\ell_1=0$, whereas the single-nearest-null information is $-\log(9/10)>0$. This illustrates why a sufficiently large sample requirement is meaningful even with randomization.

### 7.4 Reproducible finite checks

The accompanying standard-library Python program evaluates finite type tables with exact `Fraction` arithmetic. The checks cover positive compensation, probability row sums, equality of the entire null output laws, and exact unit null expectations. Separate floating-point calculations report log-power, the likelihood-envelope expectation, and the analytic finite-experiment bound. They are numerical diagnostics, not certified intervals for logarithms and not proofs of the general theorems. Full parameters, counts, script hash, and runtime version are recorded in `results/finite_experiments.json`. Run instructions are in `REPRODUCTION.md`.

## 8. Universal adaptation to an unknown alternative

The previous general-space construction knows the alternative. We now construct one statistic that does not. Fix an alphabet of size $K\ge2$, put $d=K-1$, and let $P_1,\ldots,P_L$ be distinct full-support null distributions. The alternative $Q$ may be any fixed distribution on this alphabet other than a null, including a distribution on the boundary of the simplex. The null set is still the fixed collection of complete product laws, and the common independent randomization source remains available.

Universal coding, normalized maximum likelihood (NML), and the classical $d\log n/2$ redundancy coefficient are established theory [12–14,17]. Ordinary alternative-adaptive e-values and the relation between relative GROW and NML are also prior work [15,16]. Structured independence and group models already admit common-null-law reductions combined with alternative learning or relative growth optimality [18,19]. Here the requirement is one exact statistic with an identical entire null law for an arbitrary fixed finite list, while controlling regret relative to the ordinary optimum of the original experiment. For $L=1$, pivotality imposes no additional constraint and the learning mechanism is classical.

### 8.1 A classical universal likelihood

For a sample $x^n$ with symbol counts $k_1,\ldots,k_K$, define

$$
f_n(x^n)=\prod_{a=1}^K(k_a/n)^{k_a},\qquad
C_{n,K}=\sum_{x^n}f_n(x^n),\qquad
m_n(x^n)=f_n(x^n)/C_{n,K}, \tag{8.1}
$$

where $0^0=1$. This is the multinomial NML distribution [12,14]. It is positive on every sample; it is generally not an iid product distribution. For every alphabet distribution $Q$,

$$
q^{(n)}(x^n)\le C_{n,K}m_n(x^n). \tag{8.2}
$$

**Lemma 8.1 (classical NML size bound).** For fixed $K$, there are positive finite constants $u_K,v_K$ such that for every $n\ge1$,

$$
u_K(n+1)^{d/2}\le C_{n,K}\le v_K(n+1)^{d/2}.
\quad\text{Thus}\quad
\log C_{n,K}=\frac d2\log n+O_K(1). \tag{8.3}
$$

*Proof.* Two-sided Stirling inequalities, with constants extended to the case of zero counts, bound the probability of a type under its empirical maximum-likelihood distribution by constant multiples, depending only on $K$, of

$$
\sqrt{n+1}\prod_{a=1}^K(k_a+1)^{-1/2}.
$$

For $\alpha,\beta>0$, the sum

$$
\sum_{j=0}^n(j+1)^{\alpha-1}(n-j+1)^{\beta-1}
$$

is bounded above and below by positive constant multiples of $(n+1)^{\alpha+\beta-1}$. For the upper bound, split the sum at $n/2$, bound the factor with index at least $n/2$ by its scale, and sum the remaining power. For the lower bound, restrict to $n/3\le j\le2n/3$ and absorb the finitely many small values of $n$ into the constant. Induction therefore gives

$$
\sum_{k_1+\cdots+k_K=n}\prod_a(k_a+1)^{-1/2}
\asymp_K(n+1)^{K/2-1}.
$$

Summing the maximum-likelihood type probabilities proves (8.3). This proof only supplies constant-factor bounds; sharper coding constants are known [14] and are not claimed here. $\square$

### 8.2 One exact pivot for every fixed alternative

Choose a threshold without using $Q$:

$$
a_n=\lceil\sqrt n\rceil\log2,\qquad s_n=e^{-a_n},\qquad
h_P=\max\bigl(e^{-1},\max_{i\ne j}H(P_i,P_j)\bigr), \tag{8.4}
$$

where the pairwise maximum is omitted when $L=1$. Put

$$
\rho_n^{\mathrm u}=2\{s_n+(L-1)h_P^n\},\qquad
c_n^{\mathrm u}=\frac{1-\rho_n^{\mathrm u}}{1-2\rho_n^{\mathrm u}}.
$$

A sufficient construction threshold, depending only on the nulls, is

$$
n_*=\max\left\{16,\left\lceil
\frac{\log(16\max\{1,L-1\})}{-\log h_P}
\right\rceil\right\}. \tag{8.5}
$$

For an actual alternative $Q$, used only to assess performance, set

$$
h_Q=\max_iH(Q,P_i)\lt1,\qquad
\eta_n(Q)=L\sqrt{C_{n,K}}\,e^{a_n/2}h_Q^n,
$$

and define

$$
\epsilon_n^{\mathrm u}(Q)=
\log c_n^{\mathrm u}+
\eta_n(Q)\left(a_n+\log\frac{2C_{n,K}}{1-s_n}\right). \tag{8.6}
$$

**Theorem 8.2 (universal exact-pivotal regret bound).** There is one sequence $\widehat E_n$, determined only by the nulls, $K$, $n$ and the common random source, such that each statistic is exact and pivotal, and for every $Q\notin\{P_1,\ldots,P_L\}$ and every $n\ge n_*$,

$$
\mathbb E_Q\log\widehat E_n
\ge B_n(Q)-\log C_{n,K}-\epsilon_n^{\mathrm u}(Q), \tag{8.7}
$$

where $B_n(Q)=\mathbb E_Q\min_i\log(q^{(n)}/p_i^{(n)})$. Consequently,

$$
0\le V_n(Q)-\mathbb E_Q\log\widehat E_n
\le\log L+\log C_{n,K}+\epsilon_n^{\mathrm u}(Q). \tag{8.8}
$$

The remainder tends to zero for each fixed such $Q$, uniformly over every compact subset of the probability simplex that avoids all the nulls. The construction and $n_*$ do not depend on that subset.

*Proof.* Write $m=m_n$ and $C=C_{n,K}$. Retain a sample precisely on

$$
A=\{T_n^m\ge a_n\},\qquad
T_n^m=\log\frac{m}{\max_i p_i^{(n)}}.
$$

On $A^c$, use the same null maximum-likelihood classification as in Lemma 4.1. Then

$$
P_i^{\otimes n}(A)\le s_n,\qquad
\|M-I\|_\infty\le2\{s_n+(L-1)h_P^n\}=\rho_n^{\mathrm u}. \tag{8.9}
$$

Indeed, the retained set has null probability at most $e^{-a_n}$ by its likelihood definition, and a wrong null classification costs at most $(L-1)h_P^n$. On $A$ retain the complete sample as the output. The envelope of the null output submeasures then has density $\max_i p_i^{(n)}\mathbf1_A$, and its mass is at most $s_n$. By (8.5), $\rho_n^{\mathrm u}\le1/4$, $s_n\le1/16$, and $a_n>\log c_n^{\mathrm u}$. All conditions of Lemma 3.1 hold with alternative measure $m$. That lemma is a finite-experiment statement and does not require its alternative to be a product measure.

Let $K_n$ be the resulting kernel, $\pi_n$ its common null output law, and $R_m=K_nm$. Define $\widehat E_n=dR_m/d\pi_n$ at its output. This statistic is exact and pivotal and does not involve $Q$. On the retained output space,

$$
\log\widehat E_n(x^n)\ge T_n^m(x^n)-\log c_n^{\mathrm u}\ge0. \tag{8.10}
$$

We must also control its logarithm at the dummy under an alternative different from $m$. Every compensation measure has mass at most $1/2$. Using (8.2) with any null gives

$$
R_m\{\partial\}\ge\tfrac12m(A^c)
\ge\frac{1-s_n}{2C}.
$$

Since $\pi_n\{\partial\}\le1$,

$$
\widehat E_n(\partial)\ge\frac{1-s_n}{2C}. \tag{8.11}
$$

For an arbitrary actual $Q$, (8.2) implies $T_n^m\ge T_n^Q-\log C$ on its support. The half-likelihood estimate used in Lemma 4.1 now yields

$$
Q^{\otimes n}(A^c)
\le\sum_i Q^{\otimes n}
\left(\log(q^{(n)}/p_i^{(n)})\lt a_n+\log C\right)
\le\eta_n(Q). \tag{8.12}
$$

The bound can exceed one at small sample sizes without affecting the argument. The output law under $Q$ dominates $Q^{\otimes n}|_A$, and its dummy probability is at most $Q^{\otimes n}(A^c)$. Thus (8.10)–(8.11) give

$$
\mathbb E_Q\log\widehat E_n
\ge
\mathbb E_Q[T_n^m\mathbf1_A]-\log c_n^{\mathrm u}
-Q^{\otimes n}(A^c)\log\frac{2C}{1-s_n}.
$$

Because $T_n^m\lt a_n$ on $A^c$ and $\mathbb E_QT_n^m\ge B_n(Q)-\log C$, this proves (8.7). All log integrals are finite: the sample alphabet is finite, $m$ and the null densities are positive, and (8.11) handles the dummy. Lemma 2.2 proves (8.8).

Finally, $\log c_n^{\mathrm u}=O(s_n+h_P^n)$ and $C$ grows polynomially by Lemma 8.1, whereas $a_n=O(\sqrt n)$. Hence the remainder tends to zero whenever $h_Q\lt1$. Affinity is continuous on the closed probability simplex and equals one only at equality of the measures. A compact set avoiding the nulls therefore has a common bound $h_Q\le\bar h\lt1$, giving uniform convergence. For $n\lt n_*$ define $\widehat E_n=1$. $\square$

The sublinear threshold is necessary for this particular universal construction to cover arbitrarily close fixed alternatives without knowing their separation. Its compensation error is of order $e^{-c\sqrt n}$ plus a $Q$-dependent exponentially small term; it is not the general-space theorem's fixed exponential remainder. Uniform convergence is not claimed for arbitrary sequences of alternatives approaching a null.

All quantities can again be computed by types. If the null probabilities are rational, the NML type masses and the threshold $e^{a_n}=2^{\lceil\sqrt n\rceil}$ are rational. In an exact table computation, $\rho_n^{\mathrm u}$ may be replaced by the measured norm $\widehat\rho=\|M-I\|_\infty$ and the corresponding compensation constant. Since $\widehat\rho\le\rho_n^{\mathrm u}$ and $(1-\rho)/(1-2\rho)$ increases in $\rho$, the stated upper error bound remains valid. This gives rational kernel and calibration certificates whenever the lemma's budget is verified.

### 8.3 The learning coefficient cannot be improved

Let $\Theta$ be a nondegenerate closed coordinate cube in the interior of the $K$-symbol simplex, parameterized by its first $d=K-1$ probabilities. Suppose the cube avoids all nulls and one fixed $i_*$ is the unique KL nearest null at every point of the cube. Such cubes exist: take an interior distribution sufficiently close to a null, distinct from it, and then a small surrounding cube.

For one statistic $E$ that cannot use the unknown $\theta$, define its regret as $V_n(Q_\theta)-\mathbb E_{Q_\theta}\log E$. Let $\mathcal E_n$ be all ordinary valid randomized statistics for the finite null family and $\mathcal F_n\subseteq\mathcal E_n$ the exact-pivotal ones. Define

$$
\mathcal R_n^{\mathrm{valid}}(\Theta)
=\inf_{E\in\mathcal E_n}\sup_{\theta\in\Theta}
\{V_n(Q_\theta)-\mathbb E_{Q_\theta}\log E\},
\qquad
\mathcal R_n^{\mathrm{piv}}(\Theta)
=\inf_{E\in\mathcal F_n}\sup_{\theta\in\Theta}
\{V_n(Q_\theta)-\mathbb E_{Q_\theta}\log E\}. \tag{8.13}
$$

**Theorem 8.3 (sharp logarithmic adaptation coefficient).** Under these conditions,

$$
\frac d2\log n-O_\Theta(1)
\le\mathcal R_n^{\mathrm{valid}}(\Theta)
\le\mathcal R_n^{\mathrm{piv}}(\Theta)
\le\frac d2\log n+O_\Theta(1). \tag{8.14}
$$

The particular statistic in Theorem 8.2 attains the upper bound without knowing the cube. Thus exactness and the common entire null law do not increase the leading minimax learning cost. This does not identify the optimal constant term.

*Proof.* The upper bound follows from Theorem 8.2, its uniform remainder on $\Theta$, and Lemma 8.1. The middle inequality follows from inclusion of the two classes. We prove the lower bound for every ordinary valid statistic, including randomized ones.

First, uniformly over the cube,

$$
0\le nD(Q_\theta\Vert P_{i_*})-V_n(Q_\theta)
\le A e^{-cn} \tag{8.15}
$$

for constants $A,c>0$, with zero error if $L=1$. To see this without any uniformity assumption left implicit, the KL gaps have a positive minimum on the compact cube. Each fixed log-null ratio $Y_j=\log(p_j/p_{i_*})$ is bounded and has uniformly negative $Q_\theta$-mean. The expansion $e^{tY_j}\le1+tY_j+t^2B^2e^{tB}/2$, valid for $|Y_j|\le B$, supplies one sufficiently small positive $t$ and one $b\lt1$ for all $\theta$ and all $j\ne i_*$. The positive-part estimate in the proof of Theorem 5.3 gives $nD(Q_\theta\Vert P_{i_*})-B_n(Q_\theta)\le (L-1)b^n/t$. The ordinary statistic $\exp T_n^Q$ is valid, so $V_n(Q)\ge B_n(Q)$, proving (8.15).

Average a given $E(X^n,U)$ over $U$, obtaining $\bar E(X^n)$. Jensen gives $\mathbb E_Q\log E\le\mathbb E_Q\log\bar E$, while $\bar E$ remains valid. Let $z=\mathbb E_{P_{i_*}^{\otimes n}}\bar E\le1$. If $z=0$, the regret is infinite. Otherwise

$$
R_n(x^n)=p_{i_*}^{(n)}(x^n)\bar E(x^n)/z
$$

is a probability mass function, and

$$
\mathbb E_Q\log E
\le nD(Q\Vert P_{i_*})-D(Q^{\otimes n}\Vert R_n). \tag{8.16}
$$

The inequality also covers zeros of $R_n$, with infinite divergence.

Choose $\theta$ uniformly on the cube and, conditionally on $\theta$, draw $X^n$ iid from $Q_\theta$. If $\overline Q_n$ denotes the resulting mixture, the information-radius identity gives

$$
\mathbb E_\theta D(Q_\theta^{\otimes n}\Vert R_n)
=I(\theta;X^n)+D(\overline Q_n\Vert R_n)
\ge I(\theta;X^n). \tag{8.17}
$$

For completeness, the needed information lower bound follows directly from estimation error. Let $\widehat\theta$ be the first $d$ empirical symbol frequencies. Then $\mathbb E\|\theta-\widehat\theta\|^2\le d/(4n)$. Translation by an $X^n$-measurable vector, the fact that conditioning cannot increase entropy, and the Gaussian maximum-entropy inequality imply

$$
h(\theta\mid X^n)
=h(\theta-\widehat\theta\mid X^n)
\le h(\theta-\widehat\theta)
\le\frac d2\log\left(
\frac{2\pi e}{d}\mathbb E\|\theta-\widehat\theta\|^2\right)
\le\frac d2\log\frac{\pi e}{2n}. \tag{8.18}
$$

These differential entropies are finite for each $n$: the prior is uniform on a compact interior cube, and the finitely many positive likelihood functions give bounded posterior densities with positive lower bounds on that cube. The translated error is a finite mixture of such densities on compact sets. Since $h(\theta)=\log\operatorname{Vol}(\Theta)$, (8.18) yields

$$
I(\theta;X^n)\ge
\frac d2\log n+\log\operatorname{Vol}(\Theta)
-\frac d2\log(\pi e/2). \tag{8.19}
$$

Combine (8.15)–(8.17), average the regret over this prior, and use that a supremum dominates its average. Equation (8.19) proves the lower bound in (8.14). The information-radius and entropy mechanisms are classical [13,17]; their use here compares the ordinary and exact-pivotal minimax classes for the same finite composite null. $\square$

**Corollary 8.4 (universal second-order efficiency).** For any fixed alphabet alternative $Q$ distinct from the full-support nulls, the same universal statistic obeys

$$
\mathbb E_Q\log\widehat E_n
=nr-\sqrt n\,\kappa+o(\sqrt n), \tag{8.20}
$$

with $r,\kappa$ as in Section 5.

*Proof.* On the finite support of $Q$, all log ratios have finite second moments. Theorem 5.1 applies, and (8.8) places the universal statistic within $O(\log n)$ of $V_n(Q)$. Since $\log n=o(\sqrt n)$, (8.20) follows. $\square$


## 9. Scope and unresolved questions

The general standard-Borel construction is alternative-specific; Section 8 gives a single alternative-independent construction on a fixed finite alphabet with full-support nulls. Both apply to a fixed finite list of complete iid null laws. Neither constructs a process simultaneously valid at every stopping time. Separate fixed-$n$ e-variables cannot automatically be treated as one e-process.

The bound $\log L$ is not proved to be the optimal worst-case additive price. An exact description of that price, finite-sample optimization of the output kernel, and sharp third-order terms remain open here. Our threshold can be conservative. An efficiently computable continuous-model implementation requires more than the existence of the stated measure operations.

The near-tie theorem keeps pairwise separation and alphabet size controlled. It supplies no uniform growing-family or merging-null limit. Infinite KL divergences, general composite alternatives outside the finite-alphabet setting of Section 8, and arbitrary dependent observations are outside the results as stated. The finite-KL assumption is sufficient for the main exponential envelope approximation; second moments and (5.6) are additional assumptions only where explicitly invoked.

This manuscript has not undergone external peer review or proof-assistant verification. The finite checks do not establish the general theorems.

## References

1. Zhenyuan Zhang, Aaditya Ramdas and Ruodu Wang. *On the existence of powerful p-values and e-values for composite hypotheses*. The Annals of Statistics **52**(5), 2241–2267 (2024). DOI: [10.1214/24-AOS2434](https://doi.org/10.1214/24-AOS2434). Relevant technical comparisons use [arXiv:2305.16539v4](https://arxiv.org/html/2305.16539v4); that version's section and example numbering is distinguished from the published version.
2. Hengzhi He and Guang Cheng. *Asymptotically Lossless Exact and Pivotal E-Values*. [arXiv:2609.27923v1](https://arxiv.org/html/2609.27923v1) (2026), Theorem 2.2 and Sections 3–6. Preprint; no journal publication was verified in this review.
3. Anonymous. *Exact pivotal e-variables for infinite hypotheses: a binary construction and what pivotality costs*. Evidence Press, version 0.1.0-candidate (16 November 2026). DOI: [10.5281/zenodo.24268845](https://doi.org/10.5281/zenodo.24268845). [Release](https://www.evidencepress.org/releases/exact-pivotal-e-variables-infinite-hypotheses/) and [source manuscript](https://github.com/ipitchford/exact-pivotal-e-variables-infinite-hypotheses/blob/main/manuscript.tex). Unrefereed candidate; its public claims are included in the prior-art comparison.
4. Anonymous. *The cost of exact calibration for growing Gaussian null families*. Evidence Press, version 0.1.0-candidate (15 November 2026). DOI: [10.5281/zenodo.24252837](https://doi.org/10.5281/zenodo.24252837). [Release](https://www.evidencepress.org/releases/exact-calibration-gaussian-null-families/) and [source manuscript](https://github.com/ipitchford/exact-calibration-gaussian-null-families/blob/main/manuscript.tex). Unrefereed candidate.
5. Martin Larsson, Aaditya Ramdas and Johannes Ruf. *The numeraire e-variable and reverse information projection*. The Annals of Statistics **53**(3), 1015–1043 (2025). DOI: [10.1214/24-AOS2487](https://doi.org/10.1214/24-AOS2487). Read version: [arXiv:2402.18810v4](https://arxiv.org/html/2402.18810v4).
6. Aytijhya Saha and Aaditya Ramdas. *Optimal e-variables under constraints*. [arXiv:2604.21680v1](https://arxiv.org/html/2604.21680v1) (23 April 2026). Preprint.
7. Ashwin Ram, Martin Larsson, Johannes Ruf and Aaditya Ramdas. *Strong duality for the GROW criterion*. [arXiv:2606.24768v2](https://arxiv.org/abs/2606.24768v2) (20 July 2026). Preprint.
8. Jiachun Pan, Yonglong Li and Vincent Y. F. Tan. *Asymptotics of Sequential Composite Hypothesis Testing Under Probabilistic Constraints*. IEEE Transactions on Information Theory **68**(8), 4998–5012 (2022). [Publisher record](https://ieeexplore.ieee.org/document/9745944); read version: [arXiv:2106.00896v2](https://arxiv.org/html/2106.00896v2). The separate IEEE ISIT 2021 version has DOI [10.1109/ISIT45174.2021.9517987](https://doi.org/10.1109/ISIT45174.2021.9517987). Used for comparison of likelihood-max asymptotics, not as an input to the calibration proof.
9. Muhammad Usman Farooq, Tobias Fritz, Erkka Haapasalo and Marco Tomamichel. *Matrix Majorization in Large Samples*. IEEE Transactions on Information Theory **70**(5), 3118–3144 (2024). DOI: [10.1109/TIT.2024.3352088](https://doi.org/10.1109/TIT.2024.3352088). Read version: [arXiv:2301.07353v2](https://arxiv.org/html/2301.07353v2), especially Theorem 19.
10. Peter Grünwald, Rianne de Heide and Wouter Koolen. *Safe testing*. Journal of the Royal Statistical Society Series B: Statistical Methodology **86**(5), 1091–1128 (2024). DOI: [10.1093/jrsssb/qkae011](https://doi.org/10.1093/jrsssb/qkae011).
11. Ruodu Wang and Zhenyuan Zhang. *Simultaneous optimal transport*. Transactions of the American Mathematical Society **378**(8), 5845–5898 (2025). DOI: [10.1090/tran/9393](https://doi.org/10.1090/tran/9393). Read [author manuscript dated 20 December 2024](https://www.math.uwaterloo.ca/~wang/papers/2024Wang-Zhang-TAMS.pdf), especially the joint-atomlessness definition and Proposition 1.

12. Yu. M. Shtar’kov. *Universal Sequential Coding of Single Messages*. Problems of Information Transmission **23**(3), 175–186 (1987); Russian original in Problemy Peredachi Informatsii **23**(3), 3–17. [Journal archive record](https://www.mathnet.ru/php/archive.phtml?jrnid=ppi&option_lang=eng&paperid=811&wshow=paper). NML and pointwise minimax regret are classical; the elementary size bound used here is proved in Lemma 8.1.
13. Bertrand S. Clarke and Andrew R. Barron. *Information-Theoretic Asymptotics of Bayes Methods*. IEEE Transactions on Information Theory **36**(3), 453–471 (1990). DOI: [10.1109/18.54897](https://doi.org/10.1109/18.54897). [Author-hosted published paper](https://bertrandsclarke.weebly.com/uploads/2/7/3/6/2736392/clarkebarron1990.pdf). Background for classical dimension-dependent information cost, not a source of the new calibration kernel.
14. Qun Xie and Andrew R. Barron. *Asymptotic Minimax Regret for Data Compression, Gambling, and Prediction*. IEEE Transactions on Information Theory **46**(2), 431–445 (2000). DOI: [10.1109/18.825803](https://doi.org/10.1109/18.825803). [Publisher record](https://ieeexplore.ieee.org/document/825803/). Classical multinomial minimax regret, including sharper constants than used here.
15. Larry Wasserman, Aaditya Ramdas and Sivaraman Balakrishnan. *Universal inference*. Proceedings of the National Academy of Sciences **117**(29), 16880–16890 (2020). DOI: [10.1073/pnas.1922664117](https://doi.org/10.1073/pnas.1922664117). [Full text](https://pmc.ncbi.nlm.nih.gov/articles/PMC7382245/). Finite-sample ordinary validity with estimated alternatives is existing work; it does not impose the common entire null law studied here.
16. Peter Grünwald, Yunda Hao and Akshay Balsubramani. *Growth-Optimal E-Variables and an extension to the multivariate Csiszár-Sanov-Chernoff Theorem*. [arXiv:2412.17554v2](https://arxiv.org/pdf/2412.17554v2) (2024). Sections 1.2 and 3.2 distinguish its simple-null setting and NML relative-GROW connection from the finite composite-null constraint here. Preprint.
17. Qun Xie and Andrew R. Barron. *Minimax redundancy for the class of memoryless sources*. IEEE Transactions on Information Theory **43**(2), 646–657 (1997). DOI: [10.1109/18.556120](https://doi.org/10.1109/18.556120). Classical expected redundancy over the multinomial family; its coefficient and stronger constant asymptotics are not new claims of this paper.

18. Alexander Henzi and Michael Law. *A rank-based sequential test of independence*. Biometrika **111**(4), 1169–1186 (2024). DOI: [10.1093/biomet/asae023](https://doi.org/10.1093/biomet/asae023). Read version: [arXiv:2305.13818v4](https://arxiv.org/pdf/2305.13818v4), especially Section 3.2, Proposition 1 and Remark 2. Its common-law rank reduction and universal multinomial learning are structured precedents; they are not attributed to this paper.
19. Muriel Felipe Pérez-Ortiz, Tyron Lardy, Rianne de Heide and Peter D. Grünwald. *E-statistics, group invariance and anytime-valid testing*. The Annals of Statistics **52**(4), 1410–1432 (2024). DOI: [10.1214/24-AOS2394](https://doi.org/10.1214/24-AOS2394). [Author-hosted published paper](https://riannedeheide.github.io/AOS2394.pdf); technical comparison also uses Sections 2.4 and 3 of [arXiv:2208.07610v2](https://arxiv.org/html/2208.07610v2). Group invariance and amenability underpin its relative-GROW result.

Classical inputs used with their ordinary mathematical meanings are Radon–Nikodym derivatives, the finite-dimensional Neumann series, randomized implementation of standard Borel kernels, the iid $L^1$ law of large numbers, and finite-dimensional central limit theorems. Their role is stated explicitly in each proof; no new claim of authorship is made for them.
