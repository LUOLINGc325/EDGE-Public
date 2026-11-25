---
title: "The complexity of exact terminal induction with slack composite nulls"
lang: en
geometry: margin=1in
fontsize: 11pt
---

## Abstract

On a finite observation tree, a bounded composite anytime-valid test can be dominated by the pointwise minimum of null-specific martingales while preserving its terminal decision if some null law attains the terminal size bound. We characterize this domination problem when every terminal size constraint is slack. A leaf must be assigned to a null law whose component terminal test stays exactly at the prescribed value. Feasibility of that assignment is determined by a family of subtree capacity inequalities obtained from the Snell envelope. This gives an exact construction and an integer-load dynamic program. The existence problem is strongly NP-complete even at fixed level \(1/4\), on a depth-two tree with a zero terminal decision and just one nontrivial interim target. It is NP-hard already with two distinct null laws. The same instances give hardness for exact induction without raising any interim value.

## 1. Model and main results

Let a finite rooted tree have root \(o\) and leaves at a common finite time. A finite nonempty family \(\mathcal P\) of null laws assigns positive probability to every leaf. Write \(P(v)\) for the probability of reaching node \(v\), and \(P(w\mid v)\) for the induced child probabilities. Let \(0<\alpha<1\). A prescribed bounded extension \(g\) takes values in \([0,1]\), with \(g(o)=\alpha\) and \(g(\ell)=f(\ell)\) at the leaves. It is anytime valid when \(\mathbb E_P g(\tau)\le\alpha\) for every null \(P\) and every stopping time on the tree.

A family of component tests consists of \(F_P(\ell)\in[0,1]\) with \(\mathbb E_P F_P\le\alpha\). Its induced extension is
\[
\widetilde g(v)=\min_{P\in\mathcal P}\mathbb E_P[F_P\mid v].
\]
We ask when \(\widetilde g\ge g\) at all nodes and \(\widetilde g(\ell)=f(\ell)\) at every leaf. Because \(g(o)=\alpha\), dominance at the root forces \(\mathbb E_P F_P=\alpha\) for every null. This is the exact-root convention used below. It permits different component terminal tests but preserves the pointwise terminal minimum.

For each null law define its Snell envelope by
\[
S^P(\ell)=f(\ell),\qquad
S^P(v)=\max\left\{g(v),\sum_{w\in\operatorname{ch}(v)}
P(w\mid v)S^P(w)\right\}
\]
at nonleaves. On a finite tree, the recursion gives the best conditional stopping payoff. Thus \(g\) is anytime valid exactly when \(S^P(o)=\alpha\) for every \(P\). The pinned result [1] gives an ordinary bounded martingale-domination linear program and proves that if some null has \(\mathbb E_P f=\alpha\), then every feasible \(g\) has an induced majorant preserving \(f\).

**Theorem 1 (exact terminal-induction criterion).** An anytime-valid \(g\) has an induced majorant with the prescribed terminal minimum if and only if the leaves can be partitioned into sets \(Z_P\), one per null law, such that for every \(P\) and every node \(v\),
\[
\sum_{\substack{\ell\in Z_P\\ \ell\succcurlyeq v}}
P(\ell)(1-f(\ell))\le P(v)(1-S^P(v)). \tag{1}
\]
Here \(\ell\succcurlyeq v\) means that \(\ell\) is in the subtree rooted at \(v\), including \(v\) if it is a leaf. From any valid partition one can construct the inducing component tests by a top-down recursion.

**Theorem 2 (complexity).** On rational inputs, deciding existence in Theorem 1 is strongly NP-complete. This remains true at \(\alpha=1/4\) when \(f=0\), the tree has depth two and two first-stage histories, just one proper interim node has nonzero target, and all null laws are distinct with full support and slack terminal size. With exactly two nulls the problem is NP-hard under the same restrictions. Both hardness conclusions also apply to deciding whether \(g\) itself has an exact induction.

## 2. Proof of the partition criterion

Suppose first that an inducing family is given. The terminal minimum condition implies \(F_P(\ell)\ge f(\ell)\) for every \(P,\ell\). At each leaf choose one null \(P\) where equality holds and assign that leaf to \(Z_P\). Put
\[
U_P(\ell)=
\begin{cases}
f(\ell),&\ell\in Z_P,\\
1,&\ell\notin Z_P.
\end{cases}
\]
Then \(F_P\le U_P\). Let \(M^P(v)=\mathbb E_P[F_P\mid v]\) and \(T^P(v)=\mathbb E_P[U_P\mid v]\). The martingale \(M^P\) dominates \(g\), because its pointwise minimum across the nulls does. By backward induction it dominates \(S^P\). At a leaf this follows from \(F_P\ge f\), and at an internal node it follows from dominance of \(g(v)\) and of the conditional average of child Snell values. We also have \(M^P\le T^P\), so \(S^P(v)\le T^P(v)\) everywhere. Since
\[
T^P(v)=1-\frac{1}{P(v)}
 \sum_{\substack{\ell\in Z_P\\\ell\succcurlyeq v}}
 P(\ell)(1-f(\ell)),
\]
these inequalities give (1).

