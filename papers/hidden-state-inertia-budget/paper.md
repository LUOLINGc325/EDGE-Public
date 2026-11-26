---
title: "Hidden-state complexity from excursion moments: inertia bounds and a quantitative dissipation penalty"
author: "Wen Weixiang"
date: "26 November 2026"
lang: en
---

# Abstract

An entropy-minimizing fit to a partially observed Markov chain can acquire a positive dissipation floor solely because too few hidden states are allowed. We give an observable obstruction to low-dissipation realizations. For any finite stationary reciprocal continuous-time Markov chain with individually visible states and one hidden label, let $R$ be the matrix of hidden-excursion occurrence rates and $L$ its occurrence-weighted first-duration-moment matrix. If $L$ is symmetric with $q\geq1$ negative eigenvalues, any fixed hidden-state budget supporting exact-data models with entropy production tending to zero is at least $\operatorname{rank}R+q+1$. More generally, we give a quantitative certificate in every visible dimension without exact symmetry: for $r\leq\operatorname{rank}R$ and $r\leq K\leq r+q$, the entropy is bounded below by $s_r(R)[\nu_q(L_s)-\|L_a\|_{\mathrm{op}}]_+^2/[8m(K-r+1)P_H^2]$. Here $\nu_q$ is the magnitude of the $q$th negative spectral direction, $L_s,L_a$ are the symmetric and antisymmetric parts, and $P_H$ is hidden mass. For every $m\geq2$ and $1\leq q\leq m-1$, strictly positive full-rank data attain the sharp budget $m+q+1$; its extremal case is $2m$. For two visible states and at most three hidden states, we additionally prove a positive, computable entropy bound using the second singular value of $R$, the negative part of the spectrum of the symmetric part of $L$, and its row-column imbalance. A rational data set has feasible three-hidden-state models, all with entropy production greater than $1/75000$, while an explicit four-hidden-state family preserves every datum exactly and has entropy production tending to zero, with all exit rates at most $100$. The separation persists on a nonempty open subset of the positive consistency manifold. The proofs use a stationary-flow estimate for forward and backward hitting probabilities and require no bound on internal rates or a prescribed hidden topology.

**Interpretation and verification scope.** Entropy production throughout means stationary path irreversibility; a physical dissipation interpretation needs the usual thermodynamic modeling assumptions. The results are proved mathematically below. No proof-assistant verification is asserted.

# 1. Question, results, and relation to prior work

When only part of a stochastic network is visible, minimizing entropy production over all compatible microscopic models is a natural inference procedure. Its scientific interpretation depends on the model class. A restriction on the number of hidden states may exclude low-dissipation explanations even when a reduced model fits all supplied statistics exactly.

The present observation contract distinguishes $m$ individual visible states and merges every other state into one hidden label. The observations include stationary masses, coarse transition flows, the rates $R_{ij}$ of excursions from visible state $i$ through the hidden set to visible state $j$, and their first duration moments $L_{ij}$. Return excursions are included. Neither higher moments nor the entire observed path law are fixed.

Our main statements are as follows.

1. A forward-backward hitting-probability estimate controls their Dirichlet mismatch by total entropy production, uniformly in the hidden topology and rates (Theorem 3.1).
2. The rank of $R$ and negative inertia of symmetric $L$ give a necessary hidden budget (Theorem 4.1). A nonsymmetric quantitative certificate applies in every visible dimension and is stable under perturbations of the observed matrices (Theorem 4.3 and Corollary 4.4).
3. For two visible states, a quantitative certificate applies to every model with at most three hidden states, including nonsymmetric observations (Theorem 5.1).
4. Explicit compatible models show a genuine three-versus-four dissipation separation; the same mechanism gives a sharp $m+q+1$ family for every full-rank inertia $q$, including the extremal $2m$ case (Theorems 6.3, 7.1, and 7.2).
5. A submersion argument and the nonsymmetric certificate give a full-dimensional robust separation within the consistency manifold (Theorem 8.1).

Skinner and Dunkel established optimization-based inference from incomplete transition statistics [1] and waiting-time-based dissipation bounds [2]. Nitzan, Ghosal, and Bisker studied topology reduction with transition and duration information [3]. Transition-based waiting-time inference also connects hidden cycles and irreversibility [4]. We do not claim these frameworks, the entropy formula, hitting probabilities, or phase-type moment identities as new.

The closest specific source is Petkov [5]. For positive two-visible-state data, it gives a four-hidden-state realization sequence attaining the unrestricted entropy infimum and explicitly leaves the minimal universal hidden budget open. The same source already proves that feasible two-hidden-state fits can be unsafe and that their overestimate can be arbitrarily large. Our feasible three-state obstruction shows that the universal four-state budget cannot be reduced. More substantially, the general inertia law, its dimension-dependent sharp family, and the quantitative certificate address how observed timing geometry forces microscopic complexity. The four-state sufficiency result of [5] remains its author's contribution. Our concrete separation, general sharp family, and open-set separation are proved here without using that result as a black box.

Petkov's companion work [6] concerns equilibrium realization of an entire observed path law and complete positivity of reflected observation matrices. Its fixed-law realization contract differs from the finite-moment contract here. Aznagulov [8] proves fixed-law attainment and architecture-independent positive floors using an entire observed sojourn density. Those results preserve the full observation law, whereas the families below preserve only the specified count and first-moment data. A fixed-law positive floor and a finite-moment zero infimum therefore concern different feasible sets. Work connecting committors and information thermodynamics [7] concerns another related use of hitting probabilities; the budget conclusions below are not consequences of identifying a reaction coordinate. The literature comparison is limited to the sources and searches documented with this manuscript, and does not certify global priority.

# 2. Observation model and elementary identities

## 2.1. Stationary-flow description

Let $V=\{1,\ldots,m\}$ and $H$ be disjoint finite sets, with $m\geq2$ and $H\ne\varnothing$. A model is an irreducible continuous-time Markov chain on $V\cup H$, with row generator $Q$ and strictly positive stationary probability vector $\pi$. Its support is reciprocal:

$$q_{xy}>0\quad\Longleftrightarrow\quad q_{yx}>0\qquad(x\ne y). \tag{2.1}$$

Missing reciprocal pairs are permitted. Each model has finite rates, but sequences of models need not share a rate bound. Write $n_{xy}=\pi_xq_{xy}$ for $x\ne y$ and $n_{xx}=0$. Stationarity is equivalent to equality of each row and column sum of $N=(n_{xy})$.

The entropy production is

$$\sigma=\sum_{x\lt y}(n_{xy}-n_{yx})\log\frac{n_{xy}}{n_{yx}}, \tag{2.2}$$

