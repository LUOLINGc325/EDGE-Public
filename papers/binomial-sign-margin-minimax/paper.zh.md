# 二项混合中符号泛函的全参数极小极大风险

## 局部逆 Bernstein 系数、整数估计与谱猜想反例

### 摘要

设 \(Q\) 个潜在变量独立同分布于 \([-1,1]\) 上的未知概率测度 \(G\)，每个潜在变量经过 \(n\) 次二项观测，研究由这些计数估计符号不平衡量
\(\theta(G)=\int\operatorname{sgn}(z)\,dG(z)\)
以及判断其符号的困难程度。对任意固定 \(\beta>0\)、有限 \(L\ge1\)，仅假设
\(G([-u,u])\le Lu^\beta\)；测度可以在非零位置有原子，不要求存在密度。本文证明，对所有正整数 \(Q,n\)，绝对估计风险和符号决策遗憾均在只依赖 \(\beta,L\) 的常数因子内等于
\[
F_\beta(Q,n)=
\max\left\{Q^{-1/2},\ n^{-\beta},\
[n\log(e+Q)]^{-\beta/2}\right\}.
\]
上界由明确的多项式逆矩估计量达到，并给出只用整数调参、有理数计算的实现。证明的关键是同时保留逆 Bernstein 系数的指数增长与空间衰减，再对完整 margin 类积分控制方差。下界把已有的带权 \(L^1\) 多项式逼近对偶嵌入保持 margin 常数为一的局部扰动，并显式控制实际二项观测分母。

该结论给出 Zhang–Amini [1, Conjecture 6.4] 的否定答案。对每个固定 \(\beta>0\)，沿
\(Q_n=\lceil n^\beta(\log n)^{2\beta}\rceil\)，真实风险为
\((n\log n)^{-\beta/2}\) 量级，而原谱候选量为
\((n\log\log n)^{-\beta/2}\) 量级。两者之比趋于零。作为有限通道阶数的解析基准，本文还证明识别宽度的奇偶关系，给出 \(n=1,2\) 的精确识别风险。正核逼近、Krawtchouk 恒等式、矩匹配及一般模量方法均按已有文献归属；全文不作优先权认证。

**关键词：** 二项混合；符号泛函；极小极大风险；margin 条件；Bernstein 系数；矩匹配；识别极限。

## 1. 统计实验、损失与量词

### 1.1 观测模型

固定 \(\beta>0\) 和有限 \(L\ge1\)，令
\[
\mathcal G_{\beta,L}
=\left\{G\in\mathcal P([-1,1]):
 G([-u,u])\le Lu^\beta\quad\text{对每个 }0<u\le1\right\}.
\tag{M1}
\]
这里 \(\mathcal P([-1,1])\) 是所有 Borel 概率测度。条件 (M1) 蕴含 \(G(\{0\})=0\)，但允许其他位置的任意原子，也允许零点附近无界的密度。

给定正整数 \(Q,n\)，独立生成
\[
Z_i\sim G,\qquad
S_i\mid Z_i=z\sim\operatorname{Bin}\!\left(n,\frac{1+z}{2}\right),
\quad i=1,\ldots,Q.
\]
研究者只观察计数向量 \(S_1,\ldots,S_Q\)，不观察 \(Z_i\)。单个计数的分布记为
\[
(K_nG)(k)=\binom nk\int_{-1}^1
 \left(\frac{1+z}{2}\right)^k
 \left(\frac{1-z}{2}\right)^{n-k}\,dG(z),
\quad 0\le k\le n.
\tag{M2}
\]
完整观测分布为 \((K_nG)^{\otimes Q}\)。这一标量实验来自 [1] 的两模型反对称子模型；原始嵌入取 \(n=2N\)，而本文直接研究所有正整数 \(n\)。

### 1.2 两种风险

规定 \(\operatorname{sgn}(0)=0\)，目标为
\[
\theta(G)=\int\operatorname{sgn}(z)\,dG(z)\in[-1,1].
\]
估计规则可以使用独立辅助随机性。绝对估计风险和二元决策风险分别定义为
\[
\begin{aligned}
R^{\mathrm{abs}}_{Q,n}(\beta,L)
&=\inf_{\widehat\theta}
  \sup_{G\in\mathcal G_{\beta,L}}
  \mathbb E_{(K_nG)^{\otimes Q}}
  |\widehat\theta-\theta(G)|,\\
R^{\mathrm{dec}}_{Q,n}(\beta,L)
&=\inf_{\widehat\sigma\in\{-1,+1\}}
  \sup_{G\in\mathcal G_{\beta,L}}
  \mathbb E_{(K_nG)^{\otimes Q}}
  \big[|\theta(G)|
       \mathbf1\{\widehat\sigma\theta(G)<0\}\big].
\end{aligned}
\tag{M3}
\]
下确界先对规则取，随后对未知测度取上确界；规则只能依赖观测计数及已知参数。当 \(\theta(G)=0\) 时两种决策的遗憾均为零。

给定任意实值估计量，先截断到 \([-1,1]\)，再在非负值时输出 \(+1\)、负值时输出 \(-1\)。截断不增加绝对误差；若决策符号错误，则逐条样本路径有
\[
|\theta(G)|\le|\widehat\theta-\theta(G)|.
\]
因此始终有 \(R^{\mathrm{dec}}_{Q,n}\le R^{\mathrm{abs}}_{Q,n}\)。估计值为零时的动作明确取 \(+1\)，不会输出不允许的第三种决策。

全文对数均为自然对数。\(\asymp_{\beta,L}\) 表示常数因子比较，常数可以依赖固定的 \(\beta,L\)，不依赖 \(Q,n\)；它不表示比值收敛到一。

## 2. 主定理与完整风险图景

**定理 1（全参数风险）。** 对每个固定 \(\beta>0\)，存在 \(c_\beta>0\)；对每个有限 \(L\ge1\)，存在 \(C_{\beta,L}<\infty\)，使所有整数 \(Q,n\ge1\) 同时满足
\[
c_\beta F_\beta(Q,n)
\le R^{\mathrm{dec}}_{Q,n}(\beta,L)
\le R^{\mathrm{abs}}_{Q,n}(\beta,L)
\le C_{\beta,L}F_\beta(Q,n),
\tag{M4}
\]
其中
\[
F_\beta(Q,n)
=\max\left\{
Q^{-1/2},\ n^{-\beta},\
[n\log(e+Q)]^{-\beta/2}
\right\}.
\tag{M5}
\]
下界常数可以对全部 \(L\ge1\) 一致，因为构造的困难测度属于 \(\mathcal G_{\beta,1}\)。上界包含 \(Q=1\)、\(n=1\)、小样本分支和次数饱和情形。第 8 节给出达到该阶的完全整数调参估计量。

分析中也使用
\[
\Phi_\beta(Q,n)=
\max\left\{
Q^{-1/2},\ n^{-\beta},\
[n\log(e+Qn^{-\beta/2})]^{-\beta/2}
\right\}.
\tag{M6}
\]

**引理 2（两个写法的一致性）。** 对所有 \(\beta>0\) 和 \(Q,n\ge1\)，
\[
F_\beta(Q,n)\le\Phi_\beta(Q,n)
\le2^{\beta/2}F_\beta(Q,n).
\tag{M7}
\]

**证明。** 因为 \(n^{-\beta/2}\le1\)，第一个不等式成立。若 \(Q\le n^\beta\)，则
\(Q^{-1/2}\ge n^{-\beta/2}\)，而两个式子的第三项均不超过 \(n^{-\beta/2}\)，第二项也不超过它。因此两个最大值均等于 \(Q^{-1/2}\)。若 \(Q>n^\beta\)，则 \(Qn^{-\beta/2}>\sqrt Q\)，并且
\[
\log(e+Qn^{-\beta/2})
\ge\log(e+\sqrt Q)\ge\tfrac12\log(e+Q);
\]
最后一步来自 \((e+\sqrt Q)^2\ge e+Q\)。比较第三项并取最大值即得结论。 \(\square\)

三个项分别描述个体数有限所产生的参数型困难、有限通道阶数的识别极限，以及二者之间的逆问题困难。对大 \(n\)，参数项与中间项的交接尺度为
\(Q\asymp_\beta(n\log n)^\beta\)，中间项与识别项的交接满足
\(\log(e+Q)\asymp n\)。这些是常数因子意义的尺度；定理 (M4) 本身覆盖任意接近交接处的参数序列，不需要预先把序列放在某个内部区域。

证明分为两部分。第 3–8 节构造上界，第 9 节给出匹配下界；第 10 节利用该完整定理分析原谱猜想。第 11 节的精确识别结果是补充基准，不代替联合 \(Q,n\) 的证明。

## 3. 复解析系数工具

本节给出后续局部估计所需的完整解析计算。Cauchy 系数公式、复多项式增长和 Stirling 界均是经典工具；Lorentz/Bernstein 系数的相关先例见 [5]，二项混合中的应用见 [6,7]。

**引理 3（无维数前因子的辅助系数界）。** 设 \(N\ge1\)，整数 \(0\le d\le N/2\)，实多项式 \(P\) 满足
\(\deg P\le d\)、\(\|P\|_{[-1,1]}\le1\)。其 degree-\(N\) Bernstein 表示
\[
P(2p-1)=\sum_{k=0}^N a_k\binom Nk p^k(1-p)^{N-k}
\tag{A1}
\]
满足
\[
|a_k|\le3\exp(2d^2/N),\qquad0\le k\le N.
\tag{A2}
\]

