# 风险敏感一次在线卖出的精确最优值

**全部最优阈值分布、稳定性与相变系数**

AI 辅助研究稿 · 2026-11-24 · 目标读者：算法、概率与在线决策方向研究生

## 摘要

面对不断到来的报价，一个卖方只能成交一次，也不知道报价何时结束。随机策略可以改善平均收益，但最差的一部分随机结果可能仍然很差。本文研究以收益下尾条件风险价值（CVaR）评价算法时，最优竞争比究竟是多少。

Christianson、Sun、Low 与 Wierman 已给出一个由延迟微分方程描述的候选策略，但原文没有证明其在全部风险参数下最优。我们证明：任意阈值分布的分位函数都受一个延迟积分上包络控制；再独立使用最高报价处的约束，得到与原策略完全匹配的下界。有限递增报价前缀的耦合把该下界推广到所有允许依赖历史的随机在线算法。

进一步，我们刻画全部最优阈值分布，给出最大阈值最小的压缩策略、近最优策略的积分亏损界，以及风险中性端点的一阶展开与相变点的二次展开。随机化收益在风险临界点前按二次速度消失。所有陈述保留原论文的未知时长、未成交按最低价结算和风险取自算法内部随机性的模型。一般定理依靠书面证明，有限计算用于独立核验；本稿不构成外部同行评议或 Lean 认证。

## 1. 原问题与贡献范围

本文固定 [1] 第 2.3 节的一次在线卖出模型，并解决其第 5 节定理 12 之后留下的候选策略最优性问题。已知价格区间为 $[L,U]$，其中 $0<L\le U$。对手预先选择一个非空有限报价序列，不能观察算法的随机种子。算法依次观察报价，可以接受其中一个报价并永久停止；序列长度事先未知。若序列结束时还没有接受任何报价，最终收益为 $L$。

特别地，算法不会在最后一个报价出现时收到“这是最后一笔”的提醒，未成交时也不按最后一个报价结算。改变这些条件就会改变本文的问题。

候选延迟方程、其有限级数表示、风险中性端点和风险阈值 $1/2$ 均来自 [1]。本文新增部分是：对全部风险参数的匹配下界、全部最优阈值分布的刻画、压缩与稳定性结论，以及精确的展开系数。本文没有把已有候选算法重新归为自己的发明。

近邻 [2] 研究带预测的算法：风险由预测所描述的输入分布产生，并在给定鲁棒性限制下选择确定阈值。[3] 研究预测误差、鲁棒性和光滑性的关系；[4] 在固定预测下优化一致性与鲁棒性的关系。这些工作与本文对固定输入序列、跨算法内部随机性计算 CVaR 的优化问题不同。查新结论仅限于已查阅文献的范围。

## 2. 模型、记号与主定理

对有界收益随机变量 $Y$，记其广义分位函数为 $Q_Y$。风险参数为 $\delta\in[0,1)$，置 $h=1-\delta$，定义

$$
\mathcal R_\delta(Y)=\frac1h\int_0^h Q_Y(s)\,ds.
\tag{1}
$$

它是收益最差的 $h$ 比例结果的平均值；遇到概率原子时，允许只取该原子的一部分。在 $\delta=1$ 时定义 $\mathcal R_1(Y)=\operatorname{ess\,inf}Y$。这一风险泛函满足单调性、平移等变性和正齐次性。

算法 $A$ 的竞争比为

$$
C_\delta(A)=\sup_\sigma
\frac{\max\sigma}{\mathcal R_\delta(A(\sigma))}.
\tag{2}
$$

分子是事后知道全部报价时能取得的最好收益。分母是该固定报价序列下，算法自身随机收益的下尾均值。竞争比越小越好。

除以 $L$ 后可以假设 $L=1$，并记 $\theta=U/L$。当 $\theta=1$ 时最优值显然为 $1$，以下主要考虑 $\theta>1$。

**定理 1（全参数精确最优值）。** 对 $0\le\delta<1$、$a\ge1$，令 $\phi_{a,\delta}$ 为

$$
\phi_{a,\delta}(t)=a\left[
1+\frac1h\int_0^{(t-\delta)_+}
\bigl(\phi_{a,\delta}(s)-1\bigr)\,ds
\right],\qquad 0\le t\le1
\tag{3}
$$

的连续解。方程 $\phi_{a,\delta}(1)=\theta$ 有唯一解 $a=a_\delta(\theta)>1$，且

