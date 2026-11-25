# 三态马尔可夫链有限精度观测下的熵产生双区间定理

*已知均匀平稳分布下的完整相容值域刻画*

AI 辅助研究稿

2026年11月24日

# 摘要

本文研究仅在确定性 Frobenius 范数误差范围内已知完整转移矩阵时的熵产生推断。底层过程是恰有三个可观测状态的时间齐次连续时间马尔可夫链，其均匀平稳分布已知，并满足互易支撑条件。对于具有非平凡正重特征值、且处于生成元嵌入不唯一区域的对称转移矩阵，我们证明：在其充分小的观测误差邻域内，所有相容的有限熵产生率恰好构成两个彼此分离的区间。低熵区间随观测误差以二次阶展开，其锐利系数为 $2/(u\lambda^2t^2)$。高熵区间向上无界，其精确下端点可化为复谱圆盘上的一维最小化问题，并以具有显式锐利系数的一次阶移动。当非平凡重特征值为负时，仅存在高熵区间。证明覆盖全部相容的非正规生成元及所有矩阵对数分支，并给出保证被排除区间非空的显式充分条件。本文不施加活动率约束。零误差分类被视为既有工作的推论，其中包括先前给出的一个显式实现族。本文的贡献是整个误差球的熵值域及其锐利端点行为。本稿尚未经过外部同行评议，也没有完整形式化验证。

# 1. 研究动机与既有工作

当一个连续演化的马尔可夫过程仅在固定时间间隔被观测时，采样得到的转移矩阵未必唯一确定其生成元。Bauer、Seifert 与 van der Meer [1] 说明了如何利用候选矩阵对数获得热力学界，但其有限候选枚举排除了传播子的重特征子空间。Baake 与 Sumner [2] 给出了详尽的三态嵌入分类。

具有非平凡重特征值的对称三态观测矩阵可写为
$$
P_\lambda=\Pi+\lambda H,\qquad
\Pi=\frac{\mathbf1\mathbf1^T}{3},\quad H=I-\Pi.
\tag{1}
$$
在精确共振时，平衡生成元与受驱动生成元可以产生相同的观测 [1]。均匀循环的熵产生公式是标准结果 [3]；相应的谱下包络由既有的相干性—亲和力界推出 [4,5]。文献 [6] 进一步研究了相关的谱—熵约束。

零误差熵值域也可由上述结果与 Anonymous [7，第 3.1 节] 的显式族组合推出。该族中平稳分布均匀的子族保持生成元的完整谱不变，将均匀最小化生成元连接到单向跃迁边界，并使熵产生发散。在共振采样时，它保持整个观测矩阵不变。我们曾独立推导出另一种参数化，但后续的全文比对确认了这一既有推论。因此，精确数据下的值域属于本文的背景结果，不作为原创性主张。

本文研究的问题具有更明确的观测含义：**当观测矩阵可以在一个小误差球内变化时，完整的熵值域是什么？** 任意小的观测扰动都可能允许小的正熵产生率，因此零误差时孤立的可逆值不再保持孤立。然而，仅凭这一点无法判断其余被排除区间是否仍然存在、低熵分量会扩大到何种程度，或高熵阈值会移动多远。

我们的回答是一个完整的双区间定理。其方法将解析的主矩阵对数与对所有其他实对数均成立的全局谱圆盘约束结合起来。在 Frobenius 范数约束下进行线性响应优化是已有方法；近期工作也研究了马尔可夫矩阵扰动下的熵泛函 [8]。本文的目标量是跨越所有对数分支的每一个相容连续时间生成元的熵产生，而非受扰动离散矩阵本身的熵。文献 [9,10] 研究了有限分辨率及含噪观测下的推断；本文采用的误差容限模型是确定性的，其本身不提供统计置信保证。

# 2. 模型与定义

