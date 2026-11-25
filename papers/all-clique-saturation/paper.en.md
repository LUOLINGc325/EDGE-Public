---
title: "Proper hat-guessing saturation of windmills and cone bouquets"
subtitle: "List lifting, finite-petal bounds, and exact weighted-star thresholds"
lang: en
geometry: margin=1in
fontsize: 11pt
---

## Abstract

In proper hat guessing the adversary must use different colors on adjacent vertices. We determine the eventual maximum palette on a bouquet of repeated copies of any fixed graph joined to one shared hub, with arbitrary list budgets. The saturation value is exactly the proper list capacity of one blade with its budgets multiplied by the hub budget plus one, followed by adding that same number of hub colors. For a clique blade the list capacity has a matching proof, giving an eventual value \(3d+1\) for ordinary one-guess windmills with \(d+1\) vertices per clique. The critical palette forces exact one-point separation of hub color sets, giving entropy and graph-structural lower bounds on the blade count. An explicit separating-star construction improves the sufficient blade count, and balanced partitions give the exact least blade count for weighted stars with one hub guess.

## 1. Game and saturation law

On a finite simple graph, every vertex sees its neighbors' colors and outputs a deterministic list of at most its specified nonnegative integer budget. A strategy wins if at least one vertex lists its own color for every proper coloring from a fixed palette. Let \(P(H,\boldsymbol b)\) denote the largest winnable palette size for a nonempty graph \(H\) with list budgets \(\boldsymbol b=(b_v)\). We regard a palette with no proper coloring as vacuously winnable, and include palette size zero. Winnability is downward closed by restricting the palette and intersecting each guess list with it. The maximum is finite: for \(q\ge |V(H)|\), sample a uniform injective coloring of all vertices. Given the neighbor view, a vertex's own color is uniform on at least \(q-|V(H)|+1\) choices. The union bound on correct lists is at most \(\sum b_v/(q-|V(H)|+1)\).

Let the bouquet consist of \(r\) disjoint copies of a nonempty graph \(H\), together with a hub adjacent to every vertex in those copies. Each peripheral copy uses budgets \(\boldsymbol\ell\), and the hub gets \(g\ge1\) guesses. Assume \(\sum\ell_v>0\). Put \(s=g+1\). A clique of \(d\) peripheral vertices gives a windmill whose full blades have size \(d+1\).

**Theorem 1.** The maximum winnable palette, as the number of blades is allowed to grow, is
\[
q_{\mathrm{sat}}=P(H,s\boldsymbol\ell)+s.
\qquad\text{(1)}
\]
It is attained whenever \(r\) is at least the number of classes in a partition of the \(s\)-subsets of a \(q_{\mathrm{sat}}\)-element palette into disjoint-set classes. One may always use one class per \(s\)-subset. For \(s=2\), at most \(q_{\mathrm{sat}}-1\) blades suffice if the palette size is even, and \(q_{\mathrm{sat}}\) suffice if it is odd.

For a blade \(H=K_d\), let \(L=\sum_{v=1}^d\ell_v\). Then
\[
q_{\mathrm{sat}}=d+g+(g+1)L.
\qquad\text{(2)}
\]
In particular the ordinary proper hat guessing number of \(r\) cliques of size \(d+1\) sharing one vertex is at most \(3d+1\) for every \(r\), and equals \(3d+1\) for all sufficiently large \(r\). With one blade and general budgets the exact value is \(d+g+L\).

Adriaensen and coauthors list windmills as an open family. The fixed predecessor resolves triangular blades for every blade count and explicitly leaves larger complete blades outside its theorem. The present result determines the saturation value for every clique size and gives separate estimates for the first blade count that attains it. Pinned source ledger

## 2. Separation and uniform multiplication of the lists

Fix a palette \(Q\) of size \(q\ge s\). For an exterior observation \(z\), the candidate hub colors are those unused in \(z\) for which every peripheral list fails. The hub sees \(z\), so its list can complete the strategy exactly when the candidate set always has size at most \(g\).

For a blade and an \(s\)-subset \(A\subset Q\), say the blade separates \(A\) when each proper peripheral coloring with colors in \(Q\setminus A\) gives a correct list on that blade for at least one of the proposed hub colors \(c\in A\). A fixed collection of peripheral strategies can be completed by the hub if and only if every \(s\)-subset is separated on some blade. In one direction the separated blade prevents simultaneous survival of the \(s\) colors. In the other, if a set is not separated anywhere, choose separately on each blade a proper observation avoiding the set and causing all its hub hypotheses to survive. The observations combine freely across blades. At least \(s\) possible hub colors then have no correct peripheral list, a contradiction.

