# 变角部分交换中的全环境解耦、残差乘积与浴谱相界

## 摘要

部分交换可使系统热化，也可能消除系统与所有已用热浴单元的相关性。本文建立适用于任意有限维、任意满秩浴态及任意碰撞角序列的有限步界和解耦充要条件。对最大混合浴，平方残差精确由四次正弦控制，固定角度下互信息有匹配指数。对任意固定满秩浴，后向加权残差演化化为一个有限维正映射的可交换多项式，得到与浴单元个数无关的双侧乘积界。任意非零浴谱分裂便把正弦四次方的收敛条件改变为平方条件。

## 1. 模型与主定理

系统 $A$ 与每个新浴单元 $b_k$ 维数同为 $d$。初始系统态为任意密度矩阵 $\rho_0$，浴单元均以同一满秩态 $\eta$ 独立制备。第 $k$ 步只碰撞 $A$ 与新的 $b_k$，酉矩阵为

$$
U_k=c_k I+i s_k W_k,\qquad c_k=\cos\theta_k,\quad s_k=\sin\theta_k,
$$

其中 $W_k$ 交换这两个等维子系统。记 $\rho_N$ 为第 $N$ 步后系统与已用浴 $B_N=b_1\cdots b_N$ 的联合态，$\rho_{B_N}$ 为其浴边缘态。未碰撞单元保持独立。本定义与 [1, 式 (13)–(17)] 相同，另外允许角度随步数变动。满秩包括任意有限温度下有限维 Gibbs 态。

定义参考态 $\omega_N=\eta^{\otimes(N+1)}$，以及初始距离常数

$$
b_0=\left\|\eta^{-1/2}\rho_0\eta^{-1/2}-I\right\|_{\eta,2},
\qquad
\|X\|_{\omega,2}^2=\operatorname{Tr}(\omega X^\ast X).
$$

**定理 1。** 对每一个 $N$，

$$
\|\rho_N-\eta\otimes\rho_{B_N}\|_1
   \le b_0 \prod_{k=1}^N (1-s_k^4)^{1/2}.
$$

固定角度下，只要 $\sin\theta\ne0$，右端随 $N$ 指数趋零。系统至整个已用热浴的互信息也趋零，证明 [1, 式 (22)–(23)] 的弱碰撞结论。界还适用于满足 $\sum_k s_k^4=\infty$ 的不同角度，或某次发生完全交换的序列。角度全为零模 $\pi$ 时一般没有热化。

## 2. 加权正交投影与单步信息流

令 $L_N=\omega_N^{-1/2}\rho_N\omega_N^{-1/2}$。每次碰撞酉矩阵与对应的 $\eta\otimes\eta$ 交换，故

$$
L_{N+1}=U_{N+1}(L_N\otimes I)U_{N+1}^\ast.
$$

这个操作在相应的加权内积 $\langle X,Y\rangle_\omega=\operatorname{Tr}(\omega X^\ast Y)$ 中等距。定义作用在系统因子的条件期望

$$
\mathcal P_N X=I_A\otimes\operatorname{Tr}_A[(\eta\otimes I_{B_N})X].
$$

内积下，$\mathcal P_N$ 是到 $I_A\otimes\mathcal B(B_N)$ 的正交投影。它固定该子空间，而且对任意浴算子 $Y$，$\langle I_A\otimes Y,X-\mathcal P_NX\rangle_{\omega_N}=0$。记 $R_N=L_N-\mathcal P_NL_N$，$b_N=\|R_N\|_{\omega_N,2}$。显然只作用在 $B_N$ 的分量在下一步仍是浴算子，所以只需跟踪 $R_N$。这里浴对象是整个 $B_N$，它可包含此前碰撞产生的任意相关性。

考察一个满足 $\operatorname{Tr}(\eta X)=0$ 的系统算子 $X$。碰撞后投影到新浴因子的算子为

$$
T_k(X)=s_k^2 X+i c_k s_k(X\eta-\eta X).
$$

这是将 $U_k(X\otimes I)U_k^\ast$ 对旧系统取 $\eta$ 加权部分迹所得。具体地，$W(X\otimes I)W=I\otimes X$，$\operatorname{Tr}_A[(\eta\otimes I)W]=\eta$，两个交叉项给出 $X\eta-\eta X$。在 $\eta$ 的本征基中，加权正交的非对角矩阵元 $E_{ij}$ 各乘以 $s_k^2+i c_ks_k(\eta_j-\eta_i)$。对角零均值子空间各乘以 $s_k^2$。因此

