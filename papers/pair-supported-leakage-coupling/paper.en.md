# Minimum-distinct couplings: a sharp support threshold

Matching structure, uniform ternary hardness, robust positive-channel gaps, and harmonic profile bounds

## Status and contribution scope

This manuscript presents a pair-supported analysis, a computational boundary, and quantitative extensions. External peer review and end-to-end Lean verification have not been completed. The inspected-source novelty assessment is limited: the official full text of the EFC submission [8] was unavailable, and no claim of exhaustive global priority is made.

The general minimum-distinct objective, exponential request-set formulations, logarithmic-order approximation, and probabilistic graph-coloring method have prior sources. In particular, the correlated-rounding results of Ma [12] and the probabilistic-satisfiability construction of Georgakopoulos, Kavvadias and Papadimitriou [13] are essential comparisons. Our principal result concerns the exact boundary in **maximum column support**, including constant additive separation and robustness to positive perturbation. The harmonic column-profile bound is a secondary refinement of an already studied approximation problem.

## Abstract

For finitely many discrete distributions, let $C(P)$ be the least expected number of distinct outputs in a joint coupling and let $T(P)$ be the sum of the columnwise maxima. We determine a sharp computational boundary for attaining the lower bound $C(P)\ge T(P)$. When every output column has support at most two, $C(P)$ equals the input count minus a capacitated matching-polytope optimum. Odd-set inequalities completely characterize equality, and the exact worst additive and multiplicative gaps at fixed input count follow from fractional-matching half-integrality. At maximum column support three, equality testing is NP-complete, even with every row uniform on exactly three labels. The reduction preserves a no-instance gap of at least $1/3$; a common positive perturbation retains a gap of at least $1/6$ while making every matrix entry positive. The hardness construction explicitly preserves all prescribed one-third marginals and adapts classical probabilistic-satisfiability ingredients.

For general channels, we also construct one coupling whose label-$y$ occurrence probability is at most $\min(1,\sum_j P_{(j)}(y)/j)$, where the entries of column $y$ are sorted in decreasing order. Consequently the same coupling simultaneously satisfies every nonnegative label-cost bound and gives a harmonic guarantee in the maximum column support. The general logarithmic order was already established in correlated rounding; our statement refines its dependence on the column profile. A one-sided truncation interval, an exact positive four-row family, and finite rational diagnostics complement the general proofs. The exact worst ratio at support three and a general dense-channel optimum remain unresolved.

## 1. The objective, prior questions, and the support boundary

Let $n\ge1$, let $\mathcal Y$ be finite, and let $P_1,\ldots,P_n$ be probability mass functions on $\mathcal Y$. A coupling is a joint distribution of $(Y_1,\ldots,Y_n)$ with precisely these marginals. Define

$$
T(P)=\sum_{y\in\mathcal Y}\max_iP_i(y),\qquad
C(P)=\min_{Y_i\sim P_i}\mathbb E|\{Y_1,\ldots,Y_n\}|.
\tag{1}
$$

The finite coupling polytope is nonempty and compact, so the minimum exists. The indicator identity for the number of distinct labels gives

$$
C(P)=\min_{Y_i\sim P_i}\sum_y\Pr(\exists i:Y_i=y)\ge T(P).
\tag{2}
$$

For a channel with a full-support input prior, $T(P)$ is the exponentiated maximal leakage [1,2]. The question is simultaneous attainment of all column maxima by one coupling. Makur and Singh [1,2] give sufficient conditions and solve three inputs, while leaving larger-input optimization and attainability questions open. We do not claim a new three-input formula. Ma [12] studies the same prescribed-marginal distinct-label problem in fulfillment terminology and proves logarithmic-order correlated-rounding guarantees. These objectives and broad approximation phenomena are prior work.

Write $r(P)=\max_y|\{i:P_i(y)>0\}|$. All-zero columns can be removed. The first part of the paper treats

$$
|\{i:P_i(y)>0\}|\le2\quad\hbox{for every }y.
\tag{PS}
$$

This is a **column** support restriction; each row may have arbitrarily many possible outputs. Sections 2–9 supply its exact matching representation, sharp finite-input extrema, weighted version, and truncation consequences. Sections 10–11 show that increasing the allowed column support from two to three makes equality testing NP-complete, with a fixed additive gap that survives full-positive smoothing. Section 12 supplies a profile-sensitive harmonic bound for unrestricted supports.

| Class or parameter | Proved conclusion | Location |
| --- | --- | --- |
| Maximum column support at most two | Exact polynomial-time matching optimization; equality iff all odd-set inequalities hold | Theorem 1, Corollary 2, Section 6 |
| Fixed $n$ and odd-girth lower bound $g$ | Exact worst gap $k/2$ and ratio $1+k/(n+s)$, with $k=\lfloor n/g\rfloor$ and $s=(n-k)\bmod2$ | Theorem 5 |
| Maximum column support at most three; rows uniform on three labels | Equality is NP-complete; reduction no instances have $C-T\ge1/3$ | Theorem 9 |
| Strictly positive rational channels | Distinguishing equality from $C-T\ge1/6$ is NP-hard | Theorem 12 |
| Arbitrary column profile | One cost-independent coupling satisfies the profile and harmonic bounds | Section 12 |

The complexity assertions use rational inputs with binary encoding and variable dimensions. The inequalities and coupling representations hold for real probabilities unless rationality is explicitly required for computation.

## 2. The exact matching representation

For an unordered input pair $e=\{i,j\}$ put

$$
b_e(y)=\min\{P_i(y),P_j(y)\},\quad
w_e=\sum_y b_e(y),\quad W=\sum_e w_e.
\tag{3}
$$

The overlap graph $G$ has vertex set $[n]$ and edges with $w_e>0$. For a vertex set $S$, write $E(S)$ for its internal edges. For an edge set $A$, write $x(A)=\sum_{e\in A}x_e$, and put $d_x(i)=\sum_{e\ni i}x_e$. Let $\mathsf M(G)$ be the convex hull of the incidence vectors of matchings, including the empty matching. Two elementary facts follow from (PS):

$$
\sum_{e\ni i}w_e\le1,\qquad T(P)=n-W.
\tag{4}
$$

For the first, at any fixed $(i,y)$ at most one other row contributes a positive pair minimum, which is at most $P_i(y)$. For the second, each column's total mass is its maximum plus its unique pair minimum, if there is one. Sum over columns and use the row sums.

**Theorem 1 (exact value and constructive coupling).** Under (PS),

$$
\boxed{C(P)=n-\nu(w)},\qquad
\nu(w)=\max\{x(E):x\in\mathsf M(G),\ 0\le x\le w\}.
\tag{5}
$$

In particular, with $\Delta(P)=C(P)-T(P)$,

$$
\Delta(P)=W-\nu(w).
\tag{6}
$$

### 2.1. Every coupling gives a feasible matching vector

Ignore a null set on which a coordinate takes a label having zero marginal probability. No label can then appear at three coordinates, by (PS). Consequently, the equal pairs in any tuple form a matching $M_Y$. If $z_e=\Pr(Y_i=Y_j)$, then $z=\mathbb E\mathbf1_{M_Y}\in\mathsf M(G)$, and

$$
z_e=\sum_y\Pr(Y_i=Y_j=y)\le\sum_y\min(P_i(y),P_j(y))=w_e.
$$

Each equal pair reduces the distinct count by exactly one. Thus every coupling satisfies

$$
\mathbb E|\{Y_i\}|=n-z(E)\ge n-\nu(w).
\tag{7}
$$

### 2.2. An optimal matching vector gives an optimal coupling

Choose a maximizer $x$ in (5), and choose a finite random matching $M$ with edge-inclusion probabilities $x_e$. Such a distribution exists by the definition of $\mathsf M(G)$. Set

$$
a_e(y)=\frac{x_e}{w_e}b_e(y),\quad
r_i(y)=P_i(y)-\sum_{e\ni i}a_e(y),\quad
q_i=1-\sum_{e\ni i}x_e.
\tag{8}
$$

Only edges with $w_e>0$ are used. We have $\sum_y a_e(y)=x_e$, $0\le a_e(y)\le b_e(y)$, and $\sum_y r_i(y)=q_i$. At fixed $(i,y)$, (PS) again makes at most one subtraction nonzero, so $r_i(y)\ge0$.

Conditionally on $M$, give the endpoints of every selected edge $e$ a common label with distribution $a_e/x_e$. Give every unmatched vertex $i$ a label with distribution $r_i/q_i$. These draws can be independent. An edge with $x_e=0$ is never selected; a vertex with $q_i=0$ is never unmatched, so neither zero denominator is evaluated.

For coordinate $i$, the unconditional contribution from edge $e$ is $a_e$ and the unmatched contribution is $r_i$. Their sum is exactly $P_i$. The selected edges produce at least $|M|$ disjoint equal pairs, so the generated tuple has at most $n-|M|$ distinct labels. Therefore its expected cost is at most $n-x(E)=n-\nu(w)$. Together with (7), this proves the theorem.

