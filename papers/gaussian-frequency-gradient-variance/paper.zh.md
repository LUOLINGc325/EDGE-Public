# 高斯频率模型的梯度方差精确渐近

## 摘要

对周期目标函数 $h_a(x)=\psi(a^\top x)$，随机未知频率向量 $a$ 决定训练时可用的梯度信息。已有一般损失界以高斯频率尺度 $R$ 给出 $R^{-2}$ 上界，平方损失的球面先验分析则可用输入密度的傅里叶集中性。这里在保留高斯频率先验的同时处理一般损失梯度。在有界输入密度下，方差按 $R^{-d}$ 衰减，其中 $d$ 是输入维数。我们给出精确极限和达到该阶的高斯平方损失实例。对密度可无界的原论文广泛类别，我们给出反例否定印刷的 $R^{-2}$ 界，并证明在原文定理 4 的带符号几何条件下真正的最优幂指数是 $4/3$，而每个固定实例仍满足 $o(R^{-4/3})$。

## 1. 命题

设 $d\ge2$，$f$ 为 $\mathbb R^d$ 上概率密度，$q$ 为 $\mathbb R^d\times[0,1]$ 上实值可测函数，在第二个变量周期延拓。假设对几乎每个 $x$，有 $\int_0^1q(x,t)\,dt=0$，且存在 $b(x)\ge0$ 满足 $|q(x,t)|\le b(x)$ 及
$
 f b\in L^1(\mathbb R^d)\cap L^2(\mathbb R^d).
$
定义
$
 G(a)=\int_{\mathbb R^d}f(x)q(x,a^\top x)\,dx,\qquad A_R\sim N(0,R^2I_d).
$

**定理 1.** 函数 $G$ 在 $L^2(da)$ 中满足
$
 \|G\|_{L^2(da)}^2
 \le 2\zeta(d)\int_{\mathbb R^d}\int_0^1 f(x)^2 |q(x,t)|^2\,dt\,dx .
$
对任意 $R>0$，有
$
 \operatorname{Var}(G(A_R))\le (2\pi)^{-d/2}R^{-d}\|G\|_{L^2(da)}^2.
$
此外，
$
 \lim_{R\to\infty} R^d\operatorname{Var}(G(A_R))
   =(2\pi)^{-d/2}\|G\|_{L^2(da)}^2.
$

在 [1, §4, §7] 的梯度问题中，在参数 $w$ 固定并允许微分穿过期望时，写 $v(x)=\partial_{w_i}p(w,x)$。取
$
 q(x,t)=v(x)\left(\partial_1L(p(w,x),\psi(t))
             -\int_0^1 \partial_1 L(p(w,x),\psi(s))\,ds\right).
$
原梯度坐标与 $G(A_R)$ 相差一个确定性常数，所以两者方差相同。若 $f$ 有界、$v\in L^2(f\,dx)$、括号内的中心化导数一致有界，就可以取 $b=C|v|$；Cauchy–Schwarz 给出 $fb\in L^1$，而 $f^2\le \|f\|_\infty f$ 给出 $fb\in L^2$。这包括非退化高斯输入。论文 [1] 定理 4 的印刷显示式省略坐标导数，但 §4 的定义以及 §7 的说明明确把研究量写成梯度的方差。本文以这一梯度目标为准。

## 2. 周期展开与平方可积性

对 $k\in\mathbb Z$，令
$
 g_k(x)=f(x)\int_0^1 q(x,t)e^{-2\pi i kt}\,dt,\qquad
 \widehat g_k(\xi)=\int_{\mathbb R^d}g_k(x)e^{-2\pi i\xi^\top x}\,dx.
$
$g_0=0$，且各 $g_k$ 均在 $L^1\cap L^2$ 内。周期 Parseval 与 Tonelli 给出
$
 \sum_k \|g_k\|_2^2=\int_{\mathbb R^d}\int_0^1 f(x)^2 |q(x,t)|^2\,dt\,dx .
$
Plancherel 和变量缩放给出 $\|\widehat g_k(-k\,\cdot)\|_2=|k|^{-d/2}\|g_k\|_2$。因此
$
 \sum_{k\ne0}\|\widehat g_k(-k\,\cdot)\|_2
 \le
 \left(\sum_{k\ne0}|k|^{-d}\right)^{1/2}
 \left(\sum_k\|g_k\|_2^2\right)^{1/2}.
$
右端有限，且第一项和为 $2\zeta(d)$。

