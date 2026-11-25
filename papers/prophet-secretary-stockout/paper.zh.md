# 以缺货概率校准在线阈值

*精确性能曲线与 Arnosti–Ma 猜想*

研究稿 · 2026 年 11 月 24 日

## 摘要

一批申请者随机到达，最多可以给其中 $k$ 人分配资源。静态阈值策略事先固定资格线，按到达顺序接受前 $k$ 位合格者。Arnosti 与 Ma 猜想：只要把“资源最终用尽”的概率调到 $\Pr\{\operatorname{Pois}(k)\ge k\}$，就能达到静态阈值方法的锐保证 $1-e^{-k}k^k/k!$。本文证明这一猜想，允许申请者价值独立但不服从相同分布，也允许分布有原子。进一步，对每个目标缺货概率 $\beta\in(0,1)$，给出相对于离线最优和更强事前松弛基准的精确最坏性能曲线，并证明原猜想的校准点是其唯一最大点。达到曲线下确界的极限例子可以全部取为独立同分布。证明使用已有的相对对数凹比较和在线收益分解；本文不把这些工具、原有锐常数或利用率性能曲线列为新发明。本文是附有限范围查新与复现材料的研究稿，尚未经过外部同行评议。

## 1. 问题为什么值得研究

考虑分配有限名额、库存或服务容量。每位申请者到达时，系统可以观察其价值，但必须立即决定是否接受。若事后知道所有人的价值，当然可以选择最高的 $k$ 人；在线决策没有这种信息。

最容易实施的规则是固定一条资格线，先到先得。资格线太高，会留下空额；太低，则可能让普通申请者先占满名额。实际系统往往会记录“是否用尽资源”，因此一个明确问题是：能否仅根据这个缺货事件的发生概率，就把资格线调到理论上最合适的位置？

Arnosti–Ma 在原文 [1] 第 5.2 节、印刷页码第 24 页明确提出这一猜想。他们已经证明静态阈值的最优最坏保证为

$$
\gamma_k=1-e^{-k}\frac{k^k}{k!},
$$

并给出了通过期望利用率达到它的方法。**本研究解决的是另一种校准方式：用缺货概率替代期望利用率。** 本文还确定了缺货概率没有选在最优点时，精确会损失多少保证。

读者只需掌握硕士阶段的基础概率，包括独立性、期望、分布函数和二项分布的泊松极限。证明唯一调用的结构不等式是经典 Newton 不等式；下面列出其具体形式。相对对数凹和单交叉方法已有文献 [2,3]，不属于本文首创。

## 2. 模型与主要结论

取整数 $n\ge k\ge1$。价值 $V_1,\ldots,V_n$ 相互独立、非负，且各自期望有限；它们不必同分布。到达次序是独立于价值的均匀随机排列。

策略固定阈值 $t\ge0$。价值大于 $t$ 的申请者有资格；价值恰好等于 $t$ 时，用统一概率 $\theta\in[0,1]$ 独立抽签决定资格。所有抽签与其他随机量独立。接受前 $k$ 位有资格者，不足 $k$ 人则全部接受。

记资格指示量和总人数为

$$
B_i=\mathbf1_{\{V_i>t\}}+\mathbf1_{\{V_i=t\}}C_i,
\qquad
D=\sum_i B_i,
\qquad C_i\sim\operatorname{Bernoulli}(\theta).
$$

因此 $D$ 是独立 Bernoulli 随机变量之和，也称泊松二项分布。这里的“缺货概率”精确定义为 $\Pr(D\ge k)$。

记 $\mathrm{ALG}$ 为在线策略的期望收益，$\mathrm{OPT}$ 为事后选择最高 $k$ 个价值的期望收益。另定义事前松弛基准

$$
\mathrm{LP}=
\sup\left\{\sum_i\mathbb E[V_i x_i(V_i)]:
0\le x_i\le1,\quad \sum_i\mathbb E x_i(V_i)\le k\right\},
$$

