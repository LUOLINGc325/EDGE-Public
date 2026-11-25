# 平面二分图上两种唯一支配的固定阈值

## 摘要

全覆盖唯一支配要求没有未受支配点，非重叠唯一支配要求没有重复受支配点。Foucaud 等在第 5 节提出研究两种参数在平面图上的表现。本稿给出平面二分图上的固定阈值结果。全覆盖的临界线性比例恰为二分之一。超过二分之一且不超过一的任意固定有理比例给出 NP 完全问题，即使最大度为三。非重叠方面，对每个固定有理数 $c>\sqrt8$，平方根阈值 $c\sqrt n$ 在平面二分图上已为 NP 完全。另给出一个最大度为四的平面二分图核心构造，其非重叠最优值得以用原图独立数准确表示。

## 1. 问题和结论

图 $G$ 的阶数为 $n\ge1$。用 $U_0(G)$ 表示各支配集中恰受一次支配的最大顶点数，用 $U_+(G)$ 表示各闭邻域两两不交的选集中闭邻域并集大小的最大值。支配均使用闭邻域。两个参数均为整数，因此每个实数阈值等价于其向上取整。两参数均在不交并上可加，每加一个孤立点恰加一分。

Foucaud 等讨论不同阶数阈值的复杂度，并在第 5 节将平面图列为待研究范围 [1]。当目标是整个图阶 $n$ 时，两参数的判定都等价于有效支配，即存在闭邻域恰好分割全图的选集。该问题在平面二分图上已有困难性 [2]，Nevries 将其加强到最大度至多三 [3]。

**定理 1。** 对每个固定有理数 $0<\kappa\le1/2$，所有非空二分图都满足 $U_0(G)\ge \kappa n$。对每个固定有理数 $1/2<\kappa\le1$，该判定在最大度至多三的平面二分图上是 NP 完全的。其中 $\kappa=1$ 是已知端点 [3]。若 $\kappa>1$，所有非空图都为负实例。

**定理 2。** 对每个固定有理数 $c>\sqrt8$，判断 $U_+(G)\ge c\sqrt n$ 在平面二分图上是 NP 完全的。

这两个判定均属于 NP。选集可直接验证，线性阈值按有理数比较，平方根阈值可两边平方后按整数比较。

## 2. 全覆盖的线性阈值

先去掉孤立点，从剩余二分图中选较大的独立侧，再加入每个孤立点。每个未选的非孤立点与选中侧相邻，选集是支配集。每个选中点只由自己支配，所以可在 $O(n+m)$ 时间给出至少 $n/2$ 分的见证。大于一的比例显然不可达到。剩下固定 $\kappa\in(1/2,1)$。

四圈 $C_4$ 的 $U_0$ 等于二。单点无法支配全图，任意两个点均支配全图且恰给二分。若取三个或四个点，每个顶点至少被支配两次。故 $C_4$ 是一个得分恰为图阶一半的平面二分图。

给定一个已有 NP 完全性的有效支配实例 $H$，约定其最大度至多三且为平面二分图 [3, 定理 19]。设其阶数为 $h$，目标为 $U_0(H)=h$。与 $q$ 个四圈取不交并后，新阶数为 $N=h+4q$，对应的比较值为 $A=h+2q$。取 $q=O_\kappa(h)$ 使 $(4\kappa-2)q>(1-\kappa)h$，便有 $\kappa N>A$。

再加入
$
t=\left\lceil\frac{\kappa N-A}{1-\kappa}\right\rceil
$
个孤立点。由上整定义，$-1<\kappa(N+t)-(A+t)\le0$，所以 $\lceil\kappa(N+t)\rceil=A+t$。可加性说明达到新阈值，当且仅当 $U_0(H)=h$。四圈和孤立点均保持平面性、二分性和最大度限制。规约大小为多项式，定理 1 得证。

## 3. 非重叠的平方根阈值

### 3.1 平面二分图核心构造

从平面三正则图上的独立集问题出发。Uehara 的原始报告甚至证明三连通且无三角形的平面三正则图上顶点覆盖仍 NP 完全，其补集对应所需独立集 [4]。

令源图 $H$ 有 $h$ 个顶点。将其每条边细分为恰两条边，再给每个原顶点 $v$ 附加一片私有叶 $\lambda_v$。记所得图为 $G$。令原顶点为二分图的一侧，新细分点和叶为另一侧。边细分与接叶保持平面性，所得图最大度为四。

