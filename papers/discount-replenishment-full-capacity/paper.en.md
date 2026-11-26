# Sharp demand-shape and information boundaries in random-capacity inventory control

## Abstract

We determine when a random-capacity discount order must fill its offered capacity and what information suffices to optimize the corresponding infinite inventory model. Beyond unit demand, every positive-integer demand law with nonincreasing probability masses yields strict descent of the endogenous post-decision value before its first minimizer, and a nondecreasing discrete-convex right tail. A last-rise maximum principle proves the same statement for the average-cost bias, without demand or capacity moments. For demand supported on $\{1,2\}$ the universal discounted capacity rule holds exactly when $\mathbb P(D=1)\ge1/2$; every smaller probability has an analytic strict counterexample on an explicit positive interval of offer rates. With an explicit common procurement charge $p>0$ per unit, we prove exact finite reduction when $\mathbb ED<\infty$ and $\alpha p \lt b$, despite unbounded reset costs. The proof separates two different post-decision minima and uses a bounded residual above a backlog potential. Demand tail mass and tail first moment determine absolute values; given a finite mean bound, clipped demand alone determines every optimal action, with an exact common value offset. We prove the class-wide moment and discount boundaries and all-initial-state Blackwell and average verification. A supplementary Kolmogorov perturbation theorem gives simultaneous normalized discounted and average performance certificates, and finite-sample control guarantees with no state-count or mixing-time term in the fixed-charge model. Classical finite MDP, empirical-CDF, and inventory results are explicitly distinguished. All general claims have written proofs; proof-assistant verification remains a separate obligation.

## 1. Question, contribution, and scope

The central new question is a structural and informational boundary, rather than only the original unit-demand conjecture. Section 9 identifies a full demand family for which the endogenous value has the shape needed by the capacity rule, then proves a sharp two-size classification. Section 10 removes the bounded-reset mechanism by charging for each unit purchased, and distinguishes exact control information from exact value information. Section 11 derives quantitative distribution-error consequences. Sections 2-8 include the complete fixed-charge foundations so that every dependency of the expanded results is available in one manuscript.

The primary structural comparison is Caliskan-Demirag, Chen and Yang [CCY], whose two-tier fixed-cost inventory model has the same quantity-threshold tariff mechanism in a different periodic-review setting. Their general characterization leaves intermediate order quantities unresolved, and their simpler heuristic uses an additional shape assumption. Our event-epoch result proves the relevant endogenous shape for a specified distribution class and gives its exact failure boundary within the two-size family. This is not a claim to solve their different periodic-review model. Badia, Sanguesa and Federgruen [BSF] already use nonincreasing probabilities in compound-distribution and inventory structure; the new assertion here is the last-rise proof for this controlled Bellman fixed point with moving random-capacity windows, not the first use of that distribution condition.

For procurement costs, the old bounded-value argument does not apply: each large demand now has a potentially unbounded bill. The new finite core and affine exterior verification explicitly overcome this obstacle. Exact finite MDP embeddings [LS], finite-state Blackwell algorithms [GP], and the no-order discount regime in classical setup-cost inventory [FL] are prior work. Our claims are the stated data-dependent core, its exact tail summaries and policy/value separation, and their verified application to the random-capacity model. We do not claim a new general Blackwell algorithm.

The learning consequence is also model-specific. Fan et al. [FCOQZ] already improve generic reinforcement-learning sample bounds by inventory structure. Their reported average-cost bound retains a squared inventory-range term while removing the mixing-time term; our bounded-span monotonicity gives a Kolmogorov bound without either factor in the present fixed-charge model. The models differ, so this is not a statement of uniform dominance over their results. The empirical-CDF concentration inequality [M] and unrestricted-tail mean-estimation obstruction are classical ingredients.



De Moor et al. [DMBG] specify a discounted event-epoch inventory model with random capacities on temporary setup-cost discounts. Their Conjecture 1 leaves the chosen quantity unresolved when a discount is accepted but cannot reach the order-up-to level. The source explicitly permits free disposal. Its value monotonicity, threshold framework, and adjacent-target tie analysis are prior results. Our new main step fills the entire missing descent interval and settles the conjectured quantity in the original model. The paper appeared online in April 2026 and is assigned to a January 2027 issue.

The second contribution is computational: a proved finite action interval replaces the infinite optimization exactly. Capacity tails are combined by identical feasible action costs, with no discarded probability. The source's numerical procedure instead cuts the capacity law at a 99-percent cumulative quantile. Our interval remains bounded as the positive discount rate decreases to zero, although the contraction error multiplier does not.

The long-run contribution closes a different logical gap: it proves that one policy is optimal at every sufficiently small positive discount rate, derives a bounded bias and the average-cost equation on all integer states, and verifies the long-run optimum against arbitrary admissible policies. Unit-demand bias retains strict pre-target descent; arbitrary batch laws retain exact finite solvability without moment conditions. The accompanying average-cost residual bracket is independent of the discount rate. Finite-state Blackwell theory itself is classical [B]; the infinite-model and global-state passages are part of the proof.

Zheng [Z] treats uncapacitated discount opportunities and quasiconvex inventory costs. Thus neither the can-order framework nor the use of single-valley costs is claimed as generally new. Fixed-capacity models in [GSW, RCT] have different restrictions. Our extension concerns the random-capacity model and the exact demand-size boundary established below. The self-contained proofs do not assume structural lemmas from those references.

Long-run inventory optimization with discount opportunities also predates this work: Feng and Sun [FS] give a finitely convergent average-cost algorithm for an uncapacitated model with setup and variable price differences. Van Ryzin and Vulcano [VV] use Blackwell optimality in a different inventory-auction model. The source [DMBG] itself evaluates average operating costs in its pricing analysis. Our long-run claim concerns the random-capacity model's exact common core, moment-free mark laws, bounded global bias, full-state Blackwell interval, and capacity structure. It is not a claim to originate average-cost inventory control or finite-state Blackwell theory.

The literature comparison is limited to the primary works cited here. The complete institutional manuscript of [DMBG], including Appendix A, was read. For [Z], only the publisher's abstract and bibliographic record were available. We do not claim a worldwide priority certificate or external peer review.

The main theorem concerns zero lead time and decisions at the original Poisson event epochs. It does not assume that a finite numerical truncation is the model. General positive lead times, unrestricted control between events, and an arbitrary initial overstock in a model forbidding disposal are outside the claims. Section 8 treats average cost separately, under the original event-epoch action convention.

## 2. Model and an attained Bellman equation

### Definition 2.1. Event-epoch model

Let

$$
\lambda>0,\quad \mu\ge0,\quad \alpha>0,\quad h,b>0,
\qquad 0\le k\le K<\infty.
\tag{2.1}
$$

Demand events form a Poisson process of rate $\lambda$ and remove one unit. Independent discount events have rate $\mu$ and carry an independent positive integer capacity $R$. The original model has finite support for $R$; the proofs below also allow unbounded support. At a decision epoch the state is $(x,r)$, with integer inventory $x$ and capacity $r\in\mathbb Z_{\ge0}$. A demand epoch has $r=0$. An action selects any integer target $y$. Its immediate setup charge is

$$
a_r(x,y)=
\begin{cases}
0,&y\le x,\\
k,&x \lt y\le x+r,\\
K,&y>x+r.
\end{cases}
\tag{2.2}
$$

The middle interval is empty at $r=0$. In particular, $y \lt x$ is legal free disposal. The running cost is

$$
c(y)=h\max\{y,0\}+b\max\{-y,0\}.
\tag{2.3}
$$

Write

$$
Q=\lambda+\mu+\alpha,\qquad
\beta=\frac{\lambda+\mu}{Q}<1.
\tag{2.4}
$$

The expected discounted running cost before the next event is $c(y)/Q$. Conditional on that next event, the next state is $(y-1,0)$ or $(y,R)$. Setup charges at future epochs are discounted by their actual event times. A policy may depend on the observed history and may randomize, but may not anticipate future events or marks.

Let $V(x,r)$ be the infimum of expected total discounted cost over all such policies. Define the post-decision value

$$
G(y)=\frac{c(y)+\lambda V(y-1,0)+\mu\mathbb E V(y,R)}{Q}.
\tag{2.5}
$$

### Lemma 2.2. Existence and verification

There is a unique bounded solution of

$$
V(x,r)=\min_{y\in\mathbb Z}\{a_r(x,y)+G(y)\},
\tag{2.6}
$$

with $G$ given by (2.5). It is the value over all admissible policies. A deterministic stationary minimizing selector is optimal. Moreover,

$$
0\le V(x,r)\le C:=K+\frac{\lambda K}{\alpha},
\qquad G(0)\le\frac{\lambda K}{\alpha}.
\tag{2.7}
$$

**Proof.** Substitute an arbitrary bounded function $v$ for $V$ in the right side of (2.5)-(2.6), and call the resulting operator $\mathcal B$. The expression minimized over $y$ tends to infinity with $|y|$, since $c$ is coercive and the continuation term is bounded. Hence the minimum is attained. The choice $y=0$ gives a uniform upper bound; nonnegative action and running costs give a uniform lower bound. Thus $\mathcal B$ maps the Banach space of bounded state functions into itself. The minimum is nonexpansive, so

$$
\|\mathcal Bv-\mathcal Bw\|_\infty
\le\beta\|v-w\|_\infty.
\tag{2.8}
$$

Contraction gives a unique bounded fixed point. Iteration from zero is nonnegative and equals finite-event-horizon optimization. A feasible policy first sets inventory to zero, at charge at most $K$, and then buys one unit after each demand. It incurs no running cost and ignores offers. Future demand charges have expected discounted total $\lambda K/\alpha$. Starting at the post-decision level zero omits the initial charge. This proves (2.7).

For any admissible action, the fixed-point Bellman inequality can be iterated over finitely many events. Its remaining terminal value is bounded times $\beta^n$, and tends to zero. It follows that the fixed point is no greater than any policy's total cost, also when that cost is infinite. A minimizing stationary selector makes every inequality an equality and has the same vanishing terminal term. It attains the value. This proves verification against the full policy class. $\square$

The same argument applies to every positive integer law of $R$: the continuation values are bounded, so their expectation exists without a capacity moment assumption.

### Lemma 2.3. Minimum and elementary monotonicity

The function $G$ is coercive and attains its minimum. Set

$$
g=\min_{y\in\mathbb Z}G(y),\qquad
S=\min\{y\in\mathbb Z:G(y)=g\}.
\tag{2.9}
$$

Then $S\ge0$, and $V(x+1,r)\le V(x,r)$ for every state. For constant $k$, also $V(x,r+1)\le V(x,r)$.

**Proof.** Nonnegativity implies $G(y)\ge c(y)/Q$, proving coercivity. For fixed $y$, the charge $a_r(x,y)$ is nonincreasing in $x$, and, for constant $k\le K$, in $r$. Equation (2.6) gives the two monotonicities. For $x<0$, subtraction in (2.5) yields

$$
\begin{split}
Q[G(x+1)-G(x)]={}&-b
+\lambda[V(x,0)-V(x-1,0)]\\
&+\mu\mathbb E[V(x+1,R)-V(x,R)]\le-b<0.
\end{split}
\tag{2.10}
$$

No negative integer can therefore minimize $G$. $\square$

The monotonicities and negative-inventory descent are also in [DMBG]. Their proofs are included to expose every dependency of the new step.

## 3. Descent to the target and the full-capacity theorem

### Lemma 3.1. A global minimum bounds the running cost

For all states $V(x,r)\ge g$, and for $x\ge S$ one has $V(x,r)=g$. In particular,

$$
\alpha g=hS+\lambda[V(S-1,0)-g]\ge hS.
\tag{3.1}
$$

**Proof.** Every action costs at least $g$. When $x\ge S$, the free target $S$ attains $g$. Substitute this equality at the post-decision level $S$ in (2.5). $\square$

### Theorem 3.2. Strict descent before the first minimizer

For every integer $x \lt S$,

$$G(x+1) \lt G(x).\tag{3.2}$$

For $0\le x \lt S$, the quantitative bound is

$$
Q[G(x+1)-G(x)]
\le h(x+1)-\alpha G(x)
\le-\alpha[G(x)-g]<0.
\tag{3.3}
$$

**Proof.** Equation (2.10) covers $x<0$. For $0\le x \lt S$, doing nothing at state $(x,0)$ and discarding one unit at state $(x+1,r)$ give, respectively,

$$V(x,0)\le G(x),\qquad V(x+1,r)\le G(x).\tag{3.4}$$

These actions occur at a decision epoch and use no future information. Substitution in (2.5) at $x+1$ gives

$$QG(x+1)\le h(x+1)+(\lambda+\mu)G(x).\tag{3.5}$$

Now $h(x+1)\le hS\le\alpha g$ by (3.1), whereas $G(x)>g$ because $S$ is the first minimizer. Since $\alpha>0$, rearrangement gives (3.3). $\square$

In particular, (3.3) also gives $G(x+1)-g\le\beta[G(x)-g]$ on this nonnegative pre-target interval. This is a consequence of the decision comparison, not an assumed convexity or unimodality property.

### Corollary 3.3. Right tail, ties, and target bounds

For $x\ge S+1$,

$$G(x)-g=\frac{hx-\alpha g}{Q}.\tag{3.6}$$

Consequently,

$$hS\le\alpha g\le h(S+1),\qquad
0\le S\le\left\lfloor\frac{\lambda K}{h}\right\rfloor.
\tag{3.7}$$

The minimizer set is $\{S\}$ unless $\alpha g=h(S+1)$, when it is $\{S,S+1\}$. If $K>0$, then $hS<\alpha g$ and

$$S=\left\lceil\frac{\alpha g}{h}\right\rceil-1.\tag{3.8}$$

If $K=0$, then $k=0$, $V=0$, $G=c/Q$, and $S=0$ is the unique minimizer.

