# The critical Kullback--Leibler window

## Statement and notation

Let $P$ and $Q$ be distinct, strictly positive probability distributions on a finite alphabet. In this section we use the log-likelihood ratio

$$
Z=\log\frac{P(X)}{Q(X)},
\qquad X\sim P.
$$

Thus $Z=-Y$ if $Y=\log(Q/P)$ is used elsewhere. Define

$$
D=\mathbb E_P Z=D(P\|Q)>0,
\qquad
\sigma^2=\operatorname{Var}_P(Z)>0,
\qquad
S_n=\sum_{i=1}^{n}Z_i,
$$

where the $Z_i$ are independent copies of $Z$. The variance is positive because a constant log-likelihood ratio, together with normalization, would force $P=Q$.

Fix $\zeta\in\mathbb R$, and set

$$
b_n=\exp\bigl(nD+\zeta\sigma\sqrt n\bigr),
\qquad
\alpha_n=1+b_n.
$$

For $U>0$, write

$$
c(U)=e^U-1,
\qquad
A_n(U)=\mathbb E_P\left[(1+c(U)e^{-S_n})^{-b_n}\right],
\qquad
K_n(U)=-\log A_n(U),
\qquad
G_n(U)=\frac{K_n(U)}{b_nU}.
$$

Let $\Phi$ and $\phi$ denote the standard normal distribution function and density, respectively. Then

$$
\lim_{n\to\infty}b_n\sigma\sqrt n\inf_{U>0}G_n(U)
=\kappa(\zeta),
\qquad
\kappa(\zeta)=\min_{t>0}\frac{-\log\Phi(-\zeta-t)}{t}.
$$

The limiting objective has a unique minimizer $t_\zeta$. Every sequence of exact minimizers $U_n$, and every sequence satisfying

$$
b_n\sigma\sqrt n
\left(G_n(U_n)-\inf_{U>0}G_n(U)\right)\longrightarrow0,
$$

obeys

$$
\frac{U_n}{\sigma\sqrt n}\longrightarrow t_\zeta.
$$

For a finite, strictly positive binary-input symmetric-output channel $W$ with rows $P,Q$, the support and antipodal reductions identify the optimized binary-mixture gap with the tensor-power contraction deficit. Consequently,

$$
b_n\sigma\sqrt n
\left[1-\eta_{\alpha_n}\left(W^{\otimes n}\right)\right]
\longrightarrow\kappa(\zeta).
$$

No nonlattice assumption is required: the same critical-window law holds for lattice and nonlattice log-likelihood ratios. At $\zeta=0$, numerical evaluation gives

$$
t_0\approx1.330695845160533,
\qquad
\kappa(0)\approx1.7959308448.
$$

## Uniform convergence on compact intervals

Define

$$
X_n=\frac{S_n-nD}{\sigma\sqrt n},
\qquad
U=t\sigma\sqrt n.
$$

Fix $0<t_-<t_+<\infty$ and $\varepsilon>0$. For $t\in[t_-,t_+]$, consider the random kernel

$$
k_n(X_n,t)=\left(1+c(U)e^{-S_n}\right)^{-b_n}.
$$

On the event $X_n\ge\zeta+t+\varepsilon$,

$$
b_nc(U)e^{-S_n}
\le e^{-\varepsilon\sigma\sqrt n}.
$$

The inequalities $\log(1+x)\le x$ and $e^{-x}\ge1-x$ therefore imply

$$
k_n(X_n,t)\ge1-e^{-\varepsilon\sigma\sqrt n}.
$$

On the event $X_n\le\zeta+t-\varepsilon$, for all sufficiently large $n$, uniformly over the stated interval of $t$,

$$
b_nc(U)e^{-S_n}
\ge\frac12e^{\varepsilon\sigma\sqrt n}.
$$

For every $b>0$ and $x\ge0$,

