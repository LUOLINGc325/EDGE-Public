# A proof of the two-box best-pure-search conjecture

**Research manuscript, 24 November 2026.** AI-assisted research manuscript; this manuscript has not undergone external peer review.

## Abstract

Consider a fixed hidden target in one of two boxes. Each search takes one unit of time and, when directed at the occupied box, detects the target independently with probability $q=(m-1)/m$, where $m\geq3$ is an integer. Bui, Lidbetter, and Lin proposed an eventually periodic deterministic search sequence and conjectured its minimax optimality. We prove this conjecture over all infinite deterministic search sequences and show that the proposed sequence and its box-label reversal are the only minimizers. The proof uses a lower bound on the remaining expected time after a finite prefix. At the first departure from the proposed sequence, the postponed box alone forces the total expected time strictly above the proposed value. The argument also gives an explicit penalty for the first departure and a finite-prefix guarantee for nearly optimal sequences. The candidate sequence and its value are due to Bui, Lidbetter, and Lin; the contribution developed here is their global optimality proof and the stated uniqueness and quantitative consequences.

## 1. Model, scope, and the precise claim

Fix an integer $m\geq3$, and write

$$
 r=\frac1m,\qquad q=1-r,\qquad k=m-1,\qquad Q=\frac1q=\frac{m}{m-1}.
$$

A target occupies one fixed box $i\in\{1,2\}$. A search takes one unit of time. A search of the occupied box succeeds with probability $q$, independently of previous searches; a search of the other box cannot succeed. Searching ends at the first detection. Searches do not move the target, change detection probabilities, or yield any observation other than success or failure.

A deterministic strategy is represented by an infinite word

$$
 \xi=(\xi_0,\xi_1,\ldots)\in\{1,2\}^{\mathbb N}.
$$

The index starts at zero: $\xi_n$ is the box searched during the $(n+1)$-st unit of time. Let $T_i(\xi)$ be the detection time when the target occupies box $i$, and define

$$
 U_i(\xi)=\mathbb E[T_i(\xi)]\in[0,\infty],\qquad
 J(\xi)=\max\{U_1(\xi),U_2(\xi)\}.
$$

The objective is to minimize $J$ over deterministic strategies. A deterministic policy that uses its complete observed history is included: until detection, every observed result is a failure, so its actions along the sole continuing history form one definite infinite word. Conversely, every infinite word specifies such a policy. Randomization is excluded from this optimization and is used only as a comparison in Section 7.

Let $a^k$ denote a block of $k$ copies of a symbol $a$, and let $w^\infty$ denote indefinite repetition of a finite word $w$. Define

$$
 \xi^*=12\,(2^k1^k)^\infty.
$$

This is the candidate in Conjecture 21 of the arXiv version of Bui, Lidbetter, and Lin [BLL, Section 5.2]. Their equal-search-time setting is normalized here to unit cost. The candidate and the formula below were already stated in that source; neither is presented as a discovery of this note. For any common search duration $t>0$, all expected times below are simply multiplied by $t$.

The proof mechanism has a precedent in [BLL, Section 5.1]: the discussion following Theorem 18 excludes departures from a particular sequence in an unequal-cost setting, and Lemma 19 forces initial choices by geometric-sum bounds. We do not claim first-departure reasoning as a new method. The contribution here is a uniform remaining-cost inequality that resolves their distinct Conjecture 21 over its entire stated integer parameter family, together with uniqueness and explicit departure penalties.

**Theorem 1 (global optimality and uniqueness).** For every integer $m\geq3$,

$$
 \min_{\xi\in\{1,2\}^{\mathbb N}} J(\xi)
 = V_m
 :=2+\frac1{m-1}
       +\frac{m-1}{m\bigl(m^{m-1}-1\bigr)}.
 \tag{1}
$$

Both conditional expected times of $\xi^*$ equal $V_m$. The only minimizing words are $\xi^*$ and the word obtained by exchanging the two box labels. Equivalently, the value in (1) is

$$
 V_m=2+\frac1m+
 \frac{m^{m-2}+m-2}{(m-1)(m^{m-1}-1)},
 \tag{2}
$$

which is the formula in the conjecture.

