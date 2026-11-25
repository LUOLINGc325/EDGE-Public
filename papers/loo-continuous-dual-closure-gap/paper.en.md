# Nearly unit gaps for continuous leave-one-out dual certificates

*Upper semicontinuous envelopes and exact Borel counterexamples*

## 1. Scope

For $\mathcal X=[0,\infty)^n$, let $\mathcal N_n$ be the laws with
$E[X_i\mid X_{-i}]\le1$ for each $i$, as in Zhu and Duchi (2026), §1.1. For bounded Borel $f$ set
$$
v(f)=\sup_{P\in\mathcal N_n}E_P f,\qquad
 D_c(f)=\inf_{\lambda_i\in C_b,\ \lambda_i\ge0}
    \sup_{x\in\mathcal X}\left[f(x)-\sum_i\lambda_i(x_{-i})(x_i-1)\right].
$$
Use $D_b(f)$ for the analogous infimum over bounded nonnegative Borel multipliers. For a region use $v(R)=v(\mathbf1_R)$ and the corresponding dual notation. Weak duality $v(f)\le D_b(f)\le D_c(f)$ follows from the conditional inequalities.

We prove that continuity of the multipliers forces the dual to see the upper semicontinuous envelope of the objective. We construct countable Borel rejection regions with an exact gap even in two dimensions and with gaps approaching one as the dimension grows. Every example has an explicit bounded Borel certificate attaining its true size.

## 2. The continuous dual sees closure

For bounded Borel $f$ define
$$
 f^\star(x)=\lim_{\delta\downarrow0}\sup_{\|y-x\|<\delta,\ y\in\mathcal X} f(y).
$$
This is bounded upper semicontinuous. If $g$ is continuous, then
$\sup(f-g)=\sup(f^\star-g)$: for each $x$, approach $x$ by points with $f(y)$ tending to $f^\star(x)$ and use $g(y)\to g(x)$. Thus every continuous multiplier tuple has exactly the same objective for $f$ and $f^\star$. The companion case *Strong leave-one-out duality for nonparametric mean tests*, Theorem 1, proves $D_c(g)=v(g)$ for bounded upper semicontinuous $g$ on the full orthant. Applying it to $f^\star$ gives
$$
 D_c(f)=v(f^\star),\qquad D_c(R)=v(\overline R)\quad\text{for every Borel }R.
\tag{1}
$$
For a set this uses $(\mathbf1_R)^\star=\mathbf1_{\overline R}$.

## 3. Exact two-coordinate gap

Fix $a>1$, and let
$$
 S_1=\{a+1/(2j):j\ge1\},\qquad S_2=\{a+1/(2j+1):j\ge1\}.
$$
These are disjoint countable sequences converging to $a$. Define the Borel region
$$
R=(S_1\times\{0\})\cup(\{0\}\times S_1)\cup(S_2\times S_2).
$$
Then
$$
 v(R)=D_b(R)=v_a:=\frac{2}{a+1},
 \qquad D_c(R)=w_a:=\frac{2}{a}-\frac1{a^2}.
\tag{2}
$$
Hence the gap equals $(a-1)/[a^2(a+1)]$, which equals $1/12$ at $a=2$.

To prove the upper bound for $R$, label each coordinate by $0,1,2$ according as it is outside $S_1\cup S_2$, inside $S_1$, or inside $S_2$. Put $L(0)=1/(a+1)$, $L(1)=0$, $L(2)=1$ and let $\ell(x)$ be the label. The two multipliers are $\lambda_1(y)=L(\ell(y))$ and $\lambda_2(x)=L(\ell(x))$. They are bounded and Borel. In the bracket
$$
v_a+\lambda_1(y)(x-1)+\lambda_2(x)(y-1)
$$
we may lower each actual coordinate to zero for label zero and to $a$ for either other label, keeping the multipliers fixed. The resulting pointwise lower bounds by label pair are
$$
\begin{pmatrix}
0&1&0\\
1&v_a&v_a+a-1\\
0&v_a+a-1&v_a+2(a-1)
\end{pmatrix}.
$$
Every entry is nonnegative. The membership labels $(1,0),(0,1),(2,2)$ have entries at least one, since $v_a+2(a-1)=2a^2/(a+1)>1$. This is a certificate at $v_a$.

