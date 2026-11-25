# 乘积高斯机制的非消失 zCDP 下界

## 精确高阶 Rényi 极限、固定阶收敛与单向全阶最优界

2026 年 11 月 24 日 · AI 辅助研究稿 · 目标读者：博士研究生及相关领域研究者

## 摘要

Pujol 与 Desfontaines 提出一种面向直方图计数的两阶段高斯机制：先加入固定方差的高斯噪声，再加入标准差与第一阶段输出绝对值成比例的独立高斯噪声。他们询问，第二阶段能否使较大群组获得更强的 zCDP 保证。本文分析这一原始随机机制，给出任意实数均值下乘积高斯分布的精确有向高阶 Rényi 极限。对原机制，每个非负计数与其向上相邻计数之间的双向、全阶 zCDP 预算均至少为初始高斯预算的一半。这一下界与计数大小无关，因此原机制的 zCDP 预算不能随群组规模增长而趋于零。

与此相对，每个固定有限阶数下，两个方向的 Rényi divergence 都随计数增长而趋于零。我们给出保留乘积的高斯变量缩放，从而得到显式有限参数上界，无需仅凭密度收敛推断 divergence 收敛。该方法还证明：从较大计数指向较小计数的单向最优全阶系数，确实趋于上述一半预算下界。显式密度不等式还给出仅用有理数运算即可复算的有限阶下界证书。本文不声称已经求出两个方向合并后的最优全阶预算，也不声称解决原开放问题中替代机制的设计与最优性问题。

本文为公开研究稿，尚未经过外部同行评议。定理由解析证明支持，有限计算提供额外核验和具体证书。

## 1. 原问题、机制与研究范围

考虑单个直方图单元的发布机制

$$
Y_x=(x+\sigma Z)(1+rW),\qquad
Z,W\overset{\mathrm{iid}}\sim N(0,1),\qquad \sigma,r>0.
\tag{1.1}
$$

给定第一阶段输出 $X=x+\sigma Z$，式 (1.1) 的条件分布为 $N(X,r^2X^2)$。因此它与“先加入固定标准差的高斯噪声，再加入标准差为 $r|X|$ 的高斯噪声”完全相同。即使第一阶段输出为负，这一表示也成立。本文不对高斯因子作截断，不把它们改成正值随机变量，也不修改原机制。

对加一／减一邻接，第一阶段高斯机制的 zCDP 参数是

$$
\rho=\frac{1}{2\sigma^2}.
\tag{1.2}
$$

由后处理性质，式 (1.1) 仍满足同一参数的 zCDP。原问题询问第二阶段能带来多强的、依赖群组计数的改进。本文证明这一机制存在无法消失的全阶隐私下界；它仍可能在 $\rho/2$ 与 $\rho$ 之间获得改进。

把原机制识别为两个正态变量的乘积并非本文的新结果。Azize [2，第 2.2 节] 已经给出这一表示、含 Bessel 函数的密度和相应的 Rényi 积分，并把所需的上界分析留待后续完成。Fitzsimons [3] 研究的是另一种机制，在明确修正零计数效用条件后建立最优的计数平方反比阶数；该稿也明确区分其替代构造与原始随机机制。乘积正态分布的尾部及零点渐近展开同样属于已有分布理论，特别可参见 Gaunt 与 Ye [5]。本文为后续隐私分析和可复算证书给出适用于独立因子的简短证明与显式常数，不把这些分布事实或替代机制记作新贡献。

原问题在零计数处另有效用条件的障碍。本文的结论不依赖该障碍：隐私下界对每条正计数邻接边成立，实际上覆盖全部实数 $x\ge0$。也不能仅从高阶极限推断全阶最优预算；必须另外控制全体阶数的上确界，本文只在较大计数指向较小计数的方向完成了这一步。

全文使用自然对数。对 $\alpha>1$，定义

$$
D_\alpha(P\Vert Q)
=\frac{1}{\alpha-1}\log\int p^\alpha q^{1-\alpha},
\tag{1.3}
$$

其中 $p,q$ 为相应密度。若同一预算 $v$ 对每个 $\alpha>1$ 均满足

$$
D_\alpha(P\Vert Q)\le\alpha v,
$$

则称 $v$ 为这一有向分布对的全阶系数。对无向邻接边，zCDP 同时要求两个方向满足这一不等式。必须区分有向系数与两个方向取最大值得到的预算。

