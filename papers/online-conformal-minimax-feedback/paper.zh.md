# 平方根走廊内，向内调节秩阈值严格改善共形预测首项

## 定理

沿用 Gui、Barber、Ma [1] 的未知分布在线共形和最近精确预言机损失。固定 $0<\alpha<1$，$\sigma^2=\alpha(1-\alpha)$，边界 $L_t=c_-t^{1-\beta_-},U_t=c_+t^{1-\beta_+}$，其中 $c_\pm>0,c_-+c_+\ge1$，$\min(\beta_-,\beta_+)=1/2$。记

$$
a=-\lim_{t\to\infty} L_t/\sqrt t,\quad b=\lim_{t\to\infty} U_t/\sqrt t,\quad
m=(a+b)/2,\quad C=b-a>0.
$$

对固定 $\theta\ge0$，给定截至 $t-1$ 的居中漏报数 $E_{t-1}$，置

$$
u_\theta(x)=-\theta(x-m),\qquad
k_t=\operatorname{clip}_{[0,t]}
\left(\operatorname{round}\big[\alpha t+\sqrt t\,u_\theta(E_{t-1}/\sqrt t)\big]\right).
$$

每轮先计算原始动作，拟排除评分最高的 $k_t$ 个插入秩。若下一轮某个漏报位不满足走廊，改用全空间或空集使输出位可行。这个规则对每条路径可行，且不依赖数据分布。令 $R_T(\theta)$ 为与最近精确预言机的期望累计分歧，令 $G(v)=\mathbb E|\sigma Z-v|$、$Z\sim N(0,1)$。则风险对原文全部 i.i.d. 无原子评分分布相同，且

$$
\lim_{T\to\infty}\frac{R_T(\theta)}{\sqrt T}
= \mathcal L(\theta)
:=2\int_a^b G(u_\theta(x))f_\theta(x)\,dx
+\sigma^2[f_\theta(a)+f_\theta(b)].
$$

其中

$$
f_\theta(x)=
\frac{e^{-\{x^2/2+\theta(x-m)^2\}/\sigma^2}}
     {\int_a^b e^{-\{y^2/2+\theta(y-m)^2\}/\sigma^2}\,dy}.
$$

特别地，存在 $\theta>0$ 使 $\mathcal L(\theta)<\mathcal L(0)$。结论严格改善 [1] 截断 split-conformal 规则在临界区间的首项。该规则对应把 $\theta=0$ 的最近整数动作替换为下取整；以下论证只用舍入误差至多一位，故两者系数相同。

## 1. 精确成本与状态转移

给定过去评分的秩排列，插入秩在 $1,\ldots,t$ 上独立均匀。若实际动作选择排除 $k$ 个秩，给定整个数据过去的漏报概率是过去评分概率变换后相应的 $k$ 个间距之和。间距在单位单纯形上均匀，故在给定秩排列时该和与第 $k$ 个过去顺序统计量同分布。由 [1] 引理 D.1 的最近预言机修复和引理 D.2 证明第一步的二项计数恒等式，平均阶段损失为

$$
\psi_t(k)=t^{-1}\mathbb E|\operatorname{Bin}(t,\alpha)-k|.
$$

第 $t$ 轮的合法计数区间端点是 $\lceil\alpha t-L_t\rceil$ 和 $\lfloor\alpha t+U_t\rfloor$，截断恰等于把“上一次计数加上新原始漏报位”投影到该区间。理由是原计数可行、两边非减且宽度至少一，至多一个二进制增量被排除。共享独立的 $V_t\sim U(0,1)$，可把原始漏报位写为 $B^0_t=\mathbf1\{V_t\le p_t\}$，其中 $p_t=k_t/t$。截断后的位记为 $A_t$。

固定 $t$，$p_t$ 随上一轮计数非增，因为 $u_\theta$ 非增且约定单调舍入。两个从不同合法计数出发的路径使用同一 $V_t$ 时，原始提议位按相反顺序排列。若两计数不同，它们至少相差 1，因此提议的两个计数仍保序且差不增加。共同投影进一步不扩张。若从同一计数出发，之后相同。从 $r=\lfloor\varepsilon T\rfloor$ 重启于最接近 $\alpha r$ 的合法整数，末轮原过程与重启过程的计数差因而是 $O(\sqrt{\varepsilon T}+1)$。

