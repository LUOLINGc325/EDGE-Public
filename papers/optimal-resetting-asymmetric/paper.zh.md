# 一维对数凹目标的精确布朗重置分布

2026 年 11 月 24 日

## 摘要

布朗搜索可在固定泊松率下重置到随机位置。若初始位置和每次重置位置服从同一分布，应怎样选择这个分布，才能最快找到位置未知的目标？Evans 与 Majumdar 给出了理想的平方根搜索密度，但由它反推出的重置分布可能带负质量。本文对全实线上的光滑严格对数凹目标给出所有 Borel 概率测度中的唯一最优解。两个标量尾积分决定最优支持是单点、有界区间、半直线还是全实线。非退化区间的每个有限端点都有正的原子质量。刚从单点变为区间时，相对当时最佳单点的收益以三次方出现，且系数由临界位置的目标密度和斜率决定。补充定理将精确分类推广到任意一维对数凹概率密度。

## 1. 从布朗搜索到优化问题

目标位置从概率密度 $q$ 抽取一次后保持固定。搜索者以扩散系数 $D>0$ 作布朗运动，以泊松率 $r>0$ 瞬时重置。初始位置和每次重置位置均独立抽自同一概率测度 $\mu$。固定 $D,r$，只优化 $\mu$。

令 $\alpha=\sqrt{r/D}$，$K_\alpha(x)=(\alpha/2)e^{-\alpha|x|}$，$p_\mu=K_\alpha*\mu$。从 $z$ 出发，布朗运动在下次重置前到达 $y$ 的概率为 $e^{-\alpha|z-y|}$，因为它在 $y$ 两侧满足 $Du''=ru$，在 $y$ 取值 1，并在无穷远衰减。对 $z\sim\mu$ 平均，单周期成功概率为 $2p_\mu(y)/\alpha$。将未命中目标的生存概率与指数时钟相乘后积分，可得单周期平均时长等于失败概率除以 $r$。失败后重新开始，故对目标位置平均的首达时间为
$$
T(\mu)=\frac1r\left(\frac\alpha2 F(\mu)-1\right),
\qquad F(\mu)=\int_{\mathbb R}\frac{q(x)}{p_\mu(x)}\,dx .
$$
文献 [1] 已导出这个目标以及无约束的平方根解。直观上，$q$ 大的地方需要更多搜索质量，而对小 $p_\mu$ 的惩罚是倒数。若可任取搜索密度，柯西–施瓦茨不等式得到 $p\propto\sqrt q$。实际的 $p$ 是指数核的正混合，衰减速率受核约束。最优解在内区保留平方根形状，在受约束的一侧接指数尾，拼接造成的一阶导数跳跃就是重置原子。

## 2. 光滑情形的最优分布

设 $q=e^{-V}/Z$，其中 $V$ 在 $\mathbb R$ 上二阶连续可导且严格凸，$Z=\int e^{-V}<\infty$。写 $h=\sqrt q$。两侧向外斜率 $s_-=-V'(-\infty)$ 和 $s_+=V'(+\infty)$ 均属 $(0,\infty]$。定义
$$
H_\pm(x)=\alpha\int_0^\infty e^{\alpha u}\frac{q(x\pm u)}{q(x)}\,du .
$$
若 $s_->2\alpha$，令 $L$ 为 $H_-(L)=1$ 的唯一根，否则置 $L=-\infty$。若 $s_+>2\alpha$，令 $R$ 为 $H_+(R)=1$ 的唯一根，否则置 $R=+\infty$。

**定理 1（最优律与最优值）。** 在所有 Borel 概率测度中，$F$ 的最优解唯一。

