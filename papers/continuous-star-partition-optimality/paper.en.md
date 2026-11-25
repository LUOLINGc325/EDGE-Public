# Optimal centroid partitions in one-trap games on finite metric trees

## Abstract

We prove Lidbetter and Lin’s centroid-partition conjecture for a single trap on every finite metric tree. The value depends only on the lengths of the branches at a centroid, and an optimal attacker selects a part of a maximizing centroid partition with inverse-length probabilities. An optimal defender mixes threshold-dependent branch separators and a centroid atom. The certificate applies to all connected measurable attacks using actual point membership at endpoints and at branch vertices. For stars we also give the explicit radial defender and a rational unequal-arm example. In unnormalized length units, deleting branches changes the value by at most the total length deleted.

## 1. Problem, provenance, and precise claim

A finite star consists of a center $o$ and $n\ge2$ arms of lengths $a_1,\ldots,a_n>0$. Normalize total length to

$$
\sum_{i=1}^{n} a_i=1,\qquad a_i\le\tfrac12.
\tag{1}
$$

The defender chooses one trap point $z$ anywhere in the network. The attacker chooses a connected measurable subset $S$. Its reward is its length $|S|$ when $z\notin S$, and zero otherwise. The center and arm endpoints are valid trap points; attacks need not be closed. Both players may randomize.

This is the continuous-network model of Lidbetter and Lin [1, Section 3]. Their Section 6 supplies the centroid-partition attack and poses its optimality for all stars and trees. Sections 2–6 develop the explicit star defender. Section 7 constructs a defender for the entire finite-tree model.

For a nonempty proper subset $I\subsetneq[n]$, set

$$
 A_I=\sum_{i\in I}a_i,\qquad
 B_I=\sum_{i\in I}a_i^{-1},\qquad
 U_I=\frac{|I|}{B_I+(1-A_I)^{-1}},\qquad
 V=\max_{\varnothing\ne I\subsetneq[n]} U_I.
\tag{2}
$$

Every denominator is positive. A maximizing subset exists because the set of candidates is finite. For convenience, assign value zero to the empty and full subsets when taking a maximum over all subsets.

**Theorem 1 (explicit saddle certificate).** Under (1), the game has value $V$. A maximizing centroid partition, with inverse-length probabilities, guarantees expected reward exactly $V$ against every trap point. The probability measure constructed in Section 4 gives expected reward at most $V$ to every connected measurable attack.

The proof uses the finite maximum in (2). The attacker’s partition guarantee and the candidate ordering reduction in [1, Theorem 9] are prior results.

## 2. The partition strategy and elementary bounds

For any nonempty proper $I$, split off each arm in $I$, with its center removed. Merge all other arms and the center into one last part. These are disjoint connected measurable sets covering the star. Their positive lengths are $a_i$, for $i\in I$, and $b=1-A_I$.

Write $D=B_I+b^{-1}$. Choose a part of length $c$ with probability $1/(Dc)$. These probabilities sum to one, and each probability multiplied by the corresponding length is $1/D$. Each trap point belongs to exactly one part, including at the center and all outer endpoints. Consequently the expected reward is

$$
 \frac{|I|}{D}=U_I
\tag{3}
$$

at every trap location. Taking a maximizing $I$ proves the lower guarantee in Theorem 1. This argument is the source's partition construction, with endpoint membership made explicit.

**Lemma 2 (singleton and normalization bounds).** For every arm,

$$
 V\ge a_i(1-a_i)>0,\qquad a_i\le2V.
\tag{4}
$$

Define, for $t\ge0$,

$$
 f(t)=\begin{cases}0,&t\le V,\\1-V/t,&t>V.\end{cases}
\tag{5}
$$

Then $0\le f(t)\le t$ whenever $0\le t\le a_i$, and

$$
 \sum_i f(a_i)\le1.
\tag{6}
$$