The proof does **not** assume that independent residual draws avoid collisions. For a nonoptimal $x$, additional collisions can occur. For an optimal $x$, let $z$ be the actual collision vector of the constructed coupling. The selected edges imply $z\ge x$, while Section 2.1 gives $z\in\mathsf M(G)$ and $z\le w$. Optimality forces $z(E)=x(E)$, and hence $z=x$. Accidental collisions vanish as a conclusion, not as a premise.

## 3. Exactly which channels attain the leakage bound?

We use Edmonds' classical matching-polytope theorem [3], with its full attribution:

$$
\mathsf M(G)=\left\{x\ge0:
\sum_{e\ni i}x_e\le1\ (i\in[n]),\quad
x(E(S))\le\frac{|S|-1}{2}\ (|S|\text{ odd})\right\}.
\tag{9}
$$

The graph theorem is an imported result. The contribution considered here is its exact coupling representation and the consequences established below.

**Corollary 2 (complete zero-gap criterion).** Under (PS),

$$
\boxed{C(P)=T(P)\iff
w(E(S))\le\frac{|S|-1}{2}\quad\text{for every odd }S\subseteq[n].}
\tag{10}
$$

Indeed, (6) vanishes precisely when the optimizer can equal $w$ coordinatewise. The degree constraints for $w$ already follow from (4). Equation (9) leaves exactly the displayed odd-set constraints.

Equivalently, the exact gap is the minimum amount of overlap that must be removed to satisfy these constraints:

$$
\Delta(P)=\min\left\{d(E):0\le d\le w,\quad
d(E(S))\ge w(E(S))-\frac{|S|-1}{2}\ \text{for all odd }S\right\}.
\tag{11}
$$

This is an optimization over simultaneous constraints. It cannot generally be replaced by the largest single positive defect. Two disjoint triangles with all capacities $1/2$ have total gap $1$, while every individual odd-set defect is at most $1/2$.

**Corollary 3 (four-input formula).** For $n=4$ under (PS),

$$
C(P)=T(P)+\max\left(0,\max_{|S|=3}\{w(E(S))-1\}\right).
\tag{12}
$$

Only triples give nontrivial odd-set constraints. At most one can be violated: the sum of the weights of triangles $123$ and $124$ is $d_w(1)+d_w(2)\le2$, and relabeling treats every pair of distinct triples. If one triple violates by $\delta>0$, remove total weight $\delta$ from its edges. This is possible, since its weight is $1+\delta$, and it cannot worsen any other upper constraint. Equation (11) proves (12).

This four-input consequence is closely related to, rather than independent of, the sufficient condition in [2, Theorem 3]. Under (PS), that paper's $N_{ij}$ becomes $w_{ij}$ and its second-largest column sum becomes $W$. Its condition says that the sum of the maxima in the three opposite-edge pairs is at most one. The eight choices of one edge from each pair give the four stars and four triangles. Stars already obey the degree constraints; the condition is therefore exactly the triangle criterion in this subclass. We establish its necessity here and quantify the failure through (12).

## 4. Odd cycles and the dimension-independent sharp bound

Let $g$ be the length of a shortest odd cycle in $G$. If $G$ is bipartite, write $g=\infty$.

**Theorem 4 (odd-girth bound).** If $g<\infty$, then

$$
0\le\Delta(P)\le\frac Wg\le\frac n{2g},\qquad
\frac{C(P)}{T(P)}\le1+\frac1g.
\tag{13}
$$

For a bipartite graph, $C(P)=T(P)$. In particular, every channel satisfying (PS) obeys $C(P)/T(P)\le4/3$.

**Proof.** Put $\alpha=(g-1)/g$. For an odd set $S$ with $|S|\ge g$, the degree bound gives $w(E(S))\le|S|/2$, whence

$$
\alpha w(E(S))\le\frac{(g-1)|S|}{2g}\le\frac{|S|-1}{2}.
$$

If $|S| \lt g$, its induced graph is bipartite. A bipartition $A\cup B=S$ gives $w(E(S))\le\min(|A|,|B|)\le(|S|-1)/2$. Thus $\alpha w$ satisfies (9) and is feasible in (5). Consequently $\nu(w)\ge\alpha W$. Finally, $W\le n/2$ and $T=n-W\ge W$ give the two remaining inequalities. When $G$ itself is bipartite, the same argument applies to $w$ without scaling. $\square$

An odd cycle of length $g$, with each input choosing either incident edge-label with probability $1/2$, attains $T=g/2$ and $C=(g+1)/2$. Its overlap capacities are $1/2$, and a uniformly rotated maximum matching has size $(g-1)/2$ and edge marginals $(g-1)/(2g)\le1/2$. Hence the factor $1+1/g$ is sharp. The single triangle's obstruction already appears in [9], and its numerical value follows from the known three-input result [1]; the arbitrary-size bound and structural characterization are the assertions at issue here.

## 5. The exact worst case at each input size

The rounding and parity effects at fixed $n$ can also be determined exactly.

**Theorem 5 (sharp finite-input spectrum).** Fix $n\ge1$ and an odd integer $g\ge3$. Consider all channels satisfying (PS) whose overlap graph has no odd cycle shorter than $g$. Set

$$
k=\left\lfloor\frac ng\right\rfloor,\qquad
s=(n-k)\bmod2\in\{0,1\}.
$$

Then

$$
\boxed{\max_P\Delta(P)=\frac k2,\qquad
\max_P\frac{C(P)}{T(P)}=1+\frac{k}{n+s}.}
\tag{14}
$$

Both maxima are attained by one explicit channel. If $n \lt g$, then $k=0$ and both assertions reduce to exact equality. Setting $g=3$ gives the unrestricted answer within (PS).

### 5.1. A standard half-integrality fact, with proof

Let

$$
\mathsf F(G)=\{w\ge0:d_w(i)\le1\text{ for every }i\}.
$$

Its extreme points consist of disjoint unit-weight edges and vertex-disjoint odd cycles whose edges all have weight $1/2$, with zero weight elsewhere. This is the classical fractional-matching half-integrality description. We include the elementary argument used here.

At an extreme point, remove zero edges and remove each unit edge with its endpoints. The latter cannot touch another positive edge. Discard isolated vertices from this argument. In a remaining connected component every edge has weight strictly between zero and one. Call a vertex tight when its weighted degree is one. If the edge-incidence matrix restricted to tight vertices has a nonzero kernel vector, perturbing by sufficiently small positive and negative multiples preserves tight equations, slack inequalities, and positivity. Extremality therefore requires at most as many edges as tight vertices.

A tree component has at least two leaves; both are slack because their single edge has weight below one. It has $v-1$ edges but at most $v-2$ tight vertices, a contradiction. Any component with more than $v$ edges also contradicts the rank bound. A remaining component must therefore have exactly $v$ edges and all $v$ vertices tight. No vertex can have unweighted degree one; average degree is two, so the component is a cycle. An even cycle admits an alternating perturbation. On an odd cycle the equations $w_{i-1}+w_i=1$ uniquely force $w_i=1/2$. Conversely, unit edges and odd half-cycles are uniquely fixed on their positive support by the tight equations, proving the description.

### 5.2. Convexity reduces the extremal problem to those components

For fixed $G$, the function $\nu(w)$ in (5) is concave in the capacity vector: a convex combination of optimal feasible vectors is feasible for the combined capacities. Therefore

$$
F(w)=w(E)-\nu(w)
$$

is convex. Decompose $w\in\mathsf F(G)$ as $\sum_j\lambda_jw^{(j)}$ into extreme points. Then

$$
F(w)\le\sum_j\lambda_jF(w^{(j)}).
\tag{15}
$$

If an extreme point contains $k_j$ odd cycles, each contributes exactly $1/2$ to $F$: its capacity sum exceeds its maximum feasible matching sum by $1/2$. Unit edges contribute zero. Since every such cycle has length at least $g$, $k_j\le k$, proving the additive bound.

Let $s_j$ be the number of isolated vertices in the positive support of $w^{(j)}$. All other vertices have weighted degree one, so

$$
T_j=n-w^{(j)}(E)=\frac{n+s_j}{2},\qquad
\frac{F(w^{(j)})}{T_j}=\frac{k_j}{n+s_j}.
$$

The component sizes imply $s_j\equiv n-k_j\pmod2$. Thus this ratio is at most

$$
\frac{k_j}{n+((n-k_j)\bmod2)}\le\frac{k}{n+s}.
$$

The second expression increases with the integer $k_j$ in the relevant range: the only nonimmediate successive comparison is $(r+1)/(n+1)>r/n$, equivalent to $n>r$, which holds for $r\le\lfloor n/g\rfloor$ when a successive comparison is needed. Moreover, $T(w)=\sum_j\lambda_jT_j>0$. Divide (15) by this positive weighted average to get $F(w)/T(w)\le k/(n+s)$.

### 5.3. Attaining both maxima

Take $k$ disjoint $g$-cycles with half-weight edges. Pair the remaining $n-kg$ vertices into unit edges, leaving $s$ isolated vertices. Parity agrees because $g$ is odd. The resulting vector has $F=k/2$ and $T=(n+s)/2$.

