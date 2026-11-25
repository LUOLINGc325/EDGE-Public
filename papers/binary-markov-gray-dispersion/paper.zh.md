# Gray 区间内部二元 Markov 源的操作色散

## 由严格二元噪声余量得到的多项式失真球概率界

**研究稿，2026 年 11 月 25 日。** 本稿提供书面证明与可复现检查，尚未经外部同行评审。本版本暂未附 Lean 源码；本稿不声称已经完成全篇的内核认证。本文件为英文稿的完整中文对照，保留相同的假设、量词、公式编号与证明强度。

### 摘要

本文证明：在经典低失真区域的严格内部，平稳对称二元 Markov 源满足固定码长、超额 Hamming 失真准则下的正态近似。固定转移概率 $0<p<1/2$、失真 $0<D<D_c(p)$ 和超额概率 $0<\epsilon<1$，最优码字数满足

$$
\log_2 M_n^*=n[h_2(p)-h_2(D)]
+\sqrt{n\nu(p)}\,\mathsf Q^{-1}(\epsilon)+O(\log n),
\qquad
\nu(p)=p(1-p)\left[\log_2\frac{1-p}{p}\right]^2.
$$

因此，已有的熵密度逆定理在该区域内具有匹配的操作可达上界。新增的关键是一项有限维概率估计：在 $0<D<d_0<1/2$ 的条件下，只要任意二元随机向量可表示为某个潜在向量叠加强度为 $d_0$ 的独立二元噪声，就能显式构造一个重构分布，使其在源样本周围半径为 $nD$ 的失真球上，赋予至少为源样本概率乘以 $e^{nh(D)}$、再除以一个多项式因子的概率；例外源样本集合的概率至多为 $4/n^2$。该估计不要求潜在向量独立或满足混合条件。证明先分解噪声，再同时给定潜在词和观测词，最后对两个二项随机变量之和使用初等局部概率下界。一个严格正的两状态表示验证了 Markov 源所需的有限块分解。本文不覆盖临界端点及更高失真区域。

## 1. 问题、结论与归属

设 $X_1$ 在 $\{0,1\}$ 上均匀分布，转移翻转量 $X_i\oplus X_{i-1}$、$i\ge2$，是参数为 $p\in(0,1/2)$ 的独立 Bernoulli 随机变量，并且独立于 $X_1$。长度为 $n$ 的确定性代码由一个取值于 $\{1,\ldots,M\}$ 的编码器和一个重构词属于 $\{0,1\}^n$ 的解码器组成。性能准则为

$$
\Pr\{d_H(X^n,\widehat X^n)>nD\}\le\epsilon.
\tag{1}
$$

该不等式保留精确的整数边界：可接受的错误个数至多为 $\lfloor nD\rfloor$。以 $M_n^*(D,\epsilon)$ 表示最小码字数，并令 $R^*(n,D,\epsilon)=n^{-1}\log_2M_n^*$。代码设计者知道这些参数，而且在 $n\to\infty$ 时各参数均保持固定。本文不限制编码器或码本的计算复杂度。

令 $\rho=1-2p$，并定义

$$
D_c(p)=\frac12\left(1-\frac{2\sqrt\rho}{1+\rho}\right)
=\frac12\left(1-\sqrt{1-\left(\frac p{1-p}\right)^2}\right).
\tag{2}
$$

**定理 1（严格内点的操作色散）。** 对任意固定的 $p\in(0,1/2)$、$D\in(0,D_c(p))$ 和 $\epsilon\in(0,1)$，有

$$
R^*(n,D,\epsilon)=h_2(p)-h_2(D)
+\sqrt{\frac{\nu(p)}n}\,\mathsf Q^{-1}(\epsilon)
+O_{p,D,\epsilon}\left(\frac{\log n}{n}\right),
\tag{3}
$$

其中 $h_2$ 是以比特为单位的二元熵，$\mathsf Q$ 是标准正态分布的上尾函数。

