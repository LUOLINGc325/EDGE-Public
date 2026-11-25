# A strict half-order counterexample to sorted Schmidt-reference optimality

*An exact eight-qubit witness with a nondegenerate Schmidt spectrum*

AI-assisted research draft

24 November 2026

## Abstract

We give an exact counterexample to the all-order claim that the computational-basis representative obtained by sorting a bipartite pure state's Schmidt coefficients minimizes its stabilizer Rényi entropy over local unitaries. The counterexample occurs at order $\alpha=1/2$, on four qubits per subsystem, and has sixteen strictly positive, pairwise distinct Schmidt coefficients. Simultaneously exchanging computational-basis labels 11 and 12 on the two subsystems lowers the entropy by exactly $2\log_2(13980/13979)>0$. The calculation reduces to integer Walsh correlations and is also checked by an independent enumeration of all 65,536 Pauli strings. A continuity argument shows that the failure persists on an open set of strictly positive, strictly ordered amplitude vectors. The result refutes the all-order prescription; it does not settle computational-basis optimality at order two or in the magic-monotone range $\alpha\geq2$.

## 1. The question and its precise scope

For a normalized $n$-qubit pure state $|\psi\rangle$, write $D=2^n$ and let $\mathcal P_n$ contain the $4^n$ tensor products of $I,X,Y,Z$. The stabilizer Rényi entropy is

$$
M_\alpha(\psi)=\frac{1}{1-\alpha}\log_2\left(\frac1D
\sum_{P\in\mathcal P_n}|\langle\psi|P|\psi\rangle|^{2\alpha}\right),
\qquad \alpha>0,\quad \alpha\ne1.
\tag{1}
$$

At half order this becomes

$$
M_{1/2}(\psi)=2\log_2 Z(\psi),\qquad
Z(\psi)=\frac1D\sum_{P\in\mathcal P_n}|\langle\psi|P|\psi\rangle|.
\tag{2}
$$

The nonlocal optimization minimizes (1) over local unitaries $U_A\otimes U_B$; write this minimum as $M_\alpha^{\mathrm{NL}}$. A proposed shortcut places the square roots of the Schmidt probabilities in decreasing order on matching computational-basis labels. Here the Schmidt probabilities are the squared Schmidt coefficients. Liu and Cui [1, Eq. (6)] conjecture that this representative attains the minimum. Their later paper explicitly states the all-order version in Appendix A [2, Eqs. (A3)-(A4)] and explicitly retains absolute values for half-integer orders [2, Eq. (A10)]. We test that all-order statement at $\alpha=1/2$.

This distinction is substantive. The nearby results of Sierant [3] and Franchini and Giampaolo [4] concern order two. The local minimality statement in [2] concerns integer orders at least two. The closed-form result of Viscardi, Leone and Hamma [5] concerns log-stabilizer fidelity. Moreover, the pure-state resource monotonicity established in [6] applies to $\alpha\geq2$. Our half-order result makes no assertion about those statements and no claim of resource monotonicity at half order.

## 2. Exact counterexample

Set $d=16$, so that the local Hilbert spaces are $\mathbb C^{16}$ and the total dimension is $D=d^2=256$. Computational labels $0,\ldots,15$ are identified with four-bit strings. Define

$$
a=(18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,1),
\qquad Q=\sum_{x=0}^{15}a_x^2=2096,
\tag{3}
$$

$$
|\psi_a\rangle=\frac1{\sqrt Q}\sum_{x=0}^{15}a_x|x\rangle_A|x\rangle_B.
\tag{4}
$$

Let $\pi$ exchange 11 and 12 and fix every other label. Put $U_\pi|x\rangle=|\pi(x)\rangle$ and $b_x=a_{\pi(x)}$. Since $\pi$ is an involution,

$$
(U_\pi\otimes U_\pi)|\psi_a\rangle=|\psi_b\rangle.
\tag{5}
$$

**Theorem 1 (strict half-order failure).** The state (4) is normalized and is the sorted Schmidt representative with strictly positive, strictly decreasing Schmidt probabilities $\lambda_x=a_x^2/2096$. The unitary operation (5) preserves that spectrum, and

$$
Z(\psi_a)=\frac{13980}{8384},\qquad
Z(\psi_b)=\frac{13979}{8384}.
\tag{6}
$$

Consequently,

$$
M_{1/2}(\psi_a)-M_{1/2}(\psi_b)
=2\log_2\frac{13980}{13979}>0.
\tag{7}
$$

