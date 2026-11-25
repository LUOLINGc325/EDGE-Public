---
title: Exact binary deletion-ball intersections with a growing alternating middle
lang: en
---

## Abstract

The two earlier finite counterexamples to Wang–Fang–Li–Fu’s deletion intersection conjecture share one template. This template gives an exact excess over the proposed value at every fixed deletion number $t\ge5$ and sufficiently large odd length. We prove a general binomial formula for two binary words with a growing alternating middle and fixed ends. Only a finite table of boundary choices is needed for the counterexample family, at every deletion radius. The argument also shows why adding a common alternating prefix to the two finite counterexamples does not propagate them.

## 1. Definitions and results

Let $D_t(x)$ be the distinct length-$|x|-t$ subsequences of a binary word $x$. For equal-length words put $d_L(x,y)=|x|-\operatorname{LCS}(x,y)$. Write $N(n,3,t)$ for the maximum of $|D_t(x)\cap D_t(y)|$ over length-$n$ words with $d_L(x,y)\ge3$. Wang–Fang–Li–Fu v2, Theorem 6 and §V, prove the lower bound $N(n,3,t)\ge M(n,t)$ and ask whether equality holds for every $t\ge5$ and $n\ge t+8$. Here

$$
\begin{aligned}
M(n,t)={}&6D(n-6,t-3)+4D(n-8,t-3)+6D(n-9,t-3)\\
 &+4D(n-11,t-3)+2D(n-13,t-5)+D(n-13,t-6),
\end{aligned}
$$

where $D(m,r)=\sum_{i=0}^r\binom{m-r}{i}$ for $0\le r\le m$, and zero otherwise. For any nonnegative integer $q$, use $\binom{q}{j}=0$ unless $0\le j\le q$.

**Theorem 1.** For $k\ge4$ let $x_k=(01)^k00110$ and $y_k=10011(01)^k$, so $n=2k+5$. Then $d_L(x_k,y_k)=3$. Whenever $m=n-t-11\ge0$, their intersection has excess

$$
\begin{aligned}
|D_t(x_k)\cap D_t(y_k)|-M(n,t)
&=2\binom{m}{t-5}+7\binom{m}{t-6}+10\binom{m}{t-7}+7\binom{m}{t-8}+2\binom{m}{t-9}\\
&=2\binom{m+2}{t-5}+3\binom{m+2}{t-6}+2\binom{m+2}{t-7}.
\end{aligned}
\tag{1}
$$

Within the formula’s domain $n-t-11\ge0$, the excess in (1) is positive for $t\ge5$ if and only if $n\ge\max(t+11,2t+2)$. Thus $N(n,3,t)>M(n,t)$ for every such odd $n$. For fixed $t\ge5$, the exact excess of these witnesses is asymptotic to $2n^{t-5}/(t-5)!$. At $t=5$ it is 2 at all odd $n\ge17$ and at the earlier $n=15$ example. At $t=6$ it is $2n-27$ for every odd $n\ge17$. We compute the exact intersection of this family. The exact extremal value $N(n,3,t)$ for $t\ge5$ remains open.

## 2. The alternating middle

For a finite binary word $z$ and an output prefix $w$, the leftmost embedding selects the earliest occurrence of each successive letter after the previous selected position. If any embedding exists, the leftmost one exists, and its final index is no larger than that of any other embedding. This follows by induction on the letters of $w$. Thus the leftmost process decides membership without counting a word twice, and continuation of $w$ is possible exactly when it embeds in the suffix beyond the leftmost endpoint.

Consider two templates

$$
X_k=P_x(b_x\overline b_x)^kQ_x,\qquad Y_k=P_y(b_y\overline b_y)^kQ_y,
$$

where the four binary ends and the two starting bits are fixed, and $|P_x|+|Q_x|=|P_y|+|Q_y|=c$. Let $A=\max(|P_x|,|P_y|)$, $B=\min(|P_x|,|P_y|)$ and $q=c-B$. The common length is $2k+c$. Define a boundary table $a_h$ for $h\ge0$ as follows.

