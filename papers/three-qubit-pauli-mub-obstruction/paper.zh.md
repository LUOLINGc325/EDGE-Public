# 三量子比特张量 Pauli 单轨道互无偏基的不存在性

**Nonexistence of three-qubit tensor-Pauli single-orbit mutually unbiased bases**

研究草稿 · 2026 年 11 月 24 日 · 理论物理／量子信息

## 摘要

我们证明：任意归一化向量 $\psi\in\mathbb C^8$ 在 $\{I,X,Y,Z\}^{\otimes3}$ 下产生的全部 64 个带标签轨道向量，均不能被分成八个两两互无偏的正交归一基。振幅、相位及分组完全任意；逐标签改变单位模相位也不影响结论。证明首先从实际 MUB 分组得到非恒等 Pauli 期望的模平方只能为 $0$ 或 $1/8$，继而用 Pauli 重构将纯态投影写成高斯有理矩阵的仿射变换。投影的幂等性迫使该矩阵同时满足一个含 $6\sqrt8$ 的二次方程，与 $\sqrt8$ 的无理性矛盾。更强的中间结论直接排除具有该完整 Pauli 期望模式的任何归一化纯态。

本结果处理 Damski 等人关于乘积 Weyl–Heisenberg MUB 基准态讨论中的三量子比特任意相位情形 [1]。方法承接已知的 Pauli 协变轨道算术障碍思路 [2]；部分 Pauli 期望等模而其余为零的模式也已有研究 [3]。本文的增量是该精确维数和 MUB 尺度上的解析排除，以及从实际轨道分组到不可能性结论的完整形式化证明。本文不声称解决其他量子比特数的一般猜想。

## 1. 问题、范围与贡献

对 $d$ 维复空间中的两个正交归一基 $\{u_j\}$、$\{v_k\}$，互无偏条件是 $|\langle u_j,v_k\rangle|^2=1/d$。本稿研究一个结构特别受限的构造：只取一个向量，施加全部三量子比特张量 Pauli 操作，再尝试将所得 64 个向量重排成八个这样的基。

Damski 等人在 [1, §IV.C，Conjecture 1 及其后讨论] 给出了三量子比特八次单位根相位范围的有限搜索，并讨论更高次单位根仍可能产生基准态的缺口。本稿将研究对象直接固定为任意归一化 $\mathbb C^8$ 向量，因而同时覆盖非等模振幅和连续相位。原文一般维数表达式的归一化写法不影响这里独立给出的维数八命题。

这里排除的是指定的**完整单轨道构造**。定理不讨论一般 MUB 的存在性，不要求轨道预先具有平凡稳定子，也不预设 Pauli 标签如何分组。若标签产生重复向量或相同射线，分组条件本身就必须处理它们；证明没有额外假设轨道互异。

成果的实质有两点：一是将有限相位搜索提升为对任意归一化复向量的定理；二是给出可逐项核验的短算术证明，并把具体矩阵、实际分组、归一化与最终结论连成一个 Lean 内核验证链。

## 2. 具体对象和主定理

记计算基下标集 $J=\{0,1\}^3$，Pauli 标签集 $L=\{0,1,2,3\}^3$。定义

$$
\sigma_0=\begin{pmatrix}1&0\\0&1\end{pmatrix},\quad
\sigma_1=\begin{pmatrix}0&1\\1&0\end{pmatrix},\quad
\sigma_2=\begin{pmatrix}0&-i\\i&0\end{pmatrix},\quad
\sigma_3=\begin{pmatrix}1&0\\0&-1\end{pmatrix}.
$$

对 $p=(p_1,p_2,p_3)\in L$，令 $P_p=\sigma_{p_1}\otimes\sigma_{p_2}\otimes\sigma_{p_3}$。标签 $0=(0,0,0)$ 对应恒等矩阵。内积约定为 $\langle u,v\rangle=\sum_{a\in J}\overline{u_a}v_a$。

**定义 1（完整 MUB 分组）。** 向量族 $(v_p)_{p\in L}$ 具有完整 MUB 分组，是指存在双射

$$e:\{0,\ldots,7\}\times\{0,\ldots,7\}\longrightarrow L$$

满足同一基内 $\langle v_{e(b,j)},v_{e(b,k)}\rangle=\delta_{jk}$，且当 $b\ne c$ 时，$|\langle v_{e(b,j)},v_{e(c,k)}\rangle|^2=1/8$。双射要求全部标签恰好使用一次。这是具体的正交与互无偏条件，不包含任何重构、纯性或算术障碍结论。