为证明级数的 $L^2$ 和确实等于 $G$，取 $q$ 对周期变量的 Fejér 均值 $q_N$。对几乎每个非零 $x$，$q_N(x,t)$ 对几乎每个 $t$ 收敛到 $q(x,t)$，且 $|q_N(x,t)|\le b(x)$。线性映射 $a\mapsto a^\top x$ 下，单变量零测集的原像是 $\mathbb R^d$ 的零测集，周期延拓仍成立。Fubini 遂给出几乎每个 $a$ 上对几乎每个 $x$ 的收敛。由 $fb\in L^1$，积分后的 $G_N(a)$ 几乎处处收敛到 $G(a)$。另一方面 $G_N(a)$ 是 $\widehat g_k(-ka)$ 的 Fejér 有限和，并由上述绝对 $L^2$ 收敛界，在 $L^2$ 中收敛到其无权级数之和。两种极限一致，三角不等式得到定理的范数界。若 $|q|\le b$ 从几乎处处的意义给出，同一 Fubini 论证对任何取定的可测版本都成立。

## 3. 高斯先验与精确极限

令 $c_d=(2\pi)^{-d/2}$。由高斯密度，
$
 R^d\mathbb E[|G(A_R)|^2]
   =c_d\int_{\mathbb R^d}|G(a)|^2 e^{-\|a\|^2/(2R^2)}\,da.
$
右侧受 $c_d\|G\|_2^2$ 控制，并按支配收敛趋于这一常数。对均值，令 $h_R(a)=R^{-d/2}\exp(-\|a\|^2/(2R^2))$。变量缩放给出 $\|h_R\|_2=\pi^{d/4}$，而 $h_R$ 在每个固定球上均匀趋于零。将 $G$ 分为固定球上的部分和补集，并用 Cauchy–Schwarz 控制补集，得到 $\int G h_R\to0$。于是
$
 R^{d/2}\mathbb E[G(A_R)]=c_d\int G h_R\longrightarrow0.
$
代入方差恒等式得到精确极限。若 $G$ 在 $L^2$ 中非零，该极限给出严格正的前导常数。

## 4. 锋利例子与球面比较

设 $X\sim N(0,\sigma^2I_d)$，取 $\psi(t)=\cos(2\pi t)$、$p(w,x)=w$、$L(w,y)=(w-y)^2/2$ 并在 $w=0$ 取导，则
$
 G(a)=-\exp(-2\pi^2\sigma^2\|a\|^2).
$
逐坐标完成平方得到
$
 \operatorname{Var}(G(A_R))=
 (1+8\pi^2\sigma^2R^2)^{-d/2}-(1+4\pi^2\sigma^2R^2)^{-d}.
$
乘 $R^d$ 后极限为 $(8\pi^2\sigma^2)^{-d/2}>0$，与定理 1 的积分常数吻合。此例保留高斯输入与平方损失，排除了高斯频率模型下任何对全部问题实例成立的 $o(R^{-d})$ 方差上界。对同一个例子，固定半径的均匀球面先验使 $G(A_R)$ 成为常数，方差恰为零。高斯先验仍以 $R^{-d}$ 的概率量级采到有梯度信息的固定频率区域。先验改变本身已足以令该量级不同。

## 5. 原一般上界的反例与替代指数

本节允许输入密度无界。写 $\mu(dx)=f(x)\,dx$，$q(x,t)=v(x)\ell_x(t)$，其中 $v\in L^2(\mu)$，各 $\ell_x$ 周期均值为零且 $|\ell_x|\le M_x$。对于横跨非零 $x,y$ 的角度 $\theta$，令 $r=\|x\|$、$s=\|y\|$ 及
$
 K_{\mathrm s}(x,y)=\frac{r^{-1}+s^{-1}}{1-\cos\theta},\qquad
 K_{\mathrm a}(x,y)=\frac{r^{-1}+s^{-1}}{1-|\cos\theta|},\qquad
 \mathbb E_{\mu\times\mu}[M_X^2M_Y^2K_{\mathrm s}(X,Y)^2]<\infty.
 \tag{1}
$
带符号的 $K_{\mathrm s}$ 是 [1, Theorem 4] 显示式中的几何因子。附录 C.1 最终方差式使用较强的 $K_{\mathrm a}$。

**定理 2.** 在条件 (1) 下，任一固定实例的梯度坐标方差为 $o(R^{-4/3})$。对每个 $d\ge6$ 和每个 $\beta>4/3$，存在满足附录较强条件的绝对连续输入、平方损失型目标和平方可积梯度特征，使方差沿一列 $R\to\infty$ 不为 $O(R^{-\beta})$。特别地，定理 4 显示的 $O(R^{-2})$ 在这组假设下一般不成立。

**上界。** 先由紧性将单位球面覆盖并划分为有限个 Borel 角区，每个角区的球面直径小于 $\pi/2$。例如使用有限个半径 $\pi/6$ 的开球帽覆盖，再按顺序从每个球帽去掉较早球帽。对同角区内的 $x,y$ 有 $\cos\theta\ge0$，故 $K_{\mathrm s}=K_{\mathrm a}$。条件 (1) 因此给出每个正质量角区的条件输入分布的 $K_{\mathrm a}^2$ 可积性。以下在这些分布上证明结果，最后用角区质量加权，再用 $L^2$ 三角不等式合并有限个部分。设 $K=K_{\mathrm a}$，此时 (1) 对 $K$ 也成立。

