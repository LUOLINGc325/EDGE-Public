---
title: "Finite Certificates and Memory Penalties for Binary POST Channels"
subtitle: "Complete binary classification, stationary stability, and explicit losses at every finite Markov order"
date: "25 November 2026"
lang: en
---

# Reading this research package

This package contains two complete, separately reviewed mathematical texts.
Part I proves a finite classification of feedback usefulness for all strictly
positive binary POST channels, including singular state channels, constructive
attaining sources, negative-word capacity-gain bounds, and an exact algebraic
decision theorem. Part II proves quantitative stability of stationary input
blocks, uniqueness of the stationary attaining law, and explicit capacity
penalties for every fixed finite visible Markov order in a certified example.
It also records an exact discrepancy in an older specified BSSC source's
attainment claim, without refuting unrestricted feedback/nonfeedback capacity
equality.

This collection contains two related mathematical manuscripts. Neither external peer review nor a university qualification is claimed. Novelty is limited to the
inspected primary sources; the final journal full text corresponding to
arXiv:2603.08886 was not available for version comparison.

**Lean is a separate delivery.** The existing 47-theorem algebraic core was
compiled and its 118 own declarations were audited, but it does not prove the
whole classification or Part II. Full formalization remains required. Finite
certificate computations support their stated examples; they do not replace
the analytic proofs or implement the universal quantifier-elimination theorem.

The written mathematical claims and their limitations are stated in the two texts. Full Lean formalization is not provided in this version.

# Part I. Finite feedback-gain certificates

## Abstract

For every binary-input, binary-output channel whose state is its previous output and whose transition probabilities are strictly positive, we give a finite necessary-and-sufficient test for equality of feedback and non-feedback capacity. The test handles singular state matrices separately. In the nonsingular case it is an iid alternative or eight quadratic inequalities in two interval endpoints. A feasible certificate constructs a capacity-achieving time-homogeneous edge-emitting input source with at most two hidden states; one state suffices exactly in the iid branch.

A negative coefficient of the inverse input law yields an explicit positive lower bound on the operational feedback gain. The bound applies to every correlated, nonstationary non-feedback input law. Its supplied-word verification costs only linear arithmetic in the word length. Rational transition probabilities admit exact algebraic preprocessing, a terminating equality decision, and algebraic accepting and rejecting certificates. A feedback-optimal policy on a support boundary always has a negative word of length two. A fully rational example certifies a gain greater than $49/900000$ nats per use.

The infinite simulation criterion, planar cone geometry, dimension-two positive realization, and binary feedback optimization have prior foundations. Our contribution is their complete effective connection for the full strictly positive binary class and its quantitative operational separation. The appendix supplies the full optimizer, singular-branch, asymptotic-gap, and algebraic-decision proofs. Machine-verification coverage is recorded separately; partial Lean verification is not full formalization.

## 1. Problem and inherited foundations

Let $X_t,Y_t\in\{0,1\}$, let $Y_{t-1}$ be the channel state, and assume
$$
Q(y\mid x,s)>0,\qquad \sum_yQ(y\mid x,s)=1.
$$
Write $a_s=Q(1\mid0,s)$ and $b_s=Q(1\mid1,s)$, with all four numbers in $(0,1)$. The matrix
$$
Q_s=\begin{pmatrix}1-a_s&1-b_s\\a_s&b_s\end{pmatrix}
$$
has output rows and input columns. Output Markov matrices $R$ instead have current-state rows and next-output columns. Natural logarithms are used throughout.

We use the established operational coding theorems for connected, indecomposable POST channels [ZCW26, Section II]. Strict positivity gives uniform indecomposability. In particular,
$$
C=\lim_{N\to\infty}\frac1N
\max_{P_{X^N Y_0}}I(X^N;Y^N\mid Y_0),
\tag{M1}
$$
and feedback capacity $C_f$ is the maximum stationary single-letter conditional information subject to stationarity of the output state. Initial-state correlation allowed in (M1) is an information-theoretic characterization, not free feedback for an operational encoder.

[PAW14] treats symmetric POST$(a,b)$ by inverse block channels and ratio intervals. [ZCW26, Theorem 2] already gives an all-blocklength simulation characterization; its Section V asks for more general nonperturbative conditions. Planar common invariant cones are classical [RSS09], as is dimension-two positive realization [Sch09]. General binary feedback optimization is prior work [SCK16, KCT17]. None of these tools is counted as an independent new invention.

The present target is the full four-parameter strictly positive family. Zero transition probabilities, classification with arbitrary alphabet sizes, and an exact formula for $C$ inside the strict-gain region are excluded.

### 1.1 Exact feedback coefficients

The appendix uses $u=P(X=1\mid s)$:
$$
q_s(u)=a_s+(b_s-a_s)u,\qquad
f_s(u)=h(q_s(u))-(1-u)h(a_s)-uh(b_s).
$$
Let
$$
M_s(v)=\max_{u\in[0,1]}\{f_s(u)+q_s(u)v\}.
$$
There is a unique root of $M_1(v)-M_0(v)-v=0$. The optimal output probability is
$$
\rho_s(v)=\operatorname{clip}\left(
\frac{e^{v-k_s}}{1+e^{v-k_s}},
[\min(a_s,b_s),\max(a_s,b_s)]\right),\quad
k_s=\frac{h(a_s)-h(b_s)}{a_s-b_s},
\tag{M2}
$$
when $a_s\ne b_s$, and $\rho_s=a_s$ otherwise. Set $R_*(s,1)=\rho_s$, $R_*(s,0)=1-\rho_s$. The root exists uniquely because the derivative of the bias equation is $\rho_1-\rho_0-1$, bounded above by a strictly negative constant. The Bellman value is $C_f=M_0(v)$; see Appendix A.2.

Thus $R_*$ is unique on the entire strictly positive family. In a nonsingular state, the optimal input law $p_s$ is recovered by $p_s(1)=(\rho_s-a_s)/(b_s-a_s)$. Boundary optima are allowed.

## 2. Inverse laws and a finite cone test

Assume both $Q_s$ are nonsingular. For a stochastic target $R$, define
$$
A_x(s,y)=(Q_s^{-1})(x,y)R(s,y),\qquad x,s,y\in\{0,1\}.
\tag{M3}
$$
For a finite word $w=x_1\cdots x_n$, put $A_w=A_{x_1}\cdots A_{x_n}$, and $A_\varnothing=I$. Since $\mathbf1^\top Q_s^{-1}=\mathbf1^\top$,
$$
A_0+A_1=R,\qquad (A_0+A_1)\mathbf1=\mathbf1.
\tag{M4}
$$

**Lemma 1 (exact inverse strings).** The length-$n$ block channel from initial state $s$ is invertible. Its inverse row indexed by input word $w$ is
$$
g_{s,w}(y_1\cdots y_n)
=\prod_{j=1}^n(Q_{y_{j-1}}^{-1})(x_j,y_j),\qquad y_0=s.
\tag{M5}
$$
Consequently the unique signed input law that produces the Markov output law $R$ is
$$
p_s(w)=e_s^\top A_w\mathbf1.
\tag{M6}
$$
These coefficients sum to one and satisfy
$$
p_s(\varnothing)=1,\qquad \sum_xp_s(wx)=p_s(w).
\tag{M7}
$$

*Proof.* Multiply (M5) by the forward channel matrix. Summing first over $x_1$ gives a Kronecker identity in the first output symbol. The second inverse factor then has the same preceding state as the second forward factor. Sum over $x_2$ and continue. The resulting square matrix product is the identity. Applying the inverse to the Markov output probabilities gives (M6). Equations (M4) and (M6) give (M7); repeated summation gives total mass one. This proves both invertibility and consistency. $\square$

Write $r_z=(1-z,z)^\top$ and let $\det(u,v)$ mean the determinant with columns $u,v$.

**Theorem 2 (complete finite classification).** For every strictly positive binary POST channel:

1. If either $Q_s$ is singular, then $C=C_f$ and an iid input attains capacity.
2. Otherwise form $A_x$ from the unique $R_*$. Then $C=C_f$ exactly when either $p_0(1)=p_1(1)$, or there exist
$$
0\le\ell<\tfrac12<u\le1
\tag{M8}
$$
such that, for $x\in\{0,1\}$ and $z\in\{\ell,u\}$,
$$
\det(r_\ell,A_xr_z)\ge0,\qquad
\det(A_xr_z,r_u)\ge0.
\tag{M9}
$$
There are eight inequalities of degree at most two in the two unknowns $\ell,u$.

*Proof of the singular branch.* At a singular state the output and information reward are independent of the input. Use the informative state's feedback-optimal probability iid at both states. It preserves the optimal output row and reward at the informative state, and cannot change either at the singular state. This attains the optimal stationary reward; initial-state effects vanish by positivity. If both states are singular, both capacities are zero. Appendix A.3 gives the operational details.

*Proof of the finite geometry.* Suppose $A_w\mathbf1\ge0$ for every word. The closed conic hull
$$
K=\overline{\operatorname{cone}\{A_w\mathbf1:w\in\{0,1\}^*\}}
$$
lies in the nonnegative quadrant, contains $\mathbf1$, and satisfies $A_xK\subseteq K$, since multiplication prepends a letter. If it has dimension one, it is the ray through $\mathbf1$, yielding $p_0(x)=p_1(x)$; the converse follows by induction.

If $K$ has dimension two, its normalized section $K\cap\{z_0+z_1=1\}$ is a closed interval with endpoints $r_\ell,r_u$. The vector $\mathbf1$ is interior to $K$. Indeed, if it lies on an extreme ray, the decomposition $A_0\mathbf1+A_1\mathbf1=\mathbf1$ forces both summands onto that ray, so all word vectors remain on the ray, a contradiction. Thus (M8) holds.

For $\ell<u$, a vector $z$ belongs to $\operatorname{cone}(r_\ell,r_u)$ if and only if the two determinants in (M9), with $A_xr_z$ replaced by $z$, are nonnegative. This is the explicit two-coordinate basis formula, whose denominator is $\det(r_\ell,r_u)=u-\ell>0$. Invariance therefore gives (M9). Conversely, (M9) implies invariance of the cone generated by the two rays. Since (M8) puts $\mathbf1$ inside it, induction gives nonnegativity of every word vector.

*Proof of the capacity connection.* When every coefficient is nonnegative, Lemma 1 gives valid input blocks for each initial state. Take the initial state stationary under $R_*$. The output is the stationary optimal Markov process. At each time, invertibility of $Q_s$ and the one-step output/state marginal recover the optimal input/state marginal. Hence
$$
\frac1N I(X^N;Y^N\mid Y_0)
=\sum_s\pi_*(s) f_s(p_s(1))=C_f.
$$
Equation (M1) proves equality. If a coefficient is negative, Theorem 4 below supplies a strictly positive capacity gap. This also proves necessity, independently of treating an approximate limiting simulation as an exact one. $\square$

The single-ray case is separate on purpose. When $\ell=u=1/2$, determinant conditions alone would admit negative multiples of $\mathbf1$. The theorem does not use this invalid degenerate test. Its coefficients depend on the optimal $R_*$; it does not assert a polynomial formula in arbitrary real raw channel parameters.

## 3. An attaining source and its minimal size

**Theorem 3 (one or two hidden states).** In the nonsingular equality case, an iid source attains capacity exactly when $p_0=p_1$. Otherwise a two-state time-homogeneous edge-emitting source attains capacity and one hidden state cannot suffice. The two-state construction also simulates the exact optimal output process from either specified initial channel state.

