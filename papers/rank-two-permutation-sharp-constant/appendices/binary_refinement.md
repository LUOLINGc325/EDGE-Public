# A bounded code-size remainder for every positive binary-output channel

This supplement strengthens the main rank-two theorem. It does not use a rate hidden in the multivariate Gaussian localization argument. Instead it proves a one-dimensional uniform approximation and uses the monotone likelihood ratio of the exact count kernel.

## B1. Statement and conventions

Let a finite-input binary-output channel have smallest and largest probabilities of output one equal to \(0<a<b<1\). The endpoints are actual input rows. Put

\[
\sigma_a=\sqrt{a(1-a)},\quad \sigma_b=\sqrt{b(1-b)},\quad
L=\frac{2(b-a)}{\sigma_a+\sigma_b},\quad
z_\epsilon=\Phi^{-1}(1-\epsilon/2).
\]

For either average error or maximal error, in the original length-\(n\) noisy-permutation experiment,

\[
M^*(n,\epsilon)=\frac{b-a}{(\sigma_a+\sigma_b)z_\epsilon}\sqrt n+O_{a,b,\epsilon}(1).
\tag{B1}
\]

Here the alphabets and \(a,b,\epsilon\) are fixed, \(0<\epsilon<1\), and the error bound defining \(M^*\) is a literal finite-\(n\) bound. The theorem supplies a deterministic endpoint code and a deterministic decoder attaining the lower bound. The upper bound allows arbitrary private randomization at both encoder and decoder and use of the complete permuted output sequence. No shared randomness or feedback is assumed. The constants are not asserted uniform as \(a\) or \(b\) approaches a deterministic channel or as \(a\to b\).

The finite-\(n\) endpoint reduction in the main manuscript applies first. For a word containing \(w\) copies of the \(b\)-row and \(n-w\) copies of the \(a\)-row, the output-one count is

\[
Y_w\ \stackrel{d}=\ \operatorname{Bin}(n-w,a)+\operatorname{Bin}(w,b),
\tag{B2}
\]

with independent summands. Write \(q_w=a+(b-a)w/n\). Its mean and variance are exactly

\[
\mathbb E Y_w=nq_w,\qquad
\operatorname{Var}(Y_w)=n v(q_w),\qquad
v(q)=ab+(1-a-b)q.
\tag{B3}
\]

Thus \(v(a)=\sigma_a^2\) and \(v(b)=\sigma_b^2\). Notice that this is generally smaller than \(q_w(1-q_w)\). Replacing it by the latter changes the sharp constant.

## B2. Monotone likelihood ratios of the exact experiment

**Lemma B2.1.** For each \(w<n\), the ratio
\(\mathbb P(Y_{w+1}=y)/\mathbb P(Y_w=y)\) is nondecreasing in \(y\in\{0,\ldots,n\}\). Consequently, all pairwise likelihood ratios are ordered in the same way.

**Proof.** Remove the one Bernoulli variable whose parameter changes from \(a\) to \(b\), and let \(r_y\) be the probability mass function of the remaining \(n-1\) variables, extended by zero outside its support. Then

\[
p_y=(1-a)r_y+a r_{y-1},\qquad
t_y=(1-b)r_y+b r_{y-1}.
\]

Direct expansion gives

\[
t_{y+1}p_y-t_y p_{y+1}
=(b-a)(r_y^2-r_{y-1}r_{y+1})\ge0.
\tag{B4}
\]

The last inequality is the log-concavity of a Bernoulli sum. For completeness, it also follows without a real-rootedness citation. Start with the one-point mass. If \(r\) is nonnegative, has contiguous support, and is log-concave, convolving it with \((u,v)\), \(u,v\ge0\), gives \(s_y=ur_y+vr_{y-1}\), and

\[
s_y^2-s_{y-1}s_{y+1}
=u^2(r_y^2-r_{y-1}r_{y+1})
+v^2(r_{y-1}^2-r_{y-2}r_y)
+uv(r_y r_{y-1}-r_{y-2}r_{y+1}).
\tag{B5}
\]

The last term is nonnegative: within the positive support it follows by multiplying the adjacent-ratio inequalities; at a boundary it follows by the zero extension. Contiguous support is preserved by this convolution. Induction proves log-concavity. All \(p_y\) and \(t_y\) on \(0\le y\le n\) are strictly positive, so (B4) proves the adjacent ratio claim. Multiplying adjacent positive nondecreasing ratios proves the general claim. \(\square\)

For any ordered list of code types, a maximum-likelihood decoder with a consistent largest-index tie rule is nondecreasing in the observation \(y\). Indeed, if a larger index beats a smaller one at \(y\), the likelihood-ratio order prevents the smaller one from becoming the selected maximizer at a larger observation. Its decoding regions are therefore intervals, some of which may be empty. Repeated code types cause no difficulty under the same tie rule. We do not assume that every adjacent-codeword crossing is used: dominated codewords may have empty regions.

