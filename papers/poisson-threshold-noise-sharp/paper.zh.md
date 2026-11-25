# 泊松阈值噪声稳定性的精确强度边界

**AI辅助研究稿，2026-11-25。** 本文尚无外部同行评议，全文 Lean 形式化尚未完成。

## 摘要

设两个均值为 $r$ 的泊松计数共享一个均值为 $ar$ 的泊松分量，记单个计数不超过 $m$ 的概率为 $q_m(r)$。本文刻画联合下尾概率对全部 $a\in[0,1]$ 同时满足上界 $q_m(r)^{2-a}$ 的全部强度。对每个整数 $m\ge1$，该性质等价于 $a=0$ 处的一阶导数条件，且其成立区间恰为 $(0,R_m]$。临界强度是一个显式标量函数的唯一正零点，满足 $R_m>m+1$，并具有渐近式 $R_m=m+c_*\sqrt m+o(\sqrt m)$，其中 $c_*$ 由正态风险率方程唯一确定。证明结合了可复用的非负谱序列精确判据、标量函数的单次穿越论证、经典 Ramanujan 序列及阶乘界，以及两张显式有理数 Bernstein 证书。主定理覆盖 [HMR] 附录 D 所需的解析重叠不等式参数窗口；本文的应用主张限定于这一已经核对的不等式。

## 1. 研究动机、相关工作与来源边界

作者稿 [HMR, v1, 附录 D, 第 55—56 页] 提出了阈值群测信息论分析所需的联合泊松下尾不等式。该文的解析论证覆盖阈值二，附录对更高阈值及强度窗口 $[t-1,t]$ 给出了数值探索。本文研究该不等式的全部强度范围，同时确定必要条件、成立域的唯一边界及其在大阈值下的位置。

应用依据是经作者全文镜像实际读取的 v1 稿件。[HMR, v3] 的元数据已经取得，但本次研究未获得其完整正文。因此，下述文献比较仅涉及明确标出的已核版本和结论，不构成穷尽式全球优先权主张。特别地，[CO] 已通过空间耦合算法无条件达到相同的测试数主阶基准；本文不主张首次以算法达到该基准，也不主张任意测试设计下的容量。[TMS, §1.2] 的后续比较同样区分了带解析条件的常列重设计分析与空间耦合结果。

一个相关基线是受限泊松超压缩性。[NPY, 定理 1.4] 对非负非增泛函给出
$$
\|P_s f\|_{1+(p-1)e^s}\le\|f\|_p.
$$
对阈值指示函数，利用可逆性及满足 $a=e^{-2s}$ 的对称半群分解，可得
$$
p_m(r,a)\le q_m(r)^{\,2/(1+\sqrt a)}.
$$
当 $0<a<1$ 时，这个指数严格小于 $2-a$，所以该直接推论不足以推出本文研究的精确界。本文证明的是阈值事件特有的强度刻画，而非任意泊松事件的超压缩不等式。

下文的非负展开与指数函数的 Hermite 余项都是已有的标准工具。本文主张的研究增量是所述从局部条件到全相关区间的阈值定理，以及将这些工具与标量临界边界连接起来的完整证明。文献和应用层面的表述均限定在实际核对的来源范围内。

## 2. 精确定义与主定理

对整数 $m\ge0$ 与 $r>0$，定义
$$
E_m(r)=\sum_{j=0}^m\frac{r^j}{j!},\qquad
q_m(r)=e^{-r}E_m(r),\qquad
u_m(r)=e^{-r}\frac{r^m}{m!},\qquad
h_m(r)=\frac{u_m(r)}{q_m(r)}.
\tag{2.1}
$$
对 $a\in[0,1]$，令 $Z,X,Y$ 为独立泊松变量，均值依次为 $ar,(1-a)r,(1-a)r$，并定义
$$
p_m(r,a)=\Pr(Z+X\le m,\ Z+Y\le m).
\tag{2.2}
$$
参数固定时省略下标，全文统一使用
$$
L=-\log q,\qquad A=rh^2,\qquad
B=\frac12(m-r)^2h^2,\qquad
K(L)=e^L(3-L)-3-2L.
\tag{2.3}
$$
因此 $L>0$。对 $Z$ 条件化可得
$$
p_m(r,a)=e^{-(2-a)r}\sum_{b=0}^m\frac{(ar)^b}{b!}
 E_{m-b}((1-a)r)^2,
\quad p_m(r,0)=q^2,\quad p_m(r,1)=q.
\tag{2.4}
$$

**定理 2.1。** 对每个整数 $m\ge1$，函数
$$
F_m(r)=r h_m(r)^2+\log q_m(r)=A-L.
\tag{2.5}
$$
恰有一个正零点 $R_m$。对任意 $r>0$，以下三个命题等价：

1. 对所有 $a\in[0,1]$，均有 $p_m(r,a)\le q_m(r)^{2-a}$。
2. $F_m(r)\le0$，即 $A\le L$。
3. $0<r\le R_m$。

当这些条件成立时，命题 1 的不等式对每个 $0<a<1$ 都严格成立。当 $r>R_m$ 时，每个充分小的正 $a$ 都违反该不等式。此外，
$$
R_m>m+1,
\tag{2.6}
$$
且当 $m\to\infty$ 时，
$$
R_m=m+c_*\sqrt m+o(\sqrt m),
\qquad
\left(\frac{\phi(c_*)}{\Phi(-c_*)}\right)^2=-\log\Phi(-c_*).
\tag{2.7}
$$
其中 $\phi,\Phi$ 分别为标准正态密度与分布函数，$c_*$ 是所给方程的唯一正解。数值 $c_*\approx0.2057916880$ 仅用于说明位置，不参与证明。对 $m\ge17$，证明还给出
$$
R_m<m+1+\frac13\sqrt{m+1}.
\tag{2.8}
$$

