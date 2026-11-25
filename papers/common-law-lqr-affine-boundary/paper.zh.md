# 共同扰动分布下的仿射最优性：时域精确边界、暴露面刚性与矩证书

**研究初稿 · 2026 年 11 月 25 日 · 修订稿。**

## 摘要

本文研究有限时域加权均值估计问题：所有观测均独立采自同一个未知标量分布，其均值与标准差位于以 $(0,s_0)$ 为中心的圆盘内。我们仅假设分布具有有限二阶矩。对于任意正半径、$s_0>0$ 以及任意非负阶段权重序列，我们证明，仿射规则达到不受仿射限制的极小极大值，当且仅当所有使用三个或更多观测的决策阶段权重均为零。等值方向通过一个匹配的双分布贝叶斯实验建立；严格不等方向构造由互异样本指标组成的三次统计量，并给出显式的一致风险证书，无须高阶矩假设。一个精确实例将最优仿射最坏风险 $3/2$ 改善至不超过 $35/24$。借助已有的遗憾恒等式，该定理进一步给出完全观测、有限时域、任意有限状态维数与控制维数且具有标量扰动的 LQR 问题中相应的充要条件。本文刻画仿射最优性的分类边界，而不声称求得每一种较长时域情形下不受仿射限制的精确极小极大值。

推广部分处理均值平方与方差构成的任意紧凸集合，并要求存在正坐标仿射鞍点。如果仿射暴露面上方差相对于均值平方的斜率绝对值大于一，则只要有效观测数达到三个或更多，就必然存在严格的非线性改善，即使最坏矩对不唯一也如此。当斜率绝对值等于一时，只要某个正权重决策使用至少两个观测，等值关系就强迫最不利采样分布具有二点支撑；而一个有限区间矩条件对每种时域都精确刻画等值关系。一个三角形实例进一步将整个多线性多项式类与全体可测规则类严格分离。后一分离是存在性结论，本文不声称求得其精确非线性最优值。原始偏移圆盘结果仍保留一个显式改善规则。

**关键词：** 分布稳健遗憾；共同分布歧义；极小极大均值估计；仿射策略；有限矩；线性二次控制。

## 研究动机与贡献边界

Fiechtner 和 Blanchet [R1] 建立了事前稳健遗憾控制模型，其中自然方选定一个扰动分布，并在各时刻重复使用该分布。他们的可计算综合方法在仿射策略类内最优，其结论部分将超出该策略类的最优性列为开放方向。本文在其矩歧义模型下回答标量扰动情形的这一问题，而不处理完整的多维问题。

比较基准知道候选扰动分布，但无法观测其未来样本。依赖历史信息的策略能够学习共同均值，因此，这一统计实验不同于对任意联合轨迹分布施加歧义的模型。在该实验中，一个结构性问题是：可计算的仿射解是否也在所有可测规则中最优？定理 1 对每个有限时域和每组非负阶段权重给出完整回答，其中包括权重为零的情形。

本文采用的若干基本工具已有充分研究。对于非线性因果策略，LQR 遗憾到预测损失的恒等式已在 [R2，第 3.2 节，式 (33)] 中明确给出。Eldar 和 Merhav [R3，第 VII 节及定理 4] 研究了非线性极小极大遗憾估计，并在高斯协方差不确定性模型中给出三次估计量。对称端点先验及其在一个、两个观测下的后验恒等式，是有界二项模型中的经典工具 [R4]。互异样本乘积与 U 统计量同样是标准方法 [R5, R6]。本文不将这些基本工具中的任何一项声称为新发明。

本文证明的具体增量，是对重复使用共同分布的矩约束实验给出仿射规则与全体规则之间的完整分类，并给出仅需二阶矩即可成立的显式全局严格分离证书。仿射风险的精确亏量控制了非线性修正之后对手可能进行的移动；仅在原最坏分布处验证导数改善并不足够。该结果还在 LQR 解释中保留了任意权重以及完整的因果控制策略类。

相近模型之间的区别至关重要。Dykstra [R7] 研究已知紧支撑的情形；该条件提供了有界统计实验，并允许利用经典 Dirichlet 先验建立仿射极小极大性。Wasserstein MMSE [R8] 分别对随机信号和噪声设置不确定性。具有时间相关噪声的 Wasserstein LQR 结果 [R9] 考察联合噪声分布球及最坏成本。这些模型的歧义集或遗憾实验均与本文不同。对于 [R9]，本次审查仅取得了官方摘要；本文的证明和绝对优先权判断均不使用未读过的定理。文献比较限于实际获取的材料。

### 二次研究推广的范围

第 10—12 节在原始圆盘模型之外建立几何理论。一般歧义集的坐标明确为 $(x,v)=(\mu^2,
\operatorname{Var}X)$，不能暗中替换为其他坐标系下的凸性。将最优仿射风险写为 $Bx+Av$，令 $\beta=B/A$，并以 $N$ 表示具有正权重的最大观测数。推广部分假设 $A,B>0$ 且存在正坐标对偶鞍点，因此 $\rho>0$ 有良好定义。在这些假设下：

| 情形 | 全体可测规则类与仿射类的关系 |
|---|---|
| $N\le2$ | 由共同双分布贝叶斯构造得到等值 |
| $N\ge3$, $\beta>1$ | 在有界连续规则类中存在严格改善 |
| $\beta=1$ | 当且仅当指定的有限 Beta 矩可在暴露区间上实现时等值 |
| $0<\beta<1$, $N\ge3$ | 不声称一般分类；斜率为整数倒数的三角形实例可给出等值 |

当 $\beta=1$ 时，两个观测就足以强迫每个匹配最不利先验所包含的分布具有二点支撑；一个单观测反例表明这一刚性阈值是精确的。临界面的判据在等值成立时给出有限先验，在判据失败时则给出从矩阵到多项式的构造，并附带在暴露面之外一致成立的证书。

后验均值的线性性与有限 Beta 矩匹配均属于经典结果，包括非参数线性贝叶斯分析 [R11, R12]。区间矩检验也是经典工具 [R13]，受约束二项模型的极小极大性早已通过矩向量进行研究 [R14]。本文的新论证不预设二项或指数族采样模型：它从具有有限二阶矩的歧义类中的所有分布出发，证明所需的最不利先验接口，并从非负条件方差推导暴露面阻断与二点支撑刚性。三角形分离结果进一步说明，即使多线性修正类任意丰富，仍可能遗漏全体规则类中的严格改善。这些是应与既有研究比较的具体贡献，经典工具本身不计入贡献。

## 1. 模型与主要定理

固定整数 $T\geq1$、不全为零的权重 $q_0,\ldots,q_{T-1}\geq0$，以及 $s_0>0$、$\delta>0$。记

$$
\mathcal P=\{P:\ P\text{ is a Borel probability law on }\mathbb R,
\quad E_P X^2<\infty,
\quad \mu(P)^2+(s(P)-s_0)^2\leq\delta^2\},
$$

其中 $\mu(P)=E_P X$，$s(P)^2=\operatorname{Var}_P X$。对手选定一个分布 $P$，所有观测均从该分布独立同分布采样。在阶段 $t$，估计量 $f_t$ 恰好具有 $t$ 个观测。每个 $f_t:\mathbb R^t\to\mathbb R$ 均为 Borel 可测映射，并且在每个 $P^{\otimes t}$ 下平方可积；$f_0$ 为常数。定义

$$
\mathcal R(f,P)=\sum_{t=0}^{T-1}q_t
 E_{P^{\otimes t}}[(f_t(X_1,\ldots,X_t)-\mu(P))^2],
$$

$$
V_{\rm all}=\inf_f\sup_{P\in\mathcal P}\mathcal R(f,P),\qquad
V_{\rm aff}=\inf_{f\text{ affine}}\sup_{P\in\mathcal P}\mathcal R(f,P).
$$

估计量的独立随机化不能改善这些值：给定观测取条件期望并应用 Jensen 不等式，可将任意随机化估计量替换为其条件均值，而不增加任何分布下的平方损失。因此，只需考虑确定性可测映射。

### 定理 1——仿射最优性的精确边界

对于上述参数的每一种取值，均有

$$
\boxed{\quad V_{\rm all}=V_{\rm aff}
\quad\Longleftrightarrow\quad
q_t=0\text{ for every }t\geq3.\quad} \tag{1}
$$

如果存在满足 $j\geq3$ 的 $q_j>0$，则第 6 节给出一个可容许的非线性估计量及完全显式的正常数 $\varepsilon,C_*$，使得

$$
\sup_{P\in\mathcal P}\mathcal R(f^{\varepsilon},P)
\leq V_{\rm aff}-\varepsilon C_*<V_{\rm aff}. \tag{2}
$$

该量化范围包括支撑无界的分布，以及三阶、四阶或六阶绝对矩为无穷的分布。本文并未求出每一种较长时域情形下不受仿射限制的极小极大值，也不声称所构造的特定三次修正在全局上达到极小极大最优。

## 2. 精确仿射归约与有限维鞍点

令 $I=\{t\in\{1,\ldots,T-1\}:q_t>0\}$。如果 $I$ 为空，则 $q_0>0$，取 $f_0=0$ 可得值 $q_0\delta^2$。均值分别为 $\pm\delta$、标准差均为 $s_0$ 的两个分布，为任意常数 $f_0$ 给出匹配下界。因此，$V_{\rm all}=V_{\rm aff}=q_0\delta^2$。这处理了所有不存在正权重观测阶段的情形。

以下假设 $I\neq\varnothing$。引入均值平方 $x=\mu^2$ 与方差 $v=s^2$，其矩域为

$$
K=\{(x,v)\in\mathbb R_+^2:
x+(\sqrt v-s_0)^2\leq\delta^2\}. \tag{3}
$$

该集合为紧集，因为 $0\leq x\leq\delta^2$ 且 $0\leq v\leq(s_0+\delta)^2$。它也是凸集，因为映射 $v\mapsto v-2s_0\sqrt v+s_0^2$ 在 $[0,\infty)$ 上为凸函数。$K$ 中每一点均可由均值为 $+\sqrt x$ 的有限支撑分布实现，也可由其均值为 $-\sqrt x$ 的反射分布实现。

任意仿射阶段规则均可写为 $b_t+\sum_{i=1}^t c_{ti}X_i$。对 $t$ 个观测的所有排列取平均。平方损失的凸性与独立同分布性质表明，该平均不会增加任何固定 $P$ 下的风险。所得规则具有形式 $b_t+a_t\bar X_t$，其中 $\bar X_t=t^{-1}\sum_iX_i$。再将整个策略与其符号反射策略取平均。由于 $P\in\mathcal P$ 当且仅当其反射也属于 $\mathcal P$，这一操作不会增加最坏风险，并消去了所有 $b_t$，包括 $f_0$。因此，仿射极小极大优化可限制为