**Proof.** At $x\ge S+1$, both successor values in (2.5) equal $g$, giving (3.6). Its value at $S+1$ cannot be below $g$. This proves the upper bound in (3.7) and the tie characterization. Also $\alpha g\le\alpha G(0)\le\lambda K$ by (2.7), giving localization. If $K>0$, every free target from $S-1$ has value above $g$, while every target at or above $S$ incurs $K$. Attainment in (2.6) implies $V(S-1,0)>g$. Equation (3.1) is therefore strict, proving (3.8). The zero-cost case follows directly from (2.7). $\square$

The right-tail and adjacent-minimizer facts refine the source's existing analysis and are not claimed as independent priority results. The localization will be used for finite reduction.

### Theorem 3.4. Complete canonical action comparison

If $x\ge S$, choosing $y=S$ attains $V(x,r)=g$. If $x \lt S$ and $r=0$, then

$$V(x,0)=\min\{G(x),K+g\}.\tag{3.9}$$

If $x \lt S$ and $r>0$ with $x+r \lt S$, then

$$V(x,r)=\min\{G(x),\ k+G(x+r),\ K+g\}.\tag{3.10}$$

The three displayed candidates are achieved by targets $x$, $x+r$, and $S$. If $x \lt S$ and $x+r\ge S$, then

$$V(x,r)=\min\{G(x),k+g\}.\tag{3.11}$$

These candidates are achieved by $x$ and $S$. Selecting the first minimum in these ordered lists specifies one deterministic stationary optimal policy; ties are not declared unique.

**Proof.** Theorem 3.2 minimizes the no-purchase branch at $y=x$. An insufficient discounted window ends below $S$, so its unique best target is $x+r$. In that case the regular branch contains $S$. When the discounted window contains $S$, its minimum is $g$; every regular target costs at least $K+g\ge k+g$ and is dominated. For $r=0$ the discounted branch is empty. These facts prove the formulas by (2.6). If two adjacent global minimizers exist, selecting the smaller one remains valid, although other actions can tie. $\square$

### Corollary 3.5. Resolution of the full-capacity conjecture

Whenever $r>0$, $x+r \lt S$, and a discounted positive order is optimal, its quantity is exactly $r$. Among discounted positive orders the cost-minimizing quantity is unique; it may still tie with no order or a regular order in the full decision problem.

**Proof.** On the entire discounted window the setup charge is the same, and $G$ is strictly decreasing. Any quantity $1\le q \lt r$ has strictly larger cost than $q=r$. $\square$

This proves [DMBG, Conjecture 1], including its accepted-discount region, without adding a shape assumption. Theorem 3.4 also eliminates the previously unresolved search over smaller quantities.

### Corollary 3.6. Explicit threshold descriptions

For $K>0$, let $s=\max\{x \lt S:G(x)-g\ge K\}$. For $k>0$, let $c=\max\{x \lt S:G(x)-g\ge k\}$. These sets are nonempty initial integer intervals and $s\le c \lt S$. For $k=0$, use $c=S-1$ to describe positive orders below $S$. For $s \lt x\le c$ and $k>0$, the least accepted capacity is

$$e_x=\min\{1\le r\le S-x:G(x)-G(x+r)\ge k\}.\tag{3.12}$$

It exists, and an optimal discounted order is available precisely for $r\ge e_x$. At equality either ordering or waiting can be chosen. No monotonicity of $e_x$ in $x$ is asserted.

**Proof.** Strict descent, divergence as $x\to-\infty$, and $G(S)=g$ give the interval assertions. Equation (3.12) has a feasible last index because $G(x)-g\ge k$. Equations (3.10)-(3.11) and the strict increase of $G(x)-G(x+r)$ up to $S$ give the capacity condition. The strict inequality $x>s$ removes the regular-order candidate. $\square$

### Corollary 3.7. A restricted no-disposal consequence

For any initial state with $x\le S$, a canonical policy from Theorem 3.4 never uses a negative order. Thus the free-disposal and forbidden-disposal values agree for those initial states in this event-epoch model.

**Proof.** Its targets lie between $x$ and $S$. The next inventory is either the target or one less, so the condition $x\le S$ is invariant. The policy is feasible without disposal and attains the value of the larger free-disposal policy class. $\square$

This statement does not identify the forbidden-disposal value for an arbitrary initial $x>S$.

## 4. Exact finite representation of the infinite model

### Lemma 4.1. A coarse reduction without a shape assumption

With $C$ from (2.7), let $I_0=\{y\in\mathbb Z:c(y)\le QC\}$. Every optimal action target belongs to this finite set.

**Proof.** If $y\notin I_0$, then $a_r(x,y)+G(y)\ge G(y)\ge c(y)/Q>C\ge V(x,r)$. Such an action is strictly suboptimal. $\square$

This lemma and Lemma 2.2 provide a non-circular route to every minimum and finite construction used here.

### Theorem 4.2. Explicit finite action interval

Define

$$
L=-\left\lfloor\frac{(Q+\lambda)K}{b}\right\rfloor,
\qquad U=\left\lfloor\frac{\lambda K}{h}\right\rfloor,
\qquad J=\{L,L+1,\ldots,U\}.
\tag{4.1}
$$

Every optimal target belongs to $J$. For all integer $x$ and all capacities $r$,

$$V(x,r)=\min_{j\in J}\{a_r(x,j)+G(j)\}.\tag{4.2}$$

There is no state-truncation error or artificial boundary condition. The number of target levels is

$$|J|=1+\left\lfloor\frac{(2\lambda+\mu+\alpha)K}{b}\right\rfloor
+\left\lfloor\frac{\lambda K}{h}\right\rfloor.\tag{4.3}$$

**Proof.** Every state value is at least $g$, so

$$Q[G(y)-g]\ge c(y)-\alpha g\ge c(y)-\lambda K.\tag{4.4}$$

If $y \lt L$, the last expression is strictly greater than $QK$. Thus $G(y)>K+g$, while the target $S$ is always available at setup charge at most $K$. If $y>U$, then $hy>\lambda K\ge\alpha g$, so (4.4) implies $G(y)>g$. Since $S\le U \lt y$ and the setup charge is nondecreasing in its target, $a_r(x,S)\le a_r(x,y)$. Target $S$ again strictly dominates $y$. Both tails are excluded, including ties. Formula (4.3) counts the integers in $J$. $\square$

For $0<\alpha\le\bar\alpha$, replacing $\alpha$ by $\bar\alpha$ in $L$ gives one common finite interval. This is not a claim uniform over arbitrarily large $\alpha$, nor a constant bound on numerical iteration time as $\alpha\downarrow0$.

### Theorem 4.3. Finite Bellman contraction and reconstruction

For $z\in\mathbb R^J$ and every integer $x$, put

$$A_r^z(x)=\min_{j\in J}\{a_r(x,j)+z_j\},\tag{4.5}$$

and define

$$
(Fz)_i=\frac{c(i)+\lambda A_0^z(i-1)+\mu\mathbb E A_R^z(i)}{Q},
\qquad i\in J.
\tag{4.6}
$$

The operator $F$ is a $\beta$-contraction. Its unique fixed point $z^*$ is $G|_J$, and $V(x,r)=A_r^{z^*}(x)$ for every original state.

**Proof.** A finite minimum is 1-Lipschitz in its vector, hence $F$ has contraction factor $\beta$. Theorem 4.2 shows that $G|_J$ satisfies (4.6); uniqueness and (4.2) prove reconstruction. At the lower endpoint the demand successor is the actual state $L-1$, evaluated by (4.5). It is not clipped or reflected to $L$. $\square$

### Theorem 4.4. Exact capacity-tail aggregation

Let $M=U-L$. If $M\ge1$, the finite equations (4.6) depend on the capacity law only through

$$\mathbb P(R=r),\quad 1\le r \lt M,
\qquad \mathbb P(R\ge M).\tag{4.7}$$

Equivalently, replace $R$ by $R\wedge M$ in those equations. If $M=0$, the one-point action set makes offers irrelevant to (4.6). No support or moment bound on $R$ is needed.

**Proof.** For $i,j\in J$, every positive order $j-i$ is at most $M$. Thus every capacity $r\ge M$ gives the same charge to every feasible target. Consequently $A_r^z(i)$ is identical throughout that tail, for every vector $z$. Aggregating its entire probability is exact. $\square$

The finite probabilities determine $G|_J$ and hence all pre-decision values $V(x,r)$ with the currently observed $r$ fixed. They need not determine the unconstrained post-decision value $G(x)$ at a far external $x$: evaluating its future opportunity expectation can require additional tail probabilities. This distinction prevents an incorrect global use of the same cutoff.

### Theorem 4.5. Global residual, action, and policy certificates

For any $z\in\mathbb R^J$, let

$$\delta=\|Fz-z\|_\infty,
\qquad E=\frac{\delta}{1-\beta}=\frac{Q\delta}{\alpha}.\tag{4.8}$$

Then $\|z-z^*\|_\infty\le E$ and

$$|A_r^z(x)-V(x,r)|\le E\quad\text{for all }x,r.\tag{4.9}$$

If a target has approximate cost at least $2E$ larger than another, with strict inequality, it is not optimal. A strict advantage larger than $2E$ over every other target certifies a unique optimal action in the original infinite action space. Ties require exact equality checks or sharper enclosures.

Let $\pi_z$ select a minimizing target in (4.5) at every state. Its true total cost obeys

$$0\le V^{\pi_z}(x,r)-V(x,r)\le2E\quad\text{for all }x,r.\tag{4.10}$$

**Proof.** The contraction residual inequality gives the first assertion; the minimum's Lipschitz bound gives (4.9). Each action value has error at most $E$, proving the $2E$ comparison. Theorem 4.2 strictly excludes outside targets.

For the policy assertion, replace the minimizing action in each term of (4.6) by the action selected by $\pi_z$, defining the affine policy operator $F_{\pi_z}$. It is also a $\beta$-contraction and satisfies $F_{\pi_z}z=Fz$. Hence its fixed point $z^{\pi_z}$ is within $E$ of $z$, just as $z^*$ is. The policy always targets $J$ and has bounded one-step costs, so discounted verification identifies $z^{\pi_z}$ as its actual continuation values. For each initial $(x,r)$,

$$
V^{\pi_z}(x,r)\le A_r^z(x)+E,
\qquad V(x,r)\ge A_r^z(x)-E.
$$

Subtract and use optimality of $V$. $\square$

For rational rates, costs, and the finite probabilities in (4.7), a deterministic policy on the finitely many retained event classes is evaluated by a rational linear system with nonnegative transition rates and row sum $\lambda+\mu \lt Q$. The system is nonsingular. Exact solution followed by all finite action inequalities is therefore a finite rational certificate. Exhaustive enumeration of deterministic policies is a finite exact algorithm; no polynomial bit-complexity claim is made. Policy iteration is a practical implementation, with exact residual verification as its stopping condition.

## 5. Batch demand: finite solvability survives, the quantity rule does not

### Theorem 5.1. Arbitrary-batch finite reduction

Replace the one-unit demand by an independent positive integer batch $D$ at each demand epoch. Permit arbitrary positive integer laws for $D$ and $R$, with no moment assumption. Keep the fixed setup-charge convention, instantaneous replenishment, linear inventory costs, and free disposal. The conclusions of Lemma 2.2 and Theorems 4.2-4.5 remain valid after replacing $A_0^z(i-1)$ by $\mathbb E A_0^z(i-D)$.

For the finite equations, $D$ can be replaced exactly by $D\wedge(M+1)$, where $M=U-L$; the capacity reduction remains unchanged.

**Proof.** The Bellman contraction still acts on bounded pre-decision values. Resetting to zero after a demand batch costs at most one fixed charge $K$, so the same bounds $C$ and $\alpha G(0)\le\lambda K$ apply, irrespective of batch size. Inventory monotonicity is unchanged. For $x<0$, the difference of the two demand continuation terms is nonpositive, so $G$ still strictly decreases there and its first minimizer satisfies $S\ge0$. At $S$, the inequality $V(S-D,0)\ge g$ gives $\alpha g\ge hS$. Therefore (4.4), the target bound $S\le U$, and both strict tail exclusions in Theorem 4.2 follow without using Theorem 3.2. The finite contraction and all residual arguments are identical.

For $i\in J$ and $D\ge M+1$, one has $i-D \lt L$. Every target $j\in J$ then requires a positive regular order, so

$$A_0^z(i-D)=K+\min_{j\in J}z_j,\tag{5.1}$$

independently of the batch size. Combining the full tail mass at $M+1$ is exact. Expectations are of bounded quantities; no unmentioned first moment is required. $\square$

This extension depends on fixed, quantity-independent setup charges and the absence of positive lead time. It does not cover an unbounded per-unit purchasing cost with an infinite-mean batch law. Theorem 3.2 is deliberately excluded from Theorem 5.1.

### Theorem 5.2. A strict two-unit-demand counterexample

Let $D=2$, $R=3$ almost surely, and take

$$\lambda=\alpha=h=1,\quad \mu=1/10,\quad b=40,\quad K=15,\quad k=1.\tag{5.2}$$

The first and only global minimizer is $S=4$. At inventory $x=0$ with offered capacity $r=3 \lt S-x$, the unique optimal order quantity is two. Ordering all three units costs strictly more, by $10/21$.

**Proof.** We give the value functions on all integer states. Put $Q=21/10$, $g=119/24$, $a=479/24$, $d_0=65/6$, and $d_2=83/12$. The seven exceptional post-decision values are

| $x$ | $-1$ | $0$ | $1$ | $2$ | $3$ | $4$ | $5$ |
|:--|--:|--:|--:|--:|--:|--:|--:|
| $G(x)$ | $1213/42$ | $59/6$ | $5173/504$ | $71/12$ | $179/28$ | $119/24$ | $913/168$ |

