# 共轭目标分布下更新型随机重置的全局最优性与唯一性

*布朗搜索的精确非负差额恒等式*

AI 辅助研究稿

2026 年 11 月 24 日

# 摘要

对于目标位置未知、但在整次搜索中保持固定的布朗搜索，Evans 与 Ray 提出了与给定重置等待时间分布共轭的目标分布。他们的第一变分计算证明了驻点条件；作者稿明确将全局最小性的确认留给两个分布族内的数值检查。本文在一维情形中补齐这一环节，允许竞争分布为正且有限的重置等待时间上的任意概率分布，包括含原子的分布以及均值无穷的分布。利用正的对称积分核，我们将更新过程的平均完成时间改写为一个精确的非负平方恒等式。当参考分布对应的共轭平均完成时间有限时，该参考分布是唯一最优解；当其共轭能量无穷时，所有竞争的更新型重置分布的平均完成时间均为无穷。本文还给出局部定量稳定性界，并将结果推广到在明确外域中定义的球形吸收目标。在参考能量有限时，这些结果在各个所述维度证明成功概率剖面的唯一性，并在一维与三维证明重置等待时间分布本身的唯一性。本文讨论独立同分布的更新型重置，不涉及自适应控制或依赖绝对时间的控制。

**状态（2026 年 11 月 25 日）。** 本文为附有书面证明的研究稿。文献比较范围有限：Chechkin–Sokolov [3] 的正文和补充仍未取得，未作逐定理排除。本文证明自足，不依赖其未读内容；不宣称全球优先权、外部同行评议或 Lean 认证。本版本未附全文形式化证明。

# 1. 研究问题、成果归属与适用范围

重启可以使搜索者离开长时间没有进展的探索路径。重置等待时间分布规定每次尝试最多允许持续多久。当目标距离固定且已知时，确定性重启具有一般性的最优性结论 [2]。目标只抽样一次、随后保持固定时，优化问题则有所不同：必须先形成给定目标位置下的更新均值之比，再对目标位置取平均。

Evans 与 Ray [1] 提出，将单次尝试的成功概率剖面平方并归一化，可得到一个共轭目标分布。他们的推导证明了驻点条件。作者版本在式 (15) 后指出（译）：

> 但仍需确认 ψ(τ) 使式 (1) 取得最小值，因而确实是最优的。

即仍需确认该分布确实使目标函数取得最小值。其后的数值检查将竞争分布限制在两个参数化分布族内。本文研究的问题是：在同一个更新型重置类别中，能否对所有可容许竞争分布证明这一比较结论。

本文的贡献是证明该全局比较、刻画等号条件，并处理目标函数可以取无穷值的边界情形。共轭构造、更新均值之比、指数与确定性分布的例子，以及随机重置可以优于周期重置的发现，均属于已有工作。对称化、配方、Laplace 变换唯一性以及基态型表示 [6] 是已有数学方法；本文不宣称发明了这些方法。这里实质性的联系是一个正的空间积分核，它将布朗运动单次尝试的时间成本与成功概率剖面联系起来。

主定理针对一维情形。第 7 节单独给出径向推广，并明确要求目标中心到重置点的距离严格大于目标半径。全文均假设：目标只抽样一次；各次重置等待时间与布朗运动尝试相互独立；每次重置瞬时完成且没有额外成本；每次尝试重复使用同一个等待时间分布。这个共同分布的风险率可以随本次尝试已经持续的时间而变化，但不能依赖尝试次数、此前失败、已观察到的路径或绝对经过时间。

# 2. 模型与精确定理

固定扩散系数 $D>0$。布朗运动的生成元为 $D\,d^2/dx^2$，因此其位移方差为 $2Dt$。对于距离为 $x>0$ 的目标，记无重置时首次命中该目标的时间为 $H_x$。对 $t>0$，定义

$$
 Q_t(x)=\Pr(H_x>t)
       =\operatorname{erf}\!\left(\frac{x}{\sqrt{4Dt}}\right),
 \qquad
 F_t(x)=1-Q_t(x),
\tag{2.1}
$$

以及确定性截止时间为 $t$ 时，单次尝试的平均持续时间

$$
 A_t(x)=\mathbb E\min(H_x,t)=\int_0^t Q_s(x)\,ds.
