# Two scales of heavy traffic in a scheduled queue

## Nonmemoryless continuous extremes, independent peak age, and calendar-sensitive centering

Research manuscript | 26 November 2026

### Abstract

Consider a single-server queue with one unit of work scheduled at each integer, independent nonnegative arrival delays, and service speed 1+ε. We establish a fine-scale limit for a class of increasing-hazard delay distributions, extending beyond exponential memorylessness. Write the survival function as exp(−φ), where φ is continuously differentiable, strictly increasing, convex, vanishes at zero, and satisfies φ′/φ→0. A finite sum of φ over the appointment calendar determines an explicit center bε; the inverse fluctuation scale is φ(bε). The corrected workload, its maximizing historical age, and the current late population converge jointly to independent Gumbel, unit-exponential, and current-population limits. Consequently the uncorrected workload has a different, order-one random limit. The proof derives phase-uniform tail estimates, anti-clustering, and a genuine continuous upcrossing Poisson limit directly from the delay law, without assuming that the population count is Markov. It includes a fixed-threshold age point-process Laplace functional and uniform observation-phase statements. For exponential delays, a bounded periodic term in the exponent is necessary for a universal Gumbel center. We also prove every positive-order L^p heavy-traffic limit under logarithmic Weibull tails, including decreasing-hazard shapes outside the fine-scale class. Explicit nonmemoryless examples and numerical calculations describe both the normalization and visible finite-traffic error. The literature comparison distinguishes established Bernoulli-tail theory from the dependent queue limit and records the remaining full-text access limitation.

**Keywords:** scheduled traffic; heavy traffic; dependent extremes; increasing hazard; late arrivals; Gumbel distribution.

### Contribution and relation to prior work

Araman and Glynn [1] characterize stability at critical loading for finite-mean scheduled perturbations. Their criterion explains why nonnegative unbounded delays require positive excess service capacity. The present question is quantitative: how does workload diverge as that capacity vanishes, and which state variables determine its fluctuations? The comparator treats the same independently perturbed appointment structure and deterministic-work queue.

Araman, Chen, Glynn, and Xia [2, Theorem 6] obtain a first-order heavy-traffic law for Pareto perturbations. We use their late-population representation and the established connection between heavy traffic and extreme delayed populations. The logarithmic-Weibull first-order extension is one layer of the result. Sections 2–5 develop the full exponential case explicitly, including its calendar term; Section 6 proves the distribution-class result that does not rely on exponential residual clocks.

Under primitive conditions on a nonmemoryless delay law, we prove a phase-uniform continuous drifting-boundary Poisson limit and the joint independence of the corrected workload height, the age of its creating historical extreme, and the current late population. The same theorem supplies an explicit calendar-sensitive center throughout the stated increasing-hazard class, while separating the nonuniversal order-one workload fluctuation from the finer universal extreme law.

The ingredients have substantial prior theory. Lancia, Guadagni, Ndreca, and Scoppola [3] develop exponential-lateness pool and q-product calculations for a queue whose load is reduced by independent balking and whose service is discrete. Iksanov and Kotelnikova [7] give precise point and tail asymptotics for fixed infinite Bernoulli sums, including geometric and superexponential examples. Their general marginal classification, q-series algebra, and the broad rare-block method are not claimed as inventions here. We provide a self-contained phase-uniform marginal argument suited to the moving continuous boundary, then derive the temporal and joint limits from the primitive delay assumptions. A static marginal equivalence alone would not establish those limits.

Periodic structure and queue extremes also have established antecedents. Guadagni, Ndreca, and Scoppola [8] study pre-scheduled queues with bounded perturbations and a fast/slow description. Hall and Temido [9] analyze maxima of periodic integer-valued sequences with exponential-type tails and suitable subsequences. Glynn and Whitt [10] prove heavy-traffic extreme-value limits for growing-horizon GI/G/1 waiting-time maxima. Those observables and limiting regimes differ from the present single-observation stationary workload represented by an infinite-past drifted continuous maximum. We do not claim that periodic phenomena or Gumbel limits in queueing were previously unknown.

Two recent scheduled-arrival sources require a precise distinction. The publicly accessible appendices of De Turck and Fiems [4] establish a Poisson arrival limit under increasing unpunctuality and a fixed-load, random-service large-buffer exponent. Their main-text Theorem 2 was not retrieved; no assertion excluding every result of that article is made. Della Corte and Mandjes [5, Theorem 5.1 and Section 7], whose complete preprint was retrieved, study path large deviations for empirical means of independent arrival streams on a fixed time interval and their reflected workloads. The limit parameter and observable differ from the single-stream, stationary, ε-to-zero extremes proved here. Sabria and Daganzo [6] concern a Gumbel input delay distribution and an established service order, rather than the output extreme law studied here.

The written proof is self-contained apart from standard probability tools, including Chernoff bounds, Borel–Cantelli, dominated convergence, characteristic-function convergence, and the continuous mapping theorem. Statements about distinctness concern the primary material actually inspected. Global priority is not asserted.


## 0. Exact model and conventions

Appointments occur at every integer i in Z. The actual arrival time of job i is i+ξ_i, where the ξ_i are i.i.d., nonnegative, almost surely finite. Each job brings one unit of work. A work-conserving server processes work at constant speed 1+ε, ε>0. The queue has operated from the infinite past. We observe it immediately after time 0, an appointment epoch. Thus the model is stationary under integer time shifts; its continuous-time steady regime is periodic in calendar phase.

Write

\[
 L(t)=\sum_{i\le\lfloor t\rfloor}{\bf1}\{i+\xi_i>t\},
 \qquad H(t)=L(t)+\{t\}.
\]

The newly scheduled job at an integer is included in L if its delay is positive. In the exponential case this happens almost surely, so L(0)≥1. Let A(s,t] count actual arrivals in (s,t]. The pathwise counting identity is

\[
 A(s,t]-(t-s)=H(s)-H(t). \tag{0.1}
\]

Consequently the stationary workload, in work units, is

\[
 W_\varepsilon(t)
 =\sup_{s\le t}\{A(s,t]-(1+\varepsilon)(t-s)\}
 =\sup_{s\le t}\{H(s)-\varepsilon(t-s)\}-H(t).
 \tag{0.2}
\]

In particular,

\[
 M_\varepsilon:=W_\varepsilon(0)+L(0)
 =\sup_{s\le0}\{H(s)+\varepsilon s\}. \tag{0.3}
\]

The representation by late/early customer pools and reflection is established prior methodology, especially Araman–Chen–Glynn–Xia (2022), DOI 10.1007/s11134-021-09732-9. Equation (0.3) is not claimed as a new invention.

The first-order hypothesis used below is

\[
 -\log\Pr(\xi_0>x)\sim\beta x^\alpha,
 \qquad \alpha,\beta>0. \tag{0.4}
\]

It implies finite mean and the finiteness of L(t). Every L(t) is an independent Bernoulli sum with summable probabilities, hence has every exponential moment. The tail estimates proved below also imply H(s)/|s|→0 almost surely as s→−∞, by a union bound on integer epochs and Borel–Cantelli, followed by H(n+u)≤L(n)+1. Thus (0.3) is finite almost surely. Formula (0.2) defines the minimal stationary workload and agrees with the increasing limit of queues initialized empty at earlier and earlier times.

**Random phase version.** If appointments are i+U with U uniform on [0,1), independent of all delays, the whole continuous-time model is stationary. Define θ(t)={t−U} and H_U(t)=L_U(t)+θ(t). The exact corrected maximum is then Wε(0)+L_U(0)+θ(0), not Wε(0)+L_U(0). The estimates in the proof below are uniform in the fixed observation phase. For a fixed shift U, the potential crossing times become s_j=(x+U+j)/(1+ε), and {x−εs_j}={s_j−U}; their spacing and every uniform pool estimate are unchanged. Conditional integration therefore extends the limits to random U with this correction. Omitting θ produces an order-one error, much larger than the fine extreme fluctuations: order 1/b in the exponential case and order 1/φ(b) in Section 6.

## 1. First-order Weibull theorem, including all moments

Put

\[
 r=\alpha+1,\qquad c=\frac{\beta}{\alpha+1},
 \qquad A_\varepsilon=
 \left(\frac{1}{c}\log\frac1\varepsilon\right)^{1/r}.
\]

**Theorem 1 (logarithmic-tail heavy traffic).** Under (0.4), for every p>0,

\[
 \mathbb E\left|\frac{W_\varepsilon(0)}{A_\varepsilon}-1\right|^p\longrightarrow0,
 \qquad
 \mathbb E\left|\frac{M_\varepsilon}{A_\varepsilon}-1\right|^p\longrightarrow0.
 \tag{1.1}
\]

The same assertion holds at any fixed observation phase, uniformly over phase in [0,1].

### 1.1 Sharp logarithmic tail of the late pool

Let S=L(0)=Σ_{j≥0}B_j, with independent Bernoulli B_j having success probability p_j=Pr(ξ>j). Then

\[
 \log\Pr(S\ge m)\sim-cm^r. \tag{1.2}
\]

For the lower bound require the m most recent scheduled jobs to remain late. Since every p_j>0,

\[
 \Pr(S\ge m)\ge\prod_{j=0}^{m-1}p_j,
 \qquad
 \sum_{j=0}^{m-1}(-\log p_j)\sim\frac{\beta}{\alpha+1}m^{\alpha+1}.
\]

For the upper bound fix 0 < b < β. There is a fixed J such that p_j≤exp(−b j^α) for j≥J. With θ=b m^α,

\[
 \log\mathbb Ee^{\theta S}
 \le J\theta+\sum_{j\ge0}\log(1+e^{b(m^\alpha-j^\alpha)}).
\]

For j≤m the logarithm is at most b(m^α−j^α)+log2. For j>m it is at most exp(−b(j^α−m^α)). This last sum is O(1+m^{1−α}): on (m,2m] use a lower bound on the derivative αx^{α−1}; beyond 2m use j^α−m^α≥(1−2^{−α})j^α. Therefore