固定已知的采样间隔 $t>0$。可容许的生成元 $Q$ 是满足下列条件的实 $3\times3$ 矩阵：
$$
Q\mathbf1=0,\qquad \mathbf1^TQ=0,\qquad
q_{ij}\geq0\ (i\ne j),\qquad
q_{ij}>0\Longleftrightarrow q_{ji}>0.
\tag{2}
$$
因此，平稳分布已知为均匀分布。三个状态均被完整观测；模型中不存在隐藏状态或随时间变化的速率。邻近的观测矩阵不必对称，但都是双随机矩阵。这一限制是模型假设，并非关于任意马尔可夫链的结论。

采用自然对数并取 $k_B=1$，定义
$$
\sigma(Q)=\frac13\sum_{i<j}
(q_{ij}-q_{ji})\log\frac{q_{ij}}{q_{ji}}.
\tag{3}
$$
若一对反向边均不存在，则该对边的贡献记为零。对于下文考虑的生成元类，互易支撑确保每个有限速率生成元的熵产生均为有限值。我们要确定
$$
\mathcal S_\varepsilon(\lambda)
=\left\{\sigma(Q):Q\text{ satisfies (2)},\
\|e^{tQ}-P_\lambda\|_F\leq\varepsilon\right\}.
\tag{4}
$$
本文不通过任何约束固定邻近生成元的活动率。

记
$$
\ell=|\lambda|,\quad u=-\frac{\log\ell}{t},\quad
\beta=\begin{cases}2\pi,&\lambda>0,\\ \pi,&\lambda<0,\end{cases}
\quad\omega_0=\frac{\beta}{t}.
\tag{5}
$$
我们考虑严格位于存在非零互易嵌入的区域内部的中心：
$$
0<\ell<e^{-\sqrt3\beta}.
\tag{6}
$$
对于 $a>\sqrt3 b>0$，记
$$
G(a,b)=\frac{2b}{\sqrt3}
\log\frac{a+\sqrt3 b}{a-\sqrt3 b}.
\tag{7}
$$
量 $u,\omega_0,G,\sigma$ 的单位均为时间的倒数；$\lambda$ 与 $\varepsilon$ 为无量纲量。

对于 $\varepsilon>0$，施加以下显式基本条件：
$$
\varepsilon<\ell/2,\qquad
\ell+\varepsilon/\sqrt2<e^{-\sqrt3\beta}.
\tag{8}
$$
在正特征值情形下，还要求
$$
D_\varepsilon=-\frac1t\log(1-\varepsilon/\lambda)<u/3.
\tag{9}
$$
对充分小的正 $\varepsilon$，这些条件全部成立。

# 3. 主要结果

## 定理 1. 完整熵值域

假设 (6)–(8) 成立，并在 $\lambda>0$ 时进一步假设 (9) 成立。令
$$
r=\varepsilon/\sqrt2,\qquad
z_\phi=\ell+r e^{i\phi},\qquad 0\leq\phi\leq\pi,
$$
$$
a_\phi=-\frac{\log|z_\phi|}{t},\qquad
b_\phi=\frac{\beta-\arg z_\phi}{t},\qquad
m_\varepsilon=\min_{0\leq\phi\leq\pi}G(a_\phi,b_\phi).
\tag{10}
$$
式 (10) 中的辐角取自右半平面内的上半部分，因而定义无歧义且非负。

若 $\lambda>0$，则主对数部分存在可达到的有限最大值 $M_\varepsilon$，使得
$$
\boxed{\mathcal S_\varepsilon(\lambda)
=[0,M_\varepsilon]\ \cup\ [m_\varepsilon,\infty).}
\tag{11}
$$
高熵区间恰为全部非主对数分支的像。任一区间中的每个值都由满足互易支撑且速率有限的生成元达到。

若 $\lambda<0$，则不存在低熵部分，并且
$$
\boxed{\mathcal S_\varepsilon(\lambda)=[m_\varepsilon,\infty).}
\tag{12}
$$

对于有限的正误差，式 (10) 是精确的一维变分公式。本文不声称对每个有限误差都给出了 $M_\varepsilon$ 的闭式表达式；下一结果给出其显式界与锐利首项。

