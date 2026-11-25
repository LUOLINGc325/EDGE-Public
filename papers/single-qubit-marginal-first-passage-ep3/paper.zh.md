# 单 qubit 普通首次通过时间的三阶例外点

**摘要**　对任意指定的正 Laplace 点，构造只有一个计数跳跃算符的监测 qubit。第 $n$ 次计数时刻的普通 Laplace 变换经完整末态求和后，仍含非零的 $\binom n2\lambda^{n-2}$ 项。对同一固定过程改变 Laplace 变量，三条谱支在该点按立方根分裂。证明以显式三阶 Jordan 块为基点，通过两个旋转参数维持三重根，并以态依赖计数率解除迹读出的消去。此结果给出 Bridges 对广义首次通过可见性提问中的一个解析正例。

## 1. 模型与命题

设 $\rho_+=(I+\sigma_z)/2$，$T_n$ 是从该态出发的第 $n$ 次被监测计数时刻。给定 $\gamma>0$ 与 $s_*>0$，记 $\eta=\gamma+s_*$、$\omega=\sqrt{63}\,\eta$，取
$$
 H=\omega\sigma_z/2,\qquad
 L=\sqrt\gamma\,U(c,w)\sqrt{I+\epsilon\sigma_z}.
$$
只有 $L$ 产生跳跃。$U(c,w)$ 的 Bloch 旋转为 $R_{c,w}R_z(-\alpha_*)$，其中 $\alpha_*=\arg(\eta/(\eta-i\omega))$，$R_{c,w}$ 按右手方向绕 $(\sqrt{1-w},0,\sqrt w)$ 旋转，角余弦为 $c$ 且角在 $(0,\pi)$ 内。

**定理。** 存在实解析控制 $c(\epsilon),w(\epsilon)$，基点为 $(1/2,1/7)$，使对所有充分小的 $0<|\epsilon|<1$，普通变换有以下精确结构，其中各谱量和幅度取在 $s_*$，$q=\gamma/\eta$：
$$
 \mathbb E_{\rho_+}e^{-s_* T_n}
 =q^n\left[P\kappa^n+B_0\lambda^n
 +B_1n\lambda^{n-1}
 +B_2\binom n2\lambda^{n-2}\right],\qquad
 B_2=-\frac{s_*}{28\eta}\epsilon+O(\epsilon^2).
$$
$\kappa$ 是接近 1 的单根，$\lambda$ 是接近 $1/4$ 的三重根，对应一个三阶 Jordan 块。对每个固定的小 $\epsilon$ 及其控制，当 $s$ 偏离 $s_*$ 时，三重谱根有非零的立方根分裂首项。

记 $\mathcal A_s(X)=sX+i[H,X]+\{L^\dagger L,X\}/2$，$\mathcal J(X)=LXL^\dagger$。对每次计数前的无跳跃传播积分，得到一步核 $\mathcal R_s=\mathcal J\mathcal A_s^{-1}$。因此 $\mathbb E e^{-sT_n}=\operatorname{tr}\mathcal R_s^n(\rho_+)$ [1,2]。由于 $L^\dagger L\ge\gamma(1-|\epsilon|)I$，每一步等待时间的存活概率有指数上界。取归一化核 $\mathcal K_s=\mathcal R_s/q_s$，$q_s=\gamma/(\gamma+s)$。用实坐标 $X=(t I+v\cdot\sigma)/2$，其中 $t=\operatorname{tr}X$。

## 2. 显式基点与三重根保持

在 $\epsilon=0$ 情况，$\mathcal K_s$ 保迹且保单位矩阵。自由演化的 $x+iy$ 分量经等待时间平均后乘 $f_s=(\gamma+s)/(\gamma+s-i\omega)$。故 $\mathcal K_{s_*}=1\oplus A$，其中 $A=R_{c,w}\operatorname{diag}(d,d,1)$，$d=|f_{s_*}|=1/8$。设 $z=R_{33}=c+(1-c)w$，$a=R_{11}+R_{22}=1+2c-z$。旋转矩阵的余因子矩阵等于它自身，故 $A$ 的特征多项式写成 $x^3-Tx^2+Qx-D$，其中
$$
 T=da+z,\qquad Q=da+d^2z,\qquad D=d^2 .
$$
在 $(c,w)=(1/2,1/7)$ 有 $(T,Q,D)=(3/4,3/16,1/64)$，特征多项式等于 $(x-1/4)^3$。设 $N=A-I/4$。用 Rodrigues 公式计算得到
$$
 (N^2)_{zz}=3/112,\qquad
 \operatorname{tr}(N^2 Z)=3\sqrt{21}/224,
 \qquad Z=\begin{pmatrix}0&-1&0\\1&0&0\\0&0&0\end{pmatrix}.
$$
由 Cayley–Hamilton 定理 $N^3=0$。第一项非零确立阶数三。

当 $(\epsilon,c,w)$ 在基点附近时，完整四维核的特征多项式可除去接近 1 的实解析单根 $\kappa$。所得三次因子的 $T,Q,D$ 实解析。三重根条件为 $Q-T^2/3=D-T^3/27=0$。在 $\epsilon=0$，$(c,w)\mapsto(a,z)$ 的 Jacobian 行列式为 $2(1-c)$，$(a,z)\mapsto(T,Q)$ 的行列式为 $d(d^2-1)$，且 $D$ 恒定。$(T,Q)\mapsto(Q-T^2/3,D-T^3/27)$ 的行列式为 $T^2/9$。三者乘积在基点为 $-63/8192$。隐函数定理给出所需的两项控制，$\lambda=T/3$。接近三根的谱投影实解析，因为该谱簇与 $\kappa$ 保持分离。由连续性，其限制核去掉 $\lambda I$ 后的平方仍非零，因而三重根仍对应一个三阶块。