For a given \(A\), existence of a separating strategy on a copy of \(H\) is equivalent to existence of a winning internal strategy on \(Q\setminus A\) with budgets \(s\boldsymbol\ell\). Given separation, union the \(s\) lists a vertex would make for the same internal view and the different proposed hub colors, and intersect with \(Q\setminus A\). This wins the internal game and respects the multiplied budget. Conversely, split an internal winning list into \(s\) lists of size at most \(\ell_v\), indexed by the proposed hub colors, and use the designated part when that color is observed at the hub. Extend arbitrarily to other inputs. This proves equivalence, including the vacuous case with no proper common coloring.

It follows that \(q\le P(H,s\boldsymbol\ell)+s\) whenever the bouquet wins with \(q\ge s\). At equality split the \(s\)-subsets among blades. A single blade can implement all separations in a disjoint-set class, since the subrules require different observed hub colors. A winning hub decoder then follows from the candidate criterion. With two-element sets, the round-robin construction partitions the complete graph on \(q\) vertices into \(q-1\) perfect matchings for even \(q\). Explicitly label the vertices \(\{\infty\}\cup\mathbb Z/(q-1)\) and in round \(a\) pair \(\infty\) with \(a\) and \(a-j\) with \(a+j\) for \(j=1,\ldots,(q-2)/2\). Every unordered pair of finite labels has a unique midpoint in that odd group. For odd \(q\) add a dummy vertex and restrict each matching. This proves (1) and the blade-count assertions.

The same proof applies to heterogeneous blades \(H_j,\boldsymbol\ell_j\). The palette is at most \(s+\max_j P(H_j,s\boldsymbol\ell_j)\), and at any size \(q\), a disjoint-set class can be assigned to any blade with \(P(H_j,s\boldsymbol\ell_j)\ge q-s\). This gives a constructive threshold whenever there are sufficiently many such blades.

## 3. Weighted list capacity of a clique

For \(K_d\) with arbitrary budgets \(b_i\ge0\) and \(B=\sum_i b_i>0\), the exact proper list capacity is \(d-1+B\). To see the upper bound for \(q\ge d\), there are \((q)_d\) injective ordered colorings, with \((q)_d=q(q-1)\cdots(q-d+1)\). Each player has \((q)_{d-1}\) possible views, and its list gives at most \(b_i\) successes per view when the missing color varies. A union count therefore requires \((q)_d\le B(q)_{d-1}\), or \(q-d+1\le B\).

At the limiting palette, make a bipartite graph with the full injections on one side. On the other put \(b_i\) copies of each pair consisting of player \(i\) and its view. Connect a full injection to every copy of each of its partial views. Both sides are \(B\)-regular: the left degree is the total number of list slots, and the right degree is the number of unused colors that complete its view. For every subset of either side, counting edges gives Hall's condition, so there is a perfect matching. For each player and view, list the missing colors matched to its slots. These colors are distinct for that view, and every full injection succeeds. This proves the clique formula, including the one-blade weighted clique case and (2).

## 4. Necessary blade counts at the clique ceiling

We now use the exactness of the clique count. If a blade separates a set \(A\) of \(s\) hub colors at \(q=q_{\mathrm{sat}}\), then every proper peripheral injection avoiding \(A\) yields exactly one correct list occurrence over all hub hypotheses in \(A\). Indeed the total allowed count of correct guesses over the \(s\) hypotheses is \(sL(q-s)_{d-1}=(q-s)_d\), and separation covers every injection at least once. Every positive-budget slot in every common local view must therefore be occupied by an unobserved color outside \(A\).

Fix an ordered peripheral injection \(z\) and use this same observation at every blade. There are \(m=q-d\) unused hub colors. Assign each such color a binary word of length \(r\), with a one if some peripheral player on that blade succeeds under that hub color. Every \(s\) distinct unused colors have a coordinate with exactly one one, since their separating blade has the tightness property. In particular, no word can occur on \(s\) colors, so \(m\le g\,2^r\). In the ordinary game this gives
\[
r\ge\lceil \log_2(2d+1)\rceil .
\qquad\text{(3)}
\]
For \(d=2\) it coincides with the known exact least blade count three.

