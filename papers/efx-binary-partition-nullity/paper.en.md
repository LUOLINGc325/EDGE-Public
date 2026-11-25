# The worst multiplicative EFX factor for two-class matroid-nullity chores

## Abstract

A chore is described by one bit for each agent. Each agent pays one unit for each occurrence of a bit beyond its first occurrence in her bundle. These costs are nullities of personalized two-class partition matroids and have binary, nondecreasing marginal costs. Across all numbers of chores and all $n$-agent profiles, the worst optimal multiplicative envy-freeness-up-to-any-chore factor is asymptotic to $n/\log_2 n$. A polynomial-time allocation achieves the upper bound. A matching lower bound already holds with probability tending to one for independent uniform bits on $3n-1$ chores, without any efficiency requirement. For that item count the explicit upper bound is $\lceil(n-1)/\lfloor\log_2 n\rfloor\rceil$. A projection-matching parameter also determines each profile's optimal factor to within one. The 18-agent, 53-chore counterexample of Lin, Liu, Tao and Zhou has optimal factor exactly two.

## 1. Model, scope and prior work

There are $n\ge2$ agents and $m\ge0$ labeled chores. We first treat the family $m=3n-1$, which witnesses the asymptotic lower bound. Theorem 6 gives a constructive guarantee for arbitrary $m$. Chore $g$ has signature $w_g\in\{0,1\}^n$. Distinct chores may have the same signature. For agent $i$ and bundle $B$ let $z_i(B)$ and $o_i(B)$ count the zero and one bits in coordinate $i$. Define

$$
c_i(B)=|B|-|\{w_{g,i}:g\in B\}|
       =(z_i(B)-1)_+ +(o_i(B)-1)_+ .
$$

The empty bundle costs zero. The first appearance of either bit costs zero and each subsequent appearance costs one. The cost is therefore normalized, monotone and supermodular, with all marginal increments in $\{0,1\}$. Its complementary rank counts the represented classes of a partition matroid of capacity one per class. All singleton costs are zero.

A complete allocation $X=(X_1,\ldots,X_n)$ partitions the labeled chores. For $\alpha\ge1$ it is **$\alpha$-EFX** when

$$
c_i(X_i\setminus\{g\})\le \alpha c_i(X_j)
\qquad(i,j\in[n],\quad g\in X_i).
$$

This definition quantifies over every owned chore, including those with zero marginal cost. Comparisons with a zero-cost bundle are interpreted directly by the inequality. Write $\rho(W)$ for the smallest feasible $\alpha$ and put $F_n=\max_{W:\,m=3n-1}\rho(W)$ and $G_n=\sup_{m\ge0}\max_{W:\,|W|=m}\rho(W)$. The maxima at each fixed item count range over finite families. We prove $F_n\sim G_n\sim n/\log_2 n$.

Barman, Narayan and Verma's Theorem 12 rules out simultaneous Pareto efficiency and every positive reciprocal approximation guarantee for binary supermodular chores. Their example has identical costs, for which they also prove exact EFX when fairness is considered on its own. Lin, Liu, Tao and Zhou's Theorem 2 gives an 18-agent failure of exact EFX for precisely the personalized nullity costs above. Their proof uses agreement of small bundles outside their owners' coordinates. We quantify the best possible fairness guarantee without imposing Pareto efficiency, over all item counts as the population grows. Their §4 explicitly asks a separate question about binary submodular costs. Our theorem concerns the supermodular nullities. [Barman, Narayan and Verma, §6](https://arxiv.org/abs/2302.11530) · [Lin, Liu, Tao and Zhou, §§3–4](https://arxiv.org/html/2608.10572v1#S3)

