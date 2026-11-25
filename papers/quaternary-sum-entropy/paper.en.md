# Entropy of independent four-letter sums: exact ray classes and unrestricted asymptotics

## Abstract

A multiplicative comparison on complex rays gives real-rooted residue sections for products of an explicit class of cubic probability generating functions. We characterize the class, obtain the sharp entropy and its equality cases within it, and extend the method to tilted symmetric five-letter laws. A finite family shows that certain separate conditional-binomial entropy bounds fail for arbitrary four-letter factors. We prove a stability estimate for perturbations of the ray class.

For unrestricted independent four-letter factors, we determine the entropy maximum through its first $1/n$ correction. Every array within $o(1/n)$ of the candidate maximum has one factor tending to $(1/6,1/3,1/3,1/6)$, with vanishing total intermediate occupancy among the others and vanishing summed squared mean deviations. Finite-$n$ exact equality outside the ray class remains open. Full formalization remains incomplete.

## 1. Fixed question and attribution

Let $B_m\sim\operatorname{Bin}(m,1/2)$, including $B_0=0$, and let H denote entropy in bits. The reserved question asks whether, for every $n\ge3$ and arbitrary independent heterogeneous $X_i\in\{0,1,2,3\}$,
$$
H\left(\sum_iX_i\right)\le C_{n,3},\qquad
C_{n,r}=\log_2\!\left(2^{H(B_n)}+(r-1)2^{H(B_{n-1})}\right).
\tag{1.1}
$$
All degenerate and asymmetric marginals remain in the target.

Kovačević [K21] supplied the candidate and attaining construction for every n,r, and proved special cases including n=2 for arbitrary alphabets. His construction uses n−1 fair endpoint variables on $\{0,r\}$. The last variable assigns mass $w_{n,r}/2$ to each endpoint and $(1-w_{n,r})/(r-1)$ to every interior point, where
$$
w_{n,r}=\frac{2^{H(B_n)}}{2^{H(B_n)}+(r-1)2^{H(B_{n-1})}}.
\tag{1.2}
$$
These formulas, the construction, and residue decomposition are prior work. [K26] settles r=2 for all n. Its Section 5 gives a four-letter example whose residue polynomial is neither real-rooted nor ULC. Sections 2–7 give the structural result and its boundaries. Section 9 gives the unrestricted asymptotic value and the behavior of all near-maximizers.

## 2. Monotone phase and residue roots

Write a degree-rn real polynomial as
$$
F(z)=\sum_{j=0}^{r-1}z^jF_j(z^r).
\tag{2.1}
$$
For a probability generating function, the normalized coefficients of $F_j$ give the law of $(S-j)/r$ conditional on $S\bmod r=j$.

**Lemma 2.1.** Let r≥2 be an integer, and let $P(z)=\sum_{k=0}^r a_kz^k$ have all $a_k>0$. For $\alpha=\pi/r$, the continuous argument
$\phi(\rho)=\arg P(\rho e^{i\alpha})$ lies in (0,π), increases strictly, and tends from 0 to π.

**Proof.** The imaginary part is positive because the interior sine terms are positive. Expanding the argument derivative gives
$$
|P(\rho e^{i\alpha})|^2\phi'(\rho)
=\sum_{0\le k<\ell\le r}(\ell-k)a_ka_\ell
 \rho^{k+\ell-1}\sin((\ell-k)\alpha)>0.
\tag{2.2}
$$
The endpoint-pair sine is zero and the other terms are nonnegative, with positive terms present. The constant and leading terms give the endpoint limits. For a product of n factors, the unwrapped phase $\theta=\sum_i\phi_i$ therefore increases from 0 to nπ. This is not the principal argument of the product. $\square$

**Theorem 2.2.** Let n≥1. For $F=\prod_{i=1}^nP_i$, suppose each factor has positive coefficients in degree r.