退化情形 $m=0$ 可直接处理：$q_0(r)=e^{-r}$，且 $p_0(r,a)=e^{-(2-a)r}$，所以对所有 $r>0$ 与 $a\in[0,1]$ 恒取等号，此时不存在唯一临界强度。

## 3. 非负谱展开与序列类的精确判据

### 3.1. 泊松谱展开

对整数 $j$，当 $j\ge0$ 时令 $q_j=\Pr(\operatorname{Poi}(r)\le j)$，否则令 $q_j=0$。记
$$
d_k=\sum_{j=0}^k(-1)^{k-j}\binom{k}{j}q_{m-j}.
$$
则有
$$
p_m(r,a)=\sum_{k=0}^\infty c_k a^k,
\qquad c_k=\frac{r^k}{k!}d_k^2\ge0.
\tag{3.1}
$$
这个恒等式对 (2.4) 给出的关于 $a$ 的整函数延拓也成立。直接证明如下：联合概率生成函数为
$$
G_a(x,y)=\exp\{r(x-1)+r(y-1)+ar(x-1)(y-1)\}.
$$
将其所有满足 $0\le i,j\le m$ 的系数相加，即得 $p_m(r,a)$。在 $a=0$ 处求 $k$ 阶导数，并提取这有限多个系数，可得
$$
p_m^{(k)}(r,0)=r^k
 \left(\sum_{i=0}^m[x^i](x-1)^k e^{r(x-1)}\right)^2=r^k d_k^2.
$$
式 (2.4) 是指数函数与多项式的乘积，其 Taylor 级数处处收敛，因此上述有限系数运算均合法。特别地，
$$
c_0=q^2,\qquad c_1=ru^2,\qquad c_2=\tfrac12(m-r)^2u^2,
\qquad \sum_{k\ge0}c_k=q.
\tag{3.2}
$$
这里 $d_1=-u$，而 $d_2=u(1-m/r)$。因此 $c_1/q^2=A$，$c_2/q^2=B$。

### 3.2. 可复用的极值判据

**定理 3.1。** 设 $L\ge0$、$A,B\ge0$，且 $e^L\ge1+A+B$。考虑所有满足
$$
s_0=1,\quad s_1=A,\quad s_2=B,\quad \sum_{k\ge0}s_k=e^L.
$$
的非负序列 $(s_k)_{k\ge0}$。对这一非空序列类中的每个序列及每个 $a\in[0,1]$，不等式 $\sum_{k\ge0}s_k a^k\le e^{La}$ 同时成立，当且仅当
$$
A\le L,\qquad 2A+B\le e^L(3-L)-3,
\tag{3.3}
$$
等价地，要求 $A\le L$ 及 $2(L-A)+K(L)-B\ge0$。

**证明。** 由系数非负及 $k\ge3$ 时 $a^k\le a^3$，得到精确的逐点极值多项式
$$
\sum_{k\ge0}s_k a^k\le
P(a):=1+Aa+Ba^2+(e^L-1-A-B)a^3.
\tag{3.4}
$$
将全部剩余质量放在下标 3 上的合法序列，对所有 $a$ 同时达到等号。若全类序列均满足指数上界，该多项式也必须满足。比较 0 处右导数即得 $A\le L$。又因 $P(1)=e^L$，且在 1 的左侧有 $P(a)-e^{La}\le0$，其在 1 处的左导数必非负。因此
$$
P'(1)=3e^L-3-2A-B\ge Le^L,
$$
这就是 (3.3) 的第二个条件。

为证明充分性，取在 0 和 1 处同时匹配函数值及一阶导数的三次 Hermite 插值多项式
$$
H_L(a)=1+La+K(L)a^2+J(L)a^3,
\qquad J(L)=e^L(L-2)+L+2.
\tag{3.5}
$$
对 $0<a<1$，插值余项为
$$
e^{La}-H_L(a)=\frac{L^4e^{L\xi}}{24}a^2(a-1)^2\ge0
$$
其中某个 $\xi\in(0,1)$。端点取等号及 $L=0$ 的情形显然成立。该公式也可在插值误差中减去适当倍数的 $a^2(a-1)^2$ 后连续应用四次 Rolle 定理得到。最后，
$$
H_L(a)-P(a)
=a(1-a)\bigl[(L-A)+(L-A+K(L)-B)a\bigr].
\tag{3.6}
$$
方括号内是仿射函数，其两个端点值分别为 $L-A$ 和 $2(L-A)+K(L)-B$，均由 (3.3) 保证非负。结合 (3.4)—(3.6) 即证充分性。$\square$

定理的假设保证序列类非空。定理 3.1 的必要性针对包含三次极值序列的**整个序列类**；它并不声称 (3.3) 的第二个条件对某个具体泊松谱也必要。本文将第二个条件用作泊松问题的充分证书。第一个条件对泊松问题本身确实必要，因为除以 $q^2$ 后，左侧在 $a=0$ 处的右导数恰为 $A$。

## 4. 标量临界强度的存在唯一性

固定 $m$，并省略下标。令 $J_r$ 具有如下截断泊松分布：

$$
\Pr(J_r=j)=\frac{r^j}{j!E_m(r)},\qquad 0\leq j\leq m.
$$

其均值及均值与阈值的缺口为

$$
z(r)=\mathbb E J_r=r(1-h(r)),\qquad
\delta(r)=m-z(r)=m-r(1-h(r)).
$$

支撑集的两个端点均具有正概率。因此 $0<z<m$、$0<\delta<m$，并且

$$
z'(r)=\frac{\operatorname{Var}(J_r)}r>0.
\tag{4.1}
$$

所以 $\delta$ 严格递减。由有限和表达式，$r\downarrow0$ 时 $\delta(r)\to m$，$r\to\infty$ 时 $\delta(r)\to0$。直接求导得

$$
(\log q)'=-h,\qquad
h'=\frac{h\delta}{r},\qquad
\delta'=h(\delta+1)-1.
\tag{4.2}
$$

定义

$$
G(r)=(1+2\delta(r))h(r)-1.
$$

则有

