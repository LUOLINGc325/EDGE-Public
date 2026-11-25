# 有限可逆链的修正对数 Sobolev 常数：重心证书与谱隙分岔

## 摘要

修正对数 Sobolev 常数控制有限可逆链对任意初始分布的统一熵衰减。本文证明，任何严格低于该常数的阈值，都能由单纯形分片重心处的熵耗散切平面和一个平衡邻域的谱隙估计在有限步认证。正权边的对数发散保证了边界覆盖，适用范围包含稀疏连通链。配合单个试验分布，这给出不需半正定优化的两侧逼近。我们还证明慢模三次矩非零时，最坏熵衰减由非平衡分布达到。三次矩为零时，快模的四阶修正仍可产生严格下降。在一个谱隙等号基点附近，慢模三次矩判定等号和严格间隔，出现严格间隔时有唯一极小点，并给出其幅度及常数差的首项。一个所有跃迁率都为正的三态链展示了完整的局部参数分界。

## 1. 模型与结论

设 $Q$ 是 $N\ge2$ 个状态上的有限不可约连续时间马尔可夫生成元，对严格正概率向量 $\pi$ 可逆。记 $w_{ij}=\pi_iQ_{ij}=w_{ji}$（$i\ne j$），$L=-Q$，$\lambda>0$ 为 $L$ 的最小正本征值。对概率向量 $p$，设 $h_i=p_i/\pi_i$。定义

$$
\mathcal E(u,v)=\sum_{i<j}w_{ij}(u_i-u_j)(v_i-v_j),\qquad
D(p)=\sum_i p_i\log h_i,\qquad A(p)=\mathcal E(h,\log h).
$$

内积和期望以 $\pi$ 为权，故 $\mathcal E(u,v)=\langle u,Lv\rangle_\pi$。在闭单纯形上令 $0\log0=0$，只在严格正的点上评价 $A$。本稿的修正对数 Sobolev 常数为

$$
\rho=\inf_{p_i>0,\ p\ne\pi}\frac{A(p)}{2D(p)}.
$$

采用这个因子二的归一化，沿半群的相对熵满足 $-\mathrm dD/\mathrm dt=A$，最优统一指数为 $2\rho$。Taye 的三态算例取能级 $E=(0,2/5,3)$、对称速率因子 $\gamma_{01}=1,\gamma_{02}=23/5,\gamma_{12}=3/25$，从 $i$ 到 $j$ 的率为 $\gamma_{ij}\exp((E_i-E_j)/2)$，平衡权重与 $\exp(-E_i)$ 成正比。已公开的证书证明这一固定生成元满足 $2.037150367\le\rho<2.037150368$，并证明唯一极小点位于 $|p_0-0.4766385|\le10^{-4}$、$|p_2-0.0235067|\le10^{-5}$ 的矩形内，且对能级与对称速率在一个开邻域内解析依赖。本文将其中的重心检验推广到任意有限不可约可逆链，并求出谱隙等号附近的最坏初态如何变化。 固定旧稿

**定理 1（重心证书完备性）**。对每一有限不可约可逆链及每个 $0\le R<\rho$，任意足够细的有限单纯形剖分都能用下文两项检验认证 $A\ge2RD$。每片只需在自己的重心求一次 $A$ 的梯度，外加各顶点的相对熵与平衡邻域检验。特别地，重心剖分的自适应递归在有限深度停止。对可计算的链参数，有限前缀可以用外包区间认证，并配合严格正的试验分布给出收敛到 $\rho$ 的两侧区间。

**定理 2（慢模与快模判据）**。取非零慢本征函数 $Lf=\lambda f$。若 $\mathbb E_\pi f^3\ne0$，则 $\rho<\lambda$，下确界由非平衡的严格正分布达到。如果 $\mathbb E_\pi f^3=0$，令 $P_>$ 为投影到本征值严格大于 $\lambda$ 的子空间，$\Phi=P_>(f^2)$。若

$$
\frac{\lambda}{6}\,\mathbb E_\pi f^4
-\frac1{16}\langle \Phi,L^2(L-\lambda I)^{-1}\Phi\rangle_\pi<0,
\tag{1}
$$