\[
 \log\mathbb Ee^{\theta S}
 \le b\left(m^{\alpha+1}-\sum_{j\le m}j^\alpha\right)
       +o(m^{\alpha+1}).
\]

Chernoff's inequality subtracts θm, leaving

\[
 \limsup_{m\to\infty}m^{-r}\log\Pr(S\ge m)
 \le-\frac{b}{\alpha+1}.
\]

Let b↑β. This proves (1.2). Fixed phase shifts j→j+u, u∈[0,1], are squeezed between the unshifted Bernoulli sequence and its one-index shift, so (1.2) holds uniformly in phase.

### 1.2 Upper probability bound

For every 0 < c' < c there is K < ∞ such that Pr(S>y)≤K exp(−c'y^r) for y≥0. The calendar inequality gives, for x>2,

\[
 \Pr(M_\varepsilon>x)
 \le \sum_{n\ge0}\Pr(S>x-1+\varepsilon n)
 \le K\left(1+\frac{1}{\varepsilon c'r(x-1)^{r-1}}\right)
          e^{-c'(x-1)^r}. \tag{1.3}
\]

The last step uses convexity of y↦y^r to bound the tail integral. At x=(1+η)Aε choose 0 < c' < c sufficiently close to c that (c'/c)(1+η)^r>1. The right-hand side tends to zero.

### 1.3 Independent-block lower probability bound

Fix η∈(0,1). Let m=⌊(1−η)Aε⌋ and choose γ with (1−η)^r < γ < 1. In the past interval [−T,0], T=⌊ε^{−γ}⌋, split scheduled labels into disjoint consecutive blocks of m labels. At the endpoint n of a block require every one of its m appointments to remain late. These events are independent. Each has probability

\[
 p_m^*=\prod_{j=0}^{m-1}p_j
 =\exp\{-cm^r(1+o(1))\}
 =\varepsilon^{(1-\eta)^r+o(1)}.
\]

There are at least T/m−2 trials. Their expected number of successes diverges, so a success exists with probability tending to one. At its endpoint L(n)≥m, hence Mε≥m−εT. Since εT=o(1), Mε/Aε≥1−η−o(1) with probability tending to one. Also L(0)/Aε→0 in probability, giving the corresponding lower bound for Wε=Mε−L(0). Together with (1.3), both ratios converge to one in probability. At a shifted observation phase, use the same disjoint appointment-label blocks and move the two time boundaries by at most one. This changes the drift penalty by at most ε and the number of trials by at most two; the bounds are uniform in phase.

### 1.4 All finite positive moments

For sufficiently large fixed u and all sufficiently small ε, (1.3) with x=u Aε gives

\[
 \Pr(M_\varepsilon/A_\varepsilon>u)
 \le K_1 e^{-c_1 u^r}, \tag{1.4}
\]

for constants independent of ε. Indeed log(1/ε)=c Aε^r, and for u≥2 and Aε≥1, u Aε−1≥u Aε/2. Increase the fixed lower bound on u until the negative u^r term absorbs the positive log(1/ε) term. Integrating (1.4) yields a uniform bound on every positive moment of Mε/Aε, and therefore on every positive moment of Wε/Aε. For a requested p, take a strictly larger moment to obtain uniform integrability; probability convergence proves (1.1).

## 2. Exponential delays: exact high-state probabilities

Now assume ξ_i has the exponential law with rate β>0, and set

\[
 q=e^{-\beta},\qquad C_q=\prod_{j=1}^{\infty}(1-q^j)\in(0,1).
\]

At phase u∈[0,1), L(n+u) has the distribution

\[
 S_u=\sum_{j\ge0}\mathrm{Ber}(q^{j+u}),
\]

with independent summands. For integer k≥0 the exact factorial moment is

\[
 F_k(u):=\mathbb E {S_u\choose k}
 =\frac{q^{k(k-1)/2+ku}}{\prod_{j=1}^{k}(1-q^j)}. \tag{2.1}
\]

Proof: expand the factorial moment over 0≤j_1 < ⋯ < j_k and write the gaps of the indices as nonnegative integers. The resulting geometric products are precisely ∏_{j=1}^k(1−q^j)^{-1}. This identity is compatible with the q-product/partition calculations in Lancia et al. (2018), DOI 10.1007/s00186-018-0643-3; this q-product algebra is established prior work.

For every nonnegative integer-valued S,

\[
 0\le\mathbb E{S\choose k}-\Pr(S=k)
 \le(k+1)\mathbb E{S\choose k+1}.
\]

Apply this to (2.1). Uniformly for u∈[0,1],

\[
 \Pr(S_u=k)
 =\frac{q^{k(k-1)/2+ku}}{C_q}
       \bigl[1+O(kq^k)\bigr]. \tag{2.2}
\]

The same relative equivalence holds for Pr(S_u≥k). Here the implied constants may depend on the fixed β, but not on k or u.

For x=k+u, k=⌊x⌋, u={x}, define the continuous piecewise linear function

\[
 I(x)=\beta\left(\frac{k(k-1)}2+ku\right)
     =\frac\beta2\left[x(x-1)+u(1-u)\right], \tag{2.3}
\]

and ν(x)=Pr(S_{\{x\}}=⌊x⌋). At an integer the left and right definitions of ν agree, since S_1 has the distribution S_0−1. The function I is continuous and convex; away from integers I'(x)=β⌊x⌋. Formula (2.2) becomes

\[
 \nu(x)=C_q^{-1}e^{-I(x)}(1+o(1)), \tag{2.4}
\]

uniformly over all real x above any lower bound tending to infinity.

## 3. Main second-order theorem and its centering

For sufficiently small ε let b=bε>1 be the unique solution of

\[
 I(b)+\log(\beta b C_q)=\log(1/\varepsilon). \tag{3.1}
\]

The left side is continuous and strictly increasing for b>1, and unbounded. In particular,

\[
 b\sim\sqrt{\frac2\beta\log\frac1\varepsilon},
 \qquad \varepsilon b^m\to0\quad(m\text{ fixed}). \tag{3.2}
\]

Let G have the standard Gumbel distribution Pr(G≤z)=exp(−e^{−z}).

**Theorem 2 (continuous extreme law and current-state separation).**

\[
 \beta b_\varepsilon\bigl(M_\varepsilon-b_\varepsilon\bigr)
 \ \Rightarrow\ G. \tag{3.3}
\]

Moreover,

\[
 \left(\beta b_\varepsilon(M_\varepsilon-b_\varepsilon),L(0)\right)
 \ \Rightarrow\ (G,L_*), \tag{3.4}
\]

where L_* has the distribution L(0) and is independent of G. In the random-phase stationary model replace Mε by Wε+L_U(0)+θ(0); G is independent in the limit of the pair (L_U(0),θ(0)).

The phase term u(1−u) in I cannot be omitted from a precision-1/b centering. It is bounded but generally nonvanishing in the exponent. By contrast replacing β⌊b⌋ by βb in the logarithmic prefactor changes the center by o(1/b), and is harmless.

### 3.1 Why continuous monitoring differs from integer monitoring

H rises at slope one between actual arrivals and jumps down by one at each actual arrival. At an appointment epoch its late-pool increment of one cancels the drop of its fractional phase, so it is continuous there. Thus Zε(s)=H(s)+εs rises at slope 1+ε between downward jumps.

For a deterministic threshold x>0, every upward crossing of Zε through x must occur at one of the deterministic times

\[
 s_j=\frac{x+j}{1+\varepsilon},\qquad j\in\mathbb Z. \tag{3.5}
\]

Indeed Zε(s)=(1+ε)s+an integer. At s_j let

\[
 y_j=x-\varepsilon s_j=x+\varepsilon|s_j|,
 \quad k_j=\lfloor y_j\rfloor,
 \quad u_j=\{y_j\}=\{s_j\}.
\]

An upward crossing occurs exactly when

\[
 A_j=\{L(s_j)=k_j\}. \tag{3.6}
\]

No actual arrival coincides with any of the countably many deterministic s_j almost surely. Thus the local slope at s_j is positive and (3.6) is a genuine upward crossing, not merely an equality at a downward jump. As s→−∞, Zε(s)→−∞ almost surely. Therefore {Mε>x} is exactly the event that at least one such crossing occurs at s_j < 0, apart from a possible endpoint equality at 0. The latter has probability at most Pr(L(0)≥⌊x⌋), which tends to zero at the thresholds used below.

This treats the original time orientation. It does not assume that L is reversible. Subsequent dependence bounds always condition from an earlier time to a later time.

### 3.2 Exact expected crossing count and Laplace asymptotics

As s_j runs backward from zero, the y_j form an arithmetic grid above x with mesh h=ε/(1+ε), and initial offset in (0,h]. Thus the total expected crossing count is

\[
 \Lambda_\varepsilon(x)=\sum_{s_j < 0}\nu(y_j).
\]

Using the uniform relative error in (2.4) and monotonicity of e^{−I}, Riemann-sum bounds give

\[
 \Lambda_\varepsilon(x)
 \sim\frac{1+\varepsilon}{\varepsilon C_q}
       \int_x^\infty e^{-I(y)}\,dy
 \sim\frac{(1+\varepsilon)e^{-I(x)}}{\varepsilon\beta xC_q}, \tag{3.7}
\]

whenever x→∞ and εx→0. The mesh error divided by the integral is O(εx)=o(1). For the second equivalence, substitute v=βx(y−x). Then I(x+v/(βx))−I(x)→v for each fixed v, including when x approaches an integer. Convexity gives a dominating bound e^{−v/2} for x large, so dominated convergence proves the assertion.

Take x=xε(z)=b+z/(βb). From (3.1),

\[
 I(x)-I(b)\to z,
 \quad\nu(x)\sim\varepsilon\beta b e^{-z},
 \quad\Lambda_\varepsilon(x)\to e^{-z}. \tag{3.8}
\]

For R>0 set T=R/(εβb). Crossings in the window [−T,0) have total mean

\[
 \Lambda_{\varepsilon,R}(z)\to e^{-z}(1-e^{-R}), \tag{3.9}
\]

while crossings before −T have total mean tending to e^{−z−R}. This follows by applying (3.7) to the two lower endpoints x and x+R/(βb).

### 3.3 Uniform anti-clustering estimate on a fixed rescaled window

Fix R,z. In [−T,0), every high level k_j is either k=⌊x⌋ or k+1 for sufficiently small ε. Consider a crossing event at an earlier candidate time s_i and another h grid steps later, so their time separation is d=h/(1+ε). Conditional on L(s_i)=K∈{k,k+1}, memorylessness gives

\[
 L(s_i+d)=\mathrm{Bin}(K,e^{-\beta d})+J_d, \tag{3.10}
\]

with independent summands. The random variable J_d counts late jobs whose appointments occur after s_i. There are at most h such appointments, and J_d is stochastically dominated by S_0.

For 1≤h≤k/2, another high event requires at least k−h old jobs to survive. Therefore

\[
 \Pr(A_{i+h}\mid A_i)
 \le {k+1\choose h+1}
      \exp\left[-\frac{\beta h(k-h)}{1+\varepsilon}\right]
 \le(k+1)^{h+1}
      \exp\left[-\frac{\beta h(k-h)}{1+\varepsilon}\right]. \tag{3.11}
\]

The sum of (3.11) over this range tends to zero. More explicitly, for ε < 1 and k sufficiently large that log(k+1)≤βk/8, it is at most

\[
 \frac{(k+1)e^{-\beta k/8}}{1-e^{-\beta k/8}}\longrightarrow0. \tag{3.11a}
\]


For h>k/2, either an old job survives or at least k new jobs are late. Hence

\[
 \Pr(A_{i+h}\mid A_i)
 \le(k+1)e^{-\beta h/(1+\varepsilon)}+\Pr(S_0\ge k). \tag{3.12}
\]

Choose a main-block length B=⌈e^b⌉ in candidate indices. By (2.2),

\[
 \log\Pr(S_0\ge k)=-\tfrac\beta2 b^2+O(b),
 \qquad B\Pr(S_0\ge k)\to0.
\]

Since Pr(S_0≥k)≤F_k(0)≤C_q^{-1}e^{-βk(k−1)/2}, summing (3.12) up to B gives the explicit bound

\[
 \frac{(k+1)e^{-\beta k/4}}{1-e^{-\beta/2}}
 +\frac{B}{C_q}e^{-\beta k(k-1)/2}\longrightarrow0. \tag{3.12a}
\]
 We have proved the uniform estimate

\[
 \kappa_\varepsilon:=
 \sup_i\sum_{h=1}^{B}\Pr(A_{i+h}\mid A_i)\to0. \tag{3.13}
\]

The supremum only concerns pairs inside the fixed rescaled window. Crucially, the short-time bound excludes persistent clusters of high late-pool counts, while the long-time bound includes the fresh stationary tail rather than pretending that separated states are already independent.

### 3.4 Independent blocks after input truncation

Take J=⌈b²⌉ recent appointment labels in a truncated pool L^J(s). At any phase,

\[
 \Pr(L^J(s)\ne L(s))\le q^J/(1-q). \tag{3.14}
\]

There are N=O(1/(εb)) candidate times in [−T,0). Hence the probability that any truncated indicator differs from its original counterpart is at most

\[
 \frac{Nq^J}{1-q}\to0, \tag{3.15}
\]

because log(1/ε)=βb²/2+O(b+log b), whereas −log q^J=βb²+O(1).

Split the candidate indices into main blocks of length B=⌈e^b⌉, separated by gaps of length G=⌈3J⌉. Because each time step is 1/(1+ε), for ε < 1 such gaps separate the appointment-label sets used by truncated main blocks. Their occurrence indicators are independent. The expected number of discarded crossings is bounded by

\[
 O\left(\frac{G}{B}N\max_j\Pr(A_j)\right)
 +O((B+G)\max_j\Pr(A_j))=o(1), \tag{3.16}
\]

since N max Pr(A_j)=O(1), max Pr(A_j)=O(εb), G/B→0, and Bεb→0.

The sum, over all main blocks, of probabilities of two or more original crossings is bounded by

\[
 \sum_i\Pr(A_i)\sum_{1\le h\le B}\Pr(A_{i+h}\mid A_i)
 \le\Lambda_{\varepsilon,R}(z)\kappa_\varepsilon=o(1). \tag{3.17}
\]

For a block D, the elementary Bonferroni inequality gives

\[
 0\le\sum_{i\in D}\Pr(A_i)-\Pr\!\left(\bigcup_{i\in D}A_i\right)
 \le\sum_{i < j,\ i,j\in D}\Pr(A_i\cap A_j).
\]

Summing this bound uses exactly the pair sum (3.17). Replacing original block indicators by their truncated versions changes the sum of their probabilities by at most Nq^J/(1−q), not merely by an unquantified error per block. Consequently (3.15)–(3.17) show that the independent truncated block success probabilities π_l satisfy

\[
 \max_l\pi_l\to0,
 \qquad\sum_l\pi_l\to e^{-z}(1-e^{-R}).
\]

For each real t, the characteristic function of their sum is

\[
 \prod_l\{1+\pi_l(e^{it}-1)\}
 \longrightarrow
 \exp\{e^{-z}(1-e^{-R})(e^{it}-1)\},
\]

because Σ_l π_l²≤(max_l π_l)Σ_l π_l→0. Thus the sum converges to a Poisson random variable with mean e^{-z}(1−e^{-R}). The probability of multiple original crossings in any retained block is o(1) by (3.17). Restoring gaps, truncation and endpoints therefore changes the crossing count with probability o(1). This proves both its Poisson limit and the no-crossing probability exp(−e^{-z}(1−e^{-R})), using only independent rare blocks.

### 3.5 Remove the remote-time cutoff

By Markov's inequality and (3.9), the probability of any crossing earlier than −T has limsup at most e^{−z−R}. Let ε↓0 first and then R→∞. Combining the exact crossing interpretation with the block result yields

\[
 \Pr(M_\varepsilon\le b+z/(\beta b))\to\exp(-e^{-z}),
\]

which is (3.3). The direction of the CDF is correct: more upward crossings mean a larger maximum, so a maximum below the threshold corresponds to no crossing.

### 3.6 Independence from the current pool

Delete crossing candidates in [−b²,0). Their total expected count is O(b²·εb)=o(1). All remaining indicators depend only on delay variables with appointment labels at most −b²+O(1). Approximate L(0) using only labels −⌊b²/2⌋,…,0; its error probability is at most q^{b²/2+O(1)}/(1−q)=o(1). This approximation is exactly independent of the remaining crossing events. Thus for every integer m and every real z,

\[
 \Pr(\beta b(M_\varepsilon-b)\le z,L(0)=m)
 \to e^{-e^{-z}}\Pr(L(0)=m).
\]

The marginal L(0) is fixed and tight, so these identities establish (3.4). At arbitrary fixed phase the same constants and estimates are uniform, and conditioning on the independent uniform phase proves the stated random-phase version.

## 4. Additional consequence: the age of the extreme creating the workload

This section proves an additional consequence using joint extremes over disjoint age windows. The age is the location of the maximizing historical peak; no identification with a busy-period age is asserted.

Let Zε(s)=H(s)+εs. Its past supremum is achieved either at 0 or as the left limit immediately before an actual arrival. There are almost surely finitely many arrivals in each bounded interval, and Zε(s)→−∞ as s→−∞. Consequently a maximizing location exists in the left-limit convention. It is almost surely unique: equality of the heights at two distinct actual arrival times requires their time difference to lie in the countable set (1+ε)^{-1}Z; independent continuous delays make this event have probability zero. The same argument handles equality with the endpoint at 0. Let τ_ε≥0 be minus this maximizing time.

**Theorem 3 (height, age, and current state).**

\[
 \left(\beta b(M_\varepsilon-b),\ \varepsilon\beta b\tau_\varepsilon,\ L(0)\right)
 \Rightarrow (G,E,L_*), \tag{4.1}
\]

where E is exponential with rate one and the three limit variables are mutually independent.

### 4.1 Several disjoint age windows

For peak locations and all window maxima, use the upper path envelope \(\widehat Z_\varepsilon(s)=\max\{Z_\varepsilon(s),Z_\varepsilon(s-)\}\), keeping the original time label s. Thus an arrival's pre-jump height belongs to that arrival time. This leaves the full historical supremum unchanged. A window-boundary discrepancy from right-continuous values is treated by the explicit boundary-tail bound below.

For a bounded interval I⊂[0,∞), let

\[
 M_\varepsilon(I)
 =\sup\{\widehat Z_\varepsilon(s):s\le0,
                   \ \varepsilon\beta b(-s)\in I\}.
\]

For finitely many disjoint bounded intervals I_1,…,I_m and real thresholds z_1,…,z_m, the same block proof gives

\[
 \Pr\left(\beta b(M_\varepsilon(I_j)-b)\le z_j,
                    1\le j\le m\right)
 \to
 \exp\left[-\sum_{j=1}^m e^{-z_j}
                   \int_{I_j}e^{-a}\,da\right]. \tag{4.2}
\]

Each interval uses its own threshold and hence a slightly shifted candidate grid. Use a common partition of physical time into main blocks of length B/(1+ε), separated by gaps of length G/(1+ε). Each main block contains B+O(1) candidate points for any threshold; increasing the index cutoff in (3.13) by two leaves its bounds unchanged. Discard blocks meeting the finitely many interval boundaries, together with one adjacent gap. Their total time length is O(m(B+G)), and their expected crossings are o(1). Every remaining main block belongs to one interval, so the single-color anti-clustering estimate applies unchanged. The truncated input sets of retained blocks are disjoint. The mean crossing count in interval I_j is a Riemann sum with a=εβb|s| and

\[
 \nu\left(b+\frac{z_j+a}{\beta b}\right)
 \sim\varepsilon\beta b\,e^{-z_j-a},
\]

uniformly over its bounded a-range. This gives its mean e^{-z_j}∫_{I_j}e^{-a}da. A window might start already above its threshold without an internal upward crossing. At each of the finitely many boundary times, the late-pool tail at the required height is at most exp(−βb²/2+O(b))=o(1). Thus boundary exceedances are negligible and the crossing criterion indeed represents each window maximum. This proves (4.2), including independence of the limiting window maxima. Removing a b² neighborhood of zero as before also gives joint independence from L(0).

### 4.2 From window maxima to the maximizer age

For a finite partition of [0,R] into intervals with weights w_j=∫_{I_j}e^{-a}da, (4.2) gives independent limiting maxima with CDFs exp(−w_j e^{-z}). Their largest value has CDF exp(−w e^{-z}), w=Σ_j w_j=1−e^{-R}. The probability that this largest value is at most z and occurs in interval j is

\[
 \int_{-\infty}^z
   \prod_{i\ne j}e^{-w_i e^{-t}}\,d(e^{-w_j e^{-t}})
 =\frac{w_j}{w}e^{-w e^{-z}}. \tag{4.3}
\]

The limiting maxima have continuous distributions, so ties have probability zero, justifying the argmax mapping for a fixed partition.

The maximizing age is tight. For any real z_0,

\[
 \Pr(\varepsilon\beta b\tau_\varepsilon>R)
 \le\Pr(\beta b(M_\varepsilon-b)\le z_0)
   +\Pr(M_\varepsilon((R,\infty))>b+z_0/(\beta b)).
\]

The first term tends to e^{-e^{-z_0}}. The second has limsup at most e^{-z_0-R}, plus an o(1) boundary term, by the expected-crossing bound. Choose z_0=−R/2 and then R→∞. Hence the right-hand side tends to zero uniformly in the asymptotic limsup.

Use the partition [0,a],(a,R] in (4.3), let ε↓0 and then R→∞. It follows that

\[
 \Pr\left(\beta b(M_\varepsilon-b)\le z,
            \varepsilon\beta b\tau_\varepsilon\le a\right)
 \to e^{-e^{-z}}(1-e^{-a}),\qquad a\ge0.
\]

For a=0, uniqueness means that the maximizing age can equal zero only when Mε=L(0). Its probability is at most Pr(L(0)>b/2)+Pr(Mε≤b/2), which tends to zero. The second term vanishes because the Gumbel convergence makes βb(Mε−b) tight, while its cutoff −βb²/2 tends to −∞. This supplies the endpoint a=0 separately. The same tightness argument justifies thresholds below any fixed normalized level when removing extreme remote ages.

This proves the Gumbel–exponential product law. The current-pool argument in §3.6 applies to every finite collection of window events, giving the third independent component in (4.1).

## 5. Workload fluctuations and the cost of dropping the calendar term

### 5.1 The observable workload has a different leading random scale

**Corollary 4 (two scales).** At appointment phase zero,

\[
 W_\varepsilon(0)-b_\varepsilon\Rightarrow -L_* . \tag{5.1}
\]

Indeed, Theorem 2 makes βb(Mε−b) tight. Since b→∞, Mε−b→0 in probability; subtracting L(0) and applying the joint limit gives (5.1). Thus the order-one fluctuation of the workload is the negative of its current late population. A Gumbel approximation for the uncorrected workload at scale 1/b would discard the larger random term. At uniform appointment phase, the right side is −(L_U(0)+θ(0)), with their actual joint law; the Gumbel limit is independent of that pair, not a claim that the pair's two components are independent.

The results concern the mathematical work buffer. For speed 1+ε, its corresponding virtual waiting time is Wε/(1+ε). For a convention with unit speed and deterministic work ρ < 1 per arrival, use δ=(1−ρ)/ρ in the theorems and multiply the work-buffer quantities by ρ. These are exact changes of units. No simultaneous change in the delay parameter β is included.

### 5.2 The periodic centering is necessary at the Gumbel scale

Let cε>1 solve the smooth-center equation

\[
 \frac\beta2 c_\varepsilon(c_\varepsilon-1)
  +\log(\beta c_\varepsilon C_q)=\log(1/\varepsilon), \tag{5.2}
\]

and put ψ(x)={x}(1−{x}). The periodic extension ψ is continuous, bounded by 1/4, and globally Lipschitz with constant one. Define f(x)=βx(x−1)/2+log(βxC_q). Since f'(x)=βx−β/2+1/x, comparison of f(b)+(β/2)ψ(b)=f(c) first yields b−c=O(1/c). The mean value theorem and the Lipschitz bound then give, uniformly in the fractional part of c,

\[
 \beta c_\varepsilon(b_\varepsilon-c_\varepsilon)
 =-\frac\beta2\psi(c_\varepsilon)+o(1). \tag{5.3}
\]

**Corollary 5 (subsequential shift).** Along every sequence with {cε}→r∈[0,1],

\[
 \beta c_\varepsilon(M_\varepsilon-c_\varepsilon)
 \Rightarrow G-\frac\beta2 r(1-r). \tag{5.4}
\]

To prove this, write its left side as (c/b)βb(Mε−b)+βc(b−c), use c/b→1, and apply (5.3) and Theorem 2. The equation (5.2) makes c a continuous increasing function of log(1/ε) that ranges over all sufficiently large values. Hence integer and half-integer subsequences both exist: their shifts are zero and −β/8, respectively. Dropping the periodic term therefore prevents a universal standard Gumbel limit with that center. This is an order-1/b correction to workload, despite its bounded size in the exponent.

## 6. Continuous extremes for nonmemoryless IFR delays

The exponential delay law can be replaced by a class specified directly through its cumulative hazard. The resulting late-population count need not be a Markov process. Increasing failure rate supplies the residual-life comparison needed for anti-clustering, while independence of the appointment delays supplies the finite-input approximation needed for independent blocks.

Precise tails of infinite sums of independent indicators are studied by Iksanov and Kotelnikova [7]. We give a self-contained static estimate suited to the phase parameter below. The process conclusions require additional arguments: a static tail estimate alone does not imply the continuous drifting-boundary Poisson limit or independence of the peak, its age, and the current population.

### 6.1. Primitive assumptions and the general theorem

Let \(\phi:[0,\infty)\to[0,\infty)\) be continuously differentiable, strictly increasing and convex, with

\[
 \phi(0)=0,
 \qquad \frac{\phi'(t)}{\phi(t)}\longrightarrow0
 \quad(t\to\infty).
 \tag{6.1}
\]

Suppose that the independent appointment delays have survival function

\[
 \Pr(\xi_i>t)=e^{-\phi(t)},\qquad t\ge0.
 \tag{6.2}
\]

Convexity makes the hazard \(\phi'\) nondecreasing. Its limit
\(\ell=\lim_{t\to\infty}\phi'(t)\) belongs to \((0,\infty]\): indeed, strict increase gives \(\phi(1)>0\), and convexity gives \(\phi'(1)\ge\phi(1)\). For finite \(\ell\), set

\[
 C_\ell=\prod_{j=1}^{\infty}(1-e^{-\ell j});
 \qquad C_\infty=1.
 \tag{6.3}
\]

The product is positive when \(\ell < \infty\).

Appointments occur at every integer, each job brings one unit of work, and the work-conserving server has speed \(1+\varepsilon\). As before,

\[
 L(t)=\sum_{i\le\lfloor t\rfloor}{\bf1}\{i+\xi_i>t\},
 \qquad H(t)=L(t)+\{t\},
\]

\[
 M_\varepsilon=W_\varepsilon(0)+L(0)
 =\sup_{s\le0}\{H(s)+\varepsilon s\}.
 \tag{6.4}
\]

All quantities in (6.4) are well defined. Convexity gives \(\phi(t)\ge t\phi(1)\) for \(t\ge1\), so the late population has every exponential moment. Integer-epoch Chernoff bounds, Borel–Cantelli, and \(H(n+u)\le L(n)+1\) imply \(H(s)/|s|\to0\) almost surely as \(s\to-\infty\). Thus the supremum in (6.4) is finite.

For \(x=k+r\), where \(k=\lfloor x\rfloor\) and \(0\le r < 1\), define

\[
 I_\phi(x)=\sum_{j=0}^{k-1}\phi(j+r).
 \tag{6.5}
\]

An empty sum is zero. For sufficiently small \(\varepsilon\), define \(b=b_\varepsilon>1\) and \(a=a_\varepsilon\) by

\[
 I_\phi(b)+\log\bigl(\phi(b)C_\ell\bigr)=\log(1/\varepsilon),
 \qquad a=\phi(b).
 \tag{6.6}
\]

Existence and uniqueness are proved below. An exact identity that will be used repeatedly is

\[
 \varepsilon a=C_\ell^{-1}e^{-I_\phi(b)},
 \qquad (\varepsilon a)^{-1}=C_\ell e^{I_\phi(b)}.
 \tag{6.7}
\]

**Theorem 6.** Under (6.1)–(6.2), the following assertions hold.

1. Uniformly over actual calendar phases \(r\in[0,1)\),

   \[
   \Pr(L(n+r)=k)
   \sim\Pr(L(n+r)\ge k)
   \sim C_\ell^{-1}e^{-I_\phi(k+r)}
   \quad(k\to\infty).
   \tag{6.8}
   \]

2. Fix \(z\in\mathbb R\). Mark every upward crossing of \(H(s)+\varepsilon s\) through \(b+z/a\), for \(s < 0\), by its scaled age \(\varepsilon a(-s)\). The resulting point measure converges, in the Laplace-functional sense explicitly stated in (6.33), to a Poisson random measure on \([0,\infty)\) with intensity \(e^{-z-u}\,du\). In particular, counts on finitely many disjoint bounded age intervals converge jointly to independent Poisson variables. If interval \(I_j\) uses its own fixed threshold \(z_j\), the corresponding counts still converge jointly to independent Poisson variables, now with means \(e^{-z_j}\int_{I_j}e^{-u}du\).

3. Complete the path by its left limits immediately before actual arrivals, retaining the time label of each such peak. Let \(\tau_\varepsilon\) be the age of its unique historical maximizing peak, with age zero if the maximum occurs at the observation endpoint. Then

   \[
   \bigl(a(M_\varepsilon-b),\ \varepsilon a\tau_\varepsilon,\ L(0)\bigr)
   \Rightarrow(G,E,L_*),
   \tag{6.9}
   \]

   where \(G\) is standard Gumbel, \(E\) is exponential with rate one, \(L_*\) has the law of \(L(0)\), and the three variables are mutually independent. In particular, \(W_\varepsilon(0)-b_\varepsilon\Rightarrow-L_*\).

4. The assertions extend uniformly to every fixed observation phase \(v\in[0,1)\), using the exact correction \(W_\varepsilon(v)+L(v)+v\). With an independent uniform shift of the appointment calendar, the limiting \(G,E\) are independent of the pair consisting of the current late population and the observation phase.

The assumptions are on the delay law itself. In particular, the theorem does not assume a late-population tail formula, a mixing estimate, an anti-clustering condition, or a Poisson limit. It concerns the class (6.1), rather than all increasing-failure-rate laws.

### 6.2. A phase-uniform static estimate

For \(0\le r\le1\), let

\[
 S_r=\sum_{j\ge0}B_{j,r},
 \qquad\Pr(B_{j,r}=1)=e^{-\phi(j+r)},
\]

with independent summands. For \(r < 1\), this is the law of \(L(n+r)\). The endpoint \(r=1\) is an analytic extension representing the left limit of the phase family: \(S_1\) has the law of \(S_0-1\), not the law of the right-continuous population \(L(n+1)\).

**Lemma 6.1 (factorial moments and high-state probabilities).** Uniformly for \(r\in[0,1]\),

\[
 F_k(r):=\mathbb E\binom{S_r}{k}
 \sim C_\ell^{-1}\exp\left[-\sum_{j=0}^{k-1}\phi(j+r)\right].
 \tag{6.10}
\]

Both \(\Pr(S_r=k)\) and \(\Pr(S_r\ge k)\) are asymptotic to \(F_k(r)\), uniformly on the same phase interval.

*Proof.* Expand the factorial moment over \(0\le j_1 < \cdots < j_k\), and put \(d_i=j_i-(i-1)\). The index sets correspond bijectively to \(0\le d_1\le\cdots\le d_k\). Hence

\[
 F_k(r)=e^{-I_\phi(k+r)}Z_k(r),
\]

\[
 Z_k(r)=\sum_{0\le d_1\le\cdots\le d_k}
 \exp\left[-\sum_{i=1}^k
 \bigl(\phi(i-1+r+d_i)-\phi(i-1+r)\bigr)\right].
 \tag{6.11}
\]

At the analytic endpoint \(r=1\), the sum in the exponent is understood directly; it agrees with the continuous value in (6.5) at \(k+1\).

Let \(m=\lfloor k/2\rfloor\). The sum of the last \(k-m\) entries of a nondecreasing nonnegative sequence is at least half its total sum. Convexity therefore gives

\[
 \sum_{i=1}^k
 \bigl(\phi(i-1+r+d_i)-\phi(i-1+r)\bigr)
 \ge\frac{\phi'(m)}{2}\sum_{i=1}^k d_i.
 \tag{6.12}
\]

Reverse the positive entries of \((d_i)\) to obtain an integer partition \(\lambda\). For every \(c>0\), the elementary partition identity is

\[
 \sum_\lambda e^{-c|\lambda|}
 =\prod_{j=1}^{\infty}(1-e^{-cj})^{-1} < \infty.
 \tag{6.13}
\]

It follows by independently summing the number of parts of each size.

Suppose first that \(\ell < \infty\). Choose \(c_0\in(0,\ell/2)\). For sufficiently large k, (6.12) bounds every weight in (6.11) by \(e^{-c_0|\lambda|}\). A fixed partition \(\lambda=(\lambda_1\ge\cdots\ge\lambda_m\ge1)\) has cost

\[
 \sum_{i=1}^m
 [\phi(k-i+r+\lambda_i)-\phi(k-i+r)]
 \longrightarrow\ell|\lambda|,
\]

uniformly in \(r\in[0,1]\), because \(\phi'\to\ell\). Truncate the summable partition family in (6.13), take the uniform limit on the remaining finite set, and then remove the truncation. This proves \(Z_k(r)\to C_\ell^{-1}\) uniformly.

If \(\ell=\infty\), let \(c_k=\phi'(\lfloor k/2\rfloor)/2\to\infty\). Equations (6.11)–(6.13) give the uniform bounds

\[
 1\le Z_k(r)\le\prod_{j\ge1}(1-e^{-c_kj})^{-1}\longrightarrow1.
\]

This proves (6.10) in both cases. Moreover,

\[
 \frac{F_{k+1}(r)}{F_k(r)}
 =e^{-\phi(k+r)}\frac{Z_{k+1}(r)}{Z_k(r)}
 =e^{-\phi(k+r)}(1+o(1))
 \tag{6.14}
\]

uniformly in r. Since \(\phi(k)\ge k\phi(1)\), multiplying this ratio by \(k+1\) still gives a quantity tending to zero. Finally, the elementary inequalities

\[
 F_k-(k+1)F_{k+1}
 \le\Pr(S_r=k)\le\Pr(S_r\ge k)\le F_k
\]

prove the assertion. \(\square\)

The two constants have a direct interpretation. When the limiting hazard is finite, every fixed displacement partition retains a finite asymptotic weight, and these weights sum to \(C_\ell^{-1}\). When the hazard diverges, every nonempty displacement partition has diverging cost; the k most recent scheduled labels dominate and the constant is one.

### 6.3. The phase-sensitive center and local scale

**Lemma 6.2 (local rate and Laplace tail).** The function \(I_\phi\) is continuous and convex. Its one-sided derivatives satisfy

\[
 I_\phi'(x)/\phi(x)\longrightarrow1
 \quad(x\to\infty),
 \tag{6.15}
\]

uniformly in the fractional part of x. For every fixed \(K < \infty\),

\[
 \sup_{|v|\le K}
 \left|I_\phi(x+v/\phi(x))-I_\phi(x)-v\right|\longrightarrow0,
 \tag{6.16}
\]

and

\[
 \int_x^\infty e^{-I_\phi(y)}dy
 \sim\frac{e^{-I_\phi(x)}}{\phi(x)}.
 \tag{6.17}
\]

*Proof.* At an integer, the two sums defining the adjacent values of \(I_\phi\) coincide because \(\phi(0)=0\). In an open cell \(x=k+r\),

\[
 D(x):=I_\phi'(x)=\sum_{j=0}^{k-1}\phi'(j+r).
\]

This derivative is nondecreasing within the cell, and its right-minus-left jump at an integer is \(\phi'(0)\ge0\). Thus \(I_\phi\) is convex. The upper and lower Riemann sums for the nondecreasing function \(\phi'\) yield

\[
 \phi(x)-\phi(r)-\phi'(x)+\phi'(r)
 \le D(x)\le\phi(x)-\phi(r).
 \tag{6.18}
\]

The quantities depending only on \(r\in[0,1]\) are bounded. Assumption (6.1) proves (6.15), including the one-sided derivatives at integers.

Since \((\log\phi)'=\phi'/\phi\to0\), integration gives \(\log\phi(x)=o(x)\). Also, uniformly for bounded v,

\[
 \frac{\phi(x+v/\phi(x))}{\phi(x)}\longrightarrow1.
\]

Integrating (6.15) over the corresponding short interval proves (6.16); the argument remains valid when the interval crosses an integer. For \(v\ge0\), convexity and (6.15) imply, for all sufficiently large x,

\[
 I_\phi(x+v/\phi(x))-I_\phi(x)\ge v/2.
\]

The substitution \(v=\phi(x)(y-x)\), (6.16), and dominated convergence with bound \(e^{-v/2}\) prove (6.17). \(\square\)

The function on the left of the center equation (6.6) is continuous, strictly increasing for \(b>1\), and unbounded. The strict increase follows already from the logarithmic \(\phi(b)\) term. Hence b exists uniquely for small \(\varepsilon\), and \(b\to\infty\). For a constant \(c>0\), eventually

\[
 cb^2\le I_\phi(b)\le b\phi(b).
 \tag{6.19}
\]

The lower bound follows by summing \(\phi(j)\ge j\phi(1)\); the upper bound follows termwise from (6.5). In particular,

\[
 e^b\varepsilon a\to0,
 \qquad b^m\varepsilon a\to0
 \quad\text{for every fixed }m>0.
 \tag{6.20}
\]

These estimates will control block endpoints and gaps. No regular-variation assumption is used in Lemma 6.2 or in (6.19).

### 6.4. Exact continuous upcrossings and their means

Write \(Z_\varepsilon(s)=H(s)+\varepsilon s\). It rises with slope \(1+\varepsilon\) between actual arrivals and jumps downward by one at each such arrival. The calendar jump in \(L\) cancels that in the fractional phase. Because
\(Z_\varepsilon(s)=(1+\varepsilon)s+\text{an integer}\), the possible upward crossings of a fixed level x occur exactly at

\[
 s_j=\frac{x+j}{1+\varepsilon},\qquad j\in\mathbb Z.
\]

For \(s_j < 0\), put \(y_j=x-\varepsilon s_j\). Then
\(\{y_j\}=\{s_j\}\), and the crossing event is exactly

\[
 A_j=\{L(s_j)=\lfloor y_j\rfloor\}.
 \tag{6.21}
\]

The delay distribution is continuous, so an actual arrival almost surely does not coincide with any of these countably many deterministic times. Thus equality in (6.21) is a genuine continuous upward crossing. The mass, rather than the tail probability, is the exact crossing probability.

Define \(\nu_\phi(y)=\Pr(S_{\{y\}}=\lfloor y\rfloor)\). Lemma 6.1 gives
\(\nu_\phi(y)\sim C_\ell^{-1}e^{-I_\phi(y)}\), uniformly for all sufficiently large real y. In reverse chronological order the heights \(y_j\) form an arithmetic grid above x, of step \(h=\varepsilon/(1+\varepsilon)\) and initial offset at most h. Monotone Riemann-sum bounds and Lemma 6.2 imply

\[
 \Lambda_\varepsilon(x):=\sum_{s_j < 0}\Pr(A_j)
 \sim\frac{(1+\varepsilon)e^{-I_\phi(x)}}
 {\varepsilon\phi(x)C_\ell},
 \tag{6.22}
\]

provided \(x\to\infty\) and \(\varepsilon\phi(x)\to0\). The relative grid-endpoint error is \(O(h\phi(x))\).

Take \(x=b+z/a\). Equations (6.7) and (6.16) give

\[
 \Lambda_\varepsilon(b+z/a)\longrightarrow e^{-z}.
 \tag{6.23}
\]

A fixed scaled-age interval I has mean crossing count tending to

\[
 e^{-z}\int_Ie^{-u}du.
 \tag{6.24}
\]

In particular, the means in \([0,R]\) and \((R,\infty)\) tend respectively to
\(e^{-z}(1-e^{-R})\) and \(e^{-z-R}\). This follows by applying (6.22) at the lower heights \(b+z/a\) and \(b+(z+R)/a\).

### 6.5. Anti-clustering without memorylessness

**Lemma 6.3 (residual-life domination).** At any deterministic time, condition on a specified set of K pending appointment labels. Over a future interval of length d, the number of these old customers still pending is stochastically dominated by
\(\mathrm{Bin}(K,e^{-\phi(d)})\). The same domination holds after conditioning only on the late-population count K.

*Proof.* An old customer with current lateness age v has residual survival probability

\[
 \Pr(\xi-v>d\mid\xi>v)
 =e^{-[\phi(v+d)-\phi(v)]}
 \le e^{-\phi(d)}.
 \tag{6.25}
\]

The inequality follows from convexity and \(\phi(0)=0\), since
\(\phi(v+d)-\phi(v)\ge\phi(d)\). Conditional on the pending label set, the old survival indicators are independent, and each is dominated by a Bernoulli variable with the displayed common parameter. Mixing over pending label sets of size K preserves the stochastic domination. New appointment variables remain independent of all these past conditions. \(\square\)

In particular, Lemma 6.3 does not assert that residual lifetimes have the same distribution or that the count process \(L\) is Markov.

**Lemma 6.4 (summable local recurrence bound).** Fix a bounded scaled-age window and a fixed threshold z. Let \(B=\lceil e^b\rceil\). Uniformly over candidate events in this window,

\[
 \sum_{h=1}^{3B}\Pr(A_{i+h}\mid A_i)\longrightarrow0,
 \tag{6.26}
\]

where the candidates are indexed in forward calendar order and only pairs lying in the window are included.

*Proof.* The high-state requirements in the window are k or \(k+1\), with \(k=b+O(1)\). Candidate times h steps apart have time difference \(d=h/(1+\varepsilon)\ge h/2\) when \(\varepsilon\le1\), and at most h new appointments intervene. Put \(c_0=\phi(1/2)>0\). Convexity gives
\(\phi(h/2)\ge h\phi(1/2)=c_0h\).

For \(1\le h\le k/2\), another high event requires at least \(k-h\) old customers to survive. By Lemma 6.3 and a factorial-moment bound for the binomial distribution,

\[
 \Pr(A_{i+h}\mid A_i)
 \le {k+1\choose h+1}e^{-c_0h(k-h)}.
 \tag{6.27}
\]

For k large enough that \(\log(k+1)\le c_0k/4\), the sum over these h is at most

\[
 \frac{(k+1)e^{-c_0k/4}}{1-e^{-c_0k/4}}\longrightarrow0.
\]

For \(h>k/2\), either an old customer survives or the newly scheduled customers alone supply the high population. The new population is stochastically dominated by \(S_0\), because it is a subset of the independent Bernoulli variables in a complete phase-specific pool, whose success probabilities are no larger than those at phase zero. Consequently,

\[
 \Pr(A_{i+h}\mid A_i)
 \le(k+1)e^{-c_0h}+p_k,
 \qquad p_k=\Pr(S_0\ge k).
 \tag{6.28}
\]

The sum up to \(3B\) is bounded by

\[
 \frac{(k+1)e^{-c_0k/2}}{1-e^{-c_0}}+3Bp_k\longrightarrow0.
\]

Indeed Lemma 6.1 and (6.19) give \(p_k\le K e^{-c k^2}\) for suitable fixed positive constants and all large k, while \(B=e^{b+o(1)}\) and \(k=b+O(1)\). This proves (6.26). All conditioning proceeds from earlier to later time; no time-reversal assumption is made. \(\square\)

### 6.6. Independent-input blocks and the Poisson limit

Let \(J=\lceil4b^2\rceil\), and form \(L^J(t)\) from the J most recent appointment labels. Uniformly in calendar phase,

\[
 \Pr(L^J(t)\ne L(t))
 \le\sum_{j\ge J}e^{-\phi(j)}
 \le\frac{e^{-\phi(J)}}{1-e^{-\phi(1)}}.
 \tag{6.29}
\]

For the last inequality, convexity implies
\(\phi(J+n)-\phi(J)\ge\phi(n)\ge n\phi(1)\) for integers \(n\ge0\). The number of candidates in a bounded scaled-age window is
\(N=O((\varepsilon a)^{-1})=O(e^{I_\phi(b)})\). Since

\[
 \phi(J)\ge\frac{J}{b}\phi(b)\ge4b\phi(b),
 \qquad I_\phi(b)\le b\phi(b),
\]

the probability of any truncation discrepancy among those candidates is at most

\[
 O(e^{I_\phi(b)-\phi(J)})
 \le O(e^{-3b\phi(b)})\longrightarrow0.
 \tag{6.30}
\]

Partition physical calendar time into main blocks of length \(B=\lceil e^b\rceil\) separated by gaps of length \(3J\). After truncation, different main blocks use disjoint sets of independent appointment variables and hence are exactly independent. The maximum event probability in a bounded scaled-age window is \(O(\varepsilon a)\), by Lemma 6.1 and (6.16). The fraction of time removed as gaps is \(O(J/B)\), and endpoint blocks contain \(O(B+J)\) candidate times. Equations (6.19)–(6.20) show that the total expected number of discarded events is o(1).

For multiple intervals and thresholds, use this same physical-time partition. Discard the finitely many blocks meeting interval boundaries and their adjacent gaps. Each retained block belongs to one interval and uses that interval's own candidate grid, with \((1+\varepsilon)B+O(1)\) points. The different grids are shifted by \(O(1/a)\); they are not identified by a common candidate index. The additional boundary deletion again has expected count o(1).

Let \(N_l\) be the original number of crossings in a retained block. The exact Bonferroni inequality is

\[
 0\le\mathbb E N_l-\Pr(N_l>0)
 \le\mathbb E\binom{N_l}{2}.
 \tag{6.31}
\]

The sum of the pair terms over all retained blocks is bounded by the total mean count times the recurrence sum in Lemma 6.4, and tends to zero. Thus, with probability tending to one, retained blocks contain at most one crossing. The truncation discrepancy is negligible by (6.30).

Let \(\pi_l\) be the success probabilities of the independent truncated block indicators. Their maximum tends to zero, and their sum tends to the corresponding mean in (6.24). For every real t,

\[
 \prod_l\bigl[1+\pi_l(e^{it}-1)\bigr]
 \longrightarrow\exp\bigl[\lambda(e^{it}-1)\bigr].
 \tag{6.32}
\]

The original count differs from this sum of independent indicators with probability tending to zero. This proves a Poisson count limit, rather than only its zero-count probability. For finitely many disjoint age intervals, the retained block sets are disjoint and their joint characteristic function gives independent Poisson limits. The same argument permits distinct fixed thresholds in the different intervals.

For completeness, take a nonnegative continuous function f of compact support in age. Approximate f uniformly by step functions on a finite interval partition. The difference between the two Laplace functionals is at most the uniform approximation error times the expected number of points in that compact interval, which is uniformly bounded by (6.24). The finite-interval count convergence and then refinement of the partition give

\[
 \mathbb E\exp\left[-\sum_{\text{upcrossings }s}f(\varepsilon a(-s))\right]
 \longrightarrow
 \exp\left[-\int_0^\infty(1-e^{-f(u)})e^{-z-u}du\right].
 \tag{6.33}
\]

This is the Laplace functional of the asserted fixed-threshold Poisson random measure. A multithreshold marked-peak process is not required for the conclusions below.

### 6.7. The peak, its age, and the current population

Because \(Z_\varepsilon(s)\to-\infty\) as \(s\to-\infty\), exceeding a threshold entails an upward crossing. Conversely, a crossing before time zero is followed by a positive-length interval above the threshold, almost surely. An equality at the observation endpoint contributes at most a high-state pool probability, which tends to zero by Lemma 6.1.

For each fixed z and R, the zero-count limit on \([0,R]\) is
\(\exp[-e^{-z}(1-e^{-R})]\). The probability of any earlier crossing has limsup at most its limiting mean \(e^{-z-R}\). First let \(\varepsilon\to0\), and then let \(R\to\infty\). This proves

\[
 \Pr(a(M_\varepsilon-b)\le z)\longrightarrow e^{-e^{-z}}.
 \tag{6.34}
\]

We next justify the location variable. There are almost surely finitely many actual arrivals in each bounded time interval. Together with \(Z_\varepsilon(s)\to-\infty\) in the remote past, this implies that the historical supremum occurs either at the observation endpoint or at a left limit immediately before an actual arrival. If two distinct arrival times \(T_i,T_j\) give equal peak heights, then
\((1+\varepsilon)(T_i-T_j)\in\mathbb Z\). Independent continuous delays make this event have probability zero. Equality with the endpoint similarly requires \((1+\varepsilon)T_i\in\mathbb Z\). There are countably many candidate pairs, so the maximizing time label is almost surely unique for each fixed \(\varepsilon\).

For disjoint bounded age intervals \(I_1,\ldots,I_m\), define \(M_\varepsilon(I_j)\) using the same left-limit completion and the actual time label of each peak. The multithreshold count limit yields

\[
 \Pr\bigl(a(M_\varepsilon(I_j)-b)\le z_j, 1\le j\le m\bigr)
 \longrightarrow
 \exp\left[-\sum_j e^{-z_j}\int_{I_j}e^{-u}du\right].
 \tag{6.35}
\]

A window might begin above its threshold without an internal upcrossing. At any of the finitely many boundary times, that error is bounded by
\(\Pr(S_0\ge b-O(1))\to0\), uniformly in phase. Thus (6.35) does describe the window maxima, not just crossing counts.

Partition \([0,R]\) into intervals of positive lengths, and put
\(w_j=\int_{I_j}e^{-u}du\). The limiting window maxima are independent continuous variables with CDFs \(e^{-w_je^{-z}}\). Their maximum is at most z and is attained in interval j with probability

\[
 \frac{w_j}{\sum_iw_i}
 \exp\left[-\left(\sum_iw_i\right)e^{-z}\right].
 \tag{6.36}
\]

This follows by integrating the density of the jth maximum against the CDFs of the others. Ties have limiting probability zero, so the finite-partition argmax mapping is legitimate.

The maximizing scaled age is tight. For fixed \(z_0\) and R,

\[
 \Pr(\varepsilon a\tau_\varepsilon>R)
 \le\Pr(a(M_\varepsilon-b)\le z_0)
 +\Pr(M_\varepsilon((R,\infty))>b+z_0/a).
\]

The limiting upper bound is \(e^{-e^{-z_0}}+e^{-z_0-R}\). For each fixed R choose \(z_0=-R/2\), take the \(\varepsilon\to0\) limsup, and then send R to infinity. No growing-window uniform limit is being assumed. Applying (6.36) to \([0,u]\) and \((u,R]\), then removing the cutoff, gives

\[
 \Pr(a(M_\varepsilon-b)\le z, \varepsilon a\tau_\varepsilon\le u)
 \longrightarrow e^{-e^{-z}}(1-e^{-u}),
 \qquad u>0.
 \tag{6.37}
\]

The zero-age boundary requires a separate argument rather than a zero-weight window. Since \(M_\varepsilon=L(0)\) when the endpoint is the maximizer,

\[
 \Pr(\tau_\varepsilon=0)
 \le\Pr(L(0)>b/2)+\Pr(M_\varepsilon\le b/2)\longrightarrow0.
\]

The first term vanishes because the current population has a fixed distribution. The second vanishes by tightness in (6.34) and \(ab\to\infty\). Thus (6.37) also holds at u=0.

Finally, delete candidate events in the real-time interval \([-J,0]\). Their expected number is \(O(J\varepsilon a)=o(1)\). The remaining events use only appointment labels earlier than approximately \(-J\). Approximate \(L(0)\) using its most recent \(\lfloor J/2\rfloor\) labels; (6.29) bounds the discrepancy by a quantity tending to zero. This current-population approximation is exactly independent of the retained historical events. It follows that the Gumbel variable and every finite vector of window maxima are asymptotically independent of \(L(0)\). Combining this with age tightness and the finite-partition argmax calculation proves the three-way independence in (6.9). Since a=φ(b) tends to infinity, tightness of a(Mε−b) also gives Mε−b→0 in probability. Subtracting the fixed current population proves Wε(0)−bε⇒−L*. At a fixed or uniform phase, the corresponding order-one limit is the negative of the sum of the current population and its shared observation phase.

### 6.8. Observation phase and a uniformly shifted calendar

For \(0\le v < 1\), let

\[
 M_\varepsilon(v)=W_\varepsilon(v)+H(v)
 =\sup_{r\le0}\{H(v+r)+\varepsilon r\}.
\]

The exact candidate grid in relative time is

\[
 r_j=\frac{x-v+j}{1+\varepsilon}.
 \tag{6.38}
\]

With \(y_j=x-\varepsilon r_j\), one has
\(\{y_j\}=\{v+r_j\}\), so the candidate mass is again \(\nu_\phi(y_j)\). Changing v alters only the initial offset of the arithmetic height grid, by at most one grid step. The static estimate is uniform in phase; the residual-life bound, finite-label truncation, block separation, and boundary high-state bound are also uniform. Therefore all preceding distributional estimates hold uniformly for \(v\in[0,1)\).

Since \(H(v)=L(v)+v\) on this half-open phase interval, the correction is exactly \(W+L+v\). If the entire calendar is shifted by an independent uniform U and the observation time is zero, set \(V=\{-U\}\). Condition on this shared phase V, apply the uniform result, and integrate. The limits G and E are independent of \((L_V,V)\), with \(L_V\) having conditional law \(S_v\) given \(V=v\). The phase must be included in the corrected maximum; a bounded phase error is not negligible on the fluctuation scale \(1/a\).

### 6.9. Nonmemoryless examples and their complete centers

**Finite limiting hazard.** Let

\[
 \phi(t)=\beta t-\eta(1-e^{-t}),
 \qquad 0 < \eta < \beta.
\]

Then \(\phi'(t)=\beta-\eta e^{-t}>0\), \(\phi''(t)=\eta e^{-t}>0\),
\(\ell=\beta\), and \(\phi'/\phi\to0\). The delay law is not exponential, but the partition constant remains \(C_\beta\). For \(x=k+r\), its full rate is

\[
 I_\phi(x)=
 \beta\left[\frac{k(k-1)}{2}+kr\right]
 -\eta k
 +\eta e^{-r}\frac{1-e^{-k}}{1-e^{-1}}.
 \tag{6.39}
\]

The center and scale are given explicitly by the scalar equation

\[
 I_\phi(b)+\log\left([\beta b-\eta(1-e^{-b})]C_\beta\right)
 =\log(1/\varepsilon),
 \qquad a=\beta b-\eta(1-e^{-b}).
\]

The limiting hazard alone does not determine the center. If \(b^{(0)}_\varepsilon\) is the center for the exponential law with rate \(\beta\), then

\[
 b_\varepsilon-b^{(0)}_\varepsilon\longrightarrow\eta/\beta.
 \tag{6.40}
\]

To verify this, write \(J_\phi(x)=I_\phi(x)+\log(\phi(x)C_\beta)\), and define \(J_0\) analogously for the exponential law. Equation (6.39) gives
\(J_\phi(x)=J_0(x)-\eta x+O(1)\), uniformly in the fractional part of x. At \(x=b^{(0)}_\varepsilon\), the difference from the desired level is \(-\eta x+O(1)\). For any fixed \(D>\eta/\beta\),
\(J_\phi(x+D)-J_0(x)=(\beta D-\eta)x+O(1)>0\), since
\(J_0'(t)=\beta\lfloor t\rfloor+1/t\) away from integers. Monotonicity confines \(d=b_\varepsilon-x\) to a bounded positive interval. Integrating the same derivative over \([x,x+d]\) gives
\(0=x(\beta d-\eta)+O(1)\), proving (6.40). This nonzero order-one shift is much larger than the Gumbel scale \(1/a\).

**Unbounded hazard: Weibull shapes greater than one.** If
\(\phi(t)=\beta t^\alpha\), with \(\alpha>1\), then \(\ell=\infty\) and \(C_\infty=1\). The complete center and scale satisfy

\[
 \beta\sum_{j=0}^{\lfloor b\rfloor-1}(j+\{b\})^\alpha
 +\log(\beta b^\alpha)=\log(1/\varepsilon),
 \qquad a=\beta b^\alpha.
 \tag{6.41}
\]

The leading center is
\(b\sim[(\alpha+1)\log(1/\varepsilon)/\beta]^{1/(\alpha+1)}\), agreeing with the earlier first-order result, but (6.41) also supplies the fine-scale centering and the joint law of the peak and its age.

For \(\alpha=2\), set \(B_3(r)=r^3-3r^2/2+r/2\). Exact summation gives

\[
 I_\phi(x)=\beta\left[
 \frac{x^3}{3}-\frac{x^2}{2}+\frac{x}{6}
 -\frac{B_3(\{x\})}{3}\right].
 \tag{6.42}
\]

Thus \(b\) solves \(I_\phi(b)+\log(\beta b^2)=\log(1/\varepsilon)\), and the scale is \(a=\beta b^2\). The periodic term in (6.42) is bounded but nonvanishing in the exponent, so it cannot generally be deleted at the stated precision.

**A superpolynomial example.** The function
\(\phi(t)=e^{\sqrt{1+t}}-e\) is continuously differentiable, strictly increasing and convex on \([0,\infty)\). Its second derivative is

\[
 \phi''(t)=
 \frac{e^{\sqrt{1+t}}(\sqrt{1+t}-1)}{4(1+t)^{3/2}}\ge0.
\]

It has \(\ell=\infty\) and \(\phi'/\phi\to0\), while growing faster than every power. The finite sum (6.5) and the scalar equation (6.6) again determine the full center. The class is therefore not restricted to regularly varying cumulative hazards.

Finally, \(\phi(t)=\beta t\) gives \(\ell=\beta\), \(a=\beta b\), and exactly recovers the exponential results. The first-order Weibull theorem for shapes \(0 < \alpha < 1\) remains a separate result: those laws are not in the present convex-hazard class. Nor does Theorem 6 cover every IFR law; for example, \(\phi(t)=e^t-1\) fails (6.1).

## 7. Reproducible finite-traffic checks

### 7.1. Exponential-delay continuous-event simulation

The accompanying C++ event simulator evolves the exponential delayed pool with independent rate-β residual clocks. Between appointments its population is a pure-death chain of total rate βL. At each appointment it increases by one. Continuous peaks are evaluated immediately before actual arrivals and at the observation endpoint. This avoids missing peaks between integer observations. The Python driver records seeds, centers, sample sizes, raw observations, marginal probability checks, and an analytic upcrossing-intensity calculation.

All simulations here use β=1, a backward observation window whose scaled age is 12, and an additional 45 appointment intervals of initial burn-in. The omitted initial pool has coupling-error bound e^{-45}/(1−e^{-1}); this does not bound omission of a maximum earlier than the observation window. The remote-peak error is controlled asymptotically in the proof, while these experiments deliberately remain finite-window illustrations.

| ε | Replicates | bε | Empirical CDF at normalized height 0 | Gumbel KS distance | Mean scaled peak age |
|---:|---:|---:|---:|---:|---:|
| 0.01 | 6,000 | 3.359259 | 0.465333 | 0.124811 | 1.096982 |
| 0.001 | 4,000 | 4.048438 | 0.442750 | 0.077994 | 1.072796 |
| 0.0001 | 2,000 | 4.592558 | 0.396000 | 0.051521 | 1.042235 |
| 0.00001 | 800 | 5.113090 | 0.390000 | 0.038728 | 0.997479 |

The limiting CDF at zero is e^{-1}≈0.367879, and the limiting mean of the age variable is one. The table is descriptive: weak convergence of age is proved, but convergence of its moments is not asserted. Decreasing discrepancies in this run are compatible with the theorem; they are not a statistical proof, a uniform approximation guarantee, or a theorem that the error decreases monotonically in ε. The simulations display visible finite-traffic error and decreasing sample sizes.

The analytic check independently convolves a long finite Bernoulli sequence and compares it to factorial-moment inversion. It then sums the expected crossing counts on their exact deterministic grid using geometric sums within each unit cell, with rapidly decaying series truncated numerically. Checks include centers up to b≈19.57 and thresholds z=−1,0,1. The comparison approaches the predicted e^{-z} intensity with nonmonotone phase effects. These finite-precision calculations supplement the uniform estimates in Sections 2–3 and are not substituted for them.

### 7.2. Nonmemoryless high-precision checks

The script `code/check_ifr.py` also evaluates the nonmemoryless theorem's constants without simulating that queue. It uses positive-term Bernoulli convolution at 90 and 130 decimal digits for φ(t)=t, φ(t)=t−0.6(1−e^(−t)), and φ(t)=βt² with β=0.2 and β=1. The four phases are 0, 0.2, 0.5, and 0.999; the high-state levels are 4, 8, 16, 32, and 64. An overflow bin allows the tail to be summed from positive probabilities rather than obtained by subtracting a cumulative probability from one. Every truncation records a convexity-based bound on the omitted Bernoulli terms.

For k=64, the largest absolute deviation over these four phases of P(S_r=k)/(exp(−Iφ(k+r))/Cℓ) from one is 1.052×10^(−26), 1.293×10^(−26), 9.309×10^(−12), and 6.992×10^(−56), respectively. Across all 80 coefficient/tail comparisons, the largest relative difference between the two precisions is below 7.904×10^(−87). The exponential values are independently checked by factorial-moment inversion. These finite calculations support the formulas; they are not a proof of uniform asymptotics in k, phase, or the delay law.

There are also 128 closed-form comparisons, 32 center and segmented-Laplace-integral calculations, and 128 local-shift evaluations. Convergence of the Laplace approximation can be much slower than convergence of the static high-state ratio. At ε=10^(−1024), the ratios φ(b)exp(Iφ(b))∫_b^∞exp(−Iφ(y))dy are 1.0017424, 1.0083429, 1.0304619, and 1.0526074 for the four models in the same order. Thus even this small ε leaves visible finite-parameter error for the quadratic examples. Phase effects also make the displayed errors nonmonotone along the chosen ε grid. Analytic bounds concern truncated tails and products; cross-precision agreement and independent quadrature comparisons are not certified floating-point interval enclosures.

### 7.3. Reproduction files and commands

The scientific attachments contain `code/simulate.cpp`, `code/reproduce.py`, `code/path_check.py`, `code/check_ifr.py`, the four raw simulation CSV files, and all tabulated numerical outputs under `results/`. The simulation seeds are 2026112600, 2026112601, 2026112602, and 2026112603 in descending ε order. From the accompanying project directory, `python code/reproduce.py` rebuilds the C++ program and reproduces the simulation and exponential analytic checks; `python code/check_ifr.py` reproduces the nonmemoryless coefficient, center, and integral calculations. `python code/path_check.py` checks finite-history endpoint conventions and independent intensity calculations. Required library versions are recorded in `requirements.txt`. Reproduction should use a separate copy if the originally recorded bytes are to be retained.

## 8. Scope and limitations

The first theorem needs i.i.d. nonnegative delays with the precise logarithmic-tail asymptotic; it does not assume a density. The fine theorem in Section 6 covers continuously differentiable, strictly increasing, convex cumulative hazards φ with φ(0)=0 and φ′/φ→0. This is an explicit restricted increasing-hazard class, not all such distributions: φ(t)=exp(t)−1 is excluded. Exponential laws and every Weibull law of shape greater than one are included; decreasing-hazard Weibull shapes are covered only by the first-order theorem. Negative delays, random service requirements, multiple servers, queueing networks, optimized appointment schedules, and joint variation of the delay law with ε are not treated. The proof gives distributional convergence at the fine scale and all positive-order moment convergence only at the first-order workload scale. No uniform finite-ε error bound or residual-moment theorem is claimed.

The process with appointments at integers is stationary under integer shifts and periodic in phase. Continuous-time stationarity is obtained by an independent uniform appointment shift, with the exact additional phase correction stated above. The supremum looks backward in time, but every conditional population calculation runs forward; time reversibility is neither assumed nor needed.

The age τ is the location of the maximizing left-limit historical peak. A queue-busy-period interpretation would need a separate equivalence argument and is not used. The disjoint-window argument establishes the finite family of maxima needed for the joint law. Section 6 additionally proves a fixed-threshold age point-process Laplace functional; no full point process jointly marked by all peak heights and ages is asserted.

The inspected comparisons are documented in the References. De Turck–Fiems [4] is the remaining full-text access limitation, especially its main-text Theorem 2. The current evidence does not identify an equivalent result, but that limitation prevents an unrestricted first-priority claim.

## References

[1] V. F. Araman and P. W. Glynn. *Technical Note–Stability of a Queue Fed by Scheduled Traffic at Critical Loading*. Operations Research 73(5), 2567–2571. Published online 16 September 2024; issue September–October 2025. DOI: [10.1287/opre.2023.0039](https://doi.org/10.1287/opre.2023.0039). Author manuscript: [arXiv:2212.04164](https://arxiv.org/abs/2212.04164).

[2] V. F. Araman, H. Chen, P. W. Glynn, and L. Xia. *On a single server queue fed by scheduled traffic with Pareto perturbations*. Queueing Systems 100, 61–91 (2022). DOI: [10.1007/s11134-021-09732-9](https://doi.org/10.1007/s11134-021-09732-9). [Author-hosted full text](https://web.stanford.edu/~glynn/papers/2022/AramanChenGXia2022.pdf).

[3] C. Lancia, G. Guadagni, S. Ndreca, and B. Scoppola. *Asymptotics for the late arrivals problem*. Mathematical Methods of Operations Research 88, 475–493 (2018). DOI: [10.1007/s00186-018-0643-3](https://doi.org/10.1007/s00186-018-0643-3).

[4] K. De Turck and D. Fiems. *When scheduled arrivals behave like Poisson – until they don’t*. Queueing Systems 110, article 39 (2026). DOI: [10.1007/s11134-026-10000-x](https://doi.org/10.1007/s11134-026-10000-x). Publisher abstract and publicly exposed appendices inspected; main-text Theorem 2 not retrieved.

[5] S. Della Corte and M. Mandjes. *Sample-path Large deviations for Scheduled Arrival Processes with Unpunctuality*. [arXiv:2607.12666](https://arxiv.org/abs/2607.12666), version 1, 14 July 2026. Full author preprint inspected, especially Theorem 5.1 and Section 7.

[6] F. Sabria and C. F. Daganzo. *Approximate expressions for queueing systems with scheduled arrivals and established service order*. Transportation Science 23(3), 159–165 (1989). DOI: [10.1287/trsc.23.3.159](https://doi.org/10.1287/trsc.23.3.159). Publisher abstract inspected for the Gumbel-input distinction.

[7] A. Iksanov and V. Kotelnikova. *On tail behavior of infinite sums of independent indicators*. Probability Surveys 23, 428–483 (2026). DOI: [10.1214/26-PS40](https://doi.org/10.1214/26-PS40). Comparisons use the complete [arXiv:2602.08093v2](https://arxiv.org/html/2602.08093v2), dated 23 August 2026; formal publication metadata is confirmed by the [author bibliography](https://do.csc.knu.ua/iksan/?page_id=14). The final journal text was not retrieved.

[8] G. Guadagni, S. Ndreca, and B. Scoppola. *Queueing systems with pre-scheduled random arrivals*. Mathematical Methods of Operations Research 73, 1–18 (2011). DOI: [10.1007/s00186-010-0330-5](https://doi.org/10.1007/s00186-010-0330-5). Publisher abstract and [author preprint](https://arxiv.org/abs/0805.4472) used to establish the bounded-perturbation and fast/slow scope.

[9] A. Hall and M. G. Temido. *On the maximum of periodic integer-valued sequences with exponential type tails via max-semistable laws*. Journal of Statistical Planning and Inference 142(7), 1824–1836 (2012). DOI: [10.1016/j.jspi.2011.12.020](https://doi.org/10.1016/j.jspi.2011.12.020). Comparison uses the [institutional preprint](https://www.mat.uc.pt/preprints/ps/p0731.pdf), especially its marginal tail-ratio assumptions and periodic integer-time observation regime.

[10] P. W. Glynn and W. Whitt. *Heavy-traffic extreme-value limits for queues*. Operations Research Letters 18(3), 107–111 (1995). DOI: [10.1016/0167-6377(95)00048-8](https://doi.org/10.1016/0167-6377(95)00048-8). [Author-hosted full text](https://www.columbia.edu/~ww2040/HeavyExtreme1995.pdf).