- 若 $L\ge R$，最优重置律为 $\delta_b$。位置 $b$ 由 $H_-(b)=H_+(b)=A$ 唯一确定，$A\le1$，且 $F(\delta_b)=4q(b)A/\alpha^2$。
- 若 $L<R$，令 $c^{-1}=\int_L^R h+\sum_{e\in\{L,R\}\cap\mathbb R}h(e)/\alpha$。$p_*=ch$ 在区间内成立。有限左端向外接 $ch(L)e^{-\alpha(L-x)}$，有限右端向外接 $ch(R)e^{-\alpha(x-R)}$。最优重置律在 $(L,R)$ 的密度为
$$
ch(x)\left(1+\frac{V''(x)}{2\alpha^2}-\frac{V'(x)^2}{4\alpha^2}\right).
$$
  有限端点的质量分别为
$$
\mu_*(\{L\})=\frac{ch(L)}{\alpha^2}\left(\alpha+\frac{V'(L)}2\right),
\qquad
\mu_*(\{R\})=\frac{ch(R)}{\alpha^2}\left(\alpha-\frac{V'(R)}2\right).
$$
  区间内密度及每个有限端点质量均为正，最优值为 $c^{-2}$。

纯平方根解 $p_*=h/\int h$ 可实现当且仅当 $s_-,s_+\le2\alpha$。若有一侧斜率不大于 $\alpha$，则所有单点重置的平均搜索时间都为无穷，分布式最优解依然具有有限代价。

## 3. 证明

### 3.1. 尾积分与最佳单点

以下写右侧，左侧由反射得到。严格凸性意味着每个 $u>0$ 的增量 $V(x+u)-V(x)$ 随 $x$ 严格递增。因此在 $\alpha<s_+$ 时，有限的 $H_+$ 连续且严格递减。当 $x\to-\infty$，在表达式
$$
H_+(x)=\frac{\alpha e^{-\alpha x}}{q(x)}\int_x^\infty e^{\alpha y}q(y)\,dy
$$
中将积分限制在固定有质量的区间，可知其发散到无穷。当 $x\to+\infty$，选取 $x_0$ 使 $V'(x_0)>\alpha$，用 $\alpha e^{-(V'(x_0)-\alpha)u}$ 控制积分函数，得到极限 $\alpha/(s_+-\alpha)$，其中 $s_+=\infty$ 时极限视为零。若 $\alpha\ge s_+<\infty$，倾斜后的密度 $e^{\alpha y}q(y)$ 在右侧单调不减，故右尾积分无穷。

因此右根存在当且仅当 $s_+>2\alpha$。有限右根还满足 $V'(R)<2\alpha$。否则严格凸性会使 $q(R+u)/q(R)<e^{-2\alpha u}$ 对所有 $u>0$ 成立，与 $H_+(R)=1$ 矛盾。左根同理满足 $V'(L)>-2\alpha$。结合无有限根时的斜率条件，得 $L<x<R$ 时 $|V'(x)|<2\alpha$。

若两个倾斜尾积分都有限，对 $\int q(y)e^{\alpha|y-z|}dy$ 求导得到 $q(z)(H_-(z)-H_+(z))$。左右比率的单调性及端点极限保证导数唯一过零，故平衡点 $b$ 是最佳单点。两根均有限时，$A\le1$ 等价于 $L\ge R$。

### 3.2. 非负性与全局比较

拉普拉斯核是算子 $1-\alpha^{-2}\partial_x^2$ 的 Green 函数。将这个算子作用于候选 $p_*$，利用 $h''/h=V'^2/4-V''/2$，得到定理中的连续密度和端点质量。后者来自 $p_*'$ 的跳跃，外部指数尾的贡献为零。由内区斜率界及凸性，得到非负性。$h$ 在两侧至多呈指数衰减，因而有界可积。内区又有 $\int_L^R V''\le4\alpha$，故候选的分布二阶导数是有限有符号测度。$p_*'$ 在无穷远趋于零，所以这个二阶导数的总质量为零，反演得到的 $\mu_*$ 质量为一。$K_\alpha*\mu_*=p_*$，因为两者之差是 $u''=\alpha^2u$ 的可积解，只能为零。对任意正混合还有 $p_\mu(x+t)\ge e^{-\alpha|t|}p_\mu(x)$，它排除了在任一侧衰减过快的纯平方根形状。

令 $w=q/p_*^2$，$G=K_\alpha*w$。下节证明 $w$ 有界以及 $G\le F_*:=F(\mu_*)$。由 Tonelli 定理和倒数的精确展开，对任意候选概率测度 $\nu$，
$$
F(\nu)-F_* = \int (F_*-G)\,d\nu
+\int_{\mathbb R}\frac{q(x)(p_\nu(x)-p_*(x))^2}{p_\nu(x)p_*(x)^2}\,dx .
$$
即使 $F(\nu)=\infty$，此式仍成立，因为线性项有限。右侧两项非负。等号迫使 $p_\nu=p_*$ 几乎处处；由连续性，等式处处成立。再施加 Green 算子可知 $\nu=\mu_*$。

### 3.3. 外侧证书与一次变号积分

设 $G(z_0)=\Lambda$，且 $f(t)=e^{-\alpha t}(w(z_0+t)-\Lambda)$ 在 $[0,\infty)$ 的积分为零。若 $f$ 在某个 $d>0$ 前为正、之后为负，则
$$
G(z_0+s)-\Lambda
=\frac\alpha2e^{-\alpha s}\int_0^\infty e^{2\alpha\min(s,t)} f(t)\,dt,
\qquad s>0 .
$$
原因是 $z_0$ 左半线的修正积分在 $z_0$ 为零，向右移动后只多一个统一的指数因子。对右侧积分，可以从递增乘数 $e^{2\alpha\min(s,t)}$ 减去它在 $d$ 的值，积分不变。乘积在两段均非正，在 $(0,\min(s,d))$ 严格为负。左侧由反射得到。Lean 证书检查了这一积分论证及弱不等式版本。

对分布式解取 $\Lambda=c^{-2}$，则 $w/\Lambda=1$ 在内区。对有限右边界，外侧比值为 $B(t)=e^{-V(R+t)+V(R)+2\alpha t}$。根方程给出 $\alpha\int_0^\infty e^{-\alpha t}B(t)dt=1$。$\log B$ 严格凹，在零处导数为正，最后趋于负无穷，故 $B-1$ 正后负且只穿过零一次。有限左边界有反射形式。每侧修正对内区的卷积贡献均为零，故 $G=\Lambda$ 于支持，外侧由上述积分得到 $G<\Lambda$。同时 $w$ 有界，$F_*=\int G\,d\mu_*=\Lambda$。

对单点解取 $p_*=K_\alpha(\cdot-b)$，$\Lambda=4q(b)A/\alpha^2$。左右平衡使 $G(b)=\Lambda$，每侧的修正积分都是零。$w(b\pm t)$ 严格对数凹、趋于零，且起始值至少为 $\Lambda$。当起始值恰为 $\Lambda$ 时，修正积分为零与远端严格为负迫使它先超过 $\Lambda$。故一次变号论证给出两侧 $G<\Lambda$。全局比较完成证明。

## 4. 相变阈值与临界收益

**定理 2。** 存在唯一 $\alpha_c\in(0,\min(s_-,s_+)/2)$ 使 $L=R=b_c$。低于或等于该值时最优律为单点，高于该值时为分布式。有限端点在 $\alpha$ 达到该侧斜率的一半时遁向无穷远。实际泊松率阈值为 $r_c=D\alpha_c^2$。

在两根同时存在的参数段，固定位置的两个尾比率随 $\alpha$ 严格增大，故 $L$ 严格左移、$R$ 严格右移，且都连续。$\alpha\downarrow0$ 时，对任一固定位置两比率趋于零，意味着 $L\to+\infty$、$R\to-\infty$。若有一侧先达到有限半斜率，该侧比率在临界半斜率处对任一固定位置仍严格大于一，故根遁向外侧无穷。若两侧斜率均无穷，则对任一固定位置，$\alpha\to\infty$ 时两个比率趋于无穷。严格单调性和连续性给出唯一交点。

**三次方收益。** 令 $b=b(\alpha)$ 为随参数移动的最佳单点，$\varepsilon=H_\pm(b)-1$，$\kappa=V'(b_c)/(2\alpha_c)$。从上方趋近阈值时，
$$
F(\delta_b)-F(\mu_*) =
\frac{q(b_c)}{6\alpha_c^2(1-\kappa^2)}\,\varepsilon^3+o(\varepsilon^3).
$$
其中 $\varepsilon=A'(\alpha_c)(\alpha-\alpha_c)+o(\alpha-\alpha_c)$，$A'(\alpha_c)>0$。实际首达时间的收益再乘同一参数下的 $\alpha/(2r)$。

证明时，微分分拆尾积分得
$$
\partial_x H_-=\alpha+(\alpha+V')H_-,\qquad
\partial_x H_+=-\alpha+(V'-\alpha)H_+ .
$$
临界附近每侧仍有统一的指数可积裕量，因此 $\partial_\alpha H_\pm>0$。在临界点记 $D_-=2\alpha_c+V'(b_c)>0$，$D_+=2\alpha_c-V'(b_c)>0$，隐函数定理给出
$$
A'(\alpha_c)=
\frac{D_+\partial_\alpha H_-+D_-\partial_\alpha H_+}{D_-+D_+}>0 .
$$
记 $d_-=b-L$、$d_+=R-b$、$t_\pm=\alpha\mp V'(b)/2$。边界方程给出 $2t_\pm d_\pm=\varepsilon+O(\varepsilon^2)$。归一化积分展开给出 $c^{-1}/(2h(b)/\alpha)=1+\varepsilon/2+O(\varepsilon^2)$。证书在 $b$ 取到 $F_*$，故全局比较式只剩倒数余项。

令 $p_b=K_\alpha(\cdot-b)$。用从 $b$ 沿该侧向外的坐标 $u$，内区上有
$$
\frac{p_*}{p_b}=1-\varepsilon/2+t_\pm u+O(\varepsilon^2),
\qquad 0\le u\le d_\pm.
$$
在两个外侧，$p_*/p_b$ 等于对应边界值 $1+O(\varepsilon^2)$，故外侧积分为 $O(\varepsilon^4)$，这里用到临界附近单点倒数代价一致有界。内区余项中的系数 $q/p_b$ 一致趋向 $2q(b_c)/\alpha_c$。于是积分主项来自两段
$$
\int_0^{\varepsilon/(2t_\pm)} (\varepsilon/2-t_\pm u)^2du
=\varepsilon^3/(24t_\pm).
$$
相加即得公式。两端点质量分别趋于 $(1+\kappa)/2$ 与 $(1-\kappa)/2$，两原子同时汇聚至同一点。

## 5. 算例与适用范围

反射 Gumbel 目标 $q(x)=e^{x-e^x}$ 在 $\alpha=1$ 时左侧斜率为 1，右侧为无穷。代换 $u=e^x$ 给出 $H_+(x)=e^{-x}+e^{-2x}$，因此 $R=\log\phi$，$\phi=(1+\sqrt5)/2$，最优支持为 $(-\infty,R]$。所有单点代价发散，但
$$
F_*=\left[\sqrt{2\pi}\,\operatorname{erf}(\sqrt{\phi/2})
          +\sqrt\phi\,e^{-\phi/2}\right]^2 .
$$

以 Beta$(1,3)$ 的 logit 为目标，则 $q(x)=3e^x/(1+e^x)^4$，向外斜率为 $(1,3)$。数值复核给出 $\alpha_c\approx0.3719087183$。随参数增大，依次出现单点、有界区间、半直线和全实线。左端点在 $\alpha=0.5$ 消失，右端点在 $\alpha=1.5$ 消失。三次收益的系数约为 $0.4110960757$。采用 55 位十进制计算，并以倒数余项直接积分核验微小收益。

补充定理将第 2 节的最优律推广至具有有限支撑、角点或仿射尾的对数凹密度。内区仍由 $H_-,H_+>1$ 决定，凸势的二阶导数改为曲率测度，最优律仍唯一。精确临界仿射尾可产生零质量端点或外侧证书等号。全文的三次收益定理使用第 2 节的光滑与严格凸假设。

## 6. 与已有工作的关系

Evans 与 Majumdar [1] 给出了目标函数、反演算子、无约束平方根形状及对称双指数算例，并在第 6 节提出非负重置律约束下的一般问题。前序研究稿 [7] 处理对称、严格对数凹且尾斜率无穷的情形。本文新增非对称与有限斜率分类，最优支持可为半直线或全实线，还给出最佳单点刚分裂时的三次收益，以及面向一般一维对数凹密度的分类。

近年相关研究优化预定重置族的参数、重置间隔分布或空间触发率 [3–6]。截至本文所列检索日期，所查文献中未发现相同控制变量和目标类别下的同等定理。学术优先权仍有待领域评议。

## 参考文献

1. M. R. Evans 和 S. N. Majumdar，*Diffusion with optimal resetting*，J. Phys. A **44**, 435001 (2011)，尤其第 5–6 节。[DOI](https://doi.org/10.1088/1751-8113/44/43/435001)
2. M. R. Evans、S. N. Majumdar 和 G. Schehr，*Stochastic resetting and applications*，J. Phys. A **53**, 193001 (2020)。[arXiv:1910.07993](https://arxiv.org/abs/1910.07993)
3. V. Méndez 等，*First-passage time of a Brownian searcher with stochastic resetting to random positions*，Phys. Rev. E **109**, 044134 (2024)。[DOI](https://doi.org/10.1103/PhysRevE.109.044134)
4. P. Julián-Salgado 等，*Abrupt transitions in the optimization of diffusion with distributed resetting* (2025)。[arXiv:2507.14483v2](https://arxiv.org/abs/2507.14483v2)
5. M. R. Evans 和 S. Ray，*Stochastic Resetting Prevails Over Sharp Restart for Broad Target Distributions* (2025)。[DOI](https://doi.org/10.1103/2wpq-gl2j)
6. G. García-Valladares 等，*How target distributions shape optimal stochastic resetting*，Phys. Rev. E **113**, 024107 (2026)。[DOI](https://doi.org/10.1103/9m8d-yjhw)
7. *Optimal reset locations for symmetric strictly log-concave targets*, 前序研究稿。[相关中文论文](../optimal-resetting-logconcave/paper.zh.md)。

本版本未附数值计算程序与 Lean 源码，不声称重新编译或全文形式化。