仍有同一结论。逆只在快子空间取值，快子空间为空时第二项为零。这两种判据适用于有任意重数的谱隙；第二项是允许下述二阶快模修正后得到的精确最小四阶系数。

## 2. 重心证书的有限完备性

对 $a,b>0$ 写 $J(a,b)=(a-b)(\log a-\log b)$。其 Hessian 为 $(a+b)(1/a,-1/b)^{\mathsf T}(1/a,-1/b)$，所以 $A$ 在正象限凸。它是一阶齐次函数，故支撑平面对任意严格正参照点 $m$ 给出

$$
 A(p)\ge\nabla A(m)\cdot p.
$$

相对熵 $D$ 在闭单纯形凸且连续。若满维小单纯形 $T$ 的顶点为 $v_1,\ldots,v_N$，重心 $m=N^{-1}\sum_jv_j$ 严格正。对于 $R\ge0$，在每个严格正 $p=\sum_j\alpha_j v_j$ 上有

$$
 A(p)-2RD(p)\ge \sum_j\alpha_j[\nabla A(m)\cdot v_j-2RD(v_j)].\tag{2}
$$

这是第一个检验，只要方括号都严格正便接受 $T$。

第二个检验处理平衡点。令 $0<\eta<1$。在 $1-\eta\le h_i\le1+\eta$ 内，逐边的对数差商给 $A\ge\mathcal E(h,h)/(1+\eta)$。函数 $t\log t-t+1$ 的二阶导数为 $1/t$，所以 $2D\le\mathbb E_\pi[(h-1)^2]/(1-\eta)$。由谱隙定义，非平衡点满足

$$
\frac{A}{2D}\ge \lambda\frac{1-\eta}{1+\eta}.\tag{3}
$$

沿任何慢本征函数的直线趋平衡时该比值趋于 $\lambda$，故 $\rho\le\lambda$。因此对 $R<\rho$ 可选有理 $\eta$，使右侧严格大于 $R$。若每个顶点的每个似然比在 $(1-\eta,1+\eta)$，凸性保证整片在其中，谱隙检验接受 $T$。平衡点本身满足 $A=2RD=0$。

关键在于边界不需要先截去一层，也不需要在边界处求导。设一列失败的小片直径趋于零，选择一项未通过 (2) 的顶点 $v$。取子列令 $v$ 及其重心 $m$ 都趋于同一点 $p^*\in\Delta$. 如果 $p^*$ 是非平衡内点，(2) 方括号趋于 $A(p^*)-2RD(p^*)>0$。如果 $p^*=\pi$，整片最终落在 (3) 的开邻域。两种情形都矛盾。

若 $p^*$ 在边界，连通性给一条 $w_{ij}>0$ 的边使 $p_i^*>0$、$p_j^*=0$。由 $m$ 为重心，对每一顶点及坐标总有 $v_i\le Nm_i$。逐项求导可写成

$$
 \nabla A(m)\cdot v
 =\sum_i\sum_{j\ne i} \frac{w_{ij}v_i}{\pi_i}
   \left[\log\frac{m_i}{\pi_i}-\log\frac{m_j}{\pi_j}
         +1-\frac{m_j/\pi_j}{m_i/\pi_i}\right].\tag{4}
$$

所有可能为负的项都有统一下界。确实，$v_i\log(m_i/\pi_i)\ge v_i\log(v_i/(N\pi_i))$（按连续延拓处理 $v_i=0$）；$v_i m_j/m_i\le N$；而每个 $\log(m_j/\pi_j)$ 都有统一上界。所选边中的 $-(w_{ij}v_i/\pi_i)\log(m_j/\pi_j)$ 则趋于 $+\infty$。因 $D$ 在闭单纯形有界，失败方括号必趋于 $+\infty$，又是矛盾。这证明所有直径足够小的片都通过。论证不要求速率全正或网格形状正则，只需要链的正权边图连通及每片满维。

