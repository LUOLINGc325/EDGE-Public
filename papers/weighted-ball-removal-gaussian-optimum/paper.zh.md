# 带权移球的 Gaussian 最优偏移与余球分布

## 摘要

每轮从非空箱按相对权重移除一球，直至仅一个箱非空。固定箱数和任意正权重下，全部最优整数分配距按权重比例分配至多 $O(\sqrt n)$，归一化最优期望余球数收敛到 Gaussian 时钟的最优加权间距。极限优化的严格真子集间隙排除有箱退出。沿二阶偏移收敛的分配，最后一箱与余球数有联合极限。权重在等权点的相对开邻域内，Gaussian 最优点在模平移后唯一且随权重解析变化，故所有最优整数分配共享同一确定二阶偏移。文中给出偏移的线性响应及两箱任意样本数的精确最优分位数。

## 1. 模型和结论

固定 $k\ge2$、$p_i>0$ 和 $\sum_i p_i=1$。设 $a=(a_1,\ldots,a_k)\in\mathbb Z_{\ge0}^k$，$\sum_i a_i=n\ge1$。
当前非空箱集合为 $B$ 时，选中 $i\in B$ 的概率为 $p_i/\sum_{j\in B}p_j$。
记停止时余球数为 $L(a)$，写 $F_n(a)=\mathbb E L(a)$ 及 $V_n=\min_a F_n(a)$。
若初始仅一个箱非空，则 $L(a)=n$。

Correa 等 [1] 的第 3 节为不等权情形给出精确按权重比例分配次优的两箱反例，并提出与“balanced allocation”的最大坐标距离为 $O(\sqrt n)$ 的猜想。本文把按权重比例的中心 $np$ 与等量中心区分开来。在固定权重且只对非空箱重新归一化的模型中，前一结论成立。若用等量中心 $n/k$，任何不等权向量都有线性偏差。

为陈述极限，令 $Z_1,\ldots,Z_k$ 独立标准正态。对 $S\subseteq[k]$、$|S|\ge2$ 及 $u\in\mathbb R^S$ 定义

$$
 Y_i=u_i+Z_i/\sqrt{p_i},\qquad
 G_S(u)=\mathbb E\sum_{i\in S}
 p_i\left(Y_i-\max_{j\in S\setminus\{i\}}Y_j\right)_+,
 \quad C_S=\inf_u G_S(u).
$$

**定理 1。** 设 $k,p$ 固定。所有有限样本最优分配一致满足
$\max_i|a_i^{(n)}-np_i|=O(\sqrt n)$。此外，

$$
 \frac{V_n}{\sqrt n}\ \longrightarrow\ C_{[k]}.
$$

设 $H=\{u:\sum_i p_i u_i=0\}$ 和 $\mathcal M=\{u\in H:G_{[k]}(u)=C_{[k]}\}$。
集合 $\mathcal M$ 非空且紧。每一个最优分配序列的二阶偏移
$u_i^{(n)}=(a_i^{(n)}/p_i-n)/\sqrt n$ 到 $\mathcal M$ 的距离趋于零。
对任意 $u\in\mathcal M$，整数舍入 $np_i+\sqrt n\,p_i u_i$ 并保持总和 $n$，得到归一化期望代价趋于 $C_{[k]}$ 的分配。
特别地，普通等量分配与任一最优分配的最大坐标距离为
$n\max_i|p_i-1/k|+O(\sqrt n)$。

## 2. Poisson 嵌入与相邻耗尽时间

为每个箱 $i$ 放置独立速率 $p_i$ 的 Poisson 时钟 $N_i$。只接受尚非空箱的到达，按指数竞赛与强 Markov 性质，接受到达的箱序列与离散去球过程同分布。令 $T_i$ 为 $N_i$ 的第 $a_i$ 次到达时刻，$a_i=0$ 时取 $T_i=0$。这些独立变量在正形状时服从 Erlang 分布，均值 $\mu_i=a_i/p_i$，方差 $a_i/p_i^2$。

倒数第二个耗尽时刻 $\tau$ 是独立 Poisson 向量自然滤过下的停时。唯一存活箱 $I$ 和当时余球数 $L$ 在 $\tau$ 时可测。给定历史，$T_I-\tau$ 是余下 $L$ 次到达的等待时间，条件期望为 $L/p_I$。因此得到恒等式

