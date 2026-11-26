# Exact feedback thresholds and critical scaling in compound-geometric FIFO timing channels

Finite feedback can recover the full-feedback capacity of a timing channel without revealing the preceding service duration. For block services with an arbitrary compound-geometric block law, we determine the smallest feedback threshold whenever the full-feedback entropy optimizer has geometric block counts. The threshold is a killed-renewal quantile with an exact one-clock correction for gaps in service support. At the critical geometric parameter every finite threshold loses capacity. Near it the threshold has a Gamma-quantile scaling law, including cases in which the critical tilted jump law has infinite mean.

## 1. Channel and main results

Arrivals \(A_i\) are nondecreasing nonnegative integers. In a FIFO server,
\[
 B_i=\max(A_i,D_{i-1}),\qquad D_i=B_i+S_i,\qquad D_0=0.
\]
The positive-integer services \(S_i\) are iid. At threshold \(\tau\in\mathbb N_0\), the encoder receives the service-entry time \(B_i\) and the alarm at \(B_i+\min(S_i,\tau)\). The alarm carries its time and packet index. It carries no additional completion flag at equality. All available alarms and service entries may be used causally. Full feedback reveals the departures \(D_i\). For \(n\) packets at output rate \(\lambda>0\), a code has equiprobable messages, expected deadline \(\mathbb ED_n\le n/\lambda\), and average error at the decoder observing the departures. Write \(C_\tau(\lambda)\) and \(C_F(\lambda)\) for the corresponding asymptotically achievable rates in nats per time unit.

Let \(d\ge2\), \(0 < r < 1\), and
\[
 S=J+dK,\qquad K=\sum_{\ell=1}^{N}Z_\ell,\qquad
 \Pr(N=n)=(1-r)r^n .
\]
Here \(J\) is uniform on \(\{1,\ldots,d\}\), the jumps \(Z_\ell\) have an arbitrary law \((g_j)_{j\ge1}\) on positive integers, and all these variables are independent. Let \(G(z)=\sum_{j\ge1}g_jz^j\). For \(t\in(r,1)\) with \(\rho_t=rG(1/t)\le1\), put
\[
 A_t=\frac{1-t}{1-r},\qquad
 h_t(k)=1-\sum_{j=1}^k r g_jt^{-j},\qquad
 w_k=A_t t^k h_t(k).
\tag{1}
\]
Use \(\Pr(W=dk)=w_k\) for the optimal idle law. The output law \(q_t\) and the deadline parameters are
\[
 q_t(dn+j)=\frac{1-t}{d}t^n,\qquad
 c_t=d\!\left(\frac{t}{1-t}-\mathbb E K\right)>0,\qquad
 m=\mathbb E S,\qquad \lambda_t=(m+c_t)^{-1}.
\tag{2}
\]

A defective renewal starts at zero. Each step is \(j\ge1\) with probability \(r g_jt^{-j}\), or is infinite with probability \(1-\rho_t\), independently at each finite renewal. Let \(R_t\) be the sum of its finite steps before the first infinite step. Set \(R_t=+\infty\) if every step is finite, and write \(F_t(k)=\Pr(R_t\ge k)\).

**Theorem 1.** At output rate \(\lambda_t\) the full-feedback capacity is
\[
 C_F(\lambda_t)=\lambda_t[H(q_t)-H(S)].
\tag{3}
\]
If \(\rho_t=1\), every finite \(\tau\) satisfies \(C_\tau(\lambda_t) < C_F(\lambda_t)\). If \(\rho_t < 1\), let
\[
 L_t=\min\{k\ge0:F_t(k)\le A_t\},\qquad
 H_t=\min\{k\ge L_t:\Pr(K=k)>0\}-L_t.
\tag{4}
\]
Then the smallest threshold attaining (3) is
\[
 \tau_*(t)=
 \begin{cases}
 d L_t,& F_t(L_t-1)\le \displaystyle\sum_{k=0}^{H_t}w_k,\\
 d L_t+1,& F_t(L_t-1)> \displaystyle\sum_{k=0}^{H_t}w_k.
 \end{cases}
\tag{5}
\]
Every smaller threshold has a strict capacity gap. The formulas apply to arbitrary jump supports, including supports with gaps and nontrivial common divisors.