- If r=3, assume $|P_i(-\rho)|\le|P_i(\rho e^{i\pi/3})|$ for every ρ>0.
- If r=4, assume $|P_i(\rho e^{3i\pi/4})|<|P_i(\rho e^{i\pi/4})|$ for every ρ>0.

Then $F_0$ has n simple negative roots; each other section has n−1 simple negative roots. Nonzero coefficientwise limits have only real nonpositive roots; multiplicities, zero roots, and degree loss are allowed.

**Proof for r=3.** Put $z=\rho e^{i\pi/3}$. The roots-of-unity filter gives
$$
3\rho^jF_j(-\rho^3)
=2|F(z)|\cos(\theta-j\pi/3)+(-1)^jF(-\rho).
\tag{2.3}
$$
The factor inequalities multiply, so $|F(-\rho)|\le|F(z)|$. At the unique points where $\theta=j\pi/3+k\pi$, the right side has sign $(-1)^k$: the main term has twice the maximum remainder magnitude. For j=1,2, k=0,…,n−1 gives n internal sample points and hence n−1 distinct negative roots. For j=0, use k=1,…,n−1 together with the positive constant term at zero and the leading sign $(-1)^n$ at infinity. The number of distinct roots exhausts the corresponding degrees n and n−1, so all are simple.

For r=4 the filter is
$$
4\rho^jF_j(-\rho^4)=
2\Re\{e^{-ij\pi/4}F(\rho e^{i\pi/4})\}
+2\Re\{e^{-3ij\pi/4}F(\rho e^{3i\pi/4})\}.
\tag{2.4}
$$
At the first term's phase knots its magnitude strictly exceeds that of the remainder. The same count works. Bounded-degree real-rootedness is closed under coefficient convergence for nonzero limits; simplicity need not persist. $\square$

The extra modulus inequality is essential. Basic zero-free-sector information for positive-coefficient factors alone does not imply this theorem.

## 3. The exact cubic ray class

For a normalized nonnegative cubic
$P(z)=a+bz+cz^2+dz^3$, define
$$
R_P(\rho)=ab-ac\rho+bc\rho^2-bd\rho^3+cd\rho^4.
\tag{3.1}
$$
Let $\mathcal C_3$ consist of all these probability vectors with $R_P(\rho)\ge0$ for every ρ>0. We do not assert that this is a necessary condition for the entropy conjecture.

**Proposition 3.1.**
$$
|P(\rho e^{i\pi/3})|^2-|P(-\rho)|^2=3\rho R_P(\rho).
\tag{3.2}
$$
Every member of $\mathcal C_3$ is a coefficientwise limit of positive members.

The identity follows by using real part
$a+b\rho/2-c\rho^2/2-d\rho^3$ and imaginary part
$\sqrt3(b\rho+c\rho^2)/2$, then expanding.

For the boundary statement, normalize only after approximation, since the condition is homogeneous. If b,c>0, a=0 and d>0, the condition reduces to $v=bd/c^2\le4$. Add a sufficiently small positive a; the strip criterion below applies. Reflect for d=0. If both endpoints vanish, add small endpoints making $ac/b^2=bd/c^2$. If b=0<c, the condition forces a=0. Set
$$
b_\epsilon=\epsilon,\quad d_\epsilon=d+\epsilon,\quad
a_\epsilon=\epsilon^3d_\epsilon/c^3
$$
and keep c; the two ratios coincide. Reflect for c=0<b. If b=c=0, take
$$
a_\epsilon=a+\epsilon,\ d_\epsilon=d+\epsilon,\quad
b_\epsilon=\epsilon a_\epsilon^{1/3},\
c_\epsilon=\epsilon d_\epsilon^{1/3},
$$
again making the ratios equal. These cases exhaust the nonzero probability polynomials. $\square$