## 2. 一般乘积高斯分布的精确高阶极限

记

$$
P_{a,b}=\mathcal L\big((a+Z)(b+W)\big),
\qquad a,b\in\mathbb R,
$$

其中 $Z,W$ 独立标准正态。对 $s\in\{+1,-1\}$，定义

$$
L_s(a,b)=|a+sb|,
\qquad
\Delta_s(a,c;b)=L_s(a,b)-L_s(c,b).
\tag{2.1}
$$

对实数 $u$，记 $u_+=\max\{u,0\}$。

**定理 1（精确有向高阶极限）。** 对任意固定 $a,c,b\in\mathbb R$，$P_{a,b}$ 与 $P_{c,b}$ 之间的每个有限阶 Rényi divergence 均有限，而且

$$
\boxed{
\lim_{\alpha\to\infty}
\frac{D_\alpha(P_{a,b}\Vert P_{c,b})}{\alpha}
=
\frac14\max\big\{
(\Delta_+(a,c;b))_+^2,
(\Delta_-(a,c;b))_+^2
\big\}.
}
\tag{2.2}
$$

若两个乘积同时乘以同一个非零确定性常数，结论不变。这是因为 Rényi divergence 在共同的可逆可测坐标变换下保持不变。

式 (2.2) 中的正部不能省略。某一方向的分子尾部若比相应分母尾部更轻，就不会贡献正的二次指数增长率。特别地，交换 $a$ 与 $c$ 一般会改变答案。

下面分别处理无穷远处的两个尾部和零点奇性，再给出高阶积分证明。

## 3. 无穷远处的双侧密度界

记 $f_{a,b}$ 为 $P_{a,b}$ 的密度。引入独立正态变量

$$
S=\frac{(a+Z)+(b+W)}{\sqrt2}\sim N(m,1),
\qquad
T=\frac{(a+Z)-(b+W)}{\sqrt2}\sim N(n,1),
$$

其中

$$
m=\frac{a+b}{\sqrt2},\qquad
n=\frac{a-b}{\sqrt2}.
$$

于是

$$
(a+Z)(b+W)=\frac{S^2-T^2}{2}.
$$

对 $z>0$，给定 $T=t$，变量 $S$ 有两个原像 $\pm\sqrt{2z+t^2}$。每个原像对 $z$ 的导数绝对值都是 $(2z+t^2)^{-1/2}$。因此

$$
f_{a,b}(z)
=
\frac{e^{-z-(m^2+n^2)/2}}{\pi}
\int_{\mathbb R}
\frac{e^{-t^2+nt}\cosh\!\big(m\sqrt{2z+t^2}\big)}
{\sqrt{2z+t^2}}\,dt.
\tag{3.1}
$$

两个正态密度给出系数 $1/(2\pi)$，两个原像相加产生 $2\cosh$，所以前面的系数为 $1/\pi$。

**引理 2（显式尾部界）。** 定义

$$
A(a,b)=\frac{a^2+b^2}{2}+|a|+|b|+3.
$$

对任意 $a,b\in\mathbb R$、$s\in\{-1,+1\}$ 和 $z\ge1$，

$$
e^{-A(a,b)}z^{-1/2}e^{-z+L_s(a,b)\sqrt z}
\le f_{a,b}(sz)
\le z^{-1/2}e^{-z+L_s(a,b)\sqrt z}.
\tag{3.2}
$$

**证明。** 先处理正尾部。对任意实数 $u$，

$$
\frac12e^{|u|}\le\cosh u\le e^{|u|}.
$$

又有

$$
\sqrt{2z+t^2}\le\sqrt{2z}+|t|,
\qquad
\sqrt{2z+t^2}\ge\sqrt{2z}.
$$

因此式 (3.1) 中的积分不超过

$$
(2z)^{-1/2}e^{|m|\sqrt{2z}}
\int_{\mathbb R}e^{-t^2+nt+|m||t|}\,dt.
$$

令 $k=|m|+|n|=\sqrt2\max\{|a|,|b|\}$。把积分在零点拆开并完成平方，得到

$$
\int_{\mathbb R}e^{-t^2+nt+|m||t|}dt
\le2\sqrt\pi e^{k^2/4}.
$$

代回密度公式后，上界的常数因子至多为

