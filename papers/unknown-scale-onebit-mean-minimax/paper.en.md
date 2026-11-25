# Sharp sample complexity of nonadaptive one-bit mean estimation with unknown scale

AI-assisted research manuscript

25 November 2026

# Abstract

We study one-dimensional mean estimation when each independent observation can send only one bit, every query is fixed before any response is seen, and the distribution has an unknown actual standard deviation in a known interval $[s,S]$. For known $0<s\le S\le\lambda$, relative accuracy $0<r\le1/64$, and failure probability $0<\delta\le1/16$, we prove that the minimax number of observations is, up to universal constants,

$$
\Phi(\lambda,s,S,r,\delta)
=\log(1+\lambda/s)
+r^{-2}\bigl[\log(S/s)+\log(1/r)\bigr]\log(1/\delta).
$$

The upper bound uses a coded coarse center, periodic digit queries decoded after that center is known, and a single dyadic refinement bank covering the entire possible scale range. An aggregate second-moment bound avoids paying a complete precision-estimation cost at every scale guess. The adaptation lower bound follows from a finite-scale information budget obtained by integrating binary entropy along Gaussian heat flow. Mirrored heavy-tail alternatives supply the precision lower bound with exactly equal variances, including the endpoint $S=s$. All queries in the construction are finite unions of intervals, although no constant interval budget or computational optimality is claimed.

This is an AI-assisted research manuscript . Its mathematical claims are written proofs, not a certificate of external peer review or global priority. Full-paper Lean verification is pending. The limited verified deterministic statements are documented separately and do not formalize this main theorem.

# 1. Model, question, and contribution

Let $\mathcal P(\lambda,s,S)$ be the class of probability distributions on $\mathbb R$ having finite second moment, mean $\mu(P)$ with $|\mu(P)|\le\lambda$, and actual standard deviation $\sigma(P)\in[s,S]$. The word *actual* matters: the target error is $r\sigma(P)$, not $rS$, and the lower endpoint is a constraint on the distribution rather than a label supplied to an estimator.

A nonadaptive protocol with $n$ agents has independent observations $X_1,\ldots,X_n\sim P$ and a distribution-independent random seed $U$. It fixes jointly measurable encoders $Q_i(U,\cdot):\mathbb R\to\{0,1\}$ before any responses are observed. Agent $i$ sends $Y_i=Q_i(U,X_i)$. The decoder uses $U,Y_1,\ldots,Y_n$ and may also be randomized. Independent private randomness can be incorporated into $U$ for lower bounds; revealing it only enlarges the transcript. The estimator must satisfy

$$
\sup_{P\in\mathcal P(\lambda,s,S)}
\Pr_P\{ |\widehat\mu-\mu(P)|>r\sigma(P)\}\le\delta. \tag{1.1}
$$

Define $N^*(\lambda,s,S,r,\delta)$ as the minimum such deterministic integer $n$. The sample count is fixed in advance; random stopping is not included. The encoders may be different and share randomness. We count uplink sample messages only. Query descriptions, shared randomness, real-number precision, and computation are not charged. This is the same unrestricted measurable-query style of communication model used in the closest known-scale work [2].

## 1.1 Main result

**Theorem 1 (sharp unknown-scale complexity).** There are numerical constants $0<c<C<\infty$, independent of all problem parameters, such that for every

$$
0<s\le S\le\lambda,\qquad 0<r\le1/64,\qquad 0<\delta\le1/16,
$$

$$
c\Phi(\lambda,s,S,r,\delta)
\le N^*(\lambda,s,S,r,\delta)
\le C\Phi(\lambda,s,S,r,\delta). \tag{1.2}
$$

The upper-bound encoders have one-sets that are finite unions of intervals, with half-lines allowed after clipping. The lower bound holds for arbitrary jointly measurable binary encoders and arbitrary distribution-independent shared randomness. The theorem includes $S=s$ and $S=\lambda$.

The initially reserved target was (1.2) at $\delta=1/16$. The full confidence dependence is a proved extension of that same target, not a replacement of its model or accuracy criterion.

The three terms have distinct roles. $\log(1+\lambda/s)$ pays for global location. $r^{-2}\log(1/r)\log(1/\delta)$ is the finite-variance one-bit precision cost, already present with a known scale. The new sharp adaptation component is $r^{-2}\log(S/s)\log(1/\delta)$. The dependence is additive in the two scale logarithms, rather than multiplying a full known-scale estimator by the number of scale guesses.

## 1.2 Attribution and scope of novelty

Lau and Scarlett [1, Theorem 15] already give an unknown-actual-scale, relative-error construction by a geometric scale grid. Their later work [2] gives optimal fully nonadaptive mean estimation with a known moment scale. Random cell banks, signed isolation, decoder-side filtering, coding localization, and multiscale estimation are strong existing ingredients. Appendix B explicitly adapts those mechanisms rather than claiming their invention.

Cai and Wei [3] already investigate the communication cost of Gaussian variance adaptation and integrate Hellinger quantities across locations and scales. The present finite-displacement entropy budget should be read against that close predecessor. Their published theorem has a different communication/MSE efficiency objective and does not directly state (1.2). Kumar and Vatedka [4] include both location-scale asymptotic results and a nonparametric multiple-threshold extension with additional regularity assumptions; their work must not be described as exclusively parametric.

The candidate original increment is the complete matching rate (1.2) in the stated model, together with the uniform scale-sharing upper analysis and the finite-scale entropy argument establishing its necessity. The exact-variance mirrored construction is a repair of the lower-bound family in [1], not an unrelated invention. We do not claim to resolve the already-solved known-scale noninteraction question. The literature comparison is limited; full texts of [5,6] were unavailable.

A further close author manuscript, Dewasurendra [8], uses a prequeried modulo dictionary and a dyadic tail-moment budget to attain the known-scale rate. Periodic encoding and an aggregate tail budget are therefore not independent novelty claims here. Its displayed base period is chosen using the known scale; the exact unknown-actual-scale interval theorem (1.2) and its matching adaptation lower bound are the distinction investigated in this manuscript.

# 2. Proof of the upper bound

All three batches below are fixed in advance and mutually independent. There is an order to decoding, but no response determines any query.

First, apply the localization construction of Appendix A with failure budget $\delta/2$. It returns $c\in[-\lambda,\lambda]$ satisfying

$$
\Pr\{|c-\mu|>32\sigma\}\le\delta/2
$$

using

$$
n_{\rm loc}=O\!\left(\log(1+\lambda/S)
+[1+\log(S/s)]\log(4/\delta)\right). \tag{2.1}
$$

For clarity, explicit valid parameters are as follows. Put $C_0=9/2$, $w=3S$, $N=\lceil2\lambda/w\rceil$, and

$$
n_c=\left\lceil\frac{5832}{25}\log\frac{4(N+1)}\delta\right\rceil,
\qquad L_c=\left\lceil\log_2\frac{256(C_0+1)S}{s}\right\rceil.
$$

Let $b_c$ be the smallest positive odd integer at least $4\log(4/\delta)$. Appendix A uses exactly $n_c+b_cL_c$ observations. The first batch locates within $C_0S$; the periodic blocks then adapt to the actual $\sigma$ without knowing it.

Second, set $K=1+32^2=1025$, $A=2304$, and

$$
n_0=\lceil128AK/r^2\rceil,\quad
m=\lceil\log_2(4KS/(rs))\rceil,
\quad B=\text{smallest odd integer at least }8\log(2/\delta).
$$

The fixed refinement bank of Appendix B uses exactly $2(m+1)n_0B$ additional observations. For every deterministic center obeying $|c-\mu|\le32\sigma$, each independent block has error probability at most $7/108<1/8$ at radius $r\sigma$. Conditional median amplification makes the refinement failure at most $\delta/2$. Independence of its samples and seeds from the localization transcript permits conditioning on the realized center without selection bias.

Adding the localization failure proves (1.1). The total sample count is

$$
O\!\left(\log(1+\lambda/S)
+[1+\log(S/s)]\log(4/\delta)
+r^{-2}[1+\log(S/s)+\log(1/r)]\log(2/\delta)\right).
$$