本定理针对一条连续、未被独立分块替代的 Markov 路径。在该开区间内，正系数 $\nu(p)$ 与 $D$ 无关。余项对每一组固定参数成立；当 $D\uparrow D_c(p)$、$p$ 趋近其任一端点，或 $\epsilon$ 趋近零或一时，余项常数未必有界。

经典 Gray 公式、有限块反向二元噪声分解和信息方差表达式均为已有结果。Krishnamachari [K26] 的命题 5、命题 10 和第 6 节给出了相关有限块恒等式与匹配的二阶逆界，并将对应的可达性保留为开放问题。本文使用这些已知事实，并在需要处给出显式证明。本文的贡献是严格内点的可达上界，其核心支撑是下文对任意潜在分布统一成立的失真球定理。本文不声称解决 [K26] 中范围更广的全失真猜想。第 8 节给出了与 [DK02]、[OA12]、[O12]、[KV12]、[K17]、[TK26] 的具体比较。

以下证明中，除显式使用下标 2 的记号外，对数均取自然底。记 $h(u)=-u\log u-(1-u)\log(1-u)$。

## 2. 任意相关向量的有限块定理

对 $\{0,1\}^n$ 上的概率分布 $R$，以 $R*B_u^n$ 表示对其各坐标独立地以概率 $u$ 翻转后得到的分布。$R$ 的坐标之间允许任意相关性。定义 $B_D(x)=\{y:d_H(x,y)\le nD\}$。

固定 $0<D<d_0<1/2$，并定义

$$
t=\frac{d_0-D}{1-2D},\qquad
q_0=\frac{tD}{1-d_0},\qquad
q_1=\frac{(1-t)D}{d_0}.
\tag{4}
$$

于是 $0<t<1/2$、$0<q_0<q_1<1$，且

$$
t+D-2tD=d_0,\qquad (1-d_0)q_0+d_0q_1=D.
\tag{5}
$$

令

$$
\eta=\min(q_0,1-q_0,q_1,1-q_1),\quad v=\eta(1-\eta),\quad
N=\left\lceil(4/\eta)^4\right\rceil,
$$
$$
\kappa=2+8/v,\qquad c=\frac{D}{2(1-D)}e^{-1/v},\qquad
L_n=\kappa\log(n+1)+\log(1/c).
\tag{6}
$$

这些常数均为显式给定，所需的正性成立；为简化证明，数值特意取为保守上界。

**定理 2（多项式失真球概率界）。** 对任意整数 $n\ge N$ 以及 $\{0,1\}^n$ 上的任意概率分布 $R$，令

$$
P=R*B_{d_0}^n,\qquad Q=R*B_t^n,\qquad
j(x)=-\log P(x)-nh(D).
\tag{7}
$$

存在集合 $G\subseteq\{0,1\}^n$，满足 $P(G)\ge1-4/n^2$，并且

$$
c(n+1)^{-\kappa}P(x)e^{nh(D)}
\le Q(B_D(x))\le P(x)e^{nh(D)},\qquad x\in G.
\tag{8}
$$

上界对所有 $x$ 均成立。等价地，在 $G$ 上有

$$
j(x)\le-\log Q(B_D(x))\le j(x)+L_n.
\tag{9}
$$

本定理的假设是：在一个严格更大的噪声水平上，存在**精确的有限维分解**。仅有渐近 Shannon 下界取等，并不能在此替代这个假设。分布 $R$ 可以随 $n$ 改变；定理 2 不要求有限维一致性、平稳性或混合性。

## 3. 失真球概率界的证明

### 3.1. 保留全部整数端点的局部估计

设 $B\sim\operatorname{Bin}(m,q)$、$m\ge1$、$q\in(0,1)$，并令整数 $a$ 满足 $0\le a\le m$。记 $r=a/m$。在参数为 $r$ 的二项分布中，$a$ 是一个众数；比较相邻概率即可验证，端点 $a=0,m$ 则对应点质量。因此，该众数处的概率至少为 $1/(m+1)$。将参数从 $r$ 改为 $q$，得到

