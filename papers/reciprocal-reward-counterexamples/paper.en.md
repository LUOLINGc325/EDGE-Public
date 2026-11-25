# Reciprocal-reward strategies in hypergraph search

*A smallest counterexample and the sharp five-sixths guarantee for graphs*

24 November 2026

# Abstract

Lidbetter and Lin proposed that a booby-trap search game on any hypergraph admits an optimal strategy whose positive probabilities are proportional to the reciprocals of the hyperedge rewards. We refute Conjecture 15 of their author manuscript with four vertices, four hyperedges, one trap, and unit vertex rewards. The game value is $12/13$, whereas the best strategy of the proposed form guarantees only $3/4$. Both optimal players' strategies are unique. Four vertices and four allowed actions are each minimal among hypergraphs with positive vertex rewards. An explicit family has a restricted-to-optimal value ratio tending to $1/2$; this is an upper limitation on a possible general guarantee, not a universal lower bound. For ordinary simple graphs with unit vertex rewards and one trap, we prove the sharp universal guarantee $V_{\mathrm{rec}}\ge(5/6)V$. A connected five-vertex graph attains equality and is smallest in that graph class. The proof uses the classical half-integral structure of fractional matchings, for which a self-contained argument is included. Exact rational certificates, independent implementations, and the boundaries of the literature and verification checks accompany this research draft.

# 1. Question, model, and scope

Let $\mathcal H=(V,\mathcal E)$ be a finite hypergraph with a nonempty family of nonempty allowed edges, $\varnothing\ne\mathcal E\subseteq2^V\setminus\{\varnothing\}$. Vertex $v$ has reward $w_v>0$, and $R_e=\sum_{v\in e}w_v$ for every nonempty allowed hyperedge $e$. The Hider places one trap at a vertex $v$. The Searcher chooses exactly one allowed hyperedge $e$. The Searcher's payoff is

$$A_{e,v}=R_e\,\mathbf 1_{\{v\notin e\}}.$$

The Searcher maximizes and the Hider minimizes the expected payoff. For a probability vector $p$ on $\mathcal E$, write

$$G(p)=\min_{v\in V}\sum_{e\in\mathcal E}p_eA_{e,v},\qquad V(\mathcal H)=\max_pG(p).$$

The one-trap case already suffices to refute the conjecture, which was stated for an arbitrary number of traps. Later, when discussing minimality for three vertices, we explicitly include the other possible trap count.

For a nonempty support $F\subseteq\mathcal E$, its **reciprocal-reward strategy** is

$$p_e^F=\frac{\mathbf 1_{\{e\in F\}}}{R_e\sum_{f\in F}R_f^{-1}}.$$

Set $V_{\mathrm{rec}}(\mathcal H)=\max_{\varnothing\ne F\subseteq\mathcal E}G(p^F)$. If

$$a(F)=\min_{v\in V}|\{e\in F:v\notin e\}|,$$

then direct substitution gives the exact identity

$$G(p^F)=\frac{a(F)}{\sum_{e\in F}R_e^{-1}}. \tag{1}$$

This identity is the content underlying Proposition 14 of [LL20]. Conjecture 15 asserts the existence of a support attaining $V$, or equivalently $V_{\mathrm{rec}}=V$. The model allows an arbitrary family of permitted subsets. It does not require that all subsets of a permitted set also be permitted. Our examples therefore address the conjecture as stated for arbitrary hypergraphs; they do not contradict the separate results of [LL20] for complete hypergraphs or singleton-only strategy spaces.

The source's full author manuscript, marked arXiv:1903.12231v2, was read through its author-uploaded copy. The publisher record and author institutional publication list independently verify the journal, authors, and DOI. Direct retrieval of the publisher's full text and the arXiv PDF failed in this run. Consequently the exact conjecture attribution is explicitly to the verified author-manuscript version.

# 2. A four-vertex counterexample

Take $V=\{0,1,2,3\}$, all $w_v=1$, and

$$\mathcal E=\{\{0,1\},\{0,2\},\{0,3\},\{1,2,3\}\}.$$

In this order of hyperedges and the vertex order $0,1,2,3$, the payoff matrix is

$$A=\begin{pmatrix}0&0&2&2\\0&2&0&2\\0&2&2&0\\3&0&0&0\end{pmatrix}. \tag{2}$$

**Theorem 1.** The unique optimal Searcher and Hider strategies are respectively

$$p_*=(3,3,3,4)/13,\qquad q_*=(4,3,3,3)/13.$$

The game value is $V=12/13$, whereas $V_{\mathrm{rec}}=3/4$. Hence Conjecture 15 is false.

