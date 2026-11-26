---
title: "Sharp Monotone Support Paths in Finite Moment Optimization"
subtitle: "Strict likelihood-ratio order, degenerate pivots, and k-wise independent bits"
date: "26 November 2026"
lang: en
---

# Abstract

Consider a probability distribution on an ordered finite set, and maximize its right endpoint mass subject to prescribed generalized moments. We study the optimizer when the reference distribution defining those moments varies in strict monotone likelihood-ratio order. For a moment matrix with a constant row and strictly positive ordered maximal minors, we prove that every admissible paired basis has an interval of feasibility, that optimizing pair indices move coordinatewise to the right, and that a suffix-block pivot gives the successor at every simultaneous or degenerate transition. With $n+1$ grid points and $k$ nonconstant moment constraints, the number of positive-length regimes is at most $\lfloor k/2\rfloor(n-k)+1$. This bound is attained for every $1\leq k\mathrel{<}n$ within the class of ordinary integer-grid moments. A complementary-grid inequality strengthens the pivot rule for binomial-normalized log-convex carriers: a departing pair cannot have an adjacent pair on its right. For binomial reference laws this proves the interior support-order and unit-pivot assertions in the nonboundary range of recent conjectures on $k$-wise independent bits, while identifying the necessary endpoint and dimension qualifications. The resulting complete binomial phase diagram has polynomial algebraic output and bit complexity in the expanded grid dimensions. A positive, strictly stochastically increasing family on four points can instead have arbitrarily many support changes. Exact finite certificates supplement the proofs.

# 1. Problem and contribution

Sharp probability bounds with partial moment information are classical linear programs. Their paired extremal supports, interpolation formulas, and generalized-convex dual certificates are established components of discrete moment theory [P90, CD08, GP09, NP13]. The question here concerns the whole path of the optimizer as the moment vector changes. A fixed-input solution method does not by itself bound the number of bases encountered along a parameter curve.

A concrete motivation comes from the maximum probability that $n$ bits are all one, when any $k$ of them are independent and each bit has mean $p$. Berend, Ernst, Kontorovich, and Kumar [BEKK26] give exact formulas and numerical support-path conjectures. Hermann [H26] proves a reflection relation and explicitly distinguishes endpoint degeneracy from interior feasibility. We retain those distinctions. In particular, we do not claim that a basis is feasible on a connected subset of the entire closed interval $[0,1]$; that statement is false.

The contribution is a full strict-MLR path theorem for the classical sign-consistent moment configuration, including its degenerate successor and a sharp regime count. The second structural ingredient is a positivity inequality that forbids block pivots for binomial-normalized log-convex carriers. Together these give a complete algebraic sweep for the binomial problem. The static paired-support pattern, the matrix class itself, interpolation, reflection, and the standard real-algebraic subroutines are not new claims. The proofs below separate these inputs from the path arguments.

# 2. Ordered moment configurations

## 2.1. Definitions

Fix integers $1\leq k\mathrel{<}n$. Let $A$ be a real $(k+1)\times(n+1)$ matrix with ordered columns $A_0,\ldots,A_n$. Assume its first row is all ones and

$$
\det(A_{i_0},\ldots,A_{i_k})>0
\quad\text{whenever }0\leq i_0\mathrel{<}\cdots\mathrel{<}i_k\leq n. \tag{2.1}
$$

A common negative sign can be made positive by reversing one nonconstant row. The assumption concerns maximal minors only; positivity of all lower-order minors is unnecessary. Matrices with this sign consistency and their relation to alternating configurations are classical [Pe95, GP09]. The polynomial moment matrix $A_{ri}=x_i^r$ on any strictly increasing real grid satisfies (2.1) by the Vandermonde formula.

For a positive probability vector $\mu=(\mu_0,\ldots,\mu_n)$, define

$$
V_A(\mu)=\max\{q_n:q_i\geq0,\ Aq=A\mu\}. \tag{2.2}
$$

The first row imposes $\sum_iq_i=1$. The feasible set is nonempty and compact. Its data are the generalized moments $A\mu$; no shape restriction is imposed on the competing law $q$.

Put $m=\lfloor k/2\rfloor$. An **upper paired basis** has the following form:

$$
\begin{split}
k=2m:&\quad B=\{a_1,a_1+1,\ldots,a_m,a_m+1,n\},\quad 0\leq a_1,\ a_{r+1}\geq a_r+2,\ a_m\leq n-2;\\
k=2m+1:&\quad B=\{0,a_1,a_1+1,\ldots,a_m,a_m+1,n\},\quad 1\leq a_1,\ a_{r+1}\geq a_r+2,\ a_m\leq n-2.
\end{split} \tag{2.3}
$$

When $k=1$, the second line means $B=\{0,n\}$. The movable paired part is denoted $J$. Its available-node count is $M=n$ for even $k$ and $M=n-1$ for odd $k$, so

$$M-2m=n-k. \tag{2.4}$$

For $j\in B$ define the cardinal coefficient and the interpolatory mass by

$$
\ell_{B,j}(i)=(A_B^{-1}A_i)_j,
\qquad \beta_{B,j}(\mu)=\sum_{i=0}^n\mu_i\ell_{B,j}(i). \tag{2.5}
$$

The basis is **feasible** if all these masses are nonnegative, and **nondegenerate** if all are positive. The ordering of coordinates in $A_B$ is the increasing ordering of $B$.

## 2.2. Cardinal signs and a static certificate

**Lemma 2.1 (cardinal signs).** For an upper paired basis, a left pair node $j$ satisfies $\ell_{B,j}(i)\geq0$ for $i\leq j$ and $\ell_{B,j}(i)\leq0$ for $i>j$. For a right pair node, $\ell_{B,j}(i)\leq0$ for $i\mathrel{<}j$ and $\ell_{B,j}(i)\geq0$ for $i\geq j$. At every $i\notin B$ the relevant inequality is strict. Also $\ell_{B,n}$ is nonnegative everywhere and strictly positive at $n$ and outside $B$. For odd $k$, the same endpoint assertion holds for $\ell_{B,0}$.