$$
\Pr\{B=a\}\ge\frac1{m+1}\exp[-m\,\operatorname{kl}(r\Vert q)]
\ge\frac1{m+1}\exp\left[-\frac{(a-mq)^2}{mq(1-q)}\right].
\tag{10}
$$

第二个不等式来自 $\log u\le u-1$，它蕴含
$\operatorname{kl}(r\Vert q)\le(r-q)^2/[q(1-q)]$；连续延拓也覆盖 $r=0,1$。大小为零的一组，其计数以概率一等于零；对这样的组不使用式 (10)。

**引理 3。** 设独立随机变量 $B_i\sim\operatorname{Bin}(n_i,q_i)$、$i=0,1$，满足 $n_0+n_1=n\ge1$，且 $q_i\in[\eta,1-\eta]$。记 $\mu=n_0q_0+n_1q_1$。若整数 $k$ 满足

$$
|k-\mu|+1\le\eta n/2,
\tag{11}
$$

则

$$
\Pr\{B_0+B_1=k\}\ge(n+1)^{-2}
\exp\left[-\frac1v-\frac{2(|k-\mu|+1)^2}{nv}\right].
\tag{12}
$$

**证明。** 以 $s$ 表示较小的一组，以 $\ell$ 表示较大的一组，于是 $n_\ell\ge n/2$。取 $a_s=\lfloor n_sq_s\rfloor$，并令 $a_\ell=k-a_s$。较小组的计数取值可行。较大组满足

$$
|a_\ell-n_\ell q_\ell|\le|k-\mu|+1\le\eta n/2\le\eta n_\ell.
$$

因此 $0\le a_\ell\le n_\ell$。若较小组非空，则式 (10) 给出的指数损失至多为 $1/v$；较大组的指数损失至多为 $2(|k-\mu|+1)^2/(nv)$。将两项下界相乘，并使用 $(n_s+1)(n_\ell+1)\le(n+1)^2$。若 $n_s=0$，则略去其恰为一的因子，仍保留上述较弱的统一下界。所选择的联合计数事件包含于事件 $B_0+B_1=k$，结论成立。∎

### 3.2. 先分解噪声，再作条件化

取相互独立的随机对象 $Z\sim R$、$A\sim\operatorname{Ber}(t)^{\otimes n}$ 与 $E\sim\operatorname{Ber}(D)^{\otimes n}$，定义

$$
Y=Z\oplus A,\qquad X=Y\oplus E,\qquad
S=\sum_iE_i,\qquad K=d_H(Z,X).
\tag{13}
$$

由式 (5)，有 $X\sim P$、$Y\sim Q$，且 $P=Q*B_D^n$。另外，无论 $R$ 如何，
$K=\sum_i(A_i\oplus E_i)\sim\operatorname{Bin}(n,d_0)$。

**同时**给定联合概率为正的 $Z=z$ 和 $X=x$。这些条件逐坐标指定了奇偶约束 $A_i\oplus E_i=z_i\oplus x_i$。由于各对 $(A_i,E_i)$ 原本独立，给定这些条件后的 $E_i$ 仍彼此独立。直接用误差与奇偶值的联合概率除以奇偶值概率，可知：在 $z_i=x_i$ 的坐标上，$E_i=1$ 的条件概率为 $q_0$；在 $z_i\ne x_i$ 的坐标上则为 $q_1$。因此

$$
S\mid(Z=z,X=x)\ \sim\
\operatorname{Bin}(n-K,q_0)+\operatorname{Bin}(K,q_1),
\tag{14}
$$

其中两个随机变量独立，其条件均值为

$$
\mu(z,x)=nD+(q_1-q_0)(K-nd_0).
\tag{15}
$$

