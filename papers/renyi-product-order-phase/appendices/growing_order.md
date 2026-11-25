# Proof B: Exponentially growing orders below KL

## 1. Hypotheses and result

For the main theorem, let $P,Q$ be distinct positive probability laws on a finite set,
and assume an output involution interchanges $P$ and $Q$. Section 9 states the
separate nonsymmetric extension. Write

$$
 Y(y)=\log\frac{Q(y)}{P(y)},\qquad
 \psi(\theta)=\log\sum_yP(y)^{1-\theta}Q(y)^\theta.
$$

For the symmetric-channel case, an involution interchanges $P,Q$, so $\psi(\theta)=\psi(1-\theta)$. Let $D=D(P\|Q)>0$. Fix a growth rate

$$
 0<r<D,
$$

and define $b_n=e^{nr}$, $\alpha_n=1+b_n$. There is a unique $\theta=\theta_r\in(0,\tfrac12)$ with $\psi'(\theta)=-r$. Define

$$
 R_\theta(y)=P(y)^{1-\theta}Q(y)^\theta e^{-\psi(\theta)},
 \quad \sigma_r^2=\psi''(\theta)>0,
$$
$$
 I_r=-\theta r-\psi(\theta)>0,
 \quad J_r=r+I_r.
$$

Assume the law of $Y$ is nonarithmetic, meaning its support is not contained in an affine lattice. Under $R_\theta$ its support is the same, hence it is still nonarithmetic.

For $S_n=\sum_{i=1}^nY_i$ define

$$
 A_n(a)=\mathbb E_{P^n}(1+a e^{S_n})^{-b_n},\quad
 B_n(a)=1-A_n(a),\quad
 F_n(a)=\frac{-\log A_n(a)}{b_n\log(1+a)}.
$$

**Theorem.** Every $F_n$ attains its minimum in $(0,\infty)$. Let $a_n$ be any minimizing sequence (or an approximate minimizer with rescaled additive error $o(1)$). Then $a_n\to a_\theta$, where $a_\theta$ is the unique positive root

$$
 \theta(1+a_\theta)\log(1+a_\theta)=a_\theta.
$$

Equivalently $q_n=1/(1+a_n)$ converges to the unique interior $q_\theta$ satisfying

$$
 -\theta\log q_\theta=1-q_\theta.
$$

The exact first-order strong asymptotic is

$$
 \inf_{a>0}F_n(a)
 =\frac{e^{-nJ_r}}{\sqrt n}\left[
 \frac{\Gamma(1-\theta_r)}
 {\theta_r\sigma_r\sqrt{2\pi}}
 \frac{a_{\theta_r}^{\theta_r}}
 {\log(1+a_{\theta_r})}
 +o(1)\right].
 \tag{1.1}
$$

The proof covers all sequences $a_n$, including those exponentially or superexponentially close to either endpoint. It does not assume a fixed mixing weight before optimizing.

## 2. Existence of the saddle

On a finite positive alphabet, $\psi$ is smooth and strictly convex because its second derivative is the variance of the nonconstant $Y$ under the corresponding positive tilt. Also

$$
 \psi'(0)=-D(P\|Q)=-D<0,
 \qquad \psi'(1/2)=0
$$

in the symmetric case. Therefore the stipulated $\theta_r$ exists uniquely in $(0,\tfrac12)$. Its tilted mean is $-r$. Strict convexity gives

$$
 \psi(\theta)>\psi(0)+\theta\psi'(0),
$$

and the Legendre representation at a point $-r$ strictly above the $P$-mean shows $I_r>0$. Directly, the tangent line at $\theta$ lies strictly below $\psi(0)=0$:

$$
 0>\psi(\theta)-\theta\psi'(\theta)
 =\psi(\theta)+\theta r=-I_r.
$$

All parameters $\theta_r$, $I_r$ and $\sigma_r$ are fixed with $n$. No endpoint limit $r\to0$ or $r\to D$ is included in the theorem.

## 3. Exact centered tilt and the growing-order kernel

Under $R_\theta$, put

$$
 T_n=S_n+nr=\sum_{i=1}^n(Y_i+r).
$$

The summands have mean zero and variance $\sigma_r^2$. The density identity is

$$
 \frac{dP^n}{dR_\theta^n}
 =e^{n\psi(\theta)-\theta S_n}
 =e^{-nI_r}e^{-\theta T_n}.
$$

Because $b_n=e^{nr}$, $e^{S_n}=e^{T_n}/b_n$. For $b\ge1$ and $z\ge0$ define

$$
 g_b(z)=1-(1+z/b)^{-b}.
$$

Then

$$
 B_n(a)=e^{-nI_r}\mathbb E_{R_\theta^n}
 \big[e^{-\theta T_n}g_{b_n}(a e^{T_n})\big].
 \tag{3.1}
