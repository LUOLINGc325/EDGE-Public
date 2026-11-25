---
title: "Weighting makes unique-cover preassignment hard on interval graphs"
lang: en
---

# Weighting makes unique-cover preassignment hard on interval graphs

## Abstract

A cover preassignment forces selected vertices to belong to a minimum vertex cover and asks that exactly one original optimum survives. The unweighted problem has a polynomial-time algorithm on interval graphs. We show that positive integer vertex weights make it strongly NP-complete even for distinct intervals with an explicit integer representation and linearly bounded weights. In fact, the minimum preassignment size cannot be approximated within \(N^{1-\varepsilon}\) for any fixed \(0<\varepsilon<1\) on \(N\) intervals, unless \(\mathrm P=\mathrm{NP}\). The reduction identifies maximum-weight schedules with directed paths in an acyclic graph. Repeated, edge-disjoint shortcuts both encode color conflicts and prevent a short preassignment from choosing a shortcut as its surviving path. If the intended optimum is specified in advance, a minimum cut gives the exact preassignment in polynomial time.

## 1. Problem and results

Let \(G=(V,E)\) be an interval graph given by closed intervals, one per vertex. Each vertex \(i\) has a strictly positive integer weight \(w_i\). A preassignment is a set \(S\subseteq V\) of vertices forced into the cover. It is valid when exactly one minimum-weight vertex cover of the original graph contains \(S\). We minimize the cardinality of \(S\), independently of the vertex weights. The reference optimum is the original minimum weight, so forcing the weight to increase does not give a valid preassignment.

Equivalently, forbid \(S\) from appearing in maximum-weight independent sets. Complementation is a bijection between vertex covers and independent sets, and their weights sum to the constant total vertex weight. The pinned unweighted result [1, Theorem 2] gives an \(O(N^3)\) algorithm for interval graphs. Its exchange property uses cardinality of the optimum independent set.

**Theorem 1.** Given positive integer weights and a closed interval representation, deciding whether a valid preassignment of cardinality at most \(b\) exists is strongly NP-complete. The hardness holds with distinct intervals, endpoints in \([1,2N]\), and weights at most \(N\).

**Theorem 2.** For every fixed \(0<\varepsilon<1\), a polynomial-time approximation with factor \(N^{1-\varepsilon}\) for the minimum preassignment size on the same weighted interval class would imply \(\mathrm P=\mathrm{NP}\).

**Proposition 3.** If a particular original minimum-weight cover is specified and is required to be the surviving optimum, its smallest forcing preassignment is computable in polynomial time on weighted interval graphs.

The main reduction establishes an exact gap for the minimum number of edge deletions leaving one source-to-sink path in a directed acyclic graph. A second translation relates the fixed-cover problem to a cut separating all detours of an optimal path.

## 2. From acyclic paths to weighted intervals

Let \(D\) be a directed acyclic graph, with a source \(s\) and a sink \(t\), and suppose at least one \(s\)-to-\(t\) path exists. Take a topological labeling \(0,\ldots,T\) with \(s=0\) and \(t=T\). For an edge \((u,v)\), create the closed interval
\[
I_{uv}=[2u+1,2v],\qquad w_{uv}=v-u>0 . \tag{1}
\]
Intervals representing distinct edges of a simple acyclic graph are distinct. In an independent schedule, order the intervals along the line. Two consecutive intervals for \((u_i,v_i)\), \((u_{i+1},v_{i+1})\) are compatible exactly when \(v_i\le u_{i+1}\). Their closed endpoint convention in (1) permits the equality of these vertex labels while keeping the actual intervals disjoint.

For any such schedule with \(r\) intervals,
\[
T-\sum_{i=1}^r(v_i-u_i)
=u_1+(T-v_r)+\sum_{i=1}^{r-1}(u_{i+1}-v_i)\ge0 .
\]
The empty schedule has weight zero. For a nonempty one, equality holds exactly when it starts at label zero, ends at \(T\), and each consecutive pair has \(v_i=u_{i+1}\). Thus the maximum weight is \(T\) and the original optimum schedules are precisely the edge sets of \(s\)-to-\(t\) paths in \(D\). Their order is unique given the set. Forbidding an interval removes exactly its edge from these paths. The minimum preassignment is therefore the minimum number of edges one must delete in \(D\) to leave exactly one \(s\)-to-\(t\) path.

## 3. A coloring gap for unique paths