**证明。** 常数多项式及端点 \(a_0=P(-1)\)、\(a_N=P(1)\) 直接满足结论。对 \(1\le k\le N-1\)，令
\[
p=k/N,\quad q=1-p,\quad \rho=p/q,\quad
\mathcal F(z)=(1+z)^N P\!\left(\frac{z-1}{z+1}\right).
\]
因为 \(d\le N\)，\(\mathcal F\) 是多项式，且
\([z^k]\mathcal F(z)=\binom Nk a_k\)。

先证明复增长界。若 \(x=(w+w^{-1})/2\)、\(|w|\ge1\)，则
\[
|P(x)|\le|w|^d.
\tag{A3}
\]
事实上，\(H(w)=w^dP((w+w^{-1})/2)\) 是次数至多 \(2d\) 的多项式，在单位圆上模不超过一。多项式
\(u^{2d}H(1/u)\) 在单位圆上的模也不超过一。最大模原理给出
\(|H(w)|\le|w|^{2d}\)，从而得到 (A3)。

在圆 \(z=\rho e^{it}\)、\(-\pi\le t\le\pi\) 上取
\(\sqrt z=\sqrt\rho e^{it/2}\)。对于 \(x=(z-1)/(z+1)\)，两个 Joukowski 根是
\[
w=\frac{\sqrt z+i}{\sqrt z-i},\qquad w^{-1}.
\]
令
\[
v=2\sqrt{pq}\,|\sin(t/2)|\in[0,1].
\]
直接计算得到
\[
\max\{|w|,|w|^{-1}\}
=\sqrt{\frac{1+v}{1-v}}
=e^{\operatorname{arctanh}v},
\qquad
\frac{|1+z|}{1+\rho}=\sqrt{1-v^2}.
\]
故在 \(v<1\) 时
\[
\frac{|\mathcal F(\rho e^{it})|}{(1+\rho)^N}
\le(1-v^2)^{N/2}e^{d\operatorname{arctanh}v}.
\tag{A4}
\]
唯一可能出现 \(v=1\) 的情形是 \(p=1/2,t=\pm\pi,z=-1\)。这是圆积分的零测点；\(\mathcal F\) 本身是连续多项式，以下使用其余点及极限，不把该点解释为未定义的 \(0\cdot\infty\)。

将 (A4) 右边的幂分成两半。置 \(x=2d/N\le1\)，求导或直接代入极值点可得
\[
\begin{aligned}
\sup_{0\le v<1}
 \left\{\frac N4\log(1-v^2)+d\operatorname{arctanh}v\right\}
&=\frac N4\big[(1+x)\log(1+x)+(1-x)\log(1-x)\big]\\
&\le \frac N2x^2=\frac{2d^2}{N}.
\end{aligned}
\tag{A5}
\]
当 \(x<1\) 时极值点为 \(v=x\)；当 \(x=1\) 时按极限解释，规定 \(0\log0=0\)。最后一步由
\(\log(1+x)\le x\)、\(\log(1-x)\le-x\)，分别乘以非负因子 \(1+x,1-x\) 后相加得到。

剩余圆积分用 \(\log(1-v^2)\le-v^2\) 以及
\(\sin(|t|/2)\ge|t|/\pi\) 控制：
\[
\begin{aligned}
\frac1{2\pi}\int_{-\pi}^{\pi}(1-v^2)^{N/4}\,dt
&\le\frac1{2\pi}\int_{-\pi}^{\pi}
 e^{-Npq\sin^2(t/2)}\,dt\\
&\le\frac1{2\pi}\int_{\mathbb R}e^{-Npq t^2/\pi^2}\,dt
=\frac{\sqrt\pi}{2\sqrt{Npq}}.
\end{aligned}
\tag{A6}
\]
Cauchy 公式遂给出
\[
|a_k|\le e^{2d^2/N}
 \frac{\sqrt\pi/(2\sqrt{Npq})}
 {\binom Nk p^kq^{N-k}}.
\tag{A7}
\]
采用 Robbins 的显式 Stirling 余项 [8]，
\[
\binom Nk p^kq^{N-k}
\ge\frac{e^{-1/(12k)-1/(12(N-k))}}{\sqrt{2\pi Npq}}
\ge\frac{e^{-1/6}}{\sqrt{2\pi Npq}}.
\]
因此 (A7) 的常数至多
\(e^{1/6}\pi/\sqrt2<3\)。 \(\square\)

后文还使用同一计算的直接推论：若在上述第 \(k\) 个 Cauchy 圆上，某个多项式 \(R\) 满足
\[
\left|R\!\left(\frac{z-1}{z+1}\right)\right|
\le A_k e^{J\operatorname{arctanh}v},
\qquad 0\le J\le N/2,
\tag{A8}
\]
且 \(A_k\) 不依赖角度 \(t\)，那么其第 \(k\) 个 degree-\(N\) Bernstein 系数的模至多
\(3A_k e^{2J^2/N}\)。这由 (A4)–(A7) 原样计算得到；\(J\) 可以是实际次数的一个上界。

## 4. 正导数核与 margin 偏差

选择正整数 \(r\) 满足
\[
s=2r-1>\beta.
\tag{K1}
\]
为了让所有常数只依赖 \(\beta,L\)，可以固定
\(r=\lfloor\beta/2\rfloor+2\)。以下先对任意符合 (K1) 的固定整数 \(r\) 证明。令 \(m\) 为正奇数，定义
\[
S_m(x)=\sin(m\arcsin x)=(-1)^{(m-1)/2}T_m(x),
\quad
K_{m,r}(x)=\left(\frac{S_m(x)}{mx}\right)^{2r},
\tag{K2}
\]
零点处取连续值。因为 \(S_m\) 是奇多项式，\(K_{m,r}\) 是有理系数的偶多项式，次数为 \(2r(m-1)\)。

整数倍角不等式
\(|\sin(m\vartheta)|\le m|\sin\vartheta|\)
可由 \(\sin(m\vartheta)/\sin\vartheta\) 的 \(m\) 项复指数和得到。结合 \(|S_m(x)|\le1\)，有
\[
0\le K_{m,r}(x)\le\min\{1,(m|x|)^{-2r}\},
\qquad K_{m,r}(0)=1.
\tag{K3}
\]
定义归一化积分
\[
I_{m,r}=\int_0^1K_{m,r}(x)\,dx,\qquad
P_{m,r}(x)=I_{m,r}^{-1}\int_0^xK_{m,r}(t)\,dt.
\tag{K4}
\]
于是 \(P_{m,r}\) 是奇的单调多项式，
\[
\deg P_{m,r}=2r(m-1)+1,\quad
P_{m,r}(\pm1)=\pm1,\quad
\|P_{m,r}\|_{[-1,1]}\le1.
\]
所有系数均为有理数。积分正局部多项式核来构造单调阶跃逼近是已有方法；相关构造及局部导数估计见 [4, §4]。本文随后需要的是其逆二项系数的空间控制。

当 \(0\le x\le1/(2m)\) 时，
\(\arcsin x\le2x\)、\(\arcsin x\ge x\)，且
\(m\arcsin x\le1<\pi/2\)。利用 \(\sin y\ge2y/\pi\)，得到
\[
I_{m,r}\ge\frac1{2m}\left(\frac2\pi\right)^{2r},
\qquad
I_{m,r}^{-1}\le c_rm,\quad
c_r=2(\pi/2)^{2r}.
\tag{K5}
\]
对 \(m|x|\ge1\) 积分 (K3) 的尾部，对 \(m|x|<1\) 利用单调性，得到
\[
|P_{m,r}(x)-\operatorname{sgn}x|
\le b_r\min\{1,(m|x|)^{-s}\},
\qquad b_r=\max\{1,c_r/s\}.
\tag{K6}
\]
在零点，两者均为零。

令 \(R=|Z|\)，其分布函数 \(F_R(t)\) 满足
\(F_R(t)\le Lt^\beta\)；把这个上界延伸到 \(t\ge1\) 仍成立，因为 \(L\ge1\)。对 \(a>0,v>\beta\)，非负函数的 Fubini 公式给出
\[
\begin{aligned}
\mathbb E\min\{1,(aR)^{-v}\}
&=v a^{-v}\int_{1/a}^{\infty}F_R(t)t^{-v-1}\,dt\\
&\le\frac{Lv}{v-\beta}a^{-\beta}.
\end{aligned}
\tag{K7}
\]
该恒等式直接把每个固定 \(R\) 的函数值写为从 \(\max\{R,1/a\}\) 到无穷的积分，再交换非负积分，因而允许 \(R\) 的分布有原子。

结合 (K6)–(K7)，得到
\[
\sup_{G\in\mathcal G_{\beta,L}}
\left|\int P_{m,r}\,dG-\theta(G)\right|
\le B_{\beta,L,r}m^{-\beta},
\qquad
B_{\beta,L,r}=\frac{Lb_rs}{s-\beta}.
\tag{K8}
\]

## 5. 局部逆系数与差分尾和

本节设 \(m\) 为正奇数，且
\[
4rm\le n-1,\qquad N=n-1,\qquad J=2rm\le N/2.
\tag{V1}
\]
令 \(b_0,\ldots,b_N\) 为核 \(K_{m,r}\) 的 degree-\(N\) Bernstein 系数。

**引理 4（逆导数系数的局部界）。** 对 \(0\le k\le N\)，
\[
|b_k|\le3e^{2J^2/N}
\min\{1,(m|2k/N-1|)^{-2r}\},
\tag{V2}
\]
中心处将最小值解释为一。

