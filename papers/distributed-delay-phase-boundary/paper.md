# Exact phase realization and strong stability for matrix-valued distributed delays

Research manuscript, 26 November 2026. This manuscript has not undergone external peer review. Formal verification is not included.

## Abstract

We study finite-dimensional linear functional equations whose delay coefficients are arbitrary finite matrix-valued measures. We prove the generalized Hale–Silkowski criterion for robustness under Borel changes of the delay variable, both in the full well-posed class and in the subclass with spectrum-determined growth. The missing critical case is resolved by constructing, in every uniform neighborhood of the identity, a delay map whose pushed-forward equation has spectral abscissa and solution growth bound both equal to zero. Two ingredients make this construction possible. First, the largest matrix spectral radius over measurable disk-valued multipliers is attained by a unit-modulus multiplier, including for measures with both atoms and a nonatomic part. Second, the spectral radius in the matrix convolution-measure algebra is bounded by this measurable phase radius. The latter estimate controls all algebra characters and yields a solution-growth bound without assuming that characteristic roots determine growth. It also gives the sharp common bound ω ≤ log r for every Borel pushforward of a kernel with phase radius $0\mathrel{<}r\mathrel{<}1$ on the normalized delay interval. The results establish Conjectures 3.18 and 3.19 in the accessible October 2026 monograph of Mazanti and Conjecture 4.6 of Chitour, Gonçalves Netto and Mazanti. The claims concern their Borel perturbation model; no claim is made for time-varying delay maps or for a common transient prefactor.

## 1. Problem, prior results, and contribution

Consider the real equation

$$
x(t)=\int_{[-1,0]}\mu(d\theta)x(t+\theta),\qquad t\geq0, \tag{1.1}
$$

where $d\geq1$ is finite and $\mu$ is a $d\times d$ matrix of finite real Borel measures. A perturbation replaces $\theta$ by a Borel map $\phi:[-1,0]\to[-1,0]$. Equivalently, it replaces $\mu$ by its pushforward $\phi_*\mu$.

For finitely many point delays, the Hale–Silkowski criterion characterizes strong exponential stability by a strict phase-radius inequality. Chitour, Gonçalves Netto and Mazanti [CGM] extend the perturbation model to distributed matrix measures. Their Conjecture 4.6 asks for the same equivalence within the spectrum-determined-growth class. Their Theorem 4.9 proves the version with a common negative growth rate; their Lemma 4.16 already excludes phase radius greater than one. The unclosed case is equality to one: a sequence of almost unstable perturbations does not by itself furnish one nonstable perturbation.

Mazanti's later monograph [M26, Conjectures 3.18 and 3.19, pp. 67–68] separately states the full well-posed and spectrum-determined-growth versions. Section 7.8, pp. 216–217, retains both as open problems and identifies the missing direct connection between the phase radius and solution growth. We address that connection using a convolution-measure algebra, then realize the critical phase exactly.

The contribution is the complete implication at the critical boundary and the resulting full well-posed-class criterion. The convexity/purification tools, Banach-algebra character theory, spectral-radius formula, and renewal representation used in the proof are classical; we do not claim them as inventions. The supercritical obstruction is imported with explicit attribution from [CGM]. The new argument combines these tools to construct a single admissible critical perturbation and prove its growth bound even when its measure is singular continuous.

The finite-delay stability and robust coefficient-uncertainty results of Song, Michiels, Zhou and Duan [SMZD] are a technically comparable control-theory benchmark. Our result treats a different missing issue: arbitrary finite distributed matrix measures and Borel delay perturbations. It does not improve their LMI algorithms or their structured coefficient-uncertainty analysis. Braun, Auriol and Brivadis [BAB] study exponential stability across state spaces for point-delay plus $L^1$ kernels; their renewal methods are relevant background, while their stated kernel class excludes singular-continuous measures.

### 1.1. Verification and literature scope

The complete official PDFs of [CGM, v2] and [M26, v1] were obtained and the relevant statements and proofs were checked. [M26] is dated 22 October 2026, later than [CGM]'s July arXiv revision. The author-listed later HAL version and the publisher version of [CGM] were identified, but their full texts were not obtained. The source ledger records these access limits. Consequently, the novelty assessment is limited to the sources actually inspected; the manuscript does not certify worldwide priority. Finite exact-arithmetic and floating-point checks accompanying the proof are diagnostics, not substitutes for the infinite-dimensional arguments.

## 2. Definitions and main results

All scalar-measure algebras below are complex, even when a delay equation has real coefficients. Matrix multiplication retains its usual order. Measures are integrated entrywise. Put

$$
\|K\|_{\mathrm{row}}=\max_{1\leq i\leq d}\sum_{j=1}^d\|K_{ij}\|_{\mathrm{TV}},
$$

and use the coordinate maximum norm for vectors. This matrix-measure norm is submultiplicative under convolution. Let $\nu=\sum_{i,j}|\mu_{ij}|$ be a common finite dominating measure. Statements about measurable multipliers may initially be made $\nu$-almost everywhere; a Borel representative, modified on a null set, is always chosen when defining a delay map.

