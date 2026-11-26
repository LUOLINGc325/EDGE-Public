# Reciprocal Haar spanning trees for arbitrary spectra

## Abstract

Let a deterministic nonconstant real spectrum be conjugated by a complex
Haar unitary matrix. On the complete graph, assign to each edge the
reciprocal modulus of the corresponding off-diagonal matrix entry.
We prove a first-order law for the minimum spanning tree cost that is
uniform over every such spectrum. After normalization by the spectral
variance and the dimension, the random optimum is asymptotic in
$L^1$ to the negative half moment of a weighted sum of independent
mean-one exponentials. The weights are precisely the centered squared
spectral energy fractions. This identifies every limiting constant,
including arbitrary macroscopic energy spikes and a diffuse residual
mass. The sharp constant range is $[1,\sqrt{\pi}]$, and constant one
occurs exactly when the largest energy fraction vanishes. A fixed-root
tree inequality gives a finite-dimensional expectation sandwich;
a uniform two-column Gaussian coupling and inverse-moment truncation
upgrade it to a random $L^1$ law. All multiplicities and all spectral
concentration levels are allowed. The conclusions concern the
reciprocal minimum spanning tree, and do not identify an optimal
physical control time.

**Keywords:** dependent random optimization; Haar conjugation; minimum
spanning tree; spectral concentration; uniform integrability.

# 1. Model, main results, and prior work

## 1.1 Definitions

For each integer $d\ge2$, let
$\Lambda_d=\operatorname{diag}(\lambda_{1,d},\ldots,\lambda_{d,d})$
have real, nonconstant entries. Define
$$
\bar\lambda_d=d^{-1}\sum_i\lambda_{i,d},\qquad
a_{i,d}=\lambda_{i,d}-\bar\lambda_d,\qquad
v_d=d^{-1}\sum_i a_{i,d}^2>0.
\tag{1}
$$
Let $U_d$ have Haar probability law on the complex unitary group
$\mathrm U(d)$, and set $H_d=U_d^*\Lambda_dU_d$. On the complete
undirected graph on $\{1,\ldots,d\}$ use costs
$W_{ij}=|H_{ij}|^{-1}$ for $i\ne j$. Define $M_d$ as the minimum,
over its finitely many spanning trees, of the sum of their edge costs.
On the null event that an edge entry is zero one may set its cost to
$+\infty$; all assertions below are unaffected. Section 2 proves
almost sure finiteness and integrability. A fixed order resolves
any choices among minimizers. No independence between dimensions
is required.

The centered spectral energy weights and the deterministic coefficient are
$$
w_{d,i}=\frac{a_{i,d}^2}{\sum_k a_{k,d}^2},\qquad
X_d=\sum_{i=1}^d w_{d,i}E_i,\qquad C_d=\mathbb E X_d^{-1/2},
\tag{2}
$$
where $E_i$ are independent exponential variables with mean one.
These auxiliary variables need not be coupled to $U_d$. Write
$$
Y_d=\frac{\sqrt{v_d\log d}}{d^{3/2}}M_d.
\tag{3}
$$
All logarithms are natural. Expectations and $L^1$ norms always refer
to the probability law of the displayed random variables.

## 1.2 Statements

**Theorem 1 (uniform arbitrary-spectrum law).** There exists a
deterministic sequence $\varepsilon_d\downarrow0$, depending only on
the dimension, such that
$$
\sup_{\Lambda_d\ {\rm real,\ nonconstant}}
\mathbb E|Y_d-C_d|\le\varepsilon_d.
\tag{4}
$$
In particular the spectrum may vary arbitrarily with $d$. No bound on
standardized eigenvalues, separation of eigenvalues, or growing
effective rank is imposed.

For $u_j$ the $j$th column of $U_d$, introduce
$$
R_j^2=u_j^*\Lambda_d^2u_j-(u_j^*\Lambda_du_j)^2,\qquad
A_d=\mathbb E\frac{\sqrt{v_d}}{R_1}.
\tag{5}
$$
**Theorem 2 (finite expectation sandwich).** Put $n=d-1$,
$h_m=\mathbb E(\max_{1\le i\le m}E_i)^{-1/2}$, and
$G_n=\Gamma(n)/\Gamma(n-\tfrac12)$. Then
$$
\mathbb E R_1^{-1}\,G_n n h_n
\ \le\ \mathbb E M_d
\ \le\ \mathbb E R_1^{-1}\,G_n\sum_{m=1}^n h_m.
\tag{6}
$$
Consequently, uniformly over nonconstant spectra,
$$
\mathbb E M_d=
\frac{d^{3/2}}{\sqrt{\log d}}\mathbb E R_1^{-1}
\left(1+O((\log d)^{-1})\right).
\tag{7}
$$
The tree that connects each vertex to its cheapest earlier vertex
has the same first-order expected cost.

