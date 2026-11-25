# Fewer binary measurements for certifying a noiseless quantum code

*Linear setting counts for qudits and logarithmic counts for qubit registers*

## Abstract

Can a short list of yes-or-no measurements determine whether a quantum channel transmits an encoded state perfectly? Zhang and Chen proved that a shift in the joint-measurability threshold of a family of $d^2$ binary measurements detects the absence of a noiseless code of output dimension $d$. They asked whether fewer measurements suffice. We construct families with fewer than $d^2$ settings in every dimension $d\ge2$, with at most $4d+1$ in general. For a register of $n$ qubits, $3n+1$ settings suffice. Every fixed setting in the register construction acts on a single output qubit, and the one variable setting uses local measurements with classical processing. The constructions force a joint parent to refine a minimal informationally complete measurement. They retain the quadratic transmission-error estimate for that parent. For one output qubit, a separate argument using two noisy Pauli measurements gives the minimum possible count of two.

## 1. What a threshold certifies

Let $\mathcal N:M_D(\mathbb C)\to M_d(\mathbb C)$ be a completely positive, trace-preserving channel and $\Lambda=\mathcal N^*$ its unital Heisenberg adjoint. A full-output noiseless code is an isometry $W:\mathbb C^d\to\mathbb C^D$ such that
$$
\mathcal N(W\rho W^*)=\rho\quad\text{for every state }\rho\text{ on }\mathbb C^d.                 \tag{1}
$$
The encoding is the same for all inputs. Equation (1) describes transmission without a further decoding operation. It is equivalent to $W^*\Lambda(X)W=X$ for every output observable $X$.

A binary measurement is specified by its yes effect $0\le E\le I$. A finite list of binary effects is jointly measurable if positive operators $J_{\boldsymbol a}$, one for every bit string of outcomes, sum to $I$ and have the given yes marginals. This entails no restriction on arbitrary parent measurements with classical postprocessing. Given such a parent, one can sample each requested bit conditionally on its outcome, producing a joint bit-string measurement.

For fixed effects $E_1,\ldots,E_k$ and one variable effect $B_s$, the threshold is the largest $s$ in the specified interval for which all effects are jointly measurable. We use $\tau_\Lambda$ for the threshold after applying $\Lambda$ to all effects. The finite-dimensional set of joint measurements is compact. In our constructions the compatible parameters form an interval starting at zero, by convexity. A *setting* counts one binary measurement in the family at a given value of $s$.

