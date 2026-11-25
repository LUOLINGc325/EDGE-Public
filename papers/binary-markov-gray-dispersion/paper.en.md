# Operational dispersion of binary Markov sources inside the Gray region

## A polynomial distortion-ball bound from a strict binary noise margin

**Research manuscript, 25 November 2026.** Written proof and reproducible checks are supplied. External peer review has not occurred. This manuscript is not represented as fully kernel certified; the Lean source is not included in this version.

### Abstract

We prove the fixed-length, excess-Hamming-distortion normal approximation for a stationary symmetric binary Markov source throughout the strict interior of its classical low-distortion region. If the transition probability is $0<p<1/2$, the distortion satisfies $0<D<D_c(p)$, and the excess probability $0<\epsilon<1$ is fixed, the optimal code size obeys

$$
\log_2 M_n^*=n[h_2(p)-h_2(D)]
+\sqrt{n\nu(p)}\,\mathsf Q^{-1}(\epsilon)+O(\log n),
\qquad
\nu(p)=p(1-p)\left[\log_2\frac{1-p}{p}\right]^2.
$$

The known entropy-density converse therefore has a matching operational upper bound in this regime. The new ingredient is a finite-dimensional probability estimate: whenever an arbitrary binary vector is the output of independent binary noise of level $0<D<d_0<1/2$, an explicitly constructed reproduction law assigns its radius-$nD$ distortion ball probability at least its source probability times $e^{nh(D)}$, up to a polynomial factor, outside a probability $4/n^2$. The estimate requires neither independence nor mixing of the latent vector. It follows by splitting the noise, conditioning on both latent and observed words, and applying an elementary local bound for two binomials. A positive two-state representation verifies the required finite-block decomposition for the Markov source. The critical endpoint and distortions above it are not covered.

## 1. Problem, result, and attribution

Let $X_1$ be uniform on $\{0,1\}$, and let the transition flips $X_i\oplus X_{i-1}$, $i\ge2$, be independent Bernoulli variables of parameter $p\in(0,1/2)$, independent also of $X_1$. A deterministic length-$n$ code consists of an encoder into $\{1,\ldots,M\}$ and a decoder with reproduction words in $\{0,1\}^n$. The criterion is

$$
\Pr\{d_H(X^n,\widehat X^n)>nD\}\le\epsilon.
\tag{1}
$$

The inequality includes the exact integer boundary: admissible errors are at most $\lfloor nD\rfloor$. Write $M_n^*(D,\epsilon)$ for the smallest code size and $R^*(n,D,\epsilon)=n^{-1}\log_2M_n^*$. The parameters are known to the code designer and held fixed as $n\to\infty$. No efficiency constraint is imposed on the encoder or codebook.

Put $\rho=1-2p$ and

$$
D_c(p)=\frac12\left(1-\frac{2\sqrt\rho}{1+\rho}\right)
=\frac12\left(1-\sqrt{1-\left(\frac p{1-p}\right)^2}\right).
\tag{2}
$$

**Theorem 1 (strict-interior operational dispersion).** For every fixed $p\in(0,1/2)$, $D\in(0,D_c(p))$, and $\epsilon\in(0,1)$,

$$
R^*(n,D,\epsilon)=h_2(p)-h_2(D)
+\sqrt{\frac{\nu(p)}n}\,\mathsf Q^{-1}(\epsilon)
+O_{p,D,\epsilon}\left(\frac{\log n}{n}\right),
\tag{3}
$$

where $h_2$ is binary entropy in bits and $\mathsf Q$ is the standard normal upper-tail function.

This is a theorem about one uninterrupted Markov path. The positive coefficient $\nu(p)$ is independent of $D$ within this open interval. The remainder is pointwise in the fixed parameters; its constants need not remain bounded as $D\uparrow D_c(p)$, $p$ approaches either endpoint, or $\epsilon$ approaches zero or one.

