---
title: "Which scalings of a rank-two quantum first-passage kernel are realizable?"
lang: en
---

# Which scalings of a rank-two quantum first-passage kernel are realizable?

## Abstract

We classify every positive scaling of a Choi-rank-two completely positive map that can be realized as the one-count kernel of finite-dimensional monitored Lindblad dynamics at a fixed positive Laplace point. The feasible scales form either the empty set, a singleton, or an interval starting at zero. The trace contraction gives an open outer bound, but an interval can end strictly before that bound, at an included endpoint. We give explicit tests for all rank-two maps, including maps whose Kraus space contains no invertible operator. The key reduction represents the no-jump generator by a \(2\times2\) matrix in the algebra of coordinate actions preserving the stacked Kraus range. A positive Lyapunov equation and Choi positivity then admit a separate solution for each possible algebra. Examples exhibit an isolated positive scale and two kinds of strict interval cutoff.

## 1. Model and statement

Work on a finite-dimensional complex Hilbert space \(\mathcal H\). In the all-count model, every jump contributes one to the count. Write \(J(X)=\sum_i L_iXL_i^\dagger\), \(G=J^*(I)\), and \(Q=iH+G/2\), with \(H=H^\dagger\). The star on a map is its Hilbert–Schmidt adjoint. For a fixed \(s>0\), define
\[
A_s(X)=sX+QX+XQ^\dagger,\qquad R_s=J A_s^{-1}.
\]
The no-jump propagator and its Laplace integral give \(A_s^{-1}(X)=\int_0^\infty e^{-st}e^{-Qt}X e^{-Q^\dagger t}\,dt\). In particular \(\operatorname{tr}(R_s^k(\rho))\) is the ordinary Laplace transform of the time of the \(k\)th count, with \(e^{-s\infty}=0\) [1].

Fix a completely positive map \(R_0\) with Choi rank two. Put \(B_0=R_0^*(I)\) and \(q_{\mathrm{tr}}=\|B_0\|^{-1}\). The earlier inverse theorem gives an exact semidefinite feasibility test over a Hermitian \(H\) for each proposed \(qR_0\). It also treats full Choi rank near zero and classifies Choi rank one [1, Theorems 1–2].

**Theorem 1.** For a Choi-rank-two map \(R_0\), the set of \(q>0\) for which \(qR_0=R_s\) is one of the following four forms.
\[
\varnothing,\qquad \{q_*\},\qquad (0,q_{\mathrm{tr}}),\qquad (0,q_*],\quad 0<q_*<q_{\mathrm{tr}} .
\]
The algebra of right multipliers of the Kraus space on its active input subspace determines the tests in Sections 3–5. Apart from the trace-admissibility test and linear algebra, the tests use scalar equations of degree at most four. Only the two-dimensional algebra cases can give an isolated scale. All four types are attained. The set is independent of \(s>0\).

An inverse realization at any feasible scale can be recovered from the same formulas. Its jump map has Choi rank at most two. Equality holds when the \(2\times2\) positivity test is strict.

## 2. Reduction to the Kraus range

Take a minimal linearly independent Kraus pair \(V_1,V_2\) for \(R_0\) and write \(\mathcal S=\operatorname{span}\{V_1,V_2\}\). Let \(\mathcal K=\bigcap_i\ker V_i\) and \(\mathcal P=\mathcal K^\perp\). We identify the Kraus operators with maps from \(\mathcal P\) to \(\mathcal H\) after restricting their input. The restriction of \(B_0\) to \(\mathcal P\) is positive definite; in expressions on \(\mathcal P\) we use the same symbol. Define
\[
F:\mathcal P\to\mathbb C^2\otimes\mathcal H,\qquad Fx=(V_1x,V_2x).
\]
The map \(F\) is invertible onto its range \(\mathcal U\) and \(F^\dagger F=B_0\) on \(\mathcal P\). Put
\[
E=(FF^\dagger|_{\mathcal U})^{-1},\qquad
\mathcal A=\{M\in M_2(\mathbb C):(M\otimes I)\mathcal U\subseteq\mathcal U\}.
\]
For \(M\in\mathcal A\), let \(\widehat M=(M\otimes I)|_{\mathcal U}\); its adjoint is taken in the Hilbert structure of \(\mathcal U\).

