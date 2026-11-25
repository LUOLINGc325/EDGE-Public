# 顺序局部隐私下的高斯自协方差估计

*统一极小极大定律与自适应滤波信息界*

AI 辅助研究稿

2026年11月25日

# 摘要

设一个实值、均值为零的平稳高斯过程具有谱密度 $f$，且 $m\leq 2\pi f\leq M$，其中 $0<m<1<M$ 为固定常数，边际方差未知。我们通过任意按时间顺序、单遍、顺序交互的纯 $\alpha$-局部差分隐私信道，观测长度为 $n$ 的轨迹。对于滞后 $h$ 的自协方差估计，我们证明：对全部 $n\geq1$、$h\geq1$ 和 $\alpha>0$，极小极大均方误差统一为 $1\wedge[(n-h)_+(\alpha\wedge1)^4]^{-1}$ 的量级；当 $n\leq h$ 时，该表达式定义为 $1$。一个非交互双比特机制即可达到这一量级。下界适用于全部允许依赖历史的自适应信道，包括标准 Borel 输出空间与独立公开随机数。其主要工具是一个弱依赖隐马尔可夫族的统一信息界，该族具有不随参数变化的不变分布。有界的私有似然同时控制后验密度及其参数导数，使条件得分中出现两个隐私因子。上界则通过偶函数的高斯混沌论证，仅在谱盒条件下成立。本结果确定的是极小极大风险的量级，不涉及精确常数，也不涵盖允许反复访问同一观测的全交互协议。

**状态。** 这是一份未经外部同行评审的研究稿。本版本不含 Lean 证明，也不声称通过了内核验证。

# 1. 模型、结果与贡献

记 $\gamma(k)=\mathbb E[X_0X_k]$，并采用如下谱规范：
$$
\gamma(k)=\frac1{2\pi}\int_{-\pi}^{\pi}e^{ik\omega}w(\omega)\,d\omega,
\qquad w=2\pi f.
\tag{1.1}
$$
令 $\mathcal G(m,M)$ 表示所有具有谱密度且几乎处处满足 $m\leq w\leq M$ 的实值、均值为零的平稳高斯过程分布。它们的方差 $v=\gamma(0)$ 未知，且属于 $[m,M]$。这里不假设自协方差绝对可和，不要求 $f$ 可微，也不施加 Sobolev 约束。

