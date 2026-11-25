---
title: "连续时间 CVaR 滑雪租赁的精确高风险首项"
subtitle: "均匀更新估计、最优购买分布与定量余项"
author: "Research manuscript"
date: "2026年11月24日"
lang: zh-CN
---

## 摘要

当在线算法越来越关注最坏的一小部分运行结果时，随机化比确定性决策还好多少？对连续时间滑雪租赁的 CVaR 竞争比，既有工作已经给出最优分位函数的延迟方程。本文确定最优值趋近确定性极限时的精确前导系数，并证明对移动参数有效的误差界。设风险尾部概率为 $q$，最优竞争比为 $\alpha(q)$，则

$$
2-\alpha(q)\sim A e^{-c/q},\qquad
e^c=1+2c,\quad c>0,
$$

其中

$$
A=\frac{e^c}{c(2c-1)}
\int_0^1\frac{e^{cv}-1}{1+v}\,dv
=1.1062346581287343915\ldots.
$$

证明将最优分位函数距平衡值的差额化为概率更新方程。一个共同密度下界给出全参数统一的 $7/8$ 窗口振幅收缩，因此无需把固定参数的更新定理直接代入变化的最优参数。由同一估计还得到最优购买时刻的对数尺度极限分布及上端分位边界层。附随的独立谱证明进一步给出显式相对误差界。本文的新增对象是前导系数、均匀余项及分布形状；最优策略的延迟方程和常数 $c$ 均保留原有归属。

## 1. 模型、已有结果与贡献边界

租用速率与购买价格都归一化为一。季节长度 $s>0$ 由看不到算法私有随机数的对手选择。算法抽取购买时刻 $X\in[0,\infty]$；若 $X>s$ 则成本为 $s$，若 $X\le s$ 则成本为 $1+X$。对于 $X=\infty$，成本始终定义为 $s$。离线最优成本为 $\min(s,1)$。对 $0<q\le1$，定义

$$
\operatorname{CVaR}_{1-q}(Y)
=\inf_{z\in\mathbb R}
\left\{z+\frac1q\mathbb E(Y-z)_+\right\},
\qquad
\alpha(q)=\inf_{\mathcal L(X)}\sup_{s>0}
\frac{\operatorname{CVaR}_{1-q}(C_s(X))}{\min(s,1)}.
$$

Christianson、Sun、Low 与 Wierman [R1] 已证明可以限制到 $X\in[0,1]$，并以延迟方程刻画唯一最优策略。确定性极限为二。本文使用该最优性桥，不将其作为本轮新证明。

还须区分两个已有事实。第一，[R1] 的显式可行策略已经使用满足 $e^c=1+2c$ 的常数，并给出优势 $(e^{c/q}-1)^{-1}$。第二，既有离散研究稿 [R2] 的尖锐相变上界结合 [R1] 的离散与连续比较，已经蕴含

$$2-\alpha(q)=\Theta(e^{-c/q}).$$

因此，本稿不把指数率 $c$ 或上述阶数重新计作贡献。本文的新证明不依赖 [R2]，引用它是为了划清贡献边界。此前检查的文献没有给出本稿的振幅等价式及一致余项；这一查新结论限定于随稿列明的来源和检索范围。

尾概率约束下最小化期望成本 [R3]，以及以预测误差为随机性的学习增强模型 [R4]，具有不同目标函数。本稿保持 [R1] 的原始 CVaR 目标、连续时间和对手模型。

## 2. 主结果

记

$$
\Delta(q)=2-\alpha(q),\qquad
\gamma=\log(8/7),\qquad
c=1.2564312086261696769\ldots.
$$

**定理 1（精确首项与均匀余项）。** 对上述原模型，$A$ 由摘要中的正积分定义。当 $q\downarrow0$ 时，

$$
\Delta(q)=Ae^{-c/q}
+O\!\left(q^{-1}e^{-2c/q}+e^{-(c+\gamma)/q}\right).
\tag{1}
$$

更具体地，对每个 $0<q\le1/10$，

$$
\begin{aligned}
|\Delta(q)-Ae^{-c/q}|
&\le \frac{e^2}{3}\left(1600+\frac{256}{q}\right)e^{-2c/q}\\
&\quad+\frac{64e}{7}e^{-(c+\gamma)/q}.
\end{aligned}
\tag{2}
$$