**Lemma 2.** For \(0<q<q_{\mathrm{tr}}\), \(qR_0\) is realizable if and only if some \(M\in\mathcal A\) satisfies
\[
(E-qI)\widehat M+\widehat M^\dagger(E-qI)=s q I_{\mathcal U},
\qquad sI_2+M+M^\dagger\succeq0 . \tag{1}
\]
The right multipliers \(Q\) on \(\mathcal P\) satisfying \(\mathcal S Q\subseteq\mathcal S\) correspond bijectively to matrices \(M\in\mathcal A\) by \(FQ=\widehat M F\).

To prove the trace constraint, for any state \(\rho\) the no-jump survival \(S(t)=\operatorname{tr}(e^{-Qt}\rho e^{-Q^\dagger t})\) has derivative \(-\operatorname{tr}(G e^{-Qt}\rho e^{-Q^\dagger t})\). Thus \(S(t)\ge e^{-\|G\|t}\). Integration by parts gives \(\operatorname{tr}(R_s(\rho))=1-s\int_0^\infty e^{-st} S(t)\,dt\le\|G\|/(s+\|G\|)<1\). This holds uniformly for all states, so \(qB_0<I\).

Next, \(qR_0 A_s=J\). On the Hilbert space of matrices with the Hilbert–Schmidt inner product, let \(D\) be right multiplication by \(Q\). Identify Choi operators with operators on this space by vectorization. If \(C_0\) is the Choi matrix of \(R_0\), the Choi matrix of \(J/q\) is
\[
sC_0+D C_0+C_0D^\dagger .
\]
This follows by writing \(C_0=\sum_i |V_i\rangle\langle V_i|\) and expanding \(J\). Its compression to \(\mathcal S^\perp\) is zero. Positive semidefiniteness then forces its off-diagonal blocks to vanish. Since \(C_0\) is invertible on its support \(\mathcal S\), this implies \(D\mathcal S\subseteq\mathcal S\).

From \(J^*(I)=Q+Q^\dagger\) and \(J=qR_0 A_s\) we obtain
\[
(I-qB_0)Q+Q^\dagger(I-qB_0)=s qB_0. \tag{2}
\]
Right invariance implies \(Q\mathcal K\subseteq\mathcal K\). The off-diagonal block of (2) for \(\mathcal P\oplus\mathcal K\) forces the block from \(\mathcal P\) to \(\mathcal K\) to vanish as well. The block on \(\mathcal K\) is skew-Hermitian and has no effect on the kernel. Conversely any solution on \(\mathcal P\) can be extended by zero on \(\mathcal K\).

Independence of the \(V_i\) identifies a right multiplier with the unique \(M\) such that \(V_iQ=\sum_j M_{ij}V_j\). This is exactly the claimed correspondence via \(F\), including for singular Kraus pencils. Conjugating the forms in (2) by \(F^{-1}\) gives the first part of (1). In the original Kraus basis, the coefficient matrix for \(J/q\) is \((sI_2+M+M^\dagger)^{\mathsf T}\). Transposition preserves positivity, and positivity of the coefficient matrix is equivalent to positivity of the Choi matrix because the Kraus pair is independent. This proves necessity.

For sufficiency, use (1) to recover \(Q\) on \(\mathcal P\), extend by zero, and set \(J=qR_0 A_s\). The coefficient test makes \(J\) completely positive. Equation (2) gives \(Q+Q^\dagger=J^*(I)\ge0\), so \(H=(Q-Q^\dagger)/(2i)\) is Hermitian and the no-jump operators \(e^{-Qt}\) are contractions. The Laplace integral is finite and inverts \(A_s\). Any Kraus decomposition of \(J\) now gives a realization. Rescaling \(Q\) and \(J\) by the same positive factor rescales \(s\) and leaves \(R_s\) fixed. We retain \(s\) in the formulas.

