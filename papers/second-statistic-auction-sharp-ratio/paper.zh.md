# 第二高估值信息下的稳健拍卖：完整机制归约、唯一等化轨道与认证比率

## 摘要

卖方知道竞标人数，却只观察第二高估值的分布。竞标者价值独立，但可以非同分布。
原题要求精确确定：单一确定性共同保留价二价拍卖的最佳最坏收入，相对所有允许
随机 DSIC／ex-post IR 机制的真正最优最坏收入，能够保证的全人数、全分布尖锐比例。
该问题由 Tang–Wang arXiv:2602.20429v3 明确提出。

本文给出新的结构定理和全局认证上界。全参数尖锐常数满足

\[
2-\sqrt2\le c_*
\le \frac{1000000000000000}{1646154911812389}
\approx0.607476242257.
\]

左端是 Tang–Wang 的既有普适保证；旧上界 $2/3$ 来自经典两点例与其 $n=2$
最低统计定理的组合。新增右端使用真正稳健最优分母、稀有高值变分归约和 VIII.1 的 $K=24$ 精确有理下证。

二次研究首先证明：对每个 $n\ge2$、$h>1$、$t\in[0,1]$ 的二点观测分布
$G=(1-t)\delta_1+t\delta_h$，完整允许机制空间的最优稳健收入，可精确归约到
只有 $q_2,\ldots,q_n$ 参数的分档机制族。证明先匿名化，再对所有网格报告剖面
给出收入支配，并以精确支持归约处理原模型的隐藏无界边际支持和所有实值偏离。
这不是仅在预设候选机制族中寻找最优。

其次，对次高值取高值的概率为 $1/(2n^2)$、高值为 $\sqrt2\lambda n$ 的原模型实例族，
证明真正稳健最优收入收敛到一个精确的邻接参数变分值 $V(\lambda)$。
普遍机制上界与可实施机制下界匹配，且有限截断误差不超过
$2\lambda/(K+1)$。该族最优尺度为 $\lambda=1/\sqrt2$。
一个 $K=8$ 的全有理上下证书证明

\[
\frac{164615489}{10^8}
\le V(1/\sqrt2)
\le \frac{164615533}{10^8}.
\]

这里的双侧区间刻画该实例族的真正最优稳健基准；它不意味着全局 $c_*$ 也有
$0.607476\ldots$ 的普适下界。原全局下界仍是 $2-\sqrt2$。

此外，保留首轮的完整二点机制保证、有限观测支持的精确连续／有限模型等价、
同质活跃人数对手比较的尖锐障碍，以及注明归属的旧基线。支付恒等式、优先序
与 pooling、匿名化等已有工具不计作新机制思想。另有不依赖优化器的简洁闭式后果
$c_*\le24/(24+\sqrt{239})$；精确有理证书将其进一步收紧。

本文进一步确定了所有正尺度的变分结构。完整机制极限中的最优数列唯一，严格递减且各层等化。仅首层的最大值与最优值相等；其后各层都有松弛。充分高的尾部从任何有限远端反推，误差按阶乘衰减。该结构适用于上文精确归约的稀有高值族。全观测分布的尖锐常数仍在上面的区间内。

## 原始冻结问题

For each known integer n>=2 and each probability distribution G on [0,infinity), let Pi_{2,n}(G) be all product distributions F_1 x ... x F_n of independent, not necessarily identically distributed nonnegative bidder values whose second-highest value has law G. Let M_n be the full class of measurable randomized single-item mechanisms that are dominant-strategy incentive compatible and ex-post individually rational in allocations and payments expected over the mechanism randomness conditional on every report profile. Define R_{2,n}(G)=sup_{M in M_n} inf_{F in Pi_{2,n}(G)} E_F[Rev(M)] and S_{2,n}(G)=sup_{p>=0} inf_{F in Pi_{2,n}(G)} E_F[Rev(SPA with the single common deterministic reserve p)]. Determine exactly c_star=inf_{n>=2,G:0<R_{2,n}(G)<infinity} S_{2,n}(G)/R_{2,n}(G), by proving the sharp universal guarantee and giving a matching admissible distribution family or limiting sequence with rigorously certified robust benchmarks. Keep the original product ambiguity set, unrestricted randomized DSIC/ex-post-IR mechanism class, and maximin revenue denominator; do not replace R by the full-information iid Myerson optimum, restrict to regular G, omit n=2, assume bidders' supports equal the observed statistic's support, or substitute a finite-grid or three-bidder two-point subproblem. Atomic laws, zero-valued dummy bidders, unbounded supports with finite robust value, and nonattainment must be covered or reduced by proof. All existing comparisons, including Tang-Wang's 2-sqrt(2) lower guarantee and the n=2 two-point upper benchmark inherited from classical auction examples, remain attributed baseline results.

问题键为 5a6c5d3def26c7b0ba16；PROBLEM.json 的 SHA-256 为
6742d6dd588fd4fd509c03b0d6ac6dc11779e53b3359b5fb81efc1d4256e932f。
以下在该全局目标下给出可认证界，并精确刻画稀有高值观测族。

## 首轮保留结果的边界

| 内容 | 当前精确含义 |
|---|---|
| 二点机制保证 | 对原模型全部一致独立先验的非渐近下界，包含隐藏边际支持和所有实数报价偏离 |
| 全局比率上界 | 真正 maximin 分母的下界导出 $c_*\le6/(6+\sqrt{14})$ |
| 机制匹配 | 只证明指定机制在所构造序列上的极限最坏收入 |
| 支持归约 | 对每个有限支持 $G$ 精确成立；未证明任意 $G$ 的有限化极限定理 |
| 比较障碍 | 只针对 $\min_m\operatorname{OPT}(F_m^m\times\delta_0)$ 的单独对手包络 |
| 当前仍未完成 | 原全参数尖锐常数及其全局匹配证书、全文 Lean、外部优先权认证；VI 已补齐指定二点族真正稳健最优收入的极限匹配 |


## I. 首轮二点机制保证与较早上界

### 1. Claim and its direction

The first-round bound for the original robust mechanism problem is

\[
c_*\le \frac{6}{6+\sqrt{14}}<\frac23. \tag{B1}
\]

It uses an implementable mechanism's lower guarantee against **every** consistent product prior and an exact numerator from the known Tang--Wang reserve theorem. A full-information optimum is not used as a lower bound on the robust denominator. This does not determine $c_*$ exactly. Together with the attributed universal lower guarantee, the first round narrows the previously known interval to

\[
2-\sqrt2\le c_*\le\frac{6}{6+\sqrt{14}}. \tag{B2}
\]

The legal original instances are

\[
n=h=j,\qquad G_j=(1-t_j)\delta_1+t_j\delta_j,\qquad
t_j=\frac1{2j^2},\quad j\ge3. \tag{B3}
\]

The exact support-reduction proposition identifies the original robust problem for this $G_j$ with its full finite-type problem on $A=\{0,1,h\}$, and extends every normalized finite mechanism to all real reports. Both the proof below and its claims depend on that proposition. Binary support of the observed statistic alone does not justify a binary marginal-support assumption.

### 2. The mechanism and all-real implementation

On reports in $\{0,1,h\}^n$, allocate uniformly among the high bidders when any report $h$; otherwise allocate uniformly among the bidders reporting $1$, if any. Do not allocate on the all-zero profile. Use normalized maximal finite-type payments.

The allocation to a bidder is nondecreasing in its own report at every opponents' profile. The finite payment formula and common floor extension therefore give DSIC/IR for every real true value and real report, as proved in Part II, Proposition 1.

There is also a direct universally truthful implementation: draw a uniformly random priority ordering independently of all bids; treat real bids in $[0,1)$, $[1,h)$ and $[h,\infty)$ as three ordered tiers; allocate to the highest nonempty positive tier using the fixed priority order inside the tier; charge the critical threshold for winning. For each fixed ordering, allocation is monotone and threshold payments give DSIC and IR. Averaging over orderings recovers the conditional allocations and payments below. Thus validity does not require exploiting a distinction between truthful-in-expectation and universally truthful mechanisms.

At a profile with one high bidder and $k$ low positive bidders, the high bidder's expected payment is

\[
h-\frac{h-1}{k+1}. \tag{B4}
\]

Indeed, with probability $1/(k+1)$ its priority is ahead of every low bidder, so its threshold is $1$; otherwise it must bid $h$ to win. If at least two bidders are high, total revenue is $h$. With no high bidder and at least one low positive bidder, total revenue is $1$. These payments also follow directly from the finite maximal-payment identity.

The allocation agrees with a highest-tier allocation on grid profiles, but its payments differ from an ordinary second-price auction: the whole real interval $[1,h)$ is pooled. Atoms and bids exactly equal to $1$ or $h$ use the higher tier.

### 3. All consistent priors reduce to low-endpoint choices

For a finite consistent product prior, put $p_i=\Pr(V_i=h)$ and $z_i=\Pr(V_i=0)$. At least two bidders have $z_i=0$. Otherwise the event that all but at most one bidder equal zero has positive probability by independence, contradicting $V_{(2)}\ge1$ almost surely. Conversely, two such bidders suffice to rule out a zero second-highest value. This includes $p_i=1$, when $z_i=0$ automatically.

The remaining observation constraint is

\[
\Pr\!\left(\sum_i\mathbf1\{V_i=h\}\ge2\right)=t, \tag{B5}
\]

which depends only on $p$. Fix $p$ and any distinguished pair with $z_i=0$. Other zero probabilities range over the box $0\le z_i\le1-p_i$. The fixed mechanism's expected revenue is affine in each coordinate $z_i$ separately, because the joint distribution is a product. Its minimum on this box is attained at coordinate endpoints. The full feasible set is the finite union of these boxes over possible distinguished pairs.

Thus worst revenue is attained among priors

\[
V_i=\begin{cases}
h\text{ with probability }p_i,\ 1\text{ otherwise}, &i\in I,\\
h\text{ with probability }p_i,\ 0\text{ otherwise}, &i\notin I,
\end{cases}
\qquad m=|I|\ge2. \tag{B6}
\]

The set $I$ and all $p_i$ remain arbitrary subject to (B5). The continuum of high-probability vectors is not replaced by a sampled finite adversary family. Combined with exact support reduction, this statement covers every original real-valued product prior, including hidden upper tails.

### 4. Exact expected revenue at every endpoint prior

Define

\[
P_0=\prod_i(1-p_i),\quad
u_i=p_i\prod_{\ell\ne i}(1-p_\ell),\quad
P_1=\sum_i u_i,\quad t=1-P_0-P_1,
\]

and

\[
\alpha_m=\frac{m-1}{m},\quad \beta_m=\frac{m}{m+1},\quad
W=\alpha_m\sum_{i\in I}u_i+\beta_m\sum_{i\notin I}u_i. \tag{B7}
\]

No high bidder means $m$ low positive bidders, hence revenue $1$. A unique high bidder inside $I$ faces $m-1$ low bidders and pays $1+(h-1)\alpha_m$. A unique high bidder outside $I$ faces $m$ low bidders and pays $1+(h-1)\beta_m$. With two or more high bidders, revenue is $1+(h-1)$. Therefore

\[
\operatorname{Rev}(M_h;\mathbf F)
=1+(h-1)(t+W). \tag{B8}
\]

Every weight defining $W$ is at least $1/2$.

### 5. A quadratic inequality uniform in the number of bidders

For arbitrary nonnegative numbers $r_i$, set

\[
T=\sum_i r_i,\qquad
L=\alpha_m\sum_{i\in I}r_i+\beta_m\sum_{i\notin I}r_i,\qquad
e_2(r)=\sum_{i<\ell}r_ir_\ell.
\]

**Lemma B1.** For every $n\ge m\ge2$,

\[
e_2(r)\le\frac97L^2. \tag{B9}
\]

For $m=2$, let $s=\sum_{i\in I}r_i$ and $b=\sum_{i\notin I}r_i$. The inside, cross, and outside pair sums are bounded by $s^2/4$, $sb$, and $b^2/2$, respectively. Since $L=s/2+2b/3$,

\[
\frac97L^2-\left(\frac{s^2}{4}+sb+\frac{b^2}{2}\right)
=\frac{(s-b)^2}{14}\ge0. \tag{B10}
\]

For $m\ge3$, all weights are at least $2/3$, so
$e_2(r)\le T^2/2\le(9/8)L^2\le(9/7)L^2$.

The constant $9/7$ is sharp when the number of outside bidders may grow: make the two inside coordinates equal, and spread the same total odds over increasingly many outside coordinates. This sharpness concerns (B9), not the original universal auction ratio.

### 6. A finite guarantee uniform in all parameters

**Lemma B2.** For every $n\ge m\ge2$, every set $I$ of size $m$, and every $p\in[0,1]^n$ whose probability of two or more high bidders is $t\in[0,1]$,

\[
W\ge \frac{\sqrt{7t}(1-t)}{3+2\sqrt{7t}}. \tag{B11}
\]

**Proof.** Apply Lemma B1 directly to the probabilities $r_i=p_i$, and write $L_p=\alpha_m\sum_{i\in I}p_i+\beta_m\sum_{i\notin I}p_i$. The pair-event union bound gives

\[
t\le\sum_{i<\ell}p_ip_\ell=e_2(p)\le\frac97L_p^2,
\qquad L_p\ge\frac{\sqrt{7t}}3. \tag{B12}
\]

For every $p_i\in[0,1]$, including endpoints,

\[
u_i=p_i\prod_{\ell\ne i}(1-p_\ell)\ge P_0p_i.
\]

Consequently $W\ge P_0L_p\ge P_0\sqrt{7t}/3$. Also $W\ge P_1/2$, because all weights are at least $1/2$, so

\[
P_0=1-P_1-t\ge1-2W-t. \tag{B13}
\]

Combining these inequalities, with no division by $p_i$ or $1-p_i$, yields

\[
W\ge\frac{\sqrt{7t}}3(1-2W-t).
\]

Move the $W$ term to the left and divide by the strictly positive number $1+2\sqrt{7t}/3$ to obtain (B11). This also covers $t=0$, $t=1$, and bidders who are high with probability one. The proof is uniform over all numbers of bidders. $\square$

