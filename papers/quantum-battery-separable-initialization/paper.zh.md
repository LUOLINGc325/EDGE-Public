# 完全图量子电池中可分初态的精确充电功率

*初始无关联可达性问题的有限规模解析解*

AI 辅助研究稿

2026 年 11 月 24 日 · 研究稿 v1

## 摘要

本文研究 Mathew [1] 的完全图非对易量子电池：如果电池起初完全处于基态能量子空间，且电池与辅助系统之间没有初始纠缠，最大充电功率究竟是多少？设完全图顶点数为 $M=2m$，并令 $q=\lfloor m/2\rfloor$。我们对原文同一组哈密顿量证明精确公式

$$
\max_{\rho_0\in\mathcal S_-}\ \max_{t\geq0}|P_{\rho_0}(t)|
=2\sqrt2\left(1+\frac{2q}{m}\right),
\tag{1}
$$

其中 $\mathcal S_-$ 是电池基态能区内、相对于“电池：辅助系统”划分可分的全部初态。上界可由显式乘积态达到，且辅助系统可以具有任一预先指定的总费米宇称。允许任意联合基态能区初态时的对应最优值是 $2\sqrt2\,m$。因此，当 $m\geq3$ 时，该模型的联合最优功率确实需要初始电池–辅助系统纠缠，经典初始关联不能替代它。

在原论文采用的能量范数归一化下，可分初态最优功率按 $N^{3/2}$ 增长，而任意联合初态可达到 $N^2$；这里 $N=m(2m-1)$ 是电池自旋数。证明把动力学化成两个实反对称关联矩阵的内积，用其成对出现的奇异值给出紧界及奇偶修正。本结论只适用于所列模型和初始化条件，不是“所有量子电池优势都需要纠缠”的一般定理。

## 1. 研究问题与通俗解释

可以把原论文的模型理解为一组电池自由度和一个辅助系统共同工作。原文已经证明：适当选择二者的联合起点，可以在充电过程中实现较大的功率；但这个起点可能已经让电池与辅助系统存在关联。原文结论明确留下一个问题：如果起点要求两者没有关联，同样的增强还能否实现？[1]

本文固定原有电池、原有充电驱动和原有基态准备条件，直接优化全部允许初态。我们得到的不是一个保守估计，而是“上界加达到它的方案”，从而确定真正的最优值。

需要区分三个条件。

- **乘积初态**是 $\sigma_B\otimes\eta_A$，电池与辅助系统起初没有关联。
- **可分初态**还允许 $\sum_\ell w_\ell\sigma_{B,\ell}\otimes\eta_{A,\ell}$，可以有经典关联，但没有跨越这一划分的纠缠。
- **任意联合初态**允许跨越这一划分的纠缠。

电池内部的自旋可以相互纠缠，辅助系统内部也可以有复杂关联。限制只施加在初始时刻，充电过程中产生的纠缠完全允许。即使给可分初态这些自由，它仍无法达到随规模增长的联合最优增强。

本文的候选新增贡献是：精确的有限规模最优值、固定辅助宇称下的饱和构造，以及容量比例和归一化功率的推论。原有电池模型、任意联合态的最优值、Clifford 代数和关联矩阵收缩性都是已有材料，不作为方法首创。相邻文献 [2–4] 使用不同模型或不同资源划分；尤其一般量子电池的优势并不普遍要求纠缠 [4]。

本稿不处理其他哈密顿量、有限温度初态、微扰、耗散、其他系统划分，也不解决一般非对易电池局域性上界是否最紧的问题。查新结论只覆盖已记录文献；未声称全球优先权，尚无外部同行评议。

## 2. 模型和主定理

### 2.1. 原始自旋与辅助系统

固定整数 $m\geq1$，令 $M=2m$。完全图 $K_M$ 的每条边上放一个自旋，电池自旋总数为

$$
N=\binom{2m}{2}=m(2m-1).
$$

用 $X_e,Y_e,Z_e$ 表示边 $e$ 上的 Pauli 矩阵。定义星形算符

$$
P_a=\left(\prod_{b<a}Z_{e_{ab}}\right)
     \left(\prod_{b>a}X_{e_{ab}}\right),
\qquad H_B=\sum_{a=1}^{2m}P_a.
\tag{2}
$$