**Proof.** Multiplication gives

$$p_*^{\mathsf T}A=(12/13,12/13,12/13,12/13),\qquad Aq_*=(12/13,12/13,12/13,12/13)^{\mathsf T}.$$

The first equality guarantees $12/13$ against every trap position. The second bounds every Searcher mixed strategy by $12/13$. These statements follow by taking convex combinations of the displayed inequalities; no numerical optimization is being used as a proof.

Because every component of $q_*$ is positive, any optimal $p$ must have payoff exactly $12/13$ in each column. The first column forces $p_4=4/13$. The other three force the first three probabilities to be equal, hence each is $3/13$. The same argument, using positivity of $p_*$, proves uniqueness of $q_*$.

For reciprocal strategies, a support without $\{1,2,3\}$ has value zero: the Hider chooses vertex $0$. A support containing the large edge and $s$ of the three pair edges has value zero for $s=0,1$. For $s=2,3$, the minimum number of safe edges is one, and (1) gives

$$G(p^F)=\frac{1}{s/2+1/3}=\frac6{3s+2}.$$

The maximum is $3/4$, attained at $s=2$. These cases exhaust all 15 nonempty supports. The strict gap is $9/52$, and $V_{\mathrm{rec}}/V=13/16$. $\square$

The counterexample has a connected incidence structure and strictly positive rewards. Its failure is not caused by zero-reward actions or a disconnected game. The next proposition also removes the possibility that equality of the rewards is responsible.

**Proposition 2 (robustness).** On the same hypergraph, suppose every vertex reward lies in $[1-\varepsilon,1+\varepsilon]$, where $0\le\varepsilon<3/29$. Then $V_{\mathrm{rec}}<V$.

**Proof.** Every nonzero payoff is at least $1-\varepsilon$ times its value in (2). Thus the fixed strategy $p_*$ guarantees at least $(1-\varepsilon)12/13$. For every support, its edge rewards are at most $1+\varepsilon$ times their unit-reward values. Formula (1) therefore bounds its reciprocal-strategy payoff by $1+\varepsilon$ times its unit-reward payoff. Maximizing over supports gives

$$V-V_{\mathrm{rec}}\ge \frac{12(1-\varepsilon)}{13}-\frac{3(1+\varepsilon)}4=\frac{9-87\varepsilon}{52}>0.$$

In particular, an open set of pairwise distinct positive rewards gives counterexamples. $\square$

# 3. An infinite family and an asymptotic loss of one half

For an integer $m\ge3$, let the vertices be $0,1,\ldots,m$, all with reward one. The allowed edges are

$$e_i=\{0,i\}\quad(1\le i\le m),\qquad e_\circ=\{1,\ldots,m\}.$$

Put $D_m=m^2+2m-2$.

**Theorem 3.** This game has unique optimal strategies

$$p_*(e_i)=\frac m{D_m},\quad p_*(e_\circ)=\frac{2(m-1)}{D_m},$$

$$q_*(0)=\frac{2(m-1)}{D_m},\quad q_*(i)=\frac m{D_m}\quad(1\le i\le m).$$

Its unrestricted and reciprocal values are

$$V_m=\frac{2m(m-1)}{D_m},\qquad W_m=\frac m{m+1}.$$ 

Consequently

$$V_m-W_m=\frac{m^2(m-2)}{D_m(m+1)}>0,\qquad \frac{W_m}{V_m}=\frac{D_m}{2(m^2-1)}\longrightarrow\frac12. \tag{3}$$

**Proof.** Both displayed strategies have total mass one. Against a trap at $0$, the Searcher receives $m p_*(e_\circ)=V_m$. Against a trap at leaf $j$, exactly the $m-1$ other pair edges survive, giving $2(m-1)m/D_m=V_m$. Against $q_*$, the large edge has expected reward $m q_*(0)=V_m$, and any pair edge has expected reward

$$2(1-q_*(0)-q_*(i))=2\frac{D_m-2(m-1)-m}{D_m}=V_m.$$

Thus these strategies are a saddle point. All their entries are positive. Equality against all pure strategies forces the large-edge probability and all pair-edge probabilities to be the stated values, and likewise for the Hider. This proves uniqueness.

For a reciprocal support not containing the large edge, the trap at $0$ yields zero. If it contains the large edge and $s$ pair edges, then $s=0,1$ again gives zero. For $2\le s\le m$, the Hider at $0$ leaves exactly one safe edge, and no trap leaves fewer. Formula (1) yields

$$G(p^F)=\frac{1}{s/2+1/m}=\frac{2m}{ms+2}.$$

