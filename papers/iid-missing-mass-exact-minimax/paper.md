# Good-Turing is asymptotically minimax for missing-mass estimation

26 November 2026

## Abstract

The missing mass of a sample from a discrete distribution is the total probability of symbols absent from that sample. The Good-Turing estimator, the observed singleton count divided by the sample size, has worst-case squared risk asymptotic to \(C/n\), where \(C=0.6080367865\ldots\). The bounds established by Acharya, Bao, Kang and Sun in 2018 have the smaller lower-bound constant \(0.570077\ldots\), obtained from uniform distributions with unknown support. We prove that the Good-Turing constant is the exact asymptotic minimax constant over all discrete distributions. If \(w=W(2)\), then

\[
\lim_{n\to\infty} n\inf_{\widehat M}\sup_p
\mathbb E_p(\widehat M-M_n(p))^2
=\frac w2+\frac{w^2}{4}.
\]

The lower bound uses a normalized Poisson-mixture experiment and a direct Bayesian information inequality for a target depending on both latent intensities and observed counts. A correction by increments of the Good-Turing estimation error transfers the lower bound to every deterministic sample size. The argument explains why efficiency within the uniform subclass does not determine the unrestricted minimax constant. The Poisson-mixture efficiency principle is classical; the proof isolates its normalization and fixed-sample transfer. We also give a self-contained proof of the known sharp upper bound.

## 1. Introduction and scope

Let \(Y_1,\ldots,Y_n\) be independent observations from an unknown probability distribution \(p=(p_i)_{i\ge1}\) on the positive integers. The sample reveals only a finite collection of symbols. The conditional probability that the next observation is a new symbol is the missing mass

\[
M_n(p)=\sum_{i\ge1}p_i\mathbf1\{N_i(n)=0\},
\qquad
N_i(n)=\sum_{j=1}^n\mathbf1\{Y_j=i\}.
\tag{1.1}
\]

This target is random: it depends on the same sample used to estimate it. For an estimator \(\delta_n\), define

\[
R_n(\delta_n,p)=\mathbb E_p\{\delta_n(Y_1,\ldots,Y_n)-M_n(p)\}^2,
\qquad
R_n^*=\inf_{\delta_n}\sup_{p\in\mathcal P}R_n(\delta_n,p),
\tag{1.2}
\]

where \(\mathcal P\) is the class of all probability distributions on the positive integers. Estimators may be randomized, although conditional expectation over their extra randomization cannot increase squared risk. Clipping to \([0,1]\) cannot increase risk either.

Write \(K_1(n)=\sum_i\mathbf1\{N_i(n)=1\}\). The Good-Turing estimator is

\[
G_n=\frac{K_1(n)}n.
\tag{1.3}
\]

Rajaraman, Thangaraj and Suresh [RTS17] established explicit upper and lower bounds for this decision problem. Acharya, Bao, Kang and Sun [ABKS18] identified the sharp worst-case leading constant of \(G_n\) and the different minimax constant for the subclass of uniform laws. Their author working paper asks whether the uniform-subclass constant is also the unrestricted minimax constant [ABKS17]. The two quantities must be distinguished: a distribution maximizing the risk of one estimator need not be least favorable when a restricted model is known.

The efficiency of estimating sums involving observable and latent random variables was developed by Zhang [Z05]. In particular, Robbins's \(u,v\) estimators are efficient in broad Poisson-mixture models. That result concerns a different experiment from (1.2). The present proof uses the exact normalized latent ratio and a deterministic-sample comparison. The final lower bound applies to every estimator, without a local regularity restriction on the estimator.

Painsky [P23] develops generalized Good-Turing procedures and improved risk bounds. Its bibliographic record, abstract, and author-provided software were available for comparison; its full text was not obtained. The comparison below therefore concerns one documented estimator and does not purport to survey all results in that article. This is a limitation of the literature comparison; the theorem is proved directly in Sections 3-6. The mathematical theorem below does not assert that the finite-sample Good-Turing estimator is minimax, admissible, or best for every distribution. It concerns the leading constant of the unrestricted worst-case squared risk. It does not concern multiplicative loss, estimation of expected missing mass as a deterministic parameter, or full-distribution estimation.

**Compatibility with a documented generalized Good-Turing rule.** The author-provided software [P23S] and the explicit formula in [PGKL26, Equation (2)] give the rule

