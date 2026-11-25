# 循环 Bell 纠缠交换链的尖锐乘法系数

**研究稿 · 2026 年 11 月 24 日**  
**领域：** 量子信息与量子通信  
**读者层级：** 博士研究者  
**状态：** AI 辅助研究稿，未声称通过外部同行评议。本版本未附计算程序及 Lean 源码。

## 摘要

对于由 $m\ge2$ 条独立纯态链路组成、局部维数为 $d\ge2$ 的链，在每个内部节点执行固定的循环广义 Bell 测量，并保留全部测量结果。本文确定了端点平均纠缠关于输入未缩放 $l_1$ 纠缠量乘积的最小统一系数：偶数维为 $1$，奇数维为 $2^{1-m}$。我们从实际未归一化条件态出发，将操作性平均精确分解为循环振幅自相关的乘积和，完整处理零概率分支；随后给出以非零支撑差集表述的充要等号条件、端点平均纠缠为零的精确判据，以及覆盖全部维数和链长的归一化有理数饱和输入。结论针对固定测量协议及相对于输入资源乘积的系数，不涉及测量基优化，也不是端点纠缠量的普遍绝对衰减定律。

## 1. 问题与已有工作的关系

Starke、Basso、Céleri 与 Maziero [1] 在式 (41) 中给出了两链路概率加权输出的有限求和表达，在式 (43) 中证明了系数为 $1$ 的乘积上界，并在二维、三维分别得到了精确系数 $1$、$1/2$。其式 (59) 将一般维数的系数猜想为 $1/(d-1)$。已有 trureturing 研究记录 [2] 在四维反驳了该猜想，并明确留下尖锐替代界问题。本文承认此前反例及既有两链路恒等式的归属。

本文研究的是任意维数、任意链长下的最小**统一乘法系数**，并同时确定全部等号条件和零输出条件。证明中真正需要保留的信息是：每条输入的支撑必须共同包含同一个非零位移。位移与其相反数配对；循环群中存在非零自反位移，当且仅当维数为偶数。

两条四维链路的特例也属于同期固定资源项目声明的研究范围；本文不假定该项目已经得到完整结果，也不对该特例单独主张优先权。本稿处理所有 $d,m$ 的统一系数，不求每一对给定资源值下的完整最优函数。有限范围的文献检索不能确立全球优先权。纯量子比特链的乘积规律也是已有结果 [3]；该文的高维分析使用 I-concurrence，与本文固定的未缩放 $l_1$ 纠缠量不同。

作为补充背景，我们核查了多体纠缠交换预印本 [4] 在索引中可取得的原始摘要，未取得其原始全文。该文不作为本稿证明的依据，本文也不声称已全面排除相关先行结果。文献比较限于实际获得的材料。

## 2. 协议与记号

固定整数 $d\ge2$、$m\ge2$，所有标号均属于加法循环群 $G=\mathbb Z_d$。第 $\ell$ 条链路连接系统 $L_\ell,R_\ell$，初态为

$$
|\psi_\ell\rangle
 =\sum_{x\in G}c_\ell(x)|x\rangle_{L_\ell}|x\rangle_{R_\ell},
\qquad
\sum_{x\in G}|c_\ell(x)|^2=1,
\qquad 1\le\ell\le m.
\tag{1}
$$

各条链路相互独立，联合初态为这些纯态的张量积。振幅允许为任意复数，也允许为零。记 $a_\ell(x)=|c_\ell(x)|$。

对于归一化状态 $\sum_x b(x)|\sigma(x)\rangle|x\rangle$，其中 $\sigma$ 为置换，本文使用下列未缩放的有序对纠缠量：

$$
E(b)=\sum_{x\ne y}|b(x)b(y)|.
\tag{2}
$$

特别地，$E_\ell=E(c_\ell)$。每一对不同标号的两个顺序都计入求和，并且不除以 $d-1$。本文的“未归一化纠缠量”始终指未按维数缩放的量；输入量子态本身均已归一化。

在内部节点 $t$，对系统 $R_t,L_{t+1}$ 执行固定的 Bell 基测量：

$$
|B_{p,q}\rangle
 =\frac1{\sqrt d}\sum_{k\in G}\omega^{qk}
 |p+k\rangle_{R_t}|k\rangle_{L_{t+1}},
\qquad
\omega=e^{2\pi i/d}.
\tag{3}
$$

