# Gaffke 统计量留一系数的尖锐下界

## 摘要

Haben Michael 的猜想 2 要求对 Gaffke 统计量的公共留一系数给出下界。本文证明该猜想，并把界中的总维数参数改进为严格小于一的坐标个数。新界可取等，且完整刻画等号。

## 1. 结论

令 $x_i\ge0$，$E_0,E_1,\dots,E_n$ 为独立单位速率指数变量。定义
$$S=\sum_i(x_i-1)E_i,\qquad K(x)=\Pr(S<E_0)=E[e^{-S_+}].$$
对任意 $x_i\ne1$，留一系数 $\Delta K(x)=[K(x_{-i})-K(x)]/(x_i-1)$ 与删除位置无关。

如果至少有一个坐标大于一，且有 $r\ge1$ 个坐标严格小于一，则
$$\Delta K(x)\ge (1-K(x))^{r/(r+1)}-(1-K(x)).$$
此式等号恰在只有一个坐标大于一、所有小于一的坐标均为零时成立。允许另有等于一的坐标。

由于 $r\le n-1$，在 $n\ge2$ 时得到 Michael 的猜想 2
$$\Delta K(x)\ge (1-K(x))^{1-1/n}[1-(1-K(x))^{1/n}].$$
在 $K(x)<1$ 的情形，该式取等恰为 $(0,\ldots,0,b)$ 的排列，其中 $b>1$。没有大于一的坐标时 $K=1$，右侧为零。全一向量本身没有定义留一商，可采用下文概率表达式的零值约定。

## 2. 证明

固定一个待删除的位置，对其他指数变量条件化。其余贡献记作 $Y$，当前位置贡献为 $(x_i-1)E_i$。对 $e^{-(Y+(x_i-1)u)_+}$ 按指数密度分部积分，得到
$$\Delta K(x)=E[e^{-S}\mathbf1\{S>0\}].$$

把正项之和记作 $P$，负项绝对值之和记作 $N=\sum_{i:x_i<1}d_iE_i$，其中 $d_i=1-x_i\in(0,1]$。令 $A=\Pr(P>N)$、$D=\Pr(P>N+E_0)$。则 $D=1-K$ 且 $\Delta K=A-D$。只需证明 $D\le A^{1+1/r}$。

两组指数和的密度都是对数凹的，故 $H(t)=\Pr(P>t)$ 也对数凹。选唯一 $\lambda>0$，使 $E H(N)=E e^{-\lambda N}=A$。由 $\log H(t)+\lambda t$ 从原点出发的凹性，$H(t)-e^{-\lambda t}$ 最多只从正变负一次。另一方面，$N+E_0$ 的密度除以 $N$ 的密度是严格递增的。原因是对数凹性使每个平移比 $f(t-u)/f(t)$ 随 $t$ 递增，卷积恰是这些平移比的正权积分。增加 $t$ 时积分还纳入新的正项。

原差值在 $N$ 下平均为零。改用递增密度比加权，差值的后段负部得到更大权重。因此
$$D=E H(N+E_0)\le E e^{-\lambda(N+E_0)}=\frac{A}{1+\lambda}.$$
再由独立指数变量的 Laplace 变换
$$A=\prod_i (1+\lambda d_i)^{-1}\ge(1+\lambda)^{-r}$$
即证。第一步只有当 $P$ 本身服从指数分布时取等，也就是恰有一个正项。第二步只有所有 $d_i=1$ 时取等。其余边界情形直接由 $K,\Delta K$ 的概率公式处理。

同样可以完成原文提出的逐输入压缩。保持负项之和 $N$ 不变，记其 Laplace 变换为 $L$。选择 $\lambda_*$ 使 $L(\lambda_*)/(1+\lambda_*)=D$。上面的比较给出 $\lambda_*\ge\lambda$，因此把所有正项替换为一个均值 $1/\lambda_*$ 的指数变量，保留 $K$ 且使 $\Delta K=L(\lambda_*)-D$ 不增。有多个正项且负项非空时，公共系数严格下降。

## 3. 范围

原文定理 25 已覆盖恰有一个大于一坐标的特殊情形。这里证明的是逐输入的全维度确定性不等式。Gaffke 检验在独立数据下的有限样本有效性是另一个问题，已由 Vlassis 与 Thomas 证明。复算脚本检查了 2,994 个有理输入，并用独立的部分分式算法交叉核验 1,075 个输入。

## 参考文献

- Haben Michael. *Results relating to a conjecture on the validity of a certain hypothesis test*. 预印本，猜想 2. [全文](https://haben-michael.github.io/preprints/gaffke.pdf)
- András Prékopa. *On logarithmic concave measures and functions*. 1973. [论文](https://rutcor.rutgers.edu/~prekopa/LOGCON.pdf)
- Nikos Vlassis and Philip S. Thomas. *An exact distribution-free test for means of nonnegative random variables*. 2026. [全文](https://arxiv.org/pdf/2607.08415)
