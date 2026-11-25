# Exact ancilla-assisted entangling power of the four-qubit Fredkin gate

**AI-assisted research manuscript · 24 November 2026**  
**Audience:** researchers in quantum information and mathematical physics.  
**Verification:** complete analytic argument with a finite rational polynomial certificate. This manuscript does not claim external peer review or end-to-end Lean certification.

## Abstract

We determine the exact entangling power of the four-qubit doubly controlled SWAP gate under the fully product input convention of Qiu, Song and Chen, with arbitrary finite local ancillary systems. Its value is
$2.0005218601563057308\ldots$ ebits. The unique zero of a strictly monotone scalar function specifies this constant exactly. All maximizing inputs have identical control activation probabilities and maximally mixed target marginals; consequently ancillary qubits suffice for the targets and control ancillas are unnecessary. The proof first reduces arbitrary target states to commuting marginals. A finite rational certificate excludes the entire low-control-probability region. In the remaining region, explicit inequalities for the elementary symmetric polynomials of the output spectrum prove that both target marginals must be maximally mixed. A final scalar reparameterization proves uniqueness of the optimal control probability. For the explicitly defined family with any number of controls and two swapped target qubits, the same value is the entangling power whenever at least two controls are present. The earlier counterexample to the proposed two-ebit value and the numerical candidate for the optimum belong to the trureturing project; the contribution here is the global optimality proof, equality classification and stated multi-control extension.

## 1. The problem and the exact result

Let $A,B$ be control qubits, let $C,D$ be target qubits, and let $W_{CD}$ exchange the two targets. We consider

$$
F_4=I_{ABCD}+|11\rangle\langle11|_{AB}\otimes(W_{CD}-I_{CD}).
\tag{1.1}
$$

Each physical qubit $X$ may have its own finite-dimensional ancilla $R_X$. The input is required to have the form

$$
|\psi_A\rangle_{AR_A}\otimes|\psi_B\rangle_{BR_B}
\otimes|\psi_C\rangle_{CR_C}\otimes|\psi_D\rangle_{DR_D},
\tag{1.2}
$$

where each factor is a unit vector. Thus entanglement within one laboratory, between a qubit and its own ancilla, is allowed. There is initially no entanglement between distinct laboratories. The gate acts trivially on every ancilla. A bipartition always keeps a qubit and its own ancilla together.

Write $K_{AD:BC}(F_4)$ for the supremum of the output entropy on $AR_ADR_D$, measured in ebits, over all inputs (1.2). The multipartite entangling power $K_E(F_4)$ is the maximum over all bipartitions of the laboratories. These are the conventions in [1]. They differ from an average over random input states and from an assisted entangling power that permits initial entanglement between laboratories.

Qiu, Song and Chen obtained the interval $[2,\log_2 5]$ for the crossing cut and conjectured the lower endpoint to be exact [1, Section V, Conjecture 21]. The trureturing project subsequently gave a certified input with entropy $2.000344215\ldots$ and recorded a numerical optimum $2.0005218602$, obtained with pure controls and maximally mixed target marginals [2,3]. We retain those attributions. A numerical candidate or one violating input does not provide the global upper bound established below.

Throughout the proof, $\log$ is the natural logarithm. Define

$$
\begin{aligned}
D(z)&=z^2-z+2,\\
L(z)&=\frac{(1+z)^2}{D(z)^2},\qquad
x(z)=\frac{(1-z)^2}{D(z)^2},\\
m(z)&=\frac{z^2(1-z)^2}{D(z)^2},\\
\mathcal H(z)&=\log z+
\frac{(1+z)(3+z)}{2(1-2z)}
\frac{\log((1+z)/(1-z))}{z}.
\end{aligned}
\tag{1.3}
$$

**Theorem 1.1 (exact value and all maximizing inputs).** There is a unique zero $z_*$ of $\mathcal H$ in $(0,1/10)$. Put

$$
s_* =\frac{2(1-z_*)}{D(z_*)},
\qquad
K_*=-\frac{L(z_*)\log L(z_*)+3x(z_*)\log x(z_*)+m(z_*)\log m(z_*)}{\log2}.
\tag{1.4}
$$