The algebra \(\mathcal A\) is unital. Its action on \(\mathcal U\) is faithful, since an \(M\) killing the stacked Kraus range gives zero linear combinations of the independent \(V_i\) in each row. The Lyapunov metric \(E-qI\) is positive definite for every \(q<q_{\mathrm{tr}}\). At a solution, testing the first equation of (1) on an eigenvector of \(\widehat M\) gives a strictly positive real part for every eigenvalue.

## 3. Right multiplier algebras of dimension one or two

If the algebra has dimension one, \(Q\) on \(\mathcal P\) is scalar. Equation (2) is solvable exactly when \(B_0=bI_{\mathcal P}\) for \(b>0\). Then the real scalar \(s q b/[2(1-qb)]\) satisfies it, and \(J\) is a positive multiple of \(R_0\). All \(0<q<q_{\mathrm{tr}}\) are permitted.

A unital complex algebra of dimension two is spanned by \(I\) and a nonscalar generator. Its minimal polynomial has degree two, so either it has two distinct roots, giving complementary idempotents, or a repeated root, giving a nonzero square-zero generator. The representation on \(\mathcal P\) is faithful and has the same alternatives. A basis of \(\mathcal S\) need not be the original Kraus pair. For any independent basis \(W_1,W_2\), write \(R_0(X)=\sum_{i,j}C_{ij}W_i XW_j^\dagger\), where \(C\) is positive definite. If \(D W_j=\sum_i D_{ij} W_i\) in this basis, then the coefficient matrix for \(J/q\) is
\[
s C + D C + C D^\dagger. \tag{3}
\]

### 3.1. Two distinct roots

Let \(P_1,P_2\) be the complementary idempotents of the multiplier algebra on \(\mathcal P\). Use \(\mathcal P_i=P_i\mathcal P\). These form a direct sum and need not be orthogonal. One can choose \(W_i\) in \(\mathcal S\) with \(W_iP_j=\delta_{ij}W_i\). Each is nonzero because the two distinct right actions on the two-dimensional support are faithful. Put
\[
\gamma=\frac{|C_{12}|}{\sqrt{C_{11}C_{22}}}<1 .
\]
Here and throughout, compressions to \(\mathcal P_i\) refer to sesquilinear forms on those subspaces, even when their sum is oblique. Equation (2) on each \(\mathcal P_i\) requires that the compression of \(B_0\) be \(b_i I_{\mathcal P_i}\). If either condition fails, there is no scale. Otherwise \(b_i>0\), and set \(\tau_i=1-qb_i>0\). Write \(Q+sI/2=p_1 P_1+p_2 P_2\) with \(\operatorname{Re}p_i=s/(2\tau_i)\). Indeed, adding \(s(I-qB_0)\) to (2) gives
\[
(I-qB_0)(Q+sI/2)+(Q+sI/2)^\dagger(I-qB_0)=sI. \tag{4}
\]
With the inner product conjugate-linear in its first argument, the cross equation for \(u_i\in\mathcal P_i\) is
\[
(\overline{p_1}+p_2)(\langle u_1,u_2\rangle-q\langle u_1,B_0u_2\rangle)=s\langle u_1,u_2\rangle .
\]
By (3), the coefficient positivity in this basis requires that the off-diagonal magnitude, \(|p_1+\overline{p_2}||C_{12}|\), not exceed the geometric mean of the two diagonal entries, which are \(s C_{ii}/\tau_i\).

**Orthogonal subspaces.** If \(\mathcal P_1\) is orthogonal to \(\mathcal P_2\), the cross form of \(B_0\) must vanish. To see this, \(\overline{p_1}+p_2\) has strictly positive real part, so (4) forces the cross form of \(I-qB_0\) to be zero. With that condition satisfied, the imaginary parts of the \(p_i\) are free. Make them equal to minimize the off-diagonal magnitude. The exact test is
\[
\gamma^2\le\frac{4\tau_1\tau_2}{(\tau_1+\tau_2)^2},
\]
equivalently \(q|b_1-b_2|\le\sqrt{1-\gamma^2}(2-q(b_1+b_2))\). This gives every \(q\) below \(q_{\mathrm{tr}}\) if \(\gamma=0\) or \(b_1=b_2\). Otherwise the included upper endpoint is
\[
q_*=\frac{2\sqrt{1-\gamma^2}}{|b_1-b_2|+\sqrt{1-\gamma^2}(b_1+b_2)}<q_{\mathrm{tr}} .
\]

