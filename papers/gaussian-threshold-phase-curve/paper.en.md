---
title: "The exact Gaussian threshold noise-stability phase curve"
lang: en
geometry: margin=0.85in
---

# Abstract

For a standard bivariate normal vector with correlation \(a\in(0,1)\), compare the probability that both coordinates exceed \(c\) with the marginal tail to the power \(2-a\). We determine the sign at every pair \((c,a)\). For each correlation there is a unique threshold \(c_a\), and the inequality holds exactly below that threshold. The curve is smooth and strictly increasing. At small correlation its endpoint is determined by a normal hazard equation and it leaves that endpoint with a positive linear slope. At large correlation it grows like \((1-a)^{-1/2}\), with an explicit logarithmic correction. The proof uses a single turning point of the ratio of derivatives in \(c\) and a separate turning-point argument in \(a\).

# 1. Model and phase theorem

Let \(\phi,\Phi\) be the standard normal density and distribution function. Put
\[
 q(c)=\Phi(-c),\qquad L(c)=-\log q(c),\qquad M(c)=\frac{\phi(c)}{q(c)} .
\]
For jointly standard normal \(X,Y\) with correlation \(a\in(0,1)\), write \(P(c,a)=\Pr(X\ge c,Y\ge c)\) and \(D(c,a)=P(c,a)-q(c)^{2-a}\). By symmetry the equivalent joint event is \(X,Y\le-c\). Extend \(P\) to \(a=0\) and \(a=1\) by independence and equality of the two coordinates, respectively.

**Theorem 1.** For every \(0<a<1\) there is a unique real \(c_a\) such that \(D(c_a,a)=0\), and
\[
 D(c,a)<0\quad(c<c_a),\qquad D(c,a)>0\quad(c>c_a).
\]
The function \(a\mapsto c_a\) is smooth and strictly increasing. Let \(c_*\) be the unique positive solution of \(M(c_*)^2=L(c_*)\). Then \(0<c_*<1/2\) and \(c_a>c_*\) for all \(0<a<1\). Thus the inequality \(P(c,a)\le q(c)^{2-a}\) holds for every \(a\in[0,1]\) exactly when \(c\le c_*\). It is strict at every interior correlation for such \(c\).

