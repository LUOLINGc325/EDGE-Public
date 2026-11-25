# Sharp intensity boundaries for Poisson threshold noise stability

**AI-assisted research manuscript — 2026-11-25.** This manuscript has not undergone external peer review. Full Lean formalization is not yet complete.

## Abstract

Let two Poisson counts of mean $r$ share a Poisson component of mean $ar$, and let $q_m(r)$ be the probability that one count is at most $m$. We characterize all intensities for which the joint lower-tail probability is at most $q_m(r)^{2-a}$ simultaneously for every $a\in[0,1]$. For each integer $m\ge1$, this holds exactly when the derivative test at $a=0$ holds, and exactly on an interval $(0,R_m]$. The critical intensity is the unique positive zero of an explicit scalar function, satisfies $R_m>m+1$, and has the asymptotic $R_m=m+c_*\sqrt m+o(\sqrt m)$, where $c_*$ is characterized by a normal-hazard equation. The proof combines a reusable, sharp criterion for nonnegative spectral sequences, scalar level-crossing arguments, classical Ramanujan and factorial bounds, and two explicit rational Bernstein certificates. The theorem includes the parameter window of the analytic overlap inequality in Appendix D of [HMR]. Its application here is restricted to that verified inequality.

## 1. Motivation, related work, and source boundaries

The author manuscript [HMR, v1, Appendix D, pp. 55–56] isolates a joint Poisson lower-tail inequality needed in an information-theoretic analysis of threshold group testing. Its analytic argument covers threshold two; the appendix reports numerical exploration at higher thresholds and intensities in the window $[t-1,t]$. The present question asks for the full intensity domain of that inequality, including necessity, the unique boundary of validity, and its large-threshold location.

The verified source for this application is the v1 author manuscript, read through its full-text author mirror. Metadata for [HMR, v3] is available, but that version's complete text was not obtained in this investigation. The literature comparison therefore concerns the versions and results explicitly identified here; it is not a claim of exhaustive worldwide priority. In particular, [CO] already obtains the same leading testing benchmark unconditionally by a spatially coupled algorithm. This manuscript makes no claim to first algorithmic attainment of that benchmark or to capacity for arbitrary testing designs. The later comparison in [TMS, §1.2] also distinguishes the conditional constant-column analysis from the spatially coupled result.

Restricted Poisson hypercontractivity is an essential nearby baseline. [NPY, Theorem 1.4] gives, for nonnegative decreasing functionals,
$$
\|P_s f\|_{1+(p-1)e^s}\le\|f\|_p.
$$
For a threshold indicator, reversibility and a symmetric semigroup split with $a=e^{-2s}$ give the bound
$$
p_m(r,a)\le q_m(r)^{\,2/(1+\sqrt a)}.
$$
For $0<a<1$, its exponent is strictly smaller than $2-a$, so this direct consequence does not supply the sharp bound studied below. Our proof establishes a threshold-specific intensity classification rather than an arbitrary-event hypercontractive inequality.

The nonnegative expansion and the exponential Hermite remainder used below are standard mechanisms. The contribution asserted by this manuscript is the stated local-to-global threshold theorem and the complete argument connecting those mechanisms with its scalar phase boundary. All bibliographic and application claims are confined to the checked source scope.

## 2. Definitions and main theorem

For an integer $m\ge0$ and $r>0$, define
$$
E_m(r)=\sum_{j=0}^m\frac{r^j}{j!},\qquad
q_m(r)=e^{-r}E_m(r),\qquad
u_m(r)=e^{-r}\frac{r^m}{m!},\qquad
h_m(r)=\frac{u_m(r)}{q_m(r)}.
\tag{2.1}
$$
For $a\in[0,1]$, let $Z,X,Y$ be independent Poisson variables with means $ar,(1-a)r,(1-a)r$, respectively, and set
$$
p_m(r,a)=\Pr(Z+X\le m,\ Z+Y\le m).
\tag{2.2}
$$
We suppress subscripts when parameters are fixed, and consistently use
$$
L=-\log q,\qquad A=rh^2,\qquad
B=\frac12(m-r)^2h^2,\qquad
K(L)=e^L(3-L)-3-2L.
\tag{2.3}
$$
Thus $L>0$. Conditioning on $Z$ gives
$$
p_m(r,a)=e^{-(2-a)r}\sum_{b=0}^m\frac{(ar)^b}{b!}
 E_{m-b}((1-a)r)^2,
\quad p_m(r,0)=q^2,\quad p_m(r,1)=q.
\tag{2.4}
$$

**Theorem 2.1.** For every integer $m\ge1$, there is exactly one positive zero $R_m$ of
$$
F_m(r)=r h_m(r)^2+\log q_m(r)=A-L.
\tag{2.5}
$$
For every $r>0$, the following statements are equivalent:

1. $p_m(r,a)\le q_m(r)^{2-a}$ for every $a\in[0,1]$.
2. $F_m(r)\le0$, equivalently $A\le L$.
3. $0<r\le R_m$.

If these conditions hold, the inequality in statement 1 is strict for every $0<a<1$. If $r>R_m$, it fails for every sufficiently small positive $a$. Moreover,
$$
R_m>m+1,
\tag{2.6}
$$
and, as $m\to\infty$,
$$
R_m=m+c_*\sqrt m+o(\sqrt m),
\qquad
\left(\frac{\phi(c_*)}{\Phi(-c_*)}\right)^2=-\log\Phi(-c_*).
\tag{2.7}
$$
Here $\phi,\Phi$ are the standard normal density and distribution function, and $c_*$ is the unique positive solution of this equation. The value $c_*\approx0.2057916880$ is numerical orientation only and is not evidence used in the proof. For $m\ge17$, the argument also gives
$$
R_m<m+1+\frac13\sqrt{m+1}.
\tag{2.8}
$$

