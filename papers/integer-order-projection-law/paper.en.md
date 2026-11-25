---
title: "Magnetization projection at every integer stabilizer Rényi order"
subtitle: "Pauli tensor projection, entropy types, and phase-uniform limits"
lang: en
---

## Abstract

We give an explicit variational law for integer-order stabilizer Rényi entropy after excitation-number projection of a spin-coherent product state. The law applies to every order r≥2 and every nonempty sector set with nonnegative amplitudes. Its finite-size error is logarithmic for fixed order, uniformly in the initial latitude and the selected sectors. A tensor representation of the Pauli group supplies the norm comparison needed beyond the fourth moment. A parity-column type calculation gives the Dicke entropy density and its explicit scalar optimization. On modular progressions the same density holds for arbitrary phases at diverging resolution parameter, while fixed moduli and coherent azimuths retain an exact phase-grid correction.

## 1. Definitions and result

Let \(\mathcal P_N\) contain one representative of each Pauli string up to phase. For integer \(r\ge2\) and a normalized \(N\)-qubit state \(\psi\) put

\[
 W_{r,N}(\psi)=2^{-N}\sum_{P\in\mathcal P_N}|\langle\psi,P\psi\rangle|^{2r},
 \qquad M_r(\psi)=-\frac{\log_2 W_{r,N}(\psi)}{r-1}.
\]

Write \(D_n^N\) for the normalized uniform state on strings with exactly \(n\) ones. For \(0<p<1\) and a nonempty \(\Omega\subseteq\{0,\ldots,N\}\), define

\[
 b_n=\binom{N}{n}p^n(1-p)^{N-n},\qquad
 Z=\sum_{n\in\Omega} b_n,\qquad
 \Psi=\sum_{n\in\Omega} e^{i\theta_n}\sqrt{b_n/Z}\,D_n^N .
\]

Let \(h_2\) be binary entropy and \(D_2(q\Vert p)\) binary relative entropy, both in bits. Define the finite column polynomial and its entropy transform by

\[
 Z_r(z)=\sum_{l\ \mathrm{even}}
            \binom{2r}{l} z^{2l}+2^{2r-1}z^{2r},
 \qquad
 s_r(q)=\inf_{z>0}\{\log_2 Z_r(z)-4rq\log_2 z\}.
\]
Set \(d_r(q)=[2r h_2(q)-s_r(q)]/(r-1)\), \(L_r=2r/(r-1)\), and

\[
 V_r=\min_{n\in\Omega}\{d_r(n/N)+L_r D_2(n/N\Vert p)\}
                   -L_r\min_{n\in\Omega}D_2(n/N\Vert p).
 \qquad\text{(1)}
\]

**Theorem 1.** With all amplitudes nonnegative, \(M_r(\Psi)=N V_r+O_r(\log(N+1))\), uniformly over \(p\) and \(\Omega\). More explicitly, for \(N\ge2\cdot4^r\) the error is at most \(C\,4^r\log(N+1)/(r-1)\) for a universal \(C\). For arbitrary phases on a full modular progression \(\Omega=\{n:0\le n\le N,\ n\equiv a\bmod K\}\), the corresponding error bound adds \(C N/K\). For such progressions the asymptotic formulas in Section 5 apply to every sequence of moduli and coherent azimuths.

The archived *Magic under finite-resolution magnetization projection* proves the fourth-moment case \(r=2\), including the modular phase distinction, and leaves higher orders open. The following proof uses an order-general Pauli comparison and a different number of parity columns at each order.

## 2. A tensor comparison for Pauli moments

The definition of \(W_{r,N}\) also applies to unnormalized vectors. For two vectors \(f,g\), the \(2r\)-th moment of their off-diagonal Pauli coefficients satisfies

\[
 \sum_P|\langle f,Pg\rangle|^{2r}
 \le \left(\sum_P|\langle f,Pf\rangle|^{2r}
           \sum_P|\langle g,Pg\rangle|^{2r}\right)^{1/2}.
 \qquad\text{(2)}
\]