**Proposition 3.2.** For a,b,c,d>0 set
$$
u=ac/b^2,\quad v=bd/c^2,\qquad
\Phi(v)=\min_{t>1}\{t^2/(t-1)+vt^3\}.
$$
Membership in $\mathcal C_3$ is equivalent to
$$
\max(u,v)\le\Phi(\min(u,v)).
\tag{3.3}
$$
The unique minimizer $t_v\in(1,2)$ satisfies
$$
3vt_v(t_v-1)^2=2-t_v,\qquad
\Phi(v)=\frac{t_v^2(2t_v-1)}{3(t_v-1)^2}.
\tag{3.4}
$$

**Proof.** With $t=c\rho/b$,
$$
R_P(\rho)/(bc\rho^2)
=K(t)=1+u(t^{-2}-t^{-1})+v(t^2-t).
\tag{3.5}
$$
Assume u≥v. The two bracketed expressions sum to
$(t+t^{-1}-2)(t+t^{-1}+1)\ge0$, so K>0 for 0<t≤1. For t>1, K≥0 is exactly $u\le t^2/(t-1)+vt^3$. Reflection swaps u,v and replaces t by 1/t. The derivative of the minimized expression is
$t\{(t-2)/(t-1)^2+3vt\}$. Equation (3.4) has one root in (1,2), since its left side increases strictly and its right side decreases. The objective tends to infinity at 1 and infinity. Substitution gives Φ. $\square$

**Corollary 3.3.** $|u-v|\le4$ suffices, and 4 is the largest universal strip width that guarantees this ray condition. Indeed $\Phi(v)\ge4+v$. For any C>4, let δ=C−4 and take b=c=1, a=4+δ, d=δ/16 before normalization. Then $|u-v|=4+15δ/16<C$, but $K(2)=-δ/8<0$. This is sharpness of a ray criterion, not a counterexample to the entropy conjecture.

**Corollary 3.4.** The class includes all normalized individually tilted symmetric cubics
$$
\frac{P_\lambda(\tau z)}{P_\lambda(\tau)},\qquad
P_\lambda(z)=\frac{\lambda(1+z^3)+(1-\lambda)(z+z^2)}2,\quad
0\le\lambda\le1,\ \tau>0.
\tag{3.6}
$$
Each factor may use a different λ and τ. In the positive case u=v; the boundary follows by limits.

## 4. Sharp entropy and complete cubic equality

Newton's inequalities and the preceding limiting argument give ULC of orders n,n−1,n−1. Real nonpositive roots ensure interval support; the order-N inequalities survive even if the limit loses degree. Yu's fixed-mean maximum-entropy theorem and uniqueness [Y10, Theorems 4–5], with the classical unique maximum of binomial entropy at success probability 1/2 [SO], give
$$
H(q)\le H(B_N),\qquad
H(q)=H(B_N)\ \Longleftrightarrow\ q=\mathcal L(B_N).
\tag{4.1}
$$
N=0 and endpoint means are the trivial point-mass cases and are handled before applying the fixed-mean theorem. These are classical dependencies.

**Theorem 4.2.** For all n≥1 and independent marginals in $\mathcal C_3$,
$H(S)\le C_{n,3}$. Equality occurs exactly at a permutation of n−1 fair endpoint marginals and
$$
(w/2,(1-w)/2,(1-w)/2,w/2),\qquad w=w_{n,3}.
\tag{4.2}
$$

**Proof.** Let J=S mod 3, $w_j=\Pr(J=j)$ and $N_0=n,N_1=N_2=n-1$. Zero-mass conditional events contribute zero. Then
$$
H(S)\le H(w)+\sum_jw_jH(B_{N_j})
\le\log_2\sum_j2^{H(B_{N_j})}=C_{n,3}.
\tag{4.3}
$$
The finite Gibbs variational identity has unique optimum
$w_j^*=2^{H(B_{N_j})}/\sum_\ell2^{H(B_{N_\ell})}$.
The known construction belongs to the class and attains both inequalities.