**Definition 2.1 (well-posed and spectral-growth classes).** Write $\mu\in\mathcal W$ when $I-\mu(\{0\})$ is invertible. An admissible history is $h\in C([-1,0],\mathbb R^d)$ satisfying

$$
h(0)=\int_{[-1,0]}\mu(d\theta)h(\theta).
$$

For its continuous solution let $x_t(\theta)=x(t+\theta)$. Define the growth bound

$$
\omega_\mu=\inf\{a\in\mathbb R:\exists C_a\mathrel{<}\infty,\ \|x_t\|_\infty\leq C_a e^{at}\|h\|_\infty\ \text{for every admissible }h\text{ and every }t\geq0\}.
\tag{2.1}
$$

The infimum may be $-\infty$. The characteristic determinant and spectral abscissa are

$$
\Delta_\mu(z)=\det\left(I-\int e^{z\theta}\mu(d\theta)\right),\qquad
S_\mu=\sup\{\operatorname{Re}z:\Delta_\mu(z)=0\}, \tag{2.2}
$$

where the supremum of an empty set is $-\infty$. Set $\mathcal G=\{\mu\in\mathcal W:S_\mu=\omega_\mu\}$. This is the class denoted $\mathcal G$ in [CGM] and SDG in [M26]; $\mathcal W$ is WP in [M26]. Exponential stability means $\omega_\mu\mathrel{<}0$.

**Definition 2.2 (strong stability).** For $\mathcal K=\mathcal W$ or $\mathcal G$ and $\mu\in\mathcal K$, local $\mathcal K$-strong stability means that some $\varepsilon>0$ has the following property: every Borel $\phi:[-1,0]\to[-1,0]$ with $\|\phi-\mathrm{id}\|_\infty\mathrel{<}\varepsilon$ and $\phi_*\mu\in\mathcal K$ gives an exponentially stable equation. Global $\mathcal K$-strong stability tests all Borel $\phi$ with $\phi_*\mu\in\mathcal K$. The uniform-rate versions require one $\alpha>0$ with $\omega_{\phi_*\mu}\leq-\alpha$ over the corresponding family. They do not require one common constant $C$ in (2.1).

**Definition 2.3 (measurable phase radius).** For a finite matrix measure on a compact interval, put

$$
R(\mu)=\sup_{u\text{ Borel},\ |u|=1}\rho\left(\int u\,d\mu\right), \tag{2.3}
$$

where $\rho$ is the ordinary finite-matrix spectral radius. This is $\rho_{\mathrm{HS}}$ in [CGM, M26], since every Borel unit-modulus function has a Borel argument. Theorem 3.4 below shows that the supremum is a maximum and equals the maximum over $|u|\leq1$.

**Theorem 2.4 (exact critical witness).** Let $\mu$ be any finite real matrix measure on $[-1,0]$ with $R(\mu)=1$. For every $\varepsilon>0$, there exist a Borel map $\phi:[-1,0]\to[-1,0]$, a number $\delta>0$, a frequency $b>0$, and $v\in\mathbb C^d\setminus\{0\}$ such that

$$
\|\phi-\mathrm{id}\|_\infty\mathrel{<}\varepsilon,\qquad
\phi([-1,0])\subset[-1+\delta,-\delta],\qquad
\left(\int e^{ib\theta}\,d(\phi_*\mu)(\theta)\right)v=v. \tag{2.4}
$$

Moreover $\phi_*\mu\in\mathcal G$ and

$$
S_{\phi_*\mu}=\omega_{\phi_*\mu}=0. \tag{2.5}
$$

No well-posedness assumption on the original $\mu$ is needed for this witness theorem. The witness is well posed because its support stays away from zero.

**Theorem 2.5 (complete strong-stability criteria).** Let $\mu\in\mathcal W$. The following are equivalent:

1. $R(\mu)\mathrel{<}1$.
2. The equation is globally $\mathcal W$-strongly stable.
3. The equation is locally $\mathcal W$-strongly stable.
4. The equation is globally $\mathcal W$-strongly stable with a uniform rate.
5. The equation is locally $\mathcal W$-strongly stable with a uniform rate.

If $\mu\in\mathcal G$, the same five-way equivalence holds with $\mathcal G$ in place of $\mathcal W$. Thus the conclusions apply with the exact perturbation qualifications of [CGM, Conjecture 4.6] and [M26, Conjectures 3.18 and 3.19].

**Theorem 2.6 (strict-radius growth bound).** If $r=R(\mu)\mathrel{<}1$, every Borel pushforward $\phi_*\mu$ is well posed and exponentially stable, without an additional spectral-growth hypothesis. If $0\mathrel{<}r\mathrel{<}1$, then

$$
\omega_{\phi_*\mu}\leq\log r. \tag{2.6}
$$

