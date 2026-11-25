# A persistent gap in two-phase oracle scheduling and unconditional adaptive optimization

**Research manuscript — 25 November 2026.** Written mathematics and reported finite exact verification results are presented. Full Lean formalization is incomplete; the computational files are not included in this edition. The manuscript does not claim external peer review or an external academic-value certification.

## Abstract

Dufossé, Dürr, Nadal, Trystram and Vásquez conjectured that optimal deterministic scheduling with a processing-time oracle admits a two-phase structure: test an initial collection of jobs, then execute all remaining jobs without testing. We disprove this conjecture in both their adaptive and non-adaptive models, and show that its failure can persist asymptotically at fixed processing parameters. Our comparison class allows adaptive stopping and arbitrary executions of already tested long jobs during the testing phase. A continuous Bellman potential gives its minimax additive regret, for every fixed processing gap `x>=2`, within a constant of `(1-1/x)n^2`. At `x=3` the exact value is `floor(2n^2/3)` for every number of jobs.

For every fixed `x>2`, we construct non-adaptive words with an initial execution block, a testing block, and a final untested execution block whose regret has a strictly smaller quadratic coefficient. At `x=3` and `n=150k`, the word `E^(6k) T^(54k) E^(90k)` has exact worst regret `14850k^2+9k`, whereas every adaptive physical two-phase policy has worst regret at least `15000k^2`. Every fixed base processing time `p>297` therefore gives a strictly positive limiting lower bound on the competitive-ratio advantage for all sufficiently large `k`.

A smaller exact instance establishes the strongest path-level failure. At eighteen jobs, `p=1260`, and `x=3`, the unrestricted adaptive and non-adaptive optimal ratios both equal `215783/215568`. Every optimal policy begins with an untested execution, and every worst-case path contains a later test. The fixed word `E T^7 E^10` supplies this optimum and beats the entire adaptive physical two-phase class for every `p>645`, with an explicit open extension in both processing parameters. Finally, without a two-phase assumption, we give an exact `O(n^3)`-arithmetic threshold algorithm for the full adaptive game and polynomial-time exact rational reconstruction. The universal separation results have analytic proofs; complete finite integer certificates independently check the eighteen-job instance.

## 1. Problem and contribution boundary

There are `n>=1` independent jobs on one machine. A job has processing time either `p` or `p+x`, where `p,x>0`. All jobs are available initially and are indistinguishable before they are processed or tested. A test occupies the machine for one time unit and reveals the tested job's processing time. An untested job may instead be executed immediately, and its processing time is observed when it completes. A tested job may be executed later. The objective is the sum of job completion times. A clairvoyant scheduler knows every processing time in advance and pays no testing costs.

We use `T` for testing the next unseen job, `E` for executing it without testing, and `P` for executing a pending tested long job. Tested short jobs may be executed immediately, as proved below. A deterministic adaptive policy may choose its actions from the observed history. A non-adaptive policy fixes its `T/E` word in advance. Our counterexample is a fixed word, with the usual rule of immediately executing tested short jobs and postponing tested long jobs, so it is a valid non-adaptive policy under the source's definition.

For a policy `pi` and a binary input `v`, write `ALG_pi(v)` for its total completion time and `OPT(v)` for the clairvoyant optimum. Its competitive ratio is

$$
\mathcal R(\pi)=\max_v\frac{\operatorname{ALG}_\pi(v)}{\operatorname{OPT}(v)}.
$$

All maxima are over finitely many type assignments. Deterministic finite policies suffice: repeated testing and idling reveal nothing useful and cannot improve completion times.

The source's Conjecture 1 appears on page 4 of arXiv:2005.03394v3 and in Section 2 of the published article [1,2]. The source gives conditional optimal algorithms for two-phase policies and finite experiments. The published version also gives a last-three-job structural argument. We do not claim those formulas, algorithms, experiments, or the idea of postponing tested long jobs as new.

There are two distinct structural questions.

* A **canonical two-phase policy** has a `T` prefix followed by an `E` suffix, executes each tested short job immediately, and postpones every tested long job to the end.
* A **physical two-phase policy** forbids further tests after its first `E`, but allows arbitrary legal executions of already tested jobs before and after that switch. Its choice of when to switch may depend on all test outcomes.

The physical class contains the canonical class. Every separation asserted below is against the larger adaptive physical class. Section 4 proves a uniform lower bound that retains early executions of tested long jobs, and an exact all-size value when `x=3`. Section 8 uses these bounds to obtain a quadratic regret separation and a competitive-ratio advantage that remains positive as the number of jobs grows at fixed parameters. The canonical benchmark is also stated separately, so no canonical exchange argument is silently applied to the physical class.

The source's Lemma 2 uses the two-phase assumption in its proof. Consequently it cannot be cited as an unconditional normalization and then used to prove that same assumption. We retain the `P` action in both the full adaptive game and the physical two-phase game. Section 7 separately proves an unconditional adaptive postponement result by a causal policy simulation.

## 2. Completion-time and regret identities

Put

$$
N=\frac{n(n+1)}2.
$$

If an input has `ell` long jobs, then shortest-processing-time order gives

$$
\operatorname{OPT}=pN+x\frac{\ell(\ell+1)}2. \tag{2.1}
$$

An action's rank is the number of jobs still unfinished during that action, including the executed job when the action is an execution. Each action of duration `t` contributes its rank times `t` to total completion time. Every execution contributes its common `p` part; their ranks run through `n,n-1,...,1`, so these common contributions sum to `pN`, regardless of the testing and execution order.

**Lemma 2.1 (regret decomposition).** For every fixed finite schedule,

$$
\operatorname{ALG}-\operatorname{OPT}=A+xI, \tag{2.2}
$$

where `A` is the sum of the ranks of all tests and `I` is the number of pairs consisting of a long job executed before a short job.

**Proof.** Remove tests temporarily without changing execution order. Every adjacent long-short inversion costs exactly `x` relative to the swapped order. Sorting the execution word into all short jobs followed by all long jobs uses exactly `I` such swaps. Restoring each unit test delays exactly its rank many job completions. Summing gives (2.2). This also proves nonnegativity of regret. ∎

The following elementary normalization is valid in the physical two-phase class as well as the unrestricted adaptive class.

**Lemma 2.2 (known-short normalization).** A tested short job may be executed immediately without increasing total completion time on any fixed input.

**Proof.** Move its known execution of length `p` left across intervening tests and executions. Crossing a test removes that test's delay on the short job. Crossing a job of length at least `p` cannot increase the sum of their completion times. The transformed policy simulates the original history with a virtual clock and ignores the earlier completion until the original execution point. It loses no information. This movement does not change the order of unseen-job `T/E` actions, so it preserves the physical two-phase constraint. ∎

## 3. A fixed word with regret 215

Consider `n=18`, `x=3`, and

$$
u=E\,T^7\,E^{10}. \tag{3.1}
$$