For the remaining states, set

$$
G(x)=\begin{cases}
[-40x+(11/10)a]/Q,&x\le-4,\\
[-40x+a+(1/10)d_0]/Q,&x=-3,-2,\\
[x+(11/10)g]/Q,&x\ge6.
\end{cases}\tag{5.3}
$$

The corresponding pre-decision values are

| Inventory $x$ | $V(x,0)$ | $V(x,3)$ |
|:--|--:|--:|
| $x\le-4$ | $479/24$ | $479/24$ |
| $x=-3,-2$ | $479/24$ | $65/6$ |
| $x=-1$ | $479/24$ | $83/12$ |
| $x=0$ | $59/6$ | $83/12$ |
| $x=1$ | $59/6$ | $143/24$ |
| $x=2,3$ | $71/12$ | $71/12$ |
| $x\ge4$ | $119/24$ | $119/24$ |

Substitution verifies $QG(x)=c(x)+V(x-2,0)+(1/10)V(x,3)$ in each displayed region. For example, $G(2)=[2+59/6+(1/10)(71/12)]/Q=71/12$ and $G(3)=G(2)+1/Q=179/28$.

We also verify minimization over every integer target. The formulas give $G(x)>a$ for $x<0$, $G(1)>G(0)>G(2)>g$, $G(3)>G(2)$, and $G(x)>g$ for every $x\ge5$. On negative states $G$ strictly decreases towards zero; on $x\ge6$ it strictly increases. Thus the free-target prefix minimum is $G(x)$ for $x<0$, $G(0)$ for $x=0,1$, $G(2)$ for $x=2,3$, and $g$ for $x\ge4$.

At $r=0$, all negative states optimally order to four at cost $a$; at nonnegative states the prefix minima just listed are cheaper. At $r=3$, the best discounted target is zero for $x=-3,-2$, two for $x=-1,0$, and four for $x=1$. If $x\le-4$, every discounted target is negative and already has value greater than $a$, so a regular order to four wins. At $x=2,3$, the free target two costs $71/12<1+g=143/24$. At $x\ge4$, the free target four attains $g$. Every regular action costs at least $a$, which cannot improve any displayed entry below $a$. These inequalities verify the full action minimum, including free disposal. In particular, at $(3,3)$ it is essential to allow disposal to two.

The bounded function $V$ therefore solves the unrestricted infinite-state Bellman equation. The contraction modulus is $11/21$, so Lemma 2.2 identifies it as the optimal value. The displayed values and tails show that $S=4$ uniquely. Finally, at $(0,3)$ the minimum in each tariff class is

| Action | Exact total cost |
|:--|--:|
| Best free action, $y=0$ | $59/6$ |
| Discounted quantity one | $5677/504$ |
| Discounted quantity two | $83/12$ |
| Discounted quantity three | $207/28$ |
| Best regular action, $y=4$ | $479/24$ |

All comparisons are strict at the minimum, and $207/28-83/12=10/21>0$. $\square$

The regular reorder threshold in this example is $-1$, so the failure occurs above it. The exact checker `code/compound_demand_boundary.py` independently checks 65 Bellman equalities using the coarse action interval $\{-1,0,\ldots,63\}$ from Lemma 4.1. The sharper interval of Theorem 5.1 is $\{-1,0,\ldots,15\}$. Both are exact; the checker keeps actual states $i-2$ outside its interval and never reflects or clips them. The proof above covers the entire infinite domain without relying on a program.

The one-unit comparison in (3.4) explains this boundary. With unit demand, inventory $x+1$ transitions to $x$, where doing nothing costs at most $G(x)$. With a two-unit demand it transitions to $x-1$, and returning to $x$ can require a paid order. Indeed $G(3)>G(2)$ although the best target is four. Exact finite solvability survives this loss of the descent property.

## 6. Beyond linear costs and constant discount prices

### Theorem 6.1. Single-valley costs and observed capacity-dependent prices

Replace (2.3) by a nonnegative coercive function $c:\mathbb Z\to[0,\infty)$ with $c(0)=0$, strictly decreasing on the negative half-line through zero, and nondecreasing on the nonnegative half-line. At an offer of size $r>0$, replace $k$ by a known $k_r\in[0,K]$. Retain unit demand and all other event-epoch assumptions. Then $G$ decreases strictly below its first global minimizer, and an optimal discounted order ending below that minimizer uses the entire offered capacity.

**Proof.** The bounded Bellman and verification arguments use only coercivity, nonnegative charges, and the feasible reset policy. For each fixed $r$, the fee remains nondecreasing in its target and nonincreasing in the starting inventory. Thus $V$ is inventory-monotone. Strict decrease of $c$ on negative integers gives $S\ge0$. The minimum identity gives $\alpha g\ge c(S)$. For $0\le x \lt S$, the two legal actions in (3.4) give

$$Q[G(x+1)-G(x)]\le c(x+1)-\alpha G(x)
\le-\alpha[G(x)-g]<0.\tag{6.1}$$

On the discounted window the observed charge $k_r$ is constant across quantities, so the endpoint argument of Corollary 3.5 applies. $\square$

Convexity of $c$ is not required. For example, unequal positive multiples of $|x|^p$ on the two half-lines, with $0 \lt p<1$, satisfy these conditions. This is an extension of the capacity theorem; single-valley costs already occur in classical inventory theory [Z].

When $k_r$ varies, a single acceptance threshold in $r$ need not follow, and Theorem 4.4 cannot discard the distribution of prices inside a large-capacity bucket. The capacity-tail result with only (4.7) assumes constant $k$. The linear-cost two-point minimizer description is likewise not asserted for a cost with flat positive segments.

## 7. Exact certificates and verification boundaries

The companion program `code/exact_finite_certificate.py` uses Python's standard-library rational arithmetic. It evaluates deterministic policies and checks every action inequality in the proved finite interval. Five prescribed cases have exact Bellman residual zero:

| Case | Finite target count | First target $S$ | Minimum $g$ |
|:--|--:|--:|--:|
| Accepted insufficient discount | 13 | 1 | $18/11$ |
| Zero discount charge, geometric capacity | 7 | 1 | $31/25$ |
| Discount charge equals regular charge | 5 | 1 | $4/3$ |
| Both setup charges zero | 1 | 0 | $0$ |
| Adjacent target tie | 3 | 0 | $1$ |

### Example 7.1. A strict insufficient-capacity decision

Take $\lambda=\mu=\alpha=h=1$, $b=4$, $K=6$, $k=1$, and $\mathbb P(R=1)=\mathbb P(R=2)=1/2$. The certified values include

$$G(-1)=50/11,\quad G(0)=25/11,\quad G(1)=18/11.\tag{7.1}$$

At $(x,r)=(-1,1)$, the optimal target is $0$, using the full offered unit although the target $S=1$ is unattainable at the discount. The costs of the canonical alternatives are $50/11$ for waiting, $36/11$ for the discount, and $84/11$ for a regular order. The strict gap to the nearest competitor is $14/11$.

### Example 7.2. An exact adjacent tie

Take $\lambda=\mu=\alpha=h=1$, $b=4$, $K=1$, $k=1/2$, and $R=1$. The certificate gives $G(-1)=5/2$ and $G(0)=G(1)=1$. Thus $S=0$ and $\alpha g=h(S+1)$, as in Corollary 3.3. A claim of unconditional uniqueness would fail on this instance.

The certificates establish these finite arithmetic facts. Their implication for the infinite model uses the proved reduction. They do not constitute proof-assistant checks of the general theorems. The manuscript supplies written proofs.

## 8. Vanishing discount, Blackwell optimality, and average cost

The preceding fixed-discount results do not alone settle the long-run problem. We now let $\alpha$ vary, retain arbitrary positive integer laws of $D$ and $R$ without moments, and keep the other linear-cost, fixed-charge, free-disposal assumptions of Theorem 5.1. Write $\nu=\lambda+\mu>0$ and add subscripts $\alpha$ to discounted values. Fix any $\bar\alpha>0$ and define the common finite interval

$$
\bar J=\left\{-\left\lfloor\frac{(2\lambda+\mu+\bar\alpha)K}{b}\right\rfloor,
\ldots,\left\lfloor\frac{\lambda K}{h}\right\rfloor\right\}.
\tag{8.1}
$$

It contains every optimal discounted target for every $0<\alpha\le\bar\alpha$. The demand and offer tails can be aggregated using the endpoints of this single interval. The classical finite-model principle behind Blackwell optimality is due to Blackwell [B]. The contribution here is its exact passage to this infinite inventory model, including unbounded marks, all initial states, and comparison with all admissible policies; we prove those passages explicitly.

### Definition 8.1. Average cost and Blackwell optimality

For a policy $\pi$ and an initial decision state $(x,r)$, let $C^\pi_{x,r}(T)$ be its expected total nonnegative cost through time $T$, including setup charges and the integral of inventory cost. Set

$$\overline J^\pi(x,r)=\limsup_{T\to\infty}\frac{C^\pi_{x,r}(T)}T.\tag{8.2}$$

A deterministic stationary policy is *Blackwell optimal* if it minimizes the original discounted total cost from every initial state for every $\alpha$ in some interval $(0,\varepsilon]$. This definition requires one policy, not a separate optimizer for each discount rate.

### Theorem 8.2. Global Blackwell stability without mark moments

There exist $\varepsilon>0$ and a deterministic stationary policy $\pi^B$ targeting $\bar J$ that is Blackwell optimal from every integer inventory and every nonnegative integer observed capacity. On $(0,\varepsilon]$, each core value $G_\alpha(i)$, $i\in\bar J$, is a rational function of $\alpha$ with real coefficients. With rational parameters and rational aggregated probabilities these coefficients are rational, and a valid positive rational $\varepsilon$ can be certified by finite polynomial sign checks. No unichain assumption is required.

**Proof.** The retained demand and capacity classes and the target set are finite and independent of $\alpha$. A deterministic core policy assigns a target to each retained event class following each $i\in\bar J$. There are finitely many such policies. For a fixed policy $p$, let $P_p$ be its stochastic matrix of post-decision target transitions, and let $d_p$ be the vector whose $i$-th entry is $c(i)$ plus $\nu$ times the expected setup charge at the next event. This is a finite-operator selector; repeated labels for an identical original decision state are harmless at this intermediate step. The consistent original-state policy is constructed below. Its discounted vector satisfies

$$[\alpha I+\nu(I-P_p)]z^p_\alpha=d_p.\tag{8.3}$$

The matrix is invertible for $\alpha>0$: dividing by $\nu+\alpha$ gives an identity minus a strict contraction. Its inverse has rational-function entries. A policy is greedy for its own vector exactly when finitely many inequalities of the form

$$a_r(x,p(x,r))+z^p_\alpha(p(x,r))
\le a_r(x,j)+z^p_\alpha(j),\qquad j\in\bar J,\tag{8.4}$$

hold at its retained event classes. Greediness implies the optimal fixed point by contraction. Every positive $\alpha$ admits such a policy.

Along any sequence $\alpha_n\downarrow0$, one policy occurs infinitely often. Each of its finitely many rational differences in (8.4) is identically zero or has constant sign sufficiently near zero: a nonzero numerator polynomial has only finitely many roots, and there are no positive denominator poles. Since every inequality holds along that subsequence, it holds throughout a common interval $(0,\varepsilon_0]$. This proves optimality of its core vector there.

It remains to control the infinitely many possible initial states. For any $(x,r)$, the vector $(a_r(x,j):j\in\bar J)$ has entries in $\{0,k,K\}$; hence only finitely many distinct fee vectors occur. The rational target differences for every such vector also stabilize in sign on a common smaller interval. Select one minimizing target for each vector, resolving identical ties by a fixed ordering. The resulting stationary policy is independent of $\alpha$ and greedy at every original state, including states outside $\bar J$ and marks beyond the retained tails. It is therefore globally discounted-optimal. The construction never invokes recurrent-class uniqueness. For rational input, rational polynomial arithmetic and real-root isolation can certify a positive rational interval. $\square$

### Theorem 8.3. A bounded bias and optimality for the original average-cost problem

There exist a scalar $\rho\in[0,\lambda K]$, a function $v$ on all decision states, and a coercive function $H:\mathbb Z\to[0,\infty)$ such that

$$
\alpha g_\alpha\longrightarrow\rho,\qquad
G_\alpha(y)-g_\alpha\longrightarrow H(y),\qquad
V_\alpha(x,r)-g_\alpha\longrightarrow v(x,r).
\tag{8.5}
$$

The last convergence is uniform over all $(x,r)$, and $0\le v(x,r)\le K$. Also $\min H=0$, a minimizer belongs to $\bar J$, and the global average-cost equations are

$$
\begin{split}
v(x,r)&=\min_{y\in\mathbb Z}\{a_r(x,y)+H(y)\}
       =\min_{j\in\bar J}\{a_r(x,j)+H(j)\},\\
\nu H(y)&=c(y)-\rho+\lambda\mathbb E v(y-D,0)
                         +\mu\mathbb E v(y,R).
\end{split}\tag{8.6}
$$

From every original initial state,

$$\inf_\pi\overline J^\pi(x,r)=\rho.\tag{8.7}$$

The infimum is over all causal history-dependent randomized policies. The Blackwell policy attains it. Every stationary policy that chooses a minimizing target in $\bar J$ in (8.6) also attains it, with an ordinary limit in (8.2).

**Proof.** For every discount rate, choosing a global minimizer of $G_\alpha$ costs at most $K$, while every action costs at least $g_\alpha$. Thus

$$0\le V_\alpha(x,r)-g_\alpha\le K\quad\text{for every }x,r.\tag{8.8}$$

Write $v_\alpha=V_\alpha-g_\alpha$ and $H_\alpha=G_\alpha-g_\alpha$. Then

