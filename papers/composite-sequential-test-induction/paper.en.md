# Optimal induction of bounded composite sequential tests on finite trees

## Abstract

Koning and van Meer induce a composite sequential test from a family of null-specific tests and ask how to select that family under a prescribed optimal terminal test. For finite observation trees and a finite full-support null family, we give an exact linear program for every nonnegative linear objective on preterminal test values. If a null law attains the terminal size bound, the program constructs bounded null-specific terminal tests whose conditional-mean minimum preserves the terminal target and attains the optimum. We also identify the exact achievable value at each node. A rational example shows that these separate maxima can be incompatible and quantifies the gain over inducing from the same terminal test under every null.

## 1. Setup and statements

Let a finite rooted observation tree have all leaves at a fixed horizon $N\ge1$. Denote the root by $o$, leaves by $\ell$, and immediate children of a node $v$ by $\operatorname{ch}(v)$. A probability law on leaves induces a history law $P(v)$ and conditional child probabilities $P(w\mid v)$. Let $H=\{P_1,\ldots,P_J\}$ be a finite nonempty family with every leaf positive under every member. Fix $0<\alpha<1$ and a terminal test $f$ with $0\le f(\ell)\le1$ and $E_P f\le\alpha$ for all $P\in H$.

An extension is a node function $g$ with $0\le g(v)\le1$, $g(o)=\alpha$, and $g(\ell)=f(\ell)$. It is anytime valid if $E_P[g(\tau)]\le\alpha$ for all $P\in H$ and all history stopping times $\tau\le N$. Here $g(\tau)$ is the value at the selected node. This is the bounded test convention of Koning and van Meer, equation (2). An induced extension takes $g(v)=\min_{P\in H} E_P[f_P\mid v]$ for a collection of $[0,1]$-valued terminal tests $f_P$.

**Theorem 1.** The anytime-valid extensions are exactly the projection of the following finite linear constraints on node functions $M^P$:
$$
\begin{aligned}
&0\le M^P(v)\le1,\qquad M^P(o)=\alpha,\qquad M^P(v)\ge g(v)
&&\text{for every }P,v,\\
&M^P(v)=\sum_{w\in\operatorname{ch}(v)}P(w\mid v)M^P(w)
&&\text{for every }P\text{ and nonleaf }v.
\end{aligned}\tag{1}
$$
When at least one $P_*\in H$ satisfies $E_{P_*}f=\alpha$, every feasible extension is dominated nodewise by a feasible induced extension with the same $f$. Thus any nonnegative linear objective on preterminal nodes can be optimized by (1) and realized by null-specific terminal tests without loss. Every pointwise maximal extension with that terminal test is induced in this way.

**Theorem 2.** Write $m_P(v)=E_P[f\mid v]$ and $b_P=\alpha-E_P f$. At every nonroot proper internal node $v$, the maximum achievable $g(v)$ is
$$
u(v)=\min\left\{1,\ \min_{P\in H}
 \left[m_P(v)+\frac{b_P}{P(v)}\right]\right\}. \tag{2}
$$
A pointwise greatest extension exists if and only if the vector of node caps $u(v)$, together with the fixed root and leaf values, satisfies (1).

For an alternative with full support, every maximum-power terminal test at level $\alpha$ has a binding null law. If all null constraints were slack, some leaf value below one could be increased to improve power. There is such a leaf since the all-one test is infeasible. The binding hypothesis of Theorem 1 therefore holds in the maximum-power setup of Koning and van Meer's Remark 6.

## 2. Bounded martingale construction and optimization

For each $P$, recursively set
$$S^P(\ell)=f(\ell),\qquad
 S^P(v)=\max\left\{g(v),\sum_{w\in\operatorname{ch}(v)}P(w\mid v)S^P(w)\right\}.$$
On a finite tree this is the largest conditional expected payoff of a stopping time within the subtree: at each node one can stop immediately or take the conditional average of the child optima, and those optima can be attained by a recursively chosen stopping rule. Thus anytime validity is equivalent to $S^P(o)\le\alpha$ for every $P$. The envelope takes values in $[0,1]$.

Given a feasible extension, start $M^P(o)=\alpha$. Whenever $M^P(v)\ge S^P(v)$ has been assigned, put
$$
L=\sum_{w\in\operatorname{ch}(v)}P(w\mid v)S^P(w).
$$
Assign $M^P(w)=S^P(w)+\theta(1-S^P(w))$ to the children with $\theta=(M^P(v)-L)/(1-L)$ if $L<1$. The construction has $\theta\in[0,1]$ since $L\le S^P(v)\le M^P(v)\le1$. If $L=1$ take all child values one; their required average is one. Induction yields (1). Conversely, any (1) dominates $g$ under each $P$ by a bounded martingale starting at $\alpha$, so bounded optional stopping verifies anytime validity.

