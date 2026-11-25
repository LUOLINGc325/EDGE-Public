---
title: "The trivariate two-sided Gaussian Simes inequality without a high-level correlation cap"
subtitle: "Uniform treatment of exact and near-duplicate statistics"
lang: en
---

# The trivariate two-sided Gaussian Simes inequality without a high-level correlation cap

## Abstract

We prove the two-sided Gaussian Simes inequality for three statistics at levels sufficiently close to one, uniformly over every positive semidefinite correlation matrix. Earlier high-level bounds assumed all absolute pair correlations were bounded away from one. We treat the missing region by comparing with the exact duplicate-pair problem and estimating the added probability from two nearby nonrejection strips. The added fraction is of order the smaller of the strip width and the standard deviation of the difference. It dominates the probability of violating the other nonrejection constraints even when both scales tend to zero together. We also characterize all equality cases.

## 1. Result and notation

Let Z=(Z_1,Z_2,Z_3) be centered Gaussian with unit marginal variances and correlation matrix Σ, which may be singular. Define P_i=2[1−Φ(|Z_i|)] and write F_Σ(q) for the probability that the Simes rule rejects at level q. The rule rejects when P_(j)≤jq/3 for some j=1,2,3.

**Theorem 1.** There is a universal q₀<1 such that for every positive semidefinite correlation matrix Σ and all q₀<q<1,

~~~text
F_Σ(q) ≤ q.
~~~

Equality holds exactly in the following three cases, allowing any permutation or independent sign change of the coordinates.

1. The three statistics are independent.
2. Two statistics coincide almost surely and the third is independent of them.
3. All three statistics coincide almost surely.

In the second and third cases this includes exact repeats up to sign. These equality cases in fact have equality at every q in (0,1).

The archived *The trivariate two-sided Gaussian Simes inequality near level one* proves the result, with strict inequality off independence, when max |Σ_ij| is below any fixed cap r<1. Its level neighborhood depends on r. We use that capped theorem only after treating a uniform neighborhood of the missing boundary. The new argument covers matrices approaching exact duplication at any rate relative to 1−q.

Use the thresholds

~~~text
a=Φ⁻¹(1−q/6),    b=Φ⁻¹(1−q/3),    c=Φ⁻¹(1−q/2),
h=1−q=Pr(|N(0,1)|≤c).                                         (1)
~~~

Nonrejection means that all absolute statistics are at most a, at most one exceeds b, and at least one is at most c. We freely use nonstrict thresholds because each marginal has no atoms. As q tends to one, a and b tend to distinct positive constants a₀ and b₀, while c tends to zero. By restricting to q near one, fix positive lower bounds a_−, b_−, and g_− on a, b, and a−b, along with finite upper bounds. We will shrink this neighborhood through upper bounds on c. In particular assume c≤min(1,b_−/4), so h≤c.

## 2. A pair of exact duplicates

Let G,W be standard Gaussian with correlation ρ and define

~~~text
A = {|G|≤c, c<|W|≤a} ∪ {|W|≤c, |G|≤b}.                       (2)
~~~

This is the nonrejection event for the triple (G,G,W). The following lower bound is useful even when the actual pair is only nearly duplicated.

**Lemma 2.** Fix r<1. For all |ρ|≤r and q sufficiently close to one, Pr(A)≥h, with strict inequality when ρ≠0. The level range is uniform over this cap.

**Proof.** Sign changes allow ρ≥0. The joint Gaussian law of (G,W) is invariant under exchanging G and W. For t>0 define G_t(ρ,x)=Pr(|W|≤t|G=x). Conditioning in (2) and exchanging variables in the second event gives the integral of

~~~text
G_a(ρ,x)+G_b(ρ,x)−G_c(ρ,x)
~~~

over |x|≤c with standard normal weight. At ρ=0 the integrand is exactly one, since the three probabilities are 1−q/3, 1−2q/3, and 1−q.

Put σ=√(1−ρ²) and u_±=(t±ρ|x|)/σ. Direct differentiation of the conditional Gaussian probability gives

~~~text
∂G_t/∂ρ = [φ(u_−)+φ(u_+)]/σ³
           · [ρt−|x| tanh(tρ|x|/σ²)].                         (3)
~~~

