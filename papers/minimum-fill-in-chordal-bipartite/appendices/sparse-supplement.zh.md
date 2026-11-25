---
title: "弦二分图最小填边的输出敏感近线性算法"
lang: zh-CN
---

## 摘要

主文证明原有四圈的对角线点覆盖等价于最小填边，并将冲突约束压缩为链网络。把具有相同可达邻域的点对合并后，网络进一步缩减到与原边数同阶。给定邻接表，最优值可在确定性 $O(n)+m^{1+o(1)}$ 时间内计算。若最优填边集为 $F$，输出所有边另耗时 $O(|F|\log^2(n+1))$。

## 1. 合并相同门槛的点对

沿用主文的二分部 $X,Y$ 和无 $\Gamma$ 模式的矩阵顺序。设 $G$ 有 $n$ 个顶点、$m$ 条边。用 Paige–Tarjan 算法求稀疏双字典序，耗时 $O(n+m\log(n+1))$ [1, 2]。无 $\Gamma$ 指不存在依行列顺序取出的子矩阵 $\left(\begin{smallmatrix}1&1\\1&0\end{smallmatrix}\right)$ [2, 3]。可先跳过孤立点，它们参与不了原四圈，也不增加最小填边。剩余顶点数至多 $2m$。若 $m=0$，直接返回空集。

固定行 $i$，把 $x_i$ 的邻居列按增序记为 $a_1,\dots,a_s$。令

$$S_\ell=\{j>i:x_jy_{a_\ell}\in E(G)\},\qquad S_0=\varnothing.$$

若 $j\in S_\ell$ 且 $h>\ell$，三个已知邻接 $x_iy_{a_\ell}, x_iy_{a_h}, x_jy_{a_\ell}$ 由无 $\Gamma$ 性质迫使 $x_jy_{a_h}$ 存在。故 $S_0\subseteq S_1\subseteq\cdots\subseteq S_s$。点对 $(x_i,x_j)$ 的首个公共邻居是 $y_{a_\ell}$，当且仅当 $j\in S_\ell\setminus S_{\ell-1}$。

因此所有以同一有序原边 $(x_i,y_{a_\ell})$ 为门槛的左点对组成一组。其基数为

$$w_R(i,a_\ell)=|S_\ell|-|S_{\ell-1}|.$$

在第 $a_\ell$ 列的有序邻居表中，$|S_\ell|$ 就是位于 $i$ 之后的表项数。可在按行列分别排列原边后取得所有秩，再沿各行一次扫描得到全部 $w_R$。右点对对称，给出以列链门槛 $(x_i,y_a)$ 为键的权重 $w_C(i,a)$。此计算用至多 $O(n+m\log(n+1))$ 的时间与 $O(n+m)$ 的额外存储。无需列举点对。没有共同邻居的点对在四圈冲突图中孤立，可略去。

## 2. 线性大小网络及最优性

保留每条原边的行链结点 $R_{ia}$ 和列链结点 $C_{ia}$，以及主文定义的三类弧：行链按列递增，列链按行递减，另有同一原边内的 $R_{ia}\to C_{ia}$。删除单独的点对结点。加入从源点到 $R_{ia}$ 的容量 $w_R(i,a)$ 的弧，以及从 $C_{ia}$ 到汇点容量为 $w_C(i,a)$ 的弧。其他弧的容量为

$$1+\sum_{(i,a)\in E(G)}\bigl(w_R(i,a)+w_C(i,a)\bigr).$$

该大容量超过切断全部源点出弧的代价，故最小割只支付终端弧。所有容量都是 $O(m^2+1)$ 的整数，网络有 $O(m)$ 个结点和弧。

同组点对在主文的四圈冲突图中拥有相同邻域，因为对应的可达路径有同一个门槛。一个按包含关系极小的点覆盖对每组全取或全不取。若同组中有一未取点对，该组的所有邻居都已取，此时组内任何已取点对可删去。

对不切断大容量弧的任一割，汇点侧 $R$ 结点的左组和源点侧 $C$ 结点的右组构成一个点覆盖。若有未覆盖的冲突边，源点侧的左门槛到汇点侧的右门槛之间存在一条全由大容量弧组成的有向路，矛盾。覆盖大小等于割容量。

反过来，给定一个按组选择的点覆盖，从所有未选左组的门槛沿大容量弧做可达闭包，把到达的结点放在源点侧，其余放在汇点侧。该闭包不包含任何未选右组的门槛，因为这会违反覆盖。它也包含所有未选左组的门槛。因此不会新增付费组，割容量至多为给定覆盖大小。两个方向合并说明最优值相同。用确定性精确最大流 [4]，再从残量网络计算源点可达集合，就得到一个最小割和对应的最优填边组。按主文结构定理，每个所得最小点覆盖直接给出最优填边。

## 3. 只展开实际输出

考虑割选出的一个正权重左组。它要输出满足 $j\in S_\ell\setminus S_{\ell-1}$ 的所有 $(x_i,x_j)$。这两个嵌套集合在有序邻居表中可分别表示为下标大于 $i$ 的后缀。对任意顶点编号区间 $I$，以两次秩差分别获得 $|I\cap S_\ell|, |I\cap S_{\ell-1}|$，用有序表的二分查找耗时 $O(\log(n+1))$。

从编号大于 $i$ 的整个区间开始。若计数之差为零，停止处理该区间。否则把区间二分，直至输出单点。若组内有 $k$ 条输出边，每个递归深度最多有 $k$ 个正差区间。每个正差非叶结点只派生两个调用。故总调用数为 $O(1+k\log(n+1))$，每组用时 $O(k\log^2(n+1))$。右组对称。组的成员不重叠，全部正权重组的大小之和恰为 $|F|$。

稀疏排序、建网、精确流和残量遍历总耗时 $O(n)+m^{1+o(1)}$。实际输出耗时 $O(|F|\log^2(n+1))$。若只需最优值或按组表示的填边，则无需展开。

## 参考文献

1. Robert Paige, Robert E. Tarjan. *Three Partition Refinement Algorithms*. SIAM Journal on Computing 16(6), 973–989, 1987. [DOI](https://doi.org/10.1137/0216062)
2. Dieter Kratsch, Ross M. McConnell, Kurt Mehlhorn, Jeremy P. Spinrad. *Certifying Algorithms for Recognizing Interval Graphs and Permutation Graphs*. SIAM Journal on Computing 36(2), 326–353, 2006. [关于弦二分图的第 3 节](https://people.mpi-inf.mpg.de/~mehlhorn/ftp/KMMS.pdf)
3. Anna Lubiw. *Doubly Lexical Orderings of Matrices*. SIAM Journal on Computing 16(5), 854–879, 1987. [DOI](https://doi.org/10.1137/0216057)
4. Jan van den Brand 等. *A Deterministic Almost-Linear Time Algorithm for Minimum-Cost Flow*. FOCS 2023. [作者稿](https://arxiv.org/abs/2309.16629)
