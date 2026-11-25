---
title: "Lüders 粗粒化可以增大测量顺序分数"
subtitle: "一个精确量子比特族及其尖锐阈值"
date: "2026 年 11 月 24 日"
lang: zh-CN
fontsize: 11pt
geometry: margin=23mm
colorlinks: true
---

## 摘要

本文回答 Wu 的测量顺序框架中一个明确留下的问题：合并 POVM 效应后，重新实施合并效应所对应的 Lüders 仪器，是否会增大对共同输入态取最优的总变差顺序分数？我们构造两个三结果量子比特 POVM，其中被粗粒化的测量全部由对角效应组成，并求出一个实参数族的精确最优值。当 $1/4\le s\le1$ 时，细测量分数为 $(1-s^2)\sqrt5/10$，合并两个结果后的分数则是该值与 $(1-s)(3+8s)/20$ 的最大值。严格增大的充要条件为 $(5\sqrt5-2)/22<s<1$。有理参数 $s=3/4$ 给出 $7\sqrt5/160<9/80$ 的精确反例。证明覆盖全部复密度矩阵，明确给出正平方根、顺序记录和最优输入态，并附完整的有理事件枚举证书。在本文明确限定的意义下，量子维数二与被合并测量的三个细结果均达到最小值。结论只针对指定 Lüders 仪器的全态优化总变差分数；已经生成的经典记录仍满足数据处理收缩性。同题并行内部稿以二结果伙伴测量得到相同的一般否定答案；本稿的增量在于细效应全对易的族及其完整参数分类。

# 1. 精确问题与来源

Wu 将两个测量以相反顺序作用于同一输入态，比较所得完整联合记录，并据此定义测量顺序分数 [1，定义 1，第 3 页]。该文在命题 1(ii) 后区分了两种操作：对已经生成的经典记录做后处理；先合并测量效应，再使用合并效应的 Lüders 仪器。对于后一操作，顺序分数的单调性仍未建立 [1，第 II.B 节第 4 页；第 VIII 节第 15 页]。本文否定其中总变差分数 $T$ 在一般 POVM 类中的普遍非增性。

这一区分是问题的关键。细 Lüders 测量执行完毕后，忘掉结果集合 $C$ 内部的标签，得到的未归一化结果操作为

$$
\rho\longmapsto\sum_{a\in C}\sqrt{A_a}\,\rho\,\sqrt{A_a}.
$$

先合并效应，再实施新的 Lüders 仪器，得到的操作则为

$$
\rho\longmapsto
\sqrt{\sum_{a\in C}A_a}\,\rho\,\sqrt{\sum_{a\in C}A_a}.
$$

这两个量子操作一般不同。下文的粗测量采用第二种操作。两者不同本身并不能证明分数严格增大；还需要显式构造，以及对全部输入态的严格优化。

# 2. 定义与约定

复 Hilbert 空间 $\mathbb C^2$ 上的有限 POVM $A=(A_a)$ 由和为 $I$ 的半正定矩阵组成。其 Lüders 结果操作为 $\rho\mapsto\sqrt{A_a}\rho\sqrt{A_a}$，其中平方根指唯一的正平方根。对另一个 POVM $B=(B_b)$，定义

$$
X_{ab}=\sqrt{A_a}B_b\sqrt{A_a},\qquad
Y_{ab}=\sqrt{B_b}A_a\sqrt{B_b},\qquad
D_{ab}=X_{ab}-Y_{ab}.
$$

两种顺序的概率分别为 $p_{ab}=\operatorname{Tr}(\rho X_{ab})$ 与 $q_{ab}=\operatorname{Tr}(\rho Y_{ab})$。两个记录都按测量身份 $(a,b)$ 对齐；逆转执行顺序不会交换结果坐标的含义。两种顺序使用**同一个**输入密度矩阵 $\rho$。

本文沿用 Wu 的分数 [1]：

$$
T(A,B)=\max_{\rho\succeq0,\ \operatorname{Tr}\rho=1}
\frac12\sum_{a,b}\left|\operatorname{Tr}(\rho D_{ab})\right|.
\tag{1}
$$

优化域包含全部复密度矩阵。由于状态空间紧且被优化函数连续，最大值存在。记

$$
H(x,z)=\begin{pmatrix}z&x\\x&-z\end{pmatrix}.
\tag{2}
$$

Wu 已经给出了有限事件表达式

