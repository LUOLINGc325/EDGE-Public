# 奇素数稳定子多重 Rényi 复制收缩的正相位

**摘要**　证明任意奇素数局域维数、任意纯稳定子态、任意分组和整数复制指标的多重 Rényi 收缩均为正，且等于 $p^{-\operatorname{rank}B/2}$，其中 $B$ 是相应复制二次相位的极化矩阵。核心是复制坐标的反射会交换 ket 与 bra 两项，使二次型成为反射正负子空间之间的交叉型。该证明也覆盖 $p\mid n$ 的不可半单指标。若 $p\nmid n$，有限域 Fourier 符号为交替矩阵，由此得到加权无偶环图的碰撞计数多项式。

## 1. 复制相位

取局域维数奇素数 $p$，加权简单图的顶点集有 $N$ 个 qudit，$w_{uv}=w_{vu}\in\mathbb F_p$，缺边权为 0。顶点可以任意分到 $q$ 个非空方。设 $n\ge2$，复制组 $G=(\mathbb Z/n)^{q-1}$，各方移位为标准基，参考方为 0，顶点 $u$ 所取移位记 $g_u$。图态振幅为 $p^{-N/2}$ 乘二次相位。按标准 Rényi 复制收缩 [1,2]，记 $V=\mathbb F_p^{N|G|}$，则
$$
\begin{aligned}
 Z_n&=p^{-N|G|}\sum_{x\in V}\exp(2\pi i Q(x)/p),\\
 Q(x)&=\sum_{s\in G}\sum_{u<v}w_{uv}
 \bigl[x_u(s)x_v(s)-x_u(s+g_u)x_v(s+g_v)\bigr].
\end{aligned}
$$
负号来自 bra 的复共轭。相同方内的边因共同重标 $s$ 自动相消。正的 $Z_n$ 使按 [1] 正规化的对数熵有确定实值。

## 2. 复制反射与 Gauss 相位

**定理。** 设 $B(x,y)=Q(x+y)-Q(x)-Q(y)$，则对所有 $n\ge2$ 有
$$
 Z_n=p^{-\operatorname{rank}_{\mathbb F_p}(B)/2}>0 .
$$
此式对纯奇素数稳定子态与任意方分割成立。

定义 $Jx$ 在顶点 $u$ 的复制坐标为 $(Jx)_u(s)=x_u(-s+g_u)$。它是线性对合。代入未移位项并取 $s'=-s$，得到旧移位项。代入移位项有 $(Jx)_u(s+g_u)=x_u(-s)$，得到旧未移位项。因此 $Q(Jx)=-Q(x)$。由于 $2$ 可逆，$V=V_+\oplus V_-$，其中 $J|_{V_\pm}=\pm I$。在任一特征子空间，$Q(Jx)=Q(x)$，负空间使用二次齐次性 $Q(-x)=Q(x)$。故 $Q$ 在两个子空间上都恒为零。

对 $x=x_++x_-$，$Q(x)=B(x_+,x_-)$. 选取两个子空间的基，交叉矩阵记 $C$。极化矩阵是 $\left(\begin{smallmatrix}0&C\\C^T&0\end{smallmatrix}\right)$，秩为 $2\operatorname{rank}C$。先对 $x_+$ 求和，字符正交性消去 $Cx_-\ne0$ 的项，剩余部分为 $p^{\dim V_+}|\ker C|$。除以总规模便得公式。这里的对合仅用复制组的取逆，不需 $p$ 与 $n$ 互素。

在奇素数维数，每个纯稳定子态经过逐 qudit 的局部 Clifford 可化为加权图态 [3, 引理 7]。逐 qudit 的操作合并后仍是在每一方内的局部酉。复制收缩对这些酉不变，因为同一方的复制置换与该方酉的各副本张量积对易 [1, 引理 2.2]。故图态公式给出一般纯稳定子态的相位。

**奇复合维数的图态推论。** 若局域标签改为 $\mathbb Z_d$，$d$ 是任意奇数，且相位为上述图态二次式模 $d$，同一证明成立到交叉型。此时 $2$ 在模 $d$ 可逆，$J$ 的正负部分仍为直和。交叉型给群同态 $C\colon V_-\to\operatorname{Hom}(V_+,\mathbb Z_d)$。对 $V_+$ 作有限群字符正交求和，得到 $Z_n=|\ker C|/|V_-|=1/|\operatorname{im}C|>0$。该复合维数推论针对模 $d$ 图态定义。

## 3. Fourier 交替矩阵与碰撞多项式

以下取 $p\nmid n$。令平移 $T_h f(s)=f(s+h)$。由极化的定义，跨顶点 $u,v$ 的块是 $w_{uv}(I-T_{g_v-g_u})$。在包含所有 $n$ 次单位根的有限扩域中，复制平移按字符 $\chi$ 同时对角化，且扩标量不改变原秩。置 $t_u=\chi(g_u)$，第 $u$ 行乘以 $t_u$ 后，该字符块恰为
$$
 \Upsilon(t)_{uv}=w_{uv}(t_u-t_v),\qquad
 -\log_p Z_n=\frac12\sum_{t}\operatorname{rank}\Upsilon(t).
$$
在奇特征这仍是交替矩阵。字符标签等价于为每方选择一个 $n$ 次根，参考方固定为 1。$p\mid n$ 时仍使用定理中的全复制极化秩公式。

如果加权支撑图不含偶环，每个 $\Upsilon(t)$ 的半秩恰为活跃边图的最大匹配数。任一非零主 Pfaffian 给出匹配上界。反过来，最大匹配覆盖的顶点上如有另一完美匹配，其对称差会产生偶环。因此所选最大匹配是该主 Pfaffian 中唯一的非零项，其权重积非零。这个判据不依赖于具体非零边权。

于是对任意无偶环加权图和任意分组，在 $p\nmid n$ 的全部指标上有统一多项式
$$
 -\log_p Z_n=\sum_{\pi\vdash[q]}(n-1)_{|\pi|-1}\nu(G_\pi).
$$
这里 $\pi$ 是方标签的等色划分，$(x)_r$ 是降阶乘，$G_\pi$ 删去两端所属方在同一个色块内的边。因锚定色块固定为 1，其余色块注入余下 $n-1$ 种颜色，得到该系数。此式给出原文碰撞控制判据在奇素数加权图上的一个具体范围。

## 4. 文献与边界

1. B. Czech 等，*Rényi Multi-entropy for Stabilizer States: A Finite Field Gauss Sum Problem*, arXiv:2610.26814，式 (3)–(6)、引理 2.2 以及 §5.2 的素数维加权图态和特例。
2. S. Akella 与 A. Gadde，*Rényi multi-entropy of graph states and the n to 1 limit*, arXiv:2610.27080，式 (7)–(9) 和展望。该文明确提出须确定素数维图态的 Gauss 相位和合适的碰撞判据。
3. M. Bahramgiri 与 S. Beigi，*Graph States Under the Action of Local Clifford Group in Non-Binary Case*, arXiv:quant-ph/0610267，引理 7 给出非二元的局部 Clifford 图态标准形。

正相位结论覆盖奇素数纯稳定子态的全部整数复制指标。无偶环的碰撞多项式使用半单条件 $p\nmid n$，适用域与相位定理各自如上。奇复合维数推论适用于所给二次图态振幅。
