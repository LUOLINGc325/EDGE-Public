# Sibuya 时钟下量子重置归约的最优收敛速率

*有限维非对易跳跃信道的振荡首项与严格锐例*

研究稿 v1 · 2026-11-24

## 摘要

考虑一个有限维量子系统：普通时间步作用量子信道 $\Phi$，随机事件步作用另一信道 $R$，事件间隔独立且服从参数 $0<\gamma<1$ 的 Sibuya 分布。事件本身占据一个时间步。本研究处理一个已明确提出的定量问题：在完整单位圆非共振条件 (W) 下，实际平均态与同一时钟驱动的等效完全重置模型之间的误差以何种速率消失？我们给出 $O(t^{-\gamma})$ 的迹范数上界、所有外围谱模的显式振荡首项，以及 $O(t^{-\min\{2\gamma,1\}})$ 的余项。证明保持全部算子顺序，允许自由信道的稳定谱部分具有 Jordan 块，不要求跳跃信道严格收缩。一个非对易的单量子比特例子表明，即使实际系统从等效态出发，该指数仍不能普遍提高。方法使用经典更新方程与奇点分析；候选新增内容限于这一归约误差的最优速率、首项公式和锐例。有限计算仅核验公式和实例，不代替一般定理的书面证明。

## 1. 问题来源及通俗说明

完全重置把系统直接送回一个固定量子态。不完美重置可能保留旧信息，也可能只重置部分自由度。对后者，即使知道长时间后能够用一个等效完全重置过程描述，仍不知道两个过程在有限时间有多接近。

Wald 等的离散量子重置模型 [1] 给出了物理背景。随后的一份研究稿 [2] 的定理 5.1 在条件 (W) 下证明了不完美重置与等效完全重置之间的误差趋于零；该稿第 9 节、第 24 页明确把 Sibuya 时钟下的收敛速率留作开放问题。本稿研究的正是这个定量缺口。[2] 本身是未经过外部同行评审的研究稿；这里重推所用更新恒等式和固定点结构，后续证明不以其正确性为不可检查的黑箱。

可以把两个过程理解为“真实重置装置”和“经过校准的理想重置装置”。本稿估计它们在第 $t$ 步的平均状态差异。参数 $\gamma$ 决定事件间隔的重尾程度。结果说明，这一模型替代误差的最坏衰减指数恰为 $\gamma$。这是固定模型下的大时间估计，尚不是一个具有统一数值常数的工程运行时长保证。

需要区分两个量：真实过程与等效过程的差，以及任一过程与最终稳态的差。后者可以含有更慢的 $t^{-(1-\gamma)}$ 项。我们证明前一差量中的慢项相消，因此当 $\gamma>1/2$ 时，两个过程彼此接近的速度可以快于它们各自接近稳态的速度。

## 2. 模型、时钟与符号

底层 Hilbert 空间为有限维 $\mathbb C^d$。$\Phi$ 和 $R$ 均为完全正、保迹的线性映射，即量子信道。每个普通步作用 $\Phi$；每个事件步只作用 $R$，不额外作用 $\Phi$。因此间隔为 $\ell$ 的完整周期对应

$$B_\ell=R\Phi^{\ell-1}.$$

间隔 $L$ 独立同分布，且独立于量子态，取

$$p_\ell=\Pr(L=\ell)=(-1)^{\ell-1}\binom\gamma\ell,
\quad \ell\ge1,\quad 0<\gamma<1.$$

记 $s_n=\Pr(L>n)$，$u_n$ 为第 $n$ 步发生更新的概率，并约定 $u_0=1$。以 $(a)_n$ 表示上升阶乘，则

$$s_n=\frac{(1-\gamma)_n}{n!},\qquad
u_n=\frac{(\gamma)_n}{n!},$$

$$P(w)=\sum_{\ell\ge1}p_\ell w^\ell=1-(1-w)^\gamma,
\qquad \sum_{n\ge0}u_nw^n=(1-w)^{-\gamma}.$$

这等价于年龄为 $n$ 时的事件概率 $r_n=\gamma/(n+1)$。其平均等待时间无穷大，但每次等待几乎必然结束。$\gamma=0,1$ 不属于本文定理的参数范围。

令 $\rho_t^{\rm par}$ 是从任意密度矩阵 $\rho_0$ 出发的实际平均态。等效完全重置映射为