**Theorem 2.** Suppose \(t_c\in(r,1)\) satisfies \(rG(1/t_c)=1\). Define the critical jump law \(\nu_j=r g_j t_c^{-j}\), and its Laplace transform \(\phi(s)=\sum_{j\ge1}\nu_j e^{-s j}\). If \(1-\phi(s)\) is regularly varying at zero with index \(\alpha\in(0,1]\), then as \(t\downarrow t_c\),
\[
 \log(t/t_c)\,\tau_*(t)\longrightarrow d\,u_\alpha(A_{t_c}),
 \qquad
 \Pr(\operatorname{Gamma}(\alpha,1)\ge u_\alpha(A_{t_c}))=A_{t_c}.
\tag{6}
\]
In particular, finite mean of the critical jump gives \(\alpha=1\) and the constant \(d\log(1/A_{t_c})\).

The ordinary geometric block model has \(G(z)=z\). In that case \(R_t\) is geometric, \(H_t=0\), and (5) gives the block-geometric threshold with no one-clock reduction. For general jumps the reduction can be active.

## 2. Exact full-feedback optimizer and its stability

The service generating function is
\[
 s(z)=\frac{z+\cdots+z^d}{d}\frac{1-r}{1-rG(z^d)}.
\]
The geometric block output in (2) has generating function \((z+\cdots+z^d)(1-t)/(d(1-tz^d))\). The quotient is
\[
 \frac{1-t}{1-r}\frac{1-rG(z^d)}{1-tz^d}=\sum_{k\ge0} w_k z^{dk}.
\]
Thus (1) is the unique deconvolution. Its coefficients are nonnegative precisely when \(\rho_t\le1\), since the partial sums defining \(h_t\) increase to \(\rho_t\) before subtraction from one. When nonnegative they sum to one. Both the service and the resulting idle law have finite mean because \(G(1/t) < \infty\) and the output has a finite mean. Since \(w_0=A_t < 1\), the idle mean \(c_t\) is strictly positive.

For any independent nonnegative-integer idle \(U\) of finite mean, \(S+U\) has uniform residue \(1+((S+U-1)\bmod d)\). Put \(\beta_t=-\log(t)/d>0\). If \(Q\) is the law of \(S+U\), the cross entropy to \(q_t\) gives the exact identity
\[
 H(Q)=H(q_t)+\beta_t(\mathbb E U-c_t)-D(Q\Vert q_t).
\tag{7}
\]
Indeed the log of \(q_t(dn+j)\) is \(\log((1-t)/d)+n\log t\), and the expected block count is the expected output less the mean uniform residue, divided by \(d\). Finite means ensure finite entropy and cross entropy. Thus \(q_t\) is the unique maximizing output over idles of mean at most \(c_t\).

For a timing code define \(W_i=B_i-D_{i-1}=(A_i-D_{i-1})^+\), \(Y_i=D_i-D_{i-1}=W_i+S_i\), and \(Q_i^h=\mathcal L(Y_i\mid Y^{i-1}=h)\). Conditional on the message, independent encoder random seed if any, and \(S^{i-1}\), the next idle \(W_i\) is determined by causality and is independent of \(S_i\). For fixed message and seed, the service and output words determine each other recursively, so \(H(Y^n\mid\mathrm{message})\ge nH(S)\). Moreover, \(Q_i^h\) is the convolution of the conditional idle law and \(s\). Summing (7) over histories gives, under the deadline at \(\lambda_t\),
\[
 \frac{I(\mathrm{message};Y^n)}n
 \le H(q_t)-H(S)-\Delta_n,\qquad
 \Delta_n=\frac1n\sum_i\mathbb E D(Q_i^{Y^{i-1}}\Vert q_t).
\tag{8}
\]
Thus any sequence of codes approaching the right side of (3) with vanishing average error must have \(\Delta_n\to0\), by Fano's inequality.

