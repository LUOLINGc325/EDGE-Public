# 四能级纠缠交换的固定资源精确可达区间

*标准循环 Bell 测量下的完整性能边界与构造性证明*

AI 辅助研究稿

2026 年 11 月 24 日

## 摘要

考虑两对独立的四能级纯态，它们在固定计算基中具有 Schmidt 对齐形式，并在中间节点接受标准循环广义 Bell 测量。固定两个输入的未归一化 $l_1$ 纠缠量 $e,f\in[0,3]$，我们确定概率加权平均输出纠缠量的完整可达集合。令

$$
R(x)=\begin{cases}x,&0\le x\le1,\\(3-x)/2,&1\le x\le3,\end{cases}
\qquad W=R(e)R(f).
$$

则可达集合恰为

$$
\boxed{\left[\frac{ef-W}{3},\;\frac{ef+2W}{3}\right].}
$$

这既给出对所有输入成立的上下界，也给出每个区间点的实际输入态构造。关键是确定一个输入的纠缠资源与相隔两级的循环相关量之间的完整可行域，再完成双仿射优化。证明包含复振幅、全部十六个测量结果、零概率结果和退化资源端点。区间非退化时，原文提出、后已被反例否定的 $ef/3$ 值恰在本区间自下端起三分之一处。本稿研究的是该猜想之后的精确性能刻画，不主张首次反驳原猜想。

**状态与边界。** 本文是AI 辅助研究稿，未经外部同行评议。原研究稿所述 Lean 源码从下面明确写出的 Bell 条件振幅与 Born 概率定义起，覆盖全部新数学结论；它不验证外部文献的优先权，也不将其他测量、混态输入或任意局部操作纳入本定理。

## 1. 问题与已有结果

Starke、Basso、Céleri 与 Maziero [1] 研究部分纠缠 qudit 的交换协议，给出输入纠缠量控制平均输出的若干界，并在式 (59) 猜测一个含维数因子的乘积上界。四维反例及其形式化证明已经公开 [2]；因此，重复给出反例不构成本稿的新问题。

我们固定维数为四、固定原协议的循环 Bell 测量，问：**若已知两条输入链路各自拥有多少纠缠资源，所有可能输入排布产生的平均输出究竟覆盖哪个区间？** 这是由原猜想失效引出的精确后续问题；[1] 并未逐字提出本文这个完整区间问题。[2] 给出了一个反例并明确保留最优替代界问题。我们的贡献是对全部实资源对的完整可行域、最优上下界与每一点的构造性达到。

这里的输入系数不要求按大小排序；它们的标签相对于固定 Bell 基有物理作用。允许系数为零。结论针对记录测量结果后的条件纠缠量的概率平均，不是丢弃测量记录后混合态的纠缠量。

## 2. 明确的有限维协议

所有下标在 $\mathbb Z/4\mathbb Z$ 中相加。输入为

$$
|\xi\rangle=\sum_{j=0}^3c_j|jj\rangle,
\qquad
|\eta\rangle=\sum_{j=0}^3b_j|jj\rangle,
\qquad
\sum_j|c_j|^2=\sum_j|b_j|^2=1.
$$

对任意系数向量 $v$，记

$$
E(v)=\sum_{j\ne k}|v_jv_k|.
$$

对归一化 Schmidt 对齐向量，这是本文唯一使用的纠缠量。令 $e=E(c)$、$f=E(b)$。采用 [1] 的循环 Bell 约定，结果 $(p,q)$ 对应未归一化条件态在配对正交基 $|p+j\rangle\otimes|j\rangle$ 中的振幅

$$
z^{pq}_j=\frac{c_{p+j}b_j(-i)^{qj}}{2}.
$$

其概率为 $P_{pq}=\sum_j|z^{pq}_j|^2$。若 $P_{pq}>0$，条件系数为 $z^{pq}/\sqrt{P_{pq}}$；若概率为零，该结果对平均值贡献零。定义

$$
A(c,b)=\sum_{p,q}\begin{cases}
P_{pq}E(z^{pq}/\sqrt{P_{pq}}),&P_{pq}>0,\\
0,&P_{pq}=0.
\end{cases}
$$

这些振幅、概率及平均规则就是配套形式化的协议定义。由相位模长为一，全部概率之和等于两个输入平方范数的乘积，因而等于一；每个正概率条件向量归一化。映射 $j\mapsto p+j$ 单射，两端的基向量分别正交，因此 $|z^{pq}_j|/\sqrt{P_{pq}}$ 是正概率条件态的 Schmidt 系数。

