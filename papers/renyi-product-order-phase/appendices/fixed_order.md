# Proof A: Fixed order and global prior confinement

## 1. Statement proved

Let $P$ and $Q$ be distinct strictly positive probability distributions on a finite alphabet. In the principal symmetric case, an output involution interchanges $P$ and $Q$. Let $b=\alpha-1\ge1$, and put

$$
 Z=\sum_y\sqrt{P(y)Q(y)},\qquad C=-\log Z>0,
 \qquad R(y)=\sqrt{P(y)Q(y)}/Z,
$$
$$
 Y(y)=\log\frac{Q(y)}{P(y)},\quad
 S_n=Y_1+\cdots+Y_n,\quad
 \sigma^2=\operatorname{Var}_R(Y)>0.
$$

The involution makes the law of $Y$ under $R$ symmetric, so its mean is zero. Assume that this law is nonarithmetic: it is not supported by any affine lattice $c+h\mathbb Z$ with $h>0$. All expectations involving $S_n$ below specify whether the sampling measure is $P$ or $R$.

For $a>0$ define

$$
 A_n(a)=\mathbb E_{P^n}(1+a e^{S_n})^{-b},
 \quad B_n(a)=1-A_n(a),
 \quad F_n(a)=\frac{-\log A_n(a)}{b\log(1+a)}.
$$

The mixture notation is $a=(1-q)/q$, so $\log(1+a)=-\log q$.

**Theorem.** For every $n\ge1$, $F_n$ has an interior global minimum, and all its values lie strictly between zero and one. If $a_n$ is any choice of global minimizer, then

$$
 a_n\longrightarrow a_*=3.92155363456750509245\ldots,
 \qquad q_n\longrightarrow q_*=0.20318786997997995383\ldots,
$$

where $a_*$ is the unique positive solution of

$$
 (1+a_*)\log(1+a_*)=2a_*,
$$

equivalently $q_*$ is the unique solution in $(0,1)$ of

$$
 -\tfrac12\log q_*=1-q_*.
$$

Moreover,

$$
 \inf_{a>0}F_n(a)
 =\frac{e^{-nC}}{\sqrt n}\left[
 \frac{2\sqrt\pi\,\Gamma(b+\tfrac12)}
 {\Gamma(b+1)\,\sigma\sqrt{2\pi}}
 \frac{\sqrt{a_*}}{\log(1+a_*)}+o(1)\right].
$$

The minimizer is independent of $b$ at this leading order. The same convergence holds for asymptotically minimizing sequences whose rescaled objective differs from the infimum by $o(1)$. No finite-$n$ uniqueness is asserted.

The essential additional result, beyond fixed-$a$ asymptotics, is the following sequential coercivity:

$$
 a_n\to0\text{ or }a_n\to\infty
 \quad\Longrightarrow\quad
 \sqrt n e^{nC}F_n(a_n)\to\infty.
$$

Sections 4 and 5 prove this with explicit bounds, so the infimum/asymptotic exchange does not assume that $q$ is fixed.

## 2. Exact tilt and elementary inequalities

Since $P(y)=ZR(y)e^{-Y(y)/2}$,

$$
 B_n(a)=e^{-nC}\mathbb E_{R^n}h_a(S_n),
 \qquad
 h_a(s)=e^{-s/2}\{1-(1+a e^s)^{-b}\}.
 \tag{2.1}
$$

For $z\ge0$ and $b\ge1$,

$$
 \frac{z}{1+z}\le 1-(1+z)^{-b}\le bz.
 \tag{2.2}
$$

The lower bound follows from $(1+z)^{-b}\le(1+z)^{-1}$; the upper bound is the tangent inequality for the convex function $(1+z)^{-b}$. Also

$$
 -\log(1-u)\ge u\quad(0<u<1).
$$

Consequently, with $r_n=\sqrt n\,e^{nC}$,

