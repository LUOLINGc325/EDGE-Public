# 一维随机 Pauli 读出恢复 GHZ 相位的最优对数深度

## 摘要

考虑已经制备好的 $n$ 比特 GHZ 相位探针。读出先在一维链上运行无辅助比特、无中途测量的近邻电路，再独立均匀选择每个比特的 $X,Y,Z$ 测量轴。本文证明，在这一读出模型中，恢复 GHZ 相位的固定正量子 Fisher 信息比例需要且只需要 $\Theta(\log n)$ 层两比特门。任意浅预处理电路的读出受一个显式指数上界约束。由短 GHZ 块组成的确定性 Clifford 预处理给出匹配的充分深度，在一般工作点的保留比例有精确乘积公式。允许记录单比特相位随机化时，构造对所有相位工作点都有统一的下界。

## 1. 模型与结果

取 $n\ge 1$，初始探针为

$$|\psi_\phi\rangle=(|0^n\rangle+e^{i\phi}|1^n\rangle)/\sqrt 2.$$

相位参数 $\phi$ 的量子 Fisher 信息为 $J=1$。若实验参数 $\theta$ 使 $\phi=n\theta$，量子与经典 Fisher 信息都乘以 $n^2$，比例相同。预处理 $U$ 选定时不依赖未知的 $\phi$，允许任意单比特门与深度至多 $t$ 的相邻两比特门，各层中两比特门互不相交。无中途测量、反馈或辅助比特。电路后每个站点独立均匀选轴，记录所有轴与本征值。普通得分 Fisher 信息为 $I(\phi)=\sum_{s:p_s(\phi)>0} p_s'(\phi)^2/p_s(\phi)$。对相位无关的电路随机选择，记录所用电路标签。

**定理 1（必要深度）。** 对每个上述深度 $t$ 的 $U$，设 $m=\lceil n/(4t+1)\rceil$。在每个工作点，

$$\frac{I(\phi)}{J}\le
\min\{1,\ 2(1-6^{-(2t+1)})^m\}
\le \min\{1,\ 2e^{-m6^{-(2t+1)}}\}.$$

若 $U$ 为 Clifford 电路，设 $m_C=\lceil n/(2t+1)\rceil$，则进一步有

$$\frac{I(\phi)}{J}\le (1-3^{-(2t+1)})^{m_C}.$$

上述界也适用于由同样深度上限的电路形成的有限混合。特别是 $t=o(\log n)$ 时，最优比例趋于零。若对任意大 $n$ 都要保留某个固定比例 $c>0$，任意门版本要求 $t\ge \log n/(2\log 6)-O_c(\log\log n)$。

**定理 2（充分深度）。** 把链划分为连续块，块长 $h_1,\dots,h_m\ge1$。存在两比特门深度至多 $2(\max_j h_j-1)$ 的确定性近邻 Clifford 电路，使一切 $\phi\notin (\pi/2)\mathbb Z$ 满足

$$\frac{I(\phi)}{J}=\prod_{j=1}^m\left(1-\tfrac12(2/3)^{h_j}\right).$$

对所有 $\phi$，可在该电路前对一个输入比特等概率施加 $I$ 或 $S=\operatorname{diag}(1,i)$ 并记录选择。所得 Clifford 读出满足

$$\frac{I(\phi)}{J}\ge\tfrac12\prod_{j=1}^m(1-(2/3)^{h_j}).$$

取 $s=\lceil2\log n/\log(3/2)\rceil$。对足够大的 $n$，设 $m=\lfloor n/s\rfloor$，取前 $m-1$ 块长度 $s$，最后一块长度介于 $s$ 与 $2s-1$。深度低于 $4s$。一般工作点的比例至少 $1-1/(2n)$，带单比特 Clifford 相位随机化的比例对所有工作点至少 $(1-1/n)/2$。因此固定正比例所需的最优深度阶为 $\Theta(\log n)$。

## 2. 相位 Fisher 信息与分支可区分性

对固定读出，令 $|x\rangle=U|0^n\rangle$，$|y\rangle=U|1^n\rangle$。将轴选择概率包含在秩一测量元素中，记分支的分布为 $a=(a_s)$、$b=(b_s)$。对相位探针，某结果的概率可写成

$$p_s(\phi)=\tfrac12(a_s+b_s+2\sqrt{a_sb_s}\cos(\phi+\gamma_s)).$$

$a_sb_s=0$ 时，概率与相位无关。设 $a_s\ge b_s>0$，令 $\alpha=\phi+\gamma_s$。当 $p_s>0$ 时，该结果的 Fisher 项为

$$\frac{2a_sb_s\sin^2\alpha}{a_s+b_s+2\sqrt{a_sb_s}\cos\alpha}\le 2b_s.$$

