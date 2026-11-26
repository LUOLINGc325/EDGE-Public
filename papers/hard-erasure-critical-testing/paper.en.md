# Critical Risk under Hard Erasure Budgets

## Abstract

Consider binary testing between two fixed, fully supported distributions on a finite alphabet. An adversary observes the entire independent sample and may erase a prescribed number of coordinates, while the original positions remain visible. We determine the equal-prior minimax risk when the hard budget equals sample size times total variation distance plus a fixed multiple of its square root. Exact merging of equal-likelihood-ratio letters, followed by an exponentially accurate sign-class reduction, compresses every fixed alphabet to at most three categories. The limiting risk is a Gaussian partial-coupling problem in at most two dimensions. A translation argument establishes continuity of its optimum and justifies passage through the coupling optimization, including couplings that charge the decision boundary. Without tied probabilities the limit has an explicit one-dimensional formula, attained asymptotically by an observed-count threshold, with a quantitative finite-sample bound. We classify exactly when the limiting error reaches one half. Tied letters prevent saturation at every finite critical offset and can retain information that a binary sign coarsening loses. The same hard-budget limits hold for an adversary without the true hypothesis. By contrast, an expected-total-erasure budget yields limiting error one half throughout this window. General risk–transport duality and partial stochastic dominance are used with attribution; the contribution is the complete critical-risk reduction and classification for this experiment.

**Keywords:** robust testing; erasures; critical asymptotics; optimal coupling.

**Research status.** This is a mathematical research manuscript. It has not received external peer review. Formal proof-assistant verification has not been completed. The statements below concern minimax risk values, not convergence of statistical experiments in Le Cam distance. Literature coverage and unavailable versions are specified in Section 11.

# 1. Problem, motivation, and contribution

A first-order contamination threshold does not determine the error probability when the resource budget differs from its threshold by the natural fluctuation scale. In the present problem that scale is $\sqrt n$. Even an arbitrarily large but fixed multiple of this scale can leave a strictly positive testing advantage, and whether complete confusion is possible depends on a precise variance condition and on letters whose probabilities are tied.

The visible-coordinate adaptive subtractive model is already defined in Vallinayagam, Pensia, and Jog [1, Section 7.1], with exactly the prescribed number of erasures. We use at most that number; Lemma 3.1 also proves equality of these two risk values. Their adaptive-model comparisons [1, Theorems 7.6–7.7] use fixed multiplicative slack and constant target errors. Our question is the exact risk in a shrinking, second-order neighborhood of the threshold. We formulate this question here; we do not attribute the exact square-root-window question to an explicit conjecture in [1], or claim to resolve all its sample-complexity questions.

The proof uses established mechanisms. Pydi and Jog [2,3] connect adversarial classification with optimal transport and couplings. Kamihigashi and Stachurski [4] give the one-sided coupling characterization underlying our scalar formula. Distortion-limited source distinguishability and its transport interpretation also have a substantial first-order literature [5,6]. These mechanisms are not claimed as inventions of this paper. We include the finite arguments needed to identify the exact adversarial model and preserve the original coordinate information.

The main result has three substantive components. First, every fixed finite alphabet has the same critical risk as a model with only positive-difference, tied, and negative-difference letters; the finite-sample approximation error is exponentially small. Second, the critical value is a continuous, attained coupling optimum in dimension at most two, and its saturation is completely classified. Third, the classification gives an operational separation between a pathwise resource constraint and a constraint only on its expectation. Explicit scalar thresholds, a quantitative approximation, and a certified mathematical discretization accompany the limit.

# 2. Definitions and main theorem

## 2.1. Visible erasures and the order of optimization

Let $\mathcal X=\{1,\ldots,d\}$, where $d$ is fixed. Let $P=(p_i)$ and $Q=(q_i)$ be distinct probability vectors with $p_i,q_i>0$. Under hypotheses $H_P,H_Q$, respectively, the clean sample has law $P^{\otimes n},Q^{\otimes n}$. Both hypotheses have prior probability $1/2$.

For $0\le k\le n$, let $E_k(x)$ be the finite set of outputs in $(\mathcal X\cup\{\perp\})^n$ obtained from $x$ by replacing at most $k$ coordinates by $\perp$. The output retains its original length and coordinate positions. This is not a channel that hides the deleted positions.

A test $\phi(y)\in[0,1]$ is the probability of deciding $H_P$. The adversary knows the test and observes the complete clean sample, but does not observe its future private randomization. Initially it is allowed different legal kernels under the two hypotheses. Its equal-prior minimax risk is

$$
R_n(k;P,Q)=\inf_\phi\frac12\left[
 \sum_x P^{\otimes n}(x)\bigl(1-\min_{y\in E_k(x)}\phi(y)\bigr)
 +\sum_x Q^{\otimes n}(x)\max_{y\in E_k(x)}\phi(y)
\right].                                      \tag{2.1}
$$

For a fixed test, randomizing the attack cannot improve either finite maximum. Allowing randomized kernels is nevertheless useful when constructing couplings. Equation (2.1) fixes the order of the game: the test is selected before its worst legal attack. This is average Bayes error with equal priors, not the maximum of the two conditional error probabilities.

Write

$$
A=\{i:p_i>q_i\},\quad B=\{i:p_i \lt q_i\},\quad
C=\{i:p_i=q_i\},
$$
$$
a=P(A),\quad b=Q(A),\quad r=P(C)=Q(C),\quad
\delta=\operatorname{TV}(P,Q)=a-b.                \tag{2.2}
$$

Here total variation is $\frac12\sum_i|p_i-q_i|$. Both $A,B$ are nonempty, $0 \lt b \lt a<1-r$, and $0<\delta<1$. Also $r=0$ if and only if $C$ is empty. The full-support assumption is used throughout the asymptotic statements. All limits keep $P,Q,d$ fixed.

## 2.2. The universal critical value

For $r>0$ define

$$
\Sigma_s=
\begin{pmatrix}
s(1-s)&-sr\\
-sr&r(1-r)
\end{pmatrix},\qquad s\in\{a,b\}.               \tag{2.3}
$$

