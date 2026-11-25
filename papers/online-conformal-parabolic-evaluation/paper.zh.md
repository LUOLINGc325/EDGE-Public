# 临界共形预测首项的固定区间抛物方程求值

研究稿 · 2026-11-24 · 面向概率与统计学专家。

## 通俗摘要

为使在线预测的累计漏报始终留在允许区间，系统需要偶尔覆盖或排除所有响应。先前的连续随机控制模型给出某种约束强度下的精确成本。本稿给出一条确定性的一维抛物方程，可以用它求同一个成本。将常规控制限制在有限范围、将无穷积分改成有限积分的两项误差都有显式上界。短时和长时的最优反馈不同。

## 定理

采用配套研究中的[临界变分极限](../online-conformal-critical-variational-limit/paper.zh.md)的设定：$\sigma^2=\alpha(1-\alpha)>0$，归一化走廊为 $[a,b]$，$a\le0\le b$、$a<b$。写 $C_*=\lim_{T\to\infty}M_T/\sqrt T$，$G(u)=\mathbb E|\sigma Z-u|$，$Z\sim N(0,1)$。令 $f_0$ 为 $N(0,\sigma^2)$ 截断到 $[a,b]$ 的密度，$c_{\mathrm K}=\sigma^2[f_0(a)+f_0(b)]$。

对 $M>0$ 定义可微且导数有界的 Hamilton 函数

$$
H_M(p)=\min_{|u|\le M}\{G(u)+pu\}.
$$

令 $p_M(r,z)$ 为固定区间 $(a,b)$ 上的唯一有界温和解：

