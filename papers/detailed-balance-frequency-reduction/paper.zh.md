# 平均增长频率单调性的细致平衡判据

*循环预解式乘积、精确慢系数与 Erlang 时钟*

## 1. 结论

设 $Q$ 为有限不可约传输生成元，环境是有限不可约 Markov 链，选择 $A_j=Q+D_j$，其中 $D_j$ 为实对角势。平均指数指 $x'=A_{\sigma(\omega t)}x$ 下 $\mathbb E[\mathbf1^\top x(t)]$ 的长期指数。

**定理。** 对每个有限不可约 Markov 对角环境，平均指数随速度 $\omega>0$ 非增，当且仅当 $Q$ 满足细致平衡。对于每个不可逆 $Q$，存在任意小的对角势和有向循环 Markov 环境，使平均指数在正内点严格超过快、慢两个极限。

可逆方向由配套案例《不可逆环境切换下的平均增长频率单调性》给出。下文证明反方向，并证明任意有限周期协议的平均指数通过 Erlang 时钟以 $O(N^{-1})$ 逼近。使用列向量约定。若文献中生成元按行定义，可转置并反转周期次序，保持 Floquet 谱及细致平衡性质。

## 2. 循环预解式

设 $A_1,\ldots,A_K$ 均为不可约 Metzler 矩阵，$K\ge2$。环境沿有向环依次跳转，第 $j$ 步的实际离开速率为 $r_j>0$。状态条件一阶矩的块生成元 $\mathcal B$ 为不可约 Metzler 矩阵，其谱界即平均指数。特征方程为
$$
 ((\lambda+r_j)I-A_j)x_j=r_{j-1}x_{j-1}.
$$
在 $\lambda+r_j>s(A_j)$ 对所有 $j$ 成立的区域，令
$$
R_j(\lambda)=r_j((\lambda+r_j)I-A_j)^{-1},\qquad
\mathcal R(\lambda)=R_K(\lambda)\cdots R_1(\lambda).
$$
由正半群积分，预解式各项严格为正，且随 $\lambda$ 逐项严格下降。令 $y_j=r_jx_j$，方程为 $y_j=R_j(\lambda)y_{j-1}$。因此 $\rho(\mathcal R(\lambda))=1$ 当且仅当正 Perron 向量可沿整环传播并闭合。这等价于 $\mathcal B$ 的正特征向量，故根就是平均指数。

## 3. 精确慢系数与反方向

先把冻结矩阵归一为 $s(A_j)=0$。令 $v_j,\ell_j$ 是正左右 Perron 向量，归一为 $\ell_j^\top v_j=1$。设 $P_j=v_j\ell_j^\top$，并定义
$$
\mathcal K=\rho(P_K\cdots P_1)
=(\ell_1^\top v_K)\prod_{j<K}(\ell_{j+1}^\top v_j)>0 .
$$
取环境占时 $\alpha_j>0$、$\sum_j\alpha_j=1$，离开速率 $r_j=\omega/\alpha_j$。将 $\lambda=\omega z$ 代入预解式，把零特征值空间与补空间分解。在 $z>-\min_j1/\alpha_j$ 的任意紧区间，
$$
R_j(\omega z)=\frac{P_j}{1+\alpha_j z}+O(\omega),\qquad
\rho(\mathcal R(\omega z))=
\frac{\mathcal K}{\prod_j(1+\alpha_j z)}+O(\omega).
$$
第二式可用极限乘积的正右向量作 Collatz–Wielandt 比较。右侧极限从无穷严格降到零。令 $z_*$ 为唯一满足 $\prod_j(1+\alpha_j z_*)=\mathcal K$ 的根。先用两端点把有限速度的根夹在固定邻域内，再利用极限函数的负导数，得到
$$
\Lambda_{\rm ann}(\omega)=\omega z_*+O(\omega^2),\qquad
\operatorname{sign}z_*=\operatorname{sign}\log\mathcal K .
$$

快切换极限为 $\bar A=\sum_j\alpha_j A_j$ 的谱界。具体说，块生成元的列和与速度无关，故谱界有界。将归一到总质量一的正右向量取收敛子列，再用特征方程除以 $\omega$，得极限落在 $G^\top\otimes I$ 的核中。其各块为平稳环境质量乘共同非负向量。将原方程对环境块求和后取极限，这给出 $\bar A$ 的非负非零特征向量，所以对应特征值为 $s(\bar A)$。上述环的平稳质量正是 $\alpha_j$。

Evidence Press 正文第 5 节有限周期切换部分，对每个不可逆 $Q$ 构造任意小对角势，具有 $\mathcal K>1$。将每个冻结矩阵减去自身 Perron 根乘单位阵，仍有相同的 $\mathcal K$，且对角势随原振幅趋零。归一后的快极限严格为负。取 $u_i=\prod_jv_{j,i}^{\alpha_j}$，逐边用加权算术几何平均可得 $(\bar A u)_i/u_i\le0$。若每行均取等，不可约性使全部 $v_j$ 成比例，这会给出 $\mathcal K=1$。故至少一处严格，以 $\bar A$ 的正左向量配对可得 $s(\bar A)<0$。

因 $\mathcal K>1$，平均指数在足够小的正速度为正，慢极限为零，快极限为负。有限维谱界连续，故存在严格超过两端的内点全局最大值。该反例只用源构造的相同有限个环境态。$\square$

## 4. Erlang 时钟逼近

一般 $A_j$ 可有任意冻结谱界。其环境时间周期为一、连续驻留长度为 $\alpha_j$ 的确定性协议，在速度 $\omega$ 的 Floquet 指数为
$$
\lambda_{\rm per}(\omega)=\omega\log\rho(M(\omega)),\qquad
M(\omega)=e^{\alpha_KA_K/\omega}\cdots e^{\alpha_1A_1/\omega}.
$$
将第 $j$ 季节替换为 $N$ 个连续指数阶段，每个实际速率 $\omega N/\alpha_j$。总驻留为 Erlang 分布，均值 $\alpha_j/\omega$。块指数 $\lambda_N(\omega)$ 满足预解式乘积方程
$$
\rho\!\left(\prod_{j=K}^{1}
 \left[I+\frac{\alpha_j}{\omega N}(\lambda I-A_j)\right]^{-N}\right)=1.
$$
在 $\lambda$ 有界、$\omega$ 属于正紧区间 $I$ 时，矩阵对数展开使乘积一致等于 $e^{-\lambda/\omega}M(\omega)+O_I(N^{-1})$。用 $M(\omega)$ 连续归一的正 Perron 向量作谱比较，其分量在 $I$ 上一致有正下界，故谱半径也满足同阶误差。极限半径是 $e^{(\lambda_{\rm per}(\omega)-\lambda)/\omega}$。一致夹逼后，其斜率在固定根邻域有严格负上界。于是
$$
\sup_{\omega\in I}|\lambda_N(\omega)-\lambda_{\rm per}(\omega)|=O_I(N^{-1}).
$$
因此有限个周期速度间的严格比较可由有限 Markov 时钟保持。

## 文献

- *Reversibility and frequency reduction in periodic and random positive systems*，匿名，Evidence Press / Zenodo（2026），第 5 节有限周期切换与第 7 节平均指数。[存档](https://zenodo.org/records/23911074)。
- Ogura 和 Martin，*Stability analysis of linear systems subject to regenerative switchings*，Systems & Control Letters **75** (2015), 94–100。[预印本](https://arxiv.org/abs/1403.6764)。
- Hurtado 和 Kirosingh，*Generalizations of the ‘Linear Chain Trick’*，Journal of Mathematical Biology **79** (2019), 1831–1883。
