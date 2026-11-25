---
title: Sharp ordered Gaffke intervals under bounded likelihood tilts
lang: en-US
---

## Abstract

The original ordered-sample refinement replaces the uniform variable in the randomized Gaffke rule by the rank of the observed word among the distinct permutations of its multiset. We determine what can be retained when the measurements are independent but their distributions differ. With no restriction beyond a common mean, conditional validity forces the replacement to be one on every orbit. When a known set of \(r\) measurements has bounded likelihood tilts from the remaining common law, we give the exact conditional p-value for each word, including ties, and a polynomial-time algorithm for fixed \(r\). The sharp factor preserves the finite-sample coverage and nesting of Gaffke's interval. We determine the largest possible reduction in interval width explicitly. The sharpness arguments use independent distributions that genuinely have a common mean. When the number of tilted positions is unrestricted and their weights are supplied, even one exact conditional rank probability is #P-hard to compute.

## 1. Model and valid interval

Fix \(n\ge2\), a list of \(r\) positions specified before seeing the data, and finite constants \(\Gamma_i\ge1\) for those positions. Use a fixed word order with these positions first. For a law \(P\) on \([0,1]\), the remaining \(n-r\) variables have law \(P\). The other variables have laws

\[
 dP_i(x)=\frac{g_i(x)}{\int g_i\,dP}\,dP(x),\qquad 1\le g_i(x)\le\Gamma_i,\quad 1\le i\le r. \tag{1}
\]

All positions are independent. For interval coverage suppose that all positions have the same unknown mean \(\mu\). The reference law can also have mean \(\mu\), and all sharpness constructions below have this property even if \(r=n\). Equivalently the sensitivity parameter \(\Gamma_i\) bounds the essential ratio between the highest and lowest Radon–Nikodym weight in position \(i\). The law and the tilt functions are unknown. At \(r=0\) we recover the ordered IID problem. Conditional statements below are for the multiset and its distinct words, so ties are retained. No ordering of positions based on observed values is allowed.

Let \(B\) denote the observed multiset, let \(M=|\Omega(B)|\), and write its distinct words as \(w^{(1)}<\cdots<w^{(M)}\) in lexicographic order. Given a matrix \(a=(a_{i,v})\) of tilt values at the distinct values \(v\) in \(B\), put

\[
 q_a(w)=\frac{\prod_{i=1}^r a_{i,w_i}}{\sum_{z\in\Omega(B)}\prod_{i=1}^r a_{i,z_i}},\qquad
 V_j(B)=\max_{1\le a_{i,v}\le\Gamma_i}\sum_{k\le j}q_a(w^{(k)}). \tag{2}
\]

**Theorem 1 (sharp ordered factor).** Conditional on the multiset, the observed factor \(V_{J}(B)\), where \(J\) is the rank of the observed word, is super-uniform for (1), and the conditional prefix probabilities in (2) are sharp over independent common-mean laws of the form (1) for each interior mean. The vector \(V_1,\ldots,V_M\) is the pointwise smallest conditionally super-uniform factor that is nondecreasing in lexicographic rank. No conditionally valid factor can reduce any one value while remaining no larger at every word, even if the competing factor need not be monotone. With independent common-mean laws but no tilt restriction, every conditionally valid deterministic factor equals one.

To obtain the interval, let \(K_n(z)=\Pr\{\sum_i(z_i-1)E_i<E_0\}\) for independent mean-one exponentials. Ming et al., Definition 4.12 and Theorem 4.13, show that replacing its upper-orthant value by \(U/\prod_i z_i\) when \(\min_i z_i\ge1\), for an independent uniform \(U\), preserves its p-value validity for independent nonnegative inputs with means at most one. At \(\theta\in(0,1)\) apply this rule to \(z=x/\theta\) and to \(z=(1-x)/(1-\theta)\), using the single factor \(V_J(B)\) in both tests and for all \(\theta\). The respective composite nulls are that all position means are at most, or at least, \(\theta\). The rule is valid for these nulls within the likelihood model (1), even if the means are different under a one-sided null. With one-sided levels \(\alpha_L,\alpha_U\in(0,1/e)\), closed inversion gives an interval with coverage at least \(1-\alpha_L-\alpha_U\) at the common mean. It is contained in the original unmodified Gaffke interval. In what follows the validity comparison is among conditional substitutions for the independent uniform factor, not among all possible procedures for this mean problem.

