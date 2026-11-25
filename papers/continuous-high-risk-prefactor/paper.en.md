# The leading amplitude of the high-risk advantage in continuous CVaR ski rental

**Research manuscript — 24 November 2026**  
**Research draft:** The complete theorem has not received full formal verification. This manuscript has not undergone external peer review.

## Abstract

We refine the existing delay-equation characterization of optimal continuous-time ski rental under conditional value-at-risk. If the retained tail mass is \(q\), write the optimal competitive ratio as \(2-\Delta(q)\). The characteristic constant \(c>0\), determined by \(e^c=1+2c\), is inherited from earlier work. We evaluate the leading amplitude:
\[
\Delta(q)\sim A e^{-c/q},\qquad
A=\frac{e^c}{c(2c-1)}\int_0^1\frac{e^{cv}-1}{1+v}\,dv
=1.1062346581287343915\ldots.
\]
A positive averaging equation and an explicit contraction between successive unit windows give a parameter-uniform remainder. This uniformity justifies evaluating the asymptotic at the implicitly determined optimal parameter. We also obtain a uniform limit law after logarithmically rescaling the optimal purchase time and an upper-quantile boundary profile. An independent spectral argument yields the stronger explicit relative bound \(20000e^{-1/(2q)}\) for \(q\le1/20\). The source optimization theorem is cited, not reproved. Exact rational certificates cover the constants; numerical delay-equation calculations provide separate illustrative checks.

## 1. Model, source bridge, and contribution

Normalize the purchase price and rental rate to one. For a season of length \(s>0\), a randomized purchase time \(X\in[0,\infty]\) incurs
\[
L_s(X)=s\mathbf1_{\{X>s\}}+(1+X)\mathbf1_{\{X\le s\}},
\qquad \operatorname{OPT}(s)=\min\{s,1\}.
\]
The value \(X=\infty\) means never purchasing and is assigned cost \(s\); the indicator expression is interpreted piecewise at that value.
For a loss \(Y\), use
\[
\operatorname{CVaR}_{1-q}(Y)
=\inf_{z\in\mathbb R}\left(z+q^{-1}\mathbb E[(Y-z)_+]\right),
\qquad 0<q\le1.
\]
The adversary fixes \(s\); risk is measured over the algorithm's internal randomness. The optimal value is
\[
a(q)=\inf_X\sup_{s>0}
\frac{\operatorname{CVaR}_{1-q}(L_s(X))}{\min\{s,1\}},
\qquad \Delta(q)=2-a(q).
\tag{1}
\]
This is the continuous model of Christianson, Sun, Low, and Wierman [R1].

We import the following specific bridge from [R1, Theorem 7]. Set \(T=1/q\), and define
\[
\psi_a(t)=\log\!\left(1+\frac{t}{a-1}\right)\quad(0\le t\le1),
\qquad
a\psi_a'(t)=\psi_a(t)-\psi_a(t-1)\quad(t>1).
\tag{2}
\]
Then the optimal value satisfies \(\psi_{a(q)}(T)=1\), and the optimal purchase-time quantile is
\[
\phi_q(u)=\psi_{a(q)}(u/q),\qquad 0\le u\le1.
\tag{3}
\]
Equation (3) is an imported optimality result; the analysis below concerns its long-time asymptotics.

For clarity, (2) defines a unique function on **all** \([0,\infty)\), for each \(a>1\). Once the solution is known on \([0,n]\), its equation on \([n,n+1]\) is a linear ordinary differential equation with known forcing \(-\psi_a(t-1)/a\) and the specified value at \(n\). Successive solution gives a unique continuous, locally absolutely continuous, piecewise continuously differentiable extension. The left and right derivatives at \(1\) need not coincide. All integral identities below respect that junction.

The original work establishes exponential order and gives a comparison strategy with gap \((e^{c/q}-1)^{-1}\) [R1, Theorems 6–8]. The same \(c\) occurs in the prior discrete transition theorem [R2, Section 8]. That theorem, combined with the original discrete–continuous comparison, already implies \(\Delta(q)=\Theta(e^{-c/q})\). Neither the characteristic exponent nor this order estimate is claimed as new. Our contribution is the amplitude, uniform error control, and the resulting distributional information. The advantage of the optimal strategy over the source comparison strategy has asymptotic ratio \(A\); this compares their exponentially small gaps below two, not their entire competitive ratios.

