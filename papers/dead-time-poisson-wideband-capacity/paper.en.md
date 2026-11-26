# Wideband Capacity of Dead-Time Detector Channels

Poisson converses, finite-burst envelopes, and fixed-error energy frontiers

## Abstract

We determine the leading no-feedback wideband capacity of two dead-time detector models. For the binary Poisson trigger, an occupancy converse matches the guarded pulse-position-modulation lower bound of Wang (2020). A general theorem then treats every fixed Borel trigger response that vanishes at zero input: the coefficient is the concave cost envelope of its optimal finite-burst success response, divided by the energy per dead-time period. Every near-optimal envelope value needs at most two finite burst patterns. This characterization separates gains from splitting an input into a burst and from time sharing between energy levels. Photon-count thresholds exhibit a strict, explicitly characterized time-sharing gain; sublinear Weibull responses exhibit a strict fragmentation gain and a discontinuous envelope at zero. For each fixed permitted average error, the average-energy coefficient evaluates the envelope at the enlarged budget, whereas the hard-energy coefficient is unchanged. A finite-length output-counting converse covers arbitrary stochastic non-feedback encoders and randomized decoders, and an explicit nonidentical-erasure construction proves achievability. These are first-order, iterated-limit results, not exact finite-parameter capacities. Full formalization remains a separate outstanding deliverable.

## 1. Problem and contribution

A photon detector cannot always record a second arrival immediately after the first. In a nonparalyzable detector, only a recorded arrival starts a dead-time period. In a paralyzable detector, an arrival during a dead period restarts that period. These mechanisms create memory even when the underlying optical arrivals are conditionally independent.

Wang [W20, Section 3] studied the binary-output discrete-time models used here. If the mean allowed input energy per slot is $\beta$ and the dead time is $d$ slots, the wideband limit keeps $d\beta$ near a positive constant $\eta$. The guarded PPM construction in [W20, Proposition 7] gives the no-feedback coefficient $(1-e^{-\eta})/\eta$. The paper leaves a matching upper bound open. Its feedback coefficient is already known and is larger for every positive finite $\eta$.

Our first contribution is the matching converse for the entire non-feedback coding class. Our second is the fixed-error classification: the answer depends on whether energy is averaged over messages and encoder randomization or bounded for each actual transmission. Our third is an explicit finite-length energy-versus-success certificate. The distinction matters because averaging energy allows some messages to receive no transmission resources.

The structural extension in Sections 11–14 replaces the Poisson response by an arbitrary fixed Borel trigger $p$ with $p(0)=0$. Define $Q(E)$ as the best probability of at least one trigger in a finite burst costing at most $E$, and $G(E)$ as its finite-mixture concave cost envelope. The exact leading coefficients are $G(\eta)/\eta$ under hard energy and $G(\eta/(1-\varepsilon))/\eta$ under average energy. Neither concavification nor time sharing is new as a general technique. The new assertion is that these two scalar optimizations exhaust the leading capacity of the stated growing-memory channels, with a matching converse for all codes. The two-burst approximation and the threshold and fragmentation classifications make the optimization operational and distinguish effects absent in the Poisson special case.

The tools have established origins. Guarded PPM and the original achievable coefficient belong to [W20]. PPM in high-photon-efficiency communication is developed in [WW14]. Long-term-power message dilution and the factor $1/(1-\varepsilon)$ are familiar from fixed-error coding, including [YCDP15]; we do not claim either mechanism as a new invention. The model-specific advance is a uniform occupancy converse for the growing-memory detector channel and its matching, nonlinear error-energy coefficient.

### 1.1. Relation to nearby models

[WW14] treats a memoryless Poisson channel and determines finer asymptotic terms, including dark-current effects. Its results do not give the growing-dead-time converse proved here; our results do not replace its second-order analysis. [YCDP15] studies long-term power in Gaussian and fading channels. It supplies methodological context, not the detector-channel converse. [W20] is the direct problem source and supplies the lower-bound construction and the feedback benchmark.

Additional detector models with a sampling interval at least as long as the dead time, a peak-intensity constraint, or information carried by an external photon's mark have different operational inputs or scaling. The separate novelty audit identifies the precise materials inspected and an unavailable 2025 refractory-Poisson article. The claims of distinction are limited to that audit. This manuscript does not assert globally certified priority or external peer review.

Capacity per unit cost for memoryless channels [V90] and time sharing in optical PPM [MH03] are relevant predecessors. The former's fixed memoryless-channel theorem does not supply a joint growing-dead-time capacity coefficient; the latter explicitly discusses gains from nonconcave PPM rate curves and transmitter recharge intervals. We claim neither a new cost-concavification principle nor the first use of time sharing in PPM. Our detector-output converse and the finite-burst envelope identity are the distinct assertions. The source register specifies the original material actually accessible for each comparison.

## 2. Model and operational conventions

Fix $d\in\mathbb Z_{\ge0}$ and an input vector $x^n\in[0,\infty)^n$. Conditional on this complete vector, generate independent raw indicators

$$
Z_i\sim\operatorname{Bernoulli}(1-e^{-x_i}),\qquad 1\le i\le n. \tag{1}
$$

All indicators and outputs with nonpositive indices are zero. The two output laws are

$$
Y_i^{\mathrm{NP}}=Z_i\mathbf 1\{Y_{i-d}^{\mathrm{NP}}=\cdots=Y_{i-1}^{\mathrm{NP}}=0\},
\qquad
Y_i^{\mathrm P}=Z_i\mathbf 1\{Z_{i-d}=\cdots=Z_{i-1}=0\}. \tag{2}
$$

An empty condition is true when $d=0$. The detector is initially ready. There is no dark current and no peak-amplitude restriction. Equation (1) describes a binary indicator of at least one Poisson arrival, not the full photon count.

A message $J$ is uniform on $\{1,\ldots,M\}$. A non-feedback encoder is an arbitrary probability kernel $K_j(dx^n)$ on the input vectors. Its randomness is independent of the raw channel randomness. The decoder may randomize: write $D(j\mid y^n)\ge0$ with $\sum_jD(j\mid y^n)\le1$, allowing a failure output. Average success is $P_s=\Pr\{\widehat J=J\}$ and average error is $P_e=1-P_s$.

