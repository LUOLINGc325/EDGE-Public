# 稀疏 Pauli–Lindblad 误差消除的奇偶最优性与图割规律

**AI 辅助研究稿 · 2026 年 11 月 24 日**  
目标读者：量子信息、理论计算机科学方向的博士研究生与研究者。

## 摘要

在稀疏 Pauli–Lindblad 噪声模型中，逐个采样逆生成元的标准概率误差消除方案具有显式乘法成本。已知将相同 Pauli 修正项合并可以降低成本，但仅凭生成元列表，何时能够严格降低、降低量何时开始出现，以及强噪声下的精确增长指数，仍需要结构性描述。本文对精确、全信道、无偏的 CPTP 实线性分解给出这样的描述：逐项成本最优，当且仅当所有活跃标签的二进制依赖均为偶长；若最短奇依赖的长度为 $2h-1$，成本节省恰从 $t^h$ 开始，并有不重复计数的显式首项。对图上相关 $ZZ$ 噪声，最优性等价于图的二分性，强噪声指数等于加权最大割的两倍。进一步，用有理局部信道构造证明最优成本的双边因子 2 估计为 NP-hard。给出精确有理证书和小规模量子矩阵核验。

本文使用既有的正交酉分解成本定理，并将已有的 Pauli 合并方法归于前人。新颖性判断限于已核验文献。Lean 补充涉及有限正权分组、二进制奇偶判据及其严格不等式。全文的量子桥接、渐近、图论与复杂性结论由书面证明给出。本文尚未经外部同行评议。

## 1. 问题与已有工作

概率误差消除（probabilistic error cancellation，PEC）把一个不可直接物理实现的逆噪声映射写成可实现信道的实线性组合。实验按系数绝对值采样，再用系数符号和归一化因子修正测量值。设系数绝对值之和为 $\Gamma$；对有界测量结果，标准估计器的二阶矩由 $\Gamma^2$ 控制。因此，减少 $\Gamma$ 具有直接的采样成本意义。

van den Berg 等 [2] 给出可扩展的稀疏 Pauli–Lindblad 学习与分项反演方案。Jin 等 [3] 在式 (22) 后明确区分整信道反演与逐因子反演，并说明后者可能更昂贵；其后选择研究分项情形。Scheiber 等 [4] 已提出传播、合并 Pauli 修正并利用相消减少成本，附录还讨论了子群结构和 $X,Y,Z$ 三生成元例。因此，“合并可能降低成本”以及三生成元特例均不是本文的新发现。

本文研究的是这一已知机制的完整结构分类、弱噪声首项和强噪声图割规律。该问题是文献留下的结构性缺口，并非某个有编号的著名开放猜想。理论意义在于用可计算的二进制证书区分已经最优的分项方案与必有改进空间的方案，并量化改进幅度。实际硬件收益仍受噪声建模精度、修正门误差和经典计算成本影响。

## 2. 模型、成本与已知归约

### 2.1 活跃生成元

取 $n$ 比特 Pauli 标签空间 $\mathcal W=\mathbb F_2^{2n}$，标签按整体相位取商。令 $P_a$ 为标签 $a$ 的任一厄米酉 Pauli 代表，定义共轭信道

$$
\mathcal P_a(X)=P_aXP_a^\dagger.
$$

Pauli 矩阵本身可以反对易，但它们的共轭信道满足

$$
\mathcal P_a\mathcal P_b=\mathcal P_{a+b},
\qquad \mathcal P_a^2=\mathcal I.
$$

取互不相同的非零标签 $a_1,\ldots,a_m$ 和正速率 $w_j>0$。零速率项删除；恒等标签不产生噪声；重复标签可先合并速率。设

$$
\mathcal L=\sum_{j=1}^m w_j(\mathcal P_{a_j}-\mathcal I),
\quad \mathcal N_t=e^{t\mathcal L},
\quad W=\sum_jw_j,
\quad t\ge0.
$$

记 $V=\operatorname{span}_{\mathbb F_2}\{a_1,\ldots,a_m\}$、$r=\dim V$，并定义

$$
A:\mathbb F_2^m\longrightarrow V,
\qquad As=\sum_js_ja_j.
$$