### Conditional law and realizability

Relative to \(P^n\), the density is proportional to \(\prod_{i\le r} g_i(x_i)\). Under \(P^n\), conditional on the multiset, each distinct word has the same weight. This holds with atoms and for continuous laws, by symmetrizing a bounded function over the \(n!\) permutations. Multiplicity factors cancel, since every distinct word has the same number of labelled realizations. It follows that the regular conditional law in (1) has the form \(q_a\) almost surely.

Every matrix in the box defining (2) is realizable on the given multiset under laws with any prescribed common mean \(\mu\in(0,1)\). Choose two points \(a_0<\mu<b_0\) outside the multiset. Give the distinct multiset values small positive probabilities with total mass \(\epsilon\) in the reference law, and choose the two remaining probabilities positive so that \(P\) has mean \(\mu\). This is possible for all small enough \(\epsilon\), and \(P(a_0)(\mu-a_0)\) stays bounded below as \(\epsilon\) decreases. For row \(i\), take the specified values at the multiset points and temporarily set both outside values to \(d_i=(1+\Gamma_i)/2\). Its unnormalized mean error is

\[
 e_i=\sum_{v\in B\text{ distinct}} P(v)(v-\mu)(a_{i,v}-d_i).
\]

Replace the tilt at \(a_0\) by \(d_i-e_i/[P(a_0)(a_0-\mu)]\), keeping the other one equal to \(d_i\). Since \(|e_i|\le\epsilon(\Gamma_i-1)/2\), taking \(\epsilon<P(a_0)(\mu-a_0)\) keeps all tilts in the box and eliminates each error. Normalization then gives mean \(\mu\) in every position. For \(\Gamma_i=1\) the correction is zero. All given words have positive probability on the event that the multiset equals \(B\). This proves that (2) is the genuine supremum in the independent common-mean model, rather than an enlargement caused by discarding the moment constraint.

### Optimality and impossibility

Take \(V_0=0\). The sequence increases strictly, since all \(q_a(w)\) are positive and a maximizer for each prefix exists on the compact box. Also \(V_M=1\). If \(j\) is the last index with \(V_j\le u\), then \(\Pr(V_J\le u\mid B)\le V_j\le u\). For a competing nondecreasing sequence \(b_j\), the event \(b_J\le b_j\) contains the first \(j\) words. Its maximum allowed probability is at least \(V_j\), which requires \(b_j\ge V_j\). To show the stronger pointwise comparison, suppose instead that a possibly nonmonotone factor obeys \(b_i\le V_i\) for every \(i\), with \(b_j<V_j\) at some index. Let \(u=\max\{b_j,V_{j-1}\}<V_j\). All the first \(j\) words have \(b_i\le u\), violating conditional super-uniformity under a model attaining \(V_j\). This proves both optimality statements.

When no likelihood restriction is imposed, fix any word \(w\) and any \(\mu\in(0,1)\). In each position put a sufficiently small positive mass at its designated \(w_i\) and put its remaining mass at the two common outside points \(a_0,b_0\), adjusted to achieve mean \(\mu\). There is positive probability of observing \(B\), and conditional on that event the only possible word is \(w\). A factor below one at this word fails conditional super-uniformity. This argument applies to each word, including in multisets with ties. It does not rule out other mechanisms that do not seek an orbitwise conditionally super-uniform factor.

### Transfer to inversion

