# One versus two long-time queries for affine Hamiltonian encoding

An exponential normalization separation and a sharp mean-time frontier

## Abstract

We study unconditional preparation of the physical mixed state
$R_H(C)=[I+(H-\tau(H)I)/C]/d$ from ordinary forward evolutions of an
unknown Hamiltonian of spectral diameter at most $L$, when each call must
last longer than $T$. For every one-call trace-preserving protocol, including
arbitrary ancillas, known operations, classical randomization and measurement
feedforward, the required normalization satisfies
$C/L\ge e^{LT/e-1}/(2LT)$ for $LT\ge2e$. An explicit high-pass construction attains
$C/L=\exp(O(LT))$ with finite mean evolution time. By contrast, the
preserved two-call construction attains $C=\gamma L$, with
$\gamma=35\zeta(3)/\pi^3$, independently of $T$. Thus the one-call
normalization penalty has the correct exponential order, and two calls suffice
to remove it. This separation is robust: at fixed $C/L$, the optimal
one-call uniform trace-norm error tends to the error of simply outputting
$I/d$.

We also determine a sharp resource frontier within the entire class of signed
sine-filter mixtures implementing the two-Choi/partial-SWAP interface. If the
filter has total variation at most $L+\Delta$ and uniform multiplier bias
at most $\varepsilon$, its minimal first absolute time moment is
$(2/\pi)\log[L/(\Delta+\varepsilon)]+O(1)$, with a uniform additive
constant and matching explicit constructions. The lower bound covers arbitrary
real signed Borel measures. Its endpoint-defect inequality also proves that
exact optimal normalization entails infinite mean time. A specified
second-moment-times-mean-time statistical objective has the two-term optimum
$2t_0L^2+(2L/\pi)\log(t_0L)+O(L)$. Complete inherited converter,
finite-budget estimation and restricted-batch lower-bound proofs are included.

**Scope.** The one-call obstruction is universal within the stated ordinary-query
model. The sharp first-moment and statistical-cost bounds concern the specified
partial-SWAP mixture and readout architecture. They are not general two-call
quantum lower bounds, nor a resolution of unrestricted Hamiltonian learning.
All claims are analytic; finite numerical checks are supporting diagnostics.
No external peer review or complete Lean verification is asserted.

## 1. Problem, results and relation to earlier work

An unknown Hamiltonian is accessible through the channel of
$U_H(t)=e^{-itH}$, for a classically specified $t>T>0$. We count
ordinary unknown calls and their physical evolution durations. Known gates and
reference ancillas are allowed. No controlled unknown oracle, inverse oracle,
interruption inside a single ordinary call, or selection of a favorable
measurement outcome is supplied. The Hamiltonian remains fixed throughout.
The output is an unconditional physical state, so a signed classical estimator
by itself is not a solution of the state-conversion task.

Write $d=2^n$, $n\ge1$, $\tau=\operatorname{Tr}/d$, and let
$\operatorname{diam}(H)\le L$. Centering removes the identity coefficient
that an ordinary evolution channel cannot identify. The target is
```math
R_H(C)=\frac1d\left(I+\frac{H-\tau(H)I}{C}\right).
```
Throughout, a smaller positive $C$ means a stronger encoded signal.
$C\ge L$ suffices for positivity uniformly in dimension. All state errors
in the main results are **trace norm**; conventional trace distance is half of
these values. All logarithms are natural. Constants in $O(\cdot)$ are
absolute unless a dependence is explicitly stated.

The central findings answer two resource questions. First, how much encoded
signal is lost when only one mandatory long call is available? Sections 2--4
prove a universal exponential penalty, an exponential-order construction, and
a sharp limiting approximation obstruction. The smallest query number that
allows $C=O(L)$ uniformly over arbitrarily large $LT$ is therefore two.
This does not say that exact one-query encoding is impossible: it is possible
at exponentially weakened strength.

Second, how expensive is it to approach the strongest normalization supported
by the signed two-Choi interface? Sections 5--12 give the sharp logarithmic
normalization--bias--mean-time law and its readout-cost consequence. These
optimality statements apply to every signed-measure mixture in that interface,
but not to arbitrary two-query channels. In particular, no optimal finite
constant for all two-query state processors is claimed.

The earlier manuscript supplied the two-query physical converter and finite
learning guarantees, but did not establish the one-versus-two separation or
the sharp near-optimal time law. Its core inputs retain their ownership:
Zhang's two-Choi cancellation [3], the standard partial-SWAP channel [5,6],
Theis's optimal proper shift rules [4], finite-moment differentiation kernels
[7], and classical shadows [8]. Theis's Nyquist optimum, support restrictions
and nonexistence of exponentially concentrated exact rules are background,
not new results here. The new endpoint-defect inequality quantifies how the
first moment must diverge near that optimum.

Zhao's STOC 2025 paper [9] is a technical comparison at the broader theoretical
computer science level: both works convert restricted evolution access into
Hamiltonian-dependent quantum states. Zhao uses approximate pure pseudo-Choi
encodings to learn unknown Hamiltonian structure. Our mixed affine output,
constant query count and mandatory-long-call separation address a different
resource question; we do not improve that paper's general structure-learning
guarantees. Recent control-depth and hybrid-query tradeoffs [11,12] also make
a mere extension from two to several coherent calls unsuitable as our central
originality claim. We therefore retain only the already established two-query
batch theorem in the baseline appendix.

The compactly supported spline tests used below are standard Fourier tools;
exterior-interval recovery has a substantial classical history, including
Melkman [13]. The claims here concern the complete quantum one-call reduction,
its explicit exponent-order realization, the robust state risk, and the sharp
signed-measure frontier. The literature comparison is bounded by the source-access
limitations stated below. No source has been verified to have
posed this exact combined affine-output question verbatim. We study it as an
explicitly defined research question and do not label it a first solution of
Tang's wider learning problem [1].

### Reading map

Sections 2--4 prove the new general query-count results. Sections 5--12 prove
the filter and readout frontiers. Appendix A contains the complete inherited
converter and learning proofs, using its original local section numbers and
Theorems A--C. References [1]--[10] retain their numbering there. This makes
the present complete manuscript self-contained while preserving the precise
original claims and their stated access models.

## 2. Universal one-query obstruction

**Lemma.** For the family

```math
 H_\omega=(\omega/2)Z\otimes I_{d/2},\quad |\omega|\le L,
```

let $F(\omega)$ be the expectation of the output observable $Z \otimes I$. The odd part has a representation

```math
 F_o(\omega)=\frac{F(\omega)-F(-\omega)}2
             =\int_{(T,\infty)}\sin(\omega t)\,d\mu(t),
 \qquad \|\mu\|_{\mathrm{TV}}\le1.                 \tag{Q1}
```

**Proof.** Condition on every pre-query classical datum, including the chosen time. The conditional input state $\rho$ is independent of $\omega$. Absorb all subsequent known operations, measurements and trace-preserving feedforward into a channel $\Lambda$, and put $M=\Lambda^*(Z \otimes I)$, so $\|M\|\le1$. With $P_+$ and $P_-$ the query-system eigenspace projectors,

```math
 F_t(\omega)=a+2\Re(z e^{-i\omega t}),\quad
 z=\operatorname{Tr}(M P_+\rho P_-).
```

Its odd sine coefficient has magnitude at most $2|z|$. Positivity gives

```math
 \|P_+\rho P_-\|_1
 \le\|P_+\rho^{1/2}\|_2\|P_-\rho^{1/2}\|_2
 =\sqrt{\operatorname{Tr}(P_+\rho)\operatorname{Tr}(P_-\rho)}\le\tfrac12.
```

Therefore $2|z|\le 1$. Averaging the resulting signed sine coefficients against the pre-query probability measure proves (Q1). A no-query branch contributes an $\omega$-independent constant and disappears upon taking the odd part. This argument covers arbitrary ancilla dimension and arbitrary classical time distributions. Postselection would introduce an unknown-parameter-dependent denominator, which is precisely why it is excluded. QED.

For exact target preparation, (Q1) equals $\omega/(2C)$ throughout $[-L,L]$.

### 2.1. Exponential normalization lower bound

For an integer $m\ge 2$, let $h_m$ be the convolution of $m$ uniform probability densities on $[-L/m,L/m]$. It is supported on $[-L,L]$, is absolutely continuous, vanishes at the endpoints, and its derivative is integrable. Its Fourier transform is

```math
 \widehat h_m(t)=\left(\frac{\sin(Lt/m)}{Lt/m}\right)^m.
```

Integration by parts and Fubini are legitimate because $h_m'$ is integrable and $\mu$ has finite total variation. Exact preparation implies

```math
 \frac1{2C}
 =\left|\int_{-L}^{L}F_o(\omega)h_m'(\omega)\,d\omega\right|
 \le\sup_{t>T} t\,\big|\widehat h_m(t)\big|
 \le T\left(\frac m{LT}\right)^m.                \tag{Q2}
```

The last inequality uses $|\operatorname{sinc} u|\le 1/|u|$ and the monotonicity of $t^{1-m}$. It is valid for every $LT>0$, although useful only when $m \lt LT$. Thus

```math
 \boxed{C\ge\frac1{2T}\left(\frac{LT}{m}\right)^m\qquad(m\ge2).}       \tag{Q3}
```

Put $x=LT$. For $x\ge 2e$, choose $m=\lfloor x/e\rfloor$. Since $x/m\ge e$ and $m\ge x/e-1$,

```math
 \boxed{\frac C L\ge\frac{e^{x/e-1}}{2x}.}       \tag{Q4}
```

This is a lower bound for **all** one-query trace-preserving protocols, not merely for the partial-SWAP/Fourier architecture. It does not say that exact one-query preparation is impossible. Section 4 constructs it with exponentially weaker normalization.

### Approximate version of the same test

