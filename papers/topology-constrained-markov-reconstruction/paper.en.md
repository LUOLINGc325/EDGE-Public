---
title: "Topology rigidity in stroboscopic Markov reconstruction"
subtitle: "A supported-commutant classification, the six-cycle exception, and deterministic noise bounds"
author: "AI-assisted research draft"
date: "24 November 2026"
---

# Abstract

Recovering a continuous-time Markov generator from a transition matrix observed at one fixed sampling interval can require choosing among several matrix logarithms. Known forbidden transitions provide extra information, but a numerical rank condition alone does not explain which network topologies guarantee uniqueness. We prove an explicit structural result. On every finite connected simple undirected graph without triangles or quadrilaterals, the real zero-row-sum matrices supported on its edges and commuting with a strictly positive bidirectional generator form a one-dimensional space, except when the graph is a cycle with spatially constant clockwise and counterclockwise rates. The exceptional space is two-dimensional. If the observed transition matrix is nonderogatory, this classification gives a linear reconstruction with its scale fixed by the scalar log determinant. Among homogeneous cycles of length at least five, only the six-cycle permits distinct positive rates with identical fixed-lag observations; we give the exact finite alias set and its entropy production values. We also derive a computable deterministic rate-error bound from a justified operator-norm measurement error. Independent exact graph and symbolic checks, numerical reconstructions, and explicit ill-conditioning examples accompany the proof. The contribution is the graph classification and its fixed-lag application; commutator estimation, spectral-template inference, and logarithm-based thermodynamic inference are established prior methods. This is a public research draft, not an externally peer-reviewed result or an end-to-end formal proof.

# 1. Research question and relation to prior work

Let a finite-state, time-homogeneous Markov process be observed only at times separated by a known lag $\Delta>0$. Its exact sampled transition matrix is

$$P=\exp(\Delta Q),$$

where $Q$ is the unknown continuous-time generator. Recovering $Q$ also recovers its stationary distribution, cycle affinities, and stationary entropy production. Several generators can have the same exponential, so taking the principal logarithm need not identify the physical rates.

Bauer, Seifert, and van der Meer [B25, Section 5] explicitly identify the efficient use of additional network-topology information as an open direction in stroboscopic thermodynamic inference. Their branch-enumeration method can first generate candidates and then filter them by topology. Our selected subproblem is to identify an explicit graph class for which topology removes that enumeration and to determine its structural exceptions. The particular no-triangle/no-quadrilateral theorem below is our scoped mathematical formulation; it is not a conjecture stated verbatim in [B25], and we do not claim to resolve the entire open direction.

The inference principle has substantial prior art. Barsotti et al. [BDER14] use forbidden transitions and commutator equations to estimate a discrete Markov kernel observed at random unknown times. Their rank criterion is a predecessor of the linear system used here. De Castro, Espinasse, and Rochet [DER17] define sparse-commutant identifiability for symmetric weighted adjacency matrices and establish structural and generic results. Segarra et al. [SMMR17] recover graph operators from spectral templates with explicit rank conditions and noisy variants. Johnson and Walch [JW12] derive ratio equations for commuting tridiagonal and tree patterns. Baake and Sumner [BS24] explain the commutation of embeddings of a nonderogatory observed matrix. We use these established ideas and give a self-contained proof of the additional structural statement we need.

The distinction is precise: the main algebraic theorem holds for **every** positive assignment of both directed rates on a fixed graph in the stated class, allows nonreversible generators, imposes zero row sums, and identifies all exceptions within that class. It is not a claim that sparsity, commutators, least squares, trace normalization, or tree reconstruction were invented here. Tree identifiability is already accessible through reversibility and real-spectrum logarithm results. The nonreversible cyclic and branching cases are the substantive application. The bounded novelty audit is recorded separately; it does not certify worldwide priority.

# 2. Model and notation

