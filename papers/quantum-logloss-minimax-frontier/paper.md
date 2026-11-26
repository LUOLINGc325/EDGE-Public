# Exact causal quantum log-loss at short horizons and a Gram-matrix reduction

## Abstract

In sequential prediction of a quantum state under logarithmic loss, the learner must announce a density matrix before the next effect is revealed. We reduce the exact finite-horizon minimax value to a recursion on the Gram matrix of the preceding rank-one effects. At a history of rank \(r\), the recursion needs only a distribution in \(\mathbb C^r\) with a prescribed second moment and at most \(r^2+1\) support points. It gives an exact algebraic computation whose size, at a fixed horizon, is independent of the ambient matrix dimension. The three-round value is \(d^3((1+w)/3)^3\), where \(w>d^{-1/2}\) solves \(w^3-3w/d-2/d^2=0\). We give optimal forecasts and an attaining sequence of measurements. For \(d\ge3\) this value is strictly below the best static tensor bound, even when that tensor need only dominate likelihoods on product effects. The values agree for \(d=2\). At fixed horizon the first correction as \(d\) increases is given by a dimension-independent adaptive covariance problem on complex correlation matrices. Its coefficient is \(3\sqrt{3}\) at three rounds, compared with \(6\) for the best static tensor bound.

## Guide for readers

On each round the learner announces a density matrix, which is a positive semidefinite matrix of trace one. In an experiment, an effect is one positive operator in a collection summing to the identity. The Born rule gives the probability of its outcome as the trace of the effect times the state. For example, the rank-one projector onto a unit vector has probability \(1/d\) in the uniform state \(I/d\). In the regret ratio, each effect can be rescaled because its scale multiplies the learner and hindsight likelihoods equally. A proper forecast uses a single density matrix for all the effects that could be supplied next. This ensures that its outcome probabilities sum to one for each possible measurement.

The quantity \(C_{d,T}\) is a ratio of likelihoods. Its logarithm is the excess cumulative loss over the best single state chosen after seeing the entire history. Sections 2 and 3 turn the requirement to cover every continuation of a history into a minimization over forecast matrices and an equivalent maximization over measurements. The Gram matrix lists the inner products of the earlier directions. It suffices to track those inner products and the projection of the next direction into their span.

When the number of rounds \(T\) is fixed, the resulting computation uses a fixed number of real variables and treats the ambient dimension \(d\) as an input. Section 4 gives a closed formula at three rounds, and Section 5 determines the first correction as \(d\) increases with \(T\) held fixed. These estimates leave open the joint growth rate when the number of rounds also increases. Section 6 contrasts causal forecasts with a single tensor that must bound the likelihood on every product of measurement outcomes.

## 1. Model and results

For positive integers \(d,T\) let \(\mathcal D_d=\{\rho\succeq0:\operatorname{tr}\rho=1\}\). At time \(t\), the learner announces \(\sigma_t\in\mathcal D_d\) based on past effects. The adversary sees it and supplies a nonzero positive semidefinite matrix \(A_t\). Write
\[
 F(A_{1:T})=\max_{\rho\in\mathcal D_d}\prod_{t=1}^T\operatorname{tr}(A_t\rho),
 \qquad
 C_{d,T}=\inf_{\rm learner}\sup_{\rm adversary}
 \frac{F(A_{1:T})}{\prod_{t=1}^T\operatorname{tr}(A_t\sigma_t)} .
 \tag{1}
\]
Positive rescaling in any round cancels from the ratio. Its numerator is positive by testing \(I/d\). A zero denominator gives infinite regret. We use the natural logarithm, so the minimax log-loss regret is \(\log C_{d,T}\). The same value holds for the version with private learner randomness and expected log regret when the adversary sees each current announcement. The values are \(C_{d,0}=C_{1,T}=1\).

For rank-one effects write \(P_x=xx^*\) with \(\|x\|=1\), and use \(F(x_{1:T})\) for \(F(P_{x_1},\ldots,P_{x_T})\). Define a static tensor comparator by
\[
 C^{\mathrm{st}}_{d,T}=
 \min\left\{\operatorname{tr} W:
 W=W^*,\
 (x_1\otimes\cdots\otimes x_T)^*W(x_1\otimes\cdots\otimes x_T)
  \ \ge F(x_{1:T})\ \text{for all unit }x_i
 \right\}.
 \tag{2}
\]
The tensor is shared by all possible measurement histories. Its positivity is required on product tests by the inequality. Ordinary positive tensor certificates and fixed Bayesian mixtures of product states are special cases after multiplication by their regret factor.

**Theorem 1 (exact evaluation).** For all \(d,T\), the value in (1) is determined by the recursion in Section 3 on the Gram matrix of the past rank-one effects. A transition at a history of rank \(r\) uses at most \(r^2+1\) projected directions. These transitions lift to finite rank-one POVMs attaining the dual value. The recursion gives exact semialgebraic descriptions for every finite \(d,T\), including singular histories, and gives a proper optimal forecast by a reduced matrix inequality. For fixed \(T\), the initial value can be computed as a real algebraic number in time polynomial in the bit length of \(d\), with a preprocessing cost depending on \(T\). No efficient bound in a growing horizon is asserted.

