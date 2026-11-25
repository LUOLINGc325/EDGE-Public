# Sharp simultaneous confidence widths for adaptive exponential-kernel regression

Research manuscript, 25 November 2026.

**Scope and verification.** This manuscript gives a written proof for the ordinary kernel-ridge predictor with the fixed one-dimensional kernel $k(s,t)=\exp(-|s-t|)$ on $[0,1]$. The regularization matrix is $K_n+\lambda^2I$, with $\lambda>0$ fixed before observing data. The upper bound covers every predictable design and conditionally sub-Gaussian noise. The matching lower bound concerns a deterministic scalar width with simultaneous spatial coverage, for this particular predictor and normalization. It is not a lower bound at one prespecified point or over all possible estimators. This manuscript does not claim Lean formalization or external peer review.

## Abstract

We prove that the simultaneous, posterior-normalized confidence width of ordinary kernel ridge regression with the one-dimensional exponential kernel is of order $B+(R/\lambda)\sqrt{\log(n/\delta)}$, for each fixed $\lambda>0$, where $B$ is the RKHS norm bound and $R$ is the conditional sub-Gaussian noise scale. The upper bound allows arbitrary predictable sampling, repeated locations, and endpoint observations and queries. It preserves the usual KRR center and posterior variance. A deterministic repeated-grid design supplies a matching Gaussian lower bound; a separate zero-noise construction supplies the bias term. The proof uses positivity, a single peak, and a total-influence bound for the posterior Green function. A lower envelope on a deterministic grid makes the random posterior weights compatible with a finite family of predictable interval martingales. We also give an abstract shape criterion, an all-time confidence sequence, and an explicit information-gain regret implication. The claimed rate comparison is for fixed regularization, not uniformly over all regularization regimes.

## 1. Model, question, and precise contributions

Let $(\mathcal F_i)_{i\ge0}$ be a filtration. Locations $X_i\in[0,1]$ are $\mathcal F_{i-1}$-measurable, and

$$Y_i=f(X_i)+\varepsilon_i,$$

where $f$ is a fixed, nonrandom member of the real RKHS $H$ of $k(s,t)=e^{-|s-t|}$ with $\|f\|_H\le B$. Independent randomization of the sampling policy can be included in the filtration. The noise is $\mathcal F_i$-measurable and satisfies, almost surely, for every real $a$,

$$\mathbb E[e^{a\varepsilon_i}\mid\mathcal F_{i-1}]\le e^{a^2R^2/2}. \tag{1}$$

Here $B,R\ge0$ and $\lambda>0$. When $R=0$, (1) forces $\varepsilon_i=0$ almost surely, and all noise terms below vanish. No independence of the final design and the observed noises is assumed.

For $n\ge1$, set

$$K_n=(k(X_i,X_j))_{i,j\le n},\quad k_n(x)=(k(X_i,x))_{i\le n},\quad A_n=K_n+\lambda^2I_n,$$

$$\mu_n(x)=k_n(x)^TA_n^{-1}Y_{1:n},\qquad
\sigma_n(x)^2=1-k_n(x)^TA_n^{-1}k_n(x). \tag{2}$$

Write $\mu_0=0$ and $\sigma_0=1$. We prove below that $\sigma_n(x)>0$ for every finite design and every $x$.

Define $\rho_n^*(\delta;B,R,\lambda)$ as the infimum of all deterministic numbers $r\ge0$ such that, for every model satisfying the preceding assumptions,

$$\mathbb P\left(\forall x\in[0,1]: |f(x)-\mu_n(x)|\le r\sigma_n(x)\right)\ge1-\delta. \tag{3}$$

The infimum is over scalar widths, with the center and normalization in (2) fixed. It is not an infimum over estimators. The quantifier over noise laws in (3) includes both independent $N(0,R^2)$ noise and identically zero noise.

### Main theorem

For $n\ge1$, $0<\delta<1$, define

$$M_n=\max\{1,\lceil2n^2/\lambda^2\rceil\},\quad J_n=\frac{M_n(M_n+1)}2,$$