**Theorem 3 (complete profile classification).** Sort the weights in
(2) in nonincreasing order, and extend them by zero past index $d$.
If, along a sequence of dimensions,
$w_{d,i}\to w_i$ for every fixed $i$, put
$$
s=\sum_{i\ge1}w_i\le1,\quad
X(w)=1-s+\sum_{i\ge1}w_iE_i,\quad
C(w)=\mathbb E X(w)^{-1/2}.
\tag{8}
$$
Then $C_d\to C(w)$ and $Y_d\to C(w)$ in $L^1$. Every sequence of
dimensions and spectra has a further subsequence admitting such
a profile. The series in (8) exists almost surely and in $L^1$.

**Theorem 4 (universality criterion and sharp range).** Define
$$
q_d=\max_i w_{d,i},\qquad
\theta_d=\sum_iw_{d,i}^2
=\frac{\sum_i a_{i,d}^4}{(\sum_i a_{i,d}^2)^2}.
\tag{9}
$$
The following conditions are equivalent:
$q_d\to0$; $\theta_d\to0$; $C_d\to1$; $Y_d\to1$ in $L^1$;
and $Y_d\to1$ in probability. For every finite weight vector,
$1\le C_d\le\sqrt\pi$. For profiles, $C(w)=1$ exactly when all
$w_i=0$, and $C(w)=\sqrt\pi$ exactly when $w_1=1$.
Every value in $[1,\sqrt\pi]$ is realized by a sequence of centered
real spectra.

## 1.3 Position relative to earlier results

Vecer [V26] proves the reciprocal-cost constant-one $L^1$ law under
a uniform bound on standardized eigenvalues, together with finer
expectation expansions. His Sections 2--3 provide the conditional
row law, inverse moments, and recursive tree used below.
Chambrion--Mendico [CM26a] already develop spectral concentration
ratios and single-entry shape limits; their Remark 6 discusses
a strong-center star and the $\sqrt\pi$ heuristic. Their discussion
leaves a rigorous logarithmic gain in the concentrated regime unresolved.
The new claim here is the unrestricted **global optimal-cost**
classification (4), including its exact coefficient and all profiles.
The concentration-ratio equivalence, single-entry profile ideas,
star construction, and the previously obtained critical constant
$10/3$ are not claimed as new. The earlier IRSI note [I26]
establishes qualitative mean vanishing at the critical polynomial
spectrum, without determining the sharp rate or constant.

The problem is a scope extension beyond [V26, assumption (1)], not
an explicitly stated question in its Section 9. It also differs
from the full metric-space scaling limit for independent-edge MSTs
in [ABGM17]. Our proof avoids any assertion that different graph
edges are independent. The source review is bounded by the
versions listed in the references; no global priority certification
or external peer review is asserted.

# 2. Deterministic geometry and radial identities

## 2.1 A fixed-root lower bound

**Lemma 5 (rooted sandwich).** For any finite complete graph with
positive symmetric costs, set
$$
\ell_j=\min_{i\ne j}W_{ij},\qquad
L_d=\sum_{j=2}^d\ell_j,\qquad
T_d=\sum_{j=2}^d\min_{i \lt j}W_{ij}.
$$
Then $L_d\le M_d\le T_d$.

*Proof.* Root an arbitrary spanning tree at vertex $1$. Each other
vertex $j$ has exactly one parent edge, whose cost is at least
$\ell_j$. The parent-edge list contains every tree edge exactly
once. Summing proves the lower bound, without a factor $1/2$.
It does not require the edges attaining the separate minima to
form a tree. For the upper bound choose a minimizing earlier parent
for each $j\ge2$. Parent labels strictly decrease, so every chain
ends at $1$. The selected $d-1$ edges therefore form a spanning tree
of cost $T_d$. This also proves measurability under deterministic
tie breaking. $\square$

## 2.2 Conditional directions and inverse moments

The following identities are included with their derivations to
specify the probability model exactly. The row law and radial bound
are prior tools from [V26, Lemmas 6--7]; the half-moment bound
also occurs in [CM26a].

**Lemma 6 (spherical row).** For fixed $j$, conditional on $u_j$,
the normalized off-diagonal squared moduli
$(|H_{ij}|^2/R_j^2)_{i\ne j}$ have
$\operatorname{Dirichlet}(1,\ldots,1)$ law. This vector is
independent of $R_j$.

*Proof.* Write $r=(I-u_ju_j^*)\Lambda_du_j$. The remaining columns
of the Haar matrix are a uniformly oriented orthonormal basis of
$u_j^\perp$. The coordinates of $r/\|r\|$ in this basis have the
uniform complex sphere law. A complex Gaussian vector normalized
by its length has that law; its squared moduli are independent
unit exponentials divided by their sum. This conditional law
does not depend on $u_j$. Finally $\|r\|^2=R_j^2$. $\square$