**Definition 1 (two energy constraints).** Write $A(x^n)=\sum_i x_i$. The average constraint is

$$
\frac1M\sum_{j=1}^M\int A(x^n)K_j(dx^n)\le n\beta. \tag{3}
$$

The hard constraint requires $K_j\{A(x^n)\le n\beta\}=1$ for every message $j$. A bound on the expected energy of each message separately is not the hard constraint.

**Definition 2 (fixed-error capacity).** For fixed $\beta,d$ and $0\le\varepsilon<1$, a rate $R$ is achievable if there are codes at lengths tending to infinity with

$$
\liminf_{n\to\infty}\frac{\log M_n}{n}\ge R,
\qquad
\limsup_{n\to\infty}P_{e,n}\le\varepsilon,
$$

and the relevant energy constraint at every length. Their supremum is $C^{\rm av}_{\varepsilon,s}(\beta,d)$ or $C^{\rm hard}_{\varepsilon,s}(\beta,d)$, where $s\in\{\mathrm{NP},\mathrm P\}$. The constructions below extend to every sufficiently large integer length by zero padding. At $\varepsilon=0$ this is vanishing-error capacity, not zero-error capacity at finite block length. All logarithms are natural and rates are nats per slot.

## 3. Main theorem

**Theorem 3 (complete fixed-error wideband coefficients).** Fix $\eta\in(0,\infty)$ and $\varepsilon\in[0,1)$. For every sequence $\beta_k>0$ tending to zero and integers $d_k\ge0$ such that $d_k\beta_k\to\eta$, and for both detector laws in (2),

$$
\lim_{k\to\infty}
\frac{C^{\rm av}_{\varepsilon,s}(\beta_k,d_k)}
{\beta_k\log(1/\beta_k)}
=\frac{1-\exp[-\eta/(1-\varepsilon)]}{\eta}, \tag{4}
$$

$$
\lim_{k\to\infty}
\frac{C^{\rm hard}_{\varepsilon,s}(\beta_k,d_k)}
{\beta_k\log(1/\beta_k)}
=\frac{1-e^{-\eta}}{\eta}. \tag{5}
$$

Capacity first takes the coding-length limit at each fixed $(\beta_k,d_k)$. No simultaneous coding-length/dead-time limit is implicit. In particular, (4) at $\varepsilon=0$ matches [W20, Proposition 7] for the entire parameter range $\eta>0$. Equality of these leading constants for the two detectors does not assert equality of their finite-parameter capacities.

Sections 4–7 prove explicit finite-parameter bounds. Section 8 obtains the theorem by squeezing those bounds.

## 4. Raw-window occupation and exact throughput

Set $m=d+1$. For arbitrary $n\ge1$, append zero inputs to length $Bm$, where $B=\lceil n/m\rceil$. With no dark current these inputs produce zero raw indicators and zero outputs, so the original decoding problem is unchanged. Partition this padded vector into $B$ disjoint windows of length $m$. Let $A_r$ be a window's input energy, let $I_r$ indicate a raw arrival somewhere in it, and let $K_r$ be the number of recorded detections there.

**Lemma 4 (pathwise window domination).** For either detector,

$$
0\le K_r\le I_r\le1. \tag{6}
$$

Conditional on the complete input, the $I_r$ are independent and

$$
\mathbb E[I_r\mid x^n]=1-e^{-A_r}. \tag{7}
$$

*Proof.* Two nonparalyzable recorded outputs cannot be at distance at most $d$, by the recursion. In the paralyzable case, a recorded output is itself a raw arrival and therefore prevents any recording in the next $d$ slots. Thus an $m$-slot window contains at most one recorded output. A recorded output requires a raw arrival, giving (6). The probability of no raw arrival in a window is $\prod_i e^{-x_i}=e^{-A_r}$. Disjoint raw windows are independent conditional on $x^n$. The recorded windows need not be independent. $\square$

This conditioning is valid because the encoder has no feedback. If the input were adapted to observed outputs, conditioning on the whole input could reveal channel noise; (7) and the required independence would not follow.

**Proposition 5 (exact maximal detection count).** Every encoder satisfying (3) obeys

$$
\mathbb E\sum_{i=1}^nY_i
\le B\left(1-e^{-n\beta/B}\right). \tag{8}
$$

For $n=Bm$, this upper bound is attained under the hard energy constraint, for both detectors. Consequently the maximal expected count at those lengths is exactly $B(1-e^{-m\beta})$.

*Proof.* The map $a\mapsto1-e^{-a}$ is concave and increasing on $[0,\infty)$. Apply (6)–(7), concavity over the windows, and then concavity over the random input:

$$
\mathbb E\sum_rK_r
\le\mathbb E\sum_r(1-e^{-A_r})
\le B\left(1-e^{-\mathbb E A(X^n)/B}\right)
\le B(1-e^{-n\beta/B}).
$$

For equality at $n=Bm$, place a pulse of amplitude $m\beta$ in the first slot of each window and send zero elsewhere. Consecutive possible arrivals are exactly $d+1$ slots apart. Every raw arrival is recorded under either mechanism. The total energy is exactly $n\beta$ and each pulse is recorded with probability $1-e^{-m\beta}$. $\square$

The equality construction maximizes detections; by itself it transmits no information through pulse positions. Throughput optimality and capacity optimality are separate statements.

## 5. Concentration and output counting

For $u\in[0,1]$ put

$$
h(u)=-u\log u-(1-u)\log(1-u),\quad
F_m(u)=h(u)+u\log m,\quad u_m^*=\frac m{m+1}, \tag{9}
$$

with $0\log0=0$. Differentiation on $(0,1)$ gives
$F'_m(u)=\log[m(1-u)/u]$. Thus $F_m$ increases up to $u_m^*$, where it equals $\log(m+1)$, and is continuous on $[0,1]$.

