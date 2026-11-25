# 任意量子比特数的固定角测量型精确酉二设计

## 摘要

对任意 $n\ge1$，构造一个有限开放图和预先固定的单站测量基，使均匀测量记录诱导的 $n$ 量子比特酉门集合是精确二设计。协议只使用平面测量，随机性全部来自测量结果，每个分支都保留，输出无需 Pauli 校正。它回答了 Turner 与 Markham [1] 及 Alexander、Turner 与 Bartlett [2] 提出、Strydom 与 Tame [4] 再次列出的多量子比特精确测量型设计的二阶存在性问题。归纳层只需三组局部设计和两组有限 Pauli 旋转。所有新测量角由根式和反三角函数确定。

## 1. 测量模型

开放图的 $n$ 个输入顶点装载任意未知量子态，其余顶点制备 $|+\rangle$，每条边表示一次预先实施的 $\mathrm{CZ}$。除输出外，每个顶点在固定的平面基测量。记 $R_z(\phi)=e^{-i\phi Z/2}$。取旧顶点的测量基为 $(|0\rangle+(-1)^s e^{-i\phi}|1\rangle)/\sqrt2$，在新顶点得到的分支算子相差一个全局相位后为
$
2^{-1/2} J_s(\phi),\qquad J_s(\phi)=X^s H R_z(\phi).
\tag{1}
$
因此每次测量的两支等概率，包含输入与其他线纠缠的情形。串接时，在当前线的末点和新点之间加边，测量旧点并移动末点。当前两点间增加一条图边可实现一次逻辑 $\mathrm{CZ}$。各边可提前施加，因尚未执行的边涉及的顶点均未测量，且所有 $\mathrm{CZ}$ 彼此对易。任意两个站的投影均作用于不同量子比特。由此得到一次预设的图和基，以及 $2^{-M}$ 的全记录概率，其中 $M$ 是测量点数。

两次连续的 $J_s(0)$ 实现均匀 Pauli $X^{s_2}Z^{s_1}$。按顺序测 $\phi,0$ 则实现 $R_z(\phi)$ 连同一个输出 Pauli。固定的 Clifford 门可由 $H$、$R_z(\pm\pi/2)$ 与 $\mathrm{CZ}$ 在同一模型实现，传播时输出副产物仍是多体 Pauli。$n=1$ 使用 [1,2] 中已有的五次测量，角为 $0,\pi/4,\arccos(1/\sqrt3),\pi/4,0$。

**随机符号旋转。** 给定非恒等 Pauli $P=CZ_jC^\dagger$，其中 $C$ 是 Clifford，依次实施 $C^\dagger$、在第 $j$ 线两次零角测量、$R_z(-2\theta)$、$C$。零角副产物在这两次测量后含有一个新鲜均匀的 $X$ 位。把全部 Pauli 副产物向输出传播，目标旋转成为 $e^{i\epsilon\theta P}$，其中 $\epsilon$ 在给定之前记录后均匀取 $\pm1$。传播恒等式为 $e^{i\theta P}Q=Qe^{i\epsilon\theta P}$，$\epsilon=1$ 对应 $P,Q$ 对易。每个旋转前重复此操作，其符号联合独立；剩余的输出 Pauli 可以与符号相关。

写 $w=\sin^2(2\theta)$。在两拷贝的 Pauli 对角算子 $Q\otimes Q$ 上，正负平均的作用为
$
Q\otimes Q\ \longmapsto\
\begin{cases}
Q\otimes Q,&[P,Q]=0,\\
(1-w)Q\otimes Q+w(iPQ)\otimes(iPQ),&\{P,Q\}=0.
\end{cases}
\tag{2}
$
忽略 Pauli 的整体符号，令 $\tau_P(Q)=Q$ 当二者对易，否则令 $\tau_P(Q)=PQ$。式 (2) 即保留概率 $1-w$ 的置换 $\tau_P$。中间旋转块结束后施行一次独立于整块记录的局部二设计。对每个已固定的块记录，其二阶平均吸收该记录对应的输出 Pauli。证明只用吸收后得到的二阶矩，实际测量不进行校正。

## 2. 二阶矩的两个方向