$$
f_0=0,\qquad f_t=a_t\bar X_t.
$$

将任意实数 $a_t$ 投影至 $[0,1]$，会同时减小 $a_t^2$ 与 $(1-a_t)^2$，因而还可要求 $a_t\in[0,1]$。零权重阶段可采用恒为零的规则。对于有效阶段，有

$$
\Phi(a;x,v)=B(a)x+A(a)v,\qquad
A(a)=\sum_{t\in I}\frac{q_ta_t^2}{t},\quad
B(a)=q_0+\sum_{t\in I}q_t(1-a_t)^2. \tag{4}
$$

系数域 $[0,1]^I$ 与矩域 $K$ 均为紧凸集。函数 $\Phi$ 连续，关于 $a$ 为凸函数，关于 $(x,v)$ 为线性函数。有限维凸凹极小极大定理，即 Sion 定理 [R10] 的一个特例，给出

$$
V_{\rm aff}
=\min_{a\in[0,1]^I}\max_{(x,v)\in K}\Phi(a;x,v)
=\max_{(x,v)\in K}\min_{a\in[0,1]^I}\Phi(a;x,v). \tag{5}
$$

当 $x,v>0$ 时，内层极小点唯一，且为

$$
a_t(x,v)=\frac{t x}{v+t x}, \tag{6}
$$

其值为

$$
F(x,v)=q_0x+\sum_{t\in I}q_t\frac{xv}{v+t x}. \tag{7}
$$

各分式在 $(0,0)$ 处的连续延拓值为零；例如，$0\leq xv/(v+t x)\leq\min(x,v/t)$。因此，在采用这一约定后，式 (7) 在整个定义域上成立。

式 (5) 的极小点与式 (7) 的极大点均存在。如果 $a^*$ 与 $(x_*,v_*)$ 为任意这样一对优化解，则它们构成鞍点：

$$
\Phi(a^*;x,v)\leq V_{\rm aff}
=\Phi(a^*;x_*,v_*)\leq\Phi(a;x_*,v_*) \tag{8}
$$

该式对所有可行的 $(x,v)$ 与 $a$ 均成立。事实上，中间量的上界为式 (5) 的原始问题值，下界为其对偶问题值。

### 自然方最优矩的坐标为正

我们有 $x_*>0$ 且 $v_*>0$。

首先，$F(0,v)=0$；而由于 $I\neq\varnothing$，可行点 $(\delta^2/2,s_0^2)$ 具有严格正值。这排除了 $x_*=0$。

如果 $v=0$ 可行，则该边上有 $F(x,0)=q_0x$。若 $q_0=0$，其值为零，因此不可能最优。若 $q_0>0$，则只要 $x=\delta^2-s_0^2$ 非负，这一数值就给出该边上的最优点。对于充分小的 $s>0$，可行边界点

$$
x(s)=\delta^2-(s-s_0)^2
=\delta^2-s_0^2+2s_0s-s^2
$$

满足 $x(s)>\delta^2-s_0^2$，并且 $F(x(s),s^2)\geq q_0x(s)>q_0(\delta^2-s_0^2)$。如果该边仅包含原点，则该点已被排除。因此，在所有情形下均有 $v_*>0$。

因此，式 (6) 对每个有效阶段成立，并给出 $0<a_t^*<1$。特别地，系数

$$
A=A(a^*)>0,\qquad B=B(a^*)>0 \tag{9}
$$

均严格为正。令 $s_*=\sqrt{v_*}$。

### 唯一最坏矩对及其精确风险亏量

对于仿射规则 $a^*$，自然方最大化 $Bx+As^2$。由于 $B>0$，极大点处的矩约束必取等号。因此，自然方最大化二次函数

$$
h(s)=B[\delta^2-(s-s_0)^2]+As^2
$$

其定义区间为 $[\max(0,s_0-\delta),s_0+\delta]$。已证明的 $x_*>0,s_*>0$ 表明 $s_*$ 位于该区间内部。驻点方程为

$$
(B-A)s_*=B s_0. \tag{10}
$$

由于 $B,s_*,s_0>0$，得到

$$
B>A,\qquad s_*=\frac{B s_0}{B-A}>s_0,
\qquad x_*=\delta^2-(s_*-s_0)^2>0. \tag{11}
$$

二次函数 $h$ 严格凹，因此最坏矩对唯一。分布本身未必唯一；均值为 $\pm\sqrt{x_*}$ 中任一值、方差为 $v_*$ 的所有分布，都具有相同的仿射风险。

对于任意可行的 $(x,s)$，定义其非负约束松弛量

$$
e=\delta^2-(s-s_0)^2-x\geq0.
$$

对 $h$ 配方，得到精确恒等式

$$
\Delta(x,s):=V_{\rm aff}-[Bx+As^2]
=(B-A)(s-s_*)^2+B e. \tag{12}
$$

这一恒等式至关重要。仅在原极大点处取得改善，本身不足以证明最坏风险有所改善。

### 通过唯一标量方程计算仿射鞍点

无需在概率分布上进行搜索即可计算该鞍点。在 $v\in[s_0^2,(s_0+\delta)^2]$ 上，令

$$
x(v)=\delta^2-(\sqrt v-s_0)^2,\qquad G(v)=F(x(v),v).
$$

每个满足 $v<s_0^2$ 的可行点都被 $(\delta^2,s_0^2)$ 逐坐标支配。当 $v\geq s_0^2$ 时，将 $x$ 增至其边界值不会减小 $F$。因此，只需最大化 $G$。对于 $g_t(x,v)=xv/(v+tx)$，直接求导可得

$$
\partial_xg_t=\frac{v^2}{(v+tx)^2},\quad
\partial_vg_t=\frac{t x^2}{(v+tx)^2},\quad
\nabla^2 g_t=-\frac{2t}{(v+tx)^3}
\begin{pmatrix}v^2&-xv\\-xv&x^2\end{pmatrix}\preceq0.
$$

在该区间上，$F_x>0$ 且 $x''(v)=-s_0/(2v^{3/2})<0$。因此，

$$
G''(v)=(x'(v),1)\nabla^2F(x(v),v)(x'(v),1)^\top
       +F_x(x(v),v)x''(v)<0.
$$

两端点处的导数满足

$$
G'(s_0^2)=F_v(\delta^2,s_0^2)>0,\qquad
G'((s_0+\delta)^2)
=-\frac{\delta}{s_0+\delta}\left(q_0+\sum_{t\in I}q_t\right)<0.
$$

$G'$ 在区间内部恰有一个零点。该零点给出 $v_*$，随后由式 (6)—(8) 得到 $x_*$、所有 $a_t^*$ 以及 $V_{\rm aff}$。$G'$ 的单调性允许采用带保证的区间二分法。这一刻画针对仿射值，并不计算较长历史下不受仿射限制的极小极大值。

## 3. 正权重仅涉及至多两个样本时的全估计量下界

假设对每个 $t\geq3$ 都有 $q_t=0$，并继续假设 $I\neq\varnothing$。令

$$
m=\sqrt{x_*},\qquad c=\sqrt{x_*+v_*},\qquad r=m/c\in(0,1).
$$

考虑两个可容许分布 $P_+$、$P_-$，它们支撑于同一个集合 $\{-c,c\}$，并满足

$$
P_+(X=c)=\frac{1+r}{2},\qquad
P_-(X=c)=\frac{1-r}{2}. \tag{13}
$$

它们的均值分别为 $m$ 与 $-m$，共同方差为 $v_*$。对每个分布赋予二分之一的先验概率。等价地，先在 $\Theta\in\{-m,m\}$ 中均匀抽取一个值，再条件于其对应分布独立采样观测。这是在两个固定独立同分布法则上的普通先验，并未改变对手采用共同分布的模型。

在该先验下，平方损失的贝叶斯估计量为：

$$
E[\Theta]=0,
$$

$$
E[\Theta\mid X_1]=r^2X_1
=\frac{x_*}{v_*+x_*}\bar X_1,
$$

$$
E[\Theta\mid X_1,X_2]
=\frac{2r^2}{1+r^2}\bar X_2
=\frac{2x_*}{v_*+2x_*}\bar X_2. \tag{14}
$$

对于最后一个恒等式，当两个观测符号相反时，后验均值为零。当两个观测均具有符号 $\eta\in\{-1,1\}$ 时，后验均值为 $\eta m\,2r/(1+r^2)$，这恰好等于式 (14)。因此，式 (6) 给出的仿射极小极大规则在每个正权重阶段均为贝叶斯规则。

对于任意因果估计量族 $f$，

$$
\sup_{P\in\mathcal P}\mathcal R(f,P)
\geq\tfrac12\mathcal R(f,P_+)+\tfrac12\mathcal R(f,P_-)
\geq\tfrac12\mathcal R(a^*,P_+)+\tfrac12\mathcal R(a^*,P_-)
=V_{\rm aff}. \tag{15}
$$

第二个不等式来自平方损失下条件均值的最优性，并按非负权重求和。最后一个等式来自鞍点恒等式 (8)。反向不等式则来自仿射类包含于全体规则类。因此，对于所有正权重仅出现在少量观测阶段的配置，等值结论均成立，其中包括阶段 0、1 或 2 缺失或权重为零的情形。

## 4. 仅需二阶矩的非线性方向

取任意满足 $q_j>0$ 的阶段 $j\geq3$，并记 $a=a_j^*$、$q=q_j$。定义对称三次统计量

$$
U_{j,3}=\binom j3^{-1}
\sum_{1\leq i<k<\ell\leq j}X_iX_kX_\ell. \tag{16}
$$

每个乘积中的全部因子均来自互异观测。对于均值为 $\mu$、均值平方为 $x=\mu^2$、方差为 $s^2$ 的分布，由独立性得到

$$
E U_{j,3}=\mu^3,
\qquad
E[\bar X_j U_{j,3}]=\mu^4+\frac{3s^2\mu^2}{j}. \tag{17}
$$

为验证第二个恒等式，固定一个三元组。样本均值中对应于该三元组的三个求和项，每项均贡献 $(\mu^2+s^2)\mu^2$；其余 $j-3$ 个求和项每项贡献 $\mu^4$，最后再除以 $j$。

在 $U_{j,3}^2$ 的每个乘积项中，每个单独观测的指数均不超过二。特别地，Jensen 不等式与独立性给出

$$
E U_{j,3}^2\leq(E X^2)^3=(x+s^2)^3
\leq(s_0+\delta)^6. \tag{18}
$$

最后一个不等式使用了 $\sqrt{\mu^2+s^2}\leq\sqrt{\mu^2+(s-s_0)^2}+s_0\leq\delta+s_0$。因此，该统计量在每个可容许分布下均平方可积，而不需要任何单个观测的二阶以上矩。

进行精确的有限计算时，还可使用