*Construction.* Given (M8)--(M9), set
$$
T=(r_\ell\ \ r_u),\quad
b=T^{-1}\mathbf1=
\begin{pmatrix}(2u-1)/(u-\ell)\\(1-2\ell)/(u-\ell)\end{pmatrix}>0,
\quad U=T\operatorname{diag}(b).
$$
Then $U\ge0$ and $U\mathbf1=\mathbf1$. Define
$$
B_x=U^{-1}A_xU,\qquad \alpha_s=e_s^\top U.
\tag{M10}
$$
The finite inequalities imply $B_x\ge0$, and
$$
(B_0+B_1)\mathbf1=\mathbf1,\qquad
\alpha_s\ge0,\quad\alpha_s\mathbf1=1.
$$
At hidden state $i$, emit $x$ and move to hidden state $j$ jointly with probability $B_x(i,j)$. No channel output is consulted. The probability of word $w$ is
$$
\alpha_s B_w\mathbf1=e_s^\top A_w\mathbf1.
\tag{M11}
$$
This is an edge-emitting construction, not a claim about two-state node-emitting HMMs.

*Removing initial-state knowledge.* Let $\pi_*$ be the stationary row law of $R_*$, and initialize the source with $\alpha=\pi_*U$, independently of the channel's unknown initial state. With $P=B_0+B_1$ we have $\alpha P=\alpha$. The joint hidden/channel-state invariant law is
$$
P(Z=i,Y=s)=\pi_*(s)U(s,i).
\tag{M12}
$$
To verify it, sum the one-step update over $i$ and use $UB_x=A_xU$, followed by
$$
\sum_x Q(y\mid x,s)(Q_s^{-1})(x,t)=1_{\{y=t\}}.
$$
This reduces the update to $\pi_*(y)U(y,j)$.

Couple a chain started with an arbitrary physical state to the invariant process, using the same entire hidden-state/input path and a maximal coupling of the physical outputs. Conditional on that input path, the physical states couple with a probability uniformly bounded below at each step, because $Q$ is strictly positive. Thereafter they remain coupled. The first coupling time $\tau$ therefore has uniformly bounded expectation and entropy.

Two coupled output strings differ only in a prefix of length at most $\tau$. Encoding the coupling time and that prefix gives, in each direction, a conditional entropy bound $H(\tau)+\mathbb E\tau\log2=O(1)$, uniformly in the blocklength. The same holds conditional on the full input word: given that word, future channel randomization still has the original channel law, and both conditional initial-state distributions are supported on two states. Hence the output entropy and the output entropy conditional on inputs each differ by $O(1)$. Their mutual-information rates coincide. The invariant process has rate $C_f$ by (M11) and the capacity calculation above; adding or removing conditioning on $Y_0$ changes mutual information by at most $\log2$. Thus the state-independent initialization attains $C_f$.

*Minimality.* A one-state time-homogeneous edge-emitting source is iid. For an iid attaining law, average the Bellman divergence identity of Appendix A.5 under its positive stationary physical-state law. A zero asymptotic deficit forces each output row to equal $R_*$. Invertibility then forces its single input probability to be both $p_0(1)$ and $p_1(1)$. Conversely a common probability attains capacity. This proves the asserted minimum; for singular channels the attaining iid source was already constructed. $\square$

## 4. A finite negative word is an operational gain certificate

Let $w$ have length $n\ge1$ and suppose
$$
e_s^\top A_w\mathbf1=-\gamma<0.
$$
Define
$$
\omega=\max_{y^n}g_{s,w}(y^n)-\min_{y^n}g_{s,w}(y^n),\qquad
m_s=\min_{x,r}Q(s\mid x,r)>0.
$$

**Theorem 4 (quantitative rejection).** We have $\omega>0$, and
$$
\boxed{C_f-C\ge\frac{2m_s\gamma^2}{n\omega^2}>0.}
\tag{M13}
$$
For every non-feedback input law of length $N$,
$$
N C_f-I(X^N;Y^N\mid Y_0)
\ge
2m_s\left\lfloor\frac{N-1}{n}\right\rfloor
\frac{\gamma^2}{\omega^2}-|v|.
\tag{M14}
$$

*Proof.* The inverse row has nonnegative expectation under every feasible block output, since its expectation is the probability of input word $w$. Under the target optimal Markov output it has expectation $-\gamma$. Therefore total variation is at least $\gamma/\omega$ and Pinsker's inequality gives block relative entropy at least $2\gamma^2/\omega^2$. This also proves $\omega>0$.

Conditioning on any past output history leaves an ordinary non-feedback input distribution for the future block and the original channel law. The bound therefore holds at every block starting in $s$. At any positive time the probability of that state is at least $m_s$, without any stationarity assumption. Partition the outputs after the first symbol into complete disjoint blocks, and apply the relative-entropy chain rule.

The Bellman identity bounds $NC_f-I$ below by the sum of the conditional one-step output divergences, minus the finite bias span $|v|$. The block contribution gives (M14). Divide by $N$, maximize over input laws, and use (M1). Appendix A.5--A.6 proves every conditionalization and finite-horizon identity in detail. $\square$

A fixed supplied word can be checked using $O(n)$ arithmetic operations. Compute $\gamma$ by two-dimensional matrix multiplication. To compute $\omega$, maintain the smallest and largest product in (M5) for each possible terminal output state. At each step multiply both extremes by each applicable inverse-channel coefficient, then take extrema over incoming states. Multiplication by a fixed signed scalar always has its extrema at the two endpoints. Induction proves exactness. This avoids an exponential-size block inverse.

The argument is reusable: in a strictly positive finite-alphabet POST channel, any bounded statistic separating a Bellman-optimal target block law from the feasible non-feedback block-output simplex yields the same bound, replacing $\gamma$ by the separating expectation gap. The finite complete classification in this paper remains binary.

### 4.1 Boundary optima and an exact rational example

If both $Q_s$ are nonsingular, then $C_f>0$. If some optimal action probability vanishes, a length-two negative word exists. To see this, the corresponding row of $A_x$ sums to zero but has two nonzero opposite entries. Unless the action is absent in both states, applying that row to the nonconstant one-letter probability vector yields a nonzero value; its two length-two extensions sum to zero, so one is negative. Absence in both states would make capacity zero. This includes a maximizing action exactly at a support transition; see Appendix A.7.

For
$$
(a_0,b_0,a_1,b_1)=(1/10,1/5,1/10,9/10),
$$
the optimal kernel satisfies $R_*(0,1)=1/5$ and $R_*(1,1)=r=t/(1+t)$, where
$$
10^{10}t^{12}-9^9(1+t)^{10}=0,\qquad 3/2<t<2.
$$
The branch conditions and interval signs are exact integer inequalities. For $s=0,w=00$,
$$
g_{0,00}=(4,-16,-9,1),\quad
\omega=20,\quad
p_0(00)=2r-\frac95<-\frac7{15}.
$$
Since $m_0=1/10$, (M13) gives
$$
\boxed{C_f-C>\frac{49}{900000}\text{ nats/use}.}
\tag{M15}
$$
The complete integer checks are in Appendix A.9 and the executable certificate.

A nonsymmetric non-iid equality example is
$$
(a_0,b_0,a_1,b_1)=(1/4,3/4,3/10,7/10).
$$
Its exponential bias is the positive root of
$$
3^9 5^{20}t^{20}-2^{20}7^{14}=0,
\quad
4763/5000<t<9527/10000.
$$
Both optimal output-one probabilities are $r=t/(1+t)$. The interval
$$
\ell=97/197,\qquad u=103/203
$$
strictly satisfies all eight inequalities, as certified by rational interval arithmetic. Its stationary input lag-one covariance is strictly negative in the supplied certificate, independently excluding an iid source. The two states are therefore necessary. These two instances test accepting and rejecting semantics; the general theorem is not inferred from them.

## 5. Exact rational-input decision

**Theorem 5 (terminating exact algorithm).** When the four channel parameters are rational, equality of $C$ and $C_f$ is exactly decidable. Acceptance has a real-algebraic source certificate; rejection has a finite negative word with a strictly positive real-algebraic bound (M13).

The following gives the complete decision reduction. Positive algebraic numbers are represented by defining polynomials and isolating data; exact real-algebraic sign tests, sample points, and quantifier elimination are established algorithms [BPR06, Basu14].

For nonsingular states put
$$
c_s=e^{-k_s},\qquad K_s=e^{b_s k_s-h(b_s)}.
$$
These are real algebraic for rational $a_s,b_s$, because they are products of positive rational numbers raised to rational powers. The unique positive root of
$$
K_0c_0t^2+(K_0-K_1c_1)t-K_1=0
\tag{M16}
$$
is the candidate where both Bellman optimizers are interior. Test exactly whether $c_st/(1+c_st)$ is in the open interval between $a_s,b_s$ for both states. If not, the actual optimizer must have a boundary action and strict gain follows. If so, it is the true $R_*$. Test the iid branch exactly, then decide the finite existential formula (M8)--(M9) over the real algebraic field. A feasible sample point supplies algebraic endpoints and hence an algebraic source. Singular branches are decided directly.

To produce the actual optimal rows on a rejected boundary branch, set $G_s(t)=\exp M_s(\log t)$. Its three pieces are $t^{\min(a_s,b_s)}$, $K_s(1+c_st)$, and $t^{\max(a_s,b_s)}$, with the clipping inequalities retained. The equation is $tG_0(t)=G_1(t)$. For a common denominator $D$, substituting $t=z^D$, $z>0$, gives at most nine polynomial branch systems over algebraic coefficients. Isolate roots and retain the branch-consistent positive root; uniqueness of the bias makes it unique, including branch-boundary overlaps. This computes the actual $R_*$ algebraically. In particular $C_f$ is a logarithm of an algebraic number, not necessarily algebraic itself.

Finally, enumerate words and evaluate $A_w\mathbf1$ exactly. On a rejected nonsingular kernel a negative coordinate exists by Theorem 2, so the search terminates; on a support-boundary branch length two suffices. The linear-cost recurrence computes its oscillation and gain bound. Appendix A.4 and A.8 supply the root, sign, branch, and termination details.

No polynomial bit-complexity bound, uniform rejecting-word length bound, or universal raw-parameter semialgebraicity claim is made. The supplied numerical explorer is not described as a complete real-algebraic decision engine. Its certificate verifier and algebraic formula exporter explicitly record which computations were executed. A bounded word search with no negative result is inconclusive.

## 6. Reproducibility, mathematical status, and scope

The code directory separates proposal search from exact certificate verification. The results include fully rational algebraic certificates, rational log/exp bounds where used, direct finite-block inversion checks, source-probability checks, and singular-branch checks. Data and certificate counts are stated in the generated result files.

The mathematical proof package is this text plus the included appendix. The full Lean obligation includes information-theoretic interfaces, cone necessity, source minimality and initial-state handling, entropy/divergence identities, asymptotic gain, and algebraic decision. A compiled finite-certificate core does not certify all those statements. The formalization directory lists the exact passed declarations, permitted-axiom audit, and remaining obligations. Independent internal review is not external peer review.

The 2026 primary source has a final IEEE Transactions on Information Theory version, 72(11), 8195--8210, DOI 10.1109/TIT.2026.3729399. The publication record was checked, but the final journal full text was not obtained for a version-by-version comparison. The technical comparison uses arXiv:2603.08886v1. The originality claim is bounded by the sources actually inspected; worldwide priority is not certified.

## References