$$
\|T_k(X)\|_{\eta,2}^2\ge s_k^4\|X\|_{\eta,2}^2.
$$

在旧浴的加权正交算子基展开 $R_N$，展开系数均为系统零均值算子。新浴投影把每个系数变成对应的 $T_k$，不同旧浴基向量的项仍然正交。所以至少 $s_k^4 b_N^2$ 的平方范数进入只依赖浴的正交子空间。由等距性和勾股恒等式，

$$
b_{N+1}^2\le(1-s_{N+1}^4)b_N^2 .
$$

把 $\mathcal P_N L_N$ 放回密度矩阵表示后恰为 $\eta\otimes\rho_{B_N}$，因为系统因子的部分迹允许将两个 $\eta^{1/2}$ 循环移到同一侧。于是

$$
\begin{aligned}
\|\rho_N-\eta\otimes\rho_{B_N}\|_1
&=\|\omega_N^{1/2}R_N\omega_N^{1/2}\|_1\\
&\le\|\omega_N^{1/2}\|_2\|R_N\omega_N^{1/2}\|_2=b_N .
\end{aligned}
$$

这给出主定理。设实际迹距离的一半为 $\epsilon_N$。Winter 条件熵连续性引理 [3] 只依赖系统维数 $d$，应用于 $S(A)$ 和 $S(A|B_N)$，得

$$
I(A:B_N)\le4\epsilon_N\log d+
2(1+\epsilon_N)
h_2\!\left(\frac{\epsilon_N}{1+\epsilon_N}\right),
$$

其中 $h_2(z)=-z\log z-(1-z)\log(1-z)$。由于 $B_N$ 的维数没有进入，该式严格给出整个已用浴的互信息趋零。所有对数取自然底。

## 3. 最大混合浴的精确率

**定理 2。** 若 $\eta=I/d$，上述平方收缩精确为

$$
b_N^2=b_0^2\prod_{k=1}^{N}(1-s_k^4).
$$

若 $\rho_0\ne\eta$，此时系统相对其平衡态与整个浴解耦，当且仅当这个乘积趋于零。

事实上，最大混合时 $T_k=s_k^2 I$ 在零均值算子空间上成立，投影步骤全部取等。为得到迹范数的逆向判定，记 $D_N=d^{N+1}$、$a_+=d\lambda_{\max}(\rho_0)$。由酉不变性和部分迹，$\rho_N$、$\eta\otimes\rho_{B_N}$ 均在算子序上不超过 $(a_+/D_N)I$，它们之差 $\Delta_N$ 的算子范数也至多 $a_+/D_N$。另一方面 $b_N^2=D_N\|\Delta_N\|_2^2$。因此 $b_N^2\le a_+\|\Delta_N\|_1$，给出所需逆向。乘积消失等价于至少一项为零，或者 $\sum_k s_k^4$ 发散。

同一模型下 $\rho_{A,N}-\eta=(\prod_k c_k^2)(\rho_0-\eta)$。若 $s_k=(k+1)^{-\alpha}$，其中 $1/4<\alpha\le1/2$，则系统局部趋于 $\eta$，而全环境迹距离下界保持严格正值。因为局部已经热化，用三角不等式和量子 Pinsker 不等式可知，系统与整个浴的互信息也保持正的下极限。这一区别发生在逐步变弱的碰撞序列。

**推论。** 若最大混合浴、初始 $\rho_0$ 满秩且 $\rho_0\ne\eta$，以及固定角度满足 $0<s^2<1$，则

$$
\lim_{N\to\infty}\frac1N\log I(A:B_N)=\log(1-s^4).
$$

令 $a_-=d\lambda_{\min}(\rho_0)>0$。$\rho_N$ 与 $\eta\otimes\rho_{B_N}$ 的本征值均在 $[a_-/D_N,a_+/D_N]$。沿两态连线，对函数 $\operatorname{Tr}X\log X$ 的二阶微分积分。其 Hessian 对任一 Hermitian 方向 $V$，在 $X$ 的本征基中为 $\sum_{ij}|V_{ij}|^2(\log\lambda_i-\log\lambda_j)/(\lambda_i-\lambda_j)$，重根时取 $1/\lambda_i$。标量中值定理将其夹在 $D_N\|V\|_2^2/a_+$ 和 $D_N\|V\|_2^2/a_-$ 之间，积分系数为 $1/2$。得到