$$
F'(r)=h(r)G(r).
\tag{4.3}
$$

下面证明 $G$ 恰有一个零点，并在该点从负值穿越到正值。在任意 $G$ 的零点处，

$$
h=\frac1{1+2\delta},\qquad
r=\frac{(m-\delta)(1+2\delta)}{2\delta},
$$

将其代入 $G$ 的导数，得到

$$
G'=\frac{2\delta(2\delta^2+2\delta-m)}
          {(m-\delta)(1+2\delta)^2}.
\tag{4.4}
$$

令

$$
d_* = \frac{\sqrt{1+2m}-1}{2}\in(0,m).
$$

由 $\delta$ 的严格单调性和端点极限，存在唯一 $r_*>0$ 使 $\delta(r_*)=d_*$。式 (4.4) 表明：$G$ 在 $(0,r_*)$ 内的每个零点导数均为正，而在 $(r_*,\infty)$ 内的每个零点导数均为负。

有限和表达式还给出

$$
G(r)\longrightarrow-1\quad(r\downarrow0),
$$

且对固定 $m$，

$$
h(r)=1-\frac mr+\frac m{r^2}+O(r^{-3}),\quad
\delta(r)=\frac mr+O(r^{-2}),\quad
G(r)=\frac mr+O(r^{-2}).
\tag{4.5}
$$

特别地，$G$ 在充分大的 $r$ 处为正。在 $(r_*,\infty)$ 内不可能有零点：若有，函数在该点向下穿越；此后首次从负值返回零的点具有非负导数，与 (4.4) 矛盾。因此 $G>0$ 在整个 $(r_*,\infty)$ 上成立。

还必须排除退化相切情形 $G(r_*)=0$，单靠非退化零点的导数符号并不足够。对 $0<d<m$，令

$$
t=\frac{1+g}{1+2d},\qquad
\Psi(d,g)=\frac{(1+g)d(1-t)}{m-d}
               +2t\bigl(t(d+1)-1\bigr).
$$

在 $G=0$ 的点附近，由 (4.2) 及 $r=(m-\delta)/(1-h)$ 得

$$
G'=\Psi(\delta,G).
$$

在 $g=0$ 处，

$$
\Psi(d,0)=\frac{2d(2d^2+2d-m)}{(m-d)(1+2d)^2}.
$$

该式在 $d=d_*$ 处为零，且关于 $d$ 的导数严格为正：分子中消失因子的导数为 $4d_*+2>0$，其余因子均为正。若 $G(r_*)=0$，则 $G'(r_*)=0$，且

$$
G''(r_*)=\Psi_d(d_*,0)\delta'(r_*)<0,
$$

这里用到了该点处 $\delta'=-d_* /(1+2d_*)<0$。于是 $r_*$ 成为值为零的严格局部极大点，迫使其右侧紧邻处出现负值，矛盾。因此 $G(r_*)>0$。

由于 $G$ 在零的右邻域为负，现在可知 $(0,r_*)$ 中至少有一个零点；也至多有一个，因为该区间内的所有零点都严格向上穿越，而两个这样的零点之间必有一次从正值回到负值的过程。故唯一穿越点存在，记为 $s_m$。

由 (4.3)，$F$ 在 $(0,s_m)$ 上严格递减，在 $(s_m,\infty)$ 上严格递增；其连续延拓满足 $F(0)=0$。最后，结合 (4.5) 和 $E_m$ 的首项得

$$
F(r)=m\log r-\log(m!)-2m+O(r^{-1})\longrightarrow+\infty.
\tag{4.6}
$$

因此 $F$ 恰有一个正零点 $R_m>s_m$，并具有定理 2.1 中所述的符号分布。

## 5. 应用窗口严格包含于成立域

令 $n=m+1\ge2$，本节记

$$
u=e^{-n}\frac{n^n}{n!}
  =e^{-n}\frac{n^{n-1}}{(n-1)!},\qquad
q=e^{-n}\sum_{j=0}^{n-1}\frac{n^j}{j!}.
$$

Ramanujan 数

$$
\theta_n=\left(\frac{e^n}{2}-\sum_{j=0}^{n-1}\frac{n^j}{j!}\right)
             \frac{n!}{n^n}
$$

满足 $q=1/2-\theta_nu$，且有经典估计

$$
\frac13\leq\theta_n\leq T_n:=\frac13+\frac4{135n}.
\tag{5.1}
$$

式 (5.1) 可直接由 [BRS, 第 1 页 (1.3)、第 2 页 (2.2)] 推出。Robbins 阶乘不等式 [R] 给出

$$
\frac{e^{-1/(12n)}}{\sqrt{2\pi n}}
 < u <
\frac{e^{-1/(12n+1)}}{\sqrt{2\pi n}}.
\tag{5.2}
$$

令 $x=n^{-1/2}$，于是 $0<x\le1/\sqrt2<71/100$。下面证明便于使用的多项式上界

$$
u<x k(x),\qquad k(x)=\frac25\left(1-\frac{x^2}{13}\right).
\tag{5.3}
$$

事实上，$(2\pi)^{-1/2}<2/5$。对 $z=x^2\le1/2$ 与 $y=z/(12+z)$，有

$$
e^{-y}\leq1-y+\frac{y^2}{2}\leq1-\frac z{13}.
$$

最后一个不等式除以 $z>0$ 后等价于 $12-\tfrac{35}{2}z-z^2\ge0$，其在 $[0,1/2]$ 上的最小值为 3。结合 (5.2) 的上界即得 (5.3)。

接下来核对以这些上界替换 $\theta_n$ 和 $u$ 时的方向，因为单独的对数项具有相反的单调性。定义

$$
f_n(v,t)=\frac{n v^2}{(1/2-tv)^2}+\log(1/2-tv),\quad Q=1/2-tv.
$$

其偏导数为

$$
\frac{\partial f_n}{\partial t}
  =\frac{v(2n v^2-Q^2)}{Q^3},\qquad