Conversely, suppose a leaf partition satisfies (1), and form the same caps \(U_P\) and upper martingales \(T^P\). For each \(P\) initialize \(M^P(o)=\alpha=S^P(o)\). By (1), this is at most \(T^P(o)\). Given \(M^P(v)\in[S^P(v),T^P(v)]\), we have
\[
\sum_{w\in\operatorname{ch}(v)}P(w\mid v)S^P(w)
\le M^P(v)\le
\sum_{w\in\operatorname{ch}(v)}P(w\mid v)T^P(w).
\]
On the left use the supermartingale property of the Snell envelope. On the right use harmonicity of \(T^P\). Therefore one common interpolation fraction between zero and one gives values \(M^P(w)\) in the respective child intervals with the required mean \(M^P(v)\). If the two weighted sums coincide, take all lower values. Iterating gives a bounded martingale for each \(P\).

Set \(F_P(\ell)=M^P(\ell)\). It has mean \(\alpha\), and \(f(\ell)\le F_P(\ell)\le U_P(\ell)\). For the designated \(P\) there is equality, giving the prescribed terminal minimum. The induced process dominates \(g\) because each \(M^P\) dominates its Snell envelope. It is anytime valid under each true null \(P\), because it is bounded above by that null's martingale. This proves Theorem 1.

The capacities in (1) form a laminar family within each law, meaning that the constrained sets of leaves are subtrees and any two such sets are disjoint or nested. Induction requires integral assignment of each leaf to a single witnessing null. A leaf with \(f(\ell)=1\) has zero load and can be assigned anywhere. When a null law binds the terminal size, the source's sufficient condition is recovered by assigning every leaf to that law. In fact under a binding law any interim stopping improvement over the conditional terminal test would violate validity, so its Snell envelope equals the terminal conditional mean everywhere.

## 3. Exact-value induction and a finite algorithm

If one insists on \(\widetilde g=g\) at every node, there is a similar exact certificate. Assign each node \(v\) to one law that must attain its value. For a fixed assignment let the upper cap \(C_P(v)\) equal \(g(v)\) at nodes assigned to \(P\), and one elsewhere. The lower bound at every node is \(g(v)\). For each \(P\), work upward with the interval of attainable martingale values at every node, assuming all descendants obey their caps. At leaves the interval is \([g(\ell),C_P(\ell)]\). At a nonleaf \(v\), if all child intervals \([L_P(w),U_P(w)]\) are nonempty, the interval is
\[
\left[
 \max\left\{g(v),\sum_w P(w\mid v)L_P(w)\right\},
 \min\left\{C_P(v),\sum_w P(w\mid v)U_P(w)\right\}
\right].
\]
If any child interval is empty then the subtree is infeasible, since all child probabilities are positive. Sums of independent interval choices fill the whole interval between the endpoint averages. Thus a proposed node assignment works exactly when no interval is empty and \(\alpha\) belongs to every root interval. A top-down interpolation reconstructs the component tests. This supplies an NP certificate for exact-value induction as well as a direct decision procedure after an assignment is fixed.

For Theorem 1 the witness assignment uses only leaves. With \(J=|\mathcal P|\), suppose a positive integer scale \(D_P\) is given for each law so that \(D_P P(\ell)(1-f(\ell))\) is integer at every leaf. Multiply (1) by \(D_P\) and floor its right-hand side. In each subtree, store vectors of total assigned loads, one coordinate per law. At a leaf the choices put that leaf's load into just one law coordinate. At an internal node combine child vectors by adding them coordinatewise and keep the sums that fit the local capacity bounds. Inductively the stored vectors are exactly those attainable by assignments obeying all descendant constraints. The root detects feasibility and recorded predecessor states recover a partition.

The total scaled load for law \(P\) is at most \(D_P\), so at most \(D=\prod_P(D_P+1)\) vectors occur. Combining children in sequence takes \(O(JD^2)\) elementary integer operations per merge. This yields a pseudo-polynomial algorithm for fixed \(J\) in these integer scales, in addition to the rational preprocessing. This bound does not treat clearing arbitrary rational denominators as a polynomial-size operation.