1. Range over all binary words $w$ of length $A+1$. Greedily match $w$ in each fixed prefix followed by an unbounded alternating sequence of its prescribed phase. If $A+1+d_x$ and $A+1+d_y$ are the numbers of input letters consumed, retain this word only if $d_x,d_y\le h$.
2. For each side $\nu\in\{x,y\}$ let $S_{\nu,h}$ be the alternating string of length $|P_\nu|-B+h$ ending with $\overline b_\nu$, followed by $Q_\nu$. Use the empty alternating string if this length is zero. Drop the first $d_\nu$ symbols of $S_{\nu,h}$. Count the binary words $z$ of length $q$ that embed in both remaining strings. Add this count to $a_h$ for each retained $w$.

The table involves only the fixed ends, the prescribed phase and $h$.

**Theorem 2.** With $m=2k+B-t-A-1\ge0$, the common deletion count is

$$
 |D_t(X_k)\cap D_t(Y_k)|=\sum_{h=0}^t a_h\binom{m}{t-h}.
\tag{2}
$$

In particular, at fixed $t$ it is a polynomial in $k$ for every $k$ in this domain.

**Proof.** After $i$ output letters, the next input positions are $i+d_x$ and $i+d_y$ in zero-based indexing. The two offsets never decrease, so an embedding for $2k+c-t$ outputs cannot exceed the budget $t$ at any point. Through the first $A+1$ symbols, the leftmost process using the infinite prefixes in the table agrees with the actual leftmost process on every retained prefix. Indeed each matched zero-based position is at most $A+t\le2k+B-1$. This upper bound is smaller than the end of each alternating middle. Discarding prefixes that overspend is necessary even with the true suffixes, whose positions come later.

For the output at position $i=A$, both current input positions are already in the alternating middles. The same holds for each of the next $m$ outputs, up to and excluding $i_*=2k+B-t$. At every such step any permitted match position is before $2k+B$. The two bits at the current cursors are the fixed phases plus $i+d_x$ and $i+d_y$ modulo two. If they differ, either output bit forces exactly one of the cursors to skip one symbol, so after that step the predicted bits for the next output coincide. If they agree, matching the predicted bit advances without skips, and matching its opposite requires skipping one symbol in **both** inputs. These two moves preserve agreement at the next step. In either case, the first step at $i=A$ ensures agreement on all retained prefixes. Whenever a skip exceeds one of the budgets it is simply infeasible.

Fix an output prefix $w$ as in the boundary table but initially with budget $t$. For any $j$, a subset of $j$ among the $m$ remaining middle positions uniquely determines the middle output by specifying where both sides skip a symbol. Conversely the current leftmost positions determine the predicted bit, so different such subsets yield different middle words. Because skips are monotone, the whole middle word is feasible precisely if $d_x+j,d_y+j\le t$. At its end the next offsets are $d_x+j,d_y+j$. At the reference location $i_*$, each input’s tail is $S_{\nu,t}$. Dropping $d_\nu+j$ symbols from $S_{\nu,t}$ is exactly dropping $d_\nu$ after shortening the initial alternating suffix by $j$. The latter suffix is $S_{\nu,t-j}$, because the end phase is fixed and the length is shortened on its left. There are exactly $q$ still-required output symbols. Thus, for the $\binom mj$ position sets, summing the suffix count over admissible $w$ gives $a_{t-j}$. Concatenating prefix, middle and suffix is injective at their prescribed lengths. Summation proves (2). $\square$

For each $h$, computing $a_h$ only requires the membership decisions for the $2^{A+1+q}$ pairs of boundary words. The computation may depend exponentially on the fixed ends. It does not grow with $k$. For a given pair of templates, $a_h$ eventually equals $2^{A+1+q}$, since each fixed prefix match consumes finitely many symbols and as $h$ increases each tail available beyond the consumed offsets contains an arbitrarily long alternating run. The earliest matching offsets for the prefix are independent of $h$. Together with (2), this also gives exact degrees: for fixed $t$, if $d$ is the least $h$ with $a_h>0$ and $t\ge d$, the polynomial degree is $t-d$ with leading term $a_d(2k)^{t-d}/(t-d)!$. For $t<d$ it is identically zero in the stated domain.

