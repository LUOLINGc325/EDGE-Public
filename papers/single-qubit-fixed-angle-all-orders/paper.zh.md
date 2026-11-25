# 任意阶的单量子比特固定角测量型精确酉设计

## 摘要

对每个整数 $t\ge1$，给出线性簇上的固定测量基，使均匀测量记录诱导单量子比特精确酉 $t$-设计。测量数为
$
2(\lfloor t/2\rfloor+1)(\lfloor\log_2t\rfloor+1)+2\lfloor t/2\rfloor .
$
所有记录都保留，测量角与输出操作均不随记录改变。构造回答 Strydom 和 Tame [2] 在引言中提出的 $t>3$ 存在性问题。局部测量先形成保持偶整数角动量轴向分量的精确投影，随后用勒让德多项式的零点分别消掉各个非平凡分量。

## 1. 测量字与整数自旋

输入在路径首点，其余点制备 $|+\rangle$，相邻点施加预先设置的 CZ。在角 $\phi$ 处采用 $(|0\rangle+(-1)^s e^{-i\phi}|1\rangle)/\sqrt2$ 测量，传送给下一点的 Kraus 算子以整体相位为等价是 $2^{-1/2}J_s(\phi)$，其中 $J_s(\phi)=X^s H R_z(\phi)$ 及 $R_z(\phi)=e^{-i\phi Z/2}$ [1,2]。每种条件下 $s$ 都是新的均匀位。所有未测点的边可以预先施加，测量基从始至终固定。

对矩阶 $t$，用 $\rho_t(U)$ 表示 $U^{\otimes t}$ 的共轭作用。底层是单比特 Pauli 共轭的 $t$ 次张量幂，单份把算子空间分为恒等的自旋 0，以及 Pauli 空间的自旋 1。因此只有整数自旋 $\ell=0,\ldots,t$ 可能出现。各群元素都对每个出现的等价副本作同样的操作，Haar 矩在所有自旋零副本为恒等，在其余自旋为零。以下可在任一自旋 $\ell$ 的标准权重基 $e_m$（$-\ell\le m\le\ell$）研究。

## 2. 由二进相位产生轴向投影

令 $\Pi$ 为四个单量子比特 Pauli 的矩平均。两个相邻的固定角 $(\phi,0)$ 给出
$
J_b(0)J_a(\phi)=X^bZ^aR_z(\phi),
$
故它的平均矩是 $\Pi\rho_t(R_z(\phi))$。特别是 $(0,0)$ 实现 $\Pi$。

在自旋 $\ell$ 中，$\rho_t(Z)e_m=(-1)^m e_m$，而代表绕 $x$ 轴旋转 $\pi$ 的 $\rho_t(X)$ 把 $e_m$ 送往 $e_{-m}$ 的倍数。因而 $\Pi$ 已消去奇 $m$。在每个偶 $m>0$ 对应的二维空间 $\operatorname{span}(e_m,e_{-m})$ 中，$\Pi$ 投影到由 $X$ 固定的一维线。该线的单位向量在 $e_m,e_{-m}$ 的振幅平方各为 $1/2$。据 $R_z(\phi)$ 的相位 $e^{-im\phi}$，夹层 $\Pi\rho_t(R_z(\phi))\Pi$ 在该线上乘以 $\cos(m\phi)$。$m=0$ 时 $X$ 特征值为 $(-1)^\ell$，因为绕 $x$ 轴旋转 $\pi$ 反转极轴，自旋 $\ell$ 的轴向球谐有该奇偶性。

取 $k=\lfloor\log_2 t\rfloor$。令 $A_t$ 是先执行 $(0,0)$，再对 $j=1,\ldots,k$ 依次执行 $(\pi/2^{j+1},0)$ 的测量字。任一偶正权重 $m\le t$ 可写为 $m=2^ju$，其中 $1\le j\le k$ 且 $u$ 为奇数。这个测量字中的对应余弦因子 $\cos(u\pi/2)$ 等于零。因此其矩，记作 $Q_t$，在每个偶 $\ell$ 的副本精确投影到 $e_0$，在奇 $\ell$ 为零。它与 $\Pi$ 相乘仍为 $Q_t$，从而对每个单比特 Pauli $P$ 均有 $Q_t\rho_t(P)=Q_t$。

