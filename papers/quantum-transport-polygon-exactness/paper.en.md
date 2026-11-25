# Exact polygon bounds for quantum transport costs

*Optimal values and nested projection constructions for arbitrary finite spectra*

24 November 2026

## Research status and attribution

This is an AI-assisted research manuscript with complete written proofs. It is not an externally peer-reviewed paper and does not claim a machine-checked proof. Its motivating problem is the polygon-bound question in Conjecture 7.7 of the anonymous Evidence Press research note *Quantum transport cost cones: exponent monotonicity, sharp operator-norm approximation and the sign of the centred cost*, version 0.1.0-candidate, 15 November 2026, DOI 10.5281/zenodo.24261889 [EP]. The original cost-cone definitions are due to Bunth, Pitrik, Titkos and Virosztek [BPTV].

The exponent-monotonicity conjecture of [BPTV] has already been addressed by [EP] and by the separate TrureTuring cost-cone-monotonicity record. We do not claim that result as new. Our target is the subsequent exact-approximation question. The proof below is self-contained for the comparison with exponent-$p$ quantum costs, $0<p\le1$: it does not assume the retraction or the exponent-monotonicity theorem asserted by [EP].

The general connection between maximum cycle means and minimax approximation by potential differences is established background; tropical formulations of logarithmic Chebyshev fitting are studied in [KS]. Approximation by semimetrics and its shortest-path connections are treated in [BDST], while fitting arbitrary distance data on the real line is studied in [HIL]. We use these established graph and optimization ideas. The new structural claim proved here is the reduction of all signed cycles to increasing polygons under the two explicit ordered interval inequalities below, together with its quantum consequence. The literature comparison is limited to the sources discussed in this manuscript; it is not a claim of certified global priority.

## Abstract

We prove that the polygon lower bound for approximating a superlinear spectral transport cost by exponent-$p$ costs, $0<p\le1$, is exact for every finite spectrum. An optimal approximant is the exponent-one cost of a monotone function of the original observable, equivalently a positive combination of at most $n-1$ nested spectral-projection costs for $n$ spectral levels. The result extends to every nonnegative ordered array satisfying superadditivity and an interval four-point inequality, and hence to every convex nondecreasing function of the spectral gaps that vanishes at zero. The main combinatorial lemma identifies the maximum mean signed cycle with the maximum over increasing polygons. A peak-lifting operation proves this lemma: an extremal cycle with a nonglobal peak can be split into shorter equally extremal cycles. A second proof uses an interval-weight decomposition and cyclic coloring. The common optimum is computable by $O(n^3)$ exact arithmetic operations, and a maximizing polygon together with a feasible monotone potential gives a short, independently checkable optimality certificate. We also separate the superlinear conclusion from the sublinear range: the distance claim is zero there, while the assertion of a single exponent-one observable is generally false.

## 1. Ordered arrays and the exact scalar approximation problem

Let $n\ge1$. Consider a symmetric real **ordered interval array** $a=(a_{ij})_{i,j=1}^n$ with $a_{ii}=0$, $a_{ij}\ge0$, and the following inequalities:

$$
a_{ik}\ge a_{ij}+a_{jk}\qquad(i<j<k), \tag{1.1}
$$

$$
a_{il}+a_{jk}\ge a_{ik}+a_{jl}\qquad(i<j<k<l). \tag{1.2}
$$

We call (1.1) superadditivity and (1.2) the interval four-point inequality. The index order in (1.2) is part of its hypothesis. In particular, we do not assert that the full antisymmetric matrix introduced in Section 2 is globally Monge.

For an increasing chain $i_0<i_1<\cdots<i_m$, $m\ge2$, define its polygon deficit and normalized deficit by

$$
D(i_0,\ldots,i_m)
=a_{i_0i_m}-\sum_{r=1}^m a_{i_{r-1}i_r},
\qquad
\delta(i_0,\ldots,i_m)=\frac{D(i_0,\ldots,i_m)}{m+1}. \tag{1.3}
$$

Put

$$
\delta_*(a)=\max\left(\{0\}\cup
\{\delta(i_0,\ldots,i_m):i_0<\cdots<i_m,\ m\ge2\}\right). \tag{1.4}
$$

