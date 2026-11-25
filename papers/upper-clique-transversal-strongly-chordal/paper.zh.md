# 强弦图上最大极小团横截的多项式算法

## 摘要

团横截是与图的每个极大团相交的点集。最大极小团横截问题要求在所有按包含关系极小的团横截中最大化大小。Jaffke、de Lima 和 Nikabadi 在 MFCS 2026 论文结尾提出研究强弦图的复杂度。我们给出一个多项式时间算法。强弦图的极大团超图是 $\beta$ 无环的。将每个顶点替换为相同数量的副本会保持这项性质，并把极小横截的计数变成按其大小生成的多项式取值。用已知的无环超图计数算法和插值即可求得全部大小的计数，并恢复一个最优横截。

## 1. 问题与结论

设 $G$ 是有限简单图，$\mathcal C(G)$ 为其极大团族。若 $T\subseteq V(G)$ 与每个 $C\in \mathcal C(G)$ 相交，则 $T$ 是团横截。要求 $T$ 按包含关系极小，再在这样的集合中取大小最大值，记为 $\tau_{\mathrm c}^+(G)$。

Jaffke、de Lima 和 Nikabadi 在第 5 节明确列出强弦图作为待研究图类 [1]。已知算法处理区间图和有根有向路径图 [1]，而 Milanič 与 Uno 的一般弦图规约为 NP 完全性 [2]。

**定理。** 给定一张 $n$ 点强弦图，在多项式时间内可计算每个大小的极小团横截数，因而求得 $\tau_{\mathrm c}^+(G)$ 并恢复一个最大极小团横截。

以下统一在显式超图上证明算法，并最后回到强弦图。空图的返回值取零并返回空集。

## 2. 计数多项式

令 $H=(V,\mathcal E)$ 为有限超图，顶点数为 $n$，超边集显式给出。记 $\mathcal{M}(H)$ 为其所有极小横截的族，定义
$
P_H(z)=\sum_{T\in\mathcal{M}(H)} z^{|T|}.
$
它的次数不超过 $n$。若有空超边，则没有横截，直接返回零多项式。若没有超边，则唯一极小横截为空集，返回常数一。

我们用两个已知性质。一个超图为 $\beta$ 无环，当且仅当其关联二分图没有长度至少六的诱导环 [3, 4]。Bergougnoux、Capelli 和 Kanté 的第 12 定理在多项式时间内准确计数这类显式超图的极小横截 [3]。

对任意正整数 $q$，把每个 $v\in V$ 换成 $q$ 个顶点 $v_1,\dots,v_q$。每条超边 $E$ 换成包含其中每个顶点全部副本的超边。记新超图为 $H^{[q]}$。

若 $H$ 为 $\beta$ 无环，则 $H^{[q]}$ 也为 $\beta$ 无环。其关联二分图若存在诱导环且长度至少六，该环不可能含同一个顶点的两个副本。因为两个副本在整图中邻居相同，在诱导环中也将共用两个邻居。这四个点已经形成环中的一个完整四边环，与长度至少六矛盾。故把诱导环中的每个副本换回原顶点，所得顶点互异，且边与非边关系保持，于是在 $H$ 的关联图中也得到一个同长诱导环，矛盾。

$H^{[q]}$ 的任一极小横截至多选择每个原顶点的一个副本，因为任意同组副本进入的超边完全相同，若选择两个就可以删掉一个。投影到原顶点后得到 $H$ 的横截。此投影必极小，否则可以删除同样的副本而仍命中所有超边。反过来，$H$ 的每个极小横截可任选各点的一份副本，得到 $H^{[q]}$ 的一个极小横截。这里横截极小的可删性与投影逐点一致。因此
$
|\mathcal{M}(H^{[q]})|=\sum_{T\in\mathcal{M}(H)}q^{|T|}=P_H(q).
$

对 $q=1,\dots,n+1$ 用第 12 定理计数，然后用精确有理数插值。每个实例最多有 $n(n+1)$ 个顶点，超边总大小最多为原超边总大小的 $n+1$ 倍。计数本身最多有 $n(n+1)+1$ 个二进制位。拉格朗日公式的分母是 $n$ 个非零整数差的积，每个差的绝对值至多 $n$。分子上的线性因子系数也至多为 $n+1$。因此例如将 $n+1$ 个拉格朗日分母相乘后通分，各中间分子与分母的位数仍为多项式。全部系数在多项式位复杂度内得到。