## 定理 2. 锐利端点行为与可检验的间隙

固定满足 (6) 的中心及采样间隔。当 $\varepsilon\downarrow0$ 时，
$$
M_\varepsilon=
\frac{2\varepsilon^2}{u\lambda^2t^2}+O(\varepsilon^3)
\qquad(\lambda>0),
\tag{13}
$$
而对于任一符号，均有
$$
m_\varepsilon=
G(u,\omega_0)-
\frac{\|\nabla G(u,\omega_0)\|_2}{\sqrt2\,\ell t}\,
\varepsilon+O(\varepsilon^2).
\tag{14}
$$
这里对两个速率变量求导：
$$
G_a=-\frac{4b^2}{a^2-3b^2},\qquad
G_b=\frac2{\sqrt3}\log\frac{a+\sqrt3 b}{a-\sqrt3 b}
+\frac{4ab}{a^2-3b^2}.
\tag{15}
$$

在正特征值情形下，定义
$$
c_\varepsilon=\frac2{\sqrt3 t}
\arcsin\frac{\varepsilon}{2\sqrt2\lambda},\quad
L_\varepsilon=
2c_\varepsilon\log\frac{u+3c_\varepsilon}{u-3c_\varepsilon},
\quad
B_\varepsilon=\frac{2D_\varepsilon^2}{u-3D_\varepsilon}.
\tag{16}
$$
则 $L_\varepsilon\leq M_\varepsilon\leq B_\varepsilon$。保证式 (11) 中两个区间彼此分离的一个可直接检验的充分条件是
$$
B_\varepsilon<
G\left(
-\frac{\log(\lambda-r)}{t},\
\frac{2\pi-\arcsin(r/\lambda)}{t}
\right).
\tag{17}
$$
该条件对所有充分小的正 $\varepsilon$ 成立。因此，尽管精确数据问题中孤立的零值扩展为非平凡的低熵区间，被排除的区间 $(M_\varepsilon,m_\varepsilon)$ 仍然存在。

# 4. 背景事实及其归属

为使证明可核查，下面明确列出所需的三态事实。存在性阈值、下包络值以及精确中心处的高熵区间都是既有工作的推论 [2,4,5,7]。

每个满足 (2) 中行列和为零条件的矩阵，都有唯一的参数化
$$
Q(x,y,z,c)=
\begin{pmatrix}
-(x+z)&x+c&z-c\\
x-c&-(x+y)&y+c\\
z+c&y-c&-(y+z)
\end{pmatrix}.
\tag{18}
$$
令 $a=x+y+z$，并记
$\Delta=x^2+y^2+z^2-xy-yz-zx\geq0$。直接展开得到
$$
\det(vI-Q)=v[(v+a)^2-\Delta+3c^2].
\tag{19}
$$
若非零特征值为 $-a\pm ib$，其中 $b>0$，则 $3c^2-\Delta=b^2$。记 $C=|c|$，互易支撑蕴含 $x,y,z>C$，从而
$$
a>3C\geq\sqrt3 b,\qquad
\sigma(Q)=\frac{2C}{3}\sum_{s=x,y,z}
\log\frac{s+C}{s-C}\geq G(a,b).
\tag{20}
$$
为完整起见，函数 $s\mapsto\log((s+C)/(s-C))$ 的二阶导数为 $4Cs/(s^2-C^2)^2>0$。由 Jensen 不等式可得 $\sigma\geq2C\log((a+3C)/(a-3C))$，且右端关于 $C$ 严格递增。式 (20) 取等当且仅当 $x=y=z=a/3$、$c=\pm b/\sqrt3$。

同一下界也可由 [5，式 (10)] 推出，其较早来源为 [4]：三循环不等式为 $b/a\leq\tanh(\mathcal A/6)/\sqrt3$，且 $\sigma=(2C/3)\mathcal A$。本文不将 (20) 声称为新的谱—熵不等式。

