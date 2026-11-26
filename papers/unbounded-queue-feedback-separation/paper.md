# Full-support unbounded service times with a quantitative feedback capacity gap

Research manuscript, 26 November 2026

## Abstract

We construct a discrete-time first-in-first-out timing queue whose service law has full support on the positive integers and an exponential tail, but whose full-feedback capacity strictly exceeds its weak-feedback and no-feedback capacities. Let $S=1+2G+B$, where $\Pr(G=k)=\frac14(\frac34)^k$ and $B$ is an independent Bernoulli variable with parameter $1/16$. Writing $H_0=\log(256/27)+h(1/16)$, we prove

$$
C^F=\log(1+e^{-H_0}),\qquad
C\le C^{WF}\le C^F-\frac1{40000}
\quad\text{nats per slot}.                                      \tag{1}
$$

All three capacities in (1) are optimized over their admissible output rates. A probability-generating-function construction attains the full-feedback upper bound. For the converse, every weak-feedback residual output obeys a linear inequality involving only its first three probabilities, whereas the corresponding maximum-entropy geometric output violates it. Relative entropy converts this separation into a quantitative loss, and strict concavity controls output rates away from the optimum. The same positive gap holds on an explicitly specified open set of service-law parameters. We also characterize exactly the residual waiting distributions for the lattice family $S=1+dG_q$. The entropy separation supplies a counterexample to Theorem 3, equation (7), of the inspected author version arXiv:2309.14145v2. The argument concerns that stated unbounded-support assertion, not the paper's bounded-support results. The exact weak-feedback capacity and a classification of general service laws remain open.

## 1. Model, notation, and established capacity interface

Time, arrival instants, and service durations are integer valued. The queue has one server, follows first-in-first-out order, and is initially empty. Packet service times are independent and identically distributed with law $S$ on $\mathbb N_+=\{1,2,\ldots\}$. Put $m=\mathbb ES\lt \infty$, $\mu=1/m$, and assume $H(S)\lt \infty$. All logarithms are natural. A rate is measured in nats per unit time slot, rather than per packet.

Full feedback reveals departure times causally. Weak feedback reveals the times at which packets enter service. No feedback reveals neither. We use the expected-duration timing-code convention of [1,2]: a code sends $n$ packets, its final departure has expected time at most $T_n$, and an asymptotically achievable communication rate is the limiting message log-cardinality divided by $T_n$, with error probability tending to zero. At fixed output rate $\lambda$, the expected final departure is bounded by $n/\lambda$, and the asymptotic message rate is $\lambda\log M_n/n$. Write $C(\lambda),C^{WF}(\lambda),C^F(\lambda)$ for these rate-constrained capacities and $C,C^{WF},C^F$ for their suprema over $0\lt \lambda\lt \mu$.

The following established interface is used with precisely these conventions. It is the full-feedback entropy characterization and weak-feedback converse of [1,2], also restated in [3, Propositions 2 and 3]. It is not a new coding theorem of this manuscript.

**Proposition 1 (established queue-capacity interface).** Let

$$
\begin{aligned}
\mathcal F_S(\lambda)
&=\sup_{W\in\mathbb N_0,\,\mathbb EW\le\lambda^{-1}-m} H(W+S),\\
\mathcal U_S(\lambda)
&=\sup_{X\in\mathbb N_0,\,\mathbb E(X-S_1)^+\le\lambda^{-1}-m}
 H((X-S_1)^++S_2),
\end{aligned}                                                     \tag{2}
$$

where $W$ is independent of $S$, and $X,S_1,S_2$ are mutually independent with $S_1,S_2$ distributed as $S$. Then

$$
\begin{aligned}
C^F(\lambda)&=\lambda\bigl(\mathcal F_S(\lambda)-H(S)\bigr),\\
C(\lambda)&\le C^{WF}(\lambda)
 \le\lambda\bigl(\mathcal U_S(\lambda)-H(S)\bigr).
\end{aligned}                                                     \tag{3}
$$