$$
\sqrt{2/\pi}\,e^{-\min(a^2,b^2)/2}\le1.
$$

下界只需把积分限制到 $[-1,1]$。对 $z\ge1$，在这一区间上

$$
\sqrt{2z+t^2}\le\sqrt{3z},
\qquad
\cosh\!\big(m\sqrt{2z+t^2}\big)
\ge\tfrac12e^{|m|\sqrt{2z}},
$$

并且 $e^{-t^2+nt}\ge e^{-1-|n|}$。得到的常数因子至少为

$$
\frac{e^{-(a^2+b^2)/2-1-|n|}}{\pi\sqrt3}
\ge e^{-A(a,b)},
$$

因为 $|n|\le|a|+|b|$ 且 $\log(\pi\sqrt3)<2$。由于 $|m|\sqrt{2z}=|a+b|\sqrt z$，正尾部界已经证明。

对负尾部，交换 $S$ 与 $T$ 的角色，系数相应变成 $|a-b|$。同样的估计仍然适用，且可使用同一个 $A(a,b)$。$\square$

这些常数依赖固定均值 $a,b$，但不依赖 $z$ 或 $\alpha$。后文使用的是全尾部的双侧不等式；仅有未量化的渐近展开不足以承担后续积分估计。显式常数还将在第 9 节给出有限阶有理数证书。

## 4. 零点的对数奇性

乘积高斯密度通常在零点发散。这只是单点附近的可积对数奇性，并不导致本文的 divergence 发散。

**引理 3（零点展开与紧集似然比）。** 从任一侧令 $z\to0$，均有

$$
f_{a,b}(z)
=
\frac{e^{-(a^2+b^2)/2}}{\pi}
\log\frac1{|z|}
+O_{a,b}(1).
\tag{4.1}
$$

因此，对任意固定 $a,c,b$，两个密度比 $f_{a,b}/f_{c,b}$ 与 $f_{c,b}/f_{a,b}$ 在每个紧区间上均本质有界。

**证明。** 直接对第一个因子条件化，得到

$$
f_{a,b}(z)
=
\frac{e^{-(a^2+b^2)/2}}{2\pi}
\int_{\mathbb R}\frac1{|u|}
\exp\!\left(
-\frac{u^2}{2}-\frac{z^2}{2u^2}+au+\frac{bz}{u}
\right)du.
\tag{4.2}
$$

令 $v=|z|\in(0,1)$，把指数记为 $E(u,z)$。在两个区间 $v\le|u|\le1$ 上，指数绝对值一致有界，且

$$
|E(u,z)|\le C_{a,b}\left(|u|+\frac{v}{|u|}\right).
$$

由指数函数的中值估计，

$$
\int_{v\le|u|\le1}\frac{e^{E(u,z)}}{|u|}du
=2\log(1/v)+O_{a,b}(1),
$$

因为误差积分至多为某个固定常数乘以

$$
2\int_v^1\left(1+\frac{v}{u^2}\right)du\le4.
$$

对 $|u|\ge1$，所有含 $z/u$ 的项一致有界，而 $-u^2/2+au$ 保证剩余积分有限。对 $|u|\le v$，作变换 $w=z/u$。新区间满足 $|w|\ge1$，且测度 $du/|u|$ 变为 $|dw|/|w|$，同时交换两个高斯因子的角色，所以也得到一致有限的界。代入式 (4.2)，即得式 (4.1)。

在避开零点的紧集上，积分表示通过控制收敛给出严格正的连续密度。式 (4.1) 又表明

$$
\frac{f_{a,b}(z)}{f_{c,b}(z)}
\longrightarrow e^{(c^2-a^2)/2}\in(0,\infty).
$$

将零点附近与其余紧集结合，得到两个密度比的本质有界性。$\square$

## 5. 从尾部系数得到高阶 Rényi 极限

**引理 4（尾部指数的 Rényi 极限）。** 设正密度 $p,q$ 的两个密度比在紧集上本质有界；并且对每个 $s\in\{+1,-1\}$、所有 $z\ge1$，分别存在正常数，使 $p(sz)$ 与 $q(sz)$ 被对应形式

$$
z^{-1/2}e^{-z+L_s\sqrt z}
$$

的常数倍从上下夹住。将二者的系数记为 $L_s^p,L_s^q$。则