These matrices have determinant $sr(1-s-r)>0$. Let $G_a=N(0,\Sigma_a)$ and $G_b=N(0,\Sigma_b)$ on $\mathbb R^2$. Put $h(z_1,z_2)=z_1+(z_2)_+$. For $r=0$ instead let $G_a=N(0,a(1-a))$, $G_b=N(0,b(1-b))$ on $\mathbb R$, and put $h(z)=z$. In both cases define

$$
M_{a,b,r}(c)=\max_{\gamma\in\Pi(G_a,G_b)}
  \gamma\{h(Z-W)\le c\},\qquad
\mathcal R_{a,b,r}(c)=\frac12 M_{a,b,r}(c),        \tag{2.4}
$$

where $\Pi$ denotes all couplings with the specified marginals. The marginals are Gaussian; the joint coupling need not be jointly Gaussian, and optimizing only a correlation matrix would be a different problem. The maximum in (2.4) exists, as proved below. For $r>0$, the transformed coordinates

$$
U=(Z_1,Z_1+Z_2),\qquad V=(W_1,W_1+W_2)
$$

give the equivalent event $U\le V+c(1,1)$ componentwise. Thus (2.4) is a two-dimensional partial stochastic-order problem.

**Theorem 2.1 (critical risk and saturation).** For any legal integer budgets with

$$
k_n=n\delta+c\sqrt n+o(\sqrt n),\qquad c\in\mathbb R,
$$

one has

$$
\lim_{n\to\infty}R_n(k_n;P,Q)=\mathcal R_{a,b,r}(c).       \tag{2.5}
$$

The function $M=M_{a,b,r}$ is nondecreasing and globally Lipschitz. For every $\eta\ge0$,

$$
0\le M(c+\eta)-M(c)
\le 2\Phi(\eta\kappa_b/2)-1
\le\frac{\eta\kappa_b}{\sqrt{2\pi}},\qquad
\kappa_b^2=\frac{1-r}{b(1-b-r)}.                \tag{2.6}
$$

Here $\Phi$ is the standard normal distribution function; the same formula for $\kappa_b$ applies at $r=0$. Moreover $M(c)>0$ at every finite $c$, $M(c)\to0$ as $c\to-\infty$, and $M(c)\to1$ as $c\to+\infty$. Its exact finite-offset saturation condition is

$$
\mathcal R_{a,b,r}(c)=\frac12
\quad\Longleftrightarrow\quad
r=0,\quad a+b=1,\quad c\ge0.                   \tag{2.7}
$$

Theorem 2.1 classifies all fixed, fully supported finite-alphabet pairs. It does not assert uniform convergence as a nonzero probability gap tends to zero, as the alphabet grows, or as $P,Q$ vary with $n$.

**Theorem 2.2 (explicit branch without ties).** Suppose $r=0$, and write $\sigma_P^2=a(1-a)$, $\sigma_Q^2=b(1-b)$. Then

$$
\mathcal R_{a,b,0}(c)=\frac12\inf_{t\in\mathbb R\cup\{\pm\infty\}}
\left[\Phi\left(\frac{t+c}{\sigma_P}\right)
 +1-\Phi\left(\frac{t}{\sigma_Q}\right)\right].   \tag{2.8}
$$

Each infinite endpoint has value $1/2$ after the prefactor. A threshold on the number of observed, nonerased $A$ letters attains this limit. Section 6 gives an error bound of order $n^{-1/2}$ plus an exponentially small term when $k_n=n\delta+c\sqrt n+O(1)$, and specifies the finite-sample threshold exactly.

**Theorem 2.3 (attacker information and budget type).** If a single hard-budget kernel must be used under both hypotheses, denote the minimax risk by $R_n^{\mathrm{blind}}(k)$. Then

$$
0\le R_n(k)-R_n^{\mathrm{blind}}(k)
\le\frac12\sum_x\min\{P^{\otimes n}(x),Q^{\otimes n}(x)\}
\le\frac12\left(\sum_i\sqrt{p_iq_i}\right)^n.    \tag{2.9}
$$

Consequently all the hard-budget limits above also hold for the hypothesis-blind attacker. By contrast, if a hypothesis-aware attacker need only satisfy an expected total erasure budget $B_n=n\delta+c\sqrt n+o(\sqrt n)$ under each hypothesis, its minimax risk tends to $1/2$ for every fixed $c$. These are distinct classes of budget constraints. We do not claim the expected-budget assertion for the blind attacker without an additional proof.

# 3. Exact finite reductions

## 3.1. Confusability and weighted cuts

For two clean sequences $x,z$, a common legal output exists if and only if

$$
E_k(x)\cap E_k(z)\ne\varnothing
\quad\Longleftrightarrow\quad d_H(x,z)\le k.    \tag{3.1}
$$

Indeed, every differing coordinate must be erased in a common output. Conversely erasing all differing coordinates is legal whenever their number is at most $k$. The threshold is $k$, not $2k$: the erasure mask is itself observed and must coincide in the common output.

**Lemma 3.1 (finite confusability formula).** For every $n$ and legal $k$,

$$
2R_n(k;P,Q)=
\max_{\gamma\in\Pi(P^{\otimes n},Q^{\otimes n})}
\gamma\{d_H(X,Z)\le k\}.                       \tag{3.2}
$$

An optimal test can be chosen deterministic.

**Proof.** Form a bipartite graph whose left and right vertices are clean sequences under $P$ and $Q$. Join exactly the compatible pairs from (3.1). Put vertex capacities $P^{\otimes n}(x)/2$ on the left and $Q^{\otimes n}(z)/2$ on the right. A partial flow is a nonnegative matrix on compatible edges whose row and column sums do not exceed these capacities.

For any test let $u_x=1-\min_{E_k(x)}\phi$ and $v_z=\max_{E_k(z)}\phi$. On each compatible edge a common output gives $u_x+v_z\ge1$. Therefore the total mass of every partial flow is at most the worst risk of this test. This proves the flow lower bound.

For the reverse bound use a minimum weighted vertex cover $(L_0,R_0)$. Uncovered left and right vertices have no compatible edge. Decide $H_P$ on every output that can arise from an uncovered left vertex, and decide $H_Q$ on all other outputs. All uncovered left and right vertices are classified correctly under every legal attack. The risk is at most the cover weight. The finite max-flow/min-cut theorem equates the best cover weight with the maximum partial-flow mass.

