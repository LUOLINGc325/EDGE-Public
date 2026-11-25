# 自适应指数核回归的尖锐同时置信宽度

研究稿，2026 年 11 月 25 日。

**范围与验证状态。** 本文针对固定区间 $[0,1]$ 上的一维核 $k(s,t)=\exp(-|s-t|)$，给出标准核岭回归预测器的书面证明。正则化矩阵为 $K_n+\lambda^2I$，其中 $\lambda>0$ 在观测数据之前固定。上界覆盖所有可预测采样设计与条件次高斯噪声。匹配下界针对这一特定预测器及其归一化方式下、要求同时覆盖整个空间的确定性标量宽度。它不是预先指定单点的下界，也不是对所有可能估计量的下界。本文不声称已获 Lean 形式化验证或外部同行评议。

## 摘要

我们证明，对每个固定的 $\lambda>0$，一维指数核的标准核岭回归所需的同时空间覆盖、后验标准差归一化置信宽度，其阶为 $B+(R/\lambda)\sqrt{\log(n/\delta)}$，其中 $B$ 为 RKHS 范数上界，$R$ 为条件次高斯噪声尺度。上界允许任意可预测采样、重复采样位置，以及端点处的观测与查询，并保留通常的 KRR 中心和后验方差。确定性的重复网格设计给出匹配的高斯下界，另一个零噪声构造给出偏差项下界。证明利用后验 Green 函数的非负性、单峰性及总影响量上界。确定性网格上的下包络将依赖响应的随机后验权重，归约到有限族可预测区间鞅的控制。本文还给出抽象形状判据、全时间置信序列，以及显式的信息增益遗憾界推论。所声称的阶比较针对固定正则化参数，不是对所有正则化参数区间的一致结论。

## 1. 模型、问题与精确贡献

令 $(\mathcal F_i)_{i\ge0}$ 为一个滤过。采样位置 $X_i\in[0,1]$ 为 $\mathcal F_{i-1}$-可测，并观测

$$Y_i=f(X_i)+\varepsilon_i,$$

其中 $f$ 是核 $k(s,t)=e^{-|s-t|}$ 所对应实再生核希尔伯特空间 $H$（RKHS）中的固定非随机函数，满足 $\|f\|_H\le B$。采样策略的独立随机化可以纳入滤过。噪声为 $\mathcal F_i$-可测，且几乎处处对每个实数 $a$ 满足

$$\mathbb E[e^{a\varepsilon_i}\mid\mathcal F_{i-1}]\le e^{a^2R^2/2}. \tag{1}$$

这里 $B,R\ge0$，$\lambda>0$。当 $R=0$ 时，式 (1) 强制 $\varepsilon_i=0$ 几乎处处成立，以下所有噪声项均为零。我们不假设最终采样设计与已观测噪声相互独立。

对 $n\ge1$，记

$$K_n=(k(X_i,X_j))_{i,j\le n},\quad k_n(x)=(k(X_i,x))_{i\le n},\quad A_n=K_n+\lambda^2I_n,$$

$$\mu_n(x)=k_n(x)^TA_n^{-1}Y_{1:n},\qquad
\sigma_n(x)^2=1-k_n(x)^TA_n^{-1}k_n(x). \tag{2}$$

并记 $\mu_0=0$、$\sigma_0=1$。下文将证明，对每个有限采样设计及每个 $x$，都有 $\sigma_n(x)>0$。

将 $\rho_n^*(\delta;B,R,\lambda)$ 定义为满足下述要求的所有确定性数值 $r\ge0$ 的下确界：对每个满足上述假设的模型，均有

$$\mathbb P\left(\forall x\in[0,1]: |f(x)-\mu_n(x)|\le r\sigma_n(x)\right)\ge1-\delta. \tag{3}$$

这里的下确界仅针对标量宽度，式 (2) 中的中心与归一化方式固定，并非对估计量取下确界。式 (3) 对噪声律的量化同时包括独立 $N(0,R^2)$ 噪声与恒为零的噪声。

### 主定理

对 $n\ge1$、$0<\delta<1$，定义

$$M_n=\max\{1,\lceil2n^2/\lambda^2\rceil\},\quad J_n=\frac{M_n(M_n+1)}2,$$

$$u_n(\delta)=\log\frac{4J_nn}{\delta},\qquad v_n(\delta)=\log\frac{4n}{\delta},$$

