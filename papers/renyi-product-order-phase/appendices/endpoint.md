# Proof E: Maximum-likelihood endpoint and saturation

## 1. Scope and definitions

Let $P$ and $Q$ be distinct strictly positive probability distributions on a finite alphabet $Y$. No output symmetry or nonlattice condition is needed for the analytic statements below. Set

\[
R(y)=\frac{Q(y)}{P(y)},\qquad
M=-\log\min_y R(y)=D_\infty(P\|Q)>0.
\]

Write

\[
\rho=e^{-M},\quad
\mathcal A=\{y:R(y)=\rho\},\quad
p_*=P(\mathcal A),\quad \ell=-\log p_*.
\]

Because $P$ and $Q$ are distinct, $0<\rho<1$ and $0<p_*<1$. In particular $M$ and $\ell$ are positive and finite. For iid samples $Y_1,\ldots,Y_n$ from $P$ define

\[
R_n=\prod_{j=1}^nR(Y_j),\qquad \varepsilon_n=\rho^n=e^{-nM}.
\]

For $b>0$, $a>0$ and $U=\log(1+a)$, let

\[
A_{n,b}(a)=\mathbb E_{P^n}(1+aR_n)^{-b},\qquad
L_{n,b}(a)=-\log A_{n,b}(a),
\]

\[
G_{n,b}(a)=\frac{L_{n,b}(a)}{b\log(1+a)},
\qquad g_{n,b}=\inf_{a>0}G_{n,b}(a).
\]

The relation to the two-row order-$\alpha$ Renyi coefficient uses $b=\alpha-1$ and $q=\exp(-U)=1/(1+a)$. For $\nu=\delta_P$ and $\mu=q\delta_P+(1-q)\delta_Q$, direct substitution gives the contraction defect $G$. The Dirac/two-point support reduction is inherited from Vandenbroucque, Esposito and Gastpar, arXiv:2609.34570, Theorem 6. Identifying this two-row optimization with a particular full product-channel coefficient must be justified separately by the BISO reduction proved above. The results here establish the complete optimization over $a$ for the displayed functional; they do not silently substitute a candidate prior for the infimum.

## 2. Two elementary global lemmas

### Lemma 1: atomic sandwich

For every $n$, $b$ and $a$,

\[
b\log(1+a\varepsilon_n)
\ \le L_{n,b}(a)\ \le
n\ell+b\log(1+a\varepsilon_n). \tag{2.1}
\]

**Proof.** Since $R_n\ge\varepsilon_n$, every kernel in the expectation is at most $(1+a\varepsilon_n)^{-b}$. This proves the lower bound on $L$. The event that every $Y_j$ lies in $\mathcal A$ has probability $p_*^n$ and $R_n=\varepsilon_n$ there. Keeping this event in the expectation proves the upper bound. This reasoning includes all other atoms rather than assuming they are negligible. QED.

In particular, for $0<\varepsilon_n<1$, concavity of the logarithm yields

\[
\log(1+a\varepsilon_n)
\ge \varepsilon_n\log(1+a),
\]

and hence

\[
g_{n,b}\ge\varepsilon_n. \tag{2.2}
\]

### Lemma 2: monotonicity and concavity of L

For fixed $n,b$, $L(a)$ is increasing and concave on $[0,\infty)$, with $L(0)=0$. Consequently, for $0<a\le1$,

\[
\frac{L(a)}{\log(1+a)}\ge L(1). \tag{2.3}
\]

**Proof.** Use the tilted probability weights proportional to $P^n(y)(1+aR_n(y))^{-b}$, and write $\mathbb E_a$ for expectation under those weights and $T_a=R_n/(1+aR_n)$. Finite alphabet differentiation gives

\[
L'(a)=b\mathbb E_aT_a>0,
\]

\[
L''(a)=-b\mathbb E_aT_a^2-b^2\operatorname{Var}_a(T_a)\le0.
\]

Concavity implies $L(a)\ge aL(1)$ for $a\in[0,1]$, while $\log(1+a)\le a$. QED.

### Lemma 3: an increasing logarithmic ratio

For $b>1$ the function

