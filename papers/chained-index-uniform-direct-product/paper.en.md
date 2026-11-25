# A chain-length-uniform strong direct product for balanced Chained Index

Research date: 2026-11-25 (Asia/Shanghai). This is a complete mathematical proof draft for independent review. It is not a claim of completed Lean verification.

## 1. Statement and the charged model

Let N>=2 be even, let k,r>=1, and write m=N/2. Let mu be uniform on the m-element subsets of [N]. Generate the input as follows:

1. Draw B uniformly from {0,1}^r.
2. Independently draw S_{i,j} from mu for every stage i in [k] and copy j in [r], independently also of B.
3. Conditional on B and all S, draw J_{i,j} uniformly from S_{i,j} when B_j=1 and uniformly from its complement when B_j=0. These draws are conditionally independent.

The jth input string at stage i is the indicator of S_{i,j}. Consequently its bit at J_{i,j} equals B_j at every stage. This is the product, over j, of the balanced-slice Chained Index hard distribution.

At stage i, the string holder knows S_i=(S_{i,1},...,S_{i,r}) and the public history H_{i-1}. It sends a binary message M_i. The vector J_i of indices is then publicly released. The message cannot depend on the still-unreleased J_i. At every fixed history, the set of possible completed codewords is prefix-free. Thus stopping a message, or deciding to send an empty message, cannot itself transmit an uncharged private fact. The message may have variable length and its encoder may depend arbitrarily on the full public history. All copies may be encoded jointly. The output is an arbitrary function of the final public history.

Assume the total number of transmitted bits is at most C for every valid promised input and every coin outcome on which the protocol is defined. The same conclusion holds if this bound holds almost surely for each input: the input domain is finite, so one common probability-one set of coin outcomes works for all inputs.

**Theorem.** Every such randomized protocol satisfies

\[
  \Pr[\widehat B=B]
  \le \min\left\{1,\;2^{-r/2+2C/(N+2)}\right\}.
  \tag{1}
\]

In particular, for an arbitrary original string length n>=2, use N=2 floor(n/2) active coordinates and fix any remaining coordinate. Then

\[
  C\le nr/8\quad\Longrightarrow\quad
  \Pr[\widehat B=B]\le 2^{-r/4}.
  \tag{2}
\]

The constants are independent of k. Formula (1) is a bound on the probability of correctly recovering the entire r-bit vector; it is a strong direct-product bound, not a Fano direct-sum statement.

## 2. The classical analytic input

We use only the usual real-cube hypercontractive inequality and finite-space norm duality/Minkowski. For independent unbiased signs epsilon_1,...,epsilon_d and q>=2, classical hypercontractivity gives

\[
 \left\|a+\sum_{t=1}^d c_t\epsilon_t\right\|_q^2
 \le a^2+(q-1)\sum_{t=1}^d c_t^2.
 \tag{3}
\]

Indeed, apply the cube noise operator at rho=(q-1)^(-1/2) to
F=a+sqrt(q-1) sum_t c_t epsilon_t. The L_2-to-L_q contraction bounds the resulting affine function by ||F||_2, giving (3).

This is existing mathematics, not a new hypercontractivity theorem. A primary source is Bonami [B70], Chapter III, Theorem 3 (printed p. 376), with the norm-one tensorization lemma on printed p. 375. That theorem states the cube L_p-to-L_q contraction for (q-1)rho^2<=p-1. Only its real p=2 instance is used in (3). We give the additional slice reduction and the required tensorization explicitly below.

## 3. A half-slice down-channel norm bound

Let u be uniform on [N]. For b in {0,1}, define

\[
 K_b(S,t)=\frac{2}{N}\mathbf 1\{\mathbf 1_S(t)=b\}.
\]

This is the transition probability of drawing a uniform element of S or its complement. Its output under mu is u. The corresponding map on densities is

\[
 (T_b f)(t)
 =\frac{\mathbb E_{S\sim\mu}[f(S)K_b(S,t)]}{u(t)}
 =2\,\mathbb E_{S\sim\mu}
   [f(S)\mathbf 1\{\mathbf 1_S(t)=b\}].
 \tag{4}
\]

Its adjoint, for the probability inner products of mu and u, is

\[
 (T_b^*g)(S)=\sum_tK_b(S,t)g(t).
 \tag{5}
\]

