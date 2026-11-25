---
title: "The weak-response frequency boundary for reversible Markov environments"
lang: en
geometry: margin=0.85in
---

# Abstract

Consider annealed growth of a positive linear system with finite spatial migration and a reversible Markov environment that selects a weak diagonal potential. We give a necessary and sufficient condition on the spatial generator for the quadratic growth response to be nonincreasing in switching speed for every reversible environment. On the spatial mean-zero space, write the negative generator as \(H+K\), with \(H\) selfadjoint and \(K\) skew-adjoint. The criterion is \(H^2+K^2\) positive semidefinite. We also identify the exact speed above which all such quadratic derivatives have the decreasing sign. If the criterion fails, a symmetric two-state environment produces an interior global growth maximum for every sufficiently small nonzero amplitude. A three-site example with real spatial eigenvalues shows that a condition only on their locations does not suffice for nonnormal migration.

# 1. Model and results

Let \(Q\) be a finite irreducible spatial Markov generator in row convention, with stationary law \(\pi\). A finite irreducible environment with row generator \(G\) has stationary law \(\nu\) and is reversible with respect to \(\nu\). For a real potential \(V(e,i)\), consider the positive linear system with environment-dependent matrices \(Q+\epsilon\operatorname{diag} V(e,\cdot)\) and environment speed \(\omega>0\). Its annealed growth exponent is the Perron eigenvalue of
\[
 L_\omega+\epsilon\operatorname{diag}V,\qquad
 L_\omega=\omega G\otimes I+I\otimes Q .
\]
Indeed, the forward equation for the environment-indexed first moments uses \(G^{\mathsf T}\). By reversibility that operator is diagonally similar to \(G\) with a similarity acting only on the environment index. Thus the displayed Metzler matrix has the same eigenvalues and the same Perron growth exponent for positive initial data.

Write \(\langle\cdot,\cdot\rangle_\pi\) and \(\langle\cdot,\cdot\rangle_{\nu\otimes\pi}\) for the real stationary inner products. On the \(\pi\)-mean-zero space, define
\[
 S=-Q,\qquad H=(S+S^*)/2,\qquad K=(S-S^*)/2 .
\]
The star denotes the adjoint in the \(\pi\) inner product. We have \(H\) positive definite on this space. Define the nonnegative speed scale
\[
 \xi(Q)=\min\{x\ge0:(H+xI)^2+K^2\text{ is positive semidefinite}\}.        \tag{1}
\]
For a single spatial state set \(\xi(Q)=0\).

For a fixed environment and potential, denote the expansion at \(\epsilon=0\) by
\[
 \lambda_\epsilon(\omega)
   =\epsilon\langle 1,V\rangle_{\nu\otimes\pi}
        +\epsilon^2\Phi_V(\omega)+O(\epsilon^3).
\]
Let \(\gamma_{\min}>0\) be the least nonzero eigenvalue of \(-G\) when the environment has at least two states.