这里 $0<q_1-q_0<1$，式 (15) 由恒等式 (5) 得到。两个后验参数及其补数的严格正性，来自 $(A_i,E_i)$ 四种取值均有严格正的概率。本文不声称仅给定 $X$ 后，误差坐标仍然独立。

### 3.3. 将噪声计数尾界转化为典型源样本集合

令 $w=\sqrt{n\log n}$。二项分布的 Hoeffding 界给出

$$
\Pr\{|K-nd_0|>w\}\le2e^{-2w^2/n}=2/n^2.
\tag{16}
$$

为使证明完整，可从 Bernoulli 矩母函数界
$\mathbb E e^{\theta(B-\mathbb EB)}\le e^{\theta^2/8}$ 推出它：其对数矩母函数的二阶导数是指数倾斜参数下的 Bernoulli 方差，至多为 $1/4$，而函数及其一阶导数在零点均为零。随后利用独立性、指数形式的 Markov 不等式，并在 $\theta=4w/n$ 处优化，即得两个单侧尾界。

每个 $x$ 都满足 $P(x)>0$。定义

$$
b(x)=\Pr\{|K-nd_0|>w\mid X=x\},\qquad G=\{x:b(x)\le1/2\}.
$$

由于 $\mathbb E b(X)\le2/n^2$，Markov 不等式给出 $P(G^c)\le4/n^2$。对每个 $x\in G$，$Z$ 的后验分布至少有一半质量落在 $|K-nd_0|\le w$ 上。对这些词对，式 (15) 蕴含 $|\mu-nD|\le w$。

取 $k=\lfloor nD\rfloor$。对上述词对，有
$|k-\mu|+1\le w+2$。显式条件 $n\ge N$ 保证

$$
w+2\le\eta n/2,\qquad w\ge2.
\tag{17}
$$

事实上，当 $n\ge1$ 时，$\log n\le\sqrt n$，因此 $w\le n^{3/4}\le\eta n/4$；同时，$n\ge8/\eta$ 保证 $2\le\eta n/4$。另外，$\eta\le1/2$ 蕴含 $n\ge4096$。应用引理 3 及 $(w+2)^2\le4n\log n$，得到

$$
\Pr\{S=k\mid Z=z,X=x\}\ge e^{-1/v}(n+1)^{-2}n^{-8/v}.
$$

只对后验中上述良好 $z$ 的集合求平均，即得

$$
\Pr\{S=k\mid X=x\}\ge\tfrac12e^{-1/v}(n+1)^{-2}n^{-8/v},\qquad x\in G.
\tag{18}
$$

### 3.4. 将条件球壳概率转化为重构概率

在式 (13) 的联合分布下，将 Bayes 公式应用于精确球壳，得到

$$
Q\{y:d_H(x,y)=k\}
=P(x)\frac{\Pr\{S=k\mid X=x\}}{D^k(1-D)^{n-k}}.
\tag{19}
$$

由于 $-1<k-nD\le0$，有

$$
\frac1{D^k(1-D)^{n-k}}
=\exp\left[nh(D)+(k-nD)\log\frac{1-D}{D}\right]
\ge\frac D{1-D}e^{nh(D)}.
\tag{20}
$$

该球壳包含于 $B_D(x)$。合并式 (18)—(20)，并将 $n^{-8/v}$ 放宽为 $(n+1)^{-8/v}$，便得到式 (8) 的下界。对于上界，球内每个点的二元噪声似然均至少为 $e^{-nh(D)}$，故

$$
P(x)=\sum_yQ(y)D^{d_H(x,y)}(1-D)^{n-d_H(x,y)}
\ge e^{-nh(D)}Q(B_D(x)).
$$

定理 2 得证。∎

## 4. 显式有限块编码推论

**命题 4（具有精确误差预算的随机覆盖）。** 在定理 2 的条件下，对任意实数 $a$，取整数码字数

$$
M=\left\lceil\exp[a+L_n+\log n]\right\rceil
\tag{21}
$$

则存在一个确定性代码，其超额失真概率至多为