If $r=0$, the growth bound is $-\infty$. For an interval $[-H,0]$ with $H>0$, the bound is $(\log r)/H$. The bound is sharp as a common bound depending only on $r$ and $H$.

The proof order is phase attainment, the convolution spectral bound, the renewal estimate, and finally exact realization. The strict and supercritical sides are distinguished from the new equality case throughout.

## 3. Attainment by a pure measurable phase

**Lemma 3.1 (compact disk moment set).** Let $\mu$ be a finite complex matrix measure on a compact interval. The set

$$
\mathcal D_\mu=\left\{\int\eta\,d\mu:\eta\text{ Borel},\ |\eta|\leq1\right\}
$$

is compact. In particular, $\rho$ has a maximum on $\mathcal D_\mu$.

**Proof.** Write $d\mu_{ij}=f_{ij}\,d\nu$ for $\nu=\sum_{i,j}|\mu_{ij}|$. The closed unit ball of $L^\infty(\nu)$ is compact in its weak-star topology. Each coordinate $\eta\mapsto\int\eta f_{ij}\,d\nu$ is weak-star continuous because $f_{ij}\in L^1(\nu)$. The image of the ball in the finite-dimensional matrix space is therefore compact. Borel representatives do not change this image. Continuity of the finite-matrix spectral radius proves the assertion. The zero-measure case gives the singleton $\{0\}$. $\square$

**Lemma 3.2 (nonatomic phase purification).** Let $\nu$ be finite and nonatomic and $F\in L^1(\nu;\mathbb C^m)$. For every measurable $\eta$ with $|\eta|\leq1$, there is a measurable $u$ with $|u|=1$ such that

$$
\int uF\,d\nu=\int\eta F\,d\nu. \tag{3.1}
$$

**Proof.** Put $r=|\eta|$ and $z=\eta/r$ where $r>0$, and $z=1$ where $r=0$. Set

$$
u_+=z\bigl(r+i\sqrt{1-r^2}\bigr),\qquad
u_-=z\bigl(r-i\sqrt{1-r^2}\bigr).
$$

Both have modulus one and $(u_++u_-)/2=\eta$. The finite-dimensional real vector measure

$$
V(E)=\int_E (u_+-u_-)F\,d\nu
$$

is nonatomic. By the compact convex range theorem for nonatomic vector measures, some measurable $E$ satisfies $V(E)=V(X)/2$. Define $u=u_+$ on $E$ and $u=u_-$ off $E$. Then (3.1) follows by subtraction.

For completeness, the half-range fact needed here follows from the usual extreme-point proof of the vector-measure theorem. The weak-star compact nonempty convex set of functions $0\leq q\leq1$ with $\int qG\,d\nu=(\int G\,d\nu)/2$, for $G\in L^1(\nu;\mathbb R^k)$, has an extreme point. If it lies strictly between zero and one on a positive-measure set, some smaller set has a uniform margin from both endpoints. Split that set into $k+1$ disjoint sets of positive measure. A nontrivial linear dependence among their $G$-integrals produces a nonzero bounded perturbation preserving all $k$ moments; a sufficiently small multiple can be both added and subtracted while retaining $0\leq q\leq1$. This contradicts extremality. Thus an extreme point is an indicator and gives the required set. The standard tools behind this argument, and purification more generally, are credited to the vector-measure literature [DWW, Balder]. $\square$

**Lemma 3.3 (finite matrix maximum principle).** If $A(z)$ is a finite-matrix holomorphic function on a neighborhood of the closed unit disk, then

$$
\rho(A(z_0))\leq\max_{|z|=1}\rho(A(z)),\qquad |z_0|\leq1. \tag{3.2}
$$

**Proof.** Let the boundary maximum be $q$ and fix $r>q$. The resolvents $(\lambda I-A(z))^{-1}$ are uniformly bounded on the compact set $|\lambda|=r$, $|z|=1$. The matrix Cauchy formula gives a constant $C_r$ with $\|A(z)^n\|\leq C_r r^{n+1}$ on $|z|=1$, for every integer $n\geq0$. For $|z_0|\mathrel{<}1$, apply the scalar-entry Cauchy formula to the holomorphic matrix $A(z)^n$ to obtain

$$
\|A(z_0)^n\|\leq\frac{C_r r^{n+1}}{1-|z_0|}.
$$

The finite-matrix spectral-radius formula, followed by $r\downarrow q$, proves (3.2). Boundary points require no argument. This is a maximum principle, not a convexity assertion about spectral radius. $\square$

**Theorem 3.4 (pure-phase maximum).** For every finite matrix measure $\mu$ on a compact interval,

$$
\max_{|\eta|\leq1}\rho\left(\int\eta\,d\mu\right)
=\max_{|u|=1}\rho\left(\int u\,d\mu\right)=R(\mu). \tag{3.3}
$$