Christoforidis and Santorinaios have shown that approximation can be unbounded for general superadditive costs, already for fixed numbers of agents and chores. The binary-increment restriction studied here fixes the cost scale, and our constructive upper bounds apply to every word profile. [Christoforidis and Santorinaios, Theorem 1](https://arxiv.org/abs/2406.10752)

## 2. Finite factors and homogeneous pairs

For a coordinate set $S\subseteq[n]$, project all chore signatures onto $S$. Let $f_v(S)$ be the number of chores with projected word $v$. Define

$$
P_W(S)=\sum_{v\in\{0,1\}^{S}}\left\lfloor\frac{f_v(S)}2\right\rfloor .
$$

This is the maximum number of disjoint chore pairs that agree at every coordinate in $S$. The upper bound follows class by class and is attained by pairing consecutive chores in each class. Define

$$
s_*(W)=\max\big\{|S|:1\le|S|\le n-1,\ P_W(S)\ge n-|S|\big\}.
$$

At least one such set exists. For one coordinate there are at most two classes, so at least $\lceil(3n-3)/2\rceil\ge n-1$ pairs can be formed.

**Lemma 1.** In a finite-factor allocation every bundle has at least two chores. Both pair bundles and bundles with at least three chores occur. If $S$ is the set of owners of bundles with at least three chores, every pair bundle agrees on $S$. Conversely, any complete allocation with these size and agreement properties has a finite factor. Its best factor is an integer.

**Proof.** Since $3n-1>2n$ for $n\ge2$, someone owns at least three chores. In any three chores two agree in that owner's coordinate. Removing a third chore leaves a positive nullity. A comparison with a bundle of size zero or one would then violate the inequality for every finite $\alpha$. Thus all bundles have at least two chores. Since $3n-1<3n$, some bundle has exactly two.

For a large-bundle observer, the same positive trimmed cost forces every pair bundle to have positive cost. A pair costs one exactly when its two bits agree and zero otherwise. This proves the required agreement for all coordinates in $S$. Conversely, a pair owner has trimmed cost zero. To any large-bundle owner every pair bundle has cost one and every large bundle costs at least $3-2=1$. A pair bundle exists, so the smallest comparison cost is exactly one. This allocation's best factor is the maximum of one and all trimmed own costs of its large-bundle owners, an integer. $\square$

**Theorem 2.** For every bit profile $W$,

$$
\max\left(1,\left\lceil\frac{n-1}{s_*(W)}\right\rceil-1\right)
\ \le\ \rho(W)\
\le\ \left\lceil\frac{n-1}{s_*(W)}\right\rceil .
$$

**Proof.** In any finite-factor allocation let $s=|S|$ and let $d_i=|X_i|$ for $i\in S$. The $n-s$ pair bundles certify $P_W(S)\ge n-s$, so $s\le s_*(W)$. There are $n-1$ chores beyond two per agent, giving $\sum_{i\in S}(d_i-2)=n-1$. Thus some $d_i\ge 2+\lceil(n-1)/s\rceil$. After deleting any one item that owner has cost at least $d_i-3$, since at most two colors remain. Comparison with a pair of cost one proves the lower bound.

For the upper bound, choose any feasible $S$ of size $s$. Reserve $n-s$ disjoint pairs that agree on $S$ and assign one pair to each agent outside $S$. Divide the remaining $n+2s-1$ chores as evenly as possible among the $s$ agents in $S$. Each gets at least three chores since $s\le n-1$, and at most $2+\lceil(n-1)/s\rceil$. After deleting one chore the remainder is nonempty and contains at least one color, so its cost is at most the initial size minus two. By Lemma 1 all comparison bundles cost at least one to this owner. Pair owners have all trimmed costs zero. This gives $\lceil(n-1)/s\rceil$-EFX; take $s=s_*(W)$. $\square$

The theorem applies to the original fairness definition even when $\alpha=1$. For example, a two-agent instance has $s_*=1$ and always admits exact EFX.

## 3. Uniform upper bound

**Theorem 3.** Every profile with $3n-1$ chores admits a complete allocation with factor

$$
F_n\le \left\lceil\frac{n-1}{\lfloor\log_2 n\rfloor}\right\rceil .
$$

**Proof.** Set $k=\lfloor\log_2 n\rfloor$. Here $1\le k\le n-1$. Choose any $k$ agents as $S$. At most $2^k\le n$ projected classes are occupied. If $o$ classes have odd cardinality then $P_W(S)=(3n-1-o)/2\ge(2n-1)/2$. Since $P_W(S)$ is an integer, there are at least $n$ pairs, of which only $n-k$ are needed. Apply the explicit allocation in Theorem 2. $\square$

On a word RAM with $\Theta(\log n)$-bit words, the $k$ bits from each of the $m$ input rows can be read and packed into an index for one of $2^k$ buckets. Pairing within the buckets, assigning the selected pairs and distributing the remainder require $O(mk+n)$ time for this construction and $O(m+n)$ working words. Reading a full, explicitly streamed $mn$-bit input instead gives an $O(mn)$ input-processing bound. The algorithm uses an arbitrary set of $k$ coordinates and does not require optimizing $s_*(W)$.

## 4. Lower bound on random profiles

Take the $mn$ signature bits independently and uniformly. For any specified set of $r$ disjoint chore pairs and any fixed $s$ coordinates, the probability that every pair agrees on all those coordinates is $2^{-rs}$. Independence holds because different pairs use disjoint items and different coordinates use independent bits.

**Lemma 4.** Put $t=\lceil\log_2 n\rceil+6$. With probability tending to one, $s_*(W)<t$.

**Proof.** A violation supplies $s\ge t$ selected coordinates and $r=n-s$ disjoint agreeing pairs, with $r\ge1$. First consider $r\le n/2$. There are at most $n^r$ ways to choose the $r$ complementary coordinates and at most $m^{2r}$ choices of the pairs. Since $s\ge n/2$, a union bound over this case is at most

$$
\sum_{1\le r\le n/2}(9n^3\,2^{-n/2})^r=o(1).
$$

For $r>n/2$, choose $h=\lfloor n/2\rfloor$ of the disjoint pairs and $t$ of the agreeing coordinates. The number of ways to choose $h$ unlabeled disjoint pairs is

$$
\frac{m!}{(m-2h)!\,2^h h!}\le \left(\frac{e m^2}{2h}\right)^h .
$$

The inequality follows from $h!\ge(h/e)^h$. Another union bound gives at most

$$
\binom nt\left(\frac{e m^2}{2h\,2^t}\right)^h
\le n^t\left(\frac{27e}{128}\right)^h=o(1),
$$

using $h\ge n/3$, $m<3n$ and $2^t\ge64n$. The last limit follows from $t\log n=O((\log n)^2)$ and $27e/128<1$. For sufficiently large $n$ the required choices of coordinates exist. The two cases exhaust all witnesses. $\square$

**Theorem 5.** The worst optimal factor and the optimal factor of a uniformly random profile both have leading order $n/\log_2 n$. Explicitly, for all sufficiently large $n$,

$$
\left\lceil\frac{n-1}{\lceil\log_2 n\rceil+5}\right\rceil-1
\ \le F_n\ \le\
\left\lceil\frac{n-1}{\lfloor\log_2 n\rfloor}\right\rceil .
$$

Moreover the same bounds hold for $\rho(W)$ with probability tending to one. Therefore $F_n\log_2 n/n\longrightarrow 1$, and $\rho(W)\log_2 n/n$ converges to one in probability.

**Proof.** Lemma 4 gives $s_*(W)\le t-1$ with probability tending to one. Apply the lower bound of Theorem 2 and the universal upper bound of Theorem 3. Dividing by $n/\log_2 n$ makes both bounds tend to one. $\square$

**Theorem 6.** Over all numbers of chores, $G_n\log_2 n/n\longrightarrow1$. Each profile has a polynomial-time allocation with factor at most

$$
\begin{cases}
1, & m\le2n,\\
\left\lceil d/\lfloor\log_2(d+1)\rfloor\right\rceil,
    &m=2n+d,\quad 1\le d<n,\\
2,&m\ge3n .
\end{cases}
$$

**Proof.** If $m\le2n$, give at most two chores to each agent. Every trimmed own bundle then has cost zero. If $m\ge3n$, give each agent $q$ or $q+1$ chores, where $q=\lfloor m/n\rfloor\ge3$. Any trimmed bundle has at most $q$ chores and at least one color, so its cost is at most $q-1$. Every comparison bundle costs at least $q-2$. Since $q-1\le2(q-2)$, this is $2$-EFX. When $n$ divides $m$, every bundle has size $q$ and the largest trimmed cost drops to $q-2$, giving exact EFX.

In the remaining case set $s=\lfloor\log_2(d+1)\rfloor$, so $1\le s\le d\le n-1$. Choose any $s$ agents. Projection onto them has at most $2^s\le d+1$ occupied classes. The matching size is at least $(2n+d-2^s)/2\ge n-1/2$, hence is at least $n$. Allocate $n-s$ agreeing pairs outside the chosen set and divide the $2s+d$ remaining chores evenly inside the set. Every designated owner gets at least three and at most $2+\lceil d/s\rceil$ chores. Pair owners have zero trimmed costs. Each designated owner has trimmed costs at most $\lceil d/s\rceil$ and sees every other bundle at cost at least one.

For the limit, let $L=\log_2 n$. When $d\le n/L^2$, the middle bound is at most $d=o(n/L)$. When $d>n/L^2$, its denominator is at least $L-2\log_2 L-1$. Thus its supremum is at most $(1+o(1))n/L$. The remaining two cases contribute at most two, and Theorem 5 gives the matching lower bound via $G_n\ge F_n$. $\square$

These profiles rule out a universal constant multiplicative EFX guarantee for the full binary-supermodular chore class, with complete allocations and no efficiency constraint. The matching upper bound with leading constant one covers all numbers of chores in the two-class nullity model.

## 5. Finite estimates and the published witness

An exact finite union bound enables numerical population sizes without using asymptotic approximations. For an integer $2\le u\le n-1$,

$$
\Pr[s_*(W)\ge u]\le
\sum_{s=u}^{n-1}
  \binom ns
  \frac{(3n-1)!}{(3n-1-2r)!\,2^r r!}\;2^{-rs},
\qquad r=n-s .
$$

Each summand counts coordinate sets and matchings and multiplies by the agreement probability. Whenever the sum is below one a profile with $s_*(W)\le u-1$ exists. The table uses exact integers and powers of two for the comparison. The displayed probability bounds have been rounded upwards.

| Agents | Threshold $u$ | Union bound, at most | Certified lower bound on $F_n$ | Universal upper bound |
|---:|---:|---:|---:|---:|
| 32 | 10 | 0.000121 | 3 | 7 |
| 64 | 10 | 0.000001 | 6 | 11 |
| 128 | 10 | 0.002704 | 14 | 19 |
| 256 | 11 | 0.000001 | 25 | 32 |
| 512 | 12 | 0.000001 | 46 | 57 |

For the 18-agent instance in Lin et al.'s §3.1, exhaustive projection of its 53 published words gives the following largest matching size over coordinate sets of each size $s$. Coordinates are numbered from the least significant bit, a relabeling of the published coordinates.

| $s$ | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| $\max P_W(S)$ | 26 | 26 | 26 | 25 | 23 | 20 | 14 | 10 | 7 | 4 | 3 | 2 | 1 | 0 | 0 | 0 | 0 |

Thus $s_*=8$ and Theorem 2 gives $\rho(W)\ge2$. An allocation with one bundle of size five, seven of size four, and ten pairs attains two. The list below gives its zero-based chore IDs. The ordering takes all left rotations of the first seed, then all left rotations of the second seed, then offsets 1 through 17 of the third seed, all in ascending offset order. The four- and five-chore owners are $0,1,4,5,9,10,14,16$. Every pair is homogeneous in these eight coordinates, and the size-five owner sees both colors at least twice. These facts also verify the claimed factor directly. [Original seeds, §3.1](https://arxiv.org/html/2608.10572v1#S3.SS1)

| Agent | Chore IDs | Agent | Chore IDs |
|---:|---|---:|---|
| 0 | 42, 13, 28, 41, 51 | 9 | 8, 21, 35, 46 |
| 1 | 1, 14, 30, 0 | 10 | 9, 22, 37, 47 |
| 2 | 2, 40 | 11 | 15, 24 |
| 3 | 4, 52 | 12 | 17, 36 |
| 4 | 3, 18, 31, 43 | 13 | 20, 49 |
| 5 | 5, 19, 32, 44 | 14 | 10, 25, 38, 48 |
| 6 | 6, 33 | 15 | 23, 27 |
| 7 | 7, 16 | 16 | 12, 26, 39, 50 |
| 8 | 11, 29 | 17 | 34, 45 |

The reproduction program checks the partition, each trim inequality, all $2^{18}-2$ nonempty proper coordinate sets and the exact finite sums. The finite computations illustrate the analytic results. The asymptotic proof is independent of the numerical checks.
