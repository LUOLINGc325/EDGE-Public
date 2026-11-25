# Exact erasure resilience with adaptively scheduled feedback

*Uniform finite-message laws and first-order optimal feedback communication*

25 November 2026

## Abstract

We determine the exact adversarial-erasure resilience of deterministic binary one-way communication with a prescribed number of adaptively scheduled feedback requests. The next request time depends only on already shared feedback, and every execution has the same total forward length. For every finite message count and every feedback budget, we give an explicit product formula and an optimal scheduling rule. The structural result removes every intermediate list-size constraint from the Bellman envelope: only lists of size two, size three, and the whole current alphabet matter. We prove the operational converse and a uniform positive-rate implementation. A second result preserves this exact finite-message frontier, with arbitrary fixed slack and without adding feedback requests, using only $\lceil\log_2 n\rceil+O_{r,\varepsilon}(1)$ feedback bits for $n$-bit messages. It follows from a general tail-compression principle and one use of a standard perfect-hash family. The Ramsey/Plotkin feedback lower-bound method of Gupta, Guruswami and Zhang applies under our explicit framing and timing rules, giving first-order optimality of that communication cost whenever the target resilience exceeds $1/2$.

For $r\ge1$ requests, the growing-message threshold is
$$
\rho_r=1-\left[\frac{12(r+1)}7+
\frac1{14}\prod_{j=2}^{r}\left(1-\frac4{3j}\right)\right]^{-1}.
$$
The finite-list coefficients, short simultaneous list codes, and adaptive recursive decomposition are due to Braverman, Efremenko, Kol, Saxena and Zhang [1]. The new claims concern their uniform explicit solution and preservation of the exact fixed-round frontier under short feedback. Neither hashing nor the Ramsey lower-bound mechanism is claimed as new. This AI-assisted manuscript has not undergone external peer review. Its written proofs and its unfinished Lean source checkpoint are separate evidence levels.

## 1. Model, attribution and main results

### 1.1. Timing and forward length

An encoder communicates one of $m\ge2$ messages. Forward symbols are bits, each of which an adversary may erase; unerased symbols are faithful. At most $r$ noiseless feedback requests are allowed. Initially, a request returns the entire received block since the previous request. Feedback length and computation time are uncharged in this first model.

The next forward blocklength is a deterministic function of previously shared feedback and public resources. It cannot privately depend on the message or on uncommunicated received symbols. All executions have a common total forward blocklength $L$. The contents of a block may depend on the message and shared feedback.

A privately selected public request time or message-dependent stopping time would create an extra noiseless channel. Those resources are excluded. Section 8 studies compressed feedback and charges all feedback tags and payloads.

Braverman et al. [1, Sections 1.3 and 2.1] discuss adaptive scheduling and leave a clean closed form open. Their formal Section 3.2 uses predetermined timings. We explicitly define the shared-feedback extension, rather than treating the nonadaptive definition as already adaptive.

For a protocol $P$, let $\mu(P)$ be the least number of erasures in a complete received transcript compatible with two distinct messages. The all-erased execution is common to all messages, so this quantity exists. Define
$A_r(m)=\sup_P\mu(P)/L$, allowing positive integer $L$ to vary. A consistency decoder corrects every pattern with fewer than $\mu(P)$ erasures. The threshold is a supremum with strict-slack semantics; $A_r(2)=1$ does not assert recovery after every forward bit is erased.

### 1.2. Finite-list coefficients and closed formula

Write
$$
b_{m,k}=\frac{\binom{\lfloor m/2\rfloor}{k}
+\binom{\lceil m/2\rceil}{k}}{\binom m k},
\qquad d(m,k)=1-b_{m,k},\quad 2\le k\le m. \tag{1}
$$
A binomial coefficient is zero when its lower argument exceeds its nonnegative integer upper argument. The coefficient $b_{m,k}$ is the unanimity probability of a fixed $k$-subset in a uniformly balanced binary column. These coefficients and their coding interpretation are prior work [1].

For $0\le c\le1/4$, put $H_0(c)=3c/(1+2c)$ and, for $r\ge1$,
$$
H_r(c)=
\begin{cases}
\dfrac{3c(1-3rc)}{1+2c},&3rc\le1,\\[5pt]
\left(1-\dfrac1{3rc}\right)H_{r-1}(c),&3rc\ge1 .
\end{cases} \tag{2}
$$
Both expressions equal zero at the boundary; the second branch has $c>0$. Define
$$
f_r(c)=\frac{1+3c}{3(r+1)+H_r(c)}. \tag{3}
$$
For $c>0$, let $p=\min(r,\lfloor1/(3c)\rfloor)$. The nonrecursive expression is
$$
H_r(c)=\frac{3c(1-3pc)}{1+2c}
\prod_{j=p+1}^{r}\left(1-\frac1{3jc}\right). \tag{4}
$$
Empty products equal one. If $1/(3c)$ is an integer at most $r$, the leading factor vanishes. At $c=0$, $f_r(0)=1/[3(r+1)]$.

**Theorem 1 (all finite message counts and feedback budgets).**
For every $r\ge0$, $A_r(2)=1$. For $h\ge2$, set $c_h=(h-2)/[2(2h-1)]$. Then
$$
\boxed{A_r(2h-1)=A_r(2h)=1-f_r(c_h).} \tag{5}
$$
Thus adjacent odd/even message counts form exact plateaus, and (3)--(4) leave no minimax optimization.

