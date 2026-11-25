# Two-level Pauli spectra and the four-qubit obstruction to mutually unbiased orbits

## Abstract

A binary tensor-Pauli orbit has $d^2$ labels in dimension $d=2^n$. We ask when the orbit of one pure state forms $d$ mutually unbiased orthonormal bases. A two-level Pauli square spectrum measured against one reference state forces its zero labels, with the identity adjoined, to form a Lagrangian subgroup. The bases are its cosets. After a Clifford change of coordinates every fiducial is equimodular, so the existing fourth-root phase reduction for even qubit numbers applies to arbitrary candidates. In four qubits the low bit of the phase must be a quadratic bent function. Its quadratic normal form forces a parity condition on four rows of the high bit, which is impossible. We also classify the one- and two-qubit fiducials, giving 12 and 480 rays respectively, and prove quantitative reconstruction from approximate square spectra. For even $n$, a quantized cubic trace certifies exact reconstruction when the pointwise squared-response error is at most $1/(8d^{7/2})$, using the signs of the high-layer Pauli expectations. This gives an explicit four-qubit gap. The odd-qubit obstruction also has a quantitative form.

## 1. The labeled orbit and main results

Let $d=2^n$, $n\ge1$, and $V=\mathbb F_2^n\oplus\mathbb F_2^n$ with symplectic form $[(a,b),(a',b')]=a\cdot b'+b\cdot a'$. Set $D_{a,b}=i^{|a\wedge b|}X^aZ^b$, where $|a\wedge b|$ is the integer number of simultaneous ones. These are the Hermitian tensor Pauli representatives, including $D_0=I$. For a density matrix $\rho$ write $r_v=\operatorname{Tr}(\rho D_v)$, $f(v)=r_v^2$, and put
$$
 E(\rho)=\max_{v\ne0}\min\{|f(v)|,\,|f(v)-1/d|\}.
$$
A mutually unbiased Pauli orbit of a unit vector $\psi$ is a partition of the full $d^2$ labeled orbit $D_v\psi$ into $d$ orthonormal bases which are pairwise mutually unbiased. This means that every squared overlap between vectors from distinct bases equals $1/d$. The requirement concerns all the labels of the product orbit. No labeling of the bases is supplied. The result addresses the Pauli construction, and general mutually unbiased bases can exist in these dimensions.

**Theorem 1 (Single-spectrum structure).** For pure $\rho=|\psi\rangle\langle\psi|$, the full orbit is mutually unbiased if and only if $E(\rho)=0$. In that case the zero set of $f$ together with $0$ is a Lagrangian subspace $H\le V$. The bases in any partition are exactly the cosets of $H$. A Clifford change of basis maps $H$ to the standard phase subgroup and makes $\psi$ equimodular. More generally, for $E(\rho)\le\varepsilon$ with $(d^3+d^2)\varepsilon<1$, rounding each $f(v)$ for $v\ne0$ to its nearer level recovers a Lagrangian $H$ from the low level and $0$. This recovery requires neither an assumed partition nor a count of the low-level labels.

**Theorem 2 (Small dimensions).** There is no four-qubit mutually unbiased Pauli orbit for arbitrary input amplitudes and phases. The one- and two-qubit orbits exist. Up to overall phase there are respectively 12 and 480 generating rays, each dimension giving a single Clifford orbit. All odd qubit numbers $n\ge3$ are excluded by earlier work. The proof below adds a direct phase-based derivation within the normalized model.

**Theorem 3 (Robust rounding and gaps).** In even $n\ge2$, if a pure $\rho$ satisfies $E(\rho)\le\varepsilon\le1/(8d^{7/2})$, a unique exact fiducial is selected by its rounded subgroup and its signs on the high layer. Its projector $T$ satisfies
$$
 \|\rho-T\|_1=\sqrt{2b},\qquad b=\|\rho-T\|_2^2\le\varepsilon+d^2\varepsilon^2 ,
$$
where $\|\cdot\|_2$ is the Hilbert–Schmidt norm. In particular every pure four-qubit state has $E(\rho)>1/131072$. In odd $n\ge3$, every pure state has $E(\rho)>1/(1024d^4)$. These two gap statements concern squared overlaps for the distinguished vector versus one Pauli translate at a time.

## 2. Symplectic Fourier reconstruction

