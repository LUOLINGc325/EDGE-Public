# 所有纯纠缠态的三组投影测量排除优势

*奇数维测量排除开放问题的构造性解答*

2026-11-24

## 通俗摘要

设一个装置会从事先知道的三种量子测量中选一种，只告诉我们测量结果，而不交还被测的量子系统。我们希望根据这个结果，以及自己保留的量子记忆，指出一种“肯定没有被使用”的测量。这项任务称为测量排除，也称反辨别。

本文证明：对任意给定的有限维双体纯纠缠态，都能设计三组投影测量，使该纠缠态完成上述排除任务而不出错；同一组测量下，任何可分态探针都必须承受严格为正的错误率。同时，使用这个给定的纠缠态，仍不能总是准确指出装置实际使用了哪一种测量。构造覆盖所有 Schmidt 秩，因而也覆盖原研究留下的奇数维情形。

这里的“不能准确辨别”只针对所指定的输入态。本文不声称其他纠缠态也不能辨别这些测量，也不声称所有混合纠缠态都具有同样的完美排除能力。

## 摘要

我们研究对一个未知的、有标签的秩一投影测量进行单次查询的任务。装置只返回经典测量结果，其测后量子系统不可访问。对任意有限维双体纯纠缠态，我们构造三个这样的测量，使指定的输入态能够完美排除它们，而所有可分态探针，即使带有任意有限维记忆，也具有严格为正的排除错误率。同一指定纠缠态不能完美辨别这些测量：在每一个可能出现的经典结果下，均有两个条件记忆态非正交。

构造覆盖全部 Schmidt 秩，包括奇数秩，从而回答 Manna 在这一协议中留下的奇数维问题。对 Schmidt 秩至少为三的情形，构造将 Fourier 插值代入一个显式单位根。域扩张次数论证保证三组测量基的每一种横截选取都可逆；另一个解析估计则给出显式的排除 POVM。我们还给出最优可分态错误率的精确有限表达式、一个保守的代数下界，以及附有可复现证书的有理数实例。

本文是AI 辅助研究稿，尚未经过外部同行评议，也没有端到端的 Lean 验证。

## 1. 任务与精确结论

标签 $x\in\{0,1,2\}$ 以先验概率 $\pi_x>0$ 选取一个作用在 $d$ 维系统 $A$ 上的投影测量，其中 $\sum_x\pi_x=1$：
$$
\mathcal M_x=\{P_{a|x}=|b_{a|x}\rangle\langle b_{a|x}|:0\le a<d\}.
$$
每个矩阵 $B_x=[b_{0|x},\ldots,b_{d-1|x}]$ 都是酉矩阵。相应量子通道只输出经典结果：
$$
\mathcal C_x(\rho)=\sum_a\operatorname{tr}(\rho P_{a|x})|a\rangle\langle a|.
$$
输入可以是 $A\otimes B$ 上的态，并保留系统 $B$ 作为记忆。收到结果 $a$ 后，观察者在 $B$ 上选择一个三结果 POVM $\{N_{y|a}\}_{y=0}^2$。输出 $y$ 表示断言 $x\ne y$；错误事件是 $y=x$。协议没有“无法判断”的额外输出，也不丢弃任何分支。

Manna [1，第 III—V 节] 给出了偶数维构造，并明确留下奇数维推广问题。本文能够使用的信息，恰好是该文协议中的经典测量结果与保留记忆。是否还能取得被测系统，会实质改变任务 [2]。

**定理 1。** 设 $|\Psi\rangle\in\mathcal H_A\otimes\mathcal H_B$ 是 Schmidt 秩为 $r\ge2$ 的纯态，两个 Hilbert 空间均为有限维。存在三个定义在整个 $\mathcal H_A$ 上的、有标签的秩一投影测量，满足：

1. 指定输入 $|\Psi\rangle$ 的排除错误率为零。对每个正概率的经典结果，所构造的解码器都会以正条件概率输出两个不同于真实测量的标签中的每一个。
2. 对任意严格为正的先验，遍历所有可分输入与所有解码器后得到的排除错误率下确界仍严格为正。该结论允许任意有限维记忆与经典相关。
3. 使用同一个指定输入时，不能完美辨别这三个测量。每个可能出现的经典结果下，测量 0 与测量 1 对应的条件记忆态均非正交。

第 3 项的量词仅涉及给定输入。定理没有断言其他所有纠缠输入也都不能辨别这些测量。

