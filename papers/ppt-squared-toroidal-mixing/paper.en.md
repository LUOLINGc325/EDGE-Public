# When pinching makes a Schur channel mixed unitary

*An exact SIC threshold and stronger certificates for PPT channel compositions*

## Abstract

A Schur channel multiplies the entries of a density matrix by a complex correlation matrix. We determine exactly how much complete dephasing makes a Schur channel built from a symmetric informationally complete measurement a mixture of diagonal unitaries. If the underlying measurement has dimension $r\ge2$, the least fraction of complete dephasing is $(1+\sqrt{r+1})^{-2}$. At this boundary the phase correlations form an exposed simplex, and the channel has a unique distribution on its $r^2$ unitary conjugations. A separate construction for arbitrary correlation matrices improves the finite-rank mixing bound of Kribs, Levick, Pereira and Rahaman. Its universal denominator grows at most logarithmically with matrix size $d$. In dimension four a two-vector construction reduces the previous denominator from $2$ to $1+1/\sqrt3$. Applied to diagonal orthogonal covariant channels, these bounds improve a recent sufficient criterion for an entanglement-breaking composition. We construct a one-parameter family of positive-partial-transpose channels in dimension four such that every nontrivial member preserves some entanglement and every ordered composition within the family breaks entanglement. The unrestricted PPT-squared conjecture remains open.

## 1. Phases and pinching

A complex correlation matrix has unit diagonal and is positive semidefinite. For such an $R\in M_d(\mathbb C)$, the Schur channel acts by $\Phi_R(X)=R\odot X$, where $\odot$ is entrywise multiplication. Complete dephasing in the distinguished basis is $\Phi_I$. A phase vector is a vector $z$ whose entries have absolute value one. Write
$$
\mathcal T_d=\operatorname{conv}\{zz^*:z\in\mathbb C^d,\ |z_i|=1\},\qquad
R(t)=(1-t)I+tR,\qquad 0\le t\le1.                                      \tag{1}
$$
The notation $\mathcal T_d$ refers to the set of *toroidal* correlations. The channel $\Phi_R$ is mixed unitary exactly when $R\in\mathcal T_d$. One direction follows by using diagonal unitaries with diagonals $z$. In the other direction $\Phi_R(E_{ii})=E_{ii}$ implies that every unitary with positive weight in a representation maps the $i$th basis line into itself. Thus every such unitary is diagonal. The phase matrices form a compact set, so their convex hull is compact in finite dimension and includes averages over arbitrary distributions.

Kribs et al. [1, Corollary 34, Remark 35] proved that $R(1/r)$ is toroidal for rank-$r$ correlations, gave $1/\lfloor\sqrt d\rfloor$ uniformly in $R$, and suggested the small-dimensional complex bound could be improved. In the PPT-squared problem, Márquez González [2] used this result to give a population-mixing criterion for two channels. For general channels covariant under diagonal sign changes, dimension four is the first unresolved deterministic case. We examine the phase-mixing constant itself and its implications for this composition test.

## 2. The exact threshold for a SIC

A symmetric informationally complete measurement, abbreviated SIC, in dimension $r$ consists of $n=r^2$ unit vectors $v_i\in\mathbb C^r$ such that $\sum_i v_iv_i^*=rI_r$ and $|\langle v_i,v_j\rangle|^2=1/(r+1)$ for $i\ne j$. The measurement effects are $v_iv_i^*/r$. Let $V$ have these vectors as columns and set $R=V^*V$. The physical Schur channel here acts on $M_{r^2}$, while its defining SIC lives in $\mathbb C^r$. McNulty, Townsend and Kiukas call these SIC-extremal dephasing channels and study their measurement compatibility [9]. The result below is conditional on the existence of a SIC in the chosen dimension.