**证明。** 端点为 \(b_0=b_N=m^{-2r}\)。对内部 \(k\)，采用第 3 节的
\(p=k/N,q=1-p,\rho=p/q,z=\rho e^{it}\)，并置
\[
X=\frac{z-1}{z+1},\qquad x_k=2p-1.
\]
除去前述零测点，
\[
|X|^2
=\frac{\rho^2-2\rho\cos t+1}
       {\rho^2+2\rho\cos t+1}
\ge\frac{(\rho-1)^2}{(\rho+1)^2}
=|x_k|^2.
\tag{V3}
\]
该分式关于 \(\cos t\) 非增，故最小值在 \(\cos t=1\)。

对在实区间上模不超过一的多项式 \(K_{m,r}\) 使用 (A3)，并将其实际次数 \(J-2r\) 上界为 \(J\)，得
\[
|K_{m,r}(X)|\le e^{J\operatorname{arctanh}v}.
\]
另一方面，对 \(S_m\) 使用 (A3)，结合 (V3)，在 \(x_k\ne0\) 时有
\[
|K_{m,r}(X)|
=\frac{|S_m(X)|^{2r}}{m^{2r}|X|^{2r}}
\le(m|x_k|)^{-2r}e^{J\operatorname{arctanh}v}.
\tag{V4}
\]
取两条有效复界的较小值，然后在 (A8) 中取
\(A_k=\min\{1,(m|x_k|)^{-2r}\}\)，即得 (V2)。中心使用第一条界。这里的空间因子来自独立的复几何不等式 (V3)，没有把实轴衰减式直接延拓到复平面。 \(\square\)

