# 加权共形 BH 的有限样本误报率线性上界

## 摘要

测试数据的分布和校准数据不同，可以给校准样本加权，用共形方法构造 $p$ 值。多个测试共用一份校准集时，Benjamini–Hochberg（BH）的误报率可能超出设定值。本文证明，当所有零假设成立时，误报率相对目标值的超额至多为 $C(q)mB/(n+1)$。$n$ 为校准数，$m$ 为测试数，$B$ 为权重比上界，$q$ 为目标值。结果允许分数重复。关键是把校准异常局限到它所影响的单个 BH 阈值。

## 1. 模型与结论

校准单位独立同分布于 $P$，测试单位独立同分布于 $Q$，两组独立。重要性权重满足 $dQ/dP=w/E_Pw$，经共同缩放后 $1\le w\le B$。固定实值分数 $V$，记校准权重和为 $S$，校准分数严格低于或等于 $v$ 的权重和分别为 $S_{<}(v),S_{=}(v)$。对真实测试分数 $v_j$、权重 $w_j$ 和独立均匀随机量 $U_j$，定义

$$p_j^*=\frac{S_{<}(v_j)+U_j[S_{=}(v_j)+w_j]}{S+w_j}.$$

测试数和校准数均至少为一。BH 在阈值 $t_k=qk/m$ 中寻找至少有 $k$ 个 $p$ 值达标的最大下标。全零假设下，错误发现率（FDR）等于至少拒绝一次的概率。只需处理真实分数产生的 $p_j^*$，因为逐项提高 $p$ 值只会减小发生拒绝的概率。这也覆盖原选择性推断模型中由分数单调性保证的 $p_j\ge p_j^*$。

令 $\tau=B/(n+1)$、$\kappa=B/n$、$\bar{B}=\operatorname{ess\,sup}(w)/E_Pw$。对 $m\ge2$，取 $\rho>1+\kappa$ 且 $\alpha=\rho q<1$，置 $\delta=\rho m\tau$。本文给出如下定量界

$$
\frac{\operatorname{FDR}}q-1
\le 2(m-1)\tau\frac{e^{2(1-\alpha)+\delta(1/\alpha-1)}}
{(1-\alpha e^{1-\alpha})^2}+(e^a-1)^{-2},
\qquad
a=\frac{nq(\rho-1-\kappa)^2}{2\bar{B}m(3\rho-2-2\kappa)}.
$$

它推出对每个固定的 $0<q<1$ 有仅依赖 $q$ 的显式 $C(q)$，使 FDR 不超过 $q[1+C(q)mB/(n+1)]$。

## 2. 从拒绝概率到临界窗口

固定一个测试位置。把该位置的 $p$ 值设为零，其他值为向量 $y$，记 BH 拒绝数为 $R^0(y)$。设值前，该位置恰在原 $p$ 值不超过 $t_{R^0(y)}$ 时被拒绝，此时拒绝数仍为 $R^0(y)$。

把校准样本和该测试点合成一个含 $n+1$ 个点的池。可先从按池权重和倾斜的 $P^{n+1}$ 取池，再按点权重选出测试点。两次权重因子的乘积只剩选出点的 $w/E_Pw$，所以正好复原原模型。给定这个池，每个等分数组按其总权重得到一个区间。选中该组的概率等于区间长度，而随机化给出区间内均匀值，故指定位置的 $p_j^*$ 条件均匀。

更换池内被选中的测试点时，任一其他 $p$ 值只换掉一个校准贡献。两种取法的公共部分至少有权重 $n$，所以两种 $p$ 值最多相差 $B/(n+B)\le\tau$。若 $x$ 是实际的其他 $p$ 值向量，所有可能 $R^0$ 的最大值与最小值之比至多为 $R^0(x-\tau)/R^0(x+\tau)$。条件均匀性把指定位置的期望误报贡献控制在这个比值乘以 $q/m$。