\tag{2.2}
$$

令 $\mathcal P_+$ 表示 $(0,\infty)$ 上所有 Borel 概率分布。对 $\mu\in\mathcal P_+$，定义

$$
 f_\mu(x)=\int F_t(x)\,\mu(dt),\qquad
 a_\mu(x)=\int A_t(x)\,\mu(dt),\qquad
 M_\mu(x)=\frac{a_\mu(x)}{f_\mu(x)}.
\tag{2.3}
$$

其中 $0<f_\mu(x)<1$，但 $a_\mu(x)$ 与 $M_\mu(x)$ 可以为无穷。我们不对 $\mu$ 施加任何矩条件。

选定参考分布 $\nu\in\mathcal P_+$，并记 $g=f_\nu$。仅假设

$$
 0<Z_\nu:=\int_0^\infty g(x)^2\,dx<\infty.
\tag{2.4}
$$

其共轭**距离**分布定义为

$$
 \pi_\nu(dx)=Z_\nu^{-1}g(x)^2\,dx.
\tag{2.5}
$$

若需要带符号的目标位置，可以独立地以相同概率选择正负号。此时整条实线上的位置密度为 $g(|x|)^2/(2Z_\nu)$。这一约定消除了二倍因子的歧义。

待最小化的量与参考能量分别为

$$
 J_\nu(\mu)=\int_0^\infty M_\mu(x)\,\pi_\nu(dx),
 \qquad
 \mathcal E_\nu=\frac1D\int_0^\infty\!\!\int_0^\infty
       \min(x,y)g(x)g(y)\,dx\,dy.
\tag{2.6}
$$

所有非负积分均在 $[0,\infty]$ 中理解。

## 定理 2.1. 全局恒等式与完整等号条件

对每个 $\mu\in\mathcal P_+$，都有

$$
 \boxed{\;
 J_\nu(\mu)=\frac{\mathcal E_\nu}{Z_\nu}
  +\frac1{2DZ_\nu}\int_0^\infty\!\!\int_0^\infty
   \min(x,y)\,
   \frac{[g(x)f_\mu(y)-g(y)f_\mu(x)]^2}
        {f_\mu(x)f_\mu(y)}\,dx\,dy .
 \;}
\tag{2.7}
$$

这是非负扩展实数之间的加法恒等式，不是两个可能为无穷的量相减。

若 $\mathcal E_\nu<\infty$，则

$$
 J_\nu(\mu)\ge J_\nu(\nu)=\mathcal E_\nu/Z_\nu,
 \qquad
 J_\nu(\mu)=J_\nu(\nu)\ \Longleftrightarrow\ \mu=\nu.
\tag{2.8}
$$

若 $\mathcal E_\nu=\infty$，则每个竞争分布都满足 $J_\nu(\mu)=\infty$。因此，对于这一共轭目标分布，不存在平均完成时间有限的更新型重置分布。

参考分布可以是确定性的、混合的、绝对连续的或奇异的。第 6 节给出一个明确例子，其中 $\mathbb E_\nu T=\infty$，但 $J_\nu(\nu)<\infty$。

# 3. 从布朗首次通过到正积分核

## 引理 3.1. 空间积分核恒等式

对每个有限的 $t>0$ 和每个 $x>0$，

$$
 A_t(x)=\frac1D\int_0^\infty \min(x,y)F_t(y)\,dy.
\tag{3.1}
$$

**证明。** 将右端记为 $B_t(x)$。误差函数的尾部可积，故对 $x$ 求导得到

$$
 B_t'(x)=D^{-1}\int_x^\infty F_t(y)\,dy,\qquad
 B_t''(x)=-D^{-1}F_t(x).
$$

由 $Q_s$ 的后向热方程，对于 $x>0$ 有

$$
 D A_t''(x)=Q_t(x)-Q_0(x)=-F_t(x),
$$

其中 $Q_0(x)=1$。可以在与 $x=0$ 保持正距离的任意紧区间上，将求导移入时间积分：当 $s\downarrow0$ 时，导数中可能出现的 $s^{-1}$ 的各次幂均受 $\exp[-x^2/(4Ds)]$ 的衰减控制。

两个函数在 $x=0$ 都为零，而且都具有界：$0\le A_t\le t$，并且