\frac{\partial f_n}{\partial v}
  =\frac{n v-tQ^2}{Q^3}.
\tag{5.4}
$$

由 (5.2) 的下界、$\pi<22/7$ 及 $e^{-a}>1-a$，有

$$
2n u^2>\frac1\pi e^{-1/(6n)}>
\frac7{22}\frac{11}{12}=\frac7{24}>\frac14.
\tag{5.5}
$$

另有 $nu>1/2$，因为 $(nu)^2>7n/48\ge7/24>1/4$。对 $u\le v\le xk(x)$ 及 $\theta_n\le t\le T_n<1/2$，有 $v<2/5$，从而 $0<Q\le1/2$。因此 (5.4) 的两个偏导数在整个矩形上均为正，得到

$$
F_{n-1}(n)=f_n(u,\theta_n)
 < f_n(xk(x),T_n)
 =\frac{k(x)^2}{Q(x)^2}+\log Q(x),
\tag{5.6}
$$

其中

$$
t(x)=\frac13+\frac{4x^2}{135},\quad
w(x)=x t(x)k(x),\quad Q(x)=\frac12-w(x).
$$

对 $0\le x\le71/100$，有 $0\le w(x)<1/2$。利用对数级数和 $\log2>693/1000$，得

$$
\log Q(x)
 \leq-\frac{693}{1000}-2w(x)-2w(x)^2-\frac83w(x)^3.
\tag{5.7}
$$

这里关于 $\log2$ 的界，可通过保留正项级数 $\log2=2\sum_{j\ge0}((2j+1)3^{2j+1})^{-1}$ 的前四项得到。

定义以下有理系数的 25 次多项式：

$$
P(x)=\left(\frac{693}{1000}+2w(x)+2w(x)^2+\frac83w(x)^3\right)
           \left(\frac12-w(x)\right)^2-k(x)^2.
\tag{5.8}
$$

其正性具有显式证书。写成 $P(x)=\sum_{j=0}^{25}a_jx^j$，令 $a=71/100$，并定义

$$
b_i=\sum_{j=0}^i a_j a^j\frac{\binom ij}{\binom{25}j},\qquad0\leq i\leq25.
\tag{5.9}
$$

这些就是下列 Bernstein 展开的系数：

$$
P(x)=\sum_{i=0}^{25}b_i\binom{25}i(x/a)^i(1-x/a)^{25-i}.
$$

有 $b_0=53/4000$。按 $i=0,\ldots,25$ 排列，精确整数 $\lfloor1000b_i/b_0\rfloor$ 依次为

$$
\begin{split}
&(1000,944,890,838,787,737,688,641,595,551,508,466,426,\\
&\qquad 387,349,313,278,244,212,181,152,123,96,71,46,23).
\end{split}
\tag{5.10}
$$

事实上，每个 $b_i>(23/1000)b_0=1219/4000000$，这是有限多个有理数不等式。多项式定义与基转换公式已在正文给出；完整有理系数表和精确检查程序未随本版本公开。其中没有浮点计算或采样。由于 Bernstein 基函数非负且总和为一，

$$
P(x)>\frac{1219}{4000000}>0\qquad(0\leq x\leq71/100).
\tag{5.11}
$$

结合 (5.6)—(5.8) 得

$$
F_{n-1}(n)<-\frac{P(x)}{Q(x)^2}<0.
$$

于是 $F_m(m+1)<0$，结合第 4 节的唯一性得 $R_m>m+1$。该证书还给出保守的统一上界 $F_m(m+1)<-1219/10^6$。

## 6. 整个左半区 $0<r\le m$ 上的传播论证

我们证明更强的估计
$$
2A+B\le2L\qquad(0<r\le m).
\tag{6.1}
$$
所用端点条件来自第 5 节和第 4 节的符号刻画，即 $m h_m(m)^2<-\log q_m(m)$。