$$
T(A,B)=\max_{S}\lambda_{\max}
\left(\sum_{(a,b)\in S}D_{ab}\right).
\tag{3}
$$

式 (3) 是已有工具 [1，式 (3)]，并非本文的新贡献。本文主证明也可以独立于该表达式阅读。

# 3. 精确参数族与主定理

固定三结果 POVM

$$
B_0=\begin{pmatrix}3/4&0\\0&0\end{pmatrix},\qquad
B_\epsilon=\begin{pmatrix}1/8&\epsilon/4\\\epsilon/4&1/2\end{pmatrix},
\quad \epsilon\in\{+1,-1\}.
\tag{4}
$$

对实参数 $1/4\le s\le1$，令 $d=1-s^2$，并定义

$$
\begin{aligned}
A_0(s)&=\frac{16s^2-1}{15}I,\\
A_1(s)&=\frac d{15}\begin{pmatrix}16&0\\0&1\end{pmatrix},\\
A_2(s)&=d\begin{pmatrix}0&0\\0&1\end{pmatrix}.
\end{aligned}
\tag{5}
$$

将结果 $0$ 与 $1$ 合并，得到

$$
\bar A_0(s)=A_0(s)+A_1(s)=\operatorname{diag}(1,s^2),\qquad
\bar A_1(s)=A_2(s).
\tag{6}
$$

**定理 1。** 式 (4)--(6) 均定义合法 POVM。对它们各自的 Lüders 仪器，有

$$
T(A(s),B)=\frac{(1-s^2)\sqrt5}{10},
\tag{7}
$$

$$
T(\bar A(s),B)=
\max\left\{\frac{(1-s^2)\sqrt5}{10},
\frac{(1-s)(3+8s)}{20}\right\}.
\tag{8}
$$

因此，在整个区间 $s\in[1/4,1]$ 上，

$$
T(\bar A(s),B)>T(A(s),B)
\quad\Longleftrightarrow\quad
\frac{5\sqrt5-2}{22}<s<1.
\tag{9}
$$

等号区域为 $1/4\le s\le(5\sqrt5-2)/22$，以及单独的端点 $s=1$。特别地，$s=1$ 时两个分数都为零，不能把该端点纳入严格增大区域。

**推论 2（有理反例）。** 取 $s=3/4$，则

$$
A_0=\frac8{15}I,\qquad
A_1=\operatorname{diag}(7/15,7/240),\qquad
A_2=\operatorname{diag}(0,7/16),
$$

且 $\bar A_0=\operatorname{diag}(1,9/16)$。精确最优分数为

$$
\boxed{T(A,B)=\frac{7\sqrt5}{160}
<\frac9{80}=T(\bar A,B).}
\tag{10}
$$

该构造从两个三结果量子比特 POVM 出发，将其中一个测量由三个结果合并为两个结果。三个细效应 $A_a$ 两两对易。

# 4. 构造性证明

## 4.1. 测量合法性与正平方根

在参数区间上，$d\ge0$ 且 $(16s^2-1)/15\ge0$，因此全部 $A_a$ 半正定。其两条对角线的元素和均为一。各个 $B_b$ 是半正定秩一矩阵，且和为 $I$。这些事实还保证每个效应都不超过 $I$。

式 (5)--(6) 的正平方根为

$$
\begin{aligned}
\sqrt{A_0}&=\sqrt{(16s^2-1)/15}\,I,\\
\sqrt{A_1}&=\sqrt{d/15}\,\operatorname{diag}(4,1),\\
\sqrt{A_2}&=\sqrt d\,\operatorname{diag}(0,1),\\
\sqrt{\bar A_0}&=\operatorname{diag}(1,s),\qquad
\sqrt{\bar A_1}=\sqrt{A_2}.
\end{aligned}
\tag{11}
$$

这里的矩阵均半正定，平方分别等于对应效应；在两端点仍然成立。对每个 $B_b$，其正迹 $t_b$ 为 $3/4$ 或 $5/8$，且 $B_b^2=t_bB_b$。因此

$$
\sqrt{B_b}=B_b/\sqrt{t_b},\qquad
\sqrt{B_b}E\sqrt{B_b}=B_bEB_b/t_b.
\tag{12}
$$

这些公式明确固定了所用仪器，并使每个顺序记录效应中的标量平方根消去。

## 4.2. 顺序记录矩阵

