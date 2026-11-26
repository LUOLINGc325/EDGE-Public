# Sharp Wigner-negativity bounds, purity rigidity, and quantum correlations in spin systems

**Weixiang Wen · 25 November 2026**

Research manuscript. The complete written proofs are provided here. The manuscript has not undergone external peer review.

## Abstract

What does the negativity of a fixed spin Wigner representation reveal about many-body quantum correlations? For the canonical product-sphere representation of $r$ distinguishable qubits we determine the exact minimum negative volume over the entire pure-state space:

$$
\min_{\rho\ {\rm pure}}\delta(\rho)
=\frac12\left[\left(\frac2{\sqrt3}\right)^r-1\right].
$$

All minimizers are pure product states. Together with the established convex upper bound for fully separable states, this gives a necessary and sufficient negative-volume test for entanglement of every pure multiqubit state. The proof uses a sharp signed $L^1$--$L^2$ tensor inequality and an analytic argument that completely resolves its signed equality cases. We also determine the maximum purity of Wigner-nonnegative spin-1 states, $3/4$, classify all maximizers, and combine this with the qubit value $2/3$ to obtain sharp purity bounds and quantitative product rigidity on arbitrary mixed qubit/spin-1 arrays. These statements apply to the full physical positive-symbol set, without assuming a positive product decomposition.

For mixed states we identify a different, operational boundary. A local channel $\Phi$ sends every Wigner-nonnegative multiqubit input to a fully separable output, uniformly in particle number, exactly when $\Phi\circ\mathcal D_{1/\sqrt3}$ is entanglement breaking. It sends every such input to Bell-local correlations for all finite local POVM experiments exactly when this composition is incompatibility breaking. These equivalences use known all-tensor-power and measurement-incompatibility theorems as converse inputs, and a block-positive representation gives the sufficient directions for the whole physical set. For additional depolarization $\mathcal D_t$, the two sharp thresholds are $t=1/\sqrt3$ and $t=\sqrt3/2$; strictly positive Wigner functions can support Bell nonlocality above the latter. The manuscript also retains full proofs of the general finite-spin pure-state negativity theorem and its explicit, conservative purity--negativity inequalities. The exact qubit minimum does not settle the coherent-state minimum conjecture for a single higher spin.

## 1. The question and the contribution

Continuous spin phase space assigns a real function to every density operator. Its negative part is often interpreted as nonclassicality, but that word can refer to distinct properties: failure of a positive phase-space description, entanglement, or Bell nonlocality. This paper fixes the canonical self-dual spherical Stratonovich--Weyl kernel and independent local tensor products throughout. The main question is which exact implications connect these properties, and how those implications change between pure and mixed states.

### 1.1 Exact results for correlations and state geometry

For $r$ qubits let $\delta$ be the integrated negative Wigner volume with the self-dual measure. Theorem 7.3 proves

$$
1+2\delta(\rho)\ge(2/\sqrt3)^r\sqrt{\operatorname{Tr}\rho^2},
$$

with equality precisely at pure product states. Thus the pure-product value is the exact minimum over all pure states, and every entangled pure state has strictly greater volume. Arkhipov, Barasiński and Svozilík already supplied the one-qubit value, the product rule and the convex separability upper-bound mechanism [APT18]. The new reverse bound for every pure input, including its complete equality classification, turns that sufficient witness into an equivalence for pure states. It is an equivalence for ordinary entanglement, not for genuine multipartite entanglement. It does not extend to a mixed-state converse.

The mathematical step is a sharp signed inequality for real functions affine in every sphere coordinate separately. Applying the one-site inequality and Minkowski gives the norm bound. Equality is more delicate: proportional absolute-value slices do not immediately imply proportional signed slices. A real-analytic cross-product identity on the connected product of spheres closes that gap and gives all pure-state minimizers. Proposition 7.5 additionally supplies an exact two-qubit upper endpoint and a sharp two-producible bound, with full proofs; their priority is not used to support the main novelty claim.

For Wigner-nonnegative states, Theorem 6.6 gives the sharp $r$-qubit purity $(2/3)^r$. Section 8 extends the sharp geometry beyond affine symbols. A nonnegative quadratic on the sphere admits the classical affine-square decomposition, for which we give a proof including the trust-region hard case. This yields the spin-1 optimum $3/4$ and all physical maximizers. A tensor stability theorem, valid for the entire nonnegative tensor function cone, gives the exact mixed-array optimum

$$
p_*=(2/3)^a(3/4)^b
$$

for $a$ qubits and $b$ spin-1 particles. A state with purity close to this value is close in Hilbert--Schmidt norm to a product of the classified local maximizers. The explicit squared-distance coefficient is $2a+13b/3-1$. Converting this estimate to trace norm incurs the usual dimension factor; no dimension-independent trace-distance guarantee is claimed.

Section 9 treats the physical mixed-state set itself. Positivity of the product-sphere symbol is equivalent to block positivity after inverse local depolarization, with a separate positive-semidefinite condition retained for the original state. This representation yields exact criteria for all-particle-number removal of entanglement and of Bell nonlocality by an arbitrary channel with qubit input and finite-dimensional output. The necessary directions use the published results of Christandl, Müller-Hermes and Wolf [CMW19] and Plávala, Gühne and Quintino [PGQ25]. The numerical depolarization thresholds also use the sharp qubit measurement-compatibility result [R24]. We claim the transfer to the whole physical positive-symbol set, not the discovery of those deeper source theorems. The resulting three regimes distinguish universal separability, possible entanglement with universal Bell locality, and possible Bell nonlocality within a positive-symbol input class.

### 1.2 Relation to earlier spin results and neighboring frameworks

The complete finite-spin proof and conservative effective bounds from the preceding version are retained in Sections 2--6 and Appendices A--B. Davis, Kumari, Mann and Ghose studied negativity in coherent, cat and Dicke states [D21]. Davis, Hennigar, Mann and Ghose proved that every finite-spin coherent state is Wigner negative [D23, Section III]. Their proof uses orthogonal coherent states, traciality, polynomial support, and rotational covariance. Kam states the all-pure-spin extension as a conjecture [K26].

An earlier assertion must be disclosed. Denis's thesis describes the general proof as open in its introduction [Den25, printed p. 3], but states the general conclusion after an orthogonal-state overlap identity in its later discussion [Den25, printed p. 28]. That passage does not establish an orthogonal partner in the same SU(2) orbit for an arbitrary pure state. Gichev's existing orbit--hyperplane theorem does supply that input [G04]. Section 3 connects this classical theorem with the existing support argument; it does not claim first statement of the conclusion, invention of orbit orthogonality, or the coherent-state proof idea. Sections 4--6 give explicit general-spin overlap and purity--negativity estimates. Their constants are conservative, unlike the sharp low-spin theorems that now form the principal contribution.

Several neighboring results address different quantifiers or representations. Rundle and collaborators use the same product-sphere kernel for phase-space measurement and entanglement validation [R17]; we do not introduce that kernel. Denis and collaborators study absolute Wigner bounds under all global unitary conjugations [DDMM24], which differ from positivity of a fixed state in a fixed product representation. Zaw and collaborators connect continuous-variable slice negativity and smoothed center-of-mass negativity to genuine multipartite entanglement [ZGHFL26]. Their sufficient mixed-state witnesses, distance bounds, and measurement consequences are not subsumed by the pure-state equivalence here. Classical spin-coherent Husimi/Wehrl stability [NRT26a; NRT26b] concerns a positive overlap symbol with a different optimization domain. The present quadratic tensor-cone argument is stated and proved independently. Earlier phase-space criteria for measurement incompatibility [RMdSCA21] are also distinct from the exact input-class channel equivalences below.

Our literature assessment is bounded to the documented primary sources and searches. It supports the stated incremental claims, not a guarantee that every possible prior work has been excluded. The fixed representation is essential: these statements are not assertions about discrete Weyl Wigner functions, arbitrary phase-space sampling distributions, or a reducible collective spin embedding.

### 1.3 Main notation

All Hilbert spaces are complex and finite dimensional. A density operator is a positive semidefinite Hermitian operator of trace one. We write $P_\psi=|\psi\rangle\langle\psi|$ for a rank-one orthogonal projector, $\|\psi\|=1$. The Hilbert–Schmidt norm is $\|A\|_2=(\operatorname{Tr}A^\dagger A)^{1/2}$. Matrix positivity inequalities are in the Loewner order; whenever products need not commute, their comparison below is made only after taking a trace against a positive operator.

The normalized area measure on $S^2$ is $d\sigma=d\Omega/(4\pi)$. For $r\ge1$ spins, define

$$
X=(S^2)^r,\qquad d\sigma_X=\prod_{i=1}^r d\sigma_i,
\qquad n_i=2j_i\in\mathbb N_{\ge1},
$$

$$
N=\sum_{i=1}^r n_i,\qquad d_i=n_i+1,\qquad
D=\prod_{i=1}^r d_i,\qquad d\mu=D\,d\sigma_X.
\tag{1.1}
$$

Thus $\sigma_X(X)=1$ but $\mu(X)=D$. The distinction is essential to every constant. For a real-valued normalized symbol $W_\rho$, set

$$
p=\operatorname{Tr}\rho^2,\qquad
\delta(\rho)=\frac{\int_X|W_\rho|\,d\mu-1}{2}
=\int_X(W_\rho)_-\,d\mu,
\tag{1.2}
$$

where $u_+=\max(u,0)$ and $u_-=\max(-u,0)$.

## 2. The exact symbol and its normalization

For a single spin $j=n/2$, let $\{|j,a\rangle:-j\le a\le j\}$ be the angular-momentum basis. Fix the standard Clebsch–Gordan convention, and define the trace-orthonormal irreducible tensor operators

$$
T_{\ell m}^{(j)}=
\sqrt{\frac{2\ell+1}{n+1}}
\sum_{a,b=-j}^j
\langle j,a;\ell,m\mid j,b\rangle
|j,b\rangle\langle j,a|,
\quad 0\le\ell\le n,\quad -\ell\le m\le\ell.
\tag{2.1}
$$

They obey $T_{00}=I/\sqrt{n+1}$, $T_{\ell m}^\dagger=(-1)^mT_{\ell,-m}$, and

$$
\operatorname{Tr}(T_{\ell m}^\dagger T_{\ell' m'})
=\mathbf1_{\ell=\ell',\,m=m'}.
\tag{2.2}
$$

With spherical harmonics normalized by $\int_{S^2}|Y_{\ell m}|^2d\Omega=1$, the canonical kernel is

$$
\Delta_j(x)=\sqrt{\frac{4\pi}{n+1}}
\sum_{\ell=0}^n\sum_{m=-\ell}^{\ell}
T_{\ell m}^{(j)}\,\overline{Y_{\ell m}(x)}.
\tag{2.3}
$$

This is the convention of [D23, equations (13)–(15)]. The upper limit in the inner sum is $\ell$. The kernel is Hermitian, has trace one, and is covariant under the spin-$j$ representation $U_j$ of SU(2). On the product space use

$$
\Delta(x_1,\ldots,x_r)=\bigotimes_{i=1}^r\Delta_{j_i}(x_i),
\qquad W_A(x)=\operatorname{Tr}[A\Delta(x)].
\tag{2.4}
$$

The acting group is the product $G=\prod_i\mathrm{SU}(2)$, with representation $U(g)=\bigotimes_iU_{j_i}(g_i)$. It allows independent local rotations. It is not the generally reducible diagonal collective-rotation representation.

**Lemma 2.1 (symbol identities).** For Hermitian $A,B$, the product symbol is real, is a polynomial of degree at most $n_i$ in each sphere variable, and satisfies

$$
\int_X W_A\,d\mu=\operatorname{Tr}A,\qquad
\int_X W_AW_B\,d\mu=\operatorname{Tr}(AB),
\tag{2.5}
$$

$$
W_{U(g)AU(g)^\dagger}(x)=W_A(g^{-1}x),\qquad
\operatorname{Tr}[\Delta(x)^2]=D.
\tag{2.6}
$$

In particular, for a density operator of purity $p$,

$$
\|W_\rho\|_\infty\le\sqrt{Dp}.
\tag{2.7}
$$

*Proof.* Hermiticity follows by pairing $m$ with $-m$ in (2.3), using the conjugation identities for $T_{\ell m}$ and $Y_{\ell m}$. Only the $\ell=0$ term contributes to the integral, and it equals $I/(n+1)$. Multiplication of the area measure by $n+1$ therefore gives the first identity in (2.5). Trace orthonormality and harmonic orthogonality give the second identity. Covariance follows from the identical irreducible rotation law of the tensors and spherical harmonics.

For the kernel norm, the addition theorem gives

$$
\operatorname{Tr}\Delta_j(x)^2
=\frac{4\pi}{n+1}\sum_{\ell=0}^n\sum_m|Y_{\ell m}(x)|^2
=\frac{1}{n+1}\sum_{\ell=0}^n(2\ell+1)=n+1.
$$

All identities tensorize, because tensor products of the $T_{\ell m}$ form an orthonormal basis of the full operator space. This argument does not require $A$ or $B$ to be product operators. Each harmonic is the restriction of a homogeneous polynomial of degree $\ell$, giving the separate degree bounds. Finally apply the Hilbert–Schmidt Cauchy–Schwarz inequality pointwise to $\operatorname{Tr}(\rho\Delta(x))$. ∎

The same identities hold if, for each factor, the $\ell$-th term of (2.3) is multiplied by a sign $\epsilon_\ell\in\{-1,1\}$, with $\epsilon_0=1$. The general-spin conclusions in Sections 3--6 hold uniformly for these self-dual sign choices. The qubit conclusions are unchanged by reversing a local sphere direction. The spin-1 sharp results in Section 8 require the canonical quadrupole sign and are not asserted for every sign choice. The canonical convention is the all-plus choice and is the one used for the source conjecture and numerical examples.

## 3. The qualitative compact-symmetry obstruction

We first isolate the classical input.

