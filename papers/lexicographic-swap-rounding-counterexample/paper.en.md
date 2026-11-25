# Lexicographic Swap Rounding Need Not Be 1-Negatively Associated

*An exact six-element counterexample and a positive-weight family*

AI-assisted research manuscript

24 November 2026

## Abstract

We give an explicit counterexample to 1-negative association for the standard matroid swap-rounding algorithm. In the uniform matroid $U_{3,6}$, take the ordered bases $123,124,356$ with arbitrary positive weights $a,b,c$ satisfying $a+b+c=1$. At every elementary exchange, choose the smallest element of each current basis difference. If $X_j$ indicates whether the final basis contains $j$, then

$$
\operatorname{Cov}(X_3,X_2X_5)=abc>0.
$$

Thus standard swap rounding does not universally guarantee 1-negative association, even with a fixed natural exchange rule. Equal weights give covariance $1/27$. The proof follows the two actual basis merges and gives the complete twelve-path execution tree and eleven-atom output law. It addresses the universal swap-rounding question raised in [1]; it does not rule out stronger guarantees for other exchange rules.

## 1. Question and scope

Swap rounding combines matroid bases to turn a fractional solution into a feasible random basis [2]. Duppala et al. ask whether swap rounding has the stronger property of 1-negative association [1].

A binary vector $X=(X_1,\ldots,X_n)$ is 1-negatively associated if, for every coordinate $i$, every coordinatewise nondecreasing function $f$ whose value does not depend on coordinate $i$, and every nondecreasing one-variable function $g$,

$$
\mathbb E[f(X)g(X_i)]\leq\mathbb E[f(X)]\mathbb E[g(X_i)].
$$

We disprove this inequality using $i=3$, $g(t)=t$, and $f(X)=X_2X_5$. The latter function is nondecreasing on the entire Boolean cube and ignores coordinate 3.

The claim being refuted is a universal guarantee for all legal inputs and legal exchange choices of the standard algorithm. One fully specified legal execution rule suffices. No claim is made that every exchange rule fails, that the same marginals admit no 1-negatively associated sampling distribution, or that the example has minimum possible size.

## 2. Algorithm and fixed input

Let $U_{3,6}$ have ground set $\{1,2,3,4,5,6\}$ and all three-element subsets as bases. Fix the ordered input

$$
B_1=\{1,2,3\},\qquad B_2=\{1,2,4\},\qquad B_3=\{3,5,6\},
$$

with $a,b,c>0$ and $a+b+c=1$. Its fractional vector is

$$
x=a\mathbf1_{B_1}+b\mathbf1_{B_2}+c\mathbf1_{B_3}
=(a+b,a+b,a+c,b,c,c).
$$

For bases $L,R$ of positive weights $u,v$, use the `MergeBases` procedure of [2, Section IV]. While the bases differ, set

$$
i=\min(L\setminus R),\qquad j=\min(R\setminus L).
$$

With probability $u/(u+v)$ replace $R$ by $R-j+i$; otherwise replace $L$ by $L-i+j$. Use a fresh independent coin at each exchange. Return the common basis. Both replacements are legal in the uniform matroid. Each exchange reduces the symmetric-difference size by two, so a merge uses at most three exchanges.

`SwapRound` first merges $B_1,B_2$ with weights $a,b$, then merges its result with $B_3$ with weights $a+b,c$. The basis order and the label order remain fixed throughout.

## 3. The parameterized counterexample

**Theorem 1.** For the input and deterministic rule of Section 2, let $X_j$ indicate membership of $j$ in the output. For every $a,b,c>0$ with $a+b+c=1$,

$$
\mathbb P(X_2X_5=1)=\mathbb P(X_2X_3X_5=1)=ac,
\qquad \mathbb P(X_3=1)=a+c.
$$

Consequently $\operatorname{Cov}(X_3,X_2X_5)=abc>0$, and the output is not 1-negatively associated.

**Proof.** Put $s=a+b=1-c>0$. The first merge exchanges only labels 3 and 4. Its output $C$ equals $123$ with probability $a/s$, and $124$ with probability $b/s$. Write $A=\{X_2=X_5=1\}$.

If $C=123$, the second merge has common element 3, left-only elements 1,2, and right-only elements 5,6. Its exchange pairs are $(1,5)$ and $(2,6)$. Whichever element of a pair wins, it becomes common to both bases, while both differences lose their respective member of the pair. Therefore the later pairing does not depend on the earlier coin. Each pair chooses its left element with probability $s$ and its right element with probability $c$.

The event $A$ occurs exactly when the first pair chooses 5 and the second chooses 2, with conditional probability $cs$. Element 3 remains present throughout this branch. Thus

$$
\mathbb P(A\mid C=123)
=\mathbb P(A\cap\{X_3=1\}\mid C=123)=cs.
$$

If $C=124$, the bases are disjoint and the exchange pairs are $(1,3),(2,5),(4,6)$. The event $A$ is impossible because 2 and 5 are mutually exclusive choices of one pair. Element 3 is selected with probability $c$ in this branch.

Combining the branches gives

$$
\mathbb P(A)=\mathbb P(A\cap\{X_3=1\})
=\frac a s\,cs=ac.
$$

The marginal of element 3 follows directly from the same tree:

$$
\mathbb P(X_3=1)=\frac a s+\frac b s c
=\frac{a+bc}{a+b}=a+c,
$$

where $(a+c)(a+b)=a(a+b+c)+bc=a+bc$. Hence

$$
\operatorname{Cov}(X_3,X_2X_5)
=ac-(a+c)ac=ac(1-a-c)=abc>0.
$$

