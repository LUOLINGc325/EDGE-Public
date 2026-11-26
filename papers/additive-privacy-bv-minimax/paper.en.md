# A square-to-clipped-square transition in high-privacy noise

Consider location release on \(\mathbb R^2\). Two locations are adjacent when their \(\ell_1\) distance is at most \(\Delta>0\). For probability measures, write \(\operatorname{TV}(\mu,\nu)=\sup_B|\mu(B)-\nu(B)|\), and let \(\mu_h\) be the translate by \(h\). At \((0,\delta)\) privacy the feasible additive noise laws obey \(\operatorname{TV}(\mu,\mu_h)\le\delta\) for every adjacent shift \(h\). The loss is \(\|x\|_2^p\), with \(p>0\).

For \(1\le r\le\sqrt2\) let \(E_r=[-1,1]^2\cap B_r\), \(A(r)=|E_r|\), and \(I_p(r)=\int_{E_r}\|x\|_2^p\,dx\). Write \(r_p=\sqrt2\) for \(0 < p\le2\). For \(p>2\), define \(r_p\in(1,\sqrt2)\) by
\[
 r_p^p A(r_p)=(p+1)I_p(r_p).
 \tag{1}
\]
This root exists and is unique.

**Theorem.** The infimum worst-case risk \(V_p(\delta,\Delta)\), over all Borel \((0,\delta)\)-private location release kernels, has the limit
\[
 \lim_{\delta\downarrow0}(\delta/\Delta)^p V_p(\delta,\Delta)
   =\frac{2^p I_p(r_p)}{A(r_p)^{p+1}} .
 \tag{2}
\]
The infimum agrees with the additive infimum for every \(\delta\in(0,1)\). The unique optimal density in the rescaled limiting problem is uniform on \((2/A(r_p))E_{r_p}\). Any sequence of additive noise laws attaining the right side of (2) after rescaling converges weakly with convergence of \(p\)-moments to that uniform law. Consequently, for \(p\ge1\) it converges in \(p\)-Wasserstein distance. The rescaled uniform shape is a square for \(p\le2\) and has its corners removed by a concentric disk for \(p>2\).

## Reduction to a bound on directional variation

The minimax reduction uses translation averaging. For a kernel \(K\), let \(\mu_x\) be the law of output minus \(x\) at location \(x\), and average \(\mu_x\) over \(x\) in the cube \([-L,L]^2\) to obtain \(\bar\mu_L\). Privacy at \(x,x+h\) gives \(\operatorname{TV}(\mu_x,(\mu_{x+h})_h)\le\delta\). Averaging and comparing the shifted and unshifted averaging windows give
\[
 \operatorname{TV}(\bar\mu_L,(\bar\mu_L)_h)
 \le \delta+\frac{|([-L,L]^2+h)\mathbin{\triangle}[-L,L]^2|}{(2L)^2}.
\]
If the kernel has finite worst-case risk, these averaged laws are uniformly \(p\)-moment bounded and hence tight. Any subsequential weak limit meets every translation bound, by lower semicontinuity of total variation under weak convergence of the two measures. Its moment is at most the kernel worst-case risk. Conversely an additive release is a location kernel. This gives equality of the infima.

After rescaling noise by \(\delta/\Delta\), the finite-budget condition is \(\operatorname{TV}(\mu,\mu_h)\le\delta\) for \(\|h\|_1\le\delta\). By splitting any \(h\) into shifts of that size and using the triangle inequality,
\(\operatorname{TV}(\mu,\mu_h)\le\|h\|_1+\delta\). A weak limit of laws with \(\delta\to0\) has \(\operatorname{TV}(\mu,\mu_h)\le\|h\|_1\) for every \(h\). It has a density because convolution by an approximate identity converges in total variation by this bound. For its density \(f\), each distributional derivative obeys \(|D_i f|(\mathbb R^2)\le2\) by testing difference quotients against bounded, smooth compactly supported functions. Conversely, for a density with these two derivative bounds, the BV shift inequality gives
\(\operatorname{TV}(f\,dx,(f\,dx)_h)\le \sum_i |h_i||D_i f|(\mathbb R^2)/2\le\|h\|_1\). This follows by integration along each coordinate for smooth convolutions and passage to the \(L^1\) limit. Such densities are feasible at every rescaled finite budget. It remains to minimize the moment with the two directional variation bounds.

