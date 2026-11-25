# 有向环的双季节频率见证

*任意正边权与四环弱幅度的四阶效应*

## 1. 研究问题

考虑固定传输生成元、两个交替对角势下的正线性系统。Monmarché、Schreiber 和 Strickler（2025）给出了慢切换的 Perron 重叠展开，并在有向环中采用与站点数相同的环境数。*Reversibility and frequency reduction in periodic and random positive systems*（2026）第 6 节给出两态弱振幅判据。其第 10 节将单位四环列为半正定的边界例，留下有限幅度两态见证问题。

本文证明，每个至少有三个站点的正权单向简单环，都存在两个季节使主 Floquet 指数在某个内点严格超过慢、快两个极限。两个季节的停留比例可任意指定。单位四环在任意小的非零振幅下也有见证，其慢切换系数呈严格正的四阶效应。相同构造亦给出两态 Markov 切换的正慢切换修正。

## 2. 加权有向环

以 $i=0,\ldots,n-1$ 模 $n$ 编号，令 $a_i>0$ 为 $i$ 到 $i+1$ 的传输率。在列向量约定中，
$$
L_{i,i-1}=a_{i-1},\qquad L_{i,i}=-a_i .
$$
对正向量 $v$，令
$$
A(v)=L+\operatorname{diag}\!\left(a_i-a_{i-1}\frac{v_{i-1}}{v_i}\right)_{i=0}^{n-1}.
$$
于是 $A(v)v=0$。写 $w_i=1/a_{i-1}$，$s(v)=\sum_i w_i v_i/v_{i-1}$。直接代入得左向量
$$
\ell_i(v)=\frac{w_i/v_{i-1}}{s(v)},\qquad
\ell(v)^\top A(v)=0,\qquad\ell(v)^\top v=1.
$$
因为 $A(v)$ 是不可约 Metzler 矩阵，零是简单谱界，其他特征值实部严格小于零。

以比例 $1-\alpha,\alpha$ 交替运行 $A(\mathbf1),A(v)$，其中 $0<\alpha<1$，周期记为 $T$。周期传播矩阵为 $M(T)=e^{\alpha T A(v)}e^{(1-\alpha)T A(\mathbf1)}$，主指数为 $\Lambda(T)=T^{-1}\log\rho(M(T))$。当 $T\to\infty$ 时，各半程矩阵趋于 Perron 投影，乘积的唯一非零特征值为
$$
K(v)=\bigl(\ell(v)^\top\mathbf1\bigr)\bigl(\ell(\mathbf1)^\top v\bigr)
=\frac{(\sum_iw_i v_i)(\sum_iw_i/v_{i-1})}
 {(\sum_iw_i)(\sum_iw_i v_i/v_{i-1})}. \tag{1}
$$
故 $\Lambda(T)=[\log K(v)+o(1)]/T$。

令 $v_i=M^i$，$M>1$，并记 $W=\sum_iw_i$。因为 $s(v)\le MW$、$\sum_iw_i v_i\ge w_{n-1}M^{n-1}$、$\sum_iw_i/v_{i-1}\ge w_1$，
$$
K(v)\ge \frac{w_{n-1}w_1}{W^2}M^{n-2}.
$$
在 $n\ge3$ 时，只需 $M>(W^2/(w_{n-1}w_1))^{1/(n-2)}$ 即得 $K>1$，且增大对比度可使 $K$ 任意大。单位三环取 $v=(1,4,16)$ 得 $49/43$，单位四环取 $v=(1,2,4,8)$ 得 $225/196$。

快极限为 $\bar A=(1-\alpha)A(\mathbf1)+\alpha A(v)$ 的谱界。事实上 $(M(T)-I)/T$ 对 $T>0$ 是不可约 Metzler 矩阵，谱界为 $(\rho(M(T))-1)/T$，且该矩阵趋于 $\bar A$。令 $x_i=v_i^\alpha$、$r_i=v_{i-1}/v_i$，则
$$
\frac{(\bar Ax)_i}{x_i}
=a_{i-1}\bigl[r_i^\alpha-(1-\alpha)-\alpha r_i\bigr]\le0.
$$
加权算术几何平均不等式在 $r_i\ne1$ 的行严格成立。取 $\bar A$ 正左 Perron 向量与其配对，得到 $s(\bar A)<0$。因慢极限为零而充分大有限周期主指数为正，连续性与两端极限给出严格超过两端的内点全局最大值。

若季节依两态不可约连续时间 Markov 链切换，设平稳分布为 $(1-\alpha,\alpha)$，未缩放的平稳跃迁流为 $j=(1-\alpha)\xi_{12}=\alpha\xi_{21}>0$。Monmarché 等的定理 1(3–4) 给出慢切换的一阶项 $j\log K(v)>0$，快极限仍为 $s(\bar A)<0$，故两态 Markov 主指数也非单调。

## 3. 单位四环的任意小振幅见证

令 $a_i=1$、$v=(u,1,u^{-1},1)$，其中 $u=e^\varepsilon$，$\varepsilon\ne0$。式 (1) 化简为
$$
K(v)=\frac{(u+u^{-1}+2)^2}{8(u+u^{-1})}
=1+\frac{(\cosh\varepsilon-1)^2}{4\cosh\varepsilon}>1 .
$$
因此 $\log K(v)=\varepsilon^4/16+O(\varepsilon^6)$。例如 $u=2$ 时 $K=81/80$。两季节的对角势之差为
$$
 (1-\cosh\varepsilon)\mathbf1+\sinh\varepsilon\,(1,-1,-1,1).
$$
去除标量对角项只平移各频率的指数，并保留相对大小和重叠系数。剩余振幅为 $\lvert\sinh\varepsilon\rvert$，可任意小。其中心方向 $d=(1,-1,-1,1)$ 落在近邻论文的二次型零空间。记循环移位为 $S$、常数投影为 $P$。在由 $d$ 及其循环移位展开的子空间上，$S^2=-I$，故 $(-L+P)^{-1}-P$ 等于 $(I+S)/2$。它的平方为反对称的 $S/2$，所以二次项为零。正的四阶项填补了单位四环的退化情形。

## 4. 文献与范围

传播矩阵固定，只有两个对角势状态。相等停留时间的周期协议在反演时间后只需平移相位。任意正权单向简单环和单位四环弱幅度情形均由上述构造覆盖。一般的不可逆网络仍需另行刻画。

- *Reversibility and frequency reduction in periodic and random positive systems*，匿名，Evidence Press / Zenodo，0.1.0-candidate，2026。第 6 节定理 6.1、第 10 节开放问题 1。[存档](https://zenodo.org/records/23911074)。
- Monmarché、Schreiber 和 Strickler，*Impacts of Tempo and Mode of Environmental Fluctuations on Population Growth*，Bulletin of Mathematical Biology **87** (2025), 81。定理 1 和第 4.2 节。[作者存档全文](https://schreiber.faculty.ucdavis.edu/wp-content/uploads/sites/568/2025/07/BMB-2025.pdf)。
- Benaïm、Lobry、Sari 和 Strickler，*When can a population spreading across sink habitats persist?*，Journal of Mathematical Biology **88** (2024), 19。猜想 1。[作者预印本](https://arxiv.org/html/2311.04706v2)。
