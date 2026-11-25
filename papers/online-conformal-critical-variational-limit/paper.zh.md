# 未知分布临界共形预测的精确渐近变分极限

## 定理

采用 Gui、Barber、Ma 的未知分布在线共形模型、路径约束和最近精确预言机分歧定义，记 $M_T$ 为 $T$ 轮极小极大值。固定 $0<\alpha<1$，$\sigma^2=\alpha(1-\alpha)$。边界为 $L_t=c_-t^{1-\beta_-}$、$U_t=c_+t^{1-\beta_+}$，其中 $c_\pm>0,c_-+c_+\ge1,\min(\beta_-,\beta_+)=1/2,\beta_\pm\le1$。设 $a=-\lim L_t/\sqrt t$，$b=\lim U_t/\sqrt t$，故 $a\le0\le b$ 且 $a<b$。

对 $0<\varepsilon<1$，定义如下连续问题。$W$ 是从时间 $\varepsilon$ 的零值出发的标准布朗运动。令 $\nu$ 是适应的随机有限符号测度，允许在 $\varepsilon$ 处立刻施加控制，满足 $\mathbb E|\nu|([\varepsilon,1])<\infty$。要求

$$
X_s=\sigma W_s+\nu([\varepsilon,s])\in[a\sqrt s,b\sqrt s],
\quad \varepsilon\le s\le1,\quad\text{几乎处处同时成立}.
$$

若 $\nu=v\,ds+\nu^\perp$ 是 Lebesgue 分解，代价为

$$
J_\varepsilon(\nu)=
\mathbb E\left[
\int_\varepsilon^1 g(s,v_s)\,ds+|\nu^\perp|([\varepsilon,1])
\right],
\qquad g(s,v)=\mathbb E|\sigma Z/\sqrt s-v|,\quad Z\sim N(0,1).
$$

记 $V_\varepsilon$ 为可行控制的代价下确界。可以对任意保持布朗运动性质的滤过取下确界，也可以只用布朗运动自己的通常滤过，两者相等。

则极限存在，且

$$
\lim_{T\to\infty}\frac{M_T}{\sqrt T}
=\lim_{\varepsilon\downarrow0} V_\varepsilon.
$$

这给出临界未知分布最优系数的连续变分刻画，包含奇异反射控制。该值可结合[联合下界](../online-conformal-minimax-dp/paper.zh.md)与[向内反馈上界](../online-conformal-minimax-feedback/paper.zh.md)夹估，其具体求值仍待完成。

## 1. 有限时域及固定窗口

使用[精确秩递推](../online-conformal-minimax-dp/paper.zh.md)。时点 $t$ 选择 $k_t\in\{0,\ldots,t\}$，下一漏报位条件于秩历史为 Bernoulli($p_t$)，$p_t=k_t/t$。阶段成本为 $\psi_t(k)=t^{-1}\mathbb E|\operatorname{Bin}(t,\alpha)-k|$，只允许有正概率的所有下一计数仍可行。此有限问题的最小值覆盖原模型全部确定性可测策略。

取 $r=\lfloor\varepsilon T\rfloor$。令 $M_T^\varepsilon$ 为从最接近 $\alpha r$ 的可行整数计数开始，仅在 $r+1,\dots,T$ 最小化上述代价。初始计数相差 $d$ 时，任一时域的最优值相差至多 $d$。证明以同一新增秩模拟两条路径，按第一条的位行动，只有不可行时才更正；纠正次数逐路径至多 $d$，而每轮代价差不超过相应的纠正概率。

前 $r$ 轮存在花费 $O(\sqrt r)$ 的可行算法，例如截断分位数秩算法。其精确平方根上界已由原文定理 2.2 给出。任何合法的第 $r$ 轮计数与上述中央初值相差 $O(\sqrt r+1)$，常数与 $r,T,\varepsilon$ 无关。因此

$$
|M_T-M_T^\varepsilon|\le O(\sqrt{\varepsilon T}+1).
$$