\[
G_n^{\mathrm{GGT}}
=\left(\frac1n-\frac{2.08}{n^{1.7}}\right)K_1(n)
+\frac{4.1}{n^{1.7}}K_2(n),
\qquad K_2(n)=\sum_i\mathbf1\{N_i(n)=2\}.
\tag{1.4}
\]

Since \(K_1(n)\le n\) and \(K_2(n)\le n/2\), deterministically

\[
|G_n^{\mathrm{GGT}}-G_n|
\le4.13\,n^{-0.7}=o(n^{-1/2}).
\]

Writing \(d_n=4.13\,n^{-0.7}\), the uniform bound \(\sup_p R_n(G_n,p)=O(n^{-1})\) from Section 3 implies

\[
\sup_p\bigl|R_n(G_n^{\mathrm{GGT}},p)-R_n(G_n,p)\bigr|
\le2d_n\sqrt{\sup_p R_n(G_n,p)}+d_n^2
=o(n^{-1}).
\]

Thus this rule has the same first-order worst-case risk constant as Good-Turing. This observation verifies compatibility of a specific documented estimator with Theorem 2.1; it is not a new contribution or a claim to have examined the full text of [P23].

## 2. Main theorem

Define

\[
F(c)=(1+c)e^{-c}-e^{-2c},\qquad c>0,
\quad C_* =\sup_{c>0}F(c).
\tag{2.1}
\]

**Theorem 2.1 (sharp asymptotic minimax constant).** For the experiment and loss in (1.1)-(1.2),

\[
\lim_{n\to\infty}nR_n^*=C_*
=\lim_{n\to\infty} n\sup_{p\in\mathcal P}R_n(G_n,p).
\tag{2.2}
\]

If \(w\) is the unique positive solution of \(w\exp(w)=2\), then

\[
C_*=\frac w2+\frac{w^2}4
=0.6080367865228819614\ldots,
\qquad
w=0.8526055020137254913\ldots.
\tag{2.3}
\]

The proof has four components. Section 3 establishes the known upper bound uniformly over countable alphabets. Section 4 gives a Bayesian lower bound for a normalized Poisson-mixture target. Section 5 proves continuity, in mean square, of the Good-Turing estimation error when the sample size changes by a sublinear amount. Section 6 uses that continuity to transfer the lower bound to arbitrary deterministic sample sizes.

## 3. The sharp Good-Turing upper bound

We include the argument to make the asymptotic comparison self-contained. The sharp constant in Proposition 3.3 is the established result of [ABKS17, Theorem 4; ABKS18], with the earlier risk analysis from [RTS17]; it is not a new contribution here. All constants in this section are absolute and all error bounds are uniform over \(p\).

**Lemma 3.1 (elementary exponential approximations).** For fixed \(r\in\{0,1,2\}\) and all sufficiently large \(n\),

\[
\sup_{0\le x\le1}|(1-x)^{n-r}-e^{-nx}|\le\frac{C_r}{n},
\qquad
\sup_{0\le x\le1}x|(1-x)^n-e^{-nx}|\le\frac C{n^2}.
\tag{3.1}
\]

Also \(\sup_{0\le x\le1}x^2(1-x)^{n-2}\le C/n^2\).

*Proof.* For \(x\le1/2\), use

\[
-x-\frac{x^2}{1-x}\le\log(1-x)\le-x.
\]

For fixed \(r\) and \(n\ge2r+2\), the difference in the first inequality is bounded by \(C_r(x+nx^2)\exp(-nx/2)\). Maximizing each monomial after writing \(z=nx\) proves its bound. With \(r=0\), multiplying the corresponding estimate \(Cnx^2\exp(-nx/2)\) by \(x\) gives the second bound. For \(x\ge1/2\), the two exponential terms are exponentially small in \(n\), and the same inequalities follow after enlarging the constants. The last assertion follows by maximizing \(x^2(1-x)^{n-2}\), or directly from \((1-x)^{n-2}\le\exp(-(n-2)x)\). \(\square\)

**Lemma 3.2 (uniform risk expansion).** As \(n\to\infty\),

\[
nR_n(G_n,p)
=\sum_i p_i(1+np_i)e^{-np_i}
-\left(\sum_i p_i e^{-np_i}\right)^2+O(n^{-1}),
\tag{3.2}
\]

uniformly in \(p\in\mathcal P\).

*Proof.* Direct multinomial counting gives, for \(n\ge4\),

\[
\begin{split}
R_n(G_n,p)
={}&\frac1n\sum_i p_i(1-p_i)^{n-1}
+\sum_i p_i^2(1-p_i)^n\\
&-\frac1n\sum_{i\ne j}p_ip_j(1-p_i-p_j)^{n-2}\\
&+\sum_{i\ne j}p_ip_j(p_i+p_j)^2(1-p_i-p_j)^{n-2}.
\end{split}
\tag{3.3}
\]