If $\sup_{|\omega|\le L}|F_o(\omega)-\omega/(2C)|\le\eta$, then

```math
 \frac1{2C}\le T\left(\frac m{LT}\right)^m+\eta\|h_m'\|_1
 \le T\left(\frac m{LT}\right)^m+\frac{m\eta}{L}. \tag{Q5}
```

For the last step, let $u_m$ be the uniform density on $[-L/m,L/m]$ and write $h_m=u_m*u_m^{*(m-1)}$. The distributional derivative of $u_m$ has total variation $m/L$; convolution with the probability density $u_m^{*(m-1)}$ contracts this norm. The same bound follows from symmetry/unimodality. If the approximation guarantee is trace norm at most $\eta$, then the scalar hypothesis above follows. If it is trace distance at most $\eta$, replace the last $\eta$ in (Q5) by $2\eta$.

## 3. Sharp limiting obstruction under approximation

Define

```math
 E_{1,d}(C,L,T)=\inf_{\mathcal A:\,\le1\text{ query}}
  \sup_{\operatorname{diam}(H)\le L}
  \|\mathcal A(H)-R_H(C)\|_1.
```

Assume the target is positive throughout the class, for example $C\ge L$. For every $0 \lt a\le 2L$, average (Q1) over $[L-a,L]$. Then

```math
 \left|\frac1a\int_{L-a}^{L}F_o(\omega)\,d\omega\right|
 \le\frac2{aT}.
```

The average target is $(L-a/2)/(2C)$. Consequently,

```math
 E_{1,d}(C,L,T)\ge\frac L{2C}-\frac a{4C}-\frac2{aT}.      \tag{Q6}
```

Taking $a=\sqrt{8C/T}$ whenever the displayed lower bound can be positive gives

```math
 \boxed{
 \left[\frac L{2C}-\sqrt{\frac2{CT}}\right]_+
 \le E_{1,d}(C,L,T)\le\frac L{2C}.}                       \tag{Q7}
```

There is no hidden condition in (Q7): if the bracket is positive, $T>8C/L^2$, so the optimizing $a$ lies in $(0,L)$ and is admissible; otherwise the lower bound is simply zero.

The upper bound is attained as a bound by outputting the maximally mixed state. To verify it, let $X$ be uniformly distributed over the eigenvalues of $H$, with mean $\mu$ and support $[A,B]$. Convexity of $|x-\mu|$ places it below its chord through $A,B$, giving

```math
 \mathbb E|X-\mu|
 \le\frac{2(\mu-A)(B-\mu)}{B-A}\le\frac{B-A}{2}\le\frac L2.
```

Thus $\|R_H(C)-I/d\|_1=\mathbb E|X-\mu|/C\le L/(2C)$. The balanced two-eigenvalue family in even dimension attains that worst-case error. An exactly-one-query convention is handled by executing and discarding an arbitrary allowed query before outputting $I/d$.

For fixed $\kappa=C/L\ge 1$, (Q7) proves the sharp limit

```math
 \lim_{LT\to\infty}E_{1,d}(\kappa L,L,T)=\frac1{2\kappa}.
```

Hence one query asymptotically cannot improve the leading worst-case error of the completely uninformative output. The finite-T lower bound does not exclude a smaller improvement of vanishing relative size. In contrast, the preserved two-query construction achieves zero error with $\kappa=35 \zeta(3)/\pi^3$, uniformly in $T$. For instance, attaining trace-norm error at most half the uninformative risk requires $LT\le32\kappa$ by (Q7). These constants are only explicit witnesses, not an optimal finite-$LT$ transition.

## 4. Constructive one-query upper bound of exponential order

This section supplies an explicit high-pass filter and shows that the exponential lower bound has the correct logarithmic order.

Set

```math
 J=\left\lfloor\frac{2LT}{\pi}\right\rfloor,\quad
 m=2J+4,\quad s_j=\frac{j\pi}{2L}.
```

Let $F$ be the odd $4L$-periodic sawtooth equal to $\omega$ on $(-2L,2L)$. Let $h$ be the convolution of $m$ uniform probability densities on $[-L/m,L/m]$. Define periodic convolution $F_0=F*h$, and the differential operator

```math
 \mathcal P_J=\prod_{k=1}^{J}
 \left[1+\left(\frac{2L}{\pi k}\right)^2\frac{d^2}{d\omega^2}\right].
```

An empty product is the identity. Since $h$ is symmetric with support $[-L,L]$, $F_0(\omega)=\omega$ for $|\omega|\le L$. The equality follows directly by integrating $F(\omega-x)=\omega-x$; boundary wrapping affects only null endpoints. The function $F_0$ is $C^{m-1}$, so after the $2J$ derivatives, $F_J=P_J F_0$ is at least $C^3$. On the interior of $[-L,L]$ all second and higher derivatives of $F_0$ vanish, so $F_J=\omega$ there; continuity gives the same identity at the endpoints.

The sine coefficients are explicit:

```math
 a_j=\frac{4L}{\pi}\frac{(-1)^{j+1}}{j}
 \operatorname{sinc}\left(\frac{\pi j}{2m}\right)^m
 \prod_{k=1}^{J}\left(1-\frac{j^2}{k^2}\right).           \tag{Q8}
```

They vanish for $1\le j\le J$. For $j>J$,

```math
 |a_j|\le\frac{4L}{\pi(J!)^2}j^{2J-1}
 \min\{1,(m/j)^{2J+4}\}.                               \tag{Q9}
```

Here $|\operatorname{sinc}(\pi j/(2m))|\le\min(1,2m/(\pi j))\le\min(1,m/j)$. In particular the tail is $O(j^{-5})$, and both the Fourier series and its first absolute time moment converge. Standard Fourier convergence, or absolute summability plus uniqueness of the Fourier coefficients of $F_J$, gives the exact identity

```math
 \omega=\sum_{j>J}a_j\sin(\omega s_j),\quad |\omega|\le L. \tag{Q10}
```

All retained times are strictly allowed: $s_j>T$ when $j>J$.

Put $C_J=\sum_{j>J}|a_j|$. Since (Q10) holds at $\omega=L$, $C_J\ge L$. The following coarse explicit bounds suffice:

```math
 \boxed{L\le C_J\le3L(6e)^{2J},\qquad
 M_1:=\sum_{j>J}|a_j|s_j
 \le\frac83\frac{m^{2J+1}}{(J!)^2}.}                    \tag{Q11}
```

For $J\ge 1$, summing (Q9) separately over $j\le m$ and $j>m$ gives

```math
 C_J\le\frac{4L}{\pi(J!)^2}
       \left[m^{2J}+\frac14m^{2J}\right]
       =\frac{5L}{\pi}\frac{m^{2J}}{(J!)^2}
       \le\frac{5L}{\pi}(6e)^{2J}.
```

Use $m\le 6J$ and $J!\ge (J/e)^J$. For $J=0$, $m=4$, and the analogous bound is $C_0\le28L/(3\pi)<3L$. Multiplying (Q9) by $s_j$ gives head sum at most $2m^{2J+1}/(J!)^2$ and tail at most $(2/3)m^{2J+1}/(J!)^2$, proving the second estimate.

### Physical realization with one unknown query

Use a known identity Choi state $|I\rangle$ and the queried Choi state $|e^{-is_jH}\rangle$. The same global partial-SWAP identity proved in Appendix A, baseline Section 2 produces

```math
 \rho_b(s_j)=\frac{I+bG_H(s_j)}d,\qquad
 G_H(s)=-\operatorname{Im}\{\overline{\tau(e^{-isH})}e^{-isH}\}.
```

This uses exactly one unknown forward query because the other Choi state is known. Sample $j$ with probability $|a_j|/C_J$ and use $b=\operatorname{sign}(a_j)$. For eigenvalues $E_r$,

```math
 [G_H(s)]_{rr}=\frac1d\sum_\ell\sin((E_r-E_\ell)s).
```

Equation (Q10) and absolute convergence imply

```math
 \sum_{j>J}a_jG_H(s_j)=H-\tau(H)I,
```

so the unconditional output is exactly $R_H(C_J)$. There is no quantum postselection. The expected unknown evolution time is $M_1/C_J<\infty$. The time distribution has unbounded support. Classical exact sampling of the explicit computable weights is an ideal-model operation; no finite worst-case random-bit or running-time claim is needed.

Consequently, for the infimal normalization $C_1^*(L,T)$ over all one-query exact protocols,

```math
 \frac{e^{LT/e-1}}{2LT}
 \le\frac{C_1^*(L,T)}L
 \le3\exp\left(\frac{4\log(6e)}\pi LT\right)
 \quad(LT\ge2e),
```

and therefore $\log(C_1^*/L)=\Theta(LT)$ as $LT$ grows. The exponential-order statement is proved; matching exponent constants are not claimed.


## 5. Definitions and main conclusions

Let $L>0$. A filter is a finite real signed Borel measure $\mu$ on $[0,\infty)$. Write

```math
 f_\mu(\omega)=\int_0^\infty\sin(\omega s)\,d\mu(s),\qquad
 C_\mu=\|\mu\|_{\mathrm{TV}},\qquad
 M_\mu=\int_0^\infty s\,d|\mu|(s)\in[0,\infty].
```

The physical units are: $L,C_\mu$ have units of inverse time, while $M_\mu$ is dimensionless. The exact constraint is $f_\mu(\omega)=\omega$ for $|\omega|\le L$.

For $\Delta,\varepsilon\ge0$, define

```math
 \mathcal M_L(\Delta,\varepsilon)
 =\inf_\mu\left\{M_\mu:
 C_\mu\le L+\Delta,
 \sup_{|\omega|\le L}|f_\mu(\omega)-\omega|\le\varepsilon\right\}.
 \tag{F1}
```