Let $G=(V,E)$ be a finite connected simple undirected graph with $n\ge2$ vertices and no cycles of length three or four. Trees satisfy this condition. Let

$$D=\{(i,j):\{i,j\}\in E\},\qquad m=|D|=2|E|.$$

The vertex labels, graph, and lag $\Delta$ are known. We use **row** generators: $q_{ij}>0$ for $(i,j)\in D$, $q_{ij}=0$ for other off-diagonal entries, and

$$q_{ii}=-\sum_{j\ne i}q_{ij}.$$

Thus $P=\exp(\Delta Q)$ is row stochastic. The two rates on an edge need not agree, and detailed balance is not assumed. A competing physical generator has the same positive bidirectional support. The algebraic proof is stronger: it allows arbitrary real coefficients, including zero, in

$$\mathcal L(G)=\{X\in\mathbb R^{n\times n}:X\mathbf1=0,\;x_{ij}=0\text{ if }i\ne j,\ (i,j)\notin D\}.$$

Write $\operatorname{Comm}(M)=\{X:XM=MX\}$ and $[X,M]=XM-MX$. A matrix is **nonderogatory** (also called cyclic) if its minimal polynomial has degree $n$. Having $n$ distinct complex eigenvalues is sufficient. This use of “cyclic matrix” is unrelated to a graph being a cycle.

The full matrix $P$ is an idealized infinite-data input. No hidden-state inference, unknown topology, time-varying rates, or automatic finite-sample guarantee is included. Section 7 treats a measured approximation under an explicitly supplied error bound.

# 3. Complete supported-commutant classification

**Theorem 1 (topology rigidity).** Under the preceding graph and rate hypotheses:

1. If $G$ is not a cycle, then

   $$\mathcal L(G)\cap\operatorname{Comm}(Q)=\mathbb R Q.$$

2. If $G=C_n$, $n\ge5$, the same identity holds unless both the clockwise rates and the counterclockwise rates are spatially constant.
3. On a homogeneous cycle, the intersection has dimension exactly two, spanned by the clockwise and counterclockwise generators.

The theorem does not need a spectral assumption on $Q$.

## 3.1. A unique two-step path

For $(i,j)\in D$ define $t_{ij}=x_{ij}/q_{ij}$. Suppose $[Q,X]=0$. If $i,j,k$ is a two-edge path with $i\ne k$, then $i$ and $k$ are nonadjacent because there is no triangle. They have exactly one common neighbor, $j$, because a second would produce a quadrilateral. Consequently

$$0=[Q,X]_{ik}=q_{ij}x_{jk}-x_{ij}q_{jk},$$

and positivity of the two rates gives

$$t_{ij}=t_{jk}.\tag{1}$$

Diagonal terms vanish because $q_{ik}=x_{ik}=0$. The exclusions of both short cycle lengths are used here, not merely a vague sparsity assumption.

## 3.2. Branching vertices and paths

Suppose a vertex $v$ has at least three neighbors. For any two distinct neighbors $y,z$, choose a third $x$. Equation (1) gives $t_{vy}=t_{xv}=t_{vz}$. All outgoing ratios at $v$ therefore coincide. Each incoming ratio equals an outgoing one by choosing a different neighbor, so all incident directed ratios have one value $c$.

This equality propagates. Once both orientations of an edge $u-v$ have value $c$, for every neighbor $w\ne u$ of $v$, equation (1) gives

$$t_{vw}=t_{uv}=c,\qquad t_{wv}=t_{vu}=c.$$

Connectedness carries the equality to every edge. Thus all off-diagonal entries of $X$ are $c$ times those of $Q$. Zero row sums determine the diagonal, so $X=cQ$.

If there is no vertex of degree at least three, a connected graph with at least two vertices is a path or a cycle. For a path choose an endpoint $u$ and its unique neighbor $v$. Its diagonal commutator entry is

$$0=[Q,X]_{uu}=q_{uv}x_{vu}-x_{uv}q_{vu}.$$