For example, the two off-diagonal contributions from \(\mathbb E G_n^2\) and \(\mathbb E M_n^2\), together with the cross term, have coefficient

\[
\frac{n-1}{n}+(1-p_i-p_j)^2-2(1-p_i-p_j)
=(p_i+p_j)^2-\frac1n.
\]

Every series in (3.3) is absolutely convergent, so the same computation applies to a countable alphabet by monotone or dominated convergence.

By Lemma 3.1, the last line of (3.3) is \(O(n^{-2})\). Replacing the power terms in the first and third lines by exponentials costs \(O(n^{-2})\), using \(\sum_i p_i=1\) and \(\sum_{i\ne j}p_ip_j\le1\). The diagonal term involving \(p_i^2(1-p_i)^n\) also changes by \(O(n^{-2})\), since it is bounded by

\[
\sum_i p_i\sup_{0\le x\le1}x|(1-x)^n-e^{-nx}|.
\]

Finally, completing the off-diagonal exponential sum to a square changes the risk by at most

\[
\frac1n\sum_i p_i^2e^{-2np_i}
\le\frac1n\sup_{x\ge0}xe^{-2nx}=O(n^{-2}).
\]

Multiplying by \(n\) proves (3.2). \(\square\)

**Proposition 3.3 (known sharp upper constant).** \(\lim_{n\to\infty}n\sup_p R_n(G_n,p)=C_*\).

*Proof.* Let \(\Lambda\) take the value \(np_i\) with probability \(p_i\), and put \(Z=\exp(-\Lambda)\). The right side of (3.2), without its remainder, is

\[
\mathbb E[Z(1-\log Z)]-(\mathbb EZ)^2.
\]

The function \(z(1-\log z)\) is concave on \((0,1]\) and extends continuously at zero. Jensen's inequality bounds this expression by

\[
a(1-\log a)-a^2\le C_*,\qquad a=\mathbb EZ.
\]

For the converse, take a uniform law on \(k_n\) symbols with \(n/k_n\to c\). The leading expression in (3.2) converges to \(F(c)\). Maximize over \(c\). This recovers the sharp bound attributed to [ABKS18]. \(\square\)

In particular, \(R_n^*=O(1/n)\) and \(\limsup_{n\to\infty}nR_n^*\le C_*\).

## 4. A normalized Poisson-mixture lower bound

### 4.1. The experiment and its exact target

Fix \(0\lt a\lt b\lt \infty\). Let \(G_0\) be a probability distribution with a density positive almost everywhere on \((a,b)\) and supported on \([a,b]\). Set

\[
c=\mathbb E_0\Theta,\quad
\mu=\mathbb E_0[\Theta e^{-\Theta}],\quad
m=\mu/c,\quad
\nu=\mathbb E_0[(\Theta+\Theta^2)e^{-\Theta}].
\tag{4.1}
\]

Given a mixing law \(G\), let \((\Theta_i,X_i)\), \(1\le i\le k\), be independent pairs with \(\Theta_i\sim G\) and \(X_i\mid\Theta_i\sim\operatorname{Poisson}(\Theta_i)\). Define

\[
S=\sum_i\Theta_i,\quad N=\sum_iX_i,\quad
p_i=\Theta_i/S,\quad
T_k=\frac{\sum_i\Theta_i\mathbf1\{X_i=0\}}{S}.
\tag{4.2}
\]

The statistician observes all \(k\) counts, including zeros. Conditional on the intensities and \(N\), the counts have the multinomial law with sample size \(N\) and probabilities \(p\). Thus \(T_k\) is exactly the normalized missing mass in that multinomial experiment. No replacement of \(S\) by its expectation is made in the definition.

Let \(h=(h_1,\ldots,h_d)\) be bounded functions of mean zero under \(G_0\). For \(\tau\) in a sufficiently small open neighborhood of zero, let

\[
dG_\tau=(1+\tau^T h)\,dG_0.
\tag{4.3}
\]

Choose the neighborhood so that the density multiplier lies between \(1/2\) and \(3/2\). All resulting mixing laws remain supported on \([a,b]\).

Define the fixed utility and its conditional mean by

\[
u(\theta,x)=\frac{\theta\mathbf1\{x=0\}-m\theta}{c},
\quad q_\tau(x)=\mathbb E_\tau[u(\Theta,X)\mid X=x].
\tag{4.4}
\]

