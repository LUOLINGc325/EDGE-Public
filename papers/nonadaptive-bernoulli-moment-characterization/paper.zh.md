# 非自适应 Bernoulli 工厂的有限矩：精确的逼近判据

**中文完整说明稿，2026 年 11 月 25 日。** 本文与英文规范稿具有相同的结论、假设和适用范围，保留其定理及公式编号，并用中文展开证明。英文稿为规范稿。

本文给出书面数学结果，尚未经过外部同行评审，全文 Lean 形式化尚未完成。

## 摘要

考虑在观察任何输入硬币之前，先随机选择输入预算的 Bernoulli 工厂。预算既独立于未知输入偏置，也独立于整条输入序列。对任意正实数 $r$ 和连续函数 $f:[0,1]\to(0,1)$，我们证明：存在输入成本具有有限 $r$ 阶矩的精确工厂，当且仅当

$$
A_r(f):=\sum_{j=0}^{\infty}2^{2rj}E_{2^j}(f)<\infty,
$$

其中 $E_m$ 表示在整个闭区间上，用次数不超过 $m$ 的普通代数多项式进行最佳一致逼近的误差。当目标函数与零和一之间具有固定正余量时，最优正则化成本与 $1+A_r(f)$ 等价，比较常数仅依赖于矩阶和余量。充分性证明借助对次数一致的 Bernstein 逆算子估计，把带符号的逼近展开转化为每次只执行一个分支的概率混合。必要性适用于所有非自适应随机规则。局部化的稀疏 Chebyshev 级数给出了临界矩处精确的对数转变。此外，针对 Koskela、Karvonen、Łatuszyński 和 Spanò 原有的幂律截断估计量，我们在明确的系数序假设下，通过 Jensen 不等式证书和累积尾部 Abel 恒等式解决其有限方差问题，并对指定的 Holtz--Nazarov--Peres 系数族给出更强的保证。

**关键词：** 精确模拟；Bernoulli 工厂；非自适应输入复杂度；多项式逼近；矩的可求和性；无偏估计。

## 1. 模型、主定理及与已有工作的关系

### 1.1. 成本计量

输入是一列相互独立、共同参数为未知 $x\in[0,1]$ 的 Bernoulli 随机变量。规则首先抽取整数 $N\ge0$：其分布可以依赖已知目标函数 $f$，但必须独立于 $x$ 和整条输入序列。随后规则恰好读取 $N$ 枚输入硬币并输出一个比特。输出决策可以依赖输入次序以及辅助随机性。同一个规则必须对所有 $x$（包括两个端点）都以概率 $f(x)$ 输出一。

成本仅计入对未知参数输入硬币的调用。模型允许使用具有指定实数概率的独立精确辅助随机化。这是关于输入调用次数的存在性模型；要实现有效计算，还需要逼近数据和抽样概率的表示。第 3.6 节说明了如何在带有可验证误差界的数据下实现该构造，也列出了计算方面的限制。本文不声称对任意不可计算的连续函数都存在统一算法。

对 $m\ge0$，记 $\Pi_m$ 为次数至多为 $m$ 的实代数多项式空间，并定义

$$
E_m(f)=\inf_{P\in\Pi_m}\|f-P\|_{\infty,[0,1]},\qquad
\mathcal C_r(f)=\inf_{\text{admissible exact rules}}\mathbb E(1+N)^r.
\tag{M.1}
$$

空集上的下确界约定为 $+\infty$。正则化因子覆盖零输入情形。对每个 $r>0$，$\mathbb E(1+N)^r$ 有限与 $\mathbb EN^r$ 有限等价。

### 1.2. 精确刻画

**定理 M（所有正阶矩）。** 固定 $r>0$ 及连续函数 $f:[0,1]\to(0,1)$。存在满足 $\mathbb E(1+N)^r<\infty$ 的合法精确工厂，当且仅当 $A_r(f)<\infty$。更定量地说，对每个 $0<\varepsilon\le1/2$，存在正的有限常数 $c_r$ 和 $C_{r,\varepsilon}$，使得

$$
c_r\bigl(1+A_r(f)\bigr)
\le\mathcal C_r(f)
\le C_{r,\varepsilon}\bigl(1+A_r(f)\bigr)
\quad\text{whenever }\varepsilon\le f\le1-\varepsilon.
\tag{M.2}
$$

这些常数不依赖于 $f$。给定带有可验证误差界的多项式逼近数据，以及其加权误差和的有限上界，上界证明即给出构造。结论不排除任何矩阶，包括 $2r$ 为整数的情形。由紧性，每个属于定理所述函数类的目标都具有某个正的 $\varepsilon$ 余量。

这里的条件是可求和性判据，强于单纯的速率界 $E_m(f)=O(m^{-2r})$。第 4 节构造满足

$$
E_{2^j}(f)\asymp2^{-\alpha j}j^{-\beta},
$$

的函数，并证明临界矩 $r=\alpha/2$ 可实现恰好等价于 $\beta>1$。本文直接使用上述逼近范数表述结果；在没有另行证明端点等价定理的情况下，不把它等同于 $[0,1]$ 上普通的无权 Besov 空间。

### 1.3. 两个方向为何具有相同尺度

预算为 $n$ 的规则产生一个次数为 $n$、Bernstein 系数属于 $[0,1]$ 的多项式。这样的多项式能够在较小的次数尺度 $\sqrt n$ 上被逼近，对此作二进分层求和便得到必要性。反过来，一个次数为 $m$ 且一致范数有界的多项式，升阶到常数倍的 $m^2$ 次后，其 Bernstein 系数便得到一致控制。这两个次数尺度恰好匹配。再用一个正的基底吸收带符号的逼近增量，就得到合法的可数概率混合。

第 2、3 节分别独立证明两个方向。必要性下界还解释了为何改进某个特定构造，不能避开第 4 节的对数障碍。第 5 节研究另一个固定估计量，其输出矩与输入成本矩需要分别讨论。

### 1.4. 既有工作及本文贡献的准确边界

Holtz、Nazarov 和 Peres [HNP11，定理 8] 建立了非整数 Hölder 光滑性与自适应模拟尾速率的联系，并在第 7 节明确提出有限矩刻画问题。他们的成本约定还计入公平硬币。定理 M 处理的是上述受限的非自适应输入调用模型，并未解决完整的自适应问题。固定预算下的 Bernstein 表示已有先前工作 [GS12]。正 Bernstein 系数及其升阶也是经典内容，包括 [QRR11] 和 [DZ93] 中的逼近估计。本文不把这些工具宣称为新定理。

本文拟提出的主要新增结果，是在函数层面、对所有 $r$ 的完整等价刻画，连同定量的最优成本比较及明确的临界可求和性例子。第 5 节的另一项新增结果针对 [KKLŚ26，式 (7)] 中保持不变的原估计量。该论文已核对的最新版本为 arXiv:2510.01941v2，修订于 2026 年 9 月 1 日。我们证明有限方差保证时，不预先假设该文所讨论方差恒等式所需的平方可积性。新的估计量界保留了整数截断的原幂律分布。

文献核查还检查了公开源码档案 [TT]，其中包含尖点和临界矩的下界；这些单项障碍原理不属于本文所主张的新贡献。本轮无法访问 Keane--O'Brien 原论文的出版商全文，因此没有任何优先性主张以排除其未读内容为依据。文献比较限于实际核查过的来源和版本。

## 2. 整个非自适应类的必要性

### 2.1. 混合表示

给定 $N=n$，对所有恰有 $k$ 个正面的输入串，平均规则在该输入串上的条件输出概率。由此得到与 $x$ 无关的系数 $b_{n,k}\in[0,1]$，使得

$$
f(x)=\sum_{n=0}^{\infty}p_nQ_n(x),\qquad
Q_n(x)=\sum_{k=0}^{n}b_{n,k}\binom nkx^k(1-x)^{n-k},
\quad p_n=\Pr(N=n).
\tag{N.1}
$$

当 $p_n=0$ 时，可任取该组系数。由于 $0\le Q_n\le1$ 且 $\sum p_n=1$，级数一致收敛。在 $x=0,1$ 处，同一恒等式直接由规则在全零串或全一串上的条件决策得到。上述平均是在表示任意可能依赖次序的规则，并未对规则施加额外限制。反过来，每个表示式 (N.1) 都可实现为一个规则：先抽取 $n$，读取相应数量的输入，再按对应系数的概率输出。条件辅助随机种子可以依赖于 $n$，但仍须独立于输入序列。

### 2.2. Bernstein 原子的逼近

**引理 N1（一致的原子估计）。** 对每个整数 $K\ge1$，存在 $C_K<\infty$，使得对所有 $n\ge1$、$m\ge1$，以及满足 $|b_{n,k}|\le1$ 的 Bernstein 多项式 $Q_n$，都有

$$
E_m(Q_n)\le C_K\min\{1,(\sqrt n/m)^K\}.
\tag{N.2}
$$