$$b_n(\delta)=B+\frac R\lambda\left[\sqrt{2u_n(\delta)}+\sqrt{2v_n(\delta)}\right]. \tag{4}$$

**定理 1（显式上界与匹配阶）。** 每个满足式 (1)–(2) 的模型均满足

$$\mathbb P\left(\forall x\in[0,1]:\frac{|f(x)-\mu_n(x)|}{\sigma_n(x)}\le b_n(\delta)\right)\ge1-\delta. \tag{5}$$

当 $n\ge4$ 且 $0<\delta\le1/4$ 时，

$$\rho_n^*(\delta;B,R,\lambda)\ge
\frac1{16(1+\lambda^2)}\left[B+\frac R\lambda\sqrt{\log(n/\delta)}\right]. \tag{6}$$

因此，对每个固定的 $\lambda>0$，

$$\rho_n^*(\delta;B,R,\lambda)\asymp_\lambda
B+\frac R\lambda\sqrt{\log(n/\delta)},\qquad n\ge4,\quad0<\delta\le1/4. \tag{7}$$

式 (7) 中的比较常数与 $B,R,n,\delta$ 无关，但可以依赖于 $\lambda$。式 (6) 的下界仅由确定性设计即可得到。因此，本结果并未辨识由自适应性造成的额外代价；它表明，任意可预测采样不会使同时空间覆盖所需的宽度超出这一阶。

### 与已有文献的关系

Vakili、Scarlett 与 Javidi [V21] 提出了在线核置信宽度问题。Lattimore [L23] 通过另一种自适应构造证明了连续时间下界。Hu 与 Simchi-Levi [HS26] 对加性的“线性核加周期 Sobolev 核”证明了离散时间最坏核结论，同时将特定 Matérn 核与平方指数核的情况保留为开放问题。本文定理处理固定的一维 Matérn-$1/2$ 情形，并不改变或否定最坏核下界。

Flynn 与 Reeb [FR25] 构造了更紧的序贯置信集合，改善实际实现的宽度，并保留其文中给出的最坏情形信息增益保证。本文的贡献是：针对固定预测器 (2) 与一个特定固定核，刻画置信宽度的阶，并给出一个充分的后验形状判据。经典 OU 精度矩阵公式、非负 Green 函数、层积分与鞅指数界均属于采用的背景工具，不各自作为原创性主张。文献比较以本文所述范围为限；不声称全球优先权。

## 2. 后验形状权重的可复用集中定理

下述结果不依赖高斯过程。其统计事件在任何依赖响应的权重函数被选定之前就已确定。

**定理 2（形状与总质量判据）。** 假设 $X_i$ 可预测，且式 (1) 成立。固定 $A,L\ge0$、整数 $p\ge1$、$\alpha\in(0,1]$ 以及整数 $M\ge1$。将 $[0,1]$ 划分为 $M$ 个确定性的等长单元，除包含 $1$ 的最后一个单元外，均取左闭右开。记 $J=M(M+1)/2$、$u=\log(4Jn/\delta)$、$v=\log(4n/\delta)$。

以至少 $1-\delta$ 的概率，下述结论对每个满足以下逐路径条件的连续函数 $g:[0,1]\to[0,\infty)$ 同时成立：

1. 每个严格超水平集 $\{t:g(t)>a\}$ 是至多 $p$ 个区间的并，其中 $p\ge1$ 为整数。
2. $(\sup_tg(t))\sum_{i=1}^ng(X_i)\le A^2$。
3. 对 $\alpha\in(0,1]$，有 $|g(s)-g(t)|\le L|s-t|^\alpha$。

这里 $g$ 可以依赖全部观测。结论为

$$\left|\sum_{i=1}^ng(X_i)\varepsilon_i\right|
\le AR\sqrt{2pu}+nLM^{-\alpha}R\sqrt{2v}. \tag{8}$$

同一个事件适用于所有符合条件的函数，包括不可数函数族：该事件是关于固定网格区间及单个噪声的有限个事件之交。

### 2.1. 可预测区间计数

令 $I$ 为若干连续网格单元的并。这样的非空区间恰有 $J$ 个。定义

$$S_I=\sum_{i=1}^n\mathbf1_{\{X_i\in I\}}\varepsilon_i,\qquad N_I=\sum_{i=1}^n\mathbf1_{\{X_i\in I\}}.$$