To identify this with (3.2), double any optimal partial flow. Its residual row and column masses have equal totals, so they can be completed to a full coupling, for example by a normalized product when the residual mass is positive. A full coupling restricted to compatible edges conversely gives a feasible doubled partial flow. Taking maxima yields (3.2). The cover construction gives the deterministic test. If exactly $k$ erasures are required, (3.1) is unchanged: extend the erasure mask by arbitrary further coordinates until it has size $k$. The same flow/cover proof therefore gives the same risk for exactly and at most $k$ erasures. $\square$

This is a finite, self-contained specialization of the risk–coupling framework in [2,3], not an independent novelty claim for that framework.

## 3.2. Exact reduction to multinomial counts

Let

$$
\mathcal T_n^d=\{u\in\mathbb Z_{\ge0}^d:\textstyle\sum_i u_i=n\},
\quad D(u,v)=\frac12\sum_i|u_i-v_i|
           =n-\sum_i\min(u_i,v_i),              \tag{3.3}
$$

and let $\mu_{n,P},\mu_{n,Q}$ be the multinomial laws on this set.

**Lemma 3.2 (type lifting).** The right-hand side of (3.2) equals

$$
\max_{\gamma\in\Pi(\mu_{n,P},\mu_{n,Q})}
\gamma\{D(U,V)\le k\}.                         \tag{3.4}
$$

**Proof.** Any sequence pair with counts $u,v$ has at most $\sum_i\min(u_i,v_i)$ matching coordinates. Thus $D(u,v)\le d_H(x,z)$ and projection gives one inequality.

For the other, fix $u,v$ and construct two sequences with exactly $\min(u_i,v_i)$ matching copies of each letter. The unmatched letters on the two sides belong to disjoint sets of letter types, so all remaining positions can be paired as mismatches. Their Hamming distance is exactly $D(u,v)$. Apply the same uniform random permutation of the $n$ coordinates to both sequences. Each marginal is uniform over its own type class. Mixing this construction over any coupling of the count vectors gives exactly the product-law marginals, with Hamming distance $D(U,V)$ in every component. $\square$

In particular, positions have not been silently removed from the adversarial model. They are accounted for by the simultaneous permutation lift. A type minimum cover also gives a test depending only on the nonerased counts: decide $H_P$ if those counts can be extended to an uncovered left type. If the same observation extended to an uncovered right type, its at least $n-k$ retained coordinates would force $D(u,v)\le k$, contradicting the cover property. For fixed $d$, the number of types is $\binom{n+d-1}{d-1}$; this is polynomial in $n$, but not a claim of efficiency uniformly over growing $d$ or arbitrary probability-encoding precision.

## 3.3. Merging equal likelihood ratios

**Theorem 3.3 (exact likelihood-ratio merging).** Partition $\mathcal X$ into groups $G$ such that $p_i/q_i$ is constant within each group. If $\bar P,\bar Q$ are the aggregated laws, then

$$
R_n(k;P,Q)=R_n(k;\bar P,\bar Q)
\quad\text{for every }n,k.                     \tag{3.5}
$$

**Proof.** Aggregation does not increase $D$, so projecting a coupling gives the inequality with the fine risk on the left. For the reverse inequality, within a group the conditional letter law is common:

$$
s_i=p_i/P(G)=q_i/Q(G),\qquad i\in G.
$$

Condition on any pair of group counts $(u_G,v_G)$. Draw a common multinomial vector with $\min(u_G,v_G)$ trials and law $s$. Independently draw another such vector with $|u_G-v_G|$ trials, and add it to the side with the larger group count. The two marginal count laws are the required conditional multinomials. All coordinate differences inside this group have the same sign, so their absolute values sum to $|u_G-v_G|$. Carry this out independently across groups, conditional on the coarse counts. The lifted coupling has the original multinomial marginals and preserves $D$ exactly. Apply Lemma 3.2. $\square$

All tied letters can therefore be merged exactly into one category. This argument does not justify exact merging of all positive-difference letters when their likelihood ratios differ.

# 4. Uniform sign-class approximation

Let $\bar P=(a,r,1-a-r)$, $\bar Q=(b,r,1-b-r)$ on the categories $(A,C,B)$, omitting $C$ when it is empty. Define

$$
\Delta_i=|p_i-q_i|\ (i\notin C),\qquad
e_n=2\sum_{i\notin C}\exp(-n\Delta_i^2/8).      \tag{4.1}
$$

**Theorem 4.1 (exponentially accurate three-class reduction).** Uniformly over all legal integer budgets,

$$
0\le R_n(k;\bar P,\bar Q)-R_n(k;P,Q)\le e_n.   \tag{4.2}
$$

**Proof.** Coarsening contracts $D$, proving the first inequality. To lift an optimal coarse coupling, refine the counts within $A$ and $B$ using their correct conditional multinomial laws under $P$ and $Q$. Any coupling of these conditional refinements suffices, including independence. Within $C$, use the shared-prefix construction from Theorem 3.3. This ensures that the contribution to the fine $\ell^1$ distance inside $C$ is exactly the absolute difference of its two total counts. Every lifted marginal is the required fine multinomial law.

Call a pair good if, for each $i\notin C$,

$$
|U_i/n-p_i|<\Delta_i/4,\qquad
|V_i/n-q_i|<\Delta_i/4.                         \tag{4.3}
$$

On a good pair, the sign of $U_i-V_i$ equals the sign of $p_i-q_i$. Hence the total fine distance equals the coarse distance: the sums of absolute differences within $A$ and $B$ have no cancellation, and the same was ensured within $C$. The two-sided Hoeffding inequality and a union bound give, for each marginal, probability at most $2\sum_{i\notin C}\exp(-n\Delta_i^2/8)$ of violating its part of (4.3). This estimate is marginal and therefore holds for every lifted coupling. The probability lost by excluding bad pairs is at most $4\sum_{i\notin C}\exp(-n\Delta_i^2/8)$. Equation (3.4) divides coupling mass by two, giving (4.2). $\square$

The bound is absolute, not relative. It need not be small when some $\Delta_i$ is small and $n$ is moderate. The factor of two between risk and coupling mass is essential.

# 5. Gaussian coupling limit, including ties

## 5.1. The centered count relation

Work first with the aggregated three-category model, with $r>0$. Let $U,V$ be multinomial count vectors with the two aggregated marginals. Define centered vectors in $(A,C)$ coordinates by