$$
b\log(1+x)\ge\min\left\{\frac{bx}{2},\,b\log2\right\}.
$$

It follows that, on this second event,

$$
k_n(X_n,t)
\le
\exp\left[-\min\left\{
\frac14e^{\varepsilon\sigma\sqrt n},\,b_n\log2
\right\}\right].
$$

Both errors tend to zero uniformly in $t\in[t_-,t_+]$. The central limit theorem and continuity of $\Phi$ give

$$
\sup_{x\in\mathbb R}
\left|\mathbb P(X_n\le x)-\Phi(x)\right|\longrightarrow0.
$$

Sandwiching the expectation of the kernel between the normal-tail approximations at $\zeta+t+\varepsilon$ and $\zeta+t-\varepsilon$, and then letting $\varepsilon\downarrow0$, yields

$$
\sup_{t\in[t_-,t_+]}
\left|A_n(t\sigma\sqrt n)-\Phi(-\zeta-t)\right|
\longrightarrow0.
$$

The limit is bounded away from zero on this compact interval. Applying $-\log$ and dividing by $t$ thus preserves uniform convergence:

$$
\sup_{t\in[t_-,t_+]}
\left|
\frac{K_n(t\sigma\sqrt n)}{t}
-\frac{-\log\Phi(-\zeta-t)}{t}
\right|\longrightarrow0.
$$

## Excluding the small-$U$ boundary

For fixed $n$, regard the logarithmic transform as a function of $c\ge0$:

$$
\mathcal K_n(c)
=-\log\mathbb E_P\left[(1+cR)^{-b_n}\right],
\qquad R=e^{-S_n}>0.
$$

Thus $K_n(U)=\mathcal K_n(c(U))$. Let $\mathbb E_c$ denote expectation under weights proportional to $(1+cR)^{-b_n}$, and put $V=R/(1+cR)$. Differentiation of the finite sum gives

$$
\mathcal K_n'(c)=b_n\mathbb E_cV>0,
$$

$$
\mathcal K_n''(c)
=-b_n\mathbb E_c(V^2)-b_n^2\operatorname{Var}_c(V)<0.
$$

Hence $\mathcal K_n$ is increasing and concave, with $\mathcal K_n(0)=0$. At $U=1$, the same threshold argument, now with $\log c(U)=O(1)$, gives

$$
K_n(1)\longrightarrow k_\zeta:=-\log\Phi(-\zeta)>0.
$$

For $0<U\le1$, concavity and $c(U)\ge U$ imply

$$
\frac{K_n(U)}{U}
\ge\frac{K_n(1)}{e-1}.
$$

Therefore $\sigma\sqrt n K_n(U)/U$ diverges uniformly on this interval. If $1<U=o(\sqrt n)$, monotonicity instead gives

$$
\sigma\sqrt n\frac{K_n(U)}{U}
\ge\sigma\sqrt n\frac{K_n(1)}{U}
\longrightarrow\infty.
$$

These two bounds exclude every sequence with $U/\sqrt n\to0$, including sequences for which $U$ tends to zero exponentially or faster.

## Excluding the large-$U$ boundary

Let

$$
z_{\min}=\min Z,
\qquad M=\max Z,
\qquad R_Z=M-z_{\min}>0,
$$

and fix $C>2M+2$. For $U\ge1$, split the expectation at

$$
H_n(U)=\log b_n+\log c(U)-\frac U2.
$$

If $S_n<H_n(U)$, then $b_nc(U)e^{-S_n}\ge e^{U/2}$. The elementary logarithmic bound used above gives

$$
A_n(U)
\le\mathbb P\left(S_n\ge H_n(U)\right)
+\exp\left[-\min\left\{\frac12e^{U/2},\,b_n\log2\right\}\right].
$$

Suppose $U/\sqrt n\to\infty$ and $U\le Cn$. Since $\zeta$ is fixed and

$$
\log c(U)=U+\log(1-e^{-U}),
$$

