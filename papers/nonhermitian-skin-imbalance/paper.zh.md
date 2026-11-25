# 周期谱线隙与多体趋肤效应：一个严格反例

研究稿，2026-11-24。目标读者为凝聚态理论与数学物理方向的博士研究生。

## 摘要

逐个看，非厄米晶格的单粒子态可以全部堆积在同一个边界。把这些态填成多体基态时，泡利原理迫使我们考虑占据态张成的空间，而单个态的密度不能直接相加。本文构造一个双轨费米链。它的两条周期谱支相交，半填充无法填满由线隙区分的周期谱群；在开边界下，所有单粒子右本征态仍然局域在同一端，但半填充基态的两半粒子数之差在任意长度下都有统一上界。按 Alsallom 等人猜想 1 给出的线隙与粒子数差定义，这构成其“否则呈线性增长”方向的反例。

## 1. 命题与物理量

设偶数 $L\ge2$ 为晶胞数，每胞有两条轨道。令 $S_L e_j=e_{j+1}$（$j<L$），$S_L e_L=0$。给定 $r>1$，令

$$
A_L=rS_L+r^{-1}S_L^\ast,\qquad C=r+r^{-1}.
$$

设 $0<\varepsilon<1$ 及 $2<\delta<C\sqrt{1-\varepsilon^2}$，并要求 $\varepsilon C<\delta$。考虑开边界单粒子矩阵

$$
H_L=\begin{pmatrix}
A_L+\delta I_L & \varepsilon A_L\\
\varepsilon A_L & A_L-\delta I_L
\end{pmatrix},
$$

以及它生成的守粒子数自由费米哈密顿量。周期边界模型只将 $S_L$ 换为循环移位。取含 $L$ 个费米子的右基态 $|\Psi_L\rangle$，采用普通 Hilbert 内积归一化。记每胞总粒子数为 $n_j$，用 [1, 式 (5)] 的期望值定义 [1, 式 (6)] 的两半不平衡量

$$
I_L=\sum_{j>L/2}\langle\Psi_L|n_j|\Psi_L\rangle
       -\sum_{j\le L/2}\langle\Psi_L|n_j|\Psi_L\rangle.
$$

**定理。** 对上述参数，开边界半填充基态唯一，其固定粒子数激发间隙至少为 $2(\delta-2)$；全部单粒子右本征态一致地局域于同一右端。周期边界的两条连续谱支相交，因而在热力学极限只能组成一个线隙谱群。半填充占据 $L$ 个轨道，与该谱群的全空或全满都相差 $L$ 个轨道。另一方面，令 $q=\varepsilon C/\delta$，则对所有偶数 $L\ge2$，

$$
|I_L|\ \le\ \frac{q^2(1+q^2)}{2(1-q^2)^3}.
$$

原猜想按线隙划分周期谱群，断言当开边界占据态无法对应于若干完全占据的周期谱群（允许热力学极限中零比例的例外）时，两半不平衡量呈线性增长 [1, § IV, Conjecture 1]。定理满足该方向的前提，并给出 $I_L/L\to0$。结论针对这一定义下的密度不平衡量。

## 2. 开边界谱与单粒子局域

记 $D_L e_j=r^j e_j$。则 $A_L=D_L(S_L+S_L^\ast)D_L^{-1}$。对于 $1\le n\le L$，记 $\theta_n=n\pi/(L+1)$、$x_n=2\cos\theta_n$，以及 $u_n(j)=r^j\sin(j\theta_n)$。这些 $u_n$ 构成 $A_L$ 的右本征基。由每个 $u_n$ 张成的两轨道空间中，$H_L$ 作用为实对称矩阵

$$
\begin{pmatrix}x_n+\delta&\varepsilon x_n\\
\varepsilon x_n&x_n-\delta\end{pmatrix}.
$$

其本征值为 $E_\pm(x_n)=x_n\pm\sqrt{\delta^2+\varepsilon^2 x_n^2}$。对 $x\in\mathbb R$，$E_\pm'(x)>1-\varepsilon>0$，而 $-2<x_n<2$。所以两支各自无简并，且 $E_-<-(\delta-2)<0<\delta-2<E_+$。固定粒子数的最低能量配置恰为占据全部负支，任何其它配置至少增加 $2(\delta-2)$ 的能量。