Let the latent score be \(\ell_\tau(\theta)=h(\theta)/(1+\tau^Th(\theta))\) and the observed score be \(s_\tau(x)=\mathbb E_\tau[\ell_\tau(\Theta)\mid X=x]\). Put

\[
I_\tau=\mathbb E_\tau[s_\tau(X)s_\tau(X)^T],
\quad
A_\tau=\mathbb E_\tau\operatorname{Var}_\tau(u(\Theta,X)\mid X),
\tag{4.5}
\]

\[
\gamma_\tau=\mathbb E_\tau\bigl[(u(\Theta,X)-q_\tau(X))\ell_\tau(\Theta)\bigr].
\tag{4.6}
\]

We omit redundant directions so that \(I_0\) is positive definite. All these quantities are continuous near zero. The utility and latent scores are uniformly bounded, and the denominators in their conditional expressions are bounded below by a fixed multiple of the baseline mass function.

### 4.2. Information inequality for arbitrary estimators

**Lemma 4.1 (finite-direction lower bound).** For each direction set in (4.3), there is a sequence of priors \(\pi_k\) supported on \(\|\tau\|\le Ck^{-1/3}\) such that every estimator \(\widehat T_k\) based on the count vector satisfies

\[
\liminf_{k\to\infty}
k\mathbb E_{\pi_k}(\widehat T_k-T_k)^2
\ge A_0+\gamma_0^TI_0^{-1}\gamma_0.
\tag{4.7}
\]

The expectation includes the parameter prior, latent intensities, observed counts, and any independent estimator randomization.

*Proof.* Start with a smooth product density on a fixed cube, positive in its interior, vanishing at its boundary, and with finite Fisher information. Scale this density by \(r_k=k^{-1/3}\) to obtain \(\pi_k\). Its Fisher information matrix is \(J(\pi_k)=O(k^{2/3})=o(k)\).

Write \(U_k=\sum_i u(\Theta_i,X_i)\) and \(Q_\tau=\sum_i q_\tau(X_i)\). For an arbitrary estimator \(W\) of \(U_k\), conditional variance decomposition gives

\[
\mathbb E(W-U_k)^2
=k\mathbb E_{\pi_k}A_\tau+\mathbb E(W-Q_\tau)^2.
\tag{4.8}
\]

Let

\[
J=\sum_{i=1}^k s_\tau(X_i)+\nabla\log\pi_k(\tau)
\]

be the score of the joint observed-data and parameter density. Integration by parts has no boundary term and yields

\[
\mathbb E[(W-Q_\tau)J]
=\mathbb E\nabla_\tau Q_\tau
=k\mathbb E_{\pi_k}\gamma_\tau.
\tag{4.9}
\]

The last equality follows by differentiating a conditional mean: \(\nabla_\tau q_\tau(x)=\operatorname{Cov}_\tau(u,\ell_\tau\mid X=x)\). Conditional independence and the mean-zero property of observed scores give

\[
\mathbb E JJ^T=k\mathbb E_{\pi_k}I_\tau+J(\pi_k).
\tag{4.10}
\]

Matrix Cauchy-Schwarz, applied to (4.9), therefore implies

\[
\frac1k\mathbb E(W-U_k)^2
\ge\mathbb E_{\pi_k}A_\tau
+k\bar\gamma_k^T(k\bar I_k+J(\pi_k))^{-1}\bar\gamma_k,
\tag{4.11}
\]

where bars denote prior averages. Continuity and \(J(\pi_k)=o(k)\) make the right side converge to that in (4.7).

It remains to transfer the sum target to the ratio. Put \(B_k=\sum_i\Theta_i\mathbf1\{X_i=0\}\). Exactly,

\[
T_k-m-U_k/k
=(B_k-mS)\left(\frac1S-\frac1{kc}\right).
\tag{4.12}
\]

The variables \(\Theta_i\) and \(\Theta_i(\mathbf1\{X_i=0\}-m)\) are bounded. Uniformly over \(\|\tau\|\le Cr_k\), their means differ from the corresponding baseline means by \(O(r_k)\). Fourth-moment bounds for sums of independent bounded variables give

\[
\mathbb E_\tau(S-kc)^4+
\mathbb E_\tau(B_k-mS)^4
\le C(k^2+k^4r_k^4).
\]

Since \(S\ge ka\), (4.12) and Cauchy-Schwarz imply

