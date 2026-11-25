# Assignment bounds and constant-factor algorithms for bounded-hop independent-set reconfiguration

Wen Weixiang · AI-assisted research manuscript

24 November 2026

**Status.** This AI-assisted research manuscript presents written proofs and an algorithmic construction. It has not undergone external peer review or end-to-end formal verification. The computational programs and raw outputs are not included in this version.

## Abstract

Let two equal-size independent sets of a connected graph be given. A legal $k$-jump replaces one occupied vertex by an unoccupied vertex at graph distance at most $k$, while preserving independence. For every integer $k\geq3$, we give a polynomial-time algorithm that outputs an actual reconfiguration sequence whenever the subgraph induced by the symmetric difference of the endpoints is a forest. This condition holds, in particular, for all endpoint pairs in an even-hole-free graph. The approximation factors are $3$ for $k=3$, $2$ for $k=4$, $5/3$ for $k=5$, and $3/2$ for $k\geq6$.

The construction combines a quantitative form of the known bounded-hop simulation argument with a weighted exchange-ordering lemma. Two assignment problems give independently checkable integer bounds $W\leq\operatorname{OPT}_k\leq L\leq U\leq\alpha_k W$, where $L$ is the length of the sequence actually returned. Integer assignment duals certify the two optima. An explicit path family has $\operatorname{OPT}_k/W=3/2$, showing a limitation of this lower bound. The result supplies a nontrivial approximation guarantee for the even-hole-free problem posed in the concluding section of Hatano, Kitamura, Izumi, Ito and Masuzawa [1]. No claim is made about the optimal approximation factor or the unresolved exact two-jump problem on split graphs.

## 1. Problem, scope and attribution

Let $G=(V,E)$ be a finite, connected, undirected simple graph, with $n\geq1$ vertices. Write $d(u,v)$ for its ordinary unweighted shortest-path distance. An independent set is a set with no internal edge. Given independent sets $I,J$ of the same cardinality, a reconfiguration sequence is

$$
I=I_0,I_1,\ldots,I_L=J,
$$

where each step has the form

$$
I_{h+1}=I_h-\{u\}+\{v\},\qquad
u\in I_h,\ v\notin I_h,\quad d(u,v)\leq k,
$$

and every $I_h$ is independent. The distance is measured in the original graph. Intermediate vertices on a shortest graph path are not required to be empty: a jump is one replacement, not a series of token-sliding moves. Tokens are indistinguishable. Denote the minimum possible length by $\operatorname{OPT}_k(I,J)$.

A token-jumping, or TJ, exchange imposes only the independence condition, with no hop bound. The bounded-hop rule and the qualitative simulation of TJ by $k$-jumps for $k\geq3$ are due to [1]. The forest condition on the endpoint difference, and exact shortest unweighted TJ reconfiguration under that condition, are already present in [2, Section 5.1]. They imply the earlier exact shortest-TJ result for even-hole-free graphs. Our proofs below are self-contained; neither that forest observation nor the qualitative simulation is claimed as new. The new contribution claimed within the recorded search scope is the weighted ordering and quantitative assignment construction yielding the explicit constant-factor guarantees and their certificates.

We address the approximation direction in [1] by modifying the selection of unrestricted exchanges: their graph distances enter the assignment costs before bounded-hop simulation. We do not claim that an arbitrary unweighted exchange ordering from the earlier TJ algorithm has the factors proved here.

Distance-dependent jump costs and cost-length Pareto optimization were already studied by Takada et al. [3]. Their general answer set programming approach concerns exact optimization and computational experiments. Here the objective is a polynomial-time approximation guarantee under a structural graph condition, rather than a new cost model.

An **even hole** is an induced cycle of even length at least four. A graph is even-hole-free if it has no even hole. Put

$$
A=I\setminus J,\qquad B=J\setminus I,\qquad r=|A|=|B|.
$$

The hypothesis needed in the proofs is the weaker endpoint condition

$$
G[A\cup B]\text{ is a forest}. \tag{F}
$$

The graph in (F) is bipartite, with parts $A$ and $B$. If an even-hole-free $G$ violated (F), a shortest cycle in this bipartite induced subgraph would be chordless and even, and would also be an induced cycle of $G$. Thus every equal-size endpoint pair in an even-hole-free graph satisfies (F).

The algorithm checks (F) directly. It does not require recognition of the entire even-hole-free graph class, and it also applies to graphs with even holes elsewhere. Connectedness is an assumption throughout the main statement. The case $I=J$ has optimum zero and is handled by the empty sequence.

