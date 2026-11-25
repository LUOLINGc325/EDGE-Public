# 未知尺度非自适应一比特均值估计的尖锐样本复杂度

AI 辅助研究稿

2026 年 11 月 25 日

# 摘要

每个独立样本只能发送一比特、所有查询必须预先确定，而真实标准差只知道落在区间 $[s,S]$ 内时，准确估计均值需要多少样本？本文对一维有限方差全类给出匹配上下界。设已知 $0<s\le S\le\lambda$，分布均值满足 $|\mu|\le\lambda$，要求以至少 $1-\delta$ 的概率达到真实尺度相对误差 $r\sigma$。当 $0<r\le1/64$、$0<\delta\le1/16$ 时，最优样本数在绝对常数因子内等于

$$
\boxed{\log(1+\lambda/s)
+\frac{\log(S/s)+\log(1/r)}{r^2}\log(1/\delta).}
$$

上界将编码粗定位、周期二进制位定位和统一二进尺度精细估计结合起来。关键在于用真实二阶矩同时控制所有尺度的方差，不为每个尺度猜测重复支付完整精度成本。下界利用高斯热流中的二元熵耗散，得到任意固定二元通道跨位置和尺度的信息预算，再通过有限位移亲和度和随机种子的联合 transcript 转成高置信度下界。镜像重尾分布对补足精确相同方差的精度下界，因此包括 $S=s$ 端点。

本文是 AI 辅助研究稿。书面证明不等于外部同行评审或全球首创认证。全文 Lean 形式化仍待完成；单独列出的确定性检查点不代表主定理已由 Lean 内核验证。

# 1. 模型与主定理

记 $\mathcal P(\lambda,s,S)$ 为实数轴上所有具有有限二阶矩、均值 $|\mu(P)|\le\lambda$、**真实**标准差 $s\le\sigma(P)\le S$ 的概率分布。估计误差按 $r\sigma(P)$ 衡量，不是按上界 $rS$ 衡量。允许原子、非对称和无界支持，不要求密度存在。

一个具有 $n$ 个节点的协议使用 $X_1,\ldots,X_n\overset{\rm iid}{\sim}P$。分布无关的公共随机种子为 $U$。在观察任何响应前固定全部联合可测编码器 $Q_i(U,\cdot):\mathbb R\to\{0,1\}$，节点 $i$ 发送 $Y_i=Q_i(U,X_i)$。解码器根据 $U$ 和全部比特产生 $\widehat\mu$，也可使用独立随机性。下界可以把所有私有随机性一并揭示给解码者；这只会增加可用信息，不削弱下界。

样本数是事先确定的整数，不包含随机停止。各节点的查询可以不同、可以共用随机种子。本模型只计样本上行的一比特消息；不计下行查询描述、共享随机性、实数计算精度或运行时间。它不是固定阈值数量、固定区间数量或计算复杂度的最优性结论。

令 $N^*(\lambda,s,S,r,\delta)$ 是满足

$$
\sup_{P\in\mathcal P(\lambda,s,S)}
\Pr_P\{|\widehat\mu-\mu(P)|>r\sigma(P)\}\le\delta
\tag{1}
$$

所需的最小固定样本数。

**定理 1。** 存在与全部参数无关的绝对常数 $0<c<C<\infty$，使得当

$$
0<s\le S\le\lambda,\quad 0<r\le1/64,\quad 0<\delta\le1/16
$$

时，有

$$
c\Phi\le N^*(\lambda,s,S,r,\delta)\le C\Phi,
\qquad
\Phi=\log(1+\lambda/s)
+r^{-2}[\log(S/s)+\log(1/r)]\log(1/\delta).
\tag{2}
$$

这里无下标的对数为自然对数。上界中每个查询的取值一集合都是有限个区间的并；裁剪后允许半无限区间。下界适用于所有可测二元查询，包含任意分布无关的共享随机化。定理包括 $S=s$ 与 $S=\lambda$。

三个加法项分别表示全局位置、有限方差一比特精度、未知真实尺度适应的代价。预先登记的课题是 $\delta=1/16$ 的同一命题；完整置信度结论是在相同模型下证明的加强，没有更换原题的量词或误差标准。

# 2. 与近邻工作的关系

Lau–Scarlett 的 [1, Theorem 15] 已有未知真实尺度、相对误差的几何尺度网格方案；[2] 已解决已知矩尺度下的最优非自适应一比特估计。随机格库、随机符号隔离、在解码阶段使用中心、过滤中心附近格子、编码定位和分层估计均有明确前驱。本文使用并重新核对这些机制，不将它们分别包装为首次发明。

Cai–Wei [3] 已研究高斯未知方差适应的通信代价，其正式论文第 7.1 节已经跨位置与尺度积分 Hellinger 量，是下界必须承认的强前驱。其通信与相对均方误差效率目标不同，所读结论未直接给出本文固定一比特、有限误差、高置信度全参数率。Kumar–Vatedka [4] 不仅研究位置尺度族，也在第 3.4 节给出带额外正则条件的非参数多阈值扩展，不能把整篇论文误称为纯参数研究。