$$
 F_n(a)=\mathbb E\sum_{i=1}^k
 p_i\left(T_i-\max_{j\ne i}T_j\right)_+.
 \qquad\text{(1)}
$$

这也覆盖只有一个初始非空箱的情况，此时 $\tau=0$。
等权问题的 Erlang 嵌入已有先例 [2]。以下需要处理不等权且落后箱可能在极限中消失的优化。

## 3. 加入一个低均值箱会严格改善

**引理 2。** 若 $|S|\ge2$、$u\in\mathbb R^S$ 固定且 $j\notin S$，则对充分大的 $M$，

$$
 G_{S\cup\{j\}}(u,-M)<G_S(u).
 \qquad\text{(2)}
$$

**证明。** 记原集合中最大值与次大值为 $A,B$，最大值来自箱 $I$，新时钟为 $W=-M+Z_j/\sqrt{p_j}$。原每次代价是 $p_I(A-B)$。新的最大值来自原箱时，其代价减少 $p_I \min\{(W-B)_+,A-B\}$。新箱成为最大值时，上述减少量仍然适用，并增加 $p_j(W-A)_+$。令 $p_*=\min_{i\in S}p_i$。两期望之差至多

$$
 p_j\,\mathbb E(W-A)_+
 -p_*\,\mathbb E\int_{\mathbb R}\mathbf 1\{B<t<A,\ W>t\}\,dt .
 \qquad\text{(3)}
$$

设 $P=\sum_{i\in S}p_i$。加权平均 $\overline Y=\sum_{i\in S}p_iY_i/P$ 满足 $A\ge\overline Y$。
变量 $W-\overline Y$ 的均值为 $-M+O(1)$，方差为 $1/p_j+1/P$。
对 $X\sim N(-b,\sigma^2)$、$b>0$，由正部期望的正态积分可得
$\mathbb E X_+\le \sigma\phi(b/\sigma)$，其中 $\phi$ 是标准正态密度。因此第一项的对数除以 $M^2$ 的上极限至多 $-J(P)$，其中

$$
 J(R)=\frac{p_j R}{2(p_j+R)},\qquad R>0 .
$$

固定任意 $i\in S$，取 $P'=P-p_i>0$、$c=p_j/(p_j+P')$。
在 $t\in[-cM,-cM+1]$ 上，事件
$\{W>t,\ Y_i>t,\ Y_h<t\ (h\in S\setminus\{i\})\}$ 蕴含第二项积分中的事件。
独立性给出概率下界

$$
 \Pr(W>-cM+1)\Pr(Y_i>-cM+1)
 \prod_{h\in S\setminus\{i\}}\Pr(Y_h<-cM).
$$

