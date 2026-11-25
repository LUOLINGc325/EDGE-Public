# Scalar fidelity composition and sharp word calibration

Fixed-input survival for canonical qubit gates and switched contractions

## Abstract

We examine the extension of an isotropic quantum-error fidelity composition law to anisotropic errors in an explicitly specified canonical SU(2) gate model. We construct two smooth, strictly positive probability densities on the unit spinor sphere. Both have positive first mean along the ideal spinor, a unique global density maximum at that spinor, and the same output density matrix after one error applied to the fixed input. Nevertheless, two independent repetitions give squared fidelities on opposite sides of the proposed scalar composition formula. Every one-step and two-step fidelity exceeds one half. Mixing with an isotropic polynomial family preserves all these properties and produces counterexamples with single-step squared fidelity arbitrarily close to one. The underlying interference correction is an independent-expectation specialization of existing unitary composition identities; our contribution is the explicit paired construction satisfying these simultaneous constraints. We prove compatibility with the previously defined isotropic convolution. The core construction uses sphere moments through degree five; the high-fidelity extension follows from beta integrals. The model retains spinor phase when assigning a gate: its centering conditions and counterexamples concern the full sphere, not quantum rays intrinsically. Exact symbolic calculations and an independent matrix-product implementation reproduce the results. We then establish a quantitative calibration law from mixed observations: in a qubit library, measurements of lengths at most three bound the prediction error at length $n$ by a cubic factor. In $m$ transverse dimensions, calibration through length $m+1$ gives the sharp order $n^{m+1}$, with the exponent attained by finite mixtures of rotations. Formalization tasks are listed separately.

**Keywords:** quantum errors; squared fidelity; SU(2); anisotropic distributions; interference; exact counterexample.

## 1. Problem, interpretation, and contribution

For a random qubit state produced from the fixed input $|0\rangle$, write $q$ for its squared fidelity with that input. Lacalle, Pozo Coronado, and Martín-Cuevas prove an isotropic composition law and formulate a general extension in Conjecture 1 of [1]. For one qubit the proposed scalar rule is

$$
B(q_1,q_2)=\frac12+2\left(q_1-\frac12\right)\left(q_2-\frac12\right)
=q_1q_2+(1-q_1)(1-q_2).
\tag{1}
$$

The quantity here is fixed-input squared fidelity, not average gate fidelity. Definition 1 of [1] specifies a spherical convolution for two isotropic distributions. It does not uniquely specify an operation on arbitrary anisotropic distributions. A counterexample to a proposed extension must therefore identify its operation. We use the canonical SU(2) lift of a unit spinor and compose independent gates by matrix multiplication. Section 3 proves that this operation agrees with the original isotropic convolution.

This choice is phase sensitive. If $a,b\in\mathbb C$ and $|a|^2+|b|^2=1$, define

$$
U(a,b)=\begin{pmatrix}a&-\overline b\\ b&\overline a\end{pmatrix}.
\qquad
U(e^{i\phi}a,e^{i\phi}b)
=U(a,b)\begin{pmatrix}e^{i\phi}&0\\0&e^{-i\phi}\end{pmatrix}.
\tag{2}
$$

Thus a global phase of the first column can change the gate beyond a global phase. A full spinor fixes this lift; a quantum ray alone does not. All centering and mode statements below refer to the full real sphere and its specified surface measure. We do not claim to disprove every possible ray-based interpretation of anisotropic error addition.

