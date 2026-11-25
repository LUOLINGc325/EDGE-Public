# 固定不可逆生成元的任意多重频率峰

*分离谐波与严格超过快慢极限的 Floquet 局部最优*

## 1. 问题与结论

设 $Q$ 为固定的有限不可约行 Markov 生成元，$r(\theta)$ 为实向量周期势。考察
$$x'=[Q+\epsilon\operatorname{diag}r(\omega t)]x$$
的主 Floquet 指数 $\lambda_\epsilon(\omega)$。Evidence Press（2026）第 10 节问题 5 询问频率最优点的数目与位置。

**定理。** 若 $Q$ 不可逆，则对每个整数 $N\ge1$，存在只作用于同两个坐标、时间平均为零的三角多项式势。对所有足够小的 $\epsilon>0$，主指数至少有 $N$ 个严格局部最大值，每个都高于快、慢极限。可用不交叠的频率区间定位它们。

在第一行为 $(-1,1,0)$ 的单位单向三环上，取 $R=10^4$ 及
$$
r(\theta)=\sum_{j=0}^{N-1}10^{-j}
 (\cos(R^j\theta),-\sin(R^j\theta),0).
$$
每个 $(1/(4R^j),2/R^j)$ 内至少有一个这样的严格局部最大值。该族说明，即使生成元固定且振幅任意小，峰数也没有统一有限上界。

## 2. 单谐波响应

设 $\pi$ 为平稳律，记 $\langle z,y\rangle_\pi=\sum_i\pi_i\overline z_i y_i$。在零平均子空间置 $A=-Q$、$C=A^{-1}$，并将 $C$ 在常向量上延拓为零。Dirichlet 形式的实部在该子空间严格为正，故 $C$ 的谱位于开右半平面。若 $C^2$ 自伴，则其谱严格为正，且 $C$ 限制到每个 $C^2=aI$ 的谱子空间只能取正平方根。因此 $C$ 自伴，等价于 $Q$ 可逆。

不可逆时，有两个坐标 $i,l$ 使 $d=\pi_i(C^2)_{il}-\pi_l(C^2)_{li}\ne0$。取 $z$ 为 $e_i+i\operatorname{sign}(d)e_l$ 的平稳中心化版本，则 $\operatorname{Im}\langle z,C^2z\rangle_\pi>0$。中心化产生的标量正弦在一周期积分为零，故中心化与实际两站点势的指数相同。令
$$
\beta(s)=\tfrac12\operatorname{Re}\langle z,(A+is)^{-1}z\rangle_\pi .
$$
设 $y=(A+is)^{-1}z$，则 $\beta(s)=\tfrac12\operatorname{Re}\langle Ay,y\rangle_\pi>0$。并有 $\beta'(0)=\tfrac12\operatorname{Im}\langle z,C^2z\rangle_\pi>0$。对大 $s$ 展开预解式，首个配对项为纯虚数，得 $\beta(s)=O(s^{-2})$、$\beta'(s)=O(s^{-3})$。因此可取 $0<a<s_0<b$，使 $\beta'(a)>0$、$\beta(s_0)>\beta(0)$、$\beta'(b)<0$。在一个足够短的初始区间上 $\beta(s)\ge\beta(0)$。

## 3. 分离频率

选 $0<\xi<1$ 使 $\beta(0)\xi/(1-\xi)<\beta(s_0)-\beta(0)$。令 $n_j=R^j$，用中心化表示
$$
r(\theta)=\sum_{j=0}^{N-1}\xi^{j/2}\operatorname{Re}(ze^{in_j\theta}).
$$
对每个固定 $\omega>0$，正传播矩阵的 Perron 根在小振幅下解析。零阶模式为常向量，一阶第 $j$ 谐波由 $(A+in_j\omega)^{-1}$ 解析。对二阶方程取平稳与相位平均，不同谐波交叉项因正交性消失，得到
$$
\lambda_\epsilon(\omega)=\epsilon^2 B_N(\omega)+O_{\omega,N}(\epsilon^3),\qquad
B_N(\omega)=\sum_{j=0}^{N-1}\xi^j\beta(n_j\omega).
$$
对冻结特征值使用同一微扰并取相位平均，结合文献第 5 节端点公式，给出
$$
\lambda_{\rm slow}(\epsilon)=\epsilon^2B_N(0)+O_N(\epsilon^3),
\qquad\lambda_{\rm fast}(\epsilon)=0 .
$$

选大整数 $R$，使 $\xi R>1$、$aR\ge1$、$R>b/a$，且 $s_0/R$ 落在初始区间。对 $\omega=a/n_j$ 或 $b/n_j$，把导数 $B_N'$ 除以 $\xi^j n_j$。当前谐波给出 $\beta'(a)$ 或 $\beta'(b)$。设 $C_0$ 为 $|\beta'|$ 的整体上界，$C_\infty s^{-3}$ 为 $s\ge1$ 的上界。其余项绝对值的和至多为
$$
\frac{C_0}{\xi R-1}+\frac{C_\infty\xi}{a^3(R^2-\xi)}.
$$
两项分别是较低与较高谐波的几何和。取 $R$ 足够大使这个上界小于两端主斜率的绝对值。于是每个区间左端斜率正，右端负。

在 $\omega=s_0/n_j$，低谐波不低于各自慢端；高谐波的总亏损除以 $\xi^j$ 至多 $\beta(0)\xi/(1-\xi)$，小于当前谐波的上升。因此区间内部有值高于慢端与零。分别选靠近左右端的内部点，使相应 $B_N$ 高于端点。由于仅有有限固定频率，微扰将所有严格不等式传给充分小正振幅下的 $\lambda_\epsilon$。每个闭区间的最大值遂在内部且高于两个极限。正频率上周期传播矩阵关于 $1/\omega$ 解析，简单 Perron 根也解析。非恒定解析函数在每个这样的内点最大值附近为严格最大。势的振幅至多为固定常数乘 $\epsilon/(1-\sqrt\xi)$。$\square$

## 4. 三环精确常数

该三环的单谐波响应由文献第 9 节给出：
$$
\beta(s)=\frac{1+s/2+s^2/3}{s^4+3s^2+9}.
$$
有 $\beta'(1/4)=852736/16609827>1/20$、$\beta'(2)=-473/8214<-1/20$，及 $\beta(3/4)-\beta(0)=29/939$。直接求导给出 $s\le1$ 时 $|\beta'|\le1$、$s\ge1$ 时 $|\beta'|\le13s^{-3}$，且 $\beta(s)\ge\beta(0)$ 对 $0\le s\le3/4$ 成立。取 $(a,s_0,b)=(1/4,3/4,2)$、$\xi=1/100$、$R=10^4$。非当前谐波的导数干扰小于 $1/90$，高频慢端亏损至多 $1/891<29/939$。故上述区间和严格结论均成立。

## 文献

*Reversibility and frequency reduction in periodic and random positive systems*，匿名，Evidence Press / Zenodo，0.1.0-candidate（2026-11-03），第 5、9 节及第 10 节问题 5。[存档](https://zenodo.org/records/23911074) · [冻结第 10 节](https://github.com/ipitchford/reversibility-frequency-reduction/blob/v0.1.0-candidate/sec10_discussion.tex)