*Proof.* The singleton partition $I=\{i\}$ has value $a_i(1-a_i)$, which proves the first inequality. Since $1-a_i\ge1/2$, it also proves $a_i\le2V$. If $t\le V$, the bound on $f(t)$ is immediate. Otherwise $0<t\le a_i\le1/2$, so

$$
 t(1-t)\le a_i(1-a_i)\le V.
$$

Dividing by $t$ gives $1-V/t\le t$. Summing at $t=a_i$ proves (6). $\square$

**Lemma 3 (endpoint bound).** For every $I\subseteq[n]$,

$$
 (1-A_I)\sum_{i\in I} f(a_i)\le V.
\tag{7}
$$

*Proof.* Let $J=\{i\in I:a_i>V\}$. If $J$ is empty, the left side is zero. If $J=[n]$, then $I=[n]$ and $1-A_I=0$. Otherwise $J$ is nonempty and proper. The inequality $V\ge U_J$, multiplied by its positive denominator, gives

$$
 (1-A_J)(|J|-VB_J)\le V.
$$

Here $|J|-VB_J=\sum_{i\in I} f(a_i)\ge0$, while $1-A_I\le1-A_J$. This proves (7). $\square$

## 3. A continuous truncation inequality

**Lemma 4 (finite rounding).** If $0\le y_i\le a_i$ for every $i$, then

$$
 \left(1-\sum_i y_i\right)\sum_i f(y_i)\le V.
\tag{8}
$$

*Proof.* Suppose the product is greater than $V$, and write

$$
 L=1-\sum_i y_i,\qquad H=\sum_i f(y_i),\qquad F=LH>V.
$$

We have $0\le L\le1$ and $H\le1-L$ by Lemma 2. Hence, for every $i$,

$$
 L(1-L)\ge LH>V\ge a_i(1-a_i).
\tag{9}
$$

This implies $L>a_i$: otherwise both $L$ and $a_i$ lie in $[0,1/2]$, where $t(1-t)$ is increasing, contradicting (9).

First replace every coordinate satisfying $y_i\le V$ by zero. This leaves $H$ unchanged and increases or preserves $L$; thus the strict violation survives.

For a remaining coordinate $V<y<a=a_i$, replace $y$ by $a$. The new factors are

$$
 L'=L+y-a>0,\qquad H'=H+V/y-V/a.
$$

A direct calculation gives

$$
 L'H'-LH=(a-y)\left[\frac{(L+y-a)V}{ay}-H\right].
\tag{10}
$$

Because $V/a\ge1-a$, $H\le1-L$, and $L>a$, the bracket is bounded below by

$$
 \frac{(L+y-a)(1-a)}{y}-(1-L)
 =\frac{(L-a)(1-a+y)}{y}>0.
\tag{11}
$$

This step strictly increases $F$. After every update the vector remains in the same box and still violates (8), so (9) applies again and reestablishes the inequalities needed for the next step. Repeating finitely many such steps produces a vector with each coordinate equal to zero or its arm length, while preserving $F>V$. Its product is bounded by $V$ by Lemma 3, a contradiction. The rounding process is finite and uses no differentiability, limiting argument, or assumed maximizer in the continuous box. $\square$

## 4. A concrete probability measure for the defender

Set

$$
 p_i=f(a_i),\qquad p_0=1-\sum_i p_i.
\tag{12}
$$

Lemma 2 implies that these are nonnegative and sum to one. Put mass $p_0$ at the center. On arm $i$, whose coordinate $x$ is distance from the center, use the continuous cumulative mass function

$$
 F_i(x)=f(a_i)-f(a_i-x),\qquad 0\le x\le a_i.
\tag{13}
$$

Extend it by zero for $x\le0$ and by $p_i$ for $x\ge a_i$. This is nondecreasing and continuous, begins at zero, and has total mass $p_i$. Its Stieltjes measure is therefore a well-defined finite measure supported on the arm, with no point atoms. The arm measures and the center atom define a probability measure $\mu$ supported on the star.