The weak-feedback expression is an upper bound; we do not assume that it is achievable. The independent variable $X$ in that expression is the single-letter variable in the established converse. This does not restrict actual encoders to independent arrivals or memoryless strategies. Consequently, a separation proved for (2) applies to the operational capacities through (3). A formal verification of the operational conclusions must import or prove this full interface for the stated timing-code model; replacing it by unverified axioms would only verify a conditional corollary.

For a probability mass function $p$, write $H(p)=-\sum_j p_j\log p_j$, with $0\log0=0$. For two laws $P,Q$ on a countable set, let

$$
D(P\Vert Q)=\sum_j p_j\log(p_j/q_j),\qquad
\operatorname{TV}(P,Q)=\tfrac12\sum_j|p_j-q_j|.
$$

Let $h(u)=-u\log u-(1-u)\log(1-u)$ for $0\lt u\lt 1$, and let $Q_\lambda$ denote the positive-integer geometric law

$$
Q_\lambda(j)=\lambda(1-\lambda)^{j-1},\quad j\ge1,
\qquad \mathbb E Q_\lambda=\lambda^{-1}.                           \tag{4}
$$

## 2. Entropy loss from a finite probability certificate

**Lemma 2 (geometric entropy identity).** If $Y$ is positive-integer valued with $\mathbb EY\le1/\lambda\lt \infty$, then its entropy is finite and

$$
H(Q_\lambda)-H(Y)
=D(P_Y\Vert Q_\lambda)
 +[-\log(1-\lambda)](\lambda^{-1}-\mathbb EY)
\ge D(P_Y\Vert Q_\lambda).                                      \tag{5}
$$

In particular, with $H_S=H(S)$,

$$
C^F(\lambda)\le g_S(\lambda):=h(\lambda)-\lambda H_S.              \tag{6}
$$

*Proof.* The cross entropy against (4) is
$-\log\lambda-(\mathbb EY-1)\log(1-\lambda)$, which is finite. The countable log-sum inequality bounds entropy by this cross entropy and makes the defining relative-entropy identity legitimate. Subtracting the value at mean $1/\lambda$ gives (5). Multiplying the geometric entropy by $\lambda$ gives $h(\lambda)$. Every output in the full-feedback optimization has mean at most $1/\lambda$, proving (6). The countable log-sum assertion follows by grouping all indices after $N$ into one atom, applying the finite inequality, and passing to the limit; the finite cross-entropy bound prevents an infinite entropy term. $\square$

**Lemma 3 (finite separation).** Let $f$ be bounded, of oscillation $R=\sup f-\inf f>0$. If $\mathbb E_P f\ge0$ and $\mathbb E_{Q_\lambda}f\le-\delta\lt 0$, then

$$
\operatorname{TV}(P,Q_\lambda)\ge\delta/R,
\qquad D(P\Vert Q_\lambda)\ge2\delta^2/R^2.                       \tag{7}
$$

If also $\mathbb E_PY\le1/\lambda$, then $H(Q_\lambda)-H(P)\ge2\delta^2/R^2$.

*Proof.* Subtracting $\inf f$ and using the positive and negative parts of $P-Q_\lambda$ gives
$|\mathbb E_Pf-\mathbb E_{Q_\lambda}f|\le R\operatorname{TV}(P,Q_\lambda)$.
For completeness, set $A=\{j:p_j\ge Q_\lambda(j)\}$, $u=P(A)$ and $v=Q_\lambda(A)$. Then $u-v=\operatorname{TV}(P,Q_\lambda)$. Log-sum on $A$ and its complement gives $D(P\Vert Q_\lambda)\ge d(u\Vert v)$, the binary relative entropy. For fixed $0\lt v\lt 1$, its second derivative in $u$ is $1/[u(1-u)]\ge4$, and its value and first derivative vanish at $u=v$. Integration gives $d(u\Vert v)\ge2(u-v)^2$. Boundary cases follow by limits, with the zero-distance case immediate. The last claim follows from Lemma 2. $\square$