对子集 $S\subseteq[m]$，写 $a(S)=\sum_{j\in S}a_j$，$w(S)=\prod_{j\in S}w_j$。空积为 1。

本文要求正速率的 Markovian 模型，不将任意 Pauli 对角信道都视作具有正速率的这种表示。后续强噪声极限保持有限模型固定。

### 2.2 分解范围

定义

$$
\Gamma(t)=\inf\left\{\sum_k|c_k|:
\mathcal N_t^{-1}=\sum_kc_k\mathcal C_k,\quad
c_k\in\mathbb R,\quad\mathcal C_k\text{ 为 CPTP 信道}\right\}.
\tag{1}
$$

分解取有限项，比较范围允许任意完全正且保迹（CPTP）的理想修正信道。目标是对所有输入态和可观测量均成立的精确信道等式。这个成本概念不包含有偏缓解、仅针对某一可观测量的估计、带后选择的其他操作模型，也不计修正门本身的噪声。

### 2.3 系数与正负质量

令

$$
\alpha_j(t)=\frac{1+e^{2tw_j}}2,
\qquad\beta_j(t)=\frac{e^{2tw_j}-1}2.
$$

利用共轭信道的对合性，有

$$
e^{-tw_j(\mathcal P_{a_j}-\mathcal I)}
=\alpha_j(t)\mathcal I-\beta_j(t)\mathcal P_{a_j}.
$$

证明只需分别作用于 $\mathcal P_{a_j}$ 的 $+1$ 和 $-1$ 特征空间：两边的特征值均为 1 和 $e^{2tw_j}$。由于这些信道相互可交换，展开乘积得

$$
\mathcal N_t^{-1}
=\sum_{S\subseteq[m]}(-1)^{|S|}B_S(t)\mathcal P_{a(S)},
\quad
B_S(t)=\prod_{j\notin S}\alpha_j(t)\prod_{j\in S}\beta_j(t).
\tag{2}
$$

当 $t>0$ 时，所有 $B_S(t)$ 严格为正。按最终标签分组：

$$
E_g=\sum_{\substack{a(S)=g\\ |S|\text{ 为偶数}}}B_S,
\qquad
O_g=\sum_{\substack{a(S)=g\\ |S|\text{ 为奇数}}}B_S,
\qquad q_g=E_g-O_g.
\tag{3}
$$

**引理 1（已有的正交酉成本定理）。**

$$
\Gamma(t)=\sum_{g\in V}|q_g(t)|.
\tag{4}
$$

这是 Jiang、Wang 与 Wang [1] 定理 13 的 Pauli 特例。以下证明用于明确归一化，不作为原创贡献。令
$|\Omega\rangle=2^{-n/2}\sum_x|x,x\rangle$，则归一化 Choi 算子为

$$
J(\mathcal N_t^{-1})
=\sum_gq_g|\Omega_g\rangle\langle\Omega_g|,
\qquad |\Omega_g\rangle=(I\otimes P_g)|\Omega\rangle.
$$

不同 Pauli 的 Hilbert–Schmidt 正交性保证 $|\Omega_g\rangle$ 正交归一，故该 Choi 算子的迹范数等于 $\sum_g|q_g|$。任一 CPTP 信道的归一化 Choi 算子均为迹为 1 的正算子，其迹范数为 1。迹范数三角不等式给出所有式 (1) 分解的下界 $\sum_g|q_g|$。合并后的 Pauli 分解达到该界，因而下确界实际取得。保迹性还给出 $\sum_gq_g=1$。证毕。

逐生成元采样的成本为

$$
\Gamma_{\rm fac}(t)=\prod_j(\alpha_j+\beta_j)
=e^{2tW}=\sum_g(E_g+O_g).
$$

从而有精确差额恒等式

$$
\boxed{\Gamma_{\rm fac}(t)-\Gamma(t)
=2\sum_{g\in V}\min(E_g(t),O_g(t)).}
\tag{5}
$$

## 3. 逐项反演何时已经最优

**定理 2（一般奇偶判据）。** 下列条件等价：

