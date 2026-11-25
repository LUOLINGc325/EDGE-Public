# A parity obstruction and phase rigidity for product-Pauli MUB fiducials

*An arbitrary-amplitude exclusion in odd qubit number and a fourth-root reduction in even qubit number*

24 November 2026

## Abstract

Let $d=2^n$ and let the $d^2$ tensor products of the Hermitian one-qubit Pauli matrices act on a unit vector in $\mathbb C^d$. We consider the requirement that the full labeled orbit can be partitioned into $d$ pairwise mutually unbiased orthonormal bases. A cubic-trace argument excludes this requirement for every odd $n\geq5$, without assumptions on coordinate magnitudes, coordinate phases, or the partition. The underlying algebraic lemma also applies to three qubits, whose primary result is treated separately in [6]. For even $n=2m$, we prove that every equimodular fiducial satisfying the orbit requirement has, after one global change of phase, only fourth-root phases. This reduces the remaining equimodular existence question for even $n\geq4$ to a finite phase alphabet, but does not settle its existence. Both results follow from Gaussian integrality of $\sqrt d(d\rho-I)$, where $\rho$ is the pure-state projector. The formal development uses the actual tensor Pauli matrices and an explicit basis-partition predicate; it also includes the two-qubit example as a nonvacuity check.

## 1. Problem and scope

Two orthonormal bases $\{u_j\}_{j=1}^d$ and $\{w_k\}_{k=1}^d$ of $\mathbb C^d$ are mutually unbiased when
$$|\langle u_j,w_k\rangle|^2=1/d\quad\text{for all }j,k.$$
Here the inner product is conjugate-linear in its first argument. We study a particular orbit construction, rather than the existence of unrestricted mutually unbiased bases (MUBs).

Write
$$
I=\begin{pmatrix}1&0\\0&1\end{pmatrix},\quad
X=\begin{pmatrix}0&1\\1&0\end{pmatrix},\quad
Y=\begin{pmatrix}0&-i\\i&0\end{pmatrix},\quad
Z=\begin{pmatrix}1&0\\0&-1\end{pmatrix},
$$
and let $\mathcal P_n=\{I,X,Y,Z\}^{\otimes n}$. Labels are strings in $\{0,1,2,3\}^n$; computational-basis indices are strings in $\{0,1\}^n$. Thus the matrices have dimension $d=2^n$ and there are $d^2$ labels. A **Pauli MUB fiducial** is a vector $\psi$ together with a bijective assignment of the labels to $d$ rows of $d$ columns, such that the vectors $P\psi$ in each row are normalized and mutually orthogonal and vectors in different rows have squared overlap $1/d$. This is a condition on the full orbit. It does not select a subset of an orbit with repetitions.

The definition allows every partition with these properties. It is unchanged by independently multiplying orbit representatives by complex numbers of modulus one. Thus it is also the usual statement that the $d^2$ orbit rays form $d$ MUBs. We use Hermitian representatives so that Pauli expectations are real; replacing $Y$ by the corresponding phase multiple of $XZ$ does not change the ray condition.

Damski et al. [1, PDF §IV.C; HTML §IV.3] discuss product-Weyl–Heisenberg MUB fiducials, give a numerical exclusion under an eighth-root phase ansatz for three qubits, state Conjecture 1, and suggest the stronger arbitrary-phase nonexistence for more than two qubits. Their displayed conjecture keeps the three-qubit normalization $1/(2\sqrt2)$ while allowing general $n$. We address the intended normalized problem with coordinate magnitude $1/\sqrt{2^n}$, rather than using that normalization slip as an obstruction.

**Theorem A (higher odd qubit number).** If $n\geq5$ is odd, there is no Pauli MUB fiducial in $\mathbb C^{2^n}$. Coordinate magnitudes and phases are arbitrary.

**Theorem B (even qubit number).** Let $n=2m$, $d=4^m$, and suppose that $\psi$ is a Pauli MUB fiducial with $|\psi_x|^2=1/d$ for every computational-basis index $x$. There exists $\eta\in\mathbb C$, $|\eta|=1$, such that
$$\bigl(2^m\eta\psi_x\bigr)^4=1\qquad\text{for every }x.$$
Equivalently, all the scaled coordinates are in $\{1,-1,i,-i\}$. The primary unresolved range to which this restriction applies is $m\geq2$.

