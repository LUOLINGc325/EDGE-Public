# A sharp pure-state ECQC bound for qutrits

*A minimal-dimensional counterexample, all equality cases, and an exact white-noise threshold*

24 November 2026

**AI-assisted public research draft.** The manuscript has not undergone external peer review, and the complete quantum-information theorem is not an end-to-end Lean formalization.

# Abstract

For a bipartite qutrit state, consider the classical mutual informations obtained by measuring both parties in each of the four standard mutually unbiased bases, with the same basis used on the two parties. The extended complementary quantum correlations proposal, ECQC, compares the sum of the three smallest such quantities with the original quantum mutual information. General ECQC and its general pure-state specialization already have counterexamples in prior work. Here we settle the remaining qutrit pure-state question and determine its sharp multiplicative replacement. An explicit Schmidt-rank-two state has one bit of classical mutual information in every basis and two bits of quantum mutual information, so the ECQC score is three bits. The optimal pure-state coefficient is consequently $3/2$. We classify every entangled pure equality case: up to global phase there are exactly 81 states, the orbit of an embedded singlet under independent local qutrit Weyl operators. The proof combines the standard equality condition in the Holevo bound with an elementary characterization of the nine Hesse SIC kernel rays and a tetrahedral qubit reduction. For the mixture of the explicit state with white noise, we prove that violation occurs across exactly one threshold and certify its location by rational logarithm bounds. Exact arithmetic checks cover the Born tables, orbit, marginal identities and finite algebraic exclusions; the continuous-state classification is a written proof using explicitly cited standard inputs.

# 1. Problem and relation to prior work

Iqbal's ECQC conjecture [1, Conjecture 3.1] compares quantum mutual information with the smallest sum of $d$ classical mutual informations from $d+1$ same-indexed mutually unbiased measurement bases in prime local dimension $d$. For $d=3$, it uses four measurement settings and omits the setting with the largest classical mutual information. The source reports finite random searches without a counterexample and asks for an analytic treatment of the pure-state specialization.

That general specialization must now be distinguished from its qutrit instance. Wang, Wang and Chen [2] gave a classical–classical mixed-state ECQC counterexample at dimension seven. A subsequent public construction [4] gives a maximally entangled pure-state counterexample at dimension five and explicitly leaves dimension three and sharp replacement bounds unresolved. Qian [3] addresses related two-basis CQC questions; those questions are different from the four-basis score studied here. This manuscript does not claim the first refutation of general ECQC or of general pure-state ECQC.

Our results concern a precisely fixed measurement family. For that family we give a minimal-dimensional pure-state counterexample, the optimal pure-state multiplicative coefficient, all entangled pure equality states, and the complete white-noise sign diagram of the explicit witness. The elementary upper bound follows from Holevo's theorem; the new attainment and equality classification are the main structural content. Neither Holevo's bound and its equality criterion [5] nor the Hesse SIC geometry [6] is claimed as a new tool. A nearby two-basis triangular-discrimination result [7] also involves the Hesse configuration, but optimizes a different functional over a different state class.

Each measurement setting is performed on separately prepared copies of the state. Adding the resulting information scores can count overlapping correlation repeatedly. The counterexample does not create information and does not contradict data processing for a single measurement channel.

# 2. Conventions and the measurement family

All logarithms are base two, unless explicitly written as $\ln$. For a probability vector $p$, write

$$
H(p)=-\sum_j p_j\log_2 p_j,
\qquad 0\log_2 0=0.
$$

The von Neumann entropy is $S(\rho)=-\operatorname{Tr}(\rho\log_2\rho)$. Put $\omega=e^{2\pi i/3}$ and use indices in $\mathbb F_3$. Define the four matrices of basis columns by

$$
U_\infty=I_3,
\qquad
(U_b)_{xk}=\frac{1}{\sqrt3}\omega^{b x^2+kx},
\qquad b=0,1,2. \tag{1}
$$

They are orthonormal bases and mutually unbiased. Orthogonality within one finite basis follows from the sum of a nontrivial additive character. Between two different finite bases, the inner product is one third of a nondegenerate quadratic Gauss sum and has squared modulus $1/3$. The computational basis is unbiased with each finite basis by inspection. A direct proof of the Gauss-sum identity is given in Section 5.2.