记 $d=m-r$。直接求导可得
$$
q'=-u,\qquad L'=h,\qquad h'=\left(\frac dr+h\right)h.
\tag{6.2}
$$
定义
$$
f=L-\left(r+\frac{d^2}{4}\right)h^2,\qquad
C=1+\frac32d+\frac{d^3}{2r},\qquad
D=2r+\frac{d^2}{2},\qquad S=Ch+Dh^2.
$$
精确求导得
$$
f'=h(1-S),\qquad
\frac{S'}h=-\frac32+\frac dr+\frac{d^3(d-1)}{2r^2}+3Ch+2Dh^2.
\tag{6.3}
$$
在任意 $S=1$ 的点处代入 $Dh^2=1-Ch$，得到
$$
\frac{S'}h=\frac12+\frac dr+\frac{d^3(d-1)}{2r^2}+Ch>0.
\tag{6.4}
$$
当 $d\ge1$ 时正性显然成立。当 $0\le d\le1$ 时，利用 $r=m-d\ge1-d$，有
$$
\frac dr-\frac{d^3(1-d)}{2r^2}
=\frac{d[2r-d^2(1-d)]}{2r^2}\ge0,
$$
因为 $2r-d^2(1-d)\ge(2-d^2)(1-d)\ge0$。这也覆盖了 $m=1$。

当 $r\downarrow0$ 时，$h(r)\sim r^m/m!$、$f(r)\to0$；对 $m=1$，有 $S(r)\to1/2$，对 $m\ge2$，有 $S(r)\to0$。由 (6.4)，每次经过水平 $S=1$ 都严格向上穿越，所以至多发生一次。具体地，若存在两次向上穿越，中间就必须从大于 1 返回小于 1；首次返回到值 1 的点的左导数非正，与 (6.4) 矛盾。

因此 $f$ 先递增，若穿越发生则随后递减。将其连续延拓为 $f(0)=0$ 后，在 $[0,m]$ 上的最小值必取于端点。另一个端点为
$$
f(m)=-\log q_m(m)-m h_m(m)^2>0.
$$
故每个 $0<r\le m$ 都有 $f(r)>0$，从而证明 (6.1)，并且实际上是严格不等式。

为应用三次证书，我们再直接证明本区域内 $q_m(r)>1/2$，无需引入额外概率不等式。分部积分给出
$$
q_m(r)=\frac1{m!}\int_r^\infty x^m e^{-x}\,dx.
$$
对 $0<t<m$，被积函数在 $m+t$ 处与 $m-t$ 处之比为
$$
e^{-2t}\left(\frac{m+t}{m-t}\right)^m>1,
$$
因为对 $0<x<1$ 有 $\log((1+x)/(1-x))>2x$。将这些点配对并保留 $2m$ 以上的正尾积分，即得 $q_m(m)>1/2$。再由 $q_m$ 递减，结论对所有 $r\le m$ 成立。因此 $0<L<\log2<1$。

最后，$K(0)=K'(0)=0$，且 $0<L<1$ 时 $K''(L)=e^L(1-L)>0$，所以 $K(L)>0$。式 (6.1) 从而推出 (3.3) 的两个条件，且第二个严格成立：
$$
A\le L,\qquad 2A+B\le2L<e^L(3-L)-3.
\tag{6.5}
$$

## 7. 众数右侧的统一标量界

下面对每个整数 $m\ge1$ 证明
$$
q_m(r)>\frac13\qquad(0<r\le R_m),
\tag{7.1}
$$
$$
0\le y_m(r):=\frac{r-m}{r h_m(r)}<\frac45
\qquad(m\le r\le R_m).
\tag{7.2}
$$
对 $m\ge17$，所用构造还将证明
$$
R_m<m+1+\frac13\sqrt{m+1}.
\tag{7.3}
$$

### 7.1. 单调性与端点化归

令 $T_m(r)=1/h_m(r)$。由有限泊松和得

$$
T_m(r)=\sum_{j=0}^{m}\frac{(m)_j}{r^j},
\qquad (m)_j=\frac{m!}{(m-j)!}.
$$

利用系数的望远镜相消，得到

$$
y_m(r):=\frac{r-m}{rh_m(r)}
 =\left(1-\frac mr\right)T_m(r)
 =1-\sum_{j=1}^m\frac{j(m)_j}{r^{j+1}}.
\tag{7.4}
$$

因此 $y_m$ 在 $(0,\infty)$ 上严格递增；同时 $q_m'=-u_m<0$。故对每个 $m$，只需找到一点 $b_m>R_m$，使 $q_m(b_m)>1/3$ 且 $y_m(b_m)<4/5$。

### 7.2. 对全部 $m\ge17$ 的统一端点

令 $n=m+1\ge18$、$x=n^{-1/2}$，并设

$$
r_0=n+\frac13\sqrt n,\qquad 0<x\leq\frac1{\sqrt{18}}<\frac6{25}.
$$

本节记 $u(s)=u_{n-1}(s)$、$q(s)=q_{n-1}(s)$、$u_0=u(n)$、$u_1=u(r_0)$。第 5 节使用的经典界给出

$$
q(n)=\frac12-\theta_nu_0,\qquad
\frac13\leq\theta_n\leq\frac13+\frac{4x^2}{135},
\tag{7.5}
$$

$$
\frac{e^{-x^2/12}}{\sqrt{2\pi}}
  <\frac{u_0}{x}<\frac1{\sqrt{2\pi}}<\frac25.
\tag{7.6}
$$

以上分别是 Ramanujan 序列界和 Robbins 阶乘界，原始来源为 [BRS] 与 [R]。

#### 7.2.1. 密度的显式下界

定义下列有理系数多项式：

$$
a(x)=\frac{199}{500}\left(1-\frac{x^2}{12}\right),\qquad
v(x)=\frac1{18}+\frac x3,
$$

$$
b(x)=a(x)\left(1-v(x)+\frac{v(x)^2}{2}-\frac{v(x)^3}{6}\right).
\tag{7.7}
$$

由于 $199/500<\sqrt{7/44}<(2\pi)^{-1/2}$，结合 (7.6) 与 $e^{-t}>1-t$，得到

$$
u_0>x a(x).
\tag{7.8}
$$

进一步，

$$
\begin{split}
\log\frac{u_1}{u_0}
 &=-\frac1{3x}+(x^{-2}-1)\log(1+x/3)\\
 &\geq-\frac1{18}-\frac x3+\frac{x^2}{18}
 \geq-v(x),
\end{split}
$$

这里使用了 $\log(1+t)\ge t-t^2/2$。利用下方 Taylor 多项式 $e^{-v}\ge1-v+v^2/2-v^3/6$，得

$$
u_1>x b(x).
\tag{7.9}
$$

对所有 $0\le x\le6/25$，有以下基本估计：

$$
\frac{39}{100}<a(x)<\frac25,\qquad
\frac{17}{50}<b(x)\leq a(x)<\frac25.
\tag{7.10}
$$

为证明 $b$ 的下界，可以舍去其非负的二次项与三次项之差，得到

$$
b(x)\geq a(x)(1-v(x))
 \geq \frac{24074821}{70312500}>\frac{17}{50}.
$$

这里的下界是乘积在 $x=6/25$ 处的值；两个正因子均递减。又由 $1-v+v^2/2-v^3/6\le1$ 得 $b\le a$。

#### 7.2.2. 尾概率的上下界

密度 $u(s)$ 的众数为 $n-1$，所以它在 $s\ge n$ 时递减。由 (7.5)—(7.6) 得

$$
\begin{split}
q(r_0)
 &=q(n)-\int_n^{r_0}u(s)\,ds\\
 &>\frac12-\frac25\left(\frac13+\frac x3+\frac{4x^3}{135}\right)\\
 &\geq\frac{783991}{2343750}>\frac13.
\end{split}
\tag{7.11}
$$

为求上界，注意

$$
\frac{u''(s)}{u(s)}=
\frac{(s-(n-1))^2-(n-1)}{s^2}.
$$

密度在整个 $[n,r_0]$ 上凹，因为对 $0\le x\le6/25$ 有 $(x+1/3)^2<1-x^2$。因此其积分不小于梯形近似。结合 $\theta_n\ge1/3$ 及 (7.8)—(7.9)，得到

$$
q(r_0)
 \leq\frac12-\frac{u_0}{3}
              -\frac{\sqrt n}{6}(u_0+u_1)
 < Q(x),
\tag{7.12}
$$

其中

$$
Q(x)=\frac12-\frac{x a(x)}{3}-\frac{a(x)+b(x)}6.
\tag{7.13}
$$

由 (7.10)，在整个 $[0,6/25]$ 上有 $1/3<Q(x)<2/5$。下界可由下式直接得到：

$$
Q(x)>\frac12-\frac{2x}{15}-\frac2{15}
 \geq\frac{251}{750}>\frac13.
$$

#### 7.2.3. 该端点位于临界根右侧

令 $C(x)=(1+x/3)b(x)^2$。由 (7.9)，

$$
F_{n-1}(r_0)
 >\frac{C(x)}{q(r_0)^2}+\log q(r_0).
$$

对 $0<q\le Q(x)<2/5$，函数 $C(x)/q^2+\log q$ 递减，因为其导数为 $(q^2-2C(x))/q^3<0$，这里用到了 $2C(x)>2(17/50)^2>(2/5)^2$。因此

$$
F_{n-1}(r_0)>
\frac{C(x)}{Q(x)^2}+\log Q(x).
\tag{7.14}
$$

令 $z(x)=3Q(x)-1$，则 $0<z(x)<1/5$。结合 $\log3<11/10$ 和 $\log(1+z)\ge z-z^2/2+z^3/3-z^4/4$，得到

$$
\log Q(x)>-\frac{11}{10}
            +z(x)-\frac{z(x)^2}{2}+\frac{z(x)^3}{3}-\frac{z(x)^4}{4}.
$$

第一个常数界完全由有理数计算得到：$e^{11/10}>\sum_{j=0}^5(11/10)^j/j!=36015101/12000000>3$。

因此只需证明下列 30 次多项式为正：

$$
P_+(x)=(1+x/3)b(x)^2
 +Q(x)^2\left[-\frac{11}{10}+z(x)-\frac{z(x)^2}{2}
                  +\frac{z(x)^3}{3}-\frac{z(x)^4}{4}\right].
\tag{7.15}
$$

其有限精确证书如下。令 $p_j$ 为 $P_+$ 的幂基系数，并设

$$
\beta_i=\sum_{j=0}^i p_j(6/25)^j
                 \frac{\binom ij}{\binom{30}j},\qquad0\leq i\leq30.
\tag{7.16}
$$

每个 $\beta_i>1/400$。精确整数 $\lfloor1000\beta_i/\beta_0\rfloor$ 按下标顺序为

$$
\begin{split}
&(1000,990,979,968,957,945,932,919,905,891,877,862,846,831,814,797,\\
&\qquad780,762,744,725,706,686,666,645,624,603,581,559,536,513,489).
\end{split}
\tag{7.17}
$$

完整有理系数表及精确检查程序未随本版本公开。由 (7.16) 对应的 Bernstein 表示，得到

$$
P_+(x)>\frac1{400}>0\qquad(0\leq x\leq6/25).
\tag{7.18}
$$

式 (7.14)—(7.18) 给出 $F_{n-1}(r_0)>0$，所以唯一根定理推出 $R_{n-1}<r_0$，即 (7.3)。

#### 7.2.4. 端点处比值的界

由 (7.9)、(7.10) 和 $q(r_0)<1/2$，得

$$
\begin{split}
y_{n-1}(r_0)
 &=\frac{x+1/3}{1+x/3}\frac{q(r_0)}{u_1/x}\\
 &<\frac{25}{17}\frac{x+1/3}{1+x/3}
 \leq\frac{1075}{1377}<\frac45.
\end{split}
\tag{7.19}
$$

中间关于 $x$ 的有理函数递增，故在 $6/25$ 处取得最大值。结合 (7.11)、(7.19) 及第 7.1 节的单调性，(7.1)—(7.2) 对所有 $m\ge17$ 得证。

### 7.3. 其余十六个阈值

选取下列有理数端点，目的仅是简化有限验证：

| $m$ | 端点 $b_m$ | $m$ | 端点 $b_m$ |
|---:|---:|---:|---:|
| 1 | $11/5$ | 9 | $211/20$ |
| 2 | $13/4$ | 10 | $58/5$ |
| 3 | $43/10$ | 11 | $63/5$ |
| 4 | $107/20$ | 12 | $273/20$ |
| 5 | $32/5$ | 13 | $147/10$ |
| 6 | $149/20$ | 14 | $157/10$ |
| 7 | $17/2$ | 15 | $67/4$ |
| 8 | $19/2$ | 16 | $71/4$ |

对表中每个端点，精确检查程序均证明

$$
F_m(b_m)>\frac1{1000},\qquad
q_m(b_m)>\frac13,\qquad y_m(b_m)<\frac45.
\tag{7.20}
$$

为完整定义证书，对有理数 $0<t<102$，令

$$
\mathcal E_{100}(t)=\sum_{j=0}^{100}\frac{t^j}{j!}
  +\frac{t^{101}}{101!}\frac1{1-t/102}.
$$

正项指数级数尾部的相邻项之比至多为 $t/102<1$，所以 $e^t<\mathcal E_{100}(t)$。在某个端点处记

$$
S=\sum_{j=0}^m\frac{b_m^j}{j!},\quad
v=\frac{b_m^m}{m!},\quad A=b_m(v/S)^2.
$$

有限检查恰为以下三个有理数不等式：

$$
S>\mathcal E_{100}(b_m-A+1/1000),\quad
\mathcal E_{100}(b_m)<3S,\quad
\frac{(b_m-m)S}{b_m v}<\frac45.
\tag{7.21}
$$

其中两个指数上界的自变量均为正且小于 102。第一个不等式推出 $A-b_m+\log S>1/1000$，第二个推出 $e^{-b_m}S>1/3$。因此 (7.21) 蕴含 (7.20)，无需浮点运算、数值对数或区间采样。全部 48 条有理数比较均已通过。

与大阈值情形相同，由 $R_m$ 的唯一性得 $b_m>R_m$；再由 $q_m$ 和 $y_m$ 的单调性，得到 $m=1,\ldots,16$ 时的 (7.1)—(7.2)。本节命题得证。

## 8. 精确噪声稳定性主定理的闭合

一个基本指数不等式完成右半区证书。对 $0\le L\le\log3$，有
$$
e^L(3-L)-3-2L-\frac{L^2}{3}\ge\frac{13}{375}L^2.
\tag{8.1}
$$
事实上，$\log3<6/5$，因为
$$
e^{6/5}\ge1+\frac65+\frac{18}{25}+\frac{36}{125}
=\frac{401}{125}>3.
$$
将 $e^L$ 的四次 Taylor 下界乘以 $3-L>0$，得
$$
\begin{aligned}
e^L(3-L)-3-2L-\frac{L^2}{3}
&\ge\frac{L^2}{24}(4-L^2-L^3)\\
&\ge\frac{L^2}{24}\left(4-\frac{36}{25}-\frac{216}{125}\right)
=\frac{13}{375}L^2.
\end{aligned}
$$

假设 $F_m(r)\le0$，由第 4 节等价于 $r\le R_m$。当 $r\le m$ 时，第 6 节已证明三次证书。当 $m\le r\le R_m$ 时，第 7 节给出 $0<L<\log3$、$A\le L$，以及
$$
B=\frac12y_m(r)^2A^2<\frac8{25}A^2
\le\frac8{25}L^2<\frac13L^2.
$$
结合 (8.1)，得到
$$
2A+B<2L+\frac13L^2<e^L(3-L)-3.
$$
因此，由定理 3.1，$p_m(r,a)\le q_m(r)^{2-a}$ 在整个 $[0,1]$ 上成立。

反过来，若目标不等式成立，由 $a=0$ 处取等号及第 3 节的右导数比较，必有 $A\le L$。这证明了定理 2.1 的三个命题等价。两个区域中 (3.3) 的第二个不等式都严格成立，所以 (3.6) 中仿射括号在 0 处非负，在 1 处严格为正，进而在 $(0,1)$ 内严格为正。因此每个内点 $a$ 都有 $H_L(a)-P(a)>0$，证明了主定理的严格性。

若 $r>R_m$，函数 $p_m(r,a)/q^2-e^{La}$ 在 0 处为零，且导数 $A-L$ 严格为正。因此它对每个充分小的正 $a$ 都为正，证明了临界强度之外的精确失效结论。窗口包含及显式上界已经分别在第 5、7 节证明；下面完成渐近分析。

## 9. 临界边界的正态尺度位置

令 $Q(c)=\Phi(-c)$、$\lambda(c)=\phi(c)/Q(c)$、$H(c)=\lambda(c)^2+\log Q(c)$。先证明 $H$ 恰有一个正零点，而不是根据前述小数值推断这一事实。

正态风险率满足

$$
\lambda'=\lambda(\lambda-c),\qquad
H'=\lambda\{2\lambda(\lambda-c)-1\}.
$$

记 $G_N(c)=2\lambda(c)(\lambda(c)-c)-1$。有 $G_N(0)=4/\pi-1>0$。在任意正零点 $c$ 处，

$$
\lambda'=\frac12,\quad
(\lambda-c)'=-\frac12,\quad
G_N'=(\lambda-c)-\lambda=-c<0.
\tag{9.1}
$$

对高斯尾积分分部积分，得到 $c\to\infty$ 时

$$
\frac{Q(c)}{\phi(c)}=\frac1c-\frac1{c^3}+O(c^{-5}),\quad
\lambda(c)=c+\frac1c+O(c^{-3}).
\tag{9.2}
$$

为说明余项，第一式的两项展开之后恰为 $3\phi(c)^{-1}\int_c^\infty t^{-4}\phi(t)\,dt$，它介于 0 与 $3c^{-5}$ 之间。因此 $G_N(c)\to1>0$。由 (9.1)，所有可能的正零点导数均为负；应用第 4 节相同的首次返回论证可排除所有这类零点。故 $H'>0$ 在 $[0,\infty)$ 上成立。

此外，

$$
H(0)=\frac2\pi-\log2<0,
\qquad
H(c)=\frac{c^2}{2}-\log c+2-\frac12\log(2\pi)+O(c^{-2})\to\infty.
$$

第一个严格不等式由 $\pi>25/8$ 及 $\log2>693/1000$ 已可推出。因此唯一正零点 $c_*$ 存在。

现固定任意实数 $c$，取 $r_m=m+c\sqrt m$，它对充分大的 $m$ 为正。泊松中心极限定理给出

$$
q_m(r_m)\longrightarrow\Phi(-c).
\tag{9.3}
$$

一个直接推导是考察标准化泊松变量的特征函数，其对数满足 $r(e^{it/\sqrt r}-1-it/\sqrt r)\to-t^2/2$。标准化截断点 $(m-r_m)/\sqrt{r_m}$ 收敛到 $-c$，而该点是极限正态分布的连续点。Stirling 公式给出所需的点概率极限：

$$
\begin{split}
\log\bigl(\sqrt{r_m}u_m(r_m)\bigr)
 &=\frac12\log\frac{r_m}{m}-\frac12\log(2\pi)
   -(r_m-m)+m\log\frac{r_m}{m}+o(1)\\
 &\longrightarrow-\frac{c^2}{2}-\frac12\log(2\pi).
\end{split}
$$

因此

$$
F_m(m+c\sqrt m)\longrightarrow H(c).
\tag{9.4}
$$

对任意 $0<\varepsilon<c_*$，$H$ 的严格单调性给出 $H(c_*-\varepsilon)<0<H(c_*+\varepsilon)$。由 (9.4)，当 $m$ 充分大时，相应 $F_m$ 值也分别具有这两个符号。由第 4 节的唯一根性质，

$$
m+(c_*-\varepsilon)\sqrt m<R_m<
m+(c_*+\varepsilon)\sqrt m.
$$

令 $\varepsilon\downarrow0$，便得到所述首阶渐近式。

## 10. 应用与结论边界

将 (2.4) 中公共的指数因子消去，由定理 2.1 得
$$
\sum_{b=0}^m\frac{(ar)^b}{b!}E_{m-b}((1-a)r)^2
\le E_m(r)^{2-a}
\tag{10.1}
$$
它对每个整数 $m\ge1$、每个 $r\in[m,m+1]$ 及每个 $a\in[0,1]$ 成立。取 $m=t-1$，即覆盖 [HMR, 附录 D, 第 55—56 页] 明确下尾重叠不等式所需的强度窗口 $[t-1,t]$。主定理进一步给出了全部强度成立域，不限于这一应用窗口。

本文不将 (10.1) 等同于 [HMR, v1, 猜想 1.2] 关于最大值位置的字面表述。该版本所展示的一阶矩表达式的端点行为需要单独核对；这里的应用主张仅针对已核的附录 D 显式不等式。若要进一步转移为恢复定理，还须检查原证明中的其余模型假设及关于重叠量的一致估计。

主定理没有证明任意泊松事件的对应界，也没有给出最优群测算法或任意设计的容量。[CO] 的空间耦合算法已达到所述基准。同样，定理 3.1 对全体非负序列类的充要条件，不应被解释为其第二个标量条件对某个具体泊松谱也必要。具体泊松谱的完整刻画是定理 2.1，其判据只有 $A\le L$。

本文只证明正态尺度的首阶渐近，不主张二阶常数。数值计算及探索性搜索与精确证书严格区分，不作为主定理的逻辑输入。

## 11. 复现、算术验证与证明状态

书面证明包含三项有限验证义务：第 5 节 25 次多项式的 26 条 Bernstein 系数不等式，第 7 节 30 次多项式的 31 条 Bernstein 系数不等式，以及 $m=1,\ldots,16$ 的 48 条有理数端点比较。其多项式定义、基转换公式、验证区间及严格正下界均已在正文给出。完整有理系数表未随本版本公开，可依据正文给出的多项式及基转换公式重算。

程序使用 `fractions.Fraction`、整数阶乘和二项式系数、精确多项式乘法及精确比较，不使用浮点运算、数值对数、随机测试或区间采样。第二个脚本从第一个脚本导入多项式辅助函数。原稿报告两项精确检查均通过；本版本未附程序及运行输出。这些有限检查证明的是所列有理数不等式；其概率论意义依赖第 5、7 节给出的解析化归。

有限阈值证明中引入的非初等不等式只有 Ramanujan 序列界 [BRS] 和 Robbins 阶乘界 [R]。第 9 节使用标准正态极限，并提供特征函数推导及高斯尾积分的显式余项。

本文尚无外部同行评议。精确算术检查不能替代对解析证明的审查，也不表示全文已完成 Lean 形式化；全文形式化尚未完成。

## 12. 参考文献

**[HMR]** Remco van der Hofstad, Noela Müller, Connor Riddlesden. *An Information-Theoretic Analysis of Threshold Group Testing*. arXiv:2606.11353。实际核对的全文为 2026 年 6 月 9 日 v1，重点为第 31—33 页引理 4.7 与第 55—56 页附录 D。正式记录：https://arxiv.org/abs/2606.11353 。已读作者稿镜像：https://www.researchgate.net/publication/406910283_An_Information-Theoretic_Analysis_of_Threshold_Group_Testing 。v3 记录 https://arxiv.org/abs/2606.11353v3 仅核对了元数据，未取得完整正文。

**[CO]** Amin Coja-Oghlan, Remco van der Hofstad, Lena Krieg, Noela Müller, Connor Riddlesden, Olga Scheftelowitsch. *Algorithms for Threshold Group Testing*. arXiv:2606.27127，2026。定理 1.1 及相关比较针对空间耦合设计。https://arxiv.org/abs/2606.27127 。已核作者文本镜像：https://www.researchgate.net/publication/408106488_Algorithms_for_Threshold_Group_Testing 。

**[TMS]** Trung-Khang Tran, Daniel McMorrow, Jonathan Scarlett. *Group Testing with Selectable Thresholds*. arXiv:2607.14448v1，2026 年 7 月 16 日，重点为 §1.2。https://arxiv.org/abs/2607.14448 。已核全文呈现：https://academ.us/article/2607.14448/ 。

**[NPY]** Ivan Nourdin, Giovanni Peccati, Xiaochuan Yang. *Restricted hypercontractivity on the Poisson space*. Proceedings of the American Mathematical Society 148(8) (2020), 3617–3632。所核作者稿第 4 页定理 1.4。https://doi.org/10.1090/proc/14964 ；https://arxiv.org/abs/1904.08211 ；https://arxiv.org/pdf/1904.08211 。

**[BRS]** Andrew Bakan, Stephan Ruscheweyh, Luis Salinas. *More Properties of the Ramanujan Sequence*. arXiv:1605.05479v3。第 1 页定义 (1.1) 与界 (1.3)，第 2 页式 (2.2)，其证明位于 §4；这些结果推出本文所用的 $1/3\le\theta_n\le1/3+4/(135n)$。https://arxiv.org/abs/1605.05479v3 ；https://arxiv.org/pdf/1605.05479v3 。

**[R]** Herbert Robbins. *A Remark on Stirling's Formula*. American Mathematical Monthly 62(1) (1955), 26–29，式 (1)—(2)。已核全文镜像：https://heuklyd.github.io/papers/pdf/Robbins-1955.pdf 。
