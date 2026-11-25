# Singular-value product bounds for quantum channels and the optimal qubit count

*Universal coarse bounds and sharp results for single-defect and qubit channels*

24 November 2026

## Abstract

Let $T:M_d(\mathbb C)\to M_d(\mathbb C)$ be completely positive and trace preserving, and let $\sigma_1(T)\ge\cdots\ge\sigma_{d^2}(T)$ denote its Hilbert–Schmidt singular values. We prove that
$$
\sum_{j=1}^{d^2-k}\sigma_j(T)^2\le d^2-k
\qquad\text{whenever}\qquad k\ge1,\quad (\sqrt{k}+1)^2\le2d.
$$
The inequality is strict for every nonunitary channel. The arithmetic–geometric mean inequality then gives $|\det T|\le\prod_{j=1}^k s_j^\uparrow(T)$. In particular, the factor count $k=\lfloor2d-2\sqrt{2d}+1\rfloor$ is exactly the one in Caro and Graswald's Corollary 4.16. Its product upper bound therefore holds without the infinitesimal Markovian-divisibility assumption and cannot detect failure of that property. This answers the question posed in their Remark 4.20 for the proved factor count. The separate nonnegative-determinant test remains meaningful. For a channel with a Kraus operator of defect rank at most one, we obtain the stronger square-sum and product bounds at $q_*=(d-1)^2+1$ retained factors, even with coherent return into the lost direction. The product bound is stable under mixing these channels and composing their mixtures. All qubit channels meet the stronger bounds, and the resulting count of two discarded singular values is optimal.

## 1. Question and scope

Caro and Graswald [1, Corollary 4.16] proved the necessary condition
$$
0\le\det T\le\prod_{j=1}^{k_0(d)}s_j^\uparrow(T),
\qquad k_0(d)=\left\lfloor2d-2\sqrt{2d}+1\right\rfloor,
\tag{1}
$$
for infinitesimal Markovian-divisible quantum channels. Their Remark 4.20 asks whether the product upper bound can actually be violated by a quantum channel. They explain why unital channels cannot provide such a violation and report that their search did not find one. We address that precise question by proving a stronger bound for all CPTP maps, including nonunital ones.

Throughout, $d\ge2$ is an integer. The matrix space $M_d(\mathbb C)$ carries the inner product $\langle X,Y\rangle=\operatorname{Tr}(X^*Y)$. The singular values are those of the resulting $d^2\times d^2$ superoperator matrix in an orthonormal basis. This convention is essential: arbitrary nonorthogonal changes of coordinates do not preserve these singular values.

We write $N=d^2$, list singular values in decreasing order as $\sigma_j$, and in increasing order as $s_j^\uparrow$. The Frobenius norm of a superoperator matrix is denoted by $\|T\|_F$. The Choi matrix is **unnormalized**, so $J(T)\succeq0$ and $\operatorname{Tr}J(T)=d$.

Theorem 1 covers the original factor count and every smaller positive count in every dimension. Sections 7–8 treat the stronger count $2d-2$, with exact results for a class with a rank-one defect and for all qubit channels. The corresponding full-channel question is open in higher dimensions.

## 2. Main theorem

**Theorem 1 (universal square-sum and product bounds).** Let $d\ge2$ and let $k\ge1$ be an integer such that
$$
\delta:=2d-k-1\ge2\sqrt{k}.
\tag{2}
$$
Set $q=d^2-k$. For every CPTP map $T:M_d(\mathbb C)\to M_d(\mathbb C)$,
$$
\sum_{j=1}^{q}\sigma_j(T)^2\le q,
\qquad
\prod_{j=1}^{q}\sigma_j(T)\le1,
\tag{3}
$$
and consequently
$$
|\det T|\le\prod_{j=1}^{k}s_j^\uparrow(T).
\tag{4}
$$
Equality in either inequality in (3) occurs if and only if $T(X)=UXU^*$ for a unitary $U$.