## 3. 逐阶消去轴向分量

两个固定角 $(0,\alpha)$ 的分支为
$
J_b(\alpha)J_a(0)=X^bZ^aR_x((-1)^a\alpha),\qquad
R_x(\alpha)= H R_z(\alpha)H.
$
在其后施加一个独立的 $A_t$，因 $Q_t\rho_t(X^bZ^a)=Q_t$，可在矩计算中吸收分支 Pauli。若前方也施加 $A_t$，每个偶 $\ell$ 的轴向线乘以
$
\big\langle e_0,\rho_\ell(R_x(\alpha))e_0\big\rangle=P_\ell(\cos\alpha).
\tag{1}
$
这是整数自旋的轴向矩阵元。可取单位球上的次数 $\ell$ 球谐模型。沿单位向量 $a$ 的标准化轴向球谐与 $P_\ell(a\cdot x)$ 成正比；球谐加法定理使两根轴的归一内积等于 $P_\ell(a\cdot b)$。极轴经绕 $x$ 轴转 $\alpha$ 后内积为 $\cos\alpha$，也证明两种分支角符号的值相同。相同的轴向夹层在一般紧群构造中的角色见 [3]。此处的投影和转角均由固定测量字实现。

令 $r=\lfloor t/2\rfloor$。对 $j=1,\ldots,r$，取 $x_j$ 为 $P_{2j}$ 的最大正零点，并令 $\alpha_j=\arccos(x_j)$。零点存在，因为 Rodrigues 公式的 $P_{2j}$ 对更低次多项式正交，在 $(-1,1)$ 有 $2j$ 个简单内根，且函数偶对称。正交性由把 Rodrigues 公式分部积分 $2j$ 次得到。如内部变号少于 $2j$ 次，利用这些变号根组成低次多项式相乘会产生固定符号且非零的积分，矛盾。

完整字先放 $A_t$，再对 $j=1,\ldots,r$ 依序追加 $(0,\alpha_j)$ 与 $A_t$。其矩在自旋 0 为恒等，在奇 $\ell$ 为零，在每个偶 $\ell>0$ 的轴向线上至少有一个式 (1) 的因子为零。因此它等于 Haar 矩。总测量点数是 $2(r+1)(k+1)+2r$，另有一未测输出点。路径、角度与记录概率都精确指定。该构造的测量数以 $O(t\log t)$ 增长；它适用于任意单比特矩阶。

例如 $t=4$ 时，轴向块的六个角是
$
(0,0,\pi/4,0,\pi/8,0).
$
两个转角的余弦分别为 $1/\sqrt3$ 和 $\sqrt{(15+2\sqrt{30})/35}$。三块轴向字与两个两步转角字共需 22 次测量。本文没有确定最短路径长度。该方案使用由 $t$ 决定的精确角，量词是每个阶数存在一个相应的路径。

## 参考文献

1. Peter S. Turner and Damian Markham, *Derandomizing Quantum Circuits with Measurement-Based Unitary Designs*, Phys. Rev. Lett. 116, 200501 (2016). DOI 10.1103/PhysRevLett.116.200501.
2. Conrad Strydom and Mark Tame, *Implementation of single-qubit measurement-based t-designs using IBM processors*, Scientific Reports 12, 5014 (2022), Introduction and Eq. (1)–(4). DOI 10.1038/s41598-022-08632-z.
3. Eiichi Bannai, Yoshifumi Nakata, Takayuki Okuda, and Da Zhao, *Explicit construction of exact unitary designs*, Advances in Mathematics 405, 108457 (2022), Gelfand-pair lifting and zonal spherical functions. DOI 10.1016/j.aim.2022.108457.
