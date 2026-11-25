# 任意类别数随机响应的精确 zCDP：全局相变、唯一最优阶与锐渐近

AI 辅助研究稿

2026 年 11 月 24 日

## 摘要

本文研究标准 k 元随机响应机制的最小零集中差分隐私参数。Harrison 与 Manurangsi 在 FORC 2026 给出了 k 不超过 6 时的精确值，给出一个使 KL 端点失效的阈值，并将较大 k 的精确刻画列为开放问题。我们把全 Rényi 阶优化转化为平方变量上的割线斜率，证明原阈值也是端点最优的充分条件；阈值另一侧存在唯一内部全局最优阶，并给出显式有限区间中的唯一根刻画。对固定正隐私参数 epsilon，还证明最小预算渐近为 epsilon 平方除以 4 log k，附更精确的误差项。高隐私极限与既有三点分布最优次高斯方差代理的关系单独说明，不作为新发现。一般结果由解析证明支持，有限例子另有纯有理数区间证书；本文没有声称外部同行评议或完整 Lean 认证。

## 1. 问题、意义与已有结果

### 1.1 通俗说明

随机响应是一种带有刻意随机性的报告规则。真实类别共有 $k$ 种，机制以较高概率报告真实类别，以相同的较低概率报告其他类别。隐私参数 $\varepsilon$ 决定这两种概率的比值。本文不改变这个机制，而是求它在 zCDP 框架下恰好需要多少隐私预算。

zCDP 用一个数 $\rho$ 同时控制所有 Rényi 阶 $\alpha>1$ 的信息区分程度。精确预算必须覆盖这些阶中的最坏者。困难在于：类别数较小时，最坏者位于 $\alpha\downarrow1$ 的极限；类别数较大时，它会移动到内部。单独检查 KL 散度，或者在若干预选阶上扫点，都不能证明已经找到全局最坏者。

本文给出这两种情形的完整分界，并证明内部最坏阶唯一。这使原先的无界连续优化变成一个有证明保障的有限区间求根问题。内部结果是精确隐式刻画，不是声称所有参数都有初等闭式解。

### 1.2 模型与归属

设整数 $k\ge2$，$\varepsilon\ge0$。标准 $k$ 元随机响应 $M_{k,\varepsilon}$ 的输出规则为

$$
\Pr(M_{k,\varepsilon}(i)=j)=
\begin{cases}
\dfrac{e^\varepsilon}{e^\varepsilon+k-1},&j=i,\\[4pt]
\dfrac1{e^\varepsilon+k-1},&j\ne i.
\end{cases}
$$

不同输入类别视为相邻。记其输出分布为 $P_i$。对 $\alpha>1$，

$$
D_\alpha(P\Vert Q)=\frac1{\alpha-1}
\log\sum_y P(y)^\alpha Q(y)^{1-\alpha}.
$$

最小 zCDP 参数是

$$
\rho_k(\varepsilon)=\sup_{\alpha>1}
\frac{D_\alpha(P_i\Vert P_j)}\alpha,\qquad i\ne j.
\tag{1}
$$

由对称性，右侧与不同类别的选择无关。本文所有对数均为自然对数。

Harrison 与 Manurangsi 的出版版本 [HM26] 已经给出精确 RDP 曲线（命题 20）、$2\le k\le6$ 的精确 zCDP 值（定理 16）、端点失效的单向阈值（引理 17）以及较大 $k$ 的非紧上界（推论 18、定理 19）。其第 5 节和第 7 节明确留下较大 $k$ 的精确刻画问题。**这些已有公式及阈值表达式的归属保持不变。** 本文的贡献是该阈值的充分性、全参数全局最优阶的唯一性、有限求根区间及锐渐近常数。

本文不研究所有隐私信道中的最优机制设计，也不声称一般异质机制的合成预算等于各自最小预算之和。

## 2. 主要结论

$\varepsilon=0$ 时，机制输出与输入无关，故 $\rho_k(0)=0$。此时所有阶的目标值均为零，没有唯一最优阶。下文一律假设 $\varepsilon>0$，并定义

$$
a=\frac\varepsilon2,\qquad
c=\frac{k-2}{2e^a},\qquad
C(t)=\frac{\sinh t\cosh t-t}{t\cosh t-\sinh t}\quad(t>0).
\tag{2}
$$

