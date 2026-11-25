# 随机接受在线选择的秩稀疏化与稀有接受锐极限

## 任意策略传输、因果抽样与异质接受率的信息边界

**研究稿，二次研究版本，2026-11-25。** 本稿给出解析证明与可复算检查；未声称已经外部同行评审或完成形式化验证。全文形式化尚待完成。

### 摘要

在同质不确定接受秘书问题中，候选人以均匀随机顺序到达，决策者只观察相对排名，每次提议以概率 \(p\) 独立被接受，首次接受终止。以各个 top-\(k\) 接受概率对相应离线可用概率的最小比值定义最优稳健比率 \(\gamma_n(p)\)。本文证明两个传输原理。第一，有限三角二项核将接受率 \(p_0\) 下的任意策略，转换为任意 \(p\le p_0\) 下的可实现策略，并精确传输整个成功概率向量；由此得到所有有限 \(n\) 及极限值的非增性，再利用有限截断的存活余量证明 \(n\ge2\) 时严格递减。第二，将带独立历史样本的序数最优停时策略，通过可预测的真实／虚拟硬币切换，合法地模拟为原模型中的提议策略。结合 Correa 等已建立的抽样保证，得到对每个有限 \(n\) 一致成立的显式下界
\[
\gamma_n(p)\ge \frac{c}{(1+\sqrt p)^2},
\]
其中 \(c\simeq0.745\) 是经典 Hill–Kertz 常数。结合原论文已有的极限上界，证明 \(\lim_{p\downarrow0}\gamma_\infty(p)=c\)，并给出不超过 \(2c\sqrt p\) 的差距上界。新增内容是有限策略传输、严格性和序数因果归约；常数、抽样定理与既有上界均明确引用。极限曲线的凸性与最优收敛阶不在本稿结论之内。

第二轮通过达到的最坏尾分布与 Bellman 损失恒等式，进一步证明极限曲线在全部正接受率上严格递减。与此同时，第二轮证明信息边界：在接受率仅于各人到达时可见、且与质量任意相关的模型中，最大接受率趋零仍有一致的经典常数保证；若这些概率参数全部隐藏，则对每个固定上界 \(q>0\)，最优稳健比率关于人数的阶恰为 \(n^{-1/2}\)。上界使用共同全部拒绝路径与排列子序列计数，下界为只用相对秩的在线着色策略。两侧接受指标仍独立，因此这个分离来自概率信息的缺失。

## 1. 问题、文献与精确结论

### 1.1 模型

固定整数 \(n\ge1\)，以绝对秩 \(1,\ldots,n\) 表示互异质量，秩越小越好。到达顺序是均匀随机排列。时刻 \(t\) 的相对秩 \(R_t\) 是当前候选人在前 \(t\) 人中的排名。策略只能利用已经观察到的相对秩、实际发出提议的接受／拒绝结果，以及独立的私人随机化。提议的接受概率为已知共同参数 \(p\in(0,1]\)；每个接受事件与排名、顺序和此前事件独立。拒绝后可以继续，接受后必须停止；不能事后召回被跳过的人。

特别地，决策者不能在决定提议之前观察当前人的接受硬币，也不能观察未提议人的真实接受硬币。可以从相对秩历史重构已见人的相互次序，从而计算任意保留子集中的相对秩；这不需要绝对秩或数值效用。

对可行策略 \(P\)，定义
\[
N_k(P,p)=\Pr(P\text{ 接受到绝对秩不超过 }k\text{ 的人}),\qquad
D_k(p)=1-(1-p)^k .
\tag{1}
\]
令 \(N_0=D_0=0\)，并定义
\[
\gamma_n(p)=\sup_P\min_{1\le k\le n}\frac{N_k(P,p)}{D_k(p)}.
\tag{2}
\]
全部 \(k\) 使用同一个策略。给每个人独立的潜在接受硬币用于分析，则接受 top-\(k\) 的事件包含于其中至少一个人可接受的事件，因此 \(0\le N_k\le D_k\)，从而 \(0\le\gamma_n\le1\)。这里的潜在硬币不是额外提供给策略的信息。

Perez-Salazar、Singh 和 Toriello [1] 建立了该模型、占用概率刻画和稳健目标与单调数值效用目标的关系。本文直接以式 (2) 为目标，无需重新声称上述刻画的原创性。该文还证明 \(\gamma_n(p)\) 随 \(n\) 非增，并收敛到连续线性规划值；记
\[
\gamma_\infty(p)=\inf_{n\ge1}\gamma_n(p)=\lim_{n\to\infty}\gamma_n(p).
\tag{3}
\]

### 1.2 既有常数与开放部分

令 \(\beta>1\) 是方程
\[
\int_0^1\frac{dy}{y(1-\log y)+\beta-1}=1
\tag{4}
\]
的唯一解，其中 \(y\log y\) 在零处按连续延拓解释，令 \(c=1/\beta\)。这是经典 Hill–Kertz 常数，约为 \(0.745\)，不是本稿引入的新常数。积分关于 \(\beta\) 连续严格递减；在 \(\beta\downarrow1\) 时发散，在 \(\beta\to\infty\) 时趋于零，因此定义良定。

[1, Theorem 3、§6 的 Theorem 6 与结论节] 已给出
\[
\gamma_\infty(p)\le c \quad(0<p\le1),
\tag{5}
\]
并提出接受率单调性与低接受率极限问题。式 (5) 是人数趋于无穷的上界，不能加到所有有限 \(n\) 上；例如 \(\gamma_1(p)=1\)。

### 1.3 主结果

**定理 A（任意策略的精确秩传输）。** 给定 \(n\ge1\)、\(0<p\le p_0\le1\) 及 \(p_0\) 下的任意可行策略 \(P_0\)，存在显式可实现的策略 \(P\)，使对全部 \(0\le k\le n\)，
\[
N_k(P,p)=\mathbb E[N_J(P_0,p_0)],\qquad J\sim\operatorname{Bin}(k,p/p_0).
\tag{6}
\]
因此 \(\gamma_n(p)\ge\gamma_n(p_0)\)。

**定理 B（严格性与定量连续性）。** 对 \(n\ge2\)，函数 \(\gamma_n\) 在 \((0,1]\) 严格递减；\(\gamma_1\equiv1\)。对 \(n\in\mathbb N\cup\{\infty\}\) 以及 \(0<p\le p_0\le1\)，
\[
\frac p{p_0}\gamma_n(p)\le\gamma_n(p_0)\le\gamma_n(p).
\tag{7}
\]
所以这些函数在 \((0,1]\) 连续，且 \(p\gamma_n(p)\) 非减。式 (7) 先给出极限值的非增性；第 11 节进一步证明极限严格递减。

**定理 C（独立抽样的因果转移）。** 假设对每个 \(a\in(0,1)\)，一个序数停时规则 \(Q_a\) 在任意有限有序总体上、独立抽样概率为 \(a\) 的模型中，对所有非负单调效用的在线最优值保证同一比例 \(\rho(a)\)。规则根据观察到的连续时钟和序数历史作决策，其决策公式不使用总体大小。则对全部有限 \(n\)、\(p\in(0,1]\)、\(\delta\in(0,1)\)，原不确定接受模型存在一个可行策略 \(P_\delta\)，同时满足
\[
N_k(P_\delta,p)\ge
\rho(a)D_k((1-\delta)p)\quad(1\le k\le n),\qquad
a=\frac{\delta}{\delta+(1-\delta)p}.
\tag{8}
\]
特别地，
\[
\gamma_n(p)\ge(1-\delta)\rho\!\left(\frac{\delta}{\delta+(1-\delta)p}\right).
\tag{9}
\]
定理可取确定性的时间阈值规则，已经足够支持下面的结论。

**定理 D（稀有接受锐极限及一致界）。** 对所有有限 \(n\ge1\) 及 \(0<p\le1\)，
\[
\gamma_n(p)\ge\frac{c}{(1+\sqrt p)^2}.
\tag{10}
\]
因此
\[
\frac{c}{(1+\sqrt p)^2}\le\gamma_\infty(p)\le c,\qquad
0\le c-\gamma_\infty(p)
\le\frac{c(2\sqrt p+p)}{(1+\sqrt p)^2}\le2c\sqrt p,
\tag{11}
\]
并有
\[
\lim_{p\downarrow0}\gamma_\infty(p)=c.
\tag{12}
\]
“锐”指极限常数与已有上界吻合，不表示式 (10) 是每个 \(p\) 的最优值，也不表示式 (11) 的阶或系数最优。

## 2. 有限占用概率与可实现性

定义
\[
x_{t,s}=\Pr(\text{时刻 }t\text{ 尚未接受},\,R_t=s,\,\text{向当前人提议}),
\qquad 1\le s\le t\le n .
\]
这是无条件概率，而不是条件提议率。记
\[
S_t^p(x)=1-p\sum_{i<t}\sum_{r=1}^i x_{i,r}.
\tag{13}
\]

**引理 2.1（既有占用刻画）。** 可实现数组恰为
\[
x_{t,s}\ge0,\qquad t x_{t,s}\le S_t^p(x)
\quad(1\le s\le t\le n).
\tag{14}
\]
对可行数组，处于存活状态且观察到 \(R_t=s\) 时，以概率 \(t x_{t,s}/S_t^p(x)\) 提议即可实现；若分母为零，则取提议概率零。

**证明。** 均匀排列的插入秩 \(R_1,\ldots,R_n\) 相互独立，且 \(R_t\) 在 \([t]\) 上均匀。此前未接受的事件只依赖过去插入秩、提议随机化和过去接受硬币，故与 \(R_t\) 独立。此前在不同时间接受的事件互斥，总概率为 \(p\sum_{i<t,r}x_{i,r}\)，由此得到 (13)–(14)。反之，按上述条件概率构造策略，归纳可得它在时刻 \(t\) 的存活概率恰为 (13)，各提议占用概率恰为 \(x_{t,s}\)。约束保证提议率位于 \([0,1]\)；零存活时所有相应占用量均为零。证毕。这也是 [1] 的有限线性规划基础。

令
\[
A_{t,s,k}=\Pr\{\operatorname{Hypergeom}(n,k,t)\ge s\},\qquad A_{t,s,0}=0 .
\tag{15}
\]
前 \(t\) 人的无序绝对秩集合均匀分布于全部 \(t\) 元子集，并与该集合内部的相对排列、过去私人硬币独立。给定当前相对秩 \(s\) 及任意合法过去历史，当前人的绝对秩在 top-\(k\) 内，当且仅当前 \(t\) 人中有至少 \(s\) 个 top-\(k\) 人。因此
\[
A_{t,s,k}=
\frac{\displaystyle\sum_{\ell=1}^k
\binom{\ell-1}{s-1}\binom{n-\ell}{t-s}}{\binom nt},
\qquad
N_k^p(x)=p\sum_{t=1}^n\sum_{s=1}^t A_{t,s,k}x_{t,s}.
\tag{16}
\]
不可能的二项系数按零解释。该论证允许策略使用完整序数和拒绝历史，未将最优策略类缩小为原先的 Markov 策略。