**Theorem 2 (full-envelope reduction and optimal timing).**
For every $m\ge3,r\ge1$, the Bellman envelope is unchanged at every first-block fraction $t\in[0,1]$ when all constraints except $k=2,3,m$ are removed. With $c=c_{\lceil m/2\rceil}$, $v=1/(3r)$ and $w=f_{r-1}(c)$, an optimal fraction is
$$
t_r(c)=
\begin{cases}
\dfrac1{1+r(1-c)},&c\le v,\\[6pt]
\dfrac{w-v}{c+w-v},&c>v.
\end{cases} \tag{6}
$$
After feedback, apply the same rule to the surviving alphabet and remaining length. The rule concerns real fractions; Section 6 proves integer implementation with controlled slack.

**Theorem 3 (growing-message threshold).**
With $r$ fixed and $m=2^n\to\infty$, the optimal threshold is $\rho_0=1/2$ and
$$
\boxed{\rho_r=1-\left[\frac{12(r+1)}7+
\frac1{14}\prod_{j=2}^{r}\left(1-\frac4{3j}\right)\right]^{-1}}
\quad(r\ge1). \tag{7}
$$
Every $\theta<\rho_r$ is achieved by deterministic protocols of length $O_{r,\theta}(n)$. For every $\theta>\rho_r$, sufficiently large message counts admit no such protocol, regardless of forward rate.

The structural increment is uniform domination of all intermediate constraints over both unbounded parameters. We also prove the exact fixed-round frontier remains attainable with asymptotically minimal feedback-bit complexity in Section 8. This problem concerns erasures; it does not settle the weighted maximum-cut conjecture for the bit-flip channel in [1].

## 2. Operational reduction to a finite minimax problem

For a code $C:[m]\to\{0,1\}^{\ell}$ and subset $S$, let $N_C(S)$ count coordinates where its codewords are not unanimous. Erasing those coordinates leaves every member of $S$ compatible.

**Lemma 4 (arbitrary-code converse).**
Every length-$\ell$ binary code contains a $k$-subset $S$ with $N_C(S)\le\ell d(m,k)$.

**Proof.** A column with $z$ zeros has unanimity probability
$[\binom z k+\binom{m-z}k]/\binom m k$ under a uniformly random $k$-subset. The numerator is minimized at a balanced split: the forward differences of $z\mapsto\binom z k$ are $\binom z{k-1}$, which are nondecreasing. Moving one unit from the larger argument to the smaller therefore cannot increase the sum. Average non-unanimity is at most $d(m,k)$ in each column. Sum over columns and choose a subset at most the average. This is the averaging mechanism of [1, Lemma 4.3].

**Lemma 5 (uniform simultaneous short codes).**
For every $\delta>0$, some finite $K_\delta$ works for every $m\ge2$ and every integer $\ell\ge K_\delta\log_2m$: there is a deterministic code satisfying
$$
N_C(S)\ge\ell\bigl(d(m,|S|)-\delta\bigr)
\quad\text{for every }|S|\ge2. \tag{8}
$$

**Proof.** Independently sample a uniformly balanced column at each coordinate. For a fixed $k$-subset, its non-unanimity indicators have mean $d(m,k)$. Hoeffding's inequality [2] bounds a downward deviation $\delta/2$ by $e^{-\delta^2\ell/2}$. Choose $k_0\ge2$ with $2^{1-k_0}\le\delta/2$. There are at most $k_0m^{k_0}$ relevant subsets of size at most $k_0$. Their union bound is below one if
$$
\ell>\frac2{\delta^2}\bigl(k_0\log m+\log k_0\bigr). \tag{9}
$$
Larger subsets contain a $k_0$-subset and have at least as many non-unanimous coordinates. The bound $d(m,k_0)\ge1-2^{1-k_0}$ proved next gives non-unanimity at least $1-\delta\ge d(m,|S|)-\delta$. A sufficiently large $K_\delta$ makes (9) hold for every stated integer length. Fix one successful code. No efficient codebook search is asserted. This is a uniform-length version of [1, Lemma 4.4].

For $h=\lceil m/2\rceil$, cancellation in (1) gives
$$
b_{m,k}=\frac{2\binom h k}{\binom{2h}k}
=\prod_{j=1}^{k-1}\frac{h-j}{2h-j}\quad(k\le h),
\qquad b_{m,k}=0\quad(k>h). \tag{10}
$$
For odd $m=2h-1$, use
$\binom{h-1}k=(h-k)\binom h k/h$ and
$\binom{2h-1}k=(2h-k)\binom{2h}k/(2h)$.
Each product factor is at most $1/2$, proving $b_{m,k}\le2^{1-k}$.

Define
$$
B_0(m)=d(m,2),\qquad
B_r(m)=\max_{0\le t\le1}\min_{2\le k\le m}
\{t d(m,k)+(1-t)B_{r-1}(k)\}. \tag{11}
$$
The envelope is continuous and 1-Lipschitz; its maximum is attained. Its coefficients and an optimal fraction can be rational. This observation alone is only a finite recursion, not the desired explicit law.

**Lemma 6 (finite-length converse).**
Every admissible protocol satisfies
$$
\mu(P)\le LB_r(m). \tag{12}
$$

