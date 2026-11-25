---
title: "Information loss and sharp power limits for conditional Gamma calibration"
subtitle: "A fourth-order local deficit and unequal extreme-mean regimes"
lang: en
---

## Abstract

A Gamma mean test can eliminate an unknown shape by conditioning on each observation's unsigned deviance, retaining a binary branch. We quantify what that conditioning costs. At the null, the loss of relative entropy is fourth order with an explicit positive coefficient. For a mean ratio \(d\) tending to zero, the optimal conditional expected log evidence is asymptotic to \(1/|\log d|\), and the maximal conditional-level power has an exact transition on the sample scale \(|\log d|\). For \(d\) tending to infinity, conditional evidence instead grows logarithmically and one sample gives power tending to one. The sharp testing limits concern tests with conditional size control for each deviance vector.

## 1. Model and main result

Let \(R=dX\) with \(X\) Gamma of shape \(k>0\) and rate \(k\), so \(R\) has mean \(d>0\). The null is \(d=1\) with unknown shape. Define

\[
 D=R-1-\log R,\qquad S=\mathbf 1_{\{R>1\}}.
\]

For \(D>0\), let \(r_-<1<r_+\) be the two inverse branches, and let \(g=r_+-r_-\). The pinned *Gamma mean testing by conditioning with unknown dispersion* establishes

\[
 p(D)=\Pr_0(S=1\mid D)
       =\frac{1-r_-}{g}=\frac1g-\frac1{e^g-1},
 \qquad \mathbb E_0[R\mid D]=1.
 \qquad\text{(1)}
\]

For example the branch identity follows by transforming the null density, whose two branch contributions are proportional to \(1/|r_\pm-1|\). The branch gap also satisfies \(r_-=g/(e^g-1)\) and \(r_+=r_-+g\), by subtracting the two deviance equations. Under alternative \(d\), the conditional probability \(q_d(D)\) of \(S=1\) has its odds multiplied by \(\exp(\beta g)\) relative to (1), where

\[
 \beta=k(1-1/d).
\]

This follows from the likelihood ratio \(d^{-k}\exp(\beta R)\). Let \(P_0\) be the null at the same shape \(k\), and define the conditional evidence

\[
 C_k(d)=\mathbb E_d\left[\operatorname{kl}
    \big(\operatorname{Ber}(q_d(D))\,\Vert\,\operatorname{Ber}(p(D))\big)\right].
\]

This is the largest expected log e-value among e-values that are conditionally valid for every deviance. For a fixed \(D\), if an action \(e(S)\) has \(\mathbb E_p e\le1\), then Jensen's inequality gives
\(\mathbb E_q\log(e(S)p(S)/q(S))\le\log\mathbb E_p e\le0\).
The conditional likelihood ratio attains equality. For independent observations, the same argument for their joint conditional laws makes this bound additive.

**Theorem 1.** For fixed \(k>0\), put \(v(D)=\operatorname{Var}_0(R\mid D)=(1-r_-)(r_+-1)\). The conditional evidence satisfies

\[
 C_k(d)=k(d-1-\log d)
   -\frac{\beta^4}{8}\operatorname{Var}_0(v(D))+O_k(|\beta|^5),
 \qquad d\to1 .
\]
\[
 C_k(d)\sim\frac{1}{|\log d|}\quad(d\downarrow0),\qquad
 C_k(d)=\log d+\mathbb E[\log X]+o(1)\quad(d\to\infty).
 \qquad\text{(2)}
\]

The variance in the local coefficient is strictly positive. All logarithms are natural.

For tests using \(n\) independent observations, define conditional level \(\alpha\) by the requirement that the null rejection probability given the deviance vector is at most \(\alpha\). One may allow independent randomization. The conditional null law of the signs is the product with probabilities (1), so this requirement does not use the shape.

**Theorem 2.** Fix \(0<\alpha<1\) and \(k>0\). As \(d\downarrow0\) and \(n/|\log d|\to\lambda\in[0,\infty)\), the supremum conditional-level power converges to

\[
 \min(1,\alpha e^\lambda).
 \qquad\text{(3)}
\]

A single shape- and mean-free test attains this limit and has power tending to one whenever \(n/|\log d|\to\infty\). As \(d\to\infty\), one sample suffices for power tending to one. The theorem bounds conditionally valid tests, with no claim about every test that controls only marginal size over shapes.