In the stated parameter range, $\log(1/r)\ge\log64$ absorbs the additive ones, $\log(2/\delta)$ and $\log(4/\delta)$ are constant multiples of $\log(1/\delta)$, and $s\le S$. This proves the upper half of (1.2). The constants above favor transparent verification over numerical performance; the theorem is an order result, not a claim that these conservative constants are deployable sample sizes.

# 3. Proof of the lower bound

Three valid subfamilies force the three components. The bounds are combined by taking a maximum, which is at least one third of their sum. No single distribution is required to witness every component simultaneously.

**Location.** Appendix C.5 constructs a finite family with actual variance exactly $s^2$, separated means, and a one-bit Fano bound. For the range of Theorem 1 it implies

$$
n\ge\tfrac34\log_2(\lambda/s)+\tfrac12
\ge\frac{\log(1+\lambda/s)}{2\log2}. \tag{3.1}
$$

**Precision at an exactly fixed variance.** Appendix C constructs mirrored heavy-tail alternatives with means $\pm2rs$, actual variance exactly $s^2$, and a per-bit KL divergence at most $128r^2/M$, where $M\ge\tfrac14\log_2(1/r)$. Testing data processing gives, for $\delta\le1/4$,

$$
\frac{128nr^2}{M}
\ge (1-2\delta)\log\frac{1-\delta}{\delta}
\ge\tfrac14\log(1/\delta).
$$

Thus

$$
n\ge\frac{\log(1/r)\log(1/\delta)}{2048r^2\log2}. \tag{3.2}
$$

Both (3.1) and (3.2) even hold for adaptive queries. That fact is not used to broaden the adaptation theorem.

**Unknown scale.** Restrict to $N(\mu,\sigma^2)$ with $|\mu|\le\lambda$ and $s\le\sigma\le S$. Appendix D proves, for arbitrary nonadaptive binary channels,

$$
n\ge\frac{\log(S/s)\log(1/(2\sqrt\delta))}{32r^2\log2}
\ge\frac{\log(S/s)\log(1/\delta)}{128r^2\log2}. \tag{3.3}
$$

The argument integrates a budget for each fixed channel; it remains valid with shared randomness by using the affinity of the seed-enlarged joint transcript. It does not assume success for every fixed seed, and it is not an asymptotic Fisher-information lower bound.

Equations (3.1)--(3.3) prove the lower half of (1.2), for example with $c=1/(6144\log2)$. When $S=s$, (3.3) vanishes and (3.1)--(3.2) still give the complete rate. This is why the exact-variance detail cannot be omitted.

# 4. Consequences and limitations

**Corollary 2 (no scale floor).** Fix $\lambda\ge S>0$, $0<r\le1/64$, and $0<\delta\le1/16$. No one finite fixed-sample nonadaptive protocol can satisfy (1.1) simultaneously for every distribution with $|\mu|\le\lambda$ and $0<\sigma\le S$.

**Proof.** Such a protocol would satisfy (3.3) for every $s>0$. Its finite $n$ would dominate a positive constant times $\log(S/s)$ as $s\downarrow0$, a contradiction. This assertion does not exclude distribution-dependent finite stopping times. $\square$

The same no-floor impossibility also follows from the elementary location packing bound as $s\downarrow0$, even for adaptive protocols. Corollary 2 is a boundary interpretation, not a separately claimed original phenomenon.

The result concerns one dimension, finite variance, a known relative accuracy, a known bounded mean interval, a positive known scale interval, unrestricted measurable binary queries, and a deterministic sample budget. It does not determine the optimum with a prescribed interval-component budget, adaptive queries, unknown target accuracy, multiple observations per agent, multiple bits per observation, or higher dimensions. No oracle supplies the actual scale. No support bound or density assumption is imposed.

The full written proof consists of the synthesis above and Appendices A--D below. Universal probability and analysis statements are justified analytically. Exact finite checks are error detectors for selected cases only. Formalized geometric and algebraic dependencies, their explicit assumptions, and their transitive axiom audit are listed separately; the main minimax theorem and the full probability model are not yet Lean-verified.

The appendices use local symbols for the number of periodic digits, the terminal refinement level, and the heavy-tail support length. These symbols are scoped to their own appendix; none is a data-dependent sample count.

# Appendix A. High-confidence localization

This construction develops existing coding/digit localization ideas [1,2,7] into a uniform actual-scale guarantee with additive global-location cost. The coding ingredient itself is not claimed as novel.

## A.1 Statement

Let $0<s\leq S$, $\lambda>0$, and $0<\delta<1$ be known. Let $X$ have mean $\mu\in[-\lambda,\lambda]$ and actual standard deviation $\sigma\in[s,S]$. There is a fully noninteractive protocol, with one fresh sample and one binary message per agent, whose output $C$ satisfies

$$
\Pr\{|C-\mu|>32\sigma\}\leq\delta,
$$

using

$$
O\!\left(
\log(1+\lambda/S)
+[1+\log(S/s)]\log(2/\delta)
\right) \tag{A.1}
$$

messages. All query functions are chosen before any responses are observed, and every query has a one-set that is a finite union of intervals. The number of interval components is not asserted to be bounded by a constant.

The global-location term in (A.1) is additive. Decoding uses a coarse center obtained from a separate query batch, but encoding does not use that center.

Throughout, $\pi(x)=\max\{-\lambda,\min\{x,\lambda\}\}$. Since $\mu\in[-\lambda,\lambda]$,

$$
|\pi(x)-\mu|\leq|x-\mu|. \tag{A.2}
$$

Clipping can change the mean; none of the proofs assumes otherwise.

## A.2 A self-contained known-upper-scale coarse localizer

This is an elementary randomized-code version of the known coding localizer. It gives a convenient constant $C_0=9/2$ under a variance assumption.

### A.2.1 Queries and decoder

Put

$$
w=3S,\qquad N=\left\lceil\frac{2\lambda}{w}\right\rceil\geq1,
$$

and define the clipped bin index

$$
b(x)=\min\!\left\{N-1,
\left\lfloor\frac{\pi(x)+\lambda}{w}\right\rfloor\right\}
\in\{0,\ldots,N-1\}.
$$

The last bin contains the endpoint $\lambda$. Let its candidate centers, including a potentially short last bin, be

$$
c_j=\pi\bigl(-\lambda+(j+\tfrac12)w\bigr).
$$

For each query $t=1,\ldots,n_0$, draw a public row of independent fair bits

$$
W_{t,0},\ldots,W_{t,N-1}.
$$

All rows and all sample observations are mutually independent. The query and response are

$$
Q_t(x)=W_{t,b(x)},\qquad Y_t=Q_t(X_t).
$$

After collecting the responses, compute for every candidate bin

$$
H_j=\frac1{n_0}\sum_{t=1}^{n_0}
\mathbf1\{Y_t\ne W_{t,j}\},
$$

choose an index $\widehat j$ minimizing $H_j$, with any fixed deterministic tie rule, and output $c_0=c_{\widehat j}$.

The random code matrix may be generated in full before any sample is seen. No existence theorem or search for a deterministic codebook is needed.

### A.2.2 Population score gap

Let $i=b(\mu)$ and

$$
\mathcal S=\{i-1,i,i+1\}\cap\{0,\ldots,N-1\}.
$$

If $b(X)\notin\mathcal S$, then $|\pi(X)-\mu|\geq w$. This remains true for the last-bin convention and for means at endpoints. By (2) and the variance bound,

$$
\Pr\{b(X)\notin\mathcal S\}\leq\frac{S^2}{w^2}=\frac19. \tag{A.3}
$$

Writing $p_j=\Pr\{b(X)=j\}$, some anchor $j_*\in\mathcal S$ has

$$
p_{j_*}\geq\frac{8}{27}.
$$

For every fixed candidate $j$, a generic disagreement indicator has expectation exactly

$$
\mathbb E\mathbf1\{Y_t\ne W_{t,j}\}
=\frac{1-p_j}{2}. \tag{A.4}
$$

Indeed, it vanishes if the observed bin equals $j$; otherwise the two involved code bits are independent and fair. For a fixed $j$, these indicators are independent across $t$, because the code rows and samples are independent across $t$.

