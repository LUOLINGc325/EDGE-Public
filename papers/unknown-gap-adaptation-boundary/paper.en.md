# The unknown-gap adaptation frontier and its heavy-tail boundary

## Abstract

We study how finite baseline regret controls small-gap regret in a known-value two-arm family with independent diagnostic rewards. An informative one-sided boundary event gives an iterated-logarithm obstruction, and a diagnostic renewal policy gives a matching first-order budget exponent. For every positive finite diagnostic KL divergence, the remaining multiplicative frontier is equivalent up to constants to a scalar one-sided sequential testing value. The positive log-likelihood increment has finite second moment exactly when that frontier has a bounded multiplicative ratio to its exponential scale.

## 1. Model and the order of the quantifiers

Lattimore and Munos [1, Appendix A, Theorem 13 and Remark 14] provide the bounded-baseline construction and ask whether its iterated logarithm can be removed. The answer here concerns the anytime, unknown-gap problem. It is distinct from the finite-horizon claim in Bubeck, Perchet and Rigollet [7, Theorem 8], for which a proof error was disclosed and the earlier structured-bandit paper gives a counterexample.

Let $G_0,G_1$ be known probability distributions on the real line with finite
means $-g<0$ and $0$, respectively. Consider the family
$$
 \nu_0=(N(0,1),G_0),\qquad
 \nu_\delta=(N(-\delta,1),G_1),\qquad 0<\delta\le1.       \tag{1}
$$
Successive rewards are independent within each arm, and the two reward
streams are independent. The best mean is zero in every instance. A policy
selects one arm at every round using its observed history and independent
randomization. One policy is used for all horizons and all $\delta$; it may
know the family and the budget introduced below, but it does not know the
true instance or the gap.

With $N_a(\infty)$ the possibly infinite total number of pulls of arm $a$,
expected pseudo-regret satisfies
$$
 R_\infty(\nu_0)=g\,E_0N_2(\infty),\qquad
 R_\infty(\nu_\delta)=\delta\,E_\delta N_1(\infty).
                                                               \tag{2}
$$
These identities follow by monotone convergence of nonnegative gap costs.
They are statements about expected pseudo-regret, not realized reward sums.

For $C\ge0$, define
$$
 \begin{split}
 \Pi_C=\{\pi:\;&R_\infty^\pi(\nu_0)\le C,\quad
 R_\infty^\pi(\nu_\delta)<\infty\ \text{for every }0<\delta\le1\},\\
 {\cal A}(C)=\inf_{\pi\in\Pi_C}
 &\limsup_{\delta\downarrow0}
   \frac{\delta R_\infty^\pi(\nu_\delta)}
        {\log\log(\delta^{-2})}.                         
 \end{split}\tag{3}
$$
The infimum of the empty set is $+\infty$. The logarithmic denominator is used
only near zero, where it is positive. All logarithms are natural.

The policy is selected before the gap varies. For each fixed $C$, the
small-gap limsup in (3) is taken first. Only then do the theorems below study
$C\to\infty$. A joint uniform approximation when $C$ and $\delta^{-1}$ grow
together is not asserted.

Assume for the lower bound that
$$
 G_0\ll G_1,\qquad
 0<D:=\operatorname{KL}(G_0,G_1)<\infty,\qquad
 \kappa=D/g.                                           \tag{4}
$$
The positivity of $D$ also follows from the different means when $D$ is finite.

## 2. Statements

Put
$$
 c_*=\frac{1}{2(2\log4+1)}.
$$

**Theorem 1 (uniform budget lower bound).** Under (4), for every $C\ge0$,
$$
 {\cal A}(C)\ \ge\
 \frac{1}{2\lceil 2(\log4)e^{\kappa C}\rceil}
 \ \ge\ c_*e^{-\kappa C}.                              \tag{5}
$$
The inequality is understood in the extended-real sense if $\Pi_C$ is empty.
The same constant works for every eligible policy, which is necessary before
taking the infimum in (3).

**Theorem 2 (bounded log-likelihood increments).** Suppose additionally that
$$
 Z=\log(dG_0/dG_1)(Y)\le B
 \quad G_0\text{-almost surely},\qquad B<\infty.          \tag{6}
$$
One may take $B>0$. For
$$
 C\ge C_*:=\max\{2,\ 1+(B+\log2)/\kappa\},
$$
there is an explicit anytime policy in $\Pi_C$ and
$$
 c_*e^{-\kappa C}
 \ \le {\cal A}(C)
 \ \le 128e^{B+\kappa}e^{-\kappa C}.                    \tag{7}