$$
\frac{b_N^2}{2a_+}\le
D(\rho_N\|\eta\otimes\rho_{B_N})
\le\frac{b_N^2}{2a_-}.
$$

又因为这一相对熵等于 $I(A:B_N)+D(\rho_{A,N}\|\eta)$，而同样的有限维二阶估计给出后项为 $O(c^{4N})$，故只需比较 $c^4=(1-s^2)^2<1-s^4$。去掉更快衰减的项后，互信息与 $(1-s^4)^N$ 在固定正的乘法常数内，得所述尖锐指数。

## 4. 满秩浴的双向范数判据和有限传递矩阵

令 $\Delta_N=\rho_N-\eta\otimes\rho_{B_N}$，$\delta_N=\|\Delta_N\|_1$，以及
$K=2\|\eta^{-1/2}(L_0-I)\eta^{1/2}\|_\infty$。第 2 节的正向界和以下逆向界对每个 $N$ 都成立。

$$
 b_N^2\le K\delta_N,\qquad \delta_N\le b_N .
$$

证明逆向不等式时，记 $A_N(X)=\omega_N^{-1/2}X\omega_N^{1/2}$。在系统 $\eta$ 的本征基中逐一取系统对角块可见，$A_N$ 与 $\mathcal P_N$ 交换。$\mathcal P_N$ 是保持单位算子的完全正映射，其算子范数不超过一。因此
$\|A_NR_N\|_\infty\le2\|A_N(L_N-I)\|_\infty=K$，其中等号利用总酉与 $\omega_N$ 对易。将 $b_N^2$ 改写为 $\operatorname{Tr}(\Delta_N A_NR_N)$，由迹对偶得到结果。于是 $\delta_N\to0$ 当且仅当 $b_N\to0$。

也可在固定维数中精确计算加权残差。定义系统空间
$V=\{X\in M_d(\mathbb C):\operatorname{Tr}(\eta X)=0\}$，
$QX=X-I\operatorname{Tr}(\eta X)$。所有算子空间取各自的平衡态加权内积。对新浴选一个加权正交归一基，令 $K_j(\theta)X$ 为
$(Q\otimes1)U_\theta(X\otimes I)U_\theta^*$ 在该基的第 $j$ 个系数。沿用旧浴的张量正交基展开，每个旧系数在下一次产生这一组系数。于是若把旧系数的外积相加为 $S_N$，则

$$
S_0=|L_0-I\rangle\langle L_0-I|,\qquad
S_{N+1}=\sum_j K_j(\theta_{N+1})S_N K_j(\theta_{N+1})^*,\qquad
b_N^2=\operatorname{Tr}_V S_N.
$$

矩阵阶数始终为 $d^2-1$，与已用浴的总维数无关。

## 5. 变角部分交换的精确乘积与相界

设 $d\ge2$，浴仍取同一满秩态。记 $x_j=s_j^2$、$X_0=L_0-I$。在 $V$ 上定义 $JX=X\otimes I$、$ZX=i(Q\otimes1)[W,X\otimes I]$，并在 $\operatorname{End}(V)$ 上定义正映射
$\mathsf M(H)=Z^*(H\otimes I)Z$。这里 $H\otimes I$ 中的恒等算子作用于浴的算子空间。令 $r$ 为 $\mathsf M$ 的谱半径，$g_r(x)=(1-x)(1-x+rx)$。

**定理 3。** 加权残差的精确公式为

$$
b_N^2=\left\langle X_0,
  \left\{\prod_{j=1}^N(1-x_j)\big[(1-x_j)\operatorname{Id}+x_j\mathsf M\big]\right\}(I_V)X_0
\right\rangle_\eta .
$$

它与角度的排列无关。存在只依赖浴态的有限常数 $C_\eta\ge1$，使
$C_\eta^{-1}b_0^2\prod_j g_r(x_j)\le b_N^2\le C_\eta b_0^2\prod_j g_r(x_j)$。
固定 $0<x<1$ 且 $\rho_0\ne\eta$ 时，$N^{-1}\log b_N^2\to\log g_r(x)$。这些指数针对加权残差的平方。