Tested short jobs are executed immediately; tested long jobs are executed after the ten-job untested suffix. There is no adaptive choice in the `T/E` word.

**Theorem 3.1.** For every `p>0`, the worst additive regret of `u` is exactly 215. If the first executed job is short, its worst regret is 194; if it is long, its worst regret is 215.

**Proof.** After the first execution, the first test has rank 17. Let `s` be the number of short jobs among the seven tested jobs. For fixed `s`, putting all tested long jobs before all tested short jobs maximizes the sum of test ranks. Each exchange of a tested short job followed by a tested long job raises the later test's rank by one. Hence the maximum test contribution is

$$
A=119-\frac{s(s-1)}2. \tag{3.2}
$$

Let `k` be the number of long jobs among the ten untested suffix jobs. For fixed `k`, putting these long jobs first maximizes inversions. If the first job is short, there are `k(10-k)` inversions. The maximum of (2.2) is therefore

$$
119+3\max_{0\le k\le10}k(10-k)=119+75=194,
$$

attained, for example, when all seven tested jobs are long and the suffix has five long jobs followed by five short jobs.

If the first job is long, it additionally precedes the `s` tested short jobs and the `10-k` suffix short jobs. Thus

$$
\begin{aligned}
\operatorname{ALG}-\operatorname{OPT}
&\le119-\frac{s(s-1)}2
   +3\{s+10-k+k(10-k)\}\\
&=149+\left(3s-\frac{s(s-1)}2\right)+3k(9-k).
\end{aligned} \tag{3.3}
$$

For integers `0<=s<=7`, the parenthesized expression has maximum 6, attained at `s=3,4`. For integers `0<=k<=10`, `k(9-k)` has maximum 20, attained at `k=4,5`. The resulting value is `149+6+60=215`. All ordering choices used to attain the two maxima are simultaneously feasible, so this is an exact value. ∎

For example, the binary input

$$
1\mid1110000\mid1111000000
$$

has the first job long, three tested long jobs followed by four tested short jobs, and four suffix long jobs followed by six suffix short jobs. It attains regret 215 and has eight long jobs in total. Here `1` means long and `0` means short; the separators mark the three blocks in (3.1).

The independent physical-schedule verifier `code/verify_fixed_word_exhaustive.py` enumerates all `2^18=262144` inputs and obtains exactly the two maxima above. This enumeration checks the formula and the scheduling convention; Theorem 3.1 itself follows from the displayed integer maximizations.

## 4. Uniform lower bounds for the complete physical two-phase class

The physical two-phase lower bounds in this section permit adaptive testing, adaptive switching, and early execution of tested long jobs. We first give the exact regret game, then prove a continuous lower potential for every state and every positive processing gap. Its rounding error is bounded independently of the number of jobs. At `x=3`, integrality yields the exact value for every job count.

### 4.1 State semantics and the complete Bellman recurrence

During the testing phase let `f` be the number of unseen jobs, `d` the number of pending tested long jobs, and `b` the number of long jobs already executed. The feasible states satisfy

$$
f,d,b\ge0,\qquad f+d+b\le n.
$$

The remaining jobs outside these three counts are completed short jobs. Their number and all earlier test costs can be removed from the continuation objective. An inversion is charged when its short endpoint is executed: executing a short job at this state creates exactly `b` previously uncharged inversions.

After testing has stopped, executing an unseen job instead of a known long job weakly dominates executing that known long job. Exchange their execution slots, keep the intervening operations in order, and use that the unseen job is no longer than the known long job. A virtual history withholds its earlier observation until the original observation point. This exchange remains entirely within the no-more-testing phase. Repeating it puts pending known long jobs last. Therefore, if no more tests will be made, the exact remaining worst regret is

$$
S_x(f,b)=x\max_{k\in\{0,\ldots,f\}}(b+k)(f-k). \tag{4.1}
$$

The adversary realizes this value with `k` unseen long jobs first, then `f-k` unseen short jobs. Existing pending long jobs are executed last. The `b+k` earlier long jobs each precede the `f-k` short jobs.

Let `Q_x(f,d,b)` denote the physical two-phase minimax remaining regret while testing is still permitted. Lemma 2.2 justifies immediate execution of tested short jobs. The complete recurrence is

$$
Q_x(0,d,b)=0, \tag{4.2}
$$

$$
\begin{aligned}
T_x(f,d,b)
  &=f+d+\max\{xb+Q_x(f-1,d,b),\ Q_x(f-1,d+1,b)\},\\
P_x(f,d,b)
  &=Q_x(f,d-1,b+1)\qquad(d>0),\\
Q_x(f,d,b)
  &=\min\{S_x(f,b),\ T_x(f,d,b),\ P_x(f,d,b)\},
\end{aligned} \tag{4.3}
$$

where the `P` entry is omitted at `d=0`. Stopping is exactly the commitment to no further tests; `P` leaves testing permitted. A tested short job costs its test rank `f+d` and creates `b` inversions. A tested long job costs the same test rank, remains pending, and creates no inversion yet. An early known-long execution increases `b`, decreases `d`, and charges no inversion until a later short job is executed. These observations account for every legal action and justify (4.3) by backward induction. For a deterministic policy, every adversarial path specifies a consistent fixed binary input, so the recurrence has the original worst-case input interpretation.

The induction order is increasing `f` and, for fixed `f`, increasing `d`. There are `binom(n+3,3)` feasible triples. Define the initial physical two-phase regret value by

$$
G_x(n)=Q_x(n,0,0).
$$

### 4.2 A continuous Bellman potential

For real `f,b>=0`, let

$$
s_x(f,b)=x\max_{0\le k\le f}(b+k)(f-k)
=\begin{cases}
xfb,&b\ge f,\\
x(f+b)^2/4,&b\le f.
\end{cases} \tag{4.4}
$$

The maximum in this definition is over real `k`. For integer `f,b`, completing the square and rounding the maximizer `(f-b)/2` to the nearest feasible integer give

$$
S_x(f,b)\ge s_x(f,b)-x/4.
$$

If `b>=f`, the maximum is already attained at the integer endpoint zero and there is no rounding loss.

For real `r>=f`, define

$$
\begin{aligned}
A_x(f,r,b)&=\min_{0\le u\le f}\{(f-u)r+s_x(u,b)\},\\
L_x(f,d,b)&=\max\{xfb,A_x(f,f+d,b)\}.
\end{aligned} \tag{4.5}
$$

The continuous variable `u` defines a comparison function; no fractional jobs are admitted into the scheduling game. Taking `u=f` and taking `k=0` in (4.4) show respectively that `A_x<=s_x(f,b)` and `xfb<=s_x(f,b)`. Hence `L_x<=s_x`.

Write `r=f+d`. An explicit form of this potential is

$$
L_x(f,d,b)=
\begin{cases}
xfb,&b\ge f\ \text{or}\ r\le xb,\\
r(f+b)-r^2/x,&b<f,\ xb\le r\le x(f+b)/2,\\
x(f+b)^2/4,&b<f,\ r\ge x(f+b)/2.
\end{cases} \tag{4.6}
$$

