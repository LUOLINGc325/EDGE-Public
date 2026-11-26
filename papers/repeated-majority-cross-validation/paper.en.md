# Sharp limits of repeated majority cross-validation

## A universal averaging floor and a logarithmic margin crossover

Collaborative multi-model research system · 26 November 2026

**Research manuscript.** External peer review has not been obtained. The proofs below are written mathematical arguments. Numerical checks are separate diagnostics; The manuscript provides a written proof.

## Abstract

Repeated cross-validation averages away randomness in the allocation of observations to folds, but the sample itself can create an error that persists under complete averaging. We determine this distinction sharply for binary majority classification. Write the sample size as $n=km$, where $k$ is the number of folds and $m$ their common size, and let the labels be independent signs of mean $\mu$. The target is the conditional population risk of the classifier trained on the full sample. For every fixed $C>0$, as $k,m\to\infty$, uniformly over $n\mu^2\le C\log k$ and every label-independent nonnegative convex mixture of balanced partitions, we prove

$$
\operatorname{MSE}
=\frac1{4n}+
\frac{\exp(-n\mu^2/2)}{2\sqrt2\,\pi\sqrt{nm}}
+o\!\left(\frac1n+\frac{\exp(-n\mu^2/2)}{\sqrt{nm}}\right).
$$

The risk of any such mixture exceeds the complete-average risk by at most $O(1/(n\sqrt k))$. Thus even unlimited averaging leaves the same first-order term as a single partition. The exact transition occurs at $n\mu^2-\log k=O(1)$. For bounded local drift, the root-$n$ error nevertheless has a finite weak limit whose mean differs from the limiting means, while the second moments diverge. We give a finite hypergeometric identity, prove the needed local and tail estimates without a hypergeometric limit theorem, include all parity classes, and transfer the result to binary empirical risk minimization on a one-point experiment, with arbitrary tie-breaking.

## 1. Question and contribution boundary

The question is whether spending more computation on redividing the same data changes the leading statistical error of cross-validation near a learning rule's decision boundary. We study a fixed learner and a precisely specified target. The target is the risk of the actual full-sample classifier, not the average risk of a classifier trained on a smaller independent sample.

For one balanced partition and fair random labels, Nachum, Urbanke and Weinberger [1] already obtain the $\sqrt k/n$ scale and its sharp asymptotic constant. Their concluding question asks how algorithm and distribution assumptions permit better risk rates. Our main new claim is the uniform moving-margin law across **every label-independent convex mixture of partitions**, including complete averaging, together with its exact transition window. The fair-label single-partition asymptotic is a consistency check on the theorem, not an independent novelty claim.

Complete leave-out averaging, repeated-split variance decompositions, and majority leave-one-out pathology have substantial precedents [2,3,6,8]. We use these as background. The proof's finite conditioning, telescoping, concentration, and exponential-tilting ingredients are standard tools; their combination here establishes the uniform constants and the error scale needed at the transition. The one-point ERM reduction is also an existing device [1]. The contribution in that reduction is the transfer of the new averaging and margin law.

The scope is deliberately specific. Both $k$ and $m$ must diverge. We do not optimize the fixed-$k$ problem, supply fixed-$m$ constants, cover label-stratified or data-selected partitions, or assert a minimax lower bound for all possible risk estimators.

### 1.1 Closest work and estimands

Celisse and Mary-Huard [2] treat exhaustive leave-out risk estimation for nearest-neighbor classifiers and include a majority-type leave-one-out lower bound. Arlot and Lerasle [3] explicitly separate the repeated-partition variance contribution in a density-estimation model. Neither identified result supplies the joint growing-$k$, growing-$m$, moving-margin formula proved here.

Bates, Hastie and Tibshirani [4] emphasize the distinction between risk conditional on the fitted sample and an algorithm's average risk. Their linear-model results concern a different learner; they motivate keeping the random estimand explicit. Celisse [5] establishes exact leave-out risk properties for projection density estimation, again under different structure. No result below contradicts those model-specific conclusions.

Recent work on cross-fitting under nonregularity [7] addresses normal approximation under quantitative locality assumptions, including a growing-fold extension. It is not a theorem about the present full-sample majority-risk target. Stability-based cross-validation limit theorems also appear in Austern and Zhou [9]. Our explicit weak-limit and moment calculations describe a regime in which the quantitative stability/locality controls of those theorems do not apply.

## 2. Model and principal results

### Definition 2.1. Labels, learner, and target

Let $k\ge2$ and $m\ge1$ be integers and put $n=km$. Let $Y_1,\ldots,Y_n$ be independent with values in $\{-1,+1\}$ and
$$
\Pr_\mu(Y_i=+1)=p=\frac{1+\mu}{2},\qquad -1<\mu<1.
$$
Let $S=\sum_iY_i$, and define the tie convention
$$
\sigma(s)=
\begin{cases}
1,&s>0,\\
-1,&s\le0.
\end{cases}
$$
The full-sample learner predicts $\sigma(S)$. Its conditional population risk is the random variable
$$
L_\mu(S)=\frac12-\frac{\mu\sigma(S)}2.
\tag{2.1}
$$
The randomness in this target is retained in every squared error below.