**Lemma 7 (radial positivity, moments, and tails).** For $0 \lt t<1$,
$$
\mathbb E(v_d/R_1^2)^t
\le d^{-2t}\frac{\Gamma(d)}{\Gamma(d-2t)}\Gamma(1-t)^2.
\tag{10}
$$
Also
$$
\mathbb E(R_1^2/v_d)=\frac d{d+1},\qquad
\sqrt{\frac{d+1}{d}}\le A_d\le\pi\frac{d-1}{d}.
\tag{11}
$$
For a numerical constant $K<\infty$ independent of $d$ and the
spectrum,
$$
\mathbb E(\sqrt{v_d}/R_1)^{3/2}\le K,\qquad
\mathbb E X_d^{-3/4}\le\Gamma(1/4).
\tag{12}
$$

*Proof.* If $p_i=|u_{i1}|^2$, direct expansion of the weighted
variance gives
$$
R_1^2=\sum_{i \lt k}(a_{i,d}-a_{k,d})^2p_ip_k,\qquad
\sum_{i \lt k}(a_{i,d}-a_{k,d})^2=d^2v_d.
\tag{13}
$$
All $p_i$ are strictly positive almost surely and at least one
coefficient is positive. Convexity of $x^{-t}$ and the
Dirichlet mixed moment
$$
\mathbb E(p_ip_k)^{-t}
=\frac{\Gamma(d)}{\Gamma(d-2t)}\Gamma(1-t)^2
\quad(i\ne k)
$$
give (10). The mixed moment follows by integrating the Dirichlet
density with exponents $1-t$ on coordinates $i,k$ and $1$ on the
others. The ordinary moments
$\mathbb Ep_i^2=2/[d(d+1)]$ and
$\mathbb Ep_ip_k=1/[d(d+1)]$ give the first equality in (11).
Jensen and (10) at $t=1/2$ give the remaining inequalities.
At $t=3/4$ the gamma ratio divided by $d^{3/2}$ is bounded for
all $d\ge2$, proving the first part of (12). Finally
$X_d^{-3/4}\le\sum_iw_{d,i}E_i^{-3/4}$ by convexity,
which gives the second part. $\square$

Lemma 6 and positivity imply that every off-diagonal entry is
nonzero almost surely, including when $d=2$.
All edge reciprocals are integrable: their means factor into
$\mathbb ER_1^{-1}$ and a finite negative half moment of a
Dirichlet coordinate. Thus all tree costs above are integrable.

# 3. Exponential maxima and the exact mean law

**Lemma 8 (directional maximum identity).** Let
$(\xi_1,\ldots,\xi_n)$ have $\operatorname{Dirichlet}(1,\ldots,1)$
law. For $1\le m\le n$,
$$
\mathbb E(\max_{i\le m}\xi_i)^{-1/2}=G_n h_m.
\tag{14}
$$

*Proof.* For independent unit exponentials set
$S_n=\sum_{i=1}^nE_i$. The vector $\xi_i=E_i/S_n$ is independent
of $S_n$, which has $\operatorname{Gamma}(n,1)$ law. Since
$(\max_{i\le m}E_i)^{-1/2}
=S_n^{-1/2}(\max_{i\le m}\xi_i)^{-1/2}$, divide expectations by
$\mathbb ES_n^{-1/2}=\Gamma(n-\tfrac12)/\Gamma(n)$.
The identity remains valid for $n=m=1$. $\square$

**Lemma 9 (dimension-only asymptotics).** As $m,n\to\infty$,
$$
h_m=(\log m)^{-1/2}+O((\log m)^{-3/2}),\qquad
\sum_{m=1}^nh_m=\frac n{\sqrt{\log n}}
 +O\!\left(\frac n{(\log n)^{3/2}}\right).
\tag{15}
$$

*Proof.* Put $Z_m=\max_{i\le m}E_i$ and $b=\log m$.
Its distribution is $(1-e^{-x})^m$ for $x\ge0$.
For completeness, the ordered exponential sample has independent
successive spacings of rates $m,m-1,\ldots,1$: at each step the
memoryless residual lifetimes are independent unit exponentials,
whose minimum has the current rate. Hence
$\mathbb EZ_m=\sum_{k=1}^m k^{-1}$ and
$\operatorname{Var}(Z_m)=\sum_{k=1}^m k^{-2}$.
It follows that $\mathbb E|Z_m-b|$ is bounded absolutely.
On $Z_m\ge b/2$, the derivative of $x^{-1/2}$ bounds the
mean replacement error by $O(b^{-3/2})$.

