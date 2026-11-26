# Persistence exponents for ordered families of Brownian and Ornstein–Uhlenbeck walkers

## Abstract

We determine the asymptotic decay rates of nonintersection in an ordered chamber for finitely many families of independent Ornstein–Uhlenbeck walkers. Within-family crossings are allowed. At comparable group speeds and negligible individual speed, the normalized exponent equals the minimum of a one-dimensional Dirichlet spectral partition up to a uniform cube-root error. Two equal Brownian families have asymptotic survival exponent one half per walker. When the ratio of two group speeds diverges, an Airy correction holds uniformly even when both family sizes diverge and speeds inside either family are unrestricted. We also obtain the corresponding one-leader real-moment asymptotic, with a conditional application to the entropy of open TASEP.

## 1. The persistence rate

Let \(X,Y_1,\ldots,Y_n\) be independent standardized stationary Ornstein–Uhlenbeck processes. The generator of \(X\) is \(\ell(\partial_x^2-x\partial_x)\), with fixed \(\ell>0\). The generator of \(Y_i\) is \(a_i(\partial_{y_i}^2-y_i\partial_{y_i})\), with \(a_i>0\). The corresponding standardized one-time variances are one. Compare the leader position \(kX\) with each \(Y_i\), where \(k>0\) is the ratio of physical stationary standard deviations. Define
\[
\lambda(\ell,k;a_1,\ldots,a_n)
=-\lim_{T\to\infty}T^{-1}\log\Pr\{Y_i(t)>kX(t)\ \text{for all }i,\ 0\le t\le T\}.
\]
Let \(A=\sum_i a_i\), \(R=\sqrt{2\log A}\) for \(A>1\), and \(r=R/k\). Let \(\xi_1>0\) be the smallest positive root of \(\mathrm{Ai}(-\xi_1)=0\).

**Theorem 1.** Along any sequence of finite nonempty follower collections with \(A\to\infty\), and fixed \(\ell,k>0\),
\[
\lambda(\ell,k;a_1,\ldots,a_n)
 =\frac{\ell r^2}{4}
    +\ell\,2^{-2/3}\xi_1\,r^{2/3}
    +o(r^{2/3}).
\tag{1}
\]
The little-oh is uniform over collections with a fixed total \(A\). The sizes of the collections may vary, and a common lower or upper bound on the individual speeds is unnecessary.

For \(k=1\) and \(\ell=a_i=1/2\), this is the Brownian leader persistence exponent after the Lamperti logarithmic time transformation. In this case (1) reads
\[
\lambda_n=\frac14\log n+2^{-4/3}\xi_1(\log n)^{1/3}
                           +o((\log n)^{1/3}).
\tag{2}
\]
Replacing \(\log(n/2)\) and \(\log(n+1)\) by \(\log n\) only changes lower-order terms.

For the Brownian identification, independently moving Brownian particles begun at deterministic strictly ordered leader/follower positions have, at Brownian time one and on survival, an endpoint subdensity bounded by the unrestricted shifted Gaussian density. The resulting density with respect to the centered standard Gaussian product measure is square integrable and is positive in the ordering domain. The process \(e^{-s/2}B_{e^s}\) for \(s\geq0\) follows the speed-\(1/2\) OU generator after Brownian time one, with the endpoint as its initial state. Projecting the initial subdensity and final survival probability onto the positive OU ground function gives the same exponent as under stationary initialization. Brownian time \(t\) corresponds to OU time \(\log t\), so the decay exponent for the Brownian ordering problem is exactly \(\lambda_n\).

## 2. Reduction to a one-dimensional energy