*Proof.* At basis columns the coefficients are Kronecker coordinates. Otherwise Cramer's rule expresses $\ell_{B,j}(i)$ as the determinant obtained by replacing column $j$ by $A_i$, divided by the positive determinant of $A_B$. Sorting the replacement columns changes the sign once for each basis index strictly between $i$ and $j$. An adjacent pair contributes an even number of crossings unless its partner lies between $i$ and $j$. Counting these partners gives the two asserted single-change patterns. For the right endpoint, all intervening movable indices form complete pairs, hence the sign is positive. For the left endpoint in the odd case the same argument applies. No numerator vanishes outside $B$, by (2.1). $\square$

**Lemma 2.2 (classical endpoint certificate).** Every feasible upper paired basis represents the unique optimizer of (2.2). Its endpoint mass is

$$V_A(\mu)=\beta_{B,n}(\mu)=\sum_i\mu_i\ell_{B,n}(i)>0. \tag{2.6}$$

For odd $k$, the mass at zero is positive as well.

*Proof.* Equation (2.5) gives $A_B\beta_B=A\mu$, and the constant row gives $\sum_{j\in B}\beta_{B,j}=1$. The function $\ell_{B,n}$ belongs to the row span of $A$ and majorizes the indicator of index $n$. Therefore, for every feasible $q$,

$$q_n\leq\sum_iq_i\ell_{B,n}(i)=\sum_i\mu_i\ell_{B,n}(i)=\beta_{B,n}.$$

The law on $B$ attains equality. The majorant has strict slack at every index outside $B$, so any optimal law must be supported on $B$. Invertibility of $A_B$ then proves uniqueness. Endpoint positivity follows from Lemma 2.1 and the positivity of $\mu$. $\square$

This lemma is a self-contained version of the familiar static dual argument. Existence of a feasible upper paired basis for every positive $\mu$ will follow constructively from the path proof.

# 3. Strict likelihood-ratio paths

## 3.1. One crossing for each mass

Let $I$ be a real interval, and let $t\mapsto\mu_t$ be continuous with every coordinate positive. It is **strictly MLR increasing** if, for every $s\mathrel{<}t$ in $I$,

$$i\longmapsto \frac{\mu_t(i)}{\mu_s(i)}\quad\text{is strictly increasing}. \tag{3.1}$$

In particular, every family

$$\mu_t(i)=\frac{w_i e^{t h_i}}{\sum_{r=0}^n w_r e^{t h_r}},\qquad w_i>0,\quad h_0\mathrel{<}\cdots\mathrel{<}h_n,\quad t\in\mathbb R, \tag{3.2}$$

satisfies this condition. Smoothness is not assumed in (3.1).

**Lemma 3.1 (oriented zero).** For a fixed upper paired basis, if a left-node mass vanishes at $t_0$, it is positive at every earlier parameter and negative at every later parameter in $I$. A right-node mass has the opposite orientation. Consequently each movable mass has at most one zero.

*Proof.* Suppose $\beta_{B,j}(\mu_{t_0})=0$ and $t>t_0$. With $R_i=\mu_t(i)/\mu_{t_0}(i)$, subtracting $R_j$ times the vanishing expectation gives

$$
\beta_{B,j}(\mu_t)=\sum_i\mu_{t_0}(i)(R_i-R_j)\ell_{B,j}(i). \tag{3.3}
$$

For a left node every summand is nonpositive, by Lemma 2.1. Every off-basis index contributes strictly negatively. There is such an index since $k\mathrel{<}n$. Hence the sum is negative. A decreasing likelihood ratio gives positivity for $t\mathrel{<}t_0$. For a right node all signs reverse. Two different zeros are therefore impossible. $\square$

**Corollary 3.2 (interval feasibility).** For each upper paired basis, the set

$$\{t\in I:\beta_{B,j}(\mu_t)\geq0\text{ for all }j\in B\} \tag{3.4}$$

is an interval, possibly empty or a singleton, closed relative to $I$. All its masses are positive in the interior of any positive-length feasible interval.

*Proof.* Each left-node nonnegativity set is an initial interval and each right-node nonnegativity set is a final interval. This follows from continuity and the zero orientation, also when there is no zero. Their intersection is an interval. A zero cannot occur in its positive-length interior because it would create a negative mass on one side. Endpoint masses never vanish. $\square$

## 3.2. The successor at simultaneous degeneracies

A maximal occupied block of $J$ is a maximal run of consecutive available indices belonging to $J$. Every such block has even length. Consider a finite right endpoint $t_0\in\operatorname{int}I$ of a positive-length feasible interval. Let $Z$ be the set of zero masses in $J$ at $t_0$.

**Lemma 3.3 (suffix-block successor).** The set $Z$ is nonempty and consists only of left pair nodes. In each occupied block meeting $Z$, let $a$ be its first zero left node and let $e$ be the block's last node. Remove $a$ and add $e+1$. The resulting paired set $J^+$, together with the fixed endpoint or endpoints, is feasible and nondegenerate immediately to the right of $t_0$. It is the unique nondegenerate successor.

*Proof.* If all masses were positive at $t_0$, continuity would extend feasibility to its right. A vanishing right-node mass would have been negative immediately to the left by Lemma 3.1. Hence $Z$ is nonempty and contains only left nodes.

A block reaching the last available node cannot meet $Z$. For any left node in such a terminal block, there is no off-basis index to its right; all indices to its right are basis nodes or fixed endpoints. Its cardinal coefficient is thus nonnegative everywhere and equals one at its own index. Its expectation under a positive law is strictly positive. Therefore every required index $e+1$ exists and is not in $J$.

Replacing $a$ by $e+1$ shifts the pairs beginning at $a,a+2,\ldots,e-1$ to pairs beginning at $a+1,a+3,\ldots,e$. It preserves the paired pattern. Changes in different old blocks have distinct new nodes and do not conflict, even if two resulting blocks merge.