**定理 1（完整参数刻画）。** 对每个整数 $k\ge2$ 和每个 $\varepsilon>0$，恰有下列一种情形成立。

1. 若 $c\le C(a)$，则 $D_\alpha/\alpha$ 在 $\alpha>1$ 上严格递减，而且

   $$
   \rho_k(\varepsilon)
   =\frac{\varepsilon(e^\varepsilon-1)}{e^\varepsilon+k-1}.
   \tag{3}
   $$

   上确界在 $\alpha\downarrow1$ 时趋近。等号 $c=C(a)$ 也属于此情形；任何 $\alpha>1$ 都达不到端点值。

2. 若 $c>C(a)$，则存在唯一 $t_\star>a$ 满足

   $$
   (t_\star^2-a^2)\frac{\sinh t_\star}{c+\cosh t_\star}
   =2t_\star\log\frac{c+\cosh t_\star}{c+\cosh a}.
   \tag{4}
   $$

   唯一最优 Rényi 阶及精确预算为

   $$
   \alpha_\star=\frac12+\frac{t_\star}{\varepsilon},
   \qquad
   \rho_k(\varepsilon)
   =\frac{\varepsilon^2\sinh t_\star}
          {2t_\star(c+\cosh t_\star)}.
   \tag{5}
   $$

   目标在 $(1,\alpha_\star)$ 上严格增加，在 $(\alpha_\star,\infty)$ 上严格减少；其最大值严格大于式 (3)。

第一种情形等价于

$$
k\le K(\varepsilon):=2+2e^aC(a)
=\frac{2(e^\varepsilon-1)(e^\varepsilon-1-\varepsilon)}
       {\varepsilon(e^\varepsilon+1)-2e^\varepsilon+2}.
\tag{6}
$$

式 (6) 就是 [HM26] 引理 17 已有的阈值。新增内容是“当且仅当”及阈值另一侧的全局唯一刻画。

**推论 1（隐私参数的唯一相变）。** $K$ 在 $(0,\infty)$ 上连续严格增加，且

$$
K(0+)=6,\qquad K(+\infty)=+\infty.
$$

因此，每个整数 $k\ge7$ 都有唯一正数 $\varepsilon_c(k)$ 满足 $K(\varepsilon_c(k))=k$。内部最优发生在 $0<\varepsilon<\varepsilon_c(k)$，端点最优发生在 $\varepsilon\ge\varepsilon_c(k)$。对 $2\le k\le6$，任意正 $\varepsilon$ 均为端点最优。

## 3. 从 Rényi 曲线到割线斜率

不同输入的输出分布只在两个坐标上交换概率。直接计算得到 [HM26, 命题 20]

$$
D_\alpha
=\frac1{\alpha-1}
\log\frac{e^{\alpha\varepsilon}+e^{(1-\alpha)\varepsilon}+k-2}
              {e^\varepsilon+k-1}.
\tag{7}
$$

令 $t=\varepsilon(\alpha-1/2)>a$，并令

$$
F_c(x)=\log(c+\cosh\sqrt{x}),\qquad
N(t)=\log\frac{c+\cosh t}{c+\cosh a}.
$$

因为

$$
e^{\alpha\varepsilon}+e^{(1-\alpha)\varepsilon}+k-2
=2e^a(c+\cosh t),
$$

且 $\varepsilon^2\alpha(\alpha-1)=t^2-a^2$，故

$$
\rho_k(\varepsilon)
=\varepsilon^2\sup_{t>a}\frac{N(t)}{t^2-a^2}
=\varepsilon^2\sup_{x>a^2}
  \frac{F_c(x)-F_c(a^2)}{x-a^2}.
\tag{8}
$$

这一步没有放宽任何参数，也没有把上确界换成有限网格。目标恰好是从固定点 $a^2$ 出发的割线斜率。关键是平方变量 $x=t^2$：在这个变量中，曲率只会由正转负一次。

## 4. 曲率结构与全局最优性的证明

### 4.1 阈值函数严格增加

记

$$
A(t)=\sinh t\cosh t-t,\qquad
B(t)=t\cosh t-\sinh t,
$$