若 $M_X=0$ 几乎处处，方差为零。否则由于 $K\ge r^{-1}$，(1) 推出 $\int M_x^2\,d\mu(x)<\infty$ 和 $\int M_x^2/r^2\,d\mu(x)<\infty$。因此 $vM$ 可积。取 $\delta=R^{-2/3}$，将 $G$ 分成 $r\le\delta$ 与 $r>\delta$ 的积分。低半径部分 $G_{\mathrm L}$ 的绝对值平方对任意 $a$ 都满足
$
 |G_{\mathrm L}(a)|^2\le
 \delta^2\left(\int_{r\le\delta}|v|^2\,d\mu\right)
          \left(\int_{r\le\delta}M_x^2/r^2\,d\mu\right)
 =o(\delta^2).
 \tag{2}
$

对几乎每一对 $x,y$，绝对连续性及 $d\ge2$ 保证 $x,y$ 线性无关。设 $\Sigma$ 是 $(A_R^\top x,A_R^\top y)$ 的协方差矩阵，即 $R^2$ 倍的 Gram 矩阵。将二维正态密度 $\phi_\Sigma$ 周期化，得到相位对在二维环面上的密度 $\widetilde\phi_\Sigma$。各 $\ell_x$ 的原函数 $F_x(t)=\int_0^t\ell_x(s)\,ds$ 是周期、绝对连续且 $\|F_x\|_\infty\le M_x$。分两次周期分部积分给出
$
 |\mathbb E[\ell_x(A_R^\top x)\ell_y(A_R^\top y)]|
 \le M_xM_y\|\partial_{12}\widetilde\phi_\Sigma\|_1.
$
周期化后混合导数的 $L^1$ 范数不超过周期化前的范数。由
$
 \partial_{12}\phi_\Sigma(z)
 =\big((\Sigma^{-1}z)_1(\Sigma^{-1}z)_2-(\Sigma^{-1})_{12}\big)\phi_\Sigma(z)
$
及 Cauchy–Schwarz，
$
 \|\partial_{12}\phi_\Sigma\|_1
 \le 2\sqrt{(\Sigma^{-1})_{11}(\Sigma^{-1})_{22}}
 =\frac{2}{R^2rs\sin^2\theta}
 \le\frac{2K(x,y)}{R^2(r+s)}.
 \tag{3}
$
高半径部分 $G_{\mathrm H}$ 的二次矩由 (3) 的绝对值上界积分控制。由于 $R^{4/3}/R^2=\delta$，缩放后的上界为
$
 R^{4/3}\mathbb E|G_{\mathrm H}(A_R)|^2
 \le 2\int\!\!\int
 |v(x)v(y)|M_xM_yK(x,y)
 \frac{\delta}{r+s}\mathbf1_{r,s>\delta}\,d\mu(x)d\mu(y).
$
乘在几何核后的比值带指示函数时不超过 $1/2$，且逐点趋零。其余因子由 $v\in L^2(\mu)$、(1) 和 Cauchy–Schwarz 可积。支配收敛给出 $o(1)$。结合 (2) 和 $L^2$ 三角不等式，即得上界。

**反例。** 给定 $d\ge6$ 和 $\beta>4/3$，选 $\alpha\in(0,1/2)$ 使 $\beta(1+\alpha)>2$。置
$
 r_i=4^{-i},\quad \varepsilon_i=r_i^\alpha,\quad
 s_i=r_i\varepsilon_i,\qquad i\ge1 .
$
令 $\mu_i$ 是中心 $r_i e_1$、半径 $s_i/10$ 的球内均匀概率。球互不相交，因为每球中半径在 $[0.9r_i,1.1r_i]$，相邻中心半径比为 $4$。取 $m_i=C r_i^2/i^2$，其中 $C>0$ 使 $\sum_i m_i=1$。用 $\mu=\sum_i m_i\mu_i$ 作输入分布，并在第 $i$ 球置 $v_i=(i^2m_i)^{-1/2}$。于是 $\int v^2\,d\mu=\sum_i i^{-2}<\infty$。取 $p(w,x)=w v(x)$，$\psi(t)=\cos(2\pi t)$，损失 $L(z,y)=\tfrac12(z-\chi(y)y)^2$，其中 $\chi$ 为有界、紧支撑、在 $[-1,1]$ 等于 1 的光滑函数。对实际标签此损失等于平方损失。在 $w=0$，所用损失导数对所有实 $y$ 有界，且 $q(x,t)=-v(x)\cos(2\pi t)$。梯度可以直接对期望下二次多项式求导。

