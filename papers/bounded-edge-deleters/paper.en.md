---
title: "Self-deleting paths with bounded deleters per edge"
fontsize: 11pt
geometry: margin=1.1in
abstract: |
  In a self-deleting graph, visiting a vertex removes a prescribed set of edges before the next move. Prior deterministic algorithms measure how many edges one vertex can delete. We give a dual parameter bound in the maximum number of possible deleters of one edge, without bounding a vertex's deletion list. The algorithm colors path vertices and excludes off-path deleters from their colors. Its dependence on path length is single exponential at constant edge frequency. This is optimal under the Exponential Time Hypothesis even with one deleter per edge, on subcubic bipartite two-terminal series-parallel graphs of pathwidth at most three.
---

## 1. Problem and results

A self-deleting graph consists of a finite simple undirected graph \(G=(V,E)\) and explicit sets \(F_v\subseteq E\) for each \(v\in V\). After reaching \(v\), its edges \(F_v\) are permanently removed before the next move. The initial vertex executes its deletions before the first move. No move follows the terminal, so the terminal's deletions do not affect feasibility. A path \(v_0,\ldots,v_\ell\) is conforming if for every \(0\le i<\ell\), the edge \(v_i v_{i+1}\) belongs to none of \(F_{v_0},\ldots,F_{v_i}\).

Let \(n=|V|\), \(m=|E|\), \(F=\sum_v |F_v|\), and define
\[
\mu=\max_{v\in V}|F_v|,\qquad
D_e=\{v\in V:e\in F_v\},\qquad
\nu=\max_{e\in E}|D_e|
\]
with an empty maximum zero. The two incidence parameters measure deletion lists by source and by deleted edge, respectively. We are given vertices \(s,t\) and a budget \(k\) on the number of vertices of an \(s\)-to-\(t\) path, including both endpoints.

The model and the initial color-state approach come from Dvořák et al. [1]. The pinned deterministic result [2] uses the maximum list size \(\mu\), and gives a dependence \(2^{O(k\log(\mu+2))}\). A single vertex can have a long deletion list even when every edge can be deleted by only one vertex. This motivates using \(\nu\) instead.

**Theorem 1 (algorithm).** A shortest conforming \(s\)-to-\(t\) path with at most \(k\) vertices, or a report that there is none, can be found deterministically in
\[
2^{O(k\log(\nu+2))}(n+m+F)\log(n+2)
\tag{1}
\]
time. Using the pinned outgoing-incidence algorithm when \(\mu<\nu\) gives the same expression with \(\min(\mu,\nu)\) in place of \(\nu\).

**Theorem 2 (hardness at one deleter per edge).** The decision problem is NP-complete when \(\nu\le1\), even on connected subcubic bipartite two-terminal series-parallel graphs of pathwidth at most three. Under the Exponential Time Hypothesis, it has no algorithm of running time \(2^{o(k)}(n+m+F)^{O(1)}\) on that class. Thus the single-exponential dependence on \(k\) at constant \(\nu\) in (1) is optimal in exponential order.

For either statement the empty-deletion case is ordinary graph search. If a legal walk repeats a vertex, one can erase the closed portion between two occurrences. Before each retained move the shortened walk has visited a subset of the vertices seen before that move in the original walk. Its remaining edges are therefore still available. Iterating gives a path. This also justifies treating reachability and simple-path existence as equivalent in the hardness statement.

## 2. Separating the relevant vertices

We use the minimal separating families of Gabizon, Lokshtanov and Pilipczuk [3], in the form recalled in [2]. Let \(\mathcal U\) be a universe of size \(N\), and let \(1\le p\le K\le N\). There is a deterministic family of maps \(f:\mathcal U\to [p+1]\) such that for every disjoint \(C,B\subseteq\mathcal U\) with \(|C|=p\), \(|B|\le K-p\), some \(f\) maps \(C\) bijectively to \([p]\) and maps \(B\) to the color \(p+1\). The family size is at most
\[
(K/p)^{2p}\,2^{O(p)}K^{O(1)}\log(N+2).
\tag{2}
\]
Its construction time is bounded by this expression times \(N\). We refer to \(p+1\) as the rejected color.

A path of at most \(k\) vertices uses at most \(k-1\) edges, so the union of their deleter sets contains at most \((k-1)\nu\) vertices. This bounds the vertices that can falsely make a color-state test reject those edges, regardless of the sizes of any single deletion list.