Two related models should be distinguished. Dinitz et al. optimize expected performance under tail-probability constraints [R3]. Angelopoulos, Dürr, and Melidi evaluate risk under a distributional input prediction, with a robustness constraint [R4, Sections 2.2 and 3.2]. Neither inspected formulation is (1). A bounded literature and public-artifact search found no matching prefactor theorem as of the stated date; it does not establish global priority.

## 2. Main theorem

Let \(c>0\) be the unique positive solution of \(e^c=1+2c\), and set
\[
\gamma=\log(8/7),\qquad
A=\frac{e^c}{c(2c-1)}\int_0^1\frac{e^{cv}-1}{1+v}\,dv.
\tag{4}
\]
The integral is positive. Equivalently,
\[
A=\frac{\operatorname{Ei}(2c)-\operatorname{Ei}(c)-e^c\log2}
{c(2c-1)},
\tag{5}
\]
where the difference of exponential integrals is unambiguously
\(\operatorname{Ei}(2c)-\operatorname{Ei}(c)=\int_c^{2c}e^x/x\,dx\).

**Theorem 1 (amplitude and uniform remainder).** As \(q\downarrow0\),
\[
\Delta(q)=Ae^{-c/q}
+O\!\left(q^{-1}e^{-2c/q}+e^{-(c+\gamma)/q}\right).
\tag{6}
\]
In particular, the relative error is \(O(e^{-\gamma/q})\). More explicitly, for every \(0<q\le1/10\),
\[
\left|\Delta(q)-Ae^{-c/q}\right|
\le\frac{e^2}{3}\left(1600+\frac{256}{q}\right)e^{-2c/q}
+\frac{64e}{7}e^{-(c+\gamma)/q}.
\tag{7}
\]
The constants are conservative. Appendix A independently proves, for \(0<q\le1/20\),
\[
\left|\frac{\Delta(q)}{Ae^{-c/q}}-1\right|
\le20000e^{-1/(2q)}.
\tag{8}
\]

The leading coefficient is determined by the initial logarithmic segment in (2), not merely by the characteristic root. A fixed-parameter decay estimate alone would also be insufficient: the parameter in (2) varies with \(T\). The next three sections supply that uniform control directly.

The two error terms in (6) have different sources. The averaging dynamics relax to a constant after exponential tilting; this produces the term involving \(\gamma\). Changing the parameter from \(a(q)\) to two changes both the amplitude and the decay exponent. The latter change is multiplied by the observation time \(T\), which produces \(T e^{-2cT}\). Keeping these errors separate exposes the point at which uniformity is required. The proof establishes a preliminary bound on \(\Delta\), improves it at the correct exponential scale, and only then freezes the parameter. No numerical estimate of a characteristic root's separation is needed in the main argument.

## 3. A positive averaging equation

Differentiate \(a\psi_a(t)-\int_{t-1}^t\psi_a(s)\,ds\) for \(t>1\). Equation (2) makes the derivative zero, while
\[
\int_0^1\log\!\left(1+\frac{s}{a-1}\right)ds
=a\log\!\left(\frac a{a-1}\right)-1.
\]
Continuity across the junctions therefore gives the exact invariant
\[
a\psi_a(t)-\int_{t-1}^t\psi_a(s)\,ds=1\qquad(t\ge1).
\tag{9}
\]
Define the deficit without presupposing a limit:
\[
D_a(t)=\frac1{a-1}-\psi_a(t).
\]
The invariant becomes
\[
D_a(t)=\frac1a\int_0^1D_a(t-s)\,ds\qquad(t\ge1).
\tag{10}
\]

