---
title: "Minimal negative-association failures of swap rounding"
lang: en
geometry: margin=1in
---

# Abstract

Swap rounding always gives negatively correlated pairs of inclusion indicators. We determine the smallest ground set on which the stronger property of one-negative association can fail. Five elements suffice with three bases in the rank-two uniform matroid. Four elements never suffice, for any matroid or legal adaptive exchange rule. If only two bases are permitted, the minimum increases to six, and failure requires an outcome-dependent exchange rule in the uniform model. For three ordered bases in any rank-two matroid, the largest possible covariance between a singleton indicator and a nondecreasing test valued in \([0,1]\) is exactly the product of the three input weights. An exact polynomial certificate proves the upper bound. A coloring criterion gives each three-basis uniform rank-two input a lexicographic order under which it satisfies one-negative association.

# 1. Model and results

For matroid bases \(B_1,\ldots,B_m\) with positive weights summing to one, standard sequential swap rounding merges the bases in the given order. In a merge of bases \(L,R\) with current weights \(u,v>0\), a legal exchange chooses \(i\in L\setminus R\), \(j\in R\setminus L\) such that both \(L-i+j\) and \(R-j+i\) are bases. A fresh coin replaces \(R\) by \(R-j+i\) with probability \(u/(u+v)\), otherwise it replaces \(L\) by \(L-i+j\). The merge repeats until the two bases coincide and assigns their common value weight \(u+v\). A legal adaptive rule can choose exchanges using all preceding observations and auxiliary randomness independent of future exchange coins. The lexicographic rule in a uniform matroid always pairs the least remaining elements of the two differences under one fixed ground-set order.

Let \(X_i\) be the indicator that the final basis contains \(i\). The law is **one-negatively associated** if \(\operatorname{Cov}(X_i,f(X_{\setminus i}))\le0\) for every \(i\) and every coordinatewise nondecreasing \(f\). This is equivalent to using any nondecreasing function of \(X_i\) in the covariance, since \(X_i\) is binary.

**Theorem 1.** The minimum ground-set size for failure of one-negative association is five, for all matroids and all legal adaptive rules. It is attained by the lexicographic rule in \(U_{2,5}\) with three input bases. Among inputs with only two bases the minimum ground-set size is six, attained by an adaptive rule in \(U_{3,6}\). For two bases in a uniform matroid and a fixed lexicographic rule, failure is impossible at every ground-set size.

**Theorem 2.** Fix the three weights \(a,b,c>0\) with \(a+b+c=1\). For every rank-two matroid, every three-base input and every legal adaptive rule,
\[
 \operatorname{Cov}(X_i,f(X_{\setminus i}))\le abc
\]
for every coordinatewise nondecreasing \(f\) valued in \([0,1]\). The five-element instance in Theorem 1 attains equality for every weight triple. In particular the largest possible covariance with arbitrary three weights is \(1/27\).

Theorem 1 has a direct probabilistic proof. Theorem 2 uses a finite integer coefficient certificate over all ordered triples of two-element bases on six labels, with an explicit enumeration in Section 4 and an executable reproduction.

# 2. The ground-set threshold

The weighted fractional vector of the current bases is a martingale through each elementary exchange. If their differing coordinates are \(i,j\), the update adds \(\Delta\) to coordinate \(i\) and \(-\Delta\) to coordinate \(j\). The two values of \(\Delta\) are \(v\) and \(-u\), with conditional probabilities \(u/(u+v)\) and \(v/(u+v)\). If a fixed coordinate pair consists of these two coordinates, the product of its fractional coordinates has conditional increment with mean \(-\mathbb E[\Delta^2]\). If the fixed pair contains at most one of the changed coordinates, its product has mean increment zero. The resulting products are supermartingales through the finitely many updates. At the end the coordinates are the inclusion indicators. Thus the marginals equal the input fractional vector and every distinct pair has nonpositive covariance. This proof allows adaptive exchange choices.

