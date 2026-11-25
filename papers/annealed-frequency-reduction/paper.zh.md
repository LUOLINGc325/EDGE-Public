# 不可逆环境切换下的平均增长频率单调性

*路径相对熵转移与严格性刻画*

## 1. 定理

设 $A_1,\ldots,A_K$ 是同维数的不可约实 Metzler 矩阵，且同一个正对角相似变换可将它们全部对称化。设 $\sigma$ 为不可约有限状态连续时间 Markov 链，行生成元为 $G$。给定速度 $\omega>0$，考虑
$$
x'(t)=A_{\sigma(\omega t)}x(t).
$$
以平稳环境、正空间初值启动，记 $\mathbb E[\mathbf1^\top x(t)]$ 的长期对数增长指数为 $\Lambda_{\rm ann}(\omega)$。

**定理。** 对任意不可约 $G$，$\Lambda_{\rm ann}$ 非增。当且仅当全部 $A_k$ 共享一个严格正的特征向量和同一特征值时，它为常数，其余情形严格递减。特别地，对固定可逆生成元 $Q$ 与对角势 $D_k$ 的组合 $A_k=Q+D_k$，常数情形恰为所有 $D_k$ 相等。

结论回应 *Reversibility and frequency reduction in periodic and random positive systems*（2026）第 10 节问题 4。本文使用该稿第 7 节变动传输图部分的逐路径增长定理：在共同对称化假设下，对每个平稳遍历环境，逐路径指数 $\Lambda_{\rm que}$ 随速度非增；对于不可约有限状态 Markov 信号，不能共享正特征向量时严格递减。

## 2. 有限路径的相对熵比较

令 $s=\omega t$ 为环境时间。对区间 $[0,T]$ 的环境路径 $e$ 和固定正概率向量 $p$，写
$$
F_\omega(T,e)=\log(\mathbf1^\top U_\omega(T,0;e)p),\qquad
\omega\partial_s U_\omega(s,0;e)=A_{\sigma(s)}U_\omega(s,0;e).
$$
记原环境的路径律为 $\mathsf P_T$，初始状态服从 $G$ 的平稳律 $\pi$。这个路径律与 $\omega$ 无关。

取行分解 $A_k^\top=Q_k+\operatorname{diag}d_k$，其中 $Q_k$ 保留非对角元并使各行和为零。在联合状态 $Y=(k,i)$ 上，环境按 $G$ 自主跳转，空间按 $Q_k/\omega$ 跳转。联合初值分布为 $\pi\otimes p$。记联合生成元为 $L_\omega$，势 $V_\omega(k,i)=d_{k,i}/\omega$，从而
$$
 B_\omega=L_\omega+\operatorname{diag}V_\omega
 =G\otimes I+\omega^{-1}\operatorname{blockdiag}(A_1^\top,\ldots,A_K^\top).
$$
条件于环境路径时，空间的 Feynman–Kac 期望为 $\exp F_\omega(T,e)$，因为行前向方程转置后就是上面的列传播。Perron–Frobenius 定理给出
$$
 \lim_{T\to\infty}T^{-1}\log\mathbb E_{\mathsf P_T}e^{F_\omega(T,e)}
 =s(B_\omega)=\Lambda_{\rm ann}(\omega)/\omega=:\beta_\omega.
$$

取 $B_\omega r=\beta_\omega r$ 的正向量 $r$。其 Doob 变换
$$
\widetilde L_\omega=\operatorname{diag}(r)^{-1}(B_\omega-\beta_\omega I)
  \operatorname{diag}(r)
$$
是不可约行生成元。以其平稳分布 $\widetilde\pi$ 启动，环境边缘路径律记为 $\nu_\omega$，它平稳且遍历。逐跳率比与驻留时间密度比相乘，得到相对于参考联合路径律的密度
$$
\frac{\widetilde\pi(Y_0)}{(\pi\otimes p)(Y_0)}
 \frac{r(Y_T)}{r(Y_0)}
 \exp\!\left[\int_0^T V_\omega(Y_s)\,ds-\beta_\omega T\right].