本文候选原创增量是定理 1 的**完整匹配率**，尤其是跨未知真实尺度共享方差预算，以及证明 $r^{-2}\log(S/s)\log(1/\delta)$ 必要性的有限尺度熵预算。精确方差镜像分布是对 [1] 硬分布构造的修正。已知尺度下“是否需要交互”的原问题已有答案，不属于本文贡献。

文献 [5,6] 的官方摘要、作者材料或后续原始论文中的比较已核查，但本次未取得两篇全文。查新是范围受限的比较，不能据此声称全世界不存在相同结论。详见成果包的查新记录。

补充查新发现 Dewasurendra 的作者稿 [8] 也用预发 modulo 字典和二进尺度整体尾矩预算达到已知尺度最优率。因此周期编码和整体尾预算本身都不单独计为本文原创。其显示的基础周期使用已知尺度；本文比较的增量是未知真实尺度区间上的完整率 (2) 及其匹配适应下界。

# 3. 预发查询的高置信度定位

本节证明：无需知道真实 $\sigma$，可以用

$$
O\!\left(\log(1+\lambda/S)
+[1+\log(S/s)]\log(2/\eta)\right)
\tag{3}
$$

个预发一比特查询得到 $C\in[-\lambda,\lambda]$，且
$\Pr(|C-\mu|>32\sigma)\le\eta$。三个数据批次的编码均事先固定，只有解码有先后顺序。

定义裁剪 $\pi(x)=\max\{-\lambda,\min\{x,\lambda\}\}$。因为 $\mu\in[-\lambda,\lambda]$，有
$|\pi(x)-\mu|\le|x-\mu|$。裁剪一般改变均值；下文只使用距离收缩，从未假定裁剪保持均值。

## 3.1 编码粗定位

取 $w=3S$、$N=\lceil2\lambda/w\rceil\ge1$，定义

$$
b(x)=\min\left\{N-1,\left\lfloor\frac{\pi(x)+\lambda}{w}\right\rfloor\right\},
\qquad c_j=\pi(-\lambda+(j+1/2)w).
$$

最后一个箱包含右端点 $\lambda$。每个查询 $t$ 生成独立公平码位 $W_{t,0},\ldots,W_{t,N-1}$，不同的行及样本相互独立，发送 $Y_t=W_{t,b(X_t)}$。解码时计算所有候选箱的平均不匹配分数

$$
H_j=n_c^{-1}\sum_{t=1}^{n_c}{\bf1}\{Y_t\ne W_{t,j}\},
$$

选择分数最小的箱；并列时采用固定规则。

设 $i=b(\mu)$，邻近箱集合为 $\mathcal S=\{i-1,i,i+1\}\cap\{0,\ldots,N-1\}$。如果样本不在这些箱中，则 $|\pi(X)-\mu|\ge w$。因此由切比雪夫不等式，远箱总概率至多 $1/9$。某个近箱 $j_*$ 的质量至少 $8/27$，而每个远箱的质量至多 $1/9$。若 $p_j=\Pr(b(X)=j)$，则

$$
\mathbb E{\bf1}\{Y_t\ne W_{t,j}\}=(1-p_j)/2.
$$

这是因为样本落在候选箱时必然匹配，否则两个公平独立码位不匹配的概率为 $1/2$。故锚点箱的分数均值至多 $19/54$，远箱至少 $4/9$。阈值 $43/108$ 距二者均为 $5/108$。对每个固定候选，行之间独立，Hoeffding 不等式和并集界给出：当

$$
n_c=\left\lceil\frac{5832}{25}\log\frac{N+1}{\eta_0}\right\rceil
\tag{4}
$$

时，以至少 $1-\eta_0$ 的概率，任何最小分数箱都在 $\mathcal S$ 中。近箱的中心距均值至多 $3w/2$，裁剪只改善这一距离，因此输出 $c_0$ 满足

$$
\Pr(|c_0-\mu|>C_0S)\le\eta_0,\qquad C_0=9/2.
\tag{5}
$$

短的最后一个箱、均值恰在端点、只有一个箱的情形都遵守同一证明。

## 3.2 周期二进制位查询

取

$$
L_c=\left\lceil\log_2\frac{256(C_0+1)S}{s}\right\rceil,
\quad M=2^{L_c},\quad D=Ms,\quad \ell_j=2^js.
$$

对整数 $z$ 用欧几里得余数 $[z]_M=z-M\lfloor z/M\rfloor\in\{0,\ldots,M-1\}$；其第 $j$ 位记为 $b_j$。取 $U\sim\operatorname{Unif}[0,D)$，节点 $j=0,\ldots,L_c-1$ 用独立新样本发送

$$
B_j=b_j\left(\left[\left\lfloor\frac{\pi(X_j)+U}{s}\right\rfloor\right]_M\right).
$$

汇总 $V=\sum_j2^jB_j$，令 $a=sV-U$。查询不依赖 $c_0$；解码时才在 $a+D\mathbb Z$ 中选择最靠近 $c_0$ 的点，即