Consequently, the anchor has population score at most $19/54$, while every $j\notin\mathcal S$ has score at least $4/9=24/54$, since its mass is at most $1/9$.

### A.2.3 Concentration and sample count

Use the separating threshold

$$
\theta=\frac{43}{108}.
$$

It is at distance $5/108$ from the preceding two score bounds. One-sided Hoeffding inequalities therefore give

$$
\Pr\{H_{j_*}\geq\theta\}
\leq\exp\!\left(-\frac{25n_0}{5832}\right),
$$

and, for each $j\notin\mathcal S$,

$$
\Pr\{H_j\leq\theta\}
\leq\exp\!\left(-\frac{25n_0}{5832}\right).
$$

Taking

$$
n_0=\left\lceil\frac{5832}{25}
\log\frac{N+1}{\delta_0}\right\rceil \tag{A.5}
$$

makes the union of these bad events have probability at most $\delta_0$. Off that union, every minimizer belongs to $\mathcal S$. The center of the true bin or either adjacent bin is within $3w/2$ of $\mu$; projecting the center can only help. Thus

$$
\Pr\{|c_0-\mu|>C_0S\}\leq\delta_0,
\qquad C_0=\frac92. \tag{A.6}
$$

Its cost is

$$
n_0=O\!\left(\log(1+\lambda/S)+\log(1/\delta_0)\right).
$$

If desired, when $\lambda\leq C_0S$, one may instead take $c_0=0$ deterministically with zero messages. This shortcut is optional and does not affect the subsequent argument.

## A.3 Periodic binary-digit queries prepared before the coarse center is known

Let

$$
L=\left\lceil\log_2\frac{256(C_0+1)S}{s}\right\rceil,
\quad M=2^L,
\quad D=Ms,
\quad \ell_j=2^js\quad(0\leq j<L).
$$

Thus $D\geq256(C_0+1)S$. All these quantities are known in advance.

### A.3.1 Integer conventions, including negative values

For an integer $z$, its residue modulo $M$ means the Euclidean residue

$$
[z]_M=z-M\lfloor z/M\rfloor\in\{0,\ldots,M-1\}.
$$

For such a nonnegative residue, write $b_j(z)=\lfloor z/2^j\rfloor\bmod2$. These conventions remove any dependence on a programming language's treatment of negative remainders.

### A.3.2 One block of queries

Draw $U\sim\operatorname{Unif}[0,D)$, independently of the entire coarse-localization batch and of this block's fresh samples. Agent $j$, for $j=0,\ldots,L-1$, sends

$$
B_j=b_j\!\left(
\left[\left\lfloor\frac{\pi(X_j)+U}{s}\right\rfloor\right]_M
\right).
$$

After collecting the bits, set

$$
V=\sum_{j=0}^{L-1}2^jB_j,
\qquad a=sV-U.
$$

The decoder, once it has decoded $c_0$, chooses the member of $a+D\mathbb Z$ closest to $c_0$. An explicit deterministic version is

$$
\widehat k=\left\lfloor\frac{c_0-a}{D}+\frac12\right\rfloor,
\qquad C_U=\pi(a+D\widehat k). \tag{A.7}
$$

Only (7), a computation at the learner after all messages arrive, uses $c_0$. The agents never need to know it.

## A.4 A one-block guarantee conditional on a successful coarse center

### A.4.1 Digit mismatch bounds on the circle

Let

$$
z_\mu=\left[\left\lfloor\frac{\mu+U}{s}\right\rfloor\right]_M.
$$

For each $j<L$, the relevant square wave has period $2\ell_j$, which divides $D$. Its change under a translation by $d$ occupies a fraction at most $\min\{1,|d|/\ell_j\}$ of a full period. This applies equally to positive and negative inputs. Averaging over the full-period shift and using (A.2) gives

$$
\Pr\{B_j\ne b_j(z_\mu)\}
\leq\frac{\mathbb E|\pi(X)-\mu|}{\ell_j}
\leq\frac{\sigma}{\ell_j}. \tag{A.8}
$$

In contrast to the nonperiodic construction, every reported bit here has a complete period dividing $D$; there is no special top-bit case.

### A.4.2 High-bit agreement produces a nearby lift

Let $q$ be the least index with $\ell_q\geq16\sigma$. Such an index exists among $0,\ldots,L-1$, because

$$
\ell_{L-1}=D/2\geq128(C_0+1)S\geq16\sigma.
$$

As $\sigma\geq s$, minimality gives $\ell_q<32\sigma$. The union bound in (A.8) yields

$$
\Pr\{\text{some bit }j\geq q\text{ is wrong}\}
\leq\sum_{j=q}^{L-1}\frac\sigma{\ell_j}
\leq\frac{2\sigma}{\ell_q}\leq\frac18. \tag{A.9}
$$

Suppose those high bits agree. Then $|V-z_\mu|\leq2^q-1$. Write

$$
\left\lfloor\frac{\mu+U}{s}\right\rfloor=z_\mu+kM
$$

for the appropriate integer $k$, which can be negative, and let

$$
f=\mu+U-s(z_\mu+kM)\in[0,s).
$$

The lift $a+kD$ then satisfies

$$
a+kD-\mu=s(V-z_\mu)-f,
\qquad |a+kD-\mu|<\ell_q<32\sigma. \tag{A.10}
$$

This is an existence statement about a particular lift, not merely an informal assertion that a circular distance is small.

### A.4.3 Nearest-lift decoding selects that lift

On the coarse success event

$$
G_0=\{|c_0-\mu|\leq C_0S\},
$$

the lift in (A.10) obeys

$$
|a+kD-c_0|<(C_0+32)S<D/2. \tag{A.11}
$$

The last inequality follows from $D/2\geq128(C_0+1)S$. Other lifts differ by a nonzero integer multiple of $D$, so (11) makes the nearby lift the unique nearest lift to $c_0$. Thus the deterministic tie convention in (A.7) is irrelevant on this event. After clipping,

$$
|C_U-\mu|<32\sigma.
$$

The entire periodic block is independent of the coarse batch. Therefore, for every fixed value of $c_0$ in $G_0$,

$$
\Pr\{|C_U-\mu|>32\sigma\mid c_0\}\leq\frac18. \tag{A.12}
$$

This conditional formulation is what permits confidence amplification after sharing one coarse-localization result across all subsequent blocks.

## A.5 Independent repetition and complete query count

Prepare an odd number $m$ of independent periodic blocks, each with its own shift and fresh samples, all independent of the coarse batch. Decode their nearest lifts using the common $c_0$, and let $C$ be the median of the resulting clipped centers.

Conditional on each successful coarse center, the block outputs are independent and each fails at radius $32\sigma$ with probability at most $1/8$. Hoeffding therefore gives

$$
\Pr\{|C-\mu|>32\sigma\mid c_0\}\leq e^{-9m/32}
\quad(c_0\in G_0). \tag{A.13}
$$

Take

$$
\delta_0=\delta/2,
\qquad
m=\text{smallest odd integer at least }4\log(2/\delta).
$$

Then (6) and (A.13) imply

$$
\Pr\{|C-\mu|>32\sigma\}\leq\delta/2+\delta/2=\delta.
$$

The total number of one-bit observations is exactly $n_0+mL$, with $n_0$ as in (A.5). Since

$$
L=O(1+\log(S/s)),
$$

this proves (1).

## A.6 Endpoint, wrap, and noninteraction audit

- Negative values are handled by floor followed by Euclidean residue. No truncation-toward-zero operation is used.
- The support of $X$ may be unbounded. Clipping creates valid binary queries with finitely many interval components; all bounds concern distance to the original mean.
- For each fixed sample or mean, random shifts landing exactly on a digit boundary form a null set. The half-open shift interval $[0,D)$ and the explicit floor conventions define the queries even on those events.
- The high-bit argument does not assume independent bit errors within a block; it uses only a union bound.
- A modulo representation can cross zero or the edge of $[0,D)$. Equation (A.10) explicitly carries the appropriate integer multiple of $D$, so no wrap case is omitted.
- The selected lift is unique on the joint success event, because its distance to $c_0$ is strictly below $D/2$. On failure events the tie rule still defines an output.
- Coarse queries, all periodic queries, their public randomness, and their sample allocation are fixed in advance. Decoding the coarse center first does not introduce query-side adaptivity.
- The guarantee averages over public randomness, as does the stated randomized-protocol model. No guarantee is asserted for every fixed realization of the public code matrix.