任意两个不同的星形算符只共享一条边，且该边在两者中分别带 $X$ 和 $Z$。因此 $P_a^2=I$，且 $\{P_a,P_b\}=0$（$a\ne b$）。花括号表示反对易子 $\{A,B\}=AB+BA$。

选择匹配边 $(1,2),(3,4),\ldots,(2m-1,2m)$，记 $Y_r=Y_{e_{2r-1,2r}}$。在独立辅助空间上取满足标准反对易关系的厄米 Majorana 算符 $\chi,\gamma_1,\ldots,\gamma_m$，定义

$$
Q_r=i\chi\gamma_r,\qquad
H_C=\sum_{r=1}^mY_r\otimes Q_r.
\tag{3}
$$

$Q_r$ 是厄米对合算符，即 $Q_r^\dagger=Q_r$、$Q_r^2=I$，且 $\{Q_r,Q_s\}=2\delta_{rs}I$。它由两个 Majorana 算符相乘，因此保持总费米宇称。辅助系统取通常的完整费米 Fock 表示；物理 Majorana 数需要为偶数时，可补一个不参与哈密顿量的算符。第 5 节给出具体实现，并说明限制在任一固定总宇称后仍能达到上界。

电池和辅助系统上的算符彼此对易。不同 $Y_r$ 也对易，所以

$$
H_B^2=2mI,\qquad H_C^2=mI.
\tag{4}
$$

令

$$
G=\frac{H_B}{\sqrt{2m}},\qquad
\Pi_\pm=\frac{I\pm G}{2}.
$$

电池仅有两个能量值 $\pm\sqrt{2m}$，但对应子空间可以高度简并；$\Pi_-$ 投影到全部基态能区，绝非选定某一个基态向量。以后省略电池投影后面的 $\otimes I_A$。初态满足 $\rho_0=\Pi_-\rho_0\Pi_-$。取 $\hbar=1$，直接充电协议为

$$
\rho(t)=e^{-itH_C}\rho_0e^{itH_C},\qquad
P_{\rho_0}(t)=\frac{d}{dt}\operatorname{Tr}(H_B\rho(t)).
\tag{5}
$$

### 2.2. 精确结论

**定理 1（可分初态的紧功率界）。** 记

$$
q=\left\lfloor\frac m2\right\rfloor,
\qquad a_m=1+\frac{2q}{m}.
\tag{6}
$$

对于模型 (2)–(5)，任意位于电池基态能区的可分初态均满足

$$
|P_{\rho_0}(t)|\leq2\sqrt2\,a_m\,
|\sin(2\sqrt m\,t)|.
\tag{7}
$$

存在乘积初态在每个时刻达到等号，其辅助态可处于任一指定的总费米宇称扇区。因此

$$
P_{\mathrm{sep}}^{\max}=
\begin{cases}
4\sqrt2,&m\text{ 为偶数},\\
4\sqrt2-2\sqrt2/m,&m\text{ 为奇数}.
\end{cases}
\tag{8}
$$

允许任意联合基态能区初态时，最优值为

$$
P_{\mathrm{joint}}^{\max}=2\sqrt2\,m.
\tag{9}
$$

两种最优值都在 $t_* =\pi/(4\sqrt m)$ 达到，此后还会周期性出现绝对功率峰值。奇数公式包括 $m=1$。$m=1,2$ 时乘积与联合最优值相同；每个 $m\geq3$ 都有严格差距。

## 3. 将动力学精确化为一个跃迁权重

### 3.1. 电池上的两组 Clifford 算符

定义

$$
B_r=\frac{P_{2r-1}+P_{2r}}{\sqrt2},
\qquad R_r=iB_rY_r.
\tag{10}
$$

$Y_r$ 与 $B_r$ 反对易，与其他 $B_s$ 对易。直接相乘可得

$$
\{B_r,B_s\}=2\delta_{rs}I,\quad
\{R_r,R_s\}=2\delta_{rs}I,\quad
\{B_r,R_s\}=0.
\tag{11}
$$

这说明 $B_1,\ldots,B_m,R_1,\ldots,R_m$ 是 $2m$ 个 Clifford 生成元。这里所需的含义很具体：每个算符都是厄米对合，两个不同算符互换顺序时会变号。例如 $B_rR_r=iY_r$，而 $R_rB_r=-iY_r$；不同指标时，交换两个 $B$ 造成唯一的负号。另有