Condition (2), together with $k\ge1$, implies $k\le2d-3$. In particular $q>0$ and
$$
q\ge d^2-2d+3>(d-1)^2+1.
\tag{5}
$$
This strict difference will also establish the equality statement.

**Corollary 2 (the original product test is redundant).** With $k=k_0(d)$ from (1), inequality (4) holds for every CPTP map. Hence no channel with positive determinant violates the product upper bound in (1).

Indeed $k_0(d)=\lfloor(\sqrt{2d}-1)^2\rfloor\ge1$. Taking square roots of $k_0(d)\le(\sqrt{2d}-1)^2$ yields $\sqrt{k_0(d)}+1\le\sqrt{2d}$, which is (2). This uses the exact floor definition, without numerical rounding.

For orientation, the first few factor counts are:

| System dimension $d$ | Small factors $k_0(d)$ | Large factors $q=d^2-k_0(d)$ |
|:---:|:---:|:---:|
| 2 | 1 | 3 |
| 3 | 2 | 7 |
| 4 | 3 | 13 |
| 5 | 4 | 21 |
| 6 | 6 | 30 |
| 8 | 9 | 55 |

## 3. Two elementary estimates

### 3.1. Loss over distinct ordered pairs

**Lemma 3.** Let $e_1,\ldots,e_d\ge0$, let $\sum_i e_i=r\in[0,1]$, and let $\Omega\subseteq\{1,\ldots,d\}^2$ contain $k$ distinct ordered pairs. Then
$$
\sum_{(i,j)\in\Omega}(1-e_i)(1-e_j)
\ge k-(k+1)r+r^2=(1-r)(k-r).
\tag{6}
$$

**Proof.** If $r=0$, every $e_i$ vanishes. Otherwise put $p_i=e_i/r$, so that $p_i\in[0,1]$ and $\sum_i p_i=1$. Define
$$
A_\Omega=\sum_{(i,j)\in\Omega}(p_i+p_j),\qquad
B_\Omega=\sum_{(i,j)\in\Omega}(p_i+p_j-p_ip_j).
$$
The coefficient of any $p_i$ in $A_\Omega$ is at most $k+1$: each of the $k$ pairs contributes at most one occurrence, except that the single possible diagonal pair $(i,i)$ can contribute a second one. Therefore $A_\Omega\le k+1$. Also
$$
p_i+p_j-p_ip_j=1-(1-p_i)(1-p_j)\le1,
$$
so $B_\Omega\le k$. Both $r$ and $1-r$ are nonnegative, and the exact identity
$$
\sum_\Omega(e_i+e_j-e_ie_j)
=r\bigl((1-r)A_\Omega+r B_\Omega\bigr)
\le r(k+1-r)
$$
proves (6). Distinctness is used only in the coefficient bound and must not be dropped. $\square$

### 3.2. Perturbing the smallest singular values

For an $N\times N$ matrix $X$, set
$$
h_k(X)=\left(\sum_{j=1}^k s_j^\uparrow(X)^2\right)^{1/2}.
$$

**Lemma 4.** For matrices $A,B$ of the same size and $1\le k\le N$,
$$
h_k(A+B)\ge\max\{0,h_k(A)-\|B\|_F\}.
\tag{7}
$$
If $\langle A,B\rangle_F=0$ and $b:=\|B\|_F\le h_k(A)$, then
$$
\sum_{j=1}^{N-k}\sigma_j(A+B)^2
\le\|A\|_F^2-h_k(A)^2+2b h_k(A).
\tag{8}
$$

**Proof.** By the Frobenius low-rank approximation theorem [2],
$$
h_k(X)=\inf_{\operatorname{rank}R\le N-k}\|X-R\|_F.
$$
Distance to a fixed nonempty set is 1-Lipschitz. Applying the triangle inequality inside this infimum and using $h_k\ge0$ gives (7). Orthogonality gives $\|A+B\|_F^2=\|A\|_F^2+b^2$. Subtract the squared lower bound $(h_k(A)-b)^2$ for the bottom singular block to obtain (8). The positive part in (7) cannot in general be omitted before squaring. $\square$

