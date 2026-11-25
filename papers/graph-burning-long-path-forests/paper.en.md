# A constructive near-linear threshold for burning long path forests

## Abstract

Let $L_n$ be the least integer such that every forest of $n$ paths, each with at least $L_n$ vertices, burns in $\lceil\sqrt N\rceil$ rounds, where $N$ is its total order. Tan and Teh proved that $L_n$ is finite, established a lower bound asymptotic to $12n$, and conjectured $L_n\le12n$. We prove the explicit constructive bound
$$
L_n\le4096\,n(\lceil\log_2 n\rceil+8)^2\qquad(n\ge2).
$$
Consequently $\log L_n/\log n\to1$. For square order we partition the first $\sqrt N$ odd numbers into specified path orders. We reserve a small collection of pairs around each boundary between successive target sums. After a greedy allocation of the remaining odd numbers, these pairs correct each boundary independently, including discrepancies of either parity. The construction gives a polynomial-time algorithm on an explicitly represented forest.

## 1. The threshold

A path forest is a disjoint union of nonempty paths. Its order is its number of vertices. In round $t$ of graph burning, one unburned vertex is ignited and fire spreads one edge from previously burned vertices. A source ignited in round $t$ can reach vertices at distance at most $M-t$ by the end of round $M$. On a path these form an interval with at most $2(M-t)+1$ vertices. The total capacity of $M$ sources is therefore at most $1+3+\cdots+(2M-1)=M^2$. Every path forest of order $N$ needs at least $\lceil\sqrt N\rceil$ rounds.

Tan and Teh proved that a sufficiently long shortest path guarantees equality in this bound, for every fixed number $n$ of components. Their proof uses finiteness of trees of deficient forests and König's tree lemma. Their Question 5.3 asks for the values of the thresholds $L_n$. Subsequently they established the values through $n=7$ and conjectured the uniform upper bound $12n$. Their Theorem 1.3 supplies obstructions with shortest path of order $(12-o(1))n$. [Tan and Teh, *Burnability of double spiders and path forests*, §§4–5](https://arxiv.org/abs/2207.13855) · [Tan and Teh, *A note on graph burning of path forests*, Theorem 1.3 and Conjecture 3.1](https://doi.org/10.46298/dmtcs.12709)

**Theorem 1.** For $n\ge2$ put $b=\lceil\log_2 n\rceil+8$ and $L=4096nb^2$. If each of $n$ paths has order at least $L$, their forest burns in precisely $\lceil\sqrt N\rceil$ rounds. For square $N=M^2$, the construction outputs a complete partition of the first $M$ odd positive integers with the given path orders as its sums.

**Corollary 2.** As $n\to\infty$, $L_n=n^{1+o(1)}$. **Proof.** Theorem 1 gives $\log L_n\le\log n+2\log\log n+O(1)$. Tan and Teh's lower bound $L_n\ge(12-o(1))n$ gives the other direction after division by $\log n$. $\square$

The theorem leaves a factor of order $\log^2 n$ between the current lower and upper scales. It gives neither the conjectured coefficient 12 nor an upper bound linear in $n$.

## 2. Odd partitions and reduction to a finite range

