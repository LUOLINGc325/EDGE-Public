---
title: "The sharp random EFX threshold for two-class nullity chores"
subtitle: "Odd occupancy, exact typical factors, and a lattice correction"
lang: en
---

# The sharp random EFX threshold for two-class nullity chores

## Abstract

We study complete allocations of 3n−1 chores to n agents with personalized two-class partition-matroid nullity costs. Under independent fair signatures, a matching of equal projected words determines the transition between feasible and infeasible sets of large-bundle owners. We locate that transition at an explicit constant times n projection buckets, up to a vanishing window in the logarithmic dimension. We also give the exact optimum factor with high probability, improving the previous one-unit bracket by reserving odd-class representatives to balance both colors in each large bundle. These results yield a lattice correction to the leading n/log₂ n behavior and a polynomial-time algorithm that attains the optimum with high probability away from the narrow transition windows.

## 1. Model and results

There are n≥2 agents and m=3n−1 labeled chores. Each chore has an n-bit signature. For agent i the cost of a bundle B is its cardinality minus the number of distinct bits in the i-th coordinate among chores in B. Thus each bit's first occurrence has zero cost, and every further occurrence costs one. The random model takes all mn bits to be independent and fair.

A complete allocation is α-EFX if every agent i, every other bundle B_j, and every choice of a removed own chore g satisfy c_i(B_i without g)≤α c_i(B_j). This includes zero marginal costs and comparisons with zero-cost bundles. Write ρ(W) for the least α≥1 on profile W.

For a set S of agent coordinates, let P(S) be the maximum number of disjoint chore pairs agreeing on all of S. Let s_* be the maximum 1≤s<n for which some |S|=s has P(S)≥n−s. The archived *The worst multiplicative EFX factor for two-class matroid-nullity chores* establishes the projection-matching criterion and places ρ within one unit of ⌈(n−1)/s_*⌉. Its random bounds give ρ∼n/log₂ n. We sharpen the random matching threshold and show which end of that one-unit bracket is attained.

Define χ(u)=u[1−exp(−6/u)]/2, and let u_* be the unique positive root of χ(u_*)=1. It lies between two and three. The rational enclosure in the reproducibility record places it between 2.1265735 and 2.1265746. Put x_n=log₂(u_* n). All other logs in rate estimates are natural.

**Theorem 1.** For some constant C>0, with probability tending to one,

~~~text
⌊x_n⌋ ≤ s_* ≤ ⌊x_n+C log(n)/√n⌋,
ρ(W) = ⌈(n−1)/s_*⌉−1.                                        (1)
~~~

Consequently if the fractional part of x_n is less than 1−C log(n)/√n, then s_*=⌊x_n⌋ with high probability, and

~~~text
n/ρ(W) − log₂ n = log₂ u_* − {x_n} + o(1)                    (2)
~~~

on events of probability tending to one. The excluded population sizes have density zero. Moreover there is a constant c>0 such that when x_n lies below an integer by at most c/√n, that upper integer is attained with high probability. A deterministic polynomial-time algorithm attains the exact optimum with high probability along sequences outside the excluded windows.

## 2. Odd-bin occupancy

Fix a set S of size s, and put K=2^s. The m projected words are independent uniform draws into K bins. Let O count bins of odd size. Within any bin the maximal number of agreeing pairs is half its occupancy rounded down, so

~~~text
P(S)=(m−O)/2,    P(S)≥n−s iff O≤n+2s−1.                     (3)
~~~

Write a=(1−2/K)^m. The parity expectation of one bin is a, and hence

~~~text
E O=(K/2)[1−(1−2/K)^m] = n χ(K/n)+O(1)                     (4)
~~~

uniformly for K/n in a fixed compact subinterval of (0,∞). The approximation follows by expanding log(1−2/K) with m=3n−1. The derivative of χ is [1−(1+6/u)exp(−6/u)]/2, strictly positive. Since χ(2)<1<χ(3), this proves the assertions about the root.

Changing one projected word changes the parity of at most two bins. Bounded differences therefore gives, for every t≥0 and fixed S,

~~~text
Pr{|O−E O|≥t} ≤ 2 exp[−t²/(2m)].                              (5)
~~~

We first rule out feasible sizes s>x_n+C log(n)/√n up to s≤⌈log₂ n⌉+5. In this range the ratios K/n lie in a fixed compact interval. The derivative of χ is bounded below there. By (4) the distance from E O to the feasibility threshold in (3) is at least a constant times C√n log n for sufficiently large n. For example K/n≥u_* exp[(log 2)C log(n)/√n], and n+2s−1 differs from n by O(log n). The number of tested coordinate sets is at most exp[O((log n)²)]. Choosing C sufficiently large, (5) and a union bound give failure probability tending to zero.