**Oblique subspaces.** If the two subspaces are not orthogonal, the cross form of \(B_0\) must have the form \(\langle u_1,B_0 u_2\rangle=b\langle u_1,u_2\rangle\) for one complex number \(b\), on all \(u_i\in\mathcal P_i\). Otherwise there is no scale. At a scale satisfying (4), \(1-qb\ne0\) and the necessary and sufficient conditions, after the two diagonal form tests, are
\[
\operatorname{Re}\frac{1}{1-qb}=\frac12(\tau_1^{-1}+\tau_2^{-1}),\qquad
\gamma^2\le\frac{|1-qb|^2}{\tau_1\tau_2}. \tag{5}
\]
Indeed the cross equation gives \(\overline{p_1}+p_2=s/(1-qb)\), whose imaginary part fixes the difference of the imaginary parts of \(p_1,p_2\). This leaves a common imaginary part free. Substitution of the fixed magnitude into (3) gives (5).

If \(B_0\) is scalar on \(\mathcal P\), all scales below the trace bound pass. For a nonscalar \(B_0\), at most one scale can pass (5). To see this, set \(A=(b_1+b_2)/2\), \(d=(b_1-b_2)/2\), \(e=\operatorname{Re}b-A\), \(v=\operatorname{Im}b\), and \(t=q/(1-qA)\). The real-part equation implies \(1-q\operatorname{Re} b>0\) and becomes
\[
(1-te)(e-td^2)=t v^2,\qquad t>0,\quad 1-te>0,\quad |td|<1.
\]
If \(e<0\) this is impossible. If \(e=0\), it requires \(d=v=0\); the diagonal and cross form tests would then make \(B_0\) scalar on the full direct sum. If \(e>0\), the factor \(e-td^2\) must be nonnegative. The left-hand side is strictly decreasing while positive on this domain, and the right-hand side is nondecreasing. At a zero of the left-hand side within the domain, the factor \(e-td^2\) must vanish, which happens at most once. Since \(q\mapsto t\) is strictly increasing, the scalar equation has at most one admissible solution. The Choi inequality may exclude that solution.

### 3.2. Square-zero generator

Let \(N\) be a nonzero square-zero generator on \(\mathcal P\) and write \(Q=\alpha I+wN\). A basis of the two-dimensional Kraus space is \(W,WN\) for any \(W\in\mathcal S\) with \(WN\ne0\). Require \(B_0\) to have the form
\[
B_0=b I+u N+\overline u N^\dagger+v N^\dagger N,\qquad b,v\in\mathbb R.
\]
These coefficients are unique. Indeed \(N\) is off-diagonal from \((\ker N)^\perp\) to \(\ker N\), while \(N^\dagger N\) is supported on \((\ker N)^\perp\) and is nonzero. The compression on \(\ker N\) first fixes \(b\), and the off-diagonal and final diagonal blocks determine \(u\) and \(v\). For a proposed \(q\), put \(\tau=1-qb>0\) and \(\zeta=q u/\tau\). The exact tests are
\[
qv=-2\tau|\zeta|^2,\qquad |\zeta|^2 C_{11}^2\le\det C . \tag{6}
\]