The explicit zero handles $n\le2$. By (1.1), every deficit in (1.3) is nonnegative. A maximum error over no pairs, when $n=1$, is understood to be zero; this case is immediate in every result below.

### Theorem 1.1. Exact monotone approximation

For every nonnegative ordered interval array satisfying (1.1) and (1.2),

$$
\min_{y_1\le\cdots\le y_n}
\max_{i<j}|a_{ij}-(y_j-y_i)|=\delta_*(a). \tag{1.5}
$$

The minimum is attained. In fact, the same value is obtained if one first solves the signed difference constraints without requiring monotonicity and then replaces the solution by its running maximum.

The lower bound follows immediately by adding the errors along any increasing chain. The main issue is the upper bound, which is a feasibility assertion for all difference constraints simultaneously. Checking individual triangles is insufficient; the proof must control arbitrary directed cycles.

## 2. A maximum-cycle-mean theorem

For distinct $i,j$, set

$$
c(i,j)=
\begin{cases}
a_{ij},&i<j,\\
-a_{ij},&i>j.
\end{cases} \tag{2.1}
$$

If $C=(v_0,v_1,\ldots,v_{N-1},v_0)$ is a directed simple cycle, write

$$
D(C)=-\sum_{t=0}^{N-1}c(v_t,v_{t+1}),
\qquad \lambda(C)=D(C)/N. \tag{2.2}
$$

A two-vertex cycle has deficit zero. A cycle with one descending edge is an increasing chain followed by its closing edge, and its mean is exactly (1.3).

### Lemma 2.1. Increasing polygons suffice

For an array with $n\ge2$ satisfying (1.1) and (1.2),

$$
\max_C\lambda(C)=\delta_*(a), \tag{2.3}
$$

where the maximum on the left is over directed simple cycles of length at least two.

#### Proof

Let $\lambda=\max_C\lambda(C)$. Increasing polygons and two-vertex cycles are among these cycles, so $\lambda\ge\delta_*(a)\ge0$. If $\lambda=0$, equality follows. Suppose $\lambda>0$, and choose a maximizing cycle with the fewest edges; denote its length by $N$.

**First shortcut.** The cycle has no two consecutive descending edges. If $u>v>w$ occur successively, (1.1) gives

$$
c(u,w)=-a_{uw}\le-a_{uv}-a_{vw}=c(u,v)+c(v,w).
$$

Deleting $v$ therefore does not decrease the deficit and reduces the number of edges by one. As the original deficit $N\lambda$ is positive, the new mean is strictly greater than $\lambda$, a contradiction. The resulting cycle has at least two vertices: a positive-mean cycle cannot be a two-vertex cycle, and removing one vertex from a simple cycle of length at least three gives a cycle of length at least two.

**Second shortcut.** At every local peak $v$, with predecessor $u<v$ and successor $w<v$, one must have $w<u$. Indeed, if $u<w<v$, (1.1) yields

$$
c(u,w)=a_{uw}\le a_{uv}-a_{wv}=c(u,v)+c(v,w),
$$

and the same deletion gives a strictly better mean. The equality $u=w$ is impossible in a simple cycle of length at least three.

**Peak lifting.** Let $M$ be the largest vertex in the selected cycle. Suppose it has another local peak $v<M$. Its adjacent vertices satisfy $w<u<v<M$. Replace the segment $u\to v\to w$ by $u\to M\to w$. By (1.2),

$$
a_{wM}+a_{uv}\ge a_{wv}+a_{uM},
$$

so

$$
\underbrace{a_{wM}-a_{uM}}_{\text{new deficit}}
\ge
\underbrace{a_{wv}-a_{uv}}_{\text{old deficit}}. \tag{2.4}
$$

The new closed walk has the same length and at least the old deficit. It visits $M$ exactly twice, and no other vertex repeats. Moreover, the two visits are not adjacent: neither neighbor $u,w$ equals $M$. Splitting at $M$ therefore gives two directed simple cycles, each with at least two edges and each strictly shorter than $N$.

Every simple cycle has mean at most $\lambda$. On the other hand, these two cycles together have deficit at least $N\lambda$ and total length $N$. Consequently both have mean exactly $\lambda$. This contradicts the minimal length of our chosen maximizing cycle.

