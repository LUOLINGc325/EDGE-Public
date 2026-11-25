---
title: "The additive cost of counted feedback at the growing-round erasure frontier"
lang: en
---

# The additive cost of counted feedback at the growing-round erasure frontier

## Abstract

In deterministic binary transmission under adversarial erasures, increasingly many adaptively timed feedback requests bring the erasure threshold close to one. We determine the first-order number of **charged feedback bits** needed to approach that threshold when both the message bit length \(n\) and the request budget \(r\) grow. The answer is \(r+\log_2 n\) to first order, with no restriction on their relative growth. The converse follows an all-erasure history. A three-message alternative at each node prevents the protocol from exhausting its forward length too early, so almost \(r\) charged requests have already occurred while the remaining protocol still needs \(\log_2 n-O(\log_2\log_2 n)\) feedback bits. The construction attains the leading sum with polynomial forward length. It retains a large list until the first compressible feedback packet, then encodes successive list reductions by subset ranks.

## 1. Model and results

Alice transmits one of \(m\ge2\) messages to Bob. The forward channel carries binary symbols which are delivered faithfully or erased. A deterministic protocol has a common total forward length \(L\ge1\) on every branch and at most \(r\) feedback requests. At a request Bob sends a bit string from a shared prefix-free packet set. The next forward blocklength and any stopping decisions are determined by the shared history. All tags, payloads and informative termination signals count toward the worst-case feedback length \(B\). In particular, there is no message-dependent request timing. Both parties' local computations and the public codebooks are unrestricted.

Let \(U(P)\) be the largest number of unerased forward symbols in a complete transcript compatible with two messages. A consistency decoder corrects every pattern with fewer than \(L-U(P)\) erasures. Write \(f_r(m)\) for the exact optimal unerased fraction with full, uncharged feedback, as defined and evaluated in [1]. Its finite-length converse is \(U(P)\ge Lf_r(m)\), also for compressed packets. Approaching this frontier means that \(U(P)/L\le(1+\varepsilon)f_r(m)\). All logarithms below have base two unless written \(\ln\).

**Theorem 1 (charged-feedback construction).** There is a universal constant \(C\) such that, for \(m\ge2\), \(r\ge0\), \(0<\varepsilon\le1\), and any integer
\[
L\ge C(r+1)^2\varepsilon^{-2}\log_2(2(r+1)/\varepsilon)\log_2(2m),
\]
an admissible protocol satisfies \(U(P)\le(1+\varepsilon)L f_r(m)\) and
\[
B\le r+\lceil\log_2\log_2 m\rceil+C K\log_2(2K),
\qquad K=2+\lceil\log_2(64(r+1)/\varepsilon)\rceil .
\]

**Theorem 2 (charged-feedback converse).** Let \(m=2^n\), \(n\ge3\), \(r\ge6\), \(L\ge1\), and \(0\le\varepsilon\le1/64\). Suppose \(U(P)\le(1+\varepsilon)L f_r(m)\). Put \(h=m/2\), \(c=(h-2)/(2(2h-1))\), \(a=1/(3c)\), and
\[
s_0=\max\{6,\lceil r(64\varepsilon)^{1/(1+a)}\rceil\}.
\]
Then the protocol must satisfy
\[
B\ge r-s_0+\log_2 n-\log_2\log_2 n-3.
\]
This bound applies to every forward length.

**Corollary 3 (joint first-order law).** Along every sequence with \(n,r\to\infty\) and relative slack \(\varepsilon\to0\), Theorem 2 gives \(B\ge(1-o(1))(r+\log_2 n)\). There are matching protocols with \(\varepsilon=1/\log_2(2+r)\) and
\[
B\le r+\log_2 n+O(\log_2(2+r)\log_2\log_2(4+r)),
\qquad L=O((r+1)^2\log_2^3(2+r)n).
\]
Because \(r f_r(2^n)\to7/12\) in the joint limit, these protocols approach the optimal first-order unerased fraction \((7/12+o(1))/r\).

## 2. Ingredients from the exact frontier

