---
title: "Hard-budget vertical covariance estimation under fourth moments: general and rank-one laws"
lang: en
---

## Abstract

Agents observe different coordinates of the same aligned sample. Each communicates once under a per-agent bit limit that holds for every input and every random realization. For unrestricted covariance under an absolute directional fourth-moment bound, a local prefix code, a finite-net median decoder and the Gaussian converse give the sharp expected operator-norm rate. The same code gives a confidence bound and a polynomial-time sub-Gaussian decoder. Under exact rank at most one, agents use their entire local sample to recover compatible coordinates of a common factor. For any number \(K\) of agents with heterogeneous dimensions and budgets, we characterize the minimax risk by a matching ordering formula. With equal dimensions \(p\) and budgets \(B\), the communication term is \(\min\{1,[(1+\log K)/2^B]^{1/p}\}\). A multiscale quantizer and a collection of independent radial priors resolve the gap between one-scale upper and lower bounds.

## 1. Model and result

Let \(K\ge2\), let \(d_1,\ldots,d_K\) be positive integers, and put \(d=\sum_kd_k\). The same \(m\ge1\) independent and identically distributed observations \(X_1,\ldots,X_m\in\mathbb R^d\) are split by coordinate blocks. Agent \(k\) sees only its \(d_k\) coordinates of all observations. The partition and sample alignment are known in advance. Its budget \(B_k\) is a nonnegative integer.

For a known \(\sigma>0\), define \(\mathcal P_4(\sigma)\) to consist of laws with an arbitrary unknown mean \(\mu\), satisfying

\[
 \mathbb E|u^\top(X-\mu)|^4\le\sigma^4\|u\|_2^4
 \qquad(u\in\mathbb R^d).                         \tag{1}
\]

Write \(\Sigma=\operatorname{Cov}(X)\). Cauchy--Schwarz implies \(0\preceq\Sigma\preceq\sigma^2I\). Condition (1) is an absolute moment bound; no relative kurtosis bound and no nonsingularity assumption is imposed.

An admissible protocol has one encoder per agent and a PSD-valued measurable decoder. The private random variables of distinct agents are independent of one another and of the observations. For every input and every random realization the message from agent \(k\) has at most \(B_k\) bits. There is no public random seed, feedback, or free variable-length side channel. Fixed protocol parameters and a fixed deterministic net are common knowledge. Define

\[
 \mathcal R_4(m,\mathbf d,\mathbf B;\sigma)
 =\inf_{\Pi}\sup_{P\in\mathcal P_4(\sigma)}
     \mathbb E_{P,\Pi}\|\widehat\Sigma-\Sigma\|_{\rm op}.
                                                               \tag{2}
\]

All expectations include the private randomness. A budget-zero message has one possible value. Equivalently one may allow strings of all lengths up to \(B_k\); these have fewer than \(2^{B_k+1}\) possibilities. The all-parameter lower bound below is unchanged up to universal constants for \(B_k\ge1\), and the zero-budget case is handled separately. Our upper construction uses a fixed length, so it satisfies either convention.

**Theorem 1 (hard-budget minimax law).** There are absolute constants \(c,C>0\) such that, for every parameter choice above,

\[
 c\sigma^2\min\left\{1,
       \sqrt{d/m}+\sqrt{d\max_k(d_k/B_k)}\right\}
 \le \mathcal R_4
 \le
 C\sigma^2\min\left\{1,
       \sqrt{d/m}+\sqrt{d\max_k(d_k/B_k)}\right\}.       \tag{3}
\]

Here \(d_k/0=+\infty\). The upper protocol needs no knowledge of \(\mu\), works for singular covariances, and outputs a matrix in \([0,\sigma^2I]\). Its fourth-moment decoder can require exponentially many directions. This is an information-theoretic result, not a polynomial-time assertion for the full class (1).

For convenience put

\[
 H=\min\{m,\min_k B_k/d_k\}.
                                                               \tag{4}
\]

With the convention that \(\min\{1,\sqrt{d/H}\}=1\) at \(H=0\), the rate in (3) is equivalent, within a factor of two, to \(\sigma^2\min\{1,\sqrt{d/H}\}\).

**Theorem 2 (confidence upper bound).** For every \(0<\delta<1/2\), there is an admissible protocol with

\[
 \mathbb P\left\{\|\widehat\Sigma_\delta-\Sigma\|_{\rm op}
       >C\sigma^2\min\left\{1,
         \sqrt{\frac{d+\log(2/\delta)}{H}}\right\}\right\}
 \le\delta.                                                     \tag{5}
\]

The encoding can be identical for all \(\delta\); only the decoder and the decision to use the trivial output depend on \(\delta\). No matching confidence-dependent communication lower bound is claimed.

**Theorem 3 (efficient sub-Gaussian specialization).** Replace (1) by

\[
 \mathbb E\exp(tu^\top(X-\mu))
   \le\exp(t^2\sigma^2\|u\|_2^2/2)
 \qquad(t\in\mathbb R,u\in\mathbb R^d).                         \tag{6}
\]

There is an admissible protocol whose decoder uses matrix products and an eigendecomposition and has the expected rate in the upper bound of (3). For the actual number \(n\) of transmitted pairs it has the usual sub-Gaussian bound

\[
 C\sigma^2\left\{\sqrt{(d+t)/n}+(d+t)/n\right\}                 \tag{7}
\]

outside an event of probability at most \(2e^{-t}+K(25/128)^n\), after changing absolute constants. A zero-output branch supplies the saturated regimes. Polynomial time here means arithmetic complexity in \(n,d\) and decoding the finite messages, not exact bit complexity on arbitrary real-valued inputs. A proxy \(\sigma\) in (6) is not literally the same fourth-moment normalization as (1); converting between the two costs a universal constant.

## 2. Relation to existing results

Rahmani--Yassaee--Aref [RYA25, Theorems 4.2, 4.5, 4.10 and (38)] study the same feature-split communication architecture for sub-Gaussian covariance estimation. Their stated achievability bounds contain logarithmic factors; their Gaussian converse supplies the lower-bound ingredient used here. Their Appendix H already uses private randomized rounding, and their Section 6 uses paired differences for unknown means.

Chen--Ng [CN25, Section 2.1, Lemma 1 and Theorem 3] obtain a log-free statistical bound from unbounded multibit quantization. That fact does not by itself bound the length of the messages on every input. Chen--Ng--Wang [CNW24, Section 3.1, Theorem 3] already treat an absolute directional fourth-moment condition; their bound contains a dimension logarithm and the procedure uses a full-vector truncation. The new comparison in this manuscript is confined to a purely local vertical encoder with a hard total budget and the rate (3).