The general interference mechanism is established prior work. Biamonte gives an exact unitary composition defect in Appendix C.1, Proposition C.2, Eq. (53), and deterministic qubit-pair equality conditions in Appendix C.2, Theorem C.5 of [5]. Our moment identity is its independent-expectation specialization and is proved directly for clarity. Earlier work on average gate fidelity already demonstrates the importance of coherent information in composite channels [3,4]. Those results concern related but different fidelity quantities. The variance question in [2] is also distinct. An unreviewed [MathDB reader note by Shivam Patel](https://mathdb.com/p/366329/variance-formula-for-sums-of-independent-quantum-computing-e) uses quaternion composition and a polynomial Haar density for a variance example; that construction route is not claimed as new here.

The original qubit construction gives an explicit pair of smooth positive laws that simultaneously satisfy positive directional mean centering, unique-mode centering, equality of the full one-error output state, and the fidelity range in the motivating conjecture, yet violate (1) in opposite directions under independent repetition. This corrects a specified interpretation of [1]. Sections 7–9 study what fixed-input measurements jointly imply for independent repeated and switched gates.

## 2. Model and main result

Let $H$ be normalized rotation-invariant surface probability on

$$
\begin{aligned}
\mathbb S^3&=\left\{x\in\mathbb R^4:\sum_{j=0}^3x_j^2=1\right\},
\qquad e_0=(1,0,0,0),\\
a(x)&=x_0+i x_1,\qquad b(x)=x_2+i x_3.
\end{aligned}
\tag{3}
$$

All densities are relative to $H$. We use $U(x)=U(a(x),b(x))$ from (2). For a law $\mu$ on this sphere define

$$
q_\mu=\mathbb E_\mu|a(X)|^2,
\qquad
\rho_\mu=\mathbb E_\mu\left[U(X)|0\rangle\langle0|U(X)^\dagger\right].
\tag{4}
$$

The first gate acts first: two independent laws $\mu_1,\mu_2$ produce $U(X_2)U(X_1)$. Write $q_{2\leftarrow1}$ for its squared fidelity. A law is *mean centered* here if $\mathbb EX=c e_0$ with $c>0$, and *mode centered* if its density has its unique global maximum at $e_0$. The coefficient permits a nondegenerate centered law: if $\mathbb EX=e_0$, then $\mathbb E\|X-e_0\|^2=0$, forcing $X=e_0$ almost surely.

Put $t=x_0^2+x_1^2$ and define

$$
\begin{aligned}
f_0(x)&=1+\frac{x_0}{4}+\frac{2t-1}{4},\\
f_A(x)&=f_0(x)+\frac18 x_2\left(x_0+\frac16\right)(1-x_0),\\
f_B(x)&=f_0(x)+\frac5{48}x_1x_3.
\end{aligned}
\tag{5}
$$

**Theorem 1 (paired smooth centered counterexamples).** The functions $f_A,f_B$ are smooth probability densities on $\mathbb S^3$, with

$$
f_A\ge\frac5{24},\qquad f_B\ge\frac{43}{96},
\qquad
\mathbb E_A X=\mathbb E_B X=\frac1{16}e_0.
\tag{6}
$$

Both densities have their unique global maximum at $e_0$, and

$$
q_A=q_B=\frac{13}{24},\qquad
\rho_A=\rho_B=
\begin{pmatrix}
13/24&5/1152\\5/1152&11/24
\end{pmatrix}.
\tag{7}
$$

For two independent repetitions of either law,

$$
\begin{aligned}
q_{A\leftarrow A}&=\frac{334055}{663552}
=\frac{145}{288}-\frac{25}{663552},\\
q_{B\leftarrow B}&=\frac{334105}{663552}
=\frac{145}{288}+\frac{25}{663552},\\
B(q_A,q_A)&=B(q_B,q_B)=\frac{145}{288}.
\end{aligned}
\tag{8}
$$

All these two-step squared fidelities lie strictly between $1/2$ and $13/24$. In addition, for any deterministic current spinor $x$, application of either random gate has mean $x/16$ and its output density has its unique mode at $x$.

The equality in (7) concerns one fixed input. It does not assert equality of the corresponding quantum channels. The difference between the two channels is essential to the conclusion.

## 3. Canonical composition and the isotropic operation

Direct multiplication gives $U(x)^\dagger U(x)=I$ and $\det U(x)=1$. Orthogonality and determinant one fix the second column once the first column is given, so (2) is the unique SU(2) matrix with that first column. The product has first column

$$
a_{21}=a_2a_1-\overline{b_2}b_1,
\qquad
b_{21}=b_2a_1+\overline{a_2}b_1,
\tag{9}
$$

and second column $(-\overline{b_{21}},\overline{a_{21}})^T$. Its first column has unit norm. Denote the induced real spinor product by $x_2\star x_1$. Its identity is $e_0$ and its inverse is

$$
x^{-1}=(x_0,-x_1,-x_2,-x_3).
\tag{10}
$$

For fixed unit $x$, left and right multiplication by $x$ are real-linear isometries of $\mathbb R^4$. To see this, extend the matrix formula to arbitrary $z\in\mathbb R^4$; it satisfies $U(z)^\dagger U(z)=\|z\|^2I$. Multiplication by the fixed unitary $U(x)$ preserves this norm. These maps consequently preserve $H$, which is the normalized Haar probability for this spinor group. A further direct calculation gives

$$
\left(z\star x^{-1}\right)_0
=\operatorname{Re}\left(a(z)\overline{a(x)}+\overline{b(z)}b(x)\right)
=\langle z,x\rangle_{\mathbb R^4}.
\tag{11}
$$

**Proposition 2 (isotropic compatibility).** If $X_1,X_2$ are independent with densities $f_1,f_2$, the product $Z=X_2\star X_1$ has density

$$
f_Z(z)=\int_{\mathbb S^3}f_1(x)f_2(z\star x^{-1})\,dH(x).
\tag{12}
$$

If $f_2(y)=h_2(y_0)$ is isotropic about $e_0$, this reduces to

$$
f_Z(z)=\int_{\mathbb S^3}f_1(x)h_2(\langle z,x\rangle)\,dH(x).
\tag{13}
$$

**Proof.** Conditional on $X_1=x$, the output map is $y\mapsto y\star x$. Its inverse is $z\mapsto z\star x^{-1}$ and it preserves $H$. Thus the conditional density is $f_2(z\star x^{-1})$; averaging over $x$ gives (12). Nonnegativity justifies interchange of integration. Equation (11) gives (13). Finally, $\|z-x\|^2=2-2\langle z,x\rangle$, so this conditional kernel is precisely the isotropic error density centered at the current spinor. For two isotropic inputs it is the convolution of Definition 1 in [1]. $\square$

This establishes compatibility of the entire transition kernel, not only agreement of a fidelity value. It does not make the anisotropic extension unique.

## 4. The expected interference term

For any sphere law, define the two bounded complex moments

$$
u=\mathbb E(ab),\qquad v=\mathbb E(a\overline b).
\tag{14}
$$

**Proposition 3 (ordered correction).** For arbitrary independent sphere laws,

$$
\begin{aligned}
q_{2\leftarrow1}&=B(q_1,q_2)-2\operatorname{Re}(u_2v_1),\\
q_{2\leftarrow1}=B(q_1,q_2)&\quad\Longleftrightarrow\quad
\operatorname{Re}(u_2v_1)=0.
\end{aligned}
\tag{15}
$$

**Proof.** Expanding (9) gives

$$
|a_{21}|^2
=|a_2|^2|a_1|^2+|b_2|^2|b_1|^2
-2\operatorname{Re}\left((a_2b_2)(a_1\overline{b_1})\right).
\tag{16}
$$

Independence factors the expectations of products involving separate errors. Since $\mathbb E|b_i|^2=1-q_i$, the first two terms average to $B(q_1,q_2)$, and the last averages to $-2\operatorname{Re}(u_2v_1)$. This proves the identity and its equality criterion. All quantities are bounded; no density or centering assumption is needed. $\square$

As discussed in Section 1, (16) is the relevant matrix-entry interference identity from the established composition framework [5]. The criterion in (15) concerns vanishing *expected* interference; it does not require interference to vanish for every sampled deterministic gate pair.

For $m_{jk}=\mathbb E(x_jx_k)$, expansion of (14) gives

$$
\begin{aligned}
u&=(m_{02}-m_{13})+i(m_{03}+m_{12}),\\
v&=(m_{02}+m_{13})+i(m_{12}-m_{03}).
\end{aligned}
\tag{17}
$$

For identical independent laws the correction is therefore

$$
q_{2\leftarrow1}-B(q,q)
=-2\left(m_{02}^2+m_{03}^2-m_{12}^2-m_{13}^2\right).
\tag{18}
$$

First-moment centering does not determine these second moments. If either law is isotropic, reflections of the transverse coordinates fixing $e_0$ make its four cross moments in (17) vanish. Thus $v_1=0$ for an isotropic first law, or $u_2=0$ for an isotropic second law; either condition restores (1).

## 5. Sphere moments and proof of Theorem 1

### 5.1. Required moments

Coordinate reflections imply that a monomial with an odd power in any coordinate has integral zero under $H$. Permutation invariance and the sphere constraint give $\int x_j^2\,dH=1/4$. Put $A=\int x_0^4\,dH$ and $C=\int x_0^2x_1^2\,dH$. Rotation of the first coordinate to $(x_0+x_1)/\sqrt2$ and cancellation of odd terms imply $A=(2A+6C)/4$. Squaring the sphere constraint gives $1=4A+12C$. Consequently,

$$
\int x_j^2\,dH=\frac14,\qquad
\int x_j^4\,dH=\frac18,\qquad
\int x_j^2x_k^2\,dH=\frac1{24}\quad(j\ne k).
\tag{19}
$$

In particular $\int t\,dH=1/2$ and $\int t^2\,dH=1/3$. Every degree-five monomial has an odd coordinate power, so no additional nonzero moments are required below.

### 5.2. Positivity, normalization, and mean

The functions in (5) are polynomial restrictions, hence smooth. Because $|x_0|\le1$ and $0\le t\le1$, we have $f_0\ge1/2$. Furthermore,

$$
\left|x_2\left(x_0+\frac16\right)(1-x_0)\right|\le\frac73,
\qquad |x_1x_3|\le\frac12.
\tag{20}
$$

These bounds give exactly the lower bounds in (6). The linear term of $f_0$ has zero integral, and its quadratic perturbation has zero integral because $\int t\,dH=1/2$. The extra term of $f_A$ is odd in $x_2$, and that of $f_B$ is odd in $x_1$. Both densities therefore integrate to one.

The base density has mean $e_0/16$: only its linear term contributes, with $(1/4)\int x_0^2\,dH=1/16$. The perturbation of $f_B$ makes no first-moment contribution by parity. Expand the remaining perturbation as

$$
f_A-f_0=\frac{x_2}{8}\left(-x_0^2+\frac56x_0+\frac16\right).
\tag{21}
$$

Its contribution to coordinates $0,1,3$ vanishes by parity. Its possible contribution to coordinate $2$ is

$$
\frac18\left(-\frac1{24}+\frac56\,0+\frac16\frac14\right)=0.
\tag{22}
$$

This proves the mean statement in (6).

### 5.3. Unique mode

Both densities take the value $3/2$ at $e_0$. The exact base-density gap is

$$
f_0(e_0)-f_0(x)=\frac{1-x_0}{4}+\frac{x_2^2+x_3^2}{2}.
\tag{23}
$$

Since $|x_2(x_0+1/6)|\le7/6$, the perturbation in $f_A$ is at most $(7/48)(1-x_0)$. Also,
$|x_1x_3|\le(1-x_0^2)/2\le1-x_0$, so the perturbation in $f_B$ is at most $(5/48)(1-x_0)$. Therefore

$$
\begin{aligned}
f_A(e_0)-f_A(x)&\ge\frac5{48}(1-x_0)+\frac{x_2^2+x_3^2}{2},\\
f_B(e_0)-f_B(x)&\ge\frac7{48}(1-x_0)+\frac{x_2^2+x_3^2}{2}.
\end{aligned}
\tag{24}
$$

Every sphere point other than $e_0$ has $x_0<1$. Both gaps are consequently strictly positive away from $e_0$, proving uniqueness of the modes.

### 5.4. Second moments and fidelity values

Using (19), the diagonal second moments under $f_0$ are $(13,13,11,11)/48$. For example,

$$
\int x_0^2t\,dH=\frac16,\qquad \int x_2^2t\,dH=\frac1{12}.
$$

Substitution in (5) gives these values. Each added perturbation has zero contribution to diagonal second moments by parity. The only nonzero off-diagonal moment contributed by $f_A-f_0$ is

$$
m_{02}^{A}=\frac18\left(0+\frac56\frac1{24}+0\right)=\frac5{1152}.
\tag{25}
$$

For $f_B-f_0$, only $m_{13}^{B}=(5/48)(1/24)=5/1152$ is nonzero. The other off-diagonal products contain an odd coordinate power. Thus the full second-moment matrices are

$$
M_A=\frac1{1152}\begin{pmatrix}
312&0&5&0\\0&312&0&0\\5&0&264&0\\0&0&0&264
\end{pmatrix},\qquad
M_B=\frac1{1152}\begin{pmatrix}
312&0&0&0\\0&312&0&5\\0&0&264&0\\0&5&0&264
\end{pmatrix}.
\tag{26}
$$

Equations (17) and (26) yield

$$
q_A=q_B=\frac{13}{24},\qquad
v_A=v_B=\frac5{1152},\qquad
u_A=\frac5{1152},\quad u_B=-\frac5{1152}.
\tag{27}
$$

The general single-input output matrix is

$$
\rho_\mu=\begin{pmatrix}q_\mu&v_\mu\\\overline{v_\mu}&1-q_\mu\end{pmatrix},
\tag{28}
$$

which proves (7). Substitution into (15) gives (8), because $2(5/1152)^2=25/663552$. The stated range follows from the integer inequalities

$$
331776<334055<334105<359424,
\tag{29}
$$

after division by $663552$, whose endpoints are $1/2$ and $13/24$.

### 5.5. Centering at every current spinor

The established first mean implies $\mathbb E_AU(X)=\mathbb E_BU(X)=I/16$. For every deterministic current spinor $x$, real or complex linearity therefore gives $\mathbb E[U(X)x]=x/16$. Its output density is $z\mapsto f_A(z\star x^{-1})$ or $z\mapsto f_B(z\star x^{-1})$, by the same measure-preserving change of variables as in Proposition 2. Right translation is bijective, and $z\star x^{-1}=e_0$ precisely when $z=x$. The unique mode is thus $x$. This proves the final assertion of Theorem 1 and completes its proof. $\square$

## 6. What the paired construction establishes

Equality of the one-error matrices in (7) is stronger than equality of their squared fidelities, but weaker than equality of channels. Define

$$
\Phi_\mu(\rho)=\mathbb E_\mu\left[U(X)\rho U(X)^\dagger\right].
\tag{30}
$$

Then (7) says $\Phi_A(|0\rangle\langle0|)=\Phi_B(|0\rangle\langle0|)$. Equation (8) shows that these channels cannot be identical. Full channel composition remains well defined; a single input-output state does not supply the channel information needed for a second application.

The ordered mixed cases make this distinction explicit. The first law determines $v_1$, which is the same for both laws; the second determines $u_2$, whose sign differs. Equation (15) gives the following exact table.

| First law | Second law $A$ | Second law $B$ |
|---|---:|---:|
| $A$ | $334055/663552$ | $334105/663552$ |
| $B$ | $334055/663552$ | $334105/663552$ |

Reversing the two distinct laws changes this observable by $25/331776$. The scalar rule (1), which uses only the equal values $q_A=q_B$, cannot record this information. Nor can a universal composition rule whose only inputs are the two fixed-input output density matrices: the repeated-$A$ and repeated-$B$ experiments would supply identical such inputs but different answers. This statement does not restrict composition rules that retain the full channels.

### 6.1. Counterexamples at arbitrarily high fidelity

The obstruction persists when the single-step infidelity is arbitrarily small. For an integer $m\ge3$, set

$$
\begin{aligned}
Z_m&=\int_{\mathbb S^3}(1+x_0)^m\,dH(x),\qquad
g_m(x)=\frac{(1+x_0)^m}{Z_m},\qquad \varepsilon_m=\frac1{m+1},\\
f_{A,m}&=(1-\varepsilon_m)g_m+\varepsilon_m f_A,\qquad
f_{B,m}=(1-\varepsilon_m)g_m+\varepsilon_m f_B.
\end{aligned}
\tag{31}
$$

**Corollary 4 (arbitrarily high-fidelity pairs).** For every integer $m\ge3$, the pair in (31) consists of smooth strictly positive probability densities, has the same positive mean direction and unique mode at $e_0$, and produces the same single-input output state. Its common one-step squared fidelity and its two independent repetition values are

$$
\begin{aligned}
q_m&=\frac{m}{m+1}\frac{m^2+3m+6}{(m+3)(m+4)}
+\frac{13}{24(m+1)}\longrightarrow1,\\
q_{A,m\leftarrow A,m}&=B(q_m,q_m)-\frac{25}{663552(m+1)^2},\\
q_{B,m\leftarrow B,m}&=B(q_m,q_m)+\frac{25}{663552(m+1)^2}.
\end{aligned}
\tag{32}
$$

Both two-step values lie strictly between $1/2$ and $q_m$. Conditional mean and mode centering also hold at every current spinor.

**Proof.** The normalization $Z_m$ is positive. In spherical coordinates $x_0=\cos\alpha$, the surface element has factor $\sin^2\alpha\,d\alpha$; hence the $x_0$ marginal under $H$ is proportional to $(1-x_0^2)^{1/2}$. After weighting by $(1+x_0)^m$, the variable $T=(1+x_0)/2$ has density proportional to $T^{m+1/2}(1-T)^{1/2}$. Define $\mathrm B(a,b)=\int_0^1s^{a-1}(1-s)^{b-1}\,ds$. Integration of the derivative of $s^a(1-s)^b$, together with $\mathrm B(a,b)=\mathrm B(a+1,b)+\mathrm B(a,b+1)$, yields the recurrence $\mathrm B(a+1,b)=a\mathrm B(a,b)/(a+b)$. Applying it once and twice gives

$$
\mathbb E_{g_m}x_0=\frac{m}{m+3},\qquad
\mathbb E_{g_m}x_0^2=\frac{m^2+m+3}{(m+3)(m+4)},\qquad
\mathbb E_{g_m}x_1^2=\frac{2m+3}{(m+3)(m+4)}.
\tag{33}
$$

The last equality follows from transverse permutation symmetry and the sphere constraint. Transverse sign symmetries make all mixed second moments and transverse first moments zero. Thus $u(g_m)=v(g_m)=0$ and $q(g_m)=(m^2+3m+6)/((m+3)(m+4))$.

The density $g_m$ is a normalized polynomial with its unique maximum at $e_0$, because $(1+x_0)^m$ is strictly increasing on $[-1,1]$. Both mixtures are smooth, normalized, and have that same unique maximum. Their lower bounds are $5\varepsilon_m/24$ and $43\varepsilon_m/96$. With $c=5/1152$, their common first mean and single-input output are

$$
\begin{aligned}
\mathbb E_{A,m}X=\mathbb E_{B,m}X
&=\left(\frac{m^2}{(m+1)(m+3)}+\frac1{16(m+1)}\right)e_0,\\
\rho_{A,m}=\rho_{B,m}
&=\begin{pmatrix}q_m&\varepsilon_m c\\\varepsilon_m c&1-q_m\end{pmatrix}.
\end{aligned}
\tag{34}
$$

The mean coefficient is positive. Linearity gives $u_{A,m}=v_{A,m}=\varepsilon_m c$ and $u_{B,m}=-\varepsilon_m c$, $v_{B,m}=\varepsilon_m c$. Proposition 3 yields (32). The argument of Section 5.5 proves conditional centering at every current spinor.

For the fidelity range, $q(g_m)-13/24$ has numerator $11m^2-19m-12=(m-3)(11m+14)+30$ and denominator $24(m+3)(m+4)$, so $q_m\ge13/24$. Also $q_m<1$ and $1-q_m\ge11\varepsilon_m/24$. Write $\delta_m=2\varepsilon_m^2c^2$. Since $0<\varepsilon_m<1$,

$$
\begin{aligned}
B(q_m,q_m)-\frac12&\ge\frac1{288}>2c^2\ge\delta_m,\\
q_m-B(q_m,q_m)&=(1-q_m)(2q_m-1)
\ge\frac{11\varepsilon_m}{288}>2\varepsilon_m^2c^2=\delta_m.
\end{aligned}
\tag{35}
$$

These inequalities place both two-step values strictly between $1/2$ and $q_m$. The explicit rational expression gives $q_m\to1$, while $\delta_m>0$ at every finite $m$. This proves the corollary. $\square$

The family establishes failure at arbitrarily high single-step fidelity, with an explicit discrepancy decreasing as $(m+1)^{-2}$. No optimal discrepancy or universal weak-noise coefficient is claimed. The phase-sensitive canonical model remains the same throughout.

## 7. The exact test for a repeated gate law

For a random qubit gate with mean Bloch rotation $R$, independent repeats have mean Bloch action $R^j$. Fix a unit Bloch input direction $z$ and write $t_j=z^{\mathsf T}R^jz$ and $a=t_1$. Then the survival probability is $(1+t_j)/2$. The scalar law for every $j\ge1$ is equivalent to the two observations $t_2=a^2$ and $t_3=a^3$.

In the decomposition $z^\perp\oplus\mathbb Rz$ put $R=\left(\begin{smallmatrix}B&u\\v^{\mathsf T}&a\end{smallmatrix}\right)$. The two defects measure $v^{\mathsf T}u$ and $2av^{\mathsf T}u+v^{\mathsf T}Bu$. When they vanish, Cayley–Hamilton on the two-dimensional block $B$ forces every return kernel $v^{\mathsf T}B^ju$ to vanish. In expanding the product, any term leaving the longitudinal coordinate and returning contains such a kernel, so only the entirely longitudinal term $a^j$ remains. The converse is immediate. Two-step measurements alone fail even for a deterministic gate: a rotation by $120^\circ$ about $(1,1,1)$ cyclically permutes the axes, giving $t_1=t_2=0$ and $t_3=1$ for a coordinate input. This is also a special case of the general finite-dimensional exact equivalence principle discussed below.

## 8. Qubit calibration under arbitrary switching

Fix a pure input direction $z$. A finite library of gate laws has mean Bloch rotations $R_i$. Upon each use sample the selected law independently. Write $a_i=z^TR_i z$ and $t(w)=z^TR_{w_n}\cdots R_{w_1}z$; the measured fixed-input survival probability is $(1+t(w))/2$. Define the observable calibration defect
$$
 \epsilon=\max_{2\le |w|\le3}|t(w)-\prod_{i\in w}a_i|.
$$
The product is over word positions, including repeats. For every $n$ and word $w$ of length $n$,
$$
 |t(w)-\prod_{i\in w}a_i|\le\min(2,24n^3\epsilon).
$$
Conversely, with only three physical gate laws, for every integer $k\ge1$ and every $0<\epsilon_0\le1$, there is a library with calibration defect at most $\epsilon_0$ and a length $3k$ word whose discrepancy is at least $c\min(1,k^3\epsilon_0)$ for an absolute $c>0$. Thus the cube-root horizon for uniform scalar prediction is optimal over gate libraries even when every two-step measurement is exactly consistent. At zero error the upper bound gives exact closure. Section 9.5 also derives exact closure from the general finite-state equivalence argument. The length-three observations contain genuine information even when one repeatedly uses a single deterministic cyclic permutation of the three Bloch axes.

### 8.1. Direct upper bound for qubits

In $z^\perp\oplus\mathbb R z$ put $R_i=\left(\begin{smallmatrix}B_i&u_i\\ v_i^T&a_i\end{smallmatrix}\right)$. These matrices are contractions, being averages of rotations. Expanding length two and three gives $|v_i^T u_j|\le\epsilon,\ |v_i^TB_j u_h|\le3\epsilon=:\delta$, uniformly over all ordered indices. Let $U=\max\|u_i\|,\ V=\max\|v_i\|$. If $UV\le2\delta$, every kernel $v^TB_\ell\cdots B_1u$ has modulus at most $2\delta$. Otherwise take $e_2=v_*/V$ for a maximizing read vector, and a unit perpendicular $e_1$. All $|e_2^Tu|\le\delta/V$. A maximizing $\hat u$ has $|e_1^T\hat u|\ge U/2$. Using $|v^T\hat u|\le\delta$ gives $|v^Te_1|\le4\delta/U$ for every read vector. Likewise $|e_2^TB_j\hat u|\le\delta/V$ and $\|B_j\|\le1$ give $|e_2^TB_j e_1|\le4\delta/(UV)$ for every gate. Under a length $\ell$ transverse product the propagated vector stays of norm at most $U$ and its second component grows in modulus by at most $4\delta/V$ per step. The return kernel therefore has modulus at most $(5+4\ell)\delta$. This proof also handles $\delta=0$ (a vanishing $U$ or $V$ belongs to the first case).

Let $t_j$ be the observed longitudinal component after $j$ positions of the word, with $t_0=1$. Its transverse component starts at zero. Unrolling its linear recurrence yields
$$
 t_j-a_j t_{j-1}
  =\sum_{i<j}v_j^TB_{j-1}\cdots B_{i+1}u_i\,t_{i-1}.
$$
Here the subscripts denote positions of the word. Since $|t_j|,|a_j|\le1$, telescoping gives a sum over $i<j$ bounded by $\delta\sum_{i<j}(5+4(j-i-1))\le 8n^3\delta$, with the same upper bound in the small-$UV$ case. This gives the claimed constant without a smallest-eigenvalue, observability or spectral-gap assumption.

### 8.2. Sharp physical obstruction

Choose an orthonormal triple $e_1,e_2,z$. Use
$$
 W=(1-p)I+p\,e_1 z^T,\qquad R=(1-p)I+p\,z e_2^T,
 \qquad Z=\text{rotation around }z\text{ by }\phi .
$$
The rank-one Bloch map $ab^T$ for unit $a,b$ is physical: average the identity and a half-turn about $b$ to obtain $bb^T$, then rotate $b$ to $a$. Mixing this finite ensemble with the identity realizes $W,R$ by canonical SU(2) random gates. A transverse excursion can start only at $W$, and return only at $R$; their two transverse vectors are perpendicular. All two-letter words are exact. The only defective three-letter word is $WZR$ in application order and its defect is $p^2|\sin\phi|$. For $W^kZ^kR^k$ the nilpotence of $e_1z^T$ and $ze_2^T$ gives discrepancy
$$
 k^2p^2(1-p)^{2k-2}|\sin(k\phi)|.
$$
Choose $p=\phi=\tfrac12\min(k^{-1},\epsilon_0^{1/3})$. Then the defect is at most $\epsilon_0$, $kp\le1/2$, $(1-p)^{2k-2}\ge e^{-2}$ by $\log(1-p)\ge-2p$, and $\sin(k\phi)\ge k\phi/2$. This proves the lower bound, e.g. $c=e^{-2}/16$. Thus a generic accumulation argument of order $n\epsilon$ or $n^2\epsilon$ is impossible even in the SU(2) model.

## 9. Arbitrary dimension and the sharp calibration exponent

Let $z\in\mathbb R^{m+1}$ be a unit vector, $m\ge2$, and let $R_i$ be any finite library of real Euclidean contractions. Write $a_i=z^{\mathsf T}R_i z$. For a word $w=(w_1,\ldots,w_n)$ in application order, set $t(w)=z^{\mathsf T}R_{w_n}\cdots R_{w_1}z$ and $a(w)=\prod_j a_{w_j}$. The calibration defect is
$$
 \varepsilon=\max_{2\le |w|\le m+1}|t(w)-a(w)|.
$$
All ordered words, including repeated letters, are used in this definition. For every word of length $n$,
$$
 |t(w)-a(w)|\le\min\{2,C_m n^{m+1}\varepsilon\},
 \qquad C_m=2^{m-1}(3^m-1).
$$
This exponent is sharp even for libraries of $m+1$ mean rotations, each the mean of a finitely supported probability law on $\mathrm{SO}(m+1)$. For every $k\ge1$ and $0<\varepsilon_0\le1$, there is such a library whose calibration defect is at most $\varepsilon_0$, and a word of length $(m+1)k$ with discrepancy at least
$$
 e^{-2}4^{-m}\min\{1,k^{m+1}\varepsilon_0\}.
$$
All its words of lengths at most $m$ satisfy the scalar law exactly. At $m=2$ this is the physical Bloch-rotation model for independently sampled qubit gates, and §8 independently gives a direct proof of the cubic exponent.

### 9.1. What short words control

In $z^\perp\oplus\mathbb Rz$, put $R_i=\left(\begin{smallmatrix}B_i&u_i\\v_i^{\mathsf T}&a_i\end{smallmatrix}\right)$. Each $B_i$ is a contraction. The word prefixes have transverse states $x_j$ and longitudinal states $t_j$, starting at $x_0=0,t_0=1$. With subscripts for the word positions, $x_j=B_jx_{j-1}+u_jt_{j-1}$ and $t_j=a_jt_{j-1}+v_j^{\mathsf T}x_{j-1}$. Unrolling the first recurrence gives
$$
 t_j-a_jt_{j-1}=\sum_{i<j}v_j^{\mathsf T}B_{j-1}\cdots B_{i+1}u_i\,t_{i-1}.
$$
Consequently
$$
 |v^{\mathsf T}B_{\ell}\cdots B_1u|\le 2^{\ell+1}\varepsilon
 \quad(0\le\ell\le m-1)
$$
for arbitrary write vector $u$, read vector $v$, and intervening library blocks. Indeed apply the recurrence to the corresponding word of length $\ell+2$. The left side of the recurrence has absolute value at most $2\varepsilon$ by subtracting the scalar predictions at the final position and its prefix. On the right, the first term is the full kernel since $t_0=1$. The remaining terms have shorter kernels, each multiplied by a prefix observation of modulus at most one. Induction gives $2\varepsilon+\varepsilon\sum_{r=0}^{\ell-1}2^{r+1}=2^{\ell+1}\varepsilon$. At $\ell=0$ there is no sum.

### 9.2. Scaled reachability basis

Start with $V_0=\{0\}$. At stage $k$ the candidates are all $u_i$ and all $B_j(r_i e_i)$ with $i<k$, where $e_1,\ldots,e_{k-1}$ are the orthonormal directions already chosen, and the scalar $r_i$ is their recorded projection scale. Choose a candidate $c_k$ maximizing the norm of its projection onto $V_{k-1}^\perp$. Call that norm $r_k$. If $r_k>0$, let this projection be $r_ke_k$ and set $V_k=V_{k-1}+\mathbb R e_k$. Stop at zero residual or after $m$ independent directions. Write $d$ for the number of choices. In the zero-residual case, all write vectors lie in $V_d$ and each $B_j$ preserves $V_d$, by the candidate definition. If $d=0$, every return kernel is zero.

The positive scales are nonincreasing. Old candidates have smaller residual in the next subspace, and newly added candidates have norm at most $r_{k-1}$ by contraction. For $i<k$ one also has $|\langle c_k,e_i\rangle|\le r_i$. If $c_k$ was already a candidate at stage $i$, use its residual bound there. Otherwise $c_k$ has norm at most $r_j$ for some $j\ge i$ and hence at most $r_i$.

The identity
$$
 r_ke_k=c_k-\sum_{i<k}\frac{\langle c_k,e_i\rangle}{r_i}\,(r_i e_i)
$$
therefore expresses $r_ke_k$ as a linear combination of vectors $B_wu_j$ with $|w|\le k-1$ and with coefficient absolute sum at most $3^{k-1}$. At $k=1$ it is one write vector. For $k>1$ the candidate $c_k$ itself is either a write vector or one block times a previous basis vector at its scale; its coefficient sum is at most $3^{k-2}$. Adding the previous solutions costs at most $\sum_{i<k}3^{i-1}$, so the claimed bound follows. By §9.1, every read vector consequently satisfies
$$
 |v^{\mathsf T}e_k|\le 2^m3^{k-1}\varepsilon/r_k .
$$

### 9.3. Propagating a transverse state

For any write vector $u$ and transverse product $x(s)=B_s\cdots B_1u$, define
$$
 z_k(s)=\|\operatorname{proj}_{V_{k-1}^\perp}x(s)\|/r_k,\quad 1\le k\le d .
$$
These numbers start at most one. When applying another block, its action on the current $V_{k-1}^\perp$ component is contractive. For $i<k$, the projection of $B_j(r_i e_i)$ onto $V_{k-1}^\perp$ has norm at most $r_k$ by the candidate maximum, and $|\langle x(s),e_i\rangle|/r_i\le z_i(s)$. Thus
$$
 z_k(s+1)\le z_k(s)+\sum_{i<k}z_i(s).
$$
Induction on $s$ gives $z_k(s)\le(s+1)^{k-1}$. For the inductive step, $\sum_{i<k}(s+1)^{i-1}\le(k-1)(s+1)^{k-2}\le(s+2)^{k-1}-(s+1)^{k-1}$ for $k\ge2$. The first coordinate bound is constant.

The return kernel after $s$ intervening blocks is therefore bounded by
$$
 |v^{\mathsf T}x(s)|\le 2^m\varepsilon\sum_{k=1}^d 3^{k-1}(s+1)^{k-1}
    \le C_m\varepsilon(s+1)^{m-1}.
$$
The small basis scales cancel between the write and read bounds. Telescoping the longitudinal recurrence in §9.1 against the purely scalar prediction uses at most $n(n-1)/2$ such kernels and only multipliers of modulus at most one. Since $s+1\le n$, it gives the stated bound. The alternative bound two follows from contraction.

### 9.4. Rotational construction attaining the exponent

Take orthonormal $e_1,\ldots,e_m,z$. Use the gate letters
$$
\begin{gathered}
 W=(1-p)I+p e_1 z^{\mathsf T},\quad
 R=(1-p)I+p z e_m^{\mathsf T},\\
 Z_j=\text{rotation from }e_j\text{ toward } e_{j+1}\text{ by }\phi
 \quad(1\le j<m),
\end{gathered}
$$
where $Z_j$ acts as the identity off its plane. For unit $a,b$, the rank-one map $ab^{\mathsf T}$ is a finite mean of rotations. In an orthonormal basis of $b^\perp$, average all diagonal sign changes with an even number of sign flips, extending each by the identity on $b$. Since $m\ge2$, each transverse sign has average zero, giving mean $bb^{\mathsf T}$. Then left multiply by a rotation sending $b$ to $a$. Mixing with the identity shows that all the displayed contractions belong to the stipulated rotation class.

A nonzero transverse return requires a write at $W$, movement from $e_1$ to $e_m$, and a read at $R$. Each rotation advances through at most one neighboring coordinate, and the transverse blocks of $W,R$ are scalar. A return thus costs at least $m+1$ letters. Up to that length the only nonzero discrepancy is from $WZ_1\cdots Z_{m-1}R$, of modulus $p^2|\sin\phi|^{m-1}$. For the word $W^k Z_1^k\cdots Z_{m-1}^k R^k$ the two rank-one increments in $W,R$ are nilpotent of index two. All $Z_j$ fix $z$, and the transverse entry from $e_1$ to $e_m$ of the given ordered plane rotations is $\sin(k\phi)^{m-1}$. The absolute discrepancy is consequently
$$
 k^2p^2(1-p)^{2k-2}|\sin(k\phi)|^{m-1}.
$$
Put $p=\phi=\tfrac12\min(k^{-1},\varepsilon_0^{1/(m+1)})$. The short-word defect is at most $\varepsilon_0$. Since $kp\le1/2$, one has $(1-p)^{2k-2}\ge e^{-2}$ and $\sin(k\phi)\ge k\phi/2$. Substituting gives the claimed sharp exponent and constants.

### 9.5. Relation to earlier work and finite replay

The zero-defect case is a standard finite-word equivalence principle. Indeed, work with the augmented $(m+2)$-dimensional matrices $R_i\oplus a_i$ and starting vector $(z,1)$. The span of states reached by words of length at most $j$ either stabilizes or gains dimension at each step, so it is generated by depth $m+1$. The read functional $(z^{\mathsf T},-1)$ then vanishes on the whole reachable space if it vanishes up to that depth. This is the exact reasoning of weighted or probabilistic automata equivalence, and the quantum Mealy analogue uses an operator-state space. The quantitative estimate here instead uses contraction and cancels basis scales to give a uniform bound on nonzero errors, together with a matching rotational obstruction for every $m$. [Tzeng, probabilistic automata equivalence](https://doi.org/10.1137/0221017) · [Wang–Liu–Ying, Theorem 3.1](https://arxiv.org/abs/1901.02173)

Related gate-fidelity estimates use average-gate fidelities and unitarity, whereas the present scalar involves repeated fixed-input expectation for independently sampled gates. In dimension three, $\mathrm{SO}(3)$ rotations lift to physical qubit gates under $\mathrm{SU}(2)$. For larger $m$, the theorem describes real rotations and Euclidean contractions, without identifying $\mathrm{SO}(m+1)$ with any qudit Bloch representation. [Lacalle–Pozo Coronado–Martín-Cuevas](https://doi.org/10.1007/s11128-025-05037-5) · [Carignan–Dugas–Wallman–Emerson](https://arxiv.org/abs/1610.05296)

Petreczky–Bako–van Schuppen, Theorem 4 and its appendix proof, describe the finite span-reachability test for discrete-time switched systems and the resulting invariant subspace. Oymak–Ozay, Theorem 5.3 and Corollary 5.4, quantify perturbations of a recovered realization for one time-invariant system with a lowest Hankel singular value in the estimate. Here we bound the observed scalar for every long word of a switched library directly from the scalar short-word observations, including arbitrarily weakly reachable directions. [Petreczky et al., Theorem 4](https://arxiv.org/pdf/1103.1343#page=7) · [Oymak–Ozay, §5](https://arxiv.org/pdf/1806.05722#page=8)

Petreczky–Ortega–Rossmannek–Daróczy study arbitrary-switching sub-Markov parameters and characterize uniform decay at all lengths and exponential stability of a minimal realization. Their Theorem 3.1, Corollary 4.6 and Theorem 4.7 use reachability and observability, with inverse norms in the control of hidden coordinates. The scalar estimate here starts from a single depth-$m+1$ calibration and needs no lower singular bound or stability assumption stronger than contraction. [Petreczky et al. 2026, Theorem 3.1, Corollary 4.6 and Theorem 4.7](https://arxiv.org/pdf/2607.03849v1)

The standard-library program `evidence/r02/verify_exact.py` verifies the short-word discrepancy exactly in real dimensions three to five and 25 long-word identities in dimensions three to seven, using a rational cosine–sine pair on the unit circle. The proof covers all dimensions and calibration levels.

## 10. Reproduction and scope

The exact continuous-law calculations in the original appendices retain their separate analytic and finite checks. The short- and long-word examples in §9 have a rational matrix replay. The physical gate statements assume independent uses and one fixed input direction. The higher-dimensional rotation examples refer to real Euclidean spaces. The original Lean modules cover discrete algebra and selected finite certificates, and the formalization tasks for this full paper are listed separately. [Original reproduction guide](evidence/README.md)

## Appendix A. A simpler mean-centered pair

A lower-degree example displays the same obstruction with smaller denominators. Set

$$
g_A=f_0+\frac12x_0x_2,\qquad
g_B=f_0+\frac12x_1x_3.
\tag{36}
$$

The bound $|x_jx_k|\le1/2$ gives $g_A,g_B\ge1/4$. Both are smooth, integrate to one by parity, and have mean $e_0/16$ because their additional first-moment integrands have odd total degree. The diagonal second moments remain those of $f_0$. Their respective nonzero off-diagonal moments are $m_{02}=1/48$ and $m_{13}=1/48$, by (19). Consequently

$$
\rho_{g_A}=\rho_{g_B}=
\begin{pmatrix}13/24&1/48\\1/48&11/24\end{pmatrix},
\quad
q_{g_A\leftarrow g_A}=\frac{193}{384},\qquad
q_{g_B\leftarrow g_B}=\frac{581}{1152}.
\tag{37}
$$

The scalar prediction is $145/288=580/1152$, and the two discrepancies are $\mp1/1152$. Both two-step squared-fidelity values are strictly between $1/2$ and $13/24$. No unique-mode claim is made for this simpler pair; the cubic correction in (5) supplies that additional property for the main construction.

## Appendix B. Exact finite quadrature and reproducibility

Let $Q$ consist of the eight signed coordinate unit vectors and the sixteen vectors in $\{-1/2,1/2\}^{4}$, with equal weights $1/24$. This rule integrates every polynomial of total degree at most five exactly under $H$.

Indeed, its node set is invariant under coordinate reflections and permutations. Odd-coordinate monomials average to zero. For the remaining monomials its moments are

$$
\frac{2+16/4}{24}=\frac14,\qquad
\frac{2+16/16}{24}=\frac18,\qquad
\frac{16/16}{24}=\frac1{24},
\tag{38}
$$

for $x_j^2$, $x_j^4$, and $x_j^2x_k^2$ with $j\ne k$, respectively. Together with the constant moment these exhaust the even-coordinate monomials of total degree at most five, and agree with (19). Linearity proves exactness.

Each density in (5) or (36) has degree at most three. Its product with a first- or second-moment observable has degree at most five. The squared first-entry magnitude of $U(X_2)U(X_1)$ has degree two in each spinor separately. After weighting by these densities, its degree is at most five in each spinor. The tensor-product quadrature therefore exactly reproduces the integrals for the core and simpler paired constructions. The higher-degree family in Corollary 4 is checked separately.

The companion `code/exact_moments.py` checks polynomial moments using rational arithmetic: its recorded run passes 171 assertions, including 126 monomial cases through degree five. An independent implementation, `code/independent_cubature.py`, explicitly multiplies complex $2\times2$ matrices without importing the correction formula or the moment verifier. Its recorded run checks 24 unitary nodes and 4,608 ordered matrix products across eight law-pair cases. From the case directory, the checks can be reproduced with:

```bash
python evidence/code/exact_moments.py
python evidence/code/independent_cubature.py
python evidence/code/high_fidelity_family.py
```

The last script reuses the polynomial integrator to check the higher-degree family by exact sphere-polynomial integration at $m=3,4,5,8,12,16,24,32$, passing 160 assertions in the recorded run. These finitely many cases supplement the analytic proof for every integer $m\ge3$; they do not replace it.

These computations provide exact arithmetic cross-checks. The equality between the finite quadrature and the continuous laws follows from the analytic argument above; finite enumeration by itself does not establish that bridge.

## References

1. J. Lacalle, L. M. Pozo Coronado, and R. Martín-Cuevas. *Fidelity of the sum of independent quantum computing errors*. Quantum Information Processing **25**, 38 (2026). [doi:10.1007/s11128-025-05037-5](https://doi.org/10.1007/s11128-025-05037-5). Relevant locations: Definition 1, Conjecture 1, and the isotropic fidelity result.

2. J. Lacalle and L. M. Pozo Coronado. *Variance of the sum of independent quantum computing errors*. [arXiv:2412.15800v1](https://arxiv.org/abs/2412.15800v1), deposited 20 December 2024. Cited for the distinct variance problem.

3. A. Carignan-Dugas, J. J. Wallman, and J. Emerson. *Bounding the average gate fidelity of composite channels using the unitarity*. New Journal of Physics **21**, 053016 (2019). [doi:10.1088/1367-2630/ab1800](https://doi.org/10.1088/1367-2630/ab1800); [arXiv:1610.05296v4](https://arxiv.org/abs/1610.05296v4).

4. A. Carignan-Dugas, Matthew Alexander, and J. Emerson. *A polar decomposition for quantum channels (with applications to bounding error propagation in quantum circuits)*. Quantum **3**, 173 (2019). [doi:10.22331/q-2019-08-12-173](https://doi.org/10.22331/q-2019-08-12-173). Cited for coherent/decoherent channel structure and error-propagation context, not for a theorem-by-theorem novelty exclusion.

5. Jacob Biamonte. *The Quantum Composition Paradox*. [arXiv:2609.11402v1](https://arxiv.org/abs/2609.11402v1), 10 September 2026. Relevant locations: Appendix C.1, Proposition C.2, Eq. (53); Appendix C.2, Theorem C.5, Eqs. (60)–(67).