## 4. Choi decomposition and proof of Theorem 1

### 4.1. The low-purity region

Let $\lambda=\lambda_{\max}(J(T))$. We first show that
$$
\lambda\le d-1\quad\Longrightarrow\quad
\operatorname{Tr}J(T)^2\le(d-1)^2+1.
\tag{9}
$$
If $\lambda\le1$, then every Choi eigenvalue $\lambda_a$ satisfies $\lambda_a^2\le\lambda_a$, whence their squared sum is at most $d\le(d-1)^2+1$. If $1\le\lambda\le d-1$, nonnegativity of the remaining eigenvalues gives
$$
\sum_a\lambda_a^2\le\lambda^2+(d-\lambda)^2.
$$
The difference between the last expression and $(d-1)^2+1$ is
$$
2(\lambda-1)(\lambda-d+1)\le0,
$$
which proves (9).

The Choi matrix and superoperator matrix differ by a reshuffling of entries, so their Frobenius norms agree. Thus
$$
\sum_{j=1}^{q}\sigma_j(T)^2
\le\|T\|_F^2=\operatorname{Tr}J(T)^2
\le(d-1)^2+1<q.
\tag{10}
$$
This region is completely settled, with a strict inequality.

### 4.2. The dominant Kraus operator

It remains to consider $\lambda>d-1$. Choose a spectral Kraus representation [3], ordered so that
$$
T(X)=\sum_{a\ge0}K_a X K_a^*,\qquad
\operatorname{Tr}(K_a^*K_b)=0\quad(a\ne b),
$$
and $\|K_0\|_F^2=\lambda=d-r$, where $0\le r<1$. The squared Kraus norms are precisely the nonzero eigenvalues of the unnormalized Choi matrix. If $r=0$, there is one Kraus operator, and trace preservation makes it unitary; all conclusions follow. Assume henceforth $0<r<1$.

As superoperators on Hilbert–Schmidt space, write
$$
A=\operatorname{Ad}_{K_0},\qquad
B=\sum_{a\ge1}\operatorname{Ad}_{K_a},\qquad T=A+B.
$$
For any matrices $K,L$, vectorization gives
$$
\langle\operatorname{Ad}_{K},\operatorname{Ad}_{L}\rangle_F
=|\operatorname{Tr}(K^*L)|^2.
$$
Consequently
$$
\langle A,B\rangle_F=0,\quad
\|A\|_F^2=(d-r)^2,\quad
b^2:=\|B\|_F^2=\sum_{a\ge1}\|K_a\|_F^4\le r^2.
\tag{11}
$$
The last inequality uses $\sum_{a\ge1}\|K_a\|_F^2=r$. An arbitrary Kraus representation need not give the orthogonality in (11); the spectral choice is essential.

Trace preservation implies $K_0^*K_0\preceq I$. Write its eigenvalues as $1-e_i$. Then $e_i\ge0$ and $\sum_i e_i=r$. The singular values of $A=K_0\otimes\overline{K_0}$, up to the chosen vectorization ordering, are the pairwise products of the singular values of $K_0$. Its squared singular values are therefore exactly
$$
\{(1-e_i)(1-e_j):1\le i,j\le d\}.
$$
Applying Lemma 3 to a set of positions attaining the $k$ smallest entries, including distinct positions at ties, gives
$$
S:=h_k(A)^2\ge S_0:=(1-r)(k-r)
=k-(k+1)r+r^2,\qquad 0\le S_0<k.
\tag{12}
$$

### 4.3. Small remainder

