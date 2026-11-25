# 一阶以上二元 Rényi 熵的最优跨阶幂界

*幂归一化单调性剩余开放问题的肯定解答*

2026 年 11 月 24 日 · 公开研究稿

## 摘要

二元 Rényi 熵 $H_\alpha(p)$ 用不同阶数 $\alpha$ 描述同一个二元分布的不确定性。此前有人提出：经过幂归一化的量 $F_\alpha(p)=(H_\alpha(p)/\ln2)^{2/\alpha}$ 是否随阶数增大而增大？全体正阶数上的断言已有反例，而反例成果明确保留了 $\alpha>1$ 的问题。本文证明：对每个 $p\in[0,1]$，$F_\alpha(p)$ 在 $[1,\infty)$ 上单调不减；除纯分布和均匀分布外，单调性严格。因此，对任意 $1\le a<b<\infty$，

$$
H_a(p)\le(\ln2)^{1-a/b}H_b(p)^{a/b}.
$$

其中 $a/b$ 是这类归一化幂比较中能够采用的最大指数。证明将两个事实接在一起：一阶以上的二元 Rényi 熵关于阶数对数凸，以及 Shannon 熵在一阶端点满足一个信息方差不等式。这两个事实都由同一个简单的赔率不等式推出。结论直接适用于秩至多二的量子态，为不同阶数的熵提供统一比较工具。

## 1. 问题是什么，本文解决哪一部分

可以把二元分布看作一枚正面概率为 $p$ 的硬币。熵衡量结果的不确定性，Rényi 阶数决定怎样权衡高概率与低概率事件。改变阶数时，普通 Rényi 熵会下降；但把熵除以其最大值，再取一个随阶数改变的幂，变化方向就不再直接。

本文始终采用自然对数，记 $c=\ln2$。对 $0<p<1$，

$$
H_\alpha(p)=\frac{\ln(p^\alpha+(1-p)^\alpha)}{1-\alpha}
\quad(\alpha>0,\ \alpha\ne1),
$$

并在一阶处使用连续延拓

$$
H_1(p)=-p\ln p-(1-p)\ln(1-p).
$$

在 $p=0,1$ 处，熵定义为零；在 $p=1/2$ 处，所有阶数的熵都等于 $c$。

Liu 的 STACS 2026 论文 [1，第 1.4(2) 节] 在研究量子熵估计的计算困难性时，提出了幂归一化后的阶数单调性问题。该文定理 20 已能把若干阶数与固定的二阶比较，但没有给出任意两个阶数之间的结论。后续 trureturing 成果 [2] 在 $p=1/17$、阶数 $1/4$ 与 $1/2$ 处证明了反例，同时明确指出 $\alpha>1$ 是否单调仍未确定。本文研究的正是这个剩余区间，并纳入 Shannon 端点 $\alpha=1$。

已有工作已给出 Rényi 熵联合值域及其极值分布的参数描述 [4, 5]；本文证明的是沿二元分布曲线成立的显式幂界。关于熵阶数曲率的文献 [3] 研究了其他凸变换，而正积分保留对数凸性也是既有分析工具 [6]。本文的贡献是上述二元不等式及其证明，不把这些基础工具或跨阶比较的概念计作新发明。

**定理 1：幂归一化单调性。** 对任意 $p\in[0,1]$，

$$
F_\alpha(p)=\left(\frac{H_\alpha(p)}c\right)^{2/\alpha}
$$

在 $\alpha\in[1,\infty)$ 上单调不减。当 $p\notin\{0,1/2,1\}$ 时，它在每个有限阶数处的导数都严格为正，一阶处理解为右导数。在 $p=0,1$ 处，它恒为零；在 $p=1/2$ 处，它恒为一。

**定理 2：最优跨阶幂界。** 对任意 $1\le a<b<\infty$，

$$
\left(\frac{H_a(p)}c\right)^{b/a}
\le\frac{H_b(p)}c\le\frac{H_a(p)}c
\qquad(p\in[0,1]).
$$

左侧不等式在 $p\notin\{0,1/2,1\}$ 时严格。等价地，

$$
H_a(p)\le c^{1-a/b}H_b(p)^{a/b}.
$$

固定 $a,b$ 后，$a/b$ 是能让

$$
H_a(p)/c\le(H_b(p)/c)^\theta
$$

对所有二元概率 $p$ 成立的最大正指数 $\theta$。“最优”专指这一归一化幂形式；引入额外项或关于 $p$ 的额外信息后，仍可能得到更强的界。

下文给出完整解析证明。代码、数值表和图用于复核与理解，不承担对连续区间的证明。

