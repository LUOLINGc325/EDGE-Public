---
title: "Serial service and the exact ordinal scheduling frontier"
subtitle: "Geometric prefetch and the boundary at time zero"
lang: en
---

# Serial service and the exact ordinal scheduling frontier

## Abstract

The exact ordinal-advice frontier for non-clairvoyant scheduling uses continuously divisible processing rates. We determine what changes when the processor may serve only one job at a time. A geometric prefetch construction serializes any deterministic fluid policy while inflating each job's completion time by at most an arbitrary factor 1+δ. The schedule has finitely many switches on every interval bounded away from zero. This preserves the entire fixed-job frontier as an infimum at every interior robustness budget. The minimum fluid robustness is not attained by any deterministic serial policy, and disallowing an accumulation of initial switches raises the minimum robustness all the way to the number of jobs.

## 1. Models and results

There are n≥2 positive-size jobs, all released at time zero. The sizes are unknown until completion. A deterministic policy observes completion events and has ordinal advice in the form of a permutation of the jobs. Its consistency and robustness are the worst ratios of its total completion cost to the clairvoyant optimum under, respectively, correct and arbitrary advised orders. Ties are correct in either relative order. The offline optimum is

~~~text
P_n(x)=∑_i x_i+∑_(i<j) min(x_i,x_j).
~~~

A fluid policy gives nonnegative simultaneous processing rates with sum at most one. A serial policy runs at most one job at unit rate at almost every time. We distinguish two serial classes. One allows countably many switches accumulating at time zero, and requires finitely many on every compact interval in (0,∞). The other requires finitely many switches on every bounded interval including zero.

The pinned *Ordinal predictions attain the exact finite-job scheduling frontier* gives the deterministic fluid optimum c_n(R), a continuous function of the robustness budget R on [b_n,n], where b_n=2n/(n+1). It explicitly leaves serial service outside its result.

**Theorem 1.** For every δ>0 and any deterministic causal fluid policy A with finite completion times on positive-size instances, there is a deterministic serial policy S in the first class, with the same advice and completion observations, such that for every job i and every instance,

~~~text
C_i(S) ≤ (1+δ) C_i(A).                                       (1)
~~~

**Theorem 2.** In that serial class the infimum consistency at robustness at most R equals c_n(R) for b_n<R≤n. Its robustness infimum is b_n, with no deterministic serial policy attaining b_n. In the second serial class finite robustness below n is impossible, while robustness n and consistency one are attained simultaneously by following the advised order serially.

Equation (1) addresses completion times individually. It does not require the virtual policy A to know sizes or to obey any specific phase or rank rule.

## 2. Geometric prefetch

Write e_i(t) for virtual attained service under the fluid policy. Fix δ>0 and let

~~~text
t_j=(1+δ/n)^j,    Δ_j=t_(j+1)−t_j=(δ/n)t_j,    j∈Z.
~~~

Suppose phase j starts with the virtual execution known through t_j. Take the target service for physical job i to be e_i(t_j)+Δ_j. In a fixed job order, process each still-unfinished job serially to this target, or until it completes if it needs less service. Sizes become available only when physically completed. Targets are nondecreasing in j, since both attained virtual service and Δ_j are nondecreasing.

After this prefetch, all sizes that could be encountered during the next virtual interval are known. Indeed, in time Δ_j no job gains more service than Δ_j in the fluid schedule. A job still physically unfinished has size strictly greater than its target e_i(t_j)+Δ_j, so cannot finish in the virtual interval. This remains true at the right endpoint, since a physical completion exactly at the target is observed. For a formal simulation, replace every physically unfinished size by any fictitious size strictly larger than its target. The continuation of A on those fictitious sizes has the same observed virtual history through t_(j+1), by causality. Reveal each physically known completion to A only at the virtual time when its service reaches the actual size. The simulated history through t_(j+1) is therefore exact. It supplies the next targets, and does not change the advice that A receives.

At the end of phase j, the physical service received by each job is the lesser of its true size and e_i(t_j)+Δ_j. There is no physical idle time between service pieces. Thus the elapsed physical time by that end is bounded by

~~~text
∑_i e_i(t_j)+nΔ_j ≤ t_j+nΔ_j=(1+δ)t_j.                       (2)
~~~

If a job completes virtually in (t_j,t_(j+1)], the prefetch of phase j has already completed it physically. Its physical completion time is no later than (2), which is at most (1+δ) times its virtual completion time. This proves (1) once the procedure is initialized at zero.

### 2.1. Initialization without a least epoch

Let e_i^0(t) be the deterministic no-completion trajectory of A for the given advice. Every finite prefix of this trajectory can be realized by sufficiently large sizes, so its finite restrictions are compatible by causality. For the no-completion path, define physical phase j by moving the jobs in fixed order from targets e_i^0(t_(j−1))+Δ_(j−1) to targets e_i^0(t_j)+Δ_j. The scheduled physical end of this phase is