The exception $m=0$ is exact and elementary: $q_0(r)=e^{-r}$ and $p_0(r,a)=e^{-(2-a)r}$, so equality holds for every $r>0$ and $a\in[0,1]$. There is no unique critical intensity in that case.

## 3. A nonnegative spectrum and a sharp sequence-class criterion

### 3.1. The Poisson expansion

For an integer $j$, let $q_j=\Pr(\operatorname{Poi}(r)\le j)$ if $j\ge0$, and $q_j=0$ otherwise. Put
$$
d_k=\sum_{j=0}^k(-1)^{k-j}\binom{k}{j}q_{m-j}.
$$
Then
$$
p_m(r,a)=\sum_{k=0}^\infty c_k a^k,
\qquad c_k=\frac{r^k}{k!}d_k^2\ge0.
\tag{3.1}
$$
This identity holds for the entire extension in $a$ supplied by (2.4). To verify it directly, the joint probability-generating function is
$$
G_a(x,y)=\exp\{r(x-1)+r(y-1)+ar(x-1)(y-1)\}.
$$
Summing its coefficients with $0\le i,j\le m$ gives $p_m(r,a)$. Differentiating $k$ times at $a=0$ and extracting these finitely many coefficients yields
$$
p_m^{(k)}(r,0)=r^k
 \left(\sum_{i=0}^m[x^i](x-1)^k e^{r(x-1)}\right)^2=r^k d_k^2.
$$
Equation (2.4) is an exponential times a polynomial, so the Taylor series converges everywhere and all finite coefficient operations are justified. In particular,
$$
c_0=q^2,\qquad c_1=ru^2,\qquad c_2=\tfrac12(m-r)^2u^2,
\qquad \sum_{k\ge0}c_k=q.
\tag{3.2}
$$
Indeed $d_1=-u$, while $d_2=u(1-m/r)$. Therefore $c_1/q^2=A$ and $c_2/q^2=B$.

### 3.2. The reusable extremal criterion

**Theorem 3.1.** Fix $L\ge0$, $A,B\ge0$, and $e^L\ge1+A+B$. Consider every nonnegative sequence $(s_k)_{k\ge0}$ satisfying
$$
s_0=1,\quad s_1=A,\quad s_2=B,\quad \sum_{k\ge0}s_k=e^L.
$$
The inequality $\sum_{k\ge0}s_k a^k\le e^{La}$ holds for every sequence in this nonempty class and every $a\in[0,1]$ if and only if
$$
A\le L,\qquad 2A+B\le e^L(3-L)-3,
\tag{3.3}
$$
or equivalently $A\le L$ and $2(L-A)+K(L)-B\ge0$.

**Proof.** Nonnegativity and $a^k\le a^3$ for $k\ge3$ give the exact pointwise extremal polynomial
$$
\sum_{k\ge0}s_k a^k\le
P(a):=1+Aa+Ba^2+(e^L-1-A-B)a^3.
\tag{3.4}
$$
Equality is attained throughout by the admissible sequence placing all remaining mass at index 3. If every sequence obeys the exponential bound, this polynomial does. The right derivative at 0 gives $A\le L$. Since $P(1)=e^L$ and $P(a)-e^{La}\le0$ on the left of 1, its left derivative at 1 is nonnegative. Thus
$$
P'(1)=3e^L-3-2A-B\ge Le^L,
$$
which is the second condition in (3.3).

For sufficiency, the cubic Hermite interpolant to $e^{La}$, matching value and derivative at 0 and 1, is
$$
H_L(a)=1+La+K(L)a^2+J(L)a^3,
\qquad J(L)=e^L(L-2)+L+2.
\tag{3.5}
$$
For $0<a<1$, the interpolation remainder is
$$
e^{La}-H_L(a)=\frac{L^4e^{L\xi}}{24}a^2(a-1)^2\ge0
$$
for some $\xi\in(0,1)$; endpoint equality and the case $L=0$ are immediate. The formula follows also by applying Rolle's theorem four times to the interpolation error after subtracting a suitable multiple of $a^2(a-1)^2$. Finally,
$$
H_L(a)-P(a)
=a(1-a)\bigl[(L-A)+(L-A+K(L)-B)a\bigr].
\tag{3.6}
$$
The bracket is affine, with endpoint values $L-A$ and $2(L-A)+K(L)-B$. Both are nonnegative by (3.3). Equations (3.4)–(3.6) prove sufficiency. $\square$

The hypotheses guarantee that the sequence class is nonempty. The necessity in Theorem 3.1 concerns this **whole class**, including its cubic extremizer. It does not assert that the second inequality in (3.3) is necessary for an individual Poisson spectrum. We use that inequality as a sufficient certificate for the Poisson problem. The first inequality is necessary for the Poisson problem itself, because its right derivative at $a=0$ is $A$ after normalization by $q^2$.

## 4. Existence and uniqueness of the scalar critical intensity

Fix $m$, and suppress its subscript. Let $J_r$ have the truncated Poisson
law

$$
\Pr(J_r=j)=\frac{r^j}{j!E_m(r)},\qquad 0\leq j\leq m.
$$

Its mean and mean deficit are

$$
z(r)=\mathbb E J_r=r(1-h(r)),\qquad
\delta(r)=m-z(r)=m-r(1-h(r)).
$$

Both endpoints of the support have positive probability. Consequently
$0<z<m$, $0<\delta<m$, and

$$
z'(r)=\frac{\operatorname{Var}(J_r)}r>0.
\tag{4.1}
$$

Thus $\delta$ is strictly decreasing. The finite-sum formula gives
$\delta(r)\to m$ as $r\downarrow0$ and $\delta(r)\to0$ as
$r\to\infty$. Direct differentiation gives

$$
(\log q)'=-h,\qquad
h'=\frac{h\delta}{r},\qquad
\delta'=h(\delta+1)-1.
\tag{4.2}
$$

Define

$$
G(r)=(1+2\delta(r))h(r)-1.
$$

Then

$$
F'(r)=h(r)G(r).
\tag{4.3}
$$

