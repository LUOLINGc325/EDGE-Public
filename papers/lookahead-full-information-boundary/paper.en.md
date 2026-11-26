# When Is LookAhead Globally Optimal? An Exact Boundary for Affine Age Costs

**Research manuscript, 25 November 2026.** This manuscript contains a written proof for the model stated below. It has not undergone external peer review. Machine-checked formalization is a separate delivery and is not claimed here.

## Abstract

Consider a stable two-class preemptive queue with independent Poisson arrivals and exponential service requirements. A class-1 job of system age $a$ incurs instantaneous cost $a_0+ba$, with $b>0$, whereas a class-2 job incurs a constant cost $c_2$. The published LookAhead rule is optimal among nondecreasing per-job index policies. We determine exactly when it is optimal among all nonanticipating work-conserving policies observing the entire queue and service history. The condition is $\mu_1[a_0+b/(\mu_1-\lambda_1)]\ge\mu_2c_2$: precisely the region where LookAhead becomes strict class-1 priority. A polynomial observable-state potential verifies this region against every service action and every history-dependent policy, including non-FCFS actions. Outside it, a finite marked-cohort exchange yields a strict improvement. The exchange uses only service information already revealed by an early service prefix and restores the complete coupled queue state after a finite compensation interval. A finite-backlog error bound, an explicit positive-probability trigger, and regeneration give a strictly positive, effectively certifiable long-run gain at every remaining parameter point. The exchange also shows that every positive age-threshold rule is suboptimal in this affine model. The gain certificate is deliberately conservative; the optimal policy outside the boundary and the exact optimality gap remain open.

## 1. Model, information, and main result

### 1.1 Queue and admissible policies

There are two independent Poisson arrival processes, of rates $\lambda_i>0$, and independent service requirements distributed as $\operatorname{Exp}(\mu_i)$, with $\mu_i>0$. All service requirements, arrivals, and external policy randomization are independent. A single server supplies one unit of service effort per unit time. Preemption and resumption cause no loss. Buffers are infinite, and

$$
\rho=\frac{\lambda_1}{\mu_1}+\frac{\lambda_2}{\mu_2}<1.
\tag{1}
$$

A job's age is time since arrival, including time in service. Let $N_i(t)$ be the class counts and $A(t)$ the sum of all class-1 ages. The instantaneous cost is

$$
G(S_t)=a_0N_1(t)+bA(t)+c_2N_2(t),
\qquad a_0\ge0,\quad b>0,\quad c_2>0.
\tag{2}
$$

The system starts empty. The class $\Pi$ consists of all well-defined nonanticipating work-conserving policies. They can observe every arrival time, job identity, attained service, completion, and current age, and use independent randomization. They cannot observe future input or an unfinished job's residual service requirement. Policies may retain their entire history across empty epochs. The objective is

$$
J(\pi)=\limsup_{T\to\infty}
\frac1T\mathbb E_\varnothing^\pi\int_0^T G(S_t)\,dt.
\tag{3}
$$

As usual, service decisions have predictable service-effort versions. Our lower bound even allows fractional effort allocations summing to one when nonempty; linearity of the generator preserves it. The improving policy we construct uses ordinary single-job preemptive service.

For exponential requirements, an unfinished class-$i$ job has completion intensity $\mu_i$ per unit of service effort, conditional on the full observable history. The remaining requirements of unfinished jobs are conditionally independent exponentials. One way to verify this fact is to expose each requirement only through service survival and completion: joint survival over observed effort increments factors into the corresponding exponential survival factors. Successive conditioning preserves the product residual law. Predictable effort limits give the same hazard representation for arbitrary admissible controls. Observing attained service therefore supplies no hidden knowledge of residual requirements. It does, however, preserve the actual ages of all queued successors.

### 1.2 The fixed policy being classified

Write

$$
\lambda=\lambda_1,\qquad \mu=\mu_1,\qquad r=\mu-\lambda>0,
\qquad d=\frac{\mu_2c_2/\mu-a_0}{b}.
\tag{4}
$$

The LookAhead rule [1] compares

$$
I_1(a)=\mu\left[a_0+b\left(a+\frac1r\right)\right],
\qquad I_2=\mu_2c_2.
\tag{5}
$$

Within each class it uses FCFS; cross-class ties go to class 1. Equivalently, it is the age-threshold rule $D_\alpha$, where

$$
\alpha=\max\{0,d-1/r\}.
\tag{6}
$$

For any fixed $h\ge0$, $D_h$ serves the oldest class-1 job whenever its age is at least $h$, and otherwise serves class 2. It serves the available class if the other is empty. In particular, $D_0$ is strict class-1 priority.

### 1.3 The classification

**Theorem 1 (exact full-information boundary).** Under (1)–(3),

$$
J(\mathrm{LA})=\inf_{\pi\in\Pi}J(\pi)
\quad\Longleftrightarrow\quad
\mu_1\left[a_0+\frac b{\mu_1-\lambda_1}\right]\ge\mu_2c_2.
\tag{7}
$$