Indeed, minimize `-ru+s_x(u,b)`. On `0<=u<=b` its slope is `xb-r`; on `u>=b` it is a convex quadratic with stationary point `u=2r/x-b`. If `b<f` and `r<=xb`, the minimum occurs at `u=0`, giving `A_x=fr<=xfb`. In the middle interval the stationary point lies in `[b,f]` and gives the middle expression. It dominates `xfb` because

$$
A_x-xfb=(r-xb)(f-r/x)\ge0.
$$

For `r>=x(f+b)/2`, the minimum occurs at `u=f`. If `b>=f`, the entire minimization interval is in the linear part of (4.4), and taking the maximum with `xfb` gives the first expression. All formulas agree at shared boundaries: at `r=xb`, at `r=x(f+b)/2`, and at `b=f`.

**Theorem 4.1 (uniform physical lower potential).** For every real `x>0`, every job count, and every feasible nonnegative integer state,

$$
Q_x(f,d,b)\ge L_x(f,d,b)-x/4. \tag{4.7}
$$

**Proof.** We verify a lower bound for every available action, including `P`.

For the test action, restriction of the minimum in (4.5) to `[0,f-1]` gives

$$
A_x(f,r,b)\le r+A_x(f-1,r,b)
\le r+L_x(f-1,d+1,b).
$$

The long-test child has the same `r`. For the other term defining the parent potential,

$$
r+xb+L_x(f-1,d,b)
\ge r+xb+x(f-1)b\ge xfb.
$$

The two possible test outcomes therefore imply

$$
L_x(f,d,b)\le r+\max\{xb+L_x(f-1,d,b),\ L_x(f-1,d+1,b)\}. \tag{4.8}
$$

Different adversarial outcomes may dominate the two terms of `L_x`; the maximum needs only to dominate each term.

For early execution of a known long job, we prove

$$
L_x(f,d,b)\le L_x(f,d-1,b+1)\qquad(d\ge1). \tag{4.9}
$$

Hold `f` fixed and interpolate by `d(t)=d-t`, `b(t)=b+t`, and `r(t)=f+d-t` for `0<=t<=1`. The condition `r(t)>=f` holds throughout. On the first piece of (4.6), the derivative is `xf>=0`; on its last piece it is `x(f+b(t))/2>=0`. On the middle piece it is

$$
d(t)-b(t)+2r(t)/x
\ge d(t)+r(t)/x\ge0,
$$

using the middle-piece condition `b(t)<=r(t)/x`. The interface expressions `b(t)-f`, `r(t)-xb(t)`, and `r(t)-x(f+b(t))/2` are affine in `t`. Thus the interpolation splits into finitely many pieces with nonnegative derivative; continuity at the interfaces excludes downward jumps. This proves (4.9), including crossings between formulas.

Now induct on `f` and then on `d`, uniformly in `b`. At `f=0`, both `L_x` and `Q_x` are zero. The stopping action obeys the lower bound because `S_x>=s_x-x/4>=L_x-x/4`. Substitution of the two child bounds into the test action and use of (4.8) give

$$
T_x(f,d,b)\ge r+\max\{xb+L_x(f-1,d,b),L_x(f-1,d+1,b)\}-x/4
\ge L_x(f,d,b)-x/4.
$$

For `d>0`, its `P` child precedes the parent in the induction order, so (4.9) gives the same bound for `P_x`. Taking the minimum over all legal actions proves (4.7). The error `x/4` is a single offset of the state potential; it is carried through a maximum and is not accumulated at successive tests. ∎

The monotonicity in (4.9) concerns the comparison potential. It does not assert that `P` is dominated at every physical two-phase state or that the exact physical and canonical values coincide for every real `x`.

### 4.3 Initial values and an exact all-size theorem

**Corollary 4.2 (bounded-error physical value).** For every `x>=2` and integer `n>=1`,

$$
(1-1/x)n^2-x/4\le G_x(n)
\le(1-1/x)n^2+x/16. \tag{4.10}
$$

In particular, for fixed `x>=2`, `G_x(n)/n^2` tends to `1-1/x`.

**Proof.** At `(f,d,b)=(n,0,0)`, (4.6) gives `L_x=(1-1/x)n^2`, proving the lower bound. For the upper bound choose an integer suffix length `q` nearest to `2n/x` in `[0,n]`, and use the canonical word `T^(n-q) E^q`. Its test-rank sum is at most `n(n-q)`, and only the untested suffix contributes inversions. Hence

$$
\begin{aligned}
G_x(n)&\le n(n-q)+x\lfloor q^2/4\rfloor\\
&\le (1-1/x)n^2+\frac{x}{4}(q-2n/x)^2\\
&\le (1-1/x)n^2+x/16.
\end{aligned}
$$

The nearest-integer error is at most one half, since `2n/x` belongs to `[0,n]`. ∎

**Theorem 4.3 (exact physical value at gap three).** For every integer `n>=1`,

$$
G_3(n)=\left\lfloor\frac{2n^2}{3}\right\rfloor. \tag{4.11}
$$

**Proof.** Every action increment and terminal value in (4.1)–(4.3) is integral when `x=3`, so `G_3(n)` is an integer. Corollary 4.2 gives

$$
G_3(n)\ge\left\lceil\frac{2n^2}{3}-\frac34\right\rceil
=\left\lfloor\frac{2n^2}{3}\right\rfloor.
$$

The last equality holds because `n^2` modulo three is zero or one; the fractional part of `2n^2/3` is consequently zero or two thirds.

For a matching upper bound, write `n=3m+r`, where `r` belongs to `{0,1,2}`. Test `a=m` jobs if `r=0,1`, and `a=m+1` if `r=2`, then execute the remaining unseen jobs and finally the pending long jobs. The regret is at most `na+3 floor((n-a)^2/4)`. In these three cases this is respectively

$$
6m^2,\qquad 6m^2+4m,\qquad 6m^2+8m+2,
$$

each equal to the claimed floor. These canonical policies are members of the physical class. ∎

For `n=18`, the value is therefore exactly 216. The word `T^6 E^12` attains it: its test contribution is at most 108 and its suffix contributes at most 36 inversions. The lower bound over the full physical class now follows analytically for every `n`; it does not depend on finite-state extrapolation.

### 4.4 Independent finite certificates

At `n=18`, there are exactly `binom(21,3)=1330` triples. An independent recurrence implementation directly evaluates (4.1)–(4.3) at `x=3` and checks every local equality again. The complete table is not included in this edition. Every common open-phase state is also compared with a separate recurrence that carries an explicit testing-closed flag. The physical two-phase calculations in that second implementation have 2,640 reachable four-coordinate states; they are not the 1,330-triple Q/S table.

