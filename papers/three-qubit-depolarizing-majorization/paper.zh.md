---
title: "三量子比特输出谱的精确主序"
subtitle: "交换对称替换噪声与任意消息数下的最优经典通信"
date: "研究论文 v1 · 2026 年 11 月 24 日"
lang: zh-CN
---

## 摘要

本文证明：在量子比特去极化信道的整个完全正参数区间内，三次使用的输出满足精确的谱主序关系。任意输入所产生的输出，包括纠缠混合输入的输出，其谱都被纯乘积输入的输出谱主序。更一般地，当三个量子比特中随机选定的子集予以保留，其余量子比特被替换为最大混合态，且保留子集的分布仅取决于其基数时，同一结论仍然成立。证明利用共同的特征值排序，将四个相容边缘态层组合起来。其中主要的两体不等式是 Song 和 Chen 已有的结果；本文明确标注其归属，并给出等权情形的自足证明。作为操作层面的推论，我们确定了任意正整数个等概率消息的最大平均译码成功率。编码允许使用任意三量子比特态，译码允许采用任意联合测量，而一个显式的计算基编码即可达到上界。这是有限码长结果，并未解决任意码长或局部维数下的相应猜想。本文给出完整解析证明、精确有理数检查和独立数值审计，尚未经外部同行评议，也未完成端到端的 Lean 形式化验证。

## 1. 问题与贡献

即使三个量子比特的联合输入是纠缠态，噪声也可以独立作用于各个量子比特。纠缠能否使输出的八个特征值，比任意乘积输入所能产生的谱更加集中？仅比较熵不能回答这个问题：熵只约束一个标量函数，而谱主序同时约束所有最大特征值之和。

Song、Wang、Tomamichel 和 Fang 在文献 [1，式 (2)] 中提出了任意局部维数和码长下去极化输出的精确主序关系。该文第 2 版将两次使用的情形列为已知结果，并对一般码长证明了近似关系。本文处理的正是三次使用、局部维数为二的情形，且覆盖整个完全正参数区间。

我们的证明依赖于 Song 和 Chen 的相容两体边缘态不等式 [2，命题 3]。这一不等式**不是本文的新结果**。Ky Fan 变分原理、量子比特自旋翻转、给定系综的谱逆界，以及乘积态使最小输出熵达到最优的既有结论 [3]，同样不属于本文的新贡献。本文所考察的贡献是：精确组合四个交换对称边缘态层，将其用于三次使用的去极化猜想，并在固定消息数下对任意纠缠编码态完成最优化。第 8 节及独立的查新审计详细区分了这些结论与已有工作。

这一结果的用途在于，将原本涉及任意量子编码与测量的优化问题化为显式公式。对于本文规定的三量子比特通信问题，无须再搜索纠缠输入态或联合测量。

## 2. 定义与主要结论

### 2.1 谱主序

量子态是迹为一的半正定矩阵。对于厄米矩阵 $X$，记

$$
K_k(X)=\sum_{i=1}^k\lambda_i^\downarrow(X),\qquad K_0(X)=0,
$$

其中特征值按非增序排列。记号 $X\prec Y$ 表示两矩阵的迹相同，且对所有小于矩阵维数的正整数指标都有 $K_k(X)\leq K_k(Y)$。这一记号表示特征值之间的主序关系，并不表示半正定序下的矩阵不等式。

下文所有系统的希尔伯特空间均为 $(\mathbb C^2)^{\otimes3}$，三个站点记作 $A,B,C$。对于子集 $I$，记 $\rho_I=\operatorname{Tr}_{I^c}\rho$。所有张量因子始终嵌入原来的站点顺序。特别地，$\rho_{AC}\otimes I_B$ 表示按 $A,B,C$ 顺序嵌入的算子。

### 2.2 交换对称替换噪声

对于 $j=0,1,2,3$，定义信道

$$
\mathcal E_j(\rho)=\frac1{\binom3j}
\sum_{|I|=j}\rho_I\otimes(I_2/2)^{\otimes I^c}.
\tag{1}
$$

当 $j=0$ 时，输出为 $I_8/8$；将其线性延拓到任意矩阵，得到 $X\mapsto\operatorname{Tr}(X)I_8/8$。给定满足 $\sum_jw_j=1$ 的 $w_j\geq0$，令