一个合法非重叠选集的任意两点距离至少三。若其中选了原边 $uv$ 的细分点 $z$，则 $u,v$ 均未选，$\lambda_u,\lambda_v$ 均在距离二内故也未选。可以从选集中删去 $z$，改选 $\lambda_u,\lambda_v$。这两片叶互距四，它们距离小于三的其他点只能是各自原顶点或接于该原顶点的细分点。原顶点均未选，任何这样的其他细分点与 $z$ 原本至多相距二，也未选。因此替换合法，原选点得三分，替换后得四分。故最优解无需选细分点。

选中的原顶点构成 $H$ 的独立集，因为 $H$ 中相邻原点细分后距离恰为二。反过来，对任一独立集 $I$，可同时选其原顶点与每个 $v\notin I$ 的叶 $\lambda_v$，这些点的距离均至少三。叶的闭邻域大小为二，原顶点闭邻域大小为五，所以可行解得分 $5|I|+2(h-|I|)$。固定 $I$ 后，余下所有叶都能选择。于是
$
U_+(G)=2h+3\alpha(H).
$
因此独立集阈值 $k$ 对应核心比较值 $A_0=2h+3k$。

### 3.2 树填充

令 $T_q$ 是一棵有中心 $r$ 的树。中心连 $q$ 个中间点，每个中间点拥有 $2q$ 片私有叶。这是 Goddard 等树效率极值例子去掉中心私有叶的版本 [5]。其阶数为 $2q^2+q+1$。若选择中心，则其闭邻域得 $q+1$ 分，无法再选其他点。若选一个中间点，则得 $2q+2$ 分。此时无法再选其他中间点，同一组的叶也不可选，但每个其他组可选一片叶，各得二分，总计 $4q$。若不选中心或中间点，只能每组选至多一片叶，总计至多 $2q$。因此
$
U_+(T_q)=4q.
$

取 $G$ 与 $T_q$ 的不交并，设阶数为 $N=|V(G)|+2q^2+q+1$，对应目标 $A=A_0+4q$。因为 $c>\sqrt8$，有 $c\sqrt2-4>0$，故 $q=O_c(h)$ 就足以令 $c\sqrt N>A$ 及 $\sqrt N\ge c$。具体可倍增 $q$ 并使用精确平方比较。

再加入 $t$ 个孤立点。令
$
D(t)=\lceil c\sqrt{N+t}\rceil-A-t .
$
因 $\sqrt N\ge c$，连续两个平方根阈值的实数差至多 $1/2$，所以 $D(t)$ 每步至多减一且不增。初值为正，又有 $D(t)\le D(0)+1-t/2$。可在 $t\le2D(0)+2$ 用二分找到第一个零。增加孤立点恰增加 $t$ 分，最终达到该固定阶数阈值当且仅当 $U_+(G)\ge A_0$，即 $\alpha(H)\ge k$。

所用树和孤立点保持平面二分图性质，填充实例图阶为 $O_c(h^2)$。最大度四只适用于第 3.1 节中未填充的核心。定理 2 得证。

## 参考文献

1. Florent Foucaud, Yan Gerard, Christian Laforest, Le Vu Pham. *Full-Cover and Non-Overlapping Uni-domination in Graphs: Bounds and Complexity*. arXiv:2611.21210v1. [第 5 节](https://arxiv.org/abs/2611.21210)
2. Chin Lung Lu, Chuan Yi Tang. *Weighted efficient domination problem on some perfect graphs*. Discrete Applied Mathematics 117, 163–182, 2002. [DOI](https://doi.org/10.1016/S0166-218X(01)00184-6)
3. Ragnar Nevries. *Efficient Domination and Polarity*. Universität Rostock, 2014. [定理 19](https://rosdok.uni-rostock.de/file/rosdok_disshab_0000001252/rosdok_derivate_0000019031/Dissertation_Nevries_2014.pdf)
4. Ryuhei Uehara. *NP-complete problems on a 3-connected cubic planar graph and their applications*. Technical Report No. 4, Tokyo Woman’s Christian University, 1996. [原报告](https://www.jaist.ac.jp/~uehara/pdf/triangle.pdf)
5. Wayne Goddard, Ortrud R. Oellermann, Peter J. Slater, Henda C. Swart. *Bounds on the total redundance and efficiency of a graph*. Ars Combinatoria 54, 129–138, 2000. [定理 5 后的锐利例子](https://people.computing.clemson.edu/~goddard/papers/redundancy.pdf)