**Lemma 6 (uniform low-energy concentration).** Fix $b>0$, let $p_b=1-e^{-mb}$, and let $\delta>0$. Uniformly over every deterministic input with $A(x^n)\le nb$,

$$
\Pr_{x^n}\left\{\sum_rK_r>B(p_b+\delta)\right\}
\le e^{-2B\delta^2}. \tag{10}
$$

*Proof.* By concavity,

$$
\sum_r\mathbb E[I_r\mid x^n]
\le B(1-e^{-A(x^n)/B})
\le B(1-e^{-mb})=Bp_b,
$$

since $n/B\le m$. Apply the independent Bernoulli bound in Appendix A to $\sum_r I_r$, then use (6). $\square$

**Lemma 7 (low-occupancy output count).** Let $S_{B,t}$ consist of all binary strings of length $Bm$ with at most one detection per window and at most $\lfloor Bt\rfloor$ occupied windows. If $0\le t\le u_m^*$, then

$$
|S_{B,t}|=\sum_{j=0}^{\lfloor Bt\rfloor}{B\choose j}m^j
\le e^{BF_m(t)}. \tag{11}
$$

*Proof.* Choose the occupied windows and then one of $m$ positions in each. If $t>0$, set $\theta=t/[m(1-t)]\in(0,1]$. For $j\le Bt$, $\theta^j\ge\theta^{Bt}$, so the binomial theorem gives

$$
\sum_{j\le\lfloor Bt\rfloor}{B\choose j}m^j
\le\theta^{-Bt}(1+m\theta)^B=e^{BF_m(t)}.
$$

At $t=0$ the only string is zero. At $t=u_m^*$ the same argument has $\theta=1$. These block strings may violate dead-time restrictions across window boundaries, which only makes the count an upper bound for actual outputs. Padding can likewise only reduce the number of possible outputs. $\square$

**Lemma 8 (success on a finite output set).** For any set of inputs $\mathcal A$ and finite set of outputs $S$, arbitrary stochastic encoding and randomized decoding satisfy

$$
\Pr\{\widehat J=J,\ X^n\in\mathcal A,\ Y^n\in S\}
\le\frac{|S|}{M}. \tag{12}
$$

*Proof.* Write $W_x(y)$ for the finite-output channel law. The left side is

$$
\frac1M\sum_j\int_{\mathcal A}K_j(dx)
\sum_{y\in S}W_x(y)D(j\mid y)
\le\frac1M\sum_{y\in S}\sum_jD(j\mid y)
\le\frac{|S|}{M}.
$$

Here $W_x(y)\le1$ and $K_j(\mathcal A)\le1$; nonnegativity justifies every interchange. No deterministic-encoder reduction is used. $\square$

## 6. A finite-length success certificate

**Theorem 9 (energy-versus-success bound).** Let a length-$n$ code satisfy (3), and let $b>0$, $\delta>0$ satisfy $t=1-e^{-mb}+\delta\le u_m^*$. For either detector,

$$
P_s\le \frac{\beta}{b}
+e^{-2B\delta^2}
+\frac{e^{BF_m(t)}}{M}. \tag{13}
$$

If every realized input has energy at most $nb$, the first term is absent. For all codes, independently of their energy,

$$
P_s\le\frac{(m+1)^B}{M}. \tag{14}
$$

*Proof.* Split success into high-energy inputs, low-energy inputs with outputs outside $S_{B,t}$, and low-energy inputs with outputs inside $S_{B,t}$. Markov's inequality bounds the first probability by $\beta/b$. Lemma 6 bounds the second uniformly before averaging over the encoder. Lemmas 7–8 bound the third. Under a hard $nb$ constraint the high-energy event is null. For (14), use the entire set of block patterns in Lemma 8. $\square$

The certificate covers nonstationary, dependent, and randomized inputs; only the channel randomness conditional on a non-feedback input is independent. It places no a priori bound on individual pulse amplitudes. An independent public random seed, if added to the model, also preserves these upper bounds by conditioning on the seed and averaging; our achievability needs no such resource.

Define the continuous, nondecreasing upper envelope

$$
U_m(b)=\frac1mF_m\left(\min\{1-e^{-mb},u_m^*\}\right),\qquad b\ge0. \tag{15}
$$

**Corollary 10 (finite-parameter capacity envelopes).** For either detector, every $\beta\ge0$ and $0\le\varepsilon<1$,

$$
C^{\rm av}_{\varepsilon,s}(\beta,d)
\le U_m\left(\frac\beta{1-\varepsilon}\right),
\qquad
C^{\rm hard}_{\varepsilon,s}(\beta,d)\le U_m(\beta). \tag{16}
$$

*Proof.* Fix $b>0$. If a sequence's lower limiting rate exceeds $U_m(b)$ and $p_b \lt u_m^*$, choose a sufficiently small fixed $\delta>0$ so that it still exceeds $F_m(p_b+\delta)/m$. Since $B/n\to1/m$, the last two terms of (13) tend to zero. Thus $\limsup P_s\le\beta/b$ under average energy. Under a hard $nb$ constraint, success tends to zero. If $p_b\ge u_m^*$, the same conclusion follows from (14), including equality at the saturation threshold.

Suppose an average-energy achievable rate exceeded $U_m(\beta/(1-\varepsilon))$. Continuity permits choosing $b>\beta/(1-\varepsilon)$ while preserving that strict rate gap. Then $\limsup P_s\le\beta/b<1-\varepsilon$, contradicting $\liminf P_s\ge1-\varepsilon$. Under hard energy choose $b=\beta$, and success tending to zero contradicts every fixed $\varepsilon<1$. Finally, at $\beta=0$, nonnegative energy has expectation zero, every input is zero almost surely, and $P_s\le1/M$; both capacities are zero. $\square$

This proves a strong converse above the explicit envelope $U_m$ under hard energy. It does not prove a strong converse at the unknown exact finite-parameter capacity, since equality with $U_m$ has not been established.

## 7. Achievability with exact energy accounting

