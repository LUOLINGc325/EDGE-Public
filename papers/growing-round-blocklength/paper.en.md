---
title: "Polynomial forward length for growing-round adaptive erasure feedback"
subtitle: "Uniform finite-block realization of the adaptive frontier"
lang: en
---

# Polynomial forward length for growing-round adaptive erasure feedback

## Abstract

An exact adaptive-feedback erasure threshold was previously paired with a length bound that could grow faster than exponentially in the request budget. We prove a polynomial forward-length bound even when the budget grows with the number of messages. The exact real-valued timing rule keeps every active block at least a constant times the average blocklength. A simultaneous code with multiplicative and additive unanimity bounds then preserves the small surviving fraction to relative accuracy. For r requests it suffices to take forward length of order (r+1)² log((r+1)/ε) log m divided by ε² to realize the frontier within relative ε in its unerased fraction. The blockwise method has a matching quadratic dependence on the request budget up to the logarithmic factor in the large-message regime.

## 1. Model and theorem

We use the deterministic shared-feedback erasure model of the archived *Exact erasure resilience with adaptively scheduled feedback*. The sender communicates one of m≥2 messages by forward bits, each of which is faithful or erased. At most r noiseless feedback requests are allowed. Each request returns the received block since the preceding request. Timing of the next request is a deterministic function of the information already shared. Every execution has the same total forward length L. Feedback and computation time are free. A private message cannot communicate through a privately selected request time.

Let μ(P) be the smallest number of erasures in a complete transcript compatible with at least two messages. A consistency decoder succeeds whenever the number of erasures is strictly less than μ(P). Write B_r(m) for the exact normalized ambiguity frontier from the pinned archive, and f_r(m)=1−B_r(m) for its remaining unerased fraction. In particular f_r(2)=0.

**Theorem 1.** A universal constant C has the following property. For every m≥2, integer r≥0, 0<ε≤1, and every integer

~~~text
L ≥ C (r+1)² ε^(−2) log(2(r+1)/ε) log(2m),
~~~

there is a deterministic protocol with common forward length L and at most r requests such that

~~~text
μ(P) ≥ L[1−(1+ε) f_r(m)].                                    (1)
~~~

For absolute slack ε it suffices instead to take

~~~text
L ≥ C (r+1) ε^(−2) log(2/ε) log(2m),
μ(P) ≥ L[B_r(m)−ε].                                          (2)
~~~

These are existence bounds on forward length, with no efficiency claim for finding the constituent codes. The archived theorem proves existence with linear dependence on log m for each fixed r and slack. Its use of clamped timings can give a rapidly deteriorating length constant when r increases.

## 2. The real-valued timing rule leaves room for every block

For q≥3 candidate messages and s≥0 remaining requests, the archived exact formula is

~~~text
f_s(q) = (1+3c)/[3(s+1)+H_s(c)],    0≤c≤1/4,
c=(h−2)/[2(2h−1)],    h=⌈q/2⌉.
~~~

The archive's correction recurrence gives 0≤H_s(c)≤H_0(c)=3c/(1+2c)≤1/2. For s≥1, the optimal first-block fraction is

~~~text
t_s = 1/[1+s(1−c)]                            if c≤1/(3s),
t_s = (w−v)/(c+w−v)                           if c>1/(3s),
w=f_(s−1)(q),   v=1/(3s).                                    (3)
~~~

We claim that both branches satisfy

~~~text
t_s ≥ 5/[7(s+1)],    t_s≤1/s,
1−t_s ≥ [s/(s+1)] [1−1/(3s²)].                               (4)
~~~

In the early branch, t_s≥1/(s+1), and its denominator is at least s+2/3. The ratio of 1−t_s to s/(s+1) equals 1−c/[1+s(1−c)], at least 1−1/(3s²). In the late branch, putting H=H_(s−1)(c) gives

~~~text
w−v = (9sc−H)/[3s(3s+H)].
~~~

Here 9sc>3 and H≤1/2, so 5c/(7s)≤w−v≤c/s. Substitution into (3) gives 5/[7(s+1)]≤t_s≤1/(s+1), which implies (4).