则 $C=A/B$。

**引理 1。** 对 $t>0$，$B(t)>0$；$C$ 严格增加，且 $C(0+)=2$、$C(+\infty)=+\infty$。

**证明。** $B(0)=0$，$B'(t)=t\sinh t>0$，所以 $B$ 为正。另一方面，

$$
A'(t)=2\sinh^2t,\qquad
\frac{A'(t)}{B'(t)}=\frac{2\sinh t}{t}=:h(t),
$$

而 $h'(t)=2B(t)/t^2>0$。用从零开始的积分表示 $A,B$，有

$$
C(t)=\frac{\int_0^t h(u)u\sinh u\,du}
           {\int_0^t u\sinh u\,du}<h(t).
$$

不等式严格，是因为权在 $(0,t)$ 上为正，且 $h$ 严格增加。因此

$$
C'(t)=\frac{B'(t)}{B(t)}\bigl(h(t)-C(t)\bigr)>0.
$$

由加权平均式及 $h(0+)=2$ 得到第一极限。由双曲函数的指数形式，

$$
C(t)\sim\frac{e^t}{2(t-1)}\longrightarrow\infty.
$$

证毕。

### 4.2 唯一曲率转折

**引理 2。** 写 $x=t^2$，直接微分有

$$
F_c'(x)=\frac{\sinh t}{2t(c+\cosh t)},
$$

$$
\begin{aligned}
F_c''(x)
&=\frac{t(1+c\cosh t)-\sinh t(c+\cosh t)}
        {4t^3(c+\cosh t)^2}\\
&=\frac{B(t)(c-C(t))}{4t^3(c+\cosh t)^2}.
\end{aligned}
\tag{9}
$$

**证明。** 对第一式微分，并用 $\cosh^2t-\sinh^2t=1$ 整理即得第二式。引理 1 说明全部分母和 $B(t)$ 均为正。因此，$c\le2$ 时处处严格凹；$c>2$ 时，存在唯一 $\tau>0$ 满足 $C(\tau)=c$，函数在 $(0,\tau^2)$ 上严格凸，在 $(\tau^2,\infty)$ 上严格凹。证毕。

### 4.3 割线最大值唯一

令 $x_0=a^2$，并定义

$$
Q(x)=\frac{F_c(x)-F_c(x_0)}{x-x_0},\qquad
P(x)=(x-x_0)F_c'(x)-F_c(x)+F_c(x_0).
$$

它们在 $x_0$ 连续延拓为 $Q(x_0)=F_c'(x_0)$ 和 $P(x_0)=0$，且

$$
Q'(x)=\frac{P(x)}{(x-x_0)^2},\qquad
P'(x)=(x-x_0)F_c''(x).
\tag{10}
$$

若 $c\le C(a)$，则 $x>x_0$ 时 $C(\sqrt{x})>C(a)\ge c$，所以 $F_c''(x)<0$。式 (10) 说明 $P$ 从零严格下降，$Q'<0$。于是上确界为 $F_c'(a^2)$，代入式 (8) 即得式 (3)。这同时处理了临界等号。

若 $c>C(a)$，则引理 2 的 $\tau$ 满足 $\tau>a$。$P$ 先从零严格增加至 $P(\tau^2)>0$，随后严格减少。固定 $c$，当 $x\to\infty$ 时，

$$
F_c(x)=\sqrt{x}-\log2+o(1),\qquad
F_c'(x)=\frac{1+o(1)}{2\sqrt{x}}.
$$

所以

$$
P(x)=-\frac{\sqrt{x}}2+o(\sqrt{x})\longrightarrow-\infty.
$$

连续性与严格单调性表明，$P$ 在 $\tau^2$ 之后恰好有一个零点。式 (10) 因而给出 $Q$ 的先增后减，且最大值唯一。将该零点记为 $t_\star^2$，$P(t_\star^2)=0$ 恰好就是式 (4)，并且 $Q(t_\star^2)=F_c'(t_\star^2)$ 给出式 (5)。定理 1 得证。

式 (6) 的分母等于 $4e^aB(a)>0$。将双曲函数写成指数形式，或者使用

$$
2B(a)+2e^aA(a)=2\sinh a\,(e^a\sinh a-a),
$$