**定理 1（主定理）。** 对每个满足 $\langle\psi,\psi\rangle=1$ 的 $\psi:J\to\mathbb C$，向量族 $(P_p\psi)_{p\in L}$ 不具有完整 MUB 分组。

**定理 2（任意相位代表）。** 对任意满足 $\langle\psi,\psi\rangle=1$ 的 $\psi:J\to\mathbb C$，以及任意满足 $|\alpha_p|^2=1$（对所有 $p\in L$）的 $\alpha:L\to\mathbb C$，向量族 $(\alpha_p P_p\psi)_{p\in L}$ 不具有完整 MUB 分组。因此结论不依赖 Pauli 代表或轨道向量的单位模相位选择。

以下证明先得到比定理 1 更强的 Pauli 期望模式排除，再处理相位代表。

## 3. 从分组到具体 Pauli 展开

给定向量 $\psi$，定义矩阵 $R$ 与 Pauli 系数

$$R_{ab}=\psi_a\overline{\psi_b},\qquad c_p=\operatorname{Tr}(P_pR).$$

**引理 1（归一化纯态）。** 若 $\langle\psi,\psi\rangle=1$，则 $\operatorname{Tr}R=1$ 且 $R^2=R$。

证明：迹的等式由定义逐项相加得到。对任意 $a,b$，

$$
(R^2)_{ab}=\sum_k\psi_a\overline{\psi_k}\psi_k\overline{\psi_b}
=\psi_a\langle\psi,\psi\rangle\overline{\psi_b}=R_{ab}.
$$

**引理 2（具体 Pauli 重构与实性）。** 对任意复矩阵 $R\in M_8(\mathbb C)$，

$$\sum_{p\in L}\operatorname{Tr}(P_pR)P_p=8R.\tag{1}$$

此外 $P_0=I$，各 $P_p$ 的条目都是高斯整数且 $P_p$ 为 Hermitian。若 $R=\psi\psi^*$，则全部 $c_p$ 为实数，并且 $c_p=\langle\psi,P_p\psi\rangle$。

证明：直接代入四个 $2\times2$ 矩阵可得

$$\sum_{r=0}^3(\sigma_r)_{kl}(\sigma_r)_{ab}=2\delta_{kb}\delta_{la}.$$

对三个坐标取乘积，有限求和分离为三项之积，得到

$$\sum_{p\in L}(P_p)_{kl}(P_p)_{ab}=8\delta_{kb}\delta_{la}.\tag{2}$$

将 $\operatorname{Tr}(P_pR)=\sum_{k,l}(P_p)_{kl}R_{lk}$ 代入，即得 (1)。恒等、Hermitian 与高斯整数性质直接由上述四个矩阵及乘积得到。对 Hermitian 的 $R$，对 $c_p$ 共轭后交换求和下标便恢复 $c_p$；纯态矩阵满足这一条件。最后将 $R_{ba}=\psi_b\overline{\psi_a}$ 代入迹定义，便得到内积表达式。这里的重构适用于任意复矩阵，未把待证性质作为假设。

**引理 3（分组给出的必要条件）。** 若 $(P_p\psi)_{p\in L}$ 具有完整 MUB 分组，则对每个 $p\ne0$，

$$|c_p|^2\in\{0,1/8\}.\tag{3}$$

证明：分组双射将标签 $0$ 与 $p$ 放入同一基或不同基。同一基时，标签不同意味着列下标不同，内积为零；不同基时，内积模平方为 $1/8$。由 $P_0\psi=\psi$ 和引理 2，得到 (3)。此步只使用实际分组定义，并没有预设某种 Pauli 子群分解。

## 4. 高斯有理性与纯性之间的矛盾

记 $\mathbb Q(i)=\{a+ib:a,b\in\mathbb Q\}$，令 $s=\sqrt8$。

**引理 4（系数缩放）。** 若复数 $z$ 的虚部为零，且 $|z|^2$ 为 $0$ 或 $1/8$，则 $sz\in\mathbb Q(i)$。

证明：模平方为零时 $z=0$。另一情形令 $x=\operatorname{Re}z$，则 $x^2=1/8$，故 $(sx)^2=1$。于是 $sx$ 为 $1$ 或 $-1$，而 $\operatorname{Im}(sz)=0$，结论成立。

**引理 5（无理缩放）。** 设 $t\in\mathbb R$ 无理，$z\in\mathbb Q(i)$ 且 $tz\in\mathbb Q(i)$，则 $z=0$。