指数中可取剩余类的整数代表元，结果不依赖代表元选择。投影使用 Bell bra，因此收缩时相位取复共轭。将所有 $q$ 标号反向，只改变相位约定，不改变平均量。

完整测量结果记为 $(p,q)\in G^{m-1}\times G^{m-1}$。用对应 Bell bra 收缩联合初态，所得端点 $L_1,R_m$ 上的未归一化向量为 $v_{p,q}$，其概率为 $P_{p,q}=\|v_{p,q}\|^2$。当 $P_{p,q}>0$ 时，在归一化向量 $v_{p,q}/\sqrt{P_{p,q}}$ 的 Schmidt 形式系数上计算式 (2)；当 $P_{p,q}=0$ 时，将该分支贡献定义为零。操作性平均为

$$
A_{d,m}(c_1,\ldots,c_m)
 =\sum_{p,q}P_{p,q}\,
 E\!\left(\frac{v_{p,q}}{\sqrt{P_{p,q}}}\right),
\tag{4}
$$

其中严格采用上述零分支约定。没有舍弃任何测量结果。

对 $r\in G$，定义循环振幅自相关及其非零支撑：

$$
C_\ell(r)=\sum_{x\in G}a_\ell(x)a_\ell(x+r),
\qquad
D_\ell=\{r\ne0:C_\ell(r)>0\}.
\tag{5}
$$

$D_\ell$ 恰好是输入实际占据标号的非零差集：

$$
D_\ell
 =\{r\ne0:\exists x,\ c_\ell(x)\ne0
                         \text{ 且 }c_\ell(x+r)\ne0\}.
\tag{6}
$$

这是因为式 (5) 中各项均非负，有限和严格为正当且仅当至少一项严格为正。

下面将使用一个初等循环群事实：非零自反元存在当且仅当 $d$ 为偶数，此时唯一的非零自反元是 $d/2$。确实，取其整数代表元 $u$ 满足 $1\le u<d$，自反条件意味着 $d\mid2u$。由 $0<2u<2d$，只能有 $2u=d$；反方向在偶数 $d$ 时直接代入 $u=d/2$ 即可。

## 3. 操作性平均的精确分解

### 定理 1：交换链分解公式

对于式 (1)–(4) 的协议，有

$$
\boxed{
A_{d,m}=\sum_{r\in G\setminus\{0\}}
             \prod_{\ell=1}^{m}C_\ell(r).}
\tag{7}
$$

并且

$$
C_\ell(r)\ge0,
\qquad C_\ell(-r)=C_\ell(r),
\qquad E_\ell=\sum_{r\ne0}C_\ell(r).
\tag{8}
$$

这些结论覆盖含零振幅的输入和零概率测量分支。

### 证明

令 $s_m=0$，并定义

$$
s_\ell=\sum_{t=\ell}^{m-1}p_t
\quad(1\le\ell<m).
\tag{9}
$$

展开输入张量积与各个 Bell bra。一个计算基标号组 $(x_1,\ldots,x_m)$ 保留下来，当且仅当每个内部节点均满足 $x_t=p_t+x_{t+1}$。取 $k=x_m$，则唯一保留下来的各链路标号为 $x_\ell=k+s_\ell$。因此

$$
v_{p,q}
 =d^{-(m-1)/2}\sum_{k\in G}b_{p,q}(k)
 |k+s_1\rangle|k\rangle,
\tag{10}
$$

其中

$$
b_{p,q}(k)
 =\left(\prod_{\ell=1}^{m}c_\ell(k+s_\ell)\right)
   \omega^{-\sum_{t=1}^{m-1}q_t(k+s_{t+1})}.
\tag{11}
$$

式 (10) 两端的标号分别构成正交基，因此除系数相位外，它已经是 Schmidt 形式。令

$$
w_p(k)=\prod_{\ell=1}^{m}a_\ell(k+s_\ell),
\qquad
Z_p=\sum_k w_p(k)^2.
\tag{12}
$$

式 (11) 的相位模长为一，故

$$
P_{p,q}=d^{-(m-1)}Z_p.
\tag{13}
$$

若 $Z_p>0$，归一化 Schmidt 系数的模为 $w_p(k)/\sqrt{Z_p}$。概率与纠缠量相乘，归一化因子恰好抵消：