考虑把 $n$ 线分成 $A,B$，其中 $\dim A=p=2^{n-1}$、$\dim B=2$，总维度 $d=2p$。二拷贝算子空间使用 Hilbert–Schmidt 内积。设 $S_A,S_B$ 分别是线组在两拷贝间的换位，$F=S_AS_B$ 是总换位。设 $L$ 是由两个独立局部精确二设计产生的矩投影，$H_2$ 是全空间 Haar 矩投影。依据二拷贝交换子，[3] 使用的等维情形可表成下列不依赖等维条件的空间描述：
$
\operatorname{ran} L=\operatorname{span}\{I,F,S_A,S_B\},\qquad
\operatorname{ran} H_2=\operatorname{span}\{I,F\}.
\tag{3}
$
对任意中间酉门系综的二拷贝共轭平均 $T$，夹层 $LTL$ 和其伴随固定 $I,F$。二者均与左乘 $F$ 对易。后者在局部四维空间把 $I,F$ 互换、把 $S_A,S_B$ 互换，因此局部空间中与全局投影正交的两条一维线分别由
$
g_\pm=S_A\pm S_B,\qquad v_\pm=(1-H_2)g_\pm
$
生成。任一夹层在这两条线各自乘一个实数，在 $\operatorname{ran} L^\perp$ 为零。实数来自对自伴算子的 Hilbert–Schmidt 配对。两个夹层各自把一条线杀掉，乘积就是 $H_2$。

