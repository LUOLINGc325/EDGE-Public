# Pointwise minimax rates for sampled birth–death trees under vanishing intervention contrast

## Abstract

We study two labelled birth–death populations with shared unknown age-dependent birth and death rates. The populations differ by known birth multipliers with difference \(d_N\). Observations are \(N\) independent fixed-horizon reconstructed trees conditional on nonempty terminal sampling. For noninteger Hölder smoothness \(\beta > 0\), the minimax expected absolute error for the death rate at an interior age is of order \((1\vee Nd_N^2)^{-\beta/(2\beta+5)}\). The birth-rate error is of order the maximum of \(N^{-\beta/(2\beta+1)}\) and \((1\vee Nd_N^2)^{-(\beta+1)/(2\beta+5)}\). The bounds are uniform as the known contrast vanishes and hold with unknown sampling fractions bounded away from zero. An empirical split-age coordinate makes the normalized first and second derivatives of the arm-label regression estimable at the required rates. The matching full-tree lower bounds use exact perturbations that preserve one arm and change the other by a localized log-hazard of size proportional to \(d_N\). Thus the first split age and label attain the complete-tree minimax orders, and consistency for either rate requires \(Nd_N^2\) to diverge.

## 1. Experiment and result

Fix \(T > 0\) and \(t_* \in (0,T)\). We measure age \(t\) backwards from a common terminal observation time. In arm \(j\in\{1,2\}\), each individual has birth rate \(a_j\lambda(t)\) and death rate \(b\mu(t)\), with \(b > 0\) fixed. A birth replaces a lineage by two. At age zero, each terminal individual is sampled independently with probability \(\rho_j\). The constants \(a_j\) are known, lie in a fixed interval \([a_-,a_+]\subset(0,\infty)\), and may depend on \(N\). Set \(d=|a_1-a_2|\). The sampling fractions lie in \([\rho_-,1]\) for fixed \(\rho_->0\).

Each observation first chooses its arm with probability \(1/2\) and then draws a tree from that arm's law conditional on at least one sampled terminal descendant of the stem lineage at age \(T\). The observation consists of the arm label and the complete reconstructed tree connecting this stem to its sampled tips. The data include trees with one tip and no visible split, and the number of tips is random. The design uses a budget of retained trees. Discarded empty trials and their counts are absent.

Write \(\beta=k+\gamma\) with \(k\ge 0\) integer and \(0 < \gamma < 1\). Use the \(C^\beta[0,T]\) norm given by the sum of supremum norms of derivatives through order \(k\) and the \(\gamma\)-Hölder seminorm of the order-\(k\) derivative. Both \(\lambda,\mu\) belong to a common class
\[
\mathcal C=\{ f\in C^\beta[0,T]\colon \ell\le f(t)\le M,\ \|f\|_{C^\beta}\le L\}
\]
with \(0 < \ell < M < \infty\). Assume the rate class contains a constant pair with strict slack in these inequalities. Let \(R_{f,N}\) for \(f\in\{\lambda,\mu\}\) be the infimum over estimators based on the \(N\) complete labelled trees of the maximum \(\mathbb E|\widehat f-f(t_*)|\) over the rates and the permitted sampling fractions.

**Theorem 1.** Set \(v_N=1\vee Nd^2\). For all \(N\ge 1\),
\[
R_{\mu,N}\asymp v_N^{-\beta/(2\beta+5)},\qquad
R_{\lambda,N}\asymp \max\left\{N^{-\beta/(2\beta+1)},\, v_N^{-(\beta+1)/(2\beta+5)}\right\}.
\tag{1}
\]
The two-sided constants depend only on the fixed class, its slack pair, \(\beta\), \(T,t_*,b,a_-,a_+,\rho_-\). The result holds both for fixed known sampling fractions and for unknown fractions in \([\rho_-,1]\), with the same uniformity. A single pair of estimators based on the label and oldest split of each tree, including the indicator of no split, achieves the two bounds. Along a sequence of designs, the minimax risk of either rate converges to zero precisely when \(Nd^2\longrightarrow\infty\). At \(d=0\) there are distinct rates giving the same complete labelled tree law even with fixed known sampling fractions.

