# 四分量 Abelian Chern–Simons 链接态的三阶多重熵坍缩

## 摘要

四分量 $U(1)_k$ 链接态以六个两两链接数编码。Chang、Goswami、Iizuka 和 Miyata 在有限级数扫描中发现，三阶真正四体多重熵对所有链接配置都坍缩到三方信息，当且仅当 $3$ 不整除 $k$。本文证明该判别适用于所有整数级数 $k\ge2$。当 $3$ 可逆时，三重复制算符分解成两个实坐标组成的字符模态。各模态由一个二色或三色划分决定，三色项在真正多重熵中精确抵消。当 $3$ 整除 $k$ 时，三能级的一组带符号四环链接给出可复制到每个此类级数的严格违反。进一步，单个链接配置的坍缩差量只取决于经单位因子重标度的三素数部分，故按均匀链接数计的违反比例只取决于 $v_3(k)$。

## 1. 模型和定理

用 $R=\mathbb Z/k\mathbb Z$，$\zeta_k=e^{2\pi i/k}$，$L_{ij}=L_{ji}\in R$ 表示四个链接分量 $i=0,1,2,3$ 的链接数。规范化链接态为

$$
|\psi(L;k)\rangle=k^{-2}\sum_{x\in R^4}\zeta_k^{\sum_{i<j}L_{ij}x_ix_j}|x_0,x_1,x_2,x_3\rangle.
$$

对四个分量的一个 $q$ 块划分 $\Pi$，取复制标签群 $G=\mathbb F_3^{q-1}$，前 $q-1$ 块的复制移位依序为标准基向量，最后一块移位为零。用 $g_i\in G$ 表示分量 $i$ 所在块的移位。定义三阶多重熵

$$
S(\Pi)=-\frac{1}{2\cdot 3^{q-2}}\log Z(\Pi),
$$

其中 $Z(\Pi)$ 是原文式 (2.6) 的归一化复制收缩。归一化态满足 $Z_1=1$。记 $\mathcal P_{31}$ 为四种单分量对三分量的二分划分，$\mathcal P_{22}$ 为三种两分量对两分量的二分划分，$\mathcal P_{211}$ 为六种合并一对得到的三分划分，$\Pi_4$ 为四个单分量块。沿用式 (2.11)–(2.12) 的约定，

$$
\begin{aligned}
I_3&=\sum_{\Pi\in\mathcal P_{31}}S(\Pi)-\sum_{\Pi\in\mathcal P_{22}}S(\Pi),\\
\mathrm{GM}_{a=0}&=S(\Pi_4)-\frac13\sum_{\Pi\in\mathcal P_{211}}S(\Pi)+\frac13\sum_{\Pi\in\mathcal P_{31}}S(\Pi),\\
\Delta(L;k)&=\mathrm{GM}_{a=0}-\frac19 I_3.
\end{aligned}
$$

参数 $a$ 只把 $\mathrm{GM}_{a=0}$ 改为 $\mathrm{GM}_{a=0}-aI_3$，因此这个差量对应任意约定参数下的同一判别。

**定理。** 所有三阶复制收缩 $Z(\Pi)$ 为正。对任意 $k\ge2$，以下等价：

1. 对所有 $L\in R^6$，$\Delta(L;k)=0$。
2. $3\nmid k$。

若 $k=3^v m$、$v\ge1$ 且 $\gcd(3,m)=1$，则逐配置有
$\Delta(L;k)=\Delta(m^{-1}L\bmod 3^v;3^v)$。这里的逆元取模 $3^v$。因此均匀抽取 $L\in R^6$ 得到违反的概率只取决于 $v$。

## 2. 复制字符和与移位变换

令每个 $x_i$ 在 $R^G$ 取值，内积记为 $\langle f,h\rangle=\sum_{s\in G}f(s)h(s)$。它是环上线性配对。移位 $T_g f(s)=f(s+g)$ 满足 $T_g^{\mathsf T}=T_{-g}$。将链接态展开代入复制收缩，得到

$$
Z(\Pi)=k^{-4|G|}\sum_{x_0,\dots,x_3\in R^G}\zeta_k^{Q(x)},\qquad
Q(x)=\sum_{i<j} L_{ij}\langle x_i,(I-T_{g_i-g_j})x_j\rangle .
$$

原始态的每一项相位是同一复制标签处的 $x_i x_j$；置换后的共轭态用两处分量各自移位的乘积。平移求和标签得到上式。如采用交换 bra 与 ket 的移位记号，所有移位符号可借助同时反演复制标签恢复。每个链接态振幅的模为 $k^{-2}$，故前因子正好是对全部四分量复制变量的归一化平均。

使用双射 $x_i=T_{2g_i}y_i$。因每个 $g$ 有 $3g=0$，新的差算符为

