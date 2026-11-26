# Sharp constellation size for stretched-exponential accuracy on the amplitude-constrained Gaussian channel

## Abstract

For the scalar Gaussian channel with unit noise variance and input constraint \(|X|\le A\), let \(K_\epsilon(A)\) be the smallest support size of an input whose mutual information falls within \(\epsilon\) of capacity. For every fixed \(0<\tau<2/3\), we prove
\[
K_\epsilon(A)\sim \frac{A}{\pi}\sqrt{\log(1/\epsilon)}
\]
in the joint limit \(A\to\infty\), \(\epsilon\to0\), \(\log(1/\epsilon)=O(A^\tau)\). The minimum discrete input entropy, allowing countably many atoms, equals the logarithm of this expression up to \(o(1)\). For the exact optimizer this gives a support growth exponent of at least \(4/3\), the exponent predicted by a continuum calculation of Abbott and Machta. The proof quantitatively localizes the normalized optimal output near the two amplitude boundaries. A polynomial approximation of a Gaussian convolution on intervals of length \(O(\sqrt m)\) controls derivatives of order up to \(m\) without a degree-dependent prefactor. This estimate permits a cutoff comparison on many adjacent windows, yielding a stretched-exponential localization bound for every exponent below \(2/3\).

Appendices A and B treat the wrapped Gaussian channel. They give a direct large-effective-noise proof and derive the all-noise comparison from established theorems of periodic quadrature and spherical energy.

## Reading guide

For a Gaussian channel with a bounded input amplitude, a constellation is a finite set of input points together with their probabilities. A target gap from capacity sets how accurately this finite input must reproduce the optimal output law. The main theorem counts the fewest points needed when the amplitude grows and the target gap shrinks in the stated joint regime.

The proof separates the interior of the amplitude interval from the two edges. It first bounds the interior deviations of the optimal output density. It then uses those bounds to obtain a necessary number of points and constructs a positive constellation of the same leading size. The appendices describe the separate circle model and its relation to known periodic quadrature.

## 1. Results

All logarithms are natural. Let \(\phi\) denote the standard Gaussian density and put
\[
p_P=\phi*P,\qquad I(P)=h(p_P)-h(\phi),\qquad
C(A)=\sup_{P([-A,A])=1}I(P).
\]
Define \(K_\epsilon(A)\) as in the abstract and let \(\mathsf H_\epsilon(A)\) be the infimum of \(H(Q)\) over finite or countable discrete inputs \(Q\) with \(I(Q)\ge C(A)-\epsilon\). Write \(S_k(Q)\) for the sum of the \(k\) largest weights and \(N_\alpha(Q)=\min\{k:S_k(Q)\ge\alpha\}\) for \(0<\alpha<1\). For finite supports take \(S_k(Q)=1\) past the support size.

**Theorem 1 (near-capacity input complexity).** Fix \(0<\tau<2/3\). Suppose \(A\to\infty\), \(\epsilon\to0\) and \(L=\log(1/\epsilon)=O(A^\tau)\), and put \(b_A=(A/\pi)\sqrt L\). Then
\[
 K_\epsilon(A)\sim b_A,\qquad
 \mathsf H_\epsilon(A)=\log b_A+o(1).
 \tag{1}
\]
For any sequence of admissible \(Q\) and \(k/b_A\to u\in[0,\infty)\),
\[
 \limsup S_k(Q)\le\min(1,u),\qquad
 \liminf N_\alpha(Q)/b_A\ge\alpha.
 \tag{2}
\]
If an admissible finite input has \(K/b_A\to r\in[1,\infty)\), its weight total variation from the uniform law on its own support has limit superior at most \(1-1/r\). All these constants are attainable.

**Corollary 2 (exact capacity).** Let \(P_A^*\) be a capacity-achieving input. Then
\[
 \liminf_{A\to\infty}\frac{\log |\operatorname{supp}P_A^*|}{\log A}\ge\frac43,\qquad
 \liminf_{A\to\infty}\frac{H(P_A^*)}{\log A}\ge\frac43,\qquad
 \liminf_{A\to\infty}\frac{\log N_\alpha(P_A^*)}{\log A}\ge\frac43
 \quad(0<\alpha<1).
 \tag{3}
\]
In particular every fixed power below \(4/3\) is a strict lower growth scale for exact optimal input cardinality. Smith's finite-support theorem supplies the discreteness of \(P_A^*\).

The analytic estimate behind Theorem 1 concerns the real output. Translate the interval to \(S=[0,\ell]\), \(\ell=2A\), put \(M_*=\exp h(p_{P_A^*})\), \(\mu_*=M_* P_A^*\) in these coordinates, and write \(f=\phi*\mu_*\).

**Theorem 3 (quantitative bulk localization).** For every \(0<\beta<2/3\) there are constants \(C_\beta,c_\beta>0\) such that, uniformly for \(\ell\ge2\) and \(1\le d\le\ell/2\),
\[
 E(d):=\int_d^{\ell-d}(f(y)-1)^2\,dy
 \le C_\beta e^{-c_\beta d^\beta}.
 \tag{4}
\]
More precisely, choose an integer \(p\ge1\) and real \(a>0\) such that
\[
 \beta<\frac{a}{1+a},\qquad a(1/2+1/p)<1.
 \tag{5}
\]
Let \(\kappa\) be the probability density proportional to \(\exp[-(1-t^2)^{-p}]\) for \(|t|<1\), and zero outside that interval. Write \(\kappa_R(t)=R^{-1}\kappa(t/R)\), and for \(R\) sufficiently large and \(0\lt R\le\ell/16\) define
\[
 \rho_R=\mathbf1_{[2R,\ell-2R]}*\kappa_R,\qquad
 \mu_R=(1-\rho_R)\mu_*+\rho_R\,dy,\qquad P_R=\mu_R/\mu_R(S).
\]
Their capacity loss is at most \(C_\beta A^{-1}e^{-c_\beta R^\beta}\). The law \(P_R\) has a uniform central component on \([3R,\ell-3R]\) of weight \(1-O(R/A)\).

The constants depend on the fixed exponent and cutoff. The boundary exponent \(2/3\), the accuracy \(\epsilon=e^{-A}\), and a matching upper bound at exact capacity remain open here.

## 2. Variational estimates

For each \(x\in S\) set \(i_*(x)=D(\phi(\cdot-x)\Vert p_{P_A^*})\). Compactness gives a maximizing input. Indeed for fixed \(S\), translated Gaussian upper and lower envelopes dominate \(|p_P\log p_P|\) by an integrable function uniformly over \(P\), and weak convergence gives pointwise convergence of \(p_P\). The first variation toward \(\delta_x\) gives \(i_*(x)\le C(A)\), with equality on \(\operatorname{supp}P_A^*\) since \(i_*\) is continuous and its \(P_A^*\)-average is \(C(A)\). Expanding cross entropies yields
\[
 C(A)-I(Q)=D(p_Q\Vert p_{P_A^*})+\int [C(A)-i_*(x)]\,dQ(x).
 \tag{6}
\]
In particular the capacity loss controls the output relative entropy.

