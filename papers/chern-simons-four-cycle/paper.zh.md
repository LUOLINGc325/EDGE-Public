# 用同一个四环链接解释所有级数的多重熵坍缩违反

## 摘要

Chang、Goswami、Iizuka 和 Miyata 在 $2\le k\le24$ 的四分量 Abelian $U(1)_k$ 链接态扫描中，于 Rényi 指数 $n=4,5$ 的每个级数都找到真正四体多重熵的坍缩违反。本文证明，一个固定的单位边权四环在每个整数级数 $k\ge2$、每个整数指数 $n\ge4$ 都严格违反。其差量的精确公式为 $(n-2)(n-3)\log k/(3n^2)$。证明在 $\mathbb Z/k\mathbb Z$ 上直接计算复制差分的核，因而同时覆盖复合级数和 $n,k$ 有公因子的情形。

## 1. 精确命题

取四个分量 $A,B,C,D$，链接边为 $AC,AD,BC,BD$，这些边的权重均为 $1$，其余边的权重为 $0$。令 $R=\mathbb Z/k\mathbb Z$，$\omega=e^{2\pi i/k}$。归一化态是

$$
|\psi\rangle=k^{-2}\sum_{x_A,x_B,x_C,x_D\in R}
\omega^{(x_A+x_B)(x_C+x_D)}
|x_A,x_B,x_C,x_D\rangle .
$$

对分量的 $q$ 块划分 $\Pi$，复制群取 $G=(\mathbb Z/n\mathbb Z)^{q-1}$。给前 $q-1$ 块各一单位基向量作复制移位，最后一块移位取零，记分量 $i$ 对应的移位为 $g_i$。设 $Z_n(\Pi)$ 是归一化复制收缩，定义
$S_n(\Pi)=-\log Z_n(\Pi)/[(n-1)n^{q-2}]$。
令 $S_4$ 代表全四分的该量。记 $\sum S_{211},\sum S_{31},\sum S_{22}$ 分别在六种合并一对的三分、四种 $3:1$ 二分、三种 $2:2$ 二分上求和。

论文 arXiv:2608.29627v1 式 (2.11)、(2.12)、(4.12) 所用的量为

$$
I_{3,n}=\sum S_{31}-\sum S_{22},\qquad
\mathrm{GM}_{a=0}=S_4-\tfrac13\sum S_{211}+\tfrac13\sum S_{31},
$$

$$
\Delta_n=\mathrm{GM}_{a=0}-\frac{n^2-3n+3}{3n^2}I_{3,n}.
$$

**定理。** 对上面的固定四环和每个整数 $k,n\ge2$，所有这些 $Z_n(\Pi)$ 为正，并且

$$
I_{3,n}=-\log k,\qquad
\mathrm{GM}_{a=0}=\left(\frac1{n^2}-\frac2{3n}\right)\log k,\qquad
\Delta_n=\frac{(n-2)(n-3)}{3n^2}\log k .
$$

因此同一组链接数在任意级数、任意 $n\ge4$ 都提供一个严格违反。该构造也给出 $n=2,3$ 时的零差量。

## 2. 环上复制核

设 $N=|G|=n^{q-1}$，把每个分量的复制赋值视作 $R^G$ 的一个函数。写 $T_g f(s)=f(s+g)$。把纯态乘积相位代入复制收缩，得到两个左侧变量 $x_A,x_B$ 和两个右侧变量 $y_C,y_D$ 的归一化双线性字符和。矩阵 $M$ 的 $i,j$ 块是 $I-T_{g_i-g_j}$，其中 $i\in\{A,B\}$、$j\in\{C,D\}$。这是因为每条边贡献原振幅在同一复制标签的乘积，减去两个端点分别平移后的共轭振幅乘积。把其中一端的平移吸收到求和标签，就留下两个端点移位之差。因此

$$
Z_n(\Pi)=k^{-4N}\sum_{x,y\in R^{2N}}\omega^{x^{\mathsf T}My}
=k^{-2N}|\ker_R M|.
$$

最后一步使用 $R$ 的加法字符正交性，可在复合 $k$ 上逐坐标使用。

令 $a_1=g_A,a_2=g_B,b_1=g_C,b_2=g_D$，并令
$\alpha=a_2-a_1$、$\beta=b_2-b_1$、$\gamma=b_1-a_1$。
将第 $j$ 块列乘置换 $T_{b_j}$，块变为 $T_{b_j}-T_{a_i}$。把第二列减第一列，再把第二行减第一行，得到

$$
\begin{pmatrix}
T_{b_1}-T_{a_1} & T_{b_2}-T_{b_1} \\
T_{a_1}-T_{a_2} & 0
\end{pmatrix}.
$$

将两行乘 $T_{-a_1}$，将第二列乘 $T_{-\gamma}$。记 $D_g=T_g-I$。核等价于所有满足

$$D_\alpha x=0,\qquad D_\gamma x+D_\beta y=0$$

的 $(x,y)\in R^G\times R^G$，因为上述所有行列运算可逆。

对任一 $g$，核 $\ker D_g$ 由在每个 $g$ 轨道上取常值的函数组成。方程 $D_g y=w$ 可解恰好在 $w$ 沿每个 $g$ 轨道的和为零，因为沿轨道递推时只有首尾一致条件。每个轨道保留一个自由值。这一事实无需把轨道长度除进底环。