$$
Thus $\mathcal A(C)=\Theta(e^{-DC/g})$ as $C\to\infty$, with constants depending
only on the stated distributions for the upper bound. Finite-alphabet pairs
with $G_0\ll G_1$ satisfy (6); full common support is unnecessary.

**Theorem 3 (Gaussian diagnostic arm).** For
$G_0=N(-1,1)$ and $G_1=N(0,1)$, hence $g=1$ and $D=1/2$, for every $C\ge9$,
$$
 c_*e^{-C/2}
 \ \le {\cal A}(C)
 \ \le 128e^{7/2}e^{-C/2}.                             \tag{8}
$$
In particular, $\mathcal A(C)=\Theta(e^{-C/2})$ and
$$
 \lim_{C\to\infty}-\frac{\log{\cal A}(C)}{C}=\frac12.    \tag{9}
$$
The constants in (7) and (8) are conservative. Neither the exact prefactor
of $\mathcal A(C)$ nor a pointwise lower bound at every sufficiently small gap
is claimed.

## 3. The imported testing lower bound

For i.i.d. observations with laws
$$
 P=N(0,1)\otimes U,\qquad Q_\delta=N(-\delta,1)\otimes U,
 \quad U=\operatorname{Unif}(0,1),
$$
Agrawal, Ram and Ramdas [2, Theorem 3.2] implies the following uniform
consequence: every power-one stopping rule $T$ satisfying
$P(T<\infty)\le1/4$ has
$$
 \limsup_{\delta\downarrow0}
 \frac{E_{Q_\delta}T}{F(\delta/\sqrt2)}\ge\frac14,
 \qquad F(x)=x^{-2}\log\log(1/x).                       \tag{10}
$$
Indeed, $\operatorname{KL}(Q_\delta,P)=\delta^2/2$ and the singleton null is
an anchor with comparison constant one. Choose
$\delta_i=\sqrt2e^{-(i+1/2)}$ to meet the theorem's exponential buckets.
Taking its parameter $\gamma=1$ makes the proportion of indices with
expectation less than $F/4$ tend to zero. This proves (10), uniformly over
the stopping rule. The augmented observation space is allowed in [2, §2].

Only this already established statistical lower bound is imported. In
particular, a merely test-dependent positive limsup would not suffice to
prove (5).

## 4. A budget preserves a positive-probability boundary event

Fix $\pi\in\Pi_C$ and introduce the auxiliary boundary instance
$$
 \bar\nu=(N(0,1),G_1).
$$
It is used only in the proof; it need not belong to the policy's promised
family. Let $P_0^T$ and $\bar P^T$ be the laws of the policy's history through
$T$ rounds under $\nu_0$ and $\bar\nu$.

The policy kernels and the first-arm distributions agree. Consequently the
finite-history likelihood ratio contains only second-arm factors, giving
$$
 \operatorname{KL}(P_0^T,\bar P^T)
   =D\,E_0N_2(T)
   \le DC/g=\kappa C.                                 \tag{11}
$$
Independent private randomization can be included in the history with the
same law under both measures. Conditional action probabilities cancel.
Finite $D$ ensures integrability of the log-likelihood increments.

For integers $M\ge1$, let
$$
 E_{M,T}=\{N_2(T)<M\},\quad
 E_M=\{N_2(\infty)<M\},\quad
 E=\{N_2(\infty)<\infty\}.
$$
Data processing in (11) gives
$$
 \operatorname{kl}\bigl(P_0^T(E_{M,T}),\bar P^T(E_{M,T})\bigr)
 \le\kappa C.                                         \tag{12}
$$
First let $T\to\infty$. The events decrease to $E_M$; lower semicontinuity
of binary relative entropy yields
$$
 \operatorname{kl}\bigl(P_0(E_M),\bar P(E_M)\bigr)\le\kappa C.
$$
Next let $M\to\infty$. Since $E_0N_2(\infty)\le C/g$, $P_0(E)=1$.
The events $E_M$ increase to $E$, so, writing $p=\bar P(E)$, another application
of lower semicontinuity gives
$$
 \log(1/p)=\operatorname{kl}(1,p)\le\kappa C.
$$
Thus
$$
                    p\ge e^{-\kappa C}.                \tag{13}
$$
No assertion of equivalence between two infinite second-arm product
measures is made. Both limit passages use finite-history inequalities with
a uniform bound.