For fixed multiset, both scaled vectors have the same upper-orthant status and products for all its words. On that branch rejection is \(V_J\le\alpha\prod_i z_i\) and has conditional probability bounded by the corresponding independent-uniform probability. Off the branch the rule is unchanged. The validity of the externally randomized merger gives the unconditional inequalities. For fixed data, the factor does not vary with \(\theta\). Within the upper orthant the rule is coordinatewise nonincreasing, outside it the old symmetric base value is nonincreasing, and on entry the factor only lowers the old value. Thus the two acceptance sets close to intervals of the stated orientation. Since \(V_J\le1\), the resulting interval is contained in the base interval. For nonconstant data, the sample mean lies strictly between the extreme observations, so both endpoints use their unchanged branches there. The sum \(Y=\sum_i(x_i/\bar x-1)E_i\) has mean zero and continuous log-concave CDF \(F\); applying Jensen to \(\log F\) gives \(F(0)\ge e^{-1}\), since \(F(Y)\) is uniform. The analogous statement holds for the complementary data. Hence the closed interval is nonempty at the specified levels. Constant data have only one word and factor one, and the boundary cases are handled by interval closure. The finite-sample coverage now follows from the two one-sided bounds and a union bound.

## 2. Computing the sharp envelope, including ties

**Theorem 2 (fixed number of tilted positions).** Each \(V_J(B)\) in (2) is exactly computable in polynomial time for fixed \(r\), including on tied multisets. For rational budget constants and a given ordered list of multiset values, the arithmetic is rational with polynomial bit length; no numerical smooth optimization is needed. The degree of the polynomial is allowed to depend on \(r\).

A prefix probability is linear fractional in any one \(a_{i,v}\) with every other entry fixed. Its denominator is positive, so it is constant or monotone in that entry. Starting from a maximum, replace each entry by an endpoint without lowering the probability. It follows that only \(a_{i,v}\in\{1,\Gamma_i\}\) are needed. Their choices for each distinct value form a mask \(\beta\in\{0,1\}^r\). Directly enumerating the masks for every value can be exponential even at fixed \(r\). The following compression uses the lexicographic threshold.

Write the observed threshold word as \(w\). From its first \(r\) entries take the distinct cutoff values and sort them. Split the value line into their singletons and intervening open intervals, including the two external intervals. There are at most \(2r+1\) bins. For a mask assignment store only \(m_{b,\beta}\), the number of occurrences in the multiset whose value has bin \(b\) and mask \(\beta\), counting all multiplicities. Within a bin with distinct values of multiplicities \(c_1,\ldots,c_d\), attainability of a total vector \(m_{b,\cdot}\) is an integer-load dynamic program. Start at the zero vector, and for each \(c_j\) add it to exactly one of the \(2^r\) coordinates. All copies of one value receive the same mask. Each coordinate is at most \(n\), so there are at most \((n+1)^{2^r}\) states per bin. Candidate tables are products of the attainable per-bin tables. This gives a polynomial bound at fixed \(r\).

For a candidate table, count ordered selections in the first \(r\) positions as selections of distinct labelled copies. A choice of types \(((b_1,\beta_1),\ldots,(b_r,\beta_r))\) has weighted count

\[
 \prod_{b,\beta}(m_{b,\beta})_{k_{b,\beta}}
       \prod_{i=1}^r\Gamma_i^{(\beta_i)_i}, \tag{3}
\]

where \(k_{b,\beta}\) is the multiplicity of type \((b,\beta)\) in the choice, and \((m)_k=m(m-1)\cdots(m-k+1)\) is zero if \(k>m\). After the first \(r\) choices, all remaining labelled permutations have equal weight and their number is \((n-r)!\). For the denominator of (2) sum (3) over all choices, cancelling that common factor. For the numerator multiply each term by one or zero according as the first \(r\) values are lexicographically lower or higher than the threshold's prefix. Their bins suffice for this comparison because every threshold entry is a singleton bin. If all first \(r\) values equal the threshold prefix, multiply by the fraction of remaining distinct suffix words lexicographically no later than \(w_{r+1:n}\). This fraction depends only on the multiset remaining after removal of the fixed prefix, independent of the chosen labels and masks. With multiplicity counts \(c_v\), the number of distinct residual words is \(\big(\sum_v c_v\big)!/\prod_v c_v!\). Count the earlier words by scanning the suffix positions and for each smaller available value adding the number of completions after taking that value. The fraction of admissible labelled suffixes equals the fraction of distinct suffix words because the label multiplicities are constant within that residual multiset.

