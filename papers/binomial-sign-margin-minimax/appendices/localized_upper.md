# 局部逆 Bernstein 系数上界：一个全参数风险上界

**范围。** 本文属于已准入问题的第一轮研究延续，给出需要单独独立审查的上界证明。它不自动承接 upper_initial.md 的审稿结论，也不单独声称完整 minimax 定理。与另一份下界是否匹配，必须分别核实两侧量词和全部证明。初始稿中既有 Jackson 方法、无权 U1 及有限数值诊断保留其历史范围。

## 1. 模型与声明

固定 \(\beta>0\)、有限 \(L\ge1\)，考虑
\[
\mathcal G_{\beta,L}=\{G:G([-u,u])\le Lu^\beta,\ 0<u\le1\},
\quad Z_i\sim G,\quad S_i\mid Z_i\sim\operatorname{Bin}(n,(1+Z_i)/2).
\]
观测 \(Q\) 个独立计数，\(Z_i\) 不可见。目标为 \(\theta(G)=\mathbb E_G\operatorname{sgn}Z\)，损失为绝对估计误差或对应 sign 决策 regret。所有非零位置的原子均允许；没有密度或额外光滑性假设。

定义
\[
\Phi_\beta(Q,n)=
\max\left\{Q^{-1/2},\ n^{-\beta},\
[\,n\log(e+Qn^{-\beta/2})\,]^{-\beta/2}\right\}.
\tag{L1}
\]

**定理 L1（本稿的上界）。** 对每个固定 \(\beta>0,L\ge1\)，存在仅依赖 \(\beta,L\) 的有限常数 \(C_{\beta,L}\)，使所有整数 \(Q,n\ge1\) 满足
\[
R^{\rm dec}_{Q,n}\le R^{\rm abs}_{Q,n}
\le C_{\beta,L}\Phi_\beta(Q,n).
\tag{L2}
\]
估计量是明确的有理数系数多项式逆矩估计量。该声明不含下界断言。

选择
\[
r=\lfloor\beta/2\rfloor+2,\quad s=2r-1>\beta,\quad
\gamma=\frac1{16r},\quad n_0=256r^2.
\tag{L3}
\]
当 \(n<n_0\) 时用恒零估计；否则令
\[
A_*=Qn^{-\beta/2},\quad
\ell=\log(e+A_*),\quad H=\min\{n,\ell\},\quad
u=\gamma\sqrt{nH},
\tag{L4}
\]
并取不超过 \(u\) 的最大正奇整数 \(m\)。此时 \(u\ge1\)，并且
\[
u/3\le m\le u,\qquad 4rm\le n-1,\qquad
m\ge(\gamma/3)\sqrt n.
\tag{L5}
\]
第二式来自 \(m\le\gamma n\)、\(4r\gamma=1/4\)、\(n\ge n_0\ge2\)。第一式在 \(1\le u<3\) 时由 \(m=1\) 得到，在 \(u\ge3\) 时由 \(m>u-2\ge u/3\) 得到。

以下先对任意正奇数 \(m\) 和满足 \(4rm\le n-1\) 的 \(n\) 证明风险估计，再作统一优化。

## 2. 正导数核及 margin 偏差

令
\[
S_m(x)=\sin(m\arcsin x)=(-1)^{(m-1)/2}T_m(x),\qquad
K_{m,r}(x)=\left(\frac{S_m(x)}{mx}\right)^{2r},
\tag{L6}
\]
在零点取连续值。因为 \(m\) 为奇数，\(S_m\) 是奇多项式，故 \(K_{m,r}\) 是有理系数的偶多项式，次数 \(2r(m-1)\)。整数倍角不等式
\(|\sin(m\vartheta)|\le m|\sin\vartheta|\) 给出
\[
0\le K_{m,r}(x)\le\min\{1,(m|x|)^{-2r}\},\qquad K_{m,r}(0)=1.
\tag{L7}
\]
倍角不等式可由 \(\sin(m\vartheta)/\sin\vartheta\) 的 \(m\) 项复指数和直接得到。

