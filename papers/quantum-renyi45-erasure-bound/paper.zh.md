# 四阶与五阶量子 Rényi 信息合并的最优擦除界

*完整证明、精确差额、等号结构及对偶推论*

2026年11月24日

## 摘要

两个独立二元信息源各带有量子侧信息。将两个比特作异或后，在已知各自条件熵的情况下，输出最多还剩多少不确定性？本文证明四阶和五阶沙夹条件 Rényi 熵的尖锐擦除信道上界，覆盖任意有限维、非对易及秩亏的量子侧信息，并允许任意输入先验。它在下述 BEC 归一化解释下给出 Hirche、Guan 与 Tomamichel [1] 猜想 V.6 的两个完整阶数分支。证明把每个输入化为三个有序迹矩；异或使三个矩分别相乘，再由显式加权协方差恒等式得到非负差额。四阶的矩排序来自正半定合同变换，五阶需要另一个双本征基恒等式。

我们同时刻画全部二输入等号情形：至少一个输入必须分成两块完全可识别的区域和一块两种输入完全相同的区域。独立二元擦除信道在整个允许熵域达到上界。进一步得到任意多个独立输入的尖锐异或界、一个定量差额界，以及 $1/4$ 阶和 $1/5$ 阶 Petz 上条件熵的尖锐变量节点下界。一般实数阶、另一侧的 BSC–PSC 界和冯诺依曼熵问题均不在本文结论内。本文为包含解析证明的 AI 辅助研究稿；尚无完整形式化认证或外部同行评审。

## 1. 问题、来源与精确范围

信息合并界用于研究极化码与信念传播中的校验节点和变量节点。[1] 的第 V 节考虑两个独立、均匀的二元经典–量子输入，式 (IV.1) 定义本文使用的沙夹下条件熵。该文证明了二阶公式，并在猜想 V.6、式 (V.16) 中提出一般阶数的擦除界。经典侧信息已有相应结果 [2]；非对易量子侧信息不能由经典结论直接处理。本文解决 $k\in\{4,5\}$，且证明本身允许非均匀先验。

**对来源公式的括号说明。** [1] 第 7 页的式 (V.16) 没有用括号明确对数的完整作用范围。本文以二元擦除信道直接计算所得的矩公式，以及该文已证明的二阶式 (V.13)，固定为下文式 (2) 的写法：常数 $\delta_k$ 在对数内。附录 A 还说明，本文的尖锐界蕴含把该常数读在对数外时得到的较弱字面上界。此记法问题不作为改变假设或削弱目标的理由。

与公开三阶工作 [5] 相比，四阶和五阶会出现三个不同的非对易矩，不能把三阶单矩恒等式直接改换阶数。本文的新增步骤是分别证明这三个矩具有同一排序。本文不依赖 [5] 的证明或形式化库。

所有对数均为自然对数。记 $\operatorname{Tr}$ 为有限维矩阵迹，$\|T\|_2^2=\operatorname{Tr}(T^*T)$ 为 Hilbert–Schmidt 范数平方。正半定次序记为 $\succeq$。负幂仅在支撑上取逆，在核上取零。

## 2. 主定理

令 $P_0,P_1\succeq0$ 为同一有限维复 Hilbert 空间上的子归一化矩阵，满足

$$
\operatorname{Tr}(P_0+P_1)=1,\qquad
\rho_{XB}=\sum_{x=0}^1 |x\rangle\langle x|\otimes P_x,
\qquad r=P_0+P_1.
$$

因此 $\operatorname{Tr}P_x$ 是输入先验；原论文的均匀输入对应 $P_x=\sigma_x/2$、$\operatorname{Tr}\sigma_x=1$。定义

$$
\begin{aligned}
K_k(P)&=\sum_{x=0}^1\operatorname{Tr}
 \left(r^{(1-k)/(2k)}P_xr^{(1-k)/(2k)}\right)^k,\\