这些常数为保守估计，未声称最优。由于 $c>\gamma$，式 (1) 也给出相对余项 $O(e^{-\gamma/q})$。

**定理 2（附随谱估计的更强显式界）。** 对每个 $0<q\le1/20$，

$$
\left|\frac{\Delta(q)}{Ae^{-c/q}}-1\right|
\le 20000e^{-1/(2q)}.
\tag{3}
$$

定理 1 的完整初等证明见第 3—6 节。定理 2 的独立复数分析证明完整保存在英文稿的谱估计附录；它不作为定理 1 的前提。

**定理 3（最优分位的两个极限）。** 设 $\phi_q$ 是最优购买时刻的分位函数。对每个固定 $u\in(0,1)$，

$$
1-\phi_q(u)=Ae^{-cu/q}(1+o(1)),
\qquad
q\log\frac1{1-\phi_q(u)}\longrightarrow cu.
\tag{4}
$$

收敛在 $(0,1)$ 的每个紧子区间上一致。若 $X_q$ 服从最优购买分布，则

$$
q\log\frac1{1-X_q}\ \Rightarrow\ \operatorname{Uniform}[0,c].
\tag{5}
$$

对每个固定有限 $V\ge0$，还有

$$
\sup_{0\le v\le V}
\left|\frac{1-\phi_q(1-qv)}{\Delta(q)}-(e^{cv}-1)\right|
\longrightarrow0.
\tag{6}
$$

式 (6) 在 $q$ 足够小时使用，因此其分位参数属于 $[0,1]$。它说明极靠近最晚购买时刻的一层分位具有确定的极限形状。

## 3. 从最优性桥到概率更新方程

令 $T=1/q$。对一般参数 $1<a\le2$，先定义

$$
\psi_a(t)=\log\left(1+\frac{t}{a-1}\right),\quad 0\le t\le1,
$$

再逐个单位区间解常微分方程

$$
a\psi_a'(t)=\psi_a(t)-\psi_a(t-1),\quad t>1.
\tag{7}
$$

在每一步，延迟项已由前一步给定，线性常微分方程的积分因子公式给出唯一解，并以先前区间的末值作初值。因此得到全半轴上的唯一连续、分段连续可微函数。初始区间与后续区间在 $t=1$ 的导数通常不同；本文不假设那里可微。

由 [R1, Theorem 7]，本模型的最优参数满足

$$a=\alpha(q),\qquad \psi_a(T)=1,\qquad
\phi_q(u)=\psi_a(u/q).\tag{8}$$

在 $t>1$ 对下式求导可知它为常数：

$$a\psi_a(t)-\int_{t-1}^{t}\psi_a(s)\,ds.$$

直接计算初始积分，得到

$$
\int_0^1\log\left(1+\frac{s}{a-1}\right)ds
=a\log\frac a{a-1}-1.
$$

故对于所有 $t\ge1$，

$$a\psi_a(t)-\int_{t-1}^{t}\psi_a(s)\,ds=1.\tag{9}$$

定义 $D_a(t)=1/(a-1)-\psi_a(t)$；这里尚未假设 $\psi_a$ 收敛。式 (9) 等价于

$$D_a(t)=\frac1a\int_0^1D_a(t-s)\,ds.\tag{10}$$

初始 $D_a$ 为正。设 $c_a>0$ 满足 $e^{c_a}=1+ac_a$。函数

$$\frac{e^z-1}{z}=\int_0^1e^{zs}\,ds$$

在 $z>0$ 上严格递增，值域为 $(1,\infty)$，因此该根存在且唯一。令

$$H_a(t)=e^{c_at}D_a(t),\qquad k_a(s)=\frac{e^{c_as}}a\quad(0\le s\le1).$$

则 $k_a$ 是概率密度，且

$$H_a(t)=\int_0^1k_a(s)H_a(t-s)\,ds,\qquad t\ge1.\tag{11}$$

在固定参数区间 $a\in[3/2,2]$ 上，有

$$
\frac12<c_{3/2}\le c_a\le c<\frac32,
\qquad k_a\ge\frac12,
\qquad \frac14<H_a(v)<8\quad(0\le v\le1).
\tag{12}
$$

最后的下界来自 $D_a(v)\ge1-\log2>1/4$，上界来自 $e^{c_a}<4$ 和 $1/(a-1)\le2$。