Hence $t_{uv}=t_{vu}$, and the same propagation proves $X=cQ$. This includes the two-vertex graph. The reverse inclusion is immediate because $cQ$ commutes with $Q$.

## 3.3. The cycle exception

Label cycle vertices modulo $n$, with

$$a_i=q_{i,i+1}>0,\qquad b_i=q_{i,i-1}>0.$$

Repeated application of (1) around each orientation gives constants $\alpha,\beta\in\mathbb R$ such that

$$x_{i,i+1}=\alpha a_i,\qquad x_{i,i-1}=\beta b_i.$$

Let $A$ contain clockwise rates $a_i$ and diagonal $-a_i$, and let $B$ contain counterclockwise rates $b_i$ and diagonal $-b_i$. Then

$$Q=A+B,\qquad X=\alpha A+\beta B,\qquad [Q,X]=(\beta-\alpha)[A,B].$$

Direct multiplication gives

$$[A,B]_{i,i+1}=a_i(b_i-b_{i+1}),\qquad [A,B]_{i,i-1}=b_i(a_{i-1}-a_i).\tag{2}$$

If $\alpha\ne\beta$, commutation and positivity force all $a_i$ equal and all $b_i$ equal. Conversely, when they are constant, $A=a(S-I)$ and $B=b(S^{-1}-I)$ for the cyclic shift $S$, so $A$ and $B$ commute. Their supports are disjoint off the diagonal, so they are linearly independent. This proves all three parts of Theorem 1. The argument applies without changes for $n=5$: the two distance-two vertices remain distinct. It does not apply to $n=4$, where two different length-two paths have the same endpoints.

# 4. Fixed-lag reconstruction without branch enumeration

**Lemma 2 (standard centralizer fact).** If $P$ is nonderogatory, any two matrices commuting with $P$ commute with one another.

For completeness, choose a cyclic vector $v$ so that $v,Pv,\ldots,P^{n-1}v$ is a basis. If $X$ commutes with $P$, there is a polynomial $p$ of degree at most $n-1$ with $Xv=p(P)v$. Commutation gives $XP^kv=p(P)P^kv$ on the whole basis, hence $X=p(P)$. Polynomials in $P$ commute. The equivalence between a cyclic vector and a degree-$n$ minimal polynomial is the standard cyclic-vector characterization; see [BS24, Theorem 2.1 and Corollary 2.16].

**Theorem 3 (linear reconstruction).** Assume $P=\exp(\Delta Q)$ is nonderogatory, and $G,Q$ satisfy Theorem 1 but are not a homogeneous cycle. Then

$$\mathcal L(G)\cap\operatorname{Comm}(P)=\mathbb R Q.\tag{3}$$

In particular, $Q$ is the unique real solution of

$$X\in\mathcal L(G),\qquad [X,P]=0,\qquad \operatorname{tr}X=\frac{\log\det P}{\Delta}.\tag{4}$$

**Proof.** The power series for the exponential shows $QP=PQ$. Lemma 2 implies that every $X$ commuting with $P$ also commutes with $Q$. Theorem 1 then gives $X=cQ$, proving (3). Also,

$$\det P=\exp(\Delta\operatorname{tr}Q)>0.$$

Since $\operatorname{tr}Q<0$, equation (4) fixes $c=1$. Any competing generator with exponential $P$ commutes with $P$ and has the same real trace, so it must equal $Q$. No branch choice is present in the real scalar logarithm of the positive determinant. $\square$

There is no small-lag upper bound in this theorem. Its conditions must nevertheless hold at the chosen lag. A repeated eigenvalue does not by itself imply failure, but one must not omit the nonderogatory hypothesis from the proof. For a particular input, full column rank of the linear system below can establish uniqueness even when the graph or spectral sufficient conditions do not apply. This instance-based rank principle is prior art, not an additional graph theorem.