**Lemma 4 (the unconstrained entropy envelope).** For finite $H_S\ge0$, the function in (6) has its unique maximum over $0\lt \lambda\lt 1$ at

$$
\lambda_*=(1+e^{H_S})^{-1},\qquad
g_S(\lambda_*)=\log(1+e^{-H_S}).                                 \tag{8}
$$

Moreover,

$$
g_S(\lambda_*)-g_S(\lambda)\ge2(\lambda-\lambda_*)^2.              \tag{9}
$$

*Proof.* Differentiating gives $g'_S(\lambda)=\log((1-\lambda)/\lambda)-H_S$ and $g''_S(\lambda)=-1/[\lambda(1-\lambda)]\le-4$. The critical point, its value, and (9) follow. To use (8) as a queue capacity, both $\lambda_*\lt \mu$ and a feasible waiting law attaining (4) still have to be proved. $\square$

## 3. A residual constraint for geometrically repeated blocks

Let $d\ge1$ be an integer, $0\lt q\lt 1$, and

$$
\Pr(G_q=k)=(1-q)q^k\quad(k\ge0).
$$

Let $B$ be independent of $G_q$, with probabilities $a_b$ on $\{0,\ldots,d-1\}$, and define

$$
S=1+dG_q+B.                                                       \tag{10}
$$

For an arbitrary independent $X\in\mathbb N_0$, write $x_j=\Pr(X=j)$ and $w_n=\Pr((X-S)^+=n)$.

**Lemma 5 (exact prefix identity).** For every $n\ge1$,

$$
w_n-qw_{n+d}=(1-q)\sum_{b=0}^{d-1}a_bx_{n+1+b},                  \tag{11}
$$

and

$$
(1-q)w_0-q\sum_{n=1}^d w_n
=(1-q)\sum_{b=0}^{d-1}a_b\Pr(X\le1+b)\ge0.                       \tag{12}
$$

No moment assumption on $X$ is needed for these identities.

*Proof.* Independence gives
$w_n=(1-q)\sum_b a_b\sum_{k\ge0}q^kx_{n+1+b+dk}$ for $n\ge1$.
Subtract the same expression shifted by $d$ and multiplied by $q$; all terms except $k=0$ cancel, proving (11). All sums are absolutely convergent. Summing (11) over $n\ge1$ gives on its left
$(1-q)(1-w_0)+q\sum_{n=1}^d w_n$, and on its right
$(1-q)\sum_ba_b\Pr(X\ge2+b)$. Rearrangement proves (12). $\square$

We now specialize (10) to $d=2$ and $B\sim\operatorname{Bernoulli}(\varepsilon)$, where $0\le\varepsilon\lt 1$. Put

$$
s_1=(1-q)(1-\varepsilon),\quad s_2=(1-q)\varepsilon,
\quad t=\frac{\varepsilon}{1-\varepsilon},
\quad A=1-q+q^2+qt-qt^2.                                        \tag{13}
$$

**Corollary 6 (three-probability certificate).** If $Y=(X-S_1)^++S_2$ is a weak-feedback residual output as in (2), and $p_j=\Pr(Y=j)$, then

$$
A p_1-q(1-t)p_2-qp_3
=s_1(1-q)\bigl[\Pr(X\le1)+\varepsilon\Pr(X=2)\bigr]\ge0.         \tag{14}
$$

*Proof.* Here the subscripts on the independent service copies $S_1,S_2$ are distinct from the lower-case masses $s_1,s_2$. The first three convolution equations give

$$
w_0=\frac{p_1}{s_1},\qquad
w_1=\frac{p_2-tp_1}{s_1},\qquad
w_2=\frac{p_3-tp_2+(t^2-q)p_1}{s_1}.                             \tag{15}
$$

Substitute these into (12) and multiply by $s_1$. Its right side is
$s_1(1-q)[(1-\varepsilon)\Pr(X\le1)+\varepsilon\Pr(X\le2)]$, which equals the right side of (14). $\square$

This constraint holds for every input law in the weak-feedback supremum. In particular, it remains valid for a sequence approaching a supremum, whether or not an optimizing input exists. Only three output probabilities are required to certify a uniform entropy deficit.