\[
k\mathbb E_{\pi_k}(T_k-m-U_k/k)^2
\le C(k^{-1}+kr_k^4)\longrightarrow0.
\tag{4.13}
\]

Apply (4.11) to \(W=k(\widehat T_k-m)\) and use the \(L^2\) triangle inequality. This proves (4.7). Extra independent randomization can be included throughout the integration; it contributes no score and changes none of the identities. \(\square\)

### 4.3. Exhausting the score space

**Lemma 4.2 (dense observed scores).** The span of the functions \(\mathbb E_0[h(\Theta)\mid X]\), with bounded \(G_0\)-mean-zero \(h\), is dense in \(L^2_0(P_{0,X})\).

*Proof.* Suppose that \(g\in L^2_0(P_{0,X})\) is orthogonal to every such score. Then \(\mathbb E_0[g(X)\mid\Theta]\) is constant \(G_0\) almost everywhere. Choose a closed interval \([a_0,b_0]\subset(a,b)\) with positive \(G_0\) mass. For some \(C>0\),

\[
P_{0,X}(j)\ge C\frac{a_0^j}{j!},\qquad j\ge0.
\]

Cauchy-Schwarz shows that \(H(z)=\sum_{j\ge0}g(j)z^j/j!\) is entire, because on any compact set

\[
\sum_j\frac{|g(j)||z|^j}{j!}
\le\|g\|_{L^2(P_{0,X})}
\left\{C^{-1}\sum_j\frac{(|z|^2/a_0)^j}{j!}\right\}^{1/2}.
\]

The Poisson transform \(\exp(-\theta)H(\theta)\) is constant almost everywhere on \((a,b)\), hence everywhere there by continuity and then everywhere by analytic uniqueness. Consequently \(H(z)=K\exp(z)\) and \(g(j)=K\) for all \(j\). Its mean-zero condition gives \(K=0\). The orthogonal complement is trivial. \(\square\)

Define

\[
v(x)=\frac{\mathbf1\{x=1\}-mx}{c}.
\tag{4.14}
\]

The Poisson identity \(\mathbb E[\mathbf1\{X=1\}\mid\Theta]=\Theta\exp(-\Theta)\) gives

\[
\mathbb E_0[v(X)\mid\Theta]
=\mathbb E_0[u(\Theta,X)\mid\Theta].
\tag{4.15}
\]

Both \(u\) and \(v\) have mean zero at the baseline law. With \(q=q_0\), (4.15) implies

\[
\gamma_{0,j}=\mathbb E_0[(v(X)-q(X))s_{0,j}(X)].
\tag{4.16}
\]

Thus \(\gamma_0^TI_0^{-1}\gamma_0\) is the squared norm of the projection of \(v-q\) onto the chosen finite score span. Lemma 4.2 and orthogonality of \(u-q\) to every function of \(X\) yield

\[
\sup_h\{A_0+\gamma_0^T I_0^{-1}\gamma_0\}
=\mathbb E_0(u-q)^2+\mathbb E_0(v-q)^2
=\mathbb E_0(v-u)^2.
\tag{4.17}
\]

Here the supremum is over finite direction collections. No dimension is allowed to grow inside Lemma 4.1; one first obtains a lower bound for each fixed collection and then takes their supremum.

**Proposition 4.3 (explicit mixture bound).** The supremum in (4.17) equals

\[
\sigma^2(G_0)=\frac{\nu-\mu^2/c}{c^2}.
\tag{4.18}
\]

*Proof.* Set \(r=\mathbf1\{X=1\}-\Theta\mathbf1\{X=0\}\). Conditional on \(\Theta\),

\[
\mathbb Er=0,\quad
\mathbb Er^2=(\Theta+\Theta^2)e^{-\Theta},\quad
\mathbb E[r(X-\Theta)]=\Theta e^{-\Theta},\quad
\mathbb E(X-\Theta)^2=\Theta.
\]

Since \(v-u=\{r-m(X-\Theta)\}/c\), average these identities and use \(m=\mu/c\). \(\square\)

## 5. Changing the sample size

This section controls the estimation error itself, rather than the change in the missing mass. The latter change may be too large at the root-\(n\) scale.

**Lemma 5.1 (Good-Turing error increments).** Fix \(B\lt \infty\). For an i.i.d. sequence with law \(p\) satisfying \(\max_i p_i\le B/n\), put \(E_j=G_j-M_j(p)\). For every \(0\le t\le n\),

\[
\|E_{n+t}-E_n\|_2
\le C_B\left(\frac{\sqrt t}{n}+\frac{t}{n^{3/2}}\right).
\tag{5.1}
\]