Set

\[
 q=1+N/2,\qquad p=1+2/N,\qquad
 \eta=\frac{2(p-1)}p=\frac4{N+2}.
 \tag{6}
\]

The numbers p and q are conjugate, 1<p<=2, q>=2, and 0<eta<=1.

**Lemma 1.** For either b,

\[
  \|T_bf\|_{L_2(u)}\le \|f\|_{L_p(\mu)}.
  \tag{7}
\]

**Proof.** First consider b=1 and prove the dual inequality

\[
  \|T_1^*g\|_{L_q(\mu)}\le \|g\|_{L_2(u)}.
  \tag{8}
\]

Generate a uniform perfect matching of [N], and then choose one endpoint from each matched pair using independent unbiased signs. The selected set S has size N/2 and its distribution is invariant under every permutation of [N], so it is exactly mu.

For a fixed matching {(a_t,b_t):1<=t<=m}, write bar g=N^(-1)sum_v g(v). Conditional on this matching, the random average over S equals

\[
 T_1^*g(S)=\bar g+\frac1N\sum_{t=1}^{m}
        \epsilon_t\bigl(g(a_t)-g(b_t)\bigr).
 \tag{9}
\]

By (3), its conditional L_q norm squared is at most

\[
 \bar g^2+\frac{q-1}{N^2}
     \sum_{t=1}^{m}(g(a_t)-g(b_t))^2.
\]

For each pair, (x-y)^2<=2(x-bar g)^2+2(y-bar g)^2. Summing over the disjoint pairs gives

\[
 \sum_t(g(a_t)-g(b_t))^2
   \le 2\sum_{v=1}^N(g(v)-\bar g)^2
   =2N\operatorname{Var}_u(g).
\]

Since q-1=N/2, the preceding conditional norm squared is at most

\[
 \bar g^2+\operatorname{Var}_u(g)=\mathbb E_u[g^2].
\]

The bound does not depend on the matching. Averaging its qth-power form over the matching proves (8). Finite-space duality and Holder with conjugate exponents p,q now give

\[
 \|T_1f\|_2
 =\sup_{\|g\|_2\le1}|\langle f,T_1^*g\rangle_\mu|
 \le\|f\|_p.
\]

Complementation is a measure-preserving bijection of the half-slice and exchanges K_0 and K_1. Hence the identical result holds for b=0. This proves the lemma.

The direction in (7) matters: it is L_{1+2/N} on the slice to L_2 on the index. No assertion of L_1-to-L_{1+Theta(1/N)} contraction is being used.

## 4. Tensorization across arbitrary jointly encoded copies

**Lemma 2.** For every b=(b_1,...,b_r),

\[
 \left\|\left(\bigotimes_{j=1}^rT_{b_j}\right)f\right\|_{L_2(u^r)}
 \le\|f\|_{L_p(\mu^r)}.
 \tag{10}
\]

**Proof.** Here is the full two-factor step; iteration gives all r. Suppose T_1,T_2 are contractions from their respective L_p input spaces into their L_2 output spaces. Put F(x_1,y_2)=T_2[f(x_1,.)](y_2). Applying the T_1 bound for each y_2 and then mixed-norm Minkowski gives

\[
\begin{aligned}
 \|(T_1\otimes T_2)f\|_{L_2(y_1,y_2)}
 &\le \left\|\|F(.,y_2)\|_{L_p(x_1)}\right\|_{L_2(y_2)}\\
 &\le \left\|\|F(x_1,.)\|_{L_2(y_2)}\right\|_{L_p(x_1)}\\
 &\le \left\|\|f(x_1,.)\|_{L_p(x_2)}\right\|_{L_p(x_1)}
 =\|f\|_{L_p(x_1,x_2)}.
\end{aligned}
\]

The middle inequality has exactly this direction because p<=2. It is the ordinary Minkowski integral inequality applied to |F|^p with exponent 2/p>=1. Thus no assumption that f factors over copies is needed.

## 5. The message-cell likelihood bound

Fix a stage and a public history h. First fix all random coins, so the encoder is a deterministic map f_h from the fresh input vector S in the product half-slice into a prefix-free set A_h of finite binary codewords. Write

\[
 a_m=\Pr_{S\sim\mu^r}[f_h(S)=m],\qquad
 \ell_m=|m|.
\]