Let \(H\) be a finite simple graph on \(n\ge1\) ordered vertices. We reduce from its 3-colorability, a standard NP-complete problem. Build a directed acyclic graph with successive spine junctions \(p_0=s,p_1,\ldots,p_n=t\). Between \(p_{i-1}\) and \(p_i\) put three internally disjoint branches, one per color \(c\in\{1,2,3\}\), with edges
\[
p_{i-1}\longrightarrow a_{i,c}\longrightarrow b_{i,c}\longrightarrow p_i .
\]
Call the middle edge of each branch its gate. Let \(M\) be a positive integer multiplicity. For each edge \(ij\) of \(H\) with \(i<j\), and each color \(c\), put a group of \(M\) directed two-edge shortcuts
\[
b_{i,c}\longrightarrow z_{ijc,h}\longrightarrow a_{j,c},
\qquad h=1,\ldots,M .
\]
Every interior \(z_{ijc,h}\) is distinct and incident with exactly these two arcs. Each vertex \(b_{i,c}\) has its gate as its only incoming edge, and each \(a_{i,c}\) has its gate as its only outgoing edge. To see acyclicity, order each spine layer with its \(a\)'s, then its \(b\)'s, then the interiors of all shortcuts originating in that layer, and then \(p_i\). All shortcut ends \(a_{j,c}\) lie in strictly later layers.

**Lemma 4 (gap).** If \(M-1>2n\), the minimum deletion cost to leave a unique \(s\)-to-\(t\) path is exactly \(2n\) when \(H\) is 3-colorable, and at least \(M-1\) otherwise.

Suppose there is a proper coloring. Delete the two unused gates in each layer, using \(2n\) deletions. The chosen spine path survives. A shortcut used by an \(s\)-to-\(t\) path would require the gate at its source \(b_{i,c}\) and the gate at its destination \(a_{j,c}\), because of their unique incoming and outgoing edges, respectively. For every shortcut group at least one of these gates was deleted by proper coloring. No shortcut can therefore appear on a surviving path. With one intact spine branch per layer the spine path is unique.

For the converse, consider any deletion set leaving exactly one path \(P\). If \(P\) uses a shortcut, it traverses one of the \(M\) routes of that group from its source to its destination. Any other intact route in the group could replace this segment to give a different \(s\)-to-\(t\) path. The route interiors are distinct and acyclicity ensures the replacement is a path. Thus at least one edge was deleted from each of the \(M-1\) other routes, costing at least \(M-1\).

If \(P\) uses no shortcut, it chooses a color at every layer. Each of the other two spine branches between the same kept junctions would give an alternative if intact. These unused branch edges are disjoint across all layers, so at least \(2n\) deletions are necessary. If the resulting coloring is improper, some edge \(ij\) has the same chosen color \(c\) at both ends. The path then contains \(b_{i,c}\) and \(a_{j,c}\) in that order, and every intact shortcut in their group gives a different path by replacing the segment between them. Hence at least \(M\) deletions are needed. These cases prove the gap. A unique path can always be obtained by keeping its edges and deleting all other edges.

## 4. Complexity and approximation consequences

The acyclic graph from Section 3 has \(9n+6M|E(H)|\) edges and \(7n+1+3M|E(H)|\) vertices. Translated by (1), its number of intervals is \(N=9n+6M|E(H)|\). The topological size parameter satisfies \(T=7n+3M|E(H)|\le N\), so each weight is at most \(N\) and every endpoint lies in \([1,2N]\). It is a simple directed graph, so there are no duplicate intervals.

For the decision result, take \(M=2n+2\) and \(b=2n\). By Lemma 4 the budget is feasible exactly when \(H\) is 3-colorable. The construction is polynomial, and the numerical parameters are polynomially bounded even if written in unary. This gives strong NP-hardness. To verify a proposed \(S\), compute the original maximum independent-set weight by interval scheduling. Compute the weight and number of optimum independent schedules after deleting \(S\), with the number capped at two. The usual left-to-right dynamic program on intervals sorted by right endpoint suffices. Its include and omit branches are disjoint sets of schedules. At a tie in optimum weight add their counts and cap the result at two. Accept the certificate if the weight is unchanged and the count is one. This is polynomial time and proves Theorem 1.