The classical Gray formula, finite-block backward binary-noise decomposition, and varentropy expression are existing inputs. Krishnamachari [K26], Proposition 5, Proposition 10, and Section 6, gives the relevant finite-block identities and a matching second-order converse, while leaving matching achievability open. We reuse these facts with explicit proofs where needed. Our contribution is the strict-interior upper bound, supported by the uniform-in-latent-law distortion-ball theorem below. We do not claim to settle [K26]'s larger all-distortion conjecture. A bounded comparison with [DK02], [OA12], [O12], [KV12], [K17], and [TK26] appears in Section 8.

Except where a subscript 2 is present, the rest of the proof uses natural logarithms. Write $h(u)=-u\log u-(1-u)\log(1-u)$.

## 2. A finite-block theorem for arbitrary dependent vectors

For a probability law $R$ on $\{0,1\}^n$, let $R*B_u^n$ denote the law obtained by independently flipping its coordinates with probability $u$. The coordinates of $R$ may have any dependence. Define $B_D(x)=\{y:d_H(x,y)\le nD\}$.

Fix $0<D<d_0<1/2$, and define

$$
t=\frac{d_0-D}{1-2D},\qquad
q_0=\frac{tD}{1-d_0},\qquad
q_1=\frac{(1-t)D}{d_0}.
\tag{4}
$$

Then $0<t<1/2$, $0<q_0<q_1<1$, and

$$
t+D-2tD=d_0,\qquad (1-d_0)q_0+d_0q_1=D.
\tag{5}
$$

Set

$$
\eta=\min(q_0,1-q_0,q_1,1-q_1),\quad v=\eta(1-\eta),\quad
N=\left\lceil(4/\eta)^4\right\rceil,
$$
$$
\kappa=2+8/v,\qquad c=\frac{D}{2(1-D)}e^{-1/v},\qquad
L_n=\kappa\log(n+1)+\log(1/c).
\tag{6}
$$

These constants are explicit, positive where appropriate, and deliberately conservative.

**Theorem 2 (polynomial distortion-ball bound).** For every integer $n\ge N$ and every probability law $R$ on $\{0,1\}^n$, put

$$
P=R*B_{d_0}^n,\qquad Q=R*B_t^n,\qquad
j(x)=-\log P(x)-nh(D).
\tag{7}
$$

There is a set $G\subseteq\{0,1\}^n$ with $P(G)\ge1-4/n^2$ such that

$$
c(n+1)^{-\kappa}P(x)e^{nh(D)}
\le Q(B_D(x))\le P(x)e^{nh(D)},\qquad x\in G.
\tag{8}
$$

The upper bound holds for every $x$. Equivalently, on $G$,

$$
j(x)\le-\log Q(B_D(x))\le j(x)+L_n.
\tag{9}
$$

The hypothesis is an **exact finite-dimensional decomposition at a strictly larger noise level**. Equality in an asymptotic Shannon lower bound, without such a decomposition, is not substituted for this hypothesis. The law $R$ can change with $n$; no consistency, stationarity, or mixing is needed for Theorem 2.

## 3. Proof of the distortion-ball bound

### 3.1. A local estimate with all integer endpoints

For $B\sim\operatorname{Bin}(m,q)$, $m\ge1$, $q\in(0,1)$, and an integer $0\le a\le m$, let $r=a/m$. At parameter $r$, $a$ is a mode of the binomial distribution; comparing consecutive probabilities proves this, and $a=0,m$ gives a point mass. Thus its mass is at least $1/(m+1)$. Changing the parameter from $r$ to $q$ gives

$$
\Pr\{B=a\}\ge\frac1{m+1}\exp[-m\,\operatorname{kl}(r\Vert q)]
\ge\frac1{m+1}\exp\left[-\frac{(a-mq)^2}{mq(1-q)}\right].
\tag{10}
$$

The second inequality follows from $\log u\le u-1$, which implies
$\operatorname{kl}(r\Vert q)\le(r-q)^2/[q(1-q)]$, including $r=0,1$ by continuity. A group of size zero has count zero with probability one; (10) is never applied to it.

**Lemma 3.** Let independent $B_i\sim\operatorname{Bin}(n_i,q_i)$, $i=0,1$, satisfy $n_0+n_1=n\ge1$ and $q_i\in[\eta,1-\eta]$. Write $\mu=n_0q_0+n_1q_1$. If the integer $k$ satisfies