## 2. Main theorem

For positive integers $d$ and $k\geq3$, define

$$
c_k(d)=\left\lceil\frac d k\right\rceil,
\qquad
f_k(d)=\max\left\{1,
\left\lceil\frac{d-2}{k-2}\right\rceil\right\}.
\tag{1}
$$

For $r>0$, let

$$
W=\min_{\pi:A\to B\ \mathrm{bijection}}
\sum_{a\in A}c_k(d(a,\pi(a))),
\tag{2}
$$

and

$$
U=\min_{\pi:A\to B\ \mathrm{bijection}}
\sum_{a\in A}f_k(d(a,\pi(a))).
\tag{3}
$$

Set $W=U=0$ for $r=0$. Define

$$
\alpha_k=
\begin{cases}
3,& k=3,\\
2,& k=4,\\
5/3,& k=5,\\
3/2,& k\geq6.
\end{cases}
\tag{4}
$$

**Theorem 1.** Assume (F). For every integer $k\geq3$, a polynomial-time algorithm constructs a legal $k$-jump sequence of length $L$ such that

$$
W\leq\operatorname{OPT}_k(I,J)
\leq L\leq U\leq\alpha_k W.
\tag{5}
$$

In an adjacency-matrix implementation, the algorithm uses $O(n^3)$ elementary operations and $O(n^2)$ memory, including an output of at most $r\max\{1,n-3\}$ moves. For $k\geq\operatorname{diam}(G)$, it returns an optimal sequence of exactly $r$ moves.

Consequently, (4) gives approximation guarantees for every connected even-hole-free graph, including every connected chordal or split graph, for $k\geq3$. The constants are proved upper guarantees. They are not asserted to be optimal approximation thresholds.

## 3. A quantitative local simulation

The following lemma refines the qualitative construction in the proof of Lemma 1 of [1]. The underlying blocker-exchange mechanism is from that work; here we track its exact recurrence and use it quantitatively.

**Lemma 2.** Let $K$ be independent, $s\in K$, and $t\notin K$. Assume $K-\{s\}+\{t\}$ is independent. For $k\geq3$, the TJ exchange $s\mapsto t$ can be simulated by at most $f_k(d(s,t))$ legal $k$-jumps. At the end, the occupancy of every vertex other than $s,t$ is restored.

**Proof.** We induct on $\ell=d(s,t)$. If $\ell\leq k$, perform the exchange directly. Its cost is one, which equals $f_k(\ell)$.

Suppose $\ell>k$. Choose a shortest graph path

$$
s=u_0,u_1,\ldots,u_\ell=t,
$$

and put $x=u_{\ell-k+1}$. Then

$$
d(s,x)=\ell-k+1\geq2,
\qquad d(x,t)=k-1.
\tag{6}
$$

There are two cases.

**Case 1: $x$ is unoccupied and has no occupied neighbor.** The exchange $s\mapsto x$ is a valid TJ exchange. First simulate it by induction; then move the token at $x$ directly to $t$. This last move has length $k-1$ and leaves exactly the independent set $K-\{s\}+\{t\}$. The induction is applied to a strictly smaller graph distance, at most $\ell-k+2$.

**Case 2: $x$ is occupied or has an occupied neighbor.** Choose an occupied vertex $z\in\{x\}\cup N_G(x)$. Because $d(s,x)\geq2$, we have $z\ne s$. Also,

$$
d(z,t)\leq k,
\qquad d(s,z)\leq\ell-k+2<\ell.
\tag{7}
$$

The target $t$ has no occupied neighbor in $K$: any such neighbor would have to be $s$ by the assumed legality of the original TJ exchange, whereas $d(s,t)>k\geq3$ rules that out. Thus the move $z\mapsto t$ is a legal $k$-jump. In the resulting independent set $K'=K-\{z\}+\{t\}$, the TJ exchange $s\mapsto z$ is legal, since

$$
K'-\{s\}+\{z\}=K-\{s\}+\{t\}.
$$

Apply induction to $s\mapsto z$. The required final occupancies are restored.

In both cases, one direct move is used, and the remaining recursive exchange has positive distance $\ell'\leq\ell-(k-2)$. For $\ell>k$,

