# 高斯乘积机制的精确渐近隐私增益

## 反向全阶系数趋零与可认证的计数依赖 zCDP 预算

2026 年 11 月 24 日 · AI 辅助研究稿 · 目标读者：差分隐私、概率论与信息论方向的博士研究生及研究人员

## 摘要

Pujol 与 Desfontaines 提出了一种两阶段直方图机制：先加入固定方差的高斯噪声，再加入标准差与第一阶段输出绝对值成比例的高斯噪声。其单坐标分布为
$Q_x=\mathcal L((x+\sigma Z)(1+rW))$，其中 $Z,W$ 为独立标准正态变量。先前的研究案例已证明该机制具有不可消失的全阶隐私下限，并确定了从较大计数指向较小计数方向的精确大计数极限。反方向的全阶上确界，以及由两个方向共同决定的最优零集中差分隐私（zCDP）预算，当时仍未确定。

本文证明反向全阶系数趋于零。证明同时控制所有实数 Rényi 阶数，包括任意大的阶数：先把混合高斯变量分成常规部分与指数小的中央余项，再通过方差更大的高斯核控制常规部分，并用一致的对数矩估计控制余项。结合本文重新完整证明并明确归属的既有正向上界与尾部下界，得到

$$
\lim_{x\to\infty}\sup_{\alpha>1}\frac1\alpha
\max\{D_\alpha(Q_{x+h}\Vert Q_x),D_\alpha(Q_x\Vert Q_{x+h})\}
=\frac{h^2}{4\sigma^2}.
$$

因此，对相差一个记录的邻接，最优预算恰好趋于原始高斯预算的一半。我们还构造了显式、非增且只依赖计数的预算，并对两组参数给出有限计数门槛的精确有理数证书。结论针对原始、未经截断的机制。本文没有确定每个有限计数处的精确最优值、反向收敛的最优速率，或完整的效用约束机制设计问题。本稿尚未经过外部同行评议，也没有证明助理认证。

## 1. 问题、既有结果与本文贡献

设

$$
Y_x=(x+\sigma Z)(1+rW),\qquad
Z,W\overset{\mathrm{iid}}\sim N(0,1),\quad \sigma,r>0.
\tag{1.1}
$$

给定 $X=x+\sigma Z$，输出服从 $N(X,r^2X^2)$。因此，式 (1.1) 与 Pujol–Desfontaines [PD23] 的 Algorithm 1 完全相同，包含第一阶段输出为负以及乘性高斯因子取任一符号的情况。我们没有裁剪、截断或通过条件化排除任何输出。在增加或删除一个记录的邻接下，单独发布 $x+\sigma Z$ 满足预算为

$$
\rho=\frac1{2\sigma^2}.
\tag{1.2}
$$

的 zCDP。后处理性质使式 (1.1) 也满足这一上界 [BS16]。原问题询问：额外随机化能否使较大计数获得更小的隐私预算，或者能否通过其他机制实现这一目标。

Azize [A23] 已识别出乘积正态分布，并写出了相应的 Rényi 积分。因此，乘积表示是本文使用的既有结果。Fitzsimons [F26] 研究的是替代机制方向：在明确修正零计数处的效用要求后，构造平移对数高斯机制。该构造及其计数平方反比的隐私预算衰减率属于另一种随机机制。本文保留式 (1.1)，直接分析它的全阶隐私。乘积正态密度的渐近性质，包括零点的对数奇性，也属于已有分布理论 [GY24]。

先前研究稿 [Prev26] 已证明三个与本文相关的结果：每条相邻边都有 $\rho/2$ 的预算下限；每个固定有限 Rényi 阶数下的散度均趋于零；正向全阶系数趋于 $\rho/2$。该案例明确把反向全阶上确界和双向最优值保留为未解决问题。本文闭合这个缺口，并给出非增的有限计数证书。第 4、5 节在明确归属的前提下重新给出所需既有论证，因此新定理不依赖于把未经验证的结论直接当作黑箱。

固定阶控制与全阶控制的区别是关键。有限个 Rényi 阶数上的散度可以同时趋于零，而某个无界增长的阶数序列仍然保留正的归一化隐私损失。下述定理先控制全部实数 $\alpha>1$ 上的上确界，再令计数趋于无穷。

全文使用自然对数。对正密度 $p,q$，定义