**Proof.** Choose a disk-valued maximizer $\eta_0$ by Lemma 3.1, and denote its value by $r$. Decompose the dominating measure into its nonatomic part and its at most countably many point atoms $t_j$. Put $A_j=\mu(\{t_j\})$. The series $\sum_j\|A_j\|$ converges. Lemma 3.2, applied to the vector of all matrix-entry densities on the nonatomic part, replaces $\eta_0$ there by a unit phase without changing that part of the matrix integral. Call its fixed integral $C$.

Keep all but the first $n$ atomic coordinates equal to their original values. Apply Lemma 3.3 successively to these first $n$ disk coordinates of

$$
C+\sum_j z_j A_j.
$$

Each coordinate can be moved to the unit circle without decreasing the spectral radius. No value greater than $r$ is possible by global maximality, so after these changes the value remains exactly $r$.

Choose a coordinatewise convergent subsequence of the resulting countable sequences. For every fixed $j$, its limiting coordinate has modulus one, since all sufficiently late terms place that coordinate on the circle. Absolute summability of $A_j$ makes the matrix sums converge in norm: first fix a finite head, then bound the common tail by $2\sum_{j>N}\|A_j\|$. Spectral-radius continuity preserves the value $r$. Combining these limiting atomic phases with the purified nonatomic phase gives the required Borel unit phase. The finite-atom and atom-free cases are the corresponding simpler cases. $\square$

**Corollary 3.5 (multiplier and pushforward bounds).** If $|w|\leq c$ with $c\geq0$, then $R(w\mu)\leq cR(\mu)$. If $\phi$ is Borel, then $R(\phi_*\mu)\leq R(\mu)$.

**Proof.** For $c>0$, the product of a unit phase and $w/c$ is disk-valued, so use (3.3); $c=0$ is immediate. For a pushforward, pull back each phase by $\phi$. $\square$

## 4. A spectral bound in the convolution-measure algebra

Let $\mathcal A=\mathcal M([0,\infty))$ be the complex finite regular Borel measures on the additive half-line, with total-variation norm, convolution, and identity $\delta_0$. This is a commutative unital complex Banach algebra. A finite matrix measure $K$ is an element of $M_d(\mathcal A)$, equipped, for example, with the row-sum norm defined in Section 2.

**Theorem 4.1 (convolution spectral domination).** If $K$ is a finite matrix measure of compact support on $[0,\infty)$, then

$$
r_{M_d(\mathcal A)}(K)\leq R(K). \tag{4.1}
$$

**Proof.** Fix any character $\chi$ of $\mathcal A$. It is a norm-one complex linear functional with $\chi(\delta_0)=1$. Set $\nu=\sum_{i,j}|K_{ij}|$ and $K_{ij}=f_{ij}\nu$. The map

$$
J:L^1(\nu)\longrightarrow\mathcal A,\qquad J(h)=h\nu,
$$

is a linear isometry. Thus $\chi\circ J$ is a bounded functional of norm at most one on $L^1(\nu)$. By $L^1$–$L^\infty$ duality there is a single $\eta\in L^\infty(\nu)$, $|\eta|\leq1$, for which

$$
\chi(h\nu)=\int h\eta\,d\nu\qquad(h\in L^1(\nu)).
$$

In particular, for every matrix entry at once,

$$
\chi(K)=\int\eta\,dK,
\qquad \rho(\chi(K))\leq R(K). \tag{4.2}
$$

The same $\eta$ represents all entries; independent entrywise multipliers are not being introduced.

For every $\lambda\in\mathbb C$, the matrix $\lambda I-K$ is invertible over the commutative algebra $\mathcal A$ if and only if its determinant is invertible in $\mathcal A$. This follows from determinant multiplicativity and the adjugate formula. The character criterion for invertibility in a commutative unital Banach algebra then gives

$$
\sigma_{M_d(\mathcal A)}(K)=\bigcup_{\chi}\sigma_{\mathbb C}(\chi(K)). \tag{4.3}
$$

Equations (4.2)–(4.3) prove (4.1). The zero-measure case is immediate. $\square$

The proof uses all characters of the measure algebra. It does not identify them with Laplace-transform evaluations, and therefore does not require a spectral-naturalness assumption or discard possible Wiener–Pitt phenomena. The Banach-algebra facts in this proof are standard [Rudin]; their use here supplies the required link between the phase criterion and a norm-convergent renewal resolvent.

## 5. From a convolution inverse to solution growth

Reflect the delay variable and write $K=(-\mathrm{id})_*\mu$, so $K$ is supported in $[0,1]$. Reflection is a pushforward; it is not multiplication of the measure by a minus sign. Equation (1.1) becomes

$$
x(t)=\int_{[0,1]}K(ds)x(t-s). \tag{5.1}
$$

**Lemma 5.1 (continuous well-posedness).** If $I-K(\{0\})$ is invertible, every continuous compatible history has a unique continuous global solution of (5.1), bounded on every finite time interval.