令 \(a_0,\ldots,a_n\) 为 \(P_{m,r}\) 的 degree-\(n\) Bernstein 系数。由 Bernstein 基的导数公式及 \(P'_{m,r}=K_{m,r}/I_{m,r}\)，
\[
n(a_{k+1}-a_k)=\frac{2b_k}{I_{m,r}},
\quad0\le k<n,\qquad
a_n=1,\quad a_{n-k}=-a_k.
\tag{V5}
\]
最后的反对称性来自 \(P_{m,r}\) 的奇性及基表示的唯一性。若 \(n\) 为偶数，则 \(a_{n/2}=0\)。

记
\[
E=\frac{8r^2m^2}{N}=\frac{2J^2}{N},\qquad
c'_r=6c_r2^{2r}\left(1+\frac1{2s}\right)
=12\pi^{2r}\left(1+\frac1{2s}\right).
\tag{V6}
\]

**引理 5（符号估计系数的局部界）。** 对全部 \(0\le k\le n\)，
\[
|a_k-\operatorname{sgn}(2k/n-1)|
\le c'_r e^E(1+m|2k/n-1|)^{-s}.
\tag{V7}
\]

**证明。** 考虑 \(z_k=2k/n-1>0\) 且 \(k<n\)；中心和端点随后单独处理。对 \(k\le l\le N\)，
\[
2l/N-1\ge z_k+2(l-k)/N.
\]
对非增函数 \(f(y)=\min\{1,y^{-2r}\}\)，
\(f(y)\le2^{2r}(1+y)^{-2r}\)。网格尾和至多首项加积分，因此
\[
\begin{aligned}
\sum_{l=k}^N f(m(2l/N-1))
&\le2^{2r}\sum_{h=0}^{\infty}
 (1+mz_k+2mh/N)^{-2r}\\
&\le2^{2r}\left[
 (1+mz_k)^{-2r}
 +\frac{N}{2ms}(1+mz_k)^{-s}\right].
\end{aligned}
\tag{V8}
\]
从 \(a_n=1\) 对 (V5) 作尾和，再用 (K5)、(V2)，得到
\[
\begin{aligned}
|1-a_k|
&\le\frac{6e^E}{nI_{m,r}}
 \sum_{l=k}^N f(m(2l/N-1))\\
&\le6c_r2^{2r}
 \left(\frac mn+\frac{N}{2ns}\right)
 e^E(1+mz_k)^{-s}\\
&\le c'_r e^E(1+mz_k)^{-s}.
\end{aligned}
\]
最后一步用 \(m/n\le1,N/n\le1\)。左半区由反对称性得到。端点偏差为零；偶数 \(n\) 的中心系数与 \(\operatorname{sgn}(0)\) 均为零。 \(\square\)

## 6. 对完整 margin 类的方差控制

令 \(\widehat Z=2S/n-1\)，并取 \(v=2s>\beta\)。条件于 \(Z=z\)，在事件
\(|\widehat Z-z|\le|z|/2\) 上，
\(|\widehat Z|\ge|z|/2\)。Hoeffding 不等式 [9] 给出补集概率至多 \(2e^{-nz^2/8}\)。由于被积函数不超过一，
\[
\mathbb E[(1+m|\widehat Z|)^{-v}\mid Z=z]
\le(1+m|z|/2)^{-v}+2e^{-nz^2/8}.
\tag{V9}
\]
\(z=0\) 时该不等式也成立。

以下两个积分公式均直接来自非负函数的 Fubini 定理。对 \(a>0,v>\beta\)，
\[
\begin{aligned}
\mathbb E(1+aR)^{-v}
&=\int_0^\infty av(1+at)^{-v-1}F_R(t)\,dt\\
&\le La^{-\beta}M_{\beta,v},\qquad
M_{\beta,v}
=\frac{\Gamma(\beta+1)\Gamma(v-\beta)}{\Gamma(v)}.
\end{aligned}
\tag{V10}
\]
具体地，把 \(F_R(t)\) 上界为 \(Lt^\beta\)，代换 \(y=at\)，再用 Beta 积分恒等式即可。类似地，
\[
\begin{aligned}
\mathbb Ee^{-aR^2}
&=\int_0^\infty2at e^{-at^2}F_R(t)\,dt\\
&\le L\Gamma(1+\beta/2)a^{-\beta/2}.
\end{aligned}
\tag{V11}
\]
这两式不需要分部积分的密度形式，因此不遗漏原子质量或边界项。

对 (V9) 积分，得到
\[
\sup_{G\in\mathcal G_{\beta,L}}
\mathbb E_G(1+m|\widehat Z|)^{-2s}
\le L\left[
 2^\beta M_{\beta,2s}m^{-\beta}
 +2\cdot8^{\beta/2}\Gamma(1+\beta/2)n^{-\beta/2}
\right].
\tag{V12}
\]
由 (V7) 和 \((x+y)^2\le2x^2+2y^2\)，
\[
a_S^2\le2+2(c'_r)^2e^{2E}(1+m|\widehat Z|)^{-2s}.
\]
定义有限常数
\[
C_V=2(c'_r)^2L
\max\left\{
2^\beta M_{\beta,2s},
2\cdot8^{\beta/2}\Gamma(1+\beta/2)
\right\}.
\tag{V13}
\]
因为 \(N=n-1\ge n/2\)，得到本文上界的关键估计：
\[
\boxed{
\sup_{G\in\mathcal G_{\beta,L}}
\operatorname{Var}_{K_nG}(a_S)
\le2+C_V(m^{-\beta}+n^{-\beta/2})
       \exp(32r^2m^2/n).
}
\tag{V14}
\]
该上确界遍历全部可行测度，并未限制为某一参考密度、对称分布或有限网格。

定义原始逆矩估计
\[
\overline\theta=Q^{-1}\sum_{i=1}^Q a_{S_i},
\qquad
\widehat\theta=\max\{-1,\min\{1,\overline\theta\}\}.
\]
Bernstein 表示给出
\(\mathbb E_G a_S=\int P_{m,r}\,dG\)。结合偏差 (K8)、独立性、Cauchy–Schwarz 不等式及 (V14)，有
\[
\sup_G\mathbb E_G|\widehat\theta-\theta(G)|
\le B_{\beta,L,r}m^{-\beta}+\sqrt2Q^{-1/2}
+\frac{\sqrt{C_V}}{\sqrt Q}
 (m^{-\beta}+n^{-\beta/2})^{1/2}
 e^{16r^2m^2/n}.
\tag{V15}
\]
这是对所有符合 (V1) 的 \(m,n\) 都成立的有限样本不等式。

## 7. 全参数解析调优

本节先达到 \(\Phi_\beta\) 的上界；下一节将给出不计算实数对数、实数幂或实数平方根的同阶实现。

固定
\[
r=\lfloor\beta/2\rfloor+2,\quad
s=2r-1>\beta,\quad
\gamma=\frac1{16r},\quad n_0=256r^2.
\]
当 \(n<n_0\) 时使用恒零估计。否则令
\[
A_*=Qn^{-\beta/2},\quad
\ell=\log(e+A_*),\quad
H=\min\{n,\ell\},\quad
u=\gamma\sqrt{nH},
\tag{U1}
\]
取不超过 \(u\) 的最大正奇数 \(m\)。

此时 \(H\ge1\)、\(u\ge1\)，且
\[
u/3\le m\le u,\qquad
4rm\le n-1,\qquad m\ge(\gamma/3)\sqrt n.
\tag{U2}
\]
第一条在 \(1\le u<3\) 时由 \(m=1\) 得到，在 \(u\ge3\) 时由
\(m>u-2\ge u/3\) 得到。第二条来自 \(m\le\gamma n\)、
\(4r\gamma=1/4\) 和 \(n\ge n_0\ge2\)。因此第 4–6 节的全部条件均成立。

设
\[
C_m=(3/\gamma)^\beta=(48r)^\beta,\qquad
C_*=\sqrt{C_V(C_m+1)}.
\]
有
\[
m^{-\beta}\le C_m(nH)^{-\beta/2},\quad
m^{-\beta}+n^{-\beta/2}\le(C_m+1)n^{-\beta/2},\quad
16r^2m^2/n\le H/16.
\]
故 (V15) 不超过
\[
B_{\beta,L,r}C_m(nH)^{-\beta/2}
+\sqrt2Q^{-1/2}
+C_*n^{-\beta/4}Q^{-1/2}e^{H/16}.
\tag{U3}
\]
其中
\[
(nH)^{-\beta/2}
=\max\{n^{-\beta},(n\ell)^{-\beta/2}\}.
\]

若 \(A_*<1\)，则
\(e^{H/16}\le(e+1)^{1/16}\)、\(n^{-\beta/4}\le1\)，所以 (U3) 最后一项由常数倍 \(Q^{-1/2}\) 控制。

若 \(A_*\ge1\)，则
\[
n^{-\beta/4}Q^{-1/2}e^{H/16}
\le n^{-\beta/2}A_*^{-1/2}(e+A_*)^{1/16}
\le C^\dagger_\beta(n\ell)^{-\beta/2},
\tag{U4}
\]
其中可取
\[
C^\dagger_\beta
=(e+1)^{1/16}e^{7/8}
 \left(\frac{8\beta}{7e}\right)^{\beta/2}.
\]
验证最后一步：令 \(t=\log A_*\ge0\)，则
\(\ell\le2+t\)，并且
\[
A_*^{-1/2}(e+A_*)^{1/16}
\le(e+1)^{1/16}e^{-7t/16}.
\]
再最大化
\(y^{\beta/2}e^{-7y/16}\)，其在 \(y\ge0\) 上的最大值为
\((8\beta/(7e))^{\beta/2}\)，即可控制
\((2+t)^{\beta/2}e^{-7t/16}\)。

当 \(n<n_0\) 时，恒零估计的风险至多一，而
\[
1\le n_0^\beta n^{-\beta}\le n_0^\beta\Phi_\beta(Q,n).
\]
于是可取
\[
C_{\beta,L}^{(\Phi)}
=\max\left\{
n_0^\beta,\
B_{\beta,L,r}C_m+\sqrt2+
C_*\max\{(e+1)^{1/16},C^\dagger_\beta\}
\right\},
\tag{U5}
\]
得到对全部 \(Q,n\ge1\) 的
\[
R^{\mathrm{dec}}_{Q,n}
\le R^{\mathrm{abs}}_{Q,n}
\le C_{\beta,L}^{(\Phi)}\Phi_\beta(Q,n).
\tag{U6}
\]
结合引理 2，定理 1 的上界成立。下述整数实现提供另一条直接达到 \(F_\beta\) 的调参规则。

## 8. 只用整数调参的精确估计量

### 8.1 次数选择

给实现一个固定正整数 \(r\)，满足 \(2r-1>\beta\)。选择这个整数后，算法不再对 \(\beta\) 作实数计算；固定每个 \(\beta\) 对应的 \(r=\lfloor\beta/2\rfloor+2\) 即回到只依赖 \(\beta,L\) 的常数。这里不声称对未知 \(\beta\) 的自适应最优性。

令
\[
n_0=256r^2,\quad
k=\operatorname{bitlength}(Q),\quad
h=\min\{n,k\}.
\]
若 \(n<n_0\)，输出估计值零和决策 \(+1\)。否则计算
\[
a_{\mathrm{int}}
=\operatorname{isqrt}\!\left(
 \left\lfloor\frac{nh}{256r^2}\right\rfloor\right),\qquad
m=
\begin{cases}
a_{\mathrm{int}},&a_{\mathrm{int}}\text{ 为奇数},\\
a_{\mathrm{int}}-1,&a_{\mathrm{int}}\text{ 为偶数}.
\end{cases}
\tag{I1}
\]
其中 bitlength 和 isqrt 分别是正整数的二进制位数、整数平方根下取整。恒等式
\(\lfloor\sqrt{\lfloor x\rfloor}\rfloor=\lfloor\sqrt x\rfloor\)
表明，\(m\) 正是不超过
\(u=\sqrt{nh}/(16r)\) 的最大正奇数。阈值保证 \(u\ge1\)，故 \(m\ge1\)，且
\[
\frac{\sqrt{nh}}{48r}\le m\le\frac{\sqrt{nh}}{16r},
\qquad4rm\le n-1.
\tag{I2}
\]

### 8.2 整数替换的风险证明

设 \(H_0=\min\{n,\log(e+Q)\}\)。对于整数 \(Q\ge1\)，
\[
1\le k\le1+2\log Q,\qquad
\log(e+Q)\le2k.
\tag{I3}
\]
第一条由 \(\log2\ge1/2\) 得到；第二条利用
\(Q+1\le2^k\)、\(e+Q\le e(1+Q)\)，故
\(\log(e+Q)\le1+k\log2\le2k\)。从而
\[
h\ge H_0/2,\qquad
e^{h/16}\le e^{1/16}Q^{1/8}.
\tag{I4}
\]

(V15) 与 (U3) 的推导只用次数范围及 \(h\ge1\)，所以把 \(H\) 换为这里的 \(h\) 后仍成立。偏差至多
\[
2^{\beta/2}B_{\beta,L,r}(48r)^\beta
\max\{n^{-\beta},[n\log(e+Q)]^{-\beta/2}\}.
\]
除 \(\sqrt2Q^{-1/2}\) 外的随机项至多
\[
C_*e^{1/16}n^{-\beta/4}Q^{-3/8}.
\tag{I5}
\]
若 \(Q\le n^\beta\)，它与 \(Q^{-1/2}\) 的比值至多
\(C_*e^{1/16}n^{-\beta/4}Q^{1/8}
\le C_*e^{1/16}\)。
若 \(Q>n^\beta\)，它与
\([n\log(e+Q)]^{-\beta/2}\) 的比值至多
\[
C_*e^{1/16}Q^{-1/8}\log(e+Q)^{\beta/2}
\le C_*e^{1/16}D_\beta,
\quad
D_\beta=e^{1/4}(4\beta/e)^{\beta/2}.
\tag{I6}
\]
为验证最后一步，令 \(t=\log Q\ge0\)，使用
\(\log(e+Q)\le2+t\)，并最大化
\(y^{\beta/2}e^{-y/8}\)。

小 \(n\) 分支仍由 \(n_0^\beta n^{-\beta}\) 覆盖。因此整数调参估计量达到
\[
\sup_G\mathbb E_G|\widehat\theta-\theta(G)|
\le \widetilde C_{\beta,L,r}F_\beta(Q,n),
\tag{I7}
\]
例如可以取
\[
\widetilde C_{\beta,L,r}
=\max\left\{
n_0^\beta,\
2^{\beta/2}B_{\beta,L,r}(48r)^\beta+\sqrt2+
C_*e^{1/16}\max\{1,D_\beta\}
\right\}.
\]
所有常数均有限，不依赖 \(Q,n\)。

### 8.3 有理数系数与观测统计量

Chebyshev 递推
\(T_0=1,T_1=x,T_{j+1}=2xT_j-T_{j-1}\)
产生整数系数 \(S_m\)；其被 \(x\) 整除。因此 (K2)–(K4) 的核、积分和归一化多项式均可以有限次有理运算得到。\(I_{m,r}>0\) 由 (K5) 保证。

更明确地，若
\[
P_{m,r}(2p-1)=\sum_{j=0}^{D}c_jp^j,\qquad D\le n,
\]
则逆系数为
\[
a_k=\sum_{j=0}^{\min\{k,D\}}
 c_j\frac{\binom kj}{\binom nj},
\quad0\le k\le n.
\tag{I8}
\]
这是因为
\[
p^j=\sum_{k=j}^n
 \frac{\binom kj}{\binom nj}\binom nk p^k(1-p)^{n-k};
\]
约去组合数后，右边是
\(p^j\sum_{l=0}^{n-j}\binom{n-j}{l}p^l(1-p)^{n-j-l}=p^j\)。

最后计算 \(Q^{-1}\sum_i a_{S_i}\)、截断到 \([-1,1]\)，并按第 1 节的平局规则作决策。整个过程只访问输入计数；整数次数选择和后续有理数运算均是有限、精确的。本文证明可实现性，不声称时间或位复杂度最优。

## 9. 匹配下界：保持 margin 的局部矩消去

本节所有困难测度均属于 \(\mathcal G_{\beta,1}\)，所以同时适用于任意 \(L\ge1\)。下界适用于所有允许的随机化决策。

### 9.1 已有的带权 \(L^1\) 逼近定理

令
\[
d\mu_\beta(x)=\frac\beta2|x|^{\beta-1}\,dx,
\quad -1\le x\le1,\qquad
E_d(\beta)=\inf_{P\in\Pi_d}
 \int|\operatorname{sgn}(x)-P(x)|\,d\mu_\beta(x),
\]
其中 \(\Pi_d\) 表示次数至多 \(d\) 的实多项式空间。

本文使用下列**外部已知逼近结论**：
\[
E_d(\beta)\ge a_\beta d^{-\beta}
\quad\text{对所有整数 }d\ge1,
\qquad a_\beta>0.
\tag{D1}
\]
该结论及其对全部 \(\beta>0\) 的详细特化见 [1, Appendix E, Lemma E.3]，其证明使用 [2] 的带权逆逼近定理及局部 Jackson 上界。权函数指数为 \(\beta-1>-1\)。本文不重新证明这个外部逼近定理，也不把它作为新的下界工具。

为完整说明从 (D1) 到概率构造的步骤，考虑 \(L^1(\mu_\beta)\) 中符号函数到有限维闭子空间 \(\Pi_d\) 的距离。Hahn–Banach 定理给出范数为一的对偶泛函，表示为某个 \(g\in L^\infty(\mu_\beta)\)，满足 \(|g|\le1\)、对 \(\Pi_d\) 积分为零，且目标积分等于 \(E_d(\beta)\)。将 \(g\) 替换为
\((g(x)-g(-x))/2\)，对称性保持约束与目标，得到奇函数 \(g_d\)，满足
\[
\begin{gathered}
|g_d|\le1\quad\mu_\beta\text{-几乎处处},\\
\int x^j g_d(x)\,d\mu_\beta(x)=0\quad(0\le j\le d),\\
\int\operatorname{sgn}(x)g_d(x)\,d\mu_\beta(x)=E_d(\beta).
\end{gathered}
\tag{D2}
\]
这一对偶见证也见 [1, Lemma E.4]。

定义
\[
d\mu_{d,\pm}(x)=(1\pm g_d(x))d\mu_\beta(x).
\]
它们非负，总质量为一。奇性给出精确中央质量
\[
\mu_{d,+}([-t,t])=\mu_{d,-}([-t,t])=t^\beta,
\quad0\le t\le1,
\tag{D3}
\]
且
\(\theta(\mu_{d,\pm})=\pm E_d(\beta)\)。

### 9.2 局部缩放与可行性

任取整数 \(1\le d\le n\)，设
\[
h=\sqrt{\frac d{64n}},\qquad
\lambda=h^\beta,\qquad
H_{\mathrm{end}}=\tfrac12(\delta_{-1}+\delta_1).
\]
令 \(D_h\mu\) 为缩放 \(x\mapsto hx\) 的推前测度，构造
\[
F_{d,\pm}
=(1-\lambda)H_{\mathrm{end}}+\lambda D_h\mu_{d,\pm}.
\tag{D4}
\]
由于 \(h\le1/8\)，混合权重合法。

当 \(0<t\le h\) 时，由 (D3)，
\(F_{d,\pm}([-t,t])=\lambda(t/h)^\beta=t^\beta\)。
当 \(h<t<1\) 时，该质量为 \(h^\beta\le t^\beta\)；当 \(t=1\) 时为一。因此
\[
F_{d,\pm}\in\mathcal G_{\beta,1}
\subseteq\mathcal G_{\beta,L}.
\tag{D5}
\]
缩放没有改变 margin 指数或常数。两测度互为反射，前 \(d\) 次矩相同，目标为
\[
\theta(F_{d,\pm})=\pm b_d,\qquad
b_d=h^\beta E_d(\beta)
\ge a_\beta8^{-\beta}(nd)^{-\beta/2}.
\tag{D6}
\]

### 9.3 二项通道的精确二次恒等式

记 \(B_n(k)=2^{-n}\binom nk>0\)。对任意有限实符号测度 \(\nu\)，
\[
\sum_{k=0}^n\frac{(K_n\nu)(k)^2}{B_n(k)}
=\sum_{j=0}^n\binom nj
 \left(\int z^j\,d\nu(z)\right)^2.
\tag{D7}
\]
这是经典二项/Krawtchouk 正交恒等式；二项混合统计中的直接先例见 [3, Appendix A.1]。

**证明。** 在独立公平符号 \(X_1,\ldots,X_n\in\{-1,+1\}\) 下，优势为 \(z\) 的 Bernoulli 实验相对于公平实验的似然比为
\[
L_z(X)=\prod_{i=1}^n(1+zX_i)
=\sum_{A\subseteq[n]}z^{|A|}\prod_{i\in A}X_i.
\]
不同子集对应的乘积构成正交归一族。对 \(\nu\) 积分、平方并取公平实验期望，得到 (D7) 右边。该积分后的似然比只依赖正符号个数，所以同一个期望正是左边。所有展开与积分交换都是有限和。 \(\square\)

令 \(P_\pm=K_nF_{d,\pm}\)，
\(\Delta_j=\int z^j\,d(F_{d,+}-F_{d,-})(z)\)。
有
\[
\Delta_j=0\quad(j\le d),\qquad
|\Delta_j|\le2\lambda h^j\quad(j>d).
\]
故
\[
\sum_{k=0}^n\frac{(P_+(k)-P_-(k))^2}{B_n(k)}
\le4\lambda^2\sum_{j=d+1}^n\binom nj h^{2j}.
\tag{D8}
\]
若 \(d=n\)，右边为零，因而 \(P_+=P_-\)。

### 9.4 实际观测分母与 Hellinger 距离

采用约定
\[
H^2(P,Q)=\sum_k(\sqrt{P(k)}-\sqrt{Q(k)})^2,
\qquad
\operatorname{TV}(P,Q)=\tfrac12\sum_k|P(k)-Q(k)|.
\]
相对于 \(B_n\) 的二次型本身还不足以控制 \(H^2(P_+,P_-)\)；需要比较实际分母。一般的基准分母比较也是已有方法，见 [3, Appendix A.2, Lemma 10]。这里给出满足原 margin 条件的具体比较。

对 \(0\le z<1\)，正、负优势的平均似然比满足
\[
\begin{aligned}
&\frac{(1+z)^k(1-z)^{n-k}
 +(1-z)^k(1+z)^{n-k}}2\\
&\quad=(1-z^2)^{n/2}
 \cosh\!\left((k-n/2)\log\frac{1+z}{1-z}\right)
\ge(1-z^2)^{n/2}.
\end{aligned}
\tag{D9}
\]
令 \(\rho_0=\min\{h,(2n)^{-1/2}\}\)。在 \(0\le z\le\rho_0\) 上，
\((1-z^2)^n\ge1-nz^2\ge1/2\)，故 (D9) 至少为 \(1/\sqrt2\)。利用 \(D_h\mu_\beta\) 的对称性，
\[
\lambda(K_nD_h\mu_\beta)(k)
\ge\frac{\lambda}{\sqrt2}(\rho_0/h)^\beta B_n(k)
=\frac{\rho_0^\beta}{\sqrt2}B_n(k).
\]
又因 \(d\ge1\)，
\(\rho_0\ge(8\sqrt n)^{-1}\)。由
\(\mu_{d,+}+\mu_{d,-}=2\mu_\beta\)，可得
\[
P_+(k)+P_-(k)
\ge\sqrt2\,8^{-\beta}n^{-\beta/2}B_n(k)
\quad(0\le k\le n).
\tag{D10}
\]
这里的 \(n^{-\beta/2}\) 因子由可行局部质量提供，没有人为加入零点原子或统一密度下界。

利用
\((\sqrt a+\sqrt b)^2\ge a+b\)，结合 (D8)、(D10) 及
\(\lambda^2=(d/(64n))^\beta\)，得到
\[
H^2(P_+,P_-)
\le2\sqrt2\,8^{-\beta}n^{-\beta/2}d^\beta
\sum_{j=d+1}^n
 \binom nj\left(\frac d{64n}\right)^j.
\tag{D11}
\]
对于 \(d<n\)，尾和可按下式控制：
\[
\begin{aligned}
\sum_{j=d+1}^n\binom nj\left(\frac d{64n}\right)^j
&\le\sum_{j=d+1}^{\infty}\frac{(d/64)^j}{j!}\\
&\le\frac{64}{63}\left(\frac e{64}\right)^{d+1}
\le2e^{-3d}.
\end{aligned}
\tag{D12}
\]
第一步用 \(\binom nj\le n^j/j!\)；后续项与前一项之比小于 \(1/64\)，首项用
\(j!\ge(j/e)^j\) 控制。最后一步利用 \(e^4<64\)。

**命题 6（有限次数困难对）。** 对每个 \(\beta>0\) 和 \(1\le d\le n\)，(D4) 的测度满足 (D5)、(D6)，并且
\[
H^2(P_+,P_-)\le8n^{-\beta/2}d^\beta e^{-3d}
\quad(d<n),\qquad
P_+=P_-\quad(d=n).
\tag{D13}
\]
(D11) 给出的有限尾和界更精细；(D13) 使用一个便于调优的宽松常数。

### 9.5 选择次数并证明全参数下界

令
\[
A_\beta=\max\{1,(\beta/e)^\beta\},\quad
u=Qn^{-\beta/2},\quad
D=\max\left\{1,
 \left\lceil\tfrac12\log(32A_\beta u)\right\rceil
 \right\},\quad
d=\min\{n,D\}.
\tag{D14}
\]
若 \(d<n\)，则 \(d=D\)。由
\(\sup_{x>0}x^\beta e^{-x}=(\beta/e)^\beta\) 和 (D13)，
\[
QH^2(P_+,P_-)
\le8uA_\beta e^{-2d}\le\tfrac14.
\tag{D15}
\]
即使对数为负，\(D\ge1\) 仍保持该不等式；因为始终有
\(D\ge\tfrac12\log(32A_\beta u)\)。若 \(d=n\)，两个观测分布相同。

Hellinger 亲和度在独立乘积下相乘，因而
\[
H^2(P_+^{\otimes Q},P_-^{\otimes Q})
=2\left[1-\left(1-\tfrac12H^2(P_+,P_-)\right)^Q\right]
\le QH^2(P_+,P_-).
\]
此外 \(\operatorname{TV}\le H\)，可由
\(|P-Q|=|\sqrt P-\sqrt Q|(\sqrt P+\sqrt Q)\)
和 Cauchy–Schwarz 不等式直接得到。因此两种情形均有
\[
\operatorname{TV}(P_+^{\otimes Q},P_-^{\otimes Q})\le\tfrac12.
\]

任何随机化二元规则的两个错误概率之和至少为
\(1-\operatorname{TV}(P_+^{\otimes Q},P_-^{\otimes Q})\)。
因为两目标为 \(\pm b_d\)，该规则在这两点上的最大风险至少为
\[
\frac{b_d}{2}
 \left(1-\operatorname{TV}(P_+^{\otimes Q},P_-^{\otimes Q})\right)
\ge\frac{b_d}{4}.
\tag{D16}
\]
这一步没有限制下确界中的随机化规则。

取
\(C_D=2+\tfrac12\log(32A_\beta)\)，则 \(C_D\ge1\)，由取整界和
\(\log(e+u)\ge1\) 得到
\[
D\le C_D\log(e+u).
\]
结合 \(d=\min\{n,D\}\) 与 (D6)、(D16)，有
\[
R^{\mathrm{dec}}_{Q,n}(\beta,L)
\ge \frac{a_\beta8^{-\beta}}{4C_D^{\beta/2}}
\max\left\{n^{-\beta},
 [n\log(e+Qn^{-\beta/2})]^{-\beta/2}\right\}.
\tag{D17}
\]

还需参数型项。令 \(\eta=(4\sqrt Q)^{-1}\)，考虑仅在 \(\{-1,+1\}\) 上取值、正端点质量分别为 \((1+\eta)/2\) 和 \((1-\eta)/2\) 的两测度。它们属于所有 \(\mathcal G_{\beta,L}\)，目标为 \(\pm\eta\)，单个计数只取 \(0,n\)。其 Hellinger 距离平方为
\[
2-2\sqrt{1-\eta^2}\le2\eta^2,
\]
故乘积分布的总变差小于 \(1/2\)。同一两点检验给出
\[
R^{\mathrm{dec}}_{Q,n}(\beta,L)\ge\eta/4
=\frac1{16\sqrt Q}.
\tag{D18}
\]
这也是 [1, Proposition 4.3] 中已有的端点下界机制。

合并 (D17)、(D18)，得到常数倍 \(\Phi_\beta(Q,n)\) 的下界，进而得到 (M4) 的下界。第 7 节或第 8 节给出匹配上界，定理 1 证明完毕。 \(\square\)

### 9.6 为什么分母验证不可省略

简单的稀有原子对
\[
G_\pm=(1-\rho)H_{\mathrm{end}}+\rho\delta_{\pm h},
\qquad \rho=h^\beta,\quad0<h\le1/2,
\]
也满足 \(\mathcal G_{\beta,1}\)。但当 \(n=3\) 时，计数一和二没有来自端点背景的质量，它们对 Hellinger 距离平方的合计贡献恰为
\[
\frac{3\rho}{2}(1-h^2)
 \big(1-\sqrt{1-h^2}\big)\ge\frac9{16}\rho h^2.
\]
另一方面，Hellinger 平方的联合凸性和二项亲和度给出
\[
H^2(K_3G_+,K_3G_-)
\le2\rho[1-(1-h^2)^{3/2}]
\le3\rho h^2.
\]
因此该距离的阶是 \(h^{\beta+2}\)，不是 \(h^{2\beta+2}\)。局部质量对 Hellinger 的贡献不能一般地直接平方。本文 (D10) 的共同局部分母明确处理了这一问题。这个例子用于解释证明步骤；谱猜想的否定依赖下一节对完整极小极大风险的比较。

## 10. 原谱猜想的严格反例

[1, Conjecture 6.4, 式 (83)] 提出的候选量为
\[
\Psi_\beta(Q,n)
=\min_{\substack{1\le d\le n\\d\in\mathbb N}}
 \left\{d^{-\beta}+\frac{\kappa_{d,n}}{\sqrt Q}\right\},
\qquad
\kappa_{d,n}^2
=\frac{(n-d)!(n+d+1)!}{n!(n+1)!}
=\prod_{j=0}^{d-1}\frac{n+j+2}{n-j}.
\tag{S1}
\]
谱及其阶数增长属于来源已有结构。以下用该精确式和定理 1 检验所猜测的均匀等价。

首先，对所有 \(1\le d\le n\)，由
\(\log(1+x)\ge x/(1+x)\)，
\[
\begin{aligned}
\log\kappa_{d,n}
&=\frac12\sum_{j=0}^{d-1}
 \log\left(1+\frac{2j+2}{n-j}\right)\\
&\ge\sum_{j=0}^{d-1}\frac{j+1}{n+j+2}
\ge\frac{d(d+1)}{2(n+d+1)}
\ge\frac{d^2}{8n}.
\end{aligned}
\tag{S2}
\]
当 \(1\le d\le n/2\) 时，由 \(\log(1+x)\le x\)，另有
\[
\log\kappa_{d,n}
\le\sum_{j=0}^{d-1}\frac{j+1}{n-j}
\le\frac{d(d+1)}{2(n-d+1)}
\le\frac{2d^2}{n}.
\tag{S3}
\]

**定理 7（对每个固定 margin 指数的分离）。** 固定任意
\(\beta>0\)、有限 \(L\ge1\)，令 \(n\to\infty\)，并取
\[
Q_n=\left\lceil n^\beta(\log n)^{2\beta}\right\rceil.
\tag{S4}
\]
则
\[
R^{\mathrm{dec}}_{Q_n,n}(\beta,L)
\asymp_{\beta,L}
n^{-\beta/2}(\log n)^{-\beta/2},
\tag{S5}
\]
而
\[
\Psi_\beta(Q_n,n)
\asymp_\beta
n^{-\beta/2}(\log\log n)^{-\beta/2}.
\tag{S6}
\]
因此
\[
\frac{R^{\mathrm{dec}}_{Q_n,n}(\beta,L)}
     {\Psi_\beta(Q_n,n)}
\asymp_{\beta,L}
\left(\frac{\log\log n}{\log n}\right)^{\beta/2}
\longrightarrow0.
\tag{S7}
\]

**证明。** 对充分大的 \(n\)，
\[
n^\beta(\log n)^{2\beta}\le Q_n
\le2n^\beta(\log n)^{2\beta}.
\tag{S8}
\]
所以
\[
Q_n^{-1/2}\asymp_\beta
n^{-\beta/2}(\log n)^{-\beta},
\qquad
\log(e+Q_n)\sim\beta\log n.
\]
\(F_\beta\) 的第三项为 (S5) 的阶，另外两项与它的比值分别趋于零。因此定理 1 给出 (S5)。

为证明 (S6) 的下界，限制到 \(\log\log n\ge1\)，并置
\(D_n=\sqrt{8\beta n\log\log n}\)。对每个允许的整数 \(d\)，若 \(d\le D_n\)，则
\[
d^{-\beta}\ge(8\beta)^{-\beta/2}
n^{-\beta/2}(\log\log n)^{-\beta/2}.
\]
若 \(d>D_n\)，则由 (S2)、(S8)，
\[
\frac{\kappa_{d,n}}{\sqrt{Q_n}}
\ge
\frac{e^{d^2/(8n)}}
 {\sqrt2\,n^{\beta/2}(\log n)^\beta}
\ge\frac1{\sqrt2}n^{-\beta/2}
\ge\frac1{\sqrt2}
n^{-\beta/2}(\log\log n)^{-\beta/2}.
\]
此分支划分不要求 \(D_n\) 为整数；若 \(D_n>n\)，所有允许的次数都落在第一支。因而对全部整数次数取最小值后，仍得到所需下界。

上界取
\[
d_n=\left\lfloor
 \sqrt{\frac{\beta}{8}\,n\log\log n}
 \right\rfloor.
\]
对充分大的 \(n\)，有 \(1\le d_n\le n/2\)，且 \(d_n\) 不小于下取整前实数的一半。因此
\[
d_n^{-\beta}
\le2^\beta(\beta/8)^{-\beta/2}
n^{-\beta/2}(\log\log n)^{-\beta/2}.
\]
由 (S3)、(S8)，
\[
\frac{\kappa_{d_n,n}}{\sqrt{Q_n}}
\le
\frac{\exp(2d_n^2/n)}
 {n^{\beta/2}(\log n)^\beta}
\le n^{-\beta/2}(\log n)^{-3\beta/4}
=o\!\left(n^{-\beta/2}(\log\log n)^{-\beta/2}\right).
\]
在 (S1) 中代入这个合法整数次数即得 (S6) 上界。结合 (S5) 得到 (S7)。 \(\square\)

对每个固定参数对 \((\beta,L)\)，(S7) 排除了
\(R^{\mathrm{dec}}_{Q,n}\ge c_{\beta,L}\Psi_\beta(Q,n)\)
在全部 \(Q,n\) 上成立的可能，因此否定该均匀谱等价猜想。结论包括 \(L=1\)，也可以把 \(n\) 限制在偶数子序列，故适用于原文 \(n=2N\) 的嵌入。本结论不对随 \(n\) 变化的 \(\beta_n,L_n\) 声称统一常数。

这是一条完整极小极大风险的反例序列。它使用已经构造的统一上界；仅给出某一对分布的较弱下界，不能推出 (S7)。

## 11. 识别极限的精确基准

本节补充固定通道阶数的解析性质。它们使用已有的反射、矩表示和模量思想 [1]，不作为一般方法的原创性主张。

### 11.1 识别宽度只涉及奇矩

定义
\[
W_n=\sup\left\{
|\theta(G)-\theta(H)|:
G,H\in\mathcal G_{\beta,L},\ K_nG=K_nH
\right\}.
\tag{B1}
\]
令 \(\mathcal RG\) 为 \(Z\mapsto-Z\) 的反射。类
\(\mathcal G_{\beta,L}\) 对反射及凸组合封闭，且
\(\theta(\mathcal RG)=-\theta(G)\)。

Bernstein 基构成次数至多 \(n\) 的多项式空间的一组基，故
\(K_nG=K_nH\) 当且仅当零至 \(n\) 次矩相同。也可由 (I8) 之前的单项式恒等式直接验证这两个方向。

**命题 8（奇矩表达）。**
\[
W_n
=2\sup\left\{\theta(F):
F\in\mathcal G_{\beta,L},\
\mathbb E_FZ^j=0
\text{ 对每个不超过 }n\text{ 的奇数 }j
\right\}.
\tag{B2}
\]
因此 \(W_{2k}=W_{2k-1}\) 对全部整数 \(k\ge1\) 成立。

**证明。** 对同通道输出的 \(G,H\)，必要时交换顺序使
\(\theta(G)\ge\theta(H)\)，并令
\(F=(G+\mathcal RH)/2\)。
其每个指定奇矩为
\((m_j(G)-m_j(H))/2=0\)，而
\(\theta(F)=(\theta(G)-\theta(H))/2\)。
反过来，若 \(F\) 满足这些奇矩约束，则 \(F,\mathcal RF\) 的偶矩自动相同，指定奇矩也相同；它们通道输出一致、目标间隔为 \(2|\theta(F)|\)。反射使可行目标关于零对称，取上确界即得 (B2)。阶数 \(2k\) 和 \(2k-1\) 的奇矩约束相同，遂得奇偶关系。 \(\square\)

### 11.2 \(n=1,2\) 的闭式刻画

置
\[
A=\frac{\beta}{\beta+1}L^{-1/\beta},\qquad
q=1+\frac1\beta,
\]
令 \(p_*\in(1/2,1)\) 是方程
\[
p_*+Ap_*^q=1
\tag{B3}
\]
的唯一根。左边严格递增，在 \(1/2\) 处小于一、在一处大于一，故根存在且唯一。

**命题 9（零均值约束下的最大符号偏差）。**
\[
\sup\left\{\theta(F):
F\in\mathcal G_{\beta,L},\ \mathbb E_FZ=0
\right\}=2p_*-1.
\tag{B4}
\]

**证明。** 因为零点无原子，若 \(p=F((0,1])\)，则
\(\theta(F)=2p-1\)。margin 约束及层析积分给出
\[
\mathbb EZ_+
=\int_0^1\Pr(Z>t)\,dt
\ge\int_0^{(p/L)^{1/\beta}}(p-Lt^\beta)\,dt
=Ap^q.
\]
同时 \(\mathbb EZ_-\le1-p\)。零均值要求
\(Ap^q\le1-p\)，所以 \(p\le p_*\)。

令 \(h_*=(p_*/L)^{1/\beta}<1\)。在 \((0,h_*)\) 上放置密度
\(L\beta z^{\beta-1}\)，在 \(-1\) 放置原子质量 \(1-p_*\)，得到 \(F_+\)。
其正半轴质量为 \(p_*\)；对 \(t<1\)，中央质量为
\(\min\{Lt^\beta,p_*\}\le Lt^\beta\)，在 \(t=1\) 时为
\(1\le L\)。正半轴一阶矩为
\(Ap_*^q=1-p_*\)，所以均值为零。该构造属于原始类，包括 \(L=1\)；对所有 \(\beta>0\) 都可积。它达到目标 \(2p_*-1\)。 \(\square\)

由命题 8、9，
\[
W_1=W_2=2(2p_*-1).
\tag{B5}
\]
\(F_+\) 和 \(\mathcal RF_+\) 在 \(n=1,2\) 时观测分布完全相同，故每个 \(Q\) 都有
\[
R^{\mathrm{dec}}_{Q,n}(\beta,L)
\ge(2p_*-1)/2,\qquad n\in\{1,2\}.
\tag{B6}
\]

### 11.3 固定 \(n\) 的精确极限

**命题 10。** 对每个固定 \(n\ge1\)，
\[
\lim_{Q\to\infty}R^{\mathrm{dec}}_{Q,n}(\beta,L)
=\frac{W_n}{4}.
\tag{B7}
\]

**证明。** 先说明紧性。若 \(G_l\) 弱收敛于 \(G\)，对
\(0<t<s<1\)，Portmanteau 不等式给出
\[
G([-t,t])
\le G((-s,s))
\le\liminf_lG_l((-s,s))
\le Ls^\beta.
\]
令 \(s\downarrow t\)，得到 margin 约束；\(t=1\) 的约束自动成立。因此
\(\mathcal G_{\beta,L}\) 是紧空间 \(\mathcal P([-1,1])\) 的闭子集。
以在 \([-\varepsilon,\varepsilon]\) 内线性过渡的连续函数逼近符号函数，积分误差对整个类至多
\(2L\varepsilon^\beta\)，故 \(\theta\) 在这个类上连续。
\(K_n\) 的每个坐标也连续，因而
\(\{(K_nG,\theta(G)):G\in\mathcal G_{\beta,L}\}\) 紧。

对于接近宽度 \(W_n\) 的同输出分布对，命题 8 的反射构造给出目标为相反的半间隔、观测分布相同的两测度。两点决策下界遂给出
\(R^{\mathrm{dec}}_{Q,n}\ge W_n/4\)，对每个 \(Q\) 均成立。

为证明上界，定义
\[
W_n^{(1)}(\varepsilon)
=\sup\left\{
|\theta(G)-\theta(H)|:
G,H\in\mathcal G_{\beta,L},\
\|K_nG-K_nH\|_1\le\varepsilon
\right\}.
\]
紧性与连续性蕴含
\(W_n^{(1)}(\varepsilon)\downarrow W_n\)
当 \(\varepsilon\downarrow0\)：对任意趋于零的半径序列取达到上确界的分布对，沿紧子序列收敛，极限对具有相同通道输出。

令 \(\widehat p\) 为 \(Q\) 个计数的经验频率，考虑
\[
\mathcal C(\widehat p,\varepsilon)
=\{G\in\mathcal G_{\beta,L}:
 \|K_nG-\widehat p\|_1\le\varepsilon\}.
\]
若集合为空，任意输出；否则由紧性可定义
\[
a=\max\{0,\max_{G\in\mathcal C}\theta(G)\},\qquad
b=\max\{0,\max_{G\in\mathcal C}(-\theta(G))\}.
\]
当 \(a+b>0\) 时，以 \(a/(a+b)\) 的概率输出 \(+1\)；
\(a=b=0\) 时任意输出。对每个固定 \(Q,n\)，经验频率只取有限个值，这一规则可测。

在真实 \(G\in\mathcal C\) 的事件上，如果 \(a,b>0\)，条件最坏遗憾为
\[
\frac{ab}{a+b}\le\frac{a+b}{4}
\le\frac{W_n^{(1)}(2\varepsilon)}4.
\]
最后一步因为达到两个端点的分布都距 \(\widehat p\) 至多 \(\varepsilon\)。
若 \(a,b\) 之一为零，遗憾为零。失败事件上的遗憾至多一。
写 \(p=K_nG\)，Cauchy–Schwarz 及多项分布方差给出
\[
\mathbb E\|\widehat p-p\|_1^2
\le(n+1)\sum_{k=0}^n\operatorname{Var}(\widehat p_k)
\le\frac{n+1}{Q}.
\]
故规则的最大风险不超过
\[
\frac{W_n^{(1)}(2\varepsilon)}4+
\frac{n+1}{Q\varepsilon^2}.
\]
取 \(\varepsilon=Q^{-1/4}\)，对固定 \(n\) 令 \(Q\to\infty\)，即得上极限不超过 \(W_n/4\)。 \(\square\)

特别地，\(n=1,2\) 的极限风险均为 \(p_*-1/2\)。
若 \(\beta=L=1\)，则 \(p_*=\sqrt3-1\)，精确极限为
\(\sqrt3-3/2>0\)。本节的紧集优化仅用于证明固定 \(n\) 的识别极限；达到全参数阶的明确算法仍是第 8 节的有理数估计量。

## 12. 相关工作与贡献归属

### 12.1 原问题与相邻统计模型

Zhang–Amini [1] 建立了本文使用的标量决策实验、Hellinger 模量刻画、精确谱、参数型端点界和识别尺度，并在 Conjecture 6.4 中提出全参数谱公式。本文在这个已经定义好的实验内给出统一显式风险及估计量，并通过定理 7 否定该公式。本文的标量上界没有自动推广到任意多模型、非反对称或多答案的总体集成问题。

Lee–Kennedy [10] 研究同一二项逆通道下光滑混合密度的点值估计。其方差分析使用有界混合密度导出的计数质量上界
\(p_{\mathrm{count}}(k)\le p_{\max}/(n+1)\)。
本文允许原子，不能使用该界；目标也变为不连续的符号泛函。

Vinayak 等 [6] 与 Musco 等 [7] 研究无约束混合分布的 Wasserstein-1 恢复，已经使用多项式逼近、Chebyshev 矩和逆 Bernstein 系数。[7] 的较新作者版本在相关系数界中仍保留维数前因子，并保留精确常数一的 Chebyshev 系数猜想。本文引理 3 的
\(3e^{2d^2/N}\)、\(d\le N/2\) 估计不等于解决那个全次数精确猜想；本研究的风险增益还依赖空间局部化和 margin 方差积分。

Ye [11] 研究固定基准成功概率向量的经验混合律及同时置信区域。其 Theorem 6.1 为局部模量宽度上界，Theorem 6.3 的匹配结论针对固定通道阶数、连续目标的识别宽度；S7 增加超总体覆盖的浓缩层。该文对估计项的 minimax 最优性保留明确问题。这些结论没有直接给出本文 iid、原子 margin 类、全部 \(Q,n\) 的符号决策风险。

Basu–Brill–Yekutieli [12] 通过单调检验反演建立混合 CDF 和分位数的精确置信区间。其作者预印本中固定最大试验次数的极限结论描述所构造区间的行为，并非本文的全参数 expected-regret 极小极大定理。相关范围比较依据该预印本的具体理论陈述；本文不把未核对的出版版本差异作为不存在近邻结果的证据。

### 12.2 已有工具与本文的具体推导

下界中的带权逼近定理和奇对偶见证来自 [1,2]。
Krawtchouk 二次恒等式与一般基准分母比较在 [3, Appendix A] 中有直接先例。正多项式核的积分阶跃逼近见 [4]；复系数分析的经典背景见 [5]。一般模量和两点检验对偶框架见 [1,13]。这些工具不是本文所声称的新发明。

本文的具体证明集中在两处。上界保留 Cauchy 圆上的实网格距离，通过两条复增长界的最小值得到 (V2)，再沿 Bernstein 差分尾和传递到 (V7)，对真实 margin 类积分得到 (V14)。下界利用 (D3) 的精确中央质量进行局部缩放，并在合法共同局部分布上验证 (D10)，得到对全部 \(\beta,Q,n\) 可调优的 Hellinger 界。两部分相接才产生定理 1 的完整风险和定理 7 的猜想反例。

对数写法的等价、谱优化中的整数取整和反例序列的代数比较，是完整风险定理的推论。本文不把这些推论逐项计为独立重大理论成果，也不以有界文献检索替代优先权认证。

## 13. 验证材料与形式化范围

本文的全参数声明由上述解析证明及明确引用的带权逼近定理支持。随附代码提供下列可复查材料：

| 材料 | 核验对象 | 证明范围 |
|---|---|---|
| code/lower_initial.py | 有限支持困难对的非负性、归一化、margin 约束、矩消去、精确二次恒等式及有理 Hellinger 上界 | 使用任意精度有理数；这些有限见证不代替 (D1) 的外部逼近定理 |
| code/localized_upper.py | 正核的有理系数、Bernstein 换基、导数关系、反对称性和端点值 | 精确代数恒等式与有限实例；附带浮点方差诊断不构成连续参数证明 |
| code/integer_tuning.py | bitlength/isqrt 调参、次数约束、精确估计和平局动作 | 整数和有理数实现与第 8 节一致；不证明算法复杂度最优 |
| code/exact_identification_baseline.py | 有理参数实例中的质量、一阶矩和低阶通道恒等式 | 通过代数数商环及根的有理包围核验有限基准；一般实参数结论由第 11 节证明 |

有限计算不用于推断整个分布类的方差上确界，也不把普通浮点输出称为严格证书。均匀风险所需的原子处理已经在 (K7)、(V10)–(V12) 和 (D5) 中解析给出。

已经独立审计的 Lean 范围是两组实际多项式代数：Bernstein 系列导数、实系数表示唯一性、导数系数桥及有限尾和；以及显式有限系数原函数、非零归一化因子下的端点与导数、仿射换元。有限二次型、具体正核的定量性质和原函数与解析区间积分的连接仍属于待完成义务。书面证明与有限证书见本稿和随附代码；全文 Lean 义务另行交付，精确范围以随附 formalization 审计记录和 FULL_PLAN.json 为准。本文不声称概率模型、复解析积分、带权逼近定理、均匀调优及整个极小极大主定理已经全部获得证明助手验证。形式化状态与解析证明的数学声明分别报告。

## 14. 结论范围

本文在规定的 iid 二项计数实验内，对每个固定 \(\beta>0\)、有限 \(L\ge1\)，给出了覆盖所有正整数样本量的风险、可执行估计量、匹配下界及谱猜想反例。风险常数允许依赖这些固定类参数；没有计算精确极小极大常数，也没有证明未知 margin 指数下的自适应最优性。

将局部逆系数方法推广到更一般的阈值泛函、异质试验次数或非标量集成实验，需要重新核验对应的观测几何和方差结构。本文不把这些可能的推广纳入已经证明的范围。

## 参考文献

[1] Zhi Zhang and Arash A. Amini. *Two Sample Sizes in Test-Time LLM Ensembling: Buffered ERM and Minimax Theory*. arXiv:2610.21363v1, 2026. 特别参见 Sections 3–6、Appendix E、Conjecture 6.4。  
[原始全文](https://arxiv.org/pdf/2610.21363v1)。

[2] K. A. Kopotun. *Polynomial approximation with doubling weights having finitely many zeros and singularities*. Journal of Approximation Theory **198** (2015), 24–62. DOI: 10.1016/j.jat.2015.05.003.  
[作者全文](https://home.cc.umanitoba.ca/~kopotunk/Publications/k-singular.pdf)；[出版来源](https://doi.org/10.1016/j.jat.2015.05.003)。

[3] Lucas Kania, Larry Wasserman, and Sivaraman Balakrishnan. *Testing Random Effects for Binomial Data*. arXiv:2504.13977v3, 2025. 特别参见 Section 3.3、Appendix A.1–A.2。  
[原始全文](https://arxiv.org/pdf/2504.13977v3)。

[4] K. A. Kopotun, D. Leviatan, and I. A. Shevchuk. *Interpolatory pointwise estimates for monotone polynomial approximation*. Journal of Mathematical Analysis and Applications **459** (2018), 1260–1295. DOI: 10.1016/j.jmaa.2017.11.038. 特别参见 Section 4、Lemma 4.1。  
[作者预印本](https://arxiv.org/pdf/1711.07083)；[出版来源](https://doi.org/10.1016/j.jmaa.2017.11.038)。

[5] D. S. Lubinsky and Z. Ziegler. *Coefficient Bounds in the Lorentz Representation of a Polynomial*. Canadian Mathematical Bulletin **33**(2) (1990), 197–206. DOI: 10.4153/CMB-1990-033-1.  
[出版来源](https://doi.org/10.4153/CMB-1990-033-1)。

[6] Ramya Korlakai Vinayak, Weihao Kong, Gregory Valiant, and Sham Kakade. *Maximum Likelihood Estimation for Learning Populations of Parameters*. Proceedings of ICML 2019, PMLR **97**, 6448–6457.  
[会议正文](https://proceedings.mlr.press/v97/vinayak19a.html)；[补充证明](https://proceedings.mlr.press/v97/vinayak19a/vinayak19a-supp.pdf)。

[7] Cameron Musco, Christopher Musco, Lucas Rosenblatt, and Apoorv Vikram Singh. *Sharper Bounds for Chebyshev Moment Matching, with Applications*. Proceedings of COLT 2025, PMLR **291**, 4309–4358；另参见 arXiv:2408.12385v3 的 Section 6.1–6.2。  
[会议版本](https://proceedings.mlr.press/v291/musco25a.html)；[较新作者版本](https://arxiv.org/html/2408.12385v3)。

[8] Herbert Robbins. *A Remark on Stirling's Formula*. American Mathematical Monthly **62**(1) (1955), 26–29. DOI: 10.2307/2308012.  
[出版来源](https://doi.org/10.2307/2308012)。

[9] Wassily Hoeffding. *Probability Inequalities for Sums of Bounded Random Variables*. Journal of the American Statistical Association **58**(301) (1963), 13–30. DOI: 10.1080/01621459.1963.10500830.  
[出版来源](https://doi.org/10.1080/01621459.1963.10500830)。

[10] JungHo Lee and Edward H. Kennedy. *Minimax Rates for Learning Smooth Populations of Parameters*. arXiv:2610.04135v2, 2026.  
[原始全文](https://arxiv.org/pdf/2610.04135v2)。

[11] Kuancheng Ye. *Variance-adaptive confidence regions for fixed-benchmark binomial mixtures, with application to LLM evaluation*. arXiv:2611.21266v2, 2026. 特别参见 Theorems 6.1、6.3，Corollary 6.6，Open Problem 6.7 及 Supplements S6–S7。  
[原始全文](https://arxiv.org/html/2611.21266v2)。

[12] Pallavi Basu, Barak Brill, and Daniel Yekutieli. *Exact Confidence Intervals for the Mixing Distribution from Binomial Mixture Distribution Samples*. Journal of Computational and Graphical Statistics, 2025. DOI: 10.1080/10618600.2025.2573147；本文所述具体理论范围按 arXiv:2311.14424v1 的 Sections 3–4 核对。  
[作者预印本](https://arxiv.org/html/2311.14424v1)；[出版来源](https://doi.org/10.1080/10618600.2025.2573147)。

[13] Yury Polyanskiy and Yihong Wu. *Dualizing Le Cam's method for functional estimation I: General theory*. Annals of Statistics. DOI: 10.1214/25-AOS2498.  
[出版来源](https://doi.org/10.1214/25-AOS2498)。