For s≥⌈log₂ n⌉+6, let b=n−s. A witness requires b disjoint agreeing pairs, and for fixed S and pair family the probability is 2^(−sb). Union-bound over at most binom(n,s)m^(2b)/(2^b b!) such configurations. If s≤n/4 then b≥3n/4, and this bound is at most

~~~text
2^n (6e/64)^(3n/4),
~~~

using b!≥(b/e)^b, m≤3n, and 2^s≥64n. The bound is exponentially small since 2(6e/64)^(3/4)<1. If s>n/4, use binom(n,s)=binom(n,b)≤n^b. The bound is then at most (9n³ 2^(−n/4))^b, also exponentially small for b≥1. Summing over s is harmless. This proves the upper bound in (1).

## 3. Feasibility up to the lower integer

A one-sided small-deviation estimate supplies the lower bound even when E O is within a constant of the threshold. For fixed S write b=(1−4/K)^m. The product of the parities of two distinct bins has mean b, since each draw changes that product with probability 2/K. Summing the variances and covariances of the bin indicators gives

~~~text
4 Var(O) = K(1−a²) + K(K−1)(b−a²).                           (6)
~~~

For λ=m/K in a fixed compact subinterval of (0,∞), expanding the two powers yields

~~~text
a² = e^(−4λ)[1−4λ/K+O(K^(−2))],
b  = e^(−4λ)[1−8λ/K+O(K^(−2))],
4 Var(O)/K = 1−(1+4λ)e^(−4λ)+O(K^(−1)).
~~~

The limiting expression is uniformly positive. Thus whenever K/n remains in a fixed positive compact interval, Var(O)≥c₁ n for large n. The bounded-difference tail (5) gives E[(O−E O)⁴]≤C₁ n² by integration, and Var(O)≤C₂ n as well.

Put Y=O−E O. Hölder's inequality yields E|Y|≥[E(Y²)]^(3/2)/[E(Y⁴)]^(1/2), by writing E(Y²)≤(E|Y|)^(2/3)(E Y⁴)^(1/3). Since E Y=0, the negative part Y_−=max(0,−Y) has mean E|Y|/2≥c₂√n. Its second moment is at most C₂n. The Paley–Zygmund inequality therefore gives constants p₀,c₃>0 for which

~~~text
Pr{O≤E O−c₃√n}≥p₀,                                         (7)
~~~

uniformly on such compact ratios. One can also obtain (7) directly by applying Cauchy–Schwarz to the portion Y_− above half its mean.

At s=⌊x_n⌋, K/n lies between u_*/2 and u_* and (4) gives E O≤n+O(1). This makes the event in (7) feasible by (3) for all sufficiently large n. Partition the n coordinates into disjoint groups of size s, ignoring a final incomplete group. Their projected data and feasibility events are independent because the original bits in distinct columns are independent. The chance that none is feasible is at most (1−p₀)^(⌊n/s⌋), which tends to zero exponentially in n/log n. This proves the lower bound in (1).

If x_n lies below an integer s by distance at most c/√n, K/n=u_* exp[O(c/√n)], and (4) bounds E O above by n+O(c√n)+O(1). Choose c small enough that this is at most n+(c₃/2)√n for large n. The same argument proves feasibility at that upper integer. The upper bound already excludes the next integer. This yields the stated thin-boundary result.

## 4. Which integer EFX factor is attained

The following argument also gives a direct explanation of the archive's lower bound. In any complete allocation some bundle has at least three chores. Among any three chores, two agree in that owner's coordinate, so a suitable single deletion leaves a positive cost. A comparison with a bundle of size zero or one would then prevent a finite factor. Thus all bundles have size at least two, and some are pairs since m=3n−1. For every owner with at least three chores, each pair bundle must agree in that owner's coordinate, for the same positive-trim reason. The set S of large-bundle owners therefore satisfies (3). There are exactly n−1 chores beyond two per agent, so one large owner has at least 2+⌈(n−1)/|S|⌉ chores. Any trim of this bundle leaves at most two occupied colors and therefore costs at least its original size minus three. A pair has cost one to that owner. Since |S|≤s_*, this proves

~~~text
ρ(W) ≥ ⌈(n−1)/s_*⌉−1.                                       (8)
~~~

