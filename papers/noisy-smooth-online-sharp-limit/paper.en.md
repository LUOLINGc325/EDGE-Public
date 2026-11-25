# The large-power minimax constant for smooth online learning with corrupted feedback

AI-assisted research manuscript

24 November 2026

**Intended reader:** doctoral students in learning theory and analysis.
**Status:** research draft; no claim of external peer review or end-to-end formal verification.

## Abstract

We study adversarial online prediction of an absolutely continuous function on the unit interval whose derivative has $L^q$ norm at most one. At most $\eta$ reported labels may be arbitrarily corrupted, and the first $2\eta+1$ observations are unscored. For every fixed $q>1$, we prove that the minimax sum of $p$th powers of true prediction errors converges to $2\eta+1$ as $p\to\infty$. More precisely, with $\alpha=1-1/q$ and $\alpha p>1$, this minimax loss lies between $2\eta+1$ and $(2\eta+1)(1+(2^{\alpha p}-2)^{-1})$. The upper bound is guaranteed by the median of the $2\eta+1$ nearest previous reported labels. Its proof combines majority robustness, the classical nearest-predecessor energy bound, and a colouring reduction for higher nearest-neighbour ranks. We also establish the exact supremum of the resulting geometric energy. The limit resolves the $q>1$ part of Conjecture 5.1 in Xie's 2025 preprint; its printed $q=1$ endpoint is false. We distinguish this preprint statement from the subsequent COLT 2026 version, which omits that numbered conjecture. Neither an exact finite-$p$ minimax formula nor an optimal convergence rate is asserted.

## 1. Problem and contribution

Online smooth-function prediction asks for a bound on accumulated absolute error that is independent of the number of queries. Incorrect feedback makes this requirement delicate: a single reported value may be arbitrarily far from the target. Xie's corrupted-feedback model allows a fixed number of such reports and scores errors against the true function [X25, X26]. For $p,q\ge2$, the published bounds are $2\eta+1$ and $12\eta+6$ [X26, Lemmas 4.3–4.4].

Conjecture 5.1 of the 2025 preprint asks whether the large-$p$ limit equals the lower bound [X25]. The COLT 2026 version retains the model and bounds but no longer lists this conjecture; its Section 5 still identifies precise noisy-model values as a research direction [X26]. We prove the limit throughout $q>1$, with an explicit approximation bound and a single simple learner.

The ingredients have important precedents. The one-nearest-predecessor energy estimate appears as Lemma 2.18 of Geneson–Zhou [GZ23], attributed there to Kimber–Long [KL95]. The endpoint lower bound is Xie's [X25, X26]. Median-of-nearest-labels regression is also an existing method, including the poisoning-robust kNN-m regressor of Hammoudeh–Lowd [HL23]. Local binning medians combined with Hölder/Sobolev smoothness also appear in robust nonparametric regression [Du18]. We do not claim to invent these ingredients. We include self-contained geometric and lower-bound proofs; the contribution is the higher-rank reduction as used here, the explicit cumulative-loss analysis, and the resulting large-power minimax limit. The literature comparison is limited to the sources actually inspected; no standalone priority claim is made for the geometric lifting technique.

## 2. Model and main theorem

For $1<q<\infty$, define