其中 $x_i$ 是可测函数。它只要求接受人数的期望不超过 $k$，因而允许比真实分配更灵活的选择，有 $\mathrm{LP}\ge\mathrm{OPT}$。

令 $Z_\lambda\sim\operatorname{Pois}(\lambda)$，定义

$$
b_k(\lambda)=\Pr(Z_\lambda\ge k),\qquad
u_k(\lambda)=\frac{\mathbb E\min(Z_\lambda,k)}{k},
$$

$$
a_k(\lambda)=
\mathbb E\min\left(1,\frac{k}{Z_\lambda+1}\right).
$$

$b_k$ 从零严格递增到一。对给定 $\beta\in(0,1)$，存在唯一 $\lambda>0$ 使 $b_k(\lambda)=\beta$。

**定理 1：精确缺货性能曲线。** 对所有满足 $\Pr(D\ge k)=\beta$ 的上述策略，

$$
\mathrm{ALG}\ge G_k(\beta)\,\mathrm{LP}
\ge G_k(\beta)\,\mathrm{OPT},
\qquad
G_k(\beta)=\min\{u_k(\lambda),a_k(\lambda)\}.
\tag{1}
$$

固定 $k,\beta$ 后，遍历所有有限实例和正的比较基准，这两个收益比的下确界都恰好等于 $G_k(\beta)$。即使把实例限制为独立同分布，下确界也不变。

**推论 2：Arnosti–Ma 缺货猜想。** $G_k$ 的唯一最大点为

$$
\beta_k=\Pr\{\operatorname{Pois}(k)\ge k\}.
$$

此时

$$
\mathrm{ALG}\ge
\left(1-e^{-k}\frac{k^k}{k!}\right)\mathrm{LP}
\ge
\left(1-e^{-k}\frac{k^k}{k!}\right)\mathrm{OPT}.
\tag{2}
$$

若比较基准为零，直接使用上述乘法不等式，不讨论 $0/0$。若 $n<k$，接受所有申请者已经最优，不需要校准一个正的缺货概率。

## 3. 核心：缺货概率相同，人数分布怎样比较

下面先证明一个关于概率质量的比较引理。它体现已有单交叉思想，并特别处理等号点。

**引理 3：相同尾概率处的比较。** 设 $p_j,q_j$ 是非负整数上的概率质量函数，且每个 $q_j>0$。假设

$$
I=\{j:p_j\ge q_j\}
$$

是整数区间。若对某个 $m\ge0$，

$$
\sum_{j=0}^m p_j=\sum_{j=0}^m q_j,
$$

则两分布的累计概率满足

$$
F_p(j)\le F_q(j)\quad(j\le m),\qquad
F_p(j)\ge F_q(j)\quad(j\ge m).
\tag{3}
$$

**证明。** 令 $d_i=p_i-q_i$、$H(j)=\sum_{i=0}^j d_i$。由于两个概率总和都为一，有 $\sum_i d_i=0$；级数绝对收敛，且 $H(m)=0$。

先假设 $j<m$ 却有 $H(j)>0$。前缀中必有一个 $i\le j$ 满足 $d_i>0$。$m$ 之后的尾和为零，因此尾部至少有一个 $s>m$ 满足 $d_s\ge0$。否则所有尾项严格为负，尾和也严格为负。因为非负项的位置组成区间，$j+1,\ldots,m$ 的所有项都非负。于是 $H(m)\ge H(j)>0$，矛盾。

再假设 $j>m$ 却有 $H(j)<0$。这时 $j$ 之后的尾和为正，故存在 $s>j$ 满足 $d_s>0$。前缀 $0,\ldots,m$ 是非空有限集合，其和为零，所以其中存在 $i\le m$ 满足 $d_i\ge0$。区间性质使 $m+1,\ldots,j$ 的所有项非负，推出 $H(j)\ge H(m)=0$，再次矛盾。证毕。