The infimum is over all such signed measures, including nondiscrete ones. Infinite first moments are permitted in the definition. Set the infimum of an empty set to $+\infty$.

**Main theorem.** Uniformly for $0 \lt r=\Delta+\varepsilon\le L/4$,

```math
 \frac2\pi\left[\log\frac{2L}{r}-6\right]
 \le \mathcal M_L(\Delta,\varepsilon)
 \le \frac2\pi\log\frac Lr+2.
 \tag{F2}
```

In particular,

```math
 \mathcal M_L(\Delta,\varepsilon)
 =\frac2\pi\log\frac{L}{\Delta+\varepsilon}+O(1),
 \qquad (\Delta+\varepsilon)/L\longrightarrow0,
 \tag{F3}
```

where the $O(1)$ is independent of $L$, of the relative sizes of $\Delta$ and $\varepsilon$, and of the choice between discrete and continuous filters. At $\Delta=\varepsilon=0$, $\mathcal M_L(0,0)=+\infty$.

For exact filters a stronger explicit lower bound is available. If $C_\mu=L+D>L$, then

```math
 M_\mu\ge\frac2\pi J\!\left(\frac{2L}{D}\right),
 \quad
 J(v)=2\log\frac{1+\sqrt{1+v}}2
       +\frac{2}{1+\sqrt{1+v}}-1.
 \tag{F4}
```

Here $J(v)=\log v-2\log2-1+o(1)$ as $v\to\infty$. Thus the logarithmic coefficient $2/\pi$ in (F3) cannot be improved.

## 6. The endpoint-defect inequality

The main lower bound is an endpoint saturation argument that controls oscillatory cancellation through the *same* increment whose first moment is being bounded. A uniform $O(\sqrt D)$ error bound would lose a factor two in the logarithmic coefficient; the following self-consistent bound avoids that loss.

Let $\sigma=d\mu/d|\mu|$, with $\sigma\in\{-1,1\}$ almost everywhere. Put

```math
 D=C_\mu-f_\mu(L)
   =\int\bigl(1-\sigma(s)\sin(Ls)\bigr)\,d|\mu|(s)\ge0,
```

and for $u\ge0$,

```math
 A(u)=\int\bigl(1-\cos(us)\bigr)\,d|\mu|(s)\ge0.
```

For every $u\ge0$, the trigonometric identity

```math
 \sin(Ls)-\sin((L-u)s)
 =\sin(Ls)(1-\cos(us))+\cos(Ls)\sin(us)
```

gives

```math
 f_\mu(L)-f_\mu(L-u)
 \le A(u)+2\sqrt{D A(u)}.
 \tag{F5}
```

Indeed, $\sigma\sin(Ls)\le1$, so the first integral is at most $A(u)$. For the second integral, Cauchy–Schwarz and

```math
 \begin{aligned}
 \cos^2(Ls)&=(1-\sigma\sin(Ls))(1+\sigma\sin(Ls))
 \le2(1-\sigma\sin(Ls)),\\
 \sin^2(us)&\le2(1-\cos(us)).
 \end{aligned}
```

give absolute value at most $2\sqrt{D A(u)}$.

All integrals here exist because $\mu$ has finite total variation; no first-moment assumption was used.

### Fractional-moment identity

Tonelli's theorem yields, including the possibility $+\infty$,

```math
 \int_0^\infty\frac{A(u)}{u^2}\,du
 =\int d|\mu|(s)\int_0^\infty\frac{1-\cos(us)}{u^2}\,du
 =\frac\pi2 M_\mu.
 \tag{F6}
```

The scalar identity follows by the change of variables $v=us$, integration by parts, and $\int_0^\infty\sin v/v\,dv=\pi/2$; it is trivial at $s=0$.

## 7. Exact-filter lower bound and the optimal endpoint

For an exact filter, $f_\mu(L)=L$, hence $C_\mu\ge L$. For $0\le u\le2L$, both $L$ and (L-u) lie in the constrained interval, so (F5) becomes

```math
 u\le A(u)+2\sqrt{D A(u)},\qquad D=C_\mu-L.
```

If $D>0$, solving this quadratic inequality in $\sqrt{A(u)}$ gives

```math
 A(u)\ge\bigl(\sqrt{u+D}-\sqrt D\bigr)^2.
 \tag{F7}
```

Therefore (F6), restricted to $[0,2L]$, implies

```math
 M_\mu\ge\frac2\pi\int_0^{2L}
 \frac{(\sqrt{u+D}-\sqrt D)^2}{u^2}\,du.
```

With $v=u/D$, the integrand reduces to $1/(1+\sqrt{1+v})^2$. Substituting $w=1+\sqrt{1+v}$ evaluates the integral as $J(2L/D)$, proving (F4).

If $D=0$, (F5) says $A(u)\ge u$ on $[0,2L]$, and (F6) diverges logarithmically at zero. Thus every exact filter with finite first moment has **strictly** $C_\mu>L$.

### The minimal-total-variation endpoint and uniqueness

When $C_\mu=L$, the nonnegative integrand defining $D$ vanishes $|\mu|$-almost everywhere. Thus $\mu$ is supported on

```math
 s_j=\frac{(2j+1)\pi}{2L},\qquad j=0,1,2,\ldots,
```

with signs $\operatorname{sign}\mu\{s_j\}=(-1)^j$. The functions $\sin(s_j\omega)$ are orthogonal on $[0,L]$, with squared norm $L/2$. Absolute convergence permits integration term by term against each one, hence

```math
 \mu\{s_j\}
 =\frac2L\int_0^L\omega\sin(s_j\omega)\,d\omega
 =\frac{2(-1)^j}{L s_j^2}
 =\frac{8L(-1)^j}{\pi^2(2j+1)^2}.
 \tag{F8}
```

Conversely these coefficients give the sine series of the odd triangular wave that equals $\omega$ on $[-L,L]$, and their absolute sum is $L$. Their first moment is

```math
 \frac4\pi\sum_{j=0}^\infty\frac1{2j+1}=+\infty.
```

Theis's Nyquist rule and optimal support/sign conditions are the relevant existing results. The uniqueness calculation above is included to make the endpoint statement precise, not as the primary novelty claim.

## 8. Explicit exact filters approaching the endpoint

Fix $h>0$, let $W=L+h$, and define the odd $4W$-periodic triangular wave $F_W$ by

```math
 F_W(\omega)=\omega\ (0\le\omega\le W),\qquad
 F_W(\omega)=2W-\omega\ (W\le\omega\le2W).
```

Its sine series is

```math
 F_W(\omega)=\sum_{j=0}^\infty
 \frac{8W(-1)^j}{\pi^2(2j+1)^2}
 \sin\!\left(\frac{(2j+1)\pi\omega}{2W}\right).
```

Let $\kappa_h(x)=(h-|x|)_+/h^2$, the triangular probability density on $[-h,h]$. Its mean is zero, $\mathbb E|X|=h/3$, and Fourier multiplier is

```math
 \int e^{isx}\kappa_h(x)\,dx
 =\operatorname{sinc}^2(hs/2),\qquad
 \operatorname{sinc}(z)=\begin{cases}\sin z/z,&z\ne0,\\1,&z=0.\end{cases}
```

Because $W=L+h$, every shifted point $\omega-x$, for $|\omega|\le L$, $|x|\le h$, lies in the linear segment $[-W,W]$. Hence

```math
 (F_W*\kappa_h)(\omega)=\omega\quad(|\omega|\le L).
```

Thus an exact filter is given by

```math
 s_j=\frac{(2j+1)\pi}{2W},\qquad
 c_j=\frac{8W(-1)^j}{\pi^2(2j+1)^2}
       \operatorname{sinc}^2\!\left(\frac{h s_j}{2}\right).
 \tag{F9}
```

The squared sinc is nonnegative; the coefficient signs remain $(-1)^j$. At $\omega=W$, $\sin(Ws_j)=(-1)^j$. Moreover $F_W(W-x)=W-|x|$ on the support of $\kappa_h$, since $h \lt W$. Consequently

```math
 C_h=\sum_j|c_j|=(F_W*\kappa_h)(W)
 =W-\frac h3=L+\frac{2h}{3}.
 \tag{F10}
```

This is an equality, not merely a norm upper bound. Given any allowed excess $\Delta>0$, choosing $h=3\Delta/2$ realizes $C_h=L+\Delta$ exactly.

### First moment, exact integral, and sharp asymptotic

Set $a=\pi h/(4W)\in(0,\pi/4)$. Then

```math
 M_h=\frac4\pi\sum_{j=0}^\infty
 \frac{\operatorname{sinc}^2(a(2j+1))}{2j+1}
 =\frac4{\pi a^2}\int_0^a(a-t)\log\cot t\,dt.
 \tag{F11}
```

To check the second identity, set $S(a)=\sum_{m\ge1,\ m\,\mathrm{odd}}\sin^2(am)/m^3$. The classical cosine series gives

```math
 S''(a)=2\sum_{m\,\mathrm{odd}}\frac{\cos(2am)}m
       =\log\cot a,
 \qquad0 \lt a<\pi/2.
```

The series for $S$ and $S'$ converge uniformly, with $S(0)=S'(0)=0$. The second-derivative identity is justified on compact subintervals by Abel regularization of the cosine series, then integrated twice; its logarithmic singularity at zero is integrable. This yields (F11).

Since $\tan t\ge t$, $\log\cot t\le-\log t$. Therefore

```math
 M_h\le\frac2\pi\log\frac{4W}{\pi h}+\frac3\pi.
 \tag{F12}
```

Also $\log\cot t=-\log t+O(t^2)$ as $t\downarrow0$, so

```math
 M_h=\frac2\pi\log\frac{4W}{\pi h}+\frac3\pi
       +O((h/W)^2).
 \tag{F13}
```