The algebraic argument underlying Theorem A also applies to $n=3$, which is treated in [6]. The present manuscript concerns the odd $n\geq5$ extension and Theorem B; it makes no independent priority claim for the same three-qubit result.

## 2. Tensor reconstruction and integral coefficients

We first give the concrete operator calculation used by both theorems. If $\sigma_a\in\{I,X,Y,Z\}$, direct calculation in dimension two gives
$$
\sum_{a=0}^3(\sigma_a)_{ij}(\sigma_a)_{uv}
=2\,\delta_{iv}\delta_{ju}.
\tag{1}
$$
Taking products of (1) over the qubits and distributing finite sums gives the tensor kernel identity
$$
\sum_{P\in\mathcal P_n}P_{xy}P_{uv}
=d\,\delta_{xv}\delta_{yu}.
\tag{2}
$$
This calculation does not assume an abstract operator-basis axiom. In particular, for every complex $d\times d$ matrix $A$,
$$
\sum_{P\in\mathcal P_n}\operatorname{Tr}(AP)P=dA.
\tag{3}
$$
Indeed, its $(i,j)$ entry is
$$
\sum_{x,y}A_{xy}\sum_{P\in\mathcal P_n}P_{yx}P_{ij}=dA_{ij}.
$$
The individual matrices are Hermitian, square to the identity, and have entries in the Gaussian integers $\mathbb Z[i]$. These properties follow from the four explicit one-qubit matrices and finite products.

For a normalized vector $\psi$, put $\rho=|\psi\rangle\langle\psi|$. Direct summation proves
$$
\rho^2=\rho,\qquad \operatorname{Tr}\rho=1,\qquad
\operatorname{Tr}(\rho P)=\langle\psi,P\psi\rangle.
\tag{4}
$$
Since $P$ is Hermitian, the last quantity is real. Suppose now that $\psi$ is a Pauli MUB fiducial. Compare the identity-labeled vector $\psi$ with $P\psi$ for a nonidentity label $P$. If their labels occupy the same row, they occupy different columns and have overlap zero. If they occupy different rows, their squared overlap modulus is $1/d$. Consequently
$$
r_P^2\in\{0,1/d\},\qquad
r_P:=\operatorname{Tr}(\rho P),\quad P\ne I.
\tag{5}
$$
No choice of a particular basis partition entered this argument.

**Lemma 1 (Gaussian integrality).** Suppose that $\operatorname{Tr}\rho=1$ and (5) holds. If $t^2=d$ and $t\ne0$, then
$$S=t(d\rho-I)\quad\text{has entries in }\mathbb Z[i].\tag{6}$$

**Proof.** Remove the identity term from (3):
$$
t(d\rho-I)=\sum_{P\ne I}(t r_P)P.
\tag{7}
$$
Equation (5) gives $(t r_P)^2\in\{0,1\}$. In $\mathbb C$, this implies $t r_P\in\{0,1,-1\}$ by factoring the two polynomials. Each matrix on the right of (7) therefore has Gaussian-integer entries, as does their finite sum. $\square$

The lemma is algebraic: given the square condition (5), it does not require positivity or Hermiticity of $\rho$. In the fiducial application, (4) supplies the required conditions from the actual vector and matrices.

## 3. The cubic-trace obstruction

**Lemma 2.** Let $\rho$ be a $d\times d$ complex matrix with $\rho^2=\rho$ and $\operatorname{Tr}\rho=1$. Suppose $d>2$ and $t$ is a real irrational number with $t^2=d$. Then $t(d\rho-I)$ cannot have Gaussian-integer entries.

**Proof.** Idempotence gives $\rho^3=\rho$. Expanding a polynomial in the single matrix $\rho$ gives
$$
(d\rho-I)^3=(d^3-3d^2+3d)\rho-I.
$$
Taking the trace yields
$$
\operatorname{Tr}((d\rho-I)^3)
=d^3-3d^2+2d=d(d-1)(d-2).
\tag{8}
$$
Hence, for $S=t(d\rho-I)$,
$$
\operatorname{Tr}(S^3)=d^2(d-1)(d-2)t.
\tag{9}
$$
If $S$ had Gaussian-integer entries, finite sums and products would put $\operatorname{Tr}(S^3)$ in $\mathbb Z[i]$. The right side of (9) is real, so this trace would be an ordinary integer. But its coefficient of $t$ is a nonzero integer because $d>2$. An integer equality would express $t$ as a rational number, contradicting irrationality. $\square$