## 4. Full-feedback attainment for the two-residue family

For the family in (13), the mean, entropy, and probability generating function of $S$ are

$$
\begin{aligned}
m&=1+\frac{2q}{1-q}+\varepsilon,\\
H_S&=-\log(1-q)-\frac q{1-q}\log q+h(\varepsilon),\\
\mathbb Ez^S&=\frac{z(1-q)(1-\varepsilon)(1+tz)}{1-qz^2}.
\end{aligned}                                                     \tag{16}
$$

The entropy formula follows because the parity of $S$ identifies $B$ and the remaining integer identifies $G_q$. At $\varepsilon=0$, set $h(0)=0$.

**Lemma 7 (a nonnegative deconvolution).** Let $r=1-\lambda\in(0,1)$. Suppose

$$
0\le t\lt r,\qquad t^2\le q\lt 1,
\qquad r^2-rt+t^2\ge q.                                         \tag{17}
$$

Then there is a nonnegative-integer waiting law, independent of $S$, for which $W+S$ has law $Q_\lambda$. Its generating function and coefficients are

$$
\mathbb Ez^W=c\frac{1-qz^2}{(1-rz)(1+tz)},\qquad
c=\frac{\lambda}{(1-q)(1-\varepsilon)},                          \tag{18}
$$

$$
w_0=c,\quad w_1=c(r-t),\quad
w_n=\frac c{r+t}\bigl[(r^2-q)r^{n-1}+(q-t^2)(-t)^{n-1}\bigr]
\quad(n\ge2).                                                    \tag{19}
$$

It has finite mean $\mathbb EW=1/\lambda-m$. Whenever $0\lt \lambda\lt \mu$, it is feasible for (2), and

$$
\mathcal F_S(\lambda)=H(Q_\lambda),\qquad C^F(\lambda)=g_S(\lambda).
                                                                    \tag{20}
$$

*Proof.* Expanding the two geometric denominators gives (19). Condition (17) implies $r^2\ge q$, since $rt-t^2\ge0$. For odd $n\ge3$ both terms in brackets are nonnegative. For even $n\ge2$, the required inequality is
$(r^2-q)r^{n-1}\ge(q-t^2)t^{n-1}$. At $n=2$ it is equivalent to
$(r+t)(r^2-rt+t^2-q)\ge0$. For larger even $n$, it follows from $r>t$. Also $w_0>0$ and $w_1>0$. The coefficients are therefore nonnegative. They are summable with finite first moment, because $r,t\lt 1$. Evaluating (18) at $z=1$ gives total mass one; this also proves $w_0\le1$, so no separate normalization assumption has been omitted. Multiplying (18) by (16) gives $z\lambda/(1-rz)$, the generating function of (4). Differentiation at $z=1$, or adding the finite independent means, gives the asserted waiting cost. Lemma 2 then proves (20). $\square$

## 5. An explicit full-support service law

Fix from now on

$$
q=\frac34,\qquad \varepsilon=\frac1{16},\qquad
S=1+2G_q+B.
                                                                    \tag{21}
$$

**Lemma 8 (service law and maximizing rate).** This service law satisfies

$$
\Pr(S=2k+1)=\frac{15}{64}(3/4)^k,\qquad
\Pr(S=2k+2)=\frac1{64}(3/4)^k,\quad k\ge0,                         \tag{22}
$$

$$
m=\frac{113}{16},\qquad H_S=H_0=\log(256/27)+h(1/16),
\qquad e^{H_0}=\frac{4096}{27\,15^{15/16}},                         \tag{23}
$$

and

$$
\frac3{40}\lt \lambda_*=(1+e^{H_0})^{-1}\lt \frac1{12}\lt \frac1{10}\lt \mu.
                                                                    \tag{24}
$$

It has full positive-integer support and an exponential tail.

*Proof.* Equations (22) and (23) follow from independence and (16). In fact $\Pr(S\ge2k+1)=q^k$ for every $k\ge0$, and its moment generating function is finite for $0\lt \theta\lt -\frac12\log q$. For an exact bound on (24), the integer comparisons