An entropy version strengthens this bound. Choose \(Z\) uniformly among the ordered \(d\)-color injections and then a hub color uniformly from its \(m\) unused colors. Let \(B_i\) be the corresponding success bit at blade \(i\). For each \(Z=z\), every word has probability at most \(g/m\), so \(H(B_1,\ldots,B_r\mid Z)\ge\log_2(m/g)\). The marginal distribution of the own color is uniform among \(m\) choices conditional on a leaf's neighboring colors, hence \(\Pr(B_i=1)\le L/m<1/2\) by the union bound. Using binary entropy \(h_2(t)=-t\log_2t-(1-t)\log_2(1-t)\) and subadditivity gives
\[
r\ge \left\lceil \frac{\log_2(m/g)}{h_2(L/m)}\right\rceil,\qquad
m=g+(g+1)L .
\qquad\text{(4)}
\]

For one hub guess, the graph of separated pairs on any single blade has no odd cycle of length at most \(q-d\). To see this, leave all colors on such a cycle unused by a peripheral injection. The success bits along the edges must alternate, impossible for an odd cycle. Its maximum degree is at most \(L+1\). For a center color \(c\) with a separated neighbor, let \(A\) be its nonneighbors other than itself. If \(|A|<d\), use a view of \(d-1\) colors containing \(A\) at a player with positive budget. At least one neighbor is absent. Tightness for each omitted neighbor of \(c\) forbids its color in the guess list, and tightness also forbids the center and the entire view. No color remains for a legal guess, a contradiction. Thus \(|A|\ge d\). On the \(A\)-only injections every guess for \(c\) must remain in \(A\) by the same tightness, and there is at most one success. Averaging the success count gives \(L/(|A|-d+1)\le1\). Since \(q=d+1+2L\), this yields \(\deg(c)\le L+1\). As all \(\binom q2\) pairs must be separated, edge counting also gives \(r\ge\lceil(q-1)/(L+1)\rceil\).

## 5. Improved sufficient blade counts in the ordinary clique game

Consider \(g=1\) and one guess per leaf, at the critical palette \(q=3d+1\). A single clique blade can separate the two edges of a three-vertex star simultaneously. Fix colors \(c,a,b\), with \(c\) the center of the desired separation star. First solve the two-list game on the common palette \(Q\setminus\{c,a\}\) with a separate slot for each proposed hub color. Impose the extra restriction that the \(c\)-slot never guesses \(b\).

This restricted matching admits an exact fractional certificate. Call a partial view type zero if it avoids \(b\), and type one otherwise. For a full injection avoiding \(b\), give each edge to a \(c\)-slot weight \(1/(2d-1)\) and each edge to an \(a\)-slot weight \(1/d-1/(2d-1)\). These edges are all to type-zero views and their weights sum to one. From an injection containing \(b\), the missing-\(b\) coordinate sends weight \(1/d\) to its \(a\)-slot. Each other missing coordinate has a type-one view and sends weight \(1/(2d)\) to each of its two slots. Again the row sum is one. For a type-zero view there are \(2d-1\) completions not using \(b\), and just one completing with \(b\). The \(c\) and \(a\) column sums are each one by the given weights. A type-one view has \(2d\) completions and receives \(1/(2d)\) from each per slot. All weights are nonnegative. This gives Hall's condition by summing unit row weights over any set, so the restricted matching has an integral perfect matching.

Transport this strategy by swapping \(a,b\) to separate \(c,b\). The two definitions for hub color \(c\) agree on their overlapping local views, since such views avoid \(a,b\), and the first strategy's \(c\)-slot chooses neither \(a\) nor \(b\). The strategies for hub colors \(a,b\) are distinct and cause no conflict. This proves the star construction. Vertex-disjoint stars of size at most three, including edges, can be handled on the same blade.