Then

$$
K_{AD:BC}(F_4)=K_{AC:BD}(F_4)=K_E(F_4)=K_*>2.
\tag{1.5}
$$

An input (1.2) maximizes the entropy across $AD:BC$ if and only if

$$
\langle\psi_A|(|1\rangle\langle1|\otimes I)|\psi_A\rangle
=\langle\psi_B|(|1\rangle\langle1|\otimes I)|\psi_B\rangle=s_*;
\qquad
\rho_C=\rho_D=I_2/2,
\tag{1.6}
$$

where $\rho_C,\rho_D$ are the physical target marginals. In particular, an optimal input is

$$
(\sqrt{1-s_*}|0\rangle+\sqrt{s_*}|1\rangle)_A
\otimes(\sqrt{1-s_*}|0\rangle+\sqrt{s_*}|1\rangle)_B
\otimes|\Phi^+\rangle_{CR_C}\otimes|\Phi^+\rangle_{DR_D}.
\tag{1.7}
$$

For orientation, numerical evaluation gives

$$
\begin{aligned}
z_*&=0.0343431527750266744446053939755\ldots,\\
s_*&=0.981939216329808991377437622841\ldots,\\
K_*&=2.00052186015630573081437995144\ldots.
\end{aligned}
\tag{1.8}
$$

The exact definition is (1.3)–(1.4); the displayed decimals are evaluations of it. The exact rational verifier proves the strict enclosures

$$
\begin{aligned}
0.03434315277502667444460539397551
&<z_*<0.03434315277502667444460539397552,\\
2.0005218601563057308143799514
&<K_*<2.0005218601563057308143799515.
\end{aligned}
\tag{1.9}
$$

## 2. Reducing all ancillary inputs to four real parameters

### 2.1. The controls

Write

$$
|\psi_A\rangle=\sqrt{1-p}\,|\widehat0_A\rangle+
\sqrt p\,|\widehat1_A\rangle,
\tag{2.1}
$$

where $|\widehat j_A\rangle$ is supported on physical control value $j$. The two normalized vectors are orthogonal because their physical control values differ. A local isometry on $AR_A$ identifies them with an effective qubit basis. The gate only distinguishes their labels, so this isometry removes the control ancilla without changing any output Schmidt coefficients across the crossing cut. Zero-probability branches are handled by choosing an arbitrary orthogonal completion. The same argument applies to $B$, with probability $q$. Local phases can be absorbed into the effective bases.

Consequently the two controls may be taken as

$$
|\alpha_p\rangle=\sqrt{1-p}|0\rangle+\sqrt p|1\rangle,
\qquad
|\beta_q\rangle=\sqrt{1-q}|0\rangle+\sqrt q|1\rangle,
\tag{2.2}
$$

with $p,q\in[0,1]$. This reduction does not assume that the original control marginals are pure.

### 2.2. The targets and a commuting reduction

Every purification of a qubit density operator has Schmidt rank at most two. Up to an isometry on its local ancilla, it is therefore a purification using a qubit ancilla. For fixed $p,q$, write the crossing-cut output entropy as $f(\rho_C,\rho_D)$. Its value depends on the target purifications only through these two physical marginals, since different purifications are related by local ancillary isometries.

For fixed $\rho_D$, the reduced output on the $AD$ side is linear in $\rho_C$. Concavity of von Neumann entropy therefore makes $f$ concave in its first argument. It is likewise separately concave in the second argument by tracing the opposite side.

The SWAP commutes with $U\otimes U$. Thus

$$
f(U\rho_CU^\dagger,U\rho_DU^\dagger)=f(\rho_C,\rho_D).
\tag{2.3}
$$

Choose an eigenbasis of $\rho_D$ and dephase $\rho_C$ in that basis by averaging the identity and the diagonal sign unitary. Both unitaries leave $\rho_D$ invariant. Equations (2.3) and separate concavity show that the dephasing cannot decrease the entropy. Hence, for the purpose of an upper bound and of finding a maximizer, we may assume that the target marginals commute. A common unitary then gives

$$
\rho_C=\operatorname{diag}(c,1-c),\qquad
\rho_D=\operatorname{diag}(d,1-d),\qquad c,d\in[0,1].
\tag{2.4}
$$

