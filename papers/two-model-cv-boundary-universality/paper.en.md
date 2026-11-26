# A universal boundary kernel for cross-validation after two-model selection

## Abstract

Consider empirical risk minimization between two fixed bounded losses. The losses may share a random component that is correlated with their difference. We prove that the correction from the selected empirical risk to balanced cross-validation has a common Gaussian boundary profile in mean square. The profile depends on the full-sample loss difference and is independent, to first order, of the fold partition. Our proof uses a distribution-function normal approximation against bounded-variation functions; it requires neither a lattice assumption nor a density. Consequently the same profile holds for every convex average of balanced partitions whose joint design is independent of the observations, including dependent repetitions and complete averaging. Along a local exponential tilt, the critical window is the balance between the Cramér cost and half the logarithm of the number of folds. In that window the scaled mean squared error equals the variance of the better fixed loss plus an explicit positive boundary term, whereas the scaled estimation error converges weakly to the normal law with only the former variance. We also give a finite-alphabet extension along arbitrary convergent paths, an explicit disagreement formula for two fixed binary classifiers, and exact label-stratified majority identities that delimit the independence assumption. These are written mathematical results; formal verification and external peer review are separate and have not been completed.

# 1. Question, contribution, and scope

Cross-validation evaluates a fitted rule on observations excluded from its training sample. Repeating the split reduces randomness arising from the partition, but a discontinuous selection rule can also create a sample-level boundary effect. The distinction between the risk of the rule fitted to the observed data and risk averaged over new training samples is essential [1]. Here the target is always the conditional test risk of the action selected on the entire observed sample.

The main contribution is a distribution-reusable **mean-square boundary representation**, rather than the observation that split estimates are correlated. It applies to arbitrary bounded joint loss distributions and explicitly retains their common random loss. The representation controls all data-independent convex split averages at once. A second calculation then identifies the exact critical risk term and its separation from the normal weak-limit variance. The proof separates the general boundary geometry from the covariance of the common loss, so no independence or complementarity of the two losses is imposed.

Several important phenomena are already known. The sharp fair-label majority CV calculation and its fold-dependent worst-case rate are due to Nachum, Urbanke and Weinberger [2,3]. Their longer analysis already explains rare nearly tied samples. The general two-block covariance factorization is also established in [2, Lemma 5]; the identity below specializes that device while retaining the correlated common loss. Lei's hard-argmax CV example [4, Section 5.3] is directly adjacent to two-action selection; his Section 7.1 asks about the variance benefit of repeated CV. Subsequent general variance and repetition identities appear in O'Connell and Speiser [5]. Our exact conditional repetition identity is an established variance-decomposition principle, not a new discovery. Our contribution is the general bounded-loss kernel and the precise boundary contribution retained by every independent convex design. The Bernoulli repetition and margin specialization is not claimed here as an independent contribution.

Stability-based central limit theorems already distinguish different approximation strengths [6,7]. A normal weak limit with nonconverging second moments does not contradict a theorem that assumes stronger moment control. In particular, [5, Theorem 5(a)] has explicit replacement-difference moment conditions; it is not dismissed merely because a first-order dominance condition fails. Also, our result does not imply fixed-level normal confidence intervals must undercover: weak convergence can still give their usual limiting quantile coverage.

The candidates are two **fixed loss functions**, not two arbitrary training procedures refitted inside each fold. There are independent observations within each row, equal fold sizes, and a deterministic tie convention. Data-adaptive splits or weights, signed combinations, unequal folds, dependent observations, unbounded losses, and an increasing number of actions are not covered. The result is about a class of CV estimators, not an information-theoretic lower bound for every risk estimator.

# 2. Model and exact identities

## 2.1 Two losses and their risk target

Let $(A,X)$ have a fixed joint law $Q_0$, with $|A|,|X|\leq B<\infty$,

$$
E_0X=0,\qquad E_0X^2=\sigma^2>0.
$$

Define the two losses $L_0=A+X/2$ and $L_1=A-X/2$. A common affine rescaling can place bounded losses in $[0,1]$ when desired. All formulas retain their original loss units. No restriction is placed on the dependence between $A$ and $X$.

For real $\theta$ let

$$
\psi(\theta)=\log E_0 e^{\theta X},\qquad
\frac{dP_\theta}{dQ_0}=e^{\theta X-\psi(\theta)},\qquad
\mu_\theta=\psi'(\theta),\quad a_\theta=E_\theta A.                 \tag{2.1}
$$

The parameter may depend on the sample size. Each row consists of $n=km$ independent observations from $P_\theta$, where $k\geq2$ and $m\geq1$ are integers. Set

$$
q(t)=\begin{cases}1&t>0,\\-1&t\leq0.\end{cases}
$$

The empirical minimizer selects $L_1$ if its training contrast sum is positive, and $L_0$ otherwise. Thus all ties select $L_0$. For $T=\sum_{i=1}^nX_i$, the full-sample conditional test risk is

$$
R_n=a_\theta-\frac{\mu_\theta}{2}q(T).                         \tag{2.2}
$$

It is random because the selected action is random.

## 2.2 Partitions and aggregation

A balanced partition $\pi$ has $k$ disjoint folds of size $m$. Write $U_j$ for the sum of the contrasts in fold $j$, and $\bar A=n^{-1}\sum_i A_i$. Its CV estimate is

$$
C_\pi=\bar A-\frac1{2n}\sum_{j=1}^k U_jq(T-U_j).              \tag{2.3}
$$

An admissible design is any external random choice of a probability measure $\alpha$ on the finite set of balanced partitions, independent of the entire loss-pair sample. The estimate is $C_\alpha=\sum_\pi\alpha(\pi)C_\pi$. This includes a deterministic partition, any number of possibly dependent repetitions, weights depending on their external design, and the uniform average over all partitions. This last estimate is denoted $C_\infty$; it equals complete leave-$m$-out CV by counting how often each held-out subset occurs. Independence from labels alone is insufficient if splits use other parts of the observed loss pairs.

Define $\operatorname{MSE}_\alpha=E_\theta[(C_\alpha-R_n)^2]$, with expectation over both the observed sample and any external design randomness. For every nonnegative integer $r$, let $S_r$ denote a sum of $r$ independent contrasts under the law currently in use; $S_0=0$.

