# 量子通道高阶张量矩的精确谱半径

## 摘要

随机基准测试使用平均张量矩描述同一次随机门选择对多个副本的共同影响。高阶矩作用在指数增长的空间中，但在有限维正保迹通道的任意固定概率系综里，二阶已经控制所有更高阶的谱半径。具体而言，在全空间的谱中按代数重数移走一个由迹守恒产生的特征值 $1$ 后，每一阶 $n\ge 2$ 的剩余谱半径相同。对于固定量子通道经精确酉 2-design 共轭生成的系综，该半径恰好等于一阶衰减参数的绝对值与通道 unitarity 的较大者。非酉通道因而在任意阶都只有一个单位圆特征值，且该特征值为单根。

## 1. 问题与主定理

Wallman 与 Flammia 在 [1, §VII, Definition 15] 定义了张量 $n$ 阶收缩性，并在 $n=2$ 时提出精确酉 2-design 下非酉通道的收缩猜想。现有公开可核查的形式化结果建立了有限设计群下的二阶结论，并在成果条目的范围表中把 $n\ge3$ 列为开放方向 [2]。这里处理该高阶方向，并给出剩余谱的精确半径。

令 $d\ge 2$，$V_d$ 为 $d\times d$ 无迹 Hermitian 矩阵的实空间，配 Hilbert–Schmidt 内积，$D=d^2-1$。固定一个正保迹线性映射的 Borel 概率系综；映射为复线性并作用于 $M_d(\mathbb C)$。每次抽样得到 $\Phi$，记其在 $V_d$ 上的实矩阵为 $A_\Phi$。在每个张量中，同一次抽样同时用于所有因子。定义

$$
 B_n=\mathbb E\,\Phi^{\otimes n},\qquad
 M_k=\mathbb E\,A_\Phi^{\otimes k}.
$$

$B_n$ 的谱始终按在复数域上的代数重数计。设 $r_n$ 为移去一个由迹守恒贡献的特征值 $1$ 后剩余谱的最大模。

**定理 1.** 对任意上述系综和任意整数 $n\ge 2$，

$$
r_n=\max\{\rho(M_1),\rho(M_2)\}.
$$

**定理 2.** 设 $\Lambda$ 为固定的完全正保迹通道，$\mu$ 为 $U(d)$ 上任何精确酉 2-design 概率测度，置 $\Phi=\operatorname{Ad}_{U^\dagger}\circ\Lambda\circ\operatorname{Ad}_{U}$，其中 $U\sim\mu$。令 $T=\Lambda|_{V_d}$，$p=\operatorname{tr}(T)/D$，$u=\lVert T\rVert_F^2/D$。则对任意整数 $n\ge 2$，

$$
r_n=\max\{|p|,u\}.
$$

若 $\Lambda$ 为非酉通道，则 $r_n<1$；若其为酉通道，则单位圆上至少有两个特征值（计代数重数）。这里的精确酉 2-design 指二副本共轭平均与 Haar 一致。有限精确设计群的均匀测度满足定义。

## 2. 迹分解与高阶谱半径界

取 $e_0=I/\sqrt{d}$，与 $V_d$ 的实正交基合成 Hermitian 空间的正交基。该基复化后也是 $M_d(\mathbb C)$ 的正交基。正性保证保 Hermitian，保迹性给出矩阵块

$$
 \Phi =
 \begin{pmatrix}1&0\\ b_\Phi&A_\Phi\end{pmatrix}.
$$

对 $n$ 个因子按选取 $V_d$ 的位置集合 $S\subseteq\{1,\ldots,n\}$ 分解，再按 $|S|$ 递增排列。每个 $V_d$ 因子只能映到自身，每个 $e_0$ 因子可额外产生 $V_d$ 分量，所以从集合 $S$ 出发只能到包含 $S$ 的集合。在同一层内只能留在原集合。平均后仍为下三角块矩阵，并有

$$
 \det(zI-B_n)=(z-1)
   \prod_{k=1}^{n}\det(zI-M_k)^{\binom{n}{k}}.
$$

平移块可影响特征向量，对特征多项式没有贡献。这一步也覆盖不保持单位算子的通道。

令 $A_1,\ldots,A_m$ 独立同分布为 $A_\Phi$，$P_m=A_m\cdots A_1$。张量积的乘法律和独立性给 $M_k^m=\mathbb E P_m^{\otimes k}$。任意正保迹映射在 Hermitian 迹范数中收缩：对正负谱分解 $X=X_+-X_-$，三角不等式给出

$$
\lVert\Phi(X)\rVert_1
\le \operatorname{tr}\Phi(X_+)+\operatorname{tr}\Phi(X_-)
=\lVert X\rVert_1.
$$

组合仍正保迹，故 $\lVert P_m\rVert_{2\to2}\le\sqrt d$，利用 $\lVert X\rVert_2\le \lVert X\rVert_1\le \sqrt d\lVert X\rVert_2$。实矩阵的复化有同样的奇异值，因此此界也用于复空间上的谱估计。它还保证所有矩期望有界。

设 $w=\sum_{j=1}^D e_j\otimes e_j$，此处 $e_j$ 是 $V_d$ 的坐标基。在该基中

$$
\mathbb E\lVert P_m\rVert_F^2
 =w^{\mathsf T}M_2^m w\le D\lVert M_2^m\rVert_{2\to2}.
$$

等式来自 $w^{\mathsf T}(P_m\otimes P_m)w=\sum_{i,j}(P_m)_{ij}^2$。因此对任意 $k\ge2$，

