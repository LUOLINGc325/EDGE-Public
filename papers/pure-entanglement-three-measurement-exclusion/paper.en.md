# Three Projective Measurements Witness an Exclusion Advantage for Every Pure Entangled State

*A constructive resolution of the odd-dimensional measurement-exclusion question*

24 November 2026

## Abstract

We consider one use of an unknown, labelled, rank-one projective measurement. The device returns its classical outcome; its post-measurement quantum system is unavailable. For every finite-dimensional bipartite pure entangled state, we construct three such measurements that the specified state perfectly excludes, while every separable probe, with arbitrary finite-dimensional memory, incurs strictly positive exclusion error. The same specified entangled state cannot perfectly discriminate the measurements: at every possible classical outcome, two conditional memory states are nonorthogonal. The construction covers all Schmidt ranks, including odd ranks, and thereby answers the odd-dimensional question left by Manna in this protocol. For Schmidt rank at least three, it uses a Fourier interpolation evaluated at an explicit root of unity. An extension-degree argument makes every transversal of the three measurement bases invertible, while a separate analytic estimate supplies explicit exclusion POVMs. We also give the exact finite expression for the best separable error, a conservative algebraic lower bound, and rational examples with reproducible certificates.

This is an AI-assisted research draft. It has not undergone external peer review or end-to-end Lean verification.

## 1. The task and the precise result

A label $x\in\{0,1,2\}$, with prior $\pi_x>0$ and $\sum_x\pi_x=1$, selects a projective measurement on a $d$-dimensional system $A$:
$$
\mathcal M_x=\{P_{a|x}=|b_{a|x}\rangle\langle b_{a|x}|:0\le a<d\}.
$$
Each $B_x=[b_{0|x},\ldots,b_{d-1|x}]$ is unitary. The associated channel has only a classical output,
$$
\mathcal C_x(\rho)=\sum_a\operatorname{tr}(\rho P_{a|x})|a\rangle\langle a|.
$$
An input on $A\otimes B$ can retain memory $B$. After receiving $a$, the observer chooses a three-outcome POVM $\{N_{y|a}\}_{y=0}^2$ on $B$. Output $y$ asserts that $x\ne y$; the error event is $y=x$. There is no inconclusive outcome and no discarded branch.

Manna [1, Sections III--V] established even-dimensional constructions and explicitly left the odd-dimensional extension. The information available here is exactly the classical-output and retained-memory protocol used there. The distinction from protocols that also return the measured system is essential [2].

**Theorem 1.** Let $|\Psi\rangle\in\mathcal H_A\otimes\mathcal H_B$ be a pure state of finite Schmidt rank $r\ge2$, with both Hilbert spaces finite-dimensional. There exist three labelled rank-one projective measurements on all of $\mathcal H_A$ such that:

1. The specified input $|\Psi\rangle$ has zero exclusion error. At every positive-probability classical outcome, each of the two incorrect labels has positive conditional probability under the constructed decoder.
2. For every strictly positive prior, the infimum exclusion error over all separable inputs and all decoders is strictly positive. This includes arbitrary finite-dimensional memory and classical correlations.
3. With this same specified input, the three measurements cannot be perfectly discriminated. At every possible classical outcome, the conditional memory states for measurements 0 and 1 are nonorthogonal.

The quantifier in item 3 concerns the given input. The theorem makes no assertion that every other entangled input also fails discrimination.

Three candidates are the smallest possible number for these joint requirements: with two candidates, complementing a perfectly excluded label identifies the actual candidate.

Choose Schmidt coordinates:
$$
|\Psi\rangle=\sum_{j=0}^{r-1}\sqrt{\lambda_j}|j\rangle_A|j\rangle_B,\qquad
\lambda_j>0,\quad \sum_j\lambda_j=1.
$$
Write $D=\operatorname{diag}(\sqrt{\lambda_j})$, $\Lambda=D^2$, and
$\kappa=\lambda_{\max}/\lambda_{\min}$. Measuring a basis vector $b$ in the Schmidt support leaves the unnormalised memory vector
$$
w=D\overline b. \tag{1}
$$
Local changes of coordinates carry the construction back to the original state.