$$u_n(\delta)=\log\frac{4J_nn}{\delta},\qquad v_n(\delta)=\log\frac{4n}{\delta},$$

$$b_n(\delta)=B+\frac R\lambda\left[\sqrt{2u_n(\delta)}+\sqrt{2v_n(\delta)}\right]. \tag{4}$$

**Theorem 1 (explicit upper bound and matching order).** Every model in (1)–(2) satisfies

$$\mathbb P\left(\forall x\in[0,1]:\frac{|f(x)-\mu_n(x)|}{\sigma_n(x)}\le b_n(\delta)\right)\ge1-\delta. \tag{5}$$

For $n\ge4$ and $0<\delta\le1/4$,

$$\rho_n^*(\delta;B,R,\lambda)\ge
\frac1{16(1+\lambda^2)}\left[B+\frac R\lambda\sqrt{\log(n/\delta)}\right]. \tag{6}$$

Consequently, for each fixed $\lambda>0$,

$$\rho_n^*(\delta;B,R,\lambda)\asymp_\lambda
B+\frac R\lambda\sqrt{\log(n/\delta)},\qquad n\ge4,\quad0<\delta\le1/4. \tag{7}$$

The comparison constants in (7) are independent of $B,R,n,\delta$ but may depend on $\lambda$. The lower bound in (6) already follows from deterministic designs. Thus the result does not identify an extra cost caused by adaptivity; it shows that arbitrary predictable sampling does not increase the simultaneous spatial rate beyond this order.

### Relation to the literature

Vakili, Scarlett and Javidi [V21] posed the online kernel confidence-width question. Lattimore [L23] proved a continuous-time lower bound using a different adaptive construction. Hu and Simchi-Levi [HS26] proved a discrete-time worst-kernel result for an additive linear-plus-periodic-Sobolev kernel, while leaving specific Matérn and squared-exponential kernels open. The present theorem addresses the fixed one-dimensional Matérn-$1/2$ case. It does not alter or contradict the worst-kernel lower bound.

Flynn and Reeb [FR25] develop tighter sequential confidence sets with improved realized widths and the same stated worst-case information-gain guarantee. Our contribution is a rate characterization for the fixed predictor (2) and a particular fixed kernel, together with a sufficient posterior-shape criterion. Classical OU precision formulas, positive Green functions, layer integration and martingale exponential bounds are credited background tools, not separate novelty claims. The comparison is limited to the literature discussed here; global priority is not asserted.

## 2. A reusable concentration theorem for posterior-shaped weights

The next result is independent of Gaussian processes. Its statistical event is defined before any response-dependent weight function is selected.

**Theorem 2 (shape-and-mass criterion).** Suppose $X_i$ are predictable and (1) holds. Fix $A,L\ge0$, an integer $p\ge1$, $\alpha\in(0,1]$, and an integer $M\ge1$. Partition $[0,1]$ into $M$ deterministic equal cells, left-closed and right-open except for the last cell, which includes $1$. Put $J=M(M+1)/2$, $u=\log(4Jn/\delta)$, and $v=\log(4n/\delta)$.

With probability at least $1-\delta$, the following holds simultaneously for every continuous function $g:[0,1]\to[0,\infty)$ satisfying these pathwise conditions:

1. Each strict superlevel set $\{t:g(t)>a\}$ is a union of at most $p$ intervals, where $p\ge1$ is an integer.
2. $(\sup_tg(t))\sum_{i=1}^ng(X_i)\le A^2$.
3. $|g(s)-g(t)|\le L|s-t|^\alpha$ for $\alpha\in(0,1]$.

Here $g$ may depend on all observations. The conclusion is

$$\left|\sum_{i=1}^ng(X_i)\varepsilon_i\right|
\le AR\sqrt{2pu}+nLM^{-\alpha}R\sqrt{2v}. \tag{8}$$

The same event works for all eligible functions, including an uncountable collection: it is a finite intersection of events about the fixed grid intervals and the individual noises.

### 2.1. Predictable interval counts

Let $I$ be a union of consecutive grid cells. There are exactly $J$ such nonempty intervals. Define

