# 图伊辛演化的稳定子 Rényi 矩：连续角分解、整数阶消元与二元割谱

## 摘要

本文计算加权图伊辛演化产生的稳定子 Rényi 矩。对仙人掌图，任意独立实边角和正实阶数均有按桥及循环分解的公式，偶环保留互补振幅的干涉。对任意图，连续角的整数阶矩可收缩为有限顶点模型。当每条边角为$\pi/8$ 的整数倍时，任意图的完整 Pauli 模方谱由跨割奇边子图的二元 Laplacian 秩决定。完全图由此出现尖锐的规模奇偶效应：固定阶大于一，偶数顶点的熵收敛到常数，奇数顶点的熵密度则严格为正。

## 1. 设置与原问题

令有限简单无向图 $G=(V,E)$ 有 $n$ 个顶点，每条边有实角度 $\theta_e$。研究与 [1] 相同的对易伊辛演化态

$$
\psi_G=\exp\left(-i\sum_{e=uv\in E}\theta_eZ_uZ_v\right)q^{\otimes n},\qquad q=(1,1)^{\mathsf T}/\sqrt2 .
$$

取不含整体相位的 $n$ 比特 Pauli 算符集合 $\mathcal P_n$，记 $w_G(P)=\langle\psi_G|P|\psi_G\rangle$ 为算符 $P$ 对该态的期望，定义

$$
F_\alpha(G)=2^{-n}\sum_{P\in\mathcal P_n}
  |w_G(P)|^{2\alpha},
\qquad
M_\alpha(G)=\frac{\log_2 F_\alpha(G)}{1-\alpha}.
$$

在 $\alpha=1$ 处取连续极限。第 2–4 节设 $G$ 是仙人掌图，即每条边最多属于一个简单环；其余定理允许任意有限简单图。这类图的边块由单条桥和边不相交的简单环组成。同一顶点可以属于多个边块。

[1] 的森林定理只覆盖没有环的图。补充材料 S4.F 指出环空间是森林乘积公式的障碍。正文把有环图明确列为延伸方向。下文处理该方向中的仙人掌类，范围包括相互独立的闭合链与共享割点的若干闭合链。

## 2. 仙人掌图的加权公式

设 $c_e=\cos(2\theta_e)$、$s_e=\sin(2\theta_e)$，并记

$$
d_e=|c_e|^{2\alpha}+|s_e|^{2\alpha},\qquad
B_e=\frac{1+d_e}{2},\qquad D_e=\frac{1-d_e}{2}.
$$

对一个环 $Q$ 及其边子集 $S$，记 $A_S=\prod_{e\in S}s_e\prod_{e\in Q\setminus S}c_e$。偶环长度 $\ell=|Q|$ 时，定义

$$
J_\alpha(Q)=\frac12\sum_{S\subseteq Q}
 \left|A_S+(-1)^{\ell/2+|S|}A_{Q\setminus S}\right|^{2\alpha}.
$$

**定理。** 对任意 $\alpha>0$ 和任意边权，

$$
F_\alpha(G)=\prod_{e\ \mathrm{bridge}} B_e\ \prod_{Q\ \mathrm{cycle}}K_\alpha(Q),
$$

其中环因子为

$$
K_\alpha(Q)=\prod_{e\in Q}B_e+\prod_{e\in Q}D_e
+\mathbf 1_{\{\ell\ \mathrm{even}\}}\,2^{1-\ell}
\left[J_\alpha(Q)-\prod_{e\in Q} d_e\right].
$$

对正整数 $\alpha$，无需枚举 $2^\ell$ 个互补项。偶环的 $J_\alpha$ 可由下式在线性于 $\alpha\ell$ 的次幂和乘积数内求得。

$$
J_\alpha(Q)=\frac12\sum_{k=0}^{2\alpha}
{2\alpha\choose k}(-1)^{k\ell/2}
\prod_{e\in Q}\big[c_e^{2\alpha-k}s_e^k+(-1)^k s_e^{2\alpha-k}c_e^k\big].
$$

特别地，$\alpha=2$ 时方括号中的干涉修正为

$$
J_2(Q)-\prod_{e\in Q}d_e=
3\,2^\ell\prod_{e\in Q}(c_es_e)^2
+4(-1)^{\ell/2}\prod_{e\in Q}c_es_e(c_e^2-s_e^2).
$$

## 3. 仙人掌分解的证明