**Proof of Theorem A.** Write $n=2k+1$. Then $d=2^n$ and $t=\sqrt d=2^k\sqrt2$ is irrational. For $n\geq3$, $d>2$. Equations (4)–(5) and Lemma 1 make $t(d\rho-I)$ Gaussian integral, contradicting Lemma 2. $\square$

The algebraic formulation proves that no idempotent trace-one matrix in these dimensions can have the Pauli square spectrum (5), without a separate Hermiticity assumption. The formal algebraic theorem applies to odd $n\geq3$ and precedes the actual-fiducial corollary. The square-spectrum condition and Pauli reconstruction themselves force Hermiticity, so omitting that assumption is not a claim of a strict extension to non-Hermitian states.

## 4. Fourth-root phase rigidity

The odd-qubit proof fails for even $n$ because $\sqrt{2^n}$ is then an integer. Gaussian integrality nevertheless has a strong consequence when the coordinates are equimodular.

**Lemma 3.** If $a,b\in\mathbb Z$ and $a^2+b^2=4^m$ for an integer $m\geq0$, then
$$
(a,b)\in\{(2^m,0),(-2^m,0),(0,2^m),(0,-2^m)\}.
\tag{10}
$$

**Proof.** For $m=0$, the two integer squares sum to one, yielding the four listed pairs. For $m>0$, squares modulo four are zero or one. Since their sum is divisible by four, both $a$ and $b$ are even. Divide the equation by four and apply induction to $(a/2,b/2)$. $\square$

**Proof of Theorem B.** Put $t=2^m$ and $d=t^2=4^m$. By Lemma 1, $S=t(d\rho-I)$ has Gaussian-integer entries. For $x\ne y$, its entry is
$$S_{xy}=t d\psi_x\overline{\psi_y}.$$
Equimodularity gives
$$|S_{xy}|^2=t^2d^2|\psi_x|^2|\psi_y|^2=t^2=4^m.$$
Lemma 3 applied to the real and imaginary integer parts of $S_{xy}$ shows
$$d\psi_x\overline{\psi_y}\in\{1,-1,i,-i\}.$$
For $x=y$, this expression equals one, so the same conclusion holds for all pairs. Choose an index $y_0$ and set $\eta=t\overline{\psi_{y_0}}$. Then $|\eta|=1$ and
$$t\eta\psi_x=d\psi_x\overline{\psi_{y_0}}\in\{1,-1,i,-i\}$$
for every $x$, proving the theorem. $\square$

Only one global phase is removed. The result does not allow separate changes of computational-basis phases, which would alter the fiducial problem. It is a necessary condition, not a construction and not a nonexistence proof in even qubit number.

## 5. A nonvacuous two-qubit boundary

The four-dimensional vector
$$\psi=\tfrac12(1,i,i,i)^{\mathsf T}\tag{11}$$
is equimodular and its full tensor-Pauli orbit does form four MUBs, consistent with Theorem B. This familiar boundary example is not claimed as new; see also [1]. Here is the explicit partition used in the formal verification. Encode each local label by its flip bit and phase bit:
$$I\mapsto(0,0),\quad X\mapsto(1,0),\quad
Y\mapsto(1,1),\quad Z\mapsto(0,1).$$
Group the 16 labels by their two-bit flip string. Each of the four groups contains all four phase strings. Substituting (11) into the explicit matrices gives normalized vectors, within-group overlaps zero for distinct labels, and squared overlaps $1/4$ between groups. These are finite exact calculations in $\mathbb Q(i)$; the Lean proof checks them with kernel-checked arithmetic, without floating point or an untrusted native decision procedure.

At $d=2$ the coefficient in (9) vanishes. At square dimensions the irrationality step is unavailable. Thus the obstruction itself explains why it does not exclude these boundary regimes. The example (11) also checks that the orbit predicate is satisfiable and is not accidentally stronger than the intended MUB condition.