A further exact-integer certificate uses the rank-cost and terminal-clairvoyant normalization of Section 9, extended with a two-phase restriction. A separate program checks this integer certificate; its execution reports are not included in this edition. Both formulations give physical two-phase regret 216 and unrestricted regret 215. No floating-point tolerance, sampled parameter grid, conditional postponing lemma, or omitted `P` action is used for these values.

The direct Q/S calculation is the following finite procedure:

```
for f = 0,...,18:
    for d = 0,...,18-f:
        for b = 0,...,18-f-d:
            if f == 0:
                Q[f,d,b] = 0
            else:
                stop = 3 * max((b+k)*(f-k) for k=0,...,f)
                test = f+d + max(3*b+Q[f-1,d,b], Q[f-1,d+1,b])
                Q[f,d,b] = min(stop, test)
                if d > 0:
                    Q[f,d,b] = min(Q[f,d,b], Q[f,d-1,b+1])
assert Q[18,0,0] == 216
```

These checks corroborate the analytic theorem and the state semantics. An independent piecewise-quadratic proof of the all-size `x=3` lower bound is supplied in `research/physical_two_phase_all_n_x3.md`, with a finite integer diagnostic in `code/verify_physical_subsolution.py`. The universal statements in Theorems 4.1 and 4.3 are established by their analytic proofs above.

## 5. Competitive-ratio counterexamples and an open parameter region

**Theorem 5.1 (both models fail on an infinite parameter family).** For `n=18`, `x=3`, and every `p>645`, the fixed non-adaptive policy (3.1) has a smaller worst competitive ratio than every adaptive physical two-phase policy. In particular, the two-phase conjecture is false in both original information models.

**Proof.** On every input,

$$
171p\le\operatorname{OPT}\le171(p+3).
$$

Theorem 3.1 gives

$$
\mathcal R(u)\le1+\frac{215}{171p}.
$$

For each physical two-phase policy, Theorem 4.3 supplies an input with regret at least 216. Consequently its worst ratio is at least

$$
1+\frac{216}{171(p+3)}.
$$

The latter lower bound exceeds the former upper bound by

$$
\frac{p-645}{171p(p+3)}>0. \tag{5.1}
$$

Since `u` is non-adaptive and the comparison class permits adaptive testing, the same strict separation applies to each model separately. ∎

The sufficient threshold 645 is not claimed to be the sharp onset of failure.

**Theorem 5.2 (a two-dimensional open region).** Let

$$
\delta=|x-3|<\frac1{118},\qquad
p>\frac{x(215+37\delta)}{1-118\delta}. \tag{5.2}
$$

Then at `n=18`, policy `u` strictly outperforms every adaptive physical two-phase policy.

**Proof.** By (2.2), a fixed policy on a fixed input has regret `A+xI`. At eighteen jobs, `I<=81`, the maximum possible number of long-short pairs. The policy space is a fixed finite set of decision trees after removal of idling and repeated tests. Finite maxima and minima preserve a common Lipschitz constant, so the minimax physical two-phase regret `g(x)` is 81-Lipschitz. By Theorem 4.3, `g(3)=216`.

For `u`, the inversion count is at most 37: when its first job is short, it is at most 25; when its first job is long, it equals at most `s+10+k(9-k)<=7+10+20=37`. Its worst regret `h(x)` is therefore 37-Lipschitz, and `h(3)=215`. Hence

$$
h(x)\le A_\delta=215+37\delta,\qquad
g(x)\ge B_\delta=216-81\delta.
$$

Use `171p<=OPT<=171(p+x)`. The difference between the resulting two-phase ratio lower bound and the fixed-word upper bound is

$$
\frac{p(1-118\delta)-x(215+37\delta)}{171p(p+x)},
$$

which is positive under (5.2). ∎

This is a robust sufficient region, not a characterization of the complete failure set.

## 6. Exact optimum and failure of the equilibrium-path interpretation

The source distinguishes a worst-case equilibrium path from a policy's behavior after an adversary deviates. A separation against policies that remain two-phase on every history does not by itself settle an interpretation requiring only one optimal equilibrium path to be two-phase. We therefore give an additional exact result.

**Lemma 6.1 (exact ratio of the fixed word).** For `n=18`, `x=3`, and

$$
p\ge\frac{2568}{19},
$$

the policy (3.1) has exact competitive ratio

$$
\mathcal R(u)=1+\frac{215}{171p+108}. \tag{6.1}
$$

**Proof.** Regret 215 is possible only when the first job is long, `s` belongs to `{3,4}`, and `k` belongs to `{4,5}` in (3.3). Such inputs have

$$
\ell=1+(7-s)+k=8-s+k\in\{8,9,10\}
$$

long jobs. If an input has `ell>=8`, its denominator in (2.1) is at least `171p+108`, so (6.1) is an upper bound. If `ell<=7`, its integer regret is at most 214. The inequality

$$
\frac{214}{171p}\le\frac{215}{171p+108}
$$

holds exactly when `171p>=23112`, which is the stated sufficient condition. Finally, the input displayed after Theorem 3.1 has `ell=8` and regret 215, and therefore attains (6.1). ∎

**Theorem 6.2 (exact unrestricted value).** At `n=18`, `p=1260`, `x=3`, the adaptive and non-adaptive optimal ratios are both

$$
\rho_* = \frac{215783}{215568}. \tag{6.2}
$$

At this ratio threshold the full adaptive game's root has the unique minimizing action `E`.

**Proof.** Lemma 6.1 gives an upper bound of (6.2) for a valid non-adaptive policy. The full adaptive threshold recurrence in Section 9, including all `T/E/P` actions, gives exact root payoff zero at (6.2). Its root payoff conditional on beginning with a test is `10471/11976>0`. These finite rational claims are checked by the supplied exact-integer implementation and an independent recurrence implementation; the table has 1,330 states. The reconstruction and comparison reports are not included in this edition.

The threshold theorem proves that the unrestricted adaptive value is (6.2), and that a ratio-optimal policy cannot begin with `T`. Since there is no tested job at the root, `P` is unavailable. The non-adaptive optimum lies between the adaptive optimum and the ratio of `u`, so it is equal to them. ∎

An additional integer certificate at the simpler threshold `rho=1001/1000` gives full root payoff `-71/125` and physical two-phase root payoff `153/500`. These strict signs independently witness a finite ratio separation; they are not used in place of the exact-value reconstruction.

**Theorem 6.3 (every optimal equilibrium path tests after executing).** In the original non-idling `T/E/P` model, at the parameters of Theorem 6.2, every optimal deterministic policy begins with `E`, and every worst-case path of every such policy contains a later `T`. This applies to both information models.

**Proof.** The unique root action follows from Theorem 6.2. Suppose a worst-case path contains no test. Since `p=1260` and `p+x=1263` are divisible by 3, both its total completion time `ALG` and its clairvoyant cost `OPT` are integers divisible by 3. Moreover,

$$
215460\le\operatorname{OPT}\le215973.
$$