There is thus only one local peak, namely $M$. Since consecutive descents have already been excluded, the tail of every descending edge is a local peak. It follows that the cycle has exactly one descending edge. It is an increasing polygon, hence $\lambda\le\delta_*(a)$. This proves (2.3). $\square$

The use of the shortest maximizing cycle is essential. It is generally false that, on a fixed vertex set, the sorted Hamiltonian cycle minimizes the total signed cost. The argument permits a smaller vertex set and compares the means, not merely the total costs.

## 3. Difference constraints and monotone potentials

We prove Theorem 1.1 using the standard feasibility criterion for difference constraints and shortest-path potentials. These general graph tools, as well as the broader cycle-mean formulation of potential fitting [KS] and shortest-path methods in metric nearness [BDST], are not claimed as new. Lemma 2.1 provides the specialized cycle reduction needed here. Set $\delta=\delta_*(a)$ and give the directed complete graph the edge weights

$$
w(i,j)=c(i,j)+\delta\qquad(i\ne j). \tag{3.1}
$$

By Lemma 2.1, every directed simple cycle has nonnegative total weight. Every closed walk decomposes into simple cycles, so no negative closed walk exists.

Adjoin a new source with a zero-weight edge to each vertex. Let $z_j$ be the least weight of a path from the source to $j$. These minima exist and are finite: removing any nonnegative cycle from a path never increases its weight, leaving only finitely many simple paths to consider. Appending an edge gives

$$
z_j-z_i\le w(i,j).
$$

Applying this inequality in both directions yields, for $i<j$,

$$
a_{ij}-\delta\le z_j-z_i\le a_{ij}+\delta. \tag{3.2}
$$

Now define

$$
y_j=\max_{h\le j}z_h. \tag{3.3}
$$

This sequence is nondecreasing. To verify the lower bound in (3.2) for $y$, choose $h\le i$ such that $y_i=z_h$. Then

$$
y_j-y_i\ge z_j-z_h\ge a_{hj}-\delta\ge a_{ij}-\delta,
$$

where the last inequality follows from nonnegativity and (1.1), or is equality when $h=i$.

For the upper bound, choose $k\le j$ such that $y_j=z_k$. If $k\le i$, monotonicity of the running maximum gives $y_j-y_i=0\le a_{ij}+\delta$. Otherwise $i<k\le j$, and

$$
y_j-y_i\le z_k-z_i\le a_{ik}+\delta\le a_{ij}+\delta.
$$

Thus $y$ is feasible with error at most $\delta$.

Conversely, any monotone $y$ with error at most $\varepsilon$ satisfies, along an increasing chain,

$$
a_{i_0i_m}-\varepsilon
\le y_{i_m}-y_{i_0}
=\sum_{r=1}^m(y_{i_r}-y_{i_{r-1}})
\le\sum_{r=1}^m a_{i_{r-1}i_r}+m\varepsilon.
$$

Therefore $\varepsilon\ge D(i_0,\ldots,i_m)/(m+1)$ for every chain, and hence $\varepsilon\ge\delta_*$. This establishes (1.5). $\square$

### Corollary 3.1. Equality of three projection problems

Let $\operatorname{MET}_n$ be the cone of nonnegative symmetric arrays with zero diagonal satisfying all triangle inequalities. Let $\operatorname{CUT}_n$ be the cone generated by the cut arrays $|\mathbf 1_S(i)-\mathbf 1_S(j)|$, and let $\operatorname{PATH}_n$ consist of the arrays $y_j-y_i$, $i<j$, for $y_1\le\cdots\le y_n$. For every array covered by Theorem 1.1,

$$
\operatorname{dist}_{\ell_\infty}(a,\operatorname{MET}_n)
=\operatorname{dist}_{\ell_\infty}(a,\operatorname{CUT}_n)
=\operatorname{dist}_{\ell_\infty}(a,\operatorname{PATH}_n)
=\delta_*(a). \tag{3.4}
$$

Indeed, $\operatorname{PATH}_n\subseteq\operatorname{CUT}_n\subseteq\operatorname{MET}_n$. The first inclusion follows by summing the consecutive tail cuts with weights $y_{r+1}-y_r$, and the second follows from the triangle inequality for each cut. Every member of $\operatorname{MET}_n$ satisfies every polygon inequality, so the argument giving the lower bound in Theorem 1.1 also applies to the largest of these cones. Theorem 1.1 attains that lower bound in the smallest one. All three infima are therefore attained by the same ordered line semimetric; coincident values of $y_i$ are allowed.

