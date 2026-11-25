# 固定权重上界下全零加权共形 Simes 检验的尖锐曲率

## 摘要

在共享校准样本的加权共形多重检验中，单个随机化 p 值精确服从均匀分布，但它们的联合分布可能使 Simes 检验的全零错误发现率高于名义水平。固定检验数、名义水平和权重上界后，我们证明了对所有分数分布一致的二阶展开。连续分数的最坏首项系数可通过排序区间曲率精确求出。两项检验时结论扩展到任意原子分数，并有显式最优值。

## 1. 一致展开

设 $P$、$Q$ 为校准和测试分布，其中 $dQ/dP=w/\mu$，$\mu=E_Pw$，$1\le w\le B$。令 $t_k=qk/m$，$H$ 为 Simes 拒绝概率多项式在 $\mathbf t$ 处的 Hessian。将分数 $V$ 以其 $Q$ 分布随机化为均匀秩 $T$，记 $A_s(v)=\Pr(T\le s\mid V=v)$，$x_k(v)=A_{t_k}(v)-t_k$。则
$$
\mathrm{FDR}_n
=q+\frac{E_Q[(w/\mu)x(V)^{\mathsf T}Hx(V)]}{2n}
+O_{m,q,B}\!\left(n^{-5/4}\log(en)^{3/4}\right).
$$
常数对所有满足固定权重上界的分数分布一致，包括任意原子分数。对经验加权秩函数 $J_n(s)=\sum_iw_i A_s(V_i)/\sum_iw_i$，真实 p 值与 $J_n(T)$ 相差至多 $B/n$。阈值附近以 Hoeffding 定位，再以 Bernstein 和单调性控制局部增量并夹逼条件分布函数。在均方意义下，条件分布偏差等于 $\sum_iw_i(t_k-A_{t_k}(V_i))/(n\mu)$，误差为 $O_{m,q,B}(n^{-3/4}\log(en)^{3/4})$。随机化加权共形 p 值的边际均匀性消去了 Simes 多项式的一阶项，二阶项由上述估计确定。

## 2. 尖锐最优值

令 $z_k(s)=\mathbf 1_{\{s\le t_k\}}-t_k$，$D(s)=z(s)^{\mathsf T}Hz(s)$，$p_+=|\{D>0\}|$。将正曲率区间按曲率降序排列，令 $A(p)$ 为前 $p$ 长度的曲率积分。连续分数模型中，最优系数为
$$
\frac{B-1}{2}\max_{0\le p\le p_+}\left[1-\left(1-\frac1B\right)p\right]A(p).
$$
在负曲率上取权重 $1$，对正曲率上的权重使用端点混合，再将较大权重分配给最高曲率区间，即可达到此最优值。一致误差允许模型随 $n$ 变化。

当 $m=2$ 时，三个区间的曲率依次为 $-2(1-q)$、$2(1-q)$、$0$。原子跨越某个阈值时，比较原子随机秩区间内曲率的平均与平均方向处的曲率。仅跨第一阈值时相等，仅跨第二阈值时用凸性；同时跨越时，令 $a,b,c$ 为区间落入三段的比例。由于中间段全部包含，$b\ge a$，于是 $2(a+b-q)(b-a)\le 2(1-q)(b-a)$。故将原子连续化不降低最优系数，且任意分数定律的尖锐系数为
$$
(B-1)(1-q)\frac q2\left[1-\left(1-\frac1B\right)\frac q2\right].
$$
三个有序分数值在 $Q$ 下取质量 $q/2,q/2,1-q$，配权重 $1,B,1$，即可取到。$q=1/2,B=2$ 时系数为 $7/64$。

## 3. 与原问题的关系

本结果解决 Lim 猜想 20 所涉及的固定上界子问题，并给出两项检验的完全最优值。权重上界与检验数同时增长的情形需要新的统一估计。英文稿给出完整证明和原子情形的额外适用范围。

## 参考文献

- Ryan Lim. *Almost Controlled: The FDR of Benjamini–Hochberg on Weighted Conformal p-Values*. arXiv:2611.21509v1. <https://arxiv.org/abs/2611.21509v1>
- Mehrdad Pournaderi. *Weighted conformal prediction under covariate shift: process limits, estimated weights and efficiency*. arXiv:2611.20052v1. <https://arxiv.org/abs/2611.20052v1>
