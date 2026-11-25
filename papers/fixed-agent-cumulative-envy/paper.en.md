# Cumulative Envy Is Weakly NP-Complete for Every Fixed Number of Agents at Least Four

AI-assisted research draft

24 November 2026

## Abstract

We consider the irrevocable allocation of a prescribed sequence of goods to agents with identical additive valuations. The cost is the sum, over all prefixes, of the difference between the largest and smallest allocated values. For every fixed number of agents $n\ge4$, we prove that the decision problem is NP-complete, even when every good has a strictly positive integer value encoded in binary. The proof sharpens the soundness analysis of the two-sentinel construction of Goldberg, Robinson and Teh [1]. A terminal imbalance pays for every possible saving in the prefix: for the constructed instance, every allocation satisfies $C\ge MT+(M/n)R$, where $R$ is the range after the second sentinel. This permits a reduction from ordinary PARTITION with a linear number of goods, independently of the magnitudes of the input integers. A quantitative perturbation replaces zero-valued goods by unit-valued goods. Together with a standard pseudopolynomial dynamic program, the result establishes weak NP-completeness and answers the fixed-agent question in [1, Section 4] negatively unless $\mathsf P=\mathsf{NP}$. The cases $n=2,3$ are not classified here.

## 1. Problem and contribution

There are $n$ agents and $L$ indivisible goods with nonnegative integer values $v_1,\ldots,v_L$. Every agent has the same additive valuation. The order $1,\ldots,L$ is part of the input and is known in advance. At round $t$, good $t$ is assigned irrevocably to one agent. An allocation is a sequence $s=(s_1,\ldots,s_L)\in[n]^L$.

Let

$$
x_i(t)=\sum_{u\le t:\,s_u=i}v_u,
\qquad
r_t(s)=\max_{i\in[n]}x_i(t)-\min_{i\in[n]}x_i(t).
$$

Under identical valuations, $r_t$ is exactly the maximum pairwise envy at round $t$. Define

$$
C_v(s)=\sum_{t=1}^{L}r_t(s).
\tag{1}
$$

The decision version asks whether some allocation has $C_v(s)\le K$, where $K$ is a binary-encoded nonnegative integer. In this note, the number of agents is a fixed constant, not an input parameter that grows with the reduction.

**Theorem 1.** For every fixed integer $n\ge4$, the decision version of (1) is NP-complete under identical additive, strictly positive, binary-encoded integer valuations. It also admits a pseudopolynomial algorithm. Thus it is weakly NP-complete in the usual sense.

The prescribed-order problem with a constant agent count was explicitly left open in [1, Section 4]. The two large sentinel goods and the zero-valued suffix already occur in [1, Theorem 3.1]; that construction and its general strategy belong to those authors. Our contribution is a stronger soundness inequality that makes a reduction from PARTITION work with four agents, its extension to every fixed $n\ge4$, and a quantitative removal of all zero values. We make no novelty claim for the standard load-state dynamic program.

The theorem concerns exact optimization. It is compatible with the fixed-$n$ FPTAS in [1, Theorem 4.2]. It does not establish strong NP-hardness or constant-factor inapproximability, and it does not settle the prescribed-order cases $n=2,3$.

## 2. A quantitative two-sentinel lemma

The proof is most transparent when stated for an arbitrary equal-bin partition problem.

**Lemma 2.** Let $n\ge3$, let $T$ be a positive integer, and let $b_1,\ldots,b_k$ be positive integers with

$$
\sum_{j=1}^{k}b_j=(n-2)T.
$$

Put $M=k+1$ and form the sequence of $2M$ goods

$$
v=\bigl(T,b_1,\ldots,b_k,T,
\underbrace{0,\ldots,0}_{k\text{ goods}}\bigr).
\tag{2}
$$

For every allocation, let $R$ be the load range immediately after the second sentinel of value $T$, at round $M+1$. Then

$$
C_v(s)\ \ge\ MT+\frac{M}{n}R.
\tag{3}
$$

Consequently, an allocation with $C_v(s)\le MT$ exists if and only if the middle goods can be partitioned into $n-2$ bundles of value $T$ each. Whenever such a partition exists, the optimum is exactly $MT$.

**Proof.** Fix an arbitrary allocation. Let $j$ be the recipient of the second sentinel, and set $b=x_j(M)$, its load immediately before that sentinel. The letter $b$ denotes this load and is distinct from the indexed input values $b_1,\ldots,b_k$.

At each of the first $M$ rounds, the recipient of the first sentinel has load at least $T$. Nonnegative values also imply $x_j(t)\le b$ for every $t\le M$. Therefore

$$
r_t(s)\ge T-b\quad(t\le M),
\qquad
\sum_{t=1}^{M}r_t(s)\ge M(T-b).
\tag{4}
$$

This remains valid when $b>T$; no nonnegativity of the right-hand side is assumed.

After the second sentinel, the total load is $nT$ and agent $j$ has load $T+b$. The other $n-1$ agents have average load

$$
\frac{nT-(T+b)}{n-1}=T-\frac{b}{n-1}.
$$

At least one of them has load at most this average. Hence