证明：分别写实部与虚部为有理数。若其中一个分量 $q$ 非零，且对应的乘积为有理数 $r$，则 $t=r/q\in\mathbb Q$，矛盾。所以两个分量均为零。这里 $\sqrt8$ 的无理性也可直接验证：若它为有理数，则 $8$ 是有理数的平方。由最简分数的分母约束，正整数的有理平方根必为整数，于是 $8$ 应是自然数的平方；但 $2^2<8<3^2$，矛盾。若 $6\sqrt8$ 有理，除以 $6$ 又会使 $\sqrt8$ 有理。

**引理 6（矩阵算术障碍）。** 在任意非空有限下标集上，不存在条目均属于 $\mathbb Q(i)$ 的方阵 $B$ 满足

$$B^2=6sB+56I.\tag{4}$$

证明：高斯有理数对加、减、乘和有限求和封闭。因此由 (4)，每个 $(6s)B_{ab}=(B^2-56I)_{ab}$ 仍属于 $\mathbb Q(i)$。引理 5 对每个条目给出 $B_{ab}=0$。再取任一对角条目，(4) 便成为 $0=56$，矛盾。这里未假设 $B$ 的不同分量或参与展开的不同 Pauli 矩阵彼此交换。

**引理 7（幂等矩阵的移位方程）。** 若 $R^2=R$，令

$$B=s(8R-I).\tag{5}$$

则 $B$ 满足 (4)。

证明：先置 $C=8R-I$。仅使用矩阵分配律及 $R^2=R$，得到

$$C^2=64R^2-16R+I=48R+I=6C+7I.$$

再用 $s^2=8$，得到 $B^2=8C^2=48C+56I=6sB+56I$。整个推导不需要谱分解、矩阵对角化或正定性假设。

**定理 3（更强的期望模式排除）。** 不存在归一化 $\psi\in\mathbb C^8$，使其每个非恒等张量 Pauli 期望都满足 (3)。

证明：反设存在。由引理 1，$R=\psi\psi^*$ 满足 $R^2=R$、$\operatorname{Tr}R=1$。由引理 2，$c_0=1$ 且

$$B=s(8R-I)=\sum_{p\ne0}(sc_p)P_p.\tag{6}$$

引理 2 和引理 4 表明每一项的每个条目都是高斯有理数，有限和仍然如此。因此 $B$ 的全部条目属于 $\mathbb Q(i)$。引理 7 又给出 (4)，与引理 6 矛盾。

**定理 1 的证明。** 完整 MUB 分组由引理 3 推出 (3)，而定理 3 排除了该模式。

**定理 2 的证明。** 对单位模 $\alpha,\beta$，直接由内积定义可得

$$\langle\alpha u,\beta v\rangle=\overline\alpha\beta\langle u,v\rangle,$$

所以内积的模平方保持不变。同一标签的范数也保持不变，同一基的零内积亦保持不变。因此逐标签相位调整若产生完整 MUB 分组，则原向量族也具有该分组，与定理 1 矛盾。

## 5. 形式化范围与非退化性

原稿所述形式化源码使用具体的复数、有限索引和矩阵条目。MUB 分组是一个覆盖全部标签的双射，加上原始正交和互无偏等式；定义中没有放入重构、系数平坦性或最终不可能性结论。主定理的唯一状态条件是标准归一化。

非退化实例取计算基向量 $\psi_{000}$：其 $(0,0,0)$ 分量为 $1$，其余为 $0$，内积恰为 $1$。因此归一化状态集合并非空集。零向量不满足归一化，而 $1$ 是非零高斯有理数；这两个边界实例也单独核验。下标集大小 $|J|=8$ 和 $|L|=64$ 同样单独核验。高斯有理数条件由有理实部及有理虚部的存在性定义；实数无理性直接定义为对每个 $q\in\mathbb Q$ 都不等于其在 $\mathbb R$ 中的嵌入。这些定义仅给出通常的算术含义，无理缩放和矩阵障碍均另行证明。

附录列出相关数学结论。此版本暂未附形式化源码和编译凭证，不声称已重新验证公理依赖。独立 Python 验证器另以整数对表示高斯整数，核验具体 Pauli 数据及重构核。有限证书用于复核矩阵实现；任意振幅、连续相位和最终量词由 Lean 定理覆盖。

## 6. 近邻结果、价值与边界

Godsil–Roy [2, Lemma 3.1] 对张量 Pauli 协变 SIC 轨道使用了算术限制。其不同向量间的内积模平方为 $1/(d+1)$，且没有本稿允许的零重叠。本稿承认这一方法先例，针对 MUB 的内积模平方为 $0$ 或 $1/d$ 的条件，使用纯性方程得到所需矛盾。本文不把有理性障碍本身宣称为新方法。