All statements uniform over designs mean that the error bound has no dependence on the probability measure or on the size and dependence structure of the chosen family. There is no claim of uniformity over all base laws with unrestricted variance or bound constants.

## 2.3 Boundary decomposition

**Lemma 2.1 (exact boundary decomposition).** For every observation vector and balanced partition,

$$
C_\pi-R_n=B_n+D_\pi,\qquad
B_n=\bar A-a_\theta-\frac{q(T)}2(T/n-\mu_\theta),               \tag{2.4}
$$

where

$$
D_\pi=\frac1k\sum_{j=1}^k d_T(U_j),\qquad
d_t(u)=\begin{cases}(u/m)\mathbf1_{\{u\geq t\}}&t>0,\\
(-u/m)\mathbf1_{\{u \lt t\}}&t\leq0.
\end{cases}                                                   \tag{2.5}
$$

In particular $D_\pi\geq0$, and it equals CV minus the empirical risk of the action selected on the full sample. At fixed $t$, the function $d_t$ is nondecreasing when $t>0$ and nonincreasing when $t\leq0$.

*Proof.* Subtract the selected empirical risk $\bar A-q(T)T/(2n)$ from (2.3). For $t>0$, a fold changes the fitted sign precisely when $t-u\leq0$, including equality. Its contribution is $u/n$. For $t\leq0$, a change requires $t-u>0$, so $u \lt t$ strictly, and the contribution is $-u/n$. The two cases give (2.5); their contributing $u$ have the required sign. The monotonicity follows directly, including at $t=0$. Subtract (2.2) to obtain (2.4). $\square$

## 2.4 An exact covariance identity for the common loss

Put $Q_j=q(T-U_j)$ and define

$$
Z=\bar A-a_\theta-\frac1{2n}\sum_j(U_j-m\mu_\theta)Q_j,
\qquad H=\frac{\mu_\theta}{2}\left(q(T)-\frac1k\sum_jQ_j\right).
                                                                    \tag{2.6}
$$

Then $C_\pi-R_n=Z+H$. Let $v_A=\operatorname{Var}_\theta A$, $v_X=\operatorname{Var}_\theta X$, $\gamma=\operatorname{Cov}_\theta(A,X)$, and let $W$ be an independent sum of $n-2m$ contrasts, with the empty sum equal to zero. For an independent block sum $U$ of size $m$, set

$$
f_\theta(w)=E_\theta[(U-m\mu_\theta)q(w+U)].                    \tag{2.7}
$$

**Lemma 2.2 (common-loss covariance).** For every fixed balanced partition,

$$
EZ=0,\qquad
EZ^2=\frac{v_A+v_X/4-\gamma E_\theta q(S_{n-m})}{n}
 +\frac{k-1}{4km^2}E_\theta f_\theta(W)^2.                    \tag{2.8}
$$

*Proof.* Each centered held-out sum is independent of its training sign. The diagonal contrast terms contribute $v_X/(4n)$. For two different folds, condition on their common training sum $W$. The product factors into two independent expectations, each equal to $f_\theta(W)$, giving the last term. A centered contrast from one fold is independent of all common-loss observations in other folds jointly with its own training sign, so the corresponding mixed terms vanish. Within its own fold the covariance is $m\gamma E q(S_{n-m})$. Including the factor $-1/n$ from the cross term with $\bar A$ gives $-\gamma E q(S_{n-m})/n$. Finally $\operatorname{Var}(\bar A)=v_A/n$. $\square$

This identity prevents an incorrect replacement of the regular variance by $v_A+v_X/4$: the common-loss covariance is essential.

# 3. Main results

Write $\varphi(z)=(2\pi)^{-1/2}e^{-z^2/2}$ and

$$
h_n=e^{-n\psi(\theta)},\qquad
g_n(t)=\frac{\sigma}{\sqrt m}\varphi\left(\frac{t}{\sigma\sqrt m}\right),
\qquad J_n=\frac{\sigma^2h_n}{2\pi\sqrt{2mn}}.                \tag{3.1}
$$

**Theorem 3.1 (universal boundary kernel).** Suppose $m\to\infty$, $k\to\infty$ and $|\theta|\sqrt m\to0$. For every fixed bounded base law in Section 2, including atomic, continuous, singular, lattice and nonlattice laws,

$$
\sup_\alpha E_\theta\{D_\alpha-g_n(T)\}^2=o(J_n),             \tag{3.2}
$$

where $D_\alpha=\sum_\pi\alpha(\pi)D_\pi$ and the supremum ranges over all admissible designs. Moreover,

$$
E_\theta D_\alpha^2=J_n(1+o(1)),\qquad
E_\theta D_\alpha\leq C h_n/\sqrt n,                          \tag{3.3}
$$

uniformly over these designs. No density or arithmetic-span assumption is required.

**Theorem 3.2 (critical risk and normal weak limit).** Under the same model, suppose $m,k\to\infty$ and assume $\theta$ has an eventual fixed sign $s\in\{-1,1\}$ and

$$
n\psi(\theta)-\tfrac12\log k\longrightarrow c\in\mathbb R.
                                                                    \tag{3.4}
$$

Let $L^{(s)}=A-sX/2$, so $L^{(+1)}=L_1$ and $L^{(-1)}=L_0$, and $v=\operatorname{Var}_0(L^{(s)})$. Uniformly over admissible designs,

$$
E_\theta(C_\alpha-R_n)^2
 =\frac{\operatorname{Var}_\theta(L^{(s)})}n+J_n+o(n^{-1}),        \tag{3.5}
$$

and hence

$$
nE_\theta(C_\alpha-R_n)^2
 \longrightarrow v+\frac{\sigma^2 e^{-c}}{2\pi\sqrt2}.        \tag{3.6}
$$

For any sequence of admissible designs,

$$
\sqrt n(C_\alpha-R_n)\ \Rightarrow\ N(0,v).                  \tag{3.7}
$$

When $v=0$, the latter is the point mass at zero. In every case, the squares of the scaled errors are not uniformly integrable.

The assertion about squares follows from (3.6)-(3.7) and $\sigma^2 e^{-c}>0$. It concerns second-order risk and does not by itself prescribe a confidence interval or a preferred estimator.

**Proposition 3.3 (how much uniform repetition can remove).** Let
$v_n=E\operatorname{Var}_\pi(C_\pi\mid\mathcal D_n)$ for a uniform balanced partition and the complete observed sample $\mathcal D_n$. Under the conditions of Theorem 3.1,