$$
Y_r=-iB_rR_r,\qquad
G=\frac1{\sqrt m}\sum_{r=1}^mB_r,\qquad
\{G,R_r\}=0.
\tag{12}
$$

令

$$
K=\sum_{r=1}^mR_r\otimes Q_r,
\qquad T=\Pi_+H_C\Pi_-.
\tag{13}
$$

$T$ 是从电池基态能区跃迁到激发能区的充电算符块。利用 $[G,Y_r]=-2iR_r/\sqrt m$，得到

$$
T=-\frac i{\sqrt m}K\Pi_-,\qquad
T^\dagger T=\frac1m\Pi_-K^2\Pi_-.
\tag{14}
$$

第二式作为全空间算符恒等式必须保留两侧投影；只有将定义域限制在基态能区时，才能简写为 $K^2/m$。不同的 $R_r\otimes Q_r$ 两两对易，因为电池端与辅助端各贡献一个负号。$K^2$ 与 $G$ 对易。

### 3.2. 任意基态能区初态的时间演化

这一时间演化的纯态版本已见原论文 [1] 补充材料式 (111)–(113)，其记号与本文满足 $k=mw_g$。下面重述该公式并按线性性推广到混态；本文新增的优化结论是后续对可分初态上 $k$ 的紧界。

由 $H_C^2=mI$，

$$
e^{-itH_C}=\cos(\sqrt m\,t)I
-\frac{i\sin(\sqrt m\,t)}{\sqrt m}H_C.
\tag{15}
$$

定义非负跃迁权重

$$
k(\rho_0)=\operatorname{Tr}(\rho_0T^\dagger T).
\tag{16}
$$

初态支撑在 $\Pi_-$ 内，向激发能区投影时，(15) 中的单位算符项消失。因此激发能区概率恰为

$$
p_+(t)=\frac{k(\rho_0)}m\sin^2(\sqrt m\,t).
\tag{17}
$$

电池只有两个能量值，故对纯态和混态都有

$$
\begin{aligned}
E_B(t)&=-\sqrt{2m}
+2\sqrt{2m}\,\frac{k(\rho_0)}m\sin^2(\sqrt m\,t),\\
P_{\rho_0}(t)&=2\sqrt2\,k(\rho_0)\sin(2\sqrt m\,t).
\end{aligned}
\tag{18}
$$

于是，优化所有初态和所有时间的问题，等价于优化与时间无关的标量 $k$。这一化简没有假设充电过程中保持可分。

## 4. 可分准备的精确上界

### 4.1. 任意 Clifford 状态的关联矩阵

设 $X_1,\ldots,X_m$ 满足 $\{X_r,X_s\}=2\delta_{rs}I$，$\omega$ 是任意密度算符。定义

$$
\Gamma_{rs}=\frac i2\operatorname{Tr}\bigl(\omega[X_r,X_s]\bigr).
\tag{19}
$$

$\Gamma$ 是实反对称矩阵：对角线为零，$r\ne s$ 时 $\Gamma_{rs}=i\operatorname{Tr}(\omega X_rX_s)$。我们称其为关联矩阵，不假设状态为 Gaussian 态，也不引入减去一阶矩的额外定义。

反对称标准块形与收缩条件是费米关联矩阵理论中的经典结构，可参见 Bravyi [5] 第 IV 节。下面给出适用于任意状态、任意奇偶 $m$ 的完整证明，不依赖 Gaussian 态重构或 Wick 规则。

这里 $\|A\|_{\mathrm{op}}$ 是最大奇异值，$\|A\|_F^2=\sum_{r,s}|A_{rs}|^2$ 是全部矩阵元模平方之和；实矩阵的内积为 $\langle A,B\rangle_F=\sum_{r,s}A_{rs}B_{rs}$。

**引理 2。** 所有这样的关联矩阵都满足

$$
\|\Gamma\|_{\mathrm{op}}\leq1,
\qquad \|\Gamma\|_F^2\leq2\lfloor m/2\rfloor.
\tag{20}
$$

**证明。** 矩阵 $A_{rs}=\operatorname{Tr}(\omega X_rX_s)=\delta_{rs}-i\Gamma_{rs}$ 是半正定的，因为对任意 $z\in\mathbb C^m$，

$$
z^*Az=\operatorname{Tr}\left[\omega
\left(\sum_rz_rX_r\right)^\dagger
\left(\sum_sz_sX_s\right)\right]\geq0.
$$