**证明。** 令 $F(z)=Q_n((1+\cos z)/2)$。这是一个整函数，且为偶函数和 $2\pi$ 周期函数。对 $z=u+iv$，椭圆恒等式给出

$$
\left|\frac{1+\cos z}{2}\right|+
\left|\frac{1-\cos z}{2}\right|=\cosh v.
\tag{N.3}
$$

也可以直接通过半角平方验证：两项模分别为 $|\cos(z/2)|^2$ 和 $|\sin(z/2)|^2$。因此

$$
|F(u+iv)|\le(\cosh v)^n\le e^{nv^2/2}.
$$

最后一个不等式由对 $v\ge0$ 积分 $\tanh v\le v$，再利用对称性得到。以任意实点为圆心、$n^{-1/2}$ 为半径应用 Cauchy 公式，可得

$$
\|F^{(K)}\|_{\infty,\mathbb R}\le e^{1/2}K!n^{K/2}.
\tag{N.4}
$$

周期 Jackson 逼近给出一个次数至多为 $m$ 的三角多项式 $T_m$，满足

$$
\|F-T_m\|_\infty\le J_Km^{-K}\|F^{(K)}\|_\infty.
\tag{N.5}
$$

下面直接证明这里所需的版本。选择整数 $s$ 使 $2s>K+1$。当 $m\ge s$ 时，取 $M=\lfloor m/s\rfloor+1$，将

$$
J(t)\ \propto\ \left(\frac{\sin(Mt/2)}{\sin(t/2)}\right)^{2s},\qquad -\pi\le t\le\pi,
$$

归一化至积分为一。该核的次数为 $s(M-1)\le m$，归一化前的积分为 $M^{2s-1}$ 的常数倍量级。利用商的界 $\min(M,\pi/|t|)$，并在 $1/M$ 处分割积分，得到 $\int |t|^KJ(t)\,dt\le C_Km^{-K}$。以 $J(t)$ 为核对

$$
\sum_{a=1}^{K}(-1)^{a+1}\binom Ka F(u+at).
$$

积分。对于频率为 $\ell$ 的 Fourier 模式，出现的核系数对应频率 $a\ell$，所以所有 $|\ell|>m$ 的模式都消失。误差为 $F$ 的一个 $K$ 阶有限差分，其绝对值不超过 $|t|^K\|F^{(K)}\|_\infty$。这便证明了 $m\ge s$ 时的 (N.5)。若 $1\le m<s$，则取 $F$ 的常数均值。对任意周期可微函数 $G$，积分 $G(u)-G(v)$ 可得 $\|G-\operatorname{mean}G\|_\infty\le2\pi\|G'\|_\infty$。由于各阶导数的均值为零，迭代后得到 $\|F-\operatorname{mean}F\|_\infty\le(2\pi)^K\|F^{(K)}\|_\infty$。把 $J_K$ 增大一个仅依赖 $K$ 的倍数即可覆盖这一情形。

将 $T_m(u)$ 与 $T_m(-u)$ 平均并取实部，误差界保持成立，所得为实偶三角多项式。它可写成 $P_m((1+\cos u)/2)$，其中 $P_m\in\Pi_m$。角坐标映射覆盖整个区间，因此两种一致范数相等。结合 (N.4)--(N.5) 及 $E_m(Q_n)\le1$ 即得 (N.2)。当 $n=0$ 时，原子为常数，故 $E_m(Q_0)=0$。$\square$

该证明保留了区间端点。作为另一条经典文献路线，[HNP11，引理 17] 与 [DZ93，定理 3.3] 也可通过加权导数和 Jackson 逼近给出相同尺度。

### 2.3. 可求和性及普适下界

**引理 N2（原子的成本界）。** 对每个 $r>0$，存在 $D_r<\infty$，使得

$$
A_r(Q_n)\le D_r n^r\quad(n\ge1),\qquad A_r(Q_0)=0.
\tag{N.6}
$$

取整数 $K>2r$，并令 $J=\lfloor\log_2\sqrt n\rfloor$。对 $j\le J$，使用 $E_{2^j}(Q_n)\le1$，所得几何级数至多为 $n^r$ 的一个常数倍。对 $j>J$，引理 N1 将其和控制为

$$
C_K n^{K/2}\sum_{j>J}2^{(2r-K)j}\le D'_r n^r.
$$

引理得证，也包括 $n=1$ 的情形。

到 $\Pi_m$ 的距离具有次可加性、绝对齐次性，并且关于一致范数是 1-Lipschitz 的。先对 (N.1) 的有限部分混合使用这些性质，再令部分和一致收敛到极限。由尾界 $\sum_{n>M}p_n\to0$ 得

$$
E_m(f)\le\sum_{n=0}^{\infty}p_nE_m(Q_n).
$$

对非负二重级数应用 Tonelli 定理，再使用 (N.6)，得到

$$
A_r(f)\le D_r\mathbb EN^r.
\tag{N.7}
$$

因此 $1+A_r(f)\le(1+D_r)\mathcal C_r(f)$，证明了定理 M 的下界部分。这里没有交换下确界与无穷求和。论证适用于每一个合法随机规则，故 $A_r(f)$ 发散便构成整个模型中的不可实现障碍。

## 3. 充分性及定量构造

### 3.1. 结论与模型

记

$$
 E_m(f)=\inf_{P\in\Pi_m}\|f-P\|_{\infty,[0,1]},\qquad
 A_r(f)=\sum_{j=0}^{\infty}4^{rj}E_{2^j}(f),
$$

其中 $\Pi_m$ 表示次数至多为 $m$ 的实多项式。固定 $r>0$ 和 $0<\varepsilon\le 1/2$，假设

$$
 \varepsilon\le f(x)\le1-\varepsilon\qquad(0\le x\le1).
$$

**定理 S。** 若 $A_r(f)<\infty$，则存在一个精确 Bernoulli 工厂：它在观察任何输入硬币之前抽取输入预算 $N$，预算的分布独立于未知偏置 $x$，并满足

$$
 \mathbb E(1+N)^r\le C_{r,\varepsilon}\bigl(1+A_r(f)\bigr).
$$

这里的期望不依赖于 $x$。成本仅计入输入硬币调用；模型允许精确辅助随机性和指定的实数概率表。因此，该定理讨论输入调用复杂度，并未声称能一致高效地计算这些表或其所需实数表示。

我们证明一个依赖所给数据的更强版本。假设对每个 $j\ge0$，给定多项式 $P_j\in\Pi_{2^j}$ 及非负误差证书 $e_j$，满足

$$
 \|f-P_j\|_\infty\le e_j,\qquad
 S:=\sum_{j=0}^{\infty}4^{rj}e_j<\infty.
 \tag{S.1}
$$

则下面的构造给出

$$
\begin{split}
 \mathbb E(1+N)^r
 &\le 4^r\left(\frac{8\pi^2}{\varepsilon}+2\right)^r
       \left(1+\frac{16S}{\varepsilon}\right)\\
 &\quad+4(2\pi^2+2)^r(4^r+1)S.
\end{split}
\tag{S.2}
$$

因而，定理 S 中的一个可用常数为

$$
 C_{r,\varepsilon}
 =4^r\left(\frac{8\pi^2}{\varepsilon}+2\right)^r
       \left(1+\frac{16}{\varepsilon}\right)
  +4(2\pi^2+2)^r(4^r+1).
 \tag{S.3}
$$

这些常数有意取为保守界。所有对次数的依赖均已明确写出。

### 3.2. 一致稳定的 Bernstein 逆算子

对整数 $n\ge1$，定义

$$
 b_{n,k}(x)=\binom nkx^k(1-x)^{n-k},\qquad
 (B_np)(x)=\sum_{k=0}^n p(k/n)b_{n,k}(x).
$$

下面的自足论证只用到两个经典多项式不等式。

1. **$[0,1]$ 上的 Markov 不等式：** 若 $p\in\Pi_m$，则 $\|p'\|_\infty\le2m^2\|p\|_\infty$。
2. **三角多项式的 Bernstein 不等式：** 若 $F$ 的三角次数至多为 $m$，则连续两次使用一阶导数版本可得 $\|F''\|_\infty\le m^2\|F\|_\infty$。

它们是经典工具，不属于本文拟提出的原创结果。[DZ93，式 (3.1) 和 (5.1)] 提供了从原始文献获得同一尺度的另一条独立路线。

#### 引理 S.1：Bernstein 算子在多项式上的误差

对每个整数 $m\ge1$、$n\ge1$ 和 $p\in\Pi_m$，有

$$
 \|B_np-p\|_\infty\le\frac{\pi^2m^2}{n}\|p\|_\infty.
 \tag{S.4}
$$

**证明。** 令

$$
 F(\theta)=p\left(\frac{1+\cos\theta}{2}\right),\qquad0\le\theta\le\pi.
$$