例如在每片使用重心剖分，其子片顶点是同一条嵌套面链的各重心。对嵌套面 $B\subseteq C$，$C$ 的重心由 $B$ 的重心与其余顶点的均值凸组合而得，后一个权重至多 $(N-1)/N$，故每个子片的直径至多为父片的这一倍数。若父片没有通过检验便递归，有限深度必覆盖整个单纯形。在固定深度，每片所用的不等式都有严格余量。对可计算 $\pi,w$，可用区间运算逐步提高精度以确认；谱隙下界也可在与常数互补的固定子空间上通过 Dirichlet 二次型减去有理阈值倍方差的正定性认证。对每个宽度目标 $\epsilon>0$，并行枚举深度、精度以及有理候选 $R<U$，要求 $U-R<\epsilon$，并枚举正有理试验点证明 $A/(2D)<U$。严格的 $R<\rho<U$ 及连续性保证某个枚举成功。这里 $\rho>0$，因为连通性使非平衡内点处耗散严格正，边界处比值趋于无穷，平衡附近有正的谱隙下界。该计算不需要半正定优化器，也不假定精确最优端点本身一定有严格证书。

## 3. 谱隙的三阶及四阶障碍

在 $h=1+u$、$\mathbb E_\pi u=0$ 附近，设 $F_\lambda=A-2\lambda D$。逐坐标展开 $\log(1+u)$ 以及 $(1+u)\log(1+u)$，得到

$$
\begin{aligned}
F_\lambda={}&\mathcal E(u,u)-\lambda\mathbb E_\pi u^2
-\tfrac12\mathcal E(u,u^2)+\tfrac\lambda3\mathbb E_\pi u^3\\
&+\tfrac13\mathcal E(u,u^3)-\tfrac\lambda6\mathbb E_\pi u^4+O(\|u\|_\infty^5).
\end{aligned}\tag{5}
$$

对 $u=tf$，$\mathcal E(f,z)=\lambda\mathbb E_\pi[fz]$。上式的二次项为零，三次项为 $-\lambda t^3\mathbb E_\pi f^3/6$。又 $2D=t^2\mathbb E_\pi f^2+O(t^3)$，故比值沿慢模满足

$$
\frac{A}{2D}=\lambda-\frac{\lambda\mathbb E_\pi f^3}{6\mathbb E_\pi f^2}t+O(t^2).\tag{6}
$$

两种符号的充分小 $t$ 都保留正概率。三次矩非零时选合适的符号即得严格小于 $\lambda$ 的试验点。

三次项为零时，允许 $u=tf+t^2g$，其中 $g$ 在快子空间。对 (5) 取四次项，二次行贡献 $\langle g,(L-\lambda I)g\rangle_\pi$。三次行中 $-\mathcal E(f,fg)$ 与 $\lambda\mathbb E_\pi(f^2g)$ 相消，留下 $-\mathcal E(g,f^2)/2$。纯四次行给 $\lambda\mathbb E_\pi f^4/6$。和为

$$
 \langle g,(L-\lambda I)g\rangle_\pi
 -\tfrac12\langle g,L\Phi\rangle_\pi+\tfrac\lambda6\mathbb E_\pi f^4 .\tag{7}
$$

在快子空间配方，唯一最优修正 $g=\tfrac14(L-\lambda I)^{-1}L\Phi$，最小系数恰为式 (1) 的左侧。它严格负时，任取足够小的非零 $t$，所得严格正的概率分布满足 $F_\lambda<0$。式 (1) 为非平衡的充分条件，正四次系数只说明这组局部试验不能给出同样结论。

两种情形都推出下确界实际达到。边界处链上存在一条从极限正坐标到极限零坐标的边，故该边的 $J\to+\infty$，其余边非负，而 $D$ 有界。因此比值在趋边界时发散。平衡点附近由 (3) 的任意小 $\eta$ 知极限下界为 $\lambda$。当 $\rho<\lambda$ 时，任何充分靠近最优的点都因而远离边界和平衡点，连续性给内部达到。

## 4. 三态交换对称例