**Proof.** Separate the zero atom and set $B=(I-K(\{0\}))^{-1}$. The total variation of $K$ on $(0,a]$ tends to zero as $a\downarrow0$. Choose a step $a>0$ for which the row-norm contraction factor of $B K|_{(0,a]}$ is less than one. On the first interval $[0,a]$, extend candidate continuous functions by the fixed history. The map $y(t)\mapsto B\int_{(0,1]}K(ds)y(t-s)$ preserves the history value at zero by compatibility. It maps continuous glued functions to continuous functions, by dominated convergence, and differences between candidates involve only delays $s\leq t\leq a$. It is therefore a contraction. The same argument on successive intervals of length $a$, using the previously constructed trajectory as history, gives existence and uniqueness on every finite interval. The pieces agree at their endpoints by the equation. Their union is the continuous global solution. $\square$

**Lemma 5.2 (weighted renewal estimate).** Define $K_a(ds)=e^{-as}K(ds)$ for $a\in\mathbb R$. If $K$ is well posed and

$$
r_{M_d(\mathcal A)}(K_a)\mathrel{<}1, \tag{5.2}
$$

then $\omega_K\leq a$.

**Proof.** Let $x_+(t)=x(t)$ for $t\geq0$ and zero for $t\mathrel{<}0$. For $t\geq0$ put

$$
f_h(t)=\int_{(t,1]}K(ds)h(t-s). \tag{5.3}
$$

The strict lower endpoint matters: the term at $s=t$ belongs only to $K*x_+$, with value $K(\{t\})x(0)$. For all $t\geq0$ we have the exact identity

$$
x_+=f_h+K*x_+. \tag{5.4}
$$

Here $f_h$ vanishes for $t\geq1$. It need not be continuous when $K$ has atoms. With $y_a(t)=e^{-at}x_+(t)$ and $g_a(t)=e^{-at}f_h(t)$, (5.4) becomes

$$
y_a=g_a+K_a*y_a,\qquad
\|g_a\|_\infty\leq e^{\max(0,-a)}\|K\|_{\mathrm{row}}\|h\|_\infty. \tag{5.5}
$$

The Banach-algebra spectral-radius formula and (5.2) imply

$$
L_a:=\sum_{n=0}^{\infty}\|K_a^{*n}\|_{\mathrm{row}}\mathrel{<}\infty,
\qquad K_a^{*0}=I\delta_0. \tag{5.6}
$$

Iterating (5.5) $N$ times gives the finite identity

$$
y_a=\sum_{n=0}^{N-1}K_a^{*n}*g_a+K_a^{*N}*y_a. \tag{5.7}
$$

For each fixed $T\mathrel{<}\infty$, the last term on $[0,T]$ is bounded by $\|K_a^{*N}\|_{\mathrm{row}}\|y_a\|_{[0,T]}$ and tends to zero. The solution is locally bounded by Lemma 5.1. Causal convolution and its finite rearrangements are legitimate by the total-variation bound and Fubini on each finite interval. Hence the series represents $y_a$ on every finite interval, and

$$
\sup_{t\geq0}|y_a(t)|\leq L_a\|g_a\|_\infty. \tag{5.8}
$$

This argument does not assume a positive minimum delay, nor does it assume that the unknown weighted solution is globally bounded before proving it. It remains valid with an instantaneous atom. For the history norm, values $x(t+\theta)$ with $t+\theta\geq0$ introduce at most a factor $e^{|a|}$; the remaining values come from $h$ and occur only when $t\mathrel{<}1$. Increasing the constant in (5.8) gives (2.1) with exponent $a$. $\square$

**Proposition 5.3 (critical growth control).** If $K$ is supported in $[\delta,1]$ for some $\delta>0$ and $R(K)\leq1$, then $K$ is well posed and $\omega_K\leq0$.

**Proof.** The zero atom vanishes. For every $a>0$, Corollary 3.5 and Theorem 4.1 give

$$
r_{M_d(\mathcal A)}(K_a)\leq R(K_a)\leq e^{-a\delta}R(K)\mathrel{<}1.
$$

Lemma 5.2 yields $\omega_K\leq a$ for every $a>0$, hence the conclusion. This is a growth-bound conclusion; it does not assert that every such equation is bounded at exponent zero. $\square$

**Proposition 5.4 (critical spectral-growth equality).** Under the hypotheses of Proposition 5.3, if $\Delta_K(ib)=0$ for some $b\in\mathbb R$, then $S_K=\omega_K=0$ and $K\in\mathcal G$.

**Proof.** A nonzero vector in the characteristic kernel gives the complex solution $e^{ibt}v$. Its real and imaginary parts are real continuous solutions with compatible histories. More generally the same argument gives $S_K\leq\omega_K$ for every well-posed equation. Therefore $0\leq S_K\leq\omega_K\leq0$. $\square$