$$
 r_nF_n(a)\ge
 \frac{\sqrt n}{b}\mathbb E_{R^n}
 \frac{h_a(S_n)}{\log(1+a)}.
 \tag{2.3}
$$

This lower bound remains valid even when $a$ depends on $n$ or the deficit $B_n$ is not small.

## 3. The only probabilistic input needed

Stone's interval local limit theorem, in the mean-zero one-dimensional nonarithmetic case, states that for every fixed $\ell>0$,

$$
 \sup_{x\in\mathbb R}\left|
 \sqrt n\,R^n\{S_n\in[x,x+\ell)\}
 -\frac{\ell}{\sigma\sqrt{2\pi}}
   e^{-x^2/(2n\sigma^2)}
 \right|\longrightarrow0.
 \tag{3.1}
$$

In particular, for any fixed $D,E>0$, there exist $c_0>0$, $C_0<\infty$ and $N$ such that for $n\ge N$:

$$
 \frac{c_0}{\sqrt n}\le
 R^n\{S_n\in[x,x+1)\}
 \quad\text{whenever }|x|\le D\log(n+1)+E,
 \tag{3.2}
$$

and

$$
 \sup_x R^n\{S_n\in[x,x+1)\}\le C_0/\sqrt n.
 \tag{3.3}
$$

For (3.2), $x/\sqrt n$ tends to zero uniformly on the stated logarithmic window. Thus only intervals very near the central scale are used; no moderate- or large-deviation approximation is needed.