**Theorem 1.** For a fixed reversible environment with at least two states and fixed speed \(\omega>0\), the inequality \(\Phi'_V(\omega)\le0\) holds for every real potential \(V\) exactly when
\[
 \omega\gamma_{\min}\ge \xi(Q).
\]
If the inequality in speeds is strict, then \(\Phi'_V(\omega)<0\) for every potential that depends on the environment. In particular universal quadratic frequency reduction holds for all reversible environments and speeds if and only if \(H^2+K^2\) is positive semidefinite, equivalently \(\|K H^{-1}\|\le1\) on the spatial mean-zero space. One fixed symmetric two-state environment already tests this condition.

**Theorem 2.** If \(\xi(Q)>0\), there is a real centered spatial potential \(f\) such that the symmetric two-state environment with gap one and potentials \(+\epsilon f,-\epsilon f\) has a growth exponent whose maximum over speeds is attained at a finite positive speed, strictly above both the zero- and infinite-speed limits, for every sufficiently small nonzero \(\epsilon\). Any such maximizing speed is a strict local maximum.

If \(Q\) is normal in its stationary inner product, (1) simplifies to
\[
 \xi(Q)=\max\left(\{0\}\cup
          \{|\operatorname{Im}z|+\operatorname{Re}z:
                  z\in\operatorname{spec}(Q),\ z\ne0\}\right).
\]
For nonnormal \(Q\), the symmetric matrix in (1) gives a criterion beyond the location of its eigenvalues.

# 2. Quadratic response and the speed criterion

The product generator \(L_\omega\) is irreducible for \(\omega>0\). At \(\epsilon=0\) it has simple eigenvalue zero, right eigenvector \(1\), and stationary left vector \(\nu\otimes\pi\). Normalize the perturbed right eigenvector to have stationary mean one. Its first derivative \(u\) solves
\[
 -L_\omega u=V-\bar V,\qquad
 \langle 1,u\rangle_{\nu\otimes\pi}=0,\qquad
 \bar V=\langle 1,V\rangle_{\nu\otimes\pi}.
\]
Taking stationary means at second order therefore gives
\[
 \Phi_V(\omega)=
   \langle V-\bar V,(-L_\omega)^{-1}(V-\bar V)\rangle_{\nu\otimes\pi}.
 \tag{2}
\]
The inverse is on the product mean-zero space. Simplicity gives analytic perturbation at every positive speed. On a compact positive speed interval the expansion is uniform, also after differentiating once in speed. This follows by local joint analyticity at each positive speed and a finite cover of the interval.

Let \(h_j\) be a real orthonormal environment basis with \(-G h_j=\gamma_j h_j\), \(h_0=1\), and \(\gamma_0=0\). Write \(V(e,i)=\sum_j h_j(e)V_j(i)\), with \(V_j=\mu_j 1+f_j\) and \(f_j\) centered over \(\pi\). The contribution from \(j=0\) in (2) is the constant \(\langle f_0,S^{-1}f_0\rangle_\pi\). For \(j\ge1\) the contribution is
\[
 \frac{\mu_j^2}{\omega\gamma_j}+r_{f_j}(\omega\gamma_j),
 \qquad
 r_f(x)=\langle f,(S+xI)^{-1}f\rangle_\pi.                               \tag{3}
\]
This separation uses that both the constants and the centered space are invariant under \(Q\). The first term in (3) is strictly decreasing if \(\mu_j\ne0\).

For a centered spatial vector, let \(T=S+xI\). Then
\[
 r_f'(x)=-\langle f,T^{-2}f\rangle_\pi.
\]
Write \(\operatorname{Sym}(A)=(A+A^*)/2\) for the symmetric part. Congruence by the invertible \(T^2\) gives
\[
 (T^*)^2 \operatorname{Sym}(T^{-2}) T^2
   =\operatorname{Sym}(T^2)=(H+xI)^2+K^2.                                 \tag{4}
\]
In the final equality the mixed terms are skew-adjoint. Hence \(r_f'(x)\le0\) for every centered \(f\) exactly when the last matrix is positive semidefinite. For the claim of invertibility and monotonicity, use
\[
 \langle v,Hv\rangle_\pi
      =\frac12\sum_{i,j}\pi_i Q_{ij}(v_j-v_i)^2,
\]
which is strictly positive for a nonzero centered vector by irreducibility. In particular \(T\) is invertible for \(x\ge0\). The symmetric family on the right of (4) increases strictly in positive-definite order, since its increment from \(x_1\) to \(x_2>x_1\) equals \(2(x_2-x_1)H+(x_2^2-x_1^2)I\). It becomes positive definite for sufficiently large \(x\). This justifies (1) including attainment of the minimum.

If \(\omega\gamma_{\min}\ge\xi(Q)\), all derivatives in (3) are nonpositive. If \(\omega\gamma_{\min}>\xi(Q)\), each spatial test with a nonzero centered coefficient has a strict derivative, so any genuine environment dependence gives strictness. If \(\omega\gamma_{\min}<\xi(Q)\), take a real \(v\) with negative quadratic form for the last matrix in (4) at \(x=\omega\gamma_{\min}\) and set \(f=T^2v\). By (4), \(r_f'(x)>0\). Put this \(f\) in an environment mode of eigenvalue \(\gamma_{\min}\) and let all other modes vanish. Its \(\Phi'_V(\omega)\) is positive, proving necessity.

In particular the condition holds at every positive speed exactly when it holds at \(x=0\) by closedness. Since \(K^2=-K^*K\), this is \(\|Kv\|\le\|Hv\|\) for every centered \(v\), which is the stated norm condition. A two-state environment with gap one permits the same test at any positive speed. In the case of one spatial state, only the constant spatial terms in (3) remain, and they give the claimed nonincrease directly. If the potential is independent of the environment then the exact exponent, as well as (2), is independent of \(\omega\). In every compact speed interval on which \(\Phi'_V\) is strictly negative, the exact derivative is negative for all sufficiently small nonzero amplitudes by the uniform differentiated expansion.

If \(Q\) is normal, \(H\) and \(K\) commute and may be diagonalized simultaneously over the complexification. A mode with spatial eigenvalue \(z=-\alpha+i\beta\) contributes the condition \((\alpha+x)^2-\beta^2\ge0\), yielding the displayed formula for \(\xi(Q)\). For example, an equal-rate directed spatial cycle on \(n\ge3\) sites has nonzero modes proportional to \(e^{2\pi i j/n}-1\). The scale is positive exactly when one mode has \(|\sin(2\pi j/n)|>1-\cos(2\pi j/n)\), which occurs exactly for \(n\ge5\). Uniform directed cycles on three or four sites therefore satisfy the weak criterion despite their irreversibility.

# 3. A reversible two-state environment with an actual resonance

Assume \(\xi(Q)>0\). Choose a centered real \(v\) with \(\langle v,(H^2+K^2)v\rangle_\pi<0\) and set \(f=S^2v\). Then
\[
 r_f'(0)=-\langle f,v\rangle_\pi>0,\qquad r_f(0)>0.
\]
Positivity of \(r_f(0)\) follows from
\(\operatorname{Sym}(S^{-1})=(S^*)^{-1}H S^{-1}\), which is positive definite. Fix a speed \(\omega_0>0\) with \(r_f(\omega_0)>r_f(0)\).

Take the two-state environment with transition rates \(1/2\) in both directions. Its gap is one and its nonconstant normalized eigenfunction takes the values \(+1,-1\). Use potentials \(+\epsilon f\) and \(-\epsilon f\). At every fixed positive speed,
\[
 \lambda_\epsilon(\omega)=\epsilon^2 r_f(\omega)+O(\epsilon^3).
\]
At zero speed the block matrix converges to the direct sum of \(Q+\epsilon\operatorname{diag} f\) and \(Q-\epsilon\operatorname{diag} f\). Their Perron eigenvalues both equal \(\epsilon^2r_f(0)+O(\epsilon^3)\) by centeredness and the perturbation formula. Therefore the slow endpoint has this expansion, by continuity of the finite-dimensional spectral abscissa.

For the fast endpoint, pass to the symmetric and antisymmetric coordinates of the environment-indexed eigenvector. Write \(D_f=\operatorname{diag}f\), let \(u\) be the positive symmetric component, and let \(w\) be the antisymmetric one. The eigenvalue equations give
\[
 \lambda_\epsilon(\omega)u=Q u+\epsilon D_f w,\qquad
 w=\epsilon[(\omega+\lambda_\epsilon(\omega))I-Q]^{-1}D_f u
\]
for all sufficiently large \(\omega\). Indeed, the Perron eigenvalue is bounded by \(|\epsilon|\max_i|f_i|\) using the row sums, so the inverse exists and has norm \(O(1/\omega)\). Normalize \(u\) by \(\langle 1,u\rangle_\pi=1\), which bounds its coordinates. Pairing the first equation with \(\pi\) then gives \(\lambda_\epsilon(\omega)=O(\epsilon^2/\omega)\). The fast endpoint is zero.

At \(\omega_0\) the exponent is strictly above both endpoints for all sufficiently small nonzero \(\epsilon\), by the strict quadratic inequalities. Continuity and the two endpoint limits imply that it attains a global maximum at finite positive speed. The exponent is real analytic for positive speeds because its Perron eigenvalue is simple. It is nonconstant because it exceeds the endpoints. Consequently every maximizing speed is isolated among equal values in a neighborhood and is a strict local maximum. This proves Theorem 2.

# 4. A real-spectrum three-site example

Use the directed three-site cycle with rates \(9,1,1\) around the cycle:
\[
 Q=\begin{pmatrix}-9&9&0\\0&-1&1\\1&0&-1\end{pmatrix},
 \qquad \pi=(1,9,9)/19 .
\]
The two nonzero eigenvalues are real, since the polynomial of \(S\) on the centered space is \(s^2-11s+19\) with discriminant \(45\). Let \(v=(0,1,-1)\) and \(f=S^2v=(-99,3,8)\). They are centered and \(\langle f,v\rangle_\pi=-45/19\), so \(r_f'(0)=45/19>0\). More explicitly, the characteristic polynomial gives
\[
 r_f(x)=\frac{873+(10458/19)x}{x^2+11x+19},\qquad
 r_f(x)-r_f(0)=
       \frac{45x-(873/19)x^2}{x^2+11x+19}.
\]
The speed \(x=1/2\) is an exact witness of improvement over the slow coefficient, and the construction in Section 3 applies. This uses three spatial states and two environment states. A two-state spatial generator is reversible and cannot fail the weak-response condition. With one environment state there is no switching.


For a concrete finite amplitude, take \(\epsilon=10^{-8}\). There is an exact positive-vector certificate that both frozen Perron roots are below \(46\epsilon^2\) and the speed-\(1/2\) root is above it. For each of the three generators \(L\) and centered potentials \(W\) in these comparisons, solve the centered linear equations
\[
 L u_1=-W,\qquad
 L u_2=\langle W,u_1\rangle\,1-Wu_1,
\]
where the product \(Wu_1\) is coordinatewise and the inner product uses the appropriate stationary law. Set \(U=1+\epsilon u_1+\epsilon^2u_2\). The companion rational script checks \(U>0\). For both frozen modes it checks every entry of \(((L+\epsilon\operatorname{diag}W)U-46\epsilon^2U)/\epsilon^2\) is below \(-1/20\); at speed \(1/2\) every entry exceeds \(1/3\). Pairing these vectors with the positive left Perron vector proves the three root comparisons. Together with the fast endpoint this certifies an actual interior maximum at this finite amplitude.

The criterion also applies around a fixed common spatial potential \(D_0\). Let \(\lambda_0\) be the Perron eigenvalue and \(h>0\) a corresponding eigenvector, so \((Q+D_0)h=\lambda_0 h\). Define
\[
 \widetilde Q=\operatorname{diag}(h)^{-1}(Q+D_0-\lambda_0 I)
                      \operatorname{diag}(h).
\]
The matrix \(\widetilde Q\) is an irreducible row generator. The similarity leaves every diagonal environmental potential unchanged, and the original growth exponent differs from the transformed one by \(\lambda_0\). The criterion uses the stationary law of \(\widetilde Q\). For a directed three-cycle with positive rates, the transform can prescribe any target rates of the same product: choose the adjacent ratios of \(h\) equal to the target-to-original rate ratios and set each diagonal entry of \(D_0\) to the original rate minus its target. In particular even a uniform directed three-cycle can realize the real-spectrum resonance after a common spatial baseline shift.

# 5. Pinned comparison and scope

The pinned detailed-balance classification allows arbitrary environments and builds a converse with a directed cyclic environment. Its companion shows frequency reduction for simultaneously symmetrizable spatial matrices even with irreversible switching. The result here isolates the reversible-environment restriction and gives an exact condition for the weak quadratic response, a sharp speed test, and actual resonances with two symmetric environment states on the failing side. The nonincrease criterion on the other side concerns the quadratic coefficient and its implications on compact positive speed bands. The comparison is to the pinned repository manuscripts.