Suppose $r\le k/(k+1)$. Then $S_0\ge r^2$, so $h_k(A)\ge r\ge b$ and Lemma 4 applies. For $x\ge y\ge r^2$,
$$
(-x+2r\sqrt{x})-(-y+2r\sqrt{y})
=-(\sqrt{x}-\sqrt{y})(\sqrt{x}+\sqrt{y}-2r)\le0.
$$
Using this monotonicity, (11), and (12), we obtain
$$
\begin{aligned}
\sum_{j=1}^{q}\sigma_j(T)^2
&\le(d-r)^2-S+2r\sqrt S\\
&\le(d-r)^2-S_0+2r\sqrt{S_0}\\
&=q+r\bigl(k+1-2d+2\sqrt{S_0}\bigr)\\
&<q+r\bigl(k+1-2d+2\sqrt{k}\bigr)\le q.
\end{aligned}
\tag{13}
$$
The strict step uses $r>0$ and $S_0<k$. Thus even when (2) is an equality, every nonzero remainder gives a strict bound.

### 4.4. Large remainder

Suppose instead $r\ge t:=k/(k+1)$. Here no lower bound on the bottom singular block is needed. Since $d\ge2$ and $0\le t\le r<1$,
$$
(d-t)^2+t^2-\bigl((d-r)^2+r^2\bigr)
=2(r-t)(d-r-t)\ge0.
$$
Also, direct substitution yields
$$
(d-t)^2+t^2-(d^2-k)
=\frac{k\bigl(2k-(k+1)\delta\bigr)}{(k+1)^2}<0.
\tag{14}
$$
Indeed $\delta\ge2\sqrt{k}\ge2$, so $(k+1)\delta-2k\ge2$. We conclude
$$
\sum_{j=1}^{q}\sigma_j(T)^2
\le\|T\|_F^2=(d-r)^2+b^2
\le(d-r)^2+r^2<q.
\tag{15}
$$
The two regimes meet at $r=t$, where either valid argument can be used.

### 4.5. Product, determinant, and equality

The low-purity case and both remainder regimes prove the first inequality in (3). The only non-strict case is $r=0$, equivalently a rank-one Choi matrix. For square input and output dimensions, its single trace-preserving Kraus operator is unitary. Conversely, unitary conjugation has every singular value equal to 1.

As $q>0$, the arithmetic–geometric mean inequality gives
$$
\prod_{j=1}^{q}\sigma_j(T)^2
\le\left(\frac{1}{q}\sum_{j=1}^{q}\sigma_j(T)^2\right)^q\le1.
$$
Strictness for nonunitary channels proves the equality statement for the product. Finally multiply by the product of the remaining $k$ singular values and use $|\det T|=\prod_{j=1}^{N}\sigma_j(T)$. This proves (4) without dividing by a possibly zero number and completes the proof. $\square$

For a singular channel, both sides of (4) are zero because $k\ge1$. Thus the equality classification for (3) must not be transferred to (4) without an invertibility assumption. For an invertible nonunitary channel, (4) is strict.

## 5. Interpretation and limits

The answer to Remark 4.20 at its proved factor count is negative: a positive-determinant counterexample does not exist. The obstruction follows from complete positivity and trace preservation themselves. It does not follow from assuming a Lindblad evolution.

This does not invalidate Caro and Graswald's proof of their necessary condition. It identifies the reach of one part of that condition. Their determinant-sign requirement and their different bound involving a power of the single smallest singular value are separate tests; neither is shown redundant here. Their Conjecture 4.19 concerns a different generator estimate, and a result about it does not replace the present channel-level argument.

The threshold $q_*=(d-1)^2+1$, corresponding to $k=2d-2$, is outside Theorem 1. Numerical exploration of a stronger square-sum inequality at $q_*$ produced no counterexample in the recorded finite searches. That observation is exploratory. Sections 7–8 establish the stronger count for one-defect channels and for arbitrary qubit channels.

The main mechanism is the exact orthogonality in (11). Without it, the $b^2$ cancellation in Lemma 4 is lost. The ordered-pair estimate then links the trace budget of the residual Kraus operators to the smallest singular block of the dominant one. The same constant $k+1+2\sqrt{k}$ that appears in the admissibility condition emerges from this finite-channel perturbation argument.

