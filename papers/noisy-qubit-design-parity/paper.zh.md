# 单量子比特酉设计偶奇噪声平台的精确判定

## 摘要

Strydom 与 Tame 的偶奇猜想称，不平移 Bloch 球的噪声赋予 $2k$ 阶与 $2k+1$ 阶酉设计等量敏感度。按原文的 Loewner 误差及截断半径约定，半强退极化在半径 $1/4$ 处产生严格反例，$\epsilon_4=41/400$、$\epsilon_5=1965/14896$。我们对任意前置单比特保单位噪声、以及两时序的退极化建立全阶精确公式。$k=1$ 时平台恒成立。对每个 $k\ge2$ 和每个固定非平凡径向收缩，存在唯一的转折半径，较小半径有严格偶奇差，较大半径恢复精确平台。

## 1. 误差和两种时序

输入 $\rho$ 的 Bloch 半径为 $r$，记 $A_m(r)=\mathbb{E}_{\mathrm{Haar}}(U\rho U^\dagger)^{\otimes m}$。在 [1] 式 (13) 中，相对误差是满足下式的最小 $\epsilon\ge0$
$
 (1-\epsilon)A_m(r)\preccurlyeq\widetilde A_m(\rho)
              \preccurlyeq(1+\epsilon)A_m(r).
\tag{1}
$
前置模型先施信道 $\mathcal N$，再施 $U$，见 [1] 式 (14)。若输出半径为 $s$，则 $\widetilde A_m=A_m(s)$。对保单位单量子比特信道，Bloch 映射是 $v\mapsto T v$，所以 $s\le r$。后置模型将噪声施在 $U\rho U^\dagger$ 后，见 [1] 式 (15)。退极化 $\mathcal D_p(\rho)=(1-p)\rho+pI/2$ 与酉共轭逐支对易，两时序完全相同，且 $s=(1-p)r$（同 [1] 附录 D）。

以下令 $x=r^2\in[0,1)$，$q=s^2/r^2\in[0,1]$；若 $r=0$ 则误差为零并可任取 $q$。逐态误差记为 $\epsilon_m(x,q)$，对半径不超过 $R<1$ 的球取上确界是原文截断式实验的连续总体版本。原文结论段关于 $2k$ 与 $2k+1$ 的猜想对应固定噪声和半径截断的曲线。若将所有纯态也纳入且收缩非平凡，$m\ge2$ 时完整球的统一误差实际为无穷大，因为收缩后矩是满秩，而原纯态的 Haar 矩只支持在全对称子空间。下文的比较都发生在满秩输入，无须处理零分母。

## 2. 精确的最大与最小块比值

对整数 $\ell\ge0$，定义
$
 h_\ell(x)=\sum_{j=0}^{\lfloor\ell/2\rfloor}
             c_{\ell,j}x^j,\qquad
 c_{\ell,j}=\frac{\binom{\ell}{2j}}{2j+1}.
$
在 $m$ 个相同单比特的 Schur–Weyl 分解中，标签
$\ell=m,m-2,\ldots,m\bmod2$ 的因子是
$\det^{(m-\ell)/2}\otimes\operatorname{Sym}^{\ell}(\mathbb C^2)$，并有与置换群相关的简并 [2]。若 $\lambda_\pm=(1\pm r)/2$，则 $\rho^{\otimes m}$ 在此块只作用于该因子。Haar 平均将其变为单位阵乘以归一迹
$
 \lambda_{m,\ell}(x)
 =\frac{(\lambda_+\lambda_-)^{(m-\ell)/2}}{\ell+1}
     \sum_{j=0}^{\ell}\lambda_+^{\ell-j}\lambda_-^j
 =2^{-m}(1-x)^{(m-\ell)/2} h_\ell(x).
\tag{2}
$
后一等式把等比数列写成 $(\lambda_+^{\ell+1}-\lambda_-^{\ell+1})/(\lambda_+-\lambda_-)$ 并按奇次幂展开，$r=0$ 由连续性覆盖。

式 (1) 的特征值比是
$
 \frac{\lambda_{m,\ell}(qx)}{\lambda_{m,\ell}(x)}
 =\left(\frac{1-qx}{1-x}\right)^{(m-\ell)/2}
       \frac{h_\ell(qx)}{h_\ell(x)} .
\tag{3}
$
其最大值在最小 $\ell$，因第一因子 $\ge1$ 且指数不大于 $\lfloor m/2\rfloor$，第二因子 $\le1$，而 $h_0=h_1=1$。

最小值在 $\ell=m$。具体地，对 $L>\ell$，系数比 $c_{L,j}/c_{\ell,j}$ 在公共非零支撑上随 $j$ 递增。这是因为被约掉的 $2j+1$ 相等，而 $\binom{L}{2j}/\binom{\ell}{2j}$ 是随 $2j$ 增加而增加的正因子乘积。在超出较短支撑的地方取 $c_{\ell,j}=0$。将
$
 h_L(qx)h_\ell(x)-h_\ell(qx)h_L(x)
 =\sum_{j>i}(c_{L,j}c_{\ell,i}-c_{L,i}c_{\ell,j})
              (q^j-q^i)x^{i+j}
