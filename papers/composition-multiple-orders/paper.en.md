---
title: "Several optimal Rényi orders under randomized-response composition"
subtitle: "Exact height matching and sharp overestimation by adding privacy budgets"
lang: en
geometry: margin=1in
---

## Abstract

A single k-ary randomized-response release has at most one maximizing interior Rényi order. We show that independent composition can have arbitrarily many strict local maxima, even when all releases have the same pure privacy parameter. With adjustable privacy parameters, precisely J releases can have precisely J global maximizing orders, under an arbitrarily small cap on total pure privacy. In those examples the sum of the individual exact zCDP budgets can approach J times the exact composition budget, the largest possible factor. The proof controls the full large-alphabet profile and matches all finite peak heights by a fixed-point argument.

## 1. Product model and theorem

The \(k\)-ary randomized-response mechanism with \(\varepsilon>0\) outputs the input label with probability \(e^\varepsilon/(e^\varepsilon+k-1)\) and each other label with probability \(1/(e^\varepsilon+k-1)\). We compose releases on a common binary input. Each release identifies the two possible values with the first two labels of its own output alphabet. The same input is used for every release, and the releases are conditionally independent given that input.

The archived *Exact zCDP of k-ary randomized response* gives the numerator
\[
 N_{k,\varepsilon}(\alpha)=
 \log\frac{e^{\varepsilon\alpha}+e^{\varepsilon(1-\alpha)}+k-2}
              {e^\varepsilon+k-1}.
\]
For \(\alpha>1\), the normalized Rényi profile of the single channel is \(N_{k,\varepsilon}(\alpha)/[\alpha(\alpha-1)]\), and its supremum is the exact zCDP parameter. In the product, the Rényi moment is a product of the individual moments, and the two directions agree by exchanging the first two output labels in every component. There is only one adjacent pair up to orientation, so the exact composite budget is the supremum of
\[
 G(\alpha)=\sum_{i=1}^{J}\frac{N_{k_i,\varepsilon_i}(\alpha)}{\alpha(\alpha-1)}.
 \qquad\text{(1)}
\]

**Theorem 1.** The following assertions hold.

1. For any \(J\ge1\) and any common \(\varepsilon_0>0\), some product of \(J\) releases with \(\varepsilon_i=\varepsilon_0\) has at least \(J\) strict local maxima in \(\alpha>1\).
2. For every \(J\ge2\), arbitrary positive total pure privacy cap, and arbitrary positive tolerance, there are \(J\) releases under that cap whose composite profile has exactly \(J\) distinct global maximizing orders. The ratio of the sum of their individual exact budgets to their exact product budget can be made within the tolerance of \(J\).
3. The ratio just described is always at most \(J\). Products with all parameters equal already give unbounded ratios as \(J\) grows.

## 2. The full-profile scaling limit

Fix \(a_i>0\), choose \(k_i(M)=\lceil e^{M a_i}\rceil\), and write \(G_M\) for (1) with these alphabets. Allow the \(\varepsilon_i\) to vary in any fixed compact subset of \((0,\infty)\). For \(u>0\),
\[
 M G_M(Mu)\longrightarrow g(u)
    =\frac{\sum_i(\varepsilon_i u-a_i)_+}{u^2}.
 \qquad\text{(2)}
\]
Convergence is uniform on positive compact intervals, jointly in the allowed parameters. It is also uniform through two derivatives in \(u\) on compact sets separated from every breakpoint \(\varepsilon_i u=a_i\).

For the value convergence, the numerator logarithm for release \(i\) is \(M\max(\varepsilon_i u,a_i)+O(1)\) by the log-sum-exp bound, and its denominator logarithm is \(M a_i+O(1)\). Here the term \(e^{\varepsilon_i(1-Mu)}\) is uniformly bounded for large \(M\) on the positive compact interval. Divide their difference by \(M\), then divide by \(u(u-1/M)\). For derivatives away from the breakpoints, factor out \(e^{M\varepsilon_i u}\) when it dominates, and factor out \(k_i-2\) on the other side. The remaining terms and their first two derivatives, after subtracting their constant leading term, are bounded by a polynomial in \(M\) times \(e^{-\gamma M}\) for some \(\gamma>0\). Taking the logarithm and differentiating \(u(u-1/M)\) preserves the convergence claimed in (2).

We next control maxima outside a compact interval. Choose \(u_0>0\) so small that \(\varepsilon_i u_0\le a_i/2\) uniformly in the allowed parameters. For \(1\le\alpha\le M u_0\),
\[
 0\le N'_{k_i,\varepsilon_i}(\alpha)
 \le\frac{\varepsilon_i e^{\varepsilon_i\alpha}}{k_i-2}.
\]
Integration from one, where \(N_{k_i,\varepsilon_i}(1)=0\), cancels the \(\alpha-1\) denominator and bounds \(M G_M(\alpha)\) by a quantity tending uniformly to zero on this region. At large \(u\), the bound \(D_\alpha\le\varepsilon_i\) follows directly from the maximum likelihood ratio of the single channel. Thus \(M G_M(Mu)\le\sum_i\varepsilon_i/u\). The same bound holds for \(g\). The limiting maximum is bounded away from zero uniformly because its first term attains \(\varepsilon_1^2/(4a_1)\). Hence all finite global maximizers lie in a shared positive compact interval for sufficiently large \(M\), and their heights converge uniformly to the limiting maxima. For one release the same reasoning gives
\[
 M\rho_i\longrightarrow \frac{\varepsilon_i^2}{4a_i},
 \qquad\text{(3)}
\]
uniformly on compact positive parameter ranges.