Both parties use the **same** basis $U_b$. In Iqbal's qutrit ordering [1, equation (25)], the matrices are $U_\infty,U_0,U_2,U_1$; the set and the score are therefore exactly the same. Replacing Bob's basis by its complex conjugate would define a different assertion.

Represent a normalized pure state by its coefficient matrix $C$:

$$
|\psi_C\rangle=\sum_{x,y}C_{xy}|x\rangle|y\rangle,
\qquad \operatorname{Tr}(CC^\dagger)=1.
$$

The physical marginal states and the measured amplitude matrices are

$$
\rho_A=CC^\dagger,
\qquad \rho_B=C^T\overline C,
\qquad C^{(b)}=U_b^\dagger C\overline{U_b}. \tag{2}
$$

In particular, the right-hand factor in the amplitude transformation is $\overline{U_b}$, not $U_b$ or $U_b^\dagger$. Let

$$
p^{(b)}_{jk}=|C^{(b)}_{jk}|^2,
\qquad I_b=H(p^{(b)}_{j\bullet})+H(p^{(b)}_{\bullet k})-H(p^{(b)}).
$$

For the index set $\mathcal B=\{\infty,0,1,2\}$, define

$$
J(C)=\min_{\substack{\mathcal S\subseteq\mathcal B\\|\mathcal S|=3}}
\sum_{b\in\mathcal S}I_b
=\sum_{b\in\mathcal B}I_b-\max_{b\in\mathcal B}I_b. \tag{3}
$$

For a pure state, let $E=S(\rho_A)=S(\rho_B)$ and $Q=I(A:B)=2E$. Product states have $E=J=Q=0$. Statements about the ratio $J/Q$, and the classification of its maximizers, refer to entangled pure states.

# 3. The sharp coefficient and a minimal witness

**Theorem 1 (sharp pure-state bound).** Every normalized pure state on $\mathbb C^3\otimes\mathbb C^3$ satisfies

$$
J\le\frac32 Q. \tag{4}
$$

The coefficient $3/2$ cannot be decreased for the bases (1). It is attained by

$$
|\psi_*\rangle=
\frac{|01\rangle+|02\rangle-|10\rangle-|20\rangle}{2}. \tag{5}
$$

This state has Schmidt rank two, $Q=2$ bits and $J=3$ bits. Local dimension three and Schmidt rank two are minimal for a pure-state ECQC violation.

**Proof.** Measuring Alice in any rank-one basis produces an ensemble of pure conditional states on Bob whose average is $\rho_B$. The Holevo quantity of that ensemble is $E$. Bob's subsequent measurement therefore yields $I_b\le E$ [5]. It follows immediately that $J\le3E=3Q/2$. This step is a standard bound and does not itself require mutually unbiased bases.

For attainment, put

$$
f=\frac{|1\rangle+|2\rangle}{\sqrt2},
\qquad h=\frac{|1\rangle-|2\rangle}{\sqrt2},
\qquad W=h^\perp=\operatorname{span}\{|0\rangle,f\}.
$$

Then $|\psi_*\rangle=(|0\rangle\otimes f-f\otimes|0\rangle)/\sqrt2$, the singlet on $W\otimes W$. Both reduced states have eigenvalues $(1/2,1/2,0)$, so $E=1$ and $Q=2$. Its coefficient matrix is

$$
C_*=\frac12
\begin{pmatrix}
0&1&1\\-1&0&0\\-1&0&0
\end{pmatrix}.
$$

For each finite $b$,

$$
U_b^\dagger h=
\frac{\omega^{-b}}{\sqrt6}
\begin{pmatrix}0\\\omega^2-\omega\\\omega-\omega^2\end{pmatrix}, \tag{6}
$$

which is a phase multiple of $h$. Thus $U_b^\dagger$ preserves $W$. Its induced action on the one-dimensional space $\bigwedge^2 W$ is multiplication by a phase, so applying $U_b^\dagger$ to both factors preserves the ray of $\psi_*$. Consequently all four exact Born tables are

$$
p^{(\infty)}=p^{(0)}=p^{(1)}=p^{(2)}
=\frac14\begin{pmatrix}0&1&1\\1&0&0\\1&0&0\end{pmatrix}. \tag{7}
$$

The two marginals are $(1/2,1/4,1/4)$, of entropy $3/2$, and the joint entropy is $2$. Hence every $I_b=1$, proving attainment.

