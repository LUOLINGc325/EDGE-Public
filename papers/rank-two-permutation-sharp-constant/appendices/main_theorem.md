# Exact fixed-error laws for rank-two noisy permutation channels

## Abstract

Consider a finite discrete memoryless channel with strictly positive transition probabilities, followed by an independent uniform permutation of all output symbols. We determine the exact asymptotic transmission error at every message-count scale for every channel whose transition matrix has rank two. The channel-dependent constant is an intrinsic length formed from the covariance of fixed-composition inputs. If the message count divided by the square root of blocklength converges to \(c>0\), the optimal average and maximal error probabilities both converge to \(2Q(L/(2c))\), where \(Q\) is the standard normal upper tail and \(L\) is that length. Consequently the optimal message count at fixed error \(\epsilon\) is asymptotic to \(L\sqrt n/[2\Phi^{-1}(1-\epsilon/2)]\).

The proof combines exact endpoint-input reduction, a uniform discrete Gaussian approximation, an arbitrary-code converse obtained by localization, and a deterministic decoder based on a one-step generalized least-squares estimate. We also characterize the limiting composition distribution of asymptotically optimal endpoint codebooks. Earlier noisy-permutation results establish the polynomial exponent or distinct constant-order bounds; we retain those attributions and address the matching constant for the complete rank-two class.

**Status.** Research manuscript with written proofs. External results are explicitly identified. No claim in this text is labeled Lean-verified. The accompanying workflow record controls internal review, novelty, value and release status.

## 1. Model and main theorem

Let \(W\) be a row-stochastic matrix on finite input alphabet \(X\) and output alphabet \(Y\), with \(|Y|=m\ge2\). Assume \(W(y\mid x)>0\) for every pair and \(\operatorname{rank}W=2\). A length-\(n\) input word is passed through \(W\) independently at its \(n\) coordinates. The output word is then uniformly permuted, independently of the input and channel noise. We study ordinary message transmission, not message identification.

An \(M\)-message code uses equiprobable messages. Its encoder may choose a deterministic input word or use private randomization. Its decoder may be deterministic or privately randomized, with no shared random seed between sender and receiver. Write \(e_{\rm av}(n,M)\) and \(e_{\max}(n,M)\) for the infimum of average and maximal error, respectively, over the chosen class. All asymptotic statements below hold both for deterministic codes and for the larger privately randomized class. Allowing an erasure output makes no difference to the statements.

Since all rows sum to one, their affine dimension is \(\operatorname{rank}W-1=1\). Their convex hull is a nondegenerate segment with two endpoint rows \(p_0\) and \(p_1\). These endpoints are actual rows of \(W\). Choose an ordering of them and put \(p_t=(1-t)p_0+tp_1\) for \(0\le t\le1\).

For vectors in \(\mathbb R^m\), a superscript minus denotes deletion of the last coordinate. Define

\[
 r=m-1,\qquad u=p_1^- -p_0^-,\qquad
 C(p)=\operatorname{diag}(p^-)-p^-(p^-)^\top,
\]

\[
 V(t)=(1-t)C(p_0)+tC(p_1),\qquad
 J(t)=u^\top V(t)^{-1}u,\qquad
 H(t)=\int_0^t\sqrt{J(s)}\,ds,\qquad L=H(1).
 \tag{1}
\]

Each \(C(p_i)\) is positive definite: it is the covariance of a random vector taking values \(0,e_1,\ldots,e_r\) with strictly positive probabilities. A nonzero linear functional of those values cannot be constant. Compactness therefore supplies constants \(0<\nu\le\Lambda<\infty\) such that \(\nu I\preceq V(t)\preceq\Lambda I\) for all \(t\). Also \(u\ne0\). Thus \(J\) is smooth and strictly positive, and \(0<L<\infty\).

Let \(\Phi\) denote the standard normal cumulative distribution function and \(Q=1-\Phi\). Set

\[
 \mathcal E_L(c)=
 \begin{cases}
 0,&c=0,\\
 2Q(L/(2c)),&0<c<\infty,\\
 1,&c=\infty.
 \end{cases}
 \tag{2}
\]