H_k(P)&=\widetilde H_k^\downarrow(X|B)_\rho
       =-\frac1{k-1}\log K_k(P).
\end{aligned} \tag{1}
$$

对两个独立输入 $P^{(1)},P^{(2)}$，异或输出 $Z=X_1\oplus X_2$ 的两个块为

$$
P^{\oplus}_z=\sum_{x=0}^1
 P^{(1)}_{z\oplus x}\otimes P^{(2)}_x.
$$

**定理 1（最优擦除上界）。** 对 $k=4$ 或 $k=5$，令
$\delta_k=2^{1-k}$，$K_i=K_k(P^{(i)})$，$H_i=H_k(P^{(i)})$。则

$$
\begin{aligned}
K_k(P^\oplus)&\ge F_k(K_1,K_2),\\
F_k(K_1,K_2)&=\delta_k+
 \frac{(K_1-\delta_k)(K_2-\delta_k)}{1-\delta_k},\\
H_k(P^\oplus)&\le -\frac1{k-1}\log F_k(K_1,K_2).
\end{aligned} \tag{2}
$$

该界在全体有限维二元经典–量子输入上尖锐：任意给定
$H_1,H_2\in[0,\log2]$，均有均匀先验的擦除信道达到等号。
若额外固定某个非均匀先验，本文只断言不等式有效，不另行断言受限先验类中的逐点最优性。

**定理 2（全部二输入等号）。** 定理 1 取等，当且仅当至少一个输入的侧信息空间可以正交分成三个区域，使它的两个原始块写成

$$
P_0=C+R_0,\qquad P_1=C+R_1, \tag{3}
$$

其中 $C,R_0,R_1\succeq0$ 的支撑两两正交，允许其中部分为零。
下文称式 (3) 为擦除型结构。$C$ 区域中两种输入完全相同，
$R_0,R_1$ 区域分别只可能来自一种输入。

## 3. 支撑处理与三个迹矩

因为 $0\preceq P_x\preceq r$，有 $\ker r\subseteq\ker P_x$。
确实，若 $rv=0$，则 $0\le\langle v,P_xv\rangle\le0$；
正半定性给出 $P_xv=0$。因此压缩到 $\operatorname{supp}r$ 不改变任何状态、迹或条件熵。在该支撑上 $r$ 正定，无需先假定原始边缘满秩，也无需交换极限。

置

$$
U=r^{(1-k)/(2k)}P_0r^{(1-k)/(2k)},\quad
V=r^{(1-k)/(2k)}P_1r^{(1-k)/(2k)},
$$

$$
S=U+V=r^{1/k},\qquad D=U-V.
\tag{4}
$$

于是 $D=D^*$、$S\pm D\succeq0$、$\operatorname{Tr}S^k=1$。
对两个阶数分别定义

$$
\begin{array}{c|ccc|ccc}
k&a&b&c&w_a&w_b&w_c\\ \hline
4&\operatorname{Tr}S^2D^2&\operatorname{Tr}SDSD&\operatorname{Tr}D^4&4&2&1\\
5&\operatorname{Tr}S^3D^2&\operatorname{Tr}S^2DSD&\operatorname{Tr}SD^4&5&5&5
\end{array} \tag{5}
$$

记 $w=(w_a,w_b,w_c)$，$W=w_a+w_b+w_c=2^{k-1}-1$。

**引理 3（精确展开）。** 两个阶数均满足

$$
K_k=\operatorname{Tr}(U^k+V^k)
 =\delta_k(1+w_aa+w_bb+w_cc). \tag{6}
$$

**证明。** 将 $U=(S+D)/2$、$V=(S-D)/2$ 代入，奇数个 $D$ 的词互相抵消。四阶中，六个含两个 $D$ 的词分为四个循环迹等于 $a$ 的词和两个等于 $b$ 的词。五阶中，十个含两个 $D$ 的词按循环位置分为五个 $a$、五个 $b$；五个含四个 $D$ 的词均等于 $c$。全 $S$ 项的迹为一。这给出式 (6)，整个计数只使用迹的循环性，没有交换矩阵顺序。$\square$