There are at most \(((2r+1)2^r)^r\) terms in (3) for each table. All products use at most \(r\) budget factors; the only large combinatorial integers, including factorials for the suffix and the state totals, have polynomial bit length. Maximizing the computed fraction over attainable tables proves the theorem. The result is an exact fixed-\(r\) polynomial-time algorithm, rather than an assertion of runtime uniform in \(r\). For \(r=0\) its output is the original rank divided by the number of words.

For one tilted position the answer simplifies. Let \(a,b,c\) be the fractions of multiset occurrences strictly below, equal to, and strictly above \(w_1\), and let \(q\) be the admitted suffix fraction when the first value is \(w_1\). Moving higher the weights of all values below, and lower the weights of all values above, improves the fraction. At the first value itself compare its two endpoints. Thus

\[
 V_J=\max_{t\in\{1,\Gamma_1\}}
       \frac{\Gamma_1 a+t b q}{\Gamma_1 a+t b+c}. \tag{4}
\]

## 3. Sharp worst-sample width

Let both tails use \(0<\alpha<1/e\) and write

\[
 H_\alpha(v)=\min\{1,(\alpha/v)^{1/n}\}-\alpha^{1/n},\qquad
 v_* = \frac{\prod_{i=1}^r\Gamma_i}
 {\displaystyle\sum_{S\subseteq\{1,\ldots,r\}}(n-|S|)!\prod_{i\in S}(\Gamma_i-1)}. \tag{5}
\]

**Theorem 3 (sharp absolute width gain).** The supremum of the reduction in length relative to the base Gaffke interval, over all ordered samples of length \(n\), is \(H_\alpha(v_*)\). It is approached by distinct values coalescing at any common level in \((0,1)\) and presented in increasing order. The width gain is never equal to that positive supremum.

For a fixed multiset, the minimum robust factor is its first-word factor. Its maximizing matrix gives weight \(\Gamma_i\) to the value in position \(i\) of that word, and weight one to every other value in row \(i\). Indeed, increasing the target value's weight increases the singleton probability, since the numerator scales and the denominator contains both scaling and nonscaling terms. Raising any nontarget entry only increases the denominator. The chosen numerator is \(\prod_i\Gamma_i\). Expand the denominator by multiplying the terms \(1+(\Gamma_i-1)1\{z_i=w^{(1)}_i\}\). For any subset \(S\), the number of distinct words matching these specified positions is at most \((n-|S|)!\). With distinct values it equals that factorial. Thus over all multisets the smallest first-word factor is exactly \(v_*\). All terms are nonnegative, so ties cannot lower it further. The minimizer of this factor exists as soon as the multiset is distinct, even though the width supremum is only approached.

For completeness, if \(m=\min_i x_i>0\) and \(P_x=\prod_i x_i\) has \(m^n/P_x>\alpha\), the lower endpoint of the base inversion is \((\alpha P_x)^{1/n}\). Its improved endpoint is \(\min\{m,(\alpha P_x/V_J)^{1/n}\}\). Otherwise the endpoint is unchanged. These claims follow by solving the product branch for candidate \(\theta\le m\); above \(m\) both tests coincide. The upper endpoint is the complement of the analogous lower endpoint for \(1-x\), with the same factor. Therefore both gains together are at most \(H_\alpha(V_J)(P_x^{1/n}+P_{1-x}^{1/n})\), which is at most \(H_\alpha(v_*)\) by monotonicity and the arithmetic–geometric mean inequality. For nonconstant data the arithmetic–geometric mean inequality is strict, and for constant data the factor is one and the gain is zero. In distinct near-constant data with smallest rank, \(V_J=v_*\), both upper-orthant endpoint branches are active and the minimum clipping levels converge to their corresponding geometric means. The two gains sum in the limit to \(H_\alpha(v_*)\). This establishes sharpness.