$$
v_n\leq C\frac{h_n}{n\sqrt k}.                              \tag{3.8}
$$

For $R$ conditionally independent uniform repetitions,

$$
\operatorname{MSE}_R=\operatorname{MSE}_\infty+v_n/R.         \tag{3.9}
$$

For every admissible design, including nonuniform deterministic partitions,

$$
0\leq\operatorname{MSE}_\alpha-\operatorname{MSE}_\infty
 \leq v_n.                                                   \tag{3.10}
$$

The exact $1/R$ formula requires the stated conditional independence. In the critical window $nv_n=O(k^{-1})$, whereas $nJ_n$ has a strictly positive limit.

# 4. Normal approximation on shrinking relative windows

This section explains why a local limit theorem, a density, and a lattice restriction are unnecessary when $m\to\infty$. Constants may depend on the fixed bound and positive variance.

**Lemma 4.1 (bounded-variation comparison).** If $S_N$ is a sum of $N$ centered iid bounded contrasts of variance $\sigma^2>0$, and $G_N\sim N(0,N\sigma^2)$, then for every bounded function $F$ of finite total variation,

$$
|E F(S_N)-E F(G_N)|\leq \frac C{\sqrt N}\operatorname{TV}(F).
                                                                    \tag{4.1}
$$

The inequality allows either value at a jump and also isolated point values. In particular every interval $I$, open or closed at either endpoint, satisfies

$$
P_0(S_N\in I)\leq C(|I|+1)/\sqrt N.                        \tag{4.2}
$$

*Proof.* The classical Berry-Esseen inequality bounds the supremum difference of the two distribution functions by $C E|X|^3/(\sigma^3\sqrt N)$ [8]. Integration by parts first proves (4.1) for step functions and then for bounded-variation functions by their signed-variation decomposition. A different value at a discontinuity is handled by its point mass; continuity of the Gaussian CDF bounds any atom of $S_N$ by twice the CDF error. Enlarging $C$ therefore covers every endpoint convention. Apply this bound to an interval indicator and use the maximum Gaussian density $(2\pi N\sigma^2)^{-1/2}$ to obtain (4.2). $\square$

**Lemma 4.2 (bounded-sum tails and tilt).** For a centered block sum $U$ of size $m$,

$$
E_0 e^{tU}\leq e^{Cmt^2},\qquad
P_0(|U|>x\sqrt m)\leq2e^{-c_0x^2}.                          \tag{4.3}
$$

For every fixed nonnegative integer $r$ and $|t|\sqrt m\leq1$,

$$
E_0[(|U|+1)^r e^{|t||U|}]\leq C_r m^{r/2}.                 \tag{4.4}
$$

*Proof.* For any variable supported in an interval of length $2B$, the second derivative of its log-mgf is a variance under a tilted law, at most $B^2$. Since the log-mgf and its first derivative vanish at zero after centering, two integrations give the sub-Gaussian mgf bound. Multiply independent mgfs and optimize the Chernoff bound to obtain (4.3). Integrating this tail gives all fixed moments and their exponential-weighted versions (4.4). The same bounds hold after small tilts and centering, with uniform constants. $\square$

For a full-sample function $F$, exponential tilting gives the exact identity

$$
E_\theta F=h_n E_0[e^{\theta T}F].                           \tag{4.5}
$$

If a block sum $U$ changes the training sign, the full total $T$ lies between $0$ and $U$, with the strict endpoint determined by (2.5). Conditional on $U$, the complement therefore belongs to an interval of length $|U|$. Lemmas 4.1-4.2 imply the following useful bound.

**Lemma 4.3 (localized crossing moments).** If $k,m\to\infty$ and $|\theta|\sqrt m\to0$, then, for $r=0,1,2$,

$$
E_\theta[|U|^r\mathbf1_{\{q(T)\ne q(T-U)\}}]
 \leq C h_n m^{(r+1)/2}/\sqrt n.                            \tag{4.6}
$$

*Proof.* On the crossing event $e^{\theta T}\leq e^{|\theta||U|}$. Condition on $U$ under $Q_0$, apply (4.2) to the independent complement of length $n-m$, and then use (4.4) to bound
$C h_n E_0[|U|^r(|U|+1)e^{|\theta||U|}]/\sqrt n$.
No atom is omitted. $\square$

# 5. Proof of the common boundary kernel

It suffices initially to fix one balanced partition. Put $b=\sigma\sqrt m$ and

$$
b_z(u)=\begin{cases}u\mathbf1_{\{u\geq z\}}&z>0,\\
-u\mathbf1_{\{u \lt z\}}&z\leq0.
\end{cases}
$$

Then $d_{bz}(U)=(\sigma/\sqrt m)b_z(U/b)$ and, for a standard normal $G$,

$$
E b_z(G)=\varphi(z),\qquad
\int_{\mathbb R}\varphi(z)^2\,dz=\frac1{2\sqrt\pi}.         \tag{5.1}
$$

The first identity follows by integrating $u\varphi(u)=-\varphi'(u)$ separately on the two half-lines.

## 5.1 The off-diagonal moment

Take two distinct block sums $U,V$ under $Q_0$ and let $W$ be their independent complement. Conditional on $U=u,V=v$, apply (4.1) to

$$
F_{u,v}(w)=e^{\theta(u+v+w)}d_{u+v+w}(u)d_{u+v+w}(v).
$$

The product is zero unless $u,v$ have the same nonzero sign. Otherwise it is $|uv|/m^2$ on an interval from zero of length $\min(|u|,|v|)$ in the total variable $t=u+v+w$. Its endpoint convention is immaterial to the following bound:

$$
\operatorname{TV}(F_{u,v})
 \leq C\frac{|uv|}{m^2}e^{|\theta|(|u|+|v|)}.               \tag{5.2}
$$

Indeed an exponential restricted to one interval has two endpoint jumps and monotone variation between them, bounded by a constant times its maximum. Averaging (5.2) with (4.4), the Gaussian replacement error in the off-diagonal moment is

$$
O\left(\frac{h_n}{m\sqrt n}\right)=o(J_n).                 \tag{5.3}
$$