**Lemma 11 (guarded PPM as an erasure channel).** Fix an integer $\ell\ge2$ and energy level $z>0$. In each frame of $d+\ell$ slots, put one pulse of amplitude $a=z(d+\ell)$ in one of the first $\ell$ slots, and send zeros in every other slot. Either detector induces an independent $\ell$-ary erasure channel with retention probability $p=1-e^{-a}$. Every frame has energy exactly $a$.

*Proof.* The $d$ final zero slots remove both possible detector memories before the next frame. Within a frame there is only one slot in which a raw arrival is possible. A detected arrival reports the pulse position exactly; otherwise the output is all zero. The probability of erasure is $e^{-a}$, independent of the position, and disjoint frames use independent raw randomness. $\square$

This is the construction in [W20]. The following explicit coding argument makes the achievability and the hard-cost assertion self-contained.

**Lemma 12 (finite erasure-code existence).** For $N$ independent $\ell$-ary erasure symbols with retention probability $p$, for any $M\ge1$ and $0<\delta \lt p$ there is a deterministic codebook with average error at most

$$
e^{-2N\delta^2}+(M-1)\ell^{-N(p-\delta)}. \tag{17}
$$

*Proof.* Draw the $M$ length-$N$ codewords independently and uniformly. Decode to a unique message agreeing with every unerased symbol, and otherwise fail. The number $K$ of unerased symbols is binomial $(N,p)$ and is independent of the transmitted word. Its lower tail is bounded by Appendix A. Given the transmitted word and erasure mask, any other codeword agrees in those $K$ positions with probability $\ell^{-K}$. A union bound and a split at $K=N(p-\delta)$ give (17) for the ensemble-average error. At least one deterministic codebook has error no larger than that average. Repeated codewords, if sampled, are already included in the collision event. In the PPM realization every codeword in every sampled book has energy exactly $Na$, so selecting a good book preserves the hard constraint. $\square$

Taking any symbol rate below $(p-\delta)\log\ell$, then letting $\delta\downarrow0$, proves that

$$
L(z,d,\ell)=\frac{1-e^{-z(d+\ell)}}{d+\ell}\log\ell \tag{18}
$$

is a lower bound on vanishing-error hard-energy capacity with budget $z$. At any large original length $n$, use $N=\lfloor n/(d+\ell)\rfloor$ frames and append zero slots. Energy is at most $nz$ and the rate loss vanishes as $n\to\infty$.

**Lemma 13 (average-energy message dilution).** Fix $\varepsilon>0$ and $q\in(1-\varepsilon,1]$. Any vanishing-error hard-energy code at budget $\beta/q$ gives an average-energy $\varepsilon$-achievable code at budget $\beta$ with the same asymptotic rate.

*Proof.* If the good code has $M_g$ messages, form a code with $M=\lceil M_g/q\rceil$ messages. Preserve the good messages and send the zero input for all others. Use the old decoder. The good-message fraction $q_n=M_g/M$ is at most $q$ and tends to $q$ whenever the rate is positive. Its contribution to average energy is at most $q_n n\beta/q\le n\beta$. Average error has upper limit at most $1-q<\varepsilon$. Also $\log M-\log M_g=O(1)$, so the asymptotic rate is unchanged. If a target lower rate is zero, it is achieved by the one-message zero code. The ceiling ensures the finite-length energy inequality. $\square$

The rate is not multiplied by $q$: adding a constant fraction of messages changes the logarithm of message count by only a bounded amount. This construction is an instance of the established long-term-power mechanism discussed in [YCDP15].

For $\varepsilon=0$, use $q=1$ without dilution. Together with (16), the following sandwich holds for every $\ell\ge2$:

$$
L(\beta,d,\ell)\le C^{\rm hard}_{\varepsilon,s}(\beta,d)\le U_{d+1}(\beta), \tag{19}
$$

and for $\varepsilon>0$ and $q\in(1-\varepsilon,1]$,

$$
L(\beta/q,d,\ell)\le C^{\rm av}_{\varepsilon,s}(\beta,d)
\le U_{d+1}(\beta/(1-\varepsilon)). \tag{20}
$$

## 8. Proof of the wideband theorem

Let $(\beta_k,d_k)$ be as in Theorem 3 and write $m_k=d_k+1$. Necessarily $d_k\to\infty$. For each fixed $c>0$,

$$
m_k\beta_k\to\eta,
\qquad \frac{\log m_k}{\log(1/\beta_k)}\to1,
\qquad 1-e^{-c m_k\beta_k}\to1-e^{-c\eta}<1. \tag{21}
$$

Hence the cap in (15) is eventually inactive. Since $0\le h\le\log2$,

$$
\frac{U_{m_k}(c\beta_k)}{\beta_k\log(1/\beta_k)}
\longrightarrow\frac{1-e^{-c\eta}}\eta. \tag{22}
$$

Choose

$$
\ell_k=\max\left\{2,\left\lfloor
\frac{d_k}{[\log(d_k+2)]^2}\right\rfloor\right\}. \tag{23}
$$

Then $\ell_k/d_k\to0$ and $\log\ell_k/\log(1/\beta_k)\to1$: the unfloored expression tends to infinity, its ratio to $d_k$ tends to zero, and subtracting $2\log\log(d_k+2)$ from $\log d_k$ changes that logarithm by a lower-order term. For each fixed $c>0$, (18) gives

$$
\frac{L(c\beta_k,d_k,\ell_k)}{\beta_k\log(1/\beta_k)}
\longrightarrow\frac{1-e^{-c\eta}}\eta. \tag{24}
$$

Apply (22) and (24) with $c=1$ to (19). This proves (5) for every fixed error level. At $\varepsilon=0$, hard codes also meet average energy, and the average upper envelope uses the same $c=1$; this proves (4) at zero error limit.

For $\varepsilon>0$, the average-energy upper bound uses $c=1/(1-\varepsilon)$. For each fixed $q\in(1-\varepsilon,1]$, (20) and (24) give the lower limiting coefficient $(1-e^{-\eta/q})/\eta$. Let $q\downarrow1-\varepsilon$. Continuity makes this lower bound match the upper bound. This finishes the proof of Theorem 3. $\square$

