---
title: "Single-frequency identification of a reflected diffusion from weak Floquet response"
lang: en
---

# Single-frequency identification of a reflected diffusion from weak Floquet response

## Abstract

We recover the diffusion tensor and the irreversible drift of a smooth, uniformly elliptic reflected diffusion from its quadratic Floquet responses at a single prescribed positive frequency. The spatial driving can use two phases. We take the stationary density as known, or recover it from a static first variation. The inverse of the measured response operator is the reversible elliptic operator plus a bounded correction. Localized oscillatory tests therefore identify its principal coefficients. An imaginary part of the same inverse satisfies a Sylvester equation and identifies the irreversible transport. Operator-norm noise of size \(e\) gives errors of order \(e^{1/4}\) for fixed localized tensor averages and, when the reversible part is known, of order \(e^{1/3}\) for fixed drift matrix elements. Real spatial modulations in a single phase cannot distinguish a nonreversible diffusion from its stationary time reversal.

## 1. Model and information available

Let \(\Omega\subset\mathbb R^d\) be a bounded connected domain with smooth boundary. Let \(a\) be a smooth real symmetric uniformly positive definite tensor on its closure, and let \(\pi=\rho\,dx\) be a smooth strictly positive invariant probability on the closure. Consider the reflecting generator
\[
L f=\rho^{-1}\operatorname{div}(\rho a\nabla f)+c\cdot\nabla f,
\qquad \nu\cdot a\nabla f=0\text{ on }\partial\Omega.
\]
Here \(c\) is smooth real transport, \(\operatorname{div}(\rho c)=0\), and \(\nu\cdot c=0\) on the boundary. In the convention \(L=\operatorname{div}(a\nabla)+b\cdot\nabla\), the drift is \(b=a\nabla\log\rho+c\). In nondivergence form \(L=a:D^2+b_{\rm Ito}\cdot\nabla\), the drift is \(b_{\rm Ito}=\operatorname{div}a+a\nabla\log\rho+c\), with divergence on the tensor columns. We use the Hilbert-space inner product conjugate-linear in its first argument.

At a prescribed \(\omega>0\) and for a smooth complex spatial amplitude \(z\), drive the system with the real potential \(\varepsilon\operatorname{Re}(z(x)e^{i\omega t})\). The data are the coefficients \(\beta_z(\omega)\) of \(\varepsilon^2\) in the principal Floquet growth rate near amplitude zero. This uses arbitrary real cosine and sine spatial profiles, since the real and imaginary parts of \(z\) can be chosen independently. The phase and frequency are known. Such data are a quadratic functional at \(\omega\) evaluated on smooth amplitudes, not a finite collection of measurements.

Write \(\mathcal H=L^2_0(\pi;\mathbb C)\) for the mean-zero space. For \(z\in\mathcal H\), the pinned reflecting-diffusion theorem [1, Section 2] gives
\[
\beta_z(\omega)=\tfrac12\operatorname{Re}\langle z,(-L+i\omega)^{-1}z\rangle_\pi . \tag{1}
\]
We may always subtract the known mean before choosing \(z\). Equation (1) follows by expanding the normalized periodic eigenfunction and solving the first-order forced equation at the driving frequency. Integrating the second-order equation against the invariant law and over a period leaves the mean product of the first perturbation and the drive. That product yields the factor \(1/2\).

**Theorem 1 (exact identification).** With \(\pi\) known, the data in (1) at one prescribed \(\omega>0\) determine \(a\) and \(c\), including their boundary values by continuity. If \(\pi\) is initially unknown, the first variation of the principal spectral value of \(L+\varepsilon V\) at zero, for smooth real static potentials \(V\), determines \(\pi\). The same one-frequency data then determine \(a,c\).

Recovery uses localized oscillations to read \(a\), followed by a Sylvester equation to read \(c\). We give both procedures below.

