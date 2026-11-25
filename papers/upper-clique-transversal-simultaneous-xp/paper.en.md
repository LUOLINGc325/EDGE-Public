# Upper Clique Transversal on simultaneous interval representations

**Abstract.** In a simultaneous interval representation, an edge requires both interval overlap and a common label. On input a representation using $k$ labels, Upper Clique Transversal is in XP and is W[1]-hard for this parameter. Let $d$ be the number of distinct nonempty label sets used. A sweep that stores at most two selected active vertices of each type computes the optimum in $2^{O(d)}n^{2d+O(1)}$ time and permits signed weights. The lower bound holds for the ordinary unweighted objective, even with at most four labels per vertex. ETH rules out $f(k)n^{o(k)}$ and $f(d)n^{o(d)}$. The upper and lower bounds resolve the two parts of the supplied-representation question of Jaffke, de Lima and Nikabadi.

## 1. Problem and results

A clique transversal meets every maximal clique of a finite graph. An upper clique transversal is one of maximum cardinality among the inclusion-minimal clique transversals. For weights $w:V\to\mathbb Z$, the signed objective instead maximizes the sum of the weights among the same inclusion-minimal sets. A maximal clique $C$ is *private* to $v\in S$ if $C\cap S=\{v\}$. A transversal $S$ is minimal precisely when each chosen vertex has a private clique. A private clique would become uncovered on deleting its vertex, and minimality supplies an uncovered clique after each such deletion.