For the approximation claim fix \(0<\varepsilon<1\) and an integer \(a>3/\varepsilon\), and take \(M=n^a\). For sufficiently large \(n\), the hypotheses of Lemma 4 hold and \(N=O(n^{a+2})\). On colorable inputs an \(N^{1-\varepsilon}\)-approximation would return a valid preassignment of size at most \(2nN^{1-\varepsilon}\). The exponent comparison
\[
1+(a+2)(1-\varepsilon)<a
\]
follows from \(a\varepsilon>3\). Thus this returned size is strictly less than \(M-1\) for all sufficiently large \(n\). On noncolorable inputs every valid preassignment has size at least \(M-1\). The approximation would decide 3-colorability using its returned cardinality. The finitely many smaller graph sizes can be handled by exhaustive coloring, since the cutoff depends only on \(\varepsilon\). For fixed \(\varepsilon\) the construction remains polynomial and keeps all endpoint and weight restrictions. This proves Theorem 2.

## 5. A minimum cut when the intended optimum is known

The empty interval instance has one empty optimum and requires no preassignment. For a nonempty instance, translate its weighted interval representation back to paths. For each distinct endpoint \(x\), make two consecutive time vertices \(x^-,x^+\) in that order, ordered globally by \(x\). Put a zero-weight idle edge between every consecutive pair of time vertices. For interval \([a,b]\), include a distinct weighted edge from \(a^-\) to \(b^+\). The first and last time vertices serve as source and sink. A path corresponds bijectively to an independent schedule. Its chosen interval edges are mutually compatible because one can travel from \(b^+\) to the next \(a^-\) only if the next left endpoint is greater than \(b\). The idle segments between consecutive chosen intervals are uniquely determined. This holds also for identical interval labels and zero-length intervals, with positive weight on each interval edge.

Let \(d_s(v)\) and \(d_t(v)\) be the longest prefix and suffix weights from the source and to the sink. Write \(W=d_s(t)\). Keep precisely the edges \((u,v)\) of weight \(w\) with \(d_s(u)+w+d_t(v)=W\). Each such edge satisfies \(d_s(v)=d_s(u)+w\), because otherwise a better prefix followed by the best suffix would exceed \(W\). Every \(s\)-to-\(t\) path made of these edges has weight \(W\) by telescoping. Conversely every optimum path uses only these edges, since each of its edges lies on a path of weight \(W\). Thus this subgraph represents exactly the original optimum schedules. Preassignment may delete interval edges. Idle edges are undeletable, and an interval edge outside the retained graph can have no effect on the original optimum family.

Fix the path \(P\) corresponding to the required optimum independent schedule, namely the complement of the specified cover. No edge of \(P\) may be deleted. Every extra path can follow \(P\) except for at least one segment between two vertices of \(P\). More precisely, the first departure from \(P\) and the next visit to \(P\) in any alternative give a directed detour with all interior vertices outside \(P\), or a one-edge detour directly between its vertices. This remains true with parallel edges, since taking an edge other than the specified path edge already changes the schedule. Conversely any intact detour between two vertices of \(P\) yields an alternative by replacing the corresponding segment, in their topological order. Therefore we must delete all direct nonpath edges between vertices of \(P\), and separate the other detours.

For this separation construct a network on vertices outside \(P\), with a new source and sink. Keep all edges between outside vertices. Every nonpath edge from \(P\) to an outside vertex gives an edge from the new source, and every edge from an outside vertex to \(P\) gives an edge to the new sink. Preserve an individual capacity-one arc for each eligible interval deletion and give idle edges capacity \(N+1\). In this network source-to-sink paths are exactly the detours with at least one interior vertex. Their endpoints in \(P\) must be in increasing topological order in the original graph. A minimum cut deletes all such detours with minimum cost, in addition to the forced direct deletions.

Removing every interval outside the fixed schedule leaves no other original optimum. Indeed, any other remaining schedule would be a proper subset with strictly smaller weight, and the idle arcs alone provide no multiplicity for a fixed schedule. Thus a feasible cut costs at most \(N\) and there is no forced direct idle deletion. Using capacity \(N+1\) correctly excludes idle arcs. The original scheduling graph, longest paths, and auxiliary flow can all be computed in polynomial time. This proves Proposition 3.

## 6. Source comparison and scope

The unweighted interval result of [1] gives a local exchange simplification, and it does not handle varying weights. The present reduction shows that positive weights allow the optimum schedules to encode general acyclic source-to-sink paths. The size gap uses edge-disjoint shortcut groups to control both possible forms of the chosen path. The fixed-target cut makes precise which optimization remains tractable. All complexity statements use ordinary finite graph and integer data and do not require any assumption on the quality of an interval representation returned by a recognition algorithm.

## Reference

1. *Complexity of unique minimum vertex cover preassignment on chordal and interval graphs* (Chinese manuscript), earlier research manuscript at  (archived version), especially Sections 1–4.