## 4. Consequence for quantum transport costs

Let $\mathcal H$ be a complex Hilbert space. Let $P_1,\ldots,P_n$ be nonzero mutually orthogonal projections with $\sum_iP_i=I$. For a symmetric array with zero diagonal, put

$$
D_P(a)=\sum_{i,j}a_{ij}P_i\otimes P_j^T. \tag{4.1}
$$

For a bounded selfadjoint $B$, define

$$
G_p(B)=|B\otimes I-I\otimes B^T|^p. \tag{4.2}
$$

The transpose acts on the conjugate Hilbert space. Let $\mathcal C_p$ be the cone of finite sums of (4.2) with finite-spectrum observables $B$. Positive coefficients can be absorbed into $B$ because $G_p(tB)=t^pG_p(B)$ for $t\ge0$.

### Theorem 4.1. Exact operator-norm distance

Let $0<p\le1$ and let $a$ satisfy (1.1) and (1.2). Then

$$
\inf_{C\in\mathcal C_p}\|D_P(a)-C\|_{\mathrm{op}}=\delta_*(a). \tag{4.3}
$$

The infimum is attained by

$$
C_*=G_1(Y)=\sum_{r=1}^{n-1}(y_{r+1}-y_r)G_p(Q_r),
\quad
Y=\sum_i y_iP_i,
\quad
Q_r=\sum_{i>r}P_i, \tag{4.4}
$$

where $y$ is any monotone optimal potential from Theorem 1.1. Zero summands may be omitted. Thus at most $n-1$ two-level observables suffice. The lower bound remains valid if the competing cone is enlarged to finite sums generated by arbitrary bounded selfadjoint observables, so this enlargement does not change the optimum.

#### Proof of the lower bound

Choose a unit vector $e_i$ in the range of every $P_i$. For one summand $G_p(B)$, let $Z_i$ be independent real random variables with the spectral distributions of $B$ in the states $e_i$. For distinct indices $i,j$, the spectral theorem gives

$$
c_{ij}:=\langle e_i\otimes\overline{e_j},G_p(B)(e_i\otimes\overline{e_j})\rangle
=\mathbb E|Z_i-Z_j|^p. \tag{4.5}
$$

For $0<p\le1$, $|s-t|^p$ obeys the triangle inequality. Coupling all the $Z_i$ independently and applying it pointwise along any chain shows

$$
c_{i_0i_m}\le\sum_{r=1}^m c_{i_{r-1}i_r}. \tag{4.6}
$$

The same inequality holds after summing over the observables in a finite cost. If $\|D_P(a)-C\|_{\mathrm{op}}\le\varepsilon$, the product-vector entries differ from $a_{ij}$ by at most $\varepsilon$. Substitution in (4.6) gives

$$
a_{i_0i_m}-\varepsilon\le
\sum_{r=1}^m a_{i_{r-1}i_r}+m\varepsilon.
$$

Hence $\varepsilon\ge\delta_*$. Formula (4.5) and the same proof remain valid for any bounded selfadjoint $B$, since its spectral probability measures have bounded support.

#### Proof of attainment

The projections $P_i\otimes P_j^T$ are mutually orthogonal and nonzero. For the potential $y$,

$$
G_1(Y)=\sum_{i,j}|y_i-y_j|P_i\otimes P_j^T,
$$

so Theorem 1.1 gives

$$
\|D_P(a)-G_1(Y)\|_{\mathrm{op}}
=\max_{i<j}|a_{ij}-(y_j-y_i)|\le\delta_*.
$$

For every projection $Q$, $G_p(Q)=G_1(Q)$: the eigenvalues of $Q\otimes I-I\otimes Q^T$ belong to $\{-1,0,1\}$. For $i<j$, exactly the cuts $Q_i,\ldots,Q_{j-1}$ separate the two spectral blocks. Thus the right side of (4.4) has coefficient

$$
\sum_{r=i}^{j-1}(y_{r+1}-y_r)=y_j-y_i
$$