The proof does not interchange the coding-length and wideband limits. The finite-length certificate remains available for other joint regimes, but any such extension would require separate quantitative conditions on the number of windows and the rate gap.

## 9. Interpretation and an algebraic feedback comparison

**Proposition 14 (coefficient comparison).** Define

$$
a_0(\eta)=\frac{1-e^{-\eta}}\eta,
\quad a_{\varepsilon}(\eta)=\frac{1-e^{-\eta/(1-\varepsilon)}}\eta,
\quad b(\eta)=\min\{1,1/\eta\}.
$$

For every $\eta>0$ and $0<\varepsilon<1$, $a_{\varepsilon}(\eta)>a_0(\eta)$. Also

$$
\frac{b(\eta)}{a_0(\eta)}
=\frac{\min\{\eta,1\}}{1-e^{-\eta}}>1, \tag{25}
$$

and this ratio has its unique maximum at $\eta=1$, with value $(1-e^{-1})^{-1}$.

*Proof.* Strict increase of $1-e^{-x}$ gives the first assertion. If $0<\eta\le1$, then $1-e^{-\eta}<\eta$; if $\eta\ge1$, then $1-e^{-\eta}<1$. This proves strictness in (25). Below one, the derivative of $\eta/(1-e^{-\eta})$ has numerator $1-(1+\eta)e^{-\eta}>0$, since $e^{\eta}>1+\eta$. Above one, $1/(1-e^{-\eta})$ is strictly decreasing. $\square$

The operational interpretation of $b$ as the vanishing-error feedback coefficient is the already established theorem [W20, Proposition 6 and Remark 3]. Proposition 14 is an algebraic comparison with that cited benchmark; we do not claim a new feedback coding theorem. The distinction between this imported benchmark and the new no-feedback capacity theorem is retained in the formalization coverage ledger.

At $\eta=1$, the proven no-feedback coefficient is $1-e^{-1}$, while the cited feedback coefficient is one. Permitting error changes the average-energy coefficient to $1-e^{-1/(1-\varepsilon)}$, but does not change the hard-energy leading coefficient. This is a statement about fixed-error average-error capacity, not a recommendation to deliberately lose messages in an application with different reliability requirements.

## 10. Verification, limits, and formalization scope

The analytical proof is valid for the complete code classes in Section 2. Finite exact checks in the accompanying code enumerate raw arrival paths, compare the two detector recursions, and verify window domination, guard clearing, periodic-pulse equality, and output counts. Numerical tables compare (18) and (15) along representative wideband sequences. These checks are diagnostics and do not replace the quantified arguments above.

The result assumes zero dark current, a known fixed integer dead time at each coding problem, initially ready detection, no feedback, and no peak-amplitude constraint. It does not determine exact finite-parameter capacity, a second-order term, positive-background capacity, maximal-error capacity, or the fixed-error capacity with feedback. It makes no uniform claim when $\varepsilon$ tends to one, when $\eta$ tends to zero or infinity, or when coding length and dead time grow together without additional conditions. The independent-seed upper-bound observation is not needed for the main code construction.

Full formalization must cover Definitions 1–2, Theorem 3, Lemmas 4 and 6–8, Proposition 5, Theorem 9, Corollary 10, Lemmas 11–13, the limiting estimates (21)–(24), Proposition 14, all results in Sections 11–14, and Appendix A. The derivative and endpoint facts in (9)–(15), zero-energy case, arbitrary-length padding, and deterministic-codebook extraction are necessary dependencies. PPM achievability and concentration are proved here and may not be replaced by new axioms. Proposition 14 formalizes the displayed coefficient functions; the independently cited feedback-capacity theorem is attributed background, outside our newly proved no-feedback theorem. No Lean source or kernel result is supplied in this delivery, and the later full obligation is retained.

## 11. A general finite-burst envelope law

Fix a Borel function $p:[0,\infty)\to[0,1]$ with $p(0)=0$, independent of $\beta,d$. Replace (1) by independent $Z_i\sim\operatorname{Bernoulli}(p(x_i))$ conditional on the full input, and keep both recursions (2). Here a raw event means a trigger; the paralyzable clock resets on raw triggers, not on other unobserved physical events. All code, energy and limit conventions in Section 2 remain unchanged. No monotonicity, differentiability, positive-energy continuity or strict positivity is assumed for $p$.

**Definition 15 (burst response and cost envelope).** For $E\ge0$, let

$$
Q(E)=\sup_{k\ge1,\ x_j\ge0,\ \sum_jx_j\le E}
\left[1-\prod_{j=1}^k(1-p(x_j))\right]. \tag{26}
$$

Define

$$
G(E)=\sup\left\{\sum_{a=1}^r\theta_aQ(E_a):\ r\in\mathbb N_{\ge1},\
\theta_a\ge0,\ \sum_a\theta_a=1,\ E_a\ge0,\ \sum_a\theta_aE_a\le E\right\}. \tag{27}
$$

All patterns and mixtures in these suprema are finite. Attainment is not assumed. In particular, $G$ is not defined by taking an upper-semicontinuous closure at zero.

**Lemma 16 (envelope structure and two-burst approximation).** Both $Q$ and $G$ are nondecreasing, take values in $[0,1]$, and vanish at zero. The function $G$ is concave and continuous at every $E>0$. It is the least nondecreasing concave majorant of $Q$ on $[0,\infty)$. For every $E\ge0$ and $\xi>0$, a mixture of at most two actual finite burst patterns has mean cost at most $E$ and mean trigger success at least $G(E)-\xi$.

*Proof.* Budget inclusion proves monotonicity. Zero budget permits only zero inputs, giving the endpoint. Concatenating two finite mixtures with weights $\lambda$ and $1-\lambda$, and approaching their suprema, proves concavity. A finite concave function is continuous on the interior of its interval: the inequalities between the secant slopes on $a \lt x \lt y \lt b$ bound each interior increment between the two finite outside secants. Applying this on a small closed interval around any positive point gives local continuity. If $H$ is a nondecreasing concave majorant of $Q$, finite Jensen gives $\sum\theta_aQ(E_a)\le H(\sum\theta_aE_a)\le H(E)$, proving minimality.