**Theorem 2 (stability for specified functionals).** Let \(B\) be the response operator determined by \(\langle z,Bz\rangle_\pi=2\beta_z(\omega)\). Suppose one has a bounded Hermitian estimate \(\widetilde B\) on \(\mathcal H\), with \(\|\widetilde B-B\|\le e\), \(0<e\le1/4\). For a fixed smooth, compactly supported real function \(\psi\) and vector \(\xi\in\mathbb R^d\), the procedure in Section 5 estimates
\[
\int_\Omega \psi(x)^2\,\xi^{\mathsf T}a(x)\xi\,d\pi(x)
\]
to error \(O(e^{1/4})\). If the reversible operator is known, it estimates each fixed matrix element of the irreversible transport operator in a real reversible eigenbasis to error \(O(e^{1/3})\). The constants may depend on the fixed generator, frequency, and test functions or modes.

## 2. Inverse response as an elliptic form

On \(\mathcal H\) write \(A=-L=S+K\), with \(S=-\rho^{-1}\operatorname{div}(\rho a\nabla)\) in its reflecting realization and \(K=-c\cdot\nabla\). The form of \(S\) has domain \(\mathcal V=H^1(\Omega;\mathbb C)\cap\mathcal H\) and is
\[
\mathfrak s(u,v)=\int_\Omega (\nabla\overline u)^{\mathsf T}a\nabla v\,d\pi .
\]
Uniform ellipticity and the Poincaré inequality on the mean-zero space give \(S\ge\gamma I\) for some \(\gamma>0\). The compact embedding of \(H^1\) into \(L^2\) gives compact resolvent. Integration by parts using the stationary flux conditions makes \(K\) skew-symmetric on \(\mathcal V\). It is bounded from \(\mathcal V\) with its form norm into \(\mathcal H\), since \(|c|\) is bounded and \(K\) has zero stationary mean. Define
\[
P=S^{-1},\qquad W=S^{-1/2}K S^{-1/2},\qquad F=I+W+i\omega P .
\]
The operator \(W\) is bounded skew-adjoint on \(\mathcal H\), by the form integration by parts. The operator \(F\) is an identity plus a bounded skew-adjoint operator. It and its adjoint are bounded below by one and have closed range, so each is invertible. Testing the form equation for \(A+i\omega\) against elements of \(\mathcal V\) gives
\[
R=(A+i\omega)^{-1}=S^{-1/2}F^{-1}S^{-1/2}. \tag{2}
\]
The weak form realizes the given reflecting generator. Its conormal boundary condition is the natural condition of \(\mathfrak s\), and \(K\) contributes an interior transport term with zero boundary flux.

Complex polarization in (1) identifies the bounded Hermitian operator \(B=(R+R^\dagger)/2\) on \(\mathcal H\), since smooth mean-zero functions are dense. In form notation,
\[
B=(S^{1/2}R)^\dagger(S^{1/2}R)=S^{-1/2}(FF^\dagger)^{-1}S^{-1/2}. \tag{3}
\]
For the first identity, the weak equations for \(R\) show \((R+R^\dagger)/2=R^\dagger S R\) in the form sense, since the two skew terms cancel. Equivalently, substitute (2) and use \(F+F^\dagger=2I\). The second identity follows by multiplying the bounded factors. Thus \(B\) is positive, injective and compact.

Let \(T=K S^{-1/2}\) and \(U=K S^{-1}\) on \(\mathcal H\), both bounded. The inverse to \(B\) has closed form domain \(\mathcal V\), and its quadratic form is
\[
\mathfrak q(u,v)=\langle S^{1/2}u,FF^\dagger S^{1/2}v\rangle_\pi
=\mathfrak s(u,v)+\langle u,Cv\rangle_\pi ,
\]
where the bounded Hermitian correction is
\[
C=TT^\dagger+\omega^2 S^{-1}-i\omega(U-U^\dagger). \tag{4}
\]
Indeed \(FF^\dagger=I-(W+i\omega P)^2\). Expanding it between the two \(S^{1/2}\) factors gives (4), with \(-KS^{-1}K\) represented by \(TT^\dagger\) and \(S^{-1}K\) by \(-U^\dagger\). These identities are first checked on \(\mathcal V\) by pairing and then extended by boundedness. This interpretation requires skew-symmetry of the transport on the form domain and does not require a separate skew-adjoint realization of \(K\).

