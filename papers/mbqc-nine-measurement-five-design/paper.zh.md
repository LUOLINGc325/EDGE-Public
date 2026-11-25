# 九次固定测量构造单量子比特精确酉五设计

## 摘要

在一个十顶点线性簇上，九次预设的平面测量诱导了单量子比特精确酉五设计。角度由一个八次有理多项式的指定根确定。所有 $512$ 种记录均匀保留，协议无需经典抽样、馈送、后选择或输出修正。这给出 Turner 与 Markham [1] 图 6 所讨论的 $L=9,\ t=4,5$ 两个情形的解析解。证明把非平凡自旋分量归约为三个有理多项式的精确同余。

## 1. 角度与结论

这里 $L$ 是测量点数，另有一个未测的输出点，与 [1] 式 (5) 的记号相同。设 $u_j=\cos(2\phi_j)$，按输入至输出顺序取
$
 (\phi_1,\ldots,\phi_9)=
 \left(0,\frac{\pi}{4},\frac{\arccos a}{2},\frac{\arccos b}{2},
 \frac{\arccos c}{2},\frac{\pi}{4},0,\frac{\pi}{8},0\right).
\tag{1}
$
令 $a$ 是 $ (-7/20,-17/50) $ 内的根
$
 P(a)=81a^8-8a^6-2a^4-8a^2+1=0 .
\tag{2}
$
直接代入给区间左端负、右端正。因 $a<0$，在该区间有
$P'(a)\ge16(17/50)-648(7/20)^7>0$，故根唯一。其余两个数定义为
$
\begin{split}
88288\,b={}&-593163a^7-318411a^6-100743a^5+100217a^4\\
&+45691a^3+70811a^2+80743a+24487,\\
240\,c={}&3159a^7-567a^6+255a^5+137a^4-215a^3+87a^2-399a-41 .
\end{split}
\tag{3}
$
将 $|a|<7/20$ 代入各系数绝对值之和得到 $|b|<0.76,\ |c|<0.87$，所以角度为实。供对照，$ (a,b,c)$ 约为 $(-0.3488772591,0.0543737090,0.4817621979)$。

**定理。** 用式 (1) 的角度在十点线性簇上固定测量前九点，余下点上的分支酉在全部均匀测量记录下组成精确酉五设计。于是四阶和五阶帧势分别达到 Haar 值 $14$ 和 $42$。

## 2. 九站矩的压缩

首点装载任意单比特输入，其余点为 $|+\rangle$，边表示 CZ。固定测量基为 $(|0\rangle+(-1)^s e^{-i\phi}|1\rangle)/\sqrt2$，每站的分支算子是 $2^{-1/2}X^s H R_z(\phi)$ 乘全局相位。每站测量位独立均匀。由于共轭忽略整体相位，单比特 $t$ 拷贝矩可在整数自旋 $\ell\le t$ 的表示中检验。每份单比特算子空间为自旋零与自旋一之和，故五份只包含 $\ell=0,\ldots,5$。Haar 矩在每个自旋零副本恒等，其他副本为零。

以下把门记为相应自旋的表示。令 $P_Z=(I+Z)/2$、$P_X=(I+X)/2$、$\Pi=P_XP_Z$。共轭表示中的 $X,Z$ 对易且各自平方为恒等，$\Pi$ 是 Pauli 平均投影。单站矩为
$
 P_X H R_z(\phi)=H P_Z R_z(\phi).
$
在相邻两个站之间使用 $P_Z H P_Z=H\Pi$。更具体地，$R_z$ 与 $P_Z$ 对易，且 $\Pi H=H\Pi$。把九站的乘积逐对插入 $P_Z^2=P_Z$，即可剥去左右酉因子，留下 $\Pi$ 像上的积
$
 D(u_8)H D(u_7)H\cdots H D(u_2),
 \qquad D(u)=\Pi R_z(\phi)\Pi\big|_{\operatorname{ran}\Pi},\qquad
 u=\cos(2\phi).