To see this, associate to \(P\) the unitary \(P^{\otimes r}\otimes\overline P^{\otimes r}\). The Pauli multiplication phases cancel in this tensor product, so it is a representation of the finite binary label group. Its uniform average \(\Pi\) is an orthogonal projection, by idempotence and self-adjointness of the group average. Evaluate its matrix coefficient between \(f^{\otimes r}\otimes\overline f^{\otimes r}\) and \(g^{\otimes r}\otimes\overline g^{\otimes r}\). It equals \(4^{-N}\sum_P|\langle f,Pg\rangle|^{2r}\). Cauchy–Schwarz for the positive projection gives (2).

Expand the Pauli expectations of a sum of vectors and apply Minkowski to the \(\ell^{2r}\) norm, then apply (2) to each mixed coefficient. This gives

\[
 W_{r,N}\!\left(\sum_j f_j\right)^{1/(4r)}
       \le\sum_j W_{r,N}(f_j)^{1/(4r)} .
 \qquad\text{(3)}
\]

For nonnegative real amplitudes there is also a positive expansion. With binary phase-free representatives \(X^a Z^b\), each expectation is a real signed Fourier sum of \(f(x)f(x+a)\). Its absolute \(2r\)-th power is its ordinary \(2r\)-th power. Summing over \(b\) divided by \(2^N\) retains exactly \(2r\) words \(x_1,\ldots,x_{2r}\) with bitwise XOR zero. The companion entries are all shifted by the same binary word \(a\). Every retained product is nonnegative. In particular, for a positive-amplitude sum over disjoint sectors, it contains the contribution with all entries in any one sector.

Put \(q_j=|c_j|^2\) for a normalized state \(\sum_j c_j D_{n_j}^N\) and \(J\) for its number of terms. Positivity and (3) therefore give

\[
 \max_j q_j^{2r}W_{r,N}(D_{n_j}^N)
 \le W_{r,N}\!\left(\sum_j c_jD_{n_j}^N\right)
 \le J^{4r}\max_j q_j^{2r}W_{r,N}(D_{n_j}^N).
 \qquad\text{(4)}
\]
The upper bound holds for arbitrary complex coefficients. The lower bound as stated uses nonnegativity.

## 3. A uniform Dicke-state count

For an exact sector \(n\), the positive expansion reduces \(W_{r,N}(D_n^N)\) to the number of allowed \(N\)-column arrays divided by \(\binom{N}{n}^{2r}\). A column is specified by one shift bit \(a\) and a \(2r\)-bit vector \(x\) of even parity. Its \(4r\) entries are \(x\) and \(x+a\). Each of the \(4r\) rows must sum to \(n\). There are \(4^r\) allowed column types. If \(a=0\) the column has \(2l\) ones when \(x\) has \(l\) ones, with \(l\) even. If \(a=1\) it always has \(2r\) ones. Counting the types by their total number of ones gives exactly \(Z_r(z)\).

Permuting the \(2r\) slots simultaneously in both halves and swapping the two halves act transitively on the rows and preserve the types. At a given \(z>0\), put mass proportional to \(z^{w}\) on a column with \(w\) ones. Its row means are equal by this symmetry. As \(z\) runs from zero to infinity its total mean moves continuously and strictly from zero to \(4r\). The derivative of that mean with respect to \(\log z\) is the positive variance of \(w\). For \(0<n<N\), choose the unique tilt with each row mean \(q=n/N\). The relative entropy inequality against the tilted law shows that this law maximizes entropy under the row constraints, with value \(s_r(q)\). The endpoint distributions are the all-zero and all-one columns and have entropy zero.