$$
\Pr\{j(X)>a\}+4/n^2+e^{-n}.
\tag{22}
$$

**证明。** 从 $Q$ 独立抽取 $M$ 个词。对固定 $x$，没有任何码字落入其失真球的概率为
$(1-Q(B_D(x)))^M\le\exp[-M Q(B_D(x))]$。在 $G\cap\{j\le a\}$ 上，式 (9) 将该概率控制为至多 $e^{-n}$。其余源样本的概率由式 (22) 的前两项控制。因此，至少有一个确定性码本的错误概率不超过平均值。若存在覆盖当前源词的码字，编码器选择其中第一个；否则选择一个固定码字。重复码字不影响结论，因为准则仅要求码字数至多为 $M$。∎

**命题 5（信息谱逆界）。** 对二元立方体上的任意源分布 $P$、任意含 $M$ 个码字的代码以及任意 $\gamma>0$，在 $P$ 的支撑上令 $j(x)=-\log P(x)-nh(D)$，则

$$
\epsilon_{\rm code}\ge
\Pr\{j(X)\ge\log M+\gamma\}-e^{-\gamma}.
\tag{23}
$$

**证明。** 每个半径为 $nD$ 的球至多包含 $e^{nh(D)}$ 个词，因为在参数为 $D$ 的二元噪声分布下，球内每个词的概率至少为 $e^{-nh(D)}$。因此，任何代码成功重构的源词集合，包含于至多由 $M e^{nh(D)}$ 个词组成的集合。式 (23) 中高 $j$ 事件内的每个源词，其概率至多为 $M^{-1}e^{-\gamma-nh(D)}$。所以该事件中成功重构部分的概率至多为 $e^{-\gamma}$。∎

命题 5 是标准的有损信息谱下界；此处给出证明，是为了明确概率不等式的方向与编码模型。对于具有定理 2 所述固定噪声余量的任何分布族，式 (21)—(23) 都提供了有限块操作量与源自信息之间的比较。特别地，只要 $\epsilon-4/n^2-e^{-n}>0$，就可以在该超额概率水平选择源分数的精确分位数作为 $a$。这样得到的最终误差不超过指定的 $\epsilon$，而非仅为 $\epsilon+o(1)$。

## 5. 有限块 Gray 分解的正实现

下面在同一个固定 $d_0\in(D,D_c(p))$ 上，为每个 Markov 块验证定理 2 的假设。这项有限维事实不可缺少；证明不以单独的极限率失真恒等式作为替代。

令 $s=\sqrt\rho$、$z=1-2d_0$、$g=s/z$。定义

$$
C_0=\frac14\begin{pmatrix}1+\rho+2g&1-\rho\\1-\rho&1+\rho-2g\end{pmatrix},\qquad
C_1=\frac14\begin{pmatrix}1+\rho-2g&1-\rho\\1-\rho&1+\rho+2g\end{pmatrix}.
\tag{24}
$$

由于 $d_0<D_c(p)$，所有矩阵元素均严格为正。两矩阵之和为

$$
T=C_0+C_1=\begin{pmatrix}1-p&p\\p&1-p\end{pmatrix}.
\tag{25}
$$

令 $\pi=(1/2,1/2)^\top$，并定义

$$
R_n(y^n)=\boldsymbol1^\top C_{y_n}\cdots C_{y_1}\pi.
\tag{26}
$$

这是一个严格正的概率分布，因为对所有词求和可得 $\boldsymbol1^\top T^n\pi=1$。

为了验证卷积恒等式，将每个带输出标记的矩阵通过二元噪声混合：

$$
\widetilde C_x=(1-d_0)C_x+d_0C_{1-x}.
$$

其表达式正好是将式 (24) 中的 $g$ 替换为 $s$。令
$u_0=(1+s,1-s)^\top$、$u_1=(1-s,1+s)^\top$，则

