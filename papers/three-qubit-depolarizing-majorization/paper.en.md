---
title: "Exact output majorization for three qubits"
subtitle: "Exchangeable replacement noise and optimal classical communication at every message count"
date: "Research manuscript v1 · 24 November 2026"
lang: en
---

## Abstract

We prove exact output spectral majorization for three uses of a qubit depolarizing channel throughout its completely positive parameter interval. Every output, including outputs from entangled mixed inputs, is majorized by the output of a pure product input. More generally, the statement holds when a random subset of three qubits is retained, the remaining qubits are replaced by maximally mixed states, and the distribution of the retained subset depends only on its cardinality. The proof assembles four compatible marginal layers in a common eigenvalue order. Its principal two-body inequality is an existing result of Song and Chen, which we explicitly attribute and reprove in the equal-weight case. As an operational consequence, we determine the exact maximum average decoding success probability for every positive integer number of equiprobable messages. Arbitrary three-qubit codewords and joint measurements are allowed, while a computational-basis code attains the bound. This is a finite-block result; it does not settle the corresponding conjecture for arbitrary blocklength or local dimension. The manuscript includes a complete analytic proof, exact rational checks and an independent numerical audit. It has not undergone external peer review or end-to-end Lean verification.

## 1. The question and the contribution

Noise can act independently on three qubits even when their joint input is entangled. Does entanglement make the resulting eight eigenvalues more concentrated than any product input can make them? An entropy comparison alone does not answer this: it controls one scalar function, whereas spectral majorization controls every sum of the largest eigenvalues.

Song, Wang, Tomamichel and Fang formulate the exact depolarizing-output relation for arbitrary local dimension and blocklength in [1, Eq. (2)]. Their version 2 identifies the two-use case as previously known and proves an approximate relation for general blocklength. We address precisely the three-use, two-dimensional instance. The completely positive parameter range is included in full.

Our proof relies on the compatible two-body marginal inequality in Song and Chen [2, Proposition 3]. That inequality is **not a new result of this manuscript**. Neither are Ky Fan variational principles, the qubit spin flip, spectral converses for a given ensemble, or the familiar optimality of product states for minimum output entropy [3]. The contribution considered here is the exact assembly across all four exchangeable marginal layers, its application to the three-use depolarizing conjecture, and the fixed-message-count optimization over arbitrary entangled codewords. Section 8 and the separate novelty audit distinguish these statements from prior results.

The result is useful because the universal quantum optimization becomes explicit. There is no search over entangled input states or joint measurements left in the stated three-qubit communication problem.

## 2. Definitions and the main statements

### 2.1 Spectral majorization

A state is a positive semidefinite matrix with trace one. For a Hermitian matrix $X$, let

$$
K_k(X)=\sum_{i=1}^k\lambda_i^\downarrow(X),\qquad K_0(X)=0,
$$

where the eigenvalues are arranged in nonincreasing order. Write $X\prec Y$ when their traces agree and $K_k(X)\leq K_k(Y)$ at every proper integer index. This notation refers to eigenvalues; it is not a positive-semidefinite matrix inequality.

All systems below have Hilbert space $(\mathbb C^2)^{\otimes3}$. The sites are $A,B,C$. For a subset $I$, write $\rho_I=\operatorname{Tr}_{I^c}\rho$. Tensor factors are always restored to their original site order. In particular, $\rho_{AC}\otimes I_B$ denotes its embedding in the order $A,B,C$.

### 2.2 Exchangeable replacement noise

For $j=0,1,2,3$, define the channel

$$
\mathcal E_j(\rho)=\frac1{\binom3j}
\sum_{|I|=j}\rho_I\otimes(I_2/2)^{\otimes I^c}.
\tag{1}
$$

For $j=0$ the output is $I_8/8$; the linear extension to arbitrary matrices is $X\mapsto\operatorname{Tr}(X)I_8/8$. Given $w_j\geq0$ with $\sum_jw_j=1$, put