### Theorem 1. Complete error curve

For every sequence of positive integers \(M_n\) with \(M_n/\sqrt n\to c\in[0,\infty]\),

\[
 \lim_{n\to\infty}e_{\rm av}(n,M_n)
 =\lim_{n\to\infty}e_{\rm max}(n,M_n)
 =\mathcal E_L(c).
 \tag{3}
\]

The same limits hold when the code class is restricted to deterministic encoders and deterministic decoders depending only on the output count vector.

### Corollary 1. Sharp fixed-error message count

For every fixed \(\epsilon\in(0,1)\), let \(M_{\rm av}^*(n,\epsilon)\) and \(M_{\max}^*(n,\epsilon)\) be the largest feasible message counts under the two error criteria. Then

\[
 \lim_{n\to\infty}\frac{M_{\rm av}^*(n,\epsilon)}{\sqrt n}
 =\lim_{n\to\infty}\frac{M_{\rm max}^*(n,\epsilon)}{\sqrt n}
 =\frac{L}{2\Phi^{-1}(1-\epsilon/2)}.
 \tag{4}
\]

Equivalently, for either criterion and logarithms to base two,

\[
 \log_2 M^*(n,\epsilon)
 =\tfrac12\log_2 n+
 \log_2\!\left(\frac{L}{2\Phi^{-1}(1-\epsilon/2)}\right)+o(1).
 \tag{5}
\]

The theorem concerns every fixed strictly positive rank-two channel and every fixed \(\epsilon\in(0,1)\). It does not assert a uniform limit as channel entries vanish, as rank changes, or as \(\epsilon\) tends to zero with \(n\). It does not solve higher-dimensional Gaussian packing.

## 2. Exact finite-block reductions

### Lemma 1. Endpoint input symbols suffice

Fix \(n,M\) and any decoder, including any privately randomized decoder of the full permuted output word. Every encoder on \(X\) can be replaced by a deterministic encoder using only the two endpoint input symbols, without decreasing the success probability of any message.

**Proof.** Every row \(W(\cdot\mid x)\) has the form \((1-t_x)p_0+t_xp_1\). Replace one occurrence of \(x\) by an independent endpoint-symbol draw with probabilities \(1-t_x\) and \(t_x\). Before permutation, its output distribution is exactly \(W(\cdot\mid x)\). Applying this independently in all coordinates reproduces the entire original product output law, and applying the same permutation channel preserves equality. A privately randomized original encoder is handled by mixing over its input words first.

For a fixed message and the fixed decoder, the success probability is therefore a convex combination of the success probabilities of finitely many endpoint words. Choose an endpoint word attaining at least that average. Do this separately for every message. This changes only the encoder and requires no common randomness. Each message's error does not increase, which proves both the average-error and maximal-error claims. The argument does not require the encoding map to be injective. Standard channel codes are mappings from messages to words; repeated effective output types are allowed. QED.

An endpoint word is characterized, as a statistical experiment, by the number \(w\) of \(p_1\)-symbols it contains. Write \(t=w/n\). Let \(S_{n,w}\) be the vector of counts of the first \(r\) output symbols. Before permutation these counts are sums of \(n-w\) independent categorical vectors of law \(p_0\) and \(w\) of law \(p_1\). Permutation does not change counts. Hence

\[
 \mathbb E S_{n,w}=n p_t^-,\qquad
 \operatorname{Cov}(S_{n,w})=nV(t).
 \tag{6}
\]

**Count sufficiency and the randomization distinction.** Conditional on a feasible full output count vector, the uniformly permuted output word is uniform on the corresponding type class, independently of the transmitted message. Any full-output decision rule can consequently be replaced by a randomized rule on counts with exactly the same success probability for every message. For average error, a pointwise maximum-likelihood rule on counts is optimal and deterministic. For deterministic maximal-error rules, the observed order can supply ancillary randomness; we do not assert a finite-n deterministic count-sufficiency theorem. The converse below permits randomized count rules. The construction below is deterministic from counts. These two facts establish the asserted asymptotic equality without making the stronger, unnecessary finite-n claim.