Chitambar and Zhang proposed a characterization of channels preserving every incompatible measurement family. Zhang and Chen proved this characterization in every finite dimension and constructed one threshold test involving $d^2$ binary settings. In its discussion, their paper asks whether fewer settings suffice. Our theorem concerns this latter question. [Chitambar and Zhang](https://arxiv.org/abs/2610.06642) · [Zhang and Chen](https://arxiv.org/abs/2610.37347)

**Theorem 1.** In every output dimension $d\ge2$ one can fix a binary family, independently of the channel and of $D$, such that all but one setting are fixed and equality of the image threshold to the original threshold holds exactly when (1) holds. The following are upper bounds on the number of settings.

* In dimension two, two settings suffice and one cannot suffice.
* For $d=3$ there is an eight-setting construction. For $d\ge4$ there is one using $d^2-\lfloor(d^2-1)/3\rfloor$.
* In any dimension the grid construction uses
$$
 g(d)=\left\lceil\frac{d^2}{\lfloor d/2\rfloor}\right\rceil+
       \left\lceil\frac{d^2}{\lceil d/2\rceil}\right\rceil-1.                 \tag{2}
$$
 For even $d$ this is $4d-1$. For odd $d\ge3$ it is $4d+1$.
* If $d=\prod_{l=1}^{n}d_l$, $d_l\ge2$, there is a construction using $1+\sum_l(d_l^2-1)$ settings. In particular $3n+1$ suffice for $n$ output qubits, even for channels with arbitrary correlations across the register.

One may take the smallest applicable bound. For example, a four-level system can be given a two-qubit factorization and tested with seven settings. The complexity here counts distinct binary measurements. Determining their exact compatibility threshold is a separate inference problem.

## 2. When a shorter family inherits a code test

A rank-one minimal informationally complete measurement (MIC) is a positive operator-valued measure $G=(G_j)_{j=0}^{d^2-1}$ whose nonzero effects have rank one and form a real basis of the Hermitian $d\times d$ matrices. Denote its trace-dual basis by $F_j$, so $\operatorname{Tr}(F_iG_j)=\delta_{ij}$. We take $F_0$ invertible. Zhang and Chen construct such a MIC in every dimension. We can also arrange that its supporting vectors are *full spark*, meaning that every subset of at most $d$ is linearly independent. Indeed, perturb vectors for their MIC by arbitrarily small amounts, avoiding the finitely many zero sets of the $d$-column determinants. These determinants are nonzero polynomials on the full space of tuples. With $S$ the sum of the perturbed outer products, apply $S^{-1/2}$ to all vectors to restore normalization. This invertible congruence preserves full spark. The rank-one basis and invertible-dual properties persist for sufficiently small perturbations by continuity of matrix inversion.

Use the variable effect introduced by Zhang and Chen,
$$
B_s=(I-sG_0)/2,\qquad 0\le s\le s_{\max}=1/\|G_0\|.                         \tag{3}
$$
Here $s_{\max}>1$. If an atom had eigenvalue one, every other atom would be orthogonal to its support, contradicting informational completeness.

We call fixed effects *calibrations* for $G$ when they are sums of MIC atoms and every joint outcome operator for their fixed binary outcomes is supported on a single MIC line or is zero, with the total on each line equal to its $G_j$. Such a joint measurement is obtained by splitting the $G_j$ into positive multiples along their own lines. When an atom is split further by another binary setting, its positive parts still have that line as support. The extra setting $B_s$ is thus jointly measurable exactly when its unique MIC coefficients belong to $[0,1]$. These coefficients are $(1-s)/2$ at label zero and $1/2$ elsewhere. The original threshold is exactly one.

**Transfer lemma.** For any calibrations as above, $\tau_\Lambda=1$ if and only if (1) holds. Write $\delta=\tau_\Lambda-1$ and
$$
C_G=\frac{\sqrt d}{\sqrt{\lambda_{\min}(F_0^2)}}\max_{j\ne0}\|F_j\|_1.       \tag{4}
$$
If $\tau_\Lambda<s_{\max}$ and $C_G^2\delta^2<1$, there exists an isometry $W$ satisfying
$$
\|\mathcal N(W\,{\cdot}\,W^*)-\operatorname{id}_d\|_\diamond
  \le 2C_G^2\delta^2.                                                         \tag{5}
$$

*Proof.* A noiseless code allows every image parent to be compressed by $W^*(\cdot)W$, giving an original parent. The opposite implication uses the construction in the proof of Zhang and Chen's theorem, as opposed to an assumption that every coarse-grained image parent is unique. Let $V:\mathbb C^D\to\mathbb C^d\otimes\mathcal E$ be a Stinespring isometry, $K=I-VV^*$ and $C_0=\operatorname{Tr}_{\mathbb C^d}K$. An environment unit vector in $\ker C_0$ gives a noiseless code via $W\psi=V^*(\psi\otimes e)$, since positivity implies $K(\psi\otimes e)=0$ for every $\psi$.

If $C_0$ is positive definite, put $\varepsilon=\lambda_{\min}(C_0)>0$. Zhang and Chen construct positive parts $H_j\le\Lambda(G_j)$ such that $\sum_j H_j=\Lambda(B_{1+t})$ for $0\le t\le\sqrt\varepsilon/C_G$ within the range (3). In particular this is an actual splitting of the single parent $(\Lambda(G_j))_j$. The split effects $H_j,\Lambda(G_j)-H_j$ simulate every binary calibration by reporting membership of $j$ in the prescribed group. Thus
$$
\tau_\Lambda\ge\min\{s_{\max},1+\sqrt\varepsilon/C_G\}.                      \tag{6}
$$
For completeness, their splitting follows by expanding $(F_0^{-1}\otimes C_0^{-1})K$ in the $G_j$ basis and taking Hermitian parts of its environment coefficients $A_j$. Compression gives $\sum_j V^*(G_j\otimes A_j)V=0$ and $A_0=I$. The bound $K\le d I\otimes C_0$, from block Cauchy–Schwarz, and $K^2=K$ give $\|A_j\|\le C_G/\sqrt\varepsilon$ for $j\ne0$. Take $H_0=0$ and $H_j=V^*(G_j\otimes(I+tA_j)/2)V$ for $j\ne0$. This proves (6). Under the hypotheses of (5), $\varepsilon\le C_G^2\delta^2<1$. Zhang and Chen's polar-decomposition encoding on a least-eigenvalue vector of $C_0$ has diamond error at most $2\varepsilon$. Their bound depends on the MIC and the explicit splitting used in (6), hence it applies to the shorter family. $\square$ [Zhang and Chen, equations (8)–(16)](https://arxiv.org/html/2610.37347v1)

## 3. Recovering all MIC atoms from rows and columns

Let $p=\lfloor d/2\rfloor$, $q=\lceil d/2\rceil$, $R=\lceil d^2/p\rceil$ and $C=\lceil d^2/q\rceil$. Assign atom $j$, $0\le j<d^2$, to row $\lfloor j/p\rfloor$ and column $j\bmod C$. Every row has at most $p$ atoms and each column has at most $q$. Since $p\le C$, a cell contains at most one atom. Ask the binary question for the sum of the atoms in each of the first $R-1$ rows and each of the first $C-1$ columns. These are $R+C-2$ fixed settings.

To see why the missing row and column can be recovered, let $J$ be a nonzero joint outcome operator. If it answers yes to a row, $0\le J$ is dominated by that row sum, so its range lies in the span of that row's supporting vectors. Spans of different rows meet in zero because their disjoint lists contain at most $2p\le d$ vectors in total and are full spark. Thus each $J$ answers yes to at most one row. The sum of outcomes with no row yes is $I$ minus the first $R-1$ row effects, precisely the last row effect. Every nonzero outcome consequently has a row label and is supported there.

Within this row, answering yes to a column places the range of $J$ in the intersection of its row and column spans. The two lists together contain at most $p+q=d$ distinct vectors. By linear independence their spans intersect in the shared cell line if occupied, and in zero if empty. Two different column yes answers therefore give zero inside this row. This argument also applies for odd $d$, when distinct column spans need not be disjoint in the original space. Assigning the leftover outcomes to the last column gives its sum by normalization. Every joint outcome is now supported on the line of an occupied cell. Summing yields $I=\sum_j a_jG_j$, $a_j\ge0$. Linear independence and $\sum_jG_j=I$ give $a_j=1$ for every $j$. The transfer lemma proves (2).

## 4. Small dimensions and overlapping pairs of queries

For $d\ge4$, partition the atoms other than $G_0$ into disjoint triples $(G_a,G_b,G_c)$ and up to two singleton leftovers. Replace each triple's three individual calibration queries by the two effects $G_a+G_b$ and $G_b+G_c$. Keep each leftover as a singleton query. In $d=3$ perform this replacement on one triple and keep the other five nonzero-index atoms as singleton queries. In each construction two queries belonging to different triples have disjoint supporting planes, since at most four distinct vectors occur and $d\ge4$ when there are multiple triples. A singleton from outside a triple has line disjoint from its plane already in $d=3$.

For one triple the yes–yes event is supported on the common line and equals $t_bG_b$. Its two yes-only events are $G_a+(1-t_b)G_b$ and $G_c+(1-t_b)G_b$. Positivity of the first on a vector orthogonal to $G_a$'s support and not orthogonal to $G_b$'s gives $t_b\le1$. No other triple can be active in those outcomes. Now the all-no effect is
$$
G_0-\sum_{\text{triples}}(1-t_b)G_b\ge0.
$$
Each term subtracted is positive. Its range must lie in the line of $G_0$, which is distinct from every $G_b$ line. Hence $t_b=1$ for each triple. All events are forced to the prescribed atoms, and the transfer lemma gives the claimed counts. In particular the triple construction uses $8,11,17$ settings in dimensions $3,4,5$ respectively.

## 5. A register of smaller systems

Let the output space be $\bigotimes_{l=1}^{n}\mathbb C^{d_l}$. For each factor choose a rank-one MIC $(G^{(l)}_a)_a$ with invertible distinguished dual $F^{(l)}_0$. The product atoms $G_{\boldsymbol a}=\bigotimes_l G^{(l)}_{a_l}$ form a MIC, since tensor products of the local Hermitian bases have trace-dual basis $\bigotimes_l F^{(l)}_{a_l}$. The distinguished product dual is invertible.

For each factor ask the $d_l^2-1$ binary questions for its local atoms except label zero, tensored with the identity elsewhere. At one factor a joint outcome cannot answer yes to two different local questions. Their ranges are distinct local lines tensored with the other factors, with zero intersection. The total effect of no yes at that factor is $G^{(l)}_0\otimes I_{\ne l}$ by normalization. Each joint outcome is therefore supported in one local line at every factor. The intersection is a product line, and normalization plus product MIC independence fixes all its weights. A single global variable effect (3) now gives (1) and (5). The channel itself need have no tensor-product structure.

For qubits one may choose the tetrahedral MIC $G_a=P_a/2$, where the four unit Bloch vectors of $P_a$ point to the vertices of a regular tetrahedron. Its duals are $F_a=3P_a-I$. In an $n$-qubit register the variable effect is
$$
B_s=\tfrac12 (I-s\,2^{-n}P_0^{\otimes n}),\qquad 0\le s\le 2^n.
$$
It can be implemented by measuring $P_0$ locally on each qubit, then reporting yes with probability $(1-s2^{-n})/2$ when all qubits give the $P_0$ outcome and $1/2$ otherwise. All fixed queries are one-qubit measurements. This implementation uses $3n+1$ settings and separates the count from sensitivity: a unit increase in $s$ changes the effect by operator norm $2^{-n-1}$. Formula (4) gives $C_G=\sqrt{2^n}\,3^n$, so (5) gives the explicit bound $2\,18^n(\tau_\Lambda-1)^2$ under its stated hypotheses.

Within the calibration method of Section 2, the logarithmic order in the output dimension is necessary. A joint outcome table for $k$ fixed binary settings has at most $2^k$ cells. Each nonzero cell occupies one MIC line, and every one of the $d^2$ distinct lines has positive total effect. Hence $2^k\ge d^2$. Including the variable setting, any such method needs at least $1+\lceil2\log_2 d\rceil$ settings. For $n$ qubits this places the count between $2n+1$ and $3n+1$ within this class.

## 6. Two settings are enough for one output qubit

Write $X,Z$ for the Pauli matrices and $t_0=1/\sqrt2$. Use the fixed effect $(I+t_0X)/2$ and vary $(I+tZ)/2$ for $0\le t\le1$. Two orthogonal unbiased qubit spins are jointly measurable if and only if the sum of their squared visibilities is at most one. The original threshold is $t_0$. We show that any channel preserving that threshold has a full noiseless qubit code. [Busch](https://doi.org/10.1103/PhysRevD.33.2253)

For Hermitian contractions $A,B$ denote by $\beta(A,B)$ the largest CHSH value when the two observables on one side are fixed to $A,B$ and the other observables and bipartite state may vary. Binary compatibility is equivalent to $\beta\le2$. In finite dimensions one may write
$$
\beta(A,B)=2\max_{0\le\theta\le\pi/2}\|\cos\theta\,A+i\sin\theta\,B\|.          \tag{7}
$$
Indeed, the two optimized observables may be taken as reflections and decomposed into simultaneous invariant spaces of dimension at most two. On a two-dimensional block their sum and difference are $2\cos\theta$ and $2\sin\theta$ times orthogonal Pauli matrices. The resulting CHSH matrix is block off-diagonal, giving (7), and every angle is realized. The one-dimensional blocks are covered by the endpoints. [Wolf, Pérez-García and Fernández, Proposition 2](https://doi.org/10.1103/PhysRevLett.103.230402)

Set $A=\Lambda(X)$ and $B=\Lambda(Z)$. If the threshold remains $t_0$, the image pair is compatible at $t_0$ and incompatible at every $t>t_0$. By continuity, $\beta(t_0 A,t_0 B)=2$. Homogeneity gives $\beta(A,B)=2\sqrt2$. Equality in (7) and $\cos\theta+\sin\theta\le\sqrt2$ forces $\theta=\pi/4$. For a maximizing unit vector $v$, equality in the triangle inequality gives $Av=iBv=:w$ with $\|w\|=1$. As $A$ and $B$ are Hermitian contractions, $A^2v=B^2v=v$. Hence $Aw=v$ and $Bw=iv$. Also $v\perp w$, because both $\langle v,Av\rangle$ and $\langle v,Bv\rangle$ are real. The two-dimensional space $L=\operatorname{span}\{v,w\}$ reduces $A$ and $B$, on which both act unitarily.

For a Stinespring isometry $V$ of $\Lambda$, equality of norms on $L$ gives $(X\otimes I)V\xi=VA\xi$ and $(Z\otimes I)V\xi=VB\xi$ for every $\xi\in L$. Indeed, compression to $\operatorname{ran}V$ preserves the norm of each vector on the left. Thus $VL$ is invariant under all $M_2\otimes I$, since $X,Z$ generate $M_2$. Applying the matrix units shows that every such invariant subspace is $\mathbb C^2\otimes E'$ for an environment subspace $E'$. Since $\dim VL=2$, $E'$ is one-dimensional. A unit vector $e\in E'$ gives the encoding $W\psi=V^*(\psi\otimes e)$ and (1). Conversely (1) preserves the threshold by compression. A single binary measurement is always compatible, for every channel and every allowed parameter. This proves optimality of the count in dimension two.

## 7. Scope

The register construction uses additional structure in the chosen output Hilbert-space decomposition. A channel acting jointly across all factors must still transmit every state in the entire output space to pass the threshold test. The general grid applies also in prime dimensions. The minimum number of binary settings in dimensions greater than two remains undetermined by these bounds. The quadratic error estimate is inherited from the established MIC splitting argument and depends on its conditioning. Counts of fixed laboratory settings, estimates of a joint-measurability boundary from finite data, and guarantees on encoding error quantify different resources.
