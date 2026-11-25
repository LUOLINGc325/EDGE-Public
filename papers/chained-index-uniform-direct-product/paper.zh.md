# 链式索引的统一通信下界与强直接积

*固定重量切片、逐轮信息预算与免费静默的全参数代价*

AI 辅助研究稿

2026年11月25日 · 研究稿 v1

# 摘要

链式索引中，各阶段分别持有一个长度为 $n$ 的字符串；每条消息发送后，相应索引才公开，所有被索引位承诺相同。我们研究该公开索引释放模型及其 $r$ 个并行副本。设 $N=2\lfloor n/2\rfloor$。在消息边界不能免费传递私有信息的标准二叉协议树中，任意链长、任意联合编码和公私随机性下，最坏通信量为 $C$ 的协议满足

$$
\Pr[\widehat B=B]\le
\min\{1,2^{-r/2+2C/(N+2)}\}.
$$

特别地，$C\le nr/8$ 时，全部答对的概率至多 $2^{-r/4}$。证明将经典立方体超可积性经随机匹配转移到半切片，再用每轮前缀码的 Kraft 不等式控制似然比二阶矩。另由经典熵独立性的一个自足推导，获得任意相关后验和随机编码器下无附加损失的信息预算，进而得到所有链长的单任务 $\Theta(n)$ 代价。

若改用轮次边界免费可见、允许输入相关空消息的槽位模型，则误差 $1/3$ 的单任务最坏载荷代价恰为

$$
\Theta\!\left(\max\left\{1,
\frac{n}{\log_2(2+k/n)}\right\}\right).
$$

下界由消息元组计数与条件熵预算给出；上界在每个固定承诺输入上成立，使用有硬性标记上限的随机模式匹配。两种计费约定的差异必须保留。经典超可积性、熵独立性及其与 Rényi 收缩的联系均归属于先行工作。本文给出书面数学证明；计算仅作有限一致性复核，全文 Lean 验证另行交付，当前稿不宣称已完成。

# 1. 问题、已有进展与贡献边界

## 1.1 为什么研究链长不受限的情形

普通索引问题要求发送者在不知道查询位置时概述字符串。链式索引把这一步沿多个持有不同字符串的参与者连续执行，却保证每一步查询的答案相同。较早消息使后续参与者逐渐形成有偏后验，因此不能在每一轮重新套用答案均匀的单次索引下界。

Cormode、Dark 和 Konrad [1] 在私有单向链中提出线性通信下界猜想。Sundaresan 的 ITCS 2025 正式版 [2] 引入逐消息后免费公开索引的增强黑板模型，并证明 $\Omega(n-k\log n)$。该界在 $k=o(n/\log n)$ 时最优，但不能给出任意 $k$ 的线性结论。旧 arXiv 摘要曾声称全参数结果；正式会议版本说明修复了早期论证的缺陷，故本研究以较晚正式版为比较基准。Huang 等 [3] 给出了另一条基于最小熵的路线；其正式 Theorem 22 的 signature 代价为各玩家最坏消息长度之和，引用时不能未经证明改为最坏执行路径上的总长。

我们证明增强模型中的下界。因此，只要采用同一二叉协议树计费约定，下界也适用于可被增强模型无额外收费模拟的普通黑板和原私有链。这个模拟只用于下界：增强模型的低代价上界不能反向转移到私有链。

## 1.2 本文实际增加什么

第一项结果消除了信息预算中逐轮累积的 $\log n$ 损失，允许任意相关的答案后验。其切片 KL 收缩是已有熵独立性 [4] 的特例；本文明确推导所需版本及条件化步骤，不将经典不等式本身作为首创。

第二项结果控制全部 $r$ 个答案同时正确的概率，超出平均信息量的直接和下界。关键是一个对链长无损的似然二阶矩预算。半切片的范数估计来自 Bonami [5] 的经典立方体不等式，而变量长度编码的代价通过 Kraft 不等式逐历史计入。Jain [6]、Braverman 与 Weinstein [7] 的两方强直接积不能直接套用到这里：把所有字符串交给一方、所有索引交给另一方，会引入逐轮反馈；把反馈免费化又改变了两方问题的资源。

第三项结果在另一种明确指定的模型中刻画静默的价值。静默通信本身已有研究 [8]；这里的候选新增内容是链式索引的全参数匹配阶及其与收费模型的严格区分。

超可积性、Rényi 收缩和通信逆定理之间的联系已有长期背景 [9]。2026年10月的 Moore 与 Esposito [10] 进一步研究该联系及两方单向一致随机性提取，其中 Proposition IV.1 的范数到幂收缩指数在二阶情形正是本文使用的 $2(p-1)/p$。Guruswami 与 Radhakrishnan [11] 已结合后验矩、Hölder 与超可积性控制一致性成功概率；Ben-Aroya、Regev 与 de Wolf [12] 已用超可积性证明量子随机访问码和单向直接积，并讨论容错恢复。本文不宣称发明这些联系、单向索引强直接积或 Hamming 恢复范式，也不提出任意多方问题的一般强直接积。新增主张限定于所述链式索引的任意链长结果与两种计费模型的精确代价阶。文献比较受可获取版本与检索范围限制；有限查新不能证明全球优先权。