$$
Z_n=\frac{(U_A-na,U_C-nr)}{\sqrt n},\qquad
W_n=\frac{(V_A-nb,V_C-nr)}{\sqrt n}.            \tag{5.1}
$$

Whenever $U_A-V_A\ge0$ and $U_B-V_B\le0$, one has the exact identity

$$
D(U,V)=n\delta+\sqrt n\,h(Z_n-W_n).             \tag{5.2}
$$

Indeed, type distance is the sum of positive coordinate differences, and the tied category contributes its positive part. Under any coupling, failure of the two sign inequalities has probability tending to zero exponentially: each wrong sign requires a deviation of one marginal count from its mean by at least $n\delta/2$. A union bound over the two coordinates and two marginals is uniform over all couplings. For example $4\exp(-n\delta^2/2)$ is a valid bound. Weak inequalities in the good event cause no problem because a zero difference contributes zero.

For $r=0$ use the single $A$ coordinate; (5.2) holds whenever its count difference is nonnegative. Define $M_n(c)$ as the maximum probability of $h(Z_n-W_n)\le c$ over the centered-count couplings. Equation (5.2) implies, with $c_n=(k-n\delta)/\sqrt n$,

$$
\left|2R_n(k;\bar P,\bar Q)-M_n(c_n)\right|
\le 4e^{-n\delta^2/2}.                         \tag{5.3}
$$

The bound is deliberately also used in the one-dimensional case. The multinomial central limit theorem gives the two marginal weak convergences to $G_a,G_b$ defined in Section 2. Weak convergence alone is not enough to pass through the maximum of a closed-event indicator. The next two steps supply what is missing.

## 5.2. Attainment and translation continuity

**Lemma 5.1 (attainment).** The maximum in (2.4) is attained.

**Proof.** Couplings with fixed probability marginals on Euclidean spaces form a tight set: choose compact sets carrying all but an arbitrarily small mass in each marginal and take their product. The set is closed under weak convergence because its marginals are fixed. It is therefore weakly compact by Prokhorov's theorem. The set $\{(z,w):h(z-w)\le c\}$ is closed. The Portmanteau inequality makes its probability upper semicontinuous in the coupling. An upper semicontinuous function on a compact set attains its maximum. $\square$

**Lemma 5.2 (translation modulus).** Inequality (2.6) holds.

**Proof.** Monotonicity is immediate. In two dimensions let $v=(1,0)$; in one dimension let $v=1$. In both cases $h(x+\eta v)=h(x)+\eta$ for every real $\eta$. Start with an optimal coupling at level $c+\eta$. Replace $W$ by $\widetilde W=W+\eta v$. Every previously successful pair now satisfies $h(Z-\widetilde W)\le c$.

The shifted marginal of $\widetilde W$ can be coupled to the original marginal $G_b$ with equality probability $1-\operatorname{TV}(G_b+\eta v,G_b)$. Glue this maximal coupling to $(Z,\widetilde W)$ using its conditional kernel. On the equality event the success condition is preserved. Consequently

$$
M(c)\ge M(c+\eta)-\operatorname{TV}(G_b+\eta v,G_b).
$$

For a positive-definite covariance $\Sigma$, the total variation between $N(0,\Sigma)$ and $N(\eta v,\Sigma)$ is $2\Phi(\eta\sqrt{v^T\Sigma^{-1}v}/2)-1$. To see this directly, whiten both laws and rotate the displacement to the first coordinate. The density comparison changes sign at the midpoint of the two first-coordinate means, and integrating over that half-space gives the displayed expression. Also $2\Phi(x/2)-1\le x/\sqrt{2\pi}$ for $x\ge0$. In two dimensions $(\Sigma_b^{-1})_{11}=(1-r)/[b(1-b-r)]$; at $r=0$ the inverse scalar variance is $1/[b(1-b)]$. These are exactly (2.6). No inverse of a singular three-dimensional covariance is used. $\square$

## 5.3. Passing through the coupling optimization

**Lemma 5.3 (coupling stability under the central limit theorem).** If $c_n\to c$, then $M_n(c_n)\to M(c)$.

**Proof.** Fix $\varepsilon>0$. Marginal weak convergence on Euclidean spaces permits couplings $(Z_n,Z)$ and $(W_n,W)$ such that

$$
\Pr(\|Z_n-Z\|_1>\varepsilon)
+\Pr(\|W_n-W\|_1>\varepsilon)=:\tau_n(\varepsilon)\longrightarrow0. \tag{5.4}
$$

This is the usual coupling characterization of weak convergence (equivalently, the Skorokhod representation theorem applied to each marginal sequence). Norm equivalence makes the chosen $\ell^1$ norm harmless. The function $h$ is 1-Lipschitz for this norm, so on the complement of these two exceptional events its value on a difference changes by at most $2\varepsilon$.

Take any coupling of the two discrete marginals and glue the two marginal approximation kernels to it, conditionally independently given $(Z_n,W_n)$. This produces a Gaussian coupling and shows

$$
M_n(c_n)\le M(c_n+2\varepsilon)+\tau_n(\varepsilon).
$$

Conversely, start from an optimal Gaussian coupling and glue the reverse conditional kernels from the same marginal approximation couplings. The resulting discrete coupling shows

$$
M_n(c_n)\ge M(c_n-2\varepsilon)-\tau_n(\varepsilon).          \tag{5.5}
$$

All conditional kernels exist on the finite/Euclidean standard Borel spaces involved. Crucially, the exceptional probabilities in (5.4) depend only on the marginal approximation couplings, not on the optimized joint law. First let $n\to\infty$, using Lemma 5.2, and then let $\varepsilon\downarrow0$. This proves the claim even if an optimal Gaussian coupling puts positive mass on the boundary. $\square$

Combining Theorem 4.1, (5.3), and Lemma 5.3 proves (2.5). The same proof covers the stated $o(\sqrt n)$ remainder; the faster rate in Section 6 requires the stronger remainder there.

To complete the non-saturation properties in Theorem 2.1, an independent Gaussian coupling assigns positive mass to the nonempty open set $h(Z-W) \lt c$, so $M(c)>0$. For this same fixed coupling, the success probability tends to one as $c\to+\infty$. For negative $c$, the success event implies $Z_1-W_1\le c$; under every coupling it is contained in