$$
端点因子有独立于路径及 $T$ 的正上下界。对给定环境下的空间路径积分，有
$$
\log \frac{d\nu_{\omega,T}}{d\mathsf P_T}(e)
 = F_\omega(T,e)-\beta_\omega T+O_\omega(1). \tag{1}
$$
误差对路径和 $T$ 一致。对任意平稳遍历环境 $\nu$，$p$ 的严格正性使 $\mathbf1^\top U_\omega p$ 与传播矩阵范数相差固定乘因子。条件 Feynman–Kac 公式给出 $\lvert F_\omega\rvert\le T\max_{k,i}\lvert d_{k,i}\rvert/\omega$。故
$$
 T^{-1}\mathbb E_\nu F_\omega(T,e)\longrightarrow
 \Lambda^\nu_{\rm que}(\omega)/\omega .
$$

固定 $0<\omega_1<\omega_2$，令 $\nu=\nu_{\omega_2}$。式 (1) 给出相对熵率
$$
 h=\lim_{T\to\infty}T^{-1}D(\nu_T\Vert\mathsf P_T)
 =\frac{\Lambda^\nu_{\rm que}(\omega_2)-\Lambda_{\rm ann}(\omega_2)}{\omega_2}\ge0.
$$
在 $\omega_1$ 应用有限时间 Gibbs 不等式 $\log\mathbb E_{\mathsf P_T}e^{F_{\omega_1}}\ge\mathbb E_\nu F_{\omega_1}-D(\nu_T\Vert\mathsf P_T)$。令 $T\to\infty$，再对同一个平稳遍历 $\nu$ 使用逐路径的频率单调性，得到
$$
 \Lambda_{\rm ann}(\omega_1)\ge
 \Lambda^\nu_{\rm que}(\omega_1)-\omega_1h
 \ge\Lambda_{\rm ann}(\omega_2)+(\omega_2-\omega_1)h. \tag{2}
$$

## 3. 严格性与平坦情形

当 $h>0$ 时，式 (2) 已严格。若 $h=0$，取任意块长 $\Delta>0$，记 $d_\Delta$ 为 $\nu$ 在一块的相对熵，参考路径用相同的初始分布、原生成元 $G$。对长度 $N\Delta$ 使用相对熵链式法则。参考过程在给定过去后，只通过块起始状态决定下一块分布。由相对熵凸性，在 $\nu$ 下对之前的历史取条件平均只会降低每块成本。平稳性给出
$$
D(\nu_{N\Delta}\Vert \mathsf P_{N\Delta})\ge N d_\Delta.
$$
因此 $d_\Delta=0$ 对所有 $\Delta$ 成立。各有限块均由原 Markov 转移律生成，起始分布由平稳性和不可约性必为 $\pi$。故 $\nu$ 就是原环境。

若各 $A_k$ 不共享正特征向量，原环境的逐路径指数严格递减，式 (2) 的中间不等式严格。若共享 $v>0$ 且 $A_kv=c_kv$，从 $v$ 启动即可化为标量模型，其他正初值由逐点夹逼得到同一指数。逐路径指数为 $\sum_k\pi_k c_k$，平均指数为 $\omega G+\operatorname{diag}c$ 的谱界。若 $c_k$ 相同，指数为该常数。否则取此矩阵的正右 Perron 向量 $z$，有
$$
\Lambda_{\rm ann}(\omega)-\sum_k\pi_kc_k
 =\omega\sum_{k\ne l}\pi_kG_{kl}\bigl(e^{\log z_l-\log z_k}-1\bigr)>0.
$$
因为指数减一至少为其线性项，线性项求和由平稳性为零。$c$ 非常数使 $z$ 非常数，不可约性确保至少一条边严格。因此在这种情形下 $h>0$，再用式 (2) 得严格单调。最后，若 $A_k=Q+D_k$，共享同一正向量和同一特征值要求 $(D_k-D_1)v=0$，于是所有对角势相等。$\square$

## 文献

*Reversibility and frequency reduction in periodic and random positive systems*，匿名，Evidence Press / Zenodo，0.1.0-candidate，2026-11-03。第 7 节和第 10 节问题 4。[存档](https://zenodo.org/records/23911074) · [第 7 节源文](https://github.com/ipitchford/reversibility-frequency-reduction/blob/v0.1.0-candidate/sec7_random.tex)