$$S_I=\sum_{i=1}^n\mathbf1_{\{X_i\in I\}}\varepsilon_i,\qquad N_I=\sum_{i=1}^n\mathbf1_{\{X_i\in I\}}.$$

Because the indicators are predictable, the conditional MGF assumption implies

$$\mathbb E\exp\left(aS_I-\frac{a^2R^2N_I}2\right)\le1 \tag{9}$$

by iterating conditional expectation over $i$. For fixed $m\in\{1,\ldots,n\}$, use $a=\sqrt{2u}/(R\sqrt m)$ in (9). On the event $S_I\ge R\sqrt{2mu}$ and $N_I=m$, the exponential is at least $e^u$. Markov's inequality, and then the same argument for $-S_I$, give

$$\mathbb P\{|S_I|\ge R\sqrt{2mu},\ N_I=m\}\le2e^{-u}.$$

Union over $m$ and $I$ proves, with failure probability at most $2Jn e^{-u}=\delta/2$,

$$|S_I|\le R\sqrt{2uN_I}\quad\hbox{for every grid interval }I. \tag{10}$$

When $N_I=0$, its sum is zero. When $R=0$, all assertions are immediate without dividing by $R$. A second union bound from (1) gives, with failure probability at most $2n e^{-v}=\delta/2$,

$$\max_{i\le n}|\varepsilon_i|\le R\sqrt{2v}. \tag{11}$$

No conditioning on the final locations occurs in (9)–(11).

### 2.2. Cell lower envelopes and layer integration

For each cell $C$, define $\underline g(C)=\inf_{t\in\overline C}g(t)$, taking the infimum over its closure. Let $a_i=\underline g(C(X_i))$. Then

$$0\le a_i\le g(X_i),\qquad |g(X_i)-a_i|\le LM^{-\alpha}. \tag{12}$$

For each level $a$, cells for which $\underline g(C)>a$ form at most $p$ blocks of consecutive cells. Indeed, each such closed cell lies inside one interval component of the strict superlevel set; cells between two eligible cells in the same component are eligible as well. This assertion uses the actual intervals and continuity, so it handles exact grid boundaries. It is also a direct way of avoiding a union over arbitrary random thresholds.

On event (10), the noise sum on a union of at most $p$ disjoint grid intervals is at most

$$R\sqrt{2u}\sum_{j=1}^p\sqrt{N_j}\le R\sqrt{2pu}\sqrt{\sum_jN_j}.$$

Let $N_a=\#\{i:a_i>a\}$ and $a_* =\max_i a_i$. The finite layer-cake identity and Cauchy–Schwarz in the level variable yield

$$\left|\sum_i a_i\varepsilon_i\right|
\le R\sqrt{2pu}\int_0^{a_*}\sqrt{N_a}\,da
\le R\sqrt{2pu}\sqrt{a_*\sum_i a_i}\le AR\sqrt{2pu}. \tag{13}$$

If $a_*=0$, this is interpreted directly as zero. Finally, (11)–(12) bound the remainder by $nLM^{-\alpha}R\sqrt{2v}$. This proves (8). In particular, the mass-times-maximum condition is stronger than an empirical $\ell_2$ bound for this purpose and prevents a spurious additional logarithm.

## 3. Exact RKHS and deterministic posterior identities

All results in this section hold for every deterministic finite multiset of locations. They therefore hold pathwise for an adaptive multiset, without changing the distribution of the errors.

**Lemma 3 (exact energy and resolvent).** The RKHS of $e^{-|s-t|}$ on $[0,1]$ is the real Sobolev space $H^1([0,1])$ with its continuous representatives and inner product

$$\langle u,v\rangle_H=
\frac12\int_0^1(u'v'+uv)\,dt+
\frac12[u(0)v(0)+u(1)v(1)]. \tag{14}$$