# Appendix B. A uniform dyadic refinement bank

The random cell banks, Rademacher isolation, stochastic quantization, dyadic cover, and decoder-side filtering adapt [2, Sections 2.4--2.6 and Appendix B]. The change proved here is one bank spanning every possible actual scale, with a single aggregate second-moment budget. The localization interface means a measurable $C\in[-\lambda,\lambda]$ with $\Pr(|C-\mu|\le C_0\sigma)\ge1-\delta/2$, whose entire sample and random-seed transcript is independent of all refinement samples and seeds. Only decoding may use its realized value.

## B.1 Parameters and theorem

Let X have finite mean mu and actual standard deviation sigma. Assume known numbers

$$
|\mu|\le\lambda,\qquad 0<a\le\sigma\le b,\qquad 0<r<1,\qquad 0<\delta<1/2.
$$

Write R=b/a. There is no requirement that lambda >= b. Suppose the independent localization interface holds with an absolute C0 >= 0. Define

$$
K=1+C_0^2\ge1,\qquad A=2304,\qquad
n_0=\left\lceil128AK/r^2\right\rceil.
$$

Set ell_i=2^i a for i=0,1,...,m, where m is the least nonnegative integer such that

$$
L:=\ell_m\ge T_0:=4Kb/r.
$$

Let B be the least positive odd integer with B >= 8 log(2/delta), where log is natural. The refinement protocol below uses exactly

$$
n_{\mathrm{ref}}=2(m+1)n_0B
$$

fresh samples and returns an estimator with total failure probability at most delta after including the localization failure. Every individual sample answers exactly one binary query. Every query is a finite union of O(1+lambda/a) bounded intervals. Queries, random seeds, and sample counts are fixed before observing any bit.

Since C0 is absolute, the sample count is

$$
O\!\left(r^{-2}[1+\log R+\log(1/r)]\log(2/\delta)\right).
$$

The starting scale is a, not ra. No fine-scale approximation error is incurred, because the smallest cells are estimated rather than discarded.

### Existence of m and exact layer count

Because a>0 and 2^m is unbounded, m exists. Since b>=a, K>=1, and r<1, T0>4a, so m>0. Minimality gives ell_(m-1)<T0 and consequently

$$
4Kb/r\le L<8Kb/r,
\qquad
m=\left\lceil\log_2(4KR/r)\right\rceil,
\qquad
m+1\le2+\log_2(4KR/r).
$$

These are counts of queried dyadic levels; no data-dependent stopping rule is used.

## B.2 Fixed grids and query banks

For each i define the full half-open grid

$$
\mathcal D_i=\{[j\ell_i,(j+1)\ell_i):j\in\mathbb Z\}
$$

and the finite bank

$$
\mathcal B_i=\{J\in\mathcal D_i:
J\cap[-\lambda-3\ell_i,\lambda+3\ell_i]\ne\varnothing\}.
$$

A closed interval of length 2lambda+6ell_i meets at most (2lambda/ell_i)+8 half-open grid cells. Thus

$$
|\mathcal B_i|\le 2\lambda/\ell_i+8
\le2\lambda/a+8.
$$

Rounding this harmless real upper bound upward gives an integer interval budget if one is desired. Banks do not presume bounded support of X; outside-bank samples simply return zero to that particular query.

For each block h=1,...,B, level i=0,...,m, repetition t=1,...,n0, and orientation d in {left,right}, allocate a separate sample X_(h,i,t,d). Generate one relative split zeta_(h,i,t,d), uniform on [0,1], and independent fair signs eta_(h,i,t,d,J) in {-1,+1} for all J in B_i. All signs are independent of all split variables; different (h,i,t,d) use independent seeds and samples. The single split may be shared across cells of the same query.

For J=[u_J,v_J), put s_J=u_J+zeta ell_i and

$$
A_J^{\mathrm L}=[u_J,s_J),\qquad
A_J^{\mathrm R}=[s_J,v_J).
$$

The query and answer are

$$
Q^d(x)=\mathbf1\!\left\{x\in
\bigcup_{J\in\mathcal B_i:\,\eta_J^d=1}A_J^d\right\},
\qquad Y^d=Q^d(X^d).
$$

The learner knows all query seeds. No query depends on C, on mu, on sigma, or on any response.

## B.3 Decoder-selected cover and its geometry

Fix any deterministic c in [-lambda,lambda]. Let I=[c-L,c+L]. A dyadic cell J is called admissible when

$$
\operatorname{len}(J)\le\operatorname{dist}(c,J),
\qquad\operatorname{dist}(c,J)=\inf_{x\in J}|x-c|.
$$

Consider every finest cell B0 in D_0 that intersects I. If B0 is not admissible, select B0 itself. If B0 is admissible, select its coarsest admissible dyadic ancestor. Remove duplicate selections to obtain W(c,L); let W_i(c,L) denote the selected cells of length ell_i.

### B.3.1 The ancestor search terminates by level m

The dyadic ancestor of a grid cell is uniquely determined by the fixed grids. Every ancestor of B0 contains a point of B0 intersect I. Thus it has distance at most L from c. An admissible ancestor consequently has length at most L=ell_m. Only levels 0,...,m can be admissible. The initial admissible B0 is one candidate, so the finite set of admissible ancestors has a coarsest member.

Once an ancestor is inadmissible, every larger ancestor is inadmissible: distance to c can only decrease under inclusion, while length strictly increases. Therefore the selected admissible cell always has an inadmissible parent. Its parent may lie at level m+1, but the parent is used only to check a deterministic geometric condition and is never queried.

### B.3.2 Coverage and disjointness

Every point of I belongs to its unique half-open finest grid cell; that cell intersects I and is contained in its selected ancestor. Hence I is contained in U(c,L), the union of all selected cells.

Two dyadic cells are either disjoint or one contains the other. A selected finest inadmissible cell cannot be contained in any admissible ancestor, by the monotonicity observation above. If two distinct selected admissible cells were nested, the smaller one would not be the coarsest admissible ancestor of the finest cell that generated it. Distinct selected cells are therefore disjoint.

### B.3.3 Distance and endpoint bounds

For an admissible selected cell J of length ell_i, its parent P has length 2ell_i and dist(c,P)<2ell_i. A child can be at most ell_i farther from c than its parent, so

$$
\ell_i\le\operatorname{dist}(c,J)<3\ell_i.
$$

In particular each endpoint of J has absolute distance less than 4ell_i from c. For a selected finest inadmissible cell, dist(c,J)<a and each endpoint has distance less than 2a. Thus the uniform 4ell_i endpoint bound holds for every selected cell, and the positive lower-distance bound holds at all i>=1.

Each selected J intersects the open interval (c-3ell_i,c+3ell_i). Since c lies in [-lambda,lambda], this implies J belongs to B_i. This proves that all decoder-selected cells were included in the prequeried finite banks.

### B.3.4 At most nine cover cells per level

Every selected level-i cell is contained in (c-4ell_i,c+4ell_i). A window of length 8ell_i meets at most nine half-open grid cells of length ell_i. Therefore |W_i(c,L)|<=9. This deliberately loose constant also covers all endpoint alignments; no generic-position assumption on c is used.

An implementation can enumerate the constant number of nearby grid cells at each level and test admissibility, parent inadmissibility, and intersection with I. It need not literally enumerate all finest cells across the full truncation interval. Computational complexity optimization is not needed for the sample bound.

## B.4 Filter cells and measurability

Let F_0(c) be empty and, for i>=1, let

$$
\mathcal F_i(c)=\{J\in\mathcal B_i:
\operatorname{dist}(c,J)<\ell_i\}.
$$

