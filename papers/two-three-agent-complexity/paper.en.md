---
title: "Cumulative envy is weakly NP-complete with two and three identical agents"
subtitle: "Exact lower bounds from alternating and cyclic load increments"
lang: en
geometry: margin=1in
abstract: |
  Indivisible goods of identical additive value arrive in a prescribed order. An irrevocable allocation costs the sum, over all prefixes, of the maximum pairwise envy. We prove that exact optimization is weakly NP-complete for the two smallest nontrivial agent counts, even with strictly positive binary-encoded integer values. For two agents the reduction gives an exact optimum equal to a known baseline plus the discrepancy of the source partition instance. For three agents a universal three-prefix range inequality and a single final positive-valued good establish a sharp decision threshold. Together with the existing fixed-agent result for four or more agents, these results classify all fixed agent counts.
---

## 1. Formulation and result

There are \(n\) agents and a prescribed sequence of \(N\) indivisible goods of values \(v_1,\ldots,v_N\). All agents have the same additive valuation. An allocation specifies a recipient \(s_j\in[n]\) for each good. The load of agent \(i\) after prefix \(j\) is \(x_i(j)=\sum_{k\le j:\,s_k=i}v_k\). Write
\[
 \mathcal R(x)=\max_i x_i-\min_i x_i,\qquad
 C_v(s)=\sum_{j=1}^N\mathcal R(x(j)).
\]
With identical valuations, \(\mathcal R(x(j))\) is the maximum pairwise envy at prefix \(j\). All allocations are irrevocable. The optimizer knows the whole sequence, and its order is part of the input. The decision problem asks whether \(\min_s C_v(s)\le K\).

**Theorem 1.** For each of \(n=2\) and \(n=3\), the decision problem with strictly positive, binary-encoded integer values is NP-complete and has a pseudopolynomial algorithm. For \(n=1\) the cost is always zero. The earlier fixed-agent result covers each \(n\ge4\), so the prescribed-order problem is weakly NP-complete for every fixed \(n\ge2\).

The archived case *Cumulative Envy Is Weakly NP-Complete for Every Fixed Number of Agents at Least Four* attributes the fixed-number question to Goldberg, Robinson, and Teh and explicitly leaves two and three agents unclassified. Its two-sentinel construction reserves two recipients, leaving too few recipients to place the PARTITION input for \(n\le3\). Here we use a common offset scale and charge short blocks separately. Both constructions use linearly many positive goods and add only logarithmically many bits to the largest input value.

## 2. Two agents and the exact partition discrepancy

For positive integers \(a_1,\ldots,a_m\), let \(W=\sum_i a_i\) and
\[
 \Delta(a)=\min_{\tau_i\in\{-1,1\}}\left|\sum_i\tau_i a_i\right|.
\]
Set \(B=W+1\) and construct the sequence
\[
 v=\big(B,\ (a_1,2B),\ldots,(a_m,2B),\ B\big),
 \qquad K_2=(2m+1)B .
 \qquad\text{(1)}
\]
Each pair of parentheses indicates two successive goods.

**Proposition 2.** The optimum for (1) with two agents is \(K_2+\Delta(a)\).

**Proof.** The range with two agents is the absolute signed load difference. Each block \((a_i,2B)\) contributes \(|D|+|D\pm2B|\ge2B\), where \(D\) is the difference just after \(a_i\). The first good contributes \(B\), so the cost before the final good is at least \(K_2\).

At the last prefix, the signed difference due to the designated large goods alone is an even multiple of \(B\): their total in units of \(B\) is \(2m+2\), and their signed difference has the same parity. The signed difference due to the \(a_i\) has absolute value at most \(W\). If the large-good difference is zero, the final range is at least \(\Delta(a)\). Otherwise the final range is at least \(2B-W>W\ge\Delta(a)\). This gives the lower bound.

For equality, give the first \(B\) to either agent, assign the \(a_i\) according to signs attaining \(\Delta(a)\), and give each \(2B\) to the agent with the smaller load from the designated large goods. The difference from those goods changes sign and stays of absolute value \(B\). The signed small-good discrepancy \(d\) is constant across the two charged prefixes of a block and has \(|d|<B\). Hence their ranges sum to \(|B+d|+|-B+d|=2B\). Give the final \(B\) to the agent with the smaller designated large-good load, making those loads equal. The last range is exactly \(\Delta(a)\). This attains the bound.

PARTITION asks whether \(\Delta(a)=0\), so threshold \(K_2\) proves NP-hardness. Proposition 2 also identifies the exact optimum for every no-instance.

## 3. Three agents and a cyclic range inequality

Let \(e_i\) denote the unit coordinate vector for agent \(i\).

**Lemma 3.** For arbitrary \(x\in\mathbb R^3\), \(b\ge0\), and recipients \(i,j\in[3]\),
\[
 \mathcal R(x)+\mathcal R(x+b e_i)+\mathcal R(x+b e_i+b e_j)\ge2b.
 \qquad\text{(2)}
\]

**Proof.** If \(i=j\), choose any other coordinate \(k\). The signed difference involving \(i\) and \(k\) changes by \(2b\) between the first and third states. The sum of their ranges is at least \(2b\) by the triangle inequality; the middle range is nonnegative. If \(i\ne j\), let \(k\) be the third coordinate. Lower-bound the three ranges respectively by \(x_k-x_i\), \(x_i+b-x_j\), and \(x_j+b-x_k\). Those signed differences are at most the corresponding ranges regardless of which coordinates are extreme, and sum to \(2b\).