同时满足上述要求时，三个候选是最少的数量：如果只有两个候选，将被完美排除的标签取补，就识别出了实际使用的候选。

选取 Schmidt 坐标：
$$
|\Psi\rangle=\sum_{j=0}^{r-1}\sqrt{\lambda_j}|j\rangle_A|j\rangle_B,\qquad
\lambda_j>0,\quad \sum_j\lambda_j=1.
$$
记 $D=\operatorname{diag}(\sqrt{\lambda_j})$、$\Lambda=D^2$，以及
$\kappa=\lambda_{\max}/\lambda_{\min}$。当测量基向量 $b$ 位于 Schmidt 支撑子空间内时，相应未归一化记忆向量为
$$
w=D\overline b. \tag{1}
$$
最后通过局部坐标变换，即可将构造移回原始输入态。

## 2. 最优可分态错误率的有限判据

对决策函数 $f:\{0,\ldots,d-1\}\to\{0,1,2\}$，定义
$$
T_f=[b_{a|f(a)}]_{a=0}^{d-1},\qquad
H_f=\sum_a\pi_{f(a)}P_{a|f(a)}.
$$
称 $T_f$ 为一个横截选取：它对每个固定的经典结果标签，恰好选取一个测量基向量。

**引理 2。** 可分态探针的最优错误率恰为
$$
\epsilon_{\rm sep}=\min_f\lambda_{\min}(H_f). \tag{2}
$$
特别地，该错误率为正，当且仅当每个横截选取都可逆。

**证明。** 对系统输入 $\rho$，收到结果 $a$ 后，最优经典决策会选取使 $\pi_x\operatorname{tr}(\rho P_{a|x})$ 最小的标签。错误率因此为
$$
E(\rho)=\sum_a\min_x\pi_x\operatorname{tr}(\rho P_{a|x})
       =\min_f\operatorname{tr}(\rho H_f).
$$
再对密度矩阵求最小值，并交换两个最小化次序，就得到无辅助输入情形下的式 (2)。每个最小值均可达到。由于所有先验概率为正，矩阵
$H_f=T_f\operatorname{diag}(\pi_{f(a)})T_f^\dagger$
正定，当且仅当 $T_f$ 可逆。这样的选取只有 $3^d$ 个。

对于乘积输入 $\rho_A\otimes\tau_B$，任意记忆测量只会诱导一个经典规则
$p(y|a)=\operatorname{tr}(\tau_BN_{y|a})$。故其错误率不小于无辅助输入的最优值。对于可分混合态，任意固定解码器的错误率，都是各乘积分量错误率的加权平均；每个分量具有同一个下界。反过来，最优无辅助输入本身也是可分输入。因此二者最优值相等，并且该论证已经包含任意有限维记忆。$\square$

在均匀先验下，表达式化为
$$
\epsilon_{\rm sep}=\frac13\min_f\lambda_{\min}(T_fT_f^\dagger). \tag{3}
$$
这个有限最小值就是精确的操作量，无需将其定义为对乘积态进行数值搜索的结果。

## 3. 三个近正交态的显式解码

下面的构造是文献 [3，定理 3.2 与推论 5.4] 中 Gram 矩阵排除结构的一个自包含特例。这里使用的重叠阈值是已有结果，不作为本文的新贡献。

**引理 3。** 设 $v_0,v_1,v_2$ 是单位向量，并满足
$$
|\langle v_i,v_j\rangle|<\frac12\quad(i\ne j). \tag{4}
$$
则存在一个显式 POVM，使得 $N_iv_i=0$，且对 $j\ne i$ 有
$\langle v_j,N_iv_j\rangle=1/2$。

**证明。** 令 $V=[v_0,v_1,v_2]$、$G=V^\dagger V$。Hermitian 矩阵 $G$ 的每个对角元为一，而每行其余元素的绝对值之和小于一，因此 $G$ 正定。对每个 $i$，令 $C_i$ 的第 $i$ 行与第 $i$ 列均为零，在剩余坐标 $j,k$ 上取子块
$$
\begin{pmatrix}1/2&G_{jk}\\G_{kj}&1/2\end{pmatrix}.
$$
这些子块均正定，且 $\sum_iC_i=G$。设
$$
W=VG^{-1},\qquad P=VG^{-1}V^\dagger,\qquad
N_i=WC_iW^\dagger+\frac{I-P}{3}. \tag{5}
$$
其中 $P$ 是投影到 $V$ 的列空间的正交投影。于是每个 $N_i$ 都正半定，且总和为 $I$。又因 $W^\dagger v_j=e_j$，所述概率直接由 $C_i$ 的矩阵元给出。所有效应均非零。$\square$