If one retains only the aggregate probability ratio bound \(\Gamma=\prod_i\Gamma_i\) and ignores the product law, the worst singleton probability on a distinct orbit is \(\Gamma/(n!-1+\Gamma)\). At \(n=4\), \(r=2\), and \(\Gamma_i=2\), this gives \(4/27\). Formula (5) instead yields \(4/(24+6+6+2)=2/19\). A conditional rule based only on the aggregate ratio is thus less able to exploit the observed order in this model. As in the original ordered method, this worst-sample statement concerns the data configurations maximizing width gain and does not promise an asymptotic improvement at a fixed law.

## 4. An exact-computation boundary for known weights

**Theorem 4 (unrestricted number of prescribed tilts).** Given an increasing tie-free multiset and rational per-position likelihood tilt values in \([1,2]\), computing the conditional probability of just the first lexicographic word exactly is #P-hard under polynomial-time Turing reductions. This holds for weights realizable by independent bounded observations with common mean \(1/2\) and with a common reference distribution having that mean. It is a claim about prescribed weights, not about maximizing over the unknown-weight boxes in §2.

For a prescribed matrix \(W=(w_{ij})\), the increasing word has conditional mass

\[
 p_1(W)=\frac{\prod_i w_{ii}}{\operatorname{per}(W)},\qquad
 \operatorname{per}(W)=\sum_{\sigma\in S_n}\prod_i w_{i,\sigma(i)}.
\]

To reduce the 0–1 permanent of a matrix \(C\), set \(W(t)=\mathbf 1+tC\) for \(0\le t\le1\), where \(\mathbf1\) is the all-ones matrix. At each \(t=j/n\), \(0\le j\le n\), query the first-word probability and divide the known positive diagonal product by the answer. This returns the permanent at those points. The degree of \(\operatorname{per}(W(t))\) is at most \(n\), and its degree-\(n\) coefficient is \(\operatorname{per}(C)\). It can be recovered by polynomial interpolation, or by multiplying the \(n\)-th forward difference at zero at spacing \(1/n\) by \(n^n/n!\). Every weight is a rational with denominator at most \(n\), and the oracle returns a ratio with polynomial bit length since the permanent has at most \(n!\) products of \(n\) terms. The interpolated integer is therefore obtained by polynomial-time rational arithmetic with \(n+1\) oracle calls. Valiant's theorem for 0–1 matrices completes the reduction.

For the realizability promise, choose the same multiset \((x_j)_{j=1}^n\) with \(x_j=j/(n+1)\) in all queries. Let \(P(x_j)=\epsilon/n\) with \(\epsilon=1/100\), and \(P(0)=P(1)=(1-\epsilon)/2\). It has mean \(1/2\). Start the two outside tilt values at \(3/2\) and use the given \(w_{ij}\) at the multiset points. The resulting unnormalized mean deviation in row \(i\) is

\[
 e_i=\frac{\epsilon}{n}\sum_j (x_j-1/2)(w_{ij}-3/2),\qquad |e_i|\le\epsilon/4 .
\]

Replace the tilt at zero by \(3/2+2e_i/P(0)\). The mean deviation cancels, and this update changes the tilt by at most \(\epsilon/(1-\epsilon)<1/2\). Hence it stays in \([1,2]\). Row normalizations do not affect the conditional probability. All probabilities, support points and normalized distributions have polynomial rational bit length, and the conditioned multiset event has positive probability. This proves the stated hardness in the same-mean sampling model.

