# Exact fixed-channel design for robust Chinese remaindering

## Finite optimizer windows, effective capacity quasipolynomials, and five- and six-channel certificates

**Author:** Wen Weixiang (文韦翔)  
**Project:** `6f8b9d647500f24028c6`  
**Date:** 25 November 2026  
**Status of this document:** research manuscript; written mathematics and subsequent Lean verification are separate deliveries. No Lean proof or kernel verification is claimed here.

## Abstract

We study the common-scale, pairwise-coprime modulus-design problem used in robust Chinese remaindering: minimize the largest of $L$ integer base moduli while requiring the product of the other $L-1$ bases to exceed a prescribed threshold. We prove that, for each fixed number of channels, exact optimization reduces to a finite window whose length is independent of the numerical dynamic range. The resulting algorithm is fixed-parameter tractable in $L$ for binary-encoded inputs. The entire capacity frontier is eventually a quasipolynomial, with an explicit period bound, a uniform stabilization threshold, and an eventual description of every maximizing offset pattern. For five channels, six successive possible largest bases and a window of twenty smaller positions suffice; for six channels, nine possible largest bases and thirty-nine smaller positions suffice. These give respective raw candidate bounds of $29\,070$ and $5\,181\,813$, before any pruning, for every input threshold. Analytical constructions and elementary polynomial inequalities prove the window bounds. Exact integer programs provide reproducible optimal designs and certificates. The result optimizes the standard certified radius within the specified common-scale design family; it is not a converse for arbitrary moduli or decoders.

## 1. Problem, prior work, and the precise contribution

For $L\ge2$ channels, a positive hardware cap $H$, and a positive target range $N$, consider moduli $m_i=m a_i$, where

$$
2\le a_1<a_2<\cdots<a_L,\qquad a_i\in\mathbb Z,\qquad
\gcd(a_i,a_j)=1\quad(i\ne j),\qquad m>0.
$$

The constraints are $ma_L\le H$ and $m\prod_{i=1}^L a_i\ge N$. The standard common-scale robust CRT guarantee supplies the sufficient strict noise condition $|e_i|<m/4$ [Wang–Xia 2010]. Thus the design objective considered here is to maximize $m$, or equivalently the supremal radius $m/4$ certified by that guarantee. We do not claim reconstruction at the boundary $|e_i|=m/4$.

Yan et al. [2026, inspected author preprint, Section III, equations (9)–(14)] formulate this same problem, give exact constructions for $L=2,3,4$, and discuss heuristic augmentation for $L=5,6$. Their published metadata are verified from the authors' institutional record; the technical text actually inspected is arXiv:2511.22757v1. We have not checked every statement of the final publisher PDF. The present manuscript extends the exact optimization to every fixed $L$, and gives small explicit search bounds for five and six channels. The preprint's informal description of general optimization difficulty is not a complexity lower bound, and our fixed-parameter result does not establish polynomial complexity when $L$ varies.

Several ingredients have prior mathematical precedents. Erdős–Sárközy [1993] study uniformly located coprime subsets in intervals. A 2018 original discussion by Paseman and Meyerowitz explicitly considers bounded nearby coprime sets and the periodicity of coprimality in translated windows for a different, fixed-sum extremal problem. OEIS A179661 records the maximum LCM of a fixed number of integers under an upper bound. These are acknowledged background, not inventions of this manuscript. Our capacity multiplies the smallest $L-1$ entries while requiring an additional strictly larger coprime entry, a condition absent from that LCM problem.

Xiao–Xiao [2017] also discuss optimal modulus selection. The publisher abstract and section previews available in this study concern product lower bounds required by reconstruction under specified error tolerances. Their full text was not obtained. Consequently novelty is limited to the inspected sources; we do not assert a theorem-by-theorem exclusion of that inaccessible text or universal priority.

The specific contributions are the localization of **every capacity maximizer**, the exact inverse-design algorithm with binary-input complexity, the effective eventual structure of the full capacity frontier, and the five- and six-channel analytic certificates. No large general CRT conjecture, unrestricted decoder optimum, or layered-decoding optimum is being claimed.

## 2. Definitions and reduction to an integer problem

Put $d=L-1$. For an integer $M\ge0$, define the finite family

$$
\mathcal A_L(M)=\{(a_1,\ldots,a_L): 2\le a_1<\cdots<a_L\le M,
\ \gcd(a_i,a_j)=1\ (i<j)\}.
$$