**Proof of Theorem 2.6.** First consider any kernel $K$ on $[0,1]$ with $R(K)=r\mathrel{<}1$. By (3.3), the disk multiplier $1_{\{0\}}$ gives $\rho(K(\{0\}))\leq r\mathrel{<}1$, so $K$ is well posed. For any $\beta>0$ with $e^\beta r\mathrel{<}1$,

$$
r_{M_d(\mathcal A)}(K_{-\beta})\leq R(e^{\beta s}K)\leq e^\beta r\mathrel{<}1.
$$

Lemma 5.2 gives $\omega_K\leq-\beta$. If $r>0$, let $\beta\uparrow-\log r$ to obtain $\omega_K\leq\log r$. This limiting statement concerns the infimum defining the growth bound; it need not provide an estimate at the endpoint exponent itself. If $r=0$, every $\beta>0$ is allowed, so $\omega_K=-\infty$.

For $K=(-\phi)_*\mu$, every multiplier after pushforward pulls back to a disk multiplier before pushforward, giving $R(K)\leq r$. The same inequalities with the original $r$ prove the assertion for all $\phi$, including maps that send mass to zero. On $[0,H]$, replace $e^\beta$ by $e^{\beta H}$. Sharpness follows from the scalar kernel $K=r\delta_H$: the real characteristic root $(\log r)/H$ provides the matching lower bound, and the theorem gives the upper bound. $\square$

## 6. Exact realization at the critical radius

**Lemma 6.1 (Borel phase lifting near the identity).** Given a Borel $u:[-1,0]\to\mathbb C$ with $|u|=1$ and $\varepsilon>0$, there are $b>0$, $\delta>0$, and a Borel $\phi$ satisfying

$$
e^{ib\phi(\theta)}=u(\theta),\qquad
\|\phi-\mathrm{id}\|_\infty\mathrel{<}\varepsilon,\qquad
\phi([-1,0])\subset[-1+\delta,-\delta]. \tag{6.1}
$$

**Proof.** Choose a grid length $\ell$ with $0\mathrel{<}\ell\mathrel{<}\min(1/2,2\varepsilon/3)$ and put $b=2\pi/\ell$. Let $\alpha(\theta)=\operatorname{Arg}u(\theta)\in[0,2\pi)$ be the Borel principal argument, and clip the identity into the interior by

$$
c(\theta)=\max(-1+\ell,\min(\theta,-\ell)).
$$

For $\operatorname{nint}(y)=\lfloor y+1/2\rfloor$, define

$$
k(\theta)=\operatorname{nint}\left(\frac{c(\theta)-\alpha(\theta)/b}{\ell}\right),\qquad
\phi(\theta)=\frac{\alpha(\theta)}b+\ell k(\theta). \tag{6.2}
$$

All these functions are Borel. Nearest-integer rounding gives $|\phi-c|\leq\ell/2$. Since $|c-\theta|\leq\ell$, we have $|\phi-\theta|\leq3\ell/2\mathrel{<}\varepsilon$. The range is contained in $[-1+\ell/2,-\ell/2]$, so take $\delta=\ell/2$. Finally $b\phi=\alpha+2\pi k$, which proves exact phase equality, including at ties and at the endpoints of the original interval. $\square$

**Proof of Theorem 2.4.** By Theorem 3.4, some Borel unit phase $u_0$ gives a matrix $A=\int u_0\,d\mu$ with $\rho(A)=1$. Choose an eigenvalue $\lambda$ with $|\lambda|=1$ and a corresponding nonzero eigenvector $v$. Replace $u_0$ by $u=\overline\lambda u_0$, so

$$
\left(\int u\,d\mu\right)v=v. \tag{6.3}
$$

Apply Lemma 6.1. The pushforward formula and exact phase equality give

$$
\int e^{ib\theta}\,d(\phi_*\mu)(\theta)=\int e^{ib\phi(\theta)}\,d\mu(\theta)=\int u\,d\mu.
$$

Thus $ib$ is a characteristic root of the pushed-forward equation. For the positive-delay kernel $K=(-\phi)_*\mu$, its support is contained in $[\delta,1-\delta]$ and $R(K)\leq R(\mu)=1$. Proposition 5.4 proves $S_K=\omega_K=0$. Reflection identifies these quantities with those for $\phi_*\mu$, establishing every assertion. In particular, membership in $\mathcal G$ is proved after constructing the perturbation, not presumed from its measure type. $\square$

## 7. Completion of the two conjectures

We record the already-established supercritical fact in the exact form used.

**Proposition 7.1 (known supercritical obstruction [CGM, Lemma 4.16]).** If $R(\mu)>1$, then every uniform neighborhood of the identity contains a Borel delay map $\phi$ whose pushforward is a finite point-delay measure in $\mathcal G$ and has a characteristic root in the open right half-plane.

