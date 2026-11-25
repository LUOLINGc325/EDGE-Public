---
title: "Noncommuting Markov aliases on a fixed cubic graph of girth six"
subtitle: "An exact classification and unbounded ambiguity in entropy production"
lang: en
geometry: margin=1in
fontsize: 11pt
---

## Abstract

Can one recover a continuous-time Markov generator from an exactly known sampled transition matrix and a known sparse topology? We give a fixed 16-state cubic graph of girth six on which a single sample can have arbitrarily many pairwise noncommuting, strictly bidirectional generators with distinct stationary entropy production rates. The sampled transition matrix is strictly positive, symmetric, and positive definite. No reversible generator has that transition matrix. For the exhibited data we classify *every* strictly positive bidirectional generator on the known graph. The exact alias set is a bounded range of signed solutions of a negative Pell equation, determined by the sampled matrix. A Fourier calculation finds the aliases, and an analysis of modulations of individual rates excludes every competitor outside the rotation-invariant family.

## 1. Problem and statements

Fix a sampling lag $\Delta>0$. We use the row convention: a real generator $Q$ has nonnegative off-diagonal entries and $Q\mathbf 1=0$. Its observed transition matrix is $P=e^{\Delta Q}$. The support in this work is known and includes both orientations of every edge of a simple undirected graph. For an irreducible generator with stationary law $\rho$, the stationary entropy production in natural logarithm units is
$$\sigma(Q)=\sum_{\{v,w\}}\left(\rho_v Q_{vw}-\rho_w Q_{wv}\right)
\log\frac{\rho_v Q_{vw}}{\rho_w Q_{wv}},$$
where the sum is over supported undirected edges. This expression is independent of the representative orientation.

An archived reconstruction theorem determines supported generators on connected triangle- and quadrilateral-free graphs from nonderogatory observations, apart from specified homogeneous six-cycle aliases. It explicitly leaves derogatory observations outside its classification. We ask whether that restriction can be dropped for graphs with branching, and how many distinct entropy production rates can be compatible with one sampled matrix. This has different quantifiers from recovering candidate logarithms without known topology. Archived reconstruction theorem and exact scope

Let $G$ have vertices $A_i,B_i$, $i\in\mathbb Z/8$. Its undirected edges are $A_iA_{i+1}$, $B_iB_{i+3}$ and $A_iB_i$. Write $c=2\pi/\Delta$, and choose $s>\sqrt2 c$. For each real $d$ with $|d|<s$, let $Q(d)$ have rates $(s+d)/2$ along the positive layer steps $+1,+3$ and $(s-d)/2$ along the negative steps. Both directions of every spoke have rate $c$. All diagonal entries are $-(s+c)$. Write $P_s=e^{\Delta Q(\sqrt2 c)}$.

**Theorem.** The graph $G$ is connected, cubic and has girth six. The matrix $P_s$ is strictly positive, symmetric and positive definite. Among all strictly positive bidirectional generators on this fixed support, the exact fiber over $P_s$ consists of the matrices $Q(d)$ with
$$d=\sqrt2 c\, k,\qquad k\in\mathbb Z,\qquad \ell^2-2k^2=-1
\ \text{for some }\ell\in\mathbb N,\qquad |d|<s.$$
Every two distinct members of this fiber fail to commute. The entropy of each is $d\log((s+d)/(s-d))$, strictly increasing in $|d|$ on its allowed range. In particular, for each integer $H\ge1$ and each $R>0$ one can choose $s$ so that a *single* $P_s$ has at least $H$ different compatible entropy rates and the largest minus the smallest exceeds $R$. Each fixed $s$ gives a finite fiber. No reversible Markov generator on any support has transition matrix $P_s$.

There is also a linear statement before imposing matrix exponentiation. The real matrices $R$ with $R\mathbf1=0$, all forbidden off-diagonals zero and $[R,P_s]=0$ form exactly the two-dimensional space spanned by $Q(0)$ and $K=\partial Q(d)/\partial d$.

## 2. Graph and observed Fourier blocks

The two layers are cycles of length eight, since $3$ is coprime to $8$. The spokes join them. The graph is bipartite: color $A_i$ by the parity of $i$, and $B_i$ by the opposite parity. A four-cycle with two spokes would require one layer edge in each layer between the same indices, which is impossible because $\pm1$ and $\pm3$ are disjoint modulo eight. A cycle with four spokes and length four is impossible because the spokes form a matching. A six-cycle is
$$A_0,A_1,A_2,A_3,B_3,B_0,A_0.$$
These observations prove the graph properties.