$$
E U_{j,3}^2
=\sum_{h=0}^3
\frac{\binom3h\binom{j-3}{3-h}}{\binom j3}
(x+s^2)^h x^{3-h}, \tag{19}
$$

其中，下标超出范围的二项式系数按零处理。该系数是均匀选取的第二个三元组与固定的第一个三元组交集大小为 $h$ 的概率。这同时证明了该公式以及其系数和为一的性质。当 $j=3$ 时，式 (19) 即为 $(x+s^2)^3$。

仅修改阶段 $j$：

$$
f_j^{\varepsilon}=a\bar X_j-\varepsilon U_{j,3},\qquad
f_t^{\varepsilon}=a_t^*\bar X_t\quad(t\neq j),\qquad f_0=0. \tag{20}
$$

由于零权重阶段不影响风险，其规则可取为零。由式 (17)，

$$
\mathcal R(f^{\varepsilon},P)
=Bx+As^2-2\varepsilon C(x,s)+\varepsilon^2W(x,s), \tag{21}
$$

其中

$$
C(x,s)=q x\left[(a-1)x+\frac{3a}{j}s^2\right],\qquad
W(x,s)=qE U_{j,3}^2. \tag{22}
$$

在仿射规则的最坏矩对处，使用 $a=jx_* /(v_*+jx_*)$ 得到

$$
C_*:=C(x_*,s_*)
=\frac{2q x_*^2v_*}{v_*+jx_*}>0. \tag{23}
$$

因此，在最坏均值的正负两种符号下，该新方向都使风险的一阶导数严格为负。下一节将这一局部结论提升为覆盖整个歧义集的、经过证实的一致改善。

## 5. 控制最坏情形变化的显式常数

令 $R=s_0+\delta$，并定义

$$
D_x=q\left[2(1-a)\delta^2+\frac{3a}{j}R^2\right],
\qquad
D_s=q\frac{6a}{j}\delta^2R. \tag{24}
$$

在包含整个矩域的矩形 $0\leq x\leq\delta^2$、$0\leq s\leq R$ 上，$C$ 两个偏导数的绝对值分别不超过 $D_x$ 与 $D_s$。因此，该矩形上的中值估计为

$$
|C(x,s)-C_*|\leq D_x|x-x_*|+D_s|s-s_*|. \tag{25}
$$

由松弛量 $e$ 的定义以及 $x_*$ 满足的边界恒等式，

$$
|x-x_*|
\leq |(s-s_0)^2-(s_*-s_0)^2|+e
\leq2\delta|s-s_*|+e. \tag{26}
$$

结合式 (12)、(25) 与 (26)，定义

$$
L=\frac{2\delta D_x+D_s}{\sqrt{B-A}},\qquad
M=\frac{D_x}{B},\qquad
W_0=q R^6. \tag{27}
$$

这些常数均有限且严格为正。对于每个可容许矩对，

$$
C(x,s)\geq C_*-L\sqrt{\Delta(x,s)}-M\Delta(x,s),
\qquad 0\leq W(x,s)\leq W_0. \tag{28}
$$

## 6. 具有显式证书的严格分离

任取满足下式的参数：

$$
0<\varepsilon\leq
\varepsilon_0:=
\min\left\{\frac{1}{4M},
\frac{C_*}{W_0+2L^2}\right\}. \tag{29}
$$

式 (29) 所需的全部量都由有限维仿射鞍点和输入参数确定。对于任意 $P\in\mathcal P$，令 $\Delta=\Delta(x,s)$。式 (21) 与 (28) 给出

$$
\begin{aligned}
\mathcal R(f^{\varepsilon},P)
&\leq V_{\rm aff}-\Delta-2\varepsilon C_*
 +2\varepsilon L\sqrt\Delta+2\varepsilon M\Delta
 +\varepsilon^2W_0\\
&\leq V_{\rm aff}-2\varepsilon C_*
 -\tfrac12\Delta+2\varepsilon L\sqrt\Delta
 +\varepsilon^2W_0\\
&\leq V_{\rm aff}-2\varepsilon C_*
 +\varepsilon^2(W_0+2L^2)\\
&\leq V_{\rm aff}-\varepsilon C_*.
\end{aligned} \tag{30}
$$

第三行使用初等配方不等式 $-y^2/2+2\varepsilon Ly\leq2\varepsilon^2L^2$，其中 $y=\sqrt\Delta$。第二行与第四行分别使用式 (29) 中对应的两个上界。对所有分布取上确界即可证明式 (2)，进而证明式 (1) 的严格不等方向。

该上界允许自然方针对新规则改变均值、方差、支撑或尾部形状，而且估计对所有这些选择一致成立。界中对 $1/(B-A)$ 的依赖具有实质意义：当名义方差为零时，利用唯一最坏矩及其亏量的论证不再适用，因此不能从本证明推断该单独边界情形的结论。

## 7. 具有明确一致差距的精确四阶段实例

取

$$
T=4,\qquad(q_0,q_1,q_2,q_3)=(0,0,0,1),\qquad s_0=\delta=2.
$$

矩域为 $0\leq s\leq4$、$0\leq x\leq s(4-s)$。仿射规则 $f_3=\tfrac12\bar X_3$ 对应 $A=1/12$、$B=1/4$，其最大风险为

$$
\max_{0\leq s\leq4}\left[s-\frac{s^2}{6}\right]=\frac32,
$$

并在 $(x_*,s_*)=(3,3)$ 处达到。在该矩对处，任意仿射系数的风险均满足 $3(1-a)^2+3a^2\geq3/2$。因此，精确地有 $V_{\rm aff}=3/2$。

采用显式非线性规则

$$
f_3=\frac12\bar X_3-\frac1{192}X_1X_2X_3. \tag{31}
$$

记 $R(f_3,P)=E_P[(f_3-\mu)^2]$。对于每个可容许分布，该风险为

$$
R(x,s)=\frac x4+\frac{s^2}{12}
-\frac{x(s^2-x)}{192}
+\frac{(x+s^2)^3}{192^2}. \tag{32}
$$

在整个矩域上，

$$
\partial_xR
=\frac14-\frac{s^2-2x}{192}
+\frac{3(x+s^2)^2}{192^2}
\geq\frac14-\frac{16}{192}=\frac16>0.
$$

因此，自然方在 $x=s(4-s)$ 上最大化式 (32)，此时风险化为

$$
R(s)=s-\frac{s^2}{12}-\frac{35s^3}{576}+\frac{s^4}{96}.
$$

为证明一致上界，定义

$$
P(s)=576\left[\frac{35}{24}-R(s)\right]
=840-576s+48s^2+35s^3-6s^4.
$$

记 $z=s-3\in[-3,1]$。于是

$$
P(s)=3+9z+39z^2-37z^3-6z^4.
$$

当 $-3\leq z\leq0$ 时，最后两项之和为 $-z^3(37+6z)\geq0$，其余二次式至少为 $129/52>0$。当 $0\leq z\leq1$ 时，有 $-37z^3-6z^4\geq-43z^2$，从而 $P(s)\geq3+9z-4z^2\geq3>0$。因此，

$$
V_{\rm all}\leq\sup_{P\in\mathcal P}R(f_3,P)
\leq\frac{35}{24}<\frac32=V_{\rm aff},\qquad
V_{\rm aff}-V_{\rm all}\geq\frac1{24}. \tag{33}
$$

这是在连续矩域上成立的精确不等式，并非网格检验；由式 (32) 可知，它适用于每个分布。上界 $35/24$ 是有意选择的有理数证书，本文不声称它是该多项式或全体规则的精确最优值。

## 8. 向任意状态与控制维数的 LQR 精确转移

考虑确定性的有限维矩阵，以及完全观测动力学

$$
z_{t+1}=A_tz_t+B_tu_t+\xi_t w_t,\qquad t=0,\ldots,T-1,
$$

其中初始状态 $z_0$ 固定，标量扰动独立同分布且采用同一个分布 $P$，控制不受约束。假设 $\xi_t\neq0$，从而可以由相邻状态和已实施的控制重构过去的标量扰动。成本为

$$
L=\sum_{t=0}^{T-1}
\bigl(z_t^\top Q_tz_t+2z_t^\top D_tu_t+u_t^\top R_tu_t\bigr)
+z_T^\top Q_Tz_T,
$$

其中 $Q_t,R_t,Q_T$ 为对称矩阵。允许任意有限的状态维数与控制维数，并假设下文配方得到的每个控制矩阵均正定。证明所需的是这一假设，而非各个状态成本矩阵分别为正。

置 $S_T=Q_T$、$P_T=0$，并逆向递推：

$$
M_t=R_t+B_t^\top S_{t+1}B_t\succ0,
\qquad C_t=B_t^\top S_{t+1}A_t+D_t^\top,
$$

$$
K_t=-M_t^{-1}C_t,\qquad
H_t=-M_t^{-1}B_t^\top(S_{t+1}\xi_t+P_{t+1}),
$$

$$
S_t=Q_t+A_t^\top S_{t+1}A_t-C_t^\top M_t^{-1}C_t,
$$

$$
P_t=(A_t+B_tK_t)^\top(S_{t+1}\xi_t+P_{t+1}). \tag{34}
$$

这里，$P_t$ 是状态维数的向量，与表示概率分布的符号无关。对于均值为 $\mu$ 的已知扰动分布，逆向配方得到形如 $z^\top S_tz+2z^\top P_t\mu+c_t(\mu,s^2)$ 的值函数，以及最优因果控制

$$
u_t^{*,P}=K_tz_t+H_t\mu. \tag{35}
$$

为完整起见，标量项为 $c_t=d_t\mu^2+e_t s^2$。令 $d_T=e_T=0$ 且 $g_t=S_{t+1}\xi_t+P_{t+1}$，其递推为

$$
\begin{aligned}
d_t&=d_{t+1}+\xi_t^\top S_{t+1}\xi_t
       +2\xi_t^\top P_{t+1}
       -g_t^\top B_tM_t^{-1}B_t^\top g_t,\\
e_t&=e_{t+1}+\xi_t^\top S_{t+1}\xi_t.
\end{aligned}
$$

对下一个独立扰动下的下一阶段值函数展开，并对控制变量配方，可直接验证这些递推。由于每个 $M_t$ 均正定，配方在每个阶段识别出的下确界适用于所有平方可积因果控制，而不仅适用于仿射控制。

令 $J^*(P)$ 表示已知分布最优因果控制器的成本。对于任意控制量在每个可容许分布下均平方可积的因果控制器 $\pi$，同一 Bellman 配方在给定历史后取条件期望，再对各阶段求和，得到

$$
J(\pi,P)-J^*(P)
=\sum_{t=0}^{T-1}E_P
\left[\|u_t-K_tz_t-H_t\mu\|_{M_t}^2\right],\qquad
\|y\|_{M_t}^2=y^\top M_ty. \tag{36}
$$