For completeness, \(FF^\dagger\ge I\) shows that \(\mathfrak q\) is closed on \(\mathcal V\). For any \(y\in\mathcal H\), (3) gives \(By\in\mathcal V\), and
\(\mathfrak q(v,By)=\langle v,y\rangle_\pi\) for every \(v\in\mathcal V\). Thus \(B\) is the inverse of the operator associated with \(\mathfrak q\). The bounded perturbation in (4) gives that operator as \(S+C\) with domain \(D(S)\). The spectral form of \(B^{-1}\) is consequently the stated form, independent of prior knowledge of \(S\). In particular it can be computed from \(B\) on its form domain, for example by the limit of regularized inverses used below.

## 3. Recovering the tensor and transport

### 3.1. Localized tensor averages

Fix smooth real \(\psi\) compactly supported in \(\Omega\), a real vector \(\xi\), and a positive \(t\). Let \(g_t=\psi e^{it\xi\cdot x}-\int_\Omega\psi e^{it\xi\cdot x}\,d\pi\), so that \(g_t\in\mathcal H\). The function before mean subtraction vanishes near the boundary, and the subtracted constant has zero gradient. Thus \(g_t\in D(S)\). The real tensor \(a\) is symmetric and \(\psi\) is real, so the two mixed terms cancel in the \(\mathfrak s\) energy. The norm \(\|g_t\|\) is bounded uniformly in \(t\). Equation (4) now gives
\[
t^{-2}\mathfrak q(g_t,g_t)
=\int_\Omega \psi^2\,\xi^{\mathsf T}a\xi\,d\pi+O(t^{-2})\qquad(t\to\infty). \tag{5}
\]
Thus the single-frequency operator determines this integral for every such \(\psi,\xi\). By continuity and localization, the values determine \(x\mapsto\xi^{\mathsf T}a(x)\xi\) in the interior for each \(\xi\). For example, if a continuous difference were positive somewhere, a nonzero \(\psi\) supported in that region would give a positive integral. Polarizing in \(\xi\) determines all tensor entries, and continuity determines their boundary values. With \(a,\rho\) known, the reflecting operator \(S\) and its form norm are determined.

### 3.2. Transport from the imaginary part

Choose a real orthonormal eigenbasis \(\phi_i\) of the positive operator \(S\) on \(\mathcal H\), with eigenvalues \(\lambda_i>0\), repeated according to multiplicity. Such a basis exists since \(S\) is real with compact resolvent. The terms \(\mathfrak s\), \(TT^\dagger\), and \(\omega^2 S^{-1}\) in (4) are real on real vectors. The only imaginary term there gives
\[
\operatorname{Im}\mathfrak q(\phi_i,\phi_j)
=-\omega(\lambda_i^{-1}+\lambda_j^{-1})\langle\phi_i,K\phi_j\rangle_\pi . \tag{6}
\]
To see the sum of inverse eigenvalues, \(U\phi_j=\lambda_j^{-1}K\phi_j\), and \(U^\dagger\) equals \(-S^{-1}K\) on \(\mathcal V\). The coefficient multiplying each matrix element is nonzero, including within an eigenspace of repeated eigenvalue.

Equation (6) determines \(K\) on finite eigenfunction sums. Those sums are dense in \(\mathcal V\) in the form norm, and \(K:\mathcal V\to\mathcal H\) is bounded. Therefore the entries determine the transport on \(\mathcal V\). To recover \(c_j\) on an interior ball, choose a smooth compactly supported function equal to \(x_j\) on that ball and subtract its stationary mean. On the ball its image under \(K\) is \(-c_j\). Smoothness recovers the vector field everywhere on the closure. This concludes the reconstruction of \(a,c\).

If \(\pi\) is unknown, the unperturbed principal eigenvalue of \(L\) is the simple eigenvalue zero with right eigenfunction \(1\). The left invariant law is \(\pi\), normalized to mass one. Differentiating the principal eigenvalue equation under a static bounded perturbation \(\varepsilon V\) and integrating against \(\pi\) gives the first variation \(\int_\Omega V\,d\pi\). Knowledge of this functional on smooth real \(V\) determines \(\pi\). This proves Theorem 1.

## 4. Why two phases are informative