验证附录较强的几何条件。第 $i$ 个球内的极坐标 $U=X/\|X\|$ 相对于球面面积有密度至多 $C_d\varepsilon_i^{-(d-1)}$。沿任一射线在该球中的长度至多 $s_i/5$，径向 Jacobian 至多 $(1.1r_i)^{d-1}$，将二者相乘再除以该球的体积即得。对任一固定方向 $z$，用到 $z,-z$ 的较小球面距离 $\vartheta$，则 $\sin\angle(U,z)=\sin\vartheta$。在 $\vartheta<\varepsilon_i$ 使用密度界和球面面积元 $O(\vartheta^{d-2}\,d\vartheta)$，在补集使用 $\sin\vartheta\ge 2\varepsilon_i/\pi$，得到
$
 \mathbb E_{\mu_i}\sin^{-4}\angle(U,z)\le C_d\varepsilon_i^{-4}.
$
小帽内积分 $\int_0^{\varepsilon_i}\vartheta^{d-6}\,d\vartheta$ 在 $d\ge6$ 有限。对来自第 $i,j$ 球的方向先固定任一端，取两界较小者，得到期望至多 $C_d\max(\varepsilon_i,\varepsilon_j)^{-4}$。又 $K_{\mathrm a}^2\le C(r_i^{-2}+r_j^{-2})\sin^{-4}\theta$，因为 $1/(1-|\cos\theta|)\le 2/\sin^2\theta$。将其乘以 $m_i m_j$ 求和，利用
$
 (r_i^{-2}+r_j^{-2})\max(\varepsilon_i,\varepsilon_j)^{-4}
 \le r_i^{-2}\varepsilon_j^{-4}+r_j^{-2}\varepsilon_i^{-4}
$
可见总和至多常数乘积 $(\sum_i m_i r_i^{-2})(\sum_j m_j\varepsilon_j^{-4})<\infty$，后一个和敛于 $\alpha<1/2$。这证明了源文更强的绝对值几何条件。

最后，任一 $x,y$ 的高斯频率余弦协方差为
$
 \operatorname{Cov}(\cos(2\pi A_R^\top x),\cos(2\pi A_R^\top y))
 = e^{-2\pi^2R^2(r^2+s^2)}\big[\cosh(4\pi^2R^2x^\top y)-1\big]\ge0.
$
对于同一第 $i$ 球内的 $x,y$，取 $R_i=1/s_i$。余弦乘积期望包含 $\tfrac12e^{-2\pi^2R_i^2\|x-y\|^2}$，至少为 $\tfrac12e^{-2\pi^2/25}$。均值之积至多 $e^{-4\pi^2(0.9/\varepsilon_i)^2}$，故同球的协方差从充分大的 $i$ 起有一致正下界。各处 $v\ge0$，丢掉其余协方差只能减小方差。因此
$
 \operatorname{Var}(G(A_{R_i}))\ge c(m_i v_i)^2
   = c\,\frac{m_i}{i^2}
   = c'\frac{r_i^2}{i^4}.
$
而 $R_i^{-\beta}=r_i^{\beta(1+\alpha)}$，所以上述两式的比趋于无穷。证明也表明，$4/3$ 是统一的最优幂指数，固定实例仍满足所述小 $o$ 上界。

源文前述差异可以追溯到 [1, Appendix C.1, Lemma 4] 的尺度。将 $\Sigma=R^2\Lambda$ 代入该引理时，分子按 $R^3$、行列式按 $R^4$ 缩放，因而所示引理提供 $R^{-1}$，下一显示式却使用 $R^{-2}$。反例独立于这处推导差异。定理 1 在加权 $L^2$ 类别恢复 $R^{-d}$ 锐渐近。定理 2 给出定理 4 实际显示条件下的上界，并在维数至少为 6 时确定统一最优幂次。球面频率先验的一般损失指数界也未在此推导。

## 参考文献

1. Rustem Takhanov, *The informativeness of the gradient revisited*, Neural Networks 189, 107517 (2025). [论文](https://doi.org/10.1016/j.neunet.2025.107517) · [arXiv:2505.22158v1](https://arxiv.org/abs/2505.22158).
2. Ohad Shamir, *Distribution-Specific Hardness of Learning Neural Networks*, JMLR 19(32), 1–29 (2018). [期刊全文](https://jmlr.org/papers/v19/17-537.html).
3. Rustem Takhanov, Maxat Tezekbayev, Artur Pak, Arman Bolatov and Zhenisbek Assylbekov, *Gradient Descent Fails to Learn High-frequency Functions and Modular Arithmetic*. [arXiv:2310.12660](https://arxiv.org/abs/2310.12660). 本文比对其连续一维周期目标部分。