由于指示量可预测，对条件期望按 $i$ 迭代，条件矩母函数假设给出

$$\mathbb E\exp\left(aS_I-\frac{a^2R^2N_I}2\right)\le1 \tag{9}$$

对固定的 $m\in\{1,\ldots,n\}$，在式 (9) 中取 $a=\sqrt{2u}/(R\sqrt m)$。在事件 $S_I\ge R\sqrt{2mu}$、$N_I=m$ 上，该指数项至少为 $e^u$。应用 Markov 不等式，再对 $-S_I$ 使用相同论证，得到

$$\mathbb P\{|S_I|\ge R\sqrt{2mu},\ N_I=m\}\le2e^{-u}.$$

对 $m$ 与 $I$ 取并，便证明下式的失败概率至多为 $2Jn e^{-u}=\delta/2$：

$$|S_I|\le R\sqrt{2uN_I}\quad\hbox{for every grid interval }I. \tag{10}$$

即式 (10) 对每个网格区间 $I$ 同时成立。当 $N_I=0$ 时，相应和为零。当 $R=0$ 时，所有结论直接成立，无须除以 $R$。由式 (1) 再作一次并集界，得到失败概率至多为 $2n e^{-v}=\delta/2$ 的界

$$\max_{i\le n}|\varepsilon_i|\le R\sqrt{2v}. \tag{11}$$

式 (9)–(11) 中没有对最终采样位置进行条件化。

### 2.2. 单元下包络与层积分

对每个单元 $C$，定义 $\underline g(C)=\inf_{t\in\overline C}g(t)$，即在其闭包上取下确界。令 $a_i=\underline g(C(X_i))$。则

$$0\le a_i\le g(X_i),\qquad |g(X_i)-a_i|\le LM^{-\alpha}. \tag{12}$$

对每个水平 $a$，满足 $\underline g(C)>a$ 的单元构成至多 $p$ 块连续单元。事实上，每个这样的闭单元都位于严格超水平集的某个区间分支内，而同一分支内两个符合条件的单元之间的所有单元也符合条件。该论证使用实际区间与连续性，因而涵盖恰好位于网格边界的情况，也直接避免了对任意随机阈值作并集界。

在事件 (10) 上，至多 $p$ 个互不相交网格区间之并上的噪声和，其绝对值至多为

$$R\sqrt{2u}\sum_{j=1}^p\sqrt{N_j}\le R\sqrt{2pu}\sqrt{\sum_jN_j}.$$

记 $N_a=\#\{i:a_i>a\}$、$a_* =\max_i a_i$。有限和的层积分恒等式与关于水平变量的 Cauchy–Schwarz 不等式给出

$$\left|\sum_i a_i\varepsilon_i\right|
\le R\sqrt{2pu}\int_0^{a_*}\sqrt{N_a}\,da
\le R\sqrt{2pu}\sqrt{a_*\sum_i a_i}\le AR\sqrt{2pu}. \tag{13}$$

若 $a_*=0$，上式直接解释为零。最后，式 (11)–(12) 将余项控制为 $nLM^{-\alpha}R\sqrt{2v}$，从而证明式 (8)。特别地，就此处的用途而言，“总质量乘最大值”条件强于仅有的经验 $\ell_2$ 界，并避免了一个多余的对数因子。

## 3. 精确 RKHS 与确定性后验恒等式

本节所有结果均对每个确定性的有限采样位置多重集成立。因此，它们也对自适应位置多重集逐路径成立，无须改变误差的分布。

**引理 3（精确能量与预解算子）。** 核 $e^{-|s-t|}$ 在 $[0,1]$ 上的 RKHS 是实 Sobolev 空间 $H^1([0,1])$，取其连续代表元，并配备内积

$$\langle u,v\rangle_H=
\frac12\int_0^1(u'v'+uv)\,dt+
\frac12[u(0)v(0)+u(1)v(1)]. \tag{14}$$

