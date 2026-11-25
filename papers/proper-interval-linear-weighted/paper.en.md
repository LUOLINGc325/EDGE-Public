---
title: "Linear weighted full-cover unique domination on proper intervals"
fontsize: 11pt
geometry: margin=1.08in
abstract: |
  A full-cover unique domination solution dominates every vertex and rewards those dominated exactly once. For a sorted proper interval representation, we give a linear-time exact algorithm with nonnegative vertex rewards, nonnegative center costs, and witness recovery. On a feasible center chain, the reward between successive centers depends on two neighborhood boundaries. This reduces the quadratic interval dynamic program to two values per center and four sliding-window maxima. The same compression gives the entire optimum frontier up to a cardinality budget \(b\) in \(O(nb)\) time.
---

## 1. Model and results

Let \(G\) be represented by closed intervals \(I_v=[L_v,R_v]\). Distinct intervals in the proper representation may not contain one another. Identical intervals are allowed. A set of centers \(S\) is feasible if every interval intersects at least one selected interval, counting an interval's intersection with itself. For finite nonnegative rewards \(w_v\) and finite nonnegative costs \(c_v\), maximize
\[
\operatorname{val}(S)=
\sum_v w_v\,\mathbf1_{\{|N[v]\cap S|=1\}}-\sum_{v\in S}c_v .
\tag{1}
\]
Here \(N[v]\) denotes the closed neighborhood. The optional constraint is \(|S|\le b\). The empty representation has the empty solution with value zero. A nonempty representation is infeasible at budget zero.

**Theorem 1.** With a proper representation sorted by its left endpoints, an optimal value and a center set attaining it can be found in \(O(n)\) arithmetic and comparison operations and \(O(n)\) space for \(n\) intervals. An unordered proper representation can be sorted first in \(O(n\log(n+1))\) time.

**Theorem 2.** For all budgets through \(b\), including feasibility, the prefix frontier of optimal values has an \(O(n\min(b,n)+n)\)-time algorithm after the same ordering. Value computation uses \(O(n)\) working space, plus space for the frontier. Storing \(O(n\min(b,n)+n)\) predecessor records permits witness recovery for any feasible budget. The frontier can be returned through \(\min(b,n)\) with the remaining budgets represented by one constant value. Expanding this constant tail explicitly adds time proportional to the number of entries written.

The pinned interval-graph result [1] uses ordered center chains, triple rewards, and total monotonicity to compute the unweighted result in quadratic time. For proper intervals, the ordered neighborhood boundaries let us collapse the triple rewards to two values per center. The algorithm uses the interval representation directly, without constructing the graph's potentially quadratic edge list.

## 2. Neighborhood geometry and local reward

Group identical intervals. They have the same closed neighborhood. Removing all but one center selected in such a group preserves domination, cannot reduce the reward for vertices dominated exactly once, and cannot raise the cost. Replacing the remaining center by the cheapest member is equally feasible. Thus each group has its sum of rewards and its minimum center cost. This reduction preserves the optimum with an at-most cardinality constraint, since it does not increase center count. Store one cheapest original member for reconstruction.

Use \(n\) for the number of remaining groups for the rest of the proof. In left-endpoint order the right endpoints also increase strictly. Indeed, if either coordinate tied or the right endpoints reversed, one of two distinct intervals would contain the other. Each closed neighborhood is a contiguous index interval
\[
N[i]=[\ell(i),r(i)]\cap\mathbb Z.
\]
The functions \(\ell(i),r(i)\) are nondecreasing. They are the first index with right endpoint at least \(L_i\) and last index with left endpoint at most \(R_i\), respectively, and are computed by two-pointer scans. Inequalities are inclusive because intervals are closed.

An increasing list of selected indices \(i_1<\cdots<i_h\) dominates the graph precisely when
\[
\ell(i_1)=1,\quad r(i_h)=n,\quad
r(i_j)\ge \ell(i_{j+1})-1\ \ (1\le j<h).
\tag{2}
\]
In fact the ends and successive neighborhoods cover every index under these conditions. If a gap exists in (2), monotonicity of both boundaries implies no earlier or later selected interval can fill it. Use sentinels \(0,n+1\) with \(r(0)=0\), \(\ell(n+1)=n+1\), and cost zero, to express the two ends by the same inequalities.

Consider three consecutive centers \(i,j,k\) in a feasible chain, allowing the outer indices to be sentinels. The intervals uniquely dominated by \(j\) have precisely the indices
\[
r(i)+1,\ldots,\ell(k)-1,
\tag{3}
\]
with an empty range contributing zero. By (2) any index in the range is in \(N[j]\), outside all previous neighborhoods, and outside all later ones. Conversely, an index in \(N[j]\) at most \(r(i)\) also lies in \(N[i]\) when \(i\) is real, since \(\ell(i)\le\ell(j)\). An index in \(N[j]\) at least \(\ell(k)\) analogously lies in \(N[k]\) when \(k\) is real. At either sentinel there are no indices beyond that end. This proves (3).

