# Tail-Sensitive and Robust Capacity Laws for Random-Rank Matrix Channels

*Written-proof manuscript. No external peer review or Lean certification.*

Date: 2026-11-26. Information quantities use logarithms to base $q$. The notation $\ln$ always denotes the natural logarithm, including in the critical term $n\ln n$. All $O(\cdot)$ statements below are deterministic estimates.

## 1. Problem, model and contribution boundary

Fix a prime power $q$ and positive integers $n,m$, and put $d=\min(n,m)$. The input and output alphabets are the $n\times m$ matrices over $\mathbb F_q$. Independently of the input $X$, draw $T$ from an arbitrary probability law $\pi$ on $\{0,\ldots,d\}$; conditional on $T=t$, draw $W$ uniformly among rank-$t$ matrices; and draw $A$ uniformly from $\operatorname{GL}_n(\mathbb F_q)$, independently of $(T,W)$. The channel is

$$
Y=A(X+W),\qquad C_q(n,m,\pi)=\max_{P_X} I_q(X;Y).
$$

The realization of $T$ is not revealed to the transmitter or receiver.

Random error rank is established prior work. Silva, Kschischang and Kötter [SKK10, Section VI-D] study variable error rank $R\le t$ and an entropy penalty $H(R)$ in comparison with a maximum error-rank budget. In a different, purely multiplicative model $Y=GX$, Nóbrega, Silva and Uchôa-Filho [NSU13, Theorem 5] prove that the best constant-input-rank distribution is within $\log_q(\min(n,m)+1)$ of capacity. Their Theorem 7 also gives a large-field formula with a maximum outside an expectation over transfer rank. These structural ideas predate the present work; the model of [NSU13] has no additive noise $W$.

The model above is the Gamma channel of Blackburn and Claridge [BC19]. Their article proves that an input distribution uniform conditional on its rank attains capacity and provides an exact finite optimization. Its concluding Open Problem 2 asks for useful capacity asymptotics, specifically mentioning binomial error ranks. Their later article [BC25] treats the fixed-error-rank additive-multiplicative matrix channel, identifies its deterministic leading capacity, and proves an $O(\ell\log\ell)$ error in a fixed-field proportional-growth regime. We do not claim the Gamma model, random-error-rank modeling, uniform-given-rank symmetry, the constant-rank entropy comparison, the subspace-counting method, or the fixed-$t$ leading kernel as new.

The scalar optimization used below has established precedents. Scarf's mean-variance inventory model [S58] supplies the classical stop-loss moment bound and two-point extremizer. Das, Dhara and Natarajan [DDN21] analyze moment ambiguity, regular variation and contamination effects in robust newsvendor models. These methods do not by themselves control the mutual information of the present hidden-rank matrix channel. Our use of minimax interchange is an application of Sion's classical theorem [Si58]. We do not claim stop-loss optimization, moment ambiguity, heavy-tail integration, or generic contamination sensitivity as new.

The results connect finite-field matrix geometry to capacity optimization at scales where the full error-rank tail matters:

1. A nonasymptotic approximation has additive error $O_q(m)$, uniformly over every dimension, admissible input and error rank, and error-rank law. It yields the arbitrary-law $n^2$-normalized limit and the binomial three-regime expansion.
2. Near the geometric threshold, capacity reduces to a strongly convex stop-loss objective with error $O(n+a_n^2)$. Its minimizer controls every exact best fixed rank to error $O(\sqrt{n+a_n^2})$ under explicit second-moment and nondegeneracy assumptions.
3. Stretched-exponential and regularly varying tail conditions yield distinct moving-threshold laws, with matching optimal-rank limits and legal integer-valued examples. The binomial $n\ln n$ correction is a special case of the stretched-exponential law.
4. Under a mean and variance budget, a common fixed input rank and an admissible integer two-point error law give a sharp information saddle expansion with remainder $O(n+v_n)$. At the threshold, its correction is $\frac34(N_nv_n)^{2/3}$.
5. A rare-contamination construction preserves the exact mean, leading variance, Gaussian limit, convergence of standardized second moments, and vanishing total-variation distance to a binomial law, while changing the capacity correction from order $n\ln n$ to order $n^{2\theta}$ for $1/2\mathrel{<}\theta\mathrel{<}2/3$.

All input-rank localization assertions refer to an achieving fixed-rank design or an exact optimizer within fixed-rank input laws. They do not assert that every exactly capacity-achieving input distribution has a deterministic rank. The information maximin studied below is not identified with an operational compound-channel coding capacity.

### Primary comparison sources

