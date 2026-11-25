# 协变量偏移下谱截断核回归的训练条件共形覆盖

## 结果

Pournaderi 与 Xiang 在 TMLR 论文《Training-Conditional Coverage Bounds under Covariate Shift》第 4 节提出，截断的一般 RKHS 回归能否满足其全共形与 jackknife+ 覆盖分析中的稳定性与参数条件。本文给出两种具体肯定方案。固定 Mercer 子空间的谱截断满足原两项条件。对随训练样本选择子空间的经验谱截断，则采用一个连续过渡带。该算法对每个数据集的秩均由截断阈值控制，且对任何单点删改具有统一的 $1/n$ 预测稳定性，无需经验特征值间隔。Hilbert 空间的浓缩进一步给出加权全共形与 jackknife+ 的训练条件覆盖，界不含参数维数。对经典的经验硬 top-$r$ 截断，在相邻特征值都不重复的两维算例中，一次删点仍可造成常数级预测跳变。

## 1. 模型与陈述

令 $\mathcal H$ 为可分实 RKHS，评估向量 $\phi(x)=K(x,\cdot)$ 强可测且 $\|\phi(x)\|\le K_0$，所有响应 $|Y|\le Y_0$。训练数据 $D_n$ 为 $P$ 的 i.i.d. 样本，测试独立服从 $Q$。假设协变量偏移，且已知的密度比 $w(x)=dQ_X/dP_X(x)$ 满足 $0\le w\le B$。因此 $w$ 也是联合密度比，且 $\mathbb E_P w=1$。

定义经验二阶算子及响应向量

$$
A_D=\frac1n\sum_{i=1}^n\phi(X_i)\otimes\phi(X_i),\qquad
b_D=\frac1n\sum_{i=1}^nY_i\phi(X_i).
$$

取固定阈值 $\tau>0$、过渡宽 $h>0$、ridge 参数 $\lambda>0$，设

$$
\chi(s)=\min\{1,\max\{0,(s-\tau)/h\}\},\qquad
g(s)=\frac{\chi(s)}{s+\lambda},\qquad f_D=g(A_D)b_D.
$$

令 $M_g=\sup_{s\ge0}|g(s)|$，$L_g$ 为 $g$ 的 Lipschitz 常数。可用 $M_g\le1/(\tau+\lambda)$、$L_g\le 1/[h(\tau+\lambda)]+1/(\tau+\lambda)^2$。记

$$
C_{\mathcal H}=2Y_0K_0(M_g+K_0^2L_g),\qquad
C_\infty=K_0 C_{\mathcal H},
\qquad
r_n(\varepsilon)=
\frac{C_\infty(1+\sqrt{\log(1/\varepsilon)})}{\sqrt{2n}}.
$$

**定理。** 经验滤波算子 $\operatorname{rank}g(A_D)\le K_0^2/\tau$。大小为 $n$ 的训练集中，删掉一个点或替换一个点使 $f_D$ 的 $\mathcal H$ 范数变化至多 $C_{\mathcal H}/n$。删点结论采用 $n\ge2$，从 $n$ 增至 $n+1$ 的相应界为 $C_{\mathcal H}/(n+1)$。令 $f_{*,n}=\mathbb E_P f_{D_n}$，则

$$
P^n\{\|f_{D_n}-f_{*,n}\|_\infty>r_n(\varepsilon)\}\le\varepsilon.
$$

若目标残差 $R=|Y-f_{*,n}(X)|$ 在 $Q$ 下的 CDF 是 $L$-Lipschitz，标准加权全共形和加权 jackknife+ 分别满足以下几率保证。令

$$
\eta_n(\delta)=8\sqrt{B/n}+2B\sqrt{\frac{\log(1/\delta)}{2n}},
\quad
d_{\mathrm{full}}=r_n(\varepsilon)+C_\infty/(n+1),
\quad
d_{\mathrm{J+}}=r_n(\varepsilon)+C_\infty/n.
$$

对任意一种方法，记 $d$ 为相应量，则

$$
P^n\left\{
Q\left(Y\notin\widehat C_\alpha(X;D_n)\,\middle|\,D_n\right)
>\alpha+\eta_n(\delta)+2Ld
\right\}\le\varepsilon+\delta.
$$

上界只在右侧小于 1 时给出非平凡内容。比如若 $Y$ 给定 $X$ 在目标域有统一的密度上界 $D_0$，便可取 $L=2D_0$，对任意确定性中心函数成立。

## 2. 稳定性及维数无关浓缩