Equality fixes all positive residue weights and all conditional laws, hence
$$
F(z)=((1+z^3)/2)^{n-1}P_w(z).
\tag{4.4}
$$
The positive first and last coefficients force every original factor to have degree three and positive constant coefficient. The entropy increment satisfies $0<H(B_n)-H(B_{n-1})\le1$: strict positivity follows from mixing a finite law with its distinct unit shift, and the upper bound from the entropy chain rule. Thus $1/3<w\le1/2$. Now
$$
1+z^3=(1+z)(z^2-z+1),\qquad
2P_w=(1+z)\{wz^2+(1-2w)z+w\}.
\tag{4.5}
$$
Both quadratics are irreducible over the reals and distinct. The sole real root of F is −1, of multiplicity n. Each of its n real cubic factors needs at least one real root, so each has exactly one copy of −1 and one conjugate pair. Unique real factorization leaves only the fair endpoint factor and $P_w$, the latter exactly once. Normalization fixes each constant. $\square$

## 5. Symmetric five-letter factors

For $P(z)=a+bz+cz^2+bz^3+az^4$ with a,b,c>0,
$$
|P(\rho e^{i\pi/4})|^2-|P(\rho e^{3i\pi/4})|^2
=2\sqrt2\,b\rho(1+\rho^2)
 \{a(\rho^2-1)^2+c\rho^2\}>0.
\tag{5.1}
$$
This exact identity survives positive scaling of z and positive normalization. Theorem 2.2 therefore applies to arbitrary products of individually tilted symmetric quartics. Nonnegative coefficients follow by positive approximation.

**Theorem 5.2.** For independent five-letter marginals of this type, or coefficientwise limits,
$$
H(S)\le C_{n,4}=
\log_2\{2^{H(B_n)}+3\,2^{H(B_{n-1})}\}.
\tag{5.2}
$$
Apply (4.3) to four sections with orders n,n−1,n−1,n−1. [K21]'s symmetric construction attains the bound. Equality fixes the entire sum law. A complete classification of the quartic input factorizations is not asserted. This is a reuse of the mechanism, not a change of the original four-letter target.

## 6. A known four-point tool and a new local application

**Lemma 6.1 (special case of [HS16]).** If a probability vector (a,b,c,d) satisfies $bc\ge9ad$, then $H(a,b,c,d)\le H(B_3)$, with equality only at (1,3,3,1)/8.

The fixed-ratio version follows from Hasenclever–Scholz, Theorem 1, after arranging the table with rows (b,a) and (d,c). For a strict larger ratio, mixing with the uniform law increases entropy and reaches ratio nine by continuity. Zero boundaries follow by continuity. This is not counted as an original theorem.

A self-contained proof uses natural entropy. Average b,c, preserving feasibility and increasing entropy. Write t=a+d. If t≤1/4, entropy is at most $h(t)+\ln2\le h(1/4)+\ln2$. If 1/4<t<1, fixed-t endpoint entropy increases strictly with ad, so the maximum has $ad=(1-t)^2/36$. Up to reflection the vector is proportional to $(e^s,3,3,e^{-s})$, s>0. With Z=6+2 cosh s,
$$
E'(s)=4\{3\ln3\sinh s-3s\cosh s-s\}/Z^2<0.
$$
Indeed $3\ln3<4$, and $G=3s\cosh s+s-4\sinh s$ has G(0)=G'(0)=0 and $G''=2\sinh s+3s\cosh s>0$. At t=1 feasibility gives a point mass. The equality is unique.

For three arbitrary independent four-letter inputs, let q be the actual sum law. Retain only endpoint terms of the factors, with coefficients E0,E1,E2,E3 at degrees 0,3,6,9. Then
$$
\begin{aligned}
E_1E_2-9E_0E_3={}&x_0x_3(y_0z_3-y_3z_0)^2\\
&+y_0y_3(x_0z_3-x_3z_0)^2\\
&+z_0z_3(x_0y_3-x_3y_0)^2\ge0.
\end{aligned}
\tag{6.1}
$$
Since q0=E0, q9=E3, q3≥E1 and q6≥E2,
$q_3q_6\ge9q_0q_9$. Thus, when the event has positive mass,
$$
H(S\mid S\equiv0\pmod3)\le H(B_3).
\tag{6.2}
$$
This conditional equality does not classify input marginals: two laws (1/4,1/2,0,1/4) and one fair endpoint law also attain it.

