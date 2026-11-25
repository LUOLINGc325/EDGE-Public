# The Privacy-Failure Exponent in Optimal Differentially Private E-Power

**Research draft — 25 November 2026.** This manuscript has not undergone external peer review. The full theorem and its asymptotic proof are not yet formally verified.

## Abstract

We determine the asymptotically optimal expected logarithm of an e-value under approximate differential privacy for testing two fixed, fully supported distributions on a fixed finite alphabet. Privacy is central, uses replacement adjacency, and is required on every database. For fixed $\varepsilon>0$ and privacy-failure probabilities satisfying $-n^{-1}\log\delta_n\to\rho\in[0,\infty]$, the optimal e-power per observation converges to
$
\inf_{R:\,\varepsilon\operatorname{TV}(R,Q)\le\rho}
\{D(R\Vert P)+\varepsilon\operatorname{TV}(R,Q)\}.
$
The converse applies to arbitrary measurable output mechanisms. It combines group privacy and a product coupling with a bounded-likelihood-ratio inequality that controls the information carried by the approximate-privacy exceptional mass. A matching construction releases a histogram with independent, truncated noise on the zero-sum integer lattice. We give its exact boundary leakage, an explicit radius calibration, and finite-sample upper and lower bounds. The resulting rate is continuous and convex in $\rho$, decreases strictly until an explicitly characterized saturation threshold, and then equals the known pure-privacy rate. A family of clipped distributions reduces computation to scalar bisection. The result concerns fixed hypotheses and fixed sample size; it does not assert uniform convergence over distribution pairs, growing alphabets, composite testing, or validity under optional stopping.

## 1. Problem and contribution

An e-value for a null distribution is a nonnegative statistic whose null expectation is at most one. Its expected logarithm under an alternative measures the growth of multiplicative evidence. Differential privacy restricts the possible output distributions, and therefore the amount of evidence that can be extracted from a sample. In approximate privacy, the additive probability budget $\delta_n$ permits exceptional output behavior. Its influence on an expected logarithm is sensitive to how quickly the budget decreases with the sample size.

The question addressed here is precise: for fixed simple hypotheses on a finite alphabet, how does the **optimal** evidence-growth rate change as $\delta_n$ moves from a subexponential to an exponential or superexponential scale? We optimize over all central private mechanisms, including mechanisms with arbitrary measurable output spaces. Our construction and bounds are instance specific: $P,Q,m$, and $\varepsilon$ are held fixed as $n$ increases.

The main result identifies the exponential budget with a radius constraint in a relative-entropy/total-variation variational problem. Its positive-exponent regime requires both an all-mechanism converse and a matching construction. The converse must account for exceptional output mass without assuming that approximate domination by itself bounds relative entropy. The construction must satisfy privacy on all neighboring datasets, including outputs near its truncated support boundary. These two issues are resolved explicitly below.

### Related work and the boundary of the claim

Jacobsen, Gonzalez, Brown, Fawaz, and Ramdas [1] establish the pure-$\varepsilon$-DP optimal e-power rate and identify approximate privacy as a further question. Their work supplies the relevant pure-privacy variational formula, likelihood clipping, the output-KL interpretation, and a group-privacy/coupling strategy. We use these as existing ingredients. The additional claim is the exact finite-alphabet exponential-$\delta_n$ transition, including a converse over all mechanisms and a construction achieving every exponent regime.

Csillag and Mesquita [2] study private e-values through multiplicative perturbations and the resulting growth loss. For bounded log-likelihood sensitivity, their constructions already provide antecedents of the lossless subexponential-$\delta_n$ endpoint. We include that endpoint to complete the phase diagram, rather than claiming it as an independent new contribution.

Awan and Slavkovic [3] give finite-sample uniformly most powerful private tests for binomial data using Tulap noise. Their binary optimality theory is a substantial precedent. Our binary formulas serve as checks and illustrations; neither a new binary noise mechanism nor priority over those testing results is claimed.

The frequency-table analysis of Dolera and Favaro [4], and its later journal publication with Beraha, studies the power and large deviations of specified private likelihood-ratio procedures. Truncated discrete noise and the method of types are established tools. The distinction here is optimization over every central mechanism together with a privacy-failure budget that changes exponentially with sample size. The preprint was examined in full; the journal version was checked at the metadata and abstract level. The comparison is limited to the sources and versions discussed here.

Li, Han, Jiang, and Gao [5] analyze privacy costs in language identification and generation, including a separation governed by the scale of $\log(1/\delta_n)$. Exponential-scale privacy transitions are therefore an existing concept. Their results concern language-learning performance. Our claimed increment is the exact constrained KL–TV formula and matching all-mechanism bounds for the fixed, fully supported finite-alphabet e-power problem specified below.

## 2. Model and main theorem

Let $\mathcal X=[m]$, where $m\ge2$ is fixed. Let $P=(p_i)$ and $Q=(q_i)$ satisfy $p_i,q_i>0$ for every $i$. All logarithms are natural. For distributions $R,S$, write
$
D(R\Vert P)=\sum_i r_i\log(r_i/p_i),\qquad
t(R)=\operatorname{TV}(R,Q)=\frac12\sum_i|r_i-q_i|,
$
with $0\log0=0$. An intermediate distribution $R$ may have zero coordinates.