## 3. Interlaced equal-height peaks

Choose fixed scales \(0=S_0<S_1<\cdots<S_J\), and take
\[
 \varepsilon_i=S_i-S_{i-1},
 \qquad a_i=S_i^2-S_{i-1}^2 .
 \qquad\text{(4)}
\]
The breakpoints are \(a_i/\varepsilon_i=S_i+S_{i-1}\), strictly increasing. After breakpoint \(j\) and before the next one, the first \(j\) mechanisms contribute and (2) becomes \((S_j u-S_j^2)/u^2\). It has a unique maximum at \(2S_j\), with height \(1/4\) and negative second derivative there. The maximum lies strictly between its breakpoints. Below the first breakpoint the value is zero. Thus the \(J\) points \(2S_j\) are exactly the global maxima of the limit.

Choose pairwise disjoint closed windows \(I_j\) about the maxima, strictly separated from all breakpoints, where the limiting second derivative stays negative and the endpoints have smaller values. For large \(M\), every window has an interior maximum by uniform value convergence, and this maximum is strict and unique within its window by derivative convergence. Taking \(S_j=j\varepsilon_0\) proves part 1. By (2) and (3), the summed-to-composite budget ratio for this common-parameter family tends to
\[
 \sum_{j=1}^J \frac{\varepsilon_0^2}{a_j}
 =\sum_{j=1}^J\frac1{2j-1},
 \qquad\text{(5)}
\]
which grows without bound.

## 4. Exact finite matching of all peaks

Keep the alphabet scales \(a_i\) in (4) fixed. Let \(v=(v_2,\ldots,v_J)\) run in a sufficiently small closed cube about zero. Set \(v_1=0\), \(A_0=0\), and define
\[
 A_j(v)=S_j\sqrt{1+4v_j},\qquad
 \varepsilon_j(v)=A_j(v)-A_{j-1}(v).
\]
For a sufficiently small cube all privacy parameters are positive, and the active set is exactly the first \(j\) mechanisms throughout \(I_j\). On that window the limiting curve is \((A_j(v)u-S_j^2)/u^2\), with maximum at \(2S_j^2/A_j(v)\) and height \(1/4+v_j\). The maximum stays in the interior of the window, and the second derivative stays negative there after shrinking the cube. At \(v=0\) the complement of the windows inside the shared compact region has a strict gap from \(1/4\). Uniform continuity and a smaller cube preserve this gap, since the first peak still has height \(1/4\). The tail bounds in Section 2 exclude all other orders.

For large \(M\) the finite scaled profile has exactly one maximum inside each \(I_j\) by the same endpoint gaps and uniform second-derivative bound. Its global maximum lies in one of these windows. Denote the window height by \(H_{M,j}(v)\), which is continuous in \(v\) by compact maximization. It tends uniformly to \(1/4+v_j\). In dimension \(J-1\) let
\[
 E_{M,j}(v)=H_{M,j}(v)-H_{M,1}(v)-v_j,\qquad j=2,\ldots,J .
\]
The error tends uniformly to zero. For sufficiently large \(M\), the continuous map \(v\mapsto-E_M(v)\) sends the cube into itself. Brouwer's fixed point theorem gives \(v_M=-E_M(v_M)\). At these parameters exactly one optimizer occurs in each window and all \(J\) heights agree, so there are exactly \(J\) global optimizing orders. They are strict local maxima. The fixed points satisfy \(v_M\to0\) and the optimizing orders divided by \(M\) tend to \(2S_j\).

The total pure privacy parameter is \(\sum_j\varepsilon_j(v_M)=A_J(v_M)\), which tends to \(S_J\). The upper bound follows by multiplying likelihood ratios, and equality is attained on the event of all first labels. Scaling the \(S_j\) by a common factor places this sum below any prescribed positive cap for large \(M\).

## 5. The sharp ratio

Every component profile is nonnegative. Thus \(\rho_{\mathrm{comp}}\ge\max_i\rho_i\ge(\sum_i\rho_i)/J\), giving the universal ratio ceiling \(J\). On the exact finite-tie sequence we have \(M\rho_{\mathrm{comp}}\to1/4\), while (3) gives \(M\rho_i\to\varepsilon_i(0)^2/(4a_i)\). Their ratio tends to
\[
 \sum_{i=1}^J \frac{S_i-S_{i-1}}{S_i+S_{i-1}}.
 \qquad\text{(6)}
\]
When \(S_i=\lambda K^{i-J}\) for \(K>1\), this is \(1+(J-1)(K-1)/(K+1)\). Letting \(K\) grow makes the bound arbitrarily close to \(J\). The free scale \(\lambda\) enforces any total pure privacy cap without changing the ratio. Equation (5) gives unbounded overestimation under common parameters. This proves Theorem 1.

## 6. Source and scope

The pinned source establishes the exact single-channel profile and the uniqueness of a maximizing interior order for that channel. It leaves arbitrary heterogeneous compositions outside its theorem. Our product profiles use independent releases of the very same input bit. The examples determine exact optimizer counts for the constructed parameter sets and the sharp supremum of the summed-to-composite ratio over \(J\) releases. The comparison is limited to the pinned repository record.