$$
25^{16}\lt 2^{16}15^{15},\qquad 15^{15}\lt 13^{16}                       \tag{25}
$$

imply $25/2\lt 15^{15/16}\lt 13$. Consequently
$11\lt 4096/(27\cdot13)\lt e^{H_0}\lt 8192/675\lt 37/3$.
Taking $1/(1+\cdot)$ proves the first two bounds in (24); the last follows from $\mu=16/113>1/10$. Inequalities (25) are exact finite integer comparisons, independently reproducible by repeated multiplication. $\square$

**Theorem 9 (exact full-feedback capacity).** For (21),

$$
C^F=\log(1+e^{-H_0}).                                            \tag{26}
$$

In fact $C^F(\lambda)=h(\lambda)-\lambda H_0$ for every $0\lt \lambda\le1/10$.

*Proof.* Here $t=1/15$. If $r\ge9/10$, then $r>t$, $q>t^2$, and the function $r^2-rt+t^2-q$ is increasing. At the left endpoint,

$$
(9/10)^2-(9/10)(1/15)+(1/15)^2-3/4=1/225>0.                      \tag{27}
$$

Lemma 7 gives a feasible geometric output for every stated rate. By (24) this includes the unique maximizing rate of Lemma 4, so the global entropy upper bound is attained. $\square$

The decimal values $\lambda_*\approx0.0770491653407$ and $C^F\approx0.0801793127894$ nats per slot are descriptive evaluations of the exact expressions; no inequality in the proof depends on them.

## 6. A gap after optimization over all output rates

For (21), equation (14) becomes

$$
\frac{1031}{1200}p_1-\frac7{10}p_2-\frac34p_3
=\frac{15}{256}\left[\Pr(X\le1)+\frac1{16}\Pr(X=2)\right]\ge0.
                                                                    \tag{28}
$$

Define $f(1)=1031/1200$, $f(2)=-7/10$, $f(3)=-3/4$, and $f(j)=0$ for $j\ge4$. Its oscillation is $R=1931/1200$.

**Lemma 10 (uniform rate-constrained loss).** For every $0\lt \lambda\le1/10$,

$$
\begin{aligned}
\mathcal U_S(\lambda)
&\le H(Q_\lambda)-2(454/1931)^2\lambda^2,\\
C^{WF}(\lambda)
&\le g_S(\lambda)-2(454/1931)^2\lambda^3.
\end{aligned}                                                     \tag{29}
$$

*Proof.* At $Q_\lambda$, with $r=1-\lambda\ge9/10$,

$$
\mathbb E_{Q_\lambda}f
=\lambda\left[\frac{1031}{1200}-\frac7{10}r-\frac34r^2\right]
\le-\frac{227}{600}\lambda.                                      \tag{30}
$$

The bracket is decreasing for $r\ge0$, and its value at $9/10$ is $-227/600$. Every feasible residual output has $\mathbb E f\ge0$ by (28), and mean at most $1/\lambda$. Lemmas 2 and 3 give a total-variation distance of at least $(454/1931)\lambda$, and hence the first bound in (29). The estimate is uniform over the entire feasible class, so it passes to its supremum. Multiplication by $\lambda$ and (3) prove the second bound. $\square$

**Theorem 11 (strict all-rate feedback advantage).** The law (21) obeys

$$
C\le C^{WF}\le C^F-\frac1{40000}.                                 \tag{31}
$$

*Proof.* For $\lambda\in[1/16,1/10]$, the loss in (29) is at least

$$
\kappa_0=2(454/1931)^2(1/16)^3
=\frac{51529}{1909125632}>\frac1{40000}.                          \tag{32}
$$

