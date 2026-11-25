---
title: "A linear threshold for optimal burning of long path forests"
subtitle: "Exact odd partitions by modular transfers between complementary pairs"
lang: en
geometry: margin=1in
fontsize: 11pt
---

## Abstract

Let $L_n$ be the smallest per-component order that guarantees a forest of $n$ paths and total order $N$ can be burned in $\lceil\sqrt N\rceil$ rounds. We prove $L_n\le100n$ for every $n\ge2$. In the square-order case we construct an exact partition of the first $\sqrt N$ odd numbers into the component orders. The main device is to pair residual weights to a common total and use a bounded number of split pairs per boundary to correct cumulative demands modulo that total. The remaining pairs then solve the integer multiples of the modulus independently. This improves the archived $O(n\log^2 n)$ bound and, together with a square-order obstruction, establishes $L_n=\Theta(n)$. The conjectured coefficient $12$ lies outside the proved bounds.

## 1. Model and theorem

In round $t$ of graph burning one may ignite an unburned vertex, while fire spreads one edge from vertices already burning. Once a vertex burns it stays burned. A vertex ignited at time $t$ covers a ball of radius $M-t$ by time $M$. In a path that ball has at most $2(M-t)+1$ vertices. Thus every path forest of total order $N$ has burning number at least $\lceil\sqrt N\rceil$.

For each positive integer $n$ let $L_n$ be the least positive integer $L$ such that all forests of exactly $n$ paths with each component of order at least $L$ attain this lower bound. The previous archived construction gave $L_n\le4096n(\lceil\log_2 n\rceil+8)^2$. Its discussion explicitly left an upper bound linear in $n$ and the sharper coefficient $12$ outside its conclusions. The linear-scale question is the target here.

**Theorem.** Let $n\ge2$ and let $\ell_1,\ldots,\ell_n$ be positive integers with $\ell_i\ge100n$. Write $N=\sum_i\ell_i$. The corresponding path forest burns in exactly $\lceil\sqrt N\rceil$ rounds. If $N=M^2$, the algorithm partitions $\{1,3,\ldots,2M-1\}$ into $n$ sets with sums $\ell_i$. It produces the interval centers using $O(M\log n+n^2)$ arithmetic operations in the square case and the same bound with $M=\lceil\sqrt N\rceil$ in the general case.

In particular $9n-12\le L_n\le100n$ for $n\ge3$. The lower bound has a short self-contained proof below. The stronger previously reported lower bound is $(12-o(1))n$ by Tan and Teh. Prior proof and source comparison

## 2. Reduction of the square-order problem

Assume $N=M^2$. For $j=1,\ldots,M$ write $w_j=2j-1$. Allocating $w_j$ to a path places an interval of that length on that path and uses its center at time $M-j+1$. When the intervals cover the path consecutively, every vertex is burned by the end of round $M$. Two such centers in one path with radii $a,b$ have distance at least $a+b+1$, so a source that is scheduled later cannot already have burned from one scheduled earlier. Exact partition therefore suffices.

Put $L=100n$. Starting with $m=M$ and demands of total $m^2$, give the largest remaining odd $2m-1$ to a largest demand whenever that assignment leaves the demand at least $L$. Reduce $m$ by one. All remaining demands stay at least $L$ and add up to $m^2$. At the terminal value, called $m$ again, let the remaining demands be $T_1,\ldots,T_n$. They satisfy
$$10n\le m<(1+\sqrt{101})n<100n/9.$$
The first inequality follows from $m^2\ge nL$. Stopping gives $T_i<L+2m-1$ for all $i$, hence $m^2<100n^2+2nm$, giving the second. The last follows from $1+\sqrt{101}<100/9$. All subsequent choices use only the odd weights through $2m-1$. The earlier assignments are restored at the end.

