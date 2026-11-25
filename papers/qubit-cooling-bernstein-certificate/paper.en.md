# Polynomial-Time Exact Certificates for Qubit Cooling Shell Capacity

*An all-temperature theorem through dimension 64, universal boundary coefficients, and the role of integer multiplicities*

AI-assisted research manuscript

24 November 2026

## Abstract

Exactly resonant collisions between a two-level system and a finite thermal
machine reduce an all-temperature local quadratic dissipation problem to a
family of polynomial inequalities indexed by positive integer level
multiplicities. We develop a structurally stronger certificate: elevate the
polynomial to the Bernstein basis of degree one less than the total dimension,
and minimize every coefficient over all multiplicity sequences by exact
dynamic programming. At fixed dimension $m$,
all coefficient minima can be computed in $O(m^5)$ arithmetic operations.
The integers have $O(m\log m)$ bits, so the bit complexity is also polynomial
in $m$. Two independent arbitrary-precision implementations establish
nonnegativity for every composition and coefficient at every $2\le m\le64$.
We also establish three boundary coefficients analytically in every dimension
and give an exact counterexample to the continuous-multiplicity relaxation,
even when the total multiplicity is an integer. Related work [5] that proves the physical bound for arbitrary
dimension by a different route. Our physical conclusion is therefore an
independent verification; the contribution is confined to coefficient
structure, exact optimization, and the obstruction to continuous multiplicities.

**Scope.** This is a research manuscript containing a finite-dimension
coefficient theorem and a general exact algorithm. Nonnegativity of every
Bernstein coefficient in arbitrary dimension remains unproved; the weaker
qubit physical bound is covered by the concurrent case [5]. General system
dimensions, finite-amplitude processes, and arbitrary detuned collisions are
outside this manuscript's conclusion.
No floating-point sign decisions enter the certificate. The work has not
been checked by a proof assistant or subjected to external peer review.

## 1. Problem, sources, and contributions

Mishra and Senthilkumar [1] propose an all-temperature dissipation conjecture
in finite-resource cooling. Their Theorem 2 covers a maximally mixed system or
a two-level machine, while Supplement S11 leaves a gap for more general
parameters. We fix the system dimension at two and study a local quadratic
bound on finite machine resources, rather than the original conjecture for
all system dimensions.

The earlier manuscript [4] already gives the resonant-shell capacity
reduction, an exhaustive integer proof for $m\le18$, and several analytic
subclasses without a dimension cutoff. We retain this attribution. The new
contributions are exact optimization of Bernstein coefficients over every
composition; a polynomial-size dynamic program replacing exponential
enumeration; a full coefficient-nonnegativity certificate for $m\le64$;
an integer-height proof and equality characterization for the penultimate
coefficient; and a rigorous counterexample to allowing real multiplicities.
For completeness we also include the elementary left-endpoint calculation
and the right-endpoint identity already shared with [5]. Bernstein bases, dynamic
programming, and integer arithmetic are standard tools. Our novelty claim is
limited to their structured combination, proofs, and application here.

The related work [5] proves the scalar and physical bounds for every machine dimension using
a minimal-dimension counterexample argument and a finite-prefix case split.
Our Bernstein route has not established an arbitrary-dimension theorem, and
we neither claim the result of [5] nor continue to list the same physical
problem as open. The Bernstein enclosures used in [5] on
finite parameter subintervals differ from optimizing every coefficient, over
every composition, at the fixed degree $m-1$. Polynomial nonnegativity alone
does not imply nonnegativity of these coefficients. 

## 2. Precise statements

Let $p_0,p_1>0$, with $p_0+p_1=1$, be the system reference probabilities.
Let $q_y>0$, with $\sum_{y=1}^m q_y=1$, be the machine reference probabilities,
where $m\ge2$ is an integer. A permutation $P$ acts on
$\{0,1\}\times\{1,\ldots,m\}$ and exactly preserves product reference
weights: if $P(x',y')=(x,y)$, then $p_{x'}q_{y'}=p_xq_y$. For any real vector
$\psi$, define