## 4. 非对易矩排序

**引理 4。** 式 (5) 的两个三元组都满足

$$
a\ge b\ge c\ge0. \tag{7}
$$

### 4.1 四阶

由 $S,D$ 为 Hermitian 矩阵，直接展开得

$$
a-b=\frac12\operatorname{Tr}([S,D]^*[S,D])\ge0. \tag{8}
$$

另外，两个含三个 $D$ 的交叉项在循环迹下抵消，所以

$$
\begin{aligned}
b-c&=\operatorname{Tr}\bigl(D(S-D)D(S+D)\bigr)\\
&=\left\|(S-D)^{1/2}D(S+D)^{1/2}\right\|_2^2\ge0.
\end{aligned} \tag{9}
$$

式 (9) 不需要 $D$ 正半定；需要的是 $S-D$ 与 $S+D$ 正半定。
最后 $c=\operatorname{Tr}D^4\ge0$。

### 4.2 五阶

令 $T=[S,D]$。循环迹展开，或在 $S$ 的本征基中计算，可得

$$
\begin{aligned}
a-b&=\operatorname{Tr}(ST^*T)\\
&=\frac12\sum_{i,j}(s_i+s_j)(s_i-s_j)^2|D_{ij}|^2\ge0.
\end{aligned} \tag{10}
$$

五阶的第二步不能直接沿用式 (9)。令 $G=S+D\succeq0$、
$J=S-D\succeq0$。逐词展开并只合并循环迹，得到

$$
b-c=\frac18\operatorname{Tr}
 (G^4J+GJ^4-G^3J^2-G^2J^3). \tag{11}
$$

设 $G$、$J$ 分别有本征对 $(g_i,e_i)$、$(j_l,f_l)$。
对正整数 $p,q$，
$\operatorname{Tr}(G^pJ^q)=\sum_{i,l}g_i^pj_l^q|\langle e_i,f_l\rangle|^2$。
将四项代入式 (11)，标量因子恰可分解为

$$
b-c=\frac18\sum_{i,l}
 g_i j_l(g_i+j_l)(g_i-j_l)^2
 |\langle e_i,f_l\rangle|^2\ge0. \tag{12}
$$

这允许 $G,J$ 的本征基不同，因而覆盖非对易输入。
又 $c=\operatorname{Tr}(S^{1/2}D^4S^{1/2})\ge0$，引理得证。$\square$

式 (8)–(12) 的迹恒等式另有标准库脚本的自由词、循环迹有理数证书；矩阵正性与全维结论由上述解析论证承担。

## 5. 张量乘法、精确差额与主定理证明

两个输入独立，故输出边缘为 $r_1\otimes r_2$。在乘积支撑上，任意实数幂均满足
$(r_1\otimes r_2)^s=r_1^s\otimes r_2^s$，这可在乘积本征基中逐项验证。输出的两个沙夹块因此是

$$
U_\oplus=U_1\otimes U_2+V_1\otimes V_2,\qquad
V_\oplus=U_1\otimes V_2+V_1\otimes U_2.
$$

相加、相减得

$$
S_\oplus=S_1\otimes S_2,\qquad D_\oplus=D_1\otimes D_2.
\tag{13}
$$

迹的张量乘法给出

$$
(a_\oplus,b_\oplus,c_\oplus)=(a_1a_2,b_1b_2,c_1c_2). \tag{14}
$$

对任意两个三元组 $x,y$ 和正权重 $w$，直接展开有

$$
W\sum_jw_jx_jy_j-
 \left(\sum_jw_jx_j\right)\left(\sum_jw_jy_j\right)
 =\sum_{j<l}w_jw_l(x_j-x_l)(y_j-y_l). \tag{15}
$$

