# 错报外部矩时的保形预测覆盖偏差

## 摘要

矩校准保形预测用经验似然权重匹配外部给定的矩。如果该矩与校准和测试总体不一致，覆盖率会偏多少？我们得到依赖错报方向的明确一阶偏差，及无需分数密度下界的二次余项。对任意分布的最坏一阶系数是 $\sqrt{\tau(1-\tau)}$，其中 $\tau$ 是名义覆盖率，矩误差以协方差白化后计量。一个均匀分数和二元矩的模型达到此系数。另有基于二元相对熵的有限样本覆盖区间，直接适用原论文的权重和分位数。

## 1. 模型与目标

[1, §2.1] 用经验似然选择正权重，使校准数据的加权矩符合给定外部矩。其 [§7] 提出量化外部矩错报的覆盖影响。这里考察主文的单分数边际校准，校准、测试来自同一总体，训练完成后分数固定。设该总体为 $P$，分数 $S$ 的分布函数为 $F$；侧信息为随机向量 $H$，均值 $\mu$、正定协方差 $\Sigma$。令
$
 X=\Sigma^{-1/2}(H-\mu),\quad
 \delta=\Sigma^{-1/2}(m-\mu),\quad
 \rho=\|\delta\|,\quad
 \|X\|\le B\text{ 几乎处处},
$
其中 $m$ 是外部所报的均值。于是 $E_P X=0$，$E_P XX^\mathsf T=I$，且可取 $B\ge1$。有限样本中把 $P$ 改为 $n$ 个校准指标上的均匀分布，$\mu,\Sigma,B$ 改为相应经验量。

把经验似然推广到总体，定义 $Q_\delta$ 为在概率 $Q=wP$、$E_Q X=\delta$ 下使 $D(P\|Q)=-E_P\log w$ 最小的分布。有限样本时，这与 [1] 最大化对数权重之和完全相同，因要最小化的目标只与其相差一个乘数与常数。令 $q_{\delta,\tau}$ 是 $Q_\delta$ 下分数的下 $\tau$ 分位数，$0<\tau<1$。

## 2. 二元熵覆盖区间

记
$
 k(p,q)=p\log(p/q)+(1-p)\log((1-p)/(1-q)),\qquad
 \mathcal I(q,\kappa)=[L(q,\kappa),U(q,\kappa)]
  =\{p\in[0,1]:k(p,q)\le\kappa\}.
$
端点按连续极限解释。若 $B\rho<1$，则 $w_0=1+\delta^\mathsf T X$ 是严格正的可行权重。其可行性由 $E XX^\mathsf T=I$ 直接得到。只要经验似然投影存在，就有
$
 D(P\|Q_\delta)
 \le -E\log(1+\delta^\mathsf T X)
 \le \frac{\rho^2}{2(1-B\rho)}
 =:\kappa .
 \tag{1}
$
最后一步展开 $-\log(1+t)+t$ 并用 $\sum_{j\ge2}|t|^j/j\le t^2/(2(1-B\rho))$，再用 $E t=0,E t^2=\rho^2$。在有限样本中，可行的严格正权重及对数目标靠近边界时发散保证最优解存在。在总体上，第 3 节在 $B\rho\le1/8$ 构造唯一投影。式 (1) 对任意具有这一正可行比较和最优解的模型有效。

若 $S$ 无原子，$Q_\delta\ll P$ 也无原子，故 $Q_\delta(S\le q_{\delta,\tau})=\tau$。对事件 $S\le q_{\delta,\tau}$ 使用二元映射的相对熵单调性即得
$
  F(q_{\delta,\tau})\in\mathcal I(\tau,\kappa).
  \tag{2}
$
该单调性也可直接在事件和补集上分别使用 $-\log$ 的 Jensen 不等式。保留 $\tau$ 的二元熵形式，避免对高覆盖率使用不依赖水平的总变差常数。