For the Gaussian replacement, write its density as
$[\sigma\sqrt{n-2m}]^{-1}\varphi((t-u-v)/(\sigma\sqrt{n-2m}))$.
On $|u|,|v|,|t|\leq Mb$, this density is
$(\sigma\sqrt{2\pi n})^{-1}(1+o(1))$ uniformly. Also
$e^{\theta t}=1+o(1)$ uniformly there. The joint CLT gives $(U/b,V/b)\Rightarrow(G_1,G_2)$, where the two normals are independent. Thus the remaining rescaled integral tends to

$$
\int E[b_z(G_1)b_z(G_2)]\,dz
 =\int\varphi(z)^2\,dz=\frac1{2\sqrt\pi}.                  \tag{5.4}
$$

For explicit domination, the integral of the absolute product is at most
$|uv|\min(|u|,|v|)/m^2$ before rescaling; the tilt adds at most
$e^{|\theta|(|u|+|v|)}$. The Gaussian complement density is at most $C/\sqrt n$. Lemma 4.2 gives uniformly integrable rescaled cubic moments, including their small exponential weights. Truncation at $M$ can therefore be removed after taking the limit. Threshold discontinuities have zero limiting Gaussian measure. We obtain

$$
E_\theta[d_T(U_1)d_T(U_2)]=J_n(1+o(1)).                    \tag{5.5}
$$

The diagonal is $O(J_n)$ by (4.6) with $r=2$. The $k$ diagonal terms in $E D_\pi^2$ have weight $1/k$, whereas the off-diagonal terms have weight $(k-1)/k$. Consequently

$$
E_\theta D_\pi^2=J_n(1+o(1)).                              \tag{5.6}
$$

## 5.2 The mixed moment and the kernel norm

For the mixed moment condition on a single block $U=u$ and replace its complement by a Gaussian. The relevant function of the total is
$e^{\theta t}d_t(u)g_n(t)$. The tilted Gaussian kernel
$e^{\theta t}g_n(t)$ is unimodal, has supremum $O(m^{-1/2})$ and total variation $O(m^{-1/2})$ because $|\theta|\sqrt m\to0$. Restricting it to the crossing interval gives total variation at most $C|u|/m^{3/2}$. Thus the replacement error after expectation is again $O(h_n/(m\sqrt n))$.

In the Gaussian replacement, rescale $t=bz$ and $U=bu$. The compact central limit and the same tail domination give the constant

$$
\int E b_z(G)\varphi(z)\,dz=\int\varphi(z)^2\,dz,
$$

so

$$
E_\theta[D_\pi g_n(T)]=J_n(1+o(1)).                        \tag{5.7}
$$

Finally $e^{\theta t}g_n(t)^2$ is unimodal with supremum and total variation $O(m^{-1})$. Replacing the full sum $T$ by $N(0,n\sigma^2)$ therefore has error $O(h_n/(m\sqrt n))$. A direct Gaussian integral, or $t=bz$ followed by dominated convergence, gives

$$
E_\theta g_n(T)^2=J_n(1+o(1)).                              \tag{5.8}
$$

Combining (5.6)-(5.8) proves $E(D_\pi-g_n(T))^2=o(J_n)$. The $r=1$ crossing estimate gives $E D_\pi\leq C h_n/\sqrt n$.

## 5.3 Uniformity over independent convex designs

Every fixed balanced partition has the same residual mean square by iid exchangeability. For any realized external design, Jensen's inequality gives

$$
\left(\sum_\pi\alpha(\pi)D_\pi-g_n(T)\right)^2
 \leq\sum_\pi\alpha(\pi)(D_\pi-g_n(T))^2.                  \tag{5.9}
$$

Condition on the design and average over the independent data. This proves (3.2) with the same remainder for every design. Cauchy-Schwarz applied to its residual and (5.8) gives the squared norm in (3.3); the first moment follows by linearity. This proves Theorem 3.1.

# 6. Proof of the critical risk theorem

## 6.1 The block-score profile

**Lemma 6.1 (score profile and its squared norm).** Under Theorem 3.1's assumptions, locally uniformly in $z$,

$$
\frac{f_\theta(\sigma\sqrt m z)}{\sigma\sqrt m}
 \longrightarrow 2\varphi(z),                              \tag{6.1}
$$

and

$$
E_\theta f_\theta(W)^2
 =h_n\frac{\sqrt2}{\pi}\frac{\sigma^2m^{3/2}}{\sqrt n}
 (1+o(1)).                                                   \tag{6.2}
$$

*Proof.* Let $Y=(U-m\mu_\theta)/(\sigma\sqrt m)$. Boundedness, $\theta\to0$, and the iid-row CLT give $Y\Rightarrow G$ with uniformly sub-Gaussian tails. Taylor expansion of the mgf gives $\mu_\theta=\sigma^2\theta+O(\theta^2)$, so $m\mu_\theta/(\sigma\sqrt m)\to0$. Hence the normalized expectation in (2.7) tends to $E[Gq(G+z)]=2\varphi(z)$. Truncated first moments converge uniformly over compact thresholds: truncate the tails using (4.3), then use uniform convergence of distribution functions to the continuous normal CDF. This proves (6.1).

Because $E_\theta(U-m\mu_\theta)=0$, the smaller of the two tail representations of $f_\theta$ yields

$$
0\leq f_\theta(\sigma\sqrt m z)/\sqrt m\leq C e^{-c_1z^2}.
                                                                    \tag{6.3}
$$

A harmless enlargement of $C$ covers the vanishing shift of the centered threshold. There is also a useful variation bound. In the tail representation
$f_\theta(w)=2E_\theta[(U-m\mu_\theta)\mathbf1_{\{U>-w\}}]$,
the added jumps have positive weight until $-w$ passes $m\mu_\theta$ and negative weight thereafter. Thus $f_\theta$ is nonnegative and unimodal, with supremum $O(\sqrt m)$, and $\operatorname{TV}(f_\theta^2)=O(m)$. Endpoint values obey the same variation bound.

Set $F(w)=e^{\theta w}f_\theta(w)^2$. The weighted variation is still $O(m)$. To see this without a monotonicity assumption on the product, bound its variation measure by the sum of $e^{\theta w}|d(f_\theta^2)|$ and $|\theta|e^{\theta w}f_\theta^2dw$. For the first part, $|d(f^2)|\leq2\sup f\,|df|$ and $|df|$ is the reflected measure $2|U-m\mu_\theta|P_\theta(U\in du)$. More precisely,