只要有一次完全交换，此后全环境解耦误差为零。若无完全交换并且 $\rho_0\ne\eta$，则

$$
\delta_N\to0\quad\Longleftrightarrow\quad
\begin{cases}
\sum_j x_j=\infty,&\eta\ne I/d,\\
\sum_j x_j^2=\infty,&\eta=I/d .
\end{cases}
$$

当 $\rho_0=\eta$ 时每步都保持同一个平衡乘积态；$d=1$ 时同样平凡。

### 5.1. 可交换的后向演化

单次碰撞保留在系统零均值因子的部分为 $A_\theta X=c^2 JX+cs ZX$，因为交换的二次项 $s^2(I\otimes X)$ 仅作用于浴。旧浴分量保持为浴算子，故这个单步线性算子以张量方式作用在每个旧系数上。记 $LX=[\eta,X]$；$L$ 在加权内积下自伴，且 $J^*Z=iL$。后一恒等式由对新浴取 $\eta$ 加权部分迹得到，$Q$ 保留中心化的交换子。

$J$ 和 $Z$ 将 $e^{it\eta}Xe^{-it\eta}$ 同时交织到系统和浴的相同共轭。于是 $\mathsf M$ 保持与 $L$ 对易的算子集合。对其中的 $H$，在 $A_\theta^*(H\otimes I)A_\theta$ 中，混合项为 $ic^3s[H,L]$，等于零。后向更新因而是
$H\mapsto c^4H+c^2s^2\mathsf M(H)$。从恒等算子开始，所有后向更新都作用在这个对易集合内，并且是同一个映射的多项式，故彼此可交换。由第 4 节传递矩阵的迹对偶表示，在初始 $X_0$ 上取内积即得精确公式。

### 5.2. 正定本征算子与统一常数

$W=\sum_{a,b}E_{ab}\otimes E_{ba}$。因浴给定满秩，更换到加权正交归一基是可逆的线性变换。因而 $\mathsf M$ 的 Kraus 算子的线性包络正是 $X\mapsto Q[E_{ab},X]$ 的包络，忽略公共因子 $i$。将 $V$ 识别为 $M_d(\mathbb C)/\mathbb C I$，再取无迹代表，得到所有矩阵单位在复单李代数 $\mathfrak{sl}_d$ 上的伴随作用。公共不变子空间必是李理想，因此只有零空间和全空间；Kraus 伴随族由正交补法也有同样性质。

对 $\mathsf M$ 或其迹对偶，把正半定迹一矩阵先作映射再按迹归一化。分母处处为正，否则映射的 Kraus 家族会有非零公共核；一条这样的公共核直线会是非平凡公共不变子空间。Brouwer 定理给出正半定本征算子，且其核由 Kraus 族或其伴随族保持，因此本征算子正定。正定本征算子定义的序单位范数给出同一个正本征值作为谱半径。具体地，将任一 Hermitian 矩阵夹在该本征算子的正负倍数之间，迭代正映射后此比较的范数最多乘该本征值的相应幂；复线性算子再由实虚分解得到同一谱半径上界。$\mathsf M$ 与迹对偶的谱半径相同。

把 $\mathsf M$ 的正定本征算子 $H_*$ 按共轭群的紧闭包平均，保留正定性和本征值，并使它与 $L$ 对易。此时每一步将它乘以 $g_r(x)$。在
$H_*/\lambda_{\max}(H_*)\le I_V\le H_*/\lambda_{\min}(H_*)$
两侧应用全部正更新，取 $X_0$ 上的二次型。由本征值的再一次比较，可取 $C_\eta=\lambda_{\max}(H_*)/\lambda_{\min}(H_*)$。

### 5.3. 浴谱缺损与全环境收敛

第 2 节的浴侧分量为 $xX-icsLX$，平方范数是
$x^2\|X\|_\eta^2+c^2s^2\|LX\|_\eta^2$，因为 $L$ 自伴，混合项为零。加到系统保留分量的平方等于总等距范数，代入 $H=I_V$ 的后向公式后得到
$\mathsf M(I_V)=2I_V-L^2$。
对正定的迹对偶本征算子 $S_*$ 取迹，得

$$
2-r=\frac{\operatorname{Tr}_V(S_*L^2)}{\operatorname{Tr}_V S_*}.
$$