验证如下：这一范数与通常的 $H^1$ 范数等价，所以该空间完备，点评价泛函连续。对内点 $x$，函数 $k_x(t)=e^{-|x-t|}$ 在 $x$ 之外满足 $k_x''=k_x$，在 $x$ 处的导数跳跃为 $-2$，并满足边界导数条件 $k_x'(0)=k_x(0)$、$k_x'(1)=-k_x(1)$。分部积分给出 $\langle u,k_x\rangle_H=u(x)$。当 $x=0$ 时，系数 $(k_0(0)-k_0'(0))/2$ 等于一，另一端点的边界项为零；当 $x=1$ 时，作对称计算即可。与每个 $k_x$ 正交的函数处处为零，这同时证明其张成空间稠密，并完成再生核的精确识别。

定义

$$V=I+\lambda^{-2}\sum_{i=1}^n k_{X_i}\otimes k_{X_i},\qquad
h_x(t)=k(x,t)-k_n(x)^TA_n^{-1}k_n(t).$$

直接代入，或等价地使用有限秩 Woodbury 恒等式，得到 $h_x=V^{-1}k_x$。因此，对每个 $v\in H$，

$$\langle h_x,v\rangle_H+\lambda^{-2}\sum_i h_x(X_i)v(X_i)=v(x). \tag{15}$$

特别地，

$$\sigma_n(x)^2=h_x(x)=\|h_x\|_H^2+\lambda^{-2}\sum_i h_x(X_i)^2. \tag{16}$$

点 $x$ 处的评价泛函非零，因此 $h_x\ne0$ 且 $\sigma_n(x)>0$。由于 $V\succeq I$，还有 $\sigma_n(x)\le1$。

### 3.1. 非负性与精确边界项

**引理 4（非负、单峰的后验协方差）。** 对每个设计与查询点，都有 $h_x\ge0$；它在 $[0,x]$ 上单调不减且凸，在 $[x,1]$ 上单调不增且凸。

为证明非负性，在式 (15) 中取 Sobolev 负部 $h_- =\max\{-h_x,0\}$ 为检验函数。Sobolev 链式法则与式 (14) 的端点项给出

$$-\|h_-\|_H^2-\lambda^{-2}\sum_i h_-(X_i)^2=h_-(x)\ge0.$$

因而 $h_-=0$，再由连续性可知 $h_x$ 处处非负。

记 $r_a=\#\{i:X_i=a\}$，若 $a$ 未被观测，则令 $r_a=0$。在各个不同观测位置与查询点之间，式 (15) 给出 $h_x''=h_x$。由于 $h_x$ 是有限个指数函数的线性组合，它在分段节点处存在单侧导数。对式 (15) 分部积分可知，每个内部节点 $a$ 均满足

$$h_x'(a+)-h_x'(a-)=\frac{2r_a}{\lambda^2}h_x(a)-2\mathbf1_{\{a=x\}}, \tag{17}$$

精确的端点条件为

$$h_x'(0+)=(1+2r_0/\lambda^2)h_x(0)-2\mathbf1_{\{x=0\}},$$

$$h_x'(1-)=-(1+2r_1/\lambda^2)h_x(1)+2\mathbf1_{\{x=1\}}. \tag{18}$$

在 $(0,x)$ 上，二阶导数是非负测度：它由 $h_x(t)\,dt$ 与观测处的非负导数跳跃组成。当 $x>0$ 时，左端点导数非负，所以左侧所有斜率均非负。在 $(x,1)$ 上，斜率向右单调不减；当 $x<1$ 时，右端点导数非正，因此右侧所有斜率均非正。这也证明了两侧各自的凸性。若 $x=0$，只需使用右侧论证及未受查询点影响的端点 $1$；若 $x=1$，只需使用左侧论证。重复观测以及观测位置与查询点重合的情形，均已纳入式 (17)–(18)。由此得到

$$0\le h_x(t)\le h_x(x)=\sigma_n(x)^2. \tag{19}$$

### 3.2. 总影响量与归一化连续模

令 $z=A_n^{-1}k_n(x)$。矩阵乘法给出

$$h_x(X_i)=\lambda^2z_i. \tag{20}$$

**引理 5（不超过一的总影响量与归一化形状界）。** 对每个设计与查询点，

$$z_i\ge0,\quad\sum_i z_i\le1,\quad
g_x(t):=\frac{h_x(t)}{\lambda^2\sigma_n(x)}\ge0,$$

$$\sup_tg_x(t)=\frac{\sigma_n(x)}{\lambda^2},\quad
\sum_i g_x(X_i)\le\frac1{\sigma_n(x)},\quad
|g_x(t)-g_x(s)|\le\frac{\sqrt{2|t-s|}}{\lambda^2}. \tag{21}$$

总影响量结论需要单独证明，不能仅由非负性推出。令 $m(t)=k_n(t)^TA_n^{-1}\mathbf1$。它满足弱方程

$$\langle m,v\rangle_H+\lambda^{-2}\sum_i m(X_i)v(X_i)=\lambda^{-2}\sum_i v(X_i).$$

取 $p=(m-1)_+$。由于 $\langle m,p\rangle_H=\|p\|_H^2+\langle1,p\rangle_H$，且

$$\langle1,p\rangle_H=\tfrac12\int_0^1p+\tfrac12[p(0)+p(1)]\ge0,$$

弱方程给出

$$\|p\|_H^2+\langle1,p\rangle_H+\lambda^{-2}\sum_i p(X_i)^2=0.$$

因此 $m\le1$。式 (20) 与引理 4 给出 $z_i\ge0$；又有 $m(x)=\sum_i z_i$，所以总质量上界成立。式 (21) 的最大值结论由式 (19) 得到。最后，式 (16) 蕴含 $\|h_x\|_H\le\sigma_n(x)$。再生性质给出

$$|h_x(t)-h_x(s)|\le\|h_x\|_H\|k_t-k_s\|_H
\le\sigma_n(x)\sqrt{2(1-e^{-|t-s|})},$$

从而证明式 (21) 中的连续模。这个归一化估计与设计无关，也不依赖于 $\sigma_n(x)$ 已经缩小到何种程度。

## 4. 上界与置信序列的证明

利用 $h_x=V^{-1}k_x$，式 (2) 的信号与噪声分解为

$$f(x)-\mu_n(x)=\langle h_x,f\rangle_H-\sum_i z_i\varepsilon_i. \tag{22}$$

由式 (16)，第一项的绝对值至多为 $B\sigma_n(x)$。第二项归一化后为 $\sum_i g_x(X_i)\varepsilon_i$。

在定理 2 中取 $p=1$、$A=1/\lambda$、$L=\sqrt2/\lambda^2$、$\alpha=1/2$、$M=M_n$。引理 4–5 对所有查询点同时验证了每一项逐路径假设。网格的选取满足

$$nLM_n^{-1/2}=\frac{n\sqrt2}{\lambda^2\sqrt{M_n}}\le\frac1\lambda. \tag{23}$$

当 $M_n=1$ 时，该不等式仍成立，因为此时 $2n^2/\lambda^2\le1$。式 (8)、(22)、(23) 给出式 (5)。定理 2 的事件不依赖其后如何选择查询点，因此也允许在全部数据观测完成之后选取查询点。

对每个固定的 $\lambda$，有 $M_n\le(1+2/\lambda^2)n^2$，且 $J_n\le M_n^2$。因此，当 $n\ge4$、$\delta\le1/4$ 时，式 (4) 中的两个对数项均不超过一个仅依赖 $\lambda$ 的常数乘以 $\log(n/\delta)$。这就证明了式 (7) 的上界部分，而不声称渐近常数对 $\lambda$ 一致。

**推论 6（全时间同时空间置信序列）。** 对 $n\ge1$，令 $\delta_n=\delta/[n(n+1)]$、$\beta_n=b_n(\delta_n)$；另令 $\beta_0=B$。则

$$\mathbb P\left(\forall n\ge0,\ \forall x\in[0,1]: |f(x)-\mu_n(x)|\le\beta_n\sigma_n(x)\right)\ge1-\delta. \tag{24}$$

事实上，$\sum_{n\ge1}1/[n(n+1)]=1$，而式 (5) 适用于每个确定的 $n$。$n=0$ 时的结论为 $|f(x)|\le B$。特别地，在随机停止时刻查看该序列，式 (24) 仍然成立。这是一个置信序列上界；本文不声称时间一致常数最优，也不声称迭代对数级结论。

## 5. 匹配的确定性设计下界

**定理 7（有限样本下界）。** 设 $n\ge4$、$m=\lfloor\sqrt n\rfloor$、$0<\delta<1$。则

$$\rho_n^*(\delta;B,R,\lambda)\ge
\frac R{2\lambda(1+\lambda^2)}
\Phi^{-1}\left(\frac{1+(1-\delta)^{1/m}}2\right), \tag{25}$$

其中 $R=0$ 时的噪声贡献为零。此外，独立地，对每个 $n\ge1$ 与 $0<\delta<1$，

$$\rho_n^*(\delta;B,R,\lambda)\ge B\sqrt{1-e^{-2}}. \tag{26}$$

这里 $\Phi$ 表示标准正态分布函数。

### 5.1. 重复网格与归一化协方差

令 $q=\lfloor n/m\rfloor$、$r=n-mq$。使用位置 $t_j=(j-1)/(m-1)$，$j=1,\ldots,m$，在前 $r$ 个位置各观测 $q+1$ 次，在其余位置各观测 $q$ 次。用 $q_j$ 表示各位置的观测次数，并记 $D=\operatorname{diag}(q_j)$。这样恰好使用全部 $n$ 次观测，且 $q\ge m\ge2$。

取 $f=0$，误差独立服从 $N(0,R^2)$。令 $K=(k(t_i,t_j))$、$Q=K^{-1}$、$C=(Q+\lambda^{-2}D)^{-1}$、$S=\operatorname{diag}(C_{jj})$。在通常的 KRR 方程中合并重复观测，得到 $\sigma_n(t_j)^2=C_{jj}$ 以及 $\mu_n(t_{1:m})=\lambda^{-2}Ce$，其中 $e_j$ 为位置 $t_j$ 处所有误差之和。验证这一合并方式的一种方法，是对潜在位置值 $u$ 最小化

$$u^TQu+\lambda^{-2}\sum_jq_j(u_j-\overline Y_j)^2$$

这些不同位置上取值为 $u$ 的最小范数插值函数，其 RKHS 范数平方为 $u^TQu$。正规方程给出上述预测公式，同一矩阵恒等式也给出 $C$。

由于 $e\sim N(0,R^2D)$，各位置处的归一化误差向量 $Z=S^{-1/2}\lambda^{-2}Ce$ 具有协方差

$$\Sigma=\frac{R^2}{\lambda^4}S^{-1/2}CDC S^{-1/2}. \tag{27}$$

记 $h=1/(m-1)$、$a=e^{-h}$。直接相乘可验证，矩阵 $K_{ij}=a^{|i-j|}$ 的逆为三对角矩阵：两端对角元为 $1/(1-a^2)$，内部对角元为 $(1+a^2)/(1-a^2)$，相邻非对角元为 $-a/(1-a^2)$。当 $m=2$ 时，两个对角元均为端点对角元。其正定性也可由以下二次型看出：

$$v^TQv=v_1^2+\sum_{j=1}^{m-1}\frac{(v_{j+1}-av_j)^2}{1-a^2}>0\quad(v\ne0).$$

最大绝对行和给出

$$\|Q\|_{\rm op}\le\frac{1+a}{1-a}=1+\frac2{e^h-1}\le2m. \tag{28}$$

利用 $qI\preceq D\preceq(q+1)I$，可得

$$\frac{\lambda^2}{q+1+2\lambda^2m}I\preceq C\preceq\frac{\lambda^2}qI,\qquad
S\preceq\frac{\lambda^2}qI.$$

又有 $CDC\succeq qC^2$。因此，对式 (27) 作合同变换得到

$$\Sigma\succeq\frac{R^2}{\lambda^2}
\left(\frac q{q+1+2\lambda^2m}\right)^2I
\succeq\left[\frac R{2\lambda(1+\lambda^2)}\right]^2I. \tag{29}$$

这些都是确定性矩阵不等式，没有假设未经证明的归一化坐标之间的独立性。

### 5.2. 高斯小球概率界

当 $R>0$ 时，记 $a_\lambda=R/[2\lambda(1+\lambda^2)]$。由式 (29)，在分布意义下可写为 $Z=a_\lambda\xi+\eta$，其中 $\xi\sim N(0,I_m)$，并与 $\eta\sim N(0,\Sigma-a_\lambda^2I)$ 独立。允许 $\eta$ 的协方差矩阵奇异。

对一维中心高斯分布，给定长度的区间以零为中心时具有最大概率。对区间向正方向平移后的概率质量求导，并使用密度的对称性及其随绝对值增大而递减的性质，即可验证此事实。因此，以 $\eta$ 为条件，利用 $\xi_j$ 的独立性得到

$$\mathbb P(\max_j|Z_j|\le t)\le[2\Phi(t/a_\lambda)-1]^m. \tag{30}$$

同时覆盖整个空间的置信带必须覆盖这 $m$ 个位置，故式 (30) 证明了式 (25)。

### 5.3. 显式对数阶

对 $0<\delta\le1/4$，令 $z=\Phi^{-1}((1+(1-\delta)^{1/m})/2)$、$L=\log(m/\delta)\ge\log8$。则

$$1-\Phi(z)=\frac{1-(1-\delta)^{1/m}}2\le\frac{2\delta}{3m}.$$

另一方面，当 $z\ge0$ 时，

$$1-\Phi(z)\ge\frac{e^{-(z+1)^2/2}}{\sqrt{2\pi}}\ge\frac{e^{-z^2}}{e\sqrt{2\pi}}.$$

第一个不等式仅在 $z$ 到 $z+1$ 之间积分密度；第二个使用 $(z+1)^2/2\le z^2+1$。因而 $z^2\ge L+\log[3/(2e\sqrt{2\pi})]\ge L/4$。最后一步只需使用 $e\sqrt{2\pi}<7$ 与 $3/14>8^{-3/4}$。由于 $n\ge4$ 时有 $m\ge n^{1/4}$，便得到

$$\rho_n^*(\delta;B,R,\lambda)\ge
\frac R{8\lambda(1+\lambda^2)}\sqrt{\log(n/\delta)}. \tag{31}$$

### 5.4. 偏差项及两部分的合并

仅在 $0$ 处观测，并使用恒为零的噪声。记 $a=e^{-1}$，令

$$f=\frac B{\sqrt{1-a^2}}(k_1-ak_0).$$

再生性质给出 $\|f\|_H=B$、$f(0)=0$、$f(1)=B\sqrt{1-a^2}$。所有响应均为零，因此 $\mu_n=0$，而 $\sigma_n(1)\le1$。这证明了式 (26)。式 (3) 中的宽度必须分别覆盖这个设计与上述高斯网格设计。对式 (26)、(31) 使用 $\max\{u,v\}\ge(u+v)/2$，再利用 $\sqrt{1-e^{-2}}\ge1/[8(1+\lambda^2)]$，即可得到式 (6)。结合第 4 节，定理 1 得证。

## 6. 标准 GP-UCB 的信息增益推论

本节是一项推论，不声称提出新的通用 bandit 算法或新的信息增益界。对上述核与固定的 $\lambda$，定义

$$\Gamma_T=\frac12\sup_{x_1,\ldots,x_T\in[0,1]}
\log\det(I_T+\lambda^{-2}K_T).$$

采用 $U_t(x)=\mu_{t-1}(x)+\beta_{t-1}\sigma_{t-1}(x)$ 的一个可测最大化点，其中 $\beta$ 来自推论 6。由连续性，最大化点集合非空且紧。取该集合的最小元素即可得到可预测选择：对确定的 $a\in[0,1]$，该元素不超过 $a$ 的事件就是 $\{\max_{[0,a]}U_t=\max_{[0,1]}U_t\}$；两个最大值都可写成可数稠密集上的上确界，所以都是 $\mathcal F_{t-1}$-可测的（端点单点集的情况直接处理）。令 $x^*$ 为 $f$ 的最大化点，并定义累积遗憾 $\mathcal R_T=\sum_{t=1}^T(f(x^*)-f(X_t))$。

**推论 8（以信息增益表示的遗憾界）。** 在式 (24) 的置信事件上，对每个 $T\ge1$，

$$\mathcal R_T\le2\overline\beta_T
\sqrt{\frac{2T\Gamma_T}{\log(1+\lambda^{-2})}},\qquad
\overline\beta_T=\max_{0\le s<T}\beta_s. \tag{32}$$

乐观原则给出 $f(x^*)-f(X_t)\le2\beta_{t-1}\sigma_{t-1}(X_t)$。Schur 补给出逐路径的行列式恒等式

$$\log\det(I_T+\lambda^{-2}K_T)
=\sum_{t=1}^T\log(1+\lambda^{-2}\sigma_{t-1}(X_t)^2).$$

由于 $0\le\sigma_{t-1}^2\le1$，凹性蕴含对 $a\in[0,1]$ 有 $\log(1+\lambda^{-2}a)\ge a\log(1+\lambda^{-2})$。将此不等式求和，再对遗憾和使用 Cauchy–Schwarz 不等式，即得式 (32)。可以代入某个已知的核专有 $\Gamma_T$ 上界，但式 (32) 本身不需要任何未阅读的外部信息增益定理。

## 7. 为什么直接使用随机阈值的论证会失败

**命题 9（自适应阈值障碍）。** 存在可预测位置与独立 Rademacher 误差，使得在观测完成之后选取的一个阈值，可以将所有正误差与所有负误差完全分开。

初始令 $L_0=0$、$U_0=1$。取 $X_i=(L_{i-1}+U_{i-1})/2$。若 $\varepsilon_i=+1$，令 $L_i=X_i$、$U_i=U_{i-1}$；若 $\varepsilon_i=-1$，令 $L_i=L_{i-1}$、$U_i=X_i$。这些位置可预测。对 $c=(L_n+U_n)/2$，有

$$\mathbf1_{\{X_i<c\}}=\mathbf1_{\{\varepsilon_i=+1\}}\quad\hbox{for every }i.$$

即该恒等式对每个 $i$ 成立。因此，所选区间上的和为 $N_+$，所选计数也为 $N_+$；当 $N_+>0$ 时，其按计数平方根归一化的值为 $\sqrt{N_+}$。由于 $\mathbb EN_+=n/2$、$\operatorname{Var}(N_+)=n/4$，Chebyshev 不等式给出 $\mathbb P(N_+\ge n/4)\ge1-4/n$。特别地，当 $n\ge8$ 时，这个随机阈值对应的计数归一化和以至少 $1/2$ 的概率不小于 $\sqrt n/2$。

这排除了对所有依赖响应选取的连续域区间直接套用对数级并集界的做法。定理 2 的证明使用确定性有限网格，并对实际后验权重的连续性作定量控制。整个论证从未把最终设计视为与其噪声独立。

## 8. 适用边界与验证局限

这些结果针对固定一维区间上的幅度为一的指数核，以及固定且严格为正的正则化参数。它们没有证明 $\nu>1/2$、平方指数核、高维区域、任意核之和、由数据选择的正则化参数，或零正则化下的对应结果。重新缩放区间或核时需要追踪相应常数；这不是本文定理所需的步骤。

匹配下界针对一个同时覆盖整个空间及式 (3) 中所有模型的确定性宽度。它不蕴含预先指定单点的 $\sqrt{\log n}$ 下界，不是对每个估计量的下界，也不表示存在额外的自适应性惩罚。全时间构造是有效的置信序列上界；本文不声称其序贯常数尖锐。式 (4) 中的有限样本常数较保守，在实际样本量下可能较松。

完整数学论证是解析性的。配套 NumPy 检查考察后验非负性、重复与端点情形、连续模、总影响量，以及有限维下界协方差不等式。它们是浮点诊断，不是证明证书，也不能替代普适命题。此版本未附诊断程序，不声称已有编译通过的形式化覆盖。

## 参考文献

- **[V21]** S. Vakili, J. Scarlett and T. Javidi. *Open Problem: Tight Online Confidence Intervals for RKHS Elements*. COLT 2021, PMLR 134. 官方来源：<https://proceedings.mlr.press/v134/vakili21a/vakili21a.pdf>。
- **[L23]** T. Lattimore. *A Lower Bound for Linear and Kernel Regression with Adaptive Covariates*. COLT 2023, PMLR 195:2095–2113. <https://proceedings.mlr.press/v195/lattimore23b.html>。
- **[HS26]** H. Hu and D. Simchi-Levi. *Tight Sequential Confidence Intervals for Online Kernel Regression*. arXiv:2611.19772v1，2026 年 11 月 15 日。<https://arxiv.org/html/2611.19772v1>。
- **[FR25]** H. Flynn and D. Reeb. *Tighter Confidence Bounds for Sequential Kernel Regression*. AISTATS 2025, PMLR 258:3844–3852；已检阅的预印本为 arXiv:2403.12732v2。<https://proceedings.mlr.press/v258/flynn25a.html>；<https://arxiv.org/html/2403.12732v2>。

来源版本与访问限制另行记录。本文不使用任何未检阅论文来闭合数学证明步骤。