令
$$
C_0=\begin{pmatrix}0&1&-1\\-1&0&1\\1&-1&0\end{pmatrix},
\qquad Q_{\rm hom}(a,b)=-aH+\frac b{\sqrt3}C_0.
\tag{21}
$$
由于 $C_0^2=-3H$，这一均匀生成元的谱为 $0,-a\pm ib$，熵产生为 $G(a,b)$，且
$$
e^{tQ_{\rm hom}(a,b)}
=\Pi+e^{-at}\left[
\cos(bt)H+\frac{\sin(bt)}{\sqrt3}C_0
\right].
\tag{22}
$$

在共振中心，$[G(u,\omega_0),\infty)$ 中的每个值都可以达到。一个自含的实现族是
$$
x_\delta=u/3-2\delta,\quad y_\delta=z_\delta=u/3+\delta,
\quad c_\delta=\sqrt{\omega_0^2/3+3\delta^2},
$$
$$
0\leq\delta<\delta_*=
\frac{2u}{3}-\frac{\sqrt{u^2+\omega_0^2}}{\sqrt3}.
\tag{23}
$$
此时 $\Delta=9\delta^2$，所有跃迁速率均为正，非零谱始终为 $-u\pm i\omega_0$。在零和子空间上，这两个特征值取指数后成为同一标量 $\lambda$；因此，包括非正规生成元在内，整个矩阵指数始终等于 $P_\lambda$。当 $\delta=0$ 时，熵产生为 $G(u,\omega_0)$；当 $\delta\uparrow\delta_*$ 时，$x_\delta-c_\delta\downarrow0$，而其反向通量仍为正，因此熵产生发散。连续性填满整个区间。文献 [7] 中另一个不同的显式族已经蕴含这一存在性结果；式 (23) 是对该背景事实的一种方便重构。

# 5. 低熵区间的证明

假设 $\lambda>0$。令 $\mathcal B_\varepsilon$ 为满足下列条件的所有实矩阵 $E$ 构成的闭球：
$$
E\mathbf1=0,\qquad \mathbf1^TE=0,\qquad \|E\|_F\leq\varepsilon.
$$
对每个这样的 $E$，$P_\lambda+E$ 都是严格正的随机矩阵：由 (6) 得 $\lambda<1/4$，由 (8) 得 $\varepsilon<\lambda/2<(1-\lambda)/3$。

主矩阵对数给出
$$
Q_{\rm pr}(E)=-uH+\frac1t\log(I+E/\lambda),
\tag{24}
$$
其中对数由其收敛幂级数定义。由于 $E\Pi=\Pi E=0$，将 (24) 乘以 $t$ 后取矩阵指数，恰得到 $P_\lambda+E$。同样的关系保证其行和与列和均为零。进一步有
$$
\|Q_{\rm pr}(E)+uH\|_F
\leq\frac1t\sum_{k\geq1}\frac{(\varepsilon/\lambda)^k}{k}
=D_\varepsilon.
\tag{25}
$$
因此，每个非对角元都至少为 $u/3-D_\varepsilon>0$。整个球都对应可容许的主对数生成元，而不只是球内某条选定的曲线。

反过来，主对数部分中的每个相容生成元都等于 (24)。该球是紧且连通的，熵产生在其严格正的生成元像上连续。熵产生非负，并在 $E=0$ 时为零，因此其像恰为 $[0,M_\varepsilon]$，且最大值可以达到。

为界定这一最大值，令 $A=Q_{\rm pr}(E)+uH$、$s_0=u/3$。由中值定理得
$$
\sigma(Q_{\rm pr})
\leq\frac{1}{3(s_0-D_\varepsilon)}
\sum_{i<j}(A_{ij}-A_{ji})^2
=\frac{2\|\operatorname{skew}A\|_F^2}{3(s_0-D_\varepsilon)}
\leq B_\varepsilon.
\tag{26}
$$
这里 $\operatorname{skew}A=(A-A^T)/2$。这就对球中的每个非正规主对数生成元建立了上界。