设 $\pi=(a,a,b)$，$a=(1-b)/2$。前两态互跳速率均为 $c$，各自向第三态速率均为 $k$，第三态到前两态各为 $ak/b$。令 $k>0,c\ge0$，并假定 $\lambda=2c+k<\mu=k/b$。反对称慢模 $f=(1,-1,0)$ 的三次矩为零，快对称模含有 $\Phi=f^2-(1-b)$，其平方范数为 $b(1-b)$。代入 (1) 得

$$
 8\lambda(\mu-\lambda)<3b\mu^2 .\tag{8}
$$

例如 $b=3/4,k=1,c=1/24$ 的全部三边为正。此时 $\lambda=13/12$、$\mu=4/3$、$g=(1,1,-1/3)$，四次系数为 $-11/288$。这给出一个三次矩消失、谱隙仍严格不是最优熵衰减极限的有理链。取 $t=1/10$ 的 $h=1+tf+t^2g$ 也能直接作区间核验。

## 5. 平衡极限与内部极小点的分界

**定理 3（局部分岔）**。设 $Q_\theta,\pi_\theta$ 是一族实解析的有限不可约可逆链，基点为 $\theta_0$，其最小正本征值简单。取局部实解析的慢模 $f_\theta$，归一 $\mathbb E_{\pi_\theta} f_\theta=0$、$\mathbb E_{\pi_\theta} f_\theta^2=1$，记 $m_3(\theta)=\mathbb E_{\pi_\theta} f_\theta^3$。假设在基点每个严格正的非平衡概率点都满足 $A/(2D)>\lambda$，$m_3(\theta_0)=0$，且式 (1) 的左侧在基点严格正。则在一个开邻域中有以下两种情况。

- $m_3(\theta)=0$ 时 $\rho(\theta)=\lambda(\theta)$，仅在平衡极限逼近。
- $m_3(\theta)\ne0$ 时 $\rho(\theta)<\lambda(\theta)$，并由唯一的正非平衡概率分布达到。

以 $t=\langle h-1,f_\theta\rangle_{\pi_\theta}$ 表示慢模幅度，有正实解析函数 $\kappa(\theta)$，其基点值为式 (1) 的左侧，使最优幅度及谱隙差满足

$$
 t_* =\frac{\lambda(\theta)m_3(\theta)}{12\kappa(\theta)}+O(m_3(\theta)^2),\qquad
 \lambda(\theta)-\rho(\theta)
 =\frac{\lambda(\theta)^2m_3(\theta)^2}{144\kappa(\theta)}+O(|m_3(\theta)|^3).\tag{9}
$$

误差界在缩小的参数邻域内统一。慢模改号时幅度同样改号，谱隙差不变。

**证明。** 简单本征值的谱投影、归一化的一个符号选择及其快子空间均可作局部实解析选取。写 $h=1+t(f_\theta+z)$，其中 $z$ 在快子空间。把比值的分子与分母同时除以 $t^2$ 后，得到局部实解析函数 $G(t,z,\theta)$，其 $t=0$ 的值为 $f_\theta+z$ 的 Rayleigh 商。对 $z=0$ 的 Hessian 在快子空间为 $2(L_\theta-\lambda(\theta) I)$。故 $\nabla_zG=0$ 在邻域内唯一给出 $z=Z(t,\theta)$，且 $Z(0,\theta)=0$。由局部 Hessian 正定，它也逐 $t$ 最小化同一小邻域内的 $z$。令 $r(t,\theta)=G(t,Z(t,\theta),\theta)$。由 (6)，

$$
 r(0,\theta)=\lambda(\theta),\qquad
 r_t(0,\theta)=-\lambda(\theta)m_3(\theta)/6.
$$

在基点 $m_3=0$，最优 $Z(t,\theta_0)=t g+O(t^2)$ 一阶系数由 (7) 最小化确定。因为慢模归一且 $m_3=0$，除以 $2D=t^2+O(t^3)$ 后，$r$ 的二次系数等于 (7) 的最小值。令 $\kappa(\theta)=r_{tt}(0,\theta)/2$，它在小邻域内保持正。缩小幅度范围后 $r$ 严格凸，唯一解析临界点满足 $r_t(t_*,\theta)=0$。对等式作 Taylor 展开给出 $t_*=O(|m_3|)$ 及 (9)。当 $m_3=0$ 时其唯一局部极小幅度为零，否则为非零且小于 $r(0,\theta)$ 的值。