**Theorem 1.** Put $g=\sqrt{r+1}$ and $W=gR+(1-g)I_n$. Denote its columns by $w_j$. Then
$$
R(t)\in\mathcal T_n\quad\Longleftrightarrow\quad
t\le t_*:=1-\frac{1}{(1+\sqrt{r+1})^2}.                               \tag{2}
$$
At the endpoint,
$$
R(t_*)=\frac1n\sum_{j=1}^n w_jw_j^*.                                    \tag{3}
$$
The exposed face on which $X\mapsto\operatorname{Tr}(RX)$ attains its maximum is precisely the simplex with vertices $w_jw_j^*$. Hence the $n$ equal weights in (3) are necessary, after merging identical conjugations and ignoring global phases. In particular, the boundary channel has mixed-unitary rank $n$.

**Attainment.** $R^2=rR$ and all entries of $W$ have modulus one. Squaring $W$ and dividing by $n$ gives an affine combination of $I_n$ and $R$ with unit diagonal. Its coefficient of $I_n$ is $(g-1)^2/r^2=1/(g+1)^2$. This proves (3). The identity is toroidal by taking independent unbiased signs. Convexity now includes every $t\le t_*$ in (1).

**Witness.** For every unit vector $u$ in the measurement space set $x_i=|\langle v_i,u\rangle|^2$. Then
$$
\sum_i x_i=r,\qquad \sum_i x_i^2=\frac{2r}{r+1}.                       \tag{4}
$$
For the second identity, the traceless Hermitian operators $Q_i=v_iv_i^*-I_r/r$ have a Gram matrix with diagonal $(r-1)/r$ and off-diagonal $-1/[r(r+1)]$. Its restriction to the orthogonal complement of the all-ones vector is $r/(r+1)$ times the identity. Its rank is $r^2-1$, the dimension of the real space of traceless Hermitian matrices. Thus $\sum_i|\operatorname{Tr}(Q_iH)|^2=r\operatorname{Tr}(H^2)/(r+1)$ there. Take $H=uu^*-I_r/r$ and expand. This recovers the usual SIC second-design identity [3].

The maximum of $\sum_i\sqrt{x_i}$ is the order-$1/2$ Rényi-entropy extremum of Szymusiak [4, Theorem 2 and Remark 2], up to normalization and a monotone transformation. We include a short proof to track equality. Write $h=1/\sqrt{r+1}$ and define the quadratic polynomial
$$
P(t)=\frac{-t^2+(3h^2+2h+1)t+h^2(1+2h)}{2h(1+h)^2}.
$$
For $0\le y\le1$,
$$
P(y^2)-y=\frac{(y-h)^2(1-y)(y+1+2h)}{2h(1+h)^2}\ge0.                  \tag{5}
$$
Equations (4) make $\sum_iP(x_i)$ independent of $u$. For $u=v_j$ the overlaps have one entry $1$ and $n-1$ entries $h^2$, all equality cases of (5). Consequently
$$
\max_{\|u\|=1}\sum_i|\langle v_i,u\rangle|
=1+(n-1)h=1+(r-1)\sqrt{r+1}.                                           \tag{6}
$$
Equality in (5) and $\sum_i x_i=r$ force exactly one overlap to be $1$ and the rest to be $h^2$. Thus the maximizing $u$ are precisely the SIC vectors up to phase.

For phase vectors $z$, maximizing $\|Vz\|$ first in the direction of a unit vector $u$, then over coordinate phases, gives
$$
\max_z z^*Rz=\left[\max_{\|u\|=1}\sum_i|\langle v_i,u\rangle|\right]^2. \tag{7}
$$
All overlaps at a maximizing $u=v_j$ are nonzero. Equality in the triangle inequality then forces $z$ to agree with $w_j$ up to one global phase. Thus the witness is maximized exactly at the listed phase matrices. Their uniform average (3) saturates it. Meanwhile $\operatorname{Tr}(RR(t))=n[1+(r-1)t]$ increases strictly in $t$. Every $t>t_*$ exceeds the maximum of the witness on $\mathcal T_n$.

Finally $W$ has eigenvalues $1+(r-1)g$ and $1-g$, both nonzero. A linear relation among the $w_jw_j^*$ can be written $W\operatorname{diag}(c)W^*=0$, so all coefficients vanish. Their convex hull is a simplex, and its barycentric coordinates at (3) are unique. This proves the theorem.