Thus the sorted Schmidt representative fails to attain the local-unitary minimum. In particular, $M_{1/2}^{\mathrm{NL}}(\psi_a)\leq M_{1/2}(\psi_b)<M_{1/2}(\psi_a)$. No exact value of the global minimum is asserted.

## 3. Proof from actual Pauli expectations

We give the reduction explicitly to fix the normalization and the absolute values. The Pauli-Walsh representation appears in [2, Appendix A; 4]. The contribution here is the strict witness, not the transform itself.

For a real vector $c\in\mathbb R^{16}$ with $Q(c)=\sum_x c_x^2>0$, let $|\psi_c\rangle$ be (4) with $a,Q$ replaced by $c,Q(c)$. Define

$$
H_c(s,k)=\sum_{x=0}^{15}c_xc_{x\oplus s}(-1)^{k\cdot x},
\qquad F(c)=\sum_{s,k=0}^{15}|H_c(s,k)|,
\tag{8}
$$

where the dot product in the sign is over $\mathbb F_2$.

**Lemma 2 (Pauli-Walsh reduction).** For every such $c$,

$$
\sum_{P\in\mathcal P_8}|\langle\psi_c|P|\psi_c\rangle|
=\frac{16}{Q(c)}F(c),\qquad
Z(\psi_c)=\frac{F(c)}{16Q(c)}.
\tag{9}
$$

*Proof.* A local Hermitian Pauli can be written
$P_{s,t}=i^{\nu(s,t)}X^sZ^t$, where $\nu(s,t)$ counts positions in which both bits equal one. Its phase has modulus one. In the expectation of $P_{s,t}\otimes P_{r,u}$, the support of the state requires the two shifted labels to agree. Hence the expectation vanishes unless $s=r$. When $s=r$, its modulus is

$$
\frac1{Q(c)}\left|\sum_x c_xc_{x\oplus s}
(-1)^{(t\oplus u)\cdot x}\right|
=\frac{|H_c(s,t\oplus u)|}{Q(c)}.
\tag{10}
$$

For each fixed $s,k$, there are exactly sixteen pairs $(t,u)$ with $t\oplus u=k$. Summing gives the first equality in (9). Division by the total dimension $256$ gives the second. In particular, the denominator is $16Q(c)$, not $256Q(c)$, after the multiplicity has been counted. The calculation applies to the usual Hermitian strings; dropping the unit-modulus phases is legitimate only because moduli are retained. $\square$

**Lemma 3 (exact integer certificate).** For the vectors $a,b$ of Theorem 1,

$$
Q(a)=Q(b)=2096,\qquad F(a)=55920,\qquad F(b)=55916.
\tag{11}
$$

*Proof.* Formula (3) gives the norm; $b$ is a permutation of $a$. Every term of (8) is an integer. The following per-shift sums give a compact checksum of all 256 entries for each vector. The complete tables and a program recomputing every entry directly from (8) accompany the paper.

| $s$ | $\sum_k\lvert H_a(s,k)\rvert$ | $\sum_k\lvert H_b(s,k)\rvert$ |
|---:|---:|---:|
| 0 | 5200 | 5220 |
| 1 | 4896 | 4896 |
| 2 | 4608 | 4608 |
| 3 | 4448 | 4440 |
| 4 | 4056 | 4032 |
| 5 | 3936 | 3904 |
| 6 | 3728 | 3688 |
| 7 | 3632 | 3632 |
| 8 | 2960 | 2988 |
| 9 | 2912 | 2932 |
| 10 | 2808 | 2800 |
| 11 | 2768 | 2744 |
| 12 | 2568 | 2596 |
| 13 | 2528 | 2548 |
| 14 | 2456 | 2468 |
| 15 | 2416 | 2420 |
| **Total** | **55920** | **55916** |

The finite identities in (11) can also be checked directly by the Lean kernel using integer arithmetic. Their verification does not rely on a floating-point tolerance. $\square$

*Completion of Theorem 1.* The computational basis is orthonormal, so (3) normalizes (4). Its reduced density operator is diagonal with entries $a_x^2/Q$. These entries are strictly positive and strictly decreasing. The permutation matrix $U_\pi$ is unitary; its simultaneous action gives (5), preserving the Schmidt probabilities as a multiset. Substituting (11) into (9) yields