Let $b=2m$. Pair odd weights $u$ and $b-u$. If $m$ is odd, the central weight $m$ is a singleton. Assign it to one chosen endpoint bin, to be placed last in the bin order, and subtract $m$ from that bin's demand. Let the adjusted demands be $t_i$. The adjusted total is an even multiple of $m$, namely a multiple of $b$, since $m^2$ is already divisible by $b$ when $m$ is even and $m^2-m$ is divisible by $b$ when $m$ is odd. Therefore the number of odd adjusted demands is even.

Order all odd demands consecutively in pairs, with the chosen singleton bin last when present. This is possible even if that bin has odd adjusted demand, by putting its odd partner immediately before it and all even bins before the block of odd bins. If it has even adjusted demand, append it after the others. In this order, at most $\lfloor n/2\rfloor$ of the proper prefixes have odd sum, and no two consecutive proper prefixes have odd sum.

## 3. A pair selection lemma

Represent odd residues modulo $b=2m$ by their unique values in $\{1,3,\ldots,2m-1\}$. Complementary pairs are the classes $\{a,b-a\}$ with two distinct representatives. The singleton, when present, is unavailable.

Suppose $u$ pairs have been used. To represent a nonzero even residue $\delta$ by two odds from distinct unused pairs, try $a$ over the $m$ odd residues and put $c=\delta-a\bmod b$. The map $a\mapsto c$ permutes odd residues. Used pairs exclude at most $4u$ candidates across the two representatives. A singleton can exclude at most two more. Equality $c=a$ excludes at most two, since $2a=\delta\bmod 2m$ has at most two solutions. The other same-pair case $c=b-a$ is impossible since $\delta\ne0$. Thus at most $4u+4$ candidates are forbidden.

For an odd residue $\delta$ choose a representative $a$ of any unused pair on the indicated side of $m$: take its larger member if $\delta<m$, and its smaller member if $\delta\ge m$. This makes $a\ne\delta$. Exclude that entire pair and solve the nonzero even residue $\delta-a$ by the preceding two-sum construction. Together the three selected representatives have integer sum $s\equiv\delta\bmod b$, with $0<s<6m$. Therefore
$$s\in\{\delta,\delta+2m,\delta+4m\}.$$
If $\delta<m$, the chosen $a>\delta$ excludes $s=\delta$, and the upper candidate is below $5m$. If $\delta\ge m$, then $a<\delta$ and the other two weights have sum strictly below $4m$, excluding $s=\delta+4m$. The lower candidate is at least $m$ and the middle one is below $4m$. In every case both $s$ and its complementary share $6m-s$ are at most $5m$.

## 4. Repair of cumulative demands

For each boundary between consecutive bins, let $\delta_i$ be the residue modulo $b$ of the sum of the adjusted demands through bin $i$. For $\delta_i=0$ use no pairs. For nonzero even $\delta_i$ select two pairs by Section 3. For odd $\delta_i$ select three. Give the selected representatives to the bin immediately left of the boundary, and their complements to the bin immediately right.

The maximum total number of used pairs is
$$U=2(n-1)+\lfloor n/2\rfloor.$$
For every two-sum call the number already used is at most $U$, including an initial odd representative if one was needed. Thus $4u+4\le10n-4<m$. An unused pair for the initial odd representative exists since there are $\lfloor m/2\rfloor\ge5n$ pairs and $U<5n$. All chosen pairs can therefore be made disjoint.

The sum allocated by these transfers to the first $i$ bins is congruent to $\delta_i$. All pairs strictly to the left contribute their full combined weights, which are multiples of $b$. The only other contribution is the left share of boundary $i$. Consequently every bin's adjusted demand minus its transfer allocation is an integer multiple of $b$, by taking differences of prefix congruences.

These remaining demands are nonnegative. A two-pair boundary contributes less than $4m$ to either incident bin, and a three-pair boundary at most $5m$. An interior bin has at most one odd boundary, giving total less than $9m<L$. The final endpoint, even after adding back its possible singleton, uses at most $6m<L$. The first endpoint uses at most $5m<L$. These bounds also cover the case of an empty transfer at some boundary. The sum of the remaining demands equals the total weight of the unused pairs. Give each bin its remaining demand divided by $b$ unused pairs. This produces exact sums and exhausts the weights. Restoring the peeled odds proves the square-order statement.