$$
\int e^{\theta w}|df_\theta(w)|
=2e^{-m\psi(\theta)}E_0|U-m\mu_\theta|=O(\sqrt m).
$$

Multiplying by $2\sup f=O(\sqrt m)$ bounds the first part by $O(m)$. The second part is $O(|\theta|m^{3/2})=o(m)$ by (6.3).

Under $Q_0$, apply (4.1) to $W$ of length $N=n-2m$. The change of measure is

$$
E_\theta f_\theta(W)^2
 =e^{-N\psi(\theta)}E_0[e^{\theta W}f_\theta(W)^2].          \tag{6.4}
$$

Here $e^{-N\psi}=h_n(1+o(1))$ since $m\psi=O(m\theta^2)\to0$. The Gaussian replacement error is $O(h_nm/\sqrt n)$, smaller by $m^{-1/2}$ than the claimed leading term. The central Gaussian density is $(\sigma\sqrt{2\pi n})^{-1}(1+o(1))$ on $w=O(\sqrt m)$. Rescaling $w=\sigma\sqrt m z$ and using (6.1), (6.3) gives the integral $\int(2\varphi)^2=2/\sqrt\pi$. Multiplication of these factors gives (6.2). $\square$

## 6.2 From fold selection to full-sample risk

Taylor expansion gives $\psi(\theta)=\sigma^2\theta^2/2+O(|\theta|^3)$. Condition (3.4) implies

$$
\theta\to0,\quad |\theta|\sqrt m\to0,\quad
|\mu_\theta|\sqrt n\to\infty,\quad
h_n\sqrt k\to e^{-c}.                                     \tag{6.5}
$$

For the first claim, $\psi(\theta)\to0$ and strict convexity around its unique minimum zero imply $\theta\to0$; bounded nondegenerate $X$ has mass on both sides of zero, so $\psi$ grows away from its minimum. Also $m\theta^2=O(\log k/k)\to0$, and $n\theta^2\sim(\log k)/\sigma^2\to\infty$.

Chebyshev's inequality implies $E_\theta q(S_{n-m})\to s$. Therefore the first numerator in (2.8) is
$\operatorname{Var}_\theta(A-sX/2)+o(1)$. Lemma 6.1 gives the second term as $J_n(1+o(1))$. In particular $EZ^2=O(n^{-1})$.

From (2.6), Jensen's inequality and (4.6) give

$$
EH^2\leq\mu_\theta^2P_\theta(q(T)\ne q(T-U_1))
 \leq C\mu_\theta^2h_n\sqrt{m/n}.                           \tag{6.6}
$$

Thus $nEH^2\leq C(\mu_\theta^2m)h_n\sqrt k\to0$. Cauchy-Schwarz makes $E(ZH)=o(n^{-1})$. This proves (3.5) for a fixed partition, with the correct full-sample target and arbitrary correlated $A$.

For every admissible design, (3.2) implies
$\|D_\alpha-D_\pi\|_2=o(\sqrt{J_n})=o(n^{-1/2})$ for any fixed reference partition. The $B_n$ in (2.4) is common to all designs. Their error mean squares therefore differ by $o(n^{-1})$, by Cauchy-Schwarz and the just-proved bounded reference norm. This proves (3.5)-(3.6) uniformly.

## 6.3 Weak limit and the failure of uniform integrability

Equation (3.3) and (6.5) give $\sqrt n D_\alpha\to0$ in $L^1$. Also $q(T)=s$ with probability tending to one. On this event $B_n$ is the centered sample mean of $L^{(s)}$. Its bounded iid-row characteristic function has the expansion

$$
E_\theta e^{it(L^{(s)}-E_\theta L^{(s)})/\sqrt n}
=1-\frac{t^2\operatorname{Var}_\theta(L^{(s)})}{2n}+O(n^{-3/2}),
$$

uniformly in the row. Raising to the $n$th power proves the CLT with variance $v$, including $v=0$. An event of vanishing probability can be discarded for weak convergence without a moment claim. Slutsky's theorem proves (3.7). If the squared scaled errors were uniformly integrable, convergence in distribution of their squares would force convergence of their expectations to $v$. Equation (3.6) rules this out. Theorem 3.2 follows.

# 7. Exact repetition identity and a quantitative bound

**Lemma 7.1 (two disjoint sums from a fixed multiset).** Uniformly sample disjoint sets of prescribed sizes from a fixed finite list of real numbers. If $Y_1,Y_2$ are their sums and $f,g$ are both nondecreasing or both nonincreasing, then $\operatorname{Cov}(f(Y_1),g(Y_2))\leq0$.

*Proof.* Sort the labeled list as $x_1\leq\cdots\leq x_n$. The ordered index vector $I$ of the first uniform subset is positively associated. For a direct construction, generate its successive order statistics using independent uniforms and their conditional quantiles. Given previous index $a$ and $r$ remaining choices, the next index is the minimum of a uniform $r$-subset of $\{a+1,\ldots,n\}$. Increasing $a$ amounts to conditioning that minimum to exceed the new threshold, so its distribution increases stochastically. Every resulting index is consequently a nondecreasing function of the independent uniforms. Independent variables are positively associated: the one-dimensional identity
$2\operatorname{Cov}(F(V),G(V))=E[(F(V)-F(V'))(G(V)-G(V'))]\geq0$
and induction by conditional covariance prove this assertion and its preservation under nondecreasing functions.

Now $F(I)=f(\sum_{i\in I}x_i)$ is nondecreasing. If $I$ increases coordinatewise, its ordered complement decreases coordinatewise, as follows by counting indices below every threshold. Coupling the second subset by the same chosen ranks in the two complements shows that $G(I)=E[g(Y_2)\mid I]$ is nonincreasing. Positive association applied to $F$ and $-G$ gives the required nonpositive covariance. If both functions decrease, replace both by their negatives. Repeated list values do not change this argument. $\square$

The lemma is a special case of the classical negative association of permutation distributions; a complete FKG proof appears in [9]. This known dependence fact is an input, not a new CV theorem.

Condition on the **entire observed sample**, not just $T$. Lemma 7.1 applies to $d_T$ because of its common monotonicity direction. Exchangeability of folds then gives

$$
\operatorname{Var}_\pi(C_\pi\mid\mathcal D_n)
\leq \frac1k E_\pi[d_T(U_1)^2\mid\mathcal D_n].              \tag{7.1}
$$