*Proof.* Let \(\mathcal F_j\) be the first-\(j\) observation sigma-field, and define

\[
M_{1,j}=\sum_i p_i\mathbf1\{N_i(j)=1\},\quad
Q_{0,j}=\sum_i p_i^2\mathbf1\{N_i(j)=0\}.
\]

For \(Y=Y_{j+1}\), direct counting gives

\[
\Delta E_j
=\frac{\mathbf1\{N_Y(j)=0\}-\mathbf1\{N_Y(j)=1\}-G_j}{j+1}
+p_Y\mathbf1\{N_Y(j)=0\}.
\tag{5.2}
\]

Its conditional mean is \(D_j=Z_j/(j+1)\), where

\[
Z_j=M_j-M_{1,j}-G_j+(j+1)Q_{0,j}.
\tag{5.3}
\]

Write \(p_{\max}=\max_i p_i\). For \(n\le j\le2n\), replacing one observation among the first \(j\) changes at most two occupancy counts. The changes of the four terms in (5.3) are bounded by \(2p_{\max}\), \(2p_{\max}\), \(2/j\), and \(2(j+1)p_{\max}^2\). Their sum is at most \(C_B/j\). The Efron-Stein inequality therefore gives \(\operatorname{Var}Z_j\le C_B/j\).

The exact bias of \(G_j\) is

\[
b_j=\mathbb E E_j=\sum_i p_i^2(1-p_i)^{j-1}.
\]

Hence

\[
\mathbb E Z_j=(j+1)(b_{j+1}-b_j)
=-(j+1)\sum_i p_i^3(1-p_i)^{j-1}=O_B(j^{-1}),
\tag{5.4}
\]

where we used \(\sum_i p_i^3\le p_{\max}^2\). Consequently \(\|D_j\|_2\le C_Bj^{-3/2}\).

Equation (5.2) also gives \(|\Delta E_j|\le C_B/j\). The centered increments \(\xi_{j+1}=\Delta E_j-D_j\) are martingale differences with second moments at most \(C_B/j^2\). Orthogonality and the triangle inequality now imply

\[
\left\|\sum_{j=n}^{n+t-1}\xi_{j+1}\right\|_2\le C_B\sqrt t/n,
\qquad
\left\|\sum_{j=n}^{n+t-1}D_j\right\|_2\le C_Bt/n^{3/2}.
\]

Adding these inequalities proves (5.1). \(\square\)

## 6. Transfer to every deterministic sample size

**Proposition 6.1.** For every baseline mixing law \(G_0\) as in Section 4,

\[
\liminf_{n\to\infty}nR_n^*\ge c\sigma^2(G_0).
\tag{6.1}
\]

*Proof.* Fix a finite direction collection in (4.3), and use the priors from Lemma 4.1. For each \(n\), choose a \([0,1]\)-valued estimator \(\delta_n\) whose worst-case risk is at most \(R_n^*+n^{-2}\). Set

\[
k=k_n=\left\lceil\frac{n+n^{3/4}}c\right\rceil
\tag{6.2}
\]

and consider the experiment (4.2) with \(k\) latent intensities.

Uniformly on the parameter prior's support, \(\mathbb E_\tau\Theta=c+O(k^{-1/3})\). Consequently

\[
\mathbb E_\tau S=n+n^{3/4}+O(n^{2/3}),\qquad
\operatorname{Var}_\tau S=O(n),\qquad
\max_i p_i\le\frac b{ka}\le\frac Bn
\tag{6.3}
\]

for some fixed \(B\). Bounded-variable concentration for \(S\) and conditional Poisson concentration for \(N\) imply, uniformly on this parameter support,

\[
\mathbb P_\tau(N\lt n\text{ or }N>2n)
\le C e^{-c_1 n^{1/2}}.
\tag{6.4}
\]

For completeness, the mean in (6.3) is separated above \(n\) by at least \(n^{3/4}/2\) for large \(n\). A deviation of \(S\) of order \(n^{3/4}\) has probability at most \(C\exp(-c_1n^{1/2})\) by Hoeffding's bound; on its complement the Poisson mean remains above \(n\) by that order and below \(2n\) by a linear order. Standard exponential Markov bounds for a Poisson variable give (6.4). The same mean and variance bounds give

\[
\mathbb E_{\pi_k}(N-n)_+=O(n^{3/4}),\qquad
\mathbb E_{\pi_k}(N-n)^2=O(n^{3/2}).
\tag{6.5}
\]