Choose a finite mixture in (27) within $\xi/2$ of its supremum and, for every positive weight, an actual finite pattern within $\xi/2$ of its $Q(E_a)$. Its actual cost $A_a$ is at most $E_a$ and response is $q_a$. If at least three weights are positive, there is a nonzero vector $v$ on their support with $\sum v_a=\sum A_av_a=0$. Choose its sign so that $\sum q_av_a\ge0$. Since $v$ has both signs, increase the weights along $v$ until the first weight with negative direction reaches zero. This preserves total weight and cost, does not decrease response, and removes a support point. Iteration leaves at most two. The suprema are nonempty because the zero pattern is available. $\square$

**Theorem 17 (general fixed-error envelope law).** For this fixed response $p$, either detector, every fixed $0\le\varepsilon<1$ and every positive sequence $\beta_k\to0$, $d_k\beta_k\to\eta\in(0,\infty)$ with integers $d_k\ge0$,

$$
\frac{C^{\rm hard,p}_{\varepsilon,s}(\beta_k,d_k)}{\beta_k\log(1/\beta_k)}
\longrightarrow\frac{G(\eta)}\eta,
\qquad
\frac{C^{\rm av,p}_{\varepsilon,s}(\beta_k,d_k)}{\beta_k\log(1/\beta_k)}
\longrightarrow\frac{G(\eta/(1-\varepsilon))}\eta. \tag{28}
$$

The channel response itself does not vary along the sequence. No monotonicity of the sequence is required.

### 11.1. General converse, including saturation

**Lemma 18 (general finite-parameter envelopes).** Put

$$
U_m^p(b)=\frac1mF_m\left(\min\{G(mb),u_m^*\}\right). \tag{29}
$$

For every positive $\beta$, the bounds (16) hold with $U_m^p$ replacing $U_m$. The finite-success certificate (13) holds with $t=G(mb)+\delta$ whenever $t\le u_m^*$; the energy-free certificate (14) is unchanged. At zero budget both capacities are zero.

*Proof.* The pathwise part of Lemma 4 is independent of the response law. Given an input with total cost at most $nb$, raw-window indicators remain independent, and their mean sum is at most

$$
\sum_r Q(A_r)\le\sum_rG(A_r)
\le BG\left(\frac{\sum_rA_r}{B}\right)
\le BG(mb). \tag{30}
$$

This uses only finite Jensen, so no measurability assertion about a supremum is needed for this step; in fact $Q,G$ are monotone and hence Borel. Appendix A and the same three-event split prove the certificate. At positive $b$, $G(mb)$ and (29) are continuous by Lemma 16. The rate-gap proof of Corollary 10 therefore applies unchanged. If $G(mb)\ge u_m^*$, use (14), without selecting a nonexistent positive concentration margin. Zero budget forces zero input, and $p(0)=0$ forces zero output. $\square$

For fixed $c>0$, $G(c m_k\beta_k)\to G(c\eta)$. If the limit is below one, the cap in (29) is eventually inactive; if it is one, both entries in that minimum tend to one. Since $h\le\log2$, in either case

$$
\frac{U_{m_k}^p(c\beta_k)}{\beta_k\log(1/\beta_k)}
\longrightarrow\frac{G(c\eta)}\eta. \tag{31}
$$

### 11.2. Finite patterns and deterministic schedules

**Lemma 19 (scheduled burst-position codes).** Fix finitely many finite patterns of costs $A_a$ and trigger responses $q_a$, with mixture weights $\theta_a$. Put $\bar A=\sum\theta_aA_a$ and $\bar q=\sum\theta_aq_a$. If $\bar A \lt c\eta$ for fixed $c>0$, then along the sequence in Theorem 17,

$$
\liminf_k\frac{C^{\rm hard,p}_{0,s}(c\beta_k,d_k)}{\beta_k\log(1/\beta_k)}
\ge\frac{\bar q}{\eta}. \tag{32}
$$

*Proof.* Pad every pattern with zeros to a common finite width $w\ge1$, which does not alter cost or response. Set

$$
\ell_d=\max\left\{2,\left\lfloor\frac{d}{w[\log(d+2)]^2}\right\rfloor\right\},
\qquad T_d=d+w\ell_d. \tag{33}
$$

For all sufficiently large $d$, the active region of length $w\ell_d$ is at most $d$. A frame places its chosen pattern in one of $\ell_d$ disjoint width-$w$ cells in that region, with zero inputs elsewhere and $d$ final guard slots. At least one raw trigger gives exactly one recorded trigger: the first trigger is recorded, all later triggers in the active region are within its next $d$ slots, and the guards clear both clocks. The recorded position identifies the chosen cell even when its offset inside the pattern varies. Thus the receiver can discard that offset and obtain an $\ell_d$-ary erasure symbol, retained with probability $q_a$.

At fixed $d$, use $N_a=\lfloor N\theta_a\rfloor$ frames of type $a$ in a predetermined schedule known to both parties; remaining frames use the zero pattern. Every codeword has the identical cost $\sum N_aA_a\le N\bar A$. Since $c\beta_kT_{d_k}\to c\eta>\bar A$, the hard budget holds eventually, at every $N$. The erased/retained indicators are independent, have position-independent probabilities, and their mean retention fraction $\bar q_N$ tends to $\bar q$ as $N\to\infty$.

Draw length-$N$ position words independently and uniformly. The proof of Lemma 12 works for these nonidentical independent erasures: Appendix A gives a lower-tail bound around $N\bar q_N$, and a competing word matches the $K$ retained cells with probability $\ell_d^{-K}$. Every rate below $\bar q\log\ell_d/T_d$ is therefore achievable with vanishing average error. A deterministic good codebook preserves the common hard cost. Zero-retention frames supply no retained symbol and cause no difficulty in this argument. Padding $\lfloor n/T_d\rfloor$ frames extends to arbitrary lengths without increasing energy per available slot. If $\bar q=0$, the asserted zero lower bound uses the one-message code.