A Markov kernel $K$ from $\mathcal X^n$ to an arbitrary measurable space is $(\varepsilon,\delta_n)$-differentially private if
$
K(x,S)\le e^\varepsilon K(x',S)+\delta_n
\tag{2.1}
$
for every measurable output event $S$ and every ordered pair of databases differing in one coordinate. Thus privacy is a property of the full input domain, not of a typical subset.

A private e-value is such a randomized mechanism with nonnegative real output $E_n$ and $\mathbb E_{P^n}E_n\le1$. Define
$
V_n=\sup_{E_n}\mathbb E_{Q^n}\log E_n.
\tag{2.2}
$
An individual expected logarithm may be $-\infty$; the supremum is finite and nonnegative. Assume throughout that $\varepsilon>0$ is fixed, $0<\delta_n<1/2$, and
$
\rho_n=-\frac1n\log\delta_n\longrightarrow\rho\in[0,\infty].
\tag{2.3}
$

### Theorem 2.1. Optimal exponent-dependent e-power

Under these assumptions,
$
\boxed{
\lim_{n\to\infty}\frac{V_n}{n}
=J_\varepsilon(\rho;P,Q)
:=\min_{\substack{R\in\Delta_m\\\varepsilon t(R)\le\rho}}
\{D(R\Vert P)+\varepsilon t(R)\}.}
\tag{2.4}
$
At $\rho=\infty$, the constraint is absent. A single calibrated histogram-noise construction, followed by its output likelihood ratio, attains the right side for each fixed pair $P,Q$. The histogram release itself depends only on $m,n,\varepsilon,\delta_n$; the likelihood-ratio postprocessing depends on $P,Q$. This is pointwise attainment for every fixed pair, without uniform convergence over changing pairs or a finite-sample Blackwell-optimality claim.

Consequently,
$
J_\varepsilon(0;P,Q)=D(Q\Vert P),\qquad
J_\varepsilon(\infty;P,Q)=\min_R\{D(R\Vert P)+\varepsilon t(R)\}.
\tag{2.5}
$
The second expression is the known pure-DP rate. No monotonicity of $\delta_n$, convergence of its subexponential prefactor, or favorable behavior at the boundary of the constraint is assumed. If $P=Q$, then $V_n=0$ for every $n$.

Sections 3–5 prove the theorem. Section 6 identifies its complete phase and a scalar computational representation. Section 7 records a constructive finite-sample lower bound to complement the converse bound.

## 3. An upper bound for every mechanism

### 3.1. E-power and output relative entropy

For a fixed private kernel, set $A=Q^nK$, $B=P^nK$, and
$
\ell_- =\min_i\log(q_i/p_i),\qquad
L_+=\max_i\log(q_i/p_i)\ge0.
$
The input likelihood ratio bounds imply, for every output event,
$
e^{n\ell_-}B(S)\le A(S)\le e^{nL_+}B(S).
\tag{3.1}
$
Thus $A$ and $B$ are equivalent and their likelihood ratio $f=dA/dB$ has the same positive finite bounds almost surely.

For any measurable $e\ge0$ with $\int e\,dB\le1$, Jensen's inequality gives
$
\int\log(e/f)\,dA
\le\log\int(e/f)\,dA
=\log\int e\,dB\le0.
\tag{3.2}
$
This extended expectation is legitimate: $\log^+e\le e$ and (3.1) make its positive part integrable, while $\log f$ is bounded. Equality is attained at $e=f$. Postprocessing by $f$ preserves privacy. A $B$-null event is null for every conditional output law $K(x,\cdot)$, because each input atom has positive $P^n$-probability; assigning $f$ arbitrary values there causes no domain issue. Conversely, each private e-value is itself a private kernel. Therefore
$
V_n=\sup_{K\text{ satisfies (2.1)}}D(Q^nK\Vert P^nK).
\tag{3.3}
$
Data processing yields
$
0\le V_n\le nD(Q\Vert P).
\tag{3.4}
$
For arbitrary measurable output spaces, data processing follows directly by applying the finite-input log-sum inequality to the Radon–Nikodym densities of the finitely many conditional output measures. No regular conditional distribution on the output space is required.

### 3.2. Converting exceptional mass into a KL bound

**Lemma 3.1.** Let $A\ll B$ be probability measures with $f=dA/dB\le e^L$, $L\ge0$. Suppose $a\ge0$, $\tau\ge0$, and
$
A(S)\le e^aB(S)+\tau\quad\text{for every measurable }S.
\tag{3.5}
$
Then
$
D(A\Vert B)\le
\min\{L,\ a+[1+(L-a)_+]\tau\}.
\tag{3.6}
$

**Proof.** Taking $S=\{f>e^a\}$ gives $\int(f-e^a)_+\,dB\le\tau$. Put $c=e^a$. For $f\le c$, $f\log(f/c)\le0$. For $c<f\le e^L$,
$
f\log(f/c)
=(f-c)\log(f/c)+c\log(f/c)
\le(f-c)[1+(L-a)_+],
$
using $\log u\le u-1$. Integrating gives the second bound; $\log f\le L$ gives the first. The negative entropy integrand is integrable since $u\log u\ge-1/e$. ∎

Approximate domination alone would not control KL: its exceptional mass could carry an arbitrarily large likelihood ratio. Here (3.1) supplies a mechanism-independent cap growing only linearly after taking logarithms. A vanishing exceptional mass is therefore sufficient, even without an exponential decay rate.

### 3.3. Coupling, group privacy, and a finite-sample certificate

Define
$
G_\varepsilon(k)=\sum_{j=0}^{k-1}e^{j\varepsilon}
=\frac{e^{\varepsilon k}-1}{e^\varepsilon-1},\qquad G_\varepsilon(0)=0.
$
Iteration of (2.1) along a Hamming path gives
$
K(x,S)\le e^{\varepsilon d_H(x,y)}K(y,S)
+\delta_nG_\varepsilon(d_H(x,y)).
\tag{3.7}
$

Fix any $R\in\Delta_m$, write $t=t(R)$, and take an independent product of maximal one-coordinate couplings with marginals $Q,R$. The resulting pair $(X,Y)$ satisfies
$
X\sim Q^n,\quad Y\sim R^n,\quad H=d_H(X,Y)\sim\operatorname{Bin}(n,t).
\tag{3.8}
$
For $\eta>0$, let
$
T=\left\{y:r^n(y)>0,\quad
\log\frac{r^n(y)}{p^n(y)}\le n[D(R\Vert P)+\eta]\right\},
\qquad \beta_{n,R}(\eta)=R^n(T^{\mathsf c}).
\tag{3.9}
$
Only positive coordinates of $R$ enter the logarithm, so it is finite under $R^n$, including when $R$ lies on the simplex boundary.

For $0\le k\le n$, restrict (3.7) to the event $C=\{H\le k,Y\in T\}$. Integrating, then dropping the distance indicator on the nonnegative term involving $K(Y,S)$, gives
$
\begin{aligned}
Q^nK(S)
&\le e^{\varepsilon k}\mathbb E_{R^n}[1_TK(Y,S)]
+\delta_nG_\varepsilon(k)+\Pr(H>k)+\beta_{n,R}(\eta)\\
&\le e^{n[D(R\Vert P)+\eta]+\varepsilon k}P^nK(S)
+\delta_nG_\varepsilon(k)+\Pr(H>k)+\beta_{n,R}(\eta).
\end{aligned}
\tag{3.10}
$
The two good events need not be independent. The first line uses only the correct $Y$-marginal and a union bound.

Put
$
b=D(R\Vert P)+\eta+\varepsilon k/n,
\quad
\tau=\min\{1,\Pr(\operatorname{Bin}(n,t)>k)
+\beta_{n,R}(\eta)+\delta_nG_\varepsilon(k)\}.
$
Capping the error at one preserves (3.10). Lemma 3.1 with $a=nb$, $L=nL_+$, together with (3.3)–(3.4), proves the finite-sample upper certificate
$
\boxed{
\frac{V_n}{n}\le
\min\left\{D(Q\Vert P),\quad
b+\left[\frac1n+(L_+-b)_+\right]\tau\right\}.}
\tag{3.11}
$
Every quantity on its right is independent of the mechanism. In particular, the bound already applies to the supremum at each sample size.

The sampling tails are explicit. If
$
w_R=\max_{i:r_i>0}\log(r_i/p_i)
-\min_{i:r_i>0}\log(r_i/p_i)>0,
$
the bounded-variable exponential inequality gives
$
\beta_{n,R}(\eta)\le e^{-2n\eta^2/w_R^2}.
\tag{3.12}
$
For $w_R=0$, the tail is zero. For $k/n>t$, the binomial tail is at most $e^{-2n(k/n-t)^2}$, and its exact value is zero for $k=n$. These estimates are optional; the weak law suffices below. No uniformity in varying $R$ is asserted.

### 3.4. Passage to the constrained variational bound

First suppose $0<\rho<\infty$, and fix $R$ with $\varepsilon t(R)<\rho$. Full support of $Q$ implies $t(R)<1$. Choose
$
t(R)<s<\min\{1,\rho/\varepsilon\},\qquad k_n=\lceil ns\rceil.
$
For all sufficiently large $n$, $k_n\le n$. Both sampling tails vanish for fixed $\eta>0$, and
$
\delta_nG_\varepsilon(k_n)
\le\frac{e^\varepsilon}{e^\varepsilon-1}
\exp[-n(\rho_n-\varepsilon s)]\longrightarrow0.
\tag{3.13}
$
Equation (3.11) gives $\limsup V_n/n\le D(R\Vert P)+\eta+\varepsilon s$. Letting $\eta\downarrow0$ and then $s\downarrow t(R)$ proves the bound for every point of the strict ball.

To obtain the closed ball, take any $R$ with $\varepsilon t(R)\le\rho$ and replace it by
$R_\lambda=(1-\lambda)R+\lambda Q$. Then $t(R_\lambda)=(1-\lambda)t(R)$, and the objective converges to its value at $R$. Continuity holds on the entire simplex because $P$ is positive. Thus the strict and closed infima agree. This step is necessary: at the boundary, $\delta_ne^{\varepsilon nt(R)}$ need not vanish.

For $\rho=0$, (3.4) supplies the desired bound immediately. For $\rho=\infty$, fix any $R$ and choose $s\in(t(R),1)$; (3.13) again tends to zero and yields the unrestricted infimum. This proves the upper half of Theorem 2.1 without exchanging a nonuniform limit with the mechanism supremum.

## 4. A calibrated private histogram mechanism

Let
$
\Lambda=\{z\in\mathbb Z^m:\sum_i z_i=0\},\quad
\kappa(z)=\tfrac12\|z\|_1,\quad B_r=\{z\in\Lambda:\kappa(z)\le r\}.
$
The norm $\kappa$ is integer valued on $\Lambda$. For integer $r\ge0$, draw independent noise
$
g_r(z)=C_r^{-1}e^{-\varepsilon\kappa(z)}1_{B_r}(z),\qquad
C_r=\sum_{z\in B_r}e^{-\varepsilon\kappa(z)},
\tag{4.1}
$
and release $W=h(X)+Z_r$. Outputs may have negative coordinates but always sum to $n$. This translation-invariant output domain keeps the normalizer independent of the database.

### 4.1. Shell and boundary counts

Write $s_m(k)=|\{z\in\Lambda:\kappa(z)=k\}|$. For $k\ge1$, decomposition into positive and negative supports gives
$
s_m(k)=\sum_{\substack{a,b\ge1\\a+b\le m}}
\frac{m!}{a!b!(m-a-b)!}
{k-1\choose a-1}{k-1\choose b-1},\qquad s_m(0)=1.
\tag{4.2}
$
Impossible binomial coefficients are zero. In particular, with $d=m-2$,
$
s_m(k)\le3^m k^d,\quad
C_\infty=\sum_{k\ge0}s_m(k)e^{-\varepsilon k}<\infty,\quad
M_1=\sum_{k\ge0}k s_m(k)e^{-\varepsilon k}<\infty.
\tag{4.3}
$
For the bound, there are at most $3^m$ coordinate sign assignments, and the two composition factors contribute at most $k^{a+b-2}\le k^d$.

For a neighboring shift $v=e_i-e_j$, the triangle inequality gives $|\kappa(z)-\kappa(z-v)|\le1$. On the overlap of the two supports, $g_r(z)\le e^\varepsilon g_r(z-v)$. Hence the exact directed privacy divergence is
$
\sum_z[g_r(z)-e^\varepsilon g_r(z-v)]_+
=\frac{b_m(r)e^{-\varepsilon r}}{C_r},
\tag{4.4}
$
where the cap count is
$
b_m(r)=\sum_{\substack{a,b\ge0\\a+b\le m-2}}
\frac{(m-2)!}{a!b!(m-2-a-b)!}{r\choose a}{r\choose b}.
\tag{4.5}
$
Indeed, for $v=e_1-e_2$, exit from the support occurs exactly at $\kappa(z)=r,z_1\le0,z_2\ge0$. Choose the positive and negative supports among the remaining coordinates. Positive mass $r$ splits into $a$ positive parts and one nonnegative part, counted by ${r\choose a}$; the negative side contributes ${r\choose b}$. These cases are disjoint and exhaustive. Coordinate permutations cover every ordered neighbor direction. For countable laws, the positive-part sum in (4.4) is precisely the supremum of the eventwise privacy difference. Thus (4.4) proves privacy on the entire input domain.

For example, $b_2(r)=1$, $b_3(r)=2r+1$, and the corresponding positive-radius shell counts are $2$ and $6r$. Formula (4.5) also gives $b_m(0)=1$.

### 4.2. Radius calibration and its scale

Let $a_n=\log(1/\delta_n)$. A simple sufficient radius is the least integer $\bar r_n\ge r_0$, for a fixed $r_0>\max\{1,d/\varepsilon\}$, satisfying
$
\varepsilon\bar r_n-d\log\bar r_n\ge a_n+m\log3.
\tag{4.6}
$
Equations (4.2)–(4.4) imply privacy at this radius. Since the left side is eventually at least $\varepsilon r/2$, initially $\bar r_n=O(a_n+1)$. Minimality in (4.6) then gives
$
\bar r_n=\frac{a_n+O_{m,\varepsilon}(\log(a_n+2))}{\varepsilon}.
\tag{4.7}
$

For implementation, use the smaller exact radius
$
r_n=\min\{r\ge0:b_m(r)e^{-\varepsilon r}\le\delta_n C_r\}.
\tag{4.8}
$
This comparison is rational whenever $e^{-\varepsilon}$ and $\delta_n$ are rational, and requires only the counting formulas. Existence follows from exponential decay. Because $b_m(r)\ge1$, $C_r\le C_\infty$, and $r_n\le\bar r_n$,
$
\frac{a_n-\log C_\infty}{\varepsilon}\le r_n\le\bar r_n.
\tag{4.9}
$
Consequently,
$
r_n/n\to\rho/\varepsilon\quad(\rho<\infty),\qquad
r_n/n\to\infty\quad(\rho=\infty).
\tag{4.10}
$
This proof covers bounded, oscillating, and unbounded sequences $a_n$.

A sharper expansion is available when $a_n\to\infty$. The polynomial in (4.5) has degree $d$ and leading coefficient ${2d\choose d}/d!>0$. Thus the logarithm of its leakage equals $-\varepsilon r+d\log r+O(1)$. The minimal crossing in (4.8) satisfies the privacy inequality at $r_n$ and fails it at $r_n-1$. Since $r_n\to\infty$, these two inequalities imply $\varepsilon r_n-d\log r_n=a_n+O(1)$. Combining this with (4.7)–(4.9) gives
$
r_n=\frac{a_n+d\log a_n}{\varepsilon}+O_{m,\varepsilon}(1).
\tag{4.11}
$
The second term vanishes when $m=2$.

The polynomial correction cannot be dropped when claiming finite-sample privacy. For $m=3$, $\varepsilon=\log2$, $\delta=1/1024$, and the naive radius $r=10$, (4.4) equals $21/13240>1/1024$. The smallest valid radius is eleven. This counterexample is an exact regression check in the accompanying code.

## 5. Matching output-likelihood asymptotics

Let $\mu_{A,n}^{(r)}$ be the output law of (4.1) under a positive distribution $A$. Let $\mathcal T_n$ be the empirical-distribution types and
$
N_n=|\mathcal T_n|={n+m-1\choose m-1}.
$
For an output in the support, define
$
J_{A,n}^{(r)}(w)=
\min_{\substack{R\in\mathcal T_n\\\operatorname{TV}(R,w/n)\le r/n}}
\{D(R\Vert A)+\varepsilon\operatorname{TV}(R,w/n)\}.
\tag{5.1}
$
Here total variation denotes half the $\ell_1$ norm even when $w/n$ has negative coordinates.

### 5.1. A type sandwich valid at every output

For a histogram $h=nR$,
$
N_n^{-1}e^{-nD(R\Vert A)}
\le\Pr_A\{h(X)=h\}\le e^{-nD(R\Vert A)}.
\tag{5.2}
$
To verify the lower bound directly, factor the probability as $\Pr_R(h)e^{-nD(R\Vert A)}$. The histogram $h$ is a mode under parameter $R=h/n$: for a competing histogram $g$ on its support,
$
\frac{\Pr_R(g)}{\Pr_R(h)}
=\prod_i h_i^{g_i-h_i}\frac{h_i!}{g_i!}\le1.
$
Each factor is at most one by expanding the factorial ratio, whether $g_i$ exceeds $h_i$ or is smaller. A competing histogram using a zero coordinate of $h$ has probability zero. Since there are $N_n$ types, $\Pr_R(h)\ge1/N_n$.

Convolving (5.2) with (4.1), using a minimizing type for one direction and at most $N_n$ terms for the other, gives
$
nJ_{A,n}^{(r)}(w)+\log C_r-\log N_n
\le-\log\mu_{A,n}^{(r)}(w)
\le nJ_{A,n}^{(r)}(w)+\log C_r+\log N_n.
\tag{5.3}
$

### 5.2. The closed-ball limit

For $u\in[0,\infty]$, put
$
I_A(Q,u)=\min_{\operatorname{TV}(R,Q)\le u}
\{D(R\Vert A)+\varepsilon\operatorname{TV}(R,Q)\},
\tag{5.4}
$
with unrestricted minimization at infinity. Suppose $r_n/n\to u$ and integer vectors $w_n$ satisfy $\sum_iw_{n,i}=n$ and $w_n/n\to Q$. Then
$
-n^{-1}\log\mu_{A,n}^{(r_n)}(w_n)\longrightarrow I_A(Q,u).
\tag{5.5}
$

Here is the full boundary argument. Positivity of $Q$ makes $w_n$ a nonnegative histogram eventually, so the finite feasible set is nonempty. Any convergent subsequence of finite minimizers has a feasible limit when $u<\infty$; compactness and continuity give the lower-limit inequality. For $u=0$, every feasible type tends to $Q$, and choosing $R=w_n/n$ gives the upper limit. For $0<u<\infty$, take a continuous minimizer and mix it slightly toward $Q$. This gives strict radius slack. Rounding to types with $\ell_1$ error at most $2(m-1)/n$ preserves feasibility for large $n$. Letting the mixing amount decrease to zero proves the upper limit, including an originally active boundary. When $u=\infty$, every fixed rounded simplex point is eventually feasible. Finally, $1\le C_r\le C_\infty$ and $\log N_n=O_m(\log n)$ allow (5.3) to transfer these limits to the output probabilities.

### 5.3. From output probabilities to achievable e-power

Uniformly in the radius,
$
\mathbb E\kappa(Z_r)
=C_r^{-1}\sum_{k\le r}k s_m(k)e^{-\varepsilon k}\le M_1.
\tag{5.6}
$
Under $Q^n$, the law of large numbers and Markov's inequality therefore imply $W_n/n\to Q$ in probability. Applying (5.5) with $A=P$ and $A=Q$ gives
$
\frac1n\log\frac{\mu_{Q,n}^{(r_n)}(W_n)}{\mu_{P,n}^{(r_n)}(W_n)}
\longrightarrow I_P(Q,\rho/\varepsilon)
\quad\text{in probability},
\tag{5.7}
$
since $I_Q(Q,u)=0$. The deterministic sequential limit (5.5) implies this probabilistic version: a failure would yield a subsequence of violating outputs whose normalized distance to $Q$ tends to zero, contradicting (5.5).

By (3.1), the normalized logarithm in (5.7) always lies between $\ell_-$ and $L_+$. Hence convergence in probability also gives convergence of its expectation. The scalar likelihood-ratio output
$
E_n(W_n)=\frac{\mu_{Q,n}^{(r_n)}(W_n)}{\mu_{P,n}^{(r_n)}(W_n)}
\tag{5.8}
$
is positive and finite on the common support, satisfies $\mathbb E_{P^n}E_n=1$, and preserves privacy by postprocessing. Its expected logarithm is the output KL. Equations (4.10) and (5.7) prove the matching lower bound and complete Theorem 2.1.

At $\rho=0$, this argument covers even constant $\delta_n$: the radius is $o(n)$ and the type ball collapses to $Q$. At $\rho=\infty$, one may alternatively use the untruncated law $g_\infty(z)=C_\infty^{-1}e^{-\varepsilon\kappa(z)}$. It is pure $\varepsilon$-DP, satisfies every positive approximate budget, and the same type argument has no radius restriction.

## 6. The phase diagram and scalar computation

Define
$
F_\beta(R)=D(R\Vert P)+\beta t(R),\qquad
L=\max_i\log(q_i/p_i)-\min_i\log(q_i/p_i).
$
For $\beta\ge0$, let $R_\beta$ be the minimizer of $F_\beta$, and write $t_\beta=t(R_\beta)$. Existence follows from compactness and continuity; strict convexity of entropy gives uniqueness. In particular, $R_0=P$.

### 6.1. Clipped minimizers and their radius

The clipped representation of this penalized family is
$
R_{\beta,i}=p_i\min\{a e^\beta,\max\{a,q_i/p_i\}\},
\qquad \sum_iR_{\beta,i}=1.
\tag{6.1}
$
The normalization is continuous and nondecreasing in $a>0$, with limits zero and infinity, so a root exists. The vector is unique even if its scalar representation is not. For completeness, choose subgradients $s_i\in\partial|R_{\beta,i}-q_i|$ so that
$
\log(R_{\beta,i}/p_i)+\tfrac\beta2s_i
=\log a+\tfrac\beta2.
$
Use $s_i=1$ on lower-clipped coordinates above $q_i$, $s_i=-1$ on upper-clipped coordinates below $q_i$, and the corresponding value in $[-1,1]$ otherwise. The entropy identity and subgradient inequality then give, for every $R$,
$
F_\beta(R)-F_\beta(R_\beta)\ge D(R\Vert R_\beta)\ge0.
\tag{6.2}
$
This also verifies the representation at simplex-boundary competitors.

For $\beta\ge L$,
$
F_\beta(R)-D(Q\Vert P)
=D(R\Vert Q)+\sum_i(r_i-q_i)\log(q_i/p_i)+\beta t(R)
\ge D(R\Vert Q)+(\beta-L)t(R)\ge0,
\tag{6.3}
$
so $R_\beta=Q$. For $\beta<L$, moving a small amount of mass in $Q$ from a coordinate with maximal log ratio to one with minimal log ratio has directional derivative $\beta-L<0$; therefore $t_\beta>0$.

The map $\beta\mapsto R_\beta$ is continuous: every subsequential limit of minimizers for converging parameters minimizes the limit objective, and uniqueness identifies it. Two optimality comparisons show that $t_\beta$ is nonincreasing. If two different parameters have the same positive radius, those comparisons and strict convexity force the same minimizer. That vector has a coordinate above $Q$ and another below it; their subgradient identities would force their log-ratio difference to equal both parameters, a contradiction. Thus, when $P\ne Q$, $t_\beta$ is continuous and strictly decreasing on $[0,L]$, and zero thereafter.

### 6.2. Saturation, duality, and derivatives

Set
$
u_*=t_\varepsilon,\qquad \rho_{\rm sat}=\varepsilon t_\varepsilon.
\tag{6.4}
$
If $\varepsilon\ge L$, then $u_*=0$ and the rate is $D(Q\Vert P)$ for every $\rho$. Otherwise, for each $0<u<u_*$, there is a unique $\beta(u)\in(\varepsilon,L)$ with $t_{\beta(u)}=u$. For any feasible $R$,
$
F_\varepsilon(R)
=F_{\beta(u)}(R)-(\beta(u)-\varepsilon)t(R)
\ge F_{\beta(u)}(R_{\beta(u)})-(\beta(u)-\varepsilon)u.
\tag{6.5}
$
Equality holds at $R_{\beta(u)}$. For $u\ge u_*$, the unconstrained minimizer $R_\varepsilon$ is feasible. Theorem 2.1 therefore has the explicit form
$
J_\varepsilon(\rho;P,Q)=
\begin{cases}
D(Q\Vert P),&\rho=0,\\
D(R_{\beta(\rho/\varepsilon)}\Vert P)+\rho,
&0<\rho<\rho_{\rm sat},\\
D(R_\varepsilon\Vert P)+\varepsilon t_\varepsilon,
&\rho\ge\rho_{\rm sat}.
\end{cases}
\tag{6.6}
$
When $\rho_{\rm sat}=0$, the whole expression has the constant value already specified.

Writing $V(u)=\min_{t(R)\le u}F_\varepsilon(R)$, we also obtain
$
V(u)=\sup_{\lambda\ge0}
\{\min_R F_{\varepsilon+\lambda}(R)-\lambda u\}.
\tag{6.7}
$
Weak duality is immediate; (6.5) gives equality with $\lambda=\beta(u)-\varepsilon$ in the active range. Choose $\lambda=0$ after saturation, and any $\lambda\ge0$ with $\varepsilon+\lambda\ge L$ at $u=0$. Thus the dual supremum is attained in every case.

The supporting multipliers at two nearby radii bound the value difference from above and below. Continuity of $\beta(u)$ then yields
$
\frac{\partial}{\partial\rho}J_\varepsilon(\rho;P,Q)
=1-\frac{\beta(\rho/\varepsilon)}\varepsilon,
\qquad 0<\rho<\rho_{\rm sat}.
\tag{6.8}
$
The rate is continuous and convex on $[0,\infty)$, and strictly decreasing and strictly convex on its nonconstant part. Its right derivative at zero is $\min\{0,1-L/\varepsilon\}$; its left derivative at a positive saturation threshold is zero. This argument remains valid across changes of the clipped coordinate sets and does not differentiate an unspecified active set.

Equations (6.1) and (6.6) give nested scalar bisection: normalize a clipped vector for a chosen $\beta$, then adjust $\beta$ to attain the required TV radius. A numerical solution is useful for computation, but a certified finite-sample inequality requires a validated enclosure rather than an unchecked floating-point optimum.

### 6.3. Binary benchmark

For $Q=\operatorname{Bernoulli}(q)$, $P=\operatorname{Bernoulli}(p)$, $q>p$, and
$\varepsilon<\log[q(1-p)/(p(1-q))]$, put
$
r_\varepsilon=\frac{pe^\varepsilon}{1-p+pe^\varepsilon},\qquad
\rho_{\rm sat}=\varepsilon(q-r_\varepsilon).
$
Then
$
J_\varepsilon(\rho)=
\begin{cases}
d(q-\rho/\varepsilon\Vert p)+\rho,&0\le\rho\le\rho_{\rm sat},\\
\varepsilon q-\log(1-p+pe^\varepsilon),&\rho\ge\rho_{\rm sat}.
\end{cases}
\tag{6.9}
$
Here $d$ is Bernoulli relative entropy. The opposite ordering follows by exchanging labels; $\varepsilon\ge L$ gives the constant regime. This specialization illustrates the general theorem and is not a new claim about finite-sample binary optimal mechanisms.

## 7. A constructive finite-sample lower certificate

The mechanism also yields a quantitative complement to (3.11). Define
$
T_{m,\varepsilon}(s)=\sum_{k>s}s_m(k)e^{-\varepsilon k},
\quad
\gamma_n(\eta)=2m\exp\!\left(-\frac{2n\eta^2}{m^2}\right)
+T_{m,\varepsilon}(\lfloor n\eta/2\rfloor).
$
A union bound over histogram coordinates, the bounded-variable exponential inequality, and the noise tail give
$
\Pr_{Q^n}\{\operatorname{TV}(W_n/n,Q)\le\eta\}
\ge[1-\gamma_n(\eta)]_+.
\tag{7.1}
$
On this event, every feasible type in (5.1) has TV distance at most $r_n/n+\eta$ from $Q$. The reverse triangle inequality therefore implies
$
J_{P,n}^{(r_n)}(W_n)
\ge[I_P(Q,r_n/n+\eta)-\varepsilon\eta]_+.
\tag{7.2}
$
Globally this type objective is nonnegative. Furthermore,
$
H(W_n)\le\log N_n+H(Z_{r_n}),\qquad
H(Z_r)=\log C_r+\varepsilon\mathbb E\kappa(Z_r).
\tag{7.3}
$
Combine the lower half of (5.3) with (7.1)–(7.3). The two normalizer terms cancel, yielding
$
\boxed{
\begin{aligned}
\frac{V_n}{n}
&\ge\frac1nD(\mu_{Q,n}^{(r_n)}\Vert\mu_{P,n}^{(r_n)})\\
&\ge[1-\gamma_n(\eta)]_+
[I_P(Q,r_n/n+\eta)-\varepsilon\eta]_+
-\frac{2\log N_n+\varepsilon\mathbb E\kappa(Z_{r_n})}{n}.
\end{aligned}}
\tag{7.4}
$
Taking the maximum of the right side and zero is always permissible. The noise expectation is an explicit finite sum and is bounded by $M_1$. Both finite-sample certificates preserve their stated directions; substituting an uncertified upper estimate of the infimum into the lower certificate would not preserve validity.

## 8. Verification, limitations, and further questions

A companion computational check (not included in this release) enumerates 18 binary and ternary finite-sample instances using rational arithmetic. It checks every ordered histogram-neighbor direction, exact shell and cap counts, all-output type sandwiches, the input likelihood-ratio envelope, normalization, and the identity $\mathbb E_PE_n=1$. Sixteen additional small-radius enumerations cover dimensions two through five. The failed naive calibration following (4.11) is included as an exact counterexample. The program's logarithms, KL values, and variational comparisons are numerical; the general claims rely on the proofs above.

For illustration, take $p=1/10$, $q=4/5$, and $\varepsilon=\log2$. Then $r_\varepsilon=2/11$ and $\rho_{\rm sat}=34\log2/55$. The nonprivate and saturated rates are approximately $1.362737754$ and $0.459207565$. At $n=96$, the enumerated construction gives rates approximately $1.339578078$, $0.826535749$, and $0.440450273$ for the budget families with limiting $\rho/\varepsilon$ equal to $0$, $1/4$, and $1$, respectively. These finite values illustrate convergence; they are not asserted to be finite-sample optima.

The Lean supplement currently contains nine compiled supporting lemmas concerning scalar logarithmic bounds, finite entropy conversion, group-privacy chains, mixture domination, finite likelihood-ratio caps, and e-value calibration. Their reported dependencies are restricted to `Classical.choice`, `Quot.sound`, and `propext`. They do not prove the arbitrary-output integration argument, product coupling, lattice privacy theorem, type asymptotics, or complete variational phase diagram. Full formalization remains incomplete; the Lean source is not included in this release.

The theorem keeps the alphabet, hypotheses, and $\varepsilon>0$ fixed. It does not cover a growing alphabet, vanishing $\varepsilon_n$, zero-probability hypotheses, or a supremum taken uniformly over changing $P,Q$. Full support is used both in continuity arguments and in the output likelihood-ratio cap that controls exceptional information. Extension to unbounded likelihood ratios would require an additional integrability mechanism. Composite nulls require a different validity constraint, and sequential e-processes require consistency across sample sizes and privacy accounting for a transcript. None of those extensions follows from the present fixed-sample result.

The construction permits computation of likelihood-ratio e-values by finite convolution, but it does not establish computational efficiency for growing dimension or a finite-sample optimality characterization of the full private channel class. Finite-sample sharpness, extensions beyond bounded likelihood ratios, and computational reductions for larger fixed alphabets remain separate questions.

## References

1. Jacobsen, B., Gonzalez, T., Brown, G., Fawaz, K., and Ramdas, A. (2026). *Optimal Rates for Differentially Private Hypothesis Testing with E-values*. arXiv:2605.28952v2. [Full preprint](https://arxiv.org/html/2605.28952v2).
2. Csillag, D., and Mesquita, D. (2026). *Differentially Private E-Values*. Proceedings of Machine Learning Research **300**, 1999–2007. [Official proceedings](https://proceedings.mlr.press/v300/csillag26a.html); [preprint](https://arxiv.org/html/2510.18654v1).
3. Awan, J., and Slavkovic, A. (2018). *Differentially Private Uniformly Most Powerful Tests for Binomial Data*. Advances in Neural Information Processing Systems **31**. [Official paper](https://proceedings.neurips.cc/paper_files/paper/2018/file/296472c9542ad4d4788d543508116cbc-Paper.pdf); [preprint](https://arxiv.org/abs/1805.09236).
4. Dolera, E., and Favaro, S. (2022 preprint, v2). *The power of private likelihood-ratio tests for goodness-of-fit in frequency tables*. [arXiv:2109.09630](https://arxiv.org/pdf/2109.09630). Later journal publication: Beraha, M., Dolera, E., and Favaro, S. (2026), *On the power of private likelihood-ratio tests for goodness-of-fit in frequency tables*, Bernoulli **32**(1), 544–566. [DOI:10.3150/25-BEJ1869](https://doi.org/10.3150/25-BEJ1869). The preprint and journal-access scopes are distinguished in Section 1.
5. Li, X., Han, A., Jiang, J., and Gao, J. (2026). *On the Price of Privacy for Language Identification and Generation*. arXiv:2604.07238v2, revised 16 November 2026. [Full preprint](https://arxiv.org/html/2604.07238v2); [version record](https://arxiv.org/abs/2604.07238v2).