At $t_0$ only zero-mass nodes have been removed. The old optimizing law is supported on the new basis and matches $A\mu_{t_0}$. Its new interpolatory masses therefore equal the old masses at retained indices, with zero at each new index. Any old zero retained in a shifted suffix is now a right pair node; newly added nodes are also right nodes. No zero is left before the first shifted node in an affected block. Thus every zero in the new basis is a right-node zero. Lemma 3.1 makes all of them positive to the right, and continuity preserves positivity of the other masses locally. Lemma 2.2 excludes a second nondegenerate basis there, since its positive support would differ from that of the unique optimizer. $\square$

The rule may move several adjacent pairs at once even when only one index leaves the basis. It must not be replaced by an unproved single-pair rule for arbitrary carriers.

## 3.3. Existence, the complete sweep, and its length

**Theorem 3.4 (sharp bounded monotone path).** Under (2.1), every positive reference law has a feasible upper paired basis and a unique endpoint optimizer. Along every continuous strict-MLR path, the pair-start vector of its nondegenerate optimizing basis is coordinatewise nondecreasing. The path has at most

$$R_{n,k}=\left\lfloor\frac{k}{2}\right\rfloor(n-k)+1 \tag{3.5}$$

positive-length regimes. Every finite right transition is given by Lemma 3.3. For (3.2), the sweep covers all real parameters and begins and ends at the leftmost and rightmost paired bases. The bound is sharp over the class for each $1\leq k\mathrel{<}n$.

*Proof of existence and the upper bound.* First consider (3.2). In the leftmost paired basis, every omitted index lies to the right of every movable selected index. For a movable node $j$, the cardinal expectation is its own positive mass $\mu_t(j)$ plus a fixed finite linear combination of omitted masses. Each ratio $\mu_t(i)/\mu_t(j)$ for such an omitted $i$ tends to zero as $t\to-\infty$. Hence every movable mass is positive for all sufficiently negative $t$. The fixed endpoint masses are always positive. The analogous argument at $+\infty$ applies to the rightmost basis.

Begin in the leftmost basis and extend its feasible interval. If its right endpoint is finite, apply Lemma 3.3. Each successor increases every pair-start coordinate weakly and at least one strictly. Define the integer potential

$$\Phi(J)=\sum_{r=1}^m a_r. \tag{3.6}$$

For even $k$, its minimum is $\sum_{r=1}^m2(r-1)$ and its maximum is $\sum_{r=1}^m(n-2m+2(r-1))$. For odd $k$, both expressions acquire $m$ from the left shift of the available grid, while $n$ is replaced by $n-1$ in the available-node count. In both cases the total difference is

$$\Phi_{\max}-\Phi_{\min}=m(M-2m)=m(n-k). \tag{3.7}$$

Every transition increases $\Phi$ by at least one. Thus the sweep must reach a basis whose feasible interval is unbounded to the right after at most $m(n-k)$ transitions. It cannot stop earlier at a finite parameter, by Lemma 3.3. The known positivity of the rightmost basis at large parameters and uniqueness in Lemma 2.2 identify the final basis. The sweep covers all of $\mathbb R$.

For an arbitrary positive law $\mu$, apply this construction to $\mu_i e^{t i}$ and evaluate at $t=0$. This proves static existence, and Lemma 2.2 proves uniqueness. It also supplies at every positive law a basis feasible just to its right along this artificial tilt, with any zero masses only at right nodes, and the analogous left-side basis.

Now take a general continuous strict-MLR path. At any $t_0$, use the artificial right-side basis just described. Its zero right-node masses become positive for all $t>t_0$ by Lemma 3.1, while its other masses remain positive locally by continuity. Thus it is the nondegenerate basis immediately to the right on the actual path as well. The same holds on the left. This excludes an interval consisting only of degenerate solutions, establishes local coverage, and reduces every transition to Lemma 3.3. The globally increasing integer potential limits all transitions by (3.7), so no accumulation or reentry is possible. This proves (3.5). Attainment is established in Theorem 6.1 below. $\square$

For a general MLR family, concentration at the endpoints alone is not an initialization condition: a selected mass could decay faster than an omitted tail. Formula (3.2) provides the required relative-mass separation. No such endpoint hypothesis is needed for the truncated path bound on an arbitrary interval $I$.

**Corollary 3.5 (static comparative statics).** If positive laws $\mu,\nu$ satisfy strict MLR order and have nondegenerate upper paired bases, the pair starts for $\mu$ do not exceed those for $\nu$ coordinatewise.

*Proof.* Set $h_i=\log(\nu_i/\mu_i)$ and interpolate by $\mu_s(i)\propto\mu_i e^{s h_i}$, $0\leq s\leq1$. This is a strict-MLR path joining the laws. Apply Theorem 3.4. At degenerate endpoints an arbitrary zero-weight completion is not asserted to obey this comparison. $\square$

# 4. A common extremizer for generalized-convex payoffs

Define the payoff cone

$$
\mathcal C_A=\{g\in\mathbb R^{n+1}:\text{every ordered }(k+2)\text{-minor of }[A;g]\text{ is nonnegative}\}. \tag{4.1}
$$

**Proposition 4.1 (static comparison and its path consequence).** The endpoint optimizer from Theorem 3.4 maximizes $\sum_i g_iq_i$ simultaneously for every $g\in\mathcal C_A$ under $Aq=A\mu$. If all the relevant augmented minors are strictly positive, this optimizer is unique for that payoff. Hence the MLR support path is shared by the canonical common extremizer for this whole cone.

*Proof.* Interpolate $g$ on a feasible paired basis $B$ by $p_B=g_BA_B^{-1}A$. For an omitted index $i$, the determinant with columns $B$ followed by $i$ is

$$\det(A_B)\big(g_i-p_B(i)\big). \tag{4.2}$$

Sorting these columns moves $i$ across an odd number of basis indices: the right endpoint and a number of complete pairs. Its sign is therefore negative. The sorted augmented determinant is nonnegative, so $g_i-p_B(i)\leq0$. At $B$ equality holds. Thus $p_B\geq g$ is a row-span majorant, attained by the law on $B$. Strict off-basis inequality gives uniqueness by the same argument as Lemma 2.2. $\square$

The static assertion is the classical generalized-convex extremal principle; we include its proof to specify the cone and avoid attributing newness to the matrix assumption. The new path conclusions do not apply to arbitrary payoffs. For polynomial moments, the cone is the nonnegative $(k+1)$st divided-difference cone. For nonpolynomial Chebyshev systems the same determinant description applies without choosing derivatives or a polynomial basis.