For $r=2$ the threshold is $t_*=\sqrt3/2$. Its support inequality is already present as a four-coordinate complex-cut inequality in Jarre et al. [5] and Sinjorgo et al. [6, Eq. (57), Lemma 12]. Indeed their Hermitian matrix $H$ has zero diagonal, phase entries off the diagonal and $H^2=3I$. Thus $I+H/\sqrt3$ is a qubit SIC Gram, and their inequality $\operatorname{Tr}(HX)\le6$ gives exactly the necessary ratio in this case. For $r=3$ the boundary is $t_*=8/9$. The statement and decomposition in (2)–(3) apply to every existing SIC, independently of its symmetry group.

## 3. A uniform finite-rank bound

For integers $d,r$ with $1\le r\le d$, put
$$
b(d,1)=1,\qquad b(d,r)=r-(r-1)d^{-1/(r-1)}\quad(r\ge2).                \tag{8}
$$

**Theorem 2.** For a $d$-dimensional correlation matrix $R$ of rank $r$, put $s=\min(r,\lfloor\sqrt d\rfloor)$. The matrix $R(1/b(d,s))$ is toroidal. For $s\ge2$ this denominator is strictly smaller than $s$ for each finite $d$ and bounded by $1+\log d$. In dimension four every correlation matrix also satisfies
$$
R\!\left(\frac{1}{1+1/\sqrt3}\right)\in\mathcal T_4.                  \tag{9}
$$
We give upper bounds on the required denominator. The optimal universal dimension-four constant is not determined here.

**Normalization and phase rounding.** The polydisc completion used here is [1, Corollary 33]. Given any $y$ with $|y_i|\le1$, choose independent random unit phases $z_i$ with means $y_i$. For instance two antipodal phases with suitable probabilities have any prescribed mean in the unit disc. The off-diagonal entries of $\mathbb E zz^*$ are $y_i\overline{y_j}$ and the diagonal is one.

More generally let $X$ be a random vector with $\mathbb E XX^*=R$. Write $M=\max_i|X_i|^2$ and $m=\mathbb E M<\infty$. Then $m\ge1$. Sample $X$ with probability reweighted by $M/m$, and apply the preceding rounding to $X/\sqrt M$. Values where $M=0$ have zero reweighted probability. The resulting average has off-diagonal entries $R_{ij}/m$ and diagonal one. Thus $R(1/m)\in\mathcal T_d$. Any larger denominator works by mixing with $I$. This reweighting preserves each off-diagonal entry simultaneously.

Let $R=V^*V$ for unit columns in $\mathbb C^r$. Take $X=\sqrt r\,V^*U$ with $U$ uniform on the complex unit sphere. Isotropy gives the desired covariance. For $r\ge2$, $|\langle v_i,U\rangle|^2$ has tail $(1-x)^{r-1}$ on $0\le x\le1$. To verify it, normalize a vector of independent standard complex Gaussians. The squared moduli before normalization are independent exponential random variables of mean one. Conditioning on the sum of the last $r-1$ gives the stated tail of the first normalized coordinate. A union bound and integration yield
$$
m\le r\int_0^1\min\{1,d(1-x)^{r-1}\}\,dx
 = r-(r-1)d^{-1/(r-1)}.                                                \tag{10}
$$
Split the integral at $1-d^{-1/(r-1)}$. The function $1+v(1-e^{-(\log d)/v})$, $v=r-1>0$, is nondecreasing in $v$ by $1+y\le e^y$. It is bounded above by $1+\log d$ because $1-e^{-y}\le y$. Rank one needs no dilution.

For completeness, an extreme correlation matrix of rank $k$ must have $k^2\le d$. Otherwise there is a nonzero Hermitian $H\in M_k$ annihilated by all $d$ real linear evaluations $H\mapsto v_i^*Hv_i$. Small positive and negative multiples of $H$ perturb the middle identity in $V^*IV$, preserving positivity and unit diagonal. The two perturbed matrices differ since $V$ has full row rank. A finite-dimensional compact convex set is the convex hull of its extreme points. Moreover, in any positive-weight decomposition of $R$ into positive matrices, each summand vanishes on $\ker R$. Thus the ranks in an extreme decomposition of $R$ are at most $\min(r,\lfloor\sqrt d\rfloor)$. Apply the same weakened denominator to each term before averaging.