$$F_t(X)=\sum_{n=0}^t s_nu_{t-n}\Phi^n(X). \tag{2.1}$$

对于密度矩阵 $X$，式 (2.1) 表示初态和每次完全重置后的状态都为 $X$。恒等式 $\sum_{n=0}^t s_nu_{t-n}=1$ 由生成函数相乘直接得到。

令 $\mathcal V$ 为无迹 Hermitian 矩阵组成的实向量空间，做谱分析时取其复化。选择 $\Phi$ 的一个固定密度矩阵 $\sigma$，定义

$$T=\Phi|_{\mathcal V},\quad A=R|_{\mathcal V},\quad
b=R(\sigma)-\sigma,\quad x_0=\rho_0-\sigma,\quad v=x_0-b.$$

固定态 $\sigma$ 可由 $\Phi$ 的 Cesàro 平均取得；不要求唯一。引入

$$M(w)=\sum_{\ell\ge1}p_\ell w^\ell T^{\ell-1},\quad
K(w)=AM(w),\quad H(w)=(I-K(w))^{-1}.$$

本文保留原稿 [2] 的完整条件

$$\det_{\mathcal V_{\mathbb C}}(I-K(w))\ne0
\qquad\text{对每个 }|w|=1. \tag{W}$$

它排除与更新时钟锁定的无迹模式。只在 $w=1$ 检验平均周期信道固定态的唯一性，并不足以替代 (W)。

## 3. 主定理与全部首项

**定理 3.1（最优归约速率）。** 在上述假设和 (W) 下，平均周期信道

$$\overline B=\sum_{\ell\ge1}p_\ell R\Phi^{\ell-1}$$

具有唯一固定密度矩阵 $\rho_{\rm eff}$。对所有初始密度矩阵，

$$\boxed{\|\rho_t^{\rm par}-F_t(\rho_{\rm eff})\|_1
      =O((t+1)^{-\gamma}).} \tag{3.1}$$

固定 $\Phi,R,\gamma$ 后，可对全部初态统一选取常数。该常数允许依赖固定信道和 $\gamma$；不声称在接近 (W) 失效、谱点合并或 $\gamma$ 的端点时一致。指数 $\gamma$ 在此类模型中最优。

以下更强结论同时给出所有振荡。令 $\Lambda$ 为 $T$ 在单位圆上的谱，$Q_\lambda$ 为对应谱投影，记

$$H_*=H(1),\qquad H_\lambda=H(\lambda^{-1}),
\qquad \beta=\min\{2\gamma,1\}>\gamma.$$

对 $\lambda\ne1$ 定义

$$D_\lambda=Q_\lambda\left[
H_\lambda v+(1-\lambda^{-1})^{-\gamma}(H_\lambda-H_*)b
\right]. \tag{3.2}$$

若 $1\in\Lambda$，定义

$$D_1=Q_1H_*v-Q_1H_*AQ_1H_*b. \tag{3.3}$$

复数幂采用由开单位圆盘内幂级数延伸得到的分支。则在迹范数意义下

$$\boxed{\rho_t^{\rm par}-F_t(\rho_{\rm eff})
=s_t\sum_{\lambda\in\Lambda}\lambda^tD_\lambda
+O((t+1)^{-\beta}).} \tag{3.4}$$

若外围谱为空，和式为零；若没有特征值 $1$，省略 $D_1$。我们并不声称每个模型的首项都非零，或余项阶在每个子类中最优。由

$$s_t=\frac{t^{-\gamma}}{\Gamma(1-\gamma)}
\bigl(1+O(t^{-1})\bigr)$$

可把式 (3.4) 的 $s_t$ 替换为 $t^{-\gamma}/\Gamma(1-\gamma)$，保持所写余项阶。

## 4. 保持算子顺序的更新恒等式

令 $\Omega_n$ 为第 $n$ 步恰在事件之后的未归一化平均态，约定 $\Omega_0=\rho_0$。按上一个事件条件化得

$$\Omega_n=\sum_{\ell=1}^n p_\ell R\Phi^{\ell-1}(\Omega_{n-\ell}),
\qquad\operatorname{tr}\Omega_n=u_n.$$

置 $y_n=\Omega_n-u_n\sigma$。因为 $\Phi\sigma=\sigma$，

$$y_0=x_0,\qquad
y_n=u_nb+\sum_{\ell=1}^n p_\ell AT^{\ell-1}y_{n-\ell}.$$