这是一个次数至多为 $m$ 的偶三角多项式的限制，其在圆周上的一致范数等于 $\|p\|_{\infty,[0,1]}$。固定 $0<x<1$，令 $K\sim\operatorname{Bin}(n,x)$，并记

$$
 Y=K/n,\qquad \theta=\arccos(2x-1),\qquad
 \eta=\arccos(2Y-1),\qquad D=\eta-\theta.
$$

先验证直到端点仍具有统一常数的角度估计。由于

$$
 (\sqrt x,\sqrt{1-x})=(\cos(\theta/2),\sin(\theta/2)),
$$

且对 $Y,\eta$ 也有相同关系，两点的弦距离平方为

$$
 (\sqrt Y-\sqrt x)^2+
 (\sqrt{1-Y}-\sqrt{1-x})^2=4\sin^2(D/4).
$$

由 $0\le u\le\pi/2$ 时的 $\sin u\ge2u/\pi$，结合 $|D|\le\pi$，可得

$$
 D^2\le\pi^2\bigl((\sqrt Y-\sqrt x)^2+
                   (\sqrt{1-Y}-\sqrt{1-x})^2\bigr).
$$

另外，

$$
\begin{split}
 \mathbb E(\sqrt Y-\sqrt x)^2
 &\le\frac{\mathbb E(Y-x)^2}{x}=\frac{1-x}{n},\\
 \mathbb E(\sqrt{1-Y}-\sqrt{1-x})^2
 &\le\frac{\mathbb E(Y-x)^2}{1-x}=\frac{x}{n}.
\end{split}
$$

因此

$$
 \mathbb ED^2\le\frac{\pi^2}{n}.
 \tag{S.5}
$$

因为 $Y$ 的均值为 $x$，所以 $\mathbb E\cos\eta=\cos\theta$。利用余弦函数的 Taylor 公式及 $\|\cos''\|_\infty\le1$，得到

$$
 |\sin\theta\,\mathbb ED|\le\tfrac12\mathbb ED^2.
 \tag{S.6}
$$

再对 $F$ 使用 Taylor 公式，结合上述两个经典不等式以及 $F'(\theta)=-\tfrac12\sin\theta\,p'(x)$，便有

$$
\begin{split}
 |B_np(x)-p(x)|
 &\le |F'(\theta)\mathbb ED|
      +\tfrac12\|F''\|_\infty\mathbb ED^2\\
 &\le\left(\tfrac14\|p'\|_\infty
             +\tfrac12m^2\|p\|_\infty\right)\mathbb ED^2\\
 &\le m^2\|p\|_\infty\mathbb ED^2
 \le\frac{\pi^2m^2}{n}\|p\|_\infty.
\end{split}
$$

在 $x=0$ 或 $x=1$ 时，$Y=x$ 几乎处处成立，误差为零。证明完成。$\square$

#### 引理 S.2：升阶与系数界

设 $m\ge1$、$n\ge m$，并记 $\delta=\pi^2m^2/n$。若 $\delta<1$，则限制算子 $T=B_n|_{\Pi_m}$ 可逆。对每个 $p\in\Pi_m$，其 $n$ 次 Bernstein 系数 $c_k^{(n)}(p)$ 满足

$$
 \max_{0\le k\le n}|c_k^{(n)}(p)|
 \le\frac{\|p\|_\infty}{1-\delta},
 \tag{S.7}
$$

以及

$$
 \max_{0\le k\le n}
   |c_k^{(n)}(p)-p(k/n)|
 \le\frac{\delta}{1-\delta}\|p\|_\infty.
 \tag{S.8}
$$

特别地，若 $n\ge2\pi^2m^2$，则所有系数的绝对值至多为 $2\|p\|_\infty$。

**证明。** 算子 $B_n$ 将 $\Pi_m$ 映入自身。例如，二项分布的阶乘矩恒等式表明，对 $\ell\le m$，$B_n(x^\ell)$ 的次数至多为 $\ell$。在该有限维 Banach 空间的一致范数下，引理 S.1 给出 $\|I-T\|\le\delta<1$。Neumann 级数于是给出

$$
 T^{-1}=\sum_{a=0}^{\infty}(I-T)^a,\qquad
 \|T^{-1}\|\le(1-\delta)^{-1},\qquad
 \|T^{-1}-I\|\le\delta/(1-\delta).
$$

对 $q=T^{-1}p$，有

$$
 p=B_nq=\sum_{k=0}^n q(k/n)b_{n,k}.
$$

由 $n$ 次 Bernstein 基表示的唯一性，$c_k^{(n)}(p)=q(k/n)$。两个范数界分别给出 (S.7) 和 (S.8)。$\square$

**次数无关性的核查。** Neumann 论证虽然在 $\Pi_m$ 内进行，却没有使用依赖于 $m$ 的范数等价常数。(S.4) 中的算子范数已被显式控制为 $\pi^2m^2/n$。这一点至关重要：仅有固定次数下逆算子的收敛定理，不能支撑这里的结论。

### 3.3. 从逼近证书构造工厂

假设 (S.1) 成立。令

$$
 J=\min\left\{j\in\mathbb N_0:
          4^{rj}\ge\max\left(1,\frac{16S}{\varepsilon}\right)\right\}.
 \tag{S.9}
$$

该定义覆盖 $S=0$ 的情形，此时 $J=0$。由 (S.1)，

$$
 e_J\le S4^{-rJ}\le\frac{\varepsilon}{16},\qquad
 \sum_{k\ge J}e_k\le S4^{-rJ}\le\frac{\varepsilon}{16}.
 \tag{S.10}
$$

对每个 $j>J$，令

$$
 D_j=P_j-P_{j-1},\qquad a_j=e_{j-1}+e_j,
 \qquad w_j=4a_j,
 \qquad n_j=\left\lceil2\pi^2 4^j\right\rceil.
 \tag{S.11}
$$

则

$$
 \deg D_j\le2^j,\qquad \|D_j\|_\infty\le a_j,
 \qquad
 W:=\sum_{j>J}w_j
 \le8\sum_{k\ge J}e_k\le\frac{\varepsilon}{2}\le\frac14.
 \tag{S.12}
$$

对每个 $a_j>0$ 的指标，定义

$$
 q_j(x)=\frac12+\frac{D_j(x)}{4a_j}.
 \tag{S.13}
$$

由引理 S.2，$D_j$ 的每个 $n_j$ 次 Bernstein 系数都属于 $[-2a_j,2a_j]$。因此，$q_j$ 的每个 $n_j$ 次 Bernstein 系数都属于 $[0,1]$。若 $a_j=0$，则 $D_j=0$ 且 $w_j=0$；在数学构造中省略这些指标，所以 (S.13) 不会除以零。

对基底分支，令

$$
 w_0=1-W,\qquad
 n_0=\left\lceil\frac{8\pi^2}{\varepsilon}4^J\right\rceil,
 \qquad
 q_0(x)=\frac{P_J(x)-W/2}{1-W}.
 \tag{S.14}
$$

这里下标 $0$ 是基底分支的标签，并非尺度指标 $J$。下面验证其系数界；仅验证逐点取值范围还不够。

由 (S.10)，

$$
 \frac{15\varepsilon}{16}\le P_J(x)
 \le1-\frac{15\varepsilon}{16},\qquad
 \|P_J\|_\infty\le1.
 \tag{S.15}
$$

取 $m=2^J$、$n=n_0$，引理 S.2 中的参数满足 $\delta\le\varepsilon/8\le1/16$。特别地，(S.8) 给出

$$
 \max_k|c_k^{(n_0)}(P_J)-P_J(k/n_0)|
 \le 2\delta\|P_J\|_\infty\le\varepsilon/4.
$$

与 (S.15) 合并可得

$$
 \frac{11\varepsilon}{16}
 \le c_k^{(n_0)}(P_J)
 \le1-\frac{11\varepsilon}{16}.
 \tag{S.16}
$$

由于 $W/2\le\varepsilon/4$，上述区间包含于 $[W/2,1-W/2]$。因此

$$
 0\le c_k^{(n_0)}(q_0)
   =\frac{c_k^{(n_0)}(P_J)-W/2}{1-W}\le1.
 \tag{S.17}
$$

至此，所有分支都有合法的有限输入实现。

### 3.4. 工厂及精确性

读取输入硬币之前，独立于输入序列和 $x$ 抽取分支标签 $I$，分布为

$$
 \mathbb P(I=0)=w_0,\qquad
 \mathbb P(I=j)=w_j\quad(j>J, a_j>0).
$$

这些概率非负且总和为一。令 $N=n_I$。恰好读取 $N$ 个独立的 $\operatorname{Ber}(x)$ 输入，并令 $K$ 为其中正面的数量。随后利用独立辅助随机性，按条件概率

$$
 c_K^{(N)}(q_I).
$$

输出一。(S.13) 和 (S.17) 中已经证明的界保证这是合法概率。给定 $I=i$，输出一的概率为