还需排除同一参数下远处极小。若有 $\theta$ 趋基点而 $A/(2D)\le\lambda(\theta)$ 的正初态，任何累积极限都不能在边界，因为基点的某条正权边连接极限正坐标和零坐标，该边权在附近仍有正下界。极限也不能是非平衡内点，因为基点在每个这样的点都严格大于谱隙。于是初态必须趋向平衡。写 $h-1$ 的单位方向，其比值与该方向的 Rayleigh 商之差随着幅度归零而一致趋零。简单慢本征值与其余本征值有正间隔，故这些方向必须趋于 $\pm f_\theta$。因此所有可能达到或优于谱隙的非平衡点都被上述小坐标图覆盖。若 $m_3=0$，图中所有非零 $t$ 的比值严格超过谱隙。若 $m_3\ne0$，定理 2 保证内部达到，而任何这样的极小点在该图内必须用唯一的 $Z(t,\theta)$ 和唯一的 $t_*$。 $\square$

## 6. 正三态链的具体分界实例

取两块的粗链，块的平衡权重记为 $u_i$，块内条件分布 $\sigma_i$。从块 $i$ 到块 $j$ 按固定速率 $q_{ij}$ 跨越，并把到达态独立重采样为 $\sigma_j$。设 $W=u_0q_{01}=u_1q_{10}$。块内另用一个对其条件律可逆的生成元。为正密度 $h$，写块均值 $m_i=\mathbb E_{\sigma_i}h$、条件熵 $H_i=\mathbb E_{\sigma_i}[h\log(h/m_i)]$、反向相对熵 $K_i=\mathbb E_{\sigma_i}\log(m_i/h)$。则全熵分为 $D=D_{\mathrm{coarse}}+\sum_i u_i H_i$。由跨块条件独立，跨块耗散除以 $W$ 后精确为

$$
 J(m_0,m_1)+H_0+H_1+m_1K_0+m_0K_1 .\tag{10}
$$

例如交叉项 $\mathbb E[h_0\log h_1]$ 等于 $m_0(\log m_1-K_1)$，将四项相减即得。于是 $\rho\ge\min\{\rho_{\mathrm{coarse}},\min_i(\rho_i+q_{ij}/2)\}$，其中 $\rho_i$ 是内部链常数，只在非单块上取最小；块常数密度又给 $\rho\le\rho_{\mathrm{coarse}}$。

取 $u_0=u_1=1/2$、两向粗速率 $\lambda/2$，将一块分成两个条件权重各 $1/2$ 的微态，两向内部速率均为 $3\lambda/2$，另一块保留为单态。两块平衡二态链取密度 $1\pm t$ 时，$A=\lambda t\operatorname{artanh}t$，且 $2D=2\int_0^t\operatorname{artanh}s\,\mathrm ds$。$\operatorname{artanh}$ 在 $t>0$ 严格凸且从零出发，该比值在 $0<|t|<1$ 上严格大于 $\lambda$，由 $t\to0$ 知其常数恰为 $\lambda$。内部二态的常数同理为 $3\lambda$。由 (10)，只要块均值不等或任一块内密度不恒定，$A>2\lambda D$。三态生成元的谱隙为简单粗模本征值 $\lambda$，块内波动的本征值为 $3\lambda+\lambda/2$。此基点的慢模取块值 $+1,-1$，故 $m_3=0$、$\Phi=0$、$\kappa=\lambda/6$。全三边速率均严格正，定理 3 可直接用于整个正可逆三态参数空间的邻域。

例如将第一块的平衡权重向 $p$ 扰动，改用粗速率 $q_{01}=\lambda(1-p)$、$q_{10}=\lambda p$，块内生成元与条件律保持原样。这条解析路径保持慢本征值 $\lambda$，并给