$$
\widehat k=\left\lfloor\frac{c_0-a}{D}+\frac12\right\rfloor,
\qquad C_U=\pi(a+D\widehat k).
\tag{6}
$$

对真实均值定义 $z_\mu=[\lfloor(\mu+U)/s\rfloor]_M$。第 $j$ 位是周期为 $2\ell_j$ 的方波，此周期整除 $D$。将输入平移 $d$ 后，方波改变的比例至多 $\min\{1,|d|/\ell_j\}$：当 $|d|\le\ell_j$ 时，一个周期的两处边界各贡献长度 $|d|$；更大位移用概率至多一即可。因此

$$
\Pr(B_j\ne b_j(z_\mu))
\le\frac{\mathbb E|\pi(X)-\mu|}{\ell_j}
\le\frac{\sigma}{\ell_j}.
\tag{7}
$$

最后一步为 Cauchy–Schwarz。负数与周期跨界都由 floor 和欧几里得余数的定义覆盖。

令 $q$ 为满足 $\ell_q\ge16\sigma$ 的最小指标。因 $D/2\ge128(C_0+1)S$，该指标存在，且 $\ell_q<32\sigma$。所有高位 $j\ge q$ 出错的并集概率至多
$\sum_{j\ge q}\sigma/\ell_j\le1/8$，不需要位错误之间独立。

若高位一致，则 $|V-z_\mu|\le2^q-1$。写
$\lfloor(\mu+U)/s\rfloor=z_\mu+kM$，并令
$f=\mu+U-s(z_\mu+kM)\in[0,s)$。于是某个实际的提升值满足

$$
a+kD-\mu=s(V-z_\mu)-f,
\qquad |a+kD-\mu|<\ell_q<32\sigma.
\tag{8}
$$

在粗定位成功事件上，它距 $c_0$ 小于 $(C_0+32)S<D/2$，故必为唯一最近提升值，式 (6) 一定选中它。裁剪后仍有 $|C_U-\mu|<32\sigma$。周期批次与粗定位独立，所以对每个成功的固定 $c_0$，单块失败概率至多 $1/8$。

## 3.3 置信度与成本

取 $b_c$ 个相互独立的周期块，每块有独立平移和新样本，共享已解码的 $c_0$，最后取中位数。条件于任意成功的 $c_0$，块之间独立，坏中位数概率至多 $\exp(-9b_c/32)$。令 $\eta_0=\eta/2$，$b_c$ 为不小于 $4\log(2/\eta)$ 的最小正奇数，则总失败概率至多 $\eta$，样本总数恰为 $n_c+b_cL_c$，得到式 (3)。全部码矩阵、周期查询、平移和样本分配都预先生成。解码顺序不构成查询自适应。

# 4. 一个覆盖所有可能尺度的精细估计查询库

现在给定独立定位 transcript 产生的 $C\in[-\lambda,\lambda]$，满足
$\Pr(|C-\mu|\le32\sigma)\ge1-\delta/2$。**定位的全部样本与随机种子，必须与精细估计的全部样本与随机种子独立。** 本节的查询只使用 $s,S,\lambda,r,\delta$，仅解码器使用实现值 $c$。

设 $K=1+32^2=1025$、$A=2304$、$a=s$，取

$$
\ell_i=2^ia,\quad
m=\left\lceil\log_2\frac{4KS}{ra}\right\rceil,
\quad L=\ell_m,\quad
n_0=\left\lceil\frac{128AK}{r^2}\right\rceil.
\tag{9}
$$

于是 $4KS/r\le L<8KS/r$。每层的完整半开网格为
$\mathcal D_i=\{[j\ell_i,(j+1)\ell_i):j\in\mathbb Z\}$，预设有限格库

$$
\mathcal B_i=\{J\in\mathcal D_i:
J\cap[-\lambda-3\ell_i,\lambda+3\ell_i]\ne\varnothing\}.
$$

其格数至多 $2\lambda/a+8$。样本可以落在格库之外，相应查询返回零；这里没有暗加支持有界假设。

## 4.1 解码器选出的覆盖

固定 $c\in[-\lambda,\lambda]$。称二进格 $J$ 合格，如果其长度不超过 $\operatorname{dist}(c,J)$。对每个与闭区间 $[c-L,c+L]$ 相交的最细格，若它不合格就保留；否则选择其**最粗合格祖先**。去重得到 $\mathcal W(c,L)$，长度为 $\ell_i$ 的子集记为 $\mathcal W_i$。

这个定义确实有限。每个祖先都包含截断窗中的一点，距 $c$ 至多 $L$，故合格祖先长度至多 $L$。一旦祖先不合格，更大的祖先距离只会减小、长度只会增加，也不合格。选出的合格格的父格必不合格。

不同二进格不交或包含。若两个不同的合格选格包含，则较小者不是其来源最细格的最粗合格祖先，矛盾。最细不合格格不可能包含在合格祖先内。因此选格两两不交，并覆盖整个闭窗，连同端点原子。

对合格选格，父格不合格意味着

$$
\ell_i\le\operatorname{dist}(c,J)<3\ell_i.
\tag{10}
$$