$$
(\nu+\alpha)H_\alpha(y)=c(y)-\alpha g_\alpha
 +\lambda\mathbb E v_\alpha(y-D,0)
 +\mu\mathbb E v_\alpha(y,R).
\tag{8.9}
$$

Consequently $0\le\alpha g_\alpha\le\lambda K$ and $0\le H_\alpha(i)\le c(i)/\nu+K$ on the fixed finite core. By Theorem 8.2 its coordinates are rational functions near zero; after shrinking the interval, the first minimizing coordinate is fixed, so $g_\alpha$ is also a rational function. A bounded rational function has a finite limit at zero. This gives $\rho$ and all core coordinates of $H$. The finite minimum formula yields uniform convergence of $v_\alpha$ on the entire state space, with error at most $\max_{j\in\bar J}|H_\alpha(j)-H(j)|$.

Passing to (8.9) is justified by that uniform bound, regardless of either mark distribution's moments. It defines $H(y)$ at every integer and gives the second equation in (8.6). Since $H_\alpha\ge0$ and its core minimum is zero, $H\ge0$ and $\min H=0$. Moreover $H(y)\ge[c(y)-\rho]/\nu$, so $H$ is coercive. For each fixed target $y$, passing to the discounted action inequality gives $v(x,r)\le a_r(x,y)+H(y)$. A target in the finite core attains equality by uniform convergence of its finite minimum, proving both minima in (8.6). In fact every bias-minimizing target lies in the core: below its lower endpoint, $H(y)\ge[c(y)-\rho]/\nu>K\ge v(x,r)$; above its upper endpoint, $H(y)>0$ and a minimizing target $S\le\lfloor\lambda K/h\rfloor$ has no larger setup charge. Both exclusions are strict.

For the lower bound against an arbitrary admissible policy, write $J^\pi_\alpha(x,r)$ for that policy's expected discounted total cost. Nonnegative costs imply the integration-by-parts identity

$$\alpha J^\pi_\alpha(x,r)=\alpha^2\int_0^\infty e^{-\alpha t}C^\pi_{x,r}(t)\,dt.\tag{8.10}$$

If the limsup in (8.2) is infinite the lower bound is immediate. Otherwise the costs are locally finite and, for every $\eta>0$, $C^\pi(t)\le(\overline J^\pi+\eta)t$ after a sufficiently large time. Split (8.10) there. The bounded initial integral tends to zero, and $\alpha^2\int_0^\infty t e^{-\alpha t}\,dt=1$. Hence $\limsup_{\alpha\downarrow0}\alpha J^\pi_\alpha\le\overline J^\pi$. Optimality of $V_\alpha$ and (8.8) now give $\rho\le\overline J^\pi$. This argument never restricts that policy's targets to the core.

For attainment, take any stationary core-valued selector of (8.6). After its first decision, the post-decision inventory $Y_t$ lies in the finite set $\bar J$. The event clock has rate $\nu$ and independent marks, so this is a finite continuous-time chain with generator $L=\nu(P-I)$; self-transitions are permitted and their setup charges remain included. Its expected cost rate at $i$ is $d(i)=c(i)+\nu\mathbb E[\text{next setup charge}\mid i]$. The selector equality in (8.6) reads

$$d(i)+(LH)(i)=\rho\quad(i\in\bar J).\tag{8.11}$$

Finite-state conditioning, or differentiation of the finite transition matrix, gives $\mathbb E H(Y_T)-H(Y_0)=\int_0^T\mathbb E(LH)(Y_t)\,dt$. Integrating (8.11) therefore makes its expected total cost $\rho T+H(Y_0)-\mathbb E H(Y_T)$. The last two terms are bounded independently of $T$; the initial action adds only a bounded fee. The cost per unit time tends to $\rho$. The Blackwell selector is a selector of (8.6) by passage to its discounted equalities, proving its attainment as well. No unichain or recurrence claim was needed. $\square$

### Theorem 8.4. Unit-demand average-cost shape and full-capacity decisions

Suppose $D=1$ and let $S=\min\{y:H(y)=0\}$. Then $S\ge0$, $S\le\lfloor\lambda K/h\rfloor$, and $H$ strictly decreases at every integer below $S$. When $K>0$,

$$hS<\rho\le h(S+1),\qquad
\nu H(x)=hx-\rho\quad(x\ge S+1).\tag{8.12}$$

The minimizers are $S$, and also $S+1$ exactly when $\rho=h(S+1)$. There is an average-optimal canonical policy obtained by the action lists in Theorem 3.4 with $G,g$ replaced by $H,0$. Every positive discounted action minimizing the bias equation when $x+r \lt S$ fills the capacity, and its quantity is unique within that tariff class. This does not assert that every average-cost-optimal policy must choose a bias-minimizing action: finite initial mistakes do not change long-run average cost.

**Proof.** The fee monotonicities give inventory monotonicity of $v$. Negative-inventory subtraction in (8.6) gives $\nu[H(x+1)-H(x)]\le-b<0$, so $S\ge0$. Also $v(x,r)=0$ for $x\ge S$. At the global minimizer,

$$\rho=hS+\lambda v(S-1,0).\tag{8.13}$$

If $K>0$, every free target from $S-1$ has strictly positive $H$, and every nonfree regular target costs at least $K$. Coercivity makes the action minimum attained, so $v(S-1,0)>0$. This proves $\rho>hS$. For $0\le x \lt S$, the same feasible actions used in (3.4) now give

$$\nu[H(x+1)-H(x)]\le h(x+1)-\rho<0.\tag{8.14}$$

For $x\ge S+1$, both continuations vanish and yield the tail identity in (8.12); its nonnegativity at $S+1$ gives the upper bound and the stated tie classification. If $K=0$, then $k=0$, $\rho=v=0$, and $H=c/\nu$, so the claims reduce to $S=0$ and the direct shape of $c$. The bound on $S$ follows from $\rho\le\lambda K$.

Endpoint minimization on each tariff interval now proves the canonical and capacity conclusions exactly as in Theorem 3.4. The canonical targets minimize the global bias equation and lie in its finite action core, so Theorem 8.3 verifies average optimality. Its trajectories started at $x\le S$ never discard inventory. The Blackwell policy is also average optimal; its stabilized discounted target can be either of the adjacent bias minimizers, so we do not silently identify it with the first bias minimizer. $\square$

### Theorem 8.5. A discount-independent average-cost certificate

For any vector $z\in\mathbb R^{\bar J}$, keep the exact tail aggregation and define

$$
e_i=c(i)+\lambda\mathbb E A_0^z(i-D)
          +\mu\mathbb E A_R^z(i)-\nu z_i,\qquad i\in\bar J.
\tag{8.15}
$$

Let $e_- =\min_i e_i$, $e_+=\max_i e_i$, and let $\pi_z$ choose a minimizing target in $A_r^z(x)$ at every original state. Then

$$
e_-\le\rho\le e_+,\qquad
0\le\overline J^{\pi_z}(x,r)-\rho\le e_+-e_-
\quad\text{for every }x,r.
\tag{8.16}
$$

Thus a constant residual $e_i=\rho_0$ certifies the exact average cost $\rho_0$ and a globally average-optimal policy. Unlike (4.8), this certificate has no multiplier diverging as the discount rate vanishes.

**Proof.** Under the greedy policy, $e_i=d_{\pi_z}(i)+(L_{\pi_z}z)(i)$. Finite-state telescoping as in (8.11) bounds its time-average expected cost between $e_-$ and $e_+$, because the terminal $z$ term divided by time tends to zero. Under the average-optimal core selector from Theorem 8.3, minimization in (8.15) gives $d_{\pi^*}(i)+(L_{\pi^*}z)(i)\ge e_-$. The same telescoping gives $\rho\ge e_-$. Optimality gives $\rho\le\overline J^{\pi_z}\le e_+$. Initial arbitrary inventory contributes only one finite initial action, so these bounds hold globally. Subtraction proves the gap bound. $\square$

### Example 8.6. An exact global Blackwell interval and average-cost certificate

Retain the parameters of Example 7.1 but let $\alpha$ vary. The companion symbolic certificate proves that a single policy is optimal from every original state throughout $0<\alpha\le1/100$. Its first target is $S=2$. On the common core $\{-6,\ldots,6\}$, its policy matrix has determinant

$$\det[\alpha I+2(I-P)]
=\tfrac12\alpha(\alpha+2)^9(2\alpha^3+12\alpha^2+24\alpha+17)>0.\tag{8.17}$$

In particular,

$$G_\alpha(2)=\frac{4\alpha^3+22\alpha^2+38\alpha+41}
{\alpha(2\alpha^3+12\alpha^2+24\alpha+17)}.\tag{8.18}$$

There are 105 possible fee patterns on these thirteen ordered targets: zero fees on a prefix of length $a$, discounted fees through a prefix of length $b$, and regular fees thereafter, where $0\le a\le b\le13$. Every original state has one of these patterns, represented by $x=-7+a$, $r=b-a$. The checker compares one fixed target against all thirteen targets for every pattern. Multiplication by the positive determinant and exact deduplication produces 119 polynomial comparisons. After extracting any power of $\alpha$, each nonzero polynomial has strictly positive Bernstein coefficients on $[0,1/100]$; zero self-comparisons are recorded separately. This is a sign proof for the full interval, not a grid of tested discount rates.

The exact limits include

$$\rho=41/17,\qquad H(0)=31/17,\quad H(1)=7/17,\quad H(2)=0.\tag{8.19}$$

All thirteen residuals in (8.15) equal $41/17$, so the average-cost certificate has zero width. Independently, the policy's stationary post-decision probabilities on $(-1,0,1,2)$ are $(2,4,7,4)/17$; the respective cost rates are $(11,1,1,2)$, whose weighted sum is $41/17$. At $(x,r)=(0,1)$, buying the full offered unit costs $1+H(1)=24/17$ in the bias comparison, versus $31/17$ for waiting and $6$ for regular ordering to two. Its strict advantage over every other action is at least $7/17$.

The script `code/blackwell_average_certificate.py` records the complete rational solution, policy matrix, all 105 decision patterns, polynomial-to-comparison map, Bernstein coefficients, limiting bias, and both average-cost calculations. It uses exact rational arithmetic and explicit failure guards. This executable establishes the stated finite arithmetic facts; Theorems 8.2-8.5 supply their global mathematical interpretation. No proof-assistant verification is claimed.

Theorems 8.2-8.5 add an exact long-run criterion, not an average-cost approximation inferred from a small discount. These foundational results retain random capacities and arbitrary batch laws. Section 9 below supplies the additional distributional condition that extends the unit-demand shape theorem to batches. Classical finite-policy rationality and finite-state residual arguments are not claimed as new in isolation. The asserted scope is their rigorously justified infinite-model reduction and the resulting capacity policy structure.

## 9. A demand-shape theorem and a sharp two-size classification

### 9.1. A common form of the discounted and average equations

Let $p_d=\mathbb P(D=d)$ for positive integers $d$. Keep an arbitrary capacity law $R$, positive $\lambda,h,b$, nonnegative $\mu$, and $0\le k\le K$. Write $\eta=\alpha>0$ in the discounted case and $\eta=0$ in the average-cost case, and put $Q=\lambda+\mu+\eta$.

For discounted cost define

$$
f(x)=G(x)-g,\qquad w_r(x)=V(x,r)-g,\qquad \kappa=\alpha g.
$$

For average cost use the particular bounded bias constructed in Theorem 8.3:

$$
f(x)=H(x),\qquad w_r(x)=v(x,r),\qquad \kappa=\rho.
$$

In both cases $f$ is coercive and nonnegative, its minimum is zero, and its first minimizer $S$ is nonnegative. The decision values satisfy $0\le w_r(x)\le K$ and are nonincreasing in $x$. The equations are

$$
Qf(x)=c(x)-\kappa+\lambda\sum_{d\ge1}p_d w_0(x-d)
                 +\mu\mathbb E w_R(x),                       \tag{9.1}
$$

$$
w_r(x)=\min_y\{a_r(x,y)+f(y)\}.                              \tag{9.2}
$$

For $x\ge S$, free disposal to $S$ gives $w_r(x)=0$. For $x \lt S$, put $B(x)=\min_{y\le x} f(y)$. Then

$$
w_0(x)=\min\{B(x),K\},                                      \tag{9.3}
$$

and, for $r>0$,

$$
w_r(x)=\min\left\{B(x),\ k+\min_{x \lt y\le x+r}f(y),\ K\right\}.
                                                                  \tag{9.4}
$$

To justify the apparently unconstrained constant $K$ in (9.4), if $S>x+r$ then regular ordering to $S$ attains it. If $S\le x+r$, the discounted window contains $S$, and its value $k\le K$ makes the added constant redundant. Thus (9.4) does not introduce an infeasible improving action. All minima exist by coercivity.

Define nonnegative decision-value drops

$$
a_j=w_0(j-1)-w_0(j),\qquad
b_j=\mathbb E[w_R(j-1)-w_R(j)].                              \tag{9.5}
$$

Subtracting (9.1) at successive nonnegative inventories yields

$$
Q[f(j)-f(j-1)]=h-\lambda\sum_{d\ge1}p_d a_{j-d}-\mu b_j,
\qquad j\ge1.                                               \tag{9.6}
$$

Every expectation is of a bounded decision value. No demand or capacity moment assumption is used.

### 9.2. The last-rise lemma, including the moving offer window

**Lemma 9.1.** Suppose strict descent before $S$ fails. Let $m$ be the last integer below $S$ such that $f(m+1)\ge f(m)$. Then $m\ge 0$, $m\le S-2$, and

$$
M=\max_{m+2\le j\le S}\{f(j-1)-f(j)\}>0.                    \tag{9.7}
$$

Moreover $a_{m+1}=0$, $0\le a_j\le M$ for $j\ge m+1$, and $0\le b_j\le M$ for $j\ge m+2$.