取 $x=(a_1,b_1,c_1)$、$y=(a_2,b_2,c_2)$，结合式 (6)、(14)、
$1-\delta_k=\delta_k W$，得到精确差额

$$
\Delta_k:=K_k(P^\oplus)-F_k(K_1,K_2)
 =\frac{\delta_k}{W}\sum_{j<l}w_jw_l(x_j-x_l)(y_j-y_l). \tag{16}
$$

引理 4 使每一项都非负。对数递增，而 $-1/(k-1)<0$，于是式 (2) 成立。两个阶数的系数明确为

$$
\begin{aligned}
\Delta_4={}&\frac17(a_1-b_1)(a_2-b_2)
 +\frac1{14}(a_1-c_1)(a_2-c_2)\\
&+\frac1{28}(b_1-c_1)(b_2-c_2),\\[3pt]
\Delta_5={}&\frac5{48}\bigl[(a_1-b_1)(a_2-b_2)
 +(a_1-c_1)(a_2-c_2)\\
&\hspace{41mm}+(b_1-c_1)(b_2-c_2)\bigr].
\end{aligned} \tag{17}
$$

为使熵域和后续差额估计完全自足，注意式 (6) 给出 $K_k\ge\delta_k$。
而 $U,V\succeq0$ 的迹展开给出
$\operatorname{Tr}(U+V)^k\ge\operatorname{Tr}U^k+\operatorname{Tr}V^k$。
四阶的混合循环词为 $U^3V,UV^3,U^2V^2,UVUV$；
五阶为 $U^4V,UV^4,U^3V^2,U^2V^3,U^2VUV,UVUV^2$。
每项迹均非负：前几项是两个正半定矩阵乘积的迹；
$\operatorname{Tr}(UVUV)=\operatorname{Tr}(V^{1/2}UV^{1/2})^2$；
最后两个五阶项可分别写成
$\operatorname{Tr}((VUV)U^2)$ 与 $\operatorname{Tr}((UVU)V^2)$。
因此 $K_k\le\operatorname{Tr}S^k=1$，从而

$$
\delta_k\le K_k\le1,\qquad 0\le H_k\le\log2. \tag{18}
$$

**定量差额。** 令 $\eta_i=a_i-c_i\ge0$。设
$H_k^{\rm BEC}=-(k-1)^{-1}\log F_k(K_1,K_2)$。则

$$
H_k^{\rm BEC}-H_k(P^\oplus)
 =\frac1{k-1}\log\left(1+\frac{\Delta_k}{F_k(K_1,K_2)}\right), \tag{19}
$$

并有

$$
H_4^{\rm BEC}-H_4(P^\oplus)\ge\frac{\eta_1\eta_2}{42},\qquad
H_5^{\rm BEC}-H_5(P^\oplus)\ge\frac{5\eta_1\eta_2}{192}. \tag{20}
$$

证明只需取式 (17) 中间一项，再用
$\log(1+t)\ge t/(1+t)$ 与 $F_k+\Delta_k=K_k(P^\oplus)\le1$。
这是在显式矩缺陷上的稳定性估计，不是到擦除信道集合的迹距离估计。

## 6. 等号结构与全熵域尖锐性

由式 (16) 中 $(a_1-c_1)(a_2-c_2)$ 的严格正系数，
$\Delta_k=0$ 当且仅当某一个输入满足 $a=b=c$。

固定该输入。在 $r$ 的支撑上 $S$ 正定。
四阶由式 (8)、五阶由式 (10)，$a=b$ 都推出 $[S,D]=0$。
因此可同时对角化，记本征值为 $s_j>0$、$|d_j|\le s_j$。
此时两个阶数都有

$$
b-c=\sum_j s_j^{k-4}d_j^2(s_j^2-d_j^2). \tag{21}
$$

各项非负。故 $b=c$ 等价于每个 $d_j\in\{0,s_j,-s_j\}$。
从沙夹块重建原状态，