$$
|k-\mu|+1\le\eta n/2,
\tag{11}
$$

then

$$
\Pr\{B_0+B_1=k\}\ge(n+1)^{-2}
\exp\left[-\frac1v-\frac{2(|k-\mu|+1)^2}{nv}\right].
\tag{12}
$$

**Proof.** Choose a smaller group $s$ and a larger group $\ell$, so $n_\ell\ge n/2$. Set $a_s=\lfloor n_sq_s\rfloor$ and $a_\ell=k-a_s$. The smaller count is feasible. The larger count satisfies
$$
|a_\ell-n_\ell q_\ell|\le|k-\mu|+1\le\eta n/2\le\eta n_\ell.
$$
Hence $0\le a_\ell\le n_\ell$. For a nonempty smaller group, (10) contributes exponent at most $1/v$. For the larger group it contributes at most $2(|k-\mu|+1)^2/(nv)$. Multiply the two bounds and use $(n_s+1)(n_\ell+1)\le(n+1)^2$. If $n_s=0$, omit its exact factor one and retain the weaker displayed lower bound. The chosen joint count event is contained in $B_0+B_1=k$. ∎

### 3.2. Split the noise before conditioning

Take independent random objects $Z\sim R$, $A\sim\operatorname{Ber}(t)^{\otimes n}$, and $E\sim\operatorname{Ber}(D)^{\otimes n}$. Define

$$
Y=Z\oplus A,\qquad X=Y\oplus E,\qquad
S=\sum_iE_i,\qquad K=d_H(Z,X).
\tag{13}
$$

By (5), $X\sim P$, $Y\sim Q$, and $P=Q*B_D^n$. Also
$K=\sum_i(A_i\oplus E_i)\sim\operatorname{Bin}(n,d_0)$, regardless of $R$.

Condition on **both** $Z=z$ and $X=x$ with positive joint probability. These constraints specify the coordinate parities $A_i\oplus E_i=z_i\oplus x_i$. Since the pairs $(A_i,E_i)$ were independent, the conditional $E_i$'s are independent. Their probabilities of being one are $q_0$ on equal coordinates and $q_1$ on unequal coordinates, by direct division of joint error/parity mass. Consequently

$$
S\mid(Z=z,X=x)\ \sim\
\operatorname{Bin}(n-K,q_0)+\operatorname{Bin}(K,q_1),
\tag{14}
$$

with independent summands, and its conditional mean is

$$
\mu(z,x)=nD+(q_1-q_0)(K-nd_0).
\tag{15}
$$

Here $0<q_1-q_0<1$. The identities (5) establish (15). Positivity of both posterior parameters and their complements follows from the four strictly positive probabilities of $(A_i,E_i)$. There is no assertion that the error coordinates are independent after conditioning on $X$ alone.

### 3.3. Transfer a noise-count tail to a typical source set

Let $w=\sqrt{n\log n}$. The binomial Hoeffding bound gives

$$
\Pr\{|K-nd_0|>w\}\le2e^{-2w^2/n}=2/n^2.
\tag{16}
$$

For completeness, this inequality follows from the Bernoulli bound
$\mathbb E e^{\theta(B-\mathbb EB)}\le e^{\theta^2/8}$: the second derivative of its log moment-generating function is a Bernoulli variance at a tilted parameter and is at most $1/4$, while its value and derivative at zero vanish. Independence, exponential Markov inequality, and optimization at $\theta=4w/n$ prove each tail.

Every $x$ has positive $P(x)$. Define

$$
b(x)=\Pr\{|K-nd_0|>w\mid X=x\},\qquad G=\{x:b(x)\le1/2\}.
$$

Since $\mathbb E b(X)\le2/n^2$, Markov's inequality gives $P(G^c)\le4/n^2$. For each $x\in G$, at least half the posterior mass of $Z$ satisfies $|K-nd_0|\le w$. For these pairs, (15) gives $|\mu-nD|\le w$.

Set $k=\lfloor nD\rfloor$. For such a pair,
$|k-\mu|+1\le w+2$. The explicit choice $n\ge N$ guarantees