We prove that $G$ has exactly one zero, crossing from negative to positive.
At any zero of $G$,

$$
h=\frac1{1+2\delta},\qquad
r=\frac{(m-\delta)(1+2\delta)}{2\delta},
$$

and substitution into the derivative of $G$ gives

$$
G'=\frac{2\delta(2\delta^2+2\delta-m)}
          {(m-\delta)(1+2\delta)^2}.
\tag{4.4}
$$

Let

$$
d_* = \frac{\sqrt{1+2m}-1}{2}\in(0,m).
$$

By strict monotonicity and the limits of $\delta$, there is a unique
$r_*>0$ with $\delta(r_*)=d_*$. Equation (4.4) says that every zero
of $G$ in $(0,r_*)$ has positive derivative, and every zero in
$(r_*,\infty)$ has negative derivative.

The finite-sum expressions also give

$$
G(r)\longrightarrow-1\quad(r\downarrow0),
$$

and, for fixed $m$,

$$
h(r)=1-\frac mr+\frac m{r^2}+O(r^{-3}),\quad
\delta(r)=\frac mr+O(r^{-2}),\quad
G(r)=\frac mr+O(r^{-2}).
\tag{4.5}
$$

In particular $G$ is eventually positive. There can be no zero in
$(r_*,\infty)$: such a zero would cross downwards, and the first subsequent
return from negative values to zero would have nonnegative derivative,
contradicting (4.4). Hence $G>0$ on $(r_*,\infty)$.

We must also exclude the possible tangency $G(r_*)=0$; a sign-of-derivative
argument alone would not exclude it. For $0<d<m$, set

$$
t=\frac{1+g}{1+2d},\qquad
\Psi(d,g)=\frac{(1+g)d(1-t)}{m-d}
               +2t\bigl(t(d+1)-1\bigr).
$$

Near a point where $G=0$, (4.2) and
$r=(m-\delta)/(1-h)$ show that

$$
G'=\Psi(\delta,G).
$$

At $g=0$,

$$
\Psi(d,0)=\frac{2d(2d^2+2d-m)}{(m-d)(1+2d)^2}.
$$

At $d=d_*$ this vanishes, and its derivative with respect to $d$ is
strictly positive: the derivative of the vanishing numerator factor is
$4d_*+2>0$, and every other factor is positive. If $G(r_*)=0$, then
$G'(r_*)=0$ and

$$
G''(r_*)=\Psi_d(d_*,0)\delta'(r_*)<0,
$$

because $\delta'=-d_* /(1+2d_*)<0$ there. This would make $r_*$ a
strict local maximum of value zero, forcing negative values immediately to
its right, a contradiction. Therefore $G(r_*)>0$.

There is now at least one zero in $(0,r_*)$, since $G$ is negative near
zero. There is at most one: all zeros in this interval cross strictly upwards,
whereas two such zeros would require an intervening return from positive to
negative values. This proves the asserted unique crossing, at a point denoted
$s_m$.

By (4.3), $F$ decreases strictly on $(0,s_m)$ and increases strictly on
$(s_m,\infty)$. Its continuous extension has $F(0)=0$. Finally, (4.5)
and the leading term of $E_m$ give

$$
F(r)=m\log r-\log(m!)-2m+O(r^{-1})\longrightarrow+\infty.
\tag{4.6}
$$

Thus $F$ has exactly one positive zero $R_m>s_m$, and has the signs
claimed in Theorem 2.1.

## 5. Strict inclusion of the application window

Write $n=m+1\geq2$, and in this section set

$$
u=e^{-n}\frac{n^n}{n!}
  =e^{-n}\frac{n^{n-1}}{(n-1)!},\qquad
q=e^{-n}\sum_{j=0}^{n-1}\frac{n^j}{j!}.
$$

The Ramanujan number

$$
\theta_n=\left(\frac{e^n}{2}-\sum_{j=0}^{n-1}\frac{n^j}{j!}\right)
             \frac{n!}{n^n}
$$

satisfies $q=1/2-\theta_n u$, and the classical bound gives

$$
\frac13\leq\theta_n\leq T_n:=\frac13+\frac4{135n}.
\tag{5.1}
$$

For example, (5.1) follows directly from [BRS, p. 1, (1.3), and p. 2, (2.2)].
Robbins's inequalities [R] give

$$
\frac{e^{-1/(12n)}}{\sqrt{2\pi n}}
 < u <
\frac{e^{-1/(12n+1)}}{\sqrt{2\pi n}}.
\tag{5.2}
$$

Set $x=n^{-1/2}$, so $0<x\leq1/\sqrt2<71/100$. We claim the convenient
polynomial upper bound

$$
u<x k(x),\qquad k(x)=\frac25\left(1-\frac{x^2}{13}\right).
\tag{5.3}
$$

Indeed $(2\pi)^{-1/2}<2/5$. For $z=x^2\leq1/2$ and
$y=z/(12+z)$,

$$
e^{-y}\leq1-y+\frac{y^2}{2}\leq1-\frac z{13}.
$$

The last inequality is equivalent, after division by $z>0$, to
$12-\tfrac{35}{2}z-z^2\geq0$, whose minimum on $[0,1/2]$ is 3.
This proves (5.3) from the upper bound in (5.2).

We next justify that replacing $\theta_n$ and $u$ by these upper bounds
has the required direction; the logarithm term by itself has the opposite
monotonicity. Define

$$
f_n(v,t)=\frac{n v^2}{(1/2-tv)^2}+\log(1/2-tv),\quad Q=1/2-tv.
$$

Its partial derivatives are

$$
\frac{\partial f_n}{\partial t}
  =\frac{v(2n v^2-Q^2)}{Q^3},\qquad
\frac{\partial f_n}{\partial v}
  =\frac{n v-tQ^2}{Q^3}.
\tag{5.4}
$$

The lower bound in (5.2), $\pi<22/7$, and $e^{-a}>1-a$ imply