This step does **not** assert that maximally mixed targets are optimal for every $p,q$. That stronger assertion is false. Our proof establishes the needed statement only after excluding a low-probability region.

## 3. The five-entry spectrum

Use canonical target purifications with amplitudes $(\sqrt c,\sqrt{1-c})$ and $(\sqrt d,\sqrt{1-d})$. Define

$$
N=\begin{pmatrix}
1&1&1&1\\1&1&1&1\\1&1&1&0\\1&1&0&1
\end{pmatrix},
\tag{3.1}
$$

and the diagonal matrices

$$
\begin{aligned}
R&=\operatorname{diag}((1-p)d,(1-p)(1-d),pd,p(1-d)),\\
T&=\operatorname{diag}((1-q)c,(1-q)(1-c),qc,q(1-c)).
\end{aligned}
\tag{3.2}
$$

Four rows and columns of the output amplitude matrix form the block
$R^{1/2}NT^{1/2}$. Its row labels are $(a,j)$, representing the vectors $|a\rangle_A|j,j\rangle_{DR_D}$; its column labels are $(b,i)$, representing $|b\rangle_B|i,i\rangle_{CR_C}$. The two missing entries of $N$ are exactly those for which $a=b=1$ and $i\ne j$. The SWAP moves those amplitudes into two additional rows and columns, each with a single nonzero entry.

Thus the nonzero squared Schmidt coefficients are the eigenvalues of
$R^{1/2}NTN^TR^{1/2}$, together with

$$
v_1=pq\,c(1-d),\qquad v_2=pq\,(1-c)d.
\tag{3.3}
$$

The matrix $N$ has rank three, so at most five eigenvalues are nonzero. For a formula free of square roots, $NTN^TR$ has the same characteristic polynomial as $R^{1/2}NTN^TR^{1/2}$; this remains valid for singular $R$ by the identity $\det(zI-XY)=\det(zI-YX)$.

Set

$$
t=pq,\qquad u=1-p,\qquad v=1-q,\qquad a=2c-1,\qquad b=2d-1.
\tag{3.4}
$$

The three eigenvalues of the rank-three block are the roots, counted with zeros when necessary, of

$$
y^3-B_1y^2+B_2y-B_3,
\tag{3.5}
$$

where

$$
\begin{aligned}
B_1&=1-\frac t2+\frac{tab}{2},\\
B_2&=\frac{t}{16}\bigl[
 t a^2b^2+(3t-4q)a^2+(3t-4p)b^2-8uvab
 +t-4p-4q+8\bigr],\\
B_3&=\frac{t^2uv}{16}(1-a^2)(1-b^2).
\end{aligned}
\tag{3.6}
$$

The two additional eigenvalues are

$$
v_1=\frac{t(1+a)(1-b)}4,\qquad
v_2=\frac{t(1-a)(1+b)}4.
\tag{3.7}
$$

Equations (3.1)–(3.2) give a direct way to check (3.6) by a determinant expansion. Let $\lambda$ denote this five-entry probability vector, allowing zero entries, and let $e_k(\lambda)$ be its elementary symmetric polynomials. They are equivalently defined by

$$
\prod_{j=1}^5(y-\lambda_j)
=(y^3-B_1y^2+B_2y-B_3)(y-v_1)(y-v_2).
\tag{3.8}
$$

In particular $e_1=1$.

## 4. An entropy comparison principle

Write $S(\lambda)=-\sum_j\lambda_j\log\lambda_j$ for entropy in natural units.

The relation between entropy and elementary symmetric polynomials is established in [4]. We give the exact comparison needed here in a self-contained form; this principle is an input, not a claimed new result.

**Lemma 4.1.** If $\lambda,\mu$ are probability vectors of equal length $r$, then

$$
S(\lambda)-S(\mu)=\int_0^\infty
\log\frac{\prod_{j=1}^r(y+\lambda_j)}{\prod_{j=1}^r(y+\mu_j)}\,dy.
\tag{4.1}
$$

