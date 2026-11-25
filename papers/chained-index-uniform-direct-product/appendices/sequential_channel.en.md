# A reusable second-moment bound for sequential fresh-input protocols

Date: 2026-11-25 (Asia/Shanghai). Mathematical proof draft; not yet machine-checked. This proposition isolates the analytic implication used in the Chained Index proof. It makes no claim of priority for hypercontractivity or for a general multiparty direct-product theorem.

## Proposition

All input and public-output alphabets in this proposition are finite. Let B take values in a finite set A with an arbitrary prior pi. Write pi_max=max_b pi(b). Fix p in (1,2], and set

\[
 \eta=2(p-1)/p\in(0,1].
\]

Consider a finite sequence of stages. At any public history h before a stage, the holder receives a fresh private input X with distribution mu_h, independent of B conditional on h. It then sends a finite binary codeword M through a specified stochastic kernel W_h(m|x) that does not depend on b. Conditional on h, the union of the supports of W_h(.,|x) over x is a prefix-free set. After M is sent, a public variable Y is released using a channel K_{b,h}(X,dy), with b=B. The channel has no other dependence on hidden past data; equivalently its specified transition is valid conditional on B,h,X,M. Thus the local actual transition, conditional on B=b and h, factors as mu_h(x) W_h(m|x) K_{b,h}(y|x). The current encoder cannot use the still-unreleased Y.

Assume each channel K_{b,h} sends mu_h to the same reference output measure nu_h, independent of b. Define its action on input densities by

\[
 T_{b,h}f
   =\frac{d[(f\mu_h)K_{b,h}]}{d\nu_h}.
\]

Assume uniformly in the stage, h and b that

\[
 \|T_{b,h}f\|_{L_2(\nu_h)}\le\|f\|_{L_p(\mu_h)}
 \quad\text{for every }f.
 \tag{A}
\]

Suppose the total number of charged bits is at most C on every transcript of positive probability under the actual law. The final estimator may be any stochastic kernel from the whole public transcript to A, with no additional hidden dependence on B. Then

\[
 \Pr[\widehat B=B]
 \le\min\{1,\sqrt{\pi_{\max}\,2^{\eta C}}\}.
 \tag{B}
\]

For uniform B on A this becomes

\[
 \Pr[\widehat B=B]\le
 \min\{1,\sqrt{|A|^{-1}2^{\eta C}}\}.
 \tag{C}
\]

Neither a product structure inside a stage nor a bound on the number of stages appears in this proposition. If one obtains (A) for a product family by tensorization, arbitrary encoders coupling its coordinates are allowed.

For clarity, the conditional independence and local-kernel assumptions concern the actual joint law. They are not claims that successful transcripts or tilted input laws retain independence. The proof neither conditions on success nor fixes hidden random coins. If a protocol has independent public randomness R, one may first condition only on R; the proposition applies whenever its displayed local factorization holds for every such initial public seed. In the Chained Index application it does, and fresh private coins of the current holder are included directly in W_h.

## Proof

At a fixed history h, denote the message marginal under X~mu_h and W_h by a_m=sum_x mu_h(x) W_h(m|x), and the corresponding codeword length by ell_m. Ignore messages with a_m=0. The conditional density of X given M=m is

\[
 f_m(x)=\frac{W_h(m\mid x)}{a_m}.
\]

The numerator lies in [0,1], so f_m>=0, E_mu f_m=1 and f_m<=1/a_m. Consequently

\[
 \|f_m\|_p^2
 \le a_m^{-2(p-1)/p}=a_m^{-\eta}.
 \tag{D}
\]

For fixed b, the conditional density of Y given h,m relative to nu_h is w_{b,h,m}=T_{b,h}f_m. By (A) and (D),

\[
 \mathbb E_{\nu_h}[w_{b,h,m}^2]\le a_m^{-\eta}.
 \tag{E}
\]

The marginal a_m is independent of b, because the new input is independent of B conditional on h. Define a reference law Q for the public transcript recursively: at history h, sample M with probabilities a_m and then sample Y independently from nu_h. This reference law does not use B. Complete the encoder arbitrarily at any history unreachable under all actual inputs.

Let P_b be the actual transcript law conditional on B=b, let H_i be the transcript through stage i, and write

\[
 L_i(b,h)=\frac{P_b(H_i=h)}{Q(H_i=h)}.
\]

At Q-null histories take the value zero; absolute continuity follows stage by stage. The local transition formula yields

\[
 L_i=L_{i-1}w_{b,H_{i-1},M_i}(Y_i).
\]

Let D_i be the cumulative charged length and V_i=L_i^2 2^{-eta D_i}. Prefix freedom gives Kraft's bound sum_m 2^{-ell_m}<=1. For 0<eta<1, Holder then gives

\[
 \sum_m a_m^{1-\eta}2^{-\eta\ell_m}
 \le\Bigl(\sum_ma_m\Bigr)^{1-\eta}
     \Bigl(\sum_m2^{-\ell_m}\Bigr)^\eta
 \le1.
 \tag{F}
\]