$$
P_0=\frac12 S^{(k-1)/2}(S+D)S^{(k-1)/2},\qquad
P_1=\frac12 S^{(k-1)/2}(S-D)S^{(k-1)/2}. \tag{22}
$$

在 $d=0$ 区域两块都等于 $S^k/2$；在 $d=s$ 区域只有 $P_0=S^k$；
在 $d=-s$ 区域只有 $P_1=S^k$。这正是式 (3)。
反过来，式 (3) 的三个正交区域分别满足 $D=0,S,-S$，所以三矩相等。
定理 2 得证。

取二元擦除概率 $e\in[0,1]$，输出条件态为

$$
\sigma_0=(1-e)|0\rangle\langle0|+e|\mathrm e\rangle\langle\mathrm e|,
\quad
\sigma_1=(1-e)|1\rangle\langle1|+e|\mathrm e\rangle\langle\mathrm e|,
\tag{23}
$$

并令 $P_x=\sigma_x/2$。直接计算得

$$
a=b=c=1-e,\qquad K_k=1-(1-\delta_k)e. \tag{24}
$$

因此 $H_k$ 随 $e$ 连续覆盖 $[0,\log2]$。任意给定的一对输入熵都可用两个这样的信道实现，且式 (2) 取等。任何仅依赖 $H_1,H_2$、在全输入类上有效的上界都不能逐点更小。事实上，只需一个输入具有式 (3) 结构，另一个输入可以非对易。

### 一个严格非对易的精确例子

取未归一化矩阵

$$
S_0=\begin{pmatrix}4&0\\0&2\end{pmatrix},\qquad
D_0=\begin{pmatrix}0&2\\2&0\end{pmatrix},
\quad
S=\frac{S_0}{(\operatorname{Tr}S_0^k)^{1/k}},\quad
D=\frac{D_0}{(\operatorname{Tr}S_0^k)^{1/k}}.
$$

$S_0\pm D_0$ 正定，且 $S_0D_0\ne D_0S_0$。由式 (22) 重建得到的两个块各有迹 $1/2$，因此这是原论文均匀先验类内的例子。令两输入都等于这一输入，则

| 阶数 | $(a,b,c)$ | 输入 $K_k$ | 异或输出 $K_k$ | 严格差额 $\Delta_k$ |
|---|---|---|---|---|
| $4$ | $(5,4,2)/17$ | $47/136$ | $25/136$ | $13/4046$ |
| $5$ | $(3,2,1)/11$ | $41/176$ | $191/1936$ | $5/968$ |

这些有理数可用未归一化矩阵的整数运算直接重算，无需近似求矩阵分数次幂。

## 7. 任意多个独立输入

**推论 5。** 对 $m\ge2$ 个独立二元经典–量子输入，定义

$$
\kappa_k(P)=\frac{K_k(P)-\delta_k}{1-\delta_k}.
$$

则

$$
\kappa_k(P^{\oplus m})\ge\prod_{i=1}^m\kappa_k(P^{(i)}),
\qquad
H_k(P^{\oplus m})\le-\frac1{k-1}
 \log\left[\delta_k+(1-\delta_k)\prod_i\kappa_k(P^{(i)})\right]. \tag{25}
$$

界在全熵立方体上由独立擦除信道达到。等号当且仅当满足以下至少一项：

1. 某个输入的两个原始块相同：$P^{(i)}_0=P^{(i)}_1$。
2. 至多一个输入不具有式 (3) 的擦除型结构。

**证明。** 对式 (2) 迭代即可得到不等式；所有 $\kappa_k$ 非负，故每步保持方向。
也可由式 (13) 直接得到输出三矩 $\prod_i a_i,\prod_i b_i,\prod_i c_i$。
若某个三元组全零，则 $D_i=0$：四阶由 $\operatorname{Tr}D_i^4=0$，
五阶由 $S_i$ 在支撑上正定及 $\operatorname{Tr}S_iD_i^4=0$。
因此该条件等价于 $P^{(i)}_0=P^{(i)}_1$，此时 $\kappa_k$ 不等式的两边均为零，熵及其上界均为 $\log2$。
若没有零三元组，则每个 $a_i>0$；乘积三元组恒定当且仅当所有因子三元组恒定。
两个非恒定三元组相遇时，式 (16) 的中间项严格为正；此后与其它输入合并的误差至少乘以一个正的 $\kappa_k$，严格性保留。由此得到等号分类。
擦除信道的 $\kappa_k=1-e$，直接给出全域尖锐性。$\square$