## 6. Relation to earlier results and remaining question

Godsil and Roy [2, Lemma 3.1] give an arithmetic restriction on product-Pauli covariant equiangular lines, the SIC setting. Their nonidentity squared overlap is $1/(d+1)$, whereas (5) allows zero and $1/d$. Their work is a methodological precedent and must not be confused with a proof of the present orbit statement. In particular, the three-qubit Hoggar SIC is compatible with our theorem.

Related Gaussian-integer methods also occur in the fourth-root Hadamard setting of Best and Kharaghani [4], whose order-$2k$ bound for odd $k$ does not directly apply here. The arithmetic tools are established; the contribution is their complete application to the present spectral and phase conditions.

Zhu [3] treats sharp covariance of complete stabilizer MUB sets under groups of size $d(d+1)$. The present group has $d^2$ projective elements and generates $d$ bases, with no stabilizer assumption. Those quantifiers differ. The relevant open source is [1], rather than an inference from a theorem about a different covariance group.

The remaining question is whether a fourth-root equimodular fiducial can satisfy the orbit condition for even $n\geq4$. Theorem B makes the coordinate phase alphabet finite after fixing a global phase. The finite set is still exponentially large in the Hilbert-space dimension; no efficient exhaustive algorithm, complexity bound, or successful search is claimed here. Neither theorem determines the maximum of a magic measure or imposes an obstruction on unrestricted complete MUB sets.

The MUB-fiducial idea predates [1]; Khatirinejad Fard’s 2008 thesis [5, §2.3.3] is an earlier historical source. In this audit its complete text could not be retrieved from the university or national-library endpoints. Only indexed primary-text excerpts on the cyclic Weyl–Heisenberg construction and related characterization were available. We therefore do not claim a full-text exclusion of overlap with every result in that thesis.

The literature comparison includes the cited primary papers and recent sparse-Pauli and magic literature. No matching higher-dimensional parity-plus-rigidity result was found in that bounded search. This is a report of the search performed, not a certificate of absolute priority. The separately published three-qubit result in [6], disclosed above, and the present higher-dimensional extension and phase-rigidity result belong to one research family.

## 7. Formal verification and reproducibility

The formal source is organized by mathematical dependency: Gaussian-integer and trace algebra; actual tensor Pauli matrices and their kernel reconstruction; normalized-vector projectors and the MUB partition; spectral integrality; the irrational obstruction; the sum-of-two-squares phase argument; the final theorems; and the explicit two-qubit instance. The formal source is not included in this version.

The intended trusted mathematical boundary is the Lean kernel with Mathlib at the pinned revision. The formal source and compilation evidence are not included in this version; no new compilation is claimed. Computational checks do not establish novelty or replace external peer review.

## References

1. B. S. Damski, R. Bistroń, D. Ponterio, J. Czartowski and K. Życzkowski, *Product Weyl–Heisenberg covariant mutually unbiased bases and extremal non-stabilizerness*, arXiv:2603.15550v2, 7 October 2026. [Primary text](https://arxiv.org/html/2603.15550v2), especially §IV.3.
2. C. Godsil and A. Roy, *Equiangular lines, mutually unbiased bases, and spin models*, arXiv:quant-ph/0511004, Lemma 3.1. [Primary text](https://arxiv.org/pdf/quant-ph/0511004).
3. H. Zhu, *Sharply covariant mutually unbiased bases*, arXiv:1503.00003, 2015. [Primary text](https://arxiv.org/abs/1503.00003).

4. D. Best and H. Kharaghani, *Unbiased complex Hadamard matrices and bases*, Cryptography and Communications **2**, 199–209 (2010); arXiv:1209.4315. [Primary text](https://arxiv.org/abs/1209.4315).

5. M. Khatirinejad Fard, *Regular structures of lines in complex spaces*, PhD thesis, Simon Fraser University, 2008, §2.3.3. [University record](https://summit.sfu.ca/item/9188). Full-text access was unavailable in this audit; the comparison is limited to the indexed excerpts.

6. *Nonexistence of three-qubit tensor-Pauli single-orbit mutually unbiased bases*, research draft, 24 November 2026. [Companion manuscript (Chinese)](../three-qubit-pauli-mub-obstruction/paper.zh.md).