原因是父格距 $c$ 小于 $2\ell_i$，孩子距父格最多增加 $\ell_i$。因此选格的两个端点距 $c$ 都小于 $4\ell_i$。最细不合格格的端点距离更小，小于 $2a$。每层至多九个选格，每个都在预设格库中。前者来自长度 $8\ell_i$ 的邻域至多接触九个网格，后者来自选格与 $(c-3\ell_i,c+3\ell_i)$ 相交。

## 4.2 过滤格、随机切分与一比特响应

令 $\mathcal F_0=\varnothing$；对 $i\ge1$ 定义
$\mathcal F_i(c)=\{J\in\mathcal B_i:\operatorname{dist}(c,J)<\ell_i\}$。若 $J=[j\ell_i,(j+1)\ell_i)$，这一条件等价于
$c/\ell_i-2<j<c/\ell_i+1$，所以至多三个过滤格。式 (10) 保证 $\mathcal W_i$ 与 $\mathcal F_i$ 不交。

每层、每次重复、左右两个方向，都使用独立样本和独立种子。一个查询的种子由 $\zeta\sim\operatorname{Unif}[0,1]$ 和各格独立公平符号 $\varepsilon_J\in\{-1,1\}$ 组成。对 $J=[u_J,v_J)$ 定义

$$
A_J^{\rm L}=[u_J,u_J+\zeta\ell_i),\qquad
A_J^{\rm R}=[u_J+\zeta\ell_i,v_J).
$$

方向 $d$ 的查询是 $Q^d(x)={\bf1}\{x\in\bigcup_{\varepsilon_J=1}A_J^d\}$。它与 $c$ 完全无关。

解码时定义

$$
H_i^d(c)={\bf1}\{\varepsilon_J^d=-1\text{ for all }J\in\mathcal F_i(c)\},
\quad p_i(c)=2^{-|\mathcal F_i(c)|}\ge1/8,
$$

并取端点权重 $w_J^{\rm L}=u_J-c$、$w_J^{\rm R}=v_J-c$，输出中间变量

$$
V_i^d(c)=\frac{2H_i^d(c)Y_i^d}{p_i(c)}
\sum_{J\in\mathcal W_i(c,L)}w_J^d\varepsilon_J^d.
\tag{11}
$$

这是解码过滤，不会根据过滤结果追加样本。所有选择都是 $c$ 的有限 Borel 条件，故解码器可测。

# 5. 精细估计的矩、尾部与置信度

## 5.1 无偏矩恒等式及原子

固定一个样本值 $x$ 与切分 $\zeta$。候选半格互不交，至多一个候选格 $J_*$ 包含它。若没有，则响应为零。若 $J_*\in\mathcal F_i$，过滤事件 $H=1$ 强制其符号为负，故 $HY=0$。否则 $Y=(1+\varepsilon_{J_*})/2$，过滤符号与选格符号独立，且 $\mathcal F_i\cap\mathcal W_i=\varnothing$，所以对 $J\in\mathcal W_i$，

$$
\mathbb E_\varepsilon[(2H/p)Y\varepsilon_J\mid x,\zeta]
=\mathbb E_\varepsilon[(1+\varepsilon_{J_*})\varepsilon_J]
={\bf1}\{J=J_*\}.
$$

对 $x\in J=[u,v)$，均匀切分满足
$\Pr(x\in A_J^{\rm L})=(v-x)/(v-u)$、
$\Pr(x\in A_J^{\rm R})=(x-u)/(v-u)$。端点权重的恒等式

$$
(u-c)\frac{v-x}{v-u}+(v-c)\frac{x-u}{v-u}=x-c
$$

因此给出

$$
\mathbb E[V_i^{\rm L}(c)+V_i^{\rm R}(c)]
=\sum_{J\in\mathcal W_i}\mathbb E[(X-c){\bf1}_{\{X\in J\}}].
\tag{12}
$$

所有变量在每个固定有限格库中有界，取期望合法。原子也适用：左端点的左半格概率为一；右端点归入下一格；随机切分的单点边界是零概率事件；闭窗两端的最细格均在覆盖中。等距阈值格不被过滤，后文的尾事件使用“$\ge$”保留等号。

## 5.2 局部尾二阶矩

记 $T=\sum_{J\in\mathcal W_i}w_J\varepsilon_J$。若 $x$ 位于未过滤候选格 $J_*$，则

$$
\mathbb E_\varepsilon[V^2\mid x,\zeta]
=\frac4p\mathbb E_\varepsilon\left[T^2\frac{1+\varepsilon_{J_*}}2\right]
=\frac2p\sum_{J\in\mathcal W_i}w_J^2.
$$

第二个等号即使 $J_*$ 不属于选格也成立：$\mathbb ET^2$ 中交叉项为零，$\mathbb E(T^2\varepsilon_{J_*})$ 的每一项都含某个奇数次独立公平符号，因而为零。其余候选情形二阶矩为零。又 $p\ge1/8$、选格至多九个、端点权重绝对值小于 $4\ell_i$，故