The theorem concerns all infinite deterministic words, including nonperiodic words. It does not assume that the two conditional expected times of a competitor are equal, that a competitor has finite memory, or that it is a best response to any prior distribution. It makes no claim for unequal search durations, unequal detection probabilities, or general detection probabilities outside $q=1-1/m$.

## 2. Prefix decomposition and an unavoidable delay

For a word $\xi$, define the number of searches of box $i$ before time $n$ by

$$
 N_i(n;\xi)=\#\{0\leq s<n:\xi_s=i\}.
$$

Independence of the detection trials gives

$$
 \mathbb P(T_i(\xi)>n)=r^{N_i(n;\xi)}.
$$

Indeed, detection has failed after the first $n$ searches exactly when all searches of the occupied box among them have failed. Since $T_i$ is positive integer valued, with the possibility $T_i=\infty$, the nonnegative tail-sum identity gives

$$
 U_i(\xi)=\sum_{n=0}^{\infty}r^{N_i(n;\xi)}.
 \tag{3}
$$

This identity remains valid when the sum diverges. It follows, for example, by writing $T_i=\sum_{n\geq0}\mathbf 1_{\{T_i>n\}}$ and applying monotone convergence. If a word searches one box only finitely many times, the corresponding count is eventually constant and the sum in (3) diverges; such words are therefore automatically covered and cannot be minimizers.

For a prefix of length $n$, put

$$
 P_i(n;\xi)=\sum_{s=0}^{n-1}r^{N_i(s;\xi)},
$$

and let $\sigma_n\xi=(\xi_n,\xi_{n+1},\ldots)$ be the suffix, regarded as a fresh word. Splitting (3) at $n$ gives the exact identity

$$
 U_i(\xi)=P_i(n;\xi)+r^{N_i(n;\xi)}U_i(\sigma_n\xi).
 \tag{4}
$$

All terms are nonnegative, so this identity also holds in the extended nonnegative reals.

**Lemma 2 (remaining-time bound).** For any infinite word $\eta$ and any box $i$,

$$
 U_i(\eta)\geq Q.
 \tag{5}
$$

If the first search of $\eta$ is of the other box, then

$$
 U_i(\eta)\geq 1+Q.
 \tag{6}
$$

**Proof.** By time $s$, at most $s$ searches of box $i$ have occurred. Since $0<r<1$, formula (3) gives

$$
 U_i(\eta)\geq\sum_{s=0}^{\infty}r^s
 =\frac1{1-r}=Q.
$$

If the first search is of the other box, its cost is one and it cannot detect a target in box $i$. The suffix after this search has conditional expected time at least $Q$, giving (6). The lower bound permits the suffix to search box $i$ exclusively; it remains a valid bound even though that suffix would perform badly against the other hiding location. $\square$

**Lemma 3 (first departure).** Suppose a reference word $\zeta$ satisfies $U_i(\zeta)=V<\infty$ for a particular box $i$. Let another word $\xi$ agree with $\zeta$ in positions $0,\ldots,n-1$, but let $\zeta_n=i$ and $\xi_n\ne i$. If

$$
 C_i(n):=U_i(\sigma_n\zeta)<1+Q,
$$

then

$$
 U_i(\xi)\geq V+
 r^{N_i(n;\zeta)}\bigl(1+Q-C_i(n)\bigr)>V.
 \tag{7}
$$

**Proof.** The common prefix gives the same $P_i$ and $N_i$ in (4) for both words. The suffix of $\xi$ begins by searching the other box, so its expected time against box $i$ is at least $1+Q$ by Lemma 2. Subtracting the finite identity for $\zeta$ proves (7). If $U_i(\xi)=\infty$, the asserted inequality is immediate. $\square$

This lemma is only a sufficient condition for excluding a departure. The proof below checks the condition at every position at which a departure from the proposed word could first occur.

## 3. Exact evaluation of the candidate

Set

$$
 s=r^k,\qquad
 A=Q+\frac{k}{1-s},\qquad
 B=Q+\frac{ks}{1-s}.
 \tag{8}
$$

