# 反射扩散的周期与 Markov 切换频率分类

## 摘要

在有界光滑区域内，给出反射扩散的无通量边界版本的频率分类。空间可逆性等价于所有周期势下增长率随环境频率不增，也等价于所有平稳有限状态 Markov 势下几乎处处增长率不增。任一不可逆反射生成元都存在任意弱的周期势和有限状态循环 Markov 势，使增长率在某个有限正频率达到全局最大，且严格高于快慢两端。周期情形还可以由固定频率下的时间反演对称性刻画。随机反例的慢端系数来自相邻 Perron 投影的重叠。快速端使用对平均为零的势作空间光滑的随机时间原函数。

## 1. 模型与结论

令 $\Omega\subset\mathbb R^d$ 为有界连通光滑区域，$a$ 为光滑对称一致正定的扩散矩阵，$b$ 为光滑向量场。考虑
$
 Lf=\operatorname{div}(a\nabla f)+b\cdot\nabla f,
 \qquad \nu\cdot a\nabla f=0\text{ 于 }\partial\Omega.
$
假定反射扩散有光滑严格正的不变概率密度 $\rho$。它满足 $\operatorname{div}(a\nabla\rho-\rho b)=0$ 及 $\nu\cdot(a\nabla\rho-\rho b)=0$。写 $\pi=\rho\,dx$ 和
$
 c=b-a\nabla\log\rho,qquad
 L_0=\rho^{-1}\operatorname{div}(\rho a\nabla).
$
给定周期势 $r(x,\theta)$，用 $\lambda_r(\omega)$ 表示 $\partial_t u=Lu+r(x,\omega t)u$ 的主 Floquet 增长率，$\theta$ 周期为 $2\pi$。给定平稳不可约有限状态连续时间链 $\sigma$ 和光滑势族 $r_k$，用 $\Lambda(\omega)$ 表示 $\partial_t u=Lu+r_{\sigma(\omega t)}u$ 的几乎处处主增长率。

**定理。** 以下说法等价：

1. 详细平衡成立，即 $c=0$。
2. 对所有光滑实周期势，$\lambda_r(\omega)$ 随 $\omega>0$ 不增。
3. 对所有平稳有限状态不可约 Markov 势，$\Lambda(\omega)$ 随 $\omega>0$ 不增。
4. 对某个固定 $\omega_*>0$，每个光滑实周期势及其时间反演有相同的 $\lambda_r(\omega_*)$。

在详细平衡下，周期增长率严格下降，除非 $r(x,\theta)=r_0(x)+g(\theta)$，此时恒定。若 $c\ne0$，存在光滑的实周期势族和有限状态循环 Markov 势族，两族均可取为任意小的非零幅度。对于两族的每个足够小幅度，增长率都在一个有限正频率取到高于两个端点极限的全局最大值。反例的空间势均可用在边界邻域为常值的光滑函数。

Evidence Press 2026 的 §8 在闭流形建立周期分类，其附录 B 建立可逆闭流形的随机单调性。该文 §10 的第 2、3 项提出随机不可逆扩散及有界区域的后续问题 [1]。

## 2. 无通量算子与周期分类

$\operatorname{div}(\rho c)=0$ 且 $\nu\cdot\rho c=0$，因此在 $L^2(\pi)$ 中，$c\cdot\nabla$ 反对称，$L$ 的伴随是 $L_0-c\cdot\nabla$，具有相同齐次余法向条件。对光滑测试函数分部积分，边界项分别含 $\nu\cdot a\nabla f$ 和 $\nu\cdot\rho c$，故均为零。为便于引用，在 $L^2(\pi)$ 上取标准 $H^2$ 余法向实现。零平均空间 $\mathcal H$ 上的算子 $A=-L$ 和 $A^*$ 满足
$
 \operatorname{Re}\langle f,Af\rangle_\pi
 =\int_\Omega \nabla\bar f\cdot a\nabla f\,d\pi
 \ge \gamma\|f\|_\pi^2.
$
这里用到加权 Poincaré 不等式。强制性形式、余法向正规性与紧 Sobolev 嵌入给出紧单射 $C=A^{-1}$。若 $Cf=\xi f$ 且 $\xi\ne0$，则 $\operatorname{Re}\xi>0$。由此 $C^2$ 自伴便足以推出 $C$ 自伴。因为 $C^2$ 紧自伴、单射且其非零特征值为正，各特征空间给出正交完备分解。在每个有限维特征空间内 $C^2=\lambda I$，谱只能为 $+\sqrt\lambda$，且该多项式有单根，因此 $C=\sqrt\lambda I$。最后 $C$ 自伴等价于 $L$ 自伴，反对称一阶项因此为零。