## 2. A finite criterion for the best separable error

For a decision function $f:\{0,\ldots,d-1\}\to\{0,1,2\}$, define
$$
T_f=[b_{a|f(a)}]_{a=0}^{d-1},\qquad
H_f=\sum_a\pi_{f(a)}P_{a|f(a)}.
$$
We call $T_f$ a transversal: it chooses one basis vector for each fixed classical outcome label.

**Lemma 2.** The optimal error over separable probes is exactly
$$
\epsilon_{\rm sep}=\min_f\lambda_{\min}(H_f). \tag{2}
$$
In particular, this error is positive if and only if every transversal is invertible.

**Proof.** For a system input $\rho$, the best classical decision at outcome $a$ chooses a label minimizing $\pi_x\operatorname{tr}(\rho P_{a|x})$. Its error is
$$
E(\rho)=\sum_a\min_x\pi_x\operatorname{tr}(\rho P_{a|x})
       =\min_f\operatorname{tr}(\rho H_f).
$$
Minimizing over density matrices and interchanging two minima gives (2) for unassisted inputs. Each minimum is attained. Because all priors are positive, $H_f=T_f\operatorname{diag}(\pi_{f(a)})T_f^\dagger$ is positive definite precisely when $T_f$ is invertible. There are only $3^d$ choices.

For a product input $\rho_A\otimes\tau_B$, any memory measurement induces only a classical rule $p(y|a)=\operatorname{tr}(\tau_BN_{y|a})$. Thus its error is at least the unassisted optimum. For a separable mixture, the error of any fixed decoder is the average of the errors on the product components; each component has the same lower bound. Conversely an optimal unassisted input is separable. This proves the equality, including the memory claim. $\square$

For uniform priors, the expression becomes
$$
\epsilon_{\rm sep}=\frac13\min_f\lambda_{\min}(T_fT_f^\dagger). \tag{3}
$$
The finite minimum, rather than a numerical search over product states, is the exact operational quantity.

## 3. Explicit decoding of three nearly orthogonal states

The following construction is a self-contained special case of the Gram-matrix exclusion structure in [3, Theorem 3.2 and Corollary 5.4]. The overlap threshold is an existing result, not a claimed new contribution.

**Lemma 3.** Let $v_0,v_1,v_2$ be unit vectors with
$$
|\langle v_i,v_j\rangle|<\frac12\quad(i\ne j). \tag{4}
$$
There is an explicit POVM with $N_iv_i=0$ and
$\langle v_j,N_iv_j\rangle=1/2$ for $j\ne i$.

**Proof.** Put $V=[v_0,v_1,v_2]$ and $G=V^\dagger V$. Each row of the Hermitian matrix $G$ has diagonal entry one and off-diagonal absolute row sum below one. Hence $G$ is positive definite. For each $i$, let $C_i$ have row and column $i$ zero and, on the remaining coordinates $j,k$, the block
$$
\begin{pmatrix}1/2&G_{jk}\\G_{kj}&1/2\end{pmatrix}.
$$
These blocks are positive definite, and $\sum_iC_i=G$. Set
$$
W=VG^{-1},\qquad P=VG^{-1}V^\dagger,\qquad
N_i=WC_iW^\dagger+\frac{I-P}{3}. \tag{5}
$$
Here $P$ is the orthogonal projector onto the column space of $V$. Thus every $N_i$ is positive and their sum is $I$. Moreover $W^\dagger v_j=e_j$; the stated probabilities follow from the entries of $C_i$. All effects are nonzero. $\square$

For exact arithmetic one may use unnormalised columns $w_i$. Then $G=V^\dagger V$, the diagonal entries of each supported block are $G_{jj}/2,G_{kk}/2$, and its off-diagonal entry is $G_{jk}$. The required test is
$$
4|G_{jk}|^2<G_{jj}G_{kk}. \tag{6}
$$
Formula (5) is unchanged. It gives each allowed outcome half the squared norm of the input column, so normalization again yields probability $1/2$.