下面证明对每个固定 $\varepsilon$，$M_T^\varepsilon/\sqrt T\to V_\varepsilon$。

## 2. 紧性、因果性与下半连续性

对一个近似最优的离散策略，用独立均匀数 $U_t$ 产生位 $A_t=\mathbf1\{U_t\le p_t\}$。令 $B_t=\mathbf1\{U_t\le\alpha\}$。一般秩策略若依赖排列，可取最优的计数反馈并由这些均匀数实现。取

$$
\nu_T=\sum_{t=r+1}^T \frac{p_t-\alpha}{\sqrt T}\,\delta_{t/T}.
$$

分解成正负部分。由 $\psi_t(k_t)\ge |p_t-\alpha|$ 和 $O(\sqrt T)$ 的可行后缀代价，$\mathbb E|\nu_T|([\varepsilon,1])$ 一致有界。可行后缀代价的界也可直接用秩基线，因为相同动作的截断具有 $O(\sqrt T)$ 学习和纠正成本，与任意初值之差受第 1 节的计数稳定性控制。

正负测度在紧时间区间的弱拓扑中各自紧。由 Donsker 定理，基准步函数 $T^{-1/2}\sum_{r<t\le sT}(B_t-\alpha)$ 在连续极限下趋于 $\sigma W_s$。联合变量沿子序列收敛到 $(\sigma W,\nu^+,\nu^-)$，记 $\nu=\nu^+-\nu^-$。$A_t-p_t-(B_t-\alpha)$ 是条件方差不超过 $|p_t-\alpha|$ 的鞅差。Doob 不等式使其缩放累计量的一致均方误差不超过 $O(T^{-1/2})$。所以归一化计数状态等于中央初值 $o(1)$、该布朗近似及 $\nu_T$ 累积量之和，再加一致趋零的随机误差。

极限的因果性可在一组稠密确定性时点验证。这些时点选为 $\nu^+,\nu^-$ 几乎必无原子的位置；例外集至多可数，因为两测度的期望总质量有限。对每个这样的时点 $s$，离散的基准路径与控制测度截至 $s$ 的有限维坐标都由 $U_t$ 中 $t\le sT$ 的部分确定，因此独立于此后的基准增量。利用无原子时点上的弱收敛将这条独立性传至极限。有限维坐标生成历史信息，沿稠密无原子时点从右逼近任意 $s$，使 $W$ 仍是相对于由 $W,\nu^+,\nu^-$ 的历史生成的通常滤过的布朗运动。累积控制适应于此滤过。离散路径约束也通过该稠密集上的收敛传给 $X_s$，再利用右连续性扩展至所有 $s<1$。在 $s=1$ 用弱测度收敛下总质量的收敛。整数取整误差及快速一侧的缩放误差均一致趋零。若 $r/T<\varepsilon$，可将单个最先或最后邻接步的时间戳裁至 $\varepsilon$ 或 $1$，不改变极限。

令 $\mu_T$ 为每条样本路径上以动作 $k_t$ 计算的离散阶段损失之和，除以 $\sqrt T$。一阶 Wasserstein 中心极限定理和 $s\ge\varepsilon$ 给出一致近似

$$
\mu_T=
\frac1T\sum_{t=r+1}^T g(t/T,\sqrt T(p_t-\alpha))+o(1),
$$

其中误差对所有动作一致。令 $g^*(s,q)=\sup_v[qv-g(s,v)]$。对 $|q|<1$，其显式表达为 $-2\sigma s^{-1/2}\varphi(\Phi^{-1}((1+q)/2))$，其中 $\Phi,\varphi$ 为标准正态分布函数和密度。将 $q=\pm1$ 的值取为零，使之在 $[\varepsilon,1]\times[-1,1]$ 连续。对任意连续测试函数 $q\colon[\varepsilon,1]\to[-1,1]$，Fenchel 不等式给出路径下界