A grid cell has distance less than ell_i precisely when it intersects the open interval (c-ell_i,c+ell_i). This length-2ell_i open interval intersects at most three half-open grid cells. More explicitly, writing J=[jell_i,(j+1)ell_i), its index satisfies

$$
c/\ell_i-2<j<c/\ell_i+1,
$$

an open interval of length three, which contains at most three integers. Thus |F_i(c)|<=3. When c is a grid endpoint there are only two such cells; cells whose distance is exactly ell_i are not filtered.

Cover cells and filter cells are disjoint at each level i>=1 by admissibility. This remains true at level zero because F_0 is empty. All set-selection decisions are finite Boolean combinations of Borel inequalities in c and fixed grid endpoints, so the decoder is measurable. No simultaneous probabilistic guarantee over a continuum of centers is needed.

For each query define

$$
H_i^d(c)=\mathbf1\{\eta_J^d=-1\text{ for every }J\in\mathcal F_i(c)\},
\qquad p_i(c)=2^{-|\mathcal F_i(c)|}\ge1/8.
$$

At level zero H=p=1. Define endpoint weights w_J^L=u_J-c, w_J^R=v_J-c, and decode

$$
V_i^d(c)=\frac{2H_i^d(c)Y_i^d}{p_i(c)}
\sum_{J\in\mathcal W_i(c,L)}w_J^d\eta_J^d.
\tag{B.D}
$$

Here and below block and repetition indices are suppressed when immaterial. The filtering event is checked only during decoding. It does not change query selection or cause more samples to be drawn.

## B.5 First-moment identity, including atoms

Condition on a fixed sample value x and relative split zeta. The candidate subintervals are contained in disjoint grid cells, so at most one candidate subinterval contains x. If none does, Y=0. If its cell J_* belongs to F_i, the event H=1 forces eta_(J_*)=-1, making HY=0. Since W_i and F_i are disjoint, the desired cover contribution is also zero in this case.

Otherwise J_* is outside F_i and

$$
Y=(1+\eta_{J_*})/2.
$$

The filter signs are independent of the signs of J_* and all cover cells. Therefore, for each J in W_i,

$$
\mathbb E_\eta\left[\frac{2H}{p}Y\eta_J\,\middle|\,x,\zeta\right]
=\mathbb E_\eta[(1+\eta_{J_*})\eta_J]
=\mathbf1_{\{J_*=J\}}.
$$

It follows that

$$
\mathbb E_\eta[V_i^d(c)\mid x,\zeta]
=\sum_{J\in\mathcal W_i}w_J^d\mathbf1_{\{x\in A_J^d\}}.
$$

For J=[u,v), uniform splitting gives, for x in J,

$$
\Pr(x\in A_J^L)=(v-x)/(v-u),\qquad
\Pr(x\in A_J^R)=(x-u)/(v-u).
$$

Consequently

$$
(u-c)\Pr(x\in A_J^L)+(v-c)\Pr(x\in A_J^R)=x-c.
$$

For x outside J both indicators vanish. Thus

$$
\mathbb E[V_i^L(c)+V_i^R(c)]
=\sum_{J\in\mathcal W_i(c,L)}
\mathbb E[(X-c)\mathbf1_{\{X\in J\}}].
\tag{B.M}
$$

### Endpoint audit

1. If X equals a grid left endpoint u, the left indicator has probability one and the right probability zero; the identity returns u-c.
2. A grid right endpoint v is not in [u,v); it belongs uniquely to the next cell. No atom is counted twice or omitted by the grid partition.
3. The values zeta=0 and zeta=1 have probability zero. Empty candidate intervals at these splits cause no change to any expectation, including for atoms at grid endpoints.
4. If X equals a nonboundary random split, the right interval contains it and the left interval does not. The event has zero split-probability for every fixed interior x, but the convention is defined regardless.
5. Both endpoints c-L and c+L belong to the closed truncation window. Their respective unique finest cells are included in the initial list, so the coverage argument includes their atoms.
6. Cells at distance exactly ell_i are admissible and unfiltered. The nonzero-support implication uses |X-c|>=ell_i, so equality is included correctly.

No density, symmetry, continuity, support bound, or absence of atoms is assumed.

## B.6 Tail-local second moment, with A=2304

Write S=sum_(J in W_i) w_J eta_J. If the sample lies in a candidate cell J_* outside F_i, then independence of the filter signs gives

$$
\mathbb E_\eta[(V_i^d)^2\mid x,\zeta]
=\frac4{p_i}\,
\mathbb E_\eta\left[S^2\frac{1+\eta_{J_*}}2\right]
=\frac2{p_i}\sum_{J\in\mathcal W_i}(w_J^d)^2.
$$

The second equality holds whether J_* is a cover cell or not: every term in E[S^2 eta_(J_*)] has an odd independent sign and hence vanishes. The ordinary second moment E[S^2] is the sum of the squared weights. If the sample is outside all candidates, or its candidate belongs to F_i, the second moment is zero.

For i>=1, V_i^d nonzero implies H_i^dY_i^d=1. The sample's cell is then a bank cell outside F_i, so |X-c|>=ell_i. As p_i>=1/8, |W_i|<=9 and |w_J|<4ell_i,

$$
\operatorname{Var}(V_i^d)
\le\mathbb E[(V_i^d)^2]
\le A\ell_i^2\tau_i(c),\qquad A=16\cdot9\cdot16=2304,
\tag{B.V}
$$

where tau_0(c)=1 and tau_i(c)=P(|X-c|>=ell_i) for i>=1. The smallest level has p_0=1 and an even smaller bound, so the displayed A works uniformly.

## B.7 The pointwise geometric tail sum

For every real z and every finite terminal level m,

$$
\sum_{i=1}^{m}\ell_i^2\mathbf1_{\{|z|\ge\ell_i\}}
\le\frac43z^2.
\tag{B.G}
$$

If no scale is below |z| the left side is zero. Otherwise let j be the largest included index. Increasing dyadic scales imply the included indices form an initial segment. A geometric sum gives

$$
\sum_{i=1}^{j}\ell_i^2
\le\ell_j^2\sum_{h=0}^{\infty}4^{-h}
=\frac43\ell_j^2
\le\frac43z^2.
$$

Equivalently one can prove the finite bound by induction without any infinite-series result. Taking expectation in this finite nonnegative sum gives

$$
\sum_{i=1}^{m}\ell_i^2P(|X-c|\ge\ell_i)
\le\frac43\mathbb E(X-c)^2.
\tag{B.T}
$$

This is the step that prevents a second factor of the number of scales. Replacing each individual tail probability by the Markov bound and then summing would lose this information and give an unnecessarily larger rate.

## B.8 Truncation bias

Condition on successful localization and its realized c. Independence of the refinement batch gives

$$
M_2(c):=\mathbb E(X-c)^2
=\sigma^2+(\mu-c)^2\le K\sigma^2.
$$

The disjoint cover contains [c-L,c+L]. Hence

$$
\begin{aligned}
\left|\mathbb E[(X-c)\mathbf1_{U(c,L)}]-(\mu-c)\right|
&\le\mathbb E[|X-c|\mathbf1_{\{|X-c|>L\}}]\\
&\le M_2(c)/L\\
&\le r\sigma^2/(4b)\le r\sigma/4.
\end{aligned}
\tag{B.B}
$$

The pointwise inequality behind the second step is |z| 1_{|z|>L} <= z^2/L, for L>0. The asymmetric extra portions of U outside the centered window do not cause a problem: the omitted set is contained in the tail, which is all the argument requires.

## B.9 Aggregation, explicit failure probability, and confidence

For each independent refinement block h define

$$
\widehat\mu_h=c+
\sum_{i=0}^{m}\frac1{n_0}\sum_{t=1}^{n_0}
(V_{h,i,t}^L(c)+V_{h,i,t}^R(c)).
$$

Its conditional expectation is c+E[(X-c)1_U]. Given c, all (i,t,d) are independent. Equations (B.V) and (B.T) imply

