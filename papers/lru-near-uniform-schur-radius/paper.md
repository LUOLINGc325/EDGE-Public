# The exact majorization radius of stationary LRU caching

## Abstract

For an independent reference model with positive request probabilities, the stationary hit rate of a least-recently-used cache can move in either direction under majorization. We determine exactly the largest max-to-min ratio on which every majorization comparison goes in the monotone direction. The result holds for every finite catalog and every cache capacity. In the nontrivial cases the radius is a unique root of a scalar rational equation. Two equally popular items and an equiprobable background determine the threshold. The proof shows that neither a heterogeneous background nor a finite spread of the focal pair can first violate monotonicity. The radius increases strictly with catalog size at fixed nontrivial capacity and decreases strictly with nontrivial capacity at fixed catalog size.

## Guide for readers

Imagine moving some request probability from a less popular item to a more popular one while holding their combined probability fixed. Two request laws can be compared by combining such transfers and relabeling the items. The maximum-to-minimum request ratio measures how uneven the resulting catalog is. For four items and a three-slot cache, the exact threshold is about 7.52003. Within the threshold, making one law more unequal in this sense raises the stationary hit rate. Above it, some transfers lower the hit rate.

The proof first tracks only two chosen items, conditioning on when the remaining items enter the cache. It then compares the effect of a transfer across all possible backgrounds. Sections 3 and 4 establish the comparison and its sign, and Section 5 gives the matching example and a way to compute the threshold with rational arithmetic.

## 1. Statement and relation to earlier results