For the proof, let \(Y=I-qB_0\) and \(\kappa=s+2\operatorname{Re}\alpha>0\). Positivity of \(\kappa\) follows by restricting (4) to \(\ker N\). Equation (4) reads \(\kappa Y+w Y N+\overline w N^\dagger Y=sI\). The two multiplication operators in the last terms commute and each squares to zero, so the sum cubes to zero. The inverse is the quadratic polynomial of that sum with alternating signs, after division by \(\kappa\). Applying it to \(sI\) yields
\[
Y=\frac{s}{\kappa}(I-\zeta N-\overline\zeta N^\dagger+2|\zeta|^2 N^\dagger N),
\qquad \zeta=w/\kappa .
\]
Comparison gives \(s/\kappa=\tau\), the stated form and the equality in (6). Conversely these determine the real part of \(\alpha\) and \(w\), and the common imaginary scalar can be set to zero. In the basis \(W,WN\), right multiplication by \(N\) has matrix \(T=e_{21}\). The coefficient in (3) is then \(\kappa(C+\zeta TC+\overline\zeta C T^\dagger)\). Its first diagonal entry is \(\kappa C_{11}>0\). The determinant after division by \(\kappa^2\) equals \(\det C-|\zeta|^2 C_{11}^2\). This gives the other test in (6). When \(u=0\) the equality requires \(v=0\), giving all scales for a scalar \(B_0\). When \(u\ne0\), the equality is \(v=-2q|u|^2/(1-qb)\), whose right side is strictly decreasing. Thus at most one scale passes in the nonscalar case.

## 4. The triangular algebra

A proper unital subalgebra of \(M_2(\mathbb C)\) has a common invariant line. An elementary proof is as follows. If it has an element with distinct eigenvalues, its spectral idempotents belong to the algebra. In their basis, a nonzero entry in each off-diagonal direction would give both matrix units by multiplying by these idempotents, making the algebra full. Otherwise one coordinate line is invariant. If all elements have repeated eigenvalues and the algebra has a nonscalar element, subtract its eigenvalue and choose a basis making it \(e_{12}\). Any algebra member \(T\) with \(T_{21}\ne0\) would give \(e_{12}T\) with distinct eigenvalues \(T_{21},0\). This proves the claim; the scalar algebra also has invariant lines.

For dimension three, a unitary change of Kraus coordinates putting the invariant line first makes \(\mathcal A\) the full upper triangular algebra. Invariance under its diagonal matrix units implies
\(\mathcal U=(e_1\otimes\mathcal W_1)\oplus(e_2\otimes\mathcal W_2)\) for output subspaces \(\mathcal W_i\subseteq\mathcal H\). Here \(e_i\) denotes the \(i\)th coordinate vector, and \(e_{ij}\) a matrix unit. Invariance under \(e_{12}\) gives \(\mathcal W_2\subseteq\mathcal W_1\). The inclusion is proper because equality would give the full algebra. Both subspaces are nonzero by independence of the Kraus pair. Write \(j:\mathcal W_2\hookrightarrow\mathcal W_1\) for the inclusion.

At a solution of (1), set \(M=\alpha e_{11}+z e_{12}+\beta e_{22}\). The eigenvalues \(\alpha,\beta\) of its action on \(\mathcal U\) have strictly positive real part. Write \(E_{ij}\) for the blocks of \(E\) in the displayed decomposition. The first diagonal block of (1) requires \(E_{11}=h_1 I_{\mathcal W_1}\). The cross block is
\[
(h_1-q)z j+(\overline\alpha+\beta) E_{12}=0,
\]
which requires \(E_{12}=c j\) for some complex \(c\). The second diagonal block is then \(2\operatorname{Re}\beta(E_{22}-qI)+2\operatorname{Re}(\overline c z)I=s q I\), forcing \(E_{22}=h_2 I_{\mathcal W_2}\). If any condition fails, no scale is realizable.