Let $\mathcal F$ be the unnormalized symplectic Walsh transform $(\mathcal Fg)(w)=\sum_v(-1)^{[v,w]}g(v)$. Pauli orthogonality gives $\rho=d^{-1}\sum_v r_v D_v$. Conjugation by $D_w$ changes the sign of $D_v$ by $(-1)^{[v,w]}$. Consequently
$$
 (\mathcal F f)(w)=d\,\operatorname{Tr}(\rho D_w\rho D_w)
                 =d f(w)\quad\text{for pure }\rho.
$$
The last identity uses the one-dimensional projector property. It is the standard self-Fourier identity for the characteristic distribution of a pure state.

Because label products differ only by phases, the squared overlap of translates with labels $v,w$ is $f(v+w)$. A full mutually unbiased partition thus implies $f(v)\in\{0,1/d\}$ for each $v\ne0$. Conversely assume the two-level condition and use $H=\{0\}\cup\{v\ne0:f(v)=0\}$. Write $f=\delta_0+(1-\mathbf{1}_H)/d$. The identities $\mathcal F\delta_0=1$, $\mathcal F1=d^2\delta_0$, and $\mathcal Ff=df$ imply $\mathcal F\mathbf{1}_H=d\mathbf{1}_H$. At $0$ this gives $|H|=d$. For $h\in H$, its character sum over $H$ is $d$, so all its characters there equal one. Thus $H$ is pairwise symplectically orthogonal. Its linear span is isotropic and can have dimension at most $n$ by nondegeneracy of the form. Since $H$ has $2^n$ elements, it equals its span and $H=H^\perp$. Within each coset the translates form an orthonormal basis because all nonzero differences lie in $H$. Between cosets all overlaps have the required square modulus. Orthogonality forces the same cosets in every allowable partition.

For the approximate case, put label $0$ into $H$ and add exactly the nonzero labels whose squared response rounds to the low level. The threshold on $\varepsilon$ ensures that the two levels are unambiguous. Write $f=\delta_0+(1-\mathbf{1}_H)/d+e$, $e(0)=0$, $\|e\|_\infty\le\varepsilon$. Then
$$
 \mathcal F\mathbf{1}_H-d\mathbf{1}_H=d\,\mathcal Fe-d^2e .
$$
The right-hand side has absolute value at most $(d^3+d^2)\varepsilon<1$ at every point. The left-hand side is integral, so it vanishes and the exact Lagrangian argument applies. This extraction is a statement about the labels and their values before any choice of basis.

The Clifford action on Pauli labels realizes each binary symplectic change of basis. In particular a symplectic basis adapted to a Lagrangian sends it to $Z=\{(0,b)\}$. If $H$ is the exact low layer, the expectations of $Z^b$ vanish for $b\ne0$, so Walsh inversion of the computational probabilities gives $|\psi_x|^2=1/d$. In the approximate case in those same coordinates, inversion gives the uniform estimate
$$
 \big|d\,|\psi_x|^2-1\big|\le(d-1)\sqrt{\varepsilon}.
$$

For a pure state, suppose the $d^2$ labels are given in $d$ rows of size $d$ and that every same-row off-diagonal squared overlap is strictly smaller than every different-row overlap. Then the row equivalence is translation invariant in $V$. The identity row $H$ is a subgroup and all rows are its cosets, with $|H|=d$. Averaging the pure-state identity on $H$ gives $\sum_{h\in H} f(h)=\sum_{v\in H^\perp}f(v)$. If the two groups differ, their two nonempty set differences have equal cardinality, and every value on $H\setminus H^\perp$ is smaller than every value on $H^\perp\setminus H$, a contradiction. Thus a strictly separated partition must be Lagrangian even when no two-level error bound is specified.

## 3. Fourth-root phases and the four-qubit obstruction

For a fiducial in standard $Z$ coordinates, write $\psi_x=d^{-1/2}\xi_x$ with $|\xi_x|=1$. The Pauli expansion gives for $x\ne y$
$$
 \sqrt d\,\xi_x\overline{\xi_y}\in\mathbb Z[i].