In this region, with $\sigma=1/r-d\ge0$, the optimal value is

$$
J_*=
\frac{c_2\mu_2}{1-\rho}
\left(\frac{\lambda_1}{\mu_1^2}+
\frac{\lambda_2}{\mu_2^2}\right)
+\frac{b\lambda}{r}\sigma.
\tag{8}
$$

Every $\pi\in\Pi$ has liminf average expected cost at least $J_*$, and LookAhead's average expected cost converges to $J_*$. If the inequality in (7) fails, Sections 5–7 define a complete admissible policy $\pi_{\mathrm{imp}}$ and explicit constants satisfying

$$
J(\mathrm{LA})-J(\pi_{\mathrm{imp}})\ge\Delta>0.
\tag{9}
$$

The constants are obtained by two terminating searches over positive integers and finite arithmetic expressions. For rational model parameters the acceptance tests can use exact rational arithmetic.

**Theorem 2 (positive-threshold obstruction).** For every $h>0$, the rule $D_h$ is strictly suboptimal for the model (1)–(3). The construction in Sections 5–7 supplies an admissible $\pi_h$ and an explicit $\Delta_h>0$ such that $J(D_h)-J(\pi_h)\ge\Delta_h$. This statement does not require $h$ to equal the LookAhead threshold.

Theorem 1 includes the equality boundary, $\mu_1=\mu_2$, and $a_0=0$. Neither theorem identifies an optimal policy outside (7), and neither asserts improvement at every state or every finite horizon.

## 2. Relation to prior work and the information boundary

Gurushankar et al. [1, Theorem 1.1] identify the optimal nondecreasing per-job index in the two-class model with a general nondecreasing class-1 age cost. Its affine substitution gives (5)–(6); those formulas are not new here. Their Section 1.2 leaves the comparison with unrestricted scheduling open. Their Theorem 4.1 represents the index-policy problem by a finite-arm restless-bandit model.

Li et al. [2] study the multiclass age-cost problem through a Whittle construction, with heuristic performance evidence for the unrestricted queue. Their finite-arm representation is also formulated for nondecreasing index policies. This is a directly comparable Operations Research contribution; our scope is narrower in cost structure but stronger in its exact all-policy classification and certified strict separation. Aalto's related Whittle analyses [3–5] concern other relaxations or service/abandonment models and do not supply this classification.

The distinction is substantive. Conditional on the actual queue history, a queued successor's arrival time is already known. After a completion, its age cannot be replaced by a fresh independent exponential interarrival gap. Within-class FCFS does not remove that information. We use the full ordered age vector in the positive certificate and the observed finite cohort in the negative construction. No queue/bandit equivalence for unrestricted policies is assumed.

The new claims are (7), its full-history verification, and the all-parameter constructive strict-improvement theorem. Memorylessness, workload coupling, polynomial verification, and regenerative reward arguments are standard tools. The contribution is their explicit combination with a service-prefix-observable exchange that closes the affine specialization. The source audit, dated 25 November 2026, found no matching theorem in the inspected primary literature; it is a bounded search, not a proof of absolute priority.

## 3. Policy-independent workload and moment control

This section supplies the integrability needed both for comparison with arbitrary histories and for the finite-backlog error certificate.

### 3.1 Common workload and busy periods

Presample each arriving job's actual service requirement for analysis. Under any lossless work-conserving schedule, total residual workload drains at rate one when positive and jumps by the same arriving requirements. Thus its sample path, empty times, and busy intervals are independent of the service order under this coupling. The controller does not observe these presampled requirements.

Put $\Lambda=\lambda_1+\lambda_2$. A generic arrival has service moment-generating function

$$
M(\theta)=\sum_{i=1}^2\frac{\lambda_i}{\Lambda}
\frac{\mu_i}{\mu_i-\theta},\qquad
0\le\theta<\min_i\mu_i.
\tag{10}
$$

Because $\rho<1$, a sufficiently small $\theta>0$ satisfies

$$
c=\theta-\Lambda[M(\theta)-1]>0.
\tag{11}
$$

For a busy period $B$ starting with one generic arrival, let
$X(t)=S_0+\sum_{\ell\le N_\Lambda(t)}S_\ell-t$ be the unreflected workload. The event $B>t$ implies $X(t)>0$, so exponential Markov bounding gives

$$
\mathbb P(B>t)\le M(\theta)e^{-ct}.
\tag{12}
$$

This argument applies to every service order. Starting with any finite collection of independent exponential residuals changes only the prefactor in the bound.

### 3.2 Uniform moments at a deterministic time

**Lemma 3 (uniform history-independent moment bound).** Starting empty, for every finite $p,q\ge0$,

$$
\sup_{\pi\in\Pi}\sup_{t\ge0}
\mathbb E^\pi_\varnothing[N(t)^p C_t^q]<\infty,
\tag{13}
$$