## 2. The fourth-order loss

The full relative entropy from the same-shape null is \(k(d-1-\log d)\), by the displayed likelihood ratio and \(\mathbb E_d R=d\). The deterministic deviance and sign pair recovers the observation almost surely, so the chain rule for relative entropy splits the full divergence into the deviance-marginal divergence plus \(C_k(d)\).

The likelihood of the marginal deviance under the alternative relative to the null is

\[
 f_\beta(D)=\frac{\mathbb E_0[e^{\beta R}\mid D]}{\mathbb E_0 e^{\beta R}} .
\]

By (1), the conditional and unconditional first moments are both one. The second moments are \(1+v(D)\) and \(1+1/k\). Expand the exponential for small \(\beta\) to obtain

\[
 f_\beta(D)=1+\tfrac12\beta^2(v(D)-1/k)+O_{L^3(P_0)}(|\beta|^3).
 \qquad\text{(4)}
\]

For the remainder, the deterministic exponential Taylor bound gives a multiple of \(|\beta|^3R^3e^{|\beta|R}\). Its \(L^3(P_0)\) norm is bounded after removing the factor \(|\beta|^3\) for sufficiently small \(|\beta|\), since the null Gamma has a positive exponential moment. Conditional expectation contracts this norm. The scalar denominator is analytic and bounded away from zero. These facts give (4).

Jensen also gives a uniform positive lower bound \(f_\beta\ge e^\beta/\mathbb E_0e^{\beta R}\) for \(\beta\) near zero. Write \(w=f_\beta-1\). On this range the third derivative of \(x\log x\) is bounded, so its Taylor expansion through degree two has a remainder bounded by \(C|w|^3\). Since \(\mathbb E_0 w=0\), (4) now gives the marginal divergence

\[
 \mathbb E_0[f_\beta\log f_\beta]
   =\tfrac12\mathbb E_0 w^2+O(\mathbb E_0|w|^3)
   =\frac{\beta^4}{8}\operatorname{Var}_0(v(D))+O_k(|\beta|^5).
\]

Here \(\mathbb E_0v=1/k\) by the conditional mean identity. The conditional variance tends to zero when the two branches meet and grows without bound when \(D\) tends to infinity, since \(r_-\to0\) and \(r_+\to\infty\). It is therefore nonconstant under the positive deviance density. Its moments used above are finite by Jensen applied to \(\mathbb E_0[(R-1)^2\mid D]\). Subtracting the marginal divergence proves the first part of (2).

## 3. The two extreme evidence laws

The expression (1) has \(0<p(D)<1/2\). For instance \(p=1/2+1/g-\frac12\coth(g/2)\) and \(\tanh x<x\) for \(x>0\). As \(D\to\infty\), the high branch obeys \(r_+=D+1+\log r_+\) and the low branch tends to zero. The bound \(r_+\le2(D+1)\) for sufficiently large \(D\) gives \(g=D+O(\log(D+2))\). Formula (1) also shows \(p(D)\sim1/g\) there. On the entire positive half-line \(p(D)\ge c/(1+D)\) for some \(c>0\), by this asymptotic, continuity, and the limit \(1/2\) at zero.

### 3.1. Downward means

Let \(L=-\log d\to\infty\). With \(R=dX\), we have \(D=L-1-\log X+dX\), so \(D/L\to1\) for every fixed \(X>0\). This gives \(Lp(D)\to1\). To pass to moments, on \(X\le e^{L/2}\) we have \(D\ge L/2-1\), and \(p(D)\le1/g\le1/D\) when \(D>0\). The complement has probability at most \(C\exp(-c e^{L/2})\) by the positive exponential moment of the Gamma law. Since \(p\le1/2\), dominated convergence and this bound give

\[
 L\mathbb E_d p(D)\to1,\qquad
 \mathbb E_d p(D)^2=O(L^{-2}),\qquad
 L\mathbb E_d[-\log(1-p(D))]\to1 .
 \qquad\text{(5)}
\]

For \(d<1\), \(\beta<0\) implies \(q=q_d(D)\le p\). At fixed \(p\), the Bernoulli relative entropy decreases on \(q\in[0,p]\). The gap from its value at \(q=0\) equals \(h(q)-q\log((1-p)/p)\), where \(h\) is binary entropy in natural logarithms, so