这里必须保留“非负项构成区间”，包括等号点。仅说非零项的符号依次为“负、正、负”还不够。例如 $(0,-1,2,-1)$ 的首个前缀和为零，但下一个前缀和为负。这个反例的非负位置不构成区间，因而不满足真正使用的条件。

**引理 4：泊松二项分布与泊松分布的比较。** 若 $D$ 是有限个独立 Bernoulli 变量之和，且

$$
\Pr(D\ge k)=\Pr(Z_\lambda\ge k),
$$

则

$$
F_D(j)\le F_{Z_\lambda}(j)\quad(j\le k-1),\qquad
F_D(j)\ge F_{Z_\lambda}(j)\quad(j\ge k-1).
\tag{4}
$$

**证明。** 记 $p_j=\Pr(D=j)$、$q_j=e^{-\lambda}\lambda^j/j!$，并设第 $i$ 个 Bernoulli 变量的成功概率为 $\pi_i$。若所有 $\pi_i\in(0,1)$，生成多项式

$$
\sum_{j=0}^n p_jz^j=\prod_{i=1}^n(1-\pi_i+\pi_i z)
$$

的所有根都是负实数。Newton 不等式给出

$$
\left(\frac{p_j}{\binom nj}\right)^2
\ge
\frac{p_{j-1}}{\binom n{j-1}}
\frac{p_{j+1}}{\binom n{j+1}},
\qquad 1\le j<n.
$$

对比值 $r_j=p_j/q_j$ 整理得到

$$
r_j^2\ge\frac{n-j+1}{n-j}r_{j-1}r_{j+1}
\ge r_{j-1}r_{j+1}.
\tag{5}
$$

$\pi_i=0$ 或 $1$ 的情形由概率系数的连续性保留弱不等式。正概率支持仍然是整数区间：下端是必定成功的变量数，上端是可能成功的变量数。因此 $r$ 没有内部零，且对数凹；换言之，$\log r_j$ 的相邻差递减。这保证超水平集 $\{j:r_j\ge1\}$ 为整数区间。将引理 3 用于 $m=k-1$ 即得结论。

这个性质称为相对于泊松分布的对数凹性。值得注意的是，它对每个 $\lambda>0$ 都成立，不要求 $\lambda$ 等于 $D$ 的均值。这里由缺货概率相等来确定 $\lambda$，从而把累计概率的交点放在容量 $k$ 对应的位置。

定义

$$
U_k(d)=\min(d/k,1),\qquad A_k(d)=\min(1,k/(d+1)).
$$

对任意非负整数随机变量 $Y$，有

$$
\mathbb E U_k(Y)
=1-\frac1k\sum_{j=0}^{k-1}F_Y(j),
\tag{6}
$$

$$
\mathbb E A_k(Y)
=\sum_{j=k-1}^{\infty}
\frac{k}{(j+1)(j+2)}F_Y(j).
\tag{7}
$$

式 (6) 来自截断人数的有限尾和公式。式 (7) 来自 $A_k$ 的相邻差：在 $j<k-1$ 时为零，此后为 $k/((j+1)(j+2))$。这些权重非负且总和为一，可以交换求和。将 (4) 代入，得到同时控制两种风险的结论：

$$
\mathbb E U_k(D)\ge u_k(\lambda),\qquad
\mathbb E A_k(D)\ge a_k(\lambda).
\tag{8}
$$

第一个量控制空额风险，第二个量控制一位高价值申请者被其他人挤掉的风险。

对有限人数，第二个不等式严格，因为 $D$ 的支持终点之后，$F_D=1$，而泊松分布仍有正尾概率。当 $k\ge2$ 时，第一个也严格：若取等，结合校准可得 $p_0=q_0,p_1=q_1$，于是 $r_0=r_1=1$。对数凹性迫使此后 $r_j\le1$；远端又严格小于一，导致 $p$ 的总质量小于一，矛盾。$k=1$ 时，第一个等式正是缺货校准本身。

## 4. 为什么人数比较能给出收益保证