## 4. A uniform algebraic construction for every $r\ge3$

Let $\omega=e^{2\pi i/r}$ and $F_{aj}=r^{-1/2}\omega^{-aj}$. Define
$$
U_x(z)=F\operatorname{diag}(z^{xj})_{j=0}^{r-1}F^\dagger,
\qquad x=0,1,2. \tag{7}
$$
For $|z|=1$ these matrices are unitary. Their entries are polynomials in $z$ over $\mathbb Q(\omega)$, of degrees at most $x(r-1)$; the square roots in $F$ cancel entrywise. At $z=1$, all three matrices are $I$. At $z=\omega$, $U_x(\omega)e_a=e_{a+x\bmod r}$.

Choose any prime
$$
q>\max\{2r(r-1)+1,\;80\sqrt\kappa\},
\qquad
z=\exp\!\left(\frac{2\pi i(q-1)}{rq}\right), \tag{8}
$$
and set $b_{a|x}=U_x(z)e_a$. Suitable primes exist. The Schmidt probabilities can be arbitrary positive real numbers; their algebraicity is not assumed.

### 4.1 Algebraic degree rules out every singular transversal

For each $f:\{0,\ldots,r-1\}\to\{0,1,2\}$, consider the polynomial
$$
p_f(Z)=\det[U_{f(a)}(Z)e_a]_{a=0}^{r-1}.
$$
It satisfies
$$
p_f\in\mathbb Q(\omega)[Z],\quad
\deg p_f\le (r-1)\sum_a f(a)\le2r(r-1),\quad p_f(1)=1. \tag{9}
$$
Thus no $p_f$ is identically zero.

Since $q>r$ is prime, $\gcd(q,r)=1$. The chosen $z$ is an $rq$-th root of unity and $z^r=\zeta_q^{-1}$. Consequently
$$
\mathbb Q(\omega,z)=\mathbb Q(\zeta_r,\zeta_q)
                  =\mathbb Q(\zeta_{rq}).
$$
The cyclotomic degree formula and the tower law give
$$
[\mathbb Q(\omega,z):\mathbb Q(\omega)]
=\frac{\varphi(rq)}{\varphi(r)}=q-1>2r(r-1). \tag{10}
$$
This argument does not require $z$ itself to have order $rq$. It follows from (9)--(10) that $p_f(z)\ne0$ for every $f$. Lemma 2 therefore gives a strict error gap against all separable probes.

The high-degree specialization principle, including root-of-unity choices, already appears in explicit full-spark constructions [7, Corollaries 5.2--5.3]; a recent quantitative application is [6, Theorem 2.1]. The new use here is the simultaneous enforcement of all measurement transversals within a neighborhood that admits conditional-state exclusion.

### 4.2 The same-output memory states admit perfect exclusion

Let $S=U_1(\omega)$. Unitary diagonalization and
$|e^{it}-e^{is}|\le|t-s|$ imply
$$
\|U_1(z)-S\|_{\rm op}\le\frac{2\pi}{q},\qquad
\|U_2(z)-S^2\|_{\rm op}\le\frac{4\pi}{q}. \tag{11}
$$
For nonzero vectors $u,v$,
$$
\left\|\frac{u}{\|u\|}-\frac{v}{\|v\|}\right\|
\le \frac{2\|u-v\|}{\|v\|}. \tag{12}
$$
Indeed, split the left side using the intermediate vector $u/\|v\|$, and apply the reverse triangle inequality.

Let $v_{a,x}=D\overline{U_x(z)e_a}/\|D\overline{U_x(z)e_a}\|$. Equations (11)--(12) give
$$
v_{a,0}=e_a,\quad
\|v_{a,1}-e_{a+1}\|\le\frac{4\pi\sqrt\kappa}{q},\quad
\|v_{a,2}-e_{a+2}\|\le\frac{8\pi\sqrt\kappa}{q}. \tag{13}
$$
The three reference basis vectors are distinct for every $r\ge3$. Expand an inner product by changing one factor at a time. Using unit norms and their orthogonality,
$$
|\langle v_{a,x},v_{a,y}\rangle|
\le\frac{12\pi\sqrt\kappa}{q}
<\frac{3\pi}{20}<\frac12,\qquad x\ne y. \tag{14}
$$
Lemma 3 supplies the decoder at each outcome. Each outcome has positive probability for each hypothesis because $\Lambda>0$. Each incorrect label has probability exactly $1/2$, conditional on that outcome and the actual hypothesis.

