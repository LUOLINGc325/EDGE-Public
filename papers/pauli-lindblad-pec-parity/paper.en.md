# Parity criteria and cost asymptotics for Pauli–Lindblad error cancellation

**Research manuscript · 24 November 2026**

## Abstract

Probabilistic error cancellation of a Pauli–Lindblad channel is commonly
implemented by sampling the inverse of each generator separately. The resulting
coefficient cost is multiplicative, whereas combining corrections can reduce
it. We characterize this distinction for arbitrary finite sets of active Pauli
generators. The factorized cost is optimal among all exact real decompositions
into completely positive trace-preserving maps if and only if every binary
dependence among the generator labels has even cardinality. Equivalently, one
Pauli observable anticommutes with every active generator. When an odd
dependence exists, the improvement is strict at every positive noise strength.
If the shortest odd dependence has size $2h-1$, the first saving occurs at
order $t^h$; we identify its exact coefficient without overcounting overlapping
dependences. A finite Fourier representation gives matching exponential bounds
in the strong-noise limit and an explicit leading coefficient. For correlated
$Z_uZ_v$ dephasing on a graph, factorized optimality is equivalent to
bipartiteness, and the optimal strong-noise exponent is twice the weighted
maximum cut. A finite rational-parameter reduction establishes NP-hardness of
approximating the coefficient cost within a factor of two for succinctly
specified channels. Odd-circuit formulas provide constructive reductions on
small generator blocks. The analysis concerns exact channel simulation with
known rates and ideal correction channels.

**Status.** Independently reviewed written research manuscript. The independent
review was conducted within the research workflow. Current Lean formalization
covers finite weighted fibers and binary parity; it does not cover the full
quantum-channel bridge, asymptotics, graph statements or complexity reduction.

## 1. Introduction

The cost of probabilistic error cancellation (PEC) depends on a signed
decomposition of the inverse noise map. For an exactly specified
Pauli–Lindblad channel, an elementary decomposition is available for each
generator. Multiplying their coefficient one-norms yields an explicit cost
that can be sampled without constructing a full inverse-channel expansion.
The sparse-noise framework of van den Berg et al. [2] makes this construction
relevant to correlated noise on quantum processors.

There are two established facts behind the present question. First,
Jiang, Wang and Wang [1, Theorem 13] show that a real combination of mutually
orthogonal unitary channels has optimal CPTP decomposition cost equal to its
coefficient one-norm. Second, combining inverse factors can merge equal Pauli
corrections with opposite signs. Jin et al. [3, discussion following Eq. (22)]
distinguish combined inversion from separate elementary inversions and note
their potential cost difference. Scheiber, Haubenwallner and Heller [4]
develop Pauli propagation and combination methods that exploit this
cancellation, including subgroup-based examples. Thus neither the
coefficient-one-norm reduction nor the combination mechanism is a new claim
of this paper.

We study the structural question that remains after these reductions: exactly
which generator families admit a saving, at what order does it first appear,
and which combinatorial quantity governs its strong-noise growth? The answer
is controlled by binary dependences among Pauli labels. A dependence of odd
cardinality creates opposite signs in a common coefficient fiber. This gives
an exact equality criterion, a polynomial-time certificate and a quantitative
weak-noise expansion. The Fourier description of the same coefficients gives
a complementary strong-noise law. For graph-correlated dephasing, these two
descriptions become odd-cycle and maximum-cut statements.

Throughout, the cost is the minimum coefficient one-norm of an exact,
state-independent and observable-independent real decomposition into CPTP
maps. Its square is the standard bounded-outcome PEC sampling-overhead
factor. This quantity is not the sample complexity of unrestricted error
mitigation. The noise rates are known exactly, and the correction channels
are ideal. We work with the specified positive-rate Pauli–Lindblad semigroup;
no claim is made that every Pauli channel admits such a representation.

## 2. Model and the established channel-cost reduction

### 2.1. Pauli labels and inverse coefficients