Let \(H(c)=M(c)^2-L(c)\) and \(L_*=L(c_*)\). The endpoint expansions are
\[
 c_a=c_*+\frac{L_*(L_*-c_*^2)}{2H'(c_*)}a+O(a^2),
 \qquad a\downarrow0,
 \tag{1}
\]
and, putting \(b=\sqrt{(1-a)/(1+a)}\),
\[
 c_a=\frac{d_*}{b}-\frac{2b\log(1/b)}{J'(d_*)}+O(b),
 \qquad a\uparrow1, \qquad J(d)=\log(2q(d))+d^2,
 \tag{2}
\]
where \(d_*>0\) is the unique positive solution of \(J(d_*)=0\). In particular \(\sqrt{1-a}\,c_a\to\sqrt{2}\,d_*\).

# 2. A unique threshold at fixed correlation

Fix \(a\in(0,1)\) and set \(k=2-a\), \(b=\sqrt{(1-a)/(1+a)}\). The normal conditional distribution yields
\[
 \partial_c P(c,a)=-2\phi(c)q(bc),\qquad
 P(c,a)=2\int_c^\infty \phi(t)q(bt)\,dt.                                 \tag{3}
\]
For the derivative, the event boundary has two terms, each the marginal density at \(c\) times the conditional probability for the other coordinate. That probability is \(q(bc)\). Integration from infinity gives the second identity. The ratio of derivatives of \(P(c,a)\) and \(q(c)^k\) is therefore
\[
 h_a(c)=\frac{2q(bc)}{kq(c)^{1-a}} .
\]
As \(c\) tends to minus infinity, \(h_a(c)\) tends to \(2/k>1\). As \(c\) tends to plus infinity, it tends to infinity, since the leading quadratic term in its logarithm is \(\bigl(1-a-b^2\bigr)c^2/2>0\) by the normal tail asymptotic. Its logarithmic derivative is
\[
 (\log h_a)'(c)=(1-a)M(c)-bM(bc).                                         \tag{4}
\]

The hazard representation
\[
 \frac{q(c)}{\phi(c)}=\int_0^\infty e^{-ct-t^2/2}\,dt,\qquad
 M(c)-c=
 \frac{\int_0^\infty t e^{-ct-t^2/2}\,dt}
      {\int_0^\infty e^{-ct-t^2/2}\,dt}
 \tag{5}
\]
holds by translation and integration by parts. Thus \(M>0\), \(M-c>0\) and \(M'=M(M-c)>0\). For \(c\le0\), \(bc\ge c\) and \(b>1-a\), so (4) is strictly negative.

For \(c>0\) let \(\theta(c)=c(M(c)-c)\). By rescaling \(t\) in (5), it is the mean of a positive variable with density proportional to \(\exp(-u-u^2/(2c^2))\) on \([0,\infty)\). This mean strictly increases in \(c\). For example, differentiating at fixed positive \(c\) gives \(c^{-3}\) times the covariance of \(u\) and \(u^2\), strictly positive by independent replication and multiplication of their differences. The derivative of \(\log(M(bc)/M(c))\) is
\[
 \frac{\theta(bc)-\theta(c)}{c}<0 .
\]
The ratio \(M(bc)/M(c)\) falls from \(1\) to \(b\), since \(M(c)\sim c\) as \(c\) tends to infinity. The number \((1-a)/b=\sqrt{1-a^2}\) lies strictly between \(b\) and \(1\). It follows from (4) that \(h_a\) decreases to a unique minimum and then increases.

Both \(P(c,a)\) and \(q(c)^k\) tend to \(1\) at minus infinity and to \(0\) at plus infinity. The derivative of their difference is \(-k\phi(c)q(c)^{k-1}(h_a(c)-1)\). If \(h_a\) stayed at least \(1\), the difference would be nonincreasing and strictly decreasing on a tail, incompatible with these equal limits. Thus \(h_a\) crosses \(1\) twice. The difference \(D\) then decreases from zero, strictly increases between the crossings, and strictly decreases to zero. It is negative at the first turning point and positive at the second. It has precisely one zero \(c_a\), with \(\partial_c D(c_a,a)>0\). This proves the fixed-correlation sign assertion. Smoothness follows from (3) and the implicit function theorem.

# 3. The direction of the phase curve

## The normal hazard endpoint

We use the normal-hazard argument from the pinned Poisson manuscript and record it here for completeness. From \(M'=M(M-c)\),
\[
 H'(c)=M(c)\bigl(2M(c)(M(c)-c)-1\bigr).
\]
The bracket is positive at zero, where it equals \(4/\pi-1\). At any positive zero of the bracket, \(M'=1/2\), so its derivative is \(-c<0\). Integration by parts twice in the normal tail gives \(M(c)=c+1/c+O(c^{-3})\), so the bracket tends to \(1\) at infinity. Since every positive zero would be a strict downward crossing, the bracket stays positive on \([0,\infty)\). Thus \(H\) is strictly increasing there. Also \(H(0)=2/\pi-\log 2<0\). The latter follows from \(\pi>3\) and the expansion \(\log 2=2\sum_{j\ge0}3^{-(2j+1)}/(2j+1)>2/3\).

We have \(H(1/2)>0\). In fact \(\phi(0)>199/500\) follows from \(\pi<22/7\). For \(\phi(1/2)\), multiply this lower bound by \(1-1/8+1/128-1/3072\) to get \(\phi(1/2)>7/20\). Also
\[
 q(1/2)\le\tfrac12-\phi(0)\int_0^{1/2}(1-t^2/2)\,dt<31/100.
\]
For fixed \(\phi\ge7/20\) the expression \(\phi^2/q^2+\log q\) is decreasing in \(q\) over \(0<q\le31/100\). Hence
\[
 H(1/2)>\left(\frac{35}{31}\right)^2+\log(31/100)>0.
\]
The last inequality follows from \((35/31)^2>6/5\) and \(e^{6/5}>100/31\), using the positive Taylor terms through degree four. This proves \(0<c_*<1/2\) and \(H'(c_*)>0\).

## Signs as the correlation varies

Differentiating (3) in \(a\), using \(b'=-b/(1-a^2)\) and integrating \(t\phi(t)\phi(bt)\), gives
\[
 \partial_a P(c,a)=\frac{\exp(-c^2/(1+a))}{2\pi\sqrt{1-a^2}}.              \tag{6}
\]
Normalize \(D\) by \(q(c)^2\) and write it as \(R(a)=P(c,a)/q(c)^2-e^{L(c)a}\) at fixed \(c\). It is zero at both endpoints. The sign of \(R'(a)\) is the sign of
\[
 g(a)=\log\frac{M(c)^2}{L(c)}
       -\frac12\log(1-a^2)+\frac{c^2a}{1+a}-L(c)a,                        \tag{7}
\]
which is the logarithm of the ratio of the two positive derivatives. In particular \(g(a)\) tends to plus infinity as \(a\) increases to one, and
\[
 g''(a)=\frac{1+a^2}{(1-a^2)^2}-\frac{2c^2}{(1+a)^3}.
 \tag{8}
\]

For \(0\le c\le c_*\), \(g(0)\le0\) and \(g''(a)\ge1-2c_*^2>0\). When \(c=c_*\), where \(g(0)=0\), its initial derivative is \(c_*^2-L_*<0\), since \(L_*\ge\log 2\). Thus there is one interior crossing of \(g\) from negative to positive. The function \(R\) first decreases and then increases to zero, so it is strictly negative in the interior. The fixed-correlation ordering in \(c\) extends this conclusion to all \(c<0\), and gives \(c_a>c_*\).

When \(c>c_*\), \(g(0)>0\). Its second derivative (8) is strictly increasing in \(a\), and \(g'(a)\) tends to infinity. Accordingly \(g\) can have an initial increasing segment, a decreasing segment, and a final increasing segment, with either early segment empty. Since \(R(0)=R(1)=0\) and \(R'\) is positive near both endpoints, \(g\) must be negative somewhere in between. Thus \(g\) has exactly two interior zeros, with signs positive, negative, positive in the three intervals. The function \(R\) increases from zero, then decreases, then increases to zero. It has exactly one interior zero, on its decreasing segment. If \(a_2>a_1\) and \(c=c_{a_1}\), this shows \(D(c,a_2)<0\). The fixed-correlation sign theorem gives \(c_{a_2}>c_{a_1}\). This proves the claimed strict increase.

# 4. The two endpoint expansions

For \(a\) near zero, (6) gives, uniformly for \(c\) near \(c_*\),
\[
 \frac{D(c,a)}{a q(c)^2}
  =H(c)+\frac{M(c)^2c^2-L(c)^2}{2}a+O(a^2).
\]
The quotient has a smooth extension at zero. Its \(c\)-derivative there at \(c_*\) is \(H'(c_*)>0\). The local root from the implicit function theorem is \(c_a\) for positive \(a\) by uniqueness. Its expansion is (1), with a strictly positive linear coefficient.

For \(a\) increasing to one, set \(c=d/b\) with \(d>0\), and keep \(d\) in a fixed compact subinterval of \((0,\infty)\). From (3),
\[
 \frac{P(c,a)}{q(c)}=2\,\mathbb E q(b(c+T_c)),
\]
where \(T_c\) is the positive overshoot of a standard normal conditioned to exceed \(c\), with mean \(M(c)-c=1/c+O(c^{-3})\). The bounded derivative of \(q\) gives \(P(c,a)/q(c)=2q(d)+O(b^2)\) uniformly on such compact intervals. The tail expansion
\(L(c)=c^2/2+\log c+\frac12\log(2\pi)+O(c^{-2})\) and the relation \(1-a=2b^2/(1+b^2)\) give
\[
 \log\frac{P(d/b,a)}{q(d/b)^{2-a}}
      =J(d)+2b^2\log(1/b)+O(b^2).                                        \tag{9}
\]

Here \(J(0)=0\), \(J'(0)<0\), and \(J(d)\) tends to infinity by the same tail expansion. The derivative \(J'(d)=d-(M(d)-d)\) is strictly increasing: differentiating the mean in (5) gives the negative variance of \(t\) under its density there. Thus \(d_*>0\) exists, is unique, and \(J'(d_*)>0\). Bracketing by fixed positive values of \(d\) on either side of \(d_*\) in (9), and using the sign theorem, shows \(b c_a\to d_*\). Putting \(d=b c_a\) into (9) and using that its left side is zero gives
\[
 b c_a-d_*=-\frac{2b^2\log(1/b)}{J'(d_*)}+O(b^2).
\]
Indeed the derivative stays bounded away from zero near \(d_*\), first giving \(b c_a-d_*=O(b^2\log(1/b))\); the quadratic Taylor remainder is then \(o(b^2)\). Dividing by \(b\) gives (2). A rational endpoint certificate in the companion script places \(c_*\) in \((0.2057,0.2059)\) and \(d_*\) in \((1.2395,1.2396)\). These brackets are supplementary to the analytic proof.

# 5. Relation to the Poisson problem

The pinned Poisson result treats the inequality simultaneously in the overlap parameter and obtains \(c_*\) as its leading normal-scale intensity boundary. The present result gives a separate threshold at every fixed Gaussian correlation, proves that the thresholds form an ordered curve, and computes both endpoint expansions.

For a direct fixed-correlation connection, let \(a\in(0,1)\) and \(c\) be fixed, set \(r=m+c\sqrt m\), and form the Poisson pair \((Z+U,Z+V)\) with independent components of means \(ar,(1-a)r,(1-a)r\). The pair, centered at \(r\) and divided by \(\sqrt r\), converges to standard normals with correlation \(a\), by the independent Poisson normal limits. The standardized cutoff \(m\) tends to \(-c\). Thus the difference between the joint Poisson lower-tail probability and the marginal lower tail to the power \(2-a\) tends to \(D(c,a)\). For \(c\ne c_a\) the sign for large \(m\) is the Gaussian sign. The statements on the exact phase curve concern Gaussian thresholds.