$$
 0\le B_t(x)\le D^{-1}\int_0^\infty yF_t(y)\,dy=t.
$$

最后一个等式可由代换 $y=\sqrt{4Dt}\,u$ 与分部积分得到，所需积分为 $\int_0^\infty u\,\operatorname{erfc}(u)\,du=1/4$。因此，$A_t-B_t$ 是一个仿射函数，在零点为零且在整个半轴上有界，只能恒等于零。$\square$

将式 (3.1) 对重置时间分布混合，并应用 Tonelli 定理，得到核心关系

$$
 a_\mu(x)=(Kf_\mu)(x),\qquad
 K(x,y)=\frac{\min(x,y)}D.
\tag{3.2}
$$

该核是对称的，并且当 $x,y>0$ 时严格为正。上述混合与积分换序均不要求预先假设可积性；即使两端都为无穷，等式仍然成立。

## 引理 3.2. 不要求有限均值的更新均值公式

式 (2.3) 中的 $M_\mu(x)$，就是采用共同分布 $\mu$ 进行重复独立重置时的期望完成时间。

**证明。** 每次尝试的成功概率为 $p=f_\mu(x)>0$，耗时的均值为 $a_\mu(x)=\mathbb E\min(H_x,T)$。进入第 $k$ 次尝试的概率为 $(1-p)^{k-1}$，该次新生成的路径与等待时间均独立于此前尝试。对各次非负耗时之和应用 Tonelli 定理，得到

$$
 \mathbb E T_{\mathrm{complete}}
   =\sum_{k\ge1}(1-p)^{k-1}a_\mu(x)=a_\mu(x)/p.
$$

这也证明了均值无穷时的公式。重置事件不会在有限时间内累积无穷多次：存在某个 $\varepsilon>0$ 使 $\Pr(T\ge\varepsilon)>0$，独立抽样几乎必然会无穷多次得到大于等于 $\varepsilon$ 的等待时间。$\square$

这个论证没有在失败后重新抽取未知目标。更新计算以目标距离固定为 $x$ 为条件；只有完成该计算之后，才对 $\pi_\nu$ 取平均。

# 4. 全局最优性与严格唯一性

## 4.1. 正对称核对应的比值泛函

这是经典基态表示的初等正核形式，可对照文献 [6] 命题 2.3 的二次情形与注 2.4。下面明确给出逐点计算，以及允许无穷值的非负积分推广。

对于正数 $f_x,f_y,g_x,g_y$，有

$$
 \frac12\left(g_x^2\frac{f_y}{f_x}
                  +g_y^2\frac{f_x}{f_y}\right)
 =g_xg_y+\frac{(g_xf_y-g_yf_x)^2}{2f_xf_y}.
\tag{4.1}
$$

将两端乘以一个非负对称核并积分。由 Tonelli 定理与对称性，左端两个积分相同。取 $f=f_\mu$，结合式 (3.2) 与 (2.6)，便直接得到式 (2.7)。

式 (4.1) 中的每一项都非负。因此，即使某个积分为无穷，证明仍然有效。特别地，参考能量无穷会迫使每个竞争分布的目标函数都为无穷。当参考能量有限时，平方项直接证明全局最小性，无须使用微扰论证、宣称目标函数凸性，或将竞争者限制在参数化分布族内。

## 4.2. 等号确定成功概率剖面

假设 $\mathcal E_\nu<\infty$，并且式 (2.8) 取等号。于是非负的二重积分为零。由 $K$、$f_\mu$ 和 $g$ 的严格正性可得

$$
 \frac{f_\mu(x)}{g(x)}
 =\frac{f_\mu(y)}{g(y)}
 \quad\text{对几乎处处的 }(x,y)\text{ 成立。}
$$

由 Fubini 定理，存在常数 $c>0$，使 $f_\mu=cg$ 几乎处处成立。控制收敛定理说明每个成功概率剖面都是连续的，因此上述等式实际上对所有 $x>0$ 成立。再次使用控制收敛定理，有

$$
 \lim_{x\downarrow0}f_\mu(x)
 =\lim_{x\downarrow0}g(x)=1,
$$

故 $c=1$。

## 4.3. 剖面相同确定等待时间分布