$$
R\ge (T+b)-\left(T-\frac{b}{n-1}\right)
=\frac{n}{n-1}b,
\qquad
b\le\frac{n-1}{n}R.
\tag{5}
$$

The remaining $k$ goods have value zero. Thus the range is $R$ for exactly $k+1=M$ rounds, counting the second-sentinel round. Combining (4) and (5) gives

$$
\begin{aligned}
C_v(s)
&\ge M(T-b)+MR\\
&\ge MT+M\left(1-\frac{n-1}{n}\right)R
=MT+\frac{M}{n}R.
\end{aligned}
$$

If $C_v(s)\le MT$, (3) forces $R=0$. Every final load is then $T$. Each sentinel itself has value $T$, so the two sentinels belong to distinct agents, and neither agent receives any positive middle good. The remaining $n-2$ agents partition the middle goods into bundles of value $T$.

Conversely, suppose such a partition exists. Give the first sentinel to one agent, the partition bundles to $n-2$ other agents in the prescribed order, and the second sentinel to the last agent. During the first $M$ rounds, the first agent has value $T$, the last has value zero, and each middle agent has value in $[0,T]$. The range is exactly $T$ in every one of those rounds. At round $M+1$ all loads become $T$, after which the range stays zero. The cost is $MT$. This also proves optimality, by (3). $\square$

The role of (3) is quantitative. It does not rely on an unproved assertion that some agent stays empty, nor on a suffix whose length is proportional to $T$. The selected recipient of the second sentinel may have received arbitrary earlier goods. Its previous load $b$ simultaneously controls the possible prefix savings and the resulting terminal imbalance.

## 3. Hardness for a fixed number of agents

PARTITION asks whether positive integers $a_1,\ldots,a_m$ can be divided into two sets with equal sum. We use its classical NP-completeness [2]. We may restrict attention to instances of even total $2T$: doubling every input integer maps any PARTITION instance to an even-total instance and preserves its answer. This remains true for an original odd total, since the doubled instance then cannot have a subset summing to its odd half-total.

### 3.1 Four agents

Given $\sum_{i=1}^{m}a_i=2T$, use the sequence

$$
T,a_1,\ldots,a_m,T,\underbrace{0,\ldots,0}_{m\text{ goods}}
\tag{6}
$$

with four agents and threshold $K=(m+1)T$. Lemma 2, with $n=4$ and $k=m$, proves the equivalence with PARTITION. In particular, every allocation satisfies

$$
C_v(s)\ge(m+1)T+\frac{m+1}{4}R.
\tag{7}
$$

There are $2m+2$ goods. If the input integers have at most $B$ bits, then $T$ has $O(B+\log m)$ bits, and so does the threshold up to another $O(\log m)$ term. Neither the number of goods nor any repetition count depends on the numerical magnitude of $T$. The reduction is polynomial in the binary input length.

### 3.2 Every fixed $n\ge4$

Fix $n\ge4$ in advance. Append exactly $n-4$ goods of value $T$ to the list of middle goods. Thus

$$
(b_1,\ldots,b_k)
=(a_1,\ldots,a_m,\underbrace{T,\ldots,T}_{n-4}),
\qquad k=m+n-4.
\tag{8}
$$

Their total is $(n-2)T$. They admit an equal partition into $n-2$ bins precisely when the original $a_i$ admit an equal partition into two bins. Indeed, each appended $T$ must occupy an entire bin by itself, since every middle good is positive. Conversely, a two-bin partition can be supplemented with those singleton bins.

Apply Lemma 2 using

$$
M=k+1=m+n-3,\qquad K=MT.
\tag{9}
$$

There are $k$ trailing zero-valued goods, not the original $m$ when $n>4$. The sequence has $2k+2$ goods. Since $n$ is fixed, all construction and encoding bounds remain polynomial.

### 3.3 Membership in NP

A certificate lists one recipient for every good. Computing all prefix loads, their maxima and minima, and the accumulated cost uses a polynomial number of additions and comparisons. The loads have at most $O(\log(1+V))$ bits and the cost at most $O(\log(1+LV))$ bits, where $V=\sum_t v_t$. These bit lengths are polynomial in the input length. This proves NP-completeness for nonnegative integer values and every fixed $n\ge4$.

## 4. Removing every zero-valued good

The zeros in (2) are a proof device. They are not necessary for hardness.

**Lemma 3.** Fix any number of agents and any sequence $v$ whose last $k$ values are zero. Let $Q$ be a positive integer. Form $w$ by multiplying each preceding value by $Q$ and replacing every one of the last $k$ values by $1$. For every fixed recipient sequence $s$,

$$
\bigl|C_w(s)-Q C_v(s)\bigr|
\le H,\qquad H=\frac{k(k+1)}2.
\tag{10}
$$

**Proof.** Before the suffix, the load vector is exactly $Q$ times the original vector. After $r$ unit-valued suffix goods, its deviation from that scaled vector is a nonnegative vector $d$ whose coordinates sum to $r$. In particular, $0\le d_i\le r$ for every agent.

For every real vector $x$ and every vector $d$ with $0\le d_i\le r$,