A balanced partition $\pi=(I_1,\ldots,I_k)$ has disjoint blocks of size $m$ covering $\{1,\ldots,n\}$. Put $V_j=\sum_{i\in I_j}Y_i$. Its cross-validation estimate is
$$
C_\pi=\frac12-\frac1{2n}\sum_{j=1}^kV_j\sigma(S-V_j).
\tag{2.2}
$$
Let $\mathcal P_{n,m}$ be the finite set of balanced partitions. An allowed mixture has the form
$$
C_W=\sum_{\pi\in\mathcal P_{n,m}}W_\pi C_\pi,\qquad
W_\pi\ge0,\qquad \sum_\pi W_\pi=1,
\tag{2.3}
$$
where the entire random vector $W$ is independent of the labels. There is no requirement that the selected partitions be independent or individually uniform. A countable list of repetitions is equivalent to (2.3) after collecting equal partitions.

Write
$$
R_W(n,m,\mu)=\mathbb E_\mu[(C_W-L_\mu(S))^2].
$$
Uniform averaging over all partitions is denoted by $C_*$, with risk $R_*$. It is also exhaustive leave-$m$-out cross-validation: each held-out subset has the same multiplicity in the partition average.

### Theorem 2.2. Uniform sharp law

For every fixed $C>0$, as integers $k,m\to\infty$ and $n=km$,
$$
\sup_{\substack{n\mu^2\le C\log k\\W\ \text{as in }(2.3)}}
\left|
\frac{R_W(n,m,\mu)}
{\,1/(4n)+\exp(-n\mu^2/2)/(2\sqrt2\,\pi\sqrt{nm})\,}-1
\right|\longrightarrow0.
\tag{2.4}
$$
There is no extra relation between $m$ and $\log k$. The assertion includes every parity class and the tie rule in Definition 2.1.

Moreover, uniformly on this margin set, for all sufficiently large $k,m$,
$$
0\le R_W-R_*\le \frac{K_C}{n\sqrt k}
\tag{2.5}
$$
for a constant $K_C$ independent of the mixture.

The proof of (2.4) is completed in Section 6. The result compares the full risks, not just their variances.

### Corollary 2.3. The transition window

Put $a_n=n\mu_n^2-\log k_n$, subject to the assumptions of Theorem 2.2. If $a_n\to a\in\mathbb R$, then uniformly over allowed mixtures,
$$
nR_W\longrightarrow\frac14+
\frac{e^{-a/2}}{2\sqrt2\,\pi}.
\tag{2.6}
$$
If $a_n\to+\infty$, then $R_W\sim1/(4n)$. If $a_n\to-\infty$, the second term in (2.4) dominates. In the original Bernoulli parameter, the transition is
$$
n(p-\tfrac12)^2=\tfrac14\log k+O(1).
\tag{2.7}
$$
The statement $a_n\to+\infty$ is restricted to the displayed moving-margin band; it is not a theorem about arbitrary remote alternatives.

### Theorem 2.4. Weak limits miss the dominant moments

Suppose $k,m\to\infty$ and $\sqrt n\,\mu_n\to b\in\mathbb R$. For every sequence of allowed mixtures,
$$
\sqrt n\,(C_W-L_{\mu_n}(S))
\Longrightarrow
-\frac12Z\,\operatorname{sign}(Z+b),
\qquad Z\sim N(0,1).
\tag{2.8}
$$
The value of the sign at zero does not matter in this limit. Nevertheless,
$$
\sqrt n\,\mathbb E_{\mu_n}(C_W-L_{\mu_n}(S))\to0,
\tag{2.9}
$$
whereas the mean of the limit in (2.8) is $-\phi(b)<0$, with
$\phi(u)=(2\pi)^{-1/2}e^{-u^2/2}$. Also
$$
nR_W\sim\frac{e^{-b^2/2}\sqrt k}{2\sqrt2\,\pi}\to\infty.
\tag{2.10}
$$
The sequence is not uniformly integrable even in first moment. In particular, for fair labels the weak limit is $-|Z|/2$, although every unscaled CV error has mean zero.

### Corollary 2.5. Exact binary ERM on a one-point experiment

Let a binary hypothesis class contain two functions disagreeing at a point $x_0$, and let the input distribution be supported on $x_0$, with label mean $\mu$. Any exact empirical risk minimizer predicts the sample majority at $x_0$ away from ties. Allow arbitrary tie-breaking, including independent internal randomness. The uniform law (2.4), and hence (2.6), still holds for its allowed-mixture CV error against its own full-sample conditional risk.

In particular, the supremum over data distributions of the allowed-mixture CV MSE for every such ERM is at least
$$
(1+o(1))\frac{\sqrt k}{2\sqrt2\,\pi n}
$$
along growing $k,m$. This is a limitation of this class of CV estimators. It is not a lower bound for arbitrary risk estimation procedures.

## 3. Finite identities and a sufficient conditioning statistic

### Lemma 3.1. Error decomposition