We will use the following consequence of (8). Write \(w\) for the law of \(W\) on the original integer time axis, and \(W_i^h\) for the conditional law of \(W_i\). If \(\Delta_n\to0\), then
\[
 \frac1n\sum_i\mathbb E\|W_i^{Y^{i-1}}-w\|_{\rm TV}\longrightarrow0 .
\tag{9}
\]
In fact, Pinsker and Jensen bound the analogous mean output distances by \(\sqrt{\Delta_n/2}\). Since \(s_1=(1-r)/d>0\), coefficient \(k+1\) of each convolution expresses its idle mass at \(k\) in terms of that output coefficient and earlier idle coefficients. Induction bounds the difference in idle mass at each \(k\) by a finite constant times the output total variation. At any fixed cutoff this yields convergence of the averaged finite sum. For the tail, \(W_i\le Y_i\), so the averaged idle probability beyond the cutoff is bounded by the corresponding \(q_t\) tail plus the averaged output distance. The reference idle tail also tends to zero. Let the cutoff increase to obtain (9).

## 3. A renewal representation of the posterior

The renewal mass at \(k\) of the defective process is
\[
 U_t(k)=\frac{\Pr(K=k)}{1-r}t^{-k}.
\]
This follows either by summing its finite convolutions or by matching the generating function \(1/(1-r G(z/t))\). At \(Y=dn+j\), \((1)\)–\((2)\) give
\[
 \Pr(K=k\mid Y=dn+j)=U_t(k)h_t(n-k)\qquad(0\le k\le n).
\tag{10}
\]
The right side is exactly the probability that the last renewal up to \(n\) is at \(k\). Last renewal positions are nondecreasing in \(n\). They tend almost surely to \(R_t\) for \(\rho_t < 1\), and to infinity for \(\rho_t=1\). Consequently for each \(\ell\ge0\)
\[
 \sup_{n\ge0}\Pr(K\ge\ell\mid Y=dn+j)=F_t(\ell).
\tag{11}
\]
The probability is independent of \(j\). When \(\rho_t < 1\), \(F_t(k)\) tends to zero, \(F_t(0)=1>A_t\), and \(L_t\ge1\) is finite. Minimality gives \(F_t(L_t-1)>A_t\ge F_t(L_t)\), so \(R_t\) has positive mass at \(L_t-1\). Its finite support points coincide with those of \(K\), since \(\Pr(R_t=k)=(1-\rho_t)U_t(k)\). The support is unbounded because nonzero finite jumps can repeat. Thus \(H_t\) is well defined.

## 4. Necessity for arbitrary causal policies

Call a service late if \(S_i\ge\tau\), and let \(u\) be the smallest supported service length in this event. For \(\tau=0\) all lengths are late. Conditional on the encoder random seed, message and earlier services, the offset \(A_{i+1}-B_i=x\) has a common value for every late length. All earlier feedback is fixed under the conditioning. Before admission of packet \(i+1\) the only events from packet \(i\) are entry and the single, common alarm. An unobserved completion produces no event, and a later packet cannot reveal its service entry before packet \(i+1\) is admitted. Thus \(x\) is common even if the policy can wait after the alarm or transmit earlier. Its effective idle on service length \(s\) is \((x-s)^+\).

Under the optimal idle law only multiples of \(d\) are allowed. The following rigidity statements hold even for near-optimal sequences. They follow by conditioning as above and using the fixed positive masses at the service lengths that witness a forbidden residue.

- If \(u+1\) is supported, every \(x>u\) gives a forbidden idle for at least one of \(u,u+1\). For \(x=u+1\), use the idle one after \(u\). For \(x\ge u+2\), the two possible positive idles are consecutive. Therefore the probability of any positive idle after a late service is at most a fixed multiple of the probability that \(W_{i+1}\notin d\mathbb N_0\).
- Otherwise \(u\) is the last residue of a supported block, and the next supported service is \(v=u+dH+1\), with \(H\ge1\), followed by \(v+1\). For \(u < x\le v\), a positive idle arises only when the service is \(u\). It is compatible with the support exactly when \(x=u+d\ell\) with \(1\le\ell\le H\). For \(x>v\), one of \(v,v+1\) witnesses a forbidden idle. Hence, except on an event of probability at most a fixed multiple of \(\Pr(W_{i+1}\notin d\mathbb N_0)\), late idles are zero or are at most \(dH\) and are generated only by the service \(u\).