**Proof.** The negative-inventory monotonicity excludes $m<0$. Since $S$ is the first minimizer, $f(S-1)>f(S)=0$, so the last nondecreasing step cannot be $S-1$. By the choice of $m$, $f$ strictly decreases from $m+1$ to $S$, proving (9.7).

Let $B=\min_{y\le m} f(y)$ and define $\widetilde f(x)=f(\min\{x,S\})$ for $x\ge m+1$. Successive drops of $\widetilde f$ lie in $[0,M]$. Since $f(m+1)\ge f(m)\ge B$, the prefix minimum does not change from $m$ to $m+1$. Equation (9.3) gives $a_{m+1}=0$.

For any $x\ge m+1$, the only possible improvement on the old prefix minimum $B$ before reaching $S$ is the current endpoint of the strictly decreasing suffix. Further, an offer window lying below $S$ has its best suffix target at its right endpoint, and a window reaching $S$ has value zero. Consequently,

$$
w_0(x)=\min\{B,\widetilde f(x),K\},
$$

$$
w_r(x)=\min\{B,\widetilde f(x),k+\widetilde f(x+r),K\}\quad(r>0).
                                                                  \tag{9.8}
$$

For $x\ge S$, these formulas still hold because $\widetilde f(x)=0$. Each expression inside either minimum is nonincreasing in $x$, with any successive drop at most $M$. The pointwise minimum has the same property: if $u_i(x)-M\le u_i(x+1)\le u_i(x)$ for every $i$, the same inequalities hold after taking $\min_i$. Thus every $w_r$ has successive drops at most $M$ on the suffix beginning at $m+1$. This proves the assertions about $a_j$ and $b_j$, including the expected offer term. No behavior of $f$ before $m$, other than the prefix minimum, was assumed. $\square$

### 9.3. Decreasing demand probabilities restore the complete quantity structure

**Theorem 9.2.** Suppose

$$
p_1\ge p_2\ge p_3\ge\cdots\ge0,\qquad \sum_{d\ge1}p_d=1.
                                                                  \tag{9.9}
$$

Then, for arbitrary offer rates and capacity laws, $f(x+1) \lt f(x)$ for every integer $x \lt S$. This holds for both positive-discount value and the average-cost bias described in Section 9.1. Moreover $f$ is nondecreasing on $S,S+1,\ldots$, and its successive differences are nondecreasing on that entire right tail. Thus its global minimizers form a finite consecutive interval beginning at $S$.

**Proof of strict pre-target descent.** Assume the contrary and take $m,M$ from Lemma 9.1. The Bellman difference at the nondecreasing step gives

$$
\lambda\sum_{e\ge1}p_e a_{m+1-e}\le h,                       \tag{9.10}
$$

because its left side in (9.6) is nonnegative and $\mu b_{m+1}\ge 0$.

Choose a maximum-drop position $t$ in (9.7), and write $t=m+1+\ell$, where $\ell\ge 1$. Equation (9.6), with its sign reversed, becomes

$$
QM=-h+\lambda\sum_{d\ge1}p_d a_{t-d}+\mu b_t.                \tag{9.11}
$$

For $1\le d\le\ell$, the index $t-d$ lies in the suffix $\ge m+1$, so Lemma 9.1 bounds the drop by $M$. For $d=\ell+e$, $e\ge 1$, the index is exactly $m+1-e$, and (9.9) gives $p_{\ell+e}\le p_e$. Thus the contribution of the earlier, potentially irregular history is at most the left side of (9.10). Since $b_t\le M$,

$$
QM\le [\mu+\lambda F_D(\ell)]M,\qquad
F_D(\ell)=\sum_{d=1}^{\ell}p_d.                              \tag{9.12}
$$

If $\eta>0$, or if $\mathbb P(D>\ell)>0$, then $Q>\mu+\lambda F_D(\ell)$, contradicting $M>0$.

The only remaining possibility is the average-cost case $\eta=0$ with $\mathbb P(D>\ell)=0$. Here the earlier-history part of (9.11) is actually zero, rather than merely bounded by $h$. Retaining the $-h$ term gives

$$
QM\le-h+(\lambda+\mu)M=QM-h,
$$

again impossible. Hence strict pre-target descent holds in both criteria.

**Proof on the entire right tail.** The nonnegative drops $a_j$ vanish for $j>S$, since $w_0$ is zero there. For $x\ge S$, the offer-value difference also vanishes. Equation (9.6) therefore reads

$$
Q[f(x+1)-f(x)]
=h-\lambda\sum_{j\le S}p_{x+1-j}a_j.                        \tag{9.13}
$$

All indices of $p$ on the right are positive. As $x$ increases, every coefficient weakly decreases by (9.9), so the right side weakly increases. The sums are justified by $\sum_j a_j\le K$, or by the baseline finite-core tail constancy. The first difference at $S$ is nonnegative because $f(S)=0$ is a global minimum. All later differences are therefore nonnegative as well. Coercivity rules out an infinite plateau of minima. $\square$

**Corollary 9.3.** Under (9.9), the complete action lists of Theorem 3.4 apply to arbitrary batch demand, with $G,g$ in the discounted case and $H,0$ in the average-bias case. In particular, whenever $r>0$, $x+r \lt S$, and a positive discounted order is optimal, its quantity is uniquely $r$ within the discounted tariff class. It may tie with waiting or a regular order.

**Proof.** Strict descent makes $x$ the best free target below $S$, makes $x+r$ the best target in a discounted window ending below $S$, and makes $S$ a global minimizing regular target if the window cannot reach it. When the window reaches $S$, its minimum is zero and the $K$ branch is dominated by $k\le K$. The cases are identical to the baseline action comparison once strict descent has been established. $\square$

The average statement concerns bias-minimizing decisions and an average-optimal canonical policy, not every average-optimal policy: finite early mistakes can leave average cost unchanged. Starting from $x\le S$, the canonical policy never disposes, because it targets a level between $x$ and $S$, and positive batch demand only reduces inventory.

The class (9.9) contains geometric distributions, discrete uniform distributions on $\{1,\ldots,m\}$, and the infinite-mean distribution $p_d=1/[d(d+1)]$. Uniform tails and heavy tails are not inferred from numerical truncation: the proof covers their complete laws.

### 9.4. A sharp threshold for the two-size family

Let $P(p)$ denote the assertion that discounted full-capacity ordering as in Corollary 9.3 holds for **every** admissible choice of the original model's rates, costs, and capacity law, when $\mathbb P(D=1)=p$ and $\mathbb P(D=2)=1-p$.

The necessary direction below concerns this universal discounted assertion. The average-bias sufficient result remains Theorem 9.2; an average-only necessary classification is not claimed.

**Theorem 9.4.** For $0\le p\le 1$,

$$
P(p)\quad\Longleftrightarrow\quad p\ge\tfrac12.             \tag{9.14}
$$

For each $p<1/2$, failure occurs with a strictly positive offer rate and with a unique discounted optimum at an insufficient-capacity state.

**Sufficiency.** The demand probabilities are nonincreasing exactly when $p\ge 1-p$, so Theorem 9.2 and Corollary 9.3 apply.

**Necessity, first at zero future offer rate.** Fix $0\le p<1/2$ and define

$$
s=1+2p,\quad \delta=\frac{1-2p}{1+2p},\quad
K=\frac{5-2p}{1+2p},\quad k=1,
$$

$$
\lambda=\alpha=h=1,\quad b=100,\quad\mu=0,\quad R=2.
                                                                  \tag{9.15}
$$

Put

$$
u=\frac4s,\qquad g=\frac{3+2p}s=1+\frac u2,\qquad
A=K+g=\frac8s=2u.
$$

Define the regular pre-decision value on every integer by

$$
V_0(x)=
\begin{cases}
A,&x<0,\\
u,&x=0,1,\\
g,&x\ge2.
\end{cases}                                                   \tag{9.16}
$$

The corresponding post-decision values are

$$
G(x)=\frac{-100x+A}{2}\quad(x<0),
$$

$$
G(0)=u,\qquad
G(1)=\frac{9-2p}{2s}=u+\frac\delta2,\qquad G(2)=g=u-\delta,
$$

$$
G(3)=\frac{7+5p+2p^2}{2s},\qquad
G(x)=\frac{x+g}{2}\quad(x\ge4).                              \tag{9.17}
$$

They satisfy the unrestricted Bellman equation. Indeed, (9.17) is direct substitution in $2G(x)=c(x)+pV_0(x-1)+(1-p)V_0(x-2)$. Every negative target has $G(x)>A$ because $100>A$; hence regular ordering to two is optimal at negative states. At zero and one, the free prefix minimum is $u \lt A$; at every inventory at least two the free target two attains $g$. To check the global minimum,

$$
G(0)-g=\delta>0,\qquad G(1)-g=\tfrac32\delta>0,
$$

$$
G(3)-g=\frac{1+p+2p^2}{2s}\ge\frac14,
\qquad G(x)-g=\frac{x-g}{2}\ge\frac12\quad(x\ge4),
                                                                  \tag{9.18}
$$

where $g\le 3$. Thus $S=2$ is the unique global minimizer. For an arbitrary observed offer $r$, defining $V(x,r)=\min_y\{a_r(x,y)+G(y)\}$ completes the bounded Bellman solution; those values do not enter (9.17) when $\mu=0$. Discounted contraction verifies it against all admissible policies.

At the initial state $x=-1,r=2$, the discounted choices are target zero and target one. Their costs are respectively $1+u$ and $1+u+\delta/2$; the best regular action costs $A=2u$, with gap $u-1\ge 1$. Free negative targets cost more than 50. Therefore the unique optimum orders one unit, although two units are offered and $x+r=1 \lt S=2$. The penalty for filling capacity is exactly $\delta/2>0$.

The initial-state statement with $\mu=0$ is legitimate under the original all-initial-states model. The next paragraph supplies a nondegenerate positive-rate construction as well.

**Positive-rate robustness.** Keep every parameter in (9.15) except let

$$
0<\mu\le\frac{\delta}{100K}.                                \tag{9.19}
$$

For every such rate, $S=2$ remains the unique minimizer, and the unique optimum at $(-1,2)$ remains target zero. The cost of filling capacity exceeds it by at least

$$
\frac{23}{50}\delta.                                       \tag{9.20}
$$

Here is a uniform analytic certificate. Since $2 \lt K\le 5$ and $\mu\le 1/200$, the exact finite core from Theorem 5.1 is $J=\{0,\ldots,\lfloor K\rfloor\}$: its lower endpoint is zero because $(3+\mu)K<100$. Let $z=G_0|_J$ be the values (9.17), and let $F_\mu$ be the exact finite Bellman operator with deterministic capacity two. From the zero-rate equation,

$$
(F_\mu z)_i-z_i=\frac{\mu}{2+\mu}\,[A_2^z(i)-z_i].          \tag{9.21}
$$

For $i$ in $J$, choosing the free target $i$ shows $0\le A_2^z(i)\le z_i$. Also $i\le K$, $V_0\le A=K+g\le 2K$, and (9.17) gives $0\le z_i\le 3K/2\le 2K$. Hence the residual norm is at most $2\mu K/(2+\mu)$. The contraction factor is $(1+\mu)/(2+\mu)$, and therefore

$$
\|G_\mu|_J-z\|_\infty\le2\mu K\le\delta/50.               \tag{9.22}
$$

Any difference of two target values or action costs changes by at most $4\mu K\le\delta/25$. The base target-two margin is at least $\min\{\delta,1/4\}>\delta/25$, so the unique global minimizer stays at two; the exact finite-core theorem excludes all external targets. The margin of target zero over target one is $\delta/2$, leaving at least $\delta/2-\delta/25=23\delta/50$. Its margin over every regular target is at least one, also preserved. The exact finite-core theorem again excludes all free negative targets. This proves the claimed unique action and the stated positive loss for all rates in (9.19), completing necessity. $\square$

Boundary $p=1/2$ is included in the positive theorem. As $p$ approaches it from below, the counterexample gap tends to zero, as required; no positive uniform gap across the boundary is claimed.


## 10. Explicit procurement costs, exact compression, and policy information

### 10.1. Precise extension and main result

Retain the baseline event-epoch model, arbitrary positive-integer demand $D$ and capacity $R$, free disposal, fixed charges $0\le k\le K$, rates $\lambda>0$, $\mu\ge0$, holding and backlog rates $h,b>0$, and discount rate $\alpha>0$. Add a **common actual procurement cash-flow cost** $p>0$ per purchased unit, charged for both regular and discount orders. Thus

$$
 a^p_r(x,y)=a_r(x,y)+p(y-x)^+.
$$

The fixed-charge function $a_r$ is the baseline three-tariff function; negative orders receive no refund. Let $m=\mathbb E D$ and $Q=\lambda+\mu+\alpha$. No capacity moment condition is imposed.

**Theorem 10.1 (finite first moment and explicit exact core).** If $m<\infty$ and $\alpha p \lt b$, the optimal value over the class of all nonanticipating history-dependent randomized policies is finite. All optimal action targets, at every original state $(x,r)$, lie in

$$
 J_p=\{L,\ldots,U\},\qquad
 L=-\left\lfloor{(Q+\lambda)K\over b-\alpha p}\right\rfloor,\quad
 U=\left\lfloor{\lambda(K+pm)\over h}\right\rfloor.
\tag{10.1}
$$

The infinite model is exactly reconstructed from its $|J_p|$ post-decision values. The demand law enters the finite equations only through its masses below the cutoff $M+1$, its entire tail probability and its **tail first moment**, where $M=U-L$. The capacity law enters only through its masses below $M$ and its entire tail probability. The finite operator is a contraction with modulus $\beta=(\lambda+\mu)/Q$, although the original value is unbounded in the negative-inventory direction.