This improves the number of blades sufficient for large palettes. Put \(M=\lceil q/6\rceil\), and let \(\chi'(K_M)\) denote the round-robin matching count, with \(\chi'(K_1)=0\). Divide a padded palette of \(6M\) elements into \(M\) groups of size six. Cover intergroup edges by the matching rounds of \(K_M\); in each matched pair of groups, the \(K_{6,6}\) edges can be partitioned into five star forests of the required type. Within each group the \(K_6\) edges can be partitioned into four such forests. Applying the same construction to vertex-disjoint groups simultaneously and restricting back to the true palette gives the sufficient threshold
\[
r\ge \min\{q-\mathbf1_{\{q\ \mathrm{even}\}},\ 5\chi'(K_M)+4\}.
\qquad\text{(5)}
\]
The first term is the round-robin guarantee of Theorem 1. Appendix A lists the finite forests and the companion certificate checks their edge coverage directly. As \(d\) grows, the second upper threshold is at most \(5q/6+O(1)\).

## 6. Exact saturation thresholds for weighted stars

Let \(d=1,g=1\), and let the single leaf in each blade list at most \(\ell\ge1\) colors. The resulting graph is a star with \(r\) leaves. By (2), \(q_{\mathrm{sat}}=2(\ell+1)\), and its least blade count is exactly
\[
\lceil\log_2(2\ell+2)\rceil .
\qquad\text{(6)}
\]
For the lower bound use \(q-1\) unused colors in the binary coding argument. The ceiling of \(\log_2(q-1)\) equals that of \(\log_2q\) for even \(q\ge4\). To attain it, choose distinct binary words of this length for the \(q\) colors using \(q/2\) pairs of complementary words. Each coordinate partitions the palette into two groups of size \(\ell+1\). On that blade, the leaf observing hub color \(c\) lists the other \(\ell\) colors in its group. Any two different words differ in a coordinate, and across that blade their two lists cover all \(q-2\) common colors. Thus the hub strategy wins.

More generally with \(g\) hub guesses the weighted-star ceiling is \(q=s(\ell+1)\), where \(s=g+1\). A balanced \(s\)-way partition produces a blade by listing other colors in the observed hub color’s group. Every \(s\)-set that is a transversal of this partition is separated. A uniform random balanced partition gives any specified \(s\)-set this property with probability
\[
p=\frac{s!(\ell+1)^s}{(q)_s}\ge\frac{s!}{s^s}.
\]
Independent repetition and a union bound over all \(s\)-sets give a sufficient blade count whenever \(\binom qs(1-p)^r<1\). Together with (4), the least saturated blade count has order \(\log q\) as \(\ell\to\infty\) for each fixed \(g\). The equality (6) is the explicit one-hub-guess case.

## 7. A finite-palette volume bound and scope

For homogeneous clique blades and \(q>d\), fix a hub color. At least \((q-1)_{d-1}(q-d-L)_+\) peripheral injections leave all players on one blade incorrect, by the list budget count. Draw the exterior injection on each blade independently and uniformly from the full palette. If \(U\) is the number of colors unused across that exterior observation, the expected number of surviving hub colors is at least \(q[(q-d-L)_+/q]^r\). It is at most \(\mathbb E[\min(g,U)]\), since the hub needs at most \(g\) candidates and every candidate is unused. Hence
\[
q\left(\frac{(q-d-L)_+}{q}\right)^r\le \mathbb E[\min(g,U)]\le g.
\]
The rightmost bound alone is the ordinary volume argument. The refined term can be evaluated exactly by inclusion–exclusion, since for any fixed \(j\)-set of colors the probability of remaining unused is \([(q-j)_d/(q)_d]^r\), with the falling factorial set to zero when fewer than \(d\) colors remain.

The product structure of the failed-blade sets and the ordinary volume method are inherited from He, Ido and Przybocki. Adriaensen and coauthors' proper-coloring model and its windmill question are the source of our specialization. The new contributions are the general list-multiplication saturation law and the higher-clique and weighted consequences, including the finite thresholds and refinements proved above. The exact intermediate-petal classification for larger cliques remains outside this result. The fixed repository archive records two adjacent works inspected only as abstracts. The comparison is limited to those available records and the pinned predecessors. General proofs are independently reviewed and the finite constructions are reproducible. Lean verification is tracked separately.

- S. Adriaensen et al., *Hat guessing with proper colorings*, arXiv:2603.04909v4, especially §7. [Primary version recorded in the archive](https://arxiv.org/abs/2603.04909v4)
- X. He, Y. Ido and B. Przybocki, *Hat Guessing on Books and Windmills*, Electronic Journal of Combinatorics 29(1), P1.12 (2022), especially Lemma 24 and §4. [Archived reference](https://doi.org/10.37236/10098)


## Appendix A. The finite star-forest decompositions

Label each six-vertex group by \(0,\ldots,5\). For \(K_{6,6}\), the first digit of an edge is the left label and the second is the right label. For \(K_6\) the two digits label its unordered endpoints. Each row has components consisting of isolated edges and stars with two leaves.

| Layer | \(K_{6,6}\) edges | \(K_6\) edges |
| --- | --- | --- |
| 1 | 04, 10, 21, 23, 34, 40, 52, 55 | 01, 02, 34, 35 |
| 2 | 00, 01, 12, 22, 35, 45, 53, 54 | 04, 12, 13, 45 |
| 3 | 02, 11, 24, 25, 30, 33, 42, 51 | 05, 15, 23, 24 |
| 4 | 03, 14, 15, 20, 31, 32, 43, 50 | 03, 14, 25 |
| 5 | 05, 13, 41, 44 | |

All 36 bipartite edges and all 15 clique edges occur once, as can be checked by sorting the labels in each column.
