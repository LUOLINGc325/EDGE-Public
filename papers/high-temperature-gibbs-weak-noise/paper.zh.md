# 高温 Gibbs 态在弱局域量子信道下的一致 Markov 性：定量补全稿

2026-11-24

**状态：** 完整定量证明候选，尚未同行评审或 Lean 核验

# 高温 Gibbs 态在弱局域量子信道下的一致 Markov 性

**状态：完整定量证明候选，尚未经外部同行评审或 Lean 核验。** 本文与英文技术稿采用相同的定理假设、常数和外部依赖。文献查新支持将结果定位为既定猜想的定量技术补全，尚未确立全球优先权。

## 1. 研究问题与已有工作

考虑局部项不必对易的多体 Hamiltonian $H$，以及足够高温的 Gibbs 态 $\rho_\beta=e^{-\beta H}/Z_\beta$。我们对它依次施加局域、完全正且保迹的量子信道，允许不同门的支撑重叠，也允许信道不保单位算子。目标是证明：只要温度参数与每个站点累计受到的噪声足够小，输出态 $\widetilde\rho$ 对任意互不相交区域 $A,B,C$ 都满足条件互信息的指数衰减，而且前因子只与较小的一端边界有关。

这正是 [Kim–Yang–Lee，§6 式 (6.5)](https://arxiv.org/html/2611.26626v1) 提出的弱局域信道扩展。该文已经提出在局部 projective 2-design 表示中联合展开 Hamiltonian 项和信道扰动的路线。另一方面，[Mann–Minko，Lemma 12 与 Lemmas 22–23](https://arxiv.org/html/2306.08974v2) 已有有序近恒等电路聚合物和 Hamiltonian 包含–排除展开。因此，本文不把这些构造本身列为新方法。

本文提出的定量补全，是把这些构造用于一般局部 CPTP 超算子，保留门的顺序与每次发生的标签，控制不保单位信道产生的纯门连通分量，并验证一个体积一致的加权活动量条件。证明直接调用两个外部分析工具：标准 Kotecký–Preiss 聚合物收敛定理，以及 Kim–Yang–Lee 的乘积制备条件互信息收缩结果。有限深度表述、子电路表述和短时 Lindblad 推论都是同一活动量定理的直接推论。

## 2. 设定、符号和精确命题

### 2.1 几何与量子系统

令 $\Lambda$ 为某个固定格点空间中的任意有限集合，环境格点带度量 $d$，并具有一致的多项式体积增长。对每个站点 $x$，局部 Hilbert 空间为 $\mathcal H_x$，维数满足 $2\le d_x\le q<\infty$；一维因子可删去。取任意 $r>0$，定义

$$
S_r:=\sup_u\sum_v e^{-d(u,v)/r}<\infty,
$$

其中求和在环境格点上进行。因此 $S_r$ 不依赖所选有限体积 $\Lambda$。以下所有对数均为自然对数，所有信息量以 nats 计。

设 Hamiltonian 具有有限局部项列表

$$
H=\sum_{h\in E_H}h_h,\qquad h_h=h_h^\dagger,
\qquad |X_h|\le k,\qquad \operatorname{diam}_d(X_h)\le R,
$$

其中 $X_h\subseteq\Lambda$ 是该项指定的非空支撑，不要求各项对易。零项可以删去。定义局部强度

$$
J:=\sup_x\sum_{h:x\in X_h}\|h_h\|_\infty,
\qquad
Z_\beta:=\operatorname{Tr}e^{-\beta H},\qquad
\rho_\beta:=Z_\beta^{-1}e^{-\beta H},\qquad \beta\ge0.
$$

施加有限有序信道序列

$$
\mathcal N=\mathcal N_M\circ\cdots\circ\mathcal N_1,
\qquad
\Delta_g:=\mathcal N_g-\mathrm{id},\qquad
\delta_g:=\|\Delta_g\|_\diamond.
$$

这里每个 $\mathcal N_g$ 是 CPTP 映射，作用在指定的非空集合 $Y_g$ 上，满足 $|Y_g|\le s$、$\operatorname{diam}_d(Y_g)\le r_0$。**即使两个门支撑相同，甚至是同一个信道的两次使用，它们仍是两个不同的发生标签。** 恒等门可以删去。门总数 $M$ 不必有独立于体积的统一上界；主条件控制的是每个站点的累计活动量。

diamond 范数采用完全有界迹范数约定：

$$
\|\Phi\|_\diamond
=\sup_{\mathcal K}\sup_{X\ne0}
\frac{\|(\Phi\otimes\mathrm{id}_{\mathcal K})(X)\|_1}{\|X\|_1}.
$$

目标态为 $\widetilde\rho=\mathcal N(\rho_\beta)$。取

$$
K:=\max\{2,k,s\},\qquad a:=2q-1,
\qquad r>0,\quad r\ge\max\{R,r_0\}.
$$

特别地，$K\ge2$ 是后面数值小性比较的一部分，不应遗漏。

### 2.2 符号表

| 符号 | 含义 |
|---|---|
| $E_H,E_G$ | Hamiltonian 项标签集、门发生标签集 |
| $E=E_H\sqcup E_G$ | 两类标签的不交并；标签类型也被保留 |
| $Z_e$ | 标签 $e$ 的支撑：分别为 $X_h$ 或 $Y_g$ |
| $d(Y)=\prod_{x\in Y}d_x$ | 一组站点的 Hilbert 空间维数 |
| $b_e,\eta_\lambda$ | 单标签活动量、每站点的加权累计活动量 |
| $G_*,d_*,\partial_*A$ | 增广支撑图、其图距离、区域的图内边界 |
| $Q_T$ | 恰好出现 Hamiltonian 标签集 $T$ 的所有有序 Taylor 词之和 |
| $\Delta_F$ | 选定门集合 $F$ 按原电路顺序组成的超算子 |
| $\gamma,U_\gamma,R_\gamma$ | 连通标签集即聚合物、支撑并、算子系数 |
| $\Gamma=(\gamma_1,\ldots,\gamma_j)$ | 对数展开中的聚合物元组；此处允许重复聚合物 |
| $N_\Gamma=\sum_i\lvert\gamma_i\rvert,\ U_\Gamma=\bigcup_iU_{\gamma_i}$ | 簇的标签发生总数、总支撑 |
| $\nu_x,P_{x,t},\tau_{x,t}$ | 局部 2-design 的概率、秩一投影、对偶线性泛函 |
| $W_L,w_{\gamma,L}$ | 标量化后的配分函数、聚合物活动量 |
| $\Psi_U,\pi$ | 有效实经典势、最终严格正的经典概率分布 |

定义单标签活动量与累计活动量：

$$
\begin{aligned}
b_h&=a^{|X_h|}\bigl(e^{\beta\|h_h\|_\infty}-1\bigr),\\
b_g&=a^{|Y_g|}d(Y_g)^2\delta_g,\\
\eta_\lambda&=e^{\lambda+1}\sup_x\sum_{e:x\in Z_e}b_e,
\qquad \lambda\ge0.
\end{aligned}
\tag{1}
$$

增广图 $G_*$ 的顶点是 $\Lambda$：只要两个不同站点同属于某个 $Z_e$，就在它们之间连边。也就是说，每个 Hamiltonian 项和每个非恒等门的指定支撑都生成一个团。图距离记为 $d_*$，不同连通分量之间取 $\infty$，约定 $e^{-\infty}=0$。区域 $A$ 的边界为

$$
\partial_*A
=\{x\in A:\exists y\in\Lambda\setminus A,
\ \{x,y\}\in E(G_*)\}.
$$

因此，穿过边界的信道支撑必须计入边界定义，不能只用原 Hamiltonian 的支撑图。

### 2.3 主定理：候选定量完成

**定理。** 对上述每一个有限系统及有序信道序列，若

$$
\boxed{\eta_{K+2}\le\frac1{8K},}
\tag{2}
$$

则存在严格正的经典概率分布 $\pi$，使 $\widetilde\rho$ 为局部乘积纯态关于 $\pi$ 的平均。相对于一个乘积参考测度，$\pi$ 的实有效势满足

$$
\sup_x\sum_{U\ni x}
e^{|U|+2\operatorname{diam}_*(U)}\|\Psi_U\|_\infty
\le2\eta_{K+2}.
\tag{3}
$$

所有势项均支撑在 $G_*$ 的单个连通分量内；以下势的求和只包括实际出现的非空支撑。调用后文明确列出的 Kim–Yang–Lee 外部引理，对**任意两两不相交**的 $A,B,C\subseteq\Lambda$，

$$
I(A:C\mid B)_{\widetilde\rho}
\le 2\log q\sum_{x\in A,y\in C}e^{-2d_*(x,y)}
\tag{4}
$$

以及

$$
\boxed{
I(A:C\mid B)_{\widetilde\rho}
\le 2\log q\,S_r^2
\min\{|\partial_*A|,|\partial_*C|\}
e^{-\operatorname{dist}_d(A,C)/r}.}
\tag{5}
$$

这里

$$
I(A:C\mid B)
=S(\rho_{AB})+S(\rho_{BC})-S(\rho_B)-S(\rho_{ABC}),
\qquad S(\sigma)=-\operatorname{Tr}(\sigma\log\sigma).
$$

**不要求 $A\cup B\cup C=\Lambda$，也不要求 $B$ 在几何上分隔 $A,C$。** 取 $B=\varnothing$ 就得到互信息界。若 $A$ 或 $C$ 为空，信息量为零；若两端只位于互不相连的分量，状态精确因子化，信息量也为零。这也解释了边界为空的退化情形。

在 $q,k,s,R,r_0$ 与环境格点增长常数固定时，(2)–(5) 的常数均不依赖 $|\Lambda|$。这是这里“一致”的含义。

### 2.4 有限深度下可直接使用的条件

若电路有 $m$ 层，每层门的支撑两两不交，且每次门满足 $\delta_g\le2\varepsilon$，则每个站点至多遇到 $m$ 个门。由 $e^u-1\le ue^u$ 和 $\|h_h\|_\infty\le J$，

$$
\sum_{h:x\in X_h}b_h\le a^k\beta J e^{\beta J},
\qquad
\sum_{g:x\in Y_g}b_g\le2m\varepsilon a^sq^{2s}.
$$

因此 (2) 的一个充分条件是

$$
\boxed{
e^{K+3}\left[a^k\beta J e^{\beta J}
+2m\varepsilon a^sq^{2s}\right]\le\frac1{8K}.}
\tag{6}
$$

下面证明主定理。论证依次把算子展开化为标量聚合物配分函数，证明其严格正性与势的小性，再应用信息收缩引理。

## 3. 局部门的范数控制与环境维数无关

设 $\Delta$ 作用在维数为 $d_Y$ 的局部空间上，$\mathcal K$ 是任意有限辅助空间。需要的初等估计是

$$
\|\Delta\otimes\mathrm{id}_{\mathcal K}\|_{\infty\to\infty}
\le d_Y^2\|\Delta\|_\diamond.
\tag{7}
$$

证明时把任意 $X$ 写成局部矩阵块：

$$
X=\sum_{i,j=1}^{d_Y}|i\rangle\langle j|\otimes X_{ij}.
$$

每块是左右压缩，故 $\|X_{ij}\|_\infty\le\|X\|_\infty$。又因矩阵单位的迹范数为一，

$$
\|\Delta(|i\rangle\langle j|)\|_\infty
\le\|\Delta(|i\rangle\langle j|)\|_1
\le\|\Delta\|_\diamond.
$$

对 $d_Y^2$ 项使用三角不等式和张量积算子范数的乘法性，即得 (7)。这里不要求 $\Delta$ 完全正、正或保单位；在应用中 $\Delta=\mathcal N-\mathrm{id}$ 通常也不是正映射。该估计并不精细，但没有全系统维数因子，足以支持体积一致的条件。

## 4. 保持顺序的精确算子展开

### 4.1 先合并 Hamiltonian 标签的任意重复

此处的包含–排除与有序词构造承接 [Mann–Minko 的 Lemmas 22–23](https://arxiv.org/html/2306.08974v2)。我们保留算子系数，因为随后需要先作用信道，再取标量泛函。

对 $T\subseteq E_H$，置 $Q_\varnothing=I$。当 $T\ne\varnothing$ 时，定义

$$
Q_T=
\sum_{n\ge|T|}\frac{(-\beta)^n}{n!}
\sum_{\substack{(h_1,\ldots,h_n)\in T^n\\
\{h_1,\ldots,h_n\}=T}}
h_{h_1}\cdots h_{h_n}.
\tag{8}
$$

内层集合条件表示每个 $h\in T$ 至少出现一次，且不出现 $T$ 外的标签。每个乘积仍保留其原有次序。有限维指数级数绝对收敛，因此可以按出现的标签集合重排，得到

$$
e^{-\beta H}=\sum_{T\subseteq E_H}Q_T.
\tag{9}
$$

若固定各标签重数 $n_h\ge1$，令 $n=\sum_hn_h$，则相应有序词数为 $n!/\prod_hn_h!$。逐词取范数后，Taylor 分母被该多项式系数抵消，故

$$
\begin{aligned}
\|Q_T\|_\infty
&\le\sum_{(n_h\ge1)_{h\in T}}
\prod_{h\in T}\frac{(\beta\|h_h\|_\infty)^{n_h}}{n_h!}\\
&=\prod_{h\in T}\bigl(e^{\beta\|h_h\|_\infty}-1\bigr).
\end{aligned}
\tag{10}
$$

还可使用等价的精确公式

$$
Q_T=\sum_{W\subseteq T}(-1)^{|T|-|W|}
\exp\left(-\beta\sum_{h\in W}h_h\right).
\tag{11}
$$

其验证只需展开各个指数：一个使用标签集 $V\subseteq T$ 的词，其系数含 $\sum_{V\subseteq W\subseteq T}(-1)^{|T|-|W|}$，该和仅在 $V=T$ 时为一，否则为零。

式 (11) 同时给出两个事实。第一，$Q_T$ 厄米，因为每个指数都厄米。第二，若 $T=T_1\sqcup\cdots\sqcup T_\ell$，且这些组的站点支撑两两不交，则指数在各张量因子上分解，子集求和也独立分解，所以 $Q_T=\bigotimes_jQ_{T_j}$，其余站点补恒等算子。

### 4.2 每次门只选一次，并保留原顺序

对 $F=\{g_1<\cdots<g_p\}\subseteq E_G$，定义

$$
\Delta_F:=\Delta_{g_p}\circ\cdots\circ\Delta_{g_1},
\qquad \Delta_\varnothing:=\mathrm{id}.
$$

把每个 $\mathcal N_g$ 写为 $\mathrm{id}+\Delta_g$，直接按复合的多线性展开：

$$
O:=\mathcal N(e^{-\beta H})
=\sum_{T\subseteq E_H}\sum_{F\subseteq E_G}\Delta_F(Q_T).
\tag{12}
$$

这与 [Mann–Minko，Lemma 12](https://arxiv.org/html/2306.08974v2) 中有序近恒等电路的聚合物原理相接。这里的扰动是一般局部超算子，并且始终作用于完整输入上的恒等扩张。式 (12) 不使用、也不蕴含重叠门之间的可交换性。

### 4.3 联合连通分量给出精确聚合物模型

对标签集合 $S\subseteq E$，记 $U_S=\bigcup_{e\in S}Z_e$，并置 $U_\varnothing=\varnothing$。若非空 $\gamma\subseteq E$ 的标签重叠图连通，即两个标签的支撑相交时连边所得的图连通，就称 $\gamma$ 为一个聚合物。其算子系数定义在 $U_\gamma$ 上：

$$
R_\gamma
=\Delta_{\gamma\cap E_G}\left(
Q_{\gamma\cap E_H}\otimes
I_{U_\gamma\setminus U_{\gamma\cap E_H}}
\right).
\tag{13}
$$

若 $\gamma$ 没有 Hamiltonian 标签，输入就是 $I_{U_\gamma}$。这是必须保留的情形：不保单位信道一般满足 $\Delta_g(I)\ne0$，所以在 $\beta=0$ 时也会有纯门聚合物。

若选定集合 $T\sqcup F$ 的连通分量为 $\gamma_1,\ldots,\gamma_\ell$，则

$$
\Delta_F(Q_T)=\bigotimes_{j=1}^{\ell}R_{\gamma_j},
\tag{14}
$$

未触及站点补恒等因子。证明分两步：Hamiltonian 部分先由 (11) 在这些分量间因子化；不同分量上的门作用于不同张量因子，可以跨分量重排，而每个分量内部的门顺序完全不变。因此局部线性映射的张量分解给出 (14)，无须保单位性。

称两个聚合物相容，当且仅当它们的站点支撑不交。每个选定标签集具有唯一的连通分量分解；反过来，一个两两相容的聚合物族唯一给出其标签并。故 (12) 精确改写为

$$
O=\sum_{\mathcal F\text{ 两两相容}}
\prod_{\gamma\in\mathcal F}R_\gamma,
\tag{15}
$$

空族贡献 $I$，且不出现额外组合系数。

每个 $R_\gamma$ 支撑于 $U_\gamma$，并且厄米：CPTP 映射和恒等映射均保持厄米性，它们之差及其有序复合也保持厄米性。逐门应用 (7)，再使用 (10)，得到

$$
\|R_\gamma\|_\infty
\le
\prod_{h\in\gamma\cap E_H}
\bigl(e^{\beta\|h_h\|_\infty}-1\bigr)
\prod_{g\in\gamma\cap E_G}d(Y_g)^2\delta_g.
\tag{16}
$$

这一步还说明为何不能按支撑合并门标签：两次相同支撑的门可以产生 $\Delta_{g_2}\Delta_{g_1}$；把它们视作一个标签会删去这个有序乘积。

## 5. 用局部 2-design 把算子问题变为标量问题

这里采用 [Kim–Yang–Lee 的乘积框架表示](https://arxiv.org/html/2611.26626v1)。对每个站点 $x$，选取有限加权 projective 2-design，包含秩一投影 $P_{x,t}$ 和严格正权重 $\nu_x(t)$。它的二阶矩满足

$$
\mathbb E_{\nu_x}(P_{x,t}\otimes P_{x,t})
=\frac{I+\mathsf{Swap}}{d_x(d_x+1)}.
$$

定义

$$
D_{x,t}:=(d_x+1)P_{x,t}-I,
\qquad \tau_{x,t}(X):=\operatorname{Tr}(D_{x,t}X),
\qquad \operatorname{tr}_x(X):=\operatorname{Tr}(X)/d_x.
$$

二阶矩恒等式及其一阶矩给出

$$
\begin{gathered}
\tau_{x,t}(I)=1,
\qquad \|\tau_{x,t}\|=\|D_{x,t}\|_1=2d_x-1\le a,\\
\mathbb E_{\nu_x}\tau_{x,t}=\operatorname{tr}_x,
\qquad
X=d_x\mathbb E_{\nu_x}[\tau_{x,t}(X)P_{x,t}].
\end{gathered}
\tag{17}
$$

范数等式还可直接由 $D_{x,t}$ 的本征值得到：在 $P_{x,t}$ 方向为 $d_x$，其正交补上为 $-1$。最后一个式子是框架反演公式。

给定 $L\subseteq\Lambda$，构造乘积泛函 $\omega_{\mathbf t_L}$：在 $x\in L$ 使用 $\tau_{x,t_x}$，在其余站点使用归一化迹 $\operatorname{tr}_x$。它在不交支撑上可乘，在厄米算子上取实值；对支撑于 $U$ 的算子，其范数至多 $a^{|U|}$。令

$$
w_{\gamma,L}(\mathbf t_L):=\omega_{\mathbf t_L}(R_\gamma),
\qquad
W_L(\mathbf t_L):=\omega_{\mathbf t_L}(O).
\tag{18}
$$

由 (15) 得到标量硬核聚合物配分函数

$$
W_L(\mathbf t_L)
=\sum_{\mathcal F\text{ 两两相容}}
\prod_{\gamma\in\mathcal F}w_{\gamma,L}(\mathbf t_L).
\tag{19}
$$

每个 $w_{\gamma,L}$ 都为实数，但现在尚不能保证它或 $W_L$ 非负。利用 $|U_\gamma|\le\sum_{e\in\gamma}|Z_e|$ 以及 (16)，对所有 $L$ 和所有局部标签一致地有

$$
|w_{\gamma,L}|
\le a^{|U_\gamma|}\|R_\gamma\|_\infty
\le\prod_{e\in\gamma}b_e.
\tag{20}
$$

接下来的收敛论证既给出有效势界，也解决严格正性；不能从算子 $O\ge0$ 直接推断 $W_L\ge0$，因为框架对偶泛函 $\tau_{x,t}$ 不是正泛函。

## 6. 加权连通簇的收敛与实对数

### 6.1 一个只依赖每站点活动量的树计数

固定 $\lambda\ge0$，置 $v_e=e^{\lambda+1}b_e$，于是 $\sup_x\sum_{e:x\in Z_e}v_e=\eta_\lambda$。对任意站点 $x$ 和正整数 $t$，

$$
\sum_{\substack{\gamma:x\in U_\gamma\\|\gamma|=t}}
\prod_{e\in\gamma}v_e
\le\eta_\lambda(4K\eta_\lambda)^{t-1}.
\tag{21}
$$

为验证这一式子，对每个连通标签集选一棵生成树，根标签包含 $x$，并给子节点选定次序。具有 $t$ 个顶点的平面有根树形状数不超过 $4^{t-1}$。固定形状后，根标签的总权重至多为 $\eta_\lambda$。若父标签为 $e$，与它相交的子标签总权重满足

$$
\sum_{f:Z_f\cap Z_e\ne\varnothing}v_f
\le\sum_{y\in Z_e}\sum_{f:y\in Z_f}v_f
\le K\eta_\lambda.
$$

从叶子向根依次求和，得到每个形状的上界 $\eta_\lambda(K\eta_\lambda)^{t-1}$，再乘树形状数即得 (21)。在这个非负上界中允许树标签重复只会增大求和；真实聚合物中的每个标签仍只出现一次。同支撑的不同门发生标签也仍是不同选项。

若 $\eta_\lambda\le1/(8K)$，则 $4K\eta_\lambda\le1/2$，从而

$$
\sup_x\sum_{\gamma:x\in U_\gamma}
e^{(\lambda+1)|\gamma|}\prod_{e\in\gamma}b_e
\le\frac{\eta_\lambda}{1-4K\eta_\lambda}
\le2\eta_\lambda.
\tag{22}
$$

### 6.2 调用标准 [Kotecký–Preiss 收敛定理](https://arxiv.org/abs/math-ph/0304003)

使用该定理的下述标准形式。设非负上界权重 $z_\gamma$ 与惩罚 $a_\gamma$ 满足

$$
\sum_{\gamma':U_{\gamma'}\cap U_\gamma\ne\varnothing}
z_{\gamma'}e^{a_{\gamma'}}\le a_\gamma.
\tag{23}
$$

则对 $|w_\gamma|\le z_\gamma$，配分函数的连通对数级数绝对收敛，其指数等于配分函数；指定一个聚合物为根时，包含根权重的簇和受 $z_\gamma e^{a_\gamma}$ 控制。该定理是外部输入，本文仅验证其条件。

取

$$
z_\gamma=e^{\lambda|\gamma|}\prod_{e\in\gamma}b_e,
\qquad a_\gamma=|\gamma|.
$$

由 (22)，

$$
\begin{aligned}
\sum_{\gamma'\not\sim\gamma}z_{\gamma'}e^{a_{\gamma'}}
&\le\sum_{x\in U_\gamma}
\sum_{\gamma':x\in U_{\gamma'}}z_{\gamma'}e^{a_{\gamma'}}\\
&\le2\eta_\lambda|U_\gamma|
\le2K\eta_\lambda|\gamma|
\le|\gamma|.
\end{aligned}
$$

因而 (23) 成立。

为写出后面需要的具体结论，令 $\Gamma=(\gamma_1,\ldots,\gamma_j)$ 为聚合物有序元组，允许重复。定义

$$
f_{il}=\begin{cases}-1,&U_{\gamma_i}\cap U_{\gamma_l}\ne\varnothing,\\0,&\text{否则},\end{cases}
\qquad
\phi^T(\Gamma)=\sum_{F\text{ 连通于 }\{1,\ldots,j\}}
\prod_{\{i,l\}\in E(F)}f_{il},
$$

并规定 $j=1$ 时 $\phi^T=1$。不相容图不连通时该系数为零。标准的带根簇界进一步给出站点锚定界：

$$
\sup_x\sum_{\Gamma:x\in U_\Gamma}
\frac{|\phi^T(\Gamma)|}{j!}
e^{\lambda N_\Gamma}
\prod_{i=1}^j\prod_{e\in\gamma_i}b_e
\le2\eta_\lambda.
\tag{24}
$$

这里对所有元组长度 $j\ge1$ 求和。解释一下从聚合物根到站点根的转换：每个满足 $x\in U_\Gamma$ 的簇至少含一个覆盖 $x$ 的聚合物；将它标记为根所得求和支配未标记的簇和，再对所有 $\gamma$ 满足 $x\in U_\gamma$ 的根使用 $z_\gamma e^{a_\gamma}$ 界，最后应用 (22)。重复聚合物是对数展开自身的组合结构，与 (8) 的 Taylor 词重数以及 (12) 中门的零或一次选择不同。

### 6.3 标量权重的严格正性

对固定 $L,\mathbf t_L$，实际活动量 $w_{\gamma,L}$ 是实数，且满足统一的上界权重。因此收敛的连通级数

$$
\sum_{j\ge1}\frac1{j!}
\sum_{\gamma_1,\ldots,\gamma_j}
\phi^T(\gamma_1,\ldots,\gamma_j)
\prod_iw_{\gamma_i,L}
$$

是一个有限实值。KP 定理保证它的指数恰为 (19) 中的 $W_L$，于是 $W_L>0$。这里得到的是由零活动量处连续延拓而来的实对数，不是预先假设 $W_L$ 为正后才写出的形式对数。等价地，沿 $w\mapsto u w,\ 0\le u\le1$ 使用同一无零点区域，配分函数从 $1$ 出发始终为实且不为零，所以其符号保持为正。

## 7. 有效经典势、严格正概率与量子态重构

对 $L=\Lambda$，把绝对收敛的对数级数按簇的**准确支撑并**分组：

$$
\begin{aligned}
\log W_\Lambda(\mathbf t)&=\sum_{U\ne\varnothing}\Psi_U(\mathbf t_U),\\
\Psi_U(\mathbf t_U)
&=\sum_{\Gamma:U_\Gamma=U}
\frac{\phi^T(\Gamma)}{j!}\prod_iw_{\gamma_i,\Lambda}(\mathbf t).
\end{aligned}
\tag{25}
$$

这些函数为实，且只依赖 $\mathbf t_U$。若某簇对上式有非零贡献，则其聚合物不相容图连通，每个聚合物内部的标签重叠图也连通，所以所有基本支撑联合连通。又因为每个 $Z_e$ 在 $G_*$ 中构成一个团，

$$
|U_\Gamma|\le KN_\Gamma,
\qquad
\operatorname{diam}_*(U_\Gamma)\le N_\Gamma.
$$

第二个不等式可沿连接两个站点的基本支撑链验证：每次经过一个团至多走一条图边，所需支撑数不超过簇中的标签发生总数。故

$$
e^{|U_\Gamma|+2\operatorname{diam}_*(U_\Gamma)}
\le e^{(K+2)N_\Gamma}.
$$

在 (24) 中取 $\lambda=K+2$，对 (25) 逐项取绝对值并取标签的上确界，就得到主定理中的势界 (3)。绝对收敛允许这种分组，也保证所有结论对局部标签一致。

现在记 $D_\Lambda=\prod_xd_x$、$\nu=\bigotimes_x\nu_x$。由于整体信道保迹，

$$
W_\varnothing=\operatorname{Tr}(O)/D_\Lambda
=Z_\beta/D_\Lambda>0.
$$

用 (17) 平均所有标签时，每个 $\tau_{x,t}$ 被归一化迹替代，所以 $\mathbb E_\nu W_\Lambda=W_\varnothing$。于是

$$
\pi(\mathbf t):=\nu(\mathbf t)
\frac{W_\Lambda(\mathbf t)}{W_\varnothing}
\tag{26}
$$

是严格正、归一化的概率分布。它相对于乘积参考测度 $\nu$ 的对数密度为 $\sum_U\Psi_U-\log W_\varnothing$；最后一项只是归一化常数。

对框架反演公式 (17) 逐站点取张量积，

$$
O=D_\Lambda\mathbb E_\nu
\left[W_\Lambda(\mathbf t)\bigotimes_xP_{x,t_x}\right].
$$

再除以 $Z_\beta=D_\Lambda W_\varnothing$，得到

$$
\boxed{\widetilde\rho
=\mathbb E_{\mathbf t\sim\pi}\bigotimes_xP_{x,t_x}.}
\tag{27}
$$

对未使用的量子站点取偏迹，等价于在同一个概率分布中平均其标签，因为每个 $P_{x,t}$ 的迹为一。因此所有约化态都来自同一个乘积制备模型；不需要分别给不同区域构造 Gibbs Hamiltonian。

## 8. 明确调用 [KYL Lemmas 7–8](https://arxiv.org/html/2611.26626v1)：从小实势到任意区域 CMI

这里使用以下外部结论，包含该文 §5.2 中对一般局部密度矩阵的适用范围。

**乘积制备收缩输入。** 若一个有限经典分布相对于乘积参考测度具有实势 $\Psi_U$，且对某个图度量与 $\mu>0$ 满足

$$
\sup_x\sum_{U\ni x}|U|e^{\mu\operatorname{diam}(U)}
\|\Psi_U\|_\infty\le\log(6/5),
\tag{28}
$$

则由该分布制备的量子态

$$
\sigma=\mathbb E_\pi\bigotimes_x\sigma_x(t_x),
\qquad \dim\mathcal H_x\le q,
$$

对任意两两不交区域满足

$$
I(A:C\mid B)_\sigma
\le2\log q\sum_{x\in A,y\in C}e^{-\mu d(x,y)}.
\tag{29}
$$

此处 $\sigma_x(t_x)$ 可为任意局部密度矩阵。该引理使用经典条件重采样及乘积制备结构，允许丢弃 $A\cup B\cup C$ 以外的站点，也允许任意条件区域 $B$。本文不重新证明该信息论引理，也不把它误写成“CMI 对条件系统上的任意噪声单调”。

在 (27) 中取 $\sigma_x=P_{x,t_x}$，并在 $G_*$ 上令 $\mu=2$。由 (3)、$|U|\le e^{|U|}$ 以及 $K\ge2$，

$$
\begin{aligned}
\sup_x\sum_{U\ni x}|U|e^{2\operatorname{diam}_*(U)}
\|\Psi_U\|_\infty
&\le2\eta_{K+2}\\
&\le\frac1{4K}\le\frac18<\log(6/5).
\end{aligned}
\tag{30}
$$

这核对了外部引理的定量前提，因而 (29) 给出 (4)。若 $G_*$ 不连通，可以分别在各分量上使用引理：原算子展开在分量间精确因子化，归一化后也是乘积态，条件互信息按分量相加。

## 9. 从站点对求和得到较小边界前因子

只需考虑图距离有限的 $(x,y)\in A\times C$。若不存在这样的点对，(4) 已给出零。否则令 $\ell=d_*(A,C)$。为每个有限距离点对选一条最短路径，并令 $u$ 为该路径第一次离开 $A$ 之前的最后一个站点。那么 $u\in\partial_*A$，而最短路径的子路径仍最短，故

$$
d_*(x,y)=d_*(x,u)+d_*(u,y).
$$

因为 $d_*(x,y)\ge\ell$，

$$
e^{-2d_*(x,y)}
\le e^{-\ell}e^{-d_*(x,u)}e^{-d_*(u,y)}.
$$

先按选到的边界点 $u$ 分组，再扩大为对全部 $x,y$ 的非负求和，得到

$$
\begin{aligned}
\sum_{x\in A,y\in C}e^{-2d_*(x,y)}
&\le e^{-\ell}\sum_{u\in\partial_*A}
\left(\sum_{x\in A}e^{-d_*(x,u)}\right)
\left(\sum_{y\in C}e^{-d_*(u,y)}\right)\\
&\le e^{-\ell}|\partial_*A|S_r^2.
\end{aligned}
\tag{31}
$$

最后一步使用每条 $G_*$ 边的物理长度不超过 $r$，故 $d_*(x,y)\ge d(x,y)/r$。同样有 $\ell\ge\operatorname{dist}_d(A,C)/r$。交换 $A,C$ 再作同一估计，取两者较小者，再代入 (4)，即得 (5)。至此完成主定理在上述两个外部工具下的证明。

## 10. 同一活动量条件的两个直接推论

### 10.1 子电路、前缀及逐门弱化

对每次门独立取 $u_g\in[0,1]$，令

$$
\mathcal N_g(u_g)=(1-u_g)\mathrm{id}+u_g\mathcal N_g.
\tag{32}
$$

它仍为 CPTP，且相对恒等的差为 $u_g\Delta_g$，因此所有门活动量只会减小。只要原电路满足 (2)，所有这样得到的电路都满足同一界，包括任意子电路、任意前缀和逐门插值路径。可以始终使用原来的共同增广图，也可以使用删除已失活门后的较小图。这是主条件的单调性推论。

### 10.2 短时局部 Lindblad 演化

设

$$
\mathcal L=\sum_{u\in E_L}\mathcal L_u,
\qquad
J_L:=\sup_x\sum_{u:x\in Y_u}\|\mathcal L_u\|_\diamond<\infty.
\tag{33}
$$

每项支撑满足 $|Y_u|\le s$、$\operatorname{diam}_d(Y_u)\le r_0$，并且**每个 $\mathcal L_u$ 单独生成 CPTP 半群**。这比“总和 $\mathcal L$ 是 Lindbladian”更具体；不能把任意局部线性分解代入下面的证明。

对任意 $t\ge0$，若

$$
\boxed{
e^{K+3}\left[a^k\beta J e^{\beta J}
+t\,a^sq^{2s}J_L\right]\le\frac1{8K},}
\tag{34}
$$

则 $e^{t\mathcal L}(\rho_\beta)$ 满足 (4)–(5)，其中增广图包括 Hamiltonian 与生成元的所有非零局部支撑。

证明使用固定有限体积上的标准 Lie–Trotter 逼近。因为 CPTP 映射的 diamond 范数为一，对 $h\ge0$，

$$
\begin{aligned}
\|e^{h\mathcal L_u}-\mathrm{id}\|_\diamond
&\le\int_0^h\|\mathcal L_u e^{v\mathcal L_u}\|_\diamond\,dv\\
&\le h\|\mathcal L_u\|_\diamond.
\end{aligned}
\tag{35}
$$

固定项的顺序，定义

$$
\mathcal T_p:=
\left(\prod_{u\text{ 按固定顺序}}
e^{(t/p)\mathcal L_u}\right)^p.
\tag{36}
$$

把每次出现的 $e^{(t/p)\mathcal L_u}$ 当作不同门标签。某站点的全部门活动量满足

$$
\begin{aligned}
\sum_{g:x\in Y_g}b_g
&\le p\sum_{u:x\in Y_u}
a^{|Y_u|}d(Y_u)^2\frac{t}{p}\|\mathcal L_u\|_\diamond\\
&\le t\,a^sq^{2s}J_L,
\end{aligned}
$$

与 $p$ 无关。因此 (34) 使所有 $\mathcal T_p(\rho_\beta)$ 都满足同一主定理，使用同一个图和同一组常数。

在固定有限 $\Lambda$ 上先令 $p\to\infty$。有限维 Lie–Trotter 公式给出迹范数收敛到 $e^{t\mathcal L}(\rho_\beta)$，有限维 von Neumann 熵的连续性把 CMI 不等式传到极限。虽然连续性模量可以依赖该固定体积，这里只需在每个体积内取极限；最终保留下来的不等式常数原本就不依赖体积。整个证明没有交换 Trotter 极限与热力学极限。

这不是稳态定理，也没有得到任意时间或任意温度的稳定性。短时窗口来自 (34) 中的局部累计量 $tJ_L$。

## 11. 适用范围与局限

定理的主要情形是非对易 Gibbs 输入与重叠、不保单位、多点 CPTP 门的组合。独立单点 CPTP 噪声已经由 [KYL §6](https://arxiv.org/html/2611.26626v1) 处理，而且不需要门强度小；有限深度局域酉电路也可通过 $Ue^{-\beta H}U^\dagger=e^{-\beta UHU^\dagger}$ 归约到具有扩大局域参数的 Gibbs 问题。因而这些特例本身不构成新增方法。

已有[高温 hidden Markov-network 结果](https://arxiv.org/html/2502.13210v1)允许对易量子 Hamiltonian 上受限的单点信道；已有[弱有限深度退相干结果](https://arxiv.org/html/2511.01976v1)处理 commuting-Pauli Hamiltonian 和 stabilizer-mixing 信道。其中，高温 hidden Markov-network 定理已具有任意区域与较小边界前因子；这些单项性质并非本文的新发现。[快速混合 Lindbladian 的 CMI 结果](https://arxiv.org/html/2606.28054v2)针对带额外动力学条件的固定点；[局部信道产生准局域 Gibbs 稳态的工作](https://arxiv.org/html/2408.08672v2)是另一个稳态扰动问题。这些差别解释了本文的定理为何尚未被已核对的近邻结果直接覆盖，具体比较见下列来源及配套查新报告。

一般有限 Markov length 态在任意弱噪声下并不稳定；已有[秩亏输入的弱信道反例](https://arxiv.org/html/2610.12929v3)及[无穷小耗散反例](https://arxiv.org/abs/2610.18983)。因此，高温与小活动量条件不能在没有新证明的情况下删去。本文也没有证明实际可行的采样算法、恢复电路复杂度或最优噪声阈值。

数值常数是保守的。例如 $q=2,k=s=2,m=2$ 时，(6) 化为

$$
9\beta J e^{\beta J}+576\varepsilon
\le e^{-5}/16\simeq4.2112\times10^{-4}.
$$

该区域非空；但超过这个充分阈值不意味着态不稳定。

权威稿还包含三量子比特有理数代数审计，覆盖非对易项、纯门分量、重复支撑和门顺序。这类有限审计可以发现因子化或顺序实现错误，不能替代 (21)–(30) 的任意体积收敛论证，也不能替代对外部 CMI 引理的审查。本文状态仍是供进一步专家审阅的完整定量证明候选。

## 12. 来源与明确依赖

1. **KYL：目标、经典表示与 CMI 外部输入。** A. D. Kim, T. H. Yang, J. Y. Lee, *High-temperature Gibbs states are uniformly Markovian and trivial*, [arXiv:2611.26626v1](https://arxiv.org/html/2611.26626v1), 2026-11-19。目标见 §6 式 (6.5)，信息收缩见 Lemmas 7–8 与 §5.2。近期预印本。

2. **MM：构造先例。** R. L. Mann, R. M. Minko, *Algorithmic Cluster Expansions for Quantum Problems*, PRX Quantum **5**, 010305 (2024), [arXiv:2306.08974v2](https://arxiv.org/html/2306.08974v2)。有序电路聚合物见 Lemma 12，Hamiltonian 包含–排除与词展开见 Lemmas 22–23。

3. **KP：标准收敛定理。** R. Kotecký, D. Preiss, *Cluster expansion for abstract polymer models*, Communications in Mathematical Physics **103**, 491–498 (1986)。本文使用的现代定式可同时查阅下一项。

4. **聚合物收敛与相关函数。** D. Ueltschi, *Cluster expansions and correlation functions*, Moscow Mathematical Journal **4**, 511–522 (2004), [arXiv:math-ph/0304003](https://arxiv.org/abs/math-ph/0304003)。与 KP 一起作为第 6 节的外部收敛输入。

5. **受限高温噪声结果。** Y. Zhang, S. Gopalakrishnan, *Conditional Mutual Information and Information-Theoretic Phases of Decohered Gibbs States*, [arXiv:2502.13210v1](https://arxiv.org/html/2502.13210v1)。Theorem A.1 明确其对易、单点、unital 和 commutation-preserving 条件。

6. **受限弱有限深度噪声结果。** Y. F. Zhang, S. Gopalakrishnan, *Stability of mixed-state phases under weak decoherence*, [arXiv:2511.01976v1](https://arxiv.org/html/2511.01976v1)。见 §II.2、§V、Appendix B 的 commuting-Pauli 与 stabilizer-mixing 条件。

7. **稳态快速混合结果。** P. Rosa-Ruiz, M. Scandi, Á. Capel, Á. M. Alhambra, *Static features from mixing in short- and long-range Lindbladians: Markov property and correlations*, [arXiv:2606.28054v2](https://arxiv.org/html/2606.28054v2)。Theorem 3.3 的对象是满足额外假设的固定点。

8. **局部信道的稳态 Gibbs 展开。** I. Arad, R. Firanko, O. Gurevich, *Local quantum channels giving rise to quasi-local Gibbs states*, [arXiv:2408.08672v2](https://arxiv.org/html/2408.08672v2)。比较 Theorem 3.1、Corollary 3.2 及 §6 对系数范数界的限定。

9. **弱信道不稳定性。** D. C. Newsom, M. Levin, *An Instability of the Quantum Markov Length*, [arXiv:2610.12929v3](https://arxiv.org/html/2610.12929v3)。用于说明不能推广到所有有限 Markov length 输入，不作为本文正面证明的输入。

10. **无穷小耗散不稳定性。** A.-R. Negari, Y. Zou, T. H. Hsieh, *Instability of Markov chains under infinitesimal coherent dissipation*, [arXiv:2610.18983v1](https://arxiv.org/abs/2610.18983)。同样是适用边界的背景来源，不作为本文证明的输入。

**编辑说明。** 中文稿使用生成式 AI 辅助编辑。