**Definition D1 (capacity and inverse threshold).** Set

$$
C_L(M)=\begin{cases}
\max_{a\in\mathcal A_L(M)}\prod_{i=1}^{d}a_i,&\mathcal A_L(M)\ne\varnothing,\\
0,&\mathcal A_L(M)=\varnothing,
\end{cases}
\qquad
G_L(R)=\min\{M\ge0:C_L(M)\ge R\},
$$

for a positive integer $R$. Existence of the latter minimum follows from Lemma L1 below. The maximum defining $C_L(M)$ does **not** require $a_L=M$.

**Proposition P1 (exact design reduction).** Let $\rho=N/H>0$ and $R=\lceil\rho\rceil$. The maximum common scale is

$$
m^*=\frac{H}{G_L(R)},\qquad \tau_{\mathrm{cert}}^*=\frac{H}{4G_L(R)}.
$$

For a fixed tuple, increasing $m$ to $H/a_L$ respects the hardware cap and cannot damage the range constraint. At this value the range is $H\prod_{i=1}^{d}a_i$, so feasibility is equivalent to $\prod_{i=1}^{d}a_i\ge\rho$, equivalently $\ge R$ since the product is an integer. Minimizing $a_L$ is therefore exactly the stated problem. Attainment of $m^*$ follows from an attaining integer tuple; the noise guarantee remains strict below $\tau_{\mathrm{cert}}^*$.

**Lemma L0 (elementary boundaries).** The function $C_L(M)$ is nondecreasing in $M$. If $p_L$ is the $L$th prime, then $\mathcal A_L(M)$ is empty for $M<p_L$, and is nonempty at $M=p_L$. In particular,

$$
G_L(R)=p_L\quad\text{if}\quad 1\le R\le\prod_{i=1}^{L-1}p_i.
$$

Monotonicity is set inclusion. Choose a prime divisor of every tuple entry. Pairwise coprimality makes those divisors distinct, and each is at most $M$, proving the empty-set assertion. The tuple of the first $L$ primes proves the other assertions. The sufficient range in the last display is not asserted to be the full constant region of $G_L$.

## 3. A uniform window for every number of channels

Define

$$
P=\prod_{p\le d,\ p\text{ prime}}p,
\qquad D=LP-1,\qquad W=dD.
$$

The empty product is $P=1$ when $L=2$.

**Lemma L1 (a coprime progression).** If $s\ge2$ and $\gcd(s,P)=1$, the $L$ integers $s,s+P,\ldots,s+dP$ are pairwise coprime.

Indeed, a prime $q$ dividing two entries divides $(j-i)P$. If $q$ divides $P$, it cannot divide $s$. Otherwise it divides $j-i$, and $q\le d$ implies $q\mid P$, the same contradiction. This also covers $P=1$: two consecutive integers are coprime. Choosing arbitrarily large $s\equiv1\pmod P$ proves that every positive threshold is feasible.

**Theorem T1 (uniform capacity localization).** Whenever $\mathcal A_L(M)$ is nonempty, every tuple attaining $C_L(M)$ has

$$
a_1\ge M-W.
$$

Thus the capacity is exactly computable using only the integers in $[\max(2,M-W),M]$, for every integer $M\ge0$.

For $M\ge D+2$, take the largest $s\le M-dP$ congruent to $1$ modulo $P$. The consecutive admissible values of $s$ differ by $P$, so $s\ge M-dP-(P-1)=M-D\ge2$. Lemma L1 gives an admissible tuple, and hence

$$
C_L(M)\ge(M-D)^d.
$$

For a maximizing tuple, all factors other than $a_1$ are at most $M$, whence

$$
a_1M^{d-1}\ge C_L(M)\ge M^d(1-D/M)^d\ge M^d-dDM^{d-1}.
$$

The final inequality is Bernoulli's inequality for the integer exponent $d$ and $0\le D/M\le1$. Division by $M^{d-1}>0$ proves $a_1\ge M-dD$. If $M<D+2$, then $M\le D+1\le W+1$, so $a_1\ge2>M-W$ directly. Empty families retain capacity zero and require no maximizer. This proves all small and degenerate cases as well.

**Lemma L2 (a bounded interval of possible optimum thresholds).** Put

$$
f_d(n)=\prod_{j=0}^{d-1}(n-j),\qquad
b=\min\{n\ge\max(2,d): f_d(n)\ge R\}.
$$