## 6. Verification and provenance

The mathematical argument above is an analytic proof. The accompanying programs separately check the ordered-pair inequality with exact rational arithmetic, the scalar identities, the spectral-Kraus decomposition, and the two perturbation regimes on finite samples. Their finite coverage does not establish the general theorem.

Sections 7–8 establish the strengthened claims analytically. The original manuscript reports local Lean verification of selected scalar inequalities; full formalization is incomplete. The computational programs, raw outputs and Lean source are not included in this edition.

## 7. Exact spectrum for one-level damping to an orthogonal mixed target

Take $d\ge2$, $0<\gamma<1$, $b=1-\gamma$, and let $\rho$ be any density matrix supported on the orthogonal complement of the designated level $|d\rangle$. Put $K=I_{d-1}\oplus\sqrt b$ and
$$
 T(X)=KXK^*+\gamma X_{dd}\rho.
$$
This is CPTP: diagonalize $\rho=\sum_j p_j|u_j\rangle\langle u_j|$ and use jump Kraus operators $\sqrt{\gamma p_j}|u_j\rangle\langle d|$. For $q_*=(d-1)^2+1$, the sum of the largest $q_*$ squared singular values is strictly below $q_*$. In particular their singular-value product is below one by arithmetic–geometric mean, so the determinant bound with $2d-2$ discarded factors holds. The product of the largest $q_*-1$ is strictly above one, so this loss count already fails for the determinant formulation on invertible channels.

Indeed the block on $\rho/\|\rho\|_2$ and $|d\rangle\langle d|$ is $A=\left(\begin{smallmatrix}1&\gamma\|\rho\|_2\\0&b\end{smallmatrix}\right)$. The other singular values consist of $(d-1)^2-1$ ones and $2(d-1)$ copies of $\sqrt b$. If $\lambda_+$ is the larger eigenvalue of $A^*A$, then $\lambda_+>1$ from the nonzero off-diagonal coupling and the Rayleigh quotient at the first basis vector. The other eigenvalue $b^2/\lambda_+$ lies below $b$. The characteristic polynomial at $1+\gamma$ is
$$
 \gamma^2[3-\gamma-(1+\gamma)\|\rho\|_2^2]>0
$$
because $\|\rho\|_2^2\le1$ and $0<\gamma<1$. Thus $\lambda_+<1+\gamma$ and the largest $q_*$ squared singular values sum to $\lambda_++(d-1)^2-1+b<q_*$. The first $q_*-1$ singular values have product $\sqrt{\lambda_+}>1$, and positivity of $b$ guarantees invertibility. The trace of $A^*A$ increases and its determinant remains fixed as $\|\rho\|_2^2$ increases; hence the larger eigenvalue is maximized by a pure target. The obstruction for a pure target was known, as discussed below.

## 8. Coherent targets and the sharp all-qubit count

For a CPTP map on $M_d$, use Hilbert–Schmidt singular values $\sigma_1\ge\cdots\ge\sigma_{d^2}$. Keep $q_*=(d-1)^2+1$ from §7. If a Kraus representation has an operator $K$ with ${\mathrm{rank}}(I-K^*K)\le1$, then
$$
 \sum_{j\le q_*}\sigma_j^2\le q_*,\qquad \prod_{j\le q_*}\sigma_j\le1 .
$$
The square-sum bound persists under convex mixtures of arbitrary channels from this class. The product bound persists under arbitrary finite compositions of such mixtures and closure. This permits arbitrarily many successive losses with different and nonorthogonal source and target supports. **In dimension two the square-sum and product statements hold for every CPTP channel.** The count of two discarded factors there is optimal, including among invertible channels. In all dimensions the same optimality holds for the whole single-defect class.

### 8.1. The three-dimensional coherent-target block