**Justification and attribution.** Lemma 4.16 of [CGM] constructs, for every $\varepsilon,\eta>0$ when $R(\mu)\geq1$, a finite-range $\phi$ within $\varepsilon$ of the identity whose characteristic determinant has a root with real part at least $\log R(\mu)-\eta$. When $R(\mu)>1$, take $\eta\mathrel{<}\log R(\mu)$. The proof approximates a disk multiplier by a finite simple function on small-diameter Borel cells and assigns distinct rationally independent delays to those cells. Finite-dimensional phase maximum and the classical finite-delay Hale–Silkowski theorem supply the unstable finite-delay equation. This is prior work. We use neither this approximation nor a limiting argument to claim the new equality case. [M26, Lemma 3.30 and Corollary 3.31] provide the corresponding later formulation.

**Proof of Theorem 2.5.** Theorem 2.6 shows that $R(\mu)\mathrel{<}1$ implies global $\mathcal W$-strong stability with a uniform negative rate; choose, for example, any $0\mathrel{<}\beta\mathrel{<}-\log R(\mu)$ if the radius is positive, and any $\beta>0$ if it is zero. This property implies each of the weaker global or local properties in the statement.

Conversely, suppose local $\mathcal W$-strong stability holds. A radius greater than one contradicts Proposition 7.1, since the constructed finite-delay witness belongs to $\mathcal G\subset\mathcal W$. Radius equal to one contradicts Theorem 2.4. Thus the radius is strictly less than one. This proves the five-way equivalence in $\mathcal W$.

Now suppose the original measure lies in $\mathcal G$. The strict-radius direction still follows from Theorem 2.6, even after restricting to pushforwards in $\mathcal G$. Both the critical witness in Theorem 2.4 and the supercritical witness in Proposition 7.1 belong to $\mathcal G$. They therefore also disprove local $\mathcal G$-strong stability whenever the radius is at least one. This proves the second five-way equivalence. $\square$

The theorem does not say that all singular-continuous kernels have spectrum-determined growth. It proves enough growth control to certify the specifically constructed critical witness, and gives strict-radius stability directly without invoking that property.

## 8. Examples and finite checks

### 8.1. A stable absolutely continuous kernel on the critical robustness boundary

Let $J=\begin{pmatrix}0&-1\\1&0\end{pmatrix}$ and $U(a)=\exp(aJ)$. On positive delays define

$$
K(ds)=2\,1_{[1/2,1]}(s)U(s^2)\,ds. \tag{8.1}
$$

**Proposition 8.1.** The kernel (8.1) has $R(K)=1$ and is exponentially stable, but is not locally strongly stable in either of the relevant classes.

**Proof.** The Euclidean operator norm of $U(s^2)$ is one and the scalar weight integrates to one, so every disk-multiplied matrix integral has spectral radius at most one. This uses the Euclidean norm only for this spectral-radius bound; the growth and convolution estimates retain the coordinate maximum norm fixed in Section 2. With $v=(1,-i)^T$, $U(s^2)v=e^{is^2}v$. The multiplier $e^{-is^2}$ therefore realizes eigenvalue one, proving $R(K)=1$.

Over $\mathbb C$, all rotations have the common eigenbasis with scalar factors $e^{\pm is^2}$. The characteristic determinant factors as

$$
\Delta_K(z)=\prod_{\sigma\in\{-1,1\}}\left(1-2\int_{1/2}^1 e^{-zs+i\sigma s^2}\,ds\right). \tag{8.2}
$$

If $\operatorname{Re}z>0$, each integral factor has modulus strictly less than one. If $z=ib$, equality in the integral triangle inequality would require $\sigma s^2-bs$ to be constant modulo $2\pi$ almost everywhere on an interval. Continuity would make it constant modulo $2\pi$ everywhere and then constant as a real phase up to one integer, contradicting its nonzero quadratic coefficient. Thus no root lies on the closed right half-plane.