$$

The following uniform estimates are crucial:

$$
 \frac{z}{1+z}\le g_b(z)\le\min(z,1),
 \qquad b\ge1,
 \tag{3.2}
$$

and hence

$$
 g_b(z)\ge\tfrac12\min(z,1).
 \tag{3.3}
$$

For the lower bound, Bernoulli's inequality for real $b\ge1$ gives $(1+z/b)^b\ge1+z$. For the upper bound, the convex function $(1+z/b)^{-b}$ lies above its tangent $1-z$ at zero. For $z$ in any compact interval, $g_b(z)\to1-e^{-z}$ uniformly as $b\to\infty$, using $b\log(1+z/b)\to z$ uniformly.

Let

$$
 \rho_n=b_n\sqrt n e^{nI_r}
 =\sqrt n e^{nJ_r}.
$$

The exact logarithmic gap obeys

$$
 \rho_nF_n(a)
 \ge\frac{\sqrt n}{\log(1+a)}
 \mathbb E_{R_\theta^n}
 \big[e^{-\theta T_n}g_{b_n}(a e^{T_n})\big],
 \tag{3.4}
$$

since $-\log(1-B_n)\ge B_n$. In particular the factor $b_n$ has completely canceled in this lower bound; ignoring this cancellation would give incorrect endpoint estimates.

## 4. Local-limit estimates

Apply the ordinary nonarithmetic interval LLT to the fixed centered summand $Y+r$ under $R_\theta$. For any fixed $D_0,E_0>0$ there are $c_0>0$ and $N$ such that

$$
 R_\theta^n\{T_n\in[x,x+1)\}\ge c_0/\sqrt n
 \tag{4.1}
$$

whenever $n\ge N$ and $|x|\le D_0\log(n+1)+E_0$. There is also a uniform bound over all $x$ of the same form with a finite upper constant $C_0$. The proof only uses these central-window consequences of Stone's theorem; no uniform large-deviation estimate is imported.

## 5. Uniform exclusion of $a\to0$

Take $a=e^{-t}$, $t\ge2$, and $x=\min(t/2,\log n)$. On $[x,x+1)$, $z=ae^s\le1$ and $\log(1+a)\le a$. By (3.3),

$$
 \frac{e^{-\theta s}g_{b_n}(a e^s)}{\log(1+a)}
 \ge\tfrac12 e^{(1-\theta)s}
 \ge\tfrac12 e^{(1-\theta)x}.
$$

Combining (3.4) and (4.1) yields the bound, uniform over $t\ge2$,

$$
 \rho_nF_n(e^{-t})
 \ge\frac{c_0}{2}
 \exp\big[(1-\theta)\min(t/2,\log n)\big].
 \tag{5.1}
$$

For $t=t_n\to\infty$ this tends to infinity. The proof includes arbitrarily rapid decay of $a_n$.

## 6. Uniform exclusion of $a\to\infty$

Write $a=e^t$ and let $M=\max_y|Y(y)|$. We use the original, uncentered log-likelihood $S_n$ for the extreme regime. This prevents an artificial loss from separately estimating the growing kernel.

### 6.1. $t\ge2nM+1$

As $|S_n|\le nM$,

$$
 A_n(e^t)=\mathbb E_P(1+e^{t+S_n})^{-b_n}
 \le e^{-b_n(t-nM)}.
$$

Thus

$$
 F_n(e^t)\ge\frac{t-nM}{\log(1+e^t)}\ge\tfrac12
 \quad(t\ge2nM+1).
 \tag{6.1}
$$

This inequality is exact for every $b_n>0$. It remains valid when $a$ is doubly exponential in $n$. In this regime the normalized gap is at least $\rho_n/2$, and therefore diverges. No comparison involving $e^{-nM}$ is needed.

### 6.2. $T_\theta\le t\le2nM+1$

Choose a fixed $T_\theta$ large enough that

$$
 t-(2/\theta)\log t-1\ge0
$$

for all $t\ge T_\theta$; such a threshold exists. Use the interval

$$
 I_t=[-(2/\theta)\log t-1,-(2/\theta)\log t).
$$

There $ae^s\ge1$, $e^{-\theta s}\ge t^2$, $g_{b_n}(ae^s)\ge\tfrac12$, and $\log(1+e^t)\le2t$ once $t\ge1$. Consequently

$$
 \frac{e^{-\theta s}g_{b_n}(e^{t+s})}{\log(1+e^t)}
 \ge t/4.
$$

Because $t\le2nM+1$, the interval center is $O(\log n)$ uniformly. Thus (4.1) applies with constants depending only on the fixed channel, $r$ and $\theta$:

$$
 \rho_nF_n(e^t)\ge c_0t/4.
 \tag{6.2}
