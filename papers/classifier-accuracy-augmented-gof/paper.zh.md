# 用单个扩充字母表二值分类器消除稀疏拟合度检验的额外对数损失

## 摘要

Gerber、Han 与 Polyanskiy 用分类准确率做分布检验，并在大字母表的稀疏拟合度场景留下额外对数因子。本稿证明，在已知参照分布且允许逐观测独立加一个随机标签的范围内，一个训练后的二值分类器即可消除该损失。将每个符号分成若干副本，再补加已知的 Poisson 计数，使所有副本在零假设下期望计数相同。训练分类器只判断副本是否被占用。留出集的准确率差达到稀疏区间的最优样本量阶数。

## 1. 算法和结论

未知分布 $p$ 与已知参照分布 $q$ 定义在 $k$ 个符号上。检验 $p=q$ 对 $\operatorname{TV}(p,q)\ge\epsilon$，其中 $0<\epsilon\le1$。每个符号 $i$ 变成 $r_i=\max(1,\lceil kq_i\rceil)$ 个副本。每次观测独立均匀选中一个副本。变换保持总变差距离，与原始分布的统计样本数相同。扩充参照分布 $q'$ 的每个概率至多为 $1/k$，副本数至多 $2k$。

令 $1\le n\le k$。预留 $2n$ 个训练观测和 $n$ 个未知分布留出观测；从已知参照模拟 $n$ 个留出观测。独立抽取 $L\sim\operatorname{Pois}(n)$，若 $L>2n$ 则接受零假设。用前 $L$ 个训练观测统计副本计数，再向副本 $j$ 加一个均值为 $n(1/k-q'_j)$ 的独立 Poisson 计数。分类集合 $S$ 是最终计数为正的副本。若 $|S|>4n$ 则接受，否则仅考察两份留出样本落在 $S$ 内的比例差，绝对值达到 $n\epsilon^2/(48k)$ 时拒绝。

两类错误概率均至多为 $5\exp(-n^2\epsilon^4/(92160k))$。在
$\lceil\sqrt{92160k\log(5/\delta)}/\epsilon^2\rceil\le k$
时，错误概率至多 $\delta$ 所需样本为 $O(\sqrt{k\log(1/\delta)}/\epsilon^2)$。

## 2. 为何一个集合就够

令 $\lambda=n/k$，$y_j=n(p'_j-q'_j)$。补加后的计数独立服从 $\operatorname{Pois}(\lambda+y_j)$，总期望不超过 $2n$。占用指示 $B_j$ 的分离量为 $T=\sum_j y_j B_j$。利用 $\sum_j y_j=0$，

$$E T=e^{-\lambda}\sum_j y_j(1-e^{-y_j})\ge\frac16\sum_j\min(y_j^2,|y_j|).$$

总绝对差至少 $2n\epsilon$。将小坐标用 Cauchy–Schwarz 合并、大坐标用一次矩计数，得到 $E T\ge n^2\epsilon^2/(12k)$。对 $|y_j|\le1$ 使用有界展开，对 $y_j>1$ 使用空盒概率至多 $e^{-y_j}$，即可推得逐项的单侧指数矩界。独立相乘后，分离量掉到期望一半以下的概率至多 $e^{-E T/128}$。

训练占用数由总计数控制，因而高概率有 $q'(S)\le4n/k$。给定训练集，两个留出量是独立伯努利平均。对其差应用 Bernstein，并加上训练守卫的失败概率，即得上述显式错误率。完整证明与常数见英文稿。

## 3. 适用范围

训练后的分类器在带副本标签的扩充字母表上是同一个二值函数。若只给原始符号，每次预测需独立生成副本标签。本文因此建立增强预处理范围下的稀疏已知参照结论。要求分类器在原字母表上只输出预先固定标签、或参照分布未知的情形，仍需另行处理。

## 参考文献

- Patrik R. Gerber, Yanjun Han and Yury Polyanskiy. *Minimax optimal testing by classification*. COLT 2023, §3.1.3. [论文](https://proceedings.mlr.press/v195/gerber23a.html)
- Ilias Diakonikolas and Daniel M. Kane. *A new approach for testing properties of discrete distributions*. 2016. [全文](https://arxiv.org/abs/1601.05557)
