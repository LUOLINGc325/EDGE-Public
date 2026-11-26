# Computing the additive discrepancy between flat and nested coherent risk

## Abstract

Given one finite scenario tree and specified risk functionals, we compute how far nested evaluation can differ from a flat evaluation of the same terminal loss. For arbitrary law-invariant coherent risk functionals with the Fatou property, bounded branching admits a two-sided additive approximation scheme with certified values and witness losses. Its probability resolution depends on the bit length of the masses. The scheme relies on a comparison of risks under multiplicatively close tail probabilities, which also applies when the risk is sensitive to arbitrarily small positive masses. For mean–maximum risks on an arbitrary tree, the flat-minus-nested discrepancy is exactly computable by one path linear program per leaf. A common mean–maximum preference gives a closed product formula with singleton witnesses. In the opposite direction a one-dimensional tree algorithm gives a fully polynomial additive approximation scheme for arbitrary weights, and exact polynomial computation for equiprobable leaves.

## Reader guide

A scenario tree represents information revealed over time. Flat risk evaluates the distribution of the final loss once. Nested risk first evaluates each conditional distribution and then evaluates the resulting numbers at the preceding stage. An additive discrepancy bounds how much this change in evaluation can alter any loss between zero and one. The two directions matter when the nested evaluation is used as a conservative or an optimistic substitute for the flat one.

For a concrete example, take two stages with two equally likely children at every node and use half the mean plus half the maximum at every step. A loss of one on a single leaf and zero elsewhere has flat risk \(5/8\) and nested risk \((3/4)^2=9/16\). The global flat-minus-nested discrepancy is exactly \(1/16\) by (5). For the reverse direction use a loss of one on three leaves and zero on the remaining leaf. Its flat and nested risks are \(7/8\) and \(15/16\). Formula (11) certifies \(1/16\) as the global nested-minus-flat discrepancy as well.

Section 2 discretizes losses and groups their tail probabilities by relative size. The comparison (1) shows why two such probability records give similar flat values even for preferences sensitive to rare outcomes. Section 3 handles the mean–maximum family by reducing the downward discrepancy to one path and the upward discrepancy to a search over events. Section 4 gives a closed product computation for the upward discrepancy when each layer repeats the same branching law. Appendix A studies uniform error bounds when the tree itself may vary.

## 1. Fixed-tree model

Let \(T\) be a finite rooted tree with \(n\) nodes, leaf set \(\mathcal L\) and height \(H\). Nominal conditional probabilities \(p_{vi} > 0\) at each interior node \(v\) sum to one over its children \(i\). Write \(P_v\) for the product of these probabilities along the path to \(v\), with \(P_o=1\) at the root. Thus the unconditional probability of leaf \(\ell\) is \(P_\ell\). Unary nodes are allowed. All complexities below refer to an explicitly supplied tree. The probabilities are given as rationals when discussing bit complexity.

At each interior node \(v\) fix a law-invariant coherent risk functional \(\rho_v\) on bounded losses on a standard atomless probability space, with the Fatou property. We use the loss convention. Thus the functionals are monotone, normalized, translation equivariant, positively homogeneous and subadditive, and can evaluate any finite probability law. For \(0\le X_\ell\le1\), set \(N_\ell(X)=X_\ell\) and \(N_v(X)=\rho_v((N_i(X))_i;(p_{vi})_i)\) recursively. Let \(N=N_o\). Let \(F(X)=\rho_f((X_\ell)_\ell;(P_\ell)_\ell)\) be a fixed flat risk, with the same assumptions, for which \(\rho_f=\rho_o\) is permitted. Define
\[
 \Delta_+=\max_{X\in[0,1]^{\mathcal L}}\{N(X)-F(X)\},\qquad
 \Delta_-=\max_{X\in[0,1]^{\mathcal L}}\{F(X)-N(X)\}.
\]
Monotonicity and translation equivariance imply that each risk is 1-Lipschitz in the sup norm on losses at fixed probabilities. The same is true of \(N\) by induction. Both maxima are attained and lie in \([0,1]\). The errors are conditional on all the specified inputs. The zero-height case has two zero errors.

For a general risk functional we allow an oracle for a finite law with rational losses and masses. Given a requested absolute precision, it returns a rational value within that precision. Oracle complexity is stated separately. In the mean–maximum model all operations use given rational coefficients and no general risk oracle.

## 2. Two-sided approximation for law-invariant coherent risk

**Theorem 1.** For maximum branching \(b\) and rational accuracy \(0<\varepsilon\le1\), one can return a witness loss for each directed discrepancy, within \(\varepsilon\) of its optimum, and intervals of width at most \(\varepsilon\) containing both optimal values. For \(H\ge1\), the number of oracle calls is \(O(n B^{bJ})\), where
\[
 J=\lceil 8/\varepsilon\rceil,\qquad
 B=O\bigl(1+(H+1)\varepsilon^{-1}\log(1/P_*)\bigr),\qquad
 P_*=\min_{\ell\in\mathcal L} P_\ell .
\]
The requested evaluation precision is of order \(\varepsilon/(H+1)^2\). The arithmetic outside the oracles is polynomial in these bounds and the input bit length. In particular this is an additive polynomial-time approximation scheme for fixed \(b\) and polynomial-time risk evaluators.