- **[ZCW26]** X. Zhang, J. Chen, and G. Wang. *Feedback Does Not Increase the Capacity of Approximately Memoryless Surjective POST Channels*. arXiv:2603.08886v1. https://arxiv.org/html/2603.08886v1. Journal version: https://doi.org/10.1109/TIT.2026.3729399.
- **[PAW14]** H. H. Permuter, H. Asnani, and T. Weissman. *Capacity of a POST Channel With and Without Feedback*. IEEE TIT 60(10), 6041--6057 (2014), arXiv:1309.5440v1. https://arxiv.org/abs/1309.5440.
- **[RSS09]** L. Rodman, H. Seyalioglu, and I. M. Spitkovsky. *On Common Invariant Cones for Families of Matrices*. arXiv:0903.0444v1. https://arxiv.org/abs/0903.0444.
- **[Sch09]** A. Schönhuth. *Equations for Hidden Markov Models*. arXiv:0901.3749v2, especially Section 5 and its attribution to Heller. https://arxiv.org/abs/0901.3749.
- **[SCK16]** P. A. Stavrou, C. D. Charalambous, and C. K. Kourtellaris. *Sequential Necessary and Sufficient Conditions for Capacity Achieving Distributions of Channels with Memory and Feedback*. arXiv:1604.02742v2. https://arxiv.org/abs/1604.02742.
- **[KCT17]** C. K. Kourtellaris, C. D. Charalambous, and I. Tzortzis. *Single Letter Expression of Capacity for a Class of Channels with Memory*. arXiv:1701.01007v1. https://arxiv.org/abs/1701.01007.
- **[KC14]** C. K. Kourtellaris and C. D. Charalambous. *Capacity of Binary State Symmetric Channels with and without Feedback and Transmission Cost*. arXiv:1402.0017v2. https://arxiv.org/abs/1402.0017.
- **[BPR06]** S. Basu, R. Pollack, and M.-F. Roy. *Algorithms in Real Algebraic Geometry*, second edition (2006). https://doi.org/10.1007/3-540-33099-2.
- **[Basu14]** S. Basu. *Algorithms in Real Algebraic Geometry: A Survey*. arXiv:1409.1534. https://arxiv.org/abs/1409.1534.

## Appendix A. Full optimizer, boundary, algebraic-decision, and gap proofs

The appendix was derived independently and integrated with consistent channel conventions. Its sections use $u=P(X=1\mid s)$, $v=V(1)-V(0)$, and natural logarithms. The finite-cone theorem and edge-emitting construction used in the appendix are proved in Sections 2 and 3 above.


### A.1. Model, conventions, and operational inputs

Inputs, outputs, and states are binary. The state before time i is $S_{i-1}=Y_{i-1}$.
The channel is

\[
 Q(y\mid x,s)>0,\qquad \sum_y Q(y\mid x,s)=1
 \quad (x,y,s\in\{0,1\}).
\]

All information quantities use natural logarithms. Put

\[
 a_s=Q(1\mid0,s),\qquad b_s=Q(1\mid1,s),\qquad
 q_s(u)=a_s+(b_s-a_s)u,\quad 0\le u\le1.
\]

The state-channel matrix has output rows and input columns:

\[
 Q_s=\begin{pmatrix}1-a_s&1-b_s\\a_s&b_s\end{pmatrix}.
\]

Thus $Q_s$ is singular precisely when $a_s=b_s$. Write

\[
 h(z)=-z\log z-(1-z)\log(1-z),\qquad
 f_s(u)=h(q_s(u))-(1-u)h(a_s)-u h(b_s).
\]

For a nonfeedback input block, conditional on an initial state, the entire input
word is chosen without access to channel outputs. Arbitrary dependence among
input symbols is allowed. The joint law factors as

\[
 P(x^T,y^T\mid s_0)=P(x^T\mid s_0)
                    \prod_{i=1}^TQ(y_i\mid x_i,y_{i-1}).
\]

Strict positivity supplies uniform indecomposability. Indeed, every one-step
state-transition matrix corresponding to a fixed input has a Dobrushin
contraction coefficient bounded by a common constant strictly below one.
The standard indecomposable finite-state-channel capacity theorem therefore
identifies the nonfeedback operational capacity with the limiting normalized
block mutual information and removes dependence on the initial state.
The feedback operational characterization is the stationary average-reward
formula for connected POST channels.

Primary references for these operational interfaces, not new claims here:

- Permuter, Asnani, Weissman, *Capacity of a POST Channel with and without
  Feedback*, arXiv:1309.5440; IEEE TIT 60(10), 2014.
  https://arxiv.org/pdf/1309.5440
- Zhang, Chen, Wang, *Feedback Does Not Increase the Capacity of Approximately
  Memoryless Surjective POST Channels*, arXiv:2603.08886v1, 2026-03-09.
  Equations (5)--(10) state the relevant capacity interfaces; Theorem 2 already
  gives a general simulation characterization.
  https://arxiv.org/pdf/2603.08886
- Shemuel, Sabag, Permuter, *The Feedback Capacity of Noisy Output is the STate
  (NOST) Channels*, arXiv:2107.07164.
  https://arxiv.org/abs/2107.07164

No result below changes the original coding model by supplying feedback to the
encoder. An initial-state-dependent source construction must be interpreted
through the fixed-initial-state information-rate calculation and the preceding
indecomposability theorem, unless initial-state knowledge is separately assumed.

### A.2. A scalar Bellman construction valid in every branch

For $v\in\mathbb R$ define

\[
 M_s(v)=\max_{0\le u\le1}\{f_s(u)+q_s(u)v\},\qquad
 H(v)=M_1(v)-M_0(v)-v.
\]

If $a_s$ differs from $b_s$, strict concavity of h and the affine injectivity of $q_s$
give a unique maximizing u. If $a_s=b_s$, the expression is independent of u,
but its maximizing output probability is still unique. In either case let
$\rho_s(v)$ be that output probability.

#### Lemma A.2.1: existence and uniqueness of the Bellman bias

There is exactly one v with $H(v)=0$. Each $M_s$ is continuously differentiable,
with derivative $\rho_s(v)$, including at transitions between endpoint and interior
maximizers.

Proof. In the nonsingular case the explicit clipping formula in Appendix A.4
shows that $\rho_s$ is continuous; the envelope identity gives $M_s'=\rho_s$.
In the singular case $M_s(v)=a_s v$. Let
$m_s^q=\min(a_s,b_s)$, $M_s^q=\max(a_s,b_s)$. Then

\[
 H'(v)=\rho_1(v)-\rho_0(v)-1
       \le M_1^q-m_0^q-1<0.
\]

For v at most zero, the endpoint of $q_s$ with value $m_s^q$ has zero mutual
information, and $0\le f_s\le\log 2$, so

\[
 m_s^qv\le M_s(v)\le m_s^qv+\log2.
\]

Consequently $H(v)$ tends to plus infinity as v tends to minus infinity, because
$m_1^q-m_0^q-1<0$. The corresponding bounds
$M_s^qv\le M_s(v)\le M_s^qv+\log2$ for v at least zero show that $H(v)$ tends to minus
infinity at plus infinity. Continuity and strict decrease prove the claim.

Fix this v. Let $V(0)=0$, $V(1)=v$, let $u_s^*$ be a maximizing action (arbitrary
when $Q_s$ is singular), put $\rho_s=\rho_s(v)$, and set $C_f=M_0(v)$. Then

\[
 C_f+V(s)
 =\max_u\left\{f_s(u)+\sum_yQ_u(y\mid s)V(y)\right\}.
 \tag{A.2.1}
\]

The output transition matrix $R^*$ is determined by
$R^*(s,1)=\rho_s$, $R^*(s,0)=1-\rho_s$. It is strictly positive. In nonsingular
states $u_s^*$ is unique and recovered from
$(\rho_s-a_s)/(b_s-a_s)$, irrespective of the sign of $b_s-a_s$.

#### Proposition A.2.2: the Bellman value is the feedback value

For any causal feedback strategy and any fixed initial state,

\[
 I(X^T\mathbin{\to}Y^T\mid S_0)
 \le TC_f+\mathbb E V(S_0)-\mathbb E V(S_T).
 \tag{A.2.2}
\]

For the stationary maximizing policy $u_s^*$, equality holds at every finite T.
Thus its directed-information rate is $C_f$, and the feedback operational
characterization identifies this with feedback capacity.

Proof. Given an output history, the next-symbol mutual information is $f_s(u)$,
where u is the conditional probability of $X_i$=1 and s is the last output.
Apply (A.2.1) and telescope the bias. No stationarity is required for the upper
bound. Under $u_s^*$ the Bellman inequality is an equality at every history.
The bias contribution divided by T vanishes since $|V(1)-V(0)|=|v|$ is finite.

If at least one state is nonsingular, $C_f>0$. To see this, choose any fixed
$u\in(0,1)$ independently at every time. In a nonsingular state strict
concavity gives $f_s(u)$>0, and the induced positive output transition matrix
has a stationary law giving that state positive mass. Its information rate
is strictly positive.

### A.3. Singular state channels: iid input attains feedback capacity

#### Proposition A.3.1

If either $Q_0$ or $Q_1$ is singular, feedback does not increase capacity.
An iid binary input achieves $C_f$.

Proof. If both are singular, the output process is independent of the input
and both capacities are zero.

Otherwise let s be the nonsingular state. Use iid $\operatorname{Ber}(u_s^*)$ inputs.
At that state the input law is exactly its Bellman optimizer. At the singular
state both f and q are independent of the input mixture, so every mixture is
Bellman-optimal. Hence (A.2.1) is an equality at every time under this iid law.
For a nonfeedback input, directed information equals
$I(X^T;Y^T\mid S_0)$. It follows that

\[
 I(X^T;Y^T\mid S_0)
 =TC_f+\mathbb E V(S_0)-\mathbb E V(S_T).
 \tag{A.3.1}
\]

The information rate is $C_f$. The standard indecomposable-channel
characterization yields the operational statement.

The conclusion includes a singular channel with a strictly interior common
column; no zero transition probability is needed. In the rational-input
algorithm, singularity is checked exactly before any inverse is formed.

### A.4. Algebraic feedback optimizer for rational channels

Assume here that every $a_s$,$b_s$ is rational and lies strictly between zero and
one. The procedure also covers a singular state without dividing by $a_s-b_s$.

For a nonsingular state define

\[
 k_s=\frac{h(a_s)-h(b_s)}{a_s-b_s},\quad
 c_s=e^{-k_s},\quad
 K_s=e^{a_sk_s-h(a_s)}=e^{b_sk_s-h(b_s)}.
\]

The equality of the two expressions for $K_s$ follows directly from the
definition of $k_s$. Put $t=e^v$ and $G_s(t)=e^{M_s(\log t)}$.

#### Lemma A.4.1: exact branches

Let $m=\min(a_s,b_s)$, $M=\max(a_s,b_s)$, and
$z_s(t)=c_st/(1+c_st)$. Then

\[
 G_s(t)=
 \begin{cases}
 t^m,&z_s(t)\le m,\\
 K_s(1+c_st),&m\le z_s(t)\le M,\\
 t^M,&z_s(t)\ge M .
 \end{cases}
 \tag{A.4.1}
\]

The maximizing output probability is the clipping of $z_s(t)$ to [m,M].
At a shared endpoint the adjacent expressions in (A.4.1) agree.
For a singular state, simply $G_s(t)=t^{a_s}$, $\rho_s=a_s$.

Proof. Reparameterize the action by its output probability q. The affine
conditional entropy is $h(a_s)+(q-a_s)k_s$, so the exponent being maximized is

\[
 h(q)+(\log t-k_s)q+a_sk_s-h(a_s).
\]