$$
\mu_T\ \ge\
\int q\,d\nu_T-\frac1T\sum_{t=r+1}^T g^*(t/T,q(t/T))+o(1).
$$

在采用联合弱收敛的 Skorokhod 表示逐路径传至极限后，对可数一致稠密的测试函数族取上确界。该上确界为

$$
\int_\varepsilon^1 g(s,v_s)\,ds+|\nu^\perp|([\varepsilon,1]).
$$

上界直接由 Fenchel 不等式和 $|q|\le1$ 得到。下界先用可测测试函数：在 Lebesgue 绝对连续部分选择 $g$ 在 $v_s$ 的斜率，在奇异支撑处选择奇异测度的符号。再用连续有界函数在 $ds+|\nu|$ 下逼近，$g^*$ 在紧域的一致连续性使积分收敛。Fatou 引理和 $\mu_T\ge0$ 完成 $\liminf M_T^\varepsilon/\sqrt T\ge V_\varepsilon$。

## 3. 反射变差与因果平滑

使用以下一维反射事实。对连续输入 $y$ 和带宽统一正的连续区间 $[l(s),u(s)]$，写最小反射调整 $k$，令 $y+k$ 可行。则对任意可行有限变差调整 $q$，$\mathrm{TV}(k)\le\mathrm{TV}(q)$，同取修正初值零或计入初始原子。证明是在细分网格每个时点把上次修正投影到 $[l(s)-y(s),u(s)-y(s)]$。任意合法 $q$ 的采样值是对照；一维线段加法给出逐步贪心总变差最小。将步函数输入和区间传到连续反射用 Burdzy–Kang–Ramanan 定理 2.6，再由总变差的下半连续性得界。

还需：

1. 若 $\operatorname{dist}(y(s),[l(s),u(s)])\le\delta$ 一致，则 $\|k\|_\infty\le\delta$。由该文显式 sup–inf 公式得到，因 $y-u\le\delta$ 与 $y-l\ge-\delta$。
2. 若连续趋近下，反射输入与边界一致趋于具有正间隔的连续极限，则反射调整总变差也收敛。这同样适用于前述离散投影的步函数输入。先由反射连续性知输出与净调整一致趋近。正负调整仅分别在下、上边界发生。因极限输出和边界连续、间隔正，充分靠近后每次相反方向之间有统一正的时间间隔，因此净调整分成有统一数量上界的单调块。其变差上界可由极限路径在这些块的端点分割所给的变差及一致误差控制。下界是总变差的下半连续性。

任取固定窗口上的可行 $\nu$ 与布朗路径。将 $s<\varepsilon$ 时的 $W,\nu,X$ 延伸为零。用单侧卷积

$$
v_h(s)=h^{-1}\nu((s-h,s]),\qquad
Y_h(s)=\sigma W_s+\int_\varepsilon^s v_h(u)\,du.
$$

因果性显然。将 $Y_h$ 写成过去 $h$ 窗口内的可行 $X$ 的平均，再加 $\sigma(W_s-\text{过去 }W\text{ 平均})$。由于物理时间走廊嵌套扩大，过去状态的平均在当前区间内。因此 $Y_h$ 偏离走廊最多是 $\sigma\omega_W(h)$。反射 $k_h$ 的一致范数也有相同界。

这里还要证明 $\mathrm{TV}(k_h)\to0$，仅有一致小不足。每次纠正从一侧变到另一侧，受限状态必须横跨宽度至少 $d=(b-a)\sqrt\varepsilon$。因 $\|k_h\|_\infty\to0$，充分小的 $h$ 下，未反射输入在这些时刻相差至少 $3d/4$。取一个布朗模度时间尺度 $\delta$，区间小于 $\delta$ 时布朗增量不超过 $d/4$。相反方向的纠正若相距不超过 $\delta$，累积平滑漂移必须变动至少 $d/2$。因平滑累积漂移总变差至多 $|\nu|([\varepsilon,1])$，这种转换数量一致有界。其余转换每次用时至少 $\delta$，数量也有界。故调整的总变差不超过单调划分的统一块数乘以 $2\|k_h\|_\infty$，逐路径趋零。