$$
\widetilde C_x=\tfrac14u_xu_x^\top,\quad
u_x^\top u_x=4(1-p),\quad u_x^\top u_{1-x}=4p,
\quad\boldsymbol1^\top u_x=2,\quad u_x^\top\pi=1.
\tag{27}
$$

在式 (26) 的卷积中展开矩阵乘积，再使用式 (27)，得到

$$
(R_n*B_{d_0}^n)(x^n)
=\boldsymbol1^\top\widetilde C_{x_n}\cdots\widetilde C_{x_1}\pi
=\tfrac12 p^{f(x)}(1-p)^{n-1-f(x)}=P_n(x^n),
\tag{28}
$$

其中 $f(x)$ 统计相邻坐标之间的翻转次数。这证明了对每个 $n\ge1$ 所需的精确分解。

该构造是已有 Gray 分解的一种正实现，本文不将其声称为另一项新的率失真定理。它也给出采样方法：维护一个隐藏状态；当状态为 $i$ 时，以概率 $(C_y)_{ji}$ 联合选择输出 $y$ 和下一状态 $j$。由于 $C_0+C_1$ 的各列和均为一，该方法可在 $O(n)$ 次算术运算内从式 (26) 采样。再叠加强度为 $t$ 的独立噪声，便可从定理 2 的重构分布 $Q_n$ 采样。这并不意味着指数规模的随机码本及其覆盖编码器可以高效实现。

## 6. 正态近似的证明

源的翻转次数 $F_n=f(X^n)$ 精确服从 $\operatorname{Bin}(n-1,p)$。因此，式 (7) 中的分数满足

$$
j_n(X^n)=nR+\beta+a_p[F_n-(n-1)p],
\tag{29}
$$
$$
R=h(p)-h(D),\quad\beta=\log2-h(p),\quad
a_p=\log\frac{1-p}{p}>0.
$$

其均值为 $m_n=nR+\beta$，方差为
$\sigma_n^2=(n-1)v_p$，其中 $v_p=p(1-p)a_p^2>0$。

对独立 Bernoulli 随机变量之和应用经典 Berry–Esseen 不等式 [BE11]，可得一个有限常数 $B_p$，使所有 $n\ge2$ 均满足

$$
\sup_u\left|\Pr\{(j_n-m_n)/\sigma_n\le u\}-\Phi(u)\right|
\le B_p/\sqrt{n-1}.
\tag{30}
$$

取左极限并利用 $\Phi$ 的连续性，可得到分别使用 $>$ 或 $\ge$ 的相应单侧尾界。因此，格点原子不会带来更大的误差阶。

固定 $z_\epsilon=\mathsf Q^{-1}(\epsilon)$。由于标准正态密度在该有限点严格为正，式 (30) 蕴含：可以选择一个常数 $A_{p,\epsilon}$，使得

$$
a_n=m_n+\sigma_nz_\epsilon+A_{p,\epsilon}
$$

对所有充分大的 $n$ 满足 $\Pr\{j_n>a_n\}\le\epsilon-4/n^2-e^{-n}$。具体地，在 $z_\epsilon$ 附近取一个正态密度至少为 $b_\epsilon>0$ 的邻域；将未标准化的阈值增加 $A$，会使正态上尾至少下降 $b_\epsilon A/\sigma_n$。选择足够大的 $A$，使该下降量超过 $B_p/\sqrt{n-1}$，并留下一个正的 $n^{-1/2}$ 量级余量；当 $n$ 充分大时，该余量也超过 $4/n^2+e^{-n}$。

由命题 4，存在错误概率不超过 $\epsilon$ 的代码，且

$$
\log M\le m_n+\sigma_nz_\epsilon+L_n+\log n+O(1)
=nR+\sqrt{nv_p}z_\epsilon+O_{p,D,\epsilon}(\log n).
\tag{31}
$$

一旦式 (21) 中的指数非负，向上取整造成的对数变化至多为 $\log2$；由于 $D<D_c(p)<p$ 且 $R>0$，指数最终必为正。