Average (7.1) and use (4.6) with $r=2$ to obtain (3.8). Conditional on the data, independent repetitions average independent centered residuals of variance $v_n$ in expectation; their conditional mean is $C_\infty$. Since $R_n$ is data-measurable, the orthogonal conditional-variance decomposition gives (3.9) exactly.

For (3.10), condition first on any realized admissible design and apply one common independent uniform permutation $Q$ of the sample indices to every partition. The iid sample law and $R_n$ are invariant under this permutation, so the distribution of the original estimation error is unchanged. Each transformed partition is marginally uniform. Conditional on the data and the original design, the average over $Q$ has mean $C_\infty$, giving the lower MSE bound by conditional Jensen. Pointwise convexity, then marginal uniformity, gives the upper bound by the single-partition MSE. Equation (3.9) at $R=1$ finishes the proof. This symmetrization is necessary; a fixed nonuniform original partition need not have conditional expectation $C_\infty$ before the added permutation.

# 8. Beyond a fixed exponential path

**Theorem 8.1 (finite-alphabet paths).** Let the observations lie in a fixed finite alphabet $\mathcal Z$, with fixed bounded losses $L_0,L_1$. In row $n$, sample iid observations from $P_n$ and use the same full-sample selected-risk target, evaluated under $P_n$. Let $P_n(z)\to P_0(z)>0$ for every $z\in\mathcal Z$, and assume $E_{P_0}X=0$, $\operatorname{Var}_{P_0}X=\sigma_0^2>0$, where $X=L_0-L_1$ and $A=(L_0+L_1)/2$. No arithmetic assumption on the values of $X$ is needed. For all sufficiently large $n$, define the unique real solution $\theta_n$ of

$$
E_{P_n}[Xe^{-\theta_n X}]=0,
\qquad I_n=-\log E_{P_n}e^{-\theta_n X}.                     \tag{8.1}
$$

If $k,m\to\infty$, $\theta_n$ has eventual sign $s$, and
$nI_n-\tfrac12\log k\to c$, then every admissible design satisfies

$$
n\operatorname{MSE}_\alpha\longrightarrow
\operatorname{Var}_{P_0}(A-sX/2)+\frac{\sigma_0^2e^{-c}}{2\pi\sqrt2},
                                                                    \tag{8.2}
$$

with normal weak limit of variance $\operatorname{Var}_{P_0}(A-sX/2)$. Its boundary kernel is (3.2) with $h_n=e^{-nI_n}$ and $\sigma=\sigma_0$.

*Proof.* Both signs occur in the fixed contrast support. The left side of (8.1) is strictly decreasing in $\theta$, has opposite signs at the two infinities, and thus has a unique zero. Define

$$
Q_n(z)=e^{-\theta_nX(z)+I_n}P_n(z).
$$

This is a centered probability law and $dP_n/dQ_n=e^{\theta_n X-I_n}$. Continuity and strict monotonicity imply $\theta_n\to0$ and $Q_n\to P_0$. Uniform Taylor expansion on the finite support gives, for $\mu_n=E_{P_n}X$,

$$
\theta_n=\mu_n/\sigma_0^2+o(|\mu_n|),\qquad
I_n=\mu_n^2/(2\sigma_0^2)+o(\mu_n^2).                      \tag{8.3}
$$

These expressions are exact at $\mu_n=0$ with $\theta_n=I_n=0$, and along nonzero subsequences have the stated relative meaning. Also $I_n=D(Q_n\Vert P_n)\geq0$ because $E_{Q_n}X=0$.

Repeat Sections 4-7 row by row with centered base law $Q_n$. Their constants are uniform: the common support bound is fixed, variances stay away from zero, and third moments are bounded. Berry-Esseen, the tilted moment bounds and the rescaled block CLT therefore hold uniformly. The three Gaussian integrals and the score calculation are unchanged. Initially use $\sigma_n^2=\operatorname{Var}_{Q_n}X$ in the kernel; $\sigma_n\to\sigma_0$, and the same bounded-variation comparison followed by a Gaussian integral proves the mean-square difference of the two kernels is $o(e^{-nI_n}/\sqrt{mn})$. The common-loss covariance identity is exact for every row. Thus (8.2) and the weak limit follow exactly as before. $\square$

The proof uses no differentiable parameter path and no equispaced contrast support. It does require the stated positive limiting probabilities on the chosen alphabet. Zero-probability states can be omitted only if they are absent along the entire sequence under consideration.

## 8.1 Two fixed binary classifiers

**Corollary 8.2 (disagreement coefficient).** For two fixed binary classifiers with zero-one paired losses, let

$$
p_+=P(L_0=1,L_1=0),\quad p_-=P(L_0=0,L_1=1),\quad
p_0=1-p_+-p_-.
$$

Assume the fixed joint-loss support has positive limiting probabilities, $p_{+,0}=p_{-,0}>0$, and put
$r_0=E_{P_0}L_0=E_{P_0}L_1$, $d_0=p_{+,0}+p_{-,0}$. Then the saddlepoint quantities are exactly

$$
\theta=\tfrac12\log(p_+/p_-),\qquad
I=-\log\{p_0+2\sqrt{p_+p_-}\}.                             \tag{8.4}
$$

In the critical window of Theorem 8.1,

$$
n\operatorname{MSE}_\alpha\longrightarrow
r_0(1-r_0)+\frac{d_0e^{-c}}{2\pi\sqrt2},\qquad
\sqrt n(C_\alpha-R_n)\Rightarrow N(0,r_0(1-r_0)).             \tag{8.5}
$$

*Proof.* Here $X\in\{-1,0,1\}$, so (8.1) reads $p_+e^{-\theta}=p_-e^\theta$. This gives (8.4). At the limiting tie, $E X^2=d_0$ and either fixed zero-one loss has variance $r_0(1-r_0)$. Apply Theorem 8.1. The case $p_0=0$ is permitted if those zero-contrast states are absent from the fixed support. $\square$

For example the limiting probabilities of $(L_0,L_1)=(0,0),(1,0),(0,1),(1,1)$ may be $(0.5,0.2,0.2,0.1)$. Then $r_0=0.3$, $d_0=0.4$, and the regular variance is $0.21$, whereas the critical second-moment limit is $0.21+0.4e^{-c}/(2\pi\sqrt2)$. This illustrates separately the common error rate and the disagreement probability; it is not a fitted-data recommendation.