Here φ is the standard normal density. Indeed, differentiating each normal cdf term gives a factor (ρt±|x|)/σ³, and the density difference divided by the density sum is −tanh(tρ|x|/σ²). For |x|≤c and σ²≥1−r², the bracket at t=a or b is at least ρt(1−c²/(1−r²)), by tanh v≤v. At sufficiently small c, the density sum at these thresholds has a positive lower bound depending on r because the arguments lie in a compact interval. Thus the derivative at each of a and b is at least k_r ρ for some k_r>0. At t=c, (3) gives an upper bound of K_r ρc, because the subtracted term is nonnegative and σ is bounded below. Taking c small enough, the derivative of the integrand is positive for ρ>0. Integrating in ρ, then over the strip, proves the result.

## 3. A pair of near duplicates with a separated third statistic

**Lemma 3.** Fix r<1. There are constants d_r>0 and c_r>0 such that whenever corr(G_1,G_2)=1−2d² with 0<d≤d_r, |corr(G_1,W)|≤r, and 0<c≤c_r, the nonrejection probability of (G_1,G_2,W) is strictly greater than h.

**Proof.** Let Y=(G_1+G_2)/2 and D=(G_1−G_2)/2. They are independent centered Gaussians of variances 1−d² and d². Take the event A of (2) with G=G_1. Choose a fixed bivariate difference cutoff d₀>0 small enough that c+2d₀<b and b+2d₀<a for all sufficiently small c. For example restrict c≤b_−/4 and choose 2d₀<min(b_−/2,g_−). On |D|≤d₀, A implies genuine nonrejection. In the first part of A, |G_2|≤c+2d₀<b. In the second part, |G_2|≤b+2d₀<a, and both |W| and |G_1| are at most b.

The possible loss from |D|>d₀ is bounded by conditioning on either G_1 or W on its strip. For either variable Z, given Z=x with |x|≤c the mean of D is cov(D,Z)x with absolute value at most dc. Its conditional variance is at most d². For small d, dc≤d₀/2, so the conditional Gaussian tail is at most 2 exp(−d₀²/(8d²)), also covering zero conditional variance. Thus

~~~text
Pr(A and |D|>d₀) ≤ 4h exp(−d₀²/(8d²)).                        (4)
~~~

We now produce an additional nonrejection event disjoint from A. Put U=D/d and represent

~~~text
W = αY/√(1−d²) + βU + γV,
~~~

where V is a standard normal independent of Y,U, γ≥0, and α²+β²+γ²=1. This representation includes singular cases by allowing γ=0. Since |cov(Y,W)|≤r+d, for sufficiently small d we have |α|≤(1+r)/2. Thus |β|+γ≥s₀=√[1−((1+r)/2)²]>0.

Fix a small ℓ>0 such that 2ℓ√2+ℓ/4<a_−. Restrict U to the interval of the sign of β with |U| between ℓ and 2ℓ, and restrict V to [ℓ,2ℓ]. When β=0 use the positive interval for U. These independent restrictions have fixed positive probability and ensure

~~~text
ℓs₀ ≤ βU+γV ≤ 2ℓ√2 .
~~~

For each permitted U, the set of Y for which |Y−D|≤c<|Y+D| has length min(2c,2|D|). This follows by subtracting the interval of radius c centered at −D from the interval centered at D. On this set |Y|≤c+2ℓd. For sufficiently small c,d the term αY/√(1−d²) has magnitude at most ℓs₀/4, hence c<W<a. Also |D|≤2ℓd≤d₀, so both |G_1| and |G_2| are below b. These points are genuine nonrejections with |W|>c and |G_1|>c, hence are outside A.

The density of Y on the indicated interval is bounded below by a positive constant for small c,d, since its variance tends to one and the interval lies near zero. With |D|≥ℓd and independent Y,U,V, the additional event has probability at least k'_r min(c,d) for some k'_r>0. The loss in (4) is smaller than half that gain when d is sufficiently small, uniformly over 0<c≤c_r. Indeed h≤c and

~~~text
[c / min(c,d)] exp(−d₀²/(8d²))
 ≤ max(1,c_r/d) exp(−d₀²/(8d²)) → 0    as d→0.
~~~

Combining with Lemma 2 proves strict inequality for the true triple.

