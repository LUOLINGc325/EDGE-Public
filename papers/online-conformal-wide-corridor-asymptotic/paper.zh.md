# 对称宽走廊下临界共形代价的精确渐近

## 问题与结果

对于未知数据分布的在线共形预测，要求累计漏报偏差始终处于平方根走廊。既有工作已确定最小最坏分歧的增长阶。配套研究中的的有限递推、变分极限及抛物方程案例进一步给出明确的临界系数。本稿确定走廊越来越宽时，这个系数如何接近无约束学习成本。主项的额外成本等于已知分布的反射成本。最佳反馈再减去一个小一阶的正量，系数由一个普适正态积分给出。

令 $\sigma^2=\alpha(1-\alpha)>0$，其中 $\alpha$ 为目标漏报率。取对称走廊 $L_t=U_t=\kappa\sqrt t$，在原逐路径约束下可取 $\kappa\ge1/2$。写 $C_*(\kappa,\sigma)=\lim_{T\to\infty}M_T/\sqrt T$，其中 $M_T$ 是 Gui、Barber、Ma 问题中的未知分布极小极大风险。定义 $K=\kappa/\sigma$、$g_0=\sqrt{2/\pi}$，以 $\phi,\Phi$ 记标准正态密度、分布函数，并置

$$
c_{\mathrm K}(K,\sigma)=\frac{2\sigma\phi(K)}{2\Phi(K)-1},
\qquad
J=\int_0^1
\frac{g_0-2\phi\bigl(\Phi^{-1}((1+p)/2)\bigr)}{p^2}\,dp.
$$

**定理。** 当 $K\to\infty$ 时，

$$
C_*(\kappa,\sigma)
=2\sigma g_0+c_{\mathrm K}(K,\sigma)
-4\sigma J\frac{\phi(K)}K
+o\left(\sigma\frac{\phi(K)}K\right).
$$

这里 $c_{\mathrm K}$ 是同一走廊已知分布的最优成本。积分 $J$ 绝对收敛，且 $\sqrt{\pi/8}<J<\sqrt{2/\pi}$。先固定 $\kappa$ 取轮数极限，再取 $K\to\infty$。结果表明未知分布的附加代价与 $c_{\mathrm K}$ 渐近等价，最优反馈相对「无约束学习加反射」的收益约占反射成本的 $2J/K$。

## 1. 从抛物求值式出发

沿用[临界系数的抛物求值案例](../online-conformal-parabolic-evaluation/paper.zh.md)。令 $G(u)=\mathbb E|\sigma Z-u|$，$Z$ 为标准正态，$H_M(p)=\min_{|u|\le M}[G(u)+pu]$。将位置缩为 $x=z/\sigma$、控制上限缩为 $m=M/\sigma$。归一化 Hamilton 函数为 $h_m=H_M/\sigma$。令 $h=\inf_{m>0}h_m$。在 $|p|\le1$，

$$
h(p)=2\phi(\Phi^{-1}((1+p)/2)),\qquad h(\pm1)=0.
$$

这里端点值用连续延拓。半区间 $[0,K]$ 上的梯度解 $P_{K,m}$ 满足