Consider $n\geq1$ qubits and let $\mathsf W=\mathbb F_2^{2n}$ be their Pauli
label space modulo scalar phases. Choose a Hermitian unitary representative $P_a$ of
each label $a\in\mathsf W$ and write

$$
\mathcal P_a(X)=P_aXP_a^\dagger.
$$

Pauli representatives may anticommute, but their conjugation channels satisfy

$$
\mathcal P_a\mathcal P_b=\mathcal P_{a+b},
\qquad \mathcal P_a^2=\mathcal I.
\tag{2.1}
$$

Let $a_1,\ldots,a_m$ be nonzero labels with rates $w_j>0$. Zero-rate terms
are removed and identity terms discarded. Repeated labels may be combined by
adding rates, although the results do not require this preprocessing. Define

$$
\mathcal L=\sum_{j=1}^m w_j(\mathcal P_{a_j}-\mathcal I),
\qquad \mathcal N_t=e^{t\mathcal L},
\qquad \Lambda=\sum_{j=1}^m w_j,
\qquad t\geq0.
\tag{2.2}
$$

The empty family is permitted, with $\mathcal N_t=\mathcal I$. Let

$$
V=\operatorname{span}_{\mathbb F_2}\{a_1,\ldots,a_m\},
\qquad r=\dim V,
\qquad A:\mathbb F_2^m\longrightarrow V,
\quad A(s)=\sum_j s_ja_j.
\tag{2.3}
$$

For $S\subseteq[m]$, write $a(S)=\sum_{j\in S}a_j$ and
$w(S)=\prod_{j\in S}w_j$, with $w(\varnothing)=1$.

Since each $\mathcal P_{a_j}$ is an involution,

$$
e^{-tw_j(\mathcal P_{a_j}-\mathcal I)}
=\alpha_j(t)\mathcal I-\beta_j(t)\mathcal P_{a_j},
\quad
\alpha_j(t)=\frac{1+e^{2tw_j}}2,
\quad
\beta_j(t)=\frac{e^{2tw_j}-1}2.
\tag{2.4}
$$

Both sides act by $1$ and $e^{2tw_j}$ on the $+1$ and $-1$ eigenspaces of
the involution, respectively. The corresponding forward factor is a convex
combination with coefficients $(1\pm e^{-2tw_j})/2$, so $\mathcal N_t$ is
CPTP. Expanding the commuting inverse factors yields

$$
\mathcal N_t^{-1}
=\sum_{S\subseteq[m]}(-1)^{|S|}B_S(t)\mathcal P_{a(S)},
\qquad
B_S(t)=\prod_{j\notin S}\alpha_j(t)
       \prod_{j\in S}\beta_j(t).
\tag{2.5}
$$

For $t>0$, every $B_S(t)$ is strictly positive. Separate the even and odd
representations of a label $g\in V$:

$$
E_g(t)=\sum_{\substack{a(S)=g\\ |S|\ {\rm even}}}B_S(t),
\qquad
O_g(t)=\sum_{\substack{a(S)=g\\ |S|\ {\rm odd}}}B_S(t),
\qquad q_g(t)=E_g(t)-O_g(t).
\tag{2.6}
$$

The combined inverse is $\mathcal N_t^{-1}=\sum_gq_g(t)\mathcal P_g$.

### 2.2. Optimal cost and the cancellation identity

Define

$$
\Gamma(t)=\inf\left\{
\sum_k|c_k|:
\mathcal N_t^{-1}=\sum_kc_k\mathcal C_k,
\quad c_k\in\mathbb R,
\quad \mathcal C_k\ {\rm CPTP}
\right\},
\tag{2.7}
$$

where the decompositions are finite. Trace preservation forces
$\sum_kc_k=1$.

**Lemma 2.1 (orthogonal-unitary cost [1, Theorem 13]).**
For the channel in (2.2),

$$
\Gamma(t)=\sum_{g\in V}|q_g(t)|.
\tag{2.8}
$$