For pure bipartite qubit states the ECQC score selects two of three settings. The same Holevo estimate gives a score at most $2E=Q$, so no pure-state violation exists in local dimension two. A Schmidt-rank-one pure state is a product and has zero mutual information in every setting. These observations establish both minimality claims within the pure-state class. $\square$

# 4. Statement of the complete equality classification

Let the qutrit Weyl operators be

$$
X|x\rangle=|x+1\rangle,
\qquad Z|x\rangle=\omega^x|x\rangle,
\qquad D_{r,s}=X^rZ^s. \tag{8}
$$

Global phase conventions for $D_{r,s}$ do not affect any statement below.

**Theorem 2 (all pure equality states).** A normalized entangled pure state satisfies equality in (4) if and only if, up to a global phase,

$$
|\psi\rangle=(D_{r,s}\otimes D_{r',s'})|\psi_*\rangle,
\qquad r,s,r',s'\in\mathbb F_3. \tag{9}
$$

The 81 choices give 81 distinct state rays. Every one has Schmidt probabilities $(1/2,1/2,0)$ and $(J,Q)=(3,2)$ bits.

The theorem concerns the fixed complete set (1) and the same-indexed measurements on the two parties. It does not classify mixed-state maximizers, arbitrary independently rotated local measurement sets, or maximizers of an additive rather than multiplicative discrepancy.

# 5. Proof of Theorem 2

## 5.1 Equality in the information bound

We use the standard equality condition for the Holevo bound: if a measurement attains the Holevo quantity of an ensemble, its density operators commute [5, Sections 7.1–7.3, equations (48) and (51)]. For a pure-state ensemble, commuting rank-one projectors are either identical or orthogonal. Grouping identical rays produces an orthogonally encoded classical label $K$. A prescribed measurement attains the bound only if it determines $K$ without error, because its information is $H(K)-H(K\mid Y)$. Distinct ray classes therefore have disjoint outcome supports.

This statement records both the ensemble condition and the condition on the prescribed measurement. Commutativity by itself does not make an arbitrary measurement optimal.

At $J=3E$ with $E>0$, every one of the four $I_b$ equals $E$. Indeed the sum of the three smallest quantities bounded above by $E$ equals $3E$ only when each is $E$; the largest must then also be $E$. We exclude Schmidt ranks three and nonuniform rank two before treating the remaining case.

## 5.2 Excluding Schmidt rank three

If $C$ has rank three, the three conditional vectors on Bob obtained from any Alice basis are nonzero and linearly independent. The equality condition forces them to be mutually orthogonal. Their Gram matrix is, up to conjugation, the matrix of $\rho_A$ in that basis. Thus $\rho_A$ is diagonal in every one of the four bases.

Already the computational and Fourier bases force $\rho_A=I_3/3$. To verify this directly, a density matrix diagonal in the computational basis has all three Fourier diagonal entries equal to $1/3$. If it is also diagonal in the Fourier basis, it must be $I_3/3$. Accordingly $C=V/\sqrt3$ for a unitary matrix $V$ and $E=\log_2 3$.

The condition $I_\infty=\log_2 3$, with both marginals uniform, makes the computational joint law a permutation coupling. Thus $V$ is monomial. Every permutation of $\mathbb F_3$ is affine, so

$$
V_{ay+c,y}=e^{i\theta_y},
\qquad a\in\{1,2\},\ c\in\mathbb F_3. \tag{10}
$$

For the Fourier basis,

$$
(U_0^\dagger V\overline{U_0})_{jk}
=\frac{\omega^{-jc}}3\sum_y e^{i\theta_y}\omega^{-(aj+k)y}. \tag{11}
$$

As $k$ varies in a row, this lists all Fourier coefficients of the three phases. The condition $I_0=\log_2 3$ requires another monomial matrix. Hence exactly one of those Fourier coefficients is nonzero, which gives

$$
e^{i\theta_y}=\zeta\omega^{\ell y},
\qquad |\zeta|=1,\quad \ell\in\mathbb F_3. \tag{12}
$$

There are $2\cdot3\cdot3=18$ remaining matrices up to global phase. More importantly, all of them can be excluded at once. In the basis $U_1$, each entry, apart from a phase, is one third of