$$
\mathcal E_w=\sum_{j=0}^3w_j\mathcal E_j.
\tag{2}
$$

其物理过程是：先选择保留多少个量子比特，再从该大小的所有子集中均匀选择一个，将其他量子比特替换为最大混合态。接收方不会获知具体保留了哪个子集。各次替换事件之间可以相关，但子集分布必须在三个站点的任意置换下保持不变。

令 $P=|000\rangle\langle000|$、$T_w=\mathcal E_w(P)$，并定义

$$
\begin{aligned}
q_0&=w_0/8+w_1/4+w_2/2+w_3,\\
q_1&=w_0/8+w_1/6+w_2/6,\\
q_2&=w_0/8+w_1/12,\\
q_3&=w_0/8.
\end{aligned}
\tag{3}
$$

这些数满足 $q_0\geq q_1\geq q_2\geq q_3\geq0$ 以及 $q_0+3q_1+3q_2+q_3=1$。

**定理 1（三量子比特输出的精确主序）。** 对任意符合上述条件的 $w$ 和任意三量子比特态 $\rho$，均有

$$
\mathcal E_w(\rho)\prec T_w,
\qquad
\lambda^\downarrow(T_w)=(q_0,q_1,q_1,q_1,q_2,q_2,q_2,q_3).
\tag{4}
$$

特别地，对于

$$
\mathcal D_\lambda(X)=\lambda X+(1-\lambda)\operatorname{Tr}(X)I_2/2,
\qquad -1/3\leq\lambda\leq1,
\tag{5}
$$

每个输出 $\mathcal D_\lambda^{\otimes3}(\rho)$ 都被 $\mathcal D_\lambda^{\otimes3}(P)$ 谱主序。若记

$$
\alpha=(1+|\lambda|)/2,\qquad \beta=(1-|\lambda|)/2,
\tag{6}
$$

则参考输出的谱为

$$
(\alpha^3,\alpha^2\beta,\alpha^2\beta,\alpha^2\beta,
\alpha\beta^2,\alpha\beta^2,\alpha\beta^2,\beta^3).
\tag{7}
$$

### 2.3 通信模型

设有 $M\geq1$ 个等概率的经典消息。消息 $m$ 可以编码为任意三量子比特密度矩阵 $\rho_m$，包括纠缠态或混合态。接收方可在八维输出空间上采用任意联合正算子值测度（POVM）$(F_m)_{m=1}^M$，其中 $F_m\geq0$ 且 $\sum_mF_m=I_8$。正确判决的平均概率为

$$
P_{\rm succ}=\frac1M\sum_{m=1}^M\operatorname{Tr}[F_m\mathcal E_w(\rho_m)].
\tag{8}
$$

这里考察一个固定编码块：发送方与接收方不预先共享纠缠，接收端不保留无噪声参考系统，不使用反馈，也不在各次信道使用之间进行自适应干预。与通常的平均错误率编码模型一致，我们允许不同消息使用相同的编码态，也允许某些 POVM 元素为零。优化指标是平均成功率，而非最差消息的成功率。

**定理 2（任意消息数下的精确成功概率）。** 在上述模型中，

$$
P^*_{\rm succ}(M;w)=
\begin{cases}
1,&M=1,\\
q_0+(8/M-1)q_1,&2\leq M\leq8,\\
8q_0/M,&M>8.
\end{cases}
\tag{9}
$$

对于独立去极化信道，在整个 $-1/3\leq\lambda\leq1$ 区间内，该式成为

$$
P^*_{\rm succ}(M;\lambda)=
\begin{cases}
1,&M=1,\\
\alpha^3+(8/M-1)\alpha^2\beta,&2\leq M\leq8,\\
8\alpha^3/M,&M>8.
\end{cases}
\tag{10}
$$

因此，在这个精确定义的问题中，任意纠缠编码与联合译码都无法超越一个显式的计算基编码。该结论不涉及量子通信容量、其他码长、纠缠辅助通信或其他噪声模型。

## 3. 矩阵事实与相容边缘态

对于整数 $k$，变分原理