$$
 \sum_{k=0}^{n_i}c_k^{(n_i)}(q_i)b_{n_i,k}(x)=q_i(x).
$$

不同分支标签可以对应相同的整数预算。预先抽取的标签保留为辅助随机性；等价地，给定重复预算后，也可按条件分支权重平均对应系数数组。因此，这个构造符合“先抽取预算 $N$，再读取 $N$ 枚硬币”的模型。

因为 $\sum_j e_j<\infty$，级数 $\sum_{j>J}D_j$ 在一致范数下绝对收敛。其部分和望远镜消去，又有 $\|f-P_j\|_\infty\le e_j\to0$，所以

$$
 f=P_J+\sum_{j>J}D_j.
$$

根据 (S.13) 和 (S.14)，无条件输出一的概率恰好为

$$
\begin{split}
 w_0q_0(x)+\sum_{j>J}w_jq_j(x)
 &=P_J(x)-W/2+
   \sum_{j>J}\bigl(w_j/2+D_j(x)\bigr)\\
 &=P_J(x)+\sum_{j>J}D_j(x)=f(x).
\end{split}
\tag{S.18}
$$

分支分布的每个标签都是有限整数，且每个 $n_i$ 都有限，因此 $N<\infty$ 几乎处处成立。其独立于所有输入结果，则由构造顺序直接保证。

### 3.5. 定量矩界

由于 $4^j\ge1$，

$$
 1+n_j\le(2\pi^2+2)4^j\quad(j>J),
 \qquad
 1+n_0\le\left(\frac{8\pi^2}{\varepsilon}+2\right)4^J.
 \tag{S.19}
$$

尾部分支满足

$$
\begin{split}
 \sum_{j>J}w_j(1+n_j)^r
 &\le4(2\pi^2+2)^r
      \sum_{j>J}4^{rj}(e_{j-1}+e_j)\\
 &\le4(2\pi^2+2)^r(4^r+1)S.
\end{split}
\tag{S.20}
$$

由 (S.9) 中 $J$ 的最小性，包括 $J=0$ 时在内，都有

$$
 4^{rJ}\le4^r\max\left(1,\frac{16S}{\varepsilon}\right)
 \le4^r\left(1+\frac{16S}{\varepsilon}\right).
 \tag{S.21}
$$

因为 $w_0\le1$，基底分支的贡献至多为

$$
 w_0(1+n_0)^r
 \le4^r\left(\frac{8\pi^2}{\varepsilon}+2\right)^r
          \left(1+\frac{16S}{\varepsilon}\right).
 \tag{S.22}
$$

将 (S.20) 与 (S.22) 相加即得 (S.2)。计算中的任何一步都不要求 $r\ge1$，因此也覆盖所有 $0<r<1$。

为得到定理 S，对每个 $j$ 选择最佳一致逼近多项式 $P_j\in\Pi_{2^j}$，并令 $e_j=E_{2^j}(f)$。由于逼近空间有限维，可以将极小化序列选在一个有界集内，而该空间内的闭有界集紧，因此极小值确实达到。于是 $S=A_r(f)$，所需界得证。

对任意连续 $f:[0,1]\to(0,1)$，紧性保证存在满足严格内区间界的 $\varepsilon>0$。统一的定量陈述则使用固定且已给出的 $\varepsilon$。

### 3.6. 带可验证误差界数据下的构造含义

这些公式只使用 $r,\varepsilon$、所给多项式及误差对 $(P_j,e_j)$，以及加权误差和的一个有限上界。无需精确知道 $S$：选择 $J$ 时，可用任何已认证的 $\overline S\ge S$ 替代 $S$，所得矩估计相应以 $\overline S$ 替代 $S$。

无穷尾权重 $W$ 不是一个缺少收敛速率的额外极限。对每个整数 $M\ge J$，有

$$
 0\le W-\sum_{j=J+1}^{M}w_j
     =4\sum_{j>M}(e_{j-1}+e_j)
 \le8\overline S\,4^{-rM}.
 \tag{S.23}
$$

因此，有限的证书数据就能把 $W$ 确定到任意给定精度。每张有限系数表都可以通过求解次数为 $m$ 的线性方程组 $B_nq=p$ 获得，也可直接使用通常的精确基转换恒等式。上文证明保证了这些系数的取值范围。

在任意实数的存在性定理中，第 3.3--3.5 节的取最小值、向上取整以及省略零权指标，都是合法的数学定义；常数 (S.2)--(S.3) 保持不变。若要有效实现，则必须更谨慎，因为任意可计算实数的相等判定和向上取整不能被统一判定。现在额外假设 $r,\varepsilon,\overline S$ 以及多项式和误差数据都是可计算的精确实数，并附有上述正参数与误差证书。使用以下保守选择。

1. 令 $L=r^{-1}\log_4\max\{1,16\overline S/\varepsilon\}$。计算一个满足 $L\le u<L+1$ 的有理上包络 $u$，再令 $J_{\rm eff}=\lfloor u\rfloor+1$。这里只对已知有理数取下整，因此 $L<J_{\rm eff}<L+2$；无需任何精确实数相等测试，所需小尾部不等式就都成立。
2. 对尾部分支使用整数预算

   $$
     \widetilde n_j=20\cdot4^j\qquad(j>J_{\rm eff}).
   $$

   已认证的不等式 $2\pi^2<20$ 保证了系数稳定性条件。
3. 计算有理上包络 $v$，使 $8\pi^2/\varepsilon\le v<8\pi^2/\varepsilon+1$，令 $B=\lfloor v\rfloor+1$，并采用

   $$
     \widetilde n_0=B\cdot4^{J_{\rm eff}}.
   $$

   此时 $8\pi^2/\varepsilon<B<8\pi^2/\varepsilon+2$，所以基底系数界仍然成立；这也避开了对可计算实数向上取整的问题。

在类别分布中保留所有尾部指标，包括 $w_j=0$ 的指标，不尝试判定哪些权重为零。使用一个新的均匀随机实数及可计算的累积权重，选择包含它的唯一正长度区间。可数多个区间端点的概率为零；每个零权分支的区间为空，因而永远不会被选中。抽样几乎必然终止，因为包含均匀变量的区间具有有限指标，且严格的端点比较最终能被认证。若某尾部分支 $j$ 被选中，则其区间具有正长度，这就保证 $a_j>0$。只有在这之后，才通过逐步提高实数近似精度、取得一个正有理下界来计算 $a_j^{-1}$，并形成该分支的系数表。整个过程无需统一判定 $a_j=0$，也不会在零概率分支上执行除法。基底分支已有认证界 $1-W\ge3/4$。

按这些选择，有

$$
\begin{split}
 \mathbb E(1+\widetilde N)^r
 &\le4^{2r}\left(\frac{8\pi^2}{\varepsilon}+3\right)^r
       \left(1+\frac{16\overline S}{\varepsilon}\right)\\
 &\quad+4\cdot21^r(4^r+1)\overline S.
\end{split}
\tag{S.24}
$$

事实上，$1+\widetilde n_0\le(8\pi^2/\varepsilon+3)4^{J_{\rm eff}}$，$4^{rJ_{\rm eff}}\le4^{2r}\max\{1,16\overline S/\varepsilon\}$，且 $1+\widetilde n_j\le21\cdot4^j$。混合证明的其余部分保持不变。因此，有效版本对已认证逼近和仍呈线性依赖，只是基底常数如实增大。

选中分支后，将其系数概率与第二个独立均匀随机实数比较，即可实现相应的系数硬币，并且几乎必然终止。与指定可计算概率恰好相等仍是零概率事件，概率为零或一时也是如此。这里的计算论说明不提供辅助随机比特数、实数运算量或表大小的界。它仅在本节额外的可计算数据假设下说明统一的有效可实现性；原定理仍保留任意实数的存在性模型。

## 4. 精确对数端点及普通 Hölder 例子

固定 $\alpha>0$、$\beta\ge0$、整数 $M>\alpha+1$，以及满足 $2^J>4M$ 的整数 $J\ge1$。令 $\eta=(1-2^{-\alpha})/4$，并定义

$$
f_{\alpha,\beta}(x)=\frac12+
\eta[4x(1-x)]^M\sum_{j=J}^{\infty}2^{-\alpha j}j^{-\beta}T_{2^j}(2x-1),
\tag{C.1}
$$

其中 $T_d(\cos\theta)=\cos(d\theta)$。该级数一致收敛。因为 $|T_d|\le1$ 且权函数不超过一，故 $|f_{\alpha,\beta}-1/2|<1/4$。所以这些目标具有共同的正余量，且两端点处都取值 $1/2$。

**定理 C（临界例子）。** 存在与 $\ell$ 和 $\beta\ge0$ 无关的正常数 $c_{\alpha,M}$ 和 $C_\alpha$，使得对每个 $\ell\ge J$，有