Consequently, if $e_k(\lambda)\le e_k(\mu)$ for every $2\le k\le r$, then $S(\lambda)\le S(\mu)$. If any coefficient inequality is strict, the entropy inequality is strict.

*Proof.* Integrate each $\log(y+x)$ from zero to $R$, using the antiderivative $(y+x)\log(y+x)-(y+x)$. Equal vector lengths and equal coordinate sums cancel the divergent terms at the upper endpoint. Letting $R$ tend to infinity gives (4.1). At infinity the integrand is $O(y^{-2})$; at zero its possible logarithmic singularity is integrable, including zero coordinates. Now
$\prod_j(y+\lambda_j)=y^r+y^{r-1}+\sum_{k=2}^r e_k(\lambda)y^{r-k}$.
Coefficientwise comparison gives the required pointwise comparison for every $y>0$. Strictness follows in the same way. $\square$

## 5. Excluding the complete low-probability region

Define the fixed comparison spectrum

$$
\mu=\left(\frac{39}{100},\frac15,\frac15,\frac15,\frac1{100}\right).
\tag{5.1}
$$

Its elementary symmetric polynomials are

$$
e_2(\mu)=\frac{3639}{10000},\quad
e_3(\mu)=\frac{2917}{50000},\quad
e_4(\mu)=\frac{917}{250000},\quad
e_5(\mu)=\frac{39}{1250000}.
\tag{5.2}
$$

**Lemma 5.1.** If $\min(p,q)\le4/5$, then for every target pair (2.4),
$e_k(\lambda)<e_k(\mu)$ for $k=2,3,4,5$. Consequently the output entropy is less than two ebits.

*Proof.* Exchanging the two sides allows us to assume $p\le4/5$. Simultaneous complementation $(a,b)\mapsto(-a,-b)$ leaves the spectrum unchanged. It therefore suffices to substitute

$$
p=\frac45P,\quad q=Q,\quad a=A,\quad b=\sigma B,
\qquad P,Q,A,B\in[0,1],\quad\sigma\in\{+1,-1\}.
\tag{5.3}
$$

For $k=2,3,4$, the polynomial $e_k(\mu)-e_k(\lambda)$ has degree at most $k$ in each of these four variables. Appendix A provides a finite tensor-product Bernstein certificate: 15 boxes in total, with every coefficient strictly positive and all arithmetic rational. That certificate proves the claimed inequalities on the entire continuous parameter domain, including all boundary faces.

For $k=5$, direct multiplication gives

$$
e_5(\lambda)=\frac{p^4(1-p)q^4(1-q)(1-a^2)^2(1-b^2)^2}{256}
\le\frac{256}{9765625}<\frac{39}{1250000}.
\tag{5.4}
$$

Here $r^4(1-r)$ on $[0,1]$ is maximized at $r=4/5$, as its derivative is $r^3(4-5r)$. Lemma 4.1 gives $S(\lambda)<S(\mu)$. Finally,

$$
\frac{S(\mu)}{\log2}=1.989392467486\ldots<2.
\tag{5.5}
$$

The strict inequality in (5.5), rather than merely its decimal approximation, is equivalent to the exact integer inequality
$100^{100}<2^{200}39^{39}20^{60}$, which the verifier checks directly. $\square$

The certificate is used only for this compact low-probability region. The remainder of the proof is analytic.

## 6. Maximally mixed targets in the high-probability region

Assume now that $p,q\in[4/5,1]$. Then $u,v\in[0,1/5]$. Write
$A=a^2$, $B=b^2$, and let $e_k^0$ denote the value of $e_k$ at $a=b=0$, with $p,q$ unchanged.

**Lemma 6.1.** In this region, $e_k\le e_k^0$ for $k=2,3,4,5$. If $a^2+b^2>0$, then $e_3<e_3^0$. Hence the target marginals $I_2/2,I_2/2$ uniquely maximize the output entropy among commuting target pairs.

*Proof.* Expanding (3.8) gives

$$
e_2^0-e_2=\frac t8\bigl[tAB+q(2-p)A+p(2-q)B+4(u+v)ab\bigr].
\tag{6.1}
$$

Since $q(2-p),p(2-q)\ge4/5$, $2(u+v)\le4/5$, and $2|ab|\le A+B$, the bracket is nonnegative.