对 $x>0$，对误差函数混合求导，得到

$$
 f_\mu'(x)
  =-\frac1{\sqrt{\pi D}}\int_0^\infty
       t^{-1/2}e^{-x^2/(4Dt)}\,\mu(dt).
\tag{4.2}
$$

这一求导不要求 $\int t^{-1/2}\mu(dt)<\infty$。在与零点保持正距离的任意紧 $x$ 区间上，导数被积函数对所有 $t>0$ 一致有界。

记 $\rho_\mu$ 为 $\mu$ 在映射 $u=(4Dt)^{-1}$ 下的推前分布。剖面相同蕴含

$$
 \int_0^\infty \sqrt u\,e^{-su}\,\rho_\mu(du)
 =\int_0^\infty \sqrt u\,e^{-su}\,\rho_\nu(du)
 \quad (s>0).
$$

固定 $s_0>0$。因为权函数有界，测度 $\sqrt u\,e^{-s_0u}\rho_\mu(du)$ 与 $\sqrt u\,e^{-s_0u}\rho_\nu(du)$ 均为有限测度。它们的 Laplace 变换对所有非负参数相同。由有限测度的 Laplace 变换唯一性，两测度相同。除去严格为正的权函数，再将双射 $t\mapsto(4Dt)^{-1}$ 反演，便得到 $\mu=\nu$。

为使论证完整，有限测度的上述唯一性事实可以如下证明：将 $u$ 映到 $e^{-u}\in(0,1)$；在非负整数处的变换值相同，意味着全部矩相同。多项式在 $[0,1]$ 上的连续函数空间中稠密，而有限测度由其对所有连续函数的积分唯一确定。定理 2.1 得证。

# 5. 定量稳定性与精确可容许性公式

## 5.1. 局部稳定性估计

假设参考能量有限。令 $h(x)=\log(f_\mu(x)/g(x))$。将式 (2.7) 中的平方项改写，得到

$$
 J_\nu(\mu)-J_\nu(\nu)
 =\frac1{DZ_\nu}\iint \min(x,y)g(x)g(y)
          [\cosh(h(x)-h(y))-1]\,dx\,dy.
\tag{5.1}
$$

对满足 $0<b<c<\infty$ 的区间 $I=[b,c]$，记

$$
 G_I=\int_Ig(x)\,dx,\qquad
 \rho_I(dx)=G_I^{-1}g(x)\mathbf1_I(x)\,dx.
$$

利用 $\cosh z-1\ge z^2/2$，以及 $I^2$ 上的 $\min(x,y)\ge b$，得到

$$
 \boxed{\quad
 J_\nu(\mu)-J_\nu(\nu)
 \ge\frac{bG_I^2}{DZ_\nu}
       \operatorname{Var}_{\rho_I}
       \!\left(\log\frac{f_\mu}{g}\right).
 \quad}
\tag{5.2}
$$

在这个紧区间上，所有对数均有界。该不等式控制近优成功概率剖面之比在空间上的变化幅度。它不是重置等待时间分布之间的全变差界，也不能单独控制远处尾部。

## 5.2. 归一化与有限能量的非负判据

将 $\min(x,y)$ 写为 $\int_0^\infty\mathbf1_{\{u<x\}}\mathbf1_{\{u<y\}}\,du$，得到

$$
 \mathcal E_\nu
 =D^{-1}\int_0^\infty
       \left(\int_u^\infty g(x)\,dx\right)^2du.
\tag{5.3}
$$

这是精确的有限性判据，取值无穷时也成立。若 $T,U$ 相互独立且均服从 $\nu$，初等高斯积分还给出

$$
 Z_\nu=\frac{2\sqrt D}{\sqrt\pi}
  \mathbb E\!\left[\sqrt T+\sqrt U-\sqrt{T+U}\right],
\tag{5.4}
$$

$$
 \mathcal E_\nu=\frac{4\sqrt D}{3\sqrt\pi}
  \mathbb E\!\left[(T+U)^{3/2}-T^{3/2}-U^{3/2}\right].
\tag{5.5}
$$

这里对括号内完整的非负函数取期望，不能将其解释为分别计算几个期望之后相减。验证式 (5.5) 时，先使用