进行精确算术时，可以直接使用未归一化列向量 $w_i$。此时仍令 $G=V^\dagger V$，但将每个支撑子块的两个对角元改为 $G_{jj}/2,G_{kk}/2$，非对角元仍取 $G_{jk}$。所需检验为
$$
4|G_{jk}|^2<G_{jj}G_{kk}. \tag{6}
$$
式 (5) 保持不变。每个允许输出的概率权重，都等于输入列向量范数平方的一半；归一化后，概率仍为 $1/2$。

## 4. 对所有 $r\ge3$ 的统一代数构造

令 $\omega=e^{2\pi i/r}$、$F_{aj}=r^{-1/2}\omega^{-aj}$，并定义
$$
U_x(z)=F\operatorname{diag}(z^{xj})_{j=0}^{r-1}F^\dagger,
\qquad x=0,1,2. \tag{7}
$$
当 $|z|=1$ 时，这些矩阵均为酉矩阵。它们的矩阵元是 $\mathbb Q(\omega)$ 上关于 $z$ 的多项式，次数至多为 $x(r-1)$；$F$ 中的平方根在逐项相乘时抵消。在 $z=1$ 处，三个矩阵都等于 $I$。在 $z=\omega$ 处，则有 $U_x(\omega)e_a=e_{a+x\bmod r}$。

选取任意满足下式的素数 $q$：
$$
q>\max\{2r(r-1)+1,\;80\sqrt\kappa\},
\qquad
z=\exp\!\left(\frac{2\pi i(q-1)}{rq}\right), \tag{8}
$$
并令 $b_{a|x}=U_x(z)e_a$。这样的素数总是存在。Schmidt 概率可以是任意正实数；这里不要求其为代数数。

### 4.1 代数次数排除所有奇异横截选取

对每个 $f:\{0,\ldots,r-1\}\to\{0,1,2\}$，考虑多项式
$$
p_f(Z)=\det[U_{f(a)}(Z)e_a]_{a=0}^{r-1}.
$$
它满足
$$
p_f\in\mathbb Q(\omega)[Z],\quad
\deg p_f\le (r-1)\sum_a f(a)\le2r(r-1),\quad p_f(1)=1. \tag{9}
$$
因此没有任何 $p_f$ 恒等于零。

由于 $q>r$ 为素数，故 $\gcd(q,r)=1$。选定的 $z$ 是一个 $rq$ 次单位根，且 $z^r=\zeta_q^{-1}$。于是
$$
\mathbb Q(\omega,z)=\mathbb Q(\zeta_r,\zeta_q)
                  =\mathbb Q(\zeta_{rq}).
$$
由分圆域次数公式与塔式公式，
$$
[\mathbb Q(\omega,z):\mathbb Q(\omega)]
=\frac{\varphi(rq)}{\varphi(r)}=q-1>2r(r-1). \tag{10}
$$
这个论证不要求 $z$ 本身的阶恰好等于 $rq$。式 (9)—(10) 蕴含，对所有 $f$ 均有 $p_f(z)\ne0$。引理 2 因而给出了对所有可分态探针的严格错误率间隔。

使用足够高的代数次数进行特化，包括选取单位根，已经出现在显式 full-spark 构造中 [7，推论 5.2—5.3]；其近期定量应用见 [6，定理 2.1]。本文的新应用是：在仍能进行条件态排除的邻域内，同时保证全部测量横截选取可逆。

### 4.2 同一输出下的记忆态可以完美排除

令 $S=U_1(\omega)$。通过酉对角化，并使用
$|e^{it}-e^{is}|\le|t-s|$，可得
$$
\|U_1(z)-S\|_{\rm op}\le\frac{2\pi}{q},\qquad
\|U_2(z)-S^2\|_{\rm op}\le\frac{4\pi}{q}. \tag{11}
$$
对非零向量 $u,v$，有
$$
\left\|\frac{u}{\|u\|}-\frac{v}{\|v\|}\right\|
\le \frac{2\|u-v\|}{\|v\|}. \tag{12}
$$
事实上，在左侧插入中间向量 $u/\|v\|$，再应用反三角不等式即可。