The empirical risk of the full-sample majority is
$$
C_{\mathrm{emp}}=\frac12-\frac{|S|}{2n}.
$$
Define
$$
B=-\frac{\sigma(S)}2(S/n-\mu),\qquad
D_\pi=\frac1{2n}\sum_jV_j\{\sigma(S)-\sigma(S-V_j)\}.
\tag{3.1}
$$
Then
$$
C_\pi-L_\mu(S)=B+D_\pi,\qquad D_\pi\ge0,
\quad
\mathbb E_\mu B^2=\frac{1-\mu^2}{4n}.
\tag{3.2}
$$
For a fixed total $s$, put
$$
d_s(v)=
\begin{cases}
v\,1_{\{v\ge s\}},&s>0,\\
-v\,1_{\{v< s\}},&s\le0.
\end{cases}
$$
Then $D_\pi=(km)^{-1}\sum_jd_S(V_j)$.

**Proof.** Subtract (2.1) from (2.2), adding and subtracting $\sigma(S)S/(2n)$. If a positive full-sample majority changes sign after removal, the removed sum is positive and at least $S$. If a nonpositive full-sample majority changes sign, the removed sum is negative and strictly below $S$. These are exactly the two branches of $d_s$, including ties. Finally $\sigma(S)^2=1$, even at zero, so $\mathbb E B^2=\operatorname{Var}(S/n)/4$. $\square$

In particular the empirical-risk estimator has exactly $(1-\mu^2)/(4n)$ MSE for every $n,\mu$. This control shows why the preceding lower bound must not be interpreted as a general impossibility of estimating risk.

### Lemma 3.2. Common conditional mean

Given $S=s$, the label vector is uniform among sign vectors with that total. Thus
$$
g_{n,m}(s):=\mathbb E_\mu[D_\pi\mid S=s]
=\frac1m\mathbb E[d_s(V)\mid S=s]
\tag{3.3}
$$
is independent of $\mu$ and of the fixed partition $\pi$. For every allowed $W$,
$$
\mathbb E[D_W\mid S,W]=g_{n,m}(S),
\qquad D_W=\sum_\pi W_\pi D_\pi.
\tag{3.4}
$$
Complete averaging satisfies $D_*=g_{n,m}(S)$ for each sample.

**Proof.** Every sign placement with $t=(n+s)/2$ positives has probability $p^t(1-p)^{n-t}$. Conditioning removes this common factor. Each fold is consequently a uniformly chosen size-$m$ subset. Independence of $W$ and the labels preserves the conditional law after $W$ is given. Under complete averaging each subset occurs equally often, proving the last assertion. $\square$

### Lemma 3.3. Exact boundary formula

Let $N=n-m$, $\varepsilon=N\bmod2$, and
$$
q_a(x)=2^{-a}\binom a{(a+x)/2},
$$
with value zero if the lower index is invalid. For feasible $s\equiv n\pmod2$, put
$$
t=(n+s)/2,\qquad r=(m+s+\varepsilon)/2,
$$
$$
h_j=\frac{\binom tj\binom{n-t}{m-j}}{\binom nm}.
$$
These are the conditional probabilities for the number $J=(m+V)/2$ of positive labels in one fold. Define
$$
\tau_s=
\begin{cases}
\Pr(V\ge s\mid S=s),&s>0,\\
\Pr(V< s\mid S=s),&s\le0.
\end{cases}
$$
Then, with zero-mass conventions at the boundaries,
$$
g_{n,m}(s)
=\frac{|s|}{n}\tau_s+
\frac{(m+s+\varepsilon)(N+\varepsilon)}{2mn}h_r,
\qquad
h_r=\frac{q_m(s+\varepsilon)q_N(-\varepsilon)}{q_n(s)}.
\tag{3.5}
$$

**Proof.** Put $\lambda_j=(t-j)(m-j)$ and $\nu_j=j(n-t-m+j)$. The adjacent-mass relation
$$
\lambda_jh_j=\nu_{j+1}h_{j+1},
\qquad \nu_j-\lambda_j=nj-tm
$$
gives by telescoping
$$
\mathbb E[(J-mt/n)1_{\{J\ge r\}}\mid S=s]=\frac{\nu_rh_r}{n},
$$
and the corresponding expression with $J< r$ is its negative. This remains true outside or at the endpoints of the support: the missing masses are zero and the boundary products vanish. Since $\mathbb E[V\mid S=s]=ms/n$ and
$$
\nu_r=(m+s+\varepsilon)(N+\varepsilon)/4,
$$
substitution into (3.3) proves the first identity. The event $J=r$ is $V=s+\varepsilon$; its complement sum is $-\varepsilon$. Computing this conditional probability under fair independent labels proves the second identity. $\square$

## 4. Local profile and an integrable envelope

### Lemma 4.1. Binomial local estimates

For each fixed $M<\infty$, uniformly over feasible $|x|\le M\sqrt a$,
$$
q_a(x)=\frac2{\sqrt a}\phi(x/\sqrt a)\{1+O_M(a^{-1})\}.
\tag{4.1}
$$
Also $\sup_xq_a(x)\le K/\sqrt a$ for $a\ge1$. More generally, for sign sums of length $a$ with mean $\mu\in[-1/2,1/2]$, their largest atom is at most $K/\sqrt a$.