Unitarily changing input and output coordinates, take $K=I_g\oplus\sqrt b$, $g=d-1,\ 0\le b\le1,\ \gamma=1-b$. Trace preservation forces every other Kraus operator to annihilate the ground subspace: its squared norm at a ground vector is one term of a sum of nonnegative terms equal to zero. Therefore the channel is $T(X)=KXK^*+\gamma X_{dd}\rho$, where $\rho$ is an arbitrary density matrix on the full output space. The case $\gamma=0$ is immediate. Set $z=\rho_{dd}$, $u=\|\rho_{gg}\|_2$ and $v=\|\rho_{gd}+\rho_{dg}\|_2$, using the ground and cross blocks embedded with zero padding. Then $u\le1-z,\ v^2\le2z(1-z)$. The second inequality follows by summing the $2\times2$ principal minor inequalities in a basis diagonalizing the ground block. Put $c=b+\gamma z$. Along orthonormal directions of the two blocks of $\rho$, completed arbitrarily when a block vanishes, and the excited diagonal, the superoperator is
$$
 G=\begin{pmatrix}1&0&\gamma u\\0&\sqrt b&\gamma v\\0&0&c\end{pmatrix}.
$$
The other singular values are $g^2-1$ copies of one and $2g-1$ copies of $\sqrt b$. Interlacing the first two coordinates of $G^*G$ gives $\lambda_1\ge1\ge\lambda_2\ge b\ge\lambda_3$ for its ordered eigenvalues. Thus the required sum is $g^2-1+\lambda_1+\lambda_2$.

We prove $\lambda_1+\lambda_2\le2$. Using ${\mathrm{Tr}}(\rho^2)\le1$ gives
$$
 {\mathrm{Tr}}(G^*G)-2\le b(2c-1)=:\tau.
$$
Indeed $u^2+v^2\le1-z^2$ and expanding $1+b+c^2+\gamma^2(1-z^2)-2$ gives $\tau$. It suffices to prove $G^*G\succeq \tau I$. The case $\tau\le0$ follows immediately. By continuity assume $0<b<1,\ c<1$, so $1-\tau,b-\tau>0$. The Schur complement of the first two diagonals is
$$
 c^2-\tau-\frac{\tau\gamma^2u^2}{1-\tau}-\frac{\tau\gamma^2 v^2}{b-\tau}.
$$
Use $\gamma^2u^2\le(1-c)^2,\ \gamma^2v^2\le2(c-b)(1-c)$ and $b-\tau=2b(1-c)$. The resulting lower bound is
$$
 c^2-\tau-\frac{\tau(1-c)^2}{1-\tau}-\frac{\tau(c-b)}b
 =\frac{(1-c)(c-\tau)}{1-\tau}\ge0,
$$
since $\tau=b(2c-1)\le c$. This proves the square-sum result including all boundary cases. AM–GM gives the product. The sum of the largest $q_*$ squared singular values is the maximum over rank-$q_*$ projections $P$ of $\|TP\|_F^2$, a convex function. The product of the largest $q_*$ singular values is the norm of $\bigwedge^{q_*} T$, hence submultiplicative and continuous. These facts yield the stated extensions. An ordinary composition need not inherit the square-sum conclusion from submultiplicativity.

### 8.2. Every qubit channel

The finite-dimensional compact convex set of channels is the convex hull of its extreme points. An extreme qubit channel has Kraus rank at most two: if the support of its Choi matrix has rank $r>2$, Hermitian matrices supported there span $r^2>4$ real dimensions, whereas trace preservation imposes only four real linear constraints. A nonzero supported perturbation with zero prescribed partial trace remains positive under sufficiently small perturbations in either sign. This contradicts extremality. For rank two, two independent Kraus operators span a complex matrix pencil containing a rank-one matrix: the homogeneous quadratic determinant has a projective zero (or is identically zero), and linear independence excludes the zero matrix there. Normalize its two coefficients and complete to a unitary rotation of the Kraus pair. Its other member now has rank-one defect by trace preservation. Rank one is a unitary conjugation. Convexity completes the proof. This also directly covers channels with no distinguished physical damping basis.