令 $v_{a,x}=D\overline{U_x(z)e_a}/\|D\overline{U_x(z)e_a}\|$。式 (11)—(12) 给出
$$
v_{a,0}=e_a,\quad
\|v_{a,1}-e_{a+1}\|\le\frac{4\pi\sqrt\kappa}{q},\quad
\|v_{a,2}-e_{a+2}\|\le\frac{8\pi\sqrt\kappa}{q}. \tag{13}
$$
对每个 $r\ge3$，这里的三个参考基向量均互不相同。将内积按每次替换一个因子的方式展开，利用单位范数和参考向量的正交性，可得
$$
|\langle v_{a,x},v_{a,y}\rangle|
\le\frac{12\pi\sqrt\kappa}{q}
<\frac{3\pi}{20}<\frac12,\qquad x\ne y. \tag{14}
$$
引理 3 为每个结果提供了解码器。由于 $\Lambda>0$，每个结果在每个假设下都有正概率。在给定经典结果及真实假设后，另外两个标签的条件输出概率各为 $1/2$。

### 4.3 指定输入仍不能完美辨别

矩阵 $U_1(z)$ 的每个对角元都等于
$$
c(z)=\frac1r\sum_{j=0}^{r-1}z^j
    =\frac{1-z^r}{r(1-z)}\ne0. \tag{15}
$$
由式 (8)，分子与分母都不为零。因此，假设 0 与假设 1 对应的未归一化条件向量满足
$$
\langle De_a,D\overline{U_1(z)e_a}\rangle
=\lambda_a\overline{c(z)}\ne0. \tag{16}
$$
这两个经典—量子输出态，在每个经典结果块中都具有非正交支撑。完美辨别两个密度矩阵要求它们的支撑正交：成功的辨别效应必须在一个支撑上等于恒等算子，在另一个支撑上等于零。式 (16) 排除了这种可能，与最终尝试哪一种 POVM 无关。

## 5. 完全显式但保守的错误率间隔

评估具体实例时，通常应使用精确表达式 (3)。下面的代数估计则不必枚举 $3^r$ 个横截选取，就能将严格正性定量化。

**命题 4。** 令 $n=\varphi(r)(q-1)$。对式 (7)—(8) 的构造，在均匀先验下有
$$
\epsilon_{\rm sep}\ge
\frac13 r^{-rn}\left(\frac{r-1}{r}\right)^{r-1}>0. \tag{17}
$$

**证明。** $rU_x(z)$ 的每个矩阵元都是域 $K=\mathbb Q(\zeta_{rq})$ 中的代数整数。因此 $\alpha=r^rp_f(z)$ 是非零代数整数，其域范数的绝对值至少为一。在 $K$ 的每个嵌入下，$\omega$ 与 $z$ 的像仍位于单位圆上，而且 $\omega$ 的像仍为本原 $r$ 次单位根。因此式 (7) 的各个共轭矩阵仍然酉。每个共轭横截矩阵的列向量范数都为一；由 Hadamard 不等式，$|\sigma(p_f(z))|\le1$。

恒等嵌入与复共轭嵌入彼此不同，二者给出的模相同。由于 $[K:\mathbb Q]=n$，
$$
1\le|\operatorname{Norm}_{K/\mathbb Q}(\alpha)|
   =r^{rn}\prod_\sigma|\sigma(p_f(z))|
   \le r^{rn}|p_f(z)|^2.
$$
$T_fT_f^\dagger$ 的特征值之和为 $r$，其乘积为 $|p_f(z)|^2$。根据算术—几何平均不等式，最大的 $r-1$ 个特征值之积至多为 $(r/(r-1))^{r-1}$。再应用式 (3)，即得结论。$\square$

这个下界很小，不代表实验性能承诺。它给出一个精确的连续性推论：固定构造出的测量与解码器，若某个输入与 $|\Psi\rangle\langle\Psi|$ 的迹距离小于 $\epsilon_{\rm sep}$，则其错误率仍严格小于所有可分态探针的最优错误率。这里迹距离指迹范数的一半。错误事件对应的算子位于 $0$ 与 $I$ 之间，故其期望值的变化不超过该迹距离。加入噪声后，完美排除本身未必保留。

## 6. Schmidt 秩为二的情形

这一部分等价于 [1，定理 1] 已证明的量子比特构造。为使覆盖全部秩的定理保持自包含，我们给出解码器与横截选取的核查。