对于逆界，在式 (23) 中取 $\gamma=\log n$。任何错误概率不超过 $\epsilon$ 的代码都必须满足

$$
\mathsf Q\left(\frac{\log M+\log n-m_n}{\sigma_n}\right)
\le\epsilon+n^{-1}+B_p/\sqrt{n-1}.
$$

正态上尾的反函数在固定 $\epsilon$ 附近连续可微。因此

$$
\log M\ge m_n+\sigma_nz_\epsilon-\log n-O_{p,\epsilon}(1)
=nR+\sqrt{nv_p}z_\epsilon-O_{p,\epsilon}(\log n).
\tag{32}
$$

结合式 (31) 与式 (32)，再除以 $n\log2$，即得定理 1。∎

## 7. 复现、适用范围与未解决情形

随附的精确检查脚本使用有理数运算，在明确列出的有限实例上验证两状态构造、归一化、三项噪声卷积恒等式、条件乘积分布公式以及二项分布众数下界。另一项动态规划沿采样的 Markov 路径计算实际重构球概率。这些检查用于发现实现及代数错误；所有参数和块长下的结论仍由上述带量词的证明建立。

例如，$p=4/9$ 时有 $\rho=1/9$ 和 $D_c=1/5$。选择 $D=1/10$、$d_0=9/50$，得到 $t=1/10$、$q_0=1/82$、$q_1=1/2$，而且带标记的矩阵具有精确有理数元素。这给出了满足全部严格假设的非退化实例。由于常数很大，本文不将这些界解释为短块长下实用的压缩性能保证。

本证明不解决 $D=D_c(p)$ 的情形：在该端点，同一分解区域内已不存在更大的可用 $d_0$。本文也不解决更高失真区域的色散，不优化 $\log n$ 项的系数，不提供多项式时间编码器，不处理未知 $p$，也不建立对随 $n$ 变化的参数序列一致成立的界。对一个有相关性的固定分布，只有先验证精确噪声余量假设，才能应用定理 2。

交付的 Lean 文件覆盖有限核代数中明确列举的一部分。形式概率论、局部概率下界、覆盖论证和渐近论证尚无完整形式化证明。Python 检查和未编译的 Lean 源码均不被称为端到端形式化证明。

## 8. 相关工作与新颖性边界

[K26] 是直接对应的目标文献：其有限块方差与单路径逆界识别出候选二阶系数，第 6 节明确指出尚缺失的失真球概率估计。定理 2 在严格低失真区域以 $O(\log n)$ 修正项补足这一估计。原文的全失真问题仍然具有更广范围。

一个尤其接近的先行结果是 Oğuz 的博士论文 [O12] 第 3.8 节、定理 3.8.3：它已在更一般的平衡失真设定中，结合反向噪声分解、Bayes 公式和后验典型集，得到修正项为 $O(\sqrt n\log n)$ 的球信息上界。这一量级过大，无法识别 $\sqrt n$ 尺度的色散系数。本文不将上述三项已有要素声称为创新。定理 2 增加的固定噪声余量以及精确球壳局部估计，在二元模型中将修正项压缩到 $O(\log n)$。

[DK02] 的广义渐近等分性质是失真球分析的重要基础。本比较涉及的二阶结果使用乘积重构分布，其相关重构分布扩展给出的是一阶信息，不能直接推出式 (8)。[OA12] 在 Shannon 下界取等时，为有记忆源给出熵密度与编码方差下界。[KV12] 提供一般非渐近编码原理和无记忆源色散框架。[K17] 刻画 Shannon 下界精确取等的条件，其陈述的固定失真正态近似位于无记忆设定。[TK26] 处理相互独立但未必同分布的坐标，以及保持失真的高斯变换。虽然 Markov 翻转量彼此独立，变换到翻转坐标后，原始 Hamming 失真并不会变成这些坐标上的逐坐标失真。