设 $k^0$ 是布朗输入独自反射的调整。以 $k^0-\int v_h\,ds$ 为合法对照，得 $\mathrm{TV}(k_h)\le\mathrm{TV}(k^0)+|\nu|([\varepsilon,1])$。右侧可积。对 $k^0$，在区间中点为中心对反射布朗状态平方使用 Itô 公式，边界项恰为负的区间宽度乘纠正总变差。宽度有正下界、中点导数有界、布朗积分有界二阶矩，故 $\mathbb E\mathrm{TV}(k^0)<\infty$。因此 $\mathbb E\mathrm{TV}(k_h)\to0$。

卷积的成本不比 $J_\varepsilon(\nu)$ 大到不可忽略的程度。先分离绝对连续和奇异部分。对绝对连续部分用凸性和移动平均 Jensen，并用 $g$ 在时间 $s\in[\varepsilon,1]$ 的连续性对 $v$ 一致；短初始区间上的零延伸误差为 $O(h)$。对奇异部分，用 $g$ 关于 $v$ 的 1-Lipschitz 性和卷积的 $L^1(ds)$ 范数不超过 $|\nu^\perp|$。因此 $v_h$ 加其最小反射的代价上极限至多 $J_\varepsilon(\nu)$。

对于任意两个常规漂移 $v,v'$，其最小反射代价绝对差不超过 $\int|v-v'|\,ds$。理由是可用原反射加上两漂移累计差作为对照调整，再交换两漂移。背景积分代价也 1-Lipschitz。故可截断平滑漂移，再在 $L^1(ds\,dP)$ 逼近，而总连续代价误差不超过两倍逼近误差。

## 4. 由布朗历史实现有界近似

要确保可离散实施，可先将控制改为布朗运动自身滤过上的强适应控制。给定整条布朗路径，对 $\nu$ 取条件期望有限符号测度，记 $\bar\nu$。该条件测度可在弱拓扑的正负测度空间由正则条件分布构造。对任意确定性 $s$，$\nu([\varepsilon,s])$ 是原滤过的 $\mathcal F_s$-可测函数，未来布朗增量独立于 $\mathcal F_s$。故 $\bar\nu([\varepsilon,s])$ 等于给定截至 $s$ 的布朗历史的条件期望。取可数稠密集并用布朗通常滤过右连续性得到整条累积过程适应。因走廊为闭凸区间，原可行状态取条件期望后仍可行；在可数稠密集同时实现，再传到所有时间，端点直接核对。由第 2 节中以连续测试函数的可数上确界所写出的凸代价泛函，条件 Jensen 给出 $J_\varepsilon(\bar\nu)\le J_\varepsilon(\nu)$。

因此在第 3 节平滑并截断后，只需处理由布朗历史决定的有界漂移。平滑 $v_h$ 有右连续左极限路径。截断后可按确定性网格用每个区间左端值逼近，在 $ds\,dP$ 下有界收敛。对网格左端的有界布朗历史随机变量，用其过去有限个确定性采样值的有界连续函数在 $L^1(dP)$ 中近似。可由生成历史的可数采样、条件期望收敛以及有限维分布上的连续函数稠密性得出。这样得到有界、分段常值、以过去有限个布朗采样作连续反馈的常规漂移。反射和背景代价的 $2L^1$ 界保证此类控制配最小反射已充分逼近 $V_\varepsilon$。

## 5. 离散恢复