A worst-case path of an optimal policy must have ratio exactly (6.2). That fraction is in lowest terms. Thus `OPT` must be an integer multiple of 215568. The displayed interval contains only the multiple 215568, forcing `ALG=215783`. This numerator is not divisible by 3, a contradiction. Therefore the path has a test; its initial `E` precedes that test. ∎

This argument is about every equilibrium path of every optimal policy in the specified model and parameters. It does not replace that quantified statement with a single non-two-phase trajectory produced by one tie-breaking convention. Deliberately inserting idle time into an otherwise suboptimal path is outside the source's action model and outside this all-path assertion.

## 7. Unconditional adaptive postponement by causal simulation

The full algorithm in Section 9 retains `P`, so neither the counterexample nor that algorithm needs the following normalization. We include it because it closes the conditional reduction identified in the source and explains precisely what can be postponed without assuming a two-phase testing order.

**Theorem 7.1 (known-long execution is pointwise dominated).** At any realizable history with an unseen job `j` next in input order and a pending known-long job `K`, every adaptive continuation that first executes `K` is pointwise dominated by an adaptive continuation that first executes `j` without testing.

**Proof.** Fix the original continuation `pi`. The new policy executes `j` first and stores its type. It then simulates the original policy beginning just after `pi`'s first execution of `K`, with a virtual clock and virtual history. All actions on other jobs are reproduced. If the original policy tests `j`, the new policy skips that physical test and injects the already known answer into the virtual history. When the original policy eventually executes `j`, the new policy executes the still-pending job `K` instead.

The construction is causal: the only early answer is the one obtained from the actual first execution, and it is withheld from the simulated policy until the original observation point. The input-order restriction is preserved because `j` was the next unseen job. Each job is executed once. If the original policy tests `j` and delays its execution, the replacement `K` is delayed until that same virtual execution event.

For the cost comparison, first retain any skipped test as a fictitious unit idle action. On a fixed input, the two schedules differ by exchanging an early duration `p+x` and a later duration `a` in `{p,p+x}`. If `m` other jobs complete between the two execution slots, this interchange reduces total completion time by exactly

$$
(m+1)(p+x-a)\ge0.
$$

Arbitrary intervening tests do not affect this identity: they have the same durations and create no completion themselves. Deleting the fictitious test can only reduce later completion times further. The input, and hence `OPT`, is unchanged. ∎

By finite-game backward induction, all premature `P` actions can be eliminated in the unrestricted adaptive model. This proof does not preserve the two-phase constraint: its first `E` may be followed by later simulated tests. That is why Section 4 explicitly retains `P` when lower-bounding the physical two-phase class. We do not silently infer a non-adaptive normalization from this adaptive simulation.

## 8. A persistent advantage from executing before testing

The all-size physical lower bounds allow more than an isolated counterexample. We first give exact regret formulas for simple non-adaptive words. A single early execution already yields a growing advantage at `x=3`. An execution prefix containing a positive fraction of the jobs yields a quadratic regret advantage, which translates into a nonvanishing competitive-ratio gap at fixed processing parameters.

Throughout this section, tested short jobs are executed immediately and tested long jobs are postponed to the end. Let

$$
H_y(a)=\max_{s\in\{0,\ldots,a\}}\left\{ys-\frac{s(s-1)}2\right\}
\qquad(y\ge0).
$$

All finite job-count maxima and minima in this section are over integers. The regret identities do not depend on `p`.

### 8.1 One early execution and the canonical benchmark

**Theorem 8.1 (exact one-early-execution formula).** For `0<=a<=n-1`, the word

$$
u_{n,a}=E\,T^a\,E^{n-a-1}
$$

has worst regret

$$
R_x(n,a)=a(n-1)+x\left\lfloor\frac{(n-a)^2}{4}\right\rfloor+H_x(a). \tag{8.1}
$$

**Proof.** Put `m=n-a-1`. Among the tested jobs let `s` be short, and among the suffix jobs let `k` be long. The largest test cost is `a(n-1)-s(s-1)/2`, realized by tested long jobs first. If the initial job is long, its inversion contribution together with the suffix is

$$
s+m-k+k(m-k)=s+(k+1)(m-k).
$$

The integer maximum of `(k+1)(m-k)` over `0<=k<=m` is `floor((m+1)^2/4)`. Maximizing separately over `s` gives (8.1), and both maxima are simultaneously attainable. If the initial job is short, the corresponding maximum is `a(n-1)+x floor(m^2/4)`, which does not exceed (8.1), since `H_x(a)>=0`. ∎

We also record the exact canonical benchmark. Its proof uses a canonical restriction explicitly; it is not the proof of the physical lower bound in Section 4.

**Theorem 8.2 (canonical two-phase regret).** The minimax additive regret over adaptive canonical two-phase policies is

$$
C_x(n)=\min_{0\le a\le n}\left\{na+x\left\lfloor\frac{(n-a)^2}{4}\right\rfloor\right\}. \tag{8.2}
$$

**Proof.** For a lower bound, let the adversary answer long to every test. Along this path, a deterministic canonical policy eventually stops after some `a` tests. All these tests have rank `n`. The adversary then chooses a balanced long-short split among the remaining `n-a` jobs and puts the long jobs first. Its regret is the expression inside braces. Taking the minimum over `a` proves the lower bound against every adaptive canonical stopping policy. For the upper bound, choose a minimizing fixed `a`, test exactly `a` jobs, and stop. Tests have ranks at most `n`, and at most `floor((n-a)^2/4)` inversions occur in the untested suffix. ∎

**Corollary 8.3 (an infinite physical separation with one early execution).** For every integer `k>=3`, take `n=6k`, `x=3`, and `a=2k+1`. Then

$$
R_3(6k,2k+1)=24k^2-2k+5,
\qquad G_3(6k)=C_3(6k)=24k^2. \tag{8.3}
$$

The regret gap from the complete adaptive physical two-phase class is `2k-5`.

**Proof.** Since `a>=7`, `H_3(a)=6`, attained at `s=3,4`. Substitution of `n-a=4k-1` into (8.1) gives the first identity. Theorem 4.3 gives the physical value, and its canonical attaining policy gives the same canonical value. ∎

The same denominator comparison as in Theorem 5.1 yields a competitive-ratio separation whenever

$$
p>\frac{3(24k^2-2k+5)}{2k-5}.
$$

This sufficient `p` grows with `k`. The next construction produces a separation while `p` remains fixed.

### 8.2 An exact formula with an execution prefix

**Theorem 8.4 (three-block regret formula).** Let `a,b,c` be nonnegative integers with `n=a+b+c`. The non-adaptive word

$$
w_{n;a,b}=E^b\,T^a\,E^c
$$

has exact worst additive regret

$$
W_x(n;a,b)=a(n-b)+
\max_{0\le h\le b}\{xh(b-h)+H_{xh}(a)+S_x(c,h)\}. \tag{8.4}
$$

If `c>=2b`, this simplifies to

$$
W_x(n;a,b)=a(n-b)+H_{xb}(a)
+x\left\lfloor\frac{(n-a)^2}{4}\right\rfloor. \tag{8.5}
$$