$$
\mathcal E_w=\sum_{j=0}^3w_j\mathcal E_j.
\tag{2}
$$

The physical procedure first chooses how many qubits to retain, then chooses a uniform subset of that size. It replaces the other qubits by maximally mixed states. The receiver is not told which subset was retained. Correlations between the replacement events are allowed; the subset distribution must remain invariant under permutations of the three sites.

Let $P=|000\rangle\langle000|$ and $T_w=\mathcal E_w(P)$. Define

$$
\begin{aligned}
q_0&=w_0/8+w_1/4+w_2/2+w_3,\\
q_1&=w_0/8+w_1/6+w_2/6,\\
q_2&=w_0/8+w_1/12,\\
q_3&=w_0/8.
\end{aligned}
\tag{3}
$$

These satisfy $q_0\geq q_1\geq q_2\geq q_3\geq0$ and $q_0+3q_1+3q_2+q_3=1$.

**Theorem 1 (exact three-qubit output majorization).** For every allowed $w$ and every three-qubit state $\rho$,

$$
\mathcal E_w(\rho)\prec T_w,
\qquad
\lambda^\downarrow(T_w)=(q_0,q_1,q_1,q_1,q_2,q_2,q_2,q_3).
\tag{4}
$$

In particular, for

$$
\mathcal D_\lambda(X)=\lambda X+(1-\lambda)\operatorname{Tr}(X)I_2/2,
\qquad -1/3\leq\lambda\leq1,
\tag{5}
$$

every $\mathcal D_\lambda^{\otimes3}(\rho)$ is majorized by $\mathcal D_\lambda^{\otimes3}(P)$. If

$$
\alpha=(1+|\lambda|)/2,\qquad \beta=(1-|\lambda|)/2,
\tag{6}
$$

the reference spectrum is

$$
(\alpha^3,\alpha^2\beta,\alpha^2\beta,\alpha^2\beta,
\alpha\beta^2,\alpha\beta^2,\alpha\beta^2,\beta^3).
\tag{7}
$$

### 2.3 The communication model

There are $M\geq1$ equally likely classical messages. Message $m$ can be encoded into any three-qubit density matrix $\rho_m$, including an entangled or mixed state. The receiver uses any joint POVM $(F_m)_{m=1}^M$ on the eight-dimensional output, with $F_m\geq0$ and $\sum_mF_m=I_8$. The average probability of a correct decision is

$$
P_{\rm succ}=\frac1M\sum_{m=1}^M\operatorname{Tr}[F_m\mathcal E_w(\rho_m)].
\tag{8}
$$

This is a fixed block with no preshared sender-receiver entanglement, no retained noiseless receiver reference, no feedback and no adaptive intervention between channel uses. Repeated encodings and zero POVM effects are allowed, as in the usual average-error coding model. The criterion is average success, not worst-message success.

**Theorem 2 (exact success probability at every message count).** In this model,

$$
P^*_{\rm succ}(M;w)=
\begin{cases}
1,&M=1,\\
q_0+(8/M-1)q_1,&2\leq M\leq8,\\
8q_0/M,&M>8.
\end{cases}
\tag{9}
$$

For the independent depolarizing channel, throughout $-1/3\leq\lambda\leq1$, this becomes

$$
P^*_{\rm succ}(M;\lambda)=
\begin{cases}
1,&M=1,\\
\alpha^3+(8/M-1)\alpha^2\beta,&2\leq M\leq8,\\
8\alpha^3/M,&M>8.
\end{cases}
\tag{10}
$$

Thus arbitrary entangled encoding and joint decoding have no advantage over an explicit basis code for this precise problem. This statement does not concern quantum communication capacity, other blocklengths, entanglement assistance or other noise models.

## 3. Matrix facts and compatible marginals

For integer $k$, the variational principle