For an indicator \(X_i\) with \(0<\mathbb P(X_i=1)<1\), the sign of its covariance with a test is the sign of the conditional test mean given \(X_i=1\) minus that given \(X_i=0\). It suffices to compare probabilities of increasing events, by decomposing a finite-valued nondecreasing test into a constant and positive multiples of indicators of its upper level sets.

A law on fixed-size subsets of a ground set of size at most four with nonpositive pairwise covariances is one-negatively associated. Ranks zero and one satisfy this immediately: if a singleton is present in rank one, all other indicators are zero. Taking all bit complements preserves one-negative association, since \(1-f(1-Y_{\setminus i})\) is a nondecreasing test on the complemented bits \(Y\) and both factors in the covariance have changed sign. This covers ranks of corank zero or one. The remaining case is rank two on four labels. Conditional on \(X_i=1\), the other indicators form a singleton among the three other labels. Conditional on \(X_i=0\), they form a pair. For an increasing event \(\mathcal U\), let \(S\) be the other labels whose singleton lies in \(\mathcal U\). When \(S\) is empty the conditional probability at \(X_i=1\) is zero. When \(S=\{j\}\), the probability at \(X_i=1\) is the conditional inclusion probability of \(j\), and the probability at \(X_i=0\) is at least its conditional inclusion probability, which is higher by pairwise nonpositive covariance. When \(|S|\ge2\), every pair intersects \(S\), so \(\mathcal U\) has probability one given \(X_i=0\). This proves the obstruction on four elements and also rules out all rank-one or corank-one counterexamples regardless of size.

On \(U_{2,5}\), use labels \(1<2<3<4<5\) and bases \(12,23,45\) with weights \(a,b,c\), where \(ij\) denotes a pair. Put \(s=a+b\). The first merge chooses \(12\) with probability \(a/s\) and \(23\) with probability \(b/s\). After \(12\), the second merge pairs \((1,4),(2,5)\). The event \(F=X_2\lor X_5\) then always occurs, and the chance to include label 1 is \(s\). After \(23\), the second merge pairs \((2,4),(3,5)\). Label 1 cannot occur, and \(F=0\) exactly when labels 4 and 3 win, with conditional probability \(cs\). Consequently,
\[
 \mathbb P(X_1=1)=a,\qquad \mathbb P(F=0)=bc,\qquad
 \mathbb P(X_1=1,F=0)=0.
\]
This gives \(\operatorname{Cov}(X_1,F)=abc>0\), proving the five-element threshold and the lower bound in Theorem 2. Complementing every input gives bases \(345,145,123\) in \(U_{3,5}\). Complementation swaps the sorted difference lists and preserves their matching, so their lexicographic output indicators are distributed as \(Y_i=1-X_i\). The complemented test \(1-F\) is the conjunction \(Y_2Y_5\), with \(\operatorname{Cov}(Y_1,Y_2Y_5)=abc\). Thus the five-element threshold also holds when the test is required to be a conjunction.

# 3. The role of two input bases and of the exchange rule

In any one merge, a selected exchange pair is removed from the two differences. Its winner becomes common, and the other common elements are unchanged. If the two initial differences have size at most two, a first exchange choice fixes the entire matching of differences. The remaining exchange, when present, is forced. All pairs then choose independently between their left and right elements with probabilities \(u/(u+v)\) and \(v/(u+v)\). For any fixed such matching, conditioning on one included singleton rules out its partner, with all other pair choices unchanged. This gives one-negative association. A mixture over first exchange choices preserves it: the marginal of a tested singleton is identical for every matching, so its covariance with a test is the mean of the conditional covariances. On at most five elements the differences of two equal-size subsets are disjoint and both have size at most two. Thus the two-base threshold is at least six.

