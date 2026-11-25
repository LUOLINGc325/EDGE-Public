# 实现补充：仅用整数调参的同阶估计量

本补充不修改已独立审查的 localized_upper.md。它给出一种避免对任意实数 \(\beta\)、\(\log\) 或平方根作不可靠舍入的实现。正文的符号和引理编号均指 localized_upper.md。

## 1. 简化速率

记
\[
F_\beta(Q,n)=\max\left\{Q^{-1/2},\,n^{-\beta},
 [n\log(e+Q)]^{-\beta/2}\right\}.
\tag{I1}
\]
则正文的 \(\Phi_\beta\) 满足
\[
F_\beta(Q,n)\le\Phi_\beta(Q,n)\le2^{\beta/2}F_\beta(Q,n).
\tag{I2}
\]
若 \(Q\le n^\beta\)，两者都等于 \(Q^{-1/2}\)，因为两个非参数项均不超过它。若 \(Q>n^\beta\)，则
\(Qn^{-\beta/2}>\sqrt Q\)，从而
\[
\tfrac12\log(e+Q)\le\log(e+\sqrt Q)
\le\log(e+Qn^{-\beta/2})\le\log(e+Q).
\]
第一个不等式来自 \((e+\sqrt Q)^2\ge e+Q\)，这证明 (I2)。

因此一个达到 \(C_{\beta,L}F_\beta\) 的估计量也达到原稿声明的上界。这里不另行主张下界。

## 2. 完全整数的次数选择

固定一个正整数 \(r\)，使 \(2r-1>\beta\)；正文使用的
\(r=\lfloor\beta/2\rfloor+2\) 是一种选择。实现只接收整数 \(r\)；选择该整数之后，不需要再对 \(\beta\) 作实数计算。不同 \(\beta\) 可使用相同的 \(r\)，常数允许依赖 \(\beta,r,L\)。

令
\[
n_0=256r^2,\qquad k=\operatorname{bitlength}(Q),\qquad
h=\min\{n,k\},\qquad u=\frac{\sqrt{nh}}{16r}.
\tag{I3}
\]
若 \(n<n_0\)，返回恒零估计；否则执行
\[
a=\operatorname{isqrt}\!\left(\left\lfloor\frac{nh}{256r^2}\right\rfloor\right),
\qquad
m=\begin{cases}a,&a\text{ 为奇数},\\a-1,&a\text{ 为偶数}.\end{cases}
\tag{I4}
\]
这里 isqrt 是整数平方根下取整。因为
\(\lfloor\sqrt{\lfloor x\rfloor}\rfloor=\lfloor\sqrt x\rfloor\)，所得 \(m\) 正好是不超过 \(u\) 的最大正奇数。因此
\[
u/3\le m\le u,\qquad4rm\le n-1.
\tag{I5}
\]
这比只要求 \(m\in[u/6,u]\) 的保守实数区间取整更强，而且不需要任何浮点运算或超越函数判等。

## 3. 整数替换的风险证明

设 \(H_0=\min\{n,\log(e+Q)\}\)。对整数 \(Q\ge1\)，
\[
1\le k\le1+2\log Q,\qquad
\log(e+Q)\le2k.
\tag{I6}
\]
第一式用 \(\log2\ge1/2\)。第二式用
\(Q+1\le2^k\) 和 \(e+Q\le e(1+Q)\)，所以
\(\log(e+Q)\le1+k\log2\le2k\)。
因此
\[
h\ge H_0/2,\qquad
e^{h/16}\le e^{1/16}Q^{1/8}.
\tag{I7}
\]

正文的 (L27)–(L29) 只用 \(m\le\sqrt{nh}/(16r)\)、
\(m\ge\sqrt{nh}/(48r)\) 和 \(h\ge1\)，故在这里仍然适用。偏差项不超过
\[
B_{\beta,L,r}(48r)^\beta
(nh)^{-\beta/2}
\le2^{\beta/2}B_{\beta,L,r}(48r)^\beta
\max\{n^{-\beta},[n\log(e+Q)]^{-\beta/2}\}.
\]
额外随机项不超过
\[
C_*e^{1/16}n^{-\beta/4}Q^{-3/8}.
\tag{I8}
\]
若 \(Q\le n^\beta\)，它与 \(Q^{-1/2}\) 的比值至多常数，因为
\(n^{-\beta/4}Q^{1/8}\le n^{-\beta/8}\le1\)。
若 \(Q>n^\beta\)，它与 \([n\log(e+Q)]^{-\beta/2}\) 的比值至多
\[
C_*e^{1/16}Q^{-1/8}\log(e+Q)^{\beta/2}
\le C_*e^{1/16}D_\beta,
\quad
D_\beta=e^{1/4}(4\beta/e)^{\beta/2}.
\tag{I9}
\]
最后一式以 \(t=\log Q\)、\(\log(e+Q)\le2+t\)，再最大化
\(y^{\beta/2}e^{-y/8}\) 得到。小 \(n<n_0\) 的恒零估计由
\(1\le n_0^\beta n^{-\beta}\) 覆盖。

于是这一完全整数调参估计量满足
\[
R^{\rm abs}_{Q,n}\le \widetilde C_{\beta,L,r}F_\beta(Q,n)
\le\widetilde C_{\beta,L,r}\Phi_\beta(Q,n).
\tag{I10}
\]
其系数和最终统计量均可用有理数精确计算。决策在估计为零时固定输出 \(+1\)。

## 4. 附带实现的边界

code/integer_tuning.py 实现 (I3)–(I4)，调用 code/localized_upper.py 的精确核与 Bernstein 换基，再对给定计数计算截断后的有理数估计值。计数之外没有额外数据访问。

results/integer_tuning.json 记录整数选择边界、cap、奇数约束和一个精确平局决策案例。有限检查用于验证实现与已证明公式一致，不证明连续参数风险，也不主张时间或位复杂度最优。这里没有使用浮点区间库；整数不等式直接保证所需取整范围。