1. 至少存在一个 $t>0$，使 $\Gamma(t)=\Gamma_{\rm fac}(t)$。
2. 对每个 $t>0$，均有 $\Gamma(t)=\Gamma_{\rm fac}(t)$。
3. 每个二进制依赖均为偶长，即 $\ker A\subseteq\ker\pi$，其中 $\pi(s)=\sum_js_j\in\mathbb F_2$。
4. 存在线性泛函 $\ell:V\to\mathbb F_2$，满足 $\ell(a_j)=1$ 对所有 $j$ 成立。
5. 存在一个 Pauli 算符 $Q$，与全部活跃 $P_{a_j}$ 反对易。

若这些条件不成立，则对每个 $t>0$，都有严格不等式 $\Gamma(t)<\Gamma_{\rm fac}(t)$。

**证明。** 固定 $t>0$。由所有子集权重为正及式 (5)，等号成立，当且仅当不存在一个标签同时有偶数大小和奇数大小的表示。两个表示 $S,T$ 的标签相同，当且仅当 $S\triangle T$ 是核向量；二者奇偶不同，当且仅当这个核向量为奇长。反过来，若存在奇长核子集 $D$，则 $D$ 与空集都表示标签零，所以 $E_0,O_0$ 均为正，式 (5) 严格为正。这同时证明了条件 1、2、3 的等价和全正时间的严格性。

若条件 3 成立，定义 $\ell(As)=\pi(s)$。同一像的两个原像之差在核内，其奇偶相同，因此定义良好且线性；对每个标准基向量得 $\ell(a_j)=1$。反之，条件 4 给出 $\pi=\ell\circ A$，从而条件 3 成立。

把 $\ell$ 通过补基扩张到整个 $\mathcal W$。Pauli 标签的辛形式非退化，所以存在 $b\in\mathcal W$，使这个扩张等于 $a\mapsto[b,a]$。取 $Q=P_b$；条件 $[b,a_j]=1$ 恰是反对易条件。反向推理相同，条件 4 与 5 等价。证毕。

这个证书有物理含义：

$$
\mathcal N_t(Q)=e^{-2tW}Q,
\qquad\mathcal N_t^{-1}(Q)=e^{2tW}Q.
$$

是否存在这样的 $Q$，可通过求解二进制线性方程 $\ell(a_j)=1$ 判定。高斯消元或者给出泛函，或者给出一个奇长依赖作为严格节省的证据；这个判定对 $n,m$ 为多项式时间，不需要展开所有子集。

边界必须保留：$t=0$ 时所有模型的两个成本都等于 1；如果速率为零，需要先移除相应生成元再使用判据。所谓“依赖”按整体相位取商，不要求 Pauli 矩阵相互对易。

## 4. 弱噪声：最短奇依赖决定首次节省

假设存在奇长依赖，定义

$$
g_* =\min\{|D|:a(D)=0,\ |D|\text{ 为奇数}\}=2h-1.
$$

由于所有标签非零，$g_*\ge3$。令

$$
\mathcal H=\left\{S\subseteq[m]:|S|=h,
\ \exists T\subseteq[m],\ |T|=h-1,\ a(T)=a(S)\right\}.
\tag{6}
$$

这里是子集 $S$ 的集合。同一个 $S$ 即使有多个搭配 $T$，也只出现一次。

**定理 3（精确首项）。** 保持生成元与正速率固定，当 $t\downarrow0$ 时，

$$
\boxed{\Gamma_{\rm fac}(t)-\Gamma(t)
=2t^h\sum_{S\in\mathcal H}w(S)+O(t^{h+1}).}
\tag{7}
$$

首项系数严格为正，故第一次非零节省的阶数恰为 $(g_*+1)/2$。

**证明。** 令 $d_\varepsilon(g)$ 为标签 $g$ 的表示中，具有奇偶性 $\varepsilon$ 的最小子集大小。将任意表示与一个固定奇长核子集作对称差，可以翻转奇偶而不改变标签，因此两个最小值都存在。泰勒展开给出

$$
B_S(t)=t^{|S|}w(S)+O(t^{|S|+1}).
$$

故每个奇偶类的质量，其首项次数为 $d_\varepsilon(g)$，首项系数为所有该最小大小表示的权重和。两个次数奇偶不同，不会相等。因此，当 $t$ 充分小时，$\min(E_g,O_g)$ 选择次数较大的那一项。

