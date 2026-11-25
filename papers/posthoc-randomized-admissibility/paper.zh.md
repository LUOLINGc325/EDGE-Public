# 似然比单调事后检验的可容许性

*兼容规范检验的充分条件与有限 Neyman–Pearson 混合*

## 问题与风险

Chugg、Lardy、Ramdas 和 Grünwald（2026）在第 5.3 节提出，尖锐性、规范表示、似然比单调性与损失兼容性是否足以保证随机化检验族的 $\mathbf C$-可容许性。他们还猜想，只要给定损失集合包含所有前缀赌注，有限个 Neyman–Pearson e 变量的等权混合就可容许。下面证明充分条件以及按阈值排序、允许非等权的混合定理，并给出无序前缀解释下的反例。

设 $P,Q$ 为相互绝对连续的简单原假设与备择，$R=dQ/dP$，几乎处处 $0<R<\infty$。记 $\mathcal L\subset(0,\infty)$ 为可用的第一类错误损失数值，即赌注。对拒绝概率族 $\delta(x,b)$，沿用原文的可测性约定。其安全性要求可测包络 $E_\delta=\sup_b L_b(0,1)\delta(X,b)$ 满足 $\mathbb E_P E_\delta\le1$。若没有安全检验能对每个固定情景提高或保持 $Q$ 下的拒绝概率，并至少在一处严格提高，则该检验称为 $\mathbf C$-可容许。第二类错误损失严格为正时，这与原文的固定情景风险比较等价。

对非负且 $\mathbb E_PE\le1$ 的变量 $E$，规范检验在赌注 $t$ 的拒绝概率为 $\min(1,E/t)$。它是安全的，并且任一安全检验逐点受其自身包络对应的规范检验支配。因此只需研究截断期望
$$
M_E(t)=\mathbb E_Q\min(E,t),\qquad t\in\mathcal L .
$$
当 $\mathbb E_PE=1$ 时，称 $E$ 为尖锐 e 变量。

## 定理 1. 兼容规范检验的充分条件

设 $E=h(R)$，其中 $h$ 为非降 Borel 函数，$\mathbb E_PE=1$，且 $E\in\overline{\mathcal L\cup\{0\}}$ 几乎处处成立。则其规范检验是 $\mathbf C$-可容许的。损失取值条件包含原文的 $E\in\mathcal L\cup\{0\}$。似然比可以有原子，也无需有正下界或有限上界。