A simultaneous interval representation assigns each vertex $v$ an interval $I_v$ and a label set $L_v\subseteq[k]$. Distinct $u,v$ are adjacent if and only if $I_u\cap I_v\ne\varnothing$ and $L_u\cap L_v\ne\varnothing$. The parameter $k$ is the number of labels of the given representation. Its *types* are the distinct nonempty label sets, of which there are $d\le2^k-1$. The intrinsic number $\mathrm{si}(G)$ is the minimum label count of any representation. The XP time bound refers to the actual given representation. If an optimal-label representation is supplied, its count equals $\mathrm{si}(G)$. The lower-bound reduction supplies its own representation and does not make a promise that it is optimal. [Beisegel et al., §§2 and 5](https://doi.org/10.4230/LIPIcs.SWAT.2024.7) · [Jaffke et al., §5 Open Question 2](https://drops.dagstuhl.de/storage/00lipics/lipics-vol386-mfcs2026/html/LIPIcs.MFCS.2026.99/LIPIcs.MFCS.2026.99.html#S5)

**Theorem 1.** The signed objective is solvable in $2^{O(d)}n^{2d+O(1)}$ elementary operations, with a polynomial factor for the bit cost of input handling and arithmetic. If $b$ also bounds the number of distinct right endpoints among active intervals of one type at any coordinate of the closed representation used by the sweep, the bound improves to $2^{O(d)}(1+2b+4b^2)^d n^{O(1)}$ with the same bit-cost convention.

**Theorem 2.** The ordinary unweighted problem is W[1]-hard for either supplied parameter $k$ or $d$, even when each vertex has at most four labels. Under ETH there is no $f(k)n^{o(k)}$ or $f(d)n^{o(d)}$ algorithm for computable $f$. These lower bounds also apply to algorithms parameterized by intrinsic $\mathrm{si}(G)$ that accept the representations produced by the reduction.

The exponent in Theorem 1 has necessary linear order as a function of $d$ in the sense that Theorem 2 excludes a sublinear exponent. The first continuation's all-negative reduction is also recorded below.

## 2. Clique structure and the capacity bound

Vertices with empty label sets or empty intervals are isolated, so their singleton cliques force them into every transversal. Delete them and add their weights after optimizing. The empty residual graph gives value zero. Closed intervals suffice for the sweep. If endpoint types are part of the input, rank all different endpoint coordinates, giving each coordinate four ordered blocks for open right, closed left, closed right and open left endpoints. Replace each remaining interval by the closed interval between its endpoint ranks. Equality of original endpoints can create overlap in the new representation exactly when both endpoints were closed. Distinct-coordinate comparisons are preserved. Unbounded endpoints can first be moved beyond all finite endpoints. Thus the graph remains the same.

Write $I_v=[\ell_v,r_v]$. A vertex is active at a coordinate $x$ if its interval contains $x$. If a maximal clique $C$ has common interval coordinate $x$ and uses a type $T$, every active vertex of type $T$ belongs to $C$. Indeed it meets all intervals at $x$, and it has the same intersections with other label sets as any representative of $T$ in $C$. This includes intersection with $T$ itself, which is nonempty. Maximality precludes adding such a vertex. [Type saturation, Beisegel et al., proof of Theorem 5.1](https://doi.org/10.4230/LIPIcs.SWAT.2024.7)

**Capacity lemma.** In any minimal clique transversal, at most two selected vertices of a fixed type can be active at the same coordinate. If three were active, choose the least left endpoint and greatest right endpoint among them. If both extremes belong to one interval, choose that interval and either other interval. The two chosen intervals meet and together cover the third interval. Every maximal clique containing the third vertex has an interval common point, by the Helly property of intervals, so that point belongs to at least one of the chosen intervals. Type saturation puts a second selected vertex in the clique. The third vertex has no private clique, a contradiction. Capacity two is attained by the all-one-type representation with intervals $[0,2],[1,3],[0,0],[3,3]$. The first two vertices form a minimal transversal and are simultaneously active at 1.

To enumerate maximal cliques with a processing coordinate, consider each distinct endpoint $x$ and every nonempty family of active types whose members pairwise intersect. The union of all active vertices of those types is a clique. Conversely each maximal clique has a common coordinate at the greatest left endpoint among its vertices. Saturation ensures the corresponding family generates the entire clique. Delete repeats and candidates properly contained in another candidate. Every nonmaximal candidate can extend to a maximal clique that was generated, so this filter gives the full list. Keep one generating coordinate for each resulting clique. The list starts with at most $2n(2^d-1)$ candidates, and pairwise containment checks take $2^{O(d)}n^{O(1)}$ time.

## 3. The sweep algorithm

At a sweep coordinate the state contains, for each type, the identities of at most two selected active vertices and a Boolean private-clique flag for each. Store the largest cumulative weight for every state. Start empty. For every coordinate in increasing order perform the following operations, in this order.

1. For each interval starting there, skip or select it. A selected vertex contributes its weight and has its flag initially unset. Discard a state exceeding the per-type capacity.
2. For each maximal clique assigned to the coordinate, find its intersection with selected active vertices. Discard a state if the intersection is empty. If it is a singleton, set the flag on that selected vertex.
3. For each selected interval ending there, require the flag to be set before deleting it from the state. Discard a state that fails this requirement.

All vertices of a processed clique are active and their selection decisions have been made. The singleton test identifies exactly its private witness, and a vertex cannot obtain a later witness after its right endpoint. Thus every accepted history is a minimal transversal. Conversely every minimal transversal induces an accepting history by the capacity lemma and privacy. The later acceptance and later weight contributions depend only on the current state and later choices, so retaining the largest historical weight for each state preserves the optimum. The final state is empty. Predecessor records recover a set realizing its value.

Each type has at most $1+2n+4\binom n2$ records and the number of states is $2^{O(d)}n^{2d}$. The number of coordinate, vertex and clique-processing operations contributes only $2^{O(d)}n^{O(1)}$. Weight sums require only polynomial bit length and can be compared at each step. This proves the first bound in Theorem 1.

For the endpoint-sensitive bound, replace each identity by its right endpoint and flag, retaining a multiset of at most two records for each type. At any later clique's processing coordinate a previously introduced selected vertex belongs to that clique exactly when it is still active and its type is present in the clique, by saturation. Its right endpoint controls its activity and deletion, and its flag controls final acceptance. Two identical records remain two selections. Their multiplicities govern whether a clique contains one or both. This information suffices to merge compatible histories and retain the maximum weight. There are at most $1+2b+4b^2$ multiset records for each type, proving the second bound. Endpoint-sensitive predecessor result

## 4. The ordered choice system

Use Multicolored Independent Set. There are $h$ color classes, each with $q$ options numbered $1,\ldots,q$, and a list of $m$ forbidden pairs of options from different classes. An independent choice takes one option per class and avoids all forbidden pairs. Empty classes give a fixed NO answer. An input with all classes nonempty and no forbidden pairs gives a fixed YES answer, including the case of fewer than two classes. For equal sizes one can copy options in each nonempty class, giving copies the cross-class conflicts of the originals. An equally sized instance also follows directly from Clique by taking $h$ copies of the vertex set and declaring two options in distinct classes incompatible whenever they denote the same vertex or a nonedge. The latter construction preserves the number $h$ and has polynomial size for $h\le |V|$. For the fixed YES output use a single vertex with threshold $1$. For the fixed NO output use a two-vertex clique with threshold $2$. Each has a one-label interval representation.

Suppose $h\ge2$ and $m\ge1$, using one occurrence per forbidden pair. Set $R=h(q-1)+1$ and $s=Rm$. Make $s$ layers, whose test sequence consists of $R$ repetitions of the same ordered list of $m$ forbidden pairs. Each layer $\ell$ contains one candidate $v_{\ell,i,j}$ for each class $i$ and option $j$. Call the $q$ candidates with fixed $(\ell,i)$ a block. There are $g=hs$ blocks and $N=gq$ candidates.

Let $b=2q+2$. Layer $\ell$ has center $c_\ell=b\ell$. For $0\le a\le s$, interface $a$ has marks $x_{a,t}=ba+2t$ for $1\le t\le q$. Interfaces $1,\ldots,s-1$ are internal, while $0,s$ are the outer interfaces. Give $v_{\ell,i,j}$ interval
$$
[x_{\ell-1,j}+1,\ x_{\ell,j}+1].
$$
At $c_\ell$ the active candidates are exactly those of layer $\ell$. At $x_{a,t}$, candidates from layer $a$ are active for $t\le j$ and candidates from layer $a+1$ for $j<t$, omitting a layer outside $1,\ldots,s$. These statements hold throughout $[u,u+1/2]$ for each center or mark $u$, since candidate endpoints have odd-integer coordinates and centers and marks have even-integer coordinates.

All candidates have a common label $\alpha$. Candidate $v_{\ell,i,j}$ also carries row label $\rho_i$ and parity label $\tau_{i,\ell\bmod 2}$. If the layer tests the pair $((i_0,j_0),(i_1,j_1))$, a candidate in this layer carries test label $\sigma$ exactly when its class is $i_0$ or $i_1$ and its index differs from the corresponding forbidden option.

A demand $(u,\lambda)$ specifies a mark or center $u$ and a label $\lambda$. Its *coverers* are candidates active there with label $\lambda$. The hard demands are all $(c_\ell,\rho_i)$, all $(x_{a,t},\rho_i)$ at internal interfaces, and all $(c_\ell,\sigma)$. There are
$$
D=hs+hq(s-1)+s
$$
hard demands. The centers ensure one choice in every block if a selection of exactly $g$ candidates meets all demands. Under exactly one choice per block, write $j_{\ell,i}$ for the chosen index. At internal interface $a$, row $i$ is covered at all marks exactly when $j_{a+1,i}\le j_{a,i}$. If this inequality fails, mark $t=j_{a,i}+1$ is uncovered. If it holds, the prefix $t\le j_{a,i}$ and suffix $t>j_{a+1,i}$ cover all marks. The test at $c_\ell$ fails exactly when the two tested indices equal the forbidden pair.

As indices are nonincreasing, the total count of strictly decreasing transitions, counted separately for each class, is at most $h(q-1)$. Among the $R$ repetitions some repetition has no transition with a decrease strictly inside it. Its $h$ indices are constant across its layers and avoid every listed forbidden pair. Decreases between repetitions do not affect this argument. Conversely, repeating an independent choice in every layer meets all demands with one choice per block. In particular, a hard demand with no coverers certifies a NO instance. Check that condition before constructing the graph and return the fixed NO instance if it occurs. This handles an empty test, such as a forbidden pair with one option in each of its classes.

## 5. Graph vertices for the demands and block choices

Fix integers $W\ge2$ and $M\ge qW+1$. The hardness uses $W=2$ and $M=2q+1$. Add a fresh label $\beta$.

- For each hard demand $(u,\lambda)$ add one marker $z_{u,\lambda}$ with labels $\{\lambda,\beta\}$. In the interior of its interval, place $M$ leaves, each a distinct point with sole label $\beta$.
- For each block $(\ell,i)$, mark index $t$ and each of its two bounding interfaces, add $W$ distinct reward points with sole label $\tau_{i,\ell\bmod2}$. Place them in the neighborhood of the specified mark even at an outer interface. Adjacent layers have different parity, so the associated block supplies all the coverers of these points.
- Add $z$ with sole label $\alpha$, whose interval contains all candidate intervals and extends beyond their right endpoints. In this extension, beyond the entire demand construction, put a point $y$ with sole label $\alpha$.

At each anchor $u$, put every hard-marker interval for that anchor and each reward point for that anchor in mutually disjoint locations inside $(u,u+1/2)$. The private leaves are the only points placed inside the corresponding hard-marker interval. Explicit rational coordinates can be obtained by assigning distinct offsets $j/[4(n+1)]$ at each anchor, using two offsets around the $M$ intermediate leaf offsets for each hard marker and one offset per reward point. If an anchor holds $a$ hard markers and $r$ reward points, it uses $a(M+2)+r\le2n$ offsets, so all used offsets lie strictly in $(0,1/2)$. Every candidate meeting a marker or reward point contains its whole anchor neighborhood. Its adjacency there is determined by the label test. Every leaf has only its own marker as neighbor, since no other interval carrying $\beta$ meets it. All auxiliary locations for distinct anchors are disjoint.

Here are the maximal cliques that touch an auxiliary vertex.

1. A reward point $p$ lies in exactly one maximal clique consisting of $p$ and all its coverers $C_p$. The coverers are mutually adjacent because they share $\alpha$ and a point on the line. An isolated reward has $C_p=\varnothing$ and gives a singleton maximal clique.
2. For a hard marker $z_{u,\lambda}$, one maximal clique is the marker together with its coverers $C_{u,\lambda}$. Each of its leaf edges is a further maximal clique, and these are all the maximal cliques touching the marker or any of its leaves. Every leaf has only the marker as neighbor, the coverers form a clique, and a leaf is adjacent to no coverer. The preprocessing guarantees $C_{u,\lambda}\ne\varnothing$, which is needed for the marker-and-coverers clique to be maximal.
3. The edge $\{z,y\}$ is the only maximal clique containing $y$. A clique consisting solely of candidates extends by $z$, since $z$ is adjacent to all candidates. Consequently any maximal clique outside the first two families contains $z$.

The label count is at most $h+2h+3=3h+3$. Of the nonempty label sets actually used, at most $4h$ occur on candidates, $h+1$ on hard markers, $2h$ on rewards, and two on the leaves and on $z,y$. Thus $d\le7h+3$, and no vertex has more than four labels.

## 6. Cardinality and both directions of the reduction

Let $T$ be an inclusion-minimal clique transversal and $J_{\ell,i}\subseteq[q]$ the indices of its selected candidates in block $(\ell,i)$. Exactly one of $z,y$ is in $T$. The edge requires at least one, and selecting both would leave $y$ without a private clique.

For each hard marker there are two possibilities. If the marker is selected, none of its leaves can be selected because a leaf's only maximal clique would contain the selected marker. If the marker is unselected, all its leaves are forced by the leaf edges, and some coverer must be selected to meet the marker-and-coverers clique. If $H$ hard markers are selected, markers and leaves contribute $DM-H(M-1)$. In particular every empty block forces its center marker to be chosen. If $E$ is the number of empty blocks, then $E\le H$.

For each reward point, its unique maximal clique forces its selection when no coverer is selected and prevents its selection when a coverer is selected, by minimality. For a nonempty $J=J_{\ell,i}$ there are $q-\min J$ marks with some selected coverer at the left interface and $\max J$ at the right. Of its $2qW$ reward points, exactly $W(q-\operatorname{span}J)$ belong to $T$, where $\operatorname{span}J=\max J-\min J$. If $J$ is empty, all $2qW$ rewards belong to $T$.

A nonempty block contributes its selected candidates and rewards, a total of
$$
qW+1+(|J|-1)-W\operatorname{span}J
\le qW+1-\operatorname{span}J,
$$
since $|J|-1\le\operatorname{span}J$ and $W\ge2$. An empty block contributes $2qW=(qW+1)+(qW-1)$. Define
$$
K=DM+g(qW+1)+1.
$$
Adding the contributions, using $E\le H$ and $M-1\ge qW$, gives
$$
\begin{aligned}
|T|
&\le K-H(M-1)+E(qW-1)
    -\sum_{(\ell,i):\,J_{\ell,i}\ne\varnothing}\operatorname{span}J_{\ell,i}\\
&\le K-H-\sum_{(\ell,i):\,J_{\ell,i}\ne\varnothing}\operatorname{span}J_{\ell,i}.
\end{aligned}
$$
Thus $|T|\ge K$ forces $H=0$ and zero span in every block. All blocks are nonempty, so exactly one candidate per block is selected. Every demand has a selected coverer because no hard marker was selected. Section 4 then extracts an independent choice.

Conversely, if the source has an independent choice, take its $g$ repeated candidates, every hard leaf, all rewards without a selected coverer, and $z$. The candidates hit all hard marker-and-coverer cliques. The leaves hit their edges, the rewards with no selected coverer hit their unique cliques, and $z$ meets all remaining cliques. Every selected candidate is the unique selected vertex in the hard clique for its block center. Each selected hard leaf has its leaf edge as a private clique. Each selected reward has its unique maximal clique private, and $z$ has $\{z,y\}$ private. This is a minimal transversal of cardinality exactly $K$.

## 7. Complexity implications

With $W=2$ and $M=2q+1$ the output has
$$
n=N+D(M+1)+2qgW+2=O(hq^2s).
$$
Its rational coordinate numerators and denominators have polynomial bit length. The representation and the graph, if requested in adjacency form, are constructible in fixed-degree polynomial time. The source is W[1]-hard in $h$ and has no $f(h)n_0^{o(h)}$ algorithm under ETH, where $n_0$ is the number of source vertices. Equalization enlarges $n_0$ only polynomially. The bounds on $k$ and $d$ prove W[1]-hardness and transfer the exponent lower bound. More explicitly, if the target exponent is $a(t)=o(t)$, then $\max_{1\le t\le Ch+C'} a(t)=o(h)$ for constants $C,C'$. The maximization also absorbs a nonmonotone running-time prefactor into a computable function of $h$. Substituting the fixed polynomial bound on $n$ yields the forbidden source running time. The intrinsic-parameter hardness follows because $\mathrm{si}(G)\le k$ on every output. Algorithms for this consequence may receive the bounded representation output by the reduction. [Beisegel et al., Theorem 7.2](https://doi.org/10.4230/LIPIcs.SWAT.2024.7)

## 8. Negative unit weights and prior hardness results

The same ordered demands give the earlier all-minus-one lower bound. Keep the candidates with labels $\alpha,\rho_i$ and, as applicable, $\sigma$. Add $z,y$ as above. Replace each hard demand by $g+2$ disjoint point markers of its sole demand label at nearby offsets in its stable neighborhood. Each marker has a single maximal clique with its coverers, including the singleton case. Any clique transversal of size at most $g+1$ chooses at least one of $z,y$, so it selects at most $g$ candidates. If the chosen candidates miss a demand, all $g+2$ corresponding markers are forced, which exceeds the budget. Hence such a transversal chooses exactly one candidate per block, and the repeated tests yield an independent choice. Conversely an independent choice gives a transversal of size $g+1$ by selecting its repeated candidates and $z$. The minimum size among all clique transversals is attained by an inclusion-minimal one, so weights all equal to $-1$ turn this lower bound into a signed upper-transversal lower bound. The graph has at most $h+2$ labels and polynomial size. [Earlier signed proof](#8-negative-unit-weights-and-prior-hardness-results)

Beisegel et al. use repeated intervals and compatibility tests in a lower bound for Independent Dominating Set. Their task requires an independent set dominating vertices. The ordered rows here encode coverage of specified maximal cliques. Milanič and Uno already use leaf edges in their chordal-graph hardness proof. Our construction combines private leaves with a parity-controlled count of maximal cliques, so each block with more than one chosen option has strictly smaller positive objective. [Beisegel et al., §7](https://doi.org/10.4230/LIPIcs.SWAT.2024.7) · [Milanič and Uno, Theorem 3.11](https://arxiv.org/html/2309.14103v4)

Theorem 2 of Gollin et al. proves hardness for the solution-size threshold. Its construction can have unbounded $\mathrm{si}(G)$ with two source colors. To see this, take a two-color perfect matching with $p$ edges. Their (E1)–(E2) induce an edge-vertex clique $X$ of size $p$ and a set of $p$ first-color choice vertices with neighborhoods $X\setminus\{x\}$, one for each $x\in X$. In any simultaneous representation, the clique intervals share a point. For a fixed label set of a choice vertex, the neighborhoods into $X$ are identical for intervals containing that point, nested for intervals wholly to its left, and nested for intervals wholly to its right. For example, on the left only the choice interval's right endpoint affects its overlap with a clique interval, and the label filter is fixed. Since the desired neighborhoods are incomparable, each label set accounts for at most three choice vertices. A $k$-label representation must satisfy $p\le3\cdot2^k$, so their construction cannot give the present label-parameter bound directly. [Gollin et al., §2 and Theorem 2](https://arxiv.org/html/2610.04917v2#S2)

Linear mim-width is at most simultaneous interval number, so the positive-unit reduction also supplies graphs with linear mim-width $O(h)$ as a function of source color count. Its bounds concern variable parameters. The fixed-width-one question of Jaffke et al. and the fixed-class bounded mim-width question of Milanič and Uno remain outside this result. [Beisegel et al., Theorem 3.5](https://doi.org/10.4230/LIPIcs.SWAT.2024.7) · [Jaffke et al., Open Question 1](https://drops.dagstuhl.de/storage/00lipics/lipics-vol386-mfcs2026/html/LIPIcs.MFCS.2026.99/LIPIcs.MFCS.2026.99.html#S5) · [Milanič and Uno, §8](https://arxiv.org/html/2309.14103v4#S8)

The sweep has been compared with exhaustive small-graph computation on 2,925 representations and 600 signed-weight instances. The positive-unit reduction has independent graph and finite score checks on sixteen complete source instances, two fully enumerated micrographs, and the empty-test boundary. The general claims follow from the preceding proofs. The programs and raw outputs of these reported checks are not included in this edition.
