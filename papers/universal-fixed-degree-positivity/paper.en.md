---
title: "Universal Bernstein positivity for qubit shell capacity"
subtitle: "Integer heights, quadratic dual certificates and sharp coefficient limits"
date: "25 November 2026"
geometry: margin=0.9in
---

## Abstract

The resonant-shell bound for cooling a qubit produces a polynomial for every positive integer ordered composition of the machine dimension. Scalar nonnegativity on the temperature interval is known. The stronger conjecture that every Bernstein coefficient at degree one less than the dimension is nonnegative was open. We prove it for every dimension and classify all zero coefficients. The proof combines integer height layers with explicit quadratic dual certificates. These arguments handle all dimensions from 1000 onwards. The remaining dimensions are certified by a self-contained directed-integer verification, with a separate exact Bellman cross-check. We also derive a sharp left-edge asymptotic for the minimum coefficient, characterize the limiting minimum in the interior, and find its limit near the right edge.

## 1. Statement

Let \(m\ge2\), \(d=m-1\), and \(n=(n_0,\ldots,n_L)\) be a positive integer ordered composition of \(m\), so \(0\le L\le d\). With
\[
 h_i=\frac{n_i n_{i+1}}{n_i+n_{i+1}}\quad(0\le i<L),
\]
the polynomial of interest is
\[
 G_n(t)=\left(1-\frac1m\right)\sum_{i=0}^L n_i t^i
       -(1+t)\sum_{i=0}^{L-1}h_i t^i.
\]
In the local resonant collision model this is the polynomial after the shell-capacity reduction [1–3]. The reduction concerns a qubit reference system, exact preservation of product reference weights, and a local quadratic coefficient. The scalar bound \(G_n(t)\ge0\) for \(0\le t\le1\) was already proved in [3]. Our theorem addresses the stronger coefficient conjecture recorded in [2, §8].

**Theorem 1.** In the degree-\(d\) Bernstein expansion
\[
 G_n(t)=\sum_{k=0}^d B_k(n)\binom d k t^k(1-t)^{d-k},
\]
every \(B_k(n)\) is nonnegative. The zero cases are exactly \(k=0\) with \(n=(1,m-1)\), and \(k=d-1\) or \(k=d\) with \(n=(1,\ldots,1)\). Overlapping index descriptions agree at \(m=2\).

This finishes the fixed-degree certificate at the dimension-dependent degree \(d\) without subdividing the temperature interval. It does not posit any change in the physical scope of the original scalar theorem. The least possible coefficient at a given pair \((m,k)\) is denoted by \(\beta_{m,k}\).

## 2. Two coefficient identities

Set \(r=d-k\) and \(q=k/d\) when \(0<k<d\). Put
\[
 W_i=\frac{\binom{k}{i}}{\binom{d}{i}}
     =\frac{\binom{d-i}{r}}{\binom d r}\quad(0\le i\le k),\qquad
 W_i=0\quad(i>k).
\]
By the standard monomial-to-Bernstein identity [2, Eq. (3)],
\[
 S=\sum_i W_i n_i,\qquad
 D=S-\sum_i h_i(W_i+W_{i+1}),\qquad B_k=D-S/m.
 \qquad\text{(1)}
\]
When helpful pad \(n_i\) by zeros for \(i>L\), set \(h_i=0\) unless both entries are positive, and set a term with zero numerator and denominator to zero. For \(0\le i\le k\), write \(q_i=(k-i)/(d-i)\), \(\phi_i=q_i/(1+q_i)\), and \(a_i=W_i n_i\). Then
\[
 B_k=\sum_{i=0}^{k} W_i
 \left[(1+q_i)\frac{n_i^2}{n_i+n_{i+1}}-(q_i+1/m)n_i\right].
 \qquad\text{(2)}
\]
Indeed, use \(h_i=n_i-n_i^2/(n_i+n_{i+1})\) in the outgoing edge term. The geometric-weight square identity of [3, §2] has the following counterpart for varying binomial ratios. Completing the edge squares in (1) gives
\[
 \begin{aligned}
 B_k&=\phi_0 n_0+\sum_{i=0}^{k}E_i-S/m-\sum_{i=1}^k\Delta_i a_i,\\
 E_i&=\frac{(a_i-a_{i+1})^2}{(W_i+W_{i+1})(n_i+n_{i+1})},
 \qquad
 \Delta_i=\phi_{i-1}-\phi_i
       =\frac{r}{(d+k-2i)(d+k-2i+2)}.
 \end{aligned}
 \qquad\text{(3)}
\]
For example, at edge \(i\) the square equals
\(\frac{1}{1+q_i}a_i+\frac{q_i}{1+q_i}a_{i+1}-(W_i+W_{i+1})h_i\).
Summing leaves the boundary term and the consecutive \(\phi_i\) differences. The endpoint with \(W_{k+1}=0\) is included and may still meet a positive multiplicity \(n_{k+1}\).