Write $w_j=2j-1$. If the total order is $M^2$, an exact partition of $w_1,\ldots,w_M$ into the path orders suffices to burn the forest in $M$ rounds. Place the assigned odd intervals consecutively on each path. For interval length $w_j$, ignite its center in round $M-j+1$. Its ball at the last round is that interval. Centers of intervals of radii $r$ and $s$ on the same path have distance at least $r+s+1$, sufficient to ensure that each new source is unburned when ignited. This partition formulation for square order is also recorded by Tan and Teh. [Tan and Teh, §1](https://arxiv.org/abs/2312.10914)

Let $\ell_1,\ldots,\ell_n$ be the target orders, initially summing to $M^2$ and all at least $L$. At a stage of total $m^2$, give the largest available odd number $2m-1$ to a longest target if subtracting it leaves that target at least $L$. The remaining total is $(m-1)^2$. Continue until the subtraction is no longer possible and record all assignments for restoration. At the stopping point, still denoted by $m$, write $t_1,\ldots,t_n$ for the residual targets.

**Lemma 3.** At the stopping point $64nb\le m<64nb+2n\le66nb$. If $k=\lfloor\log_2 m\rfloor$, then $k\le2b$.

**Proof.** The sum is at least $nL=(64nb)^2$. Stopping means every target is less than $L+2m-1$, so $m^2<nL+2nm$. Completing the square gives $m<n+\sqrt{n^2+(64nb)^2}\le64nb+2n$. Finally $n\le2^{b-8}$ and $b\le2^b$, hence $m\le66nb<2^{2b}$. $\square$

## 3. Correcting one boundary

Place the target bins in an arbitrary fixed order. Boundary $i$ separates bins $i$ and $i+1$, for $1\le i<n$. We reserve some odd numbers for use only in these two bins. Each boundary receives one **toggle**, the odd item $h_i=2i-1$, and three copies of $k$ disjoint pairs of items. Within each copy the pairs have index differences
$$
1,\ 2,\ 4,\ \ldots,\ 2^{k-1}.
$$
A pair of indices $(a,a+d)$ has weight difference $2d$.

**Lemma 4.** All the reserved items can be chosen disjointly in $\{1,\ldots,m\}$, with the lower index of every pair at most $B=2U+1$, where $U=(n-1)(6k+1)$. The combined weight of any one boundary's reserved items is at most $1046nb^2$.

**Proof.** Reserve indices $1,\ldots,n-1$ for the toggles first. At most $U$ indices will be used altogether. By Lemma 3,
$$
U\le13nb,\qquad 4U+2\le64nb\le m,\qquad B\le27nb .
$$
For any required difference $d$, try $a=1,\ldots,B$. A previously used index $x$ rules out at most two candidates, $x$ and $x-d$. There are $2U+1$ candidates and at most $2U$ exclusions. Moreover $a+d\le B+2^{k-1}\le m/2+m/2=m$. A greedy choice works at every step.

For one boundary let $D=3(2^k-1)$ be the sum of the index differences. A pair's total weight is $4a+2d-2\le4B+2d$. There are $3k$ pairs, hence their combined weight plus the toggle is at most
$$
2n+12kB+2D\le2n+648nb^2+396nb\le1046nb^2 ,
$$
where $D\le3m$ and $m\le66nb$. $\square$

**Lemma 5.** For each boundary $i$ there is a baseline left-bin weight $H_i$ such that every left-bin weight
$$
H_i,\ H_i+1,\ \ldots,\ H_i+2m-2
$$
is achievable by splitting its reserved items between the two incident bins. The two shares always sum to the same total.

**Proof.** Give the left bin one member of each pair. If it receives all lower members their total is $A_i$. Switching to upper members adds $2d$ per switched pair. One copy of the binary differences realizes all integer index sums from zero to $2^k-1$. With three copies their sums fill $0,\ldots,D$; to realize a desired sum, take as much as possible within each successive copy and expand each part in binary. Thus every even offset from zero to $2D$ can be added to $A_i$. Giving the toggle to the left additionally permits $h_i$ plus any such even offset.

Set $H_i=A_i+h_i-1$. Since $h_i$ is odd, every offset from $h_i-1$ to $h_i-1+2m-2$ is covered when $2D\ge h_i-1+2m-2$. Even offsets use the pairs alone. An odd offset in this range is at least $h_i$ and can use the toggle. To verify the upper endpoint, $2^k\ge(m+1)/2$, so $D\ge3(m-1)/2\ge m+n-2$ by Lemma 3. This more than suffices for $h_i\le2n-3$. $\square$

For a numerical example of the parity adjustment, consider a toggle of weight five and index gaps one, two and four. The even offsets run from zero through fourteen. The toggle adds all odd offsets from five through nineteen. Starting at offset four, a shortfall of seven is corrected by choosing offset eleven, namely the toggle plus the weight increases two and four.

## 4. Correcting all prefix sums

Initially orient every boundary according to its baseline left share. Let $C_i$ be the total baseline weight in bin $i$ from both incident boundaries, or from the single incident boundary at an endpoint. Lemma 4 gives
$$
0\le C_i\le2\cdot1046nb^2<L\le t_i.
$$
The residual targets $d_i=t_i-C_i$ are nonnegative and their total equals the weight of the unreserved odd items.

List those free items in any order. For each $i$ cut the list immediately after the longest prefix whose sum is at most $d_1+\cdots+d_i$. These cut positions are nondecreasing. Assign the items between successive cuts to the corresponding bin. Write $\delta_i$ for the shortfall of the chosen prefix from its target. Then $\delta_0=\delta_n=0$. If the cut is before another item of weight $w$, the integer shortfall is at most $w-1\le2m-2$. At the final position the shortfall is zero, including the case where an earlier target prefix already equals the total.

For boundary $i$ use Lemma 5 to increase its left share by $\delta_i$. The right share decreases by the same amount. This change increases the weight of the first $i$ bins by $\delta_i$ and changes no other cumulative prefix. Because the reserved collections are pairwise disjoint, all changes can be made together. Each cumulative sum now equals its prescribed target. Taking successive differences gives every individual target exactly. Restoring the previously assigned large odds proves the square-order case of Theorem 1.

For an arbitrary order $N$, extend the last path at one end until the total is $M^2$, where $M=\lceil\sqrt N\rceil$. Apply the square construction and project all centers back to the original paths by clipping centers outside the last path to its original endpoint. Each retained vertex is at most as far from the projected center as it was from the original center. The balls with the prescribed final radii therefore cover the original forest.

For completeness, any such ordered ball cover admits a legal burning sequence in at most $M$ rounds. If a planned center is still unburned, ignite it. If it was already reached by an earlier actual source, then the earlier source's final ball covers the planned final ball by the triangle inequality and the elapsed number of rounds. Ignite any still-unburned vertex in its place, or stop if the graph is already burned. The final actual balls cover every planned ball. The initial capacity bound gives the matching lower bound of $M$ rounds. This finishes the proof.

## 5. Algorithm and verification

A maximum heap implements the removal of largest odd items in $O(M\log n)$ operations. At the terminal scale there are $O(nb)$ pairs and $O(nb)$ candidate bases per pair. A Boolean membership array on the $m$ indices implements the disjointness checks in $O(n^2 b^2)$ operations in the worst case. The free-item cut and final orientations take $O(m+nb)$ operations. Thus an exact odd partition or an ordered ball-cover certificate is produced in $O(M\log n+n^2b^2)$ operations on indices and sums of $O(\log N)$ bits. This accounts for explicit certificate size; the list of sources itself has length $M$ on a square instance. The sufficient threshold and its constants are not optimized.

The reference program returns odd-index partitions and radius-indexed centers. Its independent checks sum the actual odd weights in every bin, test uniqueness of all indices, and merge the resulting clipped intervals on each original path. Test families include equal path orders exactly at the theorem's threshold, heterogeneous nonsquare totals, and a single long component forcing repeated removal of the largest odds. The smallest nontrivial threshold test has $n=2$, both orders $663552$, and $1152$ sources. A second check tests every allowed discrepancy at both boundaries of a three-path instance, verifying $7678$ complete left-right assignments. These finite computations test the algorithm; the uniform theorem follows from Lemmas 3–5 and the prefix argument.