**Proof.** The standard Stirling factorial estimate, with logarithmic remainder bounded by $1/(12j)$, gives the exponential factor
$$
-a I(x/a),\quad
I(z)=\tfrac12[(1+z)\log(1+z)+(1-z)\log(1-z)]
=z^2/2+O(z^4)
$$
and the prefactor $\sqrt{2/(\pi a)}(1-x^2/a^2)^{-1/2}$. Both relative errors are $O_M(a^{-1})$ on the asserted window. The fair-label global bound follows from unimodality and the central estimate, increasing the constant for small $a$. For the biased binomial, the maximum is attained at a mode within distance one of $ap$, where $p=(1+\mu)/2$. Stirling at that mode gives at most a constant times $[ap(1-p)]^{-1/2}$; $p\in[1/4,3/4]$ makes this uniform. Finitely many small $a$ are again absorbed into the constant. $\square$

### Lemma 4.2. Compact-window profile

As $k,m\to\infty$, for every fixed $M$,
$$
g_{n,m}(s)
=m^{-1/2}\{\phi(s/\sqrt m)+o(1)\}
\tag{4.2}
$$
uniformly on feasible $|s|\le M\sqrt m$.

**Proof.** Since $m/n=1/k\to0$, (4.1) gives
$$
\frac{q_N(-\varepsilon)}{q_n(s)}=1+o(1),
\qquad
h_r=\frac2{\sqrt m}\phi(s/\sqrt m)\{1+o(1)\}.
$$
The coefficient of $h_r$ in (3.5) tends uniformly to $1/2$. The other term lies between zero and $M/(k\sqrt m)$. The shift by $\varepsilon\in\{0,1\}$ is $o(1)$ in the normal coordinate. This proves the claim, without any restriction on $m/\log k$. $\square$

### Lemma 4.3. Global envelope

For $k\ge2,m\ge1$, all feasible totals satisfy
$$
0\le g_{n,m}(s)\le m^{-1/2}G(s/\sqrt m),
\quad
G(u)=\bigl(|u|+\sqrt{\pi/2}\bigr)e^{-u^2/8}.
\tag{4.3}
$$

**Proof.** Conditional on the total $s$, reveal the $m$ labels in the selected fold successively. If the first $i$ labels sum to $a_i$, the Doob martingale of the final fold sum is
$$
M_i=\frac{n-m}{n-i}a_i+\frac{m-i}{n-i}s.
$$
Given the first $i-1$ labels, the range of $M_i-M_{i-1}$ has length at most $2(n-m)/(n-i)\le2$, for $1\le i\le m$. A conditionally centered variable with range length at most two has log moment-generating function at most $\theta^2/2$. Indeed the second derivative of the log moment-generating function is the tilted variance, bounded by one; integrate twice from zero. Iterating this inequality and optimizing the exponential Markov bound gives
$$
\Pr(\pm(V-ms/n)\ge x\mid S=s)\le e^{-x^2/(2m)},\qquad x\ge0.
\tag{4.4}
$$
Set $r_0=|s|$. Reflect $V$ for $s\le0$. In either case the relevant variable $W'$ has mean $r_0/k$, and the truncated first moment in (3.3) is bounded by
$$
r_0e^{-(r_0-r_0/k)^2/(2m)}
+\int_{r_0}^{\infty}e^{-(u-r_0/k)^2/(2m)}\,du.
$$
The strict threshold for $s\le0$ only decreases this bound. For $a\ge0$,
$$
\int_a^\infty e^{-v^2/(2m)}\,dv
\le \sqrt{\pi m/2}\,e^{-a^2/(2m)};
$$
this follows by differentiating $e^{a^2/(2m)}$ times the integral, or by comparing $(a+w)^2$ with $a^2+w^2$. Since $1-1/k\ge1/2$, division by $m$ yields (4.3). The same argument covers $s=0$. $\square$

## 5. Moving margins and complete-average risk

Throughout this section $C>0$ is fixed and $n\mu^2\le C\log k$.

### Lemma 5.1. Exact tilt and uniform local mass

For every feasible $s$,
$$
\Pr_\mu(S=s)=q_n(s)T_\mu e^{\lambda s},
\quad T_\mu=(1-\mu^2)^{n/2},\quad \lambda=\operatorname{arctanh}\mu.
\tag{5.1}
$$
Uniformly in the stated band,
$$
T_\mu=e^{-n\mu^2/2}\{1+o(1)\},\qquad
|\lambda|\sqrt m=o(1).
\tag{5.2}
$$
For fixed $M$, uniformly on $|s|\le M\sqrt m$,
$$
\Pr_\mu(S=s)=\frac{2\phi(0)}{\sqrt n}
e^{-n\mu^2/2}\{1+o(1)\}.
\tag{5.3}
$$
Globally,
$$
\Pr_\mu(S=s)\le\frac K{\sqrt n}
e^{-n\mu^2/2}e^{|\lambda||s|}.
\tag{5.4}
$$

**Proof.** Factoring $p^{(n+s)/2}(1-p)^{(n-s)/2}$ gives (5.1). The logarithmic relative error in replacing $T_\mu$ is $O(n\mu^4)$, at most $O_C((\log k)^2/n)=o(1)$. Also
$$
|\lambda|\sqrt m\le(1+o(1))\sqrt{C\log k/k}=o(1).
$$
Use (4.1) and $s^2/n=O_M(1/k)$ for (5.3), and the global maximal-atom bound for (5.4). These are relative bounds even when $e^{-n\mu^2/2}$ is a small power of $k$. $\square$