$$
D_\alpha(P\Vert Q)
=\frac1{\alpha-1}\log\int p(y)^\alpha q(y)^{1-\alpha}\,dy,
\qquad \alpha>1.
\tag{1.3}
$$

下文的不等式同时保证其所述范围内的积分有限。我们还使用 $D_\alpha$ 关于阶数的标准单调性与数据处理性质。

## 2. 主定理与显式上界

记

$$
P_{a,b}=\mathcal L((a+Z)(b+W)),\qquad a,b\in\mathbb R,
$$

并固定 $b\in\mathbb R$、$d>0$。对 $a>0$，定义

$$
U_+(a)=\sup_{\alpha>1}\frac{D_\alpha(P_{a+d,b}\Vert P_{a,b})}{\alpha},
\quad
U_-(a)=\sup_{\alpha>1}\frac{D_\alpha(P_{a,b}\Vert P_{a+d,b})}{\alpha}.
\tag{2.1}
$$

最优双向系数为
$V(a)=\max\{U_+(a),U_-(a)\}$。由于只有两个方向，它也等于两个归一化散度的逐阶最大值在全部阶数上的上确界。

令

$$
A_0=\max\{2,d+1,b^2/d\},
\tag{2.2}
$$

$$
F_a=\frac{d^2}{4}+\frac{9d^2}{4(2a-1)}+\frac{b^2d^2}{2a},
\tag{2.3}
$$

$$
R_a=\frac{(4+b^2)d}{a}
+2\exp\!\left(\frac{b^2-a^2}{2}\right)
+64a\exp\!\left(\frac{3(1+b^2)}2-\frac{a^2}{8}\right).
\tag{2.4}
$$

**定理 1（双向全阶渐近）。** 对每个固定的 $b\in\mathbb R$、$d>0$ 和每个 $a\ge A_0$，有

$$
U_-(a)\le R_a,\qquad U_+(a)\le F_a,
\tag{2.5}
$$

以及

$$
\frac{d^2}{4}\le V(a)
\le\min\!\left\{\frac{d^2}{2},\max(F_a,R_a)\right\}.
\tag{2.6}
$$

$F_a$ 与 $R_a$ 在 $[A_0,\infty)$ 上均非增。特别地，

$$
\boxed{\lim_{a\to\infty}U_-(a)=0,\qquad
\lim_{a\to\infty}U_+(a)=\lim_{a\to\infty}V(a)=d^2/4.}
\tag{2.7}
$$

这里对 $U_-$ 的上界为 $O_{b,d}(1/a)$；本文不声称这一速率最优。对 $U_+$ 的上界和上述下界已在 [Prev26] 中建立，本文第 4、5 节重新推导。新的反向一致估计将在下一节证明。

## 3. 反方向的一致控制

令 $p=f_{a,b}$、$q=f_{a+d,b}$，其中 $f$ 表示乘积正态密度，$\phi$ 表示标准正态密度。给定非零的第一因子 $x\ne0$，乘积的条件密度为

$$
k_x(y)=\frac1{|x|}\phi(y/x-b).
\tag{3.1}
$$

因此，$p(y)=\int\phi(x-a)k_x(y)\,dx$。在 $y=0$ 处，密度值可能为无穷；下文全部密度不等式与积分均按几乎处处的意义理解。

### 3.1. 高斯核比较与负第一因子的处理

对标准差满足 $0<u<v$ 的正态密度，完成平方得到

$$
\sup_y\frac{g_{\mu,u}(y)}{g_{\nu,v}(y)}
=\frac vu\exp\!\left(\frac{(\mu-\nu)^2}{2(v^2-u^2)}\right).
\tag{3.2}
$$

把定义 $p$ 的积分分为 $x\ge a/2$、$x\le-a/2$ 和 $|x|<a/2$ 三部分。