$$
w+2\le\eta n/2,\qquad w\ge2.
\tag{17}
$$

Indeed $\log n\le\sqrt n$ for $n\ge1$, so $w\le n^{3/4}\le\eta n/4$, while $n\ge8/\eta$ gives $2\le\eta n/4$. Also $\eta\le1/2$ implies $n\ge4096$. Lemma 3 and $(w+2)^2\le4n\log n$ now yield

$$
\Pr\{S=k\mid Z=z,X=x\}\ge e^{-1/v}(n+1)^{-2}n^{-8/v}.
$$

Integrating only over the posterior good $z$'s gives

$$
\Pr\{S=k\mid X=x\}\ge\tfrac12e^{-1/v}(n+1)^{-2}n^{-8/v},\qquad x\in G.
\tag{18}
$$

### 3.4. Convert a conditional shell into reproduction mass

For the joint law (13), Bayes' formula on the exact shell gives

$$
Q\{y:d_H(x,y)=k\}
=P(x)\frac{\Pr\{S=k\mid X=x\}}{D^k(1-D)^{n-k}}.
\tag{19}
$$

Because $-1<k-nD\le0$,

$$
\frac1{D^k(1-D)^{n-k}}
=\exp\left[nh(D)+(k-nD)\log\frac{1-D}{D}\right]
\ge\frac D{1-D}e^{nh(D)}.
\tag{20}
$$

The shell lies in $B_D(x)$. Combining (18)--(20), and weakening $n^{-8/v}$ to $(n+1)^{-8/v}$, proves the lower bound (8). For the upper bound, every point in that ball has binary-noise likelihood at least $e^{-nh(D)}$, and therefore
$$
P(x)=\sum_yQ(y)D^{d_H(x,y)}(1-D)^{n-d_H(x,y)}
\ge e^{-nh(D)}Q(B_D(x)).
$$
This proves Theorem 2. ∎

## 4. Explicit finite-block coding consequences

**Proposition 4 (random covering with an exact error budget).** Under Theorem 2, for every real $a$, an integer code size

$$
M=\left\lceil\exp[a+L_n+\log n]\right\rceil
\tag{21}
$$

admits a deterministic code with excess probability at most

$$
\Pr\{j(X)>a\}+4/n^2+e^{-n}.
\tag{22}
$$

**Proof.** Draw $M$ words independently from $Q$. For fixed $x$, the probability that no word lies in its distortion ball is $(1-Q(B_D(x)))^M\le\exp[-M Q(B_D(x))]$. On $G\cap\{j\le a\}$, (9) makes this at most $e^{-n}$. Bound the remaining mass by the first two terms of (22). Some deterministic codebook has error no greater than the average. Use the first covering word if one exists and a fixed word otherwise. Repeated codewords cause no difficulty because the criterion allows at most $M$ words. ∎

**Proposition 5 (information-spectrum converse).** For any source law $P$ on the binary cube, any $M$-word code, and $\gamma>0$, with $j(x)=-\log P(x)-nh(D)$ on its support,

$$
\epsilon_{\rm code}\ge
\Pr\{j(X)\ge\log M+\gamma\}-e^{-\gamma}.
\tag{23}
$$

**Proof.** Each radius-$nD$ ball contains at most $e^{nh(D)}$ words: under binary noise of parameter $D$, each word in it has mass at least $e^{-nh(D)}$. Thus the successful set of any code is contained in a union of at most $M e^{nh(D)}$ words. Every point of the high-$j$ event in (23) has source mass at most $M^{-1}e^{-\gamma-nh(D)}$. Its successful part consequently has probability at most $e^{-\gamma}$. ∎

Proposition 5 is a standard lossy information-spectrum lower bound, included to keep the probability direction and coding model explicit. Equations (21)--(23) provide a finite-block comparison with source self-information for every family having the fixed noise margin of Theorem 2. In particular, one can choose $a$ as an exact source-score quantile at error $\epsilon-4/n^2-e^{-n}$, when that number is positive. This keeps the final error at most the requested $\epsilon$, rather than merely $\epsilon+o(1)$.

## 5. A positive realization of the finite-block Gray decomposition