为构造与首项匹配的实例，取 $Q=-uH+c_\varepsilon C_0$。由式 (22) 得到精确距离
$$
\|e^{tQ}-P_\lambda\|_F
=2\sqrt2\lambda
\left|\sin\frac{\sqrt3 c_\varepsilon t}{2}\right|
=\varepsilon.
\tag{27}
$$
该分支属于主对数分支，并且在已述小误差假设下其跃迁速率为正。它的熵产生为 $L_\varepsilon$，从而证明了 (16) 中的双侧界。展开得到
$$
D_\varepsilon=\frac{\varepsilon}{\lambda t}+O(\varepsilon^2),
\quad
c_\varepsilon=\frac{\varepsilon}{\sqrt6\lambda t}+O(\varepsilon^3).
$$
上下界的首项均为 $2\varepsilon^2/(u\lambda^2t^2)$，且上界余项为 $O(\varepsilon^3)$。由此证明 (13)。这并不声称该实例对每个有限误差容限都使熵产生达到最大。

# 6. 高熵区间的证明

## 6.1 覆盖全部实对数分支

取首向量为 $\mathbf1/\sqrt3$ 的一组标准正交基，可将每个可容许的 $Q$ 化为 $0\oplus B$，其中 $B$ 为实 $2\times2$ 矩阵。若 $B$ 的特征值为实数，且观测谱位于正中心附近，则 $Q$ 属于主对数部分。实 Jordan 情形同样由主对数级数覆盖。正中心处的每个非主对数嵌入都必须具有非实谱 $-a\pm ib$，其绕转频率满足
$$
b\geq\frac{2\pi-|\arg z|}{t},
\tag{28}
$$
其中 $z=e^{(-a+ib)t}$ 是观测矩阵的两个非平凡特征值之一。

对于负中心，将观测特征值写为 $z=-w$。条件 (8) 使 $w$ 位于以正数 $\ell$ 为中心的圆盘内。$B$ 的实特征值取指数后不可能产生位于左半平面的观测谱。因此，每个相容的 $Q$ 都具有非实共轭对，并且
$$
b\geq\frac{\pi-|\arg w|}{t}.
\tag{29}
$$
这一变量替换不可省略；式 (29) 没有把正中心的辐角公式直接用于负实数。

## 6.2 Frobenius 约束给出全局谱圆盘

对观测矩阵在零和子空间上的块作酉 Schur 三角化，得到
$$
\|e^{tQ}-P_\lambda\|_F^2
\geq |z-\lambda|^2+|\overline z-\lambda|^2
=2|z-\lambda|^2.
\tag{30}
$$
此不等式覆盖全部非正规生成元。因此，在负中心情形按需作上述符号变换后，有 $|w-\ell|\leq r$。

由下包络 (20)、频率界 (28)–(29) 以及 $G_b>0$，得
$$
\sigma(Q)\geq
\min_{|w-\ell|\leq r}
G\left(-\frac{\log|w|}{t},\frac{\beta-|\arg w|}{t}\right).
\tag{31}
$$
该圆盘完全位于右半平面。利用共轭对称性，可将问题限制在圆盘的上半部分。在实轴之外，从 $w$ 到其对数模长与辐角的映射光滑且 Jacobian 非奇异，而 $G_a<0$、$G_b>0$。因此，目标函数在内部没有最小值。在实直径的内部作一个小的向上位移，会以一次阶减小 $b$，而只以二次阶改变 $a$，因此会减小目标函数。于是最小值必在上半圆弧上取得，恰得到 (10)。

## 6.3 端点的达到与整个区间的填充

对式 (10) 中每个边界点，条件 (8) 蕴含
$$
a_\phi\geq-\frac{\log(\ell+r)}{t}
>\sqrt3\omega_0\geq\sqrt3 b_\phi.
$$
因此，均匀生成元 $Q_{\rm hom}(a_\phi,b_\phi)$ 是可容许的。它达到熵产生下界，同时使 (30) 取等，所以最小化点精确实现 $m_\varepsilon$。