The strict comparison is the integer inequality
$40000\cdot51529>1909125632$.
Since $g_S(\lambda)\le g_S(\lambda_*)=C^F$, this handles the middle interval. For $0\lt \lambda\lt 1/16$, (24) gives $|\lambda-\lambda_*|>1/80$. For $1/10\lt \lambda\lt \mu$, it gives $|\lambda-\lambda_*|>1/60$. Applying (9) and the general upper bound $C^{WF}(\lambda)\le C^F(\lambda)\le g_S(\lambda)$ yields, throughout both outer intervals,

$$
C^F-C^{WF}(\lambda)\ge\frac1{3200}>\frac1{40000}.                 \tag{33}
$$

Taking the supremum over all admissible output rates proves (31). The constant is a certified lower bound, not the exact gap. $\square$

Thus the phenomenon is not merely a failure to match full feedback at one prescribed packet rate. Weak feedback cannot remove the deficit by choosing another rate.

## 7. A checkable open family with the same positive gap

The example is stable within full-support service laws. The next theorem gives an explicit set of sufficient inequalities rather than a claim about arbitrary perturbations in an unspecified topology.

For $0\lt q\lt 1$, $0\lt \varepsilon\lt 1/2$, define $t,A,m,H_S,\lambda_*$ by (13), (16), and (8), and put

$$
r_0=9/10,\quad
K=q(1-t)r_0+qr_0^2-A,\quad R=A+q.                                \tag{34}
$$

**Theorem 12 (an open parameter region).** Suppose

$$
\begin{gathered}
m\lt 10,\quad t\lt r_0,\quad t^2\lt q\lt r_0^2-r_0t+t^2,\\
3/40\lt \lambda_*\lt 1/12,\quad A>0,\quad K>0,\\
2(1/16)^3(K/R)^2>1/40000.                                       \tag{35}
\end{gathered}
$$

For $S=1+2G_q+B_\varepsilon$, the conclusions

$$
C^F=\log(1+e^{-H_S}),\qquad C\le C^{WF}\le C^F-1/40000             \tag{36}
$$

hold. The region (35) is nonempty, open, and contains $(q,\varepsilon)=(3/4,1/16)$.

*Proof.* In this region $0\lt t\lt 1$, so the finite function with values $A,-q(1-t),-q,0$ has oscillation $A+q$. Equation (14) gives its nonnegative expectation for every residual output. For a geometric output with $r\ge r_0$, the bracket $A-q(1-t)r-qr^2$ is decreasing and is at most $-K$. Thus the same argument as (29) gives a rate loss of at least $2(K/R)^2\lambda^3$ on $0\lt \lambda\le1/10$. Conditions (35) ensure the full-feedback waiting law of Lemma 7 is feasible on this interval: the quadratic is increasing for $r\ge r_0>t$, and $m\lt 10$ makes the output rates admissible. They also put $\lambda_*$ in this interval. The middle and outer interval argument of Theorem 11 now applies without changing the constant. Each inequality in (35) is strict and its left and right sides are continuous in $(q,\varepsilon)$ on the indicated domain. Equations (24), (27), (30), and (32) verify them at $(3/4,1/16)$, proving openness and nonemptiness. $\square$

No necessary-and-sufficient claim for general full-support service laws is made by (35).

## 8. Exact residual feasibility for lattice-geometric service

The mechanism behind the certificate admits a sharp characterization in the unmixed family $S=1+dG_q$.

**Theorem 13 (image of the residual map).** Let $d\ge1$, $0\lt q\lt 1$, and let $(w_n)_{n\ge0}$ be any probability mass function on $\mathbb N_0$. There exists $X\in\mathbb N_0$, independent of $S=1+dG_q$, such that $(X-S)^+$ has this law if and only if

$$
w_n\ge q w_{n+d}\quad(n\ge1),\qquad
q\sum_{n=1}^d w_n\le(1-q)w_0.                                   \tag{37}
$$

When these conditions hold, one can choose

$$
x_{n+1}=\frac{w_n-qw_{n+d}}{1-q}\quad(n\ge1),\qquad x_1=0,
\qquad x_0=1-\sum_{n\ge1}x_{n+1}.                               \tag{38}
$$

*Proof.* Necessity follows from (11) and (12) with $B=0$. Conversely, the proposed tail probabilities are nonnegative, and their total is