where $N=N_1+N_2$ and $C_t$ is the elapsed time of the current workload busy interval, set to zero when empty.

**Proof.** Busy starts form a subset of arrivals; their expected counting measure $U(ds)$ is bounded by $\Lambda\,ds$. The starting service mark and subsequent input are independent of the history determining a start. Using (12), for $x\ge0$,

$$
\mathbb P(C_t>x)
\le\int_0^{(t-x)_+}\mathbb P(B>t-s)\,U(ds)
\le\frac{\Lambda M(\theta)}c e^{-cx}.
\tag{14}
$$

When $t \lt x$ the event is empty. Every present job arrived in the current busy interval. For an integer $k\ge1$, set $w=k/(2\Lambda)$. If $C_t\le w$, all present jobs are among the arrivals in the fixed interval $[(t-w)_+,t]$. That count is Poisson with mean at most $k/2$. A union bound and the Poisson Chernoff inequality imply

$$
\mathbb P(N(t)\ge k)
\le\frac{\Lambda M(\theta)}c e^{-ck/(2\Lambda)}
+e^{-k(\log2-1/2)}.
\tag{15}
$$

The exponential marginal tails give moments of all orders; Hölder's inequality gives the mixed moments. No independence between the busy age and the arrival count is used. The bounds hold even when the scheduling policy never resets its private memory. $\square$

### 3.3 A quantitative cost-to-empty second moment

Consider a state with $n$ class-1 and $K$ class-2 jobs, with class-1 ages at most $h$. Let $B$ be the common time to empty from that state, and $M=n+K+N_\Lambda(B)$ the total number of jobs in that busy segment. Every work-conserving policy's original cost to empty is bounded by

$$
H=(A+bB)MB,\qquad A=a_0+c_2+bh.
\tag{16}
$$

Define the following positive constants:

$$
\begin{aligned}
\theta&=\frac{\min(\mu_1,\mu_2)(1-\rho)}4,\\
\kappa&=\theta-\sum_i\lambda_i
 \left(\frac{\mu_i}{\mu_i-\theta}-1\right),&
R&=\sum_i\lambda_i\frac{\mu_i}{\mu_i-\theta},\\
\beta&=\kappa/2,&
g&=1+\frac{\kappa}{2R},&
\ell&=\frac{g-1}{g}.
\end{aligned}
\tag{17}
$$

In fact $\sum_i\lambda_i/(\mu_i-\theta)\le4\rho/(3+\rho)<1$, so $\kappa>0$. Put $\gamma=\log g$, for which $\gamma\ge\ell>0$. A stopped nonnegative exponential martingale gives

$$
\mathbb E e^{\beta B+\gamma M}\le
D_K:=g^{n+K}
\left(\frac{\mu_1}{\mu_1-\theta}\right)^n
\left(\frac{\mu_2}{\mu_2-\theta}\right)^K.
\tag{18}
$$

To see this directly, before emptying use the workload $V_t$ and arrival count $N_\Lambda(t)$. The drift coefficient of
$\exp(\theta V_t+\beta t+\gamma N_\Lambda(t))$ is

$$
-\theta+\beta+\sum_i\lambda_i
\left(e^\gamma\frac{\mu_i}{\mu_i-\theta}-1\right)
=-\kappa+\beta+(g-1)R=0.
\tag{19}
$$

Stop first at $B\wedge t$, then apply Fatou as $t\to\infty$. Initial residuals are independent exponentials conditional on the observable state history, which supplies the factors in (18). Only a one-sided stopped bound is needed.

Using $x^j\le j!s^{-j}e^{sx}$ for $x\ge0$, and $\ell\le\gamma$, (16)–(18) imply

$$
\mathbb E H^2\le
\mathcal M_{2,K}:=
D_K\left[
\frac{8A^2}{\ell^2\beta^2}
+\frac{96b^2}{\ell^2\beta^4}
\right].
\tag{20}
$$

Indeed $H^2\le2A^2M^2B^2+2b^2M^2B^4$. The coefficients are
$2\cdot2!\cdot2!=8$ and $2\cdot2!\cdot4!=96$.
For fixed $n$, the right side grows at most exponentially in $K$.

## 4. Verification of the optimal region

Assume $\sigma=1/r-d\ge0$. At a state, write $m=N_1$, $v=N_2$, and order class-1 ages as $x_1\ge\cdots\ge x_m\ge0$, with $A_1=\sum_i x_i$.

### 4.1 Observable workload potential

Define

$$
Y=\frac m\mu+\frac v{\mu_2},\qquad
H_0=Y^2+\frac m{\mu^2}+\frac v{\mu_2^2},\qquad
s_2=\frac\lambda{\mu^2}+\frac{\lambda_2}{\mu_2^2}.
\tag{21}
$$