Every degree-feasible $w$ is realized by a channel: give each edge its own label with probability $w_e$ at both endpoints, and give vertex $i$ a private label of probability $1-d_w(i)$. This also proves that the extrema are genuine channels, rather than unattainable abstract capacity vectors. $\square$

For example, the exact worst ratio is $6/5$ at either four or five inputs. At seven inputs it is $5/4$. The universal $4/3$ bound is attained whenever $n$ is a positive multiple of three. These are statements about the unweighted distinct-count objective; arbitrary label weights do not obey the same fixed-$n$ refinement.

## 6. Algorithms and the size of an optimal coupling

For rational input, (5) uses at most $\binom n2$ variables. Its constraints are the classical matching-polytope constraints and rational upper bounds. Standard matching-polytope separation together with separation–optimization equivalence gives a polynomial-time value algorithm [3; 7, Theorems 3.1 and 3.8]. The rational-polytope encoding condition is set out in [7, (3.6)–(3.7)]. This is a theoretical consequence of existing optimization machinery, not a claim that the supplied enumeration code implements a scalable oracle.

For clarity, the odd-set separation reduces to a minimum odd cut. Given $x\ge0$ with $d_x(i)\le1$, adjoin a root $r$ with edge capacity $1-d_x(i)$ from $r$ to vertex $i$, and give original edge $e$ capacity $x_e$. For $S\subseteq[n]$ its cut capacity is

$$
\sum_{i\in S}(1-d_x(i))+x(\delta(S))=|S|-2x(E(S)).
\tag{16}
$$

Hence an odd-set violation is exactly a root-excluding odd-cardinality cut of capacity below one. The classical polynomial odd-cut algorithm of Padberg and Rao [11] supplies separation. For its even terminal-set convention, take the terminals to be the original vertices when $n$ is even, and include the root as an additional terminal when $n$ is odd; the side excluding the root has odd terminal count exactly when $|S|$ is odd. The constraints $0\le x\le w$ are checked directly. Rational input bounds the encoding size of the resulting linear optimization problem. If $E$ is empty the value is immediate; otherwise, after omitting zero capacities as already stipulated, the constant vector $x_e=\min\{(\min_e w_e)/2,1/(4n)\}$ is strictly inside every nontrivial inequality. This supplies the full-dimensional interior required by the cited framework, with polynomially bounded encoding.

By Carathéodory's theorem, a matching decomposition of $x$ needs no more than $|E|+1$ matchings. With that decomposition, (8) describes a sampler using a polynomial-size list of matchings and conditional marginal distributions. For rational input, choose a rational optimizer and apply the rational convex-decomposition theorem [7, Theorem 3.9] to the uncapped polytope $\mathsf M(G)$; this also gives a polynomial encoding of the sampler. The capacity-box intersection is not used for that decomposition, because its vertices need not themselves be matchings. Explicitly listing all joint tuples can still be exponentially large. Our independent verifier deliberately enumerates small tuple and matching spaces to validate certificates; it does not purport to scale that enumeration to arbitrary $n$.

## 7. Nonnegative costs for individual labels

Suppose label $y$ has cost $c_y\ge0$, and define

$$
C_c(P)=\min\mathbb E\sum_y c_y\mathbf1_{\{\exists i:Y_i=y\}},\quad
T_c(P)=\sum_y c_y\max_iP_i(y),\quad
A_c=\sum_{i,y}c_yP_i(y).
$$

Keep each shared label $y$ as a separate edge $e_y$ in a loopless multigraph, with capacity $m_y=\min(P_i(y),P_j(y))$. Singleton labels give no edge. Let $B_c=\sum_{e_y}c_y m_y$, so $A_c=T_c+B_c$.

**Theorem 6 (weighted version).** Under (PS),

$$
\boxed{C_c(P)=A_c-\max\left\{\sum_{e_y}c_yx_y:
x\in\mathsf M(G_{\rm multi}),\ 0\le x_y\le m_y\right\}.}
\tag{17}
$$

To prove the lower bound, record labeled collision pairs. They form a matching, including the rule that two parallel edges cannot be selected simultaneously. In each tuple, the weighted distinct count equals the sum of its coordinate costs minus the costs of its equal pairs. Their probabilities obey the capacities $m_y$.

For the upper bound, choose an optimal random matching. A selected edge $e_y$ sets both endpoints to $y$. An unmatched row uses its remaining marginal mass, normalized by its unmatched probability. There is at most one corresponding edge at any fixed row and label, so this mass is nonnegative. Marginals are exact. Any additional collision decreases cost because $c_y\ge0$, giving the desired upper bound. Zero unmatched probabilities are handled as in Theorem 1. At an optimum, only positive-cost accidental collisions must disappear; zero-cost collisions are immaterial.

Merging parallel edges and then randomly choosing their labels proves the usual extension of (9) to this multigraph. The scaling proof of Theorem 4 applies to its underlying simple graph and yields

$$
0\le C_c-T_c\le\frac{B_c}{g},\qquad
\frac{C_c}{T_c}\le1+\frac1g\quad(T_c>0).
\tag{18}
$$

Here $B_c\le T_c$ holds columnwise. If $T_c=0$, then $C_c=0$. For a bipartite overlap graph, equality holds. The sharp cycle examples use $c_y=1$. We do not assert the finite-input refinement (14) for arbitrary costs, nor a zero-gap criterion requiring saturation of zero-cost labels. The weighted result is proved analytically; the supplied LP certificate campaign concerns the unweighted objective.

## 8. A certified extension to arbitrary channels

For any finite channel $P$, retain the two largest entries in each original column, using a fixed deterministic rule for ties. Remove the other entries. Collect the removed mass in row $i$, denoted $\varepsilon_i$, into a new private label $z_i$ that no other row uses. Denote this new channel by $Q$ and put $\eta=\sum_i\varepsilon_i$. For $n=1$, retain the single entry. Then $Q$ satisfies (PS).

**Theorem 7 (one-sided truncation interval).**

$$
\boxed{T(Q)=T(P)+\eta,\qquad
C(Q)-\eta\le C(P)\le C(Q).}
\tag{19}
$$

Equivalently,

$$
\boxed{\Delta(Q)\le\Delta(P)\le\Delta(Q)+\eta.}
\tag{20}
$$

**Proof.** Each original column keeps its maximum, while private column $z_i$ contributes $\varepsilon_i$ to $T(Q)$.

Start with an optimal $P$-coupling. Whenever coordinate $i$ outputs a removed label, replace it by $z_i$. This has the $Q$-marginals. One replacement increases the number of distinct labels by at most one; the expected number of replacements is $\eta$. Thus $C(Q)\le C(P)+\eta$.

Conversely, start with an optimal $Q$-coupling. Whenever coordinate $i$ outputs $z_i$, restore an original removed label according to its removed marginal distribution divided by $\varepsilon_i$. This restores $P_i$. The label $z_i$ is used only by that coordinate, so replacing it removes one present label and introduces at most one. The distinct count cannot increase. If $\varepsilon_i=0$, no restoration distribution is used. This proves $C(P)\le C(Q)$ and hence (19)–(20). $\square$

Computing $C(Q)$ by (5) gives an interval of width $\eta$, which can be intersected with $[T(P),n]$. A positive odd-set obstruction in $Q$ certifies a positive gap in the original, possibly fully dense, channel. Retaining the two largest entries minimizes $\eta$ among conversions that retain at most two original entries per column, do not increase them, and send removed mass to row-private labels. This minimizes the removed mass only: it need not optimize $C(Q)$, the overlap graph, or the final clipped interval.

The coefficient one in (19) is attainable. For three rows sharing one label with mass $a$ and otherwise using separate private labels, the optimal values differ by exactly the removed mass $a$. This is consistent with the already known complete three-row formula. The following four-row family gives a less degenerate application.

## 9. An exact fully positive family

For $0\le b\le1/4$, put $a=1/2-b$ and consider

$$
P_b=\begin{pmatrix}
a&a&b&b\\
a&b&a&b\\
b&a&a&b\\
b&b&b&1-3b
\end{pmatrix}.
\tag{21}
$$

All entries are positive for $b>0$. The column maxima give $T(P_b)=5/2-6b$.

**Theorem 8 (dense family and exact threshold).**

$$
\boxed{C(P_b)=\max\{3-9b,\ 5/2-6b\},\qquad
\Delta(P_b)=(1/2-3b)_+.}
\tag{22}
$$

For the truncation, retain respectively row pairs $\{1,2\}$, $\{1,3\}$, $\{2,3\}$, and $\{1,4\}$ in the four columns. These are valid largest-two choices throughout the interval, including at the all-tied endpoint. The removed mass is $\eta=8b$. The overlap graph of $Q_b$ has a triangle with all capacities $a$ and a pendant edge of capacity $b$. Its only possibly violated triple is the triangle, with defect $(1/2-3b)_+$. Corollary 3 gives

$$
C(Q_b)=5/2+2b+(1/2-3b)_+.
$$

Theorem 7 therefore proves the lower bound (22). To attain it, use the following endpoint couplings. Tuple digits are output labels $0,1,2,3$ in row order.