For \(q\) working messages, let \(b(q,k)\) be the probability that a fixed \(k\)-subset is unanimous in a uniformly balanced binary column. The pinned source [1, Lemmas 4 and 6] proves that every \(q\)-word block of length \(\ell\) has some \(k\)-subset unanimous in at least \(\ell b(q,k)\) positions. In particular \(b(q,q)=0\), \(b(q,k)\le2^{1-k}\), and for \(q\ge3\), \(b(q,3)=c\) with \(c=(\lceil q/2\rceil-2)/(2(2\lceil q/2\rceil-1))\). If \(q\ge3\), the same source gives
\[
f_s(q)=\frac{1+3c}{3(s+1)+H_s(c)},\qquad 0\le H_s(c)\le 1/2.
\]
Consequently \(1/[4(s+1)]\le f_s(q)\le7/[12(s+1)]\), \(f_s(3)=1/[3(s+1)]\), and \(f_s(2)=0\). In the regime \(c>1/(3s)\) the optimal first block equalizes the \(k=3\) and \(k=q\) branches. In terms of the optimal value this is
\[
\frac1{f_s(q)}=\left(1-\frac1{3sc}\right)\frac1{f_{s-1}(q)}+\frac1c . \tag{1}
\]
The Bellman value for \(s\ge1\) is
\[
f_s(q)=\min_{0\le t\le1}\max_{2\le k\le q}\{t b(q,k)+(1-t)f_{s-1}(k)\},\qquad f_0(q)=b(q,2).
\]

We use two finite-length estimates from [2, Sections 2–3]. In a state with \(N\) forward symbols remaining, transmit \(\ell=\lfloor t_s N\rfloor\) using the exact optimizer from [1]. Along any active path that uses these optimizers on states with \(q\ge3\), each nonfinal coded block has length at least \(5L/[21(r+1)]-1\), and a final block has length at least \(L/[3(r+1)]\). This pathwise bound is uniform in the working message counts, so it also applies when a state keeps its old labels. Independently, given \(0<\eta,\delta\le1\), there is a deterministic \(q\)-word code at every integer length \(\ell\ge C_0\log_2(2/\delta)\log_2(2q)/(\eta\delta)\) in which every subset \(S\) of size \(k\ge2\) has at most
\[
\ell[(1+\eta)b(q,k)+\delta] \tag{2}
\]
unanimous positions. All codes can be fixed publicly before transmission.

## 3. Construction and packet accounting

Maintain a publicly ordered working label set of size \(q\), the true label known to Alice, and an injective dictionary from these labels to original messages known to Bob. Initially the dictionary is the identity. If the working list reaches a singleton, pad the remaining forward length and decode it. At two labels, use distinct constant forward words for the rest of the length. At zero remaining requests and \(q\ge3\), transmit a final code satisfying (2) and decode any compatible label.

At an active state choose \(\eta=\varepsilon/4\), \(\delta=\varepsilon/[64(r+1)]\), and \(K\) as in Theorem 1. Use (2) at the optimally rounded blocklength. Bob computes the set \(\Gamma\) of labels compatible with this block. It contains the true label. When \(q>K\) and \(|\Gamma|>K\), Bob sends \(0\). Keep the working labels and dictionary, discarding this block's exclusions. When \(q>K\) and \(1\le|\Gamma|\le K\), Bob sends \(1\) and a hash index identifying a publicly fixed map into a set of size \(K^2\) that is injective on \(\Gamma\). He sends the size of \(\Gamma\) in \(\lceil\log_2 K\rceil\) bits and the rank of the image among subsets of that size. Alice applies the hash to her label. Both parties use the ordered image as the working list, while Bob transfers the dictionary on \(\Gamma\) through the injection. The hash need only be injective on this surviving list.

A family of \(T=\lceil K\log_2 m+\log_2 K\rceil+1\) maps suffices. A uniform map into \(K^2\) collides on a fixed subset of size at most \(K\) with probability below \(1/2\). Independent maps and a union bound over at most \(K m^K\) subsets give a family. The index length is \(\lceil\log_2 T\rceil\le\lceil\log_2\log_2 m\rceil+O(\log_2(2K))\). The image rank costs at most \(\lceil\log_2\binom{K^2}{|\Gamma|}\rceil=O(K\log_2(2K))\). Only the initial working set can have size above \(K\), and it stays unchanged until the hash. Thus this payload can be charged at most once.

When \(q\le K\), Bob sends \(0\) if the list is unchanged. Otherwise he sends \(1\), the surviving size \(k\) in \(\lceil\log_2 q\rceil\) bits, and the rank of \(\Gamma\) among \(k\)-subsets in \(\lceil\log_2\binom qk\rceil\) bits. The fixed-width size field gives the length of the rank field. The same applies to the large-state packet. Every packet set is prefix-free, and the next timing depends only on the parsed packet and shared resources. The private dictionary is used by Bob to convert the final label back to the original message.