Let $\theta_j=2\pi j/8$. On vectors proportional to $e^{i\theta_j i}$ on each layer, the $2\times2$ matrix of $Q(d)$ is
$$
Q_j(d)=
\begin{pmatrix}
s(\cos\theta_j-1)-c+i d\sin\theta_j & c\\
c & s(\cos3\theta_j-1)-c+i d\sin3\theta_j
\end{pmatrix}.
$$
Put $X=\begin{pmatrix}0&1\\1&0\end{pmatrix}$, $Z=\operatorname{diag}(1,-1)$ and $\alpha=-s-c$. Let $B=\Delta^{-1}\log P_s$, initially interpreted blockwise as the symmetric logarithm of a positive definite matrix.

For odd $j$, $\cos3\theta_j=-\cos\theta_j$, $\sin3\theta_j=\sin\theta_j$, and $|\sin\theta_j|=1/\sqrt2$. Thus the imaginary term of $Q_j(\sqrt2 c)$ is scalar and its exponential over $\Delta$ is one. The real block giving the sample is $B_j=\alpha I+cX+s\cos\theta_j Z$. The blocks at $j=0,4$ are real symmetric from the start:
$$B_0=-cI+cX,\qquad B_4=(-2s-c)I+cX.$$
For $j=2,6$, the mean diagonal is $\alpha$ and the remaining block is $cX+i d\sin\theta_j Z$. Its square is $(c^2-d^2)I$. At the baseline $d=\sqrt2 c$ this is $-c^2I$, and $\Delta c=2\pi$ gives exponential $I$ for the remaining block. Hence $B_2=B_6=\alpha I$.

Each block of $P_s$ equals $e^{\Delta B_j}$ for real symmetric $B_j$. The Fourier transform is unitary, and $P_s$ is real as the exponential of a real matrix. This gives symmetry and positive definiteness, and justifies the principal logarithm used above. Strict entrywise positivity holds because $Q(\sqrt2 c)+(s+c)I$ is a nonnegative matrix with a connected directed support. The exponential series has a strictly positive term between any pair of vertices.

## 3. The supported commutant

A matrix commuting with $P_s$ commutes with $B$. Indeed $B$ is a polynomial of $P_s$ obtained by interpolation on its finitely many distinct positive eigenvalues. We analyze any zero-row-sum matrix $R$ with the allowed off-diagonals, without sign assumptions.

At each layer let the two directional rate functions and the outgoing spoke rate function be arbitrary functions of $i$. Take their finite Fourier transforms. For a fixed frequency of modulation $h\in\mathbb Z/8$, let the three coefficients on the first layer be $a_h,b_h,u_h$, and on the second layer $\tilde a_h,\tilde b_h,\tilde u_h$. The mode $h$ sends frequency $j$ to $j+h$ with matrix
$$
D_{h,j}=
\begin{pmatrix}
a_h(e^{i\theta_j}-1)+b_h(e^{-i\theta_j}-1)-u_h & u_h\\
\tilde u_h & \tilde a_h(e^{3i\theta_j}-1)+\tilde b_h(e^{-3i\theta_j}-1)-\tilde u_h
\end{pmatrix}.
$$
The subtracted terms follow from row sums zero. Commutation is exactly
$$B_{j+h}D_{h,j}=D_{h,j}B_j\quad\text{for each }h,j.$$
For real symmetric blocks with disjoint spectra an intertwiner is zero, by diagonalizing both blocks.

For odd $h$, take $j=2,6$. Both source blocks are $\alpha I$ and both target blocks have eigenvalues $\alpha\pm\sqrt{c^2+s^2/2}$, distinct from $\alpha$. Thus $D_{h,2}=D_{h,6}=0$. The off-diagonals imply $u_h=\tilde u_h=0$. The two diagonal equations on each layer have coefficients $(-1+i,-1-i)$ and $(-1-i,-1+i)$, possibly interchanged on the second layer. They are independent, so all rates in mode $h$ vanish.

