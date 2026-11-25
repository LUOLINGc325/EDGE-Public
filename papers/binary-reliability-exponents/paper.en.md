---
title: "Reliability exponents for binary noisy-permutation channels"
fontsize: 11pt
geometry: margin=1.1in
abstract: |
  We determine the reliability of a strictly positive binary-output channel whose output positions are uniformly permuted. For a fixed number of messages, the exact error exponent is the best minimum of adjacent large-deviation crossing rates. Its continuous codebook is unique and equalizes those crossing rates. When the number of messages grows below square-root blocklength, both average and maximal optimal error have exponent \(nL^2/(8(M-1)^2)\), where \(L\) is the fixed-composition variance length. This yields a sharp message-count law for every subexponential vanishing error target. A uniform binary overlap estimate and a many-adjacent-pair converse avoid a \(\log M\) loss even when the error exponent grows arbitrarily slowly.
---

## 1. Model and results

Fix a finite-input binary-output channel. Let \(0<a<b<1\) be the smallest and largest one-output probabilities among its input rows. At blocklength \(n\), the channel acts independently at each position, and an independent uniform permutation is applied to the outputs. Encoding and decoding may use private randomness. There is no feedback or shared randomness. Let \(P_{\mathrm{av}}^*(n,M)\) and \(P_{\max}^*(n,M)\) denote the infimal error with \(M\ge2\) equiprobable messages, under average and maximal error, respectively.

After the permutation, the count \(Y\) of ones is sufficient, since the output word is uniform given that count under every input law. Also, every original channel row is a convex mixture of the \(a\) and \(b\) rows. Thus, for any given decoder, each original encoded message induces a mixture of endpoint-word output laws, and one deterministic endpoint word does at least as well for that message. This holds independently for each message and both error criteria [1]. We may therefore use deterministic endpoint compositions for the optimization and allow any count decoder in the converse.

For real composition \(t\in[0,1]\), define the mean and variance per symbol and their variance coordinate by
\[
\begin{split}
m_t&=a+(b-a)t,\qquad V_t=(1-t)a(1-a)+t b(1-b),\\
H(t)&=\int_0^t\frac{b-a}{\sqrt{V_u}}\,du,\qquad
L=H(1)=\frac{2(b-a)}{\sqrt{a(1-a)}+\sqrt{b(1-b)}}.
\end{split}
\tag{1}
\]
For an actual endpoint composition \(t=w/n\), write \(p_t(y)\) for the count mass function, the sum of \(n-w\) Bernoulli variables of parameter \(a\) and \(w\) of parameter \(b\). Its per-symbol log moment generating function and rate are
\[
\begin{split}
\Lambda_t(\theta)&=(1-t)\log(1-a+ae^\theta)+t\log(1-b+be^\theta),\\
I_t(x)&=\sup_{\theta\in\mathbb R}\{\theta x-\Lambda_t(\theta)\}.
\end{split}
\tag{2}
\]
All logarithms here are natural. For \(s<t\), let \(x_{s,t}\) be the unique crossing of \(I_s\) and \(I_t\) in \((m_s,m_t)\), and put \(C(s,t)=I_s(x_{s,t})=I_t(x_{s,t})\). Set \(C(t,t)=0\).

**Theorem 1 (fixed code size).** For each fixed \(M\ge2\), for either error criterion,
\[
\lim_{n\to\infty}-\frac1n\log P^*(n,M)
=E_M:=\max_{0\le t_1\le\cdots\le t_M\le1}
                    \min_{i<M} C(t_i,t_{i+1}).
\tag{3}
\]
The maximizing continuous tuple is unique, has endpoints \(t_1=0,t_M=1\), and satisfies \(C(t_i,t_{i+1})=E_M\) for each adjacent pair.

**Theorem 2 (growing code size).** If \(M=M_n\to\infty\) with \(M=o(\sqrt n)\), then for either error criterion,
\[
-\log P^*(n,M)\sim\frac{nL^2}{8(M-1)^2}.
\tag{4}
\]
For a target \(0<\varepsilon_n<1\) such that \(T_n=\log(1/\varepsilon_n)\to\infty\) and \(T_n=o(n)\), the largest message count with error at most \(\varepsilon_n\) satisfies
\[
M^*(n,\varepsilon_n)\sim L\sqrt{\frac{n}{8T_n}}
\tag{5}
\]
under both criteria.