$$
\begin{aligned}
\lVert M_k^m\rVert_{2\to2}
&\le \mathbb E\lVert P_m\rVert_{2\to2}^k\\
&\le d^{(k-2)/2}\mathbb E\lVert P_m\rVert_F^2\\
&\le d^{(k-2)/2}D\lVert M_2^m\rVert_{2\to2}.
\end{aligned}
$$

对 $m$ 取 $m$ 次根及极限，Gelfand 公式推出 $\rho(M_k)\le\rho(M_2)$。若 $M_2$ 幂零，同一有限步不等式也给出每个 $M_k$ 幂零。$n\ge2$ 时，谱分解已经含 $M_1$ 和 $M_2$ 两块，定理 1 由此成立。

## 3. 精确酉 2-design 与锐谱半径

写 $R(U)=\operatorname{Ad}_U|_{V_d}$，为实正交矩阵，$A_U=R(U)^{\mathsf T}TR(U)$。对任意 $D$ 阶矩阵 $C$，

$$
\mathbb E_U R(U)^{\mathsf T} C R(U)=\frac{\operatorname{tr}C}{D}I.
$$

每一项都是 $U$ 和 $\overline U$ 各二次的矩，由精确 2-design 与 Haar 平均一致。Haar 平均与共轭表示对易。该表示在复化的无迹空间上不可约：任一共轭不变复子空间经酉单参数群求导，便对与任一反 Hermitian 矩阵的交换子封闭；复线性使它成为 $\mathfrak{sl}_d(\mathbb C)$ 的理想，而后者为单李代数。Schur 引理和取迹给出公式。对 $C=T,T^{\mathsf T}T,TT^{\mathsf T}$ 分别应用，得到

$$
 M_1=pI,\qquad \mathbb E A_U^{\mathsf T}A_U
 =\mathbb E A_U A_U^{\mathsf T}=uI.
$$

不需要高阶设计的等矩性质。对独立产品逐步条件期望可得 $\mathbb E\lVert P_m\rVert_F^2=Du^m$。第 2 节的第一、二步估计给所有 $k\ge2$ 的 $\rho(M_k)\le u$。又由 $\mathbb E A_U A_U^{\mathsf T}=uI$，有 $M_2w=uw$，从而 $\rho(M_2)=u$。这给出等式，且有限 $m$ 有 $\lVert M_k^m\rVert_{2\to2}\le Dd^{(k-2)/2}u^m$。Cauchy–Schwarz 还给出 $|p|\le\sqrt u$。

最后，设 $J=(\Lambda\otimes\mathrm{id})(|\Omega\rangle\langle\Omega|)$ 为归一 Choi 态，$|\Omega\rangle=d^{-1/2}\sum_j|jj\rangle$。在矩阵单位基中，通道矩阵和 $dJ$ 的条目只作重排，所以 [3, Proposition 9] 的保迹情形给出

$$
 1+\lVert b_\Lambda\rVert_2^2+D u
 =d^2\operatorname{tr}(J^2)\le d^2.
$$

若 $u=1$，则 $\operatorname{tr}(J^2)=1$，$J$ 为秩一。通道于是只有一个 Kraus 算子。保迹意味着这个方阵 Kraus 算子 $K$ 满足 $K^\dagger K=I$，所以 $K$ 是酉矩阵。反过来酉共轭的 $T$ 正交，有 $u=1$，且 $w$ 给出标量块之外的特征值 $1$。非酉情形有 $u<1$ 和 $|p|<1$，于是标量块给出唯一且简单的单位圆特征值。定理 2 得证。

## 4. 可核验例子与结论边界

对单量子比特幅度阻尼通道，取存活振幅 $3/5$，则 $T=\operatorname{diag}(3/5,3/5,9/25)$，平移块非零。公式给 $p=13/25$、$u=177/625$，剩余谱半径由一阶块达到。对 Pauli $Z$ 相位翻转概率 $3/4$ 的通道，$T=\operatorname{diag}(-1/2,-1/2,1)$，得到 $p=0$、$u=1/2$，由二阶块达到。复现脚本使用 24 个单比特 Clifford 伴随作用和有理数，核验这两个案例以及一个酉边界案例的二阶至四阶完整张量平均与谱。

定理 1 适用于实际给定的正保迹分布。定理 2 的闭式系数使用固定通道的酉共轭及精确二阶矩。本文的谱结论对应独立抽样、每个时间步各副本共享同一抽样的矩算子。一阶和二阶的精确谱半径并不直接给出所有可测信号的最优有限序列长度误差界。

## 参考文献

1. J. J. Wallman and S. T. Flammia, *Randomized benchmarking with confidence*. New Journal of Physics 16, 103032 (2014). [arXiv:1404.6025](https://arxiv.org/abs/1404.6025) · [DOI](https://doi.org/10.1088/1367-2630/16/10/103032).
2. Trureturing, *Wallman–Flammia unrestricted two-contractivity*. [公开研究与形式化记录](https://www.trureturing.org/research/wf1404/)，Scope assessment.
3. J. Wallman, C. Granade, R. Harper and S. T. Flammia, *Estimating the coherence of noise*. New Journal of Physics 17, 113020 (2015). [arXiv:1503.07865](https://arxiv.org/abs/1503.07865) · [DOI](https://doi.org/10.1088/1367-2630/17/11/113020).
4. J. Helsen, J. J. Wallman, S. T. Flammia and S. Wehner, *Multi-qubit randomized benchmarking using few samples*. Physical Review A 100, 032304 (2019). [arXiv:1701.04299](https://arxiv.org/abs/1701.04299).
5. M. Ogura and C. F. Martin, *A limit formula for joint spectral radius with p-radius of probability distributions*. Linear Algebra and its Applications 458 (2014), 605–625. [arXiv:1401.3026](https://arxiv.org/abs/1401.3026).