**Theorem 10.2 (sharp failure boundaries).**

1. If $m=\infty$, every policy has infinite expected discounted cost whenever $p,b,\lambda>0$, for every $\alpha>0$.
2. If $\alpha p\ge b$, there are instances with $m<\infty$ (already $\mu=0$, $K>0$ and deterministic unit demand) for which the unique optimal action at every state $(x,0)$ with $x\le0$ is to leave inventory unchanged. Thus no finite set of targets supports an optimal policy from all integer initial inventories.

The second statement is a sharp boundary for a uniform theorem over the stated class, not a claim that every instance with $\alpha p\ge b$ lacks finite representation.

**Theorem 10.3 (global long-run consequence).** If $m<\infty$, fix any $\bar\alpha\in(0,b/p)$. Replacing $\alpha$ by $\bar\alpha$ in the left endpoint of (10.1) yields one finite core for every $0<\alpha\le\bar\alpha$. A single deterministic stationary policy is optimal at **every original state** for all sufficiently small positive $\alpha$. It is also average-cost optimal against all nonanticipating history-dependent randomized policies. The pre-decision average bias may grow linearly with negative inventory, so the all-policy average verification uses Abel comparison, not an unjustified bounded-bias telescoping argument.

These results change the old mechanism materially: reset costs are now unbounded; the relevant value space is affine rather than bounded; probability-only tail aggregation is no longer valid; a first-moment condition is necessary; and a precise discount-price boundary obstructs a uniform finite target set.

### 10.2. Existence, policy verification, and why unbounded values are harmless here

Write $\phi(x)=p(-x)^+$, $\nu=\lambda+\mu$, and $\beta=\nu/Q$. For a bounded function $u$ on the countable decision states, define

$$
 (\mathcal T_\phi u)(x,r)=
 \min_y\left\{a^p_r(x,y)+{c(y)+
 \lambda \mathbb E[\phi(y-D)+u(y-D,0)]+
 \mu \mathbb E[\phi(y)+u(y,R)]\over Q}\right\}-\phi(x).
\tag{10.2}
$$

This is a definition of a transformed operator, not an assumption that an original value exists.

### Lemma 10.4. Nonnegative transformed one-stage cost

Let

$$
 \ell_\phi(x,r,y)=a^p_r(x,y)-\phi(x)
       +{c(y)+\lambda \mathbb E\phi(y-D)+\mu\phi(y)\over Q}.
$$

Then, when $\alpha p \lt b$,

$$
 \ell_\phi(x,r,y)\ge
 {h y^+ +(b-\alpha p)(-y)^+\over Q}\ge0.
\tag{10.3}
$$

At $y=0$,

$$
 0\le \ell_\phi(x,r,0)\le K+{\lambda pm\over Q}.
\tag{10.4}
$$

**Proof.** The purchase part obeys
$p(y-x)^+\ge\phi(x)-\phi(y)$. Hence

$$
 Q\ell_\phi\ge c(y)-\alpha\phi(y)
       +\lambda(\mathbb E\phi(y-D)-\phi(y)).
$$

For $y<0$ the final difference is $pm$ and the first two terms are $(b-\alpha p)(-y)$. For $y\ge0$ the first two terms equal $hy$ and the final difference is nonnegative. This proves (10.3). At $y=0$, the procurement charge exactly cancels $\phi(x)$, leaving a setup charge in $[0,K]$; only a demand adds $\phi(-D)=pD$. This proves (10.4). All expectations are finite because $m<\infty$. $\square$

### Lemma 10.5. Bounded contraction and attained selectors

The operator in (10.2) maps bounded functions to bounded functions and has contraction modulus $\beta$. It has a unique bounded fixed point $u$, which is nonnegative. Each minimum is attained, and every greedy selector targets one common finite set.

**Proof.** If $\|u\|_\infty\le B$, (10.3) gives a lower bound $-\beta B$, while (10.4) gives an upper bound $K+\lambda pm/Q+\beta B$. A minimum is $\beta$-Lipschitz in $u$. The coercive lower bound (10.3), together with the common $y=0$ upper bound, confines all minimizers to

$$
 h y^+ +(b-\alpha p)(-y)^+
 \le QK+\lambda pm+2\nu B.
$$

This is a finite interval independent of $(x,r)$, establishing attainment and a uniform greedy target set. Banach's theorem supplies the unique fixed point. Iteration from zero is nonnegative, proving $u\ge0$. $\square$

Set $V=\phi+u$, and define

$$
 G(y)={c(y)+\lambda \mathbb EV(y-D,0)+\mu \mathbb EV(y,R)\over Q}.
$$

The expectation is finite because $V$ differs from $\phi$ by a bounded function and $\mathbb E D<\infty$. The fixed point solves the original Bellman equation.

### Lemma 10.6. Verification against the full admissible policy class

The constructed $V$ equals the true optimal discounted cost. A deterministic stationary Bellman selector attains it.

**Proof.** Let $T_n$ be event times with $T_0=0$, and let $Y_n$ be the post-decision inventory after action $n$. The intervals after $T_n$ have rate $\nu$ and are independent of the history and chosen actions. For any policy of finite expected discounted cost,

$$
 \sum_{n\ge0} \mathbb E[e^{-\alpha T_n}c(Y_n)]/Q<\infty.
\tag{10.5}
$$

Consequently each term tends to zero. The next pre-decision inventory is $Y_n-D$ at a demand or $Y_n$ at an offer. Since

$$
 \phi(Y_n-D)\le\phi(Y_n)+pD,
$$

independence and conditioning imply

$$
 \mathbb E[e^{-\alpha T_{n+1}}\phi(X_{n+1})]
 \le\beta \mathbb E[e^{-\alpha T_n}\phi(Y_n)]
     +{\lambda pm\over Q}\beta^n\longrightarrow0.
\tag{10.6}
$$

Here $\phi(Y_n)\le p c(Y_n)/b$, and $\mathbb E[e^{-\alpha T_n}]=\beta^n$. The bounded $u$ part also has vanishing discounted terminal expectation. Iterating the Bellman inequality and taking $n\to\infty$ therefore bounds $V$ above by the cost of every finite-cost policy. An infinite-cost policy is trivially no better.

A stationary minimizing selector from Lemma 10.5 has targets in one finite interval, hence bounded running costs and integrable expected procurement costs per event (bounded by a constant plus $pD$). Its discounted total cost is finite. Equality in the Bellman iteration and (10.6) show that its cost is exactly $V$. $\square$

This argument does not assume a weighted transversality condition for arbitrary policies; it derives the needed terminal limit from finite expected discounted cost.

### Lemma 10.7. Useful explicit bounds

The zero-target reset policy gives

$$
 0\le V(x,r)-\phi(x)\le K+{\lambda(K+pm)\over\alpha},\qquad
 G(0)\le{\lambda(K+pm)\over\alpha}.
\tag{10.7}
$$

The latter is the cost of starting at post-decision zero, discarding any surplus at offers, and purchasing $D$ after every demand, before holding costs accrue. The former adds the initial reset charge.

### 10.3. Two distinct minima are essential

The lower-tail proof uses the minimum of $H(y)=G(y)+py$. The upper-tail proof uses the minimum of $G$ itself. They cannot be identified.

### Lemma 10.8. The procurement-adjusted minimum

Put $W(x,r)=V(x,r)+px$ and $H(y)=G(y)+py$. Then

$$
 W(x,r)=\min_y\{d_r(x,y)+H(y)\},
$$

where

$$
 d_r(x,y)=
 \begin{cases}
 p(x-y),&y\le x,\\
 k,&x \lt y\le x+r,\\
 K,&y>x+r.
 \end{cases}
\tag{10.8}
$$

Every $d_r$ is nonnegative. Moreover,

$$
 QH(y)=c(y)+\alpha py+\lambda pm+
        \lambda \mathbb EW(y-D,0)+\mu \mathbb EW(y,R).
\tag{10.9}
$$

By (10.7), $W\ge0$. Thus $H$ is coercive on both tails when $\alpha p \lt b$. Let

$$
 g_H=\min_yH(y),\qquad S_H\in\operatorname{argmin}H.
$$

Equation (10.8) gives $W\ge g_H$. Since $H(0)=G(0)$,

$$
 \alpha g_H\le \lambda(K+pm).
$$

Subtraction in (10.9) yields

$$
 Q[H(y)-g_H]\ge c(y)+\alpha py+\lambda pm-\alpha g_H
              \ge c(y)+\alpha py-\lambda K.
\tag{10.10}
$$

If $y \lt L$ from (10.1), (10.10) gives $H(y)>K+g_H$. Such a target is strictly dominated for **every** state:

- If $x \lt S_H$, target $S_H$ has adjusted fee at most $K$; target $y$ has nonnegative fee.
- If $x\ge S_H$, then $y \lt L\le S_H\le x$. Both are disposal or no-purchase targets and $d_r(x,y)\ge d_r(x,S_H)$, while $H(y)>H(S_H)$.

This establishes the lower endpoint. The relation $L\le S_H$ follows immediately because a minimizer cannot satisfy $H(y)>K+g_H$.

### Lemma 10.9. The unadjusted minimum

The original action fee $a^p_r(x,y)$ is nonincreasing in $x$ for fixed $(r,y)$. Therefore the Bellman equation implies inventory monotonicity of $V$. For negative $y$,

$$
 Q[G(y+1)-G(y)]
 =-b+\lambda \mathbb E[V(y+1-D,0)-V(y-D,0)]
     +\mu \mathbb E[V(y+1,R)-V(y,R)]<0.
$$

The function $G$ is coercive because $G\ge c/Q$. Let

$$
 g_G=\min_yG(y),\qquad S_G=\min\operatorname{argmin}G.
$$

Then $S_G\ge0$. Nonnegative original fees imply $V\ge g_G$, while free disposal to $S_G$ implies $V(x,r)=g_G$ for $x\ge S_G$. In particular,

$$
 \alpha g_G=hS_G+\lambda(\mathbb EV(S_G-D,0)-g_G)\ge hS_G.
\tag{10.11}
$$

By (10.7), $\alpha g_G\le\lambda(K+pm)$, so $S_G\le U$. For $y>U$,

$$
 Q[G(y)-g_G]\ge hy-\alpha g_G
              \ge hy-\lambda(K+pm)>0.
$$

The original action charge is nondecreasing in target $y$. Therefore target $S_G \lt y$ has no larger fee and strictly lower $G$. This proves the upper endpoint and completes Theorem 10.1's target bound.

### 10.4. Finite equations, exact input summaries and global residuals

For $z\in\mathbb R^{J_p}$, define

$$
 A_r^z(x)=\min_{j\in J_p}\{a_r(x,j)+p(j-x)^++z_j\}.
\tag{10.12}
$$

The finite operator is

$$
 (F_pz)_i={c(i)+\lambda \mathbb EA_0^z(i-D)+\mu \mathbb EA_R^z(i)\over Q},
 \qquad i\in J_p.
\tag{10.13}
$$

It has modulus $\beta$ and unique fixed point $z^*=G|_{J_p}$. Reconstruction is $V(x,r)=A_r^{z^*}(x)$ for every original state, with no reflected or clipped boundary.

For $M=U-L$ and $D\ge M+1$, we have $i-D \lt L$ for every retained $i$. Every target requires regular positive procurement, so

$$
 A_0^z(i-D)=K+p(D-i)+\min_j(z_j+pj).
\tag{10.14}
$$

Therefore the demand input consists exactly of

$$
 \Pr(D=d)\ (1\le d\le M),\quad
 t_D=\Pr(D\ge M+1),\quad
 e_D=\mathbb E[D\,1_{\{D\ge M+1\}}],
\tag{10.15}
$$

and its tail contribution is $t_D[K-pi+\min_j(z_j+pj)]+p e_D$. For $M=0$, all demand belongs to the one tail class. In contrast to the $p=0$ case, clamping $D$ to $M+1$ without its tail moment is generally wrong.

For capacities, $R\ge M$ permits every positive order between targets, and the $p$ charge is independent of $R$. Hence the masses for $1\le r \lt M$ and the entire tail probability $\mathbb P(R\ge M)$ suffice when $M\ge1$; if $M=0$, offers are irrelevant in the one-point core. No moment condition on $R$ is used.

If $\delta=\|F_pz-z\|_\infty$ and $E=\delta/(1-\beta)$, then

$$
 |A_r^z(x)-V(x,r)|\le E
 \quad\hbox{for every }x,r.
\tag{10.16}
$$

Although $V$ itself grows linearly as $x\to-\infty$, its reconstruction error is uniformly bounded in absolute value. A minimizing reconstructed policy satisfies

$$
 0\le V^{\pi_z}(x,r)-V(x,r)\le2E
\tag{10.17}
$$

by the two fixed-point residual argument, since the affine policy operator on the finite core has the same contraction factor. The policy's running costs are bounded and its expected procurement cost per event is finite, so Lemma 10.6 justifies its original-model interpretation.

For rational parameters and rational summaries in (10.15), a fixed policy is evaluated by a finite rational linear system. No novel polynomial complexity guarantee is claimed: this is an explicit computable reduction with exact input summaries and a global certificate, beyond the original bounded-cost setting.

### Corollary 10.10. Clipped demand identifies the whole optimal policy; the discarded first moment identifies only a value offset

Suppose a known finite number $\bar m$ satisfies $\mathbb E D\le\bar m$. Construct the common core in (10.1) with $\bar m$ in place of $m$, put $M=U-L$, $d_0=M+1$, and $D_c=\min\{D,d_0\}$. Keep every other parameter and the capacity law unchanged. Let

$$
 \tau=\mathbb E[(D-d_0)^+]<\infty.
$$

Denote the optimal post-decision core vectors and pre-decision values for $D$ and $D_c$ by $z_D,z_c$ and $V_D,V_c$. Then