$$
K_k(X)=\max_{R=R^2=R^\dagger,\ \operatorname{Tr}R=k}\operatorname{Tr}(RX)
\tag{11}
$$

蕴含 $K_k$ 的酉不变性、凸性和次可加性。这个公式可直接通过对角化 $X$ 看出：$R$ 的对角元属于 $[0,1]^8$ 且总和为 $k$，因此特征值加权和的最大值由最大的 $k$ 个特征值给出。投影到相应特征子空间的谱投影恰好达到该值。

我们还使用特征值单调性：若 $X\geq D$，则对每个 $i$ 都有 $\lambda_i^\downarrow(X)\geq\lambda_i^\downarrow(D)$。这由特征值的极小极大刻画推出，因为增加一个半正定矩阵不会减小任何 Rayleigh 商。

对于纯态输入，设各单量子比特边缘态的特征值为 $(1-r_i,r_i)$，其中 $0\leq r_i\leq1/2$。这些数满足

$$
r_A\leq r_B+r_C,\quad r_B\leq r_A+r_C,\quad r_C\leq r_A+r_B.
\tag{12}
$$

下面简要证明所需的三站点多边形不等式。选择两个边缘态最大特征值对应的特征向量 $b_0,c_0$。相互交换的投影满足的不等式

$$
I-P_B\otimes P_C\leq(I-P_B)\otimes I+I\otimes(I-P_C)
$$

给出 $\langle b_0c_0|\rho_{BC}|b_0c_0\rangle\geq1-r_B-r_C$。二分纯态两个约化态的非零谱相同，因为它们来自同一系数矩阵的两个 Gram 矩阵。因此 $\lambda_{\max}(\rho_{BC})=1-r_A$，从而得到第一个不等式；置换站点即可得到其余两个。一般的多边形不等式结果由 Higuchi、Sudbery 和 Szulc 给出 [7]。

## 4. 已知两体层不等式的显式证明

定义未归一化的边缘态之和

$$
S_1=\rho_A\otimes I_{BC}+I_A\otimes\rho_B\otimes I_C+I_{AB}\otimes\rho_C,
$$

$$
S_2=\rho_{AB}\otimes I_C+\rho_{AC}\otimes I_B+I_A\otimes\rho_{BC}.
\tag{13}
$$

我们需要证明

$$
S_2\prec\operatorname{diag}(3,1,1,1,0,0,0,0).
\tag{14}
$$

式 (14) 是文献 [2，命题 3] 的等权情形，此处采用迹为六的归一化约定。我们给出完整论证，以明确所有假设，并直接核验所引用的不等式。

先考虑纯态 $\rho$。令

$$
Y=\begin{pmatrix}0&-i\\ i&0\end{pmatrix},\qquad
\widetilde\rho=Y^{\otimes3}\rho^{\mathsf T}Y^{\otimes3}.
$$

直接相乘可知，对每个 $2\times2$ 矩阵 $X$，都有 $YX^{\mathsf T}Y=\operatorname{Tr}(X)I_2-X$。对张量积展开，得到

$$
\widetilde\rho=I_8-S_1+S_2-\rho.
$$

这里的转置是**全转置**，它保持半正定性和迹；证明没有假设部分转置保持半正定性。令 $D=S_1-I_8$，可得

$$
S_2=D+\rho+\widetilde\rho\geq D,
\qquad \operatorname{Tr}D=4,\quad \operatorname{Tr}S_2=6.
\tag{15}
$$

用局部酉变换将三个单量子比特边缘态对角化，并令 $s=r_A+r_B+r_C$。矩阵 $D$ 的八个对角元为

$$
2-s;\qquad1-s+2r_i\ (i=A,B,C);\qquad
s-2r_i\ (i=A,B,C);\qquad s-1.
\tag{16}
$$

第一项最大，最后一项最小。例如，其余各项与最后一项的差分别为 $3-2s$、$2(1-s+r_i)$ 和 $1-2r_i$；由 $r_i\leq1/2$ 可知这些差均非负。同样，与第一项的比较可由 $r_i+r_j\leq1$ 和 $r_i\leq1/2$ 得到。