## 3. 恢复见证和应用

给定 $W\subseteq V$，令 $H|_W$ 的顶点集为 $W$，超边分别取原超边与 $W$ 的交集。可以合并重复超边。其关联图由原关联图删去顶点及可能重复的超边节点得到，故仍无长度至少六的诱导环。对 $T\subseteq W$，是否命中和是否极小都只取决于各个 $T\cap E=T\cap(E\cap W)$。所以
$
\mathcal M(H|_W)=\{T\in\mathcal M(H): T\subseteq W\}.
$

令 $k=\deg P_H$，从 $W=V$ 开始按任意顺序尝试删点。若删去 $v$ 后的多项式仍有非零 $z^k$ 系数，保留删除。否则保持 $v$。所有轮次均保留至少一个大小为 $k$ 的候选。当某点不能删去时，当时所有大小为 $k$ 的候选都包含它，以后候选只会减少。因此最后每个 $W$ 中的顶点都属于仍然存在的候选，且该候选也包含于 $W$。最终 $W$ 自身就是一个最大极小横截。至多进行 $n$ 次附加的多项式计算。

现在取 $H=(V(G),\mathcal C(G))$。强弦图是弦图，可以用完美消去序在多项式时间枚举至多 $n$ 个极大团。具体而言，每个极大团等于其消去序首点与该点所有后继邻点形成的团，筛掉不极大的团并合并重复项即可 [5]。Farber 的刻画说明强弦图的极大团超图是完全平衡的，因此其关联二分图没有长度至少六的诱导环 [4, 6]。它满足前述 $\beta$ 无环条件。此超图的极小横截就是 $G$ 的极小团横截。由第 2 节求其大小分布和最大次数，再由本节得到相应点集。

**推论。** 原文第 5 节同时列出的叶幂图也有相同的多项式算法，因为每个叶幂图都是强弦图 [7]。算法只需输入图本身。

## 参考文献

1. Lars Jaffke, Paloma de Lima, Amir Nikabadi. *Upper Clique Transversal on Interval Graphs and Beyond*. MFCS 2026, 99:1–99:15. [第 5 节](https://doi.org/10.4230/LIPIcs.MFCS.2026.99)
2. Martin Milanič, Yushi Uno. *The Upper Clique Transversal Problem: Hardness and Algorithms*. arXiv:2309.14103v4. [预印本](https://arxiv.org/abs/2309.14103)
3. Benjamin Bergougnoux, Florent Capelli, Mamadou Moustapha Kanté. *Counting Minimal Transversals of β-Acyclic Hypergraphs*. Journal of Computer and System Sciences 101, 21–30, 2019. [第 12 定理](https://arxiv.org/abs/1808.05017) · [期刊版](https://doi.org/10.1016/j.jcss.2018.10.002)
4. Florent Capelli. *Structural Restrictions of CNF-formulas: Applications to Model Counting and Knowledge Compilation*. 2016. [定理 1.36](https://chercheurs.lille.inria.fr/~fcapelli/publi/these_capelli.pdf)
5. Robert E. Tarjan, Mihalis Yannakakis. *Simple linear-time algorithms to test chordality of graphs, test acyclicity of hypergraphs, and selectively reduce acyclic hypergraphs*. SIAM Journal on Computing 13(3), 566–579, 1984. [DOI](https://doi.org/10.1137/0213035)
6. Martin Farber. *Characterizations of strongly chordal graphs*. Discrete Mathematics 43(2–3), 173–189, 1983. [DOI](https://doi.org/10.1016/0012-365X(83)90154-1) · [完全平衡极大团超图的表述](https://doi.org/10.1016/j.dam.2014.09.003)
7. Max Dupré la Tour, Manuel Lafond, Ndiamé Ndiaye, Adrian Vetta. *k-Leaf Powers Cannot Be Characterized by a Finite Set of Forbidden Induced Subgraphs for k ≥ 5*. ICALP 2025, 72:1–72:17. [第 1.1 节](https://doi.org/10.4230/LIPIcs.ICALP.2025.72)