因此在 $|w|<1$，

$$\widehat y(w)=H(w)\bigl[(1-w)^{-\gamma}b+v\bigr]. \tag{4.1}$$

再次按最后一个事件条件化，定义

$$Z(w)=\sum_{n\ge0}s_nw^nT^n=(I-wT)^{\gamma-1},$$

便有

$$\sum_{t\ge0}(\rho_t^{\rm par}-\sigma)w^t
=Z(w)H(w)\bigl[(1-w)^{-\gamma}b+v\bigr].$$

平均周期信道是量子信道，所以在紧凸的密度矩阵集合上有固定点。若两个固定点不同，其差属于 $\mathcal V$ 并满足 $K(1)x=x$，违反 (W)。仿射固定点方程给出

$$\rho_{\rm eff}=\sigma+H_*b. \tag{4.2}$$

式 (4.2) 的正性来自固定点构造，不来自对 $H_*$ 正性的假设。

将等效完全重置式 (2.1) 减去，可得到误差 $E_t=\rho_t^{\rm par}-F_t(\rho_{\rm eff})$ 的精确生成函数：

$$\boxed{\widehat E(w)=
Z(w)(1-w)^{-\gamma}[H(w)-H_*]b+Z(w)H(w)v.} \tag{4.3}$$

更新展开及其算子顺序有经典背景 [3]。式 (4.3) 中 $Z$ 始终位于左侧；后文不能把 $H$、$A$ 或谱投影任意交换。

## 5. 为什么原有 (W) 足以给出解析延拓

在 $\mathcal V_{\mathbb C}$ 上使用范数

$$\|X\|_\sharp=\sup_\theta
\|\operatorname{Re}(e^{i\theta}X)\|_1.$$

它在 Hermitian 矩阵上等于迹范数。保 Hermitian 的保迹正映射在 Hermitian 迹范数下收缩，故 $T,A$ 在此复化范数下也收缩。于是

$$\|K(w)\|_\sharp\le\sum_{\ell\ge1}p_\ell|w|^\ell<1
\qquad(|w|<1).$$

因此 $H$ 在开圆盘内解析。$T$ 的幂有界，所以单位圆上的 Jordan 块必为一阶，否则 $T^n$ 会出现多项式增长。其余谱严格位于圆内，允许非平凡 Jordan 块。

Sibuya 系数给出显式矩阵函数

$$M(w)=w g_\gamma(wT),\qquad
g_\gamma(z)=\frac{1-(1-z)^\gamma}{z},\quad g_\gamma(0)=\gamma.$$

因此

$$Z(w)=\sum_{\lambda\in\Lambda}
(1-\lambda w)^{\gamma-1}Q_\lambda+Z_{\rm st}(w),$$

$$M(w)=\sum_{\lambda\in\Lambda}
\lambda^{-1}[1-(1-\lambda w)^\gamma]Q_\lambda+M_{\rm st}(w). \tag{5.1}$$

稳定部分在一个半径大于 $1$ 的圆盘内解析。对稳定 Jordan 块可使用标量解析函数的有限阶导数；零特征值也没有问题，因为 $g_\gamma$ 在零处可去奇。

唯一可能的单位圆分支点是 $\zeta_\lambda=\lambda^{-1}$，以及式 (4.3) 中标量因子引入的 $1$。从每个分支点向径向外侧作切口，式 (5.1) 便延伸到闭单位圆盘周围的切口邻域。由于 $\gamma>0$，$K$ 在分支点有有限且唯一的极限。(W) 使该极限处的 $I-K$ 可逆，故一个足够小的切口邻域内也没有逆矩阵极点。对于圆周上其余点，使用普通解析性和可逆性。由圆周紧致、分支点有限，可选取一个共同的外半径和有限缺口，使 $H$ 在相应区域解析且无额外极点。

这一步提供速率证明真正需要的条件。仅知道逆核系数绝对可和，不能直接推出某个多项式速度。本文使用显式 Sibuya 函数控制圆周外的局部行为。

## 6. 局部展开与慢项消去

固定 $\lambda\in\Lambda$，置 $x=1-\lambda w$。由式 (5.1) 及局部 Neumann 展开，

$$M(w)=M(\lambda^{-1})-\lambda^{-1}Q_\lambda x^\gamma+O(x),$$