**Proof.** Induct on $r$. Without feedback use Lemma 4 with $k=2$. Otherwise the first block has fixed length $\ell$, independent of the private message. For each $k$, Lemma 4 gives a $k$-subset with a common received block after at most $\ell d(m,k)$ erasures. Restrict the continuation to this subset. It has common remaining length $L-\ell$ and at most $r-1$ requests, although it may depend on the entire shared received transcript. The first transcript may leave additional messages possible; restriction to the chosen subset is nevertheless a valid protocol and enough for a converse. Induction supplies two messages with a common continuation using at most $(L-\ell)B_{r-1}(k)$ more erasures. Thus
$\mu(P)\le\ell d(m,k)+(L-\ell)B_{r-1}(k)$ for every $k$, potentially under different adversarial transcripts. Minimize over $k$ and apply (11) at $t=\ell/L$. Zero-length blocks may be deleted; a zero-length continuation has ambiguity radius zero. Fewer than $r$ requests are covered.

Section 6 supplies the matching lower bound uniformly in $m$.

## 3. Correction-function regularity

Put $a_r(m)=1-B_r(m)$. Complementing (11) yields
$$
a_0(m)=b_{m,2},\qquad
a_r(m)=\min_{0\le t\le1}\max_{2\le k\le m}
\{b_{m,k}t+a_{r-1}(k)(1-t)\}. \tag{13}
$$
The candidate functions (2)--(3) were defined independently of this recurrence, preventing circular assumptions about active constraints.

**Lemma 7 (bounds and regularity).**
Each $H_s$ is continuous and piecewise continuously differentiable with finitely many breakpoints on $[0,1/4]$, and
$$
0\le H_s(c)\le\frac{3c}{1+2c}\le\frac12,
\qquad |H_s'(c)|\le3 \tag{14}
$$
where the derivative exists.

**Proof.** Both the early multiplier $1-3sc$ and late multiplier $1-1/(3sc)$ belong to $[0,1]$ on their respective branches; induction proves the value bounds. At stage zero,
$H_0'=3/(1+2c)^2\in[0,3]$. For $s\ge1$ on an early branch,
$$
H_s'(c)=\frac{3(1-6sc-6sc^2)}{(1+2c)^2},
\qquad
H_s''(c)=-\frac{6(3s+2)}{(1+2c)^3}<0.
$$
The derivative decreases from $3$ to $-3/(1+2/(3s))>-3$ at $c=1/(3s)$. Truncating at $1/4$ only narrows this range. On a late branch put $q=1-1/(3sc)\in[0,1]$. Then
$H_s'=qH_{s-1}'+H_{s-1}/(3sc^2)$. Its lower bound is $-3q\ge-3$. Using $H_{s-1}\le3c$, its upper bound is $3q+1/(sc)=3$. The new branches meet at zero, and inherited breakpoints preserve continuity. Finitely many smooth pieces with bounded one-sided derivatives imply absolute continuity, justifying integration across transitions.

**Lemma 8 (factor-two slope band).**
For every $s\ge0$ there are positive constants satisfying
$$
\lambda_s\le f_s'(c)\le\Lambda_s\le2\lambda_s \tag{15}
$$
at differentiable points. In particular $f_s$ is strictly increasing.

**Proof.** Directly $f_0(c)=(1+2c)/3$. For $s=1$ the whole parameter interval is early, and
$f_1(c)=(1+2c)/[3(2-c)]$, $f_1'(c)=5/[3(2-c)^2]$; the largest-to-smallest derivative ratio is $64/49<2$. For $s\ge2$, write $n=s+1\ge3$. Differentiation gives
$$
f_s'(c)=\frac{9n+3H_s(c)-(1+3c)H_s'(c)}{(3n+H_s(c))^2}.
$$
Lemma 7 and $1+3c\le7/4$ permit
$$
\lambda_s=\frac{9n-21/4}{(3n+1/2)^2},
\qquad \Lambda_s=\frac{9n+27/4}{9n^2}. \tag{16}
$$
After multiplying positive denominators, $\Lambda_s\le2\lambda_s$ is equivalent to
$144n^3-324n^2-40n-3\ge0$. At $n=3+j$ this polynomial is
$144j^3+972j^2+1904j+849>0$ for $j\ge0$.

**Corollary 9 (chord comparison).**
For $0\le e\le c\le1/4$, $c>0$,
$$
\frac{f_s(c)-f_s(e)}{f_s(c)-f_s(0)}
\ge\frac{c-e}{2c}. \tag{17}
$$
Integrate (15): the numerator is at least $\lambda_s(c-e)$, while the positive denominator is at most $\Lambda_sc\le2\lambda_sc$. Global convexity is not assumed; derivatives can jump downward at a transition.

## 4. Domination of every intermediate list size

Equation (10) implies
$$
b_{2h-1,k}=b_{2h,k},\qquad
b_{m,2}=\frac{h-1}{2h-1}=\frac{1+2c_h}{3},\qquad
b_{m,3}=c_h. \tag{18}
$$
The coefficient is nonincreasing in $k$.

**Lemma 10 (balanced-binomial comparison).**
For every odd $5\le k\le m$, with $h=\lceil m/2\rceil$,
$$
2b_{m,k}\le c_h-c_{\lceil k/2\rceil}. \tag{19}
$$

**Proof.** For $k=5$, if $h\le4$ the binomial term vanishes. For $h\ge5$,
$$
b_{m,5}=\frac{(h-3)(h-4)}{4(2h-1)(2h-3)},\qquad
c_h-c_3=\frac{3(h-3)}{10(2h-1)}.
$$
The desired inequality reduces to $5(h-4)\le3(2h-3)$. For the step from odd $k=2\ell-1\ge5$ to $k+2$, the new term is zero if $k+2>h$. Otherwise
$$
\frac{b_{m,k+2}}{b_{m,k}}
=\frac{(h-k)(h-k-1)}{(2h-k)(2h-k-1)}\le\frac14,
$$
whereas
$$
\frac{c_h-c_{\ell+1}}{c_h-c_\ell}
=\frac{h-\ell-1}{h-\ell}\frac{2\ell-1}{2\ell+1}\ge\frac14.
$$
Indeed $h\ge2\ell+1$ and $\ell\ge3$ make each factor at least $1/2$. The binomial term decays at least as fast as the positive gap, completing induction.