## 3. Exact boundary table for the two seeds

Here $A=5,B=0,c=5$, $m=2k-t-6=n-t-11$. Both alternating middles start at 0 and end at 1. For $a_h$ the first six output symbols are greedily matched in $0101\cdots$ and $100110101\cdots$. For the remaining five symbols the suffix strings are the length-$h$ alternating string ending in 1 followed by $00110$, and the length-$(h+5)$ alternating string ending in 1. In both strings discard their respective leftmost offsets from the first part.

For exact reproducibility, the entries may be computed by trying all 64 six-letter words followed by the 32 five-letter words. For a trial string $v_1\cdots v_l$ in a string $s$, start a cursor at zero. For each $v_i$ move the cursor to one past its first occurrence at or after the current cursor. Absence rejects. In the first part enforce cursor minus six at most $h$ for both strings; in the second part start from the resulting offsets. The infinite first-part input can be truncated past position $6+h$ without changing a decision. This is a finite arithmetic specification of the table:

| $h$ | $a_h$ | $\mu_h$ | $a_h-\mu_h$ |
| ---: | ---: | ---: | ---: |
| 0 | 0 | 0 | 0 |
| 1 | 0 | 0 | 0 |
| 2 | 0 | 0 | 0 |
| 3 | 20 | 20 | 0 |
| 4 | 134 | 134 | 0 |
| 5 | 438 | 436 | 2 |
| 6 | 930 | 923 | 7 |
| 7 | 1453 | 1443 | 10 |
| 8 | 1824 | 1817 | 7 |
| 9 | 1995 | 1993 | 2 |
| 10 | 2042 | 2042 | 0 |
| 11 | 2048 | 2048 | 0 |
| 12 | 2048 | 2048 | 0 |

For $h\ge11$, the last two base rows suffice. On replacing $h$ by $h+2$, admissible first-part offsets remain admissible and each second-part string, after the same offset, contains the earlier second-part string as a suffix. Thus $a_{h+2}\ge a_h$ and the ceiling is $2^{11}=2048$. It follows that $a_h=2048$ for all $h\ge11$.

For comparison, let $S_d(b)=\sum_{i=0}^{b}\binom di$, zero if $b<0$. For $m\ge0$, the six terms of $M$ all fit Vandermonde's identity. For instance $n-6-(t-3)=m+8$ and $\sum_{i=0}^{t-3}\binom{m+8}{i}=\sum_{h=0}^t\binom{m}{t-h} S_8(h-3)$. The same rearrangement gives

$$
\begin{aligned}
\mu_h&=6S_8(h-3)+4S_6(h-3)+6S_5(h-3)+4S_3(h-3)+2S_3(h-5)+S_4(h-6),\\
M(n,t)&=\sum_{h=0}^t\mu_h\binom m{t-h}.
\end{aligned}
$$

Here $\mu_h=2048$ for all $h\ge11$ since all six partial sums are complete. Subtracting the table in (2) gives the first line of (1). Factoring $2+7z+10z^2+7z^3+2z^4=(1+z)^2(2+3z+2z^2)$ gives the second. For $t=2$ theorem 2 applies at every $k\ge4$ and the intersection is empty by the table. At $t=3$ it gives 20 for every $k\ge5$; direct leftmost matching for $k=4$ also gives 20. This proves the distance claim, since an intersection at any smaller deletion radius would imply one at radius two. For $t\ge5$ and $m\ge0$, a term on the first line of (1) is positive exactly when one of $5,\ldots,9$ lies in $[t-m,t]$. This is equivalent to $m\ge\max(0,t-9)$. The threshold characterizes this specific witness in the domain of (1). For fixed $t$, only the first term has degree $t-5$ in $n$, with its stated leading coefficient. The old $n=13,15$ witnesses are $k=4,5$ and $t=5$; their previously certified excesses are 1 and 2. The uniform formula is not needed for these two boundary evaluations.

## 4. Why extending both words by the same prefix fails

Take either old pair $x,y$. Fix a final bit and prepend the length-$s$ alternating word $A_s$ ending at that bit to both words. Let $C_s(t)$ denote the new intersection count. For $s\ge2$, split the common output strings according to their first bit. If it is the common first bit, both earliest matches take the first input symbol. Otherwise both take the second input symbol. This gives