$$
\operatorname{Var}(V_i^d)
\le\mathbb E[(V_i^d)^2]
\le A\ell_i^2\tau_i(c),\quad A=2304,
\tag{13}
$$

其中 $\tau_0=1$，$i\ge1$ 时 $\tau_i(c)=\Pr(|X-c|\ge\ell_i)$。这是因为非零响应通过过滤后，样本必落在距中心至少 $\ell_i$ 的格中。

## 5.3 合并尺度，而非逐层使用 Markov 界

对任意 $z\in\mathbb R$ 与有限层数，

$$
\sum_{i=1}^m\ell_i^2{\bf1}_{\{|z|\ge\ell_i\}}
\le\frac43z^2.
\tag{14}
$$

若没有命中层，显然成立。否则令 $j$ 为命中的最大层；命中层构成初始段，平方尺度的几何和至多 $\frac43\ell_j^2\le\frac43z^2$。取有限和的期望，得到

$$
\sum_{i=1}^m\ell_i^2\Pr(|X-c|\ge\ell_i)
\le\frac43\mathbb E(X-c)^2.
\tag{15}
$$

这一整体尾和界正是避免额外层数因子的地方；先给每层各套一个 Markov 界再相加，会丢失该结构。

条件于成功定位及其实现值 $c$，独立性给出

$$
M_2(c)=\mathbb E(X-c)^2=\sigma^2+(\mu-c)^2\le K\sigma^2.
$$

选格的并 $\mathcal U$ 覆盖 $[c-L,c+L]$，故式 (12) 的截断偏差满足

$$
\left|\mathbb E[(X-c){\bf1}_{\{X\in\mathcal U\}}]-(\mu-c)\right|
\le\mathbb E[|X-c|{\bf1}_{\{|X-c|>L\}}]
\le\frac{M_2(c)}L\le\frac{r\sigma}{4}.
\tag{16}
$$

这里用逐点不等式 $|z|{\bf1}_{\{|z|>L\}}\le z^2/L$，以及 $L\ge4KS/r$、$\sigma\le S$。覆盖在截断窗之外可以不对称，因为被遗漏的部分仍在尾部。

一个精细估计块为

$$
\widehat\mu_h=c+\sum_{i=0}^m\frac1{n_0}
\sum_{t=1}^{n_0}(V_{h,i,t}^{\rm L}+V_{h,i,t}^{\rm R}).
$$

条件于 $c$，不同层、重复与方向都独立，由式 (13)--(15)，

$$
\begin{aligned}
\operatorname{Var}(\widehat\mu_h\mid c)
&\le\frac{2A}{n_0}\left[s^2+\frac43M_2(c)\right]\\
&\le\frac{14AK}{3n_0}\sigma^2
\le\frac7{192}r^2\sigma^2.
\end{aligned}
\tag{17}
$$

偏差至多 $r\sigma/4$，故切比雪夫不等式在剩余裕量 $3r\sigma/4$ 上给出单块失败概率至多 $7/108<1/8$。取 $B$ 个独立块的中位数，其中 $B$ 为不小于 $8\log(2/\delta)$ 的最小正奇数。条件于成功的 $c$，中位数失败概率至多 $\exp(-9B/32)\le\delta/2$。

定位调用第 3 节时令 $\eta=\delta/2$。再加入其失败概率，即得总失败概率至多 $\delta$。精细估计恰使用 $2(m+1)n_0B$ 个一比特样本，因此总成本为

$$
O\!\left(\log(1+\lambda/S)
+[1+\log(S/s)]\log(4/\delta)
+r^{-2}[1+\log(S/s)+\log(1/r)]\log(2/\delta)\right).
$$

定理的参数区间内，$\log(1/r)$ 吸收常数一，其余置信度对数均与 $\log(1/\delta)$ 同阶，且 $s\le S$。上式不超过 $C\Phi$。这证明上界。显式常数为便于验证而取宽松值，不代表实用最小样本量。

# 6. 精确相同方差下的精度与位置下界

## 6.1 镜像重尾分布

取 $a=2rs$、$\tau=\sqrt{s^2+a^2}$，以及

$$
M=\left\lfloor\log_2\frac{\tau}{2a}\right\rfloor,\qquad
x_j=2^j\tau,\quad q_j=\frac1{2M4^j},\quad d_j=\frac{a}{2Mx_j}
\quad(1\le j\le M).
$$

对 $r\le1/8$，有 $M\ge1$，并且 $d_j/q_j=a2^j/\tau\le1/2$。定义 $P_+$ 在 $+x_j,-x_j$ 的质量分别为 $q_j+d_j,q_j-d_j$；$P_-$ 对调二者。共同的剩余质量
$p_0=1-2\sum_jq_j\ge1-1/(3M)\ge2/3$ 放在零点。于是它们是合法分布，满足

$$
\mathbb E_{P_\pm}X=\pm a,\quad
\mathbb E_{P_\pm}X^2=\tau^2,\quad
\operatorname{Var}_{P_\pm}(X)=\tau^2-a^2=s^2.
\tag{18}
$$