For the third coefficient,

$$
e_3^0-e_3=\frac{t^2}{16}\mathcal F_3,
\tag{6.2}
$$

where

$$
\begin{aligned}
\mathcal F_3={}&A(1+2u-uv)+B(1+2v-uv)-(1+5uv)AB\\
&+2ab\,[u+v+2uv-u(1-v)A-v(1-u)B].
\end{aligned}
\tag{6.3}
$$

The bracket in the second line equals
$u(1-A)+v(1-B)+uv(2+A+B)$, so it lies between zero and $u+v+2uv$. Using also $AB\le(A+B)/2$, we obtain

$$
\begin{aligned}
\mathcal F_3
&\ge\left(\frac12+u-v-\frac{11}{2}uv\right)A
 +\left(\frac12-u+v-\frac{11}{2}uv\right)B\\
&\ge\left(\frac12-|u-v|-\frac{11}{2}uv\right)(A+B)
\ge\frac{2}{25}(A+B).
\end{aligned}
\tag{6.4}
$$

The last bound uses $|u-v|\le1/5$ and $uv\le1/25$. It gives the required strictness.

For the fourth coefficient, set $C_0=1+3u+3v+9uv$. Then

$$
e_4=\frac{t^3(1-A)(1-B)}{256}
[C_0-q(4-3p)A-p(4-3q)B+tAB-16uvab],
\tag{6.5}
$$

while $e_4^0=t^3C_0/256$. Because

$$
q(4-3p)-\frac t2=q\left(4-\frac72p\right)\ge\frac25,
\qquad
p(4-3q)-\frac t2\ge\frac25,
\tag{6.6}
$$

and $16uv|ab|\le(8/25)(A+B)$, the square bracket in (6.5) is at most
$C_0-(2/25)(A+B)\le C_0$. Multiplication by $(1-A)(1-B)\in[0,1]$ gives $e_4\le e_4^0$; if the bracket is negative, the same inequality is immediate.

Finally,

$$
e_5=\frac{t^4uv(1-A)^2(1-B)^2}{256}
\le\frac{t^4uv}{256}=e_5^0.
\tag{6.7}
$$

Lemma 4.1 completes the proof. $\square$

**Lemma 6.2 (equality before dephasing).** A global maximizer in the high-probability region has $\rho_C=\rho_D=I_2/2$, even if the original marginals do not commute.

*Proof.* Dephase $\rho_C$ in an eigenbasis of $\rho_D$, as in Section 2. The entropy cannot decrease. If the input was globally maximizing, its dephased image is also a maximizer. Lemma 6.1 forces the unchanged marginal $\rho_D$ to equal $I_2/2$. With that conclusion, choose a common basis that diagonalizes the original $\rho_C$ itself. There is then no need to dephase, and the strict part of Lemma 6.1 forces $\rho_C=I_2/2$. $\square$

## 7. Equal controls and a unique scalar optimum

For maximally mixed targets, the spectrum is

$$
\left(\lambda_+,\lambda_-,\frac t4,\frac t4,\frac t4\right),
\quad
\lambda_++\lambda_-=1-\frac{3t}{4},
\quad
\lambda_+\lambda_-=\frac{t(1-p)(1-q)}4.
\tag{7.1}
$$

At fixed $t=pq>0$, the entropy of a nonnegative pair with fixed sum is strictly increasing in its product until the two entries coincide. Moreover,

$$
(1-p)(1-q)=1-p-q+t\le(1-\sqrt t)^2,
\tag{7.2}
$$

with equality precisely when $p=q$. Replacing $p,q$ by $\sqrt t,\sqrt t$ remains inside the high-probability region and cannot decrease the entropy. Every maximizer thus has $p=q=s\in[4/5,1]$.

The two remaining Schmidt amplitudes are the absolute eigenvalues of

$$
M_s=\begin{pmatrix}
1-s&\sqrt{s(1-s)}\\
\sqrt{s(1-s)}&s/2
\end{pmatrix}.
\tag{7.3}
$$

For $s<1$, its determinant is negative. Divide the absolute eigenvalues by $s/2$, call the larger one $U$ and the smaller one $z$, and use the trace and determinant to obtain