Finally $T_{d_k}/d_k\to1$ and $\log\ell_{d_k}/\log(1/\beta_k)\to1$, giving (32). Width, mixture and accuracy are fixed before $k\to\infty$; no bounded-width optimizer is assumed. $\square$

*Completion of Theorem 17.* For hard energy, choose any $0 \lt E<\eta$ and $\xi>0$. Lemma 16 gives at most two finite patterns with mean cost at most $E$ and response at least $G(E)-\xi$. Lemma 19 with $c=1$ gives that lower coefficient. Let $\xi\downarrow0$ and then $E\uparrow\eta$; interior continuity gives $G(\eta)/\eta$. Lemma 18 and (31) give the matching upper bound, for every fixed error level. At $\varepsilon=0$, these codes also satisfy average energy.

At positive $\varepsilon$, apply Lemma 13 to hard codes at budget $\beta/q$ for each $q\in(1-\varepsilon,1]$. Lemma 19 with $c=1/q$, followed by $E\uparrow\eta/q$, gives $G(\eta/q)/\eta$. Sending $q\downarrow1-\varepsilon$ and using continuity at that positive argument matches (31). This proves (28), without assuming a supremum is attained and without interchanging the two channel limits. $\square$

## 12. Poisson responses and photon-count thresholds

**Proposition 20 (Poisson specialization).** For $p(x)=1-e^{-x}$, one has $Q(E)=G(E)=1-e^{-E}$. Thus Theorem 17 reproduces every coefficient in Theorem 3.

*Proof.* A finite burst has response $1-e^{-\sum x_j}$; concentrating the budget in one slot attains $1-e^{-E}$. This response is already nondecreasing and concave. Apply Lemma 16. $\square$

A threshold example reveals why the second optimization in (27) is needed. This is a specified mathematical trigger model: an independent Poisson count is drawn in each input slot and the raw trigger is whether that count reaches $r$. For the paralyzable mechanism, only these threshold triggers reset the clock; subthreshold photons do not. We make no claim that this models every physical threshold detector.

**Proposition 21 (complete threshold envelope).** For an integer $r\ge2$, set

$$
p_r(x)=1-e^{-x}\sum_{j=0}^{r-1}\frac{x^j}{j!}. \tag{34}
$$

Then $Q_r(E)=p_r(E)$. There is a unique $\tau_r>r-1$ solving $\tau_rp'_r(\tau_r)=p_r(\tau_r)$, and

$$
G_r(E)=\begin{cases}
\displaystyle E\,\frac{p_r(\tau_r)}{\tau_r},&0\le E\le\tau_r,\\
p_r(E),&E\ge\tau_r.
\end{cases} \tag{35}
$$

For every $0 \lt E<\tau_r$, $G_r(E)>Q_r(E)$: time sharing between a pulse of energy $\tau_r$ and silence strictly improves the leading coefficient over a constant-energy burst at energy $E$. When $\eta/(1-\varepsilon)\le\tau_r$, the average-energy coefficient is $p_r(\tau_r)/[\tau_r(1-\varepsilon)]$, whereas the hard-energy coefficient is $p_r(\tau_r)/\tau_r$.

*Proof.* For a partition of total energy $A$, couple independent Poisson counts with means equal to its components. The event that some component count is at least $r$ is contained in the event that their sum is at least $r$. The sum is Poisson with mean $A$, so the burst response is at most $p_r(A)\le p_r(E)$. The Poisson-sum identity follows directly by multiplying $e^{-x}x^j/j!$ and using the multinomial theorem. A single pulse of energy $E$ attains the bound.

Differentiate to obtain $p'_r(x)=e^{-x}x^{r-1}/(r-1)!$ and, for $x>0$, $p''_r(x)=e^{-x}x^{r-2}(r-1-x)/(r-1)!$. Let $f(x)=xp'_r(x)-p_r(x)$. It starts at zero, increases strictly on $(0,r-1)$, decreases strictly after $r-1$, and tends to $-1$. Hence it has exactly one positive root $\tau_r>r-1$. The ratio $p_r(x)/x$ increases strictly up to that root and decreases strictly afterward, because its derivative is $f(x)/x^2$.

The right side of (35) dominates $p_r$, is nondecreasing, and is concave: the linear branch has slope $p_r(\tau_r)/\tau_r=p'_r(\tau_r)$, while the other branch is concave because $x\ge\tau_r>r-1$. Thus it majorizes $G_r$ by Lemma 16. Conversely the linear branch is attained by a mixture with weight $E/\tau_r$ at energy $\tau_r$ and the remainder at zero; the nonlinear branch is attained by a single pulse. This proves equality. Strict increase of the ratio below $\tau_r$ proves the strict gap. Substitution into (28) gives the stated coefficients. $\square$

For $r=2$, the positive root solves $e^{\tau}=1+\tau+\tau^2$; its numerical value is a reproducible illustration, not a premise of the result. The threshold family differs from the Poisson detector: equal cost in every frame is no longer first-order optimal at small energy per dead-time period.

## 13. Fragmentation and endpoint discontinuity

**Proposition 22 (sublinear Weibull response).** For fixed $0<\alpha<1$ and $p_\alpha(x)=1-e^{-x^\alpha}$,

$$
Q_\alpha(E)=G_\alpha(E)=1\quad(E>0),\qquad Q_\alpha(0)=G_\alpha(0)=0. \tag{36}
$$

Consequently both energy conventions and every fixed $\varepsilon<1$ have coefficient $1/\eta$. No finite pattern of finite energy attains $Q_\alpha(E)=1$, but finite patterns approach it.

*Proof.* Split energy $E>0$ equally among $k$ slots. Its trigger probability is $1-\exp[-E^\alpha k^{1-\alpha}]$, which tends to one. Every finite pattern has a finite summed exponent and therefore response strictly below one. Zero energy produces no trigger. The resulting step function is nondecreasing and concave on $[0,\infty)$, so it already equals its envelope. Apply Theorem 17. $\square$

