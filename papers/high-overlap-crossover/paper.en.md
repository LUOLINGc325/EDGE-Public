---
title: "A Poisson-to-Gaussian crossover for nearly coincident threshold counts"
lang: en
geometry: margin=0.85in
---

# Abstract

Two Poisson counts of common mean \(r\) share a component of relative intensity \(a\). We study the probability that both counts are at most \(m\), compared to the marginal lower tail to the power \(2-a\). In the simultaneous limit \(a=1-\kappa/m\), \(r=m\rho\), with \(\kappa>0\) and \(\rho>1\), their ratio converges to the moment \(\mathbb E[\rho^{\min(U,V)-\kappa}]\) for independent Poisson variables of mean \(\kappa\). This moment defines a unique critical intensity ratio, strictly decreasing with \(\kappa\). We compute its small- and large-\(\kappa\) scales and identify the large-\(\kappa\) constant with the endpoint of the Gaussian phase curve. A uniform logarithmic correction also gives the displacement of finite-threshold crossings near the limit.

# 1. Model and statements

Write \(q_m(r)=\Pr(\operatorname{Poi}(r)\le m)\). For \(a\in[0,1]\), let independent \(Z,X,Y\) have means \(ar,(1-a)r,(1-a)r\), respectively, and write
\[
 p_m(r,a)=\Pr(Z+X\le m,\ Z+Y\le m).
\]
For \(\kappa>0,\rho>1\), let \(U,V\) be independent Poisson variables of mean \(\kappa\), and set
\[
 \mathcal R_\kappa(\rho)=\mathbb E[\rho^{\min(U,V)-\kappa}],
 \qquad K(\kappa,\rho)=\log\mathcal R_\kappa(\rho).
\]

**Theorem 1.** As \(m\to\infty\), uniformly for \((\kappa,\rho)\) on compact subsets of \((0,\infty)\times(1,\infty)\),
\[
 \log\frac{p_m(m\rho,1-\kappa/m)}{q_m(m\rho)^{\,1+\kappa/m}}
 =K(\kappa,\rho)+\frac{\kappa\log m}{2m}+O(m^{-1}).                        \tag{1}
\]

**Theorem 2.** For every \(\kappa>0\), there is a unique \(\rho_\kappa>1\) with \(K(\kappa,\rho_\kappa)=0\). The sign is negative for \(1<\rho<\rho_\kappa\), and positive for \(\rho>\rho_\kappa\). The curve \(\kappa\mapsto\rho_\kappa\) is smooth and strictly decreasing. At every fixed \(\rho>1\) there is also a unique positive \(\kappa\) where the sign changes from negative to positive as \(\kappa\) increases. The endpoint scales are
\[
 \kappa\rho_\kappa=\log(1/\kappa)+\log\log(1/\kappa)+o(1)
       \quad(\kappa\downarrow0),
 \qquad
 \sqrt\kappa\log\rho_\kappa\ \longrightarrow\ \sqrt2\,d_*
       \quad(\kappa\to\infty),                                           \tag{2}
\]
where \(d_*>0\) is the unique positive root of \(2\Phi(-d)=e^{-d^2}\).

At a fixed \(\kappa>0\), any sufficiently small neighborhood of \(\rho_\kappa\) contains a solution of \(p_m(m\rho,1-\kappa/m)=q_m(m\rho)^{1+\kappa/m}\) for all sufficiently large \(m\). Every such solution in a fixed compact interval inside \((1,\infty)\) satisfies
\[
 \rho=\rho_\kappa-\frac{\kappa\log m}
                    {2m\,\partial_\rho K(\kappa,\rho_\kappa)}+O(m^{-1}).
 \tag{3}
\]

# 2. The simultaneous large-threshold limit

Put \(r=m\rho\) and \(s=(m-\kappa)\rho\). If \(M=\max(X,Y)\) for independent Poisson variables of mean \(\kappa\rho\), conditioning on them gives \(p_m=\mathbb E q_{m-M}(s)\), with negative-index tails interpreted as zero. For a nonnegative integer \(l\) and a mean \(t>0\), the lower tail divided by its last mass is
\[
 \frac{q_l(t)}{e^{-t}t^l/l!}
   =\sum_{j=0}^l\frac{(l)_{\underline{j}}}{t^j},
\]
where \((l)_{\underline{j}}\) denotes the falling factorial. For \(k\le m/2\), rewrite this ratio with \(l=m-k,t=s\) as
\[
 \sum_{j=0}^{m-k}\rho^{-j}(1-\kappa/m)^{-j}
         \prod_{i=0}^{j-1}\bigl(1-(k+i)/m\bigr).
\]
On the parameter compacts of Theorem 1 this equals \(\rho/(\rho-1)+O((k+1)/m)\). Indeed for \(j\le m-k\) all product factors lie in \([0,1]\), and the product differs from \(1\) by at most \(\sum_{i<j}(k+i)/m\). The factor \((1-\kappa/m)^{-j}\) is uniformly bounded for \(j\le m\) and differs from \(1\) by \(O(j/m)\). Summing these errors against the uniformly decaying \(\rho^{-j}\) gives the stated bound. The omitted geometric tail after \(m-k\) is exponentially small. The same estimate at \(l=m,t=r\) gives \(\rho/(\rho-1)+O(m^{-1})\).