**Proof.** We include the specialization to fix the Choi normalization. Put
$d=2^n$ and $|\Omega\rangle=d^{-1/2}\sum_x|x,x\rangle$. The normalized
Choi operator of the inverse map is

$$
J(\mathcal N_t^{-1})
=\sum_gq_g(t)|\Omega_g\rangle\langle\Omega_g|,
\qquad |\Omega_g\rangle=(I\otimes P_g)|\Omega\rangle.
$$

The vectors $|\Omega_g\rangle$ are orthonormal. Hence the trace norm of this
operator is $\sum_g|q_g(t)|$. The normalized Choi operator of a CPTP map
is positive and has trace one. The trace-norm triangle inequality therefore
bounds the cost of every decomposition in (2.7) below by this sum. The
combined Pauli decomposition attains the bound. $\square$

Sampling all elementary inverse factors separately gives

$$
\Gamma_{\mathrm{fac}}(t)
=\prod_j(\alpha_j(t)+\beta_j(t))
=e^{2t\Lambda}
=\sum_g(E_g(t)+O_g(t)).
\tag{2.9}
$$

Since $x+y-|x-y|=2\min\{x,y\}$ for nonnegative $x,y$, we obtain the
exact identity

$$
\boxed{\Gamma_{\mathrm{fac}}(t)-\Gamma(t)
=2\sum_{g\in V}\min\{E_g(t),O_g(t)\}.}
\tag{2.10}
$$

## 3. A parity criterion for factorized optimality

Let $\pi:\mathbb F_2^m\to\mathbb F_2$ be the parity functional
$\pi(s)=\sum_js_j$.

**Theorem 3.1 (equality and strictness).**
The following conditions are equivalent:

1. $\Gamma(t)=\Gamma_{\mathrm{fac}}(t)$ for at least one $t>0$.
2. $\Gamma(t)=\Gamma_{\mathrm{fac}}(t)$ for every $t>0$.
3. $\ker A\subseteq\ker\pi$; every binary dependence among active labels
   has even cardinality.
4. There is a linear functional $\ell:V\to\mathbb F_2$ satisfying
   $\ell(a_j)=1$ for every $j$.
5. There is an $n$-qubit Pauli observable $Q$ that anticommutes with every
   active $P_{a_j}$.

If these conditions fail, then $\Gamma(t)<\Gamma_{\mathrm{fac}}(t)$ for
every $t>0$.

**Proof.** Fix $t>0$. By (2.10) and positivity of all subset weights,
equality holds exactly when no label has both an even and an odd representing
subset. Two subsets $S,T$ represent the same label with different parity
exactly when $S\mathbin{\triangle}T$ is an odd dependence. Therefore
condition 3 implies that each fiber has a single parity. Conversely, an odd
dependence $D$ shares its zero label with $\varnothing$; both $E_0(t)$ and
$O_0(t)$ are then positive, giving a strict gap in (2.10). This proves the
equivalence of conditions 1–3 and strictness at every positive time.

Under condition 3, define $\ell(A(s))=\pi(s)$. The kernel inclusion makes
this well-defined, and it is linear with $\ell(a_j)=1$. Conversely, such a
functional gives $\pi=\ell\circ A$, proving the kernel inclusion.

Extend $\ell$ from $V$ to $\mathsf W$ by completing a basis. The
nondegenerate symplectic form on $\mathsf W$ represents this extension as
$a\mapsto[b,a]$ for some $b\in\mathsf W$. The Pauli observable $P_b$
anticommutes with $P_{a_j}$ precisely when $[b,a_j]=1$. This proves the
equivalence of conditions 4 and 5. $\square$

The witness in condition 5 is a maximally damped Pauli mode:

$$
\mathcal N_t(Q)=e^{-2t\Lambda}Q,
\qquad
\mathcal N_t^{-1}(Q)=e^{2t\Lambda}Q.
\tag{3.1}
$$

Solving the binary linear system $\ell(a_j)=1$ either constructs this
witness or returns an odd dependence. This is a polynomial-time test in
$n$ and $m$ and does not expand the $2^m$ subsets in (2.5).

