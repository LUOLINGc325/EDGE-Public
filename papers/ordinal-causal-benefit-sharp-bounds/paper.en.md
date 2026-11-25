# Sharp ordinal treatment-benefit bounds under local diagonal tail dominance

## Abstract

For an ordinal outcome, the probability that an individual benefits from treatment depends on the joint distribution of two potential outcomes. Mandel and Rodan derived lower bounds under diagonal tail dominance at selected control levels. We prove that each lower bound is attainable under its corresponding assumption and give the complete identified interval. More generally, we characterize the attainable vector of threshold-exceedance masses and derive closed-form endpoints under arbitrary stratum-specific lower and upper restrictions. A construction using a single uniform random variable realizes every admissible total. For simultaneous restrictions on strict benefit and non-harm, two inequalities per level, together with coordinate bounds, describe the complete joint profile. A three-level example has sharp upper probability of strict benefit $13/36$, improving the $17/36$ upper bound from the source's implementation. On the published stroke-trial margins, we certify that its upper bound of $0.78276$ is attainable even under both local dominance conditions. [Mandel and Rodan, §§4.5–5](https://arxiv.org/html/2606.15754v1#S4.SS5) · [Authors' upper-bound implementation](https://github.com/MichaMandel/Ordinal-bounds/blob/32734b14b7164fc3223ec2d3fde7d42fcaa99b61/analyze_ordinal_marginals.R#L226-L257)

## 1. The identification problem

Write $X=Y(1)$ and $Y=Y(0)$ for the potential outcomes under treatment and control. Larger outcomes are more favorable. Known marginal distributions determine neither $\eta=\Pr(X>Y)$ nor $\tau=\Pr(X\ge Y)$. Lu, Ding and Dasgupta gave sharp bounds for each parameter over all joint laws with those marginals. Huang, Fang, Hanley and Rosenblum analyzed bounds for benefit under restrictions on the joint table using linear programming. Mandel and Rodan introduced local open- and closed-tail diagonal tail dominance (DTD) and derived lower bounds for $\eta$ and $\tau$ in their Proposition 4. That proposition establishes the inequalities. The question we address is which values and which stratum-specific profiles can actually occur under the stated restrictions. [Lu, Ding and Dasgupta (2018)](https://arxiv.org/abs/1507.01542) · [Huang et al. (2017)](https://doi.org/10.1093/biostatistics/kxw049) · [Mandel and Rodan (2026), Proposition 4](https://arxiv.org/html/2606.15754v1#S4.SS5)

Let $Y$ take levels $1,\ldots,J$ with probabilities $c_j$. Let $F$ be the distribution function of the real-valued $X$. Fix real thresholds $\theta_1\le\cdots\le\theta_J$, and define

$$
 g_j=\Pr(Y=j,\ X>\theta_j),\qquad t=\sum_{j=1}^Jg_j.
$$

Assume $0\le a_j\le g_j\le b_j\le c_j$. These restrictions may represent bounds on the conditional exceedance probability multiplied by $c_j$. They also cover $c_j=0$. Write $C_k=\sum_{j\le k}c_j$, $A_k=\sum_{j\le k}a_j$, $B_k=\sum_{j\le k}b_j$, with all three sums zero at $k=0$. Put $f_k=F(\theta_k)$.

## 2. Profiles, endpoints and attaining laws

**Theorem 1 (threshold profiles).** A vector $0\le g_j\le c_j$ occurs under the specified marginals if and only if every $1\le k\le J$ satisfies

$$
 \sum_{j\le k}(c_j-g_j)\le f_k,\qquad
 \sum_{j\ge k}g_j\le 1-f_k. \tag{1}
$$

For the bands $[a_j,b_j]$, define

$$
 \begin{split}
 L&=\max\left\{A_J,\ \max_{1\le k\le J}
              (C_k-f_k+A_J-A_k)\right\},\\
 H&=\min\left\{B_J,\ \min_{1\le k\le J}
              (1-f_k+B_{k-1})\right\}.
 \end{split} \tag{2}
$$

The identified set is nonempty precisely when $L\le H$ and, for every $k$,

$$
 B_k\ge C_k-f_k,\qquad A_J-A_{k-1}\le1-f_k. \tag{3}
$$

When these conditions hold, the identified set of $t$ is the entire closed interval $[L,H]$. Its lower endpoint depends on the lower bands and its upper endpoint on the upper bands. The formulas take $O(J)$ arithmetic operations once the $f_k$ are available.

*Proof.* The events $\{Y=j,X\le\theta_j\}$ for $j\le k$ are disjoint and their union lies in $\{X\le\theta_k\}$. The events $\{Y=j,X>\theta_j\}$ for $j\ge k$ lie in $\{X>\theta_k\}$. This proves necessity of (1).

For sufficiency, let $U$ be uniform on $(0,1)$ and take $X=F^{-1}(U)$, with $F^{-1}(u)=\inf\{x:F(x)\ge u\}$. Partition $(0,1-t]$ from left to right into consecutive intervals of lengths $c_j-g_j$, in increasing order of $j$. Partition $(1-t,1]$ in the same order into intervals of lengths $g_j$. Set $Y=j$ on the two intervals labeled $j$. Its probability is $c_j$. The first interval ends at $\sum_{i\le j}(c_i-g_i)\le f_j$. The second interval starts at $1-\sum_{i\ge j}g_i\ge f_j$. Since $F^{-1}(u)\le\theta_j$ exactly when $u\le f_j$, these intervals give the requested exceedance masses. Endpoints have zero probability under $U$. The argument permits atoms of $X$, repeated thresholds and empty intervals.

Fix $t\in[A_J,B_J]$. Start at $g_j=a_j$ and distribute $t-A_J$ additional mass in increasing order of $j$, filling each coordinate up to $b_j$ before moving on. The resulting cumulative masses are

$$
 G^t_k=A_k+\min\{B_k-A_k,t-A_J\}
       =\min\{B_k,t-A_J+A_k\}. \tag{4}
$$

Every profile with this total and these bands satisfies $G_k\le G^t_k$, by its prefix upper bounds and its suffix lower bounds. Both inequalities (1) favor a larger prefix, since they read $G_k\ge C_k-f_k$ and $t-G_{k-1}\le1-f_k$. Thus the constructed profile suffices whenever the total is attainable. Substitution of (4) in the first inequality gives $B_k\ge C_k-f_k$ and $t\ge C_k-f_k+A_J-A_k$. The second gives $t\le1-f_k+B_{k-1}$ and $A_J-A_{k-1}\le1-f_k$. Intersecting with $[A_J,B_J]$ proves (2)–(3), including attainment of every admissible total. $\square$

## 3. Sharpness under local dominance

Suppose both outcomes take values $1,\ldots,J$. For a set $D$ of control levels, local open-tail DTD imposes $\Pr(X>j,Y=j)\ge c_j\Pr(X>j)$ for $j\in D$. Local closed-tail DTD imposes $\Pr(X\ge j,Y=j)\ge c_j\Pr(X\ge j)$ for $j\in D$. Each is a restriction on a joint distribution with known marginals. [Mandel and Rodan, §§4.4–4.5](https://arxiv.org/html/2606.15754v1#S4.SS4)

**Corollary 2.** Under local open-tail DTD, take $\theta_j=j$. Under local closed-tail DTD, take $\theta_j=j-1$. For each problem set $b_j=c_j$ and $a_j=\mathbf1_{\{j\in D\}}c_j(1-f_j)$. Formula (2) gives the sharp interval for $\eta$ and $\tau$, respectively. In each case the lower endpoint equals the corresponding expression in Mandel and Rodan, Proposition 4. The upper endpoint equals the sharp upper bound obtained from the marginals alone. [Published lower bounds, equations (8) and (9)](https://arxiv.org/html/2606.15754v1#S4.SS5)

*Proof.* Independent $X,Y$ satisfy the bands and ensure feasibility. Write $\Delta_j=\Pr(X\ge j)-\Pr(Y\ge j)$. In the open-tail case $C_k-F(k)=\Delta_{k+1}$ for $k<J$. The $A_J$ term corresponds to $j=1$, and the $k=J$ term is zero. This yields equation (8) of the source. In the closed-tail case $C_k-F(k-1)=c_k+\Delta_k$, and the $k=1$ term is at least $A_J$. This yields its equation (9). In both cases $B_k=C_k$, so (2) gives the same $H$ as under the unrestricted bands $[0,c_j]$. Theorem 1 attains both endpoints. $\square$

For example, let both margins be uniform on three levels. Requiring only $g_1\le1/9$ and $g_2\ge1/9$ for strict benefit gives the sharp interval $[1/9,4/9]$. The unrestricted interval is $[0,2/3]$. This illustrates how lower and upper restrictions at different levels affect the two endpoints separately.

## 4. Simultaneous strict benefit and non-harm

Let $r_j=\Pr(X=j)$, $F_k=\sum_{j\le k}r_j$ and $F_0=0$. In this section the two outcomes share the levels $1,\ldots,J$. Define

$$
 u_j=\Pr(X>j,Y=j),\qquad v_j=\Pr(X\ge j,Y=j).
$$

**Theorem 3 (joint profiles).** The pair $(u,v)$ is attainable exactly when, for every $j$,

$$
 \begin{gathered}
 0\le u_j\le v_j\le c_j,\qquad v_j-u_j\le r_j,\\
 \sum_{i<j}u_i+v_j\ge C_j-F_{j-1},\qquad
 u_j+\sum_{i>j}v_i\le1-F_j. \tag{5}
 \end{gathered}
$$

Consequently any simultaneous local restrictions on the two profiles can be imposed directly on (5). For linear restrictions, projection under $(u,v)\mapsto(\sum_j u_j,\sum_j v_j)$ gives the sharp joint identified set of $(\eta,\tau)$ using $2J$ variables. In particular any linear contrast of the two probabilities can be bounded by two linear programs in these variables.

*Proof.* Reserve diagonal mass $d_j=v_j-u_j$ at $(j,j)$. The remaining treated mass at level $j$ is $r_j-d_j$. The remaining mass required below the threshold in control stratum $j$ is $c_j-v_j$, which must be assigned to $X<j$. Its remaining mass above the threshold is $u_j$, assigned to $X>j$. The required prefix and suffix conditions are

$$
 \sum_{i\le j}(c_i-v_i)\le\sum_{i<j}(r_i-d_i),\qquad
 \sum_{i\ge j}u_i\le\sum_{i>j}(r_i-d_i).
$$

Expanding these two inequalities gives exactly (5). To see their sufficiency, partition a rank interval of length $1-\sum_jd_j$ into treated-level intervals of lengths $r_j-d_j$ in increasing order. Starting at its left endpoint, place consecutive intervals of lengths $c_j-v_j$ in increasing order of $j$. Continue with intervals of lengths $u_j$ in increasing order of $j$. The prefix conditions put each interval of the first kind entirely among treated levels below $j$. The suffix conditions put each interval of the second kind among treated levels above $j$, up to endpoints of zero length. The intersections give the residual joint table. Adding the reserved diagonal masses completes the construction, including the case of zero residual mass. $\square$

**A strict improvement over a cross-tail bound.** Mandel and Rodan's companion code also gives upper bounds for strict benefit under local closed-tail DTD. Take treated probabilities $r=(1/2,1/3,1/6)$, control probabilities $c=(1/3,1/2,1/6)$, and $D=\{2,3\}$. The three upper-bound candidates in their implementation are $17/36,17/36,30/36$, giving $17/36$. The sharp upper endpoint is $13/36$. To see this, use mass units of $1/36$. Closed-tail DTD requires $v_2\ge9$ and $d_3=v_3\ge1$. Only six units are at treated level 3, so $u_2\le6-d_3\le5$, and $d_2=v_2-u_2\ge4$. The 18 units at $X=1$ and the diagonal masses at levels 2 and 3 are disjoint and all exclude strict benefit. The bound $36\eta\le36-18-4-1=13$ is attained by the table

$$
 \frac1{36}\begin{pmatrix}4&9&5\\8&4&0\\0&5&1\end{pmatrix},
$$

with rows indexed by treatment and columns by control. This table also satisfies local open-tail DTD on $D$. The same value is therefore sharp under both assumptions. [Mandel and Rodan, companion code, closed-tail upper bound](https://github.com/MichaMandel/Ordinal-bounds/blob/32734b14b7164fc3223ec2d3fde7d42fcaa99b61/analyze_ordinal_marginals.R#L243-L257)

## 5. Application to trial margins

Mandel and Rodan's Table 3 gives treated counts $(49,13,52,43,49,27)$ and control counts $(59,32,81,44,35,16)$ in increasing order of their six recoded outcome levels. We use their local dominance set $D=\{4,5,6\}$. The quantities below are sharp identification intervals at those empirical margins. Sampling uncertainty would require a separate analysis. [Mandel and Rodan, §5 and Table 3](https://arxiv.org/html/2606.15754v1#S5) · [Berkhemer et al., original MR CLEAN trial](https://doi.org/10.1056/NEJMoa1411587)

| Parameter | DTD assumption | Exact interval, multiplied by $62{,}211=233\cdot267$ |
| --- | --- | --- |
| Strict benefit $\eta$ | Open-tail on $D$ | $[13927,49128]$ |
| Strict benefit $\eta$ | Both on $D$ | $[13927,48696]$ |
| Non-harm $\tau$ | Closed-tail on $D$ | $[31850,62211]$ |
| Non-harm $\tau$ | Both on $D$ | $[31850,62211]$ |

The lower endpoints reproduce the source's $0.224$ and $0.512$ after rounding. Its companion implementation also yields the upper candidate $48696/62211$ for strict benefit under local closed-tail DTD. At control level 6 the restriction requires $\Pr(X=6,Y=6)\ge(27/233)(16/267)$. This event and $\{X=1\}$ are disjoint and both exclude strict benefit. Their total probability gives the same upper bound. [Authors' trial analysis](https://github.com/MichaMandel/Ordinal-bounds/blob/32734b14b7164fc3223ec2d3fde7d42fcaa99b61/stroke%20data%20analysis.R#L48-L69)

$$
 \eta\le1-\frac{49}{233}-\frac{27\cdot16}{233\cdot267}
       =\frac{48696}{62211}.
$$

The following profiles certify attainment under both local assumptions. All entries are joint masses multiplied by $62{,}211$. Each row satisfies (5) and the six local lower restrictions, so Theorem 3 supplies a complete joint law. The lower bounds and $\tau\le1$ establish the other three inequalities.

| Endpoint | $u$ | $v$ |
| --- | --- | --- |
| $\min\eta$ | $(4376,3985,1277,3344,945,0)$ | $(13747,7456,15161,10252,8155,432)$ |
| $\max\eta$ | $(13747,7456,11481,10252,5760,0)$ | $(13747,7456,11481,10252,5760,432)$ |
| $\min\tau$ | $(13747,109,4094,3344,2660,0)$ | $(13747,109,9666,5236,2660,432)$ |
| $\max\tau$ | $(664,4649,4989,3760,945,0)$ | $(13747,7456,18873,10252,8155,3728)$ |

Theorem 1 concerns one exceedance event per control level. The joint calculation shows why an upper bound attained under local open-tail restrictions can decrease when the same population is also required to satisfy local closed-tail restrictions.