The singular region is also controlled. With $t=b/2$ and
$F_m(x)=(1-e^{-x})^m$, integration by parts gives
$$
\mathbb E[Z_m^{-1/2}\mathbf1_{\{Z_m \lt t\}}]
=t^{-1/2}F_m(t)+\frac12\int_0^t x^{-3/2}F_m(x)\,dx.
\tag{16}
$$
For large $m$, split the integral at $1/2$ and $1$.
Use $F_m(x)\le x^m$ on $(0,1/2)$,
$F_m(x)\le(1-e^{-1})^m$ on $(1/2,1)$, and
$F_m(x)\le e^{-\sqrt m}$ on $(1,t)$. Each resulting term is
negligible compared with $b^{-3/2}$. The missing constant
$b^{-1/2}\mathbb P(Z_m \lt t)$ is negligible as well. This proves
the first estimate.

For the sum, its first $\lfloor\sqrt n\rfloor$ terms are at most
$\sqrt n\,h_1=\sqrt{\pi n}$. For the others the errors in the
first estimate sum to $O(n(\log n)^{-3/2})$. The mean value
theorem, for $m\ge\sqrt n$, gives
$$
0\le(\log m)^{-1/2}-(\log n)^{-1/2}
\le C(\log n)^{-3/2}\log(n/m).
$$
The sum of $\log(n/m)$ for $1\le m\le n$ is at most $n$,
by comparison with its integral. This proves (15). $\square$

*Proof of Theorem 2.* Lemma 5 bounds $M_d$ by two sums of row
minima. Lemma 6 factors each summand into an inverse radius and
an independent direction. Lemma 8 evaluates the directional
means exactly, with $m=n$ for every lower summand and
$m=j-1$ for the upper summands. This is (6).
Use (15), $G_n=\sqrt n(1+O(n^{-1}))$, and $n=d-1$ to obtain
(7). The gamma ratio estimate follows directly from Stirling's
formula. The ratio of the two bounds in (6) is dimension only;
therefore the relative error and the asymptotic optimality of
$T_d$ are uniform in the spectrum. $\square$

# 4. From a tree optimum to an empirical radius

Define $F_j=\sqrt{v_d}/R_j$ and
$\overline F_d=d^{-1}\sum_{j=1}^dF_j$.

**Lemma 10 (uniform random reduction).**
$$
\sup_{\Lambda_d}\|Y_d-\overline F_d\|_1\longrightarrow0.
\tag{17}
$$

*Proof.* Let $\kappa_d=\sqrt{v_d\log d}/d^{3/2}$.
The tree sandwich and (6), (15), (11) give
$$
0\le\mathbb E(Y_d-\kappa_dL_d)
\le\kappa_d\mathbb E(T_d-L_d)=O((\log d)^{-1})
\tag{18}
$$
uniformly. For a row put
$$
D_{d,j}=\sqrt{\frac{\log d}{d}}\,
(\max_{i\ne j}\xi_{ij})^{-1/2}.
$$
Then $\kappa_dL_d=d^{-1}\sum_{j=2}^dF_jD_{d,j}$.
For each fixed $j$, $F_j$ and $D_{d,j}$ are independent;
there is no assertion of independence between rows.

The law of $D_{d,j}$ depends only on $d$. The representation
$\max_i\xi_i=Z_n/S_n$, the law of large numbers for $S_n/n$,
and $Z_n/\log n\to1$ in probability imply $D_{d,j}\to1$ in
probability. The last convergence follows directly from
$\mathbb P(Z_n\le x)=(1-e^{-x})^n$ and the union bound for
$Z_n>(1+\delta)\log n$. By (14)--(15),
$\mathbb ED_{d,j}\to1$.
For nonnegative $D$,
$$
\mathbb E|D-1|=\mathbb ED-1+2\mathbb E(1-D)_+.
$$
Bounded convergence in probability for $(1-D_{d,j})_+$
therefore yields $\mathbb E|D_{d,j}-1|\to0$.
Independence within each row and (11) now give
$$
\|\kappa_dL_d-\overline F_d\|_1
\le\pi\mathbb E|D_{d,1}-1|+\pi/d.
$$
Together with (18), this proves (17). $\square$

# 5. Uniform concentration without a spectral regularity hypothesis

The singularity of $x^{-1/2}$ prevents an unqualified passage
from approximate quadratic forms to inverse moments. We first
give a coupling for the squared radii, then use (12).

## 5.1 Two-column Gaussian comparison