有限样本时，令 $\widehat\rho=\|\widehat\Sigma^{-1/2}(m-\bar H)\|$，$\widehat B=\max_i\|\widehat\Sigma^{-1/2}(H_i-\bar H)\|$，并以相应参数给出 $\widehat\kappa$。论文使用名义级 $\tau_n=(n+1)(1-\alpha)/n$。若 $0<\tau_n<1$、分数无并列、$\widehat\Sigma$ 正定且 $\widehat B\widehat\rho<1$，则其分位数 $\widehat q$ 满足确定性结论
$
 L(\tau_n,\widehat\kappa)
 \le F_n(\widehat q)
 \le U(\tau_n,\widehat\kappa)+\frac1n.
 \tag{3}
$
第一侧取事件 $S\le\widehat q$；其投影概率至少 $\tau_n$。若经验概率低于 $\tau_n$，对第二变量单调性使二元熵仍不超过 $\widehat\kappa$。第二侧取 $S<\widehat q$；其投影概率低于 $\tau_n$。同样的单调性控制经验左极限，上加无并列时的 $1/n$ 跳幅得到 (3)。加入 Dvoretzky–Kiefer–Wolfowitz 界，得到对真实测试覆盖率的有限样本陈述。在概率至少 $1-\gamma$ 的 DKW 事件上，只要上述数据条件成立，
$
  L(\tau_n,\widehat\kappa)-\sqrt{\log(2/\gamma)/(2n)}
  \le F(\widehat q)
  \le U(\tau_n,\widehat\kappa)+1/n+\sqrt{\log(2/\gamma)/(2n)}.
  \tag{4}
$
所有概率条件在训练阶段固定后解释。DKW 事件只涉及未加权分数，故即使外部矩估计依赖于校准数据，(4) 对该事件上所有通过明示条件的目标同时有效。

## 3. 总体投影与有向覆盖偏差

当 $B\rho\le1/8$ 时，置 $Y=X-\delta$，令 $\lambda$ 最大化
$
 \Phi(\lambda)=E_P\log(1+\lambda^\mathsf TY)
$
在半径 $2\rho$ 的闭球上。若 $\rho=0$，直接取 $\lambda=0$。否则此球内 $|\lambda^\mathsf TY|\le2\rho(B+\rho)\le9/32$。在球面，
$
 \lambda^\mathsf T\nabla\Phi(\lambda)
 =-\lambda^\mathsf T\delta-E\frac{(\lambda^\mathsf TY)^2}{1+\lambda^\mathsf TY}
 \le 2\rho^2-\frac{4\rho^2}{1+9/32}<0 .