# 9. Why data independence matters: an exact design contrast

This section specializes to majority classification solely to delimit the design assumption. Stratification quantization and its odd/even effect already have a direct precedent in Parker, Günter and Bedo [10]; those qualitative observations are not new here.

Let $X_i\in\{-1,1\}$, $P(X_i=1)=p$, $\mu=2p-1$, $A=1/2$. A label-balanced partition assigns either $\lfloor N_+/k\rfloor$ or $\lceil N_+/k\rceil$ positive labels to each size-$m$ fold, where $N_+=(n+T)/2$. Such a partition always exists by first allocating the positive counts and then filling the remaining positions with negative labels. It depends on the observed labels and so is not an admissible independent design.

**Proposition 9.1 (exact stratified correction).** With the same tie convention as before, if $m$ is even,

$$
D_{\mathrm{strat}}=\frac2n\mathbf1_{\{T=2\}},\qquad
\operatorname{MSE}_{\mathrm{strat}}
=\frac{1-\mu^2}{4n}+\frac{2\mu}{n}P_\mu(T=2).              \tag{9.1}
$$

If $m$ is odd, let $\delta=n\bmod2$ and $a=(k+\delta)/(2n)$. Then

$$
D_{\mathrm{strat}}=a\mathbf1_{\{T=\delta\}},\qquad
\operatorname{MSE}_{\mathrm{strat}}
=\frac{1-\mu^2}{4n}
 +[a^2-\delta a/n+(2\delta-1)a\mu]P_\mu(T=\delta).           \tag{9.2}
$$

*Proof.* If $m$ is even and $T=2s$, each fold sum is either $2\lfloor s/k\rfloor$ or $2\lceil s/k\rceil$. For $s\leq0$ these sums are at least $T$, and no sign changes. For $s\geq2$ they are at most $T-2$, again with no changes. For $s=1$, exactly one fold has sum $2$ and the rest have sum zero; only the former produces a training tie. This proves the first correction.

If $m$ is odd, the fold sums are the adjacent odd integers bracketing $T/k$. For $T\leq-1$ each is at least $T$, and for admissible $T\geq2$ each is strictly less than $T$. A change is therefore possible only at $T=\delta$. When $\delta=0$, half the $k$ fold sums are $-1$, giving $k/(2n)$. When $\delta=1$, $(k+1)/2$ fold sums are $1$ and give a training tie, giving $(k+1)/(2n)$.

In this model $B_n=-q(T)(T/n-\mu)/2$ and $EB_n^2=(1-\mu^2)/(4n)$ exactly. Expand $(B_n+D)^2$. At $T=2$, $B_n=\mu/2-1/n$; at $T=\delta$, $q(T)=2\delta-1$. These values give (9.1)-(9.2), including every parity class and $m=1$. $\square$

**Corollary 9.2 (finite-sample even-fold bound and odd-fold scale).** For every allowed even $m$ and every $p\in[0,1]$,

$$
\left|\operatorname{MSE}_{\mathrm{strat}}-\frac{1-\mu^2}{4n}\right|
\leq\frac8{n\sqrt{n^2-1}}.                                 \tag{9.3}
$$

At $p=1/2$, the MSE is exactly $1/(4n)$ for every even $m$. Still at $p=1/2$, for odd $m$ and $k\to\infty$,

$$
\operatorname{MSE}_{\mathrm{strat}}
=\frac1{4n}+\frac{1+o(1)}{2\sqrt{2\pi n}\,m^2}.             \tag{9.4}
$$

Thus the additional fair-label term is comparable to $1/n$ when $m$ is comparable to $n^{1/4}$.

*Proof.* Write $b_n=2^{-n}\binom n{n/2+1}$. For even $n\geq4$,
$P_\mu(T=2)=b_n(1-\mu^2)^{(n-2)/2}(1+\mu)^2$.
The central-binomial recurrence gives $b_n\leq1/\sqrt{n+1}$: for the central coefficient, induction uses $(2r+1)(2r+3)\leq(2r+2)^2$. Maximizing $u(1-u^2)^{(n-2)/2}$ on $[0,1]$ places its maximum at $u=1/\sqrt{n-1}$ and bounds it by $1/\sqrt{n-1}$. Together with $(1+\mu)^2\leq4$, this proves (9.3). At zero margin, (9.1) is exact baseline. For odd $m$, (9.2) has excess $P_0(T=0)/(4m^2)$ if $n$ is even, or $(1-1/k^2)P_0(T=1)/(4m^2)$ if $n$ is odd. The central or neighboring binomial mass is $\sqrt{2/(\pi n)}(1+O(n^{-1}))$, by Stirling's formula. Since $k\to\infty$, (9.4) follows. $\square$

These identities demonstrate why independent-design quantifiers cannot be replaced by “every CV procedure.” They do not imply stratification repairs arbitrary learning algorithms.

# 10. Verification and reproducibility

The mathematical arguments above prove the asymptotic statements. Independent finite calculations provide separate implementation and constant checks. A rational-arithmetic program enumerates 144,825 ordered samples across 21 distribution/design combinations with a three-valued contrast and a random common loss correlated with that contrast. The distributions include positive, zero and negative mean differences. Direct held-out evaluation is compared with (2.3); the boundary decomposition, centered-score identity, full-risk drift, conditional split variance and orthogonality identities have exactly zero residual. This gives 868,950 pointwise assertions, not 868,950 independent statistical experiments.

Numerical quadrature independently evaluates $\int\varphi^2$ and $\int(2\varphi)^2$. Both routes recover $1/(2\pi\sqrt2)\approx0.1125395395$ to ordinary floating-point precision. These are numerical checks, not certified interval calculations or proofs of a limiting theorem. A separate small-sample majority enumeration checks stratification identities and tie cases. The accompanying `REPRODUCTION.md` specifies commands and limitations; `code/general_two_loss_check.py` and `code/verify_stratification.py` produce the records in `results/`. These paths are relative to this manuscript directory.

This manuscript contains no Lean source or Lean verification and has not undergone external peer review.

# 11. Literature comparison and limitations