Conditional on the latent vector, realize the experiment by first drawing \(N\sim\operatorname{Poisson}(S)\) and independently drawing an infinite i.i.d. label sequence with probabilities \(p_i=\Theta_i/S\). Its first \(N\) observations have the required counts. From observed counts the same ordered sample can be generated by an independent uniformly random permutation of the multiset. This randomization gives no information about the latent vector.

On \(\mathcal A=\{n\le N\le2n\}\), define

\[
\widetilde T=\delta_n(Y_1,\ldots,Y_n)+G_N-G_n.
\tag{6.6}
\]

Off \(\mathcal A\), use \(G_N\), with value 1 if \(N=0\). Finally clip the resulting estimator to \([0,1]\), obtaining \(\widehat T\).

On \(\mathcal A\), before clipping,

\[
\widetilde T-M_N
=(\delta_n-M_n)+(E_N-E_n).
\tag{6.7}
\]

Conditional on the latent vector and on \(N\), the first \(n\) labels have law \(p^n\). Thus

\[
\mathbb E_{\pi_k}[(\delta_n-M_n)^2\mathbf1_{\mathcal A}]
\le R_n^*+n^{-2}.
\tag{6.8}
\]

Apply Lemma 5.1 conditionally on the latent vector, separately for each possible \(N\) in \(\mathcal A\). Independence of \(N\) and the label sequence conditional on that vector, together with (6.5), gives

\[
\begin{split}
\mathbb E_{\pi_k}[(E_N-E_n)^2\mathbf1_{\mathcal A}]
&\le C_B\left\{\frac{\mathbb E(N-n)_+}{n^2}
+\frac{\mathbb E(N-n)^2}{n^3}\right\}\\
&=O(n^{-5/4}+n^{-3/2})=o(n^{-1}).
\end{split}
\tag{6.9}
\]

Clipped loss is at most 1 on the exceptional event. Using (6.4), (6.7)-(6.9), and the \(L^2\) triangle inequality yields

\[
\mathbb E_{\pi_k}(\widehat T-T_k)^2
\le\left\{\sqrt{R_n^*+n^{-2}}+o(n^{-1/2})\right\}^2+o(n^{-1}).
\tag{6.10}
\]

The bound \(R_n^*=O(1/n)\) from Section 3 turns the right side into \(R_n^*+o(1/n)\). Lemma 4.1 applies to this possibly randomized estimator. Since \(n/k\to c\), we obtain

\[
\liminf_n nR_n^*\ge c(A_0+\gamma_0^TI_0^{-1}\gamma_0).
\]

This holds for every fixed finite direction collection. Taking the supremum and using (4.17)-(4.18) proves (6.1). \(\square\)

*Proof of Theorem 2.1.* Fix \(c>0\), and let \(G_0\) be uniform on \([c-\varepsilon,c+\varepsilon]\), with \(0\lt \varepsilon\lt c\). It satisfies the assumptions of Section 4 and has mean exactly \(c\). By dominated convergence,

\[
c\sigma^2(G_0)
=\frac{\mathbb E_0[(\Theta+\Theta^2)e^{-\Theta}]}c
-\left(\frac{\mathbb E_0[\Theta e^{-\Theta}]}c\right)^2
\longrightarrow F(c)
\]

as \(\varepsilon\downarrow0\). Proposition 6.1 therefore implies \(\liminf_{n\to\infty}nR_n^*\ge F(c)\) for every \(c>0\). Maximizing over \(c\) and combining with Proposition 3.3 proves (2.2).

More explicitly, fix \(c>0\) and a tolerance \(\eta>0\). First choose a fixed \(\varepsilon\in(0,c)\) for which \(c\sigma^2(G_0)\ge F(c)-\eta\). For this fixed interval law, choose a fixed finite score span whose projection deficit in (4.17), after multiplication by \(c\), is at most \(\eta\). Apply the finite-direction Bayesian argument and the sample-size transfer while holding that interval and span fixed, and then let \(n\to\infty\). This gives \(\liminf_{n\to\infty}nR_n^*\ge F(c)-2\eta\). Only then let \(\eta\downarrow0\). In particular, no score dimension or interval width changes inside an asymptotic estimate that was established only for a fixed direction family.

Finally,

\[
F'(c)=e^{-2c}(2-ce^c).
\]

The map \(c\exp(c)\) increases strictly from 0 to infinity. Thus the unique maximum is at \(w=W(2)\). Substituting \(\exp(-w)=w/2\) gives (2.3). \(\square\)