# 2. 精确模型与主定理

## 2.1 输入与信息到达顺序

有 $k\ge1$ 个字符串阶段。第 $i$ 个阶段持有 $r$ 个 $n$ 位字符串 $X_{i,1},\ldots,X_{i,r}$，只能根据本阶段字符串、既往公开历史和协议随机性发送消息 $M_i$。随后，$r$ 个索引 $J_{i,1},\ldots,J_{i,r}$ 才免费公开。承诺存在 $B\in\{0,1\}^r$ 使

$$
X_{i,j}(J_{i,j})=B_j\qquad(i\in[k],\ j\in[r]).
$$

最终解码器仅根据公开历史及其随机性估计 $B$。所有副本允许任意联合编码。字符串并不限于平衡串；平衡性仅用于构造下界分布。当前消息不能利用尚未释放的当前索引。

| 模型 | 每个固定公开历史下的消息 | 费用 |
|:--|:--|:--|
| 收费二叉协议树 | 完整消息构成前缀码；单元素码本可以只有空串 | 执行路径上真正传输的二进制位数 |
| 免费槽位 | 任意二进制串，包括与非空串并存的空串；槽位始终可见 | 各消息载荷位数之和，边界免费 |

标准模型可以按公开历史跳过某个玩家；它不允许通过依赖私有输入的“继续还是结束”免费增加一个选择。下文 $C$ 始终是对承诺输入及随机币实现的最坏通信上限。几乎处处上限也足够：输入空间有限，可以取对所有输入共同成立的概率一随机币集合。

前缀条件确实覆盖通常的顺序二叉协议树：固定一次发言开始时的公开历史，沿二进制分支走到该玩家的发言结束节点；这些结束路径构成前缀码。如果一个结束路径是另一个的真前缀，同一公开树节点就既已结束又须由同一玩家继续，违背协议树规定。结束后才释放本轮索引，故当前索引不能提供免费解码边界。

在同一计费约定下，原私有链可按阶段逐步模拟：增强黑板公开原本发给下一个玩家的同一消息位串；该玩家所需的上一索引也已在其到达前公开。每个玩家读取其中原协议所需的信息、忽略额外历史，使用同样的输入和随机币计算同一消息，最终解码器使用最后消息与索引。这样保留输出、错误率和总收费位数，因而增强模型下界传递到原模型。

## 2.2 困难分布

令 $N=2\lfloor n/2\rfloor$、$s=N/2$，$\mu$ 是 $[N]$ 的所有 $s$ 元子集上的均匀分布，$u$ 是 $[N]$ 上的均匀分布。答案 $B$ 在 $\{0,1\}^r$ 上均匀；各阶段、各副本的集合 $S_{i,j}\sim\mu$ 相互独立，也独立于 $B$。字符串为集合指示函数。给定这些集合和答案后，若 $B_j=1$，则 $J_{i,j}$ 均匀取自 $S_{i,j}$；若 $B_j=0$，则均匀取自补集。所有这些索引条件独立。

当 $n$ 为奇数时，额外一位固定，所有查询只使用前 $N$ 位。这仍是合法的原长输入分布。每轮索引边缘都是 $u^r$，无论答案是什么；但给定字符串后，索引与答案相关。

## 2.3 三个主结论

**定理 A：任意后验的信息预算。** 在某一轮，令 $B$ 的先验任意，可以相关、有偏或具有零概率分量。令新输入 $X\sim\mu^r$ 独立于 $B$，$M$ 是仅由 $X$ 及独立随机币产生的消息，$J$ 随后按上述信道释放，则

$$
I(B;M,J)\le\frac2N I(X;M)\le\frac2N H(M).
\tag{A1}
$$

对完整协议，记 $H_{i-1}$ 为包含公开随机币 $R$ 的过去历史，$L$ 为总收费位数，则标准模型中

$$
I(B;H_k\mid R)
\le\frac2N\sum_{i=1}^k H(M_i\mid H_{i-1})
\le\frac2N\mathbb E L.
\tag{A2}
$$

于是单任务误差至多 $1/3$ 要求

$$
C\ge\frac N2[1-h_2(1/3)]>\frac n{45},
\tag{A3}
$$

其中 $h_2(t)=-t\log_2t-(1-t)\log_2(1-t)$ 为二元熵，端点按 $0\log_20=0$ 定义。发送一个指定阶段的完整字符串给出代价 $n$ 的零误差协议。因此单任务为 $\Theta(n)$，常数不依赖 $k$。

**定理 B：强直接积。** 在困难分布上，任意标准模型协议满足

$$
\Pr[\widehat B=B]
\le\min\{1,2^{-r/2+2C/(N+2)}\}.
\tag{B1}
$$

特别地，$C\le nr/8$ 蕴含 $\Pr[\widehat B=B]\le2^{-r/4}$。它是全部答案同时正确的分布式下界，因而排除了相应预算下在每个承诺输入上都具有较高成功率的协议。这里不声称指数中的常数最优。