For an integer column type close to this entropy maximizer, floor each expected count \(N p_c\), where \(p_c\) is its tilted probability. The floors respect the row symmetries, so all missing row totals equal the same integer \(j\). If \(d\) is the number of remaining column slots, \(0\le j\le d<4^r\): the missing row count is a sum of fractional residual counts over columns containing that row. Fill \(j\) slots with the all-one column and \(d-j\) slots with the all-zero column. This gives an admissible integer type with total variation distance at most \(d/N\) from the maximizing law. Both extreme columns are allowed because \(2r\) is even.

Write \(C_r=4^r\). For \(N\ge2 C_r\), the entropy difference between the rounded type and its target is \(O(C_r\log(N+1)/N)\), with universal constant. For example, couple two laws at total variation distance \(\delta\); the entropy change is at most \(h_2(\delta)+\delta\log_2(C_r-1)\) by conditioning on disagreement. The multinomial type count lies between \(2^{N H}/(N+1)^{C_r}\) and \(2^{N H}\) for a type of entropy \(H\). There are at most \((N+1)^{C_r}\) integer types. Applying the lower estimate to the rounded type and the upper estimate to every admissible type shows that the logarithm of the array count is \(N s_r(q)+O(C_r\log(N+1))\). Finally \(\log_2\binom{N}{n}=N h_2(q)+O(\log(N+1))\) uniformly in \(q\). We have proved

\[
 M_r(D_n^N)=N d_r(n/N)+O\!\left(\frac{4^r}{r-1}\log(N+1)\right).
 \qquad\text{(5)}
\]

## 4. Sector optimization and arbitrary phases

Let \(p_n=b_n/Z\). Taking logarithms of (4) shows that for positive amplitudes the entropy differs from

\[
 \min_{n\in\Omega}\{M_r(D_n^N)-L_r\log_2 p_n\}
\]

by at most \(4r\log_2|\Omega|/(r-1)\). The elementary binomial type estimate bounds \(b_n\) between \(2^{-N D_2(n/N\Vert p)}/(N+1)\) and \(2^{-N D_2(n/N\Vert p)}\). The same maximum-term bounds on \(Z\), with a factor of at most \(|\Omega|\), give

\[
 -\log_2 p_n
 =N\left[D_2(n/N\Vert p)-\min_{m\in\Omega}D_2(m/N\Vert p)\right]
    +O(\log(N+1)).
\]

The constants are uniform in \(0<p<1\). Together with (5) this proves the positive-amplitude part of Theorem 1.

Both discrete minima in (1) are easy to locate on an ordered grid. The relative entropy has continuous minimizer \(q=p\). For the moment objective, the entropy terms cancel to leave

\[
 F_r(q)=d_r(q)+L_r D_2(q\Vert p)
   =\frac{-s_r(q)-2r[q\log_2 p+(1-q)\log_2(1-p)]}{r-1}.
 \qquad\text{(6)}
\]
The function \(s_r\) is strictly concave on the open interval because the tilt's mean is strictly increasing in its log parameter. Its derivative at its tilt \(z\) is \(-4r\log_2 z\). Thus \(F_r\) is strictly convex, and its continuous minimizer is the row mean at

\[
 z_*=\sqrt{p/(1-p)}.
\]
For each minimum, monotonicity on either side of its continuous minimizer leaves at most two adjacent grid points to compare. The unrestricted value of \(F_r\) is
\[
 a_r(p)=-\frac{1}{r-1}\log_2\big[(1-p)^{2r} Z_r(z_*)\big].
 \qquad\text{(7)}
\]
The binomial expansion over even \(l\) gives
\[
 (1-p)^{2r} Z_r(z_*)=
 \frac{1+(1-2p)^{2r}+(2\sqrt{p(1-p)})^{2r}}{2}.
\]
This is the single-qubit Pauli moment at an aligned coherent phase, so (7) is also its product entropy density.