The pinned work [1] obtains the fixed-error law when \(M\) is proportional to \(\sqrt n\), and an additive uniform Gaussian approximation for the binary-output case. Here the errors can be much smaller than that additive approximation. We instead control pair testing by tilted one-sided probabilities with an error that is small at the appropriate exponent scale.

## 2. Adjacent-pair testing at an exponential scale

### 2.1. Uniform rate geometry

The derivative \(\Lambda_t'\) is strictly increasing from zero to one, so \(I_t\) at each \(x\in(0,1)\) is attained at a unique tilt \(\theta_t(x)\) satisfying \(\Lambda_t'(\theta_t(x))=x\). The function \(I_t\) decreases up to \(m_t\) and increases thereafter, with its unique zero at \(m_t\). Thus \(I_s\) increases and \(I_t\) decreases on \([m_s,m_t]\) when \(s<t\), with opposite ordering of the endpoint values. The crossing is unique and interior. Joint continuity follows from the continuous inverse for \(\Lambda_t'\); in particular \(C(s,t)\) extends continuously to \(s=t\).

For \(x\in[a,b]\) and \(t\in[0,1]\), all \(\theta_t(x)\) belong to a fixed compact interval. This follows because the two tilted Bernoulli means approach zero and one at the two infinite tilt limits. On this compact interval \(\Lambda_t''\) has a uniform positive lower bound, as it is a convex combination of two strictly positive tilted variances. Consequently, for the crossing between \(s,t\), both \(|\theta_s(x_{s,t})|\) and \(|\theta_t(x_{s,t})|\) are bounded by \(B|t-s|\) for a channel-dependent constant \(B\). The signs of the two tilts are positive and negative, respectively.

### 2.2. A uniform overlap inequality

For a pair of types on the blocklength grid, let
\[
\mathrm{ov}(s,t)=\sum_{y=0}^n \min\{p_s(y),p_t(y)\}.
\]
There are constants \(c>0,B_1<\infty\), depending only on the channel, such that for all sufficiently large \(n\) and all \(s\le t\) on that grid,
\[
c\,\exp[-nC(s,t)-B_1\sqrt n\,|t-s|]
\le \mathrm{ov}(s,t)
\le 2\exp[-nC(s,t)] .
\tag{6}
\]
Repeated types have overlap one, so suppose \(s<t\). The overlap is the minimum sum of the two binary testing errors, by choosing the larger likelihood at each count. The threshold test at \(Y/n=x_{s,t}\) has each error bounded by \(\exp[-nC(s,t)]\), using the two Chernoff inequalities. This proves the upper bound, also when the threshold is a lattice point.

For the reverse bound, the count likelihood ratio \(p_t/p_s\) is nondecreasing for \(s<t\) [1, Lemma B2.1]. Hence a minimum-sum test can classify \(t\) at integer counts \(Y\ge j\) for some \(j\), with a consistent tie rule. Let \(x=x_{s,t}\). If \(j\le\lceil nx\rceil\), the error event under \(s\) contains \(nx<Y\le nx+\sqrt n\). If \(j>\lceil nx\rceil\), the error under \(t\) contains \(nx-\sqrt n\le Y<nx\).

For either composition \(u\in\{s,t\}\), tilt its count law by density factor \(\exp(\theta_u(x)Y-n\Lambda_u(\theta_u(x)))\). It remains a sum of independent Bernoulli variables since the density factor multiplies over the positions before permutation. Its mean is \(nx\). All its Bernoulli parameters stay in a fixed compact subset of \((0,1)\) by the compact tilt bound. Thus its variance is between \(c_0 n\) and \(n/4\) for some \(c_0>0\), and the sum of third absolute centered moments is at most \(n\). Berry--Esseen gives a uniform \(O(n^{-1/2})\) distribution-function approximation. Under this tilted law either centered one-sided window of width \(\sqrt n\) has probability bounded below by a positive constant for all large \(n\). Indeed, the standardized width is at least two, and the difference of normal distribution-function values has a positive minimum. Open or closed endpoints are covered by left limits and continuity of the normal law. On either window, undoing the tilt costs at most a factor \(\exp[-nI_u(x)-|\theta_u(x)|\sqrt n]\). This proves the lower bound in (6).

### 2.3. The crossing rate for small type gaps

Uniformly for \(t\in[0,1]\) and \(y\) small,
\[
I_t(m_t+y)=\frac{y^2}{2V_t}+O(|y|^3).
\tag{7}
\]
For example, Taylor-expand \(\Lambda_t\) at zero and solve \(\Lambda_t'(\theta)=m_t+y\); its second derivative at zero is \(V_t\), which is uniformly positive. All derivatives in a fixed neighborhood are uniformly bounded, so the expansion and inversion are uniform.

For \(s<t\) with \(t-s\) small, write \(d=m_t-m_s\) and \(x_{s,t}=m_s+\alpha d\), \(0<\alpha<1\). By (7) and \(V_t=V_s+O(t-s)\), equality of the rates implies
\[
\alpha^2-(1-\alpha)^2=O(t-s).
\]
Thus \(\alpha=1/2+O(t-s)\). Since \(H(t)-H(s)=d/\sqrt{V_s}+O((t-s)^2)\), (7) gives
\[
C(s,t)=\frac{(H(t)-H(s))^2}{8}+O(|t-s|^3)
\tag{8}
\]
uniformly, including near both endpoints.

## 3. Fixed numbers of messages

If message \(i\) has count law \(p_i\) and error \(e_i\) under a randomized decision rule, then for two distinct messages
\[
e_i+e_j\ge\sum_y\min\{p_i(y),p_j(y)\}.
\tag{9}
\]
Indeed, the two conditional decision probabilities at a given \(y\) sum to at most one, so the sum of the two weighted errors there is at least the smaller mass. Equation (9) also applies if two messages have the same type.

Sort the endpoint types and apply (9) to a neighboring pair with smallest crossing rate. For fixed \(M\), (6) gives an average error at least \(c\exp[-nE_M-B_1\sqrt n]/M\), where \(E_M\) is (3). This bounds every original encoder and decoder by the endpoint reduction. Since the average error is bounded by the maximal error, it gives the converse for both.

For a deterministic endpoint code with strictly increasing types, place boundaries between adjacent messages at the crossing counts \(n x_{t_i,t_{i+1}}\), breaking threshold ties consistently. These boundaries are ordered, since each lies between its two means, so they define a count decoder. Every message can err in at most its two neighboring tails, and each tail is bounded by the Chernoff inequality. Hence the maximal error is at most \(2\exp[-n\min_i C(t_i,t_{i+1})]\). Continuity and compactness give an optimizer in (3). Its value is positive, using any strictly increasing tuple. Round its compositions to the \(1/n\) grid. They remain distinct for large \(n\), and the objective converges to \(E_M\). This proves (3).

### 3.1. The unique continuous optimizer

For fixed \(x\in(0,1)\), differentiating the stationary expression in (2) gives
\[
\partial_t I_t(x)=
-\log\left(\frac{1-b+b e^{\theta_t(x)}}{1-a+a e^{\theta_t(x)}}\right).
\tag{10}
\]
This is positive when \(x<m_t\) and negative when \(x>m_t\). For fixed \(s\), increasing \(t>s\) increases \(I_t\) at the old crossing, so the new crossing moves strictly upward. Its common rate \(I_s\) increases strictly. For fixed \(t\), decreasing \(s<t\) increases \(I_s\) at the old crossing and moves the crossing strictly downward, raising \(I_t\) there. Thus \(C(s,t)\) is strictly increasing in the right endpoint and strictly decreasing in the left endpoint for nonzero gaps.

For a positive target exponent \(E\), start at \(t_1=0\) and take each next point as the smallest \(t\) with \(C(t_i,t)\ge E\), if one exists in \([t_i,1]\). The next point is the unique equality solution. The step map is strictly increasing in its starting point on the domain where it can be taken. By induction its points are no greater than those of any feasible tuple, so reaching \(M\) points in the interval is equivalent to feasibility of \(E\).

At \(E=E_M\) the greedy last point equals one. If it were smaller, each step's equality solution would have interior slack from the boundary \(1\). Strict monotonicity and continuity of \(C\) imply continuity of these finitely many step solutions locally in \(E\) and the preceding point. One could increase \(E\) slightly while still reaching \(M\) points, contradicting optimality. Any optimizing tuple with any larger point than the greedy tuple would propagate a strict increase to its last point, which would exceed one. Therefore the greedy tuple is the unique optimizer and equalizes all adjacent rates. The uniform pair converse also implies that the sorted types of any deterministic endpoint code sequence attaining \(E_M\) converge to this tuple. Otherwise a convergent subsequence would have strictly smaller minimum crossing rate. At \(M=2\) the optimizer is the two extreme rows and its exponent is ordinary Bernoulli Chernoff information.

## 4. Growing numbers of messages

For the upper bound on error, place \(M\) ideal points equally spaced in the coordinate \(H\) from \(0\) to \(L\), then round their type coordinates to the nearest \(1/n\) grid points. The derivative of \(H\) is bounded, so the arc rounding error is \(O(1/n)\). The rounded neighboring gaps are
\[
\frac{L}{M-1}+O(1/n)
\]
uniformly, and are positive for all large \(n\). Formula (8) shows that their crossing rates are uniformly \((1+o(1))L^2/[8(M-1)^2]\). With the crossing decoder of Section 3, the maximal error is at most twice the exponential with this exponent times \(n\). Since \(n/(M-1)^2\to\infty\), the factor two has negligible logarithm.

For the converse, fix \(\zeta>0\). In any sorted list of types with \(M\) entries, the sum of adjacent arc gaps is at most \(L\). At least \((M-1)\zeta/(1+\zeta)\) of its gaps are therefore at most
\[
d_n=\frac{(1+\zeta)L}{M-1}.
\]
On every such gap, \(|t_{i+1}-t_i|=O(d_n)\) since \(H'\) is bounded away from zero. By (6) and (8), its overlap is at least
\[
c\exp\left[-\frac{n d_n^2}{8}-O(n d_n^3+\sqrt n\,d_n)\right].
\tag{11}
\]
These error terms are \(o(n d_n^2)\) because \(d_n\to0\) and \(\sqrt n\,d_n\to\infty\). The estimate is uniform, including for a repeated or unusually small gap. Sum (9) over the selected neighboring pairs. Each error \(e_i\) appears at most twice, so after division by \(2M\) the average error still has the lower bound (11) times a positive factor depending only on \(\zeta\) for all large \(n\). This gives a limsup for the normalized negative log error of at most \((1+\zeta)^2\) times the claimed scale. Letting \(\zeta\downarrow0\) proves (4) for average and maximal error. The positive fraction of selected neighbors is important when \(n/M^2\) grows more slowly than \(\log M\).

For any code with average error at most \(\varepsilon<1\), the sum of its messagewise successes is at most \(n+1\): at each count the conditional decision probabilities sum to one and every likelihood is at most one. Thus \(M\le(n+1)/(1-\varepsilon)\), and the largest feasible count is finite. 

To invert (4), for any fixed \(0<\eta<1\) take integer counts near \((1-\eta)L\sqrt{n/(8T_n)}\) and \((1+\eta)L\sqrt{n/(8T_n)}\). They tend to infinity and are \(o(\sqrt n)\). Their optimal negative log errors divided by \(T_n\) tend to \((1-\eta)^{-2}>1\) and \((1+\eta)^{-2}<1\), respectively. Achievability therefore holds at the first count and fails at the second. Optimal error is nondecreasing in count: discard the worst messages for average error, or any messages for maximal error, and reassign unused decoder outputs. This proves (5). In the fixed-count optimization, the same equispacing and minimum-gap arguments with (8) also give \(E_M\sim L^2/[8(M-1)^2]\) as \(M\to\infty\).

## 5. Provenance

The pinned rank-two analysis [1] gives the finite endpoint reduction, monotone count likelihood ratio, and the fixed-error variance length and operational constant. These are used here with the standard exponential tilt, Berry--Esseen inequality, and Chernoff tail bounds. The new scope is the exact reliability exponent at every fixed code size, its equalizing optimizer, and the sharp growing-code exponent and message law at all subexponential vanishing error targets. The proof is for binary output and fixed nondegenerate endpoint rows.

**Reference**

1. *The sharp fixed-error coding constant for strictly positive rank-two noisy permutation channels*. earlier research manuscript, fixed commit 49a34ce771c8, Lemma 1 and binary-output supplement B2–B4. The complete source path and blob are in the source manifest.