$$
\partial_r p_M =
\frac{\sigma^2}{2}\partial_{zz}p_M+
\left(H_M'(p_M)-\frac z2\right)\partial_z p_M,\qquad
p_M(r,a)=-1,\ p_M(r,b)=1,\quad
p_M(0,z)=0\quad(a<z<b).
$$

初值在内点及 $L^1(a,b)$ 的意义下取值，正时间取边界值。则

$$
C_M=c_{\mathrm K}+
\int_0^\infty e^{-r/2}\int_a^b H_M(p_M(r,z))f_0(z)\,dz\,dr
$$

满足

$$
0\le C_M-C_*\le 2[G(M)-M].
$$

如仅积分到 $R>0$，记所得值为 $C_{M,R}$，则

$$
C_{M,R}-2[G(M)-M]\le C_*
\le C_{M,R}+2G(0)e^{-R/2}.
$$

两端误差均显式趋零。本结论将一般临界变分值精确化为一维确定性抛物方程和有误差界的折扣积分。它未给该方程解的闭式。

在对称区间 $[-\kappa,\kappa]$ 和 $M>0$ 时，有限时域最优有界漂移为 $H_M'(p_M(r,z))$。对每个内点 $0<z<\kappa$，其值在任意剩余时间 $r>0$ 为负，在 $r\downarrow0$ 时趋零。因此此反射控制反馈实际依赖剩余时间。

## 1. 归一化动力学与有界问题

对任意固定起点物理时间 $\varepsilon>0$，已证原共形极限可用反射控制近似：$X_s=\sigma W_s+\int_\varepsilon^s v_t\,dt$ 加上最小的双边反射调整；绝对连续控制成本为 $s^{-1/2}G(\sqrt{s}v_s)\,ds$，反射的成本是其总变差。令 $\tau=\log(s/\varepsilon)$、$Z_\tau=X_s/\sqrt s$、$u_\tau=\sqrt s\,v_s$。Itô 时间变换给出

$$
dZ_\tau=(u_\tau-Z_\tau/2)\,d\tau+\sigma\,dB_\tau+dL_\tau-dU_\tau
$$

于固定 $[a,b]$ 内。$L,U$ 分别只在左、右边界增加。反射项随空间缩放，物理时间控制总成本为 $\sqrt\varepsilon$ 乘以

$$
\mathbb E\left[\int_0^r e^{\tau/2}G(u_\tau)\,d\tau+
\int_0^r e^{\tau/2}(dL_\tau+dU_\tau)\right],
\qquad r=\log(1/\varepsilon).
$$

令 $w_M(r,z)$ 为该括号在 $|u|\le M$ 下的下确界，初始状态 $z$。在固定 $\varepsilon>0$，物理漂移有界的条件与归一化漂移对某个 $M$ 有界等价。已证的因果平滑、有界近似和最小反射恢复因此给出 $V_\varepsilon=\sqrt\varepsilon\inf_{M>0}w_M(r,0)$。

## 2. 抛物解的构造

$G$ 光滑严格凸，$G'(u)=2\Phi(u/\sigma)-1$。并且 $G''(u)=2\phi(u/\sigma)/\sigma$ 在 $[-M,M]$ 上有正下界。故 $H_M$ 连续可微，其导数等于使最小达到的唯一 $u_M(p)$，且 $u_M$ 在全轴有界、Lipschitz。对于 $|p|\le1$，有 $0\le H_M(p)\le G(0)$。

为说明初边值角点的不相容不构成疏漏，将 $p$ 减去在 $a,b$ 处取 $-1,1$ 的线性插值 $\ell(z)$，再写成齐次边界的热半群方程。原微分方程的保守形式为

$$
p_r=\frac{\sigma^2}{2}p_{zz}
+\partial_z[H_M(p)-zp/2]+p/2.
$$

对 $h=p-\ell$ 使用区间 Dirichlet 热半群，初值 $h_0=-\ell$ 作为有界可测初值。热核及源坐标导数的 $L^1$ 界分别为 $O(1)$、$O(r^{-1/2})$。该式通量和零阶项对 $h$ 全局 Lipschitz，故 Duhamel 积分对短时间的有界函数空间形成压缩。逐段延伸构造唯一有界解，在任意固定有限时间上有界，并在时间零以 $L^1$ 和内点意义恢复初值。半群在正时间给出零边界的 $h$。

这里仅需正时间上的 $p$ 与 $p_z$ 连续。可直接用区间热核：对 $0<\gamma<1$，源坐标导数在空间 $C^\gamma$ 范数有 $O(r^{-(1+\gamma)/2})$ 界，可通过对核差使用短长间距插值得到。Duhamel 积分从而使 $p$ 在任一正时间紧窗口上有统一空间 Hölder 界，且仍连续。再对通量积分取空间导数。混合二阶热核的源积分为零，因 Dirichlet 核在两个源边界均为零；可在积分中减去当前空间点的通量值。该值的 Hölder 差使 $O(r^{-1})$ 的核奇性降为可积的 $O(r^{-1+\gamma/2})$。这给出 $p_z$ 的连续性，含区间端点。在内域使用通常的均匀抛物正则性或比较原理。初值和边界均位于 $[-1,1]$；正部能量检验也能直接给出 $|p|\le1$：把非保守形式乘 $(p-1)_+$，用有界对流系数与 Cauchy 不等式，再让检验的初始正时刻趋零。对 $(-1-p)_+$ 同理。

写

$$
F(r,z)=\int_a^z p_M(r,y)\,dy,\quad
\bar H_M(r)=\int_a^b H_M(p_M(r,z))f_0(z)\,dz.
$$

设 $m_M(0)=0$，$m_M'=m_M/2+c_{\mathrm K}/2+\bar H_M$，并置

$$
w(r,z)=m_M(r)+F(r,z)-\int_a^b F(r,y)f_0(y)\,dy.
$$

它满足 Neumann 斜率 $w_z(r,a)=-1,w_z(r,b)=1$，且 $w(r,\cdot)\to0$ 一致。将候选方程对 $z$ 微分，通过 $p_M$ 的方程可知下式的残差对空间为常数：

$$
w_r=\frac{\sigma^2}{2}w_{zz}-\frac z2w_z+\frac12 w+H_M(w_z).
$$

用 $f_0$ 平均，利用 $\sigma^2f_0'=-zf_0$，扩散加漂移部分的平均为 $\frac12\sigma^2[p_M(r,b)f_0(b)-p_M(r,a)f_0(a)]=c_{\mathrm K}/2$。定义中的 ODE 恰使常数残差为零。该论证可先在分布意义下进行；右侧连续且 $w_z,w_{zz}$ 在正时刻连续，故 $w_r$ 连续，可在每个远离时间零的紧时窗使用 Itô 公式。

## 3. 验证有界反射控制的最优值

对于任一 $|u|\le M$ 的反射控制，应用 Itô 公式于 $e^{\tau/2}w(r-\tau,Z_\tau)$，先停在 $\tau=r-\delta$。边界斜率恰让反射项为 $-e^{\tau/2}(dL+dU)$。加回成本后，漂移为

$$
e^{\tau/2}\bigl[G(u)+u\,w_z-H_M(w_z)\bigr]\,d\tau\ge0.
$$

随机积分期望为零，因为 $|w_z|\le1$。令 $\delta\downarrow0$，用 $w(0,\cdot)=0$ 一致和反射成本有限，得所有可行成本至少 $w(r,z)$。选择反馈 $u=u_M(p_M(r-\tau,Z_\tau))$ 即取等号。在远离最后时刻的每个区间，该反馈有界且对状态 Lipschitz，存在一致的强反射解。漂移始终有界，布朗路径连续，反射映射连续，所以过程延伸到终时。于是 $w=w_M$。

## 4. 硬截断误差与折扣尾部

对 $|p|\le1$ 记 $H(p)=\inf_{u\in\mathbb R}(G(u)+pu)$。对 $|p|<1$ 无约束最优点是 $(G')^{-1}(-p)$，端点取极限得 $H(\pm1)=0$。若该点在 $[-M,M]$ 内，$H_M=H$。否则在 $p>0$ 半轴 $H_M(p)=G(M)-pM$；在该区间中，差 $H_M-H$ 的导数为 $-M-(G')^{-1}(-p)\ge0$。对负半轴用偶性，所以

$$
0\le H_M(p)-H(p)\le\delta_M:=G(M)-M.
$$

对 $M'\ge M$，在 $w_{M'}$ 的验证等式中施加 $u=u_M(p_{M'}(r-\tau,Z_\tau))$。这仍是有界可行反馈，漂移缺口至多 $\delta_M$。故

$$
0\le w_M(r,z)-w_{M'}(r,z)\le
\delta_M\int_0^r e^{\tau/2}\,d\tau
=2\delta_M(e^{r/2}-1).
$$

不需要对无界控制写 HJB 或比较解。取 $M'\to\infty$，并用 $V_\varepsilon=e^{-r/2}\inf_{M'}w_{M'}(r,0)$。再取 $r\to\infty$，误差不超过 $2\delta_M$。另一方面 $|w_M(r,0)-m_M(r)|\le b-a$ 因为 $|p_M|\le1$，而 ODE 显式给出

$$
e^{-r/2}m_M(r)
= c_{\mathrm K}(1-e^{-r/2})+
\int_0^r e^{-s/2}\bar H_M(s)\,ds.
$$

由 $0\le\bar H_M\le G(0)$，折扣积分尾部至多 $2G(0)e^{-R/2}$。这证明全部误差界。

## 5. 独立的求值残差证书

固定 $M,R$。取一个在 $[0,R]\times[a,b]$ 上连续、正时间上 $C^{1,2}$ 的试验函数 $W$。若 $W_z(r,a)=-1$、$W_z(r,b)=1$，记终端误差 $B_0=\sup_z|W(0,z)|$，并对每个正时刻取可积上界

$$
E(r)\ge \sup_z\left|W_r-\frac{\sigma^2}{2}W_{zz}+\frac z2W_z
-\frac12W-H_M(W_z)\right|.
$$

对 $W$ 重做第 3 节的 Itô 计算。任意可行控制的 Hamilton 缺口非负。取 $u_M(W_z)$ 时缺口为零。在任何远离剩余时间零的紧时窗，该反馈对空间 Lipschitz，且一致有界，可沿用第 3 节的反射解构造。两向界给出

$$
e^{-r/2}\sup_z |W(r,z)-w_M(r,z)|
\le B_0+\int_0^r e^{-s/2}E(s)\,ds.
$$

因此若 $e^{-R/2}W(R,0)$ 可由区间算术上下夹住，它与 $C_*$ 的差还只须加上本定理控制截断误差，以及由
$|w_M(R,0)-m_M(R)|\le b-a$ 和折扣尾项得到的
$e^{-R/2}[b-a+c_{\mathrm K}+2G(0)]$。此项提供离散求值所需的独立验证入口。本文复算只校验解析误差项，不报告未经残差核验的数值网格解。

## 6. 对称走廊的反馈时间依赖

$H_M$ 为偶函数，方程及边界对镜像取反保持，唯一性给出 $p_M$ 奇对称。在半区间 $(0,\kappa)$，边界值为 $0,1$ 且初值为零，最大原理给出 $p_M\ge0$，强最大原理给出任意正时刻和内点 $p_M>0$。因此 $u_M(p_M)<0$，而随剩余时间趋零趋于 $u_M(0)=0$。这是显式验证反馈的时间依赖。结论不排斥在更广的无界、奇异策略类里借助不同方式实现同一个风险。

## 主要近邻

- Gui、Barber、Ma, [The cost of enforcing long-run coverage: a phase transition in online conformal prediction](https://arxiv.org/pdf/2611.21542v1)，原问题、阶及最近精确预言机的损失。
- Li 与 Tang, [Optimal stochastic control with recursive cost functionals of stochastic differential systems reflected in a domain](https://www.esaim-cocv.org/articles/cocv/pdf/2015/04/cocv140062.pdf)，反射控制及非线性 Neumann 条件的相邻文献。本文特定一维归一化和通量积分用于原未知分布共形首项。
- 对具体证明使用区间反射映射、标准 Dirichlet 热核估计和 Itô 验证。