固定一个上述有界的分段漂移 $v$。在离散模型中，用附属独立均匀数模拟秩输入。以 $B_t=\mathbf1\{U_t\le\alpha\}$ 得到基准像素化布朗路径，以相同的采样和连续函数算 $v_t$，并选择原始秩阈值最接近 $\alpha t+t v_t/\sqrt T$。投影超界计数等价于强制位，保证路径可行。该模拟可额外使用历史均匀数。由于有限 Bellman 值是在每步对相同的动作集合取最小，一个附属历史随机化策略的成本始终给出 Bellman 值的上界，无需把该随机化增入原统计模型。按网格向下取整，使每个决策只用已观测的辅助均匀数。

条件于过去，$p_t-\alpha=v_t/\sqrt T+O(1/t)$，且固定窗口内界一致。将共享均匀数的原始位 $B_t^0$ 与 $B_t$ 比较，二者中心化噪声累积的归一化差依 Doob 估计一致趋零。Donsker 和连续圆柱反馈给出原始驱动路径到连续 $W+\int v$ 的弱收敛。投影在正宽度走廊内使反射输出与净修正路径一起收敛。由第 3 节的变差连续性，离散纠正数除以 $\sqrt T$ 依分布收敛到反射净修正的总变差。

这里还需要一致可积性。在固定窗口，走廊宽度至少 $c_\varepsilon\sqrt T$，中点增量为 $O_\varepsilon(T^{-1/2})$。设 $H_t$ 是距走廊中点的实际状态。平方差分解分离出控制纠正项和原始位噪声。每次实际纠正让平方差减少至少 $(D_t-1)$ 乘纠正指示；拟议漂移项、中点漂移项和一步方差项统一 $O_\varepsilon(1)$。居中噪声项是形如 $Q_t(B_t^0-p_t)$ 的鞅差，$Q_t=O_\varepsilon(\sqrt T)$。总和之后得到

$$
c_\varepsilon\sqrt T\,N_T \le O_\varepsilon(T)
+\sum_{t=r+1}^T Q_t(B_t^0-p_t),
$$

其中 $N_T$ 是实际纠正次数。平方后用鞅正交，得到 $\sup_T\mathbb E(N_T/\sqrt T)^2<\infty$。故纠正代价的期望也收敛。

常规的秩代价全部除以 $\sqrt T$ 后，由二项的一阶 Wasserstein 极限和插值 Riemann 和趋于 $\mathbb E\int_\varepsilon^1 g(s,v(s))\,ds$。强制时的实际阶段成本与“常规背景成本加实际纠正的条件概率”仅相差 $O_\varepsilon(T^{-1/2})$。固定窗口内，充分大 $T$ 时每次强制的条件纠正概率至少正的常数，故强制轮数的期望为 $O_\varepsilon(\sqrt T)$，上述误差函数经归一化后趋零。综上，恢复策略的代价趋于背景成本加反射变差。这给出 $\limsup M_T^\varepsilon/\sqrt T\le V_\varepsilon$。

## 6. 去除初始截断

对每个固定 $\varepsilon$，以上给出精确后缀极限。第 1 节的 $O(\sqrt\varepsilon)$ 比较界对所有小 $\varepsilon$ 都用相同的常数。因此 $M_T/\sqrt T$ 的上、下极限差不超过 $O(\sqrt\varepsilon)$，令 $\varepsilon\downarrow0$ 后相同。相同的比较同时给出 $V_\varepsilon$ 趋于该值。

## 文献与验证范围

- Yu Gui、Rina Foygel Barber、Cong Ma, [The cost of enforcing long-run coverage: a phase transition in online conformal prediction](https://arxiv.org/pdf/2611.21542v1)，原问题、截断上界及精确秩递推的最近预言机与秩归约输入。
- Krzysztof Burdzy、Weining Kang、Kavita Ramanan, [The Skorokhod problem in a time-dependent interval](https://arxiv.org/pdf/0712.2863)，定理 2.6、命题 2.9 与式 (2.12)，得到离散投影和反射映射的一致连续性。
- 独立内部复核检查了随机测度极限中的滤过及恢复近似。变分值的具体求解另列为开放问题。