如果上面的两个拒绝数不同，则对 $k=R^0(x-\tau)$，统计量 $x_{(k-1)}$ 必在 $I_k=(t_k-\tau,t_k+\tau]$ 内，且比值减一不超过 $k-1$。因此，记 $W_k=\{x_{(k-1)}\in I_k\}$，有

$$\frac{\operatorname{FDR}}q-1\le \sum_{k=2}^m(k-1)\Pr(W_k).$$

这复现了 Lim 定理 76 的全零假设情形，条件均匀性同时给出 $p_j^*$ 的边际均匀性。

## 3. 逐阈值分割及二项级数

记 $G_D$ 为给定校准数据 $D$ 后真实测试 $p$ 值的分布函数。对 $b_k=t_k+\tau$，分别定义好事件 $H_k=\{G_D(b_k)\le\rho b_k\}$。在 $W_k$ 上，某个测试点位于 $I_k$，同时至少有 $k-2$ 个其他点不超过 $b_k$。给定 $D$ 后测试点独立同分布。因此利用边际均匀性 $E[G_D(I_k)]\le2\tau$，

$$
\Pr(W_k\cap H_k)\le 2(m-1)\tau\,
\Pr\{\operatorname{Bin}(m-2,\min(1,\rho b_k))\ge k-2\}.
$$

另一方面，Lim 式 (15) 的单阈值集中界直接给出 $\Pr(H_k^c)\le e^{-ka}$。英文稿第 3 节给出其推导。它以允许等分数的总体分位点为界，将经验加权分布的偏离归结为独立有界变量的单侧 Bernstein 不等式。如果 $\rho b_k\ge1$，坏事件为空。

对每个 $k$ 分别处理坏事件，求和只需支付 $\sum_{k\ge2}(k-1)e^{-ka}=(e^a-1)^{-2}$。好事件中的二项尾组成 Lim 定理 78 的 $\beta_m(\rho)$。其中第 $k$ 项的二项均值最多为 $\alpha k+\delta$。指数矩用 $\lambda=1/\alpha>1$ 时，第 $k$ 项的尾概率至多为 $\lambda^{2-k}e^{(\lambda-1)(\alpha k+\delta)}$。因为 $r=\alpha e^{1-\alpha}<1$，计算 $\sum_{k\ge2}(k-1)r^k=r^2/(1-r)^2$ 即得

$$\beta_m(\rho)\le\frac{e^{2(1-\alpha)+\delta(1/\alpha-1)}}{(1-\alpha e^{1-\alpha})^2}.$$

## 4. 所有参数下的线性界

设 $x=mB/(n+1)$，固定 $\rho=(1+q)/(2q)$、$x_0=\min(1,(\rho-1)/2)$、$c=q(\rho-1)^2/[16(3\rho-2)]$。对 $m\ge2$ 有 $\kappa\le x$。当 $x\le x_0$ 时，$\rho-1-\kappa\ge(\rho-1)/2$，由 $n/(n+1)\ge1/2$ 得 $a\ge c/x$。异常项至多为 $x^2/c^2\le x_0x/c^2$，好事件项的系数则可把 $\delta$ 换成 $\rho x_0$ 后固定下来。大于 $x_0$ 时使用 $\operatorname{FDR}\le1$；只有一个测试时使用边际均匀性。取这几种情形所需常数的最大值即可。英文稿写出了显式常数。

原文给出固定 $m$ 的上界和 Poisson 窗口族随 $m$ 线性增长的下界。本文补上任意有限 $m,n$ 的线性上界，边界为独立测试、已知有界权重和全零假设。最优前导系数需要另行估计。

## 参考文献

- Ryan Lim. *Almost Controlled: The FDR of Benjamini–Hochberg on Weighted Conformal p-Values*. arXiv:2611.21509v1, 2026. [全文](https://arxiv.org/html/2611.21509v1)
- Ying Jin and Emmanuel J. Candès. *Model-free selective inference under covariate shift via weighted conformal p-values*. Biometrika 113(1), asaf066, 2026. [论文](https://doi.org/10.1093/biomet/asaf066)