$$
\begin{aligned}
\operatorname{Var}(\widehat\mu_h\mid c)
&\le\frac{2A}{n_0}
\left[a^2+\sum_{i=1}^{m}\ell_i^2\tau_i(c)\right]\\
&\le\frac{2A}{n_0}[a^2+(4/3)M_2(c)]\\
&\le\frac{14AK}{3n_0}\sigma^2\\
&\le\frac7{192}r^2\sigma^2.
\end{aligned}
$$

We used a<=sigma and K>=1; no estimate of sigma enters the algorithm. Chebyshev and (B.B) give

$$
P(|\widehat\mu_h-\mu|>r\sigma\mid c)
\le\frac{(7/192)}{(3/4)^2}
=\frac7{108}<\frac18.
$$

The final estimate is the median of the B block estimates. Conditionally on c the block failure indicators are independent, each with mean at most 1/8. A bad median requires at least B/2 bad blocks. Hoeffding yields

$$
P(|\operatorname{med}_h\widehat\mu_h-\mu|>r\sigma\mid c)
\le\exp(-2B(1/2-1/8)^2)
=\exp(-9B/32)\le\delta/2.
$$

Integrating over good c and adding the localization failure probability proves the stated overall delta bound. This conditions on an independent center, not on an event involving refinement answers, so it does not silently introduce selection bias.

# Appendix C. Lower bounds with exactly equal variances

The geometric support and least-index KL argument adapt [1, Appendix B.1]. The mirrored alternatives below ensure exactly equal actual variance, a condition not met by the symmetric-null/skewed-alternative pair displayed there.

## C.1 Model and the issue in the original theorem

Fix $s>0$, $\lambda\geq s$, $0<r\leq1/8$, and $0<\delta\leq1/4$. A procedure uses at most $n$ one-bit observations of independent samples; each query may be an arbitrary measurable binary function and may depend on the preceding transcript. Its goal is

$$
\Pr_P\{|\widehat\mu-\mu(P)|\leq rs\}\geq1-\delta
$$

for every distribution satisfying $|\mu(P)|\leq\lambda$ and **actual variance exactly $s^2$**. This is a subclass of the unknown-scale model for every interval $[s,S]$, including $S=s$.

Theorem 9 of the source assumes an upper bound on variance. Its finite-variance proof uses a symmetric null with mean zero and second moment $\sigma^2$, and an alternative of mean $3\epsilon$ with the same second moment. Thus the actual variances of the displayed pair are $\sigma^2$ and $\sigma^2-9\epsilon^2$. Directly invoking that pair does not settle the exactly-$s^2$ class. The construction below uses two mirror alternatives, giving equal squared means and hence equal variances.

## C.2 An exactly equal-variance hard pair

Define

$$
a=2rs,\qquad \tau=\sqrt{s^2+a^2},\qquad
M=\left\lfloor\log_2\frac{\tau}{2a}\right\rfloor.
$$

Since $r\leq1/8$, $\tau/(2a)\geq1/(4r)\geq2$, so $M\geq1$. For $j=1,\ldots,M$, put

$$
x_j=2^j\tau,\qquad
q_j=\frac1{2M4^j},\qquad
d_j=\frac{a}{2Mx_j}.
$$

Define $P_+$ by masses $q_j+d_j$ at $+x_j$ and $q_j-d_j$ at $-x_j$; define $P_-$ by reversing these two masses. Both have remaining mass

$$
p_0=1-2\sum_{j=1}^M q_j\geq1-\frac1{3M}\geq\frac23
$$

at zero. These are valid probability distributions because

$$
\frac{d_j}{q_j}=\frac{a2^j}{\tau}\leq\frac12. \tag{C.1}
$$

Their means and second moments are

$$
\mathbb E_{P_\pm}X=\pm\sum_{j=1}^M2d_jx_j=\pm a,
\qquad
\mathbb E_{P_\pm}X^2=\sum_{j=1}^M2q_jx_j^2=\tau^2.
$$

Therefore

$$
\operatorname{Var}_{P_+}(X)=\operatorname{Var}_{P_-}(X)
=\tau^2-a^2=s^2. \tag{C.2}
$$

Also $a=2rs\leq s/4\leq\lambda$, so both mean constraints hold. Their accuracy intervals of radius $rs$ are disjoint and lie strictly on opposite sides of zero.

## C.3 Uniform one-bit KL bound

For every measurable set $A\subseteq\mathbb R$,

$$
D_{\rm KL}\!\left(\operatorname{Bern}(P_+(A))\,
\middle\|\,\operatorname{Bern}(P_-(A))\right)
\leq \frac{32a^2}{M\tau^2}
\leq \frac{128r^2}{M}. \tag{C.3}
$$

**Proof.** Complementing $A$ preserves the Bernoulli KL divergence, so assume $P_-(A)\leq1/2$. The atom at zero has mass at least $2/3$, hence $0\notin A$. If $A$ contains no point in the support, both probabilities are zero and the claim is immediate. Otherwise let $j_*$ be the smallest index for which $A$ contains at least one of $x_{j_*},-x_{j_*}$. By (1),

$$
P_-(A)\geq q_{j_*}-d_{j_*}\geq\frac12q_{j_*}.
$$

At a given index the probability difference vanishes if both support points are in $A$, and has absolute value $2d_j$ if exactly one is. Consequently,

$$
\begin{aligned}
|P_+(A)-P_-(A)|
&\leq2\sum_{j=j_*}^Md_j\\
&\leq\frac{2a}{M\tau}\,2^{-j_*}.
\end{aligned}
$$

For $p=P_+(A)$, $q=P_-(A)\in(0,1/2]$, the Bernoulli chi-square bound on KL gives

$$
\begin{aligned}
\operatorname{kl}(p\|q)
&\leq\frac{(p-q)^2}{q(1-q)}
\leq\frac{4(p-q)^2}{q_{j_*}}\\
&\leq4\left(\frac{4a^2}{M^2\tau^2}4^{-j_*}\right)
\left(2M4^{j_*}\right)
=\frac{32a^2}{M\tau^2}.
\end{aligned}
$$

The final inequality in (C.3) follows from $a^2/\tau^2\leq4r^2$. This calculation holds for all measurable sets, including sets with arbitrarily many interval components.

## C.4 Adaptive transcripts and testing

All algorithmic random seeds can be included in an enlarged transcript. They have the same distribution under both hypotheses. Conditional on the seeds and the preceding binary responses, the next query is a fixed measurable set and its fresh sample has distribution $P_+$ or $P_-$. The KL chain rule and (C.3) therefore imply

$$
D_{\rm KL}(\mathsf T_+\|\mathsf T_-)
\leq \frac{128nr^2}{M}. \tag{C.4}
$$

Including random seeds only gives the testing procedure more information. A successful mean estimator yields the test $\widehat\mu>0$; its two errors are at most $\delta$. Hence the total variation distance between the transcript laws is at least $1-2\delta$. Pinsker's inequality and (C.4) give

$$
\frac{128nr^2}{M}\geq2(1-2\delta)^2\geq\frac12.
$$

In particular,

$$
n\geq\frac{M}{256r^2}. \tag{C.5}
$$

To express the logarithm uniformly, write $t=\log_2(1/r)\geq3$. We have $M\geq1$ and $M\geq t-3$, so $M\geq t/4$. Thus

$$
\boxed{n\geq\frac{\log_2(1/r)}{1024r^2}.} \tag{C.6}
$$

This lower bound applies even to fully adaptive one-bit protocols.

### Explicit variable-confidence strengthening

Let the binary test declare the plus hypothesis when $\widehat\mu>0$. Its plus-declaration probabilities under $P_+$ and $P_-$ are respectively at least $1-\delta$ and at most $\delta$. Data processing for KL and monotonicity of binary KL on this range imply

$$
\frac{128nr^2}{M}
\geq\operatorname{kl}(1-\delta\|\delta)
=(1-2\delta)\log\frac{1-\delta}{\delta}.
$$

For $0<\delta\leq1/4$, we have $1-2\delta\geq1/2$ and $1-\delta\geq\sqrt\delta$, so

$$
(1-2\delta)\log\frac{1-\delta}{\delta}
\geq\frac14\log(1/\delta).
$$

Hence the equal-actual-variance class satisfies the explicit bound