即可核对两个阈值表达式完全相同。最后，$K=2+2e^aC(a)$ 以及引理 1 证明推论 1。

## 5. 显式有限区间与严格求值

定义

$$
b=\log[2(c+\cosh a)]
 =\log(e^\varepsilon+k-1)-a,
\qquad T=b+\sqrt{b^2-a^2}.
\tag{11}
$$

因为 $2(c+\cosh a)\ge2\cosh a>e^a$，故 $b>a$，上述平方根有意义。令

$$
H(t)=(t^2-a^2)N'(t)-2tN(t)=2tP(t^2).
$$

再令

$$
r(t)=\log(1+2ce^{-t}+e^{-2t})>0.
$$

则 $r'(t)<0$，并且

$$
N(t)=t-b+r(t),
$$

$$
H(t)=-t^2+2bt-a^2+(t^2-a^2)r'(t)-2tr(t).
\tag{12}
$$

在 $t=T$，前面的二次多项式恰为零，后两项严格为负。因此 $H(T)<0$。

**定理 2（有限求根区间）。** 内部情形满足

$$
a<\tau<t_\star<T.
$$

从 $[a,T]$ 开始二分：中点 $m$ 若有 $H(m)>0$，提高下端点；若 $H(m)<0$，降低上端点；若恰为零，则得到根。进行 $n$ 轮后，区间长度为 $(T-a)/2^n$。这由定理 1 证明的唯一符号变化直接推出；虽然 $H(a)=0$，它只是可去的端点根，二分中点始终大于当前下端点，不会把它误认为内部最优点。

**数值证据的边界。** 高精度浮点求根给出近似值。需要严格包围时，阈值和 $H$ 的符号必须用外向取整区间证明；区间含零时应提高精度，而不能按浮点符号猜测。对于任意黑盒实数输入，算法不能保证在有限时间判定恰好位于超越方程的等号边界；定理的等号情形是解析结论。

当已得到严格根区间 $[L,U]$，且 $C(L)>c$，则 $F_c'$ 在该区间对应的平方变量上严格递减，故

$$
\frac{\varepsilon^2\sinh U}{2U(c+\cosh U)}
\le\rho_k(\varepsilon)\le
\frac{\varepsilon^2\sinh L}{2L(c+\cosh L)}.
\tag{13}
$$

附带的纯有理数程序用显式指数级数与对数级数尾界，实现若干指定有理参数的式 (13) 证书。它没有将有限测试冒充一般定理。

## 6. 大类别数的锐渐近

本节固定 $\varepsilon>0$，令整数 $k\to\infty$；大 $O$ 常数允许依赖 $\varepsilon$。

**定理 3。** 用式 (11) 定义 $b,T$，则

$$
t_\star=T+O_\varepsilon\!\left(\frac{\log k}{k}\right),
\qquad t_\star<T,
\tag{14}
$$

$$
0<\rho_k(\varepsilon)-\frac{\varepsilon^2}{2T}
=O_\varepsilon\!\left(\frac1{k(\log k)^2}\right).
\tag{15}
$$

特别地，

$$
\rho_k(\varepsilon)\sim\frac{\varepsilon^2}{4\log k},
\qquad \alpha_\star\sim\frac{2\log k}{\varepsilon}.
\tag{16}
$$

**证明。** $c$ 与 $k$ 同阶，$b=\log k-a+O(1/k)$，$T=2b+O(1/b)$。由 $r$ 的定义，在整个 $[T-1,T]$ 上一致有

$$
r(t)=O(1/c),\qquad |r'(t)|=O(1/c).
$$

这是因为 $2ce^{-T}=O(1/c)$，$e^{-2T}=O(1/c^4)$。令 $H_0(t)=-t^2+2bt-a^2$，则

$$
H_0(T-1)=2\sqrt{b^2-a^2}-1\sim2b.
$$

而式 (12) 的余项在该区间上一致为 $O(b^2/c)=o(b)$，所以充分大的 $k$ 满足 $H(T-1)>0$。由根的唯一性，$t_\star\in(T-1,T)$。

在根处，$H_0(t_\star)=O(b^2/c)$。因

$$
H_0(t)=(T-t)\left(t-\frac{a^2}{T}\right),
$$

