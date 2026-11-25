# 排序 Schmidt 参考态最优性的半阶精确反例

*具有非退化 Schmidt 谱的八量子比特构造*

AI 辅助研究稿

2026 年 11 月 24 日

## 摘要

将双体纯态的 Schmidt 系数按大小排列，再放到两侧对应的计算基上，是否总能得到局部酉轨道上稳定子 Rényi 熵的最小值？本文对这一“全阶数最优”表述给出 $\alpha=1/2$ 时的精确反例。构造只需要两侧各四个量子比特，全部十六个 Schmidt 系数严格为正且互不相同。在两侧同时交换计算基标签 11 与 12，熵就严格下降，差值恰为 $2\log_2(13980/13979)>0$。证明归约为整数 Walsh 相关和，并由独立枚举全部 65,536 个 Pauli 字符串的程序复算。连续性进一步说明，反例存在于正严格排序幅度空间的一个开邻域内。结论针对半阶及原猜想的全阶数表述；本文没有解决二阶最优性猜想，也没有对 $\alpha\geq2$ 的资源单调性区间作出否定结论。

## 1. 原问题与研究范围

设 $|\psi\rangle$ 为归一化的 $n$ 量子比特纯态，总维数为 $D=2^n$，$\mathcal P_n$ 为 $I,X,Y,Z$ 的全部 $4^n$ 个张量积。稳定子 Rényi 熵定义为

$$
M_\alpha(\psi)=\frac{1}{1-\alpha}\log_2\left(\frac1D
\sum_{P\in\mathcal P_n}|\langle\psi|P|\psi\rangle|^{2\alpha}\right),
\qquad \alpha>0,\quad\alpha\ne1.
\tag{1}
$$

在 $\alpha=1/2$ 时，记

$$
M_{1/2}(\psi)=2\log_2 Z(\psi),\qquad
Z(\psi)=\frac1D\sum_{P\in\mathcal P_n}|\langle\psi|P|\psi\rangle|.
\tag{2}
$$

所谓非局域优化，是对两侧的任意局部酉 $U_A\otimes U_B$ 最小化上述熵，所得最小值记为 $M_\alpha^{\mathrm{NL}}$。这里的 Schmidt 概率是 Schmidt 系数的平方。Liu 与 Cui 在文献 [1] 式 (6) 提出一种简化：把 Schmidt 概率的平方根降序排列，放在两侧相同的计算基标签上，就能达到最小值。其后续论文 [2] 附录 A 的式 (A3)-(A4) 明确重述全阶数最优性，式 (A10) 还明确要求半整数阶保留绝对值。本文固定检验其中的半阶命题。

需要区分几条邻近结论。Sierant [3] 以及 Franchini、Giampaolo [4] 的相关最优性结果研究二阶量；文献 [2] 的局部极小性限定在整数 $\alpha\geq2$；文献 [5] 的闭式最优解研究 log-stabilizer fidelity，是另一目标函数。文献 [6] 证明的纯态资源单调性范围也是 $\alpha\geq2$。本反例不改变这些结论，也不把半阶量称为已经具备资源单调性的量。

## 2. 主定理与具体构造

取局部维数 $d=16$，两侧空间均为 $\mathbb C^{16}$，总维数 $D=d^2=256$。标签 $0,\ldots,15$ 采用四位二进制表示。定义

$$
a=(18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,1),
\qquad Q=\sum_{x=0}^{15}a_x^2=2096,
\tag{3}
$$

$$
|\psi_a\rangle=\frac1{\sqrt Q}\sum_{x=0}^{15}a_x|x\rangle_A|x\rangle_B.
\tag{4}
$$

令 $\pi$ 只交换标签 11 与 12，定义置换酉 $U_\pi|x\rangle=|\pi(x)\rangle$ 及 $b_x=a_{\pi(x)}$。由于 $\pi^2$ 是恒等置换，

$$
(U_\pi\otimes U_\pi)|\psi_a\rangle=|\psi_b\rangle.
\tag{5}
$$

**定理 1：半阶最优性的严格失败。** 式 (4) 是归一化纯态，其 Schmidt 概率 $\lambda_x=a_x^2/2096$ 严格为正、严格降序，因此它就是该谱的排序参考态。式 (5) 是保持该谱的合法局部酉操作，并且

$$
Z(\psi_a)=\frac{13980}{8384},\qquad
Z(\psi_b)=\frac{13979}{8384}.
\tag{6}
$$

因此，

$$
M_{1/2}(\psi_a)-M_{1/2}(\psi_b)
=2\log_2\frac{13980}{13979}>0.
\tag{7}
$$