### 4.3 Perfect discrimination still fails for the specified input

Every diagonal entry of $U_1(z)$ is
$$
c(z)=\frac1r\sum_{j=0}^{r-1}z^j
    =\frac{1-z^r}{r(1-z)}\ne0. \tag{15}
$$
The numerator and denominator are nonzero by (8). The unnormalised conditional vectors for hypotheses 0 and 1 therefore satisfy
$$
\langle De_a,D\overline{U_1(z)e_a}\rangle
=\lambda_a\overline{c(z)}\ne0. \tag{16}
$$
Their classical-quantum output states have nonorthogonal supports in each classical block. Perfect discrimination of two density matrices requires orthogonal supports: a successful distinguishing effect must be identity on one support and zero on the other. Equation (16) rules this out, independently of which final POVM is attempted.

## 5. A completely explicit, conservative error gap

The exact expression (3) is usually the appropriate way to evaluate a concrete instance. An algebraic estimate also makes its positivity quantitative without enumerating $3^r$ transversals.

**Proposition 4.** Let $n=\varphi(r)(q-1)$. For the construction (7)--(8), with uniform priors,
$$
\epsilon_{\rm sep}\ge
\frac13 r^{-rn}\left(\frac{r-1}{r}\right)^{r-1}>0. \tag{17}
$$

**Proof.** Every entry of $rU_x(z)$ is an algebraic integer in $K=\mathbb Q(\zeta_{rq})$. Hence $\alpha=r^rp_f(z)$ is a nonzero algebraic integer, whose field norm has absolute value at least one. Under every embedding of $K$, both $\omega$ and $z$ remain on the unit circle, and the image of $\omega$ is still a primitive $r$-th root. The conjugate versions of (7) are unitary. Every conjugate transversal has unit columns; Hadamard's inequality gives $|\sigma(p_f(z))|\le1$.

The identity and complex-conjugation embeddings are distinct and contribute the same modulus. Since $[K:\mathbb Q]=n$,
$$
1\le|\operatorname{Norm}_{K/\mathbb Q}(\alpha)|
   =r^{rn}\prod_\sigma|\sigma(p_f(z))|
   \le r^{rn}|p_f(z)|^2.
$$
The eigenvalues of $T_fT_f^\dagger$ sum to $r$ and their product is $|p_f(z)|^2$. By AM--GM the product of the largest $r-1$ is at most $(r/(r-1))^{r-1}$. Apply (3). $\square$

This bound is very small and is not an experimental performance claim. It implies a precise continuity consequence: with the constructed measurements and decoder fixed, any input at trace distance less than $\epsilon_{\rm sep}$ from $|\Psi\rangle\langle\Psi|$ still has strictly smaller error than every separable probe. Here trace distance is one half of the trace norm. The error operator lies between $0$ and $I$, so its expectation changes by at most that distance. Perfect exclusion need not persist under noise.

## 6. Schmidt rank two

This ingredient is equivalent to the qubit construction already proved in [1, Theorem 1]. We include its decoding and transversal check to keep the all-rank theorem self-contained.