定义
\[
I_{m,r}=\int_0^1K_{m,r}(x)\,dx,\qquad
P_{m,r}(x)=I_{m,r}^{-1}\int_0^xK_{m,r}(t)\,dt.
\tag{L8}
\]
则 \(P_{m,r}\) 是奇的单调多项式，次数 \(2r(m-1)+1\)，满足 \(P_{m,r}(\pm1)=\pm1\) 和 \(\|P_{m,r}\|_{[-1,1]}\le1\)。积分和归一化保持有理系数。

在 \(0\le x\le1/(2m)\) 上，\(\arcsin x\le2x\)，所以 \(m\arcsin x\le1<\pi/2\)。结合 \(\sin y\ge2y/\pi\)、\(\arcsin x\ge x\)，得到
\[
I_{m,r}\ge\frac1{2m}\left(\frac2\pi\right)^{2r},
\qquad I_{m,r}^{-1}\le c_rm,\quad c_r=2(\pi/2)^{2r}.
\tag{L9}
\]
也有 \(I_{m,r}\le(1+1/s)/m\)，但证明只需 (L9)。

当 \(m|x|\ge1\) 时积分 (L7) 的尾部，当 \(m|x|<1\) 时用单调性，得到
\[
|P_{m,r}(x)-\operatorname{sgn}x|
\le b_r\min\{1,(m|x|)^{-s}\},
\qquad b_r=\max\{1,c_r/s\}.
\tag{L10}
\]
若 \(R=|Z|\)，其 CDF 满足 \(F_R(t)\le Lt^\beta\)；把此界延伸到 \(t\ge1\) 仍有效。对 \(a>0,v>\beta\)，非负函数 Fubini 公式给出
\[
\begin{aligned}
\mathbb E\min\{1,(aR)^{-v}\}
&=v a^{-v}\int_{1/a}^\infty F_R(t)t^{-v-1}\,dt\\
&\le\frac{Lv}{v-\beta}a^{-\beta}.
\end{aligned}
\tag{L11}
\]
因而
\[
\sup_G\left|\int P_{m,r}\,dG-\theta(G)\right|
\le B_{\beta,L,r}m^{-\beta},\qquad
B_{\beta,L,r}=\frac{Lb_rs}{s-\beta}.
\tag{L12}
\]
这个偏差证明没有使用 \(G\) 的密度。

## 3. 逆导数系数的空间局部化

令 \(N=n-1\)，并令 \(b_0,\ldots,b_N\) 为 \(K_{m,r}\) 的 degree-\(N\) Bernstein 系数：
\[
K_{m,r}(2p-1)=\sum_{k=0}^Nb_k\binom Nk p^k(1-p)^{N-k}.
\]
置 \(J=2rm\le N/2\)。核的实际次数是 \(J-2r\)，以下复增长界使用稍大的参数 \(J\)。

**引理 L2。** 对 \(0\le k\le N\)，
\[
|b_k|\le3e^{2J^2/N}
\min\{1,(m|2k/N-1|)^{-2r}\},
\tag{L13}
\]
中心的最小值解释为一。

**证明。** 端点 \(b_0=b_N=m^{-2r}\) 满足结论。对内部 \(k\)，置
\[
p=k/N,\quad q=1-p,\quad \rho=p/q,\quad
z=\rho e^{it},\quad X=\frac{z-1}{z+1},\quad
x_k=2p-1,\quad v=2\sqrt{pq}|\sin(t/2)|.
\]
除零测点 \(z=-1\) 外，
\[
|X|^2=
\frac{\rho^2-2\rho\cos t+1}{\rho^2+2\rho\cos t+1}
\ge\frac{(\rho-1)^2}{(\rho+1)^2}=|x_k|^2.
\tag{L14}
\]
该分式关于 \(\cos t\) 非增。若 \(\rho=1,t=\pm\pi\)，按极限或在积分中删除该点处理。

upper_initial.md 的 U1 自包含证明了经典复增长界：一个在 \([-1,1]\) 上模不超过一、次数至多 \(d\) 的多项式，在此 \(X\) 上的模至多 \(e^{d\operatorname{arctanh}v}\)。分别对 \(K_{m,r}\) 和 \(S_m\) 使用，得到
\[
|K_{m,r}(X)|\le e^{J\operatorname{arctanh}v},
\qquad
|K_{m,r}(X)|
\le(m|x_k|)^{-2r}e^{J\operatorname{arctanh}v}.
\tag{L15}
\]
第二式只在 \(x_k\ne0\) 时需要，并使用了 (L14)。第一式使用实际次数 \(J-2r\le J\)，第二式使用分子 \(S_m^{2r}\) 的次数 \(J\)。两条有效复界的最小值给出与 \(t\) 无关的空间因子，乘以共同的增长界。