\[
 0\le -\log(1-p)-\operatorname{kl}(q\Vert p)\le h(q).
\]

Since \(\mathbb E_d q(D)=\Pr_d(R>1)\le C\exp(-c/d)\), concavity of \(h\) makes its expected value negligible relative to \(1/L\). Applying (5) proves \(C_k(d)\sim1/L\).

### 3.2. Upward means

For \(d>1\), \(q\ge p\), and exactly

\[
 -\log p-\operatorname{kl}(q\Vert p)
    =h(q)+(1-q)\log((1-p)/p).
\]

The expected first term is at most \(h(\Pr_d(R<1))=O(d^{-k}\log d)\). For the second, use conditional expectation to write its mean with the indicator of \(R<1\) in place of \(1-q\). The bound on \(p\) makes the logarithm at most \(C+\log(1+D)\), which is integrable against \(r^{k-1}dr\) on \(0<r<1\), where \(D\le-\log r\). The alternative density there is at most a constant times \(d^{-k}r^{k-1}\), so this expected term is \(O(d^{-k})\).

On \(R\ge1\), the high branch equals \(R\), and \(g/R\to1\) as \(R\to\infty\). Thus \(-\log p(D)-\log R\) tends to zero there and is bounded by continuity and its finite limits. Since \(dX\to\infty\) almost surely, the expected difference on \(R\ge1\) tends to zero by bounded convergence. On \(R<1\), its absolute value is bounded by a constant plus \(|\log R|+\log(1+|\log R|)\), again integrable against \(r^{k-1}dr\). Its low-branch contribution is \(O(d^{-k})\). It follows that \(C_k(d)=\mathbb E_d\log R+o(1)=\log d+\mathbb E\log X+o(1)\). This proves (2). In particular the fraction of the full same-shape information retained tends to zero at either extreme, with orders \(1/[k\log^2(1/d)]\) downward and \((\log d)/(kd)\) upward.

## 4. Sharp conditional power

For each observed deviance vector let
\[
 c_n(D)=\prod_{i=1}^{n}(1-p(D_i)).
\]
This is the conditional null probability of the all-low sign vector. There is a single conditional null sign law for all shapes. The deviance distributions under alternative and null have positive densities on the same domain, so the conditional test constraint holds at alternative-almost-every deviance vector. Given that vector, no conditional-level test can reject the all-low vector with probability greater than \(\min(1,\alpha/c_n(D))\).

When \(n/L\to\lambda<\infty\), the actual signs are all low with probability tending to one, by \(n\Pr_d(R>1)\to0\). From (5), independence, and the second-moment bound,

\[
 \sum_i p(D_i)\longrightarrow\lambda\ \text{in probability},
 \qquad \sum_i p(D_i)^2\longrightarrow0\ \text{in probability}.
\]
The variance of the first sum is \(O(n/L^2)\). Since \(p\le1/2\), expand \(\log(1-p)=-p+O(p^2)\) to obtain \(c_n(D)\to e^{-\lambda}\). The probability bound for the all-low vector, bounded convergence in probability, and the negligible alternative complement yield the upper bound in (3). Rejecting only the all-low vector with probability \(\min(1,\alpha/c_n(D))\) attains it.

There is one version of the test that also handles arbitrarily large \(n/L\). Choose the shortest prefix for which the conditional all-low probability is at most \(\alpha\), using the deviance vector alone. When such a prefix exists, reject if its signs are all low. Otherwise use the randomized all-\(n\) rule above. Every conditional rejection probability is at most \(\alpha\). If \(n/L\to\infty\), fix \(C>\log(1/\alpha)\) and apply the finite-ratio argument to the first \(\lfloor CL\rfloor\) observations. With probability tending to one their conditional all-low probability is below \(\alpha\) and every sign there is low, so the rule rejects. With \(n/L\) bounded the rule still gives the same all-low probability and power limit. For the upward case one may use a single sample, rejecting the high branch with probability \(\min(1,\alpha/p(D))\). The alternative sign is high with probability tending to one and \(p(D)\to0\) in probability, so the power tends to one.