对 $\epsilon=\pm1$，由式 (11)--(12) 直接相乘得到

$$
\begin{aligned}
X_{1,\epsilon}&=\frac d{30}
\begin{pmatrix}4&2\epsilon\\2\epsilon&1\end{pmatrix},&
Y_{1,\epsilon}&=\frac d{30}
\begin{pmatrix}1&2\epsilon\\2\epsilon&4\end{pmatrix},\\
X_{2,\epsilon}&=\frac d2
\begin{pmatrix}0&0\\0&1\end{pmatrix},&
Y_{2,\epsilon}&=\frac d{10}
\begin{pmatrix}1&2\epsilon\\2\epsilon&4\end{pmatrix}.
\end{aligned}
\tag{13}
$$

对合并后的结果，

$$
\bar X_{0,\epsilon}=
\begin{pmatrix}1/8&\epsilon s/4\\\epsilon s/4&s^2/2\end{pmatrix},\qquad
\bar Y_{0,\epsilon}=\frac{1+4s^2}{40}
\begin{pmatrix}1&2\epsilon\\2\epsilon&4\end{pmatrix}.
\tag{14}
$$

$B_0$ 与全部 $A_a$ 对易，所以对应列的记录差为零。$A_0$ 为标量矩阵，其对应行的记录差也为零。粗测量的另一行保持为细测量的 $A_2$ 行。

定义

$$
z=\frac{1-s^2}{10},\qquad k=2z,\qquad
\ell=\frac{(1-s)(4s-1)}{20}.
\tag{15}
$$

完整的记录差表如下。

| 细记录差 $D_{ab}$ | $B_0$ | $B_+$ | $B_-$ |
|:--|:--:|:--:|:--:|
| $A_0$ | $0$ | $0$ | $0$ |
| $A_1$ | $0$ | $H(0,z)$ | $H(0,z)$ |
| $A_2$ | $0$ | $H(-k,-z)$ | $H(k,-z)$ |

| 粗记录差 $\bar D_{ab}$ | $B_0$ | $B_+$ | $B_-$ |
|:--|:--:|:--:|:--:|
| $\bar A_0$ | $0$ | $H(\ell,z)$ | $H(-\ell,z)$ |
| $\bar A_1$ | $0$ | $H(-k,-z)$ | $H(k,-z)$ |

在整个参数区间上，

$$
z\ge0,\qquad 0\le\ell\le k=2z,
\qquad k-\ell=\frac{1-s}{4}.
\tag{16}
$$

## 4.3. 覆盖全部复输入态

任意复量子比特密度矩阵都可写为

$$
\rho=\begin{pmatrix}a&c+it\\c-it&1-a\end{pmatrix},
\qquad a,c,t\in\mathbb R.
$$

半正定性给出 $0\le a\le1$ 与 $c^2+t^2\le a(1-a)$。令

$$
X=2c,\qquad Z=2a-1,
$$

则 $X^2+Z^2\le1$，且

$$
\operatorname{Tr}(\rho H(x,z))=xX+zZ.
\tag{17}
$$

这里没有排除非零虚部：虚部对半正定性的贡献只会收紧上述圆盘约束。另一方面，下文给出的达到态本身就是合法密度矩阵，确实属于完整优化域。

## 4.4. 精确优化

对实数 $u,v$，有恒等式

$$
|u+v|+|u-v|=2\max(|u|,|v|).
\tag{18}
$$

将它应用于两个记录差表。记未对输入态优化的总变差为 $V_{\mathrm f}(\rho)$ 和 $V_{\mathrm c}(\rho)$，则

$$
V_{\mathrm f}(\rho)
=z|Z|+\max(k|X|,z|Z|)
=\max\{k|X|+z|Z|,\,2z|Z|\},
\tag{19}
$$

以及

$$
\begin{aligned}
V_{\mathrm c}(\rho)
&=\max(\ell|X|,z|Z|)+\max(k|X|,z|Z|)\\
&=\max\{(k+\ell)|X|,\,k|X|+z|Z|,\,2z|Z|\}.
\end{aligned}
\tag{20}
$$

最后一步使用 $\ell\le k$，从而 $\ell|X|+z|Z|$ 被 $k|X|+z|Z|$ 控制。由 Cauchy--Schwarz 不等式与式 (17)，

$$
k|X|+z|Z|\le\sqrt{k^2+z^2}=\sqrt5\,z.
$$

