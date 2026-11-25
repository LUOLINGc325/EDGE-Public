# 临界覆盖约束的精确已知分布代价

研究稿 · 2026-11-24 · 面向概率与统计学博士研究生。

## 摘要

在线预测若须对所有数据序列逐轮限制累计漏报误差，即便已知真实分布，也必须在误差接近边界时调整预测。Gui、Barber 与 Ma 证明了临界平方根边界下的平方根代价阶。本稿确定其中已知分布子问题的精确系数，涵盖不对称边界。系数只依赖截断正态密度在两个端点的取值。

## 问题和结论

沿用 [1] §2 和附录 A 的漏报位、精确预言机和逐路径可行性定义。目标漏报率为 $\alpha\in(0,1)$。要求在线预测器在每条数据序列上满足

$$
-L_t\le \sum_{r\le t}(e_r-\alpha)\le U_t,\qquad
L_t=c_- t^{1-\beta_-},\quad U_t=c_+ t^{1-\beta_+},
$$

其中 $c_-,c_+>0$、$c_-+c_+\ge1$、$\beta_-,\beta_+\in[1/2,1]$ 且 $\min(\beta_-,\beta_+)=1/2$。令 $\sigma^2=\alpha(1-\alpha)$、$a=-\lim L_t/\sqrt t$、$b=\lim U_t/\sqrt t$，并写 $C=b-a>0$、$M=(a+b)/2$。定义

$$
f(x)=\frac{\exp(-x^2/(2\sigma^2))}
 {\int_a^b\exp(-y^2/(2\sigma^2))\,dy},\qquad a\le x\le b.
$$

**定理。** 已知真实分布且存在逐轮条件精确预言机时，满足约束的算法与任一精确预言机之间的最优累计预期分歧 $V_T$ 满足

$$
\lim_{T\to\infty}\frac{V_T}{\sqrt T}=\sigma^2\bigl(f(a)+f(b)\bigr).
$$

对称边界的系数为 $2\sigma^2\exp(-\kappa^2/(2\sigma^2))/\int_{-\kappa}^{\kappa}\exp(-x^2/(2\sigma^2))\,dx$。未知分布问题中的最小最大风险至少为 $V_T$。

## 逐路径最优截断

固定精确预言机的二进制漏报位 $B_t$。它们独立同分布且服从 Bernoulli$(\alpha)$，因为每一位给定过去的概率恒为 $\alpha$。令 $a_t=\lceil\alpha t-L_t\rceil$、$b_t=\lfloor\alpha t+U_t\rfloor$，定义 $K_0=0$ 和

$$
K_t=\operatorname{clip}_{[a_t,b_t]}(K_{t-1}+B_t).
$$

整数走廊区间非空，$b_t\ge b_{t-1}$ 且 $a_t\le a_{t-1}+1$，故截断输出具有二进制增量。如果两种增量均可行，就采用参考预言机的预测集。只有一种可行时，用全空间或空集实现。令 $O_t$ 为输入累计量，$r_t=K_t-O_t$，则 $r_t$ 是 $r_{t-1}$ 向 $[a_t-O_t,b_t-O_t]$ 的投影。对任何对照的可行改变量 $q_t$，投影的线段恒等式给出

$$
|r_t-r_{t-1}|+|r_t-q_t|\le |r_{t-1}-q_{t-1}|+|q_t-q_{t-1}|.
$$

从共同初值零求和，截断累计改动不超过任何可行对照。这给出逐路径最优性，也给出未知分布时的下界。下文的 $V_T$ 即此截断的期望代价。投影框架详见 [3]，本文用它识别原统计问题的已知分布风险。

## 末态的反射扩散极限

记 $E_t=K_t-\alpha t$。固定 $0<\varepsilon<1$，在 $r=\lfloor\varepsilon T\rfloor$ 从最接近 $\alpha r$ 的可行整数重新启动。替代初值的中心化偏差绝对值至多 1。共用后续输入时，一步投影对初值为 1-Lipschitz，所以两个终点相差至多 $\max(L_r,U_r)+1$，归一化后不超过 $O(\sqrt\varepsilon)+o(1)$。

按 $T$ 缩放时间、按 $\sqrt T$ 缩放空间。在区间 $[\varepsilon,1]$，中心化整数边界的步函数一致趋于 $a\sqrt s,b\sqrt s$。取初值在时刻 $\varepsilon$，随后以独立二进制位定义重启后的增量步函数。Donsker 不变原理给出缩放后的自由输入趋于从零开始的 $\sigma$ 倍布朗运动。Burdzy–Kang–Ramanan [2] 的显式双边 Skorokhod 映射在阶梯输入处等于每次跳跃的投影，且在本处连续极限下对输入与两边界一致连续。连续映射定理给出重启过程趋于在 $[a\sqrt s,b\sqrt s]$ 中反射的过程 $X_s$。固定 $\varepsilon$ 时带宽有正下界，普通反射项具有有限变差。