**定理 C：免费槽位的全参数代价。** 令 $S(n,k)$ 为免费槽位模型中，单任务最坏错误率至多 $1/3$ 的最小整数载荷代价。对 $n\ge2,k\ge1$，令

$$
F(n,k)=\max\{1,n/\log_2(2+k/n)\},
$$

则

$$
\frac1{2048}F(n,k)\le S(n,k)\le18F(n,k).
\tag{C1}
$$

上界对每个固定承诺输入成立。它使用当前索引的公开释放，不覆盖免费空串的私有相邻链。

# 3. 无附加损失的信息预算

所有熵与散度均用二进制对数；$0\log0=0$。以下是有限空间证明，不需要测度论极限。

## 3.1 从 Maclaurin 不等式到切片 KL 收缩

对均值为一的非负数 $a_1,\ldots,a_N$，经典初等对称均值不等式给出

$$
\mathbb E_{S\sim\mu}\prod_{j\in S}a_j\le1.
\tag{3.1}
$$

给出所需版本的自足证明。记 $e_s$ 为 $s$ 次初等对称多项式。在紧单纯形 $\sum a_j=N$ 上最大化 $e_s$，并在最大点中选择平方和最小者。$s=1$ 时恒等。$s\ge2$ 时，把任何不等的两个坐标替换成它们的平均数；两者和不变、积增大，而

$$
e_s(a)=e_s(a_{\rm rest})+(a_i+a_j)e_{s-1}(a_{\rm rest})
+a_i a_j e_{s-2}(a_{\rm rest}).
$$

各系数非负，故 $e_s$ 不下降，平方和却严格下降，与选择矛盾。因此该最大点所有坐标均为一，$e_s\le\binom Ns$，得到 (3.1)。零坐标已包括在此论证内。

现在令 $\nu$ 是切片上的任意分布，先抽 $S\sim\nu$，再从 $S$ 均匀抽取一个元素，输出分布记为 $v$。KL 的变分不等式为

$$
D(\nu\Vert\mu)\ge \mathbb E_\nu f-
\log_2\mathbb E_\mu 2^f.
\tag{3.2}
$$

它由对倾斜分布 $\mu_f(S)=\mu(S)2^{f(S)}/\mathbb E_\mu2^f$ 使用散度非负性得到。对 $\varepsilon>0$ 取

$$
a_j=\frac{N(v_j+\varepsilon)}{1+N\varepsilon},
\qquad f(S)=\sum_{j\in S}\log_2 a_j.
$$

式 (3.1) 控制配分函数，而 $\nu(j\in S)=sv_j$，因此

$$
D(\nu\Vert\mu)\ge
s\sum_j v_j\log_2\frac{N(v_j+\varepsilon)}{1+N\varepsilon}.
$$

令 $\varepsilon\downarrow0$，零概率项为零，得到

$$
D(v\Vert u)\le\frac2N D(\nu\Vert\mu).
\tag{3.3}
$$

补集变换保持 $\mu$，所以从补集抽元素也满足同一不等式。这是熵独立性的已有特例 [4]，并未声称系数 $2/N$ 最优。

## 3.2 产品输入可任意相关

若各信道 $K_j$ 把 $\mu_j$ 送到 $u_j$，且各自具有固定参考 KL 收缩系数 $\alpha$，则产品信道对任意联合分布 $\nu$ 满足

$$
D\bigl(\nu(\bigotimes_jK_j)\Vert\bigotimes_ju_j\bigr)
\le\alpha D(\nu\Vert\bigotimes_j\mu_j).
\tag{3.4}
$$

证明中令 $X\sim\nu$，各 $Y_j$ 由 $K_j$ 条件独立生成。输出 KL 链式法则和逐坐标收缩给出

$$
D(P_Y\Vert\textstyle\bigotimes_j u_j)
\le\alpha\sum_j\mathbb E_{Y_{<j}}
D(P_{X_j\mid Y_{<j}}\Vert\mu_j).
$$

$P_{X_j\mid Y_{<j}}$ 是各 $P_{X_j\mid X_{<j}}$ 的混合，因为过去信道的随机性在给定 $X_{<j}$ 后与 $X_j$ 独立。KL 对首变量的凸性把右端进一步界为

$$
\alpha\sum_j\mathbb E_{X_{<j}}
D(P_{X_j\mid X_{<j}}\Vert\mu_j)
=\alpha D(\nu\Vert\textstyle\bigotimes_j\mu_j).
$$

这证明了 (3.4)，没有要求 $\nu$ 分解。对每个答案向量 $b$，把子集或补集信道逐坐标相乘得到 $K_b$，于是

$$
\mu^rK_b=u^r,\qquad
D(\nu K_b\Vert u^r)\le\frac2N D(\nu\Vert\mu^r).
\tag{3.5}
$$

## 3.3 任意答案先验与随机编码器