对非均匀先验，不能把条件 1 改写为“两个归一化条件态相同”；还必须是两个子归一化块相同。

## 8. 对偶阶数的变量节点下界

对满足 $R_0,R_1\succeq0$ 及 $\operatorname{Tr}(R_0+R_1)=1$ 的二元经典–量子块，定义 Petz 上条件熵

$$
\begin{aligned}
J_{1/k}(R)&=\overline H_{1/k}^{\uparrow}(X|B)_R
 =\frac1{k-1}\log L_k(R),\\
L_k(R)&=\operatorname{Tr}(R_0^{1/k}+R_1^{1/k})^k.
\end{aligned} \tag{26}
$$

这是 [1, 式 (IV.2)] 在所用阶数上的明确表达式。以下直接证明，无需把链规则当作未展开的中间引理。

**推论 6（$1/4$ 与 $1/5$ 阶）。** 对两个独立二元输入，令 $J_i=J_{1/k}(R^{(i)})$、$L_i=e^{(k-1)J_i}$。在 CNOT 后保留 $Z=X_1\oplus X_2$ 并估计 $X_2$，有

$$
\overline H_{1/k}^{\uparrow}(X_2|ZB_1B_2)
 \ge\frac1{k-1}\log\left[1+
 \frac{(L_1-1)(L_2-1)}{2^{k-1}-1}\right]. \tag{27}
$$

该下界在全熵正方形上尖锐；二输入等号仍等价于至少一个原始输入具有式 (3) 结构。

**证明。** 置 $U_i=R_{i,0}^{1/k}/L_i^{1/k}$、
$V_i=R_{i,1}^{1/k}/L_i^{1/k}$。此时
$\operatorname{Tr}(U_i+V_i)^k=1$ 且
$\operatorname{Tr}(U_i^k+V_i^k)=1/L_i$。第 3–5 节的矩阵论证仅用
$U_i,V_i\succeq0$ 和 $\operatorname{Tr}(U_i+V_i)^k=1$，所以可直接应用，不必另行构造原始边缘的沙夹表示。
令

$$
T=\sum_{z=0}^1\operatorname{Tr}
 \left(R_{1,z}^{1/k}\otimes R_{2,0}^{1/k}
 +R_{1,z\oplus1}^{1/k}\otimes R_{2,1}^{1/k}\right)^k.
\tag{28}
$$

由于 $Z$ 是经典寄存器，式 (26) 对两个 $Z$ 块的迹相加，故
$\overline H_{1/k}^{\uparrow}(X_2|ZB_1B_2)=(k-1)^{-1}\log T$。
块内已经包含概率，无需额外条件化因子。
式 (28) 又给出 $T=L_1L_2K_{\oplus}$。代入式 (2) 并化简：

$$
T\ge L_1L_2\left[\delta_k+
 \frac{(L_1^{-1}-\delta_k)(L_2^{-1}-\delta_k)}{1-\delta_k}\right]
 =1+\frac{(L_1-1)(L_2-1)}{2^{k-1}-1}.
\tag{29}
$$

正根与正整数幂均保持“相同或正交”的三个区域，所以等号分类双向地从定理 2 转移到原始 $R$ 块。
对均匀擦除信道，$L_k=1+(2^{k-1}-1)e$，变量节点的擦除概率为 $e_1e_2$，故等号覆盖全部 $J_i\in[0,\log2]$。
此外，式 (18) 应用于归一化根块给出 $1\le L_k\le2^{k-1}$，因此该熵域不需额外假设。$\square$