Set
$$
A=\frac{\Lambda_d-\bar\lambda_d I}{\sqrt{dv_d}},\qquad B=A^2.
$$
Thus $\operatorname{tr}A=0$,
$\operatorname{tr}B=1$, and $\operatorname{tr}B^2\le1$.
Let $g,h$ be independent standard circular complex Gaussian
vectors, each coordinate having squared modulus
$\operatorname{Exp}(1)$. Construct
$$
q_1=g/\|g\|,\quad \alpha=q_1^*h,\quad
z=h-q_1\alpha,\quad q_2=z/\|z\|.
\tag{19}
$$
Rotational invariance and conditional invariance on $q_1^\perp$
show that $(q_1,q_2)$ is a Haar orthonormal two-frame.
Define
$$
S_j=d\{q_j^*Bq_j-(q_j^*Aq_j)^2\},\quad
\widetilde X_1=g^*Bg,\quad\widetilde X_2=h^*Bh.
$$
The $S_j$ have the joint law of two normalized squared radii.
The variables $\widetilde X_1,\widetilde X_2$ are independent
copies of $X_d$.

**Lemma 11 (uniform two-column error).**
$$
\begin{split}
\mathbb E|S_1-\widetilde X_1|
 &\le d^{-1/2}+(d+1)^{-1},\\
\mathbb E|S_2-\widetilde X_2|
 &\le3d^{-1/2}+d^{-1}+(d+1)^{-1}.
\end{split}
\tag{20}
$$

*Proof.* The Gaussian squared length $G=\|g\|^2$ is
$\operatorname{Gamma}(d,1)$ and independent of $q_1$.
Since $\mathbb Eq_1^*Bq_1=1/d$,
$$
\mathbb E|dq_1^*Bq_1-g^*Bg|
=d^{-1}\mathbb E|d-G|\le d^{-1/2}.
\tag{21}
$$
For either uniform column, the Dirichlet second moments give
$\mathbb E[d(q_j^*Aq_j)^2]=1/(d+1)$.
This proves the first inequality.

Conditional on $q_1$, the vectors $q_1\alpha$ and $z$ are
independent Gaussian projections. The variable
$G_z=\|z\|^2$ has $\operatorname{Gamma}(d-1,1)$ law and is
independent of $(q_1,q_2)$: its conditional radial law does
not depend on $q_1$. Hence
$$
\mathbb E|dq_2^*Bq_2-z^*Bz|
=d^{-1}\mathbb E|d-G_z|\le d^{-1/2}.
\tag{22}
$$
The last inequality uses
$\mathbb E(d-G_z)^2=(d-1)+1=d$.
Deleting the projection changes the quadratic form by
$$
h^*Bh-z^*Bz
=|\alpha|^2q_1^*Bq_1+
2\operatorname{Re}(\overline\alpha\,q_1^*Bz).
$$
The first term has mean $1/d$. For the second, conditional
independence and Cauchy--Schwarz give
$$
\mathbb E|\alpha q_1^*Bz|
\le\sqrt{\mathbb E[q_1^*B(I-q_1q_1^*)Bq_1]}
\le\sqrt{\operatorname{tr}B^2/d}\le d^{-1/2}.
\tag{23}
$$
Combine (22)--(23) with the diagonal-square mean
$1/(d+1)$ to prove the second inequality.
Every bound uses only $\operatorname{tr}B=1$ and
$\operatorname{tr}B^2\le1$. $\square$

## 5.2 Truncation and empirical concentration

**Lemma 12 (uniform inverse-radius concentration and proxy).**
$$
\sup_{\Lambda_d}\|\overline F_d-A_d\|_1\to0,\qquad
\sup_{\Lambda_d}|A_d-C_d|\to0.
\tag{24}
$$

*Proof.* For $T\ge1$ define
$f_T(x)=\min(x^{-1/2},T)$ on $x>0$, with $f_T(0)=T$.
It is bounded by $T$ and globally Lipschitz on $[0,\infty)$
with constant $T^3/2$.
Let $e_j=\mathbb E|S_j-\widetilde X_j|$ in (20).
Because the proxies are independent, comparison of their
product expectation and then of the product of marginal
expectations yields
$$
|\operatorname{Cov}(f_T(S_1),f_T(S_2))|
\le T^4(e_1+e_2)\le C T^4d^{-1/2}.
\tag{25}
$$
Indeed each comparison is bounded by
$T(T^3/2)(e_1+e_2)$. Column exchangeability therefore gives
$$
\operatorname{Var}\!\left(d^{-1}\sum_{j=1}^df_T(R_j^2/v_d)\right)
\le T^2/d+C T^4d^{-1/2}.
\tag{26}
$$
By (12) and $F\mathbf1_{\{F>T\}}\le F^{3/2}T^{-1/2}$,
removing the truncation from the average and from its mean
costs at most $2KT^{-1/2}$ in $L^1$. Thus
$$
\|\overline F_d-A_d\|_1
\le2KT^{-1/2}+\sqrt{T^2/d+C T^4d^{-1/2}}.
\tag{27}
$$
For fixed $T$ let $d\to\infty$, then let $T\to\infty$.
The bounds do not depend on the spectrum.