For example, if \(d\asymp N^{-\kappa}\) with \(0\le\kappa < 1/2\), the birth-rate exponent is the smaller of \(\beta/(2\beta+1)\) and \((1-2\kappa)(\beta+1)/(2\beta+5)\). For \(\beta < 1/2\), the direct density term controls the order through \(\kappa=(1-2\beta)/(2(\beta+1)(2\beta+1))\), where the two terms tie. For \(\beta>1/2\) the contrast term controls the order already at fixed positive contrast.

## 2. Conditional tree likelihood

The probability \(s_j(t)\) that a lineage at age \(t\) has a sampled terminal descendant satisfies
\[
s_j'=(a_j\lambda-b\mu)s_j-a_j\lambda s_j^2,\qquad s_j(0)=\rho_j.
\tag{2}
\]
This follows by expanding over birth, death, and no event in one short time step. The interval \([0,1]\) is invariant for (2), and
\[
s_j(t)\ge \rho_- e^{-bMT}.
\tag{3}
\]
Indeed, the logarithmic derivative of the positive solution is \(a_j\lambda(1-s_j)-b\mu\ge -bM\). Define the pulled birth curve \(p_j=a_j\lambda s_j\). Thus for \(p_-=a_-\ell\rho_- e^{-bMT}\) and \(p_+=a_+M\), every \(p_j\) lies in \([p_-,p_+]\). Equation (2) also gives uniform \(C^{\beta+1}\) bounds for \(s_j\) and \(C^\beta\) bounds for \(p_j\) by differentiation and the Hölder product estimate.

A reconstructed lineage is a lineage with at least one sampled descendant. At age \(t\) a split with both children reconstructed has unconditional probability \(a_j\lambda(t)s_j(t)^2\,du+o(du)\) for a forward increment \(du\). Conditional on the parent being reconstructed, this gives hazard \(p_j(t)\,du+o(du)\). The surviving subtrees are independent given the corresponding survival events, by independence of the descendant processes and sampling. Consequently the reconstructed tree in arm \(j\) is a time-inhomogeneous pure-birth tree, started with one lineage, with per-lineage birth hazard \(p_j(t)\) at age \(t\). A birth that leaves only one reconstructed child gives a continuation of the same observed lineage. The bounds on \(p_j\) give nonexplosion over \([0,T]\) by domination by a constant-rate pure-birth process.

For a positive curve \(p\) in the stated bounds, consider the law \(P_p\) of the pure-birth tree with an optional ordering of the children. Let \(t_v\) be the split ages and let \(L_{\mathcal T}(t)\) be the number of reconstructed lineages at age \(t\). Use Lebesgue measure on the ordered split ages and counting measure on the successive choices of the splitting lineage, including a singleton for no split. Conditional on the preceding history, a split has total hazard \(L_{\mathcal T}(t)p(t)\) and chooses each lineage with probability \(1/L_{\mathcal T}(t)\). The density, up to any parameter-independent child-order factors, is
\[
\mathcal L_p(\mathcal T)=
\left(\prod_v p(t_v)\right)
\exp\left[-\int_0^T L_{\mathcal T}(t)p(t)\,dt\right].
\tag{4}
\]
For no split it equals \(\exp(-\int_0^T p(t)\,dt)\). The conditioning on nonempty sampling has already entered (4) through \(s_j\) and the reconstructed-process law.

The mean reconstructed lineage count at age \(t\) is \(\mathbb E_p L_{\mathcal T}(t)=\exp(\int_t^T p(u)\,du)\), by the pure-birth mean equation. The split intensity also gives
\(\mathbb E_p\sum_v F(t_v)=\int_0^T\mathbb E_p[L_{\mathcal T}(t)]p(t)F(t)\,dt\)
for bounded measurable \(F\). Taking the expectation of the log likelihood ratio from (4) yields
\[
\operatorname{KL}(P_p\Vert P_q)=
\int_0^T e^{\int_t^T p(u)\,du}
\left[p(t)\log\frac{p(t)}{q(t)}-p(t)+q(t)\right]dt
\le \frac{e^{Tp_+}}{2p_-}\|p-q\|_2^2.
\tag{5}
\]
The inequality uses Taylor's theorem in the first argument, with second derivative \(1/p(t)\). Forgetting the optional child order preserves the upper bound by data processing. The label has the same probability in both models, so the one-observation divergence is the average of the two arm divergences, and independence multiplies that average by \(N\). This bound controls the experiment with all node times, topology and tip counts.