写成 $|\Psi\rangle=\sqrt\lambda|00\rangle+\sqrt{1-\lambda}|11\rangle$，其中 $0<\lambda<1$。设 $m=\min(\lambda,1-\lambda)$、$c=\sqrt{m/2}$、$s=\sqrt{1-c^2}$，并选择
$$
B_0=I,\qquad
B_1=\begin{pmatrix}c&s\\s&-c\end{pmatrix},\qquad
B_2=\begin{pmatrix}c&s\\-s&c\end{pmatrix}. \tag{18}
$$
在每个结果 $a$ 下，忽略各向量自身不影响物理态的整体相位，归一化条件态可写为
$$
e,\quad Ae+\xi_a Bf,\quad Ae-\xi_a Bf,
\qquad \xi_0=1,\quad\xi_1=-1, \tag{19}
$$
其中 $(e,f)=(e_a,e_{1-a})$、$A,B>0$、$A^2+B^2=1$。相应比值为
$$
\frac{A^2}{B^2}=
\begin{cases}
\lambda c^2/((1-\lambda)s^2),&a=0,\\
(1-\lambda)c^2/(\lambda s^2),&a=1.
\end{cases}
$$
由于 $c^2=m/2<m$，这两个比值均小于一。

保持原有标签次序的解码器为
$$
\begin{aligned}
N_0&=(1-A^2/B^2)|f\rangle\langle f|,\\
N_1&=\frac{|Be-\xi_a Af\rangle\langle Be-\xi_a Af|}{2B^2},\\
N_2&=\frac{|Be+\xi_a Af\rangle\langle Be+\xi_a Af|}{2B^2}.
\end{aligned} \tag{20}
$$
它由非零的正半定算子组成，总和为 $I$，并分别湮灭式 (19) 中对应的态。其余每个输出的概率均为正。因子 $\xi_1=-1$ 保证第二个经典结果下，标签 1 与标签 2 仍按正确次序对应。

式 (18) 的九个横截选取，其行列式绝对值均属于集合
$\{1,c,1-2c^2\}$，这些数都为正。因此可应用引理 2。又因 $A>0$，两个经典结果下，假设 0 与假设 1 的条件态均非正交。至此证明了 $r=2$ 时的全部断言。

## 7. 秩亏态与更大的局部维数

在 $r$ 维 Schmidt 支撑子空间的正交补上，使用同一个带标签的正交归一基，补全三组测量基。在 Bob 未使用的子空间上任意补全其 POVM，例如将该子空间恒等算子的三分之一分别加到三个效应上。

给定探针产生 Alice 新增结果的概率为零。我们不在这些不可能发生的分支上定义归一化条件态。对每个可能出现的结果，前面的构造仍然适用。

对任意其他系统探针，令 $t$ 为其在 Schmidt 支撑子空间上的总概率质量。所有测量效应都是块对角的，因此它与正交补之间的相干项不会影响测量概率。支撑子空间内的部分对错误率的贡献至少为 $t\epsilon_{\rm sep}^{(r)}$。在正交补对应的每个结果上，三个假设给出完全相同的概率；这一部分的最小错误率贡献为 $(1-t)\pi_{\min}$。因此
$$
\epsilon_{\rm sep}^{(d)}
=\min\{\epsilon_{\rm sep}^{(r)},\pi_{\min}\}>0. \tag{21}
$$
在相应子空间中选择达到最小值的输入，即可达到等号。引理 2 的混合态论证再次覆盖全部可分记忆。正概率输出仍保留式 (16) 或式 (19) 中的非正交性。定理 1 得证。

## 8. 一个精确的有理数量子三能级实例

下面的有限实例只使用有理数矩阵，便于直接核查。令
$$
U=\frac1{343}
\begin{pmatrix}
19&-18&342\\
342&19&-18\\
-18&342&19
\end{pmatrix},
\qquad B_0=I,\ B_1=U,\ B_2=U^2, \tag{22}
$$
并取
$$
|\Psi\rangle=\frac{|00\rangle+2|11\rangle+3|22\rangle}{\sqrt{14}}.
$$
计算整数列向量的内积即可证明 $U^\mathsf TU=I$。这是一个单独认证的有理数实例，并非满足充分素数大小条件 (8) 的构造实例。

对它的 27 个横截选取，直接进行有理数消元可得：

| 行列式绝对值 | 出现次数 |
|---|---:|
| $1$ | 3 |
| $19/343$ | 12 |
| $11951/117649$ | 6 |
| $116603/117649$ | 3 |
| $37/117649$ | 3 |