For sharpness, take $u\in S_1$ and the feasible three-point law on $(0,0),(u,0),(0,u)$ with masses $(u-1)/(u+1),1/(u+1),1/(u+1)$. For either coordinate, its conditional mean is one when the other coordinate is zero and zero otherwise. Its rejection probability is $2/(u+1)\to v_a$ as $u\downarrow a$ through $S_1$. Thus both $v(R)$ and $D_b(R)$ equal $v_a$.

The closure $\overline R$ lies in $\{\max(x,y)\ge a\}$ and contains $(a,0),(0,a),(a,a)$. The maximum region has size $w_a$. For a direct upper bound put $d(t)=(1-t/a)_+$ and $b=1-1/a$. The indicator is bounded by $1-d(x)d(y)$, and
$$
 b^2-d(x)d(y)=b[b-d(x)]+d(x)[b-d(y)]
 \le \frac{b}{a}(x-1)+\frac{d(x)}a(y-1).
$$
These continuous multipliers certify $1-b^2=w_a$. Independent coordinates placing probability $1/a$ at $a$ and the rest at zero are feasible and attain $w_a$ already on $\overline R$. Equation (1) proves (2).

## 4. Amplification by a block count

Partition $2k$ coordinates into $k$ disjoint ordered pairs. Let $H=R\cup\{(0,0)\}$. For $1\le m\le k$ let $R_{k,m}$ be the event that all pairs lie in $H$ and at least $m$ lie in $R$. In particular $R_{k,m}$ is countable. Write $T_{k,m}(p)=\Pr\{\mathrm{Bin}(k,p)\ge m\}$. Then
$$
 v(R_{k,m})=D_b(R_{k,m})=T_{k,m}(v_a),
 \qquad D_c(R_{k,m})=T_{k,m}(w_a).
\tag{3}
$$

To show the upper bound and its certificate, use the pair indicator $Y_j$, the cumulative count $B_j=\sum_{i\le j}Y_i$, and
$$
 H_j(s)=\Pr\{\mathrm{Bin}(k-j,v_a)\ge m-s\},\qquad j=0,\ldots,k.
$$
The function $H_j$ is nondecreasing in $s$, and the binomial recursion gives
$$
H_j(B_j)-H_{j-1}(B_{j-1})
=(Y_j-v_a)\,[H_j(B_{j-1}+1)-H_j(B_{j-1})].
\tag{4}
$$
The bracket is nonnegative and depends only on earlier pairs. Multiply the pair certificate by this bracket. Each resulting multiplier on a coordinate depends only on the other coordinate in its pair and the earlier pairs, so it is a valid bounded Borel leave-one-out multiplier. Sum (4) to get a certificate at $H_0(0)=T_{k,m}(v_a)$ for the block count, and hence for the smaller event requiring all pairs in $H$. For sharpness, take independent copies of the feasible three-point pair laws tending to size $v_a$. They satisfy the full conditional constraints. The binomial tail is continuous in its parameter, proving the first equality in (3).

The closure of $R_{k,m}$ is the event that all pairs lie in $\overline H$ and at least $m$ lie in $\overline R$. This follows by expressing it as a finite union of products of $m$ copies of $R$ with $k-m$ copies of $H$. Apply the same recursion using the pair certificate at $w_a$ for $\overline R$, and use independent pair extremizers of size $w_a$. The closure therefore has size $T_{k,m}(w_a)$, so (1) gives the last equality in (3).

Taking $m=\lceil k(v_a+w_a)/2\rceil$ and using the two one-sided Hoeffding bounds yields
$$
 D_c(R_{k,m})-v(R_{k,m})
 \ge 1-2\exp[-k(w_a-v_a)^2/2].
$$
In particular $a=2$ gives a gap at least $1-2e^{-k/288}$. Thus the supremum of the gap over dimensions and Borel events is one, even among countable examples with an exact bounded measurable certificate.

## References

- Y. Zhu and J. C. Duchi, *Finite-sample nonparametric mean tests: Leave-one-out duality and asymptotic optimality*, arXiv:2609.05360v1, §1.1 and Lemma 2.1. [Official full text](https://arxiv.org/html/2609.05360v1).
- *Strong leave-one-out duality for nonparametric mean tests*, Theorem 1. [Companion case](../leave-one-out-mean-strong-duality/paper.zh.md).
