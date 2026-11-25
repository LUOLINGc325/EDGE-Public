# 量子首次通过核的逆实现与任意维可见例外点

**摘要**　给定完全正映射与一个正 Laplace 点，本文给出该映射能否作为有限维监测 Lindblad 动力学一步计数核的半正定判据。满 Choi 秩映射经充分小的正比例缩放后可实现。Choi 秩一情形则有闭式判据。应用于任意 $d$ 维系统，可在零 Hamiltonian 下构造阶数 $d^2-1$ 的暂态 Jordan 块。普通第 $n$ 次计数时刻的变换保留次数 $d^2-2$ 的项，且固定系统的一步核随 Laplace 变量产生非零根式分裂。

## 1. 一步生成核及逆问题

所有跳跃都计入同一个累计计数，单步完全正跳跃映射记为 $J(X)=\sum_a L_aXL_a^\dagger$，总率 $G=J^*(I)$，$H$ 是 Hermitian Hamiltonian，星号为 Hilbert–Schmidt 伴随。定义
$$
 A_s(X)=sX+i[H,X]+\frac12\{G,X\},\qquad R_s=J A_s^{-1},\qquad s>0.
$$
前式来自对无跳跃传播 $X\mapsto e^{-t(iH+G/2)}X e^{-t(iH+G/2)^\dagger}$ 作 Laplace 积分。一步核的乘法给出第 $n$ 次计数时刻 $T_n$ 的普通变换 $\operatorname{tr}R_s^n(\rho)$ [1–3]。若计数可能终止，取 $e^{-s\infty}=0$。

**定理 1。** 设 $R$ 是给定有限维完全正映射，固定 $s_*>0$，$B=R^*(I)$。$R$ 是上述全计数模型的一步核 $R_{s_*}$ 当且仅当 $B<I$，且以下关于 Hermitian $H$ 的 Choi 矩阵半正定约束可行。取 $B$ 的一组本征基，$B_{ii}=b_i$，令
$$
 G(H)_{ij}=\frac{s_* b_i\delta_{ij}-i[H,B]_{ij}}{1-(b_i+b_j)/2},
 \qquad
 J_H=R\bigl(s_*\,\mathrm{id}+i[H,\cdot]+\{G(H),\cdot\}/2\bigr).
$$
约束为 $C_{J_H}\ge0$。对每个可行 $H$，$J_H$ 的任一 Kraus 分解均给出实现。

证明中，先给 $B<I$ 的必要性。任一密度矩阵下的无跳跃存活概率 $S(t)$ 满足 $S'(t)\ge-\|G\|S(t)$，故 $S(t)\ge e^{-\|G\|t}$。分部积分给出 $\operatorname{tr}R_{s_*}(\rho)=1-s_*\int_0^\infty e^{-s_*t}S(t)\,dt\le\|G\|/(s_*+\|G\|)<1$。又由 $R_{s_*}=J A_{s_*}^{-1}$ 得 $G=A_{s_*}^*(B)=s_*B-i[H,B]+\{G,B\}/2$，逐分量唯一解出 $G(H)$。反之，若 $J_H$ 完全正，该等式保证 $G(H)=J_H^*(I)\ge0$。因 $s_*>0$，相应无跳跃传播的 Laplace 积分收敛，$A_{s_*}$ 可逆。因此实现得到的核恰为 $J_H A_{s_*}^{-1}=R$。

**直接推论。** 给定 Choi 矩阵正定的完全正映射 $R_0$，每个充分小的 $q>0$ 都能在 $H=0$ 下实现 $R=qR_0$。此时 $B=qR_0^*(I)$，$G=s_*B(I-B)^{-1}$，并且 $C_{J_0}=s_*q C_{R_0}+O(q^2)$，故小 $q$ 时正定。

## 2. Choi 秩一端点

**定理 2。** 若 $R(X)=VXV^\dagger$，$V\ne0$，则其可实现性等价于 $V^\dagger V=qP$，其中 $P$ 是该算符的支撑投影，$0<q<1$。此结论允许自由选择 $H$。