$$
\max_i x_i\le\max_i(x_i+d_i)\le\max_i x_i+r,
$$

and the same two-sided bound holds for the minimum. Therefore the range changes by at most $r$ in absolute value. Summing over $r=1,\ldots,k$ proves (10). $\square$

Apply this lemma to the instance in Section 3, with its actual middle length $k=m+n-4$. Set

$$
Q=2H+1=k(k+1)+1,
\qquad K_+=QK+H.
\tag{11}
$$

In a yes-instance of PARTITION, Lemma 2 supplies a recipient sequence of base cost $K$. Its positive-value cost is at most $QK+H=K_+$.

In a no-instance, every base cost is an integer strictly larger than $K$, and hence is at least $K+1$. For every recipient sequence, (10) gives

$$
C_w(s)\ge Q(K+1)-H
=QK+H+1=K_++1.
\tag{12}
$$

All goods now have strictly positive integer value. The multiplier $Q$ is $O(k^2)$ and therefore adds only $O(\log k)$ bits. The number of goods is unchanged. This is a polynomial reduction to the strictly positive restriction, whose NP membership was already proved. It completes the hardness part of Theorem 1.

The estimate is uniform over all assignments of the unit suffix. A no-instance cannot avoid the bound by using those small goods to repair its imbalance.

## 5. Pseudopolynomial solvability and precise classification

For completeness, a standard load-state dynamic program provides a self-contained pseudopolynomial upper bound. This algorithm is included to clarify the complexity classification and support verification, not as a claimed new algorithm.

Let $V=\sum_{t=1}^{L}v_t$ and $S_t=\sum_{u=1}^{t}v_u$. At time $t$, store a minimum accumulated cost for each vector

$$
z=(z_1,\ldots,z_{n-1})\in\{0,\ldots,V\}^{n-1}
$$

with $\sum_i z_i\le S_t$. The last load is determined as $z_n=S_t-\sum_{i<n}z_i$. Unreachable states have value $+\infty$. The initial zero state has cost zero.

For each state, assign the next good to one of the $n$ agents, update the load vector, and add its new range. Keep the smallest accumulated cost for each resulting vector. Induction on $t$ proves exactness: every allocation prefix has a last recipient, and the future feasible extensions depend only on the current load vector.

There are at most $(V+1)^{n-1}$ states per time layer. With a direct $O(n)$ range computation for each of $n$ transitions, the algorithm uses

$$
O\bigl(Ln^2(V+1)^{n-1}\bigr)
\tag{13}
$$

arithmetic operations and $O((V+1)^{n-1})$ stored costs for fixed $n$. The additional bit cost is polynomial in $\log(1+LV)$. This is pseudopolynomial because $V$ need not be polynomially bounded in the binary input length. The fixed-$n$ FPTAS in [1] remains available.

The resulting classification is as follows.

| Restriction | Conclusion in this note |
|:--|:--|
| Prescribed order, identical binary-encoded positive integers, fixed $n\ge4$ | Weakly NP-complete |
| The same problem with polynomially bounded total value and fixed $n$ | Polynomial by (13) |
| Prescribed order, identical values, $n=2$ or $3$ | Not classified here |
| Order chosen by the algorithm | A different feasible set; not our theorem |
| Strong hardness or fixed-$n$ inapproximability | Not claimed |

In particular, unless $\mathsf P=\mathsf{NP}$, there cannot be an exact polynomial-time algorithm for every fixed constant number of identical agents. The proof identifies the obstruction already at four agents. It does not identify the smallest hard agent count.

## 6. Verification and research status

The proof of Theorem 1 is mathematical and applies to all binary-encoded input magnitudes. The accompanying exact-integer program separately checks small instances by dynamic programming and compares the answers against a subset-sum oracle. It also enumerates labelled assignments on smaller instances to check (3), and checks the positive-value perturbation (10). The reproducibility report gives the precise tested domains and counts. These finite computations do not replace the universal proof or the standard NP-completeness of PARTITION.

The dynamic program used for small-instance verification sorts load vectors to exploit symmetry. This is valid only because all valuations coincide and no agent-specific constraints are imposed. A separate labelled enumeration checks this symmetry reduction on its stated finite domain.

This is an AI-assisted research draft. It has not undergone external peer review and has no end-to-end proof-assistant certificate. Its contribution is the resolution of the stated exact-complexity gap and the positive-value strengthening. Neither worldwide priority nor a publication venue is asserted.

## References

1. P. W. Goldberg, I. Robinson and N. Teh. *Minimizing Cumulative Envy in Allocating a Sequence of Items*. arXiv:2610.09843v1, 7 October 2026. Sections 2–4 and Section 5 for the distinct sequencing variant. [Fixed-version full text](https://arxiv.org/html/2610.09843v1). A preliminary version appeared at SAGT 2026; the argument above is compared with the stated arXiv version.

2. R. M. Karp. *Reducibility among Combinatorial Problems*. In *Complexity of Computer Computations*, pp. 85–103, 1972. [doi:10.1007/978-1-4684-2001-2_9](https://doi.org/10.1007/978-1-4684-2001-2_9). Used only for the classical NP-complete source problem.