## 4. A cluster of three near duplicates

**Lemma 4.** After sign changes suppose all three pair correlations are at least 1−2d², where d=max_(i<j) √[(1−corr(Z_i,Z_j))/2]. For sufficiently small d and c, if d>0 then the nonrejection probability is strictly greater than h. If d=0, nonrejection has probability h.

**Proof.** For d=0 the variables coincide almost surely. Otherwise choose a pair (G_1,G_2) attaining d, and again put Y=(G_1+G_2)/2 and D=(G_1−G_2)/2. Let U be the union of the two strips |G_1|≤c or |G_2|≤c. The individual strip probability is h. The additional piece |G_2|≤c<|G_1| has conditional Y-length min(2c,2|D|). Restricting D/d to [1/2,1] gives a fixed positive Gaussian probability and keeps the Y interval bounded near zero. Since Y is independent of D with variance 1−d², the gain is at least k min(c,d) for an absolute k>0.

The event U restricted to all three |Z_i|≤b is contained in nonrejection. For any G from the chosen pair and any other Z_i, the conditional law of Z_i given G=x with |x|≤c has mean of magnitude at most c and variance at most 4d². Here the variance bound follows from 1−corr²≤2(1−corr)≤4d². Taking c≤b_−/4, the chance that this conditional |Z_i| exceeds b is at most 2 exp(−b_−²/(32d²)), also when the conditional variance is zero. A union bound over the two stripes and the other coordinates bounds the discarded probability by 8h exp(−b_−²/(32d²)). As in (4), this is smaller than half of the strip gain for all sufficiently small d, uniformly in c. This proves the lemma.

## 5. One level range for all correlation matrices

Fix a positive radius d_T and an upper bound on c from Lemma 4. Choose τ>0 with 2√(τ/2)≤d_T, and put r=1−τ. Use Lemmas 2 and 3 for this fixed r. Choose η>0 with η≤τ so small that √(η/2)≤d_r from Lemma 3. Shrink the upper bound on c to satisfy both pair lemmas as well as Lemma 4 and the threshold bounds in Section 1.

If all absolute pair correlations are at most 1−η, use the capped theorem at cap 1−η. For every other correlation matrix, relabel and sign-change the variables to arrange corr(Z_1,Z_2)>1−η. If |corr(Z_1,Z_3)|≥1−τ, choose the sign of the third coordinate to make its correlation with Z_1 nonnegative. In the resulting orientation,

~~~text
||Z_2−Z_3||₂ ≤ ||Z_2−Z_1||₂ + ||Z_1−Z_3||₂ 
             ≤ 4√(τ/2),
~~~

where the norm is the square root of the expectation of the square. The two other pairs satisfy at least as strong a bound. Since ||Z_i−Z_j||₂=2√[(1−corr(Z_i,Z_j))/2], this is the region of Lemma 4. If |corr(Z_1,Z_3)|<1−τ, apply Lemma 3 when the first pair is distinct and Lemma 2 when it coincides exactly. This covers all matrices, including any singular covariance. A single q₀ can be chosen to meet the common upper bound on c and the archived level cutoff for 1−η.

The capped theorem is strict off independence. Lemma 4 is strict unless all three coincide after signs. Lemma 3 is strict for a separated third statistic and d>0. Lemma 2 is strict when the exact repeated pair is correlated with the third. Thus equality can only occur in the three cases specified.

For three independent p-values, put w=q/3 and h=1−q. Nonrejection comprises three draws in the last interval of length h, two there and one in the middle two intervals of total length 2w, or one there and two in the middle intervals with at most one in the first of those two. The probability is h³+6wh²+9w²h=h. For an independently repeated pair, (2) has probability h[(1−q/3)+(1−2q/3)−h]=h. For three exact repeats the rule is a one-variable test at level q. These give equality for all 0<q<1 and finish the proof.

## 6. Scope and attribution

The pinned source proves the high-level theorem under fixed correlation caps and identifies merging near-zero strips as its missing boundary case. The estimates above handle that case by comparing the strip gain and the conditional Gaussian tail loss. The uniform level range is an existence result. The proof addresses the three-statistic problem near level one and does not settle the all-level Gaussian Simes question. The comparison is bounded to the pinned repository record.