取两个达到最小值的表示 $S_0,S_1$。其对称差是奇长依赖，因而

$$
d_0(g)+d_1(g)\ge|S_0\triangle S_1|\ge2h-1.
$$

这说明 $\max(d_0,d_1)\ge h$。若最大值恰为 $h$，则另一个值最多 $h-1$，结合上式只能等于 $h-1$。所以这类标签的首项恰来自所有 $h$ 元表示；其余标签的贡献为 $O(t^{h+1})$。

一个 $h$ 元子集具有式 (6) 的搭配，当且仅当其标签的两种最小表示大小为 $h,h-1$。沿标签求和时，每个这样的 $h$ 元子集恰被计算一次。代入式 (5)，得到式 (7)。最后，将一个最短奇长依赖任意分成大小 $h$ 和 $h-1$ 的两部分，就得到 $\mathcal H$ 的一个成员。所有速率为正，系数也严格为正。证毕。

最短奇依赖也是一个二进制拟阵回路：若包含更小的非空依赖，则该依赖为奇数时直接矛盾，为偶数时删除它便得到更短的奇依赖。这个事实解释了为何短局部回路适合构造可实现的降本块。

## 5. 强噪声的精确指数与余项

取 $V$ 的对偶空间 $V^*$。对 $\ell\in V^*$，把 $\ell(a_j)$ 看作实数 0 或 1，定义

$$
C(\ell)=\sum_jw_j\ell(a_j),
\qquad M=\max_{\ell\in V^*}C(\ell).
$$

**引理 4（有限 Fourier 公式）。**

$$
\widehat q_t(\ell)=\sum_gq_g(t)(-1)^{\ell(g)}=e^{2tC(\ell)},
\quad
q_g(t)=2^{-r}\sum_{\ell\in V^*}(-1)^{\ell(g)}e^{2tC(\ell)}.
\tag{8}
$$

**证明。** 把字符 $g\mapsto(-1)^{\ell(g)}$ 作用于式 (2) 的乘积。第 $j$ 个因子在 $\ell(a_j)=0$ 时为 $\alpha_j-\beta_j=1$，在 $\ell(a_j)=1$ 时为 $\alpha_j+\beta_j=e^{2tw_j}$，相乘得第一式。由有限二进制字符的正交关系反演得第二式。证毕。

**定理 5（有限时间界与精确指数）。** 对每个 $t\ge0$，

$$
\boxed{e^{2tM}\le\Gamma(t)
\le\min\{e^{2tW},\ 2^{r/2}e^{2tM}\}.}
\tag{9}
$$

所以对固定有限模型，

$$
\lim_{t\to\infty}\frac{\log\Gamma(t)}t=2M,
\qquad
\lim_{t\to\infty}\frac{\log(\Gamma_{\rm fac}(t)/\Gamma(t))}t=2(W-M).
\tag{10}
$$

**证明。** 每个 Fourier 系数的绝对值均不超过 $\sum_g|q_g|$，给出下界。Cauchy–Schwarz 与 Parseval 等式给出

$$
\Gamma(t)^2\le2^r\sum_gq_g(t)^2
=\sum_{\ell\in V^*}e^{4tC(\ell)}
\le2^re^{4tM}.
$$

另外，直接分项分解给出 $\Gamma\le e^{2tW}$。取对数后除以 $t$，由于 $r$ 固定即得极限。证毕。

由于所有速率为正，$M=W$ 当且仅当存在一个泛函在全部生成元上取值 1，与定理 2 完全一致。

还可以确定领先系数。令 $\mathcal B=\{\ell:C(\ell)=M\}$、$b=|\mathcal B|$、$N=2^r$，并置

$$
K=\frac1N\sum_{g\in V}\left|\sum_{\ell\in\mathcal B}(-1)^{\ell(g)}\right|.
$$

若 $\mathcal B\ne V^*$，令 $\Delta=M-\max_{\ell\notin\mathcal B}C(\ell)>0$，则

$$
\left|e^{-2tM}\Gamma(t)-K\right|
\le\sqrt{N-b}\,e^{-2t\Delta},
\qquad 1\le K\le\sqrt b.
\tag{11}
$$