**Lemma 11 (full-envelope domination).**
If continuation deficits equal $f_s(c_{\lceil k/2\rceil})$ for $k\ge3$, and zero for $k=2$, all constraints other than $2,3,m$ are redundant for every $t\in[0,1]$.

**Proof.** For $m\ge5$ set $c=c_{\lceil m/2\rceil}>0$. For odd $k\ge5$, put $e=c_{\lceil k/2\rceil}\le c$. Combining (17) and (19) gives
$$
f_s(e)\le\frac{b_{m,k}}c f_s(0)
+\left(1-\frac{b_{m,k}}c\right)f_s(c). \tag{20}
$$
The coefficient $b_{m,k}/c$ lies in $[0,1]$. Multiplying by $1-t$ and adding $b_{m,k}t$ bounds the $k$-line by a convex combination of the lines
$ct+f_s(0)(1-t)$ and $f_s(c)(1-t)$. It is therefore at most their maximum. The $k=3$ line remains. Each even $k\ge4$ is dominated by $k-1$: their continuation parameters agree and $b_{m,k}\le b_{m,k-1}$. For $m=3,4$, $c=0$ and no other odd intermediate constraint exists. This also handles the possibly duplicated final constraint for even $m$.

## 5. Optimal schedules and explicit product

For $r\ge1$, write $B=(1+2c)/3$, $D=(1-c)/3=B-c$,
$v=1/(3r)$ and $w=f_{r-1}(c)$. Lemma 11 reduces (13) to the maximum of
$$
L_2(t)=Bt,\qquad L_3(t)=ct+v(1-t),\qquad L_m(t)=w(1-t). \tag{21}
$$

### 5.1. Early regime

If $c\le v$, the preceding stage is also early, or is stage zero.
Substitution gives $w=B/[1+3(r-1)D]$. Intersecting $L_2,L_3$ yields
$t=v/(D+v)=1/[1+r(1-c)]$ and common value
$$
\frac{1+2c}{3\{1+r(1-c)\}}=f_r(c). \tag{22}
$$
At that point $L_m\le L_2$ because $wD\le Bv$, equivalent to $3D\le1$.
The first line is increasing and the second nonincreasing, so their intersection minimizes their maximum. Including the third line leaves the optimum unchanged.

### 5.2. Late regime

If $c\ge v$, the value bounds give
$$
v\le w\le\frac{1+3c}{3r}. \tag{23}
$$
For the lower bound, positive-denominator multiplication reduces the claim to
$H_{r-1}(c)\le9rc$, which follows from $H_{r-1}(c)\le3c$ and $r\ge1$.
The intersection of $L_3,L_m$ is
$$
t=\frac{w-v}{c+w-v},\qquad L_3(t)=L_m(t)=\frac{cw}{c+w-v}. \tag{24}
$$
Its denominator is positive since $c\ge v>0$. The omitted line is no larger there because
$$
wD\le\frac{(1+3c)(1-c)}{9r}
\le\frac{1+2c}{9r}=Bv. \tag{25}
$$
The last step is $-3c^2\le0$. Now $L_3$ is nondecreasing and $L_m$ decreasing, so the intersection minimizes their maximum. The late recurrence implies
$$
\frac1{f_r(c)}
=\left(1-\frac1{3rc}\right)\frac1{f_{r-1}(c)}+\frac1c,
$$
which identifies (24) with $f_r(c)$. At $c=v$, the middle line is constant and both intersections can be optimal; (6) selects the early one.

### 5.3. Induction

At stage zero, $a_0(m)=f_0(c_h)$ by (18). Assuming the preceding-stage formula, Lemma 11 removes intermediate constraints and the two regimes evaluate the remainder. For $m=2$, both coefficients and deficits are zero. Thus $a_r(2h-1)=a_r(2h)=f_r(c_h)$ for every stage. For (4), stages up to $p=\min(r,\lfloor1/(3c)\rfloor)$ use the early expression and later stages multiply by $1-1/(3jc)$. This proves the finite product, including reciprocal-integer transition points, without finite-grid extrapolation.

## 6. Integer lengths and uniform positive rate

**Theorem 12 (uniform finite-length achievability).**
For fixed $r\ge0$ and $\varepsilon>0$, there is a finite $C_{r,\varepsilon}$ such that every $m\ge2$ and every integer $L\ge C_{r,\varepsilon}\log_2m$ admit an admissible deterministic protocol with
$$
\mu(P)\ge L(B_r(m)-\varepsilon). \tag{26}
$$

**Proof.** It suffices to consider $0<\varepsilon<1$. Choose $\delta>0$ and $0<\alpha<1/2$. At a shared state with $q\ge2$ candidates, $N$ remaining symbols and $s\ge1$ requests, clamp an optimal real fraction into $[\alpha,1-\alpha]$ and use $\ell=\lfloor tN\rfloor$ symbols. Apply a Lemma 5 code on the canonically ordered candidates. After feedback recurse on the actual surviving set. At zero remaining requests use a final code; at a singleton pad with a fixed symbol. Every branch has length $L$.