$$
K_k(X)=\max_{R=R^2=R^\dagger,\ \operatorname{Tr}R=k}\operatorname{Tr}(RX)
\tag{11}
$$

implies unitary invariance, convexity and subadditivity of $K_k$. To see the formula directly, diagonalize $X$. The diagonal of $R$ lies in $[0,1]^8$ and sums to $k$, so the largest possible weighted sum of the eigenvalues selects the first $k$ of them. Their spectral projection attains this sum.

We also use eigenvalue monotonicity: $X\geq D$ implies $\lambda_i^\downarrow(X)\geq\lambda_i^\downarrow(D)$ for each $i$. This follows from the min-max characterization of eigenvalues, since every Rayleigh quotient increases when a positive semidefinite matrix is added.

For a pure input, let the one-qubit marginal eigenvalues be $(1-r_i,r_i)$, where $0\leq r_i\leq1/2$. They satisfy

$$
r_A\leq r_B+r_C,\quad r_B\leq r_A+r_C,\quad r_C\leq r_A+r_B.
\tag{12}
$$

Here is a short proof of the needed three-site polygon inequalities. Choose maximal-eigenvalue eigenvectors $b_0,c_0$ of the two marginals. The commuting-projector inequality

$$
I-P_B\otimes P_C\leq(I-P_B)\otimes I+I\otimes(I-P_C)
$$

gives $\langle b_0c_0|\rho_{BC}|b_0c_0\rangle\geq1-r_B-r_C$. The nonzero spectra of the two marginals of a bipartite pure state coincide: they are those of two Gram matrices of the same coefficient matrix. Consequently $\lambda_{\max}(\rho_{BC})=1-r_A$, proving the first inequality; permutation gives the others. The general polygon result is due to Higuchi, Sudbery and Szulc [7].

## 4. The known two-body layer, proved explicitly

Define the unnormalized marginal sums

$$
S_1=\rho_A\otimes I_{BC}+I_A\otimes\rho_B\otimes I_C+I_{AB}\otimes\rho_C,
$$

$$
S_2=\rho_{AB}\otimes I_C+\rho_{AC}\otimes I_B+I_A\otimes\rho_{BC}.
\tag{13}
$$

We need

$$
S_2\prec\operatorname{diag}(3,1,1,1,0,0,0,0).
\tag{14}
$$

Equation (14) is the equal-weight case of [2, Proposition 3], expressed at trace six. We give the argument to make all assumptions visible and to avoid treating the cited result as an unchecked black box.

It suffices first to consider pure $\rho$. Set

$$
Y=\begin{pmatrix}0&-i\\ i&0\end{pmatrix},\qquad
\widetilde\rho=Y^{\otimes3}\rho^{\mathsf T}Y^{\otimes3}.
$$

Direct multiplication shows $YX^{\mathsf T}Y=\operatorname{Tr}(X)I_2-X$ for every $2\times2$ matrix $X$. Tensor expansion therefore yields

$$
\widetilde\rho=I_8-S_1+S_2-\rho.
$$

The transpose here is the **full transpose**. It preserves positivity and trace; no positivity claim is made about a partial transpose. With $D=S_1-I_8$, we obtain

$$
S_2=D+\rho+\widetilde\rho\geq D,
\qquad \operatorname{Tr}D=4,\quad \operatorname{Tr}S_2=6.
\tag{15}
$$

Diagonalize the three one-qubit marginals by local unitaries and put $s=r_A+r_B+r_C$. The eight diagonal entries of $D$ are

$$
2-s;\qquad1-s+2r_i\ (i=A,B,C);\qquad
s-2r_i\ (i=A,B,C);\qquad s-1.
\tag{16}
$$

The first entry is largest and the last is smallest. For example, differences from the last are $3-2s$, $2(1-s+r_i)$ and $1-2r_i$, all nonnegative because $r_i\leq1/2$. Similarly, comparison with the first uses $r_i+r_j\leq1$ and $r_i\leq1/2$.