| Parameter | Tuples | Mass of each listed tuple | Cost |
| --- | --- | --- | --- |
| $b=0$ | $0223$, $1013$ | $1/2$ | $3$ |
| $b=1/6$ | $0000$, $0033$, $1111$, $1313$, $2222$, $3223$ | $1/6$ | $3/2$ |
| $b=1/4$ | $0000$, $1111$, $2222$, $3333$ | $1/4$ | $1$ |

Direct marginal checking verifies the table. For $0\le b\le1/6$, mix the first two couplings with weight $6b$ on the second. Since $P_b$ is affine in $b$, the marginals are $P_b$ and the cost is $3-9b$. For $1/6\le b\le1/4$, mix the last two with weight $12b-2$ on the last; the cost is $5/2-6b$. This proves the whole parameter interval without extrapolating from numerical samples.

At $b=1/20$, the channel is

$$
\frac1{20}\begin{pmatrix}9&9&1&1\\9&1&9&1\\1&9&9&1\\1&1&1&17\end{pmatrix},
$$

and $C=51/20$, $T=11/5$, and $\Delta=7/20$. Also $C(Q)=59/20$ and $\eta=2/5$, so the lower endpoint of (19) is exact. A separate full-coupling primal/dual certificate checks this instance. This family does not imply that truncation is exact for every dense channel.

## 10. The exact column-support threshold

Let $r(P)=\max_y|\{i:P_i(y)>0\}|$. Dimensions are part of the input, and probabilities have binary rational encodings. We consider the decision problem of whether $C(P)=T(P)$. The lower bound itself is explicitly computable; the computational question is its simultaneous attainability by a coupling.

**Theorem 9 (support threshold and a fixed additive gap).** For $r(P)\le2$, both $C(P)$ and the equality decision are computable in polynomial time. Deciding equality is NP-complete already when every row has exactly three positive entries, all equal to $1/3$, and $r(P)\le3$. There is a polynomial reduction from graph 3-colorability whose no instances satisfy

$$
C(P)\ge T(P)+\frac13.
\tag{23}
$$

Thus two versus three is the exact boundary between these classes for polynomial-time equality testing, unless $\mathrm P=\mathrm{NP}$. This is a statement about **maximum column support**. It neither asserts that every support-three instance is hard nor establishes a fixed multiplicative approximation barrier.

The tractable part is Theorem 1 and Section 6. The hardness proof combines a classical probabilistic-satisfiability coloring construction [13, Theorem 1] with a marginal-preserving occurrence construction and a quantitative distinct-count defect. Graph 3-colorability is the classical NP-complete source problem [14]. The one-third color indicators, cyclic averaging, general occurrence-copy idea, and sparse rational certificate principle are not claimed as new methods. The result proved here is their precise realization at the column-support boundary for this objective, with the gap and positivity consequences below.

### 10.1. Uniform incidence channels and an integer defect

Suppose row $i$ is uniform on a three-element set $A_i$, and omit unused labels. Write $r_y=|\{i:y\in A_i\}|$, with $N$ rows and $M$ labels. Then

$$
p_y=\max_iP_i(y)=\frac13,\qquad
T=\frac M3,\qquad \sum_y r_y=3N.
$$

For a supported tuple $z=(z_1,\ldots,z_N)$, set $I_y(z)=\mathbf1\{y\in\{z_i\}\}$ and $n_y(z)=|\{i:z_i=y\}|$. Define

$$
D(z)=\sum_y\bigl(r_yI_y(z)-n_y(z)\bigr)
    =\sum_y r_yI_y(z)-N.
\tag{24}
$$

Every summand is a nonnegative integer. Consequently, $D(z)=0$ if and only if every used label is assigned to all rows in its support. Such tuples correspond exactly to subsets $B$ of labels satisfying

$$
|B\cap A_i|=1\quad\hbox{for every }i.
\tag{25}
$$

We call these subsets exact selections. If a coupling has cost $T$, each label-occurrence probability $q_y$ is at least $1/3$, and their sum is $M/3$. Thus every $q_y=1/3$. The event that a given incident row chooses $y$ is contained in the occurrence event and has the same probability. These events agree almost surely. Since the incidence system is finite, the coupling is almost surely supported on exact selections.

Conversely, a distribution on exact selections with each label selected with probability $1/3$ produces an equality coupling: each row outputs its unique selected label. One exact selection alone does not generally supply such a balanced distribution. Its existence must be proved for the yes instances of the reduction.

**Lemma 10 (quantitative obstruction).** If an incidence channel has no exact selection and $r_y\le r$ for all labels, then $C(P)-T(P)\ge1/r$.

**Proof.** Every supported tuple satisfies $D\ge1$. For any coupling,

$$
1\le\mathbb ED
=\sum_y r_y(q_y-1/3)
\le r\sum_y(q_y-1/3)
=r\bigl(\mathbb E|\{Y_i\}|-T\bigr).
\tag{26}
$$

All deficits $q_y-1/3$ are nonnegative. Minimize over couplings. $\square$

### 10.2. The classical balanced coloring system

Let $G=(V,E)$ be a finite nonempty simple graph and use colors $0,1,2$ modulo three. Introduce labels

$$
a_{v,c}\ (v\in V,\ c\in\{0,1,2\}),\qquad
b_{e,c}\ (e\in E,\ c\in\{0,1,2\}).
$$

For vertex $v$ add a row uniform on $\{a_{v,0},a_{v,1},a_{v,2}\}$. For every edge $e=uv$ and color $c$ add a row uniform on

$$
\{a_{u,c},a_{v,c},b_{e,c}\}.
\tag{27}
$$

The system has $N_0=|V|+3|E|$ rows and $M_0=3|V|+3|E|$ labels. An exact selection chooses a unique color $f(v)$ at each vertex. Equal colors at the endpoints of an edge would put two selected labels in one row (27), which is impossible. Conversely, a proper coloring gives an exact selection by selecting its $a$-labels and selecting $b_{e,c}$ for the unique color unused at the endpoints of $e$.

If a proper coloring exists, choose one and shift all colors by a uniform $J\in\{0,1,2\}$. Every $a$-label has selection probability $1/3$. Every $b$-label also has probability $1/3$, since the two endpoints have different colors. This supplies the balanced distribution.

The uniform-one-third color events and cyclic averaging are precisely the classical ingredients of Georgakopoulos, Kavvadias and Papadimitriou's probabilistic-satisfiability hardness proof [13, Theorem 1]. Here edge slack labels express those forbidden simultaneous color events as uniform three-label channel rows. The column supports of the $a$-labels are still unbounded, so this construction by itself does not prove Theorem 9.

### 10.3. A probability-preserving occurrence construction

For an old label $y$ occurring in $s\ge2$ rows, order those incidences deterministically and replace occurrence $j$ by a fresh copy $x_{y,j}$. For each $1\le j \lt s$, introduce two fresh labels $u_{y,j},v_{y,j}$ and add two rows uniform on

$$
\{x_{y,j},u_{y,j},v_{y,j}\},
\qquad
\{x_{y,j+1},u_{y,j},v_{y,j}\}.
\tag{28}
$$

Leave singleton-incidence labels unchanged. Each copy appears in one original row and at most two new rows; each auxiliary appears in two rows. All columns therefore have support at most three, and all rows still have exactly three distinct labels with mass $1/3$.

For an exact selection, the two equations in (28) imply

$$
X_{y,j}+U_{y,j}+V_{y,j}=1
=X_{y,j+1}+U_{y,j}+V_{y,j},
$$

so all copies of $y$ have the same indicator. Collapsing them recovers an original exact selection. Conversely, an original exact selection extends: when $y$ is selected, select all copies and no auxiliaries; when it is unselected, select no copies and exactly one of $u_{y,j},v_{y,j}$ for each adjacent pair.

The extension also preserves balanced label probabilities. Start with the distribution from Section 10.2, in which every old label has probability $1/3$. Give its copies the same indicator. When that indicator is zero, choose $u$ or $v$ by a fair coin for each adjacent pair, using the same choice in its two gadget rows. Both auxiliaries have probability $(2/3)(1/2)=1/3$. Every new row therefore has precisely the required uniform marginal, and every outcome is an exact selection. Independence between the fair coins is convenient, but not needed.

Replacing a label of support $s$ adds $2(s-1)$ rows and has a net increase of $3(s-1)$ labels. In the coloring system only the $a$-labels need replacement. Their supports are $\deg(v)+1$, so the final dimensions are exactly

$$
N=|V|+15|E|,\qquad M=3|V|+21|E|.
\tag{29}
$$

The construction has polynomial size, without a bounded-degree premise on $G$. A colorable graph gives an equality coupling. A noncolorable graph gives no exact selection after copying; Lemma 10 with $r=3$ gives (23). This proves NP-hardness and the stated gap.

### 10.4. Rational certificates and membership in NP

For the restricted class, equality has a rational witness consisting of supported tuples and their nonnegative probabilities. Its linear system contains at most $3N$ marginal equations, normalization, and the equation that expected cost equals $T$. A feasible system has a basic feasible solution with at most $3N+2$ atoms. Each atom requires $N$ label indices. Coefficients are integers between zero and $N$; right-hand sides have polynomial bit length. Cramer's rule and the determinant bound give polynomial bit length for every basic weight. A verifier checks weights, normalization, all marginals, and the expected distinct count by rational arithmetic in polynomial time. This is the standard sparse-certificate principle used in probabilistic satisfiability [13, Proposition 1 and Corollary 1].