Provided all blocks meet the short-code length condition, induction proves
$$
\mu(P_{s,q,N})\ge N(B_s(q)-\delta-s\alpha)-s. \tag{27}
$$
The zero-stage case uses a compatible pair. For an ambiguous later execution, the first surviving set has some $k\ge2$, requiring at least $\ell(d(q,k)-\delta)$ erasures. The continuation requires at least
$(N-\ell)(B_{s-1}(k)-\delta-(s-1)\alpha)-(s-1)$ by induction.
The first-length fraction differs from an optimizer by at most $\alpha+1/N$. The 1-Lipschitz envelope loses at most that amount. Adding the two erasure costs yields (27); the code errors are length-weighted, not incorrectly added once per stage.

Set $\lambda=\alpha/2$. If $N\ge2/\alpha$, then both $\ell$ and $N-\ell$ are at least $\lambda N$. Every coded block over at most $r$ requests is therefore at least $\lambda^rL$, and candidate counts never exceed $m$. It suffices that
$$
\lambda^rL\ge\max\{K_\delta\log_2m,2/\alpha\}. \tag{28}
$$
Take $\delta=\varepsilon/4$, $\alpha=\varepsilon/[4(r+1)]$, and $L\ge2r/\varepsilon$. The proportional loss is below $\varepsilon/2$ and the additive loss contributes at most another $\varepsilon/2$. Since $\log_2m\ge1$, one finite constant works for every $m$.

Together with Lemma 6, this proves $A_r(m)=B_r(m)$ and Theorem 1. Uniformity in $m$, rather than merely scaling a fixed finite codebook, is what supplies positive rate. The rate constant is not optimized and may deteriorate rapidly with $r$ and small slack.

## 7. Growing messages and the adaptivity gain

As $m\to\infty$, $c_{\lceil m/2\rceil}\to1/4$. Lemma 7 and the positive denominator imply $\lim_m A_r(m)=1-f_r(1/4)$. For $r\ge1$, $p=1$ in (4), so
$$
H_r(1/4)=\frac18P_r,\qquad
P_r=\prod_{j=2}^{r}\left(1-\frac4{3j}\right)>0.
$$
This proves (7). There is no exchange of an infinite optimization and a limit.

Restricting a protocol to a subset shows $A_r(m)$ is nonincreasing in $m$, hence $A_r(2^n)\ge\rho_r$. For $\theta<\rho_r$, choose slack smaller than $\rho_r-\theta$ in Theorem 12 and $L=O(n)$. Conversely, for $\theta>\rho_r$ and large $n$, $A_r(2^n)<\theta$; the finite-length converse supplies a confusing transcript within the budget. This proves Theorem 3.

The predetermined-feedback optimum in [1] is $5/7$ for $r=1$ and
$$
\rho_r^{\mathrm{fixed}}=1-\frac7{12(r+1)}\quad(r\ge2). \tag{29}
$$
With $x_r=12(r+1)/7$, the exact gain for $r\ge2$ is
$$
\rho_r-\rho_r^{\mathrm{fixed}}
=\frac{P_r}{14x_r(x_r+P_r/14)}>0. \tag{30}
$$
The standard gamma identities [3] give
$P_r=\Gamma(r-1/3)/[\Gamma(2/3)\Gamma(r+1)]
\sim r^{-4/3}/\Gamma(2/3)$, hence
$$
\boxed{\rho_r-\rho_r^{\mathrm{fixed}}
\sim\frac7{288\Gamma(2/3)}\,r^{-10/3}.} \tag{31}
$$
The improvement is strict but vanishing. These limits first let message size grow for each fixed $r$, then examine the resulting sequence as $r$ grows; they do not prove a uniform positive rate for increasing $r$.

## 8. Feedback compression at the exact fixed-round frontier

### 8.1. Counted packets and the finite-message theorem

Feedback now consists of compressed packets selected by the receiver. At each shared state the admissible packets are prefix-free. All tags, indices, payloads and termination information count toward feedback cost. The next forward blocklength depends only on completely parsed prior feedback and public resources, not on the private message or uncommunicated received symbols. The total forward length remains $L$ on every branch. Full-transcript feedback can simulate these compressed decisions, so the preceding converse remains valid.

**Theorem 13 (compression preserving the finite-message frontier).**
For fixed $r\ge0$ and $\varepsilon>0$, finite constants $C_{r,\varepsilon},D_{r,\varepsilon}$ exist such that every $m\ge2$ and integer $L\ge C_{r,\varepsilon}\log_2m$ admit a deterministic protocol with at most $r$ requests, correcting all patterns of at most $(A_r(m)-\varepsilon)L$ erasures, and with worst-case total feedback
$$
B\le\lceil\log_2\log_2m\rceil+D_{r,\varepsilon}. \tag{32}
$$
The statement controls rounds, feedback bits, forward length and finite-message resilience simultaneously. Public codebooks and hash families are fixed before the input; no runtime randomness or efficient construction is asserted.

### 8.2. Perfect hashes and a general compression principle

**Perfect-hash lemma.** For $m\ge2$, $K\ge2$ and $Q=K^2$, there is a family of maps $[m]\to[Q]$ such that every nonempty subset of size at most $K$ is injected by at least one member. The family may have size
$$
T=\lceil K\log_2m+\log_2K\rceil+1. \tag{33}
$$