设 $Q=iH+G/2$。一步核的 Choi 矩阵是各 $L_a e^{-Qt}$ 的向量化外积的带正 Laplace 权重积分。若它秩一，任何垂直于 $V$ 向量化的向量对应的二次型为零。连续性及各被积项非负使所有 $L_a e^{-Qt}$ 对每个 $t\ge0$ 均落在 $\mathbb C V$。令 $t=0$ 得 $L_a=\ell_a V$，并由右导数得 $VQ=\zeta V$。$V$ 在 $P$ 上单射，故 $PQP=\zeta P$。其 Hermitian 部分是 $PGP/2=(\sum_a|\ell_a|^2)V^\dagger V/2$，所以 $V^\dagger V$ 在支撑上为标量。反之，取 $H=0$ 与单跳跃 $L=\sqrt{s_*/(1-q)}\,V$。在 $P$ 支撑上的双边块，$A_{s_*}$ 乘以 $s_*+s_*q/(1-q)$，其余块被 $J$ 消去，故 $J A_{s_*}^{-1}=R$。由此也得到任意降尺度仍不可实现的秩一例，只须令 $V$ 有两个不相等的非零奇异值。

## 3. 任意维的普通变换可见性

取 $d\ge2$、$m=d^2-1$。用迹和无迹正交 Hermitian 基 $F_1,\ldots,F_m$ 写 $X=t I/d+\sum_i v_iF_i$。令 $N e_{i+1}=e_i$、$N e_1=0$，$A=\mu I+\alpha N$，$S_\beta(t,v)=(t+\beta\ell v,v)$，其中 $\mu,\alpha$ 为很小的正数，$\ell_1=1$。设
$$
 K=S_\beta(1\oplus A)S_\beta^{-1},\qquad R=qK,\qquad 0<q<1.
$$
对任意固定 $q$，在 $(\mu,\alpha,\beta)=(0,0,0)$，$K$ 是完全去极化核 $X\mapsto(\operatorname{tr}X)I/d$，$B=qI$，$J_0=s_*qK/(1-q)$。它们的 Choi 矩阵正定。由连续性，任意充分小的参数都给出 $B<I$ 及物理无 Hamiltonian 实现。此时 $G$ 在小邻域内正定，故所有计数几乎必然发生。$q$ 是单的最大模根，余下谱子空间为一个 $m$ 阶块。

对充分小的非零实数 $\delta$，取初态 $\rho=I/d+\delta F_m$。其变换归一化后为
$$
 q^{-n}\mathbb E_{\rho} e^{-s_* T_n}
 =1-\beta\delta\ell_m+\beta\delta\,\ell A^n e_m .
$$
由 $N^{m-1}e_m=e_1$，最高次数系数恰为 $\beta\delta\alpha^{m-1}$，乘在 $\binom n{m-1}\mu^{n-m+1}$ 前。完整末态迹保留该项。这个暂态 Jordan 阶数达到具有单的最大模根的 $d$ 维核的维数上界。

## 4. 固定模型的 Laplace 谱分裂

冻结上述实现的 $J,G$，只让 $s$ 变化。$R_s=R A_{s_*}(A_{s_*}+(s-s_*)\mathrm{id})^{-1}$，所以 $\partial_sR_s|_{s_*}=-R A_{s_*}^{-1}$。令 $C=S_\beta^{-1}A_{s_*}^{-1}S_\beta$，$C_{m1}$ 指其无迹到无迹块在第 $(m,1)$ 项的分量。取 $p(x,s)$ 为从特征多项式中除去接近 $q$ 的单根后所得首一因子，在 $x=q\mu,s=s_*$ 有
$$
 \partial_s p(q\mu,s_*)=q\mu(q\alpha)^{m-1} C_{m1}.
$$
这是因为 $qA$ 的伴随矩阵在重根处为 $(q\alpha N)^{m-1}$，且 $\operatorname{tr}(N^{m-1}AC)=\mu C_{m1}$，迹只作用在无迹坐标块。完整分块行列式中，单根差因子在两侧消去。