$$
Indeed $d\rho_{xy}$ is the sum of Pauli entries at $(x,y)$ times $r_v=\pm1/\sqrt d$ for the $d$ Pauli matrices with flip $x+y$, and each such matrix entry is in $\{1,-1,i,-i\}$. The Gaussian integer has squared modulus $d$. If $n=2m$, its possible values are $2^m$ times the four units. If $n=2m+1$, they are $2^m(\pm1\pm i)$. To see this, repeatedly divide the real and imaginary parts by two whenever their squared sum is divisible by four, and finish at squared modulus one or two. Thus in even $n$, one overall phase makes $\xi_x=i^{F(x)}$ for a function $F\colon\mathbb F_2^n\to\mathbb Z/4$. In odd $n\ge3$, all relative phases would be odd eighth roots. For any three distinct coordinates two successive relative phases have an even eighth root as product, while the direct relative phase is odd. This recovers the known odd obstruction. The lattice method in even $n$ is the published phase-rigidity result after arranging the basis.

In even $n$, define $q=F\bmod2$ and
$$
 G_b(x)=i^{F(x+b)-F(x)}.
$$
The Pauli spectrum condition for a nonzero flip $b$ is exactly $|\widehat G_b(a)|=\sqrt d$ for every Boolean Walsh frequency $a$, with the unnormalized transform. A unit scalar factor and complex conjugation in the Pauli expectation have no effect on this modulus. Since $G_b(x+b)=\overline{G_b(x)}$, $\operatorname{Re}G_b$ has transform supported on $a\cdot b=0$, and $\operatorname{Im}G_b$ on $a\cdot b=1$. Parseval and the flat modulus give $\sum_x(\operatorname{Re}G_b(x))^2=d/2$. The real part has squared value one exactly when $q(x+b)=q(x)$. Thus every nonzero derivative of $q$ is balanced. By taking the Walsh transform of the autocorrelation of $(-1)^q$, this is equivalent to being Boolean bent, namely $|\widehat{(-1)^q}(a)|=\sqrt d$ at every $a$.

For four qubits, this forces $q$ to be quadratic. For any eight-point affine hyperplane its sum of $(-1)^q$ is half the sum or difference of two Walsh coefficients, hence $0$ or $\pm4$. Its number of ones is even. The whole space also has an even number of ones, since the Walsh coefficient at zero is $\pm4$. The top monomial coefficient of a Boolean function on a coordinate subspace is its truth-table parity. The four coordinate hyperplanes through zero therefore eliminate all cubic coefficients, and the whole-space parity eliminates degree four. The polar alternating form of this quadratic is nondegenerate, since otherwise some nonzero derivative is constant. Choosing a symplectic basis for the polar form and translating to remove the linear term, we can normalize
$$
 q(u,v)=u_1u_2+v_1v_2 \pmod2,\qquad u,v\in\mathbb F_2^2 .
$$
Affine changes of labels and an overall phase preserve the derivative-flatness condition. With the indicated products evaluated as integers write $F(u,v)=u_1u_2+v_1v_2+2h(u,v)\pmod4$ for a Boolean $h$.

Fix a nonzero shift $b$ on the $u$ block. It partitions the four $u$-values into two pairs. The derivative of $u_1u_2$ modulo two is a nonconstant affine function of $u$, constant on each such pair. Thus $i^{Q(u+b)-Q(u)}$, with $Q(u)=u_1u_2$ in the integers, is real on one pair and purely imaginary on the other. The scalars on the two members of a pair are conjugates. Put
$$
 A_u=\sum_{v\in\mathbb F_2^2}(-1)^{h(u,v)+h(u+b,v)}.
$$
A pair has the same $A_u$ on either member. In the Fourier coefficient at frequency $(a,0)$ the pair contributes $(-1)^{a\cdot u}A_u$ times the sum of its two conjugate scalars if $a\cdot b=0$, and times their difference if $a\cdot b=1$. The first frequency selects only the real pair, and the second only the imaginary pair. Flat modulus four forces $|A_u|=2$ on each. On four binary values this says the row difference $h(u,\cdot)+h(u+b,\cdot)$ has odd parity. As $b$ was any nonzero shift, each pair of distinct rows must have different parity. Four rows cannot have pairwise distinct parities in $\mathbb F_2$. This excludes every four-qubit fiducial.