## 2. 一个会被使用两次的简单不等式

由于交换 $p$ 和 $1-p$ 不改变熵，只需研究 $0<p<1/2$。令

$$
r=\frac{p}{1-p}\in(0,1),\qquad u=-\ln r>0,\qquad d=\ln(1+r).
$$

于是 $p=r/(1+r)$，$1-p=1/(1+r)$。这里 $d$ 依赖于概率，$c=\ln2$ 则保持不变。

**引理 3。** 对每个 $0<r<1$，

$$
d(1-r^2)>ur^2.
\tag{1}
$$

**证明。** 对数的积分表达式给出

$$
\ln(1+r)=\int_0^r\frac{dt}{1+t}>\frac r{1+r},
\qquad
-\ln r=\int_r^1\frac{dt}{t}<\frac{1-r}{r}.
$$

分别乘以正因子，就得到

$$
d(1-r^2)>r(1-r)>ur^2.
$$

在 $0<r<1$ 内，两步都是严格不等式。证毕。

这个不等式一方面控制熵随阶数的变化，另一方面控制 Shannon 熵随赔率的变化。两方面将在第五节接合。

## 3. 一阶以上的对数凸性

所谓正函数的“对数凸”，是指它的对数为凸函数。对数凸函数在两个点之间的值，不超过两个端点值的相应几何平均。

**引理 4。** 固定 $0<p<1$ 且 $p\ne1/2$ 后，$\alpha\mapsto H_\alpha(p)$ 在 $[1,\infty)$ 上对数凸。

**证明。** 沿用 $p<1/2$ 及第二节的记号，定义

$$
g(s)=d+\frac{ur^s}{1+r^s}>0\qquad(s\ge1).
$$

表达式

$$
H_\alpha(p)=\frac{\alpha d-\ln(1+r^\alpha)}{\alpha-1}
$$

的分子在 $\alpha=1$ 处为零，其关于 $\alpha$ 的导数为 $g(\alpha)$。因此

$$
H_\alpha(p)=\int_0^1g\bigl(1+t(\alpha-1)\bigr)\,dt
\qquad(\alpha\ge1).
\tag{2}
$$

这一表达式也包含 $H_1(p)=g(1)$，消除了原定义在一阶处的可去奇点。

令 $y=r^s$，则 $0<y\le r<1$。直接求导得

$$
g'(s)=-\frac{u^2y}{(1+y)^2},
\qquad
g''(s)=\frac{u^3y(1-y)}{(1+y)^3}.
$$

由此

$$
g(s)g''(s)-g'(s)^2
=\frac{u^3y}{(1+y)^4}\bigl[d-(d+u)y^2\bigr]>0.
\tag{3}
$$

括号内的量至少为 $d(1-r^2)-ur^2$，由引理 3 严格为正。因此 $g$ 在 $[1,\infty)$ 上严格对数凸。

还需说明式 (2) 中的积分保留对数凸性。任取 $a,b\ge1$ 和 $0<\lambda<1$。对每个 $t\in[0,1]$，都有

$$
g\bigl(1+t(\lambda a+(1-\lambda)b-1)\bigr)
\le g(1+t(a-1))^\lambda g(1+t(b-1))^{1-\lambda}.
$$

对 $t$ 积分，再应用 Hölder 不等式，得到

$$
H_{\lambda a+(1-\lambda)b}(p)
\le H_a(p)^\lambda H_b(p)^{1-\lambda}.
$$

被积函数在紧区间上正且连续，全部积分有限。所需对数凸性得证。

这里用到了二元分布的特殊结构，本文不把这一性质推广为任意字母表上的结论。

## 4. 为什么一阶端点也有正确的方向

对随机结果 $X$，信息量为 $-\ln P(X)$。它的方差称为信息方差或 varentropy。二元分布下，

$$
V(p)=p(1-p)\left(\ln\frac{1-p}{p}\right)^2.
$$

**引理 5：端点不等式。** 对 $0<p<1$ 且 $p\ne1/2$，

$$
\frac{V(p)}{2H_1(p)}<\ln\frac{c}{H_1(p)}.
\tag{4}
$$

在 $p=1/2$ 处，两边均为零。

**证明。** 以 $u\ge0$ 参数化概率：

$$
p(u)=\frac1{1+e^u},\qquad
w(u)=p(u)(1-p(u)),\qquad
h(u)=H_1(p(u)).
$$

由 $h(u)=\ln(1+e^{-u})+up(u)$ 可得

$$
h'(u)=-uw(u),\qquad
w'(u)=-w(u)\tanh(u/2).
$$

令 $k(u)=w(u)/h(u)$。求导得到

