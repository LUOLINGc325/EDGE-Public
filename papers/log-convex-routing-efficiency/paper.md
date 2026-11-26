# Sharp finite-size inefficiency on common-slope exponential parallel links

There are \(K\) atomic splittable users and \(N\) parallel links of costs \(c_j e^{\lambda z}\), with arbitrary \(c_j>0\) and a common \(\lambda>0\). Each user has a prescribed nonnegative demand and may split its whole demand among all links. For total load \(z_j\) on link \(j\), social cost is \(\sum_j z_j c_j e^{\lambda z_j}\). We characterize the worst equilibrium inefficiency for fixed \(K,N\), allowing arbitrarily many price classes and arbitrary demands.

**Theorem.** For \(K,N\ge2\) the supremum of equilibrium social cost divided by optimal social cost is
\[
 \frac{K e^{-d_*}}{1+N d_*},\qquad (1+d_*)e^{Nd_*}=K.
 \tag{1}
\]
Every finite instance of positive total demand has strictly smaller ratio. The supremum is approached by one cheap and \(N-1\) equally expensive links at the equilibrium threshold for using the expensive links. In the equal-demand reduction, any sequence approaching the supremum has, after permutation, one dimensionless equilibrium load tending to infinity and all others tending to zero. For \(K=1\) or \(N=1\) the ratio is one.

## Equal demands increase equilibrium cost

Rescale loads by \(\lambda\), so the common exponential slope is one. At any heterogeneous equilibrium, let \(p_j=c_j e^{x_j}\) be link \(j\)'s price at its aggregate equilibrium load \(x_j\). User \(i\)'s marginal condition gives \(x_{ij}=(\nu_i/p_j-1)_+\) for a multiplier \(\nu_i\); zero-demand users can take \(\nu_i=0\). The equal-demand equilibrium aggregate loads \(x'_j\) solve the common marginal equations with increasing marginal \(c_j e^z(1+z/K)\) on positive links and the corresponding inequality at zero. Indeed the profile \(x'_j/K\) for each user satisfies the individual optimality conditions. Conversely any equal-demand equilibrium must have equal multipliers, since \(\nu_i>\nu_\ell\) makes the \(i\)th flow strictly greater on each positive link of user \(\ell\), and weakly greater on all links.