If the successive strict small-state reductions have sizes \(q_0>q_1>\cdots>q_d\), then
\[
\prod_{i=0}^{d-1}\binom{q_i}{q_{i+1}}=
\frac{q_0!}{q_d!\prod_{i=0}^{d-1}(q_i-q_{i+1})!}\le K!.
\]
There are at most \(K-1\) reductions. Summing all small-state rank lengths, their rounding overhead, and their size fields costs \(O(K\log_2(2K))\). There is at most one tag per request, including the switch to hashed labels and requests that keep the same list. This establishes the feedback bound in Theorem 1.

### 3.1. Resilience with discarded exclusions

At a state with \(q\) labels, \(s\) remaining requests and \(N\) forward symbols left, every execution on which the decoder errs has at most
\[
N[(1+\eta) f_s(q)+2\delta]+(1+\eta)s \tag{3}
\]
unerased symbols in the remaining transmission. At \(q=1\) this is vacuous and at \(q=2\) an error needs all remaining symbols erased. At \(s=0\), an error on the final decoded label requires two consistent labels, bounded by (2) with \(k=2\).

For a request block of length \(\ell\), all its unerased positions are unanimous on \(\Gamma\). When the list is kept or reduced with \(|\Gamma|\le K\), and the execution later errs, \(k=|\Gamma|\ge2\). The first block has at most \(\ell[(1+\eta)b(q,k)+\delta]\) unerased symbols and the continuation has \(k\) working labels. This remains true after the injective relabeling. In the large-state reset case, \(|\Gamma|>K\) implies \((1+\eta)b(q,|\Gamma|)+\delta\le2\delta\) by the choice of \(K\). The continuation then has all \(q\) working labels, and the first block fits the same bound with \(k=q\), \(b(q,q)=0\), and error allowance \(2\delta\). Thus all cases are covered by the Bellman bound on the branch \(k\), including the reset branch \(k=q\).

By induction, the total number of remaining unerased symbols on an error is at most
\[
(1+\eta)[\ell b(q,k)+(N-\ell) f_{s-1}(k)]+2\delta N+(1+\eta)(s-1).
\]
Each affine branch of the Bellman envelope is 1-Lipschitz in the first-block fraction. Taking the floor when forming \(\ell\) increases the bracket by at most one above \(N f_s(q)\). This proves (3). The induction bounds errors of this decoder even when it intentionally discards information. Any ambiguous complete transcript forces an error for at least one of its compatible messages, so (3) also bounds \(U(P)\).

The length bound of Theorem 1 guarantees (2) in every coded block by the pathwise estimates of Section 2. Enlarge \(C\) so that \(L\ge32r(r+1)/\varepsilon\) as well. For \(m\ge3\), \(f_r(m)\ge1/[4(r+1)]\). Using \(\eta\le1/4\) gives
\[
\eta f_r(m)+2\delta+(1+\eta)r/L\le(17/32)\varepsilon f_r(m).
\]
This proves the promised relative slack. At \(m=2\), distinct constant words give \(U(P)=0\) without feedback.

## 4. Converse along the all-erasure history

First remove requests at shared states with a singleton packet set. Both parties can simulate the unique packet at its scheduled position, and concatenate the forward blocks with shared boundaries until another request is needed. This preserves the forward transcript behavior and does not increase either resource. The resulting protocol has only requests whose packet sets exclude the empty packet, so every actual remaining request costs at least one bit. Its worst-case total feedback is at most the original \(B\).

Set \(W=(1+\varepsilon)L f_r(m)\), so \(U(P)\le W\). Consider the all-erasure path. At a point after \(r-s\) retained requests, let \(N_s\) be the remaining forward length, starting at \(N_r=L\). All \(m\) messages remain possible, and at most \(s\) requests remain. The next lemma limits how quickly this path can use its forward length.

At a reached state with \(s>s_0\), suppose the next block before a retained request has length \(\ell\). Some triple of labels agrees on at least \(c\ell\) symbols in this block, by the arbitrary-code converse. Consider the history formed by keeping their unanimous symbols and erasing the others in that block, after the same all-erased prefix. It yields common feedback for these three messages. Their continuation has shared length \(N_s-\ell\) and at most \(s-1\) requests. The finite-length converse applied to these three inputs gives an ambiguous continuation with at least \((N_s-\ell)/(3s)\) unerased symbols. No symbols were kept before the block in question. Hence
\[
c\ell+\frac{N_s-\ell}{3s}\le W.
\]
The shared prefix fixes the forward length before the next retained packet, whichever packet Bob then sends. The all-erasure branch after that packet therefore satisfies
\[
N_{s-1}=N_s-\ell\ge\frac{N_s-W/c}{1-a/s}. \tag{4}
\]