## 4.1. Explicit linear system

For each directed edge $e=(i,j)$ let $B_e=E_{ij}-E_{ii}$. Write $Q=\sum_e q_eB_e$ and define

$$C(P)_{\cdot,e}=\operatorname{vec}(B_eP-PB_e),\qquad
\mathcal A(P)=\begin{bmatrix}C(P)\\\mathbf1^\mathsf T\end{bmatrix},\qquad
\tau=-\frac{\log\det P}{\Delta}=\sum_eq_e>0.$$

Then

$$\mathcal A(P)q=(0,\ldots,0,\tau)^\mathsf T.\tag{5}$$

Equation (3) means that $C(P)$ has nullity one. Its nullspace is spanned by $q$, whose entries have positive sum. Adding the last row therefore makes $\mathcal A(P)$ full column rank. A dense QR or SVD solve is polynomial in $n,m$ and avoids enumeration of logarithm branches. We make no optimal-complexity claim. The scale $\tau$ is the sum of escape rates over states, **not** stationary dynamical activity, which has stationary-probability weights.

For arbitrary data not known to satisfy the model, solving (5) is not an embeddability proof. One must also inspect rate signs and the exponential residual. A small floating-point residual is a diagnostic, not an exact existence certificate.

# 5. Homogeneous cycles: exact alias classification

The linear reconstruction theorem excludes every homogeneous cycle, including ones whose physical generator is nevertheless unique. They require the exponential phases, not just commutation and trace. The following calculation is an explicit nearest-neighbor specialization of established circulant embedding theory [BS20, Section 5], included to close the exception analysis rather than claimed as a separately new inference principle.

**Theorem 4 (homogeneous aliases).** Let $n\ge5$, $a,b>0$, and

$$Q=a(S-I)+b(S^{-1}-I).$$

Within this homogeneous model, equal fixed-lag propagators force equal rates unless $n=6$. For $n=6$ all positive alternatives are exactly

$$a_\ell=a+\ell h,\qquad b_\ell=b-\ell h,\qquad
h=\frac{2\pi}{\sqrt3\,\Delta},\qquad
\ell\in\mathbb Z,\quad-\frac ah<\ell<\frac bh.\tag{6}$$

If the observed $P$ is nonderogatory, these also exhaust all generators on the same cycle support, without assuming the competing generator homogeneous in advance.

**Proof.** Put $s=a+b$, $d=a-b$, and $\theta_k=2\pi k/n$. The fixed Fourier basis diagonalizes $Q$, with eigenvalues

$$\lambda_k=-s(1-\cos\theta_k)+i d\sin\theta_k.$$

The trace fixes $s'=s$. Equality of the exponentials in each labeled Fourier mode is equivalent to