两个均值均在允许范围内，半径 $rs$ 的准确区间分离且位于零的两侧。这与“给两分布贴同一个方差上界标签”不同，真实方差确切相等。

## 6.2 任意一比特查询的 KL 预算

对任意可测集合 $A$，令 $p=P_+(A)$、$q=P_-(A)$。补集保持二元 KL 不变，故可设 $q\le1/2$。零点质量至少 $2/3$，所以 $0\notin A$。若集合不包含支持点，则 KL 为零。否则取最小命中层 $j_*$，则

$$
q\ge q_{j_*}/2,\qquad
|p-q|\le2\sum_{j\ge j_*}d_j
\le\frac{2a}{M\tau}2^{-j_*}.
$$

由二元 KL 的卡方上界，

$$
\operatorname{kl}(p\Vert q)
\le\frac{(p-q)^2}{q(1-q)}
\le\frac{4(p-q)^2}{q_{j_*}}
\le\frac{32a^2}{M\tau^2}
\le\frac{128r^2}{M}.
\tag{19}
$$

把算法种子加入 transcript；即使查询自适应，条件于过去响应后，下一查询是固定可测集合，新样本仍服从 $P_+$ 或 $P_-$。KL 链式法则给出总 KL 至多 $128nr^2/M$。

成功均值估计通过符号给出两类错误均不超过 $\delta$ 的检验。数据处理和二元 KL 的单调性给出

$$
\frac{128nr^2}{M}
\ge\operatorname{kl}(1-\delta\Vert\delta)
=(1-2\delta)\log\frac{1-\delta}{\delta}
\ge\frac14\log(1/\delta),\quad \delta\le1/4.
\tag{20}
$$

最后一个宽松常数可由 $1-2\delta\ge1/2$、$1-\delta\ge\sqrt\delta$ 得出。若 $t=\log_2(1/r)\ge3$，则 $M\ge1$ 且 $M\ge t-3$，因此 $M\ge t/4$。故

$$
n\ge\frac{\log(1/r)\log(1/\delta)}{2048r^2\log2}.
\tag{21}
$$

## 6.3 位置打包

令 $J=\lfloor\lambda/(2rs)\rfloor+1$，$\mu_j=-\lambda+4rsj$，$0\le j<J$，并令
$P_j=(\delta_{\mu_j-s}+\delta_{\mu_j+s})/2$。这些分布均值合法、真实方差都是 $s^2$，误差区间两两不交。对均匀先验，估计成功意味着识别指标的错误率至多 $\delta$。随机种子与指标独立，每一比特最多带来一比特条件互信息，所以 Fano 不等式给出

$$
n\ge(1-\delta)\log_2J-1
\ge\frac34\log_2(\lambda/s)+\frac12
\ge\frac{\log(1+\lambda/s)}{2\log2}.
\tag{22}
$$

这里使用 $r\le1/8$、$\delta\le1/4$、$\lambda/s\ge1$。这一下界同样允许自适应查询。

# 7. 单个二元通道的跨尺度信息预算

本节限制到高斯子族，但允许任意可测二元通道 $q:\mathbb R\to[0,1]$。定义

$$
p(x,\sigma)=\int_{\mathbb R}q(y)\varphi_\sigma(y-x)\,dy,
\qquad I_q(x,\sigma)=\frac{p_x(x,\sigma)^2}{p(x,\sigma)(1-p(x,\sigma))}.
$$

若 $q$ 几乎处处为零或为一，则通道无信息，定义 $I_q=0$。其他情形，高斯密度严格为正，故 $0<p<1$。有界可测函数的高斯卷积在 $\sigma>0$ 上光滑；在每个紧的 $(x,\sigma)$ 区域上，$p$ 与 $1-p$ 有正下界。求导可用高斯导数的可积控制作支配收敛。以下微分与有限区间积分因此合法，不需要对所有通道统一的正下界。

令二元熵 $h(t)=-t\log t-(1-t)\log(1-t)$，则 $0\le h\le\log2$，$h''(t)=-1/[t(1-t)]$。高斯平滑在标准差变量上满足 $p_\sigma=\sigma p_{xx}$。链式法则得到

$$
\partial_\sigma h(p)=\sigma\partial_{xx}h(p)+\sigma I_q.
\tag{23}
$$

取三角权重 $w(x)=(1-|x|/\lambda)_+$，并记

$$
H(\sigma)=\int_{-\lambda}^{\lambda}w(x)h(p(x,\sigma))\,dx,
\qquad J_q(\sigma)=\int_{-\lambda}^{\lambda}w(x)I_q(x,\sigma)\,dx.
$$

因为 $\int w=\lambda$，所以 $0\le H\le\lambda\log2$。在 $[-\lambda,0]$、$[0,\lambda]$ 分别普通分部积分，完整边界式为

$$
H'(\sigma)=\sigma J_q(\sigma)
+\frac\sigma\lambda
\bigl[h(p(-\lambda,\sigma))-2h(p(0,\sigma))+h(p(\lambda,\sigma))\bigr].
\tag{24}
$$

从 $s$ 积到 $S$，两个端点熵项具有有利符号，中点熵至多 $\log2$，从而