Define $f_P(\ell)=M^P(\ell)$. Under the binding law $P_*$, $f_{P_*}\ge f$ and
$$E_{P_*}f_{P_*}=\alpha=E_{P_*}f.$$
Full support gives $f_{P_*}=f$ on every leaf. Therefore $\min_P f_P=f$. At every node, $\min_P M^P(v)$ dominates $g(v)$, and bounded martingale domination still proves validity. As $M^P(v)=E_P[f_P\mid v]$, this is the claimed induced extension. The finite feasible polytope is nonempty, since the common-terminal induction from $f$ is feasible with root raised to $\alpha$ as a separate decision at time zero. It is compact, so every stated linear objective has an optimum. Replacing an optimizer by its induced majorant preserves optimality for nonnegative weights. At a pointwise maximal extension that replacement must be identical.

Equivalently one may eliminate internal martingale variables. Use one leaf vector $f_P\in[f,1]$ for each $P$, impose $E_P f_P=\alpha$, and impose
$$\sum_{\ell\succ v} P(\ell) f_P(\ell)\ge P(v)g(v)$$
at each nonleaf node, where $\ell\succ v$ means the leaf descends from $v$. These are rational coefficients for rational leaf laws. This implements the selection of the component tests with a number of constraints proportional to the number of nulls times the number of nodes, avoiding enumeration of stopping times.

To prove Theorem 2, consider stopping at $v$ if reached and at a leaf otherwise. Its expected payoff under $P$ is $E_Pf+P(v)[g(v)-m_P(v)]$. This gives the upper bound in (2). To attain it at one specified node, set all other proper internal payoffs zero. For every $P$, the optimal stopping value after deciding to continue at the root is $E_Pf+P(v)(u(v)-m_P(v))_+$, which is at most $\alpha$. Indeed, the only positive preterminal payoff is at $v$, and at $v$ the choice is between its payoff and the conditional terminal expectation. The root decision itself also obeys the bound. So each cap is attainable separately. A greatest extension must attain them all, and if their vector is feasible it dominates every extension. This proves the criterion.

## 3. Exact examples

Consider a tree with two time-one histories $A,B$, each branching to two leaves. In leaf order $A_1,A_0,B_1,B_0$, use
$$
\begin{array}{c|rrrr}
 & A_1&A_0&B_1&B_0\\ \hline
 P_1&3/16&1/16&1/16&11/16\\
 P_2&1/20&9/20&1/100&49/100\\
 Q&3/8&1/24&1/8&11/24
\end{array}
\qquad \alpha=1/4,\qquad f=(1,0,1,0).
$$
The alternative-to-$P_1$ likelihood ratios are $2$ on the rejecting leaves and $2/3$ elsewhere. Thus $f$ is uniquely maximum power for $P_1$, and since it is feasible under $P_2$ it is uniquely maximum power for the composite null. The $P_1$ conditional terminal means are $(3/4,1/12)$ and the $P_2$ means are $(1/10,1/50)$. The common-terminal induction gives $g(A)=1/10$ and $g(B)=1/50$, with time-one expectation $4/75$ under $Q$.

The two node caps are $12/25$ and $1/12$. Taking both would give time-one expectation $169/600>1/4$ under $P_2$, so no greatest extension exists. For the time-one $Q$ objective, validity implies $g(A)+g(B)\le1/2$ by stopping at time one under $P_2$, and $g(B)\le1/12$ by (2). Hence
$$
E_Q g_1=\frac5{12}g(A)+\frac7{12}g(B)
\le \frac5{24}+\frac1{72}=\frac29.
$$
This is attained by $g(A)=5/12$, $g(B)=1/12$. An explicit inducing family is $f_{P_1}=f$ and $f_{P_2}=(1,19/54,1,19/294)$. Its conditional means under $P_2$ are exactly $(5/12,1/12)$, with root mean $1/4$.

A distinct three-leaf example illustrates the failure of taking the infimum of individually most powerful tests. Take
$$P_1=(2/5,1/10,1/2),\quad
 P_2=(1/10,2/5,1/2),\quad Q=(3/10,3/10,2/5),\quad \alpha=1/10.$$
Under $P_1$ the unique maximum ratio occurs at leaf two and its $P_1$ mass already equals $\alpha$. Thus the unique most powerful test is $(0,1,0)$. Under $P_2$ it is $(1,0,0)$. Their minimum is zero. For a composite-valid test $(a,b,c)$ the mean of the two null inequalities gives $(a+b)/4+c/2\le1/10$. Its power is at most $3/25-c/5\le3/25$. The test $(1/5,1/5,0)$ attains this bound and is feasible. The alternative lies outside the convex hull of the two nulls, since both nulls put mass $1/2$ on the third leaf. This is a case with nontrivial composite power and a vacuous minimum of the simple optima.

## References

- Nick W. Koning and Sam van Meer. *Anytime validity is free: inducing sequential tests*. JRSS B, 88(4), 1366–1384, 2026. §2.3, Theorem 2 and Remark 6. <https://doi.org/10.1093/jrsssb/qkag050>
- Aaditya Ramdas, Johannes Ruf, Martin Larsson and Wouter Koolen. *Admissible anytime-valid sequential inference must rely on nonnegative martingales*. arXiv:2009.03167. General anytime-valid process domination and admissibility. The present construction preserves the bounded test scale and the prescribed terminal decision while optimizing the component family. <https://arxiv.org/abs/2009.03167>
