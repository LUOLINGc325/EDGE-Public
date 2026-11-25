# 近似差分隐私下最优 e-power 的指数预算相图

**研究稿，2026-11-25。** 本文给出书面数学证明，尚未经过外部同行评议。所有对数均为自然对数。

## 摘要

在固定有限字母表上，考虑两个满支撑简单假设的独立同分布样本，以及替换一条记录的中心化 $(\varepsilon,\delta_n)$ 差分隐私。令 $-n^{-1}\log\delta_n\to\rho$。本文证明，最优归一化期望对数 e-value 的极限等于在以备择分布为中心、半径 $\rho/\varepsilon$ 的总变差球上最小化的 KL–总变差泛函。证明同时覆盖任意随机输出机制的上界和一个达到该界的直方图发布机制。关键步骤是用满支撑输入给出的似然比上限，控制近似隐私例外质量对 KL 的贡献；构造侧则精确校准截断格点噪声的边界泄露。进一步给出相图的饱和阈值、截断似然比求值方法及有限样本上下证书。次指数隐私预算的无损端点、纯隐私最优率和截断噪声思想均有明确近邻，本文的主要增量限定为正指数预算下的全机制匹配相图。

## 1. 问题、已有工作和范围

令 $\mathcal X=[m]$，其中 $m\ge2$ 固定。$P=(p_i)$ 与 $Q=(q_i)$ 为严格正概率向量，分别表示零假设和备择；$\varepsilon>0$ 固定。相邻数据库 $x,x'\in\mathcal X^n$ 恰好有一个坐标不同。随机机制 $K$ 满足

