# 可观测再生过程中的未见平稳质量：无参估计与尖锐风险

**摘要。** 从一条有限的平稳时间轨迹估计其中没有出现的标签所占平稳质量。若再生时刻可由数据识别，且相邻时刻间隔几乎必至多为 $H$，全样本完整词留一估计量在不知道 $H$、混合时间与词长分布时达到极小极大均方风险 $\Theta(\min\{1,H/n\})$。允许词内任意相关、标签与词长相关，以及周期过程。证明从每次删词后的定长前缀入手，以成对删除消去中心化误差，再用平稳首次出现界控制向完整样本的回归。有限平稳 Markov 链有已知再生状态时，非周期子类已给出匹配下界，唯一退化情形是 $H=1$。

## 引言

Good–Turing 的独立样本形式通过只出现一次的标签频率估计未见质量。对 Markov 轨迹，统计目标仍是实际这条路径的未见集合在平稳分布下的概率，反复观测同一局部状态有时会改变单现频率的含义。WingIt 以按混合时间选择时间窗的方式求一般链的估计保证。在最坏初态总变差混合时间有界的通常模型中，其均方风险上界和已知下界间仍可能差一个对数因子。另一项工作给出确定的 next-token 泛函的尖锐风险，但目标本身已取过联合期望。本文保留路径依赖的随机目标，假设能够观察真正的再生边界。 [WingIt，§3 和 Theorem 1](https://jmlr.org/papers/v25/24-0511.html) · [Next-token functional estimation，§1](https://arxiv.org/html/2609.19529v1)

观察时长固定时，完整词的数量受词长影响，起始和末尾的不完整词又参加未见集合的定义。因此，确定数量的 iid 词留一定理不能仅通过条件于所见词数来应用。以下先把留一比较限制到一个时间前缀，用词起点控制随机纳入，继而以平稳首次出现界恢复整条观测。算法始终直接使用所有实测完整词。 [固定 iid 样本的删除稳定性结论](https://arxiv.org/html/2610.41244v1#S5)

## 1. 模型、估计量与结果

观察整数时刻 $[0,n)$ 的标签 $X_t$，取值于可数集合 $\mathcal X$，并可从数据识别其中的再生时刻。标签过程平稳，边际律为 $\pi$。从第一个非负再生时刻 $r$ 起，过程由相继的独立同分布随机词 $C_1,C_2,\ldots$ 拼成。这些词与到首个再生点的初始前缀及其长度 $r$ 独立。词 $C_i$ 的长度 $L_i$ 满足 $1\le L_i\le H$，初始前缀长 $0\le r\le H$。段内标签允许任意相关，词的内容与长度可以相关。两个相继再生时刻的间隔就是前者处开始的词长，结束时刻本身属于下一词。

例如，平稳有限 Markov 链具有一个已知状态 $o$，从 $o$ 出发的首个正返回时间几乎必不超过 $H$。若链不可约，且以平稳分布启动，即有上述再生分解。强 Markov 性在首次到达 $o$ 处给出独立性。在双向平稳扩张中，有限不可约性保证过去有一次对 $o$ 的访问。该访问开始的回返间隔至多为 $H$，所以初始时刻距下一次访问 $o$ 至多 $H$。状态 $o$ 的每次自环构成一个长度为一的词。返回间隔可为同一确定值，链可以有周期。

对实测整条轨迹的未见集合 $U=\mathcal X\setminus\{X_0,\ldots,X_{n-1}\}$，估计随机目标 $\mathcal M_n=\pi(U)$。写 $Q_i(B)$ 为词 $C_i$ 中属于 $B$ 的位置数。称在 $[0,n)$ 内两个端点均被记录的词为完整词，令 $U^*_{-i}$ 为从实测 $n$ 个位置删掉完整词 $C_i$ 后其余位置的未见集。估计量为
$$
\widehat{\mathcal M}_n=\frac1n\sum_{i:\,C_i\text{ 完整}} Q_i(U^*_{-i}).
\tag{1}
$$
若无完整词，和为空。一个观察到的标签对分子有贡献，当且仅当它的全部观测出现都位于同一个完整词中。此时它的全部出现次数都被计入。可通过标签计数和所属词编号实现，不需要获知 $H$、段长种类数、段长分布、混合时间或平稳律。

令 $\mathcal R_H$ 为上述带可观测边界的平稳词过程类。极小极大风险对候选估计量取下确界，对 $\mathcal R_H$ 中各过程的平方误差期望取上确界。类中的模型可以具有任意可数字母表，估计量只处理观测到的标签。下界允许估计量事先知道 $H$，并在两个模型中采用同一有限字母表。

**定理 1（全样本未见质量的极小极大阶）。** 存在绝对常数 $c,C>0$。对任意整数 $n,H\ge1$，估计量 (1) 在上述可观测再生词模型中满足
$$
\mathbb E[(\widehat{\mathcal M}_n-\mathcal M_n)^2]
\le C\min\{1,H/n\}.
$$
该模型在各 $n,H\ge1$ 上的极小极大风险至少为 $c\min\{1,H/n\}$。对有已知回返状态的有限平稳不可约 Markov 链，同一下界对 $H\ge2$ 成立，且下界族可以选为非周期链。Markov 类在 $H=1$ 时只有该回返状态，风险为零。

## 2. 更新报酬、平稳首次出现和再生计数

以下 $\ell=\mathbb E L_i$。对任意确定集合 $B$，
$$
\mathbb E Q_i(B)=\ell\pi(B).
\tag{2}
$$
沿完整词的经验计数率由独立词的强大数定律收敛到 $\mathbb E Q_i(B)/\ell$，初始前缀和最后一个不完整词合计至多 $2H$ 个位置。平稳性使任何固定观察长度的经验频率期望为 $\pi(B)$。有界收敛给出 (2)。若 $B$ 由独立于 $C_i$ 的信息决定，(2) 同样可以条件使用。

**平稳首次出现界。** 对任意整数 $B_0\ge0$，设 $D_{B_0}$ 为在 $[0,B_0)$ 未见、但在 $[B_0,B_0+H)$ 出现的标签。则
$$
\mathbb E\pi(D_{B_0})\le\frac{1}{1+\lfloor B_0/H\rfloor}.
\tag{3}
$$
固定标签 $x$，令 $m=1+\lfloor B_0/H\rfloor$。事件 $x\in D_{B_0}$ 蕴含 $x$ 在末块出现并在其前 $m-1$ 个相邻长度 $H$ 的块中均未出现。这 $m$ 个块可从偏移 $B_0-(m-1)H$ 开始。将“末块出现、前 $m-1$ 块不出现”事件各向后移动 $0,H,\ldots,(m-1)H$。任意两个事件不能同时发生，因为后事件的禁现块覆盖先事件的末块。由平稳性各事件概率相同，每个概率至多 $1/m$。按 $\pi(x)$ 求和得 (3)。

以下取 $n\ge8H$，并设 $A=n-H$、$A'=n-2H$。所有其他样本量可用估计量与目标都在 $[0,1]$ 的直接界。对任意与原过程同分布的再生过程 $Y$，令 $K(Y)$ 为起始时刻严格小于 $A$ 的词数。词 $i$ 起点为 $b_i=r+\sum_{j<i}L_j$。条件 $\{b_i<A\}$ 在观察到词 $i$ 之前已确定。所有入选词位于 $[r,n)$，因此
$$
\ell\,\mathbb E K=\mathbb E\sum_{i:\,b_i<A}L_i\le n.
\tag{4}
$$
我们还需要控制 $K$ 与稀有首次出现事件的相关性。若 $z\ge3$ 且 $\ell K>zn$，则起始时刻小于 $A$ 的词至少有 $\lfloor zn/\ell\rfloor+1$ 个。于是前 $t=\lfloor zn/\ell\rfloor$ 个词长之和小于 $n$。令 $\gamma=1-e^{-1}$。由 $L_i/H\in[0,1]$ 和凸性，
$$
\mathbb E e^{-L_i/H}\le 1-\gamma\ell/H.
$$
独立性和指数 Markov 不等式给出
$$
\Pr(\ell K>zn)\le e^{n/H-\gamma t\ell/H}
\le e^{-zn/(4H)},
\tag{5}
$$
最后一步用 $t\ell\ge zn-H$、$n\ge8H$ 和 $z\ge3$。从而，只要 $D(Y)$ 是 (3) 中 $B_0=A$ 或 $A'$ 对应的集合，就有
$$
\mathbb E[\ell K(Y)\pi(D(Y))]
\le 3n\,\mathbb E\pi(D(Y))+
\mathbb E[\ell K(Y)\mathbf1_{\{\ell K(Y)>3n\}}]
\le C_0 H.
\tag{6}
$$
最后一项由 (5) 积分，至多 $(3n+4H)e^{-3n/(4H)}$。式 (3) 的分母在这里至少为 $A'/H$。此处不需 $K$ 与 $D$ 独立。

## 3. 定长截尾估计量及目标比较

令 $I_i=\mathbf1_{\{b_i<A\}}$。若 $I_i=1$，则 $b_i+L_i<A+H=n$，所以完整词的两个端点均已观察到。删去 $C_i$、闭合时间轴，取缩短后前 $A$ 个位置的未见集合 $U_i$。可在无限时间轴上定义所有 $U_i$。当 $I_i=1$ 时，实际计算只需原样本的前 $n$ 个位置，因为 $A+L_i\le n$。记短窗估计和其中的长度加权目标为
$$
\widetilde{\mathcal M}=\frac1n\sum_i I_i Q_i(U_i),
\qquad
\mathcal M^\circ=\frac1n\sum_i I_iL_i\,\pi(U_i).
$$
从 $r\le H$ 至最后入选词尾覆盖至至少 $A$，故
$$
n-2H\le \sum_i I_i L_i\le n.
\tag{7}
$$
缩短后前 $A$ 个位置来自原样本，故 $U_i\supseteq U$。固定一个在原前 $A$ 个位置已经出现的标签。若它在缩短后的前 $A$ 个位置消失，原前 $A$ 个位置中的每次出现都落在所删词内。这样的词至多一个，对长度加权至多贡献 $H$。其余属于 $U_i\setminus U$ 的标签必须在原末 $H$ 个位置中首次出现。记它们的全集为 $D_A$。逐标签计数和 (7) 给出
$$
0\le\mathcal M^\circ-\Big(\frac1n\sum_i I_i L_i\Big)\mathcal M_n
\le H/n+\pi(D_A).
$$
用 (3)、(7) 和 $0\le\pi(D_A)\le1$ 即得
$$
\mathbb E[(\mathcal M^\circ-\mathcal M_n)^2]\le C_1 H/n.
\tag{8}
$$

## 4. 双删除与依赖交叉项

设 $Z_i=Q_i(U_i)-L_i\pi(U_i)$，故 $|Z_i|\le L_i$。短窗估计相对 $\mathcal M^\circ$ 的误差为 $\sum_i I_i Z_i/n$，其平方的对角项至多 $Hn/n^2$，由 $\sum_i I_iL_i^2\le H\sum_i I_iL_i$ 得到。处理交叉项时，删去 $C_i,C_j$，闭合时间轴，令 $U_{ij}$ 为剩余前 $A'$ 个位置的未见集。对 $i\ne j$，
$$
U_{ij}\supseteq U_i\cup U_j,
$$
因为双删除前 $A'$ 个位置来自任意一次单删除后的前 $A'+H=A$ 个位置。设 $Z_i'=Q_i(U_{ij})-L_i\pi(U_{ij})$，$Z_j'$ 同理。当 $i<j$，给定初始前缀和除 $C_j$ 外所有完整词，$I_i,I_j,U_{ij},Z_i'$ 均已确定，且由 (2) 得 $\mathbb E[Z_j'\mid \text{这些信息}]=0$。所以 $\mathbb E[I_iI_jZ_i'Z_j']=0$。这一步用的是起点截尾。若改以词末尾截尾，$I_j$ 就可能受被积分的词长影响。

记 $\Delta_{ij}=U_{ij}\setminus U_i$。用
$$
Z_iZ_j-Z_i'Z_j'=(Z_i-Z_i')Z_j+Z_i'(Z_j-Z_j')
$$
及 $|Z_j|,|Z_j'|\le L_j$，对有序对求和可得
$$
\left|\sum_{i\ne j}\mathbb E[I_iI_jZ_iZ_j]\right|
\le 2\,\mathbb E\sum_{i\ne j} I_iI_j L_j\big[Q_i(\Delta_{ij})+L_i\pi(\Delta_{ij})\big].
\tag{9}
$$

固定 $i$，把删去 $C_i$ 的过程记为 $Y$。保留原初始前缀，保留的独立词依序仍独立同分布，故 $Y$ 与原过程同分布且独立于 $C_i$。在 $Y$ 中原词 $C_j$ 对应编号 $k=j$（$j<i$）或 $k=j-1$（$j>i$）。原来的 $I_j$ 至多为 $Y$ 的对应入选指标，因为删除 $C_i$ 只会将相应起点左移。原 $I_i$ 恰是 $Y$ 的第 $i$ 个起点小于 $A$ 的指标，因为这就是原位置重新插入 $C_i$ 的时刻。此时
$$
\Delta_{ij}=U_{-k,A'}(Y)\setminus U_A(Y),
$$
其中 $U_{-k,A'}(Y)$ 是删 $Y$ 的词 $k$ 后首 $A'$ 个位置的未见集，$U_A(Y)$ 是不删除时首 $A$ 个位置的未见集。它与被积分的 $C_i$ 独立。

由 (2)，括号的条件期望为 $2\ell\pi(\Delta_{ij})$。先对对应的 $k$ 求和，再对 $i$ 求和。每个删一过程分布相同，故 (9) 右端至多
$$
4\ell\,\mathbb E[K(Y)S(Y)],\qquad
S(Y)=\sum_{k=1}^{K(Y)} L_k(Y)\,
\pi\big(U_{-k,A'}(Y)\setminus U_A(Y)\big).
\tag{10}
$$
在 $Y$ 的前 $A'$ 个位置已出现的标签，只有删掉含其全部这些出现位置的唯一词才可能计入，因此对 $S$ 的总贡献不超过 $H$。其余可能计入的标签在 $[A',A)$ 首次出现，构成 $D_{A'}(Y)$。由于所有入选词的长度和至多 $n$，
$$
S(Y)\le H+n\pi(D_{A'}(Y)).
$$
用 (4) 和 (6)，(10) 至多 $C_2 Hn$。加上对角项，
$$
\mathbb E[(\widetilde{\mathcal M}-\mathcal M^\circ)^2]\le C_3 H/n.
\tag{11}
$$

## 5. 回到无参估计量

完整词起点落在 $[A,n)$ 的那些词合计至多 $H$ 个位置，因此把它们计入 (1) 所新增的值至多 $H/n$。对于其他完整词 $i$，删去后仍观测到 $n-L_i\ge A$ 个位置。真实全样本的留一未见集合 $U^*_{-i}$ 包含于 $U_i$；两者的差只能含有在删一词过程 $Y$ 的 $[A,n)$ 首次出现的标签。用 $D_A(Y)$ 表示这个允许更长的集合，原样本没有提供的额外位置仅用于证明。于是该词两种计数的差至多 $Q_i(D_A(Y))$。对被删词条件求期望，并按 (10) 的插入点计数法合并各 $i$，得到
$$
\mathbb E\sum_i I_i Q_i(D_A(Y_{-i}))
=\ell\,\mathbb E[K(Y)\pi(D_A(Y))]\le C_0 H.
$$
两估计量都在 $[0,1]$，其差的均方不超过绝对差的期望。因此
$$
\mathbb E[(\widehat{\mathcal M}_n-\widetilde{\mathcal M})^2]\le C_4 H/n.
$$
合并 (8)、(11) 与上式即给出定理上界。证明只使用词的独立同分布、可观测的切点、平稳性和长度界。未知 $H$ 仅出现在证明选取的 $A,A'$ 内。

## 6. 匹配下界和退化情形

下界在一个只有一种非零离开段长的两模型族上实现。对 $n\ge3,H\ge2$，令 $d=\min\{H-1,\lfloor n/3\rfloor\}\ge1$。状态 $o$ 以概率 $\eta=1/(d+1)$ 出发，从标签律 $p$ 抽取 $j$，在接下来的 $d$ 个位置依序走过 $(j,1),\ldots,(j,d)$，然后回 $o$。以其余概率在 $o$ 自环。所有正返回词长属于 $\{1,d+1\}$，链不可约且非周期。直接核对流量可得
$$
\pi(o)=\frac{1}{1+d\eta},
\qquad
\pi(j,k)=\frac{\eta p_j}{1+d\eta},\quad k=1,\ldots,d.
$$
总外部质量 $w=d/(2d+1)$ 介于 $1/3$ 与 $1/2$。 该族的混合时间为 $\Theta(d)$。任意初态至多 $d$ 步到 $o$，故第 $2d$ 步的各行分布都在 $o$ 有至少 $(1-\eta)^{2d}=(1+1/d)^{-2d}\ge e^{-2}$ 的共同质量。按 $2d$ 步分块对总变差使用收缩，得到 $O(d)$ 上界。从首次外部相位出发，在 $d-1$ 步时不能访问 $o$，而 $\pi(o)>1/2$，得到混合时间至少 $d$。在 $n\ge3H_0$ 时取 $d=H_0$，这也实现 r01 的单一正游程长度 $H_0$ 且 $T\asymp H_0$ 的下界范围。将标签律取为 $p_0,p_1$，重标签质量分别为 $1/2$ 和 $1/2+\delta$，剩余质量均分给同一组 $2n$ 个稀有标签。取 $\delta=[128\sqrt{2+n/d}]^{-1}$。两模型的相位时钟分布完全相同，包括平稳初始相位。独立于时钟的至多 $\lfloor n/d\rfloor+2$ 次标签抽取可模拟全轨迹，把初始、末尾的不完整游程都包括在内。单次标签 KL 等于重标签 Bernoulli KL，至多 $8\delta^2$。数据处理和 Pinsker 不等式给出两轨迹律的总变差至多 $1/64$。

考虑起点为 $o$、前 $d$ 次离开选择中成功离开、首次完整游程标签为重标签的事件。因为 $n\ge3d$，相应完整游程可由观察识别。两模型中该事件的概率均至少 $(1-e^{-1/2})/4$，由 $\pi(o)\ge1/2$、$1-(1-\eta)^d\ge1-e^{-1/2}$ 和重标签概率至少 $1/2$ 得到。此事件上，重标签的全部相位和 $o$ 均已见，而至少 $n$ 个稀有标签的全部相位未见。两模型对同一观察赋予的随机目标质量因此相差至少 $w\delta/2\ge\delta/6$。两轨迹律的共同部分给该事件的质量至少 $(1-e^{-1/2})/4-1/64>0$。任一实数估计值对两个相差 $\delta/6$ 或更大的目标，两个平方误差之和至少 $(\delta/6)^2/2$。在共同测度上积分后，最大风险至少常数倍 $\delta^2$。因 $d=\min\{H-1,\lfloor n/3\rfloor\}$，这至少为 $c_0\min\{1,H/n\}$。

当 $n=1,2$ 且 $H\ge2$，取两状态链 $P(o,a)=\eta$、$P(a,o)=1$，两模型分别取 $\eta=1/2,1/4$。两模型均以概率至少 $1/3$ 观测到全 $o$ 轨迹，其上未见质量分别为 $1/3$ 和 $1/5$。同一共同测度平方损失论证给常数下界。Markov 类 $H=1$ 仅含已知状态 $o$ 时，目标恒为零。更一般的可观测词模型在 $H=1$ 仍包含独立同分布的单字词。对该子类沿用上述重标签和 $2n$ 个稀有标签的两模型，以 $n$ 次独立抽取给 TV 界，并用“首个标签为重标签”作共同事件。此时无外部质量因子 $w$，目标差至少 $\delta/2$，取 $\delta=(128\sqrt{2+n})^{-1}$ 即给 $c_1/n$。这完成全部端点。

## 7. 原 Markov 问题与先前估计器的范围

在一般有限、不可约、非周期、平稳启动的 Markov 类中，原问题只给定最坏起点总变差 $1/4$ 混合时间上界 $T$。一般类下界为 $\Omega(\min\{1,T/n\})$，WingIt 上界为 $\widetilde O(T/n)$，本文的再生词定理没有消除一般类的缺口。已知混合时间不等于已有可观测再生边界或几乎必有界的回返间隔。反过来，确定周期链具有有限回返间隔而无有限总变差混合时间。 [一般链下界及其范围](#附录-b-一般链下界固定函数方差和有限候选平稳律) · [WingIt](https://jmlr.org/papers/v25/24-0511.html)

历史刷新链结果考察 $P=(1-r)I+r\mathbf 1\pi$。一个只在单个内部常值游程中出现的标签按其时间占比计入估计，达到 $\Theta(\min\{1,(nr)^{-1}\})$，无需给估计量刷新概率 $r$。潜在独立刷新段的边界可以无法观察，同标签的连续刷新会合并，段长也没有确定上界。历史实验还构造了混合时间为 $2$ 的配对状态链，其中这种内部常值游程统计量具有不消失的均方误差。该反例针对特定统计量。 [刷新链完整证明 S1–S5](#附录-a-刷新链的历史尖锐风险证明) · [配对状态反例](#appendix-c-the-analytic-obstruction-for-the-internal-constant-run-estimator)

有限候选平稳律的旧扩展用候选分布的总变差见证集选择模型。它可在一般混合链中工作，但估计器必须事先获得候选目录。前一轮再生状态稿已经使用全段留一的等价公式，并按段长条件化来控制风险，若已知正游程在中心状态外的长度属于 $J$ 种、不超过 $H_0$，且混合时间至多 $T$，它给出 $\min\{1,C(J+1)(H_0+T)/n\}$。自环每次计作一个短词后，本稿的回返上界取 $H=H_0+1$。这里通过时间截尾与首次出现控制去掉两者，在有界回返类中得到匹配阶。两种结构约束各有适用范围。 有限候选目录 · 前一轮再生稿

## 8. 近邻与复现

固定 iid 块的删除稳定性和更新报酬是既有工具。本文的时间截取分析联合处理长度相关的词内容、随机词数和参与目标的首尾位置。从窗口留一到成对删除的思路已有先例。这里用两个不同的时间前缀保证双删集合包容，并逐词重新编号，把计数与首次出现质量的乘积控制在 $O(H)$。 [Feldman 等，§5](https://arxiv.org/html/2610.41244v1) · [Glynn 和 Henderson，§3](https://web.stanford.edu/~glynn/papers/1998/GH98.pdf) · [WingIt，§7](https://arxiv.org/html/2404.05819v2#S7)

重原子下界承接了 sticky channel 的构造。随机重复模型有与再生词模型相交的特例，该会议论文只获得摘要，故相关估计量和特殊情形的对照仍受全文可得性限制。第 6 节的证明从有限有界回返链直接建立下界。以下附录自含记录历史刷新链、一般链下界和有限候选保证，并证明常值游程统计量的范围反例。 [Sticky channel 原文](https://arxiv.org/pdf/2202.02772) · [随机重复会议摘要](https://cmsworkshops.com/ISIT2024/view_paper.php?PaperNum=2073) · 查新和访问范围

精确有限核验覆盖确定周期、同词长分布但不同标签关系，以及标签过程非 Markov 的例子。枚举检验了样本端点、双删条件中心化和值域比较，定理证明适用任意样本长度和模型类中的全部分布。 [复现方法和结果](evidence/README.md)

## 附录 A. 刷新链的历史尖锐风险证明

### A.1 冻结问题、刷新子类与随机目标

原问题考察有限、不可约、非周期、从平稳分布开始的马尔可夫链。记其平稳分布为 $\pi$，最坏初态的总变差混合时间为

$$
T_{\mathrm{mix}}
=\min\left\{t\ge1:
  \max_x\|P^t(x,\cdot)-\pi\|_{\mathrm{TV}}\le\tfrac14
\right\}.
$$

令 $\mathcal P_T$ 为满足 $T_{\mathrm{mix}}\le T$ 的上述链的集合，其中已知整数 $T\ge1$，状态空间大小不受统一限制。观察平稳轨迹 $X^n=(X_1,\ldots,X_n)$，目标为该条轨迹的**随机平稳缺失质量**

$$
M_\pi(X^n)=
\sum_x\pi_x\mathbf1\{x\notin\{X_1,\ldots,X_n\}\}.
$$

所研究的 minimax 风险是

$$
R_{n,T}
=\inf_{\widehat M}\sup_{P\in\mathcal P_T}
\mathbb E_P\!\left[
  \bigl(\widehat M(X^n,T)-M_\pi(X^n)\bigr)^2
\right].
$$

估计器可以随机化。本项目没有得到该一般类别的统一 $O(\min\{1,T/n\})$ 上界，也没有证明必须付出额外对数因子。已完成的主要子类分析针对**刷新链**

$$
P=(1-r)I+r\mathbf1\pi,\qquad
X_1\sim\pi,\qquad 0<r\le1,\quad n\ge1.
$$

即每一步以概率 $1-r$ 保持原标签，以概率 $r$ 从 $\pi$ 独立抽取新标签；一次刷新也可能抽回原标签。S1 允许任意有限概率向量 $\pi$，包括零坐标。从平稳分布出发，零质量状态不影响轨迹或目标。与不可约混合链类别比较时，则在正质量状态空间上讨论。

### A.2 可观测估计器与主要结果

称一段极大的、非空的连续相同标签为一个**游程**（run）。若一个游程不接触观察位置 $1$ 或 $n$，称其为内部游程。对每个标签 $x$，记 $N_x$ 为它在整条观测轨迹中的出现总次数，$J_x$ 为它的游程总数。定义

$$
\boxed{
\widehat M_{\mathrm{int}}(X^n)
=\frac1n\sum_xN_x
  \mathbf1\{J_x=1,\ X_1\ne x,\ X_n\ne x\}.
}
\tag{A1}
$$

这等于把“标签只在一个内部游程中出现”的所有游程长度相加，再除以原轨迹长度 $n$。估计器仅使用可观测标签，不需要 $\pi$、状态数、刷新率或隐藏刷新时刻。它取值于 $[0,1]$，在常数轨迹上输出零。在字典操作为常数时间的条件下，可用一次扫描完成计数及游程计数，算术工作量为 $O(n)$，存储量与实际观察到的不同标签数成正比。这项计算性质本身不提供一般链的风险保证。

#### 定理 S1：对未知刷新率的自适应上界

对任意有限 $\pi$、$n\ge1$ 及 $0<r\le1$，同一个估计器 (A1) 满足

$$
\begin{aligned}
\mathbb E_{\pi,r}
  \bigl(\widehat M_{\mathrm{int}}-M_\pi(X^n)\bigr)^2
&\le
\min\left\{1,\frac{29}{2}
                 \frac{1-(1-r)^n}{nr}\right\}\\
&\le
\min\left\{1,\frac{29}{2nr}\right\}.
\end{aligned}
\tag{A2}
$$

这里没有先估计 $r$ 再代入的步骤；同一统计量同时适用于全部正刷新率。不宣称常数 $29/2$ 最优。

#### 定理 S2：固定刷新率下的匹配下界

固定任意 $0<r\le1$，即使允许估计器知道 $r$，在所有有限严格正概率向量上取上确界，仍有

$$
\inf_{\widehat M}\sup_\pi
\mathbb E_{\pi,r}
  \bigl(\widehat M-M_\pi(X^n)\bigr)^2
\ge\frac1{1024\{1+(n-1)r\}}
\ge\frac1{2048}\min\{1,(nr)^{-1}\}.
\tag{A3}
$$

因此，刷新链子类内的 minimax 阶为
$\min\{1,(nr)^{-1}\}$，且 (A1) 在不知道 $r$ 时达到这个阶。这一结论的范围不能扩大到任意混合马尔可夫链。

### A.3 已有文献与实际查阅边界

刷新模型、平稳缺失质量目标以及“重原子加均匀云”的下界模型都已有先例。[CTR22] 直接研究几何 sticky channel 中的相同目标，其记号满足 $r=1-\alpha$。其已知刷新率的修正单现统计量所展示的上界含有

$$
\frac1{(n-2)r}
\left[3+\frac1r\left(1+\frac1n\right)\right]+O(1/n).
$$

该展示式按来源自身的适用范围理解，不将其 $O(1/n)$ 余项解释为未经证明的全参数统一界。其未知参数代入方法得到模拟和小原子条件下启发式分析的支持。本稿可供后续查新评估的候选增量，是特定无参数**内部游程时间占比**统计量的显式统一 $1/(nr)$ 保证，以及覆盖全部样本区间的下界处理；不能把模型、游程思想或重原子构造本身计为新贡献。

[FMS09] 已研究 sticky channel 的游程方法和 EM 分布估计。实际取得的作者上传文本介绍了对交替标签序列使用 Good–Turing 的做法；该统计量按游程数归一化，与 (A1) 的原始时间长度归一化不同。但是，所读文本存在 OCR 和分栏问题，不能声称已逐项排除该论文全部算法。[FSM12] 的原始 PDF 已查阅，其主要定理目标包括交替链的模式冗余与源分布恢复。[CT24] 研究 Bernoulli 重复下的缺失质量；本项目只取得官方会议摘要，未取得其完整证明。这些访问限制意味着目前的比较不足以证明全球优先权。

[PMT24] 给出一般马尔可夫链的含对数因子保证。[NMP26] 对确定性的 next-token 泛函给出尖锐 $T/n$ 阶；这里的 S1–S5 估计已实现轨迹的随机平稳缺失质量，不能直接移用那个确定性目标的结论。以下 S1–S5 的论证自含，不依赖这种目标替换。

### A.4 固定观察时限下的潜在刷新表示

预生成彼此独立的
$B_2,\ldots,B_n\sim\mathrm{Bernoulli}(r)$，并独立生成无限 iid 标签序列
$Y_1,Y_2,\ldots\sim\pi$。从 $Y_1$ 开始；在位置 $t$ 若 $B_t=1$，就移动到下一个潜在标签，否则保持当前标签。所得观测轨迹恰有附录 A.1的转移核和平稳初始分布。

潜在段数为

$$
K=1+\sum_{t=2}^nB_t
  \sim1+\mathrm{Bin}(n-1,r).
$$

**只对满足 $\Pr(K=k)>0$ 的 $k$ 条件化。** 给定 $K=k$，每个含 $k-1$ 个切点的集合具有相同概率
$r^{k-1}(1-r)^{n-k}$，故切点是在 $\{2,\ldots,n\}$ 中均匀选择的 $k-1$ 元子集。因此潜在段长向量 $(L_1,\ldots,L_k)$ 均匀分布于

$$
\{(l_1,\ldots,l_k)\in\mathbb N^k:
  l_j\ge1,\ \sum_{j=1}^kl_j=n\},
$$

即 $n$ 的 $k$ 部分有序正整数分拆；并且段长向量与
$(Y_1,\ldots,Y_k)$ 独立。这里包括被固定观察时限截断的最后一段。给定总时限和段数之后，不能把这些段长当作相互独立的几何随机变量。

当 $r=1$ 时，只有 $k=n$ 有正概率。以下有关 $K=k$ 的条件式均遵守上述支持集限制；关于均匀有序分拆本身的恒等式，则是为每一组 $1\le k\le n$ 单独定义的辅助实验。

相邻潜在标签相同，会使若干潜在段合并为一个可观测游程。不过，因为每段长度严格为正，对每个实现都有

$$
\{X_1,\ldots,X_n\}=\{Y_1,\ldots,Y_K\}.
\tag{A4}
$$

于是 $M_\pi(X^n)=M_\pi(Y^K)$ 是**同一个实现上的精确相等**，而不仅仅是期望相等。这是后续处理随机目标的依据。

### A.5 引理 S3：iid Good–Turing 风险的自含界

对 $k\ge1$ 个服从 $\pi$ 的 iid 标签，记

$$
G_k=\frac1k\sum_x\mathbf1\{N_x(Y^k)=1\},
\qquad
M_k=\sum_x\pi_x\mathbf1\{N_x(Y^k)=0\}.
$$

则

$$
\mathbb E(G_k-M_k)^2\le\frac3k.
$$

**证明。** 当 $k\le3$ 时，两变量都在 $[0,1]$，故平方误差至多 $1\le3/k$。以下设 $k\ge4$，并令

$$
A_x=\frac1k\mathbf1\{N_x=1\}
       -\pi_x\mathbf1\{N_x=0\}.
$$

对角项为

$$
\begin{aligned}
\sum_x\mathbb EA_x^2
&=\frac1k\sum_x\pi_x(1-\pi_x)^{k-1}
  +\sum_x\pi_x^2(1-\pi_x)^k\\
&\le\frac2k.
\end{aligned}
\tag{A5}
$$

第一项至多 $1/k$。对第二项，二项分布恰好一次成功的概率
$kp(1-p)^{k-1}\le1$，从而
$p(1-p)^k\le1/k$；乘以 $\pi_x$ 后求和即得所需界。

对不同标签 $x,y$，令 $u=\pi_x+\pi_y$。逐项使用多项分布概率，得到

$$
\begin{aligned}
\mathbb EA_xA_y
&=\pi_x\pi_y\left[
  \frac{k-1}{k}(1-u)^{k-2}
  -2(1-u)^{k-1}
  +(1-u)^k\right]\\
&=\pi_x\pi_y(1-u)^{k-2}
  \left(u^2-\frac1k\right).
\end{aligned}
\tag{A6}
$$

这里未假定不同标签的计数独立。二项分布恰好两次成功的概率给出

$$
u^2(1-u)^{k-2}
\le\binom{k}{2}^{-1}
=\frac2{k(k-1)}
\le\frac4{k^2}.
$$

丢弃 (A6) 中的负项，再对有序的不同标签对求和，并使用
$\sum_{x\ne y}\pi_x\pi_y\le1$，交叉项总和至多 $4/k^2$。当 $k\ge4$ 时，
$2/k+4/k^2\le3/k$，结论成立。\(\blacksquare\)

S3 是经典 iid 事实的宽松重推，不单独作为新贡献。

### A.6 潜在时间加权单现统计量与引理 S4

对正概率的 $K=k$，定义仅用于证明的比较统计量

$$
S=\frac1n\sum_{j=1}^k
L_j\mathbf1\{Y_j\text{ 在 }Y^k\text{ 中恰好出现一次}\}.
\tag{A7}
$$

$S$ 不可直接观测，但最终估计器 (A1) 不使用它，也不需要隐藏刷新时刻。

#### 引理 S4：均匀有序正整数分拆的矩

设 $L$ 是 $n$ 的 $k$ 部分均匀有序正整数分拆。则
$\mathbb EL_j=n/k$。当 $k\ge2$ 时，

$$
\operatorname{Var}(L_j)
=\frac{n(n-k)(k-1)}{k^2(k+1)},
\qquad
\operatorname{Cov}(L_i,L_j)
=-\frac{n(n-k)}{k^2(k+1)}
\quad(i\ne j).
\tag{A8}
$$

**证明。** 令 $U_j=L_j-1$、$N=n-k$。非负整数解
$\sum_jU_j=N$ 共有
$\binom{N+k-1}{k-1}$ 个。利用生成函数

$$
\sum_{u\ge0}z^u=(1-z)^{-1},\quad
\sum_{u\ge0}u z^u=z(1-z)^{-2},\quad
\sum_{u\ge0}u(u-1)z^u=2z^2(1-z)^{-3},
$$

提取相应系数并除以总个数，得到

$$
\mathbb EU_1=\frac Nk,\qquad
\mathbb E[U_1(U_1-1)]
=\frac{2N(N-1)}{k(k+1)},\qquad
\mathbb EU_1U_2
=\frac{N(N-1)}{k(k+1)}.
$$

例如，后两项的未归一化系数分别为
$2\binom{N+k-1}{k+1}$ 和
$\binom{N+k-1}{k+1}$（$N\ge2$）。当 $N=0$ 或 $1$ 时，相应阶乘矩为零，上述矩公式仍成立。用
$\mathbb EU_1^2=\mathbb E[U_1(U_1-1)]+\mathbb EU_1$
并减去均值乘积，即得 (A8)。当 $k=1$ 时，$L_1=n$ 是确定的，另行处理即可。\(\blacksquare\)

给定潜在标签，令 $a=\Phi_1(Y^k)$，也就是单现标签的位置数。由于段长与标签独立，

$$
\mathbb E_LS=\frac ak=G_k.
$$

当 $k\ge2$ 时，用 (A8) 对这 $a$ 个位置的段长求和，得到

$$
\begin{aligned}
\operatorname{Var}_L(S)
&=\frac1{n^2}\left[
 a\operatorname{Var}(L_1)
 +a(a-1)\operatorname{Cov}(L_1,L_2)\right]\\
&=\frac{(n-k)a(k-a)}{n k^2(k+1)}
\le\frac1{4(k+1)}.
\end{aligned}
\tag{A9}
$$

最后一步使用 $a(k-a)\le k^2/4$ 和 $n-k\le n$。当 $k=1$ 时，段长方差为零，同一上界有效。

由于 $M_k$ 只依赖标签，先对段长使用条件方差分解，再对标签取期望，并应用 S3，可得

$$
\begin{aligned}
\mathbb E[(S-M_k)^2\mid K=k]
&=\mathbb E\!\left[
  \operatorname{Var}_L(S)+(G_k-M_k)^2
  \mid K=k\right]\\
&\le\frac1{4(k+1)}+\frac3k
\le\frac{13}{4k}.
\end{aligned}
\tag{A10}
$$

此处的负协方差来自固定总长度；整个论证没有把段长当作独立随机变量。

### A.7 引理 S5：边界删除与隐藏合并误差

对每个满足 $\Pr(K=k)>0$ 的 $1\le k\le n$，

$$
\mathbb E[
 |\widehat M_{\mathrm{int}}-S|
 \mid K=k]\le\frac4k.
\tag{A11}
$$

**证明。** 在同一组潜在标签和段长上比较两个统计量。

首先，若一个潜在标签只出现一次，而且位于位置
$j\in\{2,\ldots,k-1\}$，则它在两个统计量中贡献相同的时间占比。若这个唯一出现的位置为 $1$ 或 $k$，它被 $S$ 计入，但被可观测估计器删除。删除总权重不超过
$(L_1+L_k)/n$，条件期望不超过 $2/k$。当 $k=1$ 时，右侧把同一段重复计算，只会放宽上界。

其次，若一个标签被可观测估计器计入，却未被 $S$ 计入，则它在潜在序列中出现了 $\ell\ge2$ 次，而且**全部出现位置恰好构成一个内部连续区间**。这穷尽了其他差额：若其潜在出现位置分成两个或更多游程，由于每段长度都为正，中间的不同标签不会消失，所以观测中也不可能只剩一个游程。

给定 $N_x(Y^k)=\ell$ 且该条件具有正概率，标签 $x$ 的出现位置均匀分布在所有 $\ell$ 元子集上。若 $2\le\ell\le k-2$，长度为 $\ell$ 的内部连续区间恰有 $k-\ell-1$ 个，因此

$$
\Pr(\text{全部出现位置构成一个内部游程}\mid N_x=\ell)
=\frac{k-\ell-1}{\binom{k}{\ell}}
\le\frac2k.
\tag{A12}
$$

该不等式使用
$\binom{k}{\ell}\ge\binom{k}{2}$ 及
$k-\ell-1\le k-1$。当 $\ell=k-1$ 或 $k$ 时，不存在这样的内部区间；当 $k\le3$ 时，全部相关的非单现内部事件均为空。零概率的计数条件无需使用。

按标签计数加权并求和，额外游程所覆盖的潜在位置数的期望满足

$$
\sum_x\mathbb E\!\left[
 N_x\mathbf1\{N_x\ge2,\ \text{全部出现构成一个内部游程}\}
\right]
\le\frac2k\sum_x\mathbb EN_x=2.
\tag{A13}
$$

给定标签后，任意 $b$ 个选中潜在位置的期望时间占比为 $b/k$，因为段长独立于标签，且各段的期望长度均为 $n/k$。于是额外时间占比的条件期望至多 $2/k$。将删除权重和额外权重相加，再用三角不等式，得到 (A11)。\(\blacksquare\)

删除边界游程是实质性修正。若使用把边界也计入的未修正统计量，在 iid 情形取
$\pi=(1-n^{-2},n^{-2})$。全为重标签的常数轨迹概率是
$(1-n^{-2})^n$；在这条轨迹上，未修正统计量为 $1$，目标为 $n^{-2}$。其风险至少为
$(1-n^{-2})^{n+2}\to1$。修正后的 (A1) 在该轨迹上输出零。这个例子只否定未修正统计量，不是全体估计器的 minimax 下界。

### A.8 定理 S1 的完整风险合成

$S$ 和 $\widehat M_{\mathrm{int}}$ 都在 $[0,1]$，因此
$(\widehat M_{\mathrm{int}}-S)^2
\le|\widehat M_{\mathrm{int}}-S|$。
由同路径目标恒等式 (A4)、(A10)、(A11)，以及
$(a+b)^2\le2a^2+2b^2$，对每个正概率的 $K=k$，

$$
\begin{aligned}
&\mathbb E[
 (\widehat M_{\mathrm{int}}-M_\pi(X^n))^2
 \mid K=k]\\
&\quad\le
2\mathbb E[(S-M_k)^2\mid K=k]
 +2\mathbb E[(\widehat M_{\mathrm{int}}-S)^2\mid K=k]\\
&\quad\le\frac{13}{2k}+\frac8k
=\frac{29}{2k}.
\end{aligned}
\tag{A14}
$$

对 $K=1+\mathrm{Bin}(n-1,r)$，有精确恒等式

$$
\begin{aligned}
\mathbb E\frac1K
&=\sum_{j=0}^{n-1}
  \frac1{j+1}\binom{n-1}{j}
  r^j(1-r)^{n-1-j}\\
&=\frac1{nr}\sum_{\ell=1}^n
  \binom n\ell r^\ell(1-r)^{n-\ell}\\
&=\frac{1-(1-r)^n}{nr}.
\end{aligned}
\tag{A15}
$$

第二行使用
$\binom{n-1}{j}/(j+1)=\binom n{j+1}/n$，并且 $r>0$。仅对正概率的条件值平均 (A14)，得到 (A2) 的非平凡上界。再结合平方误差至多 $1$ 以及
$1-(1-r)^n\le1$，即得 S1。\(\blacksquare\)

当 $n=1$ 时，$K=1$，观察中没有内部游程；上述恒等式和截断风险界仍有效。当 $r=1$ 时，只需 $K=n$ 的条件论证，不涉及零概率条件。单点分布的目标和估计器均为零。本文不把含 $1/r$ 的公式直接写到 $r=0$。

### A.9 定理 S2：共同事件上的同路径下界

这里完整展开英文稿引用的首轮 B1 论证；来源为
[lower_bound_round1.md](#附录-b-一般链下界固定函数方差和有限候选平稳律) 的 §§2.2–2.4。

#### A.9.1 两个有限平稳模型

给定固定的 $r$，令

$$
m=1+(n-1)r,\qquad L=2n,\qquad
\delta=\frac1{4\sqrt m}.
$$

在同一有限状态空间 $\{0,1,\ldots,L\}$ 上取

$$
\begin{aligned}
\pi_0(0)&=\tfrac12,
&\pi_0(j)&=\frac1{2L}\quad(1\le j\le L),\\
\pi_1(0)&=\tfrac12+\delta,
&\pi_1(j)&=\frac{\tfrac12-\delta}{L}
                  \quad(1\le j\le L).
\end{aligned}
$$

因为 $m\ge1$，所以 $0<\delta\le1/4$，两概率向量严格为正。两模型均使用给定的同一个刷新率：

$$
P_i=(1-r)I+r\mathbf1\pi_i,\qquad X_1\sim\pi_i.
$$

两链均不可约、非周期且平稳开始。

#### A.9.2 同一条路径上的随机目标分离

令共同事件 $E=\{X_1=0\}$。对一条固定路径 $x^n\in E$，令
$D(x^n)$ 为其中出现的不同非零标签数。重标签已经观察到，所以

$$
M_{\pi_0}(x^n)
=\tfrac12\left(1-\frac{D(x^n)}L\right),\qquad
M_{\pi_1}(x^n)
=(\tfrac12-\delta)
 \left(1-\frac{D(x^n)}L\right).
$$

由于 $D(x^n)\le n-1\le L/2$，在同一条路径上，

$$
|M_{\pi_0}(x^n)-M_{\pi_1}(x^n)|
=\delta\left(1-\frac{D(x^n)}L\right)
\ge\frac\delta2.
$$

这里没有比较两条独立轨迹的目标，也没有把目标换成其期望。

#### A.9.3 从条件观测重叠返回原始平稳实验

记 $Q_i$ 为给定 $E$ 后的路径律，此时两条条件路径都从标签 $0$ 开始。其后续转移可以由独立创新变量
$W_t\in\{\bot\}\cup\{0,\ldots,L\}$ 生成：

$$
\Pr_i(W_t=\bot)=1-r,\qquad
\Pr_i(W_t=j)=r\pi_i(j),\quad 2\le t\le n.
$$

遇到 $\bot$ 则保持原状态，否则改为 $W_t$。这是两个模型共同的确定性路径映射。单次创新的 KL 散度为
$rD_{\mathrm{KL}}(\pi_0\Vert\pi_1)$，故由独立乘积分布的 KL 可加性和数据处理不等式，

$$
D_{\mathrm{KL}}(Q_0\Vert Q_1)
\le(n-1)rD_{\mathrm{KL}}(\pi_0\Vert\pi_1).
$$

直接计算得到

$$
D_{\mathrm{KL}}(\pi_0\Vert\pi_1)
=-\tfrac12\log(1-4\delta^2)
\le4\delta^2.
$$

最后一步可用
$-\log(1-u)\le u/(1-u)$，其中
$u=4\delta^2\le1/4$。于是

$$
D_{\mathrm{KL}}(Q_0\Vert Q_1)
\le\frac{m-1}{4m}\le\tfrac14,
\qquad
\|Q_0-Q_1\|_{\mathrm{TV}}
\le\sqrt{1/8}\le\tfrac12.
$$

总变差界使用 Pinsker 不等式。当 $n=1$ 时，没有后续创新，两个条件律都是集中于单点路径 $(0)$ 的分布，以上界仍成立。

令 $p_i(x^n)$ 表示**原始平稳实验**中的无条件路径概率。因为
$\pi_0(0)=1/2$、$\pi_1(0)\ge1/2$，共同事件上的重叠质量满足

$$
\begin{aligned}
A_E
&:=\sum_{x^n\in E}\min\{p_0(x^n),p_1(x^n)\}\\
&\ge\frac12\sum_{x^n\in E}
     \min\{Q_0(x^n),Q_1(x^n)\}\\
&=\frac12\left(1-\|Q_0-Q_1\|_{\mathrm{TV}}\right)
\ge\frac14.
\end{aligned}
$$

这一步提供原始平稳实验的重叠下界，并不声称从状态 $0$ 开始的条件实验本身是平稳实验。

#### A.9.4 平方损失归约与常数

对任意实数 $a,u,v$，

$$
(a-u)^2+(a-v)^2\ge\frac12(u-v)^2.
$$

在每条相同观测路径上令 $a$ 为同一个估计值，
$u=M_{\pi_0}(x^n)$、$v=M_{\pi_1}(x^n)$。
以共同事件上的 $\min\{p_0,p_1\}$ 为权重求和。记两个模型下的风险为 $R_0,R_1$，则

$$
\begin{aligned}
\max(R_0,R_1)
&\ge\tfrac12(R_0+R_1)\\
&\ge\frac14\sum_{x^n\in E}
 \min\{p_0(x^n),p_1(x^n)\}
 \{M_{\pi_0}(x^n)-M_{\pi_1}(x^n)\}^2\\
&\ge\frac14\cdot\frac14\cdot\frac{\delta^2}{4}
=\frac{\delta^2}{64}
=\frac1{1024m}.
\end{aligned}
$$

若估计器随机化，先在两个实验下附加同分布、独立于数据的共同随机种子，再对每个种子使用同一逐路径不等式并积分即可。由于两个候选模型的 $r$ 完全相同，允许知道 $r$ 不改变该下界实验。

最后，
$$
m=1+(n-1)r\le1+nr\le2\max\{1,nr\},
$$
给出 (A3) 的第二个不等式。S2 得证。\(\blacksquare\)

### A.10 刷新子类内与混合时间的关系

对至少含两个状态的不可约刷新链，

$$
\begin{aligned}
d(T)
&:=\max_x\|P^T(x,\cdot)-\pi\|_{\mathrm{TV}}\\
&=(1-r)^T(1-\min_x\pi_x)
\ge\tfrac12(1-r)^T.
\end{aligned}
$$

若 $d(T)\le1/4$，则 $(1-r)^T\le1/2$。由整数次幂的 Bernoulli 不等式
$(1-r)^T\ge1-Tr$，得到 $Tr\ge1/2$。S1 因而蕴含

$$
\mathbb E
(\widehat M_{\mathrm{int}}-M_\pi(X^n))^2
\le\min\{1,29T/n\}.
\tag{A16}
$$

单状态链的目标和估计值均为零。附录 B 中命题 B1 的两个下界模型也属于刷新子类，所以结合 (A16)，可得**刷新子类内**
$\min\{1,T/n\}$ 的尖锐 minimax 阶。一般链的统一上界仍未得到。


## 附录 B. 一般链下界、固定函数方差和有限候选平稳律

仍令 $\mathcal P_T$ 为附录 A.1 中最坏初态总变差 $1/4$ 混合时间至多 $T$ 的有限不可约非周期平稳链。目标是同一条轨迹的随机未见平稳质量。

**命题 B1（一般链的统一下界）。** 对任意整数 $n,T\ge1$，
$$
R_{n,T}\ge \frac1{3072}\min\{1,T/n\}.
$$
取 $r=\min\{1,2/T\}$。若 $T=1,2$，刷新链一步混合。若 $T\ge3$，其从任意初态出发在第 $T$ 步距平稳分布至多 $(1-2/T)^T\le e^{-2}<1/4$，所以附录 A.9 的刷新下界模型都在 $\mathcal P_T$ 内。由 S2 得到 $[1024\{1+(n-1)r\}]^{-1}$，且 $1+(n-1)r\le 3\max\{1,n/T\}$。证毕。

**引理 B2（固定函数的平稳经验平均）。** 任意 $P\in\mathcal P_T$ 与固定可测 $f\colon\mathcal X\to[0,1]$ 满足
$$
\mathrm{Var}\!\left(\frac1n\sum_{i=1}^n f(X_i)\right)\le T/n.
$$
证明。令 $\bar d(t)=\sup_{x,y}\|P^t(x,\cdot)-P^t(y,\cdot)\|_{\rm TV}$。这是核 $P^t$ 的 Dobrushin 系数，对概率测度的总变差收缩系数至多为 $\bar d(t)$。这是因为带符号差测度的正负部分各自归一化为概率测度，再用核行之间的最大总变差距离。因 $\bar d(T)\le1/2$，次乘性给出 $\bar d(t)\le2^{-\lfloor t/T\rfloor}$。对滞后 $t>0$，Markov 性把协方差写成 $\mathrm{Cov}(f(X_i),P^t f(X_i))$。第一项方差至多 $1/4$，第二项值域宽度至多 $\bar d(t)$，方差至多 $\bar d(t)^2/4$，所以协方差绝对值至多 $\bar d(t)/4$。求和得到
$$
\mathrm{Var}\!\left(\frac1n\sum_i f(X_i)\right)
\le\frac1{4n}+\frac1{2n}\sum_{t\ge1}2^{-\lfloor t/T\rfloor}\le T/n.
$$
这里 $f$ 为确定函数，轨迹决定的未见集合指标不能代入当作固定函数。证毕。

**命题 B3（两个已知候选模型）。** 对任意已知的 $P_0,P_1\in\mathcal P_T$，设 $d=\|\pi_0-\pi_1\|_{\rm TV}$。限于这两模型的极小极大风险至多 $\min\{d^2,4T/n\}$。

证明。若 $d=0$，对每条轨迹两目标都相同。若 $d>0$，选确定集合 $B$ 使 $\pi_1(B)-\pi_0(B)=d$。按 $B$ 的经验频率与两个已知平稳均值的中点来选择模型，再用所选模型的平稳律计算完整样本的未见质量。引理 B2 和 Chebyshev 不等式使误选概率至多 $\min\{1,4T/(nd^2)\}$。误选时，同一个未见集合上的两目标之差至多 $d$。两模型的状态空间若不同，可以在共同观测字母表上给各平稳分布补零。证明不要求扩大的转移核不可约。证毕。

**命题 B4（有限候选平稳律）。** 若只给定未知链的平稳律属于同一有限字母表上的已知 $M$ 个候选分布之一，令 $N=1+\lfloor(n-1)/T\rfloor$。存在估计量，均方风险至多
$$
\min\{1,32[1+\log(2M^2)]/N\}.
\tag{B1}
$$

证明。对每对候选 $i,j$，令 $B_{ij}=\{x:\pi_i(x)>\pi_j(x)\}$。正部定义保证 $\pi_i(B_{ij})-\pi_j(B_{ij})=\|\pi_i-\pi_j\|_{\rm TV}$。以间隔 $T$ 取 $N$ 个样本，记各见证集的经验均值为 $v_{ij}$。这个平稳骨架的核为 $P^T$，Dobrushin 系数至多 $1/2$。固定见证集，在依次揭示骨架点时考虑其命中计数的 Doob 鞅。任一次揭示当前值对未标准化计数条件期望的振幅至多 $\sum_{s\ge0}2^{-s}=2$，因为第 $s$ 个未来条件命中概率在当前状态之间至多差 $2^{-s}$。所以每一步鞅差绝对值至多 2。Azuma 不等式给双边尾界 $2e^{-Nu^2/8}$。对全部至多 $M^2$ 个见证集作并合界，真律 $\pi$ 的经验最大误差 $D=\max_{i,j}|v_{ij}-\pi(B_{ij})|$ 满足
$$
\Pr(D>u)\le 2M^2 e^{-Nu^2/8}.
$$

从候选中选使其见证集频率与 $v_{ij}$ 最大差最小者 $\widehat\pi$。真律可用，所以二者在每个见证集上的概率差至多 $2D$。特别是在实现 $\|\widehat\pi-\pi\|_{\rm TV}$ 的那个见证集上成立，因此完整轨迹的任一未见集合上也成立。用 $\widehat\pi$ 计算全样本未见质量，损失至多 $\min\{1,4D^2\}$。对尾界积分，得 $\mathbb E D^2\le (8/N)[1+\log(2M^2)]$，即 (B1)。$M=1$ 时也可直接使用唯一候选。证毕。

B3 与 B4 的估计量使用候选目录。它们不能直接达到未知一般平稳律的总体上界。B2、B3 和 B4 也不需要本文主定理的可观测再生结构。


## Appendix C. The analytic obstruction for the internal constant-run estimator

### C.1 Statement

For a path $x^n$, let $\widehat R_n(x^n)$ be the total fraction of observations belonging to maximal contiguous runs that satisfy both conditions:

1. the run touches neither endpoint of the observed path;
2. its label appears in no other run anywhere in the path.

Thus $\widehat R_n$ is the interior unique-run estimator considered in the refreshing-chain auxiliary result. Let

$$
 \widehat G_n=\frac{\Phi_1(X^n)}n
$$

be the classical Good--Turing statistic.

#### Proposition C1

For every $n\ge3$, put $K=K_n=\lceil n/2\rceil$. There is a stationary, irreducible, aperiodic chain on $2K$ states whose worst-start TV mixing time at threshold $1/4$ is exactly 2 and for which

$$
 \begin{aligned}
 \mathbb E M_\pi(X^n)&\longrightarrow e^{-3/4},\\
 \mathbb E\widehat G_n&\longrightarrow\frac9{16}e^{-3/4},\\
 \mathbb E\widehat R_n&\longrightarrow\frac9{16}e^{-3/4}.
 \end{aligned}
$$

Consequently,

$$
 \boxed{\liminf_{n\to\infty}
   \mathbb E(\widehat R_n-M_\pi(X^n))^2
   \ge \frac{49}{256}e^{-3/2}
   \approx0.0427085072.}
$$

The state space is allowed to grow with $n$, as in the frozen minimax model. The proposition therefore disproves **uniform consistency over the class with mixing time at most 2** for this estimator. It does not assert failure of consistency along a single fixed finite chain.

### C.2 Chain construction and exact mixing calculation

Partition the alphabet $\{0,1,\ldots,2K-1\}$ into the pairs

$$
 \{0,1\},\{2,3\},\ldots,\{2K-2,2K-1\}.
$$

Let $A$ deterministically exchange the two labels in every pair, let $\pi$ be uniform on the alphabet, and let $\Pi=\mathbf1\pi$. Define

$$
 P=(1-r)A+r\Pi,\qquad r=\tfrac12,
 \qquad X_1\sim\pi.
$$

The entries of $P$ are at least $r/(2K)>0$, so the chain is irreducible and aperiodic. The permutation $A$ preserves $\pi$, giving $\pi P=\pi$. It also satisfies

$$
 A\Pi=\Pi A=\Pi,\qquad\Pi^2=\Pi.
$$

It follows by induction that

$$
 P^t=(1-r)^t A^t+\{1-(1-r)^t\}\Pi.
$$

Since $A^t(x,\cdot)$ is a point mass,

$$
 \max_x\|P^t(x,\cdot)-\pi\|_{\rm TV}
  =(1-r)^t\left(1-\frac1{2K}\right).
$$

For $r=1/2$ and $K\ge2$, this is greater than $1/4$ at $t=1$ and less than $1/4$ at $t=2$. Thus the mixing time is exactly 2. Both $A$ and $\Pi$ are symmetric matrices, so this stationary chain is reversible as well.

### C.3 A two-state killed matrix

The following calculation is valid for fixed $r\in(0,1)$; the proposition then takes $r=1/2$. Write

$$
 u=\frac1{2K},\qquad a=r(2-r).
$$

Fix a target label $x$, and kill the chain upon hitting $x$. Among the remaining states, distinguish its paired label $\bar x$ from all other labels. The total transition probabilities into these two classes are identical from every state in the second class. Hence the killed chain has the exact aggregated matrix

$$
 Q_K=
 \begin{pmatrix}
 ru&r(1-2u)\\
 ru&1-2ru
 \end{pmatrix}.
$$

For example, from $\bar x$ the deterministic move goes to the killed state $x$; from an unrelated label the deterministic move stays among unrelated labels. This gives both rows directly. In the original $K$-notation,

$$
 Q_K=
 \begin{pmatrix}
 r/(2K)&r(1-1/K)\\
 r/(2K)&1-r/K
 \end{pmatrix}.
$$

Its trace and determinant are

$$
 \operatorname{tr}Q_K=1-ru,
 \qquad\det Q_K=ru(1-r).
$$

Let its two eigenvalues be $\lambda_K>\mu_K$. For $K\ge2$ and $r\in(0,1)$, the positive off-diagonal entries make the roots distinct, and the positive determinant and strictly substochastic row sums give

$$
 0<\mu_K<\lambda_K<1.
$$

Explicitly,

$$
 \lambda_K,\mu_K
  =\frac{1-ru\ \pm\sqrt{(1-ru)^2-4ru(1-r)}}2.
$$

Expansion at $u=0$ gives

$$
 \lambda_K=1-au+O(u^2),\qquad
 \mu_K=r(1-r)u+O(u^2),\qquad
 \lambda_K-\mu_K\longrightarrow1.
$$

With $K=\lceil n/2\rceil$, we have $nu\to1$ and $nu^2\to0$. Therefore, for each fixed integer $c$,

$$
 \lambda_K^{n-c}\longrightarrow e^{-a},\qquad
 \mu_K^{n-c}\longrightarrow0.
$$

These follow, for example, from $\log\lambda_K=-au+O(u^2)$. All occurrences of asymptotic notation here keep $r$ fixed.

### C.4 Expected random missing mass

For the fixed chain with $K$ pairs, define

$$
 g_K(m)=\Pr_\pi(X_1\ne x,\ldots,X_m\ne x),\qquad m\ge1.
$$

The initial subprobability vector on the two surviving classes is $w=(u,1-2u)$, so

$$
 g_K(m)=wQ_K^{m-1}\mathbf1.
$$

In particular,

$$
 g_K(1)=1-u,\qquad g_K(2)=1-2u+ru^2.
$$

Since the eigenvalues are distinct, there are exact coefficients

$$
 \begin{aligned}
 B_K&=\frac{g_K(2)-\mu_Kg_K(1)}{\lambda_K-\mu_K},\\
 E_K&=\frac{\lambda_Kg_K(1)-g_K(2)}{\lambda_K-\mu_K}
 \end{aligned}
$$

such that

$$
 g_K(m)=B_K\lambda_K^{m-1}+E_K\mu_K^{m-1}.
$$

The preceding formulas show $B_K\to1$ and $E_K\to0$. By the symmetry among labels and the uniform stationary masses,

$$
 \mathbb E M_\pi(X^n)
 =\sum_x\frac1{2K}\Pr_\pi(x\notin X^n)
 =g_K(n)\longrightarrow e^{-a}.
$$

The target in this display is still the random missing mass of the actual trajectory. Computing its expectation is one step in the later squared-risk lower bound for the particular estimator.

### C.5 Expected singleton statistic, with the short-time endpoints retained

Define the no-return probability from $x$ by

$$
 f_K(0)=1,\qquad
 f_K(m)=\Pr_x(X_1\ne x,\ldots,X_m\ne x),\quad m\ge1,
$$

where the initial state at time 0 is $x$. The first-step subprobability vector on the two surviving classes is

$$
 v=(1-r+ru,\;r(1-2u)).
$$

Thus

$$
 f_K(m)=vQ_K^{m-1}\mathbf1\quad(m\ge1),
$$

and direct multiplication gives

$$
 f_K(1)=1-ru,\qquad
 f_K(2)=a-r(3-r)u+r^2u^2.
$$

Introduce the exact coefficients

$$
 C_K=\frac{f_K(2)-\mu_K f_K(1)}{\lambda_K-\mu_K},
 \qquad
 D_K=\frac{\lambda_K f_K(1)-f_K(2)}{\lambda_K-\mu_K}.
$$

Then, for every $m\ge1$,

$$
 f_K(m)=C_K\lambda_K^{m-1}+D_K\mu_K^{m-1},
 \qquad C_K\to a,\quad D_K\to1-a.
$$

The second term must not be omitted when $m=1$: indeed $f_K(1)\to1$, whereas $a<1$. The separate value $f_K(0)=1$ must also be retained at the sample endpoints.

Conditioning on $X_i=x$, the past and future are independent. Reversibility makes their no-return probabilities equal to the forward probabilities just defined. Therefore,

$$
 \Pr(X_i\text{ occurs exactly once in }X^n)
   =f_K(i-1)f_K(n-i),
$$

and hence

$$
 \mathbb E\widehat G_n
   =\frac1n\sum_{i=1}^n f_K(i-1)f_K(n-i).
$$

For $n\ge3$, substituting the exact two-root representation gives

$$
 \begin{aligned}
 \mathbb E\widehat G_n
 ={}&\frac{n-2}{n}
   \left(C_K^2\lambda_K^{n-3}+D_K^2\mu_K^{n-3}\right)\\
 &+\frac{2C_KD_K}{n}
   \frac{\lambda_K^{n-2}-\mu_K^{n-2}}{\lambda_K-\mu_K}\\
 &+\frac2n\left(C_K\lambda_K^{n-2}+D_K\mu_K^{n-2}\right).
 \end{aligned}
$$

The last line is exactly the contribution of the two sample endpoints. The middle line sums the two geometric cross terms. In the limit, these lines vanish, as does the term with $\mu_K^{n-3}$. The remaining term yields

$$
 \mathbb E\widehat G_n\longrightarrow a^2e^{-a}.
$$

For completeness, the short-length formulas excluded from this display are $\mathbb E\widehat G_1=1$ and $\mathbb E\widehat G_2=f_K(1)$; they are not needed for the asymptotic proposition.

### C.6 A pathwise comparison between the two observable statistics

For any sample path, let

$$
 H(x^n)=\sum_{i=1}^{n-1}\mathbf1\{x_i=x_{i+1}\}
$$

be the number of adjacent equalities. A label with exactly one occurrence contributes $1/n$ to both statistics unless that occurrence is at a sample endpoint. At most two such singleton contributions are deleted by $\widehat R_n$.

Every positive contribution to $\widehat R_n-\widehat G_n$ comes from an interior unique run of length $\ell\ge2$. Its contribution is $\ell/n$, and

$$
 \ell\le2(\ell-1).
$$

Such a run contains $\ell-1$ adjacent equalities. Summing over the contributing runs gives the pathwise bound

$$
 \boxed{\left|\widehat R_n(x^n)-\widehat G_n(x^n)\right|
       \le\frac2n+\frac2nH(x^n).}
$$

For the chain constructed above, $A$ has no fixed points, so

$$
 P(x,x)=ru=\frac r{2K},\qquad
 \mathbb EH(X^n)=(n-1)ru.
$$

Consequently,

$$
 \mathbb E|\widehat R_n-\widehat G_n|
 \le\frac2n+\frac{2(n-1)}nru
 \le\frac2n+\frac rK\longrightarrow0.
$$

Thus $\mathbb E\widehat R_n\to a^2e^{-a}$. Combining this with the missing-mass expectation gives

$$
 \mathbb E(\widehat R_n-M_\pi(X^n))
   \longrightarrow -(1-a^2)e^{-a}.
$$

Applying $\mathbb EZ^2\ge(\mathbb EZ)^2$ to the estimation error itself proves

$$
 \liminf_n\mathbb E(\widehat R_n-M_\pi(X^n))^2
       \ge(1-a^2)^2e^{-2a}.
$$

At $r=1/2$, $a=3/4$, so this is exactly $(49/256)e^{-3/2}$, as stated.


## 参考文献与访问说明

- **[BE02]** O. Bousquet, A. Elisseeff. *Stability and Generalization*. JMLR 2, 499–526, 2002。[原始 PDF](https://www.jmlr.org/papers/volume2/bousquet02a/bousquet02a.pdf)。已核查 Definition 3 与 Lemma 9 式 (9)，并核对其在独立随机测度块上的删除稳定性应用。
- **[FMS09]** F. Farnoud, O. Milenkovic, N. P. Santhanam. *Small-Sample Distribution Estimation over Sticky Channels*. ISIT 2009, 1125–1129. [DOI: 10.1109/ISIT.2009.5206020](https://doi.org/10.1109/ISIT.2009.5206020)。已核查官方书目及[作者上传的部分文本](https://www.researchgate.net/publication/224578889_Small-Sample_Distribution_Estimation_Over_Sticky_Channels)；OCR 和分栏存在缺损，不声称核验全部全文结果。
- **[FSM12]** F. Farnoud, N. P. Santhanam, O. Milenkovic. *Alternating Markov Chains for Distribution Estimation in the Presence of Errors*. ISIT 2012, 2017–2021. [arXiv:1202.0925](https://arxiv.org/abs/1202.0925)；[DOI: 10.1109/ISIT.2012.6283684](https://doi.org/10.1109/ISIT.2012.6283684)。已核查原始 PDF 的模型、主要定理及源分布恢复部分。
- **[CTR22]** P. Chandra, A. Thangaraj, N. Rajaraman. *Missing Mass Estimation from Sticky Channels*. ISIT 2022, 910–915. [arXiv:2202.02772](https://arxiv.org/abs/2202.02772)；[DOI: 10.1109/ISIT50566.2022.9834573](https://doi.org/10.1109/ISIT50566.2022.9834573)。已核查 arXiv 原始全文的估计式、定理 1–2、证明和未知参数段落；不另行宣称已逐字核验会议最终排版版。
- **[CT24]** P. Chandra, A. Thangaraj. *Missing Mass under Random Duplications*. ISIT 2024, 522–526. [DOI: 10.1109/ISIT57864.2024.10619664](https://doi.org/10.1109/ISIT57864.2024.10619664)。现有核查限于[官方会议摘要](https://cmsworkshops.com/ISIT2024/view_paper.php?PaperNum=2073)，完整证明未取得，因此不作全文排除式查新结论。
- **[PMT24]** A. Pananjady, V. Muthukumar, A. Thangaraj. *Just Wing It: Near-Optimal Estimation of Missing Mass in a Markovian Sequence*. JMLR 25(312), 1–43, 2024. [官方论文入口](https://jmlr.org/papers/v25/24-0511.html)；[arXiv:2404.05819v2](https://arxiv.org/abs/2404.05819v2)。已核查主要定理及相关证明。
- **[NMP26]** M. Nakul, V. Muthukumar, A. Pananjady. *Next-token functional estimation*. [arXiv:2609.19529v1](https://arxiv.org/abs/2609.19529v1), 2026。已查阅确定性目标定义、主要定理及相关证明；不将其结论解释为本文随机目标的已有解答。
