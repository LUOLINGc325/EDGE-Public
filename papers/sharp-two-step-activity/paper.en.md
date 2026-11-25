---
title: "The sharp two-step activity bound for Glauber annealing on regular graphs"
lang: en
geometry: margin=1in
---

# Abstract

On a finite connected \(d\)-regular graph, start a Glauber annealing chain in a Gibbs state and apply two cooling updates. We determine the exact supremum of the probability that the second update changes state:
\[
 \frac12+\frac{\lfloor d^2/8\rfloor}{2d^2}.
\]
The supremum of the mean activity of the two updates has half this excess over one half. Degrees one and two cannot violate the one-half bound in two steps. Above degree two the bound follows from a vertexwise optimization that links the first-step probability current to the second-step exit rate. A connected regular bipartite family approaches the bound with distinct energies and finite strictly decreasing temperatures. For cubic graphs the sharp second-step value is \(5/9\).

# 1. Model and theorem

Let \(G=(V,E)\) be a finite connected simple \(d\)-regular graph with \(d\ge1\). Each vertex \(i\) has a finite real energy \(E_i\). At inverse temperature \(\beta\ge0\), propose a uniformly random neighbor \(j\) of the current state \(i\), and accept the proposal with probability
\[
 \frac{1}{1+\exp(\beta(E_j-E_i))}.
\]
Otherwise the chain stays put. Start with probabilities \(p_i\) proportional to \(\exp(-\beta_0 E_i)\), and update at inverse temperatures \(\beta_1,\beta_2\), where \(0\le\beta_0\le\beta_1\le\beta_2<\infty\). Let \(A_j\) denote the probability that update \(j\) changes the state, for \(j=1,2\).

**Theorem 1.** Fix \(d\ge1\) and take the supremum over all such graphs, energies and temperatures. Then
\[
 \sup A_2=\frac12+\frac{\lfloor d^2/8\rfloor}{2d^2},
 \qquad
 \sup\frac{A_1+A_2}{2}
      =\frac12+\frac{\lfloor d^2/8\rfloor}{4d^2}.
\]
Also \(A_1\le1/2\) on every instance. For \(d\ge3\) neither supremum is attained by a finite-temperature instance. Both values can be approached on connected bipartite graphs with distinct energies and \(0<\beta_0<\beta_1<\beta_2<\infty\).

# 2. Exit rates and the first probability current

Orient an edge \(e\) from its lower-energy endpoint \(L\) to its higher-energy endpoint \(H\), with either orientation for a tie. Let
\[
 t_k(e)=\tanh\bigl(\beta_k(E_H-E_L)/2\bigr),
 \qquad 0\le t_0(e)\le t_1(e)\le t_2(e)<1.
\]
For a vertex \(i\), write \(\delta_i(k)\) for its signed sum of \(t_k(e)\): the term is positive if \(i=H\) and negative if \(i=L\). The probability of leaving \(i\) at temperature \(\beta_k\) is
\[
 a_i(k)=\frac12+\frac{\delta_i(k)}{2d}.
\]
Indeed the proposal acceptance on \(e\) is \((1+t_k(e))/2\) from \(H\) and \((1-t_k(e))/2\) from \(L\). The Gibbs law satisfies \(p_L/p_H=(1+t_0(e))/(1-t_0(e))\). Consequently
\[
 \sum_i p_i\delta_i(k)
 =-\sum_e(p_L+p_H)t_0(e)t_k(e)\le0.                                      \tag{1}
\]
For \(k=1\) this gives the first-step bound.