## 2. 归一化状态的极限

固定 $\varepsilon>0$。在 $[\varepsilon T,T]$ 的重启过程中写

$$
B_t^0-\alpha=(B_t^0-p_t)+(p_t-\alpha),\qquad
p_t-\alpha=t^{-1/2}u_\theta(E_{t-1}/\sqrt t)+O(1/t).
$$

第二个误差对所有可行状态一致。令 $B_t=\mathbf1\{V_t\le\alpha\}$。噪声之差 $\xi_t=B_t^0-p_t-(B_t-\alpha)$ 是鞅差，条件二阶矩至多 $|p_t-\alpha|=O(t^{-1/2})$。Doob 不等式给出在该时间区间内，$\sum\xi_t$ 的最大绝对偏差除以 $\sqrt T$ 的均方为 $O(T^{-1/2})$。因此可以用与起始历史独立的 Bernoulli($\alpha$) 随机游走替代这一噪声部分。

用物理时间 $s=t/T$、状态 $x=E_t/\sqrt T$。计数上下界中的取整误差除以 $\sqrt T$ 一致消失，两个边界趋于 $a\sqrt s,b\sqrt s$，带宽在 $[\varepsilon,1]$ 上严格正。时间变化的 Skorokhod 映射在输入路径及两边界上一致拓扑连续，[2] Theorem 2.6；对步函数正好给出离散投影，[2] Proposition 2.9 和式 (2.12)。输出对输入路径在同边界下具有一致范数 Lipschitz 界，这也可从其显式 sup–inf 公式直接读出。

有界区间上，漂移 $u_\theta(x/\sqrt s)/\sqrt s$ 对状态在 $s\in[\varepsilon,1]$ 一致 Lipschitz。结合 Donsker 定理和 Riemann 和，在 Skorokhod 输出上用 Grönwall 不等式，可把离散漂移方程传到连续。更明确地，将重启过程写成映射作用于初值、噪声和漂移离散积分之和。在使噪声路径一致收敛的表示上，与连续积分方程比较，映射的统一误差受输入初值、噪声、边界和确定性离散误差控制，再加常数乘历时状态误差的积分。Grönwall 消去后一项。由此收敛到反射扩散

$$
dX_s=\sigma\,dW_s+s^{-1/2}u_\theta(X_s/\sqrt s)\,ds+
dK^-_s-dK^+_s,\qquad a\sqrt s\le X_s\le b\sqrt s.
$$

令 $\tau=\log(s/\varepsilon)$、$Y_\tau=X_s/\sqrt s$，Itô 公式和时间变换给出固定区间 $[a,b]$ 内的反射扩散。漂移是 $u_\theta(y)-y/2$，扩散系数是 $\sigma$。边界项只在对应端点增长。零概率通量说明其不变密度为 $f_\theta$。共享同一布朗噪声时，两个解之差平方的反射项非正，漂移使差的绝对值按 $e^{-(\theta+1/2)\tau}$ 衰减。故当 $\varepsilon\downarrow0$，终点分布收敛到 $f_\theta$。第一节的离散重启比较将结果传给真实过程。于是原过程 $E_T/\sqrt T$ 依分布收敛到 $f_\theta$，并且由于均匀有界，其有界连续矩随之收敛。

## 3. 截断纠正的首项

记 $D_t=L_t+U_t$，$m_t=(U_t-L_t)/2$，$\rho_t=m_t-m_{t-1}$，$H_t=E_t-m_t$，$h_t=\mathbb E H_t^2$，$d_t=P(A_t\ne B_t^0)$。由二进制平方差公式，令 $q_t=2(E_{t-1}-m_t)+1-2\alpha$，有

$$
h_t-h_{t-1}
=\sigma^2-2\rho_t\mathbb E H_{t-1}+\rho_t^2
+\mathbb E[q_t(p_t-\alpha)]-D_t d_t+\eta_t,
\qquad |\eta_t|\le d_t.
$$