where absent pairs contribute zero. Natural logarithms are used. Define the hidden mass $P_H=\sum_{h\in H}\pi_h$, visible masses $P_i=\pi_i$, and direct visible flows $F_{ij}=n_{ij}$ for $i\ne j$ in $V$. Coarse visible-hidden flows sum the corresponding $n_{ih}$ and $n_{hi}$.

Let $U_{ih}=n_{ih}$, $V_{hi}^{\mathrm{out}}=n_{hi}$, $D=\operatorname{diag}(\pi_h)$, and

$$J=D(-Q_{HH}). \tag{2.3}$$

To avoid confusing the visible state set with the exit matrix, we write the latter as $W=V^{\mathrm{out}}$ from now on. The diagonal of $J$ is total hidden outflow; its off-diagonal entries are $-n_{hg}$.

**Lemma 2.1 (balance and absorption).** The matrix $J$ is invertible with entrywise nonnegative inverse, and

$$J\mathbf1=W\mathbf1,\qquad \mathbf1^TJ=\mathbf1^TU. \tag{2.4}$$

**Proof.** A finite irreducible chain hits the nonempty visible set almost surely with finite mean time from any hidden state. For example, finite irreducibility supplies a positive probability, uniform over the finitely many starting states, of hitting it within a fixed time; iteration gives a geometric tail on that time grid. Thus the killed hidden semigroup decays exponentially. With $M=-Q_{HH}=D^{-1}J$,

$$M^{-1}=\int_0^\infty e^{-Mt}\,dt$$

exists and is nonnegative. Hence $J^{-1}=M^{-1}D^{-1}$ is nonnegative. The first identity in (2.4) is the hidden row-sum identity; the second is hidden stationarity. $\square$

## 2.2. Counts, moments, and hitting probabilities

An excursion begins on a jump from a visible state into $H$ and ends at the next visible visit, including a return to the initial state. Its duration excludes visible holding times. Let $R_{ij}$ be its stationary occurrence rate, and let $L_{ij}$ be that rate times its conditional mean duration. If a rate is zero, the corresponding first-moment entry is defined by the integrated occurrence measure and is zero.

**Lemma 2.2 (observation identities).** The exact count and first-moment matrices are

$$R=UJ^{-1}W,\qquad L=UJ^{-1}DJ^{-1}W. \tag{2.5}$$

**Proof.** The occurrence-rate density matrix at duration $t$ is $Ue^{Q_{HH}t}D^{-1}W$. Integrating it uses $\int_0^\infty e^{-Mt}dt=M^{-1}$; multiplying by $t$ before integration uses $\int_0^\infty t e^{-Mt}dt=M^{-2}$. The latter identity follows by integration by parts, justified by the exponential decay in Lemma 2.1. Substitute $M^{-1}=J^{-1}D$. $\square$

Define matrices of forward and backward hitting probabilities by

$$C=J^{-1}W,\qquad A=J^{-T}U^T. \tag{2.6}$$

Their rows $c_h^T,a_h^T$ are indexed by hidden states; we regard $c_h,a_h$ as column vectors in $\mathbb R^m$.

**Lemma 2.3 (probability factorization).** Both $A$ and $C$ are entrywise nonnegative and row-stochastic. They are the next-visible distributions for the chain and its stationary time reversal. In particular,

$$R=UC,\qquad L=A^TDC=\sum_h\pi_h a_hc_h^T,\qquad
\mathbf1^TL\mathbf1=P_H. \tag{2.7}$$

Moreover, $R\mathbf1=U\mathbf1$ and $\mathbf1^TR=\mathbf1^TW$.

**Proof.** Nonnegativity and row sums follow from Lemma 2.1. The killed stationary-flow matrix of the reversed chain is $J^T$, and its exit matrix is $U^T$. Solving the corresponding Dirichlet problems gives (2.6). Substitution proves the factorizations and the three marginal identities. $\square$

## 2.3. Exact realization by a single channel

We will use the following constructive fact, credited as a standard channel realization rather than as a new theorem.

**Lemma 2.4 (rank-one channel).** Let $M=tab^T$ be a nonzero nonnegative rank-one $m\times m$ matrix, with $t=\mathbf1^TM\mathbf1>0$ and probability vectors $a,b$. Suppose $a_i>0$ exactly when $b_i>0$. A single hidden state with entrance flows $ta_i$, exit flows $tb_i$, mass $\tau t$, and mean holding time $\tau>0$ contributes $M$ to $R$ and $\tau M$ to $L$. Its entropy contribution is

$$\mathcal C(M)=t\sum_{i:a_i>0}(a_i-b_i)\log\frac{a_i}{b_i}. \tag{2.8}$$

Scaling $M$ by a positive scalar scales $\mathcal C(M)$ by that scalar. A symmetric channel has zero entropy production. For two visible states and positive cross entries,

$$\mathcal C(M)=(M_{12}-M_{21})\log\frac{M_{12}}{M_{21}}. \tag{2.9}$$

**Proof.** Its killed flow is $J=t$, while $U=ta$ and $W=tb^T$. Equations (2.5) yield the two contributions. The entrance and exit totals coincide, proving stationarity at the hidden state; (2.8) is the sum of its boundary-edge entropy terms. In dimension two, $a_1-b_1=-(a_2-b_2)$ and $M_{12}/M_{21}=a_1b_2/(a_2b_1)$, giving (2.9). Symmetric one-coordinate channels also have zero entropy production, without a logarithm of zero. $\square$

Several channels may be placed in parallel. The visible flow-balance condition is

$$\sum_{j\ne i}(F_{ij}-F_{ji})=(\mathbf1^TR)_i-(R\mathbf1)_i. \tag{2.10}$$

Positive prescribed visible masses, hidden masses summing to $P_H$, and a connected reciprocal graph then give a genuine irreducible chain by dividing each stationary flow by its origin mass. This operation preserves the selected time unit.

# 3. Entropy controls forward-backward hitting mismatch

Form the full stationary-flow Laplacian

$$G=\operatorname{diag}(N\mathbf1)-N,\qquad S=\frac{G+G^T}{2},\qquad K=\frac{G-G^T}{2}. \tag{3.1}$$

For unordered supported pairs put $s_{xy}=(n_{xy}+n_{yx})/2$ and $j_{xy}=n_{xy}-n_{yx}$, with a fixed orientation $x\lt y$. Stationarity gives $K\mathbf1=0$, and

$$\mathcal E(f)=f^TSf=\sum_{x\lt y}s_{xy}(f_x-f_y)^2. \tag{3.2}$$

**Lemma 3.1 (current inequality and cancellation).** We have