用直线段连接该点与圆盘中心。在每一点都采用 (21)，并保持相同的分支选择。整个线段位于观测谱圆盘内，且满足上述速率不等式。沿线段连续变化的熵值将 $m_\varepsilon$ 与 $G(u,\omega_0)$ 连接起来。随后，精确中心处的族 (23) 实现每一个更大的有限值。此处不需要连接路径上的熵值具有单调性。全局下界则排除了高熵部分中所有更小的值。

每个相容生成元都属于正中心的主对数部分，或者属于刚刚处理的分支。因此，(11) 与 (12) 得证。

最后，在整个正中心谱圆盘上都有
$$
a\leq-\log(\lambda-r)/t,\qquad
b\geq(2\pi-\arcsin(r/\lambda))/t.
$$
由于 $G$ 关于 $a$ 递减、关于 $b$ 递增，式 (17) 的右端是 $m_\varepsilon$ 的一个下界。结合 (26)，即得区间分离判据。

# 7. 高熵端点的锐利移动

写 $w=\ell+x+iy$，其中 $y\geq0$、$x^2+y^2\leq r^2$。在这一缩小的半圆盘上一致地有
$$
a=u-\frac{x}{\ell t}+O(r^2),\qquad
b=\omega_0-\frac{y}{\ell t}+O(r^2).
$$
因此，式 (31) 中的目标函数为
$$
G(u,\omega_0)
-\frac{G_a(u,\omega_0)x+G_b(u,\omega_0)y}{\ell t}
+O(r^2).
\tag{32}
$$
由于中心严格位于 $G$ 的光滑定义域内部，上述余项是一致的。半圆盘上线性分子的最大值为 $r\|\nabla G\|_2$，并在以下方向达到：
$$
(x,y)=r\,\frac{(G_a,G_b)}{\|\nabla G\|_2}.
$$
因为 $G_b>0$，这个方向满足半圆盘约束。代入 $r=\varepsilon/\sqrt2$ 即得 (14)。均匀生成元构造在一次阶达到等号，因此该系数是锐利的。一阶优化原理本身是标准方法；实质性结论在于，这一局部最小值也是全部对数分支的共同阈值。

# 8. 解释、局限与验证

间隙的持续存在并不意味着精确数据下孤立的零值是稳定的。可逆点扩展为宽度正比于 $\varepsilon^2$ 的区间，而高熵阈值以 $\varepsilon$ 阶移动。两种不同的阶数使被排除区间在充分小误差下仍然非空。

自然的观测精度尺度是相对于 $|\lambda|$ 而言的。在正特征值情形下，$\lambda<e^{-2\pi\sqrt3}$，因此相关重特征值很小。式 (13)–(14) 中的因子 $\lambda^{-2}$ 与 $|\lambda|^{-1}$ 直接揭示了对观测误差的敏感性。不能将本定理解释为在未指定绝对噪声水平下普遍适用的实际保证。

本文不要求固定活动率。尽管如此，在误差固定时，所有相容生成元的速率都有界。非平凡观测特征值的模长至少为 $\ell-\varepsilon$，故
$$
\sum_{i\ne j}q_{ij}=-\operatorname{tr}Q
=-\frac1t\log\det(e^{tQ})
\leq-\frac2t\log(\ell-\varepsilon).
\tag{33}
$$
因此，高熵区间向上无界并不能用整体时钟速率无界来解释。反向跃迁速率可以趋近于零。

模型假设均匀平稳分布已知、恰有三个可见状态、速率时间齐次，以及确定性的 Frobenius 范数误差容限。它不覆盖任意连续时间马尔可夫链所形成的不受限误差球，不覆盖未知隐藏结构；若没有另行论证的观测误差保证，也不提供有限样本覆盖率。低熵区间的上端点 $M_\varepsilon$ 由一个最优值可达到的紧集优化问题及锐利渐近式刻画；本文没有给出对每个有限容限都成立的精确闭式公式。