$$
2n u^2>\frac1\pi e^{-1/(6n)}>
\frac7{22}\frac{11}{12}=\frac7{24}>\frac14.
\tag{5.5}
$$

Also $nu>1/2$, since $(nu)^2>7n/48\geq7/24>1/4$.
For $u\leq v\leq xk(x)$ and
$\theta_n\leq t\leq T_n<1/2$, we have $v<2/5$, hence
$0<Q\leq1/2$. Thus both derivatives in (5.4) are positive throughout
this rectangle. Consequently

$$
F_{n-1}(n)=f_n(u,\theta_n)
 < f_n(xk(x),T_n)
 =\frac{k(x)^2}{Q(x)^2}+\log Q(x),
\tag{5.6}
$$

where

$$
t(x)=\frac13+\frac{4x^2}{135},\quad
w(x)=x t(x)k(x),\quad Q(x)=\frac12-w(x).
$$

For $0\leq x\leq71/100$, $0\leq w(x)<1/2$. The logarithm series
and $\log2>693/1000$ give

$$
\log Q(x)
 \leq-\frac{693}{1000}-2w(x)-2w(x)^2-\frac83w(x)^3.
\tag{5.7}
$$

The bound for $\log2$ follows, for instance, by retaining the first four
positive terms of
$\log2=2\sum_{j\geq0}((2j+1)3^{2j+1})^{-1}$.

Define the degree-25 polynomial with rational coefficients

$$
P(x)=\left(\frac{693}{1000}+2w(x)+2w(x)^2+\frac83w(x)^3\right)
           \left(\frac12-w(x)\right)^2-k(x)^2.
\tag{5.8}
$$

Here is an explicit positivity certificate. Write $P(x)=\sum_{j=0}^{25}a_jx^j$,
put $a=71/100$, and define

$$
b_i=\sum_{j=0}^i a_j a^j\frac{\binom ij}{\binom{25}j},\qquad0\leq i\leq25.
\tag{5.9}
$$

These are the coefficients in

$$
P(x)=\sum_{i=0}^{25}b_i\binom{25}i(x/a)^i(1-x/a)^{25-i}.
$$

One has $b_0=53/4000$. In order $i=0,\ldots,25$, the exact integers
$\lfloor1000b_i/b_0\rfloor$ are

$$
\begin{split}
&(1000,944,890,838,787,737,688,641,595,551,508,466,426,\\
&\qquad 387,349,313,278,244,212,181,152,123,96,71,46,23).
\end{split}
\tag{5.10}
$$

In fact every $b_i>(23/1000)b_0=1219/4000000$; these are finite rational
inequalities. The polynomial definitions and conversion formula are given in the manuscript. The full rational coefficient list and exact checker are not included in this edition.
No floating arithmetic or sampling is involved. Since Bernstein basis
polynomials are nonnegative and sum to one,

$$
P(x)>\frac{1219}{4000000}>0\qquad(0\leq x\leq71/100).
\tag{5.11}
$$

Equations (5.6)--(5.8) now imply

$$
F_{n-1}(n)<-\frac{P(x)}{Q(x)^2}<0.
$$

This proves $F_m(m+1)<0$, and uniqueness from Section 4 gives
$R_m>m+1$. The certificate also provides the deliberately conservative
uniform bound $F_m(m+1)<-1219/10^6$.

## 6. Propagation through the entire region $0<r\le m$

We prove the stronger estimate
$$
2A+B\le2L\qquad(0<r\le m).
\tag{6.1}
$$
The endpoint input from Section 5 and the sign classification in Section 4 is
$m h_m(m)^2<-\log q_m(m)$.