For arbitrary phases the moment upper bound in (4) already holds. For the other direction on a progression \(n_j=n_0+jK\), use the coefficient norm \(\|A\|_{\mathcal P,1}=\sum_P|a_P|\) when \(A=\sum_P a_P P\). Products of Pauli strings preserve this coefficient norm submultiplicatively. For normalized \(\psi\), put \(s=\|A\psi\|^2>0\) and \(\eta=A\psi/\sqrt{s}\). The expansion of each coefficient of \(A\psi\), followed by Minkowski, gives
\[
 s^{2r} W_{r,N}(\eta)\le \|A\|_{\mathcal P,1}^{4r} W_{r,N}(\psi).
 \qquad\text{(8)}
\]
Indeed for fixed left and right Pauli strings their multiplication permutes the coefficient index up to phase.

Let \(\widehat N=\frac{1}{2}\sum_i(I-Z_i)\) be the number operator, and use the pinned polynomial filter
\[
 A_j=\prod_{i\ne j}\frac{\widehat N-n_i I}{n_j-n_i}.
\]
It selects exactly sector \(j\) on the occupied span. Each numerator has coefficient norm at most \(N\). With \(d=|\Omega|-1\), the denominator has magnitude \(K^d j!(d-j)!\). For \(d>0\), factorial bounds give \(\|A_j\|_{\mathcal P,1}\le(2eN/(Kd))^d\). Since \(d\le N/K\) and \(x\log(2e/x)\) increases on \((0,1]\), its base-two logarithm is at most \((N/K)\log_2(2e)\). For \(d=0\) the filter is the identity. With \(s=p_{n_j}\), (8) shows
\[
 M_r(\Psi)\le M_r(D_{n_j}^N)-L_r\log_2 p_{n_j}
                +\frac{4r}{r-1}\log_2\|A_j\|_{\mathcal P,1}.
\]
Minimizing over \(j\) proves the added \(O(N/K)\) term in Theorem 1, with a universal coefficient since \(r\ge2\).

## 5. Coherent azimuth and the full sequence of moduli

Consider projection of the coherent product with single-qubit state
\(v_{p,\theta}=\sqrt{1-p}|0\rangle+e^{i\theta}\sqrt p|1\rangle\)
onto the residue \(a\bmod K\) of the Hamming weight. Write \(a_{r,K}(p,\theta)\) for the minimum single-qubit \(M_r\) among the \(K\) branch azimuths \(\theta+2\pi j/K\). The normalized projected state is the Fourier sum of those \(K\) product vectors, with coefficients of common absolute value \(1/(K\sqrt Z)\). Applying (3) gives the exact lower bound
\[
 M_r(\Psi)\ge N a_{r,K}(p,\theta)+L_r\log_2 Z.
 \qquad\text{(9)}
\]

Suppose \(m=K-1\le N\). Choose a branch attaining the least single-qubit entropy. Apply a product bra on \(m\) qubits, using one normalized bra orthogonal to each unwanted branch. All other terms are annihilated. For the chosen branch the product of overlaps has magnitude \(K[p(1-p)]^{m/2}\), since the product of its distances from the other \(K\)-th roots of unity is \(K\). Thus the squared norm after the bra is \(s=[p(1-p)]^{m}/Z\), and the normalized survivor is the chosen product branch on \(N-m\) qubits.