### 引理 1：概率平均的精确化简

令 $a_j=|c_j|$、$d_j=|b_j|$。则

$$
A(c,b)=\sum_{p=0}^3\sum_{j\ne k}a_{p+j}a_{p+k}d_jd_k. \tag{1}
$$

**证明。** 若 $P_{pq}>0$，两个条件系数的模长相乘产生分母 $P_{pq}$，与概率权重抵消。该结果的贡献是 $\frac14\sum_{j\ne k}a_{p+j}a_{p+k}d_jd_k$。若 $P_{pq}=0$，其非负平方和中的每一项为零，所有条件系数均为零，右侧相应交叉积也为零。最后对四个 $q$ 求和，消去 $1/4$。此步骤沿用 [1,2] 的相关和化简，我们重新形式化其全部分支，不将化简本身列作新贡献。$\square$

## 3. 单输入可行域的完整刻画

对非负归一化向量 $a$ 定义

$$
e=2\sum_{0\le j<k\le3}a_ja_k,
\qquad t=2(a_0a_2+a_1a_3).
$$

$t$ 是相隔两级的循环相关量。定义

$$
\ell(e)=\max\{0,(e-1)/2\},\qquad h(e)=\min\{e,1\}.
$$

### 定理 2：精确可行区间

存在非负归一化 $a$ 使其资源及相隔两级相关量为 $(e,t)$，当且仅当

$$
0\le e\le3,\qquad \ell(e)\le t\le h(e). \tag{2}
$$

**必要性。** 设 $x=a_0+a_2$、$y=a_1+a_3$。直接展开得到

$$
x^2+y^2=1+t,\quad 2xy=e-t,
$$

$$
1-t=(a_0-a_2)^2+(a_1-a_3)^2,\quad
1+2t-e=(x-y)^2.
$$

非负性给出 $0\le t\le e$、$t\le1$ 和 $e-1\le2t$。这些条件也蕴含 $0\le e\le3$，故得到 (2)。

**充分性及显式构造。** 给定满足 (2) 的 $(e,t)$，令

$$
s=\sqrt{e+1},\quad d=\sqrt{1-e+2t},\quad
x=\frac{s+d}{2},\quad y=\frac{s-d}{2},\quad
\eta=\sqrt{\frac{1-t}{1+t}}.
$$

所有根号内量非负，且 $1+t>0$、$s\ge d$、$0\le\eta\le1$。取

$$
a=\frac12\bigl(x(1+\eta),\;y(1+\eta),\;x(1-\eta),\;y(1-\eta)\bigr). \tag{3}
$$

其坐标非负。又 $x^2+y^2=1+t$、$x+y=s$ 和 $(1+t)\eta^2=1-t$，所以

$$
\sum_ja_j^2=\frac{(x^2+y^2)(1+\eta^2)}2=1,
$$

$$
2(a_0a_2+a_1a_3)=\frac{(x^2+y^2)(1-\eta^2)}2=t,
$$

$$
E(a)=\left(\sum_ja_j\right)^2-1=s^2-1=e.
$$

因此 (2) 是真实可行域，不只是一个放松约束。构造对 $e=0,1,3$ 及 $t=0,1$ 仍有效。$\square$

## 4. 主定理：完整输出区间

对第二个非负输入 $d$ 同样写资源 $f$ 和相隔两级相关量 $u$。将式 (1) 按三个非零循环位移展开，可得

$$
A(c,b)=F_{e,f}(t,u):=\frac{(e-t)(f-u)}2+tu. \tag{4}
$$

式 (4) 是精确恒等式。也可以直接展开式 (1) 的四十八个非对角乘积核对。两个输入分别可选择，故 $(t,u)$ 的可行集合恰为矩形 $[\ell(e),h(e)]\times[\ell(f),h(f)]$。

### 定理 3：固定资源的精确范围

对每个 $e,f\in[0,3]$，存在满足 $E(c)=e$、$E(b)=f$ 且 $A(c,b)=z$ 的归一化复系数输入，当且仅当

$$
\frac{ef-R(e)R(f)}3\le z\le\frac{ef+2R(e)R(f)}3. \tag{5}
$$

特别地，两个端点都达到，每个中间值也达到。

**全域界的证明。** 双仿射函数在非空闭矩形内的值介于四角最小值与最大值之间。这里也可连续两次对一个变量作线性插值证明，无需调用凸性假设。四角值如下；顺序为 $(\ell(e),\ell(f))$、$(\ell(e),h(f))$、$(h(e),\ell(f))$、$(h(e),h(f))$。