经验算子半正定且迹至多 $K_0^2$。只有大于 $\tau$ 的特征值贡献非零滤波，因此秩界成立。在两个数据集对应有限秩算子的联合值域取有限维正交补充，只需在那里工作。在 $A$ 的正交特征基 $(u_i)$ 和 $A'$ 的正交特征基 $(v_j)$ 之间，滤波差的矩阵元与原算子差分别为

$$
[g(s_i)-g(s'_j)]\langle u_i,v_j\rangle,\qquad
(s_i-s'_j)\langle u_i,v_j\rangle.
$$

平方求和得到

$$
\|g(A)-g(A')\|_{\mathrm{op}}
\le\|g(A)-g(A')\|_{\mathrm{HS}}
\le L_g\|A-A'\|_{\mathrm{HS}}.
$$

相比可交换算子估计，这里允许两个数据集有完全不同的经验特征向量。

记 $A',b'$ 为删点或替换后的算子和向量。由 $A_D$ 与 $b_D$ 是经验平均，

$$
\|A_D-A'\|_{\mathrm{HS}}\le2K_0^2/n,\qquad
\|b_D-b'\|\le2Y_0K_0/n,\qquad
\|b'\|\le Y_0K_0.
$$

删点时例如 $A_D-A'=(\phi(X_i)\otimes\phi(X_i)-A')/n$。加减 $g(A_D)b'$，用上述算子不等式得到 $\|f_D-f'\|\le C_{\mathcal H}/n$。点值由再生性质受 $K_0$ 倍范数控制。强可测性由 $g(A)$ 对有限秩算子的连续性、可分性及测度假设得到，且 $\|f_D\|\le M_gY_0K_0$，故 Bochner 期望存在。

用 Efron–Stein 不等式于可数正交基中的各坐标并求和，得到

$$
\mathbb E\|f_{D_n}-f_{*,n}\|^2
\le\frac12\sum_{i=1}^n \mathbb E\|f_{D_n}-f_{D_n^{(i)}}\|^2
\le C_{\mathcal H}^2/(2n).
$$

每个样本替换使实函数 $\|f_D-f_{*,n}\|$ 改变至多 $C_{\mathcal H}/n$。由 McDiarmid 不等式并用前式界其平均值，得到 $r_n(\varepsilon)$。此步骤直接控制函数空间偏差，替代原文有限维坐标的反向 Lipschitz 和逐坐标并合步骤。

## 3. 加权经验残差的统一控制

写 $F_Q$ 为 $R$ 的目标 CDF，$R_i=|Y_i-f_{*,n}(X_i)|$，$W_i=w(X_i)$。令 $A_n(x)=n^{-1}\sum_i W_i\mathbf1\{R_i\le x\}$，$S_n=\sup_x|A_n(x)-F_Q(x)|$。标准对称化把 $\mathbb E S_n$ 上界变成 $2/n$ 乘条件 Rademacher 最大部分和的期望。具体地，按残差排序全部校准点。给定样本，阈值选择前缀，包括遇并列时可能跳过的前缀子集。由 Doob 二阶最大不等式，期望最大绝对部分和至多 $2(\sum_i W_i^2)^{1/2}$。由 $W_i^2\le BW_i$，得 $\mathbb E S_n\le4\sqrt{B/n}$。替换一个样本使 $S_n$ 变化至多 $B/n$。再用 McDiarmid，几率 $1-\delta$ 下有 $S_n\le\eta_n(\delta)/2$。

若样本总权重正，记 $\widehat F_w=A_n/\overline W$。因为 $|1-\overline W|\le S_n$，且 $\widehat F_w$ 的值均在 $[0,1]$，

$$
\sup_x|\widehat F_w(x)-F_Q(x)|\le2S_n.
$$

对严格或非严格残差尾部可取左右极限，连续的 $F_Q$ 给出相同差界。若样本总权重为零，标准全共形的测试秩权重和 jackknife+ 的两个无穷端点使预测集全覆盖，在 $Q$ 下测试权重为正几乎处处。

## 4. 全共形与 jackknife+ 的两步传递

在同时满足函数浓缩及加权经验集中之训练集中，任意候选测试点 $z=(x,y)$ 若与响应空间相容，增广拟合满足 $\|f_{D\cup z}-f_{*,n}\|_\infty\le d_{\mathrm{full}}$。因此，如果训练点基准残差满足 $R_i\ge R(z)+2d_{\mathrm{full}}$，其增广残差不小于候选残差。校准样本权重规范化后，该基准大残差集的质量，至多是增广加权共形 $p$ 值：加入候选权重且标记候选本身始终只会增大这一比例。按加权 $p$ 值规则排除 $z$ 时，该质量至多 $\alpha$。

jackknife+ 对任意 $i$ 的留一拟合相距 $f_{*,n}$ 至多 $d_{\mathrm{J+}}$。因此 $R_i\ge R(z)+2d_{\mathrm{J+}}$ 蕴含

$$
f_{-i}(x)-|Y_i-f_{-i}(X_i)|\le y\le
f_{-i}(x)+|Y_i-f_{-i}(X_i)|.
$$

若这些夹住候选的训练点的校准归一化权重质量大于 $\alpha$，则上端点分布中小于 $y$ 的权重小于 $1-\alpha$，下端点分布中不超过 $y$ 的权重大于 $\alpha$，加上目标点在 $+\infty$、$-\infty$ 的对应质量只会加强这一判断。于是 $y$ 属于标准加权 jackknife+ 区间。反之被排除时，基准大残差集的归一化质量至多 $\alpha$。

所以两种方法被排除都蕴含 $1-F_Q(R(z)+2d)\le\alpha+\eta_n(\delta)$，从而 $1-F_Q(R(z))\le\alpha+\eta_n(\delta)+2Ld$。由于 $F_Q$ 连续，$F_Q(R(Z))$ 在 $Q$ 下均匀。对测试观测取条件概率，再对两训练事件用并界，得到定理。

## 5. 固定谱基验证原假设

若有有限参考概率测度 $\pi$ 的 Mercer 表示，在固定前 $r$ 个正本征值的子空间拟合普通 ridge。把对应 RKHS 正交基写为 $h_j=\sqrt{\mu_j}e_j$，其中 $e_j$ 在 $L^2(\pi)$ 正交归一，$0<\mu_r\le\mu_j$。固定正交投影使投影后的特征范数仍不超过 $K_0$。用上面的稳定性计算并取 ridge 滤波 $g(s)=1/(s+\lambda)$，在该固定子空间直接得到所需均匀删点稳定性。对任意系数差 $\beta$，设 $f_\beta=\sum_{j=1}^r\beta_j h_j$，则

$$
\sqrt{\mu_r}\|\beta\|_\infty
\le\|f_\beta\|_{L^2(\pi)}
\le\|f_\beta\|_\infty
\le K_0\sqrt r\,\|\beta\|_\infty.
$$

因此固定 Mercer 截断满足原论文 Assumptions 1–2。第 1–4 节进一步覆盖子空间由样本决定的低秩拟合，而无须先选有限固定基底。

## 6. 经验硬截断的全样本反例

在 $\mathbb R^2$ 的线性核上，允许特征 $e_1,e_2,\sqrt2 e_2$，所有观测标签为 1。取 $m$ 个 $e_1$、$m-1$ 个 $e_2$ 和一个 $\sqrt2 e_2$，故 $n=2m$。未归一化协方差为 $\operatorname{diag}(m,m+1)$，硬 top-1 KRR 的预测向量只有第二坐标，在 $e_1$ 的预测为零。去掉最后点后，协方差为 $\operatorname{diag}(m,m-1)$，第一坐标成为唯一首特征向量，新预测在 $e_1$ 为

$$
\frac{m/(2m-1)}{m/(2m-1)+\lambda}\ \longrightarrow\ \frac1{1+2\lambda}>0.
$$

两边算子最大特征值均无并列。于是仅选经验 top-1 而没有统一间隔时，单点删除稳定性可失效。这个反例针对训练算法的全样本稳定性，因而不需要给离散示例强加覆盖定理使用的目标残差密度。

## 参考文献

1. Mehrdad Pournaderi、Yu Xiang. [Training-Conditional Coverage Bounds under Covariate Shift](https://openreview.net/forum?id=F6hHT3qWxT), TMLR, 2026。§3.2、§4、附录 C。
2. Arash Amini、Richard Baumgartner、Dai Feng. [Target alignment in truncated kernel ridge regression](https://papers.nips.cc/paper/2022/file/89b89c04f55ea7c7ca989992bb6a98c0-Paper-Conference.pdf), NeurIPS 2022。§2.2。
3. Olivier Bousquet、André Elisseeff. [Stability and Generalization](https://jmlr.org/papers/v2/bousquet02a.html), JMLR 2002。RKHS 正则化稳定性的经典来源。