证明如下：归一化后的 Fourier 向量趋于 $\mathcal B$ 的指标向量，剩余 $N-b$ 个坐标均至多 $e^{-2t\Delta}$。对它们的逆变换使用 Parseval 与 Cauchy–Schwarz，得到一范数上界；再用范数的反三角不等式得到第一式。取一个值为 1 的 Fourier 系数给出 $K\ge1$，对指标向量再次用同一范数估计给出 $K\le\sqrt b$。若 $\mathcal B=V^*$，余项为零；空生成元模型属于这一退化情形。

## 6. 图上相关相位噪声

令 $G=(U,E)$ 为有限简单图。每条边 $e=\{u,v\}$ 对应跳跃算符 $Z_uZ_v$ 和正权重 $w_e$：

$$
\mathcal L_G=\sum_{\{u,v\}\in E}w_{uv}
 (\operatorname{Ad}_{Z_uZ_v}-\mathcal I).
\tag{12}
$$

其二进制标签为顶点空间中的 $e_u+e_v$。记 $c(G)$ 为包含孤立点在内的连通分量数，$n=|U|$。

**推论 6（二分性与奇圈）。** 逐项成本最优，当且仅当 $G$ 是二分图。非二分图的最短奇依赖长度等于最短奇圈长度。

**证明。** 顶点位向量 $x$ 所定义的泛函在边 $e_u+e_v$ 上取值 1，当且仅当 $x_u\ne x_v$。所以定理 2 的泛函证书恰是二染色。另一方面，边标签之和为零意味着每个顶点的入选边度数为偶数。这种边集可分解为边不相交的圈：沿未使用的边形成闭路，取出一个圈，然后重复。若总边数为奇数，至少有一个奇圈；反之，每个奇圈都是奇依赖。因此两个最短长度相等。证毕。

例如，若图含三角形，则

$$
\Gamma_{\rm fac}(t)-\Gamma(t)
=2t^2\sum_{\{i,j,k\}\text{ 为三角形}}
(w_{ij}w_{ik}+w_{ij}w_{jk}+w_{ik}w_{jk})+O(t^3).
\tag{13}
$$

两个不同边与一个边具有相同标签，恰意味着它们组成被该边闭合的两边路径；在简单图中闭合边唯一，所以这里不会重复计数。等权图的首项为三角形个数的 $6t^2$ 倍。

**推论 7（加权最大割规律）。** 定义

$$
\operatorname{mc}_w(G)=
\max_{x\in\{0,1\}^{U}}\sum_{\{u,v\}\in E}w_{uv}\mathbf1\{x_u\ne x_v\}.
$$

则 $r=n-c(G)$，并有

$$
e^{2t\operatorname{mc}_w(G)}\le\Gamma_G(t)
\le2^{(n-c(G))/2}e^{2t\operatorname{mc}_w(G)}.
\tag{14}
$$

特别地，最优一范数成本的强噪声指数是 $2\operatorname{mc}_w(G)$，对应平方采样成本的指数是 $4\operatorname{mc}_w(G)$。

**证明。** 在每个连通分量内，一棵生成树的边标签线性独立，且任一其他边可写成连接其端点的树路径标签和。因此边标签张成该分量的偶校验空间，维数为顶点数减 1，得到秩公式。每个标签空间泛函都能扩张到顶点空间，由顶点位向量 $x$ 表示；在边上取值正是该边是否跨割。因此 $M$ 等于加权最大割。代入定理 5 即得。证毕。

## 7. 有限有理输入上的求值困难

强噪声极限本身不足以证明有限输入求值困难。下面显式给出一个有理编码的归约。输入以局部边信道列表表示，不要求提供指数大的全信道矩阵。

**推论 8（因子 2 估计的 NP-hardness）。** 对这一类简洁编码的相关 $ZZ$ 信道，若能在输入长度的多项式时间内输出一个有理数 $\widehat\Gamma$，满足

$$
\Gamma/2\le\widehat\Gamma\le2\Gamma,
$$

则无权简单图最大割有多项式时间算法。

**证明。** 给定 $n\ge1$ 顶点的简单图，令 $Q=2^{n+2}$。每条边输入有理局部信道