## 3. Estimating the two rates from the first split

Assume \(d>0\) and label the larger birth multiplier \(a_1\). Let \(R\) indicate the presence of a split and \(X\) be the oldest split age when \(R=1\). The subdensity of \(X\) in arm \(j\) is \(\xi_j=p_jH_j\) with
\[
H_j(t)=\exp\left[-\int_t^Tp_j(v)\,dv\right],\qquad
u_j=a_js_jH_j,\qquad \xi_j=\lambda u_j .
\tag{6}
\]
The derivative of \(\log H_j\) is \(p_j\), so (2) gives \((\log u_j)'=a_j\lambda-b\mu\). Both \(u_j\) have uniform positive bounds and uniform \(C^{\beta+1}\) norms. Define
\[
g(t)=\frac{\xi_1(t)+\xi_2(t)}2,\qquad z(t)=\int_0^t g(r)\,dr,\qquad
q(z(t))=\frac{u_1(t)}{u_1(t)+u_2(t)}.
\tag{7}
\]
The conditional probability of arm 1 given a split at age \(t\) is \(q(z(t))\). The observations with \(R=1\), transformed by \(z\), have unit subdensity on \([0,z(T)]\). The bounds in (3)–(6) give uniform positive bounds on \(g\) and on both \(q\) and \(1-q\). The inverse of \(z\) on its range has a uniform \(C^{\beta+1}\) bound, by differentiating its derivative \(1/(g\circ z^{-1})\) and using the fixed positive lower bound on \(g\). Derivatives of \(q\) are taken in the \(z\)-coordinate. The log odds in (7) give
\[
v(z(t)):=\frac{q'(z(t))}{d}
=\frac{2q(z(t))(1-q(z(t)))}{u_1(t)+u_2(t)},\qquad
w(z(t)):=v'(z(t))=\frac{q''(z(t))}{d}.
\tag{8}
\]
The function \(v\) has uniform positive bounds and a uniform \(C^{\beta+1}\) norm by (8). In particular, \(w\) has a uniform \(C^\beta\) norm. Integrating \(q'=dv\) gives the \(C^{\beta+2}\) bound on every anchored difference \(q-q(z_*)\) with an explicit factor \(d\), where \(z_*=z(t_*)\).

In (8), \(u_1=2q^2(1-q)/v\) at the corresponding age. Differentiating its logarithm in \(t\) and using \((\log u_1)'=a_1\lambda-b\mu\) gives the pointwise inverse
\[
\lambda=\frac{gv}{q(1-q)},\qquad
\mu=\frac1b\left(a_1\lambda-g\left[d\left(\frac{2v}{q}-\frac{v}{1-q}\right)-\frac{w}{v}\right]\right).
\tag{9}
\]
Here \(g\) is evaluated at \(t_*\), and \(q,v,w\) at \(z_*\). The first formula is uniformly Lipschitz in \((g,q,v)\) on fixed class-enclosing intervals. The second is uniformly Lipschitz in \((g,q,v,w)\). The clipping intervals for estimates can be fixed from the class bounds, independently of \(d\), and keep both denominators bounded away from zero.

Use three independent groups of sizes comparable to \(N\) when \(N\ge 6\). For the first group take \(\widehat z(t)\) to be the empirical proportion with \(R=1\) and \(X\le t\). This is the ordinary empirical CDF up to age \(T\) upon coding no split as a point at \(T+1\). With \(e=\|\widehat z-z\|_\infty\) on \([0,T]\), the empirical CDF inequality gives \(\mathbb E e\le CN^{-1/2}\) and \(\Pr(e>c_0 h)\le 2e^{-cNh^2}\) for every fixed \(c_0>0\) and each bandwidth \(h>0\). [Massart](https://doi.org/10.1214/aop/1176990746)

In the second group with size \(m\), put \(U_i=(z(X_i)-z_*)/h\), \(\widehat U_i=(\widehat z(X_i)-\widehat z(t_*))/h\), and \(W_i=R_i\,\mathbf 1_{\{|\widehat U_i|\le 1\}}\), with both coordinates set to zero if \(R_i=0\). Use degree \(r=\lfloor\beta+2\rfloor\) and the monomial vector \(V(u)=(1,u,\ldots,u^r)^\top\). Let
\[
\widehat S=\frac1{mh}\sum_i W_iV(\widehat U_i)V(\widehat U_i)^\top,\qquad
S_*=\int_{-1}^1 V(u)V(u)^\top\,du.
\tag{10}
\]
The expectation conditioned on a pilot with \(e\le c_0h\) differs from \(S_*\) by at most \(Ce/h\) in operator norm. In fact, \(|\widehat U_i-U_i|\le 2e/h\) for splits. The two window indicators differ only in edge bands of total width \(O(e)\) in the true \(z\)-coordinate. Elsewhere the monomials vary by \(O(e/h)\) on the bounded window, which has probability \(O(h)\) under the unit subdensity. We choose \(h\) up to a fixed positive constant such that the window and the edge bands lie inside \([0,z(T)]\) on a good pilot. This is possible uniformly since \(t_*\) is interior and \(g\) is bounded below.

Every unnormalized summand in (10) has bounded entries and entry variances \(O(h)\) under this pilot condition. Bernstein's inequality for each entry, followed by the fixed-dimensional matrix norm bound, gives
\[
\Pr\left(\|\widehat S-S_*\|>\tfrac12\lambda_{\min}(S_*)\mid\widehat z\right)
\le C e^{-cNh}
\quad\text{if } e\le c_0 h
\tag{11}
\]
for sufficiently small fixed \(c_0\). The matrix \(S_*\) is positive definite because a nonzero polynomial cannot vanish on the entire interval. Regress the arm-1 indicator on the monomials with weights \(W_i\) when the observed matrix passes the criterion in (11). On failure use fixed bounded defaults. Scale the fitted coefficient of index \(j\) by \(j!/(dh^j)\) for \(j=1,2\) and take the fitted intercept for \(q\). Clip each estimate to its class-enclosing interval.

To bound the fit, the true Taylor coefficients in the coordinate \(U_i\) are \(\theta_j=q^{(j)}(z_*)h^j/j!\). For \(j\ge 1\), \(|\theta_j|\le Cdh^j\) by (8). The Taylor remainder is \(O(dh^{\beta+2})\) on the observed window under the good pilot. Replacing \(U_i\) by \(\widehat U_i\) changes the Taylor polynomial by at most \(Cde\) there. Conditional on the pilot and the split indicators and ages of the second group, the responses for its splits are independent Bernoulli variables with means \(q(z(X_i))\). The coefficient covariance is bounded by \(\widehat S^{-1}/(4mh)\). The conditional bias vector is bounded by \(C(dh^{\beta+2}+de)\) since \(\widehat S\) and its inverse have fixed norm bounds on the matrix event. Taking expectations, dividing by \(dh^j/j!\), and using bounded clipped error on the exceptional events gives, for \(j=1,2\),
\[
\mathbb E\left|\widehat{q^{(j)}/d}-q^{(j)}(z_*)/d\right|
\le C\left[h^{\beta+2-j}+(Nd^2h^{2j+1})^{-1/2}
             +N^{-1/2}h^{-j}+e^{-cNh^2}\right].
\tag{12}
\]
We use \(h\le 1\), so the probability in (11) is included in the final term. The intercept bound is \(C[dh^{\beta+2}+(Nh)^{-1/2}+dN^{-1/2}+e^{-cNh^2}]\). Clipping never increases the error to a true coordinate inside its interval.

Using the third group, estimate \(g(t_*)\) by a bounded kernel of support \([-1,1]\), integral one and vanishing moments through degree \(k=\lfloor\beta\rfloor\), with bandwidth \(h_g\). The summand is set to zero on no split. Such a kernel is a polynomial times the interval indicator, obtained by solving the invertible moment system of monomial integrals. Taylor bias and the bounded \(g\) on the interior window give absolute error at most \(C[h_g^\beta+(Nh_g)^{-1/2}]\) after clipping.

For \(Nd^2>1\) and \(N\ge 6\), take \(h=h_0(Nd^2)^{-1/(2\beta+5)}\) for sufficiently small fixed \(h_0>0\). In (12), the pilot term is at most a fixed multiple of the sampling term because their ratio is \(d\sqrt h\). Since \(d\) is bounded above, the exponential term is bounded by the rate powers. The estimates of \(q,v,w\) therefore have errors bounded by respective constants times
\[
(Nd^2)^{-(\beta+2)/(2\beta+5)},\quad
(Nd^2)^{-(\beta+1)/(2\beta+5)},\quad
(Nd^2)^{-\beta/(2\beta+5)} .
\]
Set \(h_g=h_1N^{-1/(2\beta+1)}\) with fixed small \(h_1>0\). The resulting \(g\)-error is \(O(N^{-\beta/(2\beta+1)})\), which is also bounded by \(C(Nd^2)^{-\beta/(2\beta+5)}\). Substitution in (9) proves both upper bounds with the same fitted \(g,q,v,w\). When \(Nd^2\le 1\) or \(N < 6\), fixed bounded estimates suffice, since the right sides of (1) are bounded below by positive class constants.

## 4. Matching lower bounds in complete trees

Fix any admissible sampling fractions and a constant slack pair \((\lambda_0,\mu_0)\). Denote the corresponding curves by \(p_{j,0}\). Relabel for this proof so \(a_2-a_1=d\ge 0\). In the smooth submodels used below, the forward equation for the pulled curves is
\[
(\log p_j)'=(\log\lambda)'+a_j\lambda-b\mu-p_j,\qquad
p_j(0)=a_j\rho_j\lambda(0).
\tag{13}
\]
Together with the initial condition it uniquely determines the positive pulled curve at smooth positive rates, since after setting \(s_j=p_j/(a_j\lambda)\) it is (2).

Let \(\phi\) be smooth with compact support in \((-1,1)\). For small fixed \(\epsilon>0\) and \(0 < h\le h_0\), write
\[
U_h(t)=\epsilon h^{\beta+2}\phi((t-t_*)/h),\qquad E_h=dU_h,\qquad
D_h=U_h'+p_{2,0}U_h\int_0^1 e^{rE_h}\,dr.
\tag{14}
\]
Choose \(h_0\le 1\) so this bump is away from both endpoints. Define
\[
\lambda_h=\lambda_0+D_h,\qquad
\mu_h=\mu_0+\frac1b\left(\frac{D_h'}{\lambda_0+D_h}+a_1D_h\right).
\tag{15}
\]
Standard differentiation of rescaled bumps gives \(\|U_h\|_{C^\beta}\le C\epsilon h^2\), \(\|U_h'\|_{C^\beta}\le C\epsilon h\) and \(\|U_h''\|_{C^\beta}\le C\epsilon\). The fixed bounds on \(d\) and the smooth constant-rate baselines give \(\|D_h\|_{C^\beta}\le C\epsilon h\) and \(\|D_h'\|_{C^\beta}\le C\epsilon\) uniformly. In (15), the denominator stays positive and its reciprocal has a uniform norm for sufficiently small \(\epsilon\). Thus the slack makes the alternatives admissible, with a common \(\epsilon\) independent of \(h,N,d,\rho_j\).

The identity \(dD_h=E_h'+p_{2,0}(e^{E_h}-1)\) holds even when \(d=0\). Substitution in (13) shows that \(p_{1,h}=p_{1,0}\) satisfies the arm-1 equation after compensation. In the arm-2 equation the change on the right for \(p_{2,h}=p_{2,0}e^{E_h}\) is \(dD_h-p_{2,0}(e^{E_h}-1)=E_h'\), equal to the change on the left. Both curves have their original initial values because the perturbations vanish near zero. By uniqueness these are the actual forward curves:
\[
p_{1,h}=p_{1,0},\qquad p_{2,h}=p_{2,0}e^{E_h}.
\tag{16}
\]
At \(d=0\), both complete tree laws are unchanged. More generally, (5) and \(\|p_{2,h}-p_{2,0}\|_2^2\le C\|E_h\|_2^2\) bound the divergence of the complete labelled \(N\)-tree experiments by \(CNd^2\epsilon^2 h^{2\beta+5}\).

For the birth lower bound choose \(\phi(0)=0\), \(\phi'(0)=1\), giving \(\lambda_h(t_*)-\lambda_0=\epsilon h^{\beta+1}\). For the death lower bound use \(\phi(0)=\phi'(0)=0\), \(\phi''(0)=1\). At \(t_*\) this makes \(D_h=0\) and \(D_h'=\epsilon h^\beta\), giving \(\mu_h(t_*)-\mu_0=\epsilon h^\beta/(b\lambda_0)\). With \(h=h_0v_N^{-1/(2\beta+5)}\), a sufficiently small fixed \(\epsilon\) makes the divergence at most \(1/8\). By Pinsker's inequality the total variation is then at most \(1/4\). For any two target values separated by \(\Delta\), thresholding an estimator at the midpoint gives maximum expected absolute error at least \((\Delta/4)(1-\mathrm{TV})\). This yields the contrast terms of (1).

A separate submodel gives the direct birth term. Keep \(\mu=\mu_0\) and set \(\lambda_h=\lambda_0+\epsilon h^\beta\psi((t-t_*)/h)\), where \(\psi\) is smooth, supported in \((-1,1)\) and \(\psi(0)=1\). Small fixed \(\epsilon\) makes this perturbation admissible. Equation (2) and Grönwall's inequality give \(\|s_{j,h}-s_{j,0}\|_\infty\le C\epsilon h^{\beta+1}\), since the change of the vector field is \(O(\epsilon h^\beta)\) on a set of length \(2h\). The resulting \(L^2\) squared change in \(p_j=a_j\lambda s_j\) is \(O(\epsilon^2 h^{2\beta+1})\). This follows by separating the direct supported birth perturbation from the \(O(\epsilon h^{\beta+1})\) change through \(s_j\) on \([0,T]\). With \(h=h_0N^{-1/(2\beta+1)}\), (5) and the two-point bound yield \(R_{\lambda,N}\ge cN^{-\beta/(2\beta+1)}\). Taking the maximum completes (1).

## 5. Relation to prior work

Louca and Pennell establish observational equivalence across distinct diversification histories in one environment. Their pulled-rate representation underlies the forward model here. Legried and Terhorst's identifiable class restricts the trajectories to piecewise constant rates, and their subsequent work studies piecewise polynomial identifiability and testing based on a single tree with a fixed tip count. The present experiment uses unrestricted Hölder trajectories shared across two interventions, labelled independent retained trees and a joint sample-size and contrast limit. [Louca–Pennell](https://doi.org/10.1038/s41586-020-2176-1) [Legried–Terhorst, 2022](https://doi.org/10.1073/pnas.2119513119) [Legried–Terhorst, 2023](https://doi.org/10.1016/j.jtbi.2023.111520)

Warped random-design regression supplies the general idea of using a cumulative coordinate. The cancellation in (8) gives its statistical role here: it preserves the weak-contrast scale in the higher derivatives supplying the inverse. Doumic and coauthors study minimax nonparametric estimation of a size-dependent division mechanism using a genealogical growth-fragmentation observation model. Their genealogical data and inverse differ from independent survival-conditioned trees with a common unknown death function. The sharp fixed-contrast rates follow from (1) with \(d\) held fixed. The uniform minimax transition uses the contrast both in the regression signal size and in the full-tree likelihood of the compensated alternatives. [Kerkyacharian–Picard](https://doi.org/10.3150/bj/1106314850) [Doumic et al.](https://doi.org/10.3150/14-BEJ623)

The result concerns a fixed known horizon and known constant intervention multipliers. Uniformity requires positive lower bounds on rates and sampling fractions. Pointwise risk in the experiment defined in Section 1 permits random numbers of tips and balances arms within the retained budget. Estimation with raw-trial failure data, an unbalanced retention-induced arm mixture, or a fixed tip count has a different likelihood.