We now verify the premise of Theorem 2 for every Markov block at the same fixed $d_0\in(D,D_c(p))$. This finite-dimensional fact is essential; no argument based solely on a limiting rate-distortion identity is used.

Let $s=\sqrt\rho$, $z=1-2d_0$, and $g=s/z$. Define

$$
C_0=\frac14\begin{pmatrix}1+\rho+2g&1-\rho\\1-\rho&1+\rho-2g\end{pmatrix},\qquad
C_1=\frac14\begin{pmatrix}1+\rho-2g&1-\rho\\1-\rho&1+\rho+2g\end{pmatrix}.
\tag{24}
$$

Since $d_0<D_c(p)$, all entries are strictly positive. Their sum is

$$
T=C_0+C_1=\begin{pmatrix}1-p&p\\p&1-p\end{pmatrix}.
\tag{25}
$$

With $\pi=(1/2,1/2)^\top$, put

$$
R_n(y^n)=\boldsymbol1^\top C_{y_n}\cdots C_{y_1}\pi.
\tag{26}
$$

This is a strictly positive probability law, because summing over words gives $\boldsymbol1^\top T^n\pi=1$.

To verify the convolution, mix each marked matrix through binary noise:
$$
\widetilde C_x=(1-d_0)C_x+d_0C_{1-x}.
$$
The formula is (24) with $g$ replaced by $s$. Let
$u_0=(1+s,1-s)^\top$, $u_1=(1-s,1+s)^\top$. Then

$$
\widetilde C_x=\tfrac14u_xu_x^\top,\quad
u_x^\top u_x=4(1-p),\quad u_x^\top u_{1-x}=4p,
\quad\boldsymbol1^\top u_x=2,\quad u_x^\top\pi=1.
\tag{27}
$$

Distributing the matrix product in the convolution of (26), then using (27), gives

$$
(R_n*B_{d_0}^n)(x^n)
=\boldsymbol1^\top\widetilde C_{x_n}\cdots\widetilde C_{x_1}\pi
=\tfrac12 p^{f(x)}(1-p)^{n-1-f(x)}=P_n(x^n),
\tag{28}
$$

where $f(x)$ counts adjacent flips. This proves the required exact decomposition for every $n\ge1$.

The construction is a positive realization of the established Gray decomposition, and is not claimed as an independent new rate-distortion theorem. It also yields an implementation: maintain one hidden state, and from state $i$ choose output $y$ and next state $j$ with probability $(C_y)_{ji}$. The columns of $C_0+C_1$ sum to one, so this samples (26) in $O(n)$ arithmetic operations. Applying independent noise $t$ samples the reproduction law $Q_n$ in Theorem 2. This does not make the exponentially large random codebook or the covering encoder computationally efficient.

## 6. Proof of the normal approximation

The source flip count $F_n=f(X^n)$ is exactly $\operatorname{Bin}(n-1,p)$. Consequently the score of (7) is

$$
j_n(X^n)=nR+\beta+a_p[F_n-(n-1)p],
\tag{29}
$$
$$
R=h(p)-h(D),\quad\beta=\log2-h(p),\quad
a_p=\log\frac{1-p}{p}>0.
$$

Its mean is $m_n=nR+\beta$, and its variance is
$\sigma_n^2=(n-1)v_p$, where $v_p=p(1-p)a_p^2>0$.

The classical Berry--Esseen inequality for sums of independent Bernoulli variables [BE11] gives a constant $B_p<\infty$ such that, for $n\ge2$,

$$
\sup_u\left|\Pr\{(j_n-m_n)/\sigma_n\le u\}-\Phi(u)\right|
\le B_p/\sqrt{n-1}.
\tag{30}
$$

The corresponding one-sided tail inequalities with either $>$ or $\ge$ follow by taking left limits and continuity of $\Phi$. Hence lattice atoms cause at most the same error order.

Fix $z_\epsilon=\mathsf Q^{-1}(\epsilon)$. Since the normal density is positive at this finite point, (30) implies that one can choose a constant $A_{p,\epsilon}$ such that