$$
\mathcal F_q=\left\{f\in AC[0,1]:
\int_0^1|f'(u)|^q\,du\le1\right\}.
$$

Here $AC[0,1]$ denotes absolutely continuous real functions. We also permit $q=\infty$, with $\|f'\|_{L^\infty}\le1$ interpreted as an essential-supremum bound. This is the class of $1$-Lipschitz functions. No value of $f$ is fixed in advance; its additive constant is unrestricted. Set

$$
k=2\eta+1,\qquad \alpha=1-1/q,
$$

where $\eta$ is a known nonnegative integer and $1/\infty=0$.

At time $t=0,1,\ldots$, a query $x_t\in[0,1]$ is presented. The learner predicts $\widehat y_t$, then observes a reported label $z_t$. A single fixed target $f\in\mathcal F_q$ is consistent with all but at most $\eta$ reports:

$$
\#\{t:z_t\ne f(x_t)\}\le\eta.
$$

Queries may repeat and may depend on previous history. Corrupted labels have no magnitude restriction. The corruption budget includes the initial observations. We omit precisely the first $k$ rounds from loss. For every finite $T\ge k$, write

$$
L_{p,\eta,T}(A,f,x,z)
=\sum_{t=k}^{T}|\widehat y_t-f(x_t)|^p.
$$

Let $V_{p,\eta}(\mathcal F_q)$ be the infimum over deterministic learners of the supremum of this loss over all finite horizons, targets and admissible query/report sequences. This is Xie's noisy minimax quantity with the zero-based scoring convention made explicit. The upper bound below is pathwise, so it also applies to adaptive queries and reports.

**Theorem 1 (large-power minimax constant).** For $\eta\ge0$, $1<q\le\infty$, and every real $p$ satisfying $s=\alpha p>1$,

$$
\boxed{
2\eta+1\ \le\ V_{p,\eta}(\mathcal F_q)
\ \le\ (2\eta+1)\left(1+\frac{1}{2^{\alpha p}-2}\right).
}
\tag{1}
$$

In particular, for fixed $\eta$ and $q>1$,

$$
\boxed{\lim_{p\to\infty}V_{p,\eta}(\mathcal F_q)=2\eta+1.}
\tag{2}
$$

The same bounds hold for randomized learners when minimax performance is measured in expected loss: the deterministic upper-bound algorithm remains admissible, and the lower-bound construction in Section 5 applies to this formulation.

The excess in (1) is at most $k/(2^{\alpha p}-2)$. Thus, for any relative tolerance $\varepsilon>0$,

$$
p\ge \alpha^{-1}\log_2(2+\varepsilon^{-1})
\quad\Longrightarrow\quad
V_{p,\eta}(\mathcal F_q)\le(1+\varepsilon)(2\eta+1).
\tag{3}
$$

For example, when $q=2$ and $p=8$, (1) gives $k\le V_{8,\eta}\le15k/14$. This illustrates a guarantee, not an exact finite-$p$ value.

## 3. The learner and the local error bound

For each scored round, select the $k$ nearest previous **observations**. Observations at the same input remain separate entries. To resolve equal distances, order indices by the pair $(|x_t-x_i|,i)$. Predict the median of the corresponding reported labels.

```text
Input: corruption-count bound η; set k = 2η + 1.
Store every previous pair (input, reported label).
For rounds t = 0, 1, ...:
    Receive x_t.
    If t < k:
        Make any prediction; this round is unscored.
    Otherwise:
        Let I be the first k previous indices ordered by (|x_t-x_i|, i).
        Predict the (η+1)st smallest value among {z_i : i in I}.
    Receive z_t and store (x_t, z_t).
```

The algorithm needs $\eta$ but neither $p$ nor $q$. Let $r_t$ be the $k$th smallest distance from $x_t$ to a previous observation, counting multiplicity.

**Lemma 2 (robustness of the local median).** On every admissible play and every scored round,

$$
|\widehat y_t-f(x_t)|\le r_t^\alpha.
\tag{4}
$$

**Proof.** For $1<q<\infty$, absolute continuity and Hölder's inequality yield

$$
|f(x)-f(y)|
\le\int_{\min(x,y)}^{\max(x,y)}|f'(u)|\,du
\le |x-y|^{1-1/q}\|f'\|_q
\le |x-y|^\alpha.
$$

For $q=\infty$, the same conclusion follows from the Lipschitz condition. At least $\eta+1$ of the $k=2\eta+1$ selected labels are genuine. Each lies in

$$
[f(x_t)-r_t^\alpha,\ f(x_t)+r_t^\alpha].
$$

A list of $2\eta+1$ real values with at least $\eta+1$ entries in an interval has its median in that interval. This proves (4). If $r_t=0$, the same argument gives exact prediction. No boundedness assumption on corrupted labels is used. $\square$

The remaining task is geometric: bound the sum of powers of $r_t$ uniformly over every input sequence.

## 4. A sharp bound for higher nearest-neighbour rank

**Theorem 3 (geometric energy).** Let $k\ge1$ be an integer, $s>1$ real, and $x_0,\ldots,x_T\in[0,1]$. For $t\ge k$, let $r_t$ denote the distance to the $k$th nearest previous observation. Then

$$
\sum_{t=k}^{T}r_t^s\le kC_s,
\qquad C_s=1+\frac1{2^s-2}.
\tag{5}
$$

Moreover, $kC_s$ is the exact supremum over all finite sequences and horizons.

### 4.1 The classical rank-one estimate

We first give a complete proof of the known estimate from [KL95], as recorded in [GZ23, Lemma 2.18]. Let $a_0,\ldots,a_n\in[0,1]$, and put

$$
d_j=\min_{i<j}|a_j-a_i|\qquad(j\ge1).
$$

We claim that

$$
\sum_{j=1}^{n}d_j^s\le C_s.
\tag{6}
$$

Maintain the ordered set of distinct observed inputs and the potential

$$
P=\sum_{u<v\text{ consecutive observed inputs}}(v-u)^s.
$$

Initially $P=0$. Duplicate insertions have distance zero and do not change $P$. A new point outside the current convex hull extends it by a distance $d$; this insertion contributes $d^s$ to the energy and increases $P$ by $d^s$. A point inserted inside a gap of length $u+v$ has distance $\min(u,v)$ to its nearest predecessor and decreases the potential by

$$
\Delta=(u+v)^s-u^s-v^s.
$$

For $0<u\le v$, set $z=v/u\ge1$. Since

$$
\frac{d}{dz}\big((1+z)^s-1-z^s\big)
=s\big((1+z)^{s-1}-z^{s-1}\big)>0,
$$

we obtain

$$
\Delta\ge(2^s-2)\min(u,v)^s.
\tag{7}
$$

Let $B$ be the total energy of hull-extending insertions, and $I$ the total energy of interior insertions. Hull extensions have nonnegative lengths whose sum is the final hull length, at most one. Thus

$$
B\le\left(\sum_{\rm extensions}d\right)^s\le1.
$$

The exact potential balance and its nonnegativity give

$$
P_{\rm final}=B-\sum_{\rm interior}\Delta\ge0,
\qquad
(2^s-2)I\le\sum_{\rm interior}\Delta\le B.
$$

Consequently $B+I\le BC_s\le C_s$, proving (6). Arbitrary initial locations, repeated points and alternating left/right hull extensions are all included.

### 4.2 Reduction from rank $k$ to rank one

Assign the initial $k$ observations pairwise distinct colours from $\{1,\ldots,k\}$. At every subsequent time, inspect the $k-1$ nearest previous observations. Some colour is absent from this list; assign any such colour to the new observation. Every colour already has an initial seed.

Any earlier observation of the chosen colour lies outside the first $k-1$ nearest positions. Therefore its distance to the new input is at least $r_t$. If $d_t$ is the nearest-predecessor distance within the chosen colour, then

$$
r_t\le d_t.
\tag{8}
$$

Equal distances cause no difficulty: exclusion from the first $k-1$ positions gives a weak inequality, which is precisely what (8) requires. Apply (6) independently to the subsequence of each colour, omitting its initial seed. Summing proves

$$
\sum_{t=k}^{T}r_t^s
\le\sum_{c=1}^{k}\sum_{t\text{ assigned colour }c}d_t^s
\le kC_s.
$$

Colours are used only in the proof. The learner in Section 3 does not compute them.

### 4.3 Sharpness of the geometric constant

Begin with $k$ copies of $0$, followed by $k$ copies of $1$. At each successive level $j=1,\ldots,J$, insert all points

$$
\frac{2\ell-1}{2^j},\qquad \ell=1,\ldots,2^{j-1},
$$

repeating each new point $k$ times before moving on. Every copy of $1$ has $k$th nearest distance one. At a level-$j$ point, the previously completed coarser grid has nearest distance $2^{-j}$, with at least $k$ observations there. Distinct points already inserted at the same level are farther away. While the $k$ copies of the new point are being inserted, fewer than $k$ observations are located at that point. Hence each of these copies has $k$th nearest distance exactly $2^{-j}$.

The resulting finite energy is

$$
k\left(1+\sum_{j=1}^{J}2^{j-1}2^{-js}\right)
=k\left(1+\frac{1-2^{J(1-s)}}{2^s-2}\right).
\tag{9}
$$

It increases to $kC_s$ as $J\to\infty$, proving the supremum assertion. This establishes sharpness of (5) only. Simultaneously attaining every Hölder error bound with one target function is a different question, so (9) gives no matching finite-$p$ regression lower bound. $\square$

## 5. Proof of the minimax theorem

By Lemma 2 and Theorem 3, whenever $s=\alpha p>1$, every finite admissible play satisfies

$$
L_{p,\eta,T}
\le\sum_{t=k}^{T}r_t^{\alpha p}
\le k\left(1+\frac1{2^{\alpha p}-2}\right).
$$

This proves the upper bound uniformly over all horizons. There is no interchange of an infinite-horizon supremum with the limit in $p$.

For completeness, we restate Xie's lower-bound construction [X26, Lemma 4.4 and Appendix D.3], with explicit target quantifiers. The construction and the constant $2\eta+1$ are attributed to that work. For the initial $k$ rounds, query $0$ and report zero. Next make $k$ scored queries at $1$. Report $-1$ after the first $\eta$ scored predictions and $+1$ after the next $\eta$ predictions. After the last scored prediction, report the true value.

Consider the two fixed targets $f_+(x)=x$ and $f_-(x)=-x$. Each belongs to every $\mathcal F_q$, and each requires exactly $\eta$ corrupted reports in this transcript. All $k$ scored predictions, say $b_1,\ldots,b_k$, are made before the transcript distinguishes the two targets. For $p\ge1$, convexity implies

$$
\frac{|b_j-1|^p+|b_j+1|^p}{2}\ge1.
$$

At least one target therefore produces total loss at least $k$. For a deterministic learner, its predictions on the common transcript can be computed in advance and the target chosen before play; no change to a previously fixed function is needed.

For a randomized learner, choose the target sign uniformly at the start, independently of its random choices. Until the final scored prediction the transcript is sign-independent. The same inequality, averaged over the learner's randomness, gives expected loss at least $k$; consequently one fixed sign has expected loss at least $k$. This proves the lower bound even against a distribution over obliviously fixed admissible instances. Although the source states its lemma for $p,q\ge2$, this proof works for all $p\ge1,q\ge1$.

Finally, $k/(2^{\alpha p}-2)\to0$ for fixed $q>1$, so (1) yields (2). Solving $1/(2^{\alpha p}-2)\le\varepsilon$ gives (3). $\square$

## 6. Why the endpoint $q=1$ must be excluded

The printed 2025 conjecture includes $q=1$. Its finiteness theorem already rules out that endpoint [X25]; the published version also gives infiniteness when $q=1$ [X26, Theorem 4.2]. Here is a direct deterministic proof that remains valid with the prescribed warmup.

Let every warmup query be $0$ with label zero. Make one scored query at $1$ with label one; its loss may be ignored. Maintain an interval $[a,b]$, initially $[0,1]$, whose endpoints have values zero and one, and whose interior contains no earlier query. Query its midpoint $m$. If the learner predicts at least $1/2$, report zero and replace $a$ by $m$. Otherwise report one and replace $b$ by $m$. Each such round incurs true error at least $1/2$ for every target consistent with the eventual transcript.

After $N$ midpoint queries, set $f$ equal to zero to the left of the remaining interval, equal to one to its right, and affine between the two endpoints. This function agrees with every report, is absolutely continuous, and has $\int_0^1|f'|=1$. No labels were corrupted. For a deterministic learner the finite transcript and this target can be determined in advance, so they constitute a valid fixed-target instance. The scored loss is at least $N2^{-p}$, and $N$ is arbitrary. Therefore

$$
V_{p,\eta}(\mathcal F_1)=\infty\qquad\text{for every finite }p\ge1.
$$

We make no inference about why the endpoint was included in the preprint. It is an invalid part of its printed formulation, rather than a case of the positive theorem.

## 7. Consequences, limits and further questions

Theorem 1 identifies the exact limiting cost of a finite corruption budget in this model. Its guarantee is independent of the time horizon and corruption magnitudes. The factor $2\eta+1$ comes from a majority large enough to survive all allowed corruptions, while the geometric bound controls how often distant observations are needed.

Several boundaries remain explicit. The argument requires $\alpha p>1$ and therefore does not reproduce the full finiteness range $p,q>1$ proved in [X26]. It does not determine any exact finite-$p$ noisy minimax value. The exponential upper bound on the excess is not claimed to be an optimal convergence rate. The result is pointwise in fixed $q>1$, not uniform over a joint limit $q\downarrow1$ and $p\to\infty$. It assumes a known corruption-count bound, one-dimensional inputs and true-target loss; it does not cover unrestricted stochastic noise, higher dimensions or a total corruption-magnitude budget.

Natural next questions are whether the minimax value equals $2\eta+1$ already for some finite range of $p$, whether an explicit learner obtains sharp dependence near $p=1$ or $q=1$, and how much performance is lost when $\eta$ is unknown. The exact geometric supremum is available for these questions, but by itself cannot settle the regression optimum because the target's smoothness budget couples errors across rounds.

## 8. Reproduction and verification scope

The reference learner uses only the Python standard library and retains observations with multiplicity. Sorting the entire history on each round gives a direct implementation with $O(t\log t+k\log k)$ prediction time and $O(t)$ stored observations; no optimal runtime is asserted.

The reported exact checks cover median robustness, the colouring comparison, potential identities, dyadic sharpness witnesses, and corrupted online trajectories with rational piecewise-affine targets. An independent verifier uses no colouring argument: it solves the finite-grid optimization by Bellman recursion on occupancy counts capped at $k$, then replays each maximizing witness by explicitly sorting rational distances. Once a coordinate has $k$ observations, further copies have zero insertion cost and cannot alter any subsequent $k$th-neighbour distance. The finite-state recursion therefore covers every initial block and arbitrarily long sequences on each listed grid.

These finite-grid and integer-exponent checks do not certify all real parameters or all real input sequences. The general statement rests on the written proof. The reproduction programs and raw outputs are not included in this version; no end-to-end Lean verification or external peer review is claimed.

## References

**[X25]** Weian Xie. *Worst-case Error Bounds for Online Learning of Smooth Functions*. arXiv:2502.16388v1, 2025. In particular, Section 1.4, Lemma 4.4 and Conjecture 5.1. [Preprint](https://arxiv.org/abs/2502.16388v1) · [PDF](https://arxiv.org/pdf/2502.16388v1).

**[X26]** Weian (Andrew) Xie. *Worst-case Error Bounds for Online Learning of Smooth Functions*. Proceedings of the Thirty Ninth Conference on Learning Theory, Proceedings of Machine Learning Research **336**, 6858–6884, 2026. The final version omits the numbered Conjecture 5.1 of [X25]. [Official proceedings](https://proceedings.mlr.press/v336/xie26a.html) · [Official linked PDF](https://raw.githubusercontent.com/mlresearch/v336/main/assets/xie26a/xie26a.pdf).

**[GZ23]** Jesse Geneson and Ethan Zhou. *Online Learning of Smooth Functions*. Theoretical Computer Science **979**, 114203, 2023. The inspected preprint is arXiv:2301.01434v1; its Lemma 2.18 states the classical nearest-predecessor energy bound and credits [KL95]. [Preprint](https://arxiv.org/abs/2301.01434v1) · [Journal article](https://www.sciencedirect.com/science/article/pii/S0304397523005169).

**[KL95]** D. Kimber and Philip M. Long. *On-line learning of smooth functions of a single variable*. Theoretical Computer Science **148**, 141–156, 1995. The rank-one estimate is attributed to this work through the explicitly inspected statement in [GZ23].

**[HL23]** Zayd Hammoudeh and Daniel Lowd. *Reducing Certified Regression to Certified Classification for General Poisoning Attacks*. IEEE Conference on Secure and Trustworthy Machine Learning, 2023. Inspected author version: arXiv:2208.13904v2. Its kNN-m rule predicts the median of the nearest labels and gives pointwise poisoning certificates; it does not supply the online cumulative-loss theorem studied here. [Preprint](https://arxiv.org/abs/2208.13904v2) · [Author PDF](https://ix.cs.uoregon.edu/~lowd/hammoudeh-satml23.pdf).

**[Du18]** Simon S. Du, Yining Wang, Sivaraman Balakrishnan, Pradeep Ravikumar and Aarti Singh. *Robust Nonparametric Regression under Huber's $\varepsilon$-contamination Model*. arXiv:1805.10406v1, 2018. The fixed-design contamination model and integrated estimation risk differ from the online cumulative-loss problem considered here. [Preprint](https://arxiv.org/abs/1805.10406v1).