At a heterogeneous equilibrium, the hypothetical symmetric marginal evaluated at the current aggregate load is
\[
 p_j(1+x_j/K)=K^{-1}\sum_i\max(p_j,\nu_i),
\]
a nondecreasing function of \(p_j\). The symmetric equilibrium multiplier \(\mu\) is at most \(\max_i\nu_i\): taking this latter price in the symmetric marginal equations yields at least \(x_j\) on each positive link, hence at least the total demand. Thus initially unused links remain unused in the symmetric allocation. On positive links the sign of \(x'_j-x_j\) has a single crossing in \(p_j\), positive on the cheaper-price side and negative on the dearer-price side. The derivative of social cost at \(x_j\) is
\[
 p_j(1+x_j)=p_j+\sum_i(\nu_i-p_j)_+ .
\]
This is nonincreasing on \(p_j\le\max_i\nu_i\), which includes every positive link. Consequently \(\sum_j p_j(1+x_j)(x'_j-x_j)\ge0\), by subtracting an intermediate derivative between the two sign classes and using conservation of aggregate flow. Convexity of the social cost gives \(C(x')\ge C(x)\). The optimal social cost only depends on the total demand, so the supremum is unchanged by using equal demands.

## Normalized price and scalar comparison

In the equal-demand game, divide all prices by the positive equilibrium multiplier. Every active link of equilibrium load \(x\) then has coefficient \(e^{-x}/(1+x/K)\), and an inactive link has coefficient at least one. Lower coefficients of inactive links to one. This preserves the equilibrium loads and cost, and can only decrease the optimal cost. In proving the bound it therefore suffices to assume the normalized coefficient is \(e^{-x}/(1+x/K)\) for every \(x\ge0\).

At a social optimum of the normalized instance, the common marginal is \(e^a\) for some \(0 < a < \log K\). At price one, the minimizing marginal equations produce loads at most their equilibrium levels, strictly below on every positive link. At price \(K\) they produce loads strictly above. Totals and monotonicity imply the bounds on \(a\), and all optimal loads are positive because every coefficient is at most one. Thus the optimal load \(y=y(x)\) on the link with equilibrium load \(x\) satisfies
\[
 y+\log(1+y)=x+\log(1+x/K)+a .
 \tag{2}
\]
Put \(d=y(0)\), \(s=1+d\), and \(b=\log K-a>0\), so \(a=d+\log(1+d)\). Define
\[
 U=\frac{K+x}{1+y},\quad \Delta(x)=y-x=\log U-b,\quad
 F(x)=s\,y/(1+y)-\Delta(x),\quad
 \rho_d(x)=\frac{F(x)}{x/(K+x)}\quad(x>0).
\]
Because \(d < \log K < K-1\), substituting \(x+d\) on the left of (2) gives a value at least its right side, strictly for \(x>0\). Hence \(y\le x+d\) and \(U>1\). If \(Z=K+x\) and \(A=K-1+b-\log U\), equation (2) gives \(Z=UA/(U-1)\), \(A=Z(1-1/U)>0\). This expression has strictly negative derivative as a function of \(U\). Thus \(U\) decreases from \(K/s\) toward 1, and \(\Delta\) decreases from \(d\) toward \(-b\). The limit follows since \(U>1\) bounds \(\Delta\) below and \(y\le x+d\) bounds it above.

**Scalar lemma.** At a fixed \(d\), \(\rho_d(x)\) is strictly decreasing on \(x>0\), with limit \(s+b\) at infinity.

To prove it, write \(z=U-1>0\), and regard \(Z(U)=UA/z\) and \(\Phi(U)=Z(U)\log U+sU\) as functions of \(U\). Direct substitution gives
\[
 \rho_d(x)=s+b+\frac{K(s+b)-\Phi(U)}{x},\qquad
 \Phi(K/s)=K(s+b).
\]
We claim that \(\Phi\) as a function of \(Z\) is strictly convex. Indeed
\[
 Z'=-(A+z)/z^2,\qquad Z''=[2A+z(1+1/U)]/z^3 .
\]
The sign of its second derivative with respect to \(Z\) is the sign of \((\Phi'' Z'-\Phi' Z'')/(Z')^3\). Multiplying the numerator by \(Uz^4\) gives
\[
 z\{-A^2+2A(1-Us)+z[2-(U+1)s]\} < 0 .
\]
This identity follows by writing the numerator as \(2(Z')^2/U-Z'Z/U^2-Z''(Z/U+s)\) and substituting the preceding two derivatives. As \(Z' < 0\), the second derivative is positive. Thus \(K(s+b)-\Phi(U(x))\) is strictly concave in \(x\) and vanishes at zero. Its quotient by \(x>0\) decreases strictly. The finite limit of \(\Phi(U)\) at \(U=1\) implies the claimed limit of \(\rho_d(x)\).

## Reduction to a single loaded link or its limit

By conservation \(\sum_j\Delta(x_j)=0\), and \(F(0)=0\). The ratio for the normalized instance is therefore
\[
 R=\frac{K e^{-d}\sum_j x_j/(K+x_j)}
          {\sum_{j:x_j>0}[x_j/(K+x_j)]\rho_d(x_j)} .
 \tag{3}
\]
If \(d\ge d_*\), the scalar lemma gives
\[
 R < \frac{K e^{-d}}{s+b}
   =\frac{K e^{-d}}{1+\log K-\log(1+d)} .
\]
The last expression strictly decreases in \(d>0\) on the relevant interval: its logarithmic derivative is \(-1+1/[(1+d)(s+b)] < 0\). Evaluating at \(d_*\) gives (1).

If \(d < d_*\), then \(b>(N-1)d\). Each link satisfies \(\Delta(x_j)\ge-(N-1)d\), because all the other differences are at most \(d\). There is a unique \(X>0\) with \(\Delta(X)=-(N-1)d\); every \(x_j\le X\). The scalar lemma and (3) bound \(R\) by \(K e^{-d}/\rho_d(X)\). This is exactly the ratio \(I(d)\) of the one-loaded-link vector \((X,0,\ldots,0)\), since it has the same \(a\) and its differences sum to zero.

For completeness, the strict bound \(I(d) < I(d_*)\) follows from the following one-variable calculation, which is also the two-price contrast comparison. Set \(n=N-1\), \(E=e^{Nd}\), \(H=(1+d)E\), and \(P=H-1+nd\). On the comparator the social loads are \(X-nd\) and \(d\). Equation (2) gives \(X=KP/(K-H)\) and
\[
 I(d)=e^{nd}\frac{P}{Q},\qquad
 Q=E[1+Nd+(Nn/K)d^2]-1 .
\]
For \(0 < d < d_*\), \(1 < H < K\). The sign of \(I'\) is the sign of \(S=(nP+P')Q-PQ'\), affine in \(\theta=1/K\). Differentiate holding \(\theta\) constant before evaluating. Algebra at \(\theta=0\) and \(\theta=1/H\) gives
\[
 S(0)=d(E-1)n(ENd+EN+E+N-1),\qquad
 S(1/H)=\frac{d(E-1)n(Nd+N+1)P}{1+d}.
\]
Both are positive, so \(S(\theta)>0\) for the actual \(\theta=1/K\). As \(d\uparrow d_*\), \(X\to\infty\) and \(Q/P\to(1+Nd_*)/(1+d_*)\), giving the value in (1). The comparator has equilibrium costs with the \(N-1\) inactive links exactly at their usage threshold. This proves strict finite upper bounds and sharpness.

Finally suppose a sequence of normalized equal-demand instances approaches (1). The continuous one-sided bounds from (3) force \(d\to d_*\) by strict monotonicity on both intervals (the limit of \(I(d)\) at zero is one). If equilibrium loads remained bounded along a subsequence, a limit would give a finite \(d=d_*\) instance and strict inequality. The limit cannot have all loads zero, since their differences would all be \(d_*>0\). Hence the largest load tends to infinity. Its difference tends to \(-(N-1)d_*\), and every other difference is bounded by \(d\). Conservation forces all of those differences to tend to \(d_*\), which by the strict decrease of \(\Delta\) means their equilibrium loads tend to zero. This applies also before coefficients of inactive links are lowered, because that comparison left the equilibrium loads unchanged and preserved the property of approaching the upper bound.

## Relation to prior work

Brun and Prabhu's common-shape model already gives the equal-demand reduction. The short price-crossing proof above specializes that fact to exponentials. Brun and Doncel obtain the critical-demand reduction for two price classes and leave the multiclass analysis open in §6.2. The exact contrast formula for two classes does not itself compare those classes to an arbitrary coefficient vector. The scalar convexity lemma above eliminates that restriction for the global fixed-\(N\) price of anarchy. It does not identify which of the possibly many local demand maxima is largest for each fixed coefficient vector. General local smoothness controls a broader strategy class and does not retain the finite link count needed for (1). [Brun and Prabhu](https://doi.org/10.1007/s10479-014-1747-7) [Brun and Doncel](https://doi.org/10.1007/s10479-025-06648-y) [Roughgarden and Schoppmann](https://doi.org/10.1016/j.jet.2014.04.005)