### Lemma 2. Uniform rounded-Gaussian transfer

Let \(G_{n,w}\) have normal law \(N(np_t^-,nV(t))\), and round each coordinate to its nearest integer. There is a sequence \(\delta_n\to0\), depending only on \(W\), for which

\[
 \sup_{0\le w\le n}d_{\rm TV}
 \bigl(\mathcal L(S_{n,w}),\mathcal L(\operatorname{round}G_{n,w})\bigr)
 \le\delta_n.
 \tag{7}
\]

One may take \(\delta_n=O_W(n^{-1/20})\).

**Proof.** \(S_{n,w}\) is a generalized multinomial distribution, obtained by dropping one coordinate of a sum of independent categorical vectors. Theorem 1 of Daskalakis, De, Kamath and Tzamos [DDKT16] bounds its total-variation distance from the coordinatewise rounded Gaussian with the same mean and covariance by \(Cm^{7/2}/\sigma^{1/10}\), where \(\sigma^2\) is the smallest eigenvalue of its covariance. Equation (6) and \(V(t)\succeq\nu I\) give \(\sigma^2\ge n\nu\) uniformly, including \(w=0,n\). This proves (7) and the displayed rate. This is an explicitly cited external theorem; we do not present it as new. QED.

For any count decoder, extend it to all integer vectors arbitrarily and apply it to a continuous Gaussian after rounding. Its individual success probabilities change by at most \(\delta_n\). In a converse, the optimal success using rounded Gaussians is no larger than the optimal success using the continuous Gaussians themselves, because rounding is a fixed postprocessing. No assertion that a discrete and a continuous distribution are close in total variation is needed.

We shall also use a scalar consequence. For any bounded vector family \(a(t)\) for which \(a(t)^\top V(t)a(t)\) is bounded away from zero, Gaussian transfer and bounded rounding error imply a uniform normal approximation for \(a(t)^\top(S_{n,w}-np_t^-)/\sqrt n\). After normalization to unit variance, its distribution function differs from \(\Phi\) by at most \(\delta_n+O_W(n^{-1/2})\). Indeed, rounding changes \(a(t)^\top G\) by at most \(\|a(t)\|_1/2\), and a one-dimensional normal density with variance of order \(n\) assigns \(O_W(n^{-1/2})\) mass to an interval of that bounded length.

## 3. Gaussian packing and an arbitrary-code converse

### Lemma 3. Exact one-dimensional Gaussian packing

Put \(f(x)=2\Phi(x/2)-1\) for \(x\ge0\). For \(M\) equiprobable unit-variance normal distributions with ordered means \(x_1\le\cdots\le x_M\), the optimal sum of individual success probabilities is

\[
 1+\sum_{i=1}^{M-1} f(x_{i+1}-x_i).
 \tag{8}
\]

If all means lie in an interval of length \(T\), this sum is at most

\[
 1+(M-1)f\!\left(\frac{T}{M-1}\right),\qquad M\ge2.
 \tag{9}
\]

For \(M=1\) the sum is one. The same statement holds for multivariate normal means lying on a line with a common positive-definite covariance, when \(T\) is measured in that covariance's Mahalanobis metric.