而第二因子在 $(T-1,T)$ 上与 $b$ 同阶，故 $T-t_\star=O(b/c)$，得到式 (14)。

定义 $q_0(t)=(t-b)/(t^2-a^2)$。其导数的分子为 $H_0$；该二次式的较小根为 $a^2/T<a$。所以 $q_0$ 在 $(a,\infty)$ 上的唯一全局最大值是 $q_0(T)=1/(2T)$。同时

$$
\frac{N(t)}{t^2-a^2}=q_0(t)+\frac{r(t)}{t^2-a^2}.
$$

在 $T$ 处求值，因 $r(T)>0$，最大值严格大于 $1/(2T)$；在 $t_\star\in(T-1,T)$ 处求值，则不超过

$$
\frac1{2T}+O\!\left(\frac1{cb^2}\right).
$$

乘以 $\varepsilon^2$ 得式 (15)，再用 $T\sim2\log k$ 得式 (16)。证毕。

[HM26] 已有 $O(\varepsilon^2/\log k)$ 的非紧上界。这里确定了精确首项常数 $1/4$，并给出误差受控的更精细近似。它并不意味着此前无法数值计算原 RDP 公式；新增的是对全局最优点与锐渐近的证明。

## 7. 既有三点分布极限及共同质量推广

### 7.1 高隐私极限的正确归属

固定整数 $k>6$，令 $c_0=(k-2)/2$。当 $\varepsilon\downarrow0$，式 (8) 的锚点趋于零，极限目标为

$$
q_k(t)=\frac1{t^2}\log\frac{c_0+\cosh t}{c_0+1}.
$$

同一曲率论证在锚点零的连续延拓下给出唯一正最大点 $t_k$；其驻点方程为

$$
\frac{t_k\sinh t_k}{c_0+\cosh t_k}
=2\log\frac{c_0+\cosh t_k}{c_0+1}.
$$

对极限根两侧各取一点，$H$ 在正紧区间上的连续收敛保持这两点的相反符号，因此唯一有限参数根被夹在它们之间。令两点趋近 $t_k$ 得

$$
t_\star\to t_k,\quad
\varepsilon\alpha_\star\to t_k,\quad
\frac{\rho_k(\varepsilon)}{\varepsilon^2}\to q_k(t_k)>\frac1k.
$$

若 $X$ 在 $-1,0,1$ 上的概率为 $1/k,(k-2)/k,1/k$，其矩母函数就是 $(c_0+\cosh t)/(c_0+1)$。因此 $2q_k(t_k)$ 正是这一对称三点分布的最优次高斯方差代理。[AMA25] 已研究这个问题，包括 $p=1/6$ 的相变。这里将它作为极限联系与一致性核对，**不把该极限问题当作新的开放题解答**。

有限 $\varepsilon$ 的问题不同。设 $Z_c(t)=c+\cosh t$，对指数倾斜三点分布记 $G(\lambda)=\log Z_c(a+\lambda)-\log Z_c(a)$、$\mu=G'(0)$。标准最优中心化方差代理的一半为

$$
\sup_{\lambda\ne0}\frac{G(\lambda)-\mu\lambda}{\lambda^2},
$$

而本文优化的是

$$
\sup_{\lambda>0}\frac{G(\lambda)}{\lambda(\lambda+2a)}.
$$

中心化项、分母及优化区间均不同，已有方差代理结果不能未经额外证明就替代本文有限锚点定理。

### 7.2 两项交换加共同质量

设分布对 $P,Q$ 在两个特殊输出上的概率分别为 $(p,q)$ 和 $(q,p)$，其中 $p>q>0$，其余输出逐项相同，总共同质量为 $r=1-p-q\ge0$。令 $\varepsilon=\log(p/q)$、$a=\varepsilon/2$、$c=r/(2\sqrt{pq})$。因为

$$
1=2\sqrt{pq}(c+\cosh a),
$$

其 Rényi 求和式恰为

$$
p^\alpha q^{1-\alpha}+q^\alpha p^{1-\alpha}+r
=\frac{c+\cosh(\varepsilon(\alpha-1/2))}{c+\cosh a}.
$$