设 $\pi$ 为 $B$ 的任意先验。消息 $M$ 独立于 $B$。对正概率消息 $m$，令 $\nu_m=P_{X\mid M=m}$、$\rho_m=\sum_b\pi_b\nu_mK_b$。精确参考分布恒等式为

$$
\sum_b\pi_bD(\nu_mK_b\Vert u^r)
=I(B;J\mid M=m)+D(\rho_m\Vert u^r).
$$

舍去最后的非负项并使用 (3.5)，再对消息求平均，得到

$$
I(B;M,J)\le\frac2N\sum_mP(M=m)D(\nu_m\Vert\mu^r)
=\frac2N I(X;M).
$$

$I(X;M)\le H(M)$ 给出 (A1)。这一步仅需要随机编码核 $P(M=m\mid X=x)$，不需要确定性消息划分。

## 3.4 为什么可逐轮累积

对每个正概率过去历史 $h$，新输入满足

$$
P(X_i=x,B=b\mid H_{i-1}=h)
=\mu^r(x)P(B=b\mid H_{i-1}=h).
$$

因此 (A1) 可以对每个历史的任意后验使用；互信息链式法则给出 (A2) 的第一个不等式。对固定历史，若完整消息长度为 $\ell_m$，前缀性给出 $K=\sum_m2^{-\ell_m}\le1$。把 $2^{-\ell_m}/K$ 作为参考概率，KL 非负性给出

$$
H(M_i\mid h)\le\sum_mP(M_i=m\mid h)\ell_m+\log_2K
\le\mathbb E[|M_i|\mid h].
$$

再平均、求和，得到完整的 (A2)。不能把它替换成 $H(M_1,\ldots,M_k)\le C$：消息位置可以依赖先前免费公开的索引，从而把已有公共信息重新记录在元组中。

例如先免费公布均匀的 $J\in[N]$，随后只在公开指定的第 $J$ 个槽写固定比特，其余槽固定为空。各历史码本都是单元素，总费用一位，但消息元组熵为 $\log_2N$。本文始终在过去索引条件下计算新增熵。

对均匀的 $r$ 位答案，若整体错误率至多 $\delta<1/2$，每个坐标错误率也至多 $\delta$。条件熵次可加性和二元 Fano 不等式给出

$$
I(B;H_k\mid R)\ge r[1-h_2(\delta)],
\qquad
\mathbb E L\ge\frac{Nr}{2}[1-h_2(\delta)].
\tag{3.6}
$$

取 $r=1,\delta=1/3$。由 $3^5<2^8$ 可知
$1-h_2(1/3)=5/3-\log_2 3>1/15$，又 $N\ge2n/3$，得到 (A3)。指定最后阶段发送全部 $r$ 个字符串，其余阶段按预定日程为空，提供 $nr$ 位零误差上界。

**直接和不足以推出强直接积。** 抽象信道可以以概率 $\alpha$ 透露全部 $B$，其余时候不透露任何内容。它的互信息为 $\alpha r$，全部猜对概率却为 $\alpha+(1-\alpha)2^{-r}$。这个例子只否定“平均信息小便必然指数失败”的推理，不是一个低代价链式索引协议。

# 4. 半切片的超可积估计

这一节控制罕见消息分支，是强直接积所需的额外工具。对 $b\in\{0,1\}$ 定义

$$
K_b(S,t)=\frac2N\mathbf1\{\mathbf1_S(t)=b\},
\qquad
(T_bf)(t)=2\mathbb E_\mu[f(S)\mathbf1\{\mathbf1_S(t)=b\}].
$$

$T_b$ 把输入密度送到相对于 $u$ 的输出密度；其伴随为
$T_b^*g(S)=\sum_tK_b(S,t)g(t)$。令

$$
q=1+N/2,\qquad p=1+2/N,\qquad
\eta=\frac{2(p-1)}p=\frac4{N+2}.
\tag{4.1}
$$

**引理 4.1.** 对 $b=0,1$ 和任意实函数 $f$，

$$
\|T_bf\|_{L_2(u)}\le\|f\|_{L_p(\mu)}.
\tag{4.2}
$$

**证明。** 先处理 $b=1$ 的对偶形式。随机选择 $[N]$ 的均匀完美匹配，再从每对独立等概率选一个端点。所得集合大小为 $N/2$，其分布对所有坐标置换不变，所以正是 $\mu$。

固定匹配 $\{(a_t,b_t):1\le t\le s\}$，令 $\bar g=N^{-1}\sum_vg(v)$，并用独立均匀符号 $\varepsilon_t$ 表示端点选择，则

$$
T_1^*g(S)=\bar g+\frac1N\sum_{t=1}^s
\varepsilon_t(g(a_t)-g(b_t)).
$$

经典立方体超可积性 [5, Chapter III, Theorem 3] 的仿射形式是

$$
\left\|a+\sum_tc_t\varepsilon_t\right\|_q^2
\le a^2+(q-1)\sum_tc_t^2\quad(q\ge2).
\tag{4.3}
$$

具体地，对 $a+\sqrt{q-1}\sum_tc_t\varepsilon_t$ 施加噪声参数 $(q-1)^{-1/2}$ 的 $L_2\to L_q$ 收缩即可得到 (4.3)。匹配内还有