For \(r\ge2\), \(W_i\Delta_i\) is nonincreasing in \(i=1,\ldots,k\). To see this, put \(x=d-i\) and compare the binomial expression for \(W_i\Delta_i\) at \(x+1\) and \(x\). After positive denominators are cleared, the sign is that of \((r-2)(2x-r+2)\ge0\). In particular the largest weighted curvature occurs at \(i=1\). We use \(W_i\le q^i\) throughout.

## 3. Small indices

Write \(a=n_0\), \(b=n_1\) (which can be zero), \(\xi=(k+1)/d\), and define
\[
 Z=\frac{m\xi^3}{q},\qquad A=\frac{m\xi^2 q^2}{4(1-q)}.
\]
In (2), \(q_i+1/m\le\xi\). Keep the denominator \(a+b\) in the first row and bound the others by \(m\). For \(i\ge2\), the minimum of \(x^2/m-\xi x\) is \(-m\xi^2/4\), which gives
\[
 B_k\ge \frac{a^2}{a+b}-\xi a
              +q(b^2/m-\xi b)-A.
\]
With \(x=b/a\), \(s=\xi x\), and \(y=\xi+s\), divide the positive first term and the \(q\)-term by \(a\xi\). Using \(a\ge1\), \(q\le\xi\), and \(1/y\ge2-y\), the result is at least
\[
 1/y+s^2/Z-s\ge2-\xi-2s+s^2/Z\ge2-\xi-Z .
\]
Therefore \(B_k\ge a\xi(1-\xi-Z)-A>0\) whenever
\[
 \xi+Z+A/\xi<1.
 \qquad\text{(4)}
\]
In particular, if \(m\ge3(k+1)^2\), then \(m\ge12\),
\(q\le1/11\), and \(\xi\le2/11\). Using \(m/d\le12/11\) and \((k+1)/k\le2\) gives \(Z\le96/121\). Also
\(m\xi q\le48/121\), so \(A/\xi\le6/605\). The three upper bounds sum to less than one. This covers \(k=1\) for \(m\ge12\), and \(k=2\) for \(m\ge27\). In fact \(k=2\) is positive for all \(m\ge12\) by a separate direct bound. With the first four entries \(a,b,c,e\), padding missing entries by zero, (2) gives
\[
 dB_2=\frac{(m+1)a^2}{a+b}-3a+\frac am
 +2\left[\frac{m-1}{m-2}\frac{b^2}{b+c}-\frac bm-\frac b{m-2}\right]
 +\frac2{m-2}\left[\frac{c^2}{c+e}-\frac cm\right].
\]
The last bracket is nonnegative by integrality and \(c+e\le m\). Since \(b+c\le m-1\), the middle bracket is at least \((b^2-2b)/m\). Consequently \(dB_2\ge(m+1)a^2/(a+b)-3a+(2b^2-4b+a)/m\). For \(a\ge3\), use \(a+b\le m\) and \(2b^2-4b\ge-2\), giving strict positivity. For \(a=1,2\) and \(b\ge4\), \((2b^2-4b+a)/(a+b)\ge3\), so arithmetic-geometric mean applied to \(ma^2/(a+b)\) and \((2b^2-4b+a)/m\) gives more than \(3a\). For \(a=1,2\) and \(b\le3\) the first two terms already give at least \(1/4>2/m\).

## 4. Integer height estimates

For \(r\ge2\) the weights \(W_i\) are decreasing and convex on the index lattice. Write \(N=L+1\), \(U=m-N\), and \(u_i=n_i-1\). Let \(D_0=(1+W_L)/2\) and \(S_0=\sum_{i=0}^L W_i\), the values of \(D,S\) for the all-ones chain on the same \(N\) indices. Extend the weights by \(W_{-1}=2-W_1\), so their second difference at zero vanishes. The maximum second difference elsewhere is
\[
 K=\frac{r(r-1)}{d(d-1)} .
\]
Indeed the second difference at \(i\ge1\) is \(\binom{d-i-1}{r-2}/\binom d r\) on its nonzero range and zero afterwards.