其逐项复共轭 $I+i\Gamma$ 也半正定，所以厄米矩阵 $i\Gamma$ 的所有本征值都在 $[-1,1]$ 内。实反对称矩阵可经正交变换写成若干个 $\left(\begin{smallmatrix}0&s_j\\-s_j&0\end{smallmatrix}\right)$ 块，加上可能的零块。非零块最多 $q=\lfloor m/2\rfloor$ 个，且 $|s_j|\leq1$。因此 $\|\Gamma\|_F^2=2\sum_js_j^2\leq2q$。这对任意状态成立，不依赖 Gaussian 假设。证毕。

### 4.2. 乘积初态

取 $\rho_0=\sigma_B\otimes\eta_A$，且 $\sigma_B$ 支撑在 $\Pi_-$。分别用 $R_r$ 和 $Q_r$ 定义 $\Gamma^B$、$\Gamma^A$。展开 (14)，

$$
\begin{aligned}
k(\sigma_B\otimes\eta_A)
&=\frac1m\operatorname{Tr}\bigl((\sigma_B\otimes\eta_A)K^2\bigr)\\
&=1-\frac2m\sum_{r<s}\Gamma^B_{rs}\Gamma^A_{rs}\\
&=1-\frac1m\langle\Gamma^B,\Gamma^A\rangle_F.
\end{aligned}
\tag{21}
$$

这里的负号来自两端各一次 $-i$：$R_rR_s=-i(iR_rR_s)$，$Q_rQ_s=-i(iQ_rQ_s)$。利用 Cauchy–Schwarz 不等式和引理 2，

$$
k\leq1+\frac{\|\Gamma^B\|_F\|\Gamma^A\|_F}{m}
\leq1+\frac{2q}{m}=a_m.
\tag{22}
$$

### 4.3. 允许经典关联的可分初态

设 $\rho_0=\sum_\ell w_\ell\sigma_{B,\ell}\otimes\eta_{A,\ell}$ 可分，且总态位于电池基态能区。去掉零权项后 $w_\ell>0$，并有

$$
0=\operatorname{Tr}(\rho_0\Pi_+)
=\sum_\ell w_\ell\operatorname{Tr}(\sigma_{B,\ell}\Pi_+).
$$

每一项都非负，因此每个电池因子都支撑在基态能区。此处使用的是正矩阵性质：$\operatorname{Tr}(\sigma\Pi_+)=\|\sigma^{1/2}\Pi_+\|_F^2=0$ 蕴含该投影范围内没有支撑。对每个乘积项应用 (22)，再利用 $k$ 对状态的线性性，即得 $k(\rho_0)\leq a_m$。结合 (18)，定理 1 的上界成立。

## 5. 在原始物理表示中达到上界

### 5.1. 电池态的构造与非零性

对 $1\leq j\leq q$ 定义

$$
L_j^B=iR_{2j-1}R_{2j}.
$$

它们是两两对易的厄米对合，并与 $G$ 对易。任取符号 $\varepsilon_j\in\{\pm1\}$，令

$$
E_B=\Pi_-\prod_{j=1}^q\frac{I+\varepsilon_jL_j^B}{2}.
\tag{23}
$$

这是原始边自旋空间中的正交投影，且确实非零。证明如下：在 (11) 的 $2m$ 个生成元中，不重复生成元构成的任何非空单项式都具有零迹。若长度为偶数，用其中一个生成元共轭会改变符号；若长度为奇数，用一个未参与的生成元共轭会改变符号。后者总存在，因为生成元总数 $2m$ 为偶数。共轭不改变迹，故该迹只能为零。

展开 (23)，除单位算符项外，每一项都是上述非空单项式，或者是含一个 $B_r$ 和偶数个 $R_s$ 的此类单项式之和。所以

$$
\operatorname{Tr}E_B=\frac{2^N}{2^{q+1}}>0.
\tag{24}
$$

可取 $\sigma_B=E_B/\operatorname{Tr}E_B$，也可取其像空间中的任意纯态。此时 $\Gamma^B_{2j-1,2j}=\varepsilon_j$，其余非对角元全为零：任何不在所选配对内的双线性算符，都与至少一个固定的 $L_j^B$ 反对易，在对应本征空间内期望值为零。最多只有一个未配对指标，不存在另一个遗漏的双指标情形。