For completeness, in one qubit the Gaussian lattice condition gives exactly four odd eighth-root relative phases for a fixed $H=Z$. They all work because the $X$ and $Y$ expectations have squared modulus $1/2$. For two qubits, normalize $F(0)=0$. The bent low bit is $x_1x_2+\ell(x)$ with $\ell$ any of the four linear forms. The eight Boolean high bits with value zero at the origin are all allowed: for each nonzero flip the two $x,x+b$ pairs consist of one real pair and one imaginary pair, so every Walsh frequency sees exactly one pair with modulus two. Thus there are $4\cdot8=32$ rays for a fixed $H=Z$. Linear low-bit terms come from diagonal $S$ gates and any changes to the upper bit arise from diagonal $Z$ and controlled-$Z$ gates, because every Boolean function on two bits with zero at the origin has degree at most two. The one-qubit relative phases are likewise permuted by $S$. By Clifford transitivity on Lagrangians and uniqueness of the low layer, these give single Clifford orbits and multiply by the Lagrangian count in each dimension. In general there are $\prod_{j=1}^n(2^j+1)$ Lagrangians: count nonzero $h$ in a Lagrangian and reduce those containing $h$ to Lagrangians of $h^\perp/\langle h\rangle$. The numbers are three and fifteen for $n=1,2$, giving 12 and 480.

## 4. Robust rounding for an even number of qubits

The earlier cubic-trace argument also works directly without fixing a partition or choosing Clifford coordinates. If an idempotent complex $d\times d$ matrix $R$ has trace one and squared coefficients $(\operatorname{Tr}(R D_v))^2\in\{0,1/d\}$ for $v\ne0$, then $S=\sqrt d(dR-I)$ has Gaussian-integer entries by the Pauli expansion. Directly expanding with $R^2=R$ gives
$$
\operatorname{Tr}(S^3)=d^2(d-1)(d-2)\sqrt d.
$$
For odd $n\ge3$ this is real and irrational, although the trace of the cube of a Gaussian-integer matrix is a Gaussian integer. This gives the known odd obstruction in its original algebraic form. The later rounding proof uses the same trace for a matrix that need only be close to a projector.


Assume $n$ is even and $\varepsilon\le1/(8d^{7/2})$. Theorem 1 recovers $H$, and all $r_v$ for $v\notin H$ are nonzero. Define
$$
 Q=\sum_{v\notin H}\operatorname{sgn}(r_v)D_v,\qquad
 T=\frac{I+d^{-1/2}Q}{d}.
$$
This Hermitian matrix has $\operatorname{Tr}T=\operatorname{Tr}T^2=1$ by orthogonality and $|V\setminus H|=d^2-d$. Pauli coefficient errors satisfy $|r_v|\le\sqrt\varepsilon$ on $H\setminus\{0\}$ and $|r_v-\operatorname{sgn}(r_v)/\sqrt d|\le\sqrt d\,\varepsilon$ off $H$, by factoring the difference of squares. Thus
$$
 b=\|\rho-T\|_2^2\le(d-1)\varepsilon/d+d(d-1)\varepsilon^2.
$$
The cube trace is
$$
 \operatorname{Tr}T^3=(3d-2)/d^2+L/d^{7/2},\qquad L=d^{-1}\operatorname{Tr}Q^3\in\mathbb Z .
$$
Each Pauli triple has trace zero or $d$ times a Gaussian unit. The sum is real since $Q$ is Hermitian. The terms of degrees zero and two in $Q$ give the displayed constant.

All eigenvalues $\lambda_i$ of $T$ lie in $[-1,1]$ because their squares sum to one. Hence $1-\operatorname{Tr}T^3=\sum_i\lambda_i^2(1-\lambda_i)\ge0$. Since $d^{7/2}$ is integral when $n$ is even, a strictly positive gap is at least $d^{-7/2}$. On the other hand, $\operatorname{Tr}(\rho T)=1-b/2$, so the largest eigenvalue is at least $1-b/2$. The remaining eigenvalues have squares summing to at most $b$. It follows that
$$
 1-\operatorname{Tr}T^3\le \tfrac32 b+b^{3/2}<d^{-7/2},
$$
where $b\le2\varepsilon\le1/4$ gives the estimate $\tfrac32 b+b^{3/2}\le4\varepsilon\le1/(2d^{7/2})$. Therefore the gap is zero. Its nonnegative summands imply that every eigenvalue is 0 or 1, and the trace is one, so $T$ is a pure state. The prescribed Pauli coefficients now give the exact two-level spectrum and hence the actual partition from Theorem 1. Pauli orthogonality makes the state uniquely determined by these rounded signs and subgroup. The difference of two rank-one projectors is traceless of rank at most two, so its trace norm is $\sqrt{2b}$. For $n=4$, the rounded pure state cannot exist. Substitution of $d=16$ gives the stated gap.