For $h=3\Delta/2$ this becomes

```math
 M_h=\frac2\pi\log\frac L\Delta
 +\frac2\pi\log\frac8{3\pi}+\frac3\pi+o(1).
 \tag{F14}
```

The exact filter has finite first and second time moments: its coefficients decay as $O(j^{-4})$ for fixed $h>0$. No bounded-support or exponentially concentrated exact-filter claim is made.

### Sampling

The magnitude distribution in (F9), divided by $C_h$, can be sampled by proposing an odd positive integer $m$ with probability $8/(\pi^2m^2)$, then accepting with probability $\operatorname{sinc}^2(am)$. Its mean acceptance probability is $C_h/W>0$. The odd inverse-square proposal admits an exact rational dyadic rejection sampler: draw $k\ge0$ with probability $2^{-k-1}$; choose an integer $m$ uniformly in $\{2^k,\ldots,2^{k+1}-1\}$; retain only odd $m$ and accept with probability $2^{2k}/m^2$. A trial accepts $m$ with probability $1/(2m^2)$, so conditioning gives the stated proposal. For computable parameters the squared-sinc Bernoulli step can be implemented using successively refined real arithmetic and fair bits, terminating almost surely. Classical bit complexity is not included in the oracle-time claim.

## 9. Uniform approximation: lower bound

Suppose $C_\mu\le L+\Delta$ and the error is at most $\varepsilon$ on $[-L,L]$. Then

```math
 0\le D=C_\mu-f_\mu(L)\le\Delta+\varepsilon=r.
```

For $0\le u\le2L$,

```math
 u-2\varepsilon
 \le f_\mu(L)-f_\mu(L-u)
 \le A(u)+2\sqrt{r A(u)}.
```

Solving the quadratic where the left side is nonnegative, and using $A(u)\ge0$ elsewhere, gives

```math
 A(u)\ge
 \left(\sqrt{r+(u-2\varepsilon)_+}-\sqrt r\right)^2
 \ge u-2\varepsilon-2\sqrt{ru}.
 \tag{F15}
```

The last inequality uses $\sqrt{r+x}\le\sqrt r+\sqrt x$, and is also true when $u<2\varepsilon$, because the right side is then negative.

For $0 \lt r\le2L$, integrate the last lower bound over $[r,2L]$ using (F6):

```math
 \begin{aligned}
 M_\mu
 &\ge\frac2\pi\left[
 \log\frac{2L}{r}
 -2\varepsilon\left(\frac1r-\frac1{2L}\right)
 -4\left(1-\sqrt{\frac r{2L}}\right)
 \right]\\
 &\ge\frac2\pi\left[\log\frac{2L}{r}-6\right],
 \end{aligned}
 \tag{F16}
```

because $\varepsilon\le r$. This proves the lower side of (F2).

## 10. Uniform approximation: matching construction

If $\Delta\ge\varepsilon$ and $\Delta>0$, use the exact construction (F9) with $h=3\Delta/2$. For $\Delta/L\le1/4$, (F12) gives

```math
 M_h\le\frac2\pi\log\frac L\Delta
       +\frac2\pi\log\frac{11}{3\pi}+\frac3\pi
 \le\frac2\pi\log\frac Lr+2,
```

where $r/\Delta\le2$. The final numerical constant is deliberately loose; it follows from $3<\pi$ and elementary bounds on the logarithm.

If $\varepsilon\ge\Delta$ and $\varepsilon>0$, truncate the optimal Nyquist coefficients (F8) at $j=N-1$, with

```math
 N=\left\lceil\frac{2L}{\pi^2\varepsilon}\right\rceil.
```

The tail is at most $2L/(\pi^2N)\le\varepsilon$. Indeed, convexity of $x\mapsto(2x+1)^{-2}$ on each unit interval gives

```math
 \sum_{j=N}^\infty\frac1{(2j+1)^2}
 \le\int_{N-1/2}^\infty\frac{dx}{(2x+1)^2}
 =\frac1{4N}.
```

Thus $\|f_N-\operatorname{id}\|_{\infty,[-L,L]}\le\varepsilon$ and $C_N \lt L$, while

```math
 M_N=\frac4\pi\sum_{j=0}^{N-1}\frac1{2j+1}
 \le\frac4\pi+\frac2\pi\log(2N-1).
```

If $\varepsilon/L\le1/4$, then

```math
 2N-1\le\frac{4L}{\pi^2\varepsilon}+1\le\frac L\varepsilon,
```

so

```math
 M_N\le\frac2\pi\log\frac L\varepsilon+\frac4\pi
 \le\frac2\pi\log\frac Lr+\frac{4+2\log2}{\pi}
 <\frac2\pi\log\frac Lr+2.
```

This proves the upper side of (F2), including both boundary cases $\Delta=0$ and $\varepsilon=0$. When both vanish, the exact endpoint argument proves infinite cost.

## 11. Operational interpretation for the inherited affine-state interface

The baseline proof in Appendix A proves that, after two Choi queries of durations $t_0>T$ and $t_0+s$, a known partial SWAP yields

```math
 \rho_b(s)=\frac{I+bG_H(s)}d,\quad b\in\{-1,1\},\quad
 [G_H(s)]_{rr}=\frac1d\sum_\ell\sin((E_r-E_\ell)s).
```

For any chosen normalization $C\ge C_\mu$, randomize the sign and shift with measure $d|\mu|/C$, and fill the remaining probability with $s=0$, whose output is $I/d$. The zero-shift branch still uses two allowed queries of duration $t_0$. The output is

```math
 \rho_{H,\mu,C}=\frac1d\left(I+\frac{H_{f_\mu}}C\right),
 \qquad
 [H_{f_\mu}]_{rr}=\frac1d\sum_\ell f_\mu(E_r-E_\ell).
 \tag{F17}
```

Its expected total unknown evolution time is exactly

```math
 2t_0+\frac{M_\mu}{C}.
 \tag{F18}
```

Conversely, any random mixture of these signed partial-SWAP experiments determines an effective signed measure $\mu=C(q_+-q_-)$. Its total variation is at most $C$, and its first moment is at most $C$ times the actual mean extra duration. Hence the lower bounds apply to the entire randomized mixture class, even if the implementation uses cancellations or redundant branches.

If $f_\mu=\operatorname{id}$ on $[-L,L]$, (F17) is the exact affine state $(I+(H-\tau(H)I)/C)/d$. Conversely, exactness for all two-dimensional Hamiltonians of spectral diameter at most $L$ forces the same sine-multiplier identity: apply (F17) to eigenvalues $\pm\omega/2$.

It follows that, for **this complete mixture architecture**, the endpoint normalization $C=L$ is possible only with infinite expected additional duration. Every $C>L$ is possible with finite duration, and as $C\downarrow L$,

```math
 \inf\mathbb E[s]
 =\frac2{\pi C}\log\frac{L}{C-L}+O(C^{-1}).
 \tag{F19}
```

The state has a legitimate normalization $C\ge L$ independent of dimension. The lower bound in (F19) must **not** be described as excluding faster general two-query circuits outside the partial-SWAP mixture architecture.

### Approximate states in trace norm

If the scalar multiplier error is at most $\varepsilon$, then $\|H_{f_\mu}-(H-\tau(H)I)\|\le\varepsilon$, so the trace norm from the target affine state is at most $\varepsilon/C$. Conversely, a uniform trace-norm error $\eta$ for all allowed Hamiltonians implies, by the qubit test above, $\sup_{|\omega|\le L}|f_\mu(\omega)-\omega|\le2C\eta$.

Thus the minimum mean extra duration in this architecture, with target normalization $C=L(1+\delta)$, satisfies the sharp leading-order tradeoff

```math
 \inf\mathbb E[s]
 =\frac2{\pi C}\log\frac1{\delta+\eta}+O(C^{-1})
 \quad\text{as }\delta+\eta\downarrow0,
 \tag{F20}
```

uniformly for $\delta,\eta\ge0$. Here the equality means matching upper and lower bounds up to additive $O(C^{-1})$, not an exact finite-parameter formula. At $\delta=\eta=0$, the mean is infinite. The fixed multiplicative constants in the scalar/state error comparison only change the additive constant.

## 12. Large-minimum-duration statistical cost in this architecture

For the standard single-Pauli readout of an exact affine state, multiply the outcome by $C$. Its second moment is exactly $C^2$, independently of the target coefficient. For local random Pauli readout of a weight-$k$ observable, the same statement is $3^k C^2$. Consider the specific variance-proxy-times-mean-evolution objective

```math
 \mathcal J_L(t_0)
 =\inf_{\mu\ {\mathrm{exact}}}
 \left(2t_0 C_\mu^2+C_\mu M_\mu\right),\qquad t_0>T.
 \tag{F21}
```

This is the exact product of the single-Pauli score second moment and mean query time for the canonical exact preparation. It is not a claim about the minimax risk of all measurements, and it does not by itself provide a deterministic total-time bound. The existing budget-cap wrapper can be used for such a bound at a constant-factor loss.

As $r=t_0L\to\infty$,

```math
 \mathcal J_L(t_0)
 =2t_0L^2+\frac{2L}{\pi}\log(t_0L)+O(L).
 \tag{F22}
```

**Upper bound.** Choose $x=(C-L)/L=1/(2\pi r)$, use (F9), and substitute $M=(2/\pi)\log(1/x)+O(1)$. Then

```math
 \frac{2t_0C^2+CM}{L}
 =2r(1+x)^2+(1+x)M
 =2r+\frac2\pi\log r+O(1).
```

**Lower bound.** For $0 \lt x\le1/4$, (F16) with zero approximation error gives $M\ge(2/\pi)\log(1/x)-K$ for an absolute $K$. Since $M\ge0$,

```math
 2r(1+x)^2+(1+x)M
 \ge2r+4rx+\frac2\pi\log\frac1x-K.
```