$$
\lim_{\alpha\to\infty}
\frac{1}{\alpha^2}
\log\int p^\alpha q^{1-\alpha}
=
\frac14\max_{s=\pm1}(L_s^p-L_s^q)_+^2.
\tag{5.1}
$$

**证明。** 在紧区间 $[-1,1]$ 上，取 $p/q\le M$。该区间对积分的贡献不超过

$$
M^{\alpha-1}\int_{-1}^{1}p\le M^{\alpha-1},
$$

其对数至多为 $O(\alpha)$。

对符号为 $s$ 的尾部，利用密度的上下界，其积分贡献在上下两个正倍数之间；这些倍数的对数都是 $O(\alpha)$，共同的主要积分为

$$
J(c_{\alpha,s})
=\int_1^\infty z^{-1/2}e^{-z+c_{\alpha,s}\sqrt z}\,dz
=2\int_1^\infty e^{-u^2+c_{\alpha,s}u}\,du,
\tag{5.2}
$$

其中

$$
c_{\alpha,s}
=\alpha L_s^p+(1-\alpha)L_s^q
=L_s^q+\alpha\Delta_s,
\qquad \Delta_s=L_s^p-L_s^q.
$$

若 $\Delta_s>0$，平方完成给出

$$
J(c_{\alpha,s})
=2e^{c_{\alpha,s}^2/4}
\int_{1-c_{\alpha,s}/2}^{\infty}e^{-v^2}dv.
$$

最后一个积分趋于 $\sqrt\pi$，因此

$$
\alpha^{-2}\log J(c_{\alpha,s})\longrightarrow\Delta_s^2/4.
$$

若 $\Delta_s=0$，则 $J$ 是固定正常数。若 $\Delta_s<0$，则充分大的 $\alpha$ 使 $c_{\alpha,s}\le0$，故

$$
J(c_{\alpha,s})\le2\int_1^\infty e^{-u^2}du.
$$

为了控制下界，把积分限制到 $1\le u\le2$。此时

$$
-u^2+c_{\alpha,s}u\ge-4+2c_{\alpha,s},
$$

所以 $\log J$ 从下方也只下降 $O(\alpha)$。两个非正差值情形的 $\alpha^2$ 级增长率均为零。

总积分是紧区间与两个尾部贡献之和。当至少一个尾部差值为正时，其对数增长率由最大的尾部增长率决定。当全部差值非正时，上界给出极限上界为零，而 Hölder 不等式

$$
\int p^\alpha q^{1-\alpha}\ge1
$$

给出极限下界为零。同样的估计也证明所有有限 $\alpha$ 下积分有限。$\square$

将引理 2、3 代入引理 4，并利用

$$
\frac{\alpha(\alpha-1)}{\alpha^2}\longrightarrow1,
$$

即证明定理 1。

## 6. 原机制的隐私下界与方向差异

记 $Q_x=\mathcal L(Y_x)$，固定 $x\ge0$ 与向上变化量 $h>0$。标准化式 (1.1)：

$$
Y_x=\sigma r(a+Z)(b+W),
\qquad
 a=\frac{x}{\sigma},\quad
 b=\frac1r,\quad
 d=\frac h\sigma.
$$

对较大计数指向较小计数的方向，正尾部系数差恰为

$$
(a+d+b)-(a+b)=d.
$$

绝对值的三角不等式又给出

$$
|a+d-b|-|a-b|\le d.
$$

因此定理 1 直接推出

$$
\boxed{
\lim_{\alpha\to\infty}
\frac{D_\alpha(Q_{x+h}\Vert Q_x)}{\alpha}
=\frac{h^2}{4\sigma^2}.
}
\tag{6.1}
$$

反方向的正尾部差值是 $-d$，只有负尾部可能贡献正的增长率。于是

$$
\boxed{
\lim_{\alpha\to\infty}
\frac{D_\alpha(Q_x\Vert Q_{x+h})}{\alpha}
=
\frac14\left(
\left|\frac x\sigma-\frac1r\right|
-
\left|\frac{x+h}\sigma-\frac1r\right|
\right)_+^2.
}
\tag{6.2}
$$

为清楚呈现方向差异，令 $\tau=\sigma/r$。式 (6.2) 等于

$$
\begin{cases}
 h^2/(4\sigma^2), & x+h\le\tau,\\
 (2\tau-2x-h)_+^2/(4\sigma^2), & x<\tau<x+h,\\
 0, & x\ge\tau.