$$
P_{p,q}E\!\left(v_{p,q}/\sqrt{P_{p,q}}\right)
 =d^{-(m-1)}\sum_{j\ne k}w_p(j)w_p(k).
\tag{14}
$$

若 $Z_p=0$，由非负性可知每个 $w_p(k)=0$，式 (14) 的右侧为零，按式 (4) 定义的分支贡献也为零。因此式 (14) 对所有分支成立，证明没有进行零概率除法。

相位结果 $q$ 共计 $d^{m-1}$ 个，而式 (14) 与 $q$ 无关。对其求和后得到

$$
A_{d,m}
 =\sum_{p\in G^{m-1}}\sum_{j\ne k}
       \prod_{\ell=1}^{m}
       a_\ell(j+s_\ell)a_\ell(k+s_\ell).
\tag{15}
$$

三角变换 $p\mapsto(s_1,\ldots,s_{m-1})$ 是双射，其逆为 $p_t=s_t-s_{t+1}$，其中 $s_m=0$。在式 (15) 中换元 $r=k-j\ne0$、$x_m=j$，以及 $x_\ell=j+s_\ell$（$\ell<m$）。固定 $r$ 后，所得变量恰好无重复地覆盖所有独立选择的 $x_1,\ldots,x_m\in G$。于是

$$
\begin{aligned}
A_{d,m}
 &=\sum_{r\ne0}\sum_{x_1,\ldots,x_m}
          \prod_{\ell=1}^{m}a_\ell(x_\ell)a_\ell(x_\ell+r)\\
 &=\sum_{r\ne0}\prod_{\ell=1}^{m}
          \left(\sum_{x_\ell}a_\ell(x_\ell)a_\ell(x_\ell+r)\right),
\end{aligned}
\tag{16}
$$

即式 (7)。以平移 $x\mapsto x-r$ 换元得到相反位移对称性；以双射 $(x,y)\leftrightarrow(x,r=y-x)$ 换元得到式 (8) 的最后一个恒等式。非负性直接来自定义。

相同的换元还检验了操作性概率的完整归一化：

$$
\sum_{p,q}P_{p,q}
 =\sum_{p,k}\prod_{\ell=1}^{m}a_\ell(k+s_\ell)^2
 =\prod_{\ell=1}^{m}\sum_x a_\ell(x)^2=1.
\tag{17}
$$

因此，式 (4) 的平均确实使用了全部测量概率。证毕。

## 4. 最小统一乘法系数

### 定理 2：尖锐乘积上界

使下式对式 (1) 中每一组归一化输入成立的最小实常数为

$$
A_{d,m}(c_1,\ldots,c_m)
 \le K(d,m)\prod_{\ell=1}^{m}E_\ell,
\tag{18}
$$

$$
\boxed{
K(d,m)=
\begin{cases}
1,&d\text{ 为偶数},\\
2^{1-m},&d\text{ 为奇数}.
\end{cases}}
\tag{19}
$$

### 上界证明

如果某个 $E_\ell=0$，式 (8) 迫使该链路的所有非零位移相关 $C_\ell(r)$ 均为零，再由式 (7) 得 $A_{d,m}=0$，从而式 (18) 成立。

以下设所有 $E_\ell>0$。对 $r\ne0$ 定义

$$
q_\ell(r)=\frac{C_\ell(r)}{E_\ell}.
\tag{20}
$$

每个 $q_\ell$ 都是 $G\setminus\{0\}$ 上在 $r\mapsto-r$ 下不变的概率分布，且

$$
\frac{A_{d,m}}{\prod_\ell E_\ell}
 =\sum_{r\ne0}\prod_{\ell=1}^{m}q_\ell(r).
\tag{21}
$$

当 $d$ 为偶数时，由 $q_\ell(r)\le1$，

$$
\sum_{r\ne0}\prod_{\ell=1}^{m}q_\ell(r)
 \le\sum_{r\ne0}q_m(r)=1.
\tag{22}
$$

当 $d$ 为奇数时，每个非零 $r$ 都不同于 $-r$。由对称性和归一化，

$$
2q_\ell(r)=q_\ell(r)+q_\ell(-r)\le1.
\tag{23}
$$

将式 (21) 的前 $m-1$ 个因子分别上界为 $1/2$，再对最后一个分布求和，得到

$$
\sum_{r\ne0}\prod_{\ell=1}^{m}q_\ell(r)
 \le2^{-(m-1)}\sum_{r\ne0}q_m(r)
 =2^{1-m}.