For the second assertion, couple the first column with its
proxy and compare truncated expectations:
$$
|A_d-C_d|
\le (K+\Gamma(1/4))T^{-1/2}
 +(T^3/2)\{d^{-1/2}+(d+1)^{-1}\}.
\tag{28}
$$
The same order of limits proves the assertion. $\square$

*Proof of Theorem 1.* Apply the triangle inequality to (17) and
(24). This gives a dimension-only error tending to zero.
Replacing it by the supremum of its tail gives the decreasing
sequence in (4). No concentration of individual radii is needed:
fixed-rank spectra provide examples where those radii retain
nontrivial fluctuations. $\square$

# 6. Spectral profiles and the universality boundary

## 6.1 The profile limit

*Proof of Theorem 3.* A diagonal subsequence argument in
$[0,1]^{\mathbb N}$ gives coordinatewise compactness for sorted
weight vectors. Finite partial sums show $\sum_iw_i\le1$.
The positive series $\sum_iw_iE_i$ is integrable by monotone
convergence and therefore finite almost surely. Its mean is $s$;
it is positive almost surely if $s>0$. Thus $X(w)>0$ almost surely,
also when $s=0$.

For fixed $r$, the first $r$ terms in $X_d$ converge in law.
The remaining sum has mean $1-\sum_{i\le r}w_{d,i}$ and variance
$$
\sum_{i>r}w_{d,i}^2\le w_{d,r+1}\le\frac1{r+1}.
\tag{29}
$$
Its centered part is consequently uniformly small in $L^2$
as $r\to\infty$. The limiting series has the same tail bound.
Using bounded Lipschitz test functions, first send $d\to\infty$
at fixed $r$, then $r\to\infty$, to obtain
$X_d\Rightarrow X(w)$, including the deterministic residual
$1-s$. By (12), $X_d^{-1/2}$ are uniformly integrable.
The continuous mapping theorem on $(0,\infty)$ followed by
truncation gives $C_d\to C(w)$. Theorem 1 completes the proof.
$\square$

One useful integral representation is
$$
C(w)=\frac1{\sqrt\pi}\int_0^\infty
t^{-1/2}e^{-(1-s)t}\prod_{i\ge1}(1+t w_i)^{-1}\,dt.
\tag{30}
$$
For finite $d$ omit the residual exponential and use its finite
product to obtain $C_d$. The identity follows from the gamma
integral for $x^{-1/2}$, independence, and Tonelli's theorem.
The infinite product converges for each $t$ because
$\sum_i\log(1+t w_i)\le ts$.

## 6.2 An explicit Jensen gap

**Lemma 13 (quantitative necessity).** There is an absolute
constant
$$
c_*=\frac1{2\sqrt\pi}\int_0^\infty
\frac{t^{3/2}e^{-t}}{1+t}\,dt>0
$$
such that $C_d-1\ge c_*\theta_d$ for every probability
weight vector in (2).

*Proof.* For $x\ge0$,
$x-\log(1+x)=\int_0^x u/(1+u)\,du
\ge x^2/[2(1+x)]$. Hence
$$
\prod_i(1+t w_{d,i})^{-1}
\ge e^{-t}\exp\!\left(\frac{t^2\theta_d}{2(1+t)}\right).
$$
Subtract the Laplace representation of $1=1^{-1/2}$ from
that of $C_d$, and use $e^x-1\ge x$. Tonelli and positivity
give the displayed bound. The defining integral is finite
and strictly positive. $\square$

*Proof of Theorem 4.* Jensen gives $C_d\ge1$, while pointwise
convexity gives
$X_d^{-1/2}\le\sum_iw_{d,i}E_i^{-1/2}$ and hence
$C_d\le\sqrt\pi$. The elementary inequalities
$q_d^2\le\theta_d\le q_d$ prove their vanishing equivalence;
this concentration-ratio observation is already in [CM26a,
Proposition 26].
If $\theta_d\to0$, then
$\operatorname{Var}X_d=\theta_d\to0$ and $\mathbb EX_d=1$.
The inverse-moment bound (12) gives $C_d\to1$.
The converse follows from Lemma 13.

Theorem 1 transfers $C_d\to1$ to $L^1$ and probability
convergence of $Y_d$. Conversely, if $Y_d\to1$ in probability,
then $|Y_d-C_d|\to0$ in probability by (4). Since $C_d$ is
deterministic, this forces $C_d\to1$.