### 8.3. Optimality

In every $d\ge2$, take $0<b<1$ and a pure ground target. Here $u=1,v=z=0$. The $2\times2$ block on ground and excited diagonals has first column of length one with nonzero overlap with its second column. Consequently $\lambda_1>1$; the largest $g^2$ singular values consist of $\sqrt{\lambda_1}$ and $g^2-1$ ones. Their product is greater than one and $T$ is invertible. This is the previously known amplitude-loss obstruction. Together with the new universal qubit upper bound it identifies the optimal count there. Equality at the critical count need not characterize unitary channels, as excited-level dephasing ($\rho=|d\rangle\langle d|$) shows.

## 9. Relation to existing singular-value tests

Caro–Graswald Corollary 4.16 gives the original discarded count $k_0(d)$, and Remark 4.20 asks for the range of this product test for general channels. Their Lemma 4.1 already uses closure of singular-value product inequalities under composition. Example 4.17 establishes the amplitude-loss obstruction past the count $2d-2$. Their Theorem 3.6 treats the Lorentz normal form and the spectrum of its block $\Delta$. The Hilbert–Schmidt singular values used here refer to the original superoperator in orthonormal coordinates. Ruskai–Szarek–Werner already establish structural descriptions of extreme qubit channels and, in Theorem 14, a two-term convex decomposition into their closure. The addition here is the coherent-target squared-singular-value estimate and its use with extreme qubit channels to prove the optimal retained count at $d=2$. [Caro–Graswald, Theorem 3.6 and §4](https://arxiv.org/pdf/2009.06666) · [Ruskai–Szarek–Werner, Theorem 14](https://arxiv.org/pdf/quant-ph/0101003)

For $d\ge3$, the largest universal admissible discarded count for general CPTP channels remains open between $k_0(d)$ and $2d-2$. The determinant-sign condition in the divisibility criterion and the generator inequality in Conjecture 4.19 address different questions.

## References

1. M. C. Caro and B. R. Graswald. *Necessary Criteria for Markovian Divisibility of Linear Maps*. Journal of Mathematical Physics **62**, 042203 (2021). DOI: [10.1063/5.0031760](https://doi.org/10.1063/5.0031760). Author version: [arXiv:2009.06666v3](https://arxiv.org/abs/2009.06666v3), 30 October 2022; Corollary 4.16 and Remark 4.20.
2. C. Eckart and G. Young. *The approximation of one matrix by another of lower rank*. Psychometrika **1**, 211–218 (1936). DOI: [10.1007/BF02288367](https://doi.org/10.1007/BF02288367). Used only for the Frobenius low-rank approximation characterization, whose distance consequence is proved in Lemma 4.
3. M. M. Wolf. *Quantum Channels & Operations: A Guided Tour* (2012), Sections 2.1–2.3: Proposition 2.1, Theorem 2.1, and equations (2.21)–(2.22). [Author's notes](https://mediatum.ub.tum.de/doc/1701036/1701036.pdf.Show). Used for the standard Choi/Kraus correspondence and reshuffling conventions; the needed identities are displayed in Section 4.
4. M. M. Wolf and Y. Zhou. *Ky Fan majorization for binary tensor products*. [arXiv:2607.27116v1](https://arxiv.org/abs/2607.27116v1) (2026). Related work; not required by the proof.
5. R. Ibarrondo and M. Sanz. *Contraction and Expansion Values of Quantum Channels*. [arXiv:2607.04950v1](https://arxiv.org/abs/2607.04950v1) (2026). Related work; not required by the proof.
6. M. B. Ruskai, S. Szarek, and E. Werner. *An analysis of completely-positive trace-preserving maps on $M_2$*. Linear Algebra and its Applications **347**, 159–187 (2002), especially Theorem 14. [arXiv:quant-ph/0101003](https://arxiv.org/abs/quant-ph/0101003).