The scalar expression $4rx+(2/\pi)\log(1/x)$ is minimized at $x=1/(2\pi r)$, where it equals $(2/\pi)\log r+O(1)$. For $x>1/4$, the first term alone exceeds $2r$ by a positive multiple of $r$, which is stronger than the desired logarithmic bound once $r$ is large. This proves (F22).

An exact objective with fixed chosen scale $C\ge C_\mu$ cannot improve the infimum: both $2t_0C^2$ and $CM_\mu$ increase in $C$. The conclusion stays within the specified estimator/interface architecture.



## 13. Interpretation, implementation and limits

The universal and architectural optimality claims are different. The reduction
of any one-call experiment to a bounded signed sine measure uses only the
single-query channel, complete positivity, and the absence of postselection.
It therefore proves a property of the full one-call oracle model. The frontier
in (F2) instead optimizes mixtures of a particular physical converter. Other
two-call quantum processors are not reduced to that mixture and may have a
different normalization/time tradeoff.

The high-pass upper construction uses one queried Choi register and one known
identity Choi register. The two-call construction uses two queried Choi
registers whose long common baseline cancels. Both output genuine density
matrices with signs encoded in known partial-SWAP gates. Exact versions use
countably supported random times; their expected oracle time is finite at the
normalizations stated. No finite worst-case time or finite worst-case bit
complexity is claimed for an exact sample. Finite truncations yield approximate
states, and the baseline appendix separately gives a deterministic-budget
learning algorithm. These are distinct guarantees.

The two-call filter constructions can approach the architecture's normalization
endpoint $L$, but doing so costs a logarithm in mean extra duration. In the
large-baseline regime, (F22) balances that cost against the square of the signal
normalization. This gives an explicit optimization of a stated readout
objective. It is not a universal minimax learning theorem, a better unknown-
support algorithm, or a statement of robustness to arbitrary device noise.

The mandatory minimum duration is independent of the precision with which a
chosen duration can be specified. Fixed coarse grids, controlled unknown
evolution, quantum-superposed durations, parameter-dependent supplied advice,
measurement postselection and unrestricted coherent learning are different
access models. The lower bounds do not silently extend to those models.

The analytic proofs establish the universal statements. Reproduction code
checks finite channel instances, spline-filter truncations, exact symbolic
identities and independent evaluations of the moment integral. Such tests do
not substitute for the proofs or constitute end-to-end formal verification.
The precise exponent in the one-call optimum and the global two-call optimum
remain open within this manuscript; neither is included in its established
contribution.

# Appendix A. Complete baseline converter and learning proofs

The following baseline theorem statements and proofs are retained with local
section numbering. Their Theorems A--C, Lemmas 1--2 and equation labels are
local to this appendix. The new resource classification above supplements
these claims without altering their original model or scope.

### 1. Problem, model and results

A minimum duration restricts how soon unknown evolution may be interrupted. It does not restrict the precision with which a long duration can be specified. Tang's long-time Hamiltonian-learning question [1] motivates this distinction. Subsequent papers address different combinations of sparsity, ancillas, controls, precision and allowed durations [2,3,7,9,10]. In particular, Zhang already states the two-Choi cancellation used below [3]. Reusing that identity must not be described as a new solution of the entire original question.

Our narrower question is operational: can two allowed evolutions produce a physical mixed state usable in subsequent measurement tasks whose Pauli expectations are exactly linear in the unknown Hamiltonian, with controlled time cost? We answer this mathematical question and establish a learning consequence. The state is mixed and affine, unlike a pure pseudo-Choi amplitude encoding [9]. Partial-SWAP state addition and approximate imaginary-time constructions are established prior work [5,6].

We use the normalized trace $\tau(A)=\operatorname{Tr}(A)/d$, where $d=2^n$, and operator norm $\|\cdot\|$. The Hamiltonian is fixed throughout the experiment. Access is to the channel induced by $U(t)=e^{-itH}$ for chosen real $t>T$, with $T>0$. Known gates, reference ancillas, preparation of Bell pairs, and coherent storage within an experiment are available. Only unknown-evolution time and calls are counted as oracle resources; gate count, memory and classical processing are stated separately. There is no access to a controlled unknown unitary or its inverse. All guarantees are ideal-channel guarantees.

An identity component of $H$ is invisible to this oracle, so the encoded operator must be $H_0=H-\tau(H)I$. A known spectral-diameter bound $L>0$ suffices. When a norm bound $\|H\|\le B$ is supplied, set $L=2B$.

#### Theorem A: exact affine-state preparation with finite expected cost

Let $H$ be a time-independent Hermitian operator on $n$ qubits, $d=2^n$, and let $\tau=\operatorname{Tr}/d$. Suppose its spectral diameter is at most a known $L>0$. Access to the unknown channel
```math
\mathcal U_t(X)=e^{-itH}Xe^{itH}
```
is allowed only for chosen durations $t>T$. Reference ancillas, coherent storage within a two-copy experiment, and known gates are allowed.

Define
```math
C=\gamma L,\qquad
\gamma=\frac{35\zeta(3)}{\pi^3}<2.
```
There is a randomized preparation procedure whose unconditional output state is exactly
```math
\rho_H=\frac1d\left(I+\frac{H-\tau(H)I}{C}\right).
\tag{A}
```
Each completed state preparation uses exactly two ordinary forward queries, both longer than $T$, followed by known gates and discarding registers. It uses no controlled unknown oracle, no unknown inverse, and no measurement postselection.

With the baseline $t_0=T+L^{-1}$, its expected total unknown evolution time is exactly
```math
2t_0+\frac3C=O(T+L^{-1}).
\tag{B}
```
The query durations have unbounded support in this exact preparation theorem; only the expectation is bounded. Each sampled duration is finite almost surely. The procedure needs $4n+1$ qubits when the partial SWAP is implemented with standard gates and an uncomputed ancilla.

For a traceless Hamiltonian, (A) is $(I+H/C)/d$. Without tracelessness, centering is indispensable because an identity component is not observable from channel evolution.

#### Theorem B: finite implementation and simultaneous coefficient learning

Let $P_1,\ldots,P_m$ be known nonidentity Hermitian Pauli strings of weight at most $k$, and put
```math
\lambda_a=\tau(P_aH).
```
Under Theorem A's access model, for $0<\varepsilon\le L/2$ and $0<\eta<1$, a finite randomized algorithm outputs estimates satisfying
```math
\Pr\!\left(\max_{a\le m}
|\widehat\lambda_a-\lambda_a|\le\varepsilon\right)
\ge1-\eta.
```

Its total unknown evolution time is deterministically bounded, for every random realization, by
```math
O\!\left(
3^k(L^2T+L)\varepsilon^{-2}
\log\frac{2m}{\eta}
\right),
\tag{C}
```
and its number of oracle calls is
```math
O\!\left(
3^kL^2\varepsilon^{-2}\log\frac{2m}{\eta}
\right).
\tag{D}
```
All requested coefficients share the same experimental data; there is no multiplicative $m$ in the experiment count. Known-gate cost is $O(n)$ per experiment, and direct classical score computation costs $O(mk)$ per experiment. The longest individual query is
```math
O\!\left(T+\frac1{\sqrt{L\varepsilon}}\right).
```
For a known bound $\|H\|\le B$, take $L=2B$. This gives the bound
$O(3^k(B^2T+B)\varepsilon^{-2}\log(2m/\eta))$.

The $\varepsilon^{-2}$ upper bound is separate from the Heisenberg
$\varepsilon^{-1}$ question. No unrestricted lower bound is asserted in this upper-bound note.

### 2. A two-Choi partial-SWAP preparation

The two-Choi cancellation is present in Zhang [3, Eq. (4)]. The partial-SWAP reduced channel is standard [5,6]. We combine these ingredients to retain an actual output state, rather than only an expectation-value identity.

Write $U(t)=e^{-itH}$, and set $t_0=T+L^{-1}$. For $s>0$, prepare
```math
|x\rangle=|U(t_0)\rangle,\qquad
|y\rangle=|U(t_0+s)\rangle,
```
where
```math
|V\rangle=(V\otimes I)|\Phi_d\rangle,\qquad
|\Phi_d\rangle=d^{-1/2}\sum_j|jj\rangle.
```
Let $\rho=|x\rangle\langle x|$ and
$\sigma=|y\rangle\langle y|$, each acting on a full $2n$-qubit Choi register.

Let $S$ swap the two entire Choi registers. For $b\in\{-1,+1\}$, apply the known unitary
```math
W_b=e^{ib\pi S/4}=\frac{I+ibS}{\sqrt2}
```
to $\rho\otimes\sigma$. Discard the second Choi register and the reference half of the first one, retaining its $n$-qubit output system.

#### Lemma 1: exact output state

With
```math
a(s)=\tau(U(s)),\qquad
G(s)=-\operatorname{Im}\!\left(\overline{a(s)}U(s)\right),
\quad
\operatorname{Im}A=\frac{A-A^\dagger}{2i},
```
the retained state is
```math
\rho_b(s)=\frac{I+bG(s)}d.
\tag{1}
```

**Proof.** The partial-SWAP expansion and standard swap identities give
```math
\begin{aligned}
\operatorname{Tr}_2\!\left[
W_b(\rho\otimes\sigma)W_b^\dagger\right]
&=\frac12\left(\rho+\sigma
+ib(\sigma\rho-\rho\sigma)\right),\\
\operatorname{Tr}_2[S(A\otimes B)]&=BA,\\
\operatorname{Tr}_2[(A\otimes B)S]&=AB.
\end{aligned}
```
Each Choi state has first-register output marginal $I/d$. Also
```math
\langle x|y\rangle
=\tau(U(t_0)^\dagger U(t_0+s))
=a(s).
```
The transition marginal is
```math
\operatorname{Tr}_{\mathrm{ref}}|y\rangle\langle x|
=\frac{U(t_0+s)U(t_0)^\dagger}{d}
=\frac{U(s)}d.
```
Consequently,
```math
\operatorname{Tr}_{\mathrm{ref}}(\sigma\rho-\rho\sigma)
=\frac{\overline{a(s)}U(s)-a(s)U(s)^\dagger}{d}.
```
Multiplying by $ib/2$ gives $-b\,\operatorname{Im}(\overline aU)/d$, proving (1). $\square$

