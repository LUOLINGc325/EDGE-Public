# Simes 带曲率的精确变号与全零假设线性系数的反例

## 摘要

Lim 的加权共形多重检验研究把一类全零假设构造的误报增量归结为 Simes 检验的带曲率。我们计算任意内部带的曲率，利用两个强制零值试验的拒绝数分布之比，证明曲率随带号至多从负变为正一次。全部内部带严格为正的充要条件是首带为正，其显式阈值趋于 $\log 2$。我们进一步求出带内 Poisson 窗口族的渐近最优系数。当 $q>\log 2$ 时，仅略去首个负曲率带就给出大于 Lim 猜想 20 所提系数的可达误报增量，且利用原论文的转移定理可在有限校准样本下实现。

## 1. 定义与精确结论

固定 $m\ge 2$ 和 $0<q<1$。Benjamini–Hochberg（BH）的阈值为 $t_i=qi/m$。全零假设下，错误发现率（FDR）等于至少拒绝一次的概率，即 Simes 拒绝概率。令 $\psi_m$ 为 $m$ 个独立同分布 $p$ 值的 Simes 拒绝概率，视为阈值处累积分布值的多项式。记 $\mathbf t=(t_i)_{i=1}^m$，对 $1\le k\le m-1$ 定义

$$v_k(i)=t_i-\mathbf 1\{i\ge k+1\},\qquad
\mathfrak D_{m,k}=v_k^\top\nabla^2\psi_m(\mathbf t) v_k.$$

这是 [Lim 2026](https://arxiv.org/html/2611.21509v1) 附录 D.3、D.6 中的内部带曲率。记 $L_m^*(q)$ 为其定理 53 定义的带内窗口首阶系数上确界。窗口成对不交，闭包严格位于某个内部带 $(t_k,t_{k+1})$，窗长之和为 $\ell_+<1$。由 Lim 定理 46，窗口的首阶系数为 $(1-\ell_+)\sum_h\ell_h\mathfrak D_{m,k_h}/2$。取上确界时，系数总是先对固定 $m$ 和固定窗口在 $\kappa=B/n\downarrow0$ 下计算。

**定理 1（有限 $m$ 的带曲率）。** 对 $r\in\{1,2\}$ 和 $r\le i\le m$ 置

$$P_{m,i}^{(r)}=(1-q){m-r\choose i-r} t_i^{i-r}(1-t_i)^{m-i-1}.$$

则

$$\frac{\mathfrak D_{m,k}}{m(m-1)}=2\sum_{i=k+1}^m \frac{P_{m,i}^{(2)}-P_{m,i}^{(1)}}{i}. \tag{1}$$

曲率按带号 $k$ 排列时，负值是一个可能为空的前缀，至多一个零值紧邻正值后缀。$m=2$ 时唯一内部带严格为正。$m\ge3$ 时全部内部带严格为正当且仅当

$$q<q_m:=m\bigl(1-2^{-1/(m-2)}\bigr). \tag{2}$$

若 $q=q_m\in(0,1)$，仅首带为零。阈值 $q_m$ 趋于 $\log 2$。

**定理 2（带内窗口的最优系数）。** 对整数 $i\ge2$ 令

$$g_i(q)=\frac{(1-q)e^{-qi}(qi)^{i-2}}{i(i-2)!}\left(1-\frac{qi}{i-1}\right),\qquad d_k(q)=2\sum_{i=k+1}^{\infty}g_i(q).$$

对每个固定 $q\in(0,1)$，

$$\lim_{m\to\infty}\frac{L_m^*(q)}{qm}
=\frac12\sum_{k=1}^{\infty}\max\{d_k(q),0\}=:C_{\mathrm{win}}(q). \tag{3}$$

当 $q\le\log 2$，$C_{\mathrm{win}}(q)=(1-q)/2$。对 $q>\log 2$，

$$ C_{\mathrm{win}}(q)\ \ge\ (1-q)(1-e^{-q})\ >\ \frac{1-q}{2}. \tag{4}$$

特别地，$q=3/4$ 时右侧的可达下界至少为 $33/260>1/8$。这给出 Lim 猜想 20 在完整 $q$ 范围内的反例。对 $q\le\log 2$，式 (3) 的最优性限于上述窗口族。

## 2. 从两组强制零值的拒绝数到曲率

对 $s\in(t_k,t_{k+1})$，令 $a_r(s)$ 表示把 $r$ 项固定为 $s$，其余 $m-r$ 项独立均匀时的 Simes 拒绝概率。将单坐标分布替换为 $(1-\varepsilon)\mathrm{Unif}(0,1)+\varepsilon\delta_s$。其阈值处 CDF 沿 $-v_k$ 移动。按点质量坐标数展开拒绝概率的二阶导数，得到 Lim 引理 48 的恒等式

$$ \mathfrak D_{m,k}=m(m-1)\{a_2(s)-2a_1(s)+a_0(s)\}. \tag{5}$$

写 $R$ 为 BH 拒绝数。样本中所有项目在这里均计入拒绝概率，即 $\mathbf 1\{R>0\}$ 等于各项拒绝指标除以 $R\vee1$ 后的和。任一均匀项的贡献恒为 $q/m$。理由是把该项替换为零后的拒绝数 $R'$ 独立于此项。它被拒绝当且仅当它不超过 $t_{R'}$，此时原拒绝数等于 $R'$。这也在 $r=0$ 时直接给出 Simes 精确性 $a_0(s)=q$。