| 资源区域 | 左下角 | 两个混合角 | 右上角 |
|:--|:--|:--|:--|
| $e\le1,\ f\le1$ | $ef/2$ | $0$ | $ef$ |
| $e\le1,\ f\ge1$ | $e(f+1)/4$ | $e(f-1)/2$ | $e$ |
| $e\ge1,\ f\le1$ | $f(e+1)/4$ | $f(e-1)/2$ | $f$ |
| $e\ge1,\ f\ge1$ | $(3ef-e-f+3)/8$ | $(ef+e+f-3)/4$ | $1+(e-1)(f-1)/2$ |

每一行的混合角均为最小值，右上角均为最大值。最后一行中，左下角与两个极值的差分别为 $(3-e)(3-f)/8$；混合区域的比较归结为 $3-e\ge0$ 或 $3-f\ge0$。分支边界 $e=1$ 或 $f=1$ 上的公式一致。记这两个极值为 $L(e,f)$、$U(e,f)$，四个区域分别代入 $R$ 即得到 (5)。

**每一点达到的证明。** 固定 $t=h(e)$。当 $u$ 从 $\ell(f)$ 变化到 $h(f)$ 时，式 (4) 从 $L(e,f)$ 线性变化到 $U(e,f)$。若 $L<U$，对给定 $z\in[L,U]$，取

$$
\theta=\frac{z-L}{U-L},\qquad
u=\ell(f)+\theta\bigl(h(f)-\ell(f)\bigr). \tag{6}
$$

此时 $0\le\theta\le1$，$F_{e,f}(h(e),u)=z$。用式 (3) 分别构造两个输入，再视作复向量，就得到实际归一化输入。若 $L=U$，直接取端点，完全不作零分母除法。必要性已由全域界证明，定理得证。$\square$

## 5. 相对于原猜想的准确含义

### 推论 4：偏离量、区间宽度和内部资源的严格违反

式 (4) 可以写为

$$
A(c,b)=\frac{ef}{3}
+\frac32\left(t-\frac e3\right)\left(u-\frac f3\right). \tag{7}
$$

因此，决定偏离方向的是两个输入循环相关量相对于各自均衡值的乘积。完整范围的宽度为

$$
U-L=R(e)R(f),\qquad
\frac{ef}{3}=L+\frac{U-L}{3}. \tag{8}
$$

$ef/3$ 本身总可达到。若 $0<e,f<3$，则 $R(e)R(f)>0$，上端点严格大于 $ef/3$；所以每一个内部资源对都允许违反原猜想界的输入。这把已有单个反例扩展为完整资源空间中的性能描述，不改变原反例的归属。

若任一资源为零或三，则区间退化为单点 $ef/3$。特别地，一侧资源为零时输出为零，一侧为最大值三时输出等于另一侧资源。

**两个资源例子。** 当 $e=f=1$，可达集合为 $[0,1]$；相同输入资源数量并不确定输出。当 $e=f=2$，可达集合为 $[5/4,3/2]$。这两个区间均由定理的完整存在性结论保证。

**已有反例的定位。** 对 [2] 的向量 $c=b=(7,1,7,1)/10$，有 $e=f=39/25$、$A=723/625$。本定理进一步识别该值恰等于相应资源下的上端点 $U(39/25,39/25)$。该归一化向量与全部数值也在 Lean 中重新精确验证，但向量和反例本身来自 [2]。

## 6. 形式化、独立检查与复现

规范源码为 `formalization/Result.lean`，工具链固定为 Lean 4.19.0，Mathlib 固定提交 `c44e0c8ee63ca166450922a373c7409c5d26b00b`。主要对应关系如下。

| 论文内容 | Lean 声明（命名空间 `QuquartSwapping`） |
|:--|:--|
| 明确条件振幅、Born 概率与全部结果平均 | `bellAmplitude`, `mass`, `outcome`, `bellAverage` |
| 零概率处理、条件归一化与总概率 | `mass_zero`, `outcome_eq`, `normalized_mass`, `total_bell_probability` |
| 引理 1 及式 (4) | `bellAverage_average`, `average_transfer`, `bellAverage_transfer` |
| 定理 2 的充要性和构造 | `valid_feasible`, `feasible_realizable`, `feasibility_exact` |
| 双仿射全域界与每点达到 | `transfer_bounds`, `transfer_surjective` |
| 定理 3 的复振幅完整结论 | `attainable_iff`, `exact_physical_range` |
| 偏离量、宽度、内部严格违反 | `physical_centered`, `exact_width`, `strict_violation_every_interior_resource` |
| 原猜想值及退化边界 | `printed_value_attainable`, `printed_value_one_third`, `boundary_range` |
| 两个资源例子与已有向量的定位 | `one_one_range`, `two_two_range`, `publishedWitness_values` |