$$
\inf_A C_\delta(A)=a_\delta(\theta).
\tag{4}
$$

这里的下确界遍历原模型中的全部随机在线算法，包括依赖观察历史的算法。以 $\phi_{a_\delta,\delta}$ 为分位函数抽取随机阈值，接受第一个达到阈值的报价，即可达到该值。

当 $0<\delta<1$ 时，最优值等价于下面有限多项式方程的唯一 $a>1$ 根：

$$
\theta=1+(a-1)\sum_{j\ge0}
\frac{a^j(1-j\delta)_+^j}{(1-\delta)^j j!}.
\tag{5}
$$

$j=0$ 项按定义为 $1$；$j\ge1$ 且 $j\delta\ge1$ 的项为零。在 $\delta=0$ 时，方程变为 $(a-1)e^a=\theta-1$。在 $1/2\le\delta\le1$ 时，最优值为 $\sqrt\theta$；在 $0\le\delta<1/2$ 时严格小于 $\sqrt\theta$。

## 3. 任意阈值分布的精确风险表达式

设 $X$ 是 $[1,\theta]$ 上任意随机阈值，分布函数为 $F$，广义分位函数为

$$
q(t)=\inf\{x\in[1,\theta]:F(x)\ge t\},
\qquad 0<t\le1.
\tag{6}
$$

$q(0)$ 的取值不影响积分。这里不要求密度存在，允许原子、支撑中的空隙和奇异连续分布。

对 $v\in[1,\theta]$，定义基准收益

$$
Y_v=X\mathbf1_{\{X\le v\}}+
\mathbf1_{\{X>v\}},\qquad
R(v)=\mathcal R_\delta(Y_v).
\tag{7}
$$

**引理 2（阈值策略的精确竞争比）。**

$$
C_\delta(X)=\sup_{1\le v\le\theta}\frac{v}{R(v)}.
\tag{8}
$$

证明：对最大报价为 $v$ 的任意输入，使用相同阈值耦合时，实际收益至少为 $Y_v$。若 $X\le v$，算法必在某个不低于阈值的报价处成交；若 $X>v$，收益为 $1$。风险泛函的单调性给出式 (8) 的上界方向。

反之，固定 $v$，取从 $1$ 递增到 $v$、包含 $v$ 且最大间隔不超过 $\varepsilon$ 的有限价格网格。阈值不超过 $v$ 时，成交价位于 $[X,X+\varepsilon]$；否则收益仍为 $1$。因此实际收益不超过 $Y_v+\varepsilon$，其风险值不超过 $R(v)+\varepsilon$。令 $\varepsilon\downarrow0$，再对 $v$ 取上确界，得到下界方向。整个论证只使用有限输入。证毕。

当 $\delta<1$ 时，原文 [1] 引理 11 的公式可整理为

$$
R(v)=1+\frac1h\int_0^{(F(v)-\delta)_+}(q(s)-1)\,ds.
\tag{9}
$$

直接验证如下。未达到阈值的概率为 $1-F(v)$，这部分收益为 $1$。如果它不少于 $h$，最差的 $h$ 比例收益全是 $1$。否则，再从已成交部分取最小的 $F(v)-\delta$ 比例阈值。减去常数收益 $1$ 后即为式 (9)。这一排序解释允许部分使用原子，因此没有隐含无原子假设。

## 4. 匹配下界：分位函数的延迟上包络

**引理 3（对原子安全的分位约束）。** 如果 $C_\delta(X)\le a$，那么每个 $0<t\le1$ 均满足

$$
q(t)\le a\left[
1+\frac1h\int_0^{(t-\delta)_+}(q(s)-1)\,ds
\right].
\tag{10}
$$

证明：若 $q(t)=1$，结论由 $a\ge1$ 和 $q\ge1$ 直接成立。否则取任意 $1\le v<q(t)$。广义逆的定义给出 $F(v)<t$。由式 (8)、(9) 及 $q-1\ge0$，

$$
v\le aR(v)\le a\left[
1+\frac1h\int_0^{(t-\delta)_+}(q(s)-1)\,ds
\right].
$$

令 $v\uparrow q(t)$ 即得结论。关键是从左侧逼近阈值；不能在有原子时擅用 $F(q(t))=t$。证毕。

最高报价 $v=\theta$ 还给出一个必须独立使用的约束：

$$
\theta\le a\left[
1+\frac1h\int_0^h(q(s)-1)\,ds
\right].
\tag{11}
$$