例如，当 $t=1$、$u=12$、$\varepsilon=0.1e^{-12}$ 时，显式界给出约 $0.00166742\leq M_\varepsilon\leq0.00190019$。标量端点的数值为 $m_\varepsilon\approx20.78908$，而式 (17) 右端较简单的严格下界表达式，其数值约为 $20.48623$。因此，两种端点的数量级差异来自定理本身，而非拟合出的区间分离。端点的数值优化被记录为数值证据，不作为区间算术证书。

主验证程序核查导数与距离恒等式，以高精度直接计算端点矩阵和连接路径上矩阵的指数，并核查两个渐近系数。另一套单独编写的验证程序在满足行列和为零的完整主对数观测球以及非正规的非主对数嵌入中抽样。先前的精确中心验证程序仍作为背景事实的辅助证据。有限计算不能证明全称排除结论或区间填充结论；这些证明由第 4–7 节给出。

本文未经外部同行评议或完整 Lean 认证。本版本暂未附计算程序与原始输出。

# 参考文献

1. M. T. Bauer, U. Seifert, and J. van der Meer. *Stroboscopic measurements in Markov networks: Exact generator reconstruction vs. thermodynamic inference*. Journal of Physics A **58**, 125001 (2025). [arXiv:2412.15642v2](https://arxiv.org/html/2412.15642v2).
2. M. Baake and J. Sumner. *Embedding of Markov matrices for $d\leq4$*. Journal of Mathematical Biology **89**, 23 (2024). [doi:10.1007/s00285-024-02112-w](https://doi.org/10.1007/s00285-024-02112-w).
3. L. Cocconi, R. Garcia-Millan, Z. Zhen, B. Buturca, and G. Pruessner. *Entropy Production in Exactly Solvable Systems*. Entropy **22**, 1252 (2020). [Open full text](https://pmc.ncbi.nlm.nih.gov/articles/PMC7711514/).
4. A. C. Barato and U. Seifert. *Coherence of biochemical oscillations is bounded by driving force and network topology*. Physical Review E **95**, 062409 (2017). [doi:10.1103/PhysRevE.95.062409](https://doi.org/10.1103/PhysRevE.95.062409).
5. N. Ohga, S. Ito, and A. Kolchinsky. *Thermodynamic Bound on the Asymmetry of Cross-Correlations*. Physical Review Letters **131**, 077101 (2023). [doi:10.1103/PhysRevLett.131.077101](https://doi.org/10.1103/PhysRevLett.131.077101).
6. A. Kolchinsky, N. Ohga, and S. Ito. *Thermodynamic bound on spectral perturbations, with applications to oscillations and relaxation dynamics*. Physical Review Research **6**, 013082 (2024). [doi:10.1103/PhysRevResearch.6.013082](https://doi.org/10.1103/PhysRevResearch.6.013082).
7. Anonymous. *Hidden architecture and the thermodynamic cost of an exact stochastic signal*. Version 1.0.0-candidate (28 October 2026). [doi:10.5281/zenodo.23721621](https://doi.org/10.5281/zenodo.23721621). [Public versioned source](https://github.com/ipitchford/hidden-architecture-exact-signal/tree/v1.0.0-candidate).
8. M. Santos Gutiérrez, N. Zagli, and G. Carigi. *Markov matrix perturbations to optimize dynamical and entropy functionals*. [arXiv:2507.14040v2](https://arxiv.org/abs/2507.14040v2) (2026 revision).
9. J. H. Fritz, B. Ertel, and U. Seifert. *Entropy estimation for partially accessible Markov networks based on imperfect observations: Role of finite resolution and finite statistics*. Physical Review E **111**, 044106 (2025). [arXiv:2412.04102](https://arxiv.org/abs/2412.04102).
10. T. R. Gingrich, O. A. Igoshin, A. B. Kolomeisky, and D. E. Makarov. *Thermodynamic inference from noisy single-molecule time series*. Journal of Chemical Physics **165**, 124124 (2026). [doi:10.1063/5.0354355](https://doi.org/10.1063/5.0354355). [Author accepted manuscript](https://gingrich.chem.northwestern.edu/papers/JCP26-AR-03331.pdf).