on $P_i\otimes P_j^T$. This proves (4.4) and membership in $\mathcal C_p$. $\square$

### Corollary 4.2. Convex spectral costs

Let $x_1<\cdots<x_n$, and let $f:[0,\infty)\to[0,\infty)$ be convex and nondecreasing with $f(0)=0$. Then Theorem 4.1 applies to

$$
a_{ij}=f(|x_i-x_j|). \tag{4.7}
$$

Indeed, convexity and $f(0)=0$ imply superadditivity. To obtain (1.2), use the fact that the increment $f(t+h)-f(t)$ is nondecreasing in $t$ for every fixed $h\ge0$, with $h=x_j-x_i$ and bases $x_k-x_j\le x_l-x_j$.

In particular, for $q\ge1$ and $A=\sum_i x_iP_i$,

$$
\boxed{\displaystyle
\operatorname{dist}_{\mathrm{op}}(G_q(A),\mathcal C_p)
=\max_{i_0<\cdots<i_m}
\frac{(x_{i_m}-x_{i_0})^q-
\sum_{r=1}^m(x_{i_r}-x_{i_{r-1}})^q}{m+1}}
\qquad(0<p\le1), \tag{4.8}
$$

where $m\ge2$ and a zero is included in the maximum. This is the polygon formula in the superlinear regime of [EP, Conjecture 7.7], now for arbitrary finite $n$.

### Corollary 4.3. Uniform pure-state transport error

Let $L_C(\rho,\sigma)=\inf_{\Pi\in\Gamma(\rho,\sigma)}\operatorname{Tr}(C\Pi)$ be the optimal transport value for the channel-based coupling convention of [BPTV], before taking any root or subtracting self-costs. If both marginals are pure, their coupling is unique and equals the product of the two pure states, with the appropriate transpose. Therefore

$$
\inf_{C\in\mathcal C_p}\sup_{\rho,\sigma\ \mathrm{pure}}
|L_{D_P(a)}(\rho,\sigma)-L_C(\rho,\sigma)|=\delta_*(a). \tag{4.9}
$$

The upper bound follows from (4.3), and the lower bound already uses only the pure eigenstates $e_i$ in the preceding proof. This statement concerns transport values, not the centered divergence or its metric property.

## 5. Algorithm and exact certificates

The maximum in (1.4) can be restricted to chains whose endpoints are $1$ and $n$. To extend a left endpoint $i_0>1$ to $1$, use (1.2) on $1<i_0<i_1<i_m$:

$$
a_{1i_m}-a_{i_0i_m}\ge a_{1i_1}-a_{i_0i_1}.
$$

Thus extending the endpoint cannot reduce the deficit. Extending the right endpoint is analogous. The argument only concerns chains with at least two edges; single-edge chains have deficit zero.

For $1\le m\le n-1$, let

$$
V_{m,j}=\min_{1=i_0<\cdots<i_m=j}
\sum_{r=1}^m a_{i_{r-1}i_r}.
$$

With $V_{0,1}=0$ and other impossible values equal to $+\infty$,

$$
V_{m,j}=\min_{i<j}(V_{m-1,i}+a_{ij}),
\qquad
\delta_*=
\max_{1\le m\le n-1}\frac{a_{1n}-V_{m,n}}{m+1}. \tag{5.1}
$$

For $n\le1$ take $\delta_*=0$ directly. The dynamic program uses $O(n^3)$ arithmetic operations and $O(n^2)$ memory. The shortest-path construction in Section 3 takes $O(n^3)$ additional operations by Bellman--Ford on the dense graph. Running maxima and the cut weights then take $O(n)$ operations.

These are exact-arithmetic counts, not a uniform bit-complexity claim for arbitrary real inputs. Rational arrays yield rational deficits, potentials, and cut weights, and all certificates can be checked using rational arithmetic. Integer exponents and rational spectral points supply such arrays.

An optimality certificate consists of:

1. an increasing chain attaining the claimed value of $\delta$;
2. a monotone potential $y$ satisfying $|a_{ij}-(y_j-y_i)|\le\delta$ for every pair.

The first gives a universal lower bound, including against noncommuting observables. The second gives an explicit quantum cost attaining it. Verifying these two parts takes $O(n^2)$ pairwise checks, independently of the optimization code that discovered them.