对距离右端 $d=L-j$ 的晶胞，$\sin(L\theta_n)$ 的绝对值等于 $\sin\theta_n>0$。由 $|\sin((d+1)\theta)|\le(d+1)|\sin\theta|$，任一已归一化的两轨道右本征态 $\psi_{n,\pm}$ 有

$$
\|(\psi_{n,\pm})_{L-d}\|_{\mathbb C^2}
\le \frac{|u_n(L-d)|}{|u_n(L)|}
\le (d+1)r^{-d}.
$$

因此右端局域对每个能级和系统尺寸统一成立，且两支局域方向相同。格点跃迁矩阵 $I_2+\varepsilon\sigma_x$ 与胞内矩阵 $\delta\sigma_z$ 没有公共不变直线。该模型存在轨道杂化，无法用同一个胞内基将这两个矩阵同时对角化。

## 3. 周期谱交会与绕数

取周期移位的 Bloch 约定，使

$$
z(k)=r e^{ik}+r^{-1}e^{-ik}
     =C\cos k+i(r-r^{-1})\sin k.
$$

周期谱支为 $E_\pm(z)=z\pm\sqrt{\delta^2+\varepsilon^2z^2}$。在包含椭圆的开圆盘 $|z|<\delta/\varepsilon$ 内，平方根取在 $z=0$ 等于 $\delta$ 的解析分支。由于 $q<1$，该分支也等于主值，且 $\operatorname{Re}\sqrt{\delta^2+\varepsilon^2z^2}>0$。在 $k=\pi/2$，$E_+(z(k))$ 的实部严格为正；在 $k=\pi$，实部为 $-C+\sqrt{\delta^2+\varepsilon^2C^2}<0$。因此存在 $k_\ast\in(\pi/2,\pi)$，使 $E_+(z(k_\ast))$ 落在虚轴。利用 $z(\pi-k)=-\overline{z(k)}$ 得

$$
E_-(z(\pi-k_\ast))=-\overline{E_+(z(k_\ast))}
                  =E_+(z(k_\ast)).
$$

两条连续闭曲线有公共点。任何将它们分置于不同开半平面的直线都必须穿过谱，故两支没有相隔的线隙。离散有限尺寸可以避开交点，题设的线隙谱群和轨道比例均取热力学极限。

与此同时，周期 Bloch 矩阵的行列式为

$$
\det H(k)=(1-\varepsilon^2)z(k)^2-\delta^2.
$$

其关于 $z$ 的两个零点 $\pm\delta/\sqrt{1-\varepsilon^2}$ 都严格位于椭圆内部。按上述 Bloch 约定，椭圆绕每个零点一周，因此周期谱在基点 $0$ 处有点隙，且行列式绕数恰为 $2$。周期绕数与开边界单粒子右端局域在这里同时成立。

## 4. 占据子空间与不平衡的统一上界

称 $\mathcal V_L$ 为 $L$ 个负能量右本征态张成的空间。定义

$$
f(z)=-\frac{\varepsilon z}{\delta+\sqrt{\delta^2+\varepsilon^2z^2}},
\qquad F=f(A_L).
$$

矩阵函数可用幂级数定义，因为 $\|A_L\|\le C<\delta/\varepsilon$。负支本征态为 $(f(x_n)u_n,u_n)$ 的标量倍数。由于 $u_n$ 构成全空间的基，

$$
\mathcal V_L=\{(Fv,v):v\in\mathbb C^L\}.
$$

令 $M=(I+F^\ast F)^{-1}$。从注入 $(F,I)^\mathsf T$ 得到占据空间的**正交**投影

$$
P_{\mathcal V_L}=\begin{pmatrix} FMF^\ast & FM\\ MF^\ast & M \end{pmatrix}.
$$

归一化行列式态的一体密度矩阵等于这个正交投影。理由是任取占据空间的正交基再作外积，所得行列式和原态仅差整体相位；在该正交基中利用费米反对易关系即可得到一体密度矩阵。同一晶胞上两轨道的投影对角元之和给出 $\langle n_j\rangle$。