$$
K(x,A)\le e^\varepsilon K(x',A)+\delta_n
$$

对全部相邻数据库和全部可测输出事件成立，两个方向均须成立。隐私条件覆盖整个输入域。

随机 e-variable $E_n$ 是非负实数输出的此类机制，且 $\mathbb E_{P^n}E_n\le1$。定义

$$
V_n=\sup_{E_n}\mathbb E_{Q^n}\log E_n,
\qquad \rho_n=-\frac1n\log\delta_n,
\qquad 0<\delta_n<\tfrac12.
$$

允许期望等于 $-\infty$。中间分布 $R$ 可以有零坐标，约定 $0\log0=0$，并记

$$
D(R\Vert P)=\sum_i r_i\log(r_i/p_i),\qquad
t(R)=\operatorname{TV}(R,Q)=\tfrac12\sum_i|r_i-q_i|.
$$

Jacobsen 等的纯隐私结果给出无半径约束的 $\min_R[D(R\Vert P)+\varepsilon t(R)]$，并明确提出近似隐私的最优 e-power 问题。[1] Csillag–Mesquita 的乘性噪声补偿已包含有界对数敏感度下的次指数 $\delta_n$ 无损首项。[2] 二元有限样本 UMP/Tulap 检验以及频数表上的截断 Laplace 似然比检验分别是构造和大偏差分析的重要先例。[3,4] 因此，本文不将这些端点或噪声思想计作首次发现。 Li–Han–Jiang–Gao 在语言识别与生成中已给出由 $\log(1/\delta_n)$ 尺度决定的阈值先例。[5] 本文的新增主张限于下述固定有限全支撑 e-power 问题的完整受限 KL/TV 公式及全机制匹配上下界，不包括指数隐私预算产生相变这一一般概念。

研究范围不含增长字母表、非满支撑假设、随 $n$ 改变的 $\varepsilon$、复合零假设，或整个序贯发布过程的隐私与任意停止有效性。发布通道可以不依赖 $P,Q$，但输出似然比后处理依赖待检验的分布对；这不是有限样本 Blackwell 普适最优性声明。

## 2. 主定理

**定理 1（完整指数预算相图）。** 若 $\rho_n\to\rho\in[0,\infty]$，则极限存在，且

$$
\boxed{
\lim_{n\to\infty}\frac{V_n}{n}
=J_\varepsilon(\rho;P,Q)
:=\min_{R:\,\varepsilon t(R)\le\rho}
\left[D(R\Vert P)+\varepsilon t(R)\right].
}
\tag{1}
$$

$\rho=\infty$ 时去掉约束。一个只依赖 $m,n,\varepsilon,\delta_n$ 的直方图发布机制，对每个固定满支撑分布对均达到该极限；这里没有对随 $n$ 改变的分布对作一致收敛声明。

两端分别为

$$
J_\varepsilon(0;P,Q)=D(Q\Vert P),\qquad
J_\varepsilon(\infty;P,Q)=\min_R[D(R\Vert P)+\varepsilon t(R)].
\tag{2}
$$

因此，$\delta_n$ 的指数尺度决定中间分布能离开 $Q$ 多远。后面的证明分别建立对所有机制成立的上界与明确构造的下界。

## 3. 输出 KL 与一个例外质量引理

固定任意机制 $K$，写 $A=Q^nK$、$B=P^nK$。输入满支撑推出输出分布等价，并且

$$
e^{n\ell}\le \frac{dA}{dB}\le e^{nu},\qquad
\ell=\min_i\log(q_i/p_i),\quad
u=\max_i\log(q_i/p_i)\ge0.
\tag{3}
$$

这是把输入似然比上下界乘以非负核，再对输入求和的直接结果。对于任意 $e\ge0$、$\int e\,dB\le1$，令 $f=dA/dB$，则 Jensen 不等式给出

$$
\int\log(e/f)\,dA\le\log\int(e/f)\,dA
=\log\int e\,dB\le0.
$$

其正对数部分可积，因为 $\log^+e\le e$ 且 $A\le e^{nu}B$。$e=0$ 导致的负无穷不会破坏不等式。等号在 $e=f$ 取得，后处理保持隐私。因此

$$
V_n=\sup_{K\ {
m DP}}D(Q^nK\Vert P^nK),
\qquad 0\le V_n\le nD(Q\Vert P).
\tag{4}
$$

后一式是数据处理不等式，也可由有限输入的 log-sum 不等式直接证明。RN 导数在 $B$ 零测集上的赋值无关紧要：由于每个输入在 $P^n$ 下概率严格正，该零测集在每个条件输出核下都为零。

**引理 2（近似支配转 KL）。** 若 $A\ll B$、$f=dA/dB\le e^L$，其中 $L\ge0$，且对所有事件 $S$ 有

$$
A(S)\le e^aB(S)+\tau,
$$

则

$$
D(A\Vert B)\le\min\{L,\ a+[1+(L-a)_+]\tau\}.
\tag{5}
$$

**证明。** 取 $S=\{f>e^a\}$，得到 $\int(f-e^a)_+\,dB\le\tau$。若 $f\le e^a$，则 $f\log(f/e^a)\le0$。若 $f>c=e^a$，利用 $\log x\le x-1$，有

$$
f\log(f/c)=(f-c)\log(f/c)+c\log(f/c)
\le(f-c)[(L-a)+1].
$$

故处处有 $f\log(f/e^a)\le(f-e^a)_+[1+(L-a)_+]$。积分并用 $\int f=1$ 即得；另由 $\log f\le L$ 得到第一项。$f\log f$ 的负部有界，积分合法。证毕。

只知道近似支配并不足以控制 KL，因为例外质量可能带有任意大的似然比。本题中式 (3) 的统一上限使归一化例外损失至多为 $(u+1/n)\tau$。

## 4. 全机制上界

定义 $G_\varepsilon(k)=\sum_{j=0}^{k-1}e^{j\varepsilon}$，$G_\varepsilon(0)=0$。沿长度为 $h$ 的邻接路径迭代隐私不等式，得到

$$
K(x,S)\le e^{\varepsilon h}K(y,S)+\delta_nG_\varepsilon(h).
\tag{6}
$$

固定任意 $R$，逐坐标最大耦合 $Q,R$，得到联合样本 $(X,Y)$，使 $X\sim Q^n$、$Y\sim R^n$ 且 $H=d_H(X,Y)\sim\operatorname{Bin}(n,t(R))$。对 $\eta>0$ 置

$$
T=\left\{y:\ r^n(y)>0,\ \log\frac{r^n(y)}{p^n(y)}\le n[D(R\Vert P)+\eta]\right\},
\quad b_{n,R}(\eta)=R^n(T^c).
$$

对整数 $0\le k\le n$，在**联合事件** $C=\{H\le k,Y\in T\}$ 上用式 (6)，在补集上仅用条件概率不超过一，得到

$$
\begin{aligned}
Q^nK(S)
&\le e^{\varepsilon k}\mathbb E[\mathbf1_CK(Y,S)]
 +\delta_nG_\varepsilon(k)+\Pr(C^c)\\
&\le e^{\varepsilon k}\mathbb E_{R^n}[\mathbf1_TK(Y,S)]
 +\delta_nG_\varepsilon(k)+\Pr\{H>k\}+b_{n,R}(\eta)\\
&\le e^{n[D(R\Vert P)+\eta]+\varepsilon k}P^nK(S)+\tau_n,
\end{aligned}
\tag{7}
$$

其中

$$
\tau_n=\min\left\{1,\Pr\{\operatorname{Bin}(n,t(R))>k\}
+b_{n,R}(\eta)+\delta_n\frac{e^{\varepsilon k}-1}{e^\varepsilon-1}\right\}.
\tag{8}
$$

这一步不假设两个好事件独立。尤其不能先丢掉 $R$ 的典型集，再让其尾误差乘上巨大的 $e^{\varepsilon k}$。

由引理 2 得到一个对全部机制同时成立的有限样本上证书：令 $A_n=D(R\Vert P)+\eta+\varepsilon k/n$，则

$$
\boxed{
\frac{V_n}{n}\le
\min\left\{D(Q\Vert P),\ A_n+\left[\frac1n+(u-A_n)_+\right]\tau_n\right\}.
}
\tag{9}
$$

若 $0<\rho<\infty$，先固定 $\varepsilon t(R)<\rho$。因 $Q$ 满支撑，$t(R)<1$，可选 $t(R)<s<\min(1,\rho/\varepsilon)$，令 $k_n=\lceil ns\rceil$。两个抽样尾概率由大数定律趋于零；同时

$$
\delta_nG_\varepsilon(k_n)
\le\frac{e^\varepsilon}{e^\varepsilon-1}
\exp[-n(\rho_n-\varepsilon s)]\longrightarrow0.
$$

式 (9) 先令 $n\to\infty$，再令 $\eta\downarrow0$、$s\downarrow t(R)$，得到严格球上的上界。对闭球边界中的 $R$，改用 $R_\lambda=(1-\lambda)R+\lambda Q$，其距离为 $(1-\lambda)t(R)$。KL 在闭单纯形上连续，令 $\lambda\downarrow0$ 即得到式 (1) 的闭球上界。不能直接假定边界上的 $\delta_ne^{\varepsilon nt(R)}$ 消失。

$\rho=0$ 时直接用式 (4)；这允许 $\delta_n$ 为常数。$\rho=\infty$ 时，对每个固定 $R$ 同样取 $s\in(t(R),1)$，隐私误差消失，得到无约束最小值。所有误差均与机制无关，因而没有不合法地交换机制上确界与非一致极限。

## 5. 达到机制及精确隐私校准

令

$$
\Lambda=\{z\in\mathbb Z^m:\sum_i z_i=0\},\quad
k(z)=\tfrac12\sum_i|z_i|,\quad
g_r(z)=C_r^{-1}e^{-\varepsilon k(z)}\mathbf1_{k(z)\le r}.
\tag{10}
$$

$r$ 为非负整数，$C_r$ 是归一化常数。独立采样 $Z_r\sim g_r$ 并发布 $W=h(X)+Z_r$。输出允许负坐标，保证归一化不依赖数据库。

距离为整数。把非零坐标分成正、负支撑并作整数组成计数，得到 $s_m(0)=1$，且 $k\ge1$ 时

$$
s_m(k)=\sum_{a,b\ge1,\ a+b\le m}
\frac{m!}{a!b!(m-a-b)!}
{k-1\choose a-1}{k-1\choose b-1}
\le3^m k^{m-2}.
\tag{11}
$$

因此 $C_\infty=\sum_ks_m(k)e^{-\varepsilon k}$ 和 $M_1=\sum_k k s_m(k)e^{-\varepsilon k}$ 均有限。

任意邻接方向 $v=e_i-e_j$ 满足 $|k(z)-k(z-v)|\le1$。两个噪声概率均正时，似然比不超过 $e^\varepsilon$。正部差仅来自 $k(z)=r,k(z-v)=r+1$ 的边界帽，因此精确泄露为

$$
\Delta_m(r)=\sum_z[g_r(z)-e^\varepsilon g_r(z-v)]_+
=\frac{c_m(r)e^{-\varepsilon r}}{C_r},
\tag{12}
$$

其中

$$
c_m(r)=\sum_{a,b\ge0,\ a+b\le m-2}
\frac{(m-2)!}{a!b!(m-2-a-b)!}{r\choose a}{r\choose b}.
\tag{13}
$$

证明式 (13) 时可取 $v=e_1-e_2$。退出条件恰为 $z_1\le0,z_2\ge0,k(z)=r$。其余坐标选择 $a$ 个严格正、$b$ 个严格负；总正质量 $r$ 分到 $a$ 个正整数和坐标2的一个非负整数，共 ${r\choose a}$ 种，负质量同理。全部方向经置换相同。离散正部差的和等于对所有事件的最大隐私差，所以式 (12) 验证的是完整事件隐私。

可取最小整数半径 $r_n$ 使 $\Delta_m(r_n)\le\delta_n$。其尺度是

$$
\frac{r_n}{n}\longrightarrow\frac\rho\varepsilon.
\tag{14}
$$

一个无需依赖最小性单调假设的证明如下。取固定 $r_0>\max(1,(m-2)/\varepsilon)$，并选最小 $r\ge r_0$ 满足

$$
\varepsilon r-(m-2)\log r\ge\log(1/\delta_n)+m\log3.
\tag{15}
$$

由式 (11) 这是充分半径，并等于 $[\log(1/\delta_n)+O(\log(\log(1/\delta_n)+2))]/\varepsilon$。精确最小半径不大于它；另一方面 $c_m(r)\ge1,C_r\le C_\infty$ 给出 $\varepsilon r_n\ge\log(1/\delta_n)-\log C_\infty$。上下夹即得式 (14)，也覆盖零指数和无穷指数。

不能省略边界修正。例如 $m=3,\varepsilon=\log2,r=10$ 时，$c_3(r)=2r+1$，精确泄露为

$$
\Delta_3(10)=\frac{21}{13240}>\frac1{1024}.
$$

所以把 $r=\log(1/\delta)/\varepsilon$ 直接作为有限样本校准可能失效；本例最小可行半径为11。

## 6. 类型夹逼、概率极限与期望极限

令 $\mathcal T_n$ 为 $n$ 样本类型集合，$N_n={n+m-1\choose m-1}$。对正概率向量 $A$ 和输出 $w$，定义

$$
I_{A,n}^{(r)}(w)=\min_{R\in\mathcal T_n:\,\operatorname{TV}(R,w/n)\le r/n}
\{D(R\Vert A)+\varepsilon\operatorname{TV}(R,w/n)\}.
$$

在输出支撑上可行集非空。即使 $w/n$ 有负坐标，总变差符号在这里仍指半个 $\ell_1$ 距离。若 $R=h/n$，则

$$
N_n^{-1}e^{-nD(R\Vert A)}\le\Pr_A\{h(X)=h\}\le e^{-nD(R\Vert A)}.
\tag{16}
$$

一个直接证明是写成 $\Pr_R(h)e^{-nD(R\Vert A)}$。$h$ 是参数为 $R=h/n$ 的多项分布的众数：任意其他类型 $g$ 与它的概率比为 $\prod_i h_i^{g_i-h_i}h_i!/g_i!\le1$；使用 $h_i=0$ 坐标的类型概率为零。类型总数为 $N_n$，故 $1/N_n\le\Pr_R(h)\le1$。

设 $\mu_{A,n}^{(r)}$ 是噪声直方图输出分布。将式 (16) 代入卷积，使用一个极小类型和至多 $N_n$ 项的和，得到

$$
nI_{A,n}^{(r)}(w)+\log C_r-\log N_n
\le-\log\mu_{A,n}^{(r)}(w)
\le nI_{A,n}^{(r)}(w)+\log C_r+\log N_n.
\tag{17}
$$

假设 $r_n/n\to b$、$w_n/n\to Q$。$Q$ 满支撑保证 $w_n$ 最终是非负整数直方图。对有限极小点取收敛子列，紧性和 KL 连续性给出

$$
\liminf I_{A,n}^{(r_n)}(w_n)
\ge\min_{R:\operatorname{TV}(R,Q)\le b}
[D(R\Vert A)+\varepsilon\operatorname{TV}(R,Q)].
$$

$b=0$ 时所有可行类型均趋于 $Q$，并可选 $w_n/n$ 给出反向界。$0<b<\infty$ 时先把连续极小点向 $Q$ 混合以产生严格余量，再以 $O(m/n)$ 的 $\ell_1$ 误差取类型近似；先取 $n$ 极限，再去掉混合量。$b=\infty$ 时所有固定类型近似最终可行。结合 $1\le C_r\le C_\infty$、$\log N_n=O_m(\log n)$，式 (17) 给出确定性输出概率指数极限。

由于 $\mathbb E k(Z_{r_n})\le M_1$，在 $Q^n$ 下 $W_n/n\to Q$ 依概率。分别取 $A=P,Q$，得到

$$
\frac1n\log\frac{\mu_{Q,n}^{(r_n)}(W_n)}{\mu_{P,n}^{(r_n)}(W_n)}
\longrightarrow J_\varepsilon(\rho;P,Q)
\quad\text{依概率}.
$$

这里把确定性序列结论用于随机输出是合法的：若不依概率收敛，可从坏输出中选出归一化距离趋零的确定性反例序列。式 (3) 又把整个随机量夹在固定的 $[\ell,u]$ 中，因此期望也收敛。

最终取 $E_n(W)=\mu_{Q,n}^{(r_n)}(W)/\mu_{P,n}^{(r_n)}(W)$。两个输出分布有相同支撑，所以该值有限且正，$\mathbb E_{P^n}E_n=1$，并由后处理保持隐私。它达到式 (1)，与第4节上界合并完成主定理。若 $P=Q$，直接得到 $E_n\equiv1$。

## 7. 相图的计算与饱和阈值

令 $L=\max_i\log(q_i/p_i)-\min_i\log(q_i/p_i)$。对 $\beta\ge0$，记 $R_\beta$ 为 $D(R\Vert P)+\beta t(R)$ 的唯一极小点，$t_\beta=t(R_\beta)$。严格凸性给出唯一性；它可以写为

$$
R_{\beta,i}=p_i\min\{a e^\beta,\max(a,q_i/p_i)\},\qquad\sum_iR_{\beta,i}=1.
\tag{18}
$$

这族截断极小点是纯隐私问题的已有结构。[1] 其充分性可直接由绝对值次梯度验证：存在 $s_i\in\partial|R_{\beta,i}-q_i|$，使 $\log(R_{\beta,i}/p_i)+(\beta/2)s_i$ 对 $i$ 为常数。对任意 $R$，展开 KL 并加次梯度不等式，得

$$
D(R\Vert P)+\beta t(R)-D(R_\beta\Vert P)-\beta t_\beta
\ge D(R\Vert R_\beta)\ge0.
$$

$\beta\ge L$ 时 $R_\beta=Q$。因为

$$
D(R\Vert P)+\beta t(R)-D(Q\Vert P)
\ge D(R\Vert Q)+(\beta-L)t(R)\ge0.
$$

$\beta<L$ 时从最大对数似然比坐标向最小坐标搬移微量质量，在 $Q$ 处的方向导数为 $\beta-L<0$，所以 $t_\beta>0$。极小点唯一性与紧性给出连续性。两次使用最优性得到 $t_\beta$ 非增；若在两个不同的 $\beta<L$ 取相同正距离，则唯一性迫使极小点相同，而一增一减的两个坐标的次梯度条件又强迫这两个 $\beta$ 相等。因此 $t_\beta$ 在 $[0,L]$ 严格下降至零（$P=Q$ 的常值情况除外）。

定义

$$
\rho_*=\varepsilon t_\varepsilon.
\tag{19}
$$

若 $\varepsilon\ge L$，所有 $\rho$ 的速率均为 $D(Q\Vert P)$。否则，当 $0<\rho<\rho_*$，唯一 $\beta\in(\varepsilon,L)$ 满足 $t_\beta=\rho/\varepsilon$，并有

$$
J_\varepsilon(\rho)=D(R_\beta\Vert P)+\rho;
\qquad \rho\ge\rho_*\Longrightarrow
J_\varepsilon(\rho)=D(R_\varepsilon\Vert P)+\varepsilon t_\varepsilon.
\tag{20}
$$

证明只需对满足 $t(R)\le t_\beta$ 的 $R$ 写
$F_\varepsilon(R)=F_\beta(R)-(\beta-\varepsilon)t(R)\ge F_\beta(R_\beta)-(\beta-\varepsilon)t_\beta$。

非恒定区间内，用两端最优乘子的支撑线比较可得

$$
J_\varepsilon'(\rho)=1-\beta/\varepsilon.
$$

因此曲线连续、凸，在非恒定段严格下降且严格凸；零点右导数统一为 $\min\{0,1-L/\varepsilon\}$，正饱和阈值处左导数为零。计算只需先对归一化常数 $a$ 二分，再对 $\beta$ 二分，不要求一般非光滑优化器。

## 8. 有限样本下证书与数值示例

写 $I_P(Q,b)=\min_{\operatorname{TV}(R,Q)\le b}[D(R\Vert P)+\varepsilon\operatorname{TV}(R,Q)]$。对 $\eta>0$ 令

$$
\beta_n(\eta)=2m e^{-2n\eta^2/m^2}
+\sum_{k>\lfloor n\eta/2\rfloor}s_m(k)e^{-\varepsilon k}.
$$

坐标 Hoeffding 界和噪声尾界给出 $\Pr\{\operatorname{TV}(W/n,Q)\le\eta\}\ge[1-\beta_n(\eta)]_+$。在此事件上，反三角不等式推出
$I_{P,n}^{(r)}(W)\ge[I_P(Q,r/n+\eta)-\varepsilon\eta]_+$。又有
$H(W)\le\log N_n+H(Z_r)$ 及 $H(Z_r)=\log C_r+\varepsilon\mathbb E k(Z_r)$。把这些式子代入式 (17) 后归一化常数抵消，得到

$$
\boxed{
\frac1nD(\mu_{Q,n}^{(r)}\Vert\mu_{P,n}^{(r)})
\ge[1-\beta_n(\eta)]_+[I_P(Q,r/n+\eta)-\varepsilon\eta]_+
-\frac{2\log N_n+\varepsilon\mathbb E k(Z_r)}{n}.
}
\tag{21}
$$

可以再与零取最大值。若用数值优化计算 $I_P$，必须使用经过认证的下包围，才能把数值代入称作严格证书。

作为解释性二元例，取 $P=\mathrm{Bernoulli}(0.1)$、$Q=\mathrm{Bernoulli}(0.7)$、$\varepsilon=0.5$。有

$$
r_\varepsilon=\frac{0.1e^{0.5}}{0.9+0.1e^{0.5}},\qquad
\rho_*=0.5(0.7-r_\varepsilon)\approx0.2725859505.
$$

饱和前 $J=d(0.7-2\rho\Vert0.1)+\rho$，饱和后约为 $0.2871452765$。下列为数值求值，不是新的有限样本界。

| $\rho$ | 最优渐近 e-power / 样本 |
|---:|---:|
| 0 | 1.032553418 |
| 0.02 | 0.934493259 |
| 0.05 | 0.800683595 |
| 0.10 | 0.610825624 |
| 0.20 | 0.353663587 |
| 0.30 | 0.287145277 |

二元最优私有测试已有更强的有限样本先例，本表仅验证和解释一般公式。[3] 有限 $n$ 的归一化 e-power 可能高于极限，不能用表中极限替代式 (9)。

## 9. 验证边界

有限算术核验和两种数值优化方法的比较仅作为补充；本版本未附相应程序。有限枚举不替代上面的全域证明。已编译的 Lean 文件验证支持性有限求和、群隐私递推和正输出 e-value 引理；这些引理不等于任意可测输出和渐近主定理的完整形式化。全文尚未形式化，本版本未附 Lean 源码。

本文不宣称已获期刊或高校认证，也不以未取得的文献内容支持首创性。文献比较以本文所列来源及其可得版本为限。

## 参考文献

1. B. Jacobsen, T. Gonzalez, G. Brown, K. Fawaz, A. Ramdas. *Optimal Rates for Differentially Private Hypothesis Testing with E-values*. arXiv:2605.28952v2, 2026. [全文](https://arxiv.org/html/2605.28952v2).
2. D. Csillag, D. Mesquita. *Differentially Private E-Values*. AISTATS, PMLR 300:1999–2007, 2026. [正式入口](https://proceedings.mlr.press/v300/csillag26a.html).
3. J. Awan, A. Slavković. *Differentially Private Uniformly Most Powerful Tests for Binomial Data*. NeurIPS 31, 2018. [正式全文](https://proceedings.neurips.cc/paper/2018/file/296472c9542ad4d4788d543508116cbc-Paper.pdf).
4. E. Dolera, S. Favaro. *The power of private likelihood-ratio tests for goodness-of-fit in frequency tables*. arXiv:2109.09630v2, 2022. [预印本](https://arxiv.org/abs/2109.09630). 后续正式版为 M. Beraha, E. Dolera, S. Favaro, *Bernoulli* 32(1):544–566, 2026，[DOI](https://doi.org/10.3150/25-BEJ1869)；本次全文比较基于2022预印本，正式版仅核查元数据和摘要。
5. X. Li, A. Han, J. Jiang, J. Gao. *On the Price of Privacy for Language Identification and Generation*. arXiv:2604.07238v2, 2026-11-16 修订。[全文](https://arxiv.org/html/2604.07238v2)；[版本记录](https://arxiv.org/abs/2604.07238v2)。