The theorem uses labels modulo scalar phase. Commutativity of the Pauli
representatives is unnecessary because their conjugation channels obey
(2.1). The restriction $t>0$ is essential: at $t=0$, both costs equal one
for every family.

## 4. The first weak-noise saving

Assume an odd dependence exists. Let

$$
g_*=\min\{|D|:a(D)=0,\ |D|\ {\rm odd}\}=2h-1.
\tag{4.1}
$$

The nonzero-label assumption gives $g_*\geq3$. For
$\varepsilon\in\{0,1\}$ and $g\in V$, define

$$
d_\varepsilon(g)
=\min\{|S|:a(S)=g,\ |S|\equiv\varepsilon\pmod2\}.
\tag{4.2}
$$

Both minima are finite: toggling a representing subset by an odd dependence
changes its parity without changing its label. Define a set of subsets,
without multiplicities,

$$
\mathcal H=
\left\{S\subseteq[m]:|S|=h,\quad
\exists T\subseteq[m],\ |T|=h-1,\ a(T)=a(S)\right\}.
\tag{4.3}
$$

**Theorem 4.1 (order and exact leading coefficient).**
With the finite generator family and its positive rates fixed,

$$
\boxed{\Gamma_{\mathrm{fac}}(t)-\Gamma(t)
=2t^h\sum_{S\in\mathcal H}\prod_{j\in S}w_j
 +O(t^{h+1})\qquad(t\downarrow0).}
\tag{4.4}
$$

The leading coefficient is positive.

**Proof.** Each subset weight has the expansion

$$
B_S(t)=t^{|S|}w(S)+O(t^{|S|+1}).
\tag{4.5}
$$

Consequently, with $F_0=E$ and $F_1=O$,

$$
F_\varepsilon(g,t)
=t^{d_\varepsilon(g)}
\sum_{\substack{a(S)=g\\|S|=d_\varepsilon(g)}}w(S)
+O(t^{d_\varepsilon(g)+1}).
\tag{4.6}
$$

The two minimum degrees have different parity and are therefore unequal.
For small positive $t$, the smaller fiber sum is the one with the larger
minimum degree. If $S_0,S_1$ attain the two minima, their symmetric
difference is an odd dependence. Thus

$$
d_0(g)+d_1(g)\geq|S_0\mathbin{\triangle}S_1|
\geq g_*=2h-1.
\tag{4.7}
$$

It follows that $\max\{d_0(g),d_1(g)\}\geq h$. Equality forces the
unordered pair of degrees to be $\{h-1,h\}$. Such a fiber contributes at
order $t^h$ exactly the total weight of its $h$-element representations.
Every other fiber contributes $O(t^{h+1})$.

An $h$-element subset lies in one of the contributing fibers exactly when it
belongs to $\mathcal H$. Indeed, an $(h-1)$-element partner bounds the two
degrees above by $h$ and $h-1$, and (4.7) forces these bounds to be attained.
Summing the fiber contributions in (2.10) therefore counts each member of
$\mathcal H$ once and gives (4.4).

Finally, partition a shortest odd dependence $D$ into $S,T$ of sizes $h$
and $h-1$. Their labels coincide, so $S\in\mathcal H$. Positivity of
all rates proves positivity of the coefficient. $\square$

The first saving thus occurs at order $(g_*+1)/2$. Counting shortest odd
dependences independently can give the wrong coefficient, because an
$h$-subset may have several partners. The subset set (4.3), or equivalently
the fiber decomposition, removes this multiplicity.

A shortest odd dependence is also a binary circuit: a proper odd dependence
would contradict minimality, while removing a proper even dependence would
leave a smaller odd one. This connects Theorem 4.1 to the explicit circuit
formulas in Section 8.

## 5. Strong-noise bounds and a leading coefficient

Let $V^*$ be the binary dual of $V$. Set

$$
C(\ell)=\sum_jw_j\ell(a_j),
\qquad M=\max_{\ell\in V^*}C(\ell),
\tag{5.1}
$$