该式来自 $F(\theta)=1$，与阈值支撑是否到达 $\theta$ 无关。要求 $q(1)=\theta$ 会错误地排除一部分最优策略。

**引理 4（延迟比较）。** 满足式 (10) 的任意分位函数均有

$$q(t)\le\phi_{a,\delta}(t),\qquad 0<t\le1.\tag{12}$$

当 $\delta>0$ 时，先在 $(0,\delta]$ 上得到 $q\le a=\phi_{a,\delta}$。若已经证明到 $k\delta$，则对 $t\le(k+1)\delta$，式 (10) 的积分只涉及已经比较过的区间。将 $q\le\phi_{a,\delta}$ 代入积分，再使用式 (3)，即可向前推进一个长度为 $\delta$ 的区间。有限次覆盖 $(0,1]$。这只用积分的保序性，不对 $q$ 求导。

当 $\delta=0$ 时，令 $f=q-1$，并设

$$H(t)=a-1+a\int_0^t f(s)\,ds.$$

式 (10) 给出 $f(t)\le H(t)$，所以 $H'(t)=af(t)\le aH(t)$ 几乎处处成立，$H(0)=a-1$。乘以 $e^{-at}$ 并积分，得到 $H(t)\le(a-1)e^{at}$，故

$$q(t)\le1+(a-1)e^{at}=\phi_{a,0}(t).$$

把式 (12) 代入最高报价约束 (11)，再使用式 (3) 在 $t=1$ 的等式，便得到

$$\boxed{\theta\le\phi_{a,\delta}(1).}\tag{13}$$

这正是候选策略此前缺少的匹配下界。

## 5. 方程求解、达到性与一般算法

### 5.1 唯一标量根与达到性

逐段积分式 (3)，得到 [1] 已给出的解

$$
\phi_{a,\delta}(t)=1+(a-1)
\sum_{j\ge0}\frac{a^j(t-j\delta)_+^j}{h^j j!}.
\tag{14}
$$

当 $\delta=0$ 时，级数为 $e^{at}$。对固定 $\delta$，$a\mapsto\phi_{a,\delta}(1)$ 在 $[1,\infty)$ 上连续、严格递增：所有系数非负，且 $j=0$ 项已提供严格增长。它在 $a=1$ 处为 $1$，并趋于无穷。因此式 (5) 确有唯一根 $a_\delta>1$。式 (13) 说明任意阈值策略的竞争比至少为这个根。

记 $\phi_*=\phi_{a_\delta,\delta}$。它在 $[0,\delta]$ 上等于 $a_\delta$，在 $(\delta,1]$ 上严格递增，并以 $\theta$ 结束，因此可以作为随机阈值的分位函数。对 $v<a_\delta$，竞争比不超过 $a_\delta$。对 $v\ge a_\delta$，令 $t=F(v)$，则 $\phi_*(t)=v$；结合式 (9) 和 (3)，得到 $a_\delta R(v)=v$。故原候选策略达到下界。

当 $1/2\le\delta<1$ 时，式 (5) 只有 $j=0,1$ 两项，化为 $\theta=a^2$。当 $\delta<1/2$ 时，$j=2$ 项严格为正，因而最优根严格小于 $\sqrt\theta$。

### 5.2 从阈值分布到全部随机在线算法

设 $A$ 是任意随机在线算法。可以在运行前采样其整条随机带；固定随机带后，算法在相同已观察前缀上的行为相同。这包括在运行中根据历史继续采样随机数的算法。

取整数 $k\ge1$，令 $\varepsilon=(\theta-1)/k$，并取网格 $v_j=1+j\varepsilon$，$0\le j\le k$。用同一随机带耦合算法在所有递增前缀

$$\sigma_j=(v_0,v_1,\ldots,v_j)$$

上的执行。在完整网格 $\sigma_k$ 上，令 $X_k$ 等于算法首次接受的报价；若始终不接受，令 $X_k=\theta$。

对 $j<k$，由 $X_k$ 构造的基准收益 $Y_{v_j}$ 与 $A(\sigma_j)$ 逐随机带相同。对 $j=k$，唯一差别来自始终不接受的随机带：此时基准收益为 $\theta$，原算法按规则取得 $1$。所以每个 $j$ 都有

$$
\mathcal R_\delta(Y_{v_j})\ge
\mathcal R_\delta(A(\sigma_j)).
\tag{15}
$$