$$
\begin{aligned}
\int_s^S\sigma J_q(\sigma)\,d\sigma
&\le\lambda\log2+\frac{S^2-s^2}{\lambda}\log2\\
&\le2\lambda\log2.
\end{aligned}
\tag{25}
$$

最后一步使用 $S\le\lambda$。这是每个固定通道的信息预算，与其振荡次数或区间复杂度无关。

# 8. 从信息预算到有限误差、高置信度下界

## 8.1 有限位移亲和度

固定 $\sigma\in[s,S]$，令 $d=4r\sigma$。对 $u\in[-\lambda/2,\lambda/2]$ 比较均值 $u$ 与 $u+d$。记一个通道输出的 Hellinger 亲和度及其负对数为

$$
A_q(u,\sigma)=\sqrt{p(u,\sigma)p(u+d,\sigma)}
+\sqrt{(1-p(u,\sigma))(1-p(u+d,\sigma))},
\quad z_q=-\log A_q.
$$

高斯输入的亲和度是 $\exp(-d^2/(8\sigma^2))$。对通道的每个输出用 Cauchy–Schwarz，再对输出求和，证明亲和度经通道后不会减小。因此在更宽的 $r\le1/16$ 范围内，

$$
A_q\ge e^{-2r^2}\ge e^{-1/128}>1/2.
\tag{26}
$$

令 $v(x)=(\sqrt{p(x,\sigma)},\sqrt{1-p(x,\sigma)})$，则 $\|v(x)\|=1$，$\|v'(x)\|^2=I_q(x,\sigma)/4$。微积分基本定理和 Cauchy–Schwarz 给出

$$
1-A_q=\frac12\|v(u+d)-v(u)\|^2
\le\frac d8\int_u^{u+d}I_q(x,\sigma)\,dx.
$$

又 $-\log A\le2(1-A)$ 对 $A\in[1/2,1]$ 成立，所以

$$
z_q(u,\sigma)\le\frac d4\int_u^{u+d}I_q(x,\sigma)\,dx.
\tag{27}
$$

这处理的是有限的 $r$，没有用局部渐近 Fisher 信息替代有限误差证明。

因为 $d\le\lambda/4$，所有路径位于 $[-\lambda/2,3\lambda/4]$，其上 $w\ge1/4$。Fubini 及非负性给出

$$
\int_{-\lambda/2}^{\lambda/2}z_q(u,\sigma)\,du
\le d^2J_q(\sigma)=16r^2\sigma^2J_q(\sigma).
$$

再以 $d\sigma/\sigma$ 积分并使用式 (25)，得到

$$
\boxed{\int_s^S\frac{d\sigma}{\sigma}
\int_{-\lambda/2}^{\lambda/2}z_q(u,\sigma)\,du
\le32r^2\lambda\log2.}
\tag{28}
$$

## 8.2 共享随机性与置信度

将所有分布无关的种子，包括解码随机性，纳入扩大 transcript，记为 $U$。条件于种子，每个编码器固定，因查询非自适应且样本独立，比特之间独立。因此完整 transcript 在两高斯分布下的亲和度是

$$
A_T(u,\sigma)
=\mathbb E_U\prod_{i=1}^n A_{q_i^U}(u,\sigma)
=\mathbb E_U\exp\left(-\sum_{i=1}^nz_{q_i^U}(u,\sigma)\right).
\tag{29}
$$

Jensen 不等式的正确方向为
$-\log A_T\le\mathbb E_U\sum_i z_{q_i^U}$。此处绝未假定每个种子条件下都满足原 PAC 保证；保证只需对种子平均成立。

两个均值都在允许区间内。把估计量在 $u+d/2$ 处阈值化，得到两个错误概率 $\alpha,\beta\le\delta$ 的检验，因为两个均值相隔 $4r\sigma$，半径 $r\sigma$ 的准确区间分别位于阈值两侧。在两个检验决策域分别使用 Cauchy–Schwarz，得到

$$
A_T\le\sqrt{(1-\alpha)\beta}+\sqrt{\alpha(1-\beta)}
\le2\sqrt\delta.
$$

于是对于每个合法 $(u,\sigma)$，

$$
\log\frac1{2\sqrt\delta}
\le-\log A_T
\le\mathbb E_U\sum_{i=1}^nz_{q_i^U}(u,\sigma).
\tag{30}
$$

对位置长为 $\lambda$ 的区间和 $d\sigma/\sigma$ 积分，用 Tonelli 交换非负项，对每个条件通道应用式 (28)，得

$$
\lambda\log(S/s)\log\frac1{2\sqrt\delta}
\le32nr^2\lambda\log2.
$$

因 $\delta\le1/16$ 时 $\log(1/(2\sqrt\delta))\ge\frac14\log(1/\delta)$，最终有

$$
n\ge\frac{\log(S/s)\log(1/\delta)}{128r^2\log2}.
\tag{31}
$$

在 $\delta=1/16$ 时，未放松的式子给 $n\ge\log(S/s)/(32r^2)$。这一步必须是非自适应协议：自适应时历史分布依赖位置和尺度，不能再将同一个条件通道按上述方式统一积分。