$$\sum_{x\lt y}\frac{j_{xy}^2}{s_{xy}}\leq\sigma. \tag{3.3}$$

For any real vectors $u,v$,

$$u^TKv=-\frac12\sum_{x\lt y}j_{xy}(u_x-u_y)(v_x+v_y). \tag{3.4}$$

**Proof.** For positive $a,b$, set $z=(a-b)/(a+b)$. Then $(a-b)\log(a/b)=2(a+b)z\operatorname{artanh}z\geq2(a-b)^2/(a+b)$, since $z\operatorname{artanh}z\geq z^2$. Summing proves (3.3). Direct expansion gives $u^TKv=-\frac12\sum j_{xy}(u_xv_y-u_yv_x)$. The difference between that summand and the expression in (3.4) is $j_{xy}(u_xv_x-u_yv_y)$; its sum vanishes because stationary currents have zero divergence. $\square$

**Theorem 3.1 (committor energy bound).** For a fixed visible index $i$, extend the forward and backward hitting probabilities $c,b$ to the full graph with the common boundary values $\mathbf1_{\{i\}}$ on the visible states. Then

$$\mathcal E(c-b)\leq\sigma. \tag{3.5}$$

Consequently, with $w_h=\frac12\sum_i(U_{ih}+W_{hi})$,

$$w_h(C_{hi}-A_{hi})^2\leq\sigma \quad\text{for every }h,i. \tag{3.6}$$

**Proof.** Write $\delta=c-b$ and $g=c+b-\mathbf1$. Then $\delta$ vanishes on the visible boundary and $|g_x|\leq1$. The harmonic equations are $(Gc)_h=0$ and $(G^Tb)_h=0$. Multiplying by $\delta$ and subtracting gives

$$\mathcal E(\delta)=-\delta^TK(c+b)=-\delta^TKg.$$

By (3.4), $|g_x+g_y|\leq2$, Cauchy-Schwarz, and (3.3),

$$\mathcal E(\delta)\leq\sum_{x\lt y}|j_{xy}|\,|\delta_x-\delta_y|
\leq\sqrt{\sigma\mathcal E(\delta)}.$$

When the energy is positive, division and squaring give (3.5); the zero case is immediate. The visible-hidden boundary terms of (3.2) equal $\sum_h w_h\delta_h^2$ and are part of a sum of nonnegative terms. This proves (3.6). $\square$

No internal rate, conductance, or inverse of a small spectral gap appears in this estimate. In particular, it remains valid along sequences with diverging internal flows or vanishing stationary masses.

# 4. An inertia lower bound on hidden complexity

For a real symmetric matrix $L$, let $\nu_-(L)$ count strictly negative eigenvalues with multiplicity. An exact data set consists of compatible selected masses, coarse flows, $R$, and $L$. Let $\mathcal C_k(d)$ contain compatible finite reciprocal models with at most $k$ hidden states, and let $I_k(d)=\inf_{Q\in\mathcal C_k(d)}\sigma(Q)$ when this class is nonempty. A zero-infimum assertion always requires a nonempty class.

**Theorem 4.1 (rank-inertia obstruction).** Suppose $L=L^T$ and $q=\nu_-(L)\geq1$. If there exists an exact-data sequence with at most $k$ hidden states and entropy production tending to zero, then

$$k\geq\operatorname{rank}R+q+1. \tag{4.1}$$

**Proof.** Pass to a subsequence with a constant hidden state count $h\leq k$ and label those states consistently. The hidden masses lie in a compact closed simplex. The entries of $U$ are bounded because its row sums equal those of the fixed $R$. Each row of $A,C$ is a probability vector. Thus $D,U,A,C$ have a jointly convergent subsequence. This uses no compactness of $Q,J$, or the internal flows.

Let $\mathcal A$ be the indices with nonzero limiting entrance column, and let $a=|\mathcal A|$. From the exact identity $R=UC$, every limiting column outside $\mathcal A$ contributes zero, so $\operatorname{rank}R\leq a$. For $h\in\mathcal A$, the entrance total has positive limit and $w_h$ is at least half that total. Equation (3.6) therefore makes the limiting rows $a_h$ and $c_h$ equal.

In the limit, (2.7) becomes

$$L=P+T,\qquad P=\sum_{h\in\mathcal A}\pi_hc_hc_h^T\succeq0,
\qquad T=\sum_{h\notin\mathcal A}\pi_ha_hc_h^T. \tag{4.2}$$

The matrix $T$ is entrywise nonnegative, has rank at most $h-a$, and is symmetric because $L$ and $P$ are symmetric. It is nonzero, since otherwise $L$ could have no negative eigenvalue. The all-ones vector has strictly positive quadratic form under a nonzero symmetric nonnegative matrix, so $T$ has at least one positive eigenvalue. Hence

$$\nu_-(T)\leq\operatorname{rank}T-1\leq h-a-1.$$

Adding a positive semidefinite matrix cannot increase negative inertia: on any subspace where $L=P+T$ is negative definite, $T$ is also negative definite. Therefore $q\leq\nu_-(T)\leq h-a-1$, giving $h\geq a+q+1\geq\operatorname{rank}R+q+1$. $\square$

**Corollary 4.2 (positive floor below the budget).** If $\mathcal C_k(d)$ is nonempty and $k\lt \operatorname{rank}R+\nu_-(L)+1$ under the preceding hypotheses, then $I_k(d)>0$.

**Proof.** Every finite reciprocal model has finite nonnegative entropy. If the infimum were zero, selecting entropy below $1/n$ would contradict Theorem 4.1. No attainment of the infimum is needed or claimed. $\square$

The extra $+1$ is essential: the residual nonnegative symmetric matrix in (4.2) needs a positive direction as well as the negative directions it supplies. The theorem is about approaching zero total entropy. It does not automatically bound excess entropy above a nonzero count-only floor.


## 4.2. A quantitative certificate in every visible dimension

The preceding obstruction has a quantitative form without exact symmetry. Write $s_r(R)$ for the $r$th largest singular value, $L_s=(L+L^T)/2$, $L_a=(L-L^T)/2$, and let $\lambda_q^\uparrow(L_s)$ be the $q$th eigenvalue in increasing order. Put

$$\nu_q(L_s)=[-\lambda_q^\uparrow(L_s)]_+. \tag{4.3}$$

**Theorem 4.3 (general observable budget penalty).** Let $m\geq2$, $1\leq r\leq\operatorname{rank}R$, $1\leq q\leq m-1$, and $r\leq K\leq r+q$ be integers. Every compatible model with at most $K$ hidden states satisfies