**Theorem 3.1 (Gichev's orbit–hyperplane theorem [G04, Corollary 1]).** Let $K\subset\operatorname{GL}(V)$ be a compact connected irreducible complex linear group, with $\dim_{\mathbb C}V>1$. Every orbit $K v$ meets every complex hyperplane of $V$.

For a unitary representation and a unit vector $\psi$, taking the hyperplane $\psi^\perp$ yields an element $g$ such that

$$
\langle\psi,U(g)\psi\rangle=0.
\tag{3.1}
$$

The theorem, including this general-group consequence, is an existing result. A short self-contained specialization for SU(2), based on the classical constant-phase argument, is included in Appendix A for clarity; it is not an originality claim.

**Theorem 3.2 (analytic self-dual symbols exclude nonnegative pure states).** Let $G$ be a compact connected Lie group with a continuous irreducible unitary representation $U$ on a $D>1$ dimensional Hilbert space. Let $X$ be a compact connected real-analytic manifold with a continuous $G$-action and a finite invariant Borel measure $\mu$ of full support. Suppose the real-linear symbol map

$$
W:\operatorname{Herm}(\mathcal H)\longrightarrow C^\omega(X;\mathbb R)
$$

is normalized, self-dual and covariant in exactly the senses of (2.5) and the first identity of (2.6). Then every rank-one projector $P$ has $W_P(x)<0$ at some point $x\in X$, and $\int_X(W_P)_-d\mu>0$.

*Proof.* By Gichev's theorem applied to the compact connected image $U(G)$, choose $g$ with $P$ orthogonal to $Q=U(g)PU(g)^\dagger$. Suppose, for contradiction, that $f=W_P\ge0$ everywhere. Covariance gives $h=W_Q=f\circ g^{-1}\ge0$. Both are nonzero, since their integrals are one. A nonzero real-analytic function on a connected analytic manifold cannot vanish on an open set. Therefore $\{f>0\}$ and $\{h>0\}$ are open dense sets. They have a nonempty open intersection. On a sufficiently small open subset of that intersection both functions have strictly positive lower bounds, and full support of $\mu$ implies $\int fh\,d\mu>0$. Self-duality instead gives $\int fh\,d\mu=\operatorname{Tr}(PQ)=0$, a contradiction. The negative value persists on an open set by continuity, so its negative integral is positive. ∎

**Corollary 3.3 (all finite spins and all finite spin products).** Every pure state with $j>0$, and every pure state of a finite tensor product of such spins, has strictly positive negative Wigner volume for the kernels (2.3)–(2.4). This includes arbitrary entangled pure states and all the self-dual sign choices just described.

*Proof.* A nonzero spin representation is irreducible and has dimension greater than one. The exterior tensor product of irreducible representations is irreducible for the product group: an operator commuting with each factor action has scalar coefficients on that factor by Schur's lemma; applying this successively to all factors leaves only scalar multiples of the identity. A proper invariant subspace would give a nonscalar orthogonal projection in the commutant, which is impossible. The product group and product sphere are connected and compact. Finite spherical-harmonic expansions are real analytic, and product area measure has full support. Lemma 2.1 supplies the remaining hypotheses of Theorem 3.2. ∎

The analyticity hypothesis is substantive. Nonzero smooth functions can have disjoint supports, and neither covariance nor ordinary smoothness alone supplies the support argument. For a finite-dimensional covariant kernel on an analytic homogeneous space $G/H$, analyticity follows from the analytic matrix coefficients of $U$ and analytic local sections of $G\to G/H$; it is explicit in (2.3).

## 4. A quantitative overlap inequality on products of spheres

For a complex polynomial $P$ in $k$ variables, its coefficient length and Mahler measure are

$$
L(P)=\sum_{\alpha}|a_\alpha|,\qquad
M(P)=\exp\!\left(\int_{\mathbb T^k}\log|P(z)|\,dm(z)\right),
\tag{4.1}
$$

where $m$ is normalized Haar measure and $P\ne0$. Polynomial logarithms are integrable on the torus. If the degree in variable $z_a$ is at most $m_a$, Mahler [M62, equations (3)–(4)] proved

$$
L(P)\le2^{\sum_a m_a}M(P).
\tag{4.2}
$$

We use (4.2) as a classical input, not as a new inequality. The one-variable proof follows by bounding each coefficient by its binomial coefficient times the product of the root moduli outside the unit circle. Applying the one-variable coefficient estimate successively in the variables gives (4.2). The cited multivariable theorem includes the logarithmic-integrability conditions. Multiplication by a monomial does not change $M$, and $M(PQ)=M(P)M(Q)$.

**Lemma 4.1 (weighted torus parametrization).** Write

$$
q(\theta,\phi)=(\sin\theta\cos\phi,\sin\theta\sin\phi,\cos\theta),
\qquad 0\le\theta,\phi<2\pi.
$$

For every integrable $h$ on $X$, with pullback $H=h\circ q^{\times r}$,

$$
\int_X h\,d\sigma_X
=\left(\frac{\pi}{2}\right)^r
\int_{\mathbb T^{2r}} H(\boldsymbol\theta,\boldsymbol\phi)
\prod_{i=1}^r|\sin\theta_i|\,dm.
\tag{4.3}
$$

Moreover,

$$
\int_0^{2\pi}\log|\sin\theta|\,\frac{d\theta}{2\pi}=-\log2.
\tag{4.4}
$$

*Proof.* For one sphere the parametrization with $\theta\in[0,2\pi)$ covers the sphere twice, outside a null set. Hence

$$
\int_0^{2\pi}\!\int_0^{2\pi}h(q(\theta,\phi))|\sin\theta|\,d\phi\,d\theta
=2\int_{S^2}h\,d\Omega.
$$

Divide by $4\pi^2$ and compare with $d\sigma=d\Omega/(4\pi)$. This gives the factor $\pi/2$; taking products gives (4.3). For (4.4), the integral $I=\int_0^{\pi/2}\log\sin t\,dt$ is finite. Substituting $\pi/2-t$ gives the same integral for $\log\cos t$, and the double-angle identity yields $2I=-(\pi/2)\log2+I$. Symmetry on the full period finishes the calculation. ∎

**Theorem 4.2 (explicit absolute overlap).** Let $f,g$ be real or complex functions on $X$, each a polynomial of degree at most $n_i$ in sphere variable $i$. With $N=\sum_i n_i$,

$$
\int_X|fg|\,d\sigma_X
\ge c\left(\int_X|f|\,d\sigma_X\right)
          \left(\int_X|g|\,d\sigma_X\right),
\qquad c=\left(\frac{\pi}{4}\right)^r2^{-8N}.
\tag{4.5}
$$

*Proof.* The assertion is trivial if either function is zero. Otherwise let $F,G$ be their pullbacks under the torus parametrization. A monomial of degree at most $n_i$ in the three Cartesian coordinates on sphere $i$ becomes a trigonometric polynomial with frequencies between $-n_i$ and $n_i$ in each of $\theta_i,\phi_i$. Multiplying $F$ by $\prod_i z_i^{n_i}w_i^{n_i}$ therefore produces an ordinary nonzero polynomial $P$, of degree at most $2n_i$ in each of $z_i,w_i$. Its total sum of separate degree bounds is $4N$. Construct $Q$ from $G$ in the same way. On the torus $|P|=|F|$ and $|Q|=|G|$.

By the triangle inequality for coefficients, (4.2), and the fact that $\sigma_X$ is a probability measure,

$$
\int_X|f|\,d\sigma_X\le\|f\|_\infty
=\|F\|_\infty\le L(P)\le2^{4N}M(P),
\tag{4.6}
$$

and the corresponding estimate holds for $g,Q$.

Apply the arithmetic–geometric mean inequality in integral form to the nonnegative function

$$
Z=|P Q|\prod_i|\sin\theta_i|
$$

on the probability torus. Its logarithm is integrable: the polynomial factors are nonzero and (4.4) handles the Jacobians. Thus

$$
\int Z\,dm\ge\exp\int\log Z\,dm
=2^{-r}M(P)M(Q).
\tag{4.7}
$$

Zeros on null sets do not change either side. Combining (4.3), (4.6) and (4.7) gives

$$
\int_X|fg|\,d\sigma_X
\ge\left(\frac\pi4\right)^rM(P)M(Q)
\ge\left(\frac\pi4\right)^r2^{-8N}\|f\|_{L^1(\sigma_X)}\|g\|_{L^1(\sigma_X)}.
$$

This proves (4.5). ∎

The absolute values in this theorem matter: neither $f$ nor $g$ is assumed nonnegative. A rotation in each sphere preserves the separate polynomial degree, so the same constant applies to $g=f\circ g_0^{-1}$ for every physical product rotation $g_0$. No multivariate Fejér–Riesz factorization is used.

### 4.1 A stronger bound from the spherical logarithmic mean

The next estimate improves the constant of Theorem 4.2. Define $\omega$ as the unique positive solution of $\omega e^\omega=e^{-1}$, and put

$$
C=1+\omega,\qquad K=e^C=\omega^{-1},\qquad
\omega=0.2784645427610738\ldots .
\tag{4.8}
$$

The constant $K=3.591121476668622\ldots$ and the corresponding interval extremal problem are classical: they appear explicitly in Glazyrina [Gl08, Theorem 1, equations (1.8) and (1.10)], with attribution of the zero-derivative case to her 2003 work. The argument below gives the sphere and product-of-spheres versions directly. We use this as an auxiliary estimate with conservative attribution; we do not claim priority for a new approximation-theory inequality.

**Lemma 4.3 (weighted single-root estimate).** With $w(\theta)=|\sin\theta|/4$, so that $\int_0^{2\pi}w=1$, every complex number $a\ne1$ satisfies

$$
\log|1-a|-\int_0^{2\pi}w(\theta)
                 \log|e^{i\theta}-a|\,d\theta\le\frac C2.
\tag{4.9}
$$

*Proof.* Denote the difference by $D(a)$. For $|a|>1$, inversion of the root through the unit circle gives $D(a)=D(1/\bar a)$: the additive $\log|a|$ cancels. For $|a|<1$, $D$ is harmonic. More explicitly, the Poisson formula for the logarithm of the distance to a boundary point, followed by Fubini, writes $D(a)$ as the Poisson average of its integrable boundary values. Fubini is legitimate because $w$ and the Poisson kernel for a fixed interior point are bounded and the boundary logarithmic singularities are integrable. It is therefore enough to bound $D$ on the unit circle.

Set $a=e^{i\alpha}$ and $c=\cos\alpha$. Pairing $\theta$ with $2\pi-\theta$ gives

$$
|e^{i\theta}-e^{i\alpha}|^2
|e^{-i\theta}-e^{i\alpha}|^2=4(\cos\theta-c)^2.
$$

Consequently

$$
\begin{aligned}
\int_0^{2\pi}w(\theta)\log|e^{i\theta}-e^{i\alpha}|^2\,d\theta
&=\log2+\frac12\int_{-1}^1\log|x-c|\,dx\\
&=\log2-1+
\frac{(1+c)\log(1+c)+(1-c)\log(1-c)}2.
\end{aligned}
$$

Here $0\log0$ means zero. Since $|1-e^{i\alpha}|^2=2(1-c)$, it follows that

$$
2D(e^{i\alpha})
=1+\frac{1+c}{2}\log\frac{1-c}{1+c}
=1+t\log\frac{1-t}{t},\qquad t=\frac{1+c}2.
\tag{4.10}
$$

Differentiation shows that the unique interior maximum satisfies
$\log[(1-t)/t]=1/(1-t)$. Writing $s=t/(1-t)$ gives
$se^s=e^{-1}$, hence $s=\omega$. The maximum is $1+\omega=C$.
At the endpoints the expression tends to $1$ and $-\infty$, respectively.
The boundary bound, Poisson averaging, and root inversion prove (4.9). The omitted point $a=1$ has logarithmic point value $-\infty$ and cannot increase the supremum. ∎

**Theorem 4.4 (sharp auxiliary spherical logarithmic-mean inequality).** If $f$ is a nonzero complex spherical polynomial of degree at most $n$, then $\log|f|$ is integrable for probability area measure and

$$
\|f\|_\infty\le K^n\exp\!\left(\int_{S^2}\log|f|\,d\sigma\right).
\tag{4.11}
$$

For a nonzero polynomial $F$ on $X$ with separate degrees at most $n_i$, the corresponding statement is

$$
\|F\|_\infty\le K^N
       \exp\!\left(\int_X\log|F|\,d\sigma_X\right).
\tag{4.12}
$$

The constants in these two auxiliary inequalities are best possible.

*Proof.* Let $x_0$ be a point at which $|f|$ has its nonzero maximum $M$.
Rotate coordinates so that $x_0$ is the north pole. Along each meridian,
$q_\phi(\theta)=f(q(\theta,\phi))$ is a trigonometric polynomial of degree at most $n$, and $q_\phi(0)=f(x_0)\ne0$.
Multiplication by $z^n$, $z=e^{i\theta}$, gives a nonzero ordinary polynomial of degree at most $2n$. Factor it over $\mathbb C$. No root is $1$. Summing (4.9) over its at most $2n$ roots gives

$$
\log M-\int_0^{2\pi}w(\theta)\log|q_\phi(\theta)|\,d\theta\le nC.
\tag{4.13}
$$

This includes the constant-polynomial case, in which there are no roots.
Average over $\phi$ with measure $d\phi/(2\pi)$. The full meridian circle double-covers the sphere, and the weight $|\sin\theta|/4$ gives exactly probability area measure. There is no residual factor of two.
For complete integrability justification, apply Tonelli to the nonnegative function $\log M-\log|f|$, with value $+\infty$ at zeros. Equation (4.13) bounds its weighted integral on every meridian by $nC$, so its spherical integral is finite and at most $nC$. This proves (4.11). The same proof at any point with nonzero value gives its pointwise form.

For (4.12), start at a point where $|F|=M>0$ and use
$H=\log M-\log|F|\ge0$. Apply the pointwise one-sphere estimate successively in each variable. At each step a slice through a finite reference value is nonzero; its average of $H$ is at most that reference value plus $Cn_i$.
The previously obtained finite integral implies that slices with infinite reference value occur on a null set. Tonelli therefore justifies each induction step and yields
$\int_XH\,d\sigma_X\le CN$. This also proves logarithmic integrability on the product.

For sharpness, let

$$
c_*=\frac{\omega-1}{\omega+1},
\qquad f(x)=(u\cdot x-c_*)^n,\quad |u|=1.
\tag{4.14}
$$

The coordinate $u\cdot x$ is uniform on $[-1,1]$. Direct integration gives

$$
\log\|f\|_\infty-\int\log|f|\,d\sigma
=n\left(1+\frac{1+c_*}{2}\log\frac{1-c_*}{1+c_*}\right)
=nC.
$$

Products of these examples attain equality in (4.12). This establishes sharpness of the auxiliary norm comparison only. These examples are not asserted to be Wigner functions of physical pure states. ∎

**Corollary 4.5 (improved absolute overlap).** For the polynomials of Theorem 4.2,

$$
\int_X|fg|\,d\sigma_X
\ge c_1
\|f\|_{L^1(\sigma_X)}\|g\|_{L^1(\sigma_X)},
\qquad c_1:=\omega^{2N}.
\tag{4.15}
$$

*Proof.* Treat an identically zero factor separately. Otherwise Jensen's inequality and (4.12) give

$$
\int|fg|\,d\sigma_X
\ge\exp\int(\log|f|+\log|g|)\,d\sigma_X
\ge K^{-2N}\|f\|_\infty\|g\|_\infty
\ge K^{-2N}\|f\|_1\|g\|_1.
$$

All logarithms are integrable by Theorem 4.4. ∎

We use $c=\omega^{2N}$ below, to avoid confusing the overlap constant with the extremal root $c_*$ in (4.14). Its ratio to the original target constant is

$$
\frac{\omega^{2N}}{(\pi/4)^r2^{-8N}}
=\left(\frac4\pi\right)^r(256\omega^2)^N,
\qquad 256\omega^2=19.8508804032343\ldots .
\tag{4.16}
$$

Theorem 4.2 thus follows from the stronger bound and has an independent proof using the Mahler inequality. Neither Jensen's step nor the physical-state inequalities are claimed sharp.


## 5. A mixed-state overlap estimate within the physical group

**Lemma 5.1 (orbit overlap controlled by the spectrum).** Let $U$ be any compact connected irreducible unitary group representation of dimension $D>1$. For every density operator $\rho$, write $p=\operatorname{Tr}\rho^2$ and $\lambda=\lambda_{\max}(\rho)$. There is an element $g$ such that

$$
\operatorname{Tr}[\rho U(g)\rho U(g)^\dagger]
\le m(\rho):=\min\{p,\,2\lambda(1-\lambda)\}
\le1-p.
\tag{5.1}
$$

*Proof.* The identity element gives overlap $p$. If $\lambda\le1/2$, then $p\le\lambda\le2\lambda(1-\lambda)$ and $p\le1/2\le1-p$; the identity suffices.

Now suppose $\lambda>1/2$. Its eigenvector is unique up to phase. Write

$$
\rho=\lambda P+E,\qquad E\ge0,\quad EP=0,\quad
\operatorname{Tr}E=\eta:=1-\lambda.
$$

Gichev's theorem supplies $g$ such that $Q=U(g)PU(g)^\dagger$ is orthogonal to $P$. Put $F=U(g)EU(g)^\dagger$. Since $F\ge0$, $FQ=0$, and $\operatorname{Tr}F=\eta$,

$$
0\le F\le\eta(I-Q),\qquad \operatorname{Tr}(PF)\le\eta,
\qquad 0\le\operatorname{Tr}(EQ)\le\eta.
\tag{5.2}
$$

Tracing the first inequality against $E\ge0$ is legitimate even if $E,F,Q$ do not commute. It gives

$$
\operatorname{Tr}(EF)\le\eta^2-\eta\operatorname{Tr}(EQ).
\tag{5.3}
$$

Therefore

$$
\begin{aligned}
\operatorname{Tr}[\rho U(g)\rho U(g)^\dagger]
&=\lambda\operatorname{Tr}(PF)+\lambda\operatorname{Tr}(EQ)+\operatorname{Tr}(EF)\\
&\le\lambda\eta+\eta^2+(\lambda-\eta)\operatorname{Tr}(EQ)\\
&\le2\lambda\eta,
\end{aligned}
\tag{5.4}
$$

because $\lambda-\eta>0$. Choosing between this $g$ and the identity proves the minimum in (5.1). Finally, $\operatorname{Tr}E^2\le(\operatorname{Tr}E)^2=\eta^2$, so $p\le\lambda^2+\eta^2$ and $2\lambda\eta\le1-p$. If the minimum selects $p$ instead, it is no greater than $2\lambda\eta$, so the same conclusion holds. ∎

The element $g$ belongs to the given physical group, not to an unrestricted $\mathrm{SU}(D)$ chosen to rearrange eigenvalues. This distinction is needed for the covariance step below.

## 6. The quantitative negativity–purity theorem

**Theorem 6.1 (all-state inequality).** For the product spin systems and Wigner functions of Section 2, every density operator satisfies

$$
\begin{aligned}
\frac{c}{D}(1+2\delta)^2
&\le m(\rho)+4\sqrt{Dp}\,\delta\\
&\le1-p+4\sqrt{Dp}\,\delta,
\qquad c=\omega^{2N}.
\end{aligned}
\tag{6.1}
$$

*Proof.* Choose $g$ by Lemma 5.1, and put $f=W_\rho$ and $h=W_{U(g)\rho U(g)^\dagger}$. Covariance and measure invariance give

$$
\int|f|\,d\mu=\int|h|\,d\mu=1+2\delta,
\quad \int f_-d\mu=\int h_-d\mu=\delta,
\quad \|f\|_\infty=\|h\|_\infty\le B:=\sqrt{Dp}.
\tag{6.2}
$$

By Corollary 4.5 and $\mu=D\sigma_X$,

$$
\int_X|fh|\,d\mu
\ge\frac cD(1+2\delta)^2.
\tag{6.3}
$$

For real numbers, the exact identity

$$
|fh|-fh=2(f_+h_-+f_-h_+)
$$

holds pointwise. Each positive part is at most $B$; hence

$$
\int|fh|\,d\mu
\le\int fh\,d\mu+2B\int(h_-+f_-)\,d\mu
\le m(\rho)+4B\delta.
\tag{6.4}
$$

Traciality and Lemma 5.1 were used in the last step. Equations (6.3)–(6.4) prove the theorem. ∎

**Corollary 6.2 (uniform pure-state negative volume).** Every pure state, including every entangled pure state, satisfies

$$
\boxed{\quad
\delta(\rho)\ge b_{\boldsymbol n}:=
\frac{\omega^{2N}}{4D^{3/2}}>0.
\quad}
\tag{6.5}
$$

For a single spin $j=n/2>0$, this becomes

$$
\delta(\rho)\ge\frac{\omega^{2n}}{4(n+1)^{3/2}}.
\tag{6.6}
$$

*Proof.* Set $p=1$ in (6.1), and use $(1+2\delta)^2\ge1$. ∎

**Corollary 6.3 (a forbidden high-purity region).** If $W_\rho\ge0$ everywhere, then

$$
\boxed{\quad p\le1-\frac cD.\quad}
\tag{6.7}
$$

It also satisfies

$$
\lambda_{\max}(\rho)
\le\frac{1+\sqrt{1-2c/D}}2.
\tag{6.8}
$$

Conversely, exceeding either right-hand threshold certifies that the Wigner function has a negative value. These are sufficient negativity criteria, not a classification of all nonnegative mixed states.

*Proof.* A continuous normalized symbol has $\delta=0$ exactly when it is everywhere nonnegative, since area measure has full support. The second inequality in (6.1) gives (6.7). Its first inequality gives $2\lambda(1-\lambda)\ge c/D$, whose upper quadratic root is (6.8). Here $0 \lt c/D<1/2$, because $r\ge1,N\ge1,D\ge2$. ∎

**Corollary 6.4 (explicit lower bound from observed purity).** Every density operator satisfies

$$
\delta(\rho)\ge
\max\left\{0,\frac{p-1+c/D}{4\sqrt{Dp}}\right\}.
\tag{6.9}
$$

The sharper numerator $c/D-m(\rho)$ may replace $p-1+c/D$.

*Proof.* Discard the nonnegative terms $4\delta+4\delta^2$ from $(1+2\delta)^2$ in (6.1), rearrange, and use $\delta\ge0$. The denominator is positive, since $p\ge1/D$. ∎

### 6.1 Parameter scale and honest comparison

The bound is exponential in the total twice-spin $N$, rather than exponential in the generally much larger Hilbert-space dimension. Since $D\le2^N$, every pure state obeys

$$
\delta(\rho)\ge\frac14\left(\frac{\omega^2}{2^{3/2}}\right)^N.
\tag{6.10}
$$

The bound from Theorem 4.2, $c_0=(\pi/4)^r2^{-8N}$ remains valid by Theorem 4.2; the improved $c$ is used for the final general-spin estimates. For one qubit the old bound is approximately $2.71\times10^{-4}$ and the new bound is approximately $0.006854$. Both are below the exact pure-state value $1/\sqrt3-1/2\approx0.0773503$. The general purity criterion gives $p\le1-\omega^2/2\approx0.961229$ for a nonnegative single-qubit symbol, whereas the exact threshold is $2/3$.

Neither the lower bound nor the numerical decay observed for coherent states proves $\delta_{\min}(j)=\exp[-\Theta(j)]$. A matching uniform upper bound and the identification of all minimizing states remain open in this work. Sharpness of the auxiliary logarithmic-mean estimate does not establish sharpness of the Wigner negativity or purity bound.

### 6.2 The exact positivity purity boundary for qubit products

For the special case $n_i=1$ for all $i$, the general conservative bound can be replaced by an exact optimum, with a complete equality classification. This subsection uses the full $r$-qubit Hilbert space and the product of local spherical kernels. It does not concern the collective spin-$r/2$ kernel on one sphere, a full $\mathrm{SU}(2^r)$ kernel, or a discrete Wigner representation.

Write the Pauli matrices as $\boldsymbol\sigma=(\sigma_1,\sigma_2,\sigma_3)$. The local product convention is also used in [R17, Section V, equations (10)–(12)]. Its kernel is

$$
\Delta_{1/2}(x)=\frac{I+\sqrt3\,x\cdot\boldsymbol\sigma}{2},
\qquad d\mu=2^r\,d\sigma_X.
\tag{6.11}
$$

The one-qubit threshold $p\le2/3$ is established prior work [T18; APT18, equation (16)], and is not an original result of this paper. The statement below determines the optimum and all physical maximizers for every number of qubits.

**Lemma 6.5 (nonnegative separately affine functions).** Let $F$ be a nonzero real function on $(S^2)^r$ that is affine in each sphere variable separately and is nonnegative everywhere. Then

$$
\int F^2\,d\sigma_X
\le\left(\frac43\right)^r
       \left(\int F\,d\sigma_X\right)^2.
\tag{6.12}
$$

Equality holds if and only if

$$
F(x_1,\ldots,x_r)=A\prod_{i=1}^r(1+u_i\cdot x_i),
\qquad A>0,\quad u_i\in S^2.
\tag{6.13}
$$

*Proof.* On one sphere write $F(x)=a+b\cdot x$. Pointwise nonnegativity is equivalent to $a\ge|b|$. The probability-area moments give

$$
\int F\,d\sigma=a,\qquad
\int F^2\,d\sigma=a^2+\frac{|b|^2}3\le\frac43a^2.
$$

For nonzero $F$, equality holds exactly when $a=|b|>0$, giving the stated form.

For the induction step write $F(x,y)=a(y)+b(y)\cdot x$, where $x$ is the first sphere variable and $y$ denotes the remaining ones. The functions $a$ and all components of $b$ are separately affine. Positivity gives $a(y)\ge|b(y)|$ for every $y$. Thus

$$
\begin{aligned}
\int F^2\,d\sigma_X
&=\int\left(a^2+\frac{|b|^2}3\right)d\sigma_{r-1}\\
&\le\frac43\int a^2\,d\sigma_{r-1}\\
&\le\left(\frac43\right)^r\left(\int a\,d\sigma_{r-1}\right)^2.
\end{aligned}
\tag{6.14}
$$

The nonnegative continuous nonzero function $F$ has positive integral, so $a$ is nonzero and induction applies.

Suppose equality holds. Both inequalities in (6.14) are equalities. By induction,
$a(y)=A\prod_{k=2}^r(1+u_k\cdot y_k)$ with $A>0$ and unit $u_k$.
If $y_k=-u_k$, this marginal is zero. The nonnegative continuous function
$x\mapsto F(x,y)$ then has zero integral, so it vanishes for every $x$.
Thus $F$ vanishes on each full coordinate slice $y_k=-u_k$.

The following elementary fact converts these zero slices into factors. If
$G(z,y)=c(z)+d(z)\cdot y\ge0$ and $G(z,-u)=0$ for a fixed unit $u$ and every $z$, then

$$
c(z)=d(z)\cdot u\le|d(z)|\le c(z).
$$

Equality in Cauchy's inequality, including the case $c=0$, forces $d=cu$.
Hence $G=c(z)(1+u\cdot y)$. Its residual factor $c$ is the sphere average of $G$, so it remains nonnegative and separately affine in the other variables.

Apply this fact successively to the zero slices of $F$. Averaging a factored-out coordinate preserves each remaining zero slice. We obtain
$F=H(x_1)\prod_{k=2}^r(1+u_k\cdot x_k)$, where $H$ is nonzero, nonnegative and affine. Equality in (6.12) now reduces to the one-sphere equality for $H$, giving (6.13). Conversely, direct integration of (6.13) gives equality. Continuity and full support justify the pointwise zero-slice conclusions; there is no appeal to a statement that holds only almost everywhere on a null slice. ∎

**Theorem 6.6 (sharp multiqubit purity and all maximizers).** For every density operator $\rho$ on $r\ge1$ qubits with $W_\rho\ge0$ everywhere in the product representation (6.11),

$$
\operatorname{Tr}\rho^2\le\left(\frac23\right)^r.
\tag{6.15}
$$

Equality holds if and only if there are unit vectors $u_1,\ldots,u_r$ such that

$$
\rho=\bigotimes_{i=1}^r
\frac{I+u_i\cdot\boldsymbol\sigma/\sqrt3}{2}.
\tag{6.16}
$$

*Proof.* The symbol $W_\rho$ is real and separately affine, even when $\rho$ is entangled. Normalization and self-duality give
$\int W_\rho\,d\sigma_X=2^{-r}$ and
$\int W_\rho^2\,d\sigma_X=2^{-r}\operatorname{Tr}\rho^2$.
Insert these in (6.12) to obtain (6.15).

If equality holds, (6.13) and the normalization force
$W_\rho(x)=2^{-r}\prod_i(1+u_i\cdot x_i)$.
Each factor state in (6.16) has Bloch radius $1/\sqrt3<1$, hence is a strictly positive density matrix; direct trace calculation gives its symbol $(1+u_i\cdot x_i)/2$. The product state therefore has the required symbol. Self-duality makes the Wigner map injective: if a Hermitian $A$ has $W_A=0$, then $\operatorname{Tr}A^2=\int W_A^2\,d\mu=0$, so $A=0$. This proves necessity in (6.16). Conversely, those product states are physical, have a nonnegative symbol, and have purity $(2/3)^r$. ∎

The physical realization in this proof is essential. An extremizer of an auxiliary polynomial inequality need not correspond to a positive density operator; (6.16) explicitly verifies that these do. All maximizers are product states and are full rank as operators. Their Wigner functions have zeros, so they lie on the boundary of Wigner nonnegativity.

**Corollary 6.7 (entropy and all marginal purity constraints).** With natural logarithms, every state in Theorem 6.6 obeys

$$
S_2(\rho):=-\log\operatorname{Tr}\rho^2\ge r\log(3/2).
\tag{6.17}
$$

For every nonempty subset $A$ of its qubits,

$$
\operatorname{Tr}\rho_A^2\le(2/3)^{|A|}.
\tag{6.18}
$$

The entropy equality states are exactly (6.16). If any full-state or marginal purity exceeds its displayed bound, the full Wigner function has a negative value.

*Proof.* The entropy assertion follows by the monotonicity of $-\log$.
Integrating the product kernel over a complementary sphere with its mass-two measure gives the identity operator. Therefore integration of $W_\rho$ over all complementary spheres gives $W_{\rho_A}$. It is nonnegative whenever $W_\rho$ is. Apply Theorem 6.6 to the marginal. ∎

For $r>1$, the purity criterion is not asserted to characterize every Wigner-nonnegative state. The theorem also does not state that every Wigner-nonnegative state is separable; it classifies the maximum-purity states only. It does not give the sharp negative volume at a prescribed positive excess of purity.

**Example 6.8 (the optimum is not a classification of the whole set).** For two qubits, the normalized symmetric projector has

$$
\rho_{\mathrm{sym}}=\frac14\left(I\otimes I+\frac13\sum_{k=1}^3\sigma_k\otimes\sigma_k\right),
\qquad W_{\rho_{\mathrm{sym}}}(x,y)=\frac{1+x\cdot y}{4}\ge0.
\tag{6.19}
$$

It has eigenvalue $1/3$ on the three-dimensional symmetric subspace and zero on its complement, hence purity $1/3$. Both marginals are maximally mixed, whereas the joint state is not $I\otimes I/4$, so it is not a product. Conversely,
$\rho=[(I+(3/5)\sigma_3)/2]\otimes(I/2)$ has purity $17/50<4/9$, but its symbol $(1+(3\sqrt3/5)x_3)/4$ is negative at $x_3=-1$. Thus purity below the threshold is insufficient for positivity, already for two qubits. These examples delimit the theorem; neither is claimed as a new state construction.

## 7. Exact negative-volume minima and pure-state entanglement

The conservative general-spin lower bound can be replaced by an exact answer for any number of distinguishable qubits with the local product kernel (6.11). The result concerns the full pure-state space, including every entangled state. Its central step is a signed norm inequality, so it does not assume Wigner positivity.

### 7.1 A sharp signed inequality and its tensor equality cases

**Lemma 7.1 (one-sphere signed affine bound).** For a real affine function $f(x)=a+b\cdot x$ on $S^2$, with probability area measure,

$$
\|f\|_2^2\le\frac32\|f\|_1^2.
\tag{7.1}
$$

For $f\ne0$, equality holds exactly when $|b|=\sqrt3\,|a|$, and hence $a\ne0$.

*Proof.* Put $B=|b|$. Rotation invariance gives $\|f\|_2^2=a^2+B^2/3$. If $B\le|a|$, the function has constant sign and $\|f\|_1=|a|$, giving a ratio at most $4/3$. If $B>|a|$, direct integration with $x\cdot b/B$ uniform on $[-1,1]$ gives $\|f\|_1=(a^2+B^2)/(2B)$. With $t=|a|/B\in[0,1)$,

$$
\frac32-\frac{\|f\|_2^2}{\|f\|_1^2}
=\frac32-\frac{4(t^2+1/3)}{(1+t^2)^2}
=\frac{(3t^2-1)^2}{6(1+t^2)^2}.
\tag{7.2}
$$

This proves the assertion, including the equality condition. The zero function is immediate. ∎

**Theorem 7.2 (signed tensor bound and complete equality).** Every real function $F$ on $(S^2)^r$ that is affine in each sphere variable separately satisfies

$$
\|F\|_2\le\left(\frac32\right)^{r/2}\|F\|_1.
\tag{7.3}
$$

For $F\ne0$, equality holds exactly for

$$
F(x_1,\ldots,x_r)
=A\prod_{i=1}^r(1+\sqrt3\,u_i\cdot x_i),
\qquad A\ne0,\quad u_i\in S^2.
\tag{7.4}
$$

*Proof.* Induct on $r$. Write $x$ for the first sphere variable, $y$ for the remaining variables, and $c=\sqrt{3/2}$. Lemma 7.1 on the $x$ slices, Minkowski's integral inequality in $L^2(y)$, and induction give

$$
\begin{aligned}
\|F\|_{2,x,y}
&\le c\left\|\int |F(x,\cdot)|\,d\sigma(x)\right\|_{2,y}\\
&\le c\int\|F(x,\cdot)\|_{2,y}\,d\sigma(x)\\
&\le c^r\|F\|_{1,x,y}.
\end{aligned}
\tag{7.5}
$$

Every slice remains in the required tensor function space. Continuity and compactness ensure integrability. Products in (7.4) attain the bound because their norms multiply.

For necessity, equality in (7.5) forces equality in Minkowski. The functions $|F(x,\cdot)|$ are nonnegative vectors in the real Hilbert space $L^2(y)$. Squaring Minkowski's inequality expresses its gap as the integral over $x,x'$ of

$$
\|F(x,\cdot)\|_2\|F(x',\cdot)\|_2
-\langle |F(x,\cdot)|,|F(x',\cdot)|\rangle\ge0.
$$

A zero gap forces equality in Cauchy--Schwarz for almost every pair of nonzero slices. They are therefore positive multiples of a common vector. The absolute value of $F$ has tensor rank one almost everywhere, implying

$$
F(x,y)^2F(x',y')^2=F(x,y')^2F(x',y)^2
\tag{7.6}
$$

almost everywhere. Continuity and full support extend this identity to all points.

Choose $(x_0,y_0)$ with $F(x_0,y_0)\ne0$. The difference of squares in (7.6) factors into two real-analytic functions. The sum factor is $2F(x_0,y_0)^2$ at $(x_0,y_0)$, so is nonzero near that point. The difference factor vanishes there and, by the identity theorem on the connected real-analytic product of spheres, vanishes everywhere. Consequently

$$
F(x,y)F(x_0,y_0)=F(x,y_0)F(x_0,y).
\tag{7.7}
$$

Thus $F=f(x)g(y)$ with the required signed factors; equality of absolute values has not been used to assume an unjustified global sign. The two factor norm ratios multiply to $c^r$ and are individually bounded by their respective sharp constants. Both attain equality. Iteration and Lemma 7.1 give the local factors, each with nonzero mean. Absorbing their scales and signs into $A$ and their directions gives (7.4). ∎

The one-variable calculation, Minkowski's inequality, and analytic identity principle are standard tools. The claimed contribution is the resulting all-state physical bound together with its complete extremizer classification; we do not assign an independent global priority claim to the auxiliary norm inequality.

### 7.2 Exact all-pure minimum and the separable-state comparison

**Theorem 7.3 (exact pure-state negative volume).** For every $r$-qubit density operator, with purity $p=\operatorname{Tr}\rho^2$,

$$
\boxed{\quad
1+2\delta(\rho)\ge
\left(\frac2{\sqrt3}\right)^r\sqrt p.
\quad}
\tag{7.8}
$$

Equality in (7.8) holds exactly for pure product states. In particular,

$$
\boxed{\quad
\min_{\rho\ {\rm pure}}\delta(\rho)
=d_r:=\frac12\left[\left(\frac2{\sqrt3}\right)^r-1\right],
\quad}
\tag{7.9}
$$

and every minimizing state is a pure product.

*Proof.* Let $F=2^rW_\rho$. Normalization and self-duality give

$$
\int F\,d\sigma_X=1,\qquad
\|F\|_2^2=2^rp,\qquad
\|F\|_1=1+2\delta(\rho).
\tag{7.10}
$$

Substitution in Theorem 7.2 gives (7.8). If equality holds, (7.4) and the mean-one normalization force $A=1$. Its Wigner function is exactly the symbol of

$$
\bigotimes_{i=1}^r\frac{I+u_i\cdot\boldsymbol\sigma}{2}.
\tag{7.11}
$$

These are physical pure product states. Injectivity of the self-dual symbol shows there are no other equality states. Conversely their symbols attain (7.3). Taking $p=1$ proves (7.9). ∎

For a mixed state one may equivalently write the nonnegative bound
$\delta\ge\max\{0,[(2/\sqrt3)^r\sqrt p-1]/2\}$, but the complete equality statement above applies to the untruncated inequality (7.8).

**Corollary 7.4 (complete pure-state entanglement witness).** Every fully separable mixed state satisfies

$$
\delta(\rho)\le d_r.
\tag{7.12}
$$

For a pure state this bound is saturated precisely at full product structure. Therefore

$$
\rho\ {\rm pure}:\qquad
\rho\text{ is entangled}
\quad\Longleftrightarrow\quad
\delta(\rho)>d_r.
\tag{7.13}
$$

*Proof.* Every fully separable state is a convex combination of pure products. The $L^1$ norm of the linear symbol is convex, and all such products have norm $(2/\sqrt3)^r$. This proves (7.12); Theorem 7.3 proves the equivalence. ∎

The product-$L^1$ law and convex separability upper-bound mechanism are established in [APT18, equations (19)--(22)] and are not new claims. The new reverse bound for all pure inputs and complete equality classification make the pure-state criterion necessary as well as sufficient.

Here “entangled” means “not fully product” for a pure state. It does not mean genuine multipartite entanglement. For mixed states, exceeding $d_r$ remains only sufficient; Section 9 includes entangled, even Bell-nonlocal, mixed states with a positive symbol. No LOCC monotonicity, efficient sampling theorem, or general mixed-state separability criterion is asserted. The formula concerns independent local qubit kernels; it does not solve the coherent-state minimum conjecture for a single collective spin.

### 7.3 An exact two-qubit endpoint and an entanglement-depth bound

**Proposition 7.5 (two-qubit maximum).** Every two-qubit state has $\delta\le1/3$. Among pure states, equality holds exactly for maximally entangled states.

*Proof.* Local unitaries act as measure-preserving rotations of the two spheres, so a pure state can be put in Schmidt form
$\cos\theta|00\rangle+\sin\theta|11\rangle$, $0\le\theta\le\pi/4$.
Set $s=\sin(2\theta)$, $c=\cos(2\theta)$. The mean-one symbol is

$$
F(x,y)=1+\sqrt3c(x_3+y_3)
+3x_3y_3+3s(x_1y_1-x_2y_2).
\tag{7.14}
$$

With $z=y_3$, its affine constant in $x$ is $A(z)=1+\sqrt3cz$, and the linear coefficient has length $B(z)$ satisfying

$$
B(z)^2=9s^2(1-z^2)+(\sqrt3c+3z)^2
=3A(z)^2+6s^2.
\tag{7.15}
$$

The one-sphere integral is consequently

$$
1+2\delta
=\frac12\int_{-1}^1
\frac{2A(z)^2+3s^2}
{\sqrt3\sqrt{A(z)^2+2s^2}}\,dz.
\tag{7.16}
$$

At $s=0$, take the continuous value at any isolated zero. For $s>0$, the function
$h(u)=(2u+3s^2)/\sqrt{u+2s^2}$ is concave for $u\ge0$, since
$h''(u)=-(2u+7s^2)/[4(u+2s^2)^{5/2}]$.
Moreover, $\mathbb E A(z)^2=2-s^2$. Jensen's inequality gives

$$
1+2\delta\le\frac{4+s^2}{\sqrt{3(2+s^2)}}\le\frac53.
\tag{7.17}
$$

The last expression is strictly smaller than $5/3$ when $s<1$; its square increases with $s^2$ on $(0,1]$. At $s=0$ the value is $4/3$ by Theorem 7.3. At $s=1$, direct evaluation of (7.16) gives $5/3$. This proves the pure-state assertion. Convexity of the symbol $L^1$ norm proves the upper bound for all mixed states. ∎

For $0 \lt s<1$, a useful independent check on (7.16) is the closed formula

$$
1+2\delta
=\frac1{6c}\left[
A\sqrt{A^2+2s^2}
+s^2\operatorname{arsinh}\frac{A}{\sqrt2s}
\right]_{1-\sqrt3c}^{1+\sqrt3c}.
\tag{7.18}
$$

**Corollary 7.6 (sharp bound for two-producible states).** A two-producible state is a convex combination of products of blocks of at most two qubits; the partitions may vary between mixture terms. Every such $r$-qubit state satisfies

$$
1+2\delta(\rho)\le
\left(\frac53\right)^{\lfloor r/2\rfloor}
\left(\frac2{\sqrt3}\right)^{r-2\lfloor r/2\rfloor}.
\tag{7.19}
$$

The constant is attained by a product of maximally entangled pairs and, for odd $r$, one pure singleton. Exceeding it certifies entanglement depth at least three.

*Proof.* The $L^1$ norm multiplies over tensor-product blocks. Proposition 7.5 bounds each pair by $5/3$, and convexity plus the one-qubit value bounds each singleton by $2/\sqrt3$. Pairing two singleton bounds increases the bound because $5/3>4/3$. Convexity handles mixed states and varying partitions, while the stated block products attain equality. ∎

The literature search did not establish a priority claim for the two-qubit upper endpoint or its two-producible consequence. They are included with complete proofs and are not used as independent evidence for the principal novelty of Theorem 7.3.

## 8. Sharp spin-1 positivity and quantitative product rigidity

The nonnegative-symbol purity boundary admits a sharp extension from qubits to arbitrary products of qubits and spin-1 systems. The local spin-1 optimum is physically attainable and has a unique form up to rotations. More generally, a state near the sharp purity boundary must be close to a product of local maximizers. The squared Hilbert–Schmidt distance is bounded by the purity deficit with a coefficient linear in the number of sites.

The argument has two parts. First, the exact sum-of-squares representation of a nonnegative spherical quadratic reduces the spin-1 calculation to affine squares. Second, a tensor stability theorem propagates local deficit estimates through the entire cone of pointwise nonnegative functions. In particular, it does not require the global symbol to be a positive mixture of product symbols. All spin statements in this section use the canonical kernel fixed in Section 2, including its quadrupole sign.

### 8.1. Nonnegative spherical quadratics

We first give the precise sphere-constrained form of the classical trust-region or S-lemma argument [PT07].

**Lemma 8.1.** Let

$$
q(x)=c+2b^Tx+x^TAx,
\qquad A=A^T\in\mathbb R^{3\times3}.
\tag{8.1}
$$

If $q(x)\ge0$ for every $x\in S^2$, then $q$ agrees on $S^2$ with a sum of at most four squares of real affine functions. Equivalently, there is a real number $\lambda$ such that

$$
\begin{pmatrix}
c+\lambda&b^T\\
b&A-\lambda I
\end{pmatrix}\succeq0.
\tag{8.2}
$$

**Proof.** Diagonalize $A$ and denote its eigenvalues by $a_k$, with smallest eigenvalue $a_{\min}$. For $\lambda \lt a_{\min}$ define

$$
g(\lambda)=\sum_k\frac{b_k^2}{(a_k-\lambda)^2}.
$$

This function is continuous and nondecreasing, tends to zero as $\lambda\to-\infty$, and is strictly increasing unless $b=0$. If its limit as $\lambda\uparrow a_{\min}$ exceeds one, choose the unique $\lambda \lt a_{\min}$ with $g(\lambda)=1$ and set $y=-(A-\lambda I)^{-1}b$. Then $|y|=1$.

If that limit is at most one, $b$ has zero projection onto the minimum-eigenvalue eigenspace. Set $\lambda=a_{\min}$ and $y=-(A-\lambda I)^\dagger b$, where the dagger denotes the Moore–Penrose inverse. Then $|y|\le1$. This branch includes equality at the endpoint and the case $b=0$.

In both branches $B=A-\lambda I\succeq0$ and $By=-b$. Choose $z\in\ker B$, orthogonal to $y$, so that $|y+z|=1$. In the first branch take $z=0$. In the endpoint branch $y$ belongs to the range of $B$, so an appropriate multiple of a unit minimum-eigenvalue vector supplies $z$. Set $x_*=y+z$. Completing the square gives the polynomial identity

$$
q(x)=(x-y)^TB(x-y)+m+\lambda(|x|^2-1),
\qquad
m=c+\lambda-y^TBy=q(x_*).
\tag{8.3}
$$

Because $x_*\in S^2$, $m\ge0$. On the sphere the first term is a sum of at most three affine squares, and $m$ is one further constant square. This proves the asserted representation, including a function that vanishes identically on the sphere.

The same identity shows that the matrix in (8.2) is positive semidefinite: its quadratic form on $(t,x)$ is $(x-ty)^TB(x-ty)+mt^2$. Conversely, evaluation of any matrix satisfying (8.2) on $(1,x)$ with $|x|=1$ gives $q(x)\ge0$. ∎

### 8.2. The sharp quadratic norm bound

Let $\sigma$ denote probability area measure on $S^2$, and write $\mathbb E$ for integration against $\sigma$.

**Proposition 8.2.** Every nonnegative real spherical polynomial $q$ of degree at most two satisfies

$$
\mathbb E q^2\le\frac94(\mathbb E q)^2.
\tag{8.4}
$$

For nonzero $q$, equality holds exactly when

$$
q(x)=A\left(u\cdot x+\frac1{\sqrt5}\right)^2,
\qquad A>0,\quad u\in S^2.
\tag{8.5}
$$

**Proof.** For $z=u\cdot x$, rotational invariance gives

$$
\mathbb Ez=\mathbb Ez^3=0,
\qquad \mathbb Ez^2=\frac13,
\qquad \mathbb Ez^4=\frac15.
$$

Every nonzero affine square, normalized to have mean one, can be written as

$$
h_s(x)=1+\ell(s)z+s\left(z^2-\frac13\right),
\qquad
\ell(s)=2\sqrt{s(1-s/3)},\qquad 0\le s\le3.
\tag{8.6}
$$

Indeed, for an affine function $\alpha+\beta z$, division of its square by $\alpha^2+\beta^2/3$ gives $s=\beta^2/(\alpha^2+\beta^2/3)$. The sign of its linear coefficient is absorbed into $u$. If the affine constant is zero, either orientation works; if the linear part is zero, choose any direction and take $s=0$.

The constant, linear and centered quadratic terms in (8.6) are mutually orthogonal. Their moments give

$$
\|h_s\|_2^2
=1+\frac43s-\frac{16}{45}s^2
=\frac94-\frac{16}{45}\left(s-\frac{15}{8}\right)^2.
\tag{8.7}
$$

The unique maximizing parameter is $s_*=15/8$. The corresponding functions are

$$
g_u(x)=\frac{15}{8}\left(u\cdot x+\frac1{\sqrt5}\right)^2,
\qquad
\mathbb Eg_u=1,\qquad \|g_u\|_2^2=\frac94.
\tag{8.8}
$$

Now normalize a nonzero nonnegative quadratic so that $\mathbb Eq=1$. By Lemma 8.1, after discarding zero affine squares it has a finite representation $q=\sum_k w_kh_k$, where $w_k>0$, $\sum_k w_k=1$, and every $h_k$ is a mean-one affine square. Hence

$$
\|q\|_2^2\le\sum_k w_k\|h_k\|_2^2\le\frac94.
\tag{8.9}
$$

If equality holds, (8.7) makes every $h_k$ an optimizer $g_{u_k}$. Equality in the first inequality of (8.9) is equivalent to

$$
\sum_k w_k\|h_k-q\|_2^2=0.
$$

Thus every $h_k$ equals $q$ in $L^2$ and, by continuity and full support, everywhere on the sphere. Therefore $q=g_u$ for one direction $u$. Undoing the normalization yields (8.5), and (8.8) proves the converse. The zero function satisfies (8.4) separately. ∎

### 8.3. A quantitative quadratic deficit estimate

**Proposition 8.3.** For every mean-one nonnegative spherical quadratic $q$, some $u\in S^2$ satisfies

$$
\|q-g_u\|_2^2
\le\frac{10}{3}\left(\frac94-\|q\|_2^2\right).
\tag{8.10}
$$

The estimate holds for the entire nonnegative quadratic cone; its coefficient is not asserted to be optimal.

**Proof.** First compare a normalized affine square $h_s$ with the optimizer $g_u$ having the same direction. Orthogonality gives

$$
\|h_s-g_u\|_2^2
=\frac{[\ell(s)-\ell(15/8)]^2}{3}
+\frac4{45}\left(s-\frac{15}{8}\right)^2.
\tag{8.11}
$$

Here $\ell(15/8)=3\sqrt5/4$, and rationalizing the difference yields

$$
\ell(s)-\ell(15/8)
=\frac{(s-15/8)(3/2-4s/3)}{\ell(s)+3\sqrt5/4}.
$$

For $0\le s\le3$, the numerator coefficient has absolute value at most $5/2$ and the denominator is at least $3\sqrt5/4$. Therefore

$$
|\ell(s)-\ell(15/8)|
\le\frac{10}{3\sqrt5}\left|s-\frac{15}{8}\right|,
$$

and (8.7), (8.11) imply

$$
\|h_s-g_u\|_2^2
\le\frac{112}{135}\left(s-\frac{15}{8}\right)^2
=\frac73\left(\frac94-\|h_s\|_2^2\right).
\tag{8.12}
$$

The same-direction comparison attains the ratio $7/3$ at $s=3$; this does not establish optimality of the final cone stability constant.

Use the finite positive mixture $q=\sum_k w_kh_k$ from Proposition 8.2 and put

$$
A=\sum_k w_k\left(\frac94-\|h_k\|_2^2\right),
\qquad
V=\sum_k w_k\|h_k-q\|_2^2.
$$

The variance identity gives

$$
A+V=\frac94-\|q\|_2^2.
\tag{8.13}
$$

Choose for each $h_k$ the same-direction optimizer $g_k$ from (8.12). Minkowski's inequality in the Hilbert space $L^2(\{k\},w;L^2(S^2))$, followed by Cauchy–Schwarz, gives

$$
\begin{aligned}
\left(\sum_k w_k\|q-g_k\|_2^2\right)^{1/2}
&\le\sqrt V+\sqrt{\frac73A},\\
\sum_k w_k\|q-g_k\|_2^2
&\le\frac{10}{3}(A+V).
\end{aligned}
\tag{8.14}
$$

At least one $g_k$ obeys (8.10). The representation is finite, so no measurable choice of directions is required. ∎

### 8.4. Stability on the full nonnegative tensor cone

The following theorem isolates the tensor step. Its positivity hypothesis is imposed on the global function itself, without assuming a representation by positive product functions.

**Theorem 8.4.** For $i=1,\ldots,r$, let $X_i$ be a topological space with a full-support probability measure $\mu_i$, and let $V_i\subset C(X_i)\cap L^2(\mu_i)$ be a finite-dimensional real function space containing the constants. Suppose there are constants $C_i\ge1$, $K_i\ge0$ and families $\mathcal M_i$ of nonnegative mean-one functions in $V_i$ such that

$$
\begin{aligned}
&\|f\|_2^2\le C_i(\mathbb E_i f)^2
&&\text{for every nonnegative }f\in V_i,\\
&\|g\|_2^2=C_i
&&\text{for every }g\in\mathcal M_i,\\
&\exists g\in\mathcal M_i:\quad \|f-g\|_2^2
\le K_i(C_i-\|f\|_2^2)
&&\text{for every nonnegative }f\in V_i\text{ with }\mathbb E_i f=1,
\end{aligned}
\tag{8.15}
$$

Let $F\in\bigotimes_iV_i$ be pointwise nonnegative with global mean one. With $C=\prod_iC_i$ and $\Delta=C-\|F\|_2^2$, one has $\Delta\ge0$, and there are $g_i\in\mathcal M_i$ such that

$$
\left\|F-\prod_i g_i\right\|_2^2
\le\left[\sum_i(K_i+1)-1\right]\Delta.
\tag{8.16}
$$

**Proof.** Every function in the algebraic tensor product has finite $L^2$ norm. Integration of a coordinate leaves a function in the remaining tensor product. Applying the first inequality of (8.15) successively to nonnegative slices proves $\|F\|_2^2\le C$.

Let $f_i=\mathbb E_{-i}F$ and $\delta_i=C_i-\|f_i\|_2^2$. Each $f_i$ is nonnegative, has mean one, and belongs to $V_i$. Apply the local norm bounds in all coordinates other than $i$ before integrating coordinate $i$. This gives

$$
\|F\|_2^2\le\frac C{C_i}\|f_i\|_2^2,
\qquad
0\le\delta_i\le\frac{C_i}{C}\Delta.
\tag{8.17}
$$

Choose $g_i\in\mathcal M_i$ satisfying the local deficit estimate. On the appropriate coordinate of a tensor function, define

$$
E_i h=\int h\,d\mu_i,
\qquad
T_i h=\int g_i h\,d\mu_i,
\qquad
D_i=C_iE_i-T_i.
\tag{8.18}
$$

Each operator preserves nonnegativity within the remaining tensor-function space. This is immediate for $E_i$ and $T_i$. For $D_i$, each nonnegative local slice $h\in V_i$ satisfies

$$
0\le T_i h
\le\|g_i\|_2\|h\|_2
\le C_iE_i h.
\tag{8.19}
$$

The middle inequality is Cauchy–Schwarz, and the last is the first hypothesis in (8.15). Thus the preservation statement concerns precisely the local nonnegative function cone required here. Application of these linear functionals also preserves membership in the tensor space on the remaining coordinates. Operators acting on different coordinates commute.

Define

$$
\begin{aligned}
d_i=D_if_i
&=C_i-\langle f_i,g_i\rangle\\
&=\frac12\bigl(\|f_i-g_i\|_2^2+\delta_i\bigr)
\le\frac{K_i+1}{2}\delta_i.
\end{aligned}
\tag{8.20}
$$

The telescoping identity for products of commuting coordinate operators yields

$$
\begin{aligned}
H&:=C-\left\langle F,\prod_i g_i\right\rangle\\
&=\sum_i
\left(\prod_{k \lt i}C_kE_k\right)
D_i
\left(\prod_{k>i}T_k\right)F.
\end{aligned}
\tag{8.21}
$$

Every summand is nonnegative. To bound the summand with index $i$, commute $D_i$ to act first; its result is a nonnegative function in the remaining tensor space. Repeatedly use (8.19) to replace each later $T_k$ by its upper bound $C_kE_k$. The resulting upper bound is $(C/C_i)D_i\mathbb E_{-i}F=(C/C_i)d_i$. Combining this observation with (8.17) and (8.20) gives

$$
0\le H\le\sum_i\frac C{C_i}d_i
\le\frac\Delta2\sum_i(K_i+1).
\tag{8.22}
$$

Finally, the squared norm of $\prod_i g_i$ is $C$. Therefore

$$
\left\|F-\prod_i g_i\right\|_2^2
=(C-\Delta)+C-2(C-H)=2H-\Delta.
\tag{8.23}
$$

Substitution of (8.22) proves (8.16). If $\Delta=0$, the distance vanishes; full support and continuity give equality of the functions everywhere. ∎

For qubit sites the required local space consists of affine functions on $S^2$. A nonnegative mean-one affine function is $f(x)=1+v\cdot x$ with $|v|\le1$, and its sharp constant is $C_i=4/3$. Choose $u=v/|v|$ when $v\ne0$, and any unit $u$ otherwise. Then

$$
\|f-(1+u\cdot x)\|_2^2
=\frac{(1-|v|)^2}{3}
\le\frac{1-|v|^2}{3}
=\frac43-\|f\|_2^2.
\tag{8.24}
$$

Thus the local qubit coefficient is $K_i=1$. Propositions 8.2–8.3 give $C_i=9/4$ and $K_i=10/3$ for a quadratic spin-1 site. The tensor coefficient is consequently linear in the number of each type of site.

### 8.5. The exact spin-1 physical boundary

Let $P_u=|1,u\rangle\langle1,u|$ be the spin-1 coherent projector. The canonical coherent-state expansion [D21], with $z=u\cdot x$, gives

$$
W_{P_u}(x)=\frac13+\frac z{\sqrt2}
+\frac{\sqrt{10}}6P_2(z),
\qquad P_2(z)=\frac{3z^2-1}{2}.
\tag{8.25}
$$

Because $\operatorname{Tr}\Delta_1(x)=1$, the identity operator has symbol one. Define

$$
\rho_u^*=\frac{4-\sqrt{10}}{12}I_3
+\frac{\sqrt{10}}4P_u.
\tag{8.26}
$$

This is a trace-one positive definite operator with eigenvalues

$$
\frac{2+\sqrt{10}}6,
\qquad
\frac{4-\sqrt{10}}{12},
\qquad
\frac{4-\sqrt{10}}{12}.
\tag{8.27}
$$

Its symbol and purity are

$$
W_{\rho_u^*}(x)=\frac58\left(z+\frac1{\sqrt5}\right)^2,
\qquad 3W_{\rho_u^*}=g_u,
\qquad \operatorname{Tr}[(\rho_u^*)^2]=\frac34.
\tag{8.28}
$$

**Theorem 8.5.** Every spin-1 density operator with a nonnegative canonical Wigner function satisfies $\operatorname{Tr}(\rho^2)\le3/4$. Equality holds exactly for the states (8.26). For every such $\rho$, some $u\in S^2$ also satisfies

$$
\begin{aligned}
\|\rho-\rho_u^*\|_{\mathrm{HS}}^2
&\le\frac{10}{3}\left(\frac34-\operatorname{Tr}(\rho^2)\right),\\
\frac12\|\rho-\rho_u^*\|_1
&\le\sqrt{\frac52\left(\frac34-\operatorname{Tr}(\rho^2)\right)}.
\end{aligned}
\tag{8.29}
$$

**Proof.** Set $F=3W_\rho$. It is a nonnegative spherical polynomial of degree at most two. Normalization and traciality give

$$
\mathbb EF=1,
\qquad \|F\|_2^2=3\operatorname{Tr}(\rho^2).
\tag{8.30}
$$

Proposition 8.2 therefore gives the upper bound $3/4$. Its equality statement forces $F=g_u$; injectivity of the self-dual symbol and (8.28) then force $\rho=\rho_u^*$. Conversely, (8.26)–(8.28) exhibit physical equality states, so the polynomial optimum is attained within the density operators.

Proposition 8.3 and traciality give

$$
\|\rho-\rho_u^*\|_{\mathrm{HS}}^2
=\frac13\|3W_\rho-g_u\|_2^2
\le\frac{10}{3}\left(\frac34-\operatorname{Tr}(\rho^2)\right).
$$

The trace-distance estimate follows from $\|A\|_1\le\sqrt3\|A\|_{\mathrm{HS}}$ on the three-dimensional Hilbert space. ∎

### 8.6. Heterogeneous spin products and all maximizers

Consider $a$ qubit sites and $b$ spin-1 sites, with $r=a+b\ge1$, their independent local sphere variables, and the canonical product kernel. Set

$$
D=2^a3^b,
\qquad C=\left(\frac43\right)^a\left(\frac94\right)^b,
\qquad
p_*:=\frac CD=\left(\frac23\right)^a\left(\frac34\right)^b.
\tag{8.31}
$$

**Theorem 8.6.** For every density operator $\rho$ on this tensor-product Hilbert space whose canonical Wigner function is pointwise nonnegative,

$$
\operatorname{Tr}(\rho^2)\le p_*.
\tag{8.32}
$$

All equality states are precisely the products

$$
\sigma_*
=\bigotimes_{i\,\mathrm{qubit}}
\frac{I_2+u_i\cdot\boldsymbol\sigma/\sqrt3}{2}
\ \otimes\!
\bigotimes_{j\,\mathrm{spin}\,1}
\left[
\frac{4-\sqrt{10}}{12}I_3
+\frac{\sqrt{10}}4|1,u_j\rangle\langle1,u_j|
\right],
\qquad u_i,u_j\in S^2.
\tag{8.33}
$$

For every admissible $\rho$, there is a state $\sigma_*$ in this family such that

$$
\|\rho-\sigma_*\|_{\mathrm{HS}}^2
\le\left(2a+\frac{13}{3}b-1\right)
\left[p_*-\operatorname{Tr}(\rho^2)\right].
\tag{8.34}
$$

**Proof.** Put $F=DW_\rho$ and integrate against product probability area measure. Then $\mathbb EF=1$, $\|F\|_2^2=D\operatorname{Tr}(\rho^2)$, and $F$ is affine or quadratic in each variable according to its site. The local norm inequalities give $\|F\|_2^2\le C$, proving (8.32).

Apply Theorem 8.4 with the qubit input (8.24) and the spin-1 input of Propositions 8.2–8.3. The chosen local optimizing functions are exactly the dimension-normalized symbols of the physical factors in (8.33). Their product $G$ is therefore $DW_{\sigma_*}$. Traciality gives both normalization identities

$$
\begin{aligned}
\|F-G\|_2^2&=D\|\rho-\sigma_*\|_{\mathrm{HS}}^2,\\
C-\|F\|_2^2&=D\left[p_*-\operatorname{Tr}(\rho^2)\right].
\end{aligned}
\tag{8.35}
$$

The dimension factor cancels. Since $K_i+1=2$ for each qubit and $K_i+1=13/3$ for each spin-1 site, (8.16) becomes (8.34).

If the purity equals $p_*$, the right side of (8.34) vanishes, so $\rho=\sigma_*$. Conversely, each state in (8.33) has a nonnegative product symbol and purity $p_*$. Every local factor is positive definite, proving physical attainability and full rank of all maximizing states. This proves the complete equality classification without requiring a global decomposition into nonnegative product functions. ∎

When $b=0$, the sharp purity boundary agrees with the qubit result in Section 6 and (8.34) adds its quantitative product rigidity. When $a=0,b=1$, the coefficient is $10/3$, recovering the local spin-1 estimate. The argument covers arbitrary correlated and entangled input states satisfying the stated symbol condition.

### 8.7. Marginals, entropy and relative proximity

Partial integration of a nonnegative product symbol preserves nonnegativity. For every nonempty subsystem $A$ containing $a_A$ qubits and $b_A$ spin-1 sites, Theorem 8.6 therefore gives

$$
\operatorname{Tr}(\rho_A^2)
\le\left(\frac23\right)^{a_A}\left(\frac34\right)^{b_A}.
\tag{8.36}
$$

In particular, for the second Rényi entropy $S_2(\rho)=-\log\operatorname{Tr}(\rho^2)$,

$$
S_2(\rho)\ge a\log\frac32+b\log\frac43,
\tag{8.37}
$$

with equality exactly for (8.33).

Write $K_{a,b}=2a+13b/3-1$. If $\operatorname{Tr}(\rho^2)\ge(1-\varepsilon)p_*$ for $0\le\varepsilon\le1$, the same choice of $\sigma_*$ in (8.34) satisfies

$$
\frac{\|\rho-\sigma_*\|_{\mathrm{HS}}}{\|\sigma_*\|_{\mathrm{HS}}}
\le\sqrt{K_{a,b}\varepsilon},
\qquad \|\sigma_*\|_{\mathrm{HS}}^2=p_*.
\tag{8.38}
$$

This estimate holds down to zero deficit and requires no smallness assumption beyond the displayed range. For every observable $O$,

$$
|\operatorname{Tr}[O(\rho-\sigma_*)]|
\le\|O\|_{\mathrm{HS}}
\sqrt{K_{a,b}\left[p_*-\operatorname{Tr}(\rho^2)\right]}.
\tag{8.39}
$$

The corresponding conversion to trace distance contains the Hilbert-space dimension:

$$
\frac12\|\rho-\sigma_*\|_1
\le\frac12
\sqrt{D K_{a,b}\left[p_*-\operatorname{Tr}(\rho^2)\right]}.
\tag{8.40}
$$

Thus the linear dependence on site count in (8.34) is a Hilbert–Schmidt stability statement. It does not imply a dimension-independent trace-distance estimate. The local constants and their tensor combination are explicit valid coefficients; their optimality is not claimed.

## 9. Exact local-noise boundaries for positive spherical symbols

The preceding pure-state minimum does not make positivity of a mixed-state Wigner function a certificate of classical correlations. We now characterize exactly the local channels that remove all entanglement, or all Bell nonlocality, from the physical states with a nonnegative product-sphere qubit symbol, uniformly over the particle number. For the canonical representation, the sharp additional depolarizing visibilities are respectively $1/\sqrt3$ and $\sqrt3/2$. The interval between them contains entangled states whose correlations are local for every finite, single-round local POVM experiment. Above the second endpoint, Bell-nonlocal states can have a strictly positive Wigner function.

The converse proofs use two substantial existing results: the qubit-input theorem that complete entanglement annihilation under every tensor power forces an entanglement-breaking channel [CMW19, Lemma 3.2], and the theorem that every incompatible finite family of qubit measurements produces multipartite Bell nonlocality [PGQ25, Theorem 3]. The sharp all-POVM compatibility threshold of depolarization is also an established input [R24]. The new transfer below controls the full physical positive-symbol set, including states beyond the positive-semidefinite noisy-state image to which those source theorems directly apply.

### 9.1 The physical cone and an auxiliary kernel parameter

For real $s$, write

$$
\mathcal D_s(X)=sX+(1-s)\operatorname{Tr}(X)I_2/2.
\tag{9.1}
$$

This is a self-adjoint linear map for the Hilbert–Schmidt pairing, with $\mathcal D_s\mathcal D_t=\mathcal D_{st}$. It is CPTP for $0\le s\le1$ and has linear inverse $\mathcal D_{1/s}$ when $s\ne0$.

Let $P_x=(I+x\cdot\boldsymbol\sigma)/2$ for $x\in S^2$. It is useful to state the transfer for the family

$$
K_a(x)=\frac{I+a\,x\cdot\boldsymbol\sigma}{2},\qquad
W^{(a)}_\rho(x)=\operatorname{Tr}\left[\rho\bigotimes_{i=1}^rK_a(x_i)\right],
\qquad a\ge1.
\tag{9.2}
$$

Denote by $\mathcal P_a(r)$ the set of physical $r$-qubit density operators with $W^{(a)}_\rho\ge0$ everywhere. The canonical self-dual Wigner representation is $a=\sqrt3$. The auxiliary kernels at other $a$ are not claimed to be self-dual Wigner kernels.

A Hermitian operator $A$ is fully block positive if $\operatorname{Tr}[A(B_1\otimes\cdots\otimes B_r)]\ge0$ for every collection $B_i\ge0$. Equivalently, this need only be tested on rank-one local projectors. The cone is the dual of the fully separable positive cone and can contain operators that are not positive semidefinite.

**Proposition 9.1 (exact physical cone representation).** Put $q=1/a$. Then

$$
\mathcal P_a(r)=\left\{\mathcal D_q^{\otimes r}(A):
A=A^\dagger,\ \operatorname{Tr}A=1,\ A\text{ fully block positive},\quad
\mathcal D_q^{\otimes r}(A)\ge0\right\}.
\tag{9.3}
$$

In particular, $\mathcal D_q^{\otimes r}(\sigma)\in\mathcal P_a(r)$ for every $r$-qubit density operator $\sigma$.

*Proof.* Set $A=\mathcal D_a^{\otimes r}(\rho)$. Self-adjointness and $K_a(x)=\mathcal D_a(P_x)$ give

$$
W^{(a)}_\rho(x)=\operatorname{Tr}\left[A\bigotimes_iP_{x_i}\right].
\tag{9.4}
$$

Every rank-one qubit projector is some $P_x$. Thus symbol positivity is exactly block positivity of $A$, trace is preserved, and $\rho=\mathcal D_q^{\otimes r}(A)$. The physical positivity condition in (9.3) is retained separately. If $A=\sigma\ge0$, block positivity holds and the CPTP map $\mathcal D_q^{\otimes r}$ supplies physical positivity of the image. ∎

The extra positivity condition in (9.3) is material. In more than two qubits, the image of an arbitrary fully block-positive operator under $\mathcal D_{1/\sqrt3}^{\otimes r}$ need not be positive semidefinite. None of the following proofs assumes otherwise.

### 9.2 A complete channel criterion for removing entanglement

Let $\Phi:M_2\to M_d$ be any CPTP map, with arbitrary finite output dimension $d$ and no unitality assumption, and set $\Psi=\Phi\circ\mathcal D_q$. A finite-dimensional channel is entanglement breaking (EB) exactly when it has a measure-and-prepare representation [HSR03]

$$
\Psi(X)=\sum_\lambda\operatorname{Tr}(E_\lambda X)\tau_\lambda,
\qquad E_\lambda\ge0,\quad\sum_\lambda E_\lambda=I_2,
\quad\tau_\lambda\in\mathcal D(\mathbb C^d).
\tag{9.5}
$$

**Theorem 9.2 (universal separability criterion).** The following conditions are equivalent:

1. For every $r\ge1$ and $\rho\in\mathcal P_a(r)$, the output $\Phi^{\otimes r}(\rho)$ is fully separable across its $r$ output factors.
2. $\Phi\circ\mathcal D_{1/a}$ is entanglement breaking.

*Proof of sufficiency.* Write $\rho=\mathcal D_q^{\otimes r}(A)$ using Proposition 9.1 and apply (9.5) by linearity. Then

$$
\Phi^{\otimes r}(\rho)
=\sum_{\boldsymbol\lambda}w(\boldsymbol\lambda)
\tau_{\lambda_1}\otimes\cdots\otimes\tau_{\lambda_r},
\qquad
w(\boldsymbol\lambda)=\operatorname{Tr}\left[A\bigotimes_iE_{\lambda_i}\right].
\tag{9.6}
$$

Block positivity makes every weight nonnegative, and the POVM normalization gives $\sum_{\boldsymbol\lambda}w(\boldsymbol\lambda)=\operatorname{Tr}A=1$. Thus (9.6) is a physical separable decomposition even when $A$ is not positive semidefinite.

*Proof of necessity.* For every density operator $\sigma$, Proposition 9.1 places $\mathcal D_q^{\otimes r}(\sigma)$ in $\mathcal P_a(r)$. The assumed property therefore makes $\Psi^{\otimes r}(\sigma)$ fully separable for every $r$ and $\sigma$. Positive scaling extends this statement to all positive semidefinite inputs. The map $\Psi$ is completely positive and has qubit input. The qubit-input case of [CMW19, Lemma 3.2] implies that $\Psi$ is EB. ∎

Sufficiency also permits a different map $\Phi_i$ at each site if each $\Phi_i\circ\mathcal D_q$ is EB. Necessity is an all-particle-number statement about the repeated channel; it is not a criterion at a prescribed finite $r$.

For a unital qubit channel with real Bloch matrix $M$, Theorem 9.2 becomes the explicit condition

$$
\boxed{\ \|M\|_*\le a,\ }
\tag{9.7}
$$

where $\|M\|_*$ is the sum of its three singular values. Indeed, the Bloch matrix of $\Psi$ is $qM$. Bring $M$ to signed diagonal form by input and output rotations. Its Choi state is Bell diagonal, and positivity together with positivity after partial transposition is equivalent to $q\sum_i|\lambda_i|\le1$. The two-qubit PPT criterion [HHH96] and the Choi characterization of EB [HSR03] give (9.7). For the canonical symbol the right-hand side is $\sqrt3$.

### 9.3 A complete channel criterion for Bell locality

We consider Bell experiments with finitely many settings and outcomes, one local POVM per party per trial, and one qubit input per party before the channel. Different parties may use different POVM families. The conclusion does not include postselected sequential filtering or the grouping of several physical qubits into one measuring party.

A channel $\Psi:M_2\to M_d$ is incompatibility breaking (IB) if every finite collection of output POVMs has jointly measurable images under $\Psi^*$. Equivalently, for any such family $M_{b|y}$ there is a qubit mother POVM $\{G_\lambda\}$ and conditional probabilities such that

$$
\Psi^*(M_{b|y})=\sum_\lambda p(b|y,\lambda)G_\lambda,
\qquad G_\lambda\ge0,\quad\sum_\lambda G_\lambda=I_2.
\tag{9.8}
$$

A finite-outcome mother POVM suffices for a finite family, by using deterministic outcome assignments.

**Theorem 9.3 (universal Bell-locality criterion).** The following conditions are equivalent:

1. For every $r\ge1$, every $\rho\in\mathcal P_a(r)$, and arbitrary finite local output POVM families, every behavior of $\Phi^{\otimes r}(\rho)$ is Bell local.
2. $\Phi\circ\mathcal D_{1/a}$ is incompatibility breaking.

*Proof of sufficiency.* For the family at site $i$, choose a mother POVM $G^{(i)}_{\lambda_i}$ and responses $p_i(b_i|y_i,\lambda_i)$ as in (9.8). With $A$ from Proposition 9.1, the behavior is

$$
\begin{aligned}
\Pr(\boldsymbol b\mid\boldsymbol y)
&=\operatorname{Tr}\left[A\bigotimes_i\Psi^*(M^{(i)}_{b_i|y_i})\right]\\
&=\sum_{\boldsymbol\lambda}w(\boldsymbol\lambda)
\prod_i p_i(b_i|y_i,\lambda_i),\\
w(\boldsymbol\lambda)&=\operatorname{Tr}\left[A\bigotimes_iG^{(i)}_{\lambda_i}\right].
\end{aligned}
\tag{9.9}
$$

The weights are nonnegative by block positivity and sum to one. Taking the tuple $\boldsymbol\lambda$ as the shared hidden variable proves locality.

*Proof of necessity.* If $\Psi$ is not IB, a finite output family $M$ has incompatible qubit images $N_{b|y}=\Psi^*(M_{b|y})$. By [PGQ25, Theorem 3], there are some finite $r$ and an $r$-qubit density operator $\sigma$ such that using $N$ at every site gives a Bell-nonlocal behavior. The physical state $\rho=\mathcal D_q^{\otimes r}(\sigma)$ lies in $\mathcal P_a(r)$. Measuring its output under $\Phi^{\otimes r}$ with $M$ gives exactly that nonlocal behavior, contradicting 1. ∎

The sufficient argument again permits different local channels whose corresponding compositions are IB. The cited converse is existential: neither it nor the transfer supplies a general particle bound, an explicit state family, or a named Bell inequality for every channel. These constructive questions are explicitly left open in [PGQ25].

### 9.4 Sharp depolarizing thresholds and strictly positive witnesses

Take $\Phi=\mathcal D_t$, $0\le t\le1$, so $\Psi=\mathcal D_{t/a}$. A qubit depolarizing channel $\mathcal D_s$ is EB exactly when $s\le1/3$: its normalized Choi state is

$$
J_s=s|\Omega\rangle\langle\Omega|+(1-s)I_4/4,
\qquad |\Omega\rangle=(|00\rangle+|11\rangle)/\sqrt2,
\tag{9.10}
$$

and its partial transpose has minimum eigenvalue $(1-3s)/4$. The exact all-POVM IB threshold is $s\le1/2$ [R24]. Thus Theorems 9.2–9.3 give

$$
\begin{aligned}
&\mathcal D_t^{\otimes r}(\rho)\text{ is fully separable for every }r,\rho\in\mathcal P_a(r)
&&\Longleftrightarrow\quad t\le a/3,\\
&\mathcal D_t^{\otimes r}(\rho)\text{ is Bell local for every }r,\rho\in\mathcal P_a(r)
&&\Longleftrightarrow\quad t\le a/2.
\end{aligned}
\tag{9.11}
$$

The second line quantifies over all finite local POVM families. The parameter domain is $0\le t\le1$; if an endpoint exceeds one, its property holds throughout that domain.

**Corollary 9.4 (canonical three-regime classification).** For $a=\sqrt3$, additional local depolarization has the following exact behavior, uniformly over the number of qubits:

| Visibility $t$ | Conclusion for all physical Wigner-positive inputs |
|---|---|
| $0\le t\le1/\sqrt3$ | Every output is fully separable. |
| $1/\sqrt3 \lt t\le\sqrt3/2$ | Every output is Bell local for all finite local POVMs, and some finite-size output is entangled. |
| $\sqrt3/2 \lt t\le1$ | Some finite-size output is Bell nonlocal. |

The thresholds include their universal endpoints. An existence assertion above an endpoint does not say that every state there is entangled or nonlocal.

The output remains symbol positive throughout $0\le t\le1$. In a coordinate where a separately affine symbol is $F(x,y)$, the local channel acts as

$$
F(x,y)\longmapsto tF(x,y)+(1-t)\int_{S^2}F(z,y)\,d\sigma(z).
\tag{9.12}
$$

This preserves pointwise nonnegativity, and iteration treats all coordinates. Thus the entangled and Bell-nonlocal outputs in Corollary 9.4 themselves have nonnegative canonical Wigner functions.

The witnesses can be chosen in the interior of the physical positive-symbol set. If $\rho$ is any witness, then

$$
\rho_\varepsilon=(1-\varepsilon)\rho+\varepsilon I_{2^r}/2^r
\tag{9.13}
$$

has minimum eigenvalue and minimum symbol at least $\varepsilon/2^r$. For sufficiently small $\varepsilon>0$, an output outside the closed separable set remains outside, and a strict violation of a fixed finite Bell inequality persists. This proves full rank and strict positivity without requiring a boundary witness.

In the Bell regime $t>a/2$, choose $1/(2t) \lt s<1/a$. By [PGQ25, Corollary 7], some state $\sigma$ makes $\mathcal D_{ts}^{\otimes r}(\sigma)$ Bell nonlocal. Set $\rho=\mathcal D_s^{\otimes r}(\sigma)$. The local matrices in its symbol have minimum eigenvalue $(1-as)/2$, so

$$
W^{(a)}_\rho(x)\ge\left(\frac{1-as}{2}\right)^r>0,
\qquad
\rho\ge\left(\frac{1-s}{2}\right)^rI_{2^r}.
\tag{9.14}
$$

Its noisy output is the required nonlocal state. This gives a positivity margin for the existential witness, not a constructive formula for $\sigma$ or $r$.

At $t=1$, the auxiliary parameter family also has exact all-particle boundaries: every $\mathcal P_a$ state is fully separable exactly when $a\ge3$; every such state is Bell local exactly when $a\ge2$. Therefore $2\le a<3$ admits entangled but universally Bell-local positive-symbol states, while $1\le a<2$ admits Bell-nonlocal ones. The canonical value $a=\sqrt3$ lies in the latter regime.

### 9.5 The two-qubit threshold and a three-qubit example

The fixed two-qubit boundary is different from the uniform all-particle one. The noisy-state threshold and the GHZ calculation used here are established in [MZ10, §4.1–4.2]; the following argument transfers them to the full positive-symbol cone.

**Proposition 9.5.** Every state in $\mathcal P_a(2)$ is separable if and only if $a\ge\sqrt3$. In the canonical representation, the minimum number of qubits supporting a Wigner-positive entangled state is three.

*Proof.* Let $q=1/a\le1/\sqrt3$. For a pure two-qubit input, local covariance reduces the calculation to $\sqrt u|00\rangle+\sqrt{1-u}|11\rangle$. The only potentially nonpositive block in the partial transpose of its locally depolarized image has diagonal entries $(1-q^2)/4$ and off-diagonal magnitude $q^2\sqrt{u(1-u)}\le q^2/2$. It is positive when $q^2\le1/3$. The two-qubit PPT criterion therefore makes every such noisy pure state separable, and convexity treats every positive input.

For any fully block-positive $A$ and any rank-one $P_\psi$, self-adjointness gives

$$
\operatorname{Tr}[(\mathcal D_q\otimes\mathcal D_q)(A)P_\psi]
=\operatorname{Tr}[A(\mathcal D_q\otimes\mathcal D_q)(P_\psi)]\ge0.
\tag{9.15}
$$

The test operator on the right is separable, establishing positivity of the image. Depolarization commutes with transposition, and a partial transpose of a separable positive operator is separable and positive. Consequently the same argument with that test operator partially transposed proves that $(\mathcal D_q\otimes\mathcal D_q)(A)$ is PPT, and hence separable. This covers all of $\mathcal P_a(2)$.

If $a<\sqrt3$, the physical state $(\mathcal D_q\otimes\mathcal D_q)(P_\Omega)$ belongs to $\mathcal P_a(2)$ by Proposition 9.1 and has a partial-transpose eigenvalue $(1-3q^2)/4<0$.

Finally, at $a=\sqrt3$ the known locally depolarized GHZ state is

$$
\rho_3=\mathcal D_{1/\sqrt3}^{\otimes3}(P_{\mathrm{GHZ}_3})
=\frac18\left[I+\frac{ZZI+ZIZ+IZZ}{3}
+\frac{XXX-XYY-YXY-YYX}{3\sqrt3}\right].
\tag{9.16}
$$

Its Wigner symbol is the nonnegative product Husimi function of GHZ, while each one-versus-two partial transpose has the negative eigenvalue

$$
\frac{1-2/\sqrt3}{12}<0.
\tag{9.17}
$$

This gives existence at three, and the two-qubit result proves minimality. ∎

The NPT calculation across all cuts is not a claim of genuine multipartite entanglement; that stronger property does not follow merely from these tests. Neither the noisy GHZ family nor its partial-transpose threshold is counted as a new construction.

### 9.6 Incomplete amplitude damping cannot disentangle uniformly in size

Let $\mathcal A_\gamma$, $0\le\gamma\le1$, have Kraus operators

$$
E_0=\begin{pmatrix}1&0\\0&\sqrt{1-\gamma}\end{pmatrix},
\qquad E_1=\begin{pmatrix}0&\sqrt\gamma\\0&0\end{pmatrix}.
\tag{9.18}
$$

For canonical $q=1/\sqrt3$, put $\alpha=(1+q)/2$, $\beta=(1-q)/2$, and $\Psi_\gamma=\mathcal A_\gamma\circ\mathcal D_q$. Its normalized Choi matrix is

$$
J(\Psi_\gamma)=\frac12\begin{pmatrix}
\alpha+\gamma\beta&0&0&q\sqrt{1-\gamma}\\
0&(1-\gamma)\beta&0&0\\
0&0&\beta+\gamma\alpha&0\\
q\sqrt{1-\gamma}&0&0&(1-\gamma)\alpha
\end{pmatrix}.
\tag{9.19}
$$

The middle principal block of its partial transpose has determinant

$$
\frac{1-\gamma}{4}\left[\beta(\beta+\gamma\alpha)-q^2\right]
=\frac{(1-\gamma)(\gamma-\sqrt3)}{24}.
\tag{9.20}
$$

It is negative for every $\gamma<1$, so $\Psi_\gamma$ is not EB. At $\gamma=1$ it is the constant channel $X\mapsto\operatorname{Tr}(X)|0\rangle\langle0|$. Theorem 9.2 gives the exact consequence

$$
\mathcal A_\gamma^{\otimes r}(\rho)\text{ is fully separable for every }r,\rho\in\mathcal P_{\sqrt3}(r)
\quad\Longleftrightarrow\quad\gamma=1.
\tag{9.21}
$$

For each incomplete damping parameter there is some finite particle number and a physical, strictly Wigner-positive full-rank input with an entangled damped output. The number and input may depend on $\gamma$. This is not a statement that one fixed state survives every incomplete damping, or that the three-qubit GHZ example does so. Without a separate incompatibility analysis, no Bell-nonlocality conclusion is asserted for this example.

### 9.7 A quantitative bound from small negative Wigner mass

The exact separability boundary has a stable extension when the canonical Wigner function has a small negative part. Here set $a=\sqrt3$, $q=1/\sqrt3$, and retain $d\mu=2^r d\sigma_X$. Self-dual reconstruction and $\mathcal D_q(K_{\sqrt3}(x))=P_x$ give

$$
\mathcal D_q^{\otimes r}(\rho)
=\int_X W_\rho(x)\bigotimes_iP_{x_i}\,d\mu(x).
\tag{9.22}
$$

Writing $\delta=\int(W_\rho)_-d\mu$, the positive and negative masses are $1+\delta$ and $\delta$. Their normalized integrals define separable states $\tau_+$ and, when $\delta>0$, $\tau_-$. Thus

$$
\mathcal D_q^{\otimes r}(\rho)=(1+\delta)\tau_+-\delta\tau_-.
\tag{9.23}
$$

The integrals belong to the separable cone by its finite-dimensional closedness. If $R_{\mathrm{sep}}$ is robustness with respect to separable added noise,

$$
R_{\mathrm{sep}}(\omega)=\inf\left\{s\ge0:\exists\tau\in\mathrm{SEP},\quad
\frac{\omega+s\tau}{1+s}\in\mathrm{SEP}\right\},
\tag{9.24}
$$

then (9.23) immediately yields

$$
R_{\mathrm{sep}}(\mathcal D_q^{\otimes r}(\rho))\le\delta(\rho),
\qquad
\inf_{\tau\in\mathrm{SEP}}\frac12\|\mathcal D_q^{\otimes r}(\rho)-\tau\|_1\le\delta(\rho).
\tag{9.25}
$$

For the trace-distance bound choose $\tau=\tau_+$ and use $\|\tau_+-\tau_-\|_1\le2$; for $\delta=0$ the result is already separable. No sharpness is claimed for (9.25). It quantifies how the universal disentangling guarantee changes under a small negative Wigner mass, without identifying individual states or replacing the all-particle criteria above.

## 10. Boundary cases and scope checks

The restriction $j_i>0$ removes trivial factors. If every factor is spin zero, the Hilbert space is one-dimensional and the unique state has the constant nonnegative symbol; the theorem would be false. A spin-zero factor attached to nontrivial factors can simply be removed before applying the stated constants.

Compactness, connectedness, irreducibility, self-duality, and the analytic support condition each have a role. Discrete odd-dimensional Weyl phase spaces admit nonnegative pure stabilizer states [Gr06], and fail the connected analytic phase-space hypothesis. Flat bosonic phase spaces have infinite-dimensional noncompact symmetry and admit Gaussian pure states. The hyperbolic construction studied in [K26] is also outside the compact finite-dimensional hypotheses. These examples are comparisons of hypotheses, not a proof that curvature by itself completely classifies Wigner positivity.

For spin products, the exterior tensor-product representation of $\prod_i\mathrm{SU}(2)$ is the group used in every orbit argument. A diagonal SU(2) acting collectively can be reducible and may contain invariant singlets. The theorem does not assert that collective rotations alone can produce the orthogonal partner of every such state. Independent local rotations, which preserve the product kernel, are sufficient.

The conclusions concern the canonical harmonic-bandlimited function itself. Other phase-space sampling schemes can add higher harmonics that integrate to zero against all physical observables and can sometimes become positive. Those representatives need not satisfy the same self-dual all-operator identities and bandwidth bound. They are not counterexamples to this theorem.

No equality-case classification is asserted in Theorem 4.2 or Theorem 6.1. The proof deliberately trades sharp constants for a uniform estimate with every dependence explicit.

## 11. Verification and scope

The manuscript contains all written proof steps for its stated new conclusions. The main chains are the signed affine norm inequality and analytic equality factorization; the quadratic sphere decomposition, physical spin-1 realization and tensor-cone stability; and the block-positive state representation followed by the two channel transfer theorems. The original general-spin chain is also retained: normalized tensor kernels, the classical orbit input, the spherical logarithmic-mean overlap estimate, the mixed-state spectral estimate, and the signed-product comparison.

Finite symbolic and numerical checks cover the kernel conventions, normalization, channel identities, signed affine deficit, spin-1 inverse symbol, quadratic constants, Schmidt-slice identity, and the concavity calculation. Numerical quadrature splits the narrow transition near the product-state endpoint and agrees with the closed expression on the sampled grid. Further symbolic checks cover the Choi partial-transpose calculation, the noisy three-qubit example, and the local norm identities. These calculations are supporting checks. They do not prove the all-state tensor statements, classify equality by sampling, or replace the cited source theorems.

No Lean proof or completed machine verification is claimed.

The following limits are substantive. The minimum-negative-volume coherent-state conjecture for a single higher spin remains open here. We do not determine the optimal general-spin constants or the semiclassical exponent, the full mixed-state positivity region, or the sharp negative volume at each fixed mixed-state purity. The channel converses are existential over finite particle number and do not give a general explicit particle bound or Bell inequality. Bell locality is for finite single-round local POVM experiments, not arbitrary sequential postselection or grouping of particles. Pure-state entanglement equivalence does not imply LOCC monotonicity, a mixed-state converse, a genuine-multipartite-entanglement equivalence, or an efficient sampling algorithm.

## Appendix A. The SU(2) orbit input through a classical phase argument

This appendix explains a known route to the special case of Gichev's theorem needed for a single spin and its products. It is included for transparent dependencies, not as a new theorem. The constant-phase mechanism belongs to the common-zero literature [G04, S11, W25].

Let $M$ be a compact connected simply connected smooth Riemannian manifold without boundary, and let a nonzero smooth complex function $f$ satisfy

$$
\Delta f=-\Lambda f,\qquad \Lambda>0.
\tag{A.1}
$$

If $f$ had no zero, the map $f/|f|:M\to S^1$ would admit a global smooth real phase $\varphi$, so $f=R e^{i\varphi}$ with $R>0$. The imaginary part of (A.1), multiplied by $R$, is

$$
\operatorname{div}(R^2\nabla\varphi)=0.
\tag{A.2}
$$

Multiplying by $\varphi$, integrating, and applying the divergence theorem gives

$$
\int_M R^2|\nabla\varphi|^2=0.
$$

Hence $\varphi$ is constant. But then $R$ is a strictly positive eigenfunction with nonzero eigenvalue; integrating its eigenvalue equation gives $\Lambda\int_M R=0$, a contradiction. Thus $f$ has a zero. The lift is the only topological step; the circle example $f(t)=e^{it}$ explains why it cannot be dropped.

For the spin-$j$ representation, $f(g)=\langle\psi,U_j(g)\psi\rangle$ is a matrix coefficient on SU(2), which is diffeomorphic to $S^3$. For a bi-invariant metric its Casimir equation has a positive scalar eigenvalue when $j>0$, and $f(e)=1$. Therefore it vanishes somewhere. On a product of SU(2) groups, the product bi-invariant Laplacian acts with the sum of the positive Casimir eigenvalues; the same argument applies to a matrix coefficient of the exterior tensor product, whether or not $\psi$ is a product vector. This gives the orthogonal-orbit input used above without restricting to coherent states.

## Appendix B. A reproducible qubit normalization check

For a pure qubit with Bloch direction $z$, the canonical symbol is

$$
W(z)=\frac{1+\sqrt3\,z}{2},\qquad -1\le z\le1,
\quad \int_{S^2}h(z)\,d\mu=\int_{-1}^{1}h(z)\,dz.
\tag{B.1}
$$

It is negative for $z<-1/\sqrt3$, and direct integration gives

$$
\delta=\int_{-1}^{-1/\sqrt3}-\frac{1+\sqrt3 z}{2}\,dz
=\frac1{\sqrt3}-\frac12.
\tag{B.2}
$$

For a qubit Bloch vector of length $a\in[0,1]$, nonnegativity is equivalent to $a\le1/\sqrt3$, while $p=(1+a^2)/2$. Hence its exact positivity purity threshold is $2/3$. These are established qubit facts [D21]; their purpose here is to expose normalization and sign errors, not to claim a new low-spin result.

## Appendix C. Quadratic cones on spheres of arbitrary dimension

The norm and stability calculation extends to $S^{d-1}$ for every integer $d\ge2$. This gives a general version of the function-space input used in Section 8; the spin-1 physical application corresponds to $d=3$.

Let $\sigma_d$ be probability area measure on $S^{d-1}$. For $z=u\cdot x$ with $|u|=1$,

$$
\mathbb Ez=\mathbb Ez^3=0,
\qquad \mathbb Ez^2=\frac1d,
\qquad \mathbb Ez^4=\frac3{d(d+2)},
\qquad
\mathbb E\left(z^2-\frac1d\right)^2
=\frac{2(d-1)}{d^2(d+2)}.
\tag{C.1}
$$

The quadratic sum-of-affine-squares representation remains exact in this dimension. To verify it, write $q(x)=c+2b^Tx+x^TAx$ with $A=A^T\in\mathbb R^{d\times d}$ and repeat the construction in Lemma 8.1: choose $\lambda\le\lambda_{\min}(A)$ and $y=-(A-\lambda I)^\dagger b$ with $|y|\le1$, using the unique solution of $\sum_k b_k^2/(a_k-\lambda)^2=1$ when the limit at the minimum eigenvalue exceeds one. Otherwise choose that eigenvalue itself. In the endpoint branch $y$ is orthogonal to the nontrivial kernel, so a vector $z$ in that kernel completes $y$ to the unit sphere. With $B=A-\lambda I\succeq0$ and $m=q(y+z)\ge0$, identity (8.3) holds unchanged. On the sphere it supplies at most $d+1$ affine squares. This includes the case $b=0$ and the singular endpoint.

Every mean-one affine square can now be written as

$$
h_s(x)=1+\ell_d(s)z+s\left(z^2-\frac1d\right),
\qquad
\ell_d(s)=2\sqrt{s(1-s/d)},
\qquad 0\le s\le d.
\tag{C.2}
$$

Using (C.1), its norm is

$$
\begin{aligned}
\|h_s\|_2^2
&=1+\frac4d s-\frac{2(d+5)}{d^2(d+2)}s^2,\\
C_d-\|h_s\|_2^2
&=\frac{2(d+5)}{d^2(d+2)}(s-s_d)^2,\\
C_d&=\frac{3(d+3)}{d+5},
\qquad s_d=\frac{d(d+2)}{d+5}.
\end{aligned}
\tag{C.3}
$$

The local optimizers are therefore

$$
g_{d,u}(x)
=s_d(z+t_d)^2,
\qquad t_d=\sqrt{\frac3{d(d+2)}},
\qquad \mathbb Eg_{d,u}=1,
\qquad \|g_{d,u}\|_2^2=C_d.
\tag{C.4}
$$

Equivalently, if the original affine square is $(\alpha+\beta z)^2$ with $\beta\ne0$ and $v=d\alpha^2/\beta^2$, its ratio of squared $L^2$ norm to squared mean is

$$
\frac{v^2+6v+3d/(d+2)}{(v+1)^2}
=C_d-\frac{2(d+2)}{d+5}
\frac{(v-3/(d+2))^2}{(v+1)^2}.
\tag{C.5}
$$

The constant-square case is recovered by its limiting value one. A general nonnegative spherical quadratic is a positive mixture of mean-one affine squares after normalization. The norm convexity and variance equality argument in Proposition 8.2 therefore gives

$$
\mathbb E q^2\le C_d(\mathbb Eq)^2,
\tag{C.6}
$$

and all nonzero equality functions are $A(u\cdot x+t_d)^2$ with $A>0$. Explicitly, equality forces every affine square in the mixture to have the maximizing parameter $s_d$, and the vanishing mixture variance forces all normalized squares to coincide. This establishes both necessity and sufficiency of the stated equality form.

For stability, rationalization gives

$$
\ell_d(s)-\ell_d(s_d)
=\frac{4(s-s_d)[1-(s+s_d)/d]}{\ell_d(s)+\ell_d(s_d)}.
$$

Since $0\le s\le d$ and $d\ge2$,

$$
\left|1-\frac{s+s_d}{d}\right|
\le\frac{d+2}{d+5},
\qquad
\ell_d(s_d)=\frac{2\sqrt{3d(d+2)}}{d+5}.
$$

Consequently

$$
|\ell_d(s)-\ell_d(s_d)|
\le2\sqrt{\frac{d+2}{3d}}\,|s-s_d|.
\tag{C.7}
$$

The orthogonality of the linear and centered quadratic terms, followed by (C.1), (C.3) and (C.7), yields the same-direction estimate

$$
\begin{aligned}
\|h_s-g_{d,u}\|_2^2
&=\frac{[\ell_d(s)-\ell_d(s_d)]^2}{d}
+\frac{2(d-1)}{d^2(d+2)}(s-s_d)^2\\
&\le\frac{2d+1}{3}\left(C_d-\|h_s\|_2^2\right).
\end{aligned}
\tag{C.8}
$$

For a normalized nonnegative quadratic $q=\sum_k w_kh_k$, put $A=\sum_k w_k(C_d-\|h_k\|_2^2)$ and $V=\sum_k w_k\|h_k-q\|_2^2$. Again $A+V=C_d-\|q\|_2^2$. Choose the same-direction optimizer for each $h_k$. Minkowski and Cauchy–Schwarz give

$$
\sum_k w_k\|q-g_k\|_2^2
\le\left(\sqrt V+\sqrt{\frac{2d+1}{3}A}\right)^2
\le\frac{2(d+2)}3(A+V).
$$

At least one direction therefore satisfies

$$
\|q-g_{d,u}\|_2^2
\le\frac{2(d+2)}3\left(C_d-\|q\|_2^2\right).
\tag{C.9}
$$

Finally, for a nonnegative mean-one function that is quadratic in each variable on $\prod_iS^{d_i-1}$, Theorem 8.4 applies with these local constants. It gives the sharp product norm bound and quantitative rigidity

$$
\begin{aligned}
\|F\|_2^2&\le\prod_i\frac{3(d_i+3)}{d_i+5},\\
\left\|F-\prod_i g_{d_i,u_i}\right\|_2^2
&\le\left[\sum_i\frac{2d_i+7}{3}-1\right]
\left[\prod_i\frac{3(d_i+3)}{d_i+5}-\|F\|_2^2\right]
\end{aligned}
\tag{C.10}
$$

for suitable directions $u_i$. Products of the local optimizers attain the norm bound; zero deficit in the second line proves that these are all normalized equality functions. No claim for harmonic degree greater than two follows from this argument.

## References

- **[D21]** J. Davis, M. Kumari, R. B. Mann and S. Ghose, *Wigner negativity in spin-j systems*, Physical Review Research **3**, 033134 (2021). DOI: [10.1103/PhysRevResearch.3.033134](https://doi.org/10.1103/PhysRevResearch.3.033134). [arXiv:2008.10167v1](https://arxiv.org/html/2008.10167v1).
- **[D23]** J. Davis, R. A. Hennigar, R. B. Mann and S. Ghose, *Stellar representation of extremal Wigner-negative spin states*, Journal of Physics A **56**, 265302 (2023). DOI: [10.1088/1751-8121/acd918](https://doi.org/10.1088/1751-8121/acd918). [arXiv:2206.00195v1](https://arxiv.org/html/2206.00195v1), originally posted in 2022; the cited kernel and coherent-state argument are in Sections II–III.
- **[Den25]** J. Denis, *Bridging Concepts of Quantumness: Phase-space, Entanglement and Anticoherence in Spin Systems*, doctoral thesis, University of Liège (2025), printed pp. 3 and 26–28. [Official record and full text](https://orbi.uliege.be/handle/2268/336540).
- **[DDMM24]** J. Denis, J. Davis, R. B. Mann and J. Martin, *Polytopes of Absolutely Wigner Bounded Spin States*, Quantum **8**, 1550 (2024). [arXiv:2304.09006v3](https://arxiv.org/html/2304.09006v3).
- **[G04]** V. M. Gichev, *A note on common zeroes of Laplace–Beltrami eigenfunctions*, Annals of Global Analysis and Geometry **26**, 201–208 (2004), especially Corollary 1. [arXiv:math/0511688](https://arxiv.org/html/math/0511688v1), uploaded in 2005.
- **[GRYSH26]** A. Z. Goldberg, A. J. Rodrigues, Y. B. Yilmaz, A. M. Steinberg and A. Hertz, *Spin coherence scale: operator-ordering sensitivity beyond the Heisenberg–Weyl group*, Physical Review A **113**, 062457 (2026). [arXiv:2510.09747v2](https://arxiv.org/html/2510.09747v2), especially Sections V.4–V.5.
- **[Gr06]** D. Gross, *Hudson's theorem for finite-dimensional quantum systems*, Journal of Mathematical Physics **47**, 122107 (2006). [arXiv:quant-ph/0602001](https://arxiv.org/abs/quant-ph/0602001).
- **[K26]** C.-F. Kam, *Hudson's theorem fails for the SU(1,1) discrete series*, [arXiv:2609.07242v1](https://arxiv.org/html/2609.07242v1) (2026), Introduction and Section VI. This is the source of the explicit all-pure-spin conjecture addressed here; its separate hyperbolic conclusions are not proof inputs.
- **[M62]** K. Mahler, *On some inequalities for polynomials in several variables*, Journal of the London Mathematical Society **37**, 341–344 (1962). DOI: [10.1112/jlms/s1-37.1.341](https://doi.org/10.1112/jlms/s1-37.1.341). [Authorized publisher reprint](https://ems.press/content/book-chapter-files/27423), equations (3)–(4). Third-party full text is not included in this project.
- **[S11]** S. Schwartzman, *Schrödinger Operators and the Zeros of Their Eigenfunctions*, Communications in Mathematical Physics **306**, 187–191 (2011). DOI: [10.1007/s00220-011-1272-3](https://doi.org/10.1007/s00220-011-1272-3).
- **[W25]** W. W.-Y. Wong, *Zeroes of Eigenfunctions of Schrödinger Operators after Schwartzman*, [arXiv:2509.09739v1](https://arxiv.org/abs/2509.09739) (2025).

- **[Gl08]** P. Yu. Glazyrina, *The Sharp Markov–Nikolskii Inequality for Algebraic Polynomials in the Spaces $L_q$ and $L_0$ on a Closed Interval*, Mathematical Notes **84**, 3–21 (2008). DOI: [10.1134/S0001434608070018](https://doi.org/10.1134/S0001434608070018). [Primary record](https://www.mathnet.ru/eng/mzm5194); Theorem 1, equations (1.8), (1.10), and the discussion of the 2003 zero-derivative case.

- **[APT18]** I. I. Arkhipov, A. Barasiński and J. Svozilík, *Negativity volume of the generalized Wigner function as an entanglement witness for hybrid bipartite states*, Scientific Reports **8**, 16955 (2018). [DOI 10.1038/s41598-018-35330-6](https://doi.org/10.1038/s41598-018-35330-6), especially the known one-qubit purity threshold in equation (16).

- **[R17]** R. P. Rundle, P. W. Mills, T. Tilma, J. H. Samson and M. J. Everitt, *Simple procedure for phase-space measurement and entanglement validation*, Physical Review A **96**, 022117 (2017). [DOI 10.1103/PhysRevA.96.022117](https://doi.org/10.1103/PhysRevA.96.022117), Section V equations (10)–(12) for the local product kernel, and Section VII equations (17)–(18) for marginals.

- **[T18]** Y. Tian, Z. Wang, P. Zhang, G. Li, J. Li and T. Zhang, *Measurement of complete and continuous Wigner functions for discrete atomic systems*, Physical Review A **97**, 013840 (2018). [DOI 10.1103/PhysRevA.97.013840](https://doi.org/10.1103/PhysRevA.97.013840). [arXiv:1706.08676v4](https://arxiv.org/abs/1706.08676v4); [author-hosted published PDF](https://ioe.sxu.edu.cn/lab4/pdf_files/2018_PRA_TianYL.pdf).

- **[ZGHFL26]** Lin Htoo Zaw, Jiajie Guo, Qiongyi He, Matteo Fadel, Shuheng Liu, *Sufficient Wigner Negativity Implies Genuine Multipartite Entanglement*, Physical Review Letters **137**, 040202 (2026). DOI: [10.1103/bftw-qnbf](https://doi.org/10.1103/bftw-qnbf). [Primary full-text version](https://arxiv.org/pdf/2510.26761v3).

- **[PGQ25]** Martin Plávala, Otfried Gühne, Marco Túlio Quintino, *All Incompatible Measurements on Qubits Lead to Multiparticle Bell Nonlocality*, Physical Review Letters **134**, 200201 (2025). DOI: [10.1103/PhysRevLett.134.200201](https://doi.org/10.1103/PhysRevLett.134.200201). [Primary full-text version](https://journals.aps.org/prl/pdf/10.1103/PhysRevLett.134.200201).

- **[R24]** Martin J. Renner, *Compatibility of Generalized Noisy Qubit Measurements*, Physical Review Letters **132**, 250202 (2024). DOI: [10.1103/PhysRevLett.132.250202](https://doi.org/10.1103/PhysRevLett.132.250202). [Primary full-text version](https://arxiv.org/pdf/2309.12290v2).

- **[CMW19]** Matthias Christandl, Alexander Müller-Hermes, Michael M. Wolf, *When Do Composed Maps Become Entanglement Breaking?*, Annales Henri Poincaré **20**(7), 2295-2322 (2019). DOI: [10.1007/s00023-019-00774-7](https://doi.org/10.1007/s00023-019-00774-7). [Primary full-text version](https://arxiv.org/pdf/1807.01266v2).

- **[AMH23]** Guillaume Aubrun, Alexander Müller-Hermes, *Annihilating Entanglement Between Cones*, Communications in Mathematical Physics **400**, 931-976 (2023). DOI: [10.1007/s00220-022-04621-5](https://doi.org/10.1007/s00220-022-04621-5).

- **[MZ10]** Lenka Moravčíková, Mário Ziman, *Entanglement-annihilating and entanglement-breaking channels*, Journal of Physics A: Mathematical and Theoretical **43**(27), 275306 (2010). DOI: [10.1088/1751-8113/43/27/275306](https://doi.org/10.1088/1751-8113/43/27/275306). [Primary full-text version](https://arxiv.org/pdf/1006.2502v1).

- **[NRT26b]** Fabio Nicola, Federico Riccardi, Paolo Tilli, *An elementary approach to Wehrl-type entropy bounds in quantitative form*, Proceedings of the London Mathematical Society **133**(1), e70182 (2026). DOI: [10.1112/plms.70182](https://doi.org/10.1112/plms.70182).

- **[NRT26a]** Fabio Nicola, Federico Riccardi, Paolo Tilli, *The Wehrl-type entropy conjecture for symmetric SU(N) coherent states: Cases of equality and stability*, Duke Mathematical Journal **175**(12), 2279-2297 (2026). DOI: [10.1215/00127094-2025-0070](https://doi.org/10.1215/00127094-2025-0070). [Primary full-text version](https://arxiv.org/pdf/2412.10940v3).

- **[RMdSCA21]** Saleh Rahimi-Keshari, Mohammad Mehboudi, Dario De Santis, Daniel Cavalcanti, Antonio Acín, *Verification of joint measurability using phase-space quasiprobability distributions*, Physical Review A **104**, 042212 (2021). DOI: [10.1103/PhysRevA.104.042212](https://doi.org/10.1103/PhysRevA.104.042212). [Primary full-text version](https://arxiv.org/pdf/2012.06853v1).

- **[PT07]** Imre Pólik, Tamás Terlaky, *A Survey of the S-Lemma*, SIAM Review **49**(3), 371-418 (2007). DOI: [10.1137/S003614450444614X](https://doi.org/10.1137/S003614450444614X). [Primary full-text version](https://www.math.uwaterloo.ca/~hwolkowi/henry/reports/Mprime/pdf/Tamas/S-lemma_SIREV.pdf).

- **[HSR03]** M. Horodecki, P. W. Shor and M. B. Ruskai, *Entanglement Breaking Channels*, Reviews in Mathematical Physics **15**, 629–641 (2003). DOI: [10.1142/S0129055X03001709](https://doi.org/10.1142/S0129055X03001709). [Author manuscript](https://arxiv.org/abs/quant-ph/0302031).

- **[HHH96]** M. Horodecki, P. Horodecki and R. Horodecki, *Separability of Mixed States: Necessary and Sufficient Conditions*, Physics Letters A **223**, 1–8 (1996). DOI: [10.1016/S0375-9601(96)00706-2](https://doi.org/10.1016/S0375-9601(96)00706-2). [Author manuscript](https://arxiv.org/abs/quant-ph/9605038).