A class-$i$ arrival changes $H_0$ by $2Y/\mu_i+2/\mu_i^2$; a departure changes it by $-2Y/\mu_i$. Hence every work-conserving action $u$, including the empty-state action, satisfies

$$
\mathcal L^u H_0=-2(1-\rho)Y+2s_2.
\tag{22}
$$

The original cost has the algebraic decomposition

$$
G=b(A_1-dm)+c_2\mu_2Y.
\tag{23}
$$

This is a finite-state identity, not an assumption of stationary workload conservation.

### 4.2 Rank-weighted polynomial potential

For $m\ge1$ put

$$
q_m=\frac b r m\sigma+\frac b{2\mu r}m(m-1),
\tag{24}
$$

and

$$
f(m)=\frac b{2r}m(m+1)\sigma
+\frac b{6\mu r}m(m+1)(m-1),\qquad f(0)=0.
\tag{25}
$$

Then $f(m)-f(m-1)=q_m\ge0$. Define

$$
h_0(S)=\frac b\mu\sum_{i=1}^m i x_i+f(m),
\qquad j=\frac{b\lambda}{r}\sigma.
\tag{26}
$$

Direct expansion gives

$$
\lambda q_{m+1}-\mu q_m
=j-\frac b{2\mu}m(m+1)+bdm,\qquad
\lambda q_1=j.
\tag{27}
$$

The age drift of $h_0$ is $bm(m+1)/(2\mu)$; a class-1 arrival adds $q_{m+1}$. If class-1 rank $k$ departs, the potential decreases by

$$
D_k=\frac b\mu\left(kx_k+\sum_{i>k}x_i\right)+q_m.
\tag{28}
$$

In particular $D_1=bA_1/\mu+q_m$, and

$$
\mu(D_1-D_k)=b\sum_{i \lt k}(x_i-x_k)\ge0.
\tag{29}
$$

**Lemma 4 (all-action verification certificate).** Set

$$
\Psi=h_0+\frac{c_2\mu_2}{2(1-\rho)}H_0.
\tag{30}
$$

At every observable state and for every feasible service action,

$$
G+\mathcal L^u\Psi\ge J_*.
\tag{31}
$$

Equality holds for strict class-1 priority with within-class FCFS.

**Proof.** Let $g_0=b(A_1-dm)$. When $m>0$, serving the oldest class-1 job gives $g_0+\mathcal L h_0=j$ by (27). Serving rank $k$ instead leaves the nonnegative slack (29). Serving any class-2 job leaves slack

$$
bA_1+\mu q_m\ge0.
\tag{32}
$$

When $m=0$, the class-1 arrival contribution is $\lambda q_1=j$, independently of the feasible action. Combine these statements with (22)–(23). The constant is exactly (8). $\square$

This proof compares all within-class choices directly. It does not need a preliminary FCFS reduction, nor any restricted index-policy state representation.

### 4.3 Full-history transversality and optimality

The potential is nonnegative and grows at most as a constant times
$N^2C+N^3+N^2+N$. Lemma 3 therefore yields

$$
\sup_{\pi,t}\mathbb E_\varnothing^\pi\Psi(S_t)<\infty.
\tag{33}
$$

For each fixed horizon, the number of arrivals bounds the number of jobs and completions, and every age is at most the horizon. All potential increments and drifts are bounded by integrable polynomials of that Poisson count. Localization and dominated convergence justify the compensated jump/age-drift identity

$$
\mathbb E\Psi(S_T)-\Psi(S_0)
=\mathbb E\int_0^T\mathcal L^{u_t}\Psi(S_t)\,dt
\tag{34}
$$

for arbitrary predictable history-dependent controls. Integrating (31), using $\Psi(S_0)=0$, and then (33), gives

$$
\frac1T\mathbb E\int_0^TG(S_t)\,dt
\ge J_*-\frac{\mathbb E\Psi(S_T)}T
\quad\Longrightarrow\quad
\liminf_{T\to\infty}\frac1T\mathbb E\int_0^TG(S_t)\,dt\ge J_*.
\tag{35}
$$

Strict class-1 priority gives equality before taking the limit, and hence attains $J_*$. If $\sigma\ge0$, (5) implies
$I_1(a)-I_2=\mu b(a+\sigma)\ge0$. Under the stated tie convention LookAhead is exactly that attaining policy. This proves the sufficient direction of Theorem 1.

## 5. An observable finite-cohort exchange

Fix an arbitrary threshold $h>0$. This section proves a uniform local gain for $D_h$; Sections 6–7 turn it into a finite-queue and long-run certificate.

### 5.1 Trigger state and finite prefixes

Set

$$
D=h/2,\qquad \varepsilon=h/4,\qquad
\eta=h/8=\varepsilon/2,\qquad s=h/2.
\tag{36}
$$

At the intervention time, called zero here, suppose exactly $n$ class-1 jobs are present, with ordered ages in $[s,s+\eta]$, together with exactly $K$ class-2 jobs. Tag those $n$ class-1 jobs. Their threshold-release times are