Let $\delta=(1-s)_+$. Every entry except the first is at most one. For the entries $1-s+2r_i$, this is exactly the polygon inequality $r_i\leq r_j+r_k$; for $s-2r_i$ it follows from $r_j+r_k\leq1$; and $s-1\leq1/2$. The first entry obeys $2-s\leq1+\delta$. Hence, without requiring a full sorting of the middle six entries,

$$
K_k(D)\leq k+\delta\quad(k=1,2,3),
\qquad \lambda_8(D)=s-1.
\tag{17}
$$

Eigenvalue monotonicity in (15) gives $\lambda_i(S_2)\geq\lambda_i(D)$. Since $S_2\geq0$, its last eigenvalue has the stronger bound

$$
\lambda_8(S_2)\geq\max\{s-1,0\}=\lambda_8(D)+\delta.
$$

Subtracting the resulting lower bound on the spectral tail from trace six gives

$$
\begin{aligned}
K_k(S_2)
&\leq6-\bigl[4-K_k(D)+\delta\bigr]\\
&\leq k+2,\qquad k=1,2,3.
\end{aligned}
\tag{18}
$$

For $k\geq4$, positivity gives $K_k(S_2)\leq6$. These are precisely the required partial sums of (14). For mixed input, decompose $\rho$ into pure states and use linearity of $S_2$ and convexity of each $K_k$. Dividing by six proves $\mathcal E_2(\rho)\prec\mathcal E_2(P)$.

Compatibility is essential in this proof. Independently chosen pair states need not come from a common $\rho$; [2] gives a counterexample in that setting. Our executable audit includes that example as a negative control.

## 5. Completing the spectral theorem

### 5.1 The other layers

The $j=0$ layer is independent of the input. For $j=3$, every state is majorized by the rank-one state $P$.

For $j=1$, diagonalize the marginal states as $\operatorname{diag}(1-r_i,r_i)$. Start from the aligned operator

$$
A_1=P_A\otimes I_{BC}+I_A\otimes P_B\otimes I_C+I_{AB}\otimes P_C.
$$

Independently flip site $i$ with probability $r_i$. The average of these unitary conjugations of $A_1$ is exactly $S_1$ in the chosen local basis: the flip mixture maps $P_i$ to the required marginal and leaves each identity fixed. Convexity and unitary invariance of $K_k$ imply $S_1\prec A_1$. Division by twelve gives the $j=1$ layer inequality. Adding three separate rank-four estimates would be insufficient; the common random-unitary construction supplies the sharper spectrum.

### 5.2 One ordering for all aligned layers

The aligned outputs are diagonal. A basis string of Hamming weight $h$ has the entries in the following table.

| $h$ | Multiplicity | $\mathcal E_0(P)$ | $\mathcal E_1(P)$ | $\mathcal E_2(P)$ | $\mathcal E_3(P)$ |
|---|---:|---:|---:|---:|---:|
| 0 | 1 | $1/8$ | $1/4$ | $1/2$ | 1 |
| 1 | 3 | $1/8$ | $1/6$ | $1/6$ | 0 |
| 2 | 3 | $1/8$ | $1/12$ | 0 | 0 |
| 3 | 1 | $1/8$ | 0 | 0 | 0 |

Every column is nonincreasing in the same row order. Consequently,

$$
\begin{aligned}
K_k(\mathcal E_w(\rho))
&\leq\sum_jw_jK_k(\mathcal E_j(\rho))\\
&\leq\sum_jw_jK_k(\mathcal E_j(P))\\
&=K_k\!\left(\sum_jw_j\mathcal E_j(P)\right).
\end{aligned}
\tag{19}
$$

The final equality uses the common order, not just commutativity. A sum of arbitrary diagonal matrices need not have this property. All traces equal one, proving Theorem 1 for exchangeable replacement noise. Reading the weighted table yields (3).