$$
\{Z_1\le c/2\}\ \cup\ \{W_1\ge-c/2\}.
$$

The two marginal tail probabilities tend to zero as $c\to-\infty$. This proves the remaining limits uniformly over couplings.

# 6. Explicit no-tie risk and an attaining test

## 6.1. A one-sided count coupling

Assume $r=0$. Let $X_n\sim\operatorname{Bin}(n,a)$ and $Y_n\sim\operatorname{Bin}(n,b)$, with distribution functions $F_{n,a},F_{n,b}$. Define

$$
S_n(k)=\frac12\inf_{j\in\mathbb Z\cup\{\pm\infty\}}
 \{F_{n,a}(j+k)+1-F_{n,b}(j)\}.                 \tag{6.1}
$$

Both infinite endpoints inside braces equal one.

**Lemma 6.1 (finite scalar reduction).** For every legal $k$,

$$
0\le S_n(k)-R_n(k;P,Q)\le e_n.                 \tag{6.2}
$$

**Proof.** In the scalar compatibility graph join counts $x,y$ when $x\le y+k$. Its maximum coupling success probability is the expression inside the infimum in (6.1). One finite proof uses the weighted cover argument of Lemma 3.1: if the smallest uncovered left count is $m$, every right count $y\ge m-k$ must be covered. One can then uncover all left counts at least $m$ without increasing the covered weight. Thus a minimum cover has weight proportional to $F_{n,a}(m-1)+1-F_{n,b}(m-k-1)$. Put $j=m-k-1$ and include the two constant covers. This proves the scalar formula, a discrete case of partial stochastic dominance [4].

For all fine types, $D(U,V)\ge U(A)-V(A)$. Projecting their coupling therefore gives $2R_n\le2S_n$. Lift an optimal scalar coupling to full types using the correct conditional type distributions in $A$ and $B$ under each marginal. On the good event (4.3), $D(U,V)=U(A)-V(A)$ because there are no tied coordinates. The same Hoeffding calculation as in Theorem 4.1 loses at most $2e_n$ in coupling probability, proving (6.2). $\square$

## 6.2. The actual detector and its endpoints

Let $N_A(y)$ be the observed number of nonerased letters in $A$. For an integer $0\le j \lt n-k$, use

$$
\phi_j(y)=\boldsymbol 1\{N_A(y)>j\}.           \tag{6.3}
$$

Under $H_P$ the attacker can reduce that count from $X_n$ to $\max(X_n-k,0)$, so its worst error is $F_{n,a}(j+k)$. Under $H_Q$ the attacker can leave every coordinate intact, maximizing the count at $Y_n$, so its worst error is $1-F_{n,b}(j)$. Thus (6.3) has risk equal to its term in (6.1).

The two constant tests have risk $1/2$. Integers $j<0$ or $j\ge n-k$ in the analytic expression (6.1) cannot improve this value: respectively $F_{n,b}(j)=0$ or $F_{n,a}(j+k)=1$. Therefore choosing a minimizing internal threshold, or a constant test, attains $S_n(k)$ exactly. The analytic CDF expression is not asserted to be the physical threshold risk at an invalid endpoint. When $k=n$, the internal threshold set is empty and the constant tests suffice.

By (6.2) this explicit procedure is within $e_n$ of the minimax risk over all tests, not merely the best among a preselected threshold family.

## 6.3. Uniform quantitative approximation

Let $C_{\mathrm{BE}}$ be any valid universal constant in the classical Berry–Esseen inequality for iid real random variables with finite third absolute centered moment. Put

$$
\beta(s)=C_{\mathrm{BE}}\frac{s^2+(1-s)^2}{\sqrt{s(1-s)}},
\quad L_t=\frac{1/\sigma_P+1/\sigma_Q}{2\sqrt{2\pi}},
\quad c_n=\frac{k-n\delta}{\sqrt n}.            \tag{6.4}
$$

The standard inequality follows here with the Bernoulli third-moment ratio displayed explicitly; no unverified numerical choice of $C_{\mathrm{BE}}$ is required.

**Theorem 6.2 (finite-sample error).** For every $n\ge1$ and legal integer $k$,

$$
\left|R_n(k;P,Q)-\mathcal R_{a,b,0}(c_n)\right|
\le e_n+
\frac{\beta(a)+\beta(b)}{2\sqrt n}
+\frac{L_t}{2\sqrt n}.                         \tag{6.5}
$$

The same bound without $e_n$ holds with $S_n(k)$ in place of $R_n(k)$. Further,

$$
|\mathcal R_{a,b,0}(u)-\mathcal R_{a,b,0}(v)|
\le\frac{|u-v|}{2\sigma_P\sqrt{2\pi}}.         \tag{6.6}
$$

**Proof.** Denote the Gaussian infimum on the right of (2.8) by $T(c)$, without yet identifying it with the coupling value $\mathcal R(c)$. At the lattice points $t_j=(j-nb)/\sqrt n$, the standardized arguments of the two binomial CDFs are respectively $(t_j+c_n)/\sigma_P$ and $t_j/\sigma_Q$. Berry–Esseen bounds the uniform error of their half-weighted sum by $[\beta(a)+\beta(b)]/(2\sqrt n)$. The half-weighted Gaussian objective in (2.8) is globally $L_t$-Lipschitz in $t$. Every real number is within $1/(2\sqrt n)$ of this lattice, so the lattice infimum differs from the real infimum by at most $L_t/(2\sqrt n)$; the identical constant endpoint values are also available. Combining this with (6.2) proves the bound (6.5) with $T(c_n)$ in place of $\mathcal R(c_n)$. The derivative bound in the shift variable $c$, followed by taking infima, gives the modulus (6.6) for $T$. For each fixed $c$, choose $k_n=\lfloor n\delta+c\sqrt n\rfloor$. These estimates show $R_n(k_n)\to T(c)$, while Theorem 2.1 already gives $R_n(k_n)\to\mathcal R(c)$. Uniqueness of the real limit identifies $T(c)=\mathcal R(c)$ for every $c$, establishing all the stated bounds. $\square$

This argument also proves (2.8), without requiring a separate unproved exchange of Gaussian coupling and CDF extrema. For $k_n=\lfloor n\delta+c\sqrt n\rfloor$, add $1/(2\sigma_P\sqrt{2\pi n})$ to (6.5) to compare with $\mathcal R(c)$. For an $O(1)$ remainder use its bound in (6.6). An unspecified $o(\sqrt n)$ remainder yields convergence but need not yield an $O(n^{-1/2})$ rate.