To verify this, the norm is equivalent to the usual $H^1$ norm, so the space is complete and evaluations are continuous. For an interior $x$, the function $k_x(t)=e^{-|x-t|}$ has $k_x''=k_x$ away from $x$, derivative jump $-2$ at $x$, and boundary derivatives $k_x'(0)=k_x(0)$, $k_x'(1)=-k_x(1)$. Integration by parts gives $\langle u,k_x\rangle_H=u(x)$. At $x=0$, the coefficient $(k_0(0)-k_0'(0))/2$ equals one, while the other boundary term is zero; at $x=1$ the symmetric calculation applies. A function orthogonal to every $k_x$ vanishes everywhere, proving density and the exact reproducing-kernel identification.

Define

$$V=I+\lambda^{-2}\sum_{i=1}^n k_{X_i}\otimes k_{X_i},\qquad
h_x(t)=k(x,t)-k_n(x)^TA_n^{-1}k_n(t).$$

Direct substitution (equivalently the finite-rank Woodbury identity) gives $h_x=V^{-1}k_x$. Thus, for every $v\in H$,

$$\langle h_x,v\rangle_H+\lambda^{-2}\sum_i h_x(X_i)v(X_i)=v(x). \tag{15}$$

In particular,

$$\sigma_n(x)^2=h_x(x)=\|h_x\|_H^2+\lambda^{-2}\sum_i h_x(X_i)^2. \tag{16}$$

The evaluation functional at $x$ is nonzero, so $h_x\ne0$ and $\sigma_n(x)>0$. Since $V\succeq I$, also $\sigma_n(x)\le1$.

### 3.1. Positivity and the exact boundary terms

**Lemma 4 (positive, single-peaked posterior covariance).** For every design and query, $h_x\ge0$; it is nondecreasing and convex on $[0,x]$, and nonincreasing and convex on $[x,1]$.

For positivity, use the Sobolev negative part $h_- =\max\{-h_x,0\}$ as the test function in (15). The Sobolev chain rule and the endpoint terms in (14) give

$$-\|h_-\|_H^2-\lambda^{-2}\sum_i h_-(X_i)^2=h_-(x)\ge0.$$

Hence $h_-=0$ and continuity gives nonnegativity everywhere.

Let $r_a=\#\{i:X_i=a\}$, setting $r_a=0$ when $a$ is not observed. Between the distinct observation locations and the query, (15) gives $h_x''=h_x$. The representation as a finite combination of exponentials gives one-sided derivatives at the knots. Integrating (15) by parts yields, at every interior knot $a$,

$$h_x'(a+)-h_x'(a-)=\frac{2r_a}{\lambda^2}h_x(a)-2\mathbf1_{\{a=x\}}, \tag{17}$$

and the exact endpoint conditions are

$$h_x'(0+)=(1+2r_0/\lambda^2)h_x(0)-2\mathbf1_{\{x=0\}},$$

$$h_x'(1-)=-(1+2r_1/\lambda^2)h_x(1)+2\mathbf1_{\{x=1\}}. \tag{18}$$

On $(0,x)$, the second derivative is a nonnegative measure: it is $h_x(t)\,dt$ plus the nonnegative observation jumps. The left boundary derivative is nonnegative when $x>0$, so all left slopes are nonnegative. On $(x,1)$, slopes are nondecreasing toward a nonpositive right boundary derivative when $x<1$, so all right slopes are nonpositive. These statements also prove the respective convexities. If $x=0$, only the right argument, with the unaffected endpoint $1$, is needed; if $x=1$, only the left argument is needed. Repetitions and observations coinciding with the query are already included in (17)–(18). It follows that

$$0\le h_x(t)\le h_x(x)=\sigma_n(x)^2. \tag{19}$$

### 3.2. Total influence and the normalized modulus

Let $z=A_n^{-1}k_n(x)$. Matrix multiplication gives

$$h_x(X_i)=\lambda^2z_i. \tag{20}$$

**Lemma 5 (subunit influence and normalized shape budget).** For every design and query,

$$z_i\ge0,\quad\sum_i z_i\le1,\quad
g_x(t):=\frac{h_x(t)}{\lambda^2\sigma_n(x)}\ge0,$$

$$\sup_tg_x(t)=\frac{\sigma_n(x)}{\lambda^2},\quad
\sum_i g_x(X_i)\le\frac1{\sigma_n(x)},\quad
|g_x(t)-g_x(s)|\le\frac{\sqrt{2|t-s|}}{\lambda^2}. \tag{21}$$

The total-influence assertion needs a separate proof, not just positivity. Let $m(t)=k_n(t)^TA_n^{-1}\mathbf1$. Its weak equation is

$$\langle m,v\rangle_H+\lambda^{-2}\sum_i m(X_i)v(X_i)=\lambda^{-2}\sum_i v(X_i).$$

Take $p=(m-1)_+$. Since $\langle m,p\rangle_H=\|p\|_H^2+\langle1,p\rangle_H$ and

$$\langle1,p\rangle_H=\tfrac12\int_0^1p+\tfrac12[p(0)+p(1)]\ge0,$$

the weak equation gives

$$\|p\|_H^2+\langle1,p\rangle_H+\lambda^{-2}\sum_i p(X_i)^2=0.$$

Thus $m\le1$. Equation (20) and Lemma 4 give $z_i\ge0$, and $m(x)=\sum_i z_i$, proving the claimed mass bound. The maximum in (21) follows from (19). Finally, (16) implies $\|h_x\|_H\le\sigma_n(x)$. The reproducing property gives

$$|h_x(t)-h_x(s)|\le\|h_x\|_H\|k_t-k_s\|_H
\le\sigma_n(x)\sqrt{2(1-e^{-|t-s|})},$$

which proves the modulus in (21). This normalized estimate is independent of the design and of how small $\sigma_n(x)$ has become.

## 4. Proof of the upper bound and the confidence sequence

The signal/noise decomposition of (2), using $h_x=V^{-1}k_x$, is

$$f(x)-\mu_n(x)=\langle h_x,f\rangle_H-\sum_i z_i\varepsilon_i. \tag{22}$$

Its first term is at most $B\sigma_n(x)$ by (16). The normalized second term is $\sum_i g_x(X_i)\varepsilon_i$.

Apply Theorem 2 with $p=1$, $A=1/\lambda$, $L=\sqrt2/\lambda^2$, $\alpha=1/2$, and $M=M_n$. Lemmas 4–5 establish every pathwise hypothesis, simultaneously for all queries. The grid choice satisfies

$$nLM_n^{-1/2}=\frac{n\sqrt2}{\lambda^2\sqrt{M_n}}\le\frac1\lambda. \tag{23}$$

This remains true when $M_n=1$, because then $2n^2/\lambda^2\le1$. Equations (8), (22), and (23) give (5). The event from Theorem 2 is independent of the subsequent choice of query, so it also allows a query selected after all data have been observed.

For each fixed $\lambda$, $M_n\le(1+2/\lambda^2)n^2$ and $J_n\le M_n^2$. Thus both logarithms in (4) are bounded by a constant depending on $\lambda$ times $\log(n/\delta)$ for $n\ge4$, $\delta\le1/4$. This proves the upper half of (7), without asserting a uniform-in-$\lambda$ asymptotic constant.

**Corollary 6 (all-time spatial confidence sequence).** Set $\delta_n=\delta/[n(n+1)]$ for $n\ge1$ and $\beta_n=b_n(\delta_n)$; set $\beta_0=B$. Then

$$\mathbb P\left(\forall n\ge0,\ \forall x\in[0,1]: |f(x)-\mu_n(x)|\le\beta_n\sigma_n(x)\right)\ge1-\delta. \tag{24}$$

Indeed, $\sum_{n\ge1}1/[n(n+1)]=1$ and (5) applies at each deterministic $n$. The case $n=0$ is $|f(x)|\le B$. In particular, (24) remains true when inspected at a random stopping time. This is an upper confidence sequence; no optimal time-uniform constant or iterated-logarithm assertion is made.

## 5. Matching deterministic-design lower bounds

**Theorem 7 (finite-sample lower bound).** Let $n\ge4$, $m=\lfloor\sqrt n\rfloor$, and $0<\delta<1$. Then

$$\rho_n^*(\delta;B,R,\lambda)\ge
\frac R{2\lambda(1+\lambda^2)}
\Phi^{-1}\left(\frac{1+(1-\delta)^{1/m}}2\right), \tag{25}$$

with zero noise contribution if $R=0$. Independently, for every $n\ge1$ and $0<\delta<1$,

$$\rho_n^*(\delta;B,R,\lambda)\ge B\sqrt{1-e^{-2}}. \tag{26}$$

Here $\Phi$ denotes the standard normal distribution function.

### 5.1. Repeated grid and normalized covariance

Set $q=\lfloor n/m\rfloor$ and $r=n-mq$. Use the sites $t_j=(j-1)/(m-1)$, $j=1,\ldots,m$, with $q+1$ observations at the first $r$ sites and $q$ at each other site. Denote the site counts by $q_j$ and put $D=\operatorname{diag}(q_j)$. All $n$ observations are used and $q\ge m\ge2$.

Take $f=0$ and independent $N(0,R^2)$ errors. Let $K=(k(t_i,t_j))$, $Q=K^{-1}$, $C=(Q+\lambda^{-2}D)^{-1}$, and $S=\operatorname{diag}(C_{jj})$. Grouping repeated observations in the ordinary KRR equations gives $\sigma_n(t_j)^2=C_{jj}$ and $\mu_n(t_{1:m})=\lambda^{-2}Ce$, where $e_j$ is the sum of the errors at site $t_j$. One way to verify the grouping is to minimize

$$u^TQu+\lambda^{-2}\sum_jq_j(u_j-\overline Y_j)^2$$

over the latent site values $u$; the minimum-norm interpolant at these distinct sites has squared RKHS norm $u^TQu$. The normal equations give the displayed formula, and the same matrix identity gives $C$.

Since $e\sim N(0,R^2D)$, the vector $Z=S^{-1/2}\lambda^{-2}Ce$ of normalized errors at the sites has covariance

$$\Sigma=\frac{R^2}{\lambda^4}S^{-1/2}CDC S^{-1/2}. \tag{27}$$

Write $h=1/(m-1)$ and $a=e^{-h}$. Direct multiplication shows that the inverse of $K_{ij}=a^{|i-j|}$ is tridiagonal, with endpoint diagonals $1/(1-a^2)$, interior diagonals $(1+a^2)/(1-a^2)$, and adjacent entries $-a/(1-a^2)$. For $m=2$, both diagonal entries are endpoint entries. The positive-definiteness can also be seen from the quadratic form

$$v^TQv=v_1^2+\sum_{j=1}^{m-1}\frac{(v_{j+1}-av_j)^2}{1-a^2}>0\quad(v\ne0).$$

The maximum absolute row sum gives

$$\|Q\|_{\rm op}\le\frac{1+a}{1-a}=1+\frac2{e^h-1}\le2m. \tag{28}$$

Using $qI\preceq D\preceq(q+1)I$,

$$\frac{\lambda^2}{q+1+2\lambda^2m}I\preceq C\preceq\frac{\lambda^2}qI,\qquad
S\preceq\frac{\lambda^2}qI.$$

Also $CDC\succeq qC^2$. Congruence in (27) therefore yields

$$\Sigma\succeq\frac{R^2}{\lambda^2}
\left(\frac q{q+1+2\lambda^2m}\right)^2I
\succeq\left[\frac R{2\lambda(1+\lambda^2)}\right]^2I. \tag{29}$$

These are deterministic matrix inequalities; they do not assume unproved independence of the normalized coordinates.

### 5.2. A Gaussian small-ball bound

For $R>0$, put $a_\lambda=R/[2\lambda(1+\lambda^2)]$. By (29) one can write in distribution $Z=a_\lambda\xi+\eta$, where $\xi\sim N(0,I_m)$ is independent of $\eta\sim N(0,\Sigma-a_\lambda^2I)$. A possibly singular covariance for $\eta$ is permitted.

For a scalar centered Gaussian, a fixed-length interval has greatest probability when centered at zero. This follows by differentiating its mass with respect to a positive translation and using the symmetry and radial decrease of the density. Thus, conditional on $\eta$, independence of the $\xi_j$ gives

$$\mathbb P(\max_j|Z_j|\le t)\le[2\Phi(t/a_\lambda)-1]^m. \tag{30}$$

A spatially simultaneous confidence band must cover these $m$ sites. Equation (30) proves (25).

### 5.3. The explicit logarithmic rate

For $0<\delta\le1/4$, let $z=\Phi^{-1}((1+(1-\delta)^{1/m})/2)$ and $L=\log(m/\delta)\ge\log8$. Then

$$1-\Phi(z)=\frac{1-(1-\delta)^{1/m}}2\le\frac{2\delta}{3m}.$$

On the other hand, for $z\ge0$,

$$1-\Phi(z)\ge\frac{e^{-(z+1)^2/2}}{\sqrt{2\pi}}\ge\frac{e^{-z^2}}{e\sqrt{2\pi}}.$$

The first inequality integrates the density only from $z$ to $z+1$; the second uses $(z+1)^2/2\le z^2+1$. Hence $z^2\ge L+\log[3/(2e\sqrt{2\pi})]\ge L/4$. For the last inequality, it suffices that $e\sqrt{2\pi}<7$ and $3/14>8^{-3/4}$. Since $m\ge n^{1/4}$ for $n\ge4$, we obtain

$$\rho_n^*(\delta;B,R,\lambda)\ge
\frac R{8\lambda(1+\lambda^2)}\sqrt{\log(n/\delta)}. \tag{31}$$

### 5.4. Bias term and combination

Observe only at $0$ and use identically zero noise. Put $a=e^{-1}$ and

$$f=\frac B{\sqrt{1-a^2}}(k_1-ak_0).$$

The reproducing property gives $\|f\|_H=B$, $f(0)=0$, and $f(1)=B\sqrt{1-a^2}$. All responses are zero, so $\mu_n=0$, while $\sigma_n(1)\le1$. This proves (26). The width in (3) must cover this design and the Gaussian grid design separately. Applying $\max\{u,v\}\ge(u+v)/2$ to (26) and (31), and using $\sqrt{1-e^{-2}}\ge1/[8(1+\lambda^2)]$, gives (6). Together with Section 4, this completes Theorem 1.

## 6. An information-gain consequence for ordinary GP-UCB

This section is a corollary, not a claim to a new general bandit algorithm or a new information-gain bound. For the kernel and fixed $\lambda$ above, define

$$\Gamma_T=\frac12\sup_{x_1,\ldots,x_T\in[0,1]}
\log\det(I_T+\lambda^{-2}K_T).$$

Use a measurable maximizer of $U_t(x)=\mu_{t-1}(x)+\beta_{t-1}\sigma_{t-1}(x)$, with $\beta$ from Corollary 6. The argmax is nonempty and compact by continuity. Its least element is a predictable selection: for a deterministic $a\in[0,1]$, the event that this element is at most $a$ is $\{\max_{[0,a]}U_t=\max_{[0,1]}U_t\}$; both maxima are $\mathcal F_{t-1}$-measurable as suprema on countable dense sets (with the singleton endpoint treated directly). Let $x^*$ maximize $f$ and define cumulative regret $\mathcal R_T=\sum_{t=1}^T(f(x^*)-f(X_t))$.

**Corollary 8 (regret in terms of information gain).** On the confidence event in (24), for every $T\ge1$,

$$\mathcal R_T\le2\overline\beta_T
\sqrt{\frac{2T\Gamma_T}{\log(1+\lambda^{-2})}},\qquad
\overline\beta_T=\max_{0\le s<T}\beta_s. \tag{32}$$

Optimism gives $f(x^*)-f(X_t)\le2\beta_{t-1}\sigma_{t-1}(X_t)$. Schur complements give the pathwise determinant identity

$$\log\det(I_T+\lambda^{-2}K_T)
=\sum_{t=1}^T\log(1+\lambda^{-2}\sigma_{t-1}(X_t)^2).$$

Since $0\le\sigma_{t-1}^2\le1$, concavity implies $\log(1+\lambda^{-2}a)\ge a\log(1+\lambda^{-2})$ for $a\in[0,1]$. Sum this inequality and apply Cauchy–Schwarz to the regret sum to obtain (32). A known kernel-specific upper bound for $\Gamma_T$ may be substituted, but no unread external information-gain theorem is required for (32).

## 7. Why a direct random-threshold argument would be false

**Proposition 9 (adaptive threshold obstruction).** There are predictable locations with independent Rademacher errors such that a threshold selected after the observations separates every positive error from every negative error.

Start with $L_0=0$, $U_0=1$. Set $X_i=(L_{i-1}+U_{i-1})/2$. If $\varepsilon_i=+1$, set $L_i=X_i$, $U_i=U_{i-1}$; if $\varepsilon_i=-1$, set $L_i=L_{i-1}$, $U_i=X_i$. The locations are predictable. For $c=(L_n+U_n)/2$,

$$\mathbf1_{\{X_i<c\}}=\mathbf1_{\{\varepsilon_i=+1\}}\quad\hbox{for every }i.$$

Thus the interval sum is $N_+$, with selected count $N_+$, and its count-normalized value is $\sqrt{N_+}$ when $N_+>0$. Since $\mathbb EN_+=n/2$ and $\operatorname{Var}(N_+)=n/4$, Chebyshev's inequality gives $\mathbb P(N_+\ge n/4)\ge1-4/n$. In particular, for $n\ge8$ this random threshold has a count-normalized sum at least $\sqrt n/2$ with probability at least $1/2$.

This excludes an indiscriminate logarithmic union bound over all response-selected continuum intervals. The proof of Theorem 2 instead uses a deterministic finite grid and a quantitative continuity bound on the actual posterior weights. The final design is never treated as independent of its noises.

## 8. Scope and verification limitations

The results concern the amplitude-one exponential kernel on a fixed one-dimensional interval and fixed positive regularization. They do not establish the corresponding result for $\nu>1/2$, squared-exponential kernels, higher-dimensional domains, arbitrary sums of kernels, data-selected regularization, or zero regularization. Rescaling the interval or kernel requires the associated constants to be tracked; it is not needed for the stated theorem.

The matched lower rate is for one deterministic width covering the whole spatial domain and all models in (3). It does not imply a $\sqrt{\log n}$ lower bound at a single prespecified point, a lower bound over every estimator, or an additional adaptivity penalty. The all-time construction is a valid upper sequence; sharp sequential constants are not claimed. The finite constants in (4) are conservative and can be loose at practical sample sizes.

The full mathematical argument is analytic. The companion NumPy checks examine posterior positivity, repeated and endpoint cases, the modulus, total influence, and finite lower-bound covariance inequalities. They are floating-point diagnostics, not proof certificates or substitutes for the universal statements. The accompanying diagnostic programs are not included in this release. No compiled formal coverage is claimed.

## References

- **[V21]** S. Vakili, J. Scarlett and T. Javidi. *Open Problem: Tight Online Confidence Intervals for RKHS Elements*. COLT 2021, PMLR 134. Official source: <https://proceedings.mlr.press/v134/vakili21a/vakili21a.pdf>.
- **[L23]** T. Lattimore. *A Lower Bound for Linear and Kernel Regression with Adaptive Covariates*. COLT 2023, PMLR 195:2095–2113. <https://proceedings.mlr.press/v195/lattimore23b.html>.
- **[HS26]** H. Hu and D. Simchi-Levi. *Tight Sequential Confidence Intervals for Online Kernel Regression*. arXiv:2611.19772v1, 15 November 2026. <https://arxiv.org/html/2611.19772v1>.
- **[FR25]** H. Flynn and D. Reeb. *Tighter Confidence Bounds for Sequential Kernel Regression*. AISTATS 2025, PMLR 258:3844–3852; inspected preprint arXiv:2403.12732v2. <https://proceedings.mlr.press/v258/flynn25a.html>; <https://arxiv.org/html/2403.12732v2>.

Source versions and access limits are recorded separately. No uninspected paper is used to close a mathematical step in this manuscript.