Let \(p'_i\) be the law after the first update. The net probability moved from \(H\) to \(L\) along an edge is
\[
 \frac{p_H(1+t_1(e))-p_L(1-t_1(e))}{2d}
 =\frac{(p_L+p_H)(t_1(e)-t_0(e))}{2d}.
\]
Define the nonnegative terms
\[
 b_{H,e}=\frac{t_1(e)-t_0(e)}{1-t_0(e)},\qquad
 b_{L,e}=\frac{t_1(e)-t_0(e)}{1+t_0(e)},
\]
and let \(b_i\) be their signed sum at \(i\) with the same convention as \(\delta_i(k)\). Then \(p'_i=p_i(1-b_i/d)\). Each term \(b_{i,e}\) lies in \([0,t_2(e)]\), since both displayed fractions are at most \(t_1(e)\). By normalization of \(p'\) and the exit-rate expression,
\[
 A_2=\frac12+\frac{\sum_i p_i\delta_i(2)}{2d}
             -\frac{\sum_i p_i b_i\delta_i(2)}{2d^2}.                      \tag{2}
\]

# 3. The upper bound for \(d\ge3\)

At a vertex where \(b_i\) and \(\delta_i(2)\) have opposite signs, let \(r\) be the number of incident edge terms on the sign side of \(b_i\), and let \(x\) be the sum of their unsigned \(b_{i,e}\). Then \(0\le x\le r\) and \(|b_i|\le x\). On the same \(r\) edges the sum of the corresponding \(t_2(e)\) is at least \(x\), while on the remaining edges it is at most \(d-r\). Thus \(|\delta_i(2)|\le d-r-x\). The bound at that vertex is
\[
 -b_i\delta_i(2)\le x(d-r-x).
\]
If the product on the left is positive, the bound is strict, since \(d-r\ge1\) and each \(t_2(e)<1\) on the opposing edges. If the signs agree or a factor vanishes, the left side is nonpositive.

For \(d\ge3\), the maximum on the right over integer \(r\) and \(0\le x\le r\) is \(M_d=\lfloor d^2/8\rfloor\). To see this, for \(r\le d/3\) the maximum is at \(x=r\) and equals
\[
 r(d-2r)=d^2/8-2(r-d/4)^2.
\]
An integer nearest to \(d/4\) lies in this range and gives \(\lfloor d^2/8\rfloor\), as is seen by the four residues of \(d\) modulo four. In particular for \(d\ge6\) this nearest integer is at most \(d/4+1/2\le d/3\); degrees three, four and five satisfy the same condition directly. For \(r\ge d/3\), the maximum is at most \((d-r)^2/4\le d^2/9\). When \(d\ge6\), \(d^2/9\le\lfloor d^2/8\rfloor\) because \(d^2/72\ge1/2\) and a square modulo eight is \(0,1\) or \(4\). For degrees three, four and five, \(d^2/9\le \lfloor d^2/8\rfloor\) also holds.

Each vertex therefore has \(-b_i\delta_i(2)<M_d\), including the cases where this product is nonpositive. Substitution into (2), using (1), proves the strict finite-temperature upper bound and then the strict bound on the two-step mean.

# 4. Degrees one and two

In degree one the two signed sums \(b_i,\delta_i(2)\) always have the same weak sign, so (1) and (2) give \(A_2\le1/2\).

For degree two, the same argument applies at a vertex whose two incident terms have the same orientation sign. At a vertex with one lower and one higher neighbor, \(\delta_i(1)\) and \(\delta_i(2)\) have the same weak sign: the edge with the larger energy gap has the larger magnitude at either temperature. Write the errors on edge \(e\) between \(t_1(e)\) and \(b_{i,e}\) as
\[
 e_{H,e}=\frac{t_0(e)(1-t_1(e))}{1-t_0(e)},\qquad
 e_{L,e}=\frac{t_0(e)(1+t_1(e))}{1+t_0(e)}.
\]
They are nonnegative. At a mixed-orientation vertex \(i\), call its lower and higher neighbor edges \(e_{\mathrm{in}},e_{\mathrm{out}}\), respectively. Then
\[
 -b_i\delta_i(2)
 =-\delta_i(1)\delta_i(2)
    +(e_{i,e_{\mathrm{in}}}-e_{i,e_{\mathrm{out}}})\delta_i(2).
\]
If \(\delta_i(2)>0\), this is at most \(e_{i,e_{\mathrm{in}}}t_2(e_{\mathrm{in}})\), since \(0<\delta_i(2)\le t_2(e_{\mathrm{in}})\). If \(\delta_i(2)<0\), the analogous upper bound is \(e_{i,e_{\mathrm{out}}}t_2(e_{\mathrm{out}})\). In either case the bound uses the larger-gap edge at that vertex. At equality of gaps or when \(\beta_2=0\) the product vanishes.

Multiply the vertex bounds by \(p_i\) and sum. At most the two endpoint contributions of any edge can enter the resulting upper bound, and
\[
 p_H e_{H,e}+p_L e_{L,e}=(p_L+p_H)t_0(e).
\]
Thus \(-\sum_i p_i b_i\delta_i(2)\le \sum_e(p_L+p_H)t_0(e)t_2(e)\). Equation (1) cancels this potential gain in (2), since its coefficient there is \(1/(2d^2)\), no greater than the coefficient \(1/(2d)\) of the Gibbs deficit. Hence \(A_2\le1/2\) for degree two. Constant energies attain both one-half values in degrees one and two.

# 5. A family approaching the upper bounds

Fix \(d\ge3\). Choose an integer \(r\) nearest to \(d/4\), and put \(s=d-r\). Then \(r\ge1,\ s\ge2\) and \(r(d-2r)=M_d\). Take \(m\ge2\) pairs of layers \(L_k,H_k\) for \(k=1,\ldots,m\), each of width \(d\). Number the vertices within each layer by residues modulo \(d\). Between \(L_k\) and \(H_k\) connect residue \(i\) in \(L_k\) to residues \(i+j\) in \(H_k\) for \(0\le j<r\). Between \(H_k\) and \(L_{k+1}\) connect the corresponding offsets \(0\le j<s\), with \(L_{m+1}=L_1\). The degree is exactly \(d\). The graph is simple because the layer pairs are distinct and the offsets are distinct. It is bipartite with the \(L\) and \(H\) layers on opposite sides. The offset-zero edges give a connected cycle of layers within each residue, and the offset-one edges on the \(s\)-links join these cycles, so the whole graph is connected.

For \(0<\varepsilon<1/2\), give \(L_k\) base energy \((k-1)(1+\varepsilon)\) and \(H_k\) base energy one higher. To make energies distinct, add \(i\varepsilon^2/(2d)\) at residue \(i\). The gaps from \(L_k\) to \(H_k\) are \(1+O(\varepsilon^2)\). From \(H_k\) to \(L_{k+1}\) for \(k<m\) they are \(\varepsilon+O(\varepsilon^2)\). The wrap edges have a gap bounded away from zero and point from \(L_1\) toward \(H_m\) in the energy order. Take
\[
 \beta_0=\varepsilon,\qquad\beta_1=\varepsilon^{-1/2},\qquad
 \beta_2=\varepsilon^{-2}.
\]
For fixed \(m,d\), as \(\varepsilon\) decreases to zero the initial law becomes uniform and \(t_0\) tends to zero on every edge. The magnitudes \(t_1\) tend to one on the \(r\)-links and wrap links, and to zero on the other \(s\)-links. The magnitudes \(t_2\) tend to one on every edge. Therefore \(b_i\) converges to the limit of \(\delta_i(1)\).

At vertices in \(L_k\) for \(k>1\), the limiting pair \((b_i,\delta_i(2))\) is \((-r,d-2r)\). At vertices in \(H_k\) for \(k<m\), the pair is \((r,-(d-2r))\). These give product \(-M_d\). Every link out of \(L_1\) points upward and every link out of \(H_m\) points downward; all these links are sharp already at the first update. Thus the product is \(d^2\) on the two boundary layers. In (1) the Gibbs deficit tends to zero. From (2) we obtain
\[
 A_2\ \longrightarrow\
 \frac12+\frac{(m-1)M_d-d^2}{2d^2m},
 \qquad A_1\ \longrightarrow\ \frac12 .
\]
Send \(m\) to infinity after the fixed-\(m\) limits. Any prescribed tolerance is achieved by first choosing a finite number of layers and then sufficiently small positive \(\varepsilon\). This proves sharpness under the finite distinct-energy and strict-cooling conditions.

## An explicit finite cubic instance

The same graph with \(d=3,r=1,m=125\) has 750 vertices. Give the vertices at residue \(i\) in \(L_k,H_k\) the integer energies
\[
 3(k-1)(50001)+i,\qquad 3(k-1)(50001)+150000+i,
\]
respectively. For the inverse temperatures take \(\beta_0=\log(1+10^{-13})\), \(\beta_1=\log(10001/10000)\), and \(\beta_2=\log 32768\). All energies are distinct. On nonwrap \(s\)-links the gaps are between one and five, while on every other link they are at least \(140000\).

Write \(P_*\) for the ideal first update with acceptance \(1/2\) on the small-gap links and one downhill, zero uphill on the other links. The ideal second update accepts exactly downhill moves. With uniform starting law these have ideal first activity \(1/2\) and second activity \(1/2+23/450\) by the layer calculation. The actual initial law differs from uniform in \(\ell^1\) by less than \(1/400000\). In fact, if \(M=18750374\) is the energy range and \(\xi=M10^{-13}\), each ratio of an initial probability to a uniform one lies between \((1+10^{-13})^{-M}\) and \((1+10^{-13})^M\). The deviation is at most \(\xi/(1-\xi)\) by the binomial bound \((1+\gamma)^M\le (1-M\gamma)^{-1}\) for \(0\le M\gamma<1\).

For the first update, the edge magnitudes differ from their ideal values by at most \(1/1999\). On the small gaps use \((1+10^{-4})^5-1\le1/1999\), and on the large gaps use \((1+10^{-4})^{10000}>2\), so the difference from one is at most \(2/(2^{14}+1)\). The induced \(\ell^1\) norm of the first transition-matrix difference is at most \(1/1999\). Each column has off-diagonal errors with sum at most \(1/(2\cdot1999)\), and its diagonal error is at most that sum. For the second update, the exit probabilities differ from their ideal values by less than \(1/32768\), by the positive integer gap bound. Stochastic contraction in \(\ell^1\) now gives
\[
 A_2>\frac12+\frac{23}{450}
            -\frac1{400000}-\frac1{1999}-\frac1{32768}>\frac{11}{20}.
\]
The uniform exit average of the actual first transition matrix is \(1/2\), by pairing the edges. Therefore \(A_1>1/2-1/400000\). Using the stronger rational lower bound just displayed for \(A_2\) gives \((A_1+A_2)/2>21/40\). The companion script evaluates these bounds exactly.

# 6. Relation to the pinned cases

The pinned activity counterexample gives two-step violations for every degree at least three and an explicit limiting value \(1/2+(d-2)/(d^2(d+1))\) for a two-clique family. The companion bridge construction supplies another family of violations. The present bounds optimize over all finite connected regular graphs and all initially Gibbs cooling parameters in the stated model, and rule out two-step violations at degrees one and two. They concern the first two updates. The comparison is to the two pinned repository cases.