## 5. From the boundary event to the uniform coefficient

Choose an integer $M$ large enough that
$$
 p_M:=\bar P(E_M)\ge\tfrac12e^{-\kappa C}.               \tag{14}
$$
Simulate the policy using an input stream from $N(-\delta,1)$ for its first
arm and independent simulated $G_1$ observations for its second arm.
Let $\tau_M$ be the number of input observations used before the policy
selects arm 2 for the $M$-th time; set it to infinity if that choice never
occurs.

This is a stopping time in the input-sample clock. To decide
$\{\tau_M\le n\}$, simulate until either the $M$-th arm-2 choice or the
request for the $(n+1)$-st input observation. At most $n+M$ decisions and
$M-1$ second-arm rewards are needed. The reward of the $M$-th second-arm
choice is not needed.

Under input mean zero, $P(\tau_M=\infty)=p_M$. At each negative mean,
the simulation has law $\nu_\delta$. Finite $R_\infty(\nu_\delta)$ implies
that arm 1 is pulled only finitely many times almost surely; because the
policy acts forever, arm 2 is pulled infinitely many times. Therefore
$$
 P_\delta(\tau_M<\infty)=1,\qquad
 E_\delta\tau_M\le R_\infty(\nu_\delta)/\delta.          \tag{15}
$$

To place all randomization inside an i.i.d. observation model, use the
uniform component of the first augmented observation $(X_1,U_1)$ to supply
the policy seed and the finite simulated second-arm prefix, discard $X_1$,
and begin using the first components of subsequent observations.
This produces a positive-integer stopping time with expectation at most
$1+R_\infty(\nu_\delta)/\delta$. A uniform random variable can supply the
needed independent random quantities by a measurable sampling map.
No seed is fixed by an invalid simultaneous-null-set argument.

Set
$$
 r=\lceil2(\log4)e^{\kappa C}\rceil.
$$
Run $r$ independent copies in series, each with a fresh augmentation sample;
reject only when all copies stop. The resulting stopping time $T$ satisfies
$$
 P(T<\infty)=(1-p_M)^r
       \le e^{-rp_M}\le1/4,\qquad
 E_{Q_\delta}T\le r\bigl(1+R_\infty(\nu_\delta)/\delta\bigr).          \tag{16}
$$
Sequential copies use fresh unused i.i.d. observations and fresh seeds.
Under each alternative every copy finishes, so the displayed expectation
is finite; under the null a nonterminating copy simply prevents rejection.

Apply (10). Since
$$
 \frac{F(\delta/\sqrt2)}
      {\delta^{-2}\log\log(\delta^{-2})}\longrightarrow2,
$$
(16) implies
$$
 \limsup_{\delta\downarrow0}
 \frac{\delta R_\infty(\nu_\delta)}
      {\log\log(\delta^{-2})}\ge\frac1{2r}.              \tag{17}
$$
This is uniform over $\pi\in\Pi_C$: $M$ may depend on the policy, but $r$
does not. Taking the infimum gives the first inequality of (5).
Finally $r\le(2\log4+1)e^{\kappa C}$ proves the second.

## 6. An explicit Gaussian screening test

For $\beta\in(0,1)$ and i.i.d. $X_i\sim N(-\delta,1)$, let $S_n=\sum_{i\le n}X_i$.
At times $n_k=2^k$, $k=0,1,\ldots$, reject mean zero if
$$
 S_{n_k}\le
 -\sqrt{2n_k\log\!\left(\frac{\pi^2(k+1)^2}{6\beta}\right)}.
                                                               \tag{18}
$$
Let $\sigma_\beta$ be the first rejecting time, with infinity allowed.

**Lemma 4.** This test has null rejection probability at most $\beta$.
For every $\delta>0$, $E_\delta\sigma_\beta<\infty$, and for every fixed
$\beta\in(0,1)$,
$$
 \limsup_{\delta\downarrow0}
 \frac{\delta^2E_\delta\sigma_\beta}
      {\log\log(\delta^{-2})}\le64.                    \tag{19}
$$
The constant 64 does not depend on $\beta$; the gap below which the
asymptotic estimates apply may depend on $\beta$.

**Proof.** A Gaussian Chernoff bound at $n_k$ makes its null crossing
probability at most $6\beta/(\pi^2(k+1)^2)$. Summation gives the error bound.