用 $x,a,b\in\mathbb F_2^V$ 标记计算基、Pauli 翻转和相位。相差单位模相位的 $X^aZ^b$ 足以计算绝对值矩。翻转 $a$ 只会改变割边集合 $C(a)=\{uv:a_u\ne a_v\}$ 上的相位。由计算基逐项内积，Pauli 期望的绝对值等于函数

$$
f_a(x)=\prod_{e=uv\in C(a)}
\big[c_e-i s_e(-1)^{x_u+x_v}\big]
$$

在角色 $(-1)^{b\cdot x}$ 上的归一化 Walsh 系数的绝对值。内积的共轭约定只会令所有系数共轭，不改变矩。

把乘积展开。对应边集 $S\subseteq C(a)$ 的项带指数向量 $\partial S$（模 2 边界，即奇度顶点的指示向量），系数为 $(-i)^{|S|}\prod_{e\in S}s_e\prod_{e\in C(a)\setminus S}c_e$。因此相同边界的项先相加，随后取绝对值。两个边集有相同边界当且仅当它们的对称差属于割图的环空间。仙人掌图的简单环边不相交，且环空间以这些简单环为基。后者可由任一偶度边子图分解成简单环得到。对割图同理，其简单环恰是全体边都被选入割的原图环。

于是对固定的 $a$ 求和所有 $b$ 时，可以按割边集合在环空间中的陪集求和。每条不属于完整入割环的割边各自贡献 $d_e$。每个完整入割环贡献独立的互补对求和，这是因为陪集按边不相交块分解为笛卡尔积，振幅的块乘积可交换于有限求和和绝对值幂次。割在每个环上交叉偶数次，只可能完整选入偶环。其互补对的相对复相位为 $(-i)^{\ell-2|S|}=(-1)^{\ell/2+|S|}$。因此完整入割块贡献 $J_\alpha(Q)$。每个互补对恰被双计，解释了系数 $1/2$。

最后对 $a$ 均匀平均。割边指示向量是模 2 关联矩阵的转置作用于 $a$，均匀分布在其像上。线性代数给出该像恰是原图环空间的正交补。环空间基的边支撑互不相交，因此桥上指标是独立的均匀位，每个环内向量是均匀的偶子集，各块彼此独立。桥上平均得到 $B_e$。令环内每个偶子集暂按一般边乘积计算。用奇偶筛可得

$$
2^{1-\ell}\sum_{S\subseteq Q:\ |S|\ \mathrm{even}}\prod_{e\in S}d_e
=\prod_{e\in Q}B_e+\prod_{e\in Q}D_e.
$$

对偶环，唯一须替换的子集是完整环，其概率为 $2^{1-\ell}$，这给出定理的最后一项。展开偶次幂并逐边求和，得到整数阶公式。取 $\alpha=2$ 时，$k=0,4$ 合成 $\prod d_e$，$k=2$ 给出平方乘积，$k=1,3$ 合成带环长度奇偶相位的有符号项。由于 $F_1=1$，且有限个正 Pauli 权重的幂对正阶数可微，取连续极限也给出 $M_1$。

## 4. 闭合链的定量差异

所有演化角取 $\theta_e=\pi/8$，记 $d=2^{1-\alpha}$。桥因子为 $(1+d)/2$。对偶环，互补对中恰半数相消，另半数的幅值为 $2^{1-\ell/2}$。于是

$$
K_\alpha(Q)=\left(\frac{1+d}{2}\right)^\ell
 +\left(\frac{1-d}{2}\right)^\ell
 +\mathbf1_{\{\ell\ \mathrm{even}\}}\,2(2^{2\alpha-2}-1)
   \left(\frac d2\right)^\ell.
$$

二阶下，奇环因子是 $(3/4)^\ell+(1/4)^\ell$，偶环是 $(3/4)^\ell+7(1/4)^\ell$。因此单个长闭合链的单位顶点二阶熵仍趋于 $-\log_2(3/4)$，有限长度修正却区分环的奇偶。共享割点的一串短环仍精确使用各环自身的因子。当短环数量与体积同阶时，这些因子可以改变熵密度。公式在 $\theta_e\in(\pi/4)\mathbb Z$ 时还原 [1] 的全图 Clifford 复苏结论。

## 5. 共享边环的任意整数阶

在任意有限简单图上，给定正整数 $m$。每个顶点取字母 $z_v=(a_v,x_v^1,\ldots,x_v^{2m-1})\in\{0,1\}^{2m}$，并定义 $x_v^{2m}=\bigoplus_{\ell<2m}x_v^\ell$。令 $\epsilon_\ell=-1$ 当 $1\le\ell\le m$，其余取 $+1$。对原模型允许的任意边角度，有