Its unconstrained maximum is at $z_s(t)$, and its unconstrained value is
$\log K_s+\log(1+c_st)$. Strict concavity and clipping give the constrained
maximum. At either endpoint the action is deterministic and $f_s$=0,
giving the stated monomial. This argument remains valid when $b_s$<$a_s$.

#### Lemma A.4.2: effective algebraicity of the coefficients

For rational $r\in(0,1)$, $E(r)=r^r(1-r)^{1-r}$ is a positive real algebraic
number with an effective exact representation. Moreover,

\[
 c_s=\left(\frac{E(a_s)}{E(b_s)}\right)^{1/(a_s-b_s)},\qquad
 K_s=E(b_s)^{a_s/(a_s-b_s)}E(a_s)^{-b_s/(a_s-b_s)}.
 \tag{A.4.2}
\]

Every rational power here means its unique positive real value. Products,
quotients, and rational powers of positive real algebraic numbers are
effectively real algebraic: reduce rational powers to a polynomial equation
and select the positive root by real-root isolation. Thus $c_s$,$K_s$ can be
computed without numerical evaluations of logarithms or exponentials.

#### Theorem A.4.3: terminating exact optimizer computation

The optimal output kernel $R^*$ has real algebraic entries. It is computable by
a terminating exact algebraic procedure. $C_f$ is the logarithm of a positive
real algebraic number; it is not asserted to be algebraic itself.

Proof and algorithm:

1. Construct the algebraic coefficients in (A.4.2).
2. List the at most nine branch pairs from (A.4.1), using only one branch for
   a singular state.
3. Let D be a positive common denominator of the four rational channel
   probabilities, and substitute t=z^D with z>0.
4. For each branch pair form

\[
 P(z)=z^D G_0(z^D)-G_1(z^D).
 \tag{A.4.3}
\]

   This is a polynomial over the real algebraic numbers. Its degree is at
   most 2D. It is not the zero polynomial: the highest degree of the first
   term is strictly larger than D, with positive coefficient, whereas the
   degree of the second term is at most D.
5. Isolate every positive real root of P. Check the branch inequalities
   exactly at each root, using algebraic sign comparison.
6. Discard roots outside the corresponding branches and identify duplicate
   roots from overlapping boundary branches.

Lemma A.2.1 guarantees that exactly one positive t survives globally.
The output probabilities are then rational endpoints or the algebraic
expressions $c_st/(1+c_st)$. This proves algebraicity and termination.
Finally $e^{C_f}=G_0(t)$ is positive algebraic.

This algorithm explicitly handles branch equalities. It never relies on
floating-point signs. An isolation implementation can first take the
square-free part of a polynomial; that operation does not remove roots.
Extraneous roots introduced by eliminating algebraic coefficients must be
checked in the original algebraic field and against the branch conditions.
Roots at z=0 are excluded.

At a retained positive root, the derivative of tG_0(t)-$G_1(t)$ is

\[
 G_0(t)\,[1+\rho_0-\rho_1]>0.
\]

Thus no valid branch root is multiple before coefficient elimination and
unnecessary polynomial multiplication. The root-isolation procedure still
must not presume that its raw polynomial representation is square-free.

### A.5. A finite-horizon divergence deficit, including endpoint optima

The argument here is independent of stationary-input assumptions.

#### Lemma A.5.1: Bellman slack dominates output divergence

For every state s and feasible input mixture u,

\[
 C_f+V(s)-f_s(u)-q_s(u)v
 \ge D\bigl(\operatorname{Ber}(q_s(u))
                   \,\|\,\operatorname{Ber}(\rho_s)\bigr).
 \tag{A.5.1}
\]

Proof. In a nonsingular state write
$g(q)=h(q)+(v-k_s)q+a_sk_s-h(a_s)$. If r=$\rho_s$ maximizes g on the feasible
interval, then $g'(r)(q-r)\le0$ for every feasible q, including when r is an
endpoint. The entropy identity gives

\[
 g(r)-g(q)
 =D(\operatorname{Ber}(q)\|\operatorname{Ber}(r))
       -g'(r)(q-r).
\]

This proves (A.5.1). In a singular state q=r always, and both sides are zero.
All probabilities are strictly inside (0,1), so the displayed derivatives
and divergences are finite even when the input action is an endpoint.

For an initial state s, let $r_s^{(T)}$ be the length-$T$ Markov output law
with transition $R^*$ and initial state s.

#### Theorem A.5.2: exact finite-$T$ inequality

For every nonfeedback input law, even if nonstationary and dependent across
time, and every distribution of $S_0$,

\[
 \begin{split}
 I(X^T;Y^T\mid S_0)
 &\le TC_f+\mathbb E V(S_0)-\mathbb E V(S_T)\\
 &\quad-
 D\bigl(P_{Y^T\mid S_0}\,\|\,r_{S_0}^{(T)}
                      \mid P_{S_0}\bigr).
 \end{split}
 \tag{A.5.2}
\]

Proof. Conditional on $S_0$ and each output history, set
$u_i=P(X_i=1\mid Y^{i-1},S_0)$. The nonfeedback factorization implies

\[
 I(X^T;Y^T\mid S_0)=
 \sum_{i=1}^T\mathbb E f_{S_{i-1}}(u_i).
\]

In particular, conditioning on future input symbols does not change the
one-step channel law after $X_i$ and $Y_{i-1}$ are specified. Sum (A.5.1),
telescope the bias, and use the chain rule for relative entropy against
the positive Markov law $R^*$. This proves (A.5.2).

Consequently, with $B=|v|$,

\[
 I(X^T;Y^T\mid S_0)
 \le TC_f+B-
 D\bigl(P_{Y^T\mid S_0}\,\|\,r_{S_0}^{(T)}\mid P_{S_0}\bigr).
 \tag{A.5.3}
\]

No optimal stationary distribution appears in this uniform bound.

### A.6. Negative inverse words give a uniform strict capacity gap

Assume both $Q_s$ are invertible. Define the length-$n$ channel matrix

\[
 K_s^{(n)}(y^n,x^n)=\prod_{i=1}^nQ(y_i\mid x_i,y_{i-1}),\quad y_0=s.
\]

It is invertible. Indeed, with lexicographic ordering of first symbols,

\[
 K_s^{(n)}
 =\operatorname{diag}(K_0^{(n-1)},K_1^{(n-1)})
                 (Q_s\otimes I_{2^{n-1}}),
\]

which proves invertibility inductively. The empty-word channel is the scalar 1.

For a fixed input word w of length n let

\[
 \ell=(K_s^{(n)})^{-1}_{w,\cdot},\qquad
 p_s^*(w)=\ell r_s^{(n)}=-c<0,\qquad
 L=\max_y\ell_y-\min_y\ell_y.
\]

Here L>0. A constant row could not satisfy
$\ell K_s^{(n)}=e_w^\top$ when $n\ge1$, because $K_s^{(n)}$ is column stochastic and
$e_w^T$ is nonconstant.

#### Lemma A.6.1: uniform block separation

For every probability law lambda on the next n inputs and
$z=K_s^{(n)}\lambda$,

\[
 D(z\|r_s^{(n)})\ge \frac{2c^2}{L^2}=:\delta.
 \tag{A.6.1}
\]

Proof. Since $\ell z=\lambda(w)\ge0$ and $\ell r=-c$,
$\ell(z-r)\ge c$. The signed measure z-r has total mass zero, so

\[
 |\ell(z-r)|\le L\,\operatorname{TV}(z,r).
\]

Therefore $\operatorname{TV}(z,r)\ge c/L$. Pinsker's inequality with natural logarithms gives
$D(z\|r)\ge2\operatorname{TV}(z,r)^2$. Positivity of r makes the divergence well defined.

#### Lemma A.6.2: conditional blocks remain in the nonfeedback channel simplex

For any nonfeedback law of length T, condition on $S_0$ and an arbitrary
positive-probability output history through time k. If $S_k$=s, then

\[
 P(Y_{k+1}^{k+n}\mid Y^k,S_0)
 =K_s^{(n)}P(X_{k+1}^{k+n}\mid Y^k,S_0).
 \tag{A.6.2}
\]

Proof. Conditioning on past outputs reweights the law of the already-chosen
future input word, but does not turn it into a feedback encoder. Given that
word and the present state, the future channel transitions retain exactly
their defining product law. Summing over the posterior input word proves
(A.6.2). Correlations between past and future input symbols are fully allowed.

Set

\[
 \underline m_s=\min_{r,x}Q(s\mid x,r)>0.
\]

For every time $k\ge1$ and every initial-state law,
$P(S_k=s)\ge\underline m_s$. This follows by averaging the one-step channel
probability over the joint law of ($S_{k-1}$,$X_k$).

#### Theorem A.6.3: finite-$T$ and asymptotic gap certificates

Let $J_T=\lfloor(T-1)/n\rfloor$. For every nonfeedback input law,

\[
 I(X^T;Y^T\mid S_0)
 \le TC_f+B
       -J_T\underline m_s\,\frac{2c^2}{L^2}.
 \tag{A.6.3}
\]

In particular,

\[
 \boxed{\quad C_f-C\ge
       \frac{2\underline m_s c^2}{nL^2}>0.\quad}
 \tag{A.6.4}
\]

Proof. Split the output string into an initial one-symbol prefix, then $J_T$
disjoint length-$n$ blocks, and a final remainder. The block starts are
$k_j=1+jn$, $j=0,\ldots,J_T-1$. Apply the relative-entropy chain rule at these
boundaries. Prefix and remainder terms are nonnegative.

Given a block history, the reference conditional output law is
$r_{S_{k_j}}^{(n)}$. Whenever $S_{k_j}=s$, (A.6.1)--(A.6.2) lower-bound the conditional
block divergence by delta. Therefore

\[
 D(P_{Y^T\mid S_0}\|r_{S_0}^{(T)}\mid P_{S_0})
 \ge\delta\sum_{j=0}^{J_T-1}P(S_{k_j}=s)
 \ge J_T\underline m_s\delta.
\]

Combine with (A.5.3) to obtain (A.6.3). Maximize over all nonfeedback input laws,
divide by T, and use $J_T/T\to1/n$ and the indecomposable capacity theorem.
This proves (A.6.4).

The one-symbol discarded prefix avoids any assumption on $S_0$. The bound
does not assume that the input law, the state law, or the full process is
stationary. Replacing $\underline m_s$ by the optimal-feedback stationary mass
would not be justified by this proof.

### A.7. Endpoint policies force a length-two obstruction

Assume both state matrices are nonsingular. Then $C_f>0$ by Proposition A.2.2.
Write $u_s=u_s^*$.

The inverse recursion for a prescribed Markov output kernel uses

\[
 A_x(s,t)=Q_s^{-1}(x,t)R^*(s,t),\qquad
 p_s^*(x_1\cdots x_n)=e_s^\top A_{x_1}\cdots A_{x_n}\mathbf1.
 \tag{A.7.1}
\]

This identity follows from the block factorization of $K_s^{(n)}$. In
particular $A_1\mathbf1=(u_0,u_1)^\top$ and $A_0\mathbf1=(1-u_0,1-u_1)^\top$.

#### Theorem A.7.1: every endpoint optimum gives strict feedback gain

If $u_s$ is 0 or 1 for either state, some $p_s^*(w)$ with $|w|=2$ is negative,
and hence $C<C_f$.

Proof. Suppose $u_s$=0. Since $\rho_s=a_s$,

\[
 A_1(s,\cdot)
 =\kappa_s(-1,1),\qquad
 \kappa_s=\frac{a_s(1-a_s)}{b_s-a_s}\ne0.
\]

Thus