~~~text
B_j=∑_i e_i^0(t_j)+nΔ_j.
~~~

These ends increase strictly and tend to zero as j tends to minus infinity. The successive serial intervals therefore prescribe an action at every sufficiently small positive physical time. No phase requires computation at an earliest positive epoch.

For any actual positive-size vector x, all targets are below min_i x_i for all sufficiently negative j: every e_i^0(t_j) is at most t_j. The physical trajectory agrees with the prescribed no-event trajectory up to the first physical completion. If that completion occurs in phase j, the previously achieved targets from phase j−1 dominate every e_i^0(t_j), because e_i^0 can increase by at most Δ_(j−1) during that virtual interval. Since no physical completion occurred earlier, the virtual history through t_j is the genuine no-completion history. Complete the prefetch of phase j, using the physical completion as observed, and then use the general simulation rule. This defines a causal schedule on the actual sizes. All later targets are obtained from the exact simulated execution, without resetting the previous physical work.

Each phase consists of at most n serial service pieces. The infinitely many initial phases with sufficiently negative indices have physical endpoints tending to zero. Once any positive physical time is passed, only finitely many phases occur before the virtual policy finishes, because it has finite completion times. Hence no positive time is an accumulation point of switches. The policy stops when all physical jobs have completed. This completes the proof of Theorem 1.

## 3. The ordinal tradeoff under serial service

For b_n<R<n choose δ>0 small enough that R'=R/(1+δ)≥b_n. The archived ordinal theorem supplies a fluid policy with robustness at most R' and consistency c_n(R'). Applying Theorem 1 multiplies the total cost by at most 1+δ for every instance. The resulting serial policy therefore has robustness at most R and consistency at most (1+δ)c_n(R'). Letting δ decrease to zero gives an upper bound c_n(R) on the infimum by continuity of the pinned frontier. Every serial policy is a fluid policy, giving the matching lower bound. At R=n, following the predicted order serially has consistency one and robustness at most n. Thus the infimum equality also holds there.

It remains to characterize what is possible at the lower endpoint and without an initial accumulation. We prove the necessary bound directly. Fix an instance and a time t before any job has completed. Replace each actual size by a strictly greater value e_i(t)+ζ, where ζ>0, keeping the advice fixed. The histories through t are indistinguishable, since neither instance produces a completion there. The algorithm has already paid nt in cumulative unfinished-job cost. The optimum for the modified instance tends to P_n(e(t)) as ζ decreases to zero. Thus every deterministic R-robust policy obeys

~~~text
nt ≤ R P_n(e(t))                                             (3)
~~~

at each before-completion time. This use of robustness permits an arbitrarily incorrect advised order on the modified instance.

For any attained vector e,

~~~text
P_n(e) = [(n+1)/2] ∑_i e_i − (1/2)∑_(i<j)|e_i−e_j|.
~~~

The formula follows by expressing each pairwise minimum with an absolute value. Total attained service is at most t. At R=b_n, equality in the upper bound supplied by this formula is forced by (3). This requires e_i(t)=t/n for every i, for every positive time before the first completion. The time interval is nonempty because the sizes are positive. Hence every coordinate's service rate is 1/n almost everywhere on that interval. This is incompatible with serial service for n≥2, even if arbitrary measurable switching is allowed. The lower robustness b_n follows from the same inequality. Approximating the fluid round-robin policy by Theorem 1 shows it is the serial robustness infimum.

If there are only finitely many switches near zero, there is a positive initial interval on which at most one job receives service. A positive idle interval would already violate (3) for any finite R. Choose a sufficiently small t within the initial interval and before any completion. Since at most one e_i(t) is nonzero, P_n(e(t))=∑_i e_i(t)≤t. Equation (3) then requires R≥n. Conversely, following the advised order serially is work-conserving, so its cost is at most n times the total work, itself at most nP_n(x). When the order is correct it is the optimal shortest-processing-time schedule. This establishes both the lower bound and simultaneous attainability in the nonaccumulating model, proving Theorem 2.

## 4. Scope and implications

The causal prefetch lemma gives a serialization statement for individual completion times, independent of the original consistency and robustness definitions. In its present application all jobs are initially available and every advancement can be done at unit rate. Infinite initial switching is a mathematical feature of the first serial model. The lower bound in Section 3 proves that it is necessary there whenever deterministic robustness below n is sought. The lemma does not assert exact attainment at an interior robustness budget; the proved tradeoff is an infimum. It also does not assert simulation with a strictly positive first quantum. The fluid ranking frontier and its continuity are credited to the pinned paper, and the comparison is limited to that repository record.