三个同输出条件态三元组中，最大的归一化重叠平方为
$$
\frac{90238809346921}{1033957840454011}<\frac14.
$$
每一对态的重叠都非零。应用第 3 节的未归一化解码器，可得到满足正性、完备性与精确零错误率的有理数效应。结合式 (3) 与命题 4 中的特征值估计，得到
$$
\epsilon_{\rm sep}\ge\frac{5476}{373714754427}
>1.46\times10^{-8}. \tag{23}
$$
这是经过认证的下界，不是精确最优值。

仅依赖 Python 标准库的证书程序检查了这个实例、另外两个有理数量子三能级 Schmidt 谱、一个有理数量子比特实例，以及指定的秩亏嵌入。程序执行了 3228 项精确检查，其中包括 81 个三能级横截选取、729 个嵌入后的秩三横截选取、9 个量子比特横截选取与 27 个嵌入后的秩二横截选取。它检查了每个所记录解码器的全部主子式、所有完备性恒等式，以及全部排除概率。另一套使用 80 位精度的计算，在秩为 3、5、7 的九组谱上检验了分圆构造的公式。这两套计算都不替代第 2—7 节的一般证明。

## 9. 贡献、归属与边界

本文的新结论是：对指定的纯纠缠输入，存在不受奇偶性限制的、单次使用的三组投影测量构造，同时具有严格的可分态错误率间隔与给定输入的非辨别性。其中的奇数秩情形回答了文献 [1] 留下的精确问题。支撑子空间的补全进一步明确了秩亏输入的处理方式。

排除任务中的一般资源优势，已有通过子通道排除得到的结果 [4]。基于 Gram 矩阵的纯态排除与三态重叠阈值也已有研究 [3]。近期工作还使用 Choi 支撑与过程 POVM 研究一般通道排除 [5]。这些结果要么研究不同任务，要么提供本文使用的组成部分。本文不声称首创一般的纠缠辅助排除、Gram 判据、秩二构造，或高次数代数特化方法 [6,7]。文献比较的范围以随稿归档的来源与检索记录为限。

定理的范围是：纯态探针的一个副本、三个有标签的秩一投影测量、装置的经典输出，以及按该输出选择的解码器。它没有证明任意混合纠缠态都具有相应的完美优势，没有确定最优噪声容限，也没有证明其他所有纠缠探针都不能辨别所构造的测量。本文不声称存在高效算法来计算式 (3) 中全部 $3^r$ 项。有限证书只覆盖前文明确列出的范围。

## 参考文献

1. S. Manna, *Usefulness of $d\otimes d$ dimensional pure entangled states for antidiscrimination of quantum measurements when $d$ is even*, J. Phys. A: Math. Theor. **59**, 315304 (2026). [arXiv:2510.26255v2](https://arxiv.org/html/2510.26255v2)，修订于 2026 年 8 月 10 日。[DOI](https://doi.org/10.1088/1751-8121/ae91a4)。
2. S. Manna, S. Suresh, M. S. Kachhawaha and D. Saha, *Single-shot distinguishability and antidistinguishability of quantum measurements*, Phys. Rev. A **111**, 022221 (2025). [DOI](https://doi.org/10.1103/PhysRevA.111.022221)。
3. N. Johnston, V. Russo and J. Sikora, *Tight bounds for antidistinguishability and circulant sets of pure quantum states*, Quantum **9**, 1622 (2025). [arXiv:2311.17047v2](https://arxiv.org/html/2311.17047v2)。[DOI](https://doi.org/10.22331/q-2025-02-04-1622)。
4. A. F. Ducuara and P. Skrzypczyk, *Operational interpretation of weight-based resource quantifiers in convex quantum resource theories of states*, Phys. Rev. Lett. **125**, 110401 (2020). [arXiv:1909.10486v1](https://arxiv.org/abs/1909.10486v1)。[DOI](https://doi.org/10.1103/PhysRevLett.125.110401)。
5. A. A. Vijayan and N. S. Ragini, *Anti-distinguishability of quantum channels*, arXiv:2611.04105v1 (2026). [来源](https://arxiv.org/html/2611.04105v1)。
6. D. Li, *Explicit Full-Spark Gabor Windows with Quantitative Phase Retrieval*, arXiv:2609.09614v2 (2026). [来源](https://arxiv.org/html/2609.09614v2)。
7. R.-D. Malikiosis, *A note on Gabor frames in finite dimensions*, Applied and Computational Harmonic Analysis **38**(2), 318--330 (2015). [arXiv:1304.7709v1](https://arxiv.org/html/1304.7709v1)，第 5 节。[DOI](https://doi.org/10.1016/j.acha.2014.06.004)。