$$
R_j=h-a_j\in[D-\eta,D],
\tag{37}
$$

all later than $\varepsilon$. Future class-1 arrivals cannot reach age $h$ before time $h>D$.

For analysis, let the tagged jobs' residual requirements be independent $S_j\sim\operatorname{Exp}(\mu)$, in FCFS order, and define

$$
W_j=\sum_{i=1}^jS_i,\qquad W=W_n,\qquad
\tau=\min(\varepsilon,W).
\tag{38}
$$

In an auxiliary comparison where class 2 is always available, let $q$ be the amount of tagged class-1 service supplied by $D_h$ during $[0,D]$. Necessarily

$$
0\le q\le\min(\eta,W)\le\tau.
\tag{39}
$$

### 5.2 The actual policy

At a trigger, execute these stages, keeping FCFS order within each class:

1. Serve tagged class-1 jobs until $\varepsilon$ service units have been supplied, or all tags finish. The elapsed duration is $\tau$.
2. Serve class 2 until calendar time $D$.
3. Serve the remaining tagged class-1 jobs until they all finish.
4. Serve class 2 for $z=\tau-q$ service units.
5. Resume $D_h$.

If class 2 becomes empty during a stage that requires its service, abort the exchange immediately and resume $D_h$. Empty-system epochs reset the intervention state. Thus the definition is work-conserving even on paths outside the good coupling event.

**Lemma 5 (service-prefix observability).** The quantity $q$, and therefore the compensation duration $z$, is measurable from information available at the end of stage 1.

**Proof.** By that time the actual schedule has exposed the service prefix of the tags of length $\tau$, including each completed tag's residual requirement and the attained part of the next tag. If $W<\eta$, all tags have finished. Otherwise the exposed prefix has length at least $\eta$. The auxiliary release schedule (37) can consume at most $\eta$ tagged service units before $D$. Its entire needed prefix is therefore already exposed. Reconstruct its FCFS progression through known release times using this prefix. No unobserved residual or future arrival is queried. $\square$

### 5.3 Complete-state coalescence

Let the initial class-2 residuals be $V_1,\ldots,V_K$ and define

$$
\mathcal G=\left\{\sum_{i=1}^KV_i>D\right\}.
\tag{40}
$$

On $\mathcal G$, both schedules have sufficient initial class-2 work throughout the exchange; their class-2 service totals never exceed $D$. The auxiliary comparison is therefore the true baseline.

By time $D$, the baseline has supplied $q$ tagged service units and the intervention $\tau$. After $D$, all tags are eligible. The endpoints of the remaining-cohort phases are
$T_A=D+W-\tau$ for the intervention and the following time for the baseline:

$$
T=D+W-q=T_A+z.
\tag{41}
$$

When all tags already finished in an earlier stage, these are bookkeeping stage endpoints. If $q=W$, then $\tau=W$, $z=0$, and $T=D$; no future class-1 job can yet be eligible, so the formulas remain valid.

**Lemma 6 (finite complete-state coalescence).** On $\mathcal G$, the baseline and intervention have identical complete queue states at $T$, under common arrivals and presampled requirements.

**Proof.** Both have supplied $W$ class-1 service units and $D-q$ class-2 units. They use the same initial FCFS order in each class, so initial departures and attained service of any surviving class-2 head agree. Before the baseline clears the tags, future class-1 jobs are behind them. The intervention explicitly withholds service from those future jobs during compensation. In the case $q=W$, they cannot be eligible before $D \lt h$. Thus future class-1 jobs have no attained service on either path. Future class-2 jobs remain behind the unexhausted initial class-2 cohort. Arrivals and calendar time are common, so every remaining identity and age agrees as well. Subsequent $D_h$ paths can be identical. $\square$

### 5.4 A gain that grows quadratically with the cohort

Define $D^*$ as baseline cost minus intervention cost in the auxiliary finite exchange. Use an independent Poisson completion clock of rate $\mu_2$ in cumulative class-2 service time. This defines a finite completion-delay sum, not an infinite-background holding-cost objective.

Every tag finishes no later under the intervention. The baseline supplies no tagged service before $\varepsilon$; its entire prefix by $D$ has length at most $q\le\tau$, which the intervention has already supplied. After $D$, that service lead persists until tagged clearance. If $W_j>\varepsilon$, then $\tau=\varepsilon$, and its intervention and baseline completion times are respectively

$$
C_j=D+W_j-\varepsilon,\qquad
B_j=D+W_j-q.
\tag{42}
$$

Their difference is at least $\varepsilon-\eta=\varepsilon/2$. Its earlier completion age is at least $W_j-\varepsilon$. Integrating the nonnegative affine holding rate therefore gives

$$
G_1\ge\frac{b\varepsilon}{2}
\sum_{j=1}^n(W_j-\varepsilon)_+,\qquad
\mathbb EG_1\ge\frac{b\varepsilon}{2}
\left[\frac{n(n+1)}{2\mu}-n\varepsilon\right].
\tag{43}
$$