$$
\boxed{
n\geq\frac{M}{512r^2}\log(1/\delta)
\geq\frac{\log_2(1/r)\log(1/\delta)}{2048r^2}.
} \tag{C.6a}
$$

Both logarithm conventions are displayed explicitly: the accuracy logarithm in (C.6a) has base two, and the confidence logarithm is natural.

## C.5 Exact-variance localization lower bound

An independent finite family supplies the location term without any variance padding. Let

$$
K=\left\lfloor\frac{\lambda}{2rs}\right\rfloor+1,
\qquad \mu_j=-\lambda+4rsj\quad(j=0,\ldots,K-1),
$$

and

$$
P_j=\tfrac12\delta_{\mu_j-s}+\tfrac12\delta_{\mu_j+s}.
$$

Every $P_j$ has mean in $[-\lambda,\lambda]$ and actual variance $s^2$. The target intervals of radius $rs$ are disjoint. With a uniform prior on $j$, successful estimation yields identification error at most $\delta$. Each response contains at most one bit of conditional information, even under adaptive querying. Fano's inequality in bits gives

$$
n\geq(1-\delta)\log_2K-1. \tag{C.7}
$$

Since $K>\lambda/(2rs)\geq4\lambda/s$, for the parameter range above,

$$
n\geq\frac34\log_2(\lambda/s)+\frac12. \tag{C.8}
$$

Together (6a) and (C.8) imply

$$
n=\Omega\!\left(\log(\lambda/s)+r^{-2}\log(1/r)\log(1/\delta)\right)
$$

on the exactly-$s^2$ subclass. Combining this with a separately proved unknown-scale noninteractive lower bound $\Omega(r^{-2}\log(S/s)\log(1/\delta))$ would yield the desired confidence-dependent three-term bound by $\max\{A,B,C\}\geq(A+B+C)/3$. At constant confidence this specializes to the corresponding constant-confidence result. No change from actual variance to a variance label is required.

# Appendix D. A finite-scale information budget

Location/scale-integrated Hellinger arguments for unknown-variance communication have a strong predecessor in [3, Section 7.1]. The heat-entropy calculation and finite-displacement reduction below prove the specific PAC adaptation term used here.

## D.1 Statement and exact scope

Let $0<s\leq S\leq\lambda$, $0<r\leq1/16$, and $0<\delta\leq1/16$. Consider a protocol which uses exactly $n$ independent observations, sends one bit per observation, and fixes all encoding rules before any observation or bit response is seen. Arbitrary jointly measurable binary encoding rules and distribution-independent public and private randomness are allowed. The decoder may be arbitrary and randomized. The parameters $(s,S,\lambda,r,\delta,n)$ are known; the true mean and scale are not.

Suppose the estimate satisfies

$$
\Pr_{\mu,\sigma}\{ |\widehat\mu-\mu|\leq r\sigma\}\geq1-\delta
\quad\text{for all }|\mu|\leq\lambda,\quad s\leq\sigma\leq S,
\tag{D.1}
$$

when the observations are Gaussian $N(\mu,\sigma^2)$. Then

$$
\boxed{
n\geq\frac{\log(S/s)\,\log(1/(2\sqrt\delta))}
{32r^2\log2}
\geq\frac{\log(S/s)\,\log(1/\delta)}
{128r^2\log2}.}
\tag{D.2}
$$

In particular, at $\delta=1/16$,

$$
\boxed{n\geq\frac{\log(S/s)}{32r^2}.}
\tag{D.3}
$$

The main theorem's restriction $r\leq1/64$ is inside this theorem's range. All logarithms here are natural. At $S=s$ the displayed scale lower bound is zero; the fixed-scale precision and location lower bounds are separate obligations. Since the Gaussian family is a subclass of all distributions with actual standard deviation in $[s,S]$, (2) immediately applies to the full nonparametric class. The proof does not assume a variance upper bound in place of actual standard deviation.

## D.2 A single binary channel has a bounded integrated information budget

Let $q:\mathbb R\to[0,1]$ be a measurable binary channel, and write

$$
p(x,\sigma)=\int_{\mathbb R}q(y)\varphi_\sigma(y-x)\,dy,
\qquad
I_q(x,\sigma)=\frac{p_x(x,\sigma)^2}{p(x,\sigma)(1-p(x,\sigma))}.
\tag{D.4}
$$

If $q=0$ or $q=1$ Lebesgue almost everywhere, the channel is uninformative and we set $I_q=0$. Otherwise the strict positivity of the Gaussian density gives $0<p<1$. Gaussian convolution of a bounded measurable function is smooth for $\sigma>0$, and on each compact set in $\mathbb R\times(0,\infty)$, $p$ and $1-p$ are bounded away from zero. These facts justify the differentiations below; they hold separately for each channel, so no channel-uniform lower bound on $p$ is needed.

Define binary entropy in nats by

$$
h(t)=-t\log t-(1-t)\log(1-t),\qquad 0\leq h\leq\log2.
$$

The Gaussian heat equation in the standard-deviation parameter is

$$
p_\sigma=\sigma p_{xx}.
$$

Since $h''(p)=-1/[p(1-p)]$, the chain rule gives the exact identity

$$
\partial_\sigma h(p)
=\sigma\partial_{xx}h(p)+\sigma I_q.
\tag{D.5}
$$

The sign of the information term is positive. Introduce the triangular weight

$$
w(x)=\left(1-\frac{|x|}{\lambda}\right)_+,
\qquad
H(\sigma)=\int_{-\lambda}^{\lambda}w(x)h(p(x,\sigma))\,dx,
\qquad
J_q(\sigma)=\int_{-\lambda}^{\lambda}w(x)I_q(x,\sigma)\,dx.
$$

Here $\int w=\lambda$, hence $0\leq H\leq\lambda\log2$. Integrating (D.5) by parts on $[-\lambda,0]$ and $[0,\lambda]$ gives

$$
H'(\sigma)=\sigma J_q(\sigma)
+\frac{\sigma}{\lambda}
\bigl[h(p(-\lambda,\sigma))-2h(p(0,\sigma))+h(p(\lambda,\sigma))\bigr].
\tag{D.6}
$$

Equivalently, $w''=(\delta_{-\lambda}-2\delta_0+\delta_\lambda)/\lambda$ in the distributional sense; no distribution theory is needed if the two ordinary integrations by parts are used. Integrating (D.6) yields

$$
\begin{aligned}
\int_s^S\sigma J_q(\sigma)\,d\sigma
&=H(S)-H(s)
-\frac1\lambda\int_s^S\sigma
\bigl[h(p(-\lambda,\sigma))-2h(p(0,\sigma))+h(p(\lambda,\sigma))\bigr]\,d\sigma\\
&\leq\lambda\log2+\frac{S^2-s^2}{\lambda}\log2\\
&\leq2\lambda\log2.
\end{aligned}
\tag{D.7}
$$

In the inequality, the two endpoint entropy terms have favorable signs and can be discarded; the central entropy is at most $\log2$. The final step uses $S\leq\lambda$. This integrated bound holds for every fixed channel regardless of its oscillation or interval complexity.

## D.3 From local information to a finite-separation affinity bound

Fix $\sigma\in[s,S]$, and set $d=4r\sigma$. For $m\in[-\lambda/2,\lambda/2]$, define the affinity of the two channel outputs by

$$
A_q(m,\sigma)
=\sqrt{p(m,\sigma)p(m+d,\sigma)}
+\sqrt{(1-p(m,\sigma))(1-p(m+d,\sigma))},
\qquad z_q=-\log A_q.
\tag{D.8}
$$

The Gaussian input affinity is $\exp(-d^2/(8\sigma^2))$. Affinity increases under a stochastic channel: for each output value, the integral of the square root of the two input densities times the output probability is bounded above by the square root of the two resulting output probabilities, by Cauchy--Schwarz; summing over the two outputs proves the assertion. Therefore

$$
A_q(m,\sigma)\geq e^{-2r^2}\geq e^{-1/128}>\tfrac12.
\tag{D.9}
$$

Let $v(x)=(\sqrt{p(x,\sigma)},\sqrt{1-p(x,\sigma)})$. Its Euclidean norm is one and