这一节给出已有两风险分解 [1, Lemma 1] 的自足推导。记

$$
D_{-i}=\sum_{\ell\ne i}B_\ell,\qquad
S=\sum_i\mathbb E(V_i-t)_+.
$$

给定价值和资格抽签后，所有合格者之间的相对到达次序仍均匀随机。把收益拆成每名接受者的阈值部分和超过阈值的剩余部分，可得精确恒等式

$$
\mathrm{ALG}
=t\,\mathbb E\min(D,k)
+\sum_i\mathbb E(V_i-t)_+\,
\mathbb E A_k(D_{-i}).
\tag{9}
$$

有正剩余价值的人必定合格；他面对 $D_{-i}$ 个其他合格者时，被接受的概率正是 $A_k(D_{-i})$。独立性允许把剩余价值与其他人的资格人数分开取期望。

由于 $D_{-i}\le D$，而 $A_k$ 递减，(8) 与 (9) 给出

$$
\mathrm{ALG}\ge kt\,u_k(\lambda)+S\,a_k(\lambda)
\ge G_k(\beta)(kt+S).
\tag{10}
$$

另一方面，对任意事前可行选择，

$$
V_i x_i(V_i)\le t\,x_i(V_i)+(V_i-t)_+.
$$

求和取期望，得到 $\mathrm{LP}\le kt+S$。这就证明了定理 1 的普遍下界。

**含原子时也能精确校准。** 令 $W$ 为第 $k$ 大价值，选取有限分位点 $t\ge0$，使

$$
\Pr(W>t)\le\beta\le\Pr(W\ge t).
$$

固定这个 $t$ 后，每个人的资格概率都是 $\theta$ 的一次函数。因此缺货概率是 $\theta$ 的连续非减多项式，其两个端点正是上式两边。由介值定理，存在统一的 $\theta$ 达到目标 $\beta$。不需要给不同申请者设定不同抽签概率。确定性价值、零价值和 $n=k$ 均已包含。

## 5. 曲线的计算与唯一最优点

计算时不需要无限求和：

$$
b_k(\lambda)=1-e^{-\lambda}
\sum_{j=0}^{k-1}\frac{\lambda^j}{j!},
\qquad
b_k'(\lambda)=e^{-\lambda}\frac{\lambda^{k-1}}{(k-1)!}>0,
\tag{11}
$$

$$
u_k(\lambda)=1-\frac{e^{-\lambda}}{k}
\sum_{j=0}^{k-1}(k-j)\frac{\lambda^j}{j!}.
\tag{12}
$$

泊松概率满足 $j\Pr(Z_\lambda=j)=\lambda\Pr(Z_\lambda=j-1)$。逐项移位求和即得下式；原文 [1] 官方在线附录 Lemma 7 已记录这一恒等式：

$$
\lambda a_k(\lambda)=k u_k(\lambda).
\tag{13}
$$

因此只需求解一个严格单调的一元方程 $b_k(\lambda)=\beta$，然后计算

$$
G_k(\beta)=
\begin{cases}
u_k(\lambda),&0<\lambda\le k,\\
\dfrac{k}{\lambda}u_k(\lambda),&\lambda\ge k.
\end{cases}
\tag{14}
$$

$u_k$ 严格递增，$a_k$ 严格递减。证明可以把较大参数的泊松变量写成较小参数变量加上一个独立正参数的泊松增量。$U_k$ 非减，且当原变量为零、增量为正时严格增加；$A_k$ 非增，且当原变量为 $k-1$、增量为正时严格减少。这些事件均有正概率。

结合 (13)，两分支只在 $\lambda=k$ 相等。所以 $G_k$ 的唯一最大点为 $\beta_k=b_k(k)$。此时

$$
u_k(k)=
\Pr(Z_k\le k-2)+\Pr(Z_k\ge k)
=1-\Pr(Z_k=k-1)
=1-e^{-k}k^k/k!,
$$