where a bit $\ell(a_j)$ is interpreted as the real number zero or one.

**Proposition 5.1 (finite Fourier representation).**

$$
\widehat q_t(\ell)
:=\sum_{g\in V}q_g(t)(-1)^{\ell(g)}
=e^{2tC(\ell)},
\qquad
q_g(t)=2^{-r}\sum_{\ell\in V^*}
(-1)^{\ell(g)}e^{2tC(\ell)}.
\tag{5.2}
$$

**Proof.** Apply the character $g\mapsto(-1)^{\ell(g)}$ to the product
(2.5). Its $j$-th factor evaluates to $\alpha_j-\beta_j=1$ when
$\ell(a_j)=0$, and to $\alpha_j+\beta_j=e^{2tw_j}$ otherwise. Their
product is the first expression in (5.2). Finite-character orthogonality gives
the inversion formula. $\square$

**Theorem 5.2 (sharp exponential rate).**
For every $t\geq0$,

$$
\boxed{e^{2tM}\leq\Gamma(t)
\leq\min\{e^{2t\Lambda},\ 2^{r/2}e^{2tM}\}.}
\tag{5.3}
$$

For each fixed finite model,

$$
\lim_{t\to\infty}\frac{\log\Gamma(t)}{t}=2M,
\qquad
\lim_{t\to\infty}
\frac{\log(\Gamma_{\mathrm{fac}}(t)/\Gamma(t))}{t}
=2(\Lambda-M).
\tag{5.4}
$$

**Proof.** The absolute value of any Fourier coefficient is bounded by
$\sum_g|q_g(t)|$, giving the lower bound. Parseval and Cauchy–Schwarz give

$$
\Gamma(t)^2
\leq 2^r\sum_gq_g(t)^2
=\sum_{\ell\in V^*}e^{4tC(\ell)}
\leq2^re^{4tM}.
$$

The other upper bound follows from (2.10). The logarithmic limits follow with
$r$ fixed. $\square$

All rates are positive, so $M=\Lambda$ exactly when a character takes value
one on every active label. This agrees with Theorem 3.1. The limits in (5.4)
hold for a fixed finite model; they do not interchange large noise strength
with increasing system size.

**Proposition 5.3 (leading coefficient and remainder).**
Let $N=2^r$, $\mathcal B=\{\ell:C(\ell)=M\}$ and $b=|\mathcal B|$.
Define

$$
K=\frac1N\sum_{g\in V}
\left|\sum_{\ell\in\mathcal B}(-1)^{\ell(g)}\right|.
\tag{5.5}
$$

If $\mathcal B\ne V^*$, set
$\Delta=M-\max_{\ell\notin\mathcal B}C(\ell)>0$. Then

$$
\left|e^{-2tM}\Gamma(t)-K\right|
\leq\sqrt{N-b}\,e^{-2t\Delta},
\qquad 1\leq K\leq\sqrt b.
\tag{5.6}
$$

If $\mathcal B=V^*$, the remainder is zero.

**Proof.** After division by $e^{2tM}$, the Fourier vector in (5.2) equals
the indicator of $\mathcal B$ plus a remainder supported on its complement.
The inverse Fourier transform of the indicator has one-norm $K$. Each of the
$N-b$ remaining Fourier coefficients has magnitude at most
$e^{-2t\Delta}$. Parseval and Cauchy–Schwarz bound the one-norm of their
inverse transform by $\sqrt{N-b}e^{-2t\Delta}$. The reverse triangle
inequality proves the error bound. A Fourier coefficient of the indicator
equal to one gives $K\geq1$, and Parseval and Cauchy–Schwarz give
$K\leq\sqrt b$. $\square$

## 6. Correlated dephasing on a graph

Let $G=(U,E)$ be a finite simple graph on $n$ vertices, with positive edge
weights $w_{uv}$. Consider