Assume this structure holds. Put
\[
a=h_1-q,\quad b=h_2-q,\quad u=|c|^2,\quad D=ab-u .
\]
We have \(a,b,D>0\) for \(0<q<q_{\mathrm{tr}}\), as follows by restricting \(E-qI\) to one copy of the two coordinate directions along \(\mathcal W_2\). The metric is the \(2\times2\) Hermitian matrix with diagonal \(h_1,h_2\) and upper off-diagonal \(c\) tensored with identity on that shared space, plus \(h_1 I\) on the extra first-coordinate space. Thus \(q_{\mathrm{tr}}\) is the smaller eigenvalue of that \(2\times2\) metric. The Lyapunov equation gives
\[
\operatorname{Re}\alpha=\frac{s q}{2a},\qquad
\operatorname{Re}\beta=\frac{s q(a^2+u)}{2aD},\qquad
z=-\frac{c}{a}(\overline\alpha+\beta).
\]
The real parts are independent of the imaginary choices. Making the imaginary parts equal minimizes \(|z|\). Therefore the coefficient test in (1) amounts to \(R(q)\le1\), where
\[
R(q)=\frac{u q^2(a+b)^2}{4h_1D[h_2 a^2+u(2q-h_1)]}. \tag{7}
\]
Indeed it is the minimum ratio \(|z|^2/[(s+2\operatorname{Re}\alpha)(s+2\operatorname{Re}\beta)]\). The formulas also prove sufficiency. If \(c=0\), every trace-admissible scale passes.

For \(u>0\), \(R\) increases strictly from zero to infinity. To verify this, put \(S=h_1+h_2\), \(v(q)=q(S-2q)=q(a+b)>0\), and \(d(q)=h_2a^2+u(2q-h_1)=aD+q(a^2+u)>0\). Factor \(R=[\sqrt u\,v/(2h_1D)][\sqrt u\,v/(2d)]\). The first factor increases since \((a+b)/D\) is the sum of the two reciprocal gaps from \(q\) to the eigenvalues of the \(2\times2\) metric. The derivative numerator of \(v/d\) is
\[
h_2 a[S(h_1+q)-4qh_1]-u[S h_1-4qa].
\]
Here \(S h_1-4qa>0\) because \(4qa\le h_1^2\). Replacing \(u\) by the larger \(ab\) gives the strictly positive bound \(a q[(h_1-h_2)^2+4ab]\). Thus the second factor increases too. As \(q\) approaches the smaller eigenvalue, \(D\to0\) and \(v,d\) remain positive. Hence there is exactly one root \(q_*\) of \(R(q)=1\) below the trace bound. This is a quartic equation after clearing the positive denominator. The realizable scales are precisely \((0,q_*]\).

## 5. The full matrix algebra

If \(\mathcal A=M_2(\mathbb C)\), invariance under the four matrix units gives \(\mathcal U=\mathbb C^2\otimes\mathcal W\), where \(\mathcal W\ne0\) is an output subspace. Conversely this shape gives the full algebra. Write
\[
E=E_0\otimes I_{\mathcal W}+\sum_j E_j\otimes T_j,
\]
where the \(T_j\) form a basis of traceless Hermitian operators on \(\mathcal W\) and \(E_0\) is the normalized partial trace. The identity coefficient of the Lyapunov equation is
\((E_0-qI)M+M^\dagger(E_0-qI)=s q I_2\).
The \(T_j\) coefficients impose \(E_j M+M^\dagger E_j=0\). Since \(E_0-qI>0\), the first equation gives \(\operatorname{Re}\lambda>0\) for each eigenvalue \(\lambda\) of \(M\). For the homogeneous equations, \(e^{-tM^\dagger}E_j e^{-tM}\) is constant in \(t\), and decays to zero. Thus every \(E_j=0\). Conversely when \(E=E_0\otimes I_{\mathcal W}\), choosing \(M=(s q/2)(E_0-qI)^{-1}\) solves (1) and gives strict coefficient positivity. The full algebra therefore gives either no scale or the entire trace-admissible interval.

## 6. Examples and source comparison

**No scale.** On \(\mathbb C^3\) take Kraus operators \(I\) and \(T=\operatorname{diag}(0,1,2)\). A right multiplier lies in \(\operatorname{span}\{I,T\}\) since \(I\) belongs to the Kraus space. It is scalar because \(T^2\) is independent of \(I,T\). The effect \(I+T^2\) is nonscalar.

**Entire trace-admissible interval.** On \(\mathbb C^2\) take the independent orthogonal projections onto its coordinate lines as Kraus operators. Then \(B_0=I\) and \(Q=(s q/[2(1-q)])I\) realizes all \(0<q<1\).