Use the integer first-block length ℓ=⌊t_s N⌋ when N symbols remain. The remainder is at least (1−t_s)N. For any branch that reaches an active state with s remaining requests, multiply the inequalities in (4). The main factors telescope and the correction product is at least a constant:

~~~text
∏_(j≥1) [1−1/(3j²)] ≥ 1−(1/3)∑_(j≥1) j^(−2) ≥ 1/3.
~~~

The last inequality follows from the integral bound ∑j^(−2)≤2. Hence N is at least L(s+1)/[3(r+1)]. Every nonfinal coded block is therefore at least 5L/[21(r+1)]−1, and the final block is at least L/[3(r+1)]. This argument holds along every adaptive branch because (4) is uniform over the candidate count.

Branches with at most two candidates terminate requests immediately and assign all remaining time to a final block. With two candidates use two distinct constant words, so every symbol in a confusing continuation must be erased. With one candidate use a fixed padding word, so no ambiguity remains. This keeps the common total length.

## 3. Simultaneous relative control of unanimous columns

For a q-message code and a subset S of size k≥2 let U(S) count columns on which its codewords are unanimous. Let b(q,k) be the probability of unanimity in a uniformly balanced random column on q symbols. The archived formula gives b(q,k)≤2^(1−k).

**Lemma 2.** For 0<η,δ≤1, every q≥2 admits a deterministic block code of any integer length

~~~text
ℓ ≥ C₀ log(2/δ) log(2q)/(ηδ)
~~~

such that every subset S of at least two messages satisfies

~~~text
U(S) ≤ ℓ[(1+η)b(q,|S|)+δ].                                   (5)
~~~

**Proof.** Independently sample a balanced column at each position. For any fixed S, with b=b(q,|S|), the exponential moment of U(S) at λ>0 is at most exp[ℓ b(exp(λ)−1)]. Take λ=η/2. Since exp(λ)−1≤λ+λ² for 0≤λ≤1/2, exponential Markov gives

~~~text
Pr{U(S)/ℓ>(1+η)b+δ/2} ≤ exp(−ηδℓ/4).
~~~

Indeed the coefficient of b in the exponent is at most λ²−λη≤0. Choose k₀=O(log(2/δ)) with (1+η)2^(1−k₀)≤δ/2. A union bound over subsets of sizes at most k₀ has at most k₀ q^(k₀) terms and is below one at the stated length, increasing C₀ if needed. For a larger set choose any k₀ of its members. Its unanimity is no greater than theirs, which is at most δℓ. Thus a single code satisfies (5) for all relevant subsets.

## 4. Uniform finite-length realization

In unerased-fraction form, the archived Bellman rule is

~~~text
f_s(q) = min_(0≤t≤1) max_(2≤k≤q) [t b(q,k)+(1−t) f_(s−1)(k)],
f_0(q)=b(q,2).                                               (6)
~~~

Here t_s in (3) attains the minimum. Each bracket in (6) is 1-Lipschitz in t because the coefficients lie in [0,1]. Use the block of length ⌊t_s N⌋ at each active state with q≥3 and s≥1. Give it a deterministic code from Lemma 2, and after its feedback choose the remaining candidates and apply the same rule. At zero remaining requests use Lemma 2 for the whole remaining block. Choose candidate labels in public order and fix a successful code in advance for every required parameter triple. The block choices depend entirely on shared feedback.

For any confusing complete transcript of a state with q candidates, s remaining requests and N remaining symbols, we claim an upper bound on the number of unerased symbols,

~~~text
N[(1+η)f_s(q)+δ]+(1+η)s.                                    (7)
~~~

At zero remaining requests, a common transcript for at least two messages can have unerased positions only where a compatible pair is unanimous. Lemma 2 gives the bound since f_0(q)=b(q,2). The two-candidate continuation has zero unerased symbols on any confusing branch by the constant-word construction.

For an active state let k≥2 be the number of candidates still consistent at the first feedback. A confusing execution must have at least two such candidates. Every unerased position in the first block is unanimous among those k, so (5) applies. In the continuation use the induction bound with k candidates and s−1 requests. Adding the two terms gives at most

~~~text
(1+η)[ℓ b(q,k)+(N−ℓ) f_(s−1)(k)] + δN +(1+η)(s−1).
~~~