**Proof.** Let `h` be the number of long jobs in the first execution block, `s` the number of short jobs in the testing block, and `k` the number of long jobs in the final untested block. Fixing these counts, the adversary maximizes regret by placing long jobs before short jobs within each block. In the prefix and suffix this maximizes inversions; in the testing block it maximizes the ranks of later tests. The orders can be chosen independently and achieved simultaneously.

The test-rank sum is

$$
a(n-b)-s(s-1)/2,
$$

and the inversion count is

$$
h(b-h)+hs+(h+k)(c-k).
$$

The three terms count inversions within the prefix, from the prefix to tested short jobs, and to short jobs in the final untested block. Pending tested long jobs executed at the end add none. Maximizing over `s` and `k`, then over `h`, gives (8.4), including attainment by a binary input.

Suppose `c>=2b`. If `b=0`, there is only the choice `h=0`. Otherwise consider `0<=h<b`. The term `H_{xh}(a)` is nondecreasing in `h`, and, because `h<=b<=c`,

$$
S_x(c,h)=x\left\lfloor\frac{(c+h)^2}{4}\right\rfloor.
$$

Its increment from `h` to `h+1` is

$$
x\left\lfloor\frac{c+h+1}{2}\right\rfloor\ge xb.
$$

The prefix term's increment is `x(b-2h-1)`. Their combined increment is at least `x(2b-2h-1)>=x>0`. Thus the maximizing count is `h=b`. Its prefix inversion term vanishes and `c+b=n-a`, proving (8.5). ∎

For later use, completing the square gives

$$
ys-\frac{s(s-1)}2
=\frac12(y+1/2)^2-\frac12(s-y-1/2)^2. \tag{8.6}
$$

When `a>=y+1`, a nearest integer to `y+1/2` is feasible. Its distance is at most one half, so `H_y(a)` differs from the first term in (8.6) by a number in `[0,1/8]`. In particular, for integer `y`, it equals `y(y+1)/2`, attained at `s=y` and `s=y+1`.

### 8.3 Every fixed gap greater than two admits a persistent separation

Write `R_two^*(n,p,x)` for the optimal competitive ratio in the adaptive physical two-phase class, and `R_word,n(p,x)` for the ratio of the word constructed below. These are worst-input ratios, rather than ratios of worst regrets.

**Theorem 8.5 (a nonvanishing competitive-ratio gap).** Fix any real `x>2` and put

$$
C_x^{\rm lead}=1-1/x,\qquad
\beta=\frac{x-2}{x^3-2},\qquad
\alpha=x^2\beta,\qquad
\gamma_x=\frac{(x-2)^2}{2x(x^3-2)}>0. \tag{8.7}
$$

Set `b_n=floor(beta n)`, `a_n=floor(alpha n)`, and `c_n=n-a_n-b_n`, and use the non-adaptive word `E^(b_n) T^(a_n) E^(c_n)`. Then

$$
\frac{W_x(n;a_n,b_n)}{n^2}\longrightarrow C_x^{\rm lead}-\gamma_x,
\qquad
\frac{G_x(n)}{n^2}\longrightarrow C_x^{\rm lead}. \tag{8.8}
$$

For every fixed

$$
p>p_{\rm suff}(x):=
\frac{x(C_x^{\rm lead}-\gamma_x)}{\gamma_x}, \tag{8.9}
$$

the competitive-ratio gap satisfies

$$
\liminf_{n\to\infty}
\{\mathcal R_{\rm two}^*(n,p,x)-\mathcal R_{\rm word,n}(p,x)\}
\ge
\frac{2\{\gamma_xp-x(C_x^{\rm lead}-\gamma_x)\}}{p(p+x)}>0. \tag{8.10}
$$

**Proof.** The constants `alpha,beta` are positive. Moreover,

$$
1-\alpha-\beta=\frac{x(2x-1)}{x^3-2}>0,
\qquad
\alpha-x\beta=x(x-1)\beta>0.
$$

The first identity ensures `c_n>=0`. In addition,

$$
1-\alpha-3\beta=\frac{2x^2-3x+4}{x^3-2}>0.
$$

The numerator is positive because its discriminant is negative and its leading coefficient is positive. It follows that `c_n>=2b_n` for all sufficiently large `n`. Since `a_n-xb_n>=(alpha-x beta)n-1`, we also have `a_n>=xb_n+1` eventually. Thus (8.5) and the interior quadratic maximum in (8.6) apply.

The rounding errors in `a_n,b_n` are bounded by one, the floor in (8.5) loses less than one, and (8.6) loses at most one eighth. Consequently

$$
\begin{aligned}
\lim_{n\to\infty}\frac{W_x(n;a_n,b_n)}{n^2}
&=F_x(\alpha,\beta)\\
&:=\alpha(1-\beta)+\frac{x}{4}(1-\alpha)^2
+\frac{x^2\beta^2}{2}.
\end{aligned}
$$

To compute this value explicitly, for fixed `beta` the minimizing `alpha` of the displayed quadratic is `1-2(1-beta)/x`. Substituting it yields

$$
C_x^{\rm lead}-(1-2/x)\beta+(x^2/2-1/x)\beta^2.
$$

Its quadratic coefficient is positive, and its minimizing `beta` is `(x-2)/(x^3-2)`. The corresponding `alpha` is exactly `x^2 beta`, and the reduction in the quadratic is `gamma_x`. This proves the first limit in (8.8). This algebra optimizes the displayed interior-regime quadratic; it does not assert global optimality among all words or policies. Corollary 4.2 proves the second limit.

For every input, `pN<=OPT<=(p+x)N`. Every physical two-phase policy has an input with regret at least `G_x(n)`, whereas the word's regret never exceeds `W_x(n;a_n,b_n)`. Therefore

$$
\begin{aligned}
\mathcal R_{\rm two}^*(n,p,x)&\ge1+\frac{G_x(n)}{N(p+x)},\\
\mathcal R_{\rm word,n}(p,x)&\le1+\frac{W_x(n;a_n,b_n)}{Np}.
\end{aligned}
$$

Subtract these inequalities, use `N/n^2` tending to one half, and apply (8.8). The resulting limiting lower bound is

$$
2\left\{\frac{C_x^{\rm lead}}{p+x}
-\frac{C_x^{\rm lead}-\gamma_x}{p}\right\},
$$

which equals (8.10) and is positive under (8.9). ∎

The conditions `x>2` and `p>p_suff(x)` define an open set of fixed processing parameters. The comparison permits adaptive behavior throughout the larger physical two-phase class, whereas the improving word is non-adaptive. Thus the separation applies to both original information models and also lower-bounds the gap between the best physical two-phase ratio and the unrestricted optimum. It is not an all-equilibrium-path statement at these general parameters; that stronger quantified conclusion remains the exact eighteen-job result in Theorem 6.3.

### 8.4 A concrete quadratic-gap family at gap three

