# p-spin Curie–Weiss 模型在驻拐点边界上的混合时间

*公开研究稿 · 正式刊本比对待完成*

2026 年 11 月 24 日

**公开研究稿 · 查新范围。** 本文给出边界混合时间的候选证明。已核对的 arXiv v2 预印本提出该问题并证明下界。Bernoulli 正式刊本（DOI 10.3150/26-BEJ1982）的全文及补充材料尚待比对，结论优先权未确定。第 8 节的谱隙与无截止推论仍待独立复核。稿件尚未经外部同行评议或 Lean 验证。

## 摘要

平均场 p-spin Curie–Weiss 模型的磁化强度在某些临界参数下经过一个漂移近似为零的区域，导致随机单点更新异常缓慢。本文给出固定参数、非退化驻拐点情形的混合时间上界 $O(N^{4/3})$，与已知下界匹配。证明先用精确生灭链命中时间公式处理磁化强度，再用耦合恢复自旋坐标信息。进一步求得两端进入平衡区间的平均命中时间常数。论证允许多个驻拐点，分别处理精确 Gibbs 热浴更新和预印本字面定义的全磁化更新。三次临界标度与通用积分已有先例，本文待核实的贡献是这一具体离散模型的严谨补全。

## 1. 模型与主要结论

有 $N$ 个取值为 $\pm1$ 的自旋。构型 $\sigma$ 的磁化强度为 $m(\sigma)=N^{-1}\sum_i\sigma_i$。固定整数 $p\ge3$、逆温度参数 $\beta>0$ 与外场 $h\in\mathbb R$，定义

$$f(m)=\beta m^p+hm,\qquad g(m)=f'(m),$$
$$I(m)=\frac{1+m}{2}\log(1+m)+\frac{1-m}{2}\log(1-m),\qquad H=f-I.$$

取 $0\log0=0$。Gibbs 分布 $\mu_N(\sigma)$ 正比于 $\exp[Nf(m(\sigma))]$。每一步均匀选择一个坐标，并按 Gibbs 条件分布重新采样；时间单位是一次单点更新，而非一次扫描全部 $N$ 个坐标。

**假设 B。** $H$ 在 $(-1,1)$ 内只有一个局部极大点 $m_*$，且 $H''(m_*)<0$。其余驻点构成非空有限集合 $\mathcal R$，每个 $r\in\mathcal R$ 满足 $H'(r)=H''(r)=0$ 和 $H'''(r)\ne0$。因 $H'$ 在左、右端点分别趋于正、负无穷，势函数在 $m_*$ 左侧严格递增、右侧严格递减，除孤立驻拐点外导数不为零。

设 $d_N(t)=\max_\sigma\|P_N^t(\sigma,\cdot)-\mu_N\|_{\mathrm{TV}}$，$t_{\mathrm{mix,N}}(\varepsilon)=\min\{t:d_N(t)\le\varepsilon\}$。

**定理 1（候选）。** 假设 B 下，对每个固定 $0<\varepsilon<1/2$，

$$t_{\mathrm{mix,N}}(\varepsilon)=\Theta(N^{4/3}).$$

常数可依赖固定模型参数及误差水平；不主张参数趋近尖点时仍一致。设 $K$ 为正自旋数，$a_N=\lfloor N(1+m_*)/2\rfloor$，$\tau_a$ 为首次到达计数 $a$ 的时间。

**定理 2（候选）。** 同样假设下，