Computing positive-matrix permanents by interpolation from a zero-one instance is a standard transfer of Valiant's hardness. The scope here is its consequence for exact observed-order calibration with common-mean data, including the factor-two bound. It does not imply hardness of the robust box maximization. In fact the first-word robust maximum with unknown weights is explicit in Theorem 3, even when every position is tilted. [Valiant, Theorem 1](https://doi.org/10.1016/0304-3975(79)90044-6)

Barvinok §1, p. 2 uses the same interpolation principle to note exact hardness even for Hermitian positive-definite matrices with eigenvalues in [1,2]. His bounded eigenvalues are different from a rowwise bound on positive entries. Tibshirani–Barber–Candès–Ramdas, Lemma 3, already write the sum of product weights for weighted exchangeability. The statistical addition here is the restricted-model realization with rational bounded likelihood tilts, not a new permanent hardness method. [Barvinok](https://par.nsf.gov/servlets/purl/10225409) · [Tibshirani et al.](https://proceedings.neurips.cc/paper/2019/file/8fb21ee7a2207526da55a679f0332de2-Paper.pdf)

## 5. The unweighted ordered sample

The ordered IID rule is the case \(r=0\). It is useful to keep its additional conditional-average result. Write \(N=n!\). When the observed multiset has \(M\) distinct words, its factor is uniform on \(\{j/M:1\le j\le M\}\) conditional on that multiset. Its largest possible expected reduction in interval length, taking the expectation only over the uniformly random order of a fixed multiset and then the supremum over multisets, is

\[
 \frac1N\sum_{j=1}^{N}H_\alpha(j/N). \tag{6}
\]

Indeed the two geometric means in the pointwise width bound in §3 sum to at most one. The uniform \(M\)-point grid is stochastically larger than the uniform \(N\)-point grid because \(M\) divides \(N\) and its distribution function at \(u\) is \(\lfloor Mu\rfloor/M\). The function \(H_\alpha\) is nonincreasing. This proves the upper bound even with ties. On distinct values approaching any common interior level, the endpoint proof of Theorem 3 converges for every rank \(j\) to \(H_\alpha(j/N)\), so their average gives (6). The positive supremum is not attained because the geometric-mean inequality is strict at any nonconstant sample and constant samples have no gain. At \(r=0\), Theorem 3 gives the earlier sharp absolute width reduction \(H_\alpha(1/N)\). These sharpness statements concern two different extrema over samples and orders.

Under a fixed IID law, for any fixed pair of side levels the two refined endpoints agree with the base endpoints eventually almost surely. The constant law has no gain. For a nonconstant law select \(0\le a<b\le1\) with positive probability below or at \(a\) and above or at \(b\). Almost surely the sample minimum \(m\) is eventually at most \(a\) and a fixed positive fraction of observations are at least \(b\). If \(m=0\) the lower endpoint is unchanged. Otherwise the ratio \(m^n/\prod x_i=\prod (m/x_i)\) is at most \((a/b)^{cn}\) for some \(c>0\). It therefore falls below the fixed level and deactivates the branch where the lower endpoint changes. The same argument for \(1-X_i\) gives the upper endpoint. This is the existing fixed-law IID asymptotic conclusion. The heterogeneous width bound in §3 also describes a worst sample, without requiring any limiting sequence of data-generating laws.

## 6. Prior work and reproduction

Korn introduced data-randomized intervals in discrete models. Thulin §3.1 on pp. 7–8 explicitly assigns \(k/M\) to the distinct original-order permutations and uses the assigned value in place of external uniform randomness. This is the rank mechanism in the old ordered Gaffke manuscript. Ming et al., Definition 4.12, Theorem 4.13 and §4.4, give the randomized upper-orthant merger and the higher-dimensional inversion question. Their independent-input merger supplies the validity transfer here. The independent laws, exact order-specific envelope, common-mean realizability, grouped fixed-\(r\) computation and sharp heterogeneous width bound are the results of this continuation. [Korn](https://doi.org/10.1080/03610928708829397) · [Thulin](https://arxiv.org/pdf/1402.6536) · [Ming et al.](https://arxiv.org/pdf/2607.18661v1) · Earlier ordered Gaffke manuscript

Tibshirani, Barber, Candès and Ramdas, NeurIPS 2019, Definition 1 and Lemmas 2–3, use weighted exchangeability and the same conditional product-permutation law for known weights. The weighted quantile there targets a particular point's prediction score. Equation (2) begins with this established product law and optimizes its full order prefix over unknown weights, subject to known marginal bounds. The authors' later testing formulation uses a permutation null of exact exchangeability and Neyman–Pearson optimality for prediction regions. Its conditional statements do not supply the unknown-weight mean interval here. [Weighted exchangeability](https://proceedings.neurips.cc/paper/2019/file/8fb21ee7a2207526da55a679f0332de2-Paper.pdf) · [Conformal testing, arXiv:2608.27310](https://arxiv.org/abs/2608.27310)

Rosenbaum's sensitivity model and Gastwirth–Krieger–Rosenbaum §2 optimize permutation-tail probabilities under bounded hidden assignment bias in matched studies. Rosenbaum–Krieger likewise treat two-group assignment for rank, survival and categorical statistics. This literature supplies the closely related worst-case tail principle. The application and constraint structure here consist of independent common-mean measurements, slot- and value-specific density tilts, an observed ordered multiset and a fixed prefix of affected positions. The tangible additions beyond the tail principle are exact same-mean attainability of all finite tilt arrays, compression of the unknown-weight lexicographic event into attainable integer mask counts including ties, and the factorial width formula after Gaffke inversion. [Rosenbaum 1987](https://doi.org/10.1093/biomet/74.1.13) · [Rosenbaum–Krieger 1990](https://doi.org/10.1080/01621459.1990.10476226) · [Gastwirth–Krieger–Rosenbaum, author PDF](https://faculty.wharton.upenn.edu/wp-content/uploads/2012/04/Asymptotic.pdf)

A closer unknown-weight comparison is Jin, Ren and Candès, *Sensitivity analysis of individual treatment effects*, v2 Equation (8), Algorithms 1–2 and §4.3.1 Proposition 4.2. They optimize a score CDF for one shifted target draw under lower and upper likelihood bounds, including the threshold form of the worst weights and sharpness of their predictive procedure. The one-tilt expression (4) is an orbit analogue of that known fractional threshold mechanism. Here the exact target is a conditional lexicographic tail for several independently tilted measurement slots with a common mean. The means must be preserved in attaining the multivariate product envelope. The mask-count computation for known affected slots and the factorial interval-width comparison use that product structure. [Jin–Ren–Candès, PNAS 120, e2214889120](https://doi.org/10.1073/pnas.2214889120) · [Author text](https://arxiv.org/pdf/2111.12161v2)

The companion result on two observations derives exact simultaneous noncoverage for the symmetric admissible bivariate interval without recording a permutation or restricting the likelihood tilts. Its rejection boundaries do not supply conditional rank factors for the present model. Exact calibration of the bivariate intervals

Run `python3 -B evidence/code/verify_exact.py` from this paper directory. It uses only integer and rational arithmetic, comparing the compressed computation against direct vertex-and-word enumeration on tied and distinct multisets for several tilt vectors. It also checks the exact same-mean completion and the aggregate-ratio comparison. These checks illustrate the general written results. [Envelope program](evidence/code/verify_exact.py) · [Envelope output](evidence/results/envelope.txt)

Run `python3 -B evidence/code/verify_permanent_boundary.py` from the paper directory to check Theorem 4 on all 512 binary matrices of size three and 64 size-four matrices, with 7,424 exact bounded-tilt rows preserving the mean. [Known-weight program](evidence/code/verify_permanent_boundary.py) · [Known-weight output](evidence/results/known-weights.txt)
