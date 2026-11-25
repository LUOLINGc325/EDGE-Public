# An explicit sample-size threshold for fixed-distribution weighted conformal BH

## Abstract

Lim's fixed-distribution theorem identifies the limiting coefficient $c_0$ of the false discovery rate (FDR) excess for randomized weighted conformal Benjamini--Hochberg (BH) with one heavy calibration cell and a shared non-null threshold. It leaves open an explicit sample size at which a positive coefficient guarantees actual excess. We prove a computable bound $|\mathrm{FDR}_n-q-c_0/\sqrt n|\le K n^{-3/5}$ for every $n\ge N$. The bound applies under the original hypotheses, including degenerate two-dimensional Gaussian covariance. When $c_0>0$, $n_0=\max\{N,\lceil(2K/c_0)^{10}\rceil\}$ suffices.

## 1. Fixed-distribution model

Use Lim's model and conditions (F1)--(F4). For precision, let $B\ge1$, $0<p_0<1$, $m\ge2$, $0<q<1$ and $t_k=qk/m$. A calibration unit is heavy with probability $p_0$, weight $B$ and score $g$. Otherwise it has weight one and score $X$ uniform on $[0,1]$. Calibration is i.i.d. and independent of the i.i.d. test units, whose law is the weight tilt. Let $s=1-p_0$, $W_0=s+Bp_0$, $\gamma=s/W_0$, $Q_H=Bp_0/W_0$. Then the heavy mass of one test unit is $Q_H$ and the light density in $X$ is $\gamma$.

Heavy units are null and their tested score is $g$. A light unit is null when $X\le a:=1-\zeta$ and then has tested score $X$. Otherwise it shares a tested score $v$. We assume $0<g<v<a<1$. The p-value for tested score $z$ and test weight $w$ is $[S_{<}(z)+U(S_{=}(z)+w)]/(S+w)$, where $S$ sums calibration weights, subscripts restrict this sum by score, and each test has an independent uniform auxiliary $U$. The shared score is tuned to some grid index $k_*$:

$$
t_*:=t_{k_*}=\frac{s v+Bp_0}{W_0}.
$$

Write $b=sg/W_0$, $T=(sg+Bp_0)/W_0$ and $f_0(a)=(sa+Bp_0)/W_0$. Assume $f_0(a)>q$ and $t_k\notin\{b,T\}$ for all $k$. For a grid point in a light region ($t_k<b$ or $t_k>T$), write $I_k=0$ or $1$, respectively, and $u_k=(t_k W_0-I_k Bp_0)/s$. Then $u_k\in(0,1)$.

Given calibration, let $A_k$ be the probability of a null and $p$ at most $t_k$ and let $G_k$ be the probability of any p-value at most $t_k$. Let $\Pi_k(G)$ be the probability of exactly $k$ BH rejections for one forced zero and $m-1$ independent p-values with grid CDF $G$. Conditional expected FDP is

$$
H(A,G)=m\sum_{k=1}^m \frac{A_k}{k}\Pi_k(G),\qquad
H(A,G)-q=m\sum_{k=1}^m \frac{A_k-t_k}{k}\Pi_k(G). \tag{1}
$$

The first identity follows by replacing one test at a time with zero and multiplying its resulting rejection weight by the probability of rejection of the original independent test at that threshold. The second uses $mt_k/k=q$ and $\sum_k\Pi_k=1$. For two valid grid CDFs $G,G'$, the band-probability vectors have total variation at most $m\|G-G'\|_\infty$. The difference for any count event on $m-1$ independent band draws is then at most $D_\Pi\|G-G'\|_\infty$, where $D_\Pi=m(m-1)$.

## 2. Constants and result

For one calibration unit write $Z$ for its heavy indicator, and $\ell(x)=(1-Z)(\mathbf1\{X\le x\}-x)$, with any auxiliary uniform $X$ used on heavy outcomes. Define the mean-zero influence pair
$$\psi_k=a_k(Z-p_0)+b_k\ell(y_k),\qquad
\psi_D=(B-v-t_*(B-1))(Z-p_0)+\ell(v),$$
where
$$
(a_k,b_k,y_k)=
\begin{cases}
(\gamma B(t_k-I_k)/s^2,\ -\gamma/s,\ u_k), & t_k<b\ \text{or}\ t_k>T,\\
(Q_H(g-t_k)/(Bp_0^2),\ -Q_H/(Bp_0),\ g), & b<t_k<T.
\end{cases} \tag{2}
$$
Let $M=\max(1,\max_k(|a_k|+|b_k|))$, $\sigma_D^2=\operatorname{Var}(\psi_D)>0$. Its positivity follows from the light conditional Bernoulli at $v$. For a finite-valued centered vector $Y$ with covariance $\Sigma$ of rank $r\ge1$, use the explicit constant
$$\mathcal B(Y)=400r^{1/4}E[(Y^\top\Sigma^\dagger Y)^{3/2}],$$
where the dagger is the inverse on the covariance support and zero on its orthogonal complement. All distributions here have finite support obtained by splitting the uniform light score at at most two positions. Put $\beta_*=\max_k\mathcal B((\psi_k,\psi_D))$ and $C_D=2/\sigma_D+2\mathcal B(\psi_D)$. These constants require only finite arithmetic and roots.