记 $D=\sum_i(\ell(A-I))_i F_i$，于是 $B=q(I+\beta D)$。在 $\beta=0$，$A_{s_*}^{-1}=((1-q)/s_*)\,\mathrm{id}$。图变换的导数对标量算符抵消。由 $G=s_*((I-B)^{-1}-I)$，得
$$
 \left.\partial_\beta C_{m1}\right|_0
 =-\frac{q}{2s_*}\operatorname{tr}\bigl(F_m\{D,F_1\}\bigr).
$$
对 $d\ge3$，取 $\ell=e_1^T$，$F_1=\operatorname{diag}(1,-1,0,\ldots)/\sqrt2$，$F_m$ 为 $F_1^2-I/d$ 归一化而得，$F_2$ 为无迹标准化的 Hermitian 非对角矩阵。它们两两正交。$D=(\mu-1)F_1+\alpha F_2$，非对角项对 $F_m$ 的迹为零，故上式为 $q(1-\mu)\|F_1^2-I/d\|_2/s_*>0$。

对 $d=2$，令 $F_i$ 为对应于 $\sigma_i/\sqrt2$ 的三个 Pauli 方向，$\ell=e_1^T+e_3^T$。设 $D=\sum_i d_iF_i$，此时 $d_1=d_3=\mu-1$。由于 $D^2=\chi I$，$\chi=\sum_i d_i^2/2$，可写 $A_{s_*}(X)=\eta X+g\{D,X\}/2$，其中
$$
 \eta=\frac{s_*(1-q)}{(1-q)^2-q^2\beta^2\chi},\qquad
 \frac g\eta=\frac{q\beta}{1-q}.
$$
要取 $C_{31}$，求解该 $A_{s_*}$ 对 $(\beta,e_1)$ 的逆像 $(t,v)$。方程是 $\eta t+g d^T v=\beta$ 与 $\eta v+g dt/2=e_1$。因 $S_\beta^{-1}$ 不改向量坐标，解得
$$
 C_{31}=v_3=\frac{q\beta^2(1-\mu)(1-q\mu)}{2s_*(1-q)} .
$$
因此两个维数范围内，对充分小的非零 $\beta$ 均有 $\partial_s p(q\mu,s_*)\ne0$。令 $s-s_*=u^m$、$x=q\mu+u y$，解析函数 $u^{-m}p(q\mu+uy,s_*+u^m)$ 在 $u=0$ 为 $y^m+\partial_s p(q\mu,s_*)$。它的 $m$ 个简单根分别解析延拓，产生 $x=q\mu+u\xi+O(u^2)$，$\xi$ 为非零的 $m$ 个根式首项。

## 5. 来源与范围

1. L. Bridges, *An exact Jordan signature in cumulative-count first-passage statistics*, arXiv:2609.20148v2，§7 提出在更广的一计数核中研究完整末态求和可见性的后续问题。该文给出三相位二阶情形。
2. P. Menczel 等，*Full counting statistics and first-passage times in quantum Markovian processes*, arXiv:2508.18614v2，§IV 提出首次通过例外点方向。
3. C. Gneiting, A. V. Rozhkov 与 F. Nori, *Jump-time unraveling of Markovian open quantum systems*, Phys. Rev. A 104, 062212 (2021)，建立跳跃次数处的动力学迭代。
4. W. C. Wong, B. Zeng 与 J. Li, *Non-Markovian exceptional points by interpolating quantum channels*, npj Quantum Information 12, 63 (2026)，研究插值 CPTP 通道三阶例外点。本文改变的是同一计数时间分布的 Laplace 对偶变量。

定理 1 刻画有限维全计数模型单一步核的正 Laplace 点可实现性。任意维例使用 $d^2$ 个计数 Kraus 算符。单跳跃算符限制下的 qubit 三阶构造另有独立案例。本例的谱分裂和可见性都在变换域证明。