Only codewords with a_m>0 are retained. Conditional on any value of B and on any earlier history of positive probability, the new S is still mu^r. Thus these a_m do not depend on B.

For such a codeword define the posterior density

\[
 F_m(S)=\frac{\mathbf 1\{f_h(S)=m\}}{a_m}.
\]

Conditional on B=b and M=m, the density of the newly released indices relative to u^r is

\[
 w_{b,h,m}=\left(\bigotimes_{j=1}^rT_{b_j}\right)F_m.
\]

By Lemma 2,

\[
 \mathbb E_{J\sim u^r}[w_{b,h,m}(J)^2]
 \le\|F_m\|_p^2
 =a_m^{-2(p-1)/p}=a_m^{-\eta}.
 \tag{11}
\]

The same estimate also directly allows randomized encoders: replace the indicator by the kernel probability P(M=m|S), which lies in [0,1], and use E[P(M=m|S)^p]<=a_m. Fixing all coins remains a simpler way to analyze the whole protocol.

## 6. Prefix coding supplies the exact exponential budget

For each history h, the prefix-free codewords satisfy Kraft's inequality

\[
  \sum_{m\in A_h}2^{-\ell_m}\le1.
 \tag{12}
\]

Consequently, for 0<eta<1, Holder gives

\[
 \sum_m a_m^{1-\eta}2^{-\eta\ell_m}
 \le\left(\sum_ma_m\right)^{1-\eta}
      \left(\sum_m2^{-\ell_m}\right)^\eta
 \le1.
 \tag{13}
\]

For eta=1, which occurs only when N=2, (13) is exactly (12), restricted to positive-probability messages. This also covers a zero-length message: prefix freedom permits the empty word only when it is the sole possible message at that history. There is therefore no uncharged input-dependent silence channel.

## 7. A reference law and a discounted second-moment process

With the coins fixed, let P_b denote the distribution of the public transcript when B=b. Define a reference transcript law Q recursively. At every current history h:

- Choose M=m using the encoder marginal a_m computed under a fresh S~mu^r.
- Choose the released J independently from u^r.

The definition of Q does not use b. Histories impossible under every promised input can be assigned any complete prefix encoder. This completion has no effect on P_b. Alternatively the protocol may be truncated after C transmitted bits at all such histories.

For any P_b-positive history, the genuine one-stage transition is

\[
 P_b(M=m,J=j\mid h)=a_m u^r(j)w_{b,h,m}(j).
 \tag{14}
\]

Hence P_b is absolutely continuous with respect to Q. Let L_i(b,h) be the likelihood P_b(H_i=h)/Q(H_i=h), setting it to zero at impossible histories, and let D_i be the cumulative number of charged bits through stage i. The likelihood recursion is

\[
 L_i=L_{i-1}w_{b,H_{i-1},M_i}(J_i).
\]

For fixed b, consider

\[
 V_i=L_i^2 2^{-\eta D_i}.
\]

At any Q-positive history, (11) and (13) imply

\[
\begin{aligned}
 \mathbb E_Q[V_i\mid H_{i-1}]
 &=L_{i-1}^2 2^{-\eta D_{i-1}}
   \sum_ma_m2^{-\eta\ell_m}\mathbb E_{u^r}[w_{b,h,m}^2]\\
 &\le L_{i-1}^2 2^{-\eta D_{i-1}}
   \sum_ma_m^{1-\eta}2^{-\eta\ell_m}
 \le V_{i-1}.
\end{aligned}
 \tag{15}
\]

If L_{i-1}=0, the displayed inequality holds with both sides zero. Initially V_0=1. Thus E_Q[V_k]<=1 for every b, with no factor depending on k.

There is a support detail worth making explicit. The reference Q can visit transcripts that no valid input produces, so it is unnecessary and potentially incorrect to assume D_k<=C everywhere under Q. Instead, L_k(b,h)>0 implies that h has positive probability under P_b. Such an h is realized by at least one valid promised input, and therefore D_k(h)<=C by the stipulated worst-case communication bound. Since L_k vanishes on the remaining histories, (15) yields

\[
 \mathbb E_Q[L_k(b,H_k)^2]
 \le2^{\eta C}\mathbb E_Q[V_k]
 \le2^{\eta C}
 \qquad\text{for every }b.
 \tag{16}
\]