The ratio of the two last masses at \(m-k,s\) and at \(m,r\) is
\[
 e^{\kappa\rho}(1-\kappa/m)^m
       \frac{(m)_{\underline{k}}}{s^k}.
\]
The first two factors combine to \(e^{\kappa(\rho-1)}(1+O(m^{-1}))\). In the last factor, extract \(\rho^{-k}\) and apply the same product estimate, giving an absolute error from \(\rho^{-k}\) of order \(O((k^2+1)/m)\). Combining with the tail-to-mass ratios yields
\[
 \frac{q_{m-k}(s)}{q_m(r)}
    =e^{\kappa(\rho-1)}\rho^{-k}+O((k^2+1)/m),\qquad k\le m/2.
\]
For \(k>m/2\) the ratio is bounded above by the \(k=0\) ratio. Since \(M\) has uniformly bounded second moment on the compacts, averaging the last display gives
\[
 \frac{p_m(r,1-\kappa/m)}{q_m(r)}
   =e^{\kappa(\rho-1)}\mathbb E[\rho^{-M}]+O(m^{-1}).                       \tag{4}
\]
The leading term is bounded away from zero on such compacts by the contribution from \(X=Y=0\).

Stirling's formula and the tail-to-mass ratio give
\[
 q_m(m\rho)=\frac{\rho}{(\rho-1)\sqrt{2\pi m}}\,
       e^{-m I(\rho)}(1+O(m^{-1})),\qquad I(\rho)=\rho-1-\log\rho .
\]
Thus raising \(q_m(m\rho)\) to the power \(-\kappa/m\) contributes \(\kappa I(\rho)+(\kappa\log m)/(2m)+O(m^{-1})\) in logarithms. The limit obtained from (4) and this factor simplifies exactly. Expanding the two private counts gives
\[
 \begin{aligned}
 e^{\kappa(\rho-1)+\kappa I(\rho)}\mathbb E[\rho^{-M}]
 &=e^{-2\kappa}\rho^{-\kappa}
        \sum_{i,j\ge0}\frac{\kappa^{i+j}}{i!j!}\rho^{i+j-\max(i,j)}\\
 &=\mathcal R_\kappa(\rho).
 \end{aligned}
\]
This proves (1).

# 3. The critical curve and its order

At fixed \(\kappa\), \(K(\kappa,e^x)\) is the log moment-generating function of \(\min(U,V)-\kappa\). It is strictly convex in \(x\), equals zero at zero, and has derivative there \(-\mathbb E|U-V|/2<0\). It tends to infinity as \(x\to\infty\), since \(\min(U,V)\) has positive probability of exceeding \(\kappa\). Hence it crosses zero once on \(x>0\), with strictly positive derivative, giving the asserted signs in \(\rho\).

For monotonicity of the curve, fix \(\rho>1\) and let \(p_{\mathrm{tie}}\) be the tie probability under the law of independent Poisson variables of mean \(\kappa\) tilted by \(\rho^{\min(U,V)}\). Poisson differentiation with respect to \(\kappa\) adds one count in each coordinate in the generator formula. The tilt changes by the factor \(\rho\) when one count is increased and that count was strictly smaller. Thus
\[
 \partial_\kappa K(\kappa,\rho)
      =(\rho-1)(1-p_{\mathrm{tie}})-\log\rho.                              \tag{5}
\]
For example, the add-one identity follows by differentiating the Poisson weights and shifting the index of their upward term. The differentiations here and below are justified by absolute convergence on compact parameters.