### 5.3 The full depolarizing interval

For $0\leq\lambda\leq1$, the tensor cube of (5) has (2) with

$$
w_j=\binom3j\lambda^j(1-\lambda)^{3-j}.
\tag{20}
$$

Theorem 1 applies. To cover negative $\lambda$, let $u=-\lambda\geq0$ and $R(X)=\operatorname{Tr}(X)I_2-X$. Algebra gives $R\mathcal D_u=\mathcal D_{-u}$ and

$$
R^{\otimes3}(X)=Y^{\otimes3}X^{\mathsf T}Y^{\otimes3}.
\tag{21}
$$

Thus $\mathcal D_{-u}^{\otimes3}(\rho)$ and $\mathcal D_u^{\otimes3}(\rho)$ have identical spectra, as do their product references. The already proved positive-parameter inequality therefore applies for $-1/3\leq\lambda<0$.

The map $R$ is not a physical qubit channel; it is used only through the algebraic, spectrum-preserving full transpose in (21). Complete positivity of (5) on the stated interval can be seen directly from its Pauli representation: the identity conjugation has probability $(1+3\lambda)/4$, and each of the other three Pauli conjugations has probability $(1-\lambda)/4$. These probabilities are nonnegative exactly on $[-1/3,1]$.

## 6. Exact coding at every message count

### 6.1 A spectral converse

Extend $K_k(T_w)$ to $K_t(T_w)$ for real $0\leq t\leq8$ by linear interpolation between consecutive integers. Its slopes are the ordered eigenvalues, so it is concave. For any effect $0\leq F\leq I$,

$$
\operatorname{Tr}(F\sigma)\leq K_{\operatorname{Tr}F}(\sigma).
\tag{22}
$$

Indeed, in an eigenbasis of $\sigma$, the diagonal entries of $F$ lie between zero and one and have a prescribed sum. Filling the largest eigenvalues first solves that elementary linear optimization.

By Theorem 1 the right side of (22) is at most $K_{\operatorname{Tr}F}(T_w)$. Since the POVM traces sum to eight, concavity gives

$$
P_{\rm succ}\leq\frac1M\sum_mK_{\operatorname{Tr}F_m}(T_w)
\leq K_{8/M}(T_w).
\tag{23}
$$

This form of spectral converse is standard and has close precedents in [1,5]; the new input here is a zero-defect, uniform comparison over all three-qubit codewords. For $2\leq M\leq8$, the argument $8/M$ lies in $[1,4]$, where the reference Lorenz curve is the straight segment $q_0+(t-1)q_1$. For $M>8$ it lies in $[0,1]$, where the curve is $tq_0$. This proves the upper bound in (9).

### 6.2 An attaining basis code

For a computational-basis input $|c\rangle$, the output is diagonal and assigns probability $q_{d_H(c,y)}$ to readout $y$, where $d_H$ is Hamming distance. This follows either from (1) or from local bit-flip covariance.

For $2\leq M\leq8$, choose any $M$ distinct three-bit strings containing $000$ and $111$. Every string of length three has Hamming distance at most one from one of these two strings. A receiver measures in the computational basis and chooses a closest codeword. The conditional likelihood is maximal because $q_0\geq q_1\geq q_2\geq q_3$.

For each of the $M$ selected readouts the largest conditional probability is $q_0$. Each of the $8-M$ unselected readouts has distance exactly one from the code and contributes $q_1$. Therefore the average success is

$$
\frac1M\sum_{y\in\{0,1\}^3}\max_{c\in\mathcal C}q_{d_H(c,y)}
=\frac{Mq_0+(8-M)q_1}{M},
\tag{24}
$$

which attains (23). Ties, including ties caused by degenerate spectra, can be broken arbitrarily.

For $M>8$, use all eight basis states for eight designated messages. Assign any valid input to every remaining message and use zero POVM effects for those messages. The eight designated outcomes yield average success $8q_0/M$. For $M=1$, always returning the unique message succeeds with probability one. This proves Theorem 2.