\end{cases}
\tag{6.3}
$$

各分段在相邻边界上的值一致。实际上，只要 $x\ge\tau-h/2$，反向高阶极限就已为零。在这一范围内，反向似然比在全实轴上本质有界：其两个尾部系数均不大于分母的对应系数，引理 2 控制尾部，引理 3 控制紧区间。

**推论 5（不随计数消失的 zCDP 下界）。** 对加一／减一邻接 $h=1$，若 $v$ 对边 $x\leftrightarrow x+1$ 的两个方向、每个阶数都满足 $D_\alpha\le\alpha v$，则

$$
v\ge\frac{1}{4\sigma^2}=\frac\rho2.
$$

因此该邻接边的最优双向 zCDP 参数 $v_*(x)$ 满足

$$
\boxed{\frac\rho2\le v_*(x)\le\rho\qquad(x\ge0).}
\tag{6.4}
$$

下界来自式 (6.1)，上界来自初始高斯机制的后处理性质。式 (6.4) 不确定 $v_*(x)$ 的精确值，也不能据此断言它随 $x\to\infty$ 收敛到某一个端点。

若直方图各坐标独立运行该机制，改变一个群组只改变一个坐标。其余坐标的密度相同，在似然比中相消。因此这里的一维结论就是该单坐标邻接下完整直方图机制的结论。

## 7. 保留乘积的高斯缩放与固定阶收敛

我们给出一个直接比较上界。它同时说明：全阶预算的正下界，与固定有限阶 divergence 趋于零并不矛盾。

**引理 6（保留乘积的高斯比较）。** 固定 $a,c,b\in\mathbb R$ 与 $\alpha>1$。在本节记 $P_a=P_{a,b}$。对任意 $t>0$，定义

$$
\Delta_1=1+\alpha(t^2-1),
\qquad
\Delta_2=1+\alpha(t^{-2}-1).
$$

只要 $\Delta_1,\Delta_2>0$，就有

$$
\frac{D_\alpha(P_a\Vert P_c)}{\alpha}
\le
\frac{(a-ct)^2}{2\Delta_1}
+
\frac{b^2(1-t^{-1})^2}{2\Delta_2}
-
\frac{\log(\Delta_1\Delta_2)}{2\alpha(\alpha-1)}.
\tag{7.1}
$$

**证明。** 独立变量 $N(ct,t^2)$ 与 $N(b/t,t^{-2})$ 的乘积仍服从 $P_c$：它们分别相当于把 $c+Z$ 乘以 $t$，把 $b+W$ 除以 $t$。把这一二维高斯分布与 $N(a,1)\otimes N(b,1)$ 比较，再应用乘积映射下的数据处理不等式。独立分布的 Rényi divergence 可加，因此只需计算两个一维高斯 divergence。

当 $v>0$ 且 $\alpha v+1-\alpha>0$ 时，在定义积分中完成平方得到

$$
D_\alpha\big(N(\mu,1)\Vert N(\nu,v)\big)
=
\frac{\alpha(\mu-\nu)^2}{2(\alpha v+1-\alpha)}
+
\frac{\alpha\log v-\log(\alpha v+1-\alpha)}{2(\alpha-1)}.
$$

两个因子中的 $\alpha\log(t^2)$ 与 $\alpha\log(t^{-2})$ 恰好抵消，得到式 (7.1)。此外，

$$
\Delta_1\Delta_2
=1-\alpha(\alpha-1)(t-t^{-1})^2.
\tag{7.2}
$$

式 (7.1) 是乘积分布 divergence 的上界；其右端乘以 $\alpha$，才是上述二维高斯分布间 divergence 的精确值。$\square$

**定理 7（两个方向的固定阶收敛）。** 固定 $\sigma,r,h>0$。对每个固定有限 $\alpha>1$，

$$
\lim_{x\to\infty}D_\alpha(Q_{x+h}\Vert Q_x)
=
\lim_{x\to\infty}D_\alpha(Q_x\Vert Q_{x+h})
=0.
\tag{7.3}
$$

**证明。** 先在标准化模型中固定 $d\in\mathbb R$，令 $a=c+d$、$c\to+\infty$。对充分大的 $c$，取 $t=(c+d)/c>0$，则 $a-ct=0$。对每个固定 $\alpha$，两个 $\Delta_i$ 都趋于 1，故可积性条件最终成立。式 (7.1) 化为

