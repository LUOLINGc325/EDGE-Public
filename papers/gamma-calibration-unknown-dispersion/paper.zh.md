# 未知离散度下 Gamma 均值检验的有限样本条件似然

## 摘要

考察 Delong 与 Wüthrich [1] 式 (B.1) 把同一个训练离散度估计代入分样本似然比的有限样本影响。在指数离散族中，精确零假设期望由累积函数的外推差给出。对 Gamma 例，离散度低估可使期望发散，并使标称 $5\%$ 检验的实际错误率超过 $20\%$。给定每个验证观测的无符号单位离差，其高、低两支的零假设条件概率不含离散度。用它归一化同一个训练指数倾斜，得到对任意未知形状参数有限样本有效、无需剖面极大化的条件 e 值。Gamma 均值模型在零假设处的全部一阶 Fisher 信息仍保留。

## 1. 原式代入离散度的精确效果

以 [1] 的记号，训练集固定后，验证观测 $Y_i$ 相互独立，在零假设下属于基准正则指数离散族，已知预测的正则参数为 $\theta_i$、暴露权 $v_i>0$，未知真实离散度 $\phi>0$。验证的是原文条件均值正确设定，或在其 EDF 和排序假设下等价的校准零假设。训练拟合的替代参数为 $\xi_i$，令 $\Delta_i=\xi_i-\theta_i$。式 (B.1) 对每个观测的比值是
$
 E_i^{\mathrm{plug}}
 =\exp\left(\frac{v_i}{\widehat\phi}
       \{Y_i\Delta_i-\kappa(\xi_i)+\kappa(\theta_i)\}\right).
\tag{1}
$
若 $u=\phi/\widehat\phi$，指数族的矩生成公式给出
$
 \log\mathbb{E}_0[E_i^{\mathrm{plug}}\mid{\mathrm{train}}]
 =\frac{v_i}{\phi}
  \{\kappa(\theta_i+u\Delta_i)-\kappa(\theta_i)
      -u[\kappa(\xi_i)-\kappa(\theta_i)]\}.
\tag{2}
$
这里还条件于验证设计。若外推参数在矩生成有效域之外，即该指数矩发散时，取 $+\infty$。对非平凡 $\Delta_i$，严格凸性使右端在 $0<u<1$ 时负，在 $u=1$ 时零，在 $u>1$ 时正或发散。乘积的条件期望也是各期望的乘积。也就是说原样代入在离散度低估时失去条件 e 值保证。训练一致性不提供有限样本保护。[1] 附录 B 定理 7 有额外假设的渐近保证，另提出 (B.6) 的零假设剖面分母以恢复有限样本控制。

为定量说明，考虑一个验证观测 $R=Y/\mu$，零假设下 $R\sim\mathrm{Gamma}(k,\mathrm{rate}=k)$，$k=v/\phi$。替代均值设为 $d\mu$，$d>0$，$\widehat k=v/\widehat\phi$。代入比值为 $d^{-\widehat k}\exp(\widehat k(1-1/d)R)$，其零假设均值是
$
 d^{-\widehat k}
 \left(1-\frac{\widehat k}{k}(1-1/d)\right)^{-k}
$
，只在括号严格为正时有限。若 $d>1$，训练事件
$\widehat\phi\le\phi(1-1/d)$ 有正概率时，非条件均值已发散。取 $k=1,\ \widehat k=100,\ d=2$，用 e 检验的标准阈值 $20$。由于 $R$ 是单位指数变量，实际零假设拒绝概率为
$
 \mathbb{P}_0(E_i^{\mathrm{plug}}\ge 20)
 =\tfrac14\,20^{-1/50}>\tfrac15>\tfrac1{20}.
\tag{3}
$
因为 $(5/4)^5>3$，所以 $(5/4)^{50}>20$，给出第一个严格不等式。此例只固定一个训练规则的输出，无须选择验证分支来放大误差。
 
也可直接用原训练的保序回归得到无条件反例。取两个独立单位指数观测，预测都为 1，一训一验。训练拟合的相对均值 $d$ 就是训练观测，且令该样本量的 $\widehat\phi=1/100$。例如在较大训练样本改用截在 $1/100$ 以上的标准化平方残差均值，就得到在真实 $\phi=1$ 下的一致序列。若 $1/4\le d\le3/4$，验证拒绝界为
$
 R_{\mathrm{val}}<\frac{-\log d-\log(20)/100}{1/d-1}.
$
其中 $-d\log d/(1-d)$ 随 $d$ 递增，故右端大于
$\log4/3-3\log20/100>4/9-3/25>3/10$。于是训练落在上述区间且 $R_{\mathrm{val}}\le3/10$ 时必拒绝。用指数函数的交错级数与独立性得零假设实际拒绝概率下界
$
 \tfrac12 e^{-3/4}(1-e^{-3/10})
 \ge \frac{59}{256}\frac{51}{200}
 =\frac{3009}{51200}>\frac1{20}.
$
这里训练均值不是固定常数，确实由单个训练响应作保序拟合。

## 2. 按无符号单位离差条件化

设验证零假设为 $R_i=Y_i/\mu_i \sim\mathrm{Gamma}(k_i,\mathrm{rate}=k_i)$，其中每个 $\mu_i>0$ 是已固定预测，且 $k_i>0$ 未知，可因个体而异。设
$
 D=R-1-\log R,\qquad S=\mathbf1_{\{R>1\}}.