分母减去 $a_s\sin^2\alpha$ 等于 $(\sqrt{b_s}+\sqrt{a_s}\cos\alpha)^2$。交换 $a_s,b_s$ 得同样的结论。因此 $I(\phi)\le 2\sum_s\min(a_s,b_s)\le 2\mathcal A(a,b)$，其中 $\mathcal A(a,b)=\sum_s\sqrt{a_sb_s}$ 为经典 Hellinger 亲和度。普通得分约定直接忽略零概率结果。若用本相位路径的连续极限 Fisher 信息，相同上界由逐项极限成立。

还可直接得到任意固定设置的 $I\le J=1$。去掉纯态导数的全局相位部分后，切向量 $v$ 的范数为 $1/2$。每项 $p_s'^2/p_s$ 至多为 $4\langle v|E_s|v\rangle$，因为正半定测量元素 $E_s$ 给出 Cauchy–Schwarz 不等式。由 $\sum_s E_s=I$ 求和即可。

## 3. 任意近邻预处理的下界

令 $B_j$ 为以站点 $j$ 为中心、半径 $t$ 的输出区间，边缘处按物理链截断。每层相邻门只把算符支撑扩大至多一个站点，故 $UZ_jU^\dagger$ 支撑在 $B_j$。两个完整分支是这个算符的 $+1,-1$ 本征态。于是分支约化密度矩阵 $\rho_j,\sigma_j$ 分别支撑在该区间局部算符的两个正交本征子空间。这可由相反本征空间投影的期望为零推出。设 $k=|B_j|$，则 $\rho_j+\sigma_j\preceq I_{2^k}$ 且 $\|\rho_j-\sigma_j\|_1=2$。迹范数与 Hilbert–Schmidt 范数比较给出 $\|\rho_j-\sigma_j\|_2^2\ge 4/2^k$。

固定这个区间，记全部轴和结果为 $e=(A,z)$，测量元素为 $wP_e$，其中 $w=3^{-k}$，$P_e$ 为秩一乘积投影。设 $p_e=w\operatorname{tr}(P_e\rho_j)$，$q_e=w\operatorname{tr}(P_e\sigma_j)$，$R=\rho_j-\sigma_j$。因为 $p_e+q_e\le w$，亲和度满足

$$
1-\mathcal A(p,q)
=\tfrac12\sum_e(\sqrt{p_e}-\sqrt{q_e})^2
\ge\tfrac14\sum_e(p_e-q_e)^2/w.
$$

这里 $p_e=q_e=0$ 的项为零，其余项使用 $(\sqrt{p_e}+\sqrt{q_e})^2\le 2(p_e+q_e)$。对单比特，令 $e_1$ 对应六个 Pauli 本征投影之一，算符框架 $T(H)=\tfrac13\sum_{e_1}\operatorname{tr}(P_{e_1}H)P_{e_1}$ 在 $I$ 上特征值为 $1$，在 $X,Y,Z$ 上均为 $1/3$。在 $k$ 个比特上的框架是其张量幂，最小特征值为 $3^{-k}$。因此

$$1-\mathcal A(p,q)\ge \tfrac14\langle R,T^{\otimes k}(R)\rangle
\ge \tfrac14\,3^{-k}\|R\|_2^2\ge 6^{-k}.$$

选中心 $j=1+(4t+1)r\le n$。区间 $B_j$ 上任意输出算符的输入支撑至多为半径 $2t$ 的截断区间。不同中心的这些输入支撑互不相交。在任一初始分支的乘积态中，对分块测量事件的联合概率等于各边缘概率的乘积。形式上，对输出效果的乘积作 $U^\dagger(\cdot)U$ 共轭得到恰好是各拉回效果的乘积，再利用其支撑不交与初始乘积态。边缘亲和度因此相乘。丢弃其余站点按 Cauchy–Schwarz 增大亲和度，完整读出的亲和度至多为 $(1-6^{-(2t+1)})^m$。结合第 2 节得到任意近邻电路的界。

Clifford 情形中 $UZ_jU^\dagger$ 为一个带符号的 Pauli 字。若最终轴在该字的每个非恒等位置都选中对应轴，测量读取它的本征值，每个完整结果至多来自一个分支，故该设置的相位 Fisher 信息为零。选间距 $2t+1$ 的中心使这些匹配事件相互独立，每个的概率至少 $3^{-(2t+1)}$。整体比例至多为未发生任一次匹配的概率。随机电路标签独立于相位，故其 Fisher 信息是条件信息的加权平均。

最后，$m\ge n/(4t+1)$。若 $I/J\ge c$，则 $m6^{-(2t+1)}\le \log(2/c)$。当 $t\ge\log n$ 时所述必要深度直接成立，其他情况下取对数并用 $\log(4t+1)\le O(\log\log n)$。

