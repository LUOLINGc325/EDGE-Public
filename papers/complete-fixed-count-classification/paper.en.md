---
title: "Exact cumulative envy is already hard for two agents"
subtitle: "A complete fixed-agent classification and an exact partition identity"
lang: en
geometry: margin=1in
fontsize: 11pt
---

## Abstract

Consider irrevocably allocating a known sequence of goods to agents who agree on each good's value. The objective sums the difference between the largest and smallest loads after every arrival. We prove weak NP-completeness for every fixed number of agents at least two, even when all values are positive binary-encoded integers. This resolves the two- and three-agent cases left by the earlier classification. The proof rotates the identities of the heaviest and lightest agents so that every intermediate contribution of the partition goods cancels. It also gives an exact optimal-value identity. For a suitable sequence built from any list of partition goods, the excess over a known baseline is the minimum of a two-gap function of the final sorted loads. The identity holds for arbitrary numbers of agents and can be recovered after replacing every zero-valued good by a positive one.

## 1. Prescribed-order cumulative envy

Fix a number of agents \(n\). A list of goods has common values \(v_1,\ldots,v_L\) in the prescribed order. Each good is assigned to exactly one agent when it arrives. The optimizer knows the entire list. An allocation induces loads \(X_i(t)\) after round \(t\). For a vector \(x\), write \(\operatorname{rng}(x)=\max_i x_i-\min_i x_i\). The objective is
\[
C(v)=\min_{\text{allocations}}\sum_{t=1}^L\operatorname{rng}(X(t)).
\]
This range is the maximum pairwise envy under identical additive valuations. The decision problem asks if \(C(v)\) is at most a given binary-encoded integer.

**Theorem 1.** For each fixed \(n\ge2\), the prescribed-order decision problem is weakly NP-complete with strictly positive binary-encoded integer values. For one agent it is trivial.

Goldberg, Robinson and Teh posed the fixed-agent question in Section 4 of their paper. They established strong NP-hardness when the number of agents can grow and gave a fixed-agent FPTAS. Their two-agent hardness when the optimizer chooses the arrival order concerns a different feasible set. An archived earlier case established NP-completeness for every fixed \(n\ge4\) and explicitly left \(n=2,3\) unresolved. Theorem 1 supplies both missing cases. The new proof uses one construction for every \(n\ge2\).

**Theorem 2.** Take \(n\ge2\) and positive integers \(b_1,\ldots,b_m\) with \(m\ge1\), and write \(W=\sum_i b_i\). Let \(B\) be an integer with \(B>nW\). Construct the following sequence:

1. The opening goods are \(B,2B,\ldots,(n-1)B\).
2. For each \(i=1,\ldots,m\), give the good \(b_i\) and then \(n-1\) consecutive goods of value \(nB\).
3. The closing goods are \((n-1)B,(n-2)B,\ldots,B\), then \(n-2\) zero-valued goods.

Set \(K=[(n-1)^2+mn(n-1)]B\). For any assignment of the \(b_i\) to \(n\) bins, let \(x_1\le\cdots\le x_n\) be its sorted loads, including empty bins. The exact optimum of the constructed sequence is
\[
C(v)=K+\min_{\text{bin assignments}}[(n-2)(x_n-x_1)+(x_2-x_1)
]. \qquad\text{(1)}
\]
For \(n=2\) this is the ordinary two-bin discrepancy. For every \(n\ge2\), the excess is zero precisely when the low goods admit an equal-load partition.

For example, with two agents the sequence starts with \(B\), alternates each low good with a \(2B\), and ends with \(B\). On a canonical allocation, each \(2B\) good switches which agent is heavier. The two evaluations associated with each low good sum to \(2B\) regardless of which agent received it. Only the closing range depends on the final partition. In higher dimensions the proof uses the same cancellation, with a full cycle of leaders and trailers in each block. A telescoping lower bound holds for every possible assignment of the heavy goods.

## 2. A lower bound that detects all altered opening and middle assignments

For a fixed recipient sequence, split every load into \(Bh_j+d_j\). The nonnegative integer \(h_j\) counts the contribution of the opening, middle and closing goods that are multiples of \(B\). The low load \(d_j\) counts the \(b_i\) already assigned to that agent. Since \(0\le d_j\le W\), the range differs from \(B\operatorname{rng}(h)\) by at most \(W\) at every round. This follows because adding numbers in \([0,W]\) moves each of the maximum and minimum by a number in the same interval. Before the first low good, this error is zero.

At opening round \(a\), \(1\le a\le n-1\), at least one agent is still empty and the recipient of \(aB\) has \(h_j\ge a\). Consequently the sum of opening high ranges is at least \(n(n-1)/2\). A repeated recipient makes this bound strict by at least one unit, at the first repeated recipient's round. When all opening recipients are distinct, the high levels at the end of the opening rounds are exactly \(0,1,\ldots,n-1\).