$$
\mathcal D_e=\frac{1+Q^{-1}}2\mathcal I
+\frac{1-Q^{-1}}2\operatorname{Ad}_{Z_uZ_v}.
\tag{15}
$$

这等价于单位速率、时间 $t=\frac12\log Q$ 的模型，但输入只含有理系数，不依赖无理数的精确编码。其每条边的参数长度为 $O(n)$。若最大割整数为 $k$，由式 (14) 得

$$
Q^k\le\Gamma\le2^{r/2}Q^k.
$$

由近似保证得

$$
Q^k\le2\widehat\Gamma
\le4\,2^{r/2}Q^k<Q^{k+1},
$$

因为 $r\le n$ 且 $4\,2^{n/2}<2^{n+2}=Q$。因此，只需将有理数 $2\widehat\Gamma$ 与 $Q^j$ 作精确比较，即可恢复唯一整数 $k$。所有比较数的位长对 $n,|E|$ 为多项式；无需数值计算对数。无权简单最大割的 NP-hardness 来自 [5]，归约完成。证毕。

这里的困难性针对以有理局部信道参数给出的强噪声实例，不声称相同结论已对固定的弱噪声率成立，也不声称输入为有理 Lindblad 速率时已完成同一归约。

## 8. 精确算例与可实现的局部降本

若一组 $k$ 个生成元构成一个二进制回路，即唯一非空核子集是全部生成元，则两个子集表示同一标签，当且仅当它们相等或互补。偶数 $k$ 时两个互补子集同号，成本没有节省。奇数 $k$ 时

$$
\Gamma_D(t)=\frac12\sum_{S\subseteq D}|B_S(t)-B_{D\setminus S}(t)|.
\tag{16}
$$

令 $p_j=(1-e^{-2tw_j})/2$，$\mu$ 为这些独立 Bernoulli 位的乘积分布，$\mu^c(S)=\mu(D\setminus S)$。归一化式 (16) 得

$$
\frac{\Gamma_D}{\Gamma_{{\rm fac},D}}
=\frac12\sum_S|\mu(S)-\mu^c(S)|.
$$

等权 $w_j=w$、$k=2h-1$ 且 $t>0$ 时，$\mu(S)>\mu^c(S)$ 恰在 $|S|<k/2$，因而

$$
\Gamma_D(t)=e^{2tkw}
\left[1-2\sum_{j=h}^k\binom kjp^j(1-p)^{k-j}\right],
\quad p=(1-e^{-2tw})/2.
\tag{17}
$$

在 $t=0$ 时，式 (17) 可直接核验，亦由连续性成立。

三角形在单位边权下给出

$$
\Gamma_{\triangle}(t)=\frac{3e^{4t}-1}{2},
\qquad\Gamma_{{\rm fac},\triangle}(t)=e^{6t}.
$$

该式与已知单比特退极化反演具有相同系数代数，本文用它作为一致性检查。下表还列出五圈和重叠五圈的精确证书值，令 $z=e^{2t}=2$：

| 模型 | 最短奇依赖 | 节省的首项 | $\Gamma_{\rm fac}$ | $\Gamma$ |
| --- | --- | --- | ---: | ---: |
| 三角形 | 3 | $6t^2$ | 8 | $11/2$ |
| 四圈 | 不存在 | 恒为 0 | 16 | 16 |
| 五圈 | 5 | $20t^3$ | 32 | $203/8$ |
| 三条路径长度为 $(3,2,2)$ 的 theta 图 | 5 | $38t^3$ | 128 | $1471/16$ |

最后一个图由两个端点间三条内部顶点互不相交的路径组成。两个五圈共享长度为 3 的路径。每个五圈有 10 个三边子集，但共享的三边路径只能计一次，因此系数是 $2(10+10-1)=38$。这个例子直接说明逐个奇圈求和会过计数。

*Figure: 图 1：由解析 Fourier 公式绘制的成本变化。左图是平方成本比；右图比较精确有限模型曲线与弱噪声首项。数据不是硬件测量。*

矢量图文件。

对一般生成元列表，可以先把索引分成小块，在每个块内合并，再对块的逆映射作乘积采样。若块成本为 $\Gamma_B$，则所得具体方案具有乘法成本 $\prod_B\Gamma_B$，所以