**A tail comparison.** Suppose \(U,V\) lie in \([0,1]\) and
\(\Pr(U>x)\le a\Pr(V>x)\) for every \(x\ge0\) with \(a\ge1\). Then
\[
 \rho(U)\le a\rho(V).
 \tag{1}
\]
To prove this, let \(B_0\) be an independent Bernoulli variable of mean \(1/a\). The tail condition gives \(B_0 U\le_{\mathrm{st}}V\). Coupling by quantiles, monotonicity and law invariance give \(\rho(B_0 U)\le\rho(V)\). Conditional averaging gives \(\rho(U/a)\le\rho(B_0 U)\). For finite \(U\), this averaging property follows by using conditionally independent copies of \(B_0 U\) given \(U\), applying convexity to their averages and passing to the almost-sure conditional mean using Fatou. This finite case suffices below. Homogeneity now proves (1). If both tails are within a factor \(a\) of each other, the two risk values differ by at most \(a-1\). In particular the comparison allows risk functionals with an atom at the essential supremum in a spectral representation.

**The tables.** Use the grid \(\{0,1/J,\ldots,1\}\). For a grid assignment in the subtree of \(v\), record the actual unconditional tail vector
\[
 m_v(X)_j=P\{\ell\text{ below }v,\ X_\ell\ge j/J\},\qquad 1\le j\le J .
 \tag{2}
\]
These vectors add across children. Every positive coordinate lies between \(P_*\) and one. Keep zero as one bin, and divide the positive range into bins with endpoints \(P_*(1+\delta)^k\), where
\(\delta=\varepsilon/[16(H+1)]\). At any shared boundary assign consistently to one bin. A pair in the same bin has the same zero status, and positive entries differ by a factor at most \(1+\delta\). There are at most \(B\) bins, and each key is a \(J\)-tuple of bins.

At each node keep two tables, one for each direction, with one representative per occupied key. Records contain their actual vector (2), a nested value estimate and pointers to the chosen children. At a leaf insert all \(J+1\) assignments. At an interior node generate every tuple of its children's representatives in the same direction, add their vectors, and form the candidate's nested value estimate by applying the node oracle to the estimates from those children. For \(\Delta_+\) keep the largest estimated value in each key. For \(\Delta_-\) keep the smallest. Ties may be resolved deterministically. Values may be clipped to \([0,1]\).

**Preservation under pruning.** Let the height of the subtree at \(v\) be \(h\). For each grid assignment \(X\) below \(v\), the appropriate table contains a representative \(Y\) whose vector is within \((1+\delta)^h\) coordinatewise in both directions, with zeros preserved, and such that
\[
 \begin{cases}
 N_v(Y)\ge N_v(X)-h(h+1)\tau &\text{in the upper table},\\
 N_v(Y)\le N_v(X)+h(h+1)\tau &\text{in the lower table}.
 \end{cases}
 \tag{3}
\]
Here \(\tau=\varepsilon/[64(H+1)^2]\) is the absolute error of each evaluation. If needed an oracle answer can be requested at half precision and then rounded to a rational of controlled bit length.

For each record its nested value estimate is within \(h\tau\) of its true value, by Lipschitz continuity along the actual recorded tree. To prove (3) use the induction representatives for the children. Summing the vectors preserves the common relative factor, because all coordinates are nonnegative. Monotonicity and translation at the parent transfer the children's one-sided value errors with a maximum over the children. Replacing the resulting candidate by its retained representative in the same key loses at most \(2h\tau\) in the selected direction and introduces at most one more factor \(1+\delta\) in the vectors. The error recursion \((h-1)h\tau+2h\tau=h(h+1)\tau\) proves (3). The leaf assertion is exact.

At the root compare the estimated values of \(N(Y)-F(Y)\) or \(F(Y)-N(Y)\) over the respective records. The flat risk is evaluated directly from the actual grid tail vector. Its evaluation error is at most \(\tau\), so the estimated signed discrepancy differs from its true value by at most \(e=(H+1)\tau\). For the optimal continuous loss, rounding down to the grid changes a signed discrepancy by at most \(2/J\). For a grid optimum, (1) and (3) lose at most \((1+\delta)^H-1+H(H+1)\tau\). Maximizing the approximate discrepancy over the table adds at most \(2e\) to the loss. The total is at most
\[
 2/J+(1+\delta)^H-1+H(H+1)\tau+2e < \varepsilon/2 .
\]
Thus if \(s\) is the estimated score of the returned loss, \([s-e,s+e+\varepsilon/2]\), intersected with \([0,1]\), is a valid interval of width at most \(\varepsilon\). The representative itself is the promised witness.

Each table has at most \(B^J\) entries. A node with at most \(b\) children uses at most \(B^{bJ}\) oracle calls to form its candidates. Bin choices use rational comparisons against successive rational powers. Products of input probabilities, their sums over leaf sets, and these bin endpoints all have bit lengths polynomial in the stated bounds and input size. Consequently a tiny \(P_*\) affects the computation through its logarithm and introduces no loss multiplier in the accuracy guarantee.