For a profile, $\operatorname{Var}X(w)=\sum_iw_i^2$, so strict
Jensen gives $C(w)=1$ exactly when all spikes vanish.
To prove the other endpoint, apply Jensen to the random
mixture with weight $1-s$ at the constant $1$ and weights
$w_i$ at the realized values $E_i$. This can be justified
directly by a countable discrete probability measure, or by
integrable truncation. It yields
$$
C(w)\le (1-s)+s\sqrt\pi\le\sqrt\pi.
\tag{31}
$$
If $s<1$, the last inequality is strict. If $s=1$ and at least
two weights are positive, the first inequality is almost
surely strict because their independent exponential values
differ almost surely. Thus the upper equality occurs precisely
for a single unit spike. Attainability of every intermediate
constant is proved in Section 7.2. $\square$

# 7. Exact examples and the vanishing scale

## 7.1 Projection spectra

**Proposition 14 (finite rank calibration).** Let
$\Lambda_d=bI+aP_r$, where $a\ne0$, $P_r$ is a diagonal
rank-$r$ projection, and $1\le r\le d-1$. Then
$$
\mathbb E R_1^{-1}
=\frac{d-1}{|a|}
\frac{\Gamma(r-\tfrac12)}{\Gamma(r)}
\frac{\Gamma(d-r-\tfrac12)}{\Gamma(d-r)}.
\tag{32}
$$
If $r$ is fixed while $d\to\infty$, then
$$
Y_d\longrightarrow C_r
=\sqrt r\,\frac{\Gamma(r-\tfrac12)}{\Gamma(r)}
\quad\hbox{in }L^1.
\tag{33}
$$
If $d-r=s$ is fixed, the limit is instead $C_s$. If both
$r$ and $d-r$ diverge, $Y_d\to1$ in $L^1$.

*Proof.* For a uniform column,
$Q=u_1^*P_ru_1$ has $\operatorname{Beta}(r,d-r)$ law and
$R_1^2=a^2Q(1-Q)$. Integrating its density gives the beta
ratio in (32). Since $v_d=a^2r(d-r)/d^2$, multiplication
by $\sqrt{v_d}$ and the gamma-ratio asymptotic gives (33)
by Theorem 1 and (24). Alternatively the fixed-rank energy
profile has $r$ weights $1/r$ and no others.
If both ranks diverge, the largest centered energy weight
is at most $\max(1/r,1/(d-r))$, so Theorem 4 applies. $\square$

Here $C_1=\sqrt\pi$, $C_2=\sqrt{\pi/2}$, and $C_r$ decreases
strictly to one. Indeed
$$
\left(\frac{C_{r+1}}{C_r}\right)^2
=1-\frac{3r-1}{4r^3}<1,\qquad
C_r=1+\frac{3}{8r}+O(r^{-2}).
\tag{34}
$$
The identity follows from the gamma recurrence, and the
expansion from Stirling's formula.

For rank one there is also a direct pathwise check. Write
$H=a uu^*+bI$, put $p_i=|u_i|^2$, and choose a maximizer $i_*$
of $p_i$. Rooting every tree at $i_*$ gives
$$
M_d=\frac1{|a|\sqrt{p_{i_*}}}
\sum_{i\ne i_*}p_i^{-1/2}.
\tag{35}
$$
The lower bound is attained by the star centered at $i_*$.
We use this as calibration; the strong-star idea and
$\sqrt\pi$ motivation already appear in [CM26a, Remark 6].

## 7.2 A continuous family realizing the sharp range

**Proposition 15 (one energy spike).** For the profile
$w=(\eta,0,\ldots)$, $0\le\eta\le1$, the coefficient is
$$
C(\eta)=\mathbb E(1-\eta+\eta E)^{-1/2}.
$$
It is continuous, strictly increasing from $1$ to $\sqrt\pi$,
and for $0<\eta\le1$ equals
$$
C(\eta)=\sqrt{\frac{\pi}{\eta}}\,
\exp\!\left(\frac{1-\eta}{\eta}\right)
\operatorname{erfc}\!\sqrt{\frac{1-\eta}{\eta}}.
\tag{36}
$$

*Proof.* Substitution in the exponential density integral
gives (36), with
$\operatorname{erfc}(x)=2\pi^{-1/2}\int_x^\infty e^{-t^2}\,dt$.
The uniform negative $3/4$ moment bound applies also to the
mixture with a deterministic mass at $1$, so convergence in
probability as $\eta$ varies implies continuity of the mean
inverse square root, including the endpoints.
On compact subintervals of $[0,1)$, differentiation is
justified by an integrable polynomial in $E$ and a positive
lower bound for $1-\eta+\eta E$. It gives $C'(0+)=0$ and
$$
C''(\eta)=\tfrac34\mathbb E[
(E-1)^2(1-\eta+\eta E)^{-5/2}]>0.
$$
Therefore $C$ is strictly increasing; continuity covers $\eta=1$.