取 $s=\varepsilon\exp(v)$ 与 $R_v=X_s/\sqrt s$。伊藤公式和确定性时间变换给出固定区间 $[a,b]$ 内的反射 Ornstein–Uhlenbeck 方程

$$
dR_v=\sigma\,dW_v-\tfrac12 R_v\,dv+dJ^-_v-dJ^+_v.
$$

反射项只在相应端点增加。用带 Neumann 边界条件的生成元作分部积分，验证 $f$ 是平稳密度。若两条解共享布朗输入，差的平方没有随机微分项，各反射项对平方差的贡献均非正，漂移给出

$$
|R_v-\widetilde R_v|\le e^{-v/2}|R_0-\widetilde R_0|.
$$

把第二条解从平稳密度启动，在 $v=\log(1/\varepsilon)$ 得到 $O(\sqrt\varepsilon)$ 的期望耦合距离。先令 $T$ 趋于无穷，再令 $\varepsilon$ 趋于零，便有 $E_T/\sqrt T\Rightarrow f$。归一化状态一致有界，因此一阶和二阶矩也收敛。

## 从末态矩到代价

令 $D_t=L_t+U_t$、$m_t=(U_t-L_t)/2$、$\rho_t=m_t-m_{t-1}$、$H_t=E_t-m_t$、$h_t=\mathbb EH_t^2$，并记 $d_t$ 为第 $t$ 轮实际改动的概率。初值均取零。对每一步比较实际误差位与 $B_t$，展开平方给出

$$
h_t-h_{t-1}=\sigma^2-2\rho_t\mathbb EH_{t-1}+\rho_t^2-D_t d_t+\epsilon_t,
\qquad |\epsilon_t|\le d_t.
$$

为核对最后两项，修正差值为 $\delta_t=e_t-B_t$。展开后它的乘子是 $2(E_{t-1}-m_t)+1-2\alpha$。上边界改动为 $\delta_t=-1$，只能在 $U_t-(1-\alpha)<E_{t-1}\le U_t$ 时发生。下边界改动为 $\delta_t=1$，只能在 $-L_t\le E_{t-1}<-L_t+\alpha$ 时发生。两种情形的乘积与 $-D_t$ 相差至多 1，未改动时为零。

设 $\mu=\int_a^b x f(x)\,dx$、$v_f=\int_a^b (x-M)^2f(x)\,dx$。前节给出 $h_t/t\to v_f$。由幂函数边界，

$$
D_t\sim C\sqrt t,\qquad D_{t+1}-D_t\sim\frac{C}{2\sqrt t},\qquad
\sqrt t\,\rho_t\to M/2,\qquad
\mathbb EH_{t-1}/\sqrt t\to\mu-M .
$$

先用 $D_t-1>0$ 除上式的代价上界。对势函数差采用递减正权重 $1/(D_t-1)$ 作分部求和，势函数和除固定初端项之外皆非负。其余每步非势函数项绝对值有界，故 $\sum_{t\le n}d_t=O(\sqrt n)$。用二进块求和随即得到 $\sum_{t\le T}d_t/D_t=O(\log(2T))$。

再用 $D_t$ 除原等式并求和。分部求和的末端项 $h_T/D_T$ 渐近 $v_f\sqrt T/C$，权重差和的首项同样为 $v_f\sqrt T/C$。利用上述误差估计与中点极限，得到

$$
\lim_{T\to\infty}\frac{V_T}{\sqrt T}
  =\frac{2}{C}\bigl[\sigma^2-M(\mu-M)-v_f\bigr]
  =\frac{2}{C}\left[\sigma^2-\int_a^b x(x-M)f(x)\,dx\right].
$$

以 $f'(x)=-xf(x)/\sigma^2$ 计算 $((x-M)f(x))'$ 的积分，右式化为 $\sigma^2(f(a)+f(b))$，定理得证。

## 验证范围

原文 [1] 已将模型降为 Bernoulli 漏报位走廊，并用二次势函数得到数量级。本稿用尺度变换后的反射过程识别临界精确常数。Python 有限递推可精确重算若干对称实例的成本，以便区分离散边界取整效应和连续极限。未知分布的统计学习代价与约束代价在临界点同阶，其精确首项不在本定理范围内。

## 参考文献

1. Gui、Barber 与 Ma，*The cost of enforcing long-run coverage: a phase transition in online conformal prediction*，§1.4、§2、附录 A 与 C。https://arxiv.org/html/2611.21542v1
2. Burdzy、Kang 与 Ramanan，*The Skorokhod problem in a time-dependent interval*，Theorem 2.6、Proposition 2.9。https://arxiv.org/abs/0712.2863
3. Łochowski 与 Ghomrasni，*The play operator, the truncated variation and the generalisation of the Jordan decomposition*。https://doi.org/10.1002/mma.3077