### 5.2. 固定总费米宇称的辅助态

辅助端有

$$
L_j^A=iQ_{2j-1}Q_{2j}=i\gamma_{2j-1}\gamma_{2j}.
\tag{25}
$$

这给出 $q$ 对互不重叠的 $\gamma$。当 $m$ 为奇数时，剩余一对取 $(\chi,\gamma_m)$；当 $m$ 为偶数时，补一个不参与 $H_C$ 的 Majorana $\gamma_0$，剩余一对取 $(\chi,\gamma_0)$。两种情况下总共都是 $2q+2$ 个物理 Majorana，即 $q+1$ 个费米模式。

将 (25) 中的 $q$ 个双线性算符置于本征值 $-\varepsilon_j$。再选择剩余一对的本征值，使总宇称等于预先指定的正或负值。所有配对算符对易；在完整 Fock 表示中，固定这 $q+1$ 个本征值的联合本征空间是一维的。取其纯态密度算符 $\eta_A$，便有

$$
\Gamma^A=-\Gamma^B,\qquad
\|\Gamma^A\|_F^2=\|\Gamma^B\|_F^2=2q.
\tag{26}
$$

非配对项期望为零的理由与电池端相同。该构造没有使用违反总宇称规则的叠加态。

### 5.3. 饱和

对乘积初态 $\rho_0=\sigma_B\otimes\eta_A$，由 (21)、(26) 得 $k=a_m$，再由 (18) 得 (7) 对每个时刻取等号。由此证明上界是精确最优值；并非只有某个抽象关联矩阵能够达到，而是原始物理 Hilbert 空间里确实存在相应状态。

## 6. 联合态基准与物理推论

### 6.1. 复核已有的任意联合态最优值

$\|H_C\|=\sqrt m$ 立即给出 $k\leq m$。为使证明自足，我们也构造达到它的联合态。令 $F_r=R_r\otimes Q_r$，这些对合算符两两对易。投影 $\prod_r(I+F_r)/2$ 的非单位项具有零电池迹，即使辅助空间预先限制在固定总宇称，也仍然如此。因此共同 $+1$ 本征空间非零。

取其中单位向量 $v$。$G$ 与每个 $F_r$ 反对易，所以 $Gv$ 处于共同 $-1$ 本征空间，且与 $v$ 正交。于是

$$
g=\frac{v-Gv}{\sqrt2}
$$

为归一化基态能区向量，并满足 $K^2g=m^2g$。利用 (14)，有 $k=m$，从而恢复原文已经建立的 (9)。这个补充证明也核实了固定辅助总宇称的相容性。

### 6.2. 可充入容量比例与初始纠缠判据

定义储入能量为 $\Delta E_B(t)=E_B(t)-E_B(0)$，电池谱容量为 $2\sqrt{2m}$。由 (17)，可分基态初态最多能够充入的容量比例恰为

$$
f_{\mathrm{sep}}^{\max}
=\frac{\max\Delta E_B}{2\sqrt{2m}}
=\frac{a_m}{m}
=\frac{m+2\lfloor m/2\rfloor}{m^2}.
\tag{27}
$$

储能峰值在 $t_E=\pi/(2\sqrt m)$ 达到，与首次功率峰值 $t_* =\pi/(4\sqrt m)$ 不同。式 (27) 也是 $P_{\mathrm{sep}}^{\max}/P_{\mathrm{joint}}^{\max}$。$m=1,2$ 时为 1，此后下降，并渐近于 $2/m$。这里的容量比例不是可提取功、热力学效率或实验效率。

在模型和基态假设成立时，若观测功率超过 (7)，则可以推断初态跨越“电池：辅助系统”的划分存在纠缠。没有超过不能反推初态可分。该判据针对的是初始化；充电过程中从乘积态产生纠缠，也无法绕过已证明的初态上界。

| $m$ | $M$ | $a_m$ | 可分峰值除以 $2\sqrt2$ | 联合峰值除以 $2\sqrt2$ | 容量比例 |
|---:|---:|---:|---:|---:|---:|
| 1 | 2 | $1$ | $1$ | $1$ | $1$ |
| 2 | 4 | $2$ | $2$ | $2$ | $1$ |
| 3 | 6 | $5/3$ | $5/3$ | $3$ | $5/9$ |
| 4 | 8 | $2$ | $2$ | $4$ | $1/2$ |
| 5 | 10 | $9/5$ | $9/5$ | $5$ | $9/25$ |
| 8 | 16 | $2$ | $2$ | $8$ | $1/4$ |