这些下界统一适用于整段单位长度区间。
正态尾对数渐近 $\log\Pr(Z>x)=-x^2/2+o(x^2)$ 可由密度在 $[x,x+1]$ 上的积分下界及 Chernoff 上界得到。
于是第二项的对数除以 $M^2$ 的下极限至少为
$-[p_j(1-c)^2+P'c^2]/2=-J(P')$。
由于 $J(P')<J(P)$，第二项严格压过第一项，得 (2)。

## 4. Gaussian 优化的极小值与边界

**引理 3。** 任一 $|S|\ge2$ 的 $G_S$ 在模共同平移后达到极小值，所有极小值构成紧集。对每一真子集 $D\subset S$、$|D|\ge2$，有 $C_S<C_D$。

**证明。** 平移所有 $u_i$ 不改变 $G_S$，故可固定 $\max_i u_i=0$。沿任一规范化的逃逸序列抽子列，使极限落在 $[-\infty,0]^S$，记有限坐标集合为 $D$。
以同一组 $Z_i$ 作耦合。若 $|D|=1$，仅一个时钟保持有限，顶部两时钟的间距几乎处处趋于无穷，故由 Fatou 引理代价趋于无穷。
若 $|D|\ge2$，逐点极限为对应 $G_D$ 的随机代价。当 $i,h\in D$ 时，所有随机代价均被最大时钟与 $\min(Y_i,Y_h)$ 的差控制。最大时钟不超过 $\max_{\ell\in S} Z_\ell/\sqrt{p_\ell}$，而 $u_i,u_h$ 有统一下界，故有可积控制。期望收敛到 $G_D(u_D)$。

当 $|S|=2$，逃逸序列必有 $|D|=1$，与有界最小化序列矛盾。连续性来自随机代价对 $u$ 的连续性及紧区域上的可积控制。
对更大的 $S$，在所有至少含两个元素的真子集中取一个 $D_*$，使 $C_{D_*}$ 最小。归纳假设保证 $G_{D_*}$ 达到最小值。
由引理 2，加入 $S\setminus D_*$ 中任一箱后可获严格改善，再将其他箱的均值送到 $-\infty$ 即知 $C_S<C_{D_*}$。
这样任何逃逸序列的极限均严格大于 $C_S$，因此最小化序列模平移有界。利用连续性得到极小值及其紧性。
规范化 $\sum_{i\in S}p_i u_i=0$ 与 $\max_i u_i=0$ 之间是连续双向变换。每个有限 $u$ 的最大值和次大值几乎处处不同，故 $C_S>0$。

## 5. 离散最优分配的紧性和极限

对任意固定 $u\in H$，将 $np_i+\sqrt n\,p_i u_i$ 按总和约束进行整数舍入。每个坐标改变量至多 1，可先向下舍入再给若干坐标补 1。大 $n$ 时所有坐标非负且趋于无穷。
对各 $T_i$ 应用独立同分布指数等待时间的中心极限定理，得到

$$
 \left(\frac{T_i-n}{\sqrt n}\right)_{i=1}^k
 \ \Rightarrow\ (u_i+Z_i/\sqrt{p_i})_{i=1}^k.
$$

缩放后的代价被 $\max_i |(T_i-n)/\sqrt n|$ 的二倍控制，此上界的二阶矩一致有界。
故由 (1) 得 $F_n(a)/\sqrt n\to G_{[k]}(u)$。特别地
$\limsup V_n/\sqrt n\le C_{[k]}$。

反过来，取任意最优分配序列，并沿任意子序列再抽子列。记 $\mu_i^{(n)}=a_i^{(n)}/p_i$ 和 $M_n=\max_i\mu_i^{(n)}$。
由加权均值恒等式 $\sum_i p_i\mu_i^{(n)}=n$ 得 $n\le M_n\le n/\min_i p_i$。
可令 $M_n/n\to\lambda\ge1$，并令
$(\mu_i^{(n)}-M_n)/\sqrt n\to d_i\in[-\infty,0]$。
设 $D$ 为 $d_i$ 有限的坐标集合，其中至少有一个 $d_i=0$。
在 $D$ 上，$a_i^{(n)}/n\to\lambda p_i>0$，所以

$$
 \left(\frac{T_i-M_n}{\sqrt n}\right)_{i\in D}
 \ \Rightarrow\ (d_i+\sqrt{\lambda/p_i}\,Z_i)_{i\in D}.
 \qquad\text{(4)}
$$

在 $D$ 之外，$(T_i-M_n)/\sqrt n\to-\infty$ 依概率成立，因为中心化噪声 $(T_i-\mu_i^{(n)})/\sqrt n$ 的二阶矩一致有界。
若 $|D|=1$，归一化顶部间距依概率趋于无穷，(1) 中最大时钟的权重至少为 $\min_i p_i>0$。这与前述上界矛盾。

若 $|D|\ge2$，任取不同 $i,h\in D$。归一化最大时钟不超过
$\max_j (T_j-\mu_j^{(n)})/\sqrt n$，第二大时钟至少为
$\min(T_i-M_n,T_h-M_n)/\sqrt n$。
由二阶矩界可知二者之间的非负间距一致可积。
落后箱进入前两位的概率趋于零。因此由 (1)、(4) 及一致可积性，

$$
 \frac{V_n}{\sqrt n}\ \longrightarrow\
 \sqrt\lambda\,G_D(d_D/\sqrt\lambda)
 \ \ge\ C_D
 \qquad\text{(5)}
$$

沿该子列成立。若 $D\ne[k]$，由引理 3 得 $C_D>C_{[k]}$，矛盾。
若最优配置的 $\max_i|a_i-np_i|/\sqrt n$ 对 $n$ 无一致界，可以选定一条趋于无穷的子列，因为每个固定 $n$ 只有有限种配置。此时在上述提取中至少一坐标相对 $M_n$ 的偏移必须趋于 $-\infty$：若全部偏移有限，按 $p_i$ 加权求和便得到 $(n-M_n)/\sqrt n$ 有限。故 $D=[k]$ 排除了任何这类子列，并得到所需一致界。
现在任取收敛的中心化二阶偏移子列。与上界比较，中心极限定理和 (1) 强制极限代价恰等于 $C_{[k]}$，偏移极限属于 $\mathcal M$。
二阶偏移的一致有界性推出到 $\mathcal M$ 的距离趋于零，且 $V_n/\sqrt n\to C_{[k]}$。这证明定理 1。

## 6. 两箱的精确解

令 $p=p_1$、$q=1-p$，给第一箱 $a$ 球。考虑长度为 $n$ 的独立 Bernoulli$(p)$ 序列，在首次有一个箱耗尽时停止。记前 $n$ 次的成功数为 $B_n$，它服从 $\operatorname{Bin}(n,p)$。设 $f_n(a)=F_n(a,n-a)$。

**定理 4。** 对 $0\le a\le n$，

$$
 f_n(a)=\frac{\mathbb E(B_n-a)_+}{p}
       +\frac{\mathbb E(a-B_n)_+}{q}.
 \qquad\text{(6)}
$$

令 $H_n(b)=\Pr(B_n\le b)$ 且 $H_n(-1)=0$。所有最优 $a$ 恰由
$H_n(a-1)\le q\le H_n(a)$ 刻画。任取最优 $a_n$，有

$$
 \frac{a_n-np}{\sqrt n}\to\sqrt{pq}\,\Phi^{-1}(q),
 \qquad
 \frac{V_n}{\sqrt n}\to\frac{\phi(\Phi^{-1}(q))}{\sqrt{pq}} ,
 \qquad\text{(7)}
$$

其中 $\Phi,\phi$ 分别是标准正态分布函数和密度。

**证明。** 若第一箱先耗尽，终止后的 $L$ 次虚拟试验还会出现的成功数恰是 $B_n-a$，它可能为零，且其条件期望为 $pL$。若第二箱先耗尽，余下试验中失败次数恰是 $a-B_n$，条件期望为 $qL$。当 $a=0$ 或 $a=n$ 时相应空箱在时刻零耗尽，公式仍成立。取期望得 (6)。

相邻差为

$$
 f_n(a+1)-f_n(a)=\frac{H_n(a)-q}{pq},
 \qquad 0\le a<n.
$$

因 $H_n$ 单调，正负转换给出所有最优分位点。二项中心极限定理和标准正态分布函数严格递增给出第一个极限。由 (6)、标准化二项变量一致有界的二阶矩及第一个极限，第二个极限等于

$$
 \sqrt{pq}\left[
   \frac{\phi(z)-z(1-\Phi(z))}{p}
  +\frac{\phi(z)+z\Phi(z)}{q}\right]
 =\frac{\phi(z)}{\sqrt{pq}},\qquad z=\Phi^{-1}(q).
$$

例如 [1] 中 $p=5/6$ 与 $n=6$ 时，判据给出唯一最优分配 $(4,2)$。当固定 $p\ne 1/2$ 时，(7) 的首项非零，表明相对比例中心的 $O(\sqrt n)$ 普遍不能改为 $o(\sqrt n)$。

## 7. 最后一箱与余球数的联合极限

**定理 5。** 设 $p_i>0,\ \sum_i p_i=1$，箱数固定且不少于二。沿一列分配令 $u_i^{(n)}=(a_i/p_i-n)/\sqrt n\to u_i$。记 $I_n$ 为最后一箱，$L_n$ 为其余球数。若 $Y_i=u_i+Z_i/\sqrt{p_i}$，各 $Z_i$ 独立标准正态，$I=\arg\max_iY_i,\ Y_{(2)}$ 为这些时刻中的第二大值，则
$$
          (I_n,L_n/\sqrt n)\ \Rightarrow\
          (I,\ p_I(Y_I-Y_{(2)})).
$$
因此定理 1 的平均余量首项也有分布解释。

**证明。** 独立 Erlang 耗尽时钟满足联合中心极限定理 $(T_i-n)/\sqrt n\Rightarrow Y_i$。极限无平局，故胜者和最大间距收敛。在倒数第二个耗尽停时 $\tau$，箱编号 $I_n$ 和 $L_n$ 已知。由强 Markov 性，$p_{I_n}(T_{I_n}-\tau)$ 条件分布为形状 $L_n$、速率一的 Gamma，故它与 $L_n$ 之差有零条件均值和条件二阶矩 $L_n$。式 (1)或各时钟的一阶绝对偏差给出 $\mathbb E L_n=O(\sqrt n)$。除以 $\sqrt n$ 后，替换误差在平方均值下趋于零。联合极限随即成立。

例如 $z\ge0$ 时，若 $f_i,F_i$ 是 $Y_i$ 的密度和分布函数，
$$
 \lim_n\Pr(I_n=i,\ L_n>z\sqrt n)=
      \int_{\mathbb R} f_i(y)\prod_{j\ne i} F_j(y-z/p_i)\,dy .
$$
右端是可计算的尾概率。固定 $I=i$ 时，任一对 Gaussian 时钟的间距落在指定阈值的概率为零，故阈值事件的边界概率为零，包括 $z=0$。该式也适用于最优分配任何收敛的二阶偏移子列。下一节在等权邻域确定全部最优分配共同的极限偏移。

## 8. 等权邻域的全局唯一与解析偏移

**定理 6。** 固定任意箱数 $k\ge2$。对每个 $p$ 在均匀权重 $p^0_i=s=1/k$ 的某个相对开邻域内，定理 1 的全箱 Gaussian 最优化在模平移后有唯一全局极小点 $u(p)$，且随 $p$ 实解析。因此任意整数最优分配序列均有同一个二阶展开
$$
 a_i^{(n)}=np_i+\sqrt n\,p_i u_i(p)+o(\sqrt n),
 \qquad \sum p_i u_i(p)=0 .
$$
这里的相对开邻域包含不等权点，半径可依赖 $k$。

### 8.1. 顺序事件、驻点和全局唯一性

令 $Y_i=u_i+Z_i/\sqrt{p_i}$ 独立，密度和分布函数为 $f_i,F_i$，且 $P_{ij}$ 表示 $i$ 第一、$j$ 第二的概率。目标 $G=E[p_I(Y_{(1)}-Y_{(2)})]$，这里下标 $(1),(2)$ 按从大到小排列。每次坐标扰动的样本代价连续分段线性，斜率的绝对值至多一；换胜者时顶二间隙趋于零，故没有跳跃。支配收敛得
$$
 \partial_iG=\sum_{j\ne i}(p_iP_{ij}-p_jP_{ji}),\qquad
 P_{ij}=\int_{y>z} f_i(y)f_j(z)\prod_{\ell\ne i,j} F_\ell(z)\,dy\,dz .
$$
对 $p=p^0$，交换两个名次后密度乘积之比为 $\exp[s(u_i-u_j)(y-z)]$。故当 $u_i>u_j$ 时 $P_{ij}>P_{ji}$，若相等则等号。于是
$$
 u^\top\nabla G=s\sum_{i<j}(u_i-u_j)(P_{ij}-P_{ji})>0
$$
对每个非常数向量严格成立。沿从零出发的任一非平移方向，代价严格上升；均匀权重下全局极小点仅为常数向量。

在 $u=0,p=p^0$ 处，写 $f,F$ 为 $N(0,1/s)$ 的密度和 CDF。置
$$
 I_k=\int_{y>z}(y-z)f(y)f(z) F(z)^{k-2}\,dy\,dz>0 .
$$
通过交换密度比的导数，$p_iP_{ij}-p_jP_{ji}$ 关于 $u$ 的一阶变化为 $s^2 I_k(\delta u_i-\delta u_j)$。在固定平移超平面 $\sum_i u_i=0$ 上，因每对净流在两坐标的贡献反号，Hessian 是 $k s^2 I_k$ 倍单位矩阵。顺序概率也可写成固定多面锥上对 $k$ 个 Gaussian 密度的乘积积分。在任一 $p_i>0,u_i$ 的邻域，复化参数后模可以由 $C\exp(-c\|y\|^2)$ 控制，故依参数实解析。梯度在平移方向恒为零。在固定超平面上，将权重用前 $k-1$ 坐标参数化，解析隐函数定理因上述 Hessian 非退化，给均匀点附近唯一驻点分支。

需要排除远处不同的全局极小点。若 $p^{(m)}\to p^0$ 且有极小点逃逸，归一化 $\max u_i^{(m)}=0$，抽子列令有限极限坐标集合为 $D$。同一组正态耦合，只有一个有限坐标时成本几乎处处趋于无穷。若 $2\le|D|<k$，Fatou 给出极限下界 $C_D(p^0)>C_{[k]}(p^0)$，严格号为第 4 节引理 3 的真子集间隙。两种情形都违背试探 $u=0$ 给的连续上界。若坐标有界，极限必为均匀获胜点，因归一化而为零。因此全部全局极小点落入隐函数邻域。平移归一化回 $\sum p_i u_i=0$ 后仍解析。最后应用第 1 节定理 1。

### 8.2. 权重的线性响应

在均匀点定义
$$
 B_k=\frac{1}{k(k-1)}
 -\frac{s}{2}\int_{y>z}(y^2-z^2)f(y)f(z)F(z)^{k-2}\,dy\,dz .
$$
对概率向量作切向变化 $\sum\delta p_i=0$，固定 $u=0$。胜负密度交换差在基点为零，因此其他坐标的导数全部消失。对零均值、精度 $p$ 的密度求导得到系数 $1/(2p)-y^2/2$；再求前面乘数 $p_i$ 的导数，就得单对净流的一阶变化 $B_k(\delta p_i-\delta p_j)$。结合 Hessian 和归一化条件，
$$
 D u_i(p^0)[\delta p]=-\frac{B_k}{s^2 I_k}\,\delta p_i .
$$
在 $k=3$ 把 $z$ 标准化，$\phi,\Phi$ 为标准正态密度与 CDF。两项可独立以一维积分计算：
$$
 I_3=s^{-1/2}\int\phi(z)\Phi(z)[\phi(z)-z\Phi(-z)]dz,\quad
 B_3=\tfrac16-\tfrac12\int\phi(z)\Phi(z)[z\phi(z)+(1-z^2)\Phi(-z)]dz.
$$
一维积分的数值核对给出 $I_3=0.24430125595146,\ B_3=0.09775055473894$，响应系数 $-3.60110712171403$；数值用于复查，不用于证明。这个三箱响应系数为负，故在均匀点的三箱邻域里，增加该箱权重的一阶效应是将其相对时钟均值向前调。

## 9. 文献与计算范围

Correa 等 [1] §3 在不等权两箱中展示按比例取整可以次优，提出平方根偏差问题。定理 1 用权重比例中心闭合该量级。Zhou–Wang–Zhang [2] 的等权库存最优性与 Erlang 嵌入是该模型的先行工作，离散等权配置的均衡最优也见 [1]。本文的 Gaussian 真子集严格间隙、一致极限及等权邻域的全局解析中心处理不等权分配；参数远离等权时仍用定理 1 的非空紧最优集表示。两箱则由定理 4 全参数精确求解。[Correa 等作者全文](https://arxiv.org/pdf/2602.12523v2) · [Zhou 等出版者摘要](https://pubsonline.informs.org/doi/abs/10.1287/opre.2025.2228)

有限脚本以有理数对照 Erlang 嵌入与离散递归和两箱分位数。第 8 节的一维积分数值只核对线性响应；邻域唯一性的论证来自全局回缩与隐函数定理。[精确复算程序](code/exact_certificate.py)

## 参考文献

1. José Correa, Marcos Kiwi, Vasilis Livanos, Eilon Solan, Ron Solan. *About a ball removal process on bins*. arXiv:2602.12523v2, 2026, Sections 1 and 3. <https://arxiv.org/abs/2602.12523v2>
2. Ziyan Zhou, Tong Wang, Jingwei Zhang. *Optimal Inventory Allocation for Indifferent Goods Under Dynamic Substitution*. Operations Research 74(4), 2001–2012, 2026. <https://doi.org/10.1287/opre.2025.2228>
3. Fernanda Gutiérrez, Bernardo Subercaseaux. *Assortment Optimization for Conference Goodies with Indifferent Attendees*. arXiv:2403.03330, 2024. <https://arxiv.org/abs/2403.03330>