For any integers \(A_0>B_0\ge1\),
\[
 \frac{(A_0-B_0)^2}{A_0+B_0}\ge
 \sum_{j=B_0}^{A_0-1}\frac1{2j+1},
 \qquad\text{(5)}
\]
because the sum is at most \((A_0-B_0)/(2B_0+1)\), which is at most the left side. Use \(h_i=(n_i+n_{i+1}-(n_i-n_{i+1})^2/(n_i+n_{i+1}))/4\) in (1). Relative to \(D_0\), the expansion of \(D\) consists of edge energies with factor \((W_i+W_{i+1})/4\), endpoint terms with factors \((W_{-1}+W_0)/4,(W_L+W_{L+1})/4\), and the subtraction of the weighted second differences of the \(u_i\), with factor \(1/4\). The latter loss is at most \(KU/4\). These expressions also account for both endpoint terms when \(L=0\).

Decompose \(u_i\) into integer superlevels. At height \(j\ge1\), each interval component \([a,b]\) of \(\{i:u_i\ge j\}\), of length \(\ell=b-a+1\), receives at least
\[
 \frac{W_{a-1}+W_a+W_b+W_{b+1}}{4(2j+1)}
 \ \ge\ \frac{1}{(2j+1)\ell}\sum_{i=a}^b W_i
\]
from its boundary energies by (5). The endpoint coefficients without division are at least the divided amounts used here. The inequality uses convexity, first at the two outside indices and then the trapezoid bound for the interval. The mass subtraction \(S/m\) asks this block for \(\sum_{i=a}^b W_i/m\). Thus a possible deficit is at most
\[
 \frac{\ell}{m}\max\!\left(0,1-\frac{m}{(2j+1)\ell}\right).
\]