$$
c_{\alpha,M}2^{-\alpha\ell}\ell^{-\beta}
\le E_{2^\ell}(f_{\alpha,\beta})
\le C_\alpha2^{-\alpha\ell}\ell^{-\beta}.
\tag{C.2}
$$

因此，存在某个合法精确工厂，其输入成本具有有限 $r$ 阶矩，当且仅当

$$
r<\frac\alpha2\quad\text{or}\quad
\left(r=\frac\alpha2\text{ and }\beta>1\right).
\tag{C.3}
$$

**证明。** 在 $j=\ell$ 之前截断 (C.1)，所得多项式次数至多为 $2^{\ell-1}+2M\le2^\ell$；当 $\ell=J$ 时，该多项式就是常数 $1/2$。尾部范数至多为

$$
\eta\sum_{j\ge\ell}2^{-\alpha j}j^{-\beta}
\le\frac{\eta}{1-2^{-\alpha}}2^{-\alpha\ell}\ell^{-\beta}.
$$

为证明下界，作代换 $x=(1+\cos\theta)/2$，权函数变为 $\sin^{2M}\theta$。第 $j$ 项的余弦频率属于 $[2^j-2M,2^j+2M]$。由 $2^J>4M$，这些频带彼此不交。在频率 $k_\ell=2^\ell+2M$ 处，最高余弦系数恰好为

$$
\eta(-1)^M2^{-2M}2^{-\alpha\ell}\ell^{-\beta}.
\tag{C.4}
$$

这是因为 $\sin^{2M}\theta$ 的最高余弦系数为 $(-1)^M2^{1-2M}$，再乘上 $\cos(2^\ell\theta)$ 会多出因子 $1/2$。其他频带没有贡献。次数至多为 $2^\ell$ 的代数多项式不含角频率 $k_\ell$。连续函数的每个余弦系数绝对值都不超过其一致范数的两倍，故逼近误差至少为 $\eta2^{-2M-1}2^{-\alpha\ell}\ell^{-\beta}$。于是 (C.2) 得证。将其代入定理 M，判据化为 $\sum_\ell2^{(2r-\alpha)\ell}\ell^{-\beta}$ 收敛，便得到 (C.3)。特别地，临界处 $\beta=1$ 对应调和级数发散。$\square$

### 4.1. 含端点的普通 Hölder 正则性

若 $\alpha=k+\gamma$ 为非整数，其中 $k\ge0$ 且 $0<\gamma<1$，则 (C.1) 中每个函数都属于普通的 $C^\alpha[0,1]$，而不仅仅是在换元后的坐标下满足 Hölder 条件。

为证明这一点，记 $G_d(x)=[4x(1-x)]^MT_d(2x-1)$。对每个 $0\le a\le k+1$，存在常数 $D_{M,a}$，使得

$$
\|G_d^{(a)}\|_{\infty,[0,1]}\le D_{M,a}d^a\qquad(d\ge1).
\tag{C.5}
$$

在角坐标下，$G_d=\sin^{2M}\theta\cos(d\theta)$ 且 $d/dx=(-2/\sin\theta)d/d\theta$。归纳可知，求导 $a$ 次后，每一项都含有某个 $d^b$（$b\le a$）、至少为 $2M-2a$ 次的 $\sin\theta$，以及有界的正弦或余弦因子。对振荡因子求导只会使正弦的次数下降一，因此上述下界始终保持。因为 $M\ge a$，这些幂次都非负。再由多项式导数的连续性，把界延伸到端点，便得 (C.5)。

由于 $\sum_j2^{(k-\alpha)j}j^{-\beta}<\infty$，直到 $k$ 阶的导数级数都一致收敛。考虑第 $k$ 阶导数在距离 $h\in(0,1]$ 上的增量，按 $2^j\le1/h$ 分为低频和高频。利用 (C.5) 的 $k+1$ 阶界，低频部分至多为

$$
Ch\sum_{2^j\le1/h}2^{(k+1-\alpha)j}\le C'h^\gamma,
$$

高频部分至多为 $C\sum_{2^j>1/h}2^{(k-\alpha)j}\le C'h^\gamma$。这证明了整个闭区间上的普通 Hölder 正则性。这里没有把整数阶 $C^\alpha$ 与 Zygmund 空间等同。

### 4.2. 仅凭光滑性的保证能到何处

对非整数 $\rho>0$，普通 Jackson 估计 $E_m(f)=O(m^{-\rho})$ 与定理 M 表明：若 $r<\rho/2$，则每个严格取值于 $(0,1)$ 的 $C^\rho$ 目标，都存在输入成本具有有限 $r$ 阶矩的工厂。在 $r=\rho/2$ 时，(C.1) 中 $\beta\le1$ 的例子说明，不可能对整个 Hölder 类作此保证。同一临界矩处，$\beta>1$ 又给出了能够实现有限矩的例子。若 $r>\rho/2$，这些例子再次否定普遍保证。例如，在 $\alpha=3/2$ 时，精确边界为 $r=3/4$，临界处是否可实现由 $\beta>1$ 与否决定。

根据 (N.7)，这个障碍结论覆盖非自适应模型中的所有规则。它不涉及任意自适应规则的最优成本。

## 5. 原去偏估计量：矩与有界性

现在保留 [KKLŚ26，式 (7)] 的估计量，包括它原有的整数值幂律截断；本节使用的不是第 3 节构造的另一个工厂。全节都要求下系数数组在 Bernstein 升阶后保持有序。该假设用于保证非负性，不能因为 [KKLŚ26，推论 1] 的简短陈述未重述它就将其删去。

### 5.1. 结论及其准确范围

涉及 HNP 的所有结论均假设目标是连续函数 $f:[0,1]\to(0,1)$。由紧性，它与零和一之间具有严格正的余量；第 5.6 节的系数余量需要这一假设。

先固定非整数 $\rho>0$，记 $\beta=\lambda-1>0$ 和 $a=\rho/2$。对于第 5.6 节按这个固定指数构造的、未经舍入的精确 HNP 系数族，原 KKLŚ 估计量满足下列充分条件。

| 假设与参数 | 结论 |
| --- | --- |
| $f\in C^\rho[0,1]$，$\rho>0$，$0<\beta<\rho/2$，初始截断 $k$ 充分大 | $0\leq\psi\leq1$ 且无偏，对所有输入偏置 $x\in[0,1]$ 一致成立 |
| 同一系数族，$0<\beta\leq\rho/2$，任意固定的合法截断 | $\psi$ 的每个有限正阶输出矩都有限 |
| 同一系数族，$p>1$，$(p-1)\beta<p\rho/2$ | $\mathbb E_x\psi^p<\infty$，关于 $x$ 一致 |
| 同一系数族，$0<\beta<\rho$ | 方差有限 |
| 同一系数族，$\rho>1$，$1<\beta<\rho$ | 方差和平均输入成本均有限，但不声称 $\psi\leq1$ |
| 同一系数族，$\rho>2$，$1<\beta<\rho/2$，$k$ 充分大 | 估计量取值于 $[0,1]$，且平均输入成本有限 |

若光滑阶 $\rho$ 为整数，则使用非整数构造指数 $\sigma<\rho$。通过选择充分接近 $\rho$ 的 $\sigma$，表中所有严格不等式结论都可延伸至该情形。对第二行，若 $\beta<\rho/2$，一个固定构造便能同时给出每个有限阶矩。在 $\beta=\rho/2$ 时，第三行仍可针对每个固定有限矩阶，选择依赖于该矩阶的 $\sigma<\rho$ 来获得保证；但这并未提供一个同时适用于所有矩阶的系数族。引用此表时必须保留这一量词差别。

另有一个只要求抽象系数单调性及函数误差界的结论：若 $0\leq f-g_m\leq C m^{-a}$，则

$$
 (p-1)\beta<a
 \quad\Longrightarrow\quad
 \sup_{x\in[0,1]}\mathbb E_x\psi^p<\infty
 \qquad(p>1).
$$

特别地，仅凭抽象函数间隙，在 $1<\lambda<1+\rho/2$ 时即可得到有限方差。这直接回答了原文提出的 $\rho>2$ 有限方差问题，不要求预先平方可积，也不使用其方差恒等式。若 $\rho>2$，区间 $2<\lambda<1+\rho/2$ 还保证平均输入成本有限。

所有列出的参数边界都是充分条件。本文不声称它们对每个函数或每个系数族都是必要的。例如，常数目标在这些范围之外仍可具有平凡估计量。主定理中的完整矩刻画是另一项结果，不能与这里针对一个特定估计量的充分条件混为一谈。

### 5.2. Bernstein 升阶及假设

对整数 $0\leq m\leq n$，令 $T_{m,n}$ 为归一化 Bernstein 系数上的升阶映射：

$$
 (T_{m,n}c)_s
 =\sum_{i=0}^{m}
   \frac{\binom mi\binom{n-m}{s-i}}{\binom ns}c_i,
 \qquad 0\leq s\leq n.
 \tag{O.2.1}