又有 $|X|,|Z|\le1$ 与 $2z\le\sqrt5z$。所以对每个复密度矩阵，

$$
V_{\mathrm f}(\rho)\le\sqrt5z,\qquad
V_{\mathrm c}(\rho)\le\max\{\sqrt5z,k+\ell\}.
\tag{21}
$$

两个所需下界都可以显式达到。令

$$
\rho_{\mathrm f}=\frac12
\begin{pmatrix}1+1/\sqrt5&2/\sqrt5\\2/\sqrt5&1-1/\sqrt5\end{pmatrix},
\qquad
\rho_+=\frac12\begin{pmatrix}1&1\\1&1\end{pmatrix}.
\tag{22}
$$

两者都半正定、迹为一、行列式为零。第一个态满足 $(X,Z)=(2/\sqrt5,1/\sqrt5)$。其四个细记录差的期望为 $z/\sqrt5,z/\sqrt5,-5z/\sqrt5,3z/\sqrt5$，故 $V_{\mathrm f}(\rho_{\mathrm f})=\sqrt5z$。式 (20) 同时给出 $V_{\mathrm c}(\rho_{\mathrm f})\ge\sqrt5z$。态 $\rho_+$ 的四个粗记录差期望为 $\ell,-\ell,-k,k$，从而 $V_{\mathrm c}(\rho_+)=k+\ell$。因此

$$
T(A(s),B)=\sqrt5z,\qquad
T(\bar A(s),B)=\max\{\sqrt5z,k+\ell\}.
$$

代入式 (15) 即得式 (7)--(8)。这里得到的是全态优化后的精确等式，而非只比较若干选定输入态。

## 4.5. 尖锐边界与有理实例

当 $s<1$ 时，严格增大等价于

$$
3+8s>2\sqrt5(1+s).
$$

两侧均为正数。平方后为 $44s^2+8s-11>0$，也即 $(22s+2)^2>125$。由于参数域内 $22s+2>0$，阈值恰为 $(5\sqrt5-2)/22$。在 $s=1$ 处，$z=k=\ell=0$，从而得到单独的端点结论。定理 1 证毕。

当 $s=3/4$ 时，$(z,k,\ell)=(7/160,7/80,1/40)$。粗分数的第二支为 $k+\ell=9/80$；由 $18^2=324>245=(7\sqrt5)^2$，该值严格大于 $7\sqrt5/160$。推论 2 因而成立。在同一个态 $\rho_+$ 上，细、粗总变差分别为 $7/80$ 与 $9/80$；式 (10) 之所以是更强的最优分数比较，关键在于细分数已经对全部状态证明了上界。

# 5. 机制、最小性与结论范围

尽管细测量的各个 $A_a$ 对易，合并仍然改变了指定仪器。对合并结果对应的未归一化操作，先执行细测量再丢弃内部标签时，$\rho$ 的非对角元被乘以

$$
\gamma_{\mathrm f}=\frac{1+4s^2}{5},
$$

而新的合并 Lüders 操作将它乘以 $\gamma_{\mathrm c}=s$。两个操作对对角元的作用相同，且

$$
\gamma_{\mathrm c}-\gamma_{\mathrm f}
=\frac{(1-s)(4s-1)}5=4\ell.
$$

因此，合并效应改变了对量子相干性的保留方式，并在粗记录差表中产生额外的非对角分量。这不违反经典数据处理不等式。对同一个随机映射 $K$，三角不等式仍保证 $\operatorname{TV}(Kp,Kq)\le\operatorname{TV}(p,q)$。本实验中的粗正序记录一般不等于将标签擦除映射应用于细正序记录所得的 $Kp$。

可以直接给出两个有限的最小性结论。在一维空间中，所有效应都是标量，故 $\sqrt{A_a}B_b\sqrt{A_a}=A_aB_b=\sqrt{B_b}A_a\sqrt{B_b}$，全部顺序分数均为零。因此维数二最小。若对二结果 POVM 做非平凡的确定性结果合并，只会得到唯一效应 $I$；它与任意另一个 Lüders POVM 的顺序分数为零。所以严格增大要求被合并测量至少有三个细结果。本构造同时达到这两个下界。