### 6.3. 资源归一化和增长阶

在 (2)–(3) 未缩放的局部能量标度下，原文对易电池的比较值是 $4\sqrt m$ [1]。本文的可分初态最优值满足 $2\sqrt2\,a_m\leq4\sqrt m$，只有 $m=2$ 取等号。因此，可分初始化不能再现原非对易模型对该比较值的随规模增长的超越。

现在采用原论文针对非对易模型的范数归一化：

$$
\widetilde H_B=\frac{N}{\sqrt{2m}}H_B,
\qquad \widetilde H_C=\frac{N}{\sqrt m}H_C.
\tag{28}
$$

两者的算符范数都成为 $N$。本征向量和可行初态集合不变，振荡频率由 $\sqrt m$ 变为 $N$，从而

$$
\widetilde P_{\mathrm{sep}}^{\max}
=\frac{2N^2}{m}a_m,
\qquad
\widetilde P_{\mathrm{joint}}^{\max}=2N^2.
\tag{29}
$$

结合 $N=m(2m-1)$、$a_m\to2$，得到

$$
\widetilde P_{\mathrm{sep}}^{\max}\sim4\sqrt2\,N^{3/2},
\qquad
\widetilde P_{\mathrm{joint}}^{\max}=2N^2.
\tag{30}
$$

辅助自由度只有 $O(m)$，加入总规模计数不会改变这些指数。准确结论是：在这一指定归一化下，可分初态失去了随规模增长的增强以及二次增长阶；这不排除其他比较下仍有常数倍优势。

## 7. 验证层级与研究状态

上面的解析证明负责“所有整数 $m\geq1$”的结论。原稿所述计算程序在有限实例上用精确算术核对 Clifford 恒等式，并分别构造小规模原始边自旋模型和较大的约化 Clifford 表示，核对基态投影、跃迁公式、固定辅助宇称、饱和态及独立时间演化。

这些有限检验有助于发现符号、归一化和表示映射错误，但不能代替一般证明。本版本暂未附程序和原始输出。本稿没有声称通过 Lean 或其他证明助手的形式化认证。

本文尚未经过外部同行评议。原始模型和既有结果均予以署名引用。作为 AI 辅助研究稿，投稿前仍需由实际承担作者责任的人类作者审阅和确定署名。

## 参考文献

1. Sheryl Mathew. *Battery Locality Is Necessary in Noncommuting Quantum Charging Bounds*. arXiv:2609.06104v1，2026-09-05。[官方记录](https://arxiv.org/abs/2609.06104)；[固定版本全文](https://arxiv.org/html/2609.06104v1)。本文模型、联合态基准、归一化及原开放问题的来源。
2. Sebastián V. Romero, Xi Chen, Yue Ban. *Cumulative locality governs collective quantum charging*. arXiv:2610.28614v1，2026-10-20。[全文](https://arxiv.org/html/2610.28614v1)。其局域电池与自由费米充电器问题不同于本稿。
3. Anupam, Sheryl Mathew, Sibasish Ghosh. *Super-Extensive Charging Power in the Absence of Global Operations*. [开放预印本 arXiv:2512.00788v1](https://arxiv.org/html/2512.00788v1)。此处仅引用已查阅的开放预印本。
4. Francesco Campaioli, Felix A. Pollock, Felix C. Binder, Lucas Céleri, John Goold, Sai Vinjanampathy, Kavan Modi. *Enhancing the Charging Power of Quantum Batteries*. Physical Review Letters **118**, 150601 (2017)。[DOI:10.1103/PhysRevLett.118.150601](https://doi.org/10.1103/PhysRevLett.118.150601)。作为相关背景，提醒不能把本模型结论泛化为一般的纠缠必要性。
5. Sergey Bravyi. *Lagrangian representation for fermionic linear optics*. Quantum Information and Computation **5**, 216–238 (2005)。[arXiv:quant-ph/0404180v2](https://arxiv.org/html/quant-ph/0404180v2)，第 IV 节式 (18)–(19) 及其后的正性条件。关联矩阵的经典背景；本文所用任意态 Gram 证明已完整给出。