For nonzero even $h$, take $j=0,4$. The three disjoint spectral groups for $j$ even have spectra
$$\{0,-2c\},\quad\{\alpha\},\quad\{-2s,-2s-2c\}.$$
They are disjoint because $s>c$. The shifts of $0$ and $4$ under nonzero even $h$ land in different groups. Thus $D_{h,0}=D_{h,4}=0$. The spoke coefficients vanish, and at $j=4$ the diagonal equations give $a_h+b_h=\tilde a_h+\tilde b_h=0$. If $h=2$ or $6$, then $j=2$ maps to frequency $0$ or $4$. Again the spectra are disjoint, and the diagonal equation at $j=2$ forces each difference to vanish. If $h=4$, consider $j=1$. Here $D_{h,1}$ is diagonal and $B_5=\alpha I+cX-s\cos\theta_1 Z$ while $B_1=\alpha I+cX+s\cos\theta_1 Z$. The diagonal entries of the intertwiner equation give $2s\cos\theta_1$ times each diagonal entry of $D_{h,1}$ equal to zero. Since $\cos\theta_1=1/\sqrt2$, that matrix vanishes and both directional differences vanish. This exhausts all modulations. Every candidate is invariant under simultaneous rotations of the two layers.

For the surviving $h=0$, commutation at $j=0$ requires the two spoke coefficients to have a common value $c'$, by comparing diagonal entries with $-cI+cX$. At $j=4$, the two layer sums must be equal, since the off-diagonal coefficients already agree and the block commutes with $X$. Call the common sum $s'$. Let the respective layer biases be $d_A,d_B$. In an odd mode the nonscalar part of $R_j$ is
$$c' X + \left(s'\cos\theta_j + \tfrac i2 (d_A-d_B)\sin\theta_j\right)Z.$$
It commutes with $cX+s\cos\theta_j Z$ if and only if $c s'=s c'$ and $d_A=d_B$, by comparing the real and imaginary coefficients of $[X,Z]$. Thus $R=(c'/c)Q(0)+dK$ for $d=d_A=d_B$. Conversely all such matrices commute with $B$ by its displayed blocks, and hence with $P_s$. This proves the supported commutant statement without assuming that logs of the observed matrix commute with each other.

## 4. Exact exponential fiber and entropy rates

Any generator $R$ with exponential $P_s$ commutes with $P_s$. The preceding section gives $R=(c'/c)Q(0)+dK$. Its block at $j=0$ has eigenvalues $0,-2c'$, with fixed eigenvectors. Equality of the block exponentials implies $c'=c$ by injectivity of the real exponential. Strictly positive supported rates then require precisely $|d|<s$.

For odd $j$, the condition that the block exponential equal that of $P_s$ is $e^{i\Delta d/\sqrt2}=1$, equivalent to $d=\sqrt2 c k$ with integer $k$. For $j=2$ or $6$, equality requires
$$\exp\!\left(\Delta(cX+i d\sin\theta_j Z)\right)=I.$$
When $d^2<c^2$ the off-diagonal part of this exponential is nonzero by the hyperbolic sine formula. At $d^2=c^2$ the exponential is $I$ plus the nonzero nilpotent part. When $d^2>c^2$, put $w=\sqrt{d^2-c^2}>0$. The exponential equals
$$\cos(\Delta w)I+\frac{\sin(\Delta w)}w(cX+i d\sin\theta_j Z).$$
Since $c>0$, equality to $I$ is equivalent to $\Delta w\in2\pi\mathbb N$ with positive integer multiple. Substituting $d=\sqrt2 c k$ and $w=c\ell$ gives the negative Pell equation in the theorem. All conditions are sufficient in every block, so the fiber classification is exact.

At $j=2$, the commutator between different aliases is $ic(d'-d)[X,Z]\ne0$. On the full graph all generators in the family have stationary law uniform on the sixteen vertices because the total incoming and outgoing rates are both $s+c$ at each vertex. The eight edges in each layer have net flow $d/16$ and forward/backward ratio $(s+d)/(s-d)$. The spokes have no net flow. Summing gives the stated entropy. For $0<d<s$ its derivative is
$$\log\frac{s+d}{s-d}+\frac{2sd}{s^2-d^2}>0.$$
The expression is even in $d$, giving the monotonicity in its magnitude.

Starting with $(\ell,k)=(1,1)$, the integer transformation
$$(\ell,k)\mapsto(3\ell+4k,\,2\ell+3k)$$
preserves $\ell^2-2k^2$ and strictly increases both positive coordinates. Thus there are arbitrarily many distinct positive biases. If $s$ approaches a chosen higher bias from above, the entropy at that bias diverges, while it stays finite at the smallest bias. Choose a higher bias with enough predecessors to meet the desired count. Each such $s$ determines a single common observation, and the finite interval $|d|<s$ bounds the number of admissible integers $k$.


The same recurrence gives every positive solution. If $k>1$, then $k\ge3$, since $k=2$ would require $\ell^2=7$. The inverse map $(\ell,k)\mapsto(3\ell-4k,3k-2\ell)$ has positive integer entries, preserves the equation and strictly decreases $k$. In fact $4/3<\ell/k<3/2$, and $\ell>k$. This descends to $(1,1)$. Writing $\alpha_j=(1+\sqrt2)(3+2\sqrt2)^j$, the biases of positive sign are $d_j=(c/2)(\alpha_j+\alpha_j^{-1})$. Therefore the exact number of distinct compatible entropy rates at $s$ is
$$\left\lceil\frac{\log\big((s/c+\sqrt{(s/c)^2-1})/(1+\sqrt2)\big)}{\log(3+2\sqrt2)}\right\rceil.$$
The strict inequality in the definition $d_j<s$ is accounted for by the ceiling, even at an exact Pell threshold.

## 5. No reversible embedding

Any reversible generator $\widetilde Q$ with exponential $P_s$ has a stationary distribution that is also stationary for $P_s$. For a reversible finite generator that distribution exists, and $P_s$ strictly positive implies it must be uniform. Hence $\widetilde Q$ would be symmetric. A real symmetric logarithm of a positive definite matrix is its principal logarithm, as follows by orthogonal diagonalization and injectivity of the scalar exponential. Thus $\widetilde Q$ must be $B$.

The displayed blocks show that $B$ agrees with $Q(0)$ except that the cross-layer matrix $cX$ is deleted in modes $2,6$. If $\Pi_{\{2,6\}}$ is the Fourier projector in the index variable, then
$$B=Q(0)-c\,\Pi_{\{2,6\}}\otimes X,\qquad
(\Pi_{\{2,6\}})_{i,i+4}=\frac18(e^{2\pi i\,2\cdot4/8}+e^{2\pi i\,6\cdot4/8})=\frac14.$$
In this expression the tensor coordinates are ordered by index and layer. As $Q(0)_{A_i B_{i+4}}=0$, the entry $B_{A_i B_{i+4}}=-c/4$ is negative. It is off diagonal in the full vertex set. Therefore $B$ is not a Markov generator, even if all supports were allowed. The observed chain is reversible, but every admissible continuous-time embedding is irreversible.

## 6. Contribution, sources, and verification

The fixed previous study has a one-dimensional zero-row-sum, support-constrained commutant of the generator on branching networks of this girth. Its inference step uses that any two matrices commuting with a nonderogatory sampled matrix commute with each other. The present sampled matrices have repeated eigenvalues. Their *sampled* supported commutant is two-dimensional, and its admissible logarithms do fail to commute. Thus unconditional uniqueness on the same branching graph class is false. The result is a fixed-topology exact negative answer, including all rate assignments compatible with this particular family of observations. It makes no classification claim for every derogatory observation or every sparse graph.

The archived homogeneous six-cycle formulas already imply arbitrarily many distinct entropy rates and arbitrarily large entropy spread across a family of single observations. Those generators commute. The result here concerns pairwise noncommuting aliases on a cubic support and excludes reversible continuous-time embeddings of the exhibited positive-definite observations. General matrix-logarithm and Markov-embedding results motivate the spectral mechanism. It is the Fourier modulation argument that excludes all rates outside that rotation-invariant family on the specified support. The source comparison is bounded to the previously archived reconstruction study and its recorded primary-literature checks. No literature priority beyond that scope is claimed. The exact finite certificate checks graph girth, integer Pell arithmetic, and the supported-commutant rank at representative rational scales. Lean verification is a separate deliverable.

- earlier research manuscript. *Topology rigidity in stroboscopic Markov reconstruction*. §§4–6, 9. Fixed archived manuscript.
- M. T. Bauer, U. Seifert and J. van der Meer. *Stroboscopic measurements in Markov networks: Exact generator reconstruction vs. thermodynamic inference*. Journal of Physics A 58, 125001 (2025). [Archived reference](https://arxiv.org/html/2412.15642v2).
- M. Baake and J. Sumner. *Embedding of Markov matrices for $d\le4$*. Journal of Mathematical Biology 89, 23 (2024). [Archived reference](https://doi.org/10.1007/s00285-024-02112-w).