Consider a middle block, starting at the prefix immediately after its low good. Let \(Z(t)\) be its true load vector after \(t\) of the \(n-1\) heavy moves, for \(0\le t<n\). Let \(a_t\) receive the \(t\)-th heavy move, and take \(a_0=a_n\) to be an agent who receives none of these moves. Such an agent exists because there are fewer moves than agents. At each prefix, its range dominates the difference between any ordered pair of its coordinates. Therefore
\[
\begin{aligned}
\sum_{t=0}^{n-1}\operatorname{rng}(Z(t))
&\ge \sum_{t=0}^{n-1}[Z_{a_t}(t)-Z_{a_{t+1}}(t)]\\
&=\sum_{t=1}^{n-1}[Z_{a_t}(t)-Z_{a_t}(t-1)]\\
&=n(n-1)B. \qquad\text{(2)}
\end{aligned}
\]
The boundary terms cancel because \(a_0=a_n\) is untouched. This lower bound uses the true loads and allows repeated heavy recipients and arbitrary low assignments.

Let \(K_{\mathrm{pre}}=[n(n-1)/2+mn(n-1)]B\). By (2), the opening and middle cost is at least \(K_{\mathrm{pre}}\). If the opening has a repeated recipient, the cost is at least \(K_{\mathrm{pre}}+B\). If it has distinct recipients, the high residues stay distinct modulo \(n\) throughout the middle, so every high range is at least \(n-1\). Starting from consecutive high levels, a heavy good can preserve consecutive levels by going to the unique smallest level. If a heavy good goes to any other agent for the first time, the old minimum remains and the new high range is at least \(n+1\) at that prefix. In the affected block the total high-only cost is at least \([n(n-1)+2]B\). The true block cost can be at most \(nW\) less, while all other blocks satisfy (2). In this case the opening and middle cost is at least \(K_{\mathrm{pre}}+2B-nW\).

Call the opening and middle assignments canonical when the opening recipients are distinct and every heavy good goes to the smallest high level. Both types of noncanonical paths thus have excess above the baseline of at least
\[
\min\{B,2B-nW\}. \qquad\text{(3)}
\]

In a canonical middle block, the low loads \(d_j\) are fixed at its \(n\) evaluated prefixes. The highest and lowest high levels are distinct and unique, so for \(B>W\) they also determine the maximum and minimum of the true loads. The labels of the highest and of the lowest agent each visit every agent exactly once in the block. Hence the sum of the \(d_j\) contributions is zero. The true canonical opening and middle cost is exactly \(K_{\mathrm{pre}}\), for every assignment of low goods.

## 3. A universal closing bound and the exact optimum

Let \(R\) be the true range after the last closing good \(B\) and before the zero tail. At any earlier closing prefix, suppose \(\ell\) positive closing goods remain, of values \(\ell B,\ldots,B\). Here \(1\le\ell\le n-2\). The extra loads \(y\) from these remaining goods have range at least \(\ell B\): at least one agent receives none, and one receives the largest remaining good. If \(x\) is the current load vector, then \(\operatorname{rng}(y)\le\operatorname{rng}(x+y)+\operatorname{rng}(x)\). Thus this prefix costs at least \(\ell B-R\). The last closing good and the \(n-2\) zeros contribute \((n-1)R\). Adding proves, for every allocation,
\[
\text{closing and zero-tail cost}\ \ge K_{\mathrm{end}}+R,
\qquad K_{\mathrm{end}}=\frac{(n-2)(n-1)}2 B. \qquad\text{(4)}
\]
The full baseline \(K_{\mathrm{pre}}+K_{\mathrm{end}}\) equals \(K\) in Theorem 2.

For canonical opening and middle assignments, the high levels immediately before closing are \(z,z+1,\ldots,z+n-1\) for some integer \(z\). Sending each closing good to the current lowest high level balances these high levels. Conversely any closing allocation that balances the high levels must end at \(z+n-1\): this is dictated by their sum. The first closing good of size \((n-1)B\) must go to level \(z\) or it would overshoot that final high level. After that, the next largest good must go to the agent with the next largest deficit. By induction this forces the same closing sequence.

Index the low loads \(d_0,\ldots,d_{n-1}\) by increasing high level just before closing. When high levels are balanced by the closing sequence, the largest high level after closing step \(t\), for \(1\le t\le n-2\), is attained by indices \(0,\ldots,t-1,n-1\), and the smallest high level is attained only by index \(t\). The true range is
\[
(n-1-t)B+M_{t-1}-d_t,\qquad
M_t=\max(d_0,d_{n-1},d_1,\ldots,d_t). \qquad\text{(5)}
\]
Let \(x_1\le\cdots\le x_n\) be the sorted low loads. At the end \(R=x_n-x_1\). Since \(M_{t-1}-d_t\ge M_{t-1}-M_t\), the sum of offsets in (5) is at least \(M_0-x_n\ge x_2-x_n\). The bound holds when \(n=2\) as well, with empty sum and \(M_0=x_2=x_n\). We can assign the two smallest low loads to indices \(0,n-1\) and the rest to \(1,\ldots,n-2\) in increasing order. Then every inequality is an equality. Any such permutation is feasible since the low goods are freely assigned and the canonical high path is independent of their assignments. The least closing and tail cost for those sorted low loads is therefore
\[
K_{\mathrm{end}}+(x_2-x_n)+(n-1)(x_n-x_1)
= K_{\mathrm{end}}+(n-2)(x_n-x_1)+(x_2-x_1). \qquad\text{(6)}
\]

