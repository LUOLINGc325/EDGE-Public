# 固定双边覆盖约束下的精确在线预言机分歧率

研究稿 · 2026-11-24 · 目标读者为统计学博士研究生。

## 通俗摘要

想让在线预测系统在**每个**时刻离目标覆盖率都很近，可以限制累计漏报次数在一条窄走廊内。即使知道真实分布，随机漏报也会触碰边界，迫使系统修改预测。这里给出这种修改的精确长期成本。目标漏报率为一半、允许累计偏差不超过 $\kappa$ 时，每轮最优分歧率是 $1/(4\lfloor2\kappa\rfloor)$。成本会随容许偏差呈台阶式下降。其他目标漏报率由一个有限状态递推决定，任意精度均可逼近。

## 问题和主结论

Gui、Barber 和 Ma [1] §1.4 的核心问题要求算法满足逐路径逐前缀的覆盖约束，并最小化 i.i.d. 情况下与精确预言机的累计分歧。其式 (20) 给出增长阶，固定宽度端点 $\beta=1$ 的代价为 $\Theta(T)$。本文在该端点求精确线性系数。

固定 $0<\alpha<1$、$L,U>0$ 及 $L+U\ge1$。对每个数据序列及每个整数 $t\ge1$，要求算法漏报指示 $e_t$ 满足

$$
-L\le \sum_{r=1}^t e_r-\alpha t\le U.
$$

采用 [1] §2 的可测在线预测器、固定可测评分、任意评分无原子的 i.i.d. 法类 $\mathcal Q$ 以及全部精确预言机 $\mathcal O_\alpha(P)$。精确性指给定过去，漏报的条件概率恒等于 $\alpha$。损失为 $D_T(e,e^*)=\sum_{t\le T}|e_t-e_t^*|$。假设 $\mathcal Q$ 非空。记 $M_T$ 为对满足覆盖约束且不依赖 $P$ 的预测器取下确界、对 $P\in\mathcal Q$ 取上确界、对 $\mathcal O_\alpha(P)$ 取下确界的预期损失。

**定理。** 对输入 $B_t$ 独立同分布且服从 $\operatorname{Bernoulli}(\alpha)$，置 $K_0=0$ 并定义

$$
a_t=\lceil\alpha t-L\rceil,\quad z_t=\lfloor\alpha t+U\rfloor,\quad
K_t=\min(z_t,\max(a_t,K_{t-1}+B_t)).
$$

令 $V_T=\mathbb E\sum_{t=1}^T|K_t-K_{t-1}-B_t|$。对已知 $P$ 的问题，精确最小风险为 $V_T$，且该值对所有 $P\in\mathcal Q$ 相同。对未知分布的原问题，

$$
V_T\le M_T\le V_T+O(\sqrt T).
$$

存在可计算的常数 $c(\alpha,L,U)=\lim_{T\to\infty}V_T/T$。若 $\alpha=p/q$ 为既约分数，$c$ 由 $q$ 个有限状态转移与一个有理线性方程组精确给出。若 $\alpha$ 无理，$c$ 是一个黎曼可积函数的积分，下文给出带几何误差的逼近。特别地，

$$
c(1/2,\kappa,\kappa)=\frac{1}{4\lfloor2\kappa\rfloor}
\qquad(\kappa\ge1/2).
$$

## 逐路径最优性

截断计数经过重心平移后属于一维 play operator 的最小总变差框架 [3, 5]。这里直接给出离散情形的证明，以说明该框架如何识别原统计损失。

把预言机的漏报位暂看作任意二进制串 $b$，累计计数记为 $O_t$。设 $K_t$ 是用 $b$ 替换定理中的 $B$ 后的截断计数。区间 $[a_t,z_t]$ 含整数，且 $z_t\ge z_{t-1}$ 和 $a_t\le a_{t-1}+1$。令 $a_0=\lceil-L\rceil,z_0=\lfloor U\rfloor$，则 $0\in[a_0,z_0]$。从一个可行计数出发，截断总给出二进制增量，并可在线实现。在两种增量都可行时输出原预测集。只有一种增量可行时输出全空间或空集。

将计数减去原输入累计和，令 $r_t=K_t-O_t$，则 $r_t$ 是把 $r_{t-1}$ 投影至 $J_t=[a_t-O_t,z_t-O_t]$ 所得。任意可行二进制输出的计数 $K'_t$ 对应 $q_t=K'_t-O_t\in J_t$。一维投影位于 $r_{t-1}$ 与 $q_t$ 之间，所以

$$
|r_t-r_{t-1}|+|r_t-q_t|=|r_{t-1}-q_t|
\le |r_{t-1}-q_{t-1}|+|q_t-q_{t-1}|.
$$