$$
\partial_r P=\tfrac12 P_{xx}+[h_m'(P)-x/2]P_x,\qquad
P(r,0)=0,\quad P(r,K)=1,\quad P(0,x)=0\ \ (0<x<K).
$$

源于完整梯度解的奇对称性。最大原理给 $0\le P\le1$。设 $D_{K,m}=2\sigma g_0+c_{\mathrm K}-C_M$，$C_M$ 为控制上限 $M$ 下的系数。抛物求值式给出

$$
D_{K,m}=
\frac{2\sigma}{2\Phi(K)-1}\int_0^\infty e^{-r/2}
\int_0^K[g_0-h_m(P_{K,m}(r,x))]\,\phi(x)\,dx\,dr.
$$

控制截断误差满足

$$
0\le C_M-C_*\le2[G(M)-M]\le4\sigma\phi(m).
$$

最后一项由标准正态尾部的绝对误差公式得到。后面取 $m=2K$，使该误差相对于 $\sigma\phi(K)/K$ 消失。

## 2. 上屏障及边界层的点态极限

写 $A(x)=\int_0^x e^{v^2/2}dv$，定义 $B_K(x)=A(x)/A(K)$。它在 $[0,K]$ 上递增，满足 $\frac12B_K''-\frac{x}{2}B_K'=0$。对 $p\ge0$ 有 $h_m'(p)\le0$，故 $B_K$ 是上屏障。比较原理给

$$
0\le P_{K,m}(r,x)\le B_K(x)\quad(r>0,\ 0\le x\le K).
$$

为展示比较在初始边角处的有效性，可在正时间对差函数的正部作能量估计，并将初始时刻趋零。两者在 $L^2$ 的初值有正确顺序。漂移函数对 $p$ 非增，而上屏障的空间导数非负，使差方程中的漂移差乘该导数具有有利符号。其余一阶项有界，故正部估计闭合。

固定 $r>0,y>0$，取 $x=K-y/K$。已有 $A(K)\sim e^{K^2/2}/K$，由比值洛必达法可证，所以 $B_K(K-y/K)\to e^{-y}$。为了给出匹配下界，固定 $L>y$、$0<\xi<1$，在局部区间 $[K-L/K,K]$ 使用线性方程

$$
S_r=\tfrac12S_{xx}-(K/2+Q_\xi)S_x,\qquad
Q_\xi=\Phi^{-1}(1-\xi/2).
$$

取左端点值零、右端点值 $1-\xi$，初始内点值零。解可写成 $(1-\xi)$ 乘常漂移扩散在指定时间前先撞右端点的概率，因此 $0\le S\le1-\xi$，且 $S_x\ge0$。后者也可从同布朗噪声下两初值有序、固定时间前向右出界事件有序得到。对 $0\le p\le1-\xi$，无截断极小控制的标准化坐标是 $-\Phi^{-1}((1+p)/2)\ge-Q_\xi$，将其限制于 $[-m,m]$ 只会增大这个非正值。又 $x\le K$，故线性方程的漂移小于等于 $h_m'(S)-x/2$。这使 $S$ 成为原非线性方程的下屏障。其左右端点与初值不大于 $P_{K,m}$。用同一个正部比较，得到 $S(r,x)\le P_{K,m}(r,x)$，对所有 $m$ 同时成立。

在坐标 $Y=K(K-X)$ 与时间放大 $K^2$ 后，该线性扩散以方差率一在 $[0,L]$ 内运动，漂移为 $d_K=1/2+Q_\xi/K$。从 $Y=y$ 出发，先撞零的永久概率由常漂移调和函数给出

$$
\frac{e^{-2d_K y}-e^{-2d_K L}}{1-e^{-2d_K L}}.
$$

有限时限 $K^2r$ 和永久概率之差趋零。具体地，若任一单位时间内布朗增量大于 $L$，过程已经出区间。该事件有与 $K$ 和初值无关的正概率，于是未出界概率具有几何上界。由此

$$
\liminf_{K\to\infty}P_{K,m(K)}(r,K-y/K)
\ge (1-\xi)\frac{e^{-y}-e^{-L}}{1-e^{-L}}.
$$

令 $\xi\downarrow0,L\uparrow\infty$，与上屏障合并，得到

$$
P_{K,m(K)}(r,K-y/K)\longrightarrow e^{-y},
$$

其中 $m(K)>0$ 可以任意变化。这是使用局部有界漂移完成的极限，涵盖最优无界漂移在 $p=1$ 附近的奇性。

## 3. 一致支配与折扣积分

对 $p=2\Phi(q)-1,\ q\ge0$，平面标准正态变量落在正方形 $[-q,q]^2$ 的概率是 $p^2$。该正方形包含半径 $q$ 的圆盘，圆盘概率为 $1-e^{-q^2/2}$。结合 $h_m\ge h$，得到

$$
0\le g_0-h_m(p)\le g_0-h(p)\le g_0p^2.
$$

在求值式内换元 $x=K-y/K$，则 $\phi(x)=\phi(K)e^{y-y^2/(2K^2)}$。对 $0\le y\le K^2/2$，有 $x\ge K/2$，由标准指数积分估计 $A(x)\le2e^{x^2/2}/x$、$A(K)\ge e^{-1}e^{K^2/2}/K$ 可得

$$
B_K(x)^2 e^{y-y^2/(2K^2)}\le C e^{-3y/4}.
$$

后一条指数下界可在 $[K-1/K,K]$ 直接积分证明。对 $K^2/2\le y\le K^2$，使用 $A(x)\le K e^{x^2/2}$，同一表达式至多为 $C K^4e^{-y/2}$。在此区间的积分趋零。由此可以对 $r,y$ 的积分先截尾、再作支配收敛，且时间乘子 $e^{-r/2}$ 可积。

取 $m=2K$。因为 $h_m\to h$ 在 $[0,1]$ 一致，结合点态极限和上述支配，

$$
\lim_{K\to\infty}\frac{K D_{K,2K}}{\sigma\phi(K)}
=4\int_0^\infty e^y[g_0-h(e^{-y})]\,dy
=4J.
$$

最后一步用 $p=e^{-y}$。控制截断误差为更低阶，得定理。

## 4. 系数范围与精确复核

令 $p(q)=2\Phi(q)-1$，$\mathcal R(q)=(1-e^{-q^2/2})/p(q)^2$。分子与分母的导数比为 $q/[2g_0p(q)]$，它严格递增，因为 $p(q)/q$ 是一段递减密度的平均。因分子、分母在零点同为零，原比也严格递增，且从 $\pi/4$ 变到 1。因此

$$
J=g_0\int_0^\infty\mathcal R(q)\,dp(q),
\qquad
g_0\pi/4<J<g_0.
$$

随附程序用交错级数构造 $\pi$、指数和正态分布函数的有理上下界，再用 $\mathcal R$ 单调性对积分作上下 Darboux 求和。它认证的是普适系数 $J$，定理中的渐近极限由书面证明支撑。

## 来源

- Gui、Barber、Ma. [The cost of enforcing long-run coverage: a phase transition in online conformal prediction](https://arxiv.org/pdf/2611.21542v1)，§1.4、§2 及其式 (20)。
- 配套研究中的[临界抛物求值](../online-conformal-parabolic-evaluation/paper.zh.md)和[临界已知分布](../online-conformal-critical-known-oracle/paper.zh.md)案例，提供控幅比例、反射成本与梯度方程。