By (6) and |ℓ−t_sN|<1, the bracket is at most N f_s(q)+1. This proves (7). The additive code error is length-weighted, while the integer timing error contributes at most one per request before the common factor 1+η.

The block lower bounds in Section 2 ensure that all uses of Lemma 2 are legitimate whenever

~~~text
L ≥ C₁ (r+1) log(2/δ) log(2m)/(ηδ).
~~~

Applying (7) at the root and subtracting from L gives

~~~text
μ(P) ≥ L{1−(1+η) f_r(m)−δ} − (1+η)r.                         (8)
~~~

For m≥3, the archived formula gives f_r(m) ≥ 1/[4(r+1)]. Choose η=ε/4 and δ=ε/[32(r+1)]; the proposed length in (1), with a large enough universal constant, guarantees L≥32r(r+1)/ε as well as the code length requirements. Then η f_r(m)+δ+(1+η)r/L≤(17/32)ε f_r(m), proving (1) with room in the error bound. For (2) take η=δ=ε/4 and L≥8(r+1)/ε, giving total normalized error at most ε in (8). Both statements hold separately for m=2 by repeated distinct constant words. This finishes Theorem 1.

## 5. Growing rounds and comparison bounds

Let m=2^n and let n and r both tend to infinity, with no fixed relation between them. The archived finite formula gives c→1/4 and 0≤H_r≤1/2, hence

~~~text
f_r(2^n) = [7/12+o(1)]/(r+1).
~~~

Take ε=1/log(2+r) in (1) when r is large. There are protocols with

~~~text
L = O((r+1)² log³(2+r) n)
and μ(P)/L ≥ 1−[7/12+o(1)]/(r+1).                            (9)
~~~

The archived converse holds for every finite length, so the coefficient 7/12 in this joint limit is optimal. This is polynomial forward length even as the erasure tolerance tends to one. It uses uncharged feedback as specified in the model.

For comparison, if a protocol guarantees correction of E integer erasures, fix a pattern erasing exactly E positions. The L−E unerased bits determine the complete received transcript because all feedback and future timing are deterministic functions of what is received. Thus m≤2^(L−E). At an unerased fraction of order 1/r this gives a general lower bound of order r log m, allowing the usual one-symbol rounding at a first-failure threshold.

There is a sharper obstruction for the local certificate used above. In a block of length ℓ with q messages, fix any d positions with d≤ℓ and 2^d k≤q. At least k words share the same bits there by pigeonholing, so some k-subset has at least d unanimous positions. In particular, if a local certificate requires U(S)≤C₂ℓ/r for all |S|=k, with r large and q≥2k, then

~~~text
ℓ ≥ (r/C₂) ⌊log₂(q/k)⌋.
~~~

Indeed ℓ at most that logarithmic integer is impossible by taking d=ℓ, and otherwise one takes d equal to the logarithmic integer. In the relative-frontier certificate (5), k of order log r makes its permitted unanimity fraction of order 1/r for fixed ε. In any near-frontier protocol the first block has length O(L/r), even if its timing is changed. The balanced pair-unanimity coefficient of every q≥3 is at least 1/3, and the averaging bound of the archive shows that some pair in any binary first block agrees in at least ℓ/3 positions. Erase every other position and the whole continuation. A confusing transcript with at least ℓ/3 unerased positions results, so ℓ/3≤L−μ(P)=O(L/r). Thus enforcing this local certificate at the first block requires L of order at least r² log(q/k). In a regime such as n=log₂q much larger than log log r, this matches the quadratic round dependence of the construction up to its logarithmic factor at fixed relative slack. This is a lower bound on the stated local proof requirement, not a converse for every adaptive protocol.

## 6. Source relation and scope

The pinned source proves the exact real-valued frontier, its timing rule, and fixed-round implementation. The new result identifies a uniform lower bound on all block sizes under that same unmodified timing rule, and uses a relative unanimity estimate to obtain polynomial forward length for growing rounds. The exact frontier and its converse are credited to the source. The construction makes no claim about computation time, compressed feedback bits, or the optimal dependence on r for arbitrary finite-length protocols.