$$
\sum_{y\in\mathbb F_3}\omega^{-(a^2+1)y^2+Ly}. \tag{13}
$$

The quadratic coefficient is nonzero, since $a^2=1$ modulo three. For any $q\ne0$ in $\mathbb F_3$,

$$
\left|\sum_y\omega^{qy^2+Ly}\right|^2
=\sum_{h\in\mathbb F_3}\omega^{qh^2+Lh}
  \sum_{z\in\mathbb F_3}\omega^{2qhz}
=3. \tag{14}
$$

Here the substitution is $y=z+h$, and only $h=0$ survives the inner character sum. Therefore every entry of $U_1^\dagger V\overline{U_1}$ has squared modulus $1/3$. For the normalized state $C=V/\sqrt3$, the Born table is uniform on nine outcomes and $I_1=0$. This contradicts $I_1=E=\log_2 3$ and excludes rank three.

## 5.3 Excluding unequal rank-two Schmidt probabilities

Suppose the positive Schmidt probabilities are $\lambda$ and $1-\lambda$ with $\lambda\ne1/2$. Let $u,v$ be the corresponding eigenvectors of $\rho_A$. In any basis attaining Holevo equality, Bob's pure conditional states commute. Since their average has a nondegenerate positive spectrum, each such ray must be one of its two eigenrays. A measurement vector on Alice can therefore overlap at most one of $u$ and $v$.

The supports of $u,v$ are consequently disjoint in both the computational and Fourier bases. Two nonempty disjoint supports in three coordinates force at least one vector to have singleton computational support. Such a vector has all three Fourier coefficients nonzero, because every Fourier matrix entry has modulus $1/\sqrt3$. There is no nonempty Fourier support left for the other vector. This contradiction excludes unequal rank-two Schmidt probabilities.

## 5.4 The nine possible marginal kernel rays

We are left with

$$
\rho_A=\frac12(I-|h_A\rangle\langle h_A|),
\qquad
\rho_B=\frac12(I-|h_B\rangle\langle h_B|). \tag{15}
$$

In any Alice basis, the Gram matrix of the conditional Bob vectors is, up to a positive factor and conjugation,

$$
G_{jk}=\delta_{jk}-h_j\overline{h_k},
\qquad h_j=\langle e_j,h_A\rangle. \tag{16}
$$

If all three $h_j$ were nonzero, every pair of conditional vectors would have nonzero inner product. Holevo equality would make all of them parallel, whereas their span has dimension two. Thus $h_A$ has a zero coordinate in every measurement basis. Exchanging the parties gives the same conclusion for $h_B$.

A normalized qutrit vector with at least one computational zero and one Fourier zero lies on exactly one of the nine rays

$$
h_{r,s}=D_{r,s}h,
\qquad h=\frac{|1\rangle-|2\rangle}{\sqrt2},
\quad r,s\in\mathbb F_3. \tag{17}
$$

Here is an elementary verification. Two computational zeroes would make the vector a basis vector with no Fourier zero. Therefore exactly two computational coordinates are nonzero. A Fourier zero makes their contributions cancel, forcing equal moduli and a relative phase equal to minus a cube root of unity. There are three choices of the zero coordinate and three phase choices, giving (17).

These are the Hesse SIC rays [6]. Each has probabilities $(0,1/2,1/2)$, up to permutation, in each basis (1). We use this familiar configuration as a derived equality constraint, without making a novelty claim for the configuration itself.

The Weyl operators preserve every basis in (1) as a set of rays. In a finite basis, $Z^s$ changes the column label by $s$ and $X^r$ changes it by $-2br$, up to phase; in the computational basis $X^r$ shifts the coordinate by $r$. Independent local Weyl transformations only relabel measurement outcomes and preserve all four mutual informations. Applying suitable inverses, we may therefore assume $h_A=h_B=h$ in (15). The transformed state is maximally entangled on $W\otimes W$.

## 5.5 Tetrahedral saturation and uniqueness

The unique ray in each basis (1) orthogonal to $h$ is

$$
g_\infty=|0\rangle,
\qquad
g_b=\frac{|0\rangle+\sqrt2\omega^b f}{\sqrt3},
\quad b=0,1,2. \tag{18}
$$