$$
 z_D=z_c+{\lambda p\tau\over\alpha}\mathbf1,\qquad
 V_D(x,r)=V_c(x,r)+{\lambda p\tau\over\alpha}
 \quad\hbox{for every original }(x,r).
\tag{10.18}
$$

At every original decision state, the complete set of optimal action targets is identical in the two models. In particular, their globally optimal stationary selectors can be chosen identically. To determine the optimal policy, one needs the clipped demand probabilities and the finite mean upper bound used to certify $J$; the tail first moment is needed only to recover the absolute value offset. This does not claim that every arbitrary policy has the same cost offset or that all external post-decision $G(y)$, with $y\notin J$, differ by that constant.

**Proof.** Theorem 10.1 applies to both demand laws because both means are at most $\bar m$. Their common-core operators differ only in the affine demand-tail moment term:

$$
 F_Dz=F_cz+{\lambda p\tau\over Q}\mathbf1.
$$

Both operators satisfy $F(z+t\mathbf1)=F(z)+\beta t\mathbf1$. Taking $t=\lambda p\tau/\alpha$ therefore converts the fixed point of $F_c$ into that of $F_D$. Uniqueness proves the first formula in (10.18); reconstruction by the same finite action fees proves the second. Every candidate action cost inside $J$ changes by the same constant. Every optimal target of either original model is in $J$, so the complete global argmin sets agree. $\square$

For a uniform discount interval $0<\alpha\le\bar\alpha \lt b/p$, construct $J$ using (10.23) and $\bar m$, so that $d_0$ and $\tau$ no longer depend on $\alpha$. Then the optimal average rates satisfy

$$
 \rho_D=\rho_c+\lambda p\tau,
\tag{10.19}
$$

and a common Blackwell selector is average-optimal in both models. This follows by multiplying (10.18) by $\alpha$ and taking $\alpha$ down to zero, together with the full-policy verification of Theorem 10.3. Thus the probability-only clipping is exact for control after the mean-bound core certificate, but it is not exact for absolute cost. The exact instance in Section 12 has $\tau=1/3$, $\lambda=p=1$ and $\alpha=1/2$, hence value offset $2/3$.

### 10.5. Sharp impossibility boundaries

### Proposition 10.11. Positive procurement costs make a first moment necessary

For any $\alpha>0$ and $p,b>0$, let $\kappa=\min\{p,b/\alpha\}>0$. From any initial negative inventory $x$, every policy has expected discounted cost at least

$$
 \kappa(-x)^+.
\tag{10.20}
$$

**Proof.** Attribute the initial $d=(-x)^+$ backlog units individually. A unit filled at time $t$ costs at least $pe^{-\alpha t}$ in procurement plus $b(1-e^{-\alpha t})/\alpha$ in backlog cost before filling. An unfilled unit costs $b/\alpha$. Every such amount is at least $\kappa$. Future demand and disposal cannot decrease the required cost assigned to the initial units. Alternatively apply Stieltjes integration by parts to $A_t=\min\{d,\text{total purchased units up to time }t\}$, using backlog at least $d-A_t$. This is a pathwise lower bound before taking expectations. $\square$

If $\mathbb E D=\infty$, condition on a first event that is a demand. The initial target $Y_0$ is a finite integer almost surely and cannot anticipate $D$. The continuation cost is at least $\kappa(D-Y_0)^+$. Its conditional expectation is infinite for every finite $Y_0$. The demand event has positive probability and a strictly positive discount factor with positive expectation. Thus every admissible policy has infinite total expected discounted cost. There is no hidden need for a second demand moment.

### Proposition 10.12. The strict threshold $\alpha p \lt b$ cannot be omitted

Take $\mu=0$, $K>0$, $m<\infty$, and $\alpha p\ge b$. Start at $(x,0)$ with $x\le0$; all later event capacities also equal zero. Let $\pi_0$ never purchase or discard. Then

$$
 J^{\pi_0}_\alpha(x)=b\left({-x\over\alpha}
                             +{\lambda m\over\alpha^2}\right).
\tag{10.21}
$$

For any finite-cost policy $\pi$, let its positive orders be $q_l$ at times $\tau_l$. Relative to the never-order path, each procured unit can save at most $b/\alpha$ in discounted backlog cost from its purchase time onward. Positive holding costs and disposal cannot increase this saving. Tonelli and the finite procurement bill yield

$$
 J^\pi_\alpha(x)-J^{\pi_0}_\alpha(x)
 \ge \mathbb E\sum_l e^{-\alpha\tau_l}
          [K+(p-b/\alpha)q_l]\ge0.
\tag{10.22}
$$

Any positive probability of a positive order makes the first inequality's right side strictly positive because $K>0$. Discarding from the negative no-order path strictly increases costs. Consequently the unique optimal initial target is $y=x$ at each $(x,0)$ with $x\le0$. No finite target set works for all these initial states, including at equality $\alpha p=b$. With $K=0$ at equality some actions tie; likewise, an artificially supplied initial $r>0$ with $k=0$ can create initial ties. Neither case is used for the strict counterexample.

### 10.6. Blackwell and average control with affine exterior reconstruction

Let $0<\bar\alpha \lt b/p$ and set

$$
 \bar L=-\left\lfloor{(2\lambda+\mu+\bar\alpha)K
                           \over b-\bar\alpha p}\right\rfloor,\qquad
 \bar U=\left\lfloor{\lambda(K+pm)\over h}\right\rfloor.
\tag{10.23}
$$

The fraction for $-L$ increases with $\alpha$, so this is a common core for every $0<\alpha\le\bar\alpha$. All demand and capacity summaries are independent of $\alpha$.

For each deterministic core policy, the post-decision vector solves

$$
 [\alpha I+\nu(I-P)]z_\alpha=d,
\tag{10.24}
$$

where $d$ includes the integrable procurement tail contribution $pe_D$. Hence each entry is rational in $\alpha$, and there are finitely many policies. The usual finite rational-policy argument produces one core-optimal policy on a sufficiently small positive interval.

The essential all-original-state point is **finite affine fee profiles**, not bounded original fees. Subtract $\phi(x)$ from the fee vector

$$
 (a_r(x,j)+p(j-x)^+)_{j\in\bar J}.
$$

There are only finitely many resulting vectors:

1. For $x<\bar L\le0$, the procurement part minus $\phi(x)$ equals $pj$ for all $j$; the fixed fee vector only records the location of $x+r$ relative to the finite target set.
2. For $\bar L\le x\le\bar U$, there are finitely many $x$ and finitely many capacity cut positions.
3. For $x>\bar U\ge0$, every retained target is a free disposal target, so the vector is zero.

All pairwise differences of candidate target costs for these profiles are rational in $\alpha$. Their signs stabilize on a common interval. One minimizing target per profile therefore defines a single globally Blackwell-optimal original-state policy. This argument covers arbitrarily large observed capacities and arbitrarily negative initial inventories.

For average cost, the core rational functions have at most a simple pole at zero because their nonnegative values are $O(1/\alpha)$. Their leading coefficients coincide: on the common finite target set, one-step reset costs between retained levels are uniformly bounded, so all reconstructed finite-state value differences, and thus all core $G$ differences, stay bounded as $\alpha$ tends to zero. Write the common coefficient $\rho$.