令 $\delta=(1-s)_+$。除第一项外，每一项均不超过一。对于 $1-s+2r_i$，这恰好就是多边形不等式 $r_i\leq r_j+r_k$；对于 $s-2r_i$，该结论由 $r_j+r_k\leq1$ 推出；此外还有 $s-1\leq1/2$。第一项满足 $2-s\leq1+\delta$。因此，不必对中间六项进行完整排序，便有

$$
K_k(D)\leq k+\delta\quad(k=1,2,3),
\qquad \lambda_8(D)=s-1.
\tag{17}
$$

式 (15) 的特征值单调性给出 $\lambda_i(S_2)\geq\lambda_i(D)$。由于 $S_2\geq0$，其最后一个特征值还满足更强的下界

$$
\lambda_8(S_2)\geq\max\{s-1,0\}=\lambda_8(D)+\delta.
$$

将由此得到的谱尾和下界从总迹六中减去，可得

$$
\begin{aligned}
K_k(S_2)
&\leq6-\bigl[4-K_k(D)+\delta\bigr]\\
&\leq k+2,\qquad k=1,2,3.
\end{aligned}
\tag{18}
$$

当 $k\geq4$ 时，半正定性给出 $K_k(S_2)\leq6$。这些恰好是式 (14) 所要求的各个部分和界。对于混合态输入，将 $\rho$ 分解为纯态的凸组合，再使用 $S_2$ 的线性和每个 $K_k$ 的凸性即可。两边除以六，便得到 $\mathcal E_2(\rho)\prec\mathcal E_2(P)$。

相容性是这一证明的关键。独立选取的两体态未必来自同一个 $\rho$；文献 [2] 给出了这种情况下的反例。随稿提供的可执行审计将该反例用作负对照，并能正确检出主序关系失效。

## 5. 谱定理的完整证明

### 5.1 其余各层

$j=0$ 层与输入无关。对于 $j=3$，任意量子态都被秩一态 $P$ 谱主序。

对于 $j=1$，将各边缘态对角化为 $\operatorname{diag}(1-r_i,r_i)$。从对齐算子

$$
A_1=P_A\otimes I_{BC}+I_A\otimes P_B\otimes I_C+I_{AB}\otimes P_C.
$$

出发，以概率 $r_i$ 独立翻转站点 $i$。对这些作用于 $A_1$ 的酉共轭取平均，在所选局部基下恰好得到 $S_1$：翻转混合将 $P_i$ 映为所需边缘态，同时保持各恒等算子不变。由 $K_k$ 的凸性与酉不变性，得到 $S_1\prec A_1$。两边除以十二，即得 $j=1$ 层的不等式。仅将三个单独的秩四估计相加不足以得到所需结论；上述共同的随机酉构造给出了更强的谱界。

### 5.2 所有对齐层共享的排序

各个对齐输出都是对角矩阵。对于 Hamming 重量为 $h$ 的基字符串，相应对角元如下表所示。

| $h$ | 重数 | $\mathcal E_0(P)$ | $\mathcal E_1(P)$ | $\mathcal E_2(P)$ | $\mathcal E_3(P)$ |
|---|---:|---:|---:|---:|---:|
| 0 | 1 | $1/8$ | $1/4$ | $1/2$ | 1 |
| 1 | 3 | $1/8$ | $1/6$ | $1/6$ | 0 |
| 2 | 3 | $1/8$ | $1/12$ | 0 | 0 |
| 3 | 1 | $1/8$ | 0 | 0 | 0 |

每一列在同一个行顺序下均为非增序。因此，

$$
\begin{aligned}
K_k(\mathcal E_w(\rho))
&\leq\sum_jw_jK_k(\mathcal E_j(\rho))\\
&\leq\sum_jw_jK_k(\mathcal E_j(P))\\
&=K_k\!\left(\sum_jw_j\mathcal E_j(P)\right).
\end{aligned}
\tag{19}
$$

最后一个等号利用的是共同排序，仅有交换性还不够。任意对角矩阵之和未必具有这一性质。所有输出的迹均为一，因此交换对称替换噪声的定理 1 得证。将表中各列加权，即得式 (3)。

### 5.3 完整的去极化参数区间

当 $0\leq\lambda\leq1$ 时，式 (5) 的三重张量积可写成式 (2)，其中