The functions in Section 1 satisfy all requirements in the definition, completing the counterexample. $\square$

**Corollary 2.** The same family satisfies

$$
\mathbb P(A\mid X_3=0)=0,
\qquad
\mathbb P(A\mid X_3=1)=\frac{ac}{a+c}>0.
$$

**Proof.** The joint mass of $A$ with $X_3=0$ is zero by Theorem 1. The conditioning events have positive probabilities $b$ and $a+c$, respectively. Dividing the two joint masses by these probabilities proves the formulas. $\square$

## 4. Complete output law

Write $ijk$ for $\{i,j,k\}$. The first branch has four paths and the second has eight. Their sole common output is $356$, whose total mass is

$$
\frac{ac^2+bc^3}{s}=c^2(a+c).
$$

Multiplying the coin probabilities in Section 3 gives the complete law below, with $s=a+b$.

| Output basis | General probability | Equal weights |
|:---:|:---:|:---:|
| $123$ | $as$ | $6/27$ |
| $124$ | $bs^2$ | $4/27$ |
| $126$ | $bsc$ | $2/27$ |
| $136$ | $ac$ | $3/27$ |
| $145$ | $bsc$ | $2/27$ |
| $156$ | $bc^2$ | $1/27$ |
| $234$ | $bsc$ | $2/27$ |
| $235$ | $ac$ | $3/27$ |
| $236$ | $bc^2$ | $1/27$ |
| $345$ | $bc^2$ | $1/27$ |
| $356$ | $c^2(a+c)$ | $2/27$ |

Every other three-element subset has mass zero. The masses sum to one and give marginal vector $x$ from Section 2, as can also be checked by direct summation. For $a=b=c=1/3$, event $A$ is the single output $235$, and

$$
\mathbb E[X_3]=\frac23,\qquad
\mathbb E[X_2X_5]=\mathbb E[X_2X_3X_5]=\frac19,
\qquad \operatorname{Cov}(X_3,X_2X_5)=\frac1{27}.
$$

The conditional probabilities in Corollary 2 are then 0 and $1/6$. All reported numbers are exact.

## 5. Prior work and interpretation

The contribution is an explicit fixed-lexicographic execution of standard CVZ swap rounding that violates 1-negative association. The algorithm and its existing guarantees are due to [2]. The counterexample answers the universal swap-rounding question in [1]; it does not invalidate the established cylinder-dependence or objective-function guarantees.

Brown Kramer, Cutler and Radcliffe [3] already gave a seven-element SSP counterexample. The general possibility that a dependent rounding process can fail singleton-versus-event negative association is therefore not claimed as new. Our witness instead gives a three-basis input and a verified execution tree for CVZ `SwapRound`.

Qiu and Singla [4] studied weak negative regression and its separation from submodular dominance. An abstract separation between distribution classes does not by itself show that a specified implementation of an algorithm attains a separating distribution. The execution-level witness is the relevant distinction here.

The search completed on 24 November 2026 found no equivalent fixed-lexicographic CVZ counterexample in the inspected primary sources or repository catalogs. This is a scope-limited search conclusion, not a global-priority certification. Other exchange rules, other samplers with the same marginals, and minimum counterexample size remain outside this paper.

## 6. Reproduction and verification scope

Two independently written exact-arithmetic programs accompany the manuscript. The primary program mutates the two bases exactly as in the original algorithm and records every branch. The independent implementation replays the full coin tree using sets and cross-checks it against a product-of-coins construction. They verify exchange legality, total probability, the entire output law, all six marginals, and the violating event. The equal-weight instance and three unequal rational triples check the implementations; the proof of Theorem 1 supplies the continuous parameter range.

The original manuscript describes supporting Lean material. The source and build evidence are not included in this release, and no new compilation is asserted. Neither computation nor formalization certifies the completeness of a literature search.

This is an AI-assisted research manuscript without external human peer review.

## References

1. S. Duppala, G. Z. Li, J. Luque, A. Srinivasan and R. Valieva. *Concentration of Submodular Functions and Read-k Families Under Negative Dependence*. Algorithmica 88, Article 21 (2026). [doi:10.1007/s00453-026-01372-w](https://doi.org/10.1007/s00453-026-01372-w). Inspected: introduction, Definition 1 and Appendix A.2, in the journal full text.
2. C. Chekuri, J. Vondrák and R. Zenklusen. *Dependent Randomized Rounding via Exchange Properties of Combinatorial Structures*. FOCS 2010, pp. 575-584. [doi:10.1109/FOCS.2010.60](https://doi.org/10.1109/FOCS.2010.60). [Author PDF](https://chekuri.cs.illinois.edu/papers/swap-rounding-focs.pdf). Inspected: the two algorithms in Section IV and Section VI.
3. J. Brown Kramer, J. Cutler and A. J. Radcliffe. *Negative Dependence and Srinivasan's Sampling Process*. Author manuscript dated 25 January 2011. [Full text](https://josh.brownkramer.com/research/TSSP_rev.pdf). Inspected: Definition 3 and Example 1.
4. F. Qiu and S. Singla. *Submodular Dominance and Applications*. APPROX/RANDOM 2022, LIPIcs 245, 44:1-44:21. [doi:10.4230/LIPIcs.APPROX/RANDOM.2022.44](https://doi.org/10.4230/LIPIcs.APPROX/RANDOM.2022.44). [Inspected author preprint](https://arxiv.org/pdf/2207.04957). Inspected: Definition 1.2, Claim 2.3 and Section 3.
