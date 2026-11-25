# The high-order interior regime

## Statement and notation

Let $P,Q$ be distinct, strictly positive probability distributions on a finite alphabet. Under $P$, define

$$
Y=\log\frac{Q(X)}{P(X)},
\qquad X\sim P,
\qquad
S_n=\sum_{i=1}^{n}Y_i,
$$

where the $Y_i$ are independent copies of $Y$. Write

$$
\psi(\theta)=\log\mathbb E_Pe^{\theta Y},
\qquad
D=-\psi'(0)>0,
\qquad
M=-\min Y>0,
\qquad
\ell=-\log\mathbb P_P(Y=-M)>0.
$$

Fix $r\in(D,M)$, and put $b_n=e^{nr}$. For $a>0$, let

$$
U=\log(1+a),
\qquad
A_n(a)=\mathbb E_P\left[(1+ae^{S_n})^{-b_n}\right],
\qquad
L_n(a)=-\log A_n(a).
$$

The optimized binary-mixture contraction gap is

$$
\inf_{a>0}\frac{L_n(a)}{b_n\log(1+a)}.
$$

There is a unique $\beta>0$ such that

$$
\psi(-\beta)=r\beta,
\qquad\text{equivalently}\qquad
D_{1+\beta}(P\|Q)=r.
$$

Define

$$
u_*=-\psi'(-\beta)-r.
$$

Then $0<u_*<M-r$, and

$$
\lim_{n\to\infty}\inf_{a>0}
\frac{L_n(a)}{\log(1+a)}=\beta.
$$

Every sequence of exact minimizers, and every sequence $a_n>0$ satisfying

$$
\frac{L_n(a_n)}{\log(1+a_n)}
-\inf_{a>0}\frac{L_n(a)}{\log(1+a)}
\longrightarrow0,
$$

obeys

$$
\frac{\log(1+a_n)}{n}\longrightarrow u_*.
$$

In particular, the corresponding reference mass satisfies

$$
q_n=\frac{1}{1+a_n}
=\exp\bigl[-nu_*+o(n)\bigr].
$$

The result holds for arithmetic and nonarithmetic log-likelihood ratios. For a finite, strictly positive binary-input symmetric-output channel $W$ with rows $P,Q$, the support and antipodal reductions identify the displayed infimum with

$$
b_n\left[1-\eta_{b_n+1}\left(W^{\otimes n}\right)\right].
$$

## The rate function and its tangent solution

Let

$$
I(x)=\sup_{\theta\in\mathbb R}\bigl\{\theta x-\psi(\theta)\bigr\}.
$$

On the interior of the convex hull of the support of $Y$, the rate function $I$ is smooth and strictly convex, with its unique minimum at $-D$. The function

$$
\beta\longmapsto\frac{\psi(-\beta)}{\beta},
\qquad\beta>0,
$$

is strictly increasing, since it is the secant slope from the origin of the strictly convex function $\beta\mapsto\psi(-\beta)$. Its limits at zero and infinity are $D$ and $M$, respectively. Thus the stated $\beta$ exists uniquely for every $D<r<M$.

Strict convexity also gives

$$
-\psi'(-\beta)
>\frac{\psi(-\beta)}{\beta}=r,
$$

while finite support and strict positivity imply $-\psi'(-\beta)<M$. Hence $0<u_*<M-r$.

For every $0<u\le M-r$, evaluating the Legendre transform at $-\beta$ gives

$$
I(-r-u)
\ge\beta(r+u)-\psi(-\beta)
=\beta u.
$$

Equality holds exactly when $u=u_*$. At the endpoint,

$$
I(-M)=\ell,
\qquad
\frac{\ell}{M-r}>\beta,
$$

because the unique equality point is interior. Therefore $u_*$ uniquely minimizes

$$
u\longmapsto\frac{I(-r-u)}{u},
\qquad 0<u\le M-r,
$$

without requiring differentiability of $I$ at the endpoint.

## The soft-threshold Laplace limit

Suppose $U_n/n\to u\in(0,M-r)$, with $a_n=e^{U_n}-1$. We claim that

$$
\frac{L_n(a_n)}{n}\longrightarrow I(-r-u).
$$

### Lower bound

Fix $\delta>0$ small enough that $-r-u+\delta<-D$. For all sufficiently large $n$, on the event

$$
\frac{S_n}{n}\ge-r-u+\delta,
$$

the quantity $x=a_ne^{S_n}$ satisfies $b_nx\ge e^{n\delta/2}$. Since

$$
\log(1+x)\ge\min\{x/2,\log2\},
$$

the kernel on this event is at most

$$
(1+x)^{-b_n}
\le\exp\left[-\min\left\{\frac12e^{n\delta/2},\,b_n\log2\right\}\right].
$$

Consequently,

$$
A_n(a_n)
\le\mathbb P\left(\frac{S_n}{n}<-r-u+\delta\right)
+\exp\left[-\min\left\{\frac12e^{n\delta/2},\,b_n\log2\right\}\right].
$$