$$\sigma\geq\Gamma_{r,q,K}(R,L)
:=\frac{s_r(R)}{8m(K-r+1)P_H^2}
\big[\nu_q(L_s)-\|L_a\|_{\mathrm{op}}\big]_+^2. \tag{4.4}$$

The result is uniform over all finite hidden topologies, rates, and stationary mass allocations. A model with fewer than $r$ hidden states cannot fit $R$. No symmetry of $R$ or $L$ is required.

**Proof.** Append algebraic zero terms to the factorizations (2.7) until there are $K$ terms; give each appended term arbitrary probability rows and zero mass, entrance, and exit flow. Sort the $w_h$ of (3.6) in nonincreasing order. Let $u_h$ be entrance column $h$. Removing the first $r-1$ summands of $R=\sum_hu_hc_h^T$ gives

$$\begin{aligned}
s_r(R)&\leq\left\|\sum_{h=r}^K u_hc_h^T\right\|_{\mathrm{op}}
\leq\sum_{h=r}^K\|u_h\|_1\\
&\leq2\sum_{h=r}^K w_h
\leq2(K-r+1)w_r. 
\end{aligned}\tag{4.5}$$

We used the singular-value lower bound on any rank-$(r-1)$ approximation, $\|c_h\|_2\leq1$, and $\|u_h\|_1\leq2w_h$. In particular $w_r>0$. Equation (3.6), summed over the $m$ visible coordinates, yields

$$\|a_h-c_h\|_2\leq
\sqrt{\frac{2m(K-r+1)\sigma}{s_r(R)}},\qquad h\leq r. \tag{4.6}$$

Split the moment matrix as

$$\begin{aligned}
L&=P+E+B,\\
P&=\sum_{h\leq r}\pi_hc_hc_h^T\succeq0,\\
E&=\sum_{h\leq r}\pi_h(a_h-c_h)c_h^T,\qquad
B=\sum_{h>r}\pi_ha_hc_h^T. 
\end{aligned}\tag{4.7}$$

Then $B$ is entrywise nonnegative, $\operatorname{rank}B\leq K-r\leq q$, and

$$e:=\|E\|_{\mathrm{op}}\leq
P_H\sqrt{\frac{2m(K-r+1)\sigma}{s_r(R)}}. \tag{4.8}$$

Let $H=(B+B^T)/2$ and $a=\|L_a\|_{\mathrm{op}}$. Because $H=L_s-P-E_s$ with $P\succeq0$, if $\nu:=\nu_q(L_s)>e$, the eigenvalue minmax principle implies that $H$ has at least $q$ eigenvalues at most $-(\nu-e)$.

The symmetric matrix $H$ is entrywise nonnegative. Its largest eigenvalue is at least the absolute value of its smallest eigenvalue: for a unit eigenvector $v$ associated with the smallest value, entrywise nonnegativity gives $|v|^TH|v|\geq|v^THv|$, and the Rayleigh principle applies to $|v|$. Consequently $H$ has, in addition to the $q$ negative eigenvalues, a positive eigenvalue at least $\nu-e$. Hence $s_{q+1}(H)\geq\nu-e$.

On the other hand, $B$ has rank at most $q$, so

$$s_{q+1}(H)\leq\|H-B\|_{\mathrm{op}}
=\|B_a\|_{\mathrm{op}}
\leq\|L_a\|_{\mathrm{op}}+\|E_a\|_{\mathrm{op}}
\leq a+e. \tag{4.9}$$

Thus $\nu\leq a+2e$. The same inequality is immediate when $\nu\leq e$. Combining it with (4.8), taking the positive part, and squaring proves (4.4). The case $K=r$ is included: then $B=0$, and any putative $\nu>e$ already contradicts the displayed eigenvalue comparison. $\square$

**Corollary 4.4 (robust spectral complexity certificate).** Suppose $1\leq r\leq\operatorname{rank}R$, $1\leq q\leq m-1$, and $\nu_q(L_s)>\|L_a\|_{\mathrm{op}}$. Any exact-data sequence with a fixed hidden budget and entropy production tending to zero must have budget at least $r+q+1$. For every $r\leq K\leq r+q$, the nonempty class $\mathcal C_K(d)$ has the explicit lower bound (4.4). These bounds persist on a neighborhood of $(R,L)$ where $s_r(R)>0$ and $\nu_q(L_s)>\|L_a\|_{\mathrm{op}}$ continue to hold.

**Proof.** Budgets below $r$ violate the rank identity. The remaining excluded budgets have a strictly positive right side in (4.4). Singular values, eigenvalues of symmetric matrices, and the operator norm are continuous; $P_H$ remains positive on a sufficiently small neighborhood. This proves the stability statement. It asserts continuity of the certificate; it does not assert smaller-budget feasibility of every perturbed datum. $\square$

Taking $r=\operatorname{rank}R$ and $L=L^T$ recovers Theorem 4.1 with an explicit estimate. Theorem 5.1 below uses the probability-vector balance in two dimensions to improve the symmetric constant from $1/32$ to $1/16$ and to control asymmetry by a different observable quantity. Neither certificate is claimed uniformly stronger than the other for nonsymmetric data.

# 5. A computable certificate for three hidden states

This section assumes exactly two visible states. For an invertible $R$, set $\lambda=s_2(R)>0$, its smaller singular value. Define

$$L_s=\frac{L+L^T}{2},\qquad
\nu=[-\lambda_{\min}(L_s)]_+,\qquad
\beta=(L-L^T)\mathbf1,$$

$$\Gamma(R,L)=\frac{\lambda}{16P_H^2}
\big[\nu-\|\beta\|_2\big]_+^2,
\qquad P_H=\mathbf1^TL\mathbf1. \tag{5.1}$$

**Theorem 5.1 (observable three-state penalty).** Every compatible reciprocal model with at most three hidden states satisfies

$$\sigma\geq\Gamma(R,L). \tag{5.2}$$

Neither $R$ nor $L$ is required to be symmetric. The coefficient $1/16$ is a sufficient constant, not asserted optimal.

**Proof.** If necessary, pad the factorizations in (2.7) to three terms by zero entrance and exit columns, zero masses, and arbitrary probability rows. This is algebraic notation, not a new physical chain. Relabel so that $w_1\geq w_2\geq w_3$. Writing $u_h$ for entrance column $h$, the best rank-one approximation inequality gives

$$\begin{aligned}
\lambda&\leq\|R-u_1c_1^T\|_2\\
&\leq\|u_2\|_1+\|u_3\|_1
\leq2(w_2+w_3)\leq4w_2.
\end{aligned} \tag{5.3}$$