The closest fair-majority work [2,3] supplies the direct motivation and already establishes sharp single-partition fair-label behavior. This manuscript does not relabel those results as new. Its leading statement instead identifies a common $L^2$ kernel for **arbitrary bounded two-loss laws**, permitting a random correlated common component and singular nonlattice contrasts. The kernel statement is stronger than an order estimate or a repetition variance decomposition.

Fava's earlier multiple-split theorem [13, Theorem D.1] already provides a repeated-CV weak CLT under its moment and model-function convergence assumptions; its Appendix C uses a fixed number of folds. We do not count weak normality under repetition alone as a new result. Fava [12, Theorem A.1] gives a nonregular cross-fitting CLT that permits a growing number of folds, including leave-one-out, under explicit normalized-score stability and local-covariance conditions. Its random center is the average fitted-fold risk. We do not claim that existing nonregular theories exclude normality, or that that theorem is limited to two folds. The present claim is the explicit sample-level kernel and critical second-moment discrepancy for the stated full-sample risk target.

The hard-argmax example in [4] establishes that discrete selection can violate CV stability. We add neither a claim to have discovered that failure nor a general cure for it. The present shrinking-margin regime has a normal weak limit with a precisely quantified second-moment discrepancy, whereas the zero-gap example motivates nonnormality and stabilization.

Reference [5] analyzes exact variance components and repeated designs, and its normal theorem can include higher-order variance under explicit moment conditions. Our target is the full-sample selected risk, and our theorem computes a rare-boundary term outside any automatic implication from weak normality to mean-square approximation. Exact variance decomposition remains useful in both settings. The empirical and theoretical repeated-split study [11] likewise concerns gains under its stated model and evaluation setup; our result is a specific nonregular limitation, not a contradiction of its empirical gains or a prohibition on repetition.

The JASA comparison [1] is technically relevant through its structural analysis of CV risk targets. It studies ordinary least squares and conditional relationships different from the discontinuous two-action boundary here. This paper neither subsumes that work nor inherits a publication status from the comparison.

The search covered the primary texts and versions listed below, with focused checks of their relevant theorems and discussion. The arXiv main site did not expose readable full text for [5]; its author-attributed same-version PDF was read through the listed mirror. That access distinction is retained. Absence of an equivalent theorem within this bounded search is not a guarantee of global priority. Broader adaptive selection, unbounded tails, fixed fold size, and unequal fold-size optimality remain outside the proved universality theorem.

# References

1. S. Bates, T. Hastie and R. Tibshirani. *Cross-validation: what does it estimate and how well does it do it?* Journal of the American Statistical Association 119(546), 1434-1445 (2024); online 15 May 2023. DOI: [10.1080/01621459.2023.2197686](https://doi.org/10.1080/01621459.2023.2197686). [Author manuscript](https://pmc.ncbi.nlm.nih.gov/articles/PMC11412612/).
2. I. Nachum, R. Urbanke and T. Weinberger. *Minimax Limits of k-Fold Cross-Validation via Majority.* COLT 2026, PMLR 336, 6811-6848. [Official proceedings](https://proceedings.mlr.press/v336/nachum26a.html); [arXiv version 2, 19 June 2026](https://arxiv.org/html/2605.25859v2).
3. I. Nachum, R. Urbanke and T. Weinberger. *The Structure of Cross-Validation Error: Stability, Covariance, and Minimax Limits.* [arXiv:2511.03554v2](https://arxiv.org/html/2511.03554v2), 8 January 2026. Preprint.
4. J. Lei. *A Modern Theory of Cross-Validation through the Lens of Stability.* [arXiv:2505.23592v3](https://arxiv.org/html/2505.23592v3), 28 October 2025. Sections 5.3 and 7.1.
5. N. S. O'Connell and J. L. Speiser. *A Theory of Cross-Validation Variance.* [arXiv:2611.14463v1](https://arxiv.org/abs/2611.14463), 10 November 2026. [Same-version PDF inspected through a mirror](https://arxiv.cnoctave.top/pdf/2611.14463). Sections 4.2 and 5, including Theorem 5(a). Preprint.
6. P. Bayle, A. Bayle, L. Janson and L. Mackey. *Cross-validation Confidence Intervals for Test Error.* NeurIPS 2020. [Official paper](https://papers.nips.cc/paper_files/paper/2020/file/bce9abf229ffd7e570818476ee5d7dde-Paper.pdf).
7. M. Austern and W. Zhou. *Asymptotics of Cross-Validation.* [arXiv:2001.11111v2](https://arxiv.org/html/2001.11111v2). Stability conditions and nonnormal examples.
8. I. Shevtsova. *On the absolute constants in the Berry-Esseen type inequalities for identically distributed summands.* [arXiv:1111.6554](https://arxiv.org/abs/1111.6554), 2011. Only the classical finite universal-constant inequality is used here.
9. D. Dubhashi, V. Priebe and D. Ranjan. *Negative Dependence Through the FKG Inequality.* BRICS RS-96-27 (1996), Theorem 10. DOI: [10.7146/brics.v3i27.20008](https://doi.org/10.7146/brics.v3i27.20008). [Primary full text](https://tidsskrift.dk/brics/article/download/20008/17641/45453).
10. B. J. Parker, S. Günter and J. Bedo. *Stratification bias in low signal microarray studies.* BMC Bioinformatics 8:326 (2007). DOI: [10.1186/1471-2105-8-326](https://doi.org/10.1186/1471-2105-8-326). [Full text](https://pmc.ncbi.nlm.nih.gov/articles/PMC2211509/).
11. C. Eve, G. Varoquaux and T. Moreau. *Crossing the Validation Crisis: Cross-Validation Reduces Benchmarking Variance Surprisingly Well.* [arXiv:2606.12552v2](https://arxiv.org/abs/2606.12552), 20 November 2026. Author PDF identifies the NeurIPS 2026 Evaluations and Datasets track. [Inspected author copy](https://borowiecki.dev/pdf/2606.12552).

12. B. Fava. *Cross-Fitting Under Nonregularity: Normality and Inference via Locality.* [arXiv:2610.02944v1](https://arxiv.org/pdf/2610.02944), submitted 2 October 2026; PDF title date 5 October 2026. Appendix A, Theorem A.1. Preprint.

13. B. Fava. *Training and Testing with Multiple Splits: A Central Limit Theorem for Split-Sample Estimators.* [arXiv:2511.04957v2](https://arxiv.org/html/2511.04957v2). Appendix C and Theorem D.1. Preprint.