\tag{24}
$$

### 用归一化有理数输入证明最优性

若 $d$ 为偶数，令 $h=d/2\in G$。每条链路均取

$$
c_\ell(0)=\frac35,\qquad
c_\ell(h)=\frac45,\qquad
c_\ell(x)=0\quad\text{（其余标号）}.
\tag{25}
$$

两个占据标号不同，且 $9/25+16/25=1$，故输入已归一化。唯一非零位移为 $h=-h$，并有

$$
C_\ell(h)=\frac{24}{25},\qquad E_\ell=\frac{24}{25}.
\tag{26}
$$

于是 $A_{d,m}=(24/25)^m=\prod_\ell E_\ell$。

若 $d\ge3$ 为奇数，将式 (25) 中的 $h$ 换成 $1$。此时 $1\ne-1$，

$$
C_\ell(1)=C_\ell(-1)=\frac{12}{25},
\qquad E_\ell=\frac{24}{25},
\tag{27}
$$

其余非零位移的相关均为零，故

$$
A_{d,m}=2\left(\frac{12}{25}\right)^m
       =2^{1-m}\left(\frac{24}{25}\right)^m.
\tag{28}
$$

这些见证的输入纠缠乘积都严格为正。任何更小的系数都会在对应见证上失效，因此式 (19) 确为最小系数。证毕。

奇数维系数控制的是式 (21) 中的比值。对于较高 Schmidt 秩输入，未按维数缩放的 $E_\ell$ 可以超过一。因此，不能仅由式 (19) 宣称任意输入的端点纠缠绝对值按指数衰减。对于式 (25) 的具体双能级输入，精确值由式 (26)–(28) 给出。

## 5. 等号条件与零输出判据

### 定理 3：精确等号条件

如果某个 $E_\ell=0$，式 (18) 两侧均为零，因而取等。以下设所有 $E_\ell>0$。

1. 偶数维中取等，当且仅当
   $$
   D_\ell=\{d/2\}\qquad\text{对每条链路 }\ell\text{ 成立}.
   \tag{29}
   $$
2. 奇数维中取等，当且仅当存在共同的 $r\ne0$，使
   $$
   D_\ell=\{r,-r\}\qquad\text{对每条链路 }\ell\text{ 成立}.
   \tag{30}
   $$

这里的支撑差集始终是固定测量基下实际占据标号的差集。

### 证明

先设式 (22) 取等。因 $q_m$ 的总质量为一，可选 $r_0$ 满足 $q_m(r_0)>0$。式 (22) 两侧之差的每一项都非负，故取等迫使

$$
\prod_{\ell=1}^{m-1}q_\ell(r_0)=1.
\tag{31}
$$

各因子均属于 $[0,1]$，所以前 $m-1$ 个分布在 $r_0$ 上的质量全部为一，并由归一化知它们在其他位置都为零。因 $m\ge2$，至少存在一个这样的分布。式 (22) 取等进一步迫使 $q_m(r_0)=1$。相反位移对称性于是给出 $r_0=-r_0$。偶数循环群唯一的非零自反元为 $d/2$，得到式 (29)。反过来，式 (29) 使每个 $q_\ell$ 都集中于 $d/2$，式 (21) 自然等于一。

当 $d$ 为奇数时，式 (24) 取等同样迫使每个满足 $q_m(r)>0$ 的 $r$ 都满足

$$
\prod_{\ell=1}^{m-1}q_\ell(r)=2^{-(m-1)}.
\tag{32}
$$

每个因子属于 $[0,1/2]$，因此全部等于 $1/2$。选取一个这样的 $r_0$，由对称性与归一化，前 $m-1$ 个分布都恰好在 $\{r_0,-r_0\}$ 上各取一半质量。等号又迫使 $q_m$ 的支撑包含于同一对位移，而其对称性使两处质量均为 $1/2$。由于 $q_\ell(r)>0$ 当且仅当 $r\in D_\ell$，式 (30) 得证。反过来，式 (30) 与对称性迫使所有分布均为上述二点等质量分布，代入式 (21) 就得到 $2^{1-m}$。证毕。

### 定理 4：精确零输出条件

对所有允许的输入，包括含有 $E_\ell=0$ 的情况，

$$
\boxed{
A_{d,m}=0
\quad\Longleftrightarrow\quad
\bigcap_{\ell=1}^{m}D_\ell=\varnothing.}
\tag{33}
$$