# 5. Binomial-normalized carriers and unit-pair pivots

## 5.1. Reduction to paired quadrature

We now specialize to ordinary moments on $\{0,\ldots,n\}$. For even $k=2m$, multiply the reference mass by $C(x)=n-x$ and normalize on $\{0,\ldots,n-1\}$. For odd $k=2m+1$, use $C(x)=x(n-x)$ on $\{1,\ldots,n-1\}$ and shift the resulting grid down by one. Denote the transformed law by $\nu$. Its grid is $\{0,\ldots,N\}$, where

$$N=n-1\ (k\text{ even}),\qquad N=n-2\ (k\text{ odd}). \tag{5.1}$$

Write $J$ for the transformed paired indices and set

$$
Q_J(x)=\prod_{j\in J}(x-j),\qquad
L_{J,j}(x)=\frac{Q_J(x)}{(x-j)Q_J'(j)},\qquad
\lambda_j=\mathbb E_\nu L_{J,j}(X). \tag{5.2}
$$

The quotients are polynomials; evaluation at a root means polynomial continuation. The degree of $L_{J,j}$ is $2m-1$. The transformation preserves the sign of each movable mass:

$$
\begin{split}
k=2m:&\quad \lambda_j=\frac{(n-j)\beta_j}{\mathbb E_\mu(n-X)},\\
k=2m+1:&\quad \lambda_{j-1}=\frac{j(n-j)\beta_j}{\mathbb E_\mu[X(n-X)]}.
\end{split} \tag{5.3}
$$

Indeed, the full cardinal polynomial at an interior node is $C(x)/C(j)$ times the cardinal polynomial on the paired nodes. Its degree is exactly $k$, which proves (5.3) by taking expectations. Endpoint weights are positive by Lemma 2.1. In particular, for $\mu=\operatorname{Bin}(n,p)$ the transformed laws are respectively $\operatorname{Bin}(n-1,p)$ and $1+\operatorname{Bin}(n-2,p)$ before the shift. The normalizing factors are $n(1-p)$ and $n(n-1)p(1-p)$.

## 5.2. A complementary-grid positivity inequality

Let $2m\leq N$ and consider positive tilted weights

$$\nu_z(i)=\frac{w_i z^i}{\sum_{r=0}^Nw_rz^r},\qquad w_i=\binom Ni h_i,\qquad z>0. \tag{5.4}$$

The sequence $h$ is log-convex when $h_i^2\leq h_{i-1}h_{i+1}$ for $1\leq i\mathrel{<}N$, and strictly log-convex when all these inequalities are strict.

**Lemma 5.1 (gap positivity).** Let $J$ be a paired set of $2m$ nodes. Suppose consecutive occupied pairs start at $a$ and $c=a+2$, and the block containing them ends at $e\mathrel{<}N$. Put $r=e+1$ and

$$G(x)=\frac{Q_J(x)}{(x-a)(x-c)}. \tag{5.5}$$

If $h$ is log-convex and $N>2m$, then $\mathbb E_{\nu_z}G(X)>0$ for every $z>0$. The same is true for $N=2m$ when $h$ is strictly log-convex.

*Proof.* On the integer grid, $Q_J\geq0$. At its left roots the derivative is negative, so

$$G(a)=Q_J'(a)/(a-c)>0,\qquad G(c)=Q_J'(c)/(c-a)\mathrel{<}0.$$

The only integer strictly between $a$ and $c$ is an unremoved root. Thus $G$ is nonnegative at every grid node other than $c$, and is positive at $r$.

Let

$$
S=\{0,\ldots,N\}\setminus(J\setminus\{a,c\}),\qquad T=S\setminus\{a,c,r\}.
$$

The points $a,c,r$ are consecutive in $S$, so every $u\in T$ lies outside $[a,r]$, and $|T|=N-2m$. Factoring the full grid polynomial at each $i\in S$ gives

$$
\binom Ni G(i)=\frac{N!(-1)^{N-i}}{\prod_{u\in S\setminus\{i\}}(i-u)}. \tag{5.6}
$$

To verify this identity directly, the derivative of $\prod_{u=0}^N(x-u)$ at $i$ is $(-1)^{N-i}i!(N-i)!$; the same derivative is $G(i)\prod_{u\in S\setminus\{i\}}(i-u)$.

Define

$$
\alpha=\frac{r-c}{r-a},\qquad \eta=\frac{c-a}{r-a},\qquad D=w_c|G(c)|,
$$

so $\alpha,\eta>0$, $\alpha+\eta=1$, and $c=\alpha a+\eta r$. For $U=w_aG(a)/D$ and $W=w_rG(r)/D$, taking ratios of (5.6) yields

$$
U=\alpha\frac{h_a}{h_c}\prod_{u\in T}\frac{|c-u|}{|a-u|},\qquad
W=\eta\frac{h_r}{h_c}\prod_{u\in T}\frac{|c-u|}{|r-u|}. \tag{5.7}
$$

Therefore

$$
K:=\left(\frac U\alpha\right)^\alpha\left(\frac W\eta\right)^\eta
=\frac{h_a^\alpha h_r^\eta}{h_c}
\prod_{u\in T}\frac{|c-u|}{|a-u|^\alpha|r-u|^\eta}. \tag{5.8}
$$

The first factor is at least one by convexity of the linearly interpolated sequence $\log h_i$. Each other factor is strictly greater than one because $x\mapsto\log|x-u|$ is strictly concave on $[a,r]$. Thus $K>1$ if $T$ is nonempty. If $T$ is empty, strict log-convexity of $h$ gives $K>1$ instead.

Weighted AM--GM now gives

$$
Uz^{a-c}+Wz^{r-c}\geq K z^{\alpha(a-c)+\eta(r-c)}=K>1. \tag{5.9}
$$

Keeping the terms at $a,c,r$ and using nonnegativity of all other terms,

$$\sum_{i=0}^Nw_iG(i)z^i\geq Dz^c\big(Uz^{a-c}+Wz^{r-c}-1\big)>0.$$

Dividing by the positive normalizer proves the assertion. $\square$

**Theorem 5.2 (unit-pair successor).** Under the carrier assumptions of Lemma 5.1, every zero left-node mass at a feasible right boundary is the last pair's left node in its occupied block. Hence the successor replaces each departing node $a$ by $a+2$. Multiple departures occur in distinct blocks and give independent simultaneous unit-pair shifts.

*Proof.* If an exiting left node $a$ were followed by an adjacent pair starting at $c=a+2$, and its block were not terminal, Lemma 5.1 and the polynomial identity

$$\frac{Q_J(x)}{x-c}-\frac{Q_J(x)}{x-a}=(c-a)G(x) \tag{5.10}$$

would imply $\mathbb E[Q_J(X)/(X-c)]>0$, since the second expectation vanishes when $\lambda_a=0$. But $Q_J'(c)\mathrel{<}0$, so $\lambda_c\mathrel{<}0$, contradicting feasibility. A terminal block cannot contain an exiting zero by Lemma 3.3. Therefore $a$ is the last pair's left node, whose block ends at $a+1$. The suffix-block successor adds precisely $a+2$. Distinct departing nodes belong to distinct blocks, and the added nodes cannot coincide. $\square$

For the binomial carrier $h_i=1$, Theorem 5.2 applies when $N>2m$. Through (5.1), this is $k\leq n-2$ for both parities. For $m=1$, the exclusion of an adjacent following pair is immediate, and the same conclusion holds. Ordinary log-concavity or a real-rooted generating polynomial is not a substitute for the stated carrier condition: on $0,\ldots,4$, $J=\{0,1,2,3\}$ and carrier $(1,5,8,5,1)$ at $z=1$ give zero left mass at $0$ but positive left mass at $2$, and the next support is $\{1,2,3,4\}$. Its generating polynomial is $(1+z)^2(1+3z+z^2)$ and has only negative real roots. The theorem supplies a sufficient carrier condition, not a necessary-and-sufficient classification.

# 6. Exact attainment of the regime bound

**Theorem 6.1 (sharpness in every dimension).** For every $1\leq k\mathrel{<}n$, there are positive rational carriers for ordinary moments on $\{0,\ldots,n\}$ whose exponential-tilt path has exactly $\lfloor k/2\rfloor(n-k)+1$ positive-length regimes. For $m\geq1$, almost every transformed carrier in the open class of strictly binomial-normalized log-convex carriers has this property. Sharpness is asserted over the class, not for every fixed nonpolynomial matrix $A$.

*Proof.* The case $m=0$ has the constant basis $\{0,n\}$ and exactly one regime. Suppose $m\geq1$, and use the transformed grid $\{0,\ldots,N\}$ of Section 5. The strict log-convexity inequalities for $h_i=w_i/\binom Ni$ define a nonempty open subset of $\mathbb R_{>0}^{N+1}$; for example $h_i=2^{i^2}$ lies in it. By Theorem 5.2 every transition is a simultaneous collection of unit-pair shifts, including the case $N=2m$.

We show that simultaneous zeros are absent for almost every carrier. Fix a paired set $J$ and two distinct nodes $j,l\in J$. Write

$$F_j(w,z)=\sum_{i=0}^Nw_i z^i L_{J,j}(i),\qquad F_l(w,z)=\sum_{i=0}^Nw_i z^i L_{J,l}(i). \tag{6.1}$$

For $z>0$, the equations $F_j=F_l=0$ solve independently for $w_j,w_l$, because the cardinal values at $j,l$ form the identity matrix. The incidence set is thus a smooth graph with the remaining $N-1$ carrier coordinates and $z$ as parameters: its dimension is $N$, one less than the $N+1$ dimensional carrier space. Its projection into that carrier space has Lebesgue measure zero. One can see this without a global compactness assumption by covering the parameter domain with countably many compact sets on which the graph map is Lipschitz; a Lipschitz image of dimension $N$ has zero $(N+1)$ dimensional volume.

There are finitely many $J,j,l$, so almost every positive carrier has no simultaneous cardinal zeros at any $z>0$. For such a carrier, every actual transition moves exactly one pair by one index. The full sweep begins and ends at the extreme paired bases, and the potential increase is exactly $m(n-k)$. Thus the number of transitions equals that increase, and the number of regimes is $m(n-k)+1$.

For rational existence, the exceptional projection is semialgebraic: (6.1) is polynomial in $w,z$ with rational coefficients, and $z>0$ is a polynomial inequality. A semialgebraic set of measure zero has dimension less than the ambient dimension, and its closure has the same dimension [BPR06]. Its complement therefore contains a nonempty open subset of the strict log-convexity class, and that subset contains a rational carrier. Pull it back through (5.3) by dividing by $n-i$ in the even case or by $i(n-i)$ in the odd case. Assign arbitrary positive rational endpoint carriers where the transforming factor vanishes. This yields a positive rational original carrier. Its transformed tilt differs only by normalization and, for odd $k$, a common factor $z$, so the same support path is obtained. $\square$

An exact example will also be useful. Let $n=6,k=4$ and take original carrier

$$w=(10,12,15,20,30,60,60). \tag{6.2}$$

Multiplication by $6-i$ gives a constant carrier on $0,\ldots,5$. The paired supports along $z>0$ are

$$0123,\quad0134,\quad0145,\quad1245,\quad2345, \tag{6.3}$$

each supplemented by endpoint $6$. The breakpoints are $r_1,r_2,r_2^{-1},r_1^{-1}$, where $r_1,r_2$ are the unique positive roots of

$$20z^3+6z^2-1=0,\qquad 10z^3-3z-2=0, \tag{6.4}$$

respectively. The first polynomial is increasing for $z>0$ and changes sign between $0$ and $1/2$. The second has one sign change in its coefficients, is negative at $1/2$ and positive at $1$, and hence has exactly one positive root in that interval. Thus the four breakpoints are strictly ordered. Full interpolatory weights and exact interval certificates for (6.3) accompany the numerical supplement. There are five regimes, exactly the bound. This example illustrates, rather than proves, the arbitrary-dimensional assertion.

# 7. The complete binomial phase diagram

## 7.1. Reduction from independent subsets of bits

Let $M(n,k,p)$ denote the largest probability that all $n$ bits are one among laws whose every subset of at most $k$ bits is independent with mean $p$. The standard exchangeability reduction [BEKK26] identifies it with the endpoint moment problem for $\operatorname{Bin}(n,p)$.

For completeness, symmetrize any bit law under coordinate permutations; this preserves the constraints and the all-ones event. If $S$ is its number of ones, then

$$\mathbb E(S)_r=(n)_r p^r,\qquad0\leq r\leq k, \tag{7.1}$$

where $(x)_r=x(x-1)\cdots(x-r+1)$. Conversely, given a law of $S$ satisfying (7.1), choose a uniform subset of size $S$ to carry the ones. For any $r$ distinct specified coordinates the probability they are all one is $\mathbb E(S)_r/(n)_r=p^r$. Inclusion-exclusion gives $p^a(1-p)^b$ for every pattern with $a+b\leq k$. Thus the resulting bits are $k$-wise independent. Since falling factorials span the polynomials through degree $k$, (7.1) is equivalent to matching the ordinary moments of $\operatorname{Bin}(n,p)$, and the objective is $\Pr(S=n)$.

**Corollary 7.1 (binomial support path).** For $0\mathrel{<}p\mathrel{<}1$ and $1\leq k\mathrel{<}n$, the nondegenerate optimizing paired supports for $M(n,k,p)$ are coordinatewise increasing and have at most $R_{n,k}$ regimes. When $2\leq k\leq n-2$, every transition consists of independent replacements $a\mapsto a+2$ at one or more left nodes. If $d_r$ is the number of replacements at transition $r$, then

$$\sum_r d_r=m(n-k),\qquad
\#\text{regimes}=1+m(n-k)-\sum_r(d_r-1). \tag{7.2}$$

*Proof.* The binomial likelihood ratio is strictly increasing in the index when $p$ increases. Theorem 3.4 gives the path and upper bound, and (5.1)--(5.4) with $h_i=1$ allow Theorem 5.2 in the specified range. A unit shift raises the pair-start potential by one. Telescoping from the first to last basis proves (7.2). $\square$

For even $k\leq n-2$, this proves the interior positive-length interpretation of the order and single/simultaneous unit-pivot assertions in [BEKK26, Conjectures 5.2, 5.4, 5.5] and makes its Proposition 5.8 unconditional. The source's conditional counting idea is retained and credited; the new ingredient is the proof of the transitions. The exceptions in Section 8 prevent a claim of literal validity over all endpoint-inclusive or boundary-dimensional statements.

## 7.2. An exact sweep

For any current paired set $J$, compute the polynomials $\lambda_j(p)$ from (5.2) under the appropriate transformed binomial law. Each left-node mass has at most one zero in $(0,1)$. Starting with the leftmost basis, isolate its outgoing left-node roots strictly beyond the current boundary. The least such root is the next transition; if no such root exists, the final interval ends at one. At that algebraic root determine all zero left masses exactly. Use the suffix-block rule, or its unit-pair specialization when applicable. Repeat until the rightmost basis is reached.

For each regime, output its paired support, the full original weights $\beta_j(p)$, the endpoint-value polynomial, and algebraic descriptions of both boundaries. Record the zero set at each transition. The matching laws at the boundary coincide by Lemma 2.2. Supply $\delta_0$ at $p=0$ and $\delta_n$ at $p=1$, because the mean constraint forces those endpoint laws. No basis-completion claim at a degenerate endpoint is needed.

The full weights can be obtained by taking binomial expectations of the ordinary degree-$k$ cardinal polynomials. In particular,

$$
M(n,2m,p)=\frac{\mathbb E Q_J(S)}{Q_J(n)},\qquad
M(n,2m+1,p)=\frac{\mathbb E[SQ_J(S)]}{nQ_J(n)}, \tag{7.3}
$$

where in the second expression $J$ is the unshifted paired part. These are valid on their corresponding regimes, not globally for a fixed $J$.

**Theorem 7.2 (polynomial algebraic output and bit complexity).** The complete binomial phase diagram can be computed exactly in a number of bit operations polynomial in $n$ and $k$, with algebraic endpoints and rational-coefficient weight polynomials. The statement uses the expanded grid size; it does not assert complexity polynomial in $\log n$.

*Proof.* For $k=1$ the basis is $\{0,n\}$ with masses $1-p,p$, and the claim is immediate. Otherwise let $d=2m-1\geq1$. Each transformed cardinal polynomial is $P_j(x)/D_j$, where $P_j$ is a monic product of $d$ integer linear factors whose roots have magnitude at most $n$, and $D_j$ is a nonzero product of $d$ integer differences. The sum of the absolute coefficients of $P_j$ is at most $(n+1)^d$, and $|D_j|\leq n^d$.

Write $P_j(x)=\sum_{r=0}^d c_r(x)_r$. Conversion from powers to falling factorials uses Stirling numbers of the second kind. For indices at most $d$, these are at most $d^d$; therefore the integers $c_r$ have bit length $O(d\log(nd))$. For $X\sim\operatorname{Bin}(N,p)$,

$$D_j\lambda_j(p)=\sum_{r=0}^d c_r(N)_r p^r. \tag{7.4}$$

Since $(N)_r\leq n^d$, the integer coefficients on the right have bit length $O(k\log(nk))$. Its degree is at most $k-1$ for even $k$ and $k-2$ for odd $k$. The analogous full cardinal construction has degree at most $k$ and the same coefficient-size order.

There are at most $O(nk)$ regimes by Theorem 3.4, and at most $m$ outgoing left-root candidates per regime. Integer-polynomial square-free factorization, gcd, real-root isolation, and comparison of real algebraic roots take polynomial bit complexity in degree and coefficient length using standard subresultant and isolation algorithms [BPR06, EMT08]. For comparison between roots of different polynomials, a gcd determines common roots, and isolation can be refined to disjoint rational intervals for distinct roots. Root-separation bounds for their product require only a polynomial number of bits. Thus every transition and every simultaneous zero set is decidable in polynomial time. Coefficient construction, support updates, and the output of $O(nk)$ sets of $O(k)$ degree-$k$ polynomials are polynomial as well. $\square$

This is an all-parameter output bound. It does not improve the known polynomial solvability of a single fixed-$p$ linear program, and does not assert a bit bound for arbitrary real grids, arbitrary real matrix entries, or arbitrary real sufficient statistics in (3.2). For those inputs Theorem 3.4 is a structural theorem.

# 8. Necessary qualifications and failure under stochastic order

## 8.1. Closed parameter endpoints

For $n=4,k=2$ and $B=\{0,1,4\}$, direct interpolation against the binomial law gives

$$\beta_4=p^2,\qquad\beta_1=4p(1-p),\qquad\beta_0=(1-p)(1-3p). \tag{8.1}$$

Consequently the full feasibility set in the closed parameter domain is

$$L(B)=[0,1/3]\cup\{1\}. \tag{8.2}$$

This is not an interval. Every upper basis contains $n$ and is feasible at $p=1$ because the interpolated law is then $\delta_n$. The strict-positivity hypothesis in Theorem 3.4 excludes this degeneration. Its binomial conclusion is interval feasibility in $(0,1)$, followed by closures of the positive-length components if closed regime boundaries are desired. The endpoint caution is already present in [H26, Remark 4]; (8.1) is an explicit elementary illustration.

## 8.2. The boundary dimension

At $n=5,k=4$, the transformed grid is $0,\ldots,4$ with binomial carrier $(1,4,6,4,1)$. For $J=\{0,1,2,3\}$ its unnormalized cardinal expectations are

$$1-z^4,\qquad4z+4z^4,\qquad6z^2-6z^4,\qquad4z^3+4z^4. \tag{8.3}$$

Thus this basis is feasible for $0\mathrel{<}z\leq1$. At $z=1$, both left masses vanish. Lemma 3.3 replaces index $0$ by $4$, producing $J^+=\{1,2,3,4\}$, which is feasible for $z\geq1$ by the same calculation or reflection. The original full supports include endpoint $5$. This is a block transition, not a replacement $0\mapsto2$. It occurs at $p=1/2$ and lies at $k=n-1$.

Accordingly, the unit-pivot assertions in Section 7 use $k\leq n-2$, the range of the source's numerical samples and counting proposition. They are not a proof of a unit-pivot claim literally extending over all even $k\leq n-1$. The general suffix-block theorem covers the boundary without exception.

## 8.3. Arbitrarily many transitions under strict FSD

**Proposition 8.1 (no dimension-only FSD bound).** On four grid points with two moment constraints there are positive smooth families strictly increasing in first-order stochastic dominance whose optimal supports have arbitrarily many regimes.

*Proof.* Fix any positive integer $L$. On $0\leq t\leq1$ put

$$
\begin{split}
\mu_*&=(1,2,3,2)/8,\qquad d=(-1,0,-3,4),\qquad v=(0,-1,1,0),\\
\varepsilon&=1/64,\qquad a=\varepsilon/(4\pi L),\\
\mu_t&=\mu_*+\varepsilon t d+a\sin(2\pi Lt)v.
\end{split} \tag{8.4}
$$

The perturbations sum to zero. All four probabilities remain positive: the smallest first coordinate is $7/64$, the second is at least $1/4-a$, and the third is at least $21/64-a$, while the fourth is at least $1/4$. For the three nontrivial cumulative probabilities the derivatives are

$$-\varepsilon,\qquad-\varepsilon-2\pi La\cos(2\pi Lt)\leq-\varepsilon/2,\qquad-4\varepsilon. \tag{8.5}$$

Thus every cumulative probability decreases strictly, giving strict first-order stochastic increase.

Let $f(x)=(x-1)(3-x)$, whose values on the grid are $(-3,0,1,0)$. Since $\mu_*\cdot f=d\cdot f=0$ and $v\cdot f=1$,

$$\mathbb E_{\mu_t}f(X)=a\sin(2\pi Lt). \tag{8.6}$$

After multiplication by $3-x$, the transformed law has mean below one precisely when (8.6) is negative, and above one precisely when it is positive. Two-node interpolation then selects the paired support $\{0,1\}$ or $\{1,2\}$, respectively. Equivalently, the original optimal supports are $\{0,1,3\}$ and $\{1,2,3\}$. Positivity of the input law keeps the transformed mean strictly between zero and two. The sine changes sign at the $2L-1$ interior zeros, giving exactly $2L$ positive-length alternating regimes on $(0,1)$. Since $L$ is arbitrary, no bound depending only on $n=3,k=2$ is possible. $\square$

This separates MLR from FSD for this path question. It does not characterize the weakest possible ordering assumption: individual non-MLR paths may still have short monotone support sequences.

# 9. Exact finite certificates

The accompanying computational supplement constructs algebraic phase diagrams and checks them against the original moment program. The written proofs above are not inferred from these finite cases.

The binomial study covers all $3\leq n\leq12$, $2\leq k\mathrel{<}n$, together with $(n,k)=(17,4),(23,6)$: 57 instances and 525 open parameter regimes. Every exact certificate passed. For each regime a separate verifier reconstructs the full interpolatory masses directly from the binomial probability mass function, verifies the zeroth through $k$th moment identities, proves strict positivity by a rational interior point and the absence of internal real roots, checks the endpoint majorant at every grid node, and checks primal--dual equality. Algebraic boundary descriptions verify ordered continuous coverage. Gcd records identify simultaneous zero masses. The verifier does not call the successor routine or rely on the path theorem to certify the supplied intervals.

| $n$ | $k$ | Regimes | Bound $R_{n,k}$ | Simultaneous unit-pivot parameters |
|---:|---:|---:|---:|---|
| 7 | 4 | 7 | 7 | none |
| 9 | 4 | 11 | 11 | none |
| 10 | 6 | 13 | 13 | none |
| 10 | 4 | 12 | 13 | $1/2$ |
| 11 | 4 | 13 | 15 | $1/3,2/3$ |
| 17 | 4 | 26 | 27 | $1/2$ |
| 23 | 6 | 50 | 52 | $1/2$, three replacements |

![Support path and endpoint probability for $n=10,k=4$. The full support in the upper panel is $\{a_1,a_1+1,a_2,a_2+1,10\}$. Both pair starts increase at $p=1/2$. Step heights describe open regimes; multiple bases at a breakpoint represent the same optimizing law. The lower panel compares $M(10,4,p)$ with the independent value $p^{10}$ on a logarithmic scale for $p\geq0.05$; both tend to zero at $p=0$. All plotted quantities come from the exact phase certificate, with algebraic endpoints approximated only for display.](figures/binomial_n10_k4_path.png){width=95%}

For $(23,6)$, the paired support at $p=1/2$ changes from $\{6,7,10,11,14,15\}$ to $\{7,8,11,12,15,16\}$. The departing-mass numerators have gcd $2p-1$. This reproduces the source's simultaneous-transition example [BEKK26] with exact algebraic certificates. The boundary example (8.3) is separately labeled as a nonunit block transition. The rational carrier example (6.2) also passes an independent exact check over all five of its regimes.

A floating-point LP was additionally solved at one rational interior point per binomial regime. Of the original 525 comparisons, 524 met the fixed objective tolerance $2\times10^{-7}$. The remaining case, $n=12,k=9,p=7/8$, had objective discrepancy $2.048906481422197\times10^{-7}$ and moment residual $5.913158851456046\times10^{-11}$, while its exact certificate passed. One targeted recheck with an orthogonal moment basis reduced the objective discrepancy to $6.38\times10^{-16}$ and the residual to $4.44\times10^{-16}$, without changing the tolerance. The original failed comparison and original aggregate flag are preserved alongside that recheck.

The generator and verifier share SymPy and a basic exact algebraic-number ordering module, so their independence is at the program and certificate level, not at the computer-algebra kernel level. The recorded environment is Python 3.12.14, SymPy 1.14.0, SciPy 1.17.0, and NumPy 2.3.5. The finite data neither prove nor disprove that all exceptional binomial parameters are rational. Regeneration instructions and the complete certificate files are supplied separately.

# 10. Scope and remaining questions

The general theorem concerns finite ordered one-dimensional configurations satisfying (2.1), positive reference laws, and strict MLR variation. It permits arbitrary simultaneous degeneracies and applies to all generalized-convex payoffs through a common canonical extremizer. It does not cover an arbitrary matrix, a multivariate grid without the ordered-minor structure, or an arbitrary right-hand-side path. The FSD example explains one concrete failure of such an extension.

For ordinary moments, the unit-pair result uses a sufficient condition on the **transformed** carrier. Sharpness of the universal count is established over the class, not for every fixed nonpolynomial configuration. The bit bound concerns binomial inputs measured in the expanded grid dimensions. Reflection belongs to [H26]. Rational exceptional points and the maximal-spread conjectures in [BEKK26] remain open here. No claim of global priority or journal acceptance follows from the literature comparison. This manuscript has not undergone external peer review.

# References

[BEKK26] Daniel Berend, Philip A. Ernst, Aryeh Kontorovich, and Rishi Kumar. *Exact Expressions for the Maximal Probability that all k-wise Independent Bits are 1*. Journal of Theoretical Probability **39**, article 58 (2026). [doi:10.1007/s10959-026-01487-4](https://doi.org/10.1007/s10959-026-01487-4).

[H26] Roy Hermann. *Reflection of optimal supports for k-wise independent bits*. arXiv:2609.25595v1 (2026). [Original manuscript](https://arxiv.org/abs/2609.25595).

[P90] András Prékopa. *Sharp Bounds on Probabilities Using Linear Programming*. Operations Research **38**(2), 227--239 (1990). [doi:10.1287/opre.38.2.227](https://doi.org/10.1287/opre.38.2.227).

[CD08] Cindy Courtois and Michel Denuit. *S-convex extremal distributions with arbitrary discrete support*. Journal of Mathematical Inequalities **2**(2), 197--214 (2008). [doi:10.7153/jmi-02-18](https://doi.org/10.7153/jmi-02-18).

[Pe95] J. M. Peña. *Matrices with Sign Consistency of a Given Order*. SIAM Journal on Matrix Analysis and Applications **16**(4), 1100--1106 (1995). [doi:10.1137/S0895479894264430](https://doi.org/10.1137/S0895479894264430).

[GP09] M. García-Esnaola and J. M. Peña. *Sign consistent linear programming problems*. Optimization **58**(8), 935--946 (2009). [doi:10.1080/02331930701763496](https://doi.org/10.1080/02331930701763496).

[NP13] Anh Ninh and András Prékopa. *The discrete moment problem with fractional moments*. Operations Research Letters **41**(6), 715--718 (2013). [doi:10.1016/j.orl.2013.09.001](https://doi.org/10.1016/j.orl.2013.09.001).

[CHJRZ21] Xi Chen, Simai He, Bo Jiang, Christopher Thomas Ryan, and Teng Zhang. *The Discrete Moment Problem with Nonconvex Shape Constraints*. Operations Research **69**(1), 279--296 (2021). [doi:10.1287/opre.2020.1990](https://doi.org/10.1287/opre.2020.1990). This work is a related structural and algorithmic study with different constraints; its shape restrictions are not imposed in (2.2).

[BPR06] Saugata Basu, Richard Pollack, and Marie-Françoise Roy. *Algorithms in Real Algebraic Geometry*, second edition. Algorithms and Computation in Mathematics **10**, Springer (2006). [doi:10.1007/3-540-33099-2](https://doi.org/10.1007/3-540-33099-2).

[EMT08] Ioannis Z. Emiris, Bernard Mourrain, and Elias P. Tsigaridas. *Real Algebraic Numbers: Complexity Analysis and Experimentation*. In *Reliable Implementation of Real Number Algorithms: Theory and Practice*, Lecture Notes in Computer Science **5045**, 57--82, Springer (2008). [Author full text](https://who.paris.inria.fr/Elias.Tsigaridas/files/emt-lncs-2006.pdf), particularly Sections 4--6.