Let \(c_a>0\) solve \(e^{c_a}=1+ac_a\). Uniqueness follows because
\((e^z-1)/z=\int_0^1e^{zs}ds\) is strictly increasing from one to infinity for \(z>0\). Set
\[
H_a(t)=e^{c_at}D_a(t),\qquad
k_a(s)=a^{-1}e^{c_as}\mathbf1_{[0,1]}(s).
\]
The kernel integrates to one, so
\[
H_a(t)=\int_0^1 k_a(s)H_a(t-s)\,ds\qquad(t\ge1).
\tag{11}
\]
Throughout Sections 3–6, parameters range over \(I=[3/2,2]\). Elementary exponential bounds give
\[
\frac12<c_{3/2}\le c_a\le c<\frac32,
\qquad e^{c_a}<4,\qquad k_a(s)\ge\frac12.
\tag{12}
\]
For example, \(e^{1/2}<7/4\) and \(e^{3/2}>4\) bracket the required positive roots, and monotonicity of \((e^z-1)/z\) orders them. The identity \(e^{c_a}=1+ac_a\) then supplies the upper bound four. All these inequalities hold on the fixed parameter interval; they are not asymptotic assertions about a parameter already assumed close to two.
On the initial interval, \(D_a\) decreases in both \(a\) and \(t\). Since
\(D_2(1)=1-\log2>1/4\) and \(D_a(t)\le2\), we obtain
\[
\frac14<H_a(t)<8\qquad(0\le t\le1).
\tag{13}
\]
The following elementary lemma propagates these bounds and quantifies convergence.

**Lemma 2 (one-window contraction).** Suppose \(k\) is bounded, supported on \([0,1]\), integrates to one, and satisfies \(k\ge1/2\) there. If continuous \(H\) satisfies (11), define
\(m_n=\min_{[n,n+1]}H\) and \(M_n=\max_{[n,n+1]}H\). Then
\[
m_{n+1}\ge m_n,\qquad M_{n+1}\le M_n,\qquad
M_{n+1}-m_{n+1}\le\frac78(M_n-m_n).
\tag{14}
\]

*Proof.* Transfer initial data \(h(v)=H(v)\), \(0\le v\le1\), to the next window. Writing \(t=1+x\) gives a Volterra equation
\[
H(1+x)=g(x)+\int_0^x k(s)H(1+x-s)\,ds,
\qquad
g(x)=\int_x^1k(1+x-v)h(v)\,dv.
\]
Its resolvent is \(r=\sum_{j\ge1}k^{*j}\). If \(k\le K\), then
\(k^{*j}(s)\le K^js^{j-1}/(j-1)!\) on \([0,1]\), so the series converges locally uniformly. Iteration gives
\[
H(1+x)=\int_0^1 W_x(v)h(v)\,dv,
\]
\[
W_x(v)=\mathbf1_{\{v\ge x\}}k(1+x-v)
+\int_{\max(0,x-v)}^x r(s)k(1+x-v-s)\,ds.
\tag{15}
\]
These densities are nonnegative. Applying the unique Volterra solution to \(h\equiv1\) proves \(\int W_x=1\).

For \(v\ge x\), the direct term is at least \(1/2\). For \(v<x\), retain \(r(s)\ge k(s)\ge1/2\) over \([x-v,x]\); the second kernel is also at least \(1/2\). Thus \(W_x(v)\ge v/4\) almost everywhere. This common density has mass \(1/8\). Its contribution is independent of \(x\); the remaining positive measure has mass \(7/8\). The image range consequently has width at most \(7/8\) of the input range, and lies inside that range. Translation proves (14). \(\square\)

Nested ranges and (13)–(14) yield \(C_a\in(1/4,8)\) such that, simultaneously for every \(a\in I\) and \(t\ge0\),
\[
|H_a(t)-C_a|\le8(7/8)^{\lfloor t\rfloor}
\le\frac{64}{7}e^{-\gamma t}.
\tag{16}
\]
In particular, \(D_a(t)\to0\), so the previously unassumed limit is
\(\psi_a(t)\to1/(a-1)\). The contraction factor is shared by the entire parameter interval.

To spell out the convergence step, the closed intervals \([m_n,M_n]\) are nested and their lengths tend to zero. Their intersection is one point, denoted \(C_a\). Every value on the \(n\)-th time window lies in that interval, so its distance from \(C_a\) is at most the interval length. The factor \(64/7\) in (16) only compensates for replacing \(\lfloor t\rfloor\) by \(t\). Thus neither compactness in the parameter nor an unstated uniform version of a renewal theorem is being used to obtain the rate.

## 4. Evaluating the amplitude