因此定理 1 和定理 2 的曲率判据、内部唯一根与有限区间适用；此分布对的端点值为 $\varepsilon(p-q)$。写 $w=p+q$，端点条件等价于

$$
w\ge\frac{\cosh a}{\cosh a+C(a)}.
$$

这里讨论的是所述分布对；若一个机制还包含其他相邻输入对，必须另外对所有对取最大值。共同输出的身份需可观测且与两个特殊输出不重叠；把隐藏混合机制直接当作此模型并不成立。标准 $k$ 元随机响应是其中的特例。

## 8. 可复现验证与解释

计算材料分为三种用途。高精度主实现依据有限区间定理二分求根；独立实现从原始概率向量重新计算 Rényi 散度；纯有理数实现以外向区间算术证明选定参数的符号和包围。这三者的结果不能互相冒充。

下表给出若干近似值；$\alpha_\star=1$ 表示连续延拓的端点最优，原定义中以 $\alpha\downarrow1$ 实现上确界。

| $k$ | $\varepsilon$ | 最优阶 $\alpha_\star$ | 精确刻画的 $\rho$ 近似 | KL 端点值近似 |
|---:|---:|---:|---:|---:|
| 7 | 0.1 | 16.863706959 | 0.001496918480 | 0.001480202507 |
| 7 | 0.5 | 1 | 0.042407171587 | 0.042407171587 |
| 10 | 1 | 2.186743926 | 0.148132973355 | 0.146632574093 |
| 100 | 1 | 8.521666745 | 0.061138212223 | 0.016892556555 |
| 1000 | 1 | 13.274110058 | 0.039074657904 | 0.001715334401 |

例如，$k=100,\varepsilon=1$ 时，KL 值约为 $0.01689$，不足以构成有效 zCDP 预算；真实最小值约为 $0.06114$。反过来，已有一般上界可能高估所需预算。全局定理同时排除了这两个方向的误判。

纯有理证书严格给出

$$
\begin{aligned}
0.436747543470&<\varepsilon_c(7)<0.436747543471,\\
8.021666745077&<t_\star(100,1)<8.021666745080,\\
0.0611382122225&<\rho_{100}(1)<0.0611382122227.
\end{aligned}
$$

本版本暂未附有限计算的程序和原始输出。数值例子不承担一般量词下的证明。主实现返回近似值，不能将其末位舍入直接当作可部署的严格隐私上界；指定样本的严格证书由单独的有理区间程序提供。

## 9. 结论范围

本文在标准随机响应的原模型中完成了全部整数 $k\ge2$、全部 $\varepsilon\ge0$ 的最小 zCDP 参数刻画。内部情形以唯一根精确确定，且有显式有限区间；边界与零参数没有遗漏。关键是平方变量上的一次曲率转折，它把局部阈值提升为全局分类。

本文是 AI 辅助研究稿。一般定理有完整解析证明，但没有完整 Lean 认证，也未经过外部专家或同行评议。查新结论限定于所记录的检索和原文比较，不构成全球优先权保证。日常微积分方法、[HM26] 的 RDP 曲线和阈值表达式、[AMA25] 的对称三点极限均不计入原创性声明。

## 参考文献

**[HM26]** Charlie Harrison and Pasin Manurangsi. *Exact zCDP Characterizations for Fundamental Differentially Private Mechanisms*. FORC 2026, LIPIcs 368, 3:1–3:18. DOI: [10.4230/LIPIcs.FORC.2026.3](https://doi.org/10.4230/LIPIcs.FORC.2026.3). 本文统一采用出版版的定理编号；其预印本为 [arXiv:2510.25746v1](https://arxiv.org/abs/2510.25746v1)。

**[AMA25]** Soufiane Atouani, Olivier Marchal, and Julyan Arbel. *Optimal sub-Gaussian variance proxy for 3-mass distributions*. [arXiv:2510.06132v1](https://arxiv.org/abs/2510.06132v1), 2025. 尤其参见定义 1.1、第 2 节及第 3 节。

**[Ste24]** Thomas Steinke. *Tight RDP & zCDP Bounds from Pure DP*. 27 May 2024. [作者原文](https://differentialprivacy.org/pdp-to-zcdp/)。该结果提供一般纯 DP 转换与二元随机响应紧例。