$$
a_n=m_n+\sigma_n z_\epsilon+A_{p,\epsilon}
$$

satisfies $\Pr\{j_n>a_n\}\le\epsilon-4/n^2-e^{-n}$ for every sufficiently large $n$. To see the constant choice explicitly, take a neighborhood of $z_\epsilon$ where the density is bounded below by $b_\epsilon>0$; increasing the unnormalized threshold by $A$ decreases the normal tail by at least $b_\epsilon A/\sigma_n$. Choose $A$ so this dominates $B_p/\sqrt{n-1}$ by a positive multiple of $n^{-1/2}$, which eventually also dominates $4/n^2+e^{-n}$.

By Proposition 4, a code with error at most $\epsilon$ has

$$
\log M\le m_n+\sigma_nz_\epsilon+L_n+\log n+O(1)
=nR+\sqrt{nv_p}z_\epsilon+O_{p,D,\epsilon}(\log n).
\tag{31}
$$

The rounding in (21) changes the logarithm by at most $\log2$ once its exponent is nonnegative; this holds eventually because $D<D_c(p)<p$ and $R>0$.

For the converse take $\gamma=\log n$ in (23). A code with error at most $\epsilon$ must satisfy

$$
\mathsf Q\left(\frac{\log M+\log n-m_n}{\sigma_n}\right)
\le\epsilon+n^{-1}+B_p/\sqrt{n-1}.
$$

The inverse normal tail is continuously differentiable near the fixed $\epsilon$. Thus

$$
\log M\ge m_n+\sigma_n z_\epsilon-\log n-O_{p,\epsilon}(1)
=nR+\sqrt{nv_p}z_\epsilon-O_{p,\epsilon}(\log n).
\tag{32}
$$

Combining (31) and (32), then dividing by $n\log2$, proves Theorem 1. ∎

## 7. Reproduction, scope, and unresolved cases

The accompanying exact script uses rational arithmetic to verify the two-state construction, normalization, all three noise convolutions, the conditional product formula, and binomial mode bounds in explicitly listed finite cases. A separate dynamic program evaluates actual reproduction-ball masses along sampled Markov paths. These checks detect implementation and algebra errors; they are not substitutes for the quantified proofs above.

For example, $p=4/9$ gives $\rho=1/9$ and $D_c=1/5$. The choices $D=1/10$, $d_0=9/50$ have $t=1/10$, $q_0=1/82$, $q_1=1/2$, with exact rational marked matrices. This gives nondegenerate instances of every strict hypothesis. The bound's large constants are not presented as practical compression guarantees at short blocklengths.

The proof does not settle $D=D_c(p)$: at that endpoint there is no larger admissible $d_0$ within the same decomposition region. It also does not settle the higher-distortion dispersion, optimize the coefficient of $\log n$, provide a polynomial-time encoder, treat unknown $p$, or establish bounds uniform in varying parameter sequences. A fixed law with dependence can be treated by Theorem 2 only after its exact noise-margin premise is verified.

The delivered Lean file covers a specifically enumerated part of the finite kernel algebra. The general probability, local-bound, covering, and asymptotic arguments are not covered by a complete formal proof. Neither the Python tests nor uncompiled Lean source is called an end-to-end formal proof.

## 8. Related work and novelty boundary

[K26] is the immediate target: its finite-block variance and single-path converse identify the candidate coefficient, while its Section 6 isolates the missing distortion-ball estimate. Theorem 2 supplies that estimate with an $O(\log n)$ correction in the strict low-distortion region. The original all-distortion problem remains broader.

A particularly close precedent is Oğuz’s dissertation [O12], Section 3.8, Theorem 3.8.3: it already combines backward noise, Bayes’ formula, and a posterior typical set to obtain a ball-information bound with an O(√n log n) correction in a more general balanced-distortion setting. That scale is too large to identify a √n dispersion coefficient. We do not claim those three ingredients as new. The additional fixed noise margin and exact-shell estimate in Theorem 2 reduce the correction to O(log n) in the binary model.