For complexity in binary encoding, membership in NP follows directly from the leaf assignment and rational verification of (1). One can compute the unconditional Snell quantities \(P(v)S^P(v)\) using a maximum and sum recursion without division by conditional probabilities. Their bit lengths are polynomial in the input length. For example, the possible summands are terms \(P(v)g(v)\) for a collection of disjoint stopping subtrees. Their denominators divide a common product of the input denominators of the leaf probabilities and target values. The same argument works for the exact-value interval check after multiplying by the unconditional node probabilities.

## 4. Strong hardness with one interim target

We reduce from 3-PARTITION. Its input is \(3J\) positive integers \(a_1,\ldots,a_{3J}\), target integer \(B\), and \(\sum_i a_i=JB\), with \(B/4<a_i<B/2\). The question is whether the integers split into \(J\) groups each of sum \(B\). We use the standard strongly NP-complete version with \(J\ge2\).

The root has two children \(v,w\). The node \(v\) has \(3J\) leaves indexed by the items, and \(w\) has two leaves. Set the terminal target \(f=0\) everywhere, \(\alpha=1/4\), and
\[
g(v)=1-1/J,\qquad g(w)=0,\qquad g(o)=\alpha .
\]
Create \(J\) nulls \(P_j\). All give the same probability \(p_v=J/[4(J-1)]\) to \(v\), and all have conditional leaf probabilities
\(P_j(\ell_i\mid v)=a_i/(JB)\).
In the branch \(w\), give its first leaf probability \((1-p_v)j/(J+1)\) and its second the remaining \(w\)-mass. All laws are distinct and have full support. Every terminal size equals zero and is strictly slack. The extension \(g\) is nevertheless ordinary anytime valid, since continuing from the root gives maximal expected payoff \(p_v(1-1/J)=\alpha\).

For every \(j\), the condition (1) at \(v\) is that the total conditional mass of leaves assigned to \(P_j\) within \(v\) be at most \(1/J\). All these leaf probabilities agree across the laws. Because every leaf is assigned once, the \(J\) totals add to one. Thus every total must equal \(1/J\), exactly a partition of the original integers into groups of sum \(B\). The strict input bounds on \(a_i\) ensure that each group has three items.

Conversely, given a 3-partition, under law \(P_j\) put \(F_{P_j}=0\) on its designated group within \(v\) and one on all other leaves within \(v\). Put every \(F_{P_j}=0\) on the two leaves under \(w\). The conditional mean at \(v\) is \(1-1/J\) for each law, and the root mean is \(\alpha\). Every leaf has a zero component and the minimum reproduces \(g\) exactly. Thus the reduction applies to both domination and exact-value induction. The useful leaf probabilities are \(a_i/[4(J-1)B]\). The input probabilities and target values have common denominator dividing \(4J(J-1)(J+1)B\), polynomially bounded on the strongly restricted 3-PARTITION inputs. The reduction and the NP certificates give strong NP-completeness.

For exactly two laws use the same construction with a PARTITION input, conditional leaf masses \(a_i/\sum_\ell a_\ell\) under \(v\), \(g(v)=1/2\) and \(P_j(v)=1/2\). The two \(w\)-splits make the laws distinct. Condition (1) at \(v\) requires two groups of mass exactly \(1/2\), which is precisely PARTITION. The same zero-one tests give the exact induction on yes inputs. This proves the two-law NP-hardness.

The reduction does not rely on forcing the root decision to be induced. Even if the root is specified separately, a component with \(\mathbb E_P F_P\le\alpha\) and conditional mean at least \(g(v)\) must use its entire budget on \(v\), since \(P(v)g(v)=\alpha\) and all payoffs are nonnegative. The group condition is therefore unchanged.

## 5. Scope and source comparison

The pinned binding-null theorem [1] converts the convex martingale-domination problem into exact terminal induction when a terminal size constraint is tight. With all margins slack, ordinary validity still has the same linear and stopping-time characterizations. The obstruction is the simultaneous requirement that the component minimum attain the fixed terminal payoff at every leaf. The partition criterion identifies that obstruction exactly. The hardness construction shows that it persists with a single meaningful interim constraint and with the simplest terminal decision. These results concern finite full-support null families and finite observation trees.

## Reference

1. *Optimal induction of bounded composite sequential tests on finite trees*, pinned earlier research manuscript manuscript at  (archived version), especially Theorems 1–2 and Sections 1–2.