For $a_i\le V$, this arm measure is zero. Otherwise it has no mass beyond $a_i-V$, because $f(a_i-x)=0$ there. This short support, together with $a_i\le2V$, is used below. The proof requires only the cumulative functions in (13); no density approximation or numerical integration is involved.

## 5. The upper guarantee for every connected attack

We first state the geometric facts used to pass from a continuum of attacks to the formulas below. Embed the star as the union of the coordinate segments $\{t e_i:0\le t\le a_i\}$ in $\mathbb R^n$. A connected subset avoiding the origin lies entirely in one arm. Its coordinate set is an interval, with any combination of included or excluded endpoints. A connected subset containing the origin has an initial interval on each arm. These statements follow from the intermediate value property of coordinate functions and the fact that distinct arms intersect only at the origin.

Length is the sum of the ordinary one-dimensional lengths of the arm slices. For a nonempty bounded interval, length is its supremum minus its infimum. For any continuous Stieltjes measure, its mass is the cumulative function at the supremum minus that at the infimum. Thus open or closed endpoints away from the center have no effect on either length or arm probability. The center atom is always accounted for separately.

**Lemma 5 (attacks omitting the center).** Every connected measurable $S$ with $o\notin S$ satisfies

$$
 |S|(1-\mu(S))\le V.
\tag{14}
$$

*Proof.* The empty set has zero reward. Otherwise $S$ lies in one arm $i$, with endpoints $s\le t$, length $\ell=t-s$, and $0\le s\le t\le a_i$. If $\ell\le V$, nonnegativity of the captured probability immediately gives (14).

Suppose $\ell>V$. We have $a_i-V\le V<\ell\le t$, so the right endpoint lies beyond the support of the arm measure. Since the arm measure has no atoms,

$$
 \mu(S)=p_i-F_i(s)=f(a_i-s)\ge f(\ell)=1-V/\ell.
\tag{15}
$$

Here $a_i-s\ge t-s=\ell$ and $f$ is nondecreasing. Multiplication by $\ell$ proves (14). This uses the support bound; a general monotone-density rearrangement assertion is unnecessary. $\square$

**Lemma 6 (attacks containing the center).** Every connected measurable $S$ with $o\in S$ satisfies (14).

*Proof.* Write $x_i\in[0,a_i]$ for the length of its initial interval on arm $i$, and $y_i=a_i-x_i$. Then

$$
 |S|=\sum_i x_i=1-\sum_i y_i,
 \qquad
 1-\mu(S)=\sum_i[p_i-F_i(x_i)]=\sum_i f(y_i).
\tag{16}
$$

The center atom is included in $\mu(S)$, so no extra term is omitted. The product in (14) is exactly the expression bounded by Lemma 4. $\square$

Lemmas 5 and 6 prove the upper guarantee for every pure attack, including singletons and nonclosed sets. Averaging a pointwise upper guarantee cannot increase it. Similarly, the finite partition strategy has the same reward $V$ at every trap point, so averaging over any trap distribution preserves its lower guarantee. These two explicit guarantees establish Theorem 1 without needing to assume the existence of a minimax optimizer.

## 6. A nondegenerate unequal-arm instance

Take

$$
 (a_1,a_2,a_3,a_4)=(3/10,3/10,1/5,1/5).
$$

The maximum in (2) is $V=12/55$, attained by $I=\{1,2\}$. The partition lengths are $3/10,3/10,2/5$, so the corresponding attack probabilities are $4/11,4/11,3/11$.

The explicit defender has arm masses $3/11,3/11,0,0$ and center mass $5/11$. Its two nonzero arm distributions are supported within distance $9/110$ of the center. This four-arm asymmetric example lies beyond the source's equal-arm and three-arm special cases and demonstrates why an atom at the center cannot be silently discarded.

An exact rational enumeration of all proper subsets is included with the case. The general written proof does not depend on that enumeration. A symmetric three-arm instance also supplies a basic nonempty model with value $2/9$.

## 7. The finite-tree theorem