\tag{4}
$
例如三站的未压缩积恰为 $H R_z(\phi_3)H\,\Pi R_z(\phi_2)\Pi H R_z(\phi_1)$，上述步骤逐站延伸。

在自旋 $\ell$ 的磁权基，$Z$ 在权 $m$ 的符号为 $(-1)^m$，$X$ 把 $m$ 和 $-m$ 互换，允许相位。故每个正偶权 $m\le\ell$ 在 $\Pi$ 像中贡献一维，其权重对振幅平方各 $1/2$，$D(u)$ 的乘数为 $\cos(m\phi)$。轴向 $m=0$ 仅在偶 $\ell$ 出现，因为 $X$ 反转极轴，对次数 $\ell$ 的轴向球谐给出 $(-1)^\ell$。

于是 $\ell=1$ 无剩余方向，$\ell=3$ 仅有 $m=2$，被 $D(u_2)=D(0)$ 消去。对 $\ell=5$，仅有 $m=2,4$。式 (4) 的最左三处对角块为 $D(1/\sqrt2)H D(1)H D(0)$。由于 $D(1)=I$ 和 $H^2=I$，这等于 $D(1/\sqrt2)D(0)$，依次消去 $m=4$ 与 $m=2$。

## 3. 偶自旋的三项确切消去

对 $\ell=2,4$，分别有 $D_2(u)=\operatorname{diag}(1,u)$、
$D_4(u)=\operatorname{diag}(1,u,2u^2-1)$。可在齐次 $x,y,z$ 多项式按 $x^2+y^2+z^2$ 取商的模型中计算 $H$。此商与同次调和齐次多项式同构。$H$ 交换 $x,z$ 并反转 $y$。二阶 Pauli 不变基为 $x^2+y^2,x^2-y^2$，四阶为 $(x^2+y^2)^2,x^4-y^4,x^4-6x^2y^2+y^4$。三类多项式的磁权分别为 $0,2,4$。代入 $z^2=-x^2-y^2$ 给
$
 H_2=\frac12\begin{pmatrix}-1&-3\\-1&1\end{pmatrix},\qquad
 H_4=\frac18\begin{pmatrix}3&5&35\\4&4&-28\\1&-1&1\end{pmatrix}.
\tag{5}
$

式 (4) 的最左三块在偶自旋投影到零磁权。最右 $D(0)$ 只保留二阶的零权，或四阶的零权与权四。以零为行列初始下标，记
$V_\ell=H_\ell D_\ell(c)H_\ell D_\ell(b)H_\ell D_\ell(a)H_\ell$。
所需的三项正好是 $(V_2)_{00},(V_4)_{00},(V_4)_{02}$。将式 (3) 代入式 (5) 的矩阵乘法，逐次按恒等式
$
 a^8\equiv(8a^6+2a^4+8a^2-1)/81\pmod{P(a)}
$
降低幂次。这三个元素的 $a^0,\ldots,a^7$ 余式系数依次全为零。随附标准库程序逐系数核验，并同时核验实根与参数区间。故偶自旋均归零。自旋零下每站恒等，结合奇自旋，五阶矩恰为 Haar 投影。式 (1) 也实现四阶。本文只给出 $L=9$ 的解析构造，未判定更短路径能否达到同阶。

## 参考文献

1. Peter S. Turner and Damian Markham, *Derandomizing Quantum Circuits with Measurement-Based Unitary Designs*, Physical Review Letters 116, 200501 (2016), Eq. (5), Fig. 6 and discussion. DOI 10.1103/PhysRevLett.116.200501.
2. Conrad Strydom and Mark Tame, *Implementation of single-qubit measurement-based t-designs using IBM processors*, Scientific Reports 12, 5014 (2022). DOI 10.1038/s41598-022-08632-z.
3. Conrad Strydom and Mark Tame, *Investigating the effect of noise channels on the quality of unitary t-designs*, Physical Review A 108, 052414 (2023), §IV.1 uses the icosahedral group. DOI 10.1103/PhysRevA.108.052414.