$$
F_m(G)=2^{-2mn}\sum_z\prod_{uv\in E}
\exp\left[2i\theta_{uv}(a_u\oplus a_v)
\sum_{\ell=1}^{2m}\epsilon_\ell(-1)^{x_u^\ell+x_v^\ell}\right].
$$

固定翻转 $a$，写出 $m$ 个 $\widehat f_a(b)$ 与同样多的共轭副本。每份 Walsh 系数带因子 $2^{-n}$。对 $b$ 的全和是当 $\bigoplus_\ell x^\ell=0$ 时的 $2^n$，其余为零。这个 $2^n$ 抵消定义中对 $a$ 求平均的 $2^{-n}$。因此可以消去最后一个副本的独立指标，留下上式。此推导允许两个简单环共用任意多个边。

给定消元宽度为 $w$ 的顶点顺序，将有关一个顶点的因子相乘后对该字母求和。新因子只依赖至多 $w$ 个后继邻点；一次表运算至多处理 $2^{2m(w+1)}$ 个联合字母。初始边因子及消元中新增因子的总数至多 $|E|+n$。固定 $m,w$，该式在已给边相位的复数算术模型中可按图规模的多项式时间精确求值。对共用两端的任意多条内部顶点不相交路径，逐条从一端消去内部顶点，最后消去两端，宽度至多二。表消元使用 Markov–Shi [3] 所代表的张量收缩框架，专门化在于此处的副本约束和边因子。

## 6. $\pi/8$ 量化角下的完整 Pauli 谱

设任意有限简单图的边角为 $\theta_e=t_e\pi/8$，$t_e\in\mathbb Z$。把奇数 $t_e$ 的边组成生成子图 $H$，对每个翻转 $a\in\mathbb F_2^V$ 取出 $H$ 中的所有跨岸边，仍保留全部顶点，得到 $H_a$。记 $L_a$ 为 $H_a$ 的普通图 Laplacian 在 $\mathbb F_2$ 上的约化，即邻接矩阵加度数对角。令 $r_a=\operatorname{rank}_{\mathbb F_2}L_a$。

**定理。** 每个翻转 $a$ 下，恰有 $2^{r_a}$ 个相位标签 $b$ 的 Pauli 期望模方为 $2^{-r_a}$，其余为零。因此对每个实数 $\alpha>0$，

$$
F_\alpha(G)=2^{-n}\sum_{a\in\mathbb F_2^V}2^{(1-\alpha)r_a},
\qquad M_1(G)=2^{-n}\sum_a r_a.
$$

**证明。** 忽略与 $x$ 无关的单位复相位，固定翻转的相位函数是 $i^{q_a(x)}$，其中 $q_a(x)=\sum_{uv\in C(a)}t_{uv}(x_u\oplus x_v)$ 取模四，异或的值先提升为 $0$ 或 $1$。的确边的奇偶从零改为一时，演化因子之比是 $\exp(4i\theta_e)=i^{t_e}$。对任意比特向量 $h$，

$$
q_a(x+h)-q_a(x)-q_a(h)=2x^{\mathsf T}L_a h\pmod4 .
$$

这来自每条跨岸奇边的关联向量的外积。于是 $i^{q_a}$ 归一化自相关
$2^{-n}\sum_x i^{q_a(x+h)-q_a(x)}$ 在 $K=\ker L_a$ 上等于 $i^{q_a(h)}$，在其余点为零。极化恒等式使 $i^{q_a}$ 限制在 $K$ 上成为群字符。因为 $K$ 的每个元素至多二阶，该字符只取 $\pm1$，故可写成某个二元线性形式的符号。自相关的归一化 Walsh 变换正是原函数 Walsh 系数的模方。由字符正交性，模方在 $K^\perp$ 的一个陪集上等于 $|K|/2^n$，在其他点为零。因此全谱如述，对 $a$ 平均即为 $F_\alpha$。有限和在一阶处可微，取极限得到 $M_1$。