$$
D_\alpha(P_{c+d}\Vert P_c)
\le
-\frac{\log[1-\alpha(\alpha-1)(t-t^{-1})^2]}{2(\alpha-1)}
+
\frac{\alpha b^2(1-t^{-1})^2}{2[1+\alpha(t^{-2}-1)]}.
\tag{7.4}
$$

对 $d/c$ 作 Taylor 展开，右端等于

$$
\frac{\alpha(4+b^2)d^2}{2c^2}
+O_{\alpha,b,d}(c^{-3}).
\tag{7.5}
$$

它趋于零，而 divergence 非负。逆向令被比较均值为 $a=c$、目标均值为 $c+d$，取 $t=c/(c+d)$，同样使第一均值差为零，并得到趋于零的上界。最后代入 $c=x/\sigma$、$b=1/r$、$d=h/\sigma$，完成证明。$\square$

式 (7.5) 只给出显式上界的首项；本文不声称它是乘积分布 divergence 的精确首项。证明通过有限参数不等式完成，并未把密度逐点收敛当成 Rényi divergence 收敛的充分条件。

**推论 8（大计数与高阶极限不交换）。** 定义

$$
H(x,\alpha)
=\frac1\alpha\max\big\{
D_\alpha(Q_{x+h}\Vert Q_x),
D_\alpha(Q_x\Vert Q_{x+h})
\big\}.
$$

则

$$
\boxed{
\lim_{x\to\infty}\lim_{\alpha\to\infty}H(x,\alpha)
=\frac{h^2}{4\sigma^2},
\qquad
\lim_{\alpha\to\infty}\lim_{x\to\infty}H(x,\alpha)
=0.
}
\tag{7.6}
$$

第一个结论来自式 (6.1)—(6.2)，第二个来自定理 7。因此，任意固定有限阶数集 $\mathcal A\subset(1,\infty)$ 上计算出的最大归一化 divergence 都会趋于零，但全体阶数上的上确界始终至少为 $h^2/(4\sigma^2)$。固定阶数网格不能据此认证趋于零的 zCDP 预算。这是全阶认证的限制，并不否定各个有限阶 RDP 上界本身的有效性。

## 8. 较大均值指向较小均值的全阶极限

定理 1 先固定均值，再令阶数增长。下面的加强结论控制同一方向的全部阶数，并确定其最优全阶系数的大均值极限。

**定理 9（单向一致上界与精确大均值极限）。** 固定 $b\in\mathbb R$、$d>0$、$c>0$。对每个 $0<\kappa<1$，

$$
\sup_{\alpha>1}
\frac{D_\alpha(P_{c+d,b}\Vert P_{c,b})}{\alpha}
\le
\frac{d^2}{2(2-\kappa)}
+
\frac{d^2}{c^2}
\left[
\frac{b^2}{2\kappa}
+
\frac{2}{\kappa(2-\kappa)}
\right].
\tag{8.1}
$$

因此

$$
\boxed{
\lim_{c\to\infty}
\sup_{\alpha>1}
\frac{D_\alpha(P_{c+d,b}\Vert P_{c,b})}{\alpha}
=\frac{d^2}{4}.
}
\tag{8.2}
$$

**证明。** 令 $\lambda=1-\kappa$。对每个 $\alpha>1$，在式 (7.1) 中选择

$$
t=\min\left(1+\frac dc,\sqrt{1+\frac\lambda\alpha}\right).
\tag{8.3}
$$

这里的 $t$ 可以随 $\alpha$ 改变，因为每次都在比较同一对乘积分布。

由 $1\le t\le\sqrt{1+\lambda/\alpha}$，

$$
\Delta_2
\ge\frac{\alpha\kappa+\lambda}{\alpha+\lambda}
\ge\kappa.
$$

式 (7.2) 的右端在 $t\ge1$ 时随 $t$ 增长而下降，因此

$$
\Delta_1\Delta_2
\ge
(1+\lambda)\frac{\alpha\kappa+\lambda}{\alpha+\lambda}
\ge\kappa(2-\kappa).
\tag{8.4}
$$