Suppose \(U>0\), put \(x=U/m\), and for each block put \(p_*=j\ell/U\). Since \(\ell\le N\), \((2j+1)\ell/m\le1-x+2xp_*\). Hence the block deficit is at most \((\ell/m)f_x(p_*)\) with \(f_x(y)=\max(0,1-1/(1-x+2xy))\) on \(y>1/2\), and zero for \(y\le1/2\). For \(y>1/2\), every block with \(p_*\ge y\) accounts for more than half of the \(U\) height units over its support up to its height. These supports cannot be disjoint, and components of the nested superlevel sets are nested when they intersect. In particular, if the lowest such block has height \(j_0\) and length \(\ell_0\), its \((j_0-1)\ell_0\) units below do not belong to qualifying blocks. The sum of the lengths of qualifying blocks is therefore at most
\[
 U-(j_0-1)\ell_0\le U(1-y)+N=m(1-xy).
\]
The inequality is also valid when none qualify. Integrate \(f_x'\) on \([1/2,1]\) to bound the total deficit by
\[
 \mathcal D(x)=\int_{1/2}^1\frac{2x(1-xy)}{(1-x+2xy)^2}\,dy
 =\frac12\left[\frac{(3-x)x}{1+x}-\log(1+x)\right].
\]
For \(U=0\) use \(\mathcal D(0)=0\). The binomial summation
\(\sum_{i=0}^d W_i=m/(r+1)\) gives, with \(\theta=mK/4\),
\[
 B_k\ge \frac12-\frac1{r+1}-\mathcal D(x)-\theta x .
 \qquad\text{(6)}
\]
Direct differentiation gives \(\mathcal D'(x)\ge-1/4\) for \(0\le x\le1\). Also \(\mathcal D(x)\le9/40\): use \(\log(1+x)\ge2x/(2+x)\), then clear the positive denominators. The resulting numerator \(18-53x+29x^2+20x^3\) is at least \(13-38x+29x^2>0\), since the difference is \(5(2x-1)^2(x+1)\). Finally \(\mathcal D(1)=(1-\log2)/2<25/162\), using \(\log2>56/81\) from the first two terms of its series in \(1/3\). In particular
\[
 \mathcal D(x)+\theta x\ \le\
 \min\{9/40+\theta,\ \mathcal D(1)+\max(\theta,1/4)\}.
 \qquad\text{(7)}
\]

### The second last positive coefficient

For the case \(r=2\), use an alternative grouping with an exact increment. Build \(n\) from ones by increasing each superlevel block \([a,b]\) from height \(h-1\) to \(h\), where \(h\ge2\). Interior harmonic means increase by \(1/2\); across a boundary an exterior value at most \(h-1\) gives an increase at most \((h-1)/(2(2h-1))\). When \(a>0\), set \(z=W_a+W_b\), \(T=\sum_{i=a}^b W_i\), \(\eta=1+W_L\), \(\gamma=mK/2\), and \(v=(2h-1)\ell/m\le2\). The two boundary weights sum to \(2z\) plus at most \(\ell K\), by telescoping the consecutive differences. A missing right boundary can be charged anyway for a lower bound. Since \(T\le\ell z/2\), the increment satisfies
\[
 2(2h-1)\left[\Delta D-\frac{T-\ell D_0}{m}\right]
 \ge z-v(z-\eta+\gamma).
\]
For \(r=2\) and \(m\ge4\), \(\gamma\le 2/d\), and \(z\le2W_1=2(1-2/d)\le2(1-\gamma)\). If the bracket \(z-\eta+\gamma\) is nonpositive, the inequality pays the entire block charge. If it is positive, taking \(v=2\) gives \(2\eta-2\gamma-z\ge0\). When \(a=0\), the only possible boundary is on the right; the increment is at least \(1/2\), which is at least \((T-\ell D_0)/m\). Thus \(D-D_0\ge(S-S_0-UD_0)/m\), or \(B_k\ge(ND_0-S_0)/m\). When \(N\ge3\), the trapezoid bound is strict because the first three weights have positive second difference. With one layer \(B_k=m-1\); with two layers \(B_k=[n_0(n_0-1)+W_1 n_1(n_1-1)]/m>0\) for \(m\ge4\), \(k=d-2\).

## 5. Quadratic dual estimates

For any nonnegative \(\lambda_i\) on \(0\le i\le k\), completing a square in (3) yields
\[
 E_i\ge2\lambda_i(a_i-a_{i+1})
       -\lambda_i^2(W_i+W_{i+1})(n_i+n_{i+1}).
\]
Let \(C_i=\lambda_i^2(W_i+W_{i+1})\), put \(C_{-1}=C_{k+1}=0\), and write \(c_0\) for the resulting lower coefficient of \(n_0\). The vertex bounds are
\[
 \begin{aligned}
 c_0&=\phi_0-1/m+2\lambda_0-C_0,\\
 c_i&=-W_i[1/m+\Delta_i-2(\lambda_i-\lambda_{i-1})]-C_{i-1}-C_i
       &&(1\le i\le k),\\
 c_{k+1}&=-C_k .
 \end{aligned}
 \qquad\text{(8)}
\]
All later coefficients vanish. Since \(n_0\ge1\), if \(c_0>0\) and \(c_0>(m-1)\max(0,\max_{i\ge1}(-c_i))\), then \(B_k>0\).

Use the geometric family
\[
 \lambda_i=\frac{\tau(1-q^i)/(1-q)+\eta}{2m}.
 \qquad\text{(9)}
\]
We prove enough uniform bounds to leave a finite, modest certificate. In the rest of this section assume \(m\ge1000\) and \(1\le k\le d-2\), so \(r\ge2\).

### Middle and left

For \(q\le7/8\) use (4) if \(m\ge3(k+1)^2\). Otherwise use \(\tau=\eta=1\) in (9). Then \(c_0=\phi_0-C_0\) with \(C_0=(1+q)/(4m^2)\). For \(i\ge2\), the residual \(W_i(1-q^{i-1})\) in the \(m\)-scaled tail cost is at most \(q/4\). The curvature term is at most \(m W_2\Delta_2\le0.127q\), by monotonicity in Section 2. Indeed
\[
 m W_2\Delta_2
 \le \frac{m}{d}\,\frac{q^2(1-q)}{(1+q-4/d)^2}
 < 1.016\,\frac{q^2(1-q)}{(1+q)^2}\le 0.127q.
\]
The last inequality is \(q(1-q)/(1+q)^2\le1/8\). The kinetic term \(m(C_i+C_{i-1})\) is at most
\[
 \frac{(2-q)^2}{m(1-q)^2}q^{i-1}\le 0.081q
\]
using \(W_i\le q^i\) and \(\lambda_i\le(2-q)/[2m(1-q)]\). The bounds on curvature and residual are interpreted as zero at \(i=k+1\). The total is at most \(0.458q<c_0\), since \(\phi_0\ge q/2\) and \(C_0/q\le1/(2m)\).

For \(i=1\) the residual is zero. The exact curvature margin is
\[
 \phi_0-d W_1\Delta_1=\frac{2q(k-1)}{(1+q)(d+k-2)}.
\]
The cost from \(C_0+d(C_0+C_1)\) is at most \((1+q)(q+1/4)/m\). A sufficient comparison is
\[
 \frac{2m q^2(1-1/k)}{(1+q)^3}> q+1/4.
\]
If \(q\le1/8\), \(k>\sqrt{m/3}-1\) gives \(k\ge18\), \(mq^2\ge(k/(k+1))^2/3\); inserting \(k\ge18\) and \(q\le1/8\) makes the left side exceed \(3/8\). If \(1/8<q\le7/8\), using \(m\ge1000\), \(k\ge18\), and the extreme bounds on \(q\) makes the left side exceed \(9/8\). Thus every coefficient in (8) passes its comparison.

### Right

For \(q\ge7/8\) and \(r^2\ge m\), use \(\tau=3/4,\eta=0\) in (9). For \(s=q^{i-1}\) the sum of the residual and kinetic terms in the \(m\)-scaled cost is at most
\[
 q s(1-3s/4)+\frac{9}{16m(1-q)^2}s(1-qs)^2.
 \qquad\text{(10)}
\]
Indeed \(W_i\le q^i\), and the kinetic terms use \(\lambda_{i-1}\le\lambda_i\) and \(W_{i-1}+2W_i+W_{i+1}\le4q^{i-1}\). For \(q\ge15/16\), use \(m(1-q)^2\ge1\) to majorize (10) by the cubic \(f(s)=s(1-3s/4)+(9/16)s(1-15s/16)^2\). It is concave on \([0,1]\), and the maximum of its tangent line at \(s=9/16\) over that interval is \(3326423/8388608<2/5\). The curvature cost is at most \(m r/d^2<0.063\): this follows from \(W_i\le((d-i)/d)^r\) and \(\Delta_i\le r/(d-i)^2\). Thus the tail cost is strictly below \(c_0=\phi_0-1/m\ge15/31-0.001\). For \(7/8\le q\le15/16\), the residual is at most \(5/16\), and \(s(1-qs)^2\le4/(27q)\) on \([0,1]\). Together with \(1-q\ge1/16\) these bound the kinetic cost by \(0.025\). The curvature cost is below \(0.126\); the sum is below \(c_0\ge7/15-0.001\).

If \(q\ge7/8\) and \(r^2\le m\), use (6)–(7). Here \(\theta\le0.251\). For \(r\ge10\), the total loss \(\mathcal D(x)+\theta x<25/162+0.251<9/22\le1/2-1/(r+1)\). For \(3\le r\le9\), \(\theta<0.019\), and \(9/40+0.019<1/4\le1/2-1/(r+1)\). The case \(r=2\) was proved in Section 4. This completes the analytic range \(m\ge1000\).

## 6. Finite bridge and equality cases

The program first checks all 45,056 composition–coefficient pairs for \(2\le m\le12\) by direct integer enumeration. For \(m\ge13\), Sections 3–4 cover \(k=1,2\) and \(r=2\). Section 5 covers all \(m\ge1000\). Thus the finite bridge is \(13\le m<1000\), \(3\le k\le m-4\).

The bridge checks (4), the two rational sufficient bounds from (7), or the vertex inequalities (8) with the profiles \((\tau,\eta)=(3/4,0)\) and \((1,1)\). Products of rational weights and geometric powers are enclosed with outward rounding to integer multiples of \(2^{-48}\). The code rounds each cost upwards and \(c_0\) downwards, with no floating-point comparisons. The first four sufficient tests account for 16,453, 21,000, 383,383, and 72,628 pairs, respectively. All 36 remaining pairs have \(r=3\). For each, the code checks all integer \(0\le U<d\) in the more precise height lower bound that keeps the terminal weight:
\[
 B_k\ge\frac14+\frac{\binom U3}{2\binom d3}
      -\frac{4x-x^2-x^3}{2(1+x)(2+x)}
      -\frac{6U}{4d(d-1)},\qquad x=U/m .
\]
This follows from the same derivation as (6) and \(\log(1+x)\ge2x/(2+x)\). The one-layer case \(U=d\) always has \(B_k=m-1\). All 493,500 pairs pass the bridge. This check is independent of the precursor's earlier enumeration through dimension 64. An independent exact Bellman calculation computed all minima in dimensions 65 to 100 and corroborated positivity and the zero pattern. At dimension 100 its output agreed exactly with the ordinary Bellman implementation.

At \(k=0\) the coefficient equals \(n_0^2/(n_0+n_1)-n_0/m\) with a second layer, zero exactly for \((1,m-1)\). At \(k=d\) the weights are all one. The endpoint identity
\[
 B_d=\frac{n_0+n_L-2}{2}
     +\frac12\sum_{i<L}\frac{(n_i-n_{i+1})^2}{n_i+n_{i+1}}
\]
has equality exactly for the all-ones chain. At \(k=d-1\), the weights are the affine sequence \(W_i=(d-i)/d\) through \(i=d\). If \(U=0\) the all-ones coefficient is zero. If \(U>0\), then \(L<d\) and the second differences for all occupied indices vanish. The baseline at the same length is \(U(m+U-1)/(2dm)\ge x(1+x)/2\), with \(x=U/m\). The block proof in Section 4 gives a deficit at most \(\ell x/[m(1+x)]\) per block since \((2j+1)\ell\le m+U\). Summation gives \(B_k\ge x(1+x)/2-x^2/(1+x)>0\). These reproduce the endpoint conclusions from [2]. They also give the complete equality classification, using the strict bridge comparisons and the exact checks in dimensions up to 12. This proves Theorem 1.

## 7. Sharp limits of the minimum

The proof of Theorem 1 gives a sign certificate. The following limits describe the sizes of the smallest coefficients.

**Theorem 2.** Let \(m\to\infty\), \(1\le k\le d-2\), and \(q=k/d\).

1. If \(k=o(m^{1/5})\), then
   \[
   \beta_{m,k}\sim \frac{3}{2^{2/3}}(q/m)^{1/3}.
   \qquad\text{(11)}
   \]
   If \(k/m^{1/5}\to c\in(0,\infty)\), then
   \[
   m^{3/5}\beta_{m,k}\longrightarrow
   \min_{0<z\le1}\left[
   \frac{3}{2^{2/3}}(c/z)^{1/3}+c^2 z^2\right].
   \qquad\text{(12)}
   \]
2. If \(q\to t\in(0,1)\), then
   \[
   \beta_{m,k}\longrightarrow \Gamma(t)
   :=\inf_{n_0,n_1,\ldots\in\mathbb Z_{\ge1}}
   \frac{t n_0+\sum_{i\ge0}t^i(n_i-t n_{i+1})^2/(n_i+n_{i+1})}{1+t}.
   \qquad\text{(13)}
   \]
   The infimum is attained. It equals \(t/(1+t)\) exactly when \(1/t\) is an integer. It equals \(1/2\) for \(t\ge(5+\sqrt{57})/16\).
3. If \(q\to1\) and \(r=d-k\to\infty\), then \(\beta_{m,k}\to1/2\).

### The left side

In (2) all the negative terms together have magnitude at most
\[
 (q+1/m)(a+qb+q^2m),\qquad a=n_0,\quad b=n_1.
 \qquad\text{(14)}
\]
The first two positive terms are bounded below by \(a^2/(a+b)+qb^2/m\). Write \(\epsilon=(q/m)^{1/3}\). For \(b\le a\) the first term is at least \(a/2\); for \(b>a\) their sum is at least \(\inf_{y>0}\{a^2/(2y)+qy^2/m\}\), a positive constant times \(a^{4/3}\epsilon\). In either case it is at least a constant times \(a\epsilon\). Whenever \(k=O(m^{1/5})\), (14) is bounded by \(o(\epsilon)a+O(\epsilon)\) even using \(b\le m\). There are compositions with coefficient \(O(\epsilon)\), for example \(n=(1,b,m-1-b)\) with \(b\) the nearest integer to \(2^{-1/3}/\epsilon\), by the first three positive terms of (2). It follows that any minimizing sequence has \(a=O(1)\). The two positive terms then force \(b\) to be bounded above and below by positive multiples of \(1/\epsilon\), and (14) improves to \(o(\epsilon)\).

For \(k=o(m^{1/5})\), \(W_2m\le q^2m=o(\epsilon)\). The first two terms, scaled by \(\epsilon^{-1}\), are bounded below in the limit by \(a^2/y+y^2\) with \(y=b\epsilon\), using \(a+b\sim b\). Its infimum over positive integer \(a\) and \(y>0\) is \(3/2^{2/3}\) at \(a=1,y=2^{-1/3}\). The same three-layer composition above realizes the upper bound. This proves (11).

When \(k\sim c m^{1/5}\), \(\epsilon\sim c^{1/3}m^{-3/5}\). The second positive term of (2) now forces \(n_2\) to be bounded below by a positive multiple of \(m\), since \(b\) is bounded below by a multiple of \(m^{3/5}\) and the whole term is \(O(m^{-3/5})\). Along any subsequence with \(b/m^{3/5}\to y>0\), \(n_2/m\to z\in(0,1]\), and \(a\) fixed, the first two positive terms give \(a^2/y+c y^2/z\) after scaling by \(m^{3/5}\). The third gives at least \(c^2 z^2\) because \(W_2\sim q^2\) and \(n_2+n_3\le m\). Formula (14) is negligible at this scale. Conversely choose \(a=1\), \(b\) the nearest integer to \(ym^{3/5}\), and allocate mass so \(n_2/m\to z\) and \(n_2+n_3=m-1-b\). Omit the fourth layer for \(z=1\). Its cost for \(z<1\) is at most \(2W_3m=o(m^{-3/5})\). Minimizing in \(y\) proves (12). The minimizing mass fraction there is \(z_*=\min\{1,(2c)^{-5/7}\}\), so the value changes from \((3/2^{2/3})c^{1/3}+c^2\) for \(c\le1/2\) to \((7/2^{10/7})c^{4/7}\) for \(c\ge1/2\).

### The interior

For \(q\to t\in(0,1)\), the all-ones composition bounds the minimizing coefficient from above by \(1/2\) for large \(m\). The curvature loss in (3) is \(O(1)\) by \(m W_1\Delta_1=O(1)\). Therefore near-minimizers have bounded \(n_0\) and bounded total energy. For each fixed \(j\), \(W_i\) and \(q_i\) have positive limits for \(i\le j\). Since
\[
 E_i\ge \frac{q_i}{1+q_i}(\sqrt{a_i}-\sqrt{a_{i+1}})^2 \qquad (q_i>0),
\]
every fixed initial set of multiplicities is bounded. This inequality follows by factoring \(a_i-a_{i+1}\) into the sum and difference of square roots and bounding the denominator by \((1+q_i)(a_i+a_{i+1})/q_i\). No sequence of bounded chain lengths can then have mass \(m\to\infty\). In particular diagonal extraction gives an infinite positive integer profile. Both \(S/m\) and the curvature term vanish: the first fixed \(J\) terms have bounded multiplicities and \(\Delta_i=O(1/m)\), while the tails are bounded by \(q^J\) for \(S/m\) and \(mW_J\Delta_J\) for curvature. These latter bounds tend to zero as \(J\to\infty\), uniformly for \(q\) in a fixed compact interior interval. Applying (3) to any fixed prefix and then increasing \(J\) gives the lower bound in (13).

For the upper bound choose any infinite profile with finite cost and keep its entries through index \(J\). Put \(a_J=t^J n_J\). Over the next \(R\) positions taper \(\sqrt{a_i}\) linearly from \(\sqrt{a_J}\) to zero, then set the remaining target \(a_i\) to zero. Before rounding, the added square energy is \(O(a_J/R)\): the per-edge energy in the \(a_i\) coordinates is at most \(2(\sqrt{a_i}-\sqrt{a_{i+1}})^2\). Round the target multiplicities \(a_i/t^i\) upwards to positive integers, taking one at zero. The change in added energy is \(O(t^J)\). In fact the rational edge function \((x-t y)^2/(x+y)\) is uniformly Lipschitz on the nonnegative quadrant, with continuous value zero at the origin, as follows by differentiating on \(x+y>0\) and using \(|x-ty|\le x+y\). Each rounding changes its two arguments by at most one, multiplied by the factor \(t^i/(1+t)\). Choose \(J\) large and then \(R\) large. This construction has a fixed finite prefix and a tail of ones. It can be made into a composition of any sufficiently large \(m\) by appending enough ones. For these compositions the energies converge to the costs of the chosen profile with its taper: fixed terms converge and the subsequent terms admitted by appended ones are dominated by a geometric series, including the terminating edge. Dropping the subtracted quantities in (3) is valid for this upper bound. This proves (13).

The same bounded-energy and fixed-prefix compactness argument for the limiting functional shows that its infimum is attained. Nonnegativity of the summands implies the contact condition \(\Gamma(t)=t/(1+t)\) only when \(n_0=1\) and \(n_1=1/t\); the geometric integer profile with that ratio shows sufficiency. The all-ones profile has cost \(1/2\). When \(t\ge(5+\sqrt{57})/16\), an \(n_0\ge2\) alone exceeds \(1/2\). Starting from \(n_0=1\), any first departure to a value \(b\ge2\) at edge \(i\) costs at least \(t^i(2t-1)^2/[3(1+t)]\), by monotonicity in \(b\). This is at least the entire remaining all-ones cost \(t^i(1-t)/[2(1+t)]\), since \(8t^2-5t-1\ge0\). The prefix before that edge agrees with the all-ones profile. This proves the stated plateau.

### The right side

If \(q\to1\) and \(r\to\infty\), the all-ones upper bound is \(1/2-1/(r+1)\), and the curvature loss in (3) is at most \(m r/d^2=o(1)\). Along near-minimizers the total energy and \(n_0\) stay bounded. Fix \(C>0\) and \(J=\lfloor C d/r\rfloor\). The weights through \(J\) are bounded below by a strictly positive constant depending on \(C\), since \(W_i=\prod_{j<i}(1-r/(d-j))\). The successive ratios \(q_i\) there tend uniformly to one. We claim that the occupied multiplicities in these initial positions stay uniformly bounded. To prove this, fix a large integer \(H\) exceeding the bound on \(n_0\). At an upward edge with initial value \(u<H\) and final value \(v>u\), one has \(v/(v-u)\le H\). For large \(m\), \(q_i\ge1-1/(2H)\), so \(|u-q_i v|\ge(v-u)/2\). By (5) the edge energy then covers a fixed positive constant times \(\sum_{j=u}^{v-1}1/(2j+1)\). A first passage to \(H\) must cover all heights from \(n_0\) to \(H-1\). The sum diverges as \(H\) increases, contradicting the uniform energy bound for suitably chosen \(H\). This proves the claim. Therefore \(S/m\le H(J+1)/m+W_J\), with first term tending to zero and \(\limsup W_J\le e^{-C}\). Let \(C\to\infty\) and use (3) to get the lower bound \(1/2\). This completes Theorem 2.

## 8. An exact algorithm for the coefficient minima

The array of candidate second entries in the Bellman recursion of [2, §4] is a Monge matrix. At a fixed layer, fix the mass \(c\) remaining after the first entry. The row is that first entry \(a\), and the column is the next entry \(b\in\{1,\ldots,c\}\). The candidate cost has its next-layer value as a column term. Its mixed term is \(-(W_i+W_{i+1})ab/(a+b)\), with nonpositive mixed derivative
\[
 -(W_i+W_{i+1})\frac{2ab}{(a+b)^3}.
\]
Integrating over rectangles proves the Monge inequalities. This gives monotone leftmost minimizing columns. All row minima of a rectangle are found in time linear in its two side lengths by the standard totally monotone matrix search (SMAWK) [4], or with a logarithmic factor by monotone divide and conquer. Summing over masses \(c\) costs \(O(m^2)\) operations per layer. Thus all minima at fixed \(m\) take \(O(m^4)\) arithmetic operations with linear-time matrix search, improving the \(O(m^5)\) bound of [2]. The included exact implementation uses divide and conquer and preserves rational arithmetic via the integer factor \(m\operatorname{lcm}(1,\ldots,m)\binom d r\). This independent check is separate from the positivity proof in Sections 2–6.

## References

[1] Mishra and Senthilkumar. The local cooling problem, Theorems 1–2 and Supplements S10–S11, arXiv:2610.40709v1, as recorded in [2].

[2] earlier research manuscript. *Polynomial-Time Exact Certificates for Qubit Cooling Shell Capacity*. Fixed archive bb30fe2, especially §§3–8.

[3] earlier research manuscript. *Qubit cooling with arbitrary machine dimension*. Fixed archive bb30fe2, especially §§2–7. The superlevel-increment method for bounded multiplicities is documented in the bounded-degeneracy case, §5.

[4] A. Aggarwal, M. M. Klawe, S. Moran, P. Shor and R. Wilber. Geometric applications of a matrix-searching algorithm. *Algorithmica* 2, 195–208 (1987).