$$
\sum_t(g(a_t)-g(b_t))^2
\le2\sum_v(g(v)-\bar g)^2=2N\operatorname{Var}_u(g).
$$

由于 $q-1=N/2$，条件 $L_q$ 范数平方至多
$\bar g^2+\operatorname{Var}_u(g)=\|g\|_2^2$。该界对所有匹配相同；先取 $q$ 次方再平均匹配，得到
$\|T_1^*g\|_q\le\|g\|_2$。有限空间范数对偶和 Hölder 不等式于是给出 (4.2)。补集是保测度双射，交换 $T_0,T_1$，故另一情形相同。证毕。

**引理 4.2：张量化。** 对任意 $b\in\{0,1\}^r$ 和任意联合函数 $f$，

$$
\|\textstyle\bigotimes_jT_{b_j}f\|_{L_2(u^r)}
\le\|f\|_{L_p(\mu^r)}.
\tag{4.4}
$$

给出两因子步骤以明确混合范数方向。置 $F(x_1,y_2)=T_2[f(x_1,\cdot)](y_2)$，则

$$
\begin{aligned}
\|(T_1\otimes T_2)f\|_{L_2(y_1,y_2)}
&\le\bigl\|\|F(\cdot,y_2)\|_{L_p(x_1)}\bigr\|_{L_2(y_2)}\\
&\le\bigl\|\|F(x_1,\cdot)\|_{L_2(y_2)}\bigr\|_{L_p(x_1)}\\
&\le\|f\|_{L_p(x_1,x_2)}.
\end{aligned}
$$

中间一步是对 $|F|^p$ 使用指数 $2/p\ge1$ 的 Minkowski 不等式。迭代即得 (4.4)，并未假设 $f$ 分解。该经典张量化方法也见 Bonami [5, Chapter III, Lemma 1]。

# 5. 从信道范数到逐轮协议的二阶矩预算

先证明一个限定于新鲜输入的通用命题，随后代入半切片。它不是任意多方通信问题的一般定理。

## 5.1 通用命题的精确假设

答案 $B$ 在有限集 $\mathcal A$ 上具有先验 $\pi$。在每个公开历史 $h$ 下，新的私有输入服从 $\mu_h$，条件独立于 $B$。编码器使用核 $W_h(m\mid x)$，发送前缀码消息；随后公开变量由信道 $K_{b,h}(x,\cdot)$ 产生，该条件律在给定 $B,h,x,m$ 后仍成立。当前编码器不能提前使用该公开变量。各 $K_{b,h}$ 把 $\mu_h$ 送到相同参考输出 $\nu_h$。其密度算子统一满足

$$
\|T_{b,h}f\|_{L_2(\nu_h)}\le\|f\|_{L_p(\mu_h)},
\quad 1<p\le2.
\tag{5.1}
$$

公开随机币属于初始历史，独立于答案；上述假设须在其条件下成立。私有随机编码直接由核 $W_h$ 处理，不需要对一般条件模型额外固定随机币。令 $\eta=2(p-1)/p$，则最坏收费预算 $C$ 蕴含

$$
\Pr[\widehat B=B]\le
\min\{1,\sqrt{\pi_{\max}2^{\eta C}}\},
\qquad \pi_{\max}=\max_b\pi_b.
\tag{5.2}
$$

如果先验依赖公开种子，则先条件化使用相应先验；本节陈述的无条件形式使用与答案独立的公开种子。

## 5.2 每条消息的密度与 Kraft 控制

在固定历史，消息边缘为
$a_m=\mathbb E_{\mu_h}W_h(m\mid X)$，只保留 $a_m>0$ 的消息。条件输入密度是

$$
f_m(x)=W_h(m\mid x)/a_m,\qquad
0\le f_m\le1/a_m,\quad \mathbb E_{\mu_h}f_m=1.
$$

因为 $W_h\le1$，

$$
\|f_m\|_p^2\le a_m^{-2(p-1)/p}=a_m^{-\eta}.
$$

令 $w_{b,h,m}=T_{b,h}f_m$ 为新公开变量相对于 $\nu_h$ 的条件密度，(5.1) 给出

$$
\mathbb E_{\nu_h}w_{b,h,m}^2\le a_m^{-\eta}.
\tag{5.3}
$$

若消息长度为 $\ell_m$，前缀性与 Hölder 给出

$$
\sum_ma_m^{1-\eta}2^{-\eta\ell_m}
\le\left(\sum_ma_m\right)^{1-\eta}
\left(\sum_m2^{-\ell_m}\right)^\eta\le1.
\tag{5.4}
$$

$0<\eta<1$ 时这是通常 Hölder；$\eta=1$ 时正是 Kraft。空串也已包括：它只可作为该历史唯一的完整码字。

## 5.3 参考律与不可达历史