\[
 p_s^*(11)=\kappa_s(u_1-u_0),\qquad
 p_s^*(10)=-\kappa_s(u_1-u_0).
\]

If $u_0=u_1$, they are both 0, so the unique maximizing action in both
states is the same deterministic input. Its directed-information rate
is zero, contradicting $C_f>0$. Hence the displayed numbers are nonzero
opposites and one is negative.

If $u_s$=1, analogously

\[
 A_0(s,\cdot)
 =\kappa'_s(1,-1),\qquad
 \kappa'_s=\frac{b_s(1-b_s)}{b_s-a_s}\ne0,
\]

and $p_s^*(01)=\kappa'_s(u_0-u_1)$,
$p_s^*(00)=\kappa'_s(u_1-u_0)$. Equality $u_0=u_1$ would make both policies
deterministically 1 and again contradict $C_f>0$. Apply Theorem A.6.3.

This proof includes an endpoint optimum whose first derivative happens
to be exactly zero. Strict complementary slackness is not required.

### A.8. A simpler exact equality decision needs only one quadratic

The general branch algorithm in Appendix A.4 is useful when the actual feedback
optimizer and a quantitative negative certificate are requested. Equality
classification itself admits the following shorter procedure.

For two nonsingular state matrices form $c_s$,$K_s$ and the quadratic

\[
 K_0c_0t^2+(K_0-K_1c_1)t-K_1=0.
 \tag{A.8.1}
\]

Its leading coefficient is positive and its constant term is negative,
so it has exactly one positive root tau. Put

\[
 \widehat\rho_s=\frac{c_s\tau}{1+c_s\tau}.
\]

#### Proposition A.8.1

If either $\widehat\rho$ fails to lie strictly between $a_s$ and $b_s$, then $C<C_f$.
If both lie strictly between their endpoints, tau is the true Bellman
solution, $\widehat\rho=\rho$, and $R^*$ is exactly the resulting algebraic kernel.

Proof. If both candidates are strictly feasible, the interior expressions
are the true branches and (A.8.1) is exactly the Bellman equation. Uniqueness
from Lemma A.2.1 proves the identification.

Conversely, if the actual optimizers in both states were interior, their
positive t would satisfy the same quadratic and thus equal tau. Therefore
failure of strict feasibility forces an actual endpoint optimizer in at
least one state. Theorem A.7.1 gives strict feedback gain. This includes
$\widehat\rho$ equal to an endpoint; it must not be accepted as an equality case.

In the strictly feasible branch compute $A_0$,$A_1$ algebraically. If $u_0=u_1$,
the iid law with that common mixture is Bellman-optimal and $C=C_f$.
Otherwise the remaining cone test is a sentence over the real algebraic
numbers in two real variables.

For completeness, use the reversed coordinate convention $v_z=(z,1-z)^\top$ in this subsection. It describes the same set of cones as $r_z=(1-z,z)^\top$ in Section 2, with exchanged endpoint labels and reversed determinant signs. Normalize the candidate extreme rays as

\[
 v_l=(l,1-l)^T,\qquad v_u=(u,1-u)^T,\qquad
 0\le l<1/2<u\le1.
\]

For each $x\in\{0,1\}$, impose

\[
 \begin{array}{ll}
 \det(v_l,A_xv_l)\le0,&\det(A_xv_l,v_u)\le0,\\
 \det(v_l,A_xv_u)\le0,&\det(A_xv_u,v_u)\le0 .
 \end{array}
 \tag{A.8.2}
\]

Because $\det(v_l,v_u)=l-u<0$, these inequalities say precisely that both
images of the extreme rays lie in their positive hull. They are eight
polynomial inequalities of degree at most two in l,u.

Using the separately proved equivalence between inverse-word positivity
and an invariant cone containing 1, existence in (A.8.2) is equivalent to
$C=C_f$. It is decidable by quantifier elimination over a real closed field.
This is an exact terminating algorithm, not a claimed efficient one.

A nonempty semialgebraic set defined over the real algebraic numbers has
a real algebraic sample point, obtainable by the same decision machinery.
Therefore in the equality case a cone and the derived two-state
edge-emitting hidden Markov source can be returned with real algebraic
coefficients.

If the cone test fails, enumerate binary words and initial states and
compute $p_s^*(w)$ exactly. The invariant-cone equivalence guarantees that
some negative word exists, so this enumeration terminates on this branch.
Its inverse-channel row yields the algebraic certificate in (A.6.4).
In the endpoint branch, Appendix A.4 first computes the actual $R^*$, and
Theorem A.7.1 directly produces a length-two negative word.

The complete rational-channel procedure is:

1. Detect a singular state: answer equality and construct the iid optimizer.
2. Otherwise solve (A.8.1) exactly.
3. If strict interior feasibility fails: answer strict gain; compute the
   actual optimizer by Appendix A.4 only when a quantitative certificate is wanted.
4. If the optimal state input mixtures coincide: answer equality with iid input.
5. Otherwise decide (A.8.2). Return the algebraic two-state source on acceptance,
   or enumerate a negative word and return (A.6.4) on rejection.

### A.9. Independent exact strictly positive gain example

Take

\[
 (a_0,b_0)=(1/10,1/5),\qquad
 (a_1,b_1)=(1/10,9/10).
\]

These are strictly positive, nonsingular state channels. Let

\[
 K=(1/10)^{1/10}(9/10)^{9/10}.
\]

There is a unique t in (3/2,2) satisfying

\[
 t^{6/5}=K(1+t).
 \tag{A.9.1}
\]

Indeed t^(6/5)/(1+t) is strictly increasing for t>0. At 3/2, comparison
with K after raising to the tenth power reduces to $2^8<3^6$.
At 2 the opposite comparison reduces to

\[
 2^{12}10^{10}>3^{28}.
\]

Both are exact integer inequalities.

The endpoint threshold at state 0 is

\[
 t_0=\exp\left(\frac{D(\operatorname{Ber}(1/10)
                       \|\operatorname{Ber}(1/5))}{1/10}\right)
     =\frac12(9/8)^9<3/2,
\]

where the last comparison is $9^9<3\cdot8^9$. Thus $u_0^*$=1.
At state 1, $k_1$=0, so $\rho_1$=t/(1+t) lies in (3/5,2/3), strictly inside
(1/10,9/10). Consequently the proposed branches satisfy the Bellman
equation and

\[
 C_f=\frac15\log t,\qquad
 \rho_1=\frac{t}{1+t},\qquad
 u_1^*=\frac{\rho_1-1/10}{4/5}.
\]

For initial state 0 and input word 00, the corresponding row of the
inverse length-two channel, in output order 00,01,10,11, is exactly

\[
 \ell=(4,-16,-9,1),\qquad L=20.
\]

Direct multiplication verifies $\ell K_0^{(2)}=(1,0,0,0)$. Its action on the
feedback-optimal output law is

\[
 p_0^*(00)=2\rho_1-\frac95<-\frac7{15}.
\]

As $\underline m_0=1/10$ and n=2, Theorem A.6.3 yields the entirely rational
strict certificate

\[
 \boxed{\quad C_f-C>\frac{49}{900000}
                 \ \text{nats per use}.\quad}
 \tag{A.9.2}
\]

No numerical optimization is needed for this certificate. A floating-point
sanity check, not used in its proof, gave
t approximately 1.7973936467, $\rho_1$ approximately 0.6425243901,
$C_f$ approximately 0.1172675283 nats/use, and the unrounded certificate
$c^2/4000$ approximately 0.00006629369.

An independent Python-standard-library check run in this review used exact
fractions to multiply the inverse row by the channel and exact integers to
check the three displayed comparisons. All passed. The floating-point root
was separately bisected for a sanity check; it is not an exact-arithmetic
or Lean proof.



# Part II. Quantitative stationary memory penalties

## Abstract

Consider a strictly positive binary POST channel with invertible state-channel matrices and a nonfeedback input that exactly simulates the feedback-optimal output process. We prove a quantitative stability inequality for every stationary autonomous input law, including nonergodic laws: its length-\(n\) input marginal is within
\[
L^n\left(\sqrt n+\frac1{1-\tau}\right)
       \sqrt{\frac{C_f-I_\infty}{2}}
\]
in total variation of a specified stationary attaining input law. Here \(L\) is an explicit inverse-channel column norm and \(\tau<1\) is the Dobrushin coefficient of the optimal output kernel. In particular, the stationary attaining input distribution is unique.

A finite-cylinder polynomial that vanishes on a class of inputs then yields a uniform, explicit information-rate penalty for the entire class. Applied to the run identity of a \(k\)-step Markov process, this gives a positive bound at every finite order whenever a two-dimensional target determinant certificate is nonzero. For the rational channel
\[
(a_0,b_0,a_1,b_1)=(1/4,3/4,3/10,7/10),
\]
the bound is
\[
C-C_k\ge
\frac{9}{1250000000(k+2)}
\left(\frac9{15625}\right)^k>0,
\qquad k=0,1,2,\ldots.
\]
The proof treats the joint initial-state/output block before applying the inverse channel. It covers zero-probability input contexts and does not use compactness to replace a quantitative separation argument.

Infinite-memory hidden Markov outputs, finite-order rank criteria, and quadratic capacity-loss arguments have substantial prior foundations. The proposed increment is the explicit connection between stationary POST information-rate deficit, state-marginal correction, inverse-block stability, and finite-cylinder constraints. This supplement does not claim a new general hidden-Markov rank theorem or a sharp dependence on \(k\).

## 1. Model, prior context, and exact assumptions

### 1.1 The channel and the stationary input class

Inputs and outputs take values in \(\{0,1\}\). The channel is
\[
Q(y\mid x,s)>0,\qquad s=Y_{i-1},\qquad
a_s=Q(1\mid0,s),\quad b_s=Q(1\mid1,s).
\]
All four parameters belong to \((0,1)\), and
\[
Q_s=
\begin{pmatrix}1-a_s&1-b_s\\ a_s&b_s\end{pmatrix},
\qquad a_s\ne b_s.
\tag{S1}
\]
The matrix has output rows and input columns. Natural logarithms are used.

An autonomous stationary input is a shift-invariant probability law \(\mu\) on \(\{0,1\}^{\mathbb Z}\), sampled independently of the channel innovations. The input never observes channel outputs. Its canonical stationary channel extension is constructed in Section 2. Ergodicity, positive input probabilities, and positive Markov transition probabilities are not assumed.

Write
\[
I_\infty(\mu;Q)=
\lim_{N\to\infty}\frac1N I(X_1^N;Y_1^N).
\tag{S2}
\]
The limit exists for the stationary extension, as proved below. It agrees with the rate for an arbitrary independent physical initial state. Define
\[
C_k=\sup_{\mu\in\mathcal M_k} I_\infty(\mu;Q),
\tag{S3}
\]
where \(\mathcal M_k\) consists of all stationary input laws of Markov order at most \(k\). Order zero means iid. This is an information-rate restriction on the input process; it is not a claim about arbitrary time-varying encoders or the computational memory of a coding algorithm.

### 1.2 The feedback coefficients and the exact simulation assumption