**Proof.** For a uniformly random map, a fixed $k$-subset with $k\le K$ has a collision with probability at most $\binom k2/K^2<1/2$. For $T$ independent maps, simultaneous failure on that subset has probability at most $2^{-T}$. There are at most $Km^K$ relevant subsets and $Km^K2^{-T}\le1/2$. Fix a successful family. Its index length $b=\lceil\log_2T\rceil$ obeys
$$
b\le\lceil\log_2\log_2m\rceil+
\lceil\log_2(K+\log_2K+2)\rceil, \tag{34}
$$
because $T\le(K+\log_2K+2)\log_2m$. This is a standard elementary hashing argument, not a new primitive.

For a reusable statement, fix any finite forward alphabet with at least two symbols, and a pure erasure channel. Suppose $d(q,k)\in[0,1]$, $d(q,q)=1$, and for every $\delta>0$ a constant $K_\delta$ gives simultaneous codes at every integer length $\ell\ge K_\delta\log_2q$, satisfying
$N_C(S)\ge\ell(d(q,|S|)-\delta)$ for all subsets of size at least two. Assume also
$$
\tau(K)=\sup_{q\ge k>K}(1-d(q,k))\longrightarrow0. \tag{35}
$$
Define purely mathematical values
$$
V_0(q)=d(q,2),\qquad
V_s(q)=\max_{0\le t\le1}\min_{2\le k\le q}
\{td(q,k)+(1-t)V_{s-1}(k)\}. \tag{36}
$$

**Tail-compression lemma.** Under these assumptions, Theorem 13 holds with $V_r(m)$ in place of $A_r(m)$. This is achievability of the defined Bellman value, without assuming it is an operational optimum. If, additionally, every length-$\ell$ code on $q$ messages has for each $2\le k\le q$ a $k$-subset $S$ with $N_C(S)\le\ell d(q,k)$, the converse induction of Section 2 identifies $V_r(m)$ with the unrestricted-feedback optimum. This additional condition is required only for the optimality identification.

### 8.3. Proof of compression

The shared state is an ordered working alphabet $U$ of size $q$, remaining forward length $N$, and request budget $s$. Alice holds its true label $u$. Bob maintains an injective dictionary $\phi:U\to[m]$ with $\phi(u)$ equal to the original message. Initially $U=[m]$ and $\phi$ is the identity. After compression Alice need not know the inverse dictionary.

For $s\ge1,q\ge2$, choose an optimizer in (36), clamp it into $[\alpha,1-\alpha]$, and transmit a simultaneous code of length $\ell=\lfloor tN\rfloor$. Bob computes the labels $\Gamma\subseteq U$ consistent with this block. The true label belongs to $\Gamma$.

If $q>K$ and $|\Gamma|>K$, Bob sends the one-bit packet $0$. Both parties retain $U$; Bob forgets this block's exclusions. This is a reset to the same current alphabet.

If $q>K$ and $1\le|\Gamma|\le K$, Bob selects a hash injective on $\Gamma$ and sends $1$, its fixed $b$-bit index, and a $Q$-bit mask of the image $h(\Gamma)$. Both parties set $U'=h(\Gamma)$ in a public order. Alice computes $h(u)$; Bob defines $\phi'(h(v))=\phi(v)$ for $v\in\Gamma$. Injectivity makes the dictionary well defined. Collisions outside $\Gamma$ are harmless. The image mask is necessary and explicitly charged.

If $q\le K$, Bob sends the $q$-bit mask of $\Gamma$ and restricts the alphabet and dictionary. The working alphabet never increases. At a shared singleton, pad the remaining forward length. Before the first hash all large-state packets are resets, so the hash family's universe is still the original $[m]$. After that hash the alphabet remains at most $K$. Thus at most one nonconstant-size seed is sent.

Large-state packets are prefix-free: $0$ is complete, whereas $1$ fixes the length of the remaining index and mask. Small-state packet lengths are fixed by the public alphabet size. No hidden list size chooses a future request time.

We induct on actual decoding error, because reset intentionally forgets information. Set $\eta=\delta+\tau(K)$. Assuming all required codes have sufficient length, every error requires at least
$$
N(V_s(q)-\eta-s\alpha)-s \tag{37}
$$
erasures. At $s=0$, a wrong output implies at least two consistent labels, so the code costs at least $N(d(q,2)-\delta)\ge N(V_0(q)-\eta)$. A singleton cannot err.

For $s\ge1$, on a small-list branch of size $k\ge2$, the first block costs at least $\ell(d(q,k)-\eta)$. Injective relabeling preserves the true input, so a wrong original output requires a wrong $k$-state continuation, which by induction costs at least
$(N-\ell)(V_{s-1}(k)-\eta-(s-1)\alpha)-(s-1)$.
The case $k=1$ cannot err.

On a reset branch, $|\Gamma|>K$ forces at least $\ell(1-\eta)$ erasures by (35). The continuation uses the original public $q$ labels. This corresponds exactly to the $k=q$ affine branch in (36), since $d(q,q)=1$. It does not approximate $V_{s-1}(k)$ by a large-message limit.

With $u_0=\ell/N$, both cases therefore cost at least
$$
N\{u_0d(q,k)+(1-u_0)V_{s-1}(k)-\eta-(s-1)\alpha\}-(s-1),
$$
using $k=q$ for reset. Since every coefficient and continuation value lies in $[0,1]$, clamping and rounding lose at most $\alpha+1/N$ in the 1-Lipschitz envelope. This proves (37). The induction covers every true label in the full working alphabet, including labels Bob had temporarily excluded before a reset.