The same argument, with at most $NM+2$ equations and the input rational denominators, puts the general rational equality problem in NP. Together with Sections 10.2–10.3 and the matching algorithm, this completes Theorem 9. $\square$

## 11. Constant-gap hardness for strictly positive channels

**Lemma 11 (marginal repair).** For finite channels $P,Q$ on the same rows and labels,

$$
|C(P)-C(Q)|\le\sum_i\operatorname{TV}(P_i,Q_i).
\tag{30}
$$

**Proof.** A finite maximal coupling of $P_i,Q_i$ matches their common masses $\min(P_i(y),Q_i(y))$ and pairs the leftover masses arbitrarily. Its disagreement probability is $\operatorname{TV}(P_i,Q_i)$. Disintegrate it to a conditional kernel from $P_i$ to $Q_i$, and apply these kernels coordinatewise to an optimal joint $P$-coupling. The repaired law has exactly the $Q$ marginals. Changing one coordinate changes the number of distinct labels by at most one, so its expected cost increases by at most the sum of disagreement probabilities. Interchange $P,Q$ for the reverse inequality. Conditional kernels on zero-probability inputs can be chosen arbitrarily. $\square$

**Theorem 12 (positive-channel separation).** It is NP-hard to distinguish $C(P)=T(P)$ from $C(P)\ge T(P)+1/6$ for strictly positive rational matrices. The instances can be chosen with every entry at least $1/(6NM)$, where $N,M$ are their dimensions. In particular, a deterministic polynomial-time algorithm approximating $C$ to absolute error strictly below $1/12$ on all strictly positive rational inputs would imply $\mathrm P=\mathrm{NP}$.

**Proof.** Let $P$ be the output of Theorem 9, set $\varepsilon=1/(6N)$, and smooth each row by the same uniform law:

$$
P_i^\varepsilon=(1-\varepsilon)P_i+\varepsilon U_M.
\tag{31}
$$

Every entry is at least $1/(6NM)$, with polynomial encoding. Every original column maximum is $1/3$, and addition of the same scalar to every row in that column preserves its maximum. Hence

$$
T(P^\varepsilon)=(1-\varepsilon)T(P)+\varepsilon.
\tag{32}
$$

For a colorable graph, mix its equality coupling with probability $1-\varepsilon$ and one common uniform label for all rows with probability $\varepsilon$. The cost is exactly (32), proving equality for the smoothed channel.

For a noncolorable graph, Lemma 11 and $\operatorname{TV}(P_i,P_i^\varepsilon)\le\varepsilon$ imply

$$
\begin{aligned}
C(P^\varepsilon)-T(P^\varepsilon)
&\ge C(P)-N\varepsilon-(1-\varepsilon)T(P)-\varepsilon\\
&\ge\frac13-N\varepsilon+\varepsilon(T(P)-1)
\ge\frac16.
\end{aligned}
\tag{33}
$$

We used $T(P)\ge1$. The promised decision follows from graph 3-colorability. An absolute-error approximation as stated would separate the two cases by the threshold $T(P^\varepsilon)+1/12$. $\square$

Smoothing gives every column support $N$. Theorem 12 is a separate dense restriction, not a claim of full positivity and support at most three simultaneously for arbitrarily many rows. The minimum-entry bound decays with the dimension; it is not a dimension-free noise floor. Randomized algorithms would entail the corresponding randomized complexity consequence, not automatically $\mathrm P=\mathrm{NP}$.

## 12. A harmonic refinement for arbitrary column supports

### 12.1. Scope and attribution

Ma [12, Theorem 1] already gives an exact-marginal correlated-rounding scheme with per-label factor $1+\log n$; [12, Lemma 4 and Corollary 1] explains the set-cover connection and the logarithmic lower order. Thus logarithmic dependence is established prior work. This section records the harmonic factor and the more precise column profile below. Its lower construction is an explicit parameter choice within the classical random set-cover method; compare [15, Theorems 5.5–5.6]. No priority claim is made for the logarithmic order, Poisson coupling, or that lower-bound method.

All logarithms are natural. Let $P_1,\ldots,P_n$ be probability distributions on a finite alphabet $\mathcal Y$, with $n\geq1$. For nonnegative label costs $c_y$, write

$$
p_y=\max_{i\in[n]}P_i(y),\qquad
T_c(P)=\sum_{y\in\mathcal Y}c_yp_y,
$$

and

$$
C_c(P)=\min_{\pi\in\Gamma(P_1,\ldots,P_n)}
\mathbb E_\pi\!\left[\sum_{y\in\mathcal Y}
c_y\mathbf1\{y\in\{Y_1,\ldots,Y_n\}\}\right].
$$

Here $\Gamma(P_1,\ldots,P_n)$ denotes the finite-dimensional compact polytope of all joint distributions with the specified marginals, so the minimum exists. We use $T$ and $C$ when every cost equals one. Delete identically zero columns, and define

$$
r_y=|\{i:P_i(y)>0\}|,\qquad r=\max_y r_y,
\qquad H_j=\sum_{h=1}^{j}\frac1h,\quad H_0=0.
$$

For each column, let

$$
p_{(1),y}\geq\cdots\geq p_{(n),y}\geq p_{(n+1),y}=0
$$

be its entries in decreasing order. Put

$$
S_y(u)=\{i:P_i(y)\geq u\}\quad(0 \lt u\leq p_y),
\qquad
B_y(P)=\int_0^{p_y}H_{|S_y(u)|}\,du.
\tag{H.1}
$$

The finite layer representation gives the useful identities

$$
B_y(P)
=\sum_{j=1}^{n}(p_{(j),y}-p_{(j+1),y})H_j
=\sum_{j=1}^{n}\frac{p_{(j),y}}j.
\tag{H.2}
$$

The second identity follows by telescoping. Zero entries and ties cause no difficulty.

### 12.2. The column-profile bound

**Theorem 13 (simultaneous column-profile bound).** There is one coupling $\pi_P$, depending only on $P$, such that for every label $y$,

$$
\Pr_{\pi_P}\{y\in\{Y_1,\ldots,Y_n\}\}
\leq\min\{1,B_y(P)\}.
\tag{H.3}
$$

Consequently, the same coupling simultaneously satisfies every nonnegative cost vector:

$$
T_c(P)\leq C_c(P)
\leq\mathbb E_{\pi_P}\!\left[\sum_yc_y\mathbf1\{y\text{ is used}\}\right]
\leq\sum_yc_y\min\{1,B_y(P)\}
\leq\sum_yc_yH_{r_y}p_y
\leq H_rT_c(P).
\tag{H.4}
$$

In particular, $C(P)/T(P)\leq H_n$. The denominator $T(P)\geq1$. For a weighted problem with $T_c(P)=0$, the cost is identically zero and no ratio is needed.

#### 12.2.1. Construction and exact marginals

For each column $y$, choose an ordering of the rows compatible with its decreasing entries. Let $S_{y,j}$ be the first $j$ rows in that ordering, and let

$$
\lambda_{y,j}=p_{(j),y}-p_{(j+1),y}.
$$

Independently for all pairs $(y,j)$, run a homogeneous Poisson process of rate $\lambda_{y,j}$. A rate-zero process has no arrivals. At an arrival of process $(y,j)$, offer label $y$ to every row in $S_{y,j}$. Each row accepts its first offer and ignores later offers. Equivalently, a column has points with intensity $dt\,du$ on $[0,\infty)\times(0,p_y]$, and a point $(t,u)$ offers its label to $S_y(u)$. The finite layer construction makes the latter notation precise without requiring an uncountable family of independent processes.

For fixed $i,y$, the rates of the layers of column $y$ that contain row $i$ sum to $P_i(y)$. The first-offer processes of different labels for this row are independent; their total rate is $\sum_yP_i(y)=1$. Thus the first-offer time of row $i$ has exponential distribution of rate one, and its first label is $y$ with probability $P_i(y)$. Every row is assigned almost surely, and the resulting tuple has exactly the required marginals.

Call an arrival *useful* if it assigns at least one previously unassigned row, and let $U_y$ count useful arrivals with label $y$. There are at most $n$ useful arrivals in total. Each used label has at least one useful arrival, so

$$
\Pr\{y\text{ is used}\}\leq\min\{1,\mathbb EU_y\}.
\tag{H.5}
$$

#### 12.2.2. Positive association

We give the elementary association argument used in the estimate. If $X_1,\ldots,X_d$ are independent and $f,g$ are bounded functions increasing in every coordinate, then

$$
\mathbb E[f(X)g(X)]\geq\mathbb Ef(X)\,\mathbb Eg(X).
\tag{H.6}
$$

For one variable and an independent copy $X'$, this follows from

$$
2\operatorname{Cov}(f(X),g(X))
=\mathbb E[(f(X)-f(X'))(g(X)-g(X'))]\geq0.
$$