$$
 \int_0^\infty F_t(x)Q_s(x)\,dx
   =\frac{2\sqrt D}{\sqrt\pi}\,[\sqrt{t+s}-\sqrt s]
$$

再对 $0<s<u$ 积分即可。对两个互补误差函数的乘积进行相同的分部积分计算，则得到式 (5.4)。这些确定性积分公式已出现在文献 [1] 的补充材料中，其中采用了相应的密度约定。它们在本文中的作用是明确可容许性条件，并提供独立的计算核验方式。

# 6. 三种明确的参考分布

## 6.1. 指数重置与覆盖所有竞争分布的最优性

令 $\nu=\operatorname{Exp}(r)$，其中 $r>0$，并记 $\alpha=\sqrt{r/D}$。则

$$
 g(x)=e^{-\alpha x},\qquad
 a_\nu(x)=\frac{1-e^{-\alpha x}}r,\qquad
 \pi_\nu(dx)=2\alpha e^{-2\alpha x}\,dx,\qquad
 J_\nu(\nu)=\frac1r.
\tag{6.1}
$$

这一构造与参考值均为已知结果 [1]。定理 2.1 说明，$\mathcal P_+$ 中不存在平均完成时间更小的其他分布，而且取等号必然要求采用同一个指数分布。

对于参数为 $s$ 的竞争指数分布，令 $z=\sqrt{s/r}$。直接积分给出

$$
 J_\nu(\operatorname{Exp}(s))
 =\frac1{r z(2-z)},\qquad
 J_\nu(\operatorname{Exp}(s))-\frac1r
 =\frac{(z-1)^2}{r z(2-z)}
 \quad(0<z<2).
\tag{6.2}
$$

当 $z\ge2$ 时，目标函数发散。这个阈值不能忽略：截断目标位置的取值范围，可能会掩盖平均完成时间实际上为无穷的情形。

取 $D=r=1$，一个不属于单一指数分布族的竞争者为

$$
 \mu=\tfrac12\operatorname{Exp}(1)
       +\tfrac12\operatorname{Exp}(4).
$$

其成功概率剖面为 $f_\mu(x)=(e^{-x}+e^{-2x})/2$，而
$a_\mu(x)=(1-e^{-x})/2+(1-e^{-2x})/8$。在对目标位置的平均积分中代入 $u=e^{-x}$，得到精确值

$$
 J_\nu(\mu)=4\log2-\frac74>1.
\tag{6.3}
$$

## 6.2. 确定性重置

当 $\nu=\delta_\tau$ 时，

$$
 g(x)=\operatorname{erfc}\!\left(\frac{x}{\sqrt{4D\tau}}\right),
 \quad
 Z_\nu=\frac{2(2-\sqrt2)\sqrt{D\tau}}{\sqrt\pi},
 \quad
 J_\nu(\nu)=\frac{2\sqrt2}{3}\tau.
\tag{6.4}
$$

最后一个等式由式 (5.4)–(5.5) 推出。定理 2.1 给出了在所有正等待时间分布中的严格最优性，覆盖范围超出对确定性时间施加高斯扰动的情形。

对于采用确定性截止时间 $s$ 的竞争者，其平均完成时间有限，当且仅当 $s>\tau/2$。事实上，当 $x\to\infty$ 时，被积函数等于某个正常数乘以

$$
 x^{-1}\exp\!\left[
 x^2\left(\frac1{4Ds}-\frac1{2D\tau}\right)\right](1+o(1)).
$$

在边界 $s=\tau/2$ 处，该积分以对数方式发散。在 $x=0$ 附近没有发散问题。

## 6.3. 重置时间均值无穷，但最优平均完成时间有限

固定 $t_0>0$，采用逆伽马分布

$$
 \nu(dt)=t_0t^{-2}e^{-t_0/t}\,dt.
\tag{6.5}
$$

等价地，$T=t_0/U$，其中 $U\sim\operatorname{Exp}(1)$，故 $\mathbb E T=\infty$。令 $c=2\sqrt{Dt_0}$。直接积分给出

$$
 g(x)=1-\frac{x}{\sqrt{x^2+c^2}},\qquad
 \int_x^\infty g(y)\,dy=\sqrt{x^2+c^2}-x,
\tag{6.6}
$$