Put $\lambda=\alpha/2$. As in Section 6, every actual coded block has length at least $\lambda^rL$ once all intermediate lengths exceed $2/\alpha$. Since $q\le m$, it suffices that
$$
\lambda^rL\ge\max\{K_\delta\log_2m,2/\alpha\}. \tag{38}
$$
For $0<\varepsilon<1$, take $\delta=\varepsilon/16$, choose $K\ge2$ with $\tau(K)\le\varepsilon/16$, and set $\alpha=\varepsilon/[8(r+1)]$. Then $\eta+r\alpha<\varepsilon/4$. Also require $L\ge4r/\varepsilon$. Formula (37) puts every error above the promised $(V_r(m)-\varepsilon)L$ budget, with margin at least $\varepsilon L/2$. All conditions fit a uniform $C_{r,\varepsilon}\log_2m$ lower bound on length. Larger $\varepsilon$ are covered by using a smaller parameter.

If the unique hash is sent at request $j$, total feedback is at most
$$
(j-1)+(1+b+K^2)+(r-j)K\le b+K^2+rK. \tag{39}
$$
With no hash, or initially small $m$, the cost is lower. Combining with (34) proves the generic lemma. In the binary setting, (10) gives $\tau(K)\le2^{-K}$, Lemma 5 gives the simultaneous codes, and $d(q,q)=1$. Taking
$K=\max\{2,\lceil\log_2(16/\varepsilon)\rceil\}$ and using $V_r=B_r=A_r$ proves Theorem 13.

### 8.4. Lower bound and first-order optimality

The following Ramsey/Plotkin method is due to Gupta, Guruswami and Zhang [4, Theorem 6.1 and Lemma 6.2]. Its quantitative inequality already implies the logarithmic lower bound with leading coefficient one. We check its validity for shared-feedback-determined scheduling and counted prefix-free packets.

**Theorem 14 (counted feedback-tree lower bound).**
Fix $1/2<\theta<1$. Suppose a deterministic protocol with a binary forward alphabet communicates one of $m=2^n$ messages, has common forward length $L$, corrects every pattern of at most $\theta L$ erasures, and uses at most $B$ feedback bits on every execution under the timing and packet rules above. For sufficiently large $n$,
$$
B\ge\log_2n-\log_2\log_2n-\log_2q_\theta,\qquad
q_\theta=\left\lceil\frac1{2\delta}\right\rceil+2,\quad
\delta=\frac{\theta-1/2}{2}. \tag{40}
$$
No positive-rate hypothesis is required.

**Proof.** Complete feedback histories are prefix-free. Request slots can be padded by deterministic empty packets; termination information is already shared or counted. A binary prefix tree of depth at most $B$ has at most $F=2^B$ leaves.

For each complete history $f$, force Alice to receive it. Previous feedback fixes all future block boundaries, giving a length-$L$ word $C_f(x)$ for every message $x$. Extend the encoder arbitrarily on input/history pairs that are unreachable. Fill unused history indices with arbitrary words.

Color each message pair $\{x,y\}$ by some $f$ with
$d_H(C_f(x),C_f(y))\ge(1/2+\delta)L$.
Every pair has such an index. Otherwise an online adversary compares the two hypothetical encoders and erases exactly the positions where their prescribed bits differ. Common received history generates common feedback, which fixes common subsequent boundaries. The actual history $f$ is produced by this process; it need not be guessed beforehand. Total erasures equal
$d_H(C_f(x),C_f(y))<(1/2+\delta)L<\theta L$,
leaving the pair indistinguishable. This contradicts correction and avoids integer-budget endpoint issues.

There is no monochromatic $q_\theta$-clique. For $q_\theta$ binary words, each coordinate contributes at most $q_\theta^2/4$ to their total pairwise distance. Such a clique would imply
$\binom{q_\theta}{2}(1/2+\delta)L\le q_\theta^2L/4$, or
$2\delta(q_\theta-1)\le1$, contrary to the choice of $q_\theta$.

For $F\ge2$, an elementary multicolor Ramsey estimate says that $F^{q_\theta F}$ vertices force a monochromatic $q_\theta$-clique. To see this, repeatedly select a vertex and retain its largest same-color neighborhood. The recurrence $N_{i+1}\ge(N_i-1)/F$ allows
$t=F(q_\theta-1)+1\le q_\theta F$ selections. Every earlier selected vertex has one color on all its edges to later selections. Among the first $t-1$, at least $q_\theta-1$ share that outgoing color; adjoining the final vertex produces the clique. Consequently
$$
2^n<F^{q_\theta F},\qquad n<q_\theta B2^B. \tag{41}
$$
If $B\ge\log_2n$, (40) already holds. Otherwise take logarithms and use
$\log_2B<\log_2\log_2n$. With $B=0$, the Plotkin argument bounds the number of messages below $q_\theta$, excluded for large $n$.

**Corollary (first-order optimal feedback cost).**
Fix $r\ge1$ and $0<\varepsilon<\rho_r-1/2$. Among protocols with at most $r$ requests, forward length $O_{r,\varepsilon}(n)$ and resilience at least $\rho_r-\varepsilon$, the minimum worst-case feedback satisfies
$$
\frac{B_{\min}(n)}{\log_2n}\longrightarrow1. \tag{42}
$$
The upper bound is Theorem 13 with $A_r(2^n)\ge\rho_r$; the lower bound is Theorem 14. The upper theorem actually preserves each finite-message threshold with fixed slack. For targets at or below $1/2$, this logarithmic lower bound need not hold.