这里同时使用两岸所有顶点以及度数对角，给出的秩也可以为奇数。经典二次型与稳定子态表示见 Dehaene–De Moor [4]。Kagamihara–Tsuchiya [5] 的定理 1 已以同形秩母函数精确计算三均匀超图态的矩，包括按翻转求和及将相位标签求和缩成一个秩。该文的 CCZ 差分产生零对角交替矩阵，秩为偶数。本定理把图伊辛相位的矩阵识别为带度数对角的截交 Laplacian。单边图的两个非空定向割都产生秩一，已区分这两种秩分布。Chen–Yan–Zhou [6] 的第 5 节同样利用完全三均匀态的排列对称与取模二后的结构。其二阶熵在两个规模奇偶子序列中均趋于三，第 7 节的两体伊辛态则在奇数子序列具有正熵密度。对一般图，本定理可用二元消元在 $O(2^n(n^3+|E|))$ 次域运算及简单计数中取得整个秩直方图。

## 7. 完全图的奇偶熵密度

设 $H=K_n$ 且 $n\ge2$，写 $z=2^{1-\alpha}$。所有边可以独立选取任意奇乘数。矩的闭式为

$$
F_\alpha(K_n)=
\begin{cases}
2^{-n}\big[2+(2^{n-1}-2)z^2+2^{n-1}z^{n-1}\big],&n\ \text{为偶数},\\
2^{-n}\big[(1+z)^n+(1-z)^n\big],&n\ \text{为奇数}.
\end{cases}
$$

非空两岸大小为 $u,v$ 时，割图是 $K_{u,v}$。其核方程为
$(v\bmod2)x_i=\sum_j y_j$ 与 $(u\bmod2)y_j=\sum_i x_i$。两岸皆偶时只约束两岸各自的坐标和为零，秩为二。两岸皆奇时两边所有坐标相等，秩为 $n-1$。一岸为偶时，偶岸坐标由奇岸总和决定，满足另一组方程，秩为偶岸大小。两个空割各给秩零。偶数 $n$ 有 $2^{n-1}$ 个奇奇割，其余为偶偶割。奇数 $n$ 时，在偶岸大小为 $k$ 时有 $2\binom nk$ 个割，包括 $k=0$。求偶项的二项式和即得公式。

固定 $\alpha>1$ 时 $0<z<1$，故偶数 $n$ 子序列的矩趋于 $z^2/2$，熵趋于 $(1+2(\alpha-1))/(\alpha-1)$。奇数 $n$ 子序列满足

$$
\lim_{n\to\infty,\ n\,\mathrm{odd}}\frac{M_\alpha(K_n)}n
=\frac{\log_2((1+z)/2)}{1-\alpha}>0.
$$

于是同一族稠密图只由顶点数的奇偶即能区分有界熵和严格正的熵密度。在任意连续边角下，一般稠密图的非整数阶求值不由上述公式给出。

## 8. 复核与形式化范围

小规模检验对每个翻转 $a$ 直接计算所有高斯整数相位值，再做精确 Walsh 变换。它与边块公式比较一、二、三阶矩。检验涵盖正负三角函数值、奇偶环、桥、孤立点以及两个偶环共享割点。任意规模、连续角度及无界树宽的相应结论以第 3、5、6 节的证明为依据。本文不提供 Lean 形式化证明。

## 来源

1. Rishabh Jha、Karun Gadge，[Magic Without Entanglement: Exact Revivals and Their Fisher Information Origin](https://arxiv.org/pdf/2607.14222v2)，正文第 5 页与补充材料 S4.C–F，Physical Review Letters 接收页面 [10.1103/c98q-fhbn](https://doi.org/10.1103/c98q-fhbn)。
2. Lorenzo Leone、Salvatore F. E. Oliviero、Alioscia Hamma，[Stabilizer Rényi Entropy](https://doi.org/10.1103/PhysRevLett.128.050402)，Physical Review Letters 128, 050402 (2022)。
3. Igor L. Markov、Yaoyun Shi，[Simulating quantum computation by contracting tensor networks](https://arxiv.org/abs/quant-ph/0511069)，SIAM Journal on Computing 38(3), 963–981 (2008)。
4. Jeroen Dehaene、Bart De Moor，[Clifford group, stabilizer states, and linear and quadratic operations over GF(2)](https://arxiv.org/pdf/quant-ph/0304125)，Physical Review A 68, 042318 (2003)，第 IV 节定理 5。
5. Daichi Kagamihara、Shunji Tsuchiya，[Stabilizer Rényi entropy of 3-uniform hypergraph states](https://arxiv.org/html/2602.23687v1)，第 III 节定理 1 及式 (9)–(11)。
6. Junjie Chen、Yuxuan Yan、You Zhou，[Magic of quantum hypergraph states](https://quantum-journal.org/papers/q-2024-05-21-1351/)，Quantum 8, 1351 (2024)，第 3、5 节与附录 F。