Put $d=m-r$. Direct differentiation gives
$$
q'=-u,\qquad L'=h,\qquad h'=\left(\frac dr+h\right)h.
\tag{6.2}
$$
Define
$$
f=L-\left(r+\frac{d^2}{4}\right)h^2,\qquad
C=1+\frac32d+\frac{d^3}{2r},\qquad
D=2r+\frac{d^2}{2},\qquad S=Ch+Dh^2.
$$
Exact differentiation gives
$$
f'=h(1-S),\qquad
\frac{S'}h=-\frac32+\frac dr+\frac{d^3(d-1)}{2r^2}+3Ch+2Dh^2.
\tag{6.3}
$$
At any point where $S=1$, substitute $Dh^2=1-Ch$ to obtain
$$
\frac{S'}h=\frac12+\frac dr+\frac{d^3(d-1)}{2r^2}+Ch>0.
\tag{6.4}
$$
For $d\ge1$, positivity is immediate. For $0\le d\le1$, use $r=m-d\ge1-d$:
$$
\frac dr-\frac{d^3(1-d)}{2r^2}
=\frac{d[2r-d^2(1-d)]}{2r^2}\ge0,
$$
because $2r-d^2(1-d)\ge(2-d^2)(1-d)\ge0$. This includes $m=1$.

As $r\downarrow0$, $h(r)\sim r^m/m!$, $f(r)\to0$, and $S(r)\to1/2$ for $m=1$, while $S(r)\to0$ for $m\ge2$. Every crossing of the level $S=1$ is strictly upwards by (6.4), so there is at most one. To make the topological step explicit, two upward crossings would require an intermediate return from values above 1 to values below 1; at the first return point with value 1 the left derivative would be nonpositive, contradicting (6.4).

Thus $f$ first increases and then, if a crossing occurs, decreases. Its minimum on $[0,m]$, after defining $f(0)=0$, is attained at an endpoint. The other endpoint is
$$
f(m)=-\log q_m(m)-m h_m(m)^2>0.
$$
It follows that $f(r)>0$ for every $0<r\le m$, proving (6.1), in fact strictly.

For use in the cubic certificate, we also verify $q_m(r)>1/2$ throughout this region without an additional probabilistic input. Integration by parts gives
$$
q_m(r)=\frac1{m!}\int_r^\infty x^m e^{-x}\,dx.
$$
For $0<t<m$, the ratio of the integrand at $m+t$ to its value at $m-t$ is
$$
e^{-2t}\left(\frac{m+t}{m-t}\right)^m>1,
$$
since $\log((1+x)/(1-x))>2x$ for $0<x<1$. Pairing these points and keeping the positive tail above $2m$ proves $q_m(m)>1/2$. Monotonicity of $q_m$ gives the assertion for $r\le m$. Hence $0<L<\log2<1$.

Finally, $K(0)=K'(0)=0$ and $K''(L)=e^L(1-L)>0$ for $0<L<1$. Consequently $K(L)>0$, and (6.1) implies both conditions of (3.3), with the second strict:
$$
A\le L,\qquad 2A+B\le2L<e^L(3-L)-3.
\tag{6.5}
$$

## 7. Uniform scalar bounds to the right of the mode

We next prove, for every integer $m\ge1$,
$$
q_m(r)>\frac13\qquad(0<r\le R_m),
\tag{7.1}
$$
$$
0\le y_m(r):=\frac{r-m}{r h_m(r)}<\frac45
\qquad(m\le r\le R_m).
\tag{7.2}
$$
For $m\ge17$, our construction also proves
$$
R_m<m+1+\frac13\sqrt{m+1}.
\tag{7.3}
$$

### 7.1. Monotonicity and endpoint reduction

Set $T_m(r)=1/h_m(r)$. The finite Poisson sum gives

$$
T_m(r)=\sum_{j=0}^{m}\frac{(m)_j}{r^j},
\qquad (m)_j=\frac{m!}{(m-j)!}.
$$

The coefficients telescope in

$$
y_m(r):=\frac{r-m}{rh_m(r)}
 =\left(1-\frac mr\right)T_m(r)
 =1-\sum_{j=1}^m\frac{j(m)_j}{r^{j+1}}.
\tag{7.4}
$$

Consequently $y_m$ is strictly increasing on $(0,\infty)$. Also
$q_m'=-u_m<0$. It therefore suffices, for each $m$, to find a point
$b_m>R_m$ at which $q_m(b_m)>1/3$ and $y_m(b_m)<4/5$.

### 7.2. A uniform endpoint for $m\geq17$

Write $n=m+1\geq18$, $x=n^{-1/2}$, and

$$
r_0=n+\frac13\sqrt n,\qquad 0<x\leq\frac1{\sqrt{18}}<\frac6{25}.
$$

In this section let
$u(s)=u_{n-1}(s)$, $q(s)=q_{n-1}(s)$,
$u_0=u(n)$, and $u_1=u(r_0)$. The classical bounds used in
Section 5 give

$$
q(n)=\frac12-\theta_nu_0,\qquad
\frac13\leq\theta_n\leq\frac13+\frac{4x^2}{135},
\tag{7.5}
$$

$$
\frac{e^{-x^2/12}}{\sqrt{2\pi}}
  <\frac{u_0}{x}<\frac1{\sqrt{2\pi}}<\frac25.
\tag{7.6}
$$

These are the Ramanujan bound and Robbins factorial bounds, with primary references [BRS] and [R].

#### 7.2.1. Explicit lower bounds for the densities

Define the following polynomials with rational coefficients:

$$
a(x)=\frac{199}{500}\left(1-\frac{x^2}{12}\right),\qquad
v(x)=\frac1{18}+\frac x3,
$$

$$
b(x)=a(x)\left(1-v(x)+\frac{v(x)^2}{2}-\frac{v(x)^3}{6}\right).
\tag{7.7}
$$

Since $199/500<\sqrt{7/44}<(2\pi)^{-1/2}$, equation (7.6) and
$e^{-t}>1-t$ imply

$$
u_0>x a(x).
\tag{7.8}
$$

Furthermore,

$$
\begin{split}
\log\frac{u_1}{u_0}
 &=-\frac1{3x}+(x^{-2}-1)\log(1+x/3)\\
 &\geq-\frac1{18}-\frac x3+\frac{x^2}{18}
 \geq-v(x),
\end{split}
$$

where $\log(1+t)\geq t-t^2/2$ was used. The lower Taylor polynomial
$e^{-v}\geq1-v+v^2/2-v^3/6$ gives

$$
u_1>x b(x).
\tag{7.9}
$$

For every $0\leq x\leq6/25$, these elementary bounds will be useful:

$$
\frac{39}{100}<a(x)<\frac25,\qquad
\frac{17}{50}<b(x)\leq a(x)<\frac25.
\tag{7.10}
$$

For the lower bound on $b$, one can discard its positive quadratic-minus-
cubic contribution and use

$$
b(x)\geq a(x)(1-v(x))
 \geq \frac{24074821}{70312500}>\frac{17}{50}.
$$

The stated lower bound is the product evaluated at $x=6/25$; both
positive factors are decreasing. The inequality $b\leq a$ follows from
$1-v+v^2/2-v^3/6\leq1$.

#### 7.2.2. Lower and upper bounds on the tail

The density $u(s)$ decreases for $s\geq n$, since its mode is $n-1$.
Thus (7.5)--(7.6) imply

$$
\begin{split}
q(r_0)
 &=q(n)-\int_n^{r_0}u(s)\,ds\\
 &>\frac12-\frac25\left(\frac13+\frac x3+\frac{4x^3}{135}\right)\\
 &\geq\frac{783991}{2343750}>\frac13.
\end{split}
\tag{7.11}
$$

To obtain an upper bound, note that

$$
\frac{u''(s)}{u(s)}=
\frac{(s-(n-1))^2-(n-1)}{s^2}.
$$

The density is concave throughout $[n,r_0]$: indeed the required
inequality follows from
$(x+1/3)^2<1-x^2$ for $0\leq x\leq6/25$. Hence its integral is at
least its trapezoidal approximation. Using $\theta_n\geq1/3$ and
(7.8)--(7.9),

$$
q(r_0)
 \leq\frac12-\frac{u_0}{3}
              -\frac{\sqrt n}{6}(u_0+u_1)
 < Q(x),
\tag{7.12}
$$

where

$$
Q(x)=\frac12-\frac{x a(x)}{3}-\frac{a(x)+b(x)}6.
\tag{7.13}
$$

The bounds (7.10) give $1/3<Q(x)<2/5$ on the whole interval
$[0,6/25]$. For the lower inequality one may use

$$
Q(x)>\frac12-\frac{2x}{15}-\frac2{15}
 \geq\frac{251}{750}>\frac13.
$$

#### 7.2.3. The endpoint lies beyond the critical root

Put $C(x)=(1+x/3)b(x)^2$. By (7.9),

$$
F_{n-1}(r_0)
 >\frac{C(x)}{q(r_0)^2}+\log q(r_0).
$$

For $0<q\leq Q(x)<2/5$, the function $C(x)/q^2+\log q$ decreases:
its derivative is $(q^2-2C(x))/q^3<0$, since
$2C(x)>2(17/50)^2>(2/5)^2$. Therefore

$$
F_{n-1}(r_0)>
\frac{C(x)}{Q(x)^2}+\log Q(x).
\tag{7.14}
$$

Set $z(x)=3Q(x)-1$, so $0<z(x)<1/5$. The bounds
$\log3<11/10$ and
$\log(1+z)\geq z-z^2/2+z^3/3-z^4/4$ yield

$$
\log Q(x)>-\frac{11}{10}
            +z(x)-\frac{z(x)^2}{2}+\frac{z(x)^3}{3}-\frac{z(x)^4}{4}.
$$

The first numerical bound follows using only rational arithmetic from
$e^{11/10}>\sum_{j=0}^5(11/10)^j/j!=36015101/12000000>3$.

Consequently it suffices to prove positivity of the degree-30 polynomial

$$
P_+(x)=(1+x/3)b(x)^2
 +Q(x)^2\left[-\frac{11}{10}+z(x)-\frac{z(x)^2}{2}
                  +\frac{z(x)^3}{3}-\frac{z(x)^4}{4}\right].
\tag{7.15}
$$

Here is a finite exact certificate. Let $p_j$ be the power coefficients
of $P_+$, and put

$$
\beta_i=\sum_{j=0}^i p_j(6/25)^j
                 \frac{\binom ij}{\binom{30}j},\qquad0\leq i\leq30.
\tag{7.16}
$$

Every $\beta_i>1/400$. The exact integer floors
$\lfloor1000\beta_i/\beta_0\rfloor$, in order, are

$$
\begin{split}
&(1000,990,979,968,957,945,932,919,905,891,877,862,846,831,814,797,\\
&\qquad780,762,744,725,706,686,666,645,624,603,581,559,536,513,489).
\end{split}
\tag{7.17}
$$

The full rational coefficients and exact arithmetic checker are not included in this edition.
The Bernstein representation corresponding to (7.16) proves

$$
P_+(x)>\frac1{400}>0\qquad(0\leq x\leq6/25).
\tag{7.18}
$$

Equations (7.14)--(7.18) give $F_{n-1}(r_0)>0$. The unique-root theorem
therefore proves $R_{n-1}<r_0$, establishing (7.3).

#### 7.2.4. Bound on the ratio at this endpoint

By (7.9), (7.10), and $q(r_0)<1/2$,

$$
\begin{split}
y_{n-1}(r_0)
 &=\frac{x+1/3}{1+x/3}\frac{q(r_0)}{u_1/x}\\
 &<\frac{25}{17}\frac{x+1/3}{1+x/3}
 \leq\frac{1075}{1377}<\frac45.
\end{split}
\tag{7.19}
$$

The rational function of $x$ in the middle is increasing, so its maximum
is attained at $6/25$. Equations (7.11), (7.19), and the monotonicities
in Section 7.1 prove (7.1)--(7.2) for every $m\geq17$.

### 7.3. The sixteen remaining thresholds

The following are rational endpoints, chosen only to make the finite
verification simple:

| $m$ | endpoint $b_m$ | $m$ | endpoint $b_m$ |
|---:|---:|---:|---:|
| 1 | $11/5$ | 9 | $211/20$ |
| 2 | $13/4$ | 10 | $58/5$ |
| 3 | $43/10$ | 11 | $63/5$ |
| 4 | $107/20$ | 12 | $273/20$ |
| 5 | $32/5$ | 13 | $147/10$ |
| 6 | $149/20$ | 14 | $157/10$ |
| 7 | $17/2$ | 15 | $67/4$ |
| 8 | $19/2$ | 16 | $71/4$ |

At each of these endpoints the exact checker proves

$$
F_m(b_m)>\frac1{1000},\qquad
q_m(b_m)>\frac13,\qquad y_m(b_m)<\frac45.
\tag{7.20}
$$

To specify the certificate completely, define, for rational $0<t<102$,

$$
\mathcal E_{100}(t)=\sum_{j=0}^{100}\frac{t^j}{j!}
  +\frac{t^{101}}{101!}\frac1{1-t/102}.
$$

The positive exponential series has successive tail ratios at most
$t/102<1$, hence $e^t<\mathcal E_{100}(t)$. At an endpoint let

$$
S=\sum_{j=0}^m\frac{b_m^j}{j!},\quad
v=\frac{b_m^m}{m!},\quad A=b_m(v/S)^2.
$$

The finite checks are exactly the following rational inequalities:

$$
S>\mathcal E_{100}(b_m-A+1/1000),\quad
\mathcal E_{100}(b_m)<3S,\quad
\frac{(b_m-m)S}{b_m v}<\frac45.
\tag{7.21}
$$

Their exponential arguments are positive and below 102. The first inequality
implies $A-b_m+\log S>1/1000$, while the second implies
$e^{-b_m}S>1/3$. Thus (7.21) gives (7.20), without floating arithmetic,
numerical logarithms, or interval sampling. All 48 rational comparisons have
passed.

As in the large-threshold case, uniqueness of $R_m$ implies
$b_m>R_m$; monotonicity of $q_m$ and $y_m$ then proves
(7.1)--(7.2) for $m=1,\ldots,16$. The proposition is proved.

## 8. Completion of the sharp noise-stability theorem

An elementary inequality closes the right-region certificate. For $0\le L\le\log3$,
$$
e^L(3-L)-3-2L-\frac{L^2}{3}\ge\frac{13}{375}L^2.
\tag{8.1}
$$
Indeed $\log3<6/5$, since
$$
e^{6/5}\ge1+\frac65+\frac{18}{25}+\frac{36}{125}
=\frac{401}{125}>3.
$$
Multiplying the fourth-degree Taylor lower bound for $e^L$ by $3-L>0$ gives
$$
\begin{aligned}
e^L(3-L)-3-2L-\frac{L^2}{3}
&\ge\frac{L^2}{24}(4-L^2-L^3)\\
&\ge\frac{L^2}{24}\left(4-\frac{36}{25}-\frac{216}{125}\right)
=\frac{13}{375}L^2.
\end{aligned}
$$

Assume $F_m(r)\le0$, or equivalently $r\le R_m$ by Section 4. For $r\le m$, Section 6 proves the cubic certificate. For $m\le r\le R_m$, Section 7 gives $0<L<\log3$, $A\le L$, and
$$
B=\frac12y_m(r)^2A^2<\frac8{25}A^2
\le\frac8{25}L^2<\frac13L^2.
$$
Together with (8.1), this yields
$$
2A+B<2L+\frac13L^2<e^L(3-L)-3.
$$
Theorem 3.1 therefore proves $p_m(r,a)\le q_m(r)^{2-a}$ throughout $[0,1]$.

Conversely, that inequality and equality at $a=0$ force $A\le L$ by the right-derivative test in Section 3. This proves all three equivalences in Theorem 2.1. In both regions the second inequality of (3.3) is strict. The affine bracket in (3.6) is therefore nonnegative at 0 and strictly positive at 1, hence strictly positive on $(0,1)$. Thus $H_L(a)-P(a)>0$ for every interior $a$, proving the asserted strictness.

If $r>R_m$, the function $p_m(r,a)/q^2-e^{La}$ vanishes at 0 and has strictly positive derivative $A-L$ there. It is positive for every sufficiently small positive $a$. This proves sharp failure beyond the critical intensity. The window inclusion and explicit upper bound were established in Sections 5 and 7; it remains only to prove the asymptotic.

## 9. The normal-scale location of the boundary

Let $Q(c)=\Phi(-c)$, $\lambda(c)=\phi(c)/Q(c)$, and
$H(c)=\lambda(c)^2+\log Q(c)$. We first prove that $H$ has exactly one
positive zero; this is not inferred from the numerical decimal above.

The normal hazard satisfies

$$
\lambda'=\lambda(\lambda-c),\qquad
H'=\lambda\{2\lambda(\lambda-c)-1\}.
$$

Write $G_N(c)=2\lambda(c)(\lambda(c)-c)-1$. Then
$G_N(0)=4/\pi-1>0$. At any zero $c>0$,

$$
\lambda'=\frac12,\quad
(\lambda-c)'=-\frac12,\quad
G_N'=(\lambda-c)-\lambda=-c<0.
\tag{9.1}
$$

Integration by parts in the Gaussian tail gives, as $c\to\infty$,

$$
\frac{Q(c)}{\phi(c)}=\frac1c-\frac1{c^3}+O(c^{-5}),\quad
\lambda(c)=c+\frac1c+O(c^{-3}).
\tag{9.2}
$$

For completeness, the remainder after the two displayed terms of the first
expansion is $3\phi(c)^{-1}\int_c^\infty t^{-4}\phi(t)\,dt$, which lies
between 0 and $3c^{-5}$. Thus $G_N(c)\to1>0$. Since all possible zeros
in $(0,\infty)$ have negative derivative by (9.1), the same first-return
argument used in Section 4 excludes every such zero. Therefore $H'>0$ on
$[0,\infty)$.

Moreover,

$$
H(0)=\frac2\pi-\log2<0,
\qquad
H(c)=\frac{c^2}{2}-\log c+2-\frac12\log(2\pi)+O(c^{-2})\to\infty.
$$

The first inequality follows already from $\pi>25/8$ and
$\log2>693/1000$. Hence there is a unique positive zero $c_*$.

Now fix any real $c$, and take $r_m=m+c\sqrt m$, which is positive for
large enough $m$. The Poisson central limit theorem gives

$$
q_m(r_m)\longrightarrow\Phi(-c).
\tag{9.3}
$$

One elementary derivation uses the characteristic function of the standardized
Poisson variable, whose logarithm is
$r(e^{it/\sqrt r}-1-it/\sqrt r)\to-t^2/2$; the standardized cutoff
$(m-r_m)/\sqrt{r_m}$ tends to $-c$, a continuity point of the limiting
normal distribution. Stirling's formula gives the needed point-mass limit:

$$
\begin{split}
\log\bigl(\sqrt{r_m}u_m(r_m)\bigr)
 &=\frac12\log\frac{r_m}{m}-\frac12\log(2\pi)
   -(r_m-m)+m\log\frac{r_m}{m}+o(1)\\
 &\longrightarrow-\frac{c^2}{2}-\frac12\log(2\pi).
\end{split}
$$

Consequently

$$
F_m(m+c\sqrt m)\longrightarrow H(c).
\tag{9.4}
$$

For any $0<\varepsilon<c_*$, strict monotonicity of $H$ implies
$H(c_*-\varepsilon)<0<H(c_*+\varepsilon)$. By (9.4), these are also the
signs of the corresponding $F_m$ values for all sufficiently large $m$.
The unique-root property from Section 4 therefore yields

$$
m+(c_*-\varepsilon)\sqrt m<R_m<
m+(c_*+\varepsilon)\sqrt m.
$$

Letting $\varepsilon\downarrow0$ proves the asserted leading asymptotic.

## 10. Application and limits of the result

Cancelling the common exponential factor in (2.4), Theorem 2.1 gives
$$
\sum_{b=0}^m\frac{(ar)^b}{b!}E_{m-b}((1-a)r)^2
\le E_m(r)^{2-a}
\tag{10.1}
$$
for every integer $m\ge1$, every $r\in[m,m+1]$, and every $a\in[0,1]$. Setting $m=t-1$ covers precisely the intensity window $[t-1,t]$ of the explicit lower-tail overlap inequality in [HMR, Appendix D, pp. 55–56]. More generally, the theorem determines its full intensity domain rather than only that application window.

We do not identify (10.1) with the literal maximum-location wording of [HMR, v1, Conjecture 1.2]. The displayed first-moment expression in that version has endpoint behavior requiring separate attention. The present application claim concerns the verified explicit Appendix D inequality. Any broader transfer to recovery statements must check the remaining model assumptions and uniform overlap estimates in the source argument.

The theorem does not prove the corresponding bound for arbitrary Poisson events, identify an optimal group-testing algorithm, or establish arbitrary-design capacity. The spatially coupled algorithm in [CO] already attains the cited benchmark. Likewise, the necessary-and-sufficient statement for the entire nonnegative sequence class in Theorem 3.1 should not be read as necessity of its second scalar condition for an individual Poisson spectrum. The characterization of the individual Poisson spectrum is Theorem 2.1, whose condition is only $A\le L$.

Only the leading normal-scale asymptotic is established. No second-order constant is claimed. Numerical evaluations and exploratory searches are distinct from the exact certificates and are not logical inputs to the theorem.

## 11. Reproduction, arithmetic verification, and proof status

The written proof has three finite verification components: 26 Bernstein coefficient inequalities for the degree-25 polynomial in Section 5, 31 Bernstein coefficient inequalities for the degree-30 polynomial in Section 7, and the 48 rational endpoint comparisons for $m=1,\ldots,16$. Their polynomial definitions, conversion formulas, domains, and strict lower bounds are specified in this manuscript. The rational coefficients can be recomputed from the polynomial definitions and conversion formulas; the full coefficient tables are not included in this edition.

The scripts use `fractions.Fraction`, integer factorials and binomial coefficients, exact polynomial multiplication, and exact comparisons. They do not use floating arithmetic, numerical logarithms, random testing, or interval sampling. The second script imports its polynomial helpers from the first. The original manuscript reports that both checkers passed; the computation files and execution outputs are not included in this edition. These finite checks establish the claimed rational inequalities and depend on the analytic reductions in Sections 5 and 7 for their probabilistic meaning.

The only non-elementary finite-threshold inequalities imported into the proof are the Ramanujan-sequence estimate [BRS] and Robbins's factorial bounds [R]. Section 9 uses the standard normal limit, with a characteristic-function derivation and the explicit Gaussian-tail remainder included there. 

External peer review has not taken place. The exact arithmetic checkers are not a substitute for checking the analytic proof, and they are not a claim of full Lean formalization. Full formalization remains incomplete.

## 12. References

**[HMR]** Remco van der Hofstad, Noela Müller, Connor Riddlesden. *An Information-Theoretic Analysis of Threshold Group Testing*. arXiv:2606.11353. The checked full-text source is v1, 9 June 2026, especially Lemma 4.7, pp. 31–33, and Appendix D, pp. 55–56. Canonical record: https://arxiv.org/abs/2606.11353 . Author manuscript mirror read: https://www.researchgate.net/publication/406910283_An_Information-Theoretic_Analysis_of_Threshold_Group_Testing . The v3 record, https://arxiv.org/abs/2606.11353v3 , was checked at metadata level only; its complete text was not obtained.

**[CO]** Amin Coja-Oghlan, Remco van der Hofstad, Lena Krieg, Noela Müller, Connor Riddlesden, Olga Scheftelowitsch. *Algorithms for Threshold Group Testing*. arXiv:2606.27127, 2026. Theorem 1.1 and the accompanying comparison concern a spatially coupled design. https://arxiv.org/abs/2606.27127 . Checked author-text mirror: https://www.researchgate.net/publication/408106488_Algorithms_for_Threshold_Group_Testing .

**[TMS]** Trung-Khang Tran, Daniel McMorrow, Jonathan Scarlett. *Group Testing with Selectable Thresholds*. arXiv:2607.14448v1, 16 July 2026, especially §1.2. https://arxiv.org/abs/2607.14448 . Checked full-text rendering: https://academ.us/article/2607.14448/ .

**[NPY]** Ivan Nourdin, Giovanni Peccati, Xiaochuan Yang. *Restricted hypercontractivity on the Poisson space*. Proceedings of the American Mathematical Society 148(8) (2020), 3617–3632. Theorem 1.4, p. 4 of the checked author manuscript. https://doi.org/10.1090/proc/14964 ; https://arxiv.org/abs/1904.08211 ; https://arxiv.org/pdf/1904.08211 .

**[BRS]** Andrew Bakan, Stephan Ruscheweyh, Luis Salinas. *More Properties of the Ramanujan Sequence*. arXiv:1605.05479v3. Definition (1.1) and bound (1.3), p. 1; equation (2.2), p. 2, with proof in §4. These imply the bound $1/3\le\theta_n\le1/3+4/(135n)$ used here. https://arxiv.org/abs/1605.05479v3 ; https://arxiv.org/pdf/1605.05479v3 .

**[R]** Herbert Robbins. *A Remark on Stirling's Formula*. American Mathematical Monthly 62(1) (1955), 26–29, equations (1)–(2). Full-paper mirror checked: https://heuklyd.github.io/papers/pdf/Robbins-1955.pdf .