$$
\mathcal L_G=\sum_{\{u,v\}\in E}w_{uv}
\bigl(\operatorname{Ad}_{Z_uZ_v}-\mathcal I\bigr).
\tag{6.1}
$$

This correlated-dephasing model has binary labels $e_u+e_v$ in the
$Z$-label subspace. It is a specialization of the general generator model.

### 6.1. Bipartiteness and the weak-noise coefficient

**Corollary 6.1.** The factorized cost is optimal for every $t>0$ if and
only if $G$ is bipartite. If $G$ is not bipartite, its shortest odd cycle has
length $g_*=2h-1$, and Theorem 4.1 gives the order and coefficient of the
first saving.

**Proof.** A functional on the edge-label span extends to the vertex-label
space and is represented there by vertex bits $x_u$. It evaluates to one on
$e_u+e_v$ exactly when $x_u\ne x_v$. The witness condition of Theorem 3.1
is therefore precisely a binary proper coloring of the graph.

The kernel of the binary edge-incidence map consists of edge subsets with
even degree at every vertex. Such a subset decomposes into edge-disjoint
cycles. If its cardinality is odd, at least one constituent cycle has odd
length. Conversely, every odd cycle is an odd dependence. Thus the minimum
odd dependence has the length of a shortest odd cycle. $\square$

For graphs containing triangles, formula (4.4) takes the explicit form

$$
\Gamma_{\mathrm{fac}}(t)-\Gamma_G(t)
=2t^2\sum_{\{i,j,k\}\ {\rm triangle}}
\bigl(w_{ij}w_{ik}+w_{ij}w_{jk}+w_{ik}w_{jk}\bigr)+O(t^3).
\tag{6.2}
$$

A pair of distinct edges can have the same binary boundary as a single edge
only if it is a two-edge path completed by that edge to a triangle. The
closing edge is unique in a simple graph. Hence each contributing pair is
counted once. Unit weights give the coefficient six times the triangle count.

An overlap example illustrates why longer odd cycles require the fiber rule.
Take three internally disjoint paths, of lengths $3,2,2$, between common
endpoints. The graph has two five-cycles sharing the length-three path. Each
five-cycle contains ten three-edge subsets, and their shared path is the only
such subset counted twice. Thus $|\mathcal H|=19$ and

$$
\Gamma_{\mathrm{fac}}(t)-\Gamma_G(t)=38t^3+O(t^4).
\tag{6.3}
$$

Adding the two isolated five-cycle coefficients would instead give $40$.

### 6.2. A maximum-cut law

Write $c(G)$ for the number of connected components, including isolated
vertices. Define

$$
\operatorname{mc}_w(G)
=\max_{x\in\{0,1\}^{U}}
\sum_{\{u,v\}\in E}w_{uv}\mathbf1\{x_u\ne x_v\}.
\tag{6.4}
$$

**Corollary 6.2.** The edge-label rank is $r=n-c(G)$, and

$$
e^{2t\operatorname{mc}_w(G)}
\leq\Gamma_G(t)
\leq\min\left\{
e^{2t\sum_ew_e},
2^{(n-c(G))/2}e^{2t\operatorname{mc}_w(G)}\right\}.
\tag{6.5}
$$

Consequently, the strong-noise exponent of $\Gamma_G$ is
$2\operatorname{mc}_w(G)$, and that of the squared sampling-overhead factor
is $4\operatorname{mc}_w(G)$.

**Proof.** On each connected component, spanning-tree edge labels are
independent. A non-tree edge is the sum of the tree-edge labels along its
endpoint path. Hence the component contributes its number of vertices minus
one to the rank, giving $n-c(G)$ overall.

Every functional on the edge-label span extends to the vertex-label space.
Its value on an edge is $x_u+x_v$ in $\mathbb F_2$, so the quantity
$C(\ell)$ in (5.1) is exactly a cut weight. Changing every vertex bit in a
connected component leaves this functional unchanged; these repetitions do
not affect the maximum. Apply Theorem 5.2. $\square$

## 7. Hardness at finite rational channel parameters