### Example 5.1. Five equally spaced levels

Take $x=(0,1,2,3,4)$ and $q=2$. The chain $(0,2,4)$ gives

$$
\delta_*=(16-4-4)/3=8/3.
$$

The potential $y_i=(10/3)x_i$ has errors $7/3,8/3,1,8/3$ at separations $1,2,3,4$, respectively. It therefore attains the lower bound. For every $0<p\le1$,

$$
C_*=(10/3)\sum_{r=1}^4G_p(Q_r),
\qquad
\|G_2(A)-C_*\|_{\mathrm{op}}=8/3.
$$

This example is a check of the general theorem, not its proof.

## 6. The sublinear range and the exact scope of the conjecture

For $0<q<1$, the polygon deficits in [EP] are zero by subadditivity. The distance to every $\mathcal C_p$, $0<p\le1$, is also zero. One elementary cut representation is

$$
|x-y|^q=\frac{q(1-q)}2
\int_0^\infty\int_{\mathbb R}
\left|\mathbf 1_{[t,t+s]}(x)-\mathbf 1_{[t,t+s]}(y)\right|
\,\mathrm dt\,s^{q-2}\,\mathrm ds. \tag{6.1}
$$

For fixed $s$, the inner integral is $2\min\{|x-y|,s\}$. Splitting the remaining integral at $s=|x-y|$ verifies (6.1). On a finite set of points only finitely many cut patterns occur. Grouping by those patterns gives a finite positive cut decomposition; every coefficient of a nontrivial pattern is finite because that pattern separates at least one pair whose total integral is finite. The spectral lift of each cut is a projection cost, which is independent of $p$.

However, a **single exponent-one function of the original observable** cannot generally attain this zero error. For the three points $0,1,2$, the target distances are $1,1,2^q$. None equals the sum of the other two when $0<q<1$. Any three points on the real line have one distance equal to the sum of the other two. Thus no real function on these three points represents all the target distances exactly at exponent one, even without requiring monotonicity.

Accordingly, the distance portion of the polygon question holds throughout $q>0$: Section 6 covers $q<1$, $q=1$ is immediate, and Theorem 4.1 covers $q>1$. The single-observable attainment assertion must be restricted to $q\ge1$. If Conjecture 7.7 is read literally without this restriction, that additional assertion has the elementary counterexample above. We do not present a correction of this wording as the main research advance.

## Appendix A. An independent proof by interval weights and cyclic coloring

This proof of Lemma 2.1 is included as an independent check of the peak-lifting argument.

Use indices $0,\ldots,n-1$ in this appendix. For $1\le u<v\le n-1$, define

$$
\omega_{uv}=a_{u-1,v}-a_{u,v}-a_{u-1,v-1}+a_{u,v-1}. \tag{A.1}
$$

When $v=u+1$, this is a superadditivity deficit. Otherwise it is an interval four-point deficit. Hence $\omega_{uv}\ge0$. Telescoping gives

$$
a_{ij}=\sum_{t=i}^{j-1}a_{t,t+1}
+\sum_{i<u<v\le j}\omega_{uv}
\qquad(i<j). \tag{A.2}
$$

Choose a positive maximum-mean simple cycle. The two shortcut arguments in Section 2 apply, so descending edges are isolated, and no local peak has predecessor smaller than successor. Let its length be $N$ and its number of descending edges be $r$. Exactly $N-2r$ vertices have both their incoming and their outgoing edge ascending; call them ascending-through vertices.

Fix an interval $I=\{u,\ldots,v-1\}$ strictly between the minimum and maximum vertices of the cycle. Let $L=\{0,\ldots,u-1\}$ and $R=\{v,\ldots,n-1\}$. The coefficient of $\omega_{uv}$ in the cycle deficit is

$$
c_I=\#(R\to L)-\#(L\to R), \tag{A.3}
$$

where these counts refer to direct edges. Collapse each maximal consecutive run of vertices in $I$ to its entry and exit. Flow balance in the remaining cyclic $L/R$ sequence gives

$$
c_I=\#(L\to I\text{-run}\to R)
-\#(R\to I\text{-run}\to L). \tag{A.4}
$$