其中 $k=1$ 时第一项概率按零处理。$a_k(k)$ 由 (13) 取相同值，原猜想得到证明。

精确曲线的两分支分别对应未用容量和拥挤损失，峰值位于泊松容量校准点。

**推论 5：校准区间内的保证。** 若真实缺货概率已知属于 $[\beta_-,\beta_+]\subset(0,1)$，令 $\lambda_\pm=b_k^{-1}(\beta_\pm)$，则

$$
\mathrm{ALG}\ge
\min\{u_k(\lambda_-),a_k(\lambda_+)\}\,\mathrm{LP}.
\tag{15}
$$

这是因为一条分支递增、另一条递减；整个区间内的最坏值出现在端点。该区间保证也是锐的。它以真实缺货概率的区间已有效建立为前提，本文不宣称已经解决从历史样本选择阈值所需的统计样本量。

## 6. 为什么保证已经不能提高

固定 $k,\beta$，记对应的泊松参数为 $\lambda$。对 $n\ge k$，令 $r_n$ 唯一满足

$$
\Pr\{\operatorname{Bin}(n,r_n)\ge k\}=\beta.
\tag{16}
$$

对任意 $0<\varepsilon<\lambda$，将二项成功概率分别取为 $(\lambda-\varepsilon)/n$ 和 $(\lambda+\varepsilon)/n$。其尾概率极限分别严格小于、大于 $\beta$，因此由单调性可把 $nr_n$ 夹在 $\lambda-\varepsilon$ 和 $\lambda+\varepsilon$ 之间。故 $nr_n\to\lambda$。相应的二项变量及删去一项后的变量都趋于 $Z_\lambda$，下面用到的有界函数期望也收敛。

**空额一侧。** 取所有价值恒为一。缺货校准迫使阈值为一，平局接受概率为 $r_n$。在线收益为 $\mathbb E\min(\operatorname{Bin}(n,r_n),k)$，而两个基准均为 $k$。比值趋于 $u_k(\lambda)$。

**拥挤一侧。** 令 $\varepsilon_n=n^{-3}$、$M_n=n^4$。所有价值独立同分布，以概率 $\varepsilon_n$ 取 $M_n$，否则取一。对充分大的 $n$，取阈值一，并令

$$
\theta_n=\frac{r_n-\varepsilon_n}{1-\varepsilon_n}\in(0,1).
$$

这样资格概率恰为 $r_n$。若 $H_n\sim\operatorname{Bin}(n,\varepsilon_n)$ 是高价值人数，则直接条件计算得

$$
\mathrm{ALG}
=\bigl[nr_n+n\varepsilon_n(M_n-1)\bigr]\,
\mathbb E A_k(\operatorname{Bin}(n-1,r_n)),
\tag{17}
$$

$$
\mathrm{LP}=k+n\varepsilon_n(M_n-1),\qquad
\mathrm{OPT}=k+(M_n-1)\mathbb E\min(H_n,k).
\tag{18}
$$

事前方案可以接受全部高价值事件，再用单位价值补足期望容量，因而 (18) 的第一式是可达到的。对整数 $h\ge0$，有 $(h-k)_+\le h(h-1)/2$，于是

$$
0\le n\varepsilon_n-\mathbb E\min(H_n,k)
\le\frac{n(n-1)}2\varepsilon_n^2=O(n^{-4}).
$$

两个基准之差为 $O(1)$，但本身均按 $n^2$ 增长。结合 (17)，两个在线收益比都趋于 $a_k(\lambda)$。

这里不存在人为选择不利平局规则的问题。第二族中，阈值低于一会使缺货概率等于一；高于一则缺货概率不超过 $\Pr(H_n\ge k)\to0$。对固定 $\beta\in(0,1)$，充分大的 $n$ 只能取阈值一，且平局概率唯一。

两族独立同分布例子分别达到两分支的极限，与普遍下界一起证明定理 1 中的精确下确界。这不要求某个有限实例恰好取到下确界。事实上，$k\ge2$ 时，最优校准下每个有限、正收益实例的实际比值都严格大于 $\gamma_k$。