The finite Fourier representation evaluates the cost exactly in time
exponential in the label rank. The next result gives a worst-case obstruction
to a general polynomial-time replacement. Its input is the graph and its
elementary channel factors, rather than an exponentially large full channel
matrix.

**Theorem 7.1 (factor-two evaluation).**
Suppose an algorithm in the ordinary finite-bit model takes a simple graph
and rational elementary correlated-$ZZ$ dephasing factors and returns a
rational number $\widehat\Gamma$ satisfying

$$
\Gamma/2\leq\widehat\Gamma\leq2\Gamma
$$

in time polynomial in the succinct input length. Then maximum cut on
unweighted simple graphs can be solved in polynomial time.

**Proof.** Given a graph on $n\geq1$ vertices, put $Q=2^{n+2}$ and use
the same rational noise factor on every edge:

$$
\mathcal D_e
=\frac{1+Q^{-1}}2\mathcal I
 +\frac{1-Q^{-1}}2\operatorname{Ad}_{Z_uZ_v}.
\tag{7.1}
$$

This is the unit-rate model at $t=(\log Q)/2$. The input contains only
rational coefficients: the binary length of $Q$ is $n+3$. Let
$k=\operatorname{mc}(G)\in\mathbb Z$. Corollary 6.2 gives

$$
Q^k\leq\Gamma\leq2^{r/2}Q^k.
$$

The approximate output consequently satisfies

$$
Q^k\leq2\widehat\Gamma
\leq4\Gamma
\leq4\,2^{r/2}Q^k
<Q^{k+1},
\tag{7.2}
$$

because $r\leq n$ and $4\,2^{n/2}<2^{n+2}=Q$ for $n>0$. Thus $k$
is the unique integer with $Q^k\leq2\widehat\Gamma<Q^{k+1}$. It can be
recovered by rational comparisons and binary search among
$0,\ldots,|E|$; no transcendental logarithm is evaluated. The comparison
integers have polynomial bit length. Hence the hypothesized algorithm solves
unweighted maximum cut. $\square$

Simple Max Cut is NP-complete by Garey, Johnson and Stockmeyer [5], giving
the stated NP-hardness consequence. The reduction uses strongly damped
channels with succinct rational descriptions. It establishes no hardness
claim at a fixed weak per-edge noise rate.

## 8. Odd circuits and constructive block reductions

Suppose $D$ is a binary circuit of $k$ generators: its only nonempty
dependence is $D$ itself. Subsets of $D$ share a label exactly when they are
equal or complementary. Write $B_S^{D}(t)$ for the product in (2.5)
restricted to indices in $D$, and let $\Gamma_D$ and
$\Gamma_{\mathrm{fac},D}$ be the associated block costs.

If $k$ is even, complementary subsets have the same sign, so
$\Gamma_D=\Gamma_{\mathrm{fac},D}$. If $k$ is odd, their signs differ
and

$$
\Gamma_D(t)
=\frac12\sum_{S\subseteq D}
\left|B_S^{D}(t)-B_{D\setminus S}^{D}(t)\right|.
\tag{8.1}
$$

Set

$$
p_j=\frac{\beta_j(t)}{\alpha_j(t)+\beta_j(t)}
=\frac{1-e^{-2tw_j}}2.
$$

Let $\mu$ be the product Bernoulli distribution with inclusion probabilities
$p_j$, and let $\mu^c(S)=\mu(D\setminus S)$. Dividing (8.1) by
$\Gamma_{\mathrm{fac},D}$ gives the exact total-variation expression

$$
\frac{\Gamma_D(t)}{\Gamma_{\mathrm{fac},D}(t)}
=\frac12\sum_{S\subseteq D}|\mu(S)-\mu^c(S)|
=\operatorname{TV}(\mu,\mu^c).
\tag{8.2}
$$

For equal rates $w_j=w$ and $k=2h-1$, put $p=(1-e^{-2tw})/2$. Then