For comparison, define \(N_s^*=W/f_s(m)\). Since \(m\ge8\), \(c\ge1/7\) and \(a\le7/3\). For each \(s>s_0\) the late-regime identity (1) holds, so \(N_s^*,N_{s-1}^*\) satisfy (4) with equality. Upon writing \(D_s=N_s^*-N_s\), the comparison gives
\[
D_{s-1}\le(1-a/s)^{-1}D_s,\qquad D_r\le4\varepsilon (r+1)W . \tag{5}
\]
The root bound follows from \(D_r=\varepsilon L\) and \(f_r(m)\ge1/[4(r+1)]\). For \(s\ge6\), the logarithm of the product from \(j=s+1\) to \(r\) of the factors in (5) is at most
\[
a\ln(r/s)+a^2/s.
\]
Indeed, \(-\ln(1-x)\le x+x^2\) when \(0\le x\le1/2\), and the sums of \(1/j\) and \(1/j^2\) are bounded by the integrals from \(s\) to \(r\) and from \(s\) to infinity, respectively. As \(\exp(a^2/s)\le4\), every reached state with \(s\ge s_0\) satisfies
\[
D_s\le32\varepsilon s W(r/s)^{a+1}\le sW/2 .
\]
For \(\varepsilon=0\), (5) gives \(D_s\le0\) directly. Since \(N_s^*\ge12(s+1)W/7\), it follows that \(N_s>sW\).

This deduction also ensures the intended prefix exists. If a reached state with \(s>s_0\) has no further retained request, the continuation on all \(m\) messages is a single no-feedback code. It has ambiguous unerased count at least \(N_s f_0(m)\ge N_s/3>W\), a contradiction. The root comparison starts the induction. Each reached state with \(s>s_0\) must have a next request, and (4) propagates (5) to the following all-erasure state. Therefore the path reaches \(s=s_0\) after \(r-s_0\) charged requests.

### 4.1. Residual feedback lower bound

At that reached state, the remaining length satisfies \(N_{s_0}\ge s_0 W\), and the remaining protocol still has all \(m\) messages. Its maximum ambiguous unerased count is at most \(W\), since its prefix was all erased. In particular it corrects every pattern of at most \((2/3)N_{s_0}\) erasures. The charged feedback bound of [1, Theorem 14] for resilience \(2/3\) is
\[
B_{\rm suffix}\ge\log_2 n-\log_2\log_2 n-3 .
\]
For this parameter its proof colors each pair of messages by a complete history under which their forward words have relative distance at least \(7/12\). Plotkin counting rules out a monochromatic clique of size eight. An elementary Ramsey bound gives \(n<8B_{\rm suffix}2^{B_{\rm suffix}}\) if \(B_{\rm suffix}\ge1\), and Plotkin counting rules out zero feedback for \(m\ge8\). Shared timing and prefix-free packets ensure that \(B_{\rm suffix}\) bounds the depth of the binary tree of complete histories. The preceding \(r-s_0\) charged bits occurred on the same prefix for all suffix executions. Adding the lower bounds proves Theorem 2.

## 5. Joint limit and scope

The values of \(a\) lie in \([4/3,7/3]\); hence \(s_0/r\to0\) whenever \(r\to\infty\) and \(\varepsilon\to0\), uniformly in \(n\). The residual logarithmic deficit is \(o(\log_2 n)\). This proves the lower asymptotic in Corollary 3. For the upper, \(\varepsilon=1/\log_2(2+r)\) gives \(K=O(\log_2(2+r))\), and substitution in Theorem 1 gives the stated lengths. The constant \(7/12\) for the unerased fraction is inherited from [1], because \(c\to1/4\) and \(H_r(c)\le1/2\).

The shared-history request model, full-feedback frontier, fixed-round hash compression, and logarithmic feedback converse are due to the sources. The simultaneous growing-round construction and the all-erasure-prefix converse establish an additive first-order cost. The converse uses the exact late-regime recursion to compare a prefix preserving all messages with a separate triple branch at each of its nodes. The two budgets therefore appear along one execution. The paper does not determine the optimal second-order term or give an efficient uniform construction of the codebooks.

## References

1. *Exact erasure resilience with adaptively scheduled feedback*, pinned earlier research manuscript manuscript (archived version). Lemmas 4 and 6, Theorems 1–2 and 14, and Section 8.
2. *Polynomial forward length for growing-round adaptive erasure feedback*, pinned earlier research manuscript supplement (archived version). Sections 2–4.
