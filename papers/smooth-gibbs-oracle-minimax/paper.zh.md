---
title: "光滑 Gibbs 查询问题：精确点值指数和有界误差的高温转折"
author: "Research manuscript"
date: "2026-11-25"
lang: zh-CN
---

# 研究概览与结论边界

考虑紧域上光滑的 Gibbs 势，算法每条路径至多向 oracle 求值 $n$ 次。本文确定高温区的对数归一化风险和一次采样风险，给出精确点值模型的三类采样指数速度、任意预算下的风险界以及有限事件的最优证书。对有界、可适应历史及当前查询的点值误差，我们给出高温归一化风险的匹配量级，以及采样负对数风险中预算与误差精度的精确转折。

设 $s=m/d$，$t=Bn^{-s}$，并记 $h=\min(B,\eta)$，其中 $\eta$ 是点值误差的上界。当 $0<t\le1$，最坏对数归一化绝对风险为 $\Theta_{m,d}(\min\{B,\eta+t/\sqrt n\})$。当 $n\to\infty$、$t\to0$、$h\to0$，最坏无条件采样 TV 风险的负对数等价于 $\min\{n\log(1/t),\log(1/h)\}$，约定 $h=0$ 时后一项为 $+\infty$。截断拒绝采样以理想接受概率对每步误差加权，因此任意允许的误差路径产生至多 $O(\eta)$ 的分布偏差。完整中低温相图仍开放。

## 原问题及精度要求

固定整数 $d,m\geq1$，令 $s=m/d$，$B>0$，$n\geq1$，

$$
\mathcal F_{d,m,B}=\left\{f\in C^m([0,1]^d):
\max_{|\alpha|\leq m}\|\partial^\alpha f\|_\infty\leq B\right\}.
$$

范数包含零阶。记 $Z_f=\int e^f$、$L_f=\log Z_f$、$P_f(dx)=e^{f(x)}dx/Z_f$。允许自适应和任意与未知输入独立的内部随机性；每条执行路径查询至多 $n$ 次。两个风险是

$$
R_L(B,n)=\inf_{\mathcal A}\sup_{f\in\mathcal F_{d,m,B}}
\mathbb E|\mathcal A(f)-L_f|,
$$

$$
R_\mathrm{TV}(B,n)=\inf_{\mathcal A}\sup_{f\in\mathcal F_{d,m,B}}
\operatorname{TV}\bigl(\operatorname{Law}(\mathcal A(f)),P_f\bigr).
$$

第二式比较混合全部内部随机性之后的输出分布。它不等于对条件 TV 损失再求期望。查询模型不提供梯度、归一化子或未知分布采样接口，预算也不只是期望意义上的限制。

常数只允许依赖 $d,m$。若风险含指数中的尺度常数，不能把这些常数解释成风险外部的无害倍数。超指数误差的匹配精度必须明确写在对数尺度上。所有代理计算均给出只使用已知插值函数的有限近似实现说明。

## 与最近工作的关系

直接基线是 Holzmüller–Bach 的 *Convergence Rates for Non-Log-Concave Sampling and Log-Partition Estimation*（JMLR 26(249), 2025；本次核对 arXiv:2303.03237v4，2026-04-23）。该文提供确定性复杂度、随机重要性采样和逼近—拒绝采样上界，并讨论随机下界与过渡区域的问题。本报告沿用其问题背景和已有上界机制；具体定理编号均以 v4 为准。[来源 S1]

有限决策树的低次数性质、Bernstein 系数约束、超几何核与次数提升、光滑局部扰动、Jensen 不等式和两分布下界都是既有方法。本报告的候选增量是这些方法在当前未知归一化子模型下产生的具体风险结论与证书，而不是重新声称这些工具的原创性。查新是有限范围的证据检查，不能视为数学优先权的证明。

# 已证明结果

## 采样：有限预算的非零误差与高温首阶指数

存在明确可计算的 $c_{m,d}>0$，对每个 $B>0,n\geq1$，

$$
R_\mathrm{TV}(B,n)\geq
\frac12\left[c_{m,d}\min\{B(n+1)^{-s},1\}\right]^{n+1}>0.
$$

证明把 $n+1$ 个互不相交的光滑扰动编码成 Boolean 位。至多 $n$ 次查询的算法，其任意固定输出事件概率在最高阶 parity 系数上为零；目标事件的概率却是未知归一化子的倒数，其对应系数严格为正。证书为

$$
\frac{vN!\tau^N}{2^N\prod_{k=0}^{N}(1+k\tau)},\qquad N=n+1.
$$

这里 $v$ 是公共背景事件的体积，$\tau$ 是单个扰动引起的归一化质量增量。困难输入在完整随机算法确定后选取，不依赖随机种子的实现。附录 A 给出全部嵌入、导数界、量词与差分细节。

与已有逼近—拒绝采样机制及附录 C 的预算分配结合，对于任意满足 $n\to\infty$、$B_n n^{-s}\to0$ 的序列，

$$
\boxed{
\frac{-\log R_\mathrm{TV}(B_n,n)}
{n\log(n^s/B_n)}\longrightarrow1.}
$$

这确定的是高温区域的首阶负对数精度。特别地，固定 $B$ 时系数为 $s$；若 $B_n\asymp n^\beta$、$\beta<s$，则 $-\log R_\mathrm{TV}\sim(s-\beta)n\log n$。固定 $n$ 而 $B\downarrow0$ 时，另有 $R_\mathrm{TV}=\Theta_{m,d,n}(B^{n+1})$。这些推论不宣称中温和低温全部匹配。

## 对数归一化常数：高温匹配和全参数界

令 $t=Bn^{-s}$。对 $0<t\leq1$，本次下界与已有随机上界相接，得到

$$
\boxed{R_L(B,n)=\Theta_{m,d}\bigl(Bn^{-s-1/2}\bigr).}
$$

更一般地，附录 B 给出显式常数 $\alpha_{m,d}>0$、$D_d=2^{d+1}$，使所有 $B,n$ 满足

$$
R_L(B,n)\geq\frac1{30000}
\log\left(1+\frac{2\sinh(\alpha_{m,d}t/2)}{\sqrt{D_dn}}\right).
$$

证明使用有符号扰动和正扰动两类有限先验。关键步骤是：在任意自适应查询的叶子上，尚未观察的位保留条件独立性；通过反集中和两后验样本的分离，直接控制非线性的 $\log Z_f$，而不是把线性积分下界未经论证地代入对数。

二次研究改进了同一残差重要性采样算法的分析。若 $k$ 次插值查询给出 $\|f-g\|_\infty\leq\delta_k$，余下 $r=n-k\geq1$ 次查询用于 $P_g$ 提议点，则

$$
R_L(B,n)\leq4\log\left(1+\frac{2\sinh\delta_k}{\sqrt r}\right).
$$

附录 E 明确给出插值误差常数及全部有限预算的处理，得到

$$
R_L(B,n)\leq\min\left\{C_0t,
4\log\left(1+\frac{2\sinh(C_1t)}{\sqrt n}\right)\right\},
$$

其中 $C_0,C_1$ 只依赖 $m,d$。在同一给定误差证书 $\delta=(\log r)/3$ 下，新上界为 $O(r^{-1/6})$；原来显示的 $2e^{2\delta}\delta/\sqrt r$ 界不能保证误差趋于零。这是对上界分析的实际加强，但并没有改变原始 oracle 模型。

## 二次研究的两个辅助问题

**有界正随机变量的对数均值。** 若 $n$ 个 iid 样本来自任意支撑于 $[1,\kappa]$ 的分布，记

$$
F_n(\kappa)=\log\left(1+\frac{\kappa-1}{\sqrt{n\kappa}}\right).
$$

估计 $\log\mathbb EX$ 的最坏期望绝对误差满足

$$
\frac1{64}F_n(\kappa)\leq
\inf_{\widehat\ell}\sup_P\mathbb E_P|\widehat\ell-\log\mathbb E_PX|
\leq\sup_P\mathbb E_P|\log\overline X-\log\mathbb E_PX|
\leq4F_n(\kappa).
$$

上界来自经典均值相关方差界和 Jensen 不等式，下界来自两个 Bernoulli 实验。该辅助定理可直接提供上述残差权重上界；其最坏分布不能未经额外嵌入证明反向解释成光滑 Gibbs 类的匹配下界。

**有限总体的单事件极小极大误差。** 对 $M>n$ 个未知 Boolean 位，目标事件概率为 $g_k=v/(1+\tau k)$，其中 $k$ 为总一位数。所有至多 $n$ 次查询算法在置换对称化后可实现的事件概率恰为

$$
q_k=\sum_{j=0}^{n}H_{k,j}a_j,\qquad
H_{k,j}=\frac{\binom{k}{j}\binom{M-k}{n-j}}{\binom Mn},
\quad 0\leq a_j\leq1.
$$

因此最优单事件误差是紧致线性规划

$$
E_{M,n}(\tau,v)=\min_{a\in[0,1]^{n+1}}\|Ha-g\|_\infty.
$$

附录 D 给出对偶公式和恢复到同一光滑函数族的下界。固定 $M,n,v$ 而 $\tau\to\infty$ 时，

$$
E_{M,n}(\tau,v)\longrightarrow\frac{v(M-n)}{2M-n}.
$$

这加强了只保留最高阶 parity 系数得到的事件下界。二次研究进一步利用 Bernstein 次数提升矩阵的显式逆行，保留叶子概率的非负性，得到真正适用于联合过渡尺度的下界：当 $M=4n$、$n\geq16$、$\tau\geq16/n$ 时，

$$
v\,10^{-(2/\tau+3)}\leq E_{4n,n}(\tau,v)
\leq v\min\{1/2,\exp[-16/(65\tau)]\}.
$$

上界用经典倒数概率的几何级数截断构造；下界用次数提升的逆行作为对偶证书。关键是证明相关系数多项式在两个区间上的符号和幅度，而不是仅输出 LP 的数值答案。与小 $\tau$ 的 parity 证书合并，得到辅助问题全部 $\tau>0$ 的精确量级说明：

$$
\boxed{\log\frac{v}{E_{4n,n}(\tau,v)}
=\Theta\!\left(1+n\log\left(1+\frac1{n\tau}\right)\right),
\qquad n\geq16.}
$$

这里隐含常数是绝对常数，附录 D 给出显式界。这个“全部参数”结论只针对明确定义的有限单事件实验。其原问题解只构造一个事件概率，不能直接构造完整 Gibbs 输出分布。

## 采样过渡区的新下界与指数速度分类

将逆行证书恢复到同一光滑函数类后，存在显式的 $\beta,C_*,b_0>0$，只依赖 $m,d$，使得对 $n\geq16$、$b=Bn^{-s}\geq b_0$，

$$
\boxed{R_\mathrm{TV}(B,n)\geq\frac1{2000}
\exp\left[-\frac{C_*n}{e^{\beta b}-1}\right].}
$$

这比原来只给出 $\exp(-Cn)$ 量级的 parity 下界更强，能够证明随 $b$ 增大，最优采样也必然失去固定的线性 $n$ 指数速率。与前述高温定理及已有逼近—拒绝采样上界结合，在 $n\to\infty$ 时得到：

| 幅度—预算尺度 | 已证明的采样速度 |
|:--|:--|
| $b_n=B_n n^{-s}\to0$ | $-\log R_\mathrm{TV}\sim n\log(1/b_n)$ |
| $0<a\leq b_n\leq A<\infty$，$a,A$ 固定 | $-\log R_\mathrm{TV}=\Theta_{m,d,a,A}(n)$ |
| $b_n\to\infty$ | $-\log R_\mathrm{TV}=o(n)$ |

更具体地，在 $b_n\to\infty$ 且 $b_n=o(\log n)$ 时，

$$
\log\left(\frac{n}{-\log R_\mathrm{TV}(B_n,n)}\right)
=\Theta_{m,d}(b_n).
$$

最后一式明确使用更弱的第二层对数精度。这些结论是实质的过渡区进展，但仍不能消除指数内部不同光滑几何常数造成的同参数风险缺口，尤其不能声称整个冻结相图已经按原精度匹配。

# 有界误差 oracle 的高温转折

固定维数 \(d\)、导数阶 \(m\)，\(s=m/d\)。单位立方体、\(\mathcal F_{d,m,B}\) 及两种损失均同主稿，\(n\ge1\) 为每路径硬预算。查询返回 \(f(x)+e,\ |e|\le\eta\)，误差可以依赖历史及当前查询，误差可为随机，并可使用此前对其可见的历史。程序在收到当前回答后才生成本轮接受决定的新私有均匀随机数。算法的两种风险均对势及所有允许的误差策略取最坏值。记 \(t=Bn^{-s}\)。在 \(0<t\le1\) 时，对数归一化常数的风险恰为
\[
 R_{L,\eta}\asymp_{m,d}\min\{B,\ \eta+t/\sqrt n\}.
\]
对于任意 \(n\to\infty,\ t\to0,\ h=\min(B,\eta)\to0\)，当 \(B>0\) 时一次采样的无条件 TV 风险满足
\[
 -\log R_{\mathrm{TV},\eta}\sim
 \min\{\,n\log(1/t),\ \log(1/h)\,\}.
\]
规定 \(h=0\) 的第二项为无穷。两个结论把误差地板与精确点值下的有限预算误差联合起来。

## 两个不可辨识下限

令 $u=\min(B,\eta)$。两常数势 $f_\pm=\pm u$ 均允许在所有查询中回答零，但其 $\log Z$ 相差 $2u$。给两个输入耦合相同随机种子，查询及估计输出全部相同。由三角不等式，至少一侧的期望绝对误差不小于 $u$。

令 $a=\min(B,2\eta)$。两线性势 $f_\pm(x)=\pm a(x_1-\tfrac12)$ 以及其全部纳入范数的偏导均在原球内，且均允许恒答零。两 Gibbs 密度由反射互换，在 $x_1=\tfrac12$ 相交。在半空间 $x_1\ge\tfrac12$ 上两概率之差为
\[
\frac{e^{a/2}-1}{e^{a/2}+1}=\tanh(a/4).
\]
该集合正是两密度差的正部，故其概率差等于目标间的 TV 距离。两个算法输出共享同一个无条件分布，于是最坏 TV 至少为 $\tfrac12\tanh(a/4)$。零误差也是合法策略，因此两项下界分别可与精确点值的相应下界取最大值。

## 稳定插值与归一化算法

用规则网格上逐小立方体的固定阶张量插值构造 \(g\)。原稿的精确值误差为 \(C Bk^{-s}\)，每个小立方体只使用固定数目的 Lagrange 形函数，其绝对值之和在单位参考立方体上一致有界 \(\Lambda=\Lambda_{m,d}\)。故对任意含误差的 \(k\) 个观测，路径逐点保证
\(\|f-g\|_\infty\le D=C Bk^{-s}+\Lambda\eta\)。预算舍入和有限小 \(k\) 可按原稿以 \(g=0,D=B\) 处理。此估计对误差的相关结构无要求。\(Z_g\) 和 \(P_g\) 仅用已知函数；沿原稿的有界拒绝或积分逼近达到任意额外精度，不耗 \(f\) 查询。

剩余 \(r=n-k\) 个独立提议 \(Y_i\sim P_g\) 用于
\(\log Z_g+\log[r^{-1}\sum_i e^{f(Y_i)+e_i-g(Y_i)}]\)。即使误差依赖此前提议和回答，对每个结果，将全部 \(e_i\) 改为零使估计值改变不超过 \(\eta\)。条件于插值历史，理想权 \(e^{f(Y_i)-g(Y_i)}\) 独立且范围为 \([e^{-D},e^D]\)。当 \(D\) 有界时，均值中绝对误差的期望不超过 \((e^D-e^{-D})/(2\sqrt r)\)；对数在该区间的 Lipschitz 常数为 \(e^D\)。若 \(\eta\le1,\ k\asymp n,\ t\le1\)，遂给上界 \(C_{d,m}(\eta+t/\sqrt n)\)，并可取常数零估计的 \(B\) 封顶。有限小预算直接用均匀重要性抽样或零估计，常数仅依赖 \(m,d\)。若 \(\eta>1\) 且 \(B>\eta\)，用网格插值的 \(\log Z_g\) 本身（不做蒙特卡洛），其误差至多 \(D\le C_{d,m}\eta\)，同阶。下界分别用零噪声的原高温下界和两常数势 \(\pm\min(B,\eta)\) 的完全相同回答；两者取大给出公式。

## 采样中的误差为何不乘查询次数