For eta=1, (F) follows directly from Kraft. Combining (E) and (F),

\[
\begin{aligned}
 \mathbb E_Q[V_i\mid H_{i-1}=h]
 &=V_{i-1}\sum_m a_m2^{-\eta\ell_m}
                       \mathbb E_{\nu_h}[w_{b,h,m}^2]\\
 &\le V_{i-1}\sum_m a_m^{1-\eta}2^{-\eta\ell_m}
 \le V_{i-1}.
\end{aligned}
\]

Thus E_Q[V_final]<=1 for every b with pi(b)>0. The protocol's cost bound is needed only where L_final(b,h)>0. Such a transcript is reachable under P_b, so D_final(h)<=C. Elsewhere the likelihood is zero. Therefore, for every such b,

\[
 \mathbb E_Q[L_{\mathrm{final}}(b,H)^2]\le2^{\eta C}.
 \tag{G}
\]

Now place B and the reference transcript independently under \bar Q=pi tensor Q. The actual joint density relative to \bar Q is L_final(B,H), so (G) gives E_barQ L_final^2<=2^{eta C}. Apply the same final decoder kernel under both P and bar Q, and denote its output by Z. This does not change the likelihood or its second moment; under bar Q, B is independent of (H,Z). For E={B=Z},

\[
 \bar Q(E)=\mathbb E_{(H,Z)\sim Q\,\text{and decoder}}[\pi(Z)]
           \le\pi_{\max}.
\]

Finally Cauchy--Schwarz gives

\[
 P(E)=\mathbb E_{\bar Q}[L_{\mathrm{final}}\mathbf1_E]
 \le\sqrt{2^{\eta C}\pi_{\max}}.
\]

This completes the stochastic-kernel proof. Independent public seeds may then be averaged as described in the proposition.

## Chained Index specialization

Take A={0,1}^r, pi uniform, mu_h=mu^r for the uniform N/2-slice, and nu_h=u_[N]^r. Let K_b draw, independently in each copy, a uniform element of its subset or complement according to b. The matching argument and classical cube hypercontractivity establish (A) with p=1+2/N; mixed-norm Minkowski tensorizes it across r. Then eta=4/(N+2), and (C) is

\[
 \Pr[\widehat B=B]\le2^{-r/2+2C/(N+2)}.
\]

The complete derivation of the half-slice estimate, tensorization and this model specialization is in `chained_index_strong_direct_product_proof.md`.

## Immediate list and Hamming-error corollaries

If the estimator outputs a list L(h) of at most L candidates, repeat the same proof with E={(b,h):b is in L(h)}. Then bar Q(E)<=L pi_max and

\[
 \Pr[B\in\mathcal L(H)]\le
 \min\{1,\sqrt{L\pi_{\max}2^{\eta C}}\}.
\]

For the uniform r-bit Chained Index answer this gives

\[
 \Pr[B\in\mathcal L(H)]\le
 \min\{1,\sqrt{L\,2^{-r+4C/(N+2)}}\}.
\]

Let 0<=delta<=1/2, and let h_2(delta) be binary entropy, with h_2(0)=0. The Hamming ball of radius floor(delta r) around an r-bit estimate has cardinality at most 2^{r h_2(delta)}. Taking that ball as the list gives

\[
 \Pr[d_H(\widehat B,B)\le\delta r]
 \le\min\{1,\;2^{-(1-h_2(\delta))r/2+2C/(N+2)}\}.
\]

For completeness, the ball-volume inequality follows, when 0<delta<=1/2, from

\[
 1\ge\sum_{i=0}^{\lfloor\delta r\rfloor}\binom ri
       \delta^i(1-\delta)^{r-i}
 \ge\delta^{\delta r}(1-\delta)^{(1-\delta)r}
       \sum_{i=0}^{\lfloor\delta r\rfloor}\binom ri.
\]

The second inequality uses delta/(1-delta)<=1 and i<=delta r; the endpoint delta=0 is immediate. These are direct consequences of the same event-measure calculation, not separate independently novel methods.

## Scope and attribution

The proposition requires fresh private inputs, a common reference output, the stated density norm contraction, and charged prefix code boundaries. Removing any of those assumptions requires a new argument. In particular, an arbitrary multiparty communication problem does not automatically satisfy them, and a slotted silence model does not automatically satisfy Kraft's inequality.

Classical primary analytic source: Aline Bonami, *Etude des coefficients de Fourier des fonctions de L^p(G)*, Annales de l'Institut Fourier 20(2), 335--402 (1970), DOI https://doi.org/10.5802/aif.357 ; full text https://www.numdam.org/article/AIF_1970__20_2_335_0.pdf . Chapter III, Lemma 1, printed p. 375, gives the Minkowski tensorization method; Theorem 3, printed p. 376, supplies the cube hypercontractive condition used in the separate matching argument. All uses of norm duality, Holder, Kraft and Cauchy--Schwarz above are explicit.