Consider the repeating suffix $\omega=(2^k1^k)^\infty$. For box 1, its first $k$ searches all miss the occupied box, contributing $k$. The following $k$ searches of box 1 contribute $\sum_{j=0}^{k-1}r^j$. After a complete cycle, each box has been searched $k$ times. Thus direct summation by cycles gives

$$
 U_1(\omega)
 =\frac{k+\sum_{j=0}^{k-1}r^j}{1-r^k}
 =\frac{k}{1-s}+Q=A.
 \tag{9}
$$

For box 2, the first $k$ searches contribute $\sum_{j=0}^{k-1}r^j$. The next $k$ searches contribute $kr^k$. Hence

$$
 U_2(\omega)
 =\frac{\sum_{j=0}^{k-1}r^j+kr^k}{1-r^k}
 =Q+\frac{ks}{1-s}=B.
 \tag{10}
$$

These geometric series converge because $0<s<1$. In particular,

$$
 A-B=k.
 \tag{11}
$$

Adding the initial word $12$ yields

$$
 U_1(\xi^*)=1+r+rA,
 \qquad U_2(\xi^*)=2+rB.
 \tag{12}
$$

Their difference is

$$
 (1+r+rA)-(2+rB)=-1+r(1+k)=-1+rm=0.
$$

The equality uses the exact relation $r=1/m$ and $k=m-1$. Both payoffs therefore equal $2+rB$. Since

$$
 \delta:=\frac{ks}{1-s}
 =\frac{m-1}{m^{m-1}-1},\qquad B=Q+\delta,
 \tag{13}
$$

we obtain

$$
 2+rB=2+\frac1{m-1}
 +\frac{m-1}{m(m^{m-1}-1)}=V_m.
$$

Finally, subtracting $2+1/m$ and putting the remaining terms over a common denominator transforms (1) into (2). This verifies the attainment part of Theorem 1 without using an optimization argument.

## 4. Every first departure is strictly worse

We compute the candidate's remaining expected time for the box it is about to search. At its second position, after the first search of box 1, this box is box 2. No search of box 2 has yet occurred, so (4) gives

$$
 C_2(1)=V_m-1.
$$

The margin in Lemma 3 is

$$
 1+Q-C_2(1)=2+Q-V_m=1-r\delta>0.
 \tag{14}
$$

Here $0<\delta<1$: the inequality follows from
$m^{m-1}-1>m-1$ for $m\geq3$. Thus a word starting with box 1 cannot search box 1 again in its second position and have both expected times at most $V_m$.

Now consider a block of $k$ searches of box 2 within the periodic suffix. At the beginning of this block, the pair of remaining expected times is $(A,B)$. After $j$ of its searches, where $0\leq j\leq k$, the remaining payoff against box 1 is $A-j$, since those $j$ searches cannot detect a target in box 1. Against box 2 the remaining payoff $C_j$ satisfies

$$
 B=\sum_{\ell=0}^{j-1}r^\ell+r^jC_j,
$$

and consequently

$$
 C_j=r^{-j}\left(B-Q(1-r^j)\right)
 =Q+m^j\delta.
 \tag{15}
$$

In particular, for each position at which another search of box 2 is prescribed, $0\leq j\leq k-1=m-2$, the relevant margin is

$$
 1+Q-C_j=1-m^j\delta
 \geq1-m^{m-2}\delta
 =\frac{m^{m-2}-1}{m^{m-1}-1}
 =:\gamma_m>0.
 \tag{16}
$$

The strict positivity follows from $m\geq3$, which implies $m^{m-2}>1$. After all $k$ searches of box 2, the pair becomes $(B,A)$, because

$$
 A-k=B,\qquad Q+m^k\delta=Q+\delta+k=A.
$$

The following block of $k$ searches of box 1 has exactly the same analysis with the labels exchanged. Every subsequent cycle repeats these suffixes. Therefore (16) holds at every position of the periodic suffix for the box the candidate is about to search.

**Proof of Theorem 1.** Let $\xi$ be any infinite word. Exchange the labels of both boxes, if necessary, so that $\xi_0=1$; this leaves $J$ unchanged. If $\xi=\xi^*$, Section 3 gives $J(\xi)=V_m$. Otherwise, the set of indices where the two words differ is a nonempty subset of $\mathbb N$, so it has a least element $n$. Since the first symbols agree, $n\geq1$.