## 3. Mean–maximum preferences on an arbitrary weighted tree

Write
\[
 \rho_v(Z)=c_v\,\mathbb E Z+(1-c_v)\max Z,\qquad
 \rho_f(Z)=c_f\,\mathbb E Z+(1-c_f)\max Z ,
 \tag{4}
\]
with \(0\le c_v,c_f\le1\). The node probabilities may be arbitrary. The computational statements use rational coefficients.

**Theorem 2.** In the setting (4) the flat-minus-nested error is computable exactly by a linear program with \(O(H+1)\) variables and constraints per leaf. It has a witness constant on the exit cells of a single path. When \(c_v=c_f=c\) for every node, the exact formula is
\[
 \Delta_-=\max_{\ell\in\mathcal L}
 \left[1-c+cP_\ell-\prod_{v\to i\text{ on path to }\ell}(1-c+c p_{vi})\right].
 \tag{5}
\]
A singleton indicator attains it, and a single traversal computes all terms of (5). In the opposite direction there is a fully polynomial additive approximation scheme, with a witness event and an additive certificate. If \(M P_\ell\) are integers for a common positive integer \(M\), there is an exact algorithm using \(O(M^2\sum_v b_v^2)\) rational operations, where \(b_v\) is the number of children at \(v\). In particular arbitrary trees with equiprobable leaves admit exact polynomial computation of both directed errors.

### Flat minus nested

A risk in (4) is the support function of the local probability set \(c_v p_v+(1-c_v)\mathcal D_v\), where \(\mathcal D_v\) is the child probability simplex. Its condition on every child is \(q(i)\ge c_v p_{vi}\). Thus the nested envelope \(\mathcal R\) consists exactly of the terminal distributions \(Q\) whose subtree masses satisfy
\[
 Q_o=1,\qquad Q_v=\sum_i Q_i,\qquad Q_i\ge c_v p_{vi} Q_v .
 \tag{6}
\]
The equivalence follows by dividing by the parent mass when positive and choosing any admissible local law at a zero-mass node. It is a compact convex polytope. Backward maximization gives \(N(X)=\max_{Q\in\mathcal R}Q\cdot X\), with a choice of one maximizer per node. The flat envelope is the convex hull of the finitely many \(q^\ell=c_f P+(1-c_f)e_\ell\).