对多项式
\((1+z)^N K_{m,r}((z-1)/(z+1))\) 使用 Cauchy 系数积分。由于
\(|1+z|/(1+\rho)=\sqrt{1-v^2}\)，U1 的积分计算直接给出
\[
|b_k|\le e^{2J^2/N}
\min\{1,(m|x_k|)^{-2r}\}
\frac{\sqrt\pi/(2\sqrt{Npq})}{\binom Nk p^kq^{N-k}}.
\]
其中指数来自
\[
\max_{0\le v<1}
\left\{\frac N4\log(1-v^2)+J\operatorname{arctanh}v\right\}
\le2J^2/N,
\]
剩余归一化圆积分至多 \(\sqrt\pi/(2\sqrt{Npq})\)。\(J=N/2\) 的边界按连续极限处理。Stirling 余项使最后的比值至多 \(e^{1/6}\pi/\sqrt2<3\)，证明 (L13)。

这里没有将实轴局部界不加证明地延拓到复平面：(L15) 来自两个明确的全局多项式增长界和独立的几何事实 (L14)。\(\square\)

## 4. Bernstein 差分尾和

令 \(a_0,\ldots,a_n\) 为 \(P_{m,r}\) 的 degree-\(n\) Bernstein 系数。导数公式给出严格恒等式
\[
n(a_{k+1}-a_k)=2b_k/I_{m,r},\quad0\le k<n,
\qquad a_n=1,\quad a_{n-k}=-a_k.
\tag{L16}
\]
偶数 \(n\) 的中心系数恰为零。设
\[
E=\frac{8r^2m^2}{N}=\frac{2J^2}{N},\qquad
c'_r=6c_r2^{2r}\left(1+\frac1{2s}\right)
=12\pi^{2r}\left(1+\frac1{2s}\right).
\tag{L17}
\]

**引理 L3。** 以 \(\operatorname{sgn}(0)=0\) 作为系数比较约定，则
\[
|a_k-\operatorname{sgn}(2k/n-1)|
\le c'_r e^E(1+m|2k/n-1|)^{-s},\quad0\le k\le n.
\tag{L18}
\]

**证明。** 先取 \(\lceil n/2\rceil\le k<n\)，中心可单独由反对称性处理。置 \(z_k=2k/n-1\ge0\)。当 \(k\le l\le N\) 时，
\[
2l/N-1\ge z_k+2(l-k)/N.
\tag{L19}
\]
对 \(f(y)=\min\{1,y^{-2r}\}\)，有 \(f(y)\le2^{2r}(1+y)^{-2r}\)。非增函数的网格尾和至多首项加其积分，因此
\[
\begin{aligned}
\sum_{l=k}^N f(m(2l/N-1))
&\le2^{2r}\sum_{h=0}^\infty
 (1+mz_k+2mh/N)^{-2r}\\
&\le2^{2r}\left[
 (1+mz_k)^{-2r}
 +\frac{N}{2ms}(1+mz_k)^{-s}\right].
\end{aligned}
\tag{L20}
\]
由右端点 \(a_n=1\) 对 (L16) 求和，结合 (L9)、(L13)，有
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
最后使用 \(m/n\le1,N/n\le1\)。左半边由反对称性得到。端点偏差为零；若 \(n\) 为偶数，中心 \(a_{n/2}=0\) 对 \(\operatorname{sgn}(0)=0\) 的偏差也为零。\(\square\)

## 5. margin、观测噪声与 robust variance

令 \(\widehat Z=2S/n-1\)，\(v=2s>\beta\)。条件于 \(Z=z\)，在
\(|\widehat Z-z|\le|z|/2\) 上有 \(|\widehat Z|\ge|z|/2\)。Hoeffding 界给出补集概率至多 \(2e^{-nz^2/8}\)。被积函数至多一，因而
\[
\mathbb E[(1+m|\widehat Z|)^{-v}\mid Z=z]
\le(1+m|z|/2)^{-v}+2e^{-nz^2/8}.
\tag{L21}
\]
即使 \(z=0\)，该不等式仍成立。