## 3. 各划分的精确计数

写 $Z_n(\Pi)=k^{-e(\Pi)}$。下面的基元判断在复合 $n$ 同样有效。若划分标签之间的差对应一棵生成树的边，则每个标签与锚定标签之差可以沿路径写成这些边的整数和。差向量生成 $G$，数量恰为 $q-1$，故构成 $\mathbb Z/n\mathbb Z$ 上的基。

**四个单分量。** 三个差 $\alpha,\beta,\gamma$ 对应一棵四标签生成树。在坐标 $(s,t,u)$ 上使它们分别沿三个轴移动。$x$ 与 $s$ 无关。令 $H(u)=\sum_t x(t,u)$，沿 $\beta$ 轨道求和的可解条件是 $H(u+1)=H(u)$。因为映射 $x\mapsto H$ 对每个 $u$ 都有一个自由输入系数 $1$，这些约束除去恰好 $n-1$ 个自由值。于是 $x$ 有 $k^{n^2-n+1}$ 种，$y$ 对每个 $x$ 有 $k^{n^2}$ 种，给出 $e=(n-1)(2n^2+1)$。

**三分，同侧合并。** 若合并 $A,B$，则 $\alpha=0$，而 $\beta,\gamma$ 是两个独立生成元。$x$ 的 $\beta$ 轨道和必须在 $\gamma$ 方向恒定，故 $x$ 有 $k^{n^2-n+1}$ 种，$y$ 每个条件下有 $k^n$ 种。若合并 $C,D$，则 $\beta=0$，第一式和第二式要求 $x$ 在独立的 $\alpha,\gamma$ 下均不变，$x$ 为常数，$y$ 任意。两种的核基数均为 $k^{n^2+1}$，故 $e=n^2-1$。

**三分，跨侧合并。** 有一个标签同时出现在两侧，故 $\alpha,\beta$ 对应三标签上的生成树，构成基。因为 $x$ 在 $\alpha$ 方向不变，对它做 $\beta$ 轨道求和后得到整个 $G$ 上的常数。无论 $\gamma$ 是哪个平移，$D_\gamma x$ 的 $\beta$ 轨道和均为零。$x,y$ 各剩 $n$ 个自由值，故 $e=2n(n-1)$。

**二分。** 对任意单分量切分，$\alpha,\beta$ 中一个为零，一个生成整个 $G$。当 $\beta=0$ 时，$x$ 已是常数，$y$ 任意。当 $\alpha=0$ 时，$D_\gamma x$ 沿唯一 $\beta$ 轨道求和为零，$x$ 任意，$y$ 有一个自由值。切分 $AB:CD$ 时，$\alpha=\beta=0$，$\gamma$ 生成整个 $G$，故 $x$ 为常数，$y$ 任意。这三类都给出 $e=n-1$。最后，其他两种 $2:2$ 切分的 $\alpha,\beta$ 都生成整个 $G$，两变量均为常数，$e=2(n-1)$。

| 划分 | 数量 | $e(\Pi)$ |
| --- | ---: | ---: |
| 四分 | 1 | $(n-1)(2n^2+1)$ |
| 三分，同侧合并 | 2 | $n^2-1$ |
| 三分，跨侧合并 | 4 | $2n(n-1)$ |
| $3:1$ 二分 | 4 | $n-1$ |
| $AB:CD$ | 1 | $n-1$ |
| 其余 $2:2$ 二分 | 2 | $2(n-1)$ |

故 $S_4/\log k=2+1/n^2$，$\sum S_{211}/\log k=10+2/n$，$\sum S_{31}/\log k=4$，$\sum S_{22}/\log k=5$。代回第 1 节公式得到定理。独立整数证书直接从未化简的复制矩阵消元，对 $n=2,3,4,5,6$ 的全部划分只使用单位主元，复算表中指数。

## 4. 文献与范围

Chang 等给出 key-ring 类的全级数解析公式，并在一般四分量态上扫描 $2\le k\le24$。本结果把高阶存在性提升到所有级数，使用一组与 $k,n$ 无关的单位边权，同时算出精确差量。Czech 等已经给出二元稳定子环核心（包含方形）的全复制指标系数，并讨论有限域方法在素数 qudit 上的推广。本文的贡献是直接在任意 $\mathbb Z/k\mathbb Z$ 上完成全部粗化，尤其覆盖复合级数与 $\gcd(k,n)>1$。它不计算其他链接配置的违反率。

- Y.-C. Chang, K. Goswami, N. Iizuka and A. Miyata, *Genuine Multi-Entropy in Abelian Chern–Simons Theory: Exact Key-Ring Collapse and Its Breakdown for Generic Link States*, arXiv:2608.29627v1, §§4.5, 5. [原文](https://arxiv.org/abs/2608.29627v1)
- B. Czech, Y. Feng, J. Harper, X.-X. Ju and Y. Zhao, *Rényi Multi-entropy for Stabilizer States: A Finite Field Gauss Sum Problem*, arXiv:2610.26814, §4、表 1 与 §5.2. [原文](https://arxiv.org/abs/2610.26814)