**Four coordinates.** It suffices to handle rank two. Write the four unit-state projectors as $(I+b_i\cdot\sigma)/2$ with $b_i$ unit vectors in $\mathbb R^3$ and $\sigma$ the Pauli matrices. For each of the three partitions $ab|cd$ of the four indices into two pairs, form $v_{ab|cd}=(b_a+b_b-b_c-b_d)/2$. Orthogonality of the four rows of the normalized Hadamard matrix gives
$$
\sum_{ab|cd}\|v_{ab|cd}\|^2=4-\frac14\left\|\sum_i b_i\right\|^2\le4.
$$
Select a partition with $\|v_{ab|cd}\|\le2/\sqrt3$, and a unit vector $N$ orthogonal to both $b_a-b_b$ and $b_c-b_d$. Projecting the four vectors on $N$ gives two pair values whose distance is
$$
\max_i N\cdot b_i-\min_i N\cdot b_i=|N\cdot v_{ab|cd}|\le2/\sqrt3.
$$
The two opposite Bloch states with vectors $N,-N$ form an orthonormal basis of $\mathbb C^2$. Use their uniform distribution for $U$ in $X=\sqrt2V^*U$; it is isotropic. Now $m=1+(\max_iN\cdot b_i-\min_iN\cdot b_i)/2\le1+1/\sqrt3$. The phase rounding proves (9). For comparison (10) alone gives $7/4$.

The logarithmic order has antecedents in indefinite quadratic rounding. Huang and Zhang [7] compare a zero-trace Hermitian semidefinite relaxation with optimization over unit roots. The stronger assertion needed for the application is the explicit finite-rank inclusion (8) and the four-coordinate construction (9). We do not claim a new logarithmic order.

## 4. Two PPT channels in succession

A channel $\Phi$ is diagonal orthogonal covariant (DOC) if conjugating its input by any diagonal sign matrix conjugates its output by the same matrix. Such a map is represented by three matrices with a common diagonal,
$$
\Phi_{A,B,C}(X)=\operatorname{Diag}(A\operatorname{diag}X)
+\widetilde B\odot X+\widetilde C\odot X^{\mathsf T},
$$
where tildes erase the diagonal. It is trace preserving when $A$ is column stochastic. The Choi matrix has positive partial transpose (PPT) exactly when $A$ is entrywise nonnegative, $B,C$ are positive semidefinite, and $A_{ij}A_{ji}\ge\max(|B_{ij}|^2,|C_{ij}|^2)$ [8]. Entanglement breaking means the channel produces a separable state when applied to one part of every input. In this representation it is equivalent to triplewise complete positivity (TCP). A TCP atom consists of
$$
(|x|^2|y|^{2\mathsf T},\ (x\odot y)(x\odot y)^*,\
(x\odot\bar y)(x\odot\bar y)^*),
$$
and a TCP triple is a sum of such atoms. Squares and moduli of vectors are taken coordinatewise.

For the composition $\Phi_{A,B,C}\circ\Phi_{D,E,F}$ the population matrix is $G=AD$. Its off-diagonal coherences are the corresponding entries of
$$
H=B\odot E+C\odot F^{\mathsf T},\qquad
K=B\odot F+C\odot E^{\mathsf T}.                                       \tag{11}
$$
Its actual common diagonal is $\operatorname{diag}G$. The Schur product theorem makes $H,K$ positive semidefinite with common diagonal $q_i^2=2A_{ii}D_{ii}$. On $J=\{i:q_i>0\}$ write $R_{ij}=H_{ij}/(q_iq_j)$ and $S_{ij}=K_{ij}/(q_iq_j)$; zero diagonal entries force the omitted rows to vanish.

