# 留一对偶的闭包效应与近单位间隙

*上半连续包络、精确可数反例与分块放大*

## 1. 连续乘子的闭包性质

令 $\mathcal N_n$ 为 $[0,\infty)^n$ 上满足每个 $E[X_i\mid X_{-i}]\le1$ 的联合分布。对有界 Borel 收益 $f$，记 $v(f)=\sup_{P\in\mathcal N_n}E_P f$。令
$$
D_c(f)=\inf_{\lambda_i\in C_b,\ \lambda_i\ge0}
 \sup_x\left[f(x)-\sum_i\lambda_i(x_{-i})(x_i-1)\right],
$$
并令 $D_b$ 使用有界非负 Borel 乘子。条件期望约束给出弱对偶 $v(f)\le D_b(f)\le D_c(f)$。

记 $f^\star(x)=\lim_{\delta\downarrow0}\sup_{\|y-x\|<\delta}f(y)$ 为上半连续包络。对任意连续函数 $g$，有 $\sup(f-g)=\sup(f^\star-g)$，因为可取趋于 $x$ 的点使其收益达到包络极限，并用 $g$ 的连续性。配套强对偶的定理 1 适用于有界上半连续收益，故
$$
D_c(f)=v(f^\star),\qquad D_c(R)=v(\overline R).
$$
第二式将集合代入其指示函数。这给出连续乘子对一般 Borel 收益的精确含义。

## 2. 低维精确反例

令 $a>1$，$S_1=\{a+1/(2j):j\ge1\}$，$S_2=\{a+1/(2j+1):j\ge1\}$。
取可数集合
$$
 R=(S_1\times\{0\})\cup(\{0\}\times S_1)\cup(S_2\times S_2).
$$
它满足
$$
v(R)=D_b(R)=v_a=\frac{2}{a+1},\qquad
D_c(R)=w_a=\frac2a-\frac1{a^2}.
$$
故间隙为 $(a-1)/[a^2(a+1)]$，在 $a=2$ 时为 $1/12$。

对每个坐标按不在 $S_1\cup S_2$、在 $S_1$、在 $S_2$ 分为 $0,1,2$ 标号。令 $L(0)=1/(a+1)$、$L(1)=0$、$L(2)=1$，两个乘子均是另一坐标标号的 $L$ 值。在证书右端 $v_a+\lambda_1(y)(x-1)+\lambda_2(x)(y-1)$ 中，将零类坐标降为零、其他类降为 $a$，保持乘子不动。得到逐点下界表
$$
\begin{pmatrix}
0&1&0\\
1&v_a&v_a+a-1\\
0&v_a+a-1&v_a+2(a-1)
\end{pmatrix}.
$$
所有项非负，拒绝对应的 $(1,0),(0,1),(2,2)$ 项至少为一，得到证书。反向取 $u\in S_1$，在 $(0,0),(u,0),(0,u)$ 放置质量 $(u-1)/(u+1),1/(u+1),1/(u+1)$。给定另一坐标为零时条件均值为一，其余为零。该族的拒绝概率趋于 $2/(a+1)$。

闭包仍在 $\{\max(x,y)\ge a\}$ 内，并含 $(a,0),(0,a),(a,a)$。记 $b=1-1/a$、$d(t)=(1-t/a)_+$，则
$$
b^2-d(x)d(y)=b[b-d(x)]+d(x)[b-d(y)]
 \le (b/a)(x-1)+(d(x)/a)(y-1).
$$
结合 $\mathbf1_{\{\max(x,y)\ge a\}}\le1-d(x)d(y)$ 得上界 $1-b^2=w_a$。两个坐标各以 $1/a$ 的概率独立取 $a$，其余取零，即在闭包上达到该值。

## 3. 仍可数的近单位间隙

把 $2k$ 个坐标分成 $k$ 对，令 $H=R\cup\{(0,0)\}$。定义可数事件 $R_{k,m}$：每对落在 $H$，且至少 $m$ 对落在 $R$。记 $T_{k,m}(p)=P(\mathrm{Bin}(k,p)\ge m)$。那么
$$
v(R_{k,m})=D_b(R_{k,m})=T_{k,m}(v_a),\qquad
D_c(R_{k,m})=T_{k,m}(w_a).
$$

令 $Y_j$ 为第 $j$ 对落在 $R$ 的指示，$B_j=\sum_{i\le j}Y_i$。定义 $H_j(s)=P(\mathrm{Bin}(k-j,v_a)\ge m-s)$。二项递推给出
$$
H_j(B_j)-H_{j-1}(B_{j-1})
=(Y_j-v_a)[H_j(B_{j-1}+1)-H_j(B_{j-1})].
$$
括号非负，仅依赖更早的坐标对。用它乘上该对的证书，得到的每个乘子仍仅依赖本坐标以外的坐标，而且有界可测。求和得到分块计数证书，亦适用于要求各对皆在 $H$ 的事件。取独立的三点对分布逼近 $v_a$，则事件的概率趋于 $T_{k,m}(v_a)$。所以原问题和 Borel 对偶达到同一数值。

闭包可写为有限个乘积的并。每个乘积选择 $m$ 对在 $\overline R$，其余在 $\overline H$。用闭包单对证书重复递推，再用独立的闭包最优对分布达到下界，得到闭包的精确值 $T_{k,m}(w_a)$。

取 $m=\lceil k(v_a+w_a)/2\rceil$，二项分布两端的 Hoeffding 界给出
$$
D_c(R_{k,m})-v(R_{k,m})\ge
1-2\exp[-k(w_a-v_a)^2/2].
$$
$a=2$ 时，下界为 $1-2e^{-k/288}$。因此连续乘子对偶的间隙可在可数拒绝域上逼近一，而有界 Borel 乘子仍给出精确证书。

## 文献

- Zhu、Duchi，*Finite-sample nonparametric mean tests: Leave-one-out duality and asymptotic optimality*，arXiv:2609.05360v1，第 1.1 节与引理 2.1。[官方全文](https://arxiv.org/html/2609.05360v1)。
- 配套案例《非参数均值检验的留一强对偶》，定理 1。