这给出 $M_{1/2}^{\mathrm{NL}}(\psi_a)\leq M_{1/2}(\psi_b)<M_{1/2}(\psi_a)$，从而否定排序参考态总能达到全局最小值的半阶命题。本文不声称已经求出该局部酉轨道上的真正最小值。

## 3. 从真实 Pauli 期望到整数证书

下面明确推导归一化因子和绝对值。Pauli-Walsh 表示本身已有文献基础 [2，附录 A；4]；本文的新贡献是利用它得到严格反例，而不是首次提出这种变换。

对任意实向量 $c\in\mathbb R^{16}$，若 $Q(c)=\sum_x c_x^2>0$，用 $c,Q(c)$ 替换式 (4) 中的 $a,Q$ 定义归一化态 $\psi_c$。设

$$
H_c(s,k)=\sum_{x=0}^{15}c_xc_{x\oplus s}(-1)^{k\cdot x},
\qquad F(c)=\sum_{s,k=0}^{15}|H_c(s,k)|,
\tag{8}
$$

其中 $\oplus$ 是按位异或，符号中的内积在 $\mathbb F_2$ 上计算。

**引理 2：Pauli-Walsh 归约。** 对以上每个 $c$，

$$
\sum_{P\in\mathcal P_8}|\langle\psi_c|P|\psi_c\rangle|
=\frac{16}{Q(c)}F(c),\qquad
Z(\psi_c)=\frac{F(c)}{16Q(c)}.
\tag{9}
$$

**证明。** 将一侧的厄米 Pauli 写成 $P_{s,t}=i^{\nu(s,t)}X^sZ^t$，其中 $\nu(s,t)$ 是同时为 1 的位数，整体相位模长为 1。计算 $P_{s,t}\otimes P_{r,u}$ 的期望时，由于态仅支撑在 $|x,x\rangle$ 上，只有两侧移位一致，即 $s=r$，才可能得到非零项。此时期望的模长等于

$$
\frac1{Q(c)}\left|\sum_x c_xc_{x\oplus s}
(-1)^{(t\oplus u)\cdot x}\right|
=\frac{|H_c(s,t\oplus u)|}{Q(c)}.
\tag{10}
$$

对每个固定的 $(s,k)$，满足 $t\oplus u=k$ 的有序对 $(t,u)$ 恰好有十六组。因此全部 Pauli 绝对期望之和为式 (9) 的第一项。再除以总维数 256，得到第二项。这里必须区分局部维数 16 与总维数 256；消去重复度后，分母为 $16Q(c)$。去掉单位模长相位不会改变绝对值，但不能把绝对值本身去掉。证毕。

**引理 3：精确整数计算。** 主定理中的两向量满足

$$
Q(a)=Q(b)=2096,\qquad F(a)=55920,\qquad F(b)=55916.
\tag{11}
$$

**证明。** 范数直接由式 (3) 计算，置换保持范数。式 (8) 的每一项均为整数。下面列出每个位移对应的十六项绝对值之和；完整的两张 $16\times16$ 整数表及逐项重算程序随文提供。

| $s$ | $\sum_k\lvert H_a(s,k)\rvert$ | $\sum_k\lvert H_b(s,k)\rvert$ |
|---:|---:|---:|
| 0 | 5200 | 5220 |
| 1 | 4896 | 4896 |
| 2 | 4608 | 4608 |
| 3 | 4448 | 4440 |
| 4 | 4056 | 4032 |
| 5 | 3936 | 3904 |
| 6 | 3728 | 3688 |
| 7 | 3632 | 3632 |
| 8 | 2960 | 2988 |
| 9 | 2912 | 2932 |
| 10 | 2808 | 2800 |
| 11 | 2768 | 2744 |
| 12 | 2568 | 2596 |
| 13 | 2528 | 2548 |
| 14 | 2456 | 2468 |
| 15 | 2416 | 2420 |
| **合计** | **55920** | **55916** |

式 (11) 也可以作为有限整数命题由 Lean 内核直接归约验证，整个计算不需要浮点误差容限。证毕。

**主定理的完成。** 计算基正交归一，因此式 (3) 保证式 (4) 归一化。约化密度矩阵为对角阵，其对角元就是 $a_x^2/Q$，全部正且严格降序。置换矩阵 $U_\pi$ 是酉矩阵，同时作用在两侧得到式 (5)，保持 Schmidt 概率的多重集合。把式 (11) 代入式 (9)，有