The relevant postselection estimate at order \(r\) is
\[
 s^{2r} W_{r,N-m}(\eta)\le 2^{m(r-1)} W_{r,N}(\psi),
 \qquad\text{(10)}
\]
for any normalized bra \(\chi\) and normalized survivor \(\eta\). In a Hermitian Pauli basis on the discarded qubits set \(v_A=\langle\chi,A\chi\rangle\), and \(r_{AB}=\langle\psi,(A\otimes B)\psi\rangle\). Then \(s\,r_B(\eta)=2^{-m}\sum_A v_A r_{AB}\). The identity \(\sum_A|v_A|^2=2^m\) follows from orthogonality of the Pauli basis. Hölder with exponent \(2r/(2r-1)\), then the comparison of its norm to the two-norm over \(4^m\) entries, gives
\[
 (2^{-m}\|v\|_{2r/(2r-1)})^{2r}\le 2^{m(r-2)} .
\]
Summing over \(B\) and accounting for the two Pauli normalizations adds a factor \(2^m\), proving (10). Substituting the chosen postselection gives
\[
 M_r(\Psi)\le (N-m)a_{r,K}(p,\theta)+m
               -L_r m\log_2[p(1-p)]+L_r\log_2 Z.
 \qquad\text{(11)}
\]
The bras and filters are mathematical estimates on the moment, with no assertion about the cost of physical preparation.

For each fixed \(p\in(0,1)\), the bounds (9) and (11) give
\(M_r(\Psi)/N-a_{r,K}(p,\theta)\to0\)
whenever \(K=o(N)\). Indeed a grid weight is within \(O(K/N)\) of \(p\) and the binomial estimate gives \(-\log_2 Z=O_p(\log N+K^2/N)\). The single-qubit entropy is at most \(1/(r-1)\), so these bounds are uniform in \(r\ge2\).

The nearest branch to an aligned Pauli axis has angular distance at most \(\pi/K\). At distance \(\delta\) near an axis, the Pauli moment is at least \(\cos^{2r}\delta\) times the aligned moment, by the explicit Bloch components. The aligned moment is maximal over all azimuths since \(\cos^{2r}\delta+\sin^{2r}\delta\le1\). Consequently, for large \(K\),
\[
 0\le a_{r,K}(p,\theta)-a_r(p)\le O(K^{-2})
\]
uniformly over \(r\ge2,p,\theta\), since \(r/(r-1)\le2\). The case of bounded \(K\) needs no such approximation. For example at \(p=1/2,K=2,\theta=\pi/4\) the branch entropy is \([1-\log_2(1+2^{1-r})]/(r-1)\), whereas the aligned value is zero.

To give one statement for all modulus sequences, let \(r=r_N\ge2\) satisfy \(N\ge2\cdot4^r\) and \(4^r\log(N+1)/(N(r-1))\to0\), which includes every fixed integer order. For coherent offsets and all sequences of nonempty residues, we have
\[
 \frac{M_r(\Psi)}{N}
  -\big[V_r+a_{r,K}(p,\theta)-a_r(p)\big]\longrightarrow0.
 \qquad\text{(12)}
\]
For \(K\le\sqrt N\), the grid minimum of each term in (1) approaches its continuous minimum uniformly in these orders. For (6) its endpoint values are at most \(4\max(-\log_2 p,-\log_2(1-p))\), and its minimum is nonnegative. From its minimizer move toward the farther endpoint and choose a grid point within \(K/N\). Convexity bounds the increase by the corresponding fraction of the endpoint gap, which is \(O_p(K/N)\). The same argument applies to binary relative entropy. Thus \(V_r-a_r(p)\to0\) uniformly in this case, and (9)–(11) prove (12). For \(K>\sqrt N\), the arbitrary-phase estimate of Theorem 1 applies and the branch correction vanishes. This proves the combined formula, including sequences with changing offsets or moduli.

The modulus here is the gap of the occupied Hamming weights. A congruence imposed on the signed magnetization \(N-2n\) instead gives a gap equal to its modulus divided by its greatest common divisor with two, whenever the congruence is solvable.

## 6. Source and scope

The higher-order Pauli projection and parity types extend the archived fourth-moment theorem to every integer order at least two. The fourth-moment number and root-of-unity filters from that source are used with the new moment inequalities. The results distinguish arbitrary phases on sufficiently wide-spaced grids from coherent azimuth phases at bounded gaps. The formulas concern stabilizer Rényi entropies and make no claim about noninteger orders or operational distillation. The comparison is limited to the pinned repository record.