## A planar set inequality

For a measurable set \(E\) of finite positive area and finite perimeter, let \(P(E)=|D_1 1_E|(\mathbb R^2)+|D_2 1_E|(\mathbb R^2)\). Write \(X,Y\) for the sets of coordinates on each axis whose corresponding slices of \(E\) have positive one-dimensional measure. If \(|X|=2a\), \(|Y|=2b\), slicing gives \(P(E)\ge4(a+b)\), because a nonzero integrable indicator on a line has variation at least two. Also \(E\subseteq X\times Y\) up to null sets by Fubini.

For each \(t>0\),
\[
 |E\cap B_t|\le|B_t\cap([-a,a]\times[-b,b])|
              \le |B_t\cap[-s,s]^2|,\qquad s=P(E)/8 .
 \tag{3}
\]
The first inequality centers \(Y\) at fixed \(x\), using the length of intersection with a centered interval, then centers \(X\) against the resulting even function decreasing with \(|x|\). For the second, let \(F_t(a,b)\) be the rectangle intersection area in (3). If \(a\ge b\), then
\[
 \partial_a F_t=4\min\{b,\sqrt{(t^2-a^2)_+}\}
 \ \le\ 4\min\{a,\sqrt{(t^2-b^2)_+}\}=\partial_b F_t.
\]
Balancing \(a,b\) at fixed sum weakly increases the area, and enlarging the balanced square to half-width \(s\ge(a+b)/2\) does so as well.