## 7. A quantitative obstruction for every n

Take two independent fair variables on {0,2} and one uniform variable on {0,1,3}. Their sum has generating polynomial
$$
(1+z^2)^2(1+z+z^3)/12
=(1+z+2z^2+3z^3+z^4+3z^5+z^7)/12.
\tag{7.1}
$$
Residue one has mass 1/4 and a uniform three-point quotient. Its entropy is $\log_2 3>3/2=H(B_2)$, equivalently 9>8. The full entropy is about 2.625814584 bits, below the conjectured global value. This is a proof-bridge counterexample only.

Append m=n−3 fair variables on {0,3}. The residue-one quotient becomes $B_m+U_3$, with independent uniform U3 on {0,1,2}. For every m≥0,
$$
H(B_m+U_3)-H(B_{m+2})
\ge\frac1{16(m+2)\ln2}>0.
\tag{7.2}
$$

**Proof.** Use natural entropy, N=m+2, and interpolate
$r_t=\mathcal L(B_m)*(1/4+t,1/2-2t,1/4+t)$, 0≤t≤1/12.
For $b_s=2^{-N}\binom Ns$, binomial algebra gives
$$
r_t(s)=b_sR_s(t),\quad
R_s(t)=1+\frac{4t((N-2s)^2-N)}{N(N-1)}.
\tag{7.3}
$$
All probabilities are positive. Differentiating the finite entropy sum yields
$$
\frac d{dt}H_{\mathrm{nat}}(r_t)
=\sum_{j=0}^m\Pr(B_m=j)
 \ln\frac{r_t(j+1)^2}{r_t(j)r_t(j+2)}.
\tag{7.4}
$$
For N≥3, binomial log-curvature is at least 4/(N+2), by
$\ln(1+x)\ge x/(1+x)$. Moreover
$R_s\ge1-1/[3(N-1)]$ and
$R_{s-1}+R_{s+1}-2R_s=32t/[N(N-1)]$.
Using $\ln x\le x-1$,
$$
\ln\frac{r_t(s)^2}{r_t(s-1)r_t(s+1)}
\ge\frac4{N+2}-\frac8{N(3N-4)}
\ge\frac3{4N}.
\tag{7.5}
$$
The last inequality is equivalent to $39N^2-102N-40\ge0$, true at N=3 and increasing thereafter. Integrate (7.4) over length 1/12. When N=2, the exact gap is $\tfrac12\ln(9/8)\ge1/18>1/32$. This proves all m, without an asymptotic assumption. $\square$

## 8. Stability under departure from the cubic ray class

Let the $X_i$ have arbitrary laws on $\{0,1,2,3\}$, and let the $Y_i$ belong to the cubic ray class including its admitted boundary. Within each array the factors are independent. Write $S_X=\sum_iX_i$, $S_Y=\sum_iY_i$ and let $H_*=C_{n,3}$ in bits. Set $e_i=\operatorname{TV}(X_i,Y_i)$, $w_i=W_1(X_i,Y_i)$ for the integer distance, and let $Z_i$ denote the independent sum with the first $i-1$ factors from $X$ and the last $n-i$ from $Y$. Denote $d_i=\operatorname{TV}(Z_i,Z_i+1)$. Then
$$
 H(S_X)\le H_*+h_2(u)+u\log_2(3n),\qquad
 u=\min\left\{\frac{3n}{3n+1},\ 1-\prod_i(1-e_i),\ \sum_i w_i d_i\right\},
$$
where $h_2$ denotes binary entropy in bits.

