---
title: "Private-chain silence does not reduce chained index below linear payload"
fontsize: 11pt
geometry: margin=1.03in
abstract: |
  In chained index, each holder must send a message before the position in its own string is revealed to the next holder. If every stage is publicly observable and the entire transcript is retained, free empty messages can reduce the payload to a single bit for long chains. We prove that a private-neighbor chain still requires linear payload, even when an empty message is distinguishable for free. The key is that two budgeted executions with the same suffix coalesce at a shared empty message. This gives a charged-prefix simulation with at most six times the private payload and transfers the strong direct product to parallel private chains.
---

## 1. Private-slot model

Fix string length \(n\ge2\), chain length \(k\ge1\), and a number \(r\ge1\) of parallel copies. In stage \(i\) a fresh player holds \(X_{i,1},\ldots,X_{i,r}\in\{0,1\}^n\). Its input also includes the \(r\) indices \(J_{i-1}\) from the preceding stage, which are absent at the first stage. The player sees only its incoming message \(M_{i-1}\), these local inputs, and its available coins. Stage numbers and other common problem parameters are public. The outgoing message \(M_i\) is any finite binary string, including the empty string. Its boundary is visible to the next player at no cost. The indices \(J_i\) are unavailable when \(M_i\) is chosen. They are known to the next player along with that message. The decoder sees only \(M_k,J_k\) and its coins. All players may use shared randomness and local private randomness independent of the inputs.

The promise is that for one vector \(B\in\{0,1\}^r\),
\[
 X_{i,j}[J_{i,j}]=B_j\qquad(1\le i\le k,\ 1\le j\le r).
\tag{1}
\]
There is no balance restriction on the input strings. A fixed schedule runs all stages. The only carried state is the incoming message and the preceding indices. The parties may jointly encode all \(r\) copies. The worst-case payload \(C\) is an integer bound on \(\sum_i |M_i|\), over every promised input and every realization of the coins.

The pinned work [1] distinguishes an all-history public blackboard with chargeable prefix messages from a public blackboard with free observable stages. It proves a uniform linear lower bound and strong direct product in the charged public model. In the public free-stage model its protocol can use a single bit at \(k\ge2^n\). The public record allows the decoder to locate an early nonempty message even if all later messages are empty. The private-neighbor free-stage model does not retain that record.

Use the hard distribution of [1]. Write \(N=2\lfloor n/2\rfloor\). The answer vector \(B\) is uniform. In every stage and copy, independently, the first \(N\) bits of \(X_{i,j}\) form the indicator of a uniform \(N/2\)-subset of \([N]\), and an extra bit at odd \(n\) is fixed. The index is drawn uniformly among positions of color \(B_j\) in those \(N\) coordinates. Conditional on \(B\), the stage-copy pairs are independent. The marginal \(J_i\) is uniform on \([N]^r\) for each \(B\).

**Theorem 1 (single answer).** Let \(r=1\), and suppose the protocol has error at most \(1/3\) on every promised input. Then
\[
 C\ge \frac{N}{12}\bigl(1-h_2(1/3)\bigr),
\tag{2}
\]
where \(h_2\) is binary entropy. Payload \(n\) suffices with zero error. Hence the private payload is \(\Theta(n)\), uniformly in \(k\).

**Theorem 2 (parallel answers).** For \(C\ge1\), success at recovering all \(r\) answers under the hard law is at most
\[
 \min\left\{1,\ 
 \frac{2C+1}{C+1}\,2^{-r/2+12C/(N+2)}\right\}.
\tag{3}
\]
For \(C=0\), success under that law is \(2^{-r}\). In particular, for \(r\ge8\) and \(C\le nr/96\), the probability is at most \(2^{-r/4}\). This distributional bound implies an input on which success is at most the stated probability.

## 2. Exact suffix coalescence

Fix all the random tapes, including the decoder's. Consider any two promised executions that have identical data in the final \(L\) stages and the same index vector \(J_s\) at the cut \(s=k-L\), but may have different messages \(M_s\). If the incoming messages are equal, all later messages and the final output agree, by deterministic iteration of the same local rule on identical data. If the incoming messages differ, at least one is nonempty. It has already consumed at least one bit of its execution's payload budget before the suffix begins. Thus across the two executions there are at most \(2C-1\) nonempty suffix messages, counting the two executions with multiplicity. When \(L\ge2C\), some suffix position has an empty outgoing message in both executions. Their subsequent local states agree from that position onward, since every preceding index used within the suffix is shared. Again their outputs agree.

The threshold \(2C\) is sharp for this deterministic state argument under a total budget. In the first stage, send a one-bit marker if the second coordinate of the first string equals one, and send empty otherwise. Take two inputs with the same answer and \(J_1=1\) in that copy but different second coordinates. Starting from this cut, use identical suffix inputs and send a one-bit marker exactly when the incoming message is empty. After \(2C-1\) such stages the final messages differ. The execution starting empty sends \(C\) bits and the other sends \(C-1\) after its one-bit prefix. This example only concerns the coalescence threshold.

### 2.1. When an empty cut can be instantiated

For a fixed answer vector \(b\), define its canonical promised input by making all the strings of copy \(j\) constant \(b_j\) and choosing every index equal to one. These inputs are valid under (1). An empty message at stage \(s\) on this input allows a suffix of any promised input with the same \(b\) to be simulated starting with an empty \(M_s\).

To prove this, take the canonical prefix through stage \(s\) and append the desired suffix. Replace the canonical \(J_s\) by that suffix's original preceding index. The constant strings preserve the promise for the modified \(J_s\), and stage \(s\) still sends an empty message since it cannot see that index. This is a full promised execution. Its suffix obeys the payload budget \(C\), and when at least \(2C\) stages remain its output matches that of the original promised execution by coalescence.