对 $x=u\ge a/2$，与分母混合中的取值 $x'=u+d$ 比较。两个混合高斯密度相等：
$\phi(u-a)=\phi(x'-(a+d))$。相应的条件均值为 $bu$ 与 $b(u+d)$，标准差为 $u$ 与 $u+d$。由式 (3.2)，

$$
k_u(y)\le\left(1+\frac du\right)
\exp\!\left(\frac{b^2d}{2(2u+d)}\right)k_{u+d}(y)
\le K_a^+k_{u+d}(y),
\tag{3.3}
$$

其中

$$
K_a^+=\left(1+\frac{2d}{a}\right)
\exp\!\left(\frac{b^2d}{2(a+d)}\right).
\tag{3.4}
$$

对负半轴部分，写成 $x=-u$，其中 $u\ge a/2$，并通过反射与分母混合中的正取值 $u+d$ 比较。混合密度之比为

$$
\frac{\phi(-u-a)}{\phi(u-a)}=e^{-2au}.
$$

此时两个条件均值分别为 $-bu$ 与 $b(u+d)$。因此

$$
\frac{\phi(-u-a)k_{-u}(y)}{\phi(u-a)k_{u+d}(y)}
\le\left(1+\frac du\right)
\exp\!\left[-2au+\frac{b^2(2u+d)}{2d}\right].
\tag{3.5}
$$

由于 $a\ge b^2/d$，指数不超过
$-au+b^2/2\le-a^2/2+b^2/2$。所以负半轴部分对密度的贡献至多为 $K_a^-q(y)$，其中

$$
K_a^-=\left(1+\frac{2d}{a}\right)
\exp\!\left(\frac{b^2-a^2}{2}\right).
\tag{3.6}
$$

正半轴部分与反射后的负半轴部分在分母混合中的像区间有重叠，因此必须把两个常数相加。定义 $K_a=K_a^++K_a^-$，则两部分的总贡献至多为 $K_aq(y)$。特别地，$K_a\ge1$ 且 $K_a\to1$。

### 3.2. 中央余项及其对数矩

令 $U$ 在 $[-1/2,1/2]$ 上均匀分布，并与 $W$ 独立；令 $H_a$ 表示 $aU(b+W)$ 的密度。在 $|x|<a/2$ 上，
$\phi(x-a)\le\phi(a/2)$。而 $H_a$ 所用的混合密度在该区间上为 $1/a$，故

$$
p(y)\le K_aq(y)+\epsilon_a H_a(y),\qquad
\epsilon_a=\frac{a}{\sqrt{2\pi}}e^{-a^2/8}.
\tag{3.7}
$$

这是密度支配不等式，右边两个系数无须相加为一。

令 $v=y/a$、$\ell(v)=\log_+(1/|v|)$。写成 $H_a(av)=h_b(v)/a$，在均匀混合积分中直接换元可得

$$
h_b(v)=\frac1{\sqrt{2\pi}}\int_{2|v|}^\infty
\frac{e^{-(s-b)^2/2}+e^{-(s+b)^2/2}}s\,ds.
\tag{3.8}
$$

利用 $(s\pm b)^2\ge s^2/2-b^2$，再作换元 $t=s^2/4$，得到

$$
h_b(v)\le\frac{e^{b^2/2}}{\sqrt{2\pi}}E_1(v^2)
\le C_0e^{-v^2}(1+\ell(v)),
\quad C_0=\frac{2e}{\sqrt{2\pi}}e^{b^2/2}.
\tag{3.9}
$$

这里 $E_1(w)=\int_w^\infty e^{-t}dt/t$。当 $0<|v|\le1$ 时，使用 $E_1(v^2)\le2\ell(v)+1$ 与 $e^{-v^2}\ge e^{-1}$；当 $|v|\ge1$ 时，使用 $E_1(v^2)\le e^{-v^2}/v^2$。这就得到上述全域上界，无须采用渐近近似。

为从下方控制分母，把其正半轴混合积分限制到 $x\in[a+d,a+d+1]$。条件 $a\ge d+1$ 保证 $a\le x\le2a$。此外，$\phi(x-a-d)\ge\phi(1)$ 且 $|av/x-b|\le|v|+|b|$，因此

$$
aq(av)\ge c_0e^{-v^2/2-|b||v|},
\qquad c_0=\frac{e^{-(1+b^2)/2}}{4\pi}.
\tag{3.10}
$$

对每个实数 $\alpha\ge2$，直接组合式 (3.9) 与 (3.10)，得到

$$
\begin{aligned}
\int (H_a/q)^\alpha q
&=\int\frac{h_b(v)^\alpha}{(aq(av))^{\alpha-1}}\,dv\\
&\le C_0^\alpha c_0^{1-\alpha}e^{(\alpha-1)b^2/2}
\int e^{-v^2}(1+\ell(v))^\alpha\,dv.
\end{aligned}
\tag{3.11}
$$

在处理指数时使用了 $|b||v|\le(v^2+b^2)/2$，其中的 $v^2$ 项恰好合并为因子 $e^{-v^2}$。

剩余积分满足

$$
\begin{aligned}
J_\alpha
&\le 2\int_0^\infty(1+s)^\alpha e^{-s}\,ds+\sqrt\pi\\
&\le(2e+\sqrt\pi)\Gamma(\alpha+1).
\end{aligned}
\tag{3.12}
$$

为使论证完整，注意 $\Gamma(\alpha+1)\ge1$ 可由均值为一的指数随机变量的 $\alpha$ 阶矩及 Jensen 不等式得到。若 $n=\lceil\alpha\rceil$，概率测度下 $L^p$ 范数的单调性与算术–几何平均不等式给出

$$
\Gamma(\alpha+1)^{1/\alpha}
\le(n!)^{1/n}\le(n+1)/2\le\alpha\qquad(\alpha\ge2).
$$

因此，$J_\alpha^{1/\alpha}\le4\alpha$。又因为 $c_0<1$，式 (3.11) 给出一致估计

$$
\|H_a/q\|_{L^\alpha(q)}\le C\alpha,
\qquad
C=\frac{4C_0e^{b^2/2}}{c_0}
=16\sqrt{2\pi}\,e^{3(1+b^2)/2}.
\tag{3.13}
$$

该常数不依赖于 $a$、$d$ 或 $\alpha$，并显式写出了它对固定第二因子均值 $b$ 的依赖。这里有意采用保守常数。

### 3.3. 全部 Rényi 阶数与显式反向上界

对式 (3.7) 与 (3.13) 使用 Minkowski 不等式，得到

$$
\left(\int p^\alpha q^{1-\alpha}\right)^{1/\alpha}
\le K_a+C\epsilon_a\alpha\qquad(\alpha\ge2).
$$

所以

$$
\frac{D_\alpha(p\Vert q)}\alpha
\le\frac{\log(K_a+C\epsilon_a\alpha)}{\alpha-1}
\le\log K_a+2C\epsilon_a\qquad(\alpha\ge2).
\tag{3.14}
$$

这里使用了 $K_a\ge1$、$\log(1+t)\le t$ 和 $\alpha/(\alpha-1)\le2$。对于 $1<\alpha<2$，阶数单调性给出

$$
\frac{D_\alpha(p\Vert q)}\alpha
\le D_2(p\Vert q)
\le2\log(K_a+2C\epsilon_a)
\le2\log K_a+4C\epsilon_a.
\tag{3.15}
$$

因此，$U_-(a)\le2\log K_a+4C\epsilon_a$。最后，

$$
\begin{aligned}
2\log K_a
&\le\frac{(4+b^2)d}{a}
+2e^{(b^2-a^2)/2},\\
4C\epsilon_a
&=64a e^{3(1+b^2)/2-a^2/8}.
\end{aligned}
$$

第一行通过从 $K_a$ 中提出因子 $K_a^+$，再使用 $\log(1+t)\le t$ 和 $a+d\ge a$ 得到。这就对每个实数阶数大于一的情形一致证明了 $U_-(a)\le R_a$，无须设置任何依赖于 $a$ 的阶数截断。

## 4. 正向全阶上界：重述并证明先前案例的方法

本节重述并证明 [Prev26] 的高斯提升方法。固定 $\alpha>1$ 与 $t>0$，定义

$$
\Delta_1=1+\alpha(t^2-1),\qquad
\Delta_2=1+\alpha(t^{-2}-1).
$$

两个分别服从 $N(at,t^2)$ 与 $N(b/t,t^{-2})$ 的独立变量，其乘积仍服从 $P_{a,b}$。将这一独立变量对与 $N(a+d,1)\otimes N(b,1)$ 比较，再对乘法映射使用数据处理不等式。只要 $\Delta_1,\Delta_2>0$，就有

$$
\frac{D_\alpha(P_{a+d,b}\Vert P_{a,b})}{\alpha}
\le\frac{(a+d-at)^2}{2\Delta_1}
+\frac{b^2(1-t^{-1})^2}{2\Delta_2}
-\frac{\log(\Delta_1\Delta_2)}{2\alpha(\alpha-1)}.
\tag{4.1}
$$

事实上，在一维正态积分中完成平方，得到

$$
D_\alpha(N(\mu,1)\Vert N(\nu,v))
=\frac{\alpha(\mu-\nu)^2}{2(\alpha v+1-\alpha)}
+\frac{\alpha\log v-\log(\alpha v+1-\alpha)}{2(\alpha-1)}.
$$

两个方差对数项在独立变量对的比较中相消，从而证明式 (4.1)。此外，

$$
\Delta_1\Delta_2
=1-\alpha(\alpha-1)(t-t^{-1})^2.
\tag{4.2}
$$

选取 $0<\kappa<1$，令 $\lambda=1-\kappa$，并取

$$
t=\min\{1+d/a,\sqrt{1+\lambda/\alpha}\}.
\tag{4.3}
$$

则 $\Delta_2\ge\kappa$，且
$\Delta_1\Delta_2\ge\kappa(2-\kappa)$。为验证后一个不等式，注意式 (4.2) 中的乘积在 $t\ge1$ 时随 $t$ 增长而下降，而它在所允许的上端点处取值为

$$
(1+\lambda)\frac{\alpha\kappa+\lambda}{\alpha+\lambda}
\ge\kappa(2-\kappa).
$$

若式 (4.3) 取第一个分支，式 (4.1) 中的第一个均值差为零；若取第二个分支，则 $\Delta_1=2-\kappa$ 且 $0\le a+d-at\le d$。因此，第一项至多为 $d^2/[2(2-\kappa)]$。由于 $0\le1-t^{-1}\le t-1\le d/a$，第二项至多为 $b^2d^2/(2\kappa a^2)$。

对于最后一项，令 $z=\alpha(\alpha-1)(t-t^{-1})^2$。此时 $0\le z<1$，且 $-\log(1-z)\le z/(1-z)$。又因 $t-t^{-1}\le2(t-1)\le2d/a$，最后一项至多为
$2d^2/[\kappa(2-\kappa)a^2]$。于是，对全部 $\alpha>1$ 同时有

$$
U_+(a)\le\frac{d^2}{2(2-\kappa)}
+\frac{d^2}{a^2}\left[\frac{b^2}{2\kappa}+\frac{2}{\kappa(2-\kappa)}\right].
\tag{4.4}
$$

当 $a\ge2$ 时，选取 $\kappa=1/a$。精确化简得到

$$
\frac{d^2a}{2(2a-1)}+\frac{2d^2}{2a-1}+\frac{b^2d^2}{2a}
=\frac{d^2}{4}+\frac{9d^2}{4(2a-1)}+\frac{b^2d^2}{2a}=F_a.
$$

这就证明了定理 1 中的正向上界。

## 5. 不可消失的下界：自包含的尾部论证

本节尾部方法重述 [Prev26] 的相关部分；乘积正态分布的基础渐近性质已在 [GY24] 中建立。我们使用显式不等式，从而避免交换无界积分与逐点渐近。

对任意 $u,b\in\mathbb R$，令
$A(u,b)=(u^2+b^2)/2+|u|+|b|+3$。对于 $s\in\{-1,+1\}$、$z\ge1$，有

$$
e^{-A(u,b)}z^{-1/2}e^{-z+|u+sb|\sqrt z}
\le f_{u,b}(sz)
\le z^{-1/2}e^{-z+|u+sb|\sqrt z}.
\tag{5.1}
$$

下面给出直接证明。将两个独立正态变量旋转为
$S=((u+Z)+(b+W))/\sqrt2$、$T=((u+Z)-(b+W))/\sqrt2$，它们的均值分别为 $m=(u+b)/\sqrt2$ 与 $n=(u-b)/\sqrt2$。原乘积等于 $(S^2-T^2)/2$。给定 $T=t$，把 $S$ 的两个原像贡献相加，对 $z>0$ 得到

$$
f_{u,b}(z)=\frac{e^{-z-(m^2+n^2)/2}}\pi
\int_{\mathbb R}\frac{e^{-t^2+nt}\cosh(m\sqrt{2z+t^2})}{\sqrt{2z+t^2}}\,dt.
\tag{5.2}
$$

对于上界，使用 $\cosh w\le e^{|w|}$、
$\sqrt{2z+t^2}\le\sqrt{2z}+|t|$，以及分母至少为 $\sqrt{2z}$。令 $k=|m|+|n|=\sqrt2\max(|u|,|b|)$，剩余积分至多为 $2\sqrt\pi e^{k^2/4}$。代回后得到的常数为 $\sqrt{2/\pi}e^{-\min(u^2,b^2)/2}\le1$。

对于下界，把 $t$ 限制在 $[-1,1]$ 上，使用 $\cosh w\ge e^{|w|}/2$、分母至多为 $\sqrt{3z}$，以及 $e^{-t^2+nt}\ge e^{-1-|n|}$。所得常数至少为 $e^{-(u^2+b^2)/2-1-|n|}/(\pi\sqrt3)\ge e^{-A(u,b)}$。交换 $S$ 与 $T$ 即得负尾部界。式 (5.1) 得证。

当 $a\ge0$ 时，选取 $s$ 使 $sb=|b|$。则 $P_{a+d,b}$ 与 $P_{a,b}$ 的对应尾部系数之差恰好为 $d$。对分子密度使用下界，对分母密度使用上界，得到

$$
\int f_{a+d,b}^\alpha f_{a,b}^{1-\alpha}
\ge e^{-\alpha A(a+d,b)}
\int_1^\infty z^{-1/2}e^{-z+(a+|b|+\alpha d)\sqrt z}\,dz.
\tag{5.3}
$$

令 $c_\alpha=a+|b|+\alpha d$，并作换元 $w=\sqrt z$。完成平方后，积分变为

$$
2e^{c_\alpha^2/4}\int_{1-c_\alpha/2}^\infty e^{-t^2}\,dt.
$$

最后一个积分趋于 $\sqrt\pi$。因此，对式 (5.3) 取对数，再除以 $\alpha(\alpha-1)$，得到

$$
\liminf_{\alpha\to\infty}
\frac{D_\alpha(P_{a+d,b}\Vert P_{a,b})}{\alpha}\ge d^2/4.
\tag{5.4}
$$

特别地，$U_+(a)\ge d^2/4$。两个方向的通用上界均为 $d^2/2$：比较 $N(a,1)$ 与 $N(a+d,1)$，加入相同且独立的第二因子，再把乘法作为后处理即可得到。式 (3.14)—(3.15)、(4.4) 与 (5.4) 共同证明式 (2.6) 和极限 (2.7)。

为验证单调性，注意 $F_a$ 中的非常数项在 $a>1/2$ 时递减。$R_a$ 的前两项在 $a>0$ 时递减，而

$$
\frac d{da}\left(ae^{-a^2/8}\right)=e^{-a^2/8}(1-a^2/4)\le0
\quad\text{for }a\ge2.
$$

这就证明了定理 1 的剩余断言。

## 6. 原始计数机制的非增预算

同乘非零常数 $\sigma r$ 是可测双射，因此保持 Rényi 散度。在式 (1.1) 中取

$$
a=x/\sigma,\qquad b=1/r,\qquad d=h/\sigma.
$$

定理 1 即给出摘要中的精确渐近系数。对于相差一个记录的邻接，取 $d=1/\sigma$、$b=1/r$、$\rho=d^2/2$，并让 $A_0$、$F$、$R$ 使用这些参数。

定义 $v(0)=\rho$。对整数 $n\ge1$，令 $a_n=(n-1)/\sigma$，并设

$$
v(n)=
\begin{cases}
\rho,&a_n<A_0,\\
\min\{\rho,\max(F_{a_n},R_{a_n})\},&a_n\ge A_0.
\end{cases}
\tag{6.1}
$$

**推论 2（只依赖计数的全阶证书）。** 序列 $v$ 非增，且对每个 $n\ge1$ 和每个 $\alpha>1$，

$$
\max\{D_\alpha(Q_n\Vert Q_{n-1}),D_\alpha(Q_{n-1}\Vert Q_n)\}
\le\alpha v(n).
\tag{6.2}
$$

此外，$v(n)\to\rho/2$，并且这些相邻边上的任何有效预算，其下极限都不能低于 $\rho/2$。

**证明。** 当 $a_n<A_0$ 时，使用初始高斯机制的后处理上界；否则使用式 (2.6)。单调性来自 $F$ 与 $R$ 的单调性，也覆盖从常数前缀 $\rho$ 转入第二个分支的边界。下界和极限由定理 1 得到。在边 $n\leftrightarrow n+1$ 上，式 (6.2) 使用 $v(n+1)\le v(n)$，所以对于以任一端点作为起点的原始有序对定义，它都满足要求，没有遗漏任何邻接端点。对于各坐标独立发布的直方图，不变坐标的密度因子在似然比中相消，因此单坐标证明适用于某一群组发生一个记录的变化。$\square$

对每组固定的 $\sigma,r>0$，式 (6.1) 在全部充分大的计数处给出严格改进。其中的常数尚未优化。尤其是，该表达式给出的充分门槛，不必是实际最优隐私预算首次出现改进的计数。

### 6.1. 精确的有限证书

随附程序只使用 Python 标准库，以有理数运算计算式 (2.3)—(2.4) 的上界。对于 $t\ge0$，程序采用经证明成立的不等式

$$
e^{-t}\le\left(\sum_{j=0}^{32}\frac{t^j}{j!}\right)^{-1}.
\tag{6.3}
$$

下表列出的十进制上界，均由有理数证书向上舍入得到。每个上界都覆盖两个方向和全部实数 Rényi 阶数。

| 参数 | 相邻边的较大计数 $n$ | 初始预算 $\rho$ | 可认证的 $\max(F,R)$ 上界 | 精确的极限最优值 |
| --- | ---: | ---: | ---: | ---: |
| $\sigma=1,r=1$ | 12 | 0.5 | 0.458362719521 | 0.25 |
| $\sigma=10,r=3/10$ | 3024 | 0.005 | 0.004998713567 | 0.0025 |

对每一行，把较大计数减一后，仅 $R$ 的第一项就已至少为 $\rho$。由单调性可知，表中计数是所显示的充分 $F/R$ 证书首次获得严格改进的整数门槛。这不是对尚未确定的有限计数精确最优值的声明。由于可认证预算非增，表中每项改进在所有更大的计数处持续成立。

程序还验证了两个高斯核比较中的 200 项有限有理数二次式配方恒等式、正向上界化简中的 120 项精确代入，以及一项清除分母后的多项式恒等式。这些检查只验证各自明示的有限计算。一般定理由上述解析证明支持，而不是由数值覆盖或 Rényi 阶数采样支持。

## 7. 范围与剩余问题

本文新增结论是：对保持不变的高斯乘积机制，反向全阶系数趋于零，进而确定双向系数的精确渐近值。结合显式的计数依赖证书，这沿 [PD23] 的原机制方向建立了有界倍数的隐私改进。“一半”指 zCDP 预算这一数学量，不表示实际泄露风险在操作意义上也恰好减半。

有限计数处的精确双向最优值仍未确定。反向估计是一个一致的 $O(1/a)$ 上界，不是尖锐的渐近展开。当 $r$、$\sigma$ 或邻接变化量随计数变化时，本文不作一致结论。证明没有分析裁剪或截断后的变体，也没有修复原始零计数处的相对误差要求，或在全部替代机制上优化效用。这些都属于另外的问题。

证书仅使用 Python 标准库与有理数运算。本稿没有 Lean 或其他端到端形式化认证。本版本暂未附计算程序和原始输出；本文未经外部同行评议，不声称全球优先权。

## 参考文献

- **[PD23]** David Pujol and Damien Desfontaines. *Open problem — Better privacy guarantees for larger groups*. 2023 年 6 月 26 日。原始问题陈述与 Algorithm 1。https://differentialprivacy.org/open-problem-better-privacy-guarantees-for-larger-groups/
- **[A23]** Achraf Azize. *Open problem — Better privacy guarantees for larger groups*. 作者托管研究笔记，2023 年，第 2.2 节。https://achraf-azize.github.io/Open_problem_Better_privacy_guarantees_for_larger_groups.pdf
- **[F26]** Jack Fitzsimons. *Better Privacy Guarantees for Larger Groups*. 稿件日期为 2026 年 7 月 15 日；arXiv:2607.14406。https://arxiv.org/abs/2607.14406 。本文比较的稿件通过公开全文镜像读取；文献比较限于已取得的版本。
- **[BS16]** Mark Bun and Thomas Steinke. *Concentrated Differential Privacy: Simplifications, Extensions, and Lower Bounds*. TCC 2016-B。DOI: 10.1007/978-3-662-53641-4_24。https://privacytools.seas.harvard.edu/sites/g/files/omnuum6656/files/privacytools/files/simp.pdf
- **[GY24]** Robert E. Gaunt and Zixin Ye. *Asymptotic approximations for the distribution of the product of correlated normal random variables*. 指定版本稿件 arXiv:2309.07734v2；DOI: 10.1016/j.jmaa.2024.128987。https://arxiv.org/html/2309.07734v2
- **[Prev26]** *A nonvanishing privacy floor for Gaussian-product post-processing*. 研究稿，2026 年 11 月 24 日。其第 3、5、8 节给出本文复用的尾部下界及正向全阶上界。[相关论文](../gaussian-product-privacy-floor/paper.zh.md)。
