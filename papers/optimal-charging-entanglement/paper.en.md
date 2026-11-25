---
title: "Entanglement required for optimal charging in a Clifford battery"
fontsize: 11pt
geometry: margin=1.1in
abstract: |
  The complete-graph Clifford battery has a sharp separable charging bound and a larger joint optimum. We determine the exact minimum initial entanglement required to attain the joint optimum in its battery ground sector. With \(2m\) graph vertices, every optimal pure state has its squared Schmidt coefficients in identical blocks of size \(2^{\lfloor(m-1)/2\rfloor}\). The minimum is attained even at prescribed auxiliary fermion parity. Measuring commuting charging sectors gives quantitative entanglement and Schmidt-number witnesses below the optimum. Any sequence reaching a fraction \(1-o(1)\) of the optimal power requires at least \(m/2-o(m)\) ebits of relative entropy of entanglement. Explicit partially entangled states give a finite-size family connecting the sharp separable and joint endpoints.
---

## 1. Model and statements

The complete-graph spin battery of [1,2] has \(2m\) vertices and \(N=m(2m-1)\) spins, with \(m\ge1\). We use the algebraic reduction in [2, §§2–3]. On the battery there are \(2m\) Hermitian Clifford generators \(B_i,R_i\), \(1\le i\le m\), meaning that each squares to identity and distinct generators anticommute. The normalized energy observable is \(G=m^{-1/2}\sum_i B_i\). The battery begins in \(\mathcal H_{B,-}=\ker(G+I)\), with projector \(\Pi_-=(I-G)/2\).

On the auxiliary system let \(Q_i=i\chi\gamma_i\) for physical Majoranas \(\chi,\gamma_1,\ldots,\gamma_m\). Use the full Fock representation, adding one unused Majorana if necessary to make the physical Majorana count even. The \(Q_i\) are Hermitian Clifford generators and preserve total auxiliary parity. We may use the whole auxiliary Hilbert space or either prescribed total parity sector. In both cases define
\[
F_i=R_i\otimes Q_i,\qquad K=\sum_{i=1}^m F_i .
\]
The \(F_i\) commute and each flips the battery ground and excited sectors. The ground-sector energy and power expressions of [2] show that the normalized peak absolute power \(\eta\) is
\[
\eta(\rho)=\frac{\operatorname{Tr}(\rho K^2)}{m^2}.
\tag{1}
\]
It is also the maximal fraction of the battery's spectral capacity that the same state can charge. Both definitions use the fixed model of [1], and the normalization divides power by the joint optimum \(2\sqrt{2}\,m\) before the Hamiltonian norm rescaling. The ratio is unchanged under that rescaling. The exact separable endpoint is \([m+2\lfloor m/2\rfloor]/m^2\), and the joint endpoint is one [2].

For a pure state, squared Schmidt coefficients are the nonzero eigenvalues of either reduced density matrix, counted with multiplicity. The Schmidt number of a mixed state is the smallest \(r\) for which it is a convex mixture of pure states of Schmidt rank at most \(r\). We measure entropy in bits. Write \(E_R\) for the relative entropy of entanglement, the infimum of quantum relative entropy to separable states, and \(E_F\) for entanglement of formation.

**Theorem 1 (exact cost of optimal charging).** Put \(d=2^{\lfloor(m-1)/2\rfloor}\). At \(\eta=1\), every pure state's squared Schmidt coefficients occur in groups of \(d\) identical entries. An optimal pure state with \(d\) equal coefficients exists at either prescribed auxiliary parity. The minimum Schmidt number among optimal initial states is \(d\), and the minimum of either \(E_R\) or \(E_F\) is \(\log_2 d\).

**Theorem 2 (witnesses below the optimum).** A state of Schmidt number at most \(r\) has probability at most \(\min(1,r/d)\) in every charging sector defined below. The sector energies and this cap yield an explicit finite upper bound on \(\eta\). For any ground-sector state with charging-sector distribution \(p\),
\[
E_R(\rho)\ge \log_2 d-H(p).
\tag{2}
\]
In particular, if \(H_2\) denotes binary entropy and \(J_{\max}=\lfloor m/2\rfloor\),
\[
E_R(\rho)\ge
\log_2 d-\log_2(J_{\max}+1)
-m H_2\!\left(\frac{1-\sqrt{\eta}}2\right).
\tag{3}
\]
Thus \(\eta\to1\) as \(m\to\infty\) forces \(E_R\ge m/2-o(m)\).