若要求价值分布无原子，可以把单位原子替换为 $[1,1+\eta_n]$ 上的均匀分布，把高值原子替换为 $[M_n,M_n+\eta_n]$ 上的均匀分布，其中 $\eta_n\downarrow0$，且两区间不相交。对低价值，用同一个独立均匀变量 $T_i$ 生成新价值 $1+\eta_nT_i$，并把原来的资格抽签写成 $\mathbf1_{\{T_i>1-\theta_n\}}$。取新阈值 $1+\eta_n(1-\theta_n)$，就能保持整个资格向量不变；高价值加上 $[0,\eta_n]$ 内的独立扰动后仍全部合格。常数值例子使用同样构造，只需取 $\theta_n=r_n$。耦合后的在线收益和离线收益各至多变化 $k\eta_n$；将事前选择对原价值条件化，可得事前基准同样的变化界。因此极限比值不变。

## 7. 验证范围与贡献边界

书面证明覆盖所有正整数容量、任意有限人数、独立异质价值、原子和退化分布。均匀随机到达且独立于价值是必要的模型前提；本文不把结论推广到相关价值或对手指定的到达次序。

复现材料包括性能曲线、锐性例子、若干分布的精确有理数比较，以及独立编写的异质参数压力检查。有限计算用于发现公式、实现或边界错误，不替代全参数证明。原稿报告有限有符号和比较定理的局部形式化；Newton 不等式、概率分布、泊松无限求和、在线模型和极限锐性仍由书面证明负责。

原文 [1] 已有锐常数、两风险分解、期望利用率的最优校准和相应性能曲线，也已有低值与稀有高值的构造框架。本文的新增结论限定为原缺货猜想的证明，以及以缺货概率为参数的精确曲线、唯一最优点和相应锐性。Yu [2] 及 Braida 等 [3] 的比较思想均明确归属既有文献。

在已记录的文献检索和正文比对范围内，未发现原缺货猜想或本文精确缺货曲线的先行证明。这不是全球优先权认证。原作者当前为期刊论文提供的开放全文链接指向已核验的 arXiv 作者稿；出版社官方在线附录也已核查。另行排版的正式主文未取得，因此不认证其与作者稿逐字一致。本稿为 AI 辅助研究稿，未经外部同行评议。本版本未附复现程序、计算输出及 Lean 源码。

## 参考文献

1. Nick Arnosti, Will Ma. *Tight Guarantees for Static Threshold Policies in the Prophet Secretary Problem*. Operations Research 71(5):1777–1788, 2023. [DOI: 10.1287/opre.2022.2419](https://doi.org/10.1287/opre.2022.2419)。正文接口与猜想按 [arXiv:2108.12893v2](https://arxiv.org/abs/2108.12893v2) 和 [作者托管全文](https://www.columbia.edu/~wm2428/papers/prophet_secretary.pdf) 核查。

2. Yaming Yu. *Relative log-concavity and a pair of triangle inequalities*. Bernoulli 16(2):459–470, 2010. [DOI: 10.3150/09-BEJ216](https://doi.org/10.3150/09-BEJ216)，[作者重印本 arXiv:1010.2043](https://arxiv.org/abs/1010.2043)。

3. Arthur Braida, Elie Bermot, Simon Apers. *Log-Concavity and Tunneling: Quantum Adiabatic Algorithm for Convex Functions (With a Spike)*. ESA 2026, LIPIcs 388, Article 110. [DOI: 10.4230/LIPIcs.ESA.2026.110](https://doi.org/10.4230/LIPIcs.ESA.2026.110)，[正式全文](https://drops.dagstuhl.de/storage/00lipics/lipics-vol388-esa2026/html/LIPIcs.ESA.2026.110/LIPIcs.ESA.2026.110.html)，完整版本 [arXiv:2606.23614](https://arxiv.org/abs/2606.23614)。