$$
U-z=1+Uz,\qquad
U=\frac{1+z}{1-z},\qquad
s=\frac{2(1-z)}{z^2-z+2}.
\tag{7.4}
$$

This gives exactly the spectrum $(L,x,x,x,m)$ in (1.3). The interval for $s$ corresponds decreasingly to

$$
0\le z\le\frac{\sqrt{17}-3}{4}<\frac12.
\tag{7.5}
$$

Let $S(z)=-L\log L-3x\log x-m\log m$. Since $L+3x+m=1$,

$$
S'(z)=-2L'(z)\log\frac{1+z}{1-z}-2m'(z)\log z,
\tag{7.6}
$$

with

$$
L'(z)=\frac{2(1+z)(1-z)(3+z)}{D(z)^3},\qquad
m'(z)=\frac{4z(1-z)(1-2z)}{D(z)^3}.
\tag{7.7}
$$

Therefore

$$
S'(z)=-\frac{8z(1-z)(1-2z)}{D(z)^3}\,\mathcal H(z).
\tag{7.8}
$$

The function $\mathcal H$ is strictly increasing on $(0,1/2)$. Indeed, in (1.3), $\log z$ is strictly increasing,
$(1+z)(3+z)/(2(1-2z))$ is positive and strictly increasing, and

$$
\frac{\log((1+z)/(1-z))}{z}
=2\sum_{j=0}^{\infty}\frac{z^{2j}}{2j+1}
\tag{7.9}
$$

is positive and increasing. Also $\mathcal H(z)\to-\infty$ as $z\downarrow0$, whereas

$$
\mathcal H(1/10)>-3+\frac{341}{80}>0.
\tag{7.10}
$$

For the last inequality, use $\log10<3$ and the strict lower bound 2 in (7.9). The existence and uniqueness of $z_*\in(0,1/10)$ follow. Equation (7.8) shows that $S$ increases up to this root and decreases afterwards. At $z=0$, the spectrum consists of four entries $1/4$ and one zero, so $S(0)=\log4$. In particular $S(z_*)>\log4$ analytically, without a numerical estimate.

The low-probability exclusion, Lemmas 6.1–6.2, the strictness in (7.2), and scalar uniqueness prove both the crossing-cut value and its complete equality conditions.

For completeness, all other bipartitions have output Schmidt rank at most four. A single control versus the other laboratories, and the two controls versus the targets, have operator Schmidt rank at most two. A single target versus the other laboratories has operator Schmidt rank at most four, since a qubit operator space has dimension four. Local ancillary identities do not increase these ranks. Thus every noncrossing cut has entropy at most two ebits. The symmetry $C\leftrightarrow D$ identifies the two crossing cuts, proving (1.5) and completing Theorem 1.1.

## 8. Any number of controls with two target qubits

The following extension concerns a precisely specified family. It does not concern arbitrary multi-target controlled permutations.

For $r\ge1$ control qubits $A_1,\ldots,A_r$ and two target qubits $C,D$, define

$$
F_{r+2}=I+\left(\bigotimes_{j=1}^r|1\rangle\langle1|_{A_j}\right)
\otimes(W_{CD}-I_{CD}).
\tag{8.1}
$$

Inputs remain product across all individual laboratories, each with its own arbitrary finite ancilla, and $K_E$ still maximizes the output entropy over laboratory bipartitions.

**Corollary 8.1.** For the family (8.1),

$$
K_E(F_3)=2,\qquad K_E(F_{r+2})=K_*\quad(r\ge2).
\tag{8.2}
$$

*Proof.* Consider a bipartition with the two targets on opposite sides. Let $J_L,J_R$ be the sets of controls on the respective sides. When both are nonempty, project the initial product of control states on each side onto its all-ones control subspace and its orthogonal complement. These are orthogonal local branch vectors. A local isometry compresses them to one effective control qubit on each side. The corresponding activation probabilities are

$$
P=\prod_{j\in J_L}p_j,\qquad Q=\prod_{j\in J_R}p_j.
\tag{8.3}
$$