For several variables, condition on the last variable. The expected conditional covariance is nonnegative by induction; the covariance of the two conditional expectations is nonnegative by the one-variable result, because those conditional expectations are increasing. This proves (H.6). Repeatedly applying it to nonnegative products of indicators proves

$$
\Pr\Bigl(\bigcap_{i\in S}E_i\Bigr)\geq\prod_{i\in S}\Pr(E_i)
\tag{H.7}
$$

for increasing events $E_i$.

At a fixed time $t\geq0$, the finite vector of layer counts has independent coordinates. The event that row $i$ has received an offer before $t$ is increasing in those counts and has probability $1-e^{-t}$. Hence, for every nonempty deterministic set $S\subseteq[n]$,

$$
\Pr\{S\text{ contains an unassigned row just before }t\}
\leq1-(1-e^{-t})^{|S|}.
\tag{H.8}
$$

Fixed-time arrival probabilities are zero, so using “before” instead of “by” does not change this probability.

#### 12.2.3. Counting useful arrivals

For a layer of rate $\lambda$ and offered set $S$, its expected useful-arrival count is

$$
\lambda\int_0^\infty
\Pr\{S\text{ contains an unassigned row just before }t\}\,dt.
\tag{H.9}
$$

For completeness, this identity follows directly from independent increments. First work on $[0,M]$. Partition it into intervals of length $h$, with a possibly shorter last interval. For an interval beginning at $a$, multiply its layer-arrival count by the indicator that $S$ has an unassigned row at time $a$. The indicator depends only on the past, so the expectation of this product is the interval length times $\lambda$ times the availability probability at $a$.

This approximation differs from the actual useful count only in intervals containing at least two arrivals of the combined process: with at most one arrival, no earlier arrival within the interval can have changed availability. The combined rate is

$$
\sum_{y,j}\lambda_{y,j}=\sum_yp_y=T(P)<\infty.
$$

For $N\sim\operatorname{Poisson}(x)$,

$$
\mathbb E[N\mathbf1\{N\geq2\}]=x(1-e^{-x})\leq x^2.
$$

Thus the expected error of the approximation is at most
$\lceil M/h\rceil(T(P)h)^2$, which tends to zero as $h\downarrow0$. The availability probability is continuous in $t$: it is the probability of a Boolean combination of zero/nonzero statuses of finitely many Poisson counts, hence a finite linear combination of exponentials. The Riemann sums therefore converge to (H.9) restricted to $[0,M]$. Letting $M\uparrow\infty$ and applying monotone convergence proves (H.9).

For each positive integer $s$,

$$
\begin{aligned}
\int_0^\infty[1-(1-e^{-t})^s]\,dt
&=\int_0^1\frac{1-(1-z)^s}{z}\,dz\\
&=\sum_{h=0}^{s-1}\int_0^1(1-z)^h\,dz
=H_s.
\end{aligned}
\tag{H.10}
$$

Combining (H.8)–(H.10), then summing the layers of column $y$, gives

$$
\mathbb EU_y\leq\sum_j\lambda_{y,j}H_j=B_y(P).
$$

Equation (H.5) proves (H.3). The upper bounds in (H.4) follow by nonnegative weighting and $H_{|S_y(u)|}\leq H_{r_y}\leq H_r$. Finally, every coupling uses label $y$ with probability at least $\max_iP_i(y)$, proving the lower bound in (H.4). This completes the proof of Theorem 13. $\square$

**Remark 14 (scope of the refinement).** Theorem 13 gives an entry-sensitive per-label estimate, not merely an aggregate weighted estimate. Its factor $H_n\leq1+\log n$ refines the general logarithmic guarantee cited in Section 12.1. We make no assertion that $H_r$ is the optimal constant for a fixed finite $r$. In particular, for $r=2$, the matching-polytope theorem in the main text gives the strictly better sharp factor $4/3$, whereas $H_2=3/2$.

#### 12.2.4. A finite recursion and the scope of exact computation

The coupling also admits a discrete description without sampling real-valued arrival times. Let $\mathcal L$ be the finite set of positive-rate layers. Write a layer as $\ell=(y_\ell,S_\ell,\lambda_\ell)$. If $U\subseteq[n]$ is the nonempty set of unassigned rows, define

$$
a(U)=\sum_{\ell:S_\ell\cap U\ne\varnothing}\lambda_\ell>0.
$$

Conditioned on the current state, the next useful layer is $\ell$ with probability $\lambda_\ell/a(U)$ among the layers meeting $U$. Assign $y_\ell$ to $S_\ell\cap U$, and replace $U$ by $U\setminus S_\ell$. This is the same tuple law by independent increments and the exponential-race rule, and it terminates after at most $n$ transitions.

For a fixed target label $y$, let $q_y(U)$ be the probability that the future process uses $y$ when $U$ is the set of unassigned rows. Then $q_y(\varnothing)=0$, and

$$
q_y(U)=\frac{
\displaystyle\sum_{\substack{\ell:S_\ell\cap U\ne\varnothing\\y_\ell=y}}
\lambda_\ell
+\displaystyle\sum_{\substack{\ell:S_\ell\cap U\ne\varnothing\\y_\ell\ne y}}
\lambda_\ell q_y(U\setminus S_\ell)
}{a(U)}.
\tag{H.11}
$$

Every recursive state is smaller. For rational $P$, all quantities in this finite recursion are rational. Enumerating the tuple law independently by the next useful layer provides a second exact calculation of its marginals and costs. Neither this observation nor the use of Poisson processes asserts a polynomial bound on the bit complexity of exact continuous sampling or exhaustive law enumeration.

The accompanying verifier uses rational arithmetic for the layer recursion and the full tuple-law enumeration. Its recorded run checks 81 finite fixtures, with 2,599 tuple atoms in total: total probability, every row marginal, label-use probabilities, weighted costs, and all inequalities in (H.4). These calculations check the implementation on those fixtures. The arbitrary-size result is established by the proof above.

### 12.3. Classical cover certificates and an explicit lower construction

The following lower certificate retains the original exact-marginal problem. It does not replace it by a cover optimization problem.

**Lemma 15 (support-cover certificate).** Let

$$
A_i=\{y:P_i(y)>0\}.
$$

If every subset of $\mathcal Y$ meeting every $A_i$ has size at least $k+1$, then $C(P)\geq k+1$. In particular, let $A\in\{0,1\}^{n\times m}$ have positive row degrees $d_i$, and set

$$
P_i(y)=\frac{A_{iy}}{d_i}.
$$

If $d_i\geq d_{\min}>0$ for all rows and no $k$ columns cover all rows, then

$$
\frac{C(P)}{T(P)}\geq\frac{(k+1)d_{\min}}m.
\tag{H.12}
$$

**Proof.** Every sampled coordinate belongs to its row support almost surely. Therefore the distinct labels of every supported tuple meet every $A_i$, so its cost is at least $k+1$. For the incidence construction, each column maximum is at most $1/d_{\min}$, giving $T(P)\leq m/d_{\min}$. $\square$

The next proposition is included for explicit constants and alphabet size. Its method is the classical random-incidence argument, not a new source of logarithmic lower bounds. [15, Theorem 5.6] gives a closely related near-logarithmic set-cover construction, using equal row degrees; the present calculation uses independent entries and a degree-concentration event.

**Proposition 16 (explicit rational witnesses).** For every integer $n$ with $\log n\geq12$, there is a rational $n$-row channel on at most $\lceil6(\log n)^4\rceil$ labels such that

$$
\frac{C(P)}{T(P)}
>\log n-2\log\log n-\log\log\log n-4.
\tag{H.13}
$$

**Proof.** Set

$$
\begin{gathered}
L=\log n,\qquad p=\delta=L^{-1},\qquad
m=\lceil6L^4\rceil,\\
a=-\log(1-p),\qquad
b=L-2\log L-\log\log L-2,\qquad
k=\lfloor b/a\rfloor.
\end{gathered}
\tag{H.14}
$$

For $L\geq12$, $0 \lt b \lt L$. Indeed, $\log12<5/2$ and $\log\log12<1$ give $b(12)>4$, and its derivative is $1-2/L-1/(L\log L)>0$ on this range. Since $a\geq p$, we have $0\leq k\leq L^2 \lt m$.

Choose the entries of $A\in\{0,1\}^{n\times m}$ independently with success probability $p$. A row degree $D$ is binomial with mean $\mu=mp$. The standard exponential-moment calculation gives, for $0<\delta<1$,

$$
\Pr\{D\leq(1-\delta)\mu\}
\leq\exp\bigl(-\mu[\delta+(1-\delta)\log(1-\delta)]\bigr)
\leq e^{-\delta^2\mu/2}.
\tag{H.15}
$$

Indeed, apply Markov's inequality to $e^{-tD}$, use
$\mathbb Ee^{-tD}=(1-p+pe^{-t})^m\leq\exp(\mu(e^{-t}-1))$, and choose $e^{-t}=1-\delta$. The last inequality follows from
$\delta+(1-\delta)\log(1-\delta)\geq\delta^2/2$, obtained by differentiation from zero. Thus the probability that any row degree is below $(1-\delta)mp$ is at most

$$
n\exp(-\delta^2mp/2)\leq n e^{-3L}=n^{-2}.
\tag{H.16}
$$