Cieśliński [3, §V.A] 已讨论部分 Pauli 期望等绝对值、其余为零的纯态。因此这种抽象模式不是本文首次提出。本文固定三量子比特的 MUB 尺度 $1/\sqrt8$，证明该完整模式不可能来自归一化纯态，并将其连接到 [1] 的单轨道构造问题。

这项排除结果使维数八中的该类相位搜索有了确定的终止理由：在本文精确设定下，扩大相位分母或改变振幅不会得到遗漏的解。它不提供近似构造的最优误差，不处理稳健性界，也不把结论推广到其他量子比特数或不同协变群。

查新结论限定于 2026 年 11 月 24 日已核验的原始文献。未检得等价结果并不能证明全球优先权。本稿是带可复核证明材料的研究草稿，尚未经过外部同行评议。[3] 的全文通过标注 v2 的作者稿镜像核读；canonical PDF 在本次访问中不可读，未声称二者已逐字节比对。该文用于近邻比较，不作为证明的逻辑前提。

## 参考文献

[1] Bogdan S. Damski, Rafał Bistroń, Diego Ponterio, Jakub Czartowski, Karol Życzkowski. *Product Weyl–Heisenberg covariant mutually unbiased bases and extremal non-stabilizerness*. arXiv:2603.15550v2, 2026. [原始条目](https://arxiv.org/abs/2603.15550)；[作者稿](https://arxiv.org/pdf/2603.15550)。重点：Definition 1、§IV.C、Conjecture 1 及后续讨论。

[2] Chris Godsil, Aidan Roy. *Equiangular lines, mutually unbiased bases, and spin models*. European Journal of Combinatorics 30 (2009), 246–262. arXiv:quant-ph/0511004v3. [作者稿](https://arxiv.org/pdf/quant-ph/0511004)。重点：Lemma 3.1。 

[3] Paweł Cieśliński. *Pauli Flat Quantum States Mimicking Maximal Magic*. arXiv:2610.07172v2, 2026. [原始条目](https://arxiv.org/abs/2610.07172)；[本次核读的作者稿镜像](https://arxiv.cnoctave.top/pdf/2610.07172)。重点：§V.A。 


## 附录 A. 全文形式化覆盖清单

C1–C59 列出原稿形式化涉及的数学结论。本版本未附 Lean 源码，因此该清单仅说明数学范围，不构成独立的机器验证凭证。

三个实例依次为：存在归一化的具体计算基向量；零向量不归一化；存在非零高斯有理数。

### A.1 高斯有理数与算术障碍

形式化结论 C1：GaussianRat.of_rat。 任意有理数嵌入复数后是高斯有理数。

形式化结论 C2：GaussianRat.zero。 零是高斯有理数。

形式化结论 C3：GaussianRat.one。 一是高斯有理数。

形式化结论 C4：GaussianRat.I。 虚数单位是高斯有理数。

形式化结论 C5：GaussianRat.add。 高斯有理数对加法封闭。

形式化结论 C6：GaussianRat.neg。 高斯有理数对取负封闭。

形式化结论 C7：GaussianRat.sub。 高斯有理数对减法封闭。

形式化结论 C8：GaussianRat.mul。 高斯有理数对乘法封闭。

形式化结论 C9：GaussianRat.conj。 高斯有理数对共轭封闭。

形式化结论 C10：GaussianRat.sum。 任意有限集合上的高斯有理数之和仍是高斯有理数。

形式化结论 C11：GaussianRat.sum_univ。 任意有限下标类型上的全体求和保持高斯有理性。

形式化结论 C12：GaussianRat.matrix_mul。 高斯有理矩阵相乘后的每个条目仍是高斯有理数。

形式化结论 C13：rational_mul_irrational_zero。 无理实数乘有理数若为有理数，则所乘的有理数为零。

形式化结论 C14：GaussianRat.eq_zero_of_irrational_mul。 高斯有理数被任意无理实数缩放后若仍高斯有理，则原数为零。

形式化结论 C15：irrational_sqrt_eight。 $\sqrt8$ 无理。

形式化结论 C16：irrational_six_sqrt_eight。 $6\sqrt8$ 无理。

形式化结论 C17：no_gaussian_matrix_sqrt8_polynomial。 任意非空有限维高斯有理矩阵不能满足式 (4)。

形式化结论 C18：shifted_idempotent_polynomial_eight。 任意幂等矩阵经式 (5) 变换后满足式 (4)。

形式化结论 C19：no_gaussian_scaled_idempotent_eight。 幂等矩阵不可能在式 (5) 变换后具有全体高斯有理条目。

### A.2 具体 Pauli 矩阵和重构

形式化结论 C20：pauli1_zero。 单比特零标签矩阵为恒等矩阵。

形式化结论 C21：pauli1_conj。 每个具体单比特 Pauli 矩阵的共轭条目等于转置条目。

形式化结论 C22：pauli1_complete。 四个单比特矩阵满足局部完备核恒等式。

形式化结论 C23：pauli_zero。 三比特零标签矩阵为恒等矩阵。

形式化结论 C24：coeff_zero。 任意复矩阵的零标签系数等于其迹。

形式化结论 C25：pauli_conj。 每个三比特 Pauli 张量均为 Hermitian。

形式化结论 C26：triple_sum。 三个有限求和的可分离乘积可分解为三个和的乘积。

形式化结论 C27：tensor_complete。 全部三比特 Pauli 张量满足式 (2)。

形式化结论 C28：reconstruction。 任意八维复矩阵均满足式 (1) 的 Pauli 重构。

形式化结论 C29：coeff_conj_of_hermitian。 Hermitian 矩阵的各 Pauli 系数在共轭下不变。

形式化结论 C30：pureDensity_conj。 任意向量的纯态矩阵为 Hermitian。

形式化结论 C31：pure_coeff_conj。 纯态矩阵的各 Pauli 系数在共轭下不变。

形式化结论 C32：pure_coeff_im。 纯态 Pauli 系数的虚部为零。

形式化结论 C33：pure_coeff_real。 纯态 Pauli 系数等于其实部的复数嵌入。

形式化结论 C34：pauli1_gaussian_int。 具体单比特 Pauli 条目为高斯整数。

形式化结论 C35：gaussian_int_mul。 两个高斯整数相乘仍为高斯整数。

形式化结论 C36：pauli_gaussian_int。 所有三比特 Pauli 条目为高斯整数。

形式化结论 C37：pauli_re_im_integer。 所有三比特 Pauli 条目的实部和虚部均为整数。

### A.3 归一化与纯态矩阵

形式化结论 C38：density_trace。 纯态矩阵的迹等于向量与自身的内积。

形式化结论 C39：density_mul。 任意有限下标上的归一化向量产生幂等纯态矩阵。

形式化结论 C40：trace_action。 迹与矩阵作用的内积表达式相等。

### A.4 完整分组与非退化性

形式化结论 C41：partition_overlap。 任意实际 MUB 分组的不同标签之间内积模平方为零或八分之一。

形式化结论 C42：matAct_pauli_zero。 零标签的矩阵作用保持向量不变。

形式化结论 C43：density_eq_pureDensity。 两种纯态矩阵定义逐项相同。

形式化结论 C44：coeff_inner。 Pauli 系数等于向量与其轨道向量之间的内积。

形式化结论 C45：orbit_implies_flat。 完整三比特 Pauli 轨道分组推出所有非零标签的式 (3)。

形式化结论 C46：normalized_computational_zero。 计算基向量的内积归一。

形式化结论 C47：nonempty_normalized_states。 至少存在一个具体的归一化三比特向量。

形式化结论 C48：coordinate_count。 计算基下标集恰有八个元素。

形式化结论 C49：pauli_label_count。 Pauli 标签集恰有六十四个元素。

### A.5 从系数模式到不可能性

形式化结论 C50：pauli_gaussian_rat。 所有三比特 Pauli 条目都是高斯有理数。

形式化结论 C51：flat_scalar_gaussian。 实复数若模平方为零或八分之一，乘以 $\sqrt8$ 后是高斯有理数。

形式化结论 C52：shifted_reconstruction。 移位后的 Pauli 重构等于式 (5) 的矩阵。

形式化结论 C53：flat_density_gaussian。 归一化且满足式 (3) 的向量将使式 (5) 全部条目高斯有理。

形式化结论 C54：no_three_qubit_flat。 不存在满足完整式 (3) 的归一化三比特纯态，即定理 3。

形式化结论 C55：no_three_qubit_pauli_orbit_mub。 任意归一化三比特向量的完整 Pauli 轨道不能构成 MUB 分组，即定理 1。

### A.6 任意相位代表

形式化结论 C56：innerC_phase_scale。 任意两个标量作用于内积时，分别以共轭和原值提出。

形式化结论 C57：normSq_innerC_phase。 两个单位模标量保持内积模平方。

形式化结论 C58：phase_orbit_implies_flat。 任意逐标签单位模相位的轨道分组仍推出式 (3)。

形式化结论 C59：no_phase_adjusted_pauli_orbit_mub。 任意相位代表的完整轨道也不可能构成 MUB 分组，即定理 2。