Here $\|c_h\|_2\leq1$ and $\|u_h\|_1\leq2w_h$. Thus $w_1,w_2\geq\lambda/4$. The two coordinates of the difference of two probability vectors are opposites; (3.6) consequently implies

$$\|a_h-c_h\|_2\leq\sqrt{8\sigma/\lambda},\qquad h=1,2. \tag{5.4}$$

Let $\delta_h=a_h-c_h$. Multiplication of (2.7) and its transpose by $\mathbf1$ gives $\sum_h\pi_h\delta_h=\beta$. Hence

$$L=P+E+\beta c_3^T,\quad
P=\sum_h\pi_hc_hc_h^T\succeq0,\quad
E=\sum_{h=1,2}\pi_h\delta_h(c_h-c_3)^T. \tag{5.5}$$

Probability vectors have Euclidean distance at most $\sqrt2$. Therefore

$$\|E\|_2\leq4P_H\sqrt{\sigma/\lambda},\qquad
\|\beta c_3^T\|_2\leq\|\beta\|_2. \tag{5.6}$$

Taking symmetric parts cannot increase these operator-norm bounds. A unit vector in the least-eigenvalue direction of $L_s$ yields $\nu\leq4P_H\sqrt{\sigma/\lambda}+\|\beta\|_2$ when $\nu>0$; the claim is immediate when the positive part in (5.1) vanishes. Rearranging proves (5.2). $\square$

**Corollary 5.2 (symmetric timing data).** If $L=L^T$ has least eigenvalue $-\nu\lt 0$, then

$$\sigma\geq\frac{s_2(R)\nu^2}{16P_H^2}. \tag{5.7}$$

In dimension two, $\|\beta\|_2=\sqrt2\,|L_{12}-L_{21}|$. Thus (5.2) also specifies how a deterministic departure from moment symmetry affects the certificate. It is not a confidence bound for estimated moments and does not establish a finite-sample test.

# 6. Rational data with a genuine three-versus-four separation

Set

$$R=\begin{pmatrix}7&5\\5&4\end{pmatrix},\qquad
L=\begin{pmatrix}1/8&1/8\\1/8&1/10\end{pmatrix}, \tag{6.1}$$

$$P_1=P_2=21/80,\qquad P_H=19/40,\qquad F_{12}=F_{21}=1. \tag{6.2}$$

The coarse hidden flows are the row and column sums $(12,9)$ of $R$. All observed entries required to be positive are positive, $\det R=3$, $\det L=-1/320$, and $\mathbf1^TL\mathbf1=P_H$.

**Proposition 6.1 (three-state feasibility).** These data have a reciprocal irreducible three-hidden-state realization with entropy $12\log2$.

**Proof.** Choose no hidden-to-hidden edges and

$$U=\begin{pmatrix}3&6&3\\0&3&6\end{pmatrix},\quad
W=\begin{pmatrix}3&0\\3&6\\6&3\end{pmatrix},\quad
J=\operatorname{diag}(3,9,9),\quad
D=\operatorname{diag}(1/40,9/40,9/40). \tag{6.3}$$

The entrance and exit totals of each hidden state match. The visible totals match after adding the symmetric direct flow. The supported graph is reciprocal and connected; only the pair between visible state $2$ and hidden state $0$ is missing. Divide flows by the listed positive masses to obtain $Q$.

Equivalently, the channels and holding times are

$$M_0=\begin{pmatrix}3&0\\0&0\end{pmatrix},\quad t_0=1/120;\qquad
M_1=\begin{pmatrix}2&4\\1&2\end{pmatrix},\quad
M_2=M_1^T,\quad t_1=t_2=1/40. \tag{6.4}$$

Their sum is $R$, their time-weighted sum is $L$, and their masses are $1/40,9/40,9/40$. Formula (2.9) gives $3\log4$ for each of $M_1,M_2$ and zero for $M_0$, proving the entropy value. $\square$

**Proposition 6.2 (strict numerical certificate).** Every compatible model with at most three hidden states satisfies

$$\sigma\geq g_*=
\frac{(11-\sqrt{109})(\sqrt{101}-9)^2}{46208}
=1.335084602409963\ldots\times10^{-5}>
\frac1{75000}. \tag{6.5}$$

**Proof.** The relevant values are $s_2(R)=(11-\sqrt{109})/2$ and $\nu=(\sqrt{101}-9)/80$. Substitute in (5.7). For a rational verification of the final strict inequality, squaring positive rationals shows $s_2(R)>1399/5000$ and $\nu>41/3125$. Therefore

$$g_*>\frac{(1399/5000)(41/3125)^2}{361/100}
=\frac{2351719}{176269531250}>\frac1{75000}.$$

The displayed decimal is explanatory; the rational comparisons prove the strict bound. $\square$

**Theorem 6.3 (four-state exact-data low-dissipation family).** For every $0\lt \varepsilon\leq1$, the same data have a four-hidden-state realization with

$$\sigma_4(\varepsilon)=
\frac{81\varepsilon}{1600(1-\varepsilon/100)}\log\frac{187}{7}. \tag{6.6}$$

All total exit rates are at most $100$. Consequently

$$0\lt g_*\leq I_3(d)\leq12\log2,\qquad I_4(d)=0. \tag{6.7}$$

**Proof.** Take $\tau=1/100$, $z=1-\varepsilon\tau$, and

$$R_f=\frac{R-\varepsilon L}{z}=\begin{pmatrix}a&b\\b&d\end{pmatrix}.$$

The entries are positive, and the numerator determinant is $3+\varepsilon/20-\varepsilon^2/320>0$ on the stated range. Thus $R_f$ is positive definite. Its two nonnegative symmetric rank-one channels can be taken as

$$M_{f1}=\begin{pmatrix}a&b\\b&b^2/a\end{pmatrix},\qquad
M_{f2}=\begin{pmatrix}0&0\\0&d-b^2/a\end{pmatrix}, \tag{6.8}$$

each with holding time $\tau$. They have zero entropy production. Define

$$S_1=\frac1{1600}\begin{pmatrix}54&18\\99&33\end{pmatrix},\qquad
S_2=\frac1{1600}\begin{pmatrix}34&102\\21&63\end{pmatrix}. \tag{6.9}$$

These are positive rank-one matrices and

$$S_1+S_2=L-\tau R=\frac1{200}\begin{pmatrix}11&15\\15&12\end{pmatrix}.$$

Use occurrence matrices $(\varepsilon/z)S_1,(\varepsilon/z)S_2$ with holding time $1/\varepsilon$. The identities

$$R_f+\frac{\varepsilon}{z}(S_1+S_2)=R,\qquad
\tau R_f+\frac1z(S_1+S_2)=L \tag{6.10}$$