Write $|\Psi\rangle=\sqrt\lambda|00\rangle+\sqrt{1-\lambda}|11\rangle$, $0<\lambda<1$. Set $m=\min(\lambda,1-\lambda)$, $c=\sqrt{m/2}$, and $s=\sqrt{1-c^2}$. Choose
$$
B_0=I,\qquad
B_1=\begin{pmatrix}c&s\\s&-c\end{pmatrix},\qquad
B_2=\begin{pmatrix}c&s\\-s&c\end{pmatrix}. \tag{18}
$$
At each outcome $a$, after irrelevant individual phases, the normalized conditional states are
$$
e,\quad Ae+\xi_a Bf,\quad Ae-\xi_a Bf,
\qquad \xi_0=1,\quad\xi_1=-1, \tag{19}
$$
where $(e,f)=(e_a,e_{1-a})$, $A,B>0$, $A^2+B^2=1$. Their ratios are
$$
\frac{A^2}{B^2}=
\begin{cases}
\lambda c^2/((1-\lambda)s^2),&a=0,\\
(1-\lambda)c^2/(\lambda s^2),&a=1.
\end{cases}
$$
Both are below one because $c^2=m/2<m$.

The label-respecting decoder is
$$
\begin{aligned}
N_0&=(1-A^2/B^2)|f\rangle\langle f|,\\
N_1&=\frac{|Be-\xi_a Af\rangle\langle Be-\xi_a Af|}{2B^2},\\
N_2&=\frac{|Be+\xi_a Af\rangle\langle Be+\xi_a Af|}{2B^2}.
\end{aligned} \tag{20}
$$
It consists of nonzero positive operators, sums to $I$, and annihilates the corresponding states in (19). Every other probability is positive. The factor $\xi_1=-1$ keeps labels 1 and 2 in the correct order at the second outcome.

The nine transversals in (18) have determinant absolute values in
$\{1,c,1-2c^2\}$, all positive. Lemma 2 applies. Since $A>0$, the conditional states for hypotheses 0 and 1 are nonorthogonal at both outcomes. This proves all assertions for $r=2$.

## 7. Rank-deficient states and larger local dimensions

Complete each of the three bases on the orthogonal complement of the $r$-dimensional Schmidt support with the same labelled orthonormal basis. Complete Bob's POVMs arbitrarily on his unused subspace, for example by assigning $I/3$ to each effect there.

The fixed probe gives probability zero to Alice's added outcomes. We do not define normalized conditional states on those impossible branches. For every possible outcome, the preceding construction applies.

For any other system probe, let $t$ be its mass on the Schmidt support. All measurement effects are block diagonal, so coherences with the complement do not affect their probabilities. The contribution from the support has error at least $t\epsilon_{\rm sep}^{(r)}$. On every complementary outcome the three hypotheses have identical probabilities; the minimal error contribution is $(1-t)\pi_{\min}$. Thus
$$
\epsilon_{\rm sep}^{(d)}
=\min\{\epsilon_{\rm sep}^{(r)},\pi_{\min}\}>0. \tag{21}
$$
Equality follows by choosing a minimizing input in either block. The mixture argument in Lemma 2 again includes all separable memories. The positive-probability outputs retain the nonorthogonality (16) or (19). This completes the proof of Theorem 1.

## 8. An exact rational qutrit example

An accessible finite example uses only rational matrices. Let
$$
U=\frac1{343}
\begin{pmatrix}
19&-18&342\\
342&19&-18\\
-18&342&19
\end{pmatrix},
\qquad B_0=I,\ B_1=U,\ B_2=U^2, \tag{22}
$$
and
$$
|\Psi\rangle=\frac{|00\rangle+2|11\rangle+3|22\rangle}{\sqrt{14}}.
$$
The integer column inner products show $U^\mathsf TU=I$. This is a separately certified rational example; it is not an instance of the sufficient prime-size bound (8).

For its 27 transversals, direct rational elimination gives:

| Absolute determinant | Multiplicity |
|---|---:|
| $1$ | 3 |
| $19/343$ | 12 |
| $11951/117649$ | 6 |
| $116603/117649$ | 3 |
| $37/117649$ | 3 |

For the three same-output conditional triples, the largest squared normalized overlap is
$$
\frac{90238809346921}{1033957840454011}<\frac14.
$$
Every pairwise overlap is nonzero. Applying the unnormalised decoder of Section 3 gives rational effects satisfying positivity, completeness, and exact zero error. Equations (3) and the eigenvalue estimate in Proposition 4 give
$$
\epsilon_{\rm sep}\ge\frac{5476}{373714754427}
>1.46\times10^{-8}. \tag{23}
$$
This is a certified lower bound, not the exact optimum.