Let $T$ be the metric realization of a finite tree with positive edge lengths, normalized to total length one, with length measure given by Lebesgue measure along its edges. The payoff and legal attacks are those in Section 1. A length centroid $o$ exists. The continuous function $x\mapsto\int_T d(x,y)\,d\ell(y)$ attains a minimum by compactness. Upon moving from a minimizer in a given branch direction, the one-sided derivative is $1-2a$, where $a$ is that branch's length. Indeed for each fixed point other than the minimizer the distance derivative is $-1$ in the same branch and $+1$ in all other branches, and each difference quotient has absolute value at most one. Every derivative is nonnegative at a minimum, so each branch length is at most one half. Subdivide the tree at $o$ when it lies inside an edge.

**Theorem 7.** Write $a_i$ for the lengths of the components of $T\setminus\{o\}$. The value of the one-trap game on $T$ equals the number $V$ in (2) computed from the $a_i$. An optimal attacker uses a maximizing centroid partition. An optimal defender is the measure constructed below. A length-zero tree consists of one point and has value zero.

**The attacker.** The parts in Section 2 are now whole branches, with all remaining branches joined through the centroid. They are disjoint, connected, and measurable. The same inverse-length probabilities give payoff $V$ at every trap point.

**Branch separators.** Root the closure of branch $i$ at $o$. Fix a threshold $V<t<a_i$. We construct a separator $z_i(t)\ne o$ whose outward subtree, including all its outward components, has total length at least $t$; each individual outward component has length at most $t$. Start along the sole initial branch direction. At an interior point the outward length decreases linearly with distance along its edge, so stop if it reaches $t$ before the next vertex. At a vertex reached with outward total at least $t$, stop if every child component has length at most $t$. Otherwise continue down the child of length greater than $t$. That child is unique because $2t>2V\ge a_i$ by (4). Every continuation begins with outward length greater than $t$, so it either attains $t$ along the edge or reaches another vertex with outward length at least $t$. Finiteness ensures termination. The component toward the root after deleting the separator has length at most $a_i-t$.

On each edge the possible threshold cutoffs at its endpoints are constants. Partition the threshold interval by the finite list of these constants, including the lengths of all vertex child components. On every open piece the branch choices are fixed and the stopper is either a fixed vertex or an affine position on a fixed edge. The assignment is Borel, including its finitely many threshold boundaries.

**The defender.** For each branch with $a_i>V$, push the measure $V\,dt/t^2$ on $(V,a_i)$ forward by $z_i$. A branch with $a_i\le V$ carries zero mass. The mass on branch $i$ is $f(a_i)$, for $f$ as in (5). Put the residual $1-\sum_i f(a_i)$ at $o$. It is nonnegative by the elementary bound $f(a_i)\le a_i$ of Section 2. The resulting measure $\mu$ is a probability measure, possibly with additional atoms at branch vertices. Every connected attack intersects each open edge in an interval, possibly empty or a singleton, by arc containment. Together with its chosen vertices these finitely many intervals make it Borel and therefore measurable for this defender.

**Attack omitting $o$.** A connected subset of a tree contains the arc joining any two of its points. This follows because removal of any interior point of that arc puts the two endpoints in distinct open components. An attack omitting $o$ therefore lies in one branch, say of length $a_i$. If its length $s\le V$, its payoff is directly at most $V$. Otherwise, for every $V<t<s$, the separator belongs to the attack. If it did not, the connected attack would lie in one component of that branch with the separator removed. Every outward component has length at most $t$, and the component toward the root has length at most $a_i-t<t$. No such component can contain an attack of length $s$. Hence $\mu(S)\ge\int_V^s V\,dt/t^2=f(s)$, and $s(1-\mu(S))\le V$.

**Attack containing $o$.** Write $y_i=a_i-\ell(S\cap\text{branch }i)$. If the attack omits $z_i(t)$, arc containment forces it to omit the whole outward subtree at that separator. Thus $y_i\ge t$. The missed mass on branch $i$ is at most $f(y_i)$. The attack contains the centroid atom, so its expected payoff is at most
$$
 \left(1-\sum_i y_i\right)\sum_i f(y_i)\le V