For negative depolarizing parameters, invert all measured bit labels before decoding. The resulting classical probabilities have the parameters $\alpha,\beta$ in (6). This establishes (10) throughout the physical interval.

## 7. Examples and interpretation

At $\lambda=1/2$, the product reference spectrum is exactly

$$
\frac1{64}(27,9,9,9,3,3,3,1).
$$

Its seven proper leading sums are $(27,36,45,54,57,60,63)/64$. Every three-qubit output obeys all seven bounds simultaneously.

| Number of messages | Exact optimal success | Decimal |
|---:|---:|---:|
| 2 | $27/32$ | 0.84375 |
| 3 | $21/32$ | 0.65625 |
| 4 | $9/16$ | 0.56250 |
| 5 | $81/160$ | 0.50625 |
| 6 | $15/32$ | 0.46875 |
| 7 | $99/224$ | 0.44196 |
| 8 | $27/64$ | 0.421875 |

For $M=2$ the optimal basis code is the repetition code $000,111$. For intermediate counts, keep these endpoints and add arbitrary distinct strings. The code does not require optimizing continuous quantum parameters.

The result also fixes every convex unitarily invariant functional that increases under spectral concentration: its maximum output is attained by the product reference. Concave spectral entropies have the corresponding minimum there. These are consequences of majorization, rather than separate claims of new entropy additivity.

At $\lambda=0$, (10) reduces to $1/M$, since all outputs are identical. At $\lambda=1$ it reduces to $\min\{1,8/M\}$, the dimension limit. These endpoints and the physical negative endpoint $\lambda=-1/3$ are included without a limiting argument.

## 8. Prior work, verification and limits

Fujiwara and Hashizumé [4] established a two-channel majorization result. King [3] proved depolarizing maximal-output norm multiplicativity and entropy/capacity additivity. These results do not supply the three-use leading-eigenvalue sums in (4). Alhejji and Knill [8, Section III] already connect spin alignment to depolarizing channels; their relevant proved bounds concern integer Schatten objectives and at most two supported subset terms, rather than the present full compatible-marginal sum. Song and Chen [2] provide the two-body layer used here. Song et al. [1] state the general exact conjecture and obtain approximate bounds. We settle only the specified three-qubit instance and the exchangeable replacement family above.

Havas, Lin and Rosnes [5] give a converse for a supplied ensemble using its spectra and study product-output coding. Their global depolarizing map on an entire output space is different from a tensor product of three local depolarizing maps. Our uniform majorization theorem removes the product-codeword restriction in the finite problem considered here. For independent depolarization the branch $M\geq8$ follows already from King's maximum-output operator-norm bound and is also covered by communication-value multiplicativity [6, Theorem 4]. We do not claim that branch as an independent new discovery. The fixed counts $M=2,\ldots,7$ require the sharper spectral information used above.

Delsol, Fawzi, Kochanowski and Ramachandran [9, Section 5.1, Figure 2] report numerically tight semidefinite-programming bounds for binary communication through up to three copies of a qubit depolarizing channel. Their attaining binary code is the repetition code used here. Our $M=2$ branch is therefore an analytic confirmation of an existing numerical observation, not the first observation of this code's optimality. The full-spectrum theorem and the complete fixed-$M$ formula are the scope of the proposed contribution. We do not claim that every isolated binary-channel consequence is previously unknown in all equivalent formulations.

The accompanying exact checker uses rational arithmetic. It checks the scalar inequalities behind (17) at every vertex of the two relevant marginal polytopes, verifies the spin-flip and channel identities on all 64 matrix units, and enumerates all nonempty computational-basis codebooks for several rational noise parameters. Degree-three channel identities are checked at four distinct rational points, which determines every coefficient exactly. This verifies those finite algebraic components, not the entire universal matrix theorem.