## 6.4. Evaluation and the critical constant

At a finite stationary threshold the derivative vanishes exactly when

$$
\frac{t^2}{\sigma_Q^2}-\frac{(t+c)^2}{\sigma_P^2}
=2\log\frac{\sigma_P}{\sigma_Q}.               \tag{6.7}
$$

Evaluate all real roots together with the two infinite endpoints. One must not assume there is a unique stationary point.

If $\sigma_P=\sigma_Q=\sigma$, the inequality $a>b$ makes this equivalent to $a+b=1$. Direct differentiation, or symmetry about $t=-c/2$, gives

$$
\mathcal R_{a,b,0}(c)=
\begin{cases}
\Phi(c/(2\sigma)),&c<0,\\
1/2,&c\ge0.
\end{cases}                                   \tag{6.8}
$$

For $c<0$, the CDF difference being maximized has its unique positive maximum at $t=-c/2$; for $c\ge0$ it is everywhere nonpositive and has supremum zero at infinity. This explains both branches.

If the variances differ, let $\rho=\max(\sigma_P,\sigma_Q)/\min(\sigma_P,\sigma_Q)>1$. At $c=0$ define

$$
u_\rho=\sqrt{\frac{2\log\rho}{\rho^2-1}},\qquad
D_\rho=\Phi(\rho u_\rho)-\Phi(u_\rho).
$$

Equation (6.7) and symmetry give

$$
\mathcal R_{a,b,0}(0)=\frac{1-D_\rho}{2}.        \tag{6.9}
$$

Since $0 \lt D_\rho<1/2$, this risk lies strictly between $1/4$ and $1/2$. Including equal variances gives $1/4<\mathcal R_{a,b,0}(0)\le1/2$. The lower bound is sharp as an infimum over fixed full-support pairs: take binary $a\uparrow1$, $b=1/2$, so $\rho\to\infty$, $u_\rho\to0$, and $\rho u_\rho\to\infty$. This quarter bound is only for the no-tie, equal-prior, zero-offset branch; no such general bound for tied models is asserted.

# 7. Saturation, tied letters, and information loss

## 7.1. A normal-order obstruction

**Lemma 7.1.** Suppose $X\sim N(0,s^2)$ and $Y\sim N(0,t^2)$ with $s,t>0$. If a coupling satisfies $X\le Y+c$ almost surely for a finite real $c$, then $s=t$ and $c\ge0$.

**Proof.** For every real $u$, $\{Y\le u\}\subseteq\{X\le u+c\}$. Hence

$$
\Phi(u/t)\le\Phi((u+c)/s).
$$

Strict monotonicity of $\Phi$ implies $u/t\le(u+c)/s$ for every $u$. The coefficient of $u$ must vanish, so $s=t$, and the remaining inequality gives $c\ge0$. $\square$

The variance obstruction is a classical aspect of normal stochastic order [4]; its role here is to give a complete classification for the erasure limit.

## 7.2. Proof of the saturation criterion

Suppose $M(c)=1$. Lemma 5.1 supplies an actual coupling with $h(Z-W)\le c$ almost surely. If $r>0$, both

$$
Z_1-W_1\le c,\qquad
(Z_1+Z_2)-(W_1+W_2)\le c                       \tag{7.1}
$$

hold, because $h(z)=\max(z_1,z_1+z_2)$. The corresponding variances are $a(1-a),b(1-b)$ for the first projection and $(a+r)(1-a-r),(b+r)(1-b-r)$ for the second. Lemma 7.1 forces both pairs to be equal. Since $a-b=\delta>0$, their differences factor as

$$
a(1-a)-b(1-b)=\delta(1-a-b),
$$
$$
(a+r)(1-a-r)-(b+r)(1-b-r)=\delta(1-a-b-2r).
$$

Thus $a+b=1$ and $a+b+2r=1$, a contradiction when $r>0$. When $r=0$, Lemma 7.1 instead gives $a+b=1$ and $c\ge0$. Conversely, for those parameters the two scalar Gaussian marginals are identical, so couple $Z=W$. Its success probability is one for every $c\ge0$. This proves (2.7).

Together with positivity from Section 5, tied models have $0<\mathcal R(c)<1/2$ for every finite $c$. The same strict upper inequality holds without ties whenever $a+b\ne1$. It is compatible with $\mathcal R(c)\uparrow1/2$ as $c\to+\infty$; the limiting offset and sample-size quantifiers are different.

## 7.3. A strict operational example for tied letters

Consider the three-letter family

$$
P_r=(3/4,r,1/4-r),\qquad
Q_r=(1/4,r,3/4-r),\qquad 0 \lt r<1/4.              \tag{7.2}
$$

The first letter is $A$, the second is tied, and $\delta=1/2$. If the observation is first coarsened into $A$ versus its complement, the two clean laws become Bernoulli with parameters $3/4,1/4$. Their hard-erasure critical risk is $1/2$ at every $c\ge0$ by (6.8). The coarse problem corresponds to discarding the distinction between the tied and negative-difference letters. Its risk equals the risk of tests restricted to the coarse visible sequence: a coarse attack lifts by using the same coordinate mask on the fine sequence, while a fine attack induces a legal randomized coarse kernel after conditioning on the coarse clean sequence under each hypothesis. Both directions use the full hypothesis-aware attack class.

The full three-letter problem is strictly easier by (2.7). There is an explicit quantitative witness at $c=0$: keep only the larger class $S=A\cup C$ and its complement. This is a two-letter experiment with parameters $3/4+r,1/4+r$ and the same $\delta=1/2$. Coarsening cannot improve testing, so

$$
\mathcal R_{3/4,1/4,r}(0)
\le \mathcal R_{3/4+r,1/4+r,0}(0).             \tag{7.3}
$$

The right-hand side is explicit in (6.9), is strictly below $1/2$, and tends to $1/4$ as $r\uparrow1/4$. Thus discarding the tied category can cause an absolute limiting-risk loss at least arbitrarily close to $1/4$. First take $n\to\infty$ for each fixed $r$, then consider the resulting constants as $r\uparrow1/4$; no triangular-array conclusion is implied. This is a lower bound on the loss, not an assertion that the full three-letter risk equals the single-projection bound.