To attain it with high probability, fix a coordinate set S with s near log₂ n and an agent i∈S. For b in {0,1} let O_(i,b)(S) count odd bins whose i-th bit is b. Exactly half the bins have each bit, and E[O_(i,b)(S)]=(E O)/2. Uniformly over integer s between ⌊log₂ n⌋ and ⌈log₂ n⌉+5 this expectation is bounded below by γn for a fixed γ>0, by (4). Changing one projected word changes this count by at most two. Bounded differences gives an exponentially small probability that O_(i,b)(S)<γn/2. A union bound over all relevant s, S, i, b, of total size exp[O((log n)²)], now proves

~~~text
O_(i,b)(S) ≥ γn/2 for every relevant S,i,b                         (9)
~~~

with probability tending to one.

Take a feasible S of size s_*. It lies in this size range with high probability by (1)'s established projection bounds. Choose a maximum agreeing pairing by pairing within each bin, leaving one representative in every odd bin. Retain n−s_* of these pairs for the pair owners. Every odd representative is still available. For each i∈S, reserve four different remaining chores for its bundle, two of each of its own colors. This can be done greedily, because at most 4s_*=O(log n) chores are used for these reservations and (9) supplies linearly many candidates of each color.

Divide the remaining chores among the large owners so that their sizes differ by at most one. This is possible after the four-item reservations, because their smaller target size is 2+⌊(n−1)/s_*⌋≥4 for sufficiently large n. After deleting any chore a large owner retains both colors, so its trimmed cost is its original size minus three. Each other bundle has cost at least one to that owner. This holds by pair agreement for pair bundles, and by their cardinality of at least three for large bundles. Every pair owner has zero trimmed cost. The allocation therefore attains the right-hand side of (8), proving the exact factor in (1).

## 5. Lattice correction and a polynomial-time allocation

Outside the population-size windows in Theorem 1, the two integer bounds on s_* agree. There are at most two relevant powers of two in a dyadic interval N≤n<2N, up to endpoints. The condition x_n is below the next integer by at most C log(n)/√n puts n within O(√N log N) of a corresponding threshold 2^j/u_*. Thus the number of excluded integers in such a block is O(√N log N). Summing dyadic blocks shows that the excluded sizes have natural density zero.

Since s_* is of order log n and ρ=⌈(n−1)/s_*⌉−1 with high probability, n/ρ=s_*+O((log n)²/n). This gives (2). In particular the centered quantity n/ρ−log₂ n has no constant limit in probability. For every fixed 0<θ<1, take integers n near 2^(j+θ)/u_* as j grows. The fractional parts tend to θ outside the excluded windows, so the centered quantity converges in probability along that subsequence to log₂ u_*−θ. Taking θ tending to zero or one slower than the window widths also realizes the two endpoints. No subsequential constant outside [log₂ u_*−1, log₂ u_*] is possible by the projection bounds. Conversely the thin-boundary conclusion is used, for example, at n_j=⌈2^j/u_*⌉−1. These populations are just below their exact projection transition, so s_*=j with high probability even though ⌊x_(n_j)⌋=j−1.

There is an efficient allocation without exact arithmetic on the transcendental constant u_*. Among the constant number of integer candidates between ⌊log₂ n⌋ and ⌈log₂ n⌉+5, choose the largest s for which the exact rational mean in (4) is at most n+2s−1. For sufficiently large n such an s exists and is at least ⌊x_n⌋. The rational computation uses O(n log n) bits, since K is of order n. Screen disjoint coordinate groups of size s by computing their odd occupancy counts. By (7) the chance that none is feasible is exponentially small in n/log n. For a feasible group use the odd representatives and the construction from Section 4 when its color requirements hold.

On the high-probability event (9) those requirements hold. Outside the excluded windows the selected s equals ⌊x_n⌋ for large n: any larger s has exact mean above the threshold by the estimate used for the upper bound. Therefore the allocation achieves the exact optimum there with probability tending to one. If the tested groups or color reservations fail, a valid fallback allocation takes any ⌊log₂ n⌋ coordinates, pairs within their at most n projected bins, and splits the remaining chores evenly. At most n bins are odd, so there are enough pairs by (3). This fallback always has a finite factor. Pairing, screening, and all reservations are polynomial in the number of input bits.

## 6. Scope and attribution

The archive proves the deterministic matching characterization and the leading asymptotic n/log₂ n. The new results identify the random occupancy transition constant, close the one-unit optimum-factor gap with high probability, and give the lattice correction and a fast typical optimum. The theorem uses independent fair signatures and exactly 3n−1 chores. The behavior throughout the full shrinking transition window and the worst-case second-order factor are outside the result. The comparison is limited to the pinned repository record.