This also gives a finite exact certificate for any proposed signs at even $n$. Form $T$ from a proposed Lagrangian and signs, and test the integer equality $L=(d-1)(d-2)d^{3/2}$. It is equivalent to purity and hence to a physical fiducial. No eigenvalue computation is needed for this test.

## 5. The gap for odd qubit numbers and an extension to mixed states

For odd $n\ge3$, suppose that $\varepsilon\le1/(1024d^4)$. Recover $H$ and normalize it to $Z$ as above. For distinct coordinates let $\alpha_{xy}=d\psi_x\overline{\psi_y}$. As in the exact argument, each off-diagonal has $d$ contributing Pauli labels outside $H$. Replace each coefficient by its signed value $\pm1/\sqrt d$. This gives $g_{xy}\in\mathbb Z[i]/\sqrt d$ and
$$
 |\alpha_{xy}-g_{xy}|\le\eta=d^{3/2}\varepsilon,\qquad
 \big||\alpha_{xy}|-1\big|\le d\sqrt\varepsilon.
$$
The second bound uses the interval for $d|\psi_x|^2$ and $d|\psi_y|^2$ in §2. Since $d\sqrt\varepsilon+\eta<1/(3d)$, every $g_{xy}$ has modulus exactly one. All possible squared radii have the form $k/d$, $k\in\mathbb Z_{\ge0}$, and the nearest nonunit radius is at distance at least $1/(3d)$ by factoring $\sqrt{1\pm 1/d}-1$. By the odd Gaussian lattice calculation in §3, the $g_{xy}$ are odd eighth roots. The normalized relative phase $\alpha_{xy}/|\alpha_{xy}|$ is within $2\eta$ of $g_{xy}$. On three distinct coordinates these true phases multiply exactly. Their three approximations would put an even eighth root and an odd eighth root within $6\eta$, strictly less than the minimum distance $2\sin(\pi/8)$. This contradiction gives the stated odd gap.

One can allow a small impurity for the label reconstruction. For any density matrix $\rho$ let $s=1-\operatorname{Tr}\rho^2$. With the swap operator $\mathsf S$ on two copies and a Pauli $A$,
$$
 \left|(\operatorname{Tr}\rho A)^2-\operatorname{Tr}(\rho A\rho A)\right|
 =\left|\operatorname{Tr}[(\rho\otimes\rho)(A\otimes A)(I-\mathsf S)]\right|
 \le s .
$$
Indeed $A\otimes A$ commutes with $\mathsf S$ and is a Hermitian contraction, while $\rho\otimes\rho$ is positive and commutes with $\mathsf S$. Thus the approximate Fourier equation has an additional pointwise error of size at most $ds$. The same integer argument still recovers $H$ if $(d^3+d^2)\varepsilon+d^2s<1$. If the observed low layer has size $d-1$ excluding zero, Pauli Parseval already gives $s\le d\varepsilon$. In fact its rounded squared spectrum has sum $d$, which differs from $\sum_v f(v)=d\operatorname{Tr}\rho^2$ by at most $(d^2-1)\varepsilon$. A projector $P$ onto a largest eigenvector has $\|\rho-P\|_1=2(1-\lambda_{\max}(\rho))\le2s$. The squared Pauli responses of $P$ differ by at most $4s$ from those of $\rho$, so the pure results apply with effective error $\varepsilon+4s$ when it lies within the stated thresholds.

## 6. Relation to previous work

The earlier public three-qubit paper excludes arbitrary amplitudes and phases at $n=3$. The subsequent public parity paper proves the remaining odd exclusions by a cubic-trace obstruction in §3 and four-phase rigidity for equimodular even-qubit candidates in §4. Its §2 already derives the necessary two-level spectrum by comparing with the identity translate. The new structure theorem establishes the converse, identifies the unique labeling of the bases, and makes the even phase reduction apply to every possible fiducial after a Clifford change of coordinates. The four-qubit obstruction resolves the first open even case identified in §§4 and 6 of that paper. The robustness result turns a pointwise discrepancy into an exact label subgroup and an exact projector or a quantitative obstruction. [Three-qubit paper (Chinese)](../three-qubit-pauli-mub-obstruction/paper.zh.md) · [Parity and phase-rigidity paper](../pauli-mub-phase-rigidity/paper.en.md).