For average error the complete output order cannot improve on this decoder. Conditional on its count, the permuted output word is uniform over all words with that count, independently of the transmitted message. Averaging any full-output decoder over that conditional law gives a randomized count decoder with exactly the same messagewise success probabilities. At each count, maximizing the uniform-prior average success is achieved by a deterministic maximum-likelihood choice. This establishes the interval property needed for the converse, without making an unnecessary claim about deterministic count decoders for arbitrary maximal-error optimization.

## B3. Uniform transformed Berry--Esseen bound

Define the strictly increasing coordinate

\[
H(q)=\int_a^q \frac{ds}{\sqrt{v(s)}}\quad (0\le q\le1).
\tag{B6}
\]

Both \(v(0)=ab\) and \(v(1)=(1-a)(1-b)\) are positive. Hence \(H\) has bounded derivatives on this whole interval and its derivative is bounded above and below by positive constants. It has a twice continuously differentiable extension to \(\mathbb R\) with the same two properties and bounded second derivative; for example, smoothly make its derivative constant outside a slightly enlarged interval. Only values on \([0,1]\) are used by the decoder.

**Lemma B3.1.** There is a finite \(C=C(a,b)\) such that, for every \(n\ge1\) and \(0\le w\le n\),

\[
\sup_{t\in\mathbb R}
\left|\mathbb P\{\sqrt n[H(Y_w/n)-H(q_w)]\le t\}-\Phi(t)\right|
\le \frac C{\sqrt n}.
\tag{B7}
\]

**Proof.** Let
\(Z=(Y_w-nq_w)/\sqrt{nv(q_w)}\). The independent-summand Berry--Esseen inequality gives

\[
\sup_x|\mathbb P(Z\le x)-\Phi(x)|\le C_0/\sqrt n,
\]

uniformly in \(w\): every summand has absolute centered third moment at most one, while \(nv(q_w)\ge n\min(\sigma_a^2,\sigma_b^2)>0\). This is the classical independent, not necessarily identically distributed, Berry--Esseen theorem; an inspected primary proof with precisely this formulation is Vershynin [BE, Theorem 0.1].

For \(q=q_w\), put
\[
T_{n,q}(x)=\sqrt n\,[H(q+\sqrt{v(q)/n}\,x)-H(q)].
\]
It is a bijection of \(\mathbb R\), fixes zero, and its derivative at zero is one. Uniform derivative bounds give constants \(c_1,c_2,C_1>0\) such that

\[
c_1|x|\le |T_{n,q}(x)|\le c_2|x|,
\qquad |T_{n,q}(x)-x|\le C_1x^2/\sqrt n.
\]

The two arguments \(x,T_{n,q}(x)\) have the same sign. The normal density on the interval between them is bounded by \((2\pi)^{-1/2}\exp(-c_3x^2)\) for a positive \(c_3\). Consequently

\[
|\Phi(T_{n,q}(x))-\Phi(x)|
\le (C_2/\sqrt n)x^2e^{-c_3x^2}
\le C_3/\sqrt n.
\]

Apply the Berry--Esseen bound at \(T_{n,q}^{-1}(t)\). The probability in (B7) is exactly the distribution function of \(T_{n,q}(Z)\); lattice rounding is already covered by the uniform distribution-function bound. The two errors add. \(\square\)

For an interval, including an unbounded or empty interval, (B7) implies an error at most \(2C/\sqrt n\). This remains true for any combination of open and closed endpoints, by taking left limits of distribution functions and using continuity of the normal law.

## B4. Finite comparison with the Gaussian packing problem

Set \(L_n=\sqrt n[H(b)-H(a)]=\sqrt n L\), and define

\[
f(t)=2\Phi(t/2)-1,\qquad
G_M(L_n)=\frac{1+(M-1)f(L_n/(M-1))}{M}\quad(M\ge2).
\tag{B8}
\]

This is the largest average success probability for \(M\) unit-variance normal means in an interval of length \(L_n\), including coincident means. It follows from midpoint decoding and concavity of \(f\), as proved in the main manuscript.

**Theorem B4.1 (finite comparison).** For every \(M\ge2\), the largest average success probability in the original binary-output experiment is at most

\[
G_M(L_n)+2C/\sqrt n.
\tag{B9}
\]

For the equally spaced metric grid with its types rounded to integers, let
\(\rho_n=K/\sqrt n\), where \(K\) depends only on \(a,b\) and bounds the displacement of any rounded metric point. If
\(L_n/(M-1)>2\rho_n\), the resulting code has maximal error at most

\[
2\Phi\!\left(-\frac{L_n}{2(M-1)}+\rho_n\right)+2C/\sqrt n.
\tag{B10}
\]

**Proof.** Derandomize the encoder message by message into endpoint words, while retaining its decoder. Replacing the decoder by the average-optimal count decoder can only improve average success. By Lemma B2.1 this decoder uses \(M\) ordered intervals. Transform the observation by \(H\); every such region remains an interval. Apply (B7) separately to each region and average. The error is \(2C/\sqrt n\), not \(2MC/\sqrt n\). The corresponding Gaussian interval decoder cannot exceed the optimal Gaussian average success. All transformed code means lie in the interval of length \(L_n\), so (B9) follows.