prove exact agreement of all counts and first moments. Hidden masses are holding times times channel masses, so their sum is $P_H$ and all are positive. Keep the visible masses and direct edge. Balance follows from (2.10), and reciprocity and connectedness are immediate.

The cross-flow differences of $S_1,S_2$ are $-81/1600$ and $81/1600$, with cross ratios $2/11$ and $34/7$. Their total entropy from (2.9) is $(81/1600)\log(187/7)$. Homogeneity gives (6.6).

The fast hidden exit rates are $100$ and the slow rates are $\varepsilon$. The two visible exit rates are fixed at $1040/21$ and $800/21$, both less than $100$. Thus the claimed common bound holds. Equation (6.6) tends to zero and entropy is nonnegative, proving $I_4=0$; Propositions 6.1 and 6.2 give the other bounds. $\square$

**Corollary 6.4 (unbounded relative overestimate).** Relative to the true four-hidden-state models in Theorem 6.3, every compatible three-hidden-state fit has a dissipation ratio at least $g_*/\sigma_4(\varepsilon)$, which diverges as $\varepsilon\downarrow0$.

Each member of the family is finite and irreducible. The limiting reducible object at $\varepsilon=0$ is not used as a physical model. The slow excursions retain first-moment mass while their occurrence rates vanish. Combining this new necessity result with the universal four-state sufficiency theorem of [5] settles its minimal-budget question in the stated positive two-visible-state class. That last comparison credits the prior sufficiency theorem; (6.7) itself is self-contained.

# 7. A sharp family in every visible dimension

**Theorem 7.1 (dimension-dependent sharpness).** For every integer $m\geq2$, there exist strictly positive consistent observations with $m$ visible states such that zero entropy production can be approached with exactly $2m$ hidden states, while it cannot be approached with any smaller fixed budget. All rates in the matching sequence have a common finite upper bound depending on $m$.

**Proof.** Put $E=\mathbf1\mathbf1^T$, $\ell=1/[m(2m-1)]$, and

$$R=I+E,\qquad L=\ell(E-I/2),\qquad
P_i=1/(2m),\quad P_H=1/2. \tag{7.1}$$

Use symmetric positive direct visible flows, for example $F_{ij}=1$ for $i\ne j$. The entries of $R,L$ are positive and their marginal identities hold. The matrix $R$ has rank $m$; $L$ has one positive eigenvalue $1/(2m)$ and $m-1$ negative eigenvalues $-1/[2m(2m-1)]$. Theorem 4.1 therefore requires $k\geq2m$.

For the construction take $\delta=\ell/8$, $0\lt \varepsilon\leq1$, $z=1-\varepsilon\delta$, and

$$R_f=\frac{R-\varepsilon L}{z},\qquad
T=\frac{L-\delta R}{z}=\frac{\ell}{8z}(7E-5I). \tag{7.2}$$

We have $R_f=\alpha I+\gamma E$ with $\alpha=(1+\varepsilon\ell/2)/z>0$ and $\gamma=(1-\varepsilon\ell)/z>0$. Its symmetric square root is the entrywise positive matrix

$$B=\sqrt\alpha I+
\frac{\sqrt{\alpha+m\gamma}-\sqrt\alpha}{m}E. \tag{7.3}$$

The $m$ columns $b_j$ give symmetric positive channels $b_jb_j^T$ summing to $R_f$. Assign each holding time $\delta$.

For the slow channels set

$$Y=\frac34I+\frac1{4m}E,\qquad
X=TY^{-1}=\frac{\ell}{24z}\big((21+5/m)E-20I\big). \tag{7.4}$$

The matrix $Y$ is invertible and row-stochastic. Its entries are positive. The diagonal entries of $X$ are $\ell(1+5/m)/(24z)>0$, and the off-diagonal entries are larger. Thus the $m$ positive rank-one matrices $X_{:j}Y_{j:}$ sum to $T$. Use occurrence matrices $\varepsilon X_{:j}Y_{j:}$ and holding time $1/\varepsilon$.

The exact identities

$$R_f+\varepsilon T=R,\qquad \delta R_f+T=L \tag{7.5}$$

give the desired observations and hidden mass. The reciprocal graph is connected, and (2.10) holds. The fast channels are reversible. The slow matrices scale with $1/z$, with fixed positive entry ratios; by (2.8) their total entropy is $\varepsilon C_m/z$ for a finite nonnegative constant $C_m$ depending only on $m$, and thus tends to zero.

The fast exit rates are $1/\delta$, the slow rates are $\varepsilon$, and each visible total outflow is fixed by $R,F$. With the fixed positive visible masses, all exit rates have a common finite bound. This proves sufficiency with $2m$ states and completes sharpness. $\square$

The theorem establishes an exact threshold for this family. It does not claim that $2m$ states suffice for every possible $m$-visible data set, nor that the general multivisible count-only entropy optimization has been solved.


## 7.2. Every full-rank inertia has a sharp example

**Theorem 7.2 (sharp budget across the inertia range).** For every $m\geq2$ and every $q\in\{1,\ldots,m-1\}$, there exist strictly positive consistent observations with $\operatorname{rank}R=m$ and exactly $q$ negative eigenvalues of symmetric $L$ such that the smallest fixed hidden budget permitting entropy production to tend to zero is exactly $m+q+1$. The matching family preserves the observations exactly and has all exit rates at most $16m^2$. Every smaller feasible hidden budget has a positive quantitative lower bound given by Theorem 4.3.

**Proof.** Put $d=q+1$ and $n=m-d$. Use the $d$-dimensional construction of Theorem 7.1 on the first $d$ visible coordinates. If $n>0$, append $n$ one-coordinate symmetric channels, each of occurrence rate $1$ and holding time $1/(4n)$. Before mixing coordinates, the observations are

$$R_0=\operatorname{diag}(R_d,I_n),\qquad
L_0=\operatorname{diag}(L_d,I_n/(4n)), \tag{7.6}$$

where $R_d,L_d$ are (7.1) in dimension $d$. If $n=0$, use only $R_d,L_d$ and omit the second blocks. The hidden mass is $3/4$ when $n>0$, and $1/2$ otherwise. The matrix $R_0$ is positive definite, while $L_0$ has exactly $q=d-1$ negative eigenvalues.

Now set

$$T=\frac12I_m+\frac1{2m}\mathbf1\mathbf1^T,\qquad
R=TR_0T^T,\qquad L=TL_0T^T. \tag{7.7}$$