$$
by the scalar inequality of Section 3. This argument includes attacks with nonclosed boundaries. Together the pointwise upper and lower guarantees prove Theorem 7. $\blacksquare$

For a star branch and $V<t<a_i$, the separator is the arm point at distance $a_i-t$ from $o$, so the pushed-forward measure recovers the radial distribution of Section 4. On a general tree the stopping point can be a branch vertex over an interval of thresholds. The branch totals at a centroid determine the value even when the positions of the trap atoms depend on the internal geometry.

## 8. Stability under pruning

Use unnormalized length units. For a nonempty closed connected subtree $T_0\subseteq T$, let $\delta=\ell(T)-\ell(T_0)$. Then
$$
 V(T_0)\le V(T)\le V(T_0)+\delta .
$$
In fact, the first quantity bounds the lower game value from below and the last quantity bounds the upper game value from above even if only the subtree is known to have a value.

To see the lower bound, retract every deleted component to its unique attachment point in $T_0$. The inverse image of a connected measurable attack in $T_0$ is connected and measurable and has at least its length. The retracted trap lies in the original attack exactly when the actual trap lies in its lifted attack. Apply this to the subtree attack strategy. For the upper bound use the subtree defender supported on $T_0$. The intersection of any connected attack with $T_0$ is connected or empty by arc containment. It has the same trap membership as the original attack and differs in length by at most $\delta$. The upper game value consequently increases by at most $\delta$. With normalized payoffs on $T$, divide both unnormalized endpoints by $\ell(T)$.

## 9. Source scope and verification

Lidbetter and Lin’s §3 defines the network game, §§4–5 supply tree bounds and star cases, and §6 explicitly conjectures optimality of the partition strategy for all stars and trees. Their partition strategy is the attacker in the present theorem. The short-arm star proof provides the scalar bound and radial law. The tree defender extends the latter by proving two length properties of each threshold-dependent separator. The all-tree conclusion refers to one trap on finite metric trees under the connected measurable attack convention. [Author preprint, §§3–6](https://arxiv.org/html/2412.01688v1) · [Operations Research publication](https://doi.org/10.1287/opre.2024.1518)

On 2026-11-25 the author preprint's conjecture and model were reopened and checked, and a focused query for the continuous booby-trap centroid-partition problem was compared with the publisher and with the earlier Lidbetter–Lin hypergraph model. The latter uses sets of boxes as attacks, with one or several booby traps, rather than continuous connected subsets of a metric tree. The publisher exposes the article abstract and citation, while the exact conjecture wording is pinned to the author preprint. No equivalent proof was found in the inspected sources. [Network article](https://doi.org/10.1287/opre.2024.1518) · [Discrete hypergraph article](https://www.sciencedirect.com/science/article/pii/S0304397520301626)

The original manuscript reports partial formalization of rounding, finite partitions and geometric classification. The new tree separator measure and pruning transfer do not have complete Lean verification. The Lean source is not included in this edition.

## References

[1] Thomas Lidbetter and Kyle Y. Lin. *A Booby Trap Game*. arXiv:2412.01688v1, 2024, Section 6, especially the partition strategy, Theorem 9, and the closing star/tree conjecture. Published version: *Operations Research* 74(5), 2402–2414, DOI: [10.1287/opre.2024.1518](https://doi.org/10.1287/opre.2024.1518). Exact open-question text consulted: [arXiv HTML v1](https://arxiv.org/html/2412.01688v1). The publisher's complete final text was not accessible during this audit, so exact target wording is pinned to the available author preprint rather than attributed to an unseen final page.

[2] The mathlib community. *mathlib4*, revision `c44e0c8ee63ca166450922a373c7409c5d26b00b`, Lean 4.19.0. Standard topology, real analysis, finite sums, and Stieltjes measure infrastructure used by the formalization sources. [Source revision](https://github.com/leanprover-community/mathlib4/tree/c44e0c8ee63ca166450922a373c7409c5d26b00b).