For two bases \(123\) and \(456\) in \(U_{3,6}\), with weights \(p,1-p\), exchange \((1,4)\) first. If 1 wins, use \((2,6),(3,5)\) next. If 4 wins, use \((2,5),(3,6)\) next. The event \(X_2X_5=1\) is possible only when 1 wins. In that branch its conditional probability is \(p(1-p)\). Hence its covariance with \(X_1\) is \(p^2(1-p)^2>0\). Every exchange is legal, and the rule chooses its later matching using only the first outcome. In contrast, in any uniform matroid the lexicographic merge of two bases simply matches the sorted initial differences. Each exchange deletes the two least remaining members regardless of the coin result. Thus all fixed lexicographic two-base merges satisfy the same independent-pair argument.

There is also a way to choose a favorable lexicographic order for uniform rank two. Form a graph whose edges are the input bases. If it is bipartite, put all labels of one color before the other color in the lexicographic order. Every basis consists of one label of each color, and every merge pairs labels of equal color in its differences. With separate coins per color per merge, final labels of the two colors are independent categorical choices, each with distribution equal to the input weights aggregated at its slot. Conditioning on one included singleton makes every other indicator of its color zero and leaves the other slot unchanged, which proves one-negative association. In a list of at most three input bases, a nonbipartite support graph must consist of the three edges of a triangle. All outputs on that input are two-element subsets of those three labels and are already one-negatively associated by the corank-one observation. Thus every three-base input in a uniform rank-two matroid has a lexicographic order that achieves one-negative association.

# 4. The coefficient bound for three rank-two bases

## Reduction and numerator

A test valued in \([0,1]\) is a mixture of indicators of its increasing upper level sets, using its layer-cake representation. Fix such an increasing event \(\mathcal U\) on the coordinates other than \(i\). On the support given \(X_i=1\), it admits a set \(S\) of singleton labels. On the support given \(X_i=0\), it admits at least all pairs meeting \(S\). Replacing \(\mathcal U\) by \(F_S=\mathbf 1\{\text{output meets }S\}\) leaves its conditional mean at \(X_i=1\) unchanged and can only lower its mean at \(X_i=0\). It therefore suffices to bound the covariance with \(F_S\). Tests with \(|S|\le1\) have nonpositive covariance by pairwise nonpositive correlation. There are at most six labels in the union of the three input bases, and swaps never use any other labels. We can pad to six labels if needed. For \(|S|\ge4\) every pair of the five other labels meets \(S\), and the covariance is nonpositive. The two remaining cases can be relabeled with \(i=0\) and \(S=\{1,2\}\) or \(S=\{1,2,3\}\).

Every legal exchange on a rank-two matroid can be made on the uniform matroid on those six labels. It is enough to cover all rules in that uniform matroid. In a rank-two merge, the initial pair choice fixes the matching, with one or zero pairs left after that first choice. On a fixed matching every intermediate basis is reached by a unique sequence of coin outcomes. Thus a deterministic adaptive rule for two successive merges consists of an initial matching and, for every intermediate basis it can reach, one matching with the third basis. If a rule uses auxiliary randomness, fix its seed and then average; the singleton marginal is the same for every fixed seed by the exchange martingale.