**Theorem 3.** Suppose both $R(1/\kappa)$ and $S(1/\kappa)$ are toroidal on $J$, for some $\kappa\ge1$. If positive numbers $g_i$ satisfy
$$
G_{ij}\ \ge\ \kappa q_iq_j\,g_i/g_j\qquad(i,j\in J),                   \tag{12}
$$
the composition is EB. Empty $J$ is always EB. In size four, with $g_i=1$, (9) gives the population coefficient $2+2/\sqrt3$ multiplying $\sqrt{A_{ii}A_{jj}D_{ii}D_{jj}}$. The earlier size-four test [2] uses $4$. In any size one may use (8) for each correlation on its nonzero support, taking the larger denominator.

**Proof.** The two-toroidal-core construction and classical residual are from [2, Lemmas 1–2]. For clarity, if $U,V$ are toroidal and $p\ge0$, the triple $(pp^{\mathsf T},D_pUD_p,D_pVD_p)$ is TCP. Choose independent phase vectors $e^{i\theta_i},e^{i\phi_i}$ realizing $U,V$, and take $x_i=\sqrt{p_i}e^{i(\theta_i+\phi_i)/2}$, $y_i=\sqrt{p_i}e^{i(\theta_i-\phi_i)/2}$. Average their atoms. The further change $x_i\mapsto\sqrt{g_i}\,x_i$, $y_i\mapsto y_i/\sqrt{g_i}$ changes only the population entry $(i,j)$ by the factor $g_i/g_j$. With $p_i=\sqrt\kappa\,q_i$, extend zeros outside $J$. This core reproduces (11) off the diagonal. The residual population matrix $L$ is entrywise nonnegative by (12); $(L,\operatorname{Diag}(\operatorname{diag}L),\operatorname{Diag}(\operatorname{diag}L))$ is TCP by atoms supported on individual ordered index pairs. Adding the two triples restores all entries of the composite.

**A family with pairwise EB composition.** For $a\ge1$ let $M_a$ be the four-by-four matrix of ones except $(M_a)_{12}=a$, $(M_a)_{21}=a^{-1}$. Write $s_j^a$ for its column sums and $T_a=\operatorname{diag}((s_j^a)^{-1/2})$. Fix a qubit SIC Gram $Z$, and write $\mathbf J$ for the all-ones matrix. Define
$$
A_a=M_aT_a^2,\qquad B_a=T_a\mathbf JT_a,\qquad C_a=T_a ZT_a.           \tag{13}
$$
Every map is trace preserving and PPT: all reciprocal off-diagonal products of $M_a$ are one, and correlation entries have modulus at most one.

For $a>1$ the channel is not EB. Otherwise the first two components would admit the corresponding pair of TCP factorizations. Undo the column normalization by rescaling the entries of each $y$ by $(s_i^a)^{1/2}$. This gives a pair of sums realizing $(M_a,\mathbf J)$. In the second sum each nonzero $x\odot y$ is a multiple $\gamma$ of the all-ones vector, since the resulting matrix has rank one. For these terms put $\lambda=|\gamma|^2$ and $t_i=|x_i|^2$. Then $\sum\lambda=1$, all $t_i>0$, and $M_{ij}\ge\sum\lambda t_i/t_j$. Weighted arithmetic–geometric mean, multiplied around any directed cycle, implies $\prod M_{ij}\ge1$. The cycle $2\to1\to3\to2$ instead has product $1/a$.

For any ordered pair $a,b\ge1$ the normalized correlations of (11) are
$$
R=\tfrac12(\mathbf J+Z\odot\bar Z)=\tfrac23\mathbf J+\tfrac13 I,
\qquad S=Z.
$$
The first is toroidal, and Theorem 1 gives the common denominator $\kappa=2/\sqrt3$. Use $g_i=\sqrt{s_i^b/s_i^a}$. The population ratio in (12), before the coefficient $2\kappa$, is
$$
L_{ij}=s_i^a s_j^b(A_aA_b)_{ij}
=s_i^a\sum_k (M_a)_{ik}(M_b)_{kj}/s_k^a.
$$
All entries of row one of $M_b$ are at least one. Keeping $k=1,3,4$ gives
$$
L_{ij}\ge s_i^a\left((M_a)_{i1}/s_1^a+\tfrac12\right).
$$
For $i=1$ this is at least $5/2$. For $i=3,4$ it is at least $3$. For $i=2$ it equals $3+3(a-1)^2/[2(3a+1)]\ge3$. Since $5/2>4/\sqrt3=2\kappa$, the composition is EB for every $a,b\ge1$.