式 (28)–(29) 是二输入恒等式；本文未将其写成任意多输入变量节点的恒等式。

## 9. 查新、验证与实际意义

本文的文献比较涉及 [1] 的量子定义、原猜想、二阶特例；[2] 的经典条件熵范围；[3] 的冯诺依曼熵问题；[4] 的经典 BISO 偏序；以及 [5] 公开的三阶结果范围。2026 年 11 月 24 日的文献检索未发现同范围的四阶或五阶量子擦除界。该结论仅限已查阅文献范围，不是全球优先权保证。

式 (16) 对任意有限维提供可计算的精确差额，不需要优化测量、限制侧信息维数或假设输入同分布。式 (25) 给出多输入校验节点的直接界；式 (27) 则控制对偶阶数的变量节点。这些是信息合并分析中的严格不等式工具。本文没有进一步证明新的编码容量、有限码长标度或实际通信性能提升。

复现材料包括循环词的有理数恒等式核查、复高斯整数正半定矩阵的精确张量检查，以及从原始经典–量子块直接计算的独立浮点检验。本版本暂未附计算程序和原始输出。有限计算检验不能取代第 3–8 节的全域证明。

## 附录 A. 原文对数作用范围

令 $x=(K_1-\delta_k)(K_2-\delta_k)/(1-\delta_k)\ge0$。
式 (2) 证明的是 $H_{\oplus}\le-(k-1)^{-1}\log(x+\delta_k)$。
如果将 [1, 式 (V.16)] 的无括号表达式读为
$-(k-1)^{-1}\log x+\delta_k$，则对 $x>0$ 有

$$
-\frac1{k-1}\log(x+\delta_k)
\le-\frac1{k-1}\log x
\le-\frac1{k-1}\log x+\delta_k.
$$

所以本文结论还推出该较弱读法。当 $x=0$，$\log x$ 不是有限实数；只有采用从 $x>0$ 趋近的扩展实数极限，外置读法才给出 $+\infty$ 的平凡上界。本文公式始终有限，且在擦除端点正确取等。来源记录保留了实际 PDF 页码和该差别，没有将原式伪引成已有括号的表达式。

## 参考文献

1. C. Hirche, X. Guan, M. Tomamichel, *Chain Rules for Rényi Information Combining*, ISIT 2023, pp. 204–209. 本文固定全文版本为 [arXiv:2305.02589v1](https://arxiv.org/abs/2305.02589v1)，特别是式 (IV.1)、(IV.2)、(V.3)、(V.13) 和猜想 V.6。DOI: [10.1109/ISIT54713.2023.10206941](https://doi.org/10.1109/ISIT54713.2023.10206941).
2. C. Hirche, *Rényi Bounds on Information Combining*, ISIT 2020. [arXiv:2004.14408v1](https://arxiv.org/abs/2004.14408v1)，第 IV 节，特别是定理 IV.9 及引理 IV.10。
3. C. Hirche, D. Reeb, *Bounds on Information Combining With Quantum Side Information*, IEEE Transactions on Information Theory 64 (2018), 4739–4757. [arXiv:1706.09752v2](https://arxiv.org/abs/1706.09752v2)，猜想 VII.1–VII.2。
4. C. Hirche, *Rényi partial orders for BISO channels*, 2025. [arXiv:2508.19951v1](https://arxiv.org/abs/2508.19951v1)，第 4 节。
5. trureturing, *Order-three Rényi information-combining equality*, [公开研究记录](https://www.trureturing.org/research/hirche-guan-tomamichel-2023-renyi-order-three-equality/)，以及[来源和范围说明](https://the-omega-institute.github.io/trureturing-mdbook/Library/QuantumChannels/hircheguantomamichel2023renyicombining.html)，查阅于 2026-11-24。本文仅使用其公开范围记录作查重，不依赖其证明有效性。