**Theorem 2 (three rounds).** For \(d\ge2\), put \(z=1/d\) and let \(w>\sqrt z\) be the unique root of \(w^3-3zw-2z^2=0\). Then
\[
 C_{d,1}=d,\qquad C_{d,2}=d^2\left(\frac{1+d^{-1/2}}2\right)^2,
 \qquad C_{d,3}=d^3\left(\frac{1+w}{3}\right)^3 .
 \tag{3}
\]
Every positive-weight second-step outcome in an optimal three-round POVM continuation is unbiased to the first direction. The remaining conditional optimal capital matrix is unique and has the explicit inverse form in (9) below. Moreover \(C^{\mathrm{st}}_{2,3}=C_{2,3}\) and \(C^{\mathrm{st}}_{d,3}>C_{d,3}\) for every \(d\ge3\).

**Theorem 3 (fixed-horizon expansion).** For each fixed \(T\ge1\), the limit as \(d\to\infty\) satisfies
\[
 C_{d,T}=(d/T)^T\left(1+\frac{a_T}{\sqrt d}+O_T(d^{-1})\right).
 \tag{4}
\]
The constant \(a_T\) is the dimension-independent covariance optimization in Section 5, with a certified truncation error. In particular \(a_1=0,\ a_2=2,\ a_3=3\sqrt3\), and
\[
 C^{\mathrm{st}}_{d,3}=(d/3)^3
 \left(1+\frac6{\sqrt d}+O(d^{-1})\right).
 \tag{5}
\]
The expansion is for fixed \(T\). This leaves the dimension-uniform all-horizon rate, including the intermediate regime of horizons growing with dimension, open.

## 2. Pathwise reduction and matrix duality

For a nonnegative continuous function \(f\) on \(\mathcal D_d\), let \(V_n(f)\) denote the initial capital sufficient to cover \(\max_\rho f(\rho)\prod_{i=1}^n\operatorname{tr}(P_{x_i}\rho)\) on every future rank-one history. Capital on a round is multiplied by the probability of the announced effect. Put \(\ell_x(\rho)=x^*\rho x\). The recursion is
\[
\begin{aligned}
 V_0(f)&=\max_\rho f(\rho),\\
 V_{n+1}(f)&=\min_{S\succeq0}
       \{\operatorname{tr}S:x^*Sx\ge V_n(f\ell_x)\text{ for every unit }x\}\\
 &=\max_{\substack{w_j\ge0,\ \|x_j\|=1\\ \sum_j w_jP_{x_j}=I}}
                   \sum_j w_j V_n(f\ell_{x_j}).
\end{aligned}
 \tag{6}
\]
Indeed \(S\) is initial capital times a forecast, and the conditional capital after \(x\) must dominate the continuation. A scalar feasible \(S\) exists, and every positive semidefinite trace sublevel is compact. Monotonicity, homogeneity and subadditivity follow inductively. In particular \(|V_n(f)-V_n(g)|\le d^n\|f-g\|_\infty\), since \(I/d\) forecasts give \(V_n(1)\le d^n\). This gives continuity in \(x\) of \(a(x)=V_n(f\ell_x)\).