$$
f_k(\ell')\leq
\left\lceil\frac{\ell-k}{k-2}\right\rceil
=f_k(\ell)-1.
\tag{8}
$$

The right side of the first inequality is at least one, so the maximum with one in (1) causes no exception. This proves the bound and the occupancy statement. $\square$

The simulation may temporarily move tokens that belong to $I\cap J$, or to other matched pairs. Lemma 2 restores every such occupancy before the next TJ exchange. Treating these tokens as immovable would be incorrect.

## 4. Weighted matching can be ordered without conflicts

The next lemma is the step that permits assignment costs to control an actual feasible sequence. A minimum-cost assignment alone does not generally supply a legal order: a target may be adjacent to another source that has not yet moved.

**Lemma 3.** Assume (F). Let $w:A\times B\to\mathbb R$ satisfy

$$
w(a,b)\geq1\quad\text{for all }a,b,
\qquad w(a,b)=1\quad\text{if }ab\in E.
\tag{9}
$$

Choose a minimum-total-weight bijection $\pi:A\to B$. Among all such bijections, maximize the number of its pairs that are graph edges. Then the exchanges $a\mapsto\pi(a)$ admit an ordering in which every exchange is a valid TJ move.

**Proof.** Index the matched pairs by $i=1,\ldots,r$ as $(a_i,b_i)$. Construct a directed graph $D$ on these indices, placing an arc $i\to j$ when $i\ne j$ and $a_i b_j\in E$. The interpretation is that $a_i$ must be vacated before $b_j$ is occupied.

We show $D$ is acyclic. Suppose it has a directed cycle of distinct indices $i_1,\ldots,i_h$, where $h\geq2$. Reassign the sources on the cycle by matching $a_{i_j}$ to $b_{i_{j+1}}$, with indices taken cyclically. Each new pair is a graph edge, so the new total weight on the cycle is $h$. The old total weight is at least $h$.

If it is greater than $h$, the reassignment contradicts minimum total weight. If it equals $h$ and some old pair is not a graph edge, the reassignment preserves weight and increases the number of matched graph edges, contradicting the secondary choice. The only remaining possibility is that all old pairs on the cycle are graph edges as well. The old matching edges and the new matching edges then form a cycle of length $2h$ in $G[A\cup B]$. Their vertices are distinct and their edges alternate. This contradicts (F). Therefore $D$ is acyclic.

Execute the matched exchanges in any topological ordering of $D$. At the moment $a_j\mapsto b_j$ is performed, every other original source adjacent to $b_j$ has already been removed. Previously occupied targets do not neighbor $b_j$, since $J$ is independent. No vertex in $I\cap J$ neighbors $b_j$, for the same reason. Its own source $a_j$, if adjacent, is removed by this exchange. Consequently every resulting set is independent. $\square$

In our application, $w(a,b)=f_k(d(a,b))$. These are positive integers satisfying (9). A single assignment computation enforces the secondary condition: minimize the integer costs

$$
\widehat w(a,b)=(r+1)f_k(d(a,b))-\mathbf1_{\{ab\in E\}}.
\tag{10}
$$

A change of one in the primary total outweighs every possible change in the number of adjacent pairs, which is at most $r$. Thus a minimizer of (10) has primary optimum $U$ and the required secondary optimum.

Apply Lemma 2 to each exchange in the topological order supplied by Lemma 3. Because each simulation restores all other occupancies, the next ordered exchange remains valid. The resulting sequence has length

$$
L\leq\sum_{a\in A}f_k(d(a,\pi(a)))=U.
\tag{11}
$$

## 5. The assignment lower bound

**Lemma 4.** For every connected graph and every legal $k$-jump sequence between $I$ and $J$, its length is at least $W$. The forest hypothesis is unnecessary for this lower bound.

**Proof.** Represent each move $u\mapsto v$ by a directed unit of flow from $u$ to $v$. Summing all moves, the net outgoing minus incoming flow equals one on $A$, minus one on $B$, and zero elsewhere. In particular, common endpoint vertices have zero net balance even when their tokens move during the sequence.

An integral flow with these balances decomposes into directed paths pairing the unit sources $A$ with the unit sinks $B$, together with directed cycles. Discard the cycles. A path with $h$ moves has endpoints at graph distance at most $kh$, by the triangle inequality. Hence it has at least $c_k(d(a,b))$ moves. Summing over the pairing gives a total at least $W$, and it is no greater than the number of moves in the original sequence. $\square$

Equivalently, $c_k(d(u,v))$, extended to zero at $u=v$, is the graph metric of the $k$th power of $G$. Formula (2) is its minimum transportation cost between the two different endpoint occupancies. The flow argument explains why it remains a valid lower bound when common endpoint tokens are moved. It would not suffice to assume that these tokens keep their original identities or positions.

## 6. Approximation factors and proof of Theorem 1

Let $q=c_k(d)$ for a positive distance $d$. Since $d\leq kq$,

$$
f_k(d)
\leq q+\left\lceil\frac{2(q-1)}{k-2}\right\rceil.
\tag{12}
$$

This yields the following bounds, with no asymptotic rounding convention:

| Hop bound | Bound for $f_k(d)$ in terms of $q=c_k(d)$ |
| --- | --- |
| $k=3$ | $3q-2\leq3q$ |
| $k=4$ | $2q-1\leq2q$ |
| $k=5$ | $\lfloor5q/3\rfloor\leq5q/3$ |
| $k\geq6$ | $q+\lfloor q/2\rfloor\leq3q/2$ |

For the last line, $k-2\geq4$ implies

$$
\left\lceil\frac{2(q-1)}{k-2}\right\rceil
\leq\left\lceil\frac{q-1}{2}\right\rceil
=\lfloor q/2\rfloor.
$$

Thus $f_k(d)\leq\alpha_k c_k(d)$ in all cases. Apply this pointwise inequality to a bijection attaining $W$, and then minimize the $f_k$-cost:

$$
U\leq
\sum_{a\in A}f_k(d(a,\pi_W(a)))
\leq\alpha_k W.
\tag{13}
$$

Lemma 4, the feasibility of the constructed sequence, (11), and (13) prove (5).

The simpler expression $k/(k-2)$ is **not** a valid factor for all $k$. For example, at $k=7$ and $d=14$, $f_k(d)=3$ and $c_k(d)=2$, giving $3/2>7/5$. The piecewise constants in (4) retain this integer effect.

For the running time, all-pairs graph distances are obtained by breadth-first search in $O(n(n+|E|))$ time and stored in $O(n^2)$ space. Two square assignment problems have order $r\leq n$ and take $O(r^3)$ time by an integer Hungarian implementation. The dependency graph and its topological order take $O(r^2)$ time. Each recursion in Lemma 2 performs one move and recurses on only one smaller-distance exchange. A shortest-path position $x$ can be found by scanning the distance matrix for

$$
d(s,x)=\ell-k+1,\qquad d(x,t)=k-1,
$$

in $O(n)$ time; finding a blocker also takes $O(n)$ time. Since $d\leq n-1$ and $k\geq3$, every local simulation has at most $\max\{1,n-3\}$ moves. The total simulation time is therefore $O(n^3)$, with $O(n^2)$ stored moves. This is an elementary-operation bound; integer costs have polynomial encoding length. If $k$ is at least the graph diameter, every exchange is direct while retaining the original input $k$; no capping of $k$ is needed.

Finally, when $k\geq\operatorname{diam}(G)$, both costs in (1) equal one on every pair in $A\times B$. Hence $U=W=r$, and each ordered exchange is already a legal $k$-jump. At least $r$ moves are necessary to change the endpoint occupancy, so the returned sequence is optimal. This finishes the proof. $\square$

## 7. A sharp limitation of the transportation lower bound

The forest condition does not make $W$ exact. Even a path can have a permanent multiplicative gap.

**Proposition 5.** For every integer $k\geq3$, there is a path instance satisfying (F) with

$$
W=2,\qquad\operatorname{OPT}_k=3.
\tag{14}
$$

**Proof.** Let $G$ be the path with vertices $0,1,\ldots,2k$ in order, and take

$$
I=\{0,k-1\},\qquad J=\{k-1,2k\}.
$$

Both sets are independent, and their symmetric difference is the two-vertex set $\{0,2k\}$. Formula (2) gives $W=\lceil2k/k\rceil=2$.

There is no two-move sequence. If the same token makes both moves, the other token remains at $k-1$. A two-hop route from $0$ to $2k$ with both hops at most $k$ must use the unique intermediate vertex $k$, which neighbors the stationary token at $k-1$ and is forbidden. If the two tokens move once each, the token originally at $k-1$ must reach $2k$ in one move, requiring distance $k+1>k$. These cases exhaust a two-move sequence. A single move is also impossible.

The following three moves are legal:

$$
(k-1)\mapsto(2k-1),\qquad
0\mapsto(k-1),\qquad
(2k-1)\mapsto2k.
\tag{15}
$$

Their respective graph distances are $k,k-1,1$, and the two occupied vertices are nonadjacent after every step. Thus the optimum is three. $\square$

Consequently, no universal proof of an output bound $L\leq\beta W$ can have $\beta<3/2$, even on paths. For $k\geq6$, the factor in (5) meets this limitation of the chosen certificate. This is not an approximation-hardness result: in this example a three-move algorithm is optimal, and a stronger lower bound could support a different approximation analysis.

## 8. Executable construction and verification interface

The reference implementation is `code/solver.py` and uses only the Python standard library. Its input is a connected simple graph, two equal-size independent sets, and an integer $k\geq3$. It rejects inputs that fail these conditions or (F). No recognition claim for general even-hole-free graphs is built into the program.

The construction has the following stages:

1. Compute all-pairs distances and the different endpoint sets $A,B$.
2. Compute a minimum assignment for $c_k$ and retain its integer dual potentials, giving $W$.
3. Compute a minimum assignment for (10), again retaining integer dual potentials, giving $U$ and the required secondary choice.
4. Build the dependency digraph and compute a topological ordering.
5. Simulate each ordered TJ exchange with the procedure in Lemma 2, using an explicit task stack to avoid recursion-depth restrictions.
6. Return the move list, its length $L$, both assignments, both duals, and the parameters of the approximation certificate.

For either assignment cost matrix $C$, the returned row and column potentials $p_i,q_j$ satisfy

$$
p_i+q_j\leq C_{ij}
\quad\text{for every }i,j,
\qquad
p_i+q_{\pi(i)}=C_{i,\pi(i)}
\quad\text{on the matching}.
\tag{16}
$$

Summing these inequalities proves the optimality of the matching without trusting the implementation of the optimization algorithm. For the upper certificate, $C$ is the lexicographic integer cost (10); optimality therefore certifies the primary value $U$ and the edge-count tie-break. The move list can independently be checked for endpoints, hop distances, occupancy, and independence. The separately reported verifier enumerates small reconfiguration graphs directly; its program and raw results are not included in this version. Such checks supplement, rather than replace, the general proofs above.

As a small example, use the path on vertices $0,\ldots,10$, endpoints $I=\{0,3,6\}$ and $J=\{4,7,10\}$, and $k=3$. The solver returns a six-move sequence and the exact certificate $W=U=6$. Thus this instance is solved optimally, even though the uniform three-hop guarantee is a factor of three.

## 9. Conclusions and precise limitations

The forest structure of the endpoint conflict graph permits weighted assignments to be ordered into feasible exchanges. Quantifying bounded-hop simulation then gives explicit constant-factor algorithms for the even-hole-free problem of [1], together with independently checkable lower and upper bounds for each instance.

The construction requires $k\geq3$. It does not settle exact shortest two-jump reconfiguration on split graphs, nor two-jump reachability on chordal graphs. It does not characterize the best possible approximation factors for $k\geq3$. The $3/2$ path family concerns the strength of $W$, not computational hardness. The claim of distinctness is restricted to the actual bibliographic comparison recorded with this case; worldwide priority is not asserted.

## References

[1] H. Hatano, N. Kitamura, T. Izumi, T. Ito and T. Masuzawa. *Independent set reconfiguration under bounded-hop token jumping*. Theoretical Computer Science 1062 (2026), 115651. DOI: [10.1016/j.tcs.2025.115651](https://doi.org/10.1016/j.tcs.2025.115651). Author version: [arXiv:2407.11768v2](https://arxiv.org/abs/2407.11768v2), 17 May 2026. The qualitative simulation is Lemma 1; the target approximation question is the third item of Section 6.

[2] M. Kamiński, P. Medvedev and M. Milanič. *Complexity of independent set reconfigurability problems*. Theoretical Computer Science 439 (2012), 9–15. DOI: [10.1016/j.tcs.2012.03.004](https://doi.org/10.1016/j.tcs.2012.03.004). The inspected author manuscript is *Shortest paths between shortest paths and independent sets*, [arXiv:1008.4563v3](https://arxiv.org/abs/1008.4563v3), 7 February 2011, Section 5.1. This is the earlier forest-difference and even-hole-free shortest-TJ result cited by [1]; the weighted ordering and finite-hop constants are proved separately here.

[3] K. Takada, M. Banbara, T. Ito, J. Kawahara, S. Minato, T. Schaub and R. Uehara. *Multi-Objective Combinatorial Reconfiguration considering Cost and Length by Answer Set Programming: Algorithms, Encodings, and Empirical Analysis*. ECAI 2025. DOI: [10.3233/FAIA250982](https://doi.org/10.3233/FAIA250982). The publisher page separately records first online publication as 25 August 2026; Sections 2–5 and 7–8 were inspected.