对有界光滑 $z\in\mathcal H$，取 $r=\epsilon\operatorname{Re}(ze^{i\theta})$。正时间反射抛物传播子是紧且强正的，主特征值简单。由有界乘法扰动的 Duhamel 级数，对每个固定 $\omega>0$，主 Floquet 指数与适当归一化的周期模式在 $\epsilon=0$ 解析。将模式写为 $1+\epsilon u_1+O(\epsilon^2)$。将方程在 $\pi\otimes d\theta/(2\pi)$ 下积分，一阶指数为零，且
$u_1=\operatorname{Re}((A+i\omega)^{-1}z e^{i\theta})$，加常数项不影响二阶。再积分二阶方程得
$
 \lambda_r(\omega)=\epsilon^2\beta_z(\omega)+O_\omega(\epsilon^3),\qquad
 \beta_z(\omega)=\tfrac12\operatorname{Re}\langle z,(A+i\omega)^{-1}z\rangle_\pi.
$
特别地 $\beta'_z(0)=\tfrac12\operatorname{Im}\langle z,C^2z\rangle_\pi$。测试类可取复值的光滑紧支撑函数减去其平均，稠密于 $\mathcal H$，每个元素在边界附近常值。若第 2 项成立，则比较任何两个固定频率并除以 $\epsilon^2$，$\beta_z$ 与 $\beta_{\bar z}$ 都不增。其零端斜率相反，故同时为零。稠密性与极化给出 $C^2$ 自伴。

若第 4 项成立，则在 $\omega_*$ 有 $\beta_z=\beta_{\bar z}$。谱预解式 恒等式给出
$
 \beta_z(\omega_*)-\beta_{\bar z}(\omega_*)
 =\omega_*\operatorname{Im}\langle z,Fz\rangle_\pi,qquad
 F=C^2(I+\omega_*^2 C^2)^{-1}.
$
$A\pm i\omega_*$ 可逆，所以上式的有界函数演算合法。极化推出 $F$ 自伴，$C^2=F(I-\omega_*^2F)^{-1}$ 也自伴。反过来，当 $L$ 自伴时，反转伴随 Floquet 模式的时间即得第 4 项。

证明第 1 项推出第 2 项，取主右与伴随周期模式 $u,v>0$，归一使 $\int uv\,d\pi=1$。令 $w=\sqrt{uv}$、$\eta=\frac12\log(u/v)$。用周期方程得
$
 \omega ww_\theta=\rho^{-1}\operatorname{div}(\rho w^2a\nabla\eta),\qquad
 \lambda'_r(\omega)=-\frac1{2\pi}\int_0^{2\pi}\!\int w^2\eta_\theta\,d\pi\,d\theta.
$
将第二式先按时间分部积分，再用第一式按空间分部积分。由于 $u,v$ 均满足余法向条件，故 $\nu\cdot a\nabla\eta=0$，得到
$
 \lambda'_r(\omega)=-\frac{2}{\omega}\frac1{2\pi}\int_0^{2\pi}\!\int
 w^2\nabla\eta\cdot a\nabla\eta\,d\pi\,d\theta\le0.
$
若取等，连通性给出 $\eta$ 只依赖相位，随后 $w_\theta=0$。代回模式方程即得 $r=\lambda_r-Lw/w+\omega\eta'$, 为所述可分离形式。反向取常值增长率可由标量相位因子直接验证。

## 3. 周期反例及两个端点

若 $c\ne0$，则 $C^2$ 非自伴。上面稠密边界测试类中存在使 $\operatorname{Im}\langle z,C^2z\rangle_\pi>0$ 的元素，必要时取共轭。取固定小 $\Omega_0>0$ 使 $\beta_z(\Omega_0)>\beta_z(0)$。由强制性与单射，$\beta_z(0)>0$。

设 $\ell(\theta)$ 是 $L+r(\cdot,\theta)$ 的瞬时主特征值，$h(\cdot,\theta)>0$ 为光滑归一的主特征函数。均匀分离的简单特征值和固定余法向定义域保证可选取该光滑周期归一。对正周期测试函数 $U$，若 $\nu\cdot a\nabla U=0$，则用伴随模式积分得到 $\lambda_r$ 位于
$[(L+r)U-\omega U_\theta]/U$ 的最小与最大值之间。慢端取 $U=h\exp(g/\omega)$、$g'=\ell-\langle\ell\rangle_\theta$，得
$|\lambda_r(\omega)-\langle\ell\rangle_\theta|\le\omega\|h_\theta/h\|_\infty$。瞬时特征值扰动与相位平均给出
$\langle\ell\rangle_\theta=\epsilon^2\beta_z(0)+O(\epsilon^3)$。