The matrix $T$ is positive, invertible, and doubly stochastic. Since $R_0,L_0$ are nonnegative and nonzero, $R,L$ are strictly entrywise positive. Congruence preserves the rank of $R$ and the inertia of $L$. Double stochasticity preserves the total sum of each occurrence matrix and moment matrix, hence the hidden mass. Choose each visible mass equal to $(1-P_H)/m$, and symmetric direct visible flows $F_{ij}=1$ for $i\ne j$.

Apply the same congruence to every occurrence channel $M$ of the original family, replacing it by $TMT^T$ and retaining its holding time. A nonzero nonnegative rank-one matrix stays rank one and acquires strictly positive factors. The channel sums and weighted sums are exactly (7.7), so the prescribed observations hold for every $0\lt\varepsilon\leq1$. Their coarse flow balance follows from symmetry of $R$ and the direct flows.

The $d$ fast channels and the $n$ extra channels remain symmetric and thus reversible. The $d$ slow channels have occurrence matrices of the form $\varepsilon N_j/(1-\varepsilon\delta_d)$, with fixed strictly positive rank-one $N_j$ and $\delta_d=1/[8d(2d-1)]$. Homogeneity of (2.8) makes their total entropy production tend to zero. The hidden graph is a reciprocal star network with all boundary edges positive, hence the full chain is irreducible. Hidden exit rates are $1/\delta_d$, $\varepsilon$, and, if present, $4n$. For the stated quantitative rate bound, $1/\delta_d=8d(2d-1)\leq16m^2$ and $4n\leq16m^2$. Every row sum of $R_0$ is at most $d+1$, so the same is true of $R=TR_0T^T$, because $T$ is doubly stochastic. Each visible total outflow is at most $d+1+(m-1)\leq2m$, and each visible mass is at least $1/(4m)$. Its exit rate is therefore at most $8m^2$. This proves the stated $16m^2$ common bound.

The construction has $2d+n=m+q+1$ hidden states. Theorem 4.1 excludes every smaller fixed budget, and Theorem 4.3 gives a positive explicit certificate whenever such a smaller class is nonempty. Thus the threshold is exact. $\square$

This establishes optimality of the additive rank-plus-inertia dependence at every possible negative inertia of a full-rank positive datum. It is an existence theorem for matching families, not a universal sufficiency statement for all data with the same rank and inertia. The construction does not claim smaller-budget feasibility for every pair $(m,q)$; the explicit feasible three-versus-four separation and its open-set extension are separate results.

# 8. Separation on an open set of feasible observations

An exactly symmetric example might appear fragile. We now use the nonsymmetric certificate to show that the reduction bias persists on an open set, while maintaining smaller-model feasibility.

**Lemma 8.1 (four-channel upper bound near positive determinant).** For two visible states, suppose $R,L$ have positive entries, $\det R>0$, and positive masses and direct flows satisfy (2.10), $P_1+P_2+P_H=1$, and $P_H=\mathbf1^TL\mathbf1\lt 1$. The prescribed visible-to-hidden and hidden-to-visible coarse flows are respectively the row and column sums of $R$. Define

$$B(d)=(F_{12}-F_{21})\log\frac{F_{12}}{F_{21}}
+(R_{12}-R_{21})\log\frac{R_{12}}{R_{21}}. \tag{8.1}$$

Then $\mathcal C_4(d)$ is nonempty and $I_4(d)\leq B(d)$.

**Proof.** Choose $0\lt \delta\lt \min_{ij}L_{ij}/R_{ij}$. For sufficiently small $\varepsilon>0$, let

$$R_f=\frac{R-\varepsilon L}{1-\varepsilon\delta},\qquad
T=\frac{L-\delta R}{1-\varepsilon\delta}.$$

Both are entrywise positive, and $\det R_f>0$. Writing $R_f=\left(\begin{smallmatrix}a&b\\c&d\end{smallmatrix}\right)$, split it as

$$\begin{pmatrix}a&b\\c&bc/a\end{pmatrix}
+\begin{pmatrix}0&0\\0&d-bc/a\end{pmatrix}.$$

These are reciprocal rank-one channels. Assign them holding time $\delta$. For $T_0=L-\delta R>0$, choose a sufficiently small $\eta>0$ so that $Y=\left(\begin{smallmatrix}1-\eta&\eta\\\eta&1-\eta\end{smallmatrix}\right)$ is invertible and $X_0=T_0Y^{-1}>0$. This follows by continuity at $\eta=0$. Factor $T$ into the two positive rank-one matrices $X_{0,:j}Y_{j:}/(1-\varepsilon\delta)$, multiply their occurrence matrices by $\varepsilon$, and use holding time $1/\varepsilon$.

The identities (7.5) still apply. Channel realization, the prescribed visible masses, and the direct flows produce exact compatible irreducible models. Their fast entropy tends to $(R_{12}-R_{21})\log(R_{12}/R_{21})$; their slow entropy tends to zero by homogeneity, and their direct entropy is fixed. Thus their total entropy tends to (8.1). $\square$

This is the positive-determinant channel upper construction used in [5], included to make the following theorem self-contained. We neither claim it as a new contribution nor need its matching unrestricted lower bound here.

**Theorem 8.1 (robust feasible reduction bias).** In the manifold of positive consistent two-visible-state observations, there is a nonempty relatively open set on which $\mathcal C_3(d)$ is nonempty and

$$I_3(d)\geq\Gamma(R,L)>B(d)\geq I_4(d). \tag{8.2}$$

**Proof.** Perturb the first channel in (6.4) to

$$M_0(\eta)=3(1,\eta)^T(1,\eta),\qquad\eta=1/100,$$

keeping $M_1,M_2$ and all holding times. The three matrices are now strictly positive. Their observations are

$$R_\eta=\begin{pmatrix}7&5+3\eta\\5+3\eta&4+3\eta^2\end{pmatrix},\quad
L_\eta=\frac1{40}\begin{pmatrix}5&5+\eta\\5+\eta&4+\eta^2\end{pmatrix}. \tag{8.3}$$

Their determinants are $3-30\eta+12\eta^2>0$ and $(-5-10\eta+4\eta^2)/1600\lt 0$. Their hidden mass is $(19+2\eta+\eta^2)/40\lt 1$. Choose equal remaining visible masses and symmetric direct flow $1$. At this point $B(d)=0\lt \Gamma(R_\eta,L_\eta)$.

We show that three-channel feasibility fills a neighborhood in $(R,L)$. The positive rank-one matrices form a smooth three-dimensional manifold inside $2\times2$ matrices. Its tangent space at $M$ is the kernel of the nonzero derivative of $\det M$. At $M_0(\eta)$ a normal functional is