For the class-2 expectation calculation only, condition on all tagged residual requirements, including their unrevealed parts. This analytical conditioning is not information supplied to the policy. A service-clock completion at level $u\le D-\tau$ occurs at time $\tau+u$ under the intervention and between $u$ and $u+q$ under the baseline. Its delay is between zero and $\tau$. For $D-\tau \lt u\le D-q$, the intervention time is $W+u$, and the delay is between zero and $W$. The expected class-2 loss is consequently at most

$$
c_2\mu_2\,[\tau(D-\tau)+W(\tau-q)]
\le c_2\mu_2\varepsilon(D+W).
\tag{44}
$$

Combining (43)–(44) yields the uniform bound

$$
\mathbb ED^*\ge
G_0(n):=\varepsilon\left\{
\frac b2\left[\frac{n(n+1)}{2\mu}-n\varepsilon\right]
-c_2\mu_2\left[D+\frac n\mu\right]\right\}.
\tag{45}
$$

**Lemma 7 (positive auxiliary exchange).** The search for the least positive integer $n$ with $G_0(n)>0$ terminates.

**Proof.** The coefficient of $n^2$ in $G_0(n)$ is $b\varepsilon/(4\mu)>0$; all other terms have lower degree. This also supplies an explicit quadratic-root bound on the search. $\square$

The gain uses original nonnegative costs. It does not rely on subtracting infinite costs or replacing observed successor gaps by unconditional distributions.

## 6. A finite-backlog, effectively certifiable local gain

Fix any $n$ passing Lemma 7. Let $v_0=\mu_2D$. The probability that the initial class-2 backlog is insufficient is

$$
p_K=\mathbb P(\mathcal G^c)
=\mathbb P(\operatorname{Poisson}(v_0)\ge K).
\tag{46}
$$

For $K+1>v_0$, the successive terms of this tail have ratio at most $v_0/(K+1)$. Dropping $e^{-v_0}$ gives the explicit upper bound

$$
p_K\le\bar p_K:=
\frac{v_0^K}{K!}\frac{K+1}{K+1-v_0}.
\tag{47}
$$

It need not be below one for the first few $K$; it is still an upper bound.

To bound the auxiliary difference, put $A_*=a_0+b(h+D)$. Each tag's completion advance is at most $D$, its completion time is at most $D+W$, and each class-2 clock completion involved has delay at most $D+W$. Thus

$$
|D^*|\le nD(A_*+bW)+c_2N_D(D+W),
\tag{48}
$$

where $N_D\sim\operatorname{Poisson}(v_0)$ is independent of
$W\sim\operatorname{Gamma}(n,\mu)$. In particular,

$$
\begin{aligned}
\mathbb E(D^*)^2\le Q^2:={}&
2n^2D^2\left[A_*^2+\frac{2A_*bn}{\mu}
+\frac{b^2n(n+1)}{\mu^2}\right]\\
&+2c_2^2(v_0+v_0^2)
\left[D^2+\frac{2Dn}{\mu}
+\frac{n(n+1)}{\mu^2}\right].
\end{aligned}
\tag{49}
$$

Let $D_{\mathrm{real}}$ be the difference between the two true costs to their common next empty epoch. They have the same endpoint by workload coupling, even when the intervention aborts. On $\mathcal G$, Lemma 6 gives $D_{\mathrm{real}}=D^*$. On its complement, each true cost is bounded by (16). Cauchy–Schwarz and (20), (49) give

$$
\mathbb ED_{\mathrm{real}}
\ge G_0-\left[Q+2\sqrt{\mathcal M_{2,K}}\right]\sqrt{p_K}.
\tag{50}
$$

**Lemma 8 (finite and effective backlog certificate).** Choose the least positive integer $K$ with $K+1>v_0$ satisfying

$$
16Q^2\bar p_K\le G_0^2,\qquad
64\mathcal M_{2,K}\bar p_K\le G_0^2.
\tag{51}
$$

This search terminates, and for every allowed initial age tuple,

$$
\mathbb ED_{\mathrm{real}}\ge G_0/2>0.
\tag{52}
$$

**Proof.** The first inequality makes $Q\sqrt{p_K}\le G_0/4$, and the second makes $2\sqrt{\mathcal M_{2,K}p_K}\le G_0/4$. For fixed parameters and $n$, $\mathcal M_{2,K}$ is a constant times a fixed exponential in $K$, whereas (47) decays faster than every such exponential. Equivalently, the ratio of successive exponential-times-tail bounds tends to zero. Both tests eventually hold strictly. All expressions in (17), (20), (45), (47), (49), and (51) are rational when the original parameters and $h$ are rational. $\square$