$$
 m_3(p)=\frac{1-2p}{\sqrt{p(1-p)}},\qquad
 \lambda-\rho(p)=\tfrac23\lambda(p-1/2)^2+O(|p-1/2|^3).\tag{11}
$$

因此在基点全参数空间内 $m_3=0$ 为光滑超曲面。超曲面上谱隙等号仅在平衡极限逼近，曲面两侧均严格低于谱隙，且唯一最坏初态由定理 3 定位。路径用于检验零集横截性，任意邻域参数并不需要保留块重采样结构。

## 7. 相关工作与复算

Taye v1 的式 (52)–(53)、(71)–(74)、(97)–(98) 给出原模型和局部搜索估计，§XIV 与附录 I 明示特定生成元的全局最小值未获认证。前稿用重心切平面、谱隙邻域及严格凸性关闭该例的数值区间和唯一性。定理 1 升级的是其每片只用一个重心的口径，证明连通稀疏链的概率单纯形边界也必最终通过。旧稿在非平衡极小点使用的普通隐函数定理以 $D>0$ 为前提。定理 3 先消去 $A/(2D)$ 在平衡点的零除零，再处理等号面上极小点消失及两侧分岔。 [Taye，arXiv:2610.40704v1](https://arxiv.org/pdf/2610.40704v1) · 旧三态证书

Faust–Fawzi §4.1 的式 (4.1)–(4.7) 与其后半正定程序，已经对同一个修正熵常数给出 Padé 界和单纯形加平方充分证。其连续时间归一化在本文记号中是 $2\rho$。该文通常对数 Sobolev 常数的收敛结果归属原作者。本文给的是对修正常数的直接凸性证书完备性，使用边界重心的坐标比较和对数发散。 Faust 博士论文 §2.4.1 也给出了这些修正常数的 Padé–SOS 证书。 [Faust–Fawzi，arXiv:2101.04988v2](https://arxiv.org/pdf/2101.04988v2) · [Faust 博士论文](https://www.repository.cam.ac.uk/items/d082e785-e169-4f38-8935-49f9fbb9065a)

Bobkov–Tetali Proposition 3.5 的平衡态展开已给修正熵常数不超过谱隙，Example 3.10 与 Proposition 4.3 涵盖平衡两态的等号。本文继续计算三阶反对称项和快模优化后的四阶项，并控制所有远处候选。Hermon–Salez Lemma 1 已通过投影/限制链分解给修正对数 Sobolev 下界，Chen Theorem 1.1 推广到模糊分块。专门的交叉重采样恒等式 (10) 保留非负项以证一个严格等号基点，分岔结论适用于其附近不保留分块的正生成元。通用熵分解、两态谱隙和二阶平衡态比较均不计作本轮所增。 [Bobkov–Tetali](https://www-users.cse.umn.edu/~bobko001/papers/2006_JTP_BT_Modified.pdf) · [Hermon–Salez](https://arxiv.org/pdf/1902.02775) · [Chen](https://arxiv.org/pdf/2410.17301)

Caputo–Chen–Gu–Polyanskiy 的《Entropy Contractions in Markov Chains》§§1、3.3 讨论离散时间收缩常数，以及借稀有态区分这些常数的三态例。本稿分岔比较同一连续时间修正常数与本生成元谱隙，并追踪最优初态。 [Caputo 等](https://people.lids.mit.edu/yp/homepage/data/2024_sdpi_mlsi.pdf)

在论文包的目录运行 `python3 -B evidence/code/verify.py` 可重放。程序用有理数和带精确尾界的对数级数验证两态、稠密三态和稀疏连通三态的重心认证，也验证 $-11/288$ 的四阶系数、一份有理试验分布严格优于谱隙，以及第 6 节分块路径在 $p=49/100,51/100$ 的严格间隔。有限复算辅助书面分析，高维完备性与局部分岔由上述证明给出。 [程序](evidence/code/verify.py) · [固定结果](evidence/results/verification.txt)。形式化任务另行列出。