For clarity, the uniform bound on core differences can be checked without assuming a bounded bias: for any inventories $x,x'$ and a common observed capacity $r$, the difference between their fees for a fixed target is at most $p|x-x'|+K$. Thus $|V(x,r)-V(x',r)|\le p|x-x'|+K$. Couple the same $D$ and $R$ for two core levels $i,j$ to obtain $Q|G(i)-G(j)|\le|c(i)-c(j)|+\nu(p|i-j|+K)$, uniformly as $\alpha$ tends to zero.

The same Blackwell policy always returns its post-decision state to the finite core. Its expected event costs are finite because $m<\infty$. For this fixed policy, write $z_\alpha=(\rho/\alpha)\mathbf1+\mathbf h+O(\alpha)$ and $L=\nu(P-I)$. Substituting into $[\alpha I-L]z_\alpha=d$ from (10.24), using $L\mathbf1=0$, and taking the constant term gives $d+L\mathbf h=\rho\mathbf1$. Finite-state telescoping therefore gives average cost $\rho$ from every retained state. Every original initial state enters the core after its first action, whose finite cost is negligible after division by horizon length.

For an arbitrary policy $\pi$ with nonnegative cumulative expected cost $C_\pi(T)$, discounted optimality and Abel comparison imply

$$
 \rho=\lim_{\alpha\downarrow0}\alpha V_\alpha(x,r)
 \le\limsup_{T\to\infty}{C_\pi(T)\over T}.
$$

If the limsup is finite, this follows from $J_\alpha^\pi=\alpha\int_0^\infty e^{-\alpha t}C_\pi(t)\,dt$ and the defining eventual linear bound on $C_\pi$; if infinite the assertion is immediate. Thus the finite-core policy is average optimal against the full admissible class, with no unichain assumption and no bounded-global-bias claim.


## 11. Distribution-error and finite-sample consequences

### 11.1. A Kolmogorov perturbation theorem

Here $P$ and $Q$ denote probability-law pairs; the event-rate denominator is written explicitly to distinguish it from the earlier scalar $Q$. Keep all known costs and rates fixed. Let $P=(P_D,P_R)$ and $Q=(Q_D,Q_R)$ be any two positive-integer mark laws, without moment assumptions. Write $d_K(P,Q)=\sup_{t\in\mathbb Z}|P(X\le t)-Q(X\le t)|$ and

$$
 e(P,Q)=K[\lambda d_K(P_D,Q_D)+\mu d_K(P_R,Q_R)]. \tag{11.1}
$$

For each model, let $V_\alpha$, $\rho$ and a bounded average bias be the actual infinite-model objects established in Sections 2, 5 and 8. The procurement price is zero in this entire result; discounted capacities have the constant fixed charge $k$.

**Theorem 11.1.** For every $\alpha>0$ and every original decision state,

$$
 \alpha |V^P_\alpha(x,r)-V^Q_\alpha(x,r)|\le e(P,Q).
 \tag{11.2}
$$

If $\pi^Q_\alpha$ is any core-valued discounted optimal selector for model $Q$, then

$$
 0\le \alpha[J^{P,\pi^Q_\alpha}_\alpha(x,r)-V^P_\alpha(x,r)]
 \le2e(P,Q). \tag{11.3}
$$

The average values and a core-valued $Q$-bias selector satisfy

$$
 |\rho_P-\rho_Q|\le e(P,Q),\qquad
 0\le \overline J^{P,\pi^Q}(x,r)-\rho_P\le2e(P,Q).
 \tag{11.4}
$$

The last statement covers every original initial state, including external inventory and arbitrarily large observed capacity. No irreducibility, mixing-time, finite mark support, or mark moment condition is required.

**Proof.** For a bounded monotone function $f$ of oscillation at most $K$, summation by parts gives

$$
 |\mathbb E_P f(X)-\mathbb E_Q f(X)|\le K d_K(P,Q). \tag{11.5}
$$

For example, if $f$ is nondecreasing, write $f(d)=f(1)+\sum_{t \lt d}[f(t+1)-f(t)]$, apply Tonelli to the nonnegative increments, and bound the differences of survival probabilities. Their increment sum is at most $K$. A decreasing $f$ follows by changing its sign. This proves (11.5) for arbitrary countable laws without integrability beyond boundedness.

For model $Q$, $V^Q_\alpha-g^Q_\alpha$ takes values in $[0,K]$, is nonincreasing in inventory, and is nonincreasing in observed capacity because $k\le K$. For any proposed target $y$, its next-demand value $V^Q_\alpha(y-D,0)$ is a nondecreasing function of $D$; its next-offer value $V^Q_\alpha(y,R)$ is nonincreasing in $R$. Therefore changing the model changes the numerator of its post-decision continuation by at most $e(P,Q)$, uniformly over every integer $y$. Taking the action minimum gives a global Bellman residual at most $e(P,Q)/(\lambda+\mu+\alpha)$. The original bounded Bellman contraction has gap $\alpha/(\lambda+\mu+\alpha)$; hence (11.2).

The same residual bound holds for the fixed policy $\pi^Q_\alpha$, since it is greedy for $V^Q_\alpha$ in model $Q$. Its targets lie in the known finite core shared by $P$ and $Q$, so its policy operator has a bounded fixed point and its actual cost is verified. Thus $|J^{P,\pi^Q_\alpha}_\alpha-V^Q_\alpha|\le e(P,Q)/\alpha$. Combine with (11.2) and optimality to obtain (11.3).

Taking $\alpha$ down to zero in (11.2), using the two models' already established Abel limits, proves the first assertion in (11.4). For the policy assertion take a normalized average bias $v_Q$ in $[0,K]$ and its post-decision function $H_Q$. Both monotonicity properties of $v_Q$ follow either from its action minimum or from the uniform discounted limit. Define for each core target $i$

$$
 \Delta_i=\lambda(\mathbb E_{P_D}-\mathbb E_{Q_D})v_Q(i-D,0)
 +\mu(\mathbb E_{P_R}-\mathbb E_{Q_R})v_Q(i,R).
 \tag{11.6}
$$

Then $|\Delta_i|\le e(P,Q)$. Under $\pi^Q$ in model $P$, its finite post-decision chain has expected cost rate $d_P$ and generator $L_P$. The $Q$ bias equation and greedy equality give

$$
 d_P(i)+(L_PH_Q)(i)=\rho_Q+\Delta_i.
 \tag{11.7}
$$

Finite-state telescoping bounds its average cost between $\rho_Q-e(P,Q)$ and $\rho_Q+e(P,Q)$. The initial action contributes at most $K$ and does not affect the limit. Combine the upper bound with $\rho_P\ge\rho_Q-e(P,Q)$ to obtain (11.4). The true optimum being compared is still over all causal history-dependent randomized policies, by the baseline verification theorem. $\square$

### 11.2. A uniform finite-sample consequence

Observe $n_D$ independent samples from $D$ and $n_R$ independent samples from $R$; the two sample collections may be treated by a union bound, so independence between collections is unnecessary. Let $Q_D,Q_R$ be their empirical laws. For $0<\delta<1$, put

$$
 \epsilon_D=\sqrt{\log(4/\delta)/(2n_D)},\qquad
 \epsilon_R=\sqrt{\log(4/\delta)/(2n_R)}.
 \tag{11.8}
$$

The classical Dvoretzky-Kiefer-Wolfowitz-Massart bound [M] implies, with probability at least $1-\delta$,

$$
 \overline J^{P,\widehat\pi}(x,r)-\rho_P
 \le 2K(\lambda\epsilon_D+\mu\epsilon_R) \quad\hbox{for every }x,r.
 \tag{11.9}
$$

The same sample event gives (11.3) with $e(P,Q)$ replaced by $K(\lambda\epsilon_D+\mu\epsilon_R)$, simultaneously for every positive $\alpha$, even though the learned discounted optimal policy may depend on $\alpha$. There is no union bound over states, targets, or discount rates. If $\mu=0$, omit the capacity sample and use $\sqrt{\log(2/\delta)/(2n_D)}$. No claim of a minimax matching lower bound or an improvement over all inventory learning models is made.

For a fixed discount rate, or for a preassigned range $0<\alpha\le\bar\alpha$ together with the average criterion, fix the corresponding common finite core and its diameter $M$. Only the clipped observations $D\wedge(M+1)$ and $R\wedge M$ are then needed. The earlier assertion simultaneous for all $\alpha>0$ uses the original uncensored empirical-CDF event; it does not assert that this one finite $M$ covers arbitrarily large $\alpha$. Applying the same empirical-CDF inequality to these clipped variables gives (11.9) directly on the finite core: all continuation test functions there are constant on the corresponding tails, and the original all-policy optimum is represented exactly by that core. For $M=0$ the capacity data are irrelevant. Thus a batch censoring device that reports the threshold-exceedance bucket, rather than the actual large mark, preserves the stated policy guarantee. It does not preserve unbounded mark means and is not claimed to do so.

This is a sample-complexity statement and an exact control reduction, not a new claim of a polynomial-time optimization algorithm. Fan et al. already show the importance of inventory structure for lowering generic RL sample complexity. Their reported average-cost bound still includes a state/action range factor, in a different model; a term-by-term, model-aware comparison is required before claiming further improvement.

### 11.3. Why positive procurement prices change the required tail information

The new proportional-cost result proves that the finite Bellman equations require a tail first moment in addition to its tail probability. This is an exact input distinction. The following obstruction is about estimating an absolute value, not policy regret.

**Proposition 11.2.** Fix $p>0$, $\lambda>0$ and $K>0$, with any positive $h,b$ and no discount opportunities. Across all positive-integer demand distributions having a finite mean, there is no finite sample size $n$ for which an estimator, given only those iid demand samples and the known costs and rates (without a mean or tail oracle), can estimate the optimal long-run average cost to any prescribed finite additive tolerance with a uniform success probability greater than $3/4$.

**Proof.** For every finite-mean law the average optimal value satisfies

$$
 \lambda p\,\mathbb E D\le\rho\le\lambda(K+p\,\mathbb E D). \tag{11.10}
$$

The upper bound is the reset-to-zero policy. For the lower bound, use the globally average-optimal finite-core policy already established by the proportional-cost theorem. Its post-decision inventory lies in a fixed finite set. Its procurement in an event is bounded by a constant plus $D$, and disposal is bounded by the core diameter, so both have finite expected rates. Exact inventory accounting gives expected cumulative purchases minus expected cumulative discards equal to $\lambda(\mathbb E D)T$ plus the bounded change in expected inventory. Division by $T$ shows a lower procurement rate of $\lambda\mathbb E D$. All other costs are nonnegative, proving (11.10). This argument applies only to the already verified finite-core optimum; it does not impose a terminal-inventory condition on arbitrary policies.

Now compare $P_0$ concentrated at $1$ with $P_1$ that equals $1$ with probability $1-\epsilon$ and a finite integer $B$ with probability $\epsilon$. Choose $\epsilon\le1/(4n)$, and then choose $B$ so large that the lower endpoint $\lambda p[1+\epsilon(B-1)]$ for $P_1$ exceeds the upper endpoint $\lambda(K+p)$ for $P_0$ by more than twice the proposed tolerance. Both laws have finite means. Under $P_1$ all $n$ observations are $1$ with probability at least $1-n\epsilon\ge3/4$. On that event the estimator sees exactly the $P_0$ data. If it succeeds with probability greater than $3/4$ under $P_0$, its conditional $P_1$ output is wrong with probability greater than $3/4$ on this same data, giving $P_1$ failure probability greater than $9/16$. Thus no estimator can have uniform success greater than $3/4$ under both laws. The argument includes randomized estimators by conditioning on their identical-data output distribution. $\square$

The contrast is limited and precise: probability-only observations support the fixed-charge control and value certificates, whereas an explicit positive procurement bill makes an absolute average-cost certificate require first-moment information. It is not an impossibility of learning a near-optimal policy under positive procurement costs; the policy-independent consumption bill can cancel in regret, and no such broader assertion is made.

## 12. Exact expanded certificates and remaining boundaries

All new certificate arithmetic uses Python rational fractions; numerical checks support the listed instances, while Sections 9-11 prove the general results. The batch checker verifies six strictly positive-offer-rate counterexamples at $p=0,1/10,1/4,1/3,49/100,499/1000$, including the claimed perturbation margins, and six positive-class examples. The latter include the $p=1/2$ boundary, uniform batches, exact geometric demand and capacity tails, and the infinite-mean law $p_d=1/[d(d+1)]$. Every retained Bellman residual is exactly zero. No finite sample of positive cases is used to prove the general distribution theorem.

For explicit procurement, take $p=\lambda=h=1$, $\mu=\alpha=k=1/2$, $b=10$, and $K=2$. Let

$$
 \mathbb P(D=d)=\frac4{d(d+1)(d+2)},\qquad
 \mathbb P(R=r)=\frac1{r(r+1)}.
$$

Demand has mean two and infinite second moment; capacity has infinite mean. The proved core is $J=\{0,1,2,3,4\}$. Exact policy evaluation and all core action inequalities give $g_G=562/81$ but $g_H=8$, exhibiting why the two minima in the proof cannot be identified. The program checks 150 finite distribution identities, five independent core post-decision equations, and 77 external inventory-capacity cases against a larger target window. These external checks are corroboration; Theorem 10.1 supplies the assertion over all states and targets.

Clipping this demand at five loses the excess first moment $1/3$. Corollary 10.10 therefore gives an exact value underestimate $2/3$ at every original decision state while preserving the entire optimal action set. The program independently verifies that constant shift. This separates an incorrect absolute-cost truncation from an exact policy reduction.

The new scope does not include an arbitrary nonmonotone demand classification, positive lead times, general opportunity-dependent unit prices, or a new polynomial-time optimization bound. The full-capacity theorem in Section 9 is for the fixed-charge model; Section 10's procurement extension establishes exact solvability and information separation, without silently importing that shape theorem. The learning result in Section 11 is for the zero-proportional-charge model, and its absolute-value impossibility statement does not imply a policy-regret impossibility. The manuscript supplies written proofs.

## References

**[DMBG]** B. J. De Moor, R. N. Boute, S. Creemers, and J. Gijsbrechts. *Discount replenishment opportunities with limited capacity: Optimal policy and pricing dynamics*. European Journal of Operational Research, online 14 April 2026; assigned 336(2), 497-509 (2027). DOI: [10.1016/j.ejor.2026.04.016](https://doi.org/10.1016/j.ejor.2026.04.016). Full institutional manuscript read; model in Section 3.1, conjecture in Section 3.2, structural proofs in Appendix A.

**[Z]** Y.-S. Zheng. *Optimal Control Policy for Stochastic Inventory Systems with Markovian Discount Opportunities*. Operations Research 42(4), 721-738 (1994). DOI: [10.1287/opre.42.4.721](https://doi.org/10.1287/opre.42.4.721). Publisher abstract and metadata checked; full proof unavailable in this audit.

**[GSW]** G. Gallego and A. Scheller-Wolf. *Capacitated inventory problems with fixed order costs: Some optimal policy structure*. European Journal of Operational Research 126(3), 603-613 (2000). DOI: [10.1016/S0377-2217(99)00314-8](https://doi.org/10.1016/S0377-2217(99)00314-8). Publisher abstract and indexed first-page material checked.

**[RCT]** R. Rossi, Z. Chen, and S. A. Tarim. *On the stochastic inventory problem under order capacity constraints*. European Journal of Operational Research 312(2), 541-555 (2024). DOI: [10.1016/j.ejor.2023.06.045](https://doi.org/10.1016/j.ejor.2023.06.045). Institutional manuscript abstract, introduction, and model assumptions checked; this reference is contextual, not an input to our proofs.

**[B]** D. Blackwell. *Discrete Dynamic Programming*. Annals of Mathematical Statistics 33(2), 719-726 (1962). DOI: [10.1214/aoms/1177704593](https://doi.org/10.1214/aoms/1177704593). Bibliographic record and abstract checked. The finite-model rational-policy principle is classical; the needed argument and infinite-model passages are proved in Section 8.

**[ZF]** Y.-S. Zheng and A. Federgruen. *Finding Optimal (s, S) Policies Is About As Simple As Evaluating a Single Policy*. Operations Research 39(4), 654-665 (1991). DOI: [10.1287/opre.39.4.654](https://doi.org/10.1287/opre.39.4.654). Official abstract and author-institutional manuscript sections concerning the algorithm were checked in the value audit. This work is a computational benchmark; we do not claim its complexity bound for the present model.

**[FS]** Y. Feng and J. Sun. *Computing the Optimal Replenishment Policy for Inventory Systems with Random Discount Opportunities*. Operations Research 49(5), 790-795 (2001). DOI: [10.1287/opre.49.5.790.10613](https://doi.org/10.1287/opre.49.5.790.10613). Official publisher abstract and metadata checked; full proofs were not obtained.

**[VV]** G. van Ryzin and G. Vulcano. *Optimal Auctioning and Ordering in an Infinite Horizon Inventory-Pricing System*. Operations Research 52(3), 346-367 (2004). DOI: [10.1287/opre.1040.0105](https://doi.org/10.1287/opre.1040.0105). Publisher abstract and author-institutional manuscript Section 3.4 inspected in the independent value audit; only the identified Blackwell/average-cost passage is used for positioning.

**[CCY]** O. Caliskan-Demirag, Y. F. Chen, and Y. Yang. *Ordering Policies for Periodic-Review Inventory Systems with Quantity-Dependent Fixed Costs*. Operations Research 60(4), 785-796 (2012). DOI: [10.1287/opre.1110.1033](https://doi.org/10.1287/opre.1110.1033). Official metadata and abstract checked; the independent reviewer also read the author-uploaded full text's structural theorems and heuristic discussion. The periodic-review model is distinct from ours.

**[BSF]** F. G. Badia, C. Sanguesa, and A. Federgruen. *Log-concavity of compound distributions with applications in operational and actuarial models*. Probability in the Engineering and Informational Sciences 35(2), 210-235 (2021; online 2019). DOI: [10.1017/S0269964819000329](https://doi.org/10.1017/S0269964819000329). Official abstract and metadata checked; full theorem-level inspection was unavailable. Its use of nonincreasing probability masses is prior work, and uninspected implications are an explicit limitation of this novelty audit.

**[LS]** A. Leizarowitz and A. Shwartz. *Exact finite approximations of average-cost countable Markov decision processes*. Automatica 44(6), 1480-1487 (2008). DOI: [10.1016/j.automatica.2007.09.013](https://doi.org/10.1016/j.automatica.2007.09.013). Author-hosted manuscript and its finite-embedding theorem were inspected in the independent source audit.

**[GP]** J. Grand-Clement and M. Petrik. *Reducing Blackwell and Average Optimality to Discounted MDPs via the Blackwell Discount Factor*. Advances in Neural Information Processing Systems 36 (2023), main conference. [Official proceedings](https://proceedings.neurips.cc/paper_files/paper/2023/hash/a4e720ce31ccd8ba747d8863e1580fa8-Abstract-Conference.html). Finite-model threshold and algorithm results are prior work.

**[FL]** E. A. Feinberg and Y. Liang. *Structure of optimal policies to periodic-review inventory models with convex costs and backorders for all values of discount factors*. Annals of Operations Research 317, 29-45 (2022; online 2017). DOI: [10.1007/s10479-017-2548-6](https://doi.org/10.1007/s10479-017-2548-6). The discount-dependent distinction between replenishment and no-order policies is prior work. The present boundary is stated for the new random-capacity finite-core theorem, without claiming to originate that phenomenon.

**[FCOQZ]** X. Fan, B. Chen, T. Olsen, H. Qin, and Z. Zhou. *Don't Follow Reinforcement Learning Blindly: Lower Sample Complexity of Learning Optimal Inventory Control Policies with Fixed Ordering Cost*. Production and Operations Management 35(4), 1449-1468 (2026; first online 2025). DOI: [10.1177/10591478251378851](https://doi.org/10.1177/10591478251378851). Official abstract, sample-complexity formulas and metadata checked; the final source audit states any further full-text access.

**[M]** P. Massart. *The Tight Constant in the Dvoretzky-Kiefer-Wolfowitz Inequality*. Annals of Probability 18(3), 1269-1283 (1990). DOI: [10.1214/aop/1176990746](https://doi.org/10.1214/aop/1176990746). The empirical-CDF bound is a cited classical input, not a contribution of this paper.