$
函数 $r-1-\log r$ 在 $r<1$ 递减，在 $r>1$ 递增，并在两侧分别覆盖全体 $d>0$。对 $D=d$，两个根为 $r_-(d)<1<r_+(d)$。零假设密度可写成 $C(k)\,r^{-1}e^{-kd}$，因为 $r^k e^{-kr}=e^{-k(d+1)}$。变量变换后两支的密度贡献正比于 $1/|r_\pm-1|$。由此
$
 p(d)=\mathbb{P}_0(S=1\mid D=d)
     =\frac{1-r_-(d)}{r_+(d)-r_-(d)},\qquad
 \mathbb{E}_0[R\mid D=d]=1 .
\tag{4}
$
连续 Gamma 变量有 $D>0$ 几乎必然成立。若输入恰为 $R=1$，下列规则可把该项定义为 1。对独立观测，给定全部 $D_i$，相应 $S_i$ 为相互独立的 Bernoulli 变量，参数由式 (4) 给出。甚至可在固定设计、训练数据下混合任意联合潜在形状向量 $(k_i)_i$，只要在给定它时原观测独立且零假设均值不变。混合前条件符号规律完全相同，故混合后也保持。

令 $\widehat d_i=\widehat\mu_i^{\mathrm{alt}}/\mu_i>0$ 为训练得到的相对均值，$\widehat\beta_i=(v_i/\widehat\phi)(1-1/\widehat d_i)$。记 $g_i=r_+(D_i)-r_-(D_i)>0$。直接以式 (4) 的条件期望归一化式 (1)，给
$
 E_i^{\mathrm{cond}}
 =\frac{\exp(\widehat\beta_i g_i S_i)}
         {1-p(D_i)+p(D_i)\exp(\widehat\beta_i g_i)} .
\tag{5}
$
这是条件 Bernoulli 似然比，即把零假设对数胜算加上 $\widehat\beta_i g_i$。对任意有限的训练输出 $\widehat\beta_i$，式 (5) 在给定 $D_i$ 的零假设期望精确为 1。验证乘积在给定训练集、验证设计、全体 $D_i$ 后期望亦为 1。因而 Markov 检验阈值 $1/\alpha$ 有准确的有限样本水平上界。对独立或重叠数据划分的固定加权平均仍保持 e 值，只要求各划分自身的训练与验证满足上述条件。本法检验的是给定设计和预测下的 Gamma 均值；只给均值而不假定 Gamma 或同均值的 Gamma 形状混合，式 (4) 不自动成立。

## 3. 功效、局部信息及实现

若真正替代均值为 $d_i^*\mu_i$，同一形状 $k_i$ 下原始替代/基准密度比为 $(d_i^*)^{-k_i}\exp(\beta_i R_i)$，其中 $\beta_i=k_i(1-1/d_i^*)$。给定 $D_i$，真实的对数胜算改变量便是 $\beta_i g_i$。在任意固定 $D_i$ 下，知道该条件分布的式 (5) 最大化真实替代下的条件期望对数 e 值。任意拟合的损失是两个 Bernoulli 参数之间的相对熵，由 $\log(1-p+p e^\eta)$ 的二阶导数不大于 $1/4$ 得上界
$
 \text{条件期望对数损失}\ \le\
       (\widehat\beta_i-\beta_i)^2 g_i^2/8 .
\tag{6}
$
这一比较区分离散度估计的功效影响与所构造 e 值的有效性。

固定单个已知或未知形状 $k_i$，以真正均值对数相对变化 $z=\log d_i^*$ 参数化替代。零假设的完整数据均值得分是 $k_i(R_i-1)$。条件胜算的导数给条件得分 $k_i g_i (S_i-p(D_i))$，由式 (4) 它等于同一个 $k_i(R_i-1)$。因此对 $D_i$ 再取期望后的条件 Fisher 信息为 $k_i^2\operatorname{Var}_0(R_i)=k_i$，与完整数据在该点的均值信息相同。这个结论是局部的，未比较有限偏离下两法的全量功效。

实现可用单调根查找。若 $g=r_+-r_-$，相等离差给 $g=\log(r_+/r_-)$，因此
$
 r_-=\frac g{e^g-1},\qquad r_+=\frac g{1-e^{-g}},\qquad
 p=\frac1g-\frac1{e^g-1}.
$
等式提供稳定的替代参数化。固定正样本 $R$ 所在的分支，另一支由同一离差唯一决定。数值实现使用对数 e 值与稳定的指数运算。

## 参考文献

1. L. Delong and M. Wüthrich, *Universal Inference for Testing Calibration and Specification of Mean Estimates within the Exponential Dispersion Family*, arXiv:2510.23821v2 (2026), §2、§5.3.6 及 Appendix B, Eqs. (B.1), (B.6).
2. Larry Wasserman, Aaditya Ramdas, and Sivaraman Balakrishnan, *Universal inference*, Proceedings of the National Academy of Sciences 117, 16880–16890 (2020). DOI 10.1073/pnas.1922664117.
3. Augustine Wong, *Comparing Several Gamma Means: An Improved Log-Likelihood Ratio Test*, Entropy 25, 111 (2023). DOI 10.3390/e25010111.