快端取 $U=\exp(F/\omega)$，其中 $F_\theta=r$ 是周期原函数。因所选 $z$ 在边界附近常值，$U$ 满足所需条件，余量为 $LF/\omega+(\nabla F\cdot a\nabla F)/\omega^2\to0$。所以周期快端是零。对所有足够小非零 $\epsilon$，固定频率 $\Omega_0$ 的值严格高于两端。正频率连续性和两端极限给出所述最大值。

## 4. Markov 切换分类

**增长率与可逆方向。** 用环境时间和算子范数定义随机主增长率。对每个固定频率，单位时间转移有严格正且上下有界的核。这来自正时间反射热核在闭区域上的连续性及势的有界比较。热核以 $\pi$ 为参考测度时，每列积分为一。对正时间开始再沿空间前向演化，强最大值原理给出内部正性；若在边界取零，Hopf 边界引理给出非零外法向导数，与齐次余法向条件冲突。因而在紧的正时间区间，核有统一正下界和有限上界。离散时间次可加遍历定理以及额外有限时段上的比较界给出几乎处处确定的连续时间增长率，有限状态平稳不可约链的定长移位遍历。对正初态，比较常量初态即可得到同一指数。最终一个环境时间单位的核上下界使 $\max U(T,0)1$ 与 $\min U(T,0)1$ 有统一比值，故
$
0\le\log\|U_\omega(T,0)\|_{C\to C}-\log\operatorname{spr}(U_\omega(T,0))\le C
$
对 $T\ge1$ 成立。将每个样本前缀周期化，第 2 节的不增性也适用于它。可先在时间方向作周期平滑，Duhamel 估计给出传播子范数收敛，强正紧算子的简单主根连续。让 $T\to\infty$，得到可逆情形的第 3 项。

**循环环境的慢端。** 对上一节选定的 $z$，取足够大的整数 $N\ge3$，$\theta=2\pi/N$，令 $r_k=\operatorname{Re}(z e^{ik\theta})$，$k\bmod N$。以速率 $1$ 的单向循环为基准环境，使用势 $\epsilon r_k$ 与物理速率 $\omega$。记 $A_k=L+\epsilon r_k$ 的主量为 $\ell_k,h_k,v_k$，约定 $\int h_k\,d\pi=1$、$\langle v_k,h_k\rangle_\pi=1$。所有主函数均光滑且严格正。扰动展开得到
$
 h_k=1+\epsilon C r_k+O(\epsilon^2),\qquad
 v_k=1+\epsilon C^*r_k+O(\epsilon^2).
$
归一化并减去 $\langle v_{k+1},h_{k+1}\rangle_\pi=1$，得到
$
 \log\langle v_{k+1},h_k\rangle_\pi
 =\epsilon^2\langle r_{k+1},C^2(r_k-r_{k+1})\rangle_\pi+O(\epsilon^3).
$
一阶项在差值中消失，二阶差值中与常量 $1$ 的配对也因主函数的积分归一为零。沿循环求和利用离散相位正交，得
$
 J=\sum_{k}\log\langle v_{k+1},h_k\rangle_\pi
 =\tfrac N2\epsilon^2\operatorname{Re}\big[(e^{-i\theta}-1)\langle z,C^2z\rangle_\pi\big]+O(\epsilon^3).
$
因为 $\operatorname{Im}\langle z,C^2z\rangle_\pi>0$，大 $N$ 时方括号实部为正，固定该 $N$ 后，小非零 $\epsilon$ 使 $J>0$。

固定这些势。对状态 $k$ 的一次长度为 $\tau$ 的访问，入态用 $\langle v_k,\cdot\rangle_\pi$ 归一为 $f$。出态去掉 $e^{\ell_k\tau}$ 后为 $w=e^{\tau(A_k-\ell_k)}f$，满足 $\langle v_k,w\rangle_\pi=1$。下次归一化的增益是 $\langle v_{k+1},w\rangle_\pi$。有一致界
$
 \big|\log\langle v_{k+1},w\rangle_\pi-
 \log\langle v_{k+1},h_k\rangle_\pi\big|\le C_0 e^{-\delta\tau}.
$
其理由是主根从其余谱严格分离，归一半群在 $C(\bar\Omega)$ 上指数收敛到主投影。先演化一个单位，热核有界使所有 $v_k$ 归一化的非负输入的输出统一有界，再用长时谱估计。短于一个单位时，利用 $v_{k+1}/v_k$ 的统一正上下界并增大 $C_0$。