$$
w_j=\binom3j\lambda^j(1-\lambda)^{3-j}.
\tag{20}
$$

于是可应用定理 1。为覆盖负的 $\lambda$，令 $u=-\lambda\geq0$，并定义 $R(X)=\operatorname{Tr}(X)I_2-X$。代数运算给出 $R\mathcal D_u=\mathcal D_{-u}$，以及

$$
R^{\otimes3}(X)=Y^{\otimes3}X^{\mathsf T}Y^{\otimes3}.
\tag{21}
$$

因此，$\mathcal D_{-u}^{\otimes3}(\rho)$ 与 $\mathcal D_u^{\otimes3}(\rho)$ 具有相同的谱，其乘积参考输出的谱也分别相同。已证的正参数不等式由此适用于 $-1/3\leq\lambda<0$。

映射 $R$ 并非物理上允许的量子比特信道；这里仅通过式 (21) 中保持谱不变的全转置恒等式使用它。式 (5) 在所述区间上的完全正性可由其 Pauli 表示直接看出：恒等共轭的概率为 $(1+3\lambda)/4$，其余三个 Pauli 共轭各自的概率为 $(1-\lambda)/4$。这些概率恰好在 $[-1/3,1]$ 上均非负。

## 6. 任意消息数下的精确编码

### 6.1 谱逆界

在相邻整数之间作线性插值，将 $K_k(T_w)$ 延拓为定义在实数 $0\leq t\leq8$ 上的 $K_t(T_w)$。其各段斜率就是按序排列的特征值，因而该函数是凹函数。对于任意测量效应 $0\leq F\leq I$，有

$$
\operatorname{Tr}(F\sigma)\leq K_{\operatorname{Tr}F}(\sigma).
\tag{22}
$$

事实上，在 $\sigma$ 的特征基下，$F$ 的对角元均介于零和一之间，且总和给定。依次优先给最大的特征值分配权重，即可解出这个初等线性优化问题。

由定理 1，式 (22) 的右端不超过 $K_{\operatorname{Tr}F}(T_w)$。POVM 各元素的迹之和为八，因此凹性给出

$$
P_{\rm succ}\leq\frac1M\sum_mK_{\operatorname{Tr}F_m}(T_w)
\leq K_{8/M}(T_w).
\tag{23}
$$

这种形式的谱逆界是标准方法，文献 [1,5] 中已有密切相关的结果；这里新增的依据，是一个对所有三量子比特编码态统一成立、缺陷为零的谱比较。当 $2\leq M\leq8$ 时，自变量 $8/M$ 属于 $[1,4]$，而参考 Lorenz 曲线在这一段恰好是直线 $q_0+(t-1)q_1$。当 $M>8$ 时，自变量属于 $[0,1]$，曲线为 $tq_0$。这就证明了式 (9) 的上界。

### 6.2 达到上界的计算基编码

对于计算基输入 $|c\rangle$，输出为对角态，读出 $y$ 的概率为 $q_{d_H(c,y)}$，其中 $d_H$ 为 Hamming 距离。这可由式 (1) 直接推出，也可由局部比特翻转协变性得到。

当 $2\leq M\leq8$ 时，任取包含 $000$ 和 $111$ 的 $M$ 个互异三比特字符串。每个长度为三的字符串与这两个字符串中的至少一个相距至多一。接收方在计算基下测量，并选择距离最近的码字。由于 $q_0\geq q_1\geq q_2\geq q_3$，这一选择使条件似然最大。

对于码本中选定的 $M$ 个读出结果，最大条件概率均为 $q_0$。对于其余 $8-M$ 个读出结果，它们与码本的距离恰好为一，各自贡献 $q_1$。因此，平均成功率为

$$
\frac1M\sum_{y\in\{0,1\}^3}\max_{c\in\mathcal C}q_{d_H(c,y)}
=\frac{Mq_0+(8-M)q_1}{M},
\tag{24}
$$

恰好达到式 (23) 的上界。遇到并列最优时可以任意选取，包括由谱简并造成的并列情形。

当 $M>8$ 时，用全部八个计算基态编码八个指定消息。对其余每个消息指定任意合法输入态，并令对应的 POVM 元素为零。八个指定测量结果给出的平均成功率为 $8q_0/M$。当 $M=1$ 时，始终返回唯一的消息即可使成功率达到一。定理 2 得证。