Define
$$J=4B+3,\quad C_h=4B/s^2+2/s,\quad R=C_h+1+2/s,$$
and let $\Delta$ be the minimum of $|t_k-b|$, $|t_k-T|$, $f_0(a)-t_k$ over all $k$, and $|t_k-t_*|$ over $k\ne k_*$. Let $\delta$ be the minimum of
$$
1/2,\quad p_0/2,\quad s/2,\quad \Delta/(2J),\quad
\frac{\min(u_k,1-u_k)}{2(C_h+1)}
\quad\text{over each light grid point } k.
$$
The last group is omitted if there are no light grid points. Set
$$
\begin{gathered}
N=\max(2,\lceil\delta^{-5/2}\rceil),\qquad
c=\min\left(2,s,\frac{s}{4(R+2/s+1)}\right),\\
C_{\rm bad}=(4+4m)8!/c^8,\qquad
C_R=1+7/s+8B/s^3+2/(Bp_0^3)+2/(Bp_0^2)+2/p_0,\\
K=m\left(\sum_{k=1}^m k^{-1}\right)
 [C_R+(1+2M)C_{\rm bad}+MD_\Pi(M+C_R)+M\sqrt{C_D}+2\beta_*+2M^2].
\end{gathered} \tag{3}
$$
Define $G_k^0=t_k+\gamma\zeta\,\mathbf1\{k>k_*\}$ and $G_k^1=t_k+\gamma\zeta\,\mathbf1\{k\ge k_*\}$, and put $\Delta r_k=\Pi_k(G^1)-\Pi_k(G^0)$.

**Theorem.** Under the hypotheses above, for all integers $n\ge N$,
$$
\left|\operatorname{FDR}_n-q-\frac{c_0}{\sqrt n}\right|\le K n^{-3/5},
\qquad
c_0=-\frac{m}{\sqrt{2\pi}\sigma_D}\sum_{k=1}^m \frac{\Delta r_k}{k}\operatorname{Cov}(\psi_k,\psi_D). \tag{4}
$$
The coefficient is Lim's coefficient. If $c_0>0$, $n_0$ from the abstract gives the claimed lower bound for every $n\ge n_0$.

## 3. Quantitative linearization of the null masses

Let $h=N_H/n$ be the empirical heavy proportion, $L=n(1-h)$, $W(h)=1+(B-1)h$, and $\widehat F_L$ the light calibration empirical CDF. Bars denote averages of $n$ calibration influences. Set $d=n^{-2/5}$ and $e=n^{-3/5}$. First require $|h-p_0|\le d$ and $\|\widehat F_L-\mathrm{id}\|_\infty\le d$. These conditions fail with probability at most $2e^{-2n^{1/5}}+2e^{-s n^{1/5}}$ by Hoeffding and conditional DKW, since $L\ge sn/2$ on the first condition. A probability-zero set of tied light scores can be omitted.

For every light grid point $u_k$ also require
$$
\sup_{|x-u_k|\le Rd}
|(\widehat F_L(x)-x)-(\widehat F_L(u_k)-u_k)|\le e+1/L. \tag{5}
$$
Condition on the count. On a mesh with step $1/L$ in $[0,1]$, all points needed to bracket the range in (5) lie within $(R+2/s)d$ of $u_k$. At such a point the centered CDF difference, up to sign, is a mean of $L$ centered interval indicators with variance at most $(R+2/s)d$. Bernstein at level $e$ gives failure probability at most $2\exp[-c n^{1/5}]$ at each point because $L\ge sn/2$, $e\le d$, and $n e^2/d=n^{1/5}$. Between mesh points monotonicity of the empirical CDF adds at most $1/L$. A union bound over at most $m(n+1)$ points proves that the full good event fails with probability at most
$$
(4+2m(n+1))e^{-c n^{1/5}}\le C_{\rm bad}n^{-3/5}. \tag{6}
$$
The last inequality uses $e^{-x}\le 8!/x^8$, and $4+2m(n+1)\le (4+4m)n$.