There is also a finite-sample one-sided characterization. Conditional on the deviances, the alternative sign likelihood ratio is proportional to \(\exp(\beta T)\), where \(T=\sum_i g(D_i)S_i\). Thus the most powerful conditional lower-tail test rejects for small \(T\), with conditional randomization at its boundary, simultaneously for every \(d<1\) and every \(k>0\). The upper-tail analogue is valid for \(d>1\). This is the Neyman–Pearson test for each option with the same sign of \(\beta\).

## 5. Two observations suffice without full-vector conditioning

The conditional requirement in Theorem 2 matters. Consider arbitrary fixed tests that control level \(\alpha\) uniformly over the common null shape, without conditioning on every deviance separately. A single test with two observations has power tending to one as \(d\downarrow0\) for every fixed alternative shape \(k>0\). No fixed one-observation test can do so. In fact for every such one-observation test and each \(k>0\), its downward limiting inferior power is at most \(\alpha\).

To construct the two-observation test, let the null shape be \(a>0\). The density of \(D\) is proportional to \(e^{-aD}b(D)\), where
\[
 b(D)=(1-r_-)^{-1}+(r_+-1)^{-1}.
\]
This follows from the null density transformation in (1). Given \(H=D_1+D_2=t\), the null law of \(U=D_1/t\) has a density on \((0,1)\) proportional to \(b(tu)b(t(1-u))\), independently of \(a\). It is symmetric about \(1/2\). At infinity \(b(D)\to1\). Near zero, the two branches have \(|r_\pm-1|\) of order \(\sqrt D\), by the Taylor expansion of the deviance at one. Thus \(b(D)\le C(1+D^{-1/2})\), and for \(t\ge1\) the conditional density kernel is dominated by an integrable multiple of \((1+u^{-1/2})(1+(1-u)^{-1/2})\). Dominated convergence yields convergence to the uniform density. Reject when \(U\) belongs to the central interval around \(1/2\) of conditional probability \(\alpha\). Its half-width tends to \(\alpha/2\) as \(t\to\infty\). Under the downward alternative \(D_i/L\to1\), so \(H\to\infty\) and \(U\to1/2\), giving power tending to one. The test has exact conditional level given \(H\) for all common shapes.

For the lower bound, take \(0<a<k\). Let \(B\) be Beta\((a,k-a)\), independent of \(X\) of shape \(k\) and rate \(k\). The null law at shape \(a\) is the law of \(d_a X\) for the random scale \(d_a=(k/a)B\). Indeed independently drawing Gamma variables with unit rate and shapes \(a,k-a\) gives a total of shape \(k\), independent of the first one's fraction, by the usual change of variables to total and fraction. The product \(d_a X\) is the first Gamma divided by \(a\). Also
\[
 \mathbb E[d_a^{1/2}]
 = (k/a)^{1/2}
   \frac{\Gamma(a+1/2)\Gamma(k)}{\Gamma(a)\Gamma(k+1/2)}
 = O(\sqrt a) \qquad(a\downarrow0),
\]
so \(d_a\to0\) in probability. Any fixed one-observation test whose power were eventually bounded below by \(\alpha+\epsilon\) for all small \(d\) at shape \(k\) would then have level greater than \(\alpha\) under the null mixture at sufficiently small shape \(a\). This contradicts uniform level. The constant randomized test attains the limiting inferior benchmark \(\alpha\). The construction uses a common shape across observations and a fixed test independent of the alternative scale.

If the one-observation rule may depend on the target scale \(d=e^{-L}\), the order of quantifiers changes. Under the null, \(b(D)>1\) makes the density normalizer at shape \(a\) at most \(a\). For large \(D\), \(b(D)\) is bounded, so the density over all shapes is bounded by \(C\sup_{a>0}a e^{-aD}=C/(eD)\). The rule rejecting on \(|D-L|\le\sqrt L\) therefore has size \(O(L^{-1/2})\) uniformly in the null shape, and has alternative power tending to one because \(D-L=O(1)\) in probability at each fixed \(k\). This does not contradict the fixed-rule lower bound.

## 6. Source and scope

The archived case establishes the nuisance-free conditional signs and their exact first-order information at the null. The results here quantify the first strictly positive information loss, the two extreme-evidence scales, and the optimal full-vector conditional power. Conditioning on the sum of two deviances gives a different shape-valid procedure and a sharp fixed-test sample distinction. The comparison is limited to the pinned repository record.