**Theorem 3 (intermediate resource construction).** For each integer \(1\le k\le m\) with \(m-k\) even, there is a pure initial state of Schmidt rank \(d_k=2^{\lfloor(k-1)/2\rfloor}\) and entropy \(\log_2 d_k\), with either prescribed auxiliary parity, such that
\[
\eta=\frac{k^2+2(m-k)}{m^2}.
\tag{4}
\]
It reproduces the separable endpoint at \(k=1\) for odd \(m\) or \(k=2\) for even \(m\), and the joint endpoint at \(k=m\).

## 2. Charging sectors and their pure states

Set \(\ell=m-1\). The relative involutions \(E_i=F_iF_m\), \(i\le\ell\), preserve the ground sector. On the two local spaces define
\[
X_i=iR_iR_m,\qquad Y_i=-iQ_iQ_m,\qquad E_i=X_i\otimes Y_i .
\tag{5}
\]
Both local families satisfy the Clifford relations. The \(E_i\) commute, and
\[
K^2=\left(I+\sum_{i=1}^{\ell} E_i\right)^2 .
\tag{6}
\]
Indeed \(K=(I+\sum_i E_i)F_m\) on the full space and \(F_m^2=I\). On the ground sector, use the joint orthogonal projectors \(P_\epsilon\) of the \(E_i\), labelled by \(\epsilon\in\{-1,1\}^\ell\). The \(\ell=0\) convention is a single projector onto the whole allowed space.

Each \(P_\epsilon\) is nonzero. For every nonempty \(I\subseteq\{1,\ldots,\ell\}\), the product \(X_I\) is, up to phase, a nonempty word in distinct \(R_i\) in the original representation. In \(\operatorname{Tr}(\Pi_- X_I)\), the terms involving \(G\) are words with one \(B_i\) and distinct \(R_i\). Every such nonempty word has trace zero. For a word of even length conjugate by a participating generator. For a word of odd length conjugate by an unused generator, which exists since the full family has even size. These conjugations reverse the sign. The product expansion of \(\prod_i(I+\epsilon_i E_i)/2\) restricted to the ground and any auxiliary parity consequently has only its identity term in the trace. Each joint projector has dimension \(\dim(\mathcal H_{B,-})\dim(\mathcal H_A)/2^\ell\), with \(\mathcal H_A\) the chosen auxiliary space.