$$

约定当 $v$ 不属于 $0\leq v\leq u$ 时，$\binom uv=0$。对公式中每个 $s$，包括 $s=0,n$，分母都为正。Vandermonde 恒等式表明每行都是概率向量。因此这些映射保持非负性和常数，并且压缩系数的一致范数。它们满足

$$
 T_{m,n}T_{\ell,m}=T_{\ell,n}\qquad(\ell\leq m\leq n).
 \tag{O.2.2}
$$

验证 (O.2.2) 的一种方法是：先从一个 $n$ 元集合中均匀选择 $m$ 元子集，再从中均匀选择 $\ell$ 元子集。最终子集在所有 $\ell$ 元子集中均匀分布；给定标记元素总数后，便得到 (O.2.1)。

设 $A_n=(a(n,i))_{i=0}^n$ 和 $B_n=(b(n,i))_{i=0}^n$ 满足

$$
 0\leq A_n\leq B_n\leq1,
 \qquad T_{m,n}A_m\leq A_n\leq B_n\leq T_{m,n}B_m
 \quad(m\leq n).
 \tag{O.2.3}
$$

所有系数向量之间的不等式均按分量理解。定义

$$
 g_n(x)=\sum_{i=0}^n a(n,i)\binom ni x^i(1-x)^{n-i},
 \qquad
 h_n(x)=\sum_{i=0}^n b(n,i)\binom ni x^i(1-x)^{n-i}.
 \tag{O.2.4}
$$

假设 $g_n(x)\uparrow f(x)$ 且 $h_n(x)\downarrow f(x)$。第 5.3、5.4 节实际上只需下系数数组、其单调性以及 $g_n\uparrow f$。上系数数组是为误差 $e_n(x):=f(x)-g_n(x)$ 提供证书的一种方式。

下面两个误差假设必须分开：

$$
 0\leq e_n(x)\leq h_n(x)-g_n(x)\leq C n^{-a}
 \quad\text{for all }x,
 \tag{FG}
$$

以及更强的系数假设

$$
 \|B_n-A_n\|_{\ell^\infty}\leq C n^{-a}.
 \tag{CG}
$$

(CG) 蕴含 (FG)，但下文从不只凭 (FG) 推出 (CG)。

### 5.3. 保持不变的原估计量及基本恒等式

固定整数 $k\geq1$、$\lambda=1+\beta>1$，并定义

$$
 Z(m)=\sum_{j=m}^\infty j^{-1-\beta},
 \qquad
 \mathbb P(L=\ell)=\frac{\ell^{-1-\beta}}{Z(k)}
 \quad(\ell\geq k).
 \tag{O.3.1}
$$

随机变量 $L$ 独立于输入硬币。令

$$
 q_m=\mathbb P(L\geq m)=\frac{Z(m)}{Z(k)},
 \qquad w_m=q_m^{-1}\quad(m\geq k).
 \tag{O.3.2}
$$

特别地，$q_k=w_k=1$。对固定的 $\ell\geq k$ 和 $0\leq s\leq\ell$，记

$$
 y_m=H_\ell(m,s):=(T_{m,\ell}A_m)_s,
 \qquad 0\leq m\leq\ell.
 \tag{O.3.3}
$$

由 (O.2.2)--(O.2.3)，

$$
 0\leq y_0\leq y_1\leq\cdots\leq y_\ell=a(\ell,s)\leq1.
 \tag{O.3.4}
$$

原估计量为

$$
 \psi(\ell,s)
 =y_{k-1}+\sum_{m=k}^{\ell}w_m(y_m-y_{m-1}).
 \tag{O.3.5}
$$

对 $S_\ell\sim\operatorname{Bin}(\ell,x)$，超几何子抽样恒等式给出

$$
 \mathbb E_x H_\ell(m,S_\ell)=g_m(x),\qquad m\leq\ell.
 \tag{O.3.6}
$$

这是整个闭区间上的多项式恒等式。特别地，它也适用于 $x=0,1$；此时 $S_\ell$ 为确定值，不需要在这些端点对零概率事件作条件化。

(O.3.5) 中每项均非负。因此，先应用 Tonelli 定理，再用 (O.3.6)，便在扩展非负实数意义下得到

$$
 \begin{aligned}
 \mathbb E_x\psi(L,S_L)
 &=g_{k-1}(x)+\sum_{m=k}^\infty
    \frac{\mathbb P(L\geq m)}{q_m}
       [g_m(x)-g_{m-1}(x)]\\
 &=f(x).
 \end{aligned}
 \tag{O.3.7}
$$

特别地，$\psi$ 可积且无偏。此论证没有假设任何二阶矩。因为 $L<\infty$ 几乎处处成立，且每个 $q_m>0$，每次实际取到的有限和 (O.3.5) 都有定义。

#### 5.3.1. 保留末端边界的有限 Abel 恒等式

令 $d_m=w_{m+1}-w_m\geq0$。对每个有限的 $\ell\geq k$，有

$$
 \boxed{
 \psi(\ell,s)
 =a(\ell,s)+\sum_{m=k}^{\ell-1}d_m
   \bigl[a(\ell,s)-H_\ell(m,s)\bigr].}
 \tag{O.3.8}
$$

为证明它，从 (O.3.5) 中减去 $y_\ell=y_{k-1}+\sum_{j=k}^\ell(y_j-y_{j-1})$。因为 $w_k=1$，可写 $w_j-1=\sum_{m=k}^{j-1}d_m$。交换两个有限求和，再利用望远镜求和 $\sum_{j=m+1}^\ell(y_j-y_{j-1})=y_\ell-y_m$ 即得。这里没有遗漏末端项，也没有 $m=k-1$ 处的项。当 $\ell=k$ 时，求和为空，故 $\psi(k,s)=a(k,s)$。

由 (O.2.3) 中上系数的单调性，累积尾部满足

$$
 \begin{aligned}
 0\leq a(\ell,s)-H_\ell(m,s)
 &\leq (T_{m,\ell}(B_m-A_m))_s\\
 &\leq\|B_m-A_m\|_\infty .
 \end{aligned}
 \tag{O.3.9}
$$

这与将每个单独增量 $H_\ell(m)-H_\ell(m-1)$ 都用同一个误差界控制有关键区别。

### 5.4. 仅由函数间隙推出有限矩

#### 命题 O4.1：一般矩证书

在第 5.2 节的下系数数组假设下，对每个实数 $p\geq1$，有

$$
 \boxed{
 \mathbb E_x\psi^p
 \leq g_{k-1}(x)+\sum_{m=k}^\infty
      q_m^{1-p}[g_m(x)-g_{m-1}(x)]
 =f(x)+\sum_{m=k}^\infty
   [q_{m+1}^{1-p}-q_m^{1-p}]e_m(x).}
 \tag{O.4.1}
$$

该等式与不等式都在 $[0,\infty]$ 中成立；尤其是，右侧有限即能证明所需矩有限，而不是预先假设该矩存在。

**证明。** 固定 $(\ell,s)$。非负数

$$
 y_{k-1},\quad y_m-y_{m-1}\ (k\leq m\leq\ell),\quad 1-y_\ell
$$

之和为一。将它们依次视为数值 $1,w_k,\ldots,w_\ell,0$ 的权重。由 $t\mapsto t^p$ 的凸性，

$$
 \psi(\ell,s)^p
 \leq y_{k-1}+\sum_{m=k}^{\ell}w_m^p(y_m-y_{m-1}).
 \tag{O.4.2}
$$

使用 Tonelli 定理和 (O.3.6)，由于 $L$ 独立于输入硬币，取期望后 $w_m^p$ 变为 $q_mw_m^p=q_m^{1-p}$。这证明了 (O.4.1) 的第一个不等式。

对其中的等式，令 $v_m=q_m^{1-p}$，则 $v_k=1$。有限分部求和给出

$$
 g_{k-1}+\sum_{m=k}^{M}v_m(g_m-g_{m-1})
 =g_M+\sum_{m=k}^{M-1}(v_{m+1}-v_m)(g_M-g_m).
 \tag{O.4.3}
$$

当 $M\to\infty$ 时，右侧各项均非负且单调增至所写极限。单调收敛定理于是给出 (O.4.1) 的等式。没有使用任何未经验证的边界项消失假设。当 $p=1$ 时，$v_m$ 的差分为零，(O.4.1) 还原为 (O.3.7)。$\square$

对 $0<p<1$，由 (O.3.7) 的可积性与凹性得到 $\mathbb E_x\psi^p\leq f(x)^p$，无需任何误差速率。

#### 推论 O4.2：幂律截断及多项式函数间隙

若 (FG) 成立且 $p>1$，则 $(p-1)\beta<a$ 蕴含 $p$ 阶矩有限，并且关于 $x\in[0,1]$ 一致。更定量地，