对于负去极化参数，在译码前将所有测得的比特标签逐位翻转。所得经典条件概率由式 (6) 中的 $\alpha,\beta$ 给出。因此式 (10) 在整个物理参数区间内成立。

## 7. 示例与解释

当 $\lambda=1/2$ 时，乘积参考输出的谱精确为

$$
\frac1{64}(27,9,9,9,3,3,3,1).
$$

其七个非平凡前缀和为 $(27,36,45,54,57,60,63)/64$。每个三量子比特输出都同时满足这七个上界。

| 消息数 | 精确最优成功率 | 小数值 |
|---:|---:|---:|
| 2 | $27/32$ | 0.84375 |
| 3 | $21/32$ | 0.65625 |
| 4 | $9/16$ | 0.56250 |
| 5 | $81/160$ | 0.50625 |
| 6 | $15/32$ | 0.46875 |
| 7 | $99/224$ | 0.44196 |
| 8 | $27/64$ | 0.421875 |

当 $M=2$ 时，最优计算基码是重复码 $000,111$。对于中间的消息数，保留这两个端点，再加入任意互异字符串即可。该编码不需要优化连续的量子参数。

这一结果还确定了每个随谱集中程度增加而不减的凸酉不变函数的最大输出值：乘积参考输入均能达到该值。凹的谱熵函数则在同一参考输出处达到相应的最小值。这些都是主序关系的推论，并非对新的熵可加性结果所作的独立声明。

当 $\lambda=0$ 时，所有输出相同，式 (10) 化为 $1/M$。当 $\lambda=1$ 时，该式化为维数限制 $\min\{1,8/M\}$。这两个端点以及负的物理端点 $\lambda=-1/3$ 均直接包含在结论中，无须借助极限论证。

## 8. 已有工作、验证与适用边界

Fujiwara 和 Hashizumé [4] 建立了两通道的主序结果。King [3] 证明了去极化信道的最大输出范数乘法性，以及熵与容量的可加性。这些结果并未给出式 (4) 中三次使用所需的最大特征值之和。Alhejji 和 Knill [8，第 III 节] 已经建立了自旋对齐与去极化信道的联系；他们相关的已证界针对整数阶 Schatten 范数目标，以及子集分布的支撑至多含两项的情形，并未涵盖这里完整的相容边缘态之和。Song 和 Chen [2] 提供了本文使用的两体层。Song 等人 [1] 提出一般的精确猜想，并得到近似界。本文只解决前述特定的三量子比特情形及交换对称替换噪声族。

Havas、Lin 和 Rosnes [5] 利用给定系综的谱提出逆界，并研究乘积输出编码。他们作用于整个输出空间的整体去极化映射，不同于三个局部去极化映射的张量积。在本文考察的有限问题中，我们的统一主序定理去除了对乘积编码态的限制。对于独立去极化，$M\geq8$ 这一分支已经可以从 King 的最大输出算子范数界推出，也被通信值乘法性所覆盖 [6，定理 4]。我们不将这一分支视为独立的新发现。固定消息数 $M=2,\ldots,7$ 则需要上文使用的更精细谱信息。

Delsol、Fawzi、Kochanowski 和 Ramachandran [9，第 5.1 节，图 2] 报告了二元消息通过至多三份量子比特去极化信道时的半定规划界，并在数值上观察到这些界可以达到。他们达到该界的二元码，就是本文使用的重复码。因此，本文的 $M=2$ 分支是对已有数值观察的解析确认，并非首次观察到该码的最优性。拟议贡献的范围是全谱定理及覆盖所有固定 $M$ 的完整公式。我们不声称每个单独的二元通信推论，在所有等价表述下都此前未知。

配套的精确检查程序使用有理数算术。它在两个相关边缘态多面体的全部顶点上检查式 (17) 背后的标量不等式，在全部 64 个矩阵单位上验证自旋翻转与信道恒等式，并在若干有理噪声参数下枚举所有非空计算基码本。关于信道参数的三次多项式恒等式在四个互异有理点上接受检查，因而精确确定每个系数。这验证的是这些有限代数组件，并不等同于验证整个普遍矩阵定理。