The population improvement has two distinct checks. At $a=b=6/5$ the minimum of $(A_a^2)_{ij}/[(A_a)_{ii}(A_a)_{jj}]$ is $965/252$, between $7/2$ and $4$. The normalized $S$ is a rank-two non-toroidal SIC Gram, so the earlier rank refinement [2, Corollary 2] still has denominator two. The new uniform four-dimensional certificate applies. At $a=b\to\infty$ the diagonal ratio for $(1,1)$ tends to $5/2$, below $2+2/\sqrt3$. A diagonal gauge cannot change that entry. This explains why the explicit SIC boundary provides information beyond the new universal sufficient coefficient.

## 5. Scope and sources

The target characterization of SIC measurement uncertainty, the four-coordinate cut, and logarithmic-order indefinite quadratic rounding have independent precedents. Our statements combine a finite-rank phase-mixture construction, a sharper four-coordinate universal denominator, an exact conversion threshold and exposed face for all SIC Gram matrices, and deterministic composition certificates. The thresholds in Theorem 1 concern mixed-unitary Schur channels. Condition (12) proves entanglement breaking for a structured population region and is sufficient. A general answer for arbitrary pairs of four-dimensional PPT DOC channels would require additional arguments.

[1] D. W. Kribs, J. Levick, R. Pereira and M. Rahaman, *Operator algebra generalization of a theorem of Watrous and mixed unitary quantum channels*, J. Phys. A (2024). Corollaries 33–34 and Remark 35. [Article](https://doi.org/10.1088/1751-8121/ad2cb0).

[2] S. A. Márquez González, *Toroidal-Core Certificates for PPT-Squared Diagonal Orthogonal Covariant Channels* (2026). Sections II–V. [Preprint](https://arxiv.org/abs/2609.32979).

[3] J. M. Renes, R. Blume-Kohout, A. J. Scott and C. M. Caves, *Symmetric informationally complete quantum measurements*, J. Math. Phys. 45 (2004), 2171–2180. [Article](https://doi.org/10.1063/1.1737053).

[4] A. Szymusiak, *Pure states of maximum uncertainty with respect to a given POVM*, Open Systems & Information Dynamics (2020). Theorem 2 and Remark 2. [Preprint](https://arxiv.org/abs/1701.01139).

[5] F. Jarre, F. Lieder, Y.-F. Liu and C. Lu, *Set-completely-positive representations and cuts for the max-cut polytope and the unit modulus lifting*, J. Global Optim. 76 (2020), 913–932. [Article](https://doi.org/10.1007/s10898-019-00813-x).

[6] L. Sinjorgo, R. Sotirov and M. F. Anjos, *Cuts and semidefinite liftings for the complex cut polytope*, Math. Program. (2024, online). Equation (57) and Lemma 12. [Article](https://doi.org/10.1007/s10107-024-02147-3).

[7] Y. Huang, S. Zhang, *Approximation algorithms for indefinite complex quadratic maximization problems*. [Technical report](https://optimization-online.org/2005/07/1178/). See also N. Alon, K. Makarychev, Y. Makarychev and A. Naor, *Quadratic forms on graphs*, Invent. Math. 163 (2006), 499–522. [Article](https://web.math.princeton.edu/~naor/homepage%20files/AM%5E2N.pdf).

[8] S. Singh and I. Nechita, *Diagonal unitary and orthogonal symmetries in quantum theory*, Quantum 5 (2021), 519. [Article](https://doi.org/10.22331/q-2021-08-09-519).

[9] D. McNulty, W. Townsend and J. Kiukas, *Characterising extremal decoherence by quantum measurement incompatibility* (2026). Proposition 5 identifies SIC-extremal Schur channels. Appendix D uses a different robustness quantity by varying the noise channel and fixing the completely dephased endpoint. [Preprint](https://arxiv.org/abs/2607.21169).