构造不依赖答案的参考公开历史律 $Q$：每轮先按真实新鲜输入的消息边缘 $a_m$ 选择消息，再独立按 $\nu_h$ 选择公开变量。对所有真实输入都不可达的历史，可任意补全一个前缀编码器。记 $P_b$ 为答案固定为 $b$ 时的真实历史律，$L_i=dP_b(H_i)/dQ(H_i)$ 为到第 $i$ 轮的似然，$D_i$ 为累计收费位数。真实转移等于参考转移乘以 $w_{b,h,m}$，所以

$$
L_i=L_{i-1}w_{b,H_{i-1},M_i}(Y_i).
$$

对 $V_i=L_i^2 2^{-\eta D_i}$，由 (5.3) 和 (5.4)，

$$
\begin{aligned}
\mathbb E_Q[V_i\mid H_{i-1}]
&=V_{i-1}\sum_ma_m2^{-\eta\ell_m}
\mathbb E_{\nu_h}w_{b,h,m}^2\\
&\le V_{i-1}\sum_ma_m^{1-\eta}2^{-\eta\ell_m}
\le V_{i-1}.
\end{aligned}
$$

若前一似然为零，两边同时为零。因 $V_0=1$，最终 $\mathbb E_QV_k\le1$，没有任何 $k$ 因子。

参考律可能访问不对应合法输入的历史，故不能直接假设 $D_k\le C$ 在整个 $Q$ 空间成立。正确的支持论证是：$L_k(b,h)>0$ 说明该历史在 $P_b$ 下可达，因而由至少一个合法输入产生，最坏费用必有 $D_k(h)\le C$。其余历史的似然为零。因此

$$
\mathbb E_Q L_k(b,H_k)^2\le2^{\eta C}\mathbb E_QV_k
\le2^{\eta C}.
\tag{5.5}
$$

## 5.4 从二阶矩得到猜测概率

在 $\overline Q=\pi\otimes Q$ 下，答案与参考历史独立，而真实联合律相对 $\overline Q$ 的密度为 $L_k(B,H_k)$。若解码器确定，成功事件 $E=\{\widehat B(H_k)=B\}$ 的参考概率至多 $\pi_{\max}$。若解码器随机，可把一个独立解码随机种子加入两种律，似然与二阶矩不变，参考成功概率仍至多 $\pi_{\max}$。于是 Cauchy--Schwarz 给出

$$
P(E)=\mathbb E_{\overline Q}[L_k\mathbf1_E]
\le\sqrt{\mathbb E_{\overline Q}L_k^2}\sqrt{\overline Q(E)}
\le\sqrt{2^{\eta C}\pi_{\max}},
$$

证明了 (5.2)。这一论证没有在“成功”事件上条件化，所以不需要假设成功条件下未来输入仍独立。

## 5.5 链式索引与自然推论

取 $\mathcal A=\{0,1\}^r$、均匀先验、$\mu_h=\mu^r$、$\nu_h=u^r$，由 (4.4) 有 $p=1+2/N$ 和 $\eta=4/(N+2)$。式 (5.2) 即为 (B1)。又 $N+2\ge n$，故 $C\le nr/8$ 时指数不超过 $-r/4$。

同一论证允许输出至多 $L_0$ 个候选组成的列表：参考成功概率至多 $L_0\pi_{\max}$。对链式索引有

$$
\Pr[B\in\mathcal L(H_k)]\le
\min\{1,\sqrt{L_0\,2^{-r+4C/(N+2)}}\}.
\tag{5.6}
$$

对 $0\le\delta\le1/2$，半径 $\lfloor\delta r\rfloor$ 的 Hamming 球大小至多 $2^{rh_2(\delta)}$，故

$$
\Pr[d_H(\widehat B,B)\le\delta r]
\le\min\{1,2^{-(1-h_2(\delta))r/2+2C/(N+2)}\}.
\tag{5.7}
$$

球体积界在 $\delta>0$ 时由

$$
1\ge\sum_{i\le\delta r}\binom ri\delta^i(1-\delta)^{r-i}
\ge\delta^{\delta r}(1-\delta)^{(1-\delta)r}
\sum_{i\le\delta r}\binom ri
$$

直接得到，$\delta=0$ 时显然。列表与 Hamming 界是同一主定理的推论，不另作独立方法的优先权主张。

# 6. 免费静默：下界

本节仅取 $r=1$，模型使用任意空消息而不满足逐历史 Kraft。信息预算 (A1) 仍成立，但代价转换要改用完整消息元组的支持数。条件化降低熵，所以

$$
\sum_iH(M_i\mid R,M_{<i},J_{<i})
\le\sum_iH(M_i\mid R,M_{<i})
=H(M_1,\ldots,M_k\mid R).
$$

总载荷不超过整数 $C$ 的 $k$ 元组数量恰为

$$
A(C,k)=\sum_{\ell=0}^C2^\ell\binom{k+\ell-1}{\ell}.
\tag{6.1}
$$

长度总和为 $\ell$ 时，插板法确定各槽长度，再选择 $\ell$ 个有序比特。由组合恒等式，

$$
A(C,k)\le2^C\binom{k+C}{C}.
$$

Fano 与信息预算因此要求