On the good event the exact light p-value at tested score $x\ne g$, outside a set of light ties, is
$$
\frac{(1-h)\widehat F_L(x)+Bh\,\mathbf1\{g<x\}+U/n}{W(h)+1/n},
$$
and the exact heavy p-value is
$$
\frac{(1-h)\widehat F_L(g)+UB(h+1/n)}{W(h)+B/n}.
$$
Each differs from its population value with $h=p_0$, $\widehat F_L(x)=x$ and $1/n=0$ by at most $Jd$, including each one-sided limit at $g$. To see the bound, use that denominators are at least one and the population ratios are in $[0,1]$. The numerator and denominator differences sum to at most $(2B+1)d+2B/n$. This also applies to $x=v$. By the margins in $\delta$, every grid point stays in its assigned regime, every light grid cutoff stays below $a$, and the shared non-null atom cannot cross any $t_k\ne t_*$.

At a light grid point, for each fixed $U$ the light cutoff is the empirical inverse at
$$
h_U=\frac{t_kW(h)-I_kBh}{1-h}+\frac{t_k-U}{L}.
$$
It is in $(0,1)$: the first summand differs from $u_k$ by at most $(4B/s^2)d$ from its derivative, and the jitter term by at most $2d/s$. Write $Q_L(h_U)=X_{(\lfloor Lh_U\rfloor+1)}$ for the inverse describing the Lebesgue measure of the set $\widehat F_L(x)\le h_U$. Then $|\widehat F_L(Q_L(h_U))-h_U|\le1/L$ and $|Q_L(h_U)-u_k|\le Rd$. The local estimate (5) gives
$$
|Q_L(h_U)-h_U+\widehat F_L(u_k)-u_k|\le e+2/L.
$$
The eligible light score measure is exactly this cutoff, since the other light branch and the null boundary obey the strict margins. The heavy mass is $I_k Q_H$. The first summand in $h_U$ has derivative $B(t_k-I_k)/(1-h)^2$ and second derivative bounded in absolute value by $16B/s^3$. Also $\overline{\ell}(u_k)=(1-h)(\widehat F_L(u_k)-u_k)$ exactly. Replacing $\widehat F_L(u_k)-u_k$ by $\overline{\ell}(u_k)/s$ incurs error at most $d^2/s$. At the population point $\gamma u_k+I_k Q_H=t_k$. Therefore, after integration over $U$, the light-regime grid mass satisfies
$$
|A_k-t_k-\overline{\psi}_k|\le \gamma [e+3/L+(8B/s^3+1/s)d^2]\le C_R e. \tag{7}
$$

At a heavy-window grid point the light mass is exactly $\gamma g$. The heavy fraction below threshold is the unclipped fraction
$$
R_\varepsilon(h)=\frac{t_k(W(h)+B\varepsilon)-(1-h)\widehat F_L(g)}{B(h+\varepsilon)},\qquad
\varepsilon=1/n,
$$
which is in $(0,1)$ by the margin. The identity $R_\varepsilon=(hR_0+\varepsilon t_k)/(h+\varepsilon)$ gives $|R_0-R_\varepsilon|\le\varepsilon/h$. With $r_0$ the unjittered population fraction, direct subtraction gives
$$
R_0(h)-r_0=\frac{t_k-g}{B}(1/h-1/p_0)-\frac{\overline{\ell}(g)}{Bh}.
$$
The reciprocal expansion about $p_0$ has error at most $2d^2/p_0^3$, since $h\ge p_0/2$, and the reciprocal difference is at most $2d/p_0^2$. Thus (7) holds in this region as well, with the heavy coefficients in (2). The population mixture identity $\gamma g+Q_H r_0=t_k$ follows by substitution. These bounds use $1/n,d^2\le e$.

## 4. Switch and Gaussian approximation

Let $T_n=\sqrt n\,\overline\psi_D$, $Y_{k,n}=\sqrt n\,\overline\psi_k$. For the shared non-null score the threshold condition at $t_*$ is exactly $\sqrt n\,T_n\le t_*-U$. Thus outside $|T_n|\le1/\sqrt n$ the indicator agrees for every auxiliary with $J_n=\mathbf1\{T_n\le0\}$. Bentkus's i.i.d. convex-set Berry--Esseen theorem, applied after whitening on the linear covariance support, gives uniform convex-set error at most $\mathcal B(Y)/\sqrt n$ for sums of $Y$. Whitening is legitimate even in rank one because a centered variable with zero variance along a direction vanishes there almost surely. Applied to the scalar switch, the bound and the Gaussian density yield
$$
\Pr(|T_n|\le 1/\sqrt n)\le C_D/\sqrt n. \tag{8}
$$

On the good event the bound $|\overline\psi_k|\le Md$ and (7) give $\|A-\mathbf t\|_\infty\le(M+C_R)d$. If the switch band in (8) is avoided, $G-G^{J_n}=A-\mathbf t$, coordinatewise. By (1), first replace $A_k-t_k$ by $\overline\psi_k$, at error at most $C_R e+(1+M)C_{\rm bad}e$ per weighted term before multiplication by $m/k$. Then replace $\Pi_k(G)$ by $\Pi_k(G^{J_n})$. On the good event outside the band the product error is at most $MD_\Pi(M+C_R)d^2$. On the bad event it is bounded by $M\Pr(\mathrm{bad})$. On the switch band Cauchy--Schwarz gives the expectation bound
$$
E[|\overline\psi_k|\mathbf1\{|T_n|\le1/\sqrt n\}]
\le M\sqrt{C_D}\, n^{-3/4},
$$
since $E[\overline\psi_k^2]\le M^2/n$.

