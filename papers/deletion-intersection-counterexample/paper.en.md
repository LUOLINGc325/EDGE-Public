# Finite counterexamples to an exact deletion-ball intersection conjecture

*Conjecture 1 of arXiv:2601.06503v2*

AI-assisted research manuscript

24 November 2026

## Abstract

Conjecture 1 of Wang, Fang, Li and Fu, arXiv:2601.06503v2, asserts an explicit expression $M(n,t)$ for the binary deletion-channel reconstruction parameter $N(n,3,t)$ whenever $t\geq5$ and $n\geq t+8$. We give two finite counterexamples within this revised domain. The binary words

$$
x=0101010100110,\qquad y=1001101010101
$$

have deletion distance three and $155$ distinct common outputs after exactly five deletions, whereas $M(13,5)=154$. Consequently $N(13,3,5)\geq155>154$, disproving the universal conjecture. A second witness, at $n=15,t=5$, satisfies the strict length inequality $n>t+8$ and has an intersection of size $324$, exceeding the conjectured value $322$. The proof is an exact finite calculation supported by independent integer computations, explicit output embeddings and a Lean formalization. We do not claim that either witness attains the global maximum or propose a replacement formula for general parameters. The literature assessment records inaccessible sources. This research manuscript has not undergone external peer review.

## 1. The precise question

In a deletion channel, surviving symbols retain their order but their original positions are lost. The overlap between the output sets of two candidate inputs controls how many distinct observations those inputs can share. We use the fixed-output-length definitions in Section II of [1].

For a binary word $x$ of length $n$ and $0\leq t\leq n$, let

$$
D_t(x)=\{w\in\{0,1\}^{n-t}:w\text{ is a subsequence of }x\}.
$$

The elements are distinct output words. Multiple choices of deleted positions producing the same word contribute only once. Deletion counts outside the valid range give the empty set. For equal-length words, the source defines

$$
d_L(x,y)=\min\{s\geq0:D_s(x)\cap D_s(y)\ne\varnothing\}.
$$

This is the distance convention used throughout. The extremal parameter is

$$
N(n,d,t)=\max_{\substack{x,y\in\{0,1\}^{n}\\d_L(x,y)\geq d}}
|D_t(x)\cap D_t(y)|.
$$

Write the source's single-ball expression, including its endpoint and invalid-argument conventions, as

$$
D(a,b)=
\begin{cases}
\displaystyle\sum_{i=0}^{b}\binom{a-b}{i},&0\leq b\leq a,\\
0,&\text{otherwise},
\end{cases}
\qquad a,b\in\mathbb Z.
$$

Valid endpoints represent the unique original word or empty word. Negative arguments must be rejected before any conversion to natural numbers. Define

$$
\begin{aligned}
M(n,t)={}&6D(n-6,t-3)+4D(n-8,t-3)+6D(n-9,t-3)\\
&+4D(n-11,t-3)+2D(n-13,t-5)+D(n-13,t-6).
\end{aligned}
$$

**Source conjecture [1, Conjecture 1].** For all integers $t\geq5$ and $n\geq t+8$, one has $N(n,3,t)=M(n,t)$.

Our target is this exact universal assertion. Previously established asymptotics, the source's proved four-deletion result, and deletion-channel capacity are outside the scope of the question answered here. The contribution consists of two explicit admissible pairs whose intersection sizes strictly exceed the proposed expression, with independently reproducible certificates.

## 2. Main theorem and finite certificate

**Theorem 1.** Let

$$
x=0101010100110,\qquad y=1001101010101.
$$

Both words have length $13$, and

$$
d_L(x,y)=3,\qquad |D_5(x)\cap D_5(y)|=155,\qquad M(13,5)=154.
$$

It follows that

$$
N(13,3,5)\geq155>154=M(13,5).
$$

In particular, Conjecture 1 of [1] is false.

### 2.1 Distance and distinct output counts

The proof of Theorem 1 uses the following finite-set counts.