Independently coupling each array coordinate maximally gives the product bound on $\operatorname{TV}(S_X,S_Y)$. In a second bound, the triangle inequality gives $\operatorname{TV}(Z_i+a,Z_i+b)\le |a-b|d_i$. Mixing on each pair of coordinates with a minimum transportation cost coupling and replacing one coordinate at a time yields $\operatorname{TV}(S_X,S_Y)\le\sum_i w_i d_i$. A maximal coupling of the two sums has mismatch probability $p=\operatorname{TV}(S_X,S_Y)$. Their conditional entropy is at most $h_2(p)+p\log_2(3n)$ because the sum alphabet has $3n+1$ points. The bound increases up to $p=3n/(3n+1)$, where it attains its global maximum. This proves the stated capped estimate.

For example, suppose only a fixed number of factors differ between the arrays, and at least $\ell$ otherwise unchanged factors are fair on $\{0,1\}$. For any altered coordinate, $Z_i$ includes these $\ell$ factors. Convolution contracts total variation and the binomial mass is unimodal, giving
$$
 d_i\le 2^{-\ell}\binom{\ell}{\lfloor\ell/2\rfloor}.
$$
The fair $\{0,1\}$ laws are among the admitted boundary factors. If $\ell$ is proportional to $n$, the resulting entropy excess bound is $O(\log n/\sqrt n)$.

## 9. Unrestricted asymptotic optimum and inverse theorem

In this section only, entropy and logarithms are natural. The candidate $C_n$ used here equals $(\ln 2)C_{n,3}$ from §1. Let $B_n$ be the fair binomial and $C_n=\log(e^{H(B_n)}+2e^{H(B_{n-1})})$. For independent arbitrary four-letter $X_i\in\{0,1,2,3\}$, let $M_n=\max H(S)$, $S=\sum_iX_i$. Then
$$
 0\le M_n-C_n=o(1/n),\qquad
 M_n=\log3+\tfrac12\log(\pi e n/2)-\tfrac1{3n}+o(n^{-1}).
$$
Moreover, for **every** triangular array satisfying $H(S)\ge C_n-o(1/n)$, one can relabel the factors so that the first law tends to $(1/6,1/3,1/3,1/6)$, while
$$
 \sum_{i>1}\Pr(X_i\in\{1,2\})\longrightarrow0,\qquad
 \sum_{i=1}^n(\mathbb EX_i-3/2)^2\longrightarrow0.
$$
Both statements allow asymmetric factors and failures of the complex-ray or conditional-binomial hypotheses. The inverse theorem singles out a single residue-randomizing factor even though the number of competing independent variables is unbounded.

### 9.1. Two entropy estimates

A lattice variable $Y$ of lattice spacing $h$ and variance $v$ satisfies, for any $s^2$ of order $n$,
$$
 H(Y)\le \tfrac12\log(2\pi s^2)-\log h+v/(2s^2)+O(e^{-c_h n}).
$$
Compare to a discrete Gaussian centered at the actual mean on the same lattice by nonnegativity of relative entropy. Poisson summation of its normalizer leaves the zero mode $\sqrt{2\pi s^2}/h$ and relative error bounded by $2\sum_{k\ge1}\exp(-2\pi^2s^2k^2/h^2)$, uniformly in the mean and lattice shift. This inequality also applies conditionally using the same $s^2$ for all classes. Secondly $H(B_n)=\tfrac12\log(\pi e n/2)+O(n^{-2})$. For a direct derivation, use Stirling with $k=n/2+D$ on $|D|\le n/4$ in $\log\binom nk$. The entropy term contributes $n\log2-2D^2/n-4D^4/(3n^3)+O(D^6/n^5)$, the log-prefactor contributes $-\tfrac12\log(\pi n/2)+2D^2/n^2+O(D^4/n^4)$, and the Stirling correction is $-1/(4n)+O((1+D^2)/n^3)$. The fair binomial has $\mathbb ED^2=n/4,\mathbb ED^4=3n^2/16-O(n),\mathbb ED^6=O(n^3)$; the omitted tails are exponentially small by a binomial Chernoff bound. The terms of order $1/n$ cancel. Substituting into $C_n$ gives the expansion displayed above. The known construction with $n-1$ fair endpoint factors realizes $C_n$.