$
按 $i,j$ 配对，右侧非正。故 $h_\ell(qx)/h_\ell(x)\ge h_m(qx)/h_m(x)$，乘以式 (3) 的第一个大于等于 $1$ 的因子而不减。于是有全阶公式
$
\boxed{\quad
 \epsilon_m(x,q)=\max\left\{
 \left(\frac{1-qx}{1-x}\right)^{\lfloor m/2\rfloor}-1,\,
 1-\frac{h_m(qx)}{h_m(x)}
 \right\}.
 \quad}
\tag{4}
$
固定 $q$ 时两项皆随 $x$ 不减。第二项的证明同样按系数配对：$h_m(qx)/h_m(x)$ 是递减的数列 $q^j$ 以权重 $c_{m,j}x^j$ 做的归一平均；增加 $x$ 使相对质量向较高 $j$ 移动。固定 $x$ 时两偏差都随 $q$ 不增。因此对前置保单位信道和截断球 $r\le R<1$，式 (4) 的最坏情况可在 $x=R^2$、$q=\sigma_{\min}(T)^2$ 取得。后置退极化取 $q=(1-p)^2$ 即得相同结论。

## 3. 偶奇平台的转折

写 $G_k(x)=((1-qx)/(1-x))^k-1$，以及 $F_m(x)=1-h_m(qx)/h_m(x)$。固定 $0\le q<1$、$0<x<1$。上一节的严格系数比给 $F_{2k+1}(x)>F_{2k}(x)$，因为 $j=1,i=0$ 项已经严格。偶、奇两阶在式 (4) 中共享同一 $G_k$。故
$
 \epsilon_{2k+1}>\epsilon_{2k}
 \quad\Longleftrightarrow\quad F_{2k+1}>G_k.
\tag{5}
$

$G_k(x)/x$ 严格递增。展开 $(1+(1-q)x/(1-x))^k-1$ 后除以 $x$，每一项不减且一次项严格递增。另一方面
$
 \frac{F_m(x)}x=
 \frac{\sum_{j\ge0}c_{m,j+1}(1-q^{j+1})x^j}
      {\sum_{j\ge0}c_{m,j} x^j}
$
严格递减。以下给出系数比判断。相邻两项的系数比 $d_j=c_{m,j+1}(1-q^{j+1})/c_{m,j}$ 在正支撑上满足
$
 \frac{d_{j+1}}{d_j}
 \le \frac{(2j+2)(2j+3)}{(2j+4)(2j+5)}
       \frac{j+2}{j+1}
 =\frac{2j+3}{2j+5}<1.
$
这里利用 $\binom m{2j+2}/\binom m{2j}$ 的两项递减分子，以及
$(1-q^{j+2})/(1-q^{j+1})\le(j+2)/(j+1)$，后者是几何数列前缀平均值递减。最后一个 $d_j=0$。再以 $c_{m,j}x^j$ 加权即得严格递减。该陈述用于 $m\ge2$。

在 $x\downarrow0$，$G_k(x)/x\to k(1-q)$、$F_m(x)/x\to \binom m2(1-q)/3$。若 $k=1$，奇阶极限同为 $1-q$，单调性给出全部半径的 $2/3$ 平台。若 $k\ge2$，奇阶的极限为 $k(2k+1)(1-q)/3>k(1-q)$。当 $x\uparrow1$，$G_k/x$ 发散且 $F_{2k+1}\le 1$。因此存在唯一 $x_*(q,k)\in(0,1)$ 使 $F_{2k+1}=G_k$。结合式 (5)，从零到 $x_*$ 之间两阶不同，$x_*$ 及以上两阶相同。对 $q=1$ 两偏差皆为零。小半径下对一切 $m\ge4$ 由式 (4) 得
$
 \epsilon_m(x,q)=\frac{m(m-1)}6(1-q)x+O_m(x^2).
\tag{6}
$

## 4. 用原文退极化强度得到确切反例

取 [1] 图 9 的退极化强度 $p=1/2$，以及同一半径截断约定 $R=1/4$，故 $q=1/4$、$x=1/16$、$qx=1/64$。由 $h_4(x)=1+2x+x^2/5$，次数四的 $F_4(x)/x$ 与 $G_2(x)/x$ 在 $x\downarrow0$ 有同一极限且前者严格递减、后者严格递增，故 $\epsilon_4=G_2=41/400$。而 $h_5(x)=1+(10/3)x+x^2$，给
$
 F_5(x)=1-\frac{12931}{14896}
       =\frac{1965}{14896}>\frac{41}{400}.
$
因而 $\epsilon_5=1965/14896$。对整个截断球、该球面、或任何含有半径 $1/4$ 状态的同截断样本，都取得该对数值。两时序一样。这一构造反驳了原文的普遍偶奇平台猜想。式 (4) 解释平台与半径有关，且更一般的各向异性后置矩还需要额外分析。

## 参考文献

1. Conrad Strydom and Mark Tame, *Investigating the effect of noise channels on the quality of unitary t-designs*, Physical Review A 108, 052414 (2023), Eqs. (11), (13)–(15), Fig. 9, §V and Appendix D. DOI 10.1103/PhysRevA.108.052414. arXiv:2203.13771v2.
2. Michael Keyl and Reinhard F. Werner, *Estimating the spectrum of a density operator*, Physical Review A 64, 052311 (2001). DOI 10.1103/PhysRevA.64.052311.