Packet framing and the timing restriction are essential. Free packet lengths, silence or privately chosen waiting times would invalidate the $2^B$ history count. All informative tags and payloads are charged here. The joint frontier, not a new hashing or Ramsey principle, is the contribution.

## 9. Exact finite checks

Independent rational implementations evaluate the full Bellman envelope and the nonrecursive product. The retained grid checks 819 states with $2\le m\le64$, $0\le r\le12$, including 756 positive-feedback schedules. All agree. Testing 3,696 reduced-envelope breakpoints checks domination on every intervening affine segment. A separate pairwise-crossing solver checks 104 small states without the convex-envelope algorithm; 22,052 balanced-binomial instances are also checked. All are finite consistency evidence, not substitutes for the universal proof.

The tail-reset implementation additionally checks 2,268 rational states at cutoffs $K=2,4,8$ under the original optimal schedule. The observed scalar loss is always between zero and $2^{-K}$. This checks the abstract reset guarantee, not the existence or efficient implementation of every codebook.

| Messages | No feedback | One request | Two requests | Three requests |
|---|---:|---:|---:|---:|
| $2$ | $0$ | $0$ | $0$ | $0$ |
| $3,4$ | $1/3$ | $1/6$ | $1/9$ | $1/12$ |
| $5,6$ | $2/5$ | $4/19$ | $1/7$ | $4/37$ |
| $7,8$ | $3/7$ | $3/13$ | $3/19$ | $27/227$ |
| $9,10$ | $4/9$ | $8/33$ | $1/6$ | $1/8$ |
| $m\to\infty$ | $1/2$ | $2/7$ | $6/31$ | $378/2597$ |

Entries are deficits $1-A_r(m)$. For example, $\rho_2=25/31$, while the predetermined value is $29/36$, a difference of $1/1116$. At $m=9,10,r=2$, the optimal timing interval is $[5/16,3/8]$, illustrating the tie convention in (6).

## 10. Attribution and limits

The finite-list coefficients, simultaneous short codes, adaptive recursive reduction and predetermined-round law are due to [1]. The all-list domination proof supplies the explicit adaptive law. Gupta, Guruswami and Zhang [4] already obtain logarithmic feedback and slack-dependent constant-round erasure coding; their scheme already has a large-list retry stage followed by a small-list identification stage. Their Ramsey proof also contains the quantitative lower bound used here. The separate contribution of Section 8 is the preservation of the exact prescribed-round, finite-message Bellman frontier. The standard perfect-hash improvement and leading feedback coefficient are not presented as separate new primitives.

Joshi et al. [5] study efficient list decoding against causal symbol flips; Agrawal et al. [6] study interactive duration and speaking-order adaptivity; Balasundaram and Jagannathan [7] study unknown stochastic erasure channels. Their models differ from ours. The literature comparison is bounded to the versions and sections in the source records and is not a worldwide priority certificate.

The results are information-theoretic. No efficient codebook search, polynomial-time encoder, exact endpoint correction, privately selected timing channel, bit-flip analogue, or uniform rate for growing $r$ is proved. Randomized runtime protocols are outside the deterministic model. The full paper has not been checked by Lean. Source modules and remaining obligations are retained with their actual compilation status.

## References

1. M. Braverman, K. Efremenko, G. Kol, R. R. Saxena and Z. Zhang. *Round-Vs-Resilience Tradeoffs for Binary Feedback Channels*. ITCS 2025, LIPIcs 325, 22:1--22:23. [doi:10.4230/LIPIcs.ITCS.2025.22](https://doi.org/10.4230/LIPIcs.ITCS.2025.22). [Full ECCC TR22-179, Revision 1, 26 November 2024](https://eccc.weizmann.ac.il/report/2022/179/revision/1/download/).
2. W. Hoeffding. *Probability Inequalities for Sums of Bounded Random Variables*. JASA 58(301), 13--30 (1963). [doi:10.1080/01621459.1963.10500830](https://doi.org/10.1080/01621459.1963.10500830).
3. NIST Digital Library of Mathematical Functions. Gamma recurrence and asymptotic ratios, [5.5.1](https://dlmf.nist.gov/5.5#E1) and [5.11.12](https://dlmf.nist.gov/5.11#E12).
4. M. Gupta, V. Guruswami and R. Y. Zhang. *Binary Error-Correcting Codes with Minimal Noiseless Feedback*. [arXiv:2212.05673v2](https://arxiv.org/abs/2212.05673v2); IEEE Transactions on Information Theory 71(5), 3424--3446 (2025), [doi:10.1109/TIT.2025.3545097](https://doi.org/10.1109/TIT.2025.3545097). Technical comparisons use the retrieved preprint, especially Sections 3.4, 4 and 6.1.
5. P. Joshi, D. McMorrow, Y. Zhang, A. J. Budkuley and S. Jaggi. *Efficient and rate-optimal list-decoding in the presence of minimal feedback*. [arXiv:2511.04088v4](https://arxiv.org/abs/2511.04088v4), 17 November 2026.
6. S. Agrawal, R. Gelles and A. Sahai. *Adaptive Protocols for Interactive Communication*. [arXiv:1312.4182v3](https://arxiv.org/abs/1312.4182v3), 7 August 2015.
7. H. Balasundaram and K. Jagannathan. *Learning to Transmit Over Unknown Erasure Channels with Empirical Erasure Rate Feedback*. [arXiv:2507.08599v3](https://arxiv.org/abs/2507.08599v3), 30 August 2026.