记 $Q$ 为右半链晶胞的正交投影，右侧过剩粒子数满足

$$
\begin{aligned}
\sum_{j>L/2}(\langle n_j\rangle-1)
&=\operatorname{Tr}\bigl[Q(M+FMF^\ast-I)\bigr]\\
&=\operatorname{Tr}(QFMF^\ast-QF^\ast FM)\\
&=\operatorname{Tr}\bigl([Q,F]MF^\ast\bigr).
\end{aligned}
$$

第二行使用 $I-M=F^\ast FM$；第三行将第二项循环移动，并使用 $F^\ast F$ 与 $M$ 交换。因为总粒子数等于 $L$，$I_L$ 是此式左端的两倍。该恒等式也可以用于一般的占据子空间图。它说明这里的总不平衡由跨切口的矩阵元控制。

在半链切口上，$[Q,A_L]$ 只有两项非零，分别对应穿越切口的右跳和左跳，两奇异值为 $r,r^{-1}$。于是 $\|[Q,A_L]\|_1=C$，下标 $1$ 表示迹范数。对 $m\ge1$ 展开幂的交换子得

$$
\|[Q,A_L^m]\|_1\le m C^m.
$$

令 $w=\varepsilon z/\delta$。在 $|w|<1$，

$$
f(z)=\frac{1-\sqrt{1+w^2}}{w}
    =-\sum_{m=1}^\infty {1/2\choose m}w^{2m-1}.
$$

在 $w=0$ 取解析延拓值零。对所有 $m\ge1$ 有 $|{1/2\choose m}|\le1/2$。幂级数绝对收敛，给出

$$
\|F\|\le\frac{q}{2(1-q^2)},\qquad
\|[Q,F]\|_1\le\frac{q(1+q^2)}{2(1-q^2)^2}.
$$

迹的对偶范数不等式和 $\|M\|\le1$ 给出 $|I_L|\le2\|[Q,F]\|_1\|F\|$，即定理的上界。取 $r=3$、$\varepsilon=1/4$、$\delta=5/2$，则 $q=1/3$，得到对任意偶数 $L$ 的解析界 $|I_L|\le45/512$。

## 5. 与原猜想及相关工作的关系

[1] 自身的固定胞内比值模型已经说明，某些占据空间可以让不平衡量严格为零。其数值研究还在非厄米 SSH 链中发现周期线隙关闭和不平衡增长同时出现。本文在同一猜想的普遍命题中给出反例所需的物理组合：轨道杂化、相交的周期谱支、有统一间隙的开边界半填充基态，以及随长度统一有界的粒子数差。证明定位了其中一个原因：开边界占据空间仍然可由快速衰减的矩阵函数表示，而周期能谱的线隙判据无法排除这种表示。

两轨道谱支在每个固定动量 $k$ 上仍可逐点区分。若改用逐点直接间隙来定义完整周期带，可以把负支称为完整带，原文所说的“线隙分隔”就被替换成不同判据。本文以原文的线隙定义为准。对使用多体谱绕数、Fock 空间局域或纠缠等其它定义的研究，本结果只提供同一模型与密度观测量，相关量需另行计算。

## 参考文献

1. F. Alsallom、L. Herviou、O. V. Yazyev 与 M. Brzezińska，*Fate of the non-Hermitian skin effect in many-body fermionic systems*，Phys. Rev. Research **4**，033122 (2022)。[正式版](https://doi.org/10.1103/PhysRevResearch.4.033122)。
2. L. Li、C. H. Lee、S. Mu 与 J. Gong，*Critical non-Hermitian skin effect*，Nat. Commun. **11**，5491 (2020)。[正式版](https://doi.org/10.1038/s41467-020-18917-4)。
3. S. Long 与 L. Li，*Concurrent Skin-scale-free Localization and Criticality under Möbius Boundary Conditions in a Non-Hermitian Ladder*。[预印本 v1](https://arxiv.org/abs/2507.05691v1)。
4. S. Hamanaka 与 K. Kawabata，*Multifractality of many-body non-Hermitian skin effect*。[预印本 v3](https://arxiv.org/abs/2401.08304v3)。