$$
 a_\nu(x)=
 \frac{x\sqrt{x^2+c^2}
       +c^2\operatorname{arsinh}(x/c)-x^2}{2D}.
\tag{6.7}
$$

例如，作代换 $u=t_0/t$，再对 $\int_0^\infty e^{-u}\operatorname{erfc}(x\sqrt u/c)\,du$ 分部积分，即可得到式 (6.6)。对其平方积分，并在式 (5.3) 中作代换 $x=c\sinh v$，得到

$$
 Z_\nu=\sqrt{Dt_0}(4-\pi),\qquad
 \mathcal E_\nu=\frac{16}{3}\sqrt D\,t_0^{3/2},\qquad
 \boxed{J_\nu(\nu)=\frac{16t_0}{3(4-\pi)}.}
\tag{6.8}
$$

因此，尽管该分布的平均等待时间无穷，它仍然是其共轭距离分布下的唯一最优解。逆伽马分布族本身已在文献 [1] 中讨论；本例说明全局定理的精确适用范围，并为核验提供闭式表达式。

不同参考分布对应不同的共轭目标先验，不能当成同一个目标分布上的性能比较。

# 7. 明确外域中的径向推广

设整数 $d\ge2$、$a>0$，一个吸收球的中心到重置点的距离为 $R>a$。经过平移与旋转，这等价于布朗运动从以零点为中心的球体外、半径为 $R$ 的位置出发。该球在整次搜索中保持固定。其径向生成元为

$$
 \mathcal L=D\left(\frac{d^2}{dR^2}
          +\frac{d-1}{R}\frac d{dR}\right).
$$

采用如下测度与积分核：

$$
 m_d(dR)=R^{d-1}dR,\qquad
 K_d(R,S)=\frac1D\int_a^{\min(R,S)}u^{1-d}\,du.
\tag{7.1}
$$

当 $d=2$ 时，$K_d=D^{-1}\log(\min(R,S)/a)$。当 $d\ne2$ 时，

$$
 K_d(R,S)=
 \frac{\min(R,S)^{2-d}-a^{2-d}}{D(2-d)}.
$$

该核在外域上严格为正且对称。当 $d>2$ 时，不能将它与要求空间无穷远处取零值的通常 Green 核混为一谈。

## 引理 7.1. 径向表示

记 $F_t(R)=\Pr_R(H_a\le t)$，以及
$A_t(R)=\int_0^t\Pr_R(H_a>s)\,ds$，则

$$
 A_t(R)=\int_a^\infty K_d(R,S)F_t(S)\,m_d(dS).
\tag{7.2}
$$

**证明。** 对 $\lambda>0$，令 $q_\lambda(R)=\mathbb E_R e^{-\lambda H_a}$，并约定 $e^{-\lambda\infty}=0$。该有界命中时间变换满足