$$
\sum_{n\ge1}x_{n+1}
=1-w_0+\frac q{1-q}\sum_{n=1}^d w_n\le1.                         \tag{39}
$$

Thus (38) is a probability law. Its residual probability at $n\ge1$ is

$$
(1-q)\sum_{k\ge0}q^k x_{n+1+dk}
=\lim_{N\to\infty}\bigl(w_n-q^{N+1}w_{n+(N+1)d}\bigr)=w_n,
                                                                    \tag{40}
$$

because $0\le w_j\le1$. The zero mass agrees by normalization. The construction uses a product probability space to ensure independence. No finite-mean condition is required for this distributional theorem. $\square$

**Theorem 14 (sharp geometric-output boundary).** Set $S=1+dG_q$, let $r\in(0,1)$ satisfy $r^d\ge q$, and assume $\lambda=1-r\lt \mu$. Define

$$
\eta=q\sum_{j=1}^d r^j-(1-q+q^2).                                \tag{41}
$$

Then $\mathcal F_S(\lambda)=H(Q_\lambda)$, and

$$
\mathcal U_S(\lambda)=\mathcal F_S(\lambda)
\quad\Longleftrightarrow\quad\eta\le0.                           \tag{42}
$$

If $\eta>0$, there is the quantitative strict inequality

$$
\mathcal F_S(\lambda)-\mathcal U_S(\lambda)
\ge2\left(\frac{(1-r)\eta}{1+q^2}\right)^2.                       \tag{43}
$$

*Proof.* The unique waiting law yielding $Q_\lambda$ by independent convolution has generating function

$$
W(z)=\frac{1-r}{1-q}\frac{1-qz^d}{1-rz}.                         \tag{44}
$$

Indeed, the convolution equations are triangular with nonzero first service mass $1-q$, so they determine every waiting coefficient. With $c=(1-r)/(1-q)$, its coefficients are $w_n=cr^n$ for $0\le n\lt d$, and $w_n=cr^{n-d}(r^d-q)$ for $n\ge d$. They are nonnegative, sum to one, have finite mean, and satisfy the required waiting-cost equality. Thus full feedback attains the geometric entropy.

For $1\le n\lt d$, $w_n-qw_{n+d}=cr^n[1-q(r^d-q)]\ge0$; for $n\ge d$, it equals $w_n(1-qr^d)\ge0$. The prefix condition in (37) reduces exactly to $\eta\le0$. When it holds, Theorem 13 constructs a residual input with this waiting law; its cost is already the required finite value. Thus both suprema agree.

To handle $\eta>0$ without assuming attainment of the weak-feedback supremum, let $p$ be any residual output law. Convolution through degree $d+1$ gives

$$
w_n=\frac{p_{n+1}}{1-q}\ (0\le n\lt d),\qquad
w_d=\frac{p_{d+1}-qp_1}{1-q}.
$$

Its prefix inequality therefore implies

$$
(1-q+q^2)p_1-q\sum_{j=2}^{d+1}p_j\ge0.                           \tag{45}
$$

The finite function defining (45) has oscillation $1+q^2$, and its expectation under $Q_\lambda$ is $-(1-r)\eta$. Lemmas 2 and 3 prove (43), uniformly over the feasible class. This also proves the reverse implication in (42), including the distinction between nonattainment and a strict supremum gap. $\square$

For example, $d=2,q=1/2,r=9/10$ gives $m=3$, $\lambda=1/10$, and $\eta=21/200$. Equation (43) gives the exact certified entropy deficit

$$
\mathcal F_S(1/10)-\mathcal U_S(1/10)
\ge\frac{441}{3125000}=0.00014112.                               \tag{46}
$$

The corresponding rate-constrained capacity gap is at least $441/31250000$ nats per slot. This simpler periodic example alone does not establish a gap between capacities optimized over output rates; Theorem 11 supplies that stronger conclusion with full support. For $d=1$, (41) is negative because $qr\lt q\lt 1-q+q^2$, which is consistent with the geometric-service boundary.