This example establishes a strict role for the first optimization in (26): a single pulse at finite positive $E$ has probability less than one, whereas increasingly long finite bursts approach one. It also shows why no continuity or closed-envelope convention may be silently imposed at zero. The response is an explicit mathematical sensitivity example, not an empirical detector calibration. Its pattern width may grow as approximation accuracy improves; the proof fixes each width before taking the dead-time limit.

## 14. What the general characterization does and does not assert

The two envelope operations express different choices. The finite burst allocates a total energy among neighboring slots before the detector can record another event. The cost mixture allocates different burst types to a predetermined schedule across guarded frames. Lemma 16 shows that two burst types suffice for any prescribed approximation accuracy; it does not promise existence of a maximizing finite burst or a closed-form optimizer for an arbitrary Borel response.

The threshold family proves that equal energy per frame can lose a strict leading factor, while the sublinear example proves that forbidding fragmentation can also lose a strict leading factor. In contrast, the Poisson response requires neither optimization beyond a single fixed-energy pulse. These are consequences of an all-code converse, not comparisons restricted to chosen modulation schemes.

The general theorem requires independent raw triggers conditional on the complete non-feedback input, $p(0)=0$, and either fixed-clock recursion (2). It does not cover dark triggers, correlated raw noise, feedback-dependent inputs, random or state-dependent dead times, or a response that itself changes with resolution. It supplies no universal convergence speed: approximating patterns for an irregular response can be long. Positivity of $\eta$ and fixed $\varepsilon<1$ are essential to the stated continuity and limit arguments. The Poisson throughput equality in Proposition 5 remains a separate special-case assertion; no exact finite-length throughput equality is claimed for general $p$.

The formalization ledger includes Definition 15, Lemmas 16, 18 and 19, Theorem 17, Propositions 20–22, the finite-mixture support reduction, the nonidentical-erasure extension, saturation, threshold root uniqueness, the Poisson-sum identity used in Proposition 21, and the nonattainment and endpoint assertions in Proposition 22. They are not optional illustrations if the whole manuscript is later claimed fully formalized.

## Appendix A. The Bernoulli concentration fact used in the proof

**Lemma A.1 (two-sided one-sided-tail bounds).** If $V_1,\ldots,V_B$ are independent Bernoulli variables with possibly different means, then for every $\delta>0$,

$$
\Pr\left\{\sum_r(V_r-\mathbb EV_r)\ge B\delta\right\}
\le e^{-2B\delta^2},
\qquad
\Pr\left\{\sum_r(V_r-\mathbb EV_r)\le-B\delta\right\}
\le e^{-2B\delta^2}. \tag{A1}
$$

*Proof.* For a Bernoulli variable $V$ of mean $p$, let $\psi(t)=\log\mathbb E e^{t(V-p)}$. If $p=0$ or $1$, $\psi=0$. Otherwise $\psi(0)=\psi'(0)=0$, and differentiation gives $\psi''(t)=p_t(1-p_t)\le1/4$, where $p_t=pe^t/(1-p+pe^t)$. Integrating this second-derivative inequality from zero, for either sign of $t$, gives $\psi(t)\le t^2/8$. Independence and exponential Markov's inequality imply, for $t>0$,

$$
\Pr\{\textstyle\sum_r(V_r-\mathbb EV_r)\ge B\delta\}
\le\exp(-tB\delta+Bt^2/8).
$$

Set $t=4\delta$. Replacing every $V_r$ by $1-V_r$ gives the lower tail. This is the classical bounded-Bernoulli Hoeffding argument, included to specify all concentration assumptions. $\square$

## References

- **[W20]** Ligong Wang. *Asymptotic Capacity Results on the Discrete-Time Poisson Channel and the Noiseless Binary Channel with Detector Dead Time*. Entropy **22**(8), 846 (2020). [DOI: 10.3390/e22080846](https://doi.org/10.3390/e22080846). Inspected publisher full text, especially Section 3, Propositions 6–7, Remarks 2–3 and Section 4.
- **[WW14]** Ligong Wang and Gregory W. Wornell. *A Refined Analysis of the Poisson Channel in the High-Photon-Efficiency Regime*. IEEE Transactions on Information Theory **60**(7), 4299–4311 (2014). [DOI: 10.1109/TIT.2014.2320718](https://doi.org/10.1109/TIT.2014.2320718). [Author-hosted published text](https://sia.mit.edu/wp-content/uploads/2015/04/2014-wang-wornell-it.pdf).
- **[YCDP15]** Wei Yang, Giuseppe Caire, Giuseppe Durisi and Yury Polyanskiy. *Optimum Power Control at Finite Blocklength*. IEEE Transactions on Information Theory **61**(9), 4598–4615 (2015). [DOI: 10.1109/TIT.2015.2456175](https://doi.org/10.1109/TIT.2015.2456175). [Author-hosted manuscript](https://people.lids.mit.edu/yp/homepage/data/opt_powercontrol.pdf).

- **[V90]** Sergio Verdú. *On Channel Capacity per Unit Cost*. IEEE Transactions on Information Theory **36**(5), 1019–1030 (1990). [DOI: 10.1109/18.57201](https://doi.org/10.1109/18.57201). [MIT-hosted published text](https://web.mit.edu/6.441/www/reading/verdu_unitcost.pdf). The inspected original abstract specifies the memoryless model; no general-memory theorem is inferred from it.
- **[MH03]** Bruce Moision and Jon Hamkins. *Deep-Space Optical Communications Downlink Budget: Modulation and Coding*. IPN Progress Report **42-154** (2003). [JPL original text](https://ipnpr.jpl.nasa.gov/progress_report/42-154/154K.pdf), especially Section II.D on time sharing and transmitter dead time.

The accompanying source register and novelty audit contain additional inspected neighboring models and retrieval limitations. No uninspected source is used as a premise of the proof.