The gate only uses the conjunction of those two branch labels. Its action on the relevant input support is therefore exactly the four-qubit gate with effective control probabilities $P,Q$. Theorem 1.1 supplies the upper bound $K_*$. Every $P,Q\in[0,1]$ is realizable by varying one control on each side and fixing the remaining controls to $|1\rangle$, so this bound is attained.

If one side has a target but no controls, its relevant local Hilbert space has dimension at most four: one physical target and a rank-two purification ancilla. Its entropy is therefore at most two ebits. If both targets lie on the same side, (8.1) has operator Schmidt rank at most two across the cut, giving at most one ebit. These cases exhaust all cuts. For $r=1$, no crossing cut can have a control on each side, and the bound of two ebits is attained by fixing the control to $|1\rangle$ and using Bell-pair target purifications. For $r\ge2$, an appropriate crossing cut attains $K_*>2$. $\square$

## 9. Contribution and verification scope

The two-ebit conjecture was already refuted before this work. The candidate numerical optimum and maximally mixed target ansatz were also already present in the public research record [2,3]. The additional result is a proof that no other product input, including inputs with arbitrary local ancillary dimensions, gives a larger value; the proof also identifies all maximizers and gives the precise extension (8.1).

The entropy comparison principle is standard [4]. The problem-specific work is the spectral reduction, the low-region rational certificate, the high-region coefficient comparisons, the equality argument before dephasing, and the scalar parameter whose stationarity condition is strictly monotone.

The polynomial certificate proves inequalities on full continuous boxes. It is not a finite grid test. Numerical state-vector checks independently verify the spectral formulas and illustrate the optimum, but do not replace the global proof. Exact rational arithmetic and numerical checks play distinct roles. The reproduction files are not included in this edition. Neither computation nor the manuscript constitutes external peer review or a formally verified proof of the full theorem.

The full text of the published APS version was not accessible in this audit. We therefore pin the research target to the author-supplied arXiv v1 in [1], without asserting that every statement or conjecture number was retained unchanged in the journal version.

## Appendix A. A finite rational certificate for Lemma 5.1

### A.1. Bernstein representation

For $k\in\{2,3,4\}$ and $\sigma\in\{+1,-1\}$, let

$$
G_{k,\sigma}(P,Q,A,B)=e_k(\mu)-
e_k\left(\frac45P,Q,A,\sigma B\right),
\tag{A.1}
$$

where the last $e_k$ is the polynomial defined by (3.6)–(3.8), in the order $(p,q,a,b)$. If
$G=\sum_\alpha g_\alpha X^\alpha$ has degree at most $k$ in each of its four variables, its tensor Bernstein coefficients on the unit box are

$$
\beta_i=\sum_{\alpha\le i}g_\alpha
\prod_{j=1}^4\frac{\binom{i_j}{\alpha_j}}{\binom{k}{\alpha_j}},
\quad i\in\{0,\ldots,k\}^4.
\tag{A.2}
$$

The tensor Bernstein basis functions are nonnegative and sum to one. Thus a strictly positive lower bound for all $\beta_i$ proves strict positivity of $G$ on the entire box.

Use variable order $(P,Q,A,B)$. A path symbol $2j$ means restricting variable $j$ to the lower half of its current interval; $2j+1$ means the upper half, with $j=0,1,2,3$. Coefficients on a half-box are obtained by the usual de Casteljau averaging: repeatedly replace adjacent coefficients along that axis by their arithmetic mean. The left-edge and reversed right-edge entries give the two child coefficient arrays. This procedure uses only addition and division by two.

### A.2. The complete certificate

The empty path denotes the whole unit box. For each row below, the displayed rational number is the smallest Bernstein coefficient after the indicated restrictions. Paths for a fixed pair $(k,\sigma)$ form a complete subdivision of the unit box.