| Deletions $s$ | Output length $13-s$ | $\lvert D_s(x)\cap D_s(y)\rvert$ |
|:---:|:---:|---:|
| 0 | 13 | 0 |
| 1 | 12 | 0 |
| 2 | 11 | 0 |
| 3 | 10 | 20 |
| 5 | 8 | 155 |

Each row counts words of a fixed length, rather than choices of deleted positions. The formalization enumerates the binary words of that length, filters by the standard subsequence relation and takes the cardinality of the resulting finite set. Its membership theorem establishes that the enumeration contains exactly all binary words of the prescribed length. Thus neither omitted candidates nor duplicate output counting can affect the result.

The reproducibility package offers two directly inspectable certificate constructions. One enumerates all combinations of retained positions, puts the resulting strings into sets and intersects the sets. The other enumerates every binary output word of a fixed length and tests whether it is a subsequence of each input. These methods compare complete output sets. The file `all_length8_membership.tsv` records all $256$ candidate outputs, and `common_length8.tsv` gives explicit embeddings in both inputs for each of the $155$ accepted words. The Python computations provide independent checks; the machine proof of the theorem is performed by Lean on the underlying subsequence relation.

The first three rows are empty and the $s=3$ row is nonempty. The minimum in the definition of $d_L$ is therefore exactly three. The final row gives the required $155$ common five-deletion outputs. Thus the pair satisfies the source's distance condition and attains the stated intersection size.

### 2.2 Evaluation of the proposed expression

At $n=13,t=5$, the six terms are as follows.

| Term | Value of $D$ | Weighted contribution |
|:---|---:|---:|
| $6D(7,2)$ | 16 | 96 |
| $4D(5,2)$ | 7 | 28 |
| $6D(4,2)$ | 4 | 24 |
| $4D(2,2)$ | 1 | 4 |
| $2D(0,0)$ | 1 | 2 |
| $D(0,-1)$ | 0 | 0 |

Hence $M(13,5)=96+28+24+4+2+0=154$. The last argument is the integer $t-6=-1$, so its term is zero. Saturating natural-number subtraction would incorrectly turn it into $D(0,0)$. The formalization computes these indices as integers and checks validity before evaluating the binomial sum.

### 2.3 The extremal conclusion

The exhibited pair belongs to the feasible set defining $N(13,3,5)$. The maximum is at least the value attained by this pair, so

$$
N(13,3,5)\geq|D_5(x)\cap D_5(y)|=155>154=M(13,5).
$$

The inequalities $5\geq5$ and $13\geq5+8$ place the parameters in the conjecture's stated domain. The strict inequality therefore disproves its universal equality. This proves the theorem. $\square$

### 2.4 A witness satisfying the strict length inequality

**Theorem 2.** Let

$$
u=010101010100110,\qquad v=100110101010101.
$$

Both words have length $15$ and satisfy

$$
d_L(u,v)=3,\qquad |D_5(u)\cap D_5(v)|=324,\qquad M(15,5)=322.
$$

Thus $N(15,3,5)\geq324>322=M(15,5)$. This witness satisfies the strict inequality $15>5+8$, placing it inside the conjectured length range.

**Proof.** For deletion counts $s=0,1,2,3,5$, the intersection cardinalities are respectively $0,0,0,20,324$. The same finite-set verification as in Theorem 1 establishes distance three and the size of the five-deletion intersection. The complete output list and embeddings are recorded in `n15_common_length10.tsv`; `n15_all_length10_membership.tsv` classifies all $1024$ candidate outputs. The six terms evaluate to

$$
\begin{aligned}
M(15,5)&=6D(9,2)+4D(7,2)+6D(6,2)+4D(4,2)\\
&\quad+2D(2,0)+D(2,-1)\\
&=6\cdot29+4\cdot16+6\cdot11+4\cdot4+2\cdot1+0\\
&=322.
\end{aligned}
$$

Using this feasible pair in the definition of the maximum proves the conclusion. $\square$