在有改动的上边界，$q_t>D_t-1$ 且 $A_t-B_t^0=-1$；下边界，$q_t<-D_t+1$ 且 $A_t-B_t^0=1$。由于前一轮也处于新走廊内，$|q_t|\le D_t+1$。这些界给出 $\eta_t$ 的估计。

其余右端项有统一上界，因为 $|H_{t-1}|=O(\sqrt t)$、$\rho_t=O(t^{-1/2})$、$|p_t-\alpha|=O(t^{-1/2})$。将式子除以 $D_t-1$，从它为正的固定时刻求和。倒数非增，势函数的分部求和总量有固定下界。因此 $\sum_{t\le T}d_t=O(\sqrt T)$。从而 $\sum_{t\le T}d_t/D_t=O(\log T)$，可按二进区间逐块估算。

记 $\mu=\int x f_\theta(x)\,dx$，$v=\int(x-m)^2 f_\theta(x)\,dx$。状态极限给出 $h_t/t\to v$，各边界的幂函数还给出 $D_t\sim C\sqrt t$，$D_{t+1}-D_t\sim C/(2\sqrt t)$，$\sqrt t\,\rho_t\to m/2$。因此从精确势函数式按 $1/D_t$ 加权求和，使用与已知分布基准同样的分部求和，有

$$
\lim_{T\to\infty} T^{-1/2}\sum_{t\le T}d_t
=\frac2C\left(\sigma^2-m(\mu-m)-v+
2\int_a^b(x-m)u_\theta(x)f_\theta(x)\,dx\right).
$$

例如势函数差的一项为 $h_T/D_T+\sum_{t<T}(1/D_t-1/D_{t+1})h_t\sim 2v\sqrt T/C$；单步的漂移项收敛至 $2\int(x-m)u_\theta f_\theta$，故加权后贡献其两倍除以 $C$。由

$$
\sigma^2 f'_\theta(x)=(2u_\theta(x)-x)f_\theta(x)
$$

对 $(x-m)f_\theta(x)$ 积分，上式的极限化为 $\sigma^2[f_\theta(a)+f_\theta(b)]$。

## 4. 完整风险和严格改进

实际未触发时阶段成本为 $\psi_t(k_t)$。触发上边界时强制 $k=0$，成本 $\psi_t(0)=\alpha$，它与原始位纠正概率 $p_t$ 相差 $O(t^{-1/2})$；下边界的对应差同样有界。背景成本 $\psi_t(k_t)=O(t^{-1/2})$。每次触发时被纠正的条件概率，对大 $t$ 至少 $\min(\alpha,1-\alpha)/2$。因此从实际风险减去“背景成本加期望纠正数”，其差累加后绝对值为 $O(\log T)$。由二项一阶 Wasserstein 中心极限定理，$\sqrt t\,\psi_t(k_t)=G(u_\theta(E_{t-1}/\sqrt t))+o(1)$，误差在可行状态上一致。状态极限和 $\sum_{t\le T}t^{-1/2}\sim2\sqrt T$ 给出书面表达的背景首项。两项相加得到 $\mathcal L(\theta)$。

在 $\theta=0$，$G'(0)=0$，且 $f_\theta$ 都归一化为一。因此背景项对 $\theta$ 的一阶导数为零。反射项的导数为

$$
[f_0(a)+f_0(b)]\left[
\int_a^b(x-m)^2f_0(x)\,dx-\frac{(b-a)^2}{4}
\right]<0,
$$

因为在区间内部严格不达端点平方距离。由此对足够小的正 $\theta$ 有严格改进。此结论给出原未知分布极小极大值的新上界，但尚未一般确定最优反馈或者极小极大首项。

## 来源

1. Yu Gui、Rina Foygel Barber、Cong Ma, [The cost of enforcing long-run coverage: a phase transition in online conformal prediction](https://arxiv.org/pdf/2611.21542v1), §§1.4、2.2，附录 D。
2. Krzysztof Burdzy、Weining Kang、Kavita Ramanan, [The Skorokhod problem in a time-dependent interval](https://arxiv.org/pdf/0712.2863), Theorem 2.6, Proposition 2.9。