$$
\Delta_x(y)=\psi_{y'}-\psi_y,
\qquad (x',y')=P^{-1}(x,y),
$$

$$
E=\sum_{x,y}p_xq_y\Delta_x(y)^2,
\qquad
F=\sum_x p_x\left(\sum_yq_y\Delta_x(y)\right)^2.
$$

Writing $\delta_x=p_x\sum_yq_y\Delta_x(y)$ gives
$F=\sum_x\delta_x^2/p_x$. In the corresponding local expansion,
the quadratic dissipation coefficient is $Q=(E-F)/2$ [1, Supplement S11.1].

**Theorem 1 (independent finite-dimension verification of the physical bound).** For every integer
$2\le m\le64$ and all data satisfying the assumptions above,

$$
F\le\left(1-\frac1m\right)E,
\qquad Q\ge\frac{F}{2(m-1)}.
$$

Within this dimension range, the first inequality is strict if $m\ge3$,
$p_0\ne p_1$, and $E>0$. Here “all-temperature” means all strictly positive
reference probabilities within the model. Zero-probability absolute-zero
limits have not been added to the hypotheses.

The permutation statement is what this manuscript proves directly.
The fixed-reference-system-input reduction, $R=0$, in [1, Theorem 1 and
Supplements S10 and S11(c)] transfers it, under that reduction's assumptions,
to the first-order **spectral displacement** and corresponding quadratic cost
of coherent collisions. This literature-dependent corollary is not extended
here to arbitrary finite amplitudes, arbitrary changes of the input state,
or arbitrary detuning.

## 3. From resonant shells to an integer-multiplicity polynomial

We restate the reduction from [4] to make the argument self-contained.
Relabel the system so that $p_0\ge p_1$. If equality holds, use the maximally
mixed case of [1, Theorem 2] directly. The shell-merging structure changes at
equal system probabilities, so merely taking $t\to1$ in the geometric chain
below is not a substitute for that argument.

Now let $t=p_1/p_0\in(0,1)$, so $p_0=1/(1+t)$ and $p_1=t/(1+t)$.
Make machine levels the vertices of a graph, joining distinct source and
target machine labels of configurations moved by the permutation. Every
connected component is preserved by the permutation. Normalize the machine
probabilities inside one component. Its distinct weights have the form

$$
q_y=\frac{t^i}{S(t)},\qquad
S(t)=\sum_{i=0}^L n_i t^i,\qquad
n_i\in\mathbb Z_{\ge1},\qquad
\sum_{i=0}^L n_i=m.
$$

In this section, $m$ temporarily denotes the component dimension. The form
above follows because a resonant edge has machine-weight ratio $1$, $t$, or
$t^{-1}$. Connectivity makes the exponent set consecutive: any path between
the smallest and largest exponents must cross all intermediate integer
values. A one-layer component has no net transfer between system labels.

A resonant shell containing both system labels consists of label 1 at layer
$i$ and label 0 at layer $i+1$. Every configuration in it has reference weight

$$
w_i=\frac{p_1t^i}{S(t)}=\frac{p_0t^{i+1}}{S(t)}.
$$

Let $a_i$ be the weighted net perturbation transferred to the label-1 part of
this shell. A permutation preserves the total perturbation within an
equal-weight shell, so the label-0 net perturbation is $-a_i$. A single-label
shell has zero net perturbation. Applying Cauchy–Schwarz separately to the
two label classes bounds the contribution to $E$ from below by

$$
\frac{a_i^2}{w_i n_i}+\frac{a_i^2}{w_i n_{i+1}}
=\frac{a_i^2}{w_i h_i},
\qquad h_i=\frac{n_i n_{i+1}}{n_i+n_{i+1}}.
$$

If there is no mixed shell, then $F=0$. Otherwise $B=\sum_i w_i h_i>0$.
Writing $\delta=\sum_i a_i$, a second Cauchy–Schwarz inequality gives

$$
F=\frac{\delta^2}{p_0p_1},\qquad
E\ge\frac{\delta^2}{B},\qquad
B=\sum_i w_i h_i.
$$

If $\delta=0$, then $F=0$. Otherwise,

$$
\frac FE\le\frac{B}{p_0p_1}
=\frac{(1+t)\sum_{i=0}^{L-1}h_it^i}{S(t)}.
$$

It therefore suffices to prove, for every positive integer ordered
composition $n=(n_0,\ldots,n_L)$,

$$
G_n(t):=\frac{m-1}{m}S(t)
-(1+t)\sum_{i=0}^{L-1}h_it^i\ge0. \tag{1}
$$

Also write $D(t)=S(t)-(1+t)\sum_i h_it^i$, so $G=D-S/m$.
If a probability ratio greater than one is used, reversing the composition
gives $G_n(r)=r^L G_{n^{\mathrm{rev}}}(1/r)$.

Finally, restore multiple connected components. Let their probability masses
and dimensions be $\lambda_c$ and $m_c$, and let $E_c,F_c$ be computed after
normalizing within each component. Then $E=\sum_c\lambda_cE_c$.
Jensen's inequality for the squared mean in each system row gives
$F\le\sum_c\lambda_cF_c$. Since $m_c\le m$, combining the component
factors $1-1/m_c$ yields the global factor $1-1/m$.
Single-vertex components contribute zero.

Equation (1) is a sufficient condition for the physical bound. Even if a
future composition violates (1), a physical counterexample would additionally
require showing that the shell-capacity relaxation is attainable by a real
permutation and perturbation.

## 4. Bernstein elevation and the exact algorithm

Let $d=m-1$. Since $L\le d$, equation (1) can be written exactly as

$$
G_n(t)=\sum_{k=0}^d B_k(n)\binom dk t^k(1-t)^{d-k}, \tag{2}
$$

$$
g_i=\frac{m-1}{m}n_i-h_{i-1}-h_i,\qquad
B_k(n)=\sum_{i=0}^{\min(k,L)}g_i\frac{\binom ki}{\binom di}, \tag{3}
$$

where $h_{-1}=h_L=0$. Identity (3) follows directly from

$$
t^i=\sum_{k=i}^d\frac{\binom ki}{\binom di}
\binom dk t^k(1-t)^{d-k}.
$$

Indeed, $\binom dk\binom ki=\binom di\binom{d-i}{k-i}$ reduces the
remaining sum to the binomial expansion of $[t+(1-t)]^{d-i}$.

The Bernstein basis functions are nonnegative on $[0,1]$, so nonnegativity of
all $B_k(n)$ implies (1). The converse does not generally hold: a negative
coefficient alone does not refute polynomial nonnegativity.

The reversed shifted-power certificate in [4] also has a Bernstein
interpretation. If $G_{n^{\mathrm{rev}}}(1+z)=\sum_j c_jz^j$ with every
$c_j\ge0$, then

$$
G_n(t)=\sum_j c_jt^{L-j}(1-t)^j.
$$

Its degree-$L$ Bernstein coefficients are consequently already nonnegative.
Multiplication by $[t+(1-t)]^{d-L}$ preserves that nonnegativity upon elevation
to degree $d$. Thus coefficient nonnegativity for $m\le18$ is not a new
conclusion of this manuscript; the new finite range is $19\le m\le64$.
The structural change here is the uniform choice of degree $m-1$ and exact
optimization over every composition, avoiding exponential enumeration.

**Theorem 2 (exact optimization over every composition).** Given an integer
$m\ge2$, the values

$$
\beta_{m,k}=\min_{\substack{n_i\in\mathbb Z_{\ge1}\\\sum n_i=m}} B_k(n),
\qquad 0\le k\le m-1,
$$

can all be computed in $O(m^5)$ arbitrary-precision integer arithmetic
operations. Each result is accompanied by an ordered composition attaining
the minimum. The working value arrays have $O(m^2)$ entries; retaining all
backtracking decisions uses $O(m^3)$ entries. Operands have $O(m\log m)$ bits,
so the algorithm also has polynomial bit complexity in the numerical
parameter $m$. No polynomial-time claim is made in the binary input length
$\log m$.

### 4.1 Local weights and invisible tails

Fix $m,k$. Let $W_i=\binom ki/\binom{m-1}i$ for $i\le k$, and $W_i=0$
otherwise. Rearranging (3) gives

$$
B_k(n)=\frac{m-1}{m}\sum_i n_iW_i
-\sum_i\frac{n_i n_{i+1}}{n_i+n_{i+1}}(W_i+W_{i+1}). \tag{4}
$$

Only the vertices at indices $0,\ldots,k$ and the edges through the edge to
index $k+1$ are visible. For a longer composition, replace all mass at indices
$k+1$ and beyond by its sum at index $k+1$. The vertex contribution is
unchanged, while the harmonic factor of the last visible edge increases or
stays fixed: for fixed $a>0$, $ab/(a+b)$ increases with $b$. Thus this
operation cannot increase $B_k$. A global minimum is consequently attained
with at most $k+2$ layers.

A state with fixed tail mass $s$ and fixed first entry $a$ must nevertheless
allow a deeper invisible tail. It cannot always be interpreted as a single
compressed layer, because compression would change its prescribed first
entry. Only when the preceding state minimizes over that entry can it choose
the compressed value $a=s$. The zero boundary below is defined for all
invisible tails, with their first entry held fixed.

### 4.2 Bellman recurrence and completeness

Let $V_i(s,a)$ be the minimum remaining contribution of a tail starting at
index $i$, with total mass $s$ and first entry $a$. Every fully invisible
state has $V_{k+1}(s,a)=0$. For $i\le k$,

$$
V_i(a,a)=\frac{m-1}{m}W_i a, \tag{5}
$$

$$
\begin{aligned}
V_i(s,a)&=\frac{m-1}{m}W_i a\\
&\quad+\min_{1\le b\le s-a}
\left\{-\frac{ab}{a+b}(W_i+W_{i+1})
+V_{i+1}(s-a,b)\right\},\quad s>a. \tag{6}
\end{aligned}
$$

The answer is $\beta_{m,k}=\min_{1\le a\le m}V_0(m,a)$.
Every tail of more than one layer has a unique second entry $b$ and a
remaining tail, so it appears in one branch of (6). Conversely, every legal
transition joins a positive integer first entry to a positive integer tail,
producing a valid composition. Termination at (5) or at the invisible boundary
covers all lengths. Backward induction therefore proves that the recurrence
computes the true minimum. It does not relax the integer domain to real
multiplicities.

At index $i$, at least $i$ units have already been used, so every reachable
state satisfies $s\le m-i$. The implementation retains all states in this
envelope; it may include unreachable states but omits no reachable state.
For one coefficient, the actual number of candidate second entries is

$$
T(m,k)=\binom{m+2}{4}-\binom{m-k+1}{4}, \tag{7}
$$

with a binomial coefficient defined as zero if its upper index is smaller
than its lower index. This follows by summing the per-layer count
$\binom{m-i+1}{3}$. Summing over every $k$ at fixed $m$ gives

$$
2\binom{m+2}{4}+4\binom{m+2}{5}=O(m^5).
$$

### 4.3 Integer scaling without floating-point decisions

Choose $C=\operatorname{lcm}(1,\ldots,m)$ and $A=(m-1)!$, and multiply the
objective by $mCA$. The scaled weights

$$
A W_i=(k)_i(m-1-i)!
$$

are integers for $0\le i\le k$, with the later weights defined to be zero,
where $(k)_i=k(k-1)\cdots(k-i+1)$. The scaled vertex cost is
$(m-1)Ca(AW_i)$, and the magnitude of a scaled edge cost is

$$
mab\frac{C}{a+b}(AW_i+AW_{i+1}).
$$

Since $a+b\le m$, every division is exact. Minima are compared entirely using
integers. Both $A$ and $C$ have $O(m\log m)$ bits; the remaining products and
sums of at most $m$ terms do not change this order. Fractions are reduced only
when producing the output.

## 5. Three boundary coefficients in every dimension

The left coefficient is an elementary endpoint calculation. The identity for
$B_d=G(1)$ coincides with the $t=1$ identity in the concurrent case [5].
We include both to make the theorem and its equality cases self-contained;
the new analytic argument emphasized here is the integer-height proof for
$B_{m-2}$ below.

**Theorem 3.** For every integer $m\ge2$ and every positive integer ordered
composition,

$$
B_0\ge0,\qquad B_{m-2}\ge0,\qquad B_{m-1}\ge0.
$$

The equality $B_0=0$ holds exactly for the composition $(1,m-1)$.
Either of the last two coefficients is zero exactly for the all-ones
composition. Some coefficients coincide when $m=2$, and the statements agree
in that case.

The one-layer composition $(m)$ gives the constant polynomial $G=m-1>0$.
Assume $L\ge1$ below.

### 5.1 Left and right endpoints

Let $a=n_0,b=n_1$. Then

$$
B_0=\frac{a^2}{a+b}-\frac am
=\frac{a(ma-a-b)}{m(a+b)}\ge0.
$$

Because $a\ge1$ and $m\ge a+b$, equality requires and is implied by
$a=1$ and $m=a+b$.

At the other endpoint,

$$
B_d=G(1)=\frac{n_0+n_L-2}{2}
+\frac12\sum_{i=0}^{L-1}
\frac{(n_i-n_{i+1})^2}{n_i+n_{i+1}}\ge0.
$$

Equality requires both endpoints to equal one and all neighboring
multiplicities to agree. This is exactly the all-ones composition.

### 5.2 The penultimate coefficient: integer height layers

Put $u_i=n_i-1$ and $U=\sum_i u_i=m-L-1$, and write

$$
e_i=\frac{(n_i-n_{i+1})^2}{n_i+n_{i+1}}.
$$

The relevant weights are $W_i=(d-i)/d$. Direct expansion of
$d B_{d-1}=dG(1)-G'(1)$ yields

$$
\begin{aligned}
d B_{d-1}={}&A_{\mathrm l}u_0+A_{\mathrm r}u_L
+\sum_{i=0}^{L-1}A_i e_i\\
&+\frac1m\sum_{i=0}^L\left(i-\frac L2\right)u_i, \tag{8}
\end{aligned}
$$

$$
A_{\mathrm l}=\frac{2m-1}{4},\qquad
A_{\mathrm r}=\frac{2U-1}{4},\qquad
A_i=\frac{2m-2i-3}{4}.
$$

For example, the expansion can be checked using

$$
D'(1)=-\frac{n_0}{4}+\frac{(2L+1)n_L}{4}
+\frac14\sum_i(2i+1)e_i
$$

together with $G=D-S/m$ and the endpoint identity above.
If $U=0$, every multiplicity equals one and (8) is zero. Suppose $U\ge1$;
then all the displayed $A$ coefficients are positive.

For integers $a>b\ge1$, write $h=a-b$. We have

$$
\sum_{j=b}^{a-1}\frac1{2j+1}
\le\frac h{2b+1}
\le\frac{h^2}{2b+h}
=\frac{(a-b)^2}{a+b}. \tag{9}
$$

The second inequality is equivalent to $2b(h-1)\ge0$. Thus an edge energy
$e_i$ is at least the sum of $1/(2j+1)$ over the integer height levels crossed
between $u_i$ and $u_{i+1}$. More explicitly, if the neighboring original
multiplicities are $b<a$, the crossed indicators
$\mathbf1_{\{u_i\ge j\}}$ have $j=b,\ldots,a-1$, so no index shift is
needed in (9).

Decompose each $u_i$ into its indicators $\mathbf1_{\{u_i\ge j\}}$, and
split the support of each height layer into consecutive intervals $[a,b]$.
Let $\ell=b-a+1$. Every such interval satisfies $U\ge j\ell$. Substituting
(9) into (8) and retaining the endpoint and linear moment terms gives a lower
bound equal to the sum of contributions from these intervals.

First consider intervals touching an endpoint. If $a=0,b<L$, the magnitude
of any negative moment contribution is at most
$\ell L/(2m)\le L/2$. The left endpoint contribution
$A_{\mathrm l}>L/2$ strictly covers it, and the boundary energy is positive.
If $a>0,b=L$, the moment is $\ell a/(2m)\ge0$, while the endpoint and
boundary-energy contributions are positive. If $[a,b]=[0,L]$, the moment
is zero and the endpoint contributions are positive.

It remains to consider an interior interval $1\le a\le b\le L-1$.
Its two boundary edges and its moment contribute

$$
\mathcal C=
\frac{m-1-(a+b)/2}{2j+1}
+\frac{\ell(a+b-L)}{2m}. \tag{10}
$$

If $a+b\ge L$, both terms are nonnegative and the first is positive.
Otherwise,

$$
\mathcal C\ge\frac{L/2+U}{2j+1}-\frac{\ell L}{2m}\ge0.
$$

The final step follows from $\ell\le L$ and $U\ge j\ell$, which imply

$$
(2j+1)\ell\le2U+L,
\qquad
(2j+1)\ell L\le(2U+L)m.
$$

When $a+b<L$, replacing the numerator of the first term in (10) by
$L/2+U$ is actually strict. The other interval cases already contain a
strictly positive contribution. Whenever $U>0$, at least one nonempty height
interval exists, so the total lower bound is strictly positive. Consequently
$B_{d-1}\ge0$, with equality exactly for the all-ones composition.
The proof explicitly uses integer heights and does not extend to arbitrary
real multiplicities.

## 6. Complete finite certificate and completion of the physical theorem

The main program computes the exact global minimum for every $2\le m\le64$
and every $0\le k\le m-1$. There are

$$
\sum_{m=2}^{64}m=2079
$$

entries, all nonnegative. The dynamic program counts

$$
2\binom{67}{5}+4\binom{67}{6}=418\,498\,080
$$

candidate transitions. The computation implicitly covers
$\sum_{m=2}^{64}2^{m-1}=2^{64}-2$ ordered compositions. It does not enumerate
these compositions individually and does not sample temperatures.

| $m$ | $k$ | $\beta_{m,k}$ | One minimizing composition |
|---:|---:|---:|:---|
| 12 | 1 | $353/2420$ | $(1,4,7)$ |
| 12 | 6 | $39/154$ | $(1,2,3,3,2,1)$ |
| 19 | 1 | $401/3078$ | $(1,5,13)$ |
| 19 | 9 | $85437/293930$ | $(1,2,3,4,4,3,2)$ |
| 35 | 1 | $1366/13005$ | $(1,8,26)$ |

The independent implementation takes a different approach: a forward dynamic
program in C++/GMP, retaining all lengths $1,\ldots,m$, without compressing
invisible tails, and scaling by a least common multiple of Pascal binomial
denominators. Its 483,223,104 transitions produce all 2,079 rational minima
identically to the main program, entry by entry. A further exhaustive check
through $m=12$ directly converts power coefficients to Bernstein coefficients
for all 4,094 compositions and also agrees throughout.

A minimizing composition proves only an upper bound on the minimum.
The result table or substitution of witnesses alone cannot establish the
absence of a smaller value. Here the lower bounds are supported by the
proved completeness of the Bellman recurrence and the independent full-domain
recomputation. The complete code, results, counts, and review records accompany
the manuscript.

Nonnegativity of every coefficient and (2) imply $G_n(t)\ge0$ throughout the
closed interval $[0,1]$. Section 3 then yields Theorem 1. The endpoint $t=0$
belongs to the polynomial verification domain; it does not add zero reference
probabilities to the physical statement.

To prove strictness within the certified range, take $3\le m\le64$ and $0<t<1$.
If $B_0>0$, the zeroth term of (2) is already strictly positive. If $B_0=0$,
Theorem 3 forces the composition $(1,m-1)$, and direct substitution gives

$$
G_n(t)=\frac{(m-1)(m-2)}{m}t>0.
$$

Every connected component of dimension at least three therefore has a strict
capacity bound in this parameter interval. A component of dimension two has
the smaller factor $1/2<1-1/m$ when the global dimension is at least three.
Combining components proves global strictness whenever $E>0$.
This conclusion does not assert that we have found the optimal constant at a
fixed nonuniform system probability vector.

## 7. An exact counterexample to continuous multiplicities

A natural but invalid approach is to allow real $n_i\ge1$ first and attempt
to prove $mD/S\ge1$ on that larger domain. This stronger statement fails
even if the total $m$ is additionally required to be an integer.

**Proposition 4.** Let $L=150$ and

$$
n_i=1+\frac{\max\{0,i-75\}(150-i)}{70300},
\qquad r=\frac{45001}{44998}.
$$

Then $n_i\ge1$, $n_0=n_{150}=1$, and

$$
m=\sum_{i=0}^{150}n_i
=151+\frac{\sum_{j=0}^{75}j(75-j)}{70300}=152.
$$

For $S,D$ as defined in Section 3, exact rational evaluation gives

$$
-\frac{1093803967}{10^{15}}
<\frac{mD(r)}{S(r)}-1
<-\frac{1093803966}{10^{15}}<0. \tag{11}
$$

The script constructs the rational quantities directly from their
definitions and verifies both strict comparisons by exact cross
multiplication. Decimal rounding does not decide the sign. It additionally
checks the identity

$$
(1+r)D(r)=rn_0+r^Ln_L
+\sum_{i=0}^{L-1}r^i
\frac{(n_i-rn_{i+1})^2}{n_i+n_{i+1}}. \tag{12}
$$

This is a counterexample to the real relaxation, **not a counterexample with
physical level multiplicities**. For example,
$n_{76}=1+74/70300$ is nonintegral. Retaining only an integer total dimension
is insufficient; a general proof must use or preserve the integrality of
each multiplicity.

Another excluded approach replaces every denominator $n_i+n_{i+1}$ in (12)
by $m$. This produces an overly strong sufficient condition. It fails
strictly for the composition consisting of 16 ones, followed by $(2,3)$,
then 10 fours, and finally $(3,2,1)$, with $m=67$ and $r=51/50$.
The original quantity $mD/S$ is still greater than one in that example.
The failed approach and its exact rational check are archived to prevent its
reuse as an invalid intermediate lemma in a general proof.

## 8. Significance, literature comparison, and remaining questions

Physically, the result independently verifies an existing local dissipation
benchmark without fixing a particular machine spectrum or sampling
temperatures. Computationally, the local coupling of neighboring
multiplicities turns a certificate search over exponentially many compositions
into a calculation polynomial in dimension. Analytically, the integer-height
decomposition controls a coefficient containing a negative linear moment
term. The continuous counterexample shows why integrality cannot be discarded
without justification.

The related works address distinct questions. Reference [1] supplies the
original problem, local model, and coherent reduction. Reference [2,
Supplement II.C, Eqs. (S32)–(S38)] gives a specific higher-dimensional machine
construction. Reference [3] optimizes a closure infimum with an unbounded
number of collisions under an auxiliary spectral-ratio constraint.
Reference [5] already covers the non-strict physical statement of Theorem 1;
we retain no claim of physical priority for it. Exact all-composition
Bernstein minimization, the full coefficient certificate at fixed degree,
the penultimate-coefficient proof, and the continuous-multiplicity
counterexample remain distinct from the results checked in these sources.
Our literature assessment is limited to the listed primary sources and
related manuscripts; it is not a proof of global priority or an external
assessment of academic value.

The remaining stronger algebraic conjecture asks whether $B_k\ge0$ for every
integer $m$, every composition, and every $k$. Our general analytic proof
covers only $k=0,m-2,m-1$. The weaker scalar statement $G_n(t)\ge0$ has been
proved in [5]; finding a negative intermediate Bernstein coefficient would
therefore refute only the stronger certificate conjecture. A useful next
step would be to construct an inductive symbolic lower bound for the Bellman
recurrence, or extend the height-layer argument to the nonlinear binomial
weights. Increasing the finite cutoff alone cannot become an arbitrary-
dimension proof of full coefficient nonnegativity.

## 9. Reproduction and verification boundaries

The main algorithm uses only the Python standard library; the independent implementation uses C++17 and GMP. The 2,079-entry table, independent comparison, counterexample checks and computation files are not included in this edition. The contribution is the separately scoped algorithm, finite coefficient theorem and accompanying propositions. No external peer review or Lean verification is claimed.

## References

1. A. Mishra and A. Senthilkumar. *Finite-resource cooling of qudits beyond
   thermodynamic length*. arXiv:2610.40709v1 (2026).
   [Primary source](https://arxiv.org/html/2610.40709v1).
   Theorems 1–2; Supplements S10–S11.
2. P. Taranto et al. *Efficiently Cooling Quantum Systems with Finite
   Resources: Insights from Thermodynamic Geometry*. Physical Review Letters
   **134**, 070401 (2025).
   [Supplement](https://journals.aps.org/prl/supplemental/10.1103/PhysRevLett.134.070401/SM.pdf),
   Section II.C, Eqs. (S32)–(S38).
3. A. Mishra and A. Senthilkumar. *The Cost of Quantum State Conversion*.
   arXiv:2611.19725v1 (2026).
   [Primary source](https://arxiv.org/pdf/2611.19725v1).
   Sections II–III and VII.D; Appendices B and F.
4. Research manuscript: *双能级系统的热机器壳容量界*
   (Shell-capacity bound for a two-level system), 24 November 2026.
   The present work retains its shell-capacity reduction and adds the
   certificate, algorithm, analytic coefficients, and counterexamples.
   The earlier finite proof covers $2\le m\le18$.
5. Related research manuscript: *任意维热机器下双能级系统的二阶耗散下界*
   (Quadratic dissipation bound for a two-level system with an arbitrary-
   dimensional thermal machine), 24 November 2026.
   [Chinese manuscript](../qubit-cooling-arbitrary-machine/paper.zh.md).
   Its full scalar proof and finite-prefix certificates differ from the
   all-composition coefficient optimization developed here.