To justify the probability comparison, for each conditioned history any offset outside those permitted in the respective case gives conditional probability of a forbidden idle at least the minimum of the positive masses at the witness lengths \(u,u+1\), or \(u,v,v+1\), respectively. The probability of the exceptional event is at most one on such a history and zero on permitted histories. Integration gives the asserted constant factor. If the output residue \(j\) differs from the residue of \(u\), late positive idles in the second case also require \(W_i\notin d\mathbb N_0\), because \(Y_i=W_i+S_i\).

For a fixed \(y=dn+j\), define \(\mathcal A_j=\{0\}\) in the first case. In the second case let \(\mathcal A_j=\{0,d,\ldots,dH\}\) when \(j\) is the residue of \(u\), and \(\mathcal A_j=\{0\}\) otherwise. These comparisons imply that any sequence with \(\Delta_n\to0\) must have
\[
 \Pr_{q_t}(S\ge\tau\mid Y=y)\le w(\mathcal A_j)\quad\text{for every }y .
\tag{12}
\]
Here the probability on the left uses independent \(W\sim w,S\sim s\). Indeed, for each \(i < n\) compare \(\Pr(S_i\ge\tau,Y_i=y)\) to \(\Pr(Y_i=y,W_{i+1}\in\mathcal A_j)\). The difference is bounded by fixed multiples of \(\Pr(W_{i+1}\notin d\mathbb N_0)+\Pr(W_i\notin d\mathbb N_0)\). On averaging these terms vanish by (9). Independence of \(S_i\) and \(W_i\) given \(Y^{i-1}\) gives the limit \(q_t(y)\Pr_{q_t}(S\ge\tau\mid Y=y)\) on the left by (9). Applying (9) to the conditional idle law at \(Y^i\) gives \(q_t(y)w(\mathcal A_j)\) on the right, using the averaged convergence of \(\mathcal L(Y_i)\) to \(q_t\). Division gives (12). A strict violation yields a strictly positive capacity gap by (8): equality of the two capacity suprema would produce a sequence approaching the full rate with vanishing average error and therefore \(\Delta_n\to0\).

At \(\tau=d L_t-1\), the first late service is the second-last residue of the supported block \(L_t-1\). This includes \(d=2\), where that residue is the first. There are two consecutive supported late lengths, so (11)–(12) fail because \(F_t(L_t-1)>A_t\). Smaller thresholds have no more information than this one. At \(\tau=dL_t\), the first late service is \(u=dL_t\). The next block begins at \(u+d H_t+1\). For residue \(j=d\), (11)–(12) require \(F_t(L_t-1)\le \sum_{k=0}^{H_t}w_k\), with the consecutive-length case corresponding to \(H_t=0\). For \(j < d\), the late posterior supremum is at most \(F_t(L_t)\le A_t\). This proves the necessary inequality in (5).

At \(\rho_t=1\) the late posterior in every residue tends to one by (11). If consecutive earliest late lengths are present, (12) requires the bound \(A_t < 1\). If a gap follows the first late length, choose any other residue, which exists because \(d\ge2\); then (12) again requires \(A_t < 1\). In either case a finite \(y\) violates (12). This proves strict loss for all finite thresholds at criticality.

## 5. Achievability and causal reconstruction

We construct an encoder using fresh independent seeds so that \(Y_i\) are iid \(q_t\). Begin with \(W_1\sim w\). Inductively, at the entry of packet \(i\) the encoder knows \(D_{i-1}\) and hence \(W_i\). Suppose \(W_i\) has law \(w\) conditional on \(Y^{i-1}\). Then \(Y_i\) has law \(q_t\) given the same history, with service posterior (10).