### 证明

式 (7) 的每个求和项均非负。固定非零 $r$，该项乘积严格为正，当且仅当每条链路都满足 $C_\ell(r)>0$，亦即 $r\in\bigcap_\ell D_\ell$。有限个非负数之和为零，当且仅当没有任何一项为正。证毕。

一个非平凡零输出例子如下：取 $d=5,m=2$，第一条输入在标号 $0,1$ 上分别取振幅 $3/5,4/5$，第二条输入在 $0,2$ 上取相同振幅。两条输入都已归一化，且 $E_\ell=24/25>0$。非零差集分别为 $\{1,4\}$ 和 $\{2,3\}$，互不相交。因此，指定 Bell 测量下由式 (33) 得 $A_{5,2}=0$。该例子的结论限定于所规定的测量与输入对齐方式。

## 6. 意义、范围与复现

控制资源乘积比值的精确对象，是各链路位移概率分布 $q_\ell$ 的共同重合量。奇数循环维中，每个非零位移必须与不同于自身的相反位移分享质量；偶数循环群则允许单个非零自反位移，有理数见证将全部位移质量集中于此。由此无需渐近分析，也无需逐个估计测量分支，就能确定奇偶系数。

本文假设独立纯态输入、共同局部维数、指定计算基中的 Schmidt 对齐、所有内部节点上的标准循环 Bell 测量，以及对全部结果求平均。结论不覆盖任意混态输入、优化后的 Bell 基、任意局部预处理或优化后的 LOCC 中继协议。纠缠量的缩放约定始终由式 (2) 固定。

原稿报告两条不同的计算路线。`code/exact_certificate.py` 计算精确有理数自相关，并在明确列出的有限支撑族上穷举检查等号与零输出判据。`code/verify_bell_contraction.py` 则先以精确圆分算术，从输入张量系数和 Bell bra 直接构造物理条件向量，再将其概率与加权纠缠同式 (7) 比较。输出文件列明实际检查的案例，不将有限计算冒充为普遍定理的证明。一般论证见书面证明。本版本未附 Lean 源码及计算程序，未进行重新编译。

## 参考文献

[1] Diego S. Starke、Marcos L. W. Basso、Lucas C. Céleri、Jonas Maziero，*Entanglement swapping for partially entangled qudits and the role of quantum complementarity*，arXiv:2508.00813v2（2025 年 10 月 22 日），Advanced Quantum Technologies，DOI：[10.1002/qute.202500674](https://doi.org/10.1002/qute.202500674)。[固定版本全文](https://arxiv.org/html/2508.00813v2)。相关公式为式 (24)、(30)–(31)、(41)、(43)、(48)、(57)、(59)。

[2] The Omega Institute / trureturing，*The improved entanglement-swapping product bound fails in dimension four*，研究记录及形式化结果 `QuditSwappingProductBoundRefutation.result`。[固定于提交 51dca4f1542baa532983864568d6a8ca3470e745 的问题记录](https://github.com/the-omega-institute/trureturing/blob/51dca4f1542baa532983864568d6a8ca3470e745/Problems/starke-2025-qudit-swapping-product-bound-refutation.md)；[同一提交下的形式化结果说明](https://github.com/the-omega-institute/trureturing/blob/51dca4f1542baa532983864568d6a8ca3470e745/Blueprint/D5/S3/Quantum/Entanglement/QuditSwappingProductBoundRefutation.md)。访问日期为 2026 年 11 月 24 日。本文不将此前反驳计为自身贡献。

[3] János A. Bergou、Dov Fields、Mark Hillery、Siddhartha Santra、Vladimir S. Malinovsky，*Average concurrence and entanglement swapping*，Physical Review A 104, 022425（2021），DOI：[10.1103/PhysRevA.104.022425](https://doi.org/10.1103/PhysRevA.104.022425)。[固定版本全文](https://arxiv.org/html/2106.00848v1)。量子比特多次交换的乘积规律保留原作者归属；其高维部分采用 I-concurrence。

[4] Shashank Shekhar、David Elkouss、Siddhartha Santra，*Optimising multipartite entanglement manipulation in quantum networks*，[arXiv:2610.21420v1](https://arxiv.org/abs/2610.21420)。本次核查通过索引取得了 arXiv 原始摘要，未取得原始全文。