Khatirinejad Fard's 2008 dissertation §2.3.3 gives two prior versions of the orbit problem. The cyclic formulation, including Theorem 2.54, uses a shift and clock on $\mathbb Z_d$. More directly, Definitions 2.55–2.56 and Theorem 2.57 index the phase and shift operators by a finite field and use the absolute trace pairing. At characteristic two, dual bases for the trace pairing turn these operators into the same tensor-Pauli rays studied here. That definition prescribes the $Z$-coset rows and adds the computational basis. The theorem supplies an equivalent vanishing-autocorrelation test in those coordinates. Section 2.3.4 classifies the cyclic examples for $d\le5$, including the four fixed-$Z$ rays at $d=2$ in Theorem 2.58. The cyclic nonexistence theorem for $d=4$ (Theorem 2.60) concerns a projective label group of exponent four. The binary tensor labels have exponent two. The arbitrary-partition-to-$Z$ implication here makes the prescribed finite-field formulation exhaustive up to Clifford equivalence. [M. Khatirinejad Fard, *Regular Structures of Lines in Complex Spaces*, Simon Fraser University, 2008, §§2.3.3–2.3.4](https://central.bac-lac.gc.ca/.item?app=Library&id=NR58726&oclc_number=755208585&op=pdf).

Damski, Bistroń, Ponterio, Czartowski and Życzkowski study the same product group. Their §III.B takes equimodular candidates and prescribed phase-subgroup cosets, with Lemma 5 proving the row orthogonality and Lemma 6 connecting unbiasedness to product magic. Lemma 7 already obtains Clifford equivalence to an equimodular state when all responses vanish on one of its prescribed commuting classes. Theorem 1 here identifies the vanishing class from the spectrum itself. Section IV.C (HTML §IV.3), Eq. (25), gives the one- and two-qubit examples. Conjecture 1 and the accompanying stronger question identify the binary obstruction. The displayed Eq. (26) retains the three-qubit normalization in variable dimension. The four-qubit theorem addresses the normalized formulation and the stronger arbitrary-amplitude question at $d=16$. The higher even cases are open in this treatment. The SIC obstruction of Godsil and Roy concerns equiangularity with one nonzero level $1/(d+1)$ for all distinct pairs, a different spectrum condition. [Damski et al., *Product Weyl–Heisenberg covariant mutually unbiased bases and extremal non-stabilizerness*, arXiv:2603.15550v2](https://arxiv.org/html/2603.15550v2) · [Godsil and Roy, *Equiangular lines, mutually unbiased bases, and spin models*, Lemma 3.1](https://arxiv.org/abs/quant-ph/0511004).

For comparison, Abdukhalikov uses pseudo-planar functions over fields of characteristic two and Galois-ring phases to construct complete sets of MUBs with separate basis parameters. The single-orbit requirement studied here imposes a common fiducial whose phase differences must all have flat Walsh spectra. [Abdukhalikov, *Symplectic spreads, planar functions and mutually unbiased bases*, Theorem 5.1](https://arxiv.org/pdf/1306.3478).

The mathematical ingredients have independent precedents. Equation (3.5) of Gross, Nezami and Walter is the pure-state symplectic Fourier identity in normalized variables. The Clifford implementation used here is in Dehaene and De Moor §IV. The even-variable bent-function criterion and the four-variable degree restriction are classical. The argument here uses bentness for the low bit of the fourth-root phase, followed by the row-parity condition on its high bit. The robust result uses the cubic trace from the earlier parity paper in a different way, quantizing the deficit of a signed approximation whose trace and squared trace are fixed. [Gross, Nezami and Walter, *Schur–Weyl Duality for the Clifford Group with Applications*, Eq. (3.5)](https://doi.org/10.1007/s00220-021-04118-7) · [Dehaene and De Moor, *Clifford group, stabilizer states, and linear and quadratic operations over GF(2)*, §IV](https://arxiv.org/abs/quant-ph/0304125) · [Rothaus, *On “bent” functions*](https://doi.org/10.1016/0097-3165(76)90024-8).

## 7. Exact verification

The standard-library replay has two independent two-qubit routes. It enumerates the 64 normalized fourth-root phases at fixed $H=Z$, and separately tests all 4,096 sign assignments by the Pauli cube trace. Both give precisely the same 32 states. It also counts the one- and two-qubit Lagrangians, enumerates the 448 normalized four-variable Boolean bent functions, and verifies that no one of the 32,768 possible high bits of the canonical quadratic passes the three shifts used in the proof. Sections 2–5 give the analytic proofs. The computation programs and raw outputs are not included in this version; no end-to-end formal verification is asserted.