For the arithmetic certificate allow \(a,b,c\) to be unnormalized and write \(s=a+b\), \(w=a+b+c\). Scale the algorithm's weights by \(w\) when interpreting them as probabilities of choosing an input label. Write
\[
 P_i=a\mathbf 1_{\{i\in B_1\}}+b\mathbf 1_{\{i\in B_2\}}
       +c\mathbf 1_{\{i\in B_3\}} .
\]
Thus the final singleton marginal is \(P_i/w\). Suppose a first matching uses \(k\le2\) pairs and a branch chooses its left member \(\ell\) times and right member \(r\) times, where \(k=\ell+r\). The branch probability is \(a^\ell b^r/s^k\). Suppose the second matching uses \(j\le2\) pairs and produces basis \(J\) using \(L\) left wins and \(R\) right wins, so \(j=L+R\). The conditional branch probability is \(s^Lc^R/w^j\). Since \(\operatorname{Cov}(X_i,F_S)=(P_i/w)\mathbb P(F_S=0)-\mathbb P(X_i=1,F_S=0)\), the contribution of this path to \(s^2w^3\operatorname{Cov}(X_i,F_S)\) is zero if \(J\) meets \(S\), and otherwise is the homogeneous polynomial
\[
 a^\ell b^r s^{2-k+L}c^R w^{2-j}
       \bigl(P_i-w\mathbf 1_{\{i\in J\}}\bigr).                           \tag{1}
\]
Every exponent in (1) is nonnegative. The bound to verify in these variables is coefficientwise domination of the sum of (1) by \(abc(a+b)^2\).

## Exhaustive coefficient certificate

For a \(k\)-pair merge, enumerate the permutations of the sorted right difference and pair each with the sorted left difference. The common elements enter every output. For every resulting matching, enumerate its \(2^k\) binary choice vectors, recording the output and its left and right win counts. The following recurrence produces an upper envelope separately for each degree-five monomial. The maximum and addition in this pseudocode are componentwise on vectors of integer coefficients.

~~~text
for S in ({1,2}, {1,2,3}):
    for (B1,B2,B3) in all ordered triples of pairs from {0,1,2,3,4,5}:
        for first_matching in matchings(B1,B2):
            value = 0
            for (middle, ell, r) in outcomes(first_matching):
                choices = []
                for second_matching in matchings(middle,B3):
                    polynomial = 0
                    for (J,L,R) in outcomes(second_matching):
                        if J is disjoint from S:
                            polynomial += expand(1) for this path
                    choices.append(polynomial)
                value += componentwise_max(choices)
            update_envelope(S, size_of_first_matching, value)
~~~

Here \(\mathrm{expand}(1)\) means coefficient expansion of equation (1), using repeated multiplication by \(s=a+b\) and \(w=a+b+c\). For a fixed monomial the second matchings are chosen independently at distinct first outcomes, so summing their maxima considers every adaptive policy. Maximizing over first matchings and input triples then gives the displayed envelopes. There are fifteen possible input bases. For each event size the numbers of first matching cases at \(k=0,1,2\) are \(225,1800,2700\), respectively. The entries in the next table are the only potentially nonzero coordinates among the 21 degree-five monomials. Every omitted coefficient has maximum zero. The included exact integer verifier evaluates the recurrence and checks each coordinate.

| Test size | \(k\) | \(ab^3c\) | \(a^2b^2c\) | \(a^3bc\) |
|:---:|:---:|:---:|:---:|:---:|
| 2 | 0 | 0 | 0 | 0 |
| 2 | 1 | 1 | 2 | 1 |
| 2 | 2 | 1 | 1 | 1 |
| 3 | 0 | 0 | 0 | 0 |
| 3 | 1 | 1 | 2 | 1 |
| 3 | 2 | 1 | 2 | 1 |

Each envelope is at most the coefficient vector of \(abc(a+b)^2\). Since all weights are positive, evaluating the polynomials and dividing by \(s^2w^3\) gives the bound \(abc/w^3\) for either \(F_S\), and thus for every normalized nondecreasing test. Returning to \(w=1\) proves Theorem 2. Its final value \(1/27\) follows by maximizing \(abc\) over the simplex, attained at equal weights.

# 5. Pinned comparison

The pinned lexicographic counterexample uses three bases in \(U_{3,6}\) and obtains positive covariance with a conjunction. It leaves the minimum ground-set size and other exchange rules open. The present result lowers the size and rank of the example, proves both exact size thresholds, and computes the sharp magnitude for any rank-two three-base rule. The favorable-order result explains how the same input may satisfy one-negative association under a different lexicographic order. The comparison is to the pinned repository manuscript.