Let \(L^\dagger\) be the adjoint in \(L^2(\pi)\), which reverses \(c\) and keeps \(a,\rho\) fixed. Its mean-zero resolvent at \(+\omega\) is \((A^\dagger+i\omega)^{-1}\), the adjoint of \((A-i\omega)^{-1}\). The coefficients of \(A\) are real, so that \((A-i\omega)^{-1}\) is the complex conjugate of \(R\). The response operator of \(L^\dagger\) is therefore the complex conjugate of \(B\). For real \(z\), the quadratic data in (1) are identical for the two generators. They also coincide if a real spatial amplitude is given a common phase, because multiplication of all of \(z\) by one unimodular scalar leaves its quadratic value unchanged.

For a concrete pair, take the unit disk with \(a=I\), uniform invariant density, and transport \(c(x_1,x_2)=(-x_2,x_1)\). Its divergence is zero and it is tangent to the reflecting boundary. The opposite rotation gives a distinct reflected diffusion with exactly the same one-phase quadratic data at every frequency. The complex polarization in Theorem 1 uses the relative spatial phases that separate this pair.

## 5. Regularized estimates

Let \(0<e\le1/4\) and \(\delta\ge2e\). Then \(B+\delta I\ge\delta I\), and \(\widetilde B+\delta I\ge(\delta-e)I\). Define the regularized measured form
\[
\widetilde{\mathfrak q}_\delta(x,y)=\langle x,(\widetilde B+\delta I)^{-1}y\rangle_\pi .
\]
The resolvent identity bounds the operator difference of the regularized noisy and exact inverses by \(2e/\delta^2\). For \(x,y\in D(S)=D(B^{-1})\), the spectral bias identity is
\[
\langle x,[(B+\delta I)^{-1}-B^{-1}]y\rangle_\pi
=-\delta\langle B^{-1}x,B(B+\delta I)^{-1}B^{-1}y\rangle_\pi .
\]
The middle factor is a contraction. Therefore
\[
|\widetilde{\mathfrak q}_\delta(x,y)-\mathfrak q(x,y)|
\le\frac{2e}{\delta^2}\|x\|\|y\|+\delta\|B^{-1}x\|\|B^{-1}y\|. \tag{7}
\]

For \(g_t\) in (5), the second-order differential expression for \(S\) and the boundedness of \(C\) give \(\|B^{-1}g_t\|\le C_{\psi,\xi}(1+t^2)\). Here coefficient bounds and the norm of the fixed correction enter the constant. For \(t\ge1\), dividing (7) by \(t^2\) and including the residual term in (5) bounds the tensor-average error by a constant times
\[
t^{-2}+\frac{e}{\delta^2 t^2}+\delta t^2 .
\]
Taking \(t=e^{-1/8}\) and \(\delta=e^{1/2}\) makes the error \(O(e^{1/4})\). This recovers a fixed localized average, with a constant depending on its localization, and does not assert uniform pointwise recovery in noise.

When \(S\) is known, apply (7) to the fixed modes \(\phi_i,\phi_j\) and take \(\delta=e^{1/3}\). It is at least \(2e\) on the stated range. This yields an \(O(e^{1/3})\) error in the imaginary part in (6). The error in the estimated matrix element of \(K\) is bounded by this error divided by \(\omega(\lambda_i^{-1}+\lambda_j^{-1})\). This proves Theorem 2. It leaves open rates of recovery in strong norms jointly for unknown \(a\) and \(c\).

## 6. Source comparison and scope

The pinned work [1] establishes the reflecting model, the weak Floquet formula (1), and a fixed-frequency criterion for detailed balance. It does not identify the diffusion tensor or drift from those measurements. The inverse identity (4) separates an unbounded, local second-order part from bounded corrections. Locality makes one frequency sufficient to determine the tensor, even though a general scalar reversible resolvent response \(s/(s^2+\omega^2)\) is invariant under \(s\mapsto\omega^2/s\). After \(S\) is recovered, (6) extracts the direction and magnitude of irreversible transport. The results concern the quadratic Floquet functional for smooth deterministic periodic potentials with controllable spatial phase.

## Reference

1. *Frequency classification of reflected diffusions under periodic and Markov switching* (Chinese manuscript), earlier research manuscript at  (archived version), especially Sections 1–2.