A separately written audit implements the channel by Pauli Kraus conjugations, Pauli-weight multipliers and index-based partial traces. It checks 408 named and seeded random pure/mixed states at eleven depolarizing parameters (4,488 channel cases), 2,496 exchangeable-channel cases, 120 joint-POVM cases and 420 attaining-code cases. The incompatible pair-state example of [2] is correctly rejected. The largest positive depolarizing partial-sum excess is below $8.9\times10^{-16}$, below the diagnostic tolerance $2\times10^{-12}$. Full counts, tolerances and source hashes are in the result files. Numerical checks are diagnostics; the analytic argument above establishes the continuum claim.

No claim is made for four or more channel uses, higher local dimensions, arbitrary nonexchangeable subset weights, a revealed replacement flag, entanglement assistance, adaptive use, a worst-message criterion or unrestricted quantum capacity. This draft was prepared with AI assistance. Independent review in the accompanying package means separate agents within the same research session and separately written verification code. No end-to-end Lean proof or external peer review is claimed. The novelty statement is limited to the primary sources and search record listed in `NOVELTY_AUDIT.md` and `SOURCES.json`.

## References

1. Z. Song, X. Wang, M. Tomamichel and K. Fang. *Approximate majorization and high-order capacity of quantum depolarizing channels*. arXiv:2609.37240v2 (2026). [Versioned source](https://arxiv.org/abs/2609.37240v2).
2. Z. Song and L. Chen. *A counterexample to the strong spin alignment conjecture*. arXiv:2603.25410v1 (2026), Proposition 3. [Versioned source](https://arxiv.org/abs/2603.25410v1).
3. C. King. *The capacity of the quantum depolarizing channel*. IEEE Transactions on Information Theory **49**, 221–229 (2003). DOI: [10.1109/TIT.2002.806153](https://doi.org/10.1109/TIT.2002.806153); [author preprint](https://arxiv.org/abs/quant-ph/0204172v2).
4. A. Fujiwara and T. Hashizumé. *Additivity of the capacity of depolarizing channels*. Physics Letters A **299**, 469–475 (2002). DOI: [10.1016/S0375-9601(02)00735-1](https://doi.org/10.1016/S0375-9601(02)00735-1).
5. T. Havas, H.-Y. Lin and E. Rosnes. *A Spectrum-Based Converse for Quantum State Discrimination and Its Applications to Classical-Quantum Channel Coding*. arXiv:2610.06840 (2026). [Source](https://arxiv.org/abs/2610.06840).
6. E. Chitambar, I. George, B. Doolittle and M. Junge. *The Communication Value of a Quantum Channel*. IEEE Transactions on Information Theory **69**, 1660–1679 (2023). DOI: [10.1109/TIT.2022.3218540](https://doi.org/10.1109/TIT.2022.3218540); [preprint](https://arxiv.org/abs/2109.11144).
7. A. Higuchi, A. Sudbery and J. Szulc. *One-qubit reduced states of a pure many-qubit state: polygon inequalities*. Physical Review Letters **90**, 107902 (2003). DOI: [10.1103/PhysRevLett.90.107902](https://doi.org/10.1103/PhysRevLett.90.107902); [author preprint](https://arxiv.org/abs/quant-ph/0209085v2).
8. M. A. Alhejji and E. Knill. *Towards a resolution of the spin alignment problem*. Communications in Mathematical Physics **405**, 119 (2024). DOI: [10.1007/s00220-024-04980-1](https://doi.org/10.1007/s00220-024-04980-1); [checked preprint](https://arxiv.org/abs/2307.06894v3).
9. I. Delsol, O. Fawzi, J. Kochanowski and A. Ramachandran. *Computational Aspects of the Trace Norm Contraction Coefficient*. arXiv:2507.16737v3 (2026), Section 5.1. [Versioned source](https://arxiv.org/abs/2507.16737v3).