For general real parameters these formulas provide a finite analytic definition. For computable parameters, dovetail the integer candidates and certified interval precision: first find any n with a certified strict positive G_0, then find any K with both tests certified strictly below G_0 squared. Do not wait indefinitely on an earlier candidate whose test may be an equality. Each stage eventually has a strict witness, so the dovetailed search terminates. This is the claimed effective lower-bound certificate, not an uncertified numerical sign search.

## 7. Recurrent accessibility and a strict average-cost gap

### 7.1 A globally defined once-per-cycle policy

At an empty system, use $D_h$ and wait for the first arrival. Start the busy-period clock at that arrival. At elapsed time

$$
t_*=s+\eta=5h/8,
\tag{53}
$$

make one check if the same busy period is still running. If exactly $n$ class-1 and $K$ class-2 jobs are present and every class-1 age belongs to $(s,s+\eta)$, perform the exchange of Section 5 once. Otherwise continue $D_h$. After the exchange, or an abort, use $D_h$ until the next empty epoch. If the busy period ends before the check, reset at that empty epoch. This defines $\pi_h$ on every observable history.

The policy uses current counts, ages, elapsed time, and the revealed service prefix only. At a trigger, conditional residual memorylessness supplies exactly the distribution used in (45)–(52). The lower bound is uniform over all triggering age vectors and all preceding observable histories.

### 7.2 Explicit positive trigger probability

Consider the following event in a workload cycle: its first arrival is class 2; that job's service requirement exceeds $t_*$; exactly $n$ class-1 jobs arrive during $(0,\eta)$, with none during $(\eta,t_*)$; and exactly $K-1$ further class-2 jobs arrive before $t_*$. No class-1 job reaches threshold during this interval. The first class-2 job remains in service, so no job departs and the trigger conditions hold.

By independence, this event has probability

$$
p_0=
\frac{\lambda_2}{\Lambda}
e^{-(\Lambda+\mu_2)t_*}
\frac{(\lambda_1\eta)^n}{n!}
\frac{(\lambda_2t_*)^{K-1}}{(K-1)!}>0.
\tag{54}
$$

Hence the actual trigger probability is at least $p_0$. The use of an age interval is essential: no positive probability is assigned to simultaneous arrivals or exactly equal ages.

### 7.3 Regenerative comparison

**Lemma 9 (long-run gap from a complete cycle).** The policy just defined satisfies

$$
J(D_h)-J(\pi_h)\ge
\Delta_h:=
\frac{\Lambda(1-\rho)p_0G_0}{2}>0.
\tag{55}
$$

**Proof.** Couple both policies with the same service requirements and arrivals. They agree until a trigger. Their idle and busy intervals coincide pathwise by workload conservation. In each cycle the conditional expected cost reduction is at least $G_0/2$ when triggered, so the unconditional expected reduction is at least $p_0G_0/2$.

Both policies reset their rules at empty epochs. Their cycle data are therefore iid. A cycle consists of an exponential idle time of mean $1/\Lambda$ followed by the busy period initiated by a generic arrival. The latter has mean $(\rho/\Lambda)/(1-\rho)$, hence the common mean cycle length is

$$
\mathbb E L=\frac1{\Lambda(1-\rho)}.
\tag{56}
$$

For completeness, the busy-period mean follows by stopping the compound-input workload equation: the negative drift is $1-\rho$, and the initial mean work is $\rho/\Lambda$. Bound (12), or the stopped exponential estimate (18), justifies the passage to the stopping time.

Cycle lengths and rewards have moments sufficient for the renewal-reward theorem, by (18)–(20) applied to a single initial arrival. The expected cost in the incomplete cycle at a deterministic horizon is uniformly bounded: its elapsed busy time has an exponential tail by the busy-start argument in (14), and its accrued arrival count has moments bounded by the same Poisson-window argument as (15). Its accrued cost is bounded by a polynomial in those two quantities. The initial idle portion incurs no cost. Thus the expected residual reward divided by the horizon vanishes, and the time-averaged expected costs converge to their expected reward per mean cycle length. Dividing the strict cycle reduction by (56) proves (55). $\square$

### 7.4 Completion of the classification

Lemma 9 proves Theorem 2 for every $h>0$. If (7) fails, the LookAhead threshold is $h=\alpha>0$. Set $\pi_{\mathrm{imp}}=\pi_\alpha$ and $\Delta=\Delta_\alpha$. This proves (9), and therefore the necessary direction of Theorem 1. Together with Section 4 it completes the exact classification.

The index optimality theorem of [1] yields a further consequence, restricted to its stated policy class:

**Corollary 10 (obstruction to nondecreasing per-job indices).** When $\alpha>0$, no policy in the nondecreasing per-job index family compared in [1, Theorem 1.1] attains the unrestricted optimum. Indeed, every such policy has cost at least $J(\mathrm{LA})$, which exceeds $J(\pi_\alpha)$ by (55).

This corollary does not cover arbitrary nonmonotone indices, history-dependent indices, or a different information convention. The unrestricted optimum need not be attained for the inequality argument.