### Lemma 5.2. Sharp second moment of the boundary profile

Uniformly over the margin band,
$$
\mathbb E_\mu g_{n,m}(S)^2
\sim A_{n,m,\mu}
:=\frac{e^{-n\mu^2/2}}{2\sqrt2\,\pi\sqrt{nm}}.
\tag{5.5}
$$
In addition,
$$
\mathbb E_\mu g_{n,m}(S)
\le K\frac{e^{-n\mu^2/2}}{\sqrt n},\qquad
\mathbb E_\mu[|S|g_{n,m}(S)]
\le K e^{-n\mu^2/2}\sqrt{m/n}.
\tag{5.6}
$$

**Proof.** Fix $M$. Applying (4.2) and (5.3) and noting that the lattice spacing of $u=s/\sqrt m$ is $2/\sqrt m$,
$$
\begin{split}
\mathbb E_\mu[g(S)^2 1_{\{|S|\le M\sqrt m\}}]
&=(1+o(1))\frac{2\phi(0)e^{-n\mu^2/2}}{m\sqrt n}
\sum_{\substack{s\equiv n\ (2)\\|s|\le M\sqrt m}}\phi(s/\sqrt m)^2\\
&=(1+o(1))\frac{\phi(0)e^{-n\mu^2/2}}{\sqrt{nm}}
\int_{-M}^{M}\phi(u)^2\,du.
\end{split}
\tag{5.7}
$$
Parity translates the mesh by at most one mesh interval and does not alter its Riemann limit.

For the omitted tails, use (4.3) and (5.4). After division by $e^{-n\mu^2/2}/\sqrt{nm}$, their upper bound is a constant times a mesh Riemann sum of
$$
G(u)^2e^{a_{n,m}|u|}1_{\{|u|>M\}},
\qquad a_{n,m}=|\lambda|\sqrt m=o(1).
$$
For large $k,m$ this is dominated by an integrable function of the form $K(1+|u|)^2e^{-u^2/8}$. Bounding lattice sums by integrals of suprema on adjacent intervals makes the tail bound uniform over the parity shift and $\mu$. Its limit superior tends to zero as $M\to\infty$. First take the large-$k,m$ limit at fixed $M$, then let $M\to\infty$ in (5.7). The Gaussian integral
$$
\phi(0)\int_{\mathbb R}\phi(u)^2\,du
=\frac1{2\sqrt2\,\pi}
$$
gives (5.5).

The same tail argument with $G$ and $|u|G$ instead of $G^2$ gives (5.6), with the corresponding powers of $m$. No global normal approximation to biased tails has been assumed. $\square$

### Lemma 5.3. The mixed term is smaller

Uniformly in the same band,
$$
|\mathbb E_\mu[B g_{n,m}(S)]|
\le K A_{n,m,\mu}
\left(\frac1k+|\mu|\sqrt m\right)
=o(A_{n,m,\mu}).
\tag{5.8}
$$

**Proof.** The bound $|B|\le(|S|/n+|\mu|)/2$, followed by (5.6), gives
$$
|\mathbb E Bg(S)|
\le K e^{-n\mu^2/2}
\left(\frac{\sqrt m}{n\sqrt n}+\frac{|\mu|}{\sqrt n}\right).
$$
Divide by $A_{n,m,\mu}$. The two resulting factors are $1/k$ and $|\mu|\sqrt m\le\sqrt{C\log k/k}$, both tending to zero. In particular, an unproved cancellation of opposite signs is unnecessary. $\square$

### Proposition 5.4. Complete-average asymptotic

The complete-average risk satisfies
$$
R_*=\frac1{4n}+A_{n,m,\mu}
+o(n^{-1}+A_{n,m,\mu})
\tag{5.9}
$$
uniformly in the stated band.

**Proof.** By Lemma 3.2 its error is $B+g(S)$. Expand its square and apply (3.2), (5.5), and (5.8). The replacement of $(1-\mu^2)/(4n)$ by $1/(4n)$ has error $o(n^{-1})$, uniformly. $\square$

## 6. Why every allowed partition mixture has the same first term

### Lemma 6.1. Conditional nonpositive fold covariance

For any fixed partition and any feasible $s$, if $i\ne j$, then
$$
\operatorname{Cov}(d_s(V_i),d_s(V_j)\mid S=s)\le0.
\tag{6.1}
$$
Consequently
$$
\operatorname{Var}(D_\pi\mid S=s)
\le\frac{\mathbb E[d_s(V_1)^2\mid S=s]}{k m^2}.
\tag{6.2}
$$

**Proof.** Given $S=s,V_i=v$, the number of positive labels among the remaining positions decreases when $v$ increases. Couple uniformly random sets of positive positions by one uniform ordering of those remaining positions and take nested initial subsets. The resulting $V_j$ is stochastically nonincreasing as a function of $v$.