At \(\tau=dL_t+1\), choose zero idle following a late alarm, by sending the next packet at that alarm. The posterior late mass given any \(y\) is at most \(A_t\). On an early completion the encoder learns \(D_i\) and computes \(Y_i\). If the late posterior subprobability measure is \(\ell_y\delta_0\), choose the next idle law \((w-\ell_y\delta_0)/(1-\ell_y)\). It is a probability law by the bound, and its early and late mixture is \(w\). For an early completion the departure is observed. For a late one the next arrival is queued by \(D_i\), so the next entry reveals \(D_i\). Thus the induction remains valid.

Now let \(\tau=dL_t\) and assume the first inequality in (5). Then \(H_t\ge1\) by \(F_t(L_t-1)>A_t\). Put \(W_+=\sum_{k=1}^{H_t}w_k>0\). For \(y\) of residue \(d\), write
\[
 p_y^0=\Pr(S=\tau\mid Y=y),\qquad
 p_y^+=\Pr(S>\tau\mid Y=y),\qquad
 a_y=(p_y^0+p_y^+-A_t)_+ .
\]
Equations (5) and (11) give \(a_y\le W_+\) and \(a_y\le p_y^0\), the latter because \(p_y^+\le F_t(L_t)\le A_t\). At the late alarm, compute the hypothetical \(y=W_i+\tau\). Use the delays \(\tau+d k\) from entry, \(1\le k\le H_t\), with probabilities \((a_y/p_y^0)w_k/W_+\) when \(p_y^0>0\), and use the immediate alarm time with the remaining probability. If the hypothetical posterior is zero, use the immediate alarm time. These choices require only the observed idle and alarm. A delayed arrival creates idle \(dk\) exactly if \(S=\tau\). All larger supported late services finish strictly after the selected arrival. At the next entry, \(B_{i+1}=A_{i+1}\) therefore identifies \(S_i=\tau\) on this branch; if \(B_{i+1}>A_{i+1}\), the entry equals \(D_i\). Thus reconstruction of \(D_i\) holds also on the delayed late branch.

Given an actual output \(y\) of residue \(d\), the late subprobability assigns \(a_y w_k/W_+\) to positive idles \(dk\) in the allowed range, and \(p_y^0+p_y^+-a_y\) to zero. It is dominated by \(w\) coordinate by coordinate. For a residue \(j < d\), the late subprobability is concentrated at zero and is at most \(F_t(L_t)\le A_t\). Early completions reveal \(y\), so divide the residual measure of \(w\) by the early posterior probability to define the early branch. If that probability is zero the residual has zero mass and its branch is not used. In every case the next conditional idle law is \(w\), closing the induction. A larger threshold can simulate a smaller one by keeping only its corresponding truncated alarm.

For completeness, iid output realization yields a timing code at rate \(\lambda_t[H(q_t)-H(S)]\) with the exact average deadline. Use a fresh independent uniform seed at each step to choose any conditional countable idle kernel, and randomize seed words independently across the message codebook. After fixing a word, the output likelihood of its realized service path is \(\prod_i s(S_i)\), because the service path is recovered recursively from the outputs. Under the random seed word and services the output likelihood is \(\prod_i q_t(Y_i)\). The information density per packet therefore tends in probability to \(H(q_t)-H(S)\), by the two iid laws and finite entropies. Threshold decoding at any smaller rate has mean random-code error tending to zero: a competing word is independent of the actual output and its likelihood ratio to \(q_t^{\otimes n}\) has conditional expectation one, giving the union bound on false accepts.

If the mean error is \(e_n\), choose a deterministic codebook with error at most \(\sqrt{e_n}\) and mean expected cost at most \(n(m+c_t+\zeta_n)\), where \(\zeta_n=e_n^{1/3}+1/n\). The expected cost of a random codebook is \(n(m+c_t)\). Markov's inequality gives probability at least \(\zeta_n/(m+c_t+\zeta_n)\) of meeting the relaxed deadline, larger than the probability of excess error for large \(n\). Add \(\lceil M_n\zeta_n/c_t\rceil\) dummy message labels producing zero idles and count their errors as one. Their proportion tends to zero, and the augmented code meets the exact deadline. Full feedback can implement iid \(w\) directly by scheduling after departures, so (8) and the same code construction prove (3). This also proves the achievability statements in (5).