### 9.2. Variance and residue concentration

It suffices to study arrays within $o(1/n)$ below the candidate or better; maximizers exist by compactness. Set $e_i=\Pr(X_i\in\{1,2\})$, $m_i=\mathbb EX_i-3/2$, and $D=9n/4-\operatorname{Var} S=\sum_i(2e_i+m_i^2)$, using the pointwise squared distances to $3/2$. In the lattice estimate take $h=1,\ s^2=9n/4$. Comparing to $C_n$ gives $D\le3/2+o(1)$. Put $J=S\bmod3$, $B=\operatorname{Var}(\mathbb E[S\mid J])$. Applying that same estimate conditionally with $h=3,\ s^2=9n/4$ gives
$$
 H(S)\le \tfrac12\log(2\pi e\,9n/4)-[\log3-H(J)]-\frac{2(D+B)}{9n}+O(e^{-cn}).
 \tag{9.1}
$$
In particular $H(J)\to\log3$, so with $\omega=e^{2\pi i/3}$ we have $\prod_i\mathbb E\omega^{X_i}=\mathbb E\omega^S\to0$.

Choose a first factor having maximal $e_i$. Since $\sum e_i\le3/4+o(1)$, each other $e_i\le3/8+o(1)$. Its residue characteristic magnitude is at least its real part $1-3e_i/2$. The product of these lower bounds for $i>1$ is bounded away from zero: all individual deficits are eventually below $0.6$ and their sum is bounded. Consequently $\mathbb E\omega^{X_1}\to0$. A distribution on three residues with its nontrivial Fourier coefficient tending to zero tends to uniform. Thus $e_1=2/3+o(1)$. Write $e=\sum_{i>1}e_i$, which now obeys $e\le1/12+o(1)$.

### 9.3. Conditional means and the inverse statement

Let $T=S-X_1$, $w_j=\Pr(X_1\bmod3=j)=1/3+o(1)$, and $g_j=\mathbb E[X_1\mid X_1\bmod3=j]$; $g_1=1,g_2=2$. Eventually all these conditional laws exist. Uniformly in $j$,
$$
 \mathbb E[S\mid J=j]=\mathbb ET+\mathbb E[g_{j-T\bmod3}]+o(1).
 \tag{9.2}
$$
Indeed
$\Pr(J=j)=\mathbb E w_{j-T}$;
the centered numerator for the $T$ term is $\mathbb E[(T-\mathbb ET)w_{j-T}]=o(1)$. To verify the last assertion with no dimension-dependent loss, expand $w$ into three Fourier modes. Its two nonconstant coefficients are $o(1)$, and $|\mathbb E[(T-\mathbb ET)\omega^{\pm T}]|\le C e$. Expand the centered sum by independence, bounding each factor's centered Fourier contribution by $\mathbb E|(X_i-\mathbb EX_i)(\omega^{\pm X_i}-1)|\le6e_i$. The $X_1$ numerator is $\mathbb E[w_{j-T}g_{j-T}]$, with bounded $g$. This proves (9.2). Since $J$ tends to uniform and the three shifts on the right are bounded after subtracting $\mathbb ET$, Fourier orthogonality on $\mathbb Z/3$ now gives
$$
 B=|\mathbb E\omega^T|^2\operatorname{Var}_{j\ {\mathrm{uniform}}}g_j+o(1).
$$
The variance is at least $1/6$, minimized at $g_0=3/2$. The Fourier magnitude squared is at least $\prod_{i>1}(1-3e_i/2)^2\ge1-3e$, by the product deficit bound (all factors are positive for large $n$). Therefore
$$
 D+B\ge 4/3+2e+\sum_i m_i^2+(1-3e)/6+o(1)
      =3/2+3e/2+\sum_i m_i^2+o(1).