For duality, take the cone of finite positive combinations of \((P_x,a(x))\). It is closed because the trace bounds the total combination weight, and the generator set is compact. The largest \(b\) with \((I,b)\) in the cone exists and uses at most \(d^2+1\) generators by conic Carathéodory. Every feasible \(S\) in (6) has trace at least \(b\). Separating \((I,b')\) from the cone for \(b'>b\) gives a functional \((X,s)\mapsto\operatorname{tr}(SX)-\mu s\) which is nonnegative on the cone and negative at \((I,b')\). Evaluation at \((I,b)\) gives \(\mu>0\). Divide by \(\mu\) and let \(b'\downarrow b\). The resulting infimum is the first line of (6), since the constraints make \(S\) positive semidefinite. Iteration expresses \(V_T(1)\) as the maximum over depth-\(T\) finite adaptive rank-one POVM trees of the sum of their leaf likelihoods maximized over a common state separately at each leaf.

Every proper rank-one predictor with pathwise factor \(C\) extends to all effects with the same factor. Normalize the effect at time \(i\) to trace one and write \(A_i=\sum_j\lambda_{ij}P_{x_{ij}}\). Maintain each rank-one refinement of the observed history with weight equal to its simulated wealth times the product of its spectral coefficients. Forecast the mixture of the refined forecasts with these normalized weights. At the next effect the total weight is multiplied by \(\operatorname{tr}(A_t\sigma_t)\). At the terminal time, expand the likelihood of each fixed \(\rho\) along the same refinements. Each term is bounded by \(C\) times the corresponding simulated wealth, so summation proves the claim. Choosing an effect after seeing the forecast does not affect this algebra. Thus \(C_{d,T}=V_T(1)\).

For the randomized expected version, consider a rank-one prefix with carried product \(f\). For any realized forecast, the supremum over unit \(x\) of \(V_n(f\ell_x)/(x^*\sigma x)\) is at least \(V_{n+1}(f)\) by the first optimization in (6). The continuation \(V_n(f\ell_x)\) is positive on the sphere for every actual prefix by testing \(I/d\). A countable dense collection of directions therefore contains a choice achieving the factor \(1-\eta\) times that lower bound, with \(\eta>0\) arbitrary. It can be chosen measurably by using the first direction satisfying the inequality. This follows from the Lipschitz bound above and continuity of the likelihoods. It also works near a zero of \(x^*\sigma x\) by positivity of the numerator. Multiplying the lower comparisons over the realized path gives log regret at least \(\log V_T(1)+T\log(1-\eta)\). This holds for every realization of the learner's announcements. Sending \(\eta\) to zero proves the expected lower bound. For the upper bound one may choose optimal matrices measurably by the semialgebraic construction in Section 3 and a Borel spectral decomposition.

We also need the sharp rank bound on a hindsight optimizer. If \(p_i=\operatorname{tr}(A_i\rho_*)\) at an optimum, all \(p_i>0\). The directional derivative against any density matrix gives \(B=\sum_i A_i/p_i\preceq T I\), with \(\operatorname{tr}(B\rho_*)=T\). Thus \(\rho_*\) is supported on the top eigenspace of \(B\). There the \(T\) constraints \(\operatorname{tr}(A_i\rho)=p_i\) already fix the trace by the identity \(B=T I\) on the eigenspace. At an extreme positive solution of rank \(k\), a Hermitian perturbation within its support preserving those moments exists if \(k^2>T\). Small perturbations of both signs contradict extremality. Hence one optimizer has rank at most \(\min(d,\lfloor\sqrt T\rfloor)\). For sharpness use \(k^2\) projectors in the Weyl orbit of a unit vector on a \(k\)-dimensional subspace, choosing the vector to have nonzero expectation against each Weyl operator. Such vectors exist since finitely many proper real polynomial zero sets cannot cover the sphere. The orbit spans all Hermitian matrices on the subspace by Fourier inversion for Weyl conjugation, and its sum is \(kI\) there. The arithmetic–geometric mean inequality and the spanning property make the uniform state on that subspace the unique optimizer. If \(T>k^2\), pad with identities. This includes the case \(k=1\). For \(T\le3\) a pure comparator suffices on every path. From four rounds on this conclusion fails in any dimension at least two.

## 3. Gram-matrix recursion

Let \(G\) be the Gram matrix of a rank-one prefix of length \(t\lt T\), realized as \(G=X^*X\) for columns of \(X\) spanning \(\mathbb C^r\), \(r=\operatorname{rank}G\). For the empty prefix use \(r=0\). Let \(U_t(G)=V_{T-t}(\prod_{i\le t}\ell_{x_i})\). The same Gram matrix gives an equivalent prefix by an isometry on the span extended to a unitary, so \(U_t\) is well defined. The terminal \(U_T(G)\) is \(F(x_{1:T})\). It is computed on the span: projecting any density matrix to that span and renormalizing can only increase positive likelihood. At the empty terminal prefix the value is one.

If the next direction has projection \(u\) in the coordinates of the span, its new Gram matrix is
\[
 G[u]=
 \begin{pmatrix}G&X^*u\\ u^*X&1\end{pmatrix}.
\]
The domain \(B_{r,d}\) for \(u\) is the closed unit ball in \(\mathbb C^r\) when \(r\lt d\), and the unit sphere when \(r=d\). At \(r=0\) the domain consists of the zero vector. The exact reduced recursion is
\[
 U_t(G)=d\max_{\substack{\mu\text{ probability on }B_{r,d}\\
                       \int uu^*\,d\mu(u)=I_r/d}}
             \int U_{t+1}(G[u])\,d\mu(u).
 \tag{7}
\]
Any rank-one POVM induces such a law after dividing its weights by \(d\). Conversely, when \(r\lt d\), take for each support vector \(u\) the directions \(u+\sqrt{1-\|u\|^2}v\), where \(v\) is uniform over the signed vectors of an orthonormal basis in the orthogonal complement. The average projection has blocks \(uu^*\) and \((1-\|u\|^2)I_{d-r}/(d-r)\). Multiplication by \(d\) and the moment constraint yield a POVM. All these lifts have the same child Gram matrix. At \(r=d\) there is no complement to add. Hence (6) gives (7).

Compactness and continuity allow a maximizing law supported on at most \(r^2+1\) points. To see the bound, represent its moment and value together by at most \(r^2+2\) points using ordinary Carathéodory. If there are more than \(r^2+1\) positive weights, vary them in a nonzero direction preserving mass and the Hermitian second moment. At an optimum the variation has zero effect on the objective. Move until some weight is zero. Continuity of \(U_{t+1}(G[u])\) here follows by using the continuous lift with one fixed complementary vector, or just \(u\) when \(r=d\), and the bound after (6).

For the primal forecast, twirl the first minimization in (6) over unitaries fixing the observed span pointwise. When \(r\lt d\) the first capital matrix is \(M\oplus b I_{d-r}\), found by minimizing \(\operatorname{tr}M+(d-r)b\) subject to \(M\succeq0,\ b\ge0\) and
\[
 u^* M u+b(1-\|u\|^2)\ge U_{t+1}(G[u])\qquad(u\in B_{r,d}).
 \tag{8}
\]
Omit the scalar block at \(r=d\). Normalize by this trace to obtain the forecast. All histories produced by nonzero effects have a positive value, so normalization is valid. A deterministic choice of phase or completion of the coordinate basis may be made by ordered Gram–Schmidt. The resulting algorithm does not use future measurements.

For effectiveness, at fixed \(T\) the terminal value is the maximum of a polynomial on an \(r\)-dimensional density body. Encode real and imaginary parts and test positive semidefiniteness by principal minors. For each earlier \(t\) split by the integer rank \(r\le t\), encode a realization \(X\) by \(X^*X=G\) and \(\det XX^*>0\) when \(r>0\), and write (7) as the maximum over \(r^2+1\) atoms. Its graph is a formula in the first-order theory of real closed fields, using the child graphs and the polynomial moment equations after multiplication by \(d\). This also describes the minimizing matrices in (8), with a measurable semialgebraic selection. For \(d\ge T\), every transition has \(r\lt d\), so \(d\) can be a free scalar parameter in a single fixed formula. If \(1\le d\lt T\), there are only finitely many other dimension cases for this fixed \(T\). Quantifier elimination followed by real univariate root isolation gives the exact value. After elimination for the fixed horizon, degrees and the number of polynomials are fixed, and specialization to an integer \(d\) gives coefficients of bit length \(O_T(\log(d+1))\). This proves the stated bit complexity, with an algebraic number specified by an isolating representation. Formula (8) also gives certified predictions for algebraic input histories. The reduction in dimension makes no polynomial-horizon claim.

## 4. The three-round value

The first effect is equivalent to any other by a unitary. After \(P_x,P_y\), put \(z=|x^*y|^2\), \(r=\sqrt z\), and \(M=(P_x+P_y)/2\). Its two named eigenvalues are \(\lambda_\pm=(1\pm r)/2\) with eigenvectors \(e_\pm\). Phases of \(x,y\) are chosen so that the overlap is \(r\ge0\). At \(r=1\) take any unit eigenvector \(e_-\) orthogonal to \(e_+\) for the zero eigenvalue. The remaining eigenvalue is zero with multiplicity \(d-2\). If a pure vector \(\psi\) has masses \(p_+,p_-,p_0\) in these directions and the complement, its weight after the first two effects satisfies
\[
 \ell_x(\psi\psi^*)\ell_y(\psi\psi^*)\le
          (\lambda_+p_++\lambda_-p_-)^2.
\]
This is the triangle inequality for the squared modulus of the product of the two amplitudes, expressed in the \(e_\pm\) basis. It is equality when the two coefficients in these directions differ in phase by \(\pi/2\).

For \(\tau>2\lambda_+/3\), consider
\[
 S_\tau=\tau^3(3\tau I-2M)^{-1},
 \qquad s_i=\frac{\tau^3}{3\tau-2\lambda_i},
 \quad m_+=m_-=1,\quad m_0=d-2 .
 \tag{9}
\]
This is feasible for the final capital constraint (6). Indeed, a pure comparator suffices. The maximum over last directions of the squared amplitude of \(\psi\) divided by that direction's \(S_\tau\) expectation is \(\psi^* S_\tau^{-1}\psi\) by the generalized Rayleigh quotient. For \(q=\psi^*M\psi\),
\[
 \ell_x(\psi\psi^*)\ell_y(\psi\psi^*)\,\psi^* S_\tau^{-1}\psi
       \le q^2(3\tau-2q)/\tau^3\le1 ,
\]
since \(1-3u^2+2u^3=(u-1)^2(2u+1)\) for \(u=q/\tau\ge0\).

Minimize \(H(\tau)=\sum_i m_i s_i\) on this domain. Each summand \(\tau^3/(3\tau-2\lambda)\) has a strictly convex quadratic part after polynomial division, plus a nonnegative affine term, a constant and a nonnegative multiple of \(1/(3\tau-2\lambda)\). The sum grows to infinity at both ends of the domain. The minimum is unique and interior. The derivative of a summand is \(6\tau^2(\tau-\lambda)/(3\tau-2\lambda)^2\). Consequently at the minimum the probabilities
\[
 p_i=\frac{m_i s_i^2}{\sum_j m_j s_j^2}
\]
have \(\sum_i p_i\lambda_i=\tau\). Ignore \(m_i=0\). Choose a pure \(\psi\) with these block masses, with relative phase \(+i\) or \(-i\) in the two named coordinates with equal probabilities. In the complementary block choose an independent uniform signed basis direction. Let the last direction be \(v=S_\tau^{-1}\psi/\|S_\tau^{-1}\psi\|\). Its expected rank-one projection is \(I/d\), since the block masses are \(m_i/d\) and all cross terms average to zero. The construction uses finitely many vectors. At each such vector the two displayed inequalities are equalities, as \(q=\tau\). Its contribution to the dual (6) is the corresponding expectation of \(S_\tau\). The dual certifies the trace minimum, so (9) is optimal. It is also unique. For any other minimizing \(S\) and each such dual vector \(v\), the positive operator \(S-\ell_x(\psi\psi^*)\ell_y(\psi\psi^*)P_\psi\) has zero quadratic form at \(v\), hence kills \(v\). This also holds for \(S_\tau\), and the vectors \(v\) span the whole space.

Thus the remaining optimal capital after the two effects is \(h_d(z)=\min_\tau H(\tau)\). Set \(w=3\tau-1\). Then
\[
 27h_d(z)=\min_{w>\sqrt z} L(w,z),\qquad
 L(w,z)=(w+1)^2\left[d-2+\frac{2w(w+1)}{w^2-z}\right].
 \tag{10}
\]
The function is continuous on \([0,1]\) by (6) applied to a continuous realization of a pair. It is strictly concave on the interior. For verification, at a stationary point in \(w\) substitute
\[
 d-2=\frac{(w+1)(-2w^3+w^2+4wz+z)}{(w^2-z)^2}.
\]
The Hessian determinant at that point is
\[
 L_{ww} L_{zz}-L_{wz}^2=
 -\frac{4(w+1)^4\bigl(2w^3+5w^2+(2w-1)z\bigr)}{(w^2-z)^5}\lt 0 .
\]
The numerator in parentheses is positive because \(0\le z\lt w^2\). Strict convexity in \(\tau\) gives \(L_{ww}>0\); implicit differentiation of \(L_w=0\) now gives \(h_d''(z)\lt 0\).

At the second step the squared overlap with the first direction has conditional mean \(1/d\) under the probability weights of the POVM in (7). Strict Jensen inequality forces a constant overlap in an optimal continuation. Such a POVM is an orthonormal basis unbiased to the first vector, constructed by a Fourier basis in coordinates containing it. Hence \(C_{d,3}=d^2 h_d(1/d)\). The tangent line \(h_d(z_0)+h_d'(z_0)(z-z_0)\), \(z_0=1/d\), is a feasible quadratic majorant in the direction \(y\), giving an optimal second-step capital matrix. Its trace is \(d h_d(z_0)\). The first forecast is \(I/d\), and the third forecast is (9) divided by its trace. At \(z_0=1/d\) the stationary equation in (10) factors into \(w+z_0\) times \(w^3-3z_0w-2z_0^2\), up to a nonzero scalar. On \(w>\sqrt{z_0}\) the cubic is strictly increasing and crosses zero. It gives \(2(w+1)/(w^2-z_0)=d+2/w\), which reduces \(h_d(z_0)\) to \(d((1+w)/3)^3\).

For one round the first minimization in (6) has \(S=I\). For two rounds the maximum product at a pair with overlap \(r\) is \(((1+r)/2)^2\). The upper bound follows by the arithmetic–geometric mean inequality and the norm of \(M\), and the vector \(e_+\) gives equality. As a function of \(z=r^2\) this is strictly concave, so the same unbiased continuation gives \(C_{d,2}\) in (3). Finally the three-round root satisfies \(w=\sqrt3/\sqrt d+O(d^{-1})\) by putting \(w=v/\sqrt d\) in the cubic. This yields \(C_{d,3}=(d/3)^3(1+3\sqrt3/\sqrt d+O(d^{-1}))\).

## 5. The fixed-horizon correction

For a Hermitian \(T\)-by-\(T\) matrix \(E\) with zero diagonal, define the support function
\[
 g_T(E)=\max\{\operatorname{tr}(EQ):Q\succeq0,\ Q_{ii}=1\}.
\]
The feasible complex correlation matrices have trace \(T\). Thus \(g_T\) is positively homogeneous and Lipschitz for the Frobenius norm with constant at most \(T\).

The terminal likelihood on a nearly orthogonal word has the following uniform first-order comparison:
\[
 T^T F(x_{1:T})=1+g_T(G-I)+O_T(\|G-I\|_{\mathrm F}^2).
 \tag{11}
\]
We prove it first when \(E=G-I\) has operator norm at most \(1/2\). The positive semidefinite matrix \(B=X^*\rho X\) can be any such matrix satisfying \(\operatorname{tr}(G^{-1}B)=1\) on the span. At a positive product write \(B=aD_q QD_q\) with \(q\) the normalized diagonal of \(B\), \(D_q=\operatorname{diag}(\sqrt{q_i})\), and \(a=\operatorname{tr}B\). Then \(a^{-1}=\operatorname{tr}(G^{-1}D_qQD_q)\). Expanding \(G^{-1}\) at the identity gives
\[
 \log a=\operatorname{tr}(E D_q Q D_q)+O(\|E\|_{\mathrm F}^2)
\]
uniformly in \(q,Q\), as \(D_q QD_q\) is a density matrix. Let \(u_i=1/T\). The sum \(\sum_i\log(Tq_i)=-T\,D(u\Vert q)\) is bounded above by a negative constant times \(\|q-u\|_2^2\), by Pinsker's inequality. Also \(|\sqrt{q_i}-1/\sqrt T|\le\sqrt T|q_i-1/T|\), and the trace norm of \(D_qQD_q-Q/T\) is \(O_T(\|q-u\|_2)\). The latter follows by expanding the difference and applying the trace norm inequality for multiplication, since \(\|Q\|_1=T\). Hence in the log product the cost for changing \(q\) from \(u\) is quadratic, while the possible gain in \(T\log a\) is at most \(O_T(\|E\|_{\mathrm F}\|q-u\|_2)\). Completing the square gives a log upper bound \(g_T(E)+O_T(\|E\|_{\mathrm F}^2)\), with the matching lower bound by taking \(q=u\) and a maximizing \(Q\). Exponentiating gives (11). Outside the small-operator-norm regime the quadratic remainder can absorb the crude bounds \(0\le F\le1\) and \(0\le g_T(E)\le T\|E\|_{\mathrm F}\). This also covers singular Gram matrices.

Under a finite adaptive POVM tree choose its next direction with probabilities \(w_j/d\), the law under the maximally mixed state. Then \(\mathbb E[P_{x_t}\mid x_{\lt t}]=I/d\) at each node, including when labels distinguish directions with an identical projection. In particular \(\mathbb E\|G-I\|_{\mathrm F}^2=T(T-1)/d\). The dual and (11) give
\[
 C_{d,T}=(d/T)^T\left(1+\frac{a_{T,d}}{\sqrt d}+O_T(d^{-1})\right),
 \quad a_{T,d}=\sup_{\rm finite\ trees}
         \mathbb E\,g_T\!\left(\sqrt d(G-I)\right).
 \tag{12}
\]

Define \(a_T\) by the following finite-process supremum. For \(t=2,\ldots,T\), draw a vector \(\xi_t\in\mathbb C^{t-1}\) from a finitely supported conditional law with
\[
 \mathbb E[\xi_t\xi_t^*\mid \xi_{2:t-1}]=I_{t-1}.
 \tag{13}
\]
Form a Hermitian matrix \(E_\xi\) with zero diagonal and column \(t\) above the diagonal equal to \(\xi_t\). Maximize \(\mathbb E g_T(E_\xi)\). If \(T=1\), set \(a_1=0\). The second moments give \(\mathbb E\|E_\xi\|_{\mathrm F}^2=T(T-1)\), so \(a_T\) is finite.

First couple any finite tree in (12) to such a process. When the preceding vectors are linearly independent, choose orthonormal coordinates in their span so that they have Gram realization \(X=G_{t-1}^{1/2}\), with \(G_{t-1}\) the leading Gram submatrix. Set \(\xi_t\) to \(\sqrt d\) times the coordinates of the projection of \(x_t\). Its conditional moment is \(I_{t-1}\), and the actual column of \(\sqrt d(G-I)\) is \(G_{t-1}^{1/2}\xi_t\). On a linearly dependent history replace \(\xi_t\) by a fresh, finitely supported isotropic vector of the required dimension. The tower property keeps (13). On an independent history the mean squared loss in column \(t\), conditional on the past, is \(\|G_{t-1}^{1/2}-I\|_{\mathrm F}^2\le\|G_{t-1}-I\|_{\mathrm F}^2\). The latter has expectation \(O_T(d^{-1})\). A rank failure before step \(t\) has probability \(O_T(d^{-1})\), since at step \(j\) the conditional probability of landing in the previous span is at most its dimension divided by \(d\). Both compared columns have uniformly bounded second moments, so Cauchy–Schwarz controls the expected absolute loss on the failed histories by \(O_T(d^{-1/2})\). The Lipschitz bound gives \(a_{T,d}\le a_T+O_T(d^{-1/2})\).

For the other direction we first bound the effect of truncating the innovation game. Choose \(R\ge 2\sqrt T\). At a node with \(r=t-1\), write \(M_R=\mathbb E[\xi_t\xi_t^*\mathbf 1_{\{\|\xi_t\|\le R\}}\mid\text{original past}]\), and \(p=r/R^2\). With probability \(1-p\) keep the innovation if its norm is at most \(R\) and otherwise output zero. With probability \(p\) draw from a finite law with second moment \((I-(1-p)M_R)/p\). Such a law with vectors of norm at most \(R\) is obtained by choosing an eigenvector uniformly among \(r\) orthogonal directions and scaling it by the square root of \(r\) times its eigenvalue. Each eigenvalue is at most \(1/p\). All innovations of the resulting process are bounded by \(R\). Its second moment is exactly \(I\) conditional on both histories, so also conditional on the new past. Coupling to the original draw costs at most \(3r/R\) in conditional expected norm, by the original second moment bound and \(pR=r/R\). All laws remain finite. Write \(a_T(R)\) for the supremum with the bound \(R\). Then
\[
 0\le a_T-a_T(R)\le\frac{3\sqrt2\,T}{R}\sum_{r=1}^{T-1}r.
 \tag{14}
\]
For rational \(R\), \(a_T(R)\) is computable by the same finite-support moment argument as in (7) and real quantifier elimination. The terminal \(g_T\) is the maximum of a linear form over the complex correlation matrices. The bounded conditional optimizations have compact domains and preserve continuity in the earlier entries, so their maxima can be used in the recursive graph formulas.

For large \(d\) take \(R=\sqrt d/2\). Any finite process attaining or approximating \(a_T(R)\) lifts into a physical tree by \(u_t=\xi_t/\sqrt d\) in (7), with the same complementary construction. The first POVM may be any orthonormal basis. Every lifted direction increases the rank since \(\|u_t\|\le1/2\) and \(d\ge T\). Thus the same square-root Gram comparison applies with no discarded branch. It costs \(O_T(d^{-1/2})\) in the expected \(g_T\) value. Combining with (14) gives \(a_{T,d}=a_T+O_T(d^{-1/2})\). Substitution in (12) proves (4). The exact small-horizon formulas give its stated coefficients.

## 6. Separation from static product certificates

A product certificate \(W\) from (2) can be summed against all leaves of any adaptive POVM tree. The weighted product projections sum to the identity by iterated completeness, so \(C^{\mathrm{st}}_{d,T}\ge C_{d,T}\). Its exact dual is the maximum of the sum of maximized outcome likelihoods over complete finite POVMs whose effects are positive multiples of rank-one product projections. This follows by the same cone argument as in (6), with generators \((P_{x_1}\otimes\cdots\otimes P_{x_T},F(x_{1:T}))\). Positivity on the generators restricts the tensor only on product directions, as in (2). The minimum in (2) exists. Indeed \(I\) is feasible, and if feasible tensors of bounded trace had unbounded norm, normalizing a diverging sequence would give a nonzero Hermitian tensor nonnegative on products with trace zero. Its product evaluations would vanish everywhere since their integral over independent uniform directions is zero and the evaluations are continuous. Product projections span the real Hermitian space, so that tensor would be zero. Compactness now gives the minimum.

For \(T=3\) twirl \(W\) under \(U^{\otimes3}\) and all permutations of its three positions. These preserve every product inequality and the trace. By the usual Schur–Weyl commutant, the twirled tensor has the form
\[
 W=aI+b(U_{12}+U_{13}+U_{23})+c(U_{123}+U_{132})
 \tag{15}
\]
with real coefficients and \(U_\pi\) acting by permuting tensor factors. When \(d\ge3\) these three operators are linearly independent. Its normalized trace is \(a+3b/d+2c/d^2\). For fixed \(x,y\) the slice in the last coordinate is
\[
 S_W(x,y)=(a+b|x^*y|^2)I+b(P_x+P_y)+c(P_xP_y+P_yP_x).
 \tag{16}
\]
It is feasible for the last capital constraint by (2).

Suppose \(d\ge3\) and \(\operatorname{tr}W=C_{d,3}\). For any first vector \(x\), contract the first tensor leg and use any second-step basis unbiased to \(x\). The traces of the resulting last slices sum to \(\operatorname{tr}W/d\) by conjugation invariance and completeness. Every last slice has trace at least \(h_d(z_0)\) with \(z_0=1/d\). Equality of their sum forces each of them to equal \(S_\tau\) by the uniqueness in Section 4. All pairs with this overlap are equivalent after rephasing and conjugation. Write \(r=\sqrt{z_0}\), \(w=3\tau-1\). Matching the last-slice eigenvalues in (16) gives
\[
 c=\frac{\tau^3}{(w+1)(w^2-r^2)},\quad b=wc,\quad
 a=\frac{\tau^3}{w+1}-br^2.
 \tag{17}
\]

Vary \(z=|x^*y|^2\) in a neighborhood of \(z_0\) while keeping the pair's \(e_\pm\) coordinate axes and their orthogonal complement fixed. Let \(s_i(z)\) be the last slice eigenvalues. By (16),
\[
 s_0(z)=a+bz,\qquad
 s_\pm(z)=a+bz+(b\pm c\sqrt z)(1\pm\sqrt z).
\]
For any nonnegative masses \(p_i\) summing to one, the maximizing relative phase of Section 4 gives the necessary product constraint
\[
 \left(\sum_i \lambda_i(z)p_i\right)^2
       \sum_i \frac{p_i}{s_i(z)}\le1.
 \tag{18}
\]
Indeed the slice is positive definite near \(z_0\), and the maximizing final direction is the inverse applied to that comparator. At \(z_0\), equality holds for every mass vector with \(\sum_i\lambda_i(z_0)p_i=\tau\). This slice has a relative interior with all \(p_i>0\), by the explicit stationarity weights in Section 4 and \(d\ge3\). For each such vector the derivative at \(z_0\) of the left side of (18) must vanish. The derivative is \(\sum_i p_i u_i\), where
\[
 u_i=2\lambda_i'(z_0)/\tau-\tau^2s_i'(z_0)/s_i(z_0)^2.
\]
Thus the three points \((\lambda_i(z_0),u_i)\) must lie on one affine line. But substitution of (17) gives
\[
 (u_+-u_0)\lambda_-(z_0)-(u_--u_0)\lambda_+(z_0)
   =\frac{3r(1-r^2)}{(r^2-w^2)(w+1)}\ne0 .
\]
This contradicts feasibility. Since the static minimum exists, it proves \(C^{\mathrm{st}}_{d,3}>C_{d,3}\).

For \(d=2\), let \(q=\sum_{i\lt j}|x_i^*x_j|^2\). The largest eigenvalue of \(\sum_iP_{x_i}\) is \((3+\sqrt{4q-3})/2\), from its trace and squared trace, so \(3/4\le q\le3\). The arithmetic–geometric mean inequality gives
\[
 F(x_{1:3})\le f(q)=\left(\frac{3+\sqrt{4q-3}}6\right)^3 .
\]
The function is concave on the stated interval. For \(s=\sqrt{4q-3}\), its derivative in \(q\) is \((3+s)^2/(36s)\), decreasing up to \(s=3\). The tangent at \(q=3/2\) is a static certificate in the \(a,b\) part of (15). Its normalized trace is \(f(3/2)=C_{2,3}/2^3\) by (3). Thus equality holds for \(d=2\).

For the static expansion in high dimension, (11) and \(|Q_{ij}|\le1\) give
\[
 27 F(x_{1:3})\le
   1+2\sum_{i\lt j}|x_i^*x_j|+C\sum_{i\lt j}|x_i^*x_j|^2
\]
with an absolute finite \(C\). Use \(2v\le\sqrt d\,v^2+1/\sqrt d\) to construct a static bound of the \(a,b\) form, with normalized trace at most \((1+6/\sqrt d+O(d^{-1}))/27\). For the lower bound take an optimal twirled certificate. Testing three orthogonal vectors, two equal vectors orthogonal to the third, and three equal vectors gives \(a\ge1/27,\ a+b\ge4/27,\ a+3b+2c\ge1\). A real triple of pairwise inner products \(-1/2\) gives \(a+3b/4-c/4\ge0\). From \(c\ge(1-a-3b)/2\), the trace objective is at least \((1-d^{-2})a+(3/d-3/d^2)b+d^{-2}\). Together with \(b\ge4/27-a\) and the upper bound on the optimum, this first yields \(a=O(1)\). Then \(a\ge1/27\) yields \(b=O(\sqrt d)\) from above, and \(c\le4a+3b=O(\sqrt d)\) from above.

Finally choose a feasible Gram triple with all off-diagonal entries \(d^{-1/2}\) real positive. The direction proportional to the sum of the three vectors gives each probability \((1+2d^{-1/2})/3\). Condition (2) at this triple says
\[
 a+\frac{3b}{d}+\frac{2c}{d^{3/2}}\ge
 \left(\frac{1+2d^{-1/2}}3\right)^3.
\]
Since \(c\le O(\sqrt d)\), replacing \(2c/d^{3/2}\) by \(2c/d^2\) loses at most \(O(d^{-1})\). This matches the upper bound and proves (5). It compares two exact objectives on the same product likelihoods. It also applies to the stronger positive-operator certificates used in collective universal prediction as a lower bound on their cost.

## 7. Relation to earlier work

Tseng, Chen, Xiao and Li study proper state forecasts and give large-horizon regret guarantees via VB-FTRL. Li and Tseng's Theorem 1.1 excludes dimension exponents below two in guarantees of the form \(O(d^\gamma\log T)\) at sufficiently large horizons. Their Remark 3.4 leaves the exact minimax rate open. Our algorithm treats the finite-horizon value and does not provide their style of efficient large-horizon guarantee. The dimension-free moment transition and fixed-horizon coefficient refer to the original order of play with the full density-state comparator. [ALT paper](https://proceedings.mlr.press/v272/tseng25a.html) · [Li–Tseng preprint](https://arxiv.org/html/2610.21273v1)

Liu, Attias and Roy's contextual Shtarkov sum likewise maximizes an expert likelihood along each path of a context tree. Their forecaster chooses a probability vector after receiving a context. Our forecast is a density matrix announced before the effect. The local dual normalization is operator completeness, and proper-state constraint reduction uses quantum unitary invariance. The use of a sum of maximal path likelihoods and finite-dimensional cone duality is antecedent methodology. [NeurIPS paper](https://proceedings.neurips.cc/paper_files/paper/2024/hash/19a94fdf9e1c5b387830e4c4fef6972a-Abstract-Conference.html)

The maximum of summed likelihoods also appears in quantum maximal leakage. Farokhi's Theorems 1–2 give the formula and a rank-one support bound for an unrestricted measurement on a finite quantum ensemble. Xiao, Zhao, Zhu and Farokhi apply this objective to tensor powers of a finite ensemble and identify the collective optimization with equal-prior state discrimination. The tree in (6) applies that likelihood objective to one-copy measurements with classical outcome conditioning and with the full density-state family as comparator. Equations (7)–(8) exploit the restricted measurement structure and recover proper forecasts. Section 6 compares this causal class with complete product measurements that need not form a causal tree. [Farokhi, Theorems 1–2](https://doi.org/10.1103/PhysRevA.109.022608) · [Farokhi, author text](https://arxiv.org/html/2307.12529v2) · [Xiao et al., §III.B](https://arxiv.org/html/2607.15853v1)

Krattenthaler and Slater analyze universal quantum coding through relative-entropy redundancy, and Hayashi treats universal approximation of multi-copy states in general fixed dimension. The objective in (1) instead involves a worst path of effects and logarithmic likelihood ratios after measurement. Bennett et al. give distinguishability gaps between local and separable operations for specified product-state ensembles. The separation here concerns the maximized likelihood of a common unknown state on three fresh copies. The lower bound already holds for Hermitian product certificates without global positivity. [Krattenthaler–Slater](https://doi.org/10.1109/18.841164) · [Hayashi, Commun. Math. Phys. 293 (2010), 171–183](https://doi.org/10.1007/s00220-009-0909-y) · [Hayashi, author text](https://arxiv.org/abs/0806.1091) · [Bennett et al.](https://doi.org/10.1103/PhysRevA.59.1070)

The low-rank tomography theorem of Nayak and Zhou applies to trace-norm estimation at a target accuracy under sample-block restrictions. It provides a different comparison with sequential observations and does not determine the pathwise likelihood value. The rank argument in Section 2 uses the usual semidefinite extreme-point mechanism, and real quantifier elimination in Section 3 uses standard algorithms. [Nayak–Zhou preprint](https://arxiv.org/html/2609.10514v2) · [Pataki](https://doi.org/10.1287/moor.23.2.339)