When $s>0$, $d_s$ is nondecreasing, so
$v\mapsto\mathbb E[d_s(V_j)\mid V_i=v,S=s]$ is nonincreasing. When $s\le0$, $d_s$ is nonincreasing and that conditional expectation is nondecreasing. In both cases their covariance is nonpositive: for independent copies $X,X'$, twice $\operatorname{Cov}(f(X),g(X))$ is
$\mathbb E[(f(X)-f(X'))(g(X)-g(X'))]$, nonpositive for oppositely monotone functions. The law of total covariance proves (6.1). Expand the variance of $(km)^{-1}\sum_jd_s(V_j)$, drop the nonpositive cross terms, and bound each variance by its second moment to get (6.2). This argument supplies the required dependence property directly. $\square$

### Lemma 6.2. Integrated conditional variance

For every fixed $C>0$, uniformly on $n\mu^2\le C\log k$ and sufficiently large $k,m$,
$$
\mathbb E_\mu\operatorname{Var}(D_\pi\mid S)
\le \frac{K_C}{n\sqrt k}.
\tag{6.3}
$$

**Proof.** Let $V=V_1$ and $T=S-V$; these are independent sign sums of lengths $m,N$. If $d_S(V)>0$, then $|T|\le|V|$. Indeed for $S>0$, $0< S\le V$ implies $-V< T\le0$; for $S\le0$, $V< S\le0$ implies $0< T\le-V$. Thus, using Lemma 4.1 and the fact that $[-|v|,|v|]$ contains at most $|v|+1$ points of the appropriate step-two lattice,
$$
\mathbb E d_S(V)^2
\le \frac K{\sqrt n}\mathbb E(|V|^3+V^2).
\tag{6.4}
$$
Here $N\ge n/2$, and eventually $|\mu|\le1/2$.

Writing $V=m\mu+X$, independence and centeredness give $\mathbb E X^4\le3m^2+16m$. Hölder's inequality bounds $\mathbb E|X|^3$ by a constant times $m^{3/2}$. Since $|\mu|\sqrt m\le\sqrt{C\log k/k}=o(1)$, the deterministic mean adds at most the same order. Hence $\mathbb E(|V|^3+V^2)\le K_Cm^{3/2}$. Integrate (6.2), insert (6.4), and use $n=km$:
$$
\frac{K_Cm^{3/2}}{km^2\sqrt n}
=\frac{K_C}{n\sqrt k}.
$$
$\square$

### Proposition 6.3. An exact sandwich for all mixtures

For every admissible $W$,
$$
R_W-R_*=
\mathbb E\operatorname{Var}(D_W\mid S,W)\ge0.
\tag{6.5}
$$
The upper bound in (2.5) follows uniformly in the moving-margin band.

**Proof.** Conditional on $S,W$, all component means equal $g(S)$. Conditional centering removes the cross term against the $S$-measurable $B+g(S)$, proving (6.5). Pointwise convexity gives
$$
\left(\sum_\pi W_\pi(D_\pi-g(S))\right)^2
\le\sum_\pi W_\pi(D_\pi-g(S))^2.
$$
Conditional expectation bounds the variance of the mixture by the corresponding weighted average of single-partition conditional variances. Each has the same bound (6.2), regardless of dependencies between partitions. Integrate and use Lemma 6.2. $\square$

**Completion of Theorem 2.2 and Corollary 2.3.** Combine (5.9) with (2.5). The additional term is $o(n^{-1})$, so it is also $o(n^{-1}+A)$. This proves (2.4), uniformly over all external mixing laws. Multiply by $n$ and substitute $a_n=n\mu^2-\log k$ to obtain all parts of Corollary 2.3. $\square$

For independent uniformly randomized repetitions, an exact finite-sample identity further reads
$$
R_{r\,\mathrm{repeats}}=R_*+\frac{R_{\mathrm{one}}-R_*}{r},
\qquad r=1,2,\ldots .
\tag{6.6}
$$
It follows by conditioning on the entire observed sample. This familiar identity explains what ordinary averaging changes; it is not the source of the sharp result. Equations (5.5) and (6.3) identify the two terms' different asymptotic sizes.

## 7. Rare samples, weak convergence, and tie robustness

### Proof of Theorem 2.4

Set $Z_n=(S-n\mu_n)/\sqrt n$. Since $\mu_n\to0$, $Z_n\Rightarrow Z\sim N(0,1)$. For completeness, its characteristic function is
$$
\left[e^{-it\mu_n/\sqrt n}
\{\cos(t/\sqrt n)+i\mu_n\sin(t/\sqrt n)\}\right]^n,
$$
whose logarithm tends to $-t^2/2$. The continuity theorem then gives the asserted central limit.

Equation (2.5), equivalently its conditional-variance proof, gives
$$
\sqrt n\{D_W-g(S)\}\to0\quad\text{in }L^2.
$$
Also $\sqrt n\,g(S)\to0$ in probability. To see this, fix $a>0$. On $|S|\ge a\sqrt n$, (4.3) bounds it by
$\sqrt k\,G(S/\sqrt m)$, whose supremum for $|S|/\sqrt m\ge a\sqrt k$ tends to zero. On the complement, the limiting probability is at most $2a/\sqrt{2\pi}$, since $S/\sqrt n\Rightarrow Z+b$. Let $a\downarrow0$.