The first vertex of every forward run in (A.4) is ascending-through. Its predecessor lies in $L$. If its successor were a smaller vertex in $I$, the predecessor would still be smaller than that successor, creating precisely the forbidden net-ascending peak shortcut. If the run has one vertex, its successor lies in $R$ and is automatically larger. Different forward runs have different first vertices. Consequently

$$
c_I\le k_I,
\qquad c_I\le r, \tag{A.5}
$$

where $k_I$ counts ascending-through vertices in $I$.

List all ascending-through vertices in increasing spectral order and color them cyclically with $r$ colors. Every interval containing $k_I$ listed vertices contains exactly $\min\{r,k_I\}$ distinct colors. For each color, form an increasing chain using its vertices and the minimum and maximum vertices of the cycle as endpoints. An empty color gives the two-edge cycle between those endpoints and has deficit zero.

For an interval $I$ strictly inside the endpoints, the coefficient of $\omega_{uv}$ in a color polygon deficit is one if the chain contains a vertex of that color in $I$, and zero otherwise. Thus the sum of the color-polygon coefficients is $\min\{r,k_I\}\ge c_I$. Intervals not strictly inside the common endpoints have coefficient zero in both the original cycle and all color polygons, so they may be omitted. The adjacent linear part of (A.2) cancels in every closed cycle. Since all $\omega_{uv}\ge0$, the total deficit of the color polygons is at least the original deficit.

The color polygons have total length

$$
(N-2r)+2r=N.
$$

At least one therefore has mean at least the original cycle's mean. This proves (2.3). $\square$

## References

[BPTV] Gergely Bunth, József Pitrik, Tamás Titkos, and Dániel Virosztek. *Wasserstein distances and divergences of order $p$ by quantum channels*. arXiv:2501.08066v3, 27 April 2026. https://arxiv.org/html/2501.08066v3 . Relevant definitions: equations (22), (27), and (28); existing exponent-monotonicity conjecture: Conjecture 9; existing three-level analysis: Corollary 14.

[EP] Anonymous. *Quantum transport cost cones: exponent monotonicity, sharp operator-norm approximation and the sign of the centred cost*. Version 0.1.0-candidate, Evidence Press, 15 November 2026. DOI 10.5281/zenodo.24261889. https://www.evidencepress.org/releases/quantum-transport-cost-cones/ . Fixed manuscript source: https://github.com/ipitchford/quantum-transport-cost-cones/blob/270f5dba795ffd73d271bfde959237b730227c5e/manuscript.tex . Relevant statements: Proposition 7.5, Proposition 7.6, and Conjecture 7.7. This is an unrefereed AI-assisted candidate, not an established peer-reviewed baseline.

[TT] TrureTuring. *Monotonicity of finite-spectrum quantum transport cost cones*. https://www.trureturing.org/research/bunth-pitrik-titkos-virosztek-2025-cost-cone-monotonicity/ . This is prior work on the exponent-monotonicity question, not on the subsequent polygon-bound question solved here.

[KS] Nikolai Krivulin and Sergei Sergeev. *Tropical implementation of the Analytical Hierarchy Process decision method*. Fuzzy Sets and Systems 377 (2019), 31--51. DOI 10.1016/j.fss.2018.10.013. https://arxiv.org/abs/1802.01989 . Accepted manuscript: https://pure-oai.bham.ac.uk/ws/portalfiles/portal/54963804/Tropical_implementation_of_the_AHP_decision_method.pdf . Background on cycle means, tropical optimization, and logarithmic Chebyshev fitting.

[BDST] Justin Brickell, Inderjit S. Dhillon, Suvrit Sra, and Joel A. Tropp. *The Metric Nearness Problem*. SIAM Journal on Matrix Analysis and Applications 30(1) (2008), 375--396. DOI 10.1137/060653391. https://tropp.caltech.edu/papers/BDST08-Metric-Nearness.pdf . General semimetric approximation and shortest-path connections; it does not by itself supply the ordered line attainment proved here.

[HIL] Johan Håstad, Lars Ivansson, and Jens Lagergren. *Fitting Points on the Real Line and its Application to RH Mapping*. Author manuscript: https://people.kth.se/~johanh/finalrsahll.pdf . General approximation of distance data by real-line configurations.