All four rays lie in the two-dimensional space $W$. They satisfy $|\langle g_i,g_j\rangle|^2=1/3$ for $i\ne j$. Their qubit Bloch vectors $n_i$ obey

$$
n_i\cdot n_j=-\frac13\quad(i\ne j),
$$

and span $\mathbb R^3$: they form a regular tetrahedron.

Restricting a three-outcome measurement to $W$ gives the effects

$$
P_i=|g_i\rangle\langle g_i|,
\qquad \frac{I_W-P_i}{2},
\qquad \frac{I_W-P_i}{2}. \tag{19}
$$

Thus it is the binary projective measurement $\{P_i,I_W-P_i\}$ with an independent fair refinement of its second outcome. The refinement does not change the mutual information. Both local binary laws are uniform because the marginals are $I_W/2$. Consequently $I_i=1$ if and only if the binary outcomes are perfectly correlated or perfectly anticorrelated.

For a maximally entangled two-qubit pure state, the real correlation matrix $T$ in Pauli coordinates is orthogonal with determinant $-1$. Indeed such a state is obtained from the singlet by a local unitary; its adjoint action is a rotation in $SO(3)$ and the singlet correlation matrix is $-I_3$. Equality in each measurement therefore gives

$$
n_i^T Tn_i=s_i,\qquad s_i\in\{+1,-1\}. \tag{20}
$$

Since $T$ is orthogonal and $n_i$ is a unit vector, equality in Cauchy–Schwarz implies $Tn_i=s_i n_i$. Preservation of pairwise inner products now yields

$$
-\frac13=(Tn_i)\cdot(Tn_j)=s_i s_j\left(-\frac13\right).
$$

All signs are equal. If they were all positive, the spanning tetrahedron would force $T=I_3$, contradicting its determinant. They must all be negative, giving $T=-I_3$. With maximally mixed marginals the Pauli expansion determines the state uniquely from $T$, so this is exactly the singlet on $W\otimes W$, up to global phase.

Undoing the two Weyl transformations proves the necessity of (9). Conversely every state in (9) preserves the four mutual informations of $\psi_*$ by outcome relabeling. Different pairs of Hesse kernel rays give different pairs of marginal kernels, so all 81 states are distinct rays. This proves Theorem 2. $\square$

# 6. Exact white-noise threshold

The sharp factor in Theorem 1 is a pure-state statement. The following separate result treats one explicitly specified mixed-state family:

$$
\rho_t=t|\psi_*\rangle\langle\psi_*|+(1-t)\frac{I_9}{9},
\qquad 0\le t\le1. \tag{21}
$$

Here $t$ is the visibility and $1-t$ is the white-noise fraction. Because $\psi_*$ is not maximally entangled on the full qutrit space, (21) is not the qutrit isotropic-state family examined in [1]. Set

$$
a=\frac{t+2}{6},\quad b=\frac{1-t}{3},\quad
A=\frac{1+8t}{9},\quad B=\frac{1-t}{9},\quad
r=\frac{4-t}{12},\quad c=\frac{4+5t}{36}.
$$

Direct spectral and Born-rule calculations give the following distributions.

| Quantity | Probability or eigenvalue multiset |
| --- | --- |
| Either quantum marginal | $(a,a,b)$ |
| Global density matrix | $A$, and eight copies of $B$ |
| Either measured marginal, in each basis | $(a,r,r)$ |
| Joint measured table, in each basis | Four copies of $c$, and five copies of $B$ |

Write

$$
\begin{aligned}
C(t)&=2H(a,r,r)-H(c,c,c,c,B,B,B,B,B),\\
Q(t)&=2H(a,a,b)-H(A,B,B,B,B,B,B,B,B),\\
F(t)&=3C(t)-Q(t).
\end{aligned} \tag{22}
$$

Because all four classical mutual informations coincide, $F(t)$ is precisely the excess of the ECQC score over quantum mutual information.

**Theorem 3 (complete threshold for this family).** There is a unique $\alpha\in(0,1)$ such that

$$
F(t)<0\ (0<t<\alpha),\qquad
F(\alpha)=0,\qquad
F(t)>0\ (\alpha<t\le1), \tag{23}
$$

with $F(0)=0$. An exact rational interval calculation gives

$$
0.65787847979876378651
<\alpha<
0.65787847979876378652. \tag{24}
$$