We must also realize this profile by centered spectra.
For $d\ge3$, let
$$
b^{(d)}=\left(\sqrt{\frac{d-1}{d}},
 -\frac1{\sqrt{d(d-1)}},\ldots,
 -\frac1{\sqrt{d(d-1)}}\right).
$$
Choose $z^{(d)}$ with first coordinate zero, total sum zero,
norm one, and $\max_i|z_i^{(d)}|=O(d^{-1/2})$. For instance,
use equal numbers of $+1/\sqrt{2k}$ and $-1/\sqrt{2k}$ on
the last $d-1$ coordinates, with
$k=\lfloor(d-1)/2\rfloor$, and put any remaining coordinate
zero. These vectors are orthogonal.
Set
$a^{(d)}=\sqrt\eta\,b^{(d)}+\sqrt{1-\eta}\,z^{(d)}$.
It has sum zero and squared norm one. Its first squared
coordinate tends to $\eta$, and every other squared
coordinate tends uniformly to zero. Its sorted squared
energy profile is therefore the stated one.
Theorem 3 and continuity of $C$ realize the entire interval.
$\square$

## 7.3 A shape-free vanishing criterion

**Corollary 16.** For every sequence of nonconstant deterministic
real spectra,
$$
M_d\to0\ {\rm in\ probability}
\quad\Longleftrightarrow\quad M_d\to0\ {\rm in}\ L^1
\quad\Longleftrightarrow\quad
\frac{v_d\log d}{d^3}\to\infty.
\tag{37}
$$

*Proof.* Let $s_d=d^{3/2}/\sqrt{v_d\log d}$, so $M_d=s_dY_d$.
If $s_d\to0$, Theorem 1 and $C_d\le\sqrt\pi$ give
$\mathbb EM_d\to0$. Conversely, $C_d\ge1$ and (4) imply
$\mathbb P(Y_d\ge1/2)\to1$. If $s_d$ does not tend to zero,
a subsequence has $s_d\ge\delta>0$; along it
$\mathbb P(M_d\ge\delta/2)\to1$. This precludes convergence
to zero in probability. $\square$

The scale in (37) is already known under regularity assumptions
in [V26]; the added conclusion is its validity for every
nonconstant spectrum. If a control model supplies a bound
on its control time by $\pi M_d/2$, only the corresponding
sufficient upper-bound implication follows. A necessary
condition, a matching time asymptotic, or an exact physical
control constant would require separate arguments and the
model's control hypotheses.

# 8. Reproducibility and scope

The proofs above establish the claims without Monte Carlo
assumptions or a numerical certificate. The accompanying
diagnostics implement finite graph checks of Lemma 5, the
rank-one identity (35), the beta/gamma formulas, coefficient
quadrature, and modest Haar simulations. Fixed seeds,
parameters, raw outputs, and commands are recorded in
REPRODUCTION.md. Their purpose is to detect normalization
or implementation errors; finite samples do not verify the
uniform limit or determine its convergence rate.

The main theorem covers complex Haar conjugation, deterministic
real nonconstant spectra, and reciprocal-modulus costs.
It does not establish the real orthogonal analogue, a
central limit theorem, a connectivity threshold, higher
logarithmic correction coefficients, or a geometric limit
of the entire tree. A scalar spectrum is excluded because
all off-diagonal entries then vanish. Formal proof-assistant
verification and external peer review have not been completed.

# References

- **[V26]** J. Vecer. *Frieze's $\zeta(3)$ and the
  Avram--Bertsimas constant under Haar conjugation*.
  arXiv:2611.31583v1, 23 November 2026.
  <https://arxiv.org/html/2611.31583v1>.
- **[CM26a]** T. Chambrion and C. Mendico. *Vanishing Control
  Times for Single-Input Bilinear Quantum Systems under Rapid
  Drift Spectral Growth*. arXiv:2611.12502v2, revised
  10 November 2026; PDF dated 11 November.
  <https://arxiv.org/abs/2611.12502v2>.
- **[CM26b]** T. Chambrion and C. Mendico. *Minimal Control
  Time of Large Generic Quantum Systems at Critical Spectral
  Growth: A Minimum-Spanning-Tree Analysis*.
  arXiv:2611.14091v2.
  <https://arxiv.org/html/2611.14091v2>.
- **[ABGM17]** L. Addario-Berry, N. Broutin, C. Goldschmidt,
  and G. Miermont. The scaling limit of the minimum spanning
  tree of the complete graph. *The Annals of Probability*
  **45**(5), 3075--3144, 2017.
  <https://doi.org/10.1214/16-AOP1132>.
- **[I26]** IRSI. Qualitative critical-growth Haar MST note,
  12 November 2026. Internal AI research note, not external
  peer review. <https://irsi.ai/notes/haar-mst-critical/>.