记左侧为 $R_k(v_j)$。若 $v_j\le v<v_{j+1}$，由于阈值分布在网格之间没有质量，$R_k(v)=R_k(v_j)$。又因所有收益至少为 $1$，

$$
\frac{v}{R_k(v)}\le
\frac{v_j}{R_k(v_j)}+\varepsilon
\le C_\delta(A)+\varepsilon.
\tag{16}
$$

端点 $v=\theta$ 由式 (15) 单独覆盖。于是 $C_\delta(X_k)\le C_\delta(A)+\varepsilon$。阈值下界给出 $a_\delta\le C_\delta(X_k)$，令 $k\to\infty$ 后有 $C_\delta(A)\ge a_\delta$。达到性已经证明，定理 1 成立。

这是一种任意精度的性能约化，不声称每个依赖历史的算法在所有输入上都等同于固定随机阈值策略。约化机制来自 [1] 附录 A.2，此处完整写出以明确模型和不等式方向。

## 6. 全部最优阈值分布与最小支撑

**定理 5（最优分布的完整刻画）。** 固定 $0\le\delta<1$、$\theta>1$，记 $a_*=a_\delta(\theta)$、$\phi_*=\phi_{a_*,\delta}$。阈值分布的标准广义分位函数 $q$ 最优，当且仅当

$$
q(t)\le\phi_*(t)\quad(0<t\le1),
\qquad q(t)=\phi_*(t)\quad\text{几乎处处于 }(0,h).
\tag{17}
$$

必要性：最优时 $C_\delta(q)=a_*$，比较引理给出上包络。由最高报价约束与 $\phi_*(1)=\theta$，

$$
\theta\le a_*\left[1+\frac1h\int_0^h(q-1)\right]
\le a_*\left[1+\frac1h\int_0^h(\phi_*-1)\right]=\theta.
$$

因此 $\int_0^h(\phi_*-q)=0$。被积函数非负，得到几乎处处相等。

充分性：式 (9) 的积分上限不超过 $h$，所以条件 (17) 使

$$a_*R(v)=\phi_*(F(v)).\tag{18}$$

若 $s=F(v)<1$，则每个 $u>s$ 都有 $q(u)>v$。由 $q(u)\le\phi_*(u)$ 并令 $u\downarrow s$，利用 $\phi_*$ 连续得到 $v\le\phi_*(s)=a_*R(v)$。若 $F(v)=1$，则式 (18) 右侧为 $\theta\ge v$。所有报价都满足竞争比上界，再与普适下界结合即得最优性。证毕。

**推论 6（最大阈值最小的最优策略）。**

$$q_{\mathrm{cap}}(t)=\phi_*(\min\{t,h\})\tag{19}$$

是最优分位函数。在所有最优阈值分布中，它的本质最大阈值最小，恰为 $\phi_*(h)$。

式 (19) 显然满足 (17)。反之，任意最优分位函数在 $(0,h)$ 上几乎处处等于连续函数 $\phi_*$，单调性便强制其本质最大值至少为 $\phi_*(h)$，故下界尖锐。

当 $0<\delta<1/2$ 时，压缩策略在最低阈值 $a_*$ 和最高阈值 $\phi_*(h)$ 处各有概率 $\delta$ 的原子，其间为原分位曲线。原文候选分位与压缩分位不同，却具有同一最优竞争比。因此最优策略一般不唯一。$\delta=0$ 时条件 (17) 固定整个分布；$\delta\ge1/2$ 时压缩策略退化为确定阈值 $\sqrt\theta$。

**命题 7（近最优策略的积分亏损界）。** 若 $C_\delta(q)\le a$，则

$$
0\le\int_0^h\bigl(\phi_{a,\delta}(t)-q(t)\bigr)\,dt
\le\frac h a\bigl(\phi_{a,\delta}(1)-\theta\bigr).
\tag{20}
$$

左侧由比较引理得出。将 $\phi_{a,\delta}$ 的终点等式减去 $q$ 的最高报价不等式即可得到右侧。它说明接近最优根时，低分位部分相对允许上包络的面积亏损必须趋零；这里没有声称上尾也必须唯一。

更精确地，固定 $\theta,\delta$ 并令 $a\downarrow a_*$，终点函数及区间上的剖面对 $a$ 连续可微，所以

$$\int_0^h|q(t)-\phi_*(t)|\,dt
=O_{\theta,\delta}(a-a_*).\tag{20a}$$