Let \(\gamma\) be the standard Gaussian measure. On the open domain \(D=\{(x,y):y_i>kx\text{ for every }i\}\), the killed diffusion is symmetric in the product Gaussian measure, with form
\[
\mathcal E(f)=\int_D\left(\ell|\partial_x f|^2+
                              \sum_i a_i|\partial_{y_i}f|^2\right)\,d\gamma^{n+1}.
\]
The closure is the Dirichlet form obtained from smooth compactly supported functions. Multiplication by the square root of the product Gaussian density maps the form to Lebesgue measure. Each standardized coordinate contributes its speed times
\[
-\partial_z^2+z^2/4-1/2.
\tag{3}
\]
Integration by parts on the compactly supported core gives (3). For each finite collection all speeds are positive, so the confining quadratic potential gives compact resolvent, including with the Dirichlet boundary. For example, form-bounded sequences have local \(H^1\) bounds, and the positive quadratic potential gives uniform \(L^2\) tail bounds. The connected domain and positive transition densities yield a positive ground function. The stationary survival integral is the inner product of the indicator of \(D\) with its killed-semigroup evolution. This indicator has positive overlap with the ground function. Spectral expansion therefore gives existence of the rate and identifies it with the bottom of the form. Starting on the boundary has Gaussian probability zero. Following a boundary hit, a difference of the two diffusions has nonzero noise variance and crosses its boundary immediately almost surely, so the formulation with non-strict comparisons has the same probability over positive times.