In particular every $t\ge2/3$ violates ECQC. At $t=2/3$ the state is full rank and has white-noise fraction $1/3$.

**Proof.** The distributions in the table follow directly from (7), (15) for the reference state, and linearity of white-noise mixing. They give $F(0)=F'(0)=0$ and $F(1)=1$. Differentiating the explicit entropy expressions gives

$$
(\ln2)F''(t)=
\frac{80t^3+405t^2+696t-128}
{(t-4)(t-1)(t+2)(5t+4)(8t+1)}. \tag{25}
$$

The denominator is positive on $(0,1)$. Its numerator $N(t)$ obeys $N(0)=-128$, $N(1)=1053$ and

$$
N'(t)=240t^2+810t+696>0.
$$

Hence $F''$ changes sign exactly once, from negative to positive. Starting from $F'(0)=0$, the derivative first strictly decreases and then strictly increases. Moreover

$$
F''(t)\sim\frac{13}{9\ln2}\frac1{1-t}
\quad\text{as }t\uparrow1,
$$

so $F'(t)\to+\infty$. There is exactly one interior critical point of $F$, a strict minimum. As $F(0)=0$ and $F(1)=1$, there is exactly one interior zero, and the sign pattern is (23).

For an elementary exact positive point, substitution into (22) gives

$$
27F(2/3)=\log_2\frac{3^{54}11^{66}}{2^{24}5^{90}19^{19}}>0. \tag{26}
$$

The strict inequality is certified by direct arbitrary-precision integer comparison; its positive integer difference is recorded in the accompanying verification output. This strict comparison and the unique-zero result imply violation for every $t\ge2/3$. The decimal value $F(2/3)\approx0.00838187310049322$ bits is explanatory and is not needed for the sign certificate.

To certify (24), positive rational logarithm arguments are rescaled by powers of two into $[1,2]$. For $x$ in that interval, put $z=(x-1)/(x+1)$, so $0\le z\le1/3$. Then

$$
\ln x=2\sum_{j=0}^{m-1}\frac{z^{2j+1}}{2j+1}+R_m,
\qquad
0\le R_m\le\frac{2z^{2m+1}}{(2m+1)(1-z^2)}. \tag{27}
$$

The same bound encloses $\ln2$. Fifty terms, with exact rational interval propagation through (22), give a strictly negative upper bound for $F(t)\ln2$ at the left endpoint of (24) and a strictly positive lower bound at the right endpoint. The recorded enclosures are approximately $-3.618753082760574\times10^{-21}$ and $2.823355685844800\times10^{-21}$, respectively; the machine-readable certificate contains outward-rounded rational endpoints. Together with uniqueness of the zero, these signs prove (24). $\square$

Thus the white-noise fraction can be almost $0.3421215202012362$ before the violation disappears. This is the exact transition for the mixture (21), not a statement about arbitrary perturbations of the same trace distance or a universal mixed-state threshold.

The unique threshold is proved analytically and enclosed by rational arithmetic; the full-rank witness occurs at $t=2/3$.

# 7. Verification and provenance of the claims

The proof has three distinct levels of assurance.

**Written analytic argument.** Theorem 1 uses the standard Holevo bound. The exclusion of all other pure equality states in Theorem 2 uses the standard Holevo equality criterion plus the explicit rank, support and tetrahedral arguments above. The uniqueness of the noise threshold follows from the sign of the rational function (25). These are mathematical arguments over continuous state spaces, not conclusions from random samples.

**Exact finite arithmetic.** The standard-library verifier works in $\mathbb Q(\omega)$, represented by pairs of rational coefficients with $\omega^2+\omega+1=0$. It checks the reference probability tables, the marginal polynomial identities, all 81 orbit states in all four bases, the nine marginal kernel rays, the tetrahedral identities and the 18 monomial candidates arising after (12). These finite checks corroborate the calculations; the proof that the list is exhaustive is Section 5, not the enumeration itself.

**Certified scalar computation.** The root bracket uses rational interval arithmetic and the analytic remainder (27). Equation (25) is independently reconstructed from the entropy formulas and checked as an exact rational-function identity. The white-noise point (26) is also certified by an integer comparison.

The computational files are not included in this edition. No claim here rests on floating-point optimization or a numerical absence of counterexamples. Local formalization of subclaims does not establish end-to-end Lean certification of the entropy equality classification.