确实，$q$ 与 $\phi_*$ 都不超过 $\phi_{a,\delta}$，故
$|q-\phi_*|\le(\phi_{a,\delta}-q)+(\phi_{a,\delta}-\phi_*)$。
第一项的积分由式 (20) 控制，第二项由对参数的可微性控制。该定量结论同样只涉及下方 $h$ 比例分位。

## 7. 风险端点与精确相变系数

### 7.1 风险中性端点的一阶系数

固定 $\theta>1$，令

$$a_0=1+W_0((\theta-1)/e).$$

其中 $W_0$ 是 Lambert $W$ 的主支。则

$$
a_\delta=a_0+a_0(a_0-1)\delta+O_\theta(\delta^2),
\qquad\delta\downarrow0.
\tag{21}
$$

为了控制随 $\delta$ 移动的级数截断，记

$$f_j(\delta)=\left(\frac{(1-j\delta)_+}{1-\delta}\right)^j,$$

并按定义取 $f_0=f_1=1$。对 $j\ge2$，$f_j$ 在 $[0,1/2]$ 上连续可微，$f'_j$ 绝对连续。在 $\delta<1/j$ 时

$$f'_j(\delta)=-j(j-1)(1-j\delta)^{j-1}(1-\delta)^{-j-1};$$

越过 $1/j$ 后，函数及一阶导数均为零，接点处一阶导数匹配。直接微分可得几乎处处的界

$$|f''_j(\delta)|\le2^{j+3}j^4.$$

积分余项因此给出

$$|f_j(\delta)-1+j(j-1)\delta|\le2^{j+2}j^4\delta^2.$$

对任意固定 $A\ge1$，误差乘以 $a^j/j!$ 后在 $a\in[1,A]$ 上一致可求和，因为

$$
\sum_{j\ge2}\frac{A^j}{j!}2^{j+2}j^4
\le4e^{2A}\bigl((2A)^4+6(2A)^3+7(2A)^2+2A\bigr).
$$

于是

$$\sum_{j\ge0}\frac{a^j}{j!}f_j(\delta)
=e^a-a^2e^a\delta+O_A(\delta^2).\tag{22}$$

所有最优根均在 $[1,\sqrt\theta]$ 内，而终点函数对 $a$ 的导数至少为 $1$。先由式 (22) 得 $a_\delta-a_0=O_\theta(\delta)$，再对 $a$ 展开终点等式，得到

$$
0=a_0e^{a_0}(a_\delta-a_0)
-(a_0-1)a_0^2e^{a_0}\delta+O_\theta(\delta^2).
$$

除以 $a_0e^{a_0}$ 即得式 (21)。这没有把 $j\approx1/\delta$ 的移动截断项直接忽略。

### 7.2 随机化收益的二次消失

当 $1/3\le\delta\le1/2$，终点方程只有三项：

$$
\theta=a_\delta^2\left[
1+(a_\delta-1)\frac{(1-2\delta)^2}{2(1-\delta)^2}
\right].
\tag{23}
$$

设 $r=\sqrt\theta$、$\varepsilon=1/2-\delta$。由式 (23) 精确得到

$$
r-a_\delta=
\frac{8a_\delta^2(a_\delta-1)}{r+a_\delta}
\frac{\varepsilon^2}{(1+2\varepsilon)^2}.
\tag{24}
$$

先用 $1\le a_\delta\le r$ 得 $r-a_\delta=O_\theta(\varepsilon^2)$，再将其代回光滑的系数，即有

$$
a_\delta=\sqrt\theta
-4\sqrt\theta(\sqrt\theta-1)(1/2-\delta)^2
+O_\theta((1/2-\delta)^3).
\tag{25}
$$

因此随机化优势 $\sqrt\theta-a_\delta$ 以二次律趋于零。相变的位置本来就已知；式 (25) 确定的是全局最优值的精确接近速度。

对固定 $a>1$，$f_j$ 均不增，且 $f_2$ 在 $[0,1/2)$ 上严格递减。因此终点函数在该区间随 $\delta$ 严格下降，唯一根 $a_\delta$ 严格上升；其后保持 $\sqrt\theta$。

### 7.3 最坏风险端点

当 $\delta=1$，设阈值的本质下确界和上确界分别为 $m$、$M$。在 $v=\theta$ 时，最差收益为 $m$，竞争比至少为 $\theta/m$。对每个 $v<M$，阈值超过 $v$ 的概率为正，最差收益为 $1$；令 $v\uparrow M$，竞争比至少为 $M$。故