$$
C_s(t)=C_{s-1}(t)+C_{s-2}(t-1).
$$

The six terms giving $M$ satisfy the same length/radius recurrence, by Pascal's identity in the stated range. Write $E_s(t)=C_s(t)-M(|x|+s,t)$. For the old length-13 pair, $(E_0(3),E_0(4),E_0(5))=(0,0,1)$, while the two values for a common one-symbol prefix are $(0,-10,-29)$ for 0 and $(0,-10,-23)$ for 1. The length-15 values are $(0,0,2)$ and $(0,-10,-48),(0,-10,-42)$. The distance remains three under common prefixing, by repeatedly matching the common first symbol when computing an LCS. Thus $E_s(2)=0$, $E_s(3)=0$ and $E_s(4)=-10$ for all $s\ge1$. At radius five, the excess is negative from $s=1$ onward. In the family of Theorem 1, the long alternating parts instead grow between different fixed ends in the two words.

## 5. Scope relative to surrounding results

Wang–Fang–Li–Fu §II (2)–(3) already give the single alternating word’s binomial count and recurrence. Their §III Propositions 7–8 use Gabrys–Yaakobi’s decomposition by output prefixes and suffixes, using the earliest and latest embeddings. Their Lemma 9 and Theorem 11 analyze a **different** alternating-core pair and prove its intersection is exactly $M(n,t)$. The contribution here is the synchronized skip rule for two arbitrary fixed-end alternating templates, its budget-independent boundary coefficients, and the strict exact difference for the two old seeds’ growing family. Neither earliest matching nor Vandermonde is new. Elzinga–Rahmann–Wang §5 gives dynamic programming for counting common subsequences of general words. Here the periodic middle gives an exact binomial convolution once the end data are fixed. [Wang et al. v2](https://arxiv.org/html/2601.06503v2) · [Gabrys–Yaakobi, Lemmas 1–2](https://doi.org/10.1109/TIT.2018.2800044) · [Elzinga–Rahmann–Wang](https://doi.org/10.1016/j.tcs.2008.08.035)

Pham–Goyal–Kiah, author version v1 Theorem 3 and Eq. (5), give $N(n,d,t)=\binom{2d}{d} n^{t-d}/(t-d)!-O(n^{t-d-1})$ for fixed $d,t$ as $n$ grows. Their Corollary 6 gives the exact value for $d=t$ at sufficiently large $n$. Equation (1) identifies the excess over $M$ at degree $t-5$, below the known leading degree $t-3$ at distance three. Their separate Eq. (8) conjectures a recurrence for the maximum $N$ itself and is outside this comparison. Sun–Ge give a general finite upper bound and other estimates under run-count assumptions, which also leave the exact excess over $M$ undetermined. [Pham–Goyal–Kiah, Theorem 3](https://arxiv.org/pdf/2111.04255v1) · [Sun–Ge v1](https://arxiv.org/abs/2606.25822)

The original two witnesses are retained in the fixed public article. The conjecture compared here is the one in the authors’ open 32-page v2. The full Table 1 in the expanded 2025 JCTA article and the full six-page ISIT 2026 version by Wang et al. were unavailable for direct comparison. The exact optimum $N(n,3,t)$ at $t\ge5$ and a corresponding even-length family remain open here. Earlier two witnesses · [2025 JCTA article](https://doi.org/10.1016/j.jcta.2024.105980) · [ISIT 2026 record](https://doi.org/10.1109/ISIT62367.2026.11653635)

## 6. Reproduction

The Python 3 checker enumerates the boundary words and compares the binomial formula with a complete-word subsequence count on 403 parameter pairs for the counterexample template and 384 settings for other templates. It checks 254 positive excesses in the stated range, the four one-symbol-prefix initial values, and the earlier exact counts by independent subsequence sets. Run `python3 evidence/verify_exact.py` from this manuscript directory. [Reproduction instructions](evidence/README.md) · [Exact checker](evidence/verify_exact.py) · [Recorded output](evidence/results.json)