## 4. 匹配的近邻 Clifford 构造

在长度 $h$ 的块中，令 $F_h$ 依次按 $1\to2,2\to3,\dots,(h-1)\to h$ 施加 CNOT。它把 $|0^h\rangle$ 固定，并把 $|1,0,\ldots,0\rangle$ 送到 $|1^h\rangle$。因此 $F_h(H\otimes I^{\otimes h-1})F_h^\dagger$ 将 $|0^h\rangle,|1^h\rangle$ 分别送到两个归一化猫态 $(|0^h\rangle\pm|1^h\rangle)/\sqrt2$。在各块并行运行，所需两比特门深度为 $2(\max_jh_j-1)$。输入是一条跨全部块的 GHZ 相位相干叠加，电路后的两个完整分支分别是各块的正猫态、负猫态的张量积。

对一个块及一个固定的局部 Pauli 设置，令局部测量结果向量对 $|0^h\rangle,|1^h\rangle$ 的振幅为 $A,B$。猫态振幅成比例于 $A+B,A-B$。

- 设置包含至少一个 $Z$ 时，$A$、$B$ 至少一个为零。同一结果的两个猫态振幅模相等，相对相位是 $\pm1$，或两个振幅同时为零。
- 设置全是 $X/Y$ 时，$B/A$ 是四次单位根。$Y$ 个数为偶数给出 $B/A=\pm1$，每个结果至多来自一个猫态分支。$Y$ 个数为奇数给出 $B/A=\pm i$，此时猫态振幅模相等，相对相位为 $\pm i$。

因此出现任一全 $X/Y$ 且偶数 $Y$ 的块时，整个设置的 Fisher 信息为零。否则，各完整结果的两个分支具有相同概率 $a_s$，相位比为 $r_s\in\{+\eta,-\eta\}$，其中 $\eta\in\{1,i,-1,-i\}$ 固定于此设置。由分支正交，$\sum_s a_s r_s=0$，且 $\sum_s a_s=1$。在 $\phi\notin (\pi/2)\mathbb Z$ 下，所有 $a_s>0$ 的结果皆有正概率，Fisher 项等于 $a_s(1-\operatorname{Re}(e^{i\phi}r_s))$，故总和精确为 $1$。每块发生全 $X/Y$ 且偶数 $Y$ 的概率为 $(2/3)^h/2$，因为在 $2^h$ 个 $X/Y$ 标签串中切换第一项可配对奇偶性。各块轴选择独立，得到精确公式。

当每块至少有一个 $Z$，相位比分布只含实号，除 $\phi\in\pi\mathbb Z$ 外信息等于 $1$。记录 $I/S$ 的等概率随机选择将工作点替换为 $\phi$ 或 $\phi+\pi/2$，至少一个避开该例外。在所有块都含 $Z$ 的设置上，平均信息至少 $1/2$。独立块的设置概率给出一致下界。

## 5. 范围与文献

Li 与 Liu 的第 VIII 节把无预处理均匀局部 Pauli 的 GHZ 相位盲区列为提出层深问题的例子。本文固定该探针以及该随机末端读出，求解一维情形的深度阶。Du 等人的最坏情形深度定理用随机乘积态编码的正交叠加作为隐藏态，并允许任意末端幺正基读出。其可见区用近似 3-design 一致恢复所有纯态编码。本文的必要界给出原始 GHZ 的显式隐藏机制与逐深度界，充分界给出无需近似设计的适配电路以及每个分块尺寸对应的精确 Fisher 比例。Schuster 等人分析了近似设计深度，Clifford 证明可视为将他们的支撑匹配思路应用到 GHZ 两支相位。任意门证明使用局部读出亲和度。

自由挑选固定测量轴的模型允许全 $X$ 在一般 GHZ 相位工作点以零两比特门深度读出，因此独立均匀选轴是必要界的关键假设。本文保留深度阶，两侧常数仍有间隔。结果覆盖理想的单副本读出与 GHZ 相位探针。对固定门分布的未知纯态一致恢复、非单位操作或噪声读出属于其他模型。

- W. Li and J. Liu, *The exact information cost of randomized measurements in quantum metrology*, §VIII and Appendix A, arXiv:2611.00599v1. [原文](https://arxiv.org/html/2611.00599v1)
- Z. Du, S. Cheng, H. Ye, J. Chen, X. Yuan and X. Ma, *Complexity-driven transitions in quantum observation*, Theorems 1–3 and 5, arXiv:2606.09765v1. [记录](https://arxiv.org/abs/2606.09765)
- T. Schuster, J. Haferkamp and H.-Y. Huang, *Random unitaries in extremely low depth*, §4.2, arXiv:2407.07754v2. [原文](https://arxiv.org/html/2407.07754v2)