This decreases strictly with $s$, so $s=2$ is optimal and gives $W_m=m/(m+1)$. The remaining claims are direct algebra. $\square$

At $m=2$ the two values coincide; the counterexample condition $m\ge3$ is essential. Equation (3) does **not** establish a one-half lower guarantee over all hypergraphs. It only rules out any universal guarantee strictly larger than one half for this strategy restriction.

# 4. Minimality in vertices and allowed actions

**Lemma (small positive bases).** If $B$ is an invertible zero-one square matrix of order $s\le3$ and $Bx=\mathbf1$ has all entries of $x$ strictly positive, then its entries are either all one or all $1/2$.

**Proof.** For order one the claim is immediate. For order two an invertible zero-one matrix has a singleton row; it fixes one variable to one, and positivity forces the other tight row to contain only the other variable, also equal to one. For order three, a singleton row similarly fixes a variable to one. Every other tight row that contains it would have to contain no other positive variable, duplicating that row. Thus the other two independent rows avoid that variable, reducing to order two. If there is no singleton row, every row has two or three ones. A three-one row cannot coexist with a distinct two-one row at a strictly positive solution: the latter sum is strictly smaller. Three identical rows are singular. Hence all three rows have two ones, and invertibility forces the three distinct pairs. Their solution is $(1/2,1/2,1/2)$. $\square$

**Theorem 4.** With positive vertex rewards and at least one nonempty allowed edge, a reciprocal-reward optimum exists whenever either (i) there are at most three vertices, for any admissible trap count, or (ii) there are at most three allowed Searcher actions, for any number of vertices and any admissible trap count. Thus Theorem 1 is smallest both in vertices and in allowed actions.

**Proof.** Here let the Hider place $k$ traps, and index rows by its $k$-element sets $H$. For an edge $e$ put $B_{H,e}=\mathbf1_{\{H\cap e=\varnothing\}}$ and $c_e=1/R_e>0$. Delete identically zero-payoff actions unless the game value is zero. If the value is zero, any single allowed positive-reward edge is an optimal reciprocal strategy, so assume $V>0$.

The covering linear program

$$\tau=\min\left\{\sum_e c_e x_e: Bx\ge\mathbf1,\ x\ge0\right\} \tag{4}$$

satisfies $V=1/\tau$. Indeed, a strategy guaranteeing $v>0$ gives the feasible point $x_e=p_eR_e/v$ of cost $1/v$. Conversely a feasible $x$ of cost $C$ gives probabilities $p_e=c_e x_e/C$ and guarantees at least $1/C$. Positive costs ensure that the minimum is attained, and an optimum can be chosen at a vertex of this pointed polyhedron.

A vertex with $s$ positive entries has $s$ linearly independent tight covering rows on those entries; otherwise a small perturbation in both directions preserves all constraints. If there are at most three Searcher actions then $s\le3$. If there are at most three vertices then the number of Hider actions is $\binom n k\le3$, so again $s\le3$. The small-positive-bases lemma makes every positive entry of this optimal $x$ a common constant. Reconstructing $p_e=c_e x_e/\tau$ therefore gives $p_e\propto1/R_e$ on its support. $\square$

The zero-one basis classification is also exhaustively checked with exact rational arithmetic. Minimality is not inferred from a floating-point search over examples.

# 5. Graphs: the role of fractional matching

From this section onward $G=(V,E)$ is a finite simple graph with at least one edge, all vertex rewards are one, and there is one trap. Thus all edge rewards are two, and reciprocal strategies are precisely uniform distributions on nonempty edge subsets.

Define the fractional matching number

$$\nu_f(G)=\max\left\{\sum_{e\in E}x_e:x_e\ge0,\ \sum_{e\ni v}x_e\le1\ (v\in V)\right\},$$

and the support density

$$\beta(G)=\max_{\varnothing\ne F\subseteq E}\frac{|F|}{\Delta(F)},$$

where $\Delta(F)$ is the maximum degree in the spanning subgraph with edge set $F$. Isolated vertices are allowed.

**Proposition 5.**

$$V(G)=2\left(1-\frac1{\nu_f(G)}\right),\qquad V_{\mathrm{rec}}(G)=2\left(1-\frac1{\beta(G)}\right). \tag{5}$$

Every optimal Searcher strategy is a maximum fractional matching normalized by its total weight, and conversely.