Then

$$
b+1\le G_L(R)\le b+D.
$$

In any feasible tuple, $a_d\ge\max(2,d)$ and the product of the first $d$ entries is at most $f_d(a_d)$. Since $f_d$ is increasing for integers $n\ge d$, this implies $a_d\ge b$, hence $a_L\ge b+1$. For the upper bound choose the least $s\ge b$ congruent to $1$ modulo $P$. It obeys $s\le b+P-1$ and $s\ge2$. The progression of Lemma L1 has its first $d$ entries at least $b$, and therefore their product is at least $b^d\ge f_d(b)\ge R$. Its last entry is at most $b+D$.

The lower limit $\max(2,d)$ in the definition of $b$ is necessary to cover $L=2,R=1$ without introducing the forbidden base $1$.

**Lemma L3 (why a search may fix the largest entry).** At $M=G_L(R)$, every capacity-maximizing tuple has largest entry exactly $M$. Otherwise that tuple is feasible at $M-1$, contradicting minimality. This statement is only about the first feasible threshold; it need not hold for a general capacity evaluation.

**Theorem T2 (exact fixed-parameter algorithm).** Compute $b$ by exact doubling and bisection. For $M=b+1,\ldots,b+D$, in order, enumerate $d$ smaller entries from $[\max(2,M-W),M-1]$, append $M$, and check pairwise coprimality and product at least $R$. Return the first successful tuple. This algorithm returns $G_L(R)$ and an optimal design.

Any accepted tuple is feasible, so the algorithm cannot return a value smaller than the optimum. Lemmas L2 and L3 and Theorem T1 guarantee that, at the true optimum, an accepted tuple lies among the candidates. The candidate count is at most

$$
D\binom{W}{d}.
$$

This is an upper bound on complete candidate tuples, not on bit operations. Use arbitrary-precision integers for products, comparisons, and gcd computations; no floating-point root is needed. Since $P\le d!$, one may absorb all dependence on $L$ into a function

$$
F(L)=\exp(O(L^2\log(L+1))).
$$