若式 (8.3) 取第一个值，第一均值差为零；若取第二个值，则 $\Delta_1=2-\kappa$，且 $0\le c+d-ct\le d$。所以式 (7.1) 的第一项总不超过

$$
\frac{d^2}{2(2-\kappa)}.
$$

又因 $0\le1-t^{-1}\le t-1\le d/c$，第二项不超过 $b^2d^2/(2\kappa c^2)$。

最后令

$$
z=\alpha(\alpha-1)(t-t^{-1})^2\in[0,1).
$$

用 $-\log(1-z)\le z/(1-z)$、式 (8.4) 以及

$$
t-t^{-1}\le2(t-1)\le\frac{2d}{c},
$$

得到

$$
-\frac{\log(\Delta_1\Delta_2)}{2\alpha(\alpha-1)}
\le
\frac{2d^2}{\kappa(2-\kappa)c^2}.
$$

三项相加即得对所有 $\alpha$ 同时成立的式 (8.1)。

当 $c>|b|$ 时，定理 1 中两个有向尾部差值都等于 $d$，所以全阶上确界至少为 $d^2/4$。另一方面，固定任意 $\kappa\in(0,1)$，式 (8.1) 给出

$$
\limsup_{c\to\infty}
\sup_{\alpha>1}
\frac{D_\alpha(P_{c+d,b}\Vert P_{c,b})}{\alpha}
\le\frac{d^2}{2(2-\kappa)}.
$$

再令 $\kappa\downarrow0$，就与下界吻合，证明式 (8.2)。此处没有交换上确界与极限。对 $c>1$ 取 $\kappa=1/c$，还可得到显式的 $O_{b,d}(1/c)$ 误差上界；本文不声称这一收敛速率最优。$\square$

回到原机制，定理 9 意味着

$$
\lim_{x\to\infty}
\sup_{\alpha>1}
\frac{D_\alpha(Q_{x+h}\Vert Q_x)}{\alpha}
=\frac{h^2}{4\sigma^2}.
$$

这是从较大计数到较小计数的**单向**结论。反方向的高阶极限为零，不等于反方向的全阶上确界已被确定。本文尚未证明反方向全阶上确界的大计数极限，因此也未确定双向 $v_*(x)$ 的极限。

## 9. 只用有理数运算的有限阶证书

高阶极限已经给出普遍下界。引理 2 的显式常数还允许在指定的有限阶数上给出下界，而无需对极罕见尾部进行浮点积分。

**命题 10（有限阶下界证书）。** 固定 $a,c,b\in\mathbb R$、$\alpha>1$ 和 $s\in\{-1,+1\}$，定义

$$
B=|c+sb|+\alpha\big(|a+sb|-|c+sb|\big).
$$

若 $B\ge2$，则

$$
\frac{D_\alpha(P_{a,b}\Vert P_{c,b})}{\alpha}
\ge
\max\left\{
0,
\frac{B^2/4-1-\alpha A(a,b)}{\alpha(\alpha-1)}
\right\},
\qquad
A(a,b)=\frac{a^2+b^2}{2}+|a|+|b|+3.
\tag{9.1}
$$

**证明。** 在符号为 $s$ 的尾部，把 $f_{a,b}$ 的下界提升到 $\alpha$ 次幂，把 $f_{c,b}$ 的上界提升到负幂 $1-\alpha$。所得乘积至少为

$$
e^{-\alpha A(a,b)}z^{-1/2}e^{-z+B\sqrt z}.
$$

作变换 $u=\sqrt z$，并只保留 $B/2\le u\le B/2+1$ 的积分。由于 $B\ge2$，这一区间位于 $u\ge1$，且

$$
-u^2+Bu
=B^2/4-(u-B/2)^2
\ge B^2/4-1.
$$

因此整个 Rényi 积分至少为

$$
2\exp\big(B^2/4-1-\alpha A(a,b)\big).
$$

取对数，舍去正项 $\log2$，再除以 $\alpha(\alpha-1)$，得到所述下界。Rényi divergence 非负，所以可与零取最大值。$\square$

当 $a,c,b,\alpha$ 都是有理数时，保留的下界也是有理数。检查器因此能完全用整数和有理数运算重算证书。它验证的是已由解析证明建立的下界，不是 Rényi 积分的精确值。常数有意取保守值，以便得到严格而容易复算的有限阶证据。在较大均值指向较小均值的方向，使认证阶数不断增大，就会恢复定理 1 的系数；这一结论不需要浮点积分或图形支持。