Write $L=\log\log(\delta^{-2})$ and let $n_*=2^{k_*}$ be the smallest power
of two at least $32L/\delta^2$. As $\delta\downarrow0$,
$$
 n_*<64L/\delta^2,\qquad
 \log\!\left(\frac{\pi^2(k_*+1)^2}{6\beta}\right)
      =2L+O_\beta(1).
$$
For sufficiently small $\delta$, the magnitude of the sample-mean boundary
at $n_*$ is at most $\delta/2$. That magnitude decreases at all subsequent
dyadic times: for $k\ge1$ and $a=\pi^2/(6\beta)>1$,
$\log(a(k+2)^2)\le2\log(a(k+1)^2)$.
Hence, for $k\ge k_*$,
$$
 P_\delta(\sigma_\beta>n_k)\le e^{-\delta^2n_k/8}.
$$
The dyadic tail-sum identity gives
$$
 E_\delta\sigma_\beta
 =1+\sum_{k\ge0}n_kP_\delta(\sigma_\beta>n_k)
 \le n_*+\sum_{k\ge k_*}n_ke^{-\delta^2n_k/8}.          \tag{20}
$$
Writing $x_k=\delta^2n_k/8$, the final sum is
$(8/\delta^2)\sum_{k\ge k_*}x_ke^{-x_k}$.
Once $x_{k_*}\ge1$, successive terms have ratio at most $2/e$, while the
first is at most $1/e$. Thus the sum in (20) is at most
$8/((e-2)\delta^2)$, which is negligible compared with $L/\delta^2$.
This proves (19). For an arbitrary fixed positive $\delta$, the
sample-mean boundary eventually falls below $\delta/2$ and the same
summable tail argument proves finite expectation. \(\blacksquare\)

## 7. A cycle policy and its exact accounting

Let $f=dG_0/dG_1$. For a threshold $h>0$, a diagnostic phase repeatedly
pulls arm 2 until
$$
 H_h=\inf\{n\ge1:\ \sum_{s=1}^n\log f(Y_s)\ge h\}.      \tag{21}
$$
If a factor $f(Y_s)$ is zero, its likelihood product stays zero, and the
phase never crosses the positive threshold. If the phase crosses, start
a fresh arm-1 screening phase using (18). A screening rejection restarts
a new diagnostic phase, with both statistics reset. If screening never
rejects, continue pulling arm 1 forever.

Under $G_1$, the likelihood product is a nonnegative mean-one martingale.
The elementary maximal inequality therefore gives
$$
 q_h:=P_{G_1}(H_h<\infty)\le e^{-h}<1.                 \tag{22}
$$
Assume for now that $E_{G_0}H_h<\infty$.

Under the baseline, every diagnostic phase finishes. Each screening phase
restarts the cycle with probability $b_\beta\le\beta$. By independence of
fresh reward streams, or by summing the expected contribution of each
reachable phase,
$$
 R_\infty(\nu_0)
  =\frac{gE_{G_0}H_h}{1-b_\beta}
  \le\frac{gE_{G_0}H_h}{1-\beta}.                      \tag{23}
$$
Under every alternative, screening finishes almost surely and has finite
mean duration. Each diagnostic phase produces a screening phase with
probability $q_h$. The expected number of screening phases is
$q_h/(1-q_h)$, so
$$
 R_\infty(\nu_\delta)
   =\delta\,\frac{q_h}{1-q_h}\,E_\delta\sigma_\beta<\infty.
                                                               \tag{24}
$$
An infinite diagnostic phase under an alternative is harmless: it pulls
the optimal arm 2 forever and contributes zero pseudo-regret. No finite
expected calendar duration is assumed for such a phase.

Combining (19), (22) and (24),
$$
 \limsup_{\delta\downarrow0}
 \frac{\delta R_\infty(\nu_\delta)}{\log\log(\delta^{-2})}
 \le64\,\frac{e^{-h}}{1-e^{-h}}.                        \tag{25}
$$
Equations (23) and (25) separate the baseline cost of diagnostic evidence
from the small-gap adaptation cost.

## 8. Bounded increments: proof of Theorem 2

Under $G_0$, the log-likelihood increments are integrable, have mean $D$,
and are bounded above by $B$. For every deterministic integer $n$,
$$
 E_{G_0} S_{H_h\wedge n}=D\,E_{G_0}(H_h\wedge n),\qquad
 S_{H_h\wedge n}\le h+B.                               \tag{26}
$$
The expectation identity is a finite sum: the event that the next
increment is used is measurable before that independent increment.
It requires no optional-stopping theorem at an unbounded stopping time.
The pathwise upper bound holds because a crossing overshoots by at most
$B$, while before crossing the sum is below $h$.