This calculation fixes the sign: $W_b=e^{+ib\pi S/4}$ produces $I+bG$. Reversing its exponent reverses the encoded sign.

The operator $G(s)$ is Hermitian, has trace zero, and has norm at most one. The last assertion follows either from (1) for both signs or from $\|U(s)\|=1$ and $|a(s)|\le1$.

#### Known-gate implementation

Let $C_S$ denote a controlled full-register SWAP, let $H_{\mathrm{anc}}$ be the Hadamard gate on the ancilla, and define
```math
V=(H_{\mathrm{anc}}\otimes I)C_S(H_{\mathrm{anc}}\otimes I).
```
On an ancilla initially in $|0\rangle$, $V$ coherently records the $\pm1$ eigenspaces of $S$. Applying the known phase $e^{ib\pi Z_{\mathrm{anc}}/4}$ and then $V^\dagger$ implements $W_b$, returning the ancilla to $|0\rangle$. This uses two controlled full-register SWAPs. The global partial SWAP is not a tensor product of pairwise square-root-SWAP gates. Each controlled full-register SWAP is a product of $2n$ Fredkin gates, hence $O(n)$ standard gates overall. The unknown evolution is never controlled.

### 3. An explicit finite-cost derivative filter

Exact derivative shift rules are established tools [4]. Finite first-time-moment kernels and budgeted group amplification also appear in Zhou–Gong [7]. The role of the following closed-form filter is to make the state conversion and its constants explicit.

For $j\ge1$, put
```math
s_j=\frac{j\pi}{2L},\qquad
d_j=\cos\frac{j\pi}{2}-(-1)^j,\qquad
c_j=\frac{32L}{\pi^3}\frac{d_j}{j^3}.
\tag{2}
```
Thus $d_j=1$ for odd $j$, $d_j=-2$ for
$j\equiv2\bmod4$, and $d_j=0$ for $j\equiv0\bmod4$.

#### Lemma 2: exact multiplier and absolute moments

For every $|\omega|\le L$,
```math
\omega=\sum_{j=1}^{\infty}c_j\sin(\omega s_j).
\tag{3}
```
The series is absolutely and uniformly convergent, and
```math
\sum_j|c_j|=\frac{35\zeta(3)}{\pi^3}L=C<2L,
\qquad
\sum_j|c_j|s_j=3.
\tag{4}
```

**Proof.** Define an odd, $4L$-periodic function by
```math
F(\omega)=
\begin{cases}
\omega,&0\le\omega\le L,\\
\omega-\dfrac{2(\omega-L)^2}{L},
&L\le\omega\le2L.
\end{cases}
```
Its values and first derivatives match at $L$ and across the periodic endpoints. With $x=\pi\omega/(2L)$, the corresponding odd
$2\pi$-periodic function is
```math
G_0(x)=
\begin{cases}
x,&0\le x\le\pi/2,\\
x-\dfrac4\pi(x-\pi/2)^2,&\pi/2\le x\le\pi.
\end{cases}
```
Its sine coefficients are
```math
\frac2\pi\int_0^\pi G_0(x)\sin(jx)\,dx
=\frac{16}{\pi^2j^3}
\left(\cos\frac{j\pi}{2}-(-1)^j\right),
```
by two integrations by parts. Since $G_0$ is periodic $C^1$ and piecewise $C^2$, this absolutely convergent Fourier series equals $G_0$. Scaling back proves (3).

For the absolute sums,
```math
\sum_j\frac{|d_j|}{j^3}
=\left(1+\frac14\right)
\left(1-\frac18\right)\zeta(3)
=\frac{35}{32}\zeta(3),
```
and
```math
\sum_j\frac{|d_j|}{j^2}
=\left(1+\frac12\right)\frac{\pi^2}{8}
=\frac{3\pi^2}{16}.
```
Multiplying by the factors in (2) proves (4). The bound $C<2L$ follows from $\zeta(3)\le5/4$ and $\pi>3$. $\square$

### 4. Exact affine-state identity

Let $E_1,\ldots,E_d$ be the eigenvalues of $H$. In its eigenbasis,
```math
G(s)_{rr}=\frac1d\sum_{\ell=1}^d
\sin((E_r-E_\ell)s).
\tag{5}
```
Every difference lies in $[-L,L]$. Applying (3) to (5) and using absolute convergence gives
```math
\sum_jc_jG(s_j)
=H-\tau(H)I.
\tag{6}
```

Choose $j$ with probability $q_j=|c_j|/C$, and prepare the state
$\rho_{\operatorname{sign}(c_j)}(s_j)$ from Lemma 1. Then its unconditional density matrix is
```math
\sum_jq_j\rho_{\operatorname{sign}(c_j)}(s_j)
=\frac1d\left(I+\frac{H-\tau(H)I}{C}\right).
```
The expected total unknown time is
```math
\sum_jq_j(2t_0+s_j)=2t_0+\frac3C,
```
proving Theorem A. No outcome is selected or discarded according to a measurement result; the mixture is ordinary classical randomness followed by a deterministic quantum channel.

An explicit exact sampling description is available. With probability $4/5$, choose an odd positive integer $r$ with mass proportional to $r^{-3}$ and set $j=r,b=+1$. With probability $1/5$, choose the same odd-integer law and set $j=2r,b=-1$. This is precisely $q_j$. Such a distribution is computably samplable, but its support is infinite. The next section removes the infinite support from the learning theorem.

### 5. A finite affine approximation

Let
```math
M=\left\lceil\sqrt{\frac{8L}{\varepsilon}}\right\rceil,\qquad
C_M=\sum_{j=1}^M|c_j|,\qquad
H_M=\sum_{j=1}^M c_jG(s_j).
\tag{7}
```
Use the finite rational probabilities
```math
q_{j,M}=\frac{|c_j|}{C_M}\qquad(1\le j\le M),
```
omitting zero coefficients. The resulting exact output state is
```math
\rho_{H,M}=\frac1d\left(I+\frac{H_M}{C_M}\right).
\tag{8}
```
The probabilities are rational because the common factor $32L/\pi^3$ cancels.

The operator truncation error is bounded uniformly:
```math
\begin{aligned}
\|H_M-(H-\tau(H)I)\|
&\le\sum_{j>M}|c_j|\\
&\le\frac{64L}{\pi^3}\sum_{j>M}j^{-3}\\
&\le\frac{32L}{\pi^3M^2}
\le\frac{4\varepsilon}{\pi^3}<\frac{\varepsilon}{4}.
\end{aligned}
\tag{9}
```
Thus every nonidentity Pauli coefficient obeys
```math
|\tau(PH_M)-\lambda_P|<\varepsilon/4.
\tag{10}
```
Here $|\tau(PA)|\le\|A\|$, since $\|P\|_1=d$.

For the finite preparation,
```math
\begin{aligned}
\mathbb E[2t_0+s_j]
&\le2t_0+\frac3{C_M}\\
&\le2(T+L^{-1})+\frac{3\pi^3}{32L}
<2T+\frac5L=:\mu.
\end{aligned}
\tag{11}
```
We used $C_M\ge c_1=32L/\pi^3$ and $\pi^3<32$. The maximum query duration is $t_0+M\pi/(2L)$.

### 6. Shared random-Pauli measurements

The measurement rule is the standard local-Pauli shadow estimator [8]; its moments are included here for a self-contained resource calculation.

On every prepared $n$-qubit output state, independently choose
$b_i\in\{X,Y,Z\}$ uniformly for each qubit and record
$z_i\in\{-1,+1\}$. For a nonidentity $P$ of weight $w$, define
```math
X_P=C_M3^w
\left(\prod_{i\in\operatorname{supp}P}z_i\right)
\mathbf1\{b_i=P_i\text{ on }\operatorname{supp}P\}.
\tag{12}
```
The sign of the filter coefficient has already been encoded in the partial-SWAP choice $b$, so no additional sign belongs in this score.

Averaging over the preparation mixture and measurement gives
```math
\mathbb E X_P=C_M\operatorname{Tr}(P\rho_{H,M})
=\tau(PH_M).
\tag{13}
```
Since outcome signs square to one and basis matching has probability
$3^{-w}$,
```math
\mathbb E X_P^2=C_M^2\,9^w\,3^{-w}
=C_M^2\,3^w.
\tag{14}
```
This is the exact second moment. Different coordinates may be correlated, which does not affect the later coordinate-wise concentration and union bound. All coordinates use the same prepared states.

### 7. Fixed budget and simultaneous confidence

Set
```math
N=\left\lceil
\frac{32C_M^2\,3^k}{\varepsilon^2}
\right\rceil.
\tag{15}
```
For each independent group:

1. Draw $N$ filter indices $j_1,\ldots,j_N$ from the finite distribution.
2. If the planned unknown evolution time
   $\sum_{\ell=1}^N(2t_0+s_{j_\ell})$ exceeds $8N\mu$,
   mark the group unsuccessful and assign zero to every estimated coordinate.
3. Otherwise prepare the $N$ states, perform their independent random-Pauli measurements, and return the coordinate-wise sample means of (12).