### 2.2. Choosing the cut without the answer

For \(k\le4C\), retain the full chain. For \(k>4C\), consider the interval of \(2C+1\) cuts
\[
\mathcal I=\{k-4C,k-4C+1,\ldots,k-2C\}.
\tag{4}
\]
Every cut leaves between \(2C\) and \(4C\) stages. For every fixed tape and every \(b\), at most \(C\) of these positions have a nonempty canonical message. Hence at least \(C+1\) cuts can be instantiated starting empty for that answer.

For one answer bit, the two canonical executions together use at most \(2C\) nonempty positions in \(\mathcal I\). Choose the first cut that is empty on both. This choice is a deterministic function of the tapes and the two prescribed witness inputs. It does not depend on the actual \(B\). The suffix simulation preserves the original output on every promised input.

For a vector answer, use a uniformly random cut in \(\mathcal I\) independent of the tapes and the inputs. For any fixed tape and any fixed promised input, the simulation can be instantiated from the empty state on at least \((C+1)/(2C+1)\) of all cuts. On each of those cuts it preserves the original output. In particular, this holds on every input and tape where the original output was correct. Therefore the success of the simulation, averaged over its random cut, is at least \((C+1)/(2C+1)\) times the original success. The statement is multiplicative because the cut guarantee holds on each successful execution.

## 3. A charged public simulation of cost at most \(6C\)

Simulate the retained stages on the charged public blackboard of [1]. Their order and start position are known from the common tapes and the cut. Expose the independent tapes as shared coins for this simulation while evaluating every original local rule on its original arguments only. At a retained stage, the next simulated sender uses only the decoded incoming message and preceding indices as carried state. A rule originally specified only on reachable local states may be completed arbitrarily at the other states.

Start the long-chain simulation with empty \(M_s\) and the shared boundary value \(J_s\). Under the hard law, \(J_s\) is independent of the pair consisting of \(B\) and all retained input pairs. This follows from its uniform conditional marginal and stage independence given \(B\). The chosen cut depends only on tapes and independent cut randomness, so the same independence holds conditional on those choices. We can therefore make the boundary index an independent public random seed. Forgetting the discarded stages gives exactly the hard law of [1] on the retained chain. For the uncut chain there is no preceding index.

For the random-cut simulation, some cuts may fail the canonical instantiation for the actual answer. Enforce budget \(C\) on all simulated suffixes by replacing any outgoing string whose length exceeds the remaining payload with the empty string. Continue with this transmitted string as the incoming state for the next simulated stage. This cap is implementable using the common transcript and current sender. It never changes a canonically instantiated simulation, since such a simulation is the suffix of a valid full execution with total payload at most \(C\). The cap can be used in the one-bit or uncut simulations as well.

A string of length \(\ell\) can be transmitted using the prefix code that writes \(1b\) for each bit \(b\) and ends with a single \(0\). The parser reads each leading \(1\) as indicating another bit and the leading \(0\) as the end of the message. The prefix cost is \(2\ell+1\) even if \(\ell=0\). Since there are at most \(4C\) retained slots when \(C\ge1\), the total charged cost is bounded by
\[
 C'\le 2C+4C=6C .
\tag{5}
\]
After each charged message, reveal the current indices as in [1]. This preserves the information order in (1). Conditional on the coins, cut, and optional boundary index, the retained model is the charged blackboard with a fixed length, the required fresh inputs, and a hard cost bound. All bounds used below are uniform in that length.

## 4. Applying the charged bounds

When \(C=0\) all messages are empty, and the final index is independent of the answer under the hard law. A decoder then succeeds with probability \(2^{-r}\), which excludes error at most \(1/3\) in the one-bit case.

For \(r=1\) and \(C\ge1\), the output of the charged simulation has the original hard-law success, at least \(2/3\) by the worst-case hypothesis. With \(\Gamma\) its public transcript and all public randomness, binary Fano gives \(I(B;\Gamma)\ge1-h_2(1/3)\). The conditional information budget of [1, Theorem A] yields \(I(B;\Gamma)\le2C'/N\). Its length requirement is satisfied because conditional on the public seeds the length is fixed and its bound is uniform. Independence of the seeds from the answer ensures they contribute zero information initially. Now (5) proves (2). Sending the full final string and nothing earlier gives the zero-error upper bound.

For parallel copies, the pinned charged theorem [1, Theorem B] gives success at most \(2^{-r/2+2C'/(N+2)}\) under the hard law. Conditional application to the public choices is valid regardless of how the original private output depends on the fixed tapes. Averaging and using the multiplicative preservation from Section 2.2 proves (3). When \(r\ge8\) and \(C\le nr/96\), \(N+2\ge n\) and the prefactor is less than two. The exponent including that factor is at most \(1-3r/8\le-r/4\). The same simulation preserves any specified success event defined by the final output and \(B\), so analogous list and Hamming-event bounds follow from the charged versions in [1].

## 5. Consequences and scope

For \(k\ge2^n\), the one-bit public free-slot protocol of [1] and (2) give a linear separation in payload between public retention of stage timings and private transmission to the immediate neighbor. The suffix argument uses the total payload bound on all promised inputs, including the canonical inputs that witness an empty boundary. The hard distribution is used only for the charged lower bound. The result concerns fixed scheduled neighbors and a decoder that sees the final local state. A model in which the decoder or intermediate senders retain earlier slot records has different state and need not coalesce.

**Reference**

1. *Uniform communication bounds and strong direct products for chained index*, earlier research manuscript, fixed commit 96c6a8e4449b, Theorems A–B and the public observable-slot upper bound. The full path, commit, and component blobs are in the source manifest.