$$H(w)=H_\lambda-
\lambda^{-1}H_\lambda AQ_\lambda H_\lambda x^\gamma
+O(|x|^\beta), \tag{6.1}$$

$$Z(w)=x^{\gamma-1}Q_\lambda+G_\lambda(w),$$

其中 $G_\lambda$ 局部解析，$\beta=\min\{2\gamma,1\}$。式 (6.1) 中负号及算子次序来自对 $I-K$ 的逆作展开，不能省略。

### 6.1 点 $w=1$

若 $1\in\Lambda$，代入式 (4.3)，

$$H(w)-H_*=-H_*AQ_1H_*(1-w)^\gamma
+O(|1-w|^\beta).$$

此差分消去了 $(1-w)^{-\gamma}$ 因子所可能带来的慢项。具体地，

$$\widehat E(w)=(1-w)^{\gamma-1}
[Q_1H_*v-Q_1H_*AQ_1H_*b]
+O(|1-w|^{\beta-1}). \tag{6.2}$$

来自 $G_1$ 的项有界，因 $\beta\le1$ 而被余项包含。若 $1\notin\Lambda$，则 $Z,H$ 在 $1$ 附近解析，且 $H(w)-H_*=O(1-w)$；式 (4.3) 的第一项为 $O(|1-w|^{1-\gamma})$，其余项有界，没有式 (6.2) 中的首项。

### 6.2 其他外围点

若 $\lambda\ne1$，标量 $(1-w)^{-\gamma}$ 在 $w=\lambda^{-1}$ 附近解析。将式 (6.1) 代入式 (4.3) 得

$$\widehat E(w)=(1-\lambda w)^{\gamma-1}D_\lambda
+O(|1-\lambda w|^{\beta-1}). \tag{6.3}$$

这里 $D_\lambda$ 正是式 (3.2)。所有外围谱点都被处理，包括不是单位根的相位。共轭谱点的系数成对出现，恢复 Hermitian 的时间域误差。

## 7. 系数提取与余项的完整证明

下面给出本文所需的经典奇点分析估计 [4] 的简短证明，避免把“边界展开”未经论证地当成“系数展开”。

**引理 7.1。** 设 $G$ 在单位圆盘及其外侧的有限缺口区域解析，单位圆上的可能奇点为有限个 $\zeta_j$。若在每个切口端点附近

$$\|G(w)\|\le C_j|1-w/\zeta_j|^{\eta-1},
\qquad0<\eta\le1,$$

则 $\|[w^t]G(w)\|=O((t+1)^{-\eta})$。

**证明。** 在 Cauchy 系数积分中，将轮廓移到圆周外，绕开各个切口。每个端点周围用半径 $1/t$ 的小圆弧及两条朝外射线连接。选择固定的小切口角，使射线上距端点为 $r$ 时有 $|w|\ge1+cr$。于是射线上的积分由