A fixed set of $k$ columns misses any specified row with probability $(1-p)^k$; these events are independent across rows. Hence its covering probability is

$$
\bigl(1-(1-p)^k\bigr)^n\leq\exp\bigl(-n(1-p)^k\bigr).
$$

A cover with at most $k$ columns can be enlarged to one with exactly $k$ columns. A union bound therefore bounds the probability of any such cover by

$$
\binom mk\exp\bigl(-n(1-p)^k\bigr).
\tag{H.17}
$$

The choice of $k$ gives

$$
n(1-p)^k=e^{L-ak}\geq e^{L-b}=e^2L^2\log L.
$$

Also $m\leq7L^4$. For $k\geq1$,

$$
\log\binom mk\leq k\log(em/k)
\leq L^2\bigl(\log(7e)+4\log L\bigr).
$$

For $k=0$ the same upper bound is immediate. Thus (H.17) is at most

$$
\exp\!\left(L^2[\log(7e)+(4-e^2)\log L]\right)
 \lt e^{-3L^2}.
\tag{H.18}
$$

The strict inequality uses $\log(7e)<3$, $e^2>7$, and $\log L>2$. Equations (H.16) and (H.18) have sum less than one. There is consequently a binary matrix with all row degrees at least $(1-p)mp>0$ and with no cover of size at most $k$.

Normalize each of its rows to obtain a rational channel. Lemma 15 yields

$$
\begin{aligned}
\frac{C(P)}{T(P)}
&\geq(1-p)p(k+1)\\
&>(1-p)\frac pa b\\
&\geq(1-p)^2b\\
&\geq b-2\\
&=L-2\log L-\log\log L-4.
\end{aligned}
$$

Here $k+1>b/a$, $a\leq p/(1-p)$, and $0 \lt b \lt L=1/p$ justify the successive estimates. The last of these gives $(1-p)^2b\geq b-2pb\geq b-2$. This proves (H.13). $\square$

The proposition is existential. It does not supply an efficient deterministic construction of the incidence matrix, nor a complexity-theoretic hardness-of-approximation result.

**Corollary 17 (asymptotic scale, with prior-order attribution).** Let

$$
R_n=\sup_{P:\,n\text{ rows}}\frac{C(P)}{T(P)},
$$

where the alphabet may be any finite size. Then, for $\log n\geq12$,

$$
\log n-2\log\log n-\log\log\log n-4
 \lt R_n\leq H_n,
\qquad \frac{R_n}{\log n}\longrightarrow1.
\tag{H.19}
$$

Likewise, if $R_r^{\mathrm{col}}$ is the supremum over all finite channels whose column supports have size at most $r$, then

$$
R_r^{\mathrm{col}}\leq H_r,
\qquad \frac{R_r^{\mathrm{col}}}{\log r}\longrightarrow1.
\tag{H.20}
$$

**Proof.** Combine Theorem 13 and Proposition 16, using $\log n\leq H_n\leq1+\log n$. For (H.20), use the theorem for the upper bound and apply Proposition 16 with $n=r$ for the lower bound; every column then has support at most $r$. $\square$

The logarithmic scale in this corollary is consistent with the prior work identified in Section 12.1. The additional statements recorded here are the finite harmonic and column-profile estimates, the explicit lower parameters, and their expression in the channel notation.

### 12.4. Continuity and positive channels

Lemma 11 supplies the coordinate-repair bound used below, with $\operatorname{TV}(p,q)=\frac12\sum_y|p(y)-q(y)|$.

For a channel with $m$ labels, define the strictly positive smoothing

$$
P_i^\varepsilon=(1-\varepsilon)P_i+
\varepsilon\operatorname{Unif}([m]),\qquad0<\varepsilon<1.
$$

Then

$$
T(P^\varepsilon)=(1-\varepsilon)T(P)+\varepsilon,
\qquad |C(P^\varepsilon)-C(P)|\leq n\varepsilon.
\tag{H.22}
$$

The first equality holds column by column because the added uniform mass is the same for every row; the second follows from Lemma 11. In particular, the supremum $R_n$ is unchanged if it is restricted to strictly positive channels: every finite channel is the limit of these positive channels, their costs converge, and $T(P)\geq1$. For the large-$n$ witnesses of Proposition 16, choosing $\varepsilon=n^{-3}$ decreases the guaranteed ratio by at most $n^{-2}$, since $T(P^\varepsilon)\leq T(P)$ and $C(P)-n\varepsilon>0$. Positivity smoothing does not preserve a prescribed column-support bound $r \lt n$.

## 13. Related work, exact contribution boundaries, and open questions

### 13.1. Information-theoretic attainability

Makur and Singh [1, Theorem 4 and Proposition 1; 2, Theorem 3] establish the max-Doeblin/minimum-distinct connection, a general sufficient attainability condition, the three-input optimum, and a stronger sufficient condition for four inputs. The matching result solves an arbitrary-input structural class. Theorem 9 then identifies the immediately adjacent hard class in the natural column-incidence parameter. This is a computational classification of the attainability question, not a solution of every dense-channel optimum or of the benchmark papers' separate network-contraction theory.

The four-input specialization overlaps substantially with [2]: Section 3 explains exactly how its sufficient condition becomes necessary under (PS). The concept of simultaneous maximal coupling and its pairwise incompatibilities are also prior work [9,10]. Under (PS), equality is precisely simultaneous saturation of all pair overlaps. Neither that concept nor a three-cycle obstruction is a novelty claim.

### 13.2. Correlated rounding and the inherited approximation scale

Ma [12] studies the same categorical-marginal objective: items correspond to rows, fulfillment centers to labels, and the number of activated centers to the distinct count. His Theorem 1 gives a per-label $1+\log n$ guarantee; nonnegative weighted bounds follow immediately. Lemma 4 and Corollary 1 explain the set-cover connection and logarithmic-order lower bound. Section 4 provides a general exponential-size request-set optimization. These facts correct an omission from the earlier project positioning and are central prior work here.

Theorem 13 refines that approximation statement to the exact harmonic factor and the entry-sensitive profile $\sum_jp_{(j),y}/j$. Its parameter $r$ counts rows containing a label; the separate sparsity guarantee in [12] counts labels available to a row. Poisson clocks, shared randomness, positive association, set-cover obstructions, and the existence of a general coupling LP are not new mechanisms. The random-incidence lower construction records explicit parameters within a classical technique, with [15] providing a close comparison. Its logarithmic order is supporting context, not the main originality claim.

### 13.3. Probabilistic consistency and fractional coloring

The base color indicators, one-third marginals, and cyclic-color averaging in Section 10.2 are adapted from [13]. General marginal-consistency NP-hardness and the sparse-certificate principle likewise predate this work. Occurrence copying is a standard bounded-occurrence idea. The proof obligation particular to the present theorem is to impose support at most three while maintaining every categorical marginal, and then turn failure of exact selection into a fixed additive distinct-count defect.

There is an equivalent fractional-coloring description of the uniform ternary equality problem. Form the conflict graph on output labels, joining two labels whenever a row contains both. Every row induces a triangle. An exact selection is an independent set meeting every specified triangle. A balanced distribution on exact selections, multiplied by three, is a fractional coloring of total weight three covering every vertex once.

Conversely, suppose independent sets have nonnegative weights of total at most three and cover every label with weight at least one. Any specified triangle forces total weight at least three, since an independent set meets it in at most one vertex. At total weight three, its three cover inequalities must all be tight and every positive-weight independent set must meet that triangle. Applying this to every row and normalizing the weights by three gives the balanced distribution. Unused labels were removed, so every vertex belongs to a specified triangle. Thus equality is equivalent to fractional chromatic number at most three for this conflict graph.

If column support is at most three, every vertex belongs to at most three specified triangles and has degree at most six. Classical weighted fractional-coloring complexity is established in [7, Section 7]; general fixed-threshold hardness is also standard [16, Theorem 3.9.2]. We claim no new general hardness principle in that framework. The restricted triangle-incidence representation, the adjacent matching regime, and the quantitative cost consequences are the assertions proved here. The searched sources did not supply the same restricted theorem, but that is a bounded literature assessment rather than an exhaustive priority result.

### 13.4. Other settings and the unavailable EFC manuscript

Structured color-complement distributions appear in the grand-coupling analysis of [4]. Tree-coupled policy evaluation [5] and min-Doeblin contraction curves [6] address different surrounding applications. None of their broad applications is inherited without separate hypotheses. No measured savings in adaptive language-model evaluation, fulfillment systems, or an end-to-end implementation are claimed.

The full text of the related EFC submission [8] was unavailable. Observed secondary discussion concerns a general request-set program, monotone costs, and a small-total-alphabet special case; such a description does not establish either equivalence or non-equivalence to our precise column-support statements. We do not certify its unseen contents, claim that its full-text comparison has been completed, or depend on it for any proof. Generic formulation priority is in any event excluded by the directly inspected work [12].

The novelty assessment is limited to the incremental statements above and the sources available for comparison.

### 13.5. Remaining mathematical questions