**Proof.** For a distribution $p$ on edges let $L_v=\sum_{e\ni v}p_e$ and $L=\max_vL_v$. Its guaranteed payoff is $2(1-L)$. The vector $x=p/L$ is a fractional matching of total weight $1/L$, so $L\ge1/\nu_f$. Conversely, a maximum fractional matching $x$ normalized by $\nu_f$ has maximum load at most $1/\nu_f$ and attains the bound. The maximum load is exactly that value; otherwise $x$ could be scaled up, contradicting maximality. Applying the same formula to a uniform support gives maximum load $\Delta(F)/|F|$, proving the second identity. Equality in the two scaling arguments gives the correspondence of optimal strategies. $\square$

**Corollary 6 (regular-support criterion).** If $G$ has a fractional perfect matching, so $\nu_f(G)=|V|/2$, then a reciprocal strategy is optimal if and only if $G$ contains a spanning subgraph in which every vertex has the same positive degree.

**Proof.** An optimal uniform support must have $\Delta(F)/|F|=2/|V|$. The average degree of that support is $2|F|/|V|$, so its maximum degree equals its average. All degrees are therefore equal and positive. Conversely any such spanning regular support has the required load. $\square$

The scaling reduction and the half-integral matching structure below use standard linear-programming and matching ideas. We do not claim those tools as new; [San18, Theorem 4] records the standard matching structure. The proposed new conclusions are their application to the specific conjecture, the exact examples and losses, and Theorem 8.

# 6. A connected, smallest graph counterexample

Take the five-vertex graph with edges in the order

$$12,\ 13,\ 23,\ 34,\ 45.$$ 

**Theorem 7.** The unique optimal Searcher strategy is

$$p_*=(1,1,1,0,2)/5.$$

The values are $V=6/5$ and $V_{\mathrm{rec}}=1$. No simple graph on at most four vertices with unit rewards and one trap is a counterexample.

**Proof.** Every vertex load under $p_*$ is $2/5$, so its guaranteed reward is $6/5$. A uniform Hider on the five vertices gives every edge expected reward $2(3/5)=6/5$. Optimality follows. For any optimal Searcher, the maximum load is $2/5$, and the sum of loads is two. Hence all five loads are $2/5$. Vertex 5 forces $p_{45}=2/5$, vertex 4 forces $p_{34}=0$, and the three triangle equations force the remaining probabilities to be $1/5$. This proves uniqueness.

For a support of size $h$, its value is $2(1-\Delta/h)$. If $h=1,2,3,4,5$, the respective lower bounds for $\Delta$ are $1,1,2,2,3$. The bound for $h=3$ follows because five vertices cannot support three disjoint edges. Thus every uniform-support value is at most one. Two disjoint edges attain one.

For minimality, if a graph on at most four vertices contains two disjoint edges, the uniform strategy on them has maximum load $1/2$, while total load two over at most four vertices makes a smaller maximum impossible. If no two edges are disjoint, an intersecting family of simple edges is a star or a triangle: two edges $ab,ac$ either share $a$ with every other edge, or an edge avoiding $a$ must be $bc$, which excludes all further edges outside the triangle. A star has value zero. A triangle has value $2/3$, attained by its uniform edge strategy. This covers disconnected graphs and isolated vertices as well. $\square$

The bridge $34$ makes the graph connected, although it has zero weight in the unique optimum. Removing it gives the smaller-edge-count witness $K_3\sqcup K_2$ with the same values.

# 7. The sharp five-sixths guarantee for all graphs

**Lemma (classical half-integrality, proof included).** The positive support of an extreme point of the fractional matching polytope is a vertex-disjoint union of edges of weight one and odd cycles whose edges have weight $1/2$.

**Proof.** An edge of weight one excludes every other positive edge at either endpoint. Remove these isolated weighted edges. Consider a connected component of the remaining positive support, with $h$ edges, and let $T$ be its vertices whose degree constraint is tight. Extremality requires that the tight equations have rank $h$ on these coordinates. Otherwise a nonzero vector in their common nullspace permits both positive and negative sufficiently small perturbations, preserving positivity and all slack inequalities. Hence $h\le|T|$.

A tight vertex cannot have positive-support degree one: its incident edge would then have weight one. Thus tight vertices have degree at least two, while any other vertex in the component has degree at least one. If $U$ is the set of the latter vertices, then $2h\ge2|T|+|U|$. Combining this with $h\le|T|$ forces $U=\varnothing$, $h=|T|$, and degree two at every vertex. The component is a cycle. An even cycle admits an alternating perturbation and is not extreme. On an odd cycle, the equations that two adjacent edge weights sum to one force all weights to be $1/2$. $\square$

**Theorem 8 (sharp guarantee).** For every finite simple graph with at least one edge with unit vertex rewards and one trap,