从共同初值零求和得到

$$
D_T(\Gamma b,b)+|K_T-K'_T|\le D_T(e',b),
$$

其中 $\Gamma b$ 为截断输出，$e'$ 为对照输出的增量。该界也适用于可查看整条输入串的对照者。这里仅用一维投影的线段恒等式，覆盖不限于固定宽度，只要求整数走廊具有上述可行转移性质。

精确预言机的漏报位为独立 Bernoulli 串，因为每一位给定过去的条件概率恒为 $\alpha$，且过去漏报位由过去观测确定。因此对任何可行预测器和任何精确预言机，逐路径不等式给出期望下界 $V_T$。若 $P$ 已知，用一个精确预言机作为截断输入即可达到下界。评分分布无原子时，固定总体评分分位数提供这样一个预言机。

## 未知分布的同一线性常数

令 $C^0$ 以过去 $t-1$ 个评分的经验分位数为阈值，选择秩 $k_t=\lceil(1-\alpha)t\rceil$，并把秩 $t$ 解释为 $+\infty$。令 $C^*$ 使用总体 $(1-\alpha)$ 分位数。条件于过去，两预测器的套叠评分集的分歧概率为二者阈值对应 CDF 值的绝对差。阈值对应 CDF 值是均匀样本的第 $k_t$ 顺序统计量。其均值为 $k_t/t$，方差不超过 $1/[4(t+1)]$。若 $k_t=t$，CDF 值是常数 $1$，同样的均值、方差界成立。这也涵盖首轮。因此累计预期分歧至多

$$
\sum_{t=1}^T\left(\frac1t+\frac{1}{2\sqrt{t+1}}\right)=O(\sqrt T),
$$

且常数对 $P$ 一致。两条输入二进制串若只在一位不同，截断计数在该位产生至多一单位差。此后区间投影保序且不扩张，差值只能保持或回到零。所以两条截断输出最多在两位不同。逐位替换给出 $D_T(\Gamma b,\Gamma b')\le2D_T(b,b')$，即 [1] 式 (41)。据此，$\Gamma C^0$ 与 $C^*$ 的期望分歧至多 $V_T+2\mathbb ED_T(C^0,C^*)$。该算法逐路径满足约束，对每个 $P$ 选上述总体预言机即得定理上界。

## 固定宽度下的极限与计算

令相位 $x_t=\{\alpha t\}$，整数状态 $j_t=K_t-\lfloor\alpha t\rfloor$。给定连续两轮相位，转移是

$$
j_t=\operatorname{clip}
\bigl(j_{t-1}+B_t-\lfloor x_{t-1}+\alpha\rfloor,\,
[\lceil x_t-L\rceil,\lfloor x_t+U\rfloor]\bigr),
\qquad x_t=\{x_{t-1}+\alpha\}.
$$

一步成本是输出增量与 $B_t$ 的绝对差。状态取值有界，且相位和初始可行状态给定后可用有限状态前向概率递推求期望成本。

取整数 $Q\ge(L+U)/\alpha$。对一起使用相同输入的任意两个可行计数，在一段连续 $Q$ 个零位后，两者必重合。因为零输入时计数只在下界抬高时增加，端点均在非减方向移动，故经过 $Q$ 轮的计数为 $\max(K_r,a_{r+Q})$。由 $\alpha Q\ge L+U$，$a_{r+Q}\ge z_r$。这一论证对任意起始相位成立。令 $\rho=(1-\alpha)^Q>0$。用独立的长度 $Q$ 块，任意两可行初始状态经过 $m-1$ 步仍未相遇的概率至多 $(1-\rho)^{\lfloor(m-1)/Q\rfloor}$。

定义 $g_m(x)$ 为末轮相位为 $x$ 时，向前回溯 $m$ 步，从那时的下端点出发，执行 $m$ 轮递推得到的末轮期望成本。相位按旋转倒推，故这是确定的函数。对于 $n>m$，在较短回溯起点上两算法处于可行状态。共享最后 $m$ 轮输入，上述界给出

$$
\sup_x |g_n(x)-g_m(x)|\le (1-\rho)^{\lfloor(m-1)/Q\rfloor}.
$$

故 $g_m$ 一致收敛至 $g$，并具有同样的尾误差界。固定 $m$ 时，只有有限个取整跳点和相位折点，$g_m$ 分段常值并保留跳点的实际值。因此 $g$ 黎曼可积。实际从 $K_0=0$ 出发的末轮期望成本与 $g(x_t)$ 的偏差至多 $2(1-\rho)^{\lfloor(t-1)/Q\rfloor}$。该偏差可求和，对长期均值无贡献。