If $n=1$, the strict margin is given by (14). If $n\geq2$, the position belongs to one of the periodic blocks, and the strict margin is given by (16). In either case, apply Lemma 3 to the box searched by $\xi^*$ at position $n$. Its complete expected payoff under $\xi^*$ is $V_m$, and a first departure raises the payoff against that box strictly above $V_m$. Therefore $J(\xi)>V_m$.

It follows that $\xi^*$ is the only minimizer starting with box 1. By label symmetry its reversal is the only minimizer starting with box 2, proving all assertions. $\square$

The proof does not infer an infinite result from a finite enumeration. The finite calculation of the block suffixes applies at every cycle, while the least differing index exists for every unequal pair of infinite words.

## 5. Quantitative departure bounds

The preceding proof gives a stronger conclusion than strict inequality. Relabel a competing word to start with box 1, and let $n\geq1$ be its first departure from $\xi^*$. Let $i=\xi_n^*$, and let $a=N_i(n;\xi^*)$.

If $n=1$, then $a=0$ and

$$
 J(\xi)-V_m\geq1-r\delta.
 \tag{17}
$$

If $n\geq2$, let $j\in\{0,\ldots,m-2\}$ be the number of searches already completed in the current block. Then

$$
 J(\xi)-V_m\geq
 r^a\bigl(1-m^j\delta\bigr)
 \geq r^a\gamma_m.
 \tag{18}
$$

These are lower bounds on the loss of any continuation after the departure; they do not assert that the bound is attained. Since $a\leq n$, and since $1-r\delta>\gamma_m$, both cases imply

$$
 J(\xi)-V_m\geq\gamma_m r^n.
 \tag{19}
$$

**Corollary 4 (nearly optimal prefixes).** Let $L\geq2$ be an integer. If

$$
 J(\xi)\leq V_m+\varepsilon,
 \qquad 0\leq\varepsilon<\gamma_m r^{L-1},
 \tag{20}
$$

then, after possibly exchanging box labels, the first $L$ symbols of $\xi$ agree with $\xi^*$.

**Proof.** A first departure among these symbols would have $1\leq n\leq L-1$, so (19) would imply
$J(\xi)-V_m\geq\gamma_m r^n\geq\gamma_m r^{L-1}>\varepsilon$. $\square$

Uniqueness does not imply a uniform positive separation from all other words. To see this directly, exchange an adjacent pair of unlike symbols far out in the candidate and leave all later symbols unchanged. The counts of both boxes coincide again after the exchanged pair. Formula (3) then shows that one conditional expected time increases by $(1-r)r^a$, and the other decreases by $(1-r)r^b$, where $a,b$ are their respective counts before the pair. Choosing pairs farther along the periodic suffix sends both counts to infinity and the increase to zero. Thus the location-dependent factor in (18) is necessary for any meaningful quantitative statement of this kind.

## 6. The first nontrivial case

For $m=3$,

$$
 q=\frac23,\quad r=\frac13,\quad Q=\frac32,
 \quad\delta=\frac14,\quad\gamma_3=\frac14,
 \quad V_3=\frac{31}{12}.
$$

The minimizing word is

$$
 12(2211)^\infty.
$$

After the initial $12$, its pair of remaining expected times cycles through four states:

| Remaining payoffs $(C_1,C_2)$ | Prescribed search | Payoff for the prescribed box | Margin below $1+Q=5/2$ |
| --- | --- | --- | --- |
| $(15/4,7/4)$ | 2 | $7/4$ | $3/4$ |
| $(11/4,9/4)$ | 2 | $9/4$ | $1/4$ |
| $(7/4,15/4)$ | 1 | $7/4$ | $3/4$ |
| $(9/4,11/4)$ | 1 | $9/4$ | $1/4$ |

At each state, searching the other box would make the prescribed box's remaining expected time at least $5/2$. The initial second search has the larger margin $11/12$. This table illustrates the general argument; the proof for arbitrary $m$ is supplied by (14)–(16).

## 7. The established mixed-strategy benchmark

Theorem 5 of [BLL], specialized to two boxes of unit search duration, gives the unrestricted mixed-strategy value