在时刻 $i$，协议在一个标准 Borel 空间中发布 $Z_i$，所用的马尔可夫核为
$$
Q_i(dz_i\mid X_i,z_{<i},u).
\tag{1.2}
$$
其中，$U$ 是与过程独立的公开随机数。给定原始轨迹与 $U$ 后，全部私有输出记录的分布由这些核的顺序乘积给出。各核可以依赖 $n,h,\alpha,m,M$，但不得依赖未知的过程分布。对每个固定历史、公开随机种子、原始输入 $x,x'$ 以及可测集合 $A$，均要求
$$
Q_i(A\mid x,z_{<i},u)\leq e^\alpha Q_i(A\mid x',z_{<i},u).
\tag{1.3}
$$
这一模型允许向量值消息、任意历史依赖和独立的本地随机化。但后续核不得查看其他原始坐标、重新访问较早的观测，也不得使用乘积核模型以外的隐藏共享随机数。本文所说的隐私均指条件 (1.3)。

在平方损失下，定义
$$
R_{\mathrm{SI}}(n,h,\alpha;m,M)
=\inf_{Q,\widehat\gamma}\sup_{P\in\mathcal G(m,M)}
\mathbb E_{P,Q}(\widehat\gamma(Z_{1:n},U)-\gamma_P(h))^2.
\tag{1.4}
$$
估计器可以随机化；其独立随机数可并入 $U$。将下确界限制在非交互协议上所得的相应风险记为 $R_{\mathrm{NI}}$。令
$$
N=(n-h)_+,\qquad a=\alpha\wedge1,\qquad
\Psi(N,\alpha)=
\begin{cases}1,&N=0,\\ \min\{1,(Na^4)^{-1}\},&N>0.\end{cases}
\tag{1.5}
$$

**定理 1（统一极小极大定律）。** 对每组固定常数 $0<m<1<M<\infty$，存在 $0<c_{m,M}\leq C_{m,M}<\infty$，使得对所有 $n\geq1$、$h\geq1$ 和 $\alpha>0$ 同时成立
$$
c_{m,M}\Psi(N,\alpha)
\leq R_{\mathrm{SI}}(n,h,\alpha;m,M)
\leq R_{\mathrm{NI}}(n,h,\alpha;m,M)
\leq C_{m,M}\Psi(N,\alpha).
\tag{1.6}
$$
第 5 节的显式双比特估计器达到该上界。特别地，对于这一参数类上的标量目标，允许按时间顺序进行顺序交互，并不改变极小极大风险的量级。

式 (1.6) 中的常数不依赖滞后。因此，该结论也覆盖接近 $n$ 的增长滞后 $h=h_n$、趋于零的隐私参数，以及没有观测到任何滞后 $h$ 配对的情形。它并不意味着每个交互机制都不如每个非交互机制，也不意味着二者的精确最优风险相等。

## 1.1. 与已有工作的关系

Butucea、Klockmann 和 Krivobokova [BKK26] 研究了高斯时间序列估计的顺序交互机制，并证明非交互协方差估计具有四次隐私代价的下界。他们的协方差上界包含对数损失，并带有样本量充分大的条件。Issartel 和 Roueff [IR26] 消除了这些损失，得到了匹配的非交互界；他们使用私有尺度统计量和符号统计量，并明确将尖锐交互速率留作开放问题。式 (1.6) 中精确的谱盒与全滞后表述，是我们对这一开放方向作出的有限范围限定，并不是两篇论文中逐字提出的猜想。

对于包含两个坐标的信息，四次隐私损失也已出现在分坐标局部隐私中：Amorino 和 Gloter [AG25] 证明了乘积形式的隐私收缩，并允许在独立向量样本之间交互。他们的独立性条件及向量内部的信道结构，并不覆盖依赖轨迹上的全部核 (1.2)。一般的私有 Fisher 信息不等式同样是已有工具 [BCO20]。强噪声下马尔可夫滤波分布在其不变分布附近集中，是经典结果 [C06]；本文在滤波方面的贡献，涉及任意自适应私有似然下的参数导数和统一有限样本信息界。

本文主张的贡献，是针对完整协议类 (1.2) 的统一下界；证明结合了第 2 节的自适应滤波论证与一个依赖滞后的自回归子族。符号反演、阈值统计量、随机响应、信息链式法则和贝叶斯 Cramér–Rao 论证均作为已有组成部分归属。谱盒上界需要使用偶函数协方差界，因为谱盒只给出平方可和性，而 [IR26] 相关上界证明所用的是绝对可和性。本文不主张完整谱密度估计的极小极大定理，也不主张任意重复访问式交互的定理。

# 2. 自适应私有滤波的信息界

我们先给出一个不依赖高斯性的结果。本节所有 $L^2$ 空间均取实数值。密度转移算子 $T_\theta$ 将某一状态相对于概率测度 $\nu$ 的密度，映为下一状态相对于 $\nu$ 的密度。因此，$T_\theta$ 是正算子，保持积分；当 $\nu$ 为不变分布时，$T_\theta1=1$。记 $L^2_0(\nu)=\{b:\int b\,d\nu=0\}$。

**定理 2（自适应滤波信息界）。** 令标量参数 $\theta$ 取值于区间 $J$。一个标准 Borel 状态空间上的马尔可夫族具有共同不变概率测度 $\nu$，其密度转移算子在 $J$ 的一个邻域内按算子范数连续可微。假设存在 $L\geq0$，使得在 $J$ 上一致满足
$$
\|T_\theta\|_{L^2_0\to L^2_0}\leq\kappa\leq1/256,
\qquad
\|T'_\theta\|_{L^2_0\to L^2_0}\leq L.
\tag{2.1}
$$
观测该链任意有限个相互独立的副本，每个副本都从 $\nu$ 出发。观测按各链连续相继状态的一种固定交织顺序进行，保持每条链内部的次序，并且每个被访问的状态只观测一次。使用任意满足 (1.3) 的顺序核，除当前状态以外不访问其他原始输入。令 $N$ 为那些在所属链的首次观测之后发生的观测次数。对 $0<\alpha\leq1$，包括独立公开随机数在内的整个输出记录的 Fisher 信息满足
$$
I_\theta(Z,U)\leq8192L^2N\alpha^4
\quad\text{对每个 }\theta\in J.
\tag{2.2}
$$
该界允许所有链的消息影响每个后续信道，不假设后验为高斯分布，也不假设信道非自适应。

## 2.1. 任意输出空间上的共同似然

固定公开随机种子。对每个历史 $z_{<i}$，采用不依赖参数的概率核
$$
\mu_i(dz\mid z_{<i})=\int Q_i(dz\mid x,z_{<i})\,\nu(dx).
\tag{2.3}
$$
对 LDP 不等式中的 $x'$ 积分，得到测度之间的关系
$e^{-\alpha}\mu_i\leq Q_i(\cdot\mid x,z_{<i})\leq e^\alpha\mu_i$。
因此，可以选取联合可测的似然
$$
g_i(x;z_{\leq i})=\frac{dQ_i(\cdot\mid x,z_{<i})}{d\mu_i(\cdot\mid z_{<i})}(z_i)
\tag{2.4}
$$
使得对 $\mu_i$-几乎所有 $z_i$，都有
$$
e^{-\alpha}\leq g_i\leq e^\alpha\quad\nu\text{-几乎处处},
\qquad \int g_i\,d\nu=1.
\tag{2.5}
$$
为完整起见，取一列逐次加细的有限可测分割，生成标准 Borel 输出空间的 $\sigma$-代数。在每个分割上使用分割单元比值 $Q_i(A\mid x,z_{<i})/\mu_i(A\mid z_{<i})$，在分母为零的单元上令该比值为 $1$。这些比值满足 (2.5) 的有界性；对乘积测度 $\nu(dx)\mu_i(dz\mid z_{<i})$ 应用鞅收敛定理，它们收敛到一个可测极限，该极限就是 (2.4) 的一个版本。对 $x$ 积分便得到 (2.5) 中的归一化。在可测的异常输出集合上，将整个函数替换为 $1$。这一构造不依赖参数。预测分布都具有相对于 $\nu$ 的密度，因此，对任意 $\theta$，该修改都不会删去一个正概率事件。

令 $\mu$ 为 (2.3) 的顺序乘积。它是整个输出记录的一个不依赖参数的参考测度。构造这一参考测度，并不意味着真实消息相互独立。

## 2.2. 在每个已观测前缀处的分解

对每个固定参数 $\theta$ 和输出前缀 $z_{1:i}$，已访问隐路径相对于其未观测马尔可夫分布的似然为
$\prod_{j\leq i}g_j(x_j;z_{\leq j})$。
这些因子中的历史都是固定值。不同链的先验是乘积，而每个因子只涉及一条链的原始状态。将因子按链分组并归一化，便证明在这一前缀条件下，各链的隐路径条件分布按链分解。

因此，一条涉及其他链的消息，在固定已观测前缀后不会改变当前链的后验。它仍然可以改变为后续消息选取的信道，这一影响完整保留在未来的 $g_j$ 中。这个按前缀条件化的论证不可省略：仅凭各链无条件独立，无法证明在自适应消息下仍可如此滤波。

对一条给定链，令 $u$ 为当前观测发生前的预测密度，$f$ 为观测发生后的后验密度。精确递推为
$$
b=\langle g,u\rangle_\nu,\qquad f=gu/b,
\qquad u_{\mathrm{next}}=T_\theta f.
\tag{2.6}
$$
首次预测密度为 $u=1$。已发布消息相对于 $\mu_i$ 的条件密度为 $b$。特别地，$e^{-\alpha}\leq b\leq e^\alpha$。

## 2.3. 滤波器及其导数的逐路径界

记 $E=e^\alpha$、$\delta=E-1$。当 $\alpha\leq1$ 时，使用 $E<3$、$\delta<2$ 及 $\delta\leq2\alpha$。令 $P_0$ 为到 $L^2_0(\nu)$ 的正交投影。由于 $b=\int gu\,d\nu$，
$$
f-1=b^{-1}P_0(gu),\qquad
\|f-1\|_2\leq E\delta+E^2\|u-1\|_2.
\tag{2.7}
$$
事实上，写成 $gu=1+(g-1)+g(u-1)$，再使用投影的范数为一即可。预测步骤给出 $\|u_{\mathrm{next}}-1\|_2\leq\kappa\|f-1\|_2$。沿每条链的观测次数归纳，得到
$$
\|f-1\|_2\leq V:=\frac{E\delta}{1-\kappa E^2}<4\delta.
\tag{2.8}
$$
这是对每一条输出记录均成立的统一界。

在固定输出前缀处对参数求导。似然函数 $g$ 和参考核都不依赖 $\theta$。用上方一点表示该导数。由 (2.6)，
$$
\dot f=\frac{g\dot u-f\langle g,\dot u\rangle}{b},
\qquad \int\dot u\,d\nu=\int\dot f\,d\nu=0.
\tag{2.9}
$$
利用 $\langle g,\dot u\rangle=\langle g-1,\dot u\rangle$ 以及 $\|f\|_2\leq1+V$，有
$$
\|\dot f\|_2
\leq\{E^2+E\delta(1+V)\}\|\dot u\|_2
\leq63\|\dot u\|_2.
\tag{2.10}
$$
常数来自 $E<3$、$\delta<2$ 和 $V<8$。因为 $T'_\theta1=0$，
$$
\dot u_{\mathrm{next}}=T'_\theta(f-1)+T_\theta\dot f.
\tag{2.11}
$$
从 $\dot u=0$ 出发再作一次归纳，得到
$$
\|\dot u\|_2\leq W:=\frac{LV}{1-63\kappa}\leq6L\delta.
\tag{2.12}
$$
这里不会出现策略决策的导数：统计似然是在固定已观测历史处求导，而策略本身不依赖参数。

## 2.4. 条件得分与信息

在非首次观测处，条件得分为
$$
s_i=\partial_\theta\log b_i
=\frac{\langle g_i-1,\dot u_i\rangle}{b_i},
\qquad |s_i|\leq E\delta W\leq72L\alpha^2.
\tag{2.13}
$$
一条链首次观测的条件得分为零。每个条件密度积分为一，所以 $\mathbb E_\theta[s_i\mid Z_{<i},U]=0$。总得分为 $S_\theta=\sum_i s_i$。由鞅差的正交性，
$$
I_\theta=\mathbb E_\theta S_\theta^2
=\sum_i\mathbb E_\theta s_i^2
\leq5184L^2N\alpha^4\leq8192L^2N\alpha^4.
\tag{2.14}
$$
先对独立公开随机种子条件化，再取平均，即得 (2.2)。

这里的得分恒等式针对具有共同支配测度的实际统计试验成立，并非形式上的求导。对任意有限的输出长度，式 (2.6) 都是有界乘法、连续线性算子以及除以 $b\geq e^{-\alpha}$ 的有限次复合，故在 $L^2$ 中连续可微。输出密度 $p_\theta=\prod_i b_i$ 相对于 $\mu$ 介于 $e^{-n\alpha}$ 与 $e^{n\alpha}$ 之间；由 (2.13)，其导数在 $J$ 上一致有界。利用这些支配界交换微分与积分，可证明归一化恒等式，并证明 $\sqrt{p_\theta}$ 在 $L^2(\mu)$ 中可微。上述界也都不依赖随机种子。这提供了后文使用的全部正则性，完成定理 2 的证明。

**推论 3（有限参数间的收缩）。** 在定理 2 的条件下，对 $\theta,\eta\in J$，若两者之间的区间包含于 $J$，则采用规范 $H^2(P,Q)=\int(\sqrt p-\sqrt q)^2$ 的平方 Hellinger 距离满足
$$
H^2(P_\theta^{Z,U},P_\eta^{Z,U})
\leq2048L^2N\alpha^4(\theta-\eta)^2.
\tag{2.15}
$$
事实上，沿参数区间积分 $\partial_t\sqrt{p_t}=\tfrac12\sqrt{p_t}S_t$，再应用 Cauchy–Schwarz 不等式及 (2.2) 即可。因此，该结果控制的是整个参数区间，而不只是独立点处的信息。

**例 4（一个非高斯实例）。** 在 $\{-1,1\}$ 上取均匀不变分布，转移核 $K_\theta(y\mid x)=(1+\theta xy)/2$ 满足 $T_\theta(x\mapsto x)=\theta(x\mapsto x)$。因此，在 $[-1/256,1/256]$ 上，条件 (2.1) 以 $L=1$ 成立。定理 2 和推论 3 适用于该二元马尔可夫链，也适用于其独立副本的任意固定交织。这只是一般引理的一个实例，并非关于全部非高斯时间序列的主张。

# 3. 转移次数恰好匹配的高斯子族

选择
$$
r=\min\left\{\frac1{256},\frac{1-m}{2(1+m)},\frac{M-1}{2(M+1)}\right\}>0.
\tag{3.1}
$$
对每个 $\theta\in[-r,r]$，取平稳解
$$
X_t=\theta X_{t-h}+\sqrt{1-\theta^2}\,\varepsilon_t,
\qquad t\in\mathbb Z,
\tag{3.2}
$$
其中 $\varepsilon_t$ 为独立标准正态随机变量。可以用 $L^2$ 收敛级数 $X_t=\sqrt{1-\theta^2}\sum_{j\geq0}\theta^j\varepsilon_{t-jh}$ 构造该解。模 $h$ 的各剩余类构成相互独立的平稳 AR(1) 链。其协方差与谱密度为
$$
\gamma_\theta(k)=
\begin{cases}\theta^{|k|/h},&h\mid k,\\0,&h\nmid k,
\end{cases}
\qquad
w_\theta(\omega)=\frac{1-\theta^2}{1-2\theta\cos(h\omega)+\theta^2}.
\tag{3.3}
$$
特别地，$v=1$ 且 $\gamma_\theta(h)=\theta$。利用
$$
\frac{1-|\theta|}{1+|\theta|}\leq w_\theta\leq
\frac{1+|\theta|}{1-|\theta|}
\tag{3.4}
$$
与 (3.1)，可知对每个 $h$，该过程都属于 $\mathcal G(m,M)$。在 $X_1,\ldots,X_n$ 中，恰有 $N=(n-h)_+$ 次观测发生在所属链已经观测过一个较早状态之后。

## 3.1. 高斯转移算子

令 $\nu$ 为标准正态分布，$T_\theta$ 为 $Y=\theta X+\sqrt{1-\theta^2}\varepsilon$ 的密度转移算子。由可逆性，它也等于条件期望算子。对归一化 Hermite 多项式 $H_k$，生成函数恒等式
$$
\mathbb E[e^{tY-t^2/2}\mid X=x]
=e^{\theta tx-(\theta t)^2/2}
\tag{3.5}
$$
给出 $T_\theta H_k=\theta^kH_k$。Hermite 多项式构成 $L^2(\nu)$ 的标准正交基：将生成函数相乘再积分，可得正交性；对一个与所有多项式正交的函数应用同一生成函数，再利用其高斯加权 Fourier 变换的唯一性，可得稠密性。上述积分都可通过 Cauchy–Schwarz 不等式与高斯指数矩加以正当化。

因此，在零均值空间上，
$$
\|T_\theta\|\leq|\theta|,\qquad
\|T'_\theta\|=\sup_{k\geq1}k|\theta|^{k-1}\leq1
\quad (|\theta|\leq1/2).
\tag{3.6}
$$
最后一个不等式使用 $k/2^{k-1}\leq1$。这个对角级数还证明了：在 $(-1,1)$ 的每个紧子区间上，算子按算子范数连续可微；因为对 $q<1$，有 $kq^{k-1}\to0$，所以导数的尾部一致收敛。当 $\alpha\leq1$ 时，定理 2 因而给出 $I_\theta(Z,U)\leq8192N\alpha^4$。

对 $\alpha\geq1$，改用未私有化样本的信息。初始状态不依赖参数。对一次转移，记 $\sigma^2=1-\theta^2$、$Y=\theta X+\sigma\varepsilon$。其得分为
$$
\frac{X\varepsilon}{\sigma}
+\frac{\theta(1-\varepsilon^2)}{\sigma^2},
\quad\text{方差为}\quad
\frac{1+\theta^2}{(1-\theta^2)^2}\leq2.
\tag{3.7}
$$
各转移得分构成鞅差，所以原始样本的信息至多为 $2N$。经过一个不依赖参数的输出核后，得分成为原始得分在给定 $(Z,U)$ 下的条件期望。由条件 Jensen 不等式，输出信息不超过原始信息。合并两个隐私参数区域，得到
$$
I_\theta(Z,U)\leq8192N(\alpha\wedge1)^4,
\qquad -r\leq\theta\leq r.
\tag{3.8}
$$
该界对未知参数、协议、滞后、长度和公开随机化均一致成立。

# 4. 从信息界到极小极大风险

采用先验密度
$$
q(\theta)=\frac1r\cos^2\left(\frac{\pi\theta}{2r}\right)
\boldsymbol1_{[-r,r]}(\theta),
\qquad
\int\frac{q'(\theta)^2}{q(\theta)}\,d\theta=\frac{\pi^2}{r^2}.
\tag{4.1}
$$
该密度积分为一，且在两个端点均为零。我们重述贝叶斯 Cramér–Rao 的简短证明，以明确所用假设。将任意估计器截断到 $[-M,M]$，不会增大本问题中的平方误差。对联合密度 $p_\theta(z)q(\theta)$ 分部积分，得到
$$
\mathbb E[(\widehat\gamma-\theta)
\{S_\theta+q'(\theta)/q(\theta)\}]=1.
\tag{4.2}
$$
由 (4.1)，边界项为零。得分的条件均值为零，所以它与 $q'/q$ 的交叉项也为零。Cauchy–Schwarz 不等式给出
$$
\sup_{P\in\mathcal G(m,M)}\mathbb E(\widehat\gamma-\gamma_P(h))^2
\geq\frac1{8192N(\alpha\wedge1)^4+\pi^2/r^2}.
\tag{4.3}
$$
对 $\alpha\leq1$，正则性已在第 2.4 节给出。对 $\alpha\geq1$，有限维高斯试验 (3.2) 在这个紧参数区间上具有一致可积的密度导数：其协方差特征值一致远离零与无穷，得分是具有一致有界高斯矩的二次多项式。不依赖参数的核保持全变差意义下的可微性；第 3 节的条件得分论证则给出平方可积性。这些事实也为该参数区域中的 (4.2) 提供了正当性。它们也可以统一用于两个区域。

对所有协议和估计器取下确界，就证明了定理 1 的下界部分。例如，可以取
$$
c_{m,M}=(8192+\pi^2/r^2)^{-1}.
\tag{4.4}
$$
事实上，若 $Na^4\leq1$，式 (4.3) 的分母至多为 $8192+\pi^2/r^2$；若 $Na^4\geq1$，则分母至多为 $(8192+\pi^2/r^2)Na^4$。

当 $n\leq h$ 时，式 (3.2) 中全部已观测状态都属于不同的链；对每个 $\theta$，原始样本均为 $n$ 个独立标准正态变量。即使没有隐私限制，这些样本也不包含关于 $\gamma(h)=\theta$ 的信息。两个备择 $\theta=\pm r$ 给出至少为 $r^2$ 的风险，这与 (4.3) 及饱和区域的约定一致。在下界中使用单位方差子族，并不意味着上界问题假设方差已知。

# 5. 未知方差下的匹配非交互估计器

本节在整个谱盒上给出一个完全明确的估计器。令 $Y_i=X_i/\sqrt v$、$\rho_k=\gamma(k)/v$。Parseval 恒等式与谱界给出
$$
\sum_{k\in\mathbb Z}\rho_k^2
=\frac1{2\pi v^2}\int w^2
\leq\frac Mv,
\qquad v-|\gamma(h)|\geq m\quad(h\geq1).
\tag{5.1}
$$
第一个不等式使用 $w^2\leq Mw$。第二个不等式来自对 $\operatorname{Var}(X_0\pm X_h)=2(v\pm\gamma(h))$ 应用谱下界。特别地，每个标准化双坐标边际分布的协方差特征值都不小于 $m/v$。

## 5.1. 偶高斯函数

**引理 5（偶高斯块协方差）。** 设 $A,B$ 是联合均值为零的高斯向量，其各自的协方差矩阵 $\Sigma_A,\Sigma_B$ 均为正定。记 $R=\Sigma_A^{-1/2}\operatorname{Cov}(A,B)\Sigma_B^{-1/2}$。若 $F(A)$、$G(B)$ 平方可积，并分别在变换 $A\mapsto-A$、$B\mapsto-B$ 下保持不变，则
$$
|\operatorname{Cov}(F(A),G(B))|
\leq\|R\|_{\mathrm{op}}^2
\sqrt{\operatorname{Var}F(A)\operatorname{Var}G(B)}.
\tag{5.2}
$$
证明如下。将两个边际分别白化，并对它们的互协方差作奇异值分解。正交变换保持高斯分布及奇偶性。在乘积 Hermite 基下，条件期望在总次数为 $d$ 的分量上的算子范数至多为 $\|R\|_{\mathrm{op}}^d$。这可由对每个配对坐标应用 (3.5) 得到；未配对坐标的相关系数为零。中心化偶函数没有零次或一次分量，事实上只有偶数次分量。由于 $\|R\|_{\mathrm{op}}\leq1$，在这些函数所在子空间上的范数至多为 $\|R\|_{\mathrm{op}}^2$。对正交混沌展开应用 Cauchy–Schwarz 不等式即可。奇异值等于一也不构成问题：条件 Hermite 恒等式仍然成立，或者可通过高斯扰动与 $L^2$ 收敛得到。因此，不需要联合向量的协方差非奇异。

在一维情形，该引理对任意偶函数 $F$ 给出 $|\operatorname{Cov}(F(Y_0),F(Y_k))|\leq\rho_k^2\operatorname{Var}F(Y_0)$。对于符号乘积 $D_i=\operatorname{sign}(X_i)\operatorname{sign}(X_{i+h})$，将引理应用于两个块 $(Y_i,Y_{i+h})$ 与 $(Y_j,Y_{j+h})$。记 $k=j-i$，由 (5.1) 得到
$$
|\operatorname{Cov}(D_i,D_j)|
\leq(v/m)^2\{2\rho_k^2+\rho_{k+h}^2+\rho_{k-h}^2\}.
\tag{5.3}
$$
这里，每个符号乘积的方差至多为一，互协方差矩阵具有式中列出的四个元素；白化后，其算子范数可由 Frobenius 范数控制。对所有 $k\in\mathbb Z$ 将右端求和，至多为
$$
4(v/m)^2(M/v)=4Mv/m^2\leq4(M/m)^2.
\tag{5.4}
$$

## 5.2. 每次观测发布两个私有比特

令 $s_i=\operatorname{sign}(X_i)$，零点处任选约定，并令 $b_i=2\boldsymbol1_{\{|X_i|\geq1\}}-1$。分别独立地随机化这两个比特：以概率 $e^{\alpha/2}/(1+e^{\alpha/2})$ 保留原值，否则翻转。将结果记为 $S_i,B_i\in\{-1,1\}$，并令
$$
\lambda=\tanh(\alpha/4),\qquad
\mathbb E[S_i\mid X_i]=\lambda s_i,
\quad\mathbb E[B_i\mid X_i]=\lambda b_i.
\tag{5.5}
$$
给定原始样本后，这些随机化硬币全部条件独立。每个比特满足 $\alpha/2$-LDP，因此由概率相乘，输出对 $(S_i,B_i)$ 满足 $\alpha$-LDP。这是 (1.2) 的一个非交互实例。对所有 $\alpha>0$，
$$
\lambda\geq(\alpha\wedge1)/8.
\tag{5.6}
$$
对 $\alpha\leq1$，使用 $[0,1/4]$ 上的 $\tanh t\geq t/2$，因为在该区间上 $\tanh$ 的导数减去 $1/2$ 为正；对 $\alpha\geq1$，使用单调性。

## 5.3. 方差估计

令 $\Phi,\phi$ 分别为标准正态分布函数与密度，并定义
$$
p(v)=2\Phi(-v^{-1/2}),\qquad
d=\phi(m^{-1/2})M^{-3/2}>0.
\tag{5.7}
$$
在 $[m,M]$ 上，$p'(v)=\phi(v^{-1/2})v^{-3/2}\geq d$。定义
$$
\widetilde p=\frac12\left(1+\frac1{n\lambda}\sum_{i=1}^n B_i\right),
\quad \widehat p=\operatorname{clip}_{[p(m),p(M)]}(\widetilde p),
\quad \widehat v=p^{-1}(\widehat p).
\tag{5.8}
$$
未投影的估计器无偏。由引理 5，对不同指标有 $|\operatorname{Cov}(b_i,b_j)|\leq\rho_{j-i}^2$，且 $\operatorname{Cov}(B_i,B_j)=\lambda^2\operatorname{Cov}(b_i,b_j)$。对角项的方差至多为一。因此
$$
\operatorname{Var}(\widetilde p)
\leq\frac1{4n}\left\{\lambda^{-2}+\sum_{k\neq0}\rho_k^2\right\}
\leq\frac{M/m}{4n\lambda^2}.
\tag{5.9}
$$
最后一步使用 $\sum_{k\neq0}\rho_k^2\leq M/v-1$ 及 $\lambda\leq1$。投影不会增大到 $p(v)$ 的距离，逆函数是 $d^{-1}$-Lipschitz 的。故
$$
\mathbb E(\widehat v-v)^2\leq\frac{M/m}{4d^2n\lambda^2},
\qquad m\leq\widehat v\leq M.
\tag{5.10}
$$

## 5.4. 相关系数估计

设 $N=n-h>0$。高斯反正弦恒等式为
$$
\mathbb E D_i=\frac2\pi\arcsin\rho_h.
\tag{5.11}
$$
一种推导方式是：将标准化高斯对表示为具有旋转对称性的二维标准正态向量在两个单位向量上的投影，这两个单位向量的夹角为 $\arccos\rho_h$。两个投影符号相反的楔形区域占总角度的比例为 $\arccos\rho_h/\pi$，由此得到 (5.11)。非退化性由 (5.1) 保证。

令
$$
T=\frac1{N\lambda^2}\sum_{i=1}^N S_iS_{i+h},
\qquad
\widehat\rho=\sin\left(\frac\pi2\operatorname{clip}_{[-1,1]}T\right).
\tag{5.12}
$$
$T$ 的均值就是 (5.11)。对于不重叠的指标对，由随机化硬币的条件独立性，
$\operatorname{Cov}(S_iS_{i+h},S_jS_{j+h})=\lambda^4\operatorname{Cov}(D_i,D_j)$。
指标对只会在 $j-i\in\{0,h,-h\}$ 时重叠。这样的有序对至多有 $3N$ 个，每个协方差的绝对值都至多为一。因此，由 (5.3)–(5.4)，
$$
\operatorname{Var}(T)
\leq\frac3{N\lambda^4}+\frac{4(M/m)^2}{N}.
\tag{5.13}
$$
投影不会增大距离，而 (5.12) 中的正弦映射是 $\pi/2$-Lipschitz 的。因此
$$
\mathbb E(\widehat\rho-\rho_h)^2
\leq\frac{\pi^2}4\left\{\frac3{N\lambda^4}+\frac{4(M/m)^2}{N}\right\}.
\tag{5.14}
$$

## 5.5. 合并估计并覆盖全部参数区域

当 $N>0$ 时，定义 $\widehat\gamma=\widehat v\widehat\rho$；当 $N=0$ 时，定义 $\widehat\gamma=0$。由于 $|\rho_h|\leq1$ 且 $\widehat v\leq M$，
$$
|\widehat v\widehat\rho-v\rho_h|^2
\leq2M^2|\widehat\rho-\rho_h|^2+2|\widehat v-v|^2.
\tag{5.15}
$$
这个确定性不等式不要求两个估计量独立。记
$$
A_{m,M}=\frac{\pi^2M^2}2\{3+4(M/m)^2\}
+\frac{M/m}{2d^2}.
\tag{5.16}
$$
当 $N>0$ 时，使用 $n\geq N$、$\lambda\leq1$ 及 (5.6)，由 (5.10) 和 (5.14) 得到风险至多为 $4096A_{m,M}/(Na^4)$。另外，$|\widehat\gamma|\leq M$ 且 $|\gamma(h)|\leq M$，所以风险至多为 $4M^2$。当 $N=0$ 时，零估计器的风险至多为 $M^2$。例如，取
$$
C_{m,M}=\max\{4M^2,4096A_{m,M}\}.
\tag{5.17}
$$
由此得到 (1.6) 的上界部分。这些常数有意取保守值；定理 1 关注量级，而非尖锐的首项常数。证明完成。

# 6. 解释、已有界与结论边界

当 $Na^4$ 较大时，要将一个滞后协方差的均方误差控制在 $\varepsilon^2$ 的量级，需要有效配对数 $N$ 达到 $a^{-4}\varepsilon^{-2}$ 的量级，其中常数依赖参数类。两个隐私因子之所以出现，是因为参数改变的是依赖关系，而最难子族的边际分布保持不变。在弱依赖族中，过去的私有观测对滤波密度的扰动只能达到 $\alpha$ 的量级；将其参数导数与当前私有似然配对，又贡献一个 $\alpha$ 因子。条件得分平方后便得到 $\alpha^4$。

下界使用弱依赖过程，是因为极小极大风险可以由一个难子族控制。这并不意味着每个具体谱、或强相关的参数子模型都具有相同难度。相比之下，上界覆盖整个固定谱盒。若 $h\geq n$，参数类中包含观测分布相同但目标协方差不同的过程，所以常数量级风险区域是问题本身固有的。

## 6.1. 与 BKK 交互上界的相容性

[BKK26，JMLR 定理 3 与附录 A.3；arXiv v3 第 2.2 节] 的协方差结果对充分大的 $n$ 给出一个包含 $\log^{4+4\delta}n/(n\alpha^2)$ 的上界。其截断证明包含指数为 $-4\alpha\log^{1+\delta}n$ 的尾部项。当隐私参数随样本量变化时，需要谨慎理解这个大样本条件的统一性。

下面给出一个充分条件计算，并不对其估计器的最优性能作出新的断言。对于 $0<\alpha\leq1$，相应的并集界可由
$e^{\alpha/4}n\exp[-4\alpha\log^{1+\delta}n]$
控制。条件 $\alpha\log^\delta n\geq2$ 使其成为 $O(n^{-3})$；高斯截断步骤还有一个仅依赖固定参数类的阈值。在这一充分条件覆盖的区域内，他们展示的对数项与 $(n\alpha^4)^{-1}$ 的比值满足
$$
\alpha^2\log^{4+4\delta}n\geq4\log^{4+2\delta}n.
\tag{6.1}
$$
因此，该上界与我们的下界相容。对固定 $\alpha$，这一阈值最终会满足；但在诸如 $\alpha_n=n^{-b}$、$b>0$ 的联合极限中，它未必满足。这一计算不是其算法的必要条件，不宣称其固定 $\alpha$ 的定理错误，也不裁定他们另外提出的完整谱密度结论。它解释了为什么不能同时略去对数因子和依赖参数的阈值，再据此否定本文证明的统一标量定理。

## 6.2. 结果及其验证的范围

本定理假设均值已知为零、数据为高斯、存在固定的严格正谱下界，并且每个坐标按时间顺序只发布一次。近似隐私、非时间顺序的自适应排序、重复访问、(1.2) 之外的隐藏相关随机化、非高斯完整模型的极小极大速率、逐点谱估计，以及完整谱密度估计，均不在本结果范围内。一般滤波引理具有其自身明确的弱收缩和共同不变分布假设；这些假设已对用于下界的高斯族证明成立，并未施加到上界所覆盖的整个参数类。

书面证明包含任意标准 Borel 消息和 (1.5) 中的全部参数边界。配套有限计算用于检查常数和说明性小模型，不能替代本证明。本版本未附计算文件。原创性主张限于截至 2026 年 11 月 25 日实际核对过的原始文献。全文尚未完成 Lean 形式化。

# 参考文献

**[AG25]** Chiara Amorino and Arnaud Gloter. *Minimax rate for multivariate data under componentwise local differential privacy constraints*. Annals of Statistics 53(3), 2025. DOI: [10.1214/25-AOS2497](https://doi.org/10.1214/25-AOS2497)。核对的预印本为 [arXiv:2305.10416v3](https://arxiv.org/html/2305.10416v3)，2025 年 1 月 17 日，重点包括命题 3.7、推论 3.8 及独立抽样模型。

**[BCO20]** Leighton Pate Barnes, Wei-Ning Chen and Ayfer Özgür. *Fisher information under local differential privacy*. IEEE Journal on Selected Areas in Information Theory 1(3):645–659, 2020. DOI: [10.1109/JSAIT.2020.3039461](https://doi.org/10.1109/JSAIT.2020.3039461)。[arXiv:2005.10783](https://arxiv.org/abs/2005.10783)。本文引用该文用于方法归属；其任何定理陈述都不是本文下界中未经证明而直接使用的前提。

**[BKK26]** Cristina Butucea, Karolina Klockmann and Tatyana Krivobokova. *Nonparametric Spectral Density Estimation using Interactive Mechanisms under Local Differential Privacy*. Journal of Machine Learning Research 27(168):1–49, 2026。[期刊版本](https://www.jmlr.org/papers/v27/25-0680.html)；[PDF](https://www.jmlr.org/papers/volume27/25-0680/25-0680.pdf)。还核对了 [arXiv:2504.00919v3](https://arxiv.org/html/2504.00919v3)，2026 年 9 月 21 日。期刊 PDF 与 arXiv HTML 的编号有所不同。

**[C06]** Pavel Chigansky. *On filtering of Markov chains in strong noise*. IEEE Transactions on Information Theory 52(9):4267–4272, 2006。[arXiv:math/0508446v3](https://arxiv.org/abs/math/0508446v3)，2006 年 5 月 21 日。该文研究经典的有限状态强噪声滤波，本文将其作为方法背景引用；其中固定的观测信道不能推出定理 2。

**[IR26]** Yann Issartel and François Roueff. *On the privacy cost for dependent Gaussian data: spectral density estimation under local differential privacy*. [arXiv:2608.24847v1](https://arxiv.org/html/2608.24847v1)，2026 年 8 月 25 日。重点包括非交互模型、第 3.1 节的滞后 $h$ 自协方差、第 3.4 节的交互隐私，以及第 6 节的尺度与符号上界。