$$V_{\mathrm{rec}}(G)\ge\frac56 V(G). \tag{6}$$

The constant $5/6$ is best possible, even for connected graphs.

**Proof.** Choose an extreme maximum fractional matching. Let it contain $s$ edges of weight one and $t$ odd cycles, the latter having $L$ vertices altogether. Put $q=\nu_f=s+L/2$. If $s=0$ or $t=0$, the uniform distribution over the positive support is already optimal by (5), since all positive weights are equal. This also covers the zero-value case.

Assume $s,t\ge1$, and let $d=\min(s,t)$. One admissible support takes the $s$ isolated edges and a maximum matching from each odd cycle; it is a matching of size $q-t/2$. Another support takes every positive-support edge; it has $s+L$ edges and maximum degree two, giving density $q-s/2$. Therefore

$$\beta\ge q-d/2,\qquad q=s+L/2\ge s+3t/2\ge5d/2.$$

Since $q>1$, formula (5) implies

$$\begin{aligned}
\frac{V_{\mathrm{rec}}}{V}
&\ge\frac{1-(q-d/2)^{-1}}{1-q^{-1}}\\
&=1-\frac{d/2}{(q-d/2)(q-1)}\\
&\ge1-\frac1{10d-4}\ge\frac56.
\end{aligned}$$

Theorem 7 gives $V_{\mathrm{rec}}/V=1/(6/5)=5/6$ on a connected graph, proving sharpness. $\square$

The proof is constructive. From an extreme maximum fractional matching, evaluate the two described uniform supports and keep the better one. This gives the guarantee without enumerating all edge subsets. It does not assert that this procedure finds the best reciprocal support, and it does not extend the $5/6$ guarantee to arbitrary vertex rewards, multiple traps, or nonuniform hyperedges.

# 8. Verification, originality boundaries, and implications

The accompanying certificate code computes with exact rational numbers. The main finite witness is checked by matrix multiplication and enumeration of every reciprocal support. A separately implemented hypergraph checker verifies those claims and enumerates the small covering bases used in Theorem 4. A separately implemented graph checker verifies the five-vertex saddle point, all 31 supports, and all 71 nonempty labeled simple graphs on two through four vertices. The manuscript supplies proofs of the infinite family and the graph guarantee; checking a list of parameters is not presented as proof of those universal claims.

The original manuscript reports finite rational certificates; the computation files and raw outputs are not included in this edition. the entire manuscript is not a Lean formalization. No external peer review or global priority certification is claimed. Newness is bounded by the recorded searches and source comparisons as of 24 November 2026.

The result changes the optimization question in two concrete ways. First, selecting a support and assigning inverse reward weights cannot in general replace solving the game: it can lose nearly half the optimum on the displayed hypergraph family. Second, in the ordinary equal-reward graph case the same restriction still has an exact sharp guarantee. The obstruction is the coexistence of unit and half-unit weights in a fractional matching, and a pair of explicit uniform supports controls the resulting loss.

Questions not answered here include the best universal reciprocal-strategy guarantee on arbitrary hypergraphs; arbitrary rewards on ordinary graphs; multiple traps; and efficient exact optimization of $V_{\mathrm{rec}}$ in general. They are listed to delimit this paper, not asserted to be new open problems.

# References

- **[LL20]** Thomas Lidbetter and Kyle Y. Lin. *A search game on a hypergraph with booby traps*. Theoretical Computer Science 821 (2020), 57-70. DOI: [10.1016/j.tcs.2020.03.011](https://doi.org/10.1016/j.tcs.2020.03.011). Author manuscript: [arXiv:1903.12231v2](https://arxiv.org/abs/1903.12231v2), Proposition 14 and Conjecture 15. [Author-uploaded full text used in this audit](https://www.academia.edu/102128561/A_search_game_on_a_hypergraph_with_booby_traps).
- **[San18]** Laura Sanità. *The Diameter of the Fractional Matching Polytope and Its Hardness Implications*. 2018 IEEE 59th Annual Symposium on Foundations of Computer Science (FOCS), 910-921. DOI: [10.1109/FOCS.2018.00090](https://doi.org/10.1109/FOCS.2018.00090). [Official conference PDF](https://ieee-focs.org/FOCS-2018-Papers/pdfs/59f910.pdf), Theorem 4.
- **[LL26]** Thomas Lidbetter and Kyle Y. Lin. *A Booby Trap Game*. Operations Research, published online 29 April 2026. DOI: [10.1287/opre.2024.1518](https://doi.org/10.1287/opre.2024.1518). A related continuous-space/network model; it is not the arbitrary finite hypergraph claim considered here.