Monotone convergence in (26) proves both almost-sure termination and
$$
 E_{G_0}H_h\le(h+B)/D.                                 \tag{27}
$$
For $C\ge C_*$, select
$$
 \beta=1/C,\qquad h=\kappa(C-1)-B\ge\log2.
$$
Then (23) and (27) give exactly
$$
 R_\infty(\nu_0)
 \le\frac{g(h+B)}{D(1-1/C)}=C.
$$
Thus the policy belongs to $\Pi_C$. From (25) and $1-e^{-h}\ge1/2$,
$$
 {\cal A}(C)\le128e^{-h}
            =128e^{B+\kappa}e^{-\kappa C}.
$$
Together with Theorem 1, this proves (7).

The finite-alphabet condition is only one sufficient way to obtain (6).
The theorem also applies to other known distributions whose
log-likelihood ratio is bounded above under $G_0$.

## 9. Gaussian overshoots: proof of Theorem 3

In the Gaussian pair, the diagnostic increment is
$$
 Z=-Y-\tfrac12.
$$
Under $G_0=N(-1,1)$, it has law $N(1/2,1)$ and mean $1/2$.
It is not bounded above, so (26)'s pathwise bounded-overshoot argument
cannot be reused.

**Lemma 5 (uniform mean overshoot bound).** If $Z\sim N(1/2,1)$, then for
every $x\ge0$,
$$
 E[(Z-x)_+]\le3P(Z\ge x).                              \tag{28}
$$

**Proof.** For $t\ge0$, direct comparison of Gaussian densities at $s+t$
and $s$, integrated over $s\ge x\ge0$, yields
$$
 \frac{P(Z\ge x+t)}{P(Z\ge x)}
 \le e^{t/2-t^2/2}.
$$
Integrate this inequality over $t$ to bound the expected excess:
$$
 \frac{E[(Z-x)_+]}{P(Z\ge x)}
 \le\int_0^\infty e^{t/2-t^2/2}\,dt
 \le e^{1/8}\sqrt{2\pi}<3.
$$
For example, the last strict inequality follows from
$e^{1/8}\le8/7$, $\pi<22/7$, and $2816/343<9$. \(\blacksquare\)

Let $S_n$ be the diagnostic random walk and $H_h$ its first crossing.
On $\{H_h\ge n\}$ the remaining gap $h-S_{n-1}$ is positive. Conditional
application of (28) gives
$$
 E[(S_n-h)\mathbf1_{\{H_h=n\}}]\le3P(H_h=n).
$$
Summing through $n=N$ bounds the expected overshoot on a crossing by time
$N$ by 3. Since
$$
 S_{H_h\wedge N}
 \le h+\sum_{n=1}^N(S_n-h)\mathbf1_{\{H_h=n\}},
$$
the bounded-time expectation identity yields
$$
 \tfrac12E(H_h\wedge N)=E S_{H_h\wedge N}\le h+3.
$$
Monotone convergence proves
$$
                         E_{G_0}H_h\le2h+6.            \tag{29}
$$
This also proves that $H_h$ is finite almost surely, without assuming that
fact in advance.

For $C\ge9$, take
$$
                  \beta=1/C,\qquad h=C/2-7/2\ge1.      \tag{30}
$$
Using (23) and (29),
$$
 R_\infty(\nu_0)
 \le\frac{2h+6}{1-1/C}
 =\frac{C-1}{1-1/C}=C.
$$
The bound (25), with $h\ge1>\log2$, gives
$$
 {\cal A}(C)\le128e^{-h}
             =128e^{7/2}e^{-C/2}.
$$
Theorem 1 supplies the lower bound. This proves (8) and (9).

## 10. Boundaries, implementation and academic scope

This model has a directional support boundary. Even without a finite KL assumption, when $G_0\ll G_1$, a policy with finite baseline regret gives some $E_M=\{N_2(\infty)<M\}$ positive baseline probability. The event is measurable from the independent seed, complete arm-1 stream, and first $M$ diagnostic rewards. The baseline law is absolutely continuous with respect to the boundary law on that restricted sigma-field, so the event has positive boundary probability. The serial amplification in Section 5 gives a strictly positive small-gap iterated-logarithm coefficient by choosing enough copies for that probability. In particular a uniform $O(1/\delta)$ alternative regret at finite baseline cost is impossible.