The one- and two-bit-per-coordinate models of Dirksen--Maly--Rauhut [DMR22] and Dirksen--Maly [DM24] are different constraints. Our code has constant amortized cost per coordinate but unbounded individual codeword lengths before block truncation. It does not resolve a strict two-bit-per-coordinate question. Variable-length entropy coding after stochastic quantization is also established: [SSRY22, Section 6.1] explicitly uses Elias or arithmetic codes and credits earlier distributed-mean and QSGD work. Thus neither that pairing nor Elias coding itself is an originality claim here. The relevant extra argument is a dimension-normalized exponential bound from marginal second moments, followed by hard truncation and the covariance-risk coupling. Robust unquantized covariance estimation, including stronger effective-rank results under different assumptions, is already established [MZ20]. The net and median arguments below are supplied for completeness, not claimed as new robust-statistical primitives. The sparse model in [TH26] estimates cross-covariance in Frobenius loss, and [AC26] estimates a robust mean. Section 9 treats the closer structural quantization results.

## 3. Local centering and two-replica moment identities

### Lemma 4 (paired differences)

Let \(X,X'\) be independent with the same law in \(\mathcal P_4(\sigma)\), and set
\(Y=(X-X')/\sqrt2\). Then

\[
 \mathbb EY=0,\quad \mathbb EYY^\top=\Sigma,\quad
 \mathbb E(u^\top Y)^2\le\sigma^2,\quad
 \mathbb E(u^\top Y)^4\le2\sigma^4                    \tag{8}
\]

for every unit vector \(u\).

**Proof.** For \(V=u^\top(X-\mu)\), independence and \(\mathbb EV=0\) give

\[
 \mathbb E\left(\frac{V-V'}{\sqrt2}\right)^4
   =\tfrac12\mathbb EV^4+\tfrac32(\mathbb EV^2)^2
   \le2\sigma^4.
\]

The second-moment identity follows by expanding the product and using the same independence. Both agents forming a coordinate of \(Y\) use the same predetermined pair of sample indices; no centering statistic is sent. Disjoint pairs are independent. Under (6), \(Y\) also satisfies (6), by multiplying the two moment-generating-function bounds. \(\square\)

### Lemma 5 (rounding, preservation, and unbiased cross products)

For each coordinate define

\[
 a_j=\lfloor Y_j/\sigma\rfloor,\quad
 \theta_j=Y_j/\sigma-a_j,\quad
 Z_j^{(r)}=\sigma(a_j+\xi_j^{(r)}),\quad r=1,2,       \tag{9}
\]

where, conditional on \(Y\), the variables \(\xi_j^{(r)}\) are independent Bernoulli variables with success probability \(\theta_j\). All agents can generate their own coordinates of (9) with independent private random variables. The same construction is performed independently on each pair.

For \(A=(Z^{(1)}Z^{(2)\top}+Z^{(2)}Z^{(1)\top})/2\),

\[
 \mathbb EA=\Sigma,\qquad
 \mathbb E(u^\top Au)^2\le\frac{41}{16}\sigma^4<3\sigma^4
 \quad(\|u\|_2=1).                                      \tag{10}
\]

In addition \(\mathbb E|u^\top Z^{(r)}|^4\le40\sigma^4\) for unit \(u\).

**Proof.** The rounding error \(\varepsilon_j=Z_j-Y_j\) has conditional mean zero, lies in an interval of length \(\sigma\), and has conditional variance \(\sigma^2\theta_j(1-\theta_j)\le\sigma^2/4\). Thus

\[
 \mathbb E[Z^{(r)}\mid Y]=Y,\quad
 v_u(Y):=\mathbb E[(u^\top\varepsilon^{(r)})^2\mid Y]
      \le\sigma^2/4.                                      \tag{11}
\]

The two replicas are conditionally independent, including corresponding coordinates. Consequently \(\mathbb E[A\mid Y]=YY^\top\), including its diagonal. Also

\[
 \begin{aligned}
 \mathbb E[(u^\top Au)^2\mid Y]
   &=\mathbb E[(u^\top Z^{(1)})^2\mid Y]
     \mathbb E[(u^\top Z^{(2)})^2\mid Y]\\
   &=\big((u^\top Y)^2+v_u(Y)\big)^2\\
   &\le (u^\top Y)^4+\tfrac12\sigma^2(u^\top Y)^2
         +\tfrac1{16}\sigma^4.
 \end{aligned}
\]

Apply (8). For moment preservation, expand the fourth power of the sum of the conditionally independent centered errors. Its conditional fourth moment is at most
\(\sigma^4\sum_j u_j^4+6\sigma^4\sum_{i<j}u_i^2u_j^2\le3\sigma^4\).
The scalar inequality \(|a+b|^4\le8(|a|^4+|b|^4)\), followed by (8), gives the stated bound 40. \(\square\)

Using one replica without a diagonal correction would not have (10). Conditional unbiasedness of a vector alone does not imply unbiasedness of its outer product.

## 4. A hard communication bound from marginal second moments

### Lemma 6 (prefix coding without coordinate independence)

Let \(Y\in\mathbb R^p\) satisfy \(\mathbb EY_j^2\le\sigma^2\). Use the two integer roundings \(Q_j^{(r)}=Z_j^{(r)}/\sigma\) in (9). Encode an integer \(q\) by the Elias gamma code of the positive integer

\[
 \nu(q)=\begin{cases}2q+1,&q\ge0,\\-2q,&q<0.\end{cases}
\]

If \(\ell(q)=2\lfloor\log_2\nu(q)\rfloor+1\) and
\(L=\sum_{j=1}^p\sum_{r=1}^2\ell(Q_j^{(r)})\), then

\[
 \mathbb E2^{L/(2p)}\le50.                               \tag{12}
\]

For \(n\) independent rows with total length \(S\),

\[
 \mathbb P\{S>16np\}\le(25/128)^n.                     \tag{13}
\]

**Proof.** For every possible rounding,
\(|Q_j^{(r)}|\le |Y_j|/\sigma+1\) and
\(\nu(Q_j^{(r)})\le2|Y_j|/\sigma+3\). Hence

\[
 \mathbb E2^{\ell(Q_j^{(r)})}
  \le2\mathbb E(2|Y_j|/\sigma+3)^2
  \le2(4+12+9)=50,
\]

using \(\mathbb E|Y_j|/\sigma\le1\). Pointwise arithmetic--geometric mean, with all \(2p\) codewords, gives

\[
 2^{L/(2p)}
 =\left(\prod_{j,r}2^{\ell(Q_j^{(r)})}\right)^{1/(2p)}
 \le\frac1{2p}\sum_{j,r}2^{\ell(Q_j^{(r)})}.
\]

This step uses no within-row independence. Independence of complete rows now gives
\(\mathbb E2^{S/(2p)}\le50^n\). Markov's inequality at \(S=16np\) proves (13). The gamma code is prefix-free: count leading zeroes, read the next one and that many remaining binary digits. The map \(\nu\) is a bijection from integers to positive integers. \(\square\)

### Protocol and exact accounting

Choose

\[
 n=\max\left\{0,\min\left(\lfloor m/2\rfloor,
          \min_k\left\lfloor\frac{B_k-1}{16d_k}\right\rfloor
                  \right)\right\}.                         \tag{14}
\]

If the decoder's sample threshold is not met, use the predetermined zero-output protocol and send no bits. Otherwise each agent forms the first \(n\) paired differences, generates its two private replicas, and concatenates exactly \(2nd_k\) prefix codewords in a fixed known order. If their length exceeds \(16nd_k\), it sends a zero flag followed by \(16nd_k\) zeroes. Otherwise it sends a one flag, all codewords, and enough zeroes to make its message length exactly

\[
 1+16nd_k\le B_k.                                         \tag{15}
\]

The decoder knows \(n,d_k\), so it parses exactly \(2nd_k\) codewords and ignores padding. It outputs zero if any failure flag is received. Every input and every realization satisfies (15); (13) is needed only to control accuracy. There is no uncharged transmitted scale, range, index list, length, or seed. An equivalent variant uses the larger payload cap \(B_k-1\) and pads to exactly \(B_k\) bits; since \(B_k-1\ge16nd_k\), the same overflow bound applies. The reference implementation uses that variant to exploit unused budget. For an encoder shared by all confidence levels in Theorem 2, send this same fixed package whenever \(n\ge1\), including when a confidence-tuned decoder ignores it and returns zero; when \(n=0\), every decoder returns zero and sends no messages. The optional no-message shortcut for an inactive decoder is not needed for the shared-encoder assertion.

Let \(F\) be the union of the agents' overflow events in a virtual experiment that generates all untruncated roundings. A union bound, not independence of agents' data, gives

\[
 \mathbb P(F)\le K r^n,\qquad r=25/128.                    \tag{16}
\]

For any virtual decoder valued in \([0,\sigma^2I]\), the actual decoder agrees with it on \(F^c\), while both losses are at most \(\sigma^2\). In particular,

\[
 \mathbb E\|\widehat\Sigma-\Sigma\|_{\rm op}
 \le\mathbb E\|\widetilde\Sigma-\Sigma\|_{\rm op}
            +\sigma^2 K r^n.                              \tag{17}
\]

We do not assert that the virtual observations remain independent after conditioning on successful encoding. The unconditional coupling (17) avoids that false inference.

## 5. Fourth-moment reconstruction

### Lemma 7 (finite-net reduction)

Fix a deterministic \(1/4\)-net \(\mathcal N\) of the unit sphere, with \(|\mathcal N|\le9^d\). Such a net follows by taking a maximal separated set and comparing disjoint radius-\(1/8\) balls with their containing ball. For every symmetric matrix \(D\),

\[
 \|D\|_{\rm op}\le2\max_{u\in\mathcal N}|u^\top Du|.       \tag{18}
\]

Indeed take a unit eigenvector at a largest-magnitude eigenvalue and a net point within \(1/4\). Expanding the difference of the two quadratic forms bounds it by \(2(1/4)\|D\|_{\rm op}\). The volume argument gives \((1+2/(1/4))^d=9^d\). This is a standard net estimate.

### Lemma 8 (integrable simultaneous median error)

Suppose \(A_1,\ldots,A_n\) are independent copies of Lemma 5. Let \(q\) be odd and \(n\ge q\), put \(s=\lfloor n/q\rfloor\), discard unused observations, and divide the remaining observations into \(q\) fixed disjoint blocks of size \(s\). For each \(u\in\mathcal N\), take the median \(T_u\) of the block means of \(u^\top A_i u\). Put

\[
 W=\max_{u\in\mathcal N}|T_u-u^\top\Sigma u|,
 \qquad h=(q+1)/2,\quad v=3\sigma^4.
\]

For all \(t>0\),

\[
 \mathbb P\{W>t\}\le9^d\left(\frac{4v}{s t^2}\right)^h.     \tag{19}
\]

For \(q=8d+1\),

\[
 \mathbb EW\le8\sqrt{v/s}.                               \tag{20}
\]

**Proof.** Each block mean has variance at most \(v/s\). For a fixed direction, Chebyshev gives a bad-block probability at most \(v/(st^2)\). A bad median needs at least \(h\) bad blocks. Independence across blocks and a union bound over subsets give
\(2^q(v/(st^2))^h\le(4v/(st^2))^h\). A union bound over directions proves (19); their estimates need not be independent. With \(t_0=4\sqrt{v/s}\) and \(h=4d+1\),
\(9^d4^{-h}\le1\), and therefore

\[
 \mathbb P\{W>t\}\le(t_0/t)^{2h}\quad(t\ge t_0).
\]

Integrating this tail gives
\(\mathbb EW\le t_0+t_0/(2h-1)\le2t_0\).
This integration is necessary: a fixed-probability accuracy statement alone would not establish the expected risk at arbitrarily large \(n\). \(\square\)

### Lemma 9 (PSD and measurable reconstruction)

For observed medians \(T=(T_u)_{u\in\mathcal N}\), let \(\widetilde\Sigma\) be the unique minimizer, over \(0\preceq M\preceq\sigma^2I\), of

\[
 f_T(M)+\lambda\|M\|_F^2,
 \qquad f_T(M)=\max_{u\in\mathcal N}|u^\top Mu-T_u|,
 \qquad\lambda=(\sigma^2dn)^{-1}.                       \tag{21}
\]

This decoder is measurable, lies in the required interval, and satisfies

\[
 \|\widetilde\Sigma-\Sigma\|_{\rm op}\le4W+2\sigma^2/n.     \tag{22}
\]

**Proof.** The feasible set is nonempty and compact. The objective is continuous and strictly convex because \(\lambda>0\); hence it has a unique minimizer. If \(T_j\to T\), any convergent subsequence of minimizers, available by compactness, minimizes the limiting objective by continuity. Uniqueness makes its limit \(\widetilde\Sigma(T)\). Thus the map is continuous, in particular Borel. The median is itself a measurable function of finitely many observations.

Since \(\Sigma\) is feasible, comparison in (21) gives
\(f_T(\widetilde\Sigma)\le W+\lambda\|\Sigma\|_F^2\le W+\sigma^2/n\).
For each net direction the quadratic-form error is consequently at most \(2W+\sigma^2/n\). Apply (18). \(\square\)

### Proof of the upper bound in Theorem 1

If \(n<8d+1\), output zero. Otherwise apply Lemmas 8 and 9 with \(q=8d+1\) in the virtual experiment, and the hard protocol in Section 4. Since \(s\ge n/(2q)\), (17), (20), and (22) give

\[
 \mathbb E\|\widehat\Sigma-\Sigma\|_{\rm op}
 \le32\sqrt{3\sigma^4/s}+2\sigma^2/n+\sigma^2K r^n
 \le C\sigma^2\sqrt{d/n}.                                \tag{23}
\]

For the last term, \(K\le d\), \(n\ge8d+1\), and \(r<e^{-1}\); these imply \(d r^n\le C\sqrt{d/n}\) uniformly. For example \(d\le n\) and \(n^{3/2}e^{-n}\le1\) for positive integers \(n\) suffice. The loss is always at most \(\sigma^2\).

We now justify all floor and small-budget regimes. If \(H\ge64\), then
\((B_k-1)/(16d_k)\ge(H-1)/16\ge H/32\) and \(m/2\ge H/2\), so (14) gives \(n\ge H/64\). Consequently, if \(n<8d+1\), either \(H<64\), or \(H<64(8d+1)\). In both cases \(H\le C_0d\) for an absolute \(C_0\), and the zero loss bound \(\sigma^2\) has the required order with a larger universal constant. In the active branch, if \(H\ge64\), (23) gives the desired \(\sqrt{d/H}\); if \(H<64\), the same saturated bound applies. This proves the upper half of (3), including \(m=1\), zero budgets, and arbitrary partitions. \(\square\)

### Proof of Theorem 2

Take

\[
 q_\delta=2\left\lceil4d+\log(2/\delta)\right\rceil+1.
\]

If \(n<q_\delta\), use zero; the preceding floor argument with \(d+\log(2/\delta)\) establishes the saturated statement (5). Otherwise use this number of median blocks. At \(t_0=4\sqrt{v/s}\), (19) is at most \(\delta/2\): here
\(h\ge4d+\log(2/\delta)\), \(9^d4^{-4d}\le1\), and
\(4^{-\log(2/\delta)}\le\delta/2\). Also

\[
 K r^n\le d e^{-n}\le\delta/2,
\]

because \(n\ge q_\delta\ge8d+2\log(2/\delta)\). Outside these two exceptional events, (22) and \(s\ge n/(2q_\delta)\) give (5), after the same comparison between \(n\) and \(H\). \(\square\)

## 6. Efficient sub-Gaussian decoder

Under (6), conditional Hoeffding's lemma applied coordinatewise to the independent rounding errors yields

\[
 \mathbb E[e^{t u^\top\varepsilon^{(r)}}\mid Y]
 \le\exp(t^2\sigma^2\|u\|_2^2/8).
\]

Hence \(Z^{(r)}\) is centered sub-Gaussian with variance proxy at most \(5\sigma^2/4\). The vectors \(W_+=Z^{(1)}+Z^{(2)}\) and \(W_-=Z^{(1)}-Z^{(2)}\) have directional proxies at most \(9\sigma^2/2\) and \(\sigma^2/2\), respectively: condition on \(Y\), multiply the error bounds, and for \(W_+\) use the proxy for \(2Y\). They are not claimed to be independent of one another. The rows are independent.

Set \(S=n^{-1}\sum_i A_i\). The identity

\[
 A_i=\tfrac14(W_{+,i}W_{+,i}^\top-W_{-,i}W_{-,i}^\top)       \tag{24}
\]

reduces concentration to two ordinary sample second-moment matrices. For completeness, a centered scalar with proxy \(a^2\) has tail at most \(2e^{-t^2/(2a^2)}\); integrating the tail bounds its even moments by \(2(2a^2)^p p!\). The centered square consequently has \(p\)-th absolute moment at most \(p!(C a^2)^p\). Expanding its exponential series for \(|\lambda|\le c/a^2\) gives a moment-generating-function bound \(\exp(C\lambda^2a^4)\). Multiplying across independent rows and optimizing the exponential Markov bound gives

\[
 \mathbb P\left(\left|n^{-1}\sum_i(V_i^2-\mathbb EV_i^2)\right|>x\right)
 \le2\exp\{-cn\min(x^2/a^4,x/a^2)\}.
\]

Apply this bound on a \(1/4\)-net of at most \(9^d\) directions, then use (18), (24), and a union bound for \(W_+,W_-\). This proves (7) for \(S-\Sigma\), with a change of constants. Integrating the bound proves
\(\mathbb E\|S-\Sigma\|_{\rm op}\le C\sigma^2(\sqrt{d/n}+d/n)\).

Clip the eigenvalues of \(S\) to \([0,\sigma^2]\), obtaining \(\widetilde\Sigma\). Weyl's inequality and feasibility of \(\Sigma\) show
\(\|\widetilde\Sigma-S\|_{\rm op}\le\|S-\Sigma\|_{\rm op}\), so

\[
 \|\widetilde\Sigma-\Sigma\|_{\rm op}\le2\|S-\Sigma\|_{\rm op}. \tag{25}
\]

This proof does not require an unproved assertion that spectral clipping is a contraction in operator norm. Combine (25) with the overflow coupling and the zero branch for \(n<d\). Matrix products cost \(O(nd^2)\) arithmetic operations and an eigendecomposition costs \(O(d^3)\) in the standard arithmetic model. Parsing costs the number of transmitted bits. This proves Theorem 3. \(\square\)

### Explicit sub-Gaussian constants

The cross-products in (10) give a second proof with explicit constants. For any unit \(u\), write \(U=u^{\mathsf T}Z^{(1)}\), \(V=u^{\mathsf T}Z^{(2)}\) and \(\tau^2=5\sigma^2/4\), their common sub-Gaussian proxy from the conditional Hoeffding bound above. Neither calculation requires their unconditional independence. Tail integration gives \(\mathbb E|U|^{2l}\le 2^{l+1}l!\tau^{2l}\) and the same for \(V\). With Cauchy–Schwarz and the power triangle bound, for \(l\ge2\) the centered product \(C=UV-\mathbb E UV\) satisfies

\[
 \mathbb E|C|^l\le 2l!(4\tau^2)^l
 =\frac{l!}2 (64\tau^4) (4\tau^2)^{l-2}.
\]

For \(n\) independent rows the power series gives a log moment-generating bound \(nv^2 q^2/[2(1-b|q|)]\) for their centered sum when \(|q|<1/b\), with \(b=4\tau^2,v^2=64\tau^4\). With \(a=\sqrt{2t/(nv^2)}\), take \(q=a/(1+ba)\) in the Chernoff bound. This yields two-sided scalar tail \(2e^{-t}\) above \(\sqrt{2v^2t/n}+bt/n\) for the average. Using (18) and the \(1/4\)-net of size at most \(9^d\), write \(q_d=d\log9+\log2\). Then for \(t\ge0\),

\[
 \Pr\left\{\|S-\Sigma\|_{\rm op}
 >2\tau^2\left[\sqrt{128(q_d+t)/n}+4(q_d+t)/n\right]\right\}\le e^{-t}.
\]

This tail dominates the loss by the displayed threshold evaluated at an exponential variable of mean one. Jensen and \(q_d+1<4d\) show that the expected virtual error is at most \(40\sqrt2\,\sigma^2\sqrt{d/n}+40\sigma^2d/n\). Clipping by (25) and using (16)–(17) yields for the actual finite messages

\[
 \mathbb E\|\widehat\Sigma-\Sigma\|_{\rm op}
 \le \min\left\{\sigma^2,\ 
  80\sqrt2\,\sigma^2\sqrt{d/n}+80\sigma^2d/n
  +\sigma^2\min(1,K(25/128)^n)\right\}.
\]

For \(n\ge d\ge K\), the overflow term divided by \(\sigma^2\) is at most \(d2^{-n}\le\sqrt{d/n}\) because \(\sqrt{dn}\,2^{-n}\le n2^{-n}\le1\). The bound is therefore at most \(200\sigma^2\min\{1,\sqrt{d/n}\}\) for all \(n\ge1\), using saturation for \(n<d\). If \(H\ge64\), (14) gives \(n\ge H/64\), and if \(0<H<64\) the saturation bound is at most \(8\sigma^2\min\{1,\sqrt{d/H}\}\). This gives \(1600\sigma^2\min\{1,\sqrt{d/H}\}\) for all \(H\), with the convention at \(H=0\) from §1.

## 7. Gaussian lower bound and model reductions

The following is an imported lower-bound ingredient, not a new theorem of this manuscript. The Gaussian constructions and Fano argument in [RYA25, Theorem 4.2 and Sections 5 and E], with the two-group reduction in its Section 4.4, imply, for covariance scale \(a^2\),

\[
 c a^2\min\left\{1,\max\left(\sqrt{d/m},
                   \max_k\sqrt{d_k d/B_k}\right)\right\}.     \tag{26}
\]

Only an unspecified absolute constant is used. In particular, (26) retains the saturation omitted from the asymptotic display (38). The precise inspected normalization and assumptions of that source were audited separately. Converse source audit

Here are the reductions required for the present setting. For any chosen \(k\), combine all other agents into one super-agent and allow it its entire raw observation. This is a more informative experiment. The resulting dimensions are \(d_k\) and \(d-d_k\), both positive. The two-agent bound with one-sided budget \(B_k\) contains
\(\sqrt{d_k\max(d_k,d-d_k)/B_k}\), which is at least
\(2^{-1/2}\sqrt{d_kd/B_k}\). Take the largest resulting lower bound over \(k\). The centralized Gaussian covariance lower bound supplies the \(\sqrt{d/m}\) term.

Private randomness does not circumvent the source's Fano argument. The hard prior is fixed independently of the encoders. One can reveal all independent seeds to the decoder and condition on them, apply the same prior risk bound for each resulting deterministic encoder, and then average. Equivalently the auxiliary-variable conditional-SDPI inequality used in the proof is valid for stochastic Markov kernels. This argument is about one common prior; selecting a different worst-case distribution separately for each seed would not justify a randomized minimax lower bound.

The Gaussian hard families have \(0\preceq\Sigma\preceq a^2I\). Set \(a^2=\sigma^2/\sqrt3\). For a centered Gaussian member and every unit \(u\),
\(\mathbb E|u^\top X|^4=3(u^\top\Sigma u)^2\le\sigma^4\), so the family lies in (1). Restricting to zero means is allowed in a lower bound for arbitrary unknown means.

For \(B_k=0\), fix all other coordinates to zero and vary one coordinate in block \(k\) between zero variance and Gaussian variance \(\sigma^2/\sqrt3\). The decoder sees the same message law under both models. The triangle inequality implies that one of the two expected losses is at least \(\sigma^2/(2\sqrt3)\), for every \(m\). For positive budgets and the variable-length-string convention, use effective alphabet budget \(B_k+1\le2B_k\) in (26); all constants remain absolute. Taking the maximum of the statistical and communication lower bounds, and using \(a+b\le2\max(a,b)\), proves the lower half of (3). \(\square\)

## 8. Rank-one observations and heterogeneous budgets

We now add the restriction \(\operatorname{rank}(\Sigma)\le1\) to (1) and keep all other sample assumptions. The risk on this class is \(\mathcal R_{4,1}\), with the infimum also permitting public randomness independent of the data. The upper bound uses deterministic encoders. Write \(M_i=2^{B_i}\) for the size of the message alphabet and \(\log\) for the natural logarithm. For integer \(K\ge2\), \(m\ge1\), \(d_i\ge1\) and \(B_i\ge0\), define

\[
 E_* = \min_{\pi\in\mathfrak S_K}\max_{1\le j\le K}
        \left(\frac{1+\log j}{M_{\pi(j)}}\right)^{1/d_{\pi(j)}}.
\tag{27}
\]

**Theorem 10 (matching rank-one risk).** There are absolute constants \(c,C>0\) such that

\[
 c\sigma^2\min\{1,m^{-1/2}+E_*\}
 \le \mathcal R_{4,1}
 \le C\sigma^2\min\{1,m^{-1/2}+E_*\}
\tag{28}
\]

uniformly in all parameters. The upper decoder takes values in \([0,\sigma^2I]\) with rank at most one. The result also holds up to constants under the length convention allowing distinguishable strings of all lengths at most \(B_i\). In that convention their number is less than \(2M_i\), which changes each radius factor in (27) by at most two.

For two agents, \(E_*\) lies between \(\max_i M_i^{-1/d_i}\) and \((1+\log 2)\max_i M_i^{-1/d_i}\). The communication exponent \(B_i/d_i\) therefore holds with coefficient one in the exponent. For common \(d_i=p\) and \(B_i=B\), the communication term after saturation is \(\min\{1,[(1+\log K)/2^B]^{1/p}\}\). In particular, for scalar agents and sufficiently many samples, attaining a fixed sufficiently small constant error in units of \(\sigma^2\) requires and suffices to have \(B=\log_2(1+\log K)+O(1)\) at the threshold, with constants depending on the chosen error.

### 8.1. A common factor computed locally

For \(\Sigma=\lambda uu^{\mathsf T}\) with \(\|u\|=1\) and \(0<\lambda\le\sigma^2\), every coordinate of \(X-\mu\) in a finite orthonormal basis of \(u^\perp\) has variance zero. Thus \(X-\mu=Zu\) almost surely, with \(\mathbb E Z=0\), \(\mathbb E Z^2=\lambda\) and \(\mathbb E Z^4\le\sigma^4\). In the zero-covariance case all centered observations vanish almost surely. For \(m\ge2\), pair \(n_1=\lfloor m/2\rfloor\) aligned samples, as in (8), and write \(Y_i=T_i u\) and \(S=n_1^{-1}\sum_i T_i^2\). Independence and (8) give

\[
 \mathbb E S=\lambda,\qquad
 \mathbb E|S-\lambda|\le \sqrt2\sigma^2/\sqrt{n_1}.
\tag{29}
\]

Agent \(k\) with all-zero paired input uses \(v_k=0\). Otherwise it takes the first local nonzero index \(i_k\) and computes

\[
 v_k=\frac{Y_{i_k,k}}{\|Y_{i_k,k}\|}
          \left(\frac1{n_1}\sum_i\|Y_{i,k}\|^2\right)^{1/2}.
\tag{30}
\]

For every \(u_k\ne0\), \(Y_{i,k}\) is nonzero exactly when \(T_i\) is nonzero. Hence all nonzero blocks select the same index and have \(v_k=s\sqrt S u_k\), with common sign \(s\). If all paired inputs vanish choose \(s=1\). For a zero block both sides vanish. These are finite measurable rules on arbitrary input, and neither the index nor the sign is transmitted.

Let \(w_k\) be the local projection of \(v_k\) to its radius-\(\sigma\) Euclidean ball, \(w\) their concatenation and \(a=s\sqrt\lambda u\) the aligned true factor. The product of local projections fixes \(a\) and is nonexpansive, so \(\|w\|\le\sqrt S\) and \(\|w-a\|\le |\sqrt S-\sqrt\lambda|\). The global ball projection of \(w\), denoted \(w'\), has the same bounds. For any vectors \(v_1,v_2\),

\[
 \|v_1v_1^{\mathsf T}-v_2v_2^{\mathsf T}\|_{\rm op}
 \le (\|v_1\|+\|v_2\|)\|v_1-v_2\|.
\tag{31}
\]

Apply this to \(w',a\) to bound error by \(|S-\lambda|\). The multiplicative factor \(\|w'\|+\|a\|\le\sqrt S+\sqrt\lambda\) preserves the square-root sample rate in (29). This analysis also applies when \(m=1\) by using the zero output for that case.

### 8.2. The one-scale bounds

A radius-\(\sigma\) ball in dimension \(d_i\) has an \(M_i\)-point covering with radius at most \(4\sigma M_i^{-1/d_i}\). If \(M_i^{1/d_i}\le3\), use \(\{0\}\); otherwise a maximal separated set with separation \(2\sigma/(M_i^{1/d_i}-1)\) is a net and has at most \(M_i\) points by volume comparison. Each agent quantizes \(w_i\) by its nearest point with a fixed tie rule and sends the codebook index in exactly \(B_i\) bits. For the concatenated codeword \(z\),

\[
 \|z-w\|\le 4\sigma\sqrt{\sum_i M_i^{-2/d_i}}.
\]

Let \(z'\) be its projection to the global radius-\(\sigma\) ball. By (31), \(\|z'z'^{\mathsf T}-w'w'^{\mathsf T}\|_{\rm op}\le2\sigma\|z-w\|\). The server computes only \(z'\), not \(w'\). Equation (29) gives the preceding one-scale upper law

\[
 \mathcal R_{4,1}\le
 C\sigma^2\min\left\{1,m^{-1/2}+\sqrt{\sum_i M_i^{-2/d_i}}\right\}.
\tag{32}
\]

For its corresponding communication lower bound, fix one agent \(i\) and an anchor in a different block of fixed norm \(\sigma/2\). Set every other block to zero. Draw \(x\) uniformly from the radius-\(\sigma/2\) ball in \(\mathbb R^{d_i}\), and conditional on this parameter take each observation to be an independent fair sign times the concatenation of \(x\) and the anchor \(a_0\). The covariance is that concatenation's outer product and the directional fourth moments are bounded by \(\sigma^4\|u\|^4/4\). Give the decoder all sample signs and all independent seeds. Conditional on them, every other message is fixed and the \(i\)-th message has at most \(M_i\) values. From an estimated cross block \(C_{i,0}\) define \(\widehat x=C_{i,0}a_0/\|a_0\|^2\). Then \(\|\widehat x-x\|\le\|\widehat\Sigma-\Sigma\|_{\rm op}/\|a_0\|\). The probability of loss below \(v>0\) is thus bounded by the union of at most \(M_i\) radius-\(v/\|a_0\|\) balls, of total normalized volume at most \(M_i(4v/\sigma^2)^{d_i}\). Take \(v=(\sigma^2/4)2^{-(B_i+2)/d_i}\) and average over the same prior for all seeds. This gives lower bound \(\sigma^2 M_i^{-1/d_i}/32\), and the bound persists when the alphabet has fewer than \(2M_i\) symbols.

For the statistical lower bound, take two centered Gaussian laws on one fixed direction with variances \(\lambda_0=\sigma^2/4\) and \(\lambda_1=\lambda_0(1+h)\), where \(h=1/(2\sqrt m)\). Both satisfy (1), since \(3\lambda_1^2\le27\sigma^4/64\). Give all raw samples to the estimator. The product KL is

\[
 D(P_0^m\|P_1^m)=\frac m2\left(\log(1+h)-\frac{h}{1+h}\right)
 \le\frac{mh^2}{4}=\frac1{16}.
\]

The inequality follows by integrating the derivative \(h/(1+h)^2\le h\). Pinsker gives TV at most \(1/(4\sqrt2)\). Integrating the sum of the two losses against the common part of the laws, the triangle inequality yields maximal risk at least \((\lambda_1-\lambda_0)(1-\operatorname{TV})/2\ge\sigma^2/(32\sqrt m)\). Thus

\[
 \mathcal R_{4,1}\ge
 c\sigma^2\min\{1,m^{-1/2}+\max_i M_i^{-1/d_i}\}.
\tag{33}
\]

For a fixed number of agents, (32)–(33) give the precise separate exponents. Their multiplicative gap can grow as \(\sqrt K\). We close it by changing both the local covering and the hard family.

### 8.3. The multiscale upper bound

Scale to \(\sigma=1\) and take a permutation attaining (27). For the block at position \(j\), set \(b_j=1/j\). Inside its unit ball, assign a central ball of radius \(b_j\), followed by shells whose outer radius is at most twice the inner radius, ending at radius one. For \(0<\eta\le1\), cover the central ball to accuracy \(\eta b_j\) and every outer shell to half \(\eta\) times its outer radius. A maximal separated set within the respective covering ball needs at most \((1+4/\eta)^{d_i}\) points per layer. Hence with at most \((C_0/\eta)^{d_i}(1+\log j)\) points for absolute \(C_0\), the error of block \(i=\pi(j)\) is at most \(\eta\max\{\|w_i\|,b_j\}\). The codebook and tie rule are fixed before any observations. Every encoder emits only its index, on every possible input.

Set \(\eta=C_0 E_*\). In the branch \(\eta\le1\) the number of codewords is at most \(M_i\) in every block. The aggregate error obeys

\[
 \|z-w\|^2\le \eta^2\left(\|w\|^2+\sum_j b_j^2\right)
          \le \eta^2(S+2).
\]

Project globally and use (31), as for (32). Taking expectations and using \(\mathbb ES=\lambda\le1\) gives \(C(m^{-1/2}+E_*)\). For \(\eta>1\) or \(m=1\), use zero and enlarge the absolute constant. In all cases the output and target are in \([0,I]\), so error is at most one. Restoring the scale proves the upper half of (28).

### 8.4. The local relative-error lower bound

Let \(x=R\theta\in\mathbb R^p\) have uniform direction (two signs in dimension one) and independent radius with density proportional to \(r^{-3}\) on \([l,u]\), where \(0<l<u\). Weight this measure by \(R^2\) and divide by \(\mathbb ER^2\). In the resulting probability the log radius is uniform over an interval of length \(L=\log(u/l)\), and the Lebesgue density is \(1/(L|\mathbb S^{p-1}|\|x\|^p)\) on the shell. For any \(y\ne0\) and \(0<\delta\le1/3\), the event \(\|x-y\|\le\delta\|x\|\) implies

\[
 \|x\|\ge\|y\|/(1+\delta),qquad
 \|x-y\|\le\frac{\delta\|y\|}{1-\delta}.
\]

Bounding the density in this ball and using \(|\mathbb S^{p-1}|=p|\mathbb B_2^p|\) gives weighted probability at most \((2\delta)^p/(pL)\). For \(y=0\) the event is impossible. If the decoder uses at most \(M\) possible reconstructions with \(M(2\delta)^p\le pL/2\), the union bound leaves weighted probability at least one half on the relative-error complement. Equivalently,

\[
 \mathbb E[\|x\|\|\widehat x-x\|]
 \ge(\delta/2)\mathbb ER^2 .
\tag{34}
\]

The same argument applies conditional on any side information independent of \(x\). Energy weighting is the reason this prior forces a local code to resolve many log-radius scales.

### 8.5. The heterogeneous lower bound

Continue with \(\sigma=1\). Let \(t=\min\{1,E_*\}/2\), so \(0<t<E_*\). Order the products \(M_it^{d_i}\) nondecreasingly. If every position \(j\) met \(M_{\pi(j)}t^{d_{\pi(j)}}\ge1+\log j\), this permutation would give \(E_*\le t\). Therefore at least one prefix of size \(j\) has all its entries below \(1+\log j\). For \(j<16\), any block in this prefix has \(M_i^{-1/d_i}\ge t/(1+\log16)\), so (33) gives risk at least a constant times \(t\).

When \(j\ge16\), use one of those blocks as the anchor of norm \(1/2\) in its first coordinate. Use the other \(N=j-1\) blocks as independent unknown vectors \(x_i\) with the radial law of §8.4. The remaining blocks are zero. Set \(u=1/4\), \(l=u/\sqrt{N\log N}\), \(L=\frac12\log(N\log N)\) and \(\delta=t/32\). The radial normalization gives

\[
 \mathbb E R^2=\frac{2u^2 L}{N\log N-1},\qquad
 u^2 \le N\mathbb ER^2<0.13\quad(N\ge15).
\tag{35}
\]

For the lower inequality, use \(2L=\log N+\log\log N\ge\log N\); for the upper use \(\log\log N\le\log N\) and \(N\log N>40\). The prefix bound and \(d_i\ge1\) give \(M_i(2\delta)^{d_i}<(1+\log j)/16\le d_iL/2\) for each unknown block, as required in (34).

On the legal event \(G=\{\sum_i\|x_i\|^2\le1/2\}\), write \(v\) for the full vector including the anchor. With fair sample signs, the rank-one input law \(X=\varepsilon v\) has \(\|v\|^2\le3/4\), meets (1), and has covariance \(vv^{\mathsf T}\). The worst-case risk bounds the **unnormalized** prior integral of loss over \(G\). First reveal all independent signs and protocol seeds, and extract \(\widehat x_i\) from twice the estimated anchor column on each unknown block. The operator error dominates half of the Euclidean norm of the vector of reconstruction errors. On \(G\), Cauchy–Schwarz gives the further lower bound

\[
 \|\widehat\Sigma-vv^{\mathsf T}\|_{\rm op}
 \ge \tfrac12\Big(\sum_i\|\widehat x_i-x_i\|^2\Big)^{1/2}
 \ge \tfrac12\sum_i\|x_i\|\|\widehat x_i-x_i\|.
\tag{36}
\]

For each summand, condition on all \(x_k\) with \(k\ne i\), as well as on the signs and seeds. Restrict to the event \(\sum_{k\ne i}\|x_k\|^2\le1/4\), which has probability at least \(1-4(0.13)>0\) by (35) and Markov's inequality. On this event, every possible \(x_i\) yields a legal vector because \(u^2=1/16\). The \(i\)-th message alone can vary with \(x_i\), so for each such conditioning there are at most \(M_i\) reconstructions. The independent \(x_i\) still has the law in (34), and its contribution to (36) integrated on \(G\) is bounded below by a constant times \(\delta\mathbb ER^2\). This order of conditioning retains independence of the unknown block. Summing gives risk at least a constant times \(\delta N\mathbb ER^2\), hence at least a constant times \(t\). Combining with the one-direction sample lower bound and restoring \(\sigma\) proves (28).

For a simple check of the ordering in (27), \(K=3,d_i=1,M=(4,8,32)\) gives \(E_*=1/4\): the ascending alphabet order attains this value, and any order has a factor at least \(1/4\) from the smallest alphabet. For \(K=64,N=63\), (35) gives \(N\mathbb ER^2\) about \(0.0843\). Both are evaluations of the formulas; the risk bounds hold without numerics.

## 9. Scope and prior work on structural quantization

The shared direction, common sign and two-block exponent are the rank-one mechanism in §§8.1–8.2. The one-scale extension to multiple blocks yielded (32)–(33). Theorem 10 identifies the additional scale resolution that separate hard message limits impose when the number of blocks grows. The logarithmic factor reflects the logarithmic radial energies in (34)–(36). The proof permits unknown means and zero blocks. Exact rank at most one is essential to the local construction, so the theorem's distribution class excludes extra observation noise with support off the common line.

[RYA25, Remark 4.9] gives an exponential communication term for centralized covariance quantization. The centralized encoder can choose a single joint code, whereas (27) gives the separate budgets for arbitrary dimensions and admits zero-block degeneracy. [He20, §§2–4] uses a feature-distributed model to approximate an empirical kernel PCA subspace with one-shot communication. [Chi14] notes the immediate directional information in a rank-one sample and studies a different binary sensing experiment. [CF17] studies subspace learning from energy comparison bits. [DLR08] supplies the geometric rate context for Grassmann quantization. [TH26, §§2, 4, 7] treats two vertical blocks with entrywise sparsity, sub-Gaussian laws and Frobenius error. The new comparison concerns heterogeneous noninteractive hard messages and risk for the whole rank-one covariance, including magnitude. The high-dimensional codebook theorem gives finite deterministic nets and makes no claim of polynomial codebook construction.

## 10. Scope of the calculations

The general and rank-one proofs concern the same aligned noninteractive architecture and operator-norm loss. The unrestricted decoder in §5 involves an exponential directional net. The sub-Gaussian decoder in §6 uses matrix products and eigendecomposition. The reference encoding and simulation checks are described separately, including the limits of floating-point or small-dimensional demonstrations. The rank-one program checks a restricted two-scalar-block mechanism. Theorem 10 is proved for the full class by the analytic construction and lower bound in §8. [Reproduction and checks](evidence/README.md)

The historical formalization covers local framing and algebra. Remaining written claims from the Gaussian converse, robust estimation, rank-one factor and multiscale theory are part of full-paper Lean work. Historical coverage

## References

- **[RYA25]** M. R. Rahmani, M. H. Yassaee, M. R. Aref. *Fundamental Limits of Distributed Covariance Matrix Estimation via a Conditional Strong Data Processing Inequality*. arXiv:2507.16953v1 (2025). https://arxiv.org/abs/2507.16953
- **[RYMA24]** M. R. Rahmani, M. H. Yassaee, M. A. Maddah-Ali, M. R. Aref. *Fundamental Limits of Distributed Covariance Matrix Estimation Under Communication Constraints*. ICML, PMLR 235 (2024). https://proceedings.mlr.press/v235/rahmani24a.html
- **[CN25]** J. Chen, M. K. Ng. *A Parameter-Free Two-Bit Covariance Estimator with Improved Operator Norm Error Rate*. Applied and Computational Harmonic Analysis (2025); inspected arXiv:2308.16059v2. https://arxiv.org/abs/2308.16059
- **[CNW24]** J. Chen, M. K. Ng, D. Wang. *Quantizing Heavy-tailed Data in Statistical Estimation: (Near) Minimax Rates, Covariate Quantization, and Uniform Recovery*. IEEE Transactions on Information Theory 70(3) (2024); inspected arXiv:2212.14562v2. https://arxiv.org/abs/2212.14562
- **[DMR22]** S. Dirksen, J. Maly, H. Rauhut. *Covariance Estimation under One-Bit Quantization*. Annals of Statistics (2022). https://arxiv.org/abs/2104.01280
- **[DM24]** S. Dirksen, J. Maly. *Tuning-free One-bit Covariance Estimation Using Data-driven Dithering*. IEEE Transactions on Information Theory 70(7) (2024). https://arxiv.org/abs/2307.12613
- **[MZ20]** S. Mendelson, N. Zhivotovskiy. *Robust Covariance Estimation under \(L_4-L_2\) Norm Equivalence*. Annals of Statistics (2020); arXiv:1809.10462v2. https://arxiv.org/abs/1809.10462
- **[TH26]** J. Y. Tan, G. Han. *Information-Theoretic Bounds for Sparse Covariance Estimation in the Vertical-Split Distributed Model*. arXiv:2606.07124 (2026). https://arxiv.org/abs/2606.07124
- **[AC26]** P. Abdalla, J. Chen. *Robust Mean Estimation under Quantization*. arXiv:2601.07074 (2026). https://arxiv.org/abs/2601.07074
- **[SSRY22]** A. T. Suresh, Z. Sun, J. Ro, F. Yu. *Correlated Quantization for Distributed Mean Estimation and Optimization*. ICML, PMLR 162 (2022), Section 6.1. https://proceedings.mlr.press/v162/suresh22a.html
- **[He20]** F. He, K. Lv, J. Yang, X. Huang. *One-shot Distributed Algorithm for PCA with RBF Kernels*. [arXiv:2005.02664v3](https://arxiv.org/abs/2005.02664).
- **[Chi14]** Y. Chi. *One-Bit Principal Subspace Estimation*. GlobalSIP 2014. [Author-hosted PDF](https://users.ece.cmu.edu/~yuejiec/papers/1bitCov_GlobalSIP2014.pdf).
- **[CF17]** Y. Chi, H. Fu. *Subspace Learning From Bits*. IEEE Transactions on Signal Processing (2017). [arXiv:1407.6288v3](https://arxiv.org/abs/1407.6288).
- **[DLR08]** W. Dai, Y. Liu, B. Rider. *Quantization Bounds on Grassmann Manifolds and Applications to MIMO Communications*. IEEE Transactions on Information Theory (2008). [arXiv:cs/0603039v2](https://arxiv.org/abs/cs/0603039).