可行域是非空紧集：零数组可行，(14) 给出 \(0\le x_{t,s}\le1/t\)，约束闭合。式 (2) 在该有限维可行域上的目标连续，因此最优值可以达到。后续严格性证明可以使用最优占用数组。

## 3. 二项秩核与超几何交织

固定 \(q\in(0,1]\)，定义下三角核
\[
K_q(s,r)=
\begin{cases}
\binom{s-1}{r-1}q^{r-1}(1-q)^{s-r},&1\le r\le s,\\
0,&r>s.
\end{cases}
\tag{17}
\]
\(q=1\) 时直接解释为单位核。

**引理 3.1（行、列与复合）。** 对 \(s\ge1\) 及 \(1\le r\le h\)，
\[
\sum_{r=1}^sK_q(s,r)=1,\qquad
q\sum_{s=r}^hK_q(s,r)=\Pr\{\operatorname{Bin}(h,q)\ge r\}\le1 .
\tag{18}
\]
并且 \(K_qK_u=K_{qu}\)，其中每个矩阵乘积的行都只有有限项。

**证明。** 第一式是二项分布的总质量。\(qK_q(s,r)\) 是独立 Bernoulli-\(q\) 试验中第 \(r\) 次成功恰发生在位置 \(s\) 的概率；对 \(s\le h\) 求和得到第二式。最后，将 \(s-1\) 个对象先以概率 \(q\) 保留，再以概率 \(u\) 保留，最终计数服从 \(\operatorname{Bin}(s-1,qu)\)。按中间计数条件化即为矩阵复合式。证毕。尤其应注意，有限列和通常严格小于 \(1/q\)，不能用无穷列和等式替代它。

**引理 3.2（有限交织恒等式）。** 对 \(0\le k\le n\)、\(1\le r\le t\le n\)，有
\[
q\sum_{s=r}^t A_{t,s,k}K_q(s,r)
=\mathbb E[A_{t,r,J}],\qquad J\sim\operatorname{Bin}(k,q).
\tag{19}
\]

**证明。** 从固定 \(n\) 元总体中独立选择一个均匀 \(t\) 元子集 \(T\)。固定其中的 top-\(k\) 身份集合 \(B\)，对 \(B\) 的每个元素独立以概率 \(q\) 加标记，令 \(M\subseteq B\) 为全部标记集合，\(Y=|T\cap M|\)。先条件于 \(H=|T\cap B|\)：\(Y\) 服从 \(\operatorname{Bin}(H,q)\)。由 (18) 和有限求和交换，
\[
\Pr(Y\ge r)=q\sum_{s=r}^t\Pr(H\ge s)K_q(s,r),
\]
即左边。再条件于整个 \(M\)：独立的 \(T\) 仍为原总体中的均匀 \(t\) 元子集，所以 \(Y\mid M\) 服从 \(\operatorname{Hypergeom}(n,|M|,t)\)。而 \(|M|\sim\operatorname{Bin}(k,q)\)，得到右边。全过程的总体大小始终是 \(n\)；没有假设 \(H\) 与 \(|M|\) 独立。证毕。

## 4. 任意策略的精确传输

**定理 A 的证明。** 令 \(q=p/p_0\)，取原策略的可行占用数组 \(x\)，定义
\[
x'_{t,s}=\sum_{r=1}^sK_q(s,r)x_{t,r}.
\tag{20}
\]
由行和等式，
\[
t x'_{t,s}\le S_t^{p_0}(x).
\tag{21}
\]
由有限列和，
\[
p\sum_{s=1}^i x'_{i,s}
=p_0\sum_{r=1}^i x_{i,r}
\Pr\{\operatorname{Bin}(i,q)\ge r\}
\le p_0\sum_{r=1}^i x_{i,r}.
\tag{22}
\]
这里式 (22) 的中间项是对 \(r\) 的加权求和，即每个 \(x_{i,r}\) 乘以其后写出的概率。于是
\[
S_t^p(x')-S_t^{p_0}(x)
=p_0\sum_{i<t}\sum_{r=1}^i x_{i,r}
\Pr\{\operatorname{Bin}(i,q)<r\}\ge0 .
\tag{23}
\]
联立 (21)–(23) 得到 \(t x'_{t,s}\le S_t^p(x')\)，故引理 2.1 给出可实现策略。