另一套独立编写的审计程序分别通过 Pauli Kraus 共轭、按 Pauli 重量缩放，以及基于索引的偏迹来实现信道。它在十一个去极化参数下检查了 408 个指定测试态及按固定随机种子生成的纯态、混合态，共计 4,488 个信道案例；另检查了 2,496 个交换对称信道案例、120 个联合 POVM 案例和 420 个达到上界的编码案例。文献 [2] 中不相容两体态的反例被正确识别为不满足主序关系。去极化情形中，谱前缀和超过参考界的最大正数值低于 $8.9\times10^{-16}$，低于诊断容差 $2\times10^{-12}$。完整计数、容差和源文件哈希列于结果文件中。数值检查用于诊断；针对连续参数与任意量子态的结论由上面的解析论证建立。

本文不对四次或更多次信道使用、更高局部维数、任意非交换对称子集权重、向接收方揭示替换标记的模型、纠缠辅助、自适应使用、最差消息指标或不受限量子容量作出结论。本草稿在 AI 辅助下完成。配套材料中的独立复核，指同一研究会话内不同智能体的复核，以及独立编写的验证代码；它不表示已经完成端到端 Lean 证明或外部同行评议。创新性表述仅以 `NOVELTY_AUDIT.md` 和 `SOURCES.json` 所列主要来源及检索记录为范围。

## 参考文献

1. Z. Song, X. Wang, M. Tomamichel and K. Fang. *Approximate majorization and high-order capacity of quantum depolarizing channels*. arXiv:2609.37240v2 (2026). [指定版本](https://arxiv.org/abs/2609.37240v2)。
2. Z. Song and L. Chen. *A counterexample to the strong spin alignment conjecture*. arXiv:2603.25410v1 (2026), Proposition 3. [指定版本](https://arxiv.org/abs/2603.25410v1)。
3. C. King. *The capacity of the quantum depolarizing channel*. IEEE Transactions on Information Theory **49**, 221–229 (2003). DOI: [10.1109/TIT.2002.806153](https://doi.org/10.1109/TIT.2002.806153)；[作者预印本](https://arxiv.org/abs/quant-ph/0204172v2)。
4. A. Fujiwara and T. Hashizumé. *Additivity of the capacity of depolarizing channels*. Physics Letters A **299**, 469–475 (2002). DOI: [10.1016/S0375-9601(02)00735-1](https://doi.org/10.1016/S0375-9601(02)00735-1)。
5. T. Havas, H.-Y. Lin and E. Rosnes. *A Spectrum-Based Converse for Quantum State Discrimination and Its Applications to Classical-Quantum Channel Coding*. arXiv:2610.06840 (2026). [来源](https://arxiv.org/abs/2610.06840)。
6. E. Chitambar, I. George, B. Doolittle and M. Junge. *The Communication Value of a Quantum Channel*. IEEE Transactions on Information Theory **69**, 1660–1679 (2023). DOI: [10.1109/TIT.2022.3218540](https://doi.org/10.1109/TIT.2022.3218540)；[预印本](https://arxiv.org/abs/2109.11144)。
7. A. Higuchi, A. Sudbery and J. Szulc. *One-qubit reduced states of a pure many-qubit state: polygon inequalities*. Physical Review Letters **90**, 107902 (2003). DOI: [10.1103/PhysRevLett.90.107902](https://doi.org/10.1103/PhysRevLett.90.107902)；[作者预印本](https://arxiv.org/abs/quant-ph/0209085v2)。
8. M. A. Alhejji and E. Knill. *Towards a resolution of the spin alignment problem*. Communications in Mathematical Physics **405**, 119 (2024). DOI: [10.1007/s00220-024-04980-1](https://doi.org/10.1007/s00220-024-04980-1)；[已核验预印本](https://arxiv.org/abs/2307.06894v3)。
9. I. Delsol, O. Fawzi, J. Kochanowski and A. Ramachandran. *Computational Aspects of the Trace Norm Contraction Coefficient*. arXiv:2507.16737v3 (2026), Section 5.1. [指定版本](https://arxiv.org/abs/2507.16737v3)。