$$
\log_2A(C,k)\ge\frac N2[1-h_2(1/3)]>\frac n{45}.
\tag{6.2}
$$

$C=0$ 时所有消息确定，信息量为零，成功率不能超过 $1/2$，故 $C\ge1$。对 $C\ge1$，由 $\binom{k+C}{C}\le[e(k+C)/C]^C$，

$$
C[1+\log_2e+\log_2(1+k/C)]>n/45.
\tag{6.3}
$$

以下反演在所有 $k/n$ 上统一有效。置 $t=k/n$、$L=\log_2(2+t)\ge1$、$a=1/2048$。函数

$$
f_t(x)=x[1+\log_2e+\log_2(1+t/x)]
$$

在 $x>0$ 上严格递增。其导数为
$1+\log_2(1+t/x)+x/[(x+t)\ln2]>0$。
又 $1+tL/a\le(2+t)L/a$，$\log_2e<2$，$\log_2L\le L$，故

$$
f_t(a/L)\le a(14/L+2)\le16a=1/128<1/45.
$$

式 (6.3) 蕴含 $C>n/(2048L)$，结合 $C\ge1$ 即得定理 C 的下界。

# 7. 免费静默：对每个输入成立的上界

若 $k/n<64$，直接发送一个完整字符串，代价 $n$；此时 $\log_2(2+k/n)<7$，故代价至多 $7F(n,k)$。

以下设 $q=k/n\ge64$，选择

$$
t=\min\{n,\lfloor\tfrac12\log_2q\rfloor\},
\qquad C_*=\lceil4n/t\rceil.
$$

每个槽独立公开选择一个均匀 $t$ 元坐标集 $A_i\subseteq[n]$，以及其上的均匀二进制模式 $R_i$。在尚未获知答案、已发标记数小于 $C_*$ 时，玩家仅当 $X_i|_{A_i}=R_i$ 才发送一个比特 $1$，否则发送空串。标记后的索引若属于 $A_i$，所有人立即得到答案 $R_i[J_i]$，之后全部静默。若达到标记上限仍未学到答案，之后也全部静默。最终若仍未知，输出公平随机猜测。每个输入、每次随机实现的代价均至多 $C_*$。

固定任意一个承诺输入，包括所有索引。对每个固定坐标集，随机模式匹配的概率恰为 $2^{-t}$；因此匹配条件下坐标集仍均匀，查询命中概率为 $t/n$。不同槽使用独立随机性。该论证不假设输入平衡或索引随机。

考虑停止之前预先生成的全部潜在匹配，数量 $Z\sim\operatorname{Bin}(k,2^{-t})$。若 $Z\ge C_*$，在前 $C_*$ 个匹配中一个查询都未命中的概率至多

$$
(1-t/n)^{C_*}\le e^{-C_*t/n}\le e^{-4}.
$$

令 $\lambda=\mathbb EZ=k2^{-t}\ge n\sqrt q\ge8n$。由于 $t\ge2$，

$$
C_*\le5n/t\le(5/2)n\le\lambda/2.
$$

标准二项 Chernoff 下尾界给出
$\Pr[Z<C_*]\le e^{-\lambda/8}\le e^{-n}\le e^{-2}$。
为明确常数，可由指数 Markov 不等式得到
$\Pr[Z\le(1-\rho)\lambda]\le\exp(-\rho^2\lambda/2)$：使用二项矩母函数界 $\mathbb Ee^{-sZ}\le\exp[\lambda(e^{-s}-1)]$，取 $s=-\ln(1-\rho)$，再用 $\rho+(1-\rho)\ln(1-\rho)\ge\rho^2/2$。这里取 $\rho=1/2$。

故未学到答案的概率至多 $e^{-2}+e^{-4}<1/3$；最终随机猜测还能进一步减半错误率。上界具有最坏载荷硬上限，不是期望费用界。

最后核对代价。若 $t=n$，则 $C_*=4\le4F$。否则 $\log_2q\ge6$ 蕴含
$t\ge(\log_2q)/3$，且 $\log_2(2+q)\le(7/6)\log_2q$，所以

$$
C_*\le\frac{15n}{\log_2q}
\le\frac{35n}{2\log_2(2+q)}\le18F(n,k).
$$

这完成定理 C。

**一位协议的极长链例子。** 每槽公开猜一个完整 $n$ 位字符串，第一次与当前字符串完全相同时发一个标记，其余槽为空。匹配之后公开的当前索引揭示答案。最坏只用一位，且每个输入的成功率为

$$
1-\tfrac12(1-2^{-n})^k.
$$

当 $k\ge2^n$ 时该值大于 $1-\tfrac12e^{-1}>2/3$。它直接体现了免费时序的力量，也说明定理 A 的收费前提不可删除。

# 8. 核验、形式化范围与剩余问题