With prefix weights \(P(v)=\sum_{u\le v}w_u\), \(P(0)=0\), the reward in (3) is
\[
\max\{0,P(\ell(k)-1)-P(r(i))\}.
\tag{4}
\]
Here nonnegative weights imply that an empty range has a nonpositive raw difference. Formula (4) applies even when several consecutive neighborhoods overlap heavily.

## 3. Two-state compression and linear algorithm

Define \(F(i,j)\) as the largest partial-chain value with last two entries \(i,j\), whose started portion satisfies all passed gap constraints. Its costs through \(j\) have been subtracted, and the unique rewards through \(i\) settled, leaving \(j\)'s reward pending. The left-sentinel state \(F(0,j)\) equals \(-c_j\) when \(\ell(j)=1\). Impossible states have value \(-\infty\). For clarity these two-index values define the recurrence; they need not be stored.

Write
\[
A_j=\max_i F(i,j),\qquad B_j=\max_i\{F(i,j)-P(r(i))\},
\tag{5}
\]
including the legal left-sentinel state. On appending \(k\) to \(j\), (4) and interchanging two maxima give
\[
F(j,k)=-c_k+\max\{A_j,\ P(\ell(k)-1)+B_j\},
\quad \text{if } r(j)\ge\ell(k)-1 .
\tag{6}
\]
A state with \(k=n+1\) finishes the chain. Every reward appears exactly when its following center is appended.

Let \(\mathcal I_j=\{i:1\le i<j,\ r(i)\ge\ell(j)-1\}\), \(p_j=P(\ell(j)-1)\), and \(s_j=0\) if \(\ell(j)=1\) and \(-\infty\) otherwise. Combining (5) and (6) gives
\[
\begin{split}
A_j&=-c_j+\max\{s_j,\ \max_{i\in\mathcal I_j} A_i,\
                              p_j+\max_{i\in\mathcal I_j} B_i\},\\
B_j&=-c_j+\max\{s_j,\ \max_{i\in\mathcal I_j}(A_i-P(r(i))),\
                              p_j+\max_{i\in\mathcal I_j}(B_i-P(r(i)))\}.
\end{split}
\tag{7}
\]
The sentinel has \(P(r(0))=0\). Both sets of maxima are evaluated in increasing \(j\). The answer is
\[
\max_{j:r(j)=n}\max\{A_j,\ P(n)+B_j\}.
\tag{8}
\]

The window \(\mathcal I_j\) is a contiguous suffix of \(1,\ldots,j-1\) since \(r(i)\) is nondecreasing. Its left boundary never moves left, since \(\ell(j)\) is nondecreasing. Maintain four deques for the sequences \(A_i\), \(B_i\), \(A_i-P(r(i))\), and \(B_i-P(r(i))\). To advance to \(j\), append the available values for \(i=j-1\), removing from each tail entries with no larger value. From the front, evict entries with \(r(i)<\ell(j)-1\). The retained front is a maximizing index in that window. Each value enters and leaves at most once, giving linear total work. The deques store predecessor indices as well as values.

For reconstruction, store for each finite \(A_j\) and \(B_j\) the chosen branch in (7) and its maximizing predecessor, or the left sentinel. The indices strictly decrease in backward traversal, and (8) supplies the final state. Each chosen branch represents a feasible partial chain. In (6), if its actual reward (4) were larger than the value represented by the selected branch, it would contradict maximality in (6). Thus branch reconstruction yields a chain attaining the reported optimum. Use the stored cheapest representative to return original vertices. This proves Theorem 1.

## 4. Budget frontier

For each number \(h\) of selected groups retain separate arrays \(A_j^{(h)},B_j^{(h)}\), with the same interpretation as (5) and a prescribed \(h\). The first layer is only the left-sentinel state, with both summaries \(-c_j\) for \(\ell(j)=1\). At layer \(h>1\) remove the sentinel branch in (7) and use arrays from \(h-1\) for all predecessors. The same maxima deques evaluate each layer in linear time. The terminal expression (8) in each layer gives the best value with exactly \(h\) selected groups. Its running maximum over \(h\le b\) gives the promised frontier on the original representation, including infeasibility when no layer reaches the right sentinel.

One can keep two successive layers for values, and preserve a predecessor and predecessor branch at each finite state if witnesses are needed. The predecessor layer is fixed by \(h-1\). The twin reduction is used for the at-most constraint on original centers. These layer values are not asserted to describe exact counts of original centers when identical intervals occur. This proves Theorem 2.

## 5. Relation to the fixed source

The interval chain formulation and local settlement of unique rewards are already used in [1]. Monotone deques are standard. The new step uses the proper-interval boundary order to turn the three-center rectangle into an interval of indices and then collapse the state search. This yields linear weighted optimization and per-budget layer time with witnesses within the stated representation class.

**Reference**

1. *Full-cover unique domination on chordal graphs and subclasses*. earlier research manuscript, fixed commit c9a8cf037cd4, Section 3. The source manifest gives the exact manuscript path and blob.