For $r=0.24$, the two projection variances are $0.0099$ and $0.2499$, so $\rho^2=833/33$. The right-hand side of (7.3), evaluated through (6.9), is approximately $0.3378920593$. The coarse $A$-only limit is $0.5$, yielding a loss lower bound of approximately $0.1621079407$. The exact assertion is (7.3) with (6.9); the decimal evaluations are numerical illustrations, not certificates for the unknown two-dimensional optimum.

# 8. Hypothesis-blind attacks and expected budgets

## 8.1. A common hard-budget mechanism

In the blind model, the adversary must choose one kernel $K(y\mid x)$ supported on $E_k(x)$ and use it under both hypotheses. For a fixed test, write $m_x=\min_{E_k(x)}\phi$ and $M_x=\max_{E_k(x)}\phi$. The hypothesis-aware contribution at input $x$ is

$$
\tfrac12\{P^{\otimes n}(x)(1-m_x)+Q^{\otimes n}(x)M_x\}.
$$

For a common kernel, maximizing its contribution chooses $M_x$ if $Q^{\otimes n}(x)\ge P^{\otimes n}(x)$ and $m_x$ otherwise. Subtracting the two optimized contributions gives exactly

$$
\tfrac12\min\{P^{\otimes n}(x),Q^{\otimes n}(x)\}(M_x-m_x).
$$

This lies between zero and half the minimum mass. Summing, and then taking the infimum over all tests, proves the first two inequalities in (2.9). The last follows from $\min(u,v)\le\sqrt{uv}$ and the product factorization. Cauchy–Schwarz, with its equality condition and $P\ne Q$, gives $\sum_i\sqrt{p_iq_i}<1$. The risk gap is therefore exponentially small, proving the asserted common limit. The calculation uses the per-input support constraint; it does not silently transfer to average-budget feasibility.

## 8.2. A different resource constraint