$$
Using (9.1) and the expansion of $C_n$, every near-maximizer must have $e+\sum m_i^2\to0$. The same inequality gives $H(S)\le C_n+o(1/n)$ for any maximizing sequence, proving the value statement. Finally uniform first-factor residues and $m_1\to0$ split its two endpoint probabilities equally, as asserted.

## 10. Literature and reproduction

Kovačević [K21] supplies the candidate, its construction, and the finite two-summand case across alphabets. His later three-letter theorem [K26] uses the structure of residue-class polynomials, and its §5 identifies failure of that route at four letters. The conditional lattice comparison in §9 uses ordinary relative entropy against a discrete Gaussian. Its first-order improvement comes from accounting for the variance between the conditional means after forcing residue randomization. This proves matching first correction and a structural inverse for all near-optimal arrays. The finite unrestricted candidate inequality (1.1) and related finite conditional-entropy bridges remain open. [Kovačević 2021](https://arxiv.org/abs/2008.01138v3) · [Kovačević 2026, §5](https://arxiv.org/html/2605.11831v1)

The original symbolic checks cover the ray identities, strip examples, and finite obstruction algebra. The reconstructed rational replay checks 5,664 coefficient instances, 59 conditional-law instances and 58 curvature comparisons. Numerical experiments supplement the analytic proof. Some historical computational outputs were unavailable. The original manuscript reports partial algebraic Lean coverage of Sections 2–7; the analytic phase, entropy and unrestricted limit arguments lack full formal verification. The programs and Lean source are not included in this edition.

## References

- [K21] M. Kovačević, On the Maximum Entropy of a Sum of Independent Discrete Random Variables. Theory of Probability and Its Applications 66(3), 482–487. [arXiv:2008.01138v3](https://arxiv.org/abs/2008.01138v3), DOI [10.1137/S0040585X97T99054X](https://doi.org/10.1137/S0040585X97T99054X).
- [K26] M. Kovačević, Maximum Entropy of Sums of Independent Ternary Random Variables. Statistics & Probability Letters 238, 110867. [arXiv:2605.11831v1](https://arxiv.org/html/2605.11831v1), DOI [10.1016/j.spl.2026.110867](https://doi.org/10.1016/j.spl.2026.110867).
- [Y10] Y. Yu, Relative log-concavity and a pair of triangle inequalities. Bernoulli 16(2), 459–470 (2010). [arXiv:1010.2043](https://arxiv.org/abs/1010.2043), DOI [10.3150/09-BEJ216](https://doi.org/10.3150/09-BEJ216).
- [SO] L. A. Shepp and I. Olkin, Entropy of the sum of independent Bernoulli random variables and of the multinomial distribution. Stanford Report 131 (1978); Contributions to Probability, 201–206 (1981). [Original scan](https://faculty.wharton.upenn.edu/wp-content/uploads/2012/04/Sum-of-idpt-bernoulli_rotated.pdf). Mateev's independent contribution is also credited.
- [HS16] D. Hasenclever and M. Scholz, Comparing Measures of Association in 2×2 Probability Tables. The Open Statistics & Probability Journal 7, 20–35 (2016), Theorem 1. DOI [10.2174/1876527001607010020](https://doi.org/10.2174/1876527001607010020).
- [AW] C. A. Athanasiadis and D. G. Wagner, Veronese sections and interlacing matrices of polynomials and formal power series. [arXiv:2404.12989v2](https://arxiv.org/html/2404.12989v2), 1 November 2026. The fully-interlacing/AESW input hypotheses do not hold automatically here.
- [J20] K. Jochemko, Symmetric decompositions and the Veronese construction. [arXiv:2004.05423v3](https://arxiv.org/html/2004.05423v3). Its rational-generating-function operator contains an additional fixed power.
- [HKK] O. Holtz, S. Khrushchev and O. Kushel, Generalized Hurwitz matrices, generalized Euclidean algorithm, and forbidden sectors of the complex plane. [arXiv:1506.07379](https://arxiv.org/abs/1506.07379), especially Section 8.

Novelty is bounded by the primary sources actually checked; global priority is not certified.