下列积分均只使用 CDF 上限，不使用密度。对 \(a>0,v>\beta\)，
\[
\begin{aligned}
\mathbb E(1+aR)^{-v}
&=\int_0^\infty av(1+at)^{-v-1}F_R(t)\,dt\\
&\le La^{-\beta}M_{\beta,v},\qquad
M_{\beta,v}=
\frac{\Gamma(\beta+1)\Gamma(v-\beta)}{\Gamma(v)}.
\end{aligned}
\tag{L22}
\]
同样，
\[
\mathbb Ee^{-aR^2}
=\int_0^\infty2at e^{-at^2}F_R(t)\,dt
\le L\Gamma(1+\beta/2)a^{-\beta/2}.
\tag{L23}
\]
两式来自非负函数 Fubini 公式，因此原子没有导致分部积分边界缺失。

对 (L21) 积分，得
\[
\sup_G\mathbb E_G(1+m|\widehat Z|)^{-2s}
\le L\left[
 2^\beta M_{\beta,2s}m^{-\beta}
 +2\cdot8^{\beta/2}\Gamma(1+\beta/2)n^{-\beta/2}
\right].
\tag{L24}
\]
由 (L18)，
\[
a_S^2\le2+2(c'_r)^2e^{2E}(1+m|\widehat Z|)^{-2s}.
\]
记
\[
C_V=2(c'_r)^2L
\max\{2^\beta M_{\beta,2s},
       2\cdot8^{\beta/2}\Gamma(1+\beta/2)\}.
\tag{L25}
\]
利用 \(N=n-1\ge n/2\)，得到关键方差界
\[
\sup_{G\in\mathcal G_{\beta,L}}
\operatorname{Var}_{K_nG}(a_S)
\le2+C_V(m^{-\beta}+n^{-\beta/2})
\exp(32r^2m^2/n).
\tag{L26}
\]
这覆盖全部可行分布，而不是有限网格或某个参考密度。

## 6. 所有 \(Q,n\) 的风险优化

估计量为
\[
\widehat\theta=Q^{-1}\sum_{i=1}^Q a_{S_i},
\]
再截到 \([-1,1]\)。由偏差、独立性和方差界，
\[
\sup_G\mathbb E_G|\widehat\theta-\theta(G)|
\le B_{\beta,L,r}m^{-\beta}+\sqrt2 Q^{-1/2}
+\frac{\sqrt{C_V}}{\sqrt Q}
(m^{-\beta}+n^{-\beta/2})^{1/2}e^{16r^2m^2/n}.
\tag{L27}
\]
决策取估计的符号，估计恰为零时固定输出 \(+1\)；每个错误符号路径上的 regret 不超过绝对估计误差。

按 (L3)–(L5) 选择参数。令 \(C_m=(3/\gamma)^\beta=(48r)^\beta\)，则
\[
m^{-\beta}\le C_m(nH)^{-\beta/2},\quad
m^{-\beta}+n^{-\beta/2}\le(C_m+1)n^{-\beta/2},\quad
16r^2m^2/n\le H/16.
\tag{L28}
\]
因此 (L27) 至多
\[
B_{\beta,L,r}C_m(nH)^{-\beta/2}
+\sqrt2 Q^{-1/2}
+C_*n^{-\beta/4}Q^{-1/2}e^{H/16},
\quad C_*=\sqrt{C_V(C_m+1)}.
\tag{L29}
\]
而
\[
(nH)^{-\beta/2}
=\max\{n^{-\beta},(n\ell)^{-\beta/2}\}.
\tag{L30}
\]

若 \(0<A_*<1\)，则 \(e^{H/16}\le(e+1)^{1/16}\) 且 \(n^{-\beta/4}\le1\)，故最后一项至多 \(C_*(e+1)^{1/16}Q^{-1/2}\)。

若 \(A_*\ge1\)，则
\[
n^{-\beta/4}Q^{-1/2}e^{H/16}
\le n^{-\beta/2}A_*^{-1/2}(e+A_*)^{1/16}
\le C^\dagger_\beta(n\ell)^{-\beta/2},
\tag{L31}
\]
其中可以取
\[
C^\dagger_\beta=(e+1)^{1/16}e^{7/8}
\left(\frac{8\beta}{7e}\right)^{\beta/2}.
\tag{L32}
\]
验证：令 \(t=\log A_*\ge0\)，则 \(\ell\le2+t\)，且
\(A_*^{-1/2}(e+A_*)^{1/16}\le(e+1)^{1/16}e^{-7t/16}\)。
再用
\[
\sup_{y\ge0}y^{\beta/2}e^{-7y/16}
=\left(\frac{8\beta}{7e}\right)^{\beta/2}
\]
控制 \((2+t)^{\beta/2}e^{-7t/16}\) 即得。

若 \(n<n_0\)，恒零估计风险至多一，且
\(1\le n_0^\beta n^{-\beta}\le n_0^\beta\Phi_\beta(Q,n)\)。
因此一个完全明确的常数是
\[
C_{\beta,L}=
\max\left\{
n_0^\beta,\
B_{\beta,L,r}C_m+\sqrt2+
C_*\max\{(e+1)^{1/16},C^\dagger_\beta\}
\right\}.
\tag{L33}
\]
它有限且只依赖 \(\beta,L\)。这完成定理 L1 的上界证明，覆盖 \(Q=1\)、\(n=1\)、任意快慢的联合增长和次数饱和端点。\(\square\)

## 7. 可实现性、已有工具和结论边界

\(S_m,T_m,K_{m,r},I_{m,r},P_{m,r}\) 均有明确的有理系数表示，Bernstein 换基也只有有限有理运算。对给定 \(Q,n,\beta\)，选定整数 \(r,m\) 后的统计量可以精确计算；不需要输出精确随机实数，不依赖数值优化存在性。这里不宣称位复杂度或运行时间最优。

原始问题来自 Zhang–Amini 的 arXiv:2610.21363v1、Conjecture 6.4 和标量实验。原文已有 margin 局部 sign 逼近、modulus 等价、谱分解和端点界。Bernstein–Walsh 增长、Cauchy 公式、Stirling 余项、正核逼近及 Bernstein 导数公式都是经典工具。

本文需要单独核验的增量是：对明确的正导数核同时控制 degree-\(n\) 逆系数的指数增长和空间衰减，通过差分尾和传给 sign 系数，再对含原子的完整 margin 类积分得到 (L26)，进而证明 (L2)。这些证明不依赖初始稿的浮点诊断，也不把“尚未找到相同公式”当作重大原创性的证据。

本文内没有给出 (L1) 的 minimax 下界，也没有单独完成相对于原 Conjecture 6.4 的严格渐近分离。若独立下界与 (L1) 匹配，应在统一主稿中明确引用并重新核查，不能由相似的对数项推断全定理已闭合。局部逆系数方法及同一统计风险是否已有等价先例，仍须专门查新和实际价值审查。

### 来源

- Zhang–Amini, *Two Sample Sizes in Test-Time LLM Ensembling: Buffered ERM and Minimax Theory*, arXiv:2610.21363v1, 2026. [原始全文](https://arxiv.org/pdf/2610.21363).
- D. S. Lubinsky and Z. Ziegler, *Coefficient Bounds in the Lorentz Representation of a Polynomial*, Canadian Mathematical Bulletin 33(2), 1990. [DOI:10.4153/CMB-1990-033-1](https://doi.org/10.4153/CMB-1990-033-1). 经典系数与复解析方法近邻，不视为本稿双参数局部结论的已核等价结果。
- Herbert Robbins, *A Remark on Stirling's Formula*, American Mathematical Monthly 62(1):26–29, 1955. [DOI:10.2307/2308012](https://doi.org/10.2307/2308012).
- Wassily Hoeffding, *Probability Inequalities for Sums of Bounded Random Variables*, Journal of the American Statistical Association 58(301):13–30, 1963. [DOI:10.1080/01621459.1963.10500830](https://doi.org/10.1080/01621459.1963.10500830). (L21) 使用其独立有界变量尾界。