$$
 D(R^{d-1}q_\lambda')'
   =\lambda R^{d-1}q_\lambda,\qquad
 q_\lambda(a)=1,\qquad q_\lambda(\infty)=0.
$$

具体地，记 $\kappa=1-d/2$，有

$$
 q_\lambda(R)=
 \left(\frac Ra\right)^\kappa
 \frac{\mathrm K_\kappa(R\sqrt{\lambda/D})}
      {\mathrm K_\kappa(a\sqrt{\lambda/D})},
\tag{7.3}
$$

其中 $\mathrm K_\kappa$ 是修正 Bessel 函数，与本文的空间积分核不同。这一标准首次通过变换也见于文献 [1] 的补充材料式 S42。它的指数衰减蕴含 $R^{d-1}q_\lambda'(R)\to0$。对微分方程积分，得到

$$
 \int_u^\infty q_\lambda(S)S^{d-1}dS
  =-\frac D\lambda u^{d-1}q_\lambda'(u).
$$

由 Tonelli 定理，再对 $u$ 积分，得到

$$
 (K_dq_\lambda)(R)
 =-\lambda^{-1}\int_a^R q_\lambda'(u)\,du
 =\frac{1-q_\lambda(R)}{\lambda}.
\tag{7.4}
$$

$F_t$ 与 $A_t$ 关于时间的 Laplace 变换分别为 $q_\lambda/\lambda$ 和 $(1-q_\lambda)/\lambda^2$。因此，由 Tonelli 定理，式 (7.2) 右端与左端具有相同的变换。

为了从变换相同推出对每个有限 $t$ 都相同，固定 $T<\infty$。当 $0\le t\le T$ 时，有 $F_t(S)\le e^{\lambda T}q_\lambda(S)$；结合式 (7.4) 与控制收敛定理，可以证明 $K_dF_t$ 的有限性及其关于 $t$ 的连续性。$A_t$ 同样连续。由 Laplace 变换唯一性，式 (7.2) 成立。$\square$

## 推论 7.2. 全局径向最优性

按此前方式定义 $f_\mu,a_\mu$，但使用径向首次通过过程。令

$$
 \begin{aligned}
 Z_\nu&=\int_a^\infty g^2\,dm_d,\\
 \pi_\nu(dR)&=Z_\nu^{-1}g(R)^2\,m_d(dR),\\
 \mathcal E_\nu&=\iint K_d(R,S)g(R)g(S)\,dm_d(R)dm_d(S).
 \end{aligned}
$$

只要 $0<Z_\nu<\infty$，将式 (2.7) 中的 $\min(x,y)/D$ 替换为 $K_d$、将 Lebesgue 测度替换为 $m_d$，相应的加法恒等式就成立。

**证明。** 由引理 7.1，将固定时间恒等式对 $\mu$ 积分，并应用 Tonelli 定理，得到

$$
 a_\mu(R)=\int_a^\infty K_d(R,S)f_\mu(S)\,m_d(dS).
$$

将其代入 $J_\nu(\mu)=Z_\nu^{-1}\int g(R)^2a_\mu(R)/f_\mu(R)\,m_d(dR)$。由 $K_d(R,S)=K_d(S,R)$，对调 $R,S$ 后取两式平均，再使用式 (4.1)，得到完整表达式

$$
 J_\nu(\mu)=\frac{\mathcal E_\nu}{Z_\nu}
 +\frac1{2Z_\nu}\iint K_d(R,S)
 \frac{[g(R)f_\mu(S)-g(S)f_\mu(R)]^2}
      {f_\mu(R)f_\mu(S)}\,dm_d(R)dm_d(S).
$$

各项非负，因此换序及恒等式均允许无穷值。这证明了全局比较，并且当参考能量无穷时，迫使所有竞争目标值均为无穷。

若参考能量有限，取等号当且仅当 $f_\mu=f_\nu$。事实上，平方积分为零与外域上核的严格正性，先给出 $f_\mu$ 与 $f_\nu$ 几乎处处成正比例；连续性将比例关系延拓到全部外域。边界连续性与 $f_\mu(a+)=f_\nu(a+)=1$ 则消去比例常数。在三维中，

$$
 F_t(R)=\frac aR
  \operatorname{erfc}\!\left(\frac{R-a}{\sqrt{4Dt}}\right),
$$

所以剖面相同可化为一维单射性证明，从而推出 $\mu=\nu$。我们不宣称在其他维度已经证明重置等待时间分布的单射性。$\square$

在参考能量有限的情形下，对于满足 $a<b<c<\infty$ 的区间 $I=[b,c]$，式 (5.2) 的径向对应形式为

$$
 J_\nu(\mu)-J_\nu(\nu)
 \ge \frac{k_I G_I^2}{Z_\nu}
   \operatorname{Var}_{\rho_I}\!\left(\log(f_\mu/g)\right),
 \quad
 k_I=\frac1D\int_a^b u^{1-d}du,
\tag{7.5}
$$

其中 $G_I=\int_Ig\,dm_d$，且 $\rho_I=g\,dm_d/G_I$ 定义在 $I$ 上。该式由上面的非负差额表示得到：将剖面之比记为对数变量，使用 $\cosh z-1\ge z^2/2$，并在 $I^2$ 上使用 $K_d(R,S)\ge k_I$，再将双重平方差积分写成方差即可。

**定义域约定。** 作者补充材料第 VIII 节讨论 $R>a$，但部分归一化表达式的积分下限写为零。本文每个径向积分都明确取在 $R>a$ 上，因此出发点位于目标之外。常数球面面积因子在归一化的径向概率中约去。我们既不将外域 Bessel 表达式延伸到目标内部，也不在 $d\ge2$ 时取零半径极限。当 $a>0$ 时，指数重置分布在每个整数维度都产生可归一化且能量有限的共轭先验：其剖面在 $a$ 处有界，在无穷远处呈指数衰减。因此不从采用其他积分下限的约定中引入 $d<4$ 限制。

# 8. 核验与局限

配套程序通过符号运算与有理数算术检查精确代数，计算彼此独立的积分表达式，复现明确例子，并检验径向预解式恒等式。计算结果是关于公式及其实现的证据，不能替代连续情形的证明；浮点输出也不是区间算术证书。

独立脚本分别采用直接时间积分、空间积分与已知闭式表达式作为核验依据。记录输出包含精度、容差、参数及实际执行结果。

本研究未提供 Lean 定理。书面结果使用测度论中的积分换序及标准唯一性论证；代数证书只覆盖其明确声明的代数部分或有限维部分。本文任何部分都不被表述为已经完成端到端机器验证。

若干限制需要明确。允许零时长原子会使等待时间分布的唯一性不成立：当 $\mu=p\delta_0+(1-p)\nu$、$p<1$ 时，$a$ 与 $f$ 同时缩小为原来的 $1-p$ 倍，而二者之比保持不变。非零重置开销会改变单次尝试成本这一分子，需要另行分析。自适应调度、依赖绝对时间的调度、路径反馈、非布朗动力学，以及任意预先指定的目标分布，均未由本文解决。对固定共轭先验，最优重置分布的唯一性，也不意味着一个重置分布只能对某一个目标先验最优。

在所记录的检索范围内，我们未找到此前覆盖所有可容许竞争分布的共轭先验比较证明。这是有范围限制的阴性检索结果，不能认证新颖性或全球优先权。我们未能从所检查的合法公开来源取得重要前序工作 [3] 的全文；其摘要涉及多个目标，因此不能仅凭摘要排除其完整定理覆盖本问题的可能。文献审查保留该全文不可得的限制，不视为已经完整排除所有先行结果。文献比较限于实际获取的文献。

# 参考文献

[1] M. R. Evans and S. Ray, *Stochastic Resetting Prevails Over Sharp Restart for Broad Target Distributions*, Physical Review Letters **134**, 247102 (2025). DOI: [10.1103/2wpq-gl2j](https://doi.org/10.1103/2wpq-gl2j)。实际核查的作者版本：[arXiv:2410.01941v2](https://arxiv.org/abs/2410.01941v2)，2025 年 5 月 19 日，正文与补充材料。

[2] A. Pal and S. Reuveni, *First Passage under Restart*, Physical Review Letters **118**, 030603 (2017). DOI: [10.1103/PhysRevLett.118.030603](https://doi.org/10.1103/PhysRevLett.118.030603)。

[3] A. Chechkin and I. M. Sokolov, *Random Search with Resetting: A Unified Renewal Approach*, Physical Review Letters **121**, 050601 (2018). DOI: [10.1103/PhysRevLett.121.050601](https://doi.org/10.1103/PhysRevLett.121.050601)。仅核验了书目信息与摘要；全文比较待完成。

[4] M. R. Evans and J. C. Sunil, *Stochastic Resetting and Large Deviations* (2025)，  
[arXiv:2412.16374v2](https://arxiv.org/html/2412.16374v2)，特别是第 8.2 节。该后续讲解引用了共轭例子，但没有给出覆盖所有竞争分布的证明。

[5] G. García-Valladares, A. Prados, A. Manacorda, and C. A. Plata, *How target distributions shape optimal stochastic resetting*, Physical Review E **113**, 024107 (2026)，  
[arXiv:2505.16626v2](https://arxiv.org/html/2505.16626v2)。其有限定义域中位置相关重置率的优化，对应不同的可容许控制问题。

[6] R. L. Frank and R. Seiringer, *Non-linear ground state representations and sharp Hardy inequalities*, Journal of Functional Analysis **255**, 3407–3430 (2008)。DOI: [10.1016/j.jfa.2008.05.015](https://doi.org/10.1016/j.jfa.2008.05.015)。[arXiv:0803.0503v2](https://arxiv.org/abs/0803.0503v2)，第 2 节，命题 2.3 的二次情形与注 2.4。