$$T_{-2g_i}(I-T_{g_i-g_j})T_{2g_j}
=T_{g_i-g_j}-T_{g_j-g_i}.$$

这里系数 $2$ 是复制索引群中的元素，无需求 $R$ 中 $2$ 的逆元。这节的变量替换对偶数级数同样适用。

## 3. 三可逆时的二维模态

设 $3\nmid k$，$d=q-1$。对非零线性映射 $\alpha:G\to\mathbb F_3$，把 $\alpha$ 与 $-\alpha$ 合并成一对。令 $V_\alpha$ 是 $f\circ\alpha$ 组成的子模，其中 $f$ 定义在三元集合上且三个分量和为零。常数子模与所有 $V_\alpha$ 构成 $R^G$ 的直和：

- 不同对的 $\alpha,\beta$ 线性独立，每对值在 $G$ 中出现同样次数，所以其零和拉回相互正交。常数也与它们正交。
- 各 $V_\alpha$ 中，原配对是零和三元组标准配对的 $3^{d-1}$ 倍。基 $(e_0-e_2,e_1-e_2)$ 的 Gram 行列式为 $3$。常数子模的配对系数为 $3^d$。这些在 $R$ 都可逆。
- 非退化性和正交性使直和注入 $R^G$。两者基数相同，因为 $1+2(3^d-1)/2=3^d$。

每个移位保持各子模。常数模态上的相位为零。对 $V_\alpha$，标记 $c_i=\alpha(g_i)\in\mathbb F_3$。移位差在零和三元组上由 $c_i-c_j$ 决定，值为 $0,1,-1$ 分别给出零、$T-T^{-1}$、$-(T-T^{-1})$，其中 $Tf(a)=f(a+1)$。在前述基上，双线性配对 $\langle\cdot,(T-T^{-1})\cdot\rangle$ 的矩阵为

$$3\begin{pmatrix}0&1\\-1&0\end{pmatrix}.$$

因此该模态的相位为 $3^d u^{\mathsf T}C v$，其中 $u,v\in R^4$，$C$ 的对角为零且 $C_{ij}=\epsilon(c_i-c_j)L_{ij}$，$\epsilon(0)=0$、$\epsilon(1)=1$、$\epsilon(-1)=-1$。这是交替矩阵的坐标写法，即使在特征二也保持结论。因为 $3^d$ 是单位，先对 $u$ 求和得到该模态的归一化收缩

$$Z_{\mathrm{mode}}=\frac{|\ker_R C|}{k^4}>0.$$

交换颜色的任一排列，是 $\mathbb F_3$ 上一个形如 $a\mapsto\pm a+b$ 的仿射映射，故只会同时保留或改变 $C$ 的符号。模态收缩只取决于这样得到的无标号划分 $\mathcal Q$，与复制维数 $d$ 无关。记 $h(\mathcal Q)=-\log(|\ker_R C|/k^4)$。

对每个二块或三块的粗化划分 $\mathcal Q$，锚定块颜色为零后，另外一或两种非零颜色的赋值有两个选择，并且互为倒号。反过来，任一非零 $\alpha$ 的颜色在复制移位的标准基上唯一指定 $\alpha$，给出一个这样的粗化划分。于是

$$
S(\Pi)=\frac{1}{2\cdot3^{q-2}}
\sum_{\substack{\mathcal Q\succeq\Pi\\ |\mathcal Q|=2,3}} h(\mathcal Q).
$$

这里 $\mathcal Q\succeq\Pi$ 表示 $\mathcal Q$ 粗化 $\Pi$。这也给出 $q=2$ 时 $h(\Pi)=2S(\Pi)$。

## 4. 划分系数的抵消

四分的 $S(\Pi_4)$ 以 $1/18$ 计入每一二色和三色划分。三分合并项的每次贡献为 $-1/18$。三色划分恰容许一次合并，全部抵消。二色 $3:1$ 划分容许三次合并，还从 $\tfrac13 S(\Pi)$ 获得 $h(\Pi)/6$。二色 $2:2$ 划分容许两次合并。二者最终系数分别为

$$1/18-3/18+1/6=1/18,\qquad 1/18-2/18=-1/18.$$

代入 $h(\Pi)=2S(\Pi)$ 即得 $\mathrm{GM}_{a=0}=I_3/9$。这个推导涵盖所有与三互素的级数，包括任意偶数复合级数。

## 5. 三素数部分与严格违反