\[
h_b(a)=\frac{\log(1+a/b)}{\log(1+a)}
\]

is strictly increasing on $(0,\infty)$.

**Proof.** The ratio of derivatives of numerator and denominator is $(1+a)/(b+a)$, strictly increasing. Equivalently, $h_b(a)$ is the average of that increasing function on $[0,a]$ with positive weight $1/(1+x)$. Differentiating this weighted average proves the assertion. QED.

## 3. Endpoint theorem: b_n = exp(nM)

### Theorem E

If $b_n=\exp(nM)=\varepsilon_n^{-1}$, then

\[
b_n g_{n,b_n}\sim\frac{n\ell}{\log n}. \tag{3.1}
\]

Every relatively asymptotically optimal sequence $a_n$, meaning

\[
G_{n,b_n}(a_n)/g_{n,b_n}\longrightarrow1,
\]

satisfies

\[
\frac{\log(1+a_n)}{\log n}\longrightarrow1. \tag{3.2}
\]

An explicit asymptotically optimal construction is

\[
U_n=1+W_0\!\left(\frac{n\ell-1}{e}\right),\qquad
a_n=e^{U_n}-1,\qquad q_n=e^{-U_n}, \tag{3.3}
\]

for all sufficiently large $n$, where $W_0$ is the real principal Lambert $W$ function. For this construction $q_n\sim\log n/(n\ell)$. That last equivalent is asserted for this explicit construction; (3.2) alone does not assert the same finer equivalent for every optimal prior.

In fact, the endpoint value admits the stronger expansion

\[
b_ng_{n,b_n}=e^{U_n}+o(1/\log n). \tag{3.3a}
\]

Every **exact** minimizing prior, written \(\widehat U_n=\log(1+\widehat a_n)\), satisfies

\[
\widehat U_n-U_n\longrightarrow0,\qquad
\widehat q_n/e^{-U_n}\longrightarrow1. \tag{3.3b}
\]

Thus its mass satisfies \(\widehat q_n\sim\log n/(n\ell)\). Exactness of minimization matters in (3.3b): an arbitrary relatively asymptotically optimal sequence is only asserted to satisfy (3.2). Sections 3.1-3.5 first prove the coarse asymptotic and tightness, after which Section 3.6 proves the sharpening without circular localization.

### 3.1. Control of the non-minimal atoms

The key estimate is

\[
L_{n,b_n}(1)=n\ell+O((\log n)^2). \tag{3.4}
\]

Let

\[
\tau=\min_{y\notin\mathcal A}\frac{R(y)}\rho>1,
\quad
K_n=\#\{j:Y_j\notin\mathcal A\}.
\]

Then $K_n$ has the binomial distribution with parameters $n$ and $1-p_*$, and

\[
R_n/\varepsilon_n\ge\tau^{K_n}.
\]

Take $k_n=\lceil3\log n/\log\tau\rceil$. For large $n$, $k_n<n$ and $\tau^{k_n}$ lies between $n^3$ and $\tau n^3$. Splitting at $K_n<k_n$ gives

\[
A_{n,b_n}(1)
\le\mathbb P(K_n<k_n)
+(1+\tau^{k_n}/b_n)^{-b_n}. \tag{3.5}
\]

Let $B=\max\{1,(1-p_*)/p_*\}$. The first term is bounded by

\[
p_*^n k_n(nB)^{k_n}
=\exp\{-n\ell+O((\log n)^2)\}. \tag{3.6}
\]

Since $b_n$ is exponential in $n$ while $\tau^{k_n}=O(n^3)$, $\log(1+x)\ge x/2$ applies to $x=\tau^{k_n}/b_n$ for large $n$. Thus the second term in (3.5) is at most $\exp(-n^3/2)$. This proves the needed upper bound on $A$. Conversely, its all-minimal-atom contribution gives

\[
A_{n,b_n}(1)\ge p_*^n(1+1/b_n)^{-b_n}
\ge e^{-n\ell-1}. \tag{3.7}
\]

Together, (3.5)-(3.7) establish (3.4). In particular, the possible combinatorial multiplicity of near-minimal product atoms is included in the estimate.

### 3.2. Explicit upper bound