## 7. Interpretation and limitations

The lower bound is obtained from arbitrarily narrow, but nondegenerate, mixtures of intensities near the uniform point. For each fixed mixture width, the available local mixing directions are rich. Only after taking the sample-size limit and the supremum over finite direction collections do we shrink that width. Setting the width to zero at the outset produces the easier uniform model and loses these directions. The order of these operations is essential.

Theorem 2.1 identifies a global worst-case leading constant. It leaves room for finite-sample improvements, distribution-specific improvements, and substantial gains when prior structural information about \(p\) is available. It does not say that every near-uniform law is asymptotically least favorable under every local formulation. The mixing priors are a lower-bound construction, not an assumption required by the Good-Turing procedure.

Three ingredients in the proof have separate roles. The normalized ratio in (4.2) enforces total probability one exactly. The generalized Bayesian inequality in Lemma 4.1 deals with a sample-dependent target and applies to arbitrary estimators. The increment correction in (6.6) proves a lower bound along every deterministic sample size, rather than merely ruling out an eventually uniform improvement. The classical Poisson-mixture \(u,v\) principle [Z05] motivates the first-order utility, but does not by itself supply these last two transitions in the form needed for (1.2).

The comparison with generalized Good-Turing procedures is restricted to the explicit rule discussed in Section 1. No assertion is made here about every finite-sample refinement or every estimator in [P23].

## References

**[RTS17]** N. Rajaraman, A. Thangaraj and A. T. Suresh. *Minimax Risk for Missing Mass Estimation*. IEEE International Symposium on Information Theory, 2017. Author preprint: https://arxiv.org/abs/1705.05006.

**[ABKS17]** Jayadev Acharya, Yelun Bao, Yuheng Kang and Ziteng Sun. *Mean Squared Error of Missing Mass Estimation*. Author working paper dated 15 December 2017. https://people.ece.cornell.edu/acharya/papers/missing-mass-mse.pdf. Theorem 4 gives the sharp Good-Turing risk; Theorems 5-6 treat the uniform subclass. The conjecture comparing the unrestricted and uniform-subclass minimax risks appears on page 6 of this version.

**[ABKS18]** Jayadev Acharya, Yelun Bao, Yuheng Kang and Ziteng Sun. *Improved Bounds for Minimax Risk of Estimating Missing Mass*. 2018 IEEE International Symposium on Information Theory, 326-330. DOI: https://doi.org/10.1109/ISIT.2018.8437620. Published metadata and the author working paper were inspected; the proceedings text was not separately obtained. Author names are also confirmed by the coauthor's publication list, https://www.zitengsun.com/.

**[Z05]** Cun-Hui Zhang. *Estimation of sums of random variables: Examples and information bounds*. The Annals of Statistics **33**(5), 2022-2041, 2005. DOI: https://doi.org/10.1214/009053605000000390. Author-accessible reprint: https://arxiv.org/pdf/math/0602214. Theorems 2.1-2.5 and Section 2.3 provide the classical sum-estimation and Poisson-mixture efficiency framework; Section 3 discusses a related species model with random total intensity and random sample size.

**[P23]** Amichai Painsky. *Generalized Good-Turing Improves Missing Mass Estimation*. Journal of the American Statistical Association **118**(543), 1890-1899, 2023; first published online 31 January 2022. DOI: https://doi.org/10.1080/01621459.2021.2020658. Bibliographic metadata and abstract inspected; full-text mathematical comparison remains necessary. The abstract alone does not establish the asymptotic order of its improvement, and the comparison in Section 1 concerns only the separately documented estimator.

**[P23S]** Amichai Painsky. Author-provided software accompanying *Generalized Good-Turing Improves Missing Mass Estimation*. The “missing mass bounds” archive linked from https://amichai.sites.tau.ac.il/software; the file *main_experiments.m*, lines 28-29, specifies the two coefficients in (1.4). Archive: https://amichai.sites.tau.ac.il/_files/archives/5bd4ae_e2c1c2fbed2241aa9766e63491f51669.zip?dn=missing+mass+bounds.zip.

**[PGKL26]** Hongxing Pan, Yingying Guo, Wenqing Kuang and Jiashi Lu. *Mind the Unseen Mass: Unmasking LLM Hallucinations via Soft-Hybrid Alphabet Estimation*. arXiv:2604.19162v1, 21 April 2026. https://arxiv.org/html/2604.19162v1. Equation (2) states the explicit generalized Good-Turing rule used in (1.4); no other result from this application paper is needed here.