先设 $k=3^v$。虽然上面的维数分解需要三可逆，但第 2 节的移位变换仍有效。在 $R^G$ 上定义反演 $P f(s)=f(-s)$。此时 $2$ 可逆，所以有偶、奇两个直和分量。它们在标准配对下正交，且 $P(T_g-T_{-g})P=-(T_g-T_{-g})$。因此规范化相位只含全部偶分量与全部奇分量之间的双线性项。它们各自是自由模，可用每对 $\{s,-s\}$ 的偶或奇系数及零点系数显式参数化。先对其中一组变量求和，给出正的核比例。于是所有 $Z(\Pi)$ 在三素数幂级数为正。

一般令 $k=ab$，$\gcd(a,b)=1$。各分量的本地基按 CRT 双射写成 $(x\bmod a,x\bmod b)$。若 $y\in\mathbb Z/k$、两余数为 $y_a,y_b$，则

$$\zeta_k^y=\zeta_a^{b^{-1}y_a}\zeta_b^{a^{-1}y_b},$$

各逆元取在对应的因子环。这个变换将整个链接态分成级数 $a,b$ 的两个链接态，边权分别为 $b^{-1}L\bmod a$、$a^{-1}L\bmod b$。复制置换按每方张量因子分解，所以 $Z$ 相乘，$S,I_3,\Delta$ 相加。取 $a=3^v$、$b=m$，第 4 节令与三互素的部分贡献零，便得逐配置的 CRT 关系及正性。由 $m^{-1}$ 是单位，该关系的三素数边权向量在均匀输入下仍均匀。若 $m=1$，对应因子是维数一的乘积态。

在 $k=3$ 上取边权
$(L_{01},L_{02},L_{03},L_{12},L_{13},L_{23})=(1,1,0,0,1,-1)$。
该图在端点组 $\{0,3\}$ 和 $\{1,2\}$ 之间二分。对任一划分 $\Pi$，定义 $2|G|\times 2|G|$ 矩阵 $M$，块 $i,j$ 为 $L_{ij}(I-T_{g_i-g_j})$，左端点 $i\in\{0,3\}$，右端点 $j\in\{1,2\}$。复制相位是 $x_{\rm left}^{\mathsf T}M x_{\rm right}$，由字符正交直接得到 $Z=3^{-\operatorname{rank}_{\mathbb F_3}M}$。标准库整数证书按该明确矩阵做精确行消元，并用原相位的对称 Hessian 合同消元做第二路计算。

| 划分类型 | 划分数 | 每个划分的 $\operatorname{rank}_{\mathbb F_3}M$ |
| --- | ---: | ---: |
| $1:1:1:1$ | 1 | 40 |
| $2:1:1$ | 6 | 12 |
| $3:1$ | 4 | 2 |
| $2:2$ | 3 | 4 |

故 $I_3=-2\log 3$、$\mathrm{GM}_{a=0}=-\tfrac49\log 3$，并且 $\Delta=-\tfrac29\log 3$。对任意 $k=3b$，将所有边权乘 $b$。写本地整数标签为 $x=r+3s$，其中 $0\le r<3$、$0\le s<b$。相位仅依赖 $r$。该本地重标记使高维态成为原三能级态与四个局部均匀纯态的张量积，因而 $\Delta$ 保持严格非零。这个提升对 $3\mid b$ 也成立。

## 6. 文献与范围

Chang 等的式 (4.12) 定义了本文的差量。其第 4.5 节与第 5 节的三阶结果来自有限级数扫描，以及 key-ring 类的全级数证明。本文识别一般四分量链接的三阶模态机制，证明全级数判别，并把逐配置差量精确归约到三素数部分。二元稳定子态的既有三阶模态计数可覆盖 $k=2$ 的链接态。本文的字符计数把级数全环作为底环，给出偶数复合级数、一般奇数级数和三素数幂障碍。三级违反的带符号四环也在原文扫描所覆盖的配置中，本文给出其秩证书并将它提升到无限多级数。

本定理处理四分量、三阶、Abelian $U(1)_k$ 链接态的同一坍缩关系。它没有给出违反概率随 $v_3(k)$ 的数值闭式。非 Abelian 态与更高复制阶数需要其他分析。

- Y.-C. Chang, K. Goswami, N. Iizuka and A. Miyata, *Genuine Multi-Entropy in Abelian Chern–Simons Theory: Exact Key-Ring Collapse and Its Breakdown for Generic Link States*, arXiv:2608.29627v1, §§2.2–2.3, 4.3, 4.5, 5. [原文](https://arxiv.org/abs/2608.29627v1)
- S. Akella, N. Iizuka and A. Miyata, *Genuine multientropy in the toric code*, Phys. Rev. D 114, 105008 (2026). [原文](https://doi.org/10.1103/dykp-lbtq)
- TrueRuteRing, *The n = 3 collapse of the genuine four-party multi-entropy for stabilizer states*, evidence snapshot d9395451c3b795eb34407c2783c87a793820d03d. [证明记录](https://www.trureturing.org/conjectures.html?lang=en)