本文不主张另一侧测量的结果数、总结果数、有理系数大小或增大量达到最优。定理只涉及一般 POVM 及分数 $T$；没有解决仅限投影测量的版本，也没有解决 Jensen--Shannon 或平方 Hellinger 顺序分数的相应问题，不改变文献 [1] 中其他不等式和猜想。本文也没有声称粗粒化会创造效应层面的测量不兼容性：兼容性在经典结果后处理下保持 [4，第 II.C 节]。

# 6. 相关工作与有边界查新结论

解释本结果时，需要区分完整顺序记录分数与其他扰动或不兼容性量。Mandayam 和 Srinivas 比较先做第一个测量之后第二个测量的结果分布，与直接做第二个测量时的分布 [2]。其对输入态优化的边缘扰动量，与式 (1) 中完整正反顺序联合记录的距离不同。

Gao 等研究投影测量的相互本征空间扰动。他们的补充材料命题 1 在输入态与被粗粒化的可观测量对易的条件下证明粗粒化不等式；其默认采用的最大混态满足这一条件 [3，合并 PDF 第 6 页]。该量、测量类别和输入态量词均不同于定理 1。

其他不兼容性量早已有后处理非单调的例子。Designolle、Farkas 和 Kaniewski 比较多种鲁棒量，并给出通过拆分一个量子比特测量结果构造的 random robustness 反例 [4，附录 A，反例 3]。它并未计算式 (1)，也不是本文三结果到二结果的合并效应 Lüders 操作。鲁棒性框架 [4,5] 以及处理操作下的兼容性分类 [6] 研究的也是不同命题。

2026 年 11 月 24 日的独立查新阅读了原始论文 [1]--[6]，并检查了同期关于 Wu 的二元尖锐量子比特 Jensen--Shannon 分数随夹角变化的报告范围 [7]。该报告的分数及操作均不同；本次查新没有重新编译其外部 Lean 工程。初轮外部文献检索的范围及实际查询保存在配套审计中。总变差事件公式和经典收缩性均明确归属已有工具；最终新颖性判断还结合下述内部并行成果核对，不作全球优先权保证。

推送前的仓库再次去重发现一份同题并行内部稿 [8]：它使用不对易的三个细效应及二结果伙伴测量，给出最优分数 $1/30$ 与 $9/250$，因而也否定一般非增性。共同的否定结论不重复计为两项新解决问题，也不在两份并行稿之间主张优先权。本稿的独立增量限定为细效应两两对易的完整参数族、全参数精确最优值及尖锐阈值。对照快照与差异在配套并行比较中记录；未发现本显式对易效应族的全参数精确公式与阈值已有等价结果，不等于全球优先权保证。

# 7. 复现与验证状态

配套脚本 `code/exact_certificate.py` 仅使用 Python 标准库有理数运算。它检查有理效应的半正定性与归一性、秩一夹乘恒等式、两个记录差表，并对 $s=3/4$ 的实例穷举全部 $2^9=512$ 个细事件与 $2^6=64$ 个粗事件。最大的事件范数平方精确为 $49/5120$ 和 $81/6400$。脚本还检查同态证人及九个有理参数值，包含两个端点。显式核验在启用 Python 优化时仍然生效。在案例目录运行

```sh
python3 -B -O code/exact_certificate.py
```

预期输出记录为 `results/exact_certificate.json`。这些有限检查是可独立复现的算术证据。定理 1 的连续参数及全复态量词由上述解析证明保证；单凭有限参数采样不能推出该定理。

**形式化状态。** 全篇 Lean 认证与仓库强制的隔离公开发布门禁尚未完成。随附 Lean 源码属于开发产物；一个基础模块曾独立编译通过，这不能认证整篇论文。实际构建尝试、范围审查及尚需完成的要求与源码一并归档。数学结论由上述完整解析证明和独立精确核验支持。本文为 AI 辅助研究稿，尚未经外部同行评议。

# 附录 A. 完整有限事件证书

直接相乘可得 $H(x,z)^2=(x^2+z^2)I$，故其最大特征值为 $\sqrt{x^2+z^2}$。对总质量相同的两个概率记录，有 $\tfrac12\sum_j|p_j-q_j|=\max_S\sum_{j\in S}(p_j-q_j)$。再对状态与有限事件集取最大值即得式 (3)，这在本例中复现了已有公式。

两个记录差表都只有四个可能非零的条目。记

$$
v_0=(\ell,z),\quad v_1=(-\ell,z),\quad
v_2=(-k,-z),\quad v_3=(k,-z).
$$