As $E\overline\psi_k=0$, the remaining expectation is exactly $\Delta r_k E[Y_{k,n}\mathbf1\{T_n\le0\}]/\sqrt n$. Let $(Y_k^G,T^G)$ be a centered Gaussian with the covariance of $(\psi_k,\psi_D)$. For each $x\ge0$, the events $\{Y_{k,n}>x,T_n\le0\}$ and $\{Y_{k,n}<-x,T_n\le0\}$ are convex-set intersections. Integrate the difference of their probabilities up to $n^{1/4}$. Berry--Esseen then gives error at most $2\beta_* n^{-1/4}$. The combined tails of the two moment integrals for empirical and Gaussian variables are at most $2M^2 n^{-1/4}$ by their second moments. Dividing by $\sqrt n$, the whole error is at most $(2\beta_*+2M^2)n^{-3/4}$, which is also bounded by $(2\beta_*+2M^2)e$. Linear Gaussian regression, including rank one, gives
$$
E[Y_k^G\mathbf1\{T^G\le0\}]=-\frac{\operatorname{Cov}(\psi_k,\psi_D)}{\sqrt{2\pi}\sigma_D}.
$$
The estimates give (4) with (3).

To identify the coefficient in Lim's notation, $Z-p_0$ and the process $\ell(x)/s$ are uncorrelated, and their covariances are $p_0s$ and $(\min(x,y)-xy)/s$ respectively. The Gaussian versions represent the independent heavy-count Gaussian and rescaled Brownian bridge in the original formula. For a light regime,
$t_k(B-1)+u_k-I_kB=B(t_k-I_k)/s$, so (2) gives the source's light coefficients. For the heavy region, combining its two heavy-count terms gives $Q_H(g-t_k)/(Bp_0^2)$. The switch influence gives $W_0$ times the source's $\eta_D$, a positive factor which cancels in the covariance-to-standard-deviation ratio. Thus (4) has the same $c_0$. Finally $K n^{-3/5}\le c_0/(2\sqrt n)$ when $n\ge (2K/c_0)^{10}$, proving the stated explicit threshold. The constants are deliberately conservative.

## 5. A less conservative explicit example

Tracking each term before replacing its power by $n^{-3/5}$ yields another computable sufficient bound. Define
$$
R_2=8B/s^3+1/s+2/(Bp_0^3)+2/(Bp_0^2),\qquad
R_1=6/s+2/p_0,\qquad r_n=e+R_2 d^2+R_1/n .
$$
These preserve the separate powers in (7) for both regimes. Use instead the good-event bound $\eta_n=(4+4m)100!\,c^{-100}n^{-19}$ from $e^{-x}\le100!/x^{100}$ in (6). Then the same termwise proof gives
$$
\begin{aligned}
|\operatorname{FDR}_n-q-c_0/\sqrt n|
\le m\left(\sum_{k=1}^{m}k^{-1}\right)\big[&
r_n+(1+2M)\eta_n
+MD_\Pi d(Md+r_n)\\
&+(M\sqrt{C_D}+2\beta_*+2M^2)n^{-3/4}\big].
\end{aligned} \tag{9}
$$
After multiplication by $\sqrt n$, every summand on the right is a nonnegative multiple of a decreasing negative power of $n$. Therefore a single certified evaluation at $n_0\ge N$ suffices.

In Lim's Example 13 with $B=10$, a rational computation gives $c_0>9/50$. The accompanying checker certifies that the normalized right side of (9) is at most $9/100$ at $n_0=10^{40}$ and that $n_0\ge N$. Here $n_0$ is a theoretical upper bound on the threshold, and the true onset of excess may require far fewer observations.

## References

- Ryan Lim. *Almost Controlled: The FDR of Benjamini–Hochberg on Weighted Conformal p-Values*. arXiv:2611.21509v1, 2026, §7 and Theorem 23. <https://arxiv.org/html/2611.21509v1>.
- Vidmantas Bentkus. *On the dependence of the Berry--Esseen bound on dimension*. Journal of Statistical Planning and Inference 113(2), 385--402, 2003. <https://doi.org/10.1016/S0378-3758(02)00094-0>.
- Pascal Massart. *The tight constant in the Dvoretzky--Kiefer--Wolfowitz inequality*. Annals of Probability 18(3), 1269--1283, 1990. <https://doi.org/10.1214/aop/1176990746>.