$$
 M_m=\frac2q-\frac12=\frac32+\frac2{m-1}.
 \tag{21}
$$

For completeness, an elementary verification in this symmetric setting follows. Hide in each box with probability $1/2$. After $n$ searches, the expected survival probability against any deterministic word is

$$
 \frac12\left(r^{N_1(n)}+r^{N_2(n)}\right),
 \qquad N_1(n)+N_2(n)=n.
$$

For two nonnegative integer exponents with fixed sum, this expression is minimized when the exponents differ by at most one. Indeed, if $a<b-1$, then

$$
 r^a+r^b-r^{a+1}-r^{b-1}
 =(1-r)(r^a-r^{b-1})\geq0.
$$

Balancing repeatedly proves the claim. Summing the resulting lower bound over even and odd times gives

$$
 \frac{U_1(\xi)+U_2(\xi)}2
 \geq\sum_{h=0}^{\infty}
 \left(r^h+\frac{r^h+r^{h+1}}2\right)
 =\frac{3+r}{2(1-r)}
 =\frac2q-\frac12.
$$

The same lower bound holds after averaging over any randomized strategy. Conversely, choose with probability $1/2$ each of the two words $(12)^\infty$ and $(21)^\infty$. Their conditional payoffs are exchanged by the label swap, and each word attains the displayed average bound; the mixture therefore attains it against either box. This proves (21), while preserving its attribution as an established result.

Combining the established mixed value with Theorem 1 gives the exact additive cost of restricting the Searcher to a deterministic strategy:

$$
 V_m-M_m
 =\frac12-\frac1{m-1}
 +\frac{m-1}{m(m^{m-1}-1)}.
 \tag{22}
$$

This difference is positive for every $m\geq3$: for $m=3$, it equals $1/12$, and for $m\geq4$, its first two terms already have positive sum. For example, $m=4$ gives $V_4=197/84$, $M_4=13/6$, and gap $5/28$.

Since

$$
 0<\frac{m-1}{m(m^{m-1}-1)}<m^{1-m}
 \qquad(m\geq3),
$$

the large-$m$ limits are

$$
 V_m\longrightarrow2,\qquad
 M_m\longrightarrow\frac32,\qquad
 V_m-M_m\longrightarrow\frac12,\qquad
 \frac{V_m}{M_m}\longrightarrow\frac43.
$$

More precisely, (22) equals $1/2-1/(m-1)+O(m^{1-m})$. These consequences describe the reciprocal-integer family studied here; they are not an optimization result for all detection probabilities.

## 8. Boundaries and verification scope

The proof needs only the nonnegative tail-sum formula, a geometric series, and explicit inequalities. No computational enumeration, numerical optimization, or unproved statement about optimal strategies is used in the mathematical argument. Rational certificates can check sample values and state transitions, but such checks are illustrations and error checks, not the reason the theorem holds for every integer $m\geq3$.

At $m=2$, the strict margin $\gamma_m$ vanishes. That case is outside the uniqueness assertion and cannot be inserted into the proof by continuity. Similarly, the cancellation in (12) relies on $r(k+1)=1$; keeping the same block length while changing $q$ does not preserve the equal-payoff calculation. These are substantive scope restrictions.

This note resolves the explicitly normalized, equal-cost statement of Conjecture 21 in the cited arXiv version. A publication-facing priority statement should be based on a separately recorded literature audit and should be limited to that audit's coverage. No claim of external peer review or machine-checked coverage is made in this derivation note.

## Reference

[BLL] Thuy Bui, Thomas Lidbetter, and Kyle Y. Lin. *Optimal pure strategies for a discrete search game*. European Journal of Operational Research **313**(2), 767–775 (2024). DOI: [10.1016/j.ejor.2023.08.041](https://doi.org/10.1016/j.ejor.2023.08.041). Public preprint: [arXiv:2306.10908v1](https://arxiv.org/abs/2306.10908v1), submitted 19 June 2023; [full text](https://arxiv.org/pdf/2306.10908). Conjecture 21 and its surrounding equal-time assumptions are in Section 5.2, printed page 23 of the preprint; the mixed-strategy benchmark is Theorem 5.