由有理旋转的周期性和无理旋转的等分布定理 [4]，

$$
c(\alpha,L,U)=
\begin{cases}
q^{-1}\sum_{j=0}^{q-1}g(j/q),&\alpha=p/q,\\
\int_0^1 g(x)\,dx,&\alpha\notin\mathbb Q.
\end{cases}
$$

在有理情形，固定相位每 $q$ 轮返回。上面的统一耦合说明 $q$ 步转移矩阵只可能有一个平稳分布。有限状态保证存在性。各转移概率在有理数域内，因此解平稳方程及归一化方程可得精确的有理常数。无理情形下用 $g_m$ 的分段积分及几何误差控制。此计算说明以取整和相位比较可精确获得的数作为输入。对于仅以有限精度给出且恰在跳点上的阈值，不能用舍入值替代真实参数。

## 宽度恰为一时的算术效应

若 $L+U=1$，除 $\alpha t-L\in\mathbb Z$ 的时刻外，允许区间仅含一个整数。一直取下端点 $a_t$ 是可行的确定性比较序列，其输出的 1 的比例趋于 $\alpha$，故平均分歧趋于 $2\alpha(1-\alpha)$。每个恰有两个整数可选的时刻 $t$ 与其下一轮成对分析。这样的两轮窗口互不重叠，因为 $0<\alpha<1$。若 $a_t=a$，前一轮和后一轮的唯一计数分别为 $a$ 和 $a+1$。基线两轮固定增量为 $0,1$，期望分歧为 $1$。截断第一轮跟随 $B_t$，下一轮输出 $1-B_t$，期望分歧为 $\alpha^2+(1-\alpha)^2$。所以每个两值时刻恰节省 $2\alpha(1-\alpha)$，末轮未成对时只引入有界差额。记这些时刻的渐近频率为 $\lambda$，则

$$
c(\alpha,L,1-L)=2\alpha(1-\alpha)(1-\lambda),\qquad
\lambda=\begin{cases}
1/q,&\alpha=p/q\text{ 既约且 }qL\in\mathbb Z,\\
0,&\text{其它情形}.
\end{cases}
$$

无理 $\alpha$ 下等式 $\alpha t-L\in\mathbb Z$ 最多发生一次。有理 $\alpha$ 下，余数每 $q$ 轮遍历完整周期。这说明离散门槛会直接影响最优常数。例如 $L=U=1/2$ 时，所有无理 $\alpha$ 的极限为 $2\alpha(1-\alpha)$，而 $\alpha=1/2$ 处的值为 $1/4$。

## 对称半覆盖率的闭式

取 $\alpha=1/2$、$L=U=\kappa$，并令 $m=\lfloor2\kappa\rfloor\ge1$。整数状态 $2K_t-t$ 在 $[-m,m]$ 上行走。从内点以相同概率向左右移动一格，从端点必向内移动。一轮分歧恰为处于端点且 Bernoulli 输入试图向外，条件概率 $1/2$。该有限不可约随机游走的平稳权重与路径图结点度数成正比，两个端点的总权重为 $1/(2m)$。链的周期是二，Cesàro 占用平均仍收敛至平稳权重，从而得到 $c=1/(4m)$。例如 $\kappa=1/2$ 和 $\kappa=3/4$ 都有 $c=1/4$，$\kappa=1$ 则有 $c=1/8$。

## 参考文献

1. Yu Gui、Rina Foygel Barber、Cong Ma，*The cost of enforcing long-run coverage: a phase transition in online conformal prediction*，arXiv:2611.21542v1，§1.4、§2.2、附录 A.1 和 C.2。https://arxiv.org/abs/2611.21542v1
2. Mingrui Liu，*The Price of Hard Coverage Constraints in Online Conformal Prediction*，arXiv:2611.22646v1，§3–4。https://arxiv.org/abs/2611.22646v1
3. Krzysztof Burdzy、Weining Kang、Kavita Ramanan，*The Skorokhod problem in a time-dependent interval*，*Stochastic Processes and their Applications* 119 (2009), 428–452。https://arxiv.org/abs/0712.2863
4. L. Kuipers、H. Niederreiter，*Uniform Distribution of Sequences*，Wiley 1974，Chapter 1。https://books.google.com/books?id=oaZZyQEACAAJ
5. Rafał Łochowski、Raouf Ghomrasni，*The play operator, the truncated variation and the generalisation of the Jordan decomposition*，*Mathematical Methods in the Applied Sciences* 38 (2015), 403–419。https://doi.org/10.1002/mma.3077