## 4. 共同密度给出全参数统一收缩

**引理 4（窗口振幅收缩）。** 设有界概率密度 $k$ 在 $[0,1]$ 上满足 $k\ge1/2$，连续函数 $H$ 满足式 (11)。若 $m_n,M_n$ 是 $H$ 在 $[n,n+1]$ 上的最小值和最大值，则

$$
m_{n+1}\ge m_n,\qquad M_{n+1}\le M_n,
\qquad M_{n+1}-m_{n+1}\le\frac78(M_n-m_n).
\tag{13}
$$

**证明。** 只需分析从初始历史 $h(v)=H(v)$ 到下一窗口 $H(1+x)$ 的转移。把式 (11) 的积分在 $s=x$ 处分开，得

$$
H(1+x)=g(x)+\int_0^xk(s)H(1+x-s)ds,
\quad
g(x)=\int_x^1k(1+x-v)h(v)dv.
\tag{14}
$$

记 $r=\sum_{j\ge1}k^{*j}$。若 $k\le K$，在 $0\le s\le1$ 上有
$k^{*j}(s)\le K^js^{j-1}/(j-1)!$；因此级数局部一致收敛。Volterra 迭代及 Fubini 定理给出

$$H(1+x)=\int_0^1W_x(v)h(v)dv,\tag{15}$$

其中

$$
\begin{aligned}
W_x(v)
&=\mathbf1_{\{v\ge x\}}k(1+x-v)\\
&\quad+\int_{\max(0,x-v)}^x r(s)k(1+x-v-s)ds.
\end{aligned}
\tag{16}
$$

各项非负。把 $h$ 取为常数一，式 (14) 的唯一解也是一，故每行 $W_x$ 的总积分为一。

若 $v\ge x$，直接项至少为 $1/2\ge v/4$。若 $v<x$，第二项中取 $r\ge k$，积分区间 $[x-v,x]$ 长为 $v$，两个核均至少为 $1/2$，故同样有

$$W_x(v)\ge v/4.\tag{17}$$

公共密度 $v/4$ 的质量为 $1/8$。从每行扣去这一相同部分，剩余非负质量均为 $7/8$。公共部分对所有输出的贡献相同，剩余部分的取值范围宽度至多为 $\frac78(\max h-\min h)$。各行又是概率平均，因而不会超出原窗口的值域。逐个整数平移即得式 (13)。证毕。

把引理用于式 (11)，有极限 $C_a\in(1/4,8)$，并且对全部 $a\in[3/2,2]$、$t\ge0$ 同时成立

$$
|H_a(t)-C_a|\le8(7/8)^{\lfloor t\rfloor}
\le\frac{64}{7}e^{-\gamma t}.
\tag{18}
$$

这里没有依赖于参数而失控的常数。这也反过来证明 $D_a(t)\to0$ 和 $\psi_a(t)\to1/(a-1)$。

## 5. 用守恒积分求出振幅

记

$$
\overline K_a(s)=\int_s^1k_a(r)dr,
\qquad
\mu_a=\int_0^1s k_a(s)ds
=1-\frac{a-1}{ac_a}.
$$

定义

$$
J_a(t)=\int_0^1 k_a(v)\int_{t-v}^{t}H_a(u)\,du\,dv
=\int_0^1\overline K_a(s)H_a(t-s)ds.
$$

连续性足以对内层移动积分使用微积分基本定理，故对于 $t>1$，

$$J_a'(t)=H_a(t)-\int_0^1k_a(v)H_a(t-v)dv=0.$$

这一写法避免了在导数拼接点使用不存在的双侧导数。由式 (18)，令 $t\to\infty$ 得

$$
\mu_aC_a=J_a(1)
=\frac{e^{c_a}}{ac_a}\int_0^1(e^{c_av}-1)D_a(v)dv.
\tag{19}
$$

初始兼容式为 $\int_0^1D_a=aD_a(1)$。在 $[0,1]$ 上 $D_a'(v)=-1/(a-1+v)$，分部积分并用 $e^{c_a}-ac_a=1$ 可得

$$
\int_0^1(e^{c_av}-1)D_a(v)dv
=\frac1{c_a}\int_0^1\frac{e^{c_av}-1}{a-1+v}dv.
$$

因此