$$\Delta(d'-d)\sin\theta_k\in2\pi\mathbb Z\quad\text{for all }k.\tag{7}$$

If $d'\ne d$, the $k=1$ integer in (7) is nonzero. Dividing the $k=2$ relation by it makes $2\cos(2\pi/n)$ rational. This number is an algebraic integer, since it equals $\zeta+\zeta^{-1}$ for an $n$th root of unity. A rational algebraic integer is an integer. For $n=5$ it lies strictly between zero and one, and for $n\ge7$ strictly between one and two. Thus only $n=6$ is possible. On $C_6$ every nonzero sine is $\pm\sqrt3/2$, so (7) is exactly (6), including its sufficiency. Positivity gives the strict interval.

If $P$ is nonderogatory, a competing supported generator commutes with $Q$ by Lemma 2. The cycle part of Theorem 1 forces it into the span of the two homogeneous directional generators, hence the preceding Fourier calculation applies. $\square$

The number of admissible generators in (6), including the original one, is

$$N=\left\lceil\frac ah\right\rceil+\left\lceil\frac bh\right\rceil-1.$$

There is a nontrivial positive alias exactly when $\max(a,b)>h$. The exception therefore does not mean that every homogeneous six-cycle is ambiguous. Zero-rate boundary aliases are excluded by our strictly positive physical model. Three- and four-cycles have familiar circulant aliasing as well; we make no novelty claim for those lower-dimensional embedding calculations.

**Combined conclusion.** For the graph class in Theorem 1 and nonderogatory $P$, every positive supported generator is unique except for exactly the positive homogeneous $C_6$ aliases in (6). This conclusion is stronger than the linear-solver guarantee: homogeneous $C_5$ and $C_n$, $n\ge7$, are unique but do not give full column rank in (5).

# 6. Thermodynamic meaning and a nondegenerate counterexample

Let $\pi$ be the stationary row distribution, $\pi Q=0$, $\sum_i\pi_i=1$. In units with Boltzmann's constant equal to one, stationary entropy production may be written

$$\sigma(Q)=\sum_{\{i,j\}\in E}(\pi_iq_{ij}-\pi_jq_{ji})
\log\frac{\pi_iq_{ij}}{\pi_jq_{ji}}.$$

Exact reconstruction gives the rates and hence these thermodynamic quantities. On a homogeneous ring $\pi_i=1/n$, so

$$\sigma(Q)=(a-b)\log(a/b)
=d\log\frac{s+d}{s-d}.\tag{8}$$

At fixed $s$, this is even in $d$ and strictly increasing with $|d|$: for $d>0$ its derivative is $\log((s+d)/(s-d))+2sd/(s^2-d^2)>0$. Thus (6) directly enumerates all entropy values allowed by the homogeneous six-cycle model, and by the full support model when $P$ is nonderogatory.

A concrete example uses $\Delta=1$, $(a,b)=(5.5,4.5)$ and

$$a'=5.5+2\pi/\sqrt3,\qquad b'=4.5-2\pi/\sqrt3>0.$$

Equation (7) proves exact equality of their propagators. Their entropy productions are approximately $0.2006706955$ and $19.3816222486$. The sampled eigenvalues have distinct magnitudes for modes $0,3$ and the two conjugate-pair groups. Within each pair the phase is $\pm\sqrt3/2$, so the two values differ. Thus the sampled spectrum is simple: this is a real exception even under the spectral hypothesis, not merely an artifact of degeneracy. A separate symbolic certificate uses rates proportional to $\pi/\sqrt3$ and checks the winding numbers exactly.

# 7. Observable deterministic error bounds

Exact uniqueness can coexist with severe numerical instability. The following certificate exposes, rather than removes, this limitation. Throughout this section matrix $\|\cdot\|_2$ is the spectral norm, vector $\|\cdot\|_2$ the Euclidean norm, and $\|\cdot\|_F$ the Frobenius norm.

Suppose a real measured matrix $\widetilde P$ satisfies an independently justified bound

$$\|\widetilde P-P\|_2\le\varepsilon.$$

Let $u=q/\tau$, so $u_e\ge0$ and $\sum_eu_e=1$. Define $b_0=(0,\ldots,0,1)^\mathsf T$, $\widetilde{\mathcal A}=\mathcal A(\widetilde P)$, and assume $\widetilde{\mathcal A}$ has full column rank. Set

$$\widehat u=\widetilde{\mathcal A}^{\dagger}b_0,\qquad
\gamma=\sigma_{\min}(\widetilde{\mathcal A})>0.$$

**Theorem 5 (normalized-rate certificate).**

$$\|\widehat u-u\|_2\le\frac{2\sqrt2\,\varepsilon}{\gamma}.\tag{9}$$

**Proof.** Put $E=\widetilde P-P$ and $B(u)=\sum_eu_eB_e$. Since $\mathcal A(P)u=b_0$,

$$\widetilde{\mathcal A}u-b_0=(\operatorname{vec}([B(u),E]),0)^\mathsf T.$$

The off-diagonal entries of $B(u)$ have nonnegative sum one, as do the absolute row-sum diagonal entries. Consequently

$$\|B(u)\|_F^2=\sum_eu_e^2+\sum_i\left(\sum_{j:(i,j)\in D}u_{ij}\right)^2\le2.$$

Using $\|ME\|_F,\|EM\|_F\le\|M\|_F\|E\|_2$ gives residual norm at most $2\sqrt2\varepsilon$. Full column rank implies $\widetilde{\mathcal A}^{\dagger}\widetilde{\mathcal A}=I$, so applying the pseudoinverse proves (9). $\square$

If $\widehat u$ has negative entries, its Euclidean projection onto the probability simplex has no greater distance to the true $u$. This optional projection preserves the bound and gives nonnegative estimated rates; the released benchmark reports the unprojected estimator.

For scale, require $\widetilde P$ invertible with positive determinant and put

$$\widetilde\tau=-\frac{\log\det\widetilde P}{\Delta},\qquad
\rho=\|\widetilde P^{-1}\|_2\varepsilon<1.$$

**Theorem 6 (scale and full-rate certificate).**

$$|\tau-\widetilde\tau|\le\delta_\tau,
\qquad\delta_\tau=-\frac n\Delta\log(1-\rho).\tag{10}$$

If $\widetilde\tau>0$ and $\widehat q=\widetilde\tau\widehat u$, then

$$\|\widehat q-q\|_2\le
\widetilde\tau\frac{2\sqrt2\varepsilon}{\gamma}+\delta_\tau.\tag{11}$$

**Proof.** Write $P=\widetilde P(I+H)$ with $H=\widetilde P^{-1}(P-\widetilde P)$ and $\|H\|_2\le\rho<1$. Each singular value of $I+H$ lies in $[1-\rho,1+\rho]$. Its real determinant is positive, since $I+tH$ is invertible for $0\le t\le1$ and starts with determinant one. Therefore

$$|\log\det(I+H)|\le-n\log(1-\rho),$$

which proves (10). Finally,

$$\widehat q-q=\widetilde\tau(\widehat u-u)+(\widetilde\tau-\tau)u,$$

and $\|u\|_2\le1$ gives (11). $\square$

The certificate uses observed singular values, an observed inverse norm, and an externally justified $\varepsilon$. It is not a confidence interval without a sampling model establishing $\varepsilon$. It may be large or unavailable when $\rho\ge1$, and floating-point singular values are not validated interval certificates. The rate bound also does not automatically yield an entropy-error bound: logarithms are sensitive to rates near zero and the stationary distribution must be controlled separately.

# 8. Reproducible verification and numerical interpretation

The release separates the universal proofs above from three finite checks.

* `code/verify_independent.py` independently enumerates all 1,873 connected labeled graphs of orders two through six without triangles or quadrilaterals. It checks the ratio-component propagation, symbolically multiplies the general five-cycle commutator, and verifies a six-cycle alias and simple sampled spectrum with exact algebra. Finite enumeration is not the universal graph proof.
* `code/verify_reconstruction.py` runs 33 noiseless model-generated reconstruction examples and 11 deterministic synthetic-noise examples. It includes heterogeneous cycles, paths, and a branching high-girth graph, compares with the principal matrix logarithm, and checks the analytic error bounds against actual errors. These are floating-point demonstrations, not validated arithmetic proofs.
* The independent review checks assumptions, signs, graph endpoints, nonderogatory observations, the strict positivity interval, and the noise argument. All reviewing agents in this run use the same provider; agreement does not constitute external peer review or cross-provider validation.

For the heterogeneous five-cycle at $\Delta=3$, the relative generator reconstruction error in Frobenius norm is about $6.68\times10^{-13}$, while the principal-logarithm generator differs by about $0.4785$ in the same norm and introduces forbidden entries. The graph constraint resolves this branch mismatch. With a synthetic perturbation of spectral norm $10^{-8}$ at the same lag, the Euclidean error of the directed-rate vector is about $5.04\times10^{-4}$ and the deterministic bound is about $1.334\times10^{-2}$. At lag four the actual rate-vector error rises to about $2.31\times10^{-2}$ and the bound to about $1.37$. Coarse sampling therefore remains an accuracy problem even where exact identification is possible. Full parameters and numerical diagnostics are recorded in `results/reconstruction.json`.

*Figure: Numerical reconstruction, principal-log comparison, conditioning, and the six-cycle alias. Every panel is a finite floating-point illustration of separately proved statements.*

# 9. Scope, unresolved cases, and conclusion

The proved structural classification concerns known connected graphs with no triangles or quadrilaterals, positive bidirectional rates, and zero row sums. The fixed-lag uniqueness conclusion additionally assumes a nonderogatory observed matrix, unless an instance-specific full-rank certificate is separately supplied. The homogeneous-cycle classification within the homogeneous model does not need that spectral assumption; using it to exclude nonhomogeneous competitors does.

Unknown or incorrectly specified topology, hidden states, missing reverse rates, nonstationary generators, and a full classification for derogatory observations remain outside the theorem. Graphs containing triangles or quadrilaterals may still be identifiable, but the unique-two-step-path argument does not classify them. General finite-sample uncertainty and stable entropy inference require further work.

The result supplies one explicit solution to the topology-use subproblem posed by stroboscopic thermodynamic inference. Its short mechanism is a local ratio identity that propagates through the graph, with a fully described homogeneous-cycle obstruction. The paper supplies full written proofs, independent finite algebra checks, and reproducible computation. It makes no claim of external acceptance, worldwide priority, or complete Lean certification.

# References

**[B25]** M. T. Bauer, U. Seifert, J. van der Meer. *Stroboscopic measurements in Markov networks: Exact generator reconstruction vs. thermodynamic inference.* Journal of Physics A: Mathematical and Theoretical 58, 125001 (2025). [arXiv:2412.15642v2](https://arxiv.org/html/2412.15642v2).

**[BDER14]** F. Barsotti, Y. de Castro, T. Espinasse, P. Rochet. *Estimating the transition matrix of a Markov chain observed at random times.* Statistics & Probability Letters 94, 98–105 (2014). [doi:10.1016/j.spl.2014.07.009](https://doi.org/10.1016/j.spl.2014.07.009); [arXiv:1405.0384](https://arxiv.org/pdf/1405.0384).

**[DER17]** Y. De Castro, T. Espinasse, P. Rochet. *Reconstructing Undirected Graphs from Eigenspaces.* Journal of Machine Learning Research 18 (2017), 1–24. [Full paper](https://jmlr.org/papers/volume18/16-146/16-146.pdf).

**[SMMR17]** S. Segarra, A. G. Marques, G. Mateos, A. Ribeiro. *Network Topology Inference from Spectral Templates.* IEEE Transactions on Signal and Information Processing over Networks 3 (2017), 467–483. [arXiv:1608.03008](https://arxiv.org/pdf/1608.03008).

**[JW12]** C. R. Johnson, O. Walch. *Commuting pairs of patterns and symmetric realizations.* Electronic Journal of Linear Algebra 25 (2012), 84–91. [doi:10.13001/1081-3810.1598](https://doi.org/10.13001/1081-3810.1598).

**[BS24]** M. Baake, J. Sumner. *Embedding of Markov matrices for $d\le4$.* Journal of Mathematical Biology 89, 23 (2024). [doi:10.1007/s00285-024-02112-w](https://doi.org/10.1007/s00285-024-02112-w).

**[BS20]** M. Baake, J. Sumner. *Notes on Markov embedding.* [arXiv:1903.08736v2](https://arxiv.org/pdf/1903.08736v2) (2020), especially Sections 2 and 5.