## 9. Relation to the inspected literature and limitations

The timing-channel model and capacity interface (3) come from [1,2]. Theorem 3, equation (7), in the inspected arXiv version of [3] asserts equality of the residual and unrestricted entropy suprema for every unbounded service law, at every admissible rate, including its weak-feedback case $\tau=0$. Equations (22) and (29), together with full-feedback attainment in Theorem 9, contradict that assertion within its discrete-time model. The contradiction uses finite means, independent service copies, the original upper mean-cost constraint, and full positive-integer support. It does not depend on a failure of an optimizer to exist.

There is also a separately checkable issue in the discrete proof in [3, Section IV-F]: lower triangularity with diagonal $a>0$ does not force the smallest singular value to equal $a$. For $b>0$,

$$
\sigma_{\min}\begin{pmatrix}a&0\\b&a\end{pmatrix}
=\frac{\sqrt{b^2+4a^2}-b}{2}\lt a.                                  \tag{47}
$$

To verify (47), diagonalize the positive matrix $M^\mathsf TM$; its smaller eigenvalue is the square of the expression displayed. The strict inequality is equivalent to $\sqrt{b^2+4a^2}\lt b+2a$. This algebraic observation identifies a faulty implication but, on its own, would not disprove a theorem. The probability and entropy certificates above provide the independent counterexample.

The bounded-support results of [3] are outside the counterexample. The general conjecture concerning nonmemoryless service laws is not settled here. We do not determine $C^{WF}$ or $C$ exactly, optimize the gap constant, treat continuous service times, or characterize every parameter outside (35). The sharp statement (42) concerns the specified lattice family and its stated geometric-output domain, not general service distributions.

**Source-access boundary.** The author manuscripts of [2] and arXiv:2309.14145v2 were inspected. The formal journal metadata and author publication list were checked. The IEEE typeset full text of [3] was not obtained; the theorem-number and equation-specific correction in this manuscript is therefore tied to the inspected arXiv version. The scanned author-hosted copy of [1] and its bibliographic record are available; the particular operational interface is also explicitly stated in the inspected later author manuscripts. The literature search was bounded and does not establish worldwide priority or absence of an unpublished correction. No external peer review or machine-checked proof is claimed.

**Reproducibility.** The explicit service masses, polynomial identities, integer bounds (25), and gap comparison (32) admit exact rational or integer checks. Numerical evaluations of entropy, probability-generating-function coefficients, or capacity are supplementary diagnostics. The infinite-support conclusions follow from the analytic arguments (11), (19), and (40), rather than from truncated computation.

## References

1. V. Anantharam and S. Verdu, *Bits through queues*, IEEE Transactions on Information Theory **42**(1), 4-18 (1996). [DOI:10.1109/18.481773](https://doi.org/10.1109/18.481773). [Author-hosted scan](https://people.eecs.berkeley.edu/~ananth/1996-1998/Sergio/BTQ96.pdf).
2. L. Aptel and A. Tchamkerten, *Bits Through Queues With Feedback*, IEEE Transactions on Information Theory **66**(6), 3317-3326 (2020). [DOI:10.1109/TIT.2020.2970421](https://doi.org/10.1109/TIT.2020.2970421). [Inspected author manuscript, arXiv:1710.06190](https://arxiv.org/pdf/1710.06190). [Institutional publication record](https://researchportal.ip-paris.fr/fr/publications/bits-through-queues-with-feedback/).
3. K. R. Sahasranand and A. Tchamkerten, *Feedback Increases the Capacity of Queues with Bounded Service Times*, [arXiv:2309.14145v2, 30 June 2024](https://arxiv.org/abs/2309.14145v2), especially Theorem 3, equation (7), Section IV-F, and Section V. Journal record: IEEE Transactions on Information Theory **70**(10), 6823-6833 (2024), [DOI:10.1109/TIT.2024.3421909](https://doi.org/10.1109/TIT.2024.3421909). [Author publication list](https://www.tchamkerten.org/publications). The journal typeset theorem was not independently inspected.