Write
\[
\overline K_a(s)=\int_s^1 k_a(r)\,dr,
\qquad \mu_a=\int_0^1s k_a(s)\,ds
=1-\frac{a-1}{ac_a}.
\]
For \(t\ge1\), consider
\(J_a(t)=\int_0^1\overline K_a(s)H_a(t-s)\,ds\).
Integration by parts, using local absolute continuity, gives
\[
J_a'(t)=H_a(t)-\int_0^1k_a(s)H_a(t-s)\,ds=0.
\]
The invariant is continuous across step endpoints. Taking its limit with (16) and evaluating it at one gives
\[
\mu_a C_a=J_a(1)
=\frac{e^{c_a}}{ac_a}
\int_0^1(e^{c_av}-1)D_a(v)\,dv.
\tag{17}
\]
On the initial interval \(D_a'(v)=-1/(a-1+v)\). Compatibility at one in (10) says \(\int_0^1D_a(v)dv=aD_a(1)\). Integrating by parts in (17), and using \(e^{c_a}-ac_a=1\), therefore yields
\[
\int_0^1(e^{c_av}-1)D_a(v)\,dv
=\frac1{c_a}\int_0^1\frac{e^{c_av}-1}{a-1+v}\,dv.
\]
Explicitly, the boundary terms from integrating \(e^{c_av}D_a(v)\) leave
\((D_a(1)-D_a(0))/c_a\) after subtracting \(\int D_a=aD_a(1)\). Their difference is
\(-\log(a/(a-1))/c_a\), which subtracts exactly the integral of \(1/[c_a(a-1+v)]\). This explains the numerator \(e^{c_av}-1\) in the final amplitude and checks the endpoint contribution.
Consequently,
\[
C_a=\frac{e^{c_a}}{c_a(ac_a-a+1)}
\int_0^1\frac{e^{c_av}-1}{a-1+v}\,dv,
\qquad C_2=A.
\tag{18}
\]
This evaluates the limiting average from the initial data. It is independent of any numerical solution of the delay equation.

## 5. The implicit optimal parameter

For completeness, the endpoint equation has a unique solution in \((3/2,2)\) for every \(T\ge1\). To see this, let \(h_a=\psi_a'\). Away from the initial derivative junction,
\[
h_a(t)=\frac1a\int_{t-1}^t h_a(s)\,ds\quad(t\ge1),
\qquad h_a(t)=\frac1{a-1+t}\quad(0\le t<1).
\]
Positive Volterra iteration propagates strict positivity. It also propagates strict decrease with \(a\): for \(a<b\), the difference satisfies
\[
h_a(t)-h_b(t)=\frac1a\int_{t-1}^t(h_a(s)-h_b(s))\,ds
+\left(\frac1a-\frac1b\right)\int_{t-1}^t h_b(s)\,ds,
\]
with positive initial difference. Thus \(\psi_a(T)\) strictly decreases with \(a\), and depends continuously on it by the method of steps. Finally,
\(\psi_{3/2}(T)\ge\log3>1\), whereas the positive deficit gives \(\psi_2(T)<1\). This proves the assertion and agrees with the imported optimum.

At the root, the endpoint identity is exactly
\[
\Delta=(a-1)D_a(T)=(a-1)e^{-c_aT}H_a(T).
\tag{19}
\]
Hence
\[
0<\Delta\le8e^{-c_{3/2}T}\le8e^{-T/2}.
\tag{20}
\]
This first bound proves \(a(q)\to2\) before any moving-parameter asymptotic is invoked.

Differentiation of the root equation gives
\[
c_a'=\frac{c_a}{e^{c_a}-a}=\frac1{a\mu_a}.
\tag{21}
\]
The increasing density \(k_a\) has mean \(\mu_a\ge1/2\), as follows by pairing \(s\) with \(1-s\). Therefore \(c_a'\le4/3\), and
\(0\le c-c_a\le(4/3)\Delta\). For \(T\ge10\), (20) implies \((c-c_a)T<1\). With \(R=e^{(c-c_a)T}\),
\[
1\le R\le e,\qquad
R-1\le\frac{4e}{3}T\Delta,\qquad
\Delta\le8e\,e^{-cT}.
\tag{22}
\]
For the numerical threshold in this elementary estimate, \((32/3)Te^{-T/2}<1\) at \(T=10\) and decreases thereafter. The inequality \(e^x-1\le ex\) for \(0\le x\le1\) proves the middle bound in (22). Substituting the bound \(R\le e\) back into (19), rather than continuing with the weaker rate in (20), proves its final bound. This is the only preliminary improvement of the exponent needed by the main proof.

## 6. Quantitative freezing of the parameter

Here are explicit derivative bounds to keep every constant uniform. On the initial interval,
\[
|\partial_a k_a(v)|\le2k_a(v),\qquad
|\partial_aD_a(v)|\le4,\qquad
|\partial_aH_a(v)|\le80/3.
\tag{23}
\]
The first follows from \(\partial_a k_a=k_a(c_a'v-1/a)\). For the second,
\[
\partial_aD_a(v)=-\frac1{(a-1)^2}
+\frac{v}{(a-1)(a-1+v)}
\]
is nonpositive with magnitude at most four. The third follows from (12), (21), and \(D_a\le2\).

Consequently, \(|\partial_a\overline K_a|\le2\overline K_a\) and \(|\mu_a'|\le2\mu_a\). Differentiate the initial-data expression \(\mu_a C_a=J_a(1)\), obtaining
\[
|C_a'|\le176/3,
\qquad |B'(a)|\le200/3,
\qquad B(a)=(a-1)C_a.
\tag{24}
\]
Indeed, the derivative of \(J_a(1)\) is bounded by
\((16+80/3)\mu_a\); differentiating its denominator adds at most \(2C_a\le16\).

Write \(r_a(T)=H_a(T)-C_a\). Combining (16), (19), and (22) gives
\[
\Delta=e^{-cT}R\,[B(a)+(a-1)r_a(T)].
\]
Since \(B(2)=A\le8\), the triangle inequality yields
\[
\begin{aligned}
|\Delta-Ae^{-cT}|
&\le e^{-cT}\left[
\frac{200e}{3}\Delta+\frac{32e}{3}T\Delta
+\frac{64e}{7}e^{-\gamma T}\right]\\
&\le\frac{e^2}{3}(1600+256T)e^{-2cT}
+\frac{64e}{7}e^{-(c+\gamma)T}.
\end{aligned}
\]
This is (7). Since \(c>\gamma\), the first error term is absorbed by the second asymptotically. Theorem 1 follows without an interchange of a fixed-parameter limit and an implicit optimization. \(\square\)

## 7. Shape of the optimal buying-time distribution

The same estimate explains how a randomized strategy concentrates near purchase time one while retaining a nontrivial range of exponential scales.

**Corollary 3 (logarithmic quantile spread).** For \(u\) in any compact subinterval of \((0,1)\),
\[
1-\phi_q(u)=Ae^{-cu/q}(1+o(1))
\tag{25}
\]
uniformly. If \(X_q\) has the optimal purchase-time distribution, then
\[
q\log\frac1{1-X_q}\ \Rightarrow\ \operatorname{Uniform}[0,c].
\tag{26}
\]

*Proof.* The endpoint condition gives
\[
1-\phi_q(u)=D_{a(q)}(uT)-D_{a(q)}(T).
\]
Apply (16) and (18) to the two deficits. The relative renewal error is \(O(e^{-\gamma uT})\); the terminal deficit contributes \(O(e^{-c_a(1-u)T})\); changing \(c_a\) to \(c\) contributes \(O(T\Delta)\). All vanish uniformly on such compact subintervals. The prefactor tends to \(C_2=A\). Under the quantile coupling \(X_q=\phi_q(U)\), with one uniform \(U\in(0,1)\), equation (25) implies almost surely
\(q\log(1/(1-X_q))\to cU\), proving (26). The endpoint \(u=1\), where the logarithm is infinite, has probability zero. \(\square\)

In particular, each fixed interior quantile tends to one, but different quantiles do so at different exponential rates. Ordinary weak convergence of \(X_q\) to the point mass at one suppresses this information. Formula (26) retains it through a deterministic logarithmic rescaling. The assertion concerns the distribution of the algorithm's purchase time; it does not place a probability law on the adversary's season length.

**Corollary 4 (upper-quantile profile).** For each fixed finite \(V\), uniformly over \(0\le v\le V\),
\[
\frac{1-\phi_q(1-qv)}{\Delta(q)}\longrightarrow e^{cv}-1.
\tag{27}
\]
For sufficiently small \(q\), the uniform error is bounded by
\(K_V[\Delta(q)+e^{-\gamma/q}]\), for a finite constant depending only on \(V\).

*Proof.* Once \(T\ge V+1\), the exact ratio is
\[
\frac1{a-1}
\left[e^{c_av}\frac{H_a(T-v)}{H_a(T)}-1\right].
\]
The denominator is at least \(1/4\). Equation (16) controls the ratio of the two \(H_a\) values uniformly in \(v\); (21) controls the exponent, and \(a-1=1-\Delta\). This gives the claimed bound and limit, including \(v=0\), where both profiles vanish. \(\square\)

## 8. Reproducible arithmetic and numerical checks

The integral in (4) defines \(A\). The accompanying `certify_constants.py` uses exact rational arithmetic, positive exponential-series tails, and
\(\log2=2\sum_{j\ge0}3^{-(2j+1)}/(2j+1)\). To bound the integral it uses moments
\(J_n=\int_0^1t^n/(1+t)dt\), with \(J_0=\log2\) and \(J_n=1/n-J_{n-1}\). Positive coefficients permit termwise integration and geometric tail bounds. Independent numerator and denominator bounds avoid assuming monotonicity of the prefactor.

The resulting outward decimal enclosures, whose endpoints are exact decimal rationals, are
\[
1.256431208626169676982737616609<c
<1.256431208626169676982737616610,
\]
\[
1.1062346581287343915159084319<A
<1.1062346581287343915159084320.
\tag{28}
\]
This is a certificate for constants, not a formal proof of the delay dynamics or the optimization bridge.

The root certificate uses two rational trial points and bounds \(e^x-1-2x\) by signs on their respective sides. This function is strictly increasing in the certified interval above one. The amplitude certificate then bounds the increasing integral at those endpoints while enclosing the remaining positive factors separately. The checked inequalities also certify \(A>1\). Consequently the source comparison strategy has a strictly smaller leading high-risk advantage, with difference \((A-1)e^{-c/q}(1+o(1))\); the absolute difference still tends to zero exponentially.

Separately, `verify_asymptotics.py` solves the endpoint equation at seven recorded values with \(q<1\), using the same method-of-steps Taylor implementation at 110 working decimal digits with two discretizations: eight substeps with order 100 and sixteen substeps with order 80. These are two configurations of one solver, not independent implementations. The following rounded values are illustrative floating-point results.

| Tail mass \(q\) | Computed \(\Delta(q)\) | Computed \(e^{c/q}\Delta(q)\) | Relative deviation from \(Ae^{-c/q}\) |
|---|---:|---:|---:|
| \(1/4\) | \(7.43255800980\times10^{-3}\) | 1.131834351263 | \(2.31413\times10^{-2}\) |
| \(1/8\) | \(4.77188663732\times10^{-5}\) | 1.106570897589 | \(3.03949\times10^{-4}\) |
| \(1/16\) | \(2.05716449236\times10^{-9}\) | 1.106234687749 | \(2.67761\times10^{-8}\) |
| \(1/32\) | \(3.82552245212\times10^{-18}\) | 1.106234658129 | \(1.00625\times10^{-16}\) |

Among those seven DDE cases, from \(q=1/2\) through \(q=1/64\), the largest relative difference between the two discretizations was approximately \(4.1\times10^{-61}\). The additional \(q=1\) row is evaluated separately by its closed form; its zero configuration difference is not evidence of DDE mesh accuracy. Agreement is a numerical consistency check, not a certified error estimate. Neither these calculations nor the constant certificate replaces the analytical proof or the full formal gate.

## Appendix A. Independent spectral bound

This appendix proves (8) by a second route. Restrict \(a\) to \([7/4,2]\), and put \(b=a-1\), \(d_a=e^{c_a}-a=1-a+ac_a\). Then
\[
1<c_a<3/2,\quad d_a\ge1,\quad c_a'\le3/2,\quad e^{c_a}\le4.
\tag{A1}
\]
The original lower bound on the optimal ratio gives
\(0<\Delta\le2^{1-\lfloor T\rfloor}\le4\,2^{-T}\) [R1, Theorem 8], so the relevant parameter belongs to this interval for \(T\ge3\).

Set \(Z_a(t)=e^{c_at}\psi_a'(t)\), taking the right derivative at one, and extend it by zero to negative arguments. With the same probability kernel as above,
\[
Z_a=r_a+k_a*Z_a,
\qquad
r_a(t)=e^{c_at}\left[\frac1{b+t}-\frac1a\log(1+t/b)\right]
\mathbf1_{[0,1)}(t).
\tag{A2}
\]
For \(t\ge1\), this is positive averaging. The initial bounds \(1/2\le Z_a\le20/3\) propagate: the positive part of a bound violation is at most \(\|k_a\|_\infty\) times its preceding integral, and integral Gronwall makes it zero. This also accommodates the derivative jump. In particular the transforms exist on every positive vertical line.

The kernel transform is the entire function
\[
K_a(z)=\frac{e^{c_a-z}-1}{a(c_a-z)},\qquad
K_a(0)=1,\qquad -K_a'(0)=\mu_a=\frac{d_a}{ac_a}.
\]
The apparent singularity at \(z=c_a\) is removable. The only zero of \(1-K_a\) in \(\Re z\ge-1/2\) is its simple zero at zero. Indeed \(\Re z>0\) implies \(|K_a(z)|<1\); on the imaginary axis equality can hold only at zero because the kernel is positive on an interval. For a remaining zero write \(z-c_a=-s+iy\), with \(c_a<s\le c_a+1/2\le2\). It would satisfy
\[
e^s\cos y=1+as>0,\qquad e^s\sin y=ay.
\tag{A3}
\]
For \(y>0\), either \(0<y<\pi/2\) or \(y>2\pi\). The first contradicts \(\tan y/y=a/(1+as)<1\); the second contradicts
\(a|-s+iy|>10.5>1+e^2\). Conjugation handles negative \(y\); a real zero would require \(s=c_a\). Multiplication by the removable denominator introduces a spurious root at \(z=c_a\), where actually \(K_a(c_a)=1/a\).

Let \(R_a\) transform \(r_a\), and subtract the compact forcing:
\[
F_a(z)=\frac{R_a(z)K_a(z)}{1-K_a(z)}.
\tag{A4}
\]
Compact-support integration by parts makes both numerator factors \(O(|\Im z|^{-1})\) in fixed vertical strips. Thus \(F_a=O(|\Im z|^{-2})\) away from the pole. Its inverse is the continuous function \(k_a*Z_a\). Fourier inversion and a rectangular contour shift to \(\Re z=-1/2\), whose horizontal contributions vanish, give for \(t>1\)
\[
Z_a(t)=M_a+\frac1{2\pi i}\int_{-1/2-i\infty}^{-1/2+i\infty}
e^{zt}F_a(z)dz,
\qquad M_a=\frac{R_a(0)}{\mu_a}.
\tag{A5}
\]
Subtracting the forcing is necessary for this ordinary absolutely integrable inversion: \(Z_a\) itself can jump at one, so its transform need not decay quadratically. The convolution is continuous because the kernel is integrable and the tilted derivative is locally bounded. On a positive vertical line it is also exponentially integrable. In the closed strip, the compact-support transforms have uniform large-frequency bounds; after excluding the single pole, the contour deformation therefore has no additional residues or unresolved horizontal tails.

Here are quantitative bounds for that integral. Put \(r=c_a+1/2\in[3/2,2]\) and
\(N_a(y)=1+a(r-iy)-e^{r-iy}\). Then
\[
|N_a(y)|\ge1/10\quad(y\in\mathbb R),\qquad
|N_a(y)|\ge|y|\quad(|y|\ge12).
\tag{A6}
\]
For \(0\le y\le1/4\), \(e^r-1-ar\ge1/2\) and
\(e^r(1-\cos y)\le4y^2\le1/4\), so \(\Re N_a\le-1/4\).
For \(1/4\le y\le\pi/2\), use \(\sin y\ge3y/5\) and \(e^r>4\) to get \(\Im N_a\ge2y/5\ge1/10\).
For \(\pi/2\le y\le3\pi/2\), the real part exceeds one. For \(3\pi/2\le y\le2\pi\), the imaginary part has magnitude at least \(ay\). Beyond \(2\pi\), use \(|N_a|\ge ay-(1+e^r)>1\); for \(y\ge12\), \((7/4)y-9\ge y\). Conjugation proves the other half-line.

The bracket in (A2) is nonnegative, decreasing, at most \(4/3\), and has derivative magnitude below three. Applying integration by parts to its product with \(e^{rt}\) therefore gives
\[
|R_a(-1/2+iy)|\le11,\qquad
|R_a(-1/2+iy)|\le64/|y|\quad(y\ne0).
\]
Equations (A4)–(A6) yield \(|F_a|\le990\) for \(|y|\le12\) and \(|F_a|\le576/y^2\) otherwise. Hence
\[
|Z_a(t)-M_a|
\le\frac{24\cdot990+96}{2\pi}e^{-t/2}
<4000e^{-t/2}.
\tag{A7}
\]
Evaluation of the residue by integration by parts gives
\[
M_a=\frac{e^{c_a}}{d_a}
\int_0^1\frac{e^{c_av}-1}{b+v}\,dv=c_aC_a,
\]
agreeing with (18). Since \(M_a\ge1/2\), integrating (A7) to infinity proves
\[
D_a(t)=C_ae^{-c_at}(1+\varepsilon_a(t)),
\qquad |\varepsilon_a(t)|\le8000e^{-t/2},
\qquad C_a\ge1/3.
\tag{A8}
\]
The limit used in this integration follows either from (9) and integrability of \(\psi_a'\), or from Section 3.

It remains to freeze the parameter with explicit constants. Write
\[
P(a)=(a-1)C_a=U(a)J(a),\quad
U(a)=\frac{(a-1)e^{c_a}}{c_ad_a},\quad
J(a)=\int_0^1\frac{e^{c_av}-1}{a-1+v}\,dv.
\]
On the current interval, \(J\le4\), \(U\le4\), and
\[
|J'|\le\frac{24}{7}+\frac{16}{3}=\frac{184}{21}<10.
\]
For the first term use \(v/(a-1+v)\le1/a\), \(c_a'\le3/2\), and \(e^{c_av}\le4\); the second uses \(e^{c_av}-1\le3\) and \((a-1)^{-2}\le16/9\). Also
\[
|U'/U|\le4/3+3/2+3/2+7/2<8,
\]
since \(0<d_a'=c_a-1+ac_a'\le7/2\). Thus \(|P'|\le168\), and, as \(P(2)=A\ge1/3\),
\[
|P(a)/A-1|\le2016\,2^{-T},\qquad
0\le(c-c_a)T\le6T2^{-T}.
\]
For \(T\ge20\), divide (19) with (A8) by \(Ae^{-cT}\), expand its three factors, and obtain
\[
\left|\frac{\Delta}{Ae^{-cT}}-1\right|
\le8064\,2^{-T}+24T2^{-T}+8000e^{-T/2}.
\]
Finally \(2^{-T}\le e^{-T/2}\) and \(T2^{-T}\le2e^{-T/2}\), proving (8). This estimate emphasizes an explicit uniform rate; its numerical coefficient is not optimized.

## 9. Verification and scope

The mathematical proof is self-contained after the cited source bridge. The two convergence arguments agree on the exact amplitude, and the rational certificate and numerical calculations have distinct, stated scopes. A complete Lean formalization of the source-model bridge, averaging equation, asymptotic estimate, and distributional corollaries has not been completed. Thus this draft remains a private research archive under the repository's publication gate.

We do not claim a full elementary formula for the optimal ratio at arbitrary \(q\), a new solution of the original optimization problem, a new exponent, or a theorem for other risk criteria. The estimates quantify one high-risk regime and provide explicit information about its optimal distribution. The bounded novelty search is documented separately; no worldwide priority or external acceptance is asserted.

## References

**[R1]** Nicolas Christianson, Bo Sun, Steven Low, and Adam Wierman. *Risk-Sensitive Online Algorithms*. arXiv:2405.09859v2, 2024. [Full version](https://arxiv.org/html/2405.09859v2). Extended abstract in *Proceedings of the Thirty-Seventh Conference on Learning Theory*, PMLR 247:1140–1141. [Conference record](https://proceedings.mlr.press/v247/christianson24a.html).

**[R2]** *Exact risk phases in discrete ski rental*. Research manuscript, 2026, Section 8, Theorem 7. [Related manuscript](../risk-sensitive-ski-rental/paper.en.md)

**[R3]** Michael Dinitz, Sungjin Im, Thomas Lavastida, Benjamin Moseley, and Sergei Vassilvitskii. *Controlling Tail Risk in Online Ski-Rental*. arXiv:2308.05067v1, 2023. [Full text](https://arxiv.org/html/2308.05067v1).

**[R4]** Spyros Angelopoulos, Christoph Dürr, and Georgii Melidi. *Decision-Theoretic Approaches for Improved Learning-Augmented Algorithms*. arXiv:2501.17701v2, 2025; conference version listed at ICLR 2026. [Inspected full text](https://arxiv.org/html/2501.17701v2); [official conference PDF](https://openreview.net/pdf?id=XGEZ9q02Ys).