Reject if \(k=0\). If \(s=t\) and \(k\ge1\), return the one-vertex path. Otherwise clamp \(k\) to \(n\). For \(s\ne t\) and \(k<2\) report no path. In the remaining cases use \(p=k\) and a universe containing the \(n\) actual vertex labels and \(k\) dummy labels, so \(N=n+k\). Set
\[
K=\min\{N,\ k+(k-1)\nu\}.
\tag{3}
\]
For any conforming path \(P\) within budget, let \(C\) contain the vertices of \(P\) and enough distinct dummy labels to make size \(k\). Let \(B\) be the set of actual vertices outside \(P\) that occur in \(D_e\) for some edge \(e\) of \(P\). Then \(C\cap B=\varnothing\), and
\[
|B|\le \min\{N-k,\ (k-1)\nu\}=K-k .
\]
Hence a map from the family colors the actual path vertices injectively with colors in \([k]\), and every deleter of its edges outside the path has the rejected color. No changes to the graph or deletion lists are made by adding dummy labels to the family universe.

## 3. State search for each coloring

For each map \(f\) in the family, build a color mask
\[
M_f(e)=\{ f(v): v\in D_e,\ f(v)\in[k]\}
\]
for every edge \(e\). This is done by scanning the explicit incidence lists \(F_v\) and omitting the rejected color. If \(f(s)\) is rejected, skip that coloring. Otherwise initialize the state \((s,\{f(s)\})\). A state \((v,S)\) remembers the current vertex and the set of colors used up to and including it. For a neighbor \(w\) of \(v\), the transition along \(e=vw\) is allowed exactly when
\[
 f(w)\in[k]\setminus S,\qquad M_f(e)\cap S=\varnothing.
\tag{4}
\]
The next state is \((w,S\cup\{f(w)\})\). Accept a state at \(t\); it needs no further transition. The set size bounds the length by \(k\), and predecessors recover paths.

Every state-walk corresponds to a conforming path. Colors never repeat, so vertices never repeat. If an earlier visited vertex, possibly the current one, had deleted the next edge, that vertex's color would belong to both \(M_f(e)\) and \(S\), contradicting (4). Thus the algorithm never permits an unavailable edge.

Conversely, fix a conforming \(P\) and use its coloring from Section 2. Its vertices have distinct nonrejected colors. For any step of \(P\), an off-path deleter is rejected and never appears in \(M_f(e)\). An on-path deleter has its own color, and it cannot have been visited at the time of that step since \(P\) is conforming. The transition therefore passes both conditions in (4). This proves completeness at every path length up to \(k\). Taking a shortest accepting state-path over all colorings gives the demanded optimum.

A single coloring admits at most \(n2^k\) states and at most \(2m2^k\) candidate transitions. Constructing masks costs \(O(n+m+F)\) times a factor polynomial in \(k\); the search has cost at most \(2^k(n+m+F)\) times such a factor. This accounting also covers multiword masks. Formula (3) gives \(K/k\le\nu+1\) and \(K\le k(\nu+1)\). The polynomial factors in \(k,K\) are absorbed in \(2^{O(k\log(\nu+2))}\). Since \(N\le2n\), multiplying by (2) and including family construction proves (1). The code-ready search needs only the edge incidences and the family of maps; no assumption about the geometry of \(F_v\) relative to \(v\) is used.

## 4. Lower bound under a single deleter

Reduce from 3-SAT with \(p\) variables and \(q\) clauses, where \(p,q\ge1\), each clause with three literal occurrences. Repeating a literal can pad a shorter nonempty clause to three occurrences. Put disjoint gadgets in a chain, first the \(p\) variable gadgets and then the \(q\) clause gadgets. Join the exit of each gadget to the next gadget's entrance with a single bridge. The start and target are the first entrance and last exit.

Each variable gadget has entrance \(a\), exit \(b\), and two branch vertices \(T_i,F_i\). Its edges are the two length-two routes \(a-T_i-b\) and \(a-F_i-b\). These choices represent true and false.

Each clause gadget has entrance \(a\), exit \(b\), and seven private vertices \(p_1,p_2,p_3,u,v,\ell_2,\ell_3\). Give it three routes of length four:
\[
a-p_1-p_2-p_3-b,\qquad
a-u-\ell_2-v-b,\qquad
a-u-\ell_3-v-b.
\tag{5}
\]
Mark the three distinct edges \(p_1p_2,u\ell_2,u\ell_3\), in order, for the three literal occurrences. Each marked edge is deleted by just one earlier branch vertex: \(F_i\) if the literal is the variable \(i\), and \(T_i\) if the literal is its negation. There are no other deletion incidences. In particular \(\nu\le1\), even when a clause repeats a literal.