$$
\Gamma(t)\le\prod_B\Gamma_B(t).
$$

这给出用不相交短奇回路获得可认证改进的做法。它不保证已达到整体最优；任意高秩实例的精确展开仍可能需要指数级经典计算。

## 9. 验证覆盖与可复现性

核心证书只使用 Python 标准库的整数与有理数运算。独立实现的乘积卷积、直接子集展开和 Walsh 反演相互比较，核验归一化、奇偶最优性及精确差额。已完成：

- $\mathbb F_2^3$ 的全部 127 个非空、互异生成元族，各用两组正参数，共 254 个实例。
- 1 至 5 个顶点的全部 1,099 个标号简单图，使用独立二染色判定核对等号条件。
- 同样 1,099 个图的有限有理参数最大割恢复及平方形式的范数上界；使用与归约一致的 $Q=2^{n+2}$，并检查因子 2 近似允许区间的两个端点，共 2,198 次端点恢复。内部值由阈值比较的单调性覆盖。
- 奇圈长度 3、5、7、9，各用四个有理参数，共 16 个精确公式检验。
- 三角形、四圈、五圈和重叠五圈的直接泰勒展开；同时检查等权与异质整数权重。
- 36 个一至三比特的实际复 Pauli 超算子和归一化 Choi 矩阵数值检查。最大 Choi 成本绝对误差为 $1.14\times10^{-13}$，允许容差为 $2\times10^{-9}$。

有限检验不替代全称定理的书面证明。绘图使用浮点数，仅作解释。Lean 已完成的一般部分与未完成部分在 `formalization/README.md` 逐项映射；全文形式化状态为部分完成，不能把这组核心内核检查解释为所有物理与复杂性结论都已通过 Lean。

## 10. 研究结论的实际边界

结构判据回答“是否存在严格降本空间”；弱噪声首项回答“多小的噪声开始出现多大改进”；最大割规律回答“固定有限相关噪声模型的长期指数由什么决定”。三者均在同一个全信道、无偏、理想修正操作模型内成立。

后续可以研究固定弱噪声率的近似复杂性、具有更多图结构的高效采样、带参数学习误差的稳定性，以及非理想修正门的可用操作集。这些问题不属于本稿已证结论。当前查新未发现核心结构命题的同范围表述；这不构成全球优先权认证，也不能据此确定期刊档次或最终学术影响。

## 参考文献

[1] Jiaqing Jiang, Kun Wang, Xin Wang. *Physical Implementability of Linear Maps and Its Application in Error Mitigation*. Quantum 5, 600 (2021). 定理 13，式 (121)。[DOI](https://doi.org/10.22331/q-2021-12-07-600)；[作者稿](https://arxiv.org/abs/2012.10959)。

[2] Ewout van den Berg, Zlatko K. Minev, Abhinav Kandala, Kristan Temme. *Probabilistic error cancellation with sparse Pauli–Lindblad models on noisy quantum processors*. Nature Physics 19, 1116–1121 (2023). [DOI](https://doi.org/10.1038/s41567-023-02042-2)；[作者稿](https://arxiv.org/abs/2201.09866)。

[3] Tian-Ren Jin, Yu-Ran Zhang, Kai Xu, Heng Fan. *Noisy probabilistic error cancellation and generalized physical implementability*. Communications Physics 8, 296 (2025). 式 (22) 及其后讨论。[DOI](https://doi.org/10.1038/s42005-025-02217-8)；[作者稿 v2](https://arxiv.org/abs/2409.01000v2)。

[4] Timon Scheiber, Paul Haubenwallner, Matthias Heller. *Reduced Sampling Overhead for Probabilistic Error Cancellation by Pauli Error Propagation*. Quantum 9, 1840 (2025). 第 3 节和附录 E–F。[DOI](https://doi.org/10.22331/q-2025-08-29-1840)；[作者稿](https://arxiv.org/abs/2412.01311)。

[5] Michael R. Garey, David S. Johnson, Larry Stockmeyer. *Some simplified NP-complete graph problems*. Theoretical Computer Science 1(3), 237–267 (1976). 无权 Simple Max Cut 的复杂性结论。[DOI](https://doi.org/10.1016/0304-3975(76)90059-1)。