$$
k'(u)=\frac{w(u)}{h(u)^2}
\bigl[uw(u)-h(u)\tanh(u/2)\bigr].
\tag{5}
$$

对 $u>0$，再令 $r=e^{-u}$、$d=\ln(1+r)$，则

$$
h(u)\tanh(u/2)-uw(u)
=\frac{d(1-r^2)-ur^2}{(1+r)^2}>0.
$$

最后一步正是引理 3。因此 $k$ 在 $(0,\infty)$ 上严格递减，并在零处连续。

定义 $E(u)=\ln(c/h(u))$，则 $E(0)=0$，且 $E'(u)=uk(u)$。对每个 $u>0$，

$$
E(u)=\int_0^u vk(v)\,dv
>k(u)\int_0^u v\,dv
=\frac{u^2w(u)}{2h(u)}.
$$

右端即 $V(p)/(2H_1(p))$。对称性补足 $p>1/2$ 的情形。证毕。

此外，对式 (2) 的连续被积函数求导，可直接得到一阶处的阶数导数：

$$
\left.\frac{\partial H_\alpha(p)}{\partial\alpha}\right|_{\alpha=1}
=\frac{g'(1)}2=-\frac{V(p)}2.
\tag{6}
$$

这样就不必对存在可去奇点的商式直接求导。

## 5. 将两个方向接起来

**定理 1 的证明。** 固定 $p\notin\{0,1/2,1\}$，令

$$
z(\alpha)=-\ln\frac{H_\alpha(p)}c.
$$

引理 4 表明 $z$ 在 $[1,\infty)$ 上为凹函数。积分表达式保证它在所有有限阶数处二次连续可微，一阶处使用右侧导数。定义

$$
R(\alpha)=z(\alpha)-\alpha z'(\alpha).
$$

则

$$
R'(\alpha)=-\alpha z''(\alpha)\ge0.
$$

另一方面，引理 5 与式 (6) 给出

$$
R(1)=\ln\frac{c}{H_1(p)}-\frac{V(p)}{2H_1(p)}>0.
$$

因此对每个 $\alpha\ge1$，都有 $R(\alpha)>0$。最后，

$$
\ln F_\alpha(p)=-\frac{2z(\alpha)}\alpha,
\qquad
\frac{d}{d\alpha}\ln F_\alpha(p)=\frac{2R(\alpha)}{\alpha^2}>0.
$$

严格单调性得证。对 $p=0,1,1/2$，从定义直接得到定理中的三个常值情形。

对固定的 $0<p<1$，当 $\alpha\to\infty$ 时，$H_\alpha(p)$ 趋于正的最小熵 $-\ln\max\{p,1-p\}$，所以 $F_\alpha(p)\to1$。但这一收敛不能一致延伸到纯分布端点，因为每个有限阶数均有 $F_\alpha(0)=F_\alpha(1)=0$。本文不交换这些端点极限。

## 6. 指数为什么不能再改进

**定理 2 的证明。** 第一条跨阶幂界直接来自定理 1。另一侧 $H_b\le H_a$ 是 Rényi 熵通常的阶数单调性，也可由式 (2) 中 $g'(s)<0$ 直接读出：被积函数随阶数下降，因此积分也下降。

为证明指数最优，令 $p=(1+\delta)/2$，并考察 $\delta\to0$。对每个固定的有限阶数 $s\ge1$，

$$
H_s\left(\frac{1+\delta}2\right)
=c-\frac{s}{2}\delta^2+O(\delta^4).
\tag{7}
$$

当 $s>1$ 时，展开定义中的 $(1\pm\delta)^s$ 和对数即可得到该式；当 $s=1$ 时，直接展开 Shannon 熵，所得二次项相同。因此

$$
\frac{H_a(p)}c=1-\frac{a}{2c}\delta^2+O(\delta^4),
\qquad
\left(\frac{H_b(p)}c\right)^\theta
=1-\frac{\theta b}{2c}\delta^2+O(\delta^4).
$$

若 $\theta>a/b$，对一切充分小的非零 $\delta$，目标上界都会失败。而定理 1 已证明 $\theta=a/b$ 对所有 $p$ 成立，故这个指数确实最优。

**推论 6：秩至多二的量子态。** 若有限维密度矩阵 $\rho$ 的秩至多为二，则对 $1\le a<b<\infty$，

$$
S_a(\rho)\le c^{1-a/b}S_b(\rho)^{a/b},
$$

其中

$$
S_\alpha(\rho)=\frac{\ln\operatorname{Tr}(\rho^\alpha)}{1-\alpha},
$$

一阶处使用 von Neumann 熵。秩一态及两个非零特征值相等的态取等号，其余情形严格。

**证明。** 将至多两个非零特征值在必要时补零，可写成 $p,1-p$。零特征值在正阶数下不作贡献，直接应用定理 2 即可。

这使任意两个不小于一的阶数都能直接比较。若已知 $h_a=H_a/c$，则有 $h_a^{b/a}\le h_b\le h_a$；若已知 $h_b$，则有 $h_b\le h_a\le h_b^{a/b}$。这是一组确定性不等式。要据此建立具体的计算复杂度归约，还必须分别处理输入方式、承诺间隙和算法步骤；本文没有声称新的复杂度分类。

**推论 7：相互独立的二元因子。** 若 $X=(X_1,\ldots,X_n)$ 由 $n\ge1$ 个相互独立的二元变量组成，则

$$
\frac{H_a(X)}{nc}\le
\left(\frac{H_b(X)}{nc}\right)^{a/b}
\qquad(1\le a<b<\infty).
$$

对 $n$ 个秩至多二量子态的张量积，同样成立。这是直接推论，不涉及任意有关联的高秩态。

**证明。** 独立分布的幂和分解为各因子的幂和之积，取对数后得到熵的可加性。记 $h_{s,i}=H_s(X_i)/c$。由定理 2 和 $x\mapsto x^{a/b}$ 在 $[0,1]$ 上的凹性，

$$
\frac1n\sum_i h_{a,i}
\le\frac1n\sum_i h_{b,i}^{a/b}
\le\left(\frac1n\sum_i h_{b,i}\right)^{a/b}.
$$

量子张量积的谱幂和也具有同样的分解。取所有因子相同并趋近均匀分布，由式 (7) 可知，这一归一化幂形式中的指数同样最优。

## 7. 复现与适用边界

配套文件提供高精度导数检查、关键恒等式的符号复核、数值表与作图代码、中英文论文，以及文献查新记录。主证明仅用初等微积分和 Hölder 不等式，不依赖数值优化、有限样本或未经证明的猜想。

对于概率为 $1/17$ 的二元分布，先前已知的非单调现象发生在一阶以下；本文证明一阶以上严格递增。

主定理的范围是二元分布、秩至多二的量子态以及不小于一的阶数；推论 7 给出其独立乘积形式。本文没有确定一阶以下最大的可行单调区间，也没有推广到任意有关联的高秩态。低阶反例属于文献 [2]；本文完成的是反例之后仍被明确保留的一阶以上问题，并给出相应的最优幂指数。

本稿由 AI 辅助完成，尚未经过外部同行评议。本文没有宣称整篇 Lean 形式化认证。文献比较限于实际检索与查阅的来源，不等于全球优先权保证。

## 参考文献

[1] Yupan Liu. *Computational Hardness of Estimating Quantum Entropies via Binary Entropy Bounds*. STACS 2026, LIPIcs 364, 66:1–66:23. DOI：[10.4230/LIPIcs.STACS.2026.66](https://doi.org/10.4230/LIPIcs.STACS.2026.66)。完整预印本：[arXiv:2601.03734v2](https://arxiv.org/abs/2601.03734v2)。正式论文的开放问题位于第 1.4(2) 节，与固定二阶比较的结果为定理 20；预印本编号不同。

[2] The Omega Institute / trureturing. *The powered binary Rényi entropy is not monotone in the order*. [原始成果说明及其形式化源码入口](https://www.trureturing.org/research/liu-2026-powered-binary-renyi-monotonicity-refutation/)，2026 年 11 月 24 日核查。文末范围说明明确保留 $\alpha>1$ 的单调性问题。

[3] Filipp Buryak and Yuliya Mishura. *Convexity and robustness of the Rényi entropy*. Modern Stochastics: Theory and Applications 8(3), 387–412 (2021). DOI：[10.15559/21-VMSTA185](https://doi.org/10.15559/21-VMSTA185)。

[4] Peter Harremoës. *Joint Range of Rényi Entropies*. Kybernetika 45(6), 901–911 (2009)。[期刊全文](https://dml.cz/bitstream/handle/10338.dmlcz/140023/Kybernetika_45-2009-6_2.pdf)。

[5] Yuta Sakai and Ken-ichi Iwata. *Sharp Bounds Between Two Rényi Entropies of Distinct Positive Orders*. [arXiv:1605.00019v2](https://arxiv.org/abs/1605.00019v2)，2016。

[6] György Steinbrecher and Giorgio Sonnino. *Numerical Stability of Generalized Entropies*. [arXiv:1603.06240v3](https://arxiv.org/abs/1603.06240v3)，2016，第 6.4.1 节。