Define $\overline R_n(B)$ by allowing separate kernels under the two hypotheses, still using visible erasures, but imposing only $\mathbb E_H[\#\text{erasures}]\le B$ under each $H$. The expectation includes the clean sample and the attacker's randomization. There is no pathwise cap below $n$.

Put $m_i=\min(p_i,q_i)$, so $\sum_i m_i=1-\delta$. Under $H_P$ retain each input letter $i$ independently with probability $m_i/p_i$; under $H_Q$ use probability $m_i/q_i$. Each output coordinate then has the identical law

$$
\Pr(Y=i)=m_i,\qquad \Pr(Y=\perp)=\delta
$$

under both hypotheses, and the whole output has their common product law. Each expected erasure count is $n\delta$. Hence $\overline R_n(B)=1/2$ whenever $B\ge n\delta$.

For $0\le B \lt n\delta$, run this thinning mechanism with probability $\theta=B/(n\delta)$ and otherwise apply the identity kernel, using a single mixture coin for the complete batch. Each hypothesis then satisfies the budget exactly. The two output laws are $\theta L+(1-\theta)P^{\otimes n}$ and $\theta L+(1-\theta)Q^{\otimes n}$, with the product laws viewed on the un-erased outputs. Their total variation is $(1-\theta)\operatorname{TV}(P^{\otimes n},Q^{\otimes n})\le1-\theta$. Every test therefore has Bayes error at least $\theta/2$ under these attacks. The constant test gives the reverse universal bound $1/2$.

For $B_n=n\delta+c\sqrt n+o(\sqrt n)$ the budget is nonnegative eventually, and $\min\{1,B_n/(n\delta)\}\to1$. The squeeze proves $\overline R_n(B_n)\to1/2$, completing Theorem 2.3. This expected-total-budget class is not identified with every oblivious subtractive-contamination definition in [1].

# 9. A finite-flow approximation for the tied Gaussian value

The two-dimensional characterization can be approximated with a proven mathematical error bracket. This section does not claim that floating-point quadrature alone is a rigorous certificate.

Use cumulative coordinates $(Z_1,Z_1+Z_2)$ and $(W_1,W_1+W_2)$, with Gaussian laws $\mu,\nu$. Their covariance for parameter $s$ is

$$
\widetilde\Sigma_s=
\begin{pmatrix}
s(1-s)&s(1-s-r)\\
s(1-s-r)&(s+r)(1-s-r)
\end{pmatrix}.                                 \tag{9.1}
$$

Let $K_L=[-L,L]^2$. Partition it by a finite rectangular grid with a fixed half-open boundary convention (including the outer faces of $K_L$), and choose a representative for each cell, so every point of a cell is within $\eta$ of its representative in the $\ell^\infty$ norm. These rectangular grid boundaries have Gaussian mass zero. Put the exact cell masses as capacities on the two sides of a finite bipartite flow. Connect representatives $u_i,v_j$ if

$$
g(u_i-v_j):=\max\{u_{i1}-v_{j1},u_{i2}-v_{j2}\}\le t.
$$

Let $F_{L,\eta}(t)$ be its maximum partial-flow mass, and put $q_L=\mu(K_L^c)+\nu(K_L^c)$.

**Theorem 9.1 (discretization bracket).** For every real $c$,

$$
F_{L,\eta}(c-2\eta)\le M(c)
\le F_{L,\eta}(c+2\eta)+q_L.                  \tag{9.2}
$$

The width of this bracket is at most $8\eta\kappa_b/\sqrt{2\pi}+2q_L$.

**Proof.** Lift any grid partial flow at threshold $c-2\eta$ to the original cell distributions, using their normalized conditional marginals on each occupied edge. Each side's marginal is bounded by the original Gaussian marginal. Perturbing both representatives by at most $\eta$ changes $g$ by at most $2\eta$, so every lifted pair succeeds at level $c$. Complete the residual subprobability marginals to a full coupling. This proves the lower bound.

Conversely, take an optimal coupling at level $c$, discard pairs outside $K_L\times K_L$, losing mass at most $q_L$, and push successful retained pairs to their cell representatives. They form a feasible partial flow at threshold $c+2\eta$, proving the upper bound.

The same two inequalities applied with shifted thresholds give

$$
F_{L,\eta}(c+2\eta)\le M(c+4\eta),\qquad
F_{L,\eta}(c-2\eta)\ge M(c-4\eta)-q_L.
$$

The translation modulus (2.6) therefore gives

$$
\bigl[F(c+2\eta)+q_L\bigr]-F(c-2\eta)
\le\frac{8\eta\kappa_b}{\sqrt{2\pi}}+2q_L.     \tag{9.3}
$$

This proves the claimed convergence estimate. $\square$

As $L\to\infty$ and $\eta\downarrow0$, (9.2) converges to the exact value. Marginal Gaussian tail probabilities bound $q_L$ by a union bound over four one-dimensional tails. If approximate cell capacities are used, the change in a maximum-flow value is at most the sum of the absolute capacity errors on both sides: reduce any flow to the coordinatewise smaller capacities, losing at most that sum, and apply the argument in both directions. Certified probability enclosures can therefore be added to (9.2); ordinary approximate CDF calls are only numerical diagnostics.

# 10. Reproducibility and diagnostic scope

The accompanying exact-arithmetic diagnostic constructs the original clean-sequence/visible-output decision network independently of the count-coupling network. It compares their minimum cuts for rational distributions with $n\le3$ and alphabets of size two or three. It also checks the common-kernel version, enumerates every deterministic detector in small output spaces, tests equal-likelihood-ratio merges including multiple tied letters, and checks sign-class approximations against rational upper bounds. These finite checks audit modeling errors; the proofs above establish the universally quantified results.

Two exact examples clarify the boundaries. For

$$
P=(1/2,3/10,1/5),\quad Q=(1/10,1/5,7/10),\quad n=2,\ k=0,
$$

the fine risk is $39/200$, while the positive/negative sign-coarsened risk is $9/40$, a difference of $3/100$. Thus general sign merging is not finite-sample exact. For binary $P=(1/5,4/5)$, $Q=(3/5,2/5)$, $n=2,k=1$, the hypothesis-aware risk is $1/2$, the blind risk is $17/50$, and their difference $4/25$ is at most the clean Bayes error $13/50$. Thus identical asymptotic limits do not imply identical finite-sample risk.

The delivered reproduction instructions identify the executed commands, exact diagnostic counts, output hashes, and numerical precision conventions. No numerical result is used as a substitute for the Gaussian continuity argument, the saturation proof, or a formal proof-assistant check.

# 11. Literature scope and remaining questions

The direct model comparison uses the complete public text of [1], version 1, dated 23 May 2026; its arXiv record still listed only that version when checked on 26 November 2026. For [2], the corresponding author extended manuscript was inspected and the published journal metadata verified. For [3], the publicly available predecessor arXiv:2201.08956v1 and its conference version were readable, but the final expanded journal text was not obtained. The 2024 volume year and 2023 early-publication DOI are distinguished in the references. The author full text of [4], the author-hosted published text of [5], and relevant sections of the author monograph [6] were also inspected. The novelty audit therefore remains bounded by the retrieved versions and targeted searches. It does not establish global priority.

The generic optimal-transport risk representation, partial stochastic-order formula, normal-order obstruction, concentration inequalities, central limit theorem, and finite max-flow theorem are prior mathematical tools. The contribution asserted here is their complete model-specific bridge: exact likelihood-ratio merging; uniform sign-class compression; the tied, at-most-two-dimensional critical risk; its rigorous continuity and saturation classification; an attaining scalar procedure; and the hard/expected-budget separation. In particular, the first-order total-variation threshold alone is not presented as a new discovery.

The following questions remain outside the proved scope: growing alphabets, vanishing probability gaps or local alternatives $P_n,Q_n$, unknown clean distributions, a sharp quantitative convergence rate for the tied two-dimensional branch, a general closed form for its coupling optimum, and convergence in a distance between entire experiments. A universal bound on the number of retained coordinates is a different constraint from the expected total budget. Neither equal-prior risk nor the results for fixed sample size automatically determine the smallest sample size under every changing contamination fraction.

# References

1. S. Vallinayagam, A. Pensia, and V. Jog. *On the Sample Complexity of Robust Binary Hypothesis Testing*. arXiv:2605.24741v1, 2026. [Record](https://arxiv.org/abs/2605.24741); [inspected full text](https://arxiv.org/html/2605.24741v1).

2. M. S. Pydi and V. Jog. *Adversarial Risk via Optimal Transport and Optimal Couplings*. IEEE Transactions on Information Theory **67**(9), 6031–6052, 2021. DOI: [10.1109/TIT.2021.3100107](https://doi.org/10.1109/TIT.2021.3100107). [Inspected author manuscript](https://arxiv.org/abs/1912.02794v2); [ICML 2020 predecessor](https://proceedings.mlr.press/v119/pydi20a.html).

3. M. S. Pydi and V. Jog. *The Many Faces of Adversarial Risk: An Expanded Study*. IEEE Transactions on Information Theory **70**(1), 550–570, 2024; early publication 2023. DOI: [10.1109/TIT.2023.3303221](https://doi.org/10.1109/TIT.2023.3303221). [Inspected predecessor, not the final expanded text](https://arxiv.org/html/2201.08956v1).

4. T. Kamihigashi and J. Stachurski. *Partial stochastic dominance via optimal transport*. Operations Research Letters **48**(5), 584–586, 2020. DOI: [10.1016/j.orl.2020.07.003](https://doi.org/10.1016/j.orl.2020.07.003). [Inspected author full text](https://johnstachurski.net/pdfs/partial_sd.pdf).

5. M. Barni and B. Tondi. *Source Distinguishability Under Distortion-Limited Attack: An Optimal Transport Perspective*. IEEE Transactions on Information Forensics and Security **11**(10), 2145–2159, 2016. DOI: [10.1109/TIFS.2016.2570739](https://doi.org/10.1109/TIFS.2016.2570739). [Author-hosted published text](https://clem.dii.unisi.it/~vipp/website_resources/publications/journals/2016_TIFS_SourceDistinguishability_Barni_Tondi.pdf).

6. M. Barni and B. Tondi. *Theoretical Foundations of Adversarial Binary Detection*. Foundations and Trends in Communications and Information Theory **18**(1), 1–172, 2021. DOI: [10.1561/0100000102](https://doi.org/10.1561/0100000102). [Author full text](https://clem.dii.unisi.it/~vipp/website_resources/books/theoretical_foundations_of_adv_binary_detection.pdf).