对固定插值历史和提议 \(Y\sim P_g\)，设理想接受概率
\(b(Y)=\exp(f(Y)-g(Y)-D-\eta)\)，其均值为 \(p>0\)。实际用 \(\tilde b=b(Y)e^e\le1\)，新的均匀硬币判断是否接受。最多 \(r\) 次，全部失败则从 \(P_g\) 另取回退样本。用同样的提议、硬币和回退点耦合理想规则；在两者尚未分开且理想规则仍在运行时，发生不同决定要求该硬币落在 \([e^{-\eta}b,e^\eta b]\)。即使误差依赖完整既往历史和当前提议，逐次不同决定的总概率至多
\[
 (e^\eta-e^{-\eta}) \sum_{j=1}^r (1-p)^{j-1}p\le e^\eta-e^{-\eta}.
\]
上式把尚未分开的事件松为此前理想规则全拒绝，后者单独实现时是 iid 试验。理想规则输出的无条件律是 \((1-(1-p)^r)P_f+(1-p)^rP_g\)，且 \(p\ge e^{-2D-\eta}\)。故有限预算有
\[
 R_{\mathrm{TV},\eta}\le
 \min\{1,\ e^\eta-e^{-\eta}
 +(1-e^{-2D-\eta})^r\min(1,e^{2D}-1)\}.
\]
这是对任意逐查询误差的耦合界，无需把噪声回答误认成某个固定光滑势的真值。忽略 oracle、输出均匀律还给 \(\min(1,e^{2B}-1)\) 风险上界。

## 匹配负对数极限

若 \(\eta\ge B\) 且 \(h\to0\)，均匀回退上界 \(O(B)\) 与前轮线性势不可辨识下界 \(\frac12\tanh(\min(B,2\eta)/4)\gtrsim B\) 相接；此时写 $L=\log(1/t)$，有 $nL-\log(1/B)=(n-1)L+s\log n\ge0$。余下可沿 \(\eta<B\) 子列讨论，此时 \(\eta\to0\)。令 \(L=\log(1/t)\)，取 \(k\) 约为 \(n/\min(\sqrt L,\sqrt n)\)，于是 \(k\to\infty,\ k=o(n)\)，且 \(s\log(n/k)=o(L)\)。有 \(D\le \exp[-(1-o(1))L]+O(\eta)\)。有限预算界给
\[
 R_{\mathrm{TV},\eta}\le O(\eta)+
 \exp[-(1-o(1))nL]+(C\eta)^{n-k},
\]
因为 \((x+y)^r\le(2x)^r+(2y)^r\)，常数的对数是 \(o(L)\)。最后项为 \(o(\eta)\)（零噪声时直接删去）。反方向由旧稿精确查询高温指数和上段线性势不可辨识地板得出。两端的最小对数发散，故加法常数不影响等价。

例如 \(D=0.1,\eta=0.01,r=10\) 给硬币分歧概率界 \(0.02000033\)，理想全拒绝回退的额外 TV 上界小于 \(1.4\cdot10^{-8}\)。计算分别使用上界的两项。

原稿的无噪声指数及 Holzmüller–Bach 的插值、拒绝、残差重要性采样均属既有。在原精确查询所得算法上，新增的是允许对抗性输出来回变化的耦合及匹配噪声—预算转折。中低温的全参数相图仍开放。