**Proof.** The optimal uniform-prior success sum is the integral of the maximum of the \(M\) normal densities. Nearest-mean decoding partitions the real line at consecutive midpoints. Integrating the two outside tails and the interior intervals yields (8). This remains valid when some means coincide: coincident densities contribute no additional envelope area, and the corresponding gap has \(f(0)=0\). Now \(f'(x)=\phi(x/2)>0\) and \(f''(x)=-x\phi(x/2)/4\le0\). Jensen's inequality and \(\sum_i(x_{i+1}-x_i)\le T\) prove (9), attained by equally spaced means spanning the interval. For multivariate normals, whiten the covariance and project on the mean line. The orthogonal component is an independent common normal law, whose density integrates to one. QED.

The covariance varies with the composition, but on a short fixed interval it can be frozen uniformly. In fact, if \(|t-s|\le h\),

\[
 d_{\rm TV}\bigl(N(np_t^-,nV(t)),N(np_t^-,nV(s))\bigr)
 \le C_W h.
 \tag{10}
\]

Here is a direct justification. Translation and scaling reduce the claim to centered normals of covariances \(A=V(s)\) and \(A+\Delta=V(t)\). Along \(A_v=A+v\Delta\), the derivative of the normal density is that density times

\[
 -\tfrac12\operatorname{tr}(A_v^{-1}\Delta)
 +\tfrac12 x^\top A_v^{-1}\Delta A_v^{-1}x.
\]

The integral of its absolute value is at most a constant times \(\|\Delta\|\), using \(\nu I\preceq A_v\preceq\Lambda I\) and the bounded second moment of the centered normal. Integrating over \(0\le v\le1\), and using the affine dependence of \(V\) on \(t\), proves (10).

Consider any code. Apply Lemma 1 and then count symmetrization. Its average success is no greater than the largest success of the resulting endpoint experiment with randomized count decisions. Partition \([0,1]\) into \(B\) intervals of length \(h=1/B\), using any consistent convention for their boundaries, and let \(c_j\) be their midpoints. The number \(B\) is fixed while \(n\) tends to infinity. Let \(m_j\) be the number of message types in interval \(j\), and let \(b\le B\) count its nonempty intervals.

Lemma 2 transfers the count decision to rounded Gaussians with average loss at most \(\delta_n\). Observing the continuous Gaussian can only improve success. Freeze the covariance within bin \(j\) at \(nV(c_j)\), with further average loss at most \(C_Wh\) by (10). Ignore competition between different bins. Within bin \(j\), the means lie on a line segment of standardized length

\[
 T_j=\sqrt n\,h\sqrt{J(c_j)},\qquad
 L_B=\sum_{j=1}^B h\sqrt{J(c_j)}.
\]

For a nonempty bin put \(k_j=m_j-1\). Lemma 3 bounds its success sum by \(1+k_j f(T_j/k_j)\), with a zero contribution from the second term if \(k_j=0\). Concavity gives, when \(M>b\),

\[
 \sum_{j:k_j>0} k_j f(T_j/k_j)
 \le (M-b)f\!\left(\frac{\sum_{j:k_j>0}T_j}{M-b}\right)
 \le (M-b)f\!\left(\frac{\sqrt nL_B}{M-b}\right).
\]

Consequently the average success probability \(P_{\rm s,av}\) of every original code satisfies

\[
 P_{\rm s,av}\le
 \frac{b+(M-b)f(\sqrt nL_B/(M-b))}{M}
 +\delta_n+C_Wh.
 \tag{11}
\]

When \(M=b\), define the entire term \((M-b)f(\sqrt nL_B/(M-b))\) to be zero; (11) then reduces to the trivial bound \(P_{\rm s,av}\le1+\delta_n+C_Wh\). This argument permits coincident message types, arbitrary spacing, arbitrary original input symbols, private randomization at either end, and full-word decoders. For each bin, the sum of decision probabilities assigned to its messages is at most one; maximizing that sum separately is exactly why ignoring cross-bin competition supplies an upper bound.

If \(M_n/\sqrt n\to c\in(0,\infty)\), first let \(n\to\infty\) in (11). Since \(b\le B\), uniformly \(b/M_n\to0\), so this bound applies also to a sequence of optimizing codes. The limiting optimal success is at most \(f(L_B/c)+C_W/B\). Then let \(B\to\infty\). The Riemann sums satisfy \(L_B\to L\), giving

\[
 \liminf_n e_{\rm av}(n,M_n)\ge 1-f(L/c)=\mathcal E_L(c).
 \tag{12}
\]

For \(c=\infty\), the same order of limits gives success tending to zero. For \(c=0\), nonnegativity is the required lower bound. The identical proof applies to any fixed subinterval \([a,b]\subseteq[0,1]\), with length \(H(b)-H(a)\); one partitions that interval and repeats the argument. No uniform normal approximation over a growing partition is being assumed.

## 4. A deterministic decoder attaining maximal error

We construct a scalar estimate with a uniform normal limit in the intrinsic coordinate. Put

\[
 b=\frac{u}{\|u\|^2},\qquad
 a(t)=\frac{V(t)^{-1}u}{J(t)}.
\]

Thus \(b^\top u=a(t)^\top u=1\), and \(a\) is bounded and Lipschitz on \([0,1]\). Given the reduced count vector \(z\), calculate

\[
 \widetilde t=\operatorname{clip}_{[0,1]}
       \bigl(b^\top(z/n-p_0^-)\bigr),\qquad
 \widehat t=\widetilde t+
       a(\widetilde t)^\top(z/n-p_{\widetilde t}^-).
 \tag{13}
\]

Extend \(H\) to \(\mathbb R\) linearly beyond its two endpoints, with slopes \(\sqrt{J(0)}\) and \(\sqrt{J(1)}\). The resulting function, still denoted \(H\), is strictly increasing, continuously differentiable, and has a bounded Lipschitz derivative.

### Lemma 4. Uniform efficient scalar statistic

For \(z=S_{n,w}\) and \(t=w/n\),

\[
 \sup_{0\le w\le n}\sup_{x\in\mathbb R}
 \left|\Pr\{\sqrt n[H(\widehat t)-H(t)]\le x\}-\Phi(x)\right|
 \le\eta_n,\qquad \eta_n\to0.
 \tag{14}
\]

One may use \(\eta_n=\delta_n+O_W(n^{-1/4})\).

**Proof.** Write \(R=z/n-p_t^-\). Projection onto \([0,1]\) is a contraction, so \(|\widetilde t-t|\le\|b\|\|R\|\). The relation \(a(\widetilde t)^\top u=1\) gives the exact cancellation

\[
 \widehat t-t=a(\widetilde t)^\top R
   =a(t)^\top R+O_W(\|R\|^2).
\]

Also \(|\widehat t-t|\le C_W\|R\|\). Taylor's formula for a function with Lipschitz derivative therefore yields

\[
 \sqrt n[H(\widehat t)-H(t)]
 =\sqrt{J(t)}\,a(t)^\top
       \frac{S_{n,w}-np_t^-}{\sqrt n}+Z_{n,w},
 \qquad |Z_{n,w}|\le C_W\sqrt n\|R\|^2.
 \tag{15}
\]

Since \(\mathbb E\|R\|^2=\operatorname{tr}V(t)/n\), the remainder has expected absolute value at most \(C_W/\sqrt n\). The leading term has variance exactly one, because \(J(t)a(t)^\top V(t)a(t)=1\). The scalar consequence of Lemma 2 approximates its distribution function by \(\Phi\), uniformly, with error \(\delta_n+O_W(n^{-1/2})\). Markov's inequality gives \(\Pr(|Z_{n,w}|>n^{-1/4})\le C_W n^{-1/4}\). Sandwiching distribution functions at \(x\pm n^{-1/4}\), and using the bounded normal density, proves (14), including both endpoint types. QED.

For \(M=M_n\ge2\), choose target arc positions

\[
 s_i=\frac{(i-1)L}{M-1},\qquad
 t_i=H^{-1}(s_i),\qquad
 w_i=\operatorname{round}(nt_i),\qquad 1\le i\le M.
 \tag{16}
\]

Transmit an endpoint word of type \(w_i\). Let \(h_i=H(w_i/n)\). Boundedness of \(H'\) implies \(|h_i-s_i|\le K_W/n\), so consecutive actual arc positions are separated by at least

\[
 d_n=\frac{L}{M-1}-\frac{2K_W}{n}.
 \tag{17}
\]

For \(M=O(\sqrt n)\), these types are distinct for all sufficiently large \(n\). Decode by computing \(H(\widehat t)\) from (13) and selecting its nearest actual position \(h_i\), with a fixed deterministic tie rule. A wrong decision requires an absolute transformed deviation of at least \(d_n/2\). At the first and last positions only one erroneous tail exists; using both tails gives a bound valid for every message. Continuity of \(\Phi\), or left limits in (14), handles any atom at a threshold. Hence

\[
 e_{\max}\le 2Q(\sqrt n\,d_n/2)+2\eta_n.
 \tag{18}
\]

For \(M_n/\sqrt n\to c\in(0,\infty)\), (18) tends to \(\mathcal E_L(c)\). For \(c=0\) and \(M_n\ge2\), its normal-tail argument tends to infinity; if \(M_n=1\), use the zero-error one-message code. For \(c=\infty\), the trivial upper bound one suffices. Together with (12) and \(e_{\rm av}\le e_{\max}\), this proves Theorem 1 simultaneously for all stated code classes.

The decoder is explicit. For fixed output alphabet, its online operations consist of accumulating counts, one fixed-dimensional linear solve, scalar evaluations, and nearest-position lookup in a sorted list. Counting costs \(O(n)\) operations and lookup costs \(O(\log M)\). Numerical evaluation of the precomputed monotone coordinate and positions to error \(o(n^{-1/2})\) preserves the asymptotic conclusion. A literal finite-error certification would also track these numerical errors; the analytic theorem does not assume an unverified floating-point guarantee.

**Proof of Corollary 1.** The curve \(\mathcal E_L(c)\) is continuous and strictly increasing from zero to one. Every \(c<L/[2\Phi^{-1}(1-\epsilon/2)]\) is feasible for all sufficiently large \(n\) by (18). If feasible counts exceeded that constant times \(\sqrt n\) by a fixed positive fraction along a subsequence, extract a further subsequence on which the ratio tends to a larger finite limit or infinity. Theorem 1 would force average error strictly above \(\epsilon\), a contradiction. Feasible counts are finite at each \(n\): summing the largest likelihood at each of the finitely many possible outputs bounds \(M(1-\epsilon)\) by the number of those outputs. Thus the maxima exist, and the two ratio limits follow. Taking logarithms proves (5). QED.

## 5. Intrinsic geometry and fixed-composition information

Let \(d=p_1-p_0\), and define the ordinary Fisher information along the categorical mixture segment by

\[
 I(t)=\sum_{y\in Y}\frac{d_y^2}{p_t(y)}.
\]

### Proposition 1. Information identity

\[
 J(t)=\frac{I(t)}{1-t(1-t)I(t)}.
 \tag{19}
\]

In particular, \(L\) is independent of which output coordinate is deleted and of the chosen ordering of the two endpoint rows.

**Proof.** Direct expansion gives

\[
 V(t)=C(p_t)-t(1-t)uu^\top.
\]

The reduced categorical covariance satisfies

\[
 C(p_t)^{-1}
 =\operatorname{diag}(1/p_t^-)
   +\frac{\boldsymbol 1\boldsymbol 1^\top}{p_t(y_m)}.
\]

Because \(\sum_{y<m}d_y=-d_{y_m}\), this implies \(u^\top C(p_t)^{-1}u=I(t)\). The rank-one inverse identity now yields (19). Its denominator is strictly positive: conjugating the positive-definite matrix \(V(t)\) by \(C(p_t)^{-1/2}\) gives an identity matrix minus a matrix of rank at most one, whose sole possible nonzero eigenvalue is \(t(1-t)I(t)<1\). The expression in (19) uses all output coordinates symmetrically. Reversing endpoints substitutes \(1-t\) for \(t\), leaving the integral defining \(L\) unchanged. QED.

This distinction matters operationally. Independently sampling each input endpoint with probability \(t\) gives an iid output sample of law \(p_t\), with count covariance \(nC(p_t)\). A fixed input composition instead has covariance \(nV(t)\); it removes the covariance contributed by the random input composition. For distinct positive endpoints, \(J(t)>I(t)\) at every interior \(t\), so the fixed-composition length is strictly larger than \(\int_0^1\sqrt{I(t)}\,dt\). An iid mixture construction cannot simply substitute its Fisher length for the fixed-composition length in (4). The distinction between these covariances is present in prior work; the matching operational constant here is the claim being made.

For binary output, write the two endpoint probabilities of output one as \(0<a<b<1\), and \(\sigma_a=\sqrt{a(1-a)}\), \(\sigma_b=\sqrt{b(1-b)}\). Direct integration gives

\[
 L=\frac{2(b-a)}{\sigma_a+\sigma_b}.
 \tag{20}
\]

The separate supplement, **A bounded code-size remainder for every positive binary-output channel**, proves the stronger statement

\[
 M^*(n,\epsilon)
 =\frac{b-a}{(\sigma_a+\sigma_b)\Phi^{-1}(1-\epsilon/2)}\sqrt n+O(1)
 \tag{21}
\]

for both error criteria. Its proof uses an exact monotone-likelihood-ratio property and a uniform one-dimensional Berry--Esseen argument. The multivariate localization above, by itself, only proves the \(o(\sqrt n)\) code-size remainder. For a binary symmetric channel of crossover \(p\in(0,1/2)\), (20) becomes \(L=(1-2p)/\sqrt{p(1-p)}\).

## 6. Necessary composition density of optimal endpoint codebooks

### Theorem 2. Density rigidity

Let deterministic endpoint type codebooks \(\{t_{n,i}:1\le i\le M_n\}\) have \(M_n/\sqrt n\to c\in(0,\infty)\), and suppose some decoders achieve average error converging to \(\mathcal E_L(c)\). Then, for every \(t\in[0,1]\),

\[
 \frac{1}{M_n}\#\{i:t_{n,i}\le t\}\longrightarrow\frac{H(t)}L.
 \tag{22}
\]

Thus optimal endpoint codebooks are asymptotically uniform in arc position and have limiting composition density \(\sqrt{J(t)}/L\). The same conclusion holds if their maximal errors converge to the optimal curve. This theorem concerns endpoint codebooks; it does not attach an invariant type density to arbitrary original-alphabet encoders or randomized encoders.

**Proof.** Fix \(0<t<1\), and extract a subsequence along which the fraction \(p_n\) of messages with type at most \(t\) converges to \(p\in[0,1]\). Put \(L_1=H(t)>0\) and \(L_2=L-H(t)>0\). Ignore competition between the two groups, and apply the localized converse from Section 3 to each nonvanishing group. If \(0<p<1\), the limiting average success is at most

\[
 p f\!\left(\frac{L_1}{cp}\right)
 +(1-p)f\!\left(\frac{L_2}{c(1-p)}\right)
 \le f(L/c).
 \tag{23}
\]

The second inequality is strict Jensen unless \(L_1/p=L_2/(1-p)\), because \(f\) is strictly concave on \((0,\infty)\). The assumed optimal success equals \(f(L/c)\); hence \(p=L_1/L\). If \(p=0\), the left group contributes at most its vanishing fraction, while the other group's success is at most \(f(L_2/c)<f(L/c)\), a contradiction. The case \(p=1\) is identical. Every convergent subsequence therefore has the same limit, proving (22) for interior \(t\). The endpoint claims follow from monotonicity and letting \(t\) approach zero or one. If maximal errors approach the curve, average errors are bounded above by them and bounded below asymptotically by Theorem 1, so the same proof applies. QED.

Equation (22) is a distributional necessity. We do not claim that every neighboring gap has an asymptotic limit, or that this density condition alone guarantees optimal error.

## 7. Relation to prior work and exact contribution

Makur [Makur20] develops the noisy-permutation coding model and uses extreme rows of the channel-row convex hull in the proof of Theorem 3, equations (58)--(60). Endpoint reduction is accordingly a classical ingredient. Lemma 1 supplies the finite-block messagewise derandomization argument needed for the exact class of codes used here; it is not asserted as the central novelty. Tang and Polyanskiy [TP23] establish the capacity exponent \((\operatorname{rank}W-1)/2\) for strictly positive channels. Tang's thesis [Tang22, Chapter 5] explicitly discusses a Gaussian-variance approach and the difficulty of multivariate approximation. We use, rather than claim to originate, that statistical perspective.

The finite-block bounds in [Feng24] and [Feng25] address converse and achievability refinements. The inspected v2 of [Feng26] obtains volume-refined achievability and converse expansions with distinct constant terms and explicitly does not claim they match. Its rank-two and binary specializations consequently do not state (3)--(5) or (21). Its iid-output Fisher/Jeffreys volume and its discussion of fixed-type covariance are credited above. Theorem 1 of [DDKT16] supplies the uniform lattice-normal approximation; Lemma 3 is elementary Gaussian packing, and the one-step statistic uses the classical efficient-estimation construction.

Fisher-volume counting and normalized square-root-information densities are classical [CB90, Bal97, MBP00]. Theorem 2 proves a necessity statement for asymptotically optimal endpoint codebooks in this operational model; it does not claim a new geometric prior.

The specific proposed contribution is the matching fixed-error constant and complete optimal error curve for **all strictly positive rank-two channels**, uniformly over message types and valid for arbitrary original encoders and full-output decisions, with equality of average and maximal asymptotic errors. The endpoint density necessity and the binary-output bounded remainder add structural and quantitative conclusions. The claims are scoped to this channel class and transmission criterion. The novelty assessment is based on the primary sources and searches recorded in the accompanying research audit; it is not a proof that no uncatalogued predecessor exists.

## References

- **[Makur20]** A. Makur. *Coding Theorems for Noisy Permutation Channels*. 2020 preprint, arXiv:2007.07507. [Primary source](https://arxiv.org/abs/2007.07507). Extreme-row argument: Theorem 3 proof, equations (58)--(60).
- **[TP23]** J. Tang and Y. Polyanskiy. *Capacity of Noisy Permutation Channels*. IEEE Transactions on Information Theory 69(7), 4145--4162, 2023. [DOI](https://doi.org/10.1109/TIT.2023.3247812). [Author manuscript](https://people.lids.mit.edu/yp/homepage/data/2021_permut_capacity.pdf).
- **[Tang22]** J. Tang. *Divergence Covering*. PhD thesis, Massachusetts Institute of Technology, 2022. Chapter 5, especially the concluding discussion of Gaussian approximation. [Primary source](https://people.lids.mit.edu/yp/homepage/data/theses/2022_PHD_Tang.pdf).
- **[Feng24]** L. Feng, B. Wang, G. Lv, X. Li, L. Wang and Y. Jin. *New Upper Bounds for Noisy Permutation Channels*. arXiv:2406.15031v1, 21 June 2024. [Primary source](https://arxiv.org/abs/2406.15031v1).
- **[Feng25]** L. Feng, G. Lv, X. Li and Y. Jin. *A New Lower Bound for Noisy Permutation Channels via Divergence Packing*. Entropy 27(11), 1101, 2025. [DOI and primary source](https://doi.org/10.3390/e27111101).
- **[Feng26]** L. Feng, G. Lv, X. Li and Y. Jin. *Volume-Refined Achievability and Converse Approximations for Noisy Permutation Channels*. arXiv:2605.25699v2, 14 June 2026. Theorem 4, Remark 6, and Section VII.A. [Versioned primary source](https://arxiv.org/abs/2605.25699v2). The inspected version has this title; the v1 title differs.
- **[DDKT16]** C. Daskalakis, A. De, G. Kamath and C. Tzamos. *A Size-Free CLT for Poisson Multinomials and its Applications*. STOC 2016, DOI 10.1145/2897518.2897519. Theorem 1 in arXiv:1511.03641v2, 16 June 2016. [Versioned primary source](https://arxiv.org/abs/1511.03641v2).
- **[CB90]** B. S. Clarke and A. R. Barron. *Information-theoretic asymptotics of Bayes methods*. IEEE Transactions on Information Theory 36(3), 453--471, 1990. [DOI](https://doi.org/10.1109/18.54897).
- **[Bal97]** V. Balasubramanian. *Statistical Inference, Occam's Razor, and Statistical Mechanics on the Space of Probability Distributions*. Neural Computation 9(2), 349--368, 1997. [DOI](https://doi.org/10.1162/neco.1997.9.2.349). [Author preprint](https://arxiv.org/abs/cond-mat/9601030).
- **[MBP00]** I. J. Myung, V. Balasubramanian and M. A. Pitt. *Counting probability distributions: Differential geometry and model selection*. Proceedings of the National Academy of Sciences 97(21), 11170--11175, 2000. [DOI](https://doi.org/10.1073/pnas.170283897).