**Isolated scale.** On \(\mathbb C^2\) let \(s=1\), \(N=e_{12}\), \(V=e_{11}+e_{12}/4+e_{22}/2\), and use jumps \(V\) and \(\sqrt{11/16}\, VN\). Their rate is \(G=I+(N+N^\dagger)/4\). Choose \(Q=I/2+N/4\) and define \(R_0=J A_1^{-1}\). The time-dependent jump Kraus operators span \(V,VN\): they remain in this space by \(N^2=0\), and at time zero the two jumps span it. Hence \(R_0\) has Choi rank two. Since \(V\) is invertible, the multiplier algebra is exactly the span of \(I,N\). The Lyapunov formula gives \(B_0=I/2+(N+N^\dagger)/16-N^\dagger N/64\). It is nonscalar. Therefore (6) permits only \(q=1\), which the construction attains.

**Isolated scale with oblique eigenspaces.** Let \(s=1\) and \(Q=e_{11}/2+e_{12}/4+e_{22}/4\) on \(\mathbb C^2\). Its eigenlines are spanned by \((1,0)\) and \((-1,1)\), with projections \(P_1=e_{11}+e_{12}\) and \(P_2=I-P_1\). Put \(G=Q+Q^\dagger\) and \(Y=G-P_1^\dagger G P_1/17\). This \(Y\) is positive definite and satisfies \(Y+P_1^\dagger Y P_1/16=G\), since \(P_1^2=P_1\). Choose \(V=Y^{1/2}\) and jumps \(V\) and \(VP_1/4\). Their rate is \(G\). The kernel \(R_0=J A_1^{-1}\) has support spanned by \(VP_1,VP_2\), because the independent jumps span it and right multiplication by \(Q\) preserves it. In these input eigenlines (4) gives \(b_1=1/2\), \(b_2=1/3\), and \(b=3/7\). The nonscalar effect and the uniqueness in (5) leave only the attained scale \(q=1\).

**Strict endpoint in the orthogonal projection case.** In the coordinate-projection basis on \(\mathbb C^2\), take \(C_{11}=1\), \(C_{22}=1/4\), and \(C_{12}=3/10\). This is positive definite, \(B_0=\operatorname{diag}(1,1/4)\), and \(\gamma=3/5\). The scale set is exactly \((0,32/35]\), below the trace bound \(1\).

**Strict endpoint with a triangular multiplier algebra.** Let \(\mathcal H=\mathbb C^3\), take \(\mathcal W_1=\operatorname{span}\{e_1,e_2\}\), \(\mathcal W_2=\operatorname{span}\{e_1\}\), and \(\mathcal U=(e_1\otimes\mathcal W_1)\oplus(e_2\otimes\mathcal W_2)\), using the first tensor factor to label Kraus coordinates. On this space set \(h_1=h_2=2\) and \(c=1\) as in Section 4. Choose any unitary \(U_0:\mathcal H\to\mathcal U\) and set \(F=E^{-1/2}U_0\). Its two component maps define \(V_1,V_2\) and are independent since \(F\) is onto \(\mathcal U\). They give a rank-two \(R_0\) with the required metric and multiplier algebra. Every \(V_i\) and every combination of them has image in \(\mathcal W_1\), so the pencil contains no invertible matrix. The trace bound is \(1\), and (7) gives \(R(1/2)=9/140<1\) and \(R(9/10)=1089/1036>1\). This is a strict interval cutoff for a singular pencil.

The general pointwise semidefinite inverse criterion, full-rank scaling result, and rank-one criterion are due to [1]. The rank-two result replaces feasibility over a \(d\times d\) Hamiltonian by explicit tests and classifies the whole ray at once. In particular, positive rescaling toward zero can destroy realizability on a rank-two ray. This work concerns one fixed positive Laplace point in the all-count model, and does not claim simultaneous interpolation of prescribed kernels at several points.

## Reference

1. *Inverse realization of quantum first-passage kernels and visible exceptional points in arbitrary dimension* (Chinese manuscript), earlier research manuscript (archived version). Sections 1–2.