The exact worst ratio for maximum column support three is open here. The profile theorem gives $H_3=11/6$; a four-row example gives a lower bound $3/2$: take four labels and let row $i$ be uniform on the three labels other than $i$. At least two labels are needed in every supported tuple, while $T=4/3$. To attain cost two, choose an unordered pair of labels uniformly among the six pairs; a row missing one chosen label uses the other, and each remaining row chooses between the pair by a fair coin. Every row is uniform on its three allowed labels, and both chosen labels occur. Thus $C=2$. This example does not prove that $3/2$ is the universal support-three bound.

A general efficient characterization of exact equality would contradict Theorem 9 unless $\mathrm P=\mathrm{NP}$. Useful subclasses inside support three, tighter instance-dependent bounds, and stronger noise regimes remain legitimate structural questions. The positive-channel theorem uses an inverse-polynomial perturbation; a dimension-independent noise threshold or a constant multiplicative hardness factor is not established.

## 14. Reproducibility and the strength of the evidence

The arbitrary-size results rest on the complete proofs above and the attributed matching-polytope and optimization theorems. Finite computations check implementations, algebra, and representative boundary cases. They neither prove the universal results nor establish novelty.

The exact-arithmetic study includes rational primal/dual certificates for 159 pair-supported instances, 10 dense instances, and three parameter-family endpoints. Its recorded checks include 38,986 tuple-dual inequalities, 1,649 matching-dual inequalities, 2,687 odd sets, and 5,819 constructed atoms on the sparse side, together with four rejected corruptions.

Four additional diagnostics use the Python standard library and were run with Python optimization enabled:

| Program in code/ | Coverage and acceptance checks |
| --- | --- |
| verify_coloring_reduction.py | All 1,099 labeled simple graphs with one through five vertices: independent coloring and incidence exact-cover decisions agree (1,032 yes, 67 no); every yes cyclic coupling and its stated smoothing have exact rational marginals |
| verify_copy_reduction.py | 78 graphs: every labeled graph with one through four vertices plus three specified five-vertex controls; separate coloring/exact-cover decisions, column support at most three, three distinct labels per row, and the exact dimension formulas (29) |
| verify_ppp_profile.py | 238 rational channels; an independent recursion checks each marginal, label-occurrence probability, useful-arrival count, and the profile bound |
| verify_harmonic_coupling.py | 81 fixtures and 2,599 joint atoms; separate useful-layer recursion and full tuple-law enumeration check probability mass, all marginals, weighted costs, and harmonic inequalities |

The graph campaigns overlap on small graphs and are not counts of disjoint instances. The copy check does not enumerate exponentially many auxiliary-coin outcomes; their prescribed marginals are established in Section 10.3. The rational acceptance checks use explicit guards that remain active under Python optimization. Seven additional floating-point examples illustrate the lower-bound parameter arithmetic.

Run the diagnostics from the directory containing `code/`:

    python3 -B -O code/verify_coloring_reduction.py
    python3 -B -O code/verify_copy_reduction.py
    python3 -B -O code/verify_ppp_profile.py
    python3 -B -O code/verify_harmonic_coupling.py

The diagnostic outputs are machine-readable. Formal proof-assistant verification has not been completed.

## References

1. A. Makur and J. Singh. *Doeblin Coefficients and Related Measures*. IEEE Transactions on Information Theory 70(7), 4667–4692 (2024). DOI: [10.1109/TIT.2024.3367856](https://doi.org/10.1109/TIT.2024.3367856). Fixed text: [arXiv:2309.08475v2](https://arxiv.org/html/2309.08475v2).
2. A. Makur and J. Singh. *Bounds on Maximal Leakage over Bayesian Networks*. [arXiv:2512.04955v1](https://arxiv.org/html/2512.04955v1), Sections II, V, VI and Appendix B (2025).
3. J. Edmonds. *Maximum Matching and a Polyhedron With 0,1-Vertices*. Journal of Research of the National Bureau of Standards B 69B, 125–130 (1965). DOI: [10.6028/jres.069B.013](https://doi.org/10.6028/jres.069B.013). [Original paper](https://nvlpubs.nist.gov/nistpubs/jres/69B/jresv69Bn1-2p125_A1b.pdf), Section 2, Theorem (P).
4. T. Ding, H. Liu, Y. Yin and C. Zhou. *Tight Bounds for Sampling q-Colorings via Coupling from the Past*. ICALP 2026, LIPIcs 374, article 76. DOI: [10.4230/LIPIcs.ICALP.2026.76](https://doi.org/10.4230/LIPIcs.ICALP.2026.76). [Full text](https://drops.dagstuhl.de/storage/00lipics/lipics-vol374-icalp2026/html/LIPIcs.ICALP.2026.76/LIPIcs.ICALP.2026.76.html), Section 4, Problem 4.1, Lemma 4.2 and Theorem 4.4.
5. Y. Wen. *Fast A/B/n Testing: Exact Multi-Policy Comparison via Tree-Coupled Feedback Sharing*. [arXiv:2608.12831v1](https://arxiv.org/abs/2608.12831v1), Section 2, Theorem 5.2 and Corollary 5.3 (2026).
6. D. Lee, W. Lu, A. Makur and J. Singh. *Doeblin Curves*. [arXiv:2606.19859v1](https://arxiv.org/abs/2606.19859v1). IEEE Transactions on Information Theory 72(6), 3556–3596 (2026). DOI: [10.1109/TIT.2026.3678229](https://doi.org/10.1109/TIT.2026.3678229).
7. M. Grötschel, L. Lovász and A. Schrijver. *The Ellipsoid Method and Its Consequences in Combinatorial Optimization*. Combinatorica 1, 169–197 (1981). DOI: [10.1007/BF02579273](https://doi.org/10.1007/BF02579273). The separation–optimization framework is used in Section 6; Section 7 of this source is also compared for classical weighted fractional-coloring complexity.
8. Anonymous. *Exact Frontier Coupling for Adaptive Language Model Policy Evaluation*. ICLR 2027 submission, [OpenReview forum wUdENl8C8r](https://openreview.net/forum?id=wUdENl8C8r). Official full text remains unavailable; the scope-qualified comparison is discussed in Section 13.4. No technical assertion relies on this source.
9. O. Angel and Y. Spinka. *Pairwise optimal coupling of multiple random variables*. [arXiv:1903.00632v2](https://arxiv.org/abs/1903.00632v2) (2021 revision of the 2019 preprint), introduction and Theorems 2–3.
10. J. V. Kujala and E. N. Dzhafarov. *Contextuality and dichotomizations of random variables*. [Author-hosted manuscript](https://www3.psych.purdue.edu/~ehtibar/publications/dichotomizations.mod5.pdf), Definition 2 and Section 3.
11. M. W. Padberg and M. R. Rao. *Odd Minimum Cut-Sets and b-Matchings*. Mathematics of Operations Research 7(1), 67–80 (1982). DOI: [10.1287/moor.7.1.67](https://doi.org/10.1287/moor.7.1.67). Used only for the classical odd-set separation algorithm.
12. W. Ma. *Order-Optimal Correlated Rounding for Fulfilling Multi-Item E-Commerce Orders*. Manufacturing & Service Operations Management 25(4), 1324–1337 (2023). DOI: [10.1287/msom.2023.1219](https://doi.org/10.1287/msom.2023.1219). Numbering refers to the [author full version, arXiv:2207.04774v4](https://www.columbia.edu/~wm2428/papers/correlated_rounding_ecommerce.pdf), Theorem 1, Lemma 4, Corollary 1 and Section 4.
13. G. Georgakopoulos, D. Kavvadias and C. H. Papadimitriou. *Probabilistic Satisfiability*. Journal of Complexity 4(1), 1–11 (1988). DOI: [10.1016/0885-064X(88)90006-4](https://doi.org/10.1016/0885-064X(88)90006-4). [Original journal text](https://users.ime.usp.br/~mfinger/home/psat/GeorgakoPoulousKavvadiasPapdimitriou-ProbSAT-1988.pdf), Proposition 1, Corollary 1 and Theorem 1.
14. M. R. Garey, D. S. Johnson and L. Stockmeyer. *Some simplified NP-complete graph problems*. Theoretical Computer Science 1(3), 237–267 (1976). DOI: [10.1016/0304-3975(76)90059-1](https://doi.org/10.1016/0304-3975(76)90059-1). Classical graph 3-colorability is the imported source problem.
15. A. Chen, D. G. Harris and A. Srinivasan. *Partial resampling to approximate covering integer programs*. Random Structures & Algorithms 58(1), 68–93 (2021). DOI: [10.1002/rsa.20964](https://doi.org/10.1002/rsa.20964). [Author full text](https://www.cs.umd.edu/~srin/PDF/2020/lll-covering.pdf), Theorems 5.5–5.6.
16. E. R. Scheinerman and D. H. Ullman. *Fractional Graph Theory: A Rational Approach to the Theory of Graphs*. Wiley (1997). [Author-released text](https://www.ams.jhu.edu/ers/wp-content/uploads/2015/12/fgt.pdf), Section 3.9, Theorem 3.9.2. Used for background on general fixed-threshold fractional coloring, not as a theorem for the present bounded triangle-incidence class.