The standard-library certificate checks this example, two additional rational qutrit spectra, a rational qubit example, and specified rank-deficient lifts. It performs 3228 exact checks, including 81 qutrit transversals, 729 lifted rank-three transversals, 9 qubit transversals, and 27 lifted rank-two transversals. It checks every principal minor of each stored decoder, all completeness identities, and all exclusion probabilities. A separate 80-digit calculation checks the cyclotomic formulas in nine spectra of ranks 3, 5, and 7. Neither computation substitutes for the universal proof in Sections 2--7.

## 9. Contribution, attribution, and limits

The new conclusion is the parity-free, single-use, three-projective-measurement construction for a specified pure entangled input, together with its simultaneous strict separable-error gap and fixed-input nondiscrimination. Its odd-rank case answers the exact remaining question in [1]. The support completion makes the rank qualification explicit.

General resource advantages in exclusion tasks were established earlier through subchannel exclusion [4]. Gram-based pure-state exclusion and the three-state overlap threshold are also established [3]. Recent work studies general channel exclusion through Choi supports and process POVMs [5]. These results concern different tasks or supply ingredients; we do not claim to originate general entanglement-assisted exclusion, the Gram criterion, the rank-two construction, or high-degree algebraic specialization [6,7]. The literature comparison is limited to the sources and searches archived with this draft.

The theorem concerns one copy of a pure probe, three labelled rank-one PVMs, classical device output, and a decoder conditioned on that output. It does not establish a corresponding perfect advantage for arbitrary mixed entangled states, optimal noise tolerance, or nondiscriminability with every other entangled probe. It does not claim an efficient algorithm for evaluating all $3^r$ terms of (3). The finite certificates have exactly the scope stated above.

## References

1. S. Manna, *Usefulness of $d\otimes d$ dimensional pure entangled states for antidiscrimination of quantum measurements when $d$ is even*, J. Phys. A: Math. Theor. **59**, 315304 (2026). [arXiv:2510.26255v2](https://arxiv.org/html/2510.26255v2), revised 10 August 2026. [DOI](https://doi.org/10.1088/1751-8121/ae91a4).
2. S. Manna, S. Suresh, M. S. Kachhawaha and D. Saha, *Single-shot distinguishability and antidistinguishability of quantum measurements*, Phys. Rev. A **111**, 022221 (2025). [DOI](https://doi.org/10.1103/PhysRevA.111.022221).
3. N. Johnston, V. Russo and J. Sikora, *Tight bounds for antidistinguishability and circulant sets of pure quantum states*, Quantum **9**, 1622 (2025). [arXiv:2311.17047v2](https://arxiv.org/html/2311.17047v2). [DOI](https://doi.org/10.22331/q-2025-02-04-1622).
4. A. F. Ducuara and P. Skrzypczyk, *Operational interpretation of weight-based resource quantifiers in convex quantum resource theories of states*, Phys. Rev. Lett. **125**, 110401 (2020). [arXiv:1909.10486v1](https://arxiv.org/abs/1909.10486v1). [DOI](https://doi.org/10.1103/PhysRevLett.125.110401).
5. A. A. Vijayan and N. S. Ragini, *Anti-distinguishability of quantum channels*, arXiv:2611.04105v1 (2026). [Source](https://arxiv.org/html/2611.04105v1).
6. D. Li, *Explicit Full-Spark Gabor Windows with Quantitative Phase Retrieval*, arXiv:2609.09614v2 (2026). [Source](https://arxiv.org/html/2609.09614v2).
7. R.-D. Malikiosis, *A note on Gabor frames in finite dimensions*, Applied and Computational Harmonic Analysis **38**(2), 318--330 (2015). [arXiv:1304.7709v1](https://arxiv.org/html/1304.7709v1), Section 5. [DOI](https://doi.org/10.1016/j.acha.2014.06.004).