# 9. 合成、端点与适用边界

式 (21)、(22)、(31) 来自允许分布类中的三个子族。不要求一个分布同时见证全部代价；三个非负下界的最大值至少是和的三分之一。因此可取 $c=1/(6144\log2)$，得到定理 1 的下界，与第 5 节的上界合成完整结论。

当 $S=s$，尺度适应项为零，精确方差分布对和位置打包仍然给出全部所需下界。当 $S=\lambda$，三角权重预算保持有效。极小但正的 $s$ 只会增加预定网格数，没有数据依赖停止。

**推论 2。** 固定 $\lambda\ge S>0$、定理范围内的 $r,\delta$，不存在一个统一有限固定样本的非自适应协议，能够对全部 $0<\sigma\le S$ 保证真实尺度相对误差。

**证明。** 否则其固定样本数必须对每个 $s>0$ 满足式 (31)，令 $s\downarrow0$ 即矛盾。事实上，位置打包式 (22) 也已给出此不可能性，甚至允许自适应；所以该推论只是边界解释，不单独计为原创发现。它不排除逐分布有限的数据依赖停止规则。

本文没有解决固定区间组件预算的最优折衷、自适应查询的尺度代价、未知目标精度、多维分布、每节点多个样本或多比特、计算成本和公共随机性成本。正尺度下界、均值范围、误差与失败概率区间都是定理假设。

# 10. 核验与复现的准确范围

完整书面论证包括以上模型、构造、上下界和所有边界条件。非作者代理进行了逐式反例攻击、独立有限精确检查与近邻文献比较。所有审稿代理属于同一模型家族，不能计为外部同行评议或跨供应商认证。

标准库精确有理数脚本检查选格覆盖、符号矩、镜像分布的全部有限支持查询、周期提升与边界案例。它们是错误探测，不会从有限参数网格推出任意分布的普遍命题。没有用大样本模拟代替证明。

Lean 检查点真实验证了若干确定性依赖；全文概率协议、信息论下界与最终 minimax 类型尚未全部形式化。本版本不包含相应的形式化源码及核验记录。不得把该部分状态解读为“定理 1 已由 Lean 完整验证”。

# 参考文献

[1] Ivan Lau and Jonathan Scarlett. *Order-Optimal Sequential 1-Bit Mean Estimation in General Tail Regimes*. arXiv:2604.07796v2, 2026-05-22. Theorem 15、Appendix B.1 及编码定位。<https://arxiv.org/html/2604.07796v2>。

[2] Ivan Lau and Jonathan Scarlett. *Non-Adaptive 1-Bit Mean Estimation: Minimax Rates and the Sample-Interval Tradeoff*. arXiv:2609.08564v1, 2026-09-08. 模型、Lemmas 1--3、Appendices A--B、结论及 Appendix F。<https://arxiv.org/pdf/2609.08564>。

[3] T. Tony Cai and Hongji Wei. *Distributed adaptive Gaussian mean estimation with unknown variance: Interactive protocol helps adaptation*. Annals of Statistics 50(4):1992--2020, 2022. DOI:10.1214/21-AOS2167。采用 29 页正式作者版，第 3.1、7.1 节。<https://tony-cai.com/assets/pdf/papers/Distributed-Gaussian-Mean-UnknownVar.pdf>。

[4] Ritesh Kumar and Shashank Vatedka. *One-Bit Distributed Mean Estimation with Unknown Variance*. arXiv:2501.18502v4, 2026-06-23，TMLR/OpenReview 记录，特别是第 3.4 节。<https://arxiv.org/html/2501.18502v4>。

[5] Yuchen Miao. *Universal Refinement without Interaction: Order-Optimal 1-Bit Mean Estimation*. arXiv:2607.24358, 2026。本次核查官方检索摘要、作者代码说明和 [2] Appendix F 的比较；全文未取得。<https://arxiv.org/abs/2607.24358>；<https://github.com/yuchenmiao04/onebitmean>。

[6] Jiachen Hu and Han Zhong. *Interaction Is Not Necessary for Order-Optimal 1-Bit Mean Estimation*. arXiv:2608.02538, 2026。本次核查官方检索摘要及 [2] Appendix F 的比较；全文未取得。<https://arxiv.org/abs/2608.02538>。

[7] T. Tony Cai and Hongji Wei. *Distributed Gaussian Mean Estimation under Communication Constraints: Optimal Rates and Communication-Efficient Algorithms*. Journal of Machine Learning Research 25, 2024。二进制位与 Gray-code 定位背景。<https://www.jmlr.org/papers/volume25/21-0316/21-0316.pdf>。

[8] Pahan Dewasurendra. *Interaction Is Unnecessary for Order-Optimal One-Bit Mean Estimation*. 作者站 10 页稿，本次访问日期为上海时区 2026-11-25；未独立确认发表或版本日期。Theorem 1 与第 4--5 节。<https://andotheror.github.io/pdf/interaction-is-unnecessary-for-order-optimal-one-bit-mean-estimation.pdf>。