# 8. Scope and remaining questions

Entropy, the four classical mutual informations and the minimum of finitely many score sums are continuous. The strict one-bit excess at (5) therefore remains positive in some neighbourhood of that state. This does not supply a random-sampling detection probability or a classification of the whole violating set.

The sharp multiplier $3/2$ applies to pure bipartite qutrit states under the fixed measurement protocol (1). Its complete nonproduct equality set is finite, despite the continuous state space. The Hesse SIC appears as the necessary pair of marginal kernel configurations; the embedded tetrahedron then fixes the remaining entangled state.

Theorem 3 establishes robustness for a single white-noise path and does not determine the optimal mixed-state replacement coefficient. We also do not determine the largest additive value of $J-Q$ over all pure qutrit states, give a stability theorem for near-equality states, or classify all violating states. The relation between a near-maximal score and quantitative proximity to the 81-state orbit is a natural next question, but it is not claimed as a theorem here.

Prior results already refute broader ECQC assertions [2,4]. The bounded contribution of this manuscript is their smallest-dimensional pure-state completion together with a sharp constant, a complete equality classification and an exactly certified noise boundary. No global priority claim is inferred from a finite literature search.

# References

[1] Hasan Iqbal. *On the CQC conjecture: a sufficient condition and an extension.* Quantum Information Processing **25**, 250 (2026). DOI: [10.1007/s11128-026-05258-2](https://doi.org/10.1007/s11128-026-05258-2). Preprint: [arXiv:2509.08286v2](https://arxiv.org/abs/2509.08286v2). Relevant locations: Conjecture 3.1, equation (6); qutrit basis matrices, equation (25); pure-state discussion in Section 5.

[2] Jinbo Wang, Qihang Wang and Kun Chen. *When Complementary Measurements Count the Same Classical Bit Twice: Counterexamples to CQC, ECQC, and Complementarity-Based Certification.* [arXiv:2608.03828v3](https://arxiv.org/abs/2608.03828v3) (2026). Prior mixed-state ECQC refutation; it is credited here rather than presented as an open general conjecture.

[3] Lilong Qian. *Separable Counterexamples to Complementary Quantum Correlations, and Why Random Search Missed Them.* [arXiv:2608.14806v2](https://arxiv.org/abs/2608.14806v2) (2026). Relevant background on the distinct two-basis CQC problem and the limitations of random searches.

[4] trureturing. *Pure-state ECQC fails in dimension five.* [Research record](https://www.trureturing.org/research/iqbal-2025-pure-state-ecqc/) and [proof blueprint](https://the-omega-institute.github.io/trureturing-mdbook/Blueprint/D5/S3/Quantum/Information/PureStateECQCRefutation.html), accessed 24 November 2026. This public record gives the prior dimension-five pure-state construction and leaves dimension three and sharp replacement bounds open. Its reported formal verification has not been independently replayed as part of the present package.

[5] Mary Beth Ruskai. *Inequalities for Quantum Entropy: A Review with Conditions for Equality.* Journal of Mathematical Physics **43**, 4358–4375 (2002). DOI: [10.1063/1.1497701](https://doi.org/10.1063/1.1497701). [arXiv:quant-ph/0205064v2](https://arxiv.org/abs/quant-ph/0205064v2), Sections 7.1–7.3, equations (48) and (51). Standard input: the Holevo bound and the necessity of commuting ensemble states at equality.

[6] Blake C. Stacey. *SIC-POVMs and Compatibility among Quantum States.* Mathematics **4**(2), 36 (2016). DOI: [10.3390/math4020036](https://doi.org/10.3390/math4020036). [arXiv:1404.3774](https://arxiv.org/abs/1404.3774). Relevant background: the nine Hesse SIC rays, Weyl covariance and their relation to qutrit mutually unbiased bases.


[7] Anonymous / Evidence Press. *Sharp qutrit discrimination and unavoidable correlation overcounting for complementary measurements.* Version 0.1.0-candidate, 4 November 2026. DOI: [10.5281/zenodo.23933731](https://doi.org/10.5281/zenodo.23933731). [Paper and evidence entry](https://www.evidencepress.org/releases/qutrit-complementary-discrimination/). An unrefereed neighbouring result on two-basis triangular discrimination, not the four-basis pure-state ECQC functional considered here.