## 3. 完整末态求和保留二次项

在 $s=s_*$ 下，将 $\mathcal K_{s_*}$ 写成分块矩阵 $\begin{pmatrix}a_0&b\\g&A_0\end{pmatrix}$。三根谱子空间接近 $t=0$，故能用图坐标 $t=\ell v$，$\ell$ 随 $\epsilon$ 实解析。子空间不变性给出
$$
 \ell(A_0+g\ell)=a_0\ell+b .
$$
在零点 $\ell=0,a_0=1,A_0=A$，所以 $\ell'(A-I)=b'$。为求 $b'$，取无跳跃 resolvent 的迹。由 $\operatorname{tr}\mathcal R_s X=\operatorname{tr}X-s\operatorname{tr}\mathcal A_s^{-1}X$，并用 $\mathcal A_{s_*}$ 在 $(t,v_z)$ 的矩阵
$\left(\begin{smallmatrix}\eta&\gamma\epsilon\\\gamma\epsilon&\eta\end{smallmatrix}\right)$，直接得到
$$
 b'(0)=\frac{s_*}{\eta}e_z^T .
$$
该导数独立于旋转参数。设 $v_\epsilon$ 为三根谱投影作用在 $\rho_+$ 后的向量坐标，$N_\epsilon=A_0+g\ell-\lambda I$。取 $\mathcal K_{s_*}^n$ 的迹即可读出 $B_2=\ell N_\epsilon^2v_\epsilon$。在零点 $v_0=e_z$，而 $AN^2=N^2/4$，故
$$
 B_2'(0)=b'(0)(A-I)^{-1}N^2e_z
 =\frac{s_*}{\eta}\,\frac{3/112}{1/4-1}
 =-\frac{s_*}{28\eta}.
$$
因此所有充分小的非零 $\epsilon$ 都有非零二次项。由 $\kappa\ne\lambda$ 与 $\lambda\ne0$，该项无法用其余三项吸收。$s_*>0$ 是必要的，因为在 $s=0$ 普通变换恒为 1。Hilbert 空间维数一只能产生标量步核，且单计数通道是发生计数所需的最少通道数。

## 4. 固定过程的 Laplace 谱分裂

先在基点锁定 $H$ 和 $U$，并改变 $s$。归一化 Bloch 块为 $A_s=R_{c,w}\operatorname{diag}(|f_s|,|f_s|,1)R_z(\arg f_s-\alpha_*)$，故
$$
 \left.\partial_s A_s\right|_{s_*}
 =\eta^{-1} A\left[\frac{63}{64}\operatorname{diag}(1,1,0)
 -\frac{\sqrt{63}}{64}Z\right].
$$
在三重根处 $\operatorname{adj}(\lambda I-A)=N^2$，可由 $(xI-A)^{-1}$ 的有限 Laurent 展开直接求出。用 $\operatorname{tr}N^2=0$ 得到
$$
 \left.\partial_s\det(\lambda I-A_s)\right|_{s_*}
 =\frac{1}{\eta}\left(\frac{9\sqrt3}{8192}+\frac{27}{4096}\right)>0 .
$$
除去单根的实解析三次因子记为 $p(x,s)$，此非零导数沿维持三重根的控制连续保持。令 $s-s_*=u^3$、$x=\lambda+uy$。$u^{-3}p(\lambda+uy,s_*+u^3)$ 在 $u=0$ 延拓为 $y^3+\partial_s p(\lambda,s_*)$，其三个根各自简单。隐函数定理给出 $x=\lambda+u\xi+O(u^2)$，其中 $\xi$ 遍历 $-\partial_s p(\lambda,s_*)$ 的三个立方根。乘回 $q_s$ 后非零的分裂首项仍保留。

## 5. 文献范围

1. L. Bridges, *An exact Jordan signature in cumulative-count first-passage statistics*, arXiv:2609.20148v2，§§1、5、7。最新版本给出三经典相位、普通变换可见的二阶基准，并提出在更广的一计数核中识别末态总和可见性的后续问题。v1 的 §8 使用三能级与二值末态测量。
2. P. Menczel 等，arXiv:2508.18614。出处确立计数统计和首次通过传播子的关系，并提出首次通过中的例外点研究方向。
3. P. A. Brandão, *Operational signatures of exceptional quantum channels*, arXiv:2610.13622。一般迭代通道的 Jordan 可见性与显式二阶二值读出为相邻结果。本文的实质是由合法单通道量子轨道产生三阶核，并让唯一读出为完整末态迹。
4. A. Barchielli, arXiv:2605.01411。该工作研究两次跳跃之间的等待与存活规律。这里的三重根位于已对等待时间积分的一计数核，且对应任意有限阈值的精确变换。
5. W. C. Wong, B. Zeng 与 J. Li, *Non-Markovian exceptional points by interpolating quantum channels*, npj Quantum Information 12, 63 (2026)。该工作构造出插值量子通道的单 qubit 三阶块。本文的三阶谱块位于固定监测过程的一计数核，普通计数时间统计给出可见性。

本文证明受控 qubit 家族的存在性、可见性和变换谱分裂。控制由解析隐函数给出，结论量化在基点邻域内。一般核的分类及时间域反演仍属开放范围。