Let $p$ be a positive probability vector on $N\ge2$ labels. Requests are independent over time with law $p$, and a cache of size $m$ holds the $m$ most recently requested distinct labels. Let $H_m(p)$ be the stationary hit probability. For $R\ge1$, let $\mathcal D_R$ be the set of positive probability vectors satisfying $\max_i p_i / \min_i p_i\le R$. Write $p\succeq p'$ if the sums of the $j$ largest coordinates of $p$ are at least the corresponding sums for $p'$ for every $j$. Both total sums are one. Define $R_{N,m}$ as the supremum of $R$ for which $H_m(p)\ge H_m(p')$ whenever $p,p'\in\mathcal D_R$ and $p\succeq p'$.

**Theorem 1.** If $3\le m\lt N$, put $q=m-1$ and $L=N-m-1$. Define, for $r\ge1$,

$$
 P_r=\prod_{j=1}^{q}\frac{L+j}{L+j+r},\qquad
 A_r=\sum_{j=1}^{q}\frac{1}{L+j+r},\qquad
 B_r=\sum_{j=1}^{q}\frac{1}{(L+j+r)^2}.
$$

The exact global Schur-convexity radius $R_{N,m}$ is the unique root in $(1,\infty)$ of

$$
 K_{L,q}(r)=2-(r-1)(A_r+B_r/A_r)
             +\frac{2P_{2r}}{(L+2r)A_rP_r}=0.                 \tag{1}
$$

$H_m$ is strictly Schur-convex on $\mathcal D_{R_{N,m}}$, in the sense that every ordered pair of nonpermutation vectors has strict inequality. For any $R>R_{N,m}$, there is a strict reverse comparison wholly within $\mathcal D_R$ using two focal rates and all other rates equal to one before normalization. The same radius is the largest $R$ on which every infinitesimal equal-pair spread has nonnegative curvature. For $m=1,2\lt N$, $R_{N,m}=\infty$ and the monotonicity is strict. For $m=N$ the hit rate is identically one and the radius is infinite.

Fill and Holst studied the stationary search cost of move-to-front. Under independent requests, the probability that the next search rank exceeds $m$ is $1-H_m(p)$. Hildebrand disproved the conjecture that these tails are Schur-concave for arbitrary $p$. Long's Theorem 2.1 establishes strict monotonicity along rays from the uniform law. A ray need not pass through two given majorization-ordered points and the radial result gives no sharp ratio domain. Equation (1) gives the curvature threshold for a pair of equal rates against a uniform background. The comparison below makes its root exact for all majorization directions and all finite sizes.

For comparison on the same cache model, Jelenković's Theorem 3 gives a heavy-tail law for the limiting search cost, and Theorem 6 treats light tails in the fluid limit. Our threshold concerns finite catalogs, independent requests and unit-size items. The unrestricted two-slot case is already known from Hildebrand's Theorem 1 and the successive-sampling formulation of Kochar and Korwar's Theorem 2.4.

There is a cutoff convention worth making explicit. The accessible author version of Hildebrand's Theorem 1 treats a zero-based search rank and includes the cutoff $c=3$ in its Schur-concavity assertion. The journal abstract describes the broader counterexample. Theorem 3 of the author version establishes the uniform extremum. For the author version's three-slot assertion, take normalized rates $(8,8,1,1)/18$ and $(9,7,1,1)/18$. The second vector majorizes the first. For four items the probability of a miss at capacity three is the probability that the next requested item has the last exponential clock. If its rate is $w_i$ and $W=\sum_iw_i$, independence and inclusion–exclusion give

\[
 H_3=1-\sum_i\frac{w_i}{W}\sum_{J\subseteq [4]\setminus\{i\}}(-1)^{|J|}
      \frac{w_i}{w_i+\sum_{j\in J}w_j}.
\]

The two hit rates are $6401/6885$ and $375521/403920$, respectively, a decrease of $13/1211760$. In the author version's appendix, the terms for a focal item in the first two ranks are included once in the probability but recur in each group indexed by a nonfocal item. The direct computation above uses each such event once. The two-slot statement is unaffected and also follows from Kochar and Korwar's successive-sampling theorem.

## 2. Conditional pair formula

The order of backward distinct requests is successive sampling without replacement with probabilities proportional to the remaining $p_i$. To see this, expose the independent infinite past until the next unseen label appears. Conditional on the set already seen, the first unseen label has the law $p$ restricted and renormalized to its complement. The same successive order is generated by independent exponential clocks with rates $w_i$ proportional to $p_i$, by memorylessness. Write $F_m(w)$ for the expected sum of the rates of the first $m$ clocks. Then $H_m(p)=F_m(w)/\sum_i w_i$.

Fix two focal rates $a=h+\delta$ and $b=h-\delta$, with $a>b\ge1$. Scale was chosen so the smallest of all rates is one. There are $N-2$ other clocks. Let $U$ be their $q$th arrival time, $c$ its rate, and $V$ the next other arrival time ($V=\infty$ if there is none). The first $q-1$ other items are always selected. Given the other times, the focal item of rate $a$ is selected with probability

$$1-e^{-aU}+\frac{a}{a+b}\bigl(e^{-(a+b)U}-e^{-(a+b)V}\bigr).$$

The item at $U$ is selected unless both focal clocks precede $U$. A finite item at $V$ is selected exactly when both focal clocks follow $V$. Thus, differentiating the conditional expected sum with respect to $\delta$ at fixed $h$, and dividing by $a-b$, gives

$$
 \frac{1}{a-b}\int_b^a e^{-kU}\{2U+(c-k)U^2\}\,dk
       +\frac{1}{h}(e^{-2hU}-e^{-2hV}).                        \tag{2}
$$

For example, the first integrand is the derivative with respect to $k$ of $[-1-(c-k)U]e^{-kU}$. The last term follows by differentiating the coefficient $(a^2+b^2)/(a+b)$ of $e^{-2hU}-e^{-2hV}$. Differentiation can be interchanged with expectation: the finite sampling formula is rational for positive rates, and the conditional derivatives are dominated locally by polynomial factors times decaying exponentials.

Now condition on the full arrival-label order of the other clocks. Let $\lambda_j$ be the remaining total rate before arrival $j$ and $J=\lambda_{q+1}$, with $J=0$ if there is no next clock. For $1\le j\le q$, $\lambda_j\ge J+q+1-j$ and $J\ge L$. Indeed, each removed item has rate at least one and there are $L$ remaining other items just after $U$. The first $q$ interarrival times are independent exponentials of rates $\lambda_j$, and any gap after $U$ is independent exponential of rate $J$. This joint law follows by expressing the order-and-spacing density as the product of residual exponential survival factors and the rate of each arriving label.

Let $M_i(k)=\mathbb E[U^i e^{-kU}]$ under this conditional law and write $P(k)=M_0(k)$, $A(k)=\sum_j(\lambda_j+k)^{-1}$, $B(k)=\sum_j(\lambda_j+k)^{-2}$ and $C(k)=\sum_j(\lambda_j+k)^{-3}$. The conditional expectation in (2) is

$$
 \frac{1}{a-b}\int_b^a[2M_1(k)-(k-c)M_2(k)]\,dk
          +\frac{2P(2h)}{J+2h}.                                \tag{3}
$$

The convention $J=0$ gives the same formula when $V=\infty$.

## 3. A uniform comparison for finite spreads

Repeated differentiation of $P(k)=\prod_j \lambda_j/(\lambda_j+k)$ gives $M_1=PA$, $M_2=P(A^2+B)$ and $M_3=P(A^3+3AB+2C)$. If $X(k)=\max_j(\lambda_j+k)^{-1}$, then $B\le XA$ and $C\le XB$. Hence

$$ \frac{M_3(k)}{M_2(k)}\le A(k)+2X(k)
      \le A_k+\frac{2}{L+1+k}.                                  \tag{4}$$

For $q\ge2$ let $r_*>1$ solve

$$ (r_*-1)\left(A_{r_*}+\frac{2}{L+1+r_*}\right)=3.              \tag{5}$$

The left side is strictly increasing, with endpoint values zero and $q+2$, because it is a sum of terms $(r-1)/(d+r)$ with $d>0$. For $q=1$ set $r_*=\infty$ and the left side is strictly less than three for every finite $r$. For $1\le k\lt r_*$, the derivative of $f(k)=2M_1(k)-(k-1)M_2(k)$ is $-3M_2(k)+(k-1)M_3(k)\lt 0$ by (4). Also $c\ge1$. If $a\le r_*$ and $a>b$, the integral mean in (3) is strictly larger than $f(a)$. Since $h\le a$ and $P$ decreases, the last term is bounded below by $2P(2a)/(J+2a)$.

Dividing the resulting comparison by $P(a)A(a)>0$ gives

$$
 \frac{\mathbb E[\partial_\delta F_m\mid\text{other order}]}
      {(a-b)P(a)A(a)}
 > 2-(a-1)[A(a)+B(a)/A(a)]
    +\frac{2P(2a)}{(J+2a)P(a)A(a)}.                            \tag{6}
$$

Here the conditional derivative means the derivative of the rate-sum expectation given the other order. For positive coordinates $x_j$, the function $T(x)=\sum_jx_j+\sum_jx_j^2/\sum_jx_j$ is increasing in each coordinate. Its derivative is $1+2x_j/S-(\sum_i x_i^2)/S^2>0$ for $S=\sum_i x_i$. Using $\lambda_j\ge L+q+1-j$, the negative term on the right of (6) is at least $-(a-1)(A_a+B_a/A_a)$.

For the positive term in (6), first keep $J$ fixed. Increasing a $\lambda_j$ decreases $A(a)$ and increases the product $P(2a)/P(a)=\prod_j(\lambda_j+a)/(\lambda_j+2a)$. Therefore that term is at least

$$
 D(J)=\frac{2}{(J+2a)\sum_{j=1}^q(J+j+a)^{-1}}
                  \prod_{j=1}^q\frac{J+j+a}{J+j+2a}.
$$

$D(J)$ increases in $J\ge0$. In fact the derivative of $\log D(J)$ is the sum of

$$
 \sum_{j=1}^q[(J+j+a)^{-1}-(J+j+2a)^{-1}]
 \quad\text{and}\quad
 \frac{\sum_j(J+j+a)^{-2}}{\sum_j(J+j+a)^{-1}}-\frac1{J+2a}.
$$

Since $a\ge1$, the first sum is at least the telescoping sum $(J+1+a)^{-1}-(J+q+1+a)^{-1}$. The ratio in the second expression is at least $(J+q+a)^{-1}$ as a weighted mean. Finally $(J+1+a)^{-1}\ge(J+2a)^{-1}$. Together these inequalities give strict positivity. It follows that $D(J)\ge D(L)$, the positive term in (1). Thus the right side of (6) is bounded below by $K_{L,q}(a)$ for every other order.

## 4. The threshold is reached inside the derivative comparison

As a function of $r\ge1$, $K_{L,q}$ is strictly decreasing. Its negative term is $-T(y)$ with $y_j=(r-1)/(L+j+r)$, strictly increasing in $r$. In the positive term the product $P_{2r}/P_r$ decreases and the denominator $(L+2r)A_r=\sum_j (L+2r)/(L+j+r)$ increases, since the derivative of each summand is $(L+2j)/(L+j+r)^2$. Also $K_{L,q}(1)>0$ and $K_{L,q}(\infty)=1-q+2^{-q}/q\lt 0$ if $q\ge2$. There is exactly one root $r_0>1$. We show $K_{L,q}(r_*)\lt 0$, hence $r_0\lt r_*$.

At $r=r_*$ write $t=r-1$, $x_j=(L+j+r)^{-1}$, $y_j=t x_j$, $y=y_1$ and $S=\sum_j y_j=3-2y$. The relations $x_1=(1-y)/(L+2)$ and $L+2r=(1+y)/x_1$ follow directly. Equation (1) gives

$$
 -S K_{L,q}(r)=(S-2)S+\sum_j y_j^2
          -\frac{2y}{(1+y)\prod_j(1+y_j+x_j)}.                 \tag{7}
$$

To verify positivity, first suppose $q\ge3$. Because $x_1\le(1-y)/2$ and $y_j=y/(1+(j-1)x_1)$, $y$ must be less than $2/3$. Otherwise $S+2y\ge 3y+y/(1+(1-y)/2)+y/(2-y)\ge 43/14>3$. If $y\le1/2$, the first two terms of (7) have sum at least $3-8y+5y^2\ge1/4$, and the last positive quantity being subtracted is at most $2y/[(1+y)(1+S)]\le 2/9$. If $1/2\le y\lt 2/3$, then $y_2\ge4y/5$ and $y_3\ge2y/3$, so $\sum_j y_j^2\ge2y^2$. Now the first two terms have sum at least $3-8y+6y^2\ge1/3$ and the subtracted term is at most $2y/[(1+y)(1+S)]\le3/10$. The product bounds here use $\prod_j(1+y_j+x_j)\ge1+S$.

If $q=2$, let $z=y_2=3-3y$. Since $z\le y$ and $z\ge y/(1+(1-y)/2)$, one has $3/4\le y\le(7-\sqrt{22})/3\lt 77/100$. Put $u=4y-3\in[0,2/25]$. Substituting $x_1=y/z-1$ and $x_2=1-z/y$ into (7) gives

$$
 (S-2)S+y^2+z^2=\frac38-\frac54u+\frac78u^2\ge\frac{1403}{5000},
$$

$$
 \frac{2y}{(1+y)(1+y+x_1)(1+z+x_2)}
 =
 \frac{96(3+u)^2(1-u)}{(7+u)(21-2u-3u^2)(21+14u-3u^2)}
 \le\frac{96}{343}.
$$

For the second bound, $(3+u)^2(1-u)\le9$ and the last two denominator factors have product $441+u(252-154u-36u^2+9u^3)\ge441$ on the given interval. Since $1403/5000>96/343$, (7) is positive also for $q=2$. This proves $r_0\lt r_*$.

## 5. Schur-convexity, sharpness and consequences

Take any vector in $\mathcal D_{r_0}$ and use a fixed scaling to minimum rate one at the point of differentiation. For every unequal pair, $a\le r_0\lt r_*$ and $K_{L,q}(a)\ge0$. Equations (3)–(6) give a strictly positive derivative in the increasing-spread direction at fixed sum. The normalizing sum is constant along this direction. Pair averaging and permutations generate majorization of vectors with fixed sum. Pair averaging cannot enlarge the largest coordinate or decrease the smallest, so the entire comparison stays in $\mathcal D_{r_0}$. A nontrivial averaging step integrates a strict sign on its unequal interior. This proves strict Schur-convexity. For $q=1$, the same derivative argument holds for every $a$ because $r_*=\infty$ and $K_{L,1}(a)$ is positive: even dropping its positive last term gives $2-2(a-1)/(L+1+a)>0$. For $m=1$, $H_1(p)=\sum_j p_j^2$ is strictly Schur-convex.

For the converse choose $r\in(r_0,R)$ and take $N-2$ other rates equal to one, with $a=b=r$. Letting $\delta\to0$ in (3) gives the second derivative of $F_m$ along the spread, equal to $2P_r A_r K_{L,q}(r)\lt 0$. Normalize the two rates $r\pm\delta$ together with the $N-2$ ones. For sufficiently small positive $\delta$, the max-to-min ratio is $r+\delta\lt R$, the vector majorizes the tied vector, and the hit rate strictly decreases. The same construction gives the upper bound for the curvature radius. Conversely, at a tie $r\le r_0$, (3) in the limit and the two normalized comparisons in (6) give nonnegative curvature for every background. This completes Theorem 1.

**Corollary 2 (changing the catalog and capacity).** For fixed $m\ge3$, $R_{N,m}$ increases strictly with $N$ for $N>m$. For fixed $N$, $R_{N,m}$ decreases strictly over $3\le m\lt N$. Therefore for $N\ge4$ the common domain guaranteeing the stationary search-rank order at every cutoff has radius $R_{N,N-1}$.

For the first assertion increase $L$ at fixed $q$. The negative term in (1) increases because each $y_j$ decreases, and $D(L)$ increases by the comparison in Section 3. For the second, increase $q$ by one and decrease $L$ by one, preserving $N$. This appends one coordinate to $T(y)$, increasing it for $r>1$. The positive term is multiplied by

$$
 \frac{L+r}{L-1+2r}\cdot
 \frac{A_r}{A_r+(L+r)^{-1}}\lt 1\qquad(r\ge1,\ L\ge1).
$$

Each root comparison now follows from strict monotonicity in $r$. The cutoff statement uses $\mathbb P(\text{next rank}>m)=1-H_m(p)$ and Theorem 1 at the largest nontrivial capacity.

**Corollary 3 (finite certificates).** The radius can be enclosed to any rational absolute tolerance by bisection with rational sign tests in (1). An initial interval is

$$ 1\lt r_0\lt 1+3(L+q+1)/(q-1). $$

Indeed at its right endpoint each $y_j$ is at least $3/(q+2)$, so (5)'s left side is at least three. Each sign evaluation uses $O(q)$ rational operations. Any rational $r\in(r_0,R)$ can also produce a strict rational witness. Test successive halving of a positive rational spread within $\min(r-1,R-r)$. Its eventual success follows from the strictly negative curvature. For these witness vectors (3) and the conditional selected-mass formula give rational expressions using the homogeneous-background products. The procedure need not estimate derivatives numerically.

The formula also recovers the fixed-capacity asymptotics. For fixed $q\ge2$ and $N\to\infty$, substitute $r=Nx$ on compact positive $x$-intervals. The products and sums in (1) give the limiting sign of $2-(q-1)x+\frac{2}{q}(1+x)^{q+2}/(1+2x)^{q+1}$ after multiplication by $1+x$. The limiting normalized expression has a unique positive root: the negative term $-(q+1)x/(1+x)$ strictly decreases and the positive term $\frac2q((1+x)/(1+2x))^{q+1}$ strictly decreases. Monotonicity and bracketing at two nearby fixed $x$ show $R_{N,m}/N$ converges to that root. This transfers the previous local fixed-capacity coefficient to the exact global radius.

For growing capacity, $(R_{N,m}-1)A_1\to2$ as $q\to\infty$, uniformly in $L\ge0$. To see this put $t=r_0-1$. The inequalities
$$
 A_{1+t}\ge\frac{A_1}{1+t/(L+2)},\qquad
 \frac{B_{1+t}}{A_{1+t}^2}
 \le\frac{1}{(L+2+t)A_{1+t}}
 \le\frac{1}{(L+2)A_1}
$$
follow termwise. The last term of (1) is bounded above by $2/((L+2)A_1)$ because $P_{2r_0}\le P_{r_0}$ and $L+2r_0\ge L+2+t$. Also
$(L+2)A_1\ge 2\sum_{j=1}^q 1/(j+1)\to\infty$ uniformly in $L$, since $(L+2)/(L+j+1)$ is nondecreasing in $L$. Equation (1) yields $tA_{1+t}\to2$ uniformly. The same quantity is at least $(L+2)A_1\,[t/(L+2)]/[1+t/(L+2)]$, so $t/(L+2)\to0$ uniformly. Thus $A_{1+t}/A_1\to1$, proving the stated limit.

## References

- J. A. Fill and L. Holst, On the distribution of search cost for the move-to-front rule, *Random Structures & Algorithms* 8(3), 179–186 (1996). [DOI](https://doi.org/10.1002/%28SICI%291098-2418%28199605%298%3A3%3C179%3A%3AAID-RSA2%3E3.0.CO%3B2-V).
- M. Hildebrand, On a conjecture of Fill and Holst involving the move-to-front rule and cache faults, *Probability in the Engineering and Informational Sciences* 13(3) (1999). [DOI](https://doi.org/10.1017/S0269964899133084) · [Author version, 2 November 1998](https://citeseerx.ist.psu.edu/document?doi=2899d05c8f4d9864e15ea31c5313156db2d0529c&repid=rep1&type=pdf).
- P. R. Jelenković, Asymptotic approximation of the move-to-front search cost distribution and least-recently used caching fault probabilities, *The Annals of Applied Probability* 9(2), 430–464 (1999). [DOI](https://doi.org/10.1214/aoap/1029962750) · [Full text](https://www.ee.columbia.edu/~predrag/mypub/LRU_AAP99.pdf).
- C. D. Long, Radial extremality for LRU caching and the Fill–Holst conjecture, arXiv:2605.26107v1 (2026). [Preprint](https://arxiv.org/abs/2605.26107v1).
- S. C. Kochar and R. Korwar, On random sampling without replacement from a finite population, *Annals of the Institute of Statistical Mathematics* 53, 631–646 (2001). [DOI](https://doi.org/10.1023/A:1014693702392).