Thus the root-$n$ CV error differs by $o_{\Pr}(1)$ from
$$
\sqrt n B=-\tfrac12 Z_n\sigma(Z_n+\sqrt n\mu_n).
$$
The discontinuity set has zero limiting probability. This proves (2.8).

Every held-out observation is independent of its training complement. Therefore $\mathbb E C_W$ equals the mean population risk of majority trained on $N=n-m$ independent observations, regardless of $W$. If $T_N$ is that training sum,
$$
\mathbb E(C_W-L_\mu(S))
=\frac{\mu}{2}\{\mathbb E\sigma(S)-\mathbb E\sigma(T_N)\}.
\tag{7.1}
$$
The two sign expectations converge to $2\Phi(b)-1$, where $\Phi$ is the standard normal distribution function, since $N/n\to1$. Multiplication by $\sqrt n$ proves (2.9).

Direct normal integration gives
$$
\mathbb E[-Z\operatorname{sign}(Z+b)/2]=-\phi(b),\qquad
\mathbb E[Z^2\operatorname{sign}(Z+b)^2/4]=1/4.
$$
The mismatch of the means implies failure of uniform integrability. Finally (2.4) with $n\mu_n^2\to b^2$ gives (2.10). $\square$

### Proposition 7.1. Location of the excess second moment

Under Theorem 2.4, for every fixed $M>0$,
$$
\Pr_\mu(|S|\le M\sqrt m)
\sim \frac{2M\phi(b)}{\sqrt k},
\tag{7.2}
$$
and uniformly over allowed mixtures,
$$
\frac{\mathbb E_\mu[D_W^2 1_{\{|S|\le M\sqrt m\}}]}
{e^{-n\mu^2/2}/\sqrt{nm}}
\longrightarrow
\phi(0)\int_{-M}^{M}\phi(u)^2\,du.
\tag{7.3}
$$
As $M\to\infty$, these windows exhaust the leading excess second moment.

**Proof.** Sum (5.3) on the step-two lattice to obtain (7.2). Formula (5.7) proves (7.3) for $g(S)^2$. Conditional centering shows that the difference for $D_W^2$, restricted to any $S$-measurable event, is nonnegative and no larger than the total variance bound (6.3). That bound divided by $e^{-n\mu^2/2}/\sqrt{nm}$ is $O(1/k)$ when $n\mu^2\to b^2$. The tail conclusion follows from the proof of Lemma 5.2. $\square$

The probability in (7.2) tends to zero. On this band, however, the conditional mean excess $g(S)$ is of order $m^{-1/2}$, so its root-$n$ scale is $\sqrt k$. This precise concentration of moments explains how the weak limit misses the MSE-leading events.

### Proposition 7.2. Robustness to arbitrary tie-breaking

Replacing the canonical tie rule by any majority-respecting rule at each training sample and at the full sample changes the error by a quantity $\Delta$ satisfying, uniformly in the band of Theorem 2.2,
$$
\mathbb E_\mu\Delta^2
\le K_C\frac{A_{n,m,\mu}}{\sqrt m}.
\tag{7.4}
$$
Thus the risk ratio in (2.4) still tends to one.

**Proof.** A training tie can alter a fold's validation loss by at most $|V|/m$, and only when the complement sum $T$ equals zero. Apply Jensen to the folds and to the partition mixture, and then use independence of $T,V$:
$$
\mathbb E(\Delta C)^2
\le \left(\frac{1-\mu^2}{m}+\mu^2\right)\Pr_\mu(T=0).
$$
If $N$ is odd this probability is zero. Otherwise the exact central tilt gives
$$
\Pr_\mu(T=0)=q_N(0)(1-\mu^2)^{N/2}
\le K e^{-n\mu^2/2}/\sqrt n,
$$
because $m\mu^2=o(1)$ uniformly. The prefactor is $O(1/m)$. A full-sample tie changes the target risk by at most $|\mu|1_{\{S=0\}}$, whose squared mean is at most
$K\mu^2e^{-n\mu^2/2}/\sqrt n$. This is smaller by $m\mu^2=o(1)$. Combining the two perturbations proves (7.4).

For any square-integrable error $E$,
$$
|\mathbb E(E+\Delta)^2-\mathbb E E^2|
\le2\sqrt{\mathbb E E^2\,\mathbb E\Delta^2}+\mathbb E\Delta^2.
$$
Since $R_W\asymp n^{-1}+A$, the relative change is $O(m^{-1/4})=o(1)$. The bound allows arbitrary randomized choices on tie events; it does not assume that those choices are independent across folds. $\square$

**Proof of Corollary 2.5.** At $x_0$, an empirical risk minimizer must predict the empirical majority whenever the labels are not tied, since both possible predictions are represented in the class. Apply Proposition 7.2 to this experiment, including its full-sample target. For the distribution-free lower bound take $\mu=0$ and use (2.4). $\square$

## 8. Reproducible diagnostics and their limits

Two complementary programs accompany the manuscript. The [exact-arithmetic program](code/exact_checks.py) enumerates small label samples and independently evaluates fold losses, complete held-out-subset averages, and conditional moments. It checks the finite identities, both parity classes, and the covariance sign. The [large-sample program](code/phase_diagnostics.py) evaluates the hypergeometric formula with floating-point binomial probabilities. Neither program is used in the proof of the universal asymptotic.