For \(u\in[0,1]\), put
\[
q_s(u)=a_s+(b_s-a_s)u,\qquad
f_s(u)=h(q_s(u))-(1-u)h(a_s)-u h(b_s),
\]
where \(h\) is binary entropy. Let
\[
M_s(v)=\max_{0\le u\le1}\{f_s(u)+q_s(u)v\}.
\]
The scalar equation \(M_1(v)-M_0(v)-v=0\) has one root. Indeed, its derivative is \(\rho_1(v)-\rho_0(v)-1<0\), uniformly bounded away from zero, where \(\rho_s(v)\) is the unique maximizing output probability. Endpoint bounds give opposite signs at the two infinities. The proof also covers clipping transitions. Let
\[
V(0)=0,\quad V(1)=v,\quad C_f=M_0(v),\quad
R(s,1)=\rho_s,\quad R(s,0)=1-\rho_s.
\]
The Bellman equation is
\[
C_f+V(s)=
\max_u\{f_s(u)+\mathbb E[V(Y_i)\mid Y_{i-1}=s,u]\}.
\tag{S4}
\]
The positive matrix \(R\) has a unique positive stationary row law \(\pi\). These feedback-capacity and operational capacity interfaces are the standard connected/indecomposable POST interfaces [ZCW26, Section II]; the main manuscript proves the scalar optimizer calculation in Appendix A.2.

Define
\[
A_x(s,y)=Q_s^{-1}(x,y)R(s,y),\qquad
A_0+A_1=R,\qquad
p_s(w)=e_s^\top A_w\mathbf1.
\tag{S5}
\]
Products follow the temporal order of the input word. The exact hypothesis used in this supplement is
\[
p_s(w)\ge0
\quad\text{for every finite word \(w\) and both states \(s\).}
\tag{E}
\]
The finite-cone theorem in the main manuscript decides (E), and identifies it with \(C=C_f\) in the nonsingular class. The proofs below can instead take (E) directly as their assumption; they do not require a numerical capacity computation.

Under (E), define the target stationary input law by
\[
\mu_*[w]=\pi A_w\mathbf1.
\tag{S6}
\]
Section 2 verifies that this is a genuine stationary autonomous input law with \(I_\infty(\mu_*;Q)=C_f\). In particular, the standard operational capacity interface gives \(C=C_f\).

### 1.3 Relation to existing work

The supplementary collision review, secondary/IDEA_COLLISION.md and secondary/IDEA_COLLISION.json, records a “near” finding and distinguishes the claims pursued here from their predecessors. Permuter–Asnani–Weissman already exhibit a stationary infinite-memory attaining input for a POST family [PAW14]. The Heller/Holland finite-Markov-order criterion, as reviewed in [BP10, Theorem 5.1], already excludes finite order when a minimal representation has a suitable invertible symbol product. Those facts are not claimed as new.

Han–Marcus–Wu use the stationary fixed-order optimization corresponding to (S3) and discuss the distinction between approximation as the order grows and strict loss at each fixed order [HMW23, Section 3]. Their principal models are factor codes, and their input-constrained BSC discussion is a different problem. This supplement claims no solution to that BSC question. The decreasing lower bounds below also remain compatible with Markov approximation results such as [CS08].

Quadratic capacity stability has earlier finite-channel forms [NC25, CT22]. The proof here is a specific stationary-channel argument with an explicit correction for the actual state marginal. A separate BSSC first-order-attainment claim requires the comparison recorded in Section 9.

## 2. Stationary channel extensions and the target law

### Lemma 1. Canonical stationary extension

Every autonomous stationary binary input law has a unique causal stationary extension through the strictly positive channel. For any finite interval,
\[
P(X_1^n=x^n,Y_1^n=y^n\mid Y_0=s)
=P(X_1^n=x^n\mid Y_0=s)
 \prod_{i=1}^n Q(y_i\mid x_i,y_{i-1}).
\tag{S7}
\]
The input is allowed to be correlated with the stationary physical state \(Y_0\). This correlation comes from the input's past and does not provide feedback.

**Proof.** Sample a two-sided stationary input and independent iid uniform innovations \(U_i\). Use the random maps
\[
Y_i=\mathbf1\{U_i\le Q(1\mid X_i,Y_{i-1})\}.
\]
For each input symbol \(x\), the map of the previous state is constant with probability
\[
1-\bigl|Q(1\mid x,0)-Q(1\mid x,1)\bigr|.
\]
Its minimum over \(x\) is a positive constant \(\delta_Q\). Conditional on the whole input path, starting the recursion in two different states at time \(-m\) gives identical states by time zero except on an event of probability at most \((1-\delta_Q)^m\). A constant random map in the finite past removes every earlier-state choice. The limit from the infinite past therefore exists almost surely and is independent of the starting state.

The construction commutes with shifts and hence gives a stationary joint law. The same uniform forgetting proves uniqueness among causal channel extensions with these independent innovations. Since \(Y_0\) depends only on the input past and innovations through time zero, future innovations are independent of \(Y_0\) and of the entire input path. Conditioning on a future input block and then integrating the innovations proves (S7). No mixing or ergodicity property of the input is used. \(\square\)

### Lemma 2. Information-rate identity and physical initialization

For the stationary extension,
\[
I_\infty(\mu;Q)=
h(Y)-\mathbb E\,h\!\left(Q(1\mid X_0,Y_{-1})\right),
\tag{S8}
\]
where
\[
h(Y)=H(Y_0\mid Y_{-\infty}^{-1}).
\]
The same rate is obtained if the stationary input is used with an arbitrary independent physical initial state.

**Proof.** By (S7),
\[
H(Y_1^N\mid X_1^N,Y_0)
=\sum_{i=1}^N
 \mathbb E\,h\!\left(Q(1\mid X_i,Y_{i-1})\right).
\]
Adding \(Y_0\) to the conditioning changes the conditional entropy by a number between zero and \(\log2\). Stationarity makes each summand equal. Also \(H(Y_1^N)/N\) converges to the displayed entropy rate for every stationary finite-alphabet process, including nonergodic processes. This proves (S8) and existence of (S2).

For the initialization assertion, couple the stationary physical process and the process started independently in an arbitrary state using the same entire input path and future innovations. Their meeting time has a geometric tail bounded by \((1-\delta_Q)^j\). After meeting they coincide. The two output blocks differ only before that time. Encoding the meeting time and the differing binary prefix bounds both directional conditional entropies by a constant independent of \(N\). The bound is uniform conditional on the entire input path and hence also holds conditional on \(X_1^N\). Both output entropies and both output entropies conditional on inputs therefore differ by \(O(1)\), so the mutual-information rates agree. \(\square\)

### Lemma 3. A stationary attaining input

Under (E), (S6) defines a stationary autonomous input law. Its stationary output process has transition matrix \(R\), and
\[
I_\infty(\mu_*;Q)=C_f.
\tag{S9}
\]

**Proof.** Since \(R\mathbf1=\mathbf1\) and \(\pi R=\pi\), the nonnegative coefficients (S6) have total mass one and are consistent under summing either the first or the last input letter. They therefore define a stationary process.

For completeness, a compatible stationary joint channel process can be specified by the finite laws
\[
\Pr(Y_0=s,X_1^n=x^n,Y_1^n=y^n)
=\pi(s)p_s(x^n)
 \prod_{i=1}^nQ(y_i\mid x_i,y_{i-1}).
\tag{S10}
\]
Right consistency follows from input-prefix consistency. Left consistency follows from
\[
\sum_x Q(y\mid x,s)A_x(s,t)=R(s,t)\mathbf1_{\{t=y\}},
\tag{S11}
\]
followed by \(\pi R=\pi\). Explicitly, for any word \(w\),
\[
\sum_{s,x}\pi(s)Q(y\mid x,s)p_s(xw)
=\pi(y)p_y(w).
\]
Thus (S10) is a consistent stationary joint family. In each finite factorization, condition on an input interval containing time \(i\) and on all outputs in that interval before \(i\); sum out its later outputs. The conditional law of \(Y_i\) is exactly \(Q(\cdot\mid X_i,Y_{i-1})\). Increasing the input interval in both directions and the observed output past, conditional-expectation martingale convergence gives
\[
P(Y_i=y\mid X_{\mathbb Z},Y_{-\infty}^{i-1})
=Q(y\mid X_i,Y_{i-1}).
\]
For each whole input path, uniform forgetting makes the two-sided output law with these transition probabilities unique. It is the law obtained from the independent innovations in Lemma 1. Consequently (S10) is the autonomous stationary extension of its input marginal.

The block inverse identity proved in Lemma 6 below, or repeated use of (S11), shows that its output block law is the stationary Markov law with transition \(R\). At each output history, nonsingularity of \(Q_s\) then recovers the maximizing input mixture from the next-output row. Its information rate is \(\sum_s\pi(s)f_s(u_s^*)\), which equals \(C_f\) by (S4) and stationarity. \(\square\)

## 3. From information-rate deficit to output-block stability

Let
\[
\mathcal F_-=\sigma(Y_j:j\le-1),\qquad
u_-=P(X_0=1\mid\mathcal F_-),\qquad
q_-=P(Y_0=1\mid\mathcal F_-).
\]
Autonomy gives \(q_-=q_{Y_{-1}}(u_-)\). Define
\[
g(\mu)=C_f-I_\infty(\mu;Q),
\qquad
d(\mu)=
\mathbb E D\!\left(
 \operatorname{Ber}(q_-)\,\middle\|\,
 \operatorname{Ber}(\rho_{Y_{-1}})
\right).
\tag{S12}
\]
Both are finite. The expectation in \(d\) is taken under the input's actual stationary channel extension.

### Lemma 4. Stationary Bellman deficit

For every stationary autonomous input,
\[
0\le d(\mu)\le g(\mu).
\tag{S13}
\]

**Proof.** For a state \(s\), use output probability \(q\) as the action coordinate. The function maximized in the Bellman equation is
\[
G_s(q)=h(q)+(v-k_s)q+a_sk_s-h(a_s),\qquad
k_s=\frac{h(a_s)-h(b_s)}{a_s-b_s}.
\]
If \(r=\rho_s\) maximizes it on the interval between \(a_s\) and \(b_s\), then
\[
G_s(r)-G_s(q)
=D(\operatorname{Ber}(q)\|
      \operatorname{Ber}(r))-G_s'(r)(q-r)
\ge D(\operatorname{Ber}(q)\|
          \operatorname{Ber}(r)).
\tag{S14}
\]
The last inequality remains true at a boundary optimum. All feasible output probabilities are strictly inside \((0,1)\).

By (S8) and conditioning its linear conditional-entropy term on \(\mathcal F_-\),
\[
I_\infty(\mu;Q)=\mathbb E f_{Y_{-1}}(u_-).
\]
Apply (S14) to the random state and action. The expected Bellman bias cancels because \(Y_{-1}\) and \(Y_0\) have the same marginal. This proves (S13). \(\square\)