| $k$ | $\sigma$ | Subdivision path | Smallest coefficient |
| --- | --- | --- | --- |
| 2 | + | empty | $39/10000$ |
| 2 | − | 3,1,3,5 | $4/625$ |
| 2 | − | 3,1,3,4,1,7 | $139/10000$ |
| 2 | − | 3,1,3,4,1,6,1,5 | $4/625$ |
| 2 | − | 3,1,3,4,1,6,1,4 | $7/5000$ |
| 2 | − | 3,1,3,4,1,6,0 | $1287/80000$ |
| 2 | − | 3,1,3,4,0 | $339/10000$ |
| 2 | − | 3,1,2 | $153/20000$ |
| 2 | − | 3,0 | $839/10000$ |
| 2 | − | 2 | $639/10000$ |
| 3 | + | empty | $117/50000$ |
| 3 | − | 1 | $253/450000$ |
| 3 | − | 0 | $1317/50000$ |
| 4 | + | empty | $117/250000$ |
| 4 | − | empty | $23/62500$ |

All entries follow by the finite rational rules (3.6)–(3.8), (A.1), (A.2), and half-interval averaging. They have been independently recomputed from the literal amplitude matrix and from the displayed cubic. The accompanying exact verifier also checks that each subdivision is a full partition; it does not accept a collection of positive boxes without verifying coverage.

### A.3. Certifying logarithms

For a positive rational $r$, choose an integer $j$ so that $w=2^{-j}r\in[1,2)$. With $h=(w-1)/(w+1)\in[0,1/3)$,

$$
\log w=2\sum_{\ell=0}^{M-1}\frac{h^{2\ell+1}}{2\ell+1}+R_M,
\quad
0\le R_M\le\frac{2h^{2M+1}}{(2M+1)(1-h^2)}.
\tag{A.3}
$$

The same formula with $h=1/3$ bounds $\log2$. Adding $j\log2$, with the interval endpoints reversed when multiplication by a negative $j$ requires it, gives rational bounds for $\log r$. Applying these bounds to

$$
2\log2-S(\mu)=
\frac{39}{100}\log\frac{39}{25}
+\frac35\log\frac45
+\frac1{100}\log\frac1{25}
\tag{A.4}
$$

would certify its positivity; the supplied verifier instead uses the simpler exact integer inequality in Section 5. The rational logarithm procedure, with 120 terms, bounds $\mathcal H$ at the rational endpoints in (1.9). Strict monotonicity of $\mathcal H$ then encloses its unique zero. To enclose the resulting entropy, note that on $(0,1/10)$, $L$ and $m$ are increasing by (7.7), whereas $x' =-(L'+m')/3<0$. All three eigenvalue functions lie below $1/3$ on the certified root interval. The scalar function $-r\log r$ is increasing there: $r\le1/3<1/e$, using $e<3$. Evaluating the corresponding probability endpoints and rational logarithm bounds therefore encloses each entropy contribution and gives the second line of (1.9). No floating-point logarithm is needed for these assertions.

## References

[1] Xinyu Qiu, Zhiwei Song and Lin Chen, *Multipartite entangling power by von Neumann entropy*, Physical Review A **111**, 022407 (2025). DOI: [10.1103/PhysRevA.111.022407](https://doi.org/10.1103/PhysRevA.111.022407). The source version used for the problem statement is [arXiv:2410.15253v1](https://arxiv.org/html/2410.15253v1), Definition 4 and Section V, Cases 1–4 and Conjecture 21.

[2] The Omega Institute / trureturing, *The four-qubit Fredkin gate generates more than two ebits across AD:BC*, [public research dossier](https://www.trureturing.org/research/qiu-2025-fredkin-entangling-power/). The dossier attributes a certified violating input to the project; the full optimality theorem is not its stated result.

[3] The Omega Institute / trureturing, [issue #11460](https://github.com/the-omega-institute/trureturing/issues/11460), *Preregister: refute the conjecture that the four-qubit Fredkin gate generates exactly 2 ebits across AD:BC*. In addition to its rational witness, the issue records a scout's numerical optimum of $2.0005218602$ with pure controls and maximally mixed targets. Retrieved 24 November 2026.

[4] Richard Jozsa and Graeme Mitchison, *Symmetric polynomials in information theory: entropy and subentropy*, Journal of Mathematical Physics **56**, 062201 (2015). DOI: [10.1063/1.4922317](https://doi.org/10.1063/1.4922317); [arXiv:1404.7694](https://arxiv.org/abs/1404.7694), especially equations (13), (15) and (17).