The two witnesses answer the same universal conjecture. The second establishes that strict excess is not confined to the boundary $n=t+8$. Only these two specified instances are proved; no infinite family is inferred from finite data.

## 3. Formal scope and reproduction

The formalization represents finite sets by duplicate-free lists and uses Lean's standard `List.Sublist` relation. Its scope includes the semantics of the binary-word enumeration, equivalence of the deletion-output sets with the source definition, the distance conditions and stated counts for both pairs, evaluation of $M$ with signed arguments, the lower bounds on the maxima and the negation of the universal conjecture. The Lean source and claim-by-claim coverage record are not included in this edition. The counting proofs are checked by the kernel; answers returned by external programs are not imported as axioms.

The project also includes a next-occurrence counting computation and an independently authored retained-position enumeration. These are cross-checking tools; no new algorithmic claim is made for these standard methods. Reproduction commands, the pinned toolchain, compilation output and a transitive axiom report for every declaration created in the module appear in `REPRODUCTION.md` and `formalization/`. The permitted logical basis is a subset of `propext`, `Classical.choice` and `Quot.sound`. The records distinguish the executed local kernel check, independent review and post-publication rebuild of the remotely fetched source.

## 4. Relation to prior work and limits

The target is the April 2026 revision of [1], which explicitly requires $n\geq t+8$. Both counterexamples satisfy the revised domain; they do not rely on the wider domain stated in the first version. It is consistent with the source's established lower bound: an attainable lower bound may be strictly below the maximum. The contradicted statement is the additional conjecture that this lower bound is always exact in the specified range.

The exact results of Gabrys and Yaakobi [2] concern distance threshold two. Pham, Goyal and Kiah [3] obtain asymptotic results for general parameters. The finite bounds and constrained asymptotic questions studied by Sun and Ge [4], and the nonbinary distance-two problem of Wang, Li and Fu [5], have different targets from the exact finite instances here. General counting and enumeration methods are prior tools; the result claimed here is limited to the two explicit counterexamples.

As of 24 November 2026, the material actually searched did not reveal the same counterexample or an equivalent refutation. Two concrete access limits remain: the six-page ISIT 2026 conference version of [1] was unavailable, and the complete 2025 journal extension of [3], including its small-parameter Table 1, was unavailable. The earlier arXiv text is not treated as a substitute for that table. The literature audit identifies the versions and portions actually read. This bounded search is not a proof of worldwide priority.

The universal conjecture is refuted, while two specific questions remain: the exact maxima at the two exhibited parameter values, and the parameter ranges on which a corrected exact formula can hold. We do not establish $N(13,3,5)=155$ or $N(15,3,5)=324$, an infinite counterexample family or a new asymptotic term.

## References

[1] X. Wang, W. Fang, H. Li, F.-W. Fu. *Some New Results on Sequence Reconstruction Problem for Deletion Channels*. arXiv:2601.06503v2, 15 April 2026. Section II and Conjecture 1 in Section V. <https://arxiv.org/html/2601.06503v2>.

[2] R. Gabrys, E. Yaakobi. *Sequence Reconstruction Over the Deletion Channel*. IEEE Transactions on Information Theory 64(4), 2924-2931, 2018. DOI: 10.1109/TIT.2018.2800044.

[3] V. L. P. Pham, K. Goyal, H. M. Kiah. *Sequence Reconstruction Problem for Deletion Channels: A Complete Asymptotic Solution*. arXiv:2111.04255v1; Journal of Combinatorial Theory, Series A 211, 105980, 2025. DOI: 10.1016/j.jcta.2024.105980. Early full text and journal metadata checked; journal full text unavailable.

[4] Y. Sun, G. Ge. *Extremal Deletion-Ball Intersections under Run-Count and Lower-Order Deletion-Ball Intersection Constraints*. arXiv:2606.25822v1, 2026.

[5] X. Wang, H. Li, F.-W. Fu. *On Sequence Reconstruction Problem for q-ary Deletion Channels*. arXiv:2609.16837v1, 2026. <https://arxiv.org/html/2609.16837v1>.