$$
\|v'(x)\|^2=\frac14I_q(x,\sigma).
$$

The fundamental theorem of calculus and Cauchy--Schwarz give

$$
1-A_q(m,\sigma)
=\frac12\|v(m+d)-v(m)\|^2
\leq\frac d8\int_m^{m+d}I_q(u,\sigma)\,du.
\tag{D.10}
$$

For $A\in[1/2,1]$, $-\log A\leq2(1-A)$. Hence

$$
z_q(m,\sigma)\leq\frac d4\int_m^{m+d}I_q(u,\sigma)\,du.
\tag{D.11}
$$

This verifies the finite-separation constant in the finite-displacement calculation. It is an exact bound for the stated $r$, not an asymptotic Fisher-information approximation.

Now $d\leq\lambda/4$, so every path lies in $[-\lambda/2,3\lambda/4]$, on which $w\geq1/4$. Fubini's theorem and nonnegativity imply

$$
\begin{aligned}
\int_{-\lambda/2}^{\lambda/2}z_q(m,\sigma)\,dm
&\leq\frac{d^2}{4}\int_{-\lambda/2}^{\lambda/2+d}I_q(u,\sigma)\,du\\
&\leq d^2J_q(\sigma)
=16r^2\sigma^2J_q(\sigma).
\end{aligned}
\tag{D.12}
$$

Integrating with respect to $d\sigma/\sigma$, and applying (7), gives the single-channel budget

$$
\boxed{
\int_s^S\frac{d\sigma}{\sigma}
\int_{-\lambda/2}^{\lambda/2}z_q(m,\sigma)\,dm
\leq32r^2\lambda\log2.}
\tag{D.13}
$$

## D.4 Public coins and the confidence factor

Include all distribution-independent random seeds in an enlarged transcript, denoting them collectively by $U$. This may reveal private randomness and decoder randomness to the analyst, which only enlarges the available information; the original estimator and its guarantee (1) remain available. Conditional on $U$, each encoding rule is fixed and the $n$ bits are independent, because the observations are independent and the protocol is nonadaptive. Equivalently, condition only on the public seed and retain independent private randomness in the channels $q_i^U$.

Write $\mathsf T_0$ and $\mathsf T_1$ for the enlarged transcript under $N(m,\sigma^2)$ and $N(m+d,\sigma^2)$. Their affinity is

$$
A_{\mathsf T}(m,\sigma)
=\mathbb E_U\prod_{i=1}^n A_{q_i^U}(m,\sigma)
=\mathbb E_U\exp\left(-\sum_{i=1}^nz_{q_i^U}(m,\sigma)\right).
\tag{D.14}
$$

Jensen's inequality implies

$$
-\log A_{\mathsf T}(m,\sigma)
\leq\mathbb E_U\sum_{i=1}^nz_{q_i^U}(m,\sigma).
\tag{D.15}
$$

There is no conditioning of the PAC guarantee on a favorable public seed. Formula (D.14) handles success averaged over all seeds directly. This point is necessary for a valid public-coin lower bound with the confidence dependence retained.

Both Gaussian means are in $[-\lambda,\lambda]$. Thresholding $\widehat\mu$ at $m+d/2$ yields a test with error probabilities $\alpha,\beta\leq\delta$, since $d=4r\sigma$ separates the two accuracy intervals. Applying Cauchy--Schwarz on the two decision regions gives

$$
A_{\mathsf T}(m,\sigma)
\leq\sqrt{(1-\alpha)\beta}+\sqrt{\alpha(1-\beta)}
\leq2\sqrt\delta.
\tag{D.16}
$$

Thus, at every allowed $(m,\sigma)$,

$$
L_\delta:=\log\frac1{2\sqrt\delta}
\leq-\log A_{\mathsf T}(m,\sigma)
\leq\mathbb E_U\sum_{i=1}^nz_{q_i^U}(m,\sigma).
\tag{D.17}
$$

Integrating (D.17), using Tonelli for the nonnegative terms and then (13) for every conditioned channel, gives

$$
\lambda\log(S/s)L_\delta
\leq32nr^2\lambda\log2.
\tag{D.18}
$$

This proves the first inequality in (D.2). For $\delta\leq1/16$,
$L_\delta=\tfrac12\log(1/\delta)-\log2\geq\tfrac14\log(1/\delta)$, proving the second. At $\delta=1/16$, $L_\delta=\log2$, proving (3).

## D.5 Boundary and protocol limitations

**No positive scale floor.** Fix $\lambda\geq S>0$, $0<r\leq1/16$, and $0<\delta\leq1/16$. If a single finite deterministic-sample protocol satisfied (1) for every $0<\sigma\leq S$, then (2) would hold for every $s\in(0,S]$. Letting $s\downarrow0$ contradicts finiteness of $n$. This concerns a uniform fixed-sample guarantee. It does not rule out a data-dependent stopping rule which has finite cost separately at each distribution, and it does not turn the present proof into an adaptive-query lower bound.

**Why nonadaptivity matters.** Each conditional channel in (D.13) must be the same function throughout the location/scale integral. With adaptive queries, conditioning on earlier observed bits changes their distribution as the underlying Gaussian changes, so the summation step (14)--(18) does not apply. The theorem should not be stated for adaptive querying.


# References

[1] Ivan Lau and Jonathan Scarlett. *Order-Optimal Sequential 1-Bit Mean Estimation in General Tail Regimes*. arXiv:2604.07796v2, 22 May 2026. Theorem 15; Appendix B.1; coding localization. <https://arxiv.org/html/2604.07796v2>.

[2] Ivan Lau and Jonathan Scarlett. *Non-Adaptive 1-Bit Mean Estimation: Minimax Rates and the Sample-Interval Tradeoff*. arXiv:2609.08564v1, 8 September 2026. Model, Lemmas 1--3, Appendices A--B, conclusion, and Appendix F. <https://arxiv.org/pdf/2609.08564>.

[3] T. Tony Cai and Hongji Wei. *Distributed adaptive Gaussian mean estimation with unknown variance: Interactive protocol helps adaptation*. Annals of Statistics 50(4):1992--2020, 2022, DOI:10.1214/21-AOS2167. Published 29-page author version, Sections 3.1 and 7.1. <https://tony-cai.com/assets/pdf/papers/Distributed-Gaussian-Mean-UnknownVar.pdf>.

[4] Ritesh Kumar and Shashank Vatedka. *One-Bit Distributed Mean Estimation with Unknown Variance*. arXiv:2501.18502v4, 23 June 2026; TMLR/OpenReview record. In particular Section 3.4. <https://arxiv.org/html/2501.18502v4>.

[5] Yuchen Miao. *Universal Refinement without Interaction: Order-Optimal 1-Bit Mean Estimation*. arXiv:2607.24358, 2026. Official indexed abstract, author repository <https://github.com/yuchenmiao04/onebitmean>, and comparison in [2, Appendix F] checked. Direct full-text retrieval unavailable in this review; no claim of full-text exclusion. <https://arxiv.org/abs/2607.24358>.

[6] Jiachen Hu and Han Zhong. *Interaction Is Not Necessary for Order-Optimal 1-Bit Mean Estimation*. arXiv:2608.02538, 2026. Official indexed abstract and comparison in [2, Appendix F] checked. Direct full-text retrieval unavailable in this review; no claim of full-text exclusion. <https://arxiv.org/abs/2608.02538>.

[7] T. Tony Cai and Hongji Wei. *Distributed Gaussian Mean Estimation under Communication Constraints: Optimal Rates and Communication-Efficient Algorithms*. Journal of Machine Learning Research 25, 2024. Digit/Gray-code localization context. <https://www.jmlr.org/papers/volume25/21-0316/21-0316.pdf>.

[8] Pahan Dewasurendra. *Interaction Is Unnecessary for Order-Optimal One-Bit Mean Estimation*. Author-hosted 10-page manuscript, accessed 25 November 2026 (Asia/Shanghai); publication/version date not independently established. Theorem 1 and Sections 4--5. <https://andotheror.github.io/pdf/interaction-is-unnecessary-for-order-optimal-one-bit-mean-estimation.pdf>.