## 6. The critical limit

At \(t>t_c\), put \(s=\log(t/t_c)>0\). The finite step masses of the renewal are \(\nu_j e^{-s j}\), and the killing probability is \(1-\phi(s)\). For every \(u\ge0\), summing the contributions of the geometric number of finite steps gives
\[
 \mathbb E e^{-u sR_t}=\frac{1-\phi(s)}{1-\phi((1+u)s)}.
\tag{13}
\]
Regular variation makes this converge to \((1+u)^{-\alpha}\), the Laplace transform of \(\operatorname{Gamma}(\alpha,1)\). The continuity theorem gives \(sR_t\Rightarrow\operatorname{Gamma}(\alpha,1)\). Its tail is continuous and strictly decreasing, and \(A_t\to A_{t_c}\in(0,1)\). Applying the tail convergence at fixed values on either side of its upper \(A_{t_c}\)-quantile shows \(sL_t\to u_\alpha(A_{t_c})\), with integer rounding errors vanishing. Equation (5) now gives (6). If \(\sum_j j\nu_j < \infty\), dominated convergence yields \(1-\phi(s)\sim s\sum_j j\nu_j\).

Infinite-mean critical laws with each \(\alpha\in(0,1)\) are possible. Given \(t_c\in(0,1)\) and \(\nu_j\) proportional to \(j^{-1-\alpha}\), set \(r=\sum_j\nu_j t_c^j < t_c\) and \(g_j=\nu_j t_c^j/r\). The Laplace defect is asymptotic to a positive constant times \(s^\alpha\) by the Riemann sum for \(\int_0^\infty(1-e^{-x})x^{-1-\alpha}dx\), with integrable bounds at zero and infinity. Thus the service itself has an exponential moment while its critical tilted jump has infinite mean.

## 7. Examples and relation to earlier work

Take \(d=2\) and deterministic jumps \(Z=2\). Then \(R_t=2N_t\) with \(\Pr(N_t\ge j)=(r/t^2)^j\). For \(r=1/4,t=3/4\), \(A_t=1/3\), \(L_t=3\), \(H_t=1\), the late tail \(F_t(2)=4/9\), and \(w_0+w_1=7/12\). The threshold is six. The policy gains one clock through a positive idle after a service of length six, even though that length is initially indistinguishable from larger late lengths. For \(r=1/10,t=3/5\), \(L_t=1,H_t=1\), \(F_t(0)=1>w_0+w_1=32/45\), and the threshold is three.

Anantharam and Verdú give the full-feedback FIFO capacity expression in (3.4), as recalled in Theorem 2 of Aptel and Tchamkerten. The latter derive a weak-feedback converse. Sahasranand and Tchamkerten define the generalized alarm and study feedback gains, with particular attention to bounded services. Their author version §III is the model comparison. The entropy optimum in this paper is a maximum-entropy calculation, and renewal transforms and random coding are established tools. The new operational step is that geometric-output deconvolution turns late scheduling into a constrained support problem. For a missing block it leaves exactly one possible threshold at which a positive idle and subsequent reconstruction can improve the reset policy. This produces an exact threshold for arbitrary jump supports and connects its critical divergence to the renewal limit. The capacity values below the threshold and rates for which geometric deconvolution is infeasible remain separate questions.

## References

1. V. Anantharam and S. Verdú, *Bits through queues*, IEEE Transactions on Information Theory 42(1), 4–18 (1996). [DOI](https://doi.org/10.1109/18.481773).
2. L. Aptel and A. Tchamkerten, *Bits Through Queues With Feedback*, IEEE Transactions on Information Theory 66(6), 3317–3326 (2020). [DOI](https://doi.org/10.1109/TIT.2020.2970421) · [Author text](https://arxiv.org/abs/1710.06190).
3. K. R. Sahasranand and A. Tchamkerten, *Feedback Increases the Capacity of Queues With Bounded Service Times*, IEEE Transactions on Information Theory 70(10), 6823–6833 (2024). [DOI](https://doi.org/10.1109/TIT.2024.3421909) · [Author text, §III](https://arxiv.org/abs/2309.14145v2).
