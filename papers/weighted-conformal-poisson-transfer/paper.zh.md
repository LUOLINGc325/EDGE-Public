# 加权共形 BH 的 Poisson 转移与共享阈值格点

## 摘要

大权重样本的 Poisson 近似在共享非零假设阈值处存在一个边界。若某个整数校准重样本数恰好让共享 $p$ 值落在 BH 网格上，有限样本极限必须等权平均「计入」与「不计入」两种误报率。本文给出该转移的 $O(n^{-1/2})$ 速率，以及两个方向相反的精确反例。另证明固定分布的高斯系数在权重 $B$ 上升时，以 $O(B^{-1})$ 的速率趋向小参数 Poisson 系数。这两条结论回答 Lim 原文留下的不同极限问题。

## 1. 固定缩放权重的有限样本极限

校准分布里重样本的概率是 $\lambda/n$，权重为 $B=\kappa n$，分数固定为 $g$。轻样本权重为一，分数 $u$ 在 $[0,1]$ 均匀。当 $u\le1-\zeta$ 时轻样本为零假设，否则为非零假设，且其测试分数共同替换为 $v$，其中 $0<g<v<1-\zeta<1$。测试分布按权重从校准分布倾斜。给定校准数据，测试单位与随机化量独立同分布。BH 阈值为 $t_k=qk/m$。

极限中重校准计数 $N$ 服从 $\operatorname{Pois}(\lambda)$，记 $K=\kappa N,\ \omega=\kappa\lambda$。轻测试分数 $u$ 的 $p$ 值趋向
$f_K(u)=(u+K\mathbf 1\{g<u\})/(1+K)$。
重测试点的 $p$ 值在 $[g/(1+K+\kappa),(g+K+\kappa)/(1+K+\kappa)]$ 均匀分布。这里的 $\kappa$ 来自重测试点自身的随机化权重。

记 $A_k$ 为给定重计数后，测试单位为零假设且 $p\le t_k$ 的概率。令 $G_k$ 为不限制真假时的网格分布值。将一个测试位强制为零，记 $\Pi_k(G)$ 为 BH 恰好拒绝 $k$ 项的概率。给定校准样本，误报比例期望为
$H(A,G)=m\sum_{k=1}^m A_k\Pi_k(G)/k$。
这是网格概率的多项式。定义 $G^-$ 以 $f_K(v)\le t_k$ 判断非零假设是否计入，$G^+$ 则用严格小于。本文证明

$$
\operatorname{FDR}_n=
E\left[\frac{H(A,G^-)+H(A,G^+)}2\right]+O(n^{-1/2}).
$$

若 $f_K(v)=t_k$，令 $r$ 为该重计数，$L=n-r$，$C_L(v)$ 为分数小于 $v$ 的轻校准数。则非零假设在该阈值达标等价于
$C_L(v)-Lv\le r(v-t_k)+t_k-U$，
右边只在长度为一的固定区间内变化。给定 $r$，左边是中心化二项变量。Berry–Esseen 给出两侧各 $1/2+O(n^{-1/2})$，落在中间的概率为 $O(n^{-1/2})$。所有非零假设共享同一个 $C_L(v)$，因此要平均两种整体误报率，而非独立决定每个测试项。其余网格坐标由经验分布集中控制，再以 Le Cam 界替换重计数分布。详细误差估计见英文证明第 2 节。

对 $m=2,q=3/10,\kappa=1/5,\lambda=1/2,g=1/20,v=4/25,\zeta=2/5$，只有 $N=1$ 触发等号。两种条件误报率相差 $29/1210$，有限样本极限比直接采用非严格不等式的 Poisson 值低 $29e^{-1/2}/4840$。反方向也可出现。取 $m=2,q=1/2,\kappa=1/16,\lambda=2,g=1/16,v=1/2,\zeta=1/4$，只有 $N=0$ 触发等号，有限样本极限高 $e^{-2}/81$。两例可用有理数复核网格概率。

在原文定理 9 的严格条件下，主格点的条件误报率跳跃是 $O(\sqrt{\kappa})$，格点本身的概率也是 $O(\sqrt{\kappa})$。其余阈值对应该处之外的指数小尾概率。因此，等号修正影响 $O(\kappa)$，原文的 $\sqrt{\kappa}$ 首项仍传递到有限样本的顺序极限。

## 2. 固定分布首项系数

改用每个 $B$ 固定之后先令 $n\to\infty$ 的次序。令重概率为 $\omega/B$，记 $s=1-\omega/B,\ W=s+\omega$。共享测试分数设成 $v_B=(t_*W-\omega)/s$，使总体 $p$ 值恰在阈值 $t_*$。

在 Lim 附录 A.3 的高斯公式里，把切换量和每个零假设网格质量扰动除以 $\sqrt B$。共同的重计数变量变为方差为 $\omega s$ 的高斯量。切换量的系数为 $(1-t_*)/(sW)$。轻分数区的质量扰动系数是 $(t_k-I_k)/(sW)$，其中 $I_k$ 在重区间下方为零、上方为一。重区间内的系数为 $(g-t_k)/(\omega W)$。轻分数的布朗桥与重计数独立，每个桥项统一带有 $B^{-1/2}$ 因子。故归一化协方差的桥贡献只有 $O(B^{-1})$。

上述三个系数在 $B\to\infty$ 时分别趋向 Poisson 模型的三个零假设质量导数。切换量极限系数严格为正，非零假设的网格质量也以 $O(B^{-1})$ 收敛。将协方差除以切换量标准差，并代回 Lim 定理 23，得到

$$\frac{c_0(B)}{q\sqrt B}=\frac{\sqrt\omega(h_+-h_-)}{q\sqrt{2\pi}}+O(B^{-1}).$$

其中右端是 Lim 定理 9 零偏移时的精确系数。原文例 13 的极限为 $0.67066332\ldots$。上述结果覆盖满足文中严格内点条件的一重样本单共同阈值族。

## 参考文献

- Ryan Lim. *Almost Controlled: The FDR of Benjamini–Hochberg on Weighted Conformal p-Values*. arXiv:2611.21509v1, 2026. [全文](https://arxiv.org/html/2611.21509v1)
- Lucien Le Cam. *An approximation theorem for the Poisson binomial distribution*. Pacific Journal of Mathematics, 1960. [论文](https://doi.org/10.2140/pjm.1960.10.1181)
- Pascal Massart. *The tight constant in the Dvoretzky–Kiefer–Wolfowitz inequality*. Annals of Probability, 1990. [论文](https://doi.org/10.1214/aop/1176990746)