If $G_0\not\ll G_1$, choose a measurable event $A$ with $G_1(A)=0<G_0(A)$. Sample arm 2 until the first diagnostic reward in $A$, then sample arm 1 forever. The baseline cost is $g/G_0(A)$ by the geometric waiting time, and every alternative has zero regret because the event never occurs. Thus a common finite baseline cost and uniform $O(1/\delta)$ alternative regret exist exactly in this directionally singular case.

The reference implementation in [reference_policy.py](evidence/code/reference_policy.py)
uses the Gaussian diagnostic score and the dyadic screening boundary (18).
Its original conservative large-budget choice
$h=C/2-4\sqrt C-20$, $\beta=C^{-1/2}$ for $C\ge256$ also satisfies the
budget bound, now directly from (29).
The sharper parameters (30) can be implemented with the same controller.
Floating-point arithmetic is not a certified implementation of the
ideal exact-real statistical process; finite-state semantic checks are
not a proof of (5), (7), or (8).

The pointwise small-gap cost for a single policy and the budget frontier
are distinct objects. Equation (5) still uses a limsup over gaps; it
does not force a lower bound at every small gap or at each finite horizon.
Equations (7) and (8) match the dependence on the baseline budget up to
multiplicative constants. They leave exact prefactors, joint
finite-horizon/budget/gap limits open. Sections 11–12 below extend the budget result to general finite-KL diagnostic pairs.


## 11. The one-sided diagnostic problem

Assume $G_0\ll G_1$ and $0<D=E_0Z<\infty$, where $Z=\log(dG_0/dG_1)$ and $S_n=\sum_{i\le n}Z_i$. A randomized diagnostic stopping time $H$, in units of pulls of arm 2, may take either $0$ or $\infty$. Define
$$
q(t)=\inf\{P_1(H<\infty):E_0H\le t\}.
$$

**Theorem 4.** For every $C\ge0$, with the upper bound interpreted as infinity at $q(C/g)=1$,
$$
c_*q(C/g)\le\mathcal A(C)\le 64\frac{q(C/g)}{1-q(C/g)}.
$$
Moreover, $q$ is the lower closed convex boundary of the threshold points
$(E_0\tau_h,P_1(\tau_h<\infty))$, where $\tau_h=\inf\{n\ge0:S_n\ge h\}$ and $h>0$, together with the immediate-stop point $(0,1)$. The sample budget can be slack.

To see the lower bound, supply the entire independent $N(0,1)$ arm-1 stream and the policy's seed as independent auxiliary inputs. The total number $H=N_2(\infty)$ of arm-2 pulls is a stopping time in the diagnostic clock. Indeed $\{H>n\}$ is the countable union of finite decision events that request the $(n+1)$st sample, using only the first $n$ diagnostics and auxiliary inputs. Thus $E_0H\le C/g$ at the baseline and $\bar P(H<\infty)\ge q(C/g)$ at the boundary. In (14) take $p_M\ge q(C/g)/2$ and set $r=\lceil2\log4/q(C/g)\rceil$ in (16). Equations (16)–(17) give the uniform coefficient $1/(2r)\ge c_*q(C/g)$.