**Theorem B3 (finite original-model guarantee).** For every $n\ge2$, every $h>1$, and every binary observed law $G=(1-t)\delta_1+t\delta_h$ with $t\in[0,1]$, the original robust optimum satisfies

\[
R_{2,n}(G)\ge
1+(h-1)\left[t+\frac{\sqrt{7t}(1-t)}{3+2\sqrt{7t}}\right].
\tag{B14}
\]

The displayed implementable mechanism attains this lower guarantee against every original consistent product prior. This follows from the endpoint reduction, exact identity (B8), and Lemma B2; hidden supports and off-grid reports are covered by the exact support reduction or the direct tier mechanism implementation.

At the degenerate endpoints $t=0,1$, the same construction with grid $\{0,1,h\}$ remains valid even if one of these positive grid points is outside the actual support of $G$. The proof of support reduction applies unchanged to a finite grid containing the support and zero. Alternatively, a two-active point-mass prior shows the robust values are $1$ and $h$, respectively, and the guarantee is exact.

In particular, the finite inequality implies

\[
\liminf_{t\downarrow0}\ \inf \frac{W}{\sqrt t}
\ge\frac{\sqrt7}{3}, \tag{B15}
\]

where $n,m,I,p$ may all vary with $t$. There is no exchange of a fixed-$n$ limit with the adversarial infimum.

For instances (B3),

\[
R_{2,j}(G_j)\ge
1+(j-1)\left[\frac1{2j^2}
+\frac{(\sqrt{14}/(2j))(1-1/(2j^2))}
 {3+\sqrt{14}/j}\right].
\tag{B16}
\]

This is an explicit finite lower bound on the **true** robust optimum, not a lower bound merely for a sampled adversary set. Hence

\[
\liminf_{j\to\infty}R_{2,j}(G_j)
\ge1+\frac{\sqrt{14}}6. \tag{B17}
\]

Every instance has positive finite robust value by support reduction; SPA at reserve $1$ also certifies positivity, and a bounded consistent-iid prior bounds the robust optimum above.

### 7. Exact known numerator

Let $r_j$ solve

\[
1-(1-r_j)^j-jr_j(1-r_j)^{j-1}
=\frac1{2j^2}. \tag{B18}
\]

Tang--Wang Theorem 5.1 identifies this consistent-iid prior as least favorable for each common reserve. Its entire reserve curve yields

\[
S_{2,j}(G_j)=
\max\left\{
1+\frac{j-1}{2j^2},\
j[1-(1-r_j)^j]
\right\}. \tag{B19}
\]

The first term is the reserve-$1$ revenue. On $(1,j]$ the curve increases linearly, attaining its maximum there at $j$; above $j$ the consistent-iid prior gives zero. All reserves and their endpoints are covered.

The separate revenue-envelope proof derives from (B18) that $jr_j\to0$, $j^2r_j\to1$, and therefore

\[
j[1-(1-r_j)^j]\to1,\qquad S_{2,j}(G_j)\to1. \tag{B20}
\]

Combining (B17) and (B20) gives

\[
\limsup_{j\to\infty}\frac{S_{2,j}(G_j)}{R_{2,j}(G_j)}
\le\frac1{1+\sqrt{14}/6}.
\]

The definition of $c_*$ as an infimum proves (B1), as a proved first-round consequence. This direction requires a lower bound on the true $R$; an iid full-information upper bound would not establish it.

### 8. Matching adversaries for this mechanism only

For $j\ge3$, choose $I$ of size two, give its two bidders odds $a>0$ each, and give each other bidder odds $2a/(j-2)$. The inside and outside total odds both equal $2a$, so $T=4a$. Let

\[
P_0(a)=(1+a)^{-2}
 \left(1+\frac{2a}{j-2}\right)^{-(j-2)},\qquad
t(a)=1-P_0(a)(1+4a). \tag{B21}
\]

There is a unique $a_j>0$ with $t(a_j)=t_j$: every high probability increases continuously and strictly with $a$, and the probability of at least two highs increases from zero to one.

The two inside bidders alone give high-pair probability $(a_j/(1+a_j))^2\le t_j$, hence $a_j\to0$. For these odds, $T=4a_j$ and $e_2=(7-2/(j-2))a_j^2$. The elementary symmetric sums satisfy $e_k\le T^k/k!$, so

\[
0\le \sum_{k\ge3}e_k\le T^3e^T/6,\qquad
e^{-4a_j}\le P_0(a_j)\le1.
\]

The first bound is uniform in the number of bidders; the second follows from $\prod_i(1+r_i)\le e^T$. Expanding $t_j=P_0(\prod_i(1+r_i)-1-T)$ now gives

\[
t_j=P_0(a_j)
\left[\left(7-\frac2{j-2}\right)a_j^2+O(a_j^3)\right],
\qquad P_0(a_j)\to1.
\]

Thus $a_j/\sqrt{t_j}\to1/\sqrt7$. Here
$W_j=P_0(a_j)\,7a_j/3$, so $W_j/\sqrt{t_j}\to\sqrt7/3$.
These are admissible original product priors. Together with Lemma B2, they show that this mechanism's worst revenue on (B3) converges **exactly** to $1+\sqrt{14}/6$.

This does not show the same limit for the optimal robust value $R_{2,j}(G_j)$; other mechanisms may do better. Consequently it does not supply the matching instance needed to solve the original sharp constant.

### 9. Attribution and unresolved obligations

The priority mechanism, finite payment identity, and all-real threshold implementation use classical ideas. More specifically, Tang--Wang v3 Section 5.2, Proposition 5.3 already uses a rejection-below-1, pooled-low-tier and high-tier-priority mechanism with fixed lexicographic priority in its three-bidder, two-point example (with high value 2). Here the priority is uniformly randomized; such priority randomization is also a classical ingredient and is used by Tang--Wang in Section 4, which explains off-support score extensions. The mechanism itself is not claimed as new. The potential incremental contribution is the low-endpoint reduction for the full consistent product adversary, the uniform weighted rare-high guarantee over all heterogeneous probabilities and bidder counts, and the consequence (B1) for their exact original ratio.

No priority claim follows just from this derivation. Final novelty review must inspect the precise theorem and its proof. The universal lower guarantee remains the attributed $2-\sqrt2$ theorem. The interval (B2) remains open, and a matching prior for this particular mechanism is not a matching prior for the optimal robust mechanism. Full Lean formalization is incomplete.


## II. 有限观测支持的精确归约

### 1. Statement and conventions

Fix a known integer $n\ge2$. Values and reports lie in $[0,\infty)$. A mechanism is specified by measurable conditional expected allocations $x_i(v)\ge0$, with $\sum_i x_i(v)\le1$, and conditional expected payments $p_i(v)$. It is DSIC and ex-post IR in these conditional expectations for every real report profile. This is the mechanism class in the frozen problem; universal truthfulness is not additionally required.

Expected revenues entering the original objective use well-defined extended expectations. This causes no loss through subsidies: replacing each original payment $p_i(v_i,v_{-i})$ by $p_i(v_i,v_{-i})-p_i(0,v_{-i})$ preserves DSIC and increases revenue because IR at zero gives $p_i(0,v_{-i})\le0$. The classical payment identity makes these normalized payments nonnegative, so their expectations are defined. This is a revenue-dominance normalization, not an additional restriction on the original mechanism class; compare Tang--Wang v3 Section 5.3. The finite optimum and extension constructed below have bounded nonnegative total revenue.

Let $G$ be a finitely supported probability law on $[0,\infty)$, and put

\[
A=\{0\}\cup\operatorname{supp}G
  =\{a_0=0<a_1<\cdots<a_m\},\qquad
r(v)=\max\{a\in A:a\le v\}.
\tag{1}
\]

The case $m=0$ is allowed, with $r\equiv0$. Above $a_m$, the map stays equal to $a_m$. All arguments also apply to any finite grid containing zero and the support of $G$; the minimal grid in (1) is only a convenient choice. Write $\Pi(G)$ for the original set of independent product priors with second-highest law $G$, and $\Pi_A(G)$ for those priors supported on $A^n$. Define $R_A(G)$ using all randomized finite-type DSIC/IR mechanisms on the full report domain $A^n$, still with pointwise single-item feasibility; not merely incentive constraints on profiles of positive probability under a particular prior. Let $S_A(G)$ be the robust revenue of the best deterministic common-reserve second-price auction against $\Pi_A(G)$, with reserves initially allowed to be any nonnegative real number.

**Proposition 1 (exact reduction).** With this notation,

\[
R_{2,n}(G)=R_A(G),\qquad S_{2,n}(G)=S_A(G).
\tag{2}
\]

The finite mechanism optimum and a worst-case finite product prior for each fixed finite mechanism are attained. An optimal common reserve exists in $A$. A finite optimum extends explicitly to a mechanism valid against every real report and every original consistent product prior, including priors with hidden values outside $A$ and unbounded upper supports. These conclusions do not assert a finite algorithm, polynomial-time solvability, or a finite list of sufficient adversarial priors.

### 2. The exact image of the ambiguity set

For any nondecreasing scalar function $r$, applying it coordinatewise commutes with every order statistic, including at ties. Indeed, choose an ordering $v_{\sigma(1)}\ge\cdots\ge v_{\sigma(n)}$. The same sequence remains weakly decreasing after applying $r$, so its second entry is $r(v_{(2)})$.

For $V\sim\mathbf F\in\Pi(G)$, one has $V_{(2)}\in\operatorname{supp}G\subset A$ almost surely. Consequently,

\[
(r(V_1),\ldots,r(V_n))_{(2)}
=r(V_{(2)})=V_{(2)}\quad\text{almost surely}.
\tag{3}
\]

Coordinatewise measurable transformations of independent variables remain independent. Thus $r_\#\mathbf F=\bigotimes_i(r_\#F_i)\in\Pi_A(G)$. Conversely, any $\mathbf Q\in\Pi_A(G)$ is itself an original admissible prior, and $r_\#\mathbf Q=\mathbf Q$. Hence the map $r_\#:\Pi(G)\to\Pi_A(G)$ is onto, not merely into.

This is the step that permits hidden upper-tail values to be removed. Finite support of the observed statistic alone does not imply that the bidders' original marginal supports are finite or bounded.

### 3. Maximal finite-type payments