对 (16) 代入 (20)，交换有限和，再用 (19) 与 \(p=q p_0\)，可得
\[
\begin{aligned}
N_k^p(x')
&=p\sum_t\sum_r x_{t,r}\sum_{s=r}^t A_{t,s,k}K_q(s,r)\\
&=p_0\sum_t\sum_r x_{t,r}\mathbb E[A_{t,r,J}]
=\mathbb E[N_J^{p_0}(x)] .
\end{aligned}
\tag{24}
\]
若原数组对所有 \(j\) 满足 \(N_j^{p_0}(x)\ge gD_j(p_0)\)，在 \(j=0\) 处也成立，则二项分布的概率生成函数给出
\[
N_k^p(x')\ge g\,\mathbb E[1-(1-p_0)^J]
=g[1-(1-qp_0)^k]=gD_k(p).
\tag{25}
\]
因此每个原稳健保证都得以保留，取最优值得到单调性。证毕。

这是一种占用量转换：可以离线计算数组，再在原信息约束下按引理 2.1 实现。它不要求策略预先观察任何接受硬币。结论也不表示保留原策略不变就必然改善比率。

## 5. 严格递减、连续性与两个极限次序

### 5.1 有限人数的严格性

固定 \(n\ge2\)、\(0<p<p_0\le1\)，取 \(p_0\) 下的最优数组 \(x\)，并作 (20) 的转换。由 (23)，到最后一人的额外存活概率为
\[
\Delta=S_n^p(x')-S_n^{p_0}(x)
=p_0\sum_{i<n}\sum_{r=1}^i x_{i,r}
\Pr\{\operatorname{Bin}(i,p/p_0)<r\}.
\tag{26}
\]
只要原策略在最后一人之前有正概率提议，就有 \(\Delta>0\)：每个上述二项左尾概率至少为 \((1-p/p_0)^i>0\)。

在最后时刻，相对秩一就是绝对秩一。由于 \(x'_{n,1}=x_{n,1}\le S_n^{p_0}(x)/n\)，可以把 \(x'_{n,1}\) 增加 \(\Delta/n\) 而仍然满足 (14)。最后时刻之后没有新的可行性约束。这使每一个 \(N_k\)，\(k\ge1\)，都增加恰好 \(p\Delta/n\)。有限多个稳健比率同时严格增加，所以新策略的最小比率严格超过 \(\gamma_n(p_0)\)。

下面证明能选到有早期提议的最优策略。只在最后一人提议的策略，其 top-1 比率至多 \(1/n\)。若 \(n\ge3\)，或 \(n=2,p_0<1\)，考虑如下扰动：在时刻 \(n-1\) 遇到相对第一名时，以概率 \(\varepsilon\) 提议，除此之外此前不提议；若仍存活，最后一人总是提议。其 top-1 比率是
\[
\frac1n+\frac{\varepsilon}{n}
\left(1-\frac{p_0}{n-1}\right)>\frac1n .
\tag{27}
\]
推导是：最佳者位于 \(n-1\) 的概率为 \(1/n\)；最佳者位于最后时刻时，前一人是相对第一名的条件概率为 \(1/(n-1)\)。在 \(\varepsilon=0\) 处，每个 \(k\ge2\) 的比率为 \(kp_0/(nD_k(p_0))>1/n\)，因为 \(D_k(p_0)<kp_0\)。对有限多个比率取足够小的正 \(\varepsilon\)，它们仍都超过 \(1/n\)。故最优值大于 \(1/n\)，任何最优策略都有早期占用量。

剩余端点 \(n=2,p_0=1\)：第一时刻没有质量信息，若提议概率为 \(b\)，选中最佳者的概率至多 \(b/2+(1-b)/2=1/2\)。总是提议第一人达到稳健比率 \(1/2\)，并有早期占用。因此同一个转换及最后补充论证适用。\(n=1\) 时向唯一候选人提议即可达到 \(N_1/D_1=1\)。这证明了定理 B 的严格性部分。

严格性依赖有限列和的缺失质量；不能从有限 \(n\) 严格性直接推出极限曲线严格性。

### 5.2 反向缩放与连续性

对 \(p\) 下的可行数组 \(x\)，令 \(y=(p/p_0)x\)。此时 \(S_t^{p_0}(y)=S_t^p(x)\)，且 \(ty_{t,s}\le S_t^p(x)\)，所以 \(y\) 在 \(p_0\) 下可行，未归一化的成功向量完全相同。又
\[
\frac{D_k(p)}{D_k(p_0)}
=\frac p{p_0}
\frac{\sum_{j=0}^{k-1}(1-p)^j}{\sum_{j=0}^{k-1}(1-p_0)^j}
\ge\frac p{p_0}.
\tag{28}
\]
这给出 (7) 的左边，定理 A 给出右边。对 \(n\) 取极限仍保持两边不等式。由于 \(\gamma_n\le1\)，(7) 还给出
\[
0\le\gamma_n(p)-\gamma_n(p_0)\le1-p/p_0 ,
\]
故在任意远离零的接受率区间上具有统一连续模量。将 (7) 乘以 \(p_0\) 得到 \(p\gamma_n(p)\) 非减。

### 5.3 固定人数的零接受率边界

每次仍存活就向当前人提议，则选中任意特定绝对秩的概率为 \(D_n(p)/n\)：停止位置只依赖独立硬币，而到达该位置的身份均匀。因此
\[
N_k=\frac{kD_n(p)}n,\qquad
\min_k\frac{N_k}{D_k(p)}=\frac{D_n(p)}{np}.
\tag{29}
\]
最后等式由 \(D_k(p)/k\) 随 \(k\) 非增得到，也可由 \(D_k(p)\le kp\) 以及 \(k=1\) 取等得到。固定 \(n\) 时，右边趋于一，结合 \(\gamma_n\le1\)，
\[
\lim_{p\downarrow0}\gamma_n(p)=1 .
\tag{30}
\]
与定理 D 合起来，
\[
\lim_{n\to\infty}\lim_{p\downarrow0}\gamma_n(p)=1,\qquad
\lim_{p\downarrow0}\lim_{n\to\infty}\gamma_n(p)=c<1 .
\tag{31}
\]
两个次序不能互换；本文也没有断言所有联合极限都等于 \(c\)。

## 6. 所用独立抽样停时定理

本节清楚列出外部依赖。给定任意有限、严格排序的总体，各身份独立以概率 \(a\in(0,1)\) 进入事先可见的历史样本 \(H\)，其余构成在线集合 \(O\)，并以随机顺序出现。为每个身份赋独立的 \((0,1)\) 均匀时钟，时钟小于 \(a\) 表示样本。这与独立样本加随机在线顺序等价。基准为 \(O\) 中的最大非负效用；\(O=\varnothing\) 时基准为零。策略只用序数比较与当前时钟，不必看到数值效用。

**外部定理 S（Correa–Cristi–Epstein–Soto [2]）。** 对每个 \(a\in(0,1)\)，存在固定的非递减时间阈值序列。在线候选人的局部秩为 \(r\)、时钟达到第 \(r\) 个阈值时，该规则选择当前人。对每个有限总体大小 \(N\) 和每个非负单调效用向量，同一个规则保证至少 \(ca\) 倍的在线最优期望值。

这里“同一个”意味着：给定时钟的阈值决策公式不使用 \(N\)，并非声称在没有时钟、且完全未知总人数的其他模型中也有同一结论。[2, Theorem 3] 给出构造的极限保证 \(\widetilde\alpha(a)\ge ca\)；[2, §4.4, Lemmas 7–8] 证明每个固定阈值规则在有限 \(N\) 的保证不低于其极限保证。二者共同支持外部定理 S。只引用渐近下界而不核对有限 \(N\) 性质是不充分的。

如需更强的输入，[2, Theorem 4] 的最优阈值规则给出 \(\rho(a)=\alpha_{\mathrm{DOS}}(a)\)；本稿的显式界仅需上述已构造的 \(\widetilde\alpha(a)\ge ca\)。对任意具有同一有限总体保证的确定性序数规则，下一节的转移都成立。样本单调性、阈值优化、\(ca\) 下界及常数 \(c\) 本身，均不是本文新增结果。

## 7. 保持信息约束的因果抽样模拟

### 7.1 时钟和保留集合

固定 \(\delta\in(0,1)\)。原问题知道 \(n\)，策略可以先生成 \(n\) 个独立均匀数，排序后将第 \(j\) 个次序统计量分配给第 \(j\) 个实际到达者。该私人随机化与排列独立。等价的分析视角是：每个身份具有独立均匀时钟 \(U_i\)，按时钟递增到达。这个视角不会把绝对身份交给策略。

对时钟不超过 \(\delta\) 的人不提议，并将其全部保留为历史样本 \(H\)。对之后的每个人生成一个保留标记 \(B_i\)；只有 \(B_i=1\) 的人才进入虚拟在线集合 \(O\)。下一小节以合法方式构造这些标记，并证明它们条件于全部顺序和时钟后仍是独立 Bernoulli-\(p\)。

因此每个身份独立属于三类：
\[
\Pr(i\in H)=\delta,\qquad
\Pr(i\in O)=(1-\delta)p,\qquad
\Pr(i\notin H\cup O)=(1-\delta)(1-p).
\tag{32}
\]
记 \(R=H\cup O\)、\(r=\delta+(1-\delta)p\)、\(a=\delta/r\)。条件于整个保留身份集合 \(R\)，各身份进入 \(H\) 的标签仍相互独立，概率为 \(a\)。这跟只条件于保留总数不同，但两种条件化都不会把未来信息提供给策略。

对保留者定义变换时钟
\[
V_i=
\begin{cases}
aU_i/\delta,& i\in H,\\
a+(1-a)(U_i-\delta)/(1-\delta),& i\in O.
\end{cases}
\tag{33}
\]
条件于 \(R\)，这些时钟独立且均匀分布于 \((0,1)\)，并且 \(H=\{i\in R:V_i\le a\}\)。理由是每一类内部原时钟分别均匀于 \((0,\delta)\) 或 \((\delta,1)\)，线性变换后对应 \((0,a)\) 或 \((a,1)\)，混合权重恰为区间长度。零概率边界任意处理。于是得到精确的独立抽样模型。

随机总体大小 \(|R|\) 未知且依赖未来标记。我们不把它交给模拟规则：外部定理 S 的阈值公式只使用保留历史与当前变换时钟，因此对每个条件总体都能使用同一规则。

### 7.2 可预测硬币切换

保持虚拟规则的已保留历史。对时钟超过 \(\delta\) 的当前候选人，先临时将其加入历史，算出保留历史中的相对秩和式 (33) 的当前在线时钟，并确定 \(Q_a\) 在“当前人被保留”的假设下会选择还是拒绝。这个动作完全由已观察信息和当前排名决定，发生在当前标记生成之前。

若规则会选择，就向真实候选人提议。令 \(A_i\) 为这次提议的实际接受结果，设 \(B_i=A_i\)。若接受，真实过程和虚拟过程同时选择当前人并终止；若拒绝，丢弃临时插入，虚拟状态退回原状。

若规则会拒绝，就不发出真实提议，另外独立投掷私人硬币 \(C_i\sim\operatorname{Ber}(p)\)，设 \(B_i=C_i\)。若为一，把当前人作为虚拟已见但未选的人保留；若为零，丢弃临时插入。\(C_i\) 不是未提议者的真实接受硬币。

**引理 7.1（可预测切换）。** 条件于完整身份顺序和全部时钟，上述 \(B_i\) 为独立 Bernoulli-\(p\)，且真实选中身份与 \(Q_a\) 在保留过程中的选中身份一致。

**证明。** 为分析可预先配置两列相互独立的 Bernoulli-\(p\) 变量 \(A_i,C_i\)。策略在不提议时不读取 \(A_i\)。给定完整顺序、全部时钟及此前已用变量，当前“提议或不提议”是可测的；\(A_i,C_i\) 均仍是与这些条件独立的新鲜硬币。因此无论选择哪个变量，都有
\[
\Pr(B_i=1\mid\text{完整顺序、时钟及此前数据})=p .
\tag{34}
\]
依序条件化给出所有标记的乘积 Bernoulli 分布。若真实过程已终止，则后续标记以新鲜独立硬币补全，仅作概率空间延拓，不改变已停止的输出。由 (34) 还可知这些标记与全部时钟、顺序独立，所以 (32)–(33) 的条件分布成立。

归纳比较两个过程：\(B_i=0\) 的人不进入虚拟过程；\(B_i=1\) 且规则拒绝的人合法地更新虚拟历史；\(B_i=1\) 且规则选择的人恰有真实接受。只观察实际提议的结果就能维持相同停止身份。真实观察过但虚拟丢弃的排名可以被策略忽略；通过已见人的相对次序总能重算保留子集的秩。证毕。

此处的虚拟离线最优事件无需与原模型的潜在接受集合逐路径相等。后面的比较使用它们的精确概率；不能把独立模拟硬币误说成观察到了真实隐藏变量。

### 7.3 一个策略同时控制全部尾事件

固定 \(k\)，给原 top-\(k\) 人效用一，其余人效用零。条件于任意保留身份集合 \(R\)，这是保留总体上的固定非负单调效用向量。质量秩仍严格有序，效用相等不改变观察模型。将有限效用向量在总体之外补零，符合来源对有限向量的尾部约定。外部规则的保证针对所有单调效用，并使用同一个序数规则，因而可同时应用于所有 \(k\)，而无需让策略知道 \(k\)。

由精确模拟，条件期望保证再对 \(R\) 求平均，得到
\[
\begin{aligned}
N_k(P_\delta,p)
&\ge \rho(a)\Pr(O\text{ 中含有原 top-}k\text{ 的人})\\
&=\rho(a)\,[1-\{1-(1-\delta)p\}^k].
\end{aligned}
\tag{35}
\]
\(R=\varnothing\) 时两侧条件保证均为零。若外部定理以严格下降的数值向量陈述，可用严格下降的正向量逼近该零一向量；有限总体下两边对效用向量连续，阈值规则只依赖严格质量秩，得到相同不等式。

最后，\(D_k(x)/x=\sum_{j=0}^{k-1}(1-x)^j\) 在 \(x\in(0,1]\) 非增，所以
\[
D_k((1-\delta)p)\ge(1-\delta)D_k(p).
\tag{36}
\]
式 (35)–(36) 证明定理 C。证明没有渐近抽样误差、未知总体大小的补偿项，或对小 \(k\) 失效的集中不等式。

## 8. 显式下界和锐极限

在定理 C 中使用外部定理 S 的 \(\rho(a)\ge ca\)，得到
\[
\gamma_n(p)\ge
c\,\frac{\delta(1-\delta)}{\delta+(1-\delta)p}.
\tag{37}
\]
令 \(s=\sqrt p\)，取
\[
\delta_*=\frac{s}{1+s},\qquad a_*=\frac1{1+s}.
\tag{38}
\]
此时 \(1-\delta_*=a_*\)，式 (37) 等于 \(c/(1+\sqrt p)^2\)。它也确实最大化了式 (37) 的右边：其导数的符号由
\[
p(1-2\delta)-(1-p)\delta^2
\]
决定，在 \((0,1)\) 唯一变号于 (38)；\(p=1\) 时最大点是 \(1/2\)。这只是在所用线性抽样下界之内的最优参数选择，不是原问题全局策略最优性的证明。

对固定 \(p\) 取 \(n\to\infty\)，一致下界仍成立。结合 (5)，再令 \(p\downarrow0\) 即得 (12)。恒等式
\[
1-(1+x)^{-2}=\frac{x(2+x)}{(1+x)^2}\le2x\quad(x\ge0)
\]
给出 (11)。因此定理 D 完成。

更一般地，将 \(\delta=ap/(1-a+ap)\) 代回 (9)，得到可复用的下界包络
\[
\gamma_n(p)\ge
\sup_{0<a<1}\frac{1-a}{1-a+ap}\rho(a).
\tag{39}
\]
若只使用上确界而没有最大化点，对每个 \(a\) 都有策略并已足够推出 (39)；未声称一个策略同时实现所有参数的上确界。未来更强的独立抽样保证可以直接通过此式转移。

## 9. 二次研究：到达时可见的异质接受率

本节及下一节增加一个明确的信息模型，保留前面同质模型的全部结论。异质接受率本身早有研究，例如 Tamaki–Ohno [7]；这里研究的是一条对未知率向量统一有效的稳健保证，以及揭示该向量信息的必要性。

### 9.1 模型与极小极大量词

每个绝对秩 \(i\) 具有固定接受概率 \(p_i\in[0,q]\)，其中公共上界 \(q\in(0,1]\) 和 \(n\) 已知；至少一个 \(p_i>0\)。接受指标彼此独立，且与均匀到达排列、策略随机化独立。概率可以与质量秩任意相关。

区分两种信息：

1. **到达时可见率：** 当前候选人出现时，其 \(p_i\) 被揭示；未来人的概率、整条概率向量和绝对秩均不提供。
2. **隐藏率：** 每个人的概率始终不提供，只能观察实际提议的接受或拒绝；策略知道 \(n,q\)。

在固定概率向量 \(\boldsymbol p=(p_1,\ldots,p_n)\) 下，定义
\[
D_k(\boldsymbol p)=1-\prod_{i=1}^k(1-p_i),\qquad
G(P,\boldsymbol p)=\min_{\{k:D_k(\boldsymbol p)>0\}}
\frac{N_k(P,\boldsymbol p)}{D_k(\boldsymbol p)} .
\tag{40}
\]
零分母的尾约束写成 \(N_k\ge gD_k=0\)，不作除法。令
\[
\Gamma_n^{\mathrm{rev}}(q)=
\sup_{P\text{ 只用可见率信息}}\ \inf_{\boldsymbol p\in[0,q]^n,\ \boldsymbol p\ne0}
G(P,\boldsymbol p),\qquad
\Gamma^{\mathrm{rev}}(q)=\inf_{n\ge1}\Gamma_n^{\mathrm{rev}}(q),
\tag{41}
\]
并以 \(H_n(q)\) 表示将 (41) 的策略信息替换成隐藏率后的有限人数值。上确界在概率向量的下确界之外：要求一个不预知整条向量的策略处理所有向量，而不是为每个实例事后定制策略。

**定理 E（异质可见率的统一传输）。** 对所有整数 \(n\ge1\)、\(q\in(0,1]\) 和 \(\delta\in(0,1)\)，若 \(Q_a\) 满足定理 C 的独立抽样保证，则存在一个只在到达时读取当前 \(p_i\) 的序数策略，使对所有 \(\boldsymbol p\)、全部 \(k\)，
\[
N_k\ge\rho(a)\left[1-\prod_{i=1}^k\{1-(1-\delta)p_i\}\right]
\ge(1-\delta)\rho(a)D_k(\boldsymbol p),
\quad
a=\frac{\delta}{\delta+(1-\delta)q}.
\tag{42}
\]
所以
\[
\Gamma_n^{\mathrm{rev}}(q)\ge \frac{c}{(1+\sqrt q)^2},\qquad
\frac{c}{(1+\sqrt q)^2}\le\Gamma^{\mathrm{rev}}(q)\le c,\qquad
\lim_{q\downarrow0}\Gamma^{\mathrm{rev}}(q)=c.
\tag{43}
\]
这条稀有接受定律允许概率与质量任意相关，控制参数是最大接受率的已知上界。

### 9.2 比例保留消除样本类别偏差

沿用第 7 节的原始独立时钟 \(U_i\) 和前缀分界 \(\delta\)。对前缀人 \(U_i\le\delta\)，不作提议，独立以概率 \(p_i/q\) 将其保留为历史样本。\(p_i=0\) 时直接丢弃。对后段人仍进行因果切换：虚拟规则若会选择，就真实提议并使用实际接受位；否则使用独立私人 Bernoulli-\(p_i\) 位。切换前已经读到当前 \(p_i\)，但没有看到接受位。

引理 7.1 的条件化证明逐身份成立：给定完整排列、时钟、固定概率向量和此前数据，当前被选用的两种硬币都有同一个已知条件参数 \(p_i\)。因此各后段保留位独立，参数分别为 \(p_i\)。每个身份的类别概率现在是
\[
\Pr(i\in H)=\delta p_i/q,\qquad
\Pr(i\in O)=(1-\delta)p_i,\qquad
\Pr(i\in R)=p_i\{\delta/q+1-\delta\}.
\tag{44}
\]
各身份的保留率不同，但条件于整个保留集合 \(R\)，其中每个身份成为样本的概率都是
\[
\frac{\delta p_i/q}{\delta p_i/q+(1-\delta)p_i}
=\frac{\delta}{\delta+(1-\delta)q}=a .
\tag{45}
\]
\(p_i=0\) 的身份以概率一不在 \(R\)，不需要对 \(0/0\) 作定义。原分类在身份之间独立，所以条件样本标签也独立。沿用 (33) 的分段线性时钟后，条件保留过程恰为参数 \(a\) 的独立抽样停时实例。虚拟规则仍不需要未知的未来保留人数。

对每个 top-\(k\) 指示效用，条件抽样保证并对 \(R\) 平均，即得 (42) 的第一项。证明第二项可作直接耦合：先按 \(p_i\) 激活 top-\(k\) 各身份，再将已激活者独立以概率 \(1-\delta\) 保留。若原激活集合非空，则新集合非空的条件概率为 \(1-\delta^m\ge1-\delta\)，其中 \(m\ge1\) 为原激活人数。平均得到所需不等式。

代入外部定理 S 的 \(\rho(a)\ge ca\)，再取 \(\delta=\sqrt q/(1+\sqrt q)\)，得到 (43) 的下界。对于上界，所有 \(p_i=q\) 是异质实例类的子类，且此时到达时揭示概率不会增加原同质模型的信息。因此
\(\Gamma_n^{\mathrm{rev}}(q)\le\gamma_n(q)\)。对 \(n\) 取下确界并用 (5) 得到上界 \(c\)，再由夹逼得到极限。我们没有假设 \(\Gamma_n^{\mathrm{rev}}\) 关于 \(n\) 单调。

### 9.3 稳健尾保证也控制全部单调效用

固定非负单调效用 \(w_1\ge\cdots\ge w_n\ge w_{n+1}=0\)，令 \(\Delta_k=w_k-w_{k+1}\ge0\)。被选中人的期望效用等于 \(\sum_k\Delta_kN_k\)，全部独立激活者中最佳者的期望效用等于 \(\sum_k\Delta_kD_k(\boldsymbol p)\)。因此统一尾保证直接给出相同比例的效用保证。这个有限分部求和关系是已知的稳健目标解释，不另外计为创新。

比例保留的意义是修复抽样组成：若将所有前缀人无条件保留，在异质模型中条件样本率会依赖 \(p_i\)，外部定理 S 就不能按同一独立样本参数直接使用。式 (44)–(45) 给出了具体可实现的修复，并没有要求预先知道未来概率。


## 10. 隐藏异质接受率的尖锐人数阶

本节不借助抽样停时定理。它以一个共同拒绝路径上的困难实例族和一个在线单调子序列着色策略，给出匹配的人数指数。单调子序列分解是经典排列理论内容 [9]；新增的候选结论是其与隐藏接受率极小极大保证的联系。

**定理 F（隐藏率的平方根界）。** 设 \(L_n\) 是均匀随机排列的最长递增子序列长度，\(M_n=\lceil4\sqrt n\rceil\)，\(B_n=\lceil2e\sqrt n\rceil\)。对 \(H_n(q)\) 有
\[
\max\left\{(1-q)^{n-1},\
\frac{1-2^{-M_n}}{M_n}\right\}
\le H_n(q)
\le \min\left\{1,\frac{\mathbb E L_n}{qn}\right\}
\le \min\left\{1,\frac{B_n}{qn}\right\}.
\tag{46}
\]
当 \(n=1,q=1\) 时，第一项按 \((1-q)^0=1\) 解释。若仅允许严格正率向量，记相应值为 \(H_n^+(q)\)，同一下界成立，而上界可以取
\[
H_n^+(q)\le
\min\left\{1,\frac{\mathbb E L_n}{qn}+\frac1n\right\}.
\tag{47}
\]
因此对每个固定 \(q\in(0,1]\)，
\[
H_n(q)=\Theta_q(n^{-1/2}),\qquad
H_n^+(q)=\Theta_q(n^{-1/2}).
\tag{48}
\]
上界即使允许每次到达时观察绝对质量秩也成立，下界只用相对秩。式 (48) 匹配固定 \(q\) 时关于 \(n\) 的指数；没有确定最优首项常数，或同时变化的 \(q,n\) 的最优联合阶。

### 10.1 共同的全部拒绝路径

固定任意隐藏率策略 \(P\)。对每个 \(r\in[n]\)，构造一个在运行前固定的率向量
\[
p_i^{(r)}=
\begin{cases}0,&i<r,\\q,&i\ge r.\end{cases}
\tag{49}
\]
在第 \(r\) 个实例中，top-\(r\) 里只有秩 \(r\) 可以接受，所以 \(D_r=q\)，接受 top-\(r\) 等价于接受秩 \(r\)。

固定整个到达排列 \(\pi\) 和策略的全部私人随机种子。沿着“每次提议都被拒绝”的反事实观察历史，得到策略会向其提议的绝对秩子序列 \(T\)。对某个实例具有零概率的历史，任意一致地补全策略决定；这不会改变其实际概率。由于概率参数不被揭示，\(T\) 对所有实例 (49) 都相同。对 \(r\in T\)，令
\[
d_r=\#\{i\in T:i\text{ 在 }r\text{ 之前被提议且 }i>r\}.
\]
这数的是此前提议过的、更差的候选人，不包含 \(r\) 自己。实例 (49) 中，此前更好的人必拒绝，更差的 \(d_r\) 人各以概率 \(1-q\) 拒绝，于是精确地有
\[
\frac{N_r(P,\boldsymbol p^{(r)})}{q}
=\mathbb E_{\pi,\mathrm{seed}}
\bigl[\mathbf1_{\{r\in T\}}(1-q)^{d_r}\bigr].
\tag{50}
\]
式 (50) 只比较首次成功之前的历史，未要求实际过程在成功后继续沿反事实执行。它允许任意过去相对秩、提议决定和拒绝记录依赖；若另给绝对秩，反事实 \(T\) 仍不依赖隐藏的 \(r\)，论证照旧。

### 10.2 子序列计数与困难实例平均

对任意排列 \(\pi\) 及其任意子序列 \(T\)，记 \(L=\operatorname{LIS}(\pi)\)，并令
\[
F_T(m)=\#\{r\in T:d_r\le m\}.
\]
则
\[
F_T(m)\le(m+1)L\qquad(m=0,1,\ldots).
\tag{51}
\]
为证明它，在只包含 \(d_r\le m\) 的子序列内，任何递减子序列最多有 \(m+1\) 项：最后一项至少把该递减子序列的所有前项计入 \(d_r\)。给每项赋以该子序列中“以此项结尾的最长递减子序列长度”作为颜色，则至多使用 \(m+1\) 种颜色。同色项依时间出现时必递增，否则后项能延长前项的递减子序列而拥有更大颜色。每个颜色都是原排列的递增子序列，长度不超过 \(L\)，得到 (51)。

当 \(0<q<1\) 时，以 \(w=1-q\) 记，
\[
\sum_{r\in T}w^{d_r}
=q\sum_{m=0}^{\infty}w^mF_T(m)
\le qL\sum_{m=0}^{\infty}(m+1)w^m
=\frac Lq .
\tag{52}
\]
第一个等号来自 \(q\sum_{m=d}^{\infty}w^m=w^d\)，求和均非负。\(q=1\) 时左边解释为 \(d_r=0\) 的项数，直接用 (51) 的 \(m=0\) 情形，仍得到相同界，避免在概率论证中依赖 \(0^0\) 的记号。

对 (50) 的 \(r=1,\ldots,n\) 平均，再使用 (52)，至少存在一个固定的 \(r\) 使比率不超过 \(\mathbb E L_n/(qn)\)。这个 \(r\) 依赖策略，却不依赖运行中实现的排列或硬币，因此是合法的固定实例下界证明，并非自适应对手。对任意 \(P\) 都成立，得到 (46) 的上界。

若要求所有率严格正，令 \(\varepsilon=q/n^2\)，把 (49) 中的零替换为 \(\varepsilon\)。耦合两个实例，保留排列、私人种子和 \(i\ge r\) 的硬币；只有更好秩的新增激活事件可能使轨迹不同，其联合概率至多 \((r-1)\varepsilon\le n\varepsilon\)。修改后的分母至少为 \(q\)，所以相同比率上界最多增加 \(n\varepsilon/q=1/n\)，得到 (47)。即便策略只为严格正率域设计，它在全部拒绝历史上的决定仍然良定；零率实例仅是证明的辅助比较。

### 10.3 自包含的随机排列估计

对 \(1\le\ell\le n\)，在每个固定的 \(\ell\) 个位置上，数值相对次序均匀，因此成为递增子序列的概率为 \(1/\ell!\)。联合界给出
\[
\Pr(L_n\ge\ell)\le\frac{\binom n\ell}{\ell!}
\le\frac{n^\ell}{(\ell!)^2}
\le\left(\frac{e^2n}{\ell^2}\right)^\ell .
\tag{53}
\]
最后一步由 \(\ell!\ge(\ell/e)^\ell\) 得到；后者可通过对 \(\log j\) 求和并下界为 \(\int_1^\ell\log x\,dx\) 自行证明。

当 \(\ell\ge B_n=\lceil2e\sqrt n\rceil\) 时，右边不超过 \(4^{-\ell}\)。若 \(B_n>n\)，显然 \(\mathbb E L_n\le n<B_n\)；否则用尾和公式，
\[
\mathbb E L_n\le B_n-1+\sum_{\ell=B_n}^{\infty}4^{-\ell}<B_n .
\]
本文不需要随机排列最长子序列的精细渐近理论。

### 10.4 只用序数信息的匹配下界

固定整数 \(M\ge1\)，到达前独立选择 \(J\) 均匀分布于 \([M]\)。对每个到达时刻 \(t\)，依据过去比较计算
\[
c_t=1+\max\{c_s:s<t,\ \pi_s>\pi_t\},\qquad
\max\varnothing=0 .
\tag{54}
\]
只在 \(c_t=J\) 时提议，拒绝后继续。所有到达者都参与颜色计算，包括没有收到提议的人。数值 \(\pi_s>\pi_t\) 只表示此前人的质量比当前人差，用相对秩就能判断；算法不使用绝对秩或任何接受概率。

递推直接说明 \(c_t\) 是以当前项结尾的最长递减子序列长度，因此最大颜色为 \(\operatorname{LDS}(\pi)\)。同色项的绝对秩依到达次序严格递增，质量依次变差；否则 (54) 会强制后一项颜色更大。

为了分析，预先生成独立接受指标 \(A_i\)。固定整个排列和指标向量，若至少有一人激活，记最佳激活者为 \(b=\min\{i:A_i=1\}\)。若 \(\operatorname{LDS}(\pi)\le M\)，且随机颜色 \(J\) 恰是 \(b\) 的颜色，则本策略必选到 \(b\)：此前同色的人质量都更好，按 \(b\) 的定义都未激活，因此不可能提前成功；向 \(b\) 提议即被接受。命中该颜色的条件概率为 \(1/M\)。

事件 \(b\le k\) 恰是 top-\(k\) 中至少一人激活。排列与整条接受向量独立，于是对所有概率向量和全部 \(k\)，同一策略满足
\[
N_k(P_M,\boldsymbol p)\ge
\frac{\Pr\{\operatorname{LDS}(\pi)\le M\}}{M}\,
D_k(\boldsymbol p).
\tag{55}
\]
没有向算法透露预生成的硬币。事实上 (55) 只要求接受向量与排列独立，不要求向量各分量独立；若使用相关向量，分母须改用真实的 top-\(k\) 激活概率，而不能仍写独立乘积。

在均匀排列下，LIS 与 LDS 同分布。取 \(M=M_n\)。若 \(M\ge n\)，事件 \(\operatorname{LDS}\le M\) 必然发生；否则 (53) 给出
\[
\Pr(\operatorname{LDS}>M)\le
\Pr(\operatorname{LDS}\ge M)
\le(e^2n/M^2)^M\le2^{-M},
\]
因为 \(e^2<8\) 且 \(M^2\ge16n\)。故得到 (46) 和 (47) 的着色下界。允许 \(M>n\) 是合法的，只是有些颜色不会使用。若希望改善有限常数，可直接最大化 \(\Pr(L_n\le M)/M\)；本稿没有声称简单的 \(M_n\) 最优。

另一个策略是向每个仍在场的人提议。对任意 \(k\)，若 top-\(k\) 中至少一人激活、其余所有人均未激活，就必选到 top-\(k\)。故
\[
N_k\ge D_k(\boldsymbol p)\prod_{i>k}(1-p_i)
\ge D_k(\boldsymbol p)(1-q)^{n-1}.
\]
这给出 (46) 的另一下界。综上，固定正 \(q\) 时上下界的 \(n\) 指数吻合，证明定理 F。

### 10.5 信息边界与限序

由 (43) 与 (48)，每个固定 \(q>0\) 下，可见率模型具有至少 \(c/(1+\sqrt q)^2\) 的无人数依赖保证；隐藏率模型的最优统一保证则随人数趋于零，甚至额外揭示绝对秩也不能改变该消失结论。区别是概率参数信息，不是提前观察实际接受位：在两个模型里，实际接受位都只在作出提议后才可见。

隐藏率并不意味着固定人数时稀有接受仍然困难。式 (46) 给出 \(\lim_{q\downarrow0}H_n(q)=1\)；同样适用于 \(H_n^+(q)\)。但取 \(q_n=n^{-1/4}\)，式 (46)–(47) 的上界趋于零，虽然所有边际接受率均趋于零。此时可见率策略仍对每个实例保证至少 \(c/(1+n^{-1/8})^2\)，趋于 \(c\)。这给出了可复算的联合稀有率信息分离，但不声称这一联合区间的隐藏率最优速率。


## 11. 极限曲线的严格递减与达到的最坏尾分布

有限人数下的最后时刻补充提议，改善量可能随人数趋于零，因此不能直接证明极限严格性。本节采用不同论证：为低接受率问题构造达到最坏值的尾目标混合，再证明二项传输在该混合目标下必然产生正的决策损失。完整函数分析论证保留在附录 A；附录为英文，以保留审查所用的精确接口和推导。

**定理 G（全正接受率的极限严格性）。** 对所有 \(0<p<p_0\le1\)，
\[
\gamma_\infty(p)>\gamma_\infty(p_0).
\tag{56}
\]
因此，结合既有端点 \(\gamma_\infty(1)=1/e\) 和已证稀有接受极限，
\[
\frac1e<\gamma_\infty(p)<c\qquad(0<p<1).
\tag{57}
\]
这里没有断言导数存在或处处严格负。原论文 [1, §7.1] 已给出较大接受率区间的精确分支，其严格性早可推出；本定理的增量在于全部正接受率，特别是低接受率和跨区间比较。

证明分四步。首先，附录 A.1–A.3 明确定义非负 \(L^1\) 占用密度及约束 \(t\alpha(t,s)\le S_\alpha(t)\)，用固定有限尾数的动态规划、统一离散到连续误差和尾部夹逼，证明其最优值恰等于原有限策略人数极限。该独立桥接避免依赖源文连续密度取值范围的一处不一致排版，也没有声称每个连续密度都与某个有限策略逐路径相同。

其次，将尾索引紧化为 \(\mathbb N\cup\{\infty\}\)。每个密度的尾比率在无穷远收敛到总接受概率，因此在这个紧空间上连续。Sion 的极小极大定理 [11] 只需尾混合测度一侧紧性，便得到达到最坏值的概率分布 \(\lambda\)。实际可行的有限秩后缀提议能把总接受概率逼近一，而损失的有限尾混合收益趋零；因为最优值小于一，这排除了任何最小化分布在无穷远的质量。

再次，对这个由有限尾索引支撑、但不必有限支撑的 \(\lambda\)，令 \(w_s(t)\) 为相对秩 \(s\) 的混合效用，\(V(t)\) 为条件最优续值。混合尾概率给出 \(w_s\to0\) 的一致收敛；有限截断价值也一致逼近 \(V\)。每个内区间上只有有限多个相对秩可能优于续值，因此可以证明无限 Bellman 方程、全区间绝对连续性及适用于任意可行密度的精确损失恒等式。证明不假设 \(\lambda\) 的一阶矩有限，也不假设原始最优密度取得。

最后，记 \(g=\gamma_\infty(p_0)>0\)，取共同内区间 \([g/4,1-g/4]\)。高接受率近最优策略在相对秩一处的占用质量不能全部集中到两端。二项转换把其中固定正比例扩散到任何固定秩 \(R\)；而对足够大的有限 \(R\)，整个内区间上都有 \(V(t)-w_R(t)\ge v/2>0\)。损失恒等式给出
\[
\gamma_\infty(p)-\gamma_\infty(p_0)
\ge\frac{pvg}{4}(1-p/p_0)^{R-1}>0 .
\tag{58}
\]
\(v,R\) 由低接受率的达到最坏值分布确定；这是严格正差距的证书，不是一个已计算的统一数值模量。附录 A 给出各量的定义、极限次序和全部中间步骤。


## 12. 创新边界、复核证据和未解决问题

### 12.1 与最近工作的逐项区别

| 已有内容 | 本文使用方式 | 本轮新增范围 |
|---|---|---|
| [1] 的占用线性规划、人数极限与 \(\gamma_\infty\le c\) | 作为明示基础；占用部分另给完整有限证明 | 任意可行占用数组的秩核转换与全部尾概率精确等式 |
| [1, §7.2] 对特定 record-only 策略使用几何秩权重 | 承认是接近的特例，不能声称首次使用几何权重 | 全部有限 \(n\)、任意原策略、有限超几何交织及严格性 |
| [2] 的独立抽样停时、阈值构造和 \(\rho(a)\ge ca\) | 作为外部定理 S，核实有限 \(N\) 与同一阈值规则 | 信息合法的因果模拟、同一策略全部尾事件与式 (10)–(12) |
| [3, v5, §4, Lemma 2] 的零延迟接受指标吸收 | 承认已有“激活值”归约思想 | 随机排列、相对秩、对抗效用的本模型，以及随机未知保留总体的条件抽样 |
| [5] 的随机扰动在线选择、[6] 的 matroid secretary 稀疏化 | 承认已有的激活、超几何后验和有限参数比较方法 | 前者观察 iid 数值并累计收益；后者另在 §6.1–6.3 已有前缀样本、稀有激活、精确在线交织及二次激活损失；均非本模型的接受率传输 |
| [7]–[10] 的秩相关概率、可用性观察与经典子序列分解 | 均作为已知模型或工具归属，不声称首次研究这些概念 | 到达时可见率的全向量保证，以及隐藏率的固定上界平方根人数阶 |
| [1] 的高接受率精确分支及连续规划、[11] 的极小极大定理 | 既有较高接受率严格性与一般极小极大工具不计新增 | 自包含的密度值桥接、无无穷远质量的达到对偶、全部正接受率严格损失 |
| [4] 的三候选有限凸性反例 | 用于界定原问题哪些部分已被处理 | 不将其重现计为贡献；仍不解决极限曲线凸性 |

本稿闭合原论文的单调性部分和稀有接受极限部分，没有把整个“凸且递减”问题描述为完全解决。查新结论限定于所列来源与实际定向检索；未找到同范围先行证明，不等于得到世界范围的优先权认证。

### 12.2 解析证明与计算的分工

主定理由第 2–11 节及附录 A 的解析论证给出。随附标准库 Fraction 程序检查二项核、超几何交织、半群、可行性和逐排列策略成功概率；另以完整标记枚举检查可预测切换的乘积分布及停止身份的一致性。有限枚举是回归核查，不替代对所有 \(n,p,k\) 的证明。具体参数、计数、程序哈希和实际输出以 results 及 REPRODUCTION.md 为准。

本稿使用的外部定理 S 和上界 (5) 不是“已形式化”的假设。未来的全文形式化必须核对并证明这些依赖，或引用已验证且量词完全相符的库定理；仅在 Lean 中将其声明为公理或前提，不能据此宣布无条件主定理已完成。

### 12.3 范围

尚未解决：\(\gamma_\infty(p)\) 的凸性、稀有接受差距的最优阶、一般 \(p\) 的精确最优曲线、隐藏率模型的最优首项常数与接受率/人数联合阶、延迟反馈、多重选择和非均匀到达。同质结论适用第 1 节；第 9–10 节的异质扩展及其率信息、独立性条件另有精确定义，不把两种策略信息混为一谈。

## 参考文献

[1] Sebastian Perez-Salazar, Mohit Singh, Alejandro Toriello. **Robust Online Selection with Uncertain Offer Acceptance.** Mathematics of Operations Research 50(3), 2226–2260, 2025；2024-08-29 在线发表。DOI: [10.1287/moor.2023.0210](https://doi.org/10.1287/moor.2023.0210)。核查稿：[arXiv:2112.00842v2](https://arxiv.org/html/2112.00842v2)，2024-08-15。定位：有限 LP、Theorems 3 与 6、§7.2 和结论节。

[2] José Correa, Andrés Cristi, Boris Epstein, José A. Soto. **Sample-Driven Optimal Stopping: From the Secretary Problem to the i.i.d. Prophet Inequality.** Mathematics of Operations Research 49(1), 441–475, 2024。DOI: [10.1287/moor.2023.1363](https://doi.org/10.1287/moor.2023.1363)。核查[作者托管发表版本](https://www.dii.uchile.cl/~jcorrea/papers/Journals/2024CCES.pdf)。定位：§4.3.1 Theorem 3；§4.4 Lemmas 7–8、Theorem 4；附录相应证明。

[3] Emile Martinez, Felipe Garrido-Lucero, Umberto Grandi, Sebastian Perez-Salazar. **Prophet Inequalities with Delayed and Uncertain Acceptance.** [arXiv:2603.21740v5](https://arxiv.org/html/2603.21740v5)，2026-10-26。定位：§4 Lemma 2。该文模型允许观察数值且已知分布，与本文的序数稳健模型不同。

[4] **A Three-Candidate Counterexample to Finite-Horizon Convexity in Robust Secretary Selection with Uncertain Acceptance.** Open Problems in Operations Research 公开解答记录，2026-06-24；编辑说明 2026-08-25。[固定题目标识 W3216294154_p0 下的公开笔记](https://ai-in-math-or.github.io/open-problems-in-or/data/llm_math_export/solution_progress/W3216294154_p0/partial_progress/69.pdf)。这里只将该记录作为有限凸性已被反驳的公开前例，不赋予其外部同行认证。


[5] Yihua Xu, Süleyman Kerimov, Sebastian Perez-Salazar. **Online Selection with Uncertain Disruption.** [arXiv:2505.22999v2](https://arxiv.org/html/2505.22999v2)，2025-11-01；Operations Research，DOI [10.1287/opre.2025.1936](https://doi.org/10.1287/opre.2025.1936)。已知 iid 数值和中断前累积收益模型。

[6] Hamed Abdi, Kiarash Banihashem, MohammadTaghi Hajiaghayi, Danny Mittal. **On the Strong Matroid Secretary Conjecture and Beyond.** [arXiv:2609.19118v1](https://arxiv.org/html/2609.19118v1)，2026-09-16。定位：Appendix B 的有限容量比较与超几何后验稀疏化，§5 的条件稀疏化不变量，以及 §6.1–6.3 的前缀样本、稀有激活与精确在线模拟。仅作方法近邻，不声称其模型等价。


[7] Mitsushi Tamaki, Katsuhisa Ohno. **On a Generalization of the Secretary Problem with Uncertain Selection.** Journal of the Operations Research Society of Japan 43(1), 219–243, 2000。[原始期刊全文](https://orsj.org/wp-content/or-archives50/pdf/e_mag/Vol.43_01_219.pdf)。允许秩相关的给定概率序列，目标是选中整体最佳者；不等于本文未知概率向量的统一尾保证。

[8] Mitsushi Tamaki. **A Secretary Problem with Uncertain Employment and Best Choice of Available Candidates.** Operations Research 39(2), 274–284, 1991。DOI [10.1287/opre.39.2.274](https://doi.org/10.1287/opre.39.2.274)。实际可用性指标何时可见的比较已有此先例。本轮核对出版社摘要，未取得全文；不据摘要排除所有可能的重合。

[9] C. Schensted. **Longest Increasing and Decreasing Subsequences.** Canadian Journal of Mathematics 13, 179–191, 1961。DOI [10.4153/CJM-1961-015-3](https://doi.org/10.4153/CJM-1961-015-3)。本文所需的单调子序列着色事实另给自包含证明，不将经典分解机制称为首次提出。

[10] Allan Borodin, Calum MacRury, Akash Rakheja. **Secretary Matching Meets Probing with Commitment.** APPROX/RANDOM 2021, LIPIcs 207, 13:1–13:23。DOI [10.4230/LIPIcs.APPROX/RANDOM.2021.13](https://doi.org/10.4230/LIPIcs.APPROX/RANDOM.2021.13)。到达时给出概率、激活位仍隐藏的随机匹配模型早有此信息接口；其数值目标与 probing 基准不同于本文的序数全尾基准。


[11] Maurice Sion. **On general minimax theorems.** Pacific Journal of Mathematics 8(1), 171–176, 1958。DOI [10.2140/pjm.1958.8.171](https://doi.org/10.2140/pjm.1958.8.171)。[出版社全文](https://msp.org/pjm/1958/8-1/pjm-v8-n1-p14-s.pdf)。附录 A 使用其仅一侧紧性的极小极大推论；该一般定理不是本稿贡献。

## 附录 A. Strict decrease of the infinite-horizon curve: complete proof

The notation agrees with Sections 1–8. This appendix gives the complete proof behind Theorem G. General minimax and ordinary differential equation facts are standard tools; Sion’s one-compact-variable theorem is reference [11]. The density-to-finite-value bridge below is included explicitly.

### A.1. The precise density feasible set

Fix \(p\in(0,1]\). On \((0,1)\times\mathbb N\) use Lebesgue measure times
counting measure. Let \(\mathcal A_p\) be the set of nonnegative
\(\alpha\in L^1\) such that, with
\[
S_\alpha(t)=1-p\int_0^t\sum_{s\ge1}\alpha(u,s)\,du,
\]
we have
\[
S_\alpha(t)\ge0\quad(0\le t\le1),\qquad
t\alpha(t,s)\le S_\alpha(t)\quad
\text{for almost every }t,\text{ for every }s. \tag{S1}
\]
The common full-measure set can be chosen because the ranks are countable.
The set is convex, its survival functions are absolutely continuous, and
\[
\|\alpha\|_1\le1/p,\qquad 0\le S_\alpha\le1.
\]
Define
\[
a_{s,k}(t)=\Pr\{\operatorname{Bin}(k,t)\ge s\},\quad
D_k(p)=1-(1-p)^k,
\]
\[
N_k^p(\alpha)=p\int_0^1\sum_{s\ge1}a_{s,k}(t)\alpha(t,s)\,dt,\qquad
R_k^p(\alpha)=N_k^p(\alpha)/D_k(p). \tag{S2}
\]
For each finite \(k\), only \(s\le k\) occur. By dominated convergence,
\[
N_k^p(\alpha)\uparrow N_\infty^p(\alpha)
=p\|\alpha\|_1=1-S_\alpha(1),\qquad
R_k^p(\alpha)\longrightarrow R_\infty^p(\alpha):=N_\infty^p(\alpha).
\tag{S3}
\]
Every \(R_k\) lies in \([0,1/p]\), which is sufficient for all the functional
analytic arguments below. Appendix A.3 proves directly that
\[
\Gamma(p):=\sup_{\alpha\in\mathcal A_p}\inf_{k\ge1}R_k^p(\alpha)
=\lim_{n\to\infty}\gamma_n(p). \tag{S4}
\]

### Source-notation issue

The HTML display preceding the original paper's continuous LP prints
\(\alpha:[0,1]\times\mathbb N\to[0,1]\). This cannot be taken as an additional
unit bound on an occupancy **density**: its own Proposition 2 uses
\(\alpha=S/t\), exceeding one at a threshold's initial time, and its
finite-to-continuous construction scales occupancies by \(n\). We do not
silently enlarge a displayed feasible set. We define (S1) independently and
prove its equality to the original finite-policy limiting value in Appendix A.3.
In particular the proof does not depend on interpreting that typographical
range statement in a convenient way.

### A.2. A finite-utility Bellman lemma

Let \(M<\infty\), let \(\theta_1,\ldots,\theta_M\ge0\) with
\(\sum\theta_k\le1\), and set
\[
w_s(t)=\sum_{k=1}^M\frac{\theta_k a_{s,k}(t)}{D_k(p)}.
\tag{S5}
\]
Then \(w_s=0\) for \(s>M\), \(0\le w_s\le1/p\), and all \(w_s\) are
continuous on \([0,1]\). The Bellman equation is
\[
-V'(t)=\frac p t\sum_{s=1}^M(w_s(t)-V(t))_+,\qquad V(1)=0.
\tag{S6}
\]
It has a bounded continuous solution on \([0,1]\), continuously differentiable
on \((0,1)\), and
\[
V(0)=\max_{\alpha\in\mathcal A_p}
p\int_0^1\sum_s\alpha(t,s)w_s(t)\,dt. \tag{S7}
\]

Here and below \((x)_+=\max(x,0)\). For completeness, solve (S6) backwards
on each interval \([\varepsilon,1]\); the right side is continuous and
Lipschitz in \(V\) there. Comparison gives \(0\le V\le1/p\) and
\(V'\le0\). Moreover
\[
0\le -V'(t)\le\frac p t\sum_s w_s(t)
=p\sum_{k=1}^M\frac{\theta_k k}{D_k(p)}\le M, \tag{S8}
\]
because the sum of the binomial tails is \(kt\) and \(D_k(p)\ge p\).
The consistent solutions therefore extend continuously and absolutely
continuously to zero. If all weights vanish, \(V=0\). Otherwise \(V(t)>0\)
for every \(t<1\). Indeed, if \(V(t_0)=0\) for some \(t_0<1\), monotonicity and nonnegativity force \(V=0\) on \([t_0,1]\), contradicting (S6) because \(w_1(t)>0\) for \(0<t<1\). This proves positivity directly from the equation, before the policy verification below. Since \(w_1(t)\to0\) as \(t\downarrow0\), while
\(V(t)\ge V(1/2)>0\) for \(t\le1/2\), no rank is profitable sufficiently
near zero; (S6) then shows that \(V\) is constant there.

For any \(\alpha\in\mathcal A_p\), integration by parts of \(S_\alpha V\)
gives the exact verification identity
\[
\begin{aligned}
V(0)-p\int_0^1\sum_s\alpha w_s\,dt
=p\int_0^1\bigg[
&\sum_s\left(\frac{S_\alpha(t)}t-\alpha(t,s)\right)
                  (w_s(t)-V(t))_+\\
&+\sum_s\alpha(t,s)(V(t)-w_s(t))_+
\bigg]dt. 
\end{aligned} \tag{S9}
\]
The first sum is finite; the second is bounded in integral by
\((1/p)\|\alpha\|_1\). Both are nonnegative by (S1).
For equality choose
\[
j(t)=|\{s\le M:w_s(t)>V(t)\}|,\quad
S(t)=\exp\!\left(-p\int_0^t j(u)/u\,du\right),\quad
\alpha(t,s)=\frac{S(t)}t{\mathbf{1}}\{w_s(t)>V(t)\}.
\]
The integral is finite because \(j=0\) near zero and \(j\le M\).
This defines an element of \(\mathcal A_p\); every term on the right of (S9)
vanishes. It proves (S7). The same proof on \([t_0,1]\), starting survival
at one at \(t_0\), proves the corresponding conditional value \(V(t_0)\).

For later reference, if a finite utility has a constant floor \(b\ge0\),
replace \(w_s\) by \(b+\sum_{k\le M}\theta_k a_{s,k}/D_k\) and put \(V(1)=b\).
Then the left side of (S9) is
\[
V(0)-p\int\sum_s\alpha w_s\,dt-bS_\alpha(1). \tag{S10}
\]
The terminal residual \(bS_\alpha(1)\) is present; it is not reward actually
received on failure. Appendix A.4 provides legal suffix policies that approximate
such a floor whenever it is used in a supremum. The eventual least-favourable
utility has \(b=0\), as proved there.

### A.3. Equality of the density problem and the finite-policy limit

This section gives a short self-contained bridge, so that (S4) is not based
on the inconsistent printed range of the source's density.

#### A.3.1 Fixed finitely many tail objectives

For \(K\le n\), let \(\gamma_{n,K}(p)\) optimize only the first \(K\) ratios
in the original \(n\)-candidate problem. Let
\[
\Gamma_K(p)=\sup_{\alpha\in\mathcal A_p}\min_{1\le k\le K}R_k^p(\alpha).
\]
For a probability vector \(\theta\) on \(\{1,\ldots,K\}\), the finite-policy
utility is
\[
w^n_{t,s}=\sum_{k=1}^K
\frac{\theta_k\,\Pr\{\operatorname{Hypergeom}(n,k,t)\ge s\}}{D_k(p)}.
\]
Its exact scalar dynamic program is
\[
B^n_t=B^n_{t+1}+\frac p t
\sum_{s=1}^{\min(t,K)}(w^n_{t,s}-B^n_{t+1})_+,\qquad B^n_{n+1}=0.
\tag{S11}
\]
This follows from the original rank information: after relative rank \(s\),
an offer has expected reward \(pw^n_{t,s}+(1-p)B^n_{t+1}\), whereas skipping
has value \(B^n_{t+1}\); the current relative rank is uniform on \([t]\).
The original finite occupancy characterization justifies the same recursion
even when the allowed strategies use the entire legal past.

Finite minimax/LP duality and Appendix A.2 give
\[
\gamma_{n,K}(p)=\min_{\theta\in\Delta_K}B^n_1(\theta),\qquad
\Gamma_K(p)=\min_{\theta\in\Delta_K}V_\theta(0).
\tag{S12}
\]
For the latter identity, apply minimax with the finite compact simplex
\(\Delta_K\) and the convex \(L^1\) set \(\mathcal A_p\); the payoff is
continuous and linear in both variables. No compactness of \(\mathcal A_p\)
is required.

#### A.3.2 Uniform dynamic-program convergence

For fixed \(K\), uniformly over \(t,s\) and \(k\le K\),
\[
\left|\Pr\{\operatorname{Hypergeom}(n,k,t)\ge s\}
-\Pr\{\operatorname{Bin}(k,t/n)\ge s\}\right|
\le\frac{k(k-1)}{2n}. \tag{S13}
\]
Indeed the \(k\) specified identities occupy a sample of distinct uniform
positions in \([n]\). Couple these with \(k\) independent uniform positions;
the coupling agrees unless a collision occurs, whose probability is bounded
by \(\binom{k}{2}/n\). Counting positions at most \(t\) gives the two laws.

Fix \(\delta>0\). On \([\delta,1]\) the ODE (S6), with \(M=K\), has a right
side uniformly Lipschitz in its value variable, with constant at most
\(pK/\delta\). The binomial polynomials, their first derivatives and the
factor \(1/t\) have uniform bounds there, independent of
\(\theta\in\Delta_K\). Formula (S8) gives a uniform bound on \(V'\).
Consequently the local error of Euler stepping backwards in time is at most
\(C_{p,K,\delta}/n^2\); (S13) contributes another error of the same order to
one step of (S11). More explicitly, at the grid points \(u_t=t/n\), put
\(W^n(u_t)=B^n_{t+1}\). Then
\[
W^n(u_{t-1})
=W^n(u_t)+\frac1n\frac p{u_t}
 \sum_{s=1}^K(w^n_{t,s}-W^n(u_t))_+.
\]
For \(t/n\ge\delta\) and \(n\) large enough that \(t\ge K\), the maximum
grid error satisfies
\[
e_{t-1}\le(1+pK/(n\delta))e_t+C_{p,K,\delta}/n^2,
\qquad e_n=0.
\]
Iterating this finite inequality proves a uniform \(O_{p,K,\delta}(1/n)\)
bound.

The early interval does not hide a singular error. By summing the
hypergeometric tails,
\[
0\le B^n_t-B^n_{t+1}
\le\frac p t\sum_s w^n_{t,s}
=\frac p n\sum_{k=1}^K\frac{\theta_k k}{D_k(p)}
\le K/n.
\]
Similarly \(0\le V(0)-V(\delta)\le K\delta\) by (S8). Therefore
\[
\sup_{\theta\in\Delta_K}|B^n_1(\theta)-V_\theta(0)|
\le2K\delta+O_{p,K,\delta}(1/n).
\]
First \(n\to\infty\), then \(\delta\downarrow0\), yields uniform convergence.
Together with (S12),
\[
\lim_{n\to\infty}\gamma_{n,K}(p)=\Gamma_K(p). \tag{S14}
\]

#### A.3.3 Recovering every tail

For either a finite policy or a density policy, \(N_k\) is nondecreasing
in \(k\), whereas \(D_k\le1\). A guarantee \(g\) for the first \(K\) tails
therefore gives guarantee at least \(D_K(p)g\) for all tails: for \(k>K\),
\(N_k/D_k\ge N_K\ge gD_K(p)\). Thus
\[
D_K(p)\gamma_{n,K}(p)\le\gamma_n(p)\le\gamma_{n,K}(p),
\]
\[
D_K(p)\Gamma_K(p)\le\Gamma(p)\le\Gamma_K(p). \tag{S15}
\]
The \(\Gamma_K\) form a bounded nonincreasing sequence and \(D_K(p)\to1\).
Apply (S14) in (S15) and let \(K\to\infty\). Both the finite-policy limiting
value and the full density value equal \(\lim_K\Gamma_K\). This proves (S4)
and existence of the finite-policy limit without an extra density unit bound.

All uses of the original asymptotic upper bound \(\Gamma(p)\le c<1\) now
refer to the same original finite-policy limit, not an enlarged model.

### A.4. Compact duality and removal of mass at infinity

Let \(\mathcal K=\mathbb N\cup\{\infty\}\) be the one-point compactification
of the discrete positive integers. It is a compact metric space, homeomorphic
to \(\{1,1/2,\ldots\}\cup\{0\}\). Let \(\mathcal P(\mathcal K)\) be its weakly
compact convex set of Borel probability measures.

For \(\lambda\in\mathcal P(\mathcal K)\), write
\(b=\lambda(\{\infty\})\), \(\lambda_k=\lambda(\{k\})\), and put
\[
F_p(\alpha,\lambda)=\int_{\mathcal K}R_k^p(\alpha)\,d\lambda(k)
=p\int_0^1\sum_s\alpha(t,s)w_s^\lambda(t)\,dt, \tag{S16}
\]
where
\[
w_s^\lambda(t)=b+\sum_{k\ge1}
   \frac{\lambda_k a_{s,k}(t)}{D_k(p)},\qquad 0\le w_s^\lambda\le1/p.
\tag{S17}
\]
Tonelli justifies the equality. For each \(\alpha\), (S3) says exactly that
\(k\mapsto R_k^p(\alpha)\) is continuous on \(\mathcal K\), so (S16) is
weakly continuous in \(\lambda\). For each \(\lambda\), it is continuous
linear in the \(L^1\) variable \(\alpha\), since
\[
|F_p(\alpha,\lambda)-F_p(\widetilde\alpha,\lambda)|
\le\|\alpha-\widetilde\alpha\|_1.
\]
Sion's minimax theorem, with the compact variable \(\lambda\) and the convex
possibly noncompact variable \(\alpha\), yields
\[
\Gamma(p)
=\sup_{\alpha\in\mathcal A_p}\inf_{\lambda\in\mathcal P(\mathcal K)}
 F_p(\alpha,\lambda)
=\min_{\lambda\in\mathcal P(\mathcal K)}
 \Phi_p(\lambda),\qquad
\Phi_p(\lambda):=\sup_{\alpha\in\mathcal A_p}F_p(\alpha,\lambda).
\tag{S18}
\]
Including \(k=\infty\) does not change the infimum of the tail ratios because
it is their limit. Attainment of the minimum follows because
\(\Phi_p\) is the supremum of continuous functions of \(\lambda\), hence is
lower semicontinuous on the compact set of probability measures.

#### A.4.1 A legal suffix-completion lemma

For any \(\alpha\in\mathcal A_p\), fix \(T\in(0,1)\) and an integer \(R\ge1\).
Keep \(\alpha\) on \((0,T)\). Afterwards use
\[
S^{T,R}(t)=S_\alpha(T)(T/t)^{pR},\qquad
\alpha^{T,R}(t,s)=S^{T,R}(t)/t\quad(s\le R),
\]
and zero for \(s>R\). This is an element of \(\mathcal A_p\), with
\[
N_\infty(\alpha^{T,R})
=1-S_\alpha(T)T^{pR}\longrightarrow1
\quad\text{as }R\to\infty\text{ for fixed }T<1. \tag{S19}
\]
It uses actual accepted-offer opportunities; it does not give a reward upon
failure. This is a feasible control in the independently defined density model; Appendix A.3 identifies its optimal value with the original finite-policy limit. No realization of every individual density by a single finite policy is asserted. For any nonnegative
bounded reward sequence \(w_s(t)\), its reward is at least the reward earned
by the original \(\alpha\) before \(T\). That prefix reward tends to the
full reward as \(T\uparrow1\), because \(\alpha\in L^1\).

In particular \(\Phi_p(\delta_\infty)=1\). More strongly, if
\(0<b<1\), let \(\nu\) be the normalized finite-rank part of \(\lambda\).
For every \(\alpha\), using (S19), first \(R\to\infty\) at fixed \(T\),
then \(T\uparrow1\), gives
\[
\Phi_p(\lambda)\ge b+(1-b)F_p(\alpha,\nu).
\]
Taking the supremum over \(\alpha\),
\[
\Phi_p(\lambda)\ge b+(1-b)\Phi_p(\nu)\ge b+(1-b)\Gamma(p).
\tag{S20}
\]
Since the original bound is \(\Gamma(p)\le c<1\), every minimizer in (S18)
must have
\[
\boxed{\lambda(\{\infty\})=0.} \tag{S21}
\]
The case \(b=1\) is excluded by \(\Phi_p(\delta_\infty)=1\); for \(0<b<1\),
(S20) is strictly greater than \(\Gamma(p)\).

Thus a genuine countably supported probability distribution on finite
top-\(k\) objectives attains the worst-case dual value. Mass at infinity has
been excluded by actual legal policies, rather than by an assumption that
the dual distributions are tight.

### A.5. Bellman verification for an attained infinite-tail utility

Fix a minimizing probability \(\lambda\) from (S18). By (S21), it has no
mass at infinity. Write
\[
w_s(t)=\sum_{k\ge1}\frac{\lambda_k a_{s,k}(t)}{D_k(p)}.
\]
Then \(w_s\) is continuous, nonincreasing in \(s\), and
\[
\sup_{t\in[0,1]}w_s(t)
\le\frac1p\sum_{k\ge s}\lambda_k\longrightarrow0,\qquad
w_1(t)\longrightarrow0\quad(t\downarrow0). \tag{S22}
\]
Continuity and the last limit follow from uniform summability by
\(\lambda_k/p\).

Truncate only the finite part:
\[
w_s^{(m)}(t)=\sum_{k=1}^m\frac{\lambda_k a_{s,k}(t)}{D_k(p)}.
\]
Let \(V_m\) be its finite-utility Bellman solution from Appendix A.2.
Let \(V(t)\) be the supremum reward for \(w\), starting at time \(t\) with
survival one, using the same density constraints on the remaining interval;
set \(V(1)=0\). Since the probability of ever accepting is at most one,
\[
0\le V(t)-V_m(t)
\le \|w-w^{(m)}\|_\infty
\le\frac1p\sum_{k>m}\lambda_k=:\epsilon_m\longrightarrow0, \tag{S23}
\]
uniformly for \(t\in[0,1]\).
Hence \(V\) is continuous, nonincreasing, bounded, and
\[
V(0)=\Phi_p(\lambda)=\Gamma(p),\qquad V(1)=0.
\tag{S24}
\]
Moreover \(V(t)>0\) for every \(t<1\): some \(\lambda_k>0\), and a rank-one
offer rule on a nonempty interval strictly after \(t\) has positive reward.

#### A.5.1 Regularity and the infinite Bellman equation

On any compact interval \(I=[\delta,T]\subset(0,1)\),
\(V(t)\ge V(T)>0\). By (S22), choose \(M\) so that
\(w_s(t)\le V(T)/4\) for \(s>M\), uniformly in \(t\).
By (S23), for all sufficiently large \(m\), \(V_m(t)\ge3V(T)/4\) on \(I\).
Therefore every positive part with \(s>M\) in the finite Bellman equations
is zero there. Their right sides converge uniformly on \(I\), giving
\[
-V'(t)=\frac p t\sum_{s\ge1}(w_s(t)-V(t))_+ \quad(0<t<1),
\tag{S25}
\]
and \(V\in C^1(0,1)\). At each \(t<1\), the positive-part sum is finite.

Near zero, \(w_1(t)\to0\) whereas \(V(t)\ge V(1/2)>0\); thus (S25) has
zero right side there and \(V\) is constant. Since \(V'\le0\), the fundamental
theorem on compact subintervals and continuity at one imply
\[
\int_0^1 -V'(t)\,dt=V(0)-V(1)=V(0)<\infty.
\]
Consequently \(V\) is absolutely continuous on the full closed interval.
In particular
\[
\int_0^1\frac1t\sum_s(w_s(t)-V(t))_+\,dt=V(0)/p<\infty.
\tag{S26}
\]
No finite first moment of \(\lambda\) has been assumed.

#### A.5.2 Verification for every feasible density

For any \(\alpha\in\mathcal A_p\), \(S_\alpha V\) is absolutely continuous.
The two nonnegative integrands on the right of (S9), now with infinite
\(w\), are integrable: the first is bounded by the integrand in (S26), and
the second by \(V(0)\sum_s\alpha(t,s)\). Thus Tonelli and integration by
parts give the exact identity
\[
\begin{aligned}
\Gamma(p)-F_p(\alpha,\lambda)
=p\int_0^1\bigg[
&\sum_s\left(\frac{S_\alpha(t)}t-\alpha(t,s)\right)
                        (w_s(t)-V(t))_+\\
&+\sum_s\alpha(t,s)(V(t)-w_s(t))_+
\bigg]dt.
\end{aligned} \tag{S27}
\]
The terminal contribution is zero because \(V(1)=0\), following the proven
absence of dual mass at infinity. Had a floor \(b\) remained, the correct
left side would have included the additional subtraction \(bS_\alpha(1)\)
as in (S10).

In particular, for every fixed relative rank \(R\) and time interval \(I\),
\[
F_p(\alpha,\lambda)\le\Gamma(p)
-p\int_I\alpha(t,R)(V(t)-w_R(t))_+\,dt.
\tag{S28}
\]
This loss estimate applies to arbitrary feasible densities, not just to
threshold policies or to an attained primal optimum.

### A.6. Strictness from the transferred positive bad-rank mass

Fix \(0<p<p_0\le1\), put \(q=p/p_0<1\), and let
\(g=\Gamma(p_0)>0\). Positivity follows, for example, by offering only to
relative rank one after time \(1/2\): its top-one numerator is positive,
and every \(N_k/D_k\ge N_1\).

For any \(\alpha^0\in\mathcal A_{p_0}\), define the continuous binomial
transform
\[
\alpha'(t,s)=\sum_{r=1}^{s}
 \binom{s-1}{r-1}q^{r-1}(1-q)^{s-r}\alpha^0(t,r). \tag{S29}
\]
Its row sums are one and its infinite column sums are \(1/q\). Tonelli gives
\[
p\sum_s\alpha'(t,s)=p_0\sum_r\alpha^0(t,r)
\quad\text{for almost every }t,
\]
so the survival functions are exactly equal and \(\alpha'\in\mathcal A_p\).
Set \(N_0^{p_0}=D_0(p_0)=0\). The binomial thinning identity gives, for all finite \(k\),
\[
N_k^p(\alpha')=\mathbb E[N_J^{p_0}(\alpha^0)],
\qquad J\sim\operatorname{Bin}(k,q). \tag{S30}
\]
Indeed if \(H\sim\operatorname{Bin}(k,t)\), then thinning \(H\) by \(q\)
and thinning \(k\) by \(q\) before observing with probability \(t\) both give
\(\operatorname{Bin}(k,tq)\). Together with the negative-binomial column
identity, this is the continuous counterpart of the first-round finite
intertwining proof. In particular a common robust guarantee transfers
unchanged, including at \(k=\infty\) by (S3).

Take the minimizing \(\lambda\) at the **lower** probability \(p\), with
Bellman function \(V\) from Appendix A.5. Put \(\delta=g/4\), so
\(0<\delta<1/4\), and \(I=[\delta,1-\delta]\).
By positivity, \(v:=V(1-\delta)>0\).
By (S22), choose a finite \(R\) with
\(\sup_t w_R(t)\le v/2\). Then
\[
V(t)-w_R(t)\ge v/2\qquad(t\in I). \tag{S31}
\]

For \(\varepsilon>0\), choose \(\alpha^0\) at \(p_0\) with robust ratio at
least \(g-\varepsilon\); no primal attainment is assumed. Because
\(a_{1,1}(t)=t\),
\[
\int_0^1t\alpha^0(t,1)\,dt=R_1^{p_0}(\alpha^0)\ge g-\varepsilon.
\]
Feasibility gives \(t\alpha^0(t,1)\le1\), so
\[
\int_I\alpha^0(t,1)\,dt
\ge\int_I t\alpha^0(t,1)\,dt
\ge g-\varepsilon-2\delta. \tag{S32}
\]
The \(r=1\) term of (S29) forces
\[
\alpha'(t,R)\ge(1-q)^{R-1}\alpha^0(t,1). \tag{S33}
\]
Since \(\alpha'\) retains robust ratio \(g-\varepsilon\), its
\(\lambda\)-weighted payoff is at least \(g-\varepsilon\).
Apply (S28) together with (S31)-(S33):
\[
g-\varepsilon
\le F_p(\alpha',\lambda)
\le\Gamma(p)-p\frac v2(1-q)^{R-1}
                 (g-\varepsilon-2\delta).
\]
Let \(\varepsilon\downarrow0\), recalling \(2\delta=g/2\). We obtain
\[
\boxed{
\Gamma(p)-\Gamma(p_0)
\ge \frac{pvg}{4}(1-p/p_0)^{R-1}>0.
} \tag{S34}
\]
The integer \(R\) and \(v\) are specified by the attained dual at \(p\);
this is a rigorous positive certificate, not an advertised explicit
universal numerical modulus. Equation (S4) proves Theorem G for the original
limiting robust ratio.