It follows that \(|E|\le4s^2\). Choose \(0 < r\le\sqrt2\) so that \(E'=s([-1,1]^2\cap B_r)\) has area \(|E|\), taking \(r=\sqrt2\) at full square area. Its mass in each centered disk is the lesser of \(|E|\) and the last area in (3). The tail formula for \(\|x\|_2^p\) shows that \(E'\) has no larger moment. Also \(P(E')\le8s=P(E)\). The quantity
\[
 \mathcal J_p(E)=\frac{\big(\int_E\|x\|_2^p\,dx\big) P(E)^p}{|E|^{p+1}}
 \tag{4}
\]
is invariant under positive dilations. The preceding comparison reduces its minimization to \(E_r\) with \(0 < r\le\sqrt2\). For \(r\le1\) these are disks and have a common value. For \(1\le r\le\sqrt2\), their directional perimeter sum is eight, because every slice in each coordinate direction inside its projection is one interval.

The minimizing argument below has \(r>1\). Equality for a full square forces \(a=b=s\) and \(E=X\times Y\) by \(|E|\le4ab\le4s^2\), with the moment minimized only when \(X,Y\) are centered intervals, using the strict increase of radial loss in each absolute coordinate. For a minimizing clipped square with \(1 < r < \sqrt2\), equality of moments requires equality in the distribution comparison for every \(t\), by continuity of the disk-intersection volumes. For any \(t\in(s,sr)\), a smaller sum of widths or an unequal pair of widths gives strict loss in (3). The derivatives just displayed give strict improvement during balancing near half-width \(s\): here \(s < t < \sqrt2 s\), so the circle crosses the interior of the sides near the balanced square. The increasing square-area comparison is also strict near \(s\). With \(a=b=s\), the centered-\(Y\) slice length in (3) is strictly decreasing in \(|x|\) near \(|x|=s\), since \(s < t < \sqrt2s\). Among sets \(X\) of length \(2s\), its integral is therefore uniquely maximized by \([-s,s]\) up to null sets. Reversing the centering order yields the same conclusion for \(Y\). Inside that square the smallest radial moment at the given area is uniquely obtained by taking the points closest to the origin, since circles have zero area. Thus all equality cases of (4) are dilates of the minimizing centered \(E_r\).

## The exact phase transition

On \(1 < r < \sqrt2\), \(A'(r)=r[2\pi-8\arccos(1/r)]>0\), from the angle of the circle lying in the square, and \(I_p'(r)=r^p A'(r)\). Hence the derivative of \(I_p(r)/A(r)^{p+1}\) has the sign of \(F(r)=r^p A(r)-(p+1)I_p(r)\). At \(r=1\), \(F(1)=-\pi p/(p+2) < 0\). Its derivative equals \(p r^{p-1}(A(r)-r A'(r))\). On this interval,
\[
 A''(r)=2\pi-8\arccos(1/r)-8/\sqrt{r^2-1} < 0 .
\]
Thus \(A-r A'\) increases strictly from \(-\pi\) to \(4\). The function \(F\) first decreases then increases strictly. There is one interior minimum of the risk profile precisely when \(F(\sqrt2)>0\).

Let \(U=\|X\|_2/\sqrt2\) for \(X\) uniform on \([-1,1]^2\), with distribution function \(H\). The sign of \(F(\sqrt2)\) is the sign of \(1/(p+1)-E U^p\). For \(0\le t\le1/\sqrt2\), \(H(t)=\pi t^2/2\). Hence \(H(t)-t\) is negative up to \(2/\pi\) and becomes positive up to \(1/\sqrt2\). Strict concavity of \(A(r)\) for \(1 < r < \sqrt2\), with \(H(1)=1\), keeps \(H(t)-t>0\) for the rest of \(0 < t < 1\) after this one crossing. Since \(E U^2=1/3\), the integral \(\int_0^1 t(t-H(t))\,dt\) vanishes. For \(p>2\), multiplying its integrand by \(t^{p-2}\) decreases the integral strictly below zero: after subtracting the constant \((2/\pi)^{p-2}\), the multiplier times the original integrand is negative on each side of the crossing. It increases it strictly above zero for \(0 < p < 2\), and is integrable for every \(p>0\). By \(E U^p-1/(p+1)=p\int_0^1 t^{p-1}(t-H(t))\,dt\), the sign of \(F(\sqrt2)\) is thus positive for \(p>2\), zero for \(p=2\), and negative for \(p < 2\). This proves the unique minimizer \(r_p\) as defined, including its strict improvement over the disk.

## Densities, equality, and the rescaled limit

Write \(J_p=\mathcal J_p(E_{r_p})\). For a density \(f\) of total mass one, let \(E_t=\{f>t\}\) and \(a(t)=|E_t|\). By directional coarea,
\(\int_0^\infty P(E_t)\,dt=|D_1 f|(\mathbb R^2)+|D_2 f|(\mathbb R^2)\le4\).
Layer cake, (4), and Jensen under the probability measure \(a(t)\,dt\) yield
\[
 \int \|x\|_2^p f(x)\,dx
 \ \ge\ J_p\int_{a(t)>0} a(t)\left(\frac{P(E_t)}{a(t)}\right)^{-p}\,dt
 \ \ge\ J_p\,4^{-p}.
\]
Equality requires almost every nonempty level set to be a centered scaled copy of \(E_{r_p}\) and to have a common perimeter-to-area ratio of four, by strict convexity and strict decrease of \(z^{-p}\) on the positive line. That ratio fixes the scale, so \(f\) is constant on a single copy and zero off it. The copy with scale \(2/A(r_p)\) gives total directional variation four for its uniform density, with the two variations equal by symmetry. It therefore meets the two separate bounds and attains equality. Substituting in \(J_p4^{-p}\) gives the constant in (2).

The uniform density just constructed gives the corresponding finite-budget upper bound after rescaling. Any bounded-risk sequence of rescaled noise laws is tight. Every weak limit has the two directional variation bounds, and lower semicontinuity of its moment gives the opposite limiting bound. For a near-minimizing sequence every weak limit attains the bound and is therefore the stated uniform density. Weak convergence and convergence of moments give the additional Wasserstein conclusion.

## Related work

It is the \(\ell_1\) translation condition that leads to two directional variation constraints, and the Euclidean loss results in the clipped optimizer when \(p>2\). Geng and Viswanath, §V.A and Corollary 23, study integer-valued histograms with \(\ell_1\)-bounded integer shifts and give the same leading squared-error constant \(d/12\) as their lattice uniform mechanism. In dimension two their result is consistent with the square and the leading constant \(1/6\) here. The general radial power and shape boundary above are the additional conclusions. Geng, Ding, Guo and Kumar treat a scalar real-valued query and general cost. The present planar shape argument uses the two essential projection lengths. [Geng–Viswanath, IEEE Transactions on Information Theory](https://doi.org/10.1109/TIT.2015.2504972) [Geng–Ding–Guo–Kumar, AISTATS 2019](https://proceedings.mlr.press/v89/geng19a.html)