### 4.1. Graph restrictions

The variable gadget is a parallel composition of two paths. The clause gadget is the parallel composition of a path and the series composition of an edge, a diamond, and an edge. The full graph is two-terminal series-parallel by composing these gadgets and bridges in series. Each private vertex has degree at most three. Every terminal has degree two in its own gadget and receives at most one bridge, so the whole graph is subcubic. The paths between each pair of gadget terminals have even length, and one can alternate colors along the routes of (5) and the variable diamonds. Color choices of adjacent gadgets can be flipped to accommodate each bridge, so the graph is bipartite.

For pathwidth, process a variable gadget in the order \(a,T_i,F_i,b\) and a clause gadget in the order \(a,p_1,p_2,p_3,u,\ell_2,\ell_3,v,b\). In any prefix of a gadget's order, at most three processed vertices have an unprocessed neighbor within that gadget. The preceding gadget's exit is active only up to the next entrance, and the current exit is processed last. Thus the concatenated order has at most three processed vertices with an unprocessed neighbor at every cut. A path decomposition is obtained by taking, for each next vertex, a bag containing that vertex and the preceding cut's active vertices. Each edge belongs to the bag of its later endpoint and the bags containing a vertex form an interval, so the width is at most three.

### 4.2. Equivalence and parameter size

A simple \(s\)-to-\(t\) path crosses every bridge in order and crosses each gadget between its two terminals. In a variable gadget it uses exactly one branch vertex. In a clause gadget it either uses the direct route or one of the two routes through the diamond. These are all the simple terminal crossings: inside the diamond going back through its other branch would revisit \(u\) or \(v\). In particular the lengths are two and four edges in the respective gadget types.

For the assignment selected by the variable gadgets, a marked edge survives precisely when its literal is true. Each clause route needs its marked edge, and removing all three marked edges disconnects the terminals. Once an assignment is selected, the remaining clause choices cause no further deletions. Hence an \(s\)-to-\(t\) conforming path exists exactly when the formula is satisfiable. Every such path uses
\[
2p+4q+(p+q-1)+1=3p+5q
\]
vertices, so use this budget \(k\). The instance has \(4p+9q\) vertices and \(3q\) deletion incidences. Its construction and encoding have polynomial size, and an alleged path is checked directly in polynomial time. This proves NP-completeness with the stated restrictions.

The ETH statement follows from the sparse 3-SAT consequence of the sparsification lemma [4]. On formulas with \(q=O(p)\), the reduction has \(k=O(p)\) and linear-size graph and deletion data. A \(2^{o(k)}(n+m+F)^{O(1)}\)-time solver would provide subexponential sparse 3-SAT algorithms, contrary to ETH. The reduction also proves hardness for reachability without an explicit budget because all feasible simple paths have the stated length.

## 5. Provenance

The family construction is from [3]. The use of color states for the self-deleting-path model goes back to [1]. The pinned outgoing-incidence theorem [2] colors path edges and keeps other deletions out of their colors. For the per-edge incidence parameter, the present algorithm colors path vertices and tests each edge against the colors of its possible deleters. The lower bound specifies the input class and the cost assumption under which the single-exponential path-length dependence is sharp.

**References**

1. M. Dvořák, D. Knop, M. Opler, J. Pokorný, O. Suchý, and K. Szilágyi. *Pathfinding in Self-Deleting Graphs*. ISAAC 2025, LIPIcs 359, Article 28.
2. *Deterministic parameter dependence for pathfinding in self-deleting graphs*. earlier research manuscript, fixed commit 4fee22993f21. The exact source path and blob are in the source manifest.
3. A. Gabizon, D. Lokshtanov, and M. Pilipczuk. *Fast Algorithms for Parameterized Problems with Relaxed Disjointness Constraints*. ESA 2015, LNCS 9294, 545–556. The minimal separating-family theorem is stated in its expanded version, arXiv:1411.6756v5.
4. R. Impagliazzo, R. Paturi, and F. Zane. *Which Problems Have Strongly Exponential Complexity?* Journal of Computer and System Sciences 63 (2001), 512–530. Sparsification and the sparse 3-SAT consequence of ETH.