The following positive-margin diagnostics set $a=n\mu^2-\log k=0$. The limiting prediction is
$$
1/4+1/(2\sqrt2\,\pi)=0.3625395\ldots.
$$

| $k$ | $m$ | $n R_*$, numerical | Ratio to the asymptotic prediction |
| ---: | ---: | ---: | ---: |
| 20 | 25 | 0.373955 | 1.031487 |
| 80 | 51 | 0.367608 | 1.013980 |
| 320 | 101 | 0.363892 | 1.003729 |
| 1280 | 201 | 0.362748 | 1.000576 |
| 5120 | 401 | 0.362510 | 0.999919 |

The [numerical report](results/phase_diagnostics.json) also contains negative margins, $a=\pm2$, fair labels, and slowly growing even $m$. It records the summation range and included mass. These floating-point values are not interval certificates, and their apparent convergence does not prove uniformity. The exact finite checks likewise certify only the enumerated cases. The [reproduction guide](REPRODUCTION.md) gives the commands and dependency versions.

## 9. Interpretation and limitations

The main theorem separates two uses of additional computation. More partitions can reduce the conditional partition contribution; (2.5) quantifies that contribution in this model. They do not alter the leading boundary term generated by the observed sample itself. Moving the population label probability away from one half suppresses that term exponentially, giving the exact logarithmic margin window.

The theorem does not make a universal recommendation for the number of folds. It does not cover model selection, nonbinary labels, features that influence a richer learner, losses other than zero–one loss, label-dependent stratification, data-adaptive partition selection, or nonlinear aggregation. In particular a procedure that deliberately balances labels in each fold is not label-independent and is outside (2.3). Fixed-$m$ cases such as leave-one-out have separate lattice constants; substituting $m=1$ into the growing-$m$ constant is invalid.

The narrow model has a useful contrasting estimator: its empirical risk already has exactly inverse-sample-size MSE. Consequently, failure of repeated CV to remove the floor does not imply that the statistical experiment has that minimax floor. The ERM corollary preserves this distinction.

The provenance claims are bounded by the sources actually checked. We do not claim a worldwide priority certificate, external journal acceptance, or completed formal verification.

## References

1. I. Nachum, R. Urbanke and T. Weinberger. *Minimax Limits of $k$-Fold Cross-Validation via Majority*. Proceedings of COLT 2026, PMLR 336:6811–6848. Latest checked author version: arXiv:2605.25859v2, 19 June 2026. [Proceedings](https://proceedings.mlr.press/v336/nachum26a.html); [author full text](https://arxiv.org/html/2605.25859v2).

2. A. Celisse and T. Mary-Huard. *Theoretical Analysis of Cross-Validation for Estimating the Risk of the $k$-Nearest Neighbor Classifier*. Journal of Machine Learning Research 19(58):1–54, 2018. [Journal page](https://jmlr.org/papers/v19/15-498.html); [full text](https://jmlr.org/papers/volume19/15-498/15-498.pdf).

3. S. Arlot and M. Lerasle. *Choice of V for V-Fold Cross-Validation in Least-Squares Density Estimation*. Journal of Machine Learning Research 17(208):1–50, 2016. [Full text](https://jmlr.org/papers/volume17/14-296/14-296.pdf).

4. S. Bates, T. Hastie and R. Tibshirani. *Cross-validation: what does it estimate and how well does it do it?* Journal of the American Statistical Association 119(546):1434–1445, 2024; first online 2023. [doi:10.1080/01621459.2023.2197686](https://doi.org/10.1080/01621459.2023.2197686).

5. A. Celisse. *Optimal cross-validation in density estimation with the $L^2$-loss*. The Annals of Statistics 42(5):1879–1910, 2014. [doi:10.1214/14-AOS1240](https://doi.org/10.1214/14-AOS1240); [author version](https://arxiv.org/pdf/0811.0802).

6. P. Burman. *A Comparative Study of Ordinary Cross-Validation, v-Fold Cross-Validation and the Repeated Learning-Testing Methods*. Biometrika 76(3):503–514, 1989. [doi:10.1093/biomet/76.3.503](https://doi.org/10.1093/biomet/76.3.503). Bibliography and abstract checked; no proof step in this manuscript depends on its unavailable full text.

7. B. Fava. *Cross-Fitting Under Nonregularity: Normality and Inference via Locality*. arXiv:2610.02944v1, October 2026. [Full text](https://arxiv.org/pdf/2610.02944).

8. R. Kohavi. *A Study of Cross-Validation and Bootstrap for Accuracy Estimation and Model Selection*. IJCAI 1995. [Proceedings entry](https://ijcai.org/proceedings/1995/147).

9. M. Austern and W. Zhou. *Asymptotics of cross-validation*. Annales de l'Institut Henri Poincaré, Probabilités et Statistiques 61(4):2804–2865, 2025. [doi:10.1214/24-AIHP1488](https://doi.org/10.1214/24-AIHP1488); [earlier author version](https://arxiv.org/pdf/2001.11111). The journal identity is distinct from The Annals of Statistics.