对每次访问累加 $\ell_k\tau$ 和接口增益的对数，末端的 $v_k$ 归一与质量对数只差有界量。单位时间核界又保证质量与上确界范数的对数可互换。各持时独立且为 $\operatorname{Exp}(\omega)$，访问频率趋于 $\omega$，各相位所占比例趋于 $1/N$。按强大数律，已完成访问的持时之和与访问数成正比。指数尾界加 Borel–Cantelli 给出下一次持时除以访问数趋零，且有界势下常量比较控制未完成访问的对数增长，故访问时刻的界延及全部时间。接口余量除时间最多为 $C_0\omega\,\mathbb E e^{-\delta\tau}=O(\omega^2)$。因此
$
 \Lambda(\omega)=\tfrac1N\sum_k\ell_k+\tfrac\omega N J+O(\omega^2)
 \qquad(\omega\downarrow0).
$
这给出大于慢端的有限正频率，因而反驳不增性并证明第 3 项推出详细平衡。

**快端及最大值。** 在每个物理单位块内从零定义 $F(t,x)=\epsilon\int_0^t r_{\sigma(\omega s)}(x)\,ds$。循环环境均匀平稳且 $\sum_k r_k=0$。对同一环境路径，由占据时长的遍历定理，$\sup_{0\le t\le1}\|F(t)\|_{C^2}\to0$ 随 $\omega\to\infty$ 几乎处处成立。确切地说，中心化占据积分 $A_k(T)=o(T)$，故 $\sup_{u\le\omega}|A_k(u)|/\omega\to0$。$F$ 的空间余法向导数为零，指数测试函数 $e^F$ 的残差除以自身是 $LF+\nabla F\cdot a\nabla F$。取 $B$ 为该量在块中的绝对值上界，比较 $e^{F\pm Bt}$ 可得 $\|log(U_\omega(1,0)1)\|_\infty\le\|F\|_\infty+B$。各块应用正性与遍历定理，主指数绝对值不超过右侧的期望。该期望由有界收敛趋零，故快端为零。同时 $N^{-1}\sum\ell_k=\epsilon^2\beta_z(0)+O(\epsilon^3)>0$。

为验证正频率连续性，在任意紧速度区间固定单位环境时间的核比值界。记 $F_T(\omega,e)=\log\int U_\omega(T,0;e)1\,d\pi$。经过首段至少一个单位后，输出除以质量逐点夹在两个固定正数之间。按正性串接各 $T$ 长块，$F_{kT}$ 和相应各块的 $F_T$ 之和最多相差 $(k-1)C$。取期望和大时间极限后，
$|\Lambda(\omega)-\omega\mathbb EF_T/T|\le\omega C/T$，在紧速度区间上一致。固定 $T$ 的有限跳跃传播子随速度强连续，且 $|F_T|\le T\max\|\epsilon r_k\|_\infty/\omega$，故右侧的近似函数连续。由一致极限，$\Lambda$ 连续。连同两端严格比较得到所述有限频率全局最大值。

## 5. 一个边界证书与文献

单位圆盘取 $a=I$、$b=\kappa(-y,x)$、$\kappa>0$，均匀 $\pi$。旋转漂移切于边界，$z=(x+iy)(1-(x^2+y^2)/3)$ 余法向导数为零，且属于角向频数一。若 $\gamma_j>0$ 是该角向扇区的 Neumann 拉普拉斯谱，则
$\operatorname{Im}\langle z,C^2z\rangle_\pi$ 是各 $2\gamma_j\kappa/(\gamma_j^2+\kappa^2)^2$ 的非负谱权重和，至少一项严格正。这个例子用多项式微分及有限相位代数复核。完整定理使用算子论证明。

1. *Reversibility and frequency reduction in periodic and random positive systems*, Evidence Press / Zenodo, v0.1.0-candidate, §8、附录 B、§10 开放问题 2–3。[固定源码](https://github.com/ipitchford/reversibility-frequency-reduction/tree/v0.1.0-candidate)
2. S. Liu, Y. Lou, R. Peng and M. Zhou, *Monotonicity of the principal eigenvalue for a linear time-periodic parabolic operator*, Proc. AMS 147 (2019), 5291–5302。已有有界区域的周期单调性，覆盖常扩散及梯度漂移情形。[DOI](https://doi.org/10.1090/PROC/14653)
3. J. Mierczyński and W. Shen, *Time averaging for nonautonomous/random linear parabolic equations*, DCDS-B 9 (2008), 661–699。随机 Neumann 主指数与平均算子的比较。[DOI](https://doi.org/10.3934/dcdsb.2008.9.661)
4. P. Monmarché, S. J. Schreiber and É. Strickler, *Impacts of Tempo and Mode of Environmental Fluctuations on Population Growth*, Bull. Math. Biol. 87 (2025), 81。有限维慢切换重叠公式。[DOI](https://doi.org/10.1007/s11538-025-01443-z)