$$
 \mathbb E_x\psi^p
 \leq f(x)+
 C(p-1)\beta\,2^{p\beta}
 (1+\beta/k)^{p-1}
 \left(\frac1{a-(p-1)\beta}+\frac1k\right)k^{-a}.
 \tag{O.4.4}
$$

**证明。** 对每个整数 $m\geq1$，积分比较给出

$$
 \frac{m^{-\beta}}\beta
 \leq Z(m)
 \leq \frac{m^{-\beta}}\beta+m^{-1-\beta}.
 \tag{O.4.5}
$$

因为 $Z(m)-Z(m+1)=m^{-1-\beta}$，对 $z^{-(p-1)}$ 应用中值定理，再使用 (O.4.5) 的下界，得到

$$
 \begin{aligned}
 q_{m+1}^{1-p}-q_m^{1-p}
 &\leq (p-1)Z(k)^{p-1}m^{-1-\beta}Z(m+1)^{-p}\\
 &\leq (p-1)Z(k)^{p-1}\beta^p 2^{p\beta}
                  m^{(p-1)\beta-1}.
 \end{aligned}
 \tag{O.4.6}
$$

对 $\gamma=a-(p-1)\beta>0$，有

$$
 \sum_{m=k}^\infty m^{-1-\gamma}
 \leq k^{-\gamma}\left(\frac1\gamma+\frac1k\right).
 \tag{O.4.7}
$$

将 (FG)、(O.4.6)、(O.4.7) 以及 (O.4.5) 中 $Z(k)$ 的上界代入 (O.4.1)，即得 (O.4.4)。$\square$

当 $p=2$ 时，(O.4.1) 给出尤其简洁的证书

$$
 \operatorname{Var}_x(\psi)
 \leq f(x)(1-f(x))+
   \sum_{m=k}^\infty (q_{m+1}^{-1}-q_m^{-1})[f(x)-g_m(x)].
 \tag{O.4.8}
$$

因此，处理 KKLŚ 的有限方差问题无需引入其所列 Rhee--Glynn 方差公式，也无需依赖其式 (18) 中有疑问的极限。

### 5.5. 强系数间隙：有界性及更大的矩范围

假设对 $m\geq k$ 有 (CG)。由 (O.3.8)--(O.3.9)，

$$
 0\leq\psi(\ell,s)
 \leq a(\ell,s)+C\sum_{m=k}^{\ell-1}d_m m^{-a}.
 \tag{O.5.1}
$$

尾概率倒数的增量恰好为

$$
 d_m=\frac{Z(k)m^{-1-\beta}}{Z(m)Z(m+1)}.
 \tag{O.5.2}
$$

于是，利用 (O.4.5)，

$$
 d_m\leq D_k m^{\beta-1},
 \qquad
 D_k:=2^\beta\beta(1+\beta/k)k^{-\beta}.
 \tag{O.5.3}
$$

#### 定理 O5.1：原估计量的一致有界性

进一步假设，存在 $\eta>0$，使得对每个 $n\geq k$ 及所有 $i$，都有 $a(n,i)\leq1-\eta$。若 $0<\beta<a$，则

$$
 \boxed{
 0\leq\psi(\ell,s)\leq 1-\eta+
 C\,2^\beta\beta(1+\beta/k)
 \left(\frac1{a-\beta}+\frac1k\right)k^{-a}
 }
 \tag{O.5.4}
$$

对每个有限的 $\ell\geq k$ 和 $0\leq s\leq\ell$ 成立。特别地，当 $k$ 充分大时，$\psi\in[0,1]$。

**证明。** 在 (O.5.1) 中先使用 (O.5.3)，再以 $\gamma=a-\beta$ 使用 (O.4.7)。(O.5.4) 中的余项随 $k\to\infty$ 趋于零。所有估计对于 $(\ell,s)$ 都是确定性的，因而也覆盖 $x=0,1$。$\square$

一个完全显式而保守的截断选择，是取处于系数有效范围、且满足下式的任意整数 $k$：

$$
 k^a\geq
 \frac{C\,2^\beta\beta(1+\beta)
              [1+(a-\beta)^{-1}]}\eta.
 \tag{O.5.5}
$$

常数 $C,\eta$ 本身也必须由所选系数族提供可验证的界。(O.5.5) 并未使 HNP 构造在计算上变得高效，也不会自动给出其隐藏常数。

#### 命题 O5.2：截断尚不足以保证 $[0,1]$ 取值时的输出矩

对任意固定的合法 $k$，(CG) 给出：

- 若 $\beta<a$，则 $\psi$ 一致有界，因此每个有限正阶输出矩都存在。
- 若 $\beta=a$，则 $\psi(\ell,s)\leq1+CD_k[1+\log(\ell/k)]$。因此每个有限正阶输出矩都存在，因为在 (O.3.1) 的分布下，$\log(1+L)$ 的任意有限正次幂都可积。
- 若 $\beta>a$，则 $\psi(\ell,s)\leq1+(CD_k/(\beta-a))\ell^{\beta-a}$。所以，当 $p(\beta-a)<\beta$ 时，$\mathbb E_x\psi^p<\infty$。

**证明。** 将 (O.5.1) 中的求和界为 $CD_k\sum_{m=k}^{\ell-1}m^{\beta-a-1}$。第一种情形已在定理 O5.1 中处理。第二种情形的调和和至多为 $1+\log(\ell/k)$。若 $\gamma=\beta-a>0$，则根据 $\gamma\leq1$ 或 $\gamma\geq1$，分别在 $[m-1,m]$ 或 $[m,m+1]$ 上进行积分比较，得到 $\sum_{m=k}^{\ell-1}m^{\gamma-1}\leq\ell^\gamma/\gamma$。最后，

$$
 \mathbb E L^t
 =\frac1{Z(k)}\sum_{\ell=k}^\infty\ell^{t-1-\beta}
 <\infty\quad\Longleftrightarrow\quad t<\beta
 \qquad(t>0).
 \tag{O.5.6}
$$

这证明最后一项结论。各界对 $s$ 一致，因此也对 $x$ 一致。$\square$

对 $p>1$，上述三种情形共同给出简洁的充分条件 $(p-1)\beta<pa$。当 $p=2$ 时，即为 $\beta<2a$。若该充分条件取等号，当前估计得到调和级数；这并不能证明实际估计量的矩发散。

### 5.6. 精确的 HNP 系数族及次数偏移

本节使用 HNP2011 第 5 节步骤 4--5 中的具体结论，而不从其定理 8 的函数层面陈述反推系数估计。

设 $\rho>0$ 为非整数，$d=\lfloor\rho\rfloor$。HNP 选择整数 $b=2^s$、初始值 $n_0$ 和层级 $n_j=b^j n_0$。其修正多项式 $F_{n_j}$ 的次数至多为 $n_j+d$。步骤 4 给出某个 $\delta>0$，使其在 $n_j+d$ 次表示下的归一化 Bernstein 系数落在 $[\delta,1-\delta]$。步骤 5 的式 (47)--(48) 定义

$$
 \phi_n(x)=\theta_\rho n^{-\rho}
              +[x(1-x)/n]^{\rho/2},
$$

$$
 G_n=F_n-D[x+(1-x)]^d B_n\phi_n,
 \qquad
 U_n=F_n+D[x+(1-x)]^d B_n\phi_n.
 \tag{O.6.1}
$$

这里 $B_n$ 是通常的 Bernstein 算子；因子 $[x+(1-x)]^d$ 表示把 $n$ 次系数向量升为 $n+d$ 次。HNP 证明了相邻层级间下、上系数的单调性。我们采用这些原始实系数；为单独的公平比特实现而可选的舍入步骤，不属于这里的系数族。

令 $a=\rho/2$。因为升阶对一致范数是压缩映射，且 $x(1-x)\leq1/4$，(O.6.1) 中间隙的 $n+d$ 次系数满足

$$
 \|\operatorname{coeff}_{n+d}(U_n-G_n)\|_\infty
 \leq C_0 n^{-a},
 \qquad C_0=2D(\theta_\rho+4^{-a}).
 \tag{O.6.2}
$$

只选择并保留充分大的层级，使 (O.6.1) 两个式子中各自修正项的系数一致范数至多为 $\delta/2$。两组系数于是都属于 $[\delta/2,1-\delta/2]$。把保留的初始层级重新标为 $j=0$。舍弃有限多个初始层级，不会改变已用于构造剩余 $F_n$ 的 HNP 递推。

令 $M_j=n_j+d$。对每个整数 $m\geq M_0$，选择唯一满足 $M_j\leq m<M_{j+1}$ 的 $j$，并定义

$$
 A_m=T_{M_j,m}\operatorname{coeff}_{M_j}(G_{n_j}),
 \qquad
 B_m=T_{M_j,m}\operatorname{coeff}_{M_j}(U_{n_j}).
 \tag{O.6.3}
$$