The probability of a budget rejection is at most $1/8$ by Markov's inequality and (11). For a fixed coordinate, consider its hypothetical uncapped group mean. Its variance is at most $C_M^2 3^k/N$; hence
```math
\Pr\!\left(
|\overline X_P-\tau(PH_M)|>\varepsilon/2
\right)
\le\frac{4C_M^2 3^k}{N\varepsilon^2}
\le\frac18.
\tag{16}
```
Do not condition this inequality on budget acceptance. Couple the accepted group to the uncapped group and use a union bound. By (10), each actual group estimates each fixed coordinate within $3\varepsilon/4$ with probability at least $3/4$.

Choose the smallest odd integer $R\ge8\log(2m/\eta)$, run $R$ independent groups, and take the median separately for each coordinate. Hoeffding's inequality for group-failure indicators gives failure at most $e^{-R/8}$ per coordinate; a union bound over the $m$ coordinates gives at most $\eta$.

For every realization, the algorithm uses
```math
t_{\mathrm{tot}}\le8RN(2T+5/L),\qquad
\mathcal N\le2RN.
\tag{17}
```
Since $C_M<2L$, and the assumption $\varepsilon\le L/2$ absorbs the ceiling terms, this proves (C)-(D).

The state-preparation part contains no measurement postselection. The deterministic-budget wrapper in the learning algorithm can reject an entire *planned group before any oracle calls*, solely because its classically sampled schedule exceeds a known budget. That rejection is explicitly included in the failure probability. It does not alter Theorem A's exact-state claim, which is a separate expected-time statement.

### 8. Timing precision, classical complexity, and local families

The theorem is stated in the ideal exact chosen-time oracle model. The following perturbation bound quantifies timing error only; it is not a general noise-robustness theorem. From (5),
```math
\|G'(s)\|\le L.
```
Uniform relative-shift errors at most $\Delta$ therefore change $H_M$ by at most
```math
C_M L\Delta\le2L^2\Delta.
```
Choosing $\Delta\le\varepsilon/(8L^2)$ uses at most the remaining
$\varepsilon/4$ error allowance. This is a lower bound on query duration, not a permission to specify times only coarsely. The baseline is common to the two Choi copies; if each duration has its own error, use the induced error in their difference.

The finite index bound $M=O(\sqrt{L/\varepsilon})$ permits finite rational sampling and polynomial classical setup. Directly computing all $m$ scores costs $O(mk)$ per sample; outputting $m$ coefficients already entails at least linear classical output size.

For
```math
H=\sum_{a=1}^m\lambda_aP_a,\qquad|\lambda_a|\le J,
```
one may take $B=mJ$ and $L=2mJ$. For fixed locality $k$, polynomial $m,J,T$, the learning cost is polynomial in $n,1/\varepsilon,\log(1/\eta)$. In bounded-degree geometric locality with $m=O(n)$, $J=O(1)$, the simultaneous total evolution is
```math
O\!\left(
3^k(n^2T+n)\varepsilon^{-2}
\log\frac{2n}{\eta}
\right).
```
This supplies an explicit polynomial bound in the ancilla-assisted minimum-duration model. It is not a first resolution of Tang's broader question: earlier long-time learning results and Zhang's two-Choi initializer already bear directly on that question [1–3].

### 9. A matching lower bound for two-query batches

This proof uses the isospectral rotation family and Fisher-information method already used in Hamiltonian-learning lower bounds, including Zhou–Gong [7, Section 5]. Its role here is the explicit minimum-duration, bounded-batch resource comparison. Neither the hard family nor the information method is claimed as new.

#### Lower-bound model

Fix a known norm bound $B>0$, a minimum duration $T>0$, and an error tolerance $0<\varepsilon\le B/4$. A classical-adaptive, two-query-batch protocol consists of a sequence of experiments. At the beginning of each experiment it may, as a function of its complete preceding classical history and fresh classical randomness:

1. prepare an arbitrary state of query registers and arbitrarily many ancillary registers;
2. make at most two calls $U_\theta(t)=e^{-itH_\theta}$, each for a classically specified duration $t\ge T$, interspersed with arbitrary known, parameter-independent operations if desired; the call count and **all durations in this batch are fixed before its first unknown call**;
3. perform an arbitrary joint measurement and retain its classical outcome.

No quantum register carrying information about $\theta$ persists between experiments. The input state and known operations can depend on the preceding history, but, conditional on that history and the fresh classical random seed, the input state, durations, and operations are independent of $\theta$. All ancillary input states can be purified without weakening the lower bound. Both parallel two-copy experiments and coherent sequential two-query experiments are included. Classical adaptation of times is allowed **between** batches. A measurement inside a batch may not be used to choose a subsequent duration within that same batch; that more general model is outside this statement.

Assume that on **every** measurement and randomness history the sum of all unknown evolution durations is at most a deterministic physical-time budget $S$. If there is also a deterministic upper bound $Q$ on the number of unknown evolution calls, write that bound explicitly. The time constraint itself gives a query bound $\lfloor S/T\rfloor$. Free classical randomization and known operations need not be counted in $S$.

The goal is to estimate the coefficient of the specified Pauli $X$, with additive error at most $\varepsilon$ and success probability at least $2/3$, for every Hamiltonian in the following family:

```math
H_\theta=B(\cos\theta\,Z+\sin\theta\,X),
\qquad -\pi/6\le\theta\le\pi/6.
```

This is a traceless, one-qubit, two-term family of known Pauli support and operator norm exactly $B$. Tensoring it with the identity gives the same obstruction on any larger number of qubits. Its spectrum is $\{-B,+B\}$ for every parameter value. Its target coefficient is $\lambda_X(\theta)=B\sin\theta$.

#### Theorem C: one-coefficient lower bound

Every protocol satisfying the model and uniform success requirement above obeys

```math
Q\ge \frac{B^2}{1152\varepsilon^2}
```

for any valid deterministic query bound $Q$, and

```math
S\ge \frac{TB^2+B}{2304\varepsilon^2}.
```

Thus, for this model, the dependence

```math
\Omega\!\left(\frac{TB^2+B}{\varepsilon^2}\right)
```

holds even when only one known Pauli coefficient is requested. The constants are deliberately conservative. This theorem does not assert an optimal dependence on confidence, the number of requested coefficients, or their locality.

#### Proof of Theorem C

##### Step 1. A single long evolution has bounded information about the rotation axis

Write

```math
N_\theta=\cos\theta\,Z+\sin\theta\,X,
\qquad
N'_\theta=-\sin\theta\,Z+\cos\theta\,X.
```

Since $N_\theta^2=I$, the unknown evolution is exactly

```math
U_\theta(t)=\cos(Bt)I-i\sin(Bt)N_\theta.
```

Put $c=\cos(Bt)$ and $s=\sin(Bt)$. Its Hermitian parameter generator is

```math
G_\theta(t):=iU_\theta(t)^\dagger\partial_\theta U_\theta(t)
=csN'_\theta+i s^2N_\theta N'_\theta.
```

The two Hermitian matrices $N'_\theta$ and $iN_\theta N'_\theta$ are Pauli operators along orthogonal axes. They anticommute and square to the identity. Consequently

```math
G_\theta(t)^2=(c^2s^2+s^4)I=s^2I,
\qquad
\|G_\theta(t)\|=|\sin(Bt)|.
```

The identity remains true when the call acts on a subsystem with arbitrary ancillas. In particular, increasing $t$ cannot make the information about $\theta$ grow without bound: $\theta$ rotates eigenvectors, while the eigenvalues remain fixed.

##### Step 2. Information in a coherent batch

Conditional on a fixed classical history, consider a batch with $r\le2$ unknown calls at durations $t_1,\ldots,t_r$. Purify its input and all known channels. The parameter generator of its total unitary is a sum of unitary conjugates of the individual generators. The triangle inequality therefore gives

```math
\|G_{\mathrm{batch},\theta}\|
\le\sum_{j=1}^r|\sin(Bt_j)|.
```

The quantum Fisher information of a pure state evolving under this generator is $4\operatorname{Var}(G_{\mathrm{batch},\theta})$, at most four times its squared operator norm. Discarding registers or measuring cannot increase this bound. Hence the classical Fisher information $I_{\mathrm{batch}}(\theta)$ of any batch outcome satisfies

```math
\begin{aligned}
I_{\mathrm{batch}}(\theta)
&\le4\left(\sum_{j=1}^r|\sin(Bt_j)|\right)^2\\
&\le 8\sum_{j=1}^r\sin^2(Bt_j)\\
&\le 8\sum_{j=1}^r\min\{1,Bt_j\}.
\end{aligned}
```

The second inequality uses $r\le2$. For the third, $\sin^2 x\le\min\{1,x\}$ for every $x\ge0$.

##### Step 3. Classical adaptation preserves an additive information bound

Let $P_\theta$ denote the law of the complete classical transcript, including the algorithm's random choices and its final estimate. Conditional score increments from distinct experiments have mean zero, so their cross terms vanish. The Fisher-information chain rule yields

```math
I_{P}(\theta)
=\mathbb E_\theta\sum_{\text{batches }b}
I_b(\theta\mid\text{preceding history}).
```

On each history, the sum appearing in the last bound of Step 2 is at most the number of calls and at most $B$ times their total duration. Therefore, uniformly throughout the parameter interval,

```math
I_{P}(\theta)\le8\min\{Q,BS\}.
\tag{L1}
```

Independently of a supplied query bound, the minimum-duration constraint implies

```math
I_{P}(\theta)\le8\min\{S/T,BS\}.
\tag{L2}
```

Adaptive stopping causes no difficulty: the deterministic time budget bounds the number of nonempty batches, and the remaining branches can be padded with zero-query, zero-information experiments. Continuous classical randomness and general POVMs can be treated using a parameter-independent dominating measure. The same inequalities follow by applying the score identity to conditional probability kernels. Equivalently, one can use the differentiability-in-quadratic-mean formulation of classical Fisher information. Potential zero-probability outcomes are handled by the usual limiting convention; they do not invalidate the Hellinger path bound below.