因此 $r=2$ 当且仅当 $L=0$，也就是 $\eta=I/d$。满秩密度矩阵任意两个本征值之差的绝对值严格小于一，故 $r>1$。最后
$1-g_r(x)=(2-r)x+(r-1)x^2$。完全交换时 $g_r(1)=0$；否则无穷乘积趋零当且仅当非负缺损的级数发散。标量浴缺损是 $x^2$；非标量浴的缺损在 $0\le x\le1$ 与 $x$ 以固定正常数可比。第 4 节把该判据送回迹距离。

在 $s_j=(j+1)^{-\alpha}$、$1/4<\alpha\le1/2$ 时，任何非标量满秩浴都使整个已用浴解耦，最大混合浴的全环境迹距离则由第 4 节的下界保持严格为正。第 3 节已给出最大混合点上局部热化与全环境解耦的区别；从该点任意小地分裂浴谱即改变临界幂。

## 6. 与既有结果的关系

[1, §IV.A] 对强碰撞给出解析范数估计，对未修改的弱碰撞使用两能级数值证据。[1, §IV.B] 和学位论文附录 B.2 [4] 对添加周期性完全退相干的模型给出解析结果。这里从原始酉碰撞直接导出统一有限步估计。[2] 的量子均匀化控制系统与每个浴单元的局部状态。

非交换散射的抽象渐近完备性也提供固定角度定性极限的途径 [5, 定理 6.1]。对任意目标态 $\tau$，制备独立浴单元均为 $\tau$。两系统输入之差 $X$ 在碰撞和取系统边缘后按 $c^2 X+i cs(\tau X-X\tau)$ 演化，符号的反转对应反向共轭。在 $\tau$ 的本征基中，该线性映射的各因子模长不超过 $|c|<1$，因为任意两个本征值之差的绝对值至多为 $1$。因此所有有限维目标可以普遍制备。结合有限维紧性、不变满秩乘积态，以及 [5, 定理 6.1] 的浴侧加权范数极限，即可由勾股恒等式得到固定角度的定性结论。本文的新增贡献是部分交换的显式有限步收缩、最大混合浴的互信息尖锐指数，以及对固定满秩浴在任意角序列下的锐敛散条件和有序碰撞的标量乘积律。

Ziman 等 [2] 的均匀化目标以单系统边缘与各浴单元边缘为主。新近关于相干与非相干碰撞的比较 [6] 也研究边缘趋同及其瞬态差异。第 4–5 节的误差比较以所有已用浴的联合态为对象，并适用于逐步变弱或无稳定角度的序列。所给加权误差指数与第 3 节已证互信息指数各有自己的适用域。Lean 形式化另行交付。

## 参考文献

1. S. Cusumano、V. Cavina、M. Keck、A. De Pasquale 与 V. Giovannetti，*Entropy production and asymptotic factorization via thermalization: A collisional model approach*，Phys. Rev. A **98**，032119 (2018)。[arXiv:1807.04500v2](https://arxiv.org/abs/1807.04500v2)。
2. M. Ziman 等，*Diluting quantum information: An analysis of information transfer in system-reservoir interactions*，Phys. Rev. A **65**，042105 (2002)。[arXiv](https://arxiv.org/abs/quant-ph/0110164)。
3. A. Winter，*Tight uniform continuity bounds for quantum entropies: conditional entropy, relative entropy distance and energy constraints*，Commun. Math. Phys. **347**，291–313 (2016)。[arXiv](https://arxiv.org/abs/1507.07775)。
4. S. Cusumano，*Quantum Engineering in Open Quantum Systems*，博士学位论文，第 4 章及附录 B.2。[全文](https://ricerca.sns.it/retrieve/e3aacdfd-fb50-4c98-e053-3705fe0acb7e/tesi_Cusumano_def.pdf)。
5. R. Gohm、F. Haag 与 B. Kümmerer，*Universal Preparability of States and Asymptotic Completeness*，Commun. Math. Phys. **352**，601–642 (2017)。[arXiv](https://arxiv.org/abs/1605.00315)。
6. G. Karpat、B. Çakmak，*Transient Dynamics and Homogenization in Incoherent Collision Models*，Entropy **27**，206 (2025)，§§1–2。[出版文](https://www.mdpi.com/1099-4300/27/2/206)。