$$
C_a=\frac{e^{c_a}}{c_a(ac_a-a+1)}
\int_0^1\frac{e^{c_av}-1}{a-1+v}dv.
\tag{20}
$$

代入 $a=2$ 得 $C_2=A$。这一守恒积分保留了完整初始历史，因而不会遗漏时间平移产生的振幅因子。

## 6. 移动参数与显式误差的闭合

原最优性桥保证 $a=\alpha(q)\in[e/(e-1),2)$，因此属于前述统一区间。在 $t=T$ 使用式 (8)，得到精确归一化式

$$
\Delta=(a-1)D_a(T)
=(a-1)e^{-c_aT}H_a(T).
\tag{21}
$$

由式 (12)、(18)，先有粗界

$$0<\Delta\le8e^{-T/2}.\tag{22}$$

这一步先证明 $a\to2$，不借用待证的精确首项。

隐函数微分给出

$$c_a'=\frac1{a\mu_a}.$$

由于 $k_a$ 递增，$\mu_a\ge1/2$：把 $s-1/2$ 的积分在中点两侧配对即可。因此 $0<c_a'\le4/3$，于是

$$0\le c-c_a\le\frac43\Delta.$$

当 $T\ge10$ 时，式 (22) 使 $(c-c_a)T<1$。设 $R=e^{(c-c_a)T}$，便有

$$1\le R\le e,\qquad R-1\le\frac{4e}{3}T\Delta,
\qquad \Delta\le8e\,e^{-cT}.\tag{23}$$

为给出可复核常数，设 $B(a)=(a-1)C_a$。在初始窗口内直接微分可得

$$
|\partial_a k_a(v)|\le2k_a(v),\qquad
|\partial_aD_a(v)|\le4,\qquad
|\partial_aH_a(v)|\le80/3.
$$