对 $r$ 个固定等于 $s$ 的项，把它们同时替换为零，记拒绝数为 $R^{(r)}\ge r$。替换只会提高拒绝数。若 $s\le t_{R^{(r)}}$，原样本在该阈值有相同达标计数，所以拒绝数相等且这组项全部被拒绝。否则原样本的任一拒绝阈值都小于 $s$。因此

$$ a_r(s)=\frac{q(m-r)}{m}+r\sum_{i=k+1}^{m}\frac{\mathbb{P}(R^{(r)}=i)}{i}. \tag{6}$$

对 $R^{(r)}=i$，必须恰有 $i-r$ 个均匀项不超过 $t_i$。多于这个数量时若 $i<m$，$i+1$ 已可行。给定恰好这个数量，位于右边的 $m-i$ 个均匀项条件独立且均匀分布在 $(t_i,1)$。平移缩放后，无更晚可行阈值的概率由 Simes 精确性等于 $1-(m-i)q/[m(1-t_i)]=(1-q)/(1-t_i)$。$i=m$ 时右边没有项，该因子等于 $1$。乘上二项概率即得 $\mathbb P(R^{(r)}=i)=P_{m,i}^{(r)}$。这也就是 [Finner 和 Roters 2001](https://www.researchgate.net/publication/227601792_On_the_False_Discovery_Rate_and_Expected_Type_I_Errors) 式 (3.2) 中的 Dirac–均匀步进拒绝数分布，此处给出推导以固定计数定义。把 (6) 代入 (5)，线性项抵消，得到 (1)。

对 $2\le i\le m$，$P_{m,i}^{(1)}>0$，且

$$\frac{P_{m,i}^{(2)}}{P_{m,i}^{(1)}}=\frac{m}{q(m-1)}\frac{i-1}{i}.$$

这个比值严格递增，在 $i=m$ 等于 $1/q>1$。式 (1) 的被加数先可能为负，至多有一个零，最终严格为正。含有负项的尾和删掉一个负首项时严格增加。首项转为非负后，余下尾和均因末项严格为正而严格为正。若首个尾和恰好为零且还有其他尾和，首项必为负。因此所有曲率正当且仅当 $\mathfrak D_{m,1}>0$。首带公式由 Lim 引理 51 给出

$$\mathfrak D_{m,1}=m(m-1)(1-q)\{2(1-q/m)^{m-2}-1\}. \tag{7}$$

也可由 (5) 验证 (7)。两个 $s$ 强制在第二阈值拒绝。一个 $s$ 时，无拒绝等价于 $m-1$ 个均匀量满足 $U_{(j)}>(j+1)q/m$。先要求所有量大于 $q/m$，再在剩余区间应用 Simes 精确性，得到该事件概率 $(1-q)(1-q/m)^{m-2}$。式 (2) 和端点结论随即成立。

## 3. 窗口系数上确界与极限

写 $d_{m,k}=\mathfrak D_{m,k}/[m(m-1)]$，并对 $k\ge m$ 置零。对固定 $i,r$，二项质量与 $(1-t_i)^{m-i-1}$ 的极限给出

$$P_{m,i}^{(r)}\longrightarrow (1-q)e^{-qi}\frac{(qi)^{i-r}}{(i-r)!}.$$

这可以传入 (1) 的和。取固定 $z>1$ 使 $\theta=z^{-1}e^{q(z-1)}<1$。这样的 $z$ 存在，因为 $-\log z+q(z-1)$ 在 $z=1$ 的导数为 $q-1<0$。$R^{(r)}=i$ 蕴含至少 $i-r$ 个均匀项不超过 $t_i$。对该计数应用二项矩母函数界，得

$$P_{m,i}^{(r)}\le z^{r-i}\bigl[1+t_i(z-1)\bigr]^{m-r}\le z^r\theta^i.$$

从而 $|d_{m,k}|\le C(q)\theta^k$，统一于 $m,k$。控制 $i$ 尾和后有 $d_{m,k}\to d_k(q)$，再对 $k$ 求和可用同一几何控制，包括取正部后的和。Lim 引理 50 给出 $\sum_{k=1}^{m-1} d_{m,k}=1-q$，故 $\sum_{k\ge1}d_k(q)=1-q$。也可用 Lemma 49 的重复均匀点恒等式独立恢复此预算。

每个内部带的总窗口宽度至多 $q/m$，并且 $0<1-\ell_+\le1$。由 Lim 定理 46 的系数公式，$L_m^*(q)/(qm)\le (m-1)/(2m)\sum_{k\ge1}(d_{m,k})_+$。取任意固定的 $K$，在 $1\le k\le K$ 中的每个有限 $m$ 正曲率带中心放一个长度 $\eta q/m$ 的窗口，固定 $0<\eta<1$。它们的总长度至多 $Kq/m$，随 $m$ 趋于零。该窗口族给出

$$\liminf_{m\to\infty}\frac{L_m^*(q)}{qm}\ge \frac{\eta}{2}\sum_{k=1}^{K}(d_k(q))_+.$$

令 $\eta\uparrow1$ 和 $K\to\infty$ 得到 (3)。这里每个 $m$ 的窗都固定后才用 $\kappa\downarrow0$ 得系数，未交换误差项中依赖窗的常数。

式 (7) 给出 $d_1(q)=(1-q)(2e^{-q}-1)$。若 $q<\log2$，由 (2) 可知足够大 $m$ 时所有 $d_{m,k}>0$，故所有极限 $d_k(q)\ge0$。对 $q=\log2$ 亦如此，因为 $-\log(1-q/m)\le q/(m-q)$，且 $m-2<m-q$，所以 $(1-q/m)^{m-2}>e^{-q}=1/2$。于是 (3) 等于 $(1-q)/2$。若 $q>\log2$，则 $d_1(q)<0$，而正部和至少等于 $\sum_{k\ge2}d_k(q)=2(1-q)(1-e^{-q})$。这证明 (4)。在 $q=3/4$，Taylor 下界 $e^{3/4}>1+3/4+(3/4)^2/2=65/32>2$ 给出 $C_{\mathrm{win}}(3/4)>33/260$。

## 4. 有限样本反例及范围

令 $S_m(q,\kappa,n)$ 为 Lim 定理 54 所用全零假设、权重比 $B=\kappa n$ 的模型类中 $(\mathrm{FDR}-q)/(qm\kappa)$ 的上确界。对固定 $m$，定理 54 对任意误差 $\varepsilon>0$、所有足够小的正 $\kappa$、以及随后所有足够大的 $n$，给出至少 $(L_m^*(q)-\varepsilon)/(qm)$ 的值。于是

$$\liminf_{m\to\infty}\liminf_{\kappa\downarrow0}\liminf_{n\to\infty}S_m(q,\kappa,n)\ge C_{\mathrm{win}}(q).$$

等价地，也可选一条实际参数序列。先取 $m\to\infty$，对每个 $m$ 选足够小的 $\kappa_m\le m^{-2}$，再取足够大的 $n_m$，使误差趋零并有 $mB_m/n_m\to0$。因此超过原猜想系数的全零假设例子发生在严格的线性尺度，且样本量逐项有限。未要求同一个底层分布在所有 $m,\kappa,n$ 下有效。对窗口跨阈值、任意窗口或所有分布的最优系数，尤其是低 $q$ 的全模型上界，本文保持开放。

## 参考文献

- Ryan Lim. *Almost Controlled: The FDR of Benjamini–Hochberg on Weighted Conformal p-Values*. arXiv:2611.21509v1，2026。重点为猜想 20、定理 46、54 和引理 48、50、51。 [全文](https://arxiv.org/html/2611.21509v1)
- Helmut Finner and Markus Roters. *On the False Discovery Rate and Expected Type I Errors*. Biometrical Journal 43(8), 985–1005, 2001，式 (3.2)。 [全文记录](https://www.researchgate.net/publication/227601792_On_the_False_Discovery_Rate_and_Expected_Type_I_Errors)