Write $F_n(a)=b_nG_{n,b_n}(a)=L(a)/\log(1+a)$. By Lemma 1 and $\log(1+x)\le x$,

\[
F_n(e^U-1)\le\frac{n\ell+e^U-1}{U}. \tag{3.8}
\]

The $U_n$ in (3.3) solves $e^{U_n}(U_n-1)=n\ell-1$. Therefore the right side of (3.8) equals $e^{U_n}$. The defining equation implies $U_n/\log n\to1$ and

\[
e^{U_n}=\frac{n\ell-1}{U_n-1}
\sim\frac{n\ell}{\log n}. \tag{3.9}
\]

This proves the global infimum's limsup bound. No asymptotic evaluation of $A$ at this prior is necessary for the upper bound.

### 3.3. Uniform exclusion of small priors in a coordinates

Fix $\delta\in(0,1)$. If $0<a\le1$, Lemma 2 and (3.4) give $F_n(a)\ge n\ell+O((\log n)^2)$, which is much larger than the upper bound (3.9). If $1\le a\le n^{1-\delta}$, monotonicity of $L$ gives

\[
F_n(a)\ge\frac{L(1)}{\log(1+n^{1-\delta})}
=\left(\frac1{1-\delta}+o(1)\right)
\frac{n\ell}{\log n}. \tag{3.10}
\]

Hence no relatively asymptotically optimal sequence can have $a_n\le n^{1-\delta}$ infinitely often. This includes $a_n$ tending to zero at an arbitrary rate.

### 3.4. Uniform exclusion of all large-a escapes

For $a\ge n^{1+\delta}$, Lemmas 1 and 3 imply

\[
F_n(a)\ge b_nh_{b_n}(a)
\ge b_nh_{b_n}(n^{1+\delta})
\sim\frac{n^{1+\delta}}{(1+\delta)\log n}. \tag{3.11}
\]

The last expression is much larger than (3.9). This bound is uniform all the way to $a=\infty$; it does not assume $a$ is polynomial or smaller than $b_n$.

### 3.5. Completion of the lower bound and optimizer scale

The preceding exclusions imply (3.2) for any relatively asymptotically optimal sequence. For such a sequence, $a_n\ge1$ eventually, and therefore

\[
F_n(a_n)\ge\frac{L(1)}{\log(1+a_n)}
\sim\frac{n\ell}{\log n}.
\]

Combined with (3.9), this proves (3.1). One may work with approximate minimizers without assuming attainment. Alternatively, for each $n$ the limits of $F_n(a)$ at both $a\downarrow0$ and $a\to\infty$ equal $b_n$, whereas (3.9) is smaller than $b_n$ for all large $n$; continuity therefore gives interior minimizers in that range. QED.

### 3.6. Uniform atomic approximation and sharp Lambert W law

By the already-proved coarse localization with $\delta=1/2$, every exact minimizer belongs to

\[
I_n=[n^{1/2},n^{3/2}]
\]

for all sufficiently large $n$. The explicit Lambert $W$ candidate also belongs to this interval. We now establish the uniform absolute estimate

\[
L_{n,b_n}(a)=n\ell+a+o(1),\qquad a\in I_n. \tag{3.12}
\]

Write $T=R_n/\varepsilon_n$. The ratio of a product atom's kernel to the all-minimal kernel is exactly

\[
\frac{(1+aT/b_n)^{-b_n}}{(1+a/b_n)^{-b_n}}
=\left(1+\frac{a(T-1)}{b_n+a}\right)^{-b_n}. \tag{3.13}
\]

For large $n$, all $a\in I_n$ satisfy $a\le b_n$. Put $x=a(T-1)/(b_n+a)$. If $x\le1$, then $\log(1+x)\ge x/2$ and $b_n/(b_n+a)\ge1/2$, so (3.13) is at most

\[
e^{-a(T-1)/4}
\le e^{-a K_n(\tau-1)/4}. \tag{3.14}
\]

The last inequality follows from $T\ge\tau^{K_n}$ and $\tau^k-1\ge k(\tau-1)$. If $x>1$, (3.13) is at most $2^{-b_n}$.