##### Step 4. Convert Fisher information to a two-point indistinguishability bound

Choose

```math
\theta_+=\arcsin(2\varepsilon/B),
\qquad
\theta_-=-\arcsin(2\varepsilon/B).
```

Since $\varepsilon\le B/4$, both points lie in $[-\pi/6,\pi/6]$. Their target coefficients are exactly $+2\varepsilon$ and $-2\varepsilon$. An estimate accurate to $\varepsilon$ with probability at least $2/3$ distinguishes the points by the sign of the estimate with probability at least $2/3$ under each point. Thus

```math
\operatorname{TV}(P_{\theta_+},P_{\theta_-})\ge\frac13.
\tag{L3}
```

Let $\Delta\theta=\theta_+-\theta_-$. For $0\le x\le1/2$, $\arcsin x\le2x$, so

```math
\Delta\theta\le\frac{8\varepsilon}{B}.
\tag{L4}
```

Define the unnormalized Hellinger distance by

```math
\mathsf H(P,Q)=\|\sqrt p-\sqrt q\|_{L^2}.
```

The identity $\|\partial_\theta\sqrt{p_\theta}\|_2=\sqrt{I_P(\theta)}/2$ and the path-length inequality give

```math
\mathsf H(P_{\theta_+},P_{\theta_-})
\le\frac12\int_{\theta_-}^{\theta_+}\sqrt{I_P(\theta)}\,d\theta.
```

Moreover, Cauchy–Schwarz gives $\operatorname{TV}(P,Q)\le\mathsf H(P,Q)$. If $I_P(\theta)\le8M$ throughout this path, it follows that

```math
\operatorname{TV}(P_{\theta_+},P_{\theta_-})
\le\Delta\theta\sqrt{2M}.
\tag{L5}
```

Combining (L3)–(L5) yields

```math
M\ge\frac{B^2}{1152\varepsilon^2}.
\tag{L6}
```

Applying (L6) with $M=\min\{Q,BS\}$ from (L1) gives the query lower bound and $S\ge B/(1152\varepsilon^2)$. Applying it with $M=\min\{S/T,BS\}$ from (L2) also gives $S\ge TB^2/(1152\varepsilon^2)$. Finally,

```math
S\ge\frac{\max\{TB^2,B\}}{1152\varepsilon^2}
\ge\frac{TB^2+B}{2304\varepsilon^2}.
```

This proves the theorem. $\square$


### 10. Interpretation and limits

For one known weight-one Pauli coefficient and fixed success probability, Theorems B and C imply
```math
Q=\Theta(B^2/\varepsilon^2),\qquad
\mathcal T=\Theta((TB^2+B)/\varepsilon^2)
```
in the stated two-query-batch model, for $0<\varepsilon\le B/4$. The constants in the lower bound are conservative. This matching concerns the dependence on $B,T,\varepsilon$; it does not establish optimal $3^k$, coefficient-count, or high-confidence factors.

The exact preparation theorem and the bounded-budget learning theorem are different guarantees. The former has exactly two calls per state and a finite expected duration. The latter uses finitely supported sampling and may reject an entire planned group before querying the Hamiltonian; its total time is deterministically capped and its rejection probability is included in the error analysis.

The lower bound allows arbitrary ancillas, joint measurements and known coherent interleaving within a batch, but no quantum memory between batches. All durations and the number of calls in a batch must be chosen before that batch's first unknown call. Classical adaptation between batches is allowed. The theorem does not cover unrestricted coherent query sequences, adaptation of a later duration to an intra-batch measurement, or an expected-time budget without a conversion argument. Existing coherent Heisenberg-limited schemes [2,9,10] therefore do not contradict it.

The construction requires coherent storage of two Choi copies and known register-wide gates. It does not prove practical feasibility, SPAM robustness, a fixed coarse-time-grid theorem, or ancilla-free learning. Timing-error control in Section 8 addresses only errors in the difference of the two evolution times. The baseline theorem does not optimize the preparation scale, gate count or first moment. The main text now gives a universal one-call normalization law and an architectural first-moment frontier; the global two-call optimum is still not claimed.

The full spectral-width identities, estimator moments and lower bound are proved analytically. Symbolic and floating-point checks cover stated finite instances only. They are useful implementation checks, not universal proof certificates.

### Appendix A. An exact classical sampler

For completeness, the infinite law in Theorem A need not rely on an oracle for a zeta-normalized distribution. Put $a_j=|d_j|$. Draw $h\ge0$ with
$\Pr(h)=(3/4)4^{-h}$, then choose $j$ uniformly from
$\{2^h,\ldots,2^{h+1}-1\}$. Accept this classical proposal with rational probability
```math
p_{h,j}=\frac{a_j2^{3h}}{2j^3}\le1;
```
otherwise restart. The probability of proposing and accepting $j$ in a trial is
```math
\frac34\,4^{-h}\,2^{-h}\,
\frac{a_j2^{3h}}{2j^3}
=\frac{3a_j}{8j^3}.
```
Conditioning on acceptance therefore gives exactly $q_j=|c_j|/C$. The total acceptance probability is
$105\zeta(3)/256>0$; the expected number of classical trials is finite. The geometric law for $h$ can be sampled from random bits, and rational Bernoulli trials admit exact fair-bit implementations. This classical rejection precedes all quantum calls and is not quantum measurement postselection. The finite version used in Theorem B is simpler: normalize the finite rational weights $a_j/j^3$.

# References

[1] Ewin Tang. *Some open problems*, Question 4, 22 April 2025. <https://ewintang.com/blog/2025/04/22/open/>. Related workshop slides: <https://jerryzli.github.io/focs2024-slides/open_questions.pdf>.

[2] Myeongjin Shin, Junseo Lee and Changhun Oh. *Heisenberg-limited Hamiltonian learning without short-time control*. arXiv:2604.27838v1 (2026); PRX Quantum 7, 043011 (16 October 2026), doi:10.1103/kjvf-jgqj. <https://arxiv.org/html/2604.27838v1>.

[3] Yuxuan Zhang. *Heisenberg-scaling sparse Hamiltonian learning with a fixed minimum query duration*. Research manuscript, version 1.0, 1 October 2026. The two-Choi identity is Eq. (4); the coarse initializer is used in its main algorithm. <https://yuxuanzhang1995.github.io/assets/pdf/agentic/fixed-duration-hamiltonian-learning.pdf>. This is an unrefereed research manuscript.

[4] Dirk Oliver Theis. *“Proper” Shift Rules for Derivatives of Perturbed-Parametric Quantum Evolutions*. Quantum 7, 1052 (11 July 2023), doi:10.22331/q-2023-07-11-1052; arXiv:2207.01587v3. <https://arxiv.org/pdf/2207.01587>.

[5] Koenraad Audenaert, Nilanjana Datta and Maris Ozols. *Entropy power inequalities for qudits*. Journal of Mathematical Physics 57, 052202 (2016). arXiv:1503.04213v3. <https://arxiv.org/abs/1503.04213>.

[6] Tal Schwartzman, Torsten V. Zache, Hannes Pichler and H. R. Sadeghpour. *Imaginary time evolution and ground state preparation using unitary multi-copy protocols*. arXiv:2603.11208v3, 14 August 2026, especially Appendix A, Eq. (35). <https://arxiv.org/html/2603.11208v3>.

[7] Taiqi Zhou and Weiyuan Gong. *Optimal Ansatz-free Hamiltonian Learning In Situ*. arXiv:2606.19486v1 (2026), especially the derivative-kernel construction, Section 5 and Appendix C.4. <https://arxiv.org/html/2606.19486v1>.

[8] Hsin-Yuan Huang, Richard Kueng and John Preskill. *Predicting many properties of a quantum system from very few measurements*. Nature Physics 16, 1050–1057 (2020). arXiv:2002.08953. <https://arxiv.org/abs/2002.08953>.

[9] Andrew Zhao. *Learning the structure of any Hamiltonian from minimal assumptions*. arXiv:2410.21635v2, 21 April 2025; STOC 2025, doi:10.1145/3717823.3718115. <https://arxiv.org/abs/2410.21635>. See Theorems 1.9–1.10 and Proposition 3.2.

[10] Myeongjin Shin and Yu Tong. *Hamiltonian Learning and Certification via Eigenphase Engineering*. arXiv:2609.26596v1 (2026), especially Section 1.1, Theorem 7 and Section 6.1. <https://arxiv.org/abs/2609.26596>. The primary PDF was retrieved and key model/theorem sections checked.



[11] Hu et al. *Ansatz-Free Hamiltonian Learning with Heisenberg-Limited Scaling*.
PRX Quantum 6, 040315 (2025), DOI:10.1103/j7b8-pb77. Theorem G1 is a prior
bounded-control resource lower bound.

[12] Andris Ambainis, Andras Gilyen and Martins Kokainis. *Tight bounds for
hybrid quantum-classical query algorithms*. arXiv:2610.06803 (2026).
Theorem 1 and Corollary 1 in the primary PDF give prior hybrid classification
and phase-estimation depth laws. They are not claimed as new here.

[13] A. A. Melkman. *n-Widths and Optimal Interpolation of Time- and Band-Limited
Functions II*. SIAM Journal on Mathematical Analysis 16(4), 803--813 (1985),
<https://doi.org/10.1137/0516060>. Official abstract and metadata checked; full text was not
available for an exhaustive comparison of classical extremal constants.

[14] Taiqi Zhou and Weiyuan Gong. *Optimal Ansatz-free Hamiltonian Learning In
Situ*, arXiv:2606.19486v2, 28 July 2026.
<https://arxiv.org/html/2606.19486v2>. The new literature review checked this
updated primary text; the original baseline proof had cited v1 in [7].