Let
\[
\tau=\sup_{\lambda\ne\lambda'}
\frac{\operatorname{TV}(\lambda R,\lambda'R)}
     {\operatorname{TV}(\lambda,\lambda')}
=|\rho_1-\rho_0|<1,
\tag{S15}
\]
where \(\lambda,\lambda'\) are binary probability rows. We use
\(\operatorname{TV}(P,Q)=\frac12\|P-Q\|_1\).

### Lemma 5. State-marginal correction and joint output blocks

Let \(\nu\) be the actual stationary output marginal. For every \(n\ge1\),
\[
\operatorname{TV}(\nu,\pi)
\le\frac{1}{1-\tau}\sqrt{\frac d2},
\tag{S16}
\]
and
\[
\operatorname{TV}\!\left(
 P(Y_0^n),\ \pi R^{[n]}
\right)
\le
\left(\sqrt n+\frac1{1-\tau}\right)\sqrt{\frac d2}.
\tag{S17}
\]
Here \(\lambda R^{[n]}\) denotes the joint law of the initial state and the following \(n\) outputs, with initial row \(\lambda\). The comparison in (S17) includes \(Y_0\).

**Proof.** Stationarity, Pinsker's inequality, and Cauchy–Schwarz give
\[
\begin{aligned}
\operatorname{TV}(\nu,\nu R)
&=\left|\mathbb E q_-
            -\mathbb E\rho_{Y_{-1}}\right|\\
&\le\mathbb E|q_--\rho_{Y_{-1}}|
\le\sqrt{d/2}.
\end{aligned}
\]
Since \(\pi R=\pi\), the triangle inequality and the definition of \(\tau\) imply
\[
\operatorname{TV}(\nu,\pi)
\le\sqrt{d/2}+\tau\operatorname{TV}(\nu,\pi),
\]
which proves (S16).

Next use a Markov reference with the same initial marginal \(\nu\). The chain rule yields
\[
D\!\left(P(Y_0^n)\,\middle\|\,\nu R^{[n]}\right)
=
\sum_{i=1}^n
\mathbb E D\!\left(
P(Y_i\mid Y_0^{i-1})\,\middle\|\,R(Y_{i-1},\cdot)
\right).
\tag{S18}
\]
The finite-past prediction is the conditional expectation of the infinite-past prediction. The reference row is measurable with respect to the finite past. Convexity of relative entropy in its first argument and stationarity therefore bound each expected term by \(d\). Hence the divergence in (S18) is at most \(nd\), and its total variation is at most \(\sqrt{nd/2}\).

Because the initial state is retained,
\[
\operatorname{TV}(\nu R^{[n]},\pi R^{[n]})
=\operatorname{TV}(\nu,\pi).
\]
Adding this difference proves (S17). In particular, no exchange between a finite-block normalized divergence and a limiting entropy rate is being assumed. \(\square\)

## 4. Inverse-block stability and uniqueness

Define the explicitly computable constant
\[
L=\max_{s,y}\sum_{x=0}^1|Q_s^{-1}(x,y)|\ge1.
\tag{S19}
\]
This is a maximum column norm, not a row norm.

### Lemma 6. Block inverse norm

Let
\[
K_s^{(n)}(y^n,x^n)=
\prod_{i=1}^nQ(y_i\mid x_i,y_{i-1}),\qquad y_0=s.
\]
Then it is invertible, with
\[
(K_s^{(n)})^{-1}(x^n,y^n)=
\prod_{i=1}^nQ_{y_{i-1}}^{-1}(x_i,y_i).
\tag{S20}
\]
Its induced \(\ell_1\) operator norm is at most \(L^n\). The same bound holds for
\[
\mathcal K_n^{-1}=
\operatorname{diag}\!\left(
 (K_0^{(n)})^{-1},(K_1^{(n)})^{-1}
\right).
\]

**Proof.** In the forward-matrix times proposed-inverse product, sum first over the first input symbol. The ordinary inverse identity makes the first output symbols equal, so the states of the next two factors agree. Repeat this cancellation through the word. The square product is the identity, proving (S20).

For a fixed output word, summing the absolute entries of its inverse column gives
\[
\sum_{x^n}
\prod_{i=1}^n
 \left|Q_{y_{i-1}}^{-1}(x_i,y_i)\right|
=
\prod_{i=1}^n
 \sum_{x_i}\left|Q_{y_{i-1}}^{-1}(x_i,y_i)\right|
\le L^n.
\]
The induced \(\ell_1\) norm is the largest absolute column sum. The block-diagonal claim follows. \(\square\)

### Theorem 7. Quantitative stationary input-block stability

Under (S1) and (E), for every stationary autonomous input law \(\mu\) and every \(n\ge1\),
\[
\boxed{
\operatorname{TV}(\mu_n,\mu_{*,n})
\le
L^n\left(\sqrt n+\frac1{1-\tau}\right)
       \sqrt{\frac{C_f-I_\infty(\mu;Q)}2}.
}
\tag{S21}
\]
Consequently, \(\mu_*\) is the unique stationary autonomous input law attaining \(C_f=C\).

**Proof.** Retain the initial physical state. Let
\[
\xi_n=P(Y_0,X_1^n),\qquad
\xi_{*,n}(s,x^n)=\pi(s)p_s(x^n).
\]
By autonomy and the finite channel factorization,
\[
P(Y_0^n)=\mathcal K_n\xi_n,\qquad
\pi R^{[n]}=\mathcal K_n\xi_{*,n}.
\tag{S22}
\]
Thus
\[
\begin{aligned}
\operatorname{TV}(\mu_n,\mu_{*,n})
&\le\operatorname{TV}(\xi_n,\xi_{*,n})\\
&\le L^n\operatorname{TV}\!\left(
P(Y_0^n),\pi R^{[n]}\right).
\end{aligned}
\]
The first inequality marginalizes the retained state; the second applies Lemma 6 to the difference of the two joint probability vectors. There is no factor of two left over because both total variations use half the \(\ell_1\) norm. Apply (S17) and \(d\le g\).

If \(I_\infty(\mu;Q)=C_f\), every finite input block equals its target block. Stationarity then determines every finite cylinder on \(\mathbb Z\), so \(\mu=\mu_*\). Lemma 3 supplies an attaining \(\mu_*\). This is uniqueness of the stationary input-process distribution, not uniqueness of a hidden-state representation, and not a claim about nonstationary attaining inputs. \(\square\)

## 5. Finite-cylinder polynomial constraints

For a probability law \(P\) on \(\{0,1\}^n\), let \(F(P)\) be a real polynomial in probabilities of finitely many events contained in that block. Suppose a known \(K_F>0\) satisfies
\[
|F(P)-F(P')|\le K_F\operatorname{TV}(P,P')
\tag{S23}
\]
on the probability simplex.

Such constants can be obtained directly. If \(F=\sum_\alpha c_\alpha\prod_j P(E_j)^{\alpha_j}\), then
\[
K_F=\sum_\alpha |c_\alpha|\sum_j\alpha_j
\tag{S24}
\]
is a valid bound, whenever it is positive. Each event probability changes by at most total variation, and a product of quantities in \([0,1]\) has the corresponding telescoping bound. A smaller certified Lipschitz constant may replace (S24).

### Theorem 8. Uniform penalty for a finite-cylinder constraint

Let \(\mathcal A\) be any nonempty class of stationary autonomous input laws such that \(F(\mu_n)=0\) for every \(\mu\in\mathcal A\). Under the assumptions of Theorem 7,
\[
\boxed{
C-\sup_{\mu\in\mathcal A}I_\infty(\mu;Q)
\ge
\frac{2|F(\mu_{*,n})|^2}
{K_F^2 L^{2n}
 \left(\sqrt n+(1-\tau)^{-1}\right)^2}.
}
\tag{S25}
\]
A nonzero target value gives a strictly positive bound for the entire supremum.

**Proof.** For every \(\mu\in\mathcal A\),
\[
|F(\mu_{*,n})|
\le K_F\operatorname{TV}(\mu_{*,n},\mu_n)
\le K_F L^n
\left(\sqrt n+\frac1{1-\tau}\right)\sqrt{g(\mu)/2}.
\]
Squaring and rearranging proves the pointwise bound. Taking the supremum over information rates preserves its same positive constant. Here \(C=C_f\). No assumption that the supremum is attained is used. \(\square\)

The same proof applies to any finite-block Lipschitz statistic satisfying the stated vanishing property. The polynomial case provides finite algebraic certificates. For rational channels, the optimizer, target finite-cylinder probabilities, \(L\), and \(\tau\) are real algebraic after the main manuscript's exact preprocessing. When \(F\) has real-algebraic coefficients and the certified constant \(K_F\) is real algebraic, the bound in (S25) is real algebraic as well. This does not mean that capacity itself is algebraic.

## 6. All finite Markov orders

### Lemma 9. A run identity for every stationary \(k\)-step input

For \(k\ge0\), let \(n=k+2\), and write \(a_j=P(X_1^j=0^j)\), with \(a_0=1\). Every \(\mu\in\mathcal M_k\) satisfies
\[
F_k(\mu_n)=a_{k+2}a_k-a_{k+1}^2=0.
\tag{S26}
\]
On arbitrary laws of length \(n\), \(F_k\) is \(4\)-Lipschitz in total variation.

**Proof.** A stationary \(k\)-step law has a measurable transition probability depending only on the last \(k\) input symbols, almost surely. If \(a_k=0\), both longer all-zero events have probability zero and (S26) follows. If \(a_k>0\), let \(\theta\) be the transition probability of another zero after the context \(0^k\). Then
\[
a_{k+1}=a_k\theta,\qquad
a_{k+2}=a_{k+1}\theta,
\]
which proves the identity. This reasoning permits zero transition probabilities, reducibility, and nonergodicity. For \(k=0\), the context is empty and the same calculation is the iid identity.

For two block laws, each \(a_j\) changes by at most their total variation. The change in the product \(a_{k+2}a_k\) is at most twice that variation, and the change in \(a_{k+1}^2\) is also at most twice it. Their sum gives the claimed constant. \(\square\)

### Lemma 10. The target run determinant

For the target law, let
\[
a_j^*=\pi A_0^j\mathbf1,\quad
\Delta_0=a_2^*-(a_1^*)^2,\quad D_0=\det A_0.
\]
Then for all integers \(k\ge0\),
\[
F_k(\mu_{*,k+2})=\Delta_0 D_0^k.
\tag{S27}
\]

**Proof.** The Cayley–Hamilton identity gives
\[
a_{j+2}^*=(\operatorname{tr}A_0)a_{j+1}^*
                  -D_0 a_j^*.
\]
For \(F_j=a_{j+2}^*a_j^*-(a_{j+1}^*)^2\), substitute this recurrence to obtain \(F_{j+1}=D_0F_j\). Since \(a_0^*=1\), \(F_0=\Delta_0\). Induction proves (S27), including singular \(A_0\); no division by \(D_0\) is used. \(\square\)

### Theorem 11. Explicit loss at every finite Markov order

Assume (S1), (E), and
\[
\Delta_0\ne0,\qquad \det A_0\ne0.
\tag{S28}
\]
For every integer \(k\ge0\),
\[
\boxed{
C-C_k\ge
\frac{\Delta_0^2|\det A_0|^{2k}}
{8L^{2(k+2)}
 \left(\sqrt{k+2}+(1-\tau)^{-1}\right)^2}
>0.
}
\tag{S29}
\]
Thus no stationary input of any fixed finite Markov order attains capacity. The bound is uniform over all stationary inputs of that order, including those with zero-probability contexts.

**Proof.** Apply Theorem 8 with \(n=k+2\), \(F=F_k\), and \(K_F=4\), using Lemmas 9 and 10. \(\square\)

The all-one run can replace the all-zero run. Hence one invertible symbol matrix is sufficient, provided its lag-one run determinant is nonzero; requiring both symbol matrices to be invertible is unnecessary.

The nonzero covariance condition has an elementary interpretation in the present two-dimensional stationary representation. Put \(q=A_0\mathbf1\) and \(m=\pi q\). If \(q=m\mathbf1\), both terminal symbol vectors are constant multiples of \(\mathbf1\), and the word law is iid. Otherwise \(z=q-m\mathbf1\ne0\) and \(\pi z=0\). If also \(\Delta_0=0\), then \(\pi A_0z=0\). The space of rows annihilating this nonzero two-dimensional column is one-dimensional, so
\[
\pi A_0=m\pi,\qquad \pi A_1=(1-m)\pi.
\]
Again the whole word law is iid. Conversely an iid law has \(\Delta_0=0\). Thus \(\Delta_0\ne0\) is equivalent to the target's being non-iid in this stationary representation.

This argument supplies a directly checkable certificate and avoids assuming that an arbitrary two-state realization is minimal. Its qualitative infinite-memory implication is consistent with the classical rank criteria [BP10], rather than a new general rank theorem. The quantitative uniform gap (S29) is the substantive conclusion used here.

## 7. An exact rational channel with \(C_k<C\) for every \(k\)

Use
\[
(a_0,b_0,a_1,b_1)=(1/4,3/4,3/10,7/10).
\tag{S30}
\]
The main manuscript gives a strictly feasible finite-cone certificate
\[
\ell=97/197,\qquad u=103/203,
\]
so (E) holds. The optimal output rows are both \((1-r,r)\), where
\[
r=\frac{t}{1+t},\qquad
3^9 5^{20}t^{20}-2^{20}7^{14}=0,
\qquad
\frac{4763}{5000}<t<\frac{9527}{10000}.
\tag{S31}
\]
The polynomial is strictly increasing on the positive axis. Its endpoint signs and the eight strict cone inequalities are certified by integer and rational arithmetic in the main result files. In particular,
\[
\frac{487}{1000}<r<\frac{489}{1000}<\frac12.
\tag{S32}
\]

Here
\[
A_0=
\begin{pmatrix}
\frac32(1-r)&-\frac12r\\
\frac74(1-r)&-\frac34r
\end{pmatrix},
\quad
\pi=(1-r,r),
\quad L=\frac52,
\quad\tau=0.
\tag{S33}
\]
Direct polynomial multiplication gives
\[
\Delta_0
=\frac{r(1-r)(2r-1)(r+4)}8,
\qquad
\det A_0=-\frac{r(1-r)}4.
\tag{S34}
\]
Both are nonzero. The rough bracket (S32) already proves the rational estimates
\[
|\Delta_0|>\frac3{1000},\qquad
|\det A_0|>\frac3{50}.
\tag{S35}
\]
For example \(r(1-r)>(487/1000)(511/1000)\); combine this with \(1-2r>22/1000\) and \(r+4>4487/1000\) for the first estimate.

Since \((\sqrt{k+2}+1)^2\le4(k+2)\), Theorem 11 yields, simultaneously for all integers \(k\ge0\),
\[
\begin{aligned}
C-C_k
&\ge
\frac{(3/1000)^2(3/50)^{2k}}
 {32(k+2)(5/2)^{2k+4}}\\
&=
\boxed{\frac9{1250000000(k+2)}
              \left(\frac9{15625}\right)^k}
>0.
\end{aligned}
\tag{S36}
\]
The first inequality is deliberately weakened from the strict estimates. The \(k=0\) case is a certified loss for the entire iid class.

This bound is conservative. It decreases rapidly with \(k\), is not claimed sharp, and gives no positive lower bound independent of \(k\). It does not contradict the possibility, or existing applicable approximation theorems, that \(C_k\) increases to \(C\).

The example-specific program code/verify_memory_penalty.py uses integers and Python Fraction arithmetic. Its recorded output, results/stationary_memory_penalty.json, verifies the isolating interval, the exact polynomials in (S34), the rational estimates (S35), and the constant simplification in (S36). It also checks the polynomial run identity for \(k=0,\ldots,8\). Those finite checks are supplementary evidence; the universal identity is proved by Cayley–Hamilton in Lemma 10, and the all-\(k\) information-rate bound relies on the analytic theorems above.

## 8. Interpretation and limits

Theorem 7 says more than exclusion of an individual candidate source: any stationary input whose information rate approaches capacity must approach the unique target on every fixed input block, with a stated modulus. Theorem 8 transfers a finite structural obstruction into a positive uniform rate penalty. The Markov-order consequence therefore bounds the full supremum \(C_k\), rather than merely showing that one chosen \(k\)-step source fails.

The restrictions are essential to the stated proof. It concerns autonomous stationary input processes, not arbitrary nonstationary or time-varying finite-memory encoders. Unique attainment is asserted only when both state-channel matrices are invertible and (E) holds. It does not extend uniqueness to singular state channels. The positivity assumption supplies stationary-channel forgetting and finite constants; zero channel transitions are outside the theorem.

A finite hidden-state source can have infinite visible Markov order. Accordingly, the two-hidden-state attaining construction in the main manuscript is consistent with the strict losses for every fixed visible input Markov order proved here.

This supplement provides written proofs and separately checkable example algebra. It does not claim complete Lean verification, an implemented universal capacity algorithm, optimal rate-loss constants, or external peer review. The actual-value assessment must be made on the completed base-plus-supplement package and is not implied by the pre-derivation collision decision.

## 9. Exact comparison with a prior BSSC source claim

Kourtellaris–Charalambous [KC14, Theorem 3] state first-order Markov attainment for a BSSC family, including their unconstrained case. Their displayed channel can be expressed in the present parameters as
\[
(a_0,b_0,a_1,b_1)
=(1-\alpha,\beta,1-\beta,\alpha).
\]
This statement cannot be dismissed by saying that the nondegeneracy conditions of Theorem 11 automatically exclude that family. An independent exact four-state calculation, recorded in secondary/independent_bssc_countercheck.json, identifies a failure of the displayed source-attainment assertion.

Take \((\alpha,\beta)=(9/10,7/10)\) and transmission cost \(\kappa=1/3\), where the cost is the frequency of \(X_i=Y_{i-1}\). The source in [KC14, equation (IV.35)] is a symmetric first-order Markov input with stay probability \(3/16\). Its stationary joint law of \((X_i,Y_i)\), in the order \(00,01,10,11\), is
\[
(23/60,\ 7/60,\ 7/60,\ 23/60).
\]
It has the prescribed cost and matches the claimed one-step output marginals. Nevertheless, exact enumeration gives
\[
P(Y_0=0)=\frac12,\qquad
P(Y_0Y_1=00)=\frac14,\qquad
P(Y_0Y_1Y_2=000)=\frac9{64}\ne\frac18.
\tag{S37}
\]
Thus the physical output is not the proposed iid, hence first-order Markov, output. In particular,
\[
P(Y_2=0\mid Y_0Y_1=00)=\frac9{16},
\qquad P(Y_2=0\mid Y_1=0)=\frac12.
\]
The entropy-rate deficit relative to the one-step output entropy is at least \(I(Y_2;Y_0\mid Y_1)\). The single history \(00\), weighted by its probability \(1/4\), and Pinsker's inequality already give
\[
I(Y_2;Y_0\mid Y_1)
\ge\frac14\,2\left(\frac9{16}-\frac12\right)^2
=\frac1{512}\quad\text{nats}.
\tag{S38}
\]
Its conditional channel-noise entropy is the same cost-weighted expression as in the feedback calculation. Consequently the displayed source is at least \(1/512\) nats/use below that feedback value. This cost point is on the active increasing branch: at \(\kappa=1/3\) the feedback output parameter is \(1/2\), and the derivative of the stated concave cost-value function is \(h(7/10)-h(9/10)>0\).

The companion secondary/BSSC_CONFLICT_RESOLUTION.md supplies the entire triple table: conditional probabilities after the four two-symbol histories are \(9/16\) or \(7/16\). It therefore strengthens the same source loss to
\[
\log2-h(9/16)
=D(\operatorname{Ber}(9/16)\|\operatorname{Ber}(1/2))
\ge1/128\quad\text{nats/use}.
\]
Its independent Fraction verifier also treats the unconstrained optimum, rather than extrapolating from a constrained counterexample. At that optimum,
\[
t=\left(\frac{7^7}{3^{15}}\right)^{1/6},\qquad
\lambda_*=(1+t)^{-1},\qquad
\kappa_*=(\lambda_*-3/10)/(3/5),
\]
and exact root bounds give \(51/100<\kappa_*<11/20\). For the older paper's proposed source at general \(\kappa\), the exact triple defect is
\[
P(000)-\lambda^2/2
=-\frac{9(2\kappa-1)(4\kappa^2-14\kappa+7)}
        {400(\kappa+1)}.
\tag{S39}
\]
It is nonzero throughout the isolating interval for \(\kappa_*\). The companion calculation gives a conservative strictly positive unconstrained source loss greater than \(788103/5886125000000\) nats/use. Thus using the unconstrained optimal cost does not restore the displayed source's attainment claim.

The error exposed by this comparison is the inference from matching one-step input/state and output/state marginals to the full output entropy rate. The one-step marginal-matching assertions themselves can remain true. The present proof instead uses predictions conditional on the entire output past and full joint blocks in the inverse step. These calculations do not refute equality of feedback and nonfeedback capacities for the BSSC, do not exclude other attaining inputs by themselves, and do not establish a universal correction to every assertion in the older papers. The supplementary all-orders theorem is established by its own full argument above and requires its own independent review.

## References and provenance

- **[Main]** *Finite Certificates for Feedback Gains in Binary POST Channels*, manuscript/paper.en.md in this case. The main mathematical review binds SHA-256 df798d7e1c1d982ef36980e4b149499858947df060fbfe390733762c67f82ffa.
- **[Collision]** secondary/IDEA_COLLISION.md and secondary/IDEA_COLLISION.json. Pre-derivation comparison dated 24 November 2026, decision “near”; not an actual-value acceptance.
- **[ZCW26]** X. Zhang, J. Chen, G. Wang. *Feedback Does Not Increase the Capacity of Approximately Memoryless Surjective POST Channels*. arXiv:2603.08886v1, Section II. https://arxiv.org/html/2603.08886v1.
- **[HMW23]** G. Han, B. Marcus, C. Wu. *Markov capacity for factor codes with an unambiguous symbol*. Ergodic Theory and Dynamical Systems, published online 7 November 2023, especially Section 3. https://doi.org/10.1017/etds.2023.103.
- **[BP10]** M. Boyle, K. Petersen. *Hidden Markov Processes in the Context of Symbolic Dynamics*. arXiv:0907.1858v2, Theorem 5.1 and its Heller/Holland attribution. https://arxiv.org/html/0907.1858v2.
- **[PAW14]** H. H. Permuter, H. Asnani, T. Weissman. *Capacity of a POST Channel With and Without Feedback*. IEEE Transactions on Information Theory 60(10), 6041–6057, 2014; arXiv:1309.5440. https://arxiv.org/abs/1309.5440.
- **[CS08]** J. Chen, P. H. Siegel. *Markov Processes Asymptotically Achieve the Capacity of Finite-State Intersymbol Interference Channels*. IEEE Transactions on Information Theory 54(3), 1295–1303, 2008. https://doi.org/10.1109/TIT.2007.915709. Author-hosted journal text: https://cmrr-star.ucsd.edu/static/pubs/markov_sufficiency.pdf.
- **[KC14]** C. K. Kourtellaris, C. D. Charalambous. *Capacity of Binary State Symmetric Channel with and without Feedback and Transmission Cost*. arXiv:1402.0017v2, especially Theorem 3. https://arxiv.org/pdf/1402.0017.
- **[NC25]** B. Nakiboğlu, H.-C. Cheng. *The Mutual Information In The Vicinity of Capacity-Achieving Input Distributions*. arXiv:2304.14219v5; DOI 10.1109/TIT.2025.3562098. https://arxiv.org/abs/2304.14219.
- **[CT22]** M. X. Cao, M. Tomamichel. *Comments on "Channel Coding Rate in the Finite Blocklength Regime": On the Quadratic Decaying Property of the Information Rate Function*. arXiv:2208.12945v2. https://arxiv.org/abs/2208.12945.

The HMW23, ZCW26, BP10, KC14, and CS08 primary texts were opened during this derivation. The NC25/CT22 abstracts, author lists, titles, and version records were also checked; their full-text scope comparison is inherited from the collision review and is not represented as a new full-text comparison by this supplement's author.