令 $N_A$ 为从 $A$ 上所有无符号 Pauli 入射的概率矩阵在 $A$ 上的总出射质量，$N_{AB}$ 为从 $B$ 上所有无符号 Pauli 入射的概率矩阵在 $A$ 上的总出射质量。局部 Pauli 都含恒等，且张量补线上的恒等。换位展开为 $S_A=p^{-1}\sum_{Q\in\mathcal P_A}Q\otimes Q$、$S_B=2^{-1}\sum_{Q\in\mathcal P_B}Q\otimes Q$。据 $\operatorname{Tr}[(Q\otimes Q)(Q'\otimes Q')]=d^2\mathbf1_{Q=Q'}$，得到
$
\langle S_A,TS_A\rangle=4N_A,\qquad
\langle S_A,TS_B\rangle=2pN_{AB}.
\tag{4}
$
由左乘 $F$ 的等距性得到另外两个配对相等。利用 $\operatorname{Tr} S_A=2d$、$\operatorname{Tr} S_B=pd$，直接投影给出 $H_2g_\pm=(2\pm p)(I\pm F)/(d\pm1)$。从而两条线的特征值分子满足
$
\tfrac12\langle v_\pm,LTLv_\pm\rangle
=4N_A\pm2pN_{AB}-\frac{2p(p\pm2)^2}{2p\pm1}.
\tag{5}
$
式 (5) 为零即对应一条线消失。

## 3. 确切的参数

用 $x\in[0,1]$ 指定一次旋转的参数 $w$，测量角由 $\theta=\tfrac12\arcsin\sqrt{w}$ 确定。下文 $A_i$ 是 $A$ 的第 $i$ 条线。

**负线。** 对 $A_1,B$ 依次用 $XX,YY,ZZ$，每次 $w=x$。这三个无符号 Pauli 置换对易。一个非恒等单边 Pauli 恰与其中两个反对易；两个有效置换都发生时从一边移到另一边，只发生一个时变成双边 Pauli，都未发生时停在原处。因此
$
 N_A=\frac{p^2}{4}\bigl(1+3(1-x)^2\bigr),\qquad N_{AB}=1+3x^2 .
$
前式的 $p^2/4$ 来自固定不动的 $A$ 旁观线。式 (5) 的负号归零等价于
$
 (p-2)x^2-2p x+c=0,\qquad c=\frac{2(p^2-1)}{2p-1}.
$
它在 $[0,1]$ 上严格递减，端点分别为 $c>0$ 和 $-3p/(2p-1)<0$，故根
$
 x_-=\frac{c}{p+\sqrt{p^2-(p-2)c}}
\tag{6}
$
位于 $(0,1)$，包含 $p=2$ 的线性情形。

**正线，$n=2$。** 用 $XX,YY$，对应 $w=x,x/2$。四个置换子程序，按空、仅首、仅次、全选排列，其 $(N_A,N_{AB})$ 分别是 $(4,1),(2,1),(2,1),(1,2)$。这是因为单次置换把两个非恒等单边 Pauli 送到双边，而两次合成只把 $Z_B$ 送往 $A$，且把 $X_A,Y_A,Z_A$ 都移出 $A$。带上两个独立权重得 $N_A=4-3x+x^2/2$、$N_{AB}=1+x^2/2$。式 (5) 的正号在根
$
 x_+=(3-3/\sqrt5)/2
\tag{7}
$
归零。

**正线，$n\ge3$。** 用 $Z_{A_1}X_B,Z_{A_2}Z_B$，均取 $w=x$。在活动三线上，空、仅首、仅次、全选的 $(N_A,N_{AB})$ 分别为 $(16,1),(8,1),(8,1),(4,1)$。空、单次的计数由 $A$ 上反对易比例 $1/2$ 得到。两次时，从 $A_1,A_2$ 入射的 $X$ 在 $B$ 上分别投影到 $Y,Z$，故从 $A$ 到 $B$ 投影的二元线性映射的秩为二。$B$ 入射的 $X,Z$ 分别投影为 $Y,X$，也有秩二。故全选时恰有 $2^{4-2}=4$ 项从活动 $A$ 留在 $A$，且 $B$ 入射仅恒等落在 $A$。乘上旁观线因子给出 $N_A=p^2(1-x/2)^2$、$N_{AB}=1$。式 (5) 的正号在
$
 x_+=2\left(1-\sqrt{\frac{p^2+2p+3}{2p(2p+1)}}\right)
\tag{8}
$
归零。根号内严格位于 $1/4$ 和 $1$ 之间，故 $0<x_+<1$。

## 4. 图的递归构造

先并行施行 $A,B$ 上的设计，再施行负线旋转块，再并行施行 $A,B$ 上的设计，接着施行正线旋转块，最后再并行施行 $A,B$ 上的设计。假设 $n-1$ 项已构造。两组旋转之后的局部矩均吸收各自的输出 Pauli，故整个程序的矩恰为
$
 LT_+ L T_-L=(LT_+L)(LT_-L)=H_2.
$
每次测量的数据都是新的独立位，故组合的等式适用于每个维度。基例和归纳给出任意 $n$ 的确切构造。

每个活动二体 Pauli 旋转可用两个单体 Clifford $D_i,D_j$ 与一个 $\mathrm{CNOT}_{i\to j}$ 构造 $C=(D_iD_j)\mathrm{CNOT}_{i\to j}$，使 $C Z_j C^\dagger=P$。采用 $D_i Z D_i^\dagger\in\{X,Y,Z\}$ 的固定选择 $H,R_z(\pi/2)H,I$。所有门以 §1 的规则转成图边和测量角。这给出有限的静态开放图。每层至多五个二体旋转，测量数满足 $M_n=3(M_{n-1}+5)+O(1)$，所以此构造的尺寸上界为 $O(3^n)$。本结果的量词为每个 $n$ 存在一个有限开放图，其输入输出均为 $n$ 比特。完整无删边矩形簇图、三阶及以上和最小资源量仍需另外确定。

## 参考文献

1. Peter S. Turner and Damian Markham, *Derandomizing Quantum Circuits with Measurement-Based Unitary Designs*, Physical Review Letters 116, 200501 (2016), final paragraphs on multiqubit exact designs. DOI 10.1103/PhysRevLett.116.200501.
2. Rafael N. Alexander, Peter S. Turner, and Stephen D. Bartlett, *Randomized Benchmarking in Measurement-Based Quantum Computing*, Physical Review A 94, 032303 (2016), Eq. (3.5) and §IV. DOI 10.1103/PhysRevA.94.032303.
3. Ryotaro Suzuki, Hosho Katsura, Yosuke Mitsuhashi, Tomohiro Soejima, Jens Eisert, and Nobuyuki Yoshioka, *More global randomness from less-random local gates*, Physical Review A 114, 022424 (2026), §II.B. DOI 10.1103/9tnv-2559.

4. Conrad Strydom and Mark Tame, *Implementation of single-qubit measurement-based t-designs using IBM processors*, Scientific Reports 12, 5014 (2022), Introduction. DOI 10.1038/s41598-022-08632-z.