For binary input integer $R$, with $B=\operatorname{bitlength}(R)$, exact doubling/bisection takes $O(B+\log(L+1))$ iterations, because $f_d(R+d)\ge R$. All tested integers have bit length at most $O(B+\log(L+1)+\log(D+1))$. Schoolbook multiplication, division and Euclidean gcd therefore give, after enlarging $F$, a bit-operation upper bound $F(L)(B+1)^3$. The polynomial exponent does not depend on $L$. For an input rational $u/v>0$, first compute $R=(u+v-1)\mathbin{//}v$ and include the bit lengths of both $u$ and $v$ in the input size. This is a fixed-parameter tractability statement, not a practical bound for unrestricted $L$.

## 4. Effective eventual structure of the whole capacity frontier

Let

$$
Q=\prod_{p\le W,\ p\text{ prime}}p,\qquad
K=(1+W)^d,\qquad T=\max(W+2,2K+2).
$$

For $r\in\{0,\ldots,Q-1\}$, let $\mathcal E_r$ be all increasing offset vectors

$$
0\le e_0<e_1<\cdots<e_d\le W
$$

such that $\gcd(r-e_i,e_j-e_i)=1$ for every $i<j$. Gcd on signed integers uses absolute values. Define

$$
p_e(X)=\prod_{i=1}^{d}(X-e_i).
$$

The factor for $e_0$ is intentionally omitted: $M-e_0$ is the largest base.

**Lemma L4 (finite residue representation).** For $M\ge W+2$ and $M\equiv r\pmod Q$,

$$
C_L(M)=\max_{e\in\mathcal E_r}p_e(M),
$$

and every maximizing tuple is obtained from a maximizing offset vector by reversing $(M-e_0,\ldots,M-e_d)$.

For distinct offsets, $\gcd(M-e_i,M-e_j)=\gcd(M-e_i,e_j-e_i)$. Every prime dividing a positive difference is at most $W$, so the coprimality test depends only on $M\bmod Q$. At $M\ge W+2$ all corresponding entries are at least two. Theorem T1 supplies every capacity maximizer in this window, proving the exact representation. Each $\mathcal E_r$ is nonempty: choose an arbitrarily large $M$ in its residue class and apply Lemma L1 and Theorem T1.

**Lemma L5 (uniform polynomial ordering).** List the coefficients of a monic degree-$d$ polynomial in descending degree after its leading coefficient. For any two different polynomials $p_e,p_{e'}$, their ordering at every real $X>1+2K$ is the lexicographic ordering of these coefficient lists.

Each absolute coefficient is bounded by $\binom dk W^k\le K$. The difference of two distinct polynomials has a nonzero integer leading coefficient, of absolute value at least one, while all its other coefficients have absolute values at most $2K$. For a polynomial difference $a_mX^m+\cdots+a_0$ and $X>1+2K$, the absolute contribution of the lower terms is at most

$$
2K\sum_{j=0}^{m-1}X^j
=2K\frac{X^m-1}{X-1}<X^m\le |a_m|X^m.
$$

Thus its sign is that of its leading coefficient. Constant differences have the same property directly. This proof needs no asymptotic root approximation.

**Theorem T3 (effective eventual quasipolynomial and optimizer patterns).** For each residue $r$, choose the lexicographically largest coefficient list among $\{p_e:e\in\mathcal E_r\}$, and call its polynomial $q_r$. For every integer $M\ge T$,

$$
C_L(M)=q_{M\bmod Q}(M).
$$

Each $q_r$ is a monic degree-$d$ integer polynomial. Moreover the complete set of maximizing offsets at such $M$ consists exactly of the $e\in\mathcal E_r$ whose polynomial equals $q_r$ identically. Thus a fixed lexicographic tie-break on offset vectors gives an eventually periodic optimal offset rule.

This follows from Lemmas L4 and L5. Identical polynomials may arise from different choices of $e_0$, and all such feasible offsets must be retained when describing every maximizer. The period $Q$ is a valid bound, not asserted minimal. The stabilization threshold $T$ is explicit and deliberately conservative. Enumerating every residue can be much more expensive than answering one query with Theorem T2. We do not claim that the inverse function $G_L(R)$ is a quasipolynomial in $R$.

**Corollary C1 (capacity approximation and bounded inverse excess).** For $M\ge D+2$,

$$
(M-D)^d\le C_L(M)\le\prod_{j=1}^{d}(M-j)\le M^d.
$$

Consequently $C_L(M)/M^d\to1$ for fixed $L$, and Lemma L2 bounds the excess of the exact inverse threshold over its falling-factorial lower estimate by $D$. The bounds follow respectively from Lemma L1, strict ordering, and the fact that every factor is at most $M$. These asymptotic consequences are auxiliary, not the sole novelty claim.

## 5. Five channels: twenty smaller positions and six thresholds

**Lemma L6 (five-base construction).** For $s\ge5$ and $s\equiv1$ or $5\pmod6$, the tuple

$$
(s,s+2,s+3,s+4,s+6)
$$

is pairwise coprime. The four odd entries have differences $2,4,6$. A possible odd common prime must be $3$, and the pair at distance six consists of $s,s+6$, neither divisible by three. The even entry $s+3$ has differences $3,1,1,3$ from the odd entries and is not divisible by three. This proves all pairwise tests.

**Theorem T4 (five-channel capacity window).** For every $M\ge11$, every tuple attaining $C_5(M)$ lies in $[\max(2,M-20),M]$.

Take the largest $s\le M-6$ in the two indicated residue classes. It exists with $s\ge5$ and $M-9\le s\le M-6$, since their consecutive gaps are at most four. Lemma L6 gives

$$
C_5(M)\ge (M-9)(M-7)(M-6)(M-5).
$$

If a maximizing tuple had $a_1\le M-21$, then, when that antecedent is possible, $M\ge23$ and

$$
C_5(M)\le (M-21)(M-3)(M-2)(M-1).
$$

The lower expression minus the upper expression equals

$$
132M^2-936M+1764.
$$

Its leading coefficient is positive and its discriminant is $-55\,296<0$, so the difference is strictly positive for every real $M$, a contradiction. For $M<23$ the assumed small $a_1$ is impossible directly. For $M<11$ the family is empty by Lemma L0.

**Theorem T5 (five-channel exact search).** If $1\le R\le210$, return $(2,3,5,7,11)$. If $R>210$, compute $b$ of Lemma L2 with $d=4$. Then the exact optimum lies among $b+1,\ldots,b+6$. For each such value $M$, it suffices to append $M$ to four smaller entries from $[\max(2,M-20),M-1]$. There are at most $6\binom{20}{4}=29\,070$ complete candidates in total.

The first branch is Lemma L0. For the second branch, $b\ge6$. Choose the least $s\ge b-3$ with $s\equiv\pm1\pmod6$. Then $5\le s\le b$. The first four entries of Lemma L6 dominate the ordered list $(b-3,b-2,b-1,b)$ coordinatewise. Their product is at least $f_4(b)\ge R$, and the last entry is at most $b+6$. Lemma L2 supplies the lower endpoint. Theorem T4 and Lemma L3 justify the smaller-position enumeration at the actual first feasible $M$. Acceptance at an earlier $M$ would itself be a feasible design, so the first accepted result is exact.

## 6. Six channels: thirty-nine smaller positions and nine thresholds

**Lemma L7 (six-base construction).** Let $s\ge5$ and $s\equiv5\pmod6$. The appropriate one of the following sorted tuples is pairwise coprime:

$$
\begin{cases}
(s,s+2,s+4,s+5,s+6,s+8),&5\nmid s,\\
(s,s+2,s+3,s+4,s+6,s+8),&5\mid s.
\end{cases}
$$

The five odd entries have positive differences among $2,4,6,8$. The only possible odd common prime is three. The pairs with difference six are $(s,s+6)$ and $(s+2,s+8)$, neither pair divisible by three under $s\equiv5\pmod6$. In the first case the added even entry has differences $5,3,1,1,3$. It is not divisible by three; the difference-five pair is coprime because $5\nmid s$. In the second case the differences are $3,1,1,3,5$; the even entry is not divisible by three, and the two entries at difference five are both congruent to three modulo five. All remaining differences are one.

**Theorem T6 (six-channel capacity window).** For every $M\ge13$, every tuple attaining $C_6(M)$ lies in $[\max(2,M-39),M]$.

Take the largest $s\le M-8$ with $s\equiv5\pmod6$. Then $s\ge5$ and $s\ge M-13$. The first construction in Lemma L7 dominates the second in its first five coordinates, yielding

$$
C_6(M)\ge (M-13)(M-11)(M-10)(M-9)(M-7).
$$

If a maximizing tuple had $a_1\le M-40$, the antecedent requires $M\ge42$, and strict ordering would give

$$
C_6(M)\le (M-40)(M-4)(M-3)(M-2)(M-1).
$$

Subtract the upper expression from the lower one and put $t=M-13$. The result is exactly

$$
555t^3+13\,395t^2+111\,870t+320\,760>0\qquad(t\ge0),
$$

a contradiction. The remaining smaller $M$ either cannot satisfy the assumed bound on $a_1$ or have an empty feasible family by Lemma L0.

**Theorem T7 (six-channel exact search).** If $1\le R\le2310$, return $(2,3,5,7,11,13)$. If $R>2310$, compute $b$ of Lemma L2 with $d=5$. The exact optimum is among $b+1,\ldots,b+9$. For each such $M$, enumerate five smaller entries in $[\max(2,M-39),M-1]$ and append $M$. The total raw bound is $9\binom{39}{5}=5\,181\,813$ complete candidates.

For the nontrivial branch, $b\ge7$. Take the least $s\ge b-4$ congruent to five modulo six. It satisfies $s\ge5$ and $s\le b+1$. The first five entries in either construction of Lemma L7 dominate $(b-4,b-3,b-2,b-1,b)$. Their product is at least $f_5(b)\ge R$, and the last entry is at most $b+9$. The lower endpoint and the exactness of the ordered search follow as in Theorem T5, using Theorem T6.

The twenty- and thirty-nine-position bounds are sufficient universal bounds. We do not claim they are the smallest possible windows, nor that the six- and nine-threshold scan lengths are sharp.

## 7. Exact certificates and reproducibility

The accompanying `code/solve.py` implements arbitrary-precision integer evaluation of the five- and six-channel algorithms. For each tested $M$, a certificate records the maximum product over the localized tuples **anchored at $M$**, an attaining witness if such a tuple exists, and search counts. It also records the input rational and its integer ceiling, $b$, the scan interval, and the selected optimal tuple. The small-threshold branch instead uses the distinct-prime-divisor lower certificate of Lemma L0. `results/solver_examples.json` contains actual produced examples; `REPRODUCTION.md` records commands and the independently checked scope.

**Proposition P2 (optimality certificate verification).** For $L=5$ or $6$, let $w$ be respectively $20$ or $39$ and $c$ respectively $6$ or $9$. For an input in the nontrivial branch, suppose a verifier independently recomputes the anchored local maxima for every $M=b+1,\ldots,m-1$, finding each below $R$, and verifies a feasible tuple at $m\le b+c$. Then $m=G_L(R)$.

If a smaller feasible threshold existed, take the least one $M_0$. Theorem T5 or T7 places it in the scanned range. A capacity maximizer at $M_0$ contains $M_0$ by Lemma L3 and lies in the indicated window by Theorem T4 or T6. Its anchored local product would be at least $R$, contradicting the corresponding recomputed entry. The witness at $m$ proves attainability. No assumption that all capacity maxima are anchored at arbitrary $M$ is used.

Pruning in the implementation is limited to logically safe tests: insufficient candidate count, pairwise gcd incompatibility, and a product upper bound obtained by selecting the largest remaining positive candidate values while ignoring compatibility. This relaxed product is an upper bound on every compatible continuation. Mathematical exactness is established by the theorems; timing measurements and a finite comparison suite are additional implementation evidence, not replacements for an all-input proof.

All enumerations use exact integers. Reproduction checks include direct whole-interval combinations for small caps, independent polynomial-coefficient checks of Theorems T4 and T6, and very large thresholds. The checked ranges and outcomes are reported with their actual execution records rather than inferred from the existence of the programs. No claim of a Lean-verified algorithm is made.

## 8. Scope, limitations, and continuation

The general algorithm's constants grow rapidly with $L$. The practical bounds here concern $L=5,6$; no hardware latency guarantee or variable-$L$ polynomial algorithm follows. The capacity quasipolynomial has a conservative period and threshold, and its full residue table has not been materialized. Its analytic existence theorem and finite prescription are independent of that optional computation.

The design result uses distinct integer bases at least two, pairwise coprimality, a shared positive scale, a largest-modulus cap, and the full product dynamic range. It does not cover heterogeneous base noise, unconstrained non-coprime constructions, arbitrary residue decoders, or layered RCRT trade-offs. Those remain separate optimization models.

The written proof and finite computational checks are the evidence supplied for this result.

## References and inspected scope

1. W. Yan, L. Gan, H. Liu and S. Hu. *Moduli Selection in Robust Chinese Remainder Theorem: Closed-Form Solutions and Layered Design*. IEEE Transactions on Information Theory 72(10), 7258–7274 (2026). DOI: https://doi.org/10.1109/TIT.2026.3723974 . Technical source inspected: https://arxiv.org/html/2511.22757v1 . Publication metadata: https://bura.brunel.ac.uk/handle/2438/33905 .
2. W. Wang and X.-G. Xia. *A Closed-Form Robust Chinese Remainder Theorem and Its Performance Analysis*. IEEE Transactions on Signal Processing 58(11), 5655–5666 (2010). DOI: https://doi.org/10.1109/TSP.2010.2066974 . Author PDF: https://www.eecis.udel.edu/~xxia/WJWang_RCRT.pdf . This work supplies the attributed common-scale sufficient reconstruction guarantee; we do not present that guarantee as new.
3. H. Xiao and G. Xiao. *Notes on CRT-based robust frequency estimation*. Signal Processing 133, 13–17 (2017). DOI: https://doi.org/10.1016/j.sigpro.2016.10.013 . Publisher source: https://www.sciencedirect.com/science/article/pii/S0165168416302808 . Abstract and section previews only; full text unavailable during this study.
4. P. Erdős and A. Sárközy. *On sets of coprime integers in intervals*. Hardy–Ramanujan Journal 16, 1–20 (1993). DOI: https://doi.org/10.46298/hrj.1993.126 . Publisher PDF: https://hrj.episciences.org/126/pdf . Used for background attribution; the elementary construction needed here is proved in Lemma L1.
5. S. H., G. Paseman, A. Meyerowitz and contributors. *A generalization of Landau's function*. Original mathematical discussion, November–December 2018. https://mathoverflow.net/questions/314431/a-generalization-of-landaus-function . Related fixed-sum problem; explicitly acknowledged precedent for the nearby-coprime and periodic-window ideas, not a source of an unproved lemma used here.
6. OEIS Foundation. *A179661: maximal LCM of k integers from 1 through n*. https://oeis.org/A179661 . Nearby extremal object, distinct from Definition D1 because of its different objective and absence of a required larger extra base.