A related two-prefix inequality for any \(n\ge2\) is
\[
 \mathcal R(x)+\mathcal R(x+b e_i)\ge b .
 \qquad\text{(3)}
\]
Compare agent \(i\) with any other agent, and apply the triangle inequality.

### 3.1. A universal prefix cost bound

Take a PARTITION instance with positive \(a_1,\ldots,a_m\) of even total \(2T\). Doubling the integers in an arbitrary instance always makes the total even and preserves the answer. Add one small good of value \(T\), and put
\[
 (b_1,\ldots,b_M)=(a_1,\ldots,a_m,T),\qquad M=m+1,\quad W=3T,\quad B=W+1.
\]
Construct the base sequence
\[
 v=\big(B,2B,\ (b_1,3B,3B),\ldots,(b_M,3B,3B),\ 2B,B\big),
 \qquad K_3=(6M+4)B .
 \qquad\text{(4)}
\]
The first two contributions sum to at least \(3B\). The first range is \(B\). The next is \(2B\) if the recipients differ and \(3B\) if they coincide. Every three-prefix block contributes at least \(6B\) by Lemma 3 with \(b=3B\), taking \(x\) just after the small good. The last two prefixes contribute at least \(B\) by (3). Since the charged sets of prefixes are disjoint, every assignment of (4) costs at least \(K_3\).

### 3.2. Terminal equality encodes PARTITION

The designated large goods of (4) all have values that are multiples of \(B\). Each agent's accumulated small load belongs to \([0,W]\), with \(W<B\). If the terminal loads are equal, the designated large-good loads must themselves be equal: a nonzero difference of at least \(B\) cannot be canceled by a small-load difference of at most \(W\). The small loads then also coincide and are each \(T\). Whoever receives the extra good of value \(T\) can receive no original positive item. Thus the original items are split into two bundles of value \(T\).

Conversely, given a partition, send its two bundles to distinct agents and the extra small good to the third. Assign the initial \(B\) and \(2B\) to distinct agents. Just before each small good, the designated large-good loads, in increasing order, are \((h,h+1,h+2)B\) for some integer \(h\). Give each \(3B\) to the agent with the smallest current designated large-good load. This moves that agent to the largest position and rotates the order, preserving consecutiveness. Across the three charged prefixes of a block each agent occurs once as the maximum and once as the minimum. The actual extrema are attained by the same agents because small-load offsets lie in \([0,W]\). Those offsets remain unchanged across the three prefixes, so their signed corrections cancel and the sum of ranges equals \(6B\).

After the last block, give the closing \(2B\) to the smallest designated large-good load and the closing \(B\) to the middle one. All small loads are already \(T\), so the final two ranges are \(B\) and zero. This assignment attains \(K_3\) and has equal terminal loads.

### 3.3. One positive terminal good

Multiply every value in (4) by 3 and append one good of value 1. Use threshold \(3K_3+1\). For a yes-instance the constructed assignment after scaling costs \(3K_3\) through (4), and the unit good adds range one. For a no-instance, the range just before the last good is at least 3 for any assignment, since equality would imply PARTITION and all loads at that prefix are multiples of 3. Adding one to a coordinate changes the range by at most one, so the final range is at least 2. The scaled base cost is at least \(3K_3\), giving total at least \(3K_3+2\). This proves the strict decision gap with positive goods throughout.

The two-agent sequence has \(2m+2\) goods. The three-agent sequence has \(3m+8\) goods including the terminal unit. In both, \(B\), each produced value, and the threshold have bit length at most the maximum source bit length plus \(O(\log(m+1))\). The reductions run in polynomial time in the binary input.

## 4. Membership in NP and pseudopolynomial algorithms

A recipient certificate can be verified by computing every prefix and its range with integer operations on at most \(O(\log(1+NV))\) bits, where \(V=\sum_jv_j\). This establishes membership in NP.

For any fixed \(n\), store the best accumulated cost for each first \(n-1\) load vector in \(\{0,\ldots,V\}^{n-1}\). The remaining load is implied by the known prefix total. For each next good, try each recipient, compute the new range, and take the best cost through each updated vector. The zero vector initializes the procedure. The recurrence is exact because the current loads determine every possible continuation cost. The time is \(O(Nn^2(V+1)^{n-1})\) arithmetic operations, pseudopolynomial for fixed \(n\).

For two agents the absolute difference \(d\in\{0,\ldots,V\}\) suffices. Assigning a good of value \(v\) updates it to \(d+v\) or \(|d-v|\), and the new difference is charged. This uses \(O(N(V+1))\) arithmetic operations.

## 5. Archival relation and scope

The archived case covers \(n\ge4\) and credits the prescribed-order formulation and two-sentinel approach to Goldberg, Robinson, and Teh. The present two-agent proof gives an exact optimization reduction, while the three-agent proof supplies a local lower bound valid for all recipient choices and uses terminal equality only to decode a partition. The classification concerns exact optimization with identical additive valuations in a prescribed order. The accompanying program checks small instances by exact load-state optimization and checks the local inequality over signed offset profiles.