To see that \(p_{\mathrm{tie}}\) strictly decreases, write \(t=\kappa\sqrt\rho\) and
\[
 I_j(t)=\sum_{l\ge0}\frac{t^{2l+j}}{l!(l+j)!}\qquad(j\ge0).
\]
The identity \(\rho^{\min(i,j)}=\rho^{(i+j)/2}\rho^{-|i-j|/2}\) gives
\[
 p_{\mathrm{tie}}=
 \left(1+2\sum_{j\ge1}\rho^{-j/2}\frac{I_j(t)}{I_0(t)}\right)^{-1}.
\]
Each ratio \(I_j/I_0\) strictly increases in \(t>0\). For a direct proof, set \(R_j=I_{j+1}/I_j\). Termwise differentiation and coefficient comparison give
\(I_j'=2I_{j+1}+j I_j/t\) and
\(I_j-I_{j+2}=(j+1)I_{j+1}/t\), so
\[
 R_j'=2(1-R_j^2)-(2j+1)R_j/t.
\]
The derivative is positive near zero because \(R_j(t)=t/(j+1)+O(t^3)\). At any zero of the derivative,
\(R_j''=(2j+1)R_j/t^2>0\), which forbids a first zero following a positive derivative. Thus \(R_j'>0\), and \(I_j/I_0\) is the product of \(j\) strictly increasing positive adjacent ratios. This proves the tie monotonicity.

Equation (5) now makes \(K(\kappa,\rho)\) strictly convex in \(\kappa\) at fixed \(\rho\). Its value at zero is zero and its right derivative is \(-\log\rho<0\). For its growth at infinity, the same series identity rewrites the moment as
\[
 \mathcal R_\kappa(\rho)
 =e^{2\kappa(\sqrt\rho-1-\log\sqrt\rho)}
     \mathbb E_{\operatorname{Poi}(t)^2}
             [\rho^{-|U-V|/2}].
\]
The expectation is at least the chance that both variables equal \(\lfloor t\rfloor\), of order \(t^{-1}\) by Stirling's formula. The exponential coefficient is positive for \(\rho>1\), so \(K\) tends to infinity. There is therefore one positive crossing in \(\kappa\), also with strictly positive derivative. At a point of the curve, both partial derivatives of \(K\) are strictly positive. The implicit function theorem gives smoothness and
\(d\rho_\kappa/d\kappa=-\partial_\kappa K/\partial_\rho K<0\).

# 4. Endpoint scales and the finite-threshold displacement

For \(\kappa\to\infty\), put \(\rho=\exp(z/\sqrt\kappa)\) for fixed \(z>0\). The centered Poisson variables divided by \(\sqrt\kappa\) converge to independent standard normals \(N_1,N_2\). The relevant exponentials are uniformly integrable: their second moments are bounded by \(\mathbb E\exp(2z(U-\kappa)/\sqrt\kappa)\), which is bounded by the Poisson moment-generating formula. Consequently
\[
 \mathcal R_\kappa\bigl(e^{z/\sqrt\kappa}\bigr)
    \longrightarrow
    \mathbb E e^{z\min(N_1,N_2)}
    =2e^{z^2/2}\Phi(-z/\sqrt2).
\]
For the last identity, the minimum has density \(2\phi(x)\Phi(-x)\). Exponential tilting shifts \(\phi(x)\) to the density of a normal of mean \(z\); integrating \(\Phi(-x)\) against the tilted density gives \(\Phi(-z/\sqrt2)\). This limiting moment starts at one with strictly negative derivative in \(z\), is strictly log-convex, and tends to infinity. For the last fact it suffices that the minimum has positive probability of exceeding one. Its unique positive crossing is \(z=\sqrt2\,d_*\). Bracketing it by fixed positive \(z\) on either side and using the strict signs of the Poisson moments proves the large-\(\kappa\) limit in (2).

For \(\kappa\downarrow0\), set \(L=\log(1/\kappa)\) and write \(\rho=x/\kappa\) with \(x\in[L/2,2L]\). The tail-sum identity for a nonnegative integer variable gives
\[
 \mathbb E[\rho^{\min(U,V)}]
   =1+(\rho-1)\sum_{j\ge1}\rho^{j-1}\Pr(U\ge j)^2.
\]
The first tail contributes \(\kappa x+O(\kappa^2(x+1))\). For \(j\ge2\), the factorial moments give \(\Pr(U\ge j)\le\kappa^j/j!\). The remaining sum is \(O((\kappa x)^2)\), by bounding it with the corresponding geometric series in \(\rho\kappa^2=\kappa x\). Taking the logarithm yields, uniformly on this bracket,
\[
 \kappa^{-1}K(\kappa,x/\kappa)
       =x-L-\log x+O(\kappa(x^2+x+1)).
\]
The signs at \(x=L/2\) and \(2L\) are opposite for small \(\kappa\). Thus the root lies in the interval, and it satisfies \(x=L+\log x+o(1)\). This first gives \(x/L\to1\) and then \(x=L+\log L+o(1)\), proving the other endpoint.

Finally fix \(\kappa>0\). By (1), at two fixed intensities on opposite sides of \(\rho_\kappa\) the log ratio has opposite signs for all large \(m\). Continuity gives a finite-threshold zero in every sufficiently small fixed neighborhood. Any zero in a fixed compact interval inside \((1,\infty)\) must approach \(\rho_\kappa\), by uniform convergence and uniqueness of that limiting zero. Since the derivative \(\partial_\rho K\) there is strictly positive, (1) first shows that the zero lies within \(O((\log m)/m)\) of \(\rho_\kappa\). Taylor expanding \(K\) there gives (3), with the quadratic remainder absorbed into \(O(m^{-1})\). The displacement formula applies to all such finite zeros in that regime.

# 5. Relation to the pinned sources

The pinned Poisson case determines the intensity threshold for the inequality simultaneously over all overlaps and treats its normal-scale location. The pinned Gaussian supplement gives a threshold for each normal correlation and the constant \(d_*\) at near-perfect correlation. Here the expected number of private counts stays of order one and \(r-m\) is of order \(m\). The exact limiting moment and its strictly ordered boundary connect this regime to \(d_*\) as \(\kappa\) grows. The companion verifier encloses several crossover roots using rational bounds on the positive series. For example \(5.20<\rho_1<5.21\) and \(2.17<\rho_5<2.18\). At \(\kappa=1,\rho=5.20\), it verifies that the finite Poisson ratios for \(m=12,24,40\) already exceed one. These finite comparisons supplement the asymptotic displacement result.