**Theorem 8.6 (an exact infinite family at fixed processing parameters).** For every integer `k>=1`, let

$$
n=150k,\qquad b=6k,\qquad a=54k,\qquad c=90k,
$$

and set `x=3`. The word `E^(6k) T^(54k) E^(90k)` has exact worst regret

$$
W_3=14850k^2+9k,
\qquad
G_3(150k)=15000k^2. \tag{8.11}
$$

Its regret advantage over every adaptive physical two-phase policy is at least `150k^2-9k`. The difference between the best physical two-phase competitive ratio and this word's ratio is at least

$$
\Delta_k(p)=
\frac{150(p-297)k-9(p+3)}{75(150k+1)p(p+3)}. \tag{8.12}
$$

In particular, the word is strictly better whenever

$$
p>\frac{44550k+27}{150k-9}. \tag{8.13}
$$

Every fixed `p>44577/141` satisfies this sufficient condition for all `k>=1`; every fixed `p>297` satisfies it for all sufficiently large `k`. For the latter range,

$$
\liminf_{k\to\infty}
\{\mathcal R_{\rm two}^*(150k,p,3)-\mathcal R_{\rm word,k}(p,3)\}
\ge\frac{p-297}{75p(p+3)}>0. \tag{8.14}
$$

**Proof.** The counts satisfy `c>=2b` and `a>=3b+1`. The exact maximum `H_(18k)(54k)` is `18k(18k+1)/2`, attained at `s=18k,18k+1`. Formula (8.5) gives

$$
W_3=7776k^2+(162k^2+9k)+6912k^2
=14850k^2+9k.
$$

Theorem 4.3 gives `G_3(150k)=15000k^2`. Thus the regret gap is positive even at `k=1` and is quadratic in the number of jobs.

Since `N=11250k^2+75k=75k(150k+1)`, the denominator comparison used in Theorem 8.5 gives

$$
\mathcal R_{\rm two}^*-
\mathcal R_{\rm word,k}
\ge\frac{pG_3-(p+3)W_3}{Np(p+3)}
=\Delta_k(p).
$$

Its numerator is positive exactly when (8.13) holds. That threshold decreases with `k>=1`: as a real function its derivative has numerator `-405000`, with a positive squared denominator. It equals `44577/141` at `k=1` and tends to 297. More explicitly, for `p>297`, positivity holds as soon as

$$
k>\frac{9(p+3)}{150(p-297)}.
$$

Taking the limit of (8.12) proves (8.14). ∎

At `x=3`, the constants in Theorem 8.5 are `beta=1/25`, `alpha=9/25`, and `gamma_3=1/150`, and its sufficient threshold is exactly 297. The subsequence in Theorem 8.6 makes all counts integral and the suffix square even, so it yields explicit finite-size expressions in addition to the general asymptotic result. The displayed competitive-ratio gaps are lower bounds on actual differences, not claims that those differences have exactly the displayed limits. Neither 297 nor the finite-size thresholds are claimed sharp.

The independent verifier evaluates actual schedules on 94,204 inputs across 438 small word-and-parameter combinations. It also checks the finite count maximizations for the first six members of the large family . These checks corroborate the formulas. The arbitrary-size theorems follow from the proofs in this section and the analytic physical lower bounds in Section 4.

## 9. An unconditional exact algorithm for the full adaptive model

### 9.1 Threshold dynamic programming

Fix a real threshold `rho` and put `B=pN`. After known-short normalization, let `f` be the number of unseen jobs, `d` the number of pending tested long jobs, and `ell` the total number of long jobs revealed, including previously executed long jobs. The feasible states are

$$
0\le d\le\ell\le n-f.
$$

The current rank is `r=f+d`. Let `V_rho(f,d,ell)` be the minimax remaining contribution to `ALG-rho*OPT` after removing the common term `B(1-rho)` and already accumulated test and long-execution rank costs. Its terminal value is

$$
V_\rho(0,d,\ell)=x\binom{d+1}{2}-\rho x\binom{\ell+1}{2}. \tag{9.1}
$$

For `f>0`, define

$$
\begin{aligned}
T&=r+\max\{V_\rho(f-1,d,\ell),V_\rho(f-1,d+1,\ell+1)\},\\
E&=\max\{V_\rho(f-1,d,\ell),xr+V_\rho(f-1,d,\ell+1)\},\\
P&=xr+V_\rho(f,d-1,\ell)\quad(d>0),\\
V_\rho(f,d,\ell)&=\min\{T,E,P\}.
\end{aligned} \tag{9.2}
$$

Again `P` is omitted at `d=0`. It is retained elsewhere, regardless of Theorem 7.1.

**Theorem 9.1 (full adaptive threshold theorem).** For every `n>=1`, real `p,x>0`, and real `rho`,

$$
M(\rho):=B(1-\rho)+V_\rho(n,0,0)\le0
\quad\Longleftrightarrow\quad
\mathcal R^*(n,p,x)\le\rho, \tag{9.3}
$$

where `R*` is the unrestricted deterministic adaptive minimax competitive ratio. The table uses `O(n^3)` arithmetic operations and `O(n^3)` storage. A minimizing table at its zero gives an optimal adaptive policy.

**Proof.** At a fixed threshold, accrued cost is an additive constant, so omitting it from a continuation state loses no optimal action. Every test contributes its current rank, every long execution contributes `x` times its rank beyond the common `pN`, and the final clairvoyant long contribution is `x binom(ell+1,2)`. These facts give (9.1) and every branch of (9.2). The induction order is increasing `f` and then increasing `d`; `ell` indexes the remaining finite entries. All admissible actions are included.

For a fixed deterministic policy, an adaptive adversary is equivalent in value to a fixed input: each realized adversarial path defines a consistent binary type assignment, and each fixed assignment induces one such path. No distributional assumption is required. Thus the maximum in the recurrence has precisely the original worst-case meaning.

If `M(rho)<=0`, choose minimizing actions in the table; then every leaf satisfies `ALG-rho*OPT<=0`, and all denominators are positive. Conversely, a policy with ratio at most `rho` makes every such leaf payoff nonpositive, so the minimizing recurrence is nonpositive as well. This proves (9.3).

The number of feasible triples is `binom(n+3,3)`, and each entry has a constant number of actions and comparisons. There are at most `2n` physical tests and executions, so action lookup after preprocessing takes constant time per decision. Finally, `M` is a finite minimum/maximum of affine leaf payoffs, hence continuous. If a threshold is increased by `h>0`, every leaf decreases by at least `h pN`; the same bound survives minima and maxima. Therefore `M` is strictly decreasing and has a unique zero, the optimal ratio. ∎

This theorem is a fixed-threshold state-compression result. It does not claim that a ratio-optimal continuation from an arbitrary history can ignore accrued cost without fixing a threshold first. For real inputs, the operation bound uses exact real arithmetic and comparison.

### 9.2 Exact rational values and bit complexity