对 $0\leq m<M_0$，令 $A_m=0$、$B_m=1$。复合律与 HNP 的层级间序关系共同证明了每一对整数次数上的 (O.2.3)，包括跨越层级以及跨越 $M_0$ 的情形。相邻层级之间所表示的多项式本身保持不变，所以其极限仍为 $f$。

(O.6.3) 中所有大次数系数都属于 $[\eta,1-\eta]$，其中 $\eta=\delta/2$。特别地，定理 O5.1 所需的下系数与一之间具有统一正余量。此外，

$$
 m<M_{j+1}=bn_j+d\leq(b+d)n_j
 \quad(n_j\geq1),
$$

故由 (O.6.2) 和压缩性，

$$
 \|B_m-A_m\|_\infty
 \leq C_0n_j^{-a}
 \leq C_0(b+d)^a m^{-a}
 \qquad(m\geq M_0).
 \tag{O.6.4}
$$

这同时显式处理了 $n+d$ 的次数偏移，以及几何层级之间的所有整数次数。由此得到 (CG)，其中 $C=C_0(b+d)^a$。取 $k\geq M_0$ 即可应用前面的界。基底指标 $k-1$ 即使小于 $M_0$，也已由上述延拓定义，因此没有使用不存在的系数。

当 $\rho$ 为整数时，先选择非整数 $\sigma<\rho$。由嵌入 $C^\rho[0,1]\subset C^\sigma[0,1]$，可用 $a=\sigma/2$ 实施同一构造。对以 $\rho$ 表述的每个严格参数不等式，选择足够接近 $\rho$ 的 $\sigma$，便可保留该不等式。任何引用这一论证的定理，都必须自始至终使用同一个选定的 $\sigma$ 及对应的同一个构造。

### 5.7. 回答原文问题，以及需要分开的主张

KKLŚ v2 定理 2 在 $\rho>3$ 且 $1<\lambda<(\rho-1)/2$ 时证明有界性。其推论 2 后的段落询问 $\rho>2$ 是否足以保证有限方差。他们提出的路线使用某个方差恒等式，而该恒等式的适用本身就需要平方可积性。

本文提供两条独立的解决路线。

1. 命题 O4.1 是针对原估计量的扩展实数 Jensen/Tonelli 估计。使用原文的抽象函数间隙，它在 $1<\lambda<1+\rho/2$ 时证明有限方差。该论证不使用 HNP 的更强系数结论。
2. 精确 HNP 系数给出更强结论。对每个正的非整数光滑指数，利用累积尾部的 Abel 求和，当 $1<\lambda<1+\rho/2$ 且 $k$ 充分大时，可证明输出属于 $[0,1]$。这些系数还在更广的范围 $1<\lambda<1+\rho$ 内给出有限方差，但该广范围内不声称输出仍属于 $[0,1]$。

基本概率分布 (O.3.1) 总是满足：$\mathbb E L^r<\infty$ 恰好等价于 $r<\lambda-1$。因此，当 $r<\rho/2$ 时，选择 $r<\lambda-1<\rho/2$，有界估计量构造便提供有限 $r$ 阶输入成本矩。这只是一个 Hölder 充分性推论，不能替代本项目的全函数必要充分定理，也没有证明其边界处的尖锐性。

## 6. 解释、验证及尚未覆盖的边界

定理 M 描述精确非自适应工厂的存在性及最优矩成本尺度。其常数有意取为保守值，并不提供单个目标的最小期望成本。区分输入成本矩和输出矩十分必要：一个具有有限方差的非负无偏估计量可能超过一，因此不能自动把它用作最后一次 Bernoulli 抽样的概率。第 5 节单独说明了何时输出属于 $[0,1]$。

理论允许任意精确辅助概率。带有可验证误差界数据的构造控制输入调用次数，却不控制公平比特数量、获得逼近系数的工作量或存储成本。目标达到零或一、开区间上不能连续延拓的目标，以及自适应停止成本，都不属于定理 M 的范围；本文不对这些情形的有限矩作分类。针对某些解析函数或正幂级数工厂已有的最优成本界 [Men19]，也未在这里被纳入计算效率主张。

原稿报告的精确有理数检查 用精确有理数实例验证 Bernstein 系数界、带符号混合恒等式、超几何升阶、有限截断的无偏性、Jensen 与 Abel 恒等式，以及 (C.4) 的最高频率系数。其 245 个有限估计量状态包括 $x=0$ 和 $x=1$。脚本把有限截断与其末端逼近多项式比较，而不是错误地与无穷目标比较。这些检查用于支持公式转录及代数一致性；无穷维和极限结论依靠书面证明。

全文尚未完成形式化。特别是，书面定理可以引用 HNP，但这不会把其构造变成已验证的 Lean 公理。本版本未附计算文件或形式化源码，也不声称获得内核验证。

## 7. 参考文献及来源状态

**[HNP11]** O. Holtz, F. Nazarov, and Y. Peres. *New coins from old, smoothly*. Constructive Approximation 33 (2011), 331--363. [arXiv:0808.1936v3](https://arxiv.org/abs/0808.1936v3)；[DOI](https://doi.org/10.1007/s00365-010-9108-5)。已核查全文，重点包括定理 8、引理 17、第 5 节步骤 4--5 和第 7 节。其有限矩问题采用更广的算法与成本模型。

**[KKLŚ26]** J. Koskela, T. Karvonen, K. Łatuszyński, and D. Spanò. *A debiased Bernoulli factory and unbiased estimation of a probability*. [arXiv:2510.01941v2](https://arxiv.org/html/2510.01941v2)，2026 年 9 月 1 日修订，首次提交于 2025 年。已核查全文和版本历史。本文使用其式 (7)、系数序关系及推论 2 后的问题，不把方差讨论中明显疑似排印错误的公式当作恒等式使用。

**[DZ93]** Z. Ditzian and X. Zhou. *Optimal approximation class for multivariate Bernstein operators*. Pacific Journal of Mathematics 158(1) (1993), 93--120. [出版商 PDF](https://msp.org/pjm/1993/158-1/pjm-v158-n1-p06-p.pdf)。精确的经典接口为式 (3.1)、定理 3.3／式 (3.8)，以及定理 5.1／式 (5.1)。相关 PDF 页面已作视觉核查。本文的初等证明避免了引入未经说明、可能依赖次数的逆算子常数。

**[GS12]** V. Goyal and K. Sigman. *On Simulating a Class of Bernstein Polynomials*. ACM Transactions on Modeling and Computer Simulation 22(2) (2012), Article 12. [作者稿](https://www.columbia.edu/~vg2277/simulate_bernstein.pdf)；[DOI](https://doi.org/10.1145/2133390.2133396)。定理 2.3 讨论固定的确定性输入预算。作者 PDF 保留了期刊元数据占位内容，因此另行记录正式书目 DOI。

**[QRR11]** W. Qian, M. D. Riedel, and I. Rosenberg. *Uniform approximation and Bernstein polynomials with coefficients in the unit interval*. European Journal of Combinatorics 32 (2011), 448--463. [作者网站上的出版商 PDF](https://www.cctbio.ece.umn.edu/wiki/images/a/ab/Qian_Riedel_Rosenberg_Uniform_Approximation_and_Bernstein_Polynomials_with_Coefficients_in_the_Unit_Interval.pdf)；[DOI](https://doi.org/10.1016/j.ejc.2010.11.004)。定理 1--2 研究多项式升阶及充分升阶后的正系数表示，并非随机预算的矩判据。

**[Men19]** L. Mendo. *An asymptotically optimal Bernoulli factory for certain functions that can be expressed as power series*. Stochastic Processes and their Applications 129(11) (2019), 4366--4384. [arXiv:1612.08923v5](https://arxiv.org/pdf/1612.08923v5)。已核查其特殊正级数构造；其提前停止的输入成本不能被默认为补足到完全预抽样预算后的成本。

**[KO94]** M. S. Keane and G. L. O'Brien. *A Bernoulli factory*. ACM Transactions on Modeling and Computer Simulation 4(2) (1994), 213--219。本轮无法访问出版商全文。上述可读来源中讨论了这项工作；本文没有任何证明步骤或普遍创新性主张依赖其未读内容。

**[TT]** The Omega Institute，公开 `trureturing` 源码档案。检查文件包括 [BernoulliCommonEndpointCharge.lean](https://github.com/the-omega-institute/trureturing/blob/6e318f328d41e2d09b8bbde8b1a95312cac35bd9/D5/S3/Estimation/SequentialDecisionRisk/BernoulliCommonEndpointCharge.lean) 和 [NativeBernoulliFactoryCriticalMoment.lean](https://github.com/the-omega-institute/trureturing/blob/51dca4f1542baa532983864568d6a8ca3470e745/D5/S3/Estimation/SequentialDecisionRisk/NativeBernoulliFactoryCriticalMoment.lean)。这里只作源码检查，未编译这些文件，也未据此推断已经同行评审。其中尖点及对数端点障碍被记录为已有的相邻结果。