For the upper bound, let $t=C/g$ and use a diagnostic rule with $E_0H\le t$, $q_H=P_1(H<\infty)<1$. Modify each independent diagnostic phase of Section 7 by immediately ending it with probability $\beta$ and using $H$ otherwise. Its baseline cost is at most $g(1-\beta)t$, and the Gaussian screen restarts with probability at most $\beta$, so the total baseline regret remains at most $C$ by (23). Under the alternative a diagnostic phase begins a screen with probability $q'\le\beta+(1-\beta)q_H$. Equation (24) bounds the expected number of screens by $q'/(1-q')$, and (19) provides the limiting constant 64 for every fixed $\beta$. Taking the infimum over such fixed policies, letting $\beta\downarrow0$, and choosing $q_H\downarrow q(t)$ gives the stated upper bound. A random mix of immediate termination and any positive threshold gives $q(t)<1$ when $t>0$.

For the shape of $q$, require diagnostic rules still in progress at the first $G_0$-null observation to never stop thereafter. This weakly decreases $P_1(H<\infty)$ at the same baseline cost. Change measure at each finite stopping time value and sum to obtain
$P_1(H<\infty)=E_0e^{-S_H}$.
Here $E_0H<\infty$ entails almost-sure finiteness under $G_0$. The negative part of $Z$ is integrable by $E_0e^{-Z}\le1$, and its positive part is integrable by the finite KL assumption. Wald's identity and Jensen's inequality therefore give $q(t)\ge e^{-Dt}$.

For a price $c>0$ per diagnostic sample, consider state $y\ge0$ and the factor $Y=e^{-Z}$. Start a recursion with $V_0(y)=0$ and
$$
V_{n+1}(y)=\min\{y,c+E_0 V_n(yY)\}.
$$
This assigns zero terminal loss to a rule that has not stopped by step $n$, and thus lower-bounds the actual infinite-horizon cost. The increasing limit $V$ is concave, nondecreasing, bounded between zero and $y$, and obeys the Bellman equation by monotone convergence. Its stopping set is a closed interval containing $[0,c]$, because $V-y$ is nonpositive and concave. To see that this interval is bounded, truncate $Z$ above at $M$ so that its mean $D_M>0$. The truncated walk's first crossing of $h>0$ has mean at most $(h+M)/D_M$ from the bounded-step version of (26). The original crossing is no later, and its $P_1$ error is at most $e^{-h}$ by a likelihood maximal inequality. Thus at large $y$ this admissible rule beats immediate termination, since its risk with weight $y$ is at most $cE_0\tau_h+ye^{-h}$. Write the stopping interval as $[0,b_c]$.

Stop the Bellman recursion at the first hit of this interval or at $n$. The remaining value is nonnegative, so $cE_0\tau\le V(y)$. Fatou then gives $cE_0\tau+E_0[ye^{-S_\tau}]\le V(y)$. The finite-step lower bound gives the reverse inequality. At $y=1$ the rule is either immediate stopping or a positive log-likelihood threshold. Randomization at time zero makes $q$ convex and nonincreasing. The exponential lower bound gives continuity at zero, and the error of increasing thresholds tends to zero. Each supporting line with positive sample price is attained by a threshold or immediate stopping; price zero has infimum zero. Thus the closed, budget-slack convex boundary equals $q$.

## 12. The exact second-moment boundary

**Theorem 5.** For every pair in Theorem 4,
$$
\mathcal A(C)=\Theta(e^{-DC/g})\quad(C\to\infty)
\quad\Longleftrightarrow\quad E_0[(Z^+)^2]<\infty.
$$
If the positive second moment is infinite, then $e^{DC/g}\mathcal A(C)\to\infty$. In either case, $\log\mathcal A(C)/C\to-D/g$.

Write $O_h=S_{\tau_h}-h$, $t_h=E_0\tau_h$, and $q_h=P_1(\tau_h<\infty)$. Change measure and apply Wald to get $q_h=e^{-h}E_0e^{-O_h}$ and $Dt_h=h+E_0 O_h$. The first strict ascending ladder epoch $\tau_+=\inf\{n\ge1:S_n>0\}$ has finite mean by comparison with the bounded-above, positive-drift walk crossing one. Its height $L=S_{\tau_+}$ has finite positive mean by Wald. It equals $Z_1$ on $\{Z_1>0\}$, and
$L^2\le\sum_{i\le\tau_+}(Z_i^+)^2$.
The expectation of the sum is $E_0\tau_+\,E_0[(Z^+)^2]$ by nonnegative summation. Thus $L$ and $Z^+$ have finite second moments simultaneously. Strict successive ladder heights have iid positive increments of law $L$, and $O_h$ is the overshoot of that renewal process.

For finite second moment, Lorden's bound gives $E_0O_h\le B=E_0L^2/E_0L$ uniformly in $h>0$. Weak crossing has no greater overshoot than strict crossing. For $h=Dt-B>0$, we have $t_h\le t$ and $q(t)\le e^Be^{-Dt}$. Theorem 4 and the Jensen lower bound give the claim.

For infinite second moment, in the nonarithmetic case the excess life converges to the proper renewal residual law with tail $(E_0 L)^{-1}\int_x^\infty P(L>u)\,du$. Its mean is infinite. In the arithmetic case of span $d$, at exact thresholds $h=nd$ with weak crossing the limit has probability $dP(L>kd)/E_0 L$ at $kd$, $k\ge0$. This formula follows by summing over the final renewal before the threshold and applying the lattice renewal mass limit; at $k=0$ it follows directly from that mass limit. Between lattice points, switch to the next weak lattice threshold and translate the remaining amount by at most $d$. A nonarithmetic weak hit has the same limit as a strict hit because the exact-hit probability tends to zero. In both cases, finite truncations give $E_0O_h\to\infty$, while eventual tightness gives $\liminf_h E_0e^{-O_h}>0$. Consequently $q_he^{Dt_h}\to\infty$.

Convexification preserves this divergence. Fix $K>0$ and choose $T_0$ such that $t_h\ge T_0$ implies $q_h\ge Ke^{-Dt_h}$. The bounded-mean crossing estimate ensures that high $t_h$ requires high $h$. The other threshold points lie at least $e^{-DT_0}$ high. Choose $L_0\ge T_0$ so large that $Ke^{-DL_0}(1+DL_0)\le e^{-DT_0}$. The function that follows $Ke^{-Dt}$ for $t\ge L_0$ and its tangent at $L_0$ for $t<L_0$ is convex, nonincreasing, and below all threshold points and $(0,1)$. Thus it is below $q$, yielding $e^{Dt}q(t)\to\infty$. Theorem 4 transfers this to the bandit frontier.

For completeness, the first-order budget exponent follows over the entire finite-KL class: choose $M$ with $D_M=E_0\min(Z,M)>0$, then the truncated likelihood's expected crossing time is at most $(h+M)/D_M$ under $G_0$, whereas the $G_1$ crossing probability is at most $e^{-h}$. Use $h=D_Mt-M>0$ and Theorem 4, take $C\to\infty$ with $M$ fixed, and then send $D_M\uparrow D$. The matching lower bound is (5).

Both moment cases occur among actual diagnostic laws with the required means. Give $G_0$ weights $p_k$ proportional to $k^{-s}$ on rewards $-k$ for $k\ge1$, with $s>2$. Give $G_1$ weights $e^{-k}p_k$ there, and put its remaining mass at $x=(\sum_k ke^{-k}p_k)/(1-\sum_k e^{-k}p_k)>0$. Then $G_1$ has mean zero, $g=D=E_0k$, and $Z=k$ under $G_0$. The case $s=5/2$ has an infinite second moment, and $s=4$ has a finite one. They agree in the exponent $e^{-C}$ yet have different limiting multiplicative behavior.

## 13. Attribution and limits

The one-sided likelihood structure is classical. Lorden [3] studies related one-sided sequential tests. Fischer and Ramdas [5, §1, discussion following equation (6)] distinguish optimality at a test's attained error from using a conservative prescribed likelihood threshold. The stopping value above uses the actual error and also allows mixtures of admissible thresholds. Lorden's renewal overshoot bound [4] and the renewal residual limit [6] are used as mathematical inputs. The new results concern the two-sided comparison between the bandit adaptation frontier and a scalar one-sided testing problem, and the exact positive-second-moment distinction after convexification. The bounds take the small-gap limit for a fixed policy and budget. Exact bandit prefactors and simultaneous limits in the horizon, budget, and gap remain open here.

Full Lean formalization will be delivered separately.

## References

[1] Tor Lattimore and Rémi Munos. *Bounded Regret for Finite-Armed Structured
Bandits.* NeurIPS 2014. Complete manuscript, Appendix A, Theorem 13 and
Remark 14. https://arxiv.org/pdf/1411.2919

[2] Shubhada Agrawal, Ashwin Ram and Aaditya Ramdas.
*On Stopping Times of Power-one Sequential Tests: Tight Lower and Upper Bounds.*
arXiv:2504.19952v2, revised 17 August 2026. In particular §2 and
Theorem 3.2. https://arxiv.org/html/2504.19952v2

[3] Gary Lorden. *Nearly-optimal sequential tests for finitely many parameter values*. Annals of Statistics 5, 1–21 (1977). https://authors.library.caltech.edu/records/1cgah-f1743

[4] Gary Lorden. *On excess over the boundary*. Annals of Mathematical Statistics 41, 520–527 (1970). https://authors.library.caltech.edu/records/8eyxa-q6789

[5] Lasse Fischer and Aaditya Ramdas. *Improving Wald’s (approximate) sequential probability ratio test by avoiding overshoot*. arXiv:2410.16076. https://arxiv.org/html/2410.16076

[6] Steven P. Lalley. *Renewal Theory*. University of Chicago course notes. https://galton.uchicago.edu/~lalley/Courses/383/Renewal.pdf

[7] Sébastien Bubeck, Vianney Perchet, and Philippe Rigollet. *Bounded regret in stochastic multi-armed bandits*. COLT 2013, PMLR 30:122–134. https://proceedings.mlr.press/v30/Bubeck13.pdf