This argument also explains why no reference-law expected-length estimate or additive k term is needed.

## 8. Convert the moment budget into all-copy success

Let \bar Q=U_{\{0,1\}^r}\otimes Q. Under the actual joint law P of (B,H_k), the density relative to \bar Q is L_k(B,H_k). Averaging (16) over the uniform B gives

\[
 \mathbb E_{\bar Q}[L_k(B,H_k)^2]\le2^{\eta C}.
 \tag{17}
\]

Let E={(b,h):output(h)=b}. The coins have been fixed, so output(h) is a deterministic r-bit vector. Because B is independent of H_k under \bar Q,

\[
 \bar Q(E)=2^{-r}.
\]

Cauchy--Schwarz now gives

\[
\begin{aligned}
 P(E)
 &=\mathbb E_{\bar Q}[L_k\mathbf1_E]\\
 &\le\left(\mathbb E_{\bar Q}[L_k^2]\right)^{1/2}
       \bar Q(E)^{1/2}\\
 &\le2^{(\eta C-r)/2}
 =2^{-r/2+2C/(N+2)}.
\end{aligned}
\]

The bound holds for every fixed assignment of public and private coins satisfying the common worst-case cost cap. Averaging over those assignments proves (1) for randomized protocols.

For odd n, N=n-1 and N+2=n+1>=n; for even n, N=n and N+2>=n as well. If C<=nr/8, then 2C/(N+2)<=r/4, proving (2).

## 9. What this proof establishes, and what it does not establish

The estimate is uniform in the number of stages and permits arbitrary joint coding of the r copies, adaptive codebooks, variable-length prefix messages, and public or private randomness. Its strength comes from a second-moment likelihood bound on rare transcripts. An average Shannon information inequality alone would not imply the exponentially small all-copy success probability.

The cube inequality, norm duality, tensorization method, Kraft inequality and Cauchy--Schwarz are classical. The proposed contribution is their combination with the half-slice reference-channel representation and the discounted likelihood process to obtain the stated Chained Index bound. The literature audit is recorded separately and is not a proof of exhaustive novelty.

This argument does not cover the different slotted model where input-dependent silence or message endings are observable for free. Such codewords need not satisfy (12), and that model is governed by a separate communication-versus-rounds analysis. It also does not state a general strong direct-product theorem for arbitrary multiparty problems.

## Primary references

**[B70]** Aline Bonami, *Etude des coefficients de Fourier des fonctions de L^p(G)*, Annales de l'Institut Fourier 20(2), 335--402 (1970). DOI: https://doi.org/10.5802/aif.357 . Full primary text: https://www.numdam.org/article/AIF_1970__20_2_335_0.pdf . Chapter III, Lemma 1, printed p. 375 establishes norm tensorization by Minkowski; Chapter III, Theorem 3, printed p. 376 gives the cube hypercontractive condition. PDF pages 42 and 43 counting the archive cover as page 1.

**[Be75]** William Beckner, *Inequalities in Fourier analysis*, Annals of Mathematics 102(1), 159--182 (1975). DOI: https://doi.org/10.2307/1970980 . Publisher: https://annals.math.princeton.edu/1975/102-1/p11 . This is additional attribution; the proof above uses the Bonami statement verified directly in [B70].

**[S25]** Janani Sundaresan, *Optimal Communication Complexity of Chained Index*, ITCS 2025, LIPIcs 325, article 89. DOI: https://doi.org/10.4230/LIPIcs.ITCS.2025.89 . Full primary text: https://drops.dagstuhl.de/storage/00lipics/lipics-vol325-itcs2025/html/LIPIcs.ITCS.2025.89/LIPIcs.ITCS.2025.89.html . This supplies the Chained Index context and the post-message public-index blackboard strengthening; its published bound is Omega(n-k log n).

**[CDK19]** Graham Cormode, Jacques Dark, and Christian Konrad, *Independent Sets in Vertex-Arrival Streams*, ICALP 2019, LIPIcs 132, article 45. DOI: https://doi.org/10.4230/LIPIcs.ICALP.2019.45 . Full primary text: https://drops.dagstuhl.de/storage/00lipics/lipics-vol132-icalp2019/LIPIcs.ICALP.2019.45/LIPIcs.ICALP.2019.45.pdf . The original Chain communication conjecture is formulated in its private sequential model.