The normalized eigenvalue of \(K^2\) in sector \(\epsilon\) is
\[
a_\epsilon=\frac{(1+\sum_i\epsilon_i)^2}{m^2}
=\left(1-\frac{2j}{m}\right)^2 ,
\quad
j=\min\{\#\{i:\epsilon_i=-1\},m-\#\{i:\epsilon_i=-1\}\}.
\tag{7}
\]
We can count sectors by taking all \(m\)-bit sign patterns modulo simultaneous reversal, and choosing the orientation with last sign \(+1\). The number \(N_j\) with given mismatch \(j\) is \(\binom{m}{j}\) for \(j<m/2\), and \(\binom{m}{m/2}/2\) for \(j=m/2\) when \(m\) is even. The top sector \(\epsilon=(1,\ldots,1)\) is unique.

### 2.1. The local Clifford factors

Here is the finite-dimensional representation fact used in the proof. For \(2u\) generators, the complex Clifford algebra is the full matrix algebra of size \(2^u\). Products of distinct generators span it by the relations. The \(2u\) Jordan–Wigner generators on \(u\) qubits realize \(2^{2u}\) linearly independent products, since all nonidentity words have trace zero and the products are orthogonal in Hilbert–Schmidt inner product. This agrees with the matrix algebra's dimension. In any representation, matrix units give a tensor product of the \(2^u\)-dimensional irreducible module and a multiplicity space. For \(2u+1\) generators, their product times \(i^u\) is a central Hermitian involution. On each of its two eigenspaces the last generator is determined by the first \(2u\) and the sign. The irreducible modules each have dimension \(2^u\). For zero generators the module is one-dimensional. If the central word is traceless on a nonzero space, both signs are present.

Represent a pure bipartite vector as a coefficient matrix \(M\), with the matrix transpose taken in the chosen auxiliary basis. The sector equation \(E_i\psi=\epsilon_i\psi\) is equivalent to
\[
X_i M=M(\epsilon_iY_i^T)\qquad (1\le i\le \ell).
\tag{8}
\]
Transposition preserves the Hermitian Clifford relations in this family. Decompose the two sides into irreducibles of the same \(d=2^{\lfloor\ell/2\rfloor}\)-dimensional size. Matrix-unit commutation shows that every intertwining block between matched types is identity on the irreducible module times an arbitrary multiplicity matrix, after choosing a unitary equivalence of the two modules. Blocks between different central signs vanish. Hence the spectrum of \(MM^\dagger\) has \(d\)-fold repetitions, and (8) describes every pure state in a sector. In particular, its largest squared Schmidt coefficient is at most \(1/d\).

For existence of rank \(d\) in each sector, choose an irreducible piece of the specified auxiliary space, with the action modified as in (8). The corresponding irreducible battery type is available. In the even case there is just one type. In the odd case both types are present because the battery central word is traceless by the trace computation above. An intertwiner between these two pieces, zero on all other pieces and normalized in Hilbert–Schmidt norm, gives a sector vector with precisely \(d\) nonzero squared Schmidt coefficients, all \(1/d\).

An optimal state has support in the top sector by positivity and (7). Every pure state in any decomposition of such a state lies in the top sector, since the complementary projector has zero expectation. This proves the Schmidt number part of Theorem 1. The entropy claims follow from (2) and the rank-\(d\) pure construction.

## 3. From power to entanglement witnesses

### 3.1. A cap on the weight of each sector

Let \(v\) be any unit vector in the ambient bipartite space with Schmidt rank at most \(r\). For a normalized sector vector \(\psi\), the squared overlap is at most \(r/d\). To see this, project \(\psi\) on the battery Schmidt span of \(v\), of dimension at most \(r\). The squared norm of that projection is at most \(r/d\) since \(\psi\)'s reduced state has operator norm at most \(1/d\). The overlap bound holds also for \(v\) with components outside the allowed ground or parity sector. Taking the supremum over normalized sector vectors gives \(\|P_\epsilon v\|^2\le r/d\). Convexity extends this to mixed states of Schmidt number at most \(r\).

For such a state put \(\kappa=\min(1,r/d)\). List all sector values \(a_1\ge a_2\ge\cdots\ge a_{2^\ell}\) from (7), including repetitions. Let \(L=\lfloor1/\kappa\rfloor\). Then
\[
\eta(\rho)\le \kappa\sum_{i=1}^{L} a_i+(1-L\kappa)a_{L+1},
\tag{9}
\]
omitting the last term when its coefficient is zero. There are at least \(L\) sectors. The bound follows by moving probability mass toward larger \(a_i\) until those coordinates reach their cap. This gives a finite Schmidt number witness from direct power measurements within the model. This upper bound uses only the scalar caps and can be strict. For example, at \(m=4,r=1\) it gives \(5/8\), while the known separable optimum is \(1/2\).

### 3.2. An entropy bound using the complete sector distribution

The projectors \(P_\epsilon\), together with their complementary projector in the full space, define a projective measurement. For a separable \(\sigma\), its probability \(q_\epsilon=\operatorname{Tr}(\sigma P_\epsilon)\) is at most \(1/d\) by Section 3.1. The complement has zero probability on the allowed \(\rho\). The finite-dimensional data-processing inequality for quantum relative entropy under a measurement [3] then gives
\[
D(\rho\Vert\sigma)\ge
\sum_\epsilon p_\epsilon\log_2(p_\epsilon/q_\epsilon)
\ge \log_2 d-H(p).
\tag{10}
\]
A nonzero \(p_\epsilon\) with \(q_\epsilon=0\) gives infinite classical relative entropy. Taking the infimum over \(\sigma\) proves (2), including when the separable comparison is allowed to use states outside the ground or fixed-parity subspace. At optimal power \(p\) is supported on the unique top sector, giving \(E_R\ge\log_2 d\). The exact minimum follows since the constructed pure state has entanglement entropy \(\log_2 d\), and \(E_R\le E_F\) by convexity of relative entropy and the Schmidt-basis separable comparison for each pure state.

A second finite witness depends only on the normalized power. With \(\delta=1-\eta\ge0\) and \(D_j=4(j/m)(1-j/m)\), the distribution of matching labels satisfies \(\mathbb E[D_j]=\delta\). For \(\lambda\ge0\), the normalized probability proportional to \(2^{-\lambda D_j}\) per sector gives
\[
E_R(\rho)\ge \log_2 d-\lambda\delta
-\log_2\left(\sum_{j=0}^{\lfloor m/2\rfloor} N_j 2^{-\lambda D_j}\right),
\tag{11}
\]
by nonnegativity of classical relative entropy from \(p\) to that probability. Equation (11) has a one-parameter finite evaluation. Its limit at \(\delta=0\) recovers the exact minimum.

For the closed form (3), by the chain rule and \(N_j\le\binom mj\le2^{mH_2(j/m)}\) we have
\[
H(p)\le \log_2(\lfloor m/2\rfloor+1)+m\,\mathbb E H_2(j/m).
\]
On \([0,1]\) the function \(g(z)=H_2((1-\sqrt{1-z})/2)\) is concave. To check this, put \(s=\sqrt{1-z}\). The derivative for \(0<z<1\) is \(\operatorname{atanh}(s)/(2s\ln 2)\), which decreases in \(z\) since \(\operatorname{atanh}(s)/s\) is increasing in \(s\). Also \(g(D_j)=H_2(j/m)\) since \(0\le j/m\le1/2\). Jensen's inequality bounds the expectation by \(g(\delta)\), giving (3). If \(\eta\to1\) then \(g(\delta)\to0\). Because \(E_R\le E_F\le \log_2 r\) for states of Schmidt number at most \(r\), a fraction tending to one requires Schmidt number at least \(2^{m/2-o(m)}\). The order in the exponent agrees with the exact optimal construction.

## 4. Construction at intermediate Schmidt ranks

Choose \(k\) as in Theorem 3 and partition \(\{k+1,\ldots,m\}\) into disjoint pairs \((a,b)\). Fix eigenvalue \(+1\) for the battery bilinear \(iR_aR_b\) and \(-1\) for the auxiliary bilinear \(iQ_aQ_b\) on each such pair. These are simultaneous local constraints. On the battery they commute with \(G\). Ground-sector nonzeroness follows by the trace expansion of their half-projectors, using the distinct-generator trace argument from Section 2. The auxiliary pair involutions preserve the chosen parity. A common eigenspace exists there because the involutions commute. Conjugation by \(Q_aQ_k\) reverses the sign for the pair \((a,b)\) and preserves every other fixed pair sign and total parity. Hence every prescribed sign pattern is available within the chosen parity.

On these restricted local spaces, the first \(k\) generators give the relative families \(iR_iR_k\) and \(-iQ_iQ_k\) for \(i<k\). They preserve the restrictions since each relative bilinear has disjoint support from every fixed pair. The trace of a nonempty word in the battery relative family in the restricted battery space is still zero: after expanding the ground and fixed-pair projectors, the term's nonempty first-\(k\) support cannot cancel against a word on leftover generators, and any term involving \(G\) includes one \(B_i\). Thus the matching irreducible type argument in Section 2.1 applies in the restricted spaces, including both central signs when required. Choose a rank-\(d_k\) normalized maximally entangled vector on a matching pair of irreducible pieces in the all-plus relative sector.

On this vector, \((\sum_{i\le k}F_i)^2\) has value \(k^2\). For each fixed leftover pair, \(F_aF_b=-(iR_aR_b)\otimes(iQ_aQ_b)\) has value \(+1\). Every other term \(F_aF_b\) involving at least one leftover index anticommutes with the fixed battery bilinear on a pair sharing exactly one of its two indices. Its expectation is zero in the constructed state. The diagonal terms on the leftover indices contribute \(m-k\), and the fixed pair terms contribute another \(m-k\). Division by \(m^2\) proves (4).

For any fixed target fraction \(0<\theta\le1\), take the smallest \(k\) of the required parity with \(k\ge\sqrt{\theta}\,m\) and \(k\ge1\). It exists because \(m\) itself has that parity. This yields \(\eta\ge\theta\) with entropy at most \(\sqrt{\theta}\,m/2+O(1)\). Equations (3), (9) and (11) are lower-resource witnesses for this tradeoff. Determining all intermediate-rank optima remains open.

## 5. Provenance

The model and unrestricted benchmark are due to [1]. The pinned analysis [2] proves the exact separable envelope and supplies the ground-sector transition identity used in (1). The local algebra classification and entropy data processing are standard tools. The additional results here are the charging-sector Schmidt classification, the exact full-optimal resource threshold, and its quantitative and constructive extensions. The comparison treats the prescribed ground sector and battery–auxiliary partition throughout.

**References**

1. Sheryl Mathew. *Battery Locality Is Necessary in Noncommuting Quantum Charging Bounds*. arXiv:2609.06104v1. Model and joint optimum as recorded in [2].
2. *Exact charging power of separable initial states in a complete-graph quantum battery*. earlier research manuscript, fixed commit 8c3a27695b7a, §§2–6. The source manifest contains the full commit and manuscript blob.
3. Göran Lindblad. *Completely positive maps and entropy inequalities*. Communications in Mathematical Physics 40 (1975), 147–151. Quantum relative entropy monotonicity.