配套标准库 Python 程序从两个方向独立复核公式。一是枚举小规模消息元组，并以动态计数核对 (6.1)；二是对 $N=4,r=2,k=2$ 的自适应、变长、含合法空码本的协议，精确枚举真实律和参考律。该协议最坏费用为二位，最优解码成功率为 $5485/13824\approx0.396774$，满足主界。密度范数、KL 收缩及静默参数另有有限浮点检查。检查数量与容差在结果文件中记录，均不能替代任意维数与任意链长的证明。

全文形式化范围包括实际有限概率空间、切片与补集信道、Maclaurin 推导、产品 KL 收缩、随机编码条件化、前缀熵预算、半切片范数估计、张量化、参考律及二阶矩过程、Fano 与直接积推论、消息计数和静默算法的概率正确性。只证明其中的代数或 KL 基础引理不构成全文验证。Lean 补充的已编译声明、所用三公理和剩余义务单独列明；本文不借助未经内核验证的定理声明冒充完成形式化。

以下问题没有解决：强直接积指数的最优常数；任意非平衡输入分布下的最优收缩系数；免费静默的私有相邻链；免费槽位中多个任务的匹配最优规律；已有 Augmented Chain 的不同定义。本文也不从长链结果推导未经验证的新图流算法下界。

# 参考文献

[1] G. Cormode, J. Dark, C. Konrad. *Independent Sets in Vertex-Arrival Streams*. ICALP 2019, LIPIcs 132:45. [doi:10.4230/LIPIcs.ICALP.2019.45](https://doi.org/10.4230/LIPIcs.ICALP.2019.45). 原私有链定义与猜想。

[2] J. Sundaresan. *Optimal Communication Complexity of Chained Index*. ITCS 2025, LIPIcs 325:89. [doi:10.4230/LIPIcs.ITCS.2025.89](https://doi.org/10.4230/LIPIcs.ITCS.2025.89). 使用修正后的正式版，尤其 Definition 7、Lemma 10 与 Lemma 12。

[3] M.-Y. Huang, X. Mao, S. Wang, G. Yang, J. Zhang. *A Min-Entropy Approach to Multi-Party Communication Lower Bounds*. CCC 2025, LIPIcs 339:33. [doi:10.4230/LIPIcs.CCC.2025.33](https://doi.org/10.4230/LIPIcs.CCC.2025.33). §4.1 二叉协议树定义与 Theorem 22 的 signature 范围。

[4] N. Anari, V. Jain, F. Koehler, H. T. Pham, T.-D. Vuong. *Entropic Independence I: Modified Log-Sobolev Inequalities for Fractionally Log-Concave Distributions and High-Temperature Ising Models*. [arXiv:2106.04105](https://arxiv.org/abs/2106.04105). 固定参考的单元素下采样 KL 收缩背景。

[5] A. Bonami. *Étude des coefficients de Fourier des fonctions de $L^p(G)$*. Annales de l'Institut Fourier 20(2):335-402, 1970. [doi:10.5802/aif.357](https://doi.org/10.5802/aif.357). Chapter III, Lemma 1 与 Theorem 3，印刷页 375-376。

[6] R. Jain. *New Strong Direct Product Results in Communication Complexity*. Journal of the ACM, 2015. [doi:10.1145/2699432](https://doi.org/10.1145/2699432). 两方公币单向模型。

[7] M. Braverman, O. Weinstein. *An Interactive Information Odometer with Applications*. ECCC TR14-047，2017年3月10日修订版。[修订全文](https://eccc.weizmann.ac.il/report/2014/047/revision/1/download/)。两方内部信息强直接积。

[8] A. Dhulipala, C. Fragouli, A. Orlitsky. *Silence-Based Communication*. IEEE Transactions on Information Theory 56(1):350-366, 2010. [doi:10.1109/TIT.2009.2034813](https://doi.org/10.1109/TIT.2009.2034813). 静默与脉冲计费的先行背景。

[9] M. Raginsky. *Logarithmic Sobolev Inequalities and Strong Data Processing Theorems for Discrete Channels*. ISIT 2013. [作者全文](https://maxim.ece.illinois.edu/pubs/raginsky_ISIT13.pdf). 超可积性、强数据处理与 Rényi 收缩背景。

[10] R. H. Moore, A. R. Esposito. *Beyond Hypercontractivity: Stronger Communication Converses via Rényi Contraction*. [arXiv:2610.13030v1](https://arxiv.org/pdf/2610.13030), 2026年10月9日。两方单向一致随机性提取的逆定理。

[11] V. Guruswami, J. Radhakrishnan. *Tight Bounds for Communication-Assisted Agreement Distillation*. CCC 2016, LIPIcs 50:6. [doi:10.4230/LIPIcs.CCC.2016.6](https://doi.org/10.4230/LIPIcs.CCC.2016.6). Theorem 4.1、Claim 4.2 与 §4.1。

[12] A. Ben-Aroya, O. Regev, R. de Wolf. *A Hypercontractive Inequality for Matrix-Valued Functions with Applications to Quantum Computing and LDCs*. FOCS 2008. [作者全文](https://homepages.cwi.nl/~rdewolf/publ/qc/dewolf-Hypercontractive.pdf). 量子随机访问码、单向直接积及 Theorem 10 的容错推论。