我们也核查了 Le–Tan–Motani [LTM14] 的第 VI 节。该节展示的平稳单字母中心项和单字母分数，不能替代本文的路径分数：当边信息为常数、二元边缘分布对称时，那些表达式分别给出 $\log2-h(D)$ 和零分数方差；而本文式 (28)—(29) 给出 $h(p)-h(D)$ 和严格正的方差。因此，上述特化不能提供本文所证明的定理。此处比较仅限上述特化；这里不对该文其余结论作广泛评价。

所使用的集中不等式、二元噪声合成、二项类型下界、随机编码和 Berry–Esseen 定理均为标准工具。在实际核查的文献范围内，本文仅对任意相关分布的噪声余量估计及其严格 Gray 区间操作结论提出新增贡献主张；不声称拥有全球优先权认证或外部发表等级背书。文献比较以正文所述来源为限。

## 参考文献

- **[K26]** Bhaskar Krishnamachari, *A Block Hierarchy for Rate-Distortion and Dispersion of Binary Markov Sources*, arXiv:2603.07435v4，2026 年 11 月 19 日。[官方 PDF](https://arxiv.org/pdf/2603.07435v4)。重点参见第 4.2、5.3、6 节。该文已注明 Gray 的经典工作；本文所需有限块恒等式的自足证明见第 5 节。
- **[DK02]** Amir Dembo and Ioannis Kontoyiannis, *Source Coding, Large Deviations, and Approximate Pattern Matching*, IEEE Transactions on Information Theory 48(6), 1590–1615, 2002。[预印本](https://arxiv.org/abs/math/0103007)。
- **[OA12]** Barlas Oğuz and Venkat Anantharam, *Pointwise Lossy Source Coding Theorem for Sources with Memory*, ISIT 2012。[DOI](https://doi.org/10.1109/ISIT.2012.6284209)。相关作者博士论文单列为 [O12]。
- **[O12]** Barlas Oğuz, *Long Range Dependent Models in Information Theory*, PhD dissertation, University of California, Berkeley, 2012；技术报告 UCB/EECS-2012-204，2012 年 10 月 23 日。重点参见第 3.8 节、定理 3.8.3、引理 3.8.4，印刷页码 80–84。[官方报告](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2012/Archive/EECS-2012-204.pdf)。
- **[KV12]** Victoria Kostina and Sergio Verdú, *Fixed-Length Lossy Compression in the Finite Blocklength Regime*, IEEE Transactions on Information Theory 58(6), 3309–3338, 2012。[预印本](https://arxiv.org/abs/1102.3944)。
- **[K17]** Victoria Kostina, *Data Compression with Low Distortion and Finite Blocklength*, IEEE Transactions on Information Theory 63(7), 4268–4285, 2017。[预印本](https://arxiv.org/abs/1510.02190)。
- **[TK26]** Eyyüp Taşçı and Victoria Kostina, *Dispersion of Gaussian Sources with Memory and an Extension to Abstract Sources*, arXiv:2602.09176v2，2026 年 6 月 26 日。[官方版本记录](https://arxiv.org/abs/2602.09176v2)。作者拼写采用该版本 PDF 首页的变音符号形式；arXiv 网页元数据使用 ASCII 形式 Eyyup Tasci。
- **[LTM14]** Sy-Quoc Le, Vincent Y. F. Tan, and Mehul Motani, *Second-Order Coding Rates for Conditional Rate-Distortion*, arXiv:1410.2687v1，2014 年 10 月 10 日。[官方 PDF](https://arxiv.org/pdf/1410.2687v1)，第 VI 节、式 (75)—(76)。此处仅比较适用范围，该文不是本文证明的前提。
- **[BE11]** Irina Shevtsova, *On the absolute constants in the Berry–Esseen type inequalities for identically distributed summands*, arXiv:1111.6554v1，2011 年 11 月 28 日。[官方版本记录](https://arxiv.org/abs/1111.6554v1)。本文只使用具有有限常数的经典 Berry–Esseen 不等式。