$$\ell_0(Z)=\eta^2Z_{11}-\eta(Z_{12}+Z_{21})+Z_{22}.$$

It satisfies $\ell_0(M_1)=2-5\eta+2\eta^2\ne0$, so the tangent space $T_0$ together with $M_1$ spans all $2\times2$ matrices. The determinant-gradient matrices at $M_1,M_2$ are respectively

$$\begin{pmatrix}2&-1\\-4&2\end{pmatrix},\qquad
\begin{pmatrix}2&-4\\-1&2\end{pmatrix}.$$

They are not proportional, so $T_1+T_2$ also spans all matrices. For the map $(M_h,t_h)\mapsto(R,L)=(\sum M_h,\sum t_hM_h)$, let $t=t_1=t_2\ne t_0$. Its differential obeys

$$dL-t\,dR=(t_0-t)dM_0+\sum_hdt_hM_h. \tag{8.4}$$

Choose $dM_0\in T_0$ and $dt_1$ to obtain any desired right side of (8.4), with $dt_0=dt_2=0$. Then use $dM_1\in T_1,dM_2\in T_2$ to correct $dR$ arbitrarily. This does not alter (8.4). The differential is therefore onto all eight observation coordinates. The submersion theorem gives an open neighborhood of $(R_\eta,L_\eta)$ consisting of positive three-channel realizable pairs.

For each such pair, set the coarse hidden flows to its row and column sums. Choose $P_1>0$ freely near its base value and put $P_2=1-P_H-P_1>0$. Choose $F_{12}>0$ freely near $1$ and set $F_{21}=F_{12}+R_{12}-R_{21}>0$. These are local coordinates on the positive consistency manifold. The preceding channels, holding times, and visible masses realize every nearby point. Finally, $\Gamma$ and $B$ are continuous here, and their inequality is strict at the base point. Shrinking the neighborhood preserves $\det R>0$ and $\Gamma>B$. Apply Theorem 5.1 and Lemma 8.1. $\square$

The theorem provides existence of a full-dimensional neighborhood in the constrained data space, not a certified numerical radius. An exact symmetric point is used to locate the neighborhood; its members need not have symmetric $R$ or $L$.

# 9. Verification, interpretation, and limits

The accompanying scripts use rational and symbolic arithmetic to check the finite channel identities, balances, determinants, entropy coefficients, and a nonzero submersion Jacobian minor. Numerical evaluations illustrate the certificate and stress-test the committor estimate on balanced nonreversible networks; they are diagnostics, not proofs of universal statements. The mathematical arguments above establish the universal claims.

The substantive conclusions concern **model-class bias**. A positive reduced-model entropy floor does not by itself lower-bound the true system's entropy when the true state count may exceed the fitted budget. Our rational example makes that failure explicit even with an exact fit, nonempty reduced class, and a common exit-rate bound on the true-model sequence. The inertia theorem supplies an observable necessary complexity condition; it does not identify the actual microscopic topology.

The assumptions also delimit the result. We use finite stationary irreducible reciprocal chains, instantaneous reversal-even labels, and one aggregate hidden label. We do not cover odd time-reversal variables, nonstationary observations, arbitrary coarse partitions with several unresolved blocks, continuous-state dynamics, or rates with nonreciprocal support. No finite-sample uncertainty theory or experimentally validated estimator is supplied. The original inertia form uses a symmetric first-moment matrix, while Theorem 4.3 handles nonsymmetric moments in every visible dimension through a spectral gap relative to the antisymmetric norm. If that gap vanishes, this certificate gives no positive bound. The exact sharp families of Theorem 7.2 cover every full-rank inertia, but do not classify all compatible data. Full-dimensional feasibility of the smaller-budget class is established here only for the two-visible, three-hidden-state separation. We do not determine the exact value or attainment of $I_3$, and we do not claim the constant $1/16$ is sharp. Formal verification remains future work.

# References

1. D. J. Skinner and J. Dunkel. *Improved bounds on entropy production in living systems*. Proceedings of the National Academy of Sciences **118**, e2024300118 (2021). DOI: [10.1073/pnas.2024300118](https://doi.org/10.1073/pnas.2024300118). Author version: [arXiv:2011.08765](https://arxiv.org/abs/2011.08765).
2. D. J. Skinner and J. Dunkel. *Estimating entropy production from waiting time distributions*. Physical Review Letters **127**, 198101 (2021). DOI: [10.1103/PhysRevLett.127.198101](https://doi.org/10.1103/PhysRevLett.127.198101). Author version: [arXiv:2105.08681v3](https://arxiv.org/abs/2105.08681v3).
3. E. Nitzan, A. Ghosal, and G. Bisker. *Universal bounds on entropy production inferred from observed statistics*. Physical Review Research **5**, 043251 (2023). DOI: [10.1103/PhysRevResearch.5.043251](https://doi.org/10.1103/PhysRevResearch.5.043251).
4. J. van der Meer, B. Ertel, and U. Seifert. *Thermodynamic inference in partially accessible Markov networks: A unifying perspective from transition-based waiting time distributions*. Physical Review X **12**, 031025 (2022). DOI: [10.1103/PhysRevX.12.031025](https://doi.org/10.1103/PhysRevX.12.031025).
5. S. Petkov. *Entropy Production under Hidden-State Reduction: Exact Safety and Non-Testability*. hexagon:2611.00657v1 (19 November 2026; manuscript dated 5 September 2026). [Versioned source](https://hexagonmath.org/2611.00657v1), [PDF](https://hexagonmath.org/pdf/2611.00657v1). Research preprint; Theorem 9.1 and Section 12 are the closest comparison.
6. S. Petkov. *Complete positivity and equilibrium realizations of reversible observations*. hexagon:2611.00658v1 (2026). [Versioned PDF](https://hexagonmath.org/pdf/2611.00658v1). Research preprint concerning the full observed law.
7. M. D. Louwerse and D. A. Sivak. *Information Thermodynamics of the Transition-Path Ensemble*. Physical Review Letters **128**, 170602 (2022). DOI: [10.1103/PhysRevLett.128.170602](https://doi.org/10.1103/PhysRevLett.128.170602). Author version: [arXiv:2106.11511](https://arxiv.org/abs/2106.11511).
8. M. Aznagulov. *Thermodynamic Realizability of Hidden Markov Processes: Attainment, Observable Certificates, an Architecture-Independent Floor, and the Price of Architecture*. arXiv:2609.14623v2 (20 November 2026). [Versioned source](https://arxiv.org/abs/2609.14623v2), [HTML](https://arxiv.org/html/2609.14623v2). Research preprint; its full-path-law contract and total-state convention differ from the finite-moment and hidden-state conventions here.