**Primary-source provenance.** Charles Stone, *On local and ratio limit theorems*, Proceedings of the Fifth Berkeley Symposium, volume II, part II, pp. 217-224, Corollary 1 on p. 218, supplies the finite-covariance interval LLT with a remainder uniform in location. The theorem/corollary passage was retrieved through indexed primary-source text from the Berkeley collection. Direct PDF opening returned HTTP 403, so this note does not claim a locally downloaded/full-PDF inspection. Source: [Berkeley primary-source PDF](https://digicoll.lib.berkeley.edu/nanna/record/113081/files/math_s5_v2_p2_article-15.pdf?registerDownload=1&version=1&withMetadata=0&withWatermark=0). The related original 1965 paper has DOI 10.1214/aoms/1177700165; its full text was not retrieved here.

## 4. Excluding $a\to0$, including arbitrarily fast escape

Write $a=e^{-t}$, $t\ge2$, and $n\ge2$. Set

$$
 x=\min(t/2,\log n).
$$

On $I=[x,x+1)$, we have

$$
 a e^s\le e^{-t/2+1}\le1,
 \qquad \log(1+a)\le a.
$$

Applying (2.2),

$$
 \frac{h_a(s)}{\log(1+a)}
 \ge \frac{e^{-s/2}\,a e^s}{2a}
 =\tfrac12 e^{s/2}
 \ge\tfrac12e^{x/2}.
$$

The interval location is at most $\log n$, uniformly in $t$, so (3.2) applies. Thus for all sufficiently large $n$ and all $t\ge2$,

$$
 r_nF_n(e^{-t})\ge
 \frac{c_0}{2b}e^{\min(t/2,\log n)/2}
 =\frac{c_0}{2b}\min(e^{t/4},\sqrt n).
 \tag{4.1}
$$

This tends to infinity for every $t_n\to\infty$, regardless of its speed. In particular it covers $a_n$ exponentially or superexponentially small. No lower cutoff on $a$ is assumed.

## 5. Excluding $a\to\infty$

Let $M=\max_y|Y(y)|>0$. Then $|S_n|\le nM$ pointwise. Write $a=e^t$.

### 5.1. Very large $t$: a direct finite-support bound

For every sample,

$$
 (1+e^{t+S_n})^{-b}\le e^{-b(t+S_n)}
 \le e^{-b(t-nM)}.
$$

Therefore

$$
 F_n(e^t)\ge\frac{t-nM}{\log(1+e^t)}.
$$

If $t\ge2nM+1$, then $nM\le(t-1)/2$ and $\log(1+e^t)\le t+\log2$. Consequently

$$
 F_n(e^t)\ge\frac{t+1}{2(t+\log2)}\ge\tfrac12,
 \qquad t\ge2nM+1.
 \tag{5.1}
$$

Its rescaled value is at least $r_n/2$, which tends to infinity.

### 5.2. Remaining large $t$: a logarithmically displaced central window

Assume $20\le t\le2nM+1$ and choose

$$
 I_t=[-4\log t-1,-4\log t).
$$

For $s$ in this interval,

$$
 e^{t+s}\ge e^t t^{-4}e^{-1}\ge1,
 \qquad e^{-s/2}\ge t^2,
$$

where the final inequality in the first line follows because $t-4\log t-1>0$ at $t=20$ and increases thereafter. By $b\ge1$ and $\log(1+e^t)\le2t$,

$$
 \frac{h_{e^t}(s)}{\log(1+e^t)}
 \ge \frac{t^2/2}{2t}=\frac t4.
$$

The interval lies within a logarithmic distance of zero:

$$
 |{-4\log t-1}|
 \le4\log(n+1)+4\log(2M+1)+1.
$$

Thus a single choice of $D,E$ in (3.2) works for every such $t$. Combining with (2.3),

$$
 r_nF_n(e^t)\ge\frac{c_0t}{4b},
 \qquad20\le t\le2nM+1,
 \tag{5.2}
$$

for all sufficiently large $n$. Equations (5.1)-(5.2) imply, for $t\ge20$,

$$
 r_nF_n(e^t)\ge
 \min\left(\frac{c_0t}{4b},\frac{r_n}{2}\right).
 \tag{5.3}
$$

Every sequence $t_n\to\infty$ therefore has rescaled objective tending to infinity. This is the required other half of sequential coercivity.

## 6. Finite-$n$ existence and endpoint behavior

Continuity of $F_n$ on $(0,\infty)$ is immediate from the finite sum defining $A_n$. Let $X=e^{S_n}$ under $P^n$. Then $X>0$ and $\mathbb E_P X=1$. Since $P\ne Q$, $X$ is nonconstant for every $n\ge1$.

The map $x\mapsto(1+ax)^{-b}$ is strictly convex. Strict Jensen gives

$$
 A_n(a)>(1+a\mathbb E X)^{-b}=(1+a)^{-b}.
$$

Also $A_n(a)<1$. Hence $0<F_n(a)<1$.

For fixed $n$ and $a\to0$, Taylor expansion of the finite sum gives

$$
 A_n(a)=1-ba\mathbb E X+O_n(a^2)
 =1-ba+O_n(a^2),
$$

so $F_n(a)\to1$. At the other endpoint, because $X$ has a finite strictly positive support,

$$
 A_n(a)=a^{-b}\{\mathbb E X^{-b}+o(1)\},
$$

and therefore

$$
 -\log A_n(a)=b\log a-\log\mathbb E X^{-b}+o(1),
$$

which again gives $F_n(a)\to1$ as $a\to\infty$. Choosing any interior $a_0$ gives $F_n(a_0)<1$; the endpoint limits force the global infimum into a compact interior interval. By continuity, the infimum is attained. These endpoint limits alone are not a uniform-in-$n$ argument; Sections 4-5 supply that missing step.

## 7. Compact-uniform asymptotics

Fix $K=[a_-,a_+]$ contained in $(0,\infty)$. For every $a\in K$, (2.2) gives the common exponential envelope

$$
 h_a(s)\le
 \begin{cases}
 e^{-s/2},&s\ge0,\\
 b a_+ e^{s/2},&s<0.
 \end{cases}
 \tag{7.1}
$$

Stone's theorem implies vague convergence of the measures $\sqrt n\,\operatorname{Law}_R(S_n)$ to $ds/(\sigma\sqrt{2\pi})$. On each bounded interval, the functions $h_a$ form a jointly continuous compact family, so this convergence is uniform in $a\in K$, by a finite uniform-continuity net. The bound (3.3), applied to unit intervals together with (7.1), makes both tails uniformly negligible. Hence

$$
 \sup_{a\in K}\left|
 \sqrt n\,\mathbb E_R h_a(S_n)
 -\frac{1}{\sigma\sqrt{2\pi}}\int_{\mathbb R}h_a(s)\,ds
 \right|\longrightarrow0.
 \tag{7.2}
$$

For completeness, the needed uniform-continuity control can also be obtained from

$$
 \partial_a h_a(s)=b e^{s/2}(1+a e^s)^{-b-1}.
$$

For $s\le0$ this is at most $be^{s/2}$; for $s\ge0$ it is at most $b a_-^{-b-1}e^{-(b+1/2)s}$. The unit-interval concentration bound ensures that $\sqrt n\,\mathbb E_R|h_a-h_{a'}|$ is bounded by a constant times $|a-a'|$, uniformly on $K$ and in large $n$. This justifies the finite-net step explicitly.

Substitute $u=ae^s$ and integrate by parts:

$$
 \int_{\mathbb R}h_a(s)\,ds
 =\sqrt a\int_0^\infty u^{-3/2}\{1-(1+u)^{-b}\}\,du
$$
$$
 =2b\sqrt a\int_0^\infty u^{-1/2}(1+u)^{-b-1}\,du
 =\frac{2\sqrt\pi\,\Gamma(b+\tfrac12)}{\Gamma(b)}\sqrt a.
 \tag{7.3}
$$

Both boundary terms vanish: near zero the bracket is $O(u)$, and at infinity it is bounded. By (2.1) and (7.2), $B_n=O(e^{-nC}/\sqrt n)$ uniformly on $K$. Thus $-\log(1-B_n)=B_n+O(B_n^2)$, uniformly, and the rescaled quadratic error tends to zero. Since $b\log(1+a)$ is bounded away from zero on $K$,

$$
 \sup_{a\in K}\left|r_nF_n(a)-G_b(a)\right|\longrightarrow0,
$$
$$
 G_b(a)=
 \frac{2\sqrt\pi\,\Gamma(b+\tfrac12)}
 {\Gamma(b+1)\sigma\sqrt{2\pi}}
 \frac{\sqrt a}{\log(1+a)}.
 \tag{7.4}
$$

This confirms the prefactor used in the main theorem, including the factor 2 from the reciprocal half exponent and the factor $b$ absorbed into $\Gamma(b+1)$.

## 8. Passing the infimum and convergence of all optimizers

Choose any fixed $a_0>0$. Equation (7.4) shows $r_n\inf F_n\le r_nF_n(a_0)$ remains bounded. By the sequential coercivity in Sections 4-5, a sequence of minimizing $a_n$ cannot approach zero or infinity. Therefore every minimizing sequence is eventually contained in some fixed compact subset of $(0,\infty)$. Otherwise a subsequence outside larger and larger compact intervals would have a further subsequence tending to an endpoint, contradicting the bounded objective.

On that compact set, uniform convergence (7.4) applies. If $a_{n_j}\to a_{\mathrm{bar}}$, then

$$
 G_b(a_{\mathrm{bar}})
 =\lim_j r_{n_j}F_{n_j}(a_{n_j})
 \le \lim_jr_{n_j}F_{n_j}(a)=G_b(a)
$$

for every fixed $a>0$. Thus every subsequential limit minimizes $G_b$. Its $a$-dependent part is $g(a)=\sqrt a/\log(1+a)$, whose derivative has the sign of

$$
 u(a)=(1+a)\log(1+a)-2a.
$$

Here $u(0)=0$ and $u'(a)=\log(1+a)-1$. Hence $u$ first decreases, then strictly increases to infinity, and has exactly one positive zero $a_*$. This proves uniqueness of the limiting minimizer, convergence of all $a_n$, and the stated asymptotic minimum. The same proof applies to rescaled $o(1)$-approximate minimizers.

The numerical values above were independently recomputed with mpmath at 70 decimal digits; the analytic uniqueness argument does not depend on that computation. Also

$$
 \frac{\sqrt{a_*}}{\log(1+a_*)}
 =1.2426337563300258622014300773955966\ldots.
$$

## 9. Stronger general binary-pair version

The proof does not fundamentally need output symmetry. For distinct positive $P,Q$, let $\theta\in(0,1)$ be the unique minimizer of

$$
 Z(\theta)=\sum_yP(y)^{1-\theta}Q(y)^\theta.
$$

Existence, interiority and uniqueness follow from strict convexity of $\log Z$, its derivatives $-D(P\|Q)<0$ at zero and $D(Q\|P)>0$ at one, and nonconstancy of $\log(Q/P)$. Set $C=-\log Z(\theta)$, $R=P^{1-\theta}Q^\theta/Z(\theta)$, $Y=\log(Q/P)$, and $\sigma^2=\operatorname{Var}_R(Y)$. Then $\mathbb E_RY=0$, and $P=Z(\theta)Re^{-\theta Y}$.

For the same oriented binary-mixture function $F_n$, replace $h_a(s)$ by

$$
 h_{a,\theta}(s)=e^{-\theta s}\{1-(1+a e^s)^{-b}\}.
$$

Assuming the tilted log-likelihood is nonarithmetic, the complete result becomes

$$
 \inf_{a>0}F_n(a)
 =\frac{e^{-nC}}{\sqrt n}\left[
 \frac{\Gamma(1-\theta)\Gamma(b+\theta)}
 {\theta\Gamma(b+1)\sigma\sqrt{2\pi}}
 \min_{a>0}\frac{a^\theta}{\log(1+a)}+o(1)\right].
 \tag{9.1}
$$

The unique $a$-dependent minimizer satisfies

$$
 \theta(1+a_\theta)\log(1+a_\theta)=a_\theta,
$$

or, with $q_\theta=1/(1+a_\theta)$,

$$
 -\theta\log q_\theta=1-q_\theta.
$$

The integration step is

$$
 \int h_{a,\theta}(s)\,ds
 =a^\theta\int_0^\infty u^{-\theta-1}\{1-(1+u)^{-b}\}\,du
 =\frac{\Gamma(1-\theta)\Gamma(b+\theta)}
 {\theta\Gamma(b)}a^\theta.
$$

The compact-uniform envelope is $e^{-\theta s}$ for $s\ge0$ and $ba_+e^{(1-\theta)s}$ for $s<0$. Small-$a$ coercivity uses the same $x=\min(t/2,\log n)$, giving

$$
 r_nF_n(e^{-t})\ge\frac{c_0}{2b}
 e^{(1-\theta)\min(t/2,\log n)}.
$$

For large $a=e^t$ with $t\le2nM+1$, take the window

$$
 [-(2/\theta)\log t-1,-(2/\theta)\log t).
$$

For $t$ above a $\theta$-dependent fixed threshold, $e^{t+s}\ge1$ and $e^{-\theta s}\ge t^2$. The same bound $c_0t/(4b)$ follows. The very-large-$t$ bound $F_n\ge\tfrac12$ is unchanged. Thus all uniformity arguments are valid for every fixed $\theta\in(0,1)$.

This section is an oriented-pair analytic theorem. Connecting it to a nonsymmetric channel contraction coefficient may require comparing both row orientations and other input pairs; that channel reduction is a separate obligation. Reversing $P,Q$ replaces $\theta$ by $1-\theta$, preserves $C$ and $\sigma$, and may change the prefactor and optimal mixing weight.