This gives a feasible full allocation of cost at most \(K+(n-1)W\). For a noncanonical opening or middle path, (3) and (4) give a total cost of at least \(K+\min\{B,2B-nW\}\), strictly greater than that feasible cost. With a canonical opening and middle path, a closing assignment that leaves a positive high-level range has \(R\ge B-W\). Its total cost is at least \(K+B-W\), also greater than the feasible cost. Both exclusions use \(B>nW\). Thus every optimum has a canonical opening and middle path and balances the high levels when it closes. Minimizing (6) over the low assignments proves (1).

For the decision threshold \(K\) alone, any \(B>W\) suffices. The universal opening, block and closing bounds give total cost at least \(K+R\). If the cost is at most \(K\), the final loads agree. Since every low load lies in \([0,W]\) and every high contribution is a multiple of \(B\), the low loads then agree. Conversely, equally partitioned low goods achieve \(K\) with the canonical path.

## 4. Positive goods and the complexity classification

The zero tail has \(r=n-2\) terms. Put \(H=r(r+1)/2\) and \(Q=2H+1\). Multiply every earlier good by \(Q\) and replace each trailing zero by a good of value one. For any fixed recipient sequence its total cost changes relative to \(Q\) times the original cost by at most \(H\). Indeed, its earlier loads scale exactly, and at the \(j\)-th new unit good the load perturbations lie in \([0,j]\), changing the range by at most \(j\). If \(C_+\) is the new optimum, minimizing this pair of bounds gives \(|C_+-Q C(v)|\le H\) and
\[
C(v)=\left\lfloor\frac{C_++H}{Q}\right\rfloor. \qquad\text{(7)}
\]
This retains the exact information in (1). In particular \(C(v)\le K\) is equivalent to \(C_+\le QK+H\). For \(n=2\) no conversion is needed. This perturbation is credited to the archived fixed-agent precursor.

Reduce from the conventional positive-integer PARTITION problem. Given values \(a_1,\ldots,a_s\) of sum \(S\), take the low list \(2a_1,\ldots,2a_s\), appending \(n-2\) copies of \(S\). The total is \(nS\). The appended goods must each occupy a whole bin in any equal-load partition because every low good is positive. The remaining two bins with load \(S\) exist exactly when the original input is a yes-instance of PARTITION, including when \(S\) is odd. Apply the construction using \(B=1+nW\), then the positive-value conversion above. The number of goods is \(mn+3n-4\), with \(m=s+n-2\). The bit lengths of all goods and the threshold grow by at most a logarithmic amount in \(m,n\) relative to the total-value bit length. For each fixed \(n\) this is a polynomial-time reduction.

Membership in NP follows by evaluating a certificate of one recipient per good. To see pseudopolynomial solvability for fixed \(n\), let \(V\) be the sum of all input values. A dynamic program records each vector of the first \(n-1\) loads in \(\{0,\ldots,V\}^{n-1}\) and its minimum prefix cost. The final coordinate equals the total arrived value less the recorded loads. Extend each state by each possible recipient, add the new range, and keep the minimum cost at each next state. This uses \(O(Ln^2(V+1)^{n-1})\) arithmetic operations and proves exactness by induction on the prefix. This standard upper bound, together with the reduction, gives the weak NP-completeness claim, compatible with the existing fixed-agent FPTAS.

## 5. Attribution and verification

Paul W. Goldberg, Isaac Robinson and Nicholas Teh, *Minimizing Cumulative Envy in Allocating a Sequence of Items*, arXiv:2610.09843v1. The archived open question lies in Section 4, after Corollary 2 and before Theorem 4.2. Section 5 and Appendix C.1 treat the model with a selectable arrival order. [Primary reference recorded in the archive](https://arxiv.org/abs/2610.09843v1)

The fixed-agent precursor gives a two-sentinel reduction for \(n\ge4\) and explicitly leaves the two- and three-agent cases unclassified. Its archived source audit also distinguishes the same-valuations terminal-envy problem, which already embeds PARTITION with two agents. The present cancellation construction and identity directly address the extra costs from the intermediate prefixes. Fixed precursor and source audit

The mathematical proof was independently reviewed. Finite integer verification compares the identity with the actual minimum over prescribed-order allocations. Lean verification of the whole manuscript is pending. Literature comparison is confined to the fixed archived materials and their documented source checks.