这是标准的优势恒等式；针对任意因果策略的预测解释已在 [R2，第 3.2 节，式 (33)] 中明确给出。本文将其作为问题之间的接口，而不作为原创贡献。其证明仅使用下一个扰动的条件独立性与配方，因此对非线性因果策略仍然成立。特别地，比较基准是知道分布但不知道未来样本的控制器。

设名义均值为 $\widehat\mu$，共同分布满足

$$
(\mu-\widehat\mu)^2+(s-s_0)^2\leq\delta^2.
$$

令 $X_i=w_{i-1}-\widehat\mu$、$\theta=\mu-\widehat\mu$，并定义

$$
q_t=H_t^\top M_tH_t\geq0. \tag{37}
$$

对于第 1 节中的任意标量估计量族，控制器

$$
u_t=K_tz_t+H_t\widehat\mu+H_tf_t(X_1,\ldots,X_t) \tag{38}
$$

是因果的，其遗憾恰好为 $\sum_tq_t E[(f_t-\theta)^2]$。在有限时域内应用归纳法可知，其控制量与状态在每个可容许分布下均平方可积。

反过来，给定任意可容许控制策略，将其状态与控制量视为重构扰动历史的可测函数。对于满足 $q_t>0$ 的阶段，定义

$$
\widehat f_t=
\frac{H_t^\top M_t
 (u_t-K_tz_t-H_t\widehat\mu)}{q_t}.
$$

关于 $M_t$ 的正交投影恒等式逐点给出

$$
\|u_t-K_tz_t-H_t\mu\|_{M_t}^2
\geq q_t(\widehat f_t-\theta)^2. \tag{39}
$$

每个 $\widehat f_t$ 都是可容许的标量历史估计量。如果 $q_t=0$，则由 $M_t$ 正定可知 $H_t=0$，该阶段仅贡献一个可置为零的非负平方项。

式 (38) 与 (39) 表明，完整极小极大控制值等于使用式 (37) 权重的 $V_{\rm all}$。同样的论证将仿射控制值等同于 $V_{\rm aff}$：仿射扰动反馈控制产生仿射状态与仿射投影估计量；反之，将仿射估计量代入式 (38)，得到仿射扰动反馈控制。

因此，全体因果策略的事前 DRRO-LQR 值等于其仿射值，当且仅当

$$
H_t=0\quad\text{for every }t\geq3. \tag{40}
$$

如果存在这样的 $H_j\neq0$，则将使用式 (29) 参数的式 (20) 代入式 (38)，得到式 (30) 的严格改善。如果所有 $H_t=0$，则两类遗憾均为零。如果时域至多为三个阶段，则总有等值结论。在这一不含前置历史的模型中，四个阶段是首次可能出现严格分离的时域。

### 实现上述精确实例的具体 LQR

取标量状态、控制与扰动，并令 $T=4$。在阶段 $t=0,1,2$，设 $A_t=B_t=0$、$\xi_t=1$、$R_t=1$、$Q_t=D_t=0$。在阶段 3，设 $A_3=0$、$B_3=\xi_3=1$、$R_3=2$、$Q_3=D_3=0$，终端成本为 $Q_4=2$。此时成本为

$$
u_0^2+u_1^2+u_2^2+2u_3^2+2z_4^2.
$$

前三个状态揭示前三个扰动。递推 (34) 给出 $H_0=H_1=H_2=0$、$M_3=4$、$H_3=-1/2$，因此由式 (37) 得到 $(q_0,q_1,q_2,q_3)=(0,0,0,1)$。已知分布的末阶段控制器为 $u_3=-\mu/2$。取 $u_0=u_1=u_2=0$，并令 $u_3=-f_3/2$，其中估计量由式 (31) 给出。此时遗憾恰好为 $E[(f_3-\mu)^2]$，所以式 (33) 同样给出精确的 LQR 分离，差距至少为 $1/24$。

## 9. 适用范围与既有工具的归属

- 本文结论适用于重复使用同一个标量独立同分布扰动法则、完全观测、控制无约束的有限时域 LQR。本文不据此声称结论可推广到多维扰动、部分观测、随时间漂移的分布、逐阶段自适应对手或无限时域。
- 证明使用了 $s_0$ 与 $\delta$ 均为正这一条件。当 $\delta=0$ 时，共同均值已知，所有遗憾值均为零。式 (12)—(30) 并未证明 $s_0=0$、$\delta>0$ 的边界情形；该情形需要单独论证，且不属于已冻结的首轮问题。
- 三次策略的平方可积性由独立性和互异样本指标保证。若将 $U_{j,3}$ 替换为 $\bar X_j^3$ 或 $X_i^3$ 的平均值，则仅需二阶矩的结论不再成立。
- 有限维仿射归约、凸极小极大定理、贝叶斯条件均值下界与 U 统计量方法，均属于已有工具。本文主张的增量是共同分布矩歧义下全体规则与仿射规则之间的精确边界，以及构造性的一致非线性分离，其中包括向 LQR 的转移。
- 本文为研究初稿。内部检查和精确有限计算不能替代外部同行评审或证明助手内核检查。形式化是一项独立且尚未完成的证明义务。

## 10. 一般矩域：陡暴露面阻断与临界刚性

### 10.1. 结论与范围

设 $K\subset\mathbb R_+^2$ 非空、紧且凸。考虑 $\mathbb R$ 上所有具有有限二阶矩、并满足下式的 Borel 分布：

$$
(\mu(P)^2,v(P))\in K.
$$

观测独立同分布地采自同一个共同分布。仍采用不全为零的有限非负阶段权重序列，并考虑在每个可容许分布下均平方可积的全体 Borel 估计量。假设存在具有正坐标矩对 $(x_*,v_*)$ 的仿射鞍点。令

$$
\rho=v_*/x_*>0,\qquad
N=\max\{t\geq1:q_t>0\},\qquad
 a_t=\frac{t}{t+\rho}\quad(q_t>0),\qquad f_0=0,
$$

并定义

$$
A=\sum_{t\geq1}q_t\frac{t}{(t+\rho)^2}>0,
\qquad
B=q_0+\sum_{t\geq1}q_t\frac{\rho^2}{(t+\rho)^2}>0.
\tag{S1}
$$

第 1—2 节使用的标准仿射鞍点归约同样适用于紧凸集 $K$，因此最优仿射风险为 $Bx+Av$。定义

$$
\beta=B/A>0,\qquad \alpha=V_{\rm aff}/A>0.
$$

其最坏矩的暴露面可能是一个点，也可能是一条非退化线段，具体为

$$
F=\{(x,v)\in K:v+\beta x=\alpha\}.
\tag{S2}
$$

**定理 S1（陡暴露面阻断）。** 若 $N\geq3$ 且 $\beta>1$，则

$$
V_{\rm all}<V_{\rm aff}.
\tag{S3}
$$

这里不要求最坏矩对唯一，也不要求任何曲率。该结论涵盖最大有效观测数至少为三的所有零权重配置。证明给出一个有界连续估计量族存在性的结论，该估计量族取得严格的一致改善，但证明并未指定其系数或给出数值差距。

**定理 S2（临界斜率刚性）。** 假设 $N\geq2$、$\beta=1$ 且 $V_{\rm all}=V_{\rm aff}$。取下文定义的方差向下闭包后，存在最不利先验。对于有界连续决策博弈，每个这样的先验均支撑于原始仿射暴露面。在该先验下，几乎每个分布均满足

$$
P(X^2=\alpha)=1.
\tag{S4}
$$

因此，尽管歧义类包含任意支撑的分布，等值关系仍强迫最不利先验成为具有同一二点支撑 $\{-\sqrt\alpha,\sqrt\alpha\}$ 的独立同分布法则的混合。这强于仅仅构造一个由二点采样分布组成的最不利先验。

证明使用了正坐标鞍点、有限时域、独立同分布的共同分布结构以及标量观测等假设。本文不对缓暴露面的范围 $0<\beta<1$ 进行分类。

### 10.2. 在保持完整极小极大值的同时闭合分布类

令