$$C_1(X)\ge\max\{M,\theta/m\}\ge\sqrt\theta.$$

确定阈值 $\sqrt\theta$ 达到该值。等号要求 $m=M=\sqrt\theta$，所以在阈值分布类中该端点的最优者是唯一的。第 5.2 节的有限网格约化对本质下确界仍适用，故下界同样覆盖全部随机在线算法。这里不把阈值分布类中的唯一性扩大为所有历史依赖算法的逐输入唯一性。

## 8. 大价格区间的增长阶

固定 $0<\delta<1$，令

$$m=\lceil1/\delta\rceil-1.$$

则 $m\ge1$ 且 $1-m\delta>0$。式 (5) 是关于 $a$ 的 $m+1$ 次多项式，其最高次系数为

$$c_m=\frac{(1-m\delta)^m}{(1-\delta)^m m!}.$$

当 $\theta\to\infty$ 时，唯一根也趋于无穷，因此

$$
a_\delta(\theta)\sim
\left[\frac{m!(1-\delta)^m}{(1-m\delta)^m}\right]^{1/(m+1)}
\theta^{1/(m+1)}.
\tag{26}
$$

这是既有候选公式在精确最优性建立后的直接推论。固定风险参数下的最优增长幂指数为 $1/\lceil1/\delta\rceil$；该陈述固定 $\delta$，不声称在 $\delta\downarrow0$ 的联合极限中一致。

## 9. 计算核验与证据界限

原稿所述标准库脚本使用有理数算术验证延迟积分恒等式、微分恒等式、压缩策略的端点风险等式和相变公式，并为多个参数给出最优根的严格有理包围。$\delta=0$ 的指数值使用正项 Taylor 和与几何尾项上界认证，不以浮点误差代替证明。

另一套程序直接从有限报价网格上的收益表构造 CVaR 优化问题，不以式 (14) 为输入。它用分段线性规划与精确证书进行独立对照；本版本暂未附程序和原始输出。

这些计算可发现符号、相位、端点或离散实现错误，但有限计算本身不能证明全部参数和全部算法上的定理。通用结论的依据是第 3 至第 8 节的连续解析论证。本文不声称完整形式化验证。

以 $\theta=100$ 为例，下表展示四舍五入后的数值。原稿报告的数值证书给出宽度小于 $10^{-19}$ 的有理包围。

| 风险参数 $\delta$ | 最优竞争比的数值展示 |
| --- | ---: |
| $0$ | 3.6286495970 |
| $1/10$ | 4.6558686720 |
| $1/4$ | 6.4266491394 |
| $2/5$ | 8.4156163627 |
| $49/100$ | 9.9657069811 |
| $1/2$ 至 $1$ | 精确等于 10 |

## 10. 适用边界

本文没有预测未来报价的分布，也没有假设报价来自平稳过程。结论是指定最坏输入模型中的风险与竞争性之间的精确关系，并不直接构成现实市场交易策略的收益承诺。

已知时长、能够识别最后一笔报价、不同终止结算规则、自适应对手、多次交易、交易费用和带预测的鲁棒性约束均不在定理范围内。关于最优者的完整分类仅指随机阈值分布；最优值下界则覆盖全部原模型随机在线算法。

## 参考文献

[1] Nicolas Christianson, Bo Sun, Steven Low, Adam Wierman. *Risk-Sensitive Online Algorithms*. arXiv:2405.09859v2, 24 May 2024; extended abstract in COLT 2024, PMLR 247:1140-1141. https://arxiv.org/html/2405.09859v2

[2] Spyros Angelopoulos, Christoph Dürr, Georgii Melidi. *Decision-Theoretic Approaches for Improved Learning-Augmented Algorithms*. arXiv:2501.17701v2, 15 September 2025; ICLR 2026. https://arxiv.org/html/2501.17701v2

[3] Ziyad Benomar, Lorenzo Croissant, Vianney Perchet, Spyros Angelopoulos. *Pareto-Optimality, Smoothness, and Stochasticity in Learning-Augmented One-Max-Search*. ICML 2025, PMLR 267:3776-3805. https://proceedings.mlr.press/v267/benomar25a.html

[4] Sizhe Li, Nicolas Christianson, Tongxin Li. *Prediction-Specific Design of Learning-Augmented Algorithms*. arXiv:2510.14887v1, 16 October 2025; POMACS 10(1), Article 18, 2026. 本文比较使用该 arXiv 版本。https://arxiv.org/html/2510.14887v1