eventually $H_n(U)\ge nD+U/3$. Hoeffding's inequality yields

$$
\mathbb P\left(S_n\ge H_n(U)\right)
\le\exp\left(-\frac{2U^2}{9nR_Z^2}\right).
$$

Along every such sequence, the second term in the bound for $A_n(U)$ is eventually smaller than this quantity: $b_n$ grows exponentially in $n$, $e^{U/2}$ grows faster than every polynomial, and $U^2/n\le C^2n$. With $k=2/(9R_Z^2)$, it follows that

$$
K_n(U)\ge\frac{kU^2}{n}-\log2,
$$

and hence

$$
\sigma\sqrt n\frac{K_n(U)}{U}
\ge
\frac{k\sigma U}{\sqrt n}
-\frac{\sigma\sqrt n\log2}{U}
\longrightarrow\infty.
$$

For $U>Cn$, use the pointwise bound $S_n\le nM$. Since $\log c(U)\ge U-\log2$ for $U\ge\log2$, for all sufficiently large $n$,

$$
b_n\log\left(1+c(U)e^{-S_n}\right)
\ge b_n\bigl[\log c(U)-nM\bigr]
\ge\frac{b_nU}{2}.
$$

Thus $K_n(U)\ge b_nU/2$, and the normalized objective is at least $b_n\sigma\sqrt n/2\to\infty$. This covers arbitrarily fast growth of $U$.

## Convergence of minima and optimizers

For each fixed $n$, the normalized objective

$$
b_n\sigma\sqrt n\,G_n(U)
=\sigma\sqrt n\frac{K_n(U)}{U}
$$

is continuous for $U>0$ and tends to $b_n\sigma\sqrt n$ at both endpoints. At $U\downarrow0$, this uses $\mathbb E_Pe^{-S_n}=1$; at $U\to\infty$, it follows from the finite positive alphabet.

A fixed comparison point $U=t\sigma\sqrt n$ gives a bounded normalized value for all sufficiently large $n$. The two boundary exclusions show that every minimizing or asymptotically minimizing sequence remains in a compact subset of the rescaled variable $t=U/(\sigma\sqrt n)$. Uniform convergence on compact sets therefore proves convergence of the minima and convergence of optimizers to the limiting minimizer set.

## Uniqueness of the limiting optimizer

Write

$$
h(x)=-\log\Phi(-x),
\qquad
\lambda(x)=\frac{\phi(x)}{\Phi(-x)}.
$$

Then

$$
h'(x)=\lambda(x)>0,
\qquad
h''(x)=\lambda(x)\bigl[\lambda(x)-x\bigr]>0.
$$

For $x\le0$, the last inequality is immediate. For $x>0$,

$$
\Phi(-x)=\int_x^\infty\phi(u)\,du
<\frac1x\int_x^\infty u\phi(u)\,du
=\frac{\phi(x)}{x},
$$

so $\lambda(x)>x$. The derivative of $h(\zeta+t)/t$ has numerator

$$
N(t)=t\,h'(\zeta+t)-h(\zeta+t),
\qquad
N'(t)=t\,h''(\zeta+t)>0.
$$

As $t\downarrow0$, $N(t)\to-h(\zeta)<0$. The Gaussian Chernoff bound gives $h(x)\ge x^2/2$ for $x\ge0$, so $h(\zeta+t)/t\to\infty$ as $t\to\infty$. Its strictly increasing derivative numerator cannot remain nonpositive. Therefore $N$ has exactly one zero $t_\zeta$, which is the unique minimizer. It is characterized by

$$
t_\zeta
\frac{\phi(\zeta+t_\zeta)}{\Phi(-\zeta-t_\zeta)}
=-\log\Phi(-\zeta-t_\zeta).
$$

The theorem is for fixed $\zeta\in\mathbb R$; it makes no uniform assertion for unbounded $\zeta$.