$$
D=\{(x,v)\in\mathbb R_+^2:\text{ there is }v'\geq v
                  \text{ with }(x,v')\in K\}.
\tag{S5}
$$

这是仅在方差坐标上取的向下闭包。它是紧凸集。以 $\mathcal Q_K$ 与 $\mathcal Q_D$ 表示对应的分布类。令

$$
M=\sqrt{\max_{(x,v)\in K}x}>0,\qquad
C=\max_{(x,v)\in K}(x+v)<\infty.
$$

这两个类中的每个分布均满足 $|\mu|\leq M$ 与 $EX^2\leq C$。将任意估计量输出投影至 $[-M,M]$，会减小其相对于每个可能目标均值的平方误差。因此，两类分布中不受仿射限制的极小极大值，都可通过具有这一共同值域的有界 Borel 估计量计算。

固定一个均值为 $\mu$、方差为 $v$ 的 $P\in\mathcal Q_D$，并选取满足 $(\mu^2,v')\in K$ 的 $v'\geq v$。对于 $0<\varepsilon<1$，令

$$
b_\varepsilon=
\sqrt{v+\frac{v'-v}{\varepsilon}},\qquad
P_\varepsilon=(1-\varepsilon)P
 +\frac\varepsilon2\delta_{\mu+b_\varepsilon}
 +\frac\varepsilon2\delta_{\mu-b_\varepsilon}.
\tag{S6}
$$

该分布具有相同均值，其方差为

$$
(1-\varepsilon)v+\varepsilon b_\varepsilon^2=v'.
$$

因此，$P_\varepsilon\in\mathcal Q_K$，且它与 $P$ 的总变差距离至多为 $\varepsilon$。阶段 $t$ 的乘积分布之间的总变差距离至多为 $t\varepsilon$。对于输出位于 $[-M,M]$ 的估计量族，平方损失位于 $[0,4M^2]$，并且式 (S6) 中的均值完全相同。因此，

$$
|\mathcal R(f,P_\varepsilon)-\mathcal R(f,P)|
\leq4M^2\varepsilon\sum_t t q_t.
\tag{S7}
$$

于是，对每个有界估计量族分别有

$$
\sup_{P\in\mathcal Q_K}\mathcal R(f,P)
=\sup_{P\in\mathcal Q_D}\mathcal R(f,P).
\tag{S8}
$$

取下确界并使用截断归约，得到

$$
V_{\rm all}(K)=V_{\rm all}(D).
\tag{S9}
$$

这一等式不声称无界估计量的风险关于总变差距离连续。式 (S7) 仅使用了有界估计量。

### 10.3. 弱紧性与最不利先验

#### 10.3.1. 补全分布类的弱紧性

二阶矩的一致有界性使 $\mathcal Q_D$ 成为紧性族，并且保证一阶矩一致可积：

$$
\sup_{P\in\mathcal Q_D}
 E_P[|X|\mathbf1_{\{|X|>R\}}]\leq C/R.
\tag{S10}
$$

因此，先截断恒等函数再使用式 (S10)，可知均值在这个具有一致界的分布类内关于弱收敛连续。

为检验弱闭性，设 $P_n\in\mathcal Q_D$ 弱收敛于 $P$。二阶矩的下半连续性给出 $E_PX^2\leq C$，并且均值收敛。选取满足 $v_n'\geq v(P_n)$ 的 $(\mu(P_n)^2,v_n')\in K$。沿某个子序列，由 $K$ 的紧性得到 $v_n'\to v'$ 及 $(\mu(P)^2,v')\in K$。下半连续性不等式与均值收敛给出

$$
v(P)\leq\liminf_n v(P_n)\leq v'.
$$

因此，$P\in\mathcal Q_D$。紧性族性质与弱闭性证明，$\mathcal Q_D$ 在弱收敛拓扑下是紧度量空间。该论证允许弱极限中的方差损失，而这正是使用闭包 (S5) 的原因。

#### 10.3.2. 有界连续决策博弈

令 $\mathcal F_c$ 为满足下述条件的估计量族组成的凸集：

$$
f_t\in C_b(\mathbb R^t;[-M,M]),
$$

其中包括常数 $f_0\in[-M,M]$。对于固定的 $f\in\mathcal F_c$，函数 $P\mapsto\mathcal R(f,P)$ 在 $\mathcal Q_D$ 上连续：乘积分布弱收敛，对应的有界连续被积函数在相关积分中收敛，而均值由式 (S10) 收敛。其值域一致地以 $4M^2\sum_tq_t$ 为上界。

令 $\Pi$ 遍历紧度量空间 $\mathcal Q_D$ 上的概率测度。记它们组成的弱紧凸空间为 $\mathfrak P(\mathcal Q_D)$。积分风险

$$
L(f,\Pi)=\int\mathcal R(f,P)\,d\Pi(P)
$$

关于 $\Pi$ 为连续仿射函数，关于 $f$ 在乘积一致范数下为连续凸函数。因此，先验一侧紧的凸极小极大定理给出

$$
\inf_{f\in\mathcal F_c}\sup_{P\in\mathcal Q_D}\mathcal R(f,P)
=\max_{\Pi\in\mathfrak P(\mathcal Q_D)}
  \inf_{f\in\mathcal F_c}L(f,\Pi).
\tag{S11}
$$

最大值存在，因为关于 $\Pi$ 的连续函数族之下确界在紧集上是上半连续的。这一形式的极小极大定理不要求决策集紧。

对于每个固定先验，式 (S11) 的内层下确界等于全体 Borel 估计量中的通常贝叶斯风险。事实上，条件均值 $h_t=E_\Pi[\mu(P)\mid X_1,\ldots,X_t]$ 位于 $[-M,M]$。有界连续函数在 $\mathbb R^t$ 上 $(X_1,\ldots,X_t)$ 的边缘分布对应的 $L^2$ 空间中稠密。在该空间中逼近 $h_t$，并将逼近函数投影至 $[-M,M]$；该操作保持连续性且不会增加逼近误差。由于阶段数有限，这就能够逼近整个加权贝叶斯风险。因此，

$$
\inf_{f\in\mathcal F_c}L(f,\Pi)
=\sum_tq_t E_\Pi[(h_t-\mu(P))^2].
\tag{S12}
$$

这一步稠密性论证是必要的：仅凭极小极大定理，只能得到连续规则博弈的最不利先验。

### 10.4. 假设仿射等值时的推论

为了反证或分析刚性，假设

$$
V_{\rm all}(K)=V_{\rm aff}(K)=V.
\tag{S13}
$$

仿射鞍点规则 $a_t\bar X_t$ 在整个 $D$ 上的风险满足 $Bx+Av\leq V$，因为 $D$ 中每一点都位于 $K$ 中具有相同 $x$ 的某一点下方，且 $A>0$。将该规则逐坐标截断至 $[-M,M]$，得到 $\mathcal F_c$ 中的一个成员，而风险不会增加。反过来，$\mathcal F_c$ 是全体可测规则类的子集。因此，式 (S9) 与 (S13) 将式 (S11) 左端的值确定为 $V$。

对于严格改善结论，下述论证只需要式 (S11) 中的有界连续博弈值等于 $V_{\rm aff}$，并不需要更强的假设 (S13)。截断已将该博弈值的上界限制为 $V_{\rm aff}$。若等号成立，后续步骤将在 $\beta>1$ 时导出同样的矛盾。因此，证明还表明有界连续博弈值严格更小，进而存在一个实现严格改善的有界连续估计量族。这里不假设有界连续类与全可测类的极小极大值一般总是相等。

任取式 (S11) 的一个最大化先验 $\Pi$。由式 (S12)，其完整贝叶斯风险为 $V$。原始无界仿射规则的积分风险有限，且以 $V$ 为上界，因为该规则在每个分布下的风险有限，并一致满足 $Bx+Av\leq V$。贝叶斯下界与这一上界迫使

$$
L(a,\Pi)=V.
\tag{S14}
$$

因此，仿射规则本身在每个正权重阶段均为贝叶斯规则。此外，对 $\Pi$ 下几乎每个分布都有 $Bx+Av=V$。$D$ 中满足该条件的点位于原始暴露面 $F$：若 $v'\geq v$ 且 $(x,v')\in K$，则

$$
V=Bx+Av\leq Bx+Av'\leq V,
$$

故由 $A>0$ 必有 $v'=v$。最不利先验不可能在方差严格降低后的点上保留质量。

在阶段 $N$，平方损失的严格条件均值分解与 $q_N>0$ 给出

$$
E_\Pi[\mu\mid X_1,\ldots,X_N]
=\frac{\sum_{i=1}^N X_i}{N+\rho}
\quad\text{almost surely}.
\tag{S15}
$$

即使中间阶段权重为零，塔式性质仍将这一恒等式传递至每个 $0\leq n\leq N$。若 $h_n=E_\Pi[\mu\mid X_1,\ldots,X_n]$，则条件独立同分布采样给出

$$
(N+\rho)h_n
=\sum_{i=1}^nX_i+(N-n)h_n.
$$

于是

$$
h_n=\frac{\sum_{i=1}^nX_i}{n+\rho},
\quad 1\leq n\leq N,
\qquad E_\Pi\mu=0.
\tag{S16}
$$

由于 $|h_1|\leq M$，单观测恒等式迫使

$$
|X_1|\leq(\rho+1)M\quad\text{under the prior-predictive law}.
\tag{S17}
$$

等价地，$\Pi$ 下几乎每个组成分布的支撑都位于这一固定有界区间中。因此，下文所有四阶矩计算均由**所假设的等值关系**保证合法，而不依赖对原始歧义类增加任何假设。

### 10.5. 精确方差恒等式

对于每个组成分布，记 $M_r(P)=E_PX^r$。令

$$
u=E_\Pi\mu^2,\qquad \tau=E_\Pi\mu^4.
$$

在暴露面上，

$$
M_2=v+\mu^2=\alpha-(\beta-1)\mu^2.
\tag{S18}
$$

将 $n=1$ 的后验恒等式乘以 $X_1$ 并取期望，得到

$$
E_\Pi M_2=(\rho+1)u,
\qquad \alpha=(\rho+\beta)u.
\tag{S19}
$$

特别地，$u>0$。将 $n=3$ 的后验恒等式乘以 $X_1X_2X_3$ 并取期望，得到

$$
\tau=\frac3{\rho+3}E_\Pi[\mu^2M_2]
=\frac3{\rho+3}[\alpha u-(\beta-1)\tau],
$$

因此，

$$
\tau=\frac{3\alpha u}{\rho+3\beta}.
\tag{S20}
$$

将 $n=1$ 的后验恒等式乘以 $X_1^3$ 并取期望，得到

$$
E_\Pi M_4=(\rho+1)E_\Pi[\mu M_3].
\tag{S21}
$$

将 $n=2$ 的后验恒等式乘以 $X_1^2X_2$ 并取期望，得到

$$
E_\Pi[\mu M_3]
=(\rho+2)E_\Pi[\mu^2M_2]-E_\Pi M_2^2.
\tag{S22}
$$

结合以上两个方程，

$$
E_\Pi\operatorname{Var}_P(X^2)
=(\rho+2)\bigl[(\rho+1)E_\Pi(\mu^2M_2)-E_\Pi M_2^2\bigr].
\tag{S23}
$$

为明确起见，右端的两个期望分别为

$$
E_\Pi(\mu^2M_2)=\alpha u-(\beta-1)\tau,
$$

$$
E_\Pi M_2^2
=\alpha^2-2\alpha(\beta-1)u+(\beta-1)^2\tau.
$$

代入式 (S19) 与 (S20)，得到精确恒等式

$$
\boxed{\quad
E_\Pi\operatorname{Var}_P(X^2)
=-\frac{2\rho(\rho+2)(\beta-1)(\rho+\beta)}{\rho+3\beta}\,u^2.
\quad}
\tag{S24}
$$

左端各项均非负。如果 $\beta>1$，右端严格为负。这与式 (S13) 矛盾，从而证明定理 S1。

当 $\beta=1$ 时，只需 $N\geq2$ 就能得到刚性结论，无须使用 $n=3$ 的计算或式 (S20)。式 (S18) 与 (S19) 给出 $M_2=\alpha$ 和 $u=\alpha/(\rho+1)$。将它们直接代入仅使用一个与两个观测后验恒等式的式 (S23)，得到 $E_\Pi\operatorname{Var}_P(X^2)=(\rho+2)[(\rho+1)\alpha u-\alpha^2]=0$。由非负性可知，对 $\Pi$ 下几乎每个组成分布均有 $\operatorname{Var}_P(X^2)=0$。该分布的二阶矩为 $M_2=\alpha$，故几乎必然有 $X^2=\alpha$。这证明了定理 S2。

对于 $\beta=2$、$\rho=1$ 和 $\alpha=1$，式 (S19) 给出 $u=1/3$，式 (S24) 则变为 $E_\Pi\operatorname{Var}_P(X^2)=-2/7$。这是一个精确的矛盾证书，并非声称某个实际先验具有这样的方差。

### 10.6. 临界斜率矩条件的必要性与平衡面等价关系

当 $\beta=1$ 时，暴露面为 $(x,v)=(\alpha z,\alpha(1-z))$，其中 $z$ 遍历紧区间 $[l,u]$。在所假设的等值关系下，式 (S18) 给出每个先验分布都满足 $M_2=\alpha$。对于每个 $1\leq r\leq N$，将式 (S16) 中 $r$ 个观测的后验恒等式乘以互异样本乘积 $X_1\cdots X_r$，再取期望。由条件独立性得到

$$
E_\Pi\mu^{r+1}
=\frac{r\alpha}{\rho+r}E_\Pi\mu^{r-1}.
\tag{S25}
$$

这些混合乘积期望由一致二阶矩上界即可保证有限；更强的有界支撑结论 (S17) 也足以保证这一点。从 $E\mu^0=1$ 与 $E\mu=0$ 出发，递推 (S25) 确定了直到 $N+1$ 阶的全部矩。特别地，最不利先验下 $Z=\mu^2/\alpha$ 的分布支撑于 $[l,u]$，并满足

$$
E Z^k=\frac{(1/2)_k}{((\rho+1)/2)_k},
\qquad 0\leq k\leq\left\lfloor\frac{N+1}{2}\right\rfloor.
\tag{S26}
$$

因此，第 11 节中的有限 Beta 矩可表示条件，是**整个任意支撑分布类中等值关系成立的必要条件**。相应的贝叶斯构造已给出充分性。二者合起来得到完整的平衡面判据。

对于 $N=1$ 或 $N=2$，建立式 (S11)—(S19) 的同一论证以及直到 $r=N$ 的递推仍然适用，因此矩条件的必要性仍然成立；上文针对刚性的独立短证同样覆盖 $N=2$，但本文不对 $N=1$ 声称刚性。在这些短历史情形中，只需要 $Z$ 的一阶矩。

### 10.7. 两个观测的刚性阈值是精确的

仅有一个观测时，即使 $\beta=1$，也未必能推出二点支撑。取 $q_1=1$，其余权重均为零，并令 $K=\{(1/2,1/2)\}$。仿射规则 $f_1=X_1/2$ 满足 $A=B=1/4$，最坏风险为 $1/4$。对下述两个分布赋予相等先验概率：

$$
P_+=\tfrac12\delta_0+\tfrac12\delta_{\sqrt2},\qquad
P_-=\tfrac12\delta_0+\tfrac12\delta_{-\sqrt2}.
$$

它们的均值分别为 $\pm1/\sqrt2$，方差均为 $1/2$。当观测为零时，后验均值为零；在另两个观测值处，后验均值为 $X_1/2$。因此，仿射规则为贝叶斯规则，两类极小极大值均等于 $1/4$。然而，在每个先验分布下，$X^2$ 都可取零与二，而非恒等于一。这证明定理 S2 中的 $N\ge2$ 阈值不能降低为一。

## 11. 临界面上的精确全类判据

### 11.1. 设定与假设

设 $K\subset\mathbb R_+^2$ 非空、紧且凸。分布类由**所有**具有有限二阶矩且满足 $(\mu^2,v)\in K$ 的 Borel 分布组成，并在独立同分布采样中重复使用。策略类、损失及有限非负权重序列均与第 1 节相同。由相同的对称化与紧极小极大论证，仿射鞍点存在。假设该鞍点满足

$$
a_t=\frac{t}{t+\rho}\quad(t\in I),\qquad \rho>0,
\qquad A=B>0.
$$

这是关于已解仿射问题的可验证假设，并非预设全体规则的极小极大结论。例如，具有正对偶矩 $(x_*,v_*)$、$\rho=v_*/x_*$ 且 $A=B$ 的鞍点即可推出该假设。令 $N=\max I$、$d=\lfloor(N+1)/2\rfloor$，并定义

$$
c^2=\max_{(x,v)\in K}(x+v)>0,
\qquad E=\{(x,v)\in K:x+v=c^2\}.
$$

由凸性与紧性，对某些 $0\le l\le u\le1$ 有 $E=\{(c^2z,c^2(1-z)):l\le z\le u\}$。仿射值为 $V=A c^2$。全部定义都保留零权重与 $q_0$。

### 11.2. 精确判据

定义 $m_0=1$，并令

$$
m_k=\frac{(1/2)_k}{((\rho+1)/2)_k}
\quad(1\le k\le d),
$$

即一个 $\operatorname{Beta}(1/2,\rho/2)$ 随机变量的前 $d$ 个矩。于是

$$
V_{\rm all}=V_{\rm aff}
\iff \text{there is a probability measure $\nu$ on $[l,u]$ with}
\int z^k\,d\nu=m_k\quad(0\le k\le d).
\tag{F1}
$$

若该矩系统不可行，则阶段 $N$ 的一个有限奇数阶多线性修正会严格改善整个 $K$ 中**所有**分布的最坏风险，而不仅是矩位于暴露面上的分布。若该系统可行，则至多由 $2(d+1)$ 个二点分布组成的先验，为每个可测策略给出匹配下界。

#### 11.2.1. 经典有限 Hausdorff 矩阵检验

对于满足 $m_0=1$ 的一般向量 $m=(m_0,\ldots,m_d)$，定义

$$
H_r(m)=[m_{i+j}]_{i,j=0}^r,
\qquad
H_r^{(1)}(m)=[m_{i+j+1}]_{i,j=0}^r.
$$

先假设 $l<u$。经典截断 Hausdorff 定理给出式 (F1) 中矩条件的如下充要条件。

若 $d=2r$ 为偶数，则条件为

$$
H_r(m)\succeq0,
\qquad
D_{r-1}(m;l,u):=
[(l+u)m_{i+j+1}-m_{i+j+2}-lu\,m_{i+j}]_{i,j=0}^{r-1}
\succeq0.
\tag{G10}
$$

当 $r=0$ 时，第二个条件为空。

若 $d=2r+1$ 为奇数，则条件为

$$
H_r^{(1)}(m)-lH_r(m)\succeq0,
\qquad
u H_r(m)-H_r^{(1)}(m)\succeq0.
\tag{G11}
$$

使用这两个双侧区间条件时，式 (G11) 不需要额外的秩或值域条件。两矩阵之和为 $(u-l)H_r$，因此 $H_r$ 的半正定性自动成立。

对于单点区间 $l=u$，直接使用条件

$$
m_k=l^k\quad(k=0,\ldots,d).
\tag{G12}
$$

**该检验为何具有充分性。**

对平方项，或乘以 $z-l$、$u-z$、$(z-l)(u-z)$ 的平方项积分，即可直接得到必要性。对于充分性，带次数界的 Markov–Lukács 表示将每个在 $[l,u]$ 上非负且次数至多为 $2r$ 的多项式，写为一个次数至多为 $2r$ 的平方和，加上 $(z-l)(u-z)$ 乘以一个次数至多为 $2r-2$ 的平方和。对于次数至多为 $2r+1$ 的奇数阶情形，则使用 $(z-l)$ 和 $(u-z)$ 分别乘以次数至多为 $2r$ 的平方和。

因此，式 (G10) 或 (G11) 使矩泛函 $\Lambda_m$ 在相应次数范围内的每个非负多项式上均非负。如果向量 $(m_1,\ldots,m_d)$ 位于 $z\mapsto(z,\ldots,z^d)$ 的紧凸包之外，则有限维严格分离定理将给出一个在 $[l,u]$ 上非负、但 $\Lambda_m$ 值为负的多项式，产生矛盾。因此，表示测度存在。

区间矩阵检验与带次数界的表示均属于已注明归属的经典工具。Curto 和 Fialkow [R13] 第 4 节的定理 4.1、4.3 及备注 4.2、4.4 明确记载了奇数阶与偶数阶的刻画。这里将带次数界的非负多项式表示作为经典定理使用，不另作原创性主张。

#### 11.2.2. 从不满足条件的矩阵构造下降多项式

下述构造给出第 11.4—11.5 节使用的方向。暴露面上的一致下降仍需扩展至整个 $K$。

令 $\Lambda_m(z^k)=m_k$，其中采用第 11.2 节的 Beta 矩，并定义

$$
g_k(z)=(2k+1)z^k-(\rho+2k+1)z^{k+1},
\qquad k=0,\ldots,d-1.
\tag{G13}
$$

第 11.2 节的递推关系表明 $\Lambda_m(g_k)=0$。这 $d$ 个多项式线性无关，因为它们非零首项的次数分别为互不相同的 $1,\ldots,d$。因此，它们构成次数至多为 $d$ 的多项式空间中 $\Lambda_m$ 的核的一组基。

如果式 (G10) 或 (G11) 中某个矩阵具有经过验证的负二次型，则可得到一个次数至多为 $d$ 的多项式 $p$，满足

$$
p(z)\geq0\quad(l\leq z\leq u),\qquad
\Lambda_m(p)<0.
\tag{G14}
$$

具体而言，以负二次型对应向量为系数构造多项式 $h(z)$：若 $H_r$ 不满足半正定条件，则取 $p=h^2$；若偶数阶局部化矩阵不满足条件，则取 $p=(z-l)(u-z)h^2$；若相应奇数阶矩阵不满足条件，则分别取 $p=(z-l)h^2$ 或 $p=(u-z)h^2$。对于 Beta 矩向量，每个 $H_r$ 实际上均正定，因为其二次型是在 $(0,1)$ 上处处为正的密度下，对非零多项式的平方积分；因此，可能失败的只有支撑限制。

令 $\eta=-\Lambda_m(p)>0$。存在唯一系数 $\lambda_k$，使得

$$
p(z)+\eta=\sum_{k=0}^{d-1}\lambda_k g_k(z)\geq\eta
\quad(l\leq z\leq u).
\tag{G15}
$$

对于 $p(z)=\sum_{k=0}^d p_kz^k$，必要时补上零系数，可通过反向代入计算这些系数：

$$
\lambda_{d-1}=-\frac{p_d}{\rho+2d-1},\qquad
\lambda_k=
\frac{(2k+3)\lambda_{k+1}-p_{k+1}}{\rho+2k+1},
\quad k=d-2,\ldots,0.
\tag{G16}
$$

匹配非常数项的系数得到该递推；由于式 (G15) 恒等式两端的 $\Lambda_m$ 值均为零，常数项系数也随之匹配。

如果 $l=u$ 且式 (G12) 不成立，选取一个满足 $m_k\ne l^k$ 的 $k$，令 $p(z)=\sigma(z^k-l^k)$，其中选择 $\sigma\in\{-1,1\}$ 使 $\Lambda_m(p)<0$。该多项式在单点区间上为零，并给出相同构造。

### 11.3. 可行性给出针对所有估计量的贝叶斯下界

取 $Z\sim\nu$ 及一个独立的对称符号，并令 $\Theta=\pm c\sqrt Z$。给定 $\Theta=\theta$，令 $P_\theta$ 为支撑于 $\{-c,c\}$、满足 $P_\theta(c)=(1+\theta/c)/2$ 的分布。每个这样的分布均属于原始类，因为其矩恰好为 $(\theta^2,c^2-\theta^2)\in E$。

令 $Y_i=X_i/c$、$R=\Theta/c$。有限矩后验机制属于经典结果 [R11，第 4 节]。在通常的中心化 Beta 先验 $p=(1+R)/2\sim\operatorname{Beta}(\rho/2,\rho/2)$ 下，共轭性给出

$$
E[\Theta\mid Y_1,\ldots,Y_n]
=\frac{c\sum_iY_i}{n+\rho}
=a_n\bar X_n.
\tag{F2}
$$

在所构造的对称先验下，$R$ 直到 $N+1$ 阶的矩都与该 Beta 先验相同：奇数阶矩为零，偶数阶矩为 $m_k$。对于任意特定的二点观测历史，其似然是关于 $R$ 的 $n$ 次多项式，而后验分子的次数为 $n+1$。因此，对于所有 $n\le N$，该历史的概率及后验分子均与通常 Beta 先验下的数值相同。Beta 先验对每个这样的历史均赋予正概率，故分母非零，从而得到式 (F2)。没有观测时的后验均值为零。因此，仿射鞍点在每个正权重阶段均为贝叶斯规则。其在先验中的每个分布下的风险均为 $Ac^2$。通常的先验平均下界证明 $V_{\rm all}\ge Ac^2$，而由策略类的包含关系得到等值结论。

这里只指定了有限多个矩。矩向量属于 $(z,z^2,\ldots,z^d)$、$z\in[l,u]$ 的凸包。因此，由 Carathéodory 定理，可取至多具有 $d+1$ 个原子的 $\nu$，得到上述有限先验的大小上界。这是支撑大小的上界，并不声称整个 Beta 先验位于受约束的暴露面内。

### 11.4. 不可行性产生显式方向

对于 $k=0,\ldots,d-1$，定义

$$
\gamma_k(z)=z^k\big[(2k+1)-(\rho+2k+1)z\big].
$$

原点属于 $\operatorname{conv}\{\gamma(z):z\in[l,u]\}$，当且仅当该区间上存在概率测度满足

$$
(\rho+2k+1)\int z^{k+1}\,d\nu
=(2k+1)\int z^k\,d\nu \quad(0\le k<d).
$$

从零阶矩出发，这些递推恰好给出式 (F1) 中的矩。因此，式 (F1) 不可行等价于原点不属于该紧凸包。严格分离给出向量 $b\in\mathbb R^d$ 和 $\eta>0$，使每个 $z\in[l,u]$ 都满足 $b\cdot\gamma(z)\ge\eta$。

第 11.2.2 节的矩阵构造通过取 $b_k=\lambda_k$，直接给出这样的向量。

对于 $1\le r\le N$，令

$$
U_{N,r}=\binom Nr^{-1}\sum_{|S|=r}\prod_{i\in S}X_i.
$$

由独立性，无须任何单观测高阶矩即可得到

$$
E U_{N,r}=\mu^r,\quad
E[\bar X_NU_{N,r}]=\mu^{r+1}+\frac rN v\mu^{r-1},\quad
E U_{N,r}^2\le (x+v)^r\le c^{2r}.
\tag{F3}
$$

令

$$
W=\sum_{k=0}^{d-1} b_k c^{-2k}U_{N,2k+1},
\qquad f_N^\epsilon=a_N\bar X_N-\epsilon W.
$$

其他规则均保持不变。记 $a=a_N$、$q=q_N>0$，并定义

$$
C(x,v)=q E[(a\bar X_N-\mu)W].
$$

由于 $1-a=a\rho/N$，式 (F3) 表明在 $E$ 上有

$$
C(c^2z,c^2(1-z))
=\frac{qa c^2}{N}\,b\cdot\gamma(z)
\ge\kappa:=\frac{qa c^2\eta}{N}>0.
\tag{F4}
$$

整个 $K$ 上的精确风险恒等式为

$$
R_\epsilon(x,v)=A(x+v)-2\epsilon C(x,v)
 +\epsilon^2 qE W^2.
\tag{F5}
$$

这里，$C$ 是关于 $x,v$ 的多项式。Minkowski 的 $L^2$ 不等式给出

$$
qE W^2\le W_0:=q c^2\|b\|_1^2,
\qquad |C(x,v)|\le D_0:=q c^2\|b\|_1.
\tag{F6}
$$

对于后一个上界，阶段仿射均方误差至多为 $c^2$，因为 $(1-a)^2x+a^2v/N\le x+v\le c^2$。

### 11.5. 一致步长控制暴露面之外的全部矩

令 $F=\{(x,v)\in K:C(x,v)\le\kappa/2\}$。若 $F$ 非空，则由紧性、式 (F4) 及暴露面的定义得到

$$
h:=\min_F A(c^2-x-v)>0.
$$

选取

$$
0<\epsilon\le
\min\left\{\frac{\kappa}{2W_0},
            \frac{h}{8D_0},\sqrt{\frac{h}{4W_0}}\right\}.
\tag{F7}
$$

在 $F$ 之外，式 (F5) 给出 $R_\epsilon\le V-\epsilon\kappa/2$。在 $F$ 上，式 (F5)—(F7) 给出 $R_\epsilon\le V-h/2$。因此，一致严格差距至少为 $\min\{\epsilon\kappa/2,h/2\}>0$。若 $F$ 为空，则仅需式 (F7) 中的第一个上界，差距至少为 $\epsilon\kappa/2$。这完成了式 (F1) 对不受限制策略类的必要方向证明，而不仅是给出某个多项式类中的驻点条件。

这些常数完全由已解的仿射博弈、一个有限分离多项式以及 $K$ 上的紧多项式最小化问题确定。对于显式给出的半代数集 $K$，它们构成一个有限代数证书问题。本文不声称对任意编码形式的 $K$ 都能高效地在多项式时间内完成计算。

### 11.6. 首个非平凡判据与精确阻断

当 $N=3$ 或 $N=4$ 时，$d=2$。令

$$
m=\frac1{\rho+1},\qquad
\sigma_Z^2=\frac{2\rho}{(\rho+1)^2(\rho+3)}.
$$

矩条件等价于

$$
l\le m\le u,\qquad (m-l)(u-m)\ge\sigma_Z^2.
\tag{F8}
$$

对 $(Z-l)(u-Z)\ge0$ 积分即可得到必要性。对于充分性，若 $u>l$，则均值为 $m$ 的端点分布具有方差 $(m-l)(u-m)$；将其与位于 $m$ 的原子混合，可在保持均值不变的同时实现从零到该值之间的任意方差。$u=l$ 的情形不可能满足式 (F8)，因为 $\rho>0$ 给出严格正的方差。

作为精确实例，设 $q_0=1/8$、$q_3=1$，其余权重均为零，$\rho=1$，并令

$$
l=(2-\sqrt2)/4,\qquad u=(2+\sqrt2)/4,
\qquad
K=\{x,v\ge0:x\le u,\ v\le1-l,\ x+v\le1\}.
$$

规则 $f_0=0$、$f_3=(X_1+X_2+X_3)/4$ 满足 $A=B=3/16$。在暴露面上，$m=1/2$ 且 $(m-l)(u-m)=1/8=\sigma_Z^2$。支撑为 $\{-1,1\}$、均值为 $\pm\sqrt l,\pm\sqrt u$ 的四个分布各取先验概率 $1/4$，给出匹配的全类贝叶斯下界。因此，尽管整个最坏暴露面均满足 $x,v>0$，且存在一个有效的三样本阶段，两类值仍均为 $3/16$。将该区间替换为围绕 $1/2$ 的更窄对称区间，仍保持相同的仿射鞍点，但会违反式 (F8)，因此某个非线性规则将严格改善它。由此可见，暴露面的宽度构成实质性的统计阻断条件。

## 12. 所有多线性修正的局限与精确实例

### 三角形矩集

设 $\alpha,\beta>0$，并令

$$
K_{\alpha,\beta}=\{(x,v)\in\mathbb R_+^2:\beta x+v\le\alpha\}.
$$

假设 $I=\{t\ge1:q_t>0\}$ 非空，且

$$
q_0<\beta\sum_{t\in I}\frac{q_t}{t}.
\tag{B1}
$$

存在唯一的 $\rho>0$ 满足

$$
\Psi(\rho)=q_0+\sum_{t\in I}q_t\frac{\rho^2-\beta t}{(t+\rho)^2}=0.
\tag{B2}
$$

事实上，$\Psi(0)<0$，其在无穷远处的极限为 $q_0+\sum q_t>0$，且每个求和项的导数为 $2q_t t(\rho+\beta)/(t+\rho)^3>0$。令 $a_t=t/(t+\rho)$、$A=\sum q_t t/(t+\rho)^2$。式 (B2) 即为 $B=\beta A$。仿射风险为 $A(\beta x+v)$，最大值为 $A\alpha$。在 $x_*=\alpha/(\beta+\rho)$、$v_*=\rho x_*$ 处，这些系数逐阶段最小化固定矩下的仿射风险。因此，这构成一个具有正对偶矩的仿射鞍点，且 $V_{\rm aff}=A\alpha$。

### 所有多线性多项式具有相同的极小极大值

多线性规则是观测的一个多项式，其中每个单独观测的次数至多为一。这里不将总次数限制为三次。由于时域有限，该规则在矩类中的每个分布下自动平方可积。记这类规则族的极小极大值为 $V_{\rm multi}$。

取

$$
Z\sim\operatorname{Beta}(1/2,\rho/(2\beta)),\quad
x=\frac{\alpha}{\beta}Z,\quad v=\alpha-\beta x,
\quad\mu=\pm\sqrt x
$$

并使用一个独立的对称符号。对于每个 $(\mu,v)$，选取在 $\mu-\sqrt v$ 与 $\mu+\sqrt v$ 处各赋予二分之一概率的二点分布。这定义了可容许独立同分布法则上的一个实际先验，其全部矩均位于暴露面上。选择这些实现分布，并不意味着仿射规则在任意估计量中均为贝叶斯最优。

对于每个整数 $k\ge0$，Beta 矩递推给出

$$
[(2k+1)\beta+\rho]E x^{k+1}
=(2k+1)\alpha E x^k.
\tag{B3}
$$

固定阶段 $t$，对于奇数次数 $r=2k+1\le t$ 的互异样本单项式，由独立性得到先验平均交叉矩

$$
E[(a_t\bar X_t-\mu)\prod_{i\in S}X_i]
=\frac{a_t}{t} E\{x^k[r\alpha-(r\beta+\rho)x]\}=0.
\tag{B4}
$$

由反射对称性，包括常数在内的偶数次数单项式的交叉矩为零。因此，仿射误差在先验预测的 $L^2$ 空间中，与**每个**多线性扰动正交，其中包括非对称扰动。展开平方损失可证明，该仿射规则在整个多线性类内逐个正权重阶段最小化先验平均损失。由先验对称性，无观测阶段的零规则最优。其平均损失为 $A\alpha$。因此，

$$
V_{\rm multi}=V_{\rm aff}=A\alpha.
\tag{B5}
$$

然而，当 $\beta>1$ 且 $\max I\ge3$ 时，陡暴露面定理给出

$$
V_{\rm all}<V_{\rm multi}=V_{\rm aff}.
\tag{B6}
$$

这是一个精确阻断结果，说明仅靠增加互异样本多项式项，无法解决一般的不依赖分布形式的问题。它与偏移圆盘结果并不矛盾，因为后者具有唯一暴露点，允许三次方向下降。式 (B6) 保证存在的策略可选为有界连续策略，但该论证没有给出其最优策略的闭式公式或最优值的数值。

### 一个精确且确实可实现的实例

取 $\alpha=1$、$\beta=2$、$q_0=5/16$、$q_3=1$，其余权重均为零。此时 $\rho=1$、$a_3=3/4$、$A=3/16$、$B=3/8$，并且

$$
V_{\rm all}<\frac3{16}=V_{\rm multi}=V_{\rm aff}.
\tag{B7}
$$

如果某个全类最不利先验使仿射规则为贝叶斯规则，陡暴露面恒等式将要求 $E_\pi\operatorname{Var}_P(X^2)=-2/7$，与非负性矛盾。多线性下界先验则使用 $Z\sim\operatorname{Beta}(1/2,1/4)$，它并不是全类贝叶斯证书。

### 退化权重分支

若式 (B1) 不成立，选取 $a_t=1$。此时 $A=\sum q_t/t$、$B=q_0\ge\beta A$，最坏仿射风险为 $q_0\alpha/\beta$。均值分别为 $\pm\sqrt{\alpha/\beta}$ 的两个确定性分布，仅由无观测阶段就给出匹配下界。因此，在这一分支中，$V_{\rm all}=V_{\rm aff}=q_0\alpha/\beta$，即使 $\beta>1$ 且后期权重为正也如此。这说明陡暴露面定理中的正对偶方差假设不可缺少。

### 临界斜率另一侧的精确性

当 $\beta=1/m$ 且 $m\ge1$ 为整数时，在非退化分支 (B1) 中，完整三角形暴露面也具有全类贝叶斯证书。令 $c=\sqrt{\alpha/\beta}$，条件于 $p$ 抽取 $Y\sim\operatorname{Binomial}(m,p)$，并令 $X=c(2Y/m-1)$。此时 $\mu=c(2p-1)$，且 $v=\alpha-\beta\mu^2$。先验 $p\sim\operatorname{Beta}(m\rho/2,m\rho/2)$ 在每个有限阶段均给出 $E[\mu\mid X_1,\ldots,X_t]=\sum_iX_i/(t+\rho)$。因此，它证明这些三角形上有 $V_{\rm all}=V_{\rm aff}$。这是一个经典的 Beta–二项构造，列入本文是为了界定新阻断结论的范围。本文不对每个 $0<\beta<1$ 声称分类结果。

### 临界暴露面过窄时的显式改善规则

为使临界面算法具体化，取 $q_0=1/8$、$q_3=1$、$\rho=1$，并令

$$
K=\{x,v\ge0:x\le3/4,\ v\le3/4,\ x+v\le1\}.
$$

仿射鞍点为 $a_3=3/4$、$A=B=3/16$，对应暴露面 $z=x\in[1/4,3/4]$。所需 Beta 矩为 $m_1=1/2$、$m_2=3/8$。局部化多项式 $p(z)=(z-1/4)(3/4-z)$ 的 Beta 期望为 $-1/16$，因此矩判据不成立。令 $g_0=1-2z$、$g_1=3z-4z^2$，则

$$
p(z)+1/16=-g_0(z)/8+g_1(z)/4\ge1/16
\quad(1/4\le z\le3/4).
$$

取 $W=-U_{3,1}/8+U_{3,3}/4$ 和 $\epsilon=1/16$。所得规则为

$$
f_0=0,\qquad
f_3=\frac{97}{128}\bar X_3-\frac1{64}X_1X_2X_3.
\tag{B8}
$$

其交叉项为 $C=(x-v)/32+(3xv-x^2)/16$。在暴露面上，$C\ge1/64$。$K$ 中每个点都可逐坐标向上移动至暴露面，总坐标变化量为 $1-x-v$。在矩形 $[0,3/4]^2$ 上，$|C_x|\le11/64$ 且 $|C_v|\le7/64$，因此

$$
C(x,v)\ge\frac1{64}-\frac{11}{64}(1-x-v),
\qquad EW^2\le(1/8+1/4)^2=9/64.
$$

展开风险并使用仿射亏量，得到

$$
\sup_{P:(\mu^2,v)\in K}\mathcal R(f,P)
\le\frac3{16}-\frac{\epsilon}{32}+\frac{9\epsilon^2}{64}
=\frac{3049}{16384}<\frac3{16},
\tag{B9}
$$

这里使用了 $3/16-11\epsilon/32>0$。经过证明的改善量为 $23/16384$。这是一个仅需二阶矩、在连续定义域上一致成立的上界，并非在有限个分布上进行数值优化。

## 13. 推广结果解决了哪些问题

原始偏移圆盘问题已在其冻结的全部量词下得到解决。尽管一般陡暴露面定理给出了另一个存在性证明，原始的显式三次证书仍有用途。推广部分允许最坏矩暴露面不唯一，识别了临界斜率下的最不利统计实验，并在该临界面上给出精确的有限检验与可容许修正。它还在指定的三角形模型中，证明全体可测规则与整个多线性多项式类之间存在严格差距。

陡暴露面的存在性证明既不识别最优非线性规则，也不量化其差距。一般的缓暴露面 $0<\beta<1$ 仍不在分类范围内。原始结果及其推广均不涉及向量扰动、随时间变化的分布、部分观测或无限时域。在 LQR 解释中，标量噪声可重构及 Bellman 控制 Hessian 正定的假设仍然有效。相同的统计权重通过已注明归属的控制恒等式，将几何结果转移至控制问题。

随附的精确程序检查代数恒等式、有限贝叶斯实验与显式多项式证书。它们不验证测度论紧性，也不充当证明助手内核。本文不声称已提供 Lean 源码或完成形式化。首轮稿件及其独立价值审查作为研究来源记录保留，二次研究结果不替代这些历史记录。

## 参考文献

[R1] L.-B. Fiechtner and J. Blanchet. *Distributionally Robust Regret Optimal
LQR with Common Stage-Law Ambiguity*. arXiv:2604.06158v3, 23 September 2026.
[Official full text](https://arxiv.org/html/2604.06158v3).

[R2] L.-B. Fiechtner and J. Blanchet. *Regret-Optimal Linear-Quadratic Control
under Distributional Drift*. arXiv:2610.09220v1, 6 October 2026.
[Official full text](https://arxiv.org/html/2610.09220v1).

[R3] Y. C. Eldar and N. Merhav. *A Competitive Minimax Approach to Robust
Estimation of Random Parameters*. IEEE Transactions on Signal Processing
52(7), 1931--1946, 2004. [DOI](https://doi.org/10.1109/TSP.2004.828931).
[Author-hosted published text](https://www.weizmann.ac.il/math/yonina/sites/math.yonina/files/A%20Competitive%20Minimax%20Approach.pdf).

[R4] E. Marchand, F. Perron and R. Gueye. *Minimax Estimation of a Binomial
Proportion p When |p-1/2| Is Bounded*.
[Authors' report](https://www.usherbrooke.ca/mathematiques/fileadmin/sites/mathematiques/documents/Recherche/Publications/Rapports_de_recherche/rr13.pdf).

[R5] W. Hoeffding. *A Class of Statistics with Asymptotically Normal
Distribution*. Annals of Mathematical Statistics 19, 293--325, 1948.
[DOI](https://doi.org/10.1214/aoms/1177730196).

[R6] K. H. Schlag. *How to Attain Minimax Risk with Applications to
Distribution-Free Nonparametric Estimation and Testing*. Author manuscript,
12 March 2007.
[Full text](https://homepage.univie.ac.at/karl.schlag/research/statistics/MinimaxRisk.pdf).

[R7] R. Dykstra. *Minimax Estimation of a Mean Vector for Distributions on
a Compact Set*. ASTIN Bulletin 20(2), 1990.
[DOI](https://doi.org/10.2143/AST.20.2.2005440).
[Society-hosted full text](https://www.casact.org/sites/default/files/database/astin_vol20no2_173.pdf).

[R8] V. A. Nguyen, S. Shafieezadeh-Abadeh, D. Kuhn and P. Mohajerin Esfahani.
*Bridging Bayesian and Minimax Mean Square Error Estimation via Wasserstein
Distributionally Robust Optimization*. Mathematics of Operations Research
48(1), 1--37, 2023. [DOI](https://doi.org/10.1287/moor.2021.1176).

[R9] J. Nylöf, D. Kuhn, J. Lygeros and G. Ferrari-Trecate. *Optimality of
Affine Policies in Distributionally Robust Linear-Quadratic Control with
Temporally Correlated Noise*. arXiv:2609.27653, 2026.
[Official abstract](https://arxiv.org/abs/2609.27653). Abstract-only comparison.

[R10] M. Sion. *On General Minimax Theorems*. Pacific Journal of Mathematics
8, 171--176, 1958.
[Original article](https://msp.org/pjm/1958/8-1/pjm-v8-n1-p14-s.pdf).

[R11] P. Diaconis and D. Ylvisaker. *Conjugate Priors for Exponential
Families*. Annals of Statistics 7(2), 269--281, 1979.
[DOI](https://doi.org/10.1214/aos/1176344611).
[Full text](https://www.cs.columbia.edu/~blei/fogm/2020F/readings/DiaconisYlvisaker1979.pdf).
Section 4 explicitly discusses finite-sample moment matching.

[R12] S. E. Fienberg. *Linear and Quasi-Linear Bayes Estimators*.
University of Minnesota technical report, 1978.
[Institutional full text](https://conservancy.umn.edu/bitstreams/28187e28-ffbc-445e-a300-79ddada5d54d/download).
The linear Bayes shrinkage and prior-moment method are credited background.

[R13] R. E. Curto and L. A. Fialkow. *Recursiveness, Positivity, and
Truncated Moment Problems*. Houston Journal of Mathematics 17(4),
603--635, 1991.
[Original journal text](https://hjm.math.uzh.ch/v017n4/0603CURTO.pdf).
Section 4 supplies the classical interval-moment tests used here.

[R14] J. J. A. Moors. *Momentproblems and Truncated Binomial Estimation*.
Research memorandum, 1979.
[Institutional PDF](https://pure.uvt.nl/ws/portalfiles/portal/1177620/MJJA5615795.pdf).
The audit used indexed original-text passages; complete direct retrieval
was unavailable. No unread result is a necessary step in the proofs above.