Write
\[
b(s)=\inf_{f\in H_0^1((s,\infty),\gamma)\setminus\{0\}}
  \frac{\int |f'|^2\,d\gamma}{\int |f|^2\,d\gamma}
\]
for the standardized follower cost at a fixed leader boundary \(s\). Gaussian Poincaré and Cauchy–Schwarz for the zero extension give
\[
b(s)\ge \Phi(s).
\tag{4}
\]
Indeed \((\int f\,d\gamma)^2\le (1-\Phi(s))\int f^2\,d\gamma\), and the Dirichlet energy is at least the variance. As \(u\to\infty\), the piecewise linear cutoff rising from zero to one on \([-u,-u+1/u]\) gives
\[
b(-u)\le C u e^{-u^2/2}.
\tag{5}
\]
Its energy is at most \(u^2\) times the Gaussian mass of this interval, which is \(O(e^{-u^2/2}/u)\). Its squared norm is bounded away from zero. The function is an admissible form limit of compactly supported cutoffs.

For a normalized \(L^2\) function \(f(x,y)\) in the transformed Dirichlet form, set \(g(x)=\big(\int |f(x,y)|^2dy\big)^{1/2}\) using zero extension. The norm map on \(L^2(dy)\) is a contraction, giving \(\int |g'|^2 dx\le\int |\partial_x f|^2 dx\,dy\), and \(\|g\|_2=1\). At each fixed \(x\), successive application of the single follower form to each coordinate gives a follower contribution at least \(A b(kx)g(x)^2\). The finiteness of the collection suffices for this fibre inequality. Hence the full ground energy is at least the infimum over normalized \(g\) of
\[
\int_{\mathbb R}\big[\,\ell |g'|^2+
                 (\ell(x^2/4-1/2)+A b(kx))g^2\,\big]\,dx .
\tag{6}
\]

There is a corresponding upper test with a single chosen cutoff \(x_0\). Use any leader function supported below \(x_0\) and independent follower trial functions supported above \(kx_0\). Their product is in the domain of the form and has additive energy. Taking the same normalized follower function close to the half-line infimum gives follower energy arbitrarily close to \(A b(kx_0)\). The case of a product of form-limit approximants follows by convergence for each finite collection.

## 3. The scaled Dirichlet limit

Change the leader coordinate in (6) to \(z=r^{1/3}(-x-r)\), subtract \(\ell(r^2/4-1/2)\), and divide by \(\ell r^{2/3}\). The kinetic coefficient is one. The effective potential becomes
\[
W_A(z)=\frac z2+\frac{z^2}{4r^{4/3}}
      +\frac{A}{\ell r^{2/3}}b(-R-kr^{-1/3}z).
\tag{7}
\]
It is at least \(z/2\) for \(z\geq0\). On \([-\epsilon,0]\) it is at least \(-\epsilon/2\). For each fixed \(\epsilon>0\), its infimum on \((-\infty,-\epsilon]\) tends to \(+\infty\). For the latter claim, the quadratic part is bounded below by \(-r^{4/3}/4\). By (4) and monotonicity of \(\Phi\), the last term is at least
\[
\frac{A}{\ell r^{2/3}}\Phi(-R+kr^{-1/3}\epsilon),
\]
which dominates every power of \(r\) by the Gaussian lower tail estimate. The exponent in that lower bound gains \(Rkr^{-1/3}\epsilon=k^2r^{2/3}\epsilon\) over \(A e^{-R^2/2}=1\).

For the upper bound take a normalized smooth compactly supported test \(h(z)\) on the positive half-line, with support in \([\epsilon,L]\). Use the product test above with \(x_0=-r-r^{-1/3}\epsilon\). By (5) the standardized follower cost divided by \(\ell r^{2/3}\) tends to zero, since its exponent loses \(k^2r^{2/3}\epsilon\). The leader part converges to \(\int_0^\infty (|h'|^2+z|h|^2/2)\,dz\). Density of these tests gives the lowest Dirichlet energy on the positive half-line as an upper bound on the limit.

For the lower bound choose near minimizers in (6) along a sequence with bounded scaled energy. Such a bound is ensured by the product tests and the direction of (6). On the scaled line, \(W_A\ge -1/2\) for all sufficiently large \(A\), using the bound outside \([-1,0]\). Accordingly the derivatives are uniformly square integrable. The positive tail has uniformly bounded first moment from \(W_A\ge z/2\) there. For each \(\epsilon>0\) the mass below \(-\epsilon\) tends to zero by the diverging lower bound from (7) and the common lower bound elsewhere. Local compactness of \(H^1\) and these tail bounds give a subsequence converging strongly in \(L^2\) to a normalized \(H^1(\mathbb R)\) function supported on \([0,\infty)\). It has zero trace at zero. The kinetic term is weakly lower semicontinuous and the positive-side potential is bounded below by \(z/2\), so it passes to the limit from below by Fatou on a further almost-everywhere convergent subsequence. The contribution from the negative side is at least \(-\epsilon/2\) for large \(A\), with \(\epsilon>0\) arbitrary. Thus the lower limit of the scaled infima is at least the Dirichlet ground energy of \(-\partial_z^2+z/2\) on \((0,\infty)\).

Rescale \(z=2^{1/3}u\). For \(-\partial_u^2+u\), the decaying solution at energy \(\xi\) is proportional to \(\mathrm{Ai}(u-\xi)\). The zero boundary condition and positivity of the ground state give the first zero \(\xi_1\). The ground energy in the \(z\) variable is \(2^{-2/3}\xi_1\). The two bounds establish (1). All sequence choices and estimates depend on the collection through \(A\), proving the stated uniformity.

## 4. Real moments and open TASEP

Let \(X,Y\) be independent stationary unit-variance OU processes of speed \(1/2\). For each real \(q>0\), set
\[
\theta(q)=-\lim_{T\to\infty}T^{-1}\log
  \mathbb E_Y[\Pr_X\{X_t\ge Y_t\ (0\le t\le T)\mid Y\}^{q}].
\]
For a deterministic continuous path \(Y\), the two survival events on adjacent intervals are increasing path events of \(X\). The OU covariance is nonnegative, so Gaussian association gives a lower bound on their joint probability by the product of the two stationary marginal probabilities on the intervals. The assertion on continuous paths follows by approximation with nested finite dense grids. The two conditional probabilities, as functions of \(Y\), are decreasing. The same association after raising them to \(q\), and stationarity, now show that the real moment at \(T+S\) is at least the product of the moments at \(T\) and \(S\). Each moment is positive, since any continuous wall on a compact interval leaves an open tube above it with positive OU measure. The nonnegative finite negative logarithm is subadditive and nondecreasing in time, which yields the displayed limit by decomposition into equal blocks and one remainder. Because a conditional probability belongs to \([0,1]\), \(\theta(q)\) is nondecreasing in \(q\). For integer \(n\) the expectation is exactly the survival probability of \(n\) independent followers above the wall \(Y\). Formula (2) gives its two-term expansion. Squeezing \(\theta(q)\) between \(\theta(\lfloor q\rfloor)\) and \(\theta(\lceil q\rceil)\) gives
\[
\theta(q)=\frac14\log q+2^{-4/3}\xi_1(\log q)^{1/3}
                             +o((\log q)^{1/3}).
\tag{8}
\]

**Conditional consequence for TASEP.** Suppose the open TASEP with injection, exit and right-jump rates one has a fixed-order transfer of the form
\[
H_q(\pi_N)=N\log2-c(q)\log N+o_q(\log N),\qquad
c(q)=\frac{q-2\theta(q)}{q-1},\quad q>1.
\]
Under that transfer identity, (8) gives
\[
1-c(q)=\frac{\log q}{2q}
       +\frac{2^{-1/3}\xi_1(\log q)^{1/3}}q
       +o\big(q^{-1}(\log q)^{1/3}\big).
\tag{9}
\]
Here the limit in \(N\) defining the coefficient is taken before the limit in \(q\). The proof establishes the Ornstein–Uhlenbeck pressure expansion independently of this transfer identity. A uniform error in \(N\), a bounded fixed-order thermodynamic remainder, and joint limits in \(q,N\) remain outside its scope.

## 5. Ordered families with macroscopic populations

Let there be \(p\ge2\) fixed families. In family \(j\) take any finite nonempty collection of independent standardized stationary OU coordinates with speeds \(a_{ji}>0\). All coordinates in different families are independent too. The only inequalities are that every member of family \(j\) lies below every member of family \(j+1\), at every time. Write \(A_j=\sum_i a_{ji}\), \(S=\sum_j A_j\), \(w_j=A_j/S\), and \(h=\max_{ji} a_{ji}/S\). For an open interval \(I\) let \(b(I)\) be the lowest Dirichlet energy of the unit-speed OU generator on \(I\), with Gaussian weight. Endpoints \(\pm\infty\) are permitted. Define
\[
{\cal P}(w)=\inf_{-\infty=s_0 < s_1 < \cdots < s_{p-1} < s_p=\infty}
              \sum_{j=1}^{p}w_j b((s_{j-1},s_j)).
\]
In particular \(b((s,\infty))=b(s)\) in the notation of Section 2.

**Theorem 2.** Let \(\lambda_{\rm ord}\) be the stationary decay rate on this ordered chamber. For \(w_j\ge\delta>0\),
\[
0\le {\cal P}(w)-\lambda_{\rm ord}/S\le C_{p,\delta} h^{1/3}.
\tag{10}
\]
The constants are independent of all population sizes and of the individual speeds. Thus the moving-interface problem converges to a deterministic one-dimensional spectral partition whenever the largest speed is negligible relative to total speed. For two families of equal total speed \({\cal P}=1\). For \(N=2m\) equal Brownian walkers initially ordered by family, the survival power divided by \(N\) converges to \(1/2\), with absolute error on the power at most \(C N^{2/3}\).

*Proof.* Conjugation and the compact Dirichlet form argument of Section 2 apply unchanged to the finite system. A product of near-ground states on fixed disjoint intervals yields \(\lambda_{\rm ord}\le S{\cal P}(w)\). To prove the converse consider the \(p-1\) moving cuts \(B_j=\max_i x_{ji}\) on the chamber. Almost everywhere each has one derivative equal to one, in its own family, and all its other derivatives vanish. Fix mesh \(0 < e\le1\). Use a smooth real quadratic partition of unity \(\sum_k \chi_k^2=1\) on the line, supported in \((ek-e,ek+e)\), with \(\sum_k|\chi'_k|^2\le C/e^2\). One can normalize translated copies of a smooth bump positive on \([-2/3,2/3]\) after scaling to mesh \(e\). Localize by all products of the \(p-1\) functions \(\chi_{k_j}(B_j)\). The identity for the derivative of a product partition gives the sum of localized energies minus the squared-gradient error. The latter is at most \(C(p-1)Sh/e^2\) on a state of unit norm. Lipschitz cut functions preserve the form domain by approximation, and the squared partition is locally finite. For a compactly supported form test there are only finitely many nonzero terms.

On a piece with centers \(s_j=ek_j\), every coordinate of family \(j\) belongs to \(I_j^e=(s_{j-1}-e,s_j+e)\), using the infinite endpoints at the extremes. The localized function, extended by zero, is a Dirichlet form function on the product of these intervals. This follows first for chamber tests with support away from its boundary, since the bump vanishes at its support boundary, then by closure. By slicing coordinate by coordinate, its energy is at least \(S\sum_j w_j b(I_j^e)\) times its squared norm. Empty pieces contribute zero.

We give the uniform comparison of intervals needed here. Fixed separated cuts give an upper bound \(K_p\) on \({\cal P}\). Discard any pieces with relaxed energy per unit speed above \(K_p+1\) in taking a lower bound by \({\cal P}-O(e)\). On all other pieces each interval energy is at most \((K_p+1)/\delta\). The oscillator potential \(x^2/4-1/2\) bounds each finite cut in a compact set: a far positive cut forces the next entire interval far to the right, and a far negative cut forces the preceding interval far to the left. Every bounded interval has width bounded below by a positive constant, by its ordinary Dirichlet kinetic eigenvalue \(\pi^2/|I|^2\) and the potential floor \(-1/2\). Thus, for sufficiently small \(e=e(p,\delta)\) or smaller, the centers \(s_j\) are strictly ordered. On bounded intervals, affinely map each enlarged interval to its unrelaxed interval with the unitary \(L^2\) normalization. The kinetic integral changes by a factor \(1+O(e)\) and the potential by at most \(O(e)\) uniformly on this compact set. On extreme half-lines use translation by \(e\); the potential change in expectation is \(O(e)\), since normalized states with bounded energy have bounded second moment by the oscillator form. Applying these estimates to normalized near-minimizers proves \(\sum_j w_j b(I_j^e)\ge{\cal P}(w)-Ce\). Summing the localized inequalities and taking \(e=h^{1/3}\) gives (10) for small \(h\); the fixed upper bound and \(\lambda_{\rm ord}\ge0\) absorb the remaining range into \(C_{p,\delta}\).

For two equally weighted families the cut energy is \((b(s)+b(-s))/2\). The half-line energy \(b(s)\) is convex. Indeed on every finite time grid a stationary Gaussian path staying above the translated wall has probability log-concave in the wall height by the Prékopa marginal inequality. Passing along nested dense grids and using continuity yields the same inequality for closed-wall survival. A nondegenerate diffusion started from a hit crosses the wall immediately, and the endpoint law has no atoms, so strict survival has the same probability. Taking the large-time exponential rate proves convexity. Hence \(s=0\) minimizes the sum, with \(b(0)=1\) by the positive half-line Dirichlet OU eigenfunction \(x\). The Lamperti transformation gives speed \(1/2\) for standard Brownian walkers; for each finite \(N\) the endpoint-density argument of Section 1 applies to this connected chamber. The long-time exponent is taken first and then \(N\) grows. This proves all assertions. \(\square\)

## 6. A dilute family of arbitrary cardinality

Now take two families, in standard coordinates \(x_i,y_j\), and impose \(y_j>k x_i\) for all pairs with fixed \(k>0\). Write \(L=\sum_i l_i\), \(A=\sum_j a_j\) for the left and right total speeds. Both sizes and all speeds may vary. No condition on their maxima or minima is needed.

**Theorem 3.** Put \(u=A/L\) and \(r=\sqrt{2\log u}/k\). Uniformly over all such collections as \(u\to\infty\),
\[
\frac{\lambda_{\rm ord}}{L}
=\frac{r^2}{4}+2^{-2/3}\xi_1 r^{2/3}+o(r^{2/3}).
\tag{11}
\]
In particular an arbitrarily large minority family has the same per-speed Airy law as a single leader at the *ratio* of group speeds. Equations (10) and (11) treat different population regimes.

*Proof.* On each left configuration \(x\), the right-hand fibre costs at least \(A b(k\max_i x_i)\). Monotonicity gives
\[
A b(k\max_i x_i)\ \ge\ \sum_i l_i\,u b(kx_i).
\]
Take the \(L^2\)-norm of the full wavefunction over all right coordinates as a function of \(x\). The contraction for each weak derivative used in (6) bounds its left kinetic energy. After adding the left oscillator potential, the resulting lower bound separates over left coordinates. Slicing gives \(\lambda_{\rm ord}/L\ge E(u)\), where \(E(u)\) is the one-body bottom of \(-\partial_x^2+x^2/4-1/2+u b(kx)\) on the line. An upper bound per unit \(L\) comes from putting every left coordinate below the same cut \(x_0\) and every right coordinate above \(k x_0\), with identical left trial functions and identical right trial functions on their respective half-lines. It is \(b(-x_0)+u b(kx_0)\). Both bounds are independent of the allocations of either total speed. The liminf argument (7) with \(\ell=1\), \(A=u\) gives the claimed Airy lower term for \(E(u)\). The compactly supported positive-side scaled tests of Section 3, used for every left coordinate, give the matching upper term and complete the proof. \(\square\)

## 7. Relation to previous results

Cardy and Katori introduced vicious-walker families whose distinct species cannot meet and studied an expansion about spatial dimension two. Theorems 2 and 3 concern a fixed one-dimensional ordered sector, with the long-time decay rate defined at every finite size before either population limit. Li and Shao proved the logarithmic leading constant for one Brownian leader. Ben-Naim and Krapivsky derived an Airy correction for the high-dimensional circular-cone scaling function. Inserting the ordering-cone angular volume predicts the same coefficient in the equal-speed one-leader model; a matching two-sided estimate on the ordered domain is still required for that conclusion. Molchan obtained logarithmic asymptotics for stationary Gaussian pursuit under other joint-time and population hypotheses. The many-family partition and the distinction between a finite group ratio and a dilute group use the partial ordering of the original coordinates. The balanced forcing result applies to independent OU coordinates and uniformly comparable group totals. It does not give the exact finite-population eigenvalue or the optimal remainder in (10). For the TASEP application in Section 4 the real-order transfer is an explicit hypothesis.

## References

- H. Kesten, *An absorption problem for several Brownian motions*, Progress in Probability 29, 59–72 (1992). <https://depts.washington.edu/ssproc/ssp_proceed.php>
- W. V. Li and Q.-M. Shao, *A normal comparison inequality and its applications*, Probability Theory and Related Fields 122, 494–508 (2002), Section 3. <https://doi.org/10.1007/s004400100176>
- D. ben-Avraham, B. M. Johnson, C. A. Monaco, P. L. Krapivsky and S. Redner, *Ordering of random walks: the leader and the laggard*, Journal of Physics A 36, 1789–1799 (2003). <https://doi.org/10.1088/0305-4470/36/7/301>
- E. Ben-Naim and P. L. Krapivsky, *First passage in conical geometry and ordering of Brownian particles*, Sections 4–6, especially (42)–(43). <https://arxiv.org/abs/1306.2990>

- L. D. Pitt, *Positively correlated normal variables are associated*, Annals of Probability 10, 496–499 (1982). <https://doi.org/10.1214/aop/1176993872>

- J. Cardy and M. Katori, *Families of vicious walkers*, Journal of Physics A 36 (2003). <https://arxiv.org/abs/cond-mat/0208228>
- E. Ben-Naim and P. L. Krapivsky, *Kinetics of first passage in a cone*, Journal of Physics A 43 (2010), 495007, Eq. (24). <https://doi.org/10.1088/1751-8113/43/49/495007>
- G. Molchan, *Leadership exponent in the pursuit problem for 1-D random particles*, Journal of Statistical Physics (2020). <https://doi.org/10.1007/s10955-020-02614-z>
- A. Prékopa, *On logarithmic concave measures and functions*, Acta Scientiarum Mathematicarum 34 (1973), 335–343.