A heap for demand peeling takes $O(M\log n)$ operations. Each of the $n-1$ selections tests at most $O(m)$ candidates in a membership array of complementary pairs. Since $m<100n/9$, this takes $O(n^2)$ operations. Assignments and ordered interval centers take $O(M+n)$ further work. This is a deterministic constructive bound under unit-cost arithmetic on integers of $O(\log N)$ bits.

## 5. Nonsquare order and a lower example

For an arbitrary $N$, let $M=\lceil\sqrt N\rceil$. Extend one path at one end by $M^2-N$ vertices and apply the square construction. Project each center in the extension to the original endpoint. For every original vertex, its distance to the projected center is at most its distance to the planned center. Thus the original forest still has an ordered cover with final radii $M-t$.

An ordered cover by these balls yields a legal burning sequence. At its planned time $t$, ignite the projected center if still unburned after that round's spreading. If earlier sources already reach it, some earlier source at time $s<t$ is within distance $t-s$. The earlier source's final ball of radius $M-s$ then contains the projected center's planned final ball by the triangle inequality. Ignite any remaining unburned vertex in that round, or stop if all have burned. The final cover is preserved. The capacity lower bound proves the optimum is exactly $M$. On an explicitly represented forest, the additional legal-source conversion can be performed with a breadth-first spreading queue and a pointer that scans each vertex at most once to find any unburned vertex. Each vertex and edge requires constant work. Since $N\ge100n^2$ and $M=\lceil\sqrt N\rceil$, the planned cover also takes $O(N)$ work in that representation.

For a lower example independent of the known stronger asymptotic lower bound, let $n\ge3$ and $M=3n-2$. For odd $n$, start with $n$ equal demands $9n-12$ and add two to two of them. For even $n$, start with $n$ demands $9n-13$ and add two to $(n+4)/2$ of them, which is possible for $n\ge4$. In both cases the sum is $M^2$, every demand is odd, and each exceeds $2M-1$. If the forest burned in $M$ rounds, every final ball would have to realize its odd capacity and the balls would have to be disjoint, since the sum of capacities equals the total order. Then each odd component requires an odd number of odd capacities, and one capacity would be too small. There must be at least $3n$ balls, but $M=3n-2$. Thus $L_n\ge9n-12$.

## 6. Contribution and scope

The earlier upper bound used many powers-of-two pair differences at each boundary to implement all possible integer adjustments. Here all unused complementary pairs have equal total. The prescribed correction at a boundary is represented modulo that total using at most three pairs chosen *after* that residue is known. The bounded number of consumed pairs and the prohibition on adjacent odd boundaries let the argument operate at the linear scale. It applies to uneven demands, both parities of the square root, and nonsquare total forests.

This proves a linear upper bound. It does not prove the sharper $L_n\le12n$ conjecture. The source comparison is bounded to the listed archived papers, their recorded literature audit and repository snapshots. The complete written argument is independent of the literature lower bound. The companion verification gives exact finite tests of every emitted partition and cover in its recorded suite. Lean verification is a separate deliverable.

- Tan, J. H. and Teh, W. C. *Burnability of double spiders and path forests*. The path-count threshold and its existence are discussed in §§4–5. [Archived reference](https://arxiv.org/abs/2207.13855).
- Tan, J. H. and Teh, W. C. *A note on graph burning of path forests*. The known asymptotic lower bound and the conjectured $12n$ appear in Theorem 1.3 and Conjecture 3.1. [Archived reference](https://doi.org/10.46298/dmtcs.12709).
- earlier research manuscript. *A constructive near-linear threshold for burning long path forests*. §1 states the remaining gap, and §§3–4 develop the multiple-pair correction scheme being superseded. Fixed archive.