The remainder is superexponentially small in $n$. The finite-alphabet Cramér upper bound therefore yields

$$
\liminf_{n\to\infty}\frac{L_n(a_n)}{n}
\ge I(-r-u+\delta).
$$

Letting $\delta\downarrow0$ proves the required lower bound.

### Upper bound

For sufficiently small $\delta>0$, the threshold $-r-u-\delta$ remains in the interior of the support interval. On the event

$$
\frac{S_n}{n}\le-r-u-\delta,
$$

we have, for all sufficiently large $n$,

$$
b_na_ne^{S_n}\le e^{-n\delta/2}.
$$

Using $\log(1+x)\le x$, the kernel is at least

$$
(1+a_ne^{S_n})^{-b_n}
\ge\exp\bigl[-e^{-n\delta/2}\bigr].
$$

Apply the Cramér lower bound to an open left interval ending just below $-r-u-\delta$. After an arbitrarily small adjustment of the interval endpoint, this gives

$$
\limsup_{n\to\infty}\frac{L_n(a_n)}{n}
\le I(-r-u-\delta).
$$

Letting $\delta\downarrow0$ proves the claimed limit. This argument uses the standard finite-alphabet large-deviation principle, which also follows from multinomial type bounds, and applies equally to arithmetic and nonarithmetic laws.

### The support endpoint

If instead $U_n/n\to M-r$, the lower-bound argument gives

$$
\liminf_{n\to\infty}\frac{L_n(a_n)}{n}\ge I(-M)=\ell.
$$

Only this endpoint lower bound is needed; no uniform equality at the endpoint is assumed.

## Concavity excludes all $U_n=o(n)$

For fixed $n$, set $X=e^{S_n}>0$. Let $\mathbb E_a$ denote expectation under weights proportional to $(1+aX)^{-b_n}$, and write $V=X/(1+aX)$. Differentiation of the finite sum gives

$$
L_n'(a)=b_n\mathbb E_aV>0,
$$

$$
L_n''(a)
=-b_n\mathbb E_a(V^2)-b_n^2\operatorname{Var}_a(V)<0.
$$

Thus $L_n$ is increasing and concave, with $L_n(0)=0$. The same soft-threshold argument at the fixed value $a=1$ yields

$$
\frac{L_n(1)}{n}\longrightarrow I(-r)>0.
$$

When $0<a\le1$, concavity gives $L_n(a)\ge aL_n(1)$, while $\log(1+a)\le a$. Hence

$$
\frac{L_n(a)}{\log(1+a)}\ge L_n(1)\longrightarrow\infty.
$$

When $a\ge1$ but $U=\log(1+a)=o(n)$, monotonicity gives

$$
\frac{L_n(a)}{U}\ge\frac{L_n(1)}{U}\longrightarrow\infty.
$$

These bounds exclude every sequence $U_n=o(n)$, including those for which $a_n$ tends to zero at an arbitrary rate.

## Finite support excludes large $U_n/n$

Since $S_n\ge-nM$ pointwise,

$$
L_n(a)\ge b_n\log(1+ae^{-nM}).
$$

For $0<c<1$, the function

$$
a\longmapsto\frac{\log(1+ca)}{\log(1+a)}
$$

is increasing. Indeed, with $U=\log(1+a)$, the numerator becomes

$$
f(U)=\log(1-c+ce^U).
$$

This function is convex and satisfies $f(0)=0$, so $f(U)/U$ is increasing for $U>0$.

Fix $\delta>0$. For every $U\ge n(M-r+\delta)$, the preceding bounds and monotonicity imply

$$
\frac{L_n(a)}{U}
\ge
\frac{b_n\log\left(1+
\left(e^{n(M-r+\delta)}-1\right)e^{-nM}\right)}
{n(M-r+\delta)}.
$$

If $0<\delta<r$, the right-hand side is asymptotic to

$$
\frac{e^{n\delta}}{n(M-r+\delta)},
$$

which diverges. If $\delta\ge r$, use any smaller positive $\delta'<r$; the same divergence holds uniformly on the original region. Thus every near-minimizing sequence with bounded objective has $U_n/n$ bounded away from zero and satisfies

$$
\frac{U_n}{n}\le M-r+o(1).
$$

## Convergence of the infimum and the optimizer

The trial sequence $U_n=nu_*$ gives

$$
\limsup_{n\to\infty}\inf_{a>0}
\frac{L_n(a)}{\log(1+a)}
\le\frac{I(-r-u_*)}{u_*}=\beta.
$$

Take any minimizing or asymptotically minimizing sequence. The preceding exclusions place every subsequential limit $u$ of $U_n/n$ in $(0,M-r]$. The soft-threshold lower bound, including its endpoint form, gives along that subsequence

$$
\liminf_{n\to\infty}\frac{L_n(a_n)}{U_n}
\ge\frac{I(-r-u)}{u}\ge\beta.
$$

Equality is possible only at $u=u_*$. Compactness therefore proves both convergence of the infimum to $\beta$ and convergence of every near-minimizing $U_n/n$ to $u_*$.