$$\begin{aligned}N^{-4/3}\mathbb E_0\tau_{a_N}&\longrightarrow\sum_{r<m_*}C(r),\\N^{-4/3}\mathbb E_N\tau_{a_N}&\longrightarrow\sum_{r>m_*}C(r),\end{aligned}$$
$$C(r)=\frac{J}{1-r^2}\left(\frac{6}{|H'''(r)|}\right)^{2/3},\qquad J=\frac{\sqrt\pi\,2^{1/3}\Gamma(1/6)}{3\sqrt3}.$$

求和只遍历 $\mathcal R$，空和为零。这里的精确常数属于**平均命中时间**，不属于混合时间本身。

直观地说，驻拐点附近势函数的变化量正比于距离的三次方，因此 $N$ 倍势变化保持为常数量级的窗口宽度是 $N^{-1/3}$。单次更新磁化最多变化 $2/N$，穿越该窗口的扩散尺度为 $N^{4/3}$。以下证明不依赖这一启发式近似。

## 2. 精确计数链与命中时间

记 $m_k=2k/N-1$，$L(x)=(1+e^{-x})^{-1}$。由热浴条件概率，计数链向右、向左一步的概率为

$$b_k=(1-k/N)L\big(N[f(m_{k+1})-f(m_k)]\big),$$
$$d_k=(k/N)L\big(N[f(m_{k-1})-f(m_k)]\big).$$

在边界省去不可行的跃迁。计数链未归一化平衡权重为 $w_k=\binom Nk e^{Nf(m_k)}$，满足 $w_k b_k=w_{k+1}d_{k+1}$。令 $M=\|f'\|_\infty$ 和 $\eta=(1+e^{2M})^{-1}$，任一自旋取值的条件概率至少为 $\eta$。因此两条链的原地停留概率均有统一正下界；内部紧区间的 $b_k,d_k$ 也有统一正下界。

**命中恒等式。** 对 $i<a$，

$$\mathbb E_i\tau_a=\sum_{k=i}^{a-1}\frac{A_k}{b_k},\qquad A_k=\frac{\sum_{j\le k}w_j}{w_k}.$$

证明：设 $u_i=\mathbb E_i\tau_a$，由一步分析得 $b_i(u_i-u_{i+1})-d_i(u_{i-1}-u_i)=1$。乘以 $w_i$ 后从 0 到 $k$ 求和，利用详细平衡消去内部项，再对差分求和即可。对 $i>a$，反射得到 $\sum_{k=a+1}^i(\sum_{j\ge k}w_j)/(d_kw_k)$。这也说明固定目标的最坏平均命中时间出现在某个端点。

## 3. 上界的核心：控制临界瓶颈

以下只讨论平衡点左侧，右侧反射处理。对于内点紧区间，Stirling 公式给出

$$w_k\asymp N^{-1/2}\exp\{N(\log2+H(m_k))\}.$$

普通区域中 $H'$ 有正下界，因而邻近项权重比按几何级数衰减；较远点具有固定势差，其总贡献指数小。端点附近不用 Stirling：直接由 $w_{j-1}/w_j\le [j/(N-j+1)]e^{2M}$ 选取足够小的端点区间，使比值小于某个固定 $q<1$。两类区域 $A_k=O(1)$，对命中时间共贡献 $O(N)$（左侧 $b_k$ 有正下界）。

### 3.1 驻拐点

固定 $r<m_*$。由假设 B 及单调性，$H'''(r)>0$，故在某个固定邻域 $H'(r+v)\ge c v^2$。对邻域内的 $y=m_k$ 与 $x=y-u\le y$，写 $z=y-r$，得到

$$H(y)-H(y-u)\ge c\left(uz^2-u^2z+\frac{u^3}{3}\right)\ge c\left(\frac{uz^2}{8}+\frac{u^3}{24}\right).$$

第二个不等式来自配方：差除以 $u$ 为 $\frac78(z-4u/7)^2+u^2/168$。把外点 $y$ 限在较小邻域，内点若在较大邻域之外，有固定正势差，贡献指数小。其余内点的格距为 $2/N$，故

$$A_k\le C+C\sum_{\ell\ge0}\exp\{-cN[(2\ell/N)z^2+(2\ell/N)^3]\}.$$

单调积分比较分别给出 $O(N^{2/3})$ 和 $O(1+z^{-2})$；合并（在固定邻域内调整常数）即

$$A_k\le\frac{CN^{2/3}}{1+N^{2/3}(m_k-r)^2}.$$

这条估计同时控制窗口中心及其两侧。由于 $b_k$ 有正下界，且变换 $v=N^{1/3}(m_k-r)$ 后格距是 $2N^{-2/3}$，求和得

$$\sum_{|m_k-r|<\delta}\frac{A_k}{b_k}\le CN^{2/3}\sum_k(1+v_k^2)^{-1}=O(N^{4/3}).$$

### 3.2 稳定极大点

在 $m_*$ 左侧，令 $z=m_*-y\ge0$。负二阶导数使 $H(y)-H(y-u)\ge c(uz+u^2)$。同样积分比较给出

$$A_k\le\frac{C\sqrt N}{1+\sqrt N(m_*-m_k)},$$

在固定邻域求和为 $O(N\log N)$。取各驻拐点及极大点的互不相交小邻域，加上普通区域和端点区域，即覆盖全部区间。不同邻域之间相隔固定正势差，不产生额外临界贡献。于是

$$\max(\mathbb E_0\tau_{a_N},\mathbb E_N\tau_{a_N})=O(N^{4/3}).$$

### 3.3 从平衡位置扩展到中央区间

这里只到达一个取整的平衡位置，尚不能直接推出混合。由唯一非退化极大点处的离散 Laplace 估计，$Z_N=\sum_j w_j$，且对 $|k-a_N|\le A\sqrt N$，有 $Z_N/w_k=O_A(\sqrt N)$。具体而言，极大点邻域权重被高斯函数控制，区外有固定势差；中央位置权重下界为 $c_A N^{-1/2}e^{N(\log2+H(m_*))}$。目标在中央区间移动，命中公式多出的项不超过 $O_A(\sqrt N)$ 项，每项 $O_A(\sqrt N)$，因而只增加 $O_A(N)$。这一步对任意初态成立。

## 4. 从计数链到完整自旋链

令 $\pi_N(k)=w_k/Z_N$。由上述高斯集中，给定 $0<\alpha<1/2$，可取固定足够大的 $A$，使中央区间 $J_N=\{|k-a_N|\le A\sqrt N\}$ 的概率大于 $1-\alpha$。故任一平衡概率至少为 $\alpha$ 的集合 $S$ 必与 $J_N$ 相交。取其中一点 $b$，则 $\tau_S\le\tau_b$。第 3 节得

$$\max_{i,S:\pi_N(S)\ge\alpha}\mathbb E_i\tau_S=O(N^{4/3}).$$

由 Peres–Sousi 的大集合命中时间定理 [4]（Theorem 1.1、1.4、Proposition 2.11），可逆且原地停留概率统一有正下界的链，其普通总变差混合时间与上述量可比较。计数链因此在 $O(N^{4/3})$ 时间内混合。改变固定误差只需使用标准次乘性不等式 $d(t+s)\le2d(t)d(s)$。

然而计数相同不代表构型相同。为恢复位置标签，考虑同计数的两个构型 $x,y$。令 $U=\{i:x_i=+1,y_i=-1\}$、$V=\{i:x_i=-1,y_i=+1\}$，则 $|U|=|V|=D$。配对 $U,V$，以置换 $\phi$ 交换每一对，固定相同坐标。第一条链均匀选择 $i$，第二条选择 $\phi(i)$；两个旧自旋相同，条件更新概率相同，故使用同一随机数更新。

计数始终匹配。选中不匹配坐标且改变旧值时，一整对差异消失；其概率至少为 $2\eta D/N$。因此

$$\mathbb E[D_{t+1}\mid x_t,y_t]\le(1-2\eta/N)D_t,\qquad\Pr(T_{\mathrm{labels}}>s)\le(N/2)e^{-2\eta s/N}.$$

在确定时刻先将真实计数与平衡计数最大耦合，再给第二条链在其计数层内均匀分配构型，得到完整平衡分布。计数匹配时应用上述耦合，不匹配时任意合法耦合。于是

$$d_N(t+s)\le d_N^{K}(t)+(N/2)e^{-2\eta s/N}.$$

取 $t=O_\varepsilon(N^{4/3})$、$s=O_\varepsilon(N\log N)$，即得完整链上界。该方法不需要全局单调性，对奇数 $p$ 同样适用。

## 5. 下界：为何不能更快混合

原预印本附录 D 已证明这一量级的下界 [1]。这里给出另一条可独立核查的短论证。精确热浴的磁化漂移为

$$\mathbb E[m_{t+1}-m_t\mid m_t=m]=\frac{B(m)}{N}+O(N^{-2}),\quad B(m)=\tanh g(m)-m.$$

在驻拐点 $r$，由 $H'(r)=H''(r)=0$ 得 $B(r)=B'(r)=0$，故 $B(m)=O((m-r)^2)$。初态选在距 $r$ 最近的格点；记 $\tau$ 为离开 $|m-r|\le L N^{-1/3}$ 的首次时刻，$L>0$ 固定。停止链可分为累积条件漂移与鞅；窗口内漂移每步 $O_L(N^{-5/3})$，条件二阶矩至多 $4/N^2$。取 $T=\lfloor cN^{4/3}\rfloor$，累积漂移绝对值至多 $C_L cN^{-1/3}$，而停止鞅二阶矩至多 $4cN^{-2/3}$。先取 $c$ 足够小使漂移不足窗口半宽，再由 Doob 最大不等式得到离窗概率 $O(c/L^2)$，可令其小于 $1/4$。平衡分布在该窗口中的质量因 $H(r)<H(m_*)$ 趋于零。于是 $d_N(T)>1/2$（充分大 $N$），得任意固定 $\varepsilon<1/2$ 的 $\Omega(N^{4/3})$ 下界，完成定理 1。

## 6. 平均通过时间的精确常数

对一个左侧驻拐点，设 $c_r=H'''(r)/6>0$；命中双和中令 $u=N^{1/3}(m_j-r)$、$v=N^{1/3}(m_k-r)$、$j\le k$。在紧区间上，Stirling 与 Taylor 公式给出一致收敛

$$w_j/w_k\to e^{c_r(u^3-v^3)},\qquad b_k\to(1-r^2)/4.$$

两格点间距均为 $2N^{-2/3}$。两重 Riemann 和归一化中的 $1/4$ 正好抵消逆跃迁率的 4。不能直接在无界域上交换极限，故先固定 $|v|\le A,u\ge-B$（$B>A+1$）：外尾 $|v|>A$ 由第 3 节的估计在归一化后控制为 $C/A+o(1)$；内尾 $|v|\le A,u<-B$ 由三次不等式控制为 $CA\int_{B-A-1}^\infty e^{-ct^3}\,dt+o(1)$。固定邻域以外的内点贡献指数小，普通与极大点区域是 $O(N\log N)=o(N^{4/3})$。按 $N\to\infty$、$B\to\infty$、$A\to\infty$ 的顺序即可得到该点的贡献

$$\frac1{1-r^2}\int_{\mathbb R}\int_{-\infty}^v e^{c_r(u^3-v^3)}\,du\,dv=\frac{c_r^{-2/3}}{1-r^2}J.$$

令 $w=v-u\ge0,z=(u+v)/2$，Jacobian 的绝对值为 1，且 $v^3-u^3=3wz^2+w^3/4$，所以

$$J=\sqrt{\pi/3}\int_0^\infty w^{-1/2}e^{-w^3/4}\,dw=\frac{\sqrt\pi\,2^{1/3}\Gamma(1/6)}{3\sqrt3}.$$

多驻拐点分别贡献独立的积分，右侧反射给 $|H'''|$。中央目标调整只有 $O_A(N)$，不改变首项。这证明定理 2。

**归属说明。** 由 Gamma 函数恒等式，$J=4\pi^2/(9\Gamma(2/3)^2)$，亦等于 $\pi^2 3^{-2/3}[\operatorname{Ai}(0)^2+\operatorname{Bi}(0)^2]$。Hathcock–Sethna [3] 的鞍结扩散通过时间已含相同通用积分（经单位缩放）。待查新的是精确离散链的模型系数和全局收敛论证，而非该通用常数。

## 7. 两种有限规模更新规则不能混同

原预印本 [1] 的字面更新概率为 $a(m)=L(2g(m))$，若 $m$ 含旧自旋，它与精确 Gibbs 热浴不同。此链的计数率为 $\widetilde b_k=(1-k/N)a(m_k)$、$\widetilde d_k=(k/N)(1-a(m_k))$。直接求比值可得它的精确不变权重

$$\widetilde w_k=w_k W_N(m_k),\qquad W_N(m_k)=\cosh g(m_k)e^{R_N(m_k)},$$
$$R_N(m_0)=0,\qquad R_N(m_{k+1})-R_N(m_k)=g(m_k)+g(m_{k+1})-N[f(m_{k+1})-f(m_k)].$$

这是因为 $\widetilde b_k/\widetilde d_{k+1}=\frac{N-k}{k+1}e^{g(m_k)+g(m_{k+1})}\cosh g(m_{k+1})/\cosh g(m_k)$。完整链的不变分布 $\nu_N$ 在各计数层内均匀；由上述比值也得完整链的详细平衡。梯形积分余项给出 $\sup|R_N|\le 2\|g''\|_\infty/(3N)$，故 $W_N$ 有统一正上下界和统一格点 Lipschitz 界。

相应权重可比，内部跃迁率下界仍成立，第 3–4 节上界保留；该链漂移恰为 $B(m)/N$，下界也保留；临界缩放紧集上 $W_N(m_j)/W_N(m_k)\to1$，故平均通过时间首项不变。又因 $\mathbb E_{\mu_N}|m-m_*|=O(N^{-1/2})$，

$$\|\nu_N-\mu_N\|_{\mathrm{TV}}=\tfrac12\mathbb E_{\mu_N}|W_N/\mathbb E_{\mu_N}W_N-1|=O(N^{-1/2}).$$

因此以原 Gibbs 法则为比较目标的固定误差首次达标时间仍为同阶（该目标不是此链严格不变分布，不假定距离单调）。本节仅解释可访问预印本的字面规则，未对未读正式刊本作错误判断。

## 8. 候选推论：谱隙与无 cutoff

以下不需要进一步发明混合时间估计，而是使用第 4 节和局部变分法。令 $\rho_N$ 为任一完整链的实际不变分布，取任一驻拐点 $r$，构造

$$F_N(\sigma)=\max(0,1-N^{1/3}|m(\sigma)-r|).$$

记 $A_N=\{|m-r|\le N^{-1/3}+2/N\}$、$B_N=\{|m-r|\le N^{-1/3}/2\}$。三次 Taylor 展开和 Stirling 公式表明 $A_N$ 中各计数权重相差至多固定倍数；两区间都有 $\Theta(N^{2/3})$ 个格点，故 $\rho_N(B_N)\ge c\rho_N(A_N)$。又 $\rho_N(A_N)\to0$。从而

$$\operatorname{Var}_{\rho_N}(F_N)\ge\tfrac14\rho_N(B_N)-\rho_N(A_N)^2\ge c'\rho_N(A_N).$$

每步函数至多改变 $2N^{-2/3}$，且非零改变只能从 $A_N$ 出发。于是 Dirichlet 型满足 $\mathcal E(F_N,F_N)\le 2N^{-4/3}\rho_N(A_N)$。Rayleigh 变分原理给出谱隙 $\gamma_N=1-\lambda_2\le CN^{-4/3}$。同一测试函数也适用于计数链。充分大 $N$ 时 $\lambda_2>0$；将中心化的第二特征函数按最大绝对值归一化，得 $d_N(t)\ge\lambda_2^t/2$。结合 $t_{\mathrm{mix,N}}(1/4)=O(N^{4/3})$ 得 $\gamma_N\ge cN^{-4/3}$，故

$$\gamma_N=\Theta(N^{-4/3}).$$

对任意固定 $L>0$，特征函数下界还给出 $\liminf_N d_N(\lfloor LN^{4/3}\rfloor)>0$。由于 $t_{\mathrm{mix,N}}(1/4)=\Theta(N^{4/3})$，若出现 cutoff，则在其任意固定大于 1 的倍数时距离应趋零，与上式矛盾。因此无总变差 cutoff。该现象在 Potts 模型 [2] 已知；本节只是针对本文模型的候选推论，且不推出精确混合轮廓。

## 9. 适用边界及复现说明

计算 $H''(r)=0$ 可得 $r\ne0$，并有

$$H'''(r)=\frac{(p-2)-pr^2}{r(1-r^2)^2}.$$

三次项退化仅可能发生于 $r^2=(p-2)/p$，对应 $\widehat\beta_p=[p/(p-2)]^{(p-2)/2}/[2(p-1)]$。这些退化尖点不在假设 B 内。偶数 $p$ 可出现两个驻拐点；奇数 $p$ 的全局吸引性不能直接假设。本文不处理随 $N$ 逼近边界的参数窗口或尖点的统一极限。

复现代码计算三组参数、六个系统规模下的精确生灭链命中时间，并在小规模用独立线性方程核对。最大规模 $N=262144$ 的归一化两端到平稳中位数的最大平均命中时间如下（中位数在中央区间内）：

| 参数情形 | 精确热浴 | 字面更新 | 理论极限 |
|---|---:|---:|---:|
| $p=3,r=0.8$ | 5.17242 | 5.25253 | 5.11926 |
| $p=3,r=0.4$ | 6.52308 | 6.48820 | 6.25704 |
| $p=4$，对称双拐点 | 3.97126 | 4.04985 | 3.91649 |

复现程序以浮点数计算平均命中公式，并在小规模与反向方程交叉核对。混合时间结论依赖前面的解析论证。

**编辑说明。** 稿件准备过程中使用了生成式 AI 辅助。

## 参考文献

[1] R. J. Samanta, S. Mukherjee, J. Zhang. *Mixing Phases and Metastability for the Glauber Dynamics on the p-Spin Curie–Weiss Model*. [arXiv:2412.16952v2](https://arxiv.org/html/2412.16952v2), 2025-02-20. Bernoulli 32(4), 3143–3167 (2026), [DOI:10.3150/26-BEJ1982](https://doi.org/10.3150/26-BEJ1982)（正式全文待查）。

[2] P. Cuff, J. Ding, O. Louidor, E. Lubetzky, Y. Peres, A. Sly. *Glauber Dynamics for the Mean-Field Potts Model*. J. Stat. Phys. 149, 432–477 (2012). [arXiv:1204.4503](https://arxiv.org/abs/1204.4503), Theorem 2(2).

[3] D. Hathcock, J. P. Sethna. *Reaction rates and the noisy saddle-node bifurcation: Renormalization group for barrier crossing*. Phys. Rev. Research 3, 013156 (2021). [DOI](https://doi.org/10.1103/PhysRevResearch.3.013156), §III A.

[4] Y. Peres, P. Sousi. *Mixing times are hitting times of large sets*. J. Theor. Probab. 28, 488–519 (2015). [arXiv:1108.0133v3](https://arxiv.org/html/1108.0133v3).

[5] T. Mori, S. Miyashita, P. A. Rikvold. Phys. Rev. E 81, 011135 (2010). [arXiv:0905.0089](https://arxiv.org/abs/0905.0089).

[6] G.-Y. Chen, L. Saloff-Coste. *On the mixing time and spectral gap for birth and death chains*. [arXiv:1304.4346](https://arxiv.org/abs/1304.4346) (2013).

[7] J. Ding, E. Lubetzky, Y. Peres. *Total variation cutoff in birth-and-death chains*. [arXiv:0801.2625](https://arxiv.org/abs/0801.2625).