- **[SKK10]** D. Silva, F. R. Kschischang and R. Kötter, *Communication over Finite-Field Matrix Channels*, IEEE Transactions on Information Theory **56**(3), 1296–1305 (2010), DOI [10.1109/TIT.2009.2039167](https://doi.org/10.1109/TIT.2009.2039167). Fixed manuscript: [arXiv:0807.1372v4](https://arxiv.org/abs/0807.1372v4), 14 September 2009. Section VI-D treats variable error rank and its entropy penalty.
- **[NSU13]** R. W. Nóbrega, D. Silva and B. F. Uchôa-Filho, *On the Capacity of Multiplicative Finite-Field Matrix Channels*, IEEE Transactions on Information Theory **59**(8), 4949–4960 (2013), DOI [10.1109/TIT.2013.2253542](https://doi.org/10.1109/TIT.2013.2253542). Fixed manuscript: [arXiv:1105.6115v4](https://arxiv.org/abs/1105.6115v4), 17 April 2013. Relevant items: Theorem 5 and equation (15), on constant-rank approximation, and Theorem 7, on the large-field maximum-expectation formula for multiplicative channels.
- **[BC19]** S. R. Blackburn and J. Claridge, *Finite-Field Matrix Channels for Network Coding*, IEEE Transactions on Information Theory **65**(3), 1614–1625 (2019), DOI [10.1109/TIT.2018.2875763](https://doi.org/10.1109/TIT.2018.2875763). Fixed manuscript: [arXiv:1601.06037v4](https://repository.essex.ac.uk/26052/1/1601.06037v4.pdf), 31 January 2018. Relevant items: Theorem 5.5, Corollary 6.2 and concluding Open Problem 2. The journal issue is dated 2019; online-first publication was in 2018.
- **[BC25]** S. R. Blackburn and J. Claridge, *The Capacity of a Finite Field Matrix Channel*, IEEE Transactions on Information Theory **71**(4), 2482–2493 (2025), DOI [10.1109/TIT.2025.3536077](https://doi.org/10.1109/TIT.2025.3536077). Fixed manuscript: [arXiv:2210.14100v4](https://arxiv.org/html/2210.14100v4), 20 January 2025. Relevant items: Lemmas 5–8 and 11–12, and Theorems 9, 13 and 14. Random error rank is mentioned in the introduction, but these capacity theorems concern fixed $t$.
- **[G10]** L. Goldstein, *Bounds on the constant in the mean central limit theorem*, Annals of Probability **38**(4), 1672–1689 (2010), DOI [10.1214/10-AOP527](https://doi.org/10.1214/10-AOP527), Theorem 1.1. [Author manuscript](https://dornsife.usc.edu/larry-goldstein/wp-content/uploads/sites/221/2023/06/3pt-1.pdf). We use its standard $L^1$ normal-approximation bound.

- **[S58]** H. Scarf, *A Min-Max Solution of an Inventory Problem*, in K. J. Arrow, S. Karlin and H. Scarf (eds.), *Studies in the Mathematical Theory of Inventory and Production*, Stanford University Press, 1958, pp. 201–209. [Chapter scan](https://zhanksun.github.io/reading/scarf1958.pdf). The two-point moment extremum and square-root expression are in Section 2, pp. 203–205.
- **[Si58]** M. Sion, *On General Minimax Theorems*, Pacific Journal of Mathematics **8**(1), 171–176 (1958), DOI [10.2140/pjm.1958.8.171](https://doi.org/10.2140/pjm.1958.8.171). [Publisher text](https://msp.org/pjm/1958/8-1/pjm-v8-n1-p14-s.pdf), Theorem 3.4, p. 174.
- **[DDN21]** B. Das, A. Dhara and K. Natarajan, *On the Heavy-Tail Behavior of the Distributionally Robust Newsvendor*, Operations Research **69**(4), 1077–1099 (2021), DOI [10.1287/opre.2020.2091](https://doi.org/10.1287/opre.2020.2091). Fixed author manuscript: [arXiv:1806.05379v2](https://arxiv.org/html/1806.05379v2), 19 August 2019. Relevant parts in its 42-page PDF are Section 1.1, especially equation (1.3) on p. 3; Section 4, beginning on p. 26; and Section 5.3, beginning on p. 35. These give the moment-bound, regular-variation and contamination precedents, respectively.

## 2. Main results

For $a\in\mathbb R$, write $a_+=\max(a,0)$. Define the deterministic geometric kernel

$$
f_{n,m}(k,t)=(m-k-t)_+\min(k,n-t),
\qquad k,t\in\{0,\ldots,d\},
$$

and its optimized expectation

$$
M(n,m,\pi)=\max_{k\in\{0,\ldots,d\}}\mathbb E_\pi f_{n,m}(k,T).
$$

The kernel and $M$ do not depend on $q$.

### Theorem 1. Uniform finite-dimensional approximation

Let

$$
B_q(n,m)=\frac{8(m+3d)}{q-1}+\log_q(d+1)+2\log_q4.
$$

Then

$$
\left|C_q(n,m,\pi)-M(n,m,\pi)\right|
\le B_q(n,m)+\log_q(d+1).
$$

More precisely, if $I_{k,t}$ denotes mutual information under uniform rank-$k$ input and fixed rank-$t$ error, then

$$
|I_{k,t}-f_{n,m}(k,t)|\le B_q(n,m).
$$

If $I_k^\pi$ denotes mutual information under uniform rank-$k$ input with hidden error rank of law $\pi$, then

$$
\max_k\mathbb E I_{k,T}-H_q(T)
\le C_q(n,m,\pi)
\le\max_k\mathbb E I_{k,T}+\log_q(d+1).
$$

Consequently, any $k$ maximizing $\mathbb E f_{n,m}(k,T)$, used as a uniform-rank input, is within

$$
2B_q(n,m)+2\log_q(d+1)
$$

of capacity. Since $d\le m$, the displayed error is $O_q(m)$ for $n,m\ge1$. The constants are explicit and conservative; no optimality of these constants is asserted.

### Corollary 2. Arbitrary-law proportional limit

Fix $q$. Suppose $m_n/n\to\beta>0$ and $T_n/n$ converges in distribution to a law $\Pi$ supported on $[0,\min(1,\beta)]$. For the corresponding Gamma channels,

$$
\frac{C_q(n,m_n,\pi_n)}{n^2}
\longrightarrow
\max_{0\le x\le\min(1,\beta)}
\mathbb E_\Pi\!\left[(\beta-x-Z)_+\min(x,1-Z)\right].
$$

This identifies the $n^2$-normalized limit. If the right-hand side is zero, the statement alone does not identify a first nonzero asymptotic term. The limit depends on the whole law $\Pi$; replacing the error rank by its mean is generally unjustified.

### Example 2.1. Equal means can give different normalized capacities

Let $m_n=n$ and take even $n$. First let $T_n$ equal $0$ and $n$ with probability $1/2$ each. Then $\mathbb E T_n=n/2$, and Corollary 2 gives

$$
\lim_{n\to\infty}\frac{C_q(n,n,\pi_n)}{n^2}
=\max_{0\le x\le1}\frac12x(1-x)=\frac18,
$$

with maximizing rank fraction $x=1/2$. Indeed, the rank-$n$ component contributes zero to the kernel, while the rank-zero component contributes $k(n-k)$.

For the deterministic error rank $T_n=n/2$, the same mean instead gives

$$
\lim_{n\to\infty}\frac{C_q(n,n,\delta_{n/2})}{n^2}
=\max_{0\le x\le1}\left(\frac12-x\right)_+
\min\left(x,\frac12\right)=\frac1{16},
$$

with maximizing rank fraction $x=1/4$. The nonzero part of this objective is $x(1/2-x)$ on $[0,1/2]$. This is an illustrative consequence of Corollary 2, rather than a separate originality claim.

### Theorem 3. Binomial phase diagram

Fix $q$, $p\in(0,1)$ and $\beta\ge1$. Set

$$
m_n=\lfloor\beta n\rfloor,\qquad
T_n\sim\operatorname{Bin}(n,p),\qquad
u=1-p,\qquad \sigma=\sqrt{p(1-p)}.
$$

Capacity is measured in $q$-ary units per matrix use. Let $\phi$ and $\Phi$ denote the standard normal density and distribution function.

**Interior regime, $1\le\beta\mathrel{<}2-p$.**

$$
C_q(n,m_n,\pi_n)=\frac{(\beta-p)^2}{4}n^2+O(n).
$$

A uniform input with rank nearest to $(m_n-np)/2$ attains this expansion. Every rank $k_n$ maximizing exact fixed-rank mutual information satisfies

$$
\frac{k_n}{n}\longrightarrow\frac{\beta-p}{2},
\qquad
k_n=\frac{\beta-p}{2}n+O(\sqrt n).
$$

**Boundary-limited regime, $\beta>2-p$.** Put

$$
z=\Phi^{-1}\!\left(\frac{u}{\beta-1}\right).
$$

Then

$$
C_q(n,m_n,\pi_n)
=(\beta-1)u n^2-(\beta-1)\sigma\phi(z)n^{3/2}+O(n).
$$

A uniform input with rank nearest to $un-\sigma z\sqrt n$ attains this expansion. Every rank $k_n$ maximizing exact fixed-rank mutual information satisfies

$$
\frac{k_n-un}{\sqrt n}\longrightarrow-\sigma z.
$$

**Critical regime, $\beta=2-p$.**

$$
C_q(n,m_n,\pi_n)
=u^2n^2-\sigma^2n\ln n\,(1+o(1)).
$$

A uniform input with rank nearest to $un-\sigma\sqrt{n\ln n}$ attains the displayed two-term expansion. Every rank $k_n$ maximizing exact fixed-rank mutual information satisfies

$$
\frac{un-k_n}{\sigma\sqrt{n\ln n}}\longrightarrow1.
$$

Each nearest-rank prescription means a nearest admissible integer in $\{0,\ldots,n\}$ and is interior to that set for sufficiently large $n$. Constants in $O(n)$ may depend on the fixed parameters $q,p,\beta$. No uniformity as $p$ approaches $0$ or $1$, or as $\beta$ approaches $2-p$, is claimed. These are capacity asymptotics, not finite-blocklength coding-dispersion formulas or constructions of efficient decoders.

Theorems 4–6, stated with their full tail and moment assumptions in Sections 11–13, develop the local reduction and its two tail classes. Theorems 7 and 8 in Sections 14 and 15 give the variance-budget saddle and rare-contamination counterexample. Sections 3–9 first establish the uniform information estimate and the binomial formulas used throughout.

## 3. Symmetry and the exact orbit entropy identity

Let $U=\operatorname{row}(X)$ and $V=\operatorname{row}(Y)$. The conditional output law depends on $X$ only through $U$. Indeed, if $X'=NX$ for invertible $N$, take $W'=NW$ and $A'=AN^{-1}$. Then

$$
A'(X'+W')=A(X+W),
$$

and $(A',W')$ has the required law. Given the row space of $X+W$, multiplication by uniform $A$ produces a uniform $n\times m$ matrix with that row space. Thus the matrix channel carries exactly the same mutual information as the induced subspace channel:

$$
I_q(X;Y)=I_q(U;V).
$$

Right multiplication by $\operatorname{GL}_m(\mathbb F_q)$ acts transitively on subspaces of each dimension and preserves the channel. Averaging any input distribution over this action cannot reduce mutual information, by concavity in the input law and equivariance of the channel. We may therefore assume that $U$ is uniform conditional on $K=\dim U$. Since $K$ is a function of $U$,

$$
I_q(U;V)=I_q(K;V)+\mathbb E_K I_q(U;V\mid K).
$$

It follows that

$$
\max_k I_k^\pi\le C_q(n,m,\pi)
\le\max_k I_k^\pi+\log_q(d+1).
$$

These arguments apply to any error-rank law $\pi$, including a deterministic $t$.

Now fix $k,t$ and write $R=\dim V$ and $S=\dim(U\cap V)$. Conditional on $V=v$ and $S=s$, the input subspace $U$ is uniform among $k$-dimensional subspaces meeting $v$ in dimension $s$. The stabilizer of $v$ in $\operatorname{GL}_m$ acts transitively on this class and preserves both the uniform input law and the channel transition probabilities. The number of these subspaces is

$$
N_m(k;r,s)
=\begin{bmatrix}r\\s\end{bmatrix}_q
 \begin{bmatrix}m-r\\k-s\end{bmatrix}_q
 q^{(r-s)(k-s)}.
$$

Here $\begin{bmatrix}a\\b\end{bmatrix}_q$ is the Gaussian binomial coefficient. To count the subspaces, select $U\cap v$, select the projection of $U$ to $\mathbb F_q^m/v$, and select a graph map from that projection into a complement of $U\cap v$ in $v$.

The conditional law of $S$ depends on $v$ only through $r=\dim v$. Consequently,

$$
I_{k,t}
=\log_q\begin{bmatrix}m\\k\end{bmatrix}_q
 -H_q(S\mid R)-\mathbb E\log_q N_m(k;R,S).
\tag{3.1}
$$

For $0\le b\le a$, the Gaussian-binomial product formula gives

$$
0\le\log_q\begin{bmatrix}a\\b\end{bmatrix}_q-b(a-b)
\le\log_q4.
\tag{3.2}
$$

The endpoint cases $b=0,a$ have zero correction. The product lower bound used in (3.2) is proved in Lemma 4.1 below. The quadratic exponent in $N_m$ is

$$
(r-s)s+(m-k)(k-s).
$$

Thus, with $g(r,s)=(m+s-k-r)s$, equations (3.1)–(3.2) imply

$$
\left|I_{k,t}-\mathbb E g(R,S)\right|
\le\log_q(d+1)+2\log_q4.
\tag{3.3}
$$

To see the constant, the correction from the first Gaussian coefficient lies in $[0,\log_q4]$, whereas the sum of the two corrections subtracted through $N_m$ lies in $[0,2\log_q4]$. Their signed difference has absolute value at most $2\log_q4$. Also, $H_q(S\mid R)\le\log_q(d+1)$. We retain this conditional-entropy term and do not discard any rare ranks.

## 4. Uniform expected rank defects

### Lemma 4.1. Iid matrix rank defect

For an $a\times b$ matrix $G$ with independent uniform entries in $\mathbb F_q$, let

$$
D_G=\min(a,b)-\operatorname{rank}(G).
$$

Then

$$
\mathbb E D_G\le\frac1{q-1}.
$$

If $a\le b$, the expected number of nonzero vectors in the left kernel is

$$
(q^a-1)q^{-b}\le1.
$$

This number equals $q^{D_G}-1$, and

$$
q^{D_G}-1\ge(q-1)D_G.
$$

The case $b\le a$ follows by transposition. Zero-dimensional matrices satisfy the same bound trivially.

For $a\ge b$, the full-column-rank probability is

$$
\prod_{j=0}^{b-1}(1-q^{j-a})
\ge\prod_{j=1}^{\infty}(1-q^{-j})>\frac14.
$$

For completeness, at $q=2$ the first two factors multiply to $3/8$. The remaining factors satisfy

$$
\prod_{j=3}^{\infty}(1-2^{-j})
\ge1-\sum_{j=3}^{\infty}2^{-j}=\frac34,
$$

by the finite-product inequality $\prod_i(1-a_i)\ge1-\sum_i a_i$ and passage to the limit. Hence the whole product is at least $9/32>1/4$. Larger $q$ only increases each factor. Conditioning a nonnegative random variable on such a full-rank event therefore multiplies its expected value by at most four.

### Lemma 4.2. Random subspace intersection

Fix a $k$-subspace $U$ of $\mathbb F_q^m$, let $Z$ be a uniform $t$-subspace, and put

$$
D=\dim(U\cap Z),\qquad \delta=(k+t-m)_+.
$$

Then

$$
\mathbb E(D-\delta)\le\frac4{q-1}.
\tag{4.1}
$$

Generate $Z$ as the image of an $m\times t$ iid matrix $G$ conditioned on full column rank. Let $P:\mathbb F_q^m\to\mathbb F_q^m/U$ be a fixed quotient map. Before conditioning, $PG$ is an iid uniform $(m-k)\times t$ matrix after choosing quotient coordinates. On the conditioning event,

$$
D-\delta=\min(t,m-k)-\operatorname{rank}(PG).
$$

Apply Lemma 4.1 and divide by a conditioning probability greater than $1/4$. This proves (4.1) for every $k,t$, including $t=0$ and $k=m$.

### Lemma 4.3. Rank after adding noise with a fixed row space

Fix $X$ of rank $k$ and a $t$-subspace $Z$. Put

$$
D=\dim(\operatorname{row}(X)\cap Z),\qquad
r_D=\min(n,k+t-D).
$$

If $W$ is uniform among matrices with $\operatorname{row}(W)=Z$, then

$$
\mathbb E\!\left[r_D-\operatorname{rank}(X+W)\mid Z\right]
\le\frac4{q-1}.
\tag{4.2}
$$

Choose coordinates in which $Z$ consists of the first $t$ coordinate directions. Write $W=[C\mid0]$, where $C$ is an $n\times t$ iid uniform matrix conditioned on full column rank, and write $X=[X_1\mid X_2]$. The matrix $X_2$ has rank $a=k-D$. Before conditioning $C$, the block $X_1+C$ is iid uniform. Deterministic invertible row operations and operations on the last $m-t$ columns reduce $X_2$ to a rank-$a$ standard block. Subtracting its pivot columns removes the first $a$ entries of each column in the first block. The remaining lower block is an iid uniform $(n-a)\times t$ matrix $G'$. Hence, before conditioning,

$$
\operatorname{rank}(X+W)=a+\operatorname{rank}(G'),
\qquad
r_D=a+\min(n-a,t).
$$

Lemma 4.1 bounds the expected nonnegative defect by $1/(q-1)$. Conditioning $C$ to have full column rank costs at most a factor four. This proves (4.2).

### Lemma 4.4. Joint geometry bounds

Let

$$
r_0=\min(n,m,k+t),\qquad
s_0=r_0-t+\delta=\min(k,n+\delta-t).
$$

For uniform rank-$t$ noise $W$ and any fixed rank-$k$ matrix $X$, put

$$
R=\operatorname{rank}(X+W),\qquad
S=\dim\bigl(\operatorname{row}(X)\cap\operatorname{row}(X+W)\bigr).
$$

Then

$$
\mathbb E|R-r_0|\le\frac8{q-1},\qquad
\mathbb E|S-s_0|\le\frac8{q-1}.
\tag{4.3}
$$

To verify this, write $B=D-\delta\ge0$, $J=r_D-R\ge0$ and $b=r_0-r_D$. We have $0\le b\le B$, so $r_0-R=b+J$. The exact row-space equality

$$
\operatorname{row}(X)+\operatorname{row}(X+W)
=\operatorname{row}(X)+\operatorname{row}(W)
$$

gives $S=R-t+D$. Therefore $S-s_0=B-b-J$. Both absolute differences in (4.3) are at most $B+J$. Apply (4.1) and (4.2). Multiplication by $A$ leaves these row spaces unchanged.

## 5. Proof of Theorem 1 and the arbitrary-law limit

On the rectangle $0\le r,s\le d$, the function $g(r,s)=(m+s-k-r)s$ has coordinate Lipschitz constants $d$ in $r$ and $m+2d$ in $s$. Consequently (4.3) gives

$$
\left|\mathbb E g(R,S)-g(r_0,s_0)\right|
\le\frac{8(m+3d)}{q-1}.
\tag{5.1}
$$

A direct split into $k+t\le\min(m,n)$, $n\mathrel{<}k+t\le m$, and $m\mathrel{<}k+t$ shows

$$
g(r_0,s_0)=(m-k-t)_+\min(k,n-t)=f_{n,m}(k,t).
\tag{5.2}
$$

When $n\ge m$, the middle case is empty. When $k+t>m$, one has $r_0=\min(n,m)$ and $m+s_0-k-r_0=0$. Thus no aspect-ratio restriction is implicit in (5.2). Combining (5.1) with (3.3) proves the uniform fixed-rank bound.

Since $U$ and $T$ are independent under a fixed rank-$k$ input,

$$
\begin{aligned}
I_k^\pi
&=I_q(U;V,T)-I_q(U;T\mid V)\\
&=\mathbb E_T I_{k,T}-I_q(U;T\mid V).
\end{aligned}
$$

The last term lies between zero and $H_q(T)$. Combining this identity with the rank-mixture sandwich in Section 3 and $H_q(T)\le\log_q(d+1)$ proves Theorem 1. Applying the same inequalities to any rank maximizing $\mathbb E f_{n,m}(k,T)$ gives its stated achievable gap.

For Corollary 2, scale $k$ and $T$ by $n$. The functions

$$
(x,z)\longmapsto(\beta-x-z)_+\min(x,1-z)
$$

are continuous and uniformly Lipschitz on a fixed compact set containing the allowed domains for all sufficiently large $n$. Weak convergence of $T_n/n$, convergence of $m_n/n$, and compactness give uniform convergence in $x$ of the expectations. The allowable grid of $k/n$ approaches $[0,\min(1,\beta)]$. The error in Theorem 1 is $O(m_n)=O(n)$ and vanishes after division by $n^2$. This proves the variational limit.

## 6. Binomial tools and global localization

For the rest of the proof, put $\xi_n=T_n-np$. Then $\mathbb E\xi_n=0$ and $\mathbb E\xi_n^2=\sigma^2n$. For $x=k/n$, the deterministic normalized limit is

$$
F_\beta(x)=(\beta-p-x)_+\min(x,u),\qquad 0\le x\le1.
\tag{6.1}
$$

For $\beta\ge1$, this function has a unique maximum at $x=(\beta-p)/2$ if $\beta\mathrel{<}2-p$, and at $x=u$ if $\beta\ge2-p$. Define

$$
F_n(k)=\mathbb E f_{n,m_n}(k,T_n).
$$

Then $F_n(k)/n^2$ converges uniformly to $F_\beta(k/n)$. This follows directly from $\mathbb E|\xi_n|\le\sigma\sqrt n$ and an $O(n)$ Lipschitz constant of the kernel in the error rank. Consequently, any maximizer of $F_n$, and any maximizer of exact fixed-rank mutual information, has $k/n$ converging to the relevant unique maximizer. The latter assertion follows because Theorem 1 and the hidden-rank identity give a uniform $O(n)$ approximation of $I_k^{\pi_n}$ by $F_n(k)$, including the entropy penalty $H_q(T_n)=O(\log n)$.

We need two binomial estimates with specified precision. First, with $Z_n=\xi_n/(\sigma\sqrt n)$ and $Z$ standard normal,

$$
\sup_{\operatorname{Lip}(h)\le1}
\left|\mathbb E h(Z_n)-\mathbb E h(Z)\right|
=O(n^{-1/2}).
\tag{6.2}
$$

The constant may depend on fixed $p$. This is [G10, Theorem 1.1]. For a centered Bernoulli variable $B-p$, the third absolute moment is $p(1-p)[p^2+(1-p)^2]$, so the theorem gives the explicit upper bound

$$
\frac{p^2+(1-p)^2}{\sigma\sqrt n}.
$$

The identity between the one-dimensional $L^1$ distance of distribution functions and the Lipschitz test-function metric follows by integration of tails or monotone coupling. We use (6.2) only for one-sided linear truncations.

Second, for fixed $c\in(0,1)$, uniformly for $0\le h\le c\sigma\sqrt{n\ln n}$,

$$
\mathbb P\!\left(h+\sqrt n\le\xi_n\le h+2\sqrt n\right)
\ge n^{-c^2/2-o(1)}.
\tag{6.3}
$$

To prove (6.3), apply Stirling's formula to the binomial mass at integers $j$ in the indicated interval. Uniformly for $|j-np|=O(\sqrt{n\ln n})$, the natural logarithm of this mass is

$$
-\frac{(j-np)^2}{2\sigma^2n}
-\frac12\ln n+O(1)
+O\!\left(\frac{|j-np|}{n}+\frac{|j-np|^3}{n^2}\right).
$$

Indeed, the mass is $\exp[-nD(j/n\Vert p)]$ divided by $\sqrt{2\pi n(j/n)(1-j/n)}$, times $1+O(1/n)$, with a constant depending on $p$. Taylor expansion of the binary relative entropy $D(\cdot\Vert p)$ gives the displayed expression. The interval contains a constant times $\sqrt n$ integers, and its largest standardized squared deviation is $c^2\ln n+O(\sqrt{\ln n})+O(1)$. Summing the masses proves (6.3). Since $p\in(0,1)$ is fixed, these intervals lie inside the support for all sufficiently large $n$.

Finally, the centered Bernoulli log-moment-generating function satisfies

$$
\ln\mathbb E e^{\lambda(B-p)}
=\frac{\sigma^2\lambda^2}{2}+O(|\lambda|^3)
$$

near zero. The constant again may depend on $p$. Since $y_+\le e^{\lambda y}/\lambda$ for $\lambda>0$, setting $h=\sigma\sqrt{n\ln n}+O(1)$ and $\lambda=h/(\sigma^2n)$ gives

$$
\begin{aligned}
\mathbb E(\xi_n-h)_+
&\le\frac{\sigma^2n}{h}
\exp\!\left[-\frac{h^2}{2\sigma^2n}
+O\!\left(\frac{h^3}{n^2}\right)\right]\\
&=O\!\left(\frac1{\sqrt{\ln n}}\right).
\end{aligned}
\tag{6.4}
$$

For deviations of order a positive constant times $n$, the same exponential-moment method gives exponentially small binomial tails. The moderate-deviation estimate (6.3) is obtained from local masses, rather than by extrapolating a central limit theorem.

## 7. Interior regime

Suppose $1\le\beta\mathrel{<}2-p$ and put $x_0=(\beta-p)/2$. There is a fixed positive distance between $x_0$ and $u$, and between $x_0+p$ and $\beta$. By global localization, all relevant ranks lie in a fixed small neighborhood of $x_0n$. Uniformly on this neighborhood, the events $k+T_n>n$ and $m_n-k-T_n\mathrel{<}0$ have probability $O(e^{-cn})$ for some $c>0$. Off these events,

$$
f_{n,m_n}(k,T_n)=k(m_n-k-T_n).
$$

Since all values are $O(n^2)$,

$$
F_n(k)=k(m_n-k-np)+O(n^2e^{-cn}).
\tag{7.1}
$$

The maximum of the quadratic over integer $k$ is $(m_n-np)^2/4+O(1)$, and a maximizing integer near $(m_n-np)/2$ belongs to the relevant neighborhood. Therefore

$$
\max_k F_n(k)=\frac{(\beta-p)^2}{4}n^2+O(n).
$$

Theorem 1 proves the capacity expansion and the achieving rank. Equation (7.1), its quadratic loss, and the uniform $O(n)$ fixed-rank approximation imply that any exact best fixed rank differs from $(m_n-np)/2$ by $O(\sqrt n)$.

## 8. Boundary-limited regime

Suppose $\beta>2-p$ and put $b=\beta-1>u$. The function (6.1) has strictly positive left derivative $b-u$ at $x=u$ and strictly negative right derivative $-u$ there. After global localization, the deterministic loss away from $un$ is consequently at least a fixed positive constant times $n|k-un|$. The random perturbation changes the objective by $O(n^{3/2})$ uniformly in $k$. Every maximizing rank, including an exact best fixed rank, therefore satisfies $|k-un|=O(\sqrt n)$.

Write $k=un+a\sqrt n$, with $a$ in a fixed compact interval. Rounding $m_n$ changes the kernel by $O(n)$. The event on which the positive part $m_n-k-T_n$ truncates has exponentially small probability because its mean gap is $bn+O(\sqrt n)$. Apart from an $O(n^2e^{-cn})$ contribution, the two factors are

$$
\begin{aligned}
m_n-k-T_n&=bn-(a+\sigma Z_n)\sqrt n+O(1),\\
\min(k,n-T_n)&=un+\min(a,-\sigma Z_n)\sqrt n.
\end{aligned}
$$

The product of the $\sqrt n$ terms has expectation $O(n)$ uniformly on compact $a$-sets, because $\mathbb E Z_n^2=1$. Apply (6.2) to the truncated linear function, whose Lipschitz constant is $\sigma$. Uniformly on compact $a$-sets this gives

$$
\begin{aligned}
F_n(k)&=bu n^2+n^{3/2}G(a)+O(n),\\
G(a)&=b\,\mathbb E\min(a,-\sigma Z)-ua\\
&=b\!\left[a\Phi(-a/\sigma)-\sigma\phi(a/\sigma)\right]-ua.
\end{aligned}
\tag{8.1}
$$

Differentiation yields

$$
G'(a)=b\Phi(-a/\sigma)-u,\qquad
G''(a)=-\frac b\sigma\phi(a/\sigma)\mathrel{<}0.
$$

The unique maximum is thus at

$$
a_*=-\sigma z,\qquad z=\Phi^{-1}(u/b),\qquad
G(a_*)=-b\sigma\phi(z).
$$

The rank grid has $a$-spacing $1/\sqrt n$. Choosing its nearest point to $a_*$ changes the $G$ contribution by $O(\sqrt n)$, within the $O(n)$ remainder. Equation (8.1), localization, and Theorem 1 give the claimed capacity formula and achieving rank. Strict uniqueness of the maximum of $G$, together with the $O(n)$ error, yields $a\to a_*$ for every exact best fixed rank.

## 9. Critical regime

Let $\beta=2-p=1+u$ and $N=un$. Replacing $m_n$ by the real parameter $(1+u)n$ changes every kernel value and its maximum by at most $n$. It suffices to analyze this auxiliary real-parameter kernel. Put $k=N-h$ and $\xi=\xi_n$. The possible values of $h$ form the discrete set

$$
\mathcal H_n=\{un-k:k\in\{0,\ldots,n\}\}.
$$

All rank optimizations in this section use this set. Global localization shows that $h=o(n)$ for every relevant maximizing rank. Fix a sufficiently small constant $\eta>0$ and write

$$
\mathcal H_{n,\eta}=\mathcal H_n\cap[-\eta n,\eta n].
$$

For all sufficiently large $n$, every maximizer of the scalar objective and every exact best fixed rank belongs to this localized feasible set.

Let $\widetilde F_n$ denote the expected auxiliary kernel with first dimension $n$ and real second parameter $(1+u)n$. On $\mathcal H_{n,\eta}$, truncation of its first factor contributes $O(n^2e^{-cn})$ uniformly. The exceptional event is $\xi>N+h$, a deviation bounded below by a positive constant times $n$ when $\eta$ is sufficiently small. Expanding before that truncation gives

$$
\begin{aligned}
\widetilde F_n(N-h)
&=N^2-L_n(h)+O(n^2e^{-cn}),\\
L_n(h)&=h^2+N\mathbb E(\xi-h)_+
-\mathbb E\!\left[(\xi-h)_+^2\right].
\end{aligned}
\tag{9.1}
$$

For $h\ge0$, the first factor never truncates because $\xi\le N$ and $N+h-\xi\ge h$. In this case (9.1) has no truncation error, and

$$
L_n(h)=h^2+\mathbb E\!\left[(N+h-\xi)(\xi-h)_+\right]
\ge h^2.
\tag{9.2}
$$

**Upper bound on the minimal loss.** Choose an admissible rank with $h=\sigma\sqrt{n\ln n}+O(1)$. By (6.4), discarding the negative squared term in (9.1) gives

$$
L_n(h)\le h^2+N\mathbb E(\xi-h)_+
=\sigma^2n\ln n+o(n\ln n).
\tag{9.3}
$$

**Negative $h$ cannot maximize.** For $h\le0$ in the localized interval, the real-variable function $L_n$ is continuous and piecewise differentiable. Away from its finitely many knots,

$$
\begin{aligned}
L_n'(h)
&=2h+2\mathbb E(\xi-h)_+-N\mathbb P(\xi>h)\\
&=2\mathbb E\max(h,\xi)-N\mathbb P(\xi>h).
\end{aligned}
$$

Here $\mathbb E\max(h,\xi)\le\mathbb E\xi_+\le\sigma\sqrt n$, while $\mathbb P(\xi>h)\ge\mathbb P(\xi>0)\to1/2$. Hence $L_n$ is strictly decreasing on this negative interval for all sufficiently large $n$. Continuity extends the conclusion across the knots. Furthermore, (6.2) implies

$$
L_n(0)=N\mathbb E\xi_+-\mathbb E\xi_+^2
=\frac{u\sigma}{\sqrt{2\pi}}n^{3/2}+O(n).
$$

Every $h\le0$ in the localized feasible set therefore has loss of order at least $n^{3/2}$, exceeding the achievable $n\ln n$ loss. The exponentially small error in (9.1) does not affect this comparison.

**Too-small positive $h$ cannot maximize.** Fix $\varepsilon\in(0,1)$, put $c=1-\varepsilon$, and take $0\le h\le c\sigma\sqrt{n\ln n}$. On the event in (6.3), one has $\xi-h\ge\sqrt n$ and $N+h-\xi\ge N/2$ for large $n$. Thus (9.2) gives

$$
\begin{aligned}
L_n(h)
&\ge\frac N2\sqrt n\,
\mathbb P\!\left(h+\sqrt n\le\xi\le h+2\sqrt n\right)\\
&\ge n^{(3-c^2)/2-o(1)}.
\end{aligned}
\tag{9.4}
$$

Because $c\mathrel{<}1$, this exceeds $n\ln n$ by a divergent factor. The bound is uniform for every feasible $h$ in this range.

**All larger $h$.** For $h\ge(1-\varepsilon)\sigma\sqrt{n\ln n}$, equation (9.2) gives

$$
L_n(h)\ge(1-\varepsilon)^2\sigma^2n\ln n.
$$

Equations (9.3)–(9.4), followed by $\varepsilon\downarrow0$, prove

$$
\frac{\min_{h\in\mathcal H_{n,\eta}}L_n(h)}
{\sigma^2n\ln n}\longrightarrow1.
$$

Every minimizing or $O(n)$-near-minimizing $h$ in this localized feasible set satisfies

$$
\frac h{\sigma\sqrt{n\ln n}}\longrightarrow1.
$$

The upper localization follows from $L_n(h)\ge h^2$ and (9.3), and the lower localization follows from (9.4). Since all relevant maximizing ranks were already globally localized, minimizing over $\mathcal H_{n,\eta}$ suffices for the capacity calculation.

Finally restore $\lfloor\beta n\rfloor$, costing $O(n)$, and apply Theorem 1. Its $O(n)$ error is smaller than $n\ln n$. Exact best fixed-rank inputs are $O(n)$-near-maximizers of the scalar objective, so the same rank localization applies. This completes the proof of Theorem 3.

## 10. A global stop-loss identity

In Sections 10–15 we restrict to $m\ge n$ and use $b=m-n$, $N=n-\mathbb ET$ and $d=b-N$. Here $d$ is a geometric offset; the earlier rank cap $\min(n,m)$ equals $n$ in these sections. Expected kernels are denoted by $F_\pi(k)$, and $I_\pi(k)$ is the same fixed-rank mutual information denoted earlier by $I_k^\pi$.

### 10.1. Uniform information error

Theorem 1 supplies a uniform information estimate for the same hidden-rank channel. With

$$
f_{n,m}(k,t)=(m-k-t)_+\min(k,n-t),\qquad
F_\pi(k)=\mathbb E_\pi f_{n,m}(k,T),
$$

and $I_\pi(k)$ the mutual information of a uniform rank-$k$ input, it implies, whenever $n\le m=O(n)$,

$$
\sup_{\pi,k}|I_\pi(k)-F_\pi(k)|\le K_q n,
\qquad
\sup_\pi\left|C_q(n,m,\pi)-\max_kF_\pi(k)\right|\le K_q n.
\tag{10.1}
$$

The constant is uniform over every noise-rank law on $\{0,\ldots,n\}$ and all $k\in\{0,\ldots,n\}$; it may also depend on a fixed upper bound for $m/n$. The first inequality includes the hidden-rank information penalty, which is at most $\log_q(n+1)$. Thus (10.1) does not reveal $T$ as side information. 

### 10.2. Exact identity and remainders

Let $m\ge n$ and $b=m-n$. For scalar analysis, extend the kernel continuously to real $k,D\in[0,n]$ by the formula below; its mutual-information interpretation remains restricted to integer input and noise ranks. With $D=n-T$, this extension agrees with the geometric kernel:

$$
f_{n,m}(k,T)=\min(k,D)(b+D-k)_+.
$$

The following identity is valid pointwise, including where the first positive part truncates:

$$
f_{n,m}(k,T)
=k(b+D-k)-b(k-D)_++(k-D)_+^2
+D(k-D-b)_+.
\tag{10.2}
$$

Indeed, split into $k\le D$, $D\mathrel{<}k\le D+b$, and $k>D+b$. In the middle region, writing $y=k-D$ changes the first three terms into $D(b-y)$; in the last region, the final term cancels this expression. The sign of the final term is positive.

Suppose $\mathbb ET=\mu$, and put

$$
N=n-\mu,\qquad \xi=T-\mu,\qquad d=b-N,\qquad k=N-h.
$$

For every feasible real displacement $h\in[-\mu,N]$, so that $k=N-h\in[0,n]$, taking expectations in (10.2) gives

$$
F_\pi(N-h)=Nb-G_\pi(h)
+\mathbb E(\xi-h)_+^2
+\mathbb E\!\left[(N-\xi)(\xi-b-h)_+\right],
\tag{10.3}
$$

where

$$
G_\pi(h)=h^2+dh+b\mathbb E(\xi-h)_+.
$$

For $h\ge0$, $b>0$, and $\mathbb E\xi^2\le v$, the two extra terms in (10.3) satisfy

$$
0\le\mathbb E(\xi-h)_+^2
+\mathbb E\!\left[(N-\xi)(\xi-b-h)_+\right]
\le v\left(1+\frac n{4b}\right).
\tag{10.4}
$$

For the first term use $(\xi-h)_+^2\le\xi^2$. For the second, $0\le N-\xi=D\le n$ and

$$
(x-c)_+\le\frac{x^2}{4c}\qquad(c>0),
$$

which follows from $(x-2c)^2\ge0$ when $x>c$ and is trivial otherwise. Take $c=b+h\ge b$.

We will also use the second-term bound alone for negative $h$. For any $b+h>0$, the same argument gives

$$
0\le\mathbb E\!\left[(N-\xi)(\xi-b-h)_+\right]
\le\frac{n\mathbb E\xi^2}{4(b+h)}.
\tag{10.5}
$$

In particular this is $O(a_n^2)$ if $b+h\ge c_0n$ and $\mathbb E\xi^2=O(a_n^2)$. The excess-square term in (10.3) need not satisfy this bound when $h$ is negative and must be retained there.

## 11. General convex reduction and optimal fixed-rank localization

For each $n$, let $T_n$ have an arbitrary law on $\{0,\ldots,n\}$. Set

$$
\mu_n=\mathbb E T_n,\quad N_n=n-\mu_n,\quad
\xi_n=T_n-\mu_n,\quad V_n=\mathbb E\xi_n^2.
$$

Suppose

$$
\frac{\mu_n}{n}\longrightarrow p\in(0,1),\qquad u=1-p.
\tag{11.1}
$$

Let $m_n$ be an integer, and define

$$
b_n=m_n-n,\qquad d_n=b_n-N_n.
$$

The symbol $d_n$ in these sections denotes the deviation from the critical geometry, not the maximum possible matrix rank. Assume

$$
d_n=o(n).
\tag{11.2}
$$

Then $b_n/n\to u>0$, so $m_n\ge n$ for all sufficiently large $n$. Every value of $T_n$ is therefore an admissible error rank. Throughout Sections 11–13, assume that, for a deterministic sequence $a_n$,

$$
a_n\longrightarrow\infty,\qquad a_n=o(n),\qquad
V_n\le K a_n^2,\qquad
\frac{\xi_n}{a_n}\Rightarrow Z,\qquad \mathbb P(Z>0)>0,
\tag{11.3}
$$

where $K$ is fixed. The second-moment bound implies uniform integrability of the first moments. In particular,

$$
\mathbb EZ=0,\quad \mathbb EZ^2\le K,\quad
\frac{\mathbb E(\xi_n)_+}{a_n}\longrightarrow
\gamma:=\mathbb EZ_+>0.
\tag{11.4}
$$

Let $I_n(k)$ be the mutual information for a uniform rank-$k$ input with the realization of $T_n$ hidden, and put

$$
F_n(k)=\mathbb E\bigl[(m_n-k-T_n)_+\min(k,n-T_n)\bigr],
\qquad k\in\{0,\ldots,n\}.
$$

Theorem 1 gives

$$
\sup_{0\le k\le n}|I_n(k)-F_n(k)|\le e_n,\qquad
\left|C_q(n,m_n,\pi_n)-\max_{0\le k\le n}F_n(k)\right|\le e_n,
\tag{11.5}
$$

where one may take

$$
e_n=\frac{8(m_n+3n)}{q-1}
       +2\log_q(n+1)+2\log_q4=O(n).
\tag{11.6}
$$

The first inequality includes the hidden-state penalty, bounded by $H_q(T_n)\le\log_q(n+1)$. The second includes the possible advantage from mixing input ranks. Neither inequality reveals the state to the actual receiver.

For use in this section, denote the stop-loss and the two remainder terms by

$$
S_n(h)=\mathbb E(\xi_n-h)_+,\qquad
Q_n(h)=\mathbb E(\xi_n-h)_+^2,\qquad
R_n^{\mathrm{clip}}(h)
=\mathbb E\!\left[(N_n-\xi_n)(\xi_n-b_n-h)_+\right].
$$

Equation (10.3) supplies the exact scalar identity, while (10.4) gives, uniformly for $0\le h\le N_n$,

$$
0\le Q_n(h)+R_n^{\mathrm{clip}}(h)
\le D_n:=V_n\left(1+\frac{n}{4b_n}\right)=O(a_n^2).
\tag{11.7}
$$

### 11.1. The convex objective

Define, for real $h\ge0$,

$$
G_n(h)=h^2+d_nh+b_n\mathbb E(\xi_n-h)_+.
\tag{11.8}
$$

### Theorem 4. Convex reduction with quantitative transfer

Under (11.1)–(11.3), the following statements hold for all sufficiently large $n$.

1. Every maximizer of $F_n(k)$, and every maximizer of $I_n(k)$, has $h=N_n-k>0$.

2. The function $G_n$ has a unique minimizer $h_n^*$ on $[0,\infty)$. It satisfies

$$
0\mathrel{<}h_n^*\mathrel{<}N_n,\qquad h_n^*=o(n),
\tag{11.9}
$$

and the exact quantile inequalities

$$
b_n\mathbb P(\xi_n>h_n^*)
\le 2h_n^*+d_n
\le b_n\mathbb P(\xi_n\ge h_n^*).
\tag{11.10}
$$

Thus restricting the minimization in (11.8) to $[0,N_n]$ does not change its value.

3. Write $G_n^*=G_n(h_n^*)$. With $e_n$ from (11.6) and $D_n$ from (11.7),

$$
N_nb_n-G_n^*-\frac14-e_n
\le C_q(n,m_n,\pi_n)
\le N_nb_n-G_n^*+D_n+e_n.
\tag{11.11}
$$

In particular,

$$
C_q(n,m_n,\pi_n)
=N_nb_n-\min_{h\ge0}G_n(h)+O(n+a_n^2).
\tag{11.12}
$$

4. If $k_n$ maximizes the actual fixed-rank information $I_n(k)$, then

$$
\left|(N_n-k_n)-h_n^*\right|
\le\sqrt{D_n+2e_n+\frac14}
=O\!\left(\sqrt{n+a_n^2}\right).
\tag{11.13}
$$

A uniform input whose rank is a nearest admissible integer to $N_n-h_n^*$ is within $D_n+2e_n+1/4$ of capacity.

#### Proof

**Step 1: global localization precedes all local analysis.**

By (11.1)–(11.3), $T_n/n\to p$ in $L^1$, and $m_n/n\to1+u=2-p$. The normalized kernel is uniformly Lipschitz in the error rank on the relevant compact domains. Therefore, uniformly over the input-rank grid,

$$
\frac{F_n(k)}{n^2}
-F_{\mathrm{crit}}\!\left(\frac{k}{n}\right)\longrightarrow0,
\qquad
F_{\mathrm{crit}}(x)=(2u-x)_+\min(x,u).
\tag{11.14}
$$

The limiting function has a unique maximum at $x=u$. On $x\le u$ it is $x(2u-x)$; on $x\ge u$ it is $u(2u-x)_+$. Compactness and uniqueness imply $k/n\to u$ for every scalar maximizer. The same conclusion holds for every exact best fixed rank by (11.5). Hence

$$
h=N_n-k=o(n)
\tag{11.15}
$$

for every maximizing sequence under either criterion. Equivalently, for any sufficiently small fixed $\eta>0$, all such ranks eventually have $|h|\le\eta n$.

**Step 2: exclude all negative maximizing displacements.**

It is not valid to bound $Q_n(h)$ by $O(a_n^2)$ uniformly for negative $h$. Instead define the exact untruncated loss

$$
L_n(h)=G_n(h)-Q_n(h)
=h^2+d_nh+b_n\mathbb E(\xi_n-h)_+
 -\mathbb E(\xi_n-h)_+^2.
\tag{11.16}
$$

For $|h|\le\eta n$, choose $\eta$ so small that $b_n+h\ge c_0n$ for some fixed $c_0>0$. Then (10.5) gives

$$
F_n(N_n-h)=N_nb_n-L_n(h)+R_n^{\mathrm{clip}}(h),
\qquad 0\le R_n^{\mathrm{clip}}(h)=O(a_n^2)
\tag{11.17}
$$

uniformly in that entire localized interval, including its negative part.

The function $L_n$ is continuous and piecewise differentiable. Away from its finitely many knots,

$$
\begin{aligned}
L_n'(h)
&=2h+d_n-b_n\mathbb P(\xi_n>h)
       +2\mathbb E(\xi_n-h)_+\\
&=2\mathbb E\max(h,\xi_n)+d_n
       -b_n\mathbb P(\xi_n>h).
\end{aligned}
\tag{11.18}
$$

For $h\le0$, $\max(h,\xi_n)\le(\xi_n)_+$. There is a fixed positive lower bound on $\mathbb P(\xi_n>0)$ for large $n$: select $z_0>0$ with $\mathbb P(Z>z_0)>0$ and apply the portmanteau inequality to $(z_0,\infty)$. Thus, uniformly for $h\le0$,

$$
L_n'(h)\le 2\sqrt K\,a_n+|d_n|
            -b_n\mathbb P(\xi_n>0)\le-c_1n
\tag{11.19}
$$

for a fixed $c_1>0$ and sufficiently large $n$. Continuity extends monotonicity across the knots. Consequently $L_n(h)\ge L_n(0)$ for negative $h$, and

$$
\frac{L_n(0)}{na_n}
=\frac{b_n}{n}\frac{\mathbb E(\xi_n)_+}{a_n}
 -\frac{\mathbb E(\xi_n)_+^2}{na_n}
\longrightarrow u\gamma>0.
\tag{11.20}
$$

This argument uses $0$ only as a point of the real-variable function; it need not be a feasible rank-grid displacement.

We now construct a strictly better positive feasible displacement. Choose

$$
t_n=\min\left\{(n/a_n)^{1/4},
                  \sqrt{\frac{n}{|d_n|+1}}\right\}.
$$

Then $t_n\to\infty$, $a_nt_n=o(n)$, and

$$
\frac{a_n}{n}t_n^2\to0,\qquad
\frac{|d_n|}{n}t_n\to0.
$$

At $h=a_nt_n$, the elementary excess bound in Section 10.2 yields

$$
\begin{aligned}
G_n(h)
&\le a_n^2t_n^2+|d_n|a_nt_n
       +\frac{b_nKa_n}{4t_n}
=o(na_n).
\end{aligned}
\tag{11.21}
$$

The feasible grid is

$$
\mathcal H_n=\{N_n-k:k=0,\ldots,n\}.
\tag{11.22}
$$

Rounding $a_nt_n$ to its nearest point in this grid preserves positivity and feasibility for large $n$. It changes $G_n$ by $O(n)$, since on $[0,N_n]$ its Lipschitz constant is at most $2N_n+|d_n|+b_n=O(n)$. As $a_n\to\infty$, this rounding cost is $o(na_n)$. At the rounded point, (10.3) gives

$$
F_n(N_n-h)\ge N_nb_n-G_n(h)
=N_nb_n-o(na_n).
\tag{11.23}
$$

For every localized negative point, (11.17) and (11.20), with $a_n^2=o(na_n)$, give instead

$$
F_n(N_n-h)\le N_nb_n-c_2na_n
\tag{11.24}
$$

for a fixed $c_2>0$. The information error $e_n=O(n)=o(na_n)$ cannot reverse this strict comparison. Step 1 had already placed every scalar or exact fixed-rank maximizer in the localized interval. Thus none can have $h\le0$. This proves statement 1 without assuming that the true capacity-achieving input has a single rank.

**Step 3: convexity, quantile balance, and the rank lattice.**

The stop-loss function is convex, so $G_n$ is 2-strongly convex and coercive. Its one-sided derivatives are

$$
G_{n,+}'(h)=2h+d_n-b_n\mathbb P(\xi_n>h),
\quad
G_{n,-}'(h)=2h+d_n-b_n\mathbb P(\xi_n\ge h).
\tag{11.25}
$$

The right derivative at zero is negative for large $n$, by the same positive-tail argument as in (11.19). Thus the unique minimizer is positive. For any fixed $\varepsilon>0$,

$$
G_{n,-}'(\varepsilon n)
\ge2\varepsilon n-|d_n|
   -\frac{b_nKa_n^2}{\varepsilon^2n^2}>0
\tag{11.26}
$$

eventually. It follows that $h_n^*=o(n)$, so $h_n^*\mathrel{<}N_n$. The subgradient condition at this interior minimum is precisely (11.10). The same argument at any fixed positive $h$, using $a_n\to\infty$, also shows $h_n^*\to\infty$.

Strong convexity and the zero subgradient imply

$$
G_n(h)\ge G_n(h_n^*)+(h-h_n^*)^2
\qquad(h\ge0).
\tag{11.27}
$$

There is a useful exact lattice improvement. The atoms of $\xi_n=T_n-\mu_n$ lie in $\mathbb Z-\mu_n$. The rank lattice is

$$
\mathcal H_n=N_n-\mathbb Z
=(n-\mu_n)-\mathbb Z=\mathbb Z-\mu_n
$$

intersected with its feasible interval. Hence the stop-loss term is affine between any adjacent rank-grid points. On each such open unit interval, $G_n$ is a quadratic with second derivative 2. If $h_n^*$ itself is a grid point, no rounding is needed. Otherwise it lies strictly inside a grid interval, its derivative is zero there, and rounding to the closer endpoint $\widehat h_n$ gives

$$
0\le G_n(\widehat h_n)-G_n(h_n^*)
=(\widehat h_n-h_n^*)^2\le\frac14.
\tag{11.28}
$$

Both endpoints are in $[0,N_n]$ for large $n$, because $h_n^*\to\infty$ and $N_n-h_n^*$ is of linear order. This improvement is not needed for the asymptotic order in (11.12), but makes the integer transfer explicit.

**Step 4: transfer the convex optimum to information and actual best ranks.**

By statement 1, the maximum of $F_n$ occurs at a positive feasible $h$. Equations (10.3), (11.7), and (11.28) therefore imply

$$
N_nb_n-G_n^*-\frac14
\le \max_k F_n(k)
\le N_nb_n-G_n^*+D_n.
\tag{11.29}
$$

Apply (11.5) to obtain (11.11). For an exact best fixed rank $k_n$, set $h_n=N_n-k_n>0$. Its information is at least that of the rounded candidate. Using (11.5) once for each rank gives

$$
G_n(h_n)-G_n^*
\le D_n+2e_n+\frac14.
\tag{11.30}
$$

Equation (11.27) proves (11.13). The same inequalities bound the gap between capacity and the rounded candidate by $D_n+2e_n+1/4$. $\square$

## 12. Stretched-exponential tails and a moving critical point

The next assumptions concern probabilities, not an unknown optimizer or an already integrated stop-loss value. They separate the sharp local logarithmic tail rate from a weaker envelope valid over the full tail.

Fix $r,c>0$, and define

$$
\ell_n=\ln(n/a_n),\qquad
H_n=a_n(\ell_n/c)^{1/r}.
\tag{12.1}
$$

Since $a_n=o(n)$, $\ell_n\to\infty$, $H_n/a_n\to\infty$, and $H_n=o(n)$. Assume:

$$
\frac{\ln\mathbb P(\xi_n>xH_n)}{\ell_n}
\longrightarrow-x^r
\quad\text{for every fixed }x>0;
\tag{W1}
$$

there exist fixed $A,\kappa>0$ such that for all sufficiently large $n$ and all $t\ge a_n$,

$$
\mathbb P(\xi_n>t)\le A\exp[-\kappa(t/a_n)^r].
\tag{W2}
$$

The probabilities in (W1) are consequently positive for sufficiently large $n$. Because $H_n=o(n)$, (W1) is compatible with the finite support of the error rank. It does not impose a sharp Gaussian or Weibull rate at deviations proportional to $n$.

### Theorem 5. Stretched-exponential moving-critical law

Assume (11.1), (11.3), (W1), and (W2), and suppose

$$
\frac{d_n}{H_n}\longrightarrow\lambda\in\mathbb R,\qquad
\frac{n+a_n^2}{H_n^2}\longrightarrow0.
\tag{12.2}
$$

Then

$$
C_q(n,m_n,\pi_n)
=N_nb_n-H_n^2J_W(\lambda)+o(H_n^2),
\tag{12.3}
$$

where

$$
J_W(\lambda)=\min_{x\ge1}(x^2+\lambda x)
=
\begin{cases}
1+\lambda,&\lambda\ge-2,\\
-\lambda^2/4,&\lambda\mathrel{<}-2.
\end{cases}
\tag{12.4}
$$

For every exact best fixed input rank,

$$
\frac{N_n-k_n}{H_n}
\longrightarrow x_W(\lambda):=\max(1,-\lambda/2).
\tag{12.5}
$$

The same limit holds for $h_n^*/H_n$. The correction $J_W$ is signed relative to $N_nb_n$; it is not always a capacity loss. When $J_W=0$, (12.3) does not identify a first nonzero correction.

#### Proof

For a nonnegative threshold, the tail-integral identity is

$$
S_n(h)=\int_h^\infty\mathbb P(\xi_n>t)\,dt.
\tag{12.6}
$$

For each fixed $x>1$, we claim

$$
\frac{b_nS_n(xH_n)}{H_n^2}\longrightarrow0.
\tag{12.7}
$$

Choose a fixed $B>x$. The integral between $xH_n$ and $BH_n$ is at most $BH_n\mathbb P(\xi_n>xH_n)$. Since

$$
\frac{b_n}{H_n}\asymp
e^{\ell_n}\ell_n^{-1/r},
$$

(W1) shows that its contribution to (12.7) tends to zero: its exponential rate is $1-x^r\mathrel{<}0$.

For the remaining integral, (W2) gives

$$
\int_{BH_n}^{\infty}\mathbb P(\xi_n>t)\,dt
\le A a_n\int_{BH_n/a_n}^{\infty}e^{-\kappa y^r}\,dy.
$$

For fixed $r,\kappa>0$, substitution $v=\kappa y^r$ bounds the last integral by $C\exp[-(\kappa/2)(BH_n/a_n)^r]$ for large lower limits: the power of $v$ in the transformed integrand can be absorbed into $e^{v/2}$. Choose $B$ so that $\kappa B^r/(2c)>1$. After multiplication by $b_n/H_n^2$, this bound is at most a constant times

$$
e^{[1-\kappa B^r/(2c)]\ell_n}\ell_n^{-2/r},
$$

which vanishes. This proves (12.7).

For each fixed $0\mathrel{<}x\mathrel{<}1$, choose $y\in(x,1)$. Then

$$
S_n(xH_n)\ge(y-x)H_n\mathbb P(\xi_n>yH_n).
$$

By (W1),

$$
\frac{b_nS_n(xH_n)}{H_n^2}\longrightarrow\infty,
\tag{12.8}
$$

because its exponential rate is $1-y^r>0$. This lower bound also holds uniformly for all $0\le h\le xH_n$, by monotonicity of $S_n$.

Now apply Theorem 4. At any fixed $x>1$, (12.7) gives

$$
\frac{G_n(xH_n)}{H_n^2}\longrightarrow x^2+\lambda x.
\tag{12.9}
$$

Thus $G_n(h_n^*)=O(H_n^2)$. Since $G_n(h)\ge h^2-|d_n|h$, the sequence $h_n^*/H_n$ is bounded above. Equation (12.8) excludes every compact interval below 1. Any subsequential limit $x$ of $h_n^*/H_n$ therefore satisfies $x\ge1$, and nonnegativity of the stop-loss term gives

$$
\liminf\frac{G_n(h_n^*)}{H_n^2}\ge x^2+\lambda x.
$$

Conversely, (12.9) bounds the limit superior by the infimum of $x^2+\lambda x$ over $x>1$, which equals its minimum over $x\ge1$. The constrained quadratic has the unique minimizer $x_W(\lambda)$. Therefore

$$
\frac{G_n(h_n^*)}{H_n^2}\to J_W(\lambda),
\qquad
\frac{h_n^*}{H_n}\to x_W(\lambda).
$$

The scale separation in (12.2), together with (11.11) and (11.13), transfers both limits to capacity and every exact best fixed rank. $\square$

The hypotheses determine the optimizing displacement scale. Under only (W1)–(W2), the exactly chosen threshold $H_n$ need not have a negligible stop-loss term at the boundary $x=1$. The theorem does not assert that every sequence with $h_n/H_n\to1$ attains the displayed expansion. Rounding the actual convex minimizer $h_n^*$ is always valid; stronger explicit tail bounds can justify a simpler boundary prescription.

### 12.1. A binomial moving-critical corollary

### Corollary 5.1. Binomial crossover on the $\sqrt{n\ln n}$ scale

Fix $p\in(0,1)$, put $u=1-p$, $\sigma^2=p(1-p)$, and let $T_n\sim\operatorname{Bin}(n,p)$. Let $m_n=n+b_n$ be integer with

$$
\frac{b_n-un}{\sigma\sqrt{n\ln n}}\longrightarrow\lambda\in\mathbb R.
\tag{12.10}
$$

Then

$$
C_q(n,m_n,\pi_n)
=un\,b_n-\sigma^2n\ln n\,J_W(\lambda)+o(n\ln n),
\tag{12.11}
$$

and every exact best fixed input rank satisfies

$$
\frac{un-k_n}{\sigma\sqrt{n\ln n}}\longrightarrow x_W(\lambda).
\tag{12.12}
$$

Here a uniform input whose rank is nearest to
$un-x_W(\lambda)\sigma\sqrt{n\ln n}$ attains (12.11).

#### Proof

Take $a_n=\sigma\sqrt n$, $r=2$, and $c=1/2$. Then

$$
\ell_n=\ln(n/a_n),\qquad
H_n^2=2\sigma^2n\ell_n
=\sigma^2n\ln n+O(n),
\tag{12.13}
$$

and $(n+a_n^2)/H_n^2\to0$. The central limit theorem and the exact variance give (11.3).

For a fixed $x>0$, put $h=xH_n=O(\sqrt{n\ln n})$. The centered Bernoulli cumulant expansion, followed by Chernoff's bound with parameter $h/(\sigma^2n)$, gives

$$
\ln\mathbb P(\xi_n>h)
\le-\frac{h^2}{2\sigma^2n}
     +O(h^3/n^2)
=-x^2\ell_n+o(\ell_n).
$$

For the reverse logarithmic bound, sum the binomial masses over the interval $[h+a_n,h+2a_n]$, which contains a constant times $\sqrt n$ integers. Stirling's formula gives a local logarithmic mass

$$
-\frac{(j-np)^2}{2\sigma^2n}
-\frac12\ln n+O(1)+O(|j-np|^3/n^2)
$$

uniformly on this interval. Summing cancels the factor $n^{-1/2}$ and yields

$$
\ln\mathbb P(\xi_n>h)
\ge-x^2\ell_n-O(\sqrt{\ell_n})-O(1).
$$

This proves (W1).

For the global envelope, let
$\psi(\theta)=\ln\mathbb E e^{\theta(B-p)}$, where $B$ is Bernoulli with parameter $p$. Exponential tilting gives
$\psi''(\theta)=p_\theta(1-p_\theta)\le1/4$, while
$\psi(0)=\psi'(0)=0$. Thus $\psi(\theta)\le\theta^2/8$. Chernoff optimization gives

$$
\mathbb P(\xi_n>t)\le e^{-2t^2/n}
=\exp[-2\sigma^2(t/a_n)^2],
$$

so (W2) holds with $\kappa=2\sigma^2$. Theorem 5 and (12.13) prove (12.11)–(12.12).

It remains to justify the explicit boundary candidate when $x_W(\lambda)=1$. With $H_n'=\sigma\sqrt{n\ln n}$, the elementary inequality $y_+\le e^{\theta y}/\theta$, and the same cumulant expansion, imply

$$
\mathbb E(\xi_n-H_n')_+
\le\frac{\sigma^2n}{H_n'}
 \exp\!\left[-\frac{(H_n')^2}{2\sigma^2n}
       +O((H_n')^3/n^2)\right]
=O((\ln n)^{-1/2}).
$$

Multiplication by $b_n$ gives $o((H_n')^2)$. If $x_W(\lambda)>1$, the tail-integral estimate (12.7) already gives this conclusion. Hence the stated rank has
$G_n(h)=J_W(\lambda)(H_n')^2+o((H_n')^2)$; nearest-rank rounding costs $O(n)=o((H_n')^2)$, and (11.5), (10.3), and (11.7) transfer the expansion to its actual mutual information. $\square$

This is a moving-geometry result with $\lambda$ fixed. It does not assert uniform validity when $\lambda\to\pm\infty$, or replace the fixed-aspect-ratio formulas away from the critical point.

### 12.2. Legal integer-valued constructions

The following construction accounts for centering, clipping, and the finite support, rather than treating an unbounded continuous variable as a matrix rank.

### Lemma 12.1. Rounding and clipping with actual centering

Let $Z$ be a mean-zero real random variable with $\mathbb EZ^2\mathrel{<}\infty$. Fix $p\in(0,1)$, take $a_n\to\infty$, $a_n=o(n)$, and let $M_n=\lfloor pn\rfloor$. For a nearest-integer rounding map $\operatorname{rnd}$, define

$$
T_n=\min\bigl(n,\max(0,M_n+\operatorname{rnd}(a_nZ))\bigr),
\quad
\mu_n=\mathbb ET_n,\quad
\xi_n=T_n-\mu_n.
\tag{12.14}
$$

Then $T_n$ is an integer in $\{0,\ldots,n\}$, and

$$
\mu_n=M_n+o(a_n),\qquad
\frac{\xi_n}{a_n}\longrightarrow Z\quad\text{in }L^2,
\qquad
\frac{\operatorname{Var}(T_n)}{a_n^2}\longrightarrow\mathbb EZ^2.
\tag{12.15}
$$

In particular, (11.1) and the moment part of (11.3) hold. If $\mathbb P(Z>0)>0$, all of (11.3) holds.

#### Proof

Set $Y_n=(T_n-M_n)/a_n$. It is obtained from
$\operatorname{rnd}(a_nZ)/a_n$ by clipping to an interval whose endpoints tend to $-\infty$ and $+\infty$. Hence $Y_n\to Z$ almost surely. Clipping to an interval containing zero cannot increase absolute value, so
$|Y_n|\le|Z|+1/(2a_n)$. Dominated convergence gives $Y_n\to Z$ in $L^2$. Therefore $\mathbb EY_n\to0$ and
$\xi_n/a_n=Y_n-\mathbb EY_n\to Z$ in $L^2$, proving all the assertions. $\square$

The construction does not claim $\mu_n=pn$ exactly, nor preservation of the variance at finite $n$. All channel geometry below is defined using the actual mean $\mu_n$.

### Example 12.2. Every stretched-exponential exponent

Let $Y\ge0$ have survival function

$$
\mathbb P(Y>y)=e^{-cy^r},\qquad y\ge0,
$$

where $c,r>0$, and set $Z=Y-\mathbb EY$. All moments of $Z$ are finite, and $\mathbb P(Z>0)>0$. Use (12.14) with $a_n=\sqrt n$.

Here $(\mu_n-M_n)/a_n=o(1)$. Whenever $\mu_n+t\mathrel{<}n$, clipping at $n$ does not affect the event $T_n>\mu_n+t$. Integer rounding sandwiches this probability between the original survival probabilities for $Z$ at

$$
\frac{t}{a_n}+\frac{\mu_n-M_n}{a_n}
\pm\frac{1}{2a_n}.
\tag{12.16}
$$

For $t=xH_n$, this threshold is $x(\ell_n/c)^{1/r}+o(1)$; its addition to the fixed shift $\mathbb EY$ gives

$$
\ln\mathbb P(\xi_n>xH_n)
=-x^r\ell_n+o(\ell_n).
$$

All these thresholds are below the clipping level for large $n$, because $H_n=o(n)$. Thus (W1) holds.

For $t/a_n$ sufficiently large, the same sandwich bounds the right tail by $\exp[-\kappa(t/a_n)^r]$ for some fixed $\kappa>0$. A larger multiplicative constant covers the bounded interval $1\le t/a_n\le C$. Above the finite support the probability is zero. Hence (W2) holds uniformly over the entire required tail.

Moreover,

$$
H_n^2=n\left(\frac{\ln(\sqrt n)}{c}\right)^{2/r},
\qquad
\frac{n+a_n^2}{H_n^2}\longrightarrow0.
$$

For any fixed $\lambda$, choose $b_n$ to be a nearest integer to
$N_n+\lambda H_n$, and set $m_n=n+b_n$. Theorem 5 applies. This provides legal integer rank laws with correction scale $n(\ln n)^{2/r}$ and the moving-critical function $J_W$.

## 13. Regularly varying tail windows under the finite-rank constraint

Fix $\alpha>2$ and $c>0$, and set

$$
s_n=\left(\frac{cN_na_n^\alpha}{2}\right)^{1/(\alpha+1)}.
\tag{13.1}
$$

Then $s_n/a_n\to\infty$ and $s_n=o(n)$. Assume the following two probability conditions:

$$
\frac{\mathbb P(\xi_n>s_nx)}
 {c(a_n/s_n)^\alpha}\longrightarrow x^{-\alpha}
\quad\text{for every fixed }x>0;
\tag{R1}
$$

for a fixed $A\mathrel{<}\infty$, all sufficiently large $n$, and all $x\ge1$,

$$
\frac{\mathbb P(\xi_n>s_nx)}
 {c(a_n/s_n)^\alpha}\le A x^{-\alpha}.
\tag{R2}
$$

These conditions refer to a moving tail window below the finite-rank cutoff. They do not say that an individual bounded-support law is regularly varying at infinity. They are satisfied, for example, by the centered, rounded, truncated Pareto construction in Example 13.1.

### Theorem 6. Power-tail moving-critical law

Assume (11.1), (11.3), (R1), and (R2), and suppose

$$
\frac{d_n}{s_n}\longrightarrow\lambda\in\mathbb R,\qquad
\frac{n+a_n^2}{s_n^2}\longrightarrow0.
\tag{13.2}
$$

Then

$$
C_q(n,m_n,\pi_n)
=N_nb_n-s_n^2J_R(\lambda)+o(s_n^2),
\tag{13.3}
$$

where

$$
J_R(\lambda)=
\min_{x>0}\left\{x^2+\lambda x+
                  \frac{2x^{1-\alpha}}{\alpha-1}\right\}.
\tag{13.4}
$$

The minimizing point $x_R(\lambda)$ is unique and satisfies

$$
2x_R(\lambda)+\lambda-2x_R(\lambda)^{-\alpha}=0.
\tag{13.5}
$$

For every exact best fixed rank,

$$
\frac{N_n-k_n}{s_n}\longrightarrow x_R(\lambda).
\tag{13.6}
$$

At $\lambda=0$, $x_R(0)=1$ and
$J_R(0)=(\alpha+1)/(\alpha-1)$. A uniform input with rank nearest to $N_n-s_nx_R(\lambda)$ attains (13.3). As in Theorem 5, $J_R(\lambda)$ is a signed correction relative to $N_nb_n$.

#### Proof

The normalized survival functions in (R1) are nonincreasing in $x$, and their limit $x^{-\alpha}$ is continuous. A finite partition argument therefore upgrades (R1) to uniform convergence on every compact subinterval of $(0,\infty)$: monotonicity bounds the survival function between its values at neighboring partition points, and uniform continuity controls the limiting function between those points.

By (12.6), for fixed $x>0$,

$$
\frac{S_n(s_nx)}{c a_n^\alpha s_n^{1-\alpha}}
=\int_x^\infty
\frac{\mathbb P(\xi_n>s_ny)}
 {c(a_n/s_n)^\alpha}\,dy.
$$

Uniform convergence on compact intervals and the integrable envelope (R2) give, uniformly for $x$ in any compact subinterval of $(0,\infty)$,

$$
\frac{S_n(s_nx)}{c a_n^\alpha s_n^{1-\alpha}}
\longrightarrow\int_x^\infty y^{-\alpha}\,dy
=\frac{x^{1-\alpha}}{\alpha-1}.
\tag{13.7}
$$

This proves the integrated-tail statement directly from probability bounds; it has not been postulated as an optimization hypothesis. Since
$cN_na_n^\alpha=2s_n^{\alpha+1}$ and $b_n/N_n\to1$,

$$
\frac{G_n(s_nx)}{s_n^2}
\longrightarrow Q_\lambda(x)
:=x^2+\lambda x+\frac{2x^{1-\alpha}}{\alpha-1}
\tag{13.8}
$$

uniformly on those compact intervals.

At $x=1$, (13.8) gives a finite candidate value, so $G_n(h_n^*)=O(s_n^2)$. The lower bound $G_n(h)\ge h^2-|d_n|h$ bounds $h_n^*/s_n$ above. It is also bounded away from zero. Indeed, for $h\le\varepsilon s_n$, monotonicity of $S_n$ gives

$$
\frac{G_n(h)}{s_n^2}
\ge-\frac{d_n^2}{4s_n^2}
    +\frac{b_nS_n(\varepsilon s_n)}{s_n^2}.
$$

For fixed $\varepsilon>0$, the second term tends to
$2\varepsilon^{1-\alpha}/(\alpha-1)$, which diverges as $\varepsilon\downarrow0$. Choose a sufficiently small fixed $\varepsilon$ to exceed the candidate bound.

The optimizer is now localized to a fixed compact subset of $(0,\infty)$, where (13.8) is uniform. The function $Q_\lambda$ diverges at both endpoints of $(0,\infty)$ and satisfies

$$
Q_\lambda'(x)=2x+\lambda-2x^{-\alpha},\qquad
Q_\lambda''(x)=2+2\alpha x^{-\alpha-1}>0.
$$

Thus it has the unique minimizer in (13.5), and uniform convergence yields
$G_n^*/s_n^2\to J_R(\lambda)$ and
$h_n^*/s_n\to x_R(\lambda)$. Equations (11.11), (11.13), and the error condition in (13.2) transfer these limits to capacity and every exact best fixed rank. Finally, substituting the explicit fixed value $x_R(\lambda)$ into (13.8), rounding the input rank, and using (11.5) and (11.7) proves the achievable expansion. $\square$

The exponent $\alpha>2$ is used here to give finite-variance examples compatible with (11.3). The tail integral in (13.7) itself only requires $\alpha>1$. No claim is made here for infinite-variance noise scales or for an arbitrary unbounded slowly varying multiplier without an adjusted normalization.

### Example 13.1. Finite-variance regularly varying tails

Fix $\alpha>2$ and $c>0$, and let $Y\ge0$ have survival function

$$
\mathbb P(Y>y)=\left(1+\frac{y}{c^{1/\alpha}}\right)^{-\alpha},
\qquad y\ge0.
$$

Put $Z=Y-\mathbb EY$ and again use (12.14) with $a_n=\sqrt n$. Its second moment is finite, so Lemma 12.1 applies, with actual centered variance converging after division by $a_n^2$.

The centered original tail satisfies
$\mathbb P(Z>y)\sim cy^{-\alpha}$, and is bounded by a constant times $cy^{-\alpha}$ for all sufficiently large $y$. Since $s_n/a_n\to\infty$, the threshold shifts in (12.16) are negligible relative to $s_nx/a_n$, uniformly for $x$ in compact subsets of $(0,\infty)$. Also $s_n=o(n)$, so these compact windows lie below the clipping level. Therefore (R1) holds.

For all $x\ge1$, either the corresponding event is above the finite support and has probability zero, or (12.16) and the original tail bound give

$$
\mathbb P(\xi_n>s_nx)
\le A c(a_n/s_n)^\alpha x^{-\alpha}
$$

with a fixed $A$. This proves (R2), including arbitrarily large $x$. Finally,

$$
s_n^2\asymp n^{(\alpha+2)/(\alpha+1)}
=n^{1+1/(\alpha+1)},
$$

so $(n+a_n^2)/s_n^2\to0$. For any fixed $\lambda$, choose $b_n$ nearest to $N_n+\lambda s_n$, and let $m_n=n+b_n$. Theorem 6 supplies the stated capacity and actual fixed-rank limits for this legal rank law.

## 14. A variance-budget information saddle law

### Theorem 7. Variance-budget information saddle

Fix $q$ and a number $p\in(0,1)$. Let $n\to\infty$, let the means $\mu_n$ be integers with $\mu_n/n\to p$, and let $m_n$ be integers. Set

$$
N_n=n-\mu_n,\quad b_n=m_n-n,\quad d_n=b_n-N_n,
\quad H_n=(N_nv_n)^{1/3},\quad\lambda_n=d_n/H_n.
$$

Assume

$$
\frac{v_n}{\sqrt n}\longrightarrow\infty,
\qquad\frac{v_n}{n^2}\longrightarrow0,
\qquad |\lambda_n|\le L
\tag{14.1}
$$

eventually, for a fixed finite $L$. Consider the class

$$
\mathcal P_n=
\left\{\pi\text{ on }\{0,\ldots,n\}:
\mathbb E_\pi T=\mu_n,\quad
\mathbb E_\pi(T-\mu_n)^2\le v_n\right\}.
$$

Define the one-use information maximin and worst-law capacity

$$
R_n=\max_{P_X}\min_{\pi\in\mathcal P_n}I_\pi(X;Y),
\qquad
U_n=\min_{\pi\in\mathcal P_n}C_q(n,m_n,\pi).
$$

For each real $\lambda$, let $x_\lambda$ be the unique positive solution of

$$
2x+\lambda-\frac1{4x^2}=0,
$$

and put

$$
J(\lambda)=\min_{x>0}\left(x^2+\lambda x+\frac1{4x}\right)
=x_\lambda^2+\lambda x_\lambda+\frac1{4x_\lambda}.
$$

The exact minimax statement applies to every finite legal instance $n\ge1$, $m\ge n$, integer $\mu\in\{0,\ldots,n\}$ and $v\ge0$, independently of the asymptotic scale definitions. Under (14.1), these support and dimension requirements hold for all sufficiently large $n$. For such finite instances,

$$
R_n=U_n,
\tag{14.2}
$$

and under (14.1) their common asymptotic value is

$$
R_n=U_n=N_nb_n-H_n^2J(\lambda_n)+O(n+v_n).
\tag{14.3}
$$

The constant in (14.3) is uniform for $|\lambda_n|\le L$ and for $\mu_n/n$ in any fixed compact subinterval of $(0,1)$. The asymptotic threshold may depend on how the two ratios in (14.1) approach their limits. In particular,

$$
\frac{n+v_n}{H_n^2}\longrightarrow0.
$$

A common uniform input rank

$$
k_n^{\mathrm{com}}=N_n-\operatorname{nint}(x_{\lambda_n}H_n)
\tag{14.4}
$$

attains the lower side of (14.3) for every $\pi\in\mathcal P_n$ simultaneously. Here $\operatorname{nint}$ denotes any nearest integer. A specific law supported on the two integer noise ranks $\mu_n+r_n$ and $\mu_n-\ell_n$ attains the upper side to the same $O(n+v_n)$ error, where

$$
r_n=\operatorname{nint}(2x_{\lambda_n}H_n),\qquad
\ell_n=\left\lfloor\frac{v_n}{r_n}\right\rfloor,
$$

and

$$
\mathbb P(\xi_n=r_n)=\frac{\ell_n}{\ell_n+r_n},\qquad
\mathbb P(\xi_n=-\ell_n)=\frac{r_n}{\ell_n+r_n}.
\tag{14.5}
$$

All these ranks are admissible for sufficiently large $n$. The pair (14.4)–(14.5) is an additive $O(n+v_n)$ information saddle. It need not be an exact saddle or an exact worst law at finite $n$.

At $d_n=0$, one has $x_0=1/2$ and $J(0)=3/4$, so

$$
R_n=U_n=N_n^2-\frac34(N_nv_n)^{2/3}+O(n+v_n),
$$

with common rank retreat $(N_nv_n)^{1/3}/2+O(1)$. If $v_n$ is proportional to $n$, the retreat has order $n^{2/3}$ and the correction has order $n^{4/3}$. For negative $\lambda$, $J(\lambda)$ can be negative; (14.3) is a signed correction relative to $N_nb_n$, not an unconditional loss statement.

### 14.1. Exact minimax equality and existence

For fixed finite dimensions, the input laws form a compact convex simplex. The class $\mathcal P_n$ is a nonempty compact convex polytope: the mass and mean constraints are affine, and at fixed mean the variance constraint is the linear inequality

$$
\sum_{t=0}^n(t-\mu_n)^2\pi_t\le v_n.
$$

It is nonempty because the point mass at the integer $\mu_n$ is admissible.

The transition kernel $W_\pi(y\mid x)$ is affine in $\pi$. Mutual information is jointly continuous on the two finite-dimensional probability sets. For fixed $\pi$ it is concave in $P_X$, since output entropy is concave and conditional entropy is linear in $P_X$. For fixed $P_X$, it is convex in $W_\pi$, hence in $\pi$, by the joint convexity of relative entropy applied to

$$
I_\pi(X;Y)=D_q(P_XW_\pi\Vert P_X(P_XW_\pi)_Y).
$$

Both arguments of the relative entropy are affine in $W_\pi$ when $P_X$ is fixed. Sion's compact convex minimax theorem [Si58, Theorem 3.4] therefore gives (14.2). Compactness and continuity give attaining strategies, and any pair of maximin/minimax optimizers is an exact information saddle. This equality is an application of a classical theorem; the explicit asymptotic value and integer approximation below require separate work.

The elementary inequality $R_n\le U_n$ also holds without invoking minimax and suffices for the asymptotic sandwich proved next.

### 14.2. Uniform scale facts and the scalar optimizer

Suppress subscripts $n$. Since $N\asymp n$, assumptions (14.1) imply

$$
H=o(n),\qquad \frac v{H^2}\to0,
\qquad \frac vH\to\infty,
\qquad \frac n{H^2}\to0.
\tag{14.6}
$$

For example, $v/H=(v^2/N)^{1/3}\to\infty$ follows precisely from $v/\sqrt n\to\infty$. Also $b=N+\lambda H\asymp n>0$ eventually, and consequently $n\le m=O(n)$, as required for (10.1).

The function $x^2+\lambda x+1/(4x)$ tends to infinity as $x\downarrow0$ or $x\to\infty$. Its second derivative is $2+1/(2x^3)>0$. Its unique minimizer solves the displayed equation. By continuity of this solution in $\lambda$, there are constants

$$
0\mathrel{<}x_-\le x_\lambda\le x_+\mathrel{<}\infty
\tag{14.7}
$$

for $|\lambda|\le L$. All subsequent constants may depend on $L$ and these bounds.

### 14.3. The classical centered stop-loss bound

If $\mathbb E\xi=0$ and $\mathbb E\xi^2\le v$, then for $h\ge0$,

$$
\mathbb E(\xi-h)_+
=\frac{\mathbb E|\xi-h|-h}{2}
\le\frac{\sqrt{h^2+v}-h}{2}
=:\psi_v(h).
\tag{14.8}
$$

The inequality is Cauchy–Schwarz. Over unrestricted real-valued laws with variance at most $v$, equality is attained by taking $a=\sqrt{h^2+v}$, placing mass $(a-h)/(2a)$ at $h+a$, and the remaining mass at $h-a$. This law has mean zero, variance $v$, and constant $|\xi-h|=a$. Thus the scalar moment argument itself is classical and exact. Bounded support and integrality are handled separately in Section 14.5.

For $h\asymp H$, Taylor expansion, uniformly using $v/H^2\to0$, gives

$$
\psi_v(h)=\frac v{4h}+O\!\left(\frac{v^2}{h^3}\right).
\tag{14.9}
$$

### 14.4. A simultaneous lower bound from one fixed input rank

Take $h=\operatorname{nint}(x_\lambda H)$. Equations (14.6)–(14.7) make $0\mathrel{<}h\mathrel{<}N$ eventually, so $k=N-h$ is admissible. By (10.3), its nonnegative remainders, and (14.8), every admissible noise law satisfies

$$
F_\pi(N-h)\ge Nb-
\left[h^2+dh+\frac b2\bigl(\sqrt{h^2+v}-h\bigr)\right].
\tag{14.10}
$$

At this integer $h$,

$$
h^2+dh=H^2(x_\lambda^2+\lambda x_\lambda)+O(H),
$$

and, since $Nv=H^3$,

$$
\frac{bv}{4h}=\frac{H^2}{4x_\lambda}+O(v+H).
$$

Here replacing $b=N+d$ by $N$ costs $O(|d|v/H)=O(v)$, and rounding $h$ costs $O(Nv/H^2)=O(H)$. The error from (14.9) is

$$
O\!\left(\frac{bv^2}{H^3}\right)=O(v).
$$

Thus the bracket in (14.10) equals $H^2J(\lambda)+O(n+v)$. Applying the fixed-input estimate in (10.1), uniformly in $\pi$, proves

$$
\inf_{\pi\in\mathcal P_n}I_\pi(k_n^{\mathrm{com}})
\ge Nb-H^2J(\lambda)-O(n+v).
\tag{14.11}
$$

This proves the lower bound for $R_n$ without exchanging an infimum and a maximum and without giving either terminal the realized noise rank.

### 14.5. Construction and admissibility of the integer two-point law

Set $r=\operatorname{nint}(2x_\lambda H)$, $\ell=\lfloor v/r\rfloor$, and $\rho=\ell/(\ell+r)$. Equations (14.6)–(14.7) give

$$
r\asymp H,\quad r=o(n),\quad
\ell\to\infty,\quad
\ell=o(r),\quad\ell=o(n).
\tag{14.12}
$$

For instance, $\ell/r\le v/r^2=O(v/H^2)\to0$, and $\ell/n\le v/(rn)=O(v/(Hn))\to0$. Therefore $1\le\ell\le\mu$ and $1\le r\le N$ eventually. Both support points in (14.5) lie in $\{0,\ldots,n\}$. The mean and variance are exactly

$$
\mathbb E\xi=\rho r-(1-\rho)\ell=0,
\qquad
\mathbb E\xi^2=\ell r\le v.
\tag{14.13}
$$

The variance lost to the floor obeys

$$
0\le v-\ell r\mathrel{<}r.
\tag{14.14}
$$

In addition, $\ell r/v\to1$, because $r/v=O(H/v)\to0$. The mean is exact, not merely asymptotic.

### 14.6. Exact global optimization against the two-point law

The possible values of $h=N-k$ form the integer set $\{-\mu,\ldots,N\}$. Since $b\asymp n$ and $\ell+r=o(n)$, we have $b-\ell-r>0$ for large $n$. On the entire interval $-\ell\le h\le r$, the first kernel factor is consequently positive for both noise atoms. Only the atom $\xi=r$ has positive excess above $h$. Its exact loss relative to $Nb$ is

$$
\begin{aligned}
L(h)&=h^2+dh+b\rho(r-h)-\rho(r-h)^2\\
&=(1-\rho)h^2+(d-b\rho+2\rho r)h
+b\rho r-\rho r^2.
\end{aligned}
\tag{14.15}
$$

This quadratic has positive leading coefficient. Its continuous minimizer is

$$
\begin{aligned}
h_{\mathrm e}
&=\frac{b\rho-2\rho r-d}{2(1-\rho)}\\
&=\frac{N\ell}{2r}-\ell-\frac d2.
\end{aligned}
\tag{14.16}
$$

Writing $\ell=v/r-e$ with $0\le e\mathrel{<}1$ gives the exact expression

$$
h_{\mathrm e}
=\frac{Nv}{2r^2}-\frac vr-\frac d2
-e\left(\frac N{2r}-1\right).
$$

At $r_0=2x_\lambda H$, the first and third terms sum to $x_\lambda H$, by the defining equation for $x_\lambda$. Replacing $r_0$ by $r=r_0+O(1)$ changes $Nv/(2r^2)$ by $O(1)$. The remaining terms are bounded by $O(v/H+n/H+1)$. Hence

$$
h_{\mathrm e}=x_\lambda H+O\!\left(\frac{n+v}{H}\right)
=x_\lambda H+o(H).
\tag{14.17}
$$

It follows uniformly that $0\mathrel{<}h_{\mathrm e}\mathrel{<}r$, with a distance of order $H$ from both endpoints. A nearest integer is feasible, and the increase of (14.15) from integer rounding is at most $(1-\rho)/4\le1/4$.

No global maximum has been missed outside the quadratic interval. If $h\ge r$, both noise atoms lie below $h$, and the exact loss is $h^2+dh$. Its derivative is positive throughout that half-line because

$$
2r+d=(4x_\lambda+\lambda)H+O(1)
=\left(2x_\lambda+\frac1{4x_\lambda^2}\right)H+O(1)>0.
$$

If $h\le-\ell$, then $k=N-h$ is at least each possible residual dimension $D=N-\xi$. For each atom separately the objective is $D(b+h-\xi)_+$, which is nondecreasing in $h$. Thus none of this left region exceeds its value at $h=-\ell$. The global integer optimum is therefore attained by a nearest integer to $h_{\mathrm e}$ in the interior quadratic region.

### 14.7. Uniform control of every integerization error

Let $w=\ell r\le v$, so $v-w\mathrel{<}r$, and set $s=w/r^2=\ell/r$. Then $\rho=s/(1+s)$, and

$$
\left|\rho-\frac v{r^2}\right|
\le\frac{v^2}{r^4}+\frac1r.
\tag{14.18}
$$

For every $h\in[-\ell,r]$, equation (14.12) gives $|r-h|=O(r)$. Using $|b-N|=O(H)$ in (14.18),

$$
\begin{aligned}
\left|b\rho(r-h)-\frac{Nv}{r^2}(r-h)\right|
&\le O\!\left(|d|\frac vr
+\frac{Nv^2}{r^3}+N\right)\\
&=O(n+v).
\end{aligned}
\tag{14.19}
$$

The $N$ term comes from the floor error $v-w\mathrel{<}r$. The term $Nv^2/r^3$ is $O(v)$ because $r^3\asymp H^3=Nv$. Also,

$$
\rho(r-h)^2=O(v).
\tag{14.20}
$$

Finally, replacing $r$ by $r_0=2x_\lambda H$ in $(Nv/r^2)(r-h)$ costs $O(H)$ uniformly for $|h|=O(H)$. This follows by differentiating $Nv/r-Nvh/r^2$ on an interval where $r\asymp H$. Combining (14.15), (14.19), and (14.20) therefore yields the useful uniform square completion

$$
L(h)=H^2J(\lambda)+(h-x_\lambda H)^2+O(n+v),
\qquad -\ell\le h\le r.
\tag{14.21}
$$

Indeed, $\lambda-1/(4x_\lambda^2)=-2x_\lambda$ and
$J(\lambda)=-x_\lambda^2+1/(2x_\lambda)$. Taking the global integer minimum, justified in Section 14.6, proves

$$
\max_kF_{\pi_n^*}(k)
=Nb-H^2J(\lambda)+O(n+v).
\tag{14.22}
$$

### 14.8. Completion of the information sandwich

By (10.1) and (14.22),

$$
U_n\le C_q(n,m,\pi_n^*)
\le Nb-H^2J(\lambda)+O(n+v).
$$

Together with (14.11) and $R_n\le U_n$, this proves (14.3). Combining with the classical exact minimax equality gives (14.2)–(14.3) simultaneously.

More explicitly, with $\mathcal V_n=Nb-H^2J(\lambda)$ and $E_n=n+v$, there is a uniform $K$ such that

$$
I_\pi(k_n^{\mathrm{com}})\ge\mathcal V_n-KE_n
\quad\text{for all }\pi\in\mathcal P_n,
$$

and

$$
I_{\pi_n^*}(P_X)\le\mathcal V_n+KE_n
\quad\text{for all input laws }P_X.
$$

These statements exhibit the claimed approximate information saddle without asserting that the exact minimax input has a single rank.

## 15. A rare-contamination counterexample

### Theorem 8. Contamination with matching mean, leading variance and CLT

Fix $q$, and let $n\to\infty$ through even integers. Put $m=3n/2$ and $N=n/2$. Choose fixed exponents

$$
\frac12\mathrel{<}\theta\mathrel{<}\frac23,
\qquad 2\theta-1\mathrel{<}\alpha\mathrel{<}1-\theta.
\tag{15.1}
$$

Define

$$
r_n=\operatorname{nint}(n^\theta),\qquad
\varepsilon_n=n^{-\alpha},\qquad
\Delta_n=\frac{\varepsilon_nr_n}{1-\varepsilon_n},
\qquad p_n=\frac12-\frac{\Delta_n}{n},
$$

and the integer rank law

$$
\pi_n=(1-\varepsilon_n)\operatorname{Bin}(n,p_n)
+\varepsilon_n\delta_{N+r_n}.
\tag{15.2}
$$

For sufficiently large $n$, this is admissible. It has exactly the same mean as $\pi_n^0=\operatorname{Bin}(n,1/2)$ and the same leading variance:

$$
\mathbb E_{\pi_n}T=N,
\qquad\operatorname{Var}_{\pi_n}(T)=\frac n4+o(n).
\tag{15.3}
$$

Moreover,

$$
\|\pi_n-\pi_n^0\|_{\mathrm{TV}}\longrightarrow0,
\qquad
\frac{T-N}{\sqrt n/2}\ \Rightarrow\ \mathcal N(0,1),
\qquad
\mathbb E_{\pi_n}\left(\frac{T-N}{\sqrt n/2}\right)^2\longrightarrow1.
\tag{15.4}
$$

Despite these properties,

$$
C_q(n,3n/2,\pi_n)
=\frac{n^2}{4}-r_n^2(1+o(1)),
\tag{15.5}
$$

and every rank $k_n$ maximizing the exact fixed-rank mutual information satisfies

$$
\frac{n/2-k_n}{r_n}\longrightarrow1.
\tag{15.6}
$$

By Theorem 3, the uncontaminated law instead has

$$
C_q(n,3n/2,\pi_n^0)
=\frac{n^2}{4}-\frac n4\ln n\,(1+o(1)),
$$

with best-fixed-rank retreat $\frac12\sqrt{n\ln n}\,(1+o(1))$. Since $r_n^2/(n\ln n)\to\infty$, the correction orders differ. Exact variance equality is not claimed. This is a triangular-array statement with increasing channel dimensions, not discontinuity of a fixed finite channel's capacity in its transition law.

### 15.1. Parameter checks, exact mean, and variance

Write $r,\varepsilon,\Delta$ for the quantities above. Conditions (15.1) imply

$$
r=o(n),\quad\varepsilon\to0,\quad
\varepsilon r^2=o(n),\quad
\Delta=o(\sqrt n),\quad
\frac{n\varepsilon}{r}\longrightarrow\infty,
\quad n=o(r^2).
\tag{15.7}
$$

For the fourth assertion, $\alpha>2\theta-1>\theta-1/2$. For the fifth, $\alpha\mathrel{<}1-\theta$. Thus $p_n\in(0,1)$ and $N+r\le n$ for all sufficiently large $n$.

The central binomial component has mean $N-\Delta$. Hence the mixture mean is exactly

$$
(1-\varepsilon)(N-\Delta)+\varepsilon(N+r)=N.
$$

Let $\xi=T-N$. The central component has variance $n/4-\Delta^2/n$, so direct computation gives

$$
\begin{aligned}
\mathbb E\xi^2
&=(1-\varepsilon)\left(\frac n4-\frac{\Delta^2}{n}+\Delta^2\right)
+\varepsilon r^2\\
&=(1-\varepsilon)\frac n4
+\frac{\varepsilon r^2(1-\varepsilon/n)}{1-\varepsilon}
=\frac n4+o(n).
\end{aligned}
\tag{15.8}
$$

This proves (15.3) and convergence of the standardized second moments. In particular, the rare component contributes $\varepsilon r^2=o(n)$ to the variance; there is no hidden leading-order variance inflation.

### 15.2. Total-variation convergence without an external divergence inequality

Let $P_n$ be the law of $n$ independent Bernoulli variables of parameter $1/2-\Delta/n$, and $Q_n$ the fair Bernoulli product law. If $L_n=dP_n/dQ_n$, independence gives the exact identity

$$
\mathbb E_{Q_n}L_n^2
=\left(1+\frac{4\Delta^2}{n^2}\right)^n.
$$

By Cauchy–Schwarz,

$$
\|P_n-Q_n\|_{\mathrm{TV}}
=\frac12\mathbb E_{Q_n}|L_n-1|
\le\frac12\sqrt{\left(1+\frac{4\Delta^2}{n^2}\right)^n-1}
=O(\Delta/\sqrt n)=o(1).
\tag{15.9}
$$

Mapping each binary vector to its sum cannot increase total variation. Mixing in the rare atom costs at most $\varepsilon$. Therefore

$$
\|\pi_n-\pi_n^0\|_{\mathrm{TV}}
\le\varepsilon+O(\Delta/\sqrt n)\longrightarrow0.
$$

The same convergence holds after any common measurable rescaling. The ordinary fair-binomial central limit theorem therefore gives the distributional statement in (15.4). Together with the bounded second moments in (15.8), it also implies uniform integrability of $|\xi|/\sqrt n$ and hence

$$
\mathbb P(\xi>0)\longrightarrow\frac12,
\qquad
\frac{\mathbb E\xi_+}{\sqrt n}
\longrightarrow\frac1{2\sqrt{2\pi}}.
\tag{15.10}
$$

### 15.3. Global localization and the correct treatment of negative retreats

For $k=N-h$, the feasible retreats are integers $h\in\{-N,\ldots,N\}$. Since $\mathbb E|\xi|=O(\sqrt n)$, the kernel's $O(n)$ Lipschitz constant in the noise rank gives

$$
\sup_k\left|F_{\pi_n}(k)-f_{n,3n/2}(k,N)\right|=O(n^{3/2}).
$$

After division by $n^2$, the deterministic limiting objective has its unique maximum at $k/n=1/2$. Equation (10.1) therefore implies $h=o(n)$ for every scalar maximizer and every exact best fixed rank.

Fix a sufficiently small $\eta>0$. On $|h|\le\eta n$, equations (10.3) and (10.5), with $b=N$ and variance $O(n)$, give

$$
F_{\pi_n}(N-h)=N^2-L_n(h)+O(n),
\qquad
L_n(h)=h^2+N\mathbb E(\xi-h)_+
-\mathbb E(\xi-h)_+^2.
\tag{15.11}
$$

The only approximation here is the final clipping correction in (10.3). The excess-square term remains part of $L_n$.

For $h\le0$, the continuous, piecewise differentiable function $L_n$ has derivative, away from its finitely many knots,

$$
L_n'(h)=2\mathbb E\max(h,\xi)-N\mathbb P(\xi>h)
\le2\sqrt{\mathbb E\xi^2}-N\mathbb P(\xi>0)\mathrel{<}-c n
$$

for a fixed $c>0$ and all sufficiently large $n$, by (15.8)–(15.10). Continuity gives monotonicity across the knots. At the origin,

$$
L_n(0)=N\mathbb E\xi_+-\mathbb E\xi_+^2
=\left(\frac1{4\sqrt{2\pi}}+o(1)\right)n^{3/2}.
\tag{15.12}
$$

Consequently every negative feasible $h$ in the localized region has loss at least a fixed positive multiple of $n^{3/2}$, up to the $O(n)$ error in (15.11).

### 15.4. An admissible positive retreat with loss $r_n^2+o(r_n^2)$

Take the feasible integer $h=r$. For all $h\ge0$ the first kernel factor cannot truncate, because $\xi\le N$ and $b=N$. Thus

$$
F_{\pi_n}(N-h)=N^2-L_n(h),
\qquad
L_n(h)=h^2+\mathbb E\!\left[(N+h-\xi)(\xi-h)_+\right]
\ge h^2
\tag{15.13}
$$

exactly. At $h=r$, the rare atom contributes zero to the expectation in (15.13). For the central component $B\sim\operatorname{Bin}(n,p_n)$, the event $\xi>r$ requires $B-\mathbb EB>r+\Delta$.

For completeness, a Bernoulli variable's centered log-mgf has second derivative at most $1/4$ at every real tilt. Integration from zero twice gives a bound $\lambda^2/8$ for that log-mgf. Independence and Chernoff's argument then yield

$$
\mathbb P(B-\mathbb EB>r+\Delta)
\le\exp\!\left[-\frac{2(r+\Delta)^2}{n}\right].
$$

The integrand in (15.13) is $O(n^2)$. Since $r^2/n\to\infty$ as a positive power of $n$, we obtain

$$
L_n(r)=r^2+O\!\left(n^2e^{-2(r+\Delta)^2/n}\right)
=r^2+o(1).
\tag{15.14}
$$

In particular, $r^2=o(n^{3/2})$ because $\theta\mathrel{<}2/3\mathrel{<}3/4$. Equations (15.11)–(15.14) exclude negative $h$ for every scalar or exact-fixed-rank optimizer once $n$ is large.

### 15.5. All positive retreats below or above the rare-atom scale

Fix $\delta\in(0,1)$. For every $0\le h\le(1-\delta)r$, the rare atom alone contributes to (15.13) at least

$$
\varepsilon(N+h-r)(r-h)
\ge\varepsilon(N-r)\delta r
\ge c\delta n\varepsilon r.
\tag{15.15}
$$

Its ratio to $r^2$ diverges by $n\varepsilon/r\to\infty$. Such retreats are uniformly worse than the candidate (15.14), even allowing the $O(n)$ information error.

For every $h\ge(1+\delta)r$, equation (15.13) gives

$$
L_n(h)\ge h^2\ge(1+\delta)^2r^2,
$$

which is again worse than (15.14). Therefore every relevant optimizing retreat has $h/r\to1$. Moreover, for any fixed $\delta>0$, all remaining admissible nonnegative retreats satisfy $L_n(h)\ge(1-\delta)^2r^2$. Combining this with (15.14), and then sending $\delta\downarrow0$, proves

$$
\max_kF_{\pi_n}(k)=N^2-r^2(1+o(1)).
$$

Because $O(n)=o(r^2)$, (10.1) proves (15.5). An exact best fixed rank is an $O(n)$-near-maximizer of $F_{\pi_n}$; all exclusions above remain valid for such ranks and prove (15.6).

## 16. Interpretation, parameter ranges and limitations

The uniform theorem gives a scalar approximation to Gamma-channel capacity with explicit additive error $O_q(m)$. In proportional growth, it identifies the $n^2$-normalized capacity limit for every convergent scaled error-rank law. A zero normalized limit requires a separate analysis to identify the first nonzero asymptotic scale. Example 2.1 shows that even the leading limit can depend on the entire error-rank distribution, despite identical means.

For binomial errors, substituting the mean rank retains the $n^2$ term but can miss the dominant subleading loss and the input-rank offset. The boundary-limited regime selects a Gaussian quantile and incurs an $n^{3/2}$ correction. At the threshold, the rank offset reaches the moderate-deviation scale $\sqrt{n\ln n}$. Theorems 4–6 express this sensitivity through an explicit stop-loss objective and distinguish stretched-exponential and power-law tails. Their tail hypotheses are stronger than a central limit theorem. Theorem 8 shows that exact means, matching leading variances, the same CLT, second-moment convergence and vanishing total variation do not suffice to fix the critical correction.

Theorem 7 concerns a finite one-use information game under a mean and variance budget. Exact equality of its maximin and minimax values is classical convex-concave minimax. The common fixed-rank strategy and integer two-point adversary achieve its explicit asymptotic value with error $O(n+v_n)$; they are not asserted to form an exact finite-size saddle. The asymptotic window is $\sqrt n=o(v_n)$, $v_n=o(n^2)$, with bounded $d_n/(N_nv_n)^{1/3}$ and mean fraction bounded away from zero and one. The signed correction can be negative relative to $N_nb_n$.

All claims have their stated parameter scope. The binomial theorem assumes fixed $q,p,\beta$ and $\beta\ge1$. The local reduction requires a nondegenerate positive limiting tail and a uniform second-moment bound. Each tail theorem imposes an additional moving-scale tail condition, a controlling tail envelope, and an error scale smaller than its retained correction. The rare-contamination construction uses even $n$ and the specified open exponent interval; its variance agreement is asymptotic, not exact. The explicit integer-valued examples include the effects of truncation, rounding and centering.

The results do not determine exact finite-$n$ capacity, optimize the universal constants in Theorem 1, provide efficient encoders or decoders, cover adversarial error sequences or noninvertible transfer matrices, or establish finite-blocklength error exponents. They do not identify an operational compound-channel coding capacity, nor assert that every exact capacity optimizer uses a single input rank.

### Limits of the literature comparison

The comparison is bounded by the primary sources examined. Two identifiable works were not available in primary full text:

- Michael Cyran's *Channel Coding and Precoding for Linear Network Coding*, identifiable in an [institutional defence record](https://www.apps.tf.fau.de/jahresbericht/2016-17/promotionen/liste.php).
- C. Liu, X. Li, B. Zhou and W. H. Mow, *On the Minimum Subspace Coding Capacity of Multiplicative Finite-Field Matrix Channels with a Given Rank Distribution*, APCC 2016, pp. 302–306, DOI [10.1109/APCC.2016.7581511](https://doi.org/10.1109/APCC.2016.7581511). The [HKUST institutional description](https://ece.hkust.edu.hk/news/paper-prof-wai-ho-mow-and-his-research-students-received-apcc16-best-paper-award) verifies the title and authors and describes a subspace-coding lower bound attained by worst-case network scenarios.

The second work's title and institutional description concern multiplicative matrix channels with a given rank distribution. They do not permit a theorem-by-theorem exclusion of overlap without the full paper. No assertion is made that either unavailable work lacks an equivalent result, and neither is used as a premise of the proofs. Forward-citation access was also incomplete. Absence of an encountered competing theorem is not proof of worldwide novelty. Scarf's moment extremum, Sion's minimax theorem, and the robust-tail and contamination methods of [DDN21] remain explicit methodological precedents.

## 17. Verification scope

Theorem 1 covers every finite field size $q\ge2$, positive dimensions in both aspect-ratio directions, and all admissible input and error ranks, including zero and full ranks. The proof retains the hidden-rank information penalty and the orbit conditional entropy. The binomial and general tail arguments establish global optimizer localization before using their local approximations. The variance-budget proof retains the bounded integer noise support, exact mean, variance inequality and every integerization error.

The supplementary program `code/verify_research.py`, with results in `results/research_checks.json`, examines 47 finite fixed-rank cases over $\mathbb F_2$, including orbit counts and floating-point entropy cross-checks. It performs 7,452 exact matrix-identity assertions, 56,372 integer checks of the global positive-part identity, and 236 comparisons of the binomial truncated-moment evaluator with direct finite sums. Its 21 binomial scalar-kernel diagnostics use exhaustive input-rank comparison only when $n\le1600$; the larger instances use a bounded scalar search and a local integer neighborhood, and are not exhaustive global-optimality certificates.

The supplementary program `code/verify_robust_capacity.py` records its results in `results/robust_capacity_checks.json`. Its scope comprises 18,516 exact-rational evaluations of the global kernel identity; 972 comparisons of an independently implemented piecewise-quadratic two-point maximum with exhaustive input-rank enumeration; 26 finite two-point asymptotic diagnostics; and four finite scalar-kernel minimax linear programs. The linear programs use the geometric kernel, not exact channel mutual information. These checks verify the stated finite cases and provide numerical diagnostics; they do not prove the universal asymptotic results, certify exact finite-channel capacities, or replace the written arguments.

The manuscript has not received external peer review, and no Lean formalization or computer-checked proof is claimed. Existing channel models, symmetrization, subspace counting, entropy comparisons, fixed-error-rank leading kernels and standard probabilistic or optimization tools are attributed to their earlier sources.