$$
\frac{55920}{16\cdot2096}=\frac{13980}{8384},\qquad
\frac{55916}{16\cdot2096}=\frac{13979}{8384}.
$$

两个有理数严格为正。利用商的对数恒等式和对数的严格单调性，即得式 (7)。由于式 (5) 属于允许的局部酉轨道，找到这一个更低值就足以排除原态的全局最优性。证毕。

## 4. 反例不是孤立的退化点

原文使用“generic”这一表述，因此仅给出退化谱中的孤立例子可能不足以澄清其适用边界。本例除了全秩且谱值互异，还具有严格不等式的局部稳定性。

**定理 4：反例的开邻域。** 存在包含 $a$ 的开集 $\mathcal U\subset\mathbb R^{16}$，使每个 $c\in\mathcal U$ 都严格为正、严格降序，且

$$
M_{1/2}\bigl((U_\pi\otimes U_\pi)\psi_c\bigr)
<M_{1/2}(\psi_c).
\tag{12}
$$

**证明。** 每个 $H_c(s,k)$ 都是关于幅度的二次多项式。有限求和与绝对值保持连续性，故 $F$ 连续；固定置换后的函数也连续。于是

$$
\mathcal U=\{c:\ c_0>c_1>\cdots>c_{15}>0,\quad
F(c\circ\pi)<F(c)\}
\tag{13}
$$

是有限个严格连续不等式确定的开集。由式 (3) 与式 (11)，$a\in\mathcal U$。正性保证 $Q(c)>0$，置换则保证 $Q(c\circ\pi)=Q(c)$。再使用式 (9) 及对数严格单调性，即得式 (12)。证毕。

这一结论在幅度坐标中表述，每个向量都以自身范数归一化。它没有声称几乎所有谱都会使排序方案失效。

## 5. 核验与学术意义

复现包提供两条分开的精确计算路径。`code/exact_certificate.py` 用任意精度整数重新生成 Walsh 表；`code/verify_full_pauli.py` 则从 $I,X,Y,Z$ 对计算基的实际作用出发，直接枚举全部 65,536 个字符串，使用 $i$ 的整数指数记录相位，不使用浮点复数。后者得到的绝对期望分子总和分别为 894720 和 894656，恰与引理 3 的结果相差一个已证明的十六倍重复度。证明不依赖熵的小数近似值。

原研究稿描述了有限证书及数学连接的 Lean 形式化范围，包括复数态、归一化、局部置换、Pauli 总和、严格熵比较和开邻域论证。该源码及编译证据未附于本版本；不据此声称重新验证。

本结果指出一条具体解析捷径的失效边界。排序参考态仍是合法的候选态，因此其熵仍提供非局域最小值的上界；但不能对所有 Rényi 阶数把这一上界直接当作精确最小值。严格差即使很小，也足以否定精确等式。本文没有求最优差值、最小反例维数、失败的完整阶数区间或轨道的精确最小值。尤其是二阶最优性猜想不在本结果的解决范围内。

本文为 AI 辅助研究稿，尚未经过外部同行评议。文献比较以实际核查的来源为限，不作全球首创保证。文献 [6] 仅核查出版方摘要，用于界定资源单调性背景，不作为本证明的前提。

## 参考文献

1. L.-Y.-N. Liu, J. Cui. *Nonlocal nonstabilizerness for slightly entangled quantum many-body states*. arXiv:2607.10714v2. [全文](https://arxiv.org/html/2607.10714v2).
2. L.-Y.-N. Liu, J. Cui. *Entanglement, anti-flatness, and nonlocal nonstabilizerness: a unified perspective from entanglement spectrum*. arXiv:2609.01993v2. [全文](https://arxiv.org/html/2609.01993v2).
3. P. Sierant. *Spectral geometry of nonlocal stabilizer entropy*. arXiv:2609.13106v2. [全文](https://arxiv.org/html/2609.13106v2).
4. F. Franchini, S. M. Giampaolo. *Schmidt-Gauge Non-Local Magic: Representation, Optimality, and Mathematical Properties*. arXiv:2608.02745v2. [全文](https://arxiv.org/html/2608.02745v2).
5. M. Viscardi, L. Leone, A. Hamma. *Non-local Magic: closed-form solution and equivalence with magic of purification*. arXiv:2609.04119v2. [全文](https://arxiv.org/html/2609.04119v2).
6. L. Leone, L. Bittel. *Stabilizer entropies are monotones for magic-state resource theory*. Physical Review A **110**, L040403 (2024). [出版方摘要](https://doi.org/10.1103/PhysRevA.110.L040403).