The discrete payment formula is classical. In particular, Giannakopoulos--Hahn, *Discrete Single-Parameter Optimal Auction Design* (ACM TEAC 2026), Section 3, LP2 and Lemma 3.4, gives this finite single-parameter maximal-payment characterization: [DOI 10.1145/3789259](https://doi.org/10.1145/3789259), [published author-deposited PDF](https://eprints.gla.ac.uk/378726/1/378726.pdf). It is reproduced here to prove the exact transfer and is not claimed as a new identity.

Fix bidder $i$ and opponents' reports $a_{-i}\in A^{n-1}$, and abbreviate $x_j=x_i(a_j,a_{-i})$, $p_j=p_i(a_j,a_{-i})$. Finite DSIC implies $x_{j+1}\ge x_j$: adding the two incentive inequalities for types $a_j,a_{j+1}$ gives

\[
(a_{j+1}-a_j)(x_{j+1}-x_j)\ge0.
\]

IR at zero gives $p_0\le0$, and the downward adjacent incentive constraint gives

\[
p_j-p_{j-1}\le a_j(x_j-x_{j-1})\quad(1\le j\le m).
\tag{4}
\]

Define normalized maximal payments by

\[
p_j^*=\sum_{k=1}^{j}a_k(x_k-x_{k-1})
=a_jx_j-\sum_{k=0}^{j-1}(a_{k+1}-a_k)x_k,
\qquad p_0^*=0.
\tag{5}
\]

Equation (4) telescopes to $p_j\le p_j^*$. These maximal payments are themselves finite-type DSIC and IR. To see DSIC, for $j>\ell$,

\[
a_\ell(x_j-x_\ell)
\le p_j^*-p_\ell^*
=\sum_{k=\ell+1}^{j}a_k(x_k-x_{k-1})
\le a_j(x_j-x_\ell).
\tag{6}
\]

The two inequalities are precisely the pairwise IC constraints, and cover arbitrary, not just adjacent, reports. Moreover $0\le p_j^*\le a_jx_j$, so truthful utility is nonnegative. Pointwise feasibility is unchanged because allocations are unchanged.

Thus every finite DSIC/IR mechanism is pointwise revenue-dominated by its normalized version with the same allocations. Maximizing robust revenue can be restricted to allocations in a compact polytope and the payments in (5). No assumption that the original mechanism had nonnegative payments, no positive subsidies, or universally truthful randomization is needed.

### 4. Extension to all real reports

Take any normalized finite mechanism. Define

\[
\widetilde x_i(v)=x_i(r(v_1),\ldots,r(v_n)),
\tag{7}
\]

and use the standard normalized single-parameter payment identity

\[
\widetilde p_i(v)=v_i\widetilde x_i(v)
-\int_0^{v_i}\widetilde x_i(t,v_{-i})\,dt.
\tag{8}
\]

For each fixed real $v_{-i}$, the own-report allocation is nondecreasing and bounded. The payment identity therefore yields DSIC and ex-post IR for every real true value and every real deviation. Explicitly, if true value is $v_i$, the gain from truth over a lower report $b_i\le v_i$ is

\[
\int_{b_i}^{v_i}
\bigl[\widetilde x_i(t,v_{-i})-\widetilde x_i(b_i,v_{-i})\bigr]dt\ge0;
\]

for a higher report $b_i\ge v_i$, it is

\[
\int_{v_i}^{b_i}
\bigl[\widetilde x_i(b_i,v_{-i})-\widetilde x_i(t,v_{-i})\bigr]dt\ge0.
\]

Truthful utility is the nonnegative integral in (8). All equalities use conditional expected allocations and payments, exactly as required by the original mechanism class. Feasibility holds at every real profile because (7) evaluates a feasible finite allocation vector at one common rounded profile.

For $v_i\in[a_j,a_{j+1})$, with the final interval interpreted as $[a_m,\infty)$, the integral in (8) equals

\[
\sum_{k=0}^{j-1}(a_{k+1}-a_k)x_i(a_k,r(v_{-i}))
+(v_i-a_j)x_i(a_j,r(v_{-i})).
\]

Consequently,

\[
\widetilde p_i(v)
=p_i^*(r(v_i),r(v_{-i})).
\tag{9}
\]

The same formula holds exactly at every grid point; endpoint values of the allocation do not affect the integral. In particular, payment remains bounded even when a true value lies arbitrarily far above the observed statistic's support. Equations (7) and (9) define a measurable mechanism. Allocations can be implemented by drawing at most one winner according to the vector $\widetilde x(v)$; the proof concerns conditional expected transfers, as does the stated model.

### 5. Both directions of the robust-value equality

For any original mechanism $M$, restricting reports to $A^n$ yields a finite DSIC/IR mechanism $M|_A$. Since $\Pi_A(G)\subset\Pi(G)$,

\[
\inf_{\mathbf F\in\Pi(G)}\mathbb E_{\mathbf F}\operatorname{Rev}(M)
\le
\inf_{\mathbf Q\in\Pi_A(G)}\mathbb E_{\mathbf Q}\operatorname{Rev}(M|_A)
\le R_A(G).
\]

Taking the supremum over original mechanisms gives $R_{2,n}(G)\le R_A(G)$. This direction does not require the original mechanism's payments to be normalized.

Conversely, let $M_A$ be a normalized finite mechanism and extend it as in (7)--(8). The pointwise identity (9) and the onto statement from Section 2 give

\[
\inf_{\mathbf F\in\Pi(G)}\mathbb E_{\mathbf F}\operatorname{Rev}(\widetilde M_A)
=
\min_{\mathbf Q\in\Pi_A(G)}\mathbb E_{\mathbf Q}\operatorname{Rev}(M_A).
\tag{10}
\]

The minimum notation is justified below; the equality already holds with infima. Supremizing over the normalized finite mechanisms gives $R_{2,n}(G)\ge R_A(G)$. This proof neither exchanges max and min nor convexifies the product-prior ambiguity set.

### 6. Exact finite-dimensional formulation and attainment

Let $z_{ij}=\Pr(V_i=a_j)$. The prior domain is a product of simplices $z_{ij}\ge0$, $\sum_jz_{ij}=1$, restricted by the polynomial equalities

\[
\sum_{i=1}^{n}\prod_{\ell\ne i}F_\ell(a_j)
-(n-1)\prod_{\ell=1}^{n}F_\ell(a_j)=G(a_j),
\quad F_i(a_j)=\sum_{k\le j}z_{ik},
\tag{11}
\]

for $0\le j\le m$. The identity is the probability that at most one value exceeds $a_j$. These constraints characterize the entire law of the second-highest value on $A$; not just selected moments. This is a closed subset $\mathcal Z_G$ of a compact set.

It is nonempty: the continuous strictly increasing function

\[
h_n(u)=nu^{n-1}-(n-1)u^n
\]

maps $[0,1]$ onto itself. The finite cumulative probabilities $F(a_j)=h_n^{-1}(G(a_j))$ define an admissible common marginal. This existence construction is the known consistent-iid prior, not a new result.

Let $\mathcal X_A$ be the allocation polytope consisting of pointwise feasibility, nonnegative allocations, and own-coordinate monotonicity on $A^n$. For $x\in\mathcal X_A$, use (5) to define payments and let

\[
\Phi(x,z)=\sum_{a\in A^n}\left(\sum_i p_i^*(a;x)\right)
\prod_{i=1}^{n}z_{i,\operatorname{index}(a_i)}.
\]

Then the original robust value is exactly

\[
R_{2,n}(G)=\max_{x\in\mathcal X_A}\min_{z\in\mathcal Z_G}\Phi(x,z).
\tag{12}
\]

The inner minimum exists by compactness and continuity. The function $x\mapsto\min_z\Phi(x,z)$ is continuous, for example by uniform continuity on the compact product or a uniform finite bound on its coefficients. The outer maximum also exists. This is a finite-dimensional polynomially constrained robust optimization problem. It is generally **not an ordinary finite linear program**: the product ambiguity set is nonconvex and contains continuously many priors. Minimizing over an arbitrary finite list of priors would only give an upper bound on (12).

All normalized revenues under grid priors lie in $[0,a_m]$: individual IR gives $p_i\le a_i x_i\le a_mx_i$, and single-item feasibility gives the total bound. Hence the original robust value is finite. If $G\ne\delta_0$, a zero-reserve SPA gives $R_{2,n}(G)\ge\mathbb E_G[V_{(2)}]>0$. If $G=\delta_0$, the all-zero product prior shows $R=0$, consistently with (12).

### 7. Common-reserve revenue equality

Use the convention that a value equal to the reserve is eligible. At a real profile $v$, the SPA revenue with reserve $p\ge0$ is

\[
\rho_p(v)=\mathbf1\{v_{(1)}\ge p\}\max\{p,v_{(2)}\}.
\tag{13}
\]

For a reserve $a\in A$, rounding preserves whether $v_{(1)}\ge a$. Under every original consistent prior, it also preserves $v_{(2)}$ almost surely by (3). Thus

\[
\rho_a(V)=\rho_a(r(V))\quad\text{almost surely},\qquad
\inf_{\Pi(G)}\mathbb E\rho_a
=\min_{\Pi_A(G)}\mathbb E\rho_a.
\tag{14}
\]

For a grid-supported profile and a reserve $p\in(a_j,a_{j+1}]$, replacing $p$ by $a_{j+1}$ preserves the eligible set and weakly increases revenue. Reserves above $a_m$ earn zero. The zero reserve is already in $A$. It follows that

\[
S_A(G)=\max_{a\in A}\min_{\Pi_A(G)}\mathbb E\rho_a.
\]

Because $\Pi_A(G)\subset\Pi(G)$, arbitrary reserves in the original problem cannot yield a value above $S_A(G)$. Equation (14) supplies the reverse inequality using a maximizing reserve in $A$. This proves the second equality in (2) without using the pre-existing least-favorable-iid reserve theorem. The latter gives an additional attributed formula for computing this finite numerator.

### 8. Scope and what remains open

The exact reduction removes a genuine modelling gap in finite computational exploration: hidden marginal support and off-grid deviations are covered, and prior independence is preserved. Its proof is an application of classical finite IC/payment facts and monotone pushforwards, and priority is not established. Tang--Wang already extend ironed virtual scores to off-support bids by a floor convention in their specific Myerson mechanism. The possible increment here is the explicit two-sided equality for **all** allowed finite mechanisms and the full consistent product ambiguity set, plus the attained polynomial formulation. It should not be described as a new payment identity or a general sharp approximation result.

There is no proved limiting theorem in this note taking arbitrary $G$ to finite laws while preserving the ratio. Formula (12) has not been solved uniformly in $n,A,G$. The all-$n$, all-$G$ constant $c_*$ from the frozen problem remains unresolved. Exact finite experiments, if subsequently performed, must still certify every feasible product prior in (11) before yielding a robust lower bound.

## III. 完整收益曲线下的同质活跃对手障碍

### 1. 结论及量词范围

记 \(S_{2,n}(G)\) 为最佳共同确定保留价二价拍卖的稳健收益，\(R_{2,n}(G)\) 为原始完整随机 DSIC/ex-post IR 机制空间的最优稳健收益。对 \(2\le m\le n\)，令

\[
F_m=H_{m,2}^{-1}\circ G,
\qquad
\mathbf D_m(G)=F_m^m\times\delta_0^{n-m},
\]

其中

\[
H_{m,2}(u)=mu^{m-1}-(m-1)u^m.
\]

这些是有 \(m\) 个同分布活跃竞标者的可行产品分布对手。定义

\[
B_m(G)=\operatorname{OPT}(\mathbf D_m(G)),
\qquad B_{\mathrm{act},n}(G)=\min_{2\le m\le n} B_m(G).
\]

这里 \(\operatorname{OPT}\) 是知道该产品分布时完整 DSIC/IR 机制空间的最优收益。可行对手只给出

\[
R_{2,n}(G)\le B_{\mathrm{act},n}(G)\le B_2(G).
\tag{1}
\]

**本文证明的障碍定理**是

\[
\sup_{\substack{n\ge2,G\\0<S_{2,n}(G)<\infty}}
\frac{B_2(G)}{S_{2,n}(G)}
=
\sup_{\substack{n\ge2,G\\0<S_{2,n}(G)<\infty}}
\frac{B_{\mathrm{act},n}(G)}{S_{2,n}(G)}
=1+\frac1{\sqrt2}.
\tag{2}
\]

因此，保留完整保留价收益曲线、但仍仅以上述同质活跃人数对手的完全知情最优收益比较分母，不能改善 Tang–Wang 的 \(2-\sqrt2\) 普适保证。本文给出达到该比较障碍的有限两点分布序列及完整证明。

式 (2) **不是** \(\sup R/S\) 的定值。它既没有给出真实 \(R\) 的匹配下界，也没有排除将多个对手联合施加于同一机制后获得更强约束。

### 2. 既有成分的归属

- Tang–Wang [TW26, Claim 2.1] 给出相容 iid 边际；虚拟零价值竞标者使 \(\mathbf D_m(G)\) 可行。
- [TW26, Theorem 5.1] 给出每个保留价在 \(n\) 个相容 iid 边际下达到最坏收益，因此完整分子可直接计算。
- [TW26, §5.3] 已证明
  \[
  B_2(G)\le \left(1+\frac1{\sqrt2}\right)P_n(G)
  \le \left(1+\frac1{\sqrt2}\right)S_{2,n}(G),
  \]
  其中 \(P_n(G)\) 是相容 iid 最高值的最佳 posted-price 收益。该式给出 (2) 的既有上界。
- 单参数 DSIC 的支付约束及两点分布虚拟收益上界是经典工具；第 4 节为验证原机制空间与支持外报价而完整写出，不作为新的机制设计技术。
- Hartline 的两点 iid 紧例与 [TW26, Theorem 4.1] 结合所得 \(c_*\le2/3\) 是此前核实的旧基线，与本文比较包络的障碍不能混同。

本轮新增工作是将完整分子、有限活跃人数的精确最优收益与一个共同极限序列对齐，形成所提 R1 比较接口的失效证书。

### 3. 两点观测分布及完整 SPA 收益

固定 \(h>1\)、\(0<q<1\)，令

\[
G_{h,q}=(1-q^2)\delta_1+q^2\delta_h.
\tag{3}
\]

对任意整数 \(m\ge2\)，记 \(r_m\in(0,1)\) 为方程

\[
g_m(r_m):=
1-(1-r_m)^m-mr_m(1-r_m)^{m-1}
=q^2
\tag{4}
\]

的唯一解。这正是 \(\operatorname{Bin}(m,r_m)\) 至少为 2 的概率；在 \((0,1)\) 内其导数为

\[
g_m'(r)=m(m-1)r(1-r)^{m-2}>0.
\]

令

\[
F_m=(1-r_m)\delta_1+r_m\delta_h.
\]

在 \(\mathbf D_m=F_m^m\times\delta_0^{n-m}\) 下，总有至少两个价值不低于 1 的竞标者，而次高价值等于 \(h\) 当且仅当至少两个活跃竞标者为高值。故 \(\mathbf D_m\in\Pi_{2,n}(G_{h,q})\)。当 \(m=2\) 时 \(r_2=q\)。

令

\[
\beta_n:=1-(1-r_n)^n.
\]

由 [TW26, Theorem 5.1]，原稳健 SPA 分子等于在 \(F_n^n\) 下优化保留价。完整收益函数为

\[
\operatorname{Rev}(\operatorname{SPA}(p),F_n^n)=
\begin{cases}
1+(h-1)q^2,&0\le p\le1,\\
p\beta_n+(h-p)q^2,&1<p\le h,\\
0,&p>h.
\end{cases}
\tag{5}
\]

第二段随 \(p\) 非减，因为 \(\beta_n\ge q^2\)。因此，**保留全部原子端点与尾积分后**，有精确等式

\[
S_{2,n}(G_{h,q})=
\max\{1+(h-1)q^2,\ h\beta_n\}.
\tag{6}
\]

式 (5) 在 \(p=1\) 使用第一段；该原子处不能用 \(F(1)\) 替代 \(F(1^-)\)。这里没有将 SPA 收益降为 posted-price 部分。

### 4. 两点 iid 活跃对手的精确 \(\operatorname{OPT}\)

#### 引理 1

设 \(m\ge2\)，\(m\) 个活跃价值独立且均为

\[
F=(1-r)\delta_1+r\delta_h,
\qquad h>1,\quad 0<r<1,\quad hr\le1.
\]

可以另有任意多个恒为零的竞标者。则在所有非负实值报告上满足 DSIC/ex-post IR 的完整随机机制空间中，

\[
\operatorname{OPT}(F^m\times\delta_0^{n-m})
=1+(h-1)\bigl[1-(1-r)^{m-1}\bigr].
\tag{7}
\]

##### 上界证明

首先可将零报告支付规范化为零；该步骤保持 DSIC 与 IR 并弱增收益，[TW26, §5.3] 已完整说明。于是恒零竞标者不提供正支付，其分配只会消耗可行分配预算。

固定一个活跃竞标者及其他报告。令其报告为 \(1,h\) 时的期望分配分别为 \(x_L,x_H\)，支付为 \(t_L,t_H\)。这里对机制内部随机性求期望，所以覆盖原文允许的全部随机 DSIC 机制。IR 与高类型的 DSIC 约束分别给出

\[
t_L\le x_L,
\qquad
t_H\le h x_H-hx_L+t_L
\le h x_H-(h-1)x_L.
\]

其条件期望支付满足

\[
(1-r)t_L+rt_H
\le rhx_H+(1-hr)x_L.
\tag{8}
\]

定义两个虚拟权重

\[
\phi(1)=\frac{1-hr}{1-r}\ge0,
\qquad \phi(h)=h.
\]

利用独立性对其他报告积分，再对竞标者求和，式 (8) 和分配可行性给出

\[
\operatorname{Rev}(M,F^m)
\le \mathbb E\!\left[\max_i\phi(V_i)\right]
=h[1-(1-r)^m]+(1-hr)(1-r)^{m-1}.
\]

由于 \((1-r)+r=1\)，右侧等于 (7)。这一上界只使用原机制所必须满足的约束，没有把机制限制为有限类型域。

##### 达到上界的全报告域机制

在报告前独立抽取一个均匀优先顺序。拒绝所有低于 1 的报价；将报价 \([1,h)\) 视作低档，报价 \([h,\infty)\) 视作高档。若存在高档，则选优先顺序最靠前的高档；否则选最靠前的低档。支付为固定其他报价与优先顺序后的临界报价。

对于每个固定优先顺序，自己的分配随报价非减，胜出临界点为 1 或 \(h\)。因此该机制对**全部非负实值报价及偏离**是 DSIC 和 ex-post IR，而非仅对两点报告有效。

在实际活跃支持 \(\{1,h\}^m\) 上，若优先顺序第一位以外的 \(m-1\) 人中没有高值，成交支付为 1；只要其中有高值，成交支付为 \(h\)。于是其期望收益恰为

\[
1\cdot(1-r)^{m-1}
+h\cdot[1-(1-r)^{m-1}],
\]

即 (7)。零价值竞标者总被拒绝，不影响相对优先顺序或支付。引理得证。

### 5. 同一两点观测下，两活跃对手精确优于所有同质活跃人数

#### 引理 2

对 (3) 的观测分布，若 \(hq\le1\)，则每个 \(2\le m\le n\) 都满足

\[
B_m(G_{h,q})\ge B_2(G_{h,q})
=1+(h-1)q.
\tag{9}
\]

因而

\[
B_{\mathrm{act},n}(G_{h,q})=B_2(G_{h,q}).
\tag{10}
\]

##### 证明

在 \(m\) 个高值概率为 \(r_m\) 的 iid 抽样中，前两人均为高值蕴含至少有两人高值。因此

\[
r_m^2\le q^2,\qquad hr_m\le hq\le1.
\]

引理 1 可用。记 \(a=1-r_m\)，\(A_m=1-a^{m-1}\)。由 (4)，

\[
A_m^2-q^2
=a^{m-1}\bigl[(m-2)-(m-1)a+a^{m-1}\bigr].
\tag{11}
\]

括号对 \(a\in[0,1]\) 非负：当 \(m=2\) 时为零；当 \(m\ge3\) 时有显式正系数证书

\[
a^{m-1}-(m-1)a+m-2
=(1-a)^2\sum_{k=0}^{m-3}(m-2-k)a^k\ge0.
\tag{12}
\]

于是 \(A_m\ge q\)，由 (7) 得到 (9)。对 \(m=2\)，\(r_2=q\)、\(A_2=q\)，等号成立。若 \(m>2\)、\(0<q<1\)、\(h>1\)，(12) 严格为正，因此 \(B_m>B_2\)。引理得证。

这一定理仅比较 **iid 活跃部分**的对手。它没有声称两活跃对手在所有非同质产品分布中最不利，更没有声称它与某一机制形成稳健鞍点。

### 6. 保留完整曲线仍达到旧比较常数的序列

令整数 \(j\ge2\)，取

\[
n_j=h_j=j,
\qquad q_j=\frac1{\sqrt2\,j},
\qquad
G_j=\left(1-\frac1{2j^2}\right)\delta_1
+\frac1{2j^2}\delta_j.
\tag{13}
\]

观测分布的两个价值及其概率均为有理数；只有分析用的二活跃高值概率 \(q_j\) 为二次代数数。由引理 2，

\[
B_{\mathrm{act},j}(G_j)=B_2(G_j)
=1+\frac{j-1}{\sqrt2\,j}
\longrightarrow1+\frac1{\sqrt2}.
\tag{14}
\]

下面证明完整 \(S_{2,j}(G_j)\to1\)，不丢弃其尾积分项。

令 \(r_j\) 是 (4) 在 \(m=j,q=q_j\) 时的解，记 \(C_j=\binom j2\)。至少两次成功概率满足

\[
C_jr_j^2(1-r_j)^{j-2}
\le q_j^2\le C_jr_j^2.
\tag{15}
\]

右式来自对所有成功对的并集上界，左式来自恰好两次成功事件。又有 \(r_j\le q_j\)，因此由 Bernoulli 不等式

\[
(1-r_j)^{j-2}\ge1-(j-2)r_j
\ge1-\frac1{\sqrt2}=:\kappa>0.
\]

结合 (15)，

\[
jr_j\le
\frac{j}{\sqrt{C_j}}\frac{q_j}{\sqrt\kappa}
\le \frac{2q_j}{\sqrt\kappa}\longrightarrow0.
\tag{16}
\]

由 (15)、(16) 得到

\[
\frac{q_j}{\sqrt{C_j}\,r_j}\longrightarrow1.
\tag{17}
\]

对 \(\beta_j=1-(1-r_j)^j\)，恰好一次成功概率和并集上界给出

\[
jr_j(1-r_j)^{j-1}\le\beta_j\le jr_j,
\]

故

\[
\frac{\beta_j}{jr_j}\longrightarrow1.
\tag{18}
\]

因而

\[
h_j\beta_j
=(h_jq_j)
\frac{j}{\sqrt{C_j}}
\frac{\sqrt{C_j}r_j}{q_j}
\frac{\beta_j}{jr_j}
\longrightarrow
\frac1{\sqrt2}\cdot\sqrt2=1.
\tag{19}
\]

完整分子的另一分支为

\[
1+(h_j-1)q_j^2
=1+\frac{j-1}{2j^2}\longrightarrow1.
\]

由 (6)，\(S_{2,j}(G_j)\to1\)。结合 (14)，

\[
\frac{B_2(G_j)}{S_{2,j}(G_j)}
=\frac{B_{\mathrm{act},j}(G_j)}{S_{2,j}(G_j)}
\longrightarrow1+\frac1{\sqrt2}.
\tag{20}
\]

再结合第 2 节所归属的既有统一上界，(2) 得证。每个实例都满足

\[
0<S_{2,j}(G_j)\le R_{2,j}(G_j)\le B_2(G_j)<\infty,
\]

所以序列没有通过零分母、无限收益或不合法支撑逃出原问题的定义域。

### 7. 失败证书的实际含义

式 (2) 排除了以下特定研究方案：只利用对每个 \(m\) 单独成立的 \(R\le B_m\)，再希望把 \(\min_m B_m\) 通过完整 SPA 收益曲线压到比 \((1+1/\sqrt2)S\) 更小的统一倍数。这种改良不可能对全部 \((n,G)\) 成立。

它没有排除下列可能性：

1. 选择不属于 \(F_m^m\times\delta_0^{n-m}\) 的非同质产品分布对手；
2. 保留同一机制面对多个对手时的联合约束，即研究 \(\sup_M\min_m\operatorname{Rev}(M,\mathbf D_m)\)，而不将其松弛为 \(\min_m\sup_M\operatorname{Rev}(M,\mathbf D_m)\)；
3. 直接证明真实机制的稳健收益上界，或为匹配实例建立对所有相容产品分布有效的机制下界。

特别地，本序列只给出

\[
\frac{S_{2,j}(G_j)}{B_2(G_j)}
\le \frac{S_{2,j}(G_j)}{R_{2,j}(G_j)}\le1.
\]

左端趋于 \(2-\sqrt2\) 不是右侧真实比率趋于该值的证明。本节单独不改变旧基线；综合 VI 的机制变分归约与 VIII.1 的精确下证，全文的认证区间为

\[
2-\sqrt2\le c_*\le\frac{1000000000000000}{1646154911812389}.
\]

### 8. 精确复现与验证边界

配套代码：`verify_revenue_envelope.py`。输出：`revenue_envelope_certificate.json`。

验证内容：

- 用整数运算对 (4) 的唯一根做有理二分包围，严格检查左右端点符号；
- 对 \(\sqrt2\) 使用整数平方根获得有理上下界；
- 据此包围每个示例的完整 \(S\)、\(B_2\) 与 \(B_2/S\)，输出向外舍入的十进制区间；
- 独立以高值人数的二项分布求和，核验第 4 节机制收益公式；
- 精确核验 (11) 的代数恒等式及 (12) 的正系数分解。

代码验证有限实例和代数表达式，不替代第 6 节的无限序列证明。一般 \(m\) 的公式在正文中已证明；脚本枚举若干 \(m\) 仅用于发现实现错误。

### 参考来源

**[TW26]** Zhihao Gavin Tang and Shixin Wang, *Robust Mechanism Design with Anonymous Information*, arXiv:2602.20429v3, 2026-11-05. [官方全文](https://arxiv.org/html/2602.20429v3)。

**[H]** Jason D. Hartline, *Mechanism Design and Approximation*, Chapter 4, Corollary 4.4.3. [作者章节 PDF](https://jasonhartline.com/MDnA/MDnA-ch4.pdf)。

## IV. 既有二人二点例的精确回归与验证范围

### 1. 归属与复现范围

二点族来自 Hartline 的 *Mechanism Design and Approximation*，Chapter 4，Corollary 4.4.3，pp.129–130。[作者原件](https://jasonhartline.com/MDnA/MDnA-ch4.pdf)。其 `n=2` 特例的原模型鲁棒分母，使用 Tang–Wang arXiv:2602.20429v3 的 Theorem 4.1（此时第二高值即最低值）；SPA 分子对应其 Theorem 5.1。[官方原件](https://arxiv.org/pdf/2602.20429v3)

本次只把该旧例补成含端点、完整机制和精确分数的回归基线。`2/3` 上界和该构造不计新贡献。

[有限模型检查器](evidence/code/verify_finite_model.py) · [初始完整结果](evidence/results/finite_model_initial_exact.json)

### 2. 旧二点族的完整精确核对

令 `h≥3`，`q=1/h`，两个 bidder 独立同分布：

\[
\Pr(V=2)=1-q,\qquad \Pr(V=h)=q.
\]

第二高值分布为

\[
G_h(\{2\})=1-q^2,\qquad G_h(\{h\})=q^2.
\]

为覆盖零概率报告，有限报告域取 `A={0,2,h}`，并在 **全部** `A²` 上检查激励约束，而非只检查真实分布的正概率类型。

#### 2.1 保留价端点与 SPA 最优性

报价等于保留价时可以中标。因此

\[
F(2^-)=0,\ F(2)=1-q,\ F(h^-)=1-q,\ F(h)=1;
\]

\[
\Pr(V\ge2)=1,\quad\Pr(V>2)=q,\quad
\Pr(V\ge h)=q,\quad\Pr(V>h)=0.
\]

按所有真实保留价 `p≥0` 分段计算：

\[
\operatorname{Rev}(\mathrm{SPA}(p),F_h^2)=
\begin{cases}
2+(h-2)q^2,&0\le p\le2,\\
2p q(1-q)+hq^2,&2<p\le h,\\
0,&p>h.
\end{cases}
\]

第二段随 `p` 严格增加，到 `p=h` 的收益为 `2−1/h`。第一段超过它的差为 `2(h−1)/h²>0`，故

\[
S_{2,2}(G_h)=2+\frac1h-\frac2{h^2}.
\]

SymPy 不是仅对若干 `h` 取值代入：代码置 `h=3+s`、`s≥0`，精确核对上面的差、第二段导数及后面的比值差均为正。端点分段本身由上述事件分类给出。

#### 2.2 完整可行机制与有限最优性上界

在网格上，分配给最高正类型；平局时均匀随机；两人均报零时不分配。使用最大规范化有限类型支付

\[
t_i(a_j,a_{-i})=a_jx_i(a_j,a_{-i})
-\sum_{k<j}(a_{k+1}-a_k)x_i(a_k,a_{-i}).
\]

这不是将连续 SPA 的支付直接限制在网格上。完整分配及支付为：

| 报告 | 分配概率 `(x₁,x₂)` | 条件期望支付 `(t₁,t₂)` |
|---|---|---|
| `(0,0)` | `(0,0)` | `(0,0)` |
| `(0,2)` | `(0,1)` | `(0,2)` |
| `(0,h)` | `(0,1)` | `(0,2)` |
| `(2,0)` | `(1,0)` | `(2,0)` |
| `(2,2)` | `(1/2,1/2)` | `(1,1)` |
| `(2,h)` | `(0,1)` | `(0,(h+2)/2)` |
| `(h,0)` | `(1,0)` | `(2,0)` |
| `(h,2)` | `(1,0)` | `((h+2)/2,0)` |
| `(h,h)` | `(1/2,1/2)` | `(h/2,h/2)` |

代码逐一检查每个实例的 9 个可行性条件、18 个 IR 条件及 36 个非平凡 DSIC 条件。由真实分布计算其收益：

\[
2(1-q)^2+(h+2)q(1-q)+hq^2=3-\frac2h.
\]

为避免只证明一个可行下界，代码另算标准有限类型虚拟剩余上界。若边缘质量为 `z_j`，最大支付期望中 `x(a_j)` 的系数为

\[
c_j=a_jz_j-(a_{j+1}-a_j)\sum_{\ell>j}z_\ell
\quad(j<|A|-1),\qquad c_{|A|-1}=a_{|A|-1}z_{|A|-1}.
\]

正质量处取 `φ_j=c_j/z_j`。零质量处 `c_j≤0`，舍去这些非正贡献仍是上界；无需除以零。在本例中，两个正概率类型的虚拟值是 `φ(2)=h/(h−1)`、`φ(h)=h`。逐 profile 的最大非负虚拟值期望，与上述构造收益精确相等。因此有限类型最优值已由一个可行机制和一个相等的上界认证。

原连续报告、原产品分布模糊集中的鲁棒等式

\[
R_{2,2}(G_h)=\operatorname{OPT}(F_h^2)=3-\frac2h
\]

此处**归因于 Tang–Wang Theorem 4.1**，不由有限 checker 的有限次检查独立推出。

#### 2.3 比值和精确回归表

\[
\frac{S_{2,2}(G_h)}{R_{2,2}(G_h)}
=\frac{2h^2+h-2}{h(3h-2)},\qquad
\frac{S_{2,2}(G_h)}{R_{2,2}(G_h)}-\frac23
=\frac{7h-6}{3h(3h-2)}>0,
\]

且 `h→∞` 时趋于 `2/3`。

| h | 最优 SPA 收益 | 鲁棒最优收益（引用 TW4.1） | 精确比值 |
|---:|---:|---:|---:|
| 3 | 19/9 | 7/3 | 19/21 |
| 4 | 17/8 | 5/2 | 17/20 |
| 5 | 53/25 | 13/5 | 53/65 |
| 10 | 52/25 | 14/5 | 26/35 |
| 100 | 10049/5000 | 149/50 | 10049/14900 |
| 1000 | 1000499/500000 | 1499/500 | 1000499/1499000 |

### 3. 有限产品分布约束

设严格递增网格 `A={a₀=0,…,a_m}`；允许退化网格 `A={0}`。对每个 bidder 输入完整边缘概率质量 `z_i,j≥0`，每行和为 1，记 `u_i,j=Σ_(k≤j)z_i,k`。在每个网格点，第二高值的**含端点 CDF** 约束为

\[
\prod_i u_{i,j}+
\sum_i(1-u_{i,j})\prod_{\ell\ne i}u_{\ell,j}=G(a_j).
\]

等价形式是 \(\sum_i\prod_{\ell\ne i}u_{\ell,j}-(n-1)\prod_i u_{i,j}\)。代码使用不含除法的式子，因而 `u_i,j=0` 或 `1` 无需额外分支。

工具提供两种不同功能：

- `check_product_cdf_constraints`：对**一个输入的精确有理产品先验**，检查所有网格点及完整边缘概率合法性。
- `symbolic_product_cdf_constraints`：输出边缘 CDF 单调性不等式及产品多项式等式，保留其连续、一般非凸的结构；没有将它线性化成任意联合分布或有限先验列表。

单点可行性检查不等于对所有可行产品分布最坏收益的认证。符号约束刻画实数概率空间；有理数 checker 不假设最坏概率必须是有理数。

### 4. 完整有限类型 DSIC、IR 检查

`check_mechanism` 要求每个报告 profile 都有完整分配和支付，包括边缘质量为零的报告。它逐项检查：

\[
x_i(a)\ge0,\qquad\sum_i x_i(a)\le1,
\]

\[
a_ix_i(a)-t_i(a)\ge0,
\]

\[
a_ix_i(a_i,a_{-i})-t_i(a_i,a_{-i})
\ge a_ix_i(b_i,a_{-i})-t_i(b_i,a_{-i})
\quad\text{对全部 }a,b_i.
\]

它不只检查相邻类型，不只检查真实分布支持内的误报，也不假定对称性。`canonical_payments` 是另一个工具：在 own-type monotone 分配下生成最大规范化支付，随后仍交给完整 pairwise checker 检查。

回归诊断包括：CDF 多项式与独立 profile 枚举的一致性；错误目标 CDF 被拒绝；可行且 IR、但允许有利零概率误报的机制被 DSIC 检查拒绝；IR 和可行性各自被故意破坏的机制被拒绝；`A={0}` 的零收益边界通过。

所有输入只接受整数、Fraction 或有理数字符串，拒绝静默接受浮点数。所有结果用精确分数字符串写入 JSON。

### 5. 隐藏无界支持诊断与归约范围

为核验“统计量有限支持并不意味着边缘有限支持”，代码记录了一个显式、真正无界的独立先验：

\[
V_1=100\cdot2^K,\quad\Pr(K=k)=2^{-k},\ k\ge1;
\qquad V_2=1,\quad V_3=0.
\]

几何级数质量和精确为 1，每个实现都满足 `V₁≥200>V₂=1>V₃=0`，故第二高值恒为 1。对共同网格 `{0,1}` 向下取整后，profile 恒为 `(1,1,0)`；第二高值及独立性保持，精确产品 CDF 检查通过。此处保留了对固定网格之外无界边缘的真实例子，而非只测若干大数。

一般有限支持归约见本稿 II 部分的命题 1。本执行者已独立核对其中的边界：共同 floor 保持单物品可行性；网格跳点不影响支付积分；最高网格以上支付恒定；`G=δ₀` 的单点退化一致；SPA 任意价的 ceil 比较只先用于网格先验，再用模糊集包含关系比较原问题，方向正确。

这些是对证明稿的数学核对。程序自身没有枚举所有真实报告或所有连续产品分布，不能以测试通过替代该证明。原题任意 `G` 的有限逼近与极限交换也不在本文件的结论中。

### 6. 复现命令与依赖

本轮环境：Python `3.12.14`，SymPy `1.14.0`。Fraction、itertools、json 等来自 Python 标准库；未调用浮点优化器。

在[原案例目录](evidence/)运行只读验证：

```bash
python code/verify_finite_model.py
```

明确重建完整精确结果时运行：

```bash
python code/verify_finite_model.py --write-results results/finite_model_initial_exact.json
```

默认命令不写结果文件，只输出 PASS、版本、基线参数及验证范围。初始两次执行均 exit 0；最终结果包括符号恒等式、符号正性检查、六个完整机制表和所有 checker 诊断。

### 7. 明确未完成的内容

本工具没有求解 `max_x min_z`，没有证明任意 `n≥3` 下的非平凡鲁棒机制收益下界，没有生成覆盖连续产品模糊集的最坏分布证书，也没有产生 `2−√2` 与旧上界 `2/3` 之间的新紧常数。有限实验后续若开展，必须沿用完整多项式约束并单独提供最坏分布覆盖或解析证明。

## V. 一个有限原模型实例的严格分离

上述比率改进不仅有极限表达式。取 $n=h=16$、$t=1/512$，则

\[
S_{2,16}(G)=\frac{527}{512},\qquad
R_{2,16}(G)\ge\frac{4160053}{2649088}>\frac{157}{100}.
\]

分子的两个保留价分支由一致 iid 的高值概率 $r_{16}$ 决定。精确有理计算验证

\[
g_{16}(1/243)>\frac1{512},\qquad
16[1-(242/243)^{16}]<\frac{527}{512}.
\]

因 $g_{16}$ 单调，$r_{16}<1/243$，所以高保留价分支严格低于低保留价分支。
分母使用 I 节的全产品先验解析保证，并代入
$\sqrt{14}>187/50$；该保证随此正根参数递增。所得下界为上式有理数，
超过 $157/100$ 的差恰为 $24621/66227200$。因此

\[
\frac{S_{2,16}(G)}{R_{2,16}(G)}
\le\frac{13175}{20096}<\frac23.
\]

这是对固定有限人数原模型的严格证书，不要求证明当前机制稳健最优。
它不取代完整序列对 $6/(6+\sqrt{14})$ 的解析证明。


## VI. 二次研究：精确有限机制结构与完整最优极限

### 1. Statement

Fix $\lambda>0$. For every sufficiently large integer $n$ put

\[
t_n=\frac1{2n^2},\qquad h_n=\sqrt2\,\lambda n>1,\qquad
G_n=(1-t_n)\delta_1+t_n\delta_{h_n}.
\tag{S1}
\]

Let $R_n=R_{2,n}(G_n)$ and $S_n=S_{2,n}(G_n)$ retain the **original** unrestricted randomized DSIC/ex-post-IR mechanism class and the original independent, possibly heterogeneous nonnegative product priors.

For $m\ge2$ and positive $\alpha,\beta$, define

\[
C_m(\alpha,\beta)=
\begin{cases}
\sqrt2\,\beta,&\alpha\ge\beta,\\
\sqrt{2\beta^2-2m(\beta-\alpha)^2},
 &\alpha<\beta<\dfrac{m\alpha}{m-1},\\
\alpha\sqrt{\dfrac{2m}{m-1}},
 &\beta\ge\dfrac{m\alpha}{m-1}.
\end{cases}
\tag{S2}
\]

The formulas agree at boundaries. For $q=(q_m)_{m\ge2}\in[0,1]^{\{2,3,\ldots\}}$, put

\[
\alpha_m(q)=1-\frac{q_m}{m},\quad
\beta_m(q)=1-\frac{q_{m+1}}{m+1},\quad
f_m(q;\lambda)=q_m+\lambda C_m(\alpha_m(q),\beta_m(q)),
\]

and

\[
V(\lambda)=\max_{q\in[0,1]^{\{2,3,\ldots\}}}
             \inf_{m\ge2} f_m(q;\lambda).
\tag{S3}
\]

**Theorem S1 (full-mechanism asymptotic value).** The maximum in (S3) exists and

\[
\lim_{n\to\infty}R_n=V(\lambda),\qquad
\lim_{n\to\infty}S_n=\max\{1,\sqrt2\,\lambda\}.
\tag{S4}
\]

This is a characterization of the true optimal robust value in a specific rare-high family, with an upper bound for **all** mechanisms; it is not merely a claim of optimality within the constructed tier family.

For each $K\ge2$, let

\[
U_K(\lambda)=
\max_{q_2,\ldots,q_{K+1}\in[0,1]}
\min_{2\le m\le K} f_m(q;\lambda).
\tag{S5}
\]

**Theorem S2.** The compact finite-dimensional programs satisfy

\[
U_K(\lambda)-\frac{2\lambda}{K+1}
\le V(\lambda)\le U_K(\lambda).
\tag{S6}
\]

Thus the representation gives certified finite approximations, not just an unevaluated formal interchange of optimization and limits. Its primal and upper-certificate constructions are explicit below.

The original global $c_*$ remains open. A consequence, without claiming global matching, is

\[
c_*\le \inf_{\lambda>0}
\frac{\max\{1,\sqrt2\lambda\}}{V(\lambda)}
=\frac1{V(1/\sqrt2)}.
\tag{S7}
\]

### 2. A sharp weighted pair inequality

For $s,b\ge0$ define

\[
Q_m(s,b)=\frac{(s+b)^2-s^2/m}{2}.
\]

The set $\{s,b\ge0:Q_m(s,b)=1\}$ is compact: writing $T=s+b$ gives
$T^2/4\le Q_m(s,b)\le T^2/2$, so $\sqrt2\le T\le2$.

For arbitrary nonnegative $r_1,\ldots,r_N$, with a distinguished set $I$ of $m\ge2$ indices, put
$s=\sum_{i\in I}r_i$, $b=\sum_{i\notin I}r_i$. Cauchy's inequality inside $I$ and the nonnegative outside squares give

\[
e_2(r)=\frac{(s+b)^2-\sum_i r_i^2}{2}
\le Q_m(s,b).
\tag{S8}
\]

Define the weighted sum $L=\alpha s+\beta b$. By homogeneity,

\[
L\ge C_m(\alpha,\beta)\sqrt{e_2(r)},
\quad
C_m(\alpha,\beta)
=\min_{\substack{s,b\ge0\\Q_m(s,b)=1}}(\alpha s+\beta b).
\tag{S9}
\]

If all $r_i$ vanish the inequality is immediate; otherwise scale $(s,b)$ by $\sqrt{Q_m(s,b)}$. To obtain (S2), write $\theta=s/(s+b)\in[0,1]$:

\[
C_m(\alpha,\beta)
=\min_{0\le\theta\le1}
\frac{\sqrt2[\beta+(\alpha-\beta)\theta]}
     {\sqrt{1-\theta^2/m}}.
\tag{S10}
\]

The derivative has the sign of
$(\alpha-\beta)+\beta\theta/m$. If $\alpha\ge\beta$, the minimum is at zero. If $\alpha<\beta$, the unconstrained minimizer is
$\theta_*=m(\beta-\alpha)/\beta$; it lies in $(0,1)$ precisely in the middle case of (S2), and otherwise the minimum is at one. Substitution proves the formula, including equality of the boundary formulas.

For sharpness as the number of outside coordinates grows, distribute the inside total $s$ equally over $m$ coordinates and the outside total $b$ equally over $N-m$ coordinates. Then
$e_2=Q_m(s,b)-b^2/(2(N-m))\to1$ when $(s,b)$ minimizes (S9).
Every finite such vector will later produce a genuine product prior; the limiting outside mass is not itself asserted to be a finite prior.

For the mechanism-induced weights in (S3),

\[
\frac1{\sqrt2}\le C_m(\alpha_m,\beta_m)\le\sqrt2.
\tag{S11}
\]

Indeed all weights lie in $[1/2,1]$, every normalized $(s,b)$ has $s+b\ge\sqrt2$, and the admissible point $(s,b)=(0,\sqrt2)$ gives the upper bound. Also, by the same compact representation,

\[
|C_m(\alpha,\beta)-C_m(\alpha,\beta')|
\le2|\beta-\beta'|.
\tag{S12}
\]

No assumption of concavity or differentiability at the piecewise boundaries is needed for this Lipschitz bound.

### 3. Mechanisms for arbitrary sequences q

Fix $n$ and $h>1$. On the finite report grid $\{0,1,h\}^n$, allocate uniformly among high reports if any exist. If no report is high and exactly $m$ reports equal $1$, allocate to a uniformly selected such bidder with total probability $q_m$. For the moment allow $q_1\in[0,1]$ as well, and do not allocate to zero reports. The singleton parameter will be irrelevant to the stated ambiguity set. On the all-zero profile, do not allocate.

For any $q_m\in[0,1]$, the own-report allocation is nondecreasing: it is zero at own type zero; if another bidder is high it remains zero at own type one; otherwise it is $q_m/m\le1$, and reporting high wins with probability one. With other high reports, moving from one to high also weakly increases allocation. Pointwise feasibility is immediate.

Use normalized maximal payments on the grid, then the common floor extension and continuous payment identity from the first-round support-reduction theorem. This gives a valid all-real-report DSIC/ex-post-IR mechanism. The claimed validity is DSIC/ex-post IR in conditional expected allocations and payments, which is exactly the original mechanism class.

The endpoint reduction from the first round applies to any fixed mechanism. Thus for $G=(1-t)\delta_1+t\delta_h$, minimizing its revenue over all original product priors reduces exactly to choosing a set $I$ of $m\ge2$ bidders with low endpoint one, all other bidders with low endpoint zero, and arbitrary independent high probabilities $p_i$ with $\Pr(\#\text{high}\ge2)=t$.

Let $P_0$, $P_1$, and $u_i$ be the probabilities of no high, exactly one high, and bidder $i$ being uniquely high. Define

\[
W=\alpha_m(q)\sum_{i\in I}u_i+
  \beta_m(q)\sum_{i\notin I}u_i.
\]

The no-high revenue is $q_m$. A uniquely high bidder in $I$ pays
$h-(h-1)q_m/m=1+(h-1)\alpha_m$, while a uniquely high outside bidder pays
$1+(h-1)\beta_m$. Multiple high bidders generate revenue $h$. Therefore

\[
\operatorname{Rev}(M_q;\mathbf F)
=q_mP_0+P_1+(h-1)W+ht
=q_m+(1-q_m)(P_1+t)+(h-1)(W+t).
\tag{S13}
\]

This exact expression explains why changing the low-tier allocation changes the robust tradeoff; it is not an arbitrary transfer modification.

#### Exact finite reduction of the full mechanism class

**Theorem S0.** For every $n\ge2$, $h>1$ and $t\in[0,1]$, some mechanism $M_q$ of the above family is optimal in the original robust problem for $G=(1-t)\delta_1+t\delta_h$. Consequently the full original optimum has the exact attained representation

\[
R_{2,n}(G)=
\max_{q_2,\ldots,q_n\in[0,1]}
\min_{\substack{2\le m\le n,\ p\in[0,1]^n\\
 \tau(p)=t}}
\bigl[q_mP_0(p)+P_1(p)+(h-1)W_m(p;q)+ht\bigr],
\tag{S0}
\]

where $\tau(p)=1-P_0(p)-P_1(p)$, the distinguished set can be fixed to
$I=\{1,\ldots,m\}$ by relabeling, and the high probabilities remain arbitrary and possibly heterogeneous. For $m=n$, the outside sum is zero; $q_{n+1}$ is unused and can be assigned any value in that term. This is a compact nonlinear adversarial problem, not a finite sampled LP.

**Proof.** The first-round exact support theorem reduces the original value to the full finite report domain. Its ambiguity set is permutation-invariant. Symmetrizing any mechanism by a uniformly random bidder permutation preserves DSIC/IR and feasibility and weakly improves its worst revenue: the revenue at any one prior is the average of the original mechanism's revenues at permuted admissible priors, each at least its original worst revenue. Thus anonymous mechanisms suffice.

For an arbitrary anonymous finite mechanism $M$, let $q_m$ be its total allocation to the $m$ low-positive bidders at the profile with no high reports and all other reports zero, for **every** $1\le m\le n$. Each such bidder has allocation $q_m/m$, and $0\le q_m\le1$. Construct $M_q$ using precisely these parameters, including the original $q_1$ for now.

We claim that $M_q$ weakly dominates $M$ in total revenue at **every grid report profile**:

- With no positive bidder, IR gives every payment at most zero, whereas $M_q$ earns zero.
- With no high bidder and $m\ge1$ low bidders, low IR bounds their payments by their allocations, and zero-type IR makes all remaining payments nonpositive. Total revenue is at most $q_m$, which $M_q$ earns.
- With exactly one high bidder and $k$ low bidders, let $x_H$ be the high bidder's allocation and let $x_L$ be its allocation after reporting one instead. Anonymity at that counterfactual all-low profile gives $x_L=q_{k+1}/(k+1)$. The high-type DSIC inequality and low-type IR imply
  \[
  p_H\le h x_H-(h-1)x_L.
  \]
  Payments of other low bidders sum to at most their allocations, hence at most $1-x_H$; zero-type payments are nonpositive. Total revenue is at most
  \[
  1+(h-1)(x_H-x_L)
  \le h-(h-1)\frac{q_{k+1}}{k+1},
  \]
  exactly the revenue of $M_q$ at this profile.
- With at least two high bidders, IR and feasibility bound total revenue by $h\sum_i x_i\le h$. The mechanism $M_q$ earns $h$.

No assumption about original zero-type allocations, no positive subsidies, or normalization is required for these upper bounds. The constructed mechanism is valid by own-report monotonicity and maximal payments. This establishes pointwise domination on the grid, hence robust domination against every grid prior. Together with exact support reduction and its all-real extension, the full original optimum is attained in the family.

There is a necessary scope distinction for $q_1$. To obtain the preceding **all-grid** domination, it must match the original singleton-low allocation; arbitrarily setting it to one first can fail on a singleton-high profile. After domination is established, every consistent prior for the stated $G$ has at least two positive values almost surely. On those profiles, $M_q$ payments use only $q_2,\ldots,q_n$. Therefore $q_1$ can then be fixed to one without changing any robust revenue. The theorem does not assert pointwise domination over off-grid original reports; its transfer there uses the proved two-sided support equivalence.

Finally, the endpoint argument gives exactly (S0), not only an inequality. The outer cube is compact; the inner feasible set is a finite union of compact nonempty sets defined by the polynomial constraint $\tau(p)=t$. The continuous objective has attained minima and a continuous minimum as a function of $q$, so its maximum is attained as well. No minimax interchange is made. $\square$

### 4. A uniform finite lower certificate

Apply (S9) to $r_i=p_i$, with the appropriate weights. The pair-event union bound gives

\[
L_p\ge C_m\sqrt t.
\]

Because $u_i\ge P_0p_i$ for every $p_i\in[0,1]$ and all weights are nonnegative,

\[
W\ge P_0L_p\ge P_0 C_m\sqrt t.
\]

The weights are at least $1/2$, so $P_0=1-P_1-t\ge1-2W-t$. Rearrangement yields the all-parameter bound

\[
W\ge\frac{C_m\sqrt t(1-t)}{1+2C_m\sqrt t}.
\tag{S14}
\]

It includes probability zero and one, and does not divide by $p_i$ or $1-p_i$. Since the extra term in (S13) is nonnegative,

\[
R_{2,n}(G)\ge
\min_{2\le m\le n}
\left\{q_m+(h-1)\left[
t+\frac{C_m(\alpha_m,\beta_m)\sqrt t(1-t)}
           {1+2C_m(\alpha_m,\beta_m)\sqrt t}
\right]\right\}.
\tag{S15}
\]

If $m=n$, the nonexistent outside bidders make $q_{n+1}$ irrelevant to actual revenue. Any value for it can be used in the weaker valid pair inequality. Thus a single infinite sequence $q$ defines legitimate mechanisms for every $n$.

For (S1), $(h_n-1)\sqrt{t_n}=\lambda-1/(\sqrt2n)$. Bounds (S11) make the approximation uniform in every $m\le n$ and every sequence $q$: for all sufficiently large $n$,

\[
R_n\ge \inf_{m\ge2} f_m(q;\lambda)-\varepsilon_n,
\qquad \varepsilon_n\longrightarrow0.
\tag{S16}
\]

For example, the elementary estimates
$2C_m\sqrt{t_n}\le2/n$ and
$(1-t_n)/(1+2C_m\sqrt{t_n})\ge1-2/n-1/(2n^2)$ give a bound of order
$(\lambda+1)/n$, uniformly. No per-prior or fixed-dimension error is hidden here.
Taking the liminf and then the supremum over $q$ gives

\[
\liminf_n R_n\ge V(\lambda).
\tag{S17}
\]

Existence of the maximum in (S3) follows from compactness of the countable product $[0,1]^{\{2,3,\ldots\}}$: each $f_m$ is continuous in two coordinates, so their infimum is upper semicontinuous and attains a maximum. The function is bounded by (S11).

### 5. Upper bound for every allowed mechanism

Theorem S0 already permits an optimal member of the tier family. To make coverage of the full mechanism class explicit, the following argument also applies to an arbitrary anonymous optimum before its pointwise replacement. Existence and symmetry reduction were proved above. Let $q_{m,n}\in[0,1]$ be its total allocation to positive bidders at the profile with exactly $m$ low reports and all other reports zero. Each low bidder has allocation $q_{m,n}/m$, and total payment is at most $q_{m,n}$ by IR. The subsequent bounds do not assume a tier allocation for the original mechanism.

The optimal revenues are uniformly bounded. A feasible two-active-bidder prior has high probability $\sqrt{t_n}$ for each active bidder; IR and feasibility bound its expected revenue by expected maximum value, at most $1+2h_n\sqrt{t_n}=1+2\lambda$. Choose a subsequence attaining $\limsup_nR_n$ and use a diagonal subsequence so that $q_{m,n}\to q_m\in[0,1]$ for every fixed $m\ge2$.

Fix any such $m$. Let $\alpha=1-q_m/m$, $\beta=1-q_{m+1}/(m+1)$, and choose a minimizer $(s,b)$ in (S9). For $n>m$ define rate coefficients

\[
z_{i,n}=s/m\quad(i\le m),\qquad
z_{i,n}=b/(n-m)\quad(i>m).
\]

They have total mass $T=s+b\le2$, and

\[
e_2(z_n)=1-\frac{b^2}{2(n-m)}\longrightarrow1.
\tag{S18}
\]

For all sufficiently large $n$, at least two coefficients are positive. There is a unique scale $a_n>0$ such that independent Bernoulli high probabilities

\[
p_{i,n}=\frac{a_n z_{i,n}}{1+a_n z_{i,n}}
\]

have probability exactly $t_n$ of at least two highs. This probability is continuous and strictly increasing from zero to one as $a_n$ grows. Give the first $m$ bidders low endpoint one and all others low endpoint zero. These are genuine legal original product priors for $G_n$.

Here $a_n\to0$: at any fixed $a=\epsilon>0$, the probability of exactly two highs is
$P_0(\epsilon)\epsilon^2 e_2(z_n)\ge e^{-2\epsilon}\epsilon^2/2$
for large $n$, so a root with $t_n\to0$ must eventually lie below every $\epsilon$.
The elementary symmetric expansion, with uniform remainder

\[
0\le \sum_{k\ge3}e_k(a_nz_n)
\le(a_nT)^3 e^{a_nT}/6,
\]

gives $P_0\to1$ and $a_n/\sqrt{t_n}\to1$. Consequently the weighted unique-high probability, using the actual $q_{m,n},q_{m+1,n}$, satisfies

\[
\frac{W_n}{\sqrt{t_n}}
=P_0\frac{a_n}{\sqrt{t_n}}
 \left[\left(1-\frac{q_{m,n}}m\right)s+
       \left(1-\frac{q_{m+1,n}}{m+1}\right)b\right]
\longrightarrow C_m(\alpha,\beta).
\tag{S19}
\]

At a uniquely high bidder inside the first $m$ bidders, high-type DSIC and low-type IR bound its payment by
$h_n-(h_n-1)q_{m,n}/m$. Other low bidders' total payment is at most one by IR and feasibility. The outside case uses $q_{m+1,n}/(m+1)$. Thus unique-high total revenue is at most $h_n$ times the corresponding weight plus two. No-high revenue is at most $q_{m,n}$. Multiple-high revenue is at most $h_n$ pointwise. The optimal mechanism's revenue against this one feasible prior is therefore at most

\[
q_{m,n}P_0+h_nW_n+2P_1+h_nt_n.
\tag{S20}
\]

Since $P_1=O(\sqrt{t_n})$, taking limits gives

\[
\limsup_n R_n\le q_m+\lambda C_m(\alpha_m(q),\beta_m(q)).
\]

This holds for every fixed $m$ along the same diagonal limit sequence. Hence

\[
\limsup_n R_n
\le\inf_{m\ge2}f_m(q;\lambda)\le V(\lambda).
\tag{S21}
\]

Together with (S17), this proves the first limit in (S4). The proof keeps one mechanism across all constraints; it never replaces $\sup_M\inf_F$ with $\inf_F\sup_M$. No mixture of priors is mislabeled as a product prior.

### 6. Numerator and the best scale within this family

The first-round numerator calculation, using Tang--Wang Theorem 5.1, gives
$S_n=\max\{1+(h_n-1)t_n,\ h_n[1-(1-r_n)^n]\}$, where
$\Pr(\operatorname{Bin}(n,r_n)\ge2)=t_n$.
The already-proved binomial estimates imply $n[1-(1-r_n)^n]\to1$.
This proves the second limit in (S4).

The functions $V(\lambda)$ and $V(\lambda)/\lambda$ have the following monotonicities. Since every $C_m$ is positive, each fixed sequence's infimum is nondecreasing in $\lambda$, hence so is $V$. Also

\[
V(\lambda)/\lambda
=\sup_q\inf_m[q_m/\lambda+C_m(\alpha_m,\beta_m)]
\]

is nonincreasing in $\lambda$, since $q_m\ge0$. The ratio in (S7) is therefore nonincreasing on $(0,1/\sqrt2]$ and nondecreasing on $[1/\sqrt2,\infty)$. Its minimum is attained at $1/\sqrt2$. This scale result concerns only family (S1), not all observed laws.

### 7. Finite truncation and quantitative approximation

The upper inequality in (S6) follows by dropping all constraints with $m>K$. Each finite program has a maximum by continuity and compactness. Also $U_K\le1+\sqrt2\lambda$ by (S11).

Take a maximizing vector for $U_K$. Keep $q_2,\ldots,q_K$, and set $q_m=1$ for every $m\ge K+1$. All constraints with $m<K$ are unchanged. At $m=K$, only $\beta_K$ changes, by at most $1/(K+1)$, so (S12) bounds the lost value by $2\lambda/(K+1)$.

For every tail index $m\ge K+1$, both weights are at least $1-1/m$, giving

\[
C_m\ge\sqrt2(1-1/m)
\ge\sqrt2\left(1-\frac1{K+1}\right).
\]

Thus the tail payoff is at least
$1+\sqrt2\lambda-\sqrt2\lambda/(K+1)
\ge U_K-2\lambda/(K+1)$.
This constructs an infinite feasible sequence with the asserted lower value and proves (S6). In particular, $U_K\downarrow V$.

Each $C_m$ is concave in $(\alpha,\beta)$, being an infimum of linear functions over a fixed compact set. Hence the constraints $v\le f_m(q;\lambda)$ define a compact convex feasible region after bounding $v$; this is a finite convex optimization formulation. This statement alone does not certify a floating-point optimizer's answer.

### 8. Exact certificates for computation

At $\lambda=1/\sqrt2$, let $S_m,B_m\ge0$ satisfy

\[
(S_m+B_m)^2-\frac{S_m^2}{m}\ge1.
\tag{S22}
\]

Scaling down to equality if necessary and using (S9) gives the valid upper affine bound

\[
f_m(q;1/\sqrt2)
\le(S_m+B_m)
 +(1-S_m/m)q_m-\frac{B_m}{m+1}q_{m+1}.
\tag{S23}
\]

For nonnegative rational weights $w_m$ summing to one over $2\le m\le K$, a weighted average of (S23) bounds the minimum of the $f_m$. Maximizing that affine expression over the cube is exactly its constant plus the sum of its positive coefficients. Thus rational data satisfying (S22), together with rational weights, give a fully explicit upper certificate for $U_K$ and hence for the true limiting robust optimum $V$. They are not claimed to form one product prior; they implement simultaneous bounds on one mechanism.

For a lower certificate, choose rational $q_2,\ldots,q_{K+1}$ and use the constant tail $q_m=q_{K+1}=q_{\mathrm{tail}}$ for $m\ge K+1$. All finite inequalities can be checked by the exact piecewise formula (S2), with squared comparisons only when the compared quantities are nonnegative. In the tail, the weaker uniform bound

\[
f_m(q;1/\sqrt2)\ge
q_{\mathrm{tail}}+1-\frac{q_{\mathrm{tail}}}{K+1}
=1+\frac{K}{K+1}q_{\mathrm{tail}}
\tag{S24}
\]

suffices. This proves a lower bound for all infinitely many constraints from a finite certificate, without assuming an unproved monotone tail.

A numerical solver may suggest these rational witnesses and weights. Only exact inequalities (S22)--(S24) and the affine cube maximization certify the resulting interval. An apparent optimizer convergence flag has no role in the mathematical proof.

### 9. A simple closed-form improvement

Take $\lambda=1/\sqrt2$, $q_2=1$, and $q_m=7/8$ for every $m\ge3$.
The explicit formula (S2) gives

\[
f_2=1+\frac{\sqrt{239}}{24}=:L,\qquad
f_3=\frac78+\sqrt{\frac{913}{1536}}.
\tag{S25}
\]

The first equality uses $\alpha_2=1/2$, $\beta_2=17/24$; the second uses
$\alpha_3=17/24$, $\beta_3=25/32$, both in the middle branch of (S2).
For $m\ge4$, the lower bound by the smallest weight gives

\[
f_m\ge\frac78+1-\frac{7}{8m}
\ge\frac{53}{32}>L.
\]

The last inequality follows from $239<(63/4)^2$. Also $f_3>L$: both compared radicals are positive, and

\[
(L-7/8)^2=\frac{31}{72}+\frac{\sqrt{239}}{96}
<\frac{341}{576}<\frac{913}{1536},
\]

where the first strict inequality uses $\sqrt{239}<31/2$, and the second difference is exactly $11/4608$.
Consequently the infimum over all indices is exactly $f_2=L$, so

\[
V(1/\sqrt2)\ge1+\frac{\sqrt{239}}{24},
\qquad
c_*\le\frac{24}{24+\sqrt{239}}
\approx0.608216629.
\tag{S26}
\]

The new expression is strictly smaller than the first-round upper bound
$6/(6+\sqrt{14})$, because $239>16\cdot14$.
This is an exact all-product-prior guarantee applied to original legal instances.
No numerical optimizer, finite-adversary approximation, or assertion that this constant-q-tail sequence is optimal is needed.

The original rigorous interval thus becomes

\[
2-\sqrt2\le c_*\le\frac{24}{24+\sqrt{239}}.
\]

The lower endpoint is still the attributed Tang--Wang theorem. Part VII strengthens the upper endpoint to $100000000/164615489$ using an independently verified exact rational certificate. Approximate optimization output alone is not used as proof.

### 10. Net secondary increment and limits

The first round gave a guarantee for one already-known priority mechanism and matched that mechanism only. The secondary result first reduces the **full finite binary-information optimum** exactly to count-dependent tier mechanisms by pointwise dominance after symmetrization. It then adds a matching asymptotic upper bound for every allowed randomized mechanism, the exact variational limit of the original robust optimum, and a quantitative finite approximation theorem with independent primal and upper certificates.

Classical anonymity reduction, payment identities, compactness, rare-event expansion, and minimax/dual ideas are credited as tools; their reuse does not establish novelty by itself. The precise new combination must pass independent source and correctness review. No numerical value of $V$ is claimed in this note without a separate exact certificate. The original all-$G$, all-$n$ sharp constant remains unresolved, and all new probability, optimization, and mechanism statements remain outside the three already-verified scalar Lean declarations.


## VII. 二次研究的精确有理证书与有限机制核验

### 1. Result and scope

For the variational game defined in Part VI, Theorem S1 and (S2)--(S4), the following finite
rational certificate proves

\[
\boxed{
\frac{164615489}{100000000}
\le V(1/\sqrt2)\le
\frac{164615533}{100000000}
}.
\tag{C1}
\]

Thus the exact certified interval is
\([1.64615489,1.64615533]\), of width \(11/25000000=4.4\times10^{-7}\).
The proof consists entirely of rational comparisons, and covers all infinitely
many game constraints. No numerical solver output is assumed to be optimal.

The connection to the unrestricted randomized DSIC/ex-post-IR robust auction
value is **Theorem S1 in Part VI**, proved there and independently reviewed.
The computation does not replace that mathematical proof. By that theorem, the original legal rare-high instance family has limiting ratio in

\[
\left[
\frac{100000000}{164615533},
\frac{100000000}{164615489}
\right]
\subset [0.60747608,0.60747626].
\tag{C2}
\]

Consequently its upper endpoint gives an upper bound on the original global
sharp constant \(c_*\). The original all-\(G\), all-\(n\) problem remains open;
this is not a matching global lower bound. The existing Tang--Wang lower bound
is attributed in the first-round paper and is unchanged.

### 2. The exact game evaluated here

At \(\lambda=1/\sqrt2\), write

\[
f_m(q)=q_m+c_m(q_m,q_{m+1}),\qquad
\alpha=1-q_m/m,\quad\beta=1-q_{m+1}/(m+1).
\]

The squared nonnegative radical is rational whenever the coordinates are
rational:

\[
c_m^2=
\begin{cases}
\beta^2,&\alpha\ge\beta,\\
\beta^2-m(\beta-\alpha)^2,
 &\alpha<\beta<m\alpha/(m-1),\\
\alpha^2m/(m-1),&\beta\ge m\alpha/(m-1).
\end{cases}
\tag{C3}
\]

This is formula (S2) in Part VI, after multiplying by \(\lambda\).
The verifier uses rational branch comparisons and squares an inequality only
after checking the compared signs.

### 3. A finite certificate for the infinite lower bound

Use \(K=8\). The following integer numerators specify the sequence exactly;
every denominator is \(10^8\).

| Index \(m\) | Numerator of \(q_m\) |
|---:|---:|
| 2 | 100000000 |
| 3 | 86160000 |
| 4 | 80615656 |
| 5 | 77410492 |
| 6 | 75291951 |
| 7 | 73788529 |
| 8 | 72737287 |
| \(m\ge9\) | 72692427 |

Let \(L=164615489/10^8\). All seven indices \(2\le m\le8\)
lie in the middle branch of (C3), and the exact verifier checks

\[
c_m^2-(L-q_m)^2>0.
\tag{C4}
\]

Here every \(L-q_m\) is positive, so (C4) implies \(f_m>L\)
without introducing any spurious solution by squaring. All seven positive
rational remainders are retained in `limit_game_exact_verification.json`.
For example, the first is \(181290879/10^{16}\).

For the infinite tail, let \(q=72692427/10^8\). At each \(m\ge9\)
both weights are at least \(1-q/m\). The normalized pair constraint underlying
formula (S2) in Part VI implies \(c_m\ge1-q/m\). Hence

\[
f_m\ge1+q-\frac q9
=\frac{61730809}{37500000}
=L+\frac1{60000000}>L.
\tag{C5}
\]

This verifies all tail indices at once. No extrapolation of the numerical
prefix and no unproved eventual monotonicity are used.

### 4. A rational affine upper certificate

For every \(m=2,\ldots,8\), the next table gives nonnegative
\(S_m,B_m,w_m\). The displayed columns are integer numerators with the
specified common denominators.

| \(m\) | \(10^{10}S_m\) | \(10^{10}B_m\) | \(10^{12}w_m\) |
|---:|---:|---:|---:|
| 2 | 6586680664 | 4444737246 | 831646583290 |
| 3 | 3275633322 | 6901625210 | 138317610621 |
| 4 | 2225428326 | 7836287871 | 25271399943 |
| 5 | 1687501300 | 8340934877 | 4099021375 |
| 6 | 1394631916 | 8621563289 | 583388032 |
| 7 | 1547239960 | 8469845100 | 73477196 |
| 8 | 6951427191 | 3346159541 | 8519543 |

The weight numerators sum to \(10^{12}\). All seven exact normalization
remainders satisfy

\[
(S_m+B_m)^2-S_m^2/m-1>0.
\tag{C6}
\]

By the compact variational representation in Part VI, Sections 2 and 8,
scaling each pair down to equality in (C6) gives the affine majorant

\[
f_m(q)\le S_m+B_m+
\left(1-\frac{S_m}{m}\right)q_m-
\frac{B_m}{m+1}q_{m+1}.
\tag{C7}
\]

For a single common vector \((q_2,\ldots,q_9)\), its minimum payoff is no
larger than the weighted average of (C7). Write that affine expression as
\(A_0+\sum_{j=2}^9A_jq_j\). Its maximum over the entire cube
\([0,1]^8\) is exactly \(A_0+\sum_j\max\{A_j,0\}\).
The exact result from the displayed table is

\[
A_0+\sum_j\max\{A_j,0\}
=\frac{230461744933546412459183}
        {140000000000000000000000}
<\frac{164615533}{100000000}.
\tag{C8}
\]

The final strict slack is
\(1266453587540817/140000000000000000000000\).
Every coefficient and each normalization remainder is retained in the JSON
receipt. Dropping the constraints \(m\ge9\) enlarges the game, so (C8)
upper-bounds both \(U_8\) and \(V\). The argument uses simultaneous
constraints on one vector; these weights are not mislabeled as one product
prior, nor is any interchange of maximum and minimum invoked.

### 5. Independent simple-sequence check

The same verifier checks the closed-form construction in Part VI, Section 9:
\(q_2=1\), \(q_m=7/8\) for \(m\ge3\). Its exact infimum is

\[
1+\sqrt{239}/24.
\]

The \(m=2\) and \(m=3\) squared radicals are respectively
\(239/576\) and \(913/1536\). The latter exceeds the needed radical
comparison using \(\sqrt{239}<31/2\); the remaining rational slack is
\(11/4608\). All \(m\ge4\) have payoff at least \(53/32\), which
strictly exceeds the first payoff. This reproduces the exact simple bound
\(c_*\le24/(24+\sqrt{239})\), by Theorem S1 in Part VI.

The rational lower endpoint in (C1) strictly improves this simple sequence:
the verifier checks \(L>1\) and \((L-1)^2>239/576\).

### 6. Finite mechanism implementation checks

`verify_secondary_mechanism.py` implements the new allocation rule directly:
uniform allocation among high reports; otherwise total allocation probability
\(q_m\), split uniformly among the \(m\) positive low reports. It uses
the frozen finite-grid canonical-payment implementation to build all payments.

For each \(n=2,3,4,5\) and \(h\in\{3/2,7\}\), it checks every grid
report profile, including profiles with zero probability under a selected
prior, for feasibility, DSIC, and ex-post IR. At \(h=7\), for every set
\(I\) of at least two bidders with low endpoint one, it verifies all high
subsets. This gives 1,044 exact payment-case checks. Four rational product
scenarios per set, including zero and one high probabilities, give 168 checks
of both the second-statistic constraint and the expected-revenue identity

\[
\operatorname{Rev}
=q_m+(1-q_m)(P_1+t)+(h-1)(W+t).
\tag{C9}
\]

It also checks the manuscript's finite \(W\) lower inequality on those
scenarios, with nonnegative-square comparisons. These are finite implementation
cross-checks. The general all-\(n\), all-real-report mechanism theorem and
the exact support reduction remain mathematical dependencies of the
manuscript; finite enumeration cannot certify them.

### 7. Numerical provenance and stopping point

Exploration used Python 3.12.14, NumPy 2.3.5, and SciPy 1.17.0. Only
\(K=4\) and \(K=8\) were explored, each with and without the constant-tail
constraint. The SLSQP routine received analytic gradients.

| \(K\) | Program | Candidate value | Solver status |
|---:|---|---:|---|
| 4 | Finite prefix | 1.6483292848725684 | Success |
| 4 | Prefix plus constant-tail bound | 1.6460200811349406 | Success |
| 8 | Finite prefix | 1.6461553208924176 | Line-search warning |
| 8 | Prefix plus constant-tail bound | 1.6461549040241460 | Success |

The \(K=8\) finite-prefix run reported a positive directional derivative;
its largest constraint discrepancy was about \(1.9\times10^{-13}\).
That flag and the apparent numerical accuracy are **not proofs**. Only the
rounded rational adversary data and exact inequalities (C6)--(C8) are used in
the upper bound. The exploratory output is retained without changing the
warning into a success flag. Once the exact width in (C1) was attained, no
larger truncation or further numerical search was run.

### 8. Reproduction and artifacts

From the [historical case directory](evidence/), the following exact certificate checks are read-only:

```bash
python secondary/code/verify_limit_game.py
python secondary/code/verify_secondary_mechanism.py
```

The first verifier uses Python's standard library only. The second imports
the frozen finite checker, which has the recorded SymPy 1.14.0 dependency.
Neither command invokes SciPy, regenerates candidates, or writes bytecode for
local imports. To create a separate exact receipt explicitly, add
`--write-results PATH`.

The complete rational witness is
`secondary/results/limit_game_certificate.json`, SHA-256
`169bf1fa1872d4422775e625f5a491ac97a1e9962ec35747af6a937e71a86b00`.
Exact checks are retained in `limit_game_exact_verification.json` and
`secondary_mechanism_exact.json`. The approximate exploration is stored
separately in `limit_game_exploratory.json`.

Optional provenance commands, unnecessary for verification, are:

```bash
python secondary/code/build_limit_certificate.py
python secondary/code/explore_limit_game.py
```

The builder reads the saved numerical candidates, rounds the primal to
denominator \(10^8\), rounds each adversary component upward to denominator
\(10^{10}\), and checks normalization exactly. It uses the stationarity
recurrence only to suggest positive weights, rounds and normalizes them,
then passes the complete witness through the exact verifier. The accepted
proof would be unchanged if the same rational data were proposed by any
other method.

These computations do not add to the three first-round scalar Lean
checkpoints. The new game, infinite tail, affine certificate rule, auction
reduction, and limiting optimality theorem are not claimed to be formalized.

## VIII. 有限反推与全尺度唯一等化

### 1. 小尺度有限反推和有理区间

取原稿 S2–S5 的 \(C_m,f_m,U_K(\lambda)\)。在 \(0<\lambda\le1/\sqrt2\) 上，可把多维可行性 \(U_K(\lambda)\ge z\) 精确归约为 \(K-1\) 个依次求解的单调标量问题。这也覆盖原稿给出最紧数值证书的参数。定义和截断误差见式 (S2)–(S5)。

设 \(r_{K+1}=0\)。依次对 \(m=K,K-1,\ldots,2\)，把 \(q_{m+1}\) 固定为 \(r_{m+1}\)，令 \(r_m\) 为 \([0,1]\) 中满足 \(f_m(q_m,r_{m+1};\lambda)\ge z\) 的最小 \(q_m\)。集合为空即判失败。所有步骤成功当且仅当 \(U_K(\lambda)\ge z\)，成功时所得向量本身为证书。

**证明。** \(C_m\) 对两坐标均非降。在中间分支其 \(\alpha\) 导数为 \(2m(\beta-\alpha)/C_m\)。令 \(x=(\beta-\alpha)/\beta\in[0,1/m]\)，导数为 \(\sqrt2 m x/\sqrt{1-mx^2}\)，递增到 \(\sqrt{2m/(m-1)}\)。另两分支的斜率为零或同一上界。因此 \(f_m\) 对第一坐标的增量至少为 \((1-\lambda\sqrt{2m/(m-1)}/m)\Delta q_m>0\)，对第二坐标非增。任何可行向量均有 \(q_{K+1}\ge0\)。若已知 \(q_{m+1}\ge r_{m+1}\)，则降低该坐标保留当前不等式，故 \(q_m\ge r_m\)。反向归纳给出必要性；逐行定义给出充分性。

端点比较决定无解或 \(r_m=0\)，其余情形有唯一根。对代数输入，各分支比较和根隔离均可用实代数数完成，故可以作精确判定；浮点二分单独使用只给近似。取 \(K=24,\lambda=1/\sqrt2\)，独立整型核算进一步给出
\[
 1.646154911812389\ \le V(1/\sqrt2)<1.646154911812390 .
\]
下证置 \(q_{25}=1\)，反向将所需根向上舍入，并以常数一延拓。对 \(m\ge25\)，常数尾有 \(f_m\ge2-1/m\)（将 \(C_m\) 两个坐标均降至 \(1-1/m\) 即得）。上证置 \(q_{25}=0\)，反向逐行保留所需根的下界，出现空可行域即排除该水平。网格分母 \(10^{15}\)，分支判别和平方比较均为整数运算；可独立运行的整数算术见 [K=24 阈值核验](evidence/secondary/code/verify_k24_threshold.py)。

此判据配合原稿 \(U_K-2\lambda/(K+1)\le V\le U_K\) 控制无限维误差，仍限于原稿的罕见高值分布族。

### 2. 全尺度无限轨道定理

### 精确表述

固定 $\lambda>0$ 并写 $\theta=\sqrt2\lambda$。令 $V=V(\lambda)$ 为原式 (S3) 的最优值，其中 $m\ge2$，
$x=q_m$、$y=q_{m+1}$。式 (S2) 的第三段要求 $1-y/(m+1)\ge (m-x)/(m-1)$，在 $[0,1]^2$ 中只可能为边界 $x=1,y=0$。因此两段可统一为

$$
f_m(x,y)=x+\theta\sqrt{(1-y/(m+1))^2
                     -(x-my/(m+1))_+^2/m}.
$$

**定理。** 对每个 $\lambda>0$，最优数列唯一，所有层的目标值相等，即 $f_m(q_m,q_{m+1})=V$。它满足 $q_m>q_{m+1}>0$ 以及
$$
q_m=A+\theta A/m+O(m^{-2}),\qquad A=V-\theta>0 .
$$
给定最优尾部，只有首层的最大值等于全局值，即
$V=\max_{0\le x\le1}f_2(x,q_3)$；每个 $m\ge3$ 的相应最大值严格大于 $V$。在充分高的各尾层，可用任何 $[0,1]$ 末端值反推；固定尾坐标的误差随末端推远按阶乘下降。有限首段依严格余裕及首层唯一最大点确定。所给结构适用于之前已证明的全机制稀有高值族极限。

### 证明

写 $\beta=1-y/(m+1)$、$d=(x-my/(m+1))_+$。在单位方形内 $0\le d\le\beta$。对固定 $x,y$，随 $m$ 增大 $\beta$ 增而 $d^2/m$ 减；$y>0$ 时改进严格。对固定 $x$ 和 $y>0$，$f_m$ 对 $y$ 严格递减：在 $d>0$ 的区域，根号关于 $y$ 的导数为 $-(\beta-d)/[(m+1)\sqrt{\beta^2-d^2/m}]$，且 $\beta-d=1-x+(m-1)y/(m+1)>0$；在 $d=0$ 区域导数为 $-1/(m+1)$。该函数在闭区间上非增。对固定 $y$，从左端开始是斜率一的线性段，随后严格凹，且唯一最大点是

$$
x_m^*(y)=\min\{1,my/(m+1)+m\beta/\sqrt{m+\theta^2}\}.
$$

尤其 $V\le Z:=\max_x f_2(x,0)<1+\theta$；直接求导给 $Z=1+\theta/\sqrt2$ 当 $\theta\le\sqrt2$，否则 $Z=\sqrt{\theta^2+2}$。在紧积空间 $[0,1]^{\mathbb N_{\ge2}}$ 内，逐层连续值的下确界是上半连续的，故最优值取得。同时 $V>\theta$。取 $M>4\theta+2$，令 $m\ge M$ 的坐标均为正小数 $\varepsilon$。由 $\sqrt{\beta^2-d^2/m}\ge\beta-d/\sqrt m$，这些层至少为 $\theta+\varepsilon/2$。对 $m<M$，依次令 $q_m=d_m\varepsilon$，其中 $d_M=1$、$d_m=1+\theta d_{m+1}/(m+1)$。每个有限首层的一阶展开为 $\theta+\varepsilon+O(\varepsilon^2)$。充分小的 $\varepsilon$ 使全部坐标合法且得到严格下界。

对试探目标 $z>\theta$，给定 $y$ 定义 $R_m(z,y)$ 为使 $f_m(x,y)\ge z$ 的最小 $x\in[0,1]$，无解记无穷。它随 $y,z$ 非减，且随 $m$ 非增。若存在则 $x>0$ 且 $f_m(x,y)=z$，因为 $f_m(0,y)\le\theta$。固定 $Z<Z'<1+\theta$，选择 $M$ 足够大，使 $m\ge M$ 时满足
$1+\theta(1-1/m)>Z'$ 且 $\theta/\sqrt{m(m-1)}\le1/2$。
单位方形上 $f_m(1,y)\ge f_m(1,1)\ge1+\theta(1-1/m)$，故 $z\in(\theta,Z']$ 时这些尾层均有根。尾层的 $x$ 斜率至少 $1-\theta/\sqrt{m(m-1)}\ge1/2$。此外
$(\beta-d)^2\le\beta^2-d^2/m$，所以 $y$ 的斜率绝对值不超过 $\theta/(m+1)$。根映射相应是 $2\theta/(m+1)$-Lipschitz。给一个任意末坐标 $q_{K+1}\in[0,1]$，从 $K$ 反推到固定 $m\ge M$ 时，两种末边界产生的误差至多

$$
\prod_{k=m}^K\frac{2\theta}{k+1}.
$$

把更远的有限反推在 $K+1$ 的结果也视作边界，得到逐坐标一致收敛、唯一尾部和关于 $z$ 的连续性。对于低于 $M$ 的有限各层，继续取最小根。一个可行数列逐项大于或等于从任意零尾边界反推的坐标；令 $K$ 增大可知它逐项支配所算尾部，再依次支配有限首层。相反，当首层的根都存在时，反推数列本身可行。

在任一可行 $z>\theta$ 处，可等价地从全零数列同步反复应用 $R_m$。所得数列递增且被任何可行解支配。根是随 $m$ 不增、随其后继不减的，所以每一步的坐标都随层号非增。逐坐标取极限后由连续性仍满足各层等式，并给逐项最小可行解 $r_m$。这与上面的尾部最小解一致。因为所有 $r_m>0$，有
$f_{m+1}(r_m,r_{m+1})>f_m(r_m,r_{m+1})=z$，
而 $r_{m+2}\le r_{m+1}$；将 $r_m$ 用作下一层当前坐标得到严格余裕，所以其最小根满足 $r_{m+1}<r_m$。

对 $j\ge3$，在相同正后继处提高层号使目标严格变大，且换为更小的后继只能提高目标。因此
$$
\max_x f_j(x,r_{j+1})>\max_x f_{j-1}(x,r_j)\ge z.
$$
这些最小根都位于严格可行域，因而靠近该 $(z,r_{j+1})$ 时连续。这可由上升分支的单调性或用根两侧的严格不等式得出。取 $z=V$，若第 2 层也有严格余裕，从连续尾部经过有限次严格可行反推，可稍增 $z$ 而仍可行，与最优矛盾。故首层的最大值等于 $V$。最小尾部随 $z$ 非减，首层的最大值随其后继非增，所以这一瓶颈方程至多一根。

若另一个最优解某层 $j\ge3$ 严格大于最小根，利用上一层对正后继的严格单调性，在 $x=r_{j-1}$ 时目标会严格低于 $V$，故必须有 $q_{j-1}>r_{j-1}$。逐层传到 $q_3>r_3$ 会使第 2 层最大值严格小于 $V$，矛盾。最高点唯一使 $q_2$ 也唯一。最后从等化式及 $x,y\in[0,1]$ 得 $q_m=A+O(m^{-1})$，所以 $d=O(m^{-1})$。根号和 $\beta$ 之差是 $O(m^{-3})$，得到
$q_m=A+\theta q_{m+1}/(m+1)+O(m^{-3})$，即所述渐近。若需实现反推，在线性段取线性根，余下上升分支上的根由一次平方后的二次方程和符号约束确定。

### 贡献范围

上批针对单个 $\lambda$ 用有限前缀反向标量可行性得到数值区间。这里闭合全部正 $\lambda$ 的最优性结构、唯一性、任意尾边界的阶乘阶误差和首层瓶颈，同时保留原论文对全部机制的归约。原全分布常数 $c_*$ 的匹配下界仍未确定；本稿只解式 (S3) 指定的稀有高值分布族。极限族与全分布上界的关系见式 (S3) 及第 VIII 节第 1 小节。

## 参考文献与已有归属

1. Zhihao Gavin Tang and Shixin Wang. *Robust Mechanism Design with Anonymous Information*. arXiv:2602.20429v3, 2026-11-05. [官方全文](https://arxiv.org/html/2602.20429v3)。主要读取 §2，Theorems 4.1、5.1、5.3，§5.3 完整证明及 §6。原问题、已有常数、consistent-iid reserve 公式和具体 Myerson 支持外延拓归属该文。
2. Jason D. Hartline. *Mechanism Design and Approximation*, Chapter 4, Corollary 4.4.3, pp.129–130. [作者书稿](https://jasonhartline.com/MDnA/MDnA-ch4.pdf)。既有二点 iid 例归属该书；结合上述 Theorem 4.1 的 $n=2$ 情形给旧上界 $2/3$。
3. Yiannis Giannakopoulos and Johannes Hahn. *Discrete Single-Parameter Optimal Auction Design*. ACM Transactions on Economics and Computation 14(3), Article 11, 2026. [DOI](https://doi.org/10.1145/3789259)；[正式发表版机构存档](https://eprints.gla.ac.uk/378726/1/378726.pdf)。§3 LP2、Lemma 3.4 的有限单参数最大支付公式为已知成分。

4. Jerry Anunrojwong, Santiago R. Balseiro and Omar Besbes. *Robust Auction Design with Support Information*. Definition 2、Theorem 1 已在已知区间支持、同分布及完全信息基准的模型中刻画 pooling。此处的模糊集允许独立异质边际，只固定第二高估值分布。[作者稿](https://jerryanunroj.github.io/papers/a-b-paper.pdf)

完整近邻范围、差异和文献获取限制见 SOURCES.json、LITERATURE_SCREEN.md 及独立查新记录。没有把检索未发现等同于优先权证明。

## 形式化与计算覆盖

原版形式化档案记录，三个独立标量代数引理已通过 Lean 内核、公理审计和独立复编；它们只覆盖二次型恒等式及有限不等式的标量推导。有限支付、全实值 DSIC、产品支持归约、完整概率二次型、机制收益、有限最优机制归约、完整变分极限、截断与证书转移、上界极限及比较障碍仍待等强形式化。Python 精确分数、符号恒等式及有理区间证书验证与 Lean 核验是不同层次。本稿的完整 Lean 另行交付。