For each \(\ell\), finite-dimensional minimax interchanges the unit-cube maximization and the nested-envelope minimization in \((q^\ell-Q)\cdot X\). Maximizing this linear expression on the cube gives total variation, so
\[
 \Delta_-=\max_\ell\min_{Q\in\mathcal R}\operatorname{TV}(q^\ell,Q).
 \tag{7}
\]
Here \(\operatorname{TV}(q,Q)=1-\sum_{\ell'}\min(q_{\ell'},Q_{\ell'})\). We next reduce the inner computation to the selected path.

Let \(v_0=o,\ldots,v_h=\ell\) be its nodes, write \(p_j=p_{v_j v_{j+1}}\), \(P_j=P_{v_j}\), and let \(r_j=Q_{v_j}\). The feasible path-mass constraints are
\[
 r_0=1,\qquad c_{v_j}p_j r_j\le r_{j+1}
                 \le [1-c_{v_j}(1-p_j)]r_j \quad (0\le j\lt h).
 \tag{8}
\]
The exit cell at \(v_j\) is the set of leaves below \(v_j\) and outside \(v_{j+1}\). Its two total masses are \(r_j-r_{j+1}\) and \(c_f(P_j-P_{j+1})\). For fixed feasible path masses the greatest possible overlap on that cell is the minimum of these two numbers. To attain it allocate the cell mass proportionally to nominal probability among the other children, and follow nominal probabilities thereafter. This respects every floor in (6) by (8). Within the cell \(Q\) is then proportional to \(P\), as is \(q^\ell\), so the overlap bound is exact. A unary node has an empty exit cell and no side allocation. The same argument proves that every path vector satisfying (8) is attainable.

It follows that the closest distance in (7) is one minus the maximum over (8) of
\[
 \sum_{j\lt h}\min\{r_j-r_{j+1},c_f(P_j-P_{j+1})\}
  +\min\{r_h,1-c_f+c_fP_\ell\}.
 \tag{9}
\]
One auxiliary variable below each pair in a minimum yields the claimed linear program. In the space with one coordinate for each exit cell and one for the distinguished leaf, the distance from the collapsed \(q^\ell\) to the collapsed envelope is precisely (9)'s complement. Apply the same finite-dimensional minimax in these coordinates to obtain a cube witness constant on cells, using an optimizing linear-program dual. Choose a maximizing \(\ell\) in (7). For that witness \(F(X)-N(X)\ge q^\ell\cdot X-N(X)=\Delta_-\), so equality holds. This also proves the computational witness assertion when probabilities and coefficients are rational.

In the homogeneous case, allocate as much mass as possible along the selected path, \(r_{j+1}=(1-c+cp_j)r_j\). Then \(r_j\ge P_j\), and the off-path masses \(c(1-p_j)r_j\) dominate their targets. In the final cell,
\[
 r_h=\prod_{j\lt h}(1-c+cp_j)\le 1-c+c\prod_{j\lt h}p_j=q^\ell(\ell).
\]
The inequality follows by induction from
\((1-c+cu)(1-c+cv)\le1-c+cuv\) on \([0,1]^2\). Thus only the distinguished leaf has a deficit, equal to \(q^\ell(\ell)-r_h\). No feasible \(Q\) can allocate more than \(r_h\) there, by (8). This proves (5) and the singleton witness.

### Nested minus flat

More generally, when \(F\) is comonotone additive, a maximizing loss for \(\Delta_+\) can be taken to be an indicator. Write any loss as the nonnegative sum of layers of its nested upper level sets, with the total of the coefficients at most one. The flat value adds over these comonotone indicators. The nested risk is subadditive by induction using monotonicity and subadditivity at every node. The gap is therefore at most the largest indicator gap. The empty event supplies gap zero.

In (4), let \(E\) be such an event and use its unconditional nominal mass as the table coordinate. At an interior node, if \(x_i\) are child event values, the nesting takes the form
\[
 N_v(\mathbf 1_E)=
   \max_j\sum_i \bigl(c_v p_{vi}+(1-c_v)\mathbf 1_{i=j}\bigr)x_i .
 \tag{10}
\]
For each possible distinguished child \(j\), the coefficients in the sum are fixed and nonnegative. For that choice, merge the child event tables one at a time, adding their unconditional nominal masses and the weighted child values. After each merge, retain the greatest partial weighted sum for each mass key. At the end of the merges, recover the actual nested value of each representative by (10). Pool the representatives from all choices of \(j\) and retain the greatest actual nested value at each key. Leaves have just the empty and singleton event choices.

If masses are integer multiples of \(1/M\), use their exact integer counts as keys. For a fixed total count at a node, the greatest nested value follows from (10) and the nonnegative coefficients. Induction on the tree verifies it: for each target event pick a maximizing \(j\), and prune partial configurations only in favor of another with the same mass and at least as large a weighted sum. The final actual nested value is at least that retained weighted sum. The number of pairs to merge is \(O(M^2)\) for each child and choice of \(j\). At the root subtract \(F(\mathbf 1_E)=1-c_f+c_f P(E)\) for a nonempty event, and use value zero for the empty event. This proves exactness and the stated operation count.

For arbitrary rational masses use one-dimensional multiplicative bins as in (2), with zero separate and \(\delta=\varepsilon/(8n)\). When a configuration is replaced in a bin, its mass changes by at most \(1+\delta\) and its objective for that merge does not fall. For each target event one may inductively follow a retained witness whose nested value is at least that target's value and whose mass is within a factor \((1+\delta)^{\ell_v}\). At a leaf \(\ell_v=0\). At a node use
\[
 \ell_v=\max_i\ell_i+b_v+1 .
\]
Indeed, choose the index \(j\) in (10) for the target. Replace the child events by their witnesses, sum the weighted values, and preserve this sum using one pruning operation per merge. Addition of positive masses preserves the largest existing relative factor. The final pooling operation adds at most one more factor and retains at least the actual nested value. At the root \(\ell_o\le 2n\), since outdegrees sum to \(n-1\) and the number of interior nodes on a path is at most \(n-1\). Consequently the relative mass factor is at most \(1+\varepsilon/2\), and the change in the flat value of a nonempty event is at most \(\varepsilon/2\). This certifies the returned gap within \(\varepsilon\), using the true witness score and its increment by \(\varepsilon\) as bounds.

There are \(O(1+n\varepsilon^{-1}\log(1/P_*))\) bins. Pairwise merges and the loop over possible \(j\) use time polynomial in this number and the input length, with back-pointers for the final event. Every nested value in (10) is a finite weighted sum of unit losses with coefficients that are products of the rational local coefficients. Common denominators can be bounded by products of the input coefficient denominators over all nodes and children. Thus its exact numerator and denominator, and the masses and partial scores actually used, have polynomial bit length. This proves the fully polynomial additive claim.

## 4. An exact product calculation for the upward error

Suppose additionally that the nominal branching law is the same at all nodes of each layer \(j\), and \(c_v=c_j\) there. A path has one step from each layer, with unary layers allowed. At layer \(j\) let \(a_j\) denote the smallest nominal child probability in that layer. Take independent Bernoulli variables \(B_j\) of probabilities \(a_j\). Then
\[
 \Delta_+=
  \mathbb E\left[\left(c_f-\prod_{j=1}^H
       \left(c_j+\frac{1-c_j}{a_j}B_j\right)\right)_+\right].
 \tag{11}
\]
With the same \(c_j\) and \(a_j\) at all layers, this is a binomial sum with \(H+1\) terms.

To prove (11), the distance of a terminal probability \(Q\) to the flat envelope \(\{r:r_\ell\ge c_f P_\ell\}\) equals \(\sum_\ell(c_fP_\ell-Q_\ell)_+\). The lower bound is the total deficit of the constrained coordinates. For equality transfer that mass from the remaining coordinates, whose aggregate excess over their floors is sufficient. Minimax as in (7), now in the other direction, gives the largest such distance over \(\mathcal R\). Every \(Q\in\mathcal R\) is a convex combination of terminal measures obtained by taking one preferred child at each node and using the corresponding local vertex of (4). To see this, write every local conditional as a mixture of its vertices, select all vertices independently, and average their path products. The distance to the flat envelope is convex in \(Q\), so one of the deterministic choices attains its maximum.

Under the nominal law, if the probability of the preferred child at a node in layer \(j\) is \(p\), the multiplier of the path likelihood ratio at this layer is \(c_j+(1-c_j)B/p\), with \(B\) Bernoulli of parameter \(p\). Future optimal costs are identical functions of the current ratio \(r\) at every node in a layer, by the product assumptions. Starting at the leaves with \(\varphi(r)=(c_f-r)_+\), each backward cost remains convex as a maximum of nonnegative weighted sums of convex functions composed with nonnegative linear maps. For a given convex future cost \(\varphi\) and ratio \(r\), the candidate expectation is
\[
 \varphi(rc_j)+p\big[\varphi(rc_j+r(1-c_j)/p)-\varphi(rc_j)\big].
\]
It is nonincreasing in \(p\), since the secant slope of a convex function from a fixed left endpoint is nondecreasing in the length of the interval. When \(r(1-c_j)=0\) all choices have the same value. Thus a child of smallest nominal probability is optimal throughout, producing the independent factors in (11). The formula includes zero mean coefficients, with a product evaluated directly when a factor is zero.

## 5. Relation to earlier work and scope

Rectangular sets, their conditional pasting interpretation and support-function comparisons are established. Shapiro characterizes rectangularity by dynamic decomposition in robust optimization. In his finite scenario-tree time-consistency analysis, equality of probabilities on specified levels and symmetry give rigidity of recursive law invariance. We fix the entire tree and measure the additive change for all losses in the unit cube. The tail comparison allows the certificate to use a single tractable table at each stored probability key even for a noncomonotone risk. [Shapiro, Operations Research](https://doi.org/10.1287/opre.2015.1466) [Shapiro, Operations Research Letters](https://doi.org/10.1016/j.orl.2012.08.007)

Xin and Shapiro study the conditional analogues of law-invariant coherent risks. Their Propositions 3.1 and 3.2 bound nested AVaR by flat AVaR at the same or multiplied tail levels, and Proposition 4.2 integrates the product-tail bound for a comonotone risk. These comparisons apply for all losses in their domains and give general upper bounds. Our algorithms compute extremizing losses and numerical discrepancies for specified scenario probabilities and risk evaluators. This is the additional fixed-tree question addressed in Sections 2–4. [Xin–Shapiro, Operations Research Letters](https://doi.org/10.1016/j.orl.2012.09.002) [Author text, §§3–4](https://optimization-online.org/wp-content/uploads/2012/08/3553.pdf)

Iancu, Petrik and Subramanian study multiplicative domination of static and dynamic risks over nonnegative losses. Their general hardness results and their exact algorithms for selected ratios refer to that scale-invariant comparison. The objectives here are two unit-cube additive discrepancies for fixed preferences. The new computations are the certified oracle scheme from tail masses, the one-dimensional event optimization for the positive direction in (4), and the exact reverse formulas and witness reduction to one path. The general oracle result is polynomial for fixed branching and fixed requested accuracy. Exact computation on arbitrary weighted trees outside the stated cases is unresolved here. [Iancu–Petrik–Subramanian, Mathematics of Operations Research](https://doi.org/10.1287/moor.2014.0689)

## Appendix A. Uniform propagation and synchronized rigidity

This appendix gives risk envelopes and rigidity results over classes of risks or all trees. Sections 2–4 quantify the errors for one specified tree and specified risks.

### A.1 Model and statements

Let each risk functional $\rho$ act on $L^\infty$ of a standard atomless probability space. It is finite, normalized, law invariant, monotone in losses, translation equivariant, positively homogeneous, subadditive, and has the Fatou property for bounded almost surely convergent sequences. Thus it acts on every bounded probability law. Write
\[
A(\rho)=\sup_{0\le X\le1}(\rho(X)-\mathbb EX),\quad
a(\rho)=\inf_{p>0}\rho(\operatorname{Ber}(p)),\quad
B(\rho)=1-a(\rho),\quad d(\rho)=\min\{A(\rho),B(\rho)\}.
\]
Then $A,B$ are the uniform distances to expectation and essential supremum, respectively.

A scenario tree is finite, with finitely many nodes and finitely many children at each interior node. Its depth is $H\ge1$, all existing edges have positive conditional probability, and every interior node is assigned a risk functional $\rho_v$. One-child nodes are permitted and may be used to extend all terminal paths to depth $H$. A terminal loss $X$ lies in $[0,1]$. Denote the bottom-up nested value by $N(X)$ and the root functional evaluated directly on the terminal law by $F(X)=\rho_o(X)$.

**Theorem A.1.** Let $A_h=\max_{v\ {\rm at\ stage}\ h}A(\rho_v)$ and $a_h=\min_{v\ {\rm at\ stage}\ h}a(\rho_v)$, where the root is stage one. For any such tree and loss,
\[
\begin{split}
N(X)-F(X)&\le
\min\!\left\{1-a_1,\ 1-\prod_{h=2}^H(1-A_h)\right\},\\
F(X)-N(X)&\le
\min\!\left\{A_1,\ 1-\prod_{h=2}^H a_h\right\}.
\end{split}
\tag{A.1}
\]
The proof gives tighter certificates for the individual tree. The two product terms are sharp over the indicated stagewise envelopes. More precisely, for any $A_1,\ldots,A_H < 1$ the upper product term is achieved with $\rho_h$ equal to CVaR of tail mass $1-A_h$. For any specified $a_2,\ldots,a_H\in[0,1]$, the lower product term is approached with a maximum at the root and conditional mean–maximum mixtures downstream.

**Corollary A.2.** Suppose that the same $\rho$ is used everywhere, and let $\Delta_H(\rho)=\sup_{T,\,0\le X\le1}|N(X)-\rho(X)|$. For each $d_0\in[0,1]$,
\[
\sup_{d(\rho)\le d_0}\Delta_H(\rho)=1-(1-d_0)^{H-1}.
\tag{A.2}
\]
At $H=1$ the value is zero. For $d_0 < 1$ the supremum is attained by CVaR, on a finite binary tree if $0 < d_0 < 1$.

**Theorem A.3.** Suppose $H\ge2$ and one risk functional $\rho_h$ is specified per stage, with arbitrary scenario trees allowed. Let $\Delta=\sup_{T,X}|N(X)-\rho_1(X)|$. There exists a single functional $\rho_\star\in\{\mathbb E,\operatorname{esssup}\}$ such that
\[
\max_{1\le h\le H}\sup_{0\le X\le1}|\rho_h(X)-\rho_\star(X)|\le17\Delta .
\tag{A.3}
\]
Conversely, if the distance to a common extreme is at most $\epsilon\in[0,1]$ at all stages, then $\Delta\le1-(1-\epsilon)^{H-1}$. Different extremes at different stages give no nontrivial bound based solely on those individual distances.

### A.2 Finite envelopes

For every finite partition $\mathcal F$ one has $\rho(\mathbb E[X\mid\mathcal F])\le \rho(X)$. To see this, construct conditionally independent copies of $X$ on each positive-probability atom of $\mathcal F$ using its atomless probability space. The unconditional laws are all the law of $X$. Convexity bounds the risk of their average by $\rho(X)$, and the conditional strong law and Fatou property give the assertion. The trivial partition gives $\rho(X)\ge\mathbb EX$. Monotonicity gives $\rho(X)\le\operatorname{esssup}X$. On unit losses $\rho(X)\ge a(\rho)\operatorname{esssup}X$ by testing $X\ge t\mathbf1_{\{X>t\}}$ and taking $t$ up to the essential supremum. Applying this bound to rare Bernoulli losses shows that the uniform distance to the maximum is exactly $1-a(\rho)$.

For a node with child law $p_v$, the function of finitely many child values is sublinear, monotone and translation equivariant. The finite-dimensional supporting-hyperplane theorem gives a compact convex probability envelope $Q_v$ such that
\[
\rho_v(x)=\max_{q_v\in Q_v}q_v\cdot x .
\]
Indeed any supporting linear functional is nonnegative by monotonicity and has mass one by translation equivariance. The nominal vector $p_v$ belongs to $Q_v$ because $\rho_v(x)\ge p_v\cdot x$. For each $q_v\in Q_v$,
\[
\|q_v-p_v\|_{\mathrm{TV}}=\max_{S}(q_v(S)-p_v(S))\le A(\rho_v).
\tag{A.4}
\]
Fresh choices at each node give the terminal product-law envelope $\mathcal R_T$. Maximizing the expected terminal loss by backward induction gives $N(X)=\max_{Q\in\mathcal R_T}E_QX$. The set $\mathcal R_T$ is compact by continuity of products and convex because the conditional law of a mixture at each visited node is a mixture of its component conditionals. At an unvisited node one may choose any permitted kernel.

### A.3 The two directions

### Change in probability below the root

For a given $Q\in\mathcal R_T$, keep its root kernel and replace every downstream kernel with the nominal one. Call the resulting terminal law $Q'$ and let $m_i$ be the nominal conditional mean loss under root child $i$. Then
\[
E_{Q'}X=\sum_i q_{o,i}m_i\le \rho_o(m)\le \rho_o(X).
\tag{A.5}
\]
The last inequality is the conditional averaging property. Along synchronized paths in the two laws, couple each conditional pair of child laws with common mass $\min(p_{v,i},q_{v,i})$ on child $i$. Both marginals of this coupling are the required transition laws. If paths differ, their continuations can be coupled arbitrarily. With leaves assigned $g_v=1$, define for nonroot interior nodes
\[
g_v=\min_{q_v\in Q_v}\sum_i\min(p_{v,i},q_{v,i})g_i .
\tag{A.6}
\]
Induction shows that the probability that the two paths agree at the terminal leaf is at least $\min_{q_o\in Q_o}\sum_iq_{o,i}g_i$. For losses between zero and one the resulting certificate is
\[
N(X)-F(X)\le1-\min_{q_o\in Q_o}\sum_i q_{o,i}g_i.
\tag{A.7}
\]
This bound can be evaluated node by node from the envelopes. In (A.6) the weighted sum of minima is the minimum of finitely many affine forms, obtained by deciding for each child which of its two terms to use. Taking the minimum over the envelope requires only its support values in those directions.

By (A.4), $\sum_i\min(p_{v,i},q_{v,i})\ge1-A(\rho_v)$. Thus (A.7) gives the first product in (A.1). Also $F(X)\ge a_1\max X$ and $N(X)\le\max X$, giving the other bound in that direction.

### Retaining a subtree maximum

For an edge $v\to i$, write $\theta_{vi}=\max_{q_v\in Q_v}q_{v,i}=\rho_v(\operatorname{Ber}(p_{v,i}))$. Set $s_v=1$ at leaves and $s_v=\min_i\theta_{vi}s_i$ at each nonroot interior node. If $M_v$ is the largest terminal loss below $v$, its recursively evaluated value is at least $s_vM_v$. Indeed a child attaining the largest terminal loss can be assigned mass $\theta_{vi}$ by a permissible kernel, and all other child values are nonnegative. The flat root value obeys $F(X)\le\rho_o((M_i)_i)$ by monotonicity. The nested root value is at least $\rho_o((s_iM_i)_i)$. Subadditivity yields
\[
F(X)-N(X)\le \rho_o((1-s_i)_i)
=1-\min_{q_o\in Q_o}\sum_iq_{o,i}s_i.
\tag{A.8}
\]
Each $\theta_{vi}\ge a(\rho_v)$, giving the second product in (A.1). The root also satisfies $F(X)\le\mathbb EX+A_1$ and the nested evaluation is at least $\mathbb EX$, completing the proof.

The certificates apply to two trees with the same terminal probability space and the same root functional, even if their intermediate partitions differ. If $(U_T,L_T)$ and $(U_{T'},L_{T'})$ bound the respective directed errors, then $N_T(X)-N_{T'}(X)\le U_T+L_{T'}$. They also bound optimization error for replacing a flat criterion with its nested version. If the bounds hold on the entire feasible family of losses, a minimizer under the nested criterion has flat regret at most $U_T+L_T$, by comparing its nested value and that of a flat minimizer.

For given full envelopes there is also an exact description of the worst directed error. For compact convex probability envelopes $C,D$ on a common finite space, let $h_C,h_D$ be their support functions. Then
\[
\sup_{0\le X\le1}(h_C(X)-h_D(X))
=\max_{q\in C}\min_{r\in D}\|q-r\|_{\mathrm{TV}} .
\tag{A.9}
\]
For each fixed $q$, finite-dimensional minimax interchanges $\max_{X\in[0,1]^L}$ and $\min_{r\in D}$ in $(q-r)\cdot X$. Maximizing this linear expression over the unit cube gives total variation. This identity works for the flat and rectangular envelopes and for the envelopes of two different trees.

### A.4 Sharpness

For $\eta\in(0,1]$ write $C_\eta$ for upper-tail CVaR of mass $\eta$. Its dual probabilities have likelihood ratio at most $1/\eta$ with respect to the nominal probabilities. Equivalently it is the average of the highest $\eta$ portion of the loss distribution, with partial mass at ties. For Bernoulli losses its value is $\min(p/\eta,1)$. The dual likelihood ratio cap gives overlap at least $\eta$ with the nominal law, so $A(C_\eta)\le1-\eta$, with equality at $p=\eta$. Also $a(C_\eta)=0$.

Assign $C_{\eta_h}$ to stage $h$ and use independent successes of probabilities $\eta_h$, with terminal loss one when every trial succeeds and zero otherwise. At every live node the evaluation of success is one. The nested value is one and the flat value is $\prod_{h=2}^H\eta_h$. Deterministic stages with $\eta_h=1$ can use one child. This proves upper product sharpness. For the other direction choose maximum at the root and use $a_h\max+(1-a_h)\mathbb E$ at stages $h\ge2$. Take independent successes of probability $p>0$ in all those stages and count their conjunction as terminal loss. The root may have one child. The flat value is one while the nested value is $\prod_{h=2}^H(a_h+(1-a_h)p)$. Taking $p\downarrow0$ gives the lower product result.

For a homogeneous functional, if $d=A$, the first product bounds upward error and $A$ bounds downward error. If $d=1-a$, the second product bounds downward error and $1-a$ bounds upward error. For $H\ge2$ the relevant geometric expression is at least the one-stage bound. This proves the upper bound in (A.2), and the CVaR construction with $\eta_h=1-d_0$ gives equality for $d_0 < 1$. Letting $d_0$ increase to one supplies the endpoint supremum.

These examples also describe uniform guarantees over arbitrarily long finite truncations. For example, with fixed $A_1 < 1$ and $\sum_{h\ge2} A_h < \infty$, $A_h < 1$ individually, the upward gap is bounded by $1-\prod_{h\ge2}(1-A_h) < 1$. If the sums diverge, the finite-truncation supremum can be one even when each level uses CVaR and $A_h\to0$. The corresponding downward statement holds for $1-a_h$ with a maximum root. No convergence of infinite-stream risk functionals is required for these statements.

### A.5 Rigidity under changes of stage preference

First, for any one risk functional let $v(p)=\rho(\operatorname{Ber}(p))$. Finite-layer approximations of an arbitrary $X\in[0,1]$, subadditivity, and uniform continuity of the risk imply
\[
A=\sup_{p\in[0,1]}(v(p)-p).
\]
Indeed represent a lower uniform-step approximation of $X$ as a sum of scaled level-set indicators, subtract its expectation and pass to the uniform limit. A Bernoulli loss supplies the reverse inequality. The conditional averaging property gives
\[
v(y+(x-y)p)\ge y+(x-y)v(p),\qquad 0\le y\le x\le1.
\tag{A.10}
\]
This is obtained by taking the conditional mean of a success indicator whose probabilities on the two branches of masses $p,1-p$ are $x,y$. For $0 < p < q$, take $x=p/q,y=0$ in (A.10) to see $v(p)\ge (p/q)v(q)$, so $v$ is continuous on $(0,1]$. Write $r=v(1/2)$. To bound $v(p)-p$ at $p\le1/2$, use $x=1$, $y=(1/2-p)/(1-p)$ in (A.10). For $p\ge1/2$ use $x=1/(2p)$ and $y=0$. Both give $v(p)-p\le2r-1$, hence $A\le2r-1$.

Let $D_2$ be the supremum absolute discrepancy for success indicators on two successive binary branches when both stages use $\rho$. At $t\in(0,1)$ set $c=v(t)$, $u=v(t^2)$ and $w=v(2t-t^2)$. The three signed flat-minus-nested residuals
\[
u-c^2,\qquad w-2c+c^2,\qquad c-(1-r)u-rw
\]
are legitimate tests. The first is an intersection, the second a union, and the third uses a half-mass split between conditional success probabilities $t^2$ and $2t-t^2$. Weight their sum by $1-r,r,1$, respectively, to obtain $-(2r-1)c(1-c)$. Each residual is at least $-D_2$, so when $a\le1/2$ one can take or approach $c=1/2$ to get $A\le8D_2$. If $a>1/2$, the union residual tends to $-a(1-a)$ as $t\downarrow0$, giving $1-a\le2D_2$. Thus $d(\rho)\le8D_2$.

For stagewise varying preferences, a tree with randomness only at stage $h$ has nested risk $\rho_h$ and flat risk $\rho_1$. Therefore $\|\rho_h-\rho_1\|_{[0,1]}\le\Delta$, first on finite laws and then by uniform discretization. Use a two-live-stage tree with stages one and two. Substituting $\rho_1$ for $\rho_2$ changes the first-stage nested result by at most $\Delta$ since a normalized monotone translation-equivariant risk is $1$-Lipschitz in the sup norm. Thus $D_2(\rho_1)\le2\Delta$ and the single-functional inverse just proved gives $d(\rho_1)\le16\Delta$. The triangle inequality gives (A.3). The converse follows from (A.1). To see why stagewise synchronization is essential, take expectation at the root and maximum at stage two, with the same rare-success conditional law on both first-stage branches. The nested value is one and the flat value tends to zero. For maximum followed by expectation, the opposite directed discrepancy tends to one.

### A.6 Relation to existing theory

The finite probability-envelope and pasting constructions are established. Shapiro uses rectangular sets to characterize dynamic decomposition, and proves the expectation/maximum restriction under symmetry in equal-probability finite scenarios. The new estimates use the probability mass preserved by each transition to give sharp additive quantitative control for bounded losses across depth, independently of minimum atom mass. The alignment result uses the uniform family of trees, including one-live-stage trees. It does not infer rigidity from one fixed filtration. [Shapiro, Operations Research 64(2), 528–541, DOI 10.1287/opre.2015.1466](https://doi.org/10.1287/opre.2015.1466) [Shapiro, Operations Research Letters 40(6), 436–439, DOI 10.1016/j.orl.2012.08.007](https://doi.org/10.1016/j.orl.2012.08.007)

Iancu, Petrik and Subramanian characterize multiplicative approximation factors for given static and dynamic risk measures, with multiperiod results for comonotone risks and CVaR calculations in §4.3 and Theorem 8 of their author manuscript. Their nested CVaR envelope analysis anticipates the product of tail masses for that family. Here the product is a sharp additive stability modulus across the whole law-invariant coherent class, plus directed certificates for heterogeneous preferences. The fixed-envelope identity (A.9) is ordinary support-function duality. The present bounds do not supply their multiplicative domination factors or solve the general exact envelope optimization efficiently. [Iancu, Petrik and Subramanian, Mathematics of Operations Research 40(3), 655–682, DOI 10.1287/moor.2014.0689](https://doi.org/10.1287/moor.2014.0689)