$$C\int_{1/t}^{r_0}e^{-c'tr}r^{\eta-1}\,dr=O(t^{-\eta})$$

控制。小圆弧长度为 $O(1/t)$，函数大小为 $O(t^{1-\eta})$，且 $|w|^{-t-1}$ 有界，故贡献也为 $O(t^{-\eta})$。远离奇点的其余轮廓给指数小项。对有限维矩阵逐坐标应用，再用范数等价，即得结论。此论证包括 $\eta=1$。证毕。

从 $\widehat E(w)$ 减去

$$\sum_{\lambda\in\Lambda}D_\lambda(1-\lambda w)^{\gamma-1}.$$

在每个端点，本地首项由式 (6.2) 或式 (6.3) 消去；其余被减项在该点解析且有界。剩余函数满足引理 7.1 中 $\eta=\beta$ 的条件。又因为

$$[w^t](1-\lambda w)^{\gamma-1}=\lambda^t s_t,$$

故得到式 (3.4)。所有局部常数对初态的依赖均为仿射或线性，而密度矩阵集合紧，故可统一控制初态，完成定理 3.1 的证明。

特别在 $\gamma=1/2$ 时，$\beta=1$，有界的局部余项给出 $O(t^{-1})$ 的系数界。这里没有把解析常数误当成非零 $t^{-1}$ 首项，也没有使用 $1/\Gamma(0)$。

## 8. 非对易、同初态的严格锐例

在一个量子比特上，令 $\sigma_x,\sigma_z$ 为 Pauli 矩阵，$|+\rangle=(|0\rangle+|1\rangle)/\sqrt2$，取

$$\Phi(X)=\sigma_zX\sigma_z,\qquad
R(X)=cX+(1-c)\operatorname{tr}(X)|+\rangle\langle+|,
\quad0<c<1.$$

这两个完整信道不交换：将它们以不同顺序作用于 $I/2$，会分别产生沿 Bloch $x$ 轴正向和负向的偏置。$R$ 也不是完全重置；它保留比例 $c$ 的输入。其无迹线性部分为 $A=cI$，所以 $\|K(w)\|\le c<1$ 对闭单位圆盘成立，保证 (W)。

选择 $\sigma=I/2$。沿 $x$ 方向有 $T=-1$、$b=1-c$，且

$$H_x(w)=\frac1{1+c-c(1+w)^\gamma},\qquad
x_* = \frac{1-c}{1+c-c2^\gamma}.$$

由于分母大于 $1-c>0$，$0<x_*<1$，故 $\rho_{\rm eff}=(I+x_*\sigma_x)/2$ 是合法密度矩阵。现在取 **实际初态恰为 $\rho_{\rm eff}$**，消除双方初态不同造成的瞬态。

式 (3.2) 给出唯一非零首项

$$d_- = \frac{c(2^\gamma-2)x_*}{1+c}<0,$$

$$E_t=s_t(-1)^t d_-\frac{\sigma_x}{2}+O(t^{-\beta}).$$

因为 $\|\sigma_x/2\|_1=1$，

$$\lim_{t\to\infty}t^\gamma\|E_t\|_1
=\frac{c(2-2^\gamma)x_*}{(1+c)\Gamma(1-\gamma)}>0. \tag{8.1}$$

因此不能对整个假设类普遍改进指数 $\gamma$。当 $c=\gamma=1/2$ 时，全部常数化为

$$x_* = \frac{3+\sqrt2}{7},\qquad d_- = \frac{\sqrt2-4}{21},$$

$$\boxed{\lim_{t\to\infty}\sqrt t\,\|E_t\|_1
=\frac{4-\sqrt2}{21\sqrt\pi}>0.} \tag{8.2}$$

## 9. 无收缩历史的例子与计算核验

主定理的假设比“存在严格收缩的事件序列”更一般。一个已有的说明性例子 [2] 是让 $\Phi$ 和 $R$ 分别为 Bloch 球绕 $z$ 轴、$x$ 轴旋转 $\pi/2$ 的幺正信道。任意历史都是幺正变换，不会严格收缩迹距离。

Sibuya 分布对 $L=1,2$ 都有正权重。若 $K(w)v=v$，Hilbert--Schmidt 范数的三角不等式取等要求所有 $w^\ell R\Phi^{\ell-1}v$ 相同。由 $\ell=1,2$ 得到 $Rv=w^{-1}v$ 和 $\Phi v=w^{-1}v$。但这两个四分之一转动没有相同特征值的公共非零无迹特征向量：实轴特征向量分别在 $x,z$ 方向，$\pm i$ 的复特征方向也不重合。因此 (W) 成立，$\rho_{\rm eff}=I/2$，定理直接适用。该例的模型和 (W) 论证已有；本稿核对的是新的速率及首项。

原稿报告的核验分为以下三层，本版本暂未附程序和原始输出：

| 核验 | 实际覆盖 | 不覆盖 |
|---|---|---|
| 标准库 $\mathbb Q(\sqrt2)$ 精确算术 | $t=0,\ldots,48$ 的年龄链、事件更新与生成函数三种实现；合法态、非交换、非零首项；共 1377 项检查 | 一般无限时间极限定理 |
| 非对易锐例直接年龄链 | $\gamma=1/4,1/2,3/4$、$c=1/2$，到 $4096$ 步，核对首项相位及幅度 | 全参数正确性、误差常数的严格包围 |
| 幺正四分之一转动 | 到 $4096$ 步的事件更新；前 $64$ 步另以年龄链比较 | (W) 的一般性证明 |

在 $\gamma=1/2$ 的锐例中，第 $4096$ 步实际误差与首项预测之比为 $0.9998849$。幺正例的两种独立递推在前 $64$ 步最大差为 $1.56\times10^{-17}$。这些数字是实现交叉核验，书面证明负责极限与量词。

## 10. 贡献与限制

本稿候选贡献是：在已有的完整 (W) 下，给出 Sibuya 时钟驱动的**非对易跳跃信道归约误差**的最优 $t^{-\gamma}$ 速率、显式振荡首项和同初态的严格锐例。更新展开、Sibuya 分布、谱投影及 Cauchy 奇点分析都是已有工具。经典算子更新理论还提供保留多项式衰减的逆核估计 [5]；本文不把这些方法作为独立发明。

一个实质相邻的近期结果 [6] 已在连续时间 Prabhakar 时钟、单量子比特纯退相干与固定幺正跳跃的模型中，证明方向传输的 $t^{-\alpha}$ 和 $t^{-1-\alpha}$ 尾部。其第 IV D 节及附录 C6 使用极点与轮廓条件，估计具体响应分量。本文处理离散 Sibuya 时钟、任意有限维 CPTP 信道，在原 (W) 下比较实际态与 $F_t(\rho_{\rm eff})$，并给出完整外围谱首项。因此，非交换量子更新中的幂律响应本身也不属于本稿的首创。

已核查的原稿和相关来源尚未给出同一归约误差的结论；这一判断只针对记录的查新范围，不构成全球优先权证明。原稿 [2] 的非对易归约和等效态概念均保留来源。完整重置的收敛分类及其 Sibuya 速率已有，不属于本稿新增部分。

本文包含书面推导、文献比较和有限计算说明，尚未经过外部同行评议或 Lean 形式化。有限精确计算仅涉及明确列出的恒等式和代数常数。

结果限于有限维、固定信道、独立且与态无关的 Sibuya 间隔及 (W)。没有解决 (W) 失效的完整分类、无限维通道、测量触发时钟、相关间隔或任意正则变换重尾的同强度结论。常数未整理成对所有信道统一的显式有限时间证书，余项指数也不主张处处最优。

## 参考文献

1. S. Wald, L. H. Yao, T. Platini, C. Hooley, F. Carollo. *Stochastic resetting in discrete-time quantum dynamics: steady states and correlations in few-qubit systems*. Quantum **9**, 1742 (2025). [DOI](https://doi.org/10.22331/q-2025-05-13-1742); [官方全文 v3](https://arxiv.org/html/2410.11497v3).
2. Anonymous. *Renewal resetting of quantum dynamics: a classification for complete resets, a reduction for jump channels, and critical time scales*. v1.0.0-candidate, 23 October 2026. 未经外部同行评审的研究稿。[DOI](https://doi.org/10.5281/zenodo.23580221); [固定版本源码](https://github.com/ipitchford/renewal-quantum-resetting-equilibration/blob/e3c77d3055f7b80b4962ccf3024446b3e15993f4/paper/paper.tex); [研究页及开放项](https://evidencepress.org/releases/renewal-quantum-resetting-equilibration/).
3. B. Vacchini. *Quantum renewal processes*. Scientific Reports **10**, 5592 (2020). [DOI](https://doi.org/10.1038/s41598-020-62260-z); [原始预印本](https://arxiv.org/abs/1906.00693).
4. P. Flajolet, A. Odlyzko. *Singularity analysis of generating functions*. SIAM Journal on Discrete Mathematics **3**, 216--240 (1990). [DOI](https://doi.org/10.1137/0403019); [作者托管全文](https://algo.inria.fr/flajolet/Publications/FlOd90b.pdf). 本文所用多端点轮廓是该经典方法的直接应用。
5. S. Gouëzel. *Sharp polynomial estimates for the decay of correlations*. Israel Journal of Mathematics **139**, 29--65 (2004). [DOI](https://doi.org/10.1007/BF02787541); [作者托管全文](https://gouezel.pages.math.cnrs.fr/webpage/articles/decay.pdf). 相关近邻为引理 4.5；本文主证明不依赖该引理。

6. R. U. Erdoğan, F. A. Savacı. *Directional transfer from coherence to longitudinal polarization and algebraic storage in a transmon with Markovian dephasing and a glassy environment: a non-Markovian fractional renewal model*. arXiv:2609.37270v1, 29 September 2026. [版本记录](https://arxiv.org/abs/2609.37270v1); [作者稿 PDF](https://arxiv.org/pdf/2609.37270v1). 实质比较见第 IV D 节式 (96)--(97) 及附录 C6 式 (C37)--(C38)。