源码对任意实参数证明结论，不依赖有限网格枚举。构建脚本收集本模块所有新定义、定理和编译器辅助声明的传递公理，只接受 `Classical.choice`、`Quot.sound`、`propext`。本版本暂未附相应 Lean 源码和构建凭证，不声称已经在此仓库重新编译。

原研究稿另述 Python 标准库精确算术复现（本版本暂未附程序），从复有理 Bell 投影、Born 概率和条件纠缠平均计算，再对照相关和与区间公式。它用于发现索引、归一化和实现错误，不能替代连续域的书面证明或 Lean 证明。

## 7. 文献核查范围与限制

已直接比较 [1] 的全文、[2] 的一手研究记录，以及研究 I-concurrence [3]、qubit 交换 [4]、G-concurrence 和测量优化 [5]、后续综述 [6] 等近邻。[5] 已核对 2026 年 8 月更新的 v2：§III.2 优化 G-concurrence，§XII 也讨论通常 Bell 测量及其傅里叶旋转；它与本文的关键区别在于纠缠量和固定资源问题，而非完全不同的物理操作。其他近邻的量、维数、固定资源或可优化协议也与本文不同；在本次实际核查范围内，未发现同一固定资源四维完整区间结论。

对 Cong 与 Xu [7] 仅取得出版社摘要，未取得全文。摘要讨论 qubit 条件态 concurrence 与纯化，未显示与本命题重合；本文不声称已经全文排除该文。查新结论限于可核查材料，不证明全球优先权。

本文不解决一般维数、任意测量优化、任意输入基取向或混态量子网络的完整性能问题；且尚未经过外部同行评议。新结果的确切范围是式 (5) 所述的有限维、固定协议、全部实资源对的完整刻画。

## 参考文献

[1] D. S. Starke, M. L. W. Basso, L. C. Céleri, J. Maziero. *Entanglement swapping for partially entangled qudits and the role of quantum complementarity*. arXiv:2508.00813v2. DOI: [10.1002/qute.202500674](https://doi.org/10.1002/qute.202500674). 实际协议全文：[arXiv HTML](https://arxiv.org/html/2508.00813v2)。

[2] trureturing. *The improved entanglement-swapping product bound fails in dimension four*. [一手研究记录](https://www.trureturing.org/research/starke-2025-qudit-swapping-product-bound-refutation/). 查阅日期：2026-11-24。既有四维反例及一般相关和化简的归属来源。

[3] J. A. Bergou et al. *Average concurrence and entanglement swapping*. Physical Review A 104, 022425 (2021). [arXiv:2106.00848](https://arxiv.org/abs/2106.00848). DOI: [10.1103/PhysRevA.104.022425](https://doi.org/10.1103/PhysRevA.104.022425).

[4] S. M. Zangi et al. *Entanglement Swapping and Swapped Entanglement*. Entropy 25, 415 (2023). [开放全文](https://pmc.ncbi.nlm.nih.gov/articles/PMC10047960/). DOI: [10.3390/e25030415](https://doi.org/10.3390/e25030415).

[5] M. Alimuddin, J. Kim, A. Acín, L. Zambrano. *Entanglement-swapping measurements for deterministic entanglement distribution*. arXiv:2601.08581v2 (2026-08-21). [查阅的 v2 完整 HTML](https://arxiv.org/html/2601.08581v2)，相关部分 §III.2、§XII。本文用于比较 G-concurrence、通常 Bell 测量及测量优化的研究范围。

[6] D. S. Starke et al. *Bohr's complementarity*. [arXiv:2605.26375v1](https://arxiv.org/html/2605.26375v1), 相关部分 §VI.5。

[7] R.-Z. Cong, S. Xu. *Formal bounds of entanglement purification via entanglement swapping*. Physical Review A 111, 012409 (2025). DOI: [10.1103/PhysRevA.111.012409](https://doi.org/10.1103/PhysRevA.111.012409). 本次仅核查[出版社摘要](https://journals.aps.org/pra/abstract/10.1103/PhysRevA.111.012409)。