## 8. Effective calculation, boundaries, and limitations

### 8.1 Exact arithmetic example

Take

$$
\lambda_1=\lambda_2=\frac15,\qquad
\mu_1=\mu_2=1,\qquad
a_0=0,\quad b=1,\quad c_2=2.
\tag{57}
$$

Then $\rho=2/5$, $h=\alpha=3/4$. The first passing cohort size in (45) is $n=8$, with $G_0=3/32$. The exact rational tests (51) first pass at $K=14$. Their left sides divided by $G_0^2$ are approximately $4.5771\cdot10^{-11}$ and $0.126244$, respectively; those decimals are display values, and the supplied program makes all decisions with rational fractions.

To certify the exponential factor in (54) without floating-point arithmetic, write $x=(\Lambda+\mu_2)t_*$ and choose any integer $k>x$. Since $\log(1-y)\le-y$ for $0 \lt y<1$,

$$
e^{-x}\ge(1-x/k)^k>0.
\tag{58}
$$

Substitution gives an exact rational positive lower bound for (55). For (57), the stored certificate gives a lower bound approximately $5.084\cdot10^{-45}$. This tiny number is a rigorous witness of strict separation, not an estimate of the actual performance gain. It reflects conservative moment bounds and a deliberately rare trigger. No practical efficiency claim is made for the witness policy.

The reproduction program checks the polynomial recurrences symbolically, the example certificate with exact rational arithmetic, and 20,000 finite-cohort sample paths against the release-time recurrence. Those path checks include early cohort clearance and varying service/time scales; they are diagnostics, not a replacement for Lemmas 5–9 or a proof by simulation.

### 8.2 Boundary cases

At $d=1/r$, $\sigma=0$, $q_1=j=0$, while $q_m=bm(m-1)/(2\mu r)\ge0$. The all-action certificate therefore remains valid. The class-1 tie rule gives $D_0$; a tie involving a single age-zero class-1 job lasts zero calendar time almost surely.

No denominator contains $\mu_1-\mu_2$, and no argument requires $a_0>0$. Thus equal service rates and zero intercept are genuinely included. Positive arrivals, positive $b,c_2$, and $\rho<1$ are retained throughout. We do not claim the same strict separation if one class never arrives, if the age slope is zero, or at instability.

### 8.3 What the result does and does not establish

The positive theorem compares all admissible histories through a common finite-horizon potential. The negative theorem gives a policy defined everywhere and improves its long-run average from the empty state. It does not assert that every state admits a favorable deviation or that every sample path is improved.

The obstruction comes from observed successors: delaying a large known cohort creates a quadratic aggregate age-cost effect, while the compensating class-2 loss grows only linearly with cohort size. A rule looking only at the oldest job's age cannot react to that cohort. The prefix construction shows precisely how service information used by the exchange becomes observable before it is needed.

The results classify when the published LookAhead rule is globally optimal throughout the affine/constant parameter family. They do not solve arbitrary nonlinear TVHC, multiple servers, unknown service laws, the full optimal decision surface in the negative region, or the exact gap. The present certificates can be sharpened, but their purpose here is an all-parameter strict theorem with a checkable stopping rule.

## References

1. K. Gurushankar, Z. Li, M. Harchol-Balter, and A. Scheller-Wolf. *LookAhead: the optimal non-decreasing index policy for a time-varying holding cost problem*. Queueing Systems 110, Article 7 (2026). [DOI: 10.1007/s11134-025-09967-w](https://doi.org/10.1007/s11134-025-09967-w). Full publisher text and formal author PDF inspected, especially Sections 1.1–1.2 and Theorems 1.1 and 4.1.
2. Z. Li, K. Gurushankar, M. Harchol-Balter, and A. Scheller-Wolf. *Improving Upon the Generalized cμ Rule: A Whittle Approach*. Operations Research 74(5), 2577–2591 (2026). [DOI: 10.1287/opre.2025.1987](https://doi.org/10.1287/opre.2025.1987). Formal author PDF, author preprint with appendices, and publisher metadata inspected.
3. S. Aalto. *Whittle index approach to the multi-class queueing systems with convex holding costs and IHR service times*. Mathematical Methods of Operations Research 100, 603–634 (2024). [DOI: 10.1007/s00186-024-00877-w](https://doi.org/10.1007/s00186-024-00877-w). Publisher full text inspected.
4. S. Aalto. *Dynamic scheduling with convex delay costs revisited*. Queueing Systems 110, Article 2 (2026). [DOI: 10.1007/s11134-025-09961-2](https://doi.org/10.1007/s11134-025-09961-2). Publisher text and author repository PDF inspected.
5. S. Aalto. *Whittle index approach to multi-server scheduling with convex delay costs and impatient customers*. [arXiv:2609.19792](https://arxiv.org/abs/2609.19792) (2026). Full preprint inspected for its model and scope; it is not treated as a peer-reviewed flagship benchmark.