第一式由 $\partial_ak_a=k_a(c_a'v-1/a)$ 得到。第二式使用
$\partial_aD_a=-1/(a-1)^2+v/[(a-1)(a-1+v)]\in[-4,0]$；第三式再用 $D_a\le2$、$e^{c_av}<4$。对式 (19) 微分，结合
$|\partial_a\overline K_a|\le2\overline K_a$、$|\mu_a'|\le2\mu_a$ 和 $C_a\le8$，得到

$$|C_a'|\le176/3,\qquad |B'(a)|\le200/3.\tag{24}$$

令 $r_a(T)=H_a(T)-C_a$，式 (21) 改写为

$$\Delta=e^{-cT}R[B(a)+(a-1)r_a(T)].$$

利用 $B(2)=A\le8$、式 (18)、(23)、(24)，三角不等式给出

$$
\begin{aligned}
|\Delta-Ae^{-cT}|
&\le e^{-cT}\left[
\frac{200e}{3}\Delta+\frac{32e}{3}T\Delta
+\frac{64e}{7}e^{-\gamma T}\right]\\
&\le\frac{e^2}{3}(1600+256T)e^{-2cT}
+\frac{64e}{7}e^{-(c+\gamma)T}.
\end{aligned}
$$

这正是定理 1。整个证明都在固定参数区间上控制误差，再代入最优参数，因而没有交换未经论证的极限。

## 7. 最优随机策略的形状

由 $D_a(T)=\Delta/(a-1)$，对任意 $u\in[0,1]$ 有

$$1-\phi_q(u)=D_a(uT)-D_a(T).\tag{25}$$

固定 $0<u<1$，第一项由式 (18)、(20)、(23) 等价于 $Ae^{-cuT}$，第二项则小一个指数阶；得到式 (4)。若 $u\in[\varepsilon,1-\varepsilon]$，所有误差可同时用
$e^{-\gamma\varepsilon T}$、$e^{-c_a\varepsilon T}$ 和 $T\Delta$ 控制，故收敛一致。

在同一概率空间上取 $U\sim\operatorname{Uniform}(0,1)$，置 $X_q=\phi_q(U)$。式 (4) 对所有 $U\in(0,1)$ 给出几乎处处收敛至 $cU$，从而推出式 (5)。$u=1$ 处的对数为无穷；该点概率为零，不属于式 (4) 的一致收敛区间。

对于固定 $V<\infty$，在 $T\ge V+1$ 时直接使用式 (21)、(25)：

$$
\frac{1-\phi_q(1-qv)}{\Delta}
=\frac1{a-1}\left[e^{c_av}
\frac{H_a(T-v)}{H_a(T)}-1\right].
$$

因 $H_a\ge1/4$，分母有统一正下界；式 (18) 使两个窗口值均趋于 $C_a$，且 $a\to2,c_a\to c$。收敛对 $v\in[0,V]$ 一致，证明式 (6)。同样论证给出某个仅依赖 $V$ 的有限常数 $K_V$，使误差不超过
$K_V(\Delta+e^{-\gamma/q})$。

## 8. 可复现核验与结果解释

精确常数证书只用 Python 标准库的有理数算术。指数函数用正项 Taylor 级数及几何尾界；$\log2$ 用 $2\operatorname{atanh}(1/3)$ 的正项级数。积分使用

$$
\int_0^1\frac{e^{cv}-1}{1+v}dv
=\sum_{n\ge1}\frac{c^n}{n!}J_n,
\quad J_0=\log2,\quad J_n=\frac1n-J_{n-1}.
$$

程序给出的外向舍入区间为

$$
1.1062346581287343915159084319
<A<
1.1062346581287343915159084320.
$$

另一个程序对记录中的七个 $q<1$ 参数直接用逐步 Taylor 法解原差额 DDE，再求终点条件，不使用更新极限作为数值解。交叉计算采用同一 Taylor 实现的两套步长与阶数配置，并非两套独立求解器。另一个 $q=1$ 数据点单独采用闭式计算，其零配置差异不计入 DDE 网格一致性的证据。部分结果如下；表中数值属于高精度数值核验，不是对所有 $q$ 的形式化证明。

| $q$ | 数值 $\Delta(q)$ | 数值 $e^{c/q}\Delta(q)$ |
|---:|---:|---:|
| $1/4$ | $7.4325580098\times10^{-3}$ | $1.1318343513$ |
| $1/8$ | $4.7718866373\times10^{-5}$ | $1.1065708976$ |
| $1/16$ | $2.0571644924\times10^{-9}$ | $1.1062346877$ |
| $1/32$ | $3.8255224521\times10^{-18}$ | $1.1062346581$ |

*Figure: 左：最优优势的缩放值趋于新振幅；右：观察误差与保守解析误差包络。数据为数值核验，曲线不替代证明。*

[R1] 的显式策略具有同一指数，但其缩放振幅趋于一。因此它取得的优势占最优优势的比例趋于 $1/A\approx0.904$。这个比例作用于相对确定性基准的改进量，总成本的差异仍是指数小量。

## 9. 验证边界与后续义务

本稿给出基于 [R1] 最优性桥的完整解析论证，附有独立内部数学审查、精确常数证书及两套数值离散化核对。它尚未经过外部同行评议。相关核验各有不同范围：常数证书只认证常数区间，数值实验只检查列出的参数，Lean 部分只能按其范围表说明实际证明的积分比较步骤。

当前尚未完整形式化的内容包括原在线优化到 DDE 的桥、Volterra 核构造、统一长时极限、振幅积分及两个分布极限。因此，本稿不声称全文形式化或三公理验证完成。

本轮结果是一个明确理论模型中的精确渐近完善。学术价值应由其证明、与既有工作的真实差异和后续专家审查判断；本文不预先承诺论文级别或全球优先权。

## 参考文献

[R1] Nicolas Christianson, Bo Sun, Steven Low, Adam Wierman. *Risk-Sensitive Online Algorithms*. arXiv:2405.09859v2, 2024, Section 3 and Appendix B. COLT 2024, PMLR 247:1140–1141. <https://arxiv.org/html/2405.09859v2>.

[R2] *Exact risk phases in discrete ski rental*. 研究稿，2026，定理1与定理7。[相关论文](../risk-sensitive-ski-rental/paper.en.md)

[R3] Michael Dinitz, Sungjin Im, Thomas Lavastida, Benjamin Moseley, Sergei Vassilvitskii. *Controlling Tail Risk in Online Ski-Rental*. SODA 2024, 4247–4263; arXiv:2308.05067. <https://arxiv.org/abs/2308.05067>.

[R4] Spyros Angelopoulos, Christoph Dürr, Georgii Melidi. *Decision-Theoretic Approaches for Improved Learning-Augmented Algorithms*. arXiv:2501.17701; ICLR 2026. <https://arxiv.org/abs/2501.17701>.