$$

Together (6.1)-(6.2) give

$$
 \rho_nF_n(e^t)\ge\min(c_0t/4,\rho_n/2)
 \qquad(t\ge T_\theta)
 \tag{6.3}
$$

for all sufficiently large $n$. Every $t_n\to\infty$ has diverging normalized objective. This closes global coercivity at both endpoints.

## 7. Compact-uniform kernel limit and prefactor

Fix a compact interval $K=[a_-,a_+]$ in $(0,\infty)$, and put

$$
 h_{n,a}(s)=e^{-\theta s}g_{b_n}(a e^s),
 \qquad h_a(s)=e^{-\theta s}(1-e^{-a e^s}).
$$

On every compact $s$ interval, $h_{n,a}\to h_a$ uniformly jointly in $a\in K$. By (3.2), both families have the common envelope

$$
 \begin{cases}
 e^{-\theta s},&s\ge0,\\
 a_+e^{(1-\theta)s},&s<0.
 \end{cases}
$$

This envelope is summable over unit intervals since $0<\theta<1$. The uniform concentration upper bound from the LLT controls its tails uniformly after multiplication by $\sqrt n$. On compact $s$ intervals, joint uniform convergence of the kernels and the interval LLT establish convergence of the expectations. A finite $a$-net, or joint uniform continuity, makes it uniform on $K$. Therefore

$$
 \sup_{a\in K}\left|
 \sqrt n\,\mathbb E_R h_{n,a}(T_n)
 -\frac1{\sigma_r\sqrt{2\pi}}\int_{\mathbb R}h_a(s)\,ds
 \right|\longrightarrow0.
 \tag{7.1}
$$

The integral is elementary:

$$
 \int_{\mathbb R}h_a(s)\,ds
 =a^\theta\int_0^\infty u^{-\theta-1}(1-e^{-u})\,du
 =\frac{\Gamma(1-\theta)}{\theta}a^\theta.
 \tag{7.2}
$$

Integration by parts is legitimate: near zero the boundary term is $O(u^{1-\theta})$, and at infinity it is $O(u^{-\theta})$. Because $I_r>0$, (3.1) and (7.1) imply $B_n=O(e^{-nI_r}/\sqrt n)$ uniformly on $K$. Expanding $-\log(1-B_n)$ shows that its quadratic remainder contributes only $O(e^{-nI_r}/\sqrt n)$ to the normalized objective. Hence

$$
 \sup_{a\in K}|\rho_nF_n(a)-G_r(a)|\longrightarrow0,
$$
$$
 G_r(a)=\frac{\Gamma(1-\theta_r)}
 {\theta_r\sigma_r\sqrt{2\pi}}
 \frac{a^{\theta_r}}{\log(1+a)}.
 \tag{7.3}
$$

## 8. Optimization and finite-$n$ existence

For each $n$, $b_n$ is a finite positive number. Strict Jensen for $x\mapsto(1+ax)^{-b_n}$, applied to $X=e^{S_n}$ with $\mathbb E_P X=1$ and $X$ nonconstant, gives $0<F_n(a)<1$. The fixed-$n$ limits as $a\to0$ and $a\to\infty$ are both one, by the same finite-sum expansions as in the fixed-order note. Thus an interior global minimizer exists for every $n$.

Evaluating at one fixed $a$ gives a bounded sequence $\rho_n\inf F_n$. Sections 5-6 then force every optimizing or normalized-$o(1)$-approximate optimizing sequence into a fixed compact subset of $(0,\infty)$. Compact-uniform convergence (7.3) therefore permits passage of the infimum and transfers every subsequential optimizer to a minimizer of $G_r$.

For $g_\theta(a)=a^\theta/\log(1+a)$, the derivative has the sign of

$$
 u_\theta(a)=\theta(1+a)\log(1+a)-a.
$$

Now $u_\theta(0)=0$, $u_\theta'(a)=\theta\log(1+a)+\theta-1$, and $u_\theta''(a)=\theta/(1+a)>0$. Thus $u_\theta$ initially decreases, then strictly increases to infinity, with exactly one positive zero. Also $g_\theta$ tends to infinity at both endpoints. Consequently this root is the unique global minimizer, all minimizing $a_n$ converge to it, and (1.1) follows.

## 9. Nonsymmetric extension and boundaries

The same oriented-pair theorem applies to nonsymmetric $P,Q$. Let $\theta_0\in(0,1)$ be the zero of $\psi'$. For any fixed $0<r<D(P\|Q)$, the saddle $\theta_r\in(0,\theta_0)$ is defined by $\psi'(\theta_r)=-r$. Every proof above uses only $0<\theta_r<1$, finite positive support and nonarithmeticity; output symmetry only places the saddle below one half.