We record bounds with constants independent of \(\ell\ge2\):
\[
 \ell\le M_*\le \ell+\sqrt{2\pi e},\qquad
 c\le f(y)\le C\ \ (y\in S),\qquad f(y)\le C\ \ (y\in\mathbb R).
 \tag{7}
\]
For the first lower bound use the uniform input and condition on the noise. For the upper bound let \(r(y)=y-\Pi_S(y)\) be the residual from projection onto \(S\). For \(x\in S\), \(r(y)^2\le r(y)(y-x)\). Gaussian integration by parts gives \(\mathbb E r(x+Z)^2\le\mathbb E r'(x+Z)=\Pr(x+Z\notin S)\) since \(r\) is Lipschitz and piecewise linear. A comparison density proportional to \(1\) on \(S\) and to \(e^{1/2}e^{-r(y)^2/2}\) outside has normalizer \(\ell+\sqrt{2\pi e}\), and its cross entropy with each \(\phi(\cdot-x)\) is at most the logarithm of that normalizer. This proves the upper bound.

For the global upper bound on \(f\), write \(P=P_A^*\), \(q=p_P\). For fixed \(y\) let \(R_y(dx)=\phi(y-x)P(dx)/q(y)\), let \(u_y=\phi*R_y\), and let \(\gamma_y=\phi(\cdot-y)\). The support equality gives \(\int u_y\log q=-h(q)\). Expanding three relative entropies gives
\[
 \tfrac12-h(q)-\log q(y)
 =D(u_y\Vert\gamma_y)+D(R_y\Vert P)-D(u_y\Vert q)\ge0,
\]
where the inequality uses data processing for Gaussian convolution. Thus \(f\le e^{1/2}\). It follows that \(\mu_*([u,u+1])\le e^{1/2}/\phi(1/2)\) for every real \(u\), by evaluating \(f\) at the midpoint. With \(g=\phi*\mathbf1_S\), the signed measure \(\zeta=\mu_*-\mathbf1_S\,dy\) also has uniformly bounded variation on every unit interval.

The KKT inequality reads \(\phi*\log f\ge0\) on \(S\), so \(\phi*f=\phi_{\sqrt2}*\mu_*\ge1\) there by Jensen. Here \(\phi_{\sqrt2}\) denotes the \(N(0,2)\) density. The unit-interval mass bound makes the contribution of points farther than a fixed \(R_0\) less than \(1/2\) uniformly. On the remaining points the ratio \(\phi/\phi_{\sqrt2}\) has positive minimum, proving the interior lower bound in (7). The same argument at both endpoints supplies a fixed positive amount of mass within \(R_0\) of each endpoint. In particular, both \(f\) and any replacement retaining these masses have the exterior lower bound
\[
 c_0 e^{-(\operatorname{dist}(y,S)+R_0)^2/2}.
 \tag{8}
\]
The unit-interval mass bound also gives \(f+g\le C\exp[-c\operatorname{dist}(y,S)^2]\) outside \(S\), by summing Gaussian tails over successive unit intervals.

Put \(F(v)=v\log v-v\) with \(F(0)=0\), and define
\(\mathcal F(q)=\int_{\mathbb R}(F(q)+\mathbf1_S)\).
For a positive finite measure \(\mu\) on \(S\) with mass \(M\) and normalized output \(p=\phi*\mu/M\), minimizing over the scalar \(M\) gives
\[
 \mathcal F(\phi*\mu)=\ell+M\log M-Mh(p)-M\ \ge\ \ell-e^{h(p)}
 \ \ge\ \ell-M_*=\mathcal F(f).
 \tag{9}
\]
The zero measure satisfies the same inequality. If \(\mathcal F(\phi*\mu)-\mathcal F(f)\le v\lt M_*\), then
\[
 h(p_{P_A^*})-h(p)\le-\log(1-v/M_*).
 \tag{10}
\]
On the fixed bounded range of \(f\), \(F(f)+1\ge c(f-1)^2\). The exterior tail estimate, \(|F(f)|\le C\sqrt f\) for bounded \(f\), and (9) show \(\int_S(f-1)^2\le C\). We also use
\[
 \int_t^{\ell-t}(g-1)^2\le C e^{-c t^2}
 \quad (0\le t\le\ell/2),
 \tag{11}
\]
which follows by integrating \(1-g(y)=\Phi(-y)+\Phi(y-\ell)\) and the Gaussian tail bound.

## 3. Derivatives of a Gaussian convolution on a local interval

Let \(u=f-g=\phi*\zeta\). The unit-interval variation bound implies that \(u\) extends to an entire function and
\[
 \sup_{y\in\mathbb R}|u(y+iv)|\le C e^{v^2/2}\qquad (v\in\mathbb R).
 \tag{12}
\]
This follows from \(|\phi(y+iv-x)|=e^{v^2/2}\phi(y-x)\) and summing interval masses against the Gaussian. The analytic extension also follows directly by integration over compact \(S\).

**Lemma 4 (local derivative estimates).** Let \(m\ge2\) be an integer and \(b=\delta\sqrt m\) with a fixed sufficiently small \(\delta>0\). For a union \(T\) of two intervals of length at most \(2w\), where \(w\ge b\), set \(T^+=T+[-2b,2b]\). Then for \(0\le j\le m\),
\[
 \|u^{(j)}\|_{L^2(T)}
 \le (C\sqrt m)^j C\left(\|u\|_{L^2(T^+)}+\sqrt w\,e^{-cm}\right).
 \tag{13}
\]
In particular the prefactor outside \((C\sqrt m)^j\) is independent of \(m\).

*Proof.* For any real center \(t\) take the degree-\(m\) Taylor polynomial \(P\) of \(u\) there. By (12), on the complex disk of radius \(\sqrt m\) about \(t\) the function is bounded by \(Ce^{m/2}\). Cauchy's coefficient bound makes the remainder on the disk of radius \(b\) at most
\(Ce^{m/2} \delta^{m+1}/(1-\delta)\le C e^{-c m}\).
On \([t-b/2,t+b/2]\) its \(j\)th derivative is bounded by \(Cj!(4/b)^j e^{-cm}\) by Cauchy's derivative formula, at radius \(b/4\). Since \(j\le m\), this is at most \(C(Cm/b)^j e^{-cm}\).

For any polynomial \(P\) of degree at most \(m\), the weighted Legendre derivative identity gives
\[
 \int_{-1}^1(1-x^2)^j |P^{(j)}(x)|^2dx
 \le \frac{(m+j)!}{(m-j)!}\int_{-1}^1 |P(x)|^2dx.
 \tag{14}
\]
To see this, use the Legendre basis \(P_k\) and its differential equation. Differentiating that equation \(j\) times yields
\(\big[(1-x^2)^{j+1}(P_k^{(j)})'\big]'
=-(k-j)(k+j+1)(1-x^2)^j P_k^{(j)}\).
Integration by parts shows that the inner product of two \((j+1)\)st derivatives with weight \((1-x^2)^{j+1}\) is the inner product at level \(j\) multiplied by \((k-j)(k+j+1)\), where \(k\) is the index of the differentiated polynomial after integration by parts. The undifferentiated polynomials are orthogonal, and terms with \(k\lt j\) vanish. Iteration gives the diagonal multiplier \((k+j)!/(k-j)!\), bounded by the factor in (14). Boundary terms are zero because the weights vanish there. On \([-1/2,1/2]\) the weight is at least \((3/4)^j\), and the factorial ratio is at most \((2m)^{2j}\).

Scale the polynomial estimate to \([t-b,t+b]\) and combine it with the two Taylor error bounds. This bounds the \(L^2\) derivative on \([t-b/2,t+b/2]\) by \((Cm/b)^j C(\|u\|_{L^2([t-b,t+b])}+\sqrt b\,e^{-cm})\). Cover each component of \(T\) by intervals of length \(b\) in a consecutive mesh. The corresponding enlarged intervals have bounded overlap and lie in \(T^+\). The number of intervals is \(O(w/b)\), so taking squared sums proves (13). \(\square\)

**Lemma 5 (cutoff and Fourier bounds).** For the fixed \(\kappa\) of Theorem 3, set \(s=1+1/p\). Then for all integers \(j\ge0\) and real \(\omega\),
\[
 \|\kappa^{(j)}\|_\infty\le D^{j+1}(j!)^s,\qquad
 |\widehat\kappa(\omega)|\le C e^{-c|\omega|^{1/s}},
 \tag{15}
\]
with constants depending on \(p\). If
\(\theta=1-\mathbf1_{[d+w,\ell-d-w]}*\kappa_w\)
with \(d+2w<\ell/2\), then its \(j\)th derivative for \(j\ge1\) is supported in \(T=[d,d+2w]\cup[\ell-d-2w,\ell-d]\) and satisfies
\[
 \|\theta^{(j)}\|_\infty\le D^{j+1}(j!)^s w^{-j}.
 \tag{16}
\]

*Proof.* For \(x\in(-1,1)\) and \(r=1-|x|\), take a complex disk of radius \(c_p r\) around \(x\). On this disk \(1-z^2\) differs from \(1-x^2\) by at most a fixed fraction depending on \(p\), so the real part of \((1-z^2)^{-p}\) is at least \(c'_p r^{-p}\). Cauchy's derivative estimate then gives \(j!(c_p r)^{-j}\exp[-c'_p r^{-p}]\) up to the normalization constant. Maximizing in \(r\) bounds this by \(D^{j+1}(j!)^{1+1/p}\), using \(j!\ge(j/e)^j\). For each fixed \(j\) the bound before maximizing tends to zero at either endpoint, justifying the smooth zero extension. Integrating by parts \(j\) times bounds the Fourier transform by \(2D^{j+1}(j!)^s|\omega|^{-j}\). Choosing \(j=\lfloor c_1|\omega|^{1/s}\rfloor\) with small fixed \(c_1>0\) proves (15) for large \(|\omega|\), and the bound \(|\widehat\kappa|\le1\) treats the remainder. The \(j\)th cutoff derivative is a difference of translated \((j-1)\)st derivatives of \(\kappa_w\), proving (16). \(\square\)

## 4. Iterating the cutoff comparison

Use \(\theta\) from Lemma 5 and assume \(d\ge w\) with \(w\) sufficiently large. Put \(\mu_{d,w}=\theta\mu_*+(1-\theta)\mathbf1_Sdy\), \(f_{d,w}=\phi*\mu_{d,w}\), and \(h_{d,w}=g+\theta u\). Their output difference is the commutator
\[
 e=f_{d,w}-h_{d,w}
 =\int \phi(y-x)[\theta(x)-\theta(y)]\,d\zeta(x).
 \tag{17}
\]
The first derivative bound and the unit-interval mass bound give \(\|e\|_\infty\le C/w\). Since \(h_{d,w}\) is bounded above and below by positive constants on \(S\) by (7) and the corresponding bound for \(g\), the same is true of \(f_{d,w}\) for large \(w\).

For any \(J\ge2\) expand \(\theta(x)-\theta(y)\) up to degree \(J-1\) in (17). The identity
\[
 \int e^{t(x-y)}\phi(y-x)\,d\zeta(x)=e^{t^2/2}u(y+t)
\]
gives
\[
 e=\sum_{j=1}^{J-1}\theta^{(j)}(y)
      \sum_{v=0}^{\lfloor j/2\rfloor}
       \frac{u^{(j-2v)}(y)}{2^v v!(j-2v)!}+r_J(y).
 \tag{18}
\]
The integral remainder has size bounds
\[
 \|r_J\|_\infty\le C\!\left(\frac{C J^{s-1/2}}w\right)^J,\qquad
 \|r_J\|_1\le Cw\!\left(\frac{C J^{s-1/2}}w\right)^J.
 \tag{19}
\]
Indeed the Taylor integral remainder gives \(\|\theta^{(J)}\|_\infty/J!\) times the \(J\)th absolute Gaussian moment against \(|\zeta|\). The latter is at most \(C(C\sqrt J)^J\) uniformly in the evaluation point, by taking the maximum of \(|z|^J e^{-z^2/4}\) and summing \(e^{-z^2/4}\) over unit intervals. For the \(L^1\) bound retain the derivative inside the Taylor integral and set \(z=x-y\). For each intermediate point \(x-\eta z\), \(0\le\eta\le1\), the translated derivative support intersects \(O(w)\) unit intervals in \(x\), giving the factor \(w\). The remaining integral in \(z\) is a Gaussian absolute moment. Using (16) and \(J!\le J^J\) gives (19). In particular \(\|r_J\|_2^2\le\|r_J\|_\infty\|r_J\|_1\).

Choose \(m=J=\lfloor w^a\rfloor\) with the fixed parameters in (5), and \(b=\delta\sqrt m\) from Lemma 4. In (18), for \(j\lt m\), Lemma 4 bounds the \(L^2(T)\) norm of the inner sum by
\[
 C \frac{(C_1\sqrt m)^j}{j!}
 \left(\|u\|_{L^2(T^+)}+\sqrt w\,e^{-cm}\right).
 \tag{20}
\]
To check constants, factor \((C_0\sqrt m)^j/j!\) from the sum of the bounds in (13). The remaining sum is at most \(\exp[j^2/(2C_0^2 m)]\) because \(j!/(j-2v)!\le j^{2v}\). For \(j\le m\) this exponential can be absorbed in \(C_1^j\).

Let \(\gamma=1-a(s-1/2)>0\). By (16) and (20), the sum in (18), denoted \(e_0\) and supported in \(T\), satisfies
\[
 \|e_0\|_2
 \le Cw^{-\gamma}\big(\|u\|_{L^2(T^+)}+\sqrt w\,e^{-cm}\big).
 \tag{21}
\]
In fact the \(j\)th factor after canceling \(j!\) is bounded by
\((C m^{s-1/2}/w)^j\), since \((j!)^{s-1}\le m^{(s-1)j}\). Summing this geometric sequence gives (21). With \(J=m\), (19) bounds \(\|r_J\|_1+\|r_J\|_2\) by \(C e^{-c w^a}\) for sufficiently large \(w\). This bound also absorbs \(\sqrt w\,e^{-cm}\) in (21).

On \(S\), convexity gives
\[
 F(h_{d,w})-F(f)
 \le -(1-\theta)[F(f)+1]+(1-\theta)[F(g)+1].
\]
The integral of the first term is at most \(-c_1 E(d+2w)\), since \(\theta=0\) at that depth and \(F(f)+1\ge c_1(f-1)^2\). The second term is supported at depths at least \(d\) and its integral is \(O(e^{-c d^2})\) by (11) and the positive lower bound for \(g\) on \(S\).

For the additional change \(h_{d,w}\) to \(f_{d,w}\), use Taylor's theorem for \(F\) on their fixed positive bounded range on \(S\). On \(T\),
\[
 |\log h_{d,w}|\le C(|u|+|g-1|).
\]
Since \(a<2\), \(b=O(w^{a/2})=o(w)\). With \(u=f-g\), (11) bounds both \(\|u\|_{L^2(T^+)}\) and \(\|\log h_{d,w}\|_{L^2(T)}\) by \(C[E(d-2b)+e^{-c(d-2b)^2}]^{1/2}\). Using (21) for the linear term against \(e_0\), the bounded logarithm for \(r_J\), and the global \(L^2\) error for the quadratic term, we obtain
\[
 \int_S [F(f_{d,w})-F(h_{d,w})]
 \le C w^{-\gamma} E(d-2b)+C e^{-c w^a}.
 \tag{22}
\]
All terms with \(|g-1|\) are absorbed since \(d\ge w\) and \(a<2\).

Outside \(S\), \(h_{d,w}=f\). The modified input mass lies at depth at least \(d\). Summing local masses in (17) therefore gives \(|f_{d,w}-f|\le C\exp[-c(\operatorname{dist}(y,S)+d)^2]\) there. For \(d\ge R_0\) the endpoint lower bounds (8) apply to both outputs, and both are uniformly bounded above by the unit-interval mass estimate. Thus the logarithm at any value between the two outputs is bounded in absolute value by \(C(1+\operatorname{dist}(y,S)^2)\). The mean value theorem shows that the exterior contribution to \(\mathcal F(f_{d,w})-\mathcal F(f)\) is \(O(e^{-c d^2})\).

Combining this with (9) and (22) proves the uniform inequality
\[
 0\le\mathcal F(f_{d,w})-\mathcal F(f)
 \le -c_1 E(d+2w) + Cw^{-\gamma}E(d-2b)+C e^{-c w^a}.
 \tag{23}
\]
The depth and the window width are independent parameters in this inequality.

To bound \(E(D)\), take a large depth \(D<\ell/2\) and choose \(w=D^{1/(1+a)}\), keeping the same \(w,m,b\) throughout this step. Starting at \(z_0=w\), put \(z_{i+1}=z_i+2w+2b\) and apply (23) with \(d=z_i+2b\) whenever \(z_{i+1}\le D\). There are at least \(cD/w\) such steps for large \(D\), since \(w=o(D)\) and \(b=o(w)\). For large \(w\), \(C w^{-\gamma}/c_1\le1/2\). The initial bound \(E(z_0)\le C\), iteration of (23) and monotonicity in depth give
\[
 E(D)\le C\,2^{-cD/w}+C e^{-c w^a}
       \le C' e^{-c'D^{a/(1+a)}}.
 \tag{24}
\]
Bounded \(D\) follows from the uniform initial energy, and \(E(\ell/2)=0\). For any \(0<\beta<2/3\), an integer \(p\) and a real \(a\) obeying (5) exist because \(1/(1/2+1/p)\to2\) as \(p\to\infty\). This proves (4).

For the replacement in Theorem 3 set \(d=w=R\). Discarding the negative term in (23) and applying (24) at \(R-2b\ge R/2\) gives a free energy difference \(O(e^{-c_\beta R^\beta})\), since \(a>\beta\). Equations (7) and (10) convert it to the stated capacity loss. The input \(\rho_R\,dy\) equals Lebesgue measure on the central interval. The remaining input mass is \(O(R)\) by the unit-interval bound and the support of the two transitions, and the total mass is \(\ell+O(R)\). This proves the uniform-component assertion and Theorem 3. \(\square\)

## 5. The lower bounds

Fix \(0<\tau<2/3\) as in Theorem 1. Choose \(\beta\in(\tau,2/3)\), then choose \(r\in(\tau/\beta,1)\) and \(R=A^r\). Theorem 3 gives \(C(A)-I(P_R)=o(\epsilon)\) uniformly along the stated joint limits, since \(R^\beta=A^{r\beta}\) and \(r\beta>\tau\). Return to the centered constraint interval. The uniform part of \(P_R\) is on \([-a_-,a_-]\), \(a_-=A-3R\), with weight \(w_R=1-O(R/A)\). By (6) and Pinsker's inequality, every admissible \(Q\) satisfies
\[
 T:=\operatorname{TV}(p_Q,p_{P_R})=O(\sqrt\epsilon).
 \tag{25}
\]
Here and below total variation is one half the \(L^1\) distance.

For a positive integer \(n\) form \(v(x)=(e^{i\pi j x/a_-})_{j=0}^n\) and let \(\Pi\) be the orthogonal projection onto the complement of the evaluation vectors at the \(k\) heaviest atoms of \(Q\), for \(k\lt n+1\). The real trigonometric polynomial \(B(x)=v(x)^*\Pi v(x)/(n+1)\) is bounded between zero and one and is zero at those atoms. Its average on \([-a_-,a_-]\) is \(\operatorname{rank}\Pi/(n+1)\ge1-k/(n+1)\). Let \(B_{\rm inv}\) multiply its \(j\)th Fourier coefficient by \(e^{(\pi j/a_-)^2/2}\). Then \(\phi*B_{\rm inv}=B\) and
\[
 \|B_{\rm inv}\|_\infty\le e^{(\pi n/a_-)^2/2}.
 \tag{26}
\]
Indeed the trigonometric Bernstein inequality gives \(\|D_t\|_{\infty\to\infty}\le\pi n/a_-\) for differentiation in this finite-dimensional polynomial space, and the exponential series for \(e^{-D_t^2/2}\) gives (26).

The difference between the two input expectations of \(B\) is bounded by \(2T\|B_{\rm inv}\|_\infty\). Its expectation under \(Q\) is at most \(1-S_k(Q)\), and its expectation under \(P_R\) is at least \(w_R(1-k/(n+1))\). Choose
\[
 n=\left\lfloor \frac{a_-}{\pi}\sqrt{L-4\log L}\right\rfloor,\quad M=n+1 .
\]
The comparison gives
\[
 S_k(Q)\le k/M+\delta_A,\qquad
 M\sim b_A,\qquad \delta_A=O(R/A+L^{-2}).
 \tag{27}
\]
This also holds for \(k\ge M\) since \(S_k\le1\). It applies to countably supported \(Q\) because only finitely many evaluations are removed. Taking \(S_K=1\) for a finite support gives the cardinality lower bound. Equation (27) also gives (2), and the identity
\(\operatorname{TV}(Q,\operatorname{Unif}(\operatorname{supp}Q))=\max_{k\le K}(S_k-k/K)\)
gives the claimed weight bound when \(K/b_A\to r_0\ge1\). If \(M\le K\), the maximum is at most \(1-M/K+\delta_A\) by splitting at \(M\). If \(M>K\), the bound is simply \(\delta_A\).

For the entropy lower bound let \(E=\sum_i(q_i-1/M)_+\le\delta_A\), by using in (27) the finite number of weights exceeding \(1/M\). If \(E=0\) then \(H(Q)\ge\log M\). For \(0\lt E<1\) write \(Q=(1-E)Q_0+E Q_1\), where \(Q_0\) is formed by clipping each \(q_i\) to \(1/M\) and normalizing, and \(Q_1\) is the normalized excess. Then \(H(Q_0)\ge\log[M(1-E)]\). By using the mixture label and \(I(Q_0)\le C(A)\),
\[
 EC(A)-\epsilon-h_2(E)\le E I(Q_1)\le E H(Q_1),
\]
where \(h_2(E)\) is binary entropy. Entropy concavity gives
\[
 H(Q)\ge\log M-\delta_A(\log M-C(A))_+-\delta_A-h_2(\delta_A)-\epsilon
\]
for large \(A\) with \(\delta_A\le1/2\), using \((1-E)\log(1-E)\ge-E\). Infinite \(H(Q)\) satisfies the same bound. The capacity lower bound in (7) implies \((\log M-C(A))_+\le\tfrac12\log L+O(1)\). Since \(r<1\) is fixed and \(L=O(A^\tau)\), \(\delta_A\log L=o(1)\), yielding \(H(Q)\ge\log b_A-o(1)\).

## 6. Sharp positive discretization

Keep \(R=A^r\) and the centered coordinates. Write \(a_0=A-2R\) and
\[
 \rho_R=\mathbf1_{[-a_0,a_0]}*\kappa_R,\qquad
 \nu_R=(1-\rho_R)\mu_*,\qquad
 M_R=\mu_R(S),\qquad f_R=\phi*\mu_R .
\]
Then \(\mu_R=\nu_R+\rho_R\,dx\), with boundary mass \(\nu_R(S)=O(R)\) in two intervals of length \(3R\), and \(M_R\asymp A\). The proof of (23) gives \(f_R\ge c>0\) in \(S\) and the exterior lower envelope (8).

Let \(K\ge1\), \(h=2a_0/K\), \(\xi=2\pi/h\), and take \(U\) uniform on \([0,h)\). The phase-dependent bulk approximation
\[
 \lambda_U=h\sum_{j\in\mathbb Z}\rho_R(jh+U)\delta_{jh+U}
\]
has total mass \(2a_0\) at every phase and \(\mathbb E\lambda_U=\rho_R\,dx\). For the first equality, periodizing the interval indicator of length \(Kh\) gives the constant \(K\) almost everywhere, and convolution with \(\kappa_R\) gives it everywhere. The second follows by integrating the sum over a period of \(U\).

Here is its entropy error estimate. Define
\[
 V=\frac1{M_R}\int\frac{\mathbb E|\phi*\lambda_U-\phi*(\rho_R\,dx)|^2}{f_R}\,dy.
\]
For \(0<\eta<1/2\) and \(\eta\xi\ge1\), (15) implies
\[
 V\le C e^{-(1-\eta)^2\xi^2}
   + C A^{-1}e^{-c(R\eta\xi)^{1/s}}
   + C A e^{-c R^2}.
 \tag{28}
\]
For the interior estimate, compute phase Fourier coefficients of \((\phi*\lambda_U)(y)\). At index \(k\) they are
\(\int \rho_R(x)\phi(y-x)e^{-ik\xi x}\,dx\).
Subtracting the \(k=0\) mean, then applying Parseval in \(U\) and Plancherel in \(y\), gives the integrated unweighted variance
\[
 \frac1{2\pi}\sum_{k\ne0}\int e^{-\omega^2}
       |\widehat\rho_R(\omega-k\xi)|^2\,d\omega .
\]
The sign of the shift can be reversed by replacing \(k\) by \(-k\). On \(|\omega|\ge(1-\eta)|k|\xi\) its \(k\)th integral is at most \(C A e^{-(1-\eta)^2 k^2\xi^2}\) since \(\|\rho_R\|_2^2\le2a_0\). On the complement, \(|\omega-k\xi|\ge\eta|k|\xi\). Using
\[
 \widehat\rho_R(t)=\frac{2\sin(a_0t)}{t}\widehat\kappa(Rt)
\]
and (15) bounds that integral by \(C e^{-c(R\eta\xi |k|)^{1/s}}\). Both sums are bounded by constant multiples of their leading terms with \(c\) reduced in the second sum. Division by \(M_R f_R\) on \(S\) proves the first two contributions to (28).

For the exterior, both bulk input measures have mass \(2a_0\) and are supported at least distance \(R\) from the endpoints. At distance \(t\ge0\) beyond an endpoint, the sum of the two output densities is at most \(C A e^{-(t+R)^2/2}\). By (8) the exterior contribution to \(V\) is bounded by \(C A\int_0^\infty e^{-(t+R)^2+(t+R_0)^2/2}\,dt\) at each end, giving the last contribution to (28).

We also need a finite approximation of the boundary mass. For any integer \(q\ge1\), divide each of its two supporting intervals into cells of length at most \(\sqrt q/4\). For each normalized positive-mass cell restriction, Carathéodory's theorem gives a law with at most \(q\) support points matching moments through degree \(q-1\) in the closed cell. Both supports are within distance \(\sqrt q/4\) of the original conditional mean. To bound the smoothed error, translate this mean to zero and let \(P_0,Q_0\) be the original and matched cells. With \(D=Q_0-P_0\), Gaussian integration gives
\[
 \int\frac{(\phi*D)^2}{\phi}
 =\iint e^{xy}\,dD(x)dD(y)
 =\sum_{j\ge q}\frac{\big(\int x^j\,dD(x)\big)^2}{j!}
 \le4\sum_{j\ge q}\frac{(q/16)^j}{j!}.
\]
Also \(\phi*P_0\ge e^{-q/32}\phi\) by Jensen and the mean-zero condition. Consequently the cell \(\chi^2\) divergence is bounded by \(5e^{-q}\), using \(q!\ge(q/e)^q\) and the \(1/16\) tail ratio. Mixing cell approximations with their original weights preserves the bound by joint convexity of \(\chi^2\). We obtain a boundary measure \(\widehat\nu_R\) of the same total mass, with \(O(R\sqrt q+q)\) atoms. Put \(\overline P=(\widehat\nu_R+\rho_R\,dx)/M_R\). Another application of joint convexity shows
\[
 E_B:=\chi^2(p_{\overline P}\Vert p_{P_R})\le 5\,\frac{\nu_R(S)}{M_R}\,e^{-q}.
 \tag{29}
\]
A zero boundary mass is covered by the zero measure.

The law \(Q_U=(\widehat\nu_R+\lambda_U)/M_R\) is a probability and has mean \(\overline P\). Orthogonality of the mean boundary error and the centered phase error yields \(\mathbb E\chi^2(p_{Q_U}\Vert p_{P_R})=E_B+V\) with the fixed denominator \(p_{P_R}\). Expanding the relative entropy and using Cauchy–Schwarz gives
\[
 \begin{split}
 h(p_{P_R})-\mathbb E h(p_{Q_U})
 &=\mathbb E D(p_{Q_U}\Vert p_{P_R})
  +\int (p_{\overline P}-p_{P_R})\log p_{P_R}\\
 &\le E_B+V+C(1+A^2)\sqrt{E_B}.
 \end{split}
 \tag{30}
\]
Indeed every unit-noise Gaussian mixture on \([-A,A]\) is bounded above by \(\phi(0)\) and below by \(\phi(|y|+A)\). These inequalities and the fourth moment of \(Y=X+Z\) give \(\|\log p_{P_R}\|_{L^2(p_{P_R})}\le C(1+A^2)\). They also justify the entropy identities uniformly over all phases for fixed \(A\).

Choose
\[
 \eta=L^{-1/4},\qquad K=\left\lceil (a_0/\pi)\sqrt{L+4L^{3/4}}\right\rceil,\qquad
 q=\lceil2L+10\log A\rceil .
\]
Since \(L\to\infty\), eventually \((1-\eta)^2\xi^2\ge L+L^{3/4}\) and \(\eta\xi\ge1\). Thus the first term of (28) is \(o(\epsilon)\). For the second, the parameters in (5) give
\(\beta\lt a/(1+a)<1/s\). The latter inequality follows from \(a(s-1)<1\), which holds since \(a(s-1/2)<1\). Hence \(r/s>r\beta>\tau\), and the second term is \(o(\epsilon)\) as well. The last term is \(o(\epsilon)\) because \(2r>\tau\). The choice of \(q\) makes both terms in (30) involving \(E_B\) be \(o(\epsilon)\). Together with the replacement loss, the mean of \(C(A)-I(Q_U)\) is \(o(\epsilon)\). This loss is nonnegative at every phase, so some phase is admissible.

The bulk support size is at most \(K(1+R/a_0)+2\sim b_A\). Its boundary supplement has \(O(R\sqrt{L+\log A}+L+\log A)=o(A\sqrt L)\) atoms. For the first term use \(R/A=A^{r-1}\) and \(L\to\infty\), and for the second use \(L=O(A^\tau)\) with \(\tau<2\). Thus the admissible phase has at most \((1+o(1))b_A\) atoms. Its entropy is at most the logarithm of its support size, proving the two upper bounds of (1).

By (27) any asymptotically minimal support has weights converging in total variation to uniform on that support. The preceding construction therefore attains the mass constants in (2) and the weight bound at \(r_0=1\). For \(r_0>1\), take the same construction at loss \(\epsilon/2\) and add distinct new points until the count is \(\lceil r_0K\rceil\), assigning them total mass at most \(\epsilon/[4(1+C(A))]\). Concavity of mutual information keeps the resulting loss below \(\epsilon\). The added mass tends to zero, and its number of atoms gives weight total variation tending to \(1-1/r_0\). This proves Theorem 1. Apply its lower bounds to the exact optimizer with \(\epsilon=e^{-A^\tau}\) for each \(\tau<2/3\) to get growth exponents at least \(1+\tau/2\) for support, entropy and trimmed mass. Taking the supremum over \(\tau\) proves Corollary 2. \(\square\)

## 7. Relation to earlier bounds

Smith proved finite support for the exact optimizer. Dytso, Yagli, Poor and Shamai proved an \(O(A^2)\) upper bound on its cardinality. Wang, Barletta and Dytso, Theorem 1, obtained a lower bound of order \(A\sqrt{\log A}\) by estimating the relative entropy of the uniform-input output with respect to the optimal output on the real line and then using a wrapped-channel comparison. Bounding the loss of the uniform input by \(O(A^{-1})\) alone limits such a converse to logarithmic growth in the inverse accuracy. Theorem 3 keeps the boundary input, which provides the precision needed for the power-law lower bound (3).

Barletta and Dytso, Theorems 2–4 in their August 2026 author version, study the same \(K_\epsilon(A)\). Their polynomial-accuracy bounds establish the \(A\sqrt{\log A}\) order, and their upper bound gives \(O(A^{3/2})\) at \(\epsilon=e^{-A}\). The upper and lower constants in their polynomial bounds differ, and their exponential lower bound is still on the \(A\sqrt{\log A}\) scale. Ma, Wu and Yang, Theorem 1 and Sections 3–4, establish the approximation order for the worst compactly supported Gaussian location mixture, using local moment matching and trigonometric moment matrices. These are the antecedents of the corresponding approximation ingredients above. Here the target is an entropy optimizer, and quantitative localization is what makes a nearly full uniform component available at much smaller loss. It also confines the general moment-matching approximation to a negligible boundary fraction, allowing the sharp constant from the Gaussian Fourier multiplier to survive in the real channel.

Abbott and Machta, equations (13)–(14), use a local-density ansatz in a continuum expansion to predict \(K\) of order \(A^{4/3}\) for the exact optimizer. Corollary 2 rigorously reaches the predicted exponent from below without a local-spacing hypothesis. A matching upper exponent and the finite positive leading constant for exact capacity remain to be determined.

### References

- M. C. Abbott and B. B. Machta. A scaling law from discrete to continuous solutions of channel capacity problems in the low-noise limit. Journal of Statistical Physics 176, 214–227 (2019). [DOI](https://doi.org/10.1007/s10955-019-02296-2)
- L. Barletta and A. Dytso. Support size of \(\epsilon\)-capacity-achieving inputs for the amplitude-constrained AWGN channel. Entropy 28, 500 (2026). [DOI](https://doi.org/10.3390/e28050500) · [Author version v2](https://arxiv.org/abs/2604.14915v2)
- A. Dytso, S. Yagli, H. V. Poor and S. Shamai. The capacity achieving distribution for the amplitude constrained additive Gaussian channel: an upper bound on the number of mass points. IEEE Transactions on Information Theory 66, 2006–2022 (2020). [DOI](https://doi.org/10.1109/TIT.2019.2948636)
- Y. Ma, Y. Wu and P. Yang. On the best approximation by finite Gaussian mixtures. IEEE Transactions on Information Theory 71, 5469–5492 (2025). [DOI](https://doi.org/10.1109/TIT.2025.3558841) · [Author version](https://arxiv.org/abs/2404.08913v2)
- A. L. McKellips. Simple tight bounds on capacity for the peak-limited discrete-time channel. IEEE International Symposium on Information Theory (2004). [DOI](https://doi.org/10.1109/ISIT.2004.1365385)
- J. G. Smith. The information capacity of amplitude- and variance-constrained scalar Gaussian channels. Information and Control 18, 203–219 (1971). [DOI](https://doi.org/10.1016/S0019-9958(71)90346-9)
- H. Wang, L. Barletta and A. Dytso. An improved lower bound on cardinality of support of the amplitude-constrained AWGN channel. IEEE Transactions on Information Theory 72, 5392–5399 (2026). [DOI](https://doi.org/10.1109/TIT.2026.3697668) · [Author version](https://arxiv.org/abs/2512.22691v2)

## Appendix A. A direct proof on the circle at large effective noise

The circle has no boundary, and its finite-support entropy problem admits a different comparison. This appendix gives a direct moment and Hessian proof in the large-effective-noise regime. Appendix B explains a stronger all-noise conclusion from established periodic quadrature and spherical energy theorems.

On a circle of length \(2\pi\), let \(Q\) be a probability measure on at most \(K\) points and let \(p\) be its density relative to Haar measure after smoothing by a Gaussian of variance \(\sigma^2>0\) modulo \(2\pi\). We minimize the deficit \(D(p\Vert1)=\int p\log p\) from the uniform output entropy. The equally weighted regular polygon is globally optimal once \(\sigma^2K\) exceeds a logarithmic function of \(K\).

### Statement

There is an absolute constant \(C\) such that for every \(K\ge2\) and \(\sigma^2 K\ge C\log(K+1)\), the unique minimizers up to rotation are the equally weighted regular \(K\)-gons.

In addition, writing \(G_K(\sigma)\) for the minimum and \(x=\sigma^2K^2\), along all sequences with \(x\to\infty\) and \(K e^{-x/2}\to0\),
\[
G_K(\sigma)=e^{-x}(1+o(1)).
\tag{A.1}
\]
The exact optimizer theorem and (A.1) concern the wrapped channel.

### A.1. Low moments localize every optimizer

Write \(m_j(Q)=\int e^{ij\theta}\,dQ(\theta)\). An equal-weight regular polygon gives \(m_j=0\) except at multiples of \(K\). Its smoothed density \(p_\circ\) satisfies
\[
 D(p_\circ\Vert1)\le \chi^2(p_\circ\Vert1)
  =2\sum_{\ell\ge1}e^{-\ell^2 x}\le3e^{-x}\qquad(x\ge1).
\tag{A.2}
\]
An optimizer \(Q_*\) exists by compactness of \(K\)-atomic probabilities and continuity of the strictly positive heat density at fixed \(\sigma\). From (A.2), Pinsker and the Fourier multiplier \(e^{-\sigma^2j^2/2}\), it satisfies
\[
 |m_j(Q_*)|\le \sqrt6\, e^{-\sigma^2(K^2-j^2)/2}\qquad(1\le j\lt K).
\tag{A.3}
\]

Put \(\eta=\max_{1\le j\lt K}|m_j(Q_*)|\), and suppose \(K^2\eta\) is small. The \(K\)-by-\(K\) Toeplitz matrix with entries \(m_{j-l}\), \(0\le j,l\lt K\), differs from identity by operator norm at most \(K\eta\). It is the matrix \(V V^*\), where a column of \(V\) corresponding to an atom of weight \(w_i\) at \(z_i=e^{i\theta_i}\) has entries \(\sqrt{w_i}z_i^j\). Full rank requires exactly \(K\) distinct atoms of positive weight. Then \(V^*V\) is also within \(K\eta\) of identity. Its diagonal gives \(|Kw_i-1|\le K\eta\), and its off-diagonals give
\[
\left|K^{-1}\sum_{j=0}^{K-1}(z_i\overline z_l)^j\right|\le C_1 K\eta \qquad (i\ne l).
\tag{A.4}
\]
Rotate to place one atom at angle zero. For each other atom, \(|\sin(K\theta_i/2)|\le C_1K^2\eta\) by the geometric-series identity and (A.4). Thus each angle is within \(O(K\eta)\) of a grid angle. Two angles assigned to the same grid point would have separation \(O(K\eta)\), and their normalized sum in (A.4) would be \(1+O(K^2\eta)\), a contradiction. Exactly one angle belongs to each grid point. After another small rotation, the angular displacements sum to zero. The vector of all weight and angle deviations has Euclidean norm \(O(K^{3/2}\eta)\).

### A.2. Moment coordinates and strict KL curvature

Near the regular polygon use real variables \(v=(w_i-1/K,\theta_i-\theta_i^\circ)_{i=1}^K\), with both sums zero. Let \(M(v)=(m_1,\ldots,m_{K-1})\), viewed as a real vector. The differential at the grid is
\[
(DM(0)v)_j=\widehat a_j+i(j/K)\widehat b_j ,
\]
where \(a,b\) are the weight and angle deviations, and the hats are their unnormalized discrete Fourier transforms. Pair the \(j\)th output with the conjugate of output \(K-j\), using the real-valued input displacements. Their difference is \(i\widehat b_j\), and their sum with suitable coefficients recovers \(\widehat a_j\). Parseval on these transforms gives \(\|DM(0)^{-1}\|\le C_2/\sqrt K\).

For \(\|v\|\le c K^{-2}\), all weights are at most \(2/K\). Second derivatives of a single \(m_j\) in parameter directions of norm one have bound \(C(j+j^2/K)\). This follows by differentiating \(\sum w_i e^{ij\theta_i}\) and applying Cauchy–Schwarz to the two coordinate vectors. Consequently \(\|D^2 M\|\le C_3K^{3/2}\) on the parameter ball. The inverse map is defined on a ball of radius \(c_1 K^{-3/2}\) in moment space, with \(\|D v\|\le C/\sqrt K\) and \(\|D^2v\|\le C\). For an explicit argument write \(J=DM(0)\) and solve \(v=J^{-1}\big(m-M(v)+Jv\big)\) on the parameter ball. The above bounds make the right side a strict contraction mapping the ball to itself for small absolute \(c,c_1\). Differentiating this inverse identity gives the two derivative bounds.

Choose \(C\) large in \(\sigma^2K\ge C\log(K+1)\). Equation (A.3) makes \(\eta\) smaller than a fixed constant times \(K^{-10}\). Thus the just-established localization puts \(Q_*\) inside the coordinate neighborhood, and the segment from zero to \(m=M(v_*)\) stays inside its image. Along this segment all low Fourier coefficients of \(p\) have absolute value at most \(\sqrt6 e^{-x/2}\). The high ones satisfy the Gaussian bound \(e^{-\sigma^2 j^2/2}\). Since \(\sigma^2K\) exceeds a fixed constant, their geometric tail is \(O(e^{-x/2})\). In particular
\[
 \|p-1\|_\infty\le C_4 K e^{-x/2} .
\tag{A.5}
\]
For a unit direction \(u\) in moment coordinates, low Fourier modes of \(D^2p[u,u]\) vanish identically. By the parameter derivative bounds above, the Hessian of each high moment is bounded by a polynomial in \(K,j\) of fixed degree. In detail \(\|D_v m_j\|\le \sqrt K+C j/\sqrt K\), \(\|D_v^2m_j\|\le C(j+j^2/K)\), and the inverse bounds give \(\|D_m^2m_j\|\le C_5 K^2(1+j)^2\). Hence
\[
 \|D^2p[u,u]\|_\infty\le C_6 K^4e^{-x/2}.
\tag{A.6}
\]
The same geometric tail estimate controls the extra \(j^2\) factor.

The KL Hessian in direction \(u\) is
\[
\int (Dp[u])^2/p+\int (\log p) D^2p[u,u],
\]
using zero integral of \(D^2p\). The first term is at least \(c_2 e^{-\sigma^2(K-1)^2}\) by Parseval on the low Fourier modes, since they are exact moment coordinates and \(p\) is bounded above by (A.5). The second term is bounded in absolute value by \(C_7K^5 e^{-x}\), by (A.5)–(A.6). For sufficiently large absolute \(C\) in the hypothesis, the first term dominates since \(x-\sigma^2(K-1)^2=\sigma^2(2K-1)\). Thus the KL objective has strictly positive second derivative along the moment segment to any optimizer distinct from zero.

At the grid the first derivative in these coordinates is zero. Rotation by \(2\pi/K\) followed by relabeling acts linearly on moment coordinates as \(m_j\mapsto e^{2\pi ij/K}m_j\) and preserves entropy. An invariant real linear derivative must vanish because each of these \(K-1\) coordinate characters is nontrivial. Strict convexity along the segment now contradicts optimality unless every low moment is zero. Such a measure is precisely a regular grid by the unitary Vandermonde argument (A.4). This proves the exact optimizer assertion.

### A.3. Sharp prefactor in a wider regime

From (A.2), any optimizer has total variation at most \(C e^{-x/2}\) from Haar after smoothing. For its Fourier expansion use the TV bound on \(j\lt K\) and the Gaussian bound on \(j\ge K\). Even when \(\sigma^2K\) is small, the latter sum is at most
\[
 e^{-x/2}\left(1+\frac1{\sigma^2K}\right)
 =e^{-x/2}(1+K/x),
\]
by \(j^2-K^2\ge2K(j-K)\) and summing the geometric series. Thus \(\|p-1\|_\infty=o(1)\) when \(x\to\infty\) and \(K e^{-x/2}\to0\). Expanding \((1+y)\log(1+y)\) uniformly in this range yields \(D(p\Vert1)=(1/2+o(1))\chi^2(p\Vert1)\).

For completeness, the quadratic-energy optimum used to bound this chi-square term is classical. The kernel
\[
 1+2\sum_{j\ge1} e^{-\sigma^2j^2}\cos(j\theta)
\]
has Jacobi product with each nonconstant linear factor in \(\cos\theta\) positive on \([-1,1]\) and with positive slope. Hence it is absolutely monotone there, and is completely monotone as a function of squared chord distance. The regular-polygon universal-optimality certificate of Cohn–Kumar gives a Chebyshev polynomial minorant of degree \(\le K-1\) with nonnegative nonconstant coefficients, interpolating all off-diagonal inner products. For a weighted configuration its sum is at least the constant coefficient, by Fourier squares. Restoring the diagonal contributes a nonnegative multiple of \(\sum_i w_i^2\ge1/K\). The equal-weight polygon reaches equality in both bounds. Accordingly \(\chi^2\ge 2\sum_{\ell\ge1}e^{-\ell^2 x}\) for every competitor. Applying the uniform entropy expansion to an optimizer and to the polygon proves (A.1). \(\square\)

## Appendix B. The all-noise circle comparison from periodic quadrature

Let \(K\ge1\) and \(\sigma>0\). Write \(k_\sigma\) for the wrapped \(N(0,\sigma^2)\) density relative to Haar probability on the circle of length \(2\pi\), and \(Q_{\rm reg}\) for the equally weighted regular \(K\)-gon. For every probability \(Q\) supported on at most \(K\) points and every \(c\in\mathbb R\),
\[
 \int (k_\sigma*Q_{\rm reg}-c)_+\,d{\rm Haar}
 \le \int(k_\sigma*Q-c)_+\,d{\rm Haar}.
 \tag{B.1}
\]
Consequently the regular polygon minimizes every convex integral of the output density. For entropy it is the unique minimizer up to rotation. This resolves the earlier large-effective-noise condition through an application of established approximation-theory results.

### The approximation theorem

Theorem 2.2.3 on printed p. 92 of D. S. Skorokhodov's 2018 dissertation, *Optimal recovery of operators and functionals and related extremal problems in approximation theory*, compares the positive and negative parts of every translation of the averaged quadrature error kernel in decreasing-rearrangement order. Take its branch \(J(k)=\varnothing\), \(k\in\mathcal A_{2K}(\varnothing)\), and total quadrature weight \(2\pi\). The hypothesis means that the kernel has nonvanishing Fourier coefficients and its convolution does not increase cyclic sign changes of input functions with at most \(2K\) cyclic sign changes. Section 2.1.2 of the same dissertation identifies the earlier point-quadrature precedents in Babenko. [Dissertation, Definitions 2.1.3–2.1.4 and Theorem 2.2.3](https://imath.kiev.ua/zahyst/files/92/diss.pdf)

For completeness the wrapped Gaussian has the required variation property. For a continuous real periodic input \(f\), set \(u=(I-\epsilon \partial^2)^{-1}f\). If \(u\) has \(2j\) alternating positive and negative values in cyclic order, choose a signed local extremum of \(u\) between consecutive bounding values of the other sign. At a positive maximum \(f=u-\epsilon u''>0\), and at a negative minimum \(f<0\). Thus the resolvent cannot increase cyclic sign changes. Iterate it \(N\) times with \(\epsilon=\sigma^2/(2N)\). The Fourier multipliers converge to \(e^{-\sigma^2 n^2/2}\). For \(N\ge1\) they are dominated by \((1+\sigma^2 n^2/2)^{-1}\), using Bernoulli's inequality. The corresponding convolution kernels converge uniformly, so variation diminution passes to the heat kernel. For piecewise continuous inputs with finitely many cyclic sign changes one may approximate in \(L^1\) by continuous functions with no additional sign changes, interpolating inside each constant-sign piece and tapering its endpoints to zero. The final heat convolutions converge uniformly, giving the same result. All wrapped heat multipliers are nonzero.

For an input \(Q=\sum_i w_i\delta_{\theta_i}\), let the quadrature coefficients be \(2\pi w_i\) and the averaging intervals be centered at the \(\theta_i\). Their half-width \(h\) can be arbitrarily small, so choose it less than half the minimum circular separation of the centers and less than \(\pi/K\). An input with fewer than \(K\) centers is handled by adding zero coefficients at distinct centers, or by continuity in the coefficients. With \(k^h\) denoting the local average of \(k_\sigma\), the quadrature error kernel (2.5) of the cited theorem is \(2\pi(1-k^h*Q)\). Use \(\lambda=2\pi(1-c)\) and the negative part in its conclusion. At the full rearrangement integration length the assertion is the corresponding integral inequality for \((k^h*Q-c)_+\), since rearrangement preserves integrals. Uniform convergence \(k^h\to k_\sigma\) as \(h\downarrow0\) proves (B.1).

The output densities have a common positive bounded range and common integral one. Representation of a convex function by positive mixtures of hinges on that range gives the convex comparison. In particular for \(\Phi(x)=x\log x\), the mixture density is \(\Phi''(c)=1/c>0\). Equality of the entropy objectives forces equality of the hinge inequalities at every threshold by continuity. The two outputs then also have the same quadratic integral.

### Equality in the quadratic comparison

For \(K=1\) the rotation statement is immediate. For \(K\ge2\) the squared output norm is the pair energy of the heat kernel with variance \(2\sigma^2\), including diagonal terms. Its expression \(F(\cos\theta)\) has strictly positive derivatives of every order on \([-1,1]\). This follows from the Jacobi product, whose factors \(1+2q^{2j-1}x+q^{4j-2}\), \(q=e^{-\sigma^2}\), are positive with strictly positive slopes. The product converges locally uniformly in complex \(x\), and one can differentiate any fixed number of initial linear factors while keeping the rest of the product positive. [NIST DLMF, Eq. 20.5.3](https://dlmf.nist.gov/20.5.E3)

Use the Cohn–Kumar Hermite auxiliary polynomial \(H\) at all distinct off-diagonal inner products of the regular \(K\)-gon with multiplicities two. The regular polygon is sharp since it is a spherical \((K-1)\)-design on the circle with \(\lfloor K/2\rfloor\) distances. Section 6 of Cohn–Kumar therefore gives a Chebyshev expansion with nonnegative nonconstant coefficients and degree at most \(2\lfloor K/2\rfloor-1\lt K\). The Hermite remainder is strictly positive \(F-H>0\) away from the interpolation inner products, including at \(x=1\). The weighted version of their energy bound is also described in §4. In detail, if \(h_0\) is the constant Chebyshev coefficient, then
\[
 \sum_{i,j} w_iw_j F(\cos(\theta_i-\theta_j))
 \ge \sum_{i,j}w_iw_j H(\cos(\theta_i-\theta_j))
       +(F(1)-H(1))\sum_iw_i^2
 \ge h_0+(F(1)-H(1))/K .
\]
The second inequality uses nonnegative Fourier squares and Cauchy–Schwarz. The regular polygon gives equality, as its moments below degree \(K\) vanish and all of its distinct pairs are interpolation points. Equality for a competitor forces exactly \(K\) atoms with equal weights and every distinct pair attaining one of those inner products. Relative to one atom, each other atom then has angle an integer multiple of \(2\pi/K\), so the support is a rotation of the full regular polygon. This establishes entropy uniqueness too. [Cohn–Kumar, §§4 and 6](https://doi.org/10.1090/S0894-0347-06-00546-7)

Finally \(k_\sigma*Q_{\rm reg}(\theta)=k_{\sigma K}(K\theta)\). Its entropy deficit relative to Haar is exactly \(D(k_{\sigma K}\Vert1)\). As \(x=\sigma^2K^2\to\infty\), the Fourier series and Taylor expansion give \(e^{-x}(1+o(1))\) with no additional joint restriction on \(K\). The quadratic comparison is the established spherical energy result, and the all-noise convex comparison is a consequence of the earlier quadrature theorem. These conclusions do not give the real-line boundary estimate.

### Priority references

- V. F. Babenko. Approximations, widths and optimal quadrature formulae for classes of periodic functions with rearrangement invariant sets of derivatives. Analysis Mathematica 13, 281–306 (1987). Bibliographic record and Skorokhodov's description of the point theorem checked. [DOI](https://doi.org/10.1007/BF01909434)
- V. F. Babenko. Widths and optimal quadrature formulas for convolution classes. Ukrainian Mathematical Journal 43, 1064–1076 (1991). Author abstract and Skorokhodov's description checked. [DOI](https://doi.org/10.1007/BF01089204)
- V. F. Babenko and D. S. Skorokhodov. On the best interval quadrature formulae for convolution classes. East Journal on Approximations 14(3), 353–376 (2008). The inspected theorem and proof are in the author's 2018 dissertation. [Dissertation](https://imath.kiev.ua/zahyst/files/92/diss.pdf)