$
因此极大点在内部。Hessian 为负定，因为 $E YY^\mathsf T=I+\delta\delta^\mathsf T$，故解唯一。设 $w=(1+\lambda^\mathsf TY)^{-1}$，一阶条件给 $EwY=0$，并由 $w=1-w\lambda^\mathsf TY$ 得 $Ew=1$。任一可行的 $w'$ 满足
$
 E\log(w'/w)\le E(w'/w)-1
             = E[w'(1+\lambda^\mathsf TY)]-1=0 .
$
因此 $w$ 是所需的唯一投影。若某竞争权重在正概率集为零，对数目标为负无穷，同样被覆盖。

令
$
 A_\lambda=E\frac{YY^\mathsf T}{1+\lambda^\mathsf TY}.
$
一阶条件等价于 $\delta=-A_\lambda\lambda$。由 $|\lambda^\mathsf TY|\le(9/4)B\rho$ 和 $1+\lambda^\mathsf TY\ge23/32$，
$
 \|A_\lambda-I\|
 \le \rho^2+\frac{(9/4)B\rho}{1-9/32}(1+\rho^2)
 \le4B\rho.
$
从而 $\|\lambda+\delta\|\le8B\rho^2$。恒等式
$
 w-1-\delta^\mathsf TX
  =-(\lambda+\delta)^\mathsf TX+\lambda^\mathsf T\delta+
       \frac{(\lambda^\mathsf TY)^2}{1+\lambda^\mathsf TY}
$
对任意 $0\le g\le1$ 给出
$
  \big|E_Qg-E_Pg-\delta^\mathsf T E_P[Xg]\big|
    \le17B\rho^2.
 \tag{5}
$
三项分别用 $8B\rho^2,2\rho^2,7\rho^2$ 控制。首项由协方差归一化和 Cauchy–Schwarz，末项由 $E YY^\mathsf T$ 的公式。

设 $S$ 无原子，记 $q_{0,\tau}$ 为真实未加权分位数，$q=q_{\delta,\tau}$。令 $C_\delta=F(q)$。在 (5) 取 $g=1(S\le q)$，其 $Q$ 期望为 $\tau$。由 $EX=0$ 和 Cauchy–Schwarz，
$\|E[Xg]\|\le\sqrt{C_\delta(1-C_\delta)}\le1/2$。因此 $|C_\delta-\tau|\le3\rho$。两个嵌套阈值的差满足
$
  \|E[X1(S\le q)]-E[X1(S\le q_{0,\tau})]\|
   \le B |C_\delta-\tau|.
$
由此得到有向覆盖偏差
$
  \left|C_\delta-\tau+\delta^\mathsf T E[X1(S\le q_{0,\tau})]\right|
    \le 20B\rho^2,
 \tag{6}
$
以及一阶系数上界 $\sqrt{\tau(1-\tau)}$。该论证只用无原子分数，不要求分位点密度存在或有正下界。若错报方向与该矩向量正相关，领先阶覆盖率下降。

此外，投影族在此邻域的准确微分可写为：设 $R_\delta$ 是密度正比于 $w^2$ 的相对 $P$ 分布，则对方向 $\eta$
$
  \frac{d}{dt}Q_{\delta+t\eta}(g)\bigg|_{t=0}
  =\operatorname{Cov}_{R_\delta}(g,X)^\mathsf T
      \operatorname{Cov}_{R_\delta}(X)^{-1}\eta.
 \tag{7}
$
证明是把 $w$ 写成 $(c+b^\mathsf TX)^{-1}$。归一化和矩方程的参数 Jacobian 为负的 $E_P[w^2(1,X^\mathsf T)^\mathsf T(1,X^\mathsf T)]$，它正定至负号，故隐函数定理适用。微分后用归一化等式消去截距，再用矩导数求解斜率，即得 (7)。

## 4. 最坏一阶系数的达到

取 $S\sim U[0,1]$，$H=1(S\le\tau)$，所以 $\mu=\tau,\Sigma=\tau(1-\tau)$。若报告 $m=\tau+d$，最优投影在两分数区内分别均匀，且第一分区质量为 $m$。可由给定分区质量时最大化对数权重得到。于是
$
 C_\delta=
 \begin{cases}
   \tau^2/(\tau+d),&d\ge0,\\
   \tau-d(1-\tau)/(1-\tau-d),&d<0 .
 \end{cases}
$
两侧 $C_\delta-\tau=-d+O(d^2)$，而 $\rho=|d|/\sqrt{\tau(1-\tau)}$。因此一阶系数达到 (6) 的最坏上界，且一侧确实发生低覆盖。证书用有理数计算该例的覆盖率，并通过对数级数的外包尾界认证 (1)–(2) 的具体实例。

## 参考文献

1. Guanghui Wang, Liuhua Peng, Liu Liu, Changliang Zou, *Moment-Calibrated Conformal Prediction with Side Information*, arXiv:2610.15268v1. [全文](https://arxiv.org/html/2610.15268v1)。同一问题见 §7，原算法见 §2.1。
2. A. B. Owen, *Empirical likelihood ratio confidence intervals for a single functional*, Biometrika 75(2), 237–249, 1988. [DOI](https://doi.org/10.1093/biomet/75.2.237)。
3. P. Massart, *The tight constant in the Dvoretzky–Kiefer–Wolfowitz inequality*, Annals of Probability 18(3), 1269–1283, 1990. [DOI](https://doi.org/10.1214/aop/1176990746)。
