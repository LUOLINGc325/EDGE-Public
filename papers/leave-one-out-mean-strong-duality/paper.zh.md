# 非参数均值检验的留一强对偶与有限网格计算

## 摘要

Zhu 与 Duchi 用点态乘子证书控制非负样本的留一条件均值原假设，并没有断言强对偶。本文证明，对于任意有界上半连续收益，最坏情形期望等于使用非负、有界、连续乘子的点态对偶值，而且存在最不利联合分布。对任意坐标单调增加的 Borel 拒绝域，强对偶无需闭性，并给出带显式误差的有限网格线性规划。

## 1. 连续样本空间上的强对偶

记 $\mathcal N=\{P:E_P[X_i\mid X_{-i}]\le1,\ i=1,\ldots,n\}$，样本坐标非负，允许依赖。若 $f$ 有界且上半连续，则
$$
\max_{P\in\mathcal N}E_Pf
=\inf_{\lambda_i\in C_b^+}\sup_{x\ge0}
\left[f(x)-\sum_i\lambda_i(x_{-i})(x_i-1)\right].
$$
留一条件恰等价于对每个非负有界连续乘子的积分约束。总一阶矩不超过 $n$ 的测度集合在弱拓扑下紧，乘子积分是下半连续的，故可应用 Sion 极小极大定理。固定乘子后，将总一阶矩上界记为 $s$，最优值为有限、单调不减的凹函数。在 $s=n$ 处取支撑斜率，并将同一个非负斜率加到每个乘子，可将紧矩约束中的分布上确界替换成整个样本空间的点态上确界。

## 2. 单调拒绝域的有限精度界

设 $R$ 为坐标单调增加的上集，$v(R)$ 为其最坏拒绝概率。取网格 $G=\{0,a,\ldots,M\}$，其中 $M/a$ 是正整数。若 $v_G(R)$ 是同一问题限制在 $G^n$ 的最优值，则
$$
v_G(R)\le v(R)\le\min\{1,(1+a)^n v_G(R)+n/M\},
\qquad v(R)-v_G(R)\le na+n/M.
$$
将各坐标向上取整并截断，再独立地以概率 $a/(1+a)$ 把各坐标置零，所得联合分布仍满足留一条件。在未截断且各坐标均保留时，原拒绝事件因单调性被保留。截断概率至多 $n/M$。用小量平移替代取整也说明 $v(R)=v(\overline R)$，因此不闭的单调拒绝域具有相同强对偶。

对 $R=\{\max_i x_i\ge c\}$、$c>1$，最坏概率恰为 $1-(1-1/c)^n$。独立的 $\{0,c\}$ 两点分布达到等号，截断线性函数的乘积给出同值点态证书。$n=3,c=5$ 时最优值为 $61/125$。

## 参考文献

- Yifan Zhu and John C. Duchi. *Finite-sample nonparametric mean tests: Leave-one-out duality and asymptotic optimality*. arXiv:2609.05360v1. <https://arxiv.org/abs/2609.05360>
- Maurice Sion. *On general minimax theorems*. Pacific Journal of Mathematics 8(1), 1958.