$$
\frac{55920}{16\cdot2096}=\frac{13980}{8384},\qquad
\frac{55916}{16\cdot2096}=\frac{13979}{8384}.
$$

Both numbers are positive. The logarithm-of-a-quotient identity and strict monotonicity give (7). Since (5) is an allowed point of the local-unitary orbit, a smaller value at that point excludes global minimality of (4). $\square$

## 4. Failure on an open set

The original conjecture refers to generic states. An isolated degenerate example could leave that qualification ambiguous. Our witness has a nondegenerate spectrum, and its strict inequality persists in a neighborhood.

**Theorem 4 (open family of failures).** There is an open neighborhood $\mathcal U\subset\mathbb R^{16}$ of $a$ such that every $c\in\mathcal U$ is strictly positive and strictly decreasing and satisfies

$$
M_{1/2}\bigl((U_\pi\otimes U_\pi)\psi_c\bigr)
<M_{1/2}(\psi_c).
\tag{12}
$$

*Proof.* Each $H_c(s,k)$ is a quadratic polynomial in $c$, so $F$ is continuous. Composition with the fixed permutation is continuous. Therefore the set

$$
\mathcal U=\{c:\ c_0>c_1>\cdots>c_{15}>0,\quad
F(c\circ\pi)<F(c)\}
\tag{13}
$$

is open, being a finite intersection of strict continuous inequalities. It contains $a$ by (3) and (11). Positivity gives $Q(c)>0$, and a permutation preserves $Q(c)$. Equation (9) and strict monotonicity of the logarithm now give (12). $\square$

This is a neighborhood statement in amplitude coordinates, with each vector normalized by its own norm. It does not assert a measure-one prevalence of failure.

## 5. Verification, significance and limits

The reproducibility package has two separate exact computations. `code/exact_certificate.py` reconstructs the Walsh tables using arbitrary-precision integers. `code/verify_full_pauli.py` starts from the literal actions of $I,X,Y,Z$, enumerates all 65,536 strings, and uses integer exponents of $i$ to avoid floating point. The latter produces absolute numerator totals 894720 and 894656, which agree with sixteen times the two totals in (11). Numerical entropy values are not needed anywhere in the proof.

The original manuscript describes a Lean development for the finite certificate and mathematical bridges: complex states, normalization, local permutation, the Pauli sum, strict entropy comparison, and an open-neighborhood argument. Its source and build evidence are not included in this release; no new formal verification is asserted.

The result identifies a failure of an exact spectral shortcut. Sorting the spectrum remains an admissible representative and therefore an upper bound on the nonlocal minimum, but it cannot be identified with that minimum uniformly over Rényi orders. The positive gap, however small, disproves exact equality. We do not establish an optimal gap, a smallest counterexample dimension, an interval of Rényi orders with failure, or the exact global minimum. In particular, the central order-two conjecture remains outside the present result.

This is an AI-assisted research draft, not an externally peer-reviewed publication. The literature comparison is limited to the sources examined; global priority is not asserted. Source [6] was consulted at the publisher-abstract level for scope context; it is not used in the proof.

## References

1. L.-Y.-N. Liu and J. Cui. *Nonlocal nonstabilizerness for slightly entangled quantum many-body states*. arXiv:2607.10714v2. [Full text](https://arxiv.org/html/2607.10714v2).
2. L.-Y.-N. Liu and J. Cui. *Entanglement, anti-flatness, and nonlocal nonstabilizerness: a unified perspective from entanglement spectrum*. arXiv:2609.01993v2. [Full text](https://arxiv.org/html/2609.01993v2).
3. P. Sierant. *Spectral geometry of nonlocal stabilizer entropy*. arXiv:2609.13106v2. [Full text](https://arxiv.org/html/2609.13106v2).
4. F. Franchini and S. M. Giampaolo. *Schmidt-Gauge Non-Local Magic: Representation, Optimality, and Mathematical Properties*. arXiv:2608.02745v2. [Full text](https://arxiv.org/html/2608.02745v2).
5. M. Viscardi, L. Leone and A. Hamma. *Non-local Magic: closed-form solution and equivalence with magic of purification*. arXiv:2609.04119v2. [Full text](https://arxiv.org/html/2609.04119v2).
6. L. Leone and L. Bittel. *Stabilizer entropies are monotones for magic-state resource theory*. Physical Review A **110**, L040403 (2024). [Publisher abstract](https://doi.org/10.1103/PhysRevA.110.L040403).