$$
\Gamma_D(t)=e^{2tkw}
\left[1-2\sum_{j=h}^{k}\binom{k}{j}p^j(1-p)^{k-j}\right].
\tag{8.3}
$$

For $t>0$, the likelihood ratio $\mu(S)/\mu^c(S)$ exceeds one exactly
when $|S|<k/2$. The positive and negative halves are complementary, giving
the difference between the lower and upper binomial probabilities. At $t=0$,
(8.3) follows directly with $p=0$. For
$k=3$ and $w=1$,

$$
\Gamma_D(t)=\frac{3e^{4t}-1}{2},
\qquad \Gamma_{\mathrm{fac},D}(t)=e^{6t}.
\tag{8.4}
$$

This three-generator algebra also occurs in depolarizing inversion and the
$X,Y,Z$ combination discussed in [4]. Equation (8.4) is used here as a
consistency check.

For a general generator family, partition its indices into blocks and combine
coefficients within each block. Composing their minimizing Pauli
decompositions produces a valid construction with product cost before any
further cancellation. Therefore

$$
\Gamma(t)\leq\prod_{D\ {\rm block}}\Gamma_D(t).
\tag{8.5}
$$

Choosing disjoint short odd circuits gives an explicit certified reduction
without constructing the full global expansion. A $k$-generator circuit has
$2^{k-1}$ labels, so the construction is efficient only for small blocks or
with additional exploitable structure. It does not imply an efficient optimal
sampler for arbitrary large-rank instances.

## Verification and formalization scope

The accompanying exact certificate compares subset expansion, binary
convolution and the Walsh representation using rational arithmetic. It also
checks the parity criterion, graph instances, finite-parameter maximum-cut
recovery and the overlapping-five-cycle coefficient in (6.3). The separate
matrix verification uses actual Pauli superoperators and normalized Choi
matrices, including noncommuting Pauli representatives. Their recorded
parameters and outcomes are in `results/exact_certificate.json` and
`results/matrix_verification.json`.

These finite computations support the implementation and examples. The
general statements follow from the proofs above. Current Lean verification
covers finite weighted-fiber identities and the binary-parity equivalence.
The quantum-channel reduction, asymptotic analysis, graph consequences and
complexity reduction are written proofs outside that formalized coverage.

## References

[1] J. Jiang, K. Wang and X. Wang. Physical Implementability of Linear Maps and
Its Application in Error Mitigation. *Quantum* **5**, 600 (2021).
[DOI: 10.22331/q-2021-12-07-600](https://doi.org/10.22331/q-2021-12-07-600).
[Author manuscript](https://arxiv.org/abs/2012.10959).

[2] E. van den Berg, Z. K. Minev, A. Kandala and K. Temme. Probabilistic error
cancellation with sparse Pauli–Lindblad models on noisy quantum processors.
*Nature Physics* **19**, 1116–1121 (2023).
[DOI: 10.1038/s41567-023-02042-2](https://doi.org/10.1038/s41567-023-02042-2).

[3] T.-R. Jin, Y.-R. Zhang, K. Xu and H. Fan. Noisy probabilistic error
cancellation and generalized physical implementability. *Communications
Physics* **8**, 296 (2025).
[DOI: 10.1038/s42005-025-02217-8](https://doi.org/10.1038/s42005-025-02217-8).
[Author manuscript](https://arxiv.org/abs/2409.01000).

[4] T. Scheiber, P. Haubenwallner and M. Heller. Reduced Sampling Overhead for
Probabilistic Error Cancellation by Pauli Error Propagation. *Quantum* **9**,
1840 (2025).
[DOI: 10.22331/q-2025-08-29-1840](https://doi.org/10.22331/q-2025-08-29-1840).
[Author manuscript](https://arxiv.org/abs/2412.01311).

[5] M. R. Garey, D. S. Johnson and L. Stockmeyer. Some simplified NP-complete
graph problems. *Theoretical Computer Science* **1**, 237–267 (1976).
[DOI: 10.1016/0304-3975(76)90059-1](https://doi.org/10.1016/0304-3975(76)90059-1).