To obtain a genuine spectral gap, rather than just pointwise absence of roots, note that the integral in (8.2) tends uniformly to zero as $|b|\to\infty$ for $\operatorname{Re}z\in[-1,0]$. Indeed the amplitudes $2e^{-as+i\sigma s^2}1_{[1/2,1]}$ form a compact set in $L^1$ as $(a,\sigma)$ ranges over the compact parameter set, and the Riemann–Lebesgue lemma plus a finite $L^1$ net gives uniform decay. The remaining bounded frequency interval is compact; the determinant is bounded away from zero at $a=0$ and remains so for all sufficiently small negative $a$. Hence $S_K\mathrel{<}0$. An absolutely continuous kernel belongs to $\mathcal G$ by [CGM, Remark 2.8(6)] (equivalently [M26]'s non-singular subclass), so $\omega_K=S_K\mathrel{<}0$. Theorem 2.4 supplies a nonstable admissible perturbation in every uniform neighborhood. $\square$

This example is included to make the distinction concrete: exponential stability of one absolutely continuous distributed-delay equation does not imply delay robustness at the phase-radius boundary. The density is smooth on the interior of its support and has jumps at the support endpoints. Its role is illustrative, not a separate claim of priority over known fragility examples.

### 8.2. Instantaneous mass and the sharp rate

For the scalar kernel $K=q\delta_0+p\delta_1$ with $0\leq q\mathrel{<}1$, $p>0$, and $r=p+q\mathrel{<}1$, the equation reduces to $x(t)=\frac p{1-q}x(t-1)$. Its growth bound is $\log\frac p{1-q}\leq\log r$; the inequality follows from $p\leq(p+q)(1-q)$, whose difference is $q(1-r)\geq0$. At $q=0$ the bound is attained. This check illustrates why the instantaneous atom belongs inside the renewal equation and why the strict-radius proof must not assume a minimum positive delay.

### 8.3. Reproducible finite verification

The accompanying script uses exact rational arithmetic for finite weighted rotation kernels, including the identity of the phase-weighted matrix on its complex eigenvector. It also checks the explicit rounding construction at endpoints, phase discontinuities, and several perturbation scales. Trigonometric evaluations and norm gaps in those latter checks use floating point and are labeled accordingly. The theorem for arbitrary finite measures is proved in Sections 3–7; it is not inferred from the number of checks.

## 9. Scope and remaining questions

The coefficient dimension is finite. The proof uses a common finite dominating measure and a finite-dimensional moment space for purification. We do not extend the conclusion to operator-valued measures on an infinite-dimensional state space.

The perturbation $\phi$ is Borel and fixed in time, exactly as in [CGM, M26]. The exact lift may be discontinuous and noninjective. Stability restricted to continuous, monotone, differentiable, or bounded-slew delay maps is a different problem and is not characterized here. Time-varying delays and nonlinear equations are also outside the result.

The common rate in Theorem 2.6 is a bound on the infimum in (2.1). Constants for exponents strictly above that infimum may depend on the kernel, the perturbation, and the chosen exponent. A common transient prefactor is not asserted. The existence proof for a maximizing phase uses compactness and nonatomic purification; it is not an efficient algorithm for computing $R(\mu)$ from a general measure representation.

All core statements have written proofs. The results have not undergone external peer review or proof-assistant verification.

## References

**[CGM]** Y. Chitour, F. Gonçalves Netto and G. Mazanti. *Strong Stability of Linear Functional Equations with Distributed Delays*. arXiv:2510.25581v2, 12 July 2026. [Official preprint](https://arxiv.org/abs/2510.25581), [fixed PDF](https://arxiv.org/pdf/2510.25581v2). Author-listed journal version: *Journal of Mathematical Analysis and Applications* 567(1), 131128, nominal issue year 2027, [doi:10.1016/j.jmaa.2026.131128](https://doi.org/10.1016/j.jmaa.2026.131128). The inspected theorem numbering is that of arXiv v2; the publisher and later HAL texts were not obtained.

**[M26]** G. Mazanti. *Control, stability, and stabilization of some classes of linear time-delay systems*. Habilitation monograph, arXiv:2610.31398v1, 22 October 2026. [Fixed PDF](https://arxiv.org/pdf/2610.31398v1). Conjectures 3.18–3.19 and Section 7.8 were checked in the complete downloaded PDF.

**[SMZD]** Y. Song, W. Michiels, B. Zhou and G.-R. Duan. Strong Stability Analysis of Linear Delay-Difference Equations With Multiple Time Delays. *IEEE Transactions on Automatic Control* 66(8), 3741–3748, 2021. [doi:10.1109/TAC.2020.3027660](https://doi.org/10.1109/TAC.2020.3027660). [Institutional author manuscript](https://lirias.kuleuven.be/retrieve/6264014e-5f88-4dc6-a07c-ff7776ab0484).

**[BAB]** A. Braun, J. Auriol and L. Brivadis. *A Spectral Exponential Stability Criterion for Integral Difference Equations and Delay Differential Equations in various state spaces*. arXiv:2512.13195v2, 5 January 2026. [Official preprint](https://arxiv.org/abs/2512.13195), [fixed PDF](https://arxiv.org/pdf/2512.13195v2). See Assumption 1 for the point-delay plus $L^1$-density kernel class.

**[DWW]** A. Dvoretzky, A. Wald and J. Wolfowitz. Elimination of randomization in certain statistical decision procedures and zero-sum two-person games. *The Annals of Mathematical Statistics* 22(1), 1–21, 1951. Classical source for finite-dimensional nonatomic purification.

**[Balder]** E. J. Balder. *Comments on purification in continuum games*, *International Journal of Game Theory* 37, 73–92, 2008. [doi:10.1007/s00182-007-0094-1](https://doi.org/10.1007/s00182-007-0094-1). [Author-hosted text](https://webspace.science.uu.nl/~balde101/balder_ijgt08.pdf), Appendix A. The present proof needs only the finite-dimensional vector-measure half-range property and spells out its standard extreme-point argument.

**[Rudin]** W. Rudin. *Functional Analysis*, second edition, McGraw–Hill, 1991. Standard Banach-algebra spectral-radius and character-invertibility theory, and weak-star compactness. These background theorems are not claimed as new results.