For achievability, choose target points \(s_j=jL_n/(M-1)\), \(j=0,\ldots,M-1\), set \(q_j=H^{-1}(s_j/\sqrt n)\), and round \(n(q_j-a)/(b-a)\) to the nearest integer in \([0,n]\). Since \(H'\) is bounded, the transformed mean changes by at most \(K/\sqrt n\). Distinct rounded means are separated by at least \(L_n/(M-1)-2\rho_n\). Decode the transformed observation to its nearest actual transformed mean. An interior message can be wrongly decoded only if its transformed noise exceeds half that minimum gap in absolute value; endpoint messages have only one erroneous tail. Bound both tails by (B7). This proves (B10). \(\square\)

## B5. Inverting the risk bounds

We now prove (B1) without replacing a finite error constraint by an asymptotic statement. Write \(A=L/(2z_\epsilon)>0\).

First (B9), together with \(f(t)\le t/\sqrt{2\pi}\), implies

\[
1-\epsilon\le\frac{1+L_n/\sqrt{2\pi}}M+2C/\sqrt n.
\]

For all sufficiently large \(n\), every admissible average-error code therefore has \(M=O(\sqrt n)\). For the desired upper bound it suffices to consider \(M\ge A\sqrt n/2\), since all smaller \(M\) already satisfy it. From (B9),

\[
\left(1-\frac1M\right)2\Phi\!\left(-\frac{L_n}{2(M-1)}\right)
\le\epsilon+2C/\sqrt n.
\]

Here \(1/M=O(n^{-1/2})\), so the tail probability is at most \(\epsilon+O(n^{-1/2})\). The normal quantile is continuously differentiable at \(1-\epsilon/2\). Inverting gives

\[
\frac{L_n}{2(M-1)}\ge z_\epsilon-O(n^{-1/2}),
\qquad M\le A\sqrt n+O(1).
\]

This upper bound also applies to maximal error. Conversely, choose
\(M=\lfloor A\sqrt n-D\rfloor\) with a fixed sufficiently large \(D>0\). For large \(n\),

\[
\frac{L_n}{2(M-1)}-\rho_n
\ge z_\epsilon+\frac{D'}{\sqrt n},
\]

where \(D'\) can be made arbitrarily large by increasing \(D\). Since the derivative of \(2\Phi(-z)\) at \(z=z_\epsilon\) is \(-2\phi(z_\epsilon)<0\), choose \(D'\) so that the improvement in the normal tail exceeds \(2C/\sqrt n\), with a strict margin for the Taylor remainder. Formula (B10) is then at most \(\epsilon\) for every sufficiently large \(n\). Enlarging the final fixed remainder covers the finitely many smaller blocklengths. This proves (B1) for both error criteria.

Finally, integrating the reciprocal square root of the positive affine function \(v\) gives

\[
H(b)-H(a)=\frac{2(b-a)}{\sqrt{v(a)}+\sqrt{v(b)}}.
\]

This identity includes the zero-slope case \(a+b=1\), by direct evaluation rather than division by that slope. For the binary symmetric channel with crossover \(p\in(0,1/2)\), it becomes

\[
M^*(n,\epsilon)=
\frac{1-2p}{2\sqrt{p(1-p)}\,z_\epsilon}\sqrt n+O(1).
\]

The proof also yields an \(O(n^{-1/2})\) comparison of optimal average and maximal errors with the Gaussian error curve when \(M/\sqrt n\) stays in a fixed compact subset of \((0,\infty)\). It does not identify the bounded, lattice-sensitive second term in the integer code size.

## B6. Attribution and formal scope

Berry--Esseen approximation, log-concavity of Bernoulli sums, variance stabilization, and Gaussian nearest-neighbor decoding are classical. This supplement's asserted contribution is their uniform combination for the exact noisy-permutation count experiment, including the arbitrary-code converse and bounded code-size remainder. The source and novelty audit lists the inspected channel-coding and statistical-geometry predecessors. The argument is an ordinary mathematical proof; executable finite checks and the accompanying Lean algebraic lemmas do not certify its analytic or probabilistic steps. Full Lean coverage remains separately pending unless the formalization report explicitly changes that status.

**[BE]** R. Vershynin. *A friendly proof of the Berry--Esseen theorem*. arXiv:2602.06234v1, 2026, Theorem 0.1. [Versioned preprint](https://arxiv.org/abs/2602.06234v1). [Author's complete proof](https://www.math.uci.edu/~rvershyn/papers/berry-esseen.pdf). This citation uses the v1 title; v2 is titled *Two Friendly Proofs of the Berry--Esseen Theorem*. The theorem is classical, originating with Berry (1941) and Esseen (1942); the cited proof is used to verify the nonidentically distributed formulation, not to assert a new normal-approximation result.