## 10. 含义、边界与后续问题

较大计数下，输出的主要概率质量确实可能表现得近似于某个高斯尺度族。但高阶 Rényi divergence 会放大极罕见输出的似然比。标准化正尾部的主要指数为

$$
-u^2+\alpha d\,u,
$$

其最大点约为 $u=\alpha d/2$，对应输出绝对值为 $\alpha^2$ 量级。对每组固定参数，这一尾部保留了正的全阶隐私代价。

对每个固定 $r>0$，式 (6.1) 与 $r$ 的具体值无关；但当 $r=0$ 时，机制退化为第一阶段高斯机制，其归一化 Rényi divergence 为 $h^2/(2\sigma^2)$。所以先取高阶极限再令 $r\downarrow0$，与直接令 $r=0$ 并不相同。这里没有矛盾：尾部界的常数，以及尾部开始控制高阶积分的阶数，都不对 $r\downarrow0$ 一致。

在计数依赖性上，这一原机制无法与那些 zCDP 预算能够趋于零的替代机制竞争。其固定阶行为仍解释了一个容易误判的现象：只考察有限阶数范围的数值研究，可能显示出比全阶隐私允许的程度更强的放大效果。这是该机制特有的数学区别，不影响后处理性质，也不否定文献 [3] 的替代机制结果。

已完成的结果包括：一般乘积模型的精确有向高阶极限、原机制的 $\rho/2$ 双向预算下界、两个方向的固定阶趋零、极限不交换，以及较大均值指向较小均值的单向最优全阶极限。仍待解决的问题包括反方向的全阶大计数极限、两个方向合并后的最优预算，以及完整有限阶隐私曲线。对乘性噪声作修改或截断会改变机制，需要另行证明；本文始终固定原始未截断的高斯机制。

## 11. 参考文献与成果归属

[1] David Pujol and Damien Desfontaines. **Open problem — Better privacy guarantees for larger groups.** DifferentialPrivacy.org，2023 年 6 月 26 日。[作者维护的原始开放问题与 Algorithm 1](https://differentialprivacy.org/open-problem-better-privacy-guarantees-for-larger-groups/)。

[2] Achraf Azize. **Open problem — Better privacy guarantees for larger groups.** 2023 年 7 月。[作者托管的研究稿](https://achraf-azize.github.io/Open_problem_Better_privacy_guarantees_for_larger_groups.pdf)。第 2.2 节 Attempt 1 识别乘积正态分布并写出 Rényi 积分；第 3 节讨论另一种算法。本文明确将乘积表示归属于这一先前分析。

[3] Jack Fitzsimons. **Better Privacy Guarantees for Larger Groups.** arXiv:2607.14406，2026 年 7 月 15 日。[arXiv 记录](https://arxiv.org/abs/2607.14406)；[可访问的完整研究稿](https://www.researchgate.net/publication/410301346_Better_Privacy_Guarantees_for_Larger_Groups)。该稿提出平移对数高斯替代机制，并在允许零计数容差的效用表述下给出匹配的计数阶数下界；其范围说明明确排除对原始随机 Algorithm 1 的分析。

[4] Mark Bun and Thomas Steinke. **Concentrated Differential Privacy: Simplifications, Extensions, and Lower Bounds.** 2016。[原始研究稿](https://privacytools.seas.harvard.edu/sites/g/files/omnuum6656/files/privacytools/files/simp.pdf)。本文使用其中的标准 zCDP 定义、高斯机制标定和后处理性质。

[5] Robert E. Gaunt and Zixin Ye. **Asymptotic approximations for the distribution of the product of correlated normal random variables.** arXiv:2309.07734v2，2024。[指定版本的研究稿](https://arxiv.org/abs/2309.07734v2)。命题 2.1 与定理 2.2 在更一般的乘积正态模型中建立相关零点及尾部渐近展开。本文针对后续隐私问题证明独立因子的初等显式界，不声称乘积正态渐近理论本身的新颖性。

候选贡献是精确的有向 Rényi 极限、它对原始未截断机制的应用、两种阶数极限的差异、单向一致比较，以及有限阶有理数下界证书。查新结论仅限于项目另行记录的检索与全文比较范围。本文不作全球优先权或外部同行评议认证。