**证明。** 取任意非负竞争者 $E'$，使 $\mathbb E_PE'\le1$ 且在 $\mathcal L$ 上 $M_{E'}\ge M_E$。令
$$
A_t=\{E>t\},\quad B_t=\{E'>t\},\quad F(t)=Q(B_t)-Q(A_t),\quad
D(t)=P(B_t)-P(A_t).
$$
记 $C(t)=M_{E'}(t)-M_E(t)=\int_0^t F(s)\,ds$。由尾积分公式，$\int_0^\infty |D|\le\mathbb E_P(E'+E)<\infty$。连续性将 $C\ge0$ 延拓到 $\overline{\mathcal L\cup\{0\}}$。在每个有界补区间，$E$ 在内部无质量，$M_E$ 为仿射函数，凹函数 $M_{E'}$ 位于端点连线之上。在无界补区间 $M_E$ 为常数，$M_{E'}$ 非降。因此 $C(t)\ge0$ 对所有 $t\ge0$ 成立。

对于 $0<P(A_t)<1$，设 $c(t)=\operatorname{ess\,inf}_{A_t}R$。由于 $h$ 非降，留在 $A_t$ 外的似然比不超过内部的本质下确界。又因外部有正质量且 $R>0$，有 $0<c(t)<\infty$、$A_t$ 内 $R\ge c(t)$，外部 $R\le c(t)$。若 $P(A_t)=1$ 则令 $c(t)=0$，若 $P(A_t)=0$ 则令 $c(t)=\infty$。记 $w=1/c$，其值随 $t$ 非增。对于真截面，
$$
D(t)-w(t)F(t)
=\int (\mathbf 1_{B_t}-\mathbf 1_{A_t})(1-R/c(t))\,dP\ge0. \tag{1}
$$
被积式非负，取等要求两截面在 $\{R=c(t)\}$ 外几乎处处相同。$A_t$ 满概率的初始区间上 $F\le0$，故 $C\ge0$ 与 $C(0)=0$ 推出该处几乎处处 $F=D=0$，定义 $wF=0$。在 $A_t$ 为零概率处，$w=0$ 且 $D\ge0$。于是整体几乎处处 $D\ge wF$。

令 $w_M=\min(w,M)$，取右连续代表。对有限 $T$ 作 Stieltjes 分部积分，
$$
I_M(T)=\int_0^T w_M F
=w_M(T)C(T)+\int_{(0,T]}C\,d(-w_M)\ge0. \tag{2}
$$
由式 (1) 及极端截面的约定，$(w_MF)_+\le D_+\,\mathbf 1_{\{F>0\}}$。式 (2) 将负部积分也控制在正部积分之内。先令 $T\to\infty$，再令 $M\to\infty$，正负部分别单调收敛且总积分有限。因此
$$
0\ge\mathbb E_PE'-1=\int_0^\infty D\ge\int_0^\infty wF\ge0.
$$
故 $D=wF$ 几乎处处，且 $L_M=\lim_{T\to\infty} I_M(T)\to0$。

假设 $\{t>0:C(t)>0\}$ 有连通分支 $(a,b)$。在任意内部闭区间 $[u,v]$ 上，式 (2) 给出
$$
\min_{[u,v]}C\, [w_M(u)-w_M(v)]\le L_M .
$$
令 $M\to\infty$，可见 $w$ 在分支内恒定。若该值为 $\infty$，由满概率截面的讨论得 $F=0$ 几乎处处。若为 $0$，由 $D=wF=0$ 知两个截面均为零概率，也有 $F=0$。这两种情况都与 $C(a)=0<C(t)$ 矛盾。若常数为正且有限，式 (1) 取等使 $A_t$ 与 $B_t$ 只能在共同的似然比水平 $\{R=1/w\}$ 上不同。该水平上 $E=h(1/w)$ 固定，所以在此数值之前 $F\le0$，在其之后 $F\ge0$。这种导数符号不能在两端为零的区间产生正值。左端 $C(a)=0$，有限右端 $C(b)=0$。若 $b=\infty$，式 (2) 给出 $\min(w,M)\limsup_{T\to\infty}C(T)\le L_M$，再令 $M\to\infty$。因此没有正值分支，所有截断期望相等，得到可容许性。$\square$

## 定理 2. 有序阈值组的有限混合

取赌注 $b_i\in\mathcal L$、$b_i\ge1$，以及精确 Neyman–Pearson 检验
$$
\phi_i=\mathbf 1_{\{R>c_i\}}+\gamma_i\mathbf 1_{\{R=c_i\}},
\qquad \mathbb E_P\phi_i=1/b_i,\qquad 0\le\gamma_i\le1 .
$$
对 $b_i=1$ 取 $c_i=0$。对 $b_i>1$ 可用分位数选取正且有限的 $c_i$，随赌注非降。设 $p_i>0$、$\sum_i p_i=1$，且 $E=\sum_i p_i b_i\phi_i$。将正阈值相同的项分为一组，记不同的正阈值为 $c_1^\star<\cdots<c_J^\star$。令 $a=\sum_{i:c_i=0}p_i b_i$，以及
$$
z_0=0,\qquad z_j=\sum_{i:0<c_i\le c_j^\star}p_i b_i .
$$
若 $a>0$ 时 $a\in\mathcal L$，且每个 $a+z_j\in\mathcal L$，则 $E$ 的规范检验为 $\mathbf C$-可容许。原文的等权条件在按阈值非降排列时推出本条件；相同阈值组内的其余前缀可以省略。

**证明。** 精确检验水平给出 $\mathbb E_PE=1$。支配者 $E'$ 在 $a>0$ 时必须保持饱和的截断期望 $M_E(a)=a$，因此 $E'\ge a$ 几乎处处。若 $a=0$，同一不等式自动成立。若无正阈值组，则 $E=a=1$，预算直接推出 $E'=1$。其余情况令 $Y=E-a$、$Y'=E'-a$，并定义
$$
w_j=\frac1{c_j^\star}-\frac1{c_{j+1}^\star},\qquad
c_{J+1}^\star=\infty,\qquad V(y)=\sum_{j=1}^J w_j\min(y,z_j).
$$
每个权重严格为正。逐点看，凹函数 $RV(y)-y$ 在 $(z_{j-1},z_j)$ 的斜率为 $R/c_j^\star-1$，在 $(z_J,\infty)$ 为 $-1$。由检验的阈值结构，$Y$ 总是最大化点。在非阈值处最大化点唯一，在 $R=c_j^\star$ 处最大化点集合是 $[z_{j-1},z_j]$，且 $Y$ 在该似然比水平为常数。

支配关系和预算给出 $\mathbb E_QV(Y')\ge\mathbb E_QV(Y)$、$\mathbb E_PY'\le\mathbb E_PY$。逐点最大性要求两式同时取等，且 $Y'$ 也逐点最大化。每个组终点的截断期望必须相等。记 $d_i=\mathbb E_Q[(Y'-Y)\mathbf 1_{\{R=c_i^\star\}}]$。在截断点 $z_j$，$i\le j$ 的对应取值不超过截断点，$i>j$ 的取值至少为截断点。因此差值为 $\sum_{i\le j}d_i=0$，逐次得到每个 $d_i=0$。据此，在每个有正质量的阈值水平，$Y'$ 的条件平均等于固定的 $Y$。对任意截断点应用 Jensen 不等式，该水平的截断期望不能增大。在非阈值处 $Y'=Y$，而赌注不超过 $a$ 时二者均以概率一拒绝。故没有严格支配者。$\square$

\newpage

## 两个精确例子

**阈值随机化。** 令 $P$ 下两类概率为 $3/4,1/4$，相应似然比为 $2/3,2$，所以 $Q$ 下两类概率各为 $1/2$。赌注 $2,8$ 的精确检验分别为 $(1/3,1)$ 和 $(0,1/2)$。等权混合 $E=(1/3,3)$，两值均不属于 $\mathcal L=\{1,2,5,8\}$，但组终点 $1,5$ 可用。因此定理 2 适用。

**无序前缀。** 令 $P$ 为 $[0,1]$ 上的均匀分布，$Q$ 密度为 $1/2+x$。等权混合以 $8,2$ 排列，$\mathcal L=\{2,4,5,8\}$，列出的前缀 $4,5$ 均可用。混合在 $1/2,7/8$ 切出的三个区域上依次取 $0,1,5$。在 $[1/2,5/8)$ 将取值减 $1/2$，在 $[3/4,7/8)$ 加 $1/2$。原假设预算不变，所有允许的截断点在受扰区间均不饱和。因此每个截断期望均增加
$$
\frac12\bigl[Q([3/4,7/8))-Q([1/2,5/8))\bigr]=\frac1{64}.
$$
原文第 2 节按第一类错误损失排列情景。有序解释采用这一排列，任意排列版本则由本例否定。

## 文献

B. Chugg、T. Lardy、A. Ramdas、P. Grünwald，*On admissibility in post-hoc hypothesis testing*，International Journal of Approximate Reasoning **191** (2026)，109634，第 2、3、5.3 节及式 (20)。[期刊全文](https://ir.cwi.nl/pub/36228/36228.pdf)；[作者预印本 v3](https://arxiv.org/html/2508.00770v3)，第 5.3 节及式 (5.2)。