粗表使用式 (15) 的参数，细表对应将 $\ell$ 换成零。零条目是否被选入事件，不影响事件和。完整枚举为

| 事件 $S$ | $\sum_{j\in S}v_j$ |
|:--|:--:|
| $\varnothing$ | $(0,0)$ |
| $\{0\}$ | $(\ell,z)$ |
| $\{1\}$ | $(-\ell,z)$ |
| $\{2\}$ | $(-k,-z)$ |
| $\{3\}$ | $(k,-z)$ |
| $\{0,1\}$ | $(0,2z)$ |
| $\{0,2\}$ | $(\ell-k,0)$ |
| $\{0,3\}$ | $(\ell+k,0)$ |
| $\{1,2\}$ | $(-\ell-k,0)$ |
| $\{1,3\}$ | $(k-\ell,0)$ |
| $\{2,3\}$ | $(0,-2z)$ |
| $\{0,1,2\}$ | $(-k,z)$ |
| $\{0,1,3\}$ | $(k,z)$ |
| $\{0,2,3\}$ | $(\ell,-z)$ |
| $\{1,2,3\}$ | $(-\ell,-z)$ |
| $\{0,1,2,3\}$ | $(0,0)$ |

在式 (16) 的条件下，最大长度为

$$
\max\{\sqrt{\ell^2+z^2},\sqrt{k^2+z^2},2z,k+\ell\}
=\max\{\sqrt5z,k+\ell\}.
$$

当 $\ell=0$ 时，该值为 $\sqrt5z$。这给出两个分数的另一套精确推导，并构成脚本有限枚举的完整证书。

# 参考文献

1. S. Wu, *Measurement-order dependence bounds uncertainty, contextuality, steering, and Bell nonlocality*, arXiv:2611.24604v1（2026 年 11 月 18 日）。[固定版本](https://arxiv.org/abs/2611.24604v1)。相关位置：第 3 页定义 1 及式 (3)；第 4 页第 II.B 节命题 1(ii) 后；第 15 页第 VIII 节。

2. P. Mandayam and M. D. Srinivas, *Measures of disturbance and incompatibility for quantum measurements*, Physical Review A **89**, 062112 (2014). [arXiv:1402.0810v3](https://arxiv.org/abs/1402.0810v3)；[DOI](https://doi.org/10.1103/PhysRevA.89.062112)。

3. N. Gao, D. Li, A. Mishra, J. Yan, K. Simonov and G. Chiribella, *Measuring incompatibility and clustering quantum observables with a quantum switch*, Physical Review Letters **130**, 170201 (2023). [arXiv:2208.06210v4](https://arxiv.org/abs/2208.06210v4)；[DOI](https://doi.org/10.1103/PhysRevLett.130.170201)。补充材料命题 1 位于合并 PDF 第 6 页。

4. S. Designolle, M. Farkas and J. Kaniewski, *Incompatibility robustness of quantum measurements: a unified framework*, New Journal of Physics **21**, 113053 (2019). [arXiv:1906.00448v5](https://arxiv.org/abs/1906.00448v5)；[DOI](https://doi.org/10.1088/1367-2630/ab5020)。

5. T. Heinosaari, J. Kiukas and D. Reitzner, *Noise robustness of the incompatibility of quantum measurements*, Physical Review A **92**, 022115 (2015). [arXiv:1501.04554v3](https://arxiv.org/abs/1501.04554v3)；[DOI](https://doi.org/10.1103/PhysRevA.92.022115)。

6. A. K. Das, S. Mukherjee, D. Saha, D. Das and A. S. Majumdar, *Classifying Measurement Incompatibility under Classical Pre- and Post-Processing Operations*, Proceedings of the Royal Society A **482**, 20250045 (2026). [arXiv:2401.01236v3](https://arxiv.org/abs/2401.01236v3)；[DOI](https://doi.org/10.1098/rspa.2025.0045)。

7. the-omega-institute/trureturing, *Monotonicity of Wu's qubit Jensen--Shannon order score*，仓库报告，2026 年 11 月 24 日查阅。[问题及结论声明](https://the-omega-institute.github.io/trureturing-mdbook/Problems/wu-2026-qubit-order-score-monotonicity.html)。配套来源清单记录了所查阅提交及其声明范围。

8. 相关未发表研究稿，2026年11月24日；不据此主张已建立优先权。