Holzmüller–Bach 的 JMLR §2.2 和 §4 用准确点值建立插值、重要性采样与预算截断拒绝。Plaskota 研究随机信息噪声。Plaskota–Siedlecki §2 也允许有界确定性误差，但其目标为 Hilbert 空间的线性问题，观测可选择带精度成本的线性泛函。He–Zhang 使用全空间梯度 oracle。这里的两项目标是非线性的，查询点值的误差水平统一固定，且采样使用回答后生成的硬币。[Holzmüller–Bach 原文](https://www.jmlr.org/papers/v26/24-1494.html) · [Plaskota](https://doi.org/10.1006/jcom.1996.0026) · [Plaskota–Siedlecki 作者原文](https://arxiv.org/pdf/2303.16328) · [He–Zhang](https://arxiv.org/abs/2502.06200v3)

# 证明、计算与形式化证据

## 证据分层

| 证据 | 已验证内容 | 不能由此推断的内容 |
|:--|:--|:--|
| 五份完整推导及交叉审查 | 本报告列出的部分定理、辅助模型、实现和量词 | 原始全参数相图已经解决 |
| 有理数有限证书程序 | 差分恒等式、有限树消去、有限 LP 的原对偶等值 | 连续模型中未证明的相变规律 |
| 浮点诊断 | 指定有限实验的公式计算与数值检查 | 严格概率定理或精确实数认证 |
| Lean 编译及公理审计 | 所有自然数阶倒数递归差分的代数恒等式与正性；2 项定义、7 项定理 | 全文概率论、光滑嵌入与极小极大结论的形式化 |

基础 LP 组有 68 份有理数证书；过渡区定向实验另有 14 份证书记录，其中一个参数点重复。合计为 82 份证书记录、79 个不同参数实例（定向实验另有两个参数点与基础组重合）。另一个 $M=32,n=16,\tau=1/32$ 实例未能从浮点候选恢复精确证书，明确记录为未认证，不计入通过结果。独立验证器只使用 Python 标准库的有理数运算，重建超几何核并检查原对偶界相等，不信任浮点优化器的最优性报告。

新增逆行程序另保存 40 组精确对偶下界见证，并检查 1188 个有理参数递推恒等式。此组是下界证书，不与前述 LP 原对偶等值的最优值证书混计。

其他程序的算术性质均在结果文件中标明；特别是 Bayes 风险曲线计算使用浮点数，而相关有限矩计算才是精确有理数检查。数学结论的依据是书面证明；有限数值实验只服务于寻找证书与排查错误。

## 形式化范围

Lean 模块证明一般起点 $a>0$、步长 $\tau>0$、所有自然数阶 $N$ 的递归差分闭式与正性。工具链为 Lean 4.19.0，mathlib 固定到记录中的提交；只使用 Classical.choice、Quot.sound、propext。没有 sorry、admit 或新增公理，独立复编已通过。

仍需形式化：有限交替和与递归差分的桥接、连续随机种子的积分、决策树叶子结构、光滑嵌入、TV 和 log-partition 风险、超几何可实现集合、辅助统计实验以及上界实现与极限。上述编译和独立审计属于历史代数检查点。本文新增噪声定理的数学依据为书面证明。

## 研究来源与时间顺序

精确点值部分先完成两轮推导并保留各自的有限证书。随后分别加入不可辨识误差下限、带噪高温转折和有限预算耦合。各阶段的来源与独立核查列于文稿编辑记录。

# 尚未解决的问题及可继续的最小任务

首要缺口是 $t=Bn^{-s}$ 随 $n$ 增长时的统一匹配精度。上下界虽已有共同的 $\log(1+\sinh(\cdot)/\sqrt n)$ 外形，但不同常数仍在双曲正弦内部；当 $t=\gamma\log n$ 时，这会改变 $n$ 的幂次，不能忽略。

对采样，有限单事件问题在 $M=4n$ 时的全幅度负对数最优量级已经得到，且其逆行证书已合法转移为连续模型的过渡下界。剩余问题是识别这一事件障碍与完整分布输出之间的差距，并使下界中的有效几何尺度与可实现采样上界对齐。一个具体继续任务是：研究非同质扰动与多个事件的联合可实现约束，证明或否定同质扰动加公共背景事件足以给出原模型的尖锐相变尺度。

对 log-partition，一个明确的继续任务是：识别自适应点值查询后可实现的最坏残差权重分布，并将光滑逼近与下界扰动置于同一几何尺度。任意支撑在 $[1,\kappa]$ 的 iid 类已经解决，但此类与原问题并无已证等价性。

带噪高温结果与精确查询高温结果共享这一边界。特别是有限单事件的最优速度不能直接用来构造完整 Gibbs 输出。

# 来源索引与完整证明导读

S1. Holzmüller–Bach. *Convergence Rates for Non-Log-Concave Sampling and Log-Partition Estimation*. [arXiv:2303.03237v4](https://arxiv.org/html/2303.03237v4)；[JMLR 26(249)](https://jmlr.org/papers/v26/24-1494.html)。

S2. Buhrman–Vereshchagin–de Wolf. *On Computation and Communication with Small Bias*. [作者机构 PDF](https://ir.cwi.nl/pub/11750/11750D.pdf)。有限查询多项式方法的先行工作。

S3. Goyal–Sigman. *On simulating a class of Bernstein polynomials*. [作者 PDF](https://www.columbia.edu/~vg2277/simulate_bernstein.pdf)；DOI 10.1145/2133390.2133396。固定样本量与有界 Bernstein 系数的先行工作。

S4. Nacu–Peres. *Fast simulation of new coins from old*. [arXiv:math/0309222v5](https://arxiv.org/abs/math/0309222v5)。Bernstein 方法和超几何核的先行工作。

S5. Cordero–Hummel–Schertzer. *General selection models: Bernstein duality and minimal ancestral structures*. [实际核对的机构作者全文](https://www.sfb1283.uni-bielefeld.de/preprints/sfb19007.pdf)（arXiv:1903.06731 的早期稿）。第 7 节记录超几何核与次数提升。

S6. Bhatia–Davis. *A Better Bound on the Variance*. [DOI 10.1080/00029890.2000.12005203](https://doi.org/10.1080/00029890.2000.12005203)。本报告所需标量不等式另外完整自证。

S7. Liao–Berg. *Sharpening Jensen's Inequality*. [作者 PDF](https://arthurberg.com/papers/Liao_19.pdf)。Jensen gap 的相关研究；不声称其包含本报告的辅助极小极大公式。

S8. Huber. *An optimal (epsilon, delta)-approximation scheme for the mean of random variables with bounded relative variance*. [arXiv:1706.01478v2](https://arxiv.org/abs/1706.01478v2)。高概率相对误差模型的近邻工作。

S9. Maddison et al. *Filtering Variational Objectives*. [NeurIPS 2017 原文](https://papers.nips.cc/paper_files/paper/2017/file/fa84632d742f2729dc32ce8cb5d49733-Paper.pdf)。对数 Monte Carlo 估计的偏差和方差背景。

S10. He–Zhang. *On the query complexity of sampling from non-log-concave distributions*. [arXiv:2502.06200v3](https://arxiv.org/abs/2502.06200v3)。全空间、梯度光滑和矩约束的不同 oracle 模型；没有把它与本题紧域 $C^m$ 范数模型混同。

S11. Huber. *Optimal linear Bernoulli factories for small mean problems*. [arXiv:1507.00843v2](https://arxiv.org/pdf/1507.00843)。第 2 节的 logistic factory 是倒数概率构造的直接先例；本报告不主张发明几何截断机制。

S12. Koskela–Karvonen–Łatuszyński–Spanò. *A debiased Bernoulli factory and unbiased estimation of a probability*. [arXiv:2510.01941v2](https://arxiv.org/html/2510.01941v2)，2026-09-01。其样本数为无界的随机变量，并非每条路径固定最大预算；因此不与本报告有限预算非零误差结论冲突。

S13. Holtz–Nazarov–Peres. *New coins from old, smoothly*. [arXiv:0808.1936v3](https://arxiv.org/pdf/0808.1936)。其一致 Bernstein 近似与随机停止尾部结果是重要近邻；本报告的逆系数下界逐项自证，没有援引不满足假设的通用逆逼近命题。

以下附录收录五份完整的精确点值证明，保留原分节编号和各阶段的证明范围。带噪部分的完整论证已列在正文。


\clearpage

# 附录 A：采样下界与联合高温极限


本附录保留精确点值采样下界的原推导。其有限预算下界与附录 C 的上界共同给出正文的高温极限。

本节使用经典的有限查询决策树多项式思想。新结论的候选贡献是将其用于未知 Gibbs 归一化子的高阶差分，从而得到原无条件输出 law 的非零定量下界，并与已有逼近—拒绝采样上界对接。多项式表示和拒绝采样框架均不主张原创。

### 1. 模型及主要结论

令整数 $d,m\ge1$，$B>0$，$n\ge1$，$s=m/d$，$\mathcal X=[0,1]^d$。定义

$$\mathcal F_{d,m,B}=\{f\in C^m(\mathcal X):\max_{|\alpha|\le m}\|\partial^\alpha f\|_\infty\le B\}.$$

范数包含 $\alpha=0$。算法可以使用任意内部随机种子 $\omega$，自适应查询精确函数值，并在每条执行路径上查询至多 $n$ 次，然后输出 $X_f\in\mathcal X$。种子分布可以依赖已知参数 $d,m,B,n$，但不依赖未知输入 $f$；查询点及后续计算仍可依赖此前已读的值。其无条件输出 law 为 $Q_f=\operatorname{Law}(X_f)$。令

$$P_f(dx)=Z_f^{-1}e^{f(x)}dx,\qquad Z_f=\int_{\mathcal X}e^{f(x)}dx,$$

$$R_\mathrm{TV}(B,n)=\inf_{\mathcal A}\sup_{f\in\mathcal F_{d,m,B}}\sup_{E\subseteq\mathcal X\ {
m measurable}}|Q_f(E)-P_f(E)|.$$

#### 定理 S1（全有限预算的显式 TV 下界）

设

$$D_{m,d}=2^{d(m+1)}[2(m+1)]^m,$$

$$I_{m,d}=\left(\frac{2^{2m+3}((m+1)!)^2}{(2m+3)!}\right)^d,\qquad
c_{m,d}=\frac{I_{m,d}}{12D_{m,d}8^{m+d}}.$$

则对所有 $B>0,n\ge1$，有

$$\boxed{R_\mathrm{TV}(B,n)\ge\frac12\left[c_{m,d}\min\{B(n+1)^{-s},1\}\right]^{n+1}>0.}\tag{S1}$$

该结论对任意可测随机化和自适应策略成立。它比较的是**内部随机性全部混合后的输出 law**，不是按 transcript 或种子条件化后再平均的 TV。

下面的精确有限族证书比 (S1) 更强，且不需要将 bump 振幅截断到 $1$。

#### 定理 S2（精确 reciprocal-normalizer 证书）

令 $N=n+1$，$L=\lceil N^{1/d}\rceil$，$\rho=(4L)^{-1}$。取 $N$ 个不同的 $L^d$ 等分网格单元中心 $z_1,\ldots,z_N$。定义

$$\phi_m(u)=\begin{cases}(1-u^2)^{m+1},&|u|\le1,\\0,&|u|>1,\end{cases}
\qquad \psi(u)=\prod_{j=1}^d\phi_m(u_j).$$

任取

$$0<a\le B\rho^m/D_{m,d},$$

并令

$$f_\theta(x)=a\sum_{i=1}^N\theta_i\psi((x-z_i)/\rho),\qquad\theta\in\{0,1\}^N.$$

这些函数都属于 $\mathcal F_{d,m,B}$。设

$$t=\rho^d\int_{[-1,1]^d}(e^{a\psi(u)}-1)du>0,\qquad
v=1-N(2\rho)^d\ge\frac12.$$

则

$$\boxed{R_\mathrm{TV}(B,n)\ge
\frac{vN!t^N}{2^N\prod_{k=0}^{N}(1+kt)}.}\tag{S2}$$

这里 $k=0$ 的因子等于 $1$。右端是**所有**至多 $n$ 次查询算法共用的下界，不依赖算法，更不依赖其随机种子。

### 2. 显式光滑嵌入

#### 引理 S3（范数与质量）

上述 $\phi_m$ 属于 $C^m(\mathbb R)$：在 $u=\pm1$，多项式零点的阶数为 $m+1$，所以 $0$ 至 $m$ 阶导数均与外部零函数连续拼接。因此 $\psi\in C^m(\mathbb R^d)$，$0\le\psi\le1$，其正集为 $(-1,1)^d$。

对 $0\le r\le m$，多项式展开给出

$$\|\phi_m^{(r)}\|_\infty
\le\sum_{2j\ge r}\binom{m+1}{j}\frac{(2j)!}{(2j-r)!}
\le2^{m+1}[2(m+1)]^r.$$

所以对 $|\alpha|\le m$，

$$\|\partial^\alpha\psi\|_\infty\le
2^{d(m+1)}[2(m+1)]^{|\alpha|}\le D_{m,d}.$$

各个闭支撑立方体 $z_i+\rho[-1,1]^d$ 两两不交且位于 $\mathcal X$ 内部。故在任意一点，所有阶数不超过 $m$ 的导数至多有一个非零项。由于 $\rho\le1$，

$$\|\partial^\alpha f_\theta\|_\infty
\le aD_{m,d}\rho^{-|\alpha|}
\le aD_{m,d}\rho^{-m}\le B.$$

这也验证了零阶范数约束，没有将函数值上界遗漏。

不交正集的体积为 $N(2\rho)^d\le2^{-d}$，故其补集体积 $v\ge1-2^{-d}\ge1/2$。此外

$$\int_{[-1,1]^d}\psi(u)du=I_{m,d}.$$

最后的恒等式可由二项式积分或 Beta 积分得到；一维积分恰为 $2^{2m+3}((m+1)!)^2/(2m+3)!$。证毕。

### 3. 连续查询、连续种子与 Boolean 信息

#### 引理 S4（固定种子的叶子配对）

固定任意合法算法、任意随机种子 $\omega$ 和任意可测事件 $E\subseteq\mathcal X$。在输入族 $\{f_\theta\}$ 上，函数

$$h_\omega(\theta)=\boldsymbol1\{X_{f_\theta}(\omega)\in E\}$$

满足

$$\sum_{\theta\in\{0,1\}^N}(-1)^{|\theta|}h_\omega(\theta)=0.\tag{S3}$$

**证明。** 固定种子后算法为确定性过程。当前查询点 $x$ 由此前 transcript 确定。若 $x$ 不位于任何 bump 的正集中，oracle 返回值恒为 $0$，不揭露任何位。若 $x$ 位于第 $i$ 个正集中，则其值为

$$f_\theta(x)=a\psi((x-z_i)/\rho)\theta_i,$$

其中乘数是一个已知的严格正数，所以该查询至多揭露 $\theta_i$。不存在一次查询同时涉及两个未知位的情形。支撑边界上的值为 $0$，已包含在第一种情况。

因此，在这个有限输入族上，算法诱导一棵深度至多 $n$ 的二叉决策树；无信息查询可压缩成单分支。每个非空叶子对应一个 Boolean cylinder：至多 $n$ 个已查询坐标被固定，其他坐标自由。即使某个位被重复查询，固定坐标的数目也不会增加。自适应性没有改变这一点：任何满足这些坐标约束的输入，逐步产生相同 transcript，因而到达同一叶子。

每个叶子至少有一个自由坐标，因为 $N=n+1$。该叶子的输出 $X_{f_\theta}(\omega)$ 完全确定，故 $h_\omega$ 在叶子上为常数。沿一个自由坐标将输入两两配对，其 parity 符号相反，叶子上的带符号和为零。对所有有限个叶子求和得 (S3)。证毕。

这也等价于通常的“深度至多 $n$ 的决策树给出次数至多 $n$ 的多重线性多项式”表述，但上述叶子证明不需要额外的多项式表示假设。

#### 引理 S5（先平均种子，后比较 TV）

令 $q_E(\theta)=Q_{f_\theta}(E)$。则

$$2^{-N}\sum_\theta(-1)^{|\theta|}q_E(\theta)=0.\tag{S4}$$

**证明。** 对每个输入，$h_\omega(\theta)$ 可测且介于 $0$ 和 $1$。对 (S3) 取任意种子分布的积分，并交换积分和**有限**求和即可。种子可以是连续随机变量，也可以是一整条随机带；不需要有限种子集或离散随机性。

算法模型要求每条路径的预算限制，故 (S3) 对全部种子成立。即使改为“每个输入几乎处处满足同一个确定预算”，本有限族也允许对 $2^N$ 个满测度种子集合取交集，证明仍成立。这里不包括仅限制期望查询数的模型。证毕。

关键顺序是先得到真正无条件概率 $q_E$，再取它与目标概率的差。我们没有选取依赖已观察种子的困难输入，也没有使用 $\mathbb E_\omega\operatorname{TV}(\cdot\mid\omega)$。

### 4. 精确高阶差分

取同一个事件

$$A=\mathcal X\setminus\bigcup_{i=1}^N(z_i+\rho(-1,1)^d).$$

它包含所有支撑边界，且与 $\theta$ 无关。边界的 Lebesgue 质量为零；即便算法在边界输出原子，$A$ 仍是合法 TV 测试事件。

由于支撑不交，

$$e^{f_\theta(x)}=1+\sum_i\theta_i(e^{a\psi((x-z_i)/\rho)}-1),$$

所以恰有

$$Z_{f_\theta}=1+t|\theta|,\qquad
P_{f_\theta}(A)=\frac{v}{1+t|\theta|}.\tag{S5}$$

#### 引理 S6（倒数的有限差分恒等式）

对每个整数 $N\ge0$ 和实数 $t>0$，

$$F_N(t):=\sum_{k=0}^N(-1)^k\binom Nk\frac1{1+kt}
=\frac{N!t^N}{\prod_{k=0}^N(1+kt)}.\tag{S6}$$

特别地 $F_N(t)>0$。

**证明。** 由有限二项式展开，

$$F_N(t)=\int_0^1(1-x^t)^Ndx.$$

当 $N=0$ 时积分为 $1$。当 $N\ge1$ 时，分部积分给出

$$F_N(t)=Nt\int_0^1x^t(1-x^t)^{N-1}dx
=Nt(F_{N-1}(t)-F_N(t)).$$

所以 $F_N(t)=\frac{Nt}{1+Nt}F_{N-1}(t)$；归纳即得 (S6)。分部积分可先在 $[\varepsilon,1]$ 上做，再令 $\varepsilon\downarrow0$，其边界项与积分均收敛。证毕。

#### S2 的证明

令 $q(\theta)=Q_{f_\theta}(A)$。由 S5 和 S6，

$$2^{-N}\sum_\theta(-1)^{|\theta|}P_{f_\theta}(A)
=\frac{vF_N(t)}{2^N}.
$$

由 S4，算法概率的同一系数为零。因此

$$\begin{aligned}
\max_\theta\operatorname{TV}(Q_{f_\theta},P_{f_\theta})
&\ge\max_\theta|q(\theta)-P_{f_\theta}(A)|\\
&\ge\left|2^{-N}\sum_\theta(-1)^{|\theta|}
       (q(\theta)-P_{f_\theta}(A))\right|\\
&=\frac{vN!t^N}{2^N\prod_{k=0}^N(1+kt)}.
\end{aligned}$$

困难输入 $\theta$ 在整套随机算法的 law 确定后选取，不能依赖种子的实现。上式对任意算法均成立；对算法取 infimum 得 S2。

### 5. 从精确证书到统一显式界

记 $x=B N^{-s}$，选择

$$a=\gamma_{m,d}\min\{x,1\},\qquad
\gamma_{m,d}=(D_{m,d}8^m)^{-1}.$$

因为 $L\le2N^{1/d}$，所以 $\rho\ge(8N^{1/d})^{-1}$。于是

$$aD_{m,d}\rho^{-m}\le N^s\min\{BN^{-s},1\}\le B,$$

故该选择满足 S2 的嵌入条件。并且 $a\le1$。由 $e^z-1\ge z$，

$$Nt\ge N\rho^d a I_{m,d}\ge\frac{aI_{m,d}}{8^d}.\tag{S7}$$

另一方面，对 $0\le z\le1$，$e^z-1\le(e-1)z\le2z$。结合 $I_{m,d}\le2^d$，得

$$Nt\le2aN\rho^d I_{m,d}\le2a\,2^{-d}\le a\le1.\tag{S8}$$

因此 $\prod_{k=1}^N(1+kt)\le2^N$。利用 $N!\ge(N/e)^N\ge(N/3)^N$，S2 给出

$$R_\mathrm{TV}(B,n)\ge v\left(\frac{Nt}{12}\right)^N
\ge v\left[\frac{I_{m,d}}{12D_{m,d}8^{m+d}}
\min\{BN^{-s},1\}\right]^N.$$

再用 $v\ge1/2$ 即得 S1。这里每个常数仅依赖 $m,d$，没有把 $B$ 或 $n$ 隐藏在大 $O$ 常数中。

### 6. 与可实现上界合并：联合高温精确对数尺度

附录 C 给出沿用 HB 框架的预算上界：存在仅依赖 $m,d$ 的 $C,k_0$，对 $k+r=n$、$k\ge k_0$，令 $\delta=CBk^{-s}$，则

$$R_\mathrm{TV}(B,n)\le
\min\{1,e^{2\delta}-1\}(1-e^{-2\delta})^r.\tag{S9}$$

附录 C 还给出仅计算已知代理函数的任意精度提议实现。该实现保留原模型的连续随机输出，仅近似代理计算和接受概率。

#### 定理 S7（任意联合高温序列）

令 $n\to\infty$，$B_n>0$ 任意，且

$$a_n=B_n n^{-s}\to0.$$

则

$$\boxed{\lim_{n\to\infty}
\frac{-\log R_\mathrm{TV}(B_n,n)}{n\log(n^s/B_n)}=1.}\tag{S10}$$

**下界对应的 limsup。** 令 $q_n=\log(1/a_n)\to\infty$。最终 $B_n(n+1)^{-s}<1$，S1 给出

$$-\log R_\mathrm{TV}(B_n,n)
\le\log2+(n+1)\left[q_n+s\log(1+1/n)+\log(1/c_{m,d})\right].$$

除以 $nq_n$ 得 limsup 至多 $1$。S1 的严格正性保证对数在每个有限 $n$ 均有定义。

**上界对应的 liminf。** 取

$$k_n=\max\{k_0,\lceil n e^{-\sqrt{q_n}}\rceil\},\qquad r_n=n-k_n.$$

最终 $k_n<n$，且 $k_n/n\to0$。由于 $k_n\ge n e^{-\sqrt{q_n}}$，总有

$$\log(n/k_n)\le\sqrt{q_n},\qquad
2CB_n k_n^{-s}\le2C e^{-q_n+s\sqrt{q_n}}\to0.$$

无须额外假设 $B_n$ 为多项式，也不需要对 $k_n=k_0$ 的情况改变不等式。对于最终足够小的 $\delta$，S9 给出

$$R_\mathrm{TV}(B_n,n)\le2(2CB_n k_n^{-s})^{r_n+1}.$$

所以

$$\frac{-\log R_\mathrm{TV}(B_n,n)}{nq_n}
\ge\frac{r_n+1}{n}
\left[1-\frac{s}{\sqrt{q_n}}-\frac{\log(2C)}{q_n}\right]
-\frac{\log2}{nq_n}\to1.$$

两半合并即得 S10。

#### 推论 S8（固定幅度和多项式幅度）

对每个固定 $B>0$，

$$\lim_{n\to\infty}\frac{-\log R_\mathrm{TV}(B,n)}{n\log n}=\frac md.$$

更一般地，若 $\log B_n/\log n\to\beta<s$，则

$$\lim_{n\to\infty}\frac{-\log R_\mathrm{TV}(B_n,n)}{n\log n}=s-\beta.$$

这是精确对数尺度结论，**不表示**风险本身为常数倍的某个简单显式函数，也未识别 $O(n)$ 或更低阶对数项。

#### 推论 S9（固定预算、幅度趋零）

对每个固定 $d,m,n$，当 $B\downarrow0$ 时，

$$R_\mathrm{TV}(B,n)=\Theta_{m,d,n}(B^{n+1}).$$

下界为 S1。上界不需要代理逼近查询：直接取常数包络 $h\equiv B$，用均匀分布作提议，至多拒绝 $n$ 次，然后回退均匀分布。原函数查询数至多 $n$，且 $0\le h-f\le2B$。HB 的无条件混合式给出

$$R_\mathrm{TV}(B,n)\le
\min\{1,e^{2B}-1\}(1-e^{-2B})^n
\le2(2B)^{n+1}\quad(0<B\le1/4).$$

此处常数允许依赖固定的 $n$，故不能用它替代全 $B,n$ 一致界。它也说明 S10 中必须保留 $n\to\infty$；固定 $n$ 只令 $B\downarrow0$ 时的幂次是 $n+1$。

### 7. 已知归一化子类、预算与测度陷阱

1. **不与 HB Proposition 14 冲突。** 该命题额外知道 $L_f=0$，即 $Z_f=1$。本族的 $Z_{f_\theta}=1+t|\theta|$ 随未知输入变化；若将 $f_\theta$ 减去其未知 $\log Z_{f_\theta}$，一个位于 bump 外的点值查询就会泄露该常数，因而不再属于本文的一位 oracle 归约。
2. **不覆盖仅限期望查询数的算法。** 每个种子的深度上限是 S4 的关键；一般 rejection sampling 的随机停止时间没有统一有限上限。
3. **不假定种子有限。** 种子积分只与有限输入求和交换，使用的被积函数有界。没有复杂的极限换序问题。
4. **不按种子另选输入。** 最终困难输入针对混合后的 $Q_f$ 选取；这正是原 minimax 风险的量词顺序。
5. **不把非零证书称作全相图。** 对很大的 $a$，S2 的本有限族证书最多趋于 $v2^{-N}$；它不能代替大幅度区的常数风险下界。

### 8. 仍未完成的范围

本节完成所有有限 $B,n$ 的严格正下界、任意 $B_n n^{-s}\to0$ 序列的精确首阶对数渐近，以及固定预算的小幅度幂次。

原目标仍要求控制 $a=Bn^{-s}$ 不趋零的完整区间。HB 已有 $a\gtrsim_{m,d}1+\log n$ 时的常数 TV 下界。本节在 $a$ 为常数至 $\log n$ 的过渡带内仅提供指数级非零下界，未证明与最佳上界在所需尺度一致；也没有由本节推出完整 log-partition 风险。两项缺口均须保留，不得将本节的高温闭合当作原题完成。

### 9. 核验材料与归属

- `code/sampling_finite_certificate.py` 使用标准库有理数，检查有限差分恒等式、精确多项式 bump 积分及导数系数界，并穷举小 Boolean 立方体上的有界深度决策树函数，核对 parity 消去。
- `results/sampling_finite_certificate.json` 记录实际运行结果、参数和验证范围。有限运算是推导的独立算术检查，不替代上述任意维数、任意连续种子的证明。
- 主源：Holzmüller–Bach, *Convergence Rates for Non-Log-Concave Sampling and Log-Partition Estimation*, [arXiv:2303.03237v4](https://arxiv.org/html/2303.03237v4), Definitions 1–2、§2.2、Lemma 11、Theorems 12–13、Proposition 14。此版本编号不同于较早期刊 PDF。
- 决策树方法归属：Buhrman–Vereshchagin–de Wolf, [*On Computation and Communication with Small Bias*](https://ir.cwi.nl/pub/11750/11750D.pdf)，随机决策树接受概率的低次数表示。本文给出适配当前 oracle 的自足叶子证明。
- 相邻固定预算先例：Goyal–Sigman, [*On simulating a class of Bernstein polynomials*](https://doi.org/10.1145/2133390.2133396), 2012。其输入为未知偏置硬币，不能直接代替本文的连续函数值 oracle 嵌入。

现有历史代数检查点覆盖倒数差分闭式和正性。光滑扰动、有限查询归约、随机种子积分、极小极大量词和渐近拼接留作形式化任务。


\clearpage

# 附录 B：随机 log-partition 下界


### Status and scope

This appendix proves the randomized lower bounds for the exact-value log-partition problem. The sampling proofs appear in Appendices A, C, and D. The sharp log-partition transition outside the high-temperature regime remains open.

The construction uses classical information-based-complexity ideas: disjoint smooth perturbations, a finite prior, and conditioning on coordinates revealed by adaptive queries. These ideas are already part of the randomized integration literature discussed in Holzmüller–Bach, Section 2.2 and Appendix B.2. The claims below concern their quantitative application to the nonlinear log-partition functional.

Reference: D. Holzmüller and F. Bach, *Convergence Rates for Non-Log-Concave Sampling and Log-Partition Estimation*, JMLR 26(249), 2025; latest checked manuscript [arXiv:2303.03237v4](https://arxiv.org/html/2303.03237v4), 23 April 2026. Theorem numbers in this note refer to that arXiv version.

### 1. Model and main results

Fix integers \(d,m\geq1\). Let \(X=[0,1]^d\), and put

\[
 \mathcal F_{d,m,B}
 =\left\{f\in C^m(X):
       \max_{|\beta|_1\leq m}\|\partial^\beta f\|_\infty\leq B
   \right\},\qquad B>0.
\]

The order-zero term is included. Define

\[
 Z_f=\int_X e^{f(x)}\,dx,\qquad L_f=\log Z_f.
\]

An algorithm may use arbitrary internal randomness independent of \(f\), choose its query points adaptively, and output a real number. On every execution path it may request at most \(n\) exact point values of \(f\), where \(n\geq1\). Its risk is

\[
 R_L(d,m,B,n)
 =\inf_{\mathcal A}\sup_{f\in\mathcal F_{d,m,B}}
       \mathbb E\bigl|\mathcal A(f)-L_f\bigr|.
\]

No gradients, known normalizer, or average-query-budget relaxation is supplied.

For the explicit constants, define

\[
\begin{split}
 r&=m+1,\\
 K_{m,d}&=4^{rd}(2r)^m,\\
 I_{m,d}&=\left(\frac{4^r(r!)^2}{(2r+1)!}\right)^d,\\
 D_d&=2^{d+1},\\
 \alpha_{m,d}
   &=\frac{I_{m,d}}{K_{m,d}D_d^{m/d}},\\
 t&=Bn^{-m/d}.
\end{split} \tag{1}
\]

These constants are deliberately conservative; in particular \(0<\alpha_{m,d}\leq1\).

#### Theorem 1: explicit quadrature-regime lower bound

For every \(B>0,n\geq1\),

\[
 R_L(d,m,B,n)
 \geq
 \frac{1-\exp(-\alpha_{m,d}t)}
      {2\sqrt{6D_dn}}.
 \tag{2}
\]

Consequently, whenever \(0<t\leq1\),

\[
 R_L(d,m,B,n)
 \geq
 \frac{\alpha_{m,d}}{4\sqrt{6D_d}}\,
 Bn^{-m/d-1/2}.
 \tag{3}
\]

Together with Holzmüller–Bach v4, Theorem 9, this proves

\[
 R_L(d,m,B,n)
 =\Theta_{m,d}\!\left(Bn^{-m/d-1/2}\right)
 \quad\text{uniformly on }0<Bn^{-m/d}\leq1.
 \tag{4}
\]

The upper bound in this corollary is an existing result. Equation (4) is a restricted-regime conclusion, not the complete frozen target.

#### Theorem 2: a lower profile valid for all \(B,n\)

For every \(B>0,n\geq1\),

\[
 \boxed{\quad
 R_L(d,m,B,n)
 \geq
 \frac1{30000}
 \log\left(
       1+\frac{2\sinh(\alpha_{m,d}t/2)}{\sqrt{D_dn}}
     \right).
 \quad} \tag{5}
\]

In particular, the following uniform lower bound holds without a small-\(t\) restriction:

\[
 R_L(d,m,B,n)
 \geq
 \frac{\alpha_{m,d}}{60000\sqrt{D_d}}\,
 Bn^{-m/d-1/2}.
 \tag{6}
\]

A more informative finite-grid form of (5) is proved below. It also gives an exponential-in-\(t\) lower profile before the optimization regime. Different geometric constants inside exponential factors cannot be absorbed into multiplicative constants of the risk; therefore (5), together with the currently known upper bound, is **not** asserted to be a complete matching transition formula.

### 2. Explicit smooth perturbations

Let

\[
 \vartheta(u)=
 \begin{cases}
  [4u(1-u)]^r,&0\leq u\leq1,\\
  0,&u\notin[0,1],
 \end{cases}
 \qquad
 \psi(y)=\prod_{\ell=1}^d\vartheta(y_\ell).
 \tag{7}
\]

The extension \(\vartheta\) belongs to \(C^m(\mathbb R)\). Indeed, before extension it has a zero of order \(r=m+1\) at both endpoints, so all derivatives of order at most \(m\) vanish there. Thus \(\psi\in C^m(\mathbb R^d)\), it is positive on \((0,1)^d\), it vanishes outside \([0,1]^d\), and \(0\leq\psi\leq1\).

For \(0\leq j\leq m\), Leibniz's rule gives, on \([0,1]\),

\[
 \vartheta^{(j)}(u)
 =4^r\sum_{\ell=0}^j
     {j\choose\ell}(r)_\ell(r)_{j-\ell}
     (-1)^{j-\ell}
     u^{r-\ell}(1-u)^{r-j+\ell},
 \tag{8}
\]

where \((r)_s=r(r-1)\cdots(r-s+1)\). Every exponent in (8) is nonnegative, and \((r)_\ell(r)_{j-\ell}\leq r^j\). Hence

\[
 \|\vartheta^{(j)}\|_\infty\leq4^r(2r)^j,
 \qquad
 \|\partial^\beta\psi\|_\infty
 \leq4^{rd}(2r)^{|\beta|_1}
 \leq K_{m,d}
 \quad (|\beta|_1\leq m).
 \tag{9}
\]

The integral is explicit:

\[
 \int_{[0,1]^d}\psi(y)\,dy
 =\left(4^r\int_0^1u^r(1-u)^r\,du\right)^d
 =I_{m,d}.
 \tag{10}
\]

Choose

\[
 q=\left\lceil(2n)^{1/d}\right\rceil,\qquad
 M=q^d,\qquad
 a=\frac{B}{K_{m,d}q^m}.
 \tag{11}
\]

Index the \(M\) grid cells by \(j\in\{0,\ldots,q-1\}^d\), and write

\[
 \psi_j(x)=\psi(qx-j).
\]

Their interiors are disjoint. At common boundaries, all their derivatives of total order at most \(m\) vanish. Thus, for either \(v_j\in\{0,1\}\) or \(\sigma_j\in\{-1,1\}\),

\[
 f_v(x)=a\sum_{j=1}^M v_j\psi_j(x),
 \qquad
 f_\sigma(x)=a\sum_{j=1}^M \sigma_j\psi_j(x)
 \tag{12}
\]

belong to \(\mathcal F_{d,m,B}\). To see this, at an interior point only one term is nonzero, and

\[
 |\partial^\beta f(x)|
 \leq a q^{|\beta|_1}K_{m,d}
 \leq a q^mK_{m,d}=B.
\]

There is no factor \(M\) in this derivative bound.

The elementary grid bounds used later are

\[
 2n\leq M\leq D_dn,
 \qquad
 a\geq \frac{t}{K_{m,d}D_d^{m/d}},
 \qquad
 aI_{m,d}\geq\alpha_{m,d}t.
 \tag{13}
\]

For example, \(q\leq2(2n)^{1/d}\), which proves the upper bound on \(M\).

### 3. The adaptive finite-oracle reduction

We record explicitly why arbitrary adaptive queries do not invalidate the prior arguments.

Fix all internal randomness of an algorithm in advance. It is now a deterministic adaptive procedure. At a query point \(x\), one of the following happens:

1. All \(\psi_j(x)\) vanish. The answer is zero for every input in the finite family and reveals no coordinate.
2. Exactly one \(\psi_j(x)\) is positive. The answer is the known positive number \(a\psi_j(x)\) times the single coordinate \(v_j\) or \(\sigma_j\). It reveals that coordinate and no other coordinate.
3. The same coordinate has already been observed. No additional unknown coordinate is revealed.

The point \(x\) depends only on earlier answers and the fixed seed. Therefore the resulting procedure is a binary decision tree with at most \(n\) newly revealed coordinates along each path. A leaf is a cylinder set: all inputs agreeing on the revealed coordinates follow exactly the same path to that leaf.

Under a product prior on the coordinates, conditioning on such a leaf leaves every unrevealed coordinate independent with its original law. This statement includes adaptive choices and repeated queries. Queries on support boundaries carry no information and cause no exception.

Every prior lower bound obtained for every fixed seed also holds for randomized algorithms. More explicitly, for any finite prior \(\pi\),

\[
 \sup_f\mathbb E_\omega |\mathcal A_\omega(f)-L_f|
 \geq
 \sum_f\pi(f)\mathbb E_\omega|\mathcal A_\omega(f)-L_f|
 =
 \mathbb E_\omega\sum_f\pi(f)|\mathcal A_\omega(f)-L_f|.
 \tag{14}
\]

The bounds below apply to the final inner average for every seed. Thus no unproved minimax interchange is required.

### 4. Symmetric perturbations: proof of Theorem 1

Use the family \(f_\sigma\) with independent uniform signs. Put

\[
 A=\int_{[0,1]^d}\cosh(a\psi(y))\,dy,\qquad
 H=\int_{[0,1]^d}\sinh(a\psi(y))\,dy.
 \tag{15}
\]

Changing variables cell by cell gives the exact identity

\[
 Z_{f_\sigma}
 =\frac1M\sum_{j=1}^M\int e^{a\sigma_j\psi(y)}\,dy
 =A+\frac HM\sum_{j=1}^M\sigma_j.
 \tag{16}
\]

No expansion of the exponential or logarithm is used.

At a leaf, let \(r_0\leq n\) be the number of revealed signs, \(C\) their sum, and \(k=M-r_0\). The unobserved sum

\[
 S=\sum_{i=1}^k\varepsilon_i
\]

has independent uniform-sign summands. For \(b=H/M\), the unknown log-partition is

\[
 g(S)=\log(A+bC+bS).
\]

All its logarithm arguments lie in \([A-H,A+H]\), and \(A-H=\int e^{-a\psi}>0\).

For any proposed answer \(z\), symmetry of \(S\) gives

\[
\begin{split}
 \mathbb E|g(S)-z|
 &=\frac12\mathbb E\bigl(|g(S)-z|+|g(-S)-z|\bigr)\\
 &\geq\frac12\mathbb E|g(S)-g(-S)|\\
 &\geq\frac{b}{A+H}\,\mathbb E|S|.
\end{split} \tag{17}
\]

The last inequality follows by integrating the derivative \(1/u\), which is at least \(1/(A+H)\) throughout the interval between the two arguments.

The sign sum has moments

\[
 \mathbb ES^2=k,\qquad \mathbb ES^4=3k^2-2k.
\]

Hölder's inequality, in the form

\[
 \mathbb ES^2
 \leq(\mathbb E|S|)^{2/3}(\mathbb ES^4)^{1/3},
\]

therefore implies

\[
 \mathbb E|S|
 \geq\frac{k^{3/2}}{\sqrt{3k^2-2k}}
 \geq\sqrt{k/3}.
 \tag{18}
\]

Since \(k\geq M-n\), (17), (18), and (14) prove the finite-grid bound

\[
 R_L(d,m,B,n)
 \geq
 \frac{H}{A+H}\,
 \frac{\sqrt{M-n}}{\sqrt3\,M}.
 \tag{19}
\]

To simplify it, note that \(A-H=\int e^{-a\psi}\leq1\), while Jensen's inequality gives \(A+H=\int e^{a\psi}\geq e^{aI_{m,d}}\). Consequently,

\[
 \frac H{A+H}
 =\frac12\left(1-\frac{A-H}{A+H}\right)
 \geq\frac12(1-e^{-aI_{m,d}}).
\]

Using \(M-n\geq M/2\) and (13) yields (2). If \(0<t\leq1\), then \(0<\alpha_{m,d}t\leq1\), and \(1-e^{-u}\geq u/2\) on this interval proves (3).

Finally, Holzmüller–Bach v4, Theorem 9, supplies

\[
 R_L\leq C_1\min\{t,e^{C_2t}t/\sqrt n\},
 \tag{20}
\]

where \(C_1,C_2\) depend only on \(m,d\). On \(t\leq1\), its second term is at most \(C_1e^{C_2}t/\sqrt n\). This proves (4).

### 5. Nonnegative perturbations and a finite Bernoulli problem

For the family \(f_v\), define

\[
 \eta=\int_{[0,1]^d}(e^{a\psi(y)}-1)\,dy>0,
 \qquad w=\eta/M.
 \tag{21}
\]

The cellwise computation is again exact:

\[
 Z_{f_v}=1+w\sum_{j=1}^Mv_j,
 \qquad
 L_{f_v}=\log\left(1+w\sum_{j=1}^Mv_j\right).
 \tag{22}
\]

The following finite result is the main quantitative ingredient for all parameters.

#### Lemma 3: finite Bernoulli normalizer lower bound

Suppose \(M\geq2n\), \(M\geq2\), and \(\eta>0\). An algorithm observes at most \(n\) coordinates of \(v\in\{0,1\}^M\), possibly adaptively and randomly, and estimates

\[
 T(v)=\log\left(1+\frac\eta M\sum_{j=1}^Mv_j\right).
\]

Then its worst-case expected absolute error is at least

\[
 \frac1{30000}
 \log\left(1+\frac{\eta}{\sqrt{M(1+\eta)}}\right).
 \tag{23}
\]

The argument supplies a product prior for \(0<\eta\leq M\), and a sparse mixture prior for \(\eta>M\).

#### Proof for \(0<\eta\leq M\)

Set

\[
 p=\min\{1/2,1/\eta\},\qquad
 \lambda=Mp,\qquad w=\eta/M.
 \tag{24}
\]

These choices ensure

\[
 p\leq1/2,\qquad \lambda\geq1,\qquad w\lambda=\eta p\leq1.
 \tag{25}
\]

Use independent Bernoulli-\(p\) coordinates. Fix the algorithm's seed. Let \(R\) denote the number of revealed coordinates equal to one. The number of newly revealed coordinates may depend on the answers, but at each new reveal its conditional expected value is \(p\). Therefore

\[
 \mathbb ER=p\,\mathbb E[\text{number of new reveals}]
 \leq np\leq\lambda/2.
\]

This identity also follows by summing the conditional expectations of the at most \(n\) first-reveal indicators; it does not assume a nonadaptive design. Markov's inequality gives

\[
 \mathbb P(R\leq2\lambda)\geq3/4.
 \tag{26}
\]

Condition on a leaf in the event \(R\leq2\lambda\). If \(k\) coordinates remain, then \(M/2\leq k\leq M\), and their sum has law

\[
 S\sim\operatorname{Bin}(k,p).
\]

Let \(S'\) be an independent copy under this conditional law, and put

\[
 v=kp(1-p),\qquad D=S-S'.
\]

We have \(\lambda/4\leq v\leq\lambda\), and direct moment expansion gives

\[
 \mathbb ED^2=2v,\qquad
 \mathbb ED^4
 =12v^2+2v(1-6p(1-p))
 \leq12v^2+2v
 \leq20v^2.
 \tag{27}
\]

The final inequality uses \(v\geq\lambda/4\geq1/4\).

For completeness, the elementary second-moment inequality for a nonnegative \(Y\) is

\[
 \mathbb P(Y\geq\theta\mathbb EY)
 \geq
 (1-\theta)^2\frac{(\mathbb EY)^2}{\mathbb EY^2},
 \qquad 0<\theta<1.
 \tag{28}
\]

It follows by applying Cauchy–Schwarz to
\(\mathbb E[Y\mathbf1_{\{Y\geq\theta\mathbb EY\}}]\).
Applying (28) to \(Y=D^2\) and \(\theta=1/2\), (27) gives

\[
 \mathbb P(|D|\geq\sqrt v)\geq1/20.
\]

Also, \(\mathbb E(S+S')=2kp\leq2\lambda\), so

\[
 \mathbb P(S+S'>80\lambda)\leq1/40.
\]

It follows that, with conditional probability at least \(1/40\),

\[
 |D|\geq\sqrt\lambda/2,\qquad
 S+S'\leq80\lambda.
 \tag{29}
\]

Write \(g(s)=\log(1+w(R+s))\). On the event (29),

\[
\begin{split}
 |g(S)-g(S')|
 &\geq
 \frac{w|S-S'|}
      {1+w(R+\max\{S,S'\})}\\
 &\geq
 \frac{w\sqrt\lambda}
      {2(1+82w\lambda)}.
\end{split} \tag{30}
\]

Here the denominator is controlled on a constant-probability event, rather than by the very pessimistic bound \(1+wM\).

For any leaf answer \(z\), the triangle inequality gives

\[
 \mathbb E|g(S)-z|
 \geq\frac12\mathbb E|g(S)-g(S')|
 \geq
 \frac{w\sqrt\lambda}{160(1+82w\lambda)}.
 \tag{31}
\]

Averaging over good leaves using (26), and using nonnegativity of the error on all other leaves, yields

\[
 \mathbb E|\widehat T-T(v)|
 \geq
 \frac{3w\sqrt\lambda}{640(1+82w\lambda)}
 \geq\frac{w\sqrt\lambda}{20000}.
 \tag{32}
\]

The last numerical step is valid because \(w\lambda\leq1\) and
\(3/(640\cdot83)=3/53120\geq1/20000\).

Now

\[
 w\sqrt\lambda=\frac{\eta\sqrt p}{\sqrt M}
 \geq\frac1{\sqrt2}\frac{\eta}{\sqrt{M(1+\eta)}}.
 \tag{33}
\]

For \(\eta\leq2\), this follows from \(p=1/2\); for \(\eta\geq2\), use \(p=1/\eta\). Since \(1/(20000\sqrt2)\geq1/30000\) and \(\log(1+u)\leq u\), (32) proves (23) when \(\eta\leq M\). The seed averaging is justified by (14).

#### Proof for \(\eta>M\)

Use a prior with probability \(1/2\) on the all-zero vector and probability \(1/(2M)\) on each of the \(M\) vectors with exactly one nonzero coordinate.

Fix the seed, and follow the all-zero transcript. It reveals a set \(J\) of at most \(n\) coordinates. For every \(j\notin J\), the vector with its only one at \(j\) has the same complete transcript and the same answer \(z\). Its target value is

\[
 \ell=\log(1+\eta/M),
\]

whereas the all-zero target is zero. The prior-average error is consequently at least

\[
 \frac12|z|
 +\frac{M-|J|}{2M}|z-\ell|
 \geq
 \frac{M-|J|}{2M}\ell
 \geq\frac14\log(1+\eta/M).
 \tag{34}
\]

The argument does not assume that \(z\) is nonnegative.

If \(\eta/M>1\), then

\[
 \frac{\eta}{\sqrt{M(1+\eta)}}
 \leq\sqrt{\eta/M}\leq\eta/M.
\]

Thus (34) is stronger than (23). This finishes the proof of Lemma 3.

### 6. Consequences for smooth log-partition estimation

The finite-oracle reduction in Section 3 and the exact identity (22) allow Lemma 3 to be applied without further approximation. We obtain

\[
 R_L(d,m,B,n)
 \geq
 \frac1{30000}
 \log\left(1+\frac{\eta}{\sqrt{M(1+\eta)}}\right),
 \qquad
 \eta=\int(e^{a\psi}-1).
 \tag{35}
\]

The function \(u\mapsto u/\sqrt{1+u}\) is increasing on \([0,\infty)\). Jensen's inequality gives

\[
 \eta\geq e^{aI_{m,d}}-1,
 \qquad
 \frac{\eta}{\sqrt{1+\eta}}
 \geq e^{aI_{m,d}/2}-e^{-aI_{m,d}/2}
 =2\sinh(aI_{m,d}/2).
\]

Combining this with (13) proves Theorem 2, equation (5).

To prove (6), put \(s=\alpha_{m,d}t/2\) and \(r_0=\sqrt{D_dn}\geq1\). First,

\[
 2\sinh s=e^s-e^{-s}\geq e^s-1.
\]

Second, if \(U\) is Bernoulli with success probability \(1/r_0\), Jensen's inequality implies

\[
 \log\left(1+\frac{e^s-1}{r_0}\right)
 =\log\mathbb Ee^{sU}
 \geq s\mathbb EU
 =s/r_0.
 \tag{36}
\]

Equations (5) and (36) give the claimed all-\(B,n\) integration-rate lower bound.

#### An explicit optimization-regime corollary

For example, if

\[
 t\geq\frac4{\alpha_{m,d}}
             \log\bigl(2\sqrt{D_dn}\bigr),
 \tag{37}
\]

then (5) yields

\[
 R_L(d,m,B,n)\geq\frac{\alpha_{m,d}}{120000}\,t.
 \tag{38}
\]

Indeed, \(s=\alpha_{m,d}t/2\geq2\log(2r_0)\); therefore
\(2\sinh s\geq e^s/2\), and

\[
 \log(1+2\sinh s/r_0)
 \geq s-\log(2r_0)\geq s/2.
\]

Together with the existing deterministic approximation upper bound \(O_{m,d}(t)\), this matches the optimization order in the indicated regime. This corollary is included for explicit parameter bookkeeping; the existence of an optimization regime was already established by Holzmüller–Bach.

### 7. What remains unresolved

The proved statements should be separated carefully:

- Equations (2)–(4) supply a complete randomized lower proof and matching order on \(0<t\leq1\).
- Equations (5), (6), and (35) supply lower bounds valid for every \(B,n\), including a nontrivial growing transition profile.
- The upper bound (20) is prior work.
- The lower and upper formulas have different constants in their exponential dependence on \(t\). For a sequence such as \(t=c\log n\), such constants can change powers of \(n\). They cannot be dismissed as harmless multiplicative constants.
- No conclusion about unconditional-output TV minimax risk is obtained merely by applying this estimation lower bound. Sampling has a different loss and allows cancellation when internal randomness is mixed.
- In particular, the one-query exact-sampling phenomenon with a known normalizer in Holzmüller–Bach Proposition 14 does not contradict the present estimation result, and it precludes a careless transfer of its proof to sampling.
- The frozen all-parameter two-risk target is therefore still open within this work.

A matching transition description at the stated precision remains open. The independent exact-value TV results are proved in Appendices A, C and D.

### 8. Reproducible finite checks

The accompanying program, code/log_partition_lower_check.py, checks the elementary moment identities and the quantitative finite Bernoulli bound on a deterministic grid of finite cases. It evaluates the exact finite Bayes-risk formula numerically in IEEE double by summing binomial probabilities and choosing a conditional median for the target; only the moment checks use exact rational arithmetic. For the exchangeable product prior, observing fresh coordinates is optimal: extra information can be ignored, repeated queries supply no information, and all unseen coordinates have the same conditional law. Thus the calculation is a useful independent check on the numerical constants in the finite reduction, without a numerical-certification claim.

These finite computations do not establish the smooth theorem or replace the arbitrary-adaptive-algorithm proof above. Their output is recorded in results/log_partition_lower_checks.json. No Lean formalization is asserted for this note.

### References

1. D. Holzmüller and F. Bach. *Convergence Rates for Non-Log-Concave Sampling and Log-Partition Estimation*. JMLR 26(249):1–72, 2025. [Latest checked v4](https://arxiv.org/html/2303.03237v4). Relevant locations: Section 2.2, Theorems 8–9, Proposition 10, and Appendix B.2; sampling distinction in Proposition 14.
2. E. Novak. *Deterministic and Stochastic Error Bounds in Numerical Analysis*. Lecture Notes in Mathematics 1349, Springer, 1988. Used here as attribution for the classical randomized-integration setting, as explicitly discussed by source 1; the present proof is self-contained and does not require an unverified theorem from this book.



\clearpage

# 附录 C：上界算法、预算与代理计算


本附录给出逼近—拒绝采样框架的预算接口，来自 Holzmüller–Bach arXiv:2303.03237v4，引理 11、定理 12。其上界与附录 A 的下界在联合高温极限下匹配。

### 1. 只用函数值的确定性逼近

记 $s=m/d$。存在仅依赖 $m,d$ 的常数 $C\ge1$ 及整数 $k_0$，使每个 $k\ge k_0$ 都有至多 $k$ 次点值查询的显式分片多项式 $g$，满足

$$\|f-g\|_\infty\le\delta_k:=CBk^{-s}.$$

一种具体构造如下。在每一轴分成 $q$ 等长小区间；每个小立方体采用每轴 $m$ 个不同内节点的张量积 Lagrange 插值。总查询数不超过 $(mq)^d$。一维 $m$ 阶插值余项由 $m$ 阶导数界给出 $C_m Bq^{-m}$；逐轴插值的误差用望远镜展开及各一维插值算子的有限 Lebesgue 常数控制，得到 $C_{m,d}Bq^{-m}$。这里每个余项只需要某一坐标的 $m$ 阶纯导数，而该导数已在原假设中；无需偷加总阶数 $md$ 的混合导数。取 $q=\lfloor k^{1/d}/m\rfloor$，并令 $k_0=(2m)^d$，便有 $q\ge k^{1/d}/(2m)$。小于 $k_0$ 的预算用平凡界单独处理。

插值节点、分片和多项式系数均由有限个已知查询值确定。分片间可能不连续，不妨碍积分与拒绝采样；分片边界按固定约定分配。

### 2. 任意查询预算分配

令 $k+r=n$，$k\ge k_0$，$r\ge0$，并令 $h=g+\delta_k$。于是

$$0\le h-f\le2\delta_k,\qquad p:=Z_f/Z_h\ge e^{-2\delta_k}.$$

以 $P_h$ 为提议分布，至多进行 $r$ 次拒绝采样，每次仅查询一次 $f$；若全部拒绝，再独立输出一个 $P_h$ 样本。总原函数查询数每条路径至多 $k+r=n$。提议分布只由前 $k$ 次已知数据形成。

对任意可测事件 $E$，一次提议且接受的联合概率是 $pP_f(E)$。独立重复并在全拒绝时回退给出精确无条件输出分布

$$Q_{k,r}=(1-(1-p)^r)P_f+(1-p)^rP_h.$$

因此直接在无条件分布层面有

$$\operatorname{TV}(Q_{k,r},P_f)=(1-p)^r\operatorname{TV}(P_h,P_f)
\le \min\{1,e^{2\delta_k}-1\}(1-e^{-2\delta_k})^r.\tag{U1}$$

当 $0<\delta_k\le1/4$ 时，利用 $1-e^{-2\delta_k}\le2\delta_k$ 及 $e^{2\delta_k}-1\le4\delta_k$，可简化为

$$R_\mathrm{TV}(B,n)\le 2(2CBk^{-s})^{n-k+1}.\tag{U2}$$

这两个上界是已有拒绝采样混合式和标准插值误差的直接预算化结果，不作为新算法贡献。

### 3. 提议抽样不是额外的未知 oracle

上面的理想表达出现 $P_h$，但不需要新的 $f$ 查询就可任意精度实现它。由 $\|f\|_\infty\le B$ 及 $\|g-f\|_\infty\le\delta_k$ 可知

$$-B\le h\le B+2\delta_k.$$

对均匀提议使用上包络 $H=B+2\delta_k$，接受条件为 $u\le\exp(h(x)-H)$。一次接受概率至少 $\exp(-2B-2\delta_k)$。最多尝试 $M$ 次，全部失败时回退均匀分布，则其输出 $\widetilde P_h$ 满足

$$\operatorname{TV}(\widetilde P_h,P_h)\le\exp\{-M e^{-2B-2\delta_k}\}.$$

取误差容差 $0<\eta<1$，以及整数 $M\ge e^{2B+2\delta_k}\log((r+1)/\eta)$，使每个提议样本的 TV 误差至多 $\eta/(r+1)$。最大耦合与数据处理不等式保证，整个至多 $r+1$ 次提议的算法输出误差增加至多 $\eta$。所有额外计算只计算已知分片多项式，没有调用原函数。对任意小的 $\eta>0$ 都有有限的这种算法，故取 infimum 得到 (U1)，不声称该 infimum 必定由一个有限运行时间算法恰好达到。

这是信息复杂度模型中的可实现性说明：输出保留模型允许的精确连续随机点，查询值是精确实数。若只将已知代理函数的接受概率作数值逼近，可在同一连续候选点上使用一致误差界，并把有限次判定的额外误差加入 $\eta$；这不增加原函数查询。这里不承诺用有限位坐标输出达到连续目标的 TV 保证：离散输出的 law 与连续目标互相奇异。本文也没有宣称运行时间对 $B$ 或 $m,d$ 有一致的低次多项式界。

类似地，$Z_g$ 可由已知分片多项式的确定性细网格积分任意精度近似；$Z_g\ge e^{-B-\delta_k}$ 允许把绝对积分容差转换为 log 容差。用于 log-partition 上界的有限个 $P_g$ 提议亦可按上述方式逼近。将估计量截断到 $[-B,B]$ 后，提议 law 的 TV 误差只增加可控的有界期望损失。故已有重要性积分上界无需额外未知的 $f$ 积分或抽样 oracle。

### 4. 联合高温极限的上界半边

令 $n\to\infty$，允许 $B=B_n>0$ 随 $n$ 变化，并假设

$$a_n=B_n n^{-s}\longrightarrow0,\qquad q_n=\log(1/a_n)\longrightarrow\infty.$$

取

$$k_n=\max\{k_0,\lceil n e^{-\sqrt{q_n}}\rceil\}.$$

当 $n$ 足够大时 $k_n<n$，且 $k_n/n\to0$。同时 $k_n\ge n e^{-\sqrt{q_n}}$，从而

$$\log\frac1{2CB_n k_n^{-s}}
=q_n-s\log(n/k_n)-\log(2C)
\ge q_n-s\sqrt{q_n}-\log(2C).$$

右侧趋于正无穷，故最终可用 (U2)。于是

$$\liminf_{n\to\infty}\frac{-\log R_\mathrm{TV}(B_n,n)}{n\log(n^s/B_n)}\ge1.\tag{U3}$$

附录 A 的 (S1) 给对应的 $\limsup\le1$，与 (U3) 合并得联合极限 (S10)。固定预算的小幅度幂次另见附录 A。

### 5. 仍未解决的原题范围

当前上界接口没有闭合 $a=Bn^{-s}$ 处于常数至 $\log n$ 之间的最优误差。查询模型中允许对已知代理函数做昂贵计算，不代表获得了固定次多项式运行时间。二者都不得从本节推断。


\clearpage

# 附录 D：有限事件的精确线性规划


本附录刻画精确点值模型的有限族上单个固定事件的可实现概率，并推出整个输出分布的 TV 风险下界。

超几何核、Bernstein 升阶、有界概率系数及线性规划对偶的先例列在本附录第 8 节。

### 1. 有限总体模型与精确可实现集合

固定整数 $0\le n<M$。未知输入为 $\theta\in\{0,1\}^M$；一次查询可以读取一个坐标 $\theta_i$。允许自适应选择坐标、重复查询及任意辅助随机性，但每路径至多查询 $n$ 次。算法输出一个事件指示变量 $Y\in\{0,1\}$，其无条件接受概率记为 $q(\theta)$。

取任意只依赖 Hamming 重量的目标 $g:\{0,\ldots,M\}\to[0,1]$，定义

$$\mathcal E_{M,n}(g)=\inf_{\mathcal A}\max_{\theta\in\{0,1\}^M}|q_{\mathcal A}(\theta)-g(|\theta|)|.$$

约定非法下标的二项式系数为零，令

$$H_{k,j}=\frac{\binom{k}{j}\binom{M-k}{n-j}}{\binom{M}{n}},\qquad
0\le k\le M,\quad 0\le j\le n.\tag{F1}$$

每行之和为 $1$；这是从大小为 $M$、含 $k$ 个正位的总体中无放回均匀抽取 $n$ 个坐标后，观测到 $j$ 个正位的概率。

#### 定理 F1（硬预算下的完整对称事件概率集合）

对任意合法算法，按输入重量平均的概率

$$\bar q(k)=\binom{M}{k}^{-1}\sum_{|\theta|=k}q(\theta)$$

均具有表示

$$\boxed{\bar q(k)=\sum_{j=0}^nH_{k,j}a_j,\qquad 0\le a_j\le1.}\tag{F2}$$

反之，每个 $a\in[0,1]^{n+1}$ 都由一个至多 $n$ 次查询、接受概率本身只依赖 $|\theta|$ 的算法实现。因此

$$\boxed{\mathcal E_{M,n}(g)=\min_{a\in[0,1]^{n+1}}\|Ha-g\|_\infty.}\tag{F3}$$

**证明：必要性。** 固定全部辅助随机种子。删去重复读取已知位的查询；这不会改变输出，也不增加读取新位的数量。对每个提前终止分支，用尚未读过的坐标补足至恰好 $n$ 个新位，忽略补读结果。由于 $M>n$，始终有足够坐标。补读仅是等价有限树的构造，不允许原算法额外使用这些值改变已决定的输出。

现在每个固定种子诱导一棵深度恰为 $n$、每路径坐标互异的二叉树。设依次观测的位串为 $x=(x_1,\ldots,x_n)$。在重量为 $k$ 的输入均匀先验下，给定前 $\ell$ 个观测，尚未读取的坐标在剩余位数约束下仍可交换；查询索引由已读信息决定，不能偏向未知值。因此，若 $|x|=j$，该完整观测串的概率为

$$\frac{(k)_{\underline j}(M-k)_{\underline{n-j}}}{(M)_{\underline n}},\tag{F4}$$

其中下划线表示下降阶乘；不可行的位串概率为零。该值与观测顺序、索引选择和固定种子均无关。它可以直接由逐次条件概率相乘得到，也可以计数：每条路径固定 $n$ 个不同坐标及其值，完成该路径的重量 $k$ 输入数恰为 $\binom{M-n}{k-j}$。

对该种子，令 $b(x)\in\{0,1\}$ 为位串 $x$ 所在叶的输出，并令

$$a_j(\omega)=\binom nj^{-1}\sum_{|x|=j}b_\omega(x)\in[0,1].$$

把 (F4) 按 $j$ 分组，利用

$$\binom nj\frac{(k)_{\underline j}(M-k)_{\underline{n-j}}}{(M)_{\underline n}}=H_{k,j},$$

得到固定种子的平均接受概率为 $Ha(\omega)$。再对原种子分布积分，取 $a_j=\mathbb E a_j(\omega)$ 即得 (F2)。这里只交换有限和与有界可测函数的积分，所以连续随机种子、无限随机带以及随机化自适应查询均包含在证明内。困难输入没有依赖实际种子来选择。

**证明：充分性与 minimax。** 均匀抽取大小为 $n$ 的坐标集合并查询，记正位数为 $J$，随后用一个独立均匀变量以概率 $a_J$ 输出 $1$。其接受概率恰为 $Ha$。对任意原算法，有限排列群平均也给出一个合法算法，且其概率正是 $\bar q(|\theta|)$。由于目标只依赖重量，

$$|\bar q(k)-g(k)|\le\max_{|\theta|=k}|q(\theta)-g(k)|.$$

故对称化不会增大最坏风险，而全部对称化概率恰由 (F2) 给出。立方体紧、目标连续，最小值取得，(F3) 成立。证毕。

**解释边界。** (F2) 比“次数至多 $n$ 的多项式”更强，因为保留了 $a_j\in[0,1]$。但它是经典 Bernstein 有界系数结构在有限总体无放回模型中的直接版本，不主张发明了这种结构。充分性算法只模拟一个事件，并不自动构造任何指定的完整连续分布。

### 2. 精确原始问题、对偶及证书

给定 $g$，(F3) 是变量 $(a_0,\ldots,a_n,\varepsilon)$ 的线性规划：

$$\begin{aligned}
\text{最小化 }&\varepsilon,\\
\text{满足 }&-\varepsilon\le\sum_jH_{k,j}a_j-g(k)\le\varepsilon\quad(0\le k\le M),\\
&0\le a_j\le1\quad(0\le j\le n),\qquad \varepsilon\ge0.
\end{aligned}\tag{F5}$$

#### 定理 F2（可独立核验的对偶）

令 $x_+=\max(x,0)$。有

$$\boxed{\mathcal E_{M,n}(g)=
\max_{\|y\|_1\le1}\left\{\sum_{k=0}^Mg(k)y_k-
\sum_{j=0}^n\left(\sum_{k=0}^MH_{k,j}y_k\right)_+\right\}.}\tag{F6}$$

**证明。** 对任何原始可行 $a$ 及 $\|y\|_1\le1$，

$$\begin{aligned}
\|Ha-g\|_\infty
&\ge y^T(g-Ha)\\
&\ge y^Tg-\sum_j((H^Ty)_j)_+.
\end{aligned}$$

最后一步只用了 $0\le a_j\le1$。这已证明任何给定对偶向量都是严格下界证书。另一方面，有限维无穷范数对偶给出

$$\|Ha-g\|_\infty=\max_{\|y\|_1\le1}y^T(g-Ha).$$

两个可行集合均为紧凸多面体，目标是双线性的。有限线性规划强对偶（亦可用紧凸集合上的 minimax 定理）允许交换 min 与 max。对固定 $y$，$\max_{a\in[0,1]^{n+1}}y^THa=\sum_j((H^Ty)_j)_+$，得到 (F6)。证毕。

实际证书不需要信任浮点求解器的最优性标志。给出有理数 $a,\varepsilon,y$，逐项检查原始约束、$\|y\|_1\le1$ 及两边目标值相等，即可精确认证。对于有理 $g$，原始 LP 系数全为有理数，存在有理最优解。浮点解只用于猜测活跃约束，不承担证明任务。

下面专取

$$g_t(k)=\frac{v}{1+tk},\qquad 0<v\le1,\quad t>0,$$

并简写 $E_{M,n}(t,v)=\mathcal E_{M,n}(g_t)$。对有理 $t,v$，该有限问题允许完整有理证书。对实际 bump 积分给出的实数 $t$，定理本身仍精确成立；有理数示例不能擅自替代该实参数。必要时，利用 $|E(g)-E(\tilde g)|\le\|g-\tilde g\|_\infty$ 转移经过认证的目标误差区间。

### 3. 大振幅极限与非负约束的作用

#### 定理 F3（固定有限总体的大 $t$ 精确极限）

对固定整数 $0\le n<M$ 及固定 $0<v\le1$，

$$\boxed{\lim_{t\to\infty}E_{M,n}(t,v)=
\frac{v(M-n)}{2M-n}.}\tag{F7}$$

此外对每个有限 $t>0$ 都有

$$\boxed{E_{M,n}(t,v)\ge
\left[\frac{v((M-n)t-n)}{(2M-n)(1+t)}\right]_+.}\tag{F8}$$

**证明。** 写 $r=(M-n)/M$，并令 $g_\infty=(v,0,\ldots,0)$。超几何核前两行满足

$$H_{0,0}=1,\qquad H_{1,0}=r,\qquad H_{1,1}=1-r,$$

其他项为零（当 $n=0$ 时第二个非零列不存在，$1-r=0$）。如果 $\|Ha-g_\infty\|_\infty\le\varepsilon$，则 $a_0\ge v-\varepsilon$，且由于所有 $a_j\ge0$，

$$\varepsilon\ge(Ha)_1\ge r a_0\ge r(v-\varepsilon).$$

从而 $\varepsilon\ge vr/(1+r)$。

取 $a_0=v/(1+r)$，$a_j=0$（$j\ge1$）。在 $k=0$ 的误差恰为 $vr/(1+r)$。在 $k\ge1$，

$$H_{k,0}=\binom{M-k}{n}/\binom Mn\le H_{1,0}=r,$$

因此误差也不超过 $vr/(1+r)$。于是 $\mathcal E_{M,n}(g_\infty)=vr/(1+r)$。

该等式还有显式对偶证书：取

$$y_0=\frac{r}{1+r},\qquad y_1=-\frac1{1+r},\qquad y_k=0\ (k\ge2).\tag{F9}$$

其 $\ell^1$ 范数为 $1$；$(H^Ty)_0=0$，其他分量均非正，所以 (F6) 中正部惩罚为零。将 $g_t$ 代入此证书，即得 (F8)；再与平凡下界零取最大值。

最后，任意两个目标都满足距离函数的 $1$-Lipschitz 性：

$$|\mathcal E_{M,n}(g)-\mathcal E_{M,n}(\tilde g)|\le\|g-\tilde g\|_\infty.$$

由于 $\|g_t-g_\infty\|_\infty=v/(1+t)$，得到 (F7)，以及一个对所有 $M,n$ 一样有效的绝对误差控制

$$\left|E_{M,n}(t,v)-\frac{v(M-n)}{2M-n}\right|\le\frac{v}{1+t}.\tag{F10}$$

精确极限陈述先固定 $M,n,v$。若这些量共同变化，必须另行使用 (F8) 或 (F10)，不能将逐点极限当作未经证明的相对渐近。证毕。

当 $M\ge2n$ 时，极限至少是 $v/3$。若再有 $t\ge3$，(F8) 已给出 $E_{M,n}(t,v)\ge v/6$。这显著区别于第一轮 $M=n+1$ 的单个最高阶 parity 证书；后者在 $t\to\infty$ 时仅趋于 $v/2^{n+1}$。

这种比较还可在同一个总体 $M=n+1$ 上做：完整有限事件极限是 $v/(n+2)$，而 parity 极限是 $v/2^{n+1}$。因此指数天花板确实是丢弃概率非负约束造成的方法损失，不是该有限事件问题的真实性质。

### 4. 回到原光滑 Gibbs 问题

使用第一轮引理 S3 的同一个显式 $C^m$ bump $\psi$ 和常数

$$D=2^{d(m+1)}[2(m+1)]^m,\qquad
I=\int_{[-1,1]^d}\psi(u)du
=\left(\frac{2^{2m+3}((m+1)!)^2}{(2m+3)!}\right)^d.$$

这里允许任意整数 $M>n$。设 $L=\lceil M^{1/d}\rceil$，$\rho=(4L)^{-1}$，选取 $M$ 个不同网格单元的中心 $z_i$，并取 $0<a\le B\rho^m/D$。定义

$$f_\theta(x)=a\sum_{i=1}^M\theta_i\psi((x-z_i)/\rho),$$

$$t=\rho^d\int_{[-1,1]^d}(e^{a\psi(u)}-1)du,\qquad
v=1-M(2\rho)^d\ge\frac12.$$

仍有 $f_\theta\in\mathcal F_{d,m,B}$。同一个固定可测事件

$$A=[0,1]^d\setminus\bigcup_{i=1}^M\bigl(z_i+\rho(-1,1)^d\bigr)$$

满足 $Z_{f_\theta}=1+t|\theta|$ 及 $P_{f_\theta}(A)=v/(1+t|\theta|)$。

#### 定理 F4（完整有限事件对偶向原风险转移）

对上述任意 $M>n$ 和合法振幅 $a$，

$$\boxed{R_\mathrm{TV}(B,n)\ge E_{M,n}(t,v).}\tag{F11}$$

特别地，任意 (F6) 的可行对偶向量都给出原问题的严格下界。可以对全部合法 $M,a$ 取上确界。

**证明。** 给定任意原连续点值算法，构造一个读取 $\theta$ 的模拟器：当该算法查询 $x$ 时，若 $x$ 在所有 bump 正集之外，直接返回 $0$；若位于第 $i$ 个正集，则读取 $\theta_i$ 并返回已知数 $a\psi((x-z_i)/\rho)\theta_i$。支撑互不相交，所以一次函数值查询至多读取一个位；已读坐标可以缓存。每路径的 bit 查询数仍至多 $n$。最终输出 $\boldsymbol1\{X\in A\}$，其无条件接受概率恰为原 $Q_{f_\theta}(A)$。

定理 F1 因而给出

$$\max_\theta|Q_{f_\theta}(A)-P_{f_\theta}(A)|\ge E_{M,n}(t,v).$$

每一项不超过对应的完整 TV 误差；有限族又包含于原光滑球。对原算法取下确界即得结论。证明没有引入关于未知归一化子的查询，没有交换条件 TV 与无条件 TV，也没有将一个可实现的事件模拟器当作完整采样器。证毕。

#### 参数量级必须恢复体积因子

取满振幅 $a=B\rho^m/D$，写 $s=m/d$。由

$$8^{-d}M^{-1}\le\rho^d\le4^{-d}M^{-1},\qquad
a\ge\frac{BM^{-s}}{D8^m},$$

及 Jensen 不等式，有

$$\boxed{t\ge\frac{4^{-d}}M\left(\exp\left\{\kappa BM^{-s}\right\}-1\right),\qquad
\kappa=\frac{I}{2^dD8^m}.}\tag{F12}$$

这里使用了 $[-1,1]^d$ 的体积是 $2^d$：

$$\int(e^{a\psi}-1)\ge2^d(e^{aI/2^d}-1).$$

另一方面，$0\le\psi\le1$ 给出

$$t\le\frac{2^{-d}}M\left(\exp\left\{\frac{BM^{-s}}{D4^m}\right\}-1\right).\tag{F13}$$

因此不能把 $t$ 当作没有体积惩罚的 $e^a$。例如，令 $M=2n$。若

$$B\ge\kappa^{-1}(2n)^s\log(1+3\cdot4^d\cdot2n),\tag{F14}$$

则 $t\ge3$，于是 (F8)、(F11) 及 $v\ge1/2$ 给出 $R_\mathrm{TV}(B,n)\ge1/12$。这重新得到 $Bn^{-s}$ 为 $\log n$ 量级时的冷区常数障碍。它证明了完整有限事件方法越过 parity 天花板，却没有单凭此式改进 Holzmüller–Bach 已知冷区范围。

同样，当 $M\asymp n$ 而 $BM^{-s}=o(\log M)$ 时，(F13) 强制 $t\to0$。此时必须研究 LP 在小 $t$、增长 $M,n$ 的联合行为；大 $t$ 极限不能用来填补这个区间。

### 5. 一个真正进入过渡区的显式逆变换证书

上一节的大 $t$ 推论只重获冷区。下面保留一个高阶逆变换系数的非负约束，在 $t$ 可以趋于零的联合区间得到更强下界。

#### 定理 F5（四倍总体的过渡区下界及有限事件指数尺度）

设 $n\ge16$，$M=4n$，$t\ge16/n$，$0<v\le1$。则

$$\boxed{E_{4n,n}(t,v)\ge
v\,10^{-(2/t+3)}=\frac{v}{1000}\exp\left(-\frac{2\log10}{t}\right).}\tag{F15}$$

并且一个仅用于有限事件问题的显式算法给出

$$\boxed{E_{4n,n}(t,v)\le
v\min\left\{\frac12,\exp\left(-\frac{16}{65t}\right)\right\}.}\tag{F16}$$

因此，在上述全部有限参数范围内，有

$$\boxed{\frac8{65}(1+t^{-1})
\le\log\frac{v}{E_{4n,n}(t,v)}
\le3\log10\,(1+t^{-1}).}\tag{F17}$$

(F16)–(F17) 精确限定为 finite-event 任务，不是原完整连续采样风险的上界。

##### 5.1 超几何核的显式左逆

暂令 $M>n$ 任意，记 $q=M-n$。对于 $0\le j\le n$，定义只支撑在 $\{0,\ldots,j\}$ 的向量

$$w_{j,k}=\frac{(-1)^{j-k}\binom Mk\binom{q+j-k-1}{j-k}}{\binom nj}
\quad(0\le k\le j),\qquad w_{j,k}=0\quad(k>j).\tag{F18}$$

由二项式恒等式

$$H_{k,r}=\frac{\binom nr\binom q{k-r}}{\binom Mk},$$

若 $h=Ha$，则生成函数满足

$$\sum_{k=0}^M\binom Mk h(k)z^k
=(1+z)^q\sum_{r=0}^n\binom nr a_r z^r.$$

乘以 $(1+z)^{-q}$ 并取 $z^j$ 系数，即得

$$w_j^T h=a_j,\qquad\boxed{H^Tw_j=e_j.}\tag{F19}$$

这是形式幂级数恒等式；只用前 $j+1$ 个系数，没有收敛或余项假设。因此 $-w_j/\|w_j\|_1$ 是 (F6) 的对偶可行向量，其 $H^T$ 像处处非正，正部惩罚完全消失。

##### 5.2 逆系数多项式与符号控制

现取 $M=4n$、$q=3n$。定义

$$A_j(u)=\sum_{k=0}^jw_{j,k}u^k
=\binom nj^{-1}[z^j]\frac{(1+uz)^M}{(1+z)^q},\qquad 0\le u\le1.\tag{F20}$$

于是 $A_0(u)=1$，$A_1(u)=4u-3$。对生成函数求导并比较系数，得到对 $2\le j\le n$ 的精确递推

$$A_j(u)=
\frac{Mu-q-(1+u)(j-1)}{n-j+1}A_{j-1}(u)
+\frac{u(j-1)}{n-j+1}A_{j-2}(u).\tag{F21}$$

具体地，若 $F(z)=(1+uz)^M/(1+z)^q$，则
$(1+z)(1+uz)F'(z)=[Mu-q+un z]F(z)$，这直接导出 (F21)。

对所有 $j\le n/4+1$，有以下三个界：

1. 若 $0\le u\le3/4$，则 $(-1)^jA_j(u)\ge0$。
2. 若 $0\le u\le1/4$，则 $(-1)^jA_j(u)\ge2^j$。
3. 若 $3/4\le u\le1$，则 $|A_j(u)|\le1$。

前两个结论由 (F21) 对 $B_j=(-1)^jA_j$ 归纳得到。在 $u\le3/4$ 时，$B_j$ 递推的两个系数均非负；在 $u\le1/4$ 时，第一个系数至少是

$$\frac{q-Mu}{n-j+1}\ge\frac{2n}{n-j+1}\ge2,$$

且 $B_0=1$、$B_1\ge2$，从而得到 $2^j$ 界。

为证第三个结论，记 (F21) 的两个系数为 $a,b$，其中 $b\ge0$。若 $a\ge0$，则

$$|a|+b=\frac{Mu-q-(j-1)}{n-j+1}\le1.$$

若 $a<0$，利用 $Mu-q\ge0$，有

$$|a|+b\le\frac{(1+2u)(j-1)}{n-j+1}
\le\frac{3(j-1)}{n-j+1}\le1,$$

最后一步等价于 $j\le n/4+1$。由 $|A_0|,|A_1|\le1$ 归纳即得第三个结论。

##### 5.3 选择对偶阶数并控制其范数

令 $\alpha=1/t$，取满足

$$2\alpha+1\le j\le2\alpha+3\tag{F22}$$

的最小奇整数。因为 $t\ge16/n$，有

$$j\le n/8+3\le n/4+1\le n\qquad(n\ge16).$$

对 reciprocal 目标，有合法的积分表示

$$g_t(k)=v\int_0^1u^k\alpha u^{\alpha-1}du.$$

因此，利用奇数 $j$ 及上述三个符号界，

$$\begin{aligned}
w_j^Tg_t
&=v\int_0^1A_j(u)\alpha u^{\alpha-1}du\\
&\le v\left[-2^j\left(\frac14\right)^\alpha+1\right]\\
&=v[1-2^{j-2\alpha}]\le-v.
\end{aligned}\tag{F23}$$

这里 $[1/4,3/4]$ 上的积分非正而被舍弃，$[3/4,1]$ 上的积分被其概率质量的上界 $1$ 控制；没有把两段积分的符号抵消假设为独立事件。

另一方面，由 (F18)，

$$\begin{aligned}
\|w_j\|_1
&=\binom nj^{-1}\sum_{k=0}^j\binom Mk\binom{q+j-k-1}{j-k}\\
&\le\frac{(M+q+j-1)^j}{(n-j+1)^j}
\le\left(\frac{29}{3}\right)^j\le10^j.
\end{aligned}\tag{F24}$$

第一处不等式使用
$\binom Mk\le M^k/k!$、
$\binom{q+j-k-1}{j-k}\le(q+j-1)^{j-k}/(j-k)!$、
$\binom nj\ge(n-j+1)^j/j!$ 及二项式求和。
第二处使用 $M+q=7n$、$j-1\le n/4$、$n-j+1\ge3n/4$。

将 $y=-w_j/\|w_j\|_1$ 代入 (F6)，由 (F19)、(F23) 和 (F24)，得到

$$E_{4n,n}(t,v)\ge-\frac{w_j^Tg_t}{\|w_j\|_1}
\ge v10^{-j}\ge v10^{-(2/t+3)},$$

这证明了 (F15)。该证书使用的是一个负的必需概率系数，不要求最高阶 parity 系数，也不使用浮点最优值。

##### 5.4 仅用于有限事件任务的匹配指数上界

令 $\zeta=Mt/(1+Mt)$。先生成 $G\in\{0,1,\ldots\}$，其分布为
$\Pr(G=\ell)=(1-\zeta)\zeta^\ell$。只需要区分 $G=0,\ldots,n$ 和 $G>n$，所以可用至多 $n+1$ 次已知概率辅助投币实现这个截断随机变量。若 $G>n$，输出 $0$；若 $G\le n$，独立均匀有放回抽取 $G$ 个坐标并查询，仅在所读位全部为零时以概率 $v$ 输出 $1$。

此算法每路径读取至多 $n$ 次。对于重量 $k$，无限和对应的目标恰为

$$v(1-\zeta)\sum_{\ell=0}^{\infty}[\zeta(1-k/M)]^\ell
=\frac{v}{1+tk}.$$

截断算法的误差是

$$g_t(k)[\zeta(1-k/M)]^{n+1}\le v\zeta^{n+1}.$$

这个简单的几何 factory 构造不主张原创。对 $M=4n$、$nt\ge16$，有

$$\zeta^{n+1}\le\exp\left(-\frac{n+1}{1+4nt}\right)
\le\exp\left(-\frac{16}{65t}\right).$$

最后一步等价于 $nt+65t\ge16$，由 $nt\ge16$ 保证。另一个合法算法是不查询并以概率 $v/2$ 输出 $1$，其误差至多 $v/2$。这给出 (F16)。由 (F15)–(F16)，

$$\max\{\log2,16/(65t)\}\le\log(v/E_{4n,n})
\le3\log10+(2\log10)/t,$$

从而 (F17) 成立。注意有放回抽坐标仅出现在这个有限事件上界中；它与必要性证明中用于压缩信息的无放回核不矛盾。

##### 5.5 全部 $t>0$ 的有限事件负对数尺度

把 (F15) 与第一轮的有限差分证书结合，可闭合这个辅助实验的全部 $t$ 范围。

**推论 F5a。** 对所有 $n\ge16$、$t>0$ 和 $0<v\le1$，令
$L=\log(1+1/(nt))$，则

$$\boxed{\frac18(1+nL)\le
\log\frac{v}{E_{4n,n}(t,v)}
\le40(1+nL).}\tag{F24a}$$

**证明。** 上节的几何算法对全部 $t>0$ 有效。因此

$$\log(v/E_{4n,n})\ge
\max\left\{\log2,(n+1)\log\left(1+\frac1{4nt}\right)\right\}
\ge\max\{\log2,nL/4\}\ge(1+nL)/8.$$

倒数第二步使用对数的凹性，最后一步可用 $\log2\ge1/2$ 验证。

若 $t\ge16/n$，则 $\log(1+x)\ge x/(1+x)$ 在 $x=1/(nt)\le1/16$ 时给出 $1/t\le17nL/16$。由 (F15)，

$$\log(v/E_{4n,n})\le3\log10+2\log10/t
\le3\log10\,(1+nL)<40(1+nL).$$

若 $t<16/n$，令 $N=n+1$。把输入限制为前 $N$ 位任意、其他位全零，目标仍是 $v/(1+t|\theta|)$；任意原算法仍只读取至多 $n$ 个未知位。第一轮叶子 parity 论证和倒数差分恒等式直接给出

$$E_{4n,n}(t,v)\ge
\frac{vN!t^N}{2^N\prod_{k=0}^N(1+kt)}
\ge v\left[\frac{Nt}{6(1+Nt)}\right]^N.$$

第二步使用 $N!\ge(N/3)^N$ 及 $\prod_{k=0}^N(1+kt)\le(1+Nt)^N$。从而

$$\log(v/E_{4n,n})\le N\left[\log6+\log\left(1+\frac1{Nt}\right)\right]
\le\frac{17n}{16}(2+L).$$

这里 $N\le17n/16$、$\log6<2$。又因 $nt<16$，$L\ge\log(17/16)\ge1/17$，所以最后一项至多
$(17/16)\cdot35\,nL<38nL<40(1+nL)$。两支合并即得 (F24a)。证毕。

该推论的精度明确定义为 $\log(v/E)$ 的常数倍匹配；它不是 $E$ 本身的常数倍公式，也不升级为原光滑模型完整 TV 风险的等式。

### 6. 对原光滑模型的过渡推论及精度边界

令 $b=Bn^{-s}$，保留 (F12) 中的 $\kappa$，定义显式常数

$$\beta=\kappa4^{-s},\qquad
b_0=\beta^{-1}\log(1+16\cdot4^{d+1}),\qquad
C_*=2\cdot4^{d+1}\log10.$$

#### 推论 F6（原风险的温度相关指数障碍）

对所有 $n\ge16$ 和 $b\ge b_0$，

$$\boxed{R_\mathrm{TV}(B,n)\ge\frac1{2000}
\exp\left\{-\frac{C_*n}{e^{\beta b}-1}\right\}.}\tag{F25}$$

**证明。** 在光滑嵌入中取 $M=4n$ 和满振幅。式 (F12) 给出实际积分参数的下界

$$t\ge\frac{e^{\beta b}-1}{4^{d+1}n}\ge\frac{16}{n}.$$

故可以先对这个**实际 $t$** 应用 (F15) 和 (F11)。然后使用
$t^{-1}\le4^{d+1}n/(e^{\beta b}-1)$ 以及 $v\ge1/2$，得到 (F25)。没有假设 $E_{M,n}$ 对 $t$ 单调；替换参数只发生在已经证明的显式单调下界中。证毕。

与第一轮对 $b\ge1$ 基本保持 $\exp(-Cn)$ 形式的简化 parity 下界相比，(F25) 的负对数上界会随着 $b$ 增大而降到 $o(n)$。这是真正涉及过渡区的定量改进，并非大 $t$ 冷区结果的重命名。

以下推论只陈述较弱的指数精度，不替代原冻结目标要求的全参数同点匹配。

#### 推论 F7（指数速度的三种范围）

令 $n\to\infty$，$b_n=B_n n^{-s}$。

- 若 $b_n\to0$，第一轮已证明
  $-\log R_\mathrm{TV}(B_n,n)\sim n\log(1/b_n)$。
- 若 $0<c\le b_n\le C<\infty$，则
  $-\log R_\mathrm{TV}(B_n,n)=\Theta_{m,d,c,C}(n)$。
- 若 $b_n\to\infty$，则
  $[-\log R_\mathrm{TV}(B_n,n)]/n\to0$。

中间项的下界（针对负对数）由固定比例预算的逼近—拒绝采样上界得到；其上界由第一轮 (S1) 得到。第三项由 (F25)、$0<R_\mathrm{TV}\le1$ 以及

$$\frac{-\log R_\mathrm{TV}}n
\le\frac{\log2000}{n}+\frac{C_*}{e^{\beta b_n}-1}\longrightarrow0$$

直接得到。三种陈述针对各自列明的序列；并没有将任意振荡序列强行放入某个极限类。

若进一步 $b_n\to\infty$ 且 $b_n=o(\log n)$，可给出第二重对数的过渡尺度。设 $T_n=-\log R_\mathrm{TV}(B_n,n)$。固定比例预算的已证拒绝上界给出某个 $C_2=C_2(m,d)>0$ 使

$$T_n\ge\frac n2e^{-C_2b_n}$$

对充分大的 $n$ 成立；而 (F25) 及 $n e^{-\beta b_n}\to\infty$ 给出
$T_n\le C_3n e^{-\beta b_n}$，其中 $C_3>0$ 只依赖 $m,d$。因此

$$\boxed{\log\frac{n}{-\log R_\mathrm{TV}(B_n,n)}
=\Theta_{m,d}(b_n).}\tag{F26}$$

具体地，左边夹在 $\beta b_n-\log C_3$ 与 $C_2b_n+\log2$ 之间。该推论在第二重对数上匹配温度尺度；它**不**证明 $T_n$ 在同一个 $b_n$ 上具有常数倍匹配，因为 $\beta$ 与 $C_2$ 仍处于指数内部。它也不证明精确风险级别的原全温度相图。

### 7. 精确计算的角色与当前剩余问题

`code/finite_event_lp.py` 和 `results/finite_event_lp_certificates.json` 保存有限有理参数的原始—对偶证书。证书只验证各自给定的有限参数；它们不构成所有实数参数的数值证明，也不自动验证光滑 bump 积分给出的 $t$。理论上的完整有限事件等价关系由定理 F1–F2 的证明承担。

`code/bernstein_transition_certificate.py` 对显式逆核、对偶及递推给出独立可运行的有限精确算术检查。有限检查支撑实现复核；定理 F5 的全部实数 $t$ 和所有整数 $n$ 范围由上述解析证明承担。

本轮已经得到：任意随机自适应有限坐标算法的完整对称事件概率集合；其准确 minimax LP 和可复核对偶；固定总体的大振幅精确极限；四倍总体下全部 $t>0$ 的有限事件负对数尺度；以及向原无条件光滑采样风险的温度相关指数下界。这里“完整”只修饰所述有限事件实验。

尚未得到：使 (F11) 或 (F25) 与原问题可实现采样上界在所有 $B,n$ 上匹配的统一解析式，或证明同质 bump 和共同补集事件足以达到原问题全部过渡区下界。式 (F25)–(F26) 现在对 $1\ll Bn^{-s}\ll\log n$ 给出新的定量信息，但原光滑问题的不同几何常数仍处于指数内部。有限 LP 的全部最优值及剩余参数区域也未获统一闭式解。不能把这些常数视为无害外部因子，不能把第二重对数匹配冒充原风险匹配，也不能用有限证书数量替代理论深度。

### 8. 与先例的边界

- Goyal–Sigman, *On Simulating a Class of Bernstein Polynomials*, TOMACS 22(2), Article 12 (2012), Propositions 2.1–2.2、Theorem 2.3：固定数量 iid Bernoulli 观测的可实现概率是系数落在 $[0,1]$ 的 Bernstein 多项式。原文：[作者全文](https://www.columbia.edu/~vg2277/simulate_bernstein.pdf)，[出版 DOI](https://doi.org/10.1145/2133390.2133396)。本稿的有限总体刻画是相邻版本，并未首次发现有界系数方法。
- Nacu–Peres, *Fast simulation of new coins from old*, Annals of Applied Probability 15(1A), 93–115 (2005)，§2–3、公式 (7)–(11)：用超几何条件分布表达 Bernstein 模拟的一致性。原文：[arXiv 全文](https://arxiv.org/pdf/math/0309222)。其允许随机停止的完整 factory 问题与本稿固定预算误差不同，但所用核有直接先例。
- Cordero–Hummel–Schertzer, *General selection models: Bernstein duality and minimal ancestral structures*, arXiv:1903.06731，Lemma 7.1、公式 (7.1)、Remark 7.1：明确给出相同超几何升阶矩阵。原文：[作者所在机构全文](https://www.sfb1283.uni-bielefeld.de/preprints/sfb19007.pdf)。
- Holzmüller–Bach, *Convergence Rates for Non-Log-Concave Sampling and Log-Partition Estimation*, JMLR 26(249), 1–72 (2025)，[arXiv v4](https://arxiv.org/html/2303.03237v4)：原模型的已知逼近—拒绝采样上界和冷区下界仍是本稿必须对比的基准；本稿没有因得到 (F14) 而宣称首次发现该冷区。

原问题的尖锐风险在部分温度过渡区仍待确定。


\clearpage

# 附录 E：有界正权重与改进的 log-partition 上界


### Status and provenance

This appendix improves the evaluation of residual importance sampling and gives matching bounds for the auxiliary bounded-weight model. The upper proof uses classical variance and Jensen inequalities, and the lower proof compares two distributions.

The results improve the explicit residual-importance upper bound and give a complete auxiliary fixed-sample minimax rate. They **do not** identify a multiplicatively matching risk for the original smooth model throughout its temperature transition, nor do they settle the TV part of that frozen target.

Numbering correction: in Holzmüller–Bach [arXiv:2303.03237v4](https://arxiv.org/html/2303.03237v4), the residual-importance bound is **Theorem 9**, with proof in Appendix B.2. The uniform-sample MC log-partition result is **Theorem 25**, not Theorem 23; Theorem 23 concerns density norms.

### 1. Exact auxiliary model

Let \(n\geq1\) and \(\kappa\geq1\). Let \(\mathcal P_\kappa\) be the collection of all probability laws supported on \([1,\kappa]\). For \(P\in\mathcal P_\kappa\), write

\[
 \mu_P=\mathbb E_PX,\qquad
 W_n=\frac1n\sum_{i=1}^nX_i,\qquad X_i\stackrel{\mathrm{iid}}{\sim}P.
\]

The observations are the \(n\) samples themselves. Estimators may be randomized but must use the same fixed sample budget. Define

\[
 \mathfrak R_n(\kappa)
 =\inf_{\widehat\ell}
     \sup_{P\in\mathcal P_\kappa}
       \mathbb E_P|\widehat\ell-\log\mu_P|,
\]

and

\[
 \rho=\frac{\kappa-1}{\sqrt{n\kappa}},
 \qquad F_n(\kappa)=\log(1+\rho).
 \tag{R1}
\]

This is an auxiliary iid statistical problem; its sample access must not be confused with the adaptive point oracle of the main Gibbs problem.

#### Theorem R1: uniform bounded-log-mean risk

For every \(n\geq1,\kappa\geq1\),

\[
 \frac1{64}F_n(\kappa)
 \leq\mathfrak R_n(\kappa)
 \leq\sup_{P\in\mathcal P_\kappa}
          \mathbb E_P|\log W_n-\log\mu_P|
 \leq4F_n(\kappa).
 \tag{R2}
\]

In particular, the unregularized logarithm of the sample mean already attains the correct order. No pseudo-count or truncated logarithm is needed because the support has a strictly positive known lower bound.

If \(\kappa=1\), both sides and the risk are zero. The bounds preserve the factor \(\kappa-1\) near that boundary. In the regime \(\kappa/n\to\infty\), the rate has order \(\log(\kappa/n)\), up to universal constants; this follows from (R1), rather than from a small-relative-error approximation.

### 2. Upper proof by positive deviations and Jensen bias

Fix a law \(P\in\mathcal P_\kappa\), and abbreviate \(\mu=\mathbb EX\), \(W=W_n\). The identity

\[
 \mathbb E[(X-1)(\kappa-X)]\geq0
\]

gives the classical mean-dependent range bound

\[
 \operatorname{Var}(X)\leq(\kappa-\mu)(\mu-1).
 \tag{R3}
\]

This is the scalar Bhatia–Davis variance bound. Its use here is elementary, and the displayed one-line derivation is sufficient for the present proof.

Two useful consequences, obtained by maximizing the right-hand side over \(1\leq\mu\leq\kappa\), are

\[
 \frac{\operatorname{Var}(X)}{\mu^2}
 \leq\frac{(\kappa-1)^2}{4\kappa},
 \qquad
 \frac{\operatorname{Var}(X)}{\mu}
 \leq(\sqrt\kappa-1)^2.
 \tag{R4}
\]

For the first, the maximum occurs at \(\mu=2\kappa/(\kappa+1)\); equivalently, the required polynomial inequality is the nonnegativity of
\(((\kappa+1)\mu-2\kappa)^2\).
For the second, use
\((\kappa-\mu)(\mu-1)/\mu=\kappa+1-\mu-\kappa/\mu
\leq\kappa+1-2\sqrt\kappa\).

Set

\[
 A=\mathbb E\bigl[\log(W/\mu)\bigr]_+,
 \qquad
 J=\log\mu-\mathbb E\log W.
\]

By Jensen, \(J\geq0\), and the exact positive/negative-part decomposition gives

\[
 \mathbb E|\log W-\log\mu|=2A+J.
 \tag{R5}
\]

For the positive part, concavity of the logarithm and centering of \(W-\mu\) yield

\[
\begin{split}
 A
 &=\mathbb E\log\left(1+\frac{(W-\mu)_+}{\mu}\right)\\
 &\leq\log\left(1+\frac{\mathbb E(W-\mu)_+}{\mu}\right)\\
 &=\log\left(1+\frac{\mathbb E|W-\mu|}{2\mu}\right)\\
 &\leq\log(1+\rho/4).
\end{split} \tag{R6}
\]

The last step uses \(\operatorname{Var}(W)=\operatorname{Var}(X)/n\) and the first inequality in (R4).

For the bias, the positive lower support bound \(W\geq1\) is essential. First,

\[
 J=\mathbb E\log(\mu/W)\leq\log\bigl(\mu\mathbb E(1/W)\bigr).
\]

Next, the following identity is exact:

\[
 \mu\mathbb E(1/W)-1
 =\mathbb E\frac{(W-\mu)^2}{\mu W}
 \leq\frac{\operatorname{Var}(W)}{\mu}.
 \tag{R7}
\]

Indeed, expanding the fraction inside the expectation gives
\(\mathbb E(W/\mu-2+\mu/W)=\mu\mathbb E(1/W)-1\).
The inequality uses \(W\geq1\), not an unsupported inverse-moment approximation. From (R4),

\[
 J
 \leq
 \log\left(1+\frac{(\sqrt\kappa-1)^2}{n}\right)
 \leq\log(1+\rho^2).
 \tag{R8}
\]

Here \(\sqrt\kappa-1\leq(\kappa-1)/\sqrt\kappa\) for \(\kappa\geq1\).

Combining (R5)–(R8) gives the slightly more informative bound

\[
 \mathbb E|\log W-\log\mu|
 \leq
 2\log(1+\rho/4)
 +
 \log\left(1+\frac{(\sqrt\kappa-1)^2}{n}\right)
 \leq4\log(1+\rho).
 \tag{R9}
\]

This proves the upper half of Theorem R1. It is valid for every support ratio and sample size, without a Taylor expansion or an event on which \(W\) is assumed close to \(\mu\).

### 3. Matching auxiliary minimax lower bound

We give the two-distribution argument explicitly, including constants. This section establishes an auxiliary statistical rate; it does not claim that every worst-case iid weight distribution can be realized by a smooth Gibbs residual.

For two observation laws \(Q_0,Q_1\), and target values \(\ell_0,\ell_1\), every estimator satisfies

\[
 \max_{i=0,1}\mathbb E_{Q_i}|\widehat\ell-\ell_i|
 \geq
 \frac{|\ell_1-\ell_0|}{2}
       (1-\operatorname{TV}(Q_0,Q_1)).
 \tag{R10}
\]

To prove this, integrate the triangle inequality
\(|z-\ell_0|+|z-\ell_1|\geq|\ell_1-\ell_0|\)
against the common part of the two data measures. Independent estimator randomization can be included in the common observation space and does not change their total variation.

Assume now \(\kappa>1\), and use only endpoint laws

\[
 X=1+(\kappa-1)Y,\qquad Y\sim\operatorname{Bern}(p).
 \tag{R11}
\]

#### 3.1 The case \(0<\rho\leq1\)

Put

\[
 p_0=\frac1{\kappa+1},
 \qquad
 h=\frac{\sqrt\kappa}{8(\kappa+1)\sqrt n},
 \qquad
 p_1=p_0+h.
 \tag{R12}
\]

The condition \(\rho\leq1\) implies \(\kappa\leq n+2\). Hence
\(h/p_0\leq\sqrt3/8<1/4\), so both Bernoulli parameters are valid and \(p_1<1\).

For their \(n\)-sample laws, the chi-square divergence relative to parameter \(p_0\) is exactly

\[
 \chi^2(Q_1,Q_0)
 =
 \left(1+\frac{h^2}{p_0(1-p_0)}\right)^n-1
 =
 \left(1+\frac1{64n}\right)^n-1
 \leq e^{1/64}-1<1.
 \tag{R13}
\]

Cauchy–Schwarz gives
\(\operatorname{TV}(Q_1,Q_0)\leq\frac12\sqrt{\chi^2(Q_1,Q_0)}<1/2\).
The two means have logarithmic separation

\[
 \ell_1-\ell_0
 =
 \log\left(
  1+\frac{(\kappa-1)h}{1+(\kappa-1)p_0}
 \right)
 =
 \log(1+\rho/16)
 \geq\frac1{16}\log(1+\rho).
 \tag{R14}
\]

The last inequality follows from concavity of \(\log\).
Equations (R10), (R13), and (R14) prove the lower bound
\(F_n(\kappa)/64\).

#### 3.2 The case \(\rho\geq1\)

Take \(p_0=0\) and \(p_1=1/(2n)\). Under \(Q_0\), all observations are zero in the Bernoulli representation. The common mass of \(Q_0\) and \(Q_1\) is

\[
 1-\operatorname{TV}(Q_0,Q_1)
 =\left(1-\frac1{2n}\right)^n
 \geq\frac12.
 \tag{R15}
\]

Their target separation is

\[
 \ell_1-\ell_0
 =\log\left(1+\frac{\kappa-1}{2n}\right)
 \geq\log(1+\rho^2/2)
 \geq\frac12\log(1+\rho).
 \tag{R16}
\]

For the first inequality,
\((\kappa-1)/(2n)=\rho^2\kappa/[2(\kappa-1)]\geq\rho^2/2\).
For the second, use \(\rho^2\geq\rho\) and concavity of the logarithm.

Equations (R10), (R15), and (R16) give the stronger bound \(F_n(\kappa)/8\). This completes Theorem R1 for all parameters.

### 4. Transfer to residual importance sampling

Return to the frozen smooth model, with \(s=m/d\) and
\(t=Bn^{-s}\). Use \(k\) point queries to obtain an explicit interpolant \(g\) satisfying

\[
 \|f-g\|_\infty\leq\delta_k=CBk^{-s},
 \qquad k\geq k_0,
 \tag{R17}
\]

where \(C,k_0\) depend only on \(m,d\). Allocate \(r=n-k\geq1\) further queries to independent proposals \(Y_i\sim P_g\).

For a fully explicit choice, use the within-cell interpolation nodes
\(i/(m+1)\), \(1\leq i\leq m\), in each coordinate. One may take

\[
 \Lambda_m=\frac{[2(m+1)]^{m-1}}{(m-1)!},\qquad
 C=\frac{(2m)^m}{m!}\sum_{j=0}^{d-1}\Lambda_m^j,
 \qquad k_0=(2m)^d.
 \tag{R17a}
\]

Indeed, the sum of absolute one-dimensional Lagrange basis polynomials is at most \(\Lambda_m\): their denominators have absolute values
\((i-1)!(m-i)!/(m+1)^{m-1}\), and each numerator factor has absolute value at most one. The univariate remainder is at most \(B/(m!q^m)\); telescoping the tensor operators multiplies it by at most \(\sum_{j=0}^{d-1}\Lambda_m^j\). Finally \(q=\lfloor k^{1/d}/m\rfloor\geq k^{1/d}/(2m)\). This uses only pure derivatives of order \(m\), not mixed derivatives of total order \(md\).

Define the estimator by

\[
 W_i=e^{f(Y_i)-g(Y_i)},\qquad
 \widehat L=L_g+\log\left(\frac1r\sum_{i=1}^rW_i\right).
\]

The identities and support bounds are

\[
 e^{-\delta_k}\leq W_i\leq e^{\delta_k},
 \qquad
 \mathbb EW_i=e^{L_f-L_g}.
\]

Scaling by \(e^{\delta_k}\) puts the weights in
\([1,\kappa]\) with \(\kappa=e^{2\delta_k}\). Thus

\[
 \frac{\kappa-1}{\sqrt{r\kappa}}
 =\frac{2\sinh\delta_k}{\sqrt r}.
\]

Theorem R1 therefore proves

\[
 \boxed{\quad
 \sup_f\mathbb E|\widehat L-L_f|
 \leq
 4\log\left(1+\frac{2\sinh(CBk^{-s})}{\sqrt{n-k}}\right).
 \quad} \tag{R18}
\]

A sharper retained form is

\[
 \sup_f\mathbb E|\widehat L-L_f|
 \leq
 2\log\left(1+\frac{\sinh\delta_k}{2\sqrt r}\right)
 +
 \log\left(1+\frac{(e^{\delta_k}-1)^2}{r}\right).
 \tag{R19}
\]

The pointwise bound \(|\widehat L-L_f|\leq2\delta_k\) is also available for the ideal estimator, and deterministic interpolation provides the separate minimax upper bound \(C_0Bn^{-s}\).

#### Finite surrogate realization and the hard budget

The implementation argument in Appendix C applies. All integration and extra proposal generation evaluate only the known piecewise polynomial \(g\), not the original \(f\). Each \(W_i\) consumes exactly one new point query. The total original-query budget is at most \(k+r=n\) on every path.

For an explicit approximation argument, clip the final estimate to \([-B,B]\), which cannot increase loss because \(L_f\in[-B,B]\). Approximate \(L_g\) within a deterministic tolerance \(\varepsilon/2\). Approximate each of the \(r\) proposal laws within TV tolerance \(\varepsilon/(4Br)\), or a smaller positive tolerance. Coupling all proposals gives total failure probability at most \(\varepsilon/(4B)\), so the change in expected clipped loss is at most \(\varepsilon/2\). Arbitrarily accurate numerical evaluation of the known exponential weights can be incorporated into the same tolerance.

For each \(\varepsilon>0\), these are finite computations in the stated exact-real/continuous-randomness oracle model. They introduce no extra original-function query. Taking an infimum proves (R18) for the minimax risk. It does not assert that the infimum is attained, and it does not claim that finite-bit-coordinate outputs provide TV approximation to a continuous measure.

#### A uniform simplified upper profile

For sufficiently large \(n\), take \(k=\lfloor n/2\rfloor\); then \(k\geq n/3\), \(r\geq n/2\), and \(k\geq k_0\). Adjusting constants depending only on \(m,d\), (R18) gives

\[
 R_L(d,m,B,n)
 \leq
 4\log\left(1+\frac{2\sinh(C_1t)}{\sqrt n}\right).
 \tag{R20}
\]

Here a factor \(\sqrt2\) in the numerator can be absorbed by increasing \(C_1\), using \(\sinh(cx)\geq c\sinh x\) for \(c\geq1,x\geq0\).

For the finitely many smaller budgets, use \(g=0\), no interpolation queries, and \(n\) uniform proposals. Theorem R1 then gives
\(4\log(1+2\sinh B/\sqrt n)\). Since \(B=n^st\) and these \(n\) are bounded in terms of \(m,d\), increasing \(C_1\) covers them as well. Thus (R20) holds for every \(B>0,n\geq1\). We can also combine it with the existing deterministic upper bound.

Using (R17a), explicit sufficient constants are
\(C_1=\max\{\sqrt2\,C3^s,(2k_0)^s\}\) and
\(C_0=\max\{C,k_0^s\}\). For \(C_0\), use interpolation when \(n\geq k_0\), and the answer zero with error at most \(B\) for smaller budgets. For \(C_1\), use half the queries for interpolation when \(n\geq2k_0\), and the uniform-proposal construction otherwise. In particular,

\[
 R_L(d,m,B,n)
 \leq
 \min\left\{
       C_0t,\,
       4\log\left(1+\frac{2\sinh(C_1t)}{\sqrt n}\right)
      \right\}.
 \tag{R21}
\]

### 5. What the new estimate improves

This is an improvement in the **explicit analysis of the same residual-importance algorithm**. It does not require a new oracle or a new sampling mechanism.

For a fixed interpolation error certificate \(\delta\) and \(r\) importance samples, the Appendix B.2 calculation in Holzmüller–Bach gives

\[
 2e^{2\delta}\delta/\sqrt r,
\]

whereas (R18) gives

\[
 4\log(1+2\sinh\delta/\sqrt r).
\]

For example, along \(\delta=(\log r)/3\), the previous displayed error bound grows as \(r^{1/6}\log r\), so the deterministic bound of order \(\delta\) is preferable. The new bound decreases as \(O(r^{-1/6})\). This comparison keeps the same certified \(\delta\); it does not hide a change of the constant multiplying \(\delta\).

More generally, when \(\delta=\theta\log r\), the new upper bound tends to zero for each fixed \(\theta<1/2\), remains bounded at \(\theta=1/2\), and grows at most logarithmically for \(\theta>1/2\). This materially improves the available guarantee for the residual-weight problem.

### 6. Why the smooth transition is still unresolved

The first-round smooth lower bound and (R20) have the forms

\[
 c_0\log\left(1+\frac{2\sinh(c_1t)}{\sqrt n}\right)
 \leq R_L(d,m,B,n)
 \leq
 4\log\left(1+\frac{2\sinh(C_1t)}{\sqrt n}\right),
 \tag{R22}
\]

with explicit positive lower constants and a valid upper constant depending only on \(m,d\). For the lower bound, the fixed factor \(D_d\) inside the square root from the first-round manuscript can be moved into the exterior constant by concavity of \(\log\).

Equation (R22) is a useful common-shape sandwich. It is **not** a multiplicatively matching formula at the same \(B,n\): \(c_1\) and \(C_1\) occur inside a hyperbolic sine. If \(t=\gamma\log n\), different constants can change whether the displayed bound decays, stays bounded, or grows. Calling these constants harmless would change the frozen precision requirement.

Nor does the auxiliary minimax lower bound in Theorem R1 eliminate this gap. The class of arbitrary iid weights on \([1,\kappa]\) is larger than the class of residual weights produced by a given smooth potential and an adaptive interpolation method. There is no proved equivalence identifying their worst cases at a common sharp geometric scale.

Accordingly, the proved secondary additions are:

- A self-contained, all-\(\kappa,n\), constant-factor auxiliary minimax theorem, with the raw log sample mean attaining the upper order.
- An improved, implementable, all-\(B,n\) smooth log-partition upper bound.
- A sharper comparison with the existing first-round lower profile.

The unclosed tasks are still the smooth transition at the required matching precision and any remaining TV transition obligations. The auxiliary theorem is based on short classical arguments and should not independently be treated as meeting the project's high contribution threshold.

### References and collision limits

1. Holzmüller–Bach, [arXiv:2303.03237v4](https://arxiv.org/html/2303.03237v4), Theorem 9 and Appendix B.2; Theorem 25 and Appendix D.2.2. The checked proof of Theorem 9 contains the older exponential-Lipschitz estimate used in Section 5.
2. Bhatia–Davis, *A Better Bound on the Variance*, The American Mathematical Monthly 107(4):353–357, 2000, [DOI 10.1080/00029890.2000.12005203](https://doi.org/10.1080/00029890.2000.12005203). Publisher and institutional-repository metadata were retrieved; full-text access was blocked in this check. The scalar inequality needed here is proved directly in (R3).
3. Liao–Berg, *Sharpening Jensen's Inequality*, The American Statistician, [DOI 10.1080/00031305.2017.1419145](https://doi.org/10.1080/00031305.2017.1419145); [author-hosted primary text](https://arthurberg.com/papers/Liao_19.pdf). This is prior work on quantitative Jensen gaps, not a source being claimed to state Theorem R1.
4. Huber, *An optimal \((\epsilon,\delta)\)-approximation scheme for the mean of random variables with bounded relative variance*, [arXiv:1706.01478v2](https://arxiv.org/abs/1706.01478). This concerns high-probability relative-error approximation and supplies relevant prior context.
5. Maddison et al., *Filtering Variational Objectives*, NeurIPS 2017, [primary proceedings PDF](https://papers.nips.cc/paper_files/paper/2017/file/fa84632d742f2729dc32ce8cb5d49733-Paper.pdf). Its discussion of log-transformed Monte Carlo estimators is relevant prior context for bias/variance analysis.

The targeted searches did not locate a source with exactly the uniform expected-absolute-log formula in Theorem R1. That finite search does not establish originality, and the short derivation from established tools materially limits any novelty claim.