Let $h=(1-p_*)/p_*$ and $c_0=(\tau-1)/4$. Divide the whole expectation by its all-minimal contribution. The sum of all other atoms, using the two preceding bounds and allowing overcounting, is at most

\[
\delta_n=
\left(1+h e^{-c_0\sqrt n}\right)^n-1
+e^{n\ell-b_n\log2}\longrightarrow0, \tag{3.15}
\]

uniformly for $a\in I_n$. Hence, for some $\Delta_n(a)\in[0,\delta_n]$,

\[
A_{n,b_n}(a)=p_*^n(1+a/b_n)^{-b_n}
\bigl(1+\Delta_n(a)\bigr). \tag{3.16}
\]

Using $x-x^2/2\le\log(1+x)\le x$ for $x\ge0$ and $\log(1+\Delta)\le\Delta$ gives the explicit uniform sandwich

\[
n\ell+a-E_n\le L_{n,b_n}(a)\le n\ell+a,
\qquad
E_n=\frac{n^3}{2b_n}+\delta_n\longrightarrow0. \tag{3.17}
\]

This proves (3.12). Define

\[
H_n(U)=\frac{n\ell+e^U-1}{U}.
\]

Its derivative has the sign of $e^U(U-1)-(n\ell-1)$, whose derivative is $Ue^U>0$. Thus $H_n$ has a unique minimizer $U_n$ from (3.3), and its minimum is $e^{U_n}$. The actual infimum and this surrogate infimum both have minimizing arguments in $I_n$. Applying (3.17) at a true minimizer and the upper bound at the surrogate minimizer gives

\[
0\le e^{U_n}-b_ng_{n,b_n}
\le\frac{E_n}{\log(1+\sqrt n)}
=o(1/\log n). \tag{3.18}
\]

This proves (3.3a).

For the optimizer, the same comparison shows that $H_n(\widehat U_n)-H_n(U_n)$ tends to zero. The identity

\[
H_n(U_n+d)-H_n(U_n)
=\frac{e^{U_n}(e^d-1-d)}{U_n+d},\qquad U_n+d>0, \tag{3.19}
\]

follows directly from $e^{U_n}(U_n-1)=n\ell-1$. For any fixed positive $\delta$, the right side at $d=\delta$ or $d=-\delta$ tends to infinity. Since $H_n$ is strictly decreasing before $U_n$ and strictly increasing after $U_n$, an exact optimizer cannot have $\lvert\widehat U_n-U_n\rvert\ge\delta$ for infinitely many $n$. This proves (3.3b), and concludes the sharpened endpoint theorem. QED.

## 4. Superendpoint theorem: r > M

### Theorem S

Fix $r>M$ and $b_n=\exp(nr)$. Then

\[
g_{n,b_n}\sim e^{-nM}. \tag{4.1}
\]

An explicit asymptotically optimal prior is given by

\[
v_n=b_n\varepsilon_n=e^{n(r-M)},\quad
U_n=\sqrt{\frac{2n\ell}{v_n}},\quad
q_n=e^{-U_n},\quad a_n=e^{U_n}-1. \tag{4.2}
\]

In particular $q_n\to1$. This construction has the quantitative sandwich

\[
1\le\frac{g_{n,b_n}}{\varepsilon_n}
\le\frac{G_{n,b_n}(a_n)}{\varepsilon_n}
\le\frac{U_n}{2}+\frac{e^{U_n}-1}{U_n}
=1+U_n+O(U_n^2). \tag{4.3}
\]

**Proof.** The lower bound is (2.2), valid for every $a$ and hence for the infimum. The upper part of (2.1) yields

\[
\frac{G_{n,b_n}(a_n)}{\varepsilon_n}
\le\frac{n\ell}{v_n U_n}
+\frac{\log(1+a_n\varepsilon_n)}{\varepsilon_n U_n}
\le\frac{U_n}{2}+\frac{a_n}{U_n}.
\]

Since $r>M$, $U_n\to0$. Expanding $\exp(U_n)$ gives (4.3) and (4.1). The argument treats all competing priors through a global lower bound and all non-minimal product atoms through the atomic sandwich; no unverified domination approximation is used. QED.