**Theorem 9.2 (exact rational optimization).** Suppose `p=P/Q` and `x=X/Q`, with positive integers `P,X,Q`, and let `L` bound their binary encoding lengths. Then the exact adaptive minimax ratio and an optimal policy can be found using

$$
O\bigl(n^3(L+\log n)\bigr)
$$

arithmetic operations on integers with `O(L+log n)` bits, up to constant factors. In particular, the bit complexity is polynomial in `n` and the rational input length.

**Proof.** Let `D=N(P+X)`. After multiplying all durations by `Q`, every leaf ratio has positive integer denominator

$$
PN+X\binom{\ell+1}{2}\le D.
$$

The finite minimax value is one of the leaf ratios: successive maxima and minima each select a child value. Its reduced denominator is therefore at most `D`.

The no-testing policy gives `1<=R*<=n`: its sum of completion times is at most `n` times total processing, while `OPT` is at least total processing. For `n=1`, the value is 1. Otherwise bisect `[1,n]` with Theorem 9.1 until its width is less than `1/(2D^2)`, unless an exact zero is found earlier. This takes `O(log n+log D)` evaluations. Distinct reduced rationals of denominator at most `D` differ by at least `1/D^2`, so `R*` is the unique such rational closest to the interval midpoint. A bounded-denominator continued-fraction approximation recovers it. Re-evaluate the threshold at the reconstructed fraction and require an exact zero.

At a rational threshold `rho=A/C`, multiply the entire recurrence by `CQ`. Its terminal entries become

$$
CX\binom{d+1}{2}-AX\binom{\ell+1}{2},
$$

its test costs are `CQr`, its long-execution costs are `CXr`, and its root offset is `(C-A)PN`. Thus every evaluation uses only exact integers. Bisection and reconstruction require integer lengths `O(L+log n)`; path costs sum at most a polynomial number of quantities of those lengths. Multiplying the per-table operation count by the number of evaluations proves the bound. Continued-fraction reconstruction also has polynomial bit complexity. ∎

The dependence is polynomial in the number of jobs, not in `log n` alone. Fractional-objective thresholding, backward induction, bisection, and continued fractions are standard methods; thresholding has a classical optimization literature, including [4]. The contribution here is the application-specific full-game state and its unconditional exact policy extraction, together with the counterexample to the structural conjecture.

## 10. Reproduction, verification scope, and limitations

The principal evidence is summarized below. Finite diagnostics and exact certificates are distinguished from the analytic arguments that quantify over arbitrary numbers of jobs.

| Claim | Evidence |
| --- | --- |
| General physical two-phase lower potential | Continuous stopping envelope, test inequality, and monotonicity under `P` in Theorem 4.1 |
| Physical regret within a constant of `(1-1/x)n^2` for `x>=2` | Potential lower bound and rounded canonical upper bound in Corollary 4.2 |
| Exact physical value `floor(2n^2/3)` for every `n` | Integrality and an explicit attaining policy in Theorem 4.3; independent supplementary potential proof |
| Fixed eighteen-job word has exact regret 215 | Analytic proof in Section 3; complete binary-input enumeration |
| Physical two-phase regret is 216 at eighteen jobs | Theorem 4.3; complete 1,330-triple Q/S certificate and separate phase-flag recurrence |
| Exact optimal ratio `215783/215568` | General threshold theorem; integer threshold table; bounded-denominator reconstruction; independent implementation |
| Every optimal equilibrium path is non-two-phase at the exact instance | Positive root-test margin plus the arithmetic proof in Theorem 6.3 |
| Eighteen-job open parameter region | Lipschitz and denominator proof in Theorem 5.2 |
| Quadratic regret and persistent ratio gaps for every fixed `x>2` in the stated `p` range | Exact three-block formula, asymptotic coefficients, and denominator comparisons in Theorems 8.4–8.6 |
| General exact adaptive algorithm | Full-state backward induction and rational reconstruction in Section 9 |

The universal physical lower bounds do not rest on extrapolation from a finite grid. They also do not require the unproved assertion that early known-long execution is dominated within the two-phase class. We prove the exact physical value for all job counts at `x=3`, and a bounded-error description for all real `x>=2`; we do not claim an exact physical value for every other real gap. The three-block words need not be globally optimal. The sufficient thresholds in Theorem 5.1, Theorem 5.2, Lemma 6.1, and Theorems 8.5–8.6 are not claimed sharp. The statement about every worst-case path of every optimal policy is restricted to the original non-idling model and the exact parameters in Theorem 6.3.

No claim is made about randomized policies, unequal testing costs, more than two processing times, multiple machines, release dates, or general scheduling with interval uncertainty. In particular, the recent multi-machine obligatory-test model in [5] requires every job to be tested before execution and does not permit the untested `E` action used here; its stated scope is different from the conjecture studied in this manuscript.

Literature checking used the complete arXiv v3 PDF, the author's companion site, and retrieved publisher text. Direct opening of the journal page was blocked, so journal-only additions were checked in the publisher's indexed text. For [5], only the retrieved primary abstract was inspected; its full text was not opened. In the inspected search scope we did not find a later resolution of the stated conjecture. This is a bounded novelty check, not a guarantee of worldwide priority.

The written proofs and executable exact certificates do not constitute Lean kernel verification. Full formalization remains incomplete. Any formal proof of a finite certificate must establish every checked identity and its relation to the original scheduling semantics within the proof kernel, rather than assume the correctness of a Python output.

## References

[1] F. Dufossé, C. Dürr, N. Nadal, D. Trystram, and Ó. C. Vásquez. *Scheduling with a processing time oracle*. arXiv:2005.03394v3, 5 May 2021. https://arxiv.org/abs/2005.03394v3. Conjecture 1 on page 4; conditional postponing discussion on pages 9–10; conditional adaptive algorithm in Theorem 3.

[2] F. Dufossé, C. Dürr, N. Nadal, D. Trystram, and Ó. C. Vásquez. *Scheduling with a processing time oracle*. Applied Mathematical Modelling 104 (2022), 701–720. https://doi.org/10.1016/j.apm.2021.12.020. Sections 2, 5, and 9 were checked through retrieved publisher text.

[3] C. Dürr. Author companion programs for *Scheduling with a processing time oracle*. https://www.lip6.fr/Christoph.Durr/Scheduling-w-Oracle/. The original finite-search programs are prior work; the present exact verifiers use independently specified recurrences and physical-schedule enumeration.

[4] W. Dinkelbach. *On Nonlinear Fractional Programming*. Management Science 13(7) (1967), 492–498. https://doi.org/10.1287/mnsc.13.7.492. Cited as background for fractional-objective thresholding; the threshold equivalence used here is proved in Section 9.

[5] K.-C. Liang and Y.-C. Liang. *The Completion-Threshold Framework for Obligatory-Test Scheduling on Multiple Machines*. arXiv:2606.02029v1, 1 June 2026. https://arxiv.org/abs/2606.02029v1. Comparison based on the retrieved primary abstract only.