The generalized AEP in [DK02] is foundational for distortion-ball analysis. Its second-order statements used in this comparison concern a product reproduction law, and its dependent-reproduction extension gives first-order information; these do not directly furnish (8). [OA12] gives entropy-density and coding-variance lower bounds for sources with memory when the Shannon lower bound is tight. [KV12] supplies general nonasymptotic coding principles and the memoryless dispersion framework. [K17] characterizes exact Shannon-lower-bound equality, with the stated fixed-distortion normal approximation in the memoryless setting. [TK26] handles independent, potentially nonidentical coordinates and Gaussian transformations preserving the distortion. Independent Markov flips do not transform the original Hamming distortion into a coordinatewise distortion on flips.

We also checked Le–Tan–Motani [LTM14], Section VI. Its displayed stationary single-letter centering and single-letter score cannot be substituted for the present path score: with constant side information and a symmetric binary marginal, those expressions give $\log2-h(D)$ and zero score variance, whereas (28)–(29) give $h(p)-h(D)$ and positive variance. That specialization therefore does not provide the theorem claimed here. This comparison is limited to the stated specialization.

The underlying concentration, binary-noise composition, binomial type bound, random coding, and Berry--Esseen theorem are standard. Novelty is claimed only for the combined arbitrary-dependent-law noise-margin estimate and its operational strict-Gray application, within the literature actually checked. No global priority certificate or external publication-level endorsement is asserted. The comparison is limited to the sources discussed here.

## References

- **[K26]** B. Krishnamachari, *A Block Hierarchy for Rate-Distortion and Dispersion of Binary Markov Sources*, arXiv:2603.07435v4, 19 November 2026. [Official PDF](https://arxiv.org/pdf/2603.07435v4). Particularly Sections 4.2, 5.3, and 6. Gray's classical work is credited there; our proof of the needed finite-block identity is given in Section 5.
- **[DK02]** A. Dembo and I. Kontoyiannis, *Source Coding, Large Deviations, and Approximate Pattern Matching*, IEEE Transactions on Information Theory 48(6), 1590--1615, 2002. [Preprint](https://arxiv.org/abs/math/0103007).
- **[OA12]** B. Oğuz and V. Anantharam, *Pointwise Lossy Source Coding Theorem for Sources with Memory*, ISIT 2012. [DOI](https://doi.org/10.1109/ISIT.2012.6284209). Related author dissertation: [Berkeley report](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2012/Archive/EECS-2012-204.pdf), Chapter 3.
- **[O12]** B. Oğuz, *Long Range Dependent Models in Information Theory*, PhD dissertation, University of California, Berkeley, 2012, Section 3.8, Theorem 3.8.3 and Lemma 3.8.4, printed pages 80–84. [Official report EECS-2012-204](https://www2.eecs.berkeley.edu/Pubs/TechRpts/2012/Archive/EECS-2012-204.pdf).
- **[KV12]** V. Kostina and S. Verdú, *Fixed-Length Lossy Compression in the Finite Blocklength Regime*, IEEE Transactions on Information Theory 58(6), 3309--3338, 2012. [Preprint](https://arxiv.org/abs/1102.3944).
- **[K17]** V. Kostina, *Data Compression with Low Distortion and Finite Blocklength*, IEEE Transactions on Information Theory, 2017. [Preprint](https://arxiv.org/abs/1510.02190).
- **[TK26]** Eyyüp Taşçı and Victoria Kostina, *Dispersion of Gaussian Sources with Memory and an Extension to Abstract Sources*, arXiv:2602.09176v2, 26 June 2026. [Official record](https://arxiv.org/abs/2602.09176v2).
- **[LTM14]** S.-Q. Le, V. Y. F. Tan, and M. Motani, *Second-Order Coding Rates for Conditional Rate-Distortion*, arXiv:1410.2687v1, 2014. [Official PDF](https://arxiv.org/pdf/1410.2687v1), Section VI, equations (75)–(76). This is a scope comparison, not an input to our proof.
- **[BE11]** I. Shevtsova, *On the absolute constants in the Berry--Esseen type inequalities for identically distributed summands*, arXiv:1111.6554, 2011. [Official record](https://arxiv.org/abs/1111.6554). Only the classical finite-constant Berry--Esseen inequality is used.
