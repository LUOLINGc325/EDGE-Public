# Exact discounted queue control with arbitrary heterogeneous servers

## Abstract

We investigate the proposed ordered-occupancy structure for a nonpreemptive infinite-buffer queue with one fast exponential server and an arbitrary finite number of identical slow exponential servers. The full discounted and stable average-cost statement is retained as the research target but is neither proved nor refuted here. The first research round identifies exact obstructions to extending the known two-slow-server invariant-cone argument, including an obstruction that survives a continuous convex extension, bounded slopes, an optimized-input condition, and an affine tail. A proposed stronger auxiliary inequality already fails on the true third Bellman iterate.

The substantive second round supplies a quantitative discounted full-occupancy tail within the explicitly restricted fast-work-conserving physical policy class, together with an exact finite algebraic Bellman boundary. An independent rational certificate in the unrestricted original two-slow-server model verifies an optimal occupancy jump from zero to two. The latter uses every physical nonpreemptive action, a real-event waiting-cost identity, and an analytic infinite continuation. It disproves two stronger proposed properties but is consistent with the known two-slow-server threshold theorem. These results do not establish the arbitrary-capacity ordered-occupancy conjecture or its average-cost counterpart.

The unrestricted discounted problem admits an explicit full-occupancy threshold for every finite array of heterogeneous rates. Above this threshold, a first-passage transform gives the exact geometric correction to an affine value, leaving only a finite real-event Bellman problem.

## The frozen research question

For every integer m>=1, lambda>=0, a>b>0, and alpha>0, does the original one-fast/m-identical-slow queue admit an optimal stationary deterministic policy with a nondecreasing preferred slow occupancy h(n), with final occupancy max(y,h(n)), and the corresponding stable average-cost structure when lambda<a+mb? The complete quantified statement and action conventions are preserved in original quantified problem. No change to this target is hidden in the restricted supporting tail theorem.

## Contribution and scope map

| Chapter | Delivered mathematical content | Exact limitation |
|---|---|---|
| E | All-capacity linear-event stencil identities and cone preservation | Does not establish nonlinear Bellman closure |
| A | Convex-row tail increment formula and global proof-invariant obstructions | Generic witnesses are not asserted to be reachable value functions |
| A4 | Negative K8 expression on the actual third Bellman iterate | K8 is auxiliary; its failure is not a policy counterexample |
| B | Explicit discounted full-occupancy tail and finite algebraic boundary | Fast-work-conserving policy class only; no average-cost limit |
| C | Exact infinite-state original-model policy certificate at rational parameters | A two-slow-server instance |
| D | Unrestricted high-population threshold and exact finite reduction | Arbitrary finite rate array with discounted holding cost |

The known m=2 framework is due to Wang et al., [arXiv:2607.22580](https://www.cs.cmu.edu/~weinaw/pdf/One_fast_two_slow_conjecture.pdf). The broader literature and the limits of this run's novelty checks are recorded in the original ledger and novelty audit. No claim of global priority or external human peer review is made.

## Notation and value semantics

Each chapter is a self-contained proof note. The linear stencils L_i in Chapter E are the K_i expressions in Chapter A. Chapter B uses V for the auxiliary scaled postdecision value and U for the unscaled physical decision value QV/D. Chapter C uses U as an auxiliary scaled construction function, W as the scaled physical decision value, and H as the scaled physical cost of waiting after a fixed dispatch. Thus Chapter C's W corresponds to D times Chapter B's physical U. Arbitrary virtual postdecision values are not identified with arbitrary already-fixed physical postdecision values.

The first draft and its actual-value review were frozen before the formal second research round. A later semantic audit corrected the first draft's overbroad postdecision interpretation; the frozen original is retained rather than silently rewritten. The semantic correction and historical independent reviews document the distinction.

## Verification boundaries

Exact Python arithmetic certifies the displayed finite algebra and the fixed-parameter infinite-state certificate. Floating-point searches remain exploratory. Lean 4.19.0 verifies only three linear-event support propositions; an independent audit of all 26 declarations in that module found no transitive axiom outside Classical.choice, Quot.sound, and propext after the documented code-generation repair. Full-manuscript Lean coverage remains required and unfinished. Detailed statements follow.

---

# Uniform event-operator identities

This is a supporting result, not a proof of the queueing threshold conjecture.
All indices below are integers in the indicated domains. Let $m\ge1$ and
$f:\mathbb N_0\times\{0,\ldots,m\}\to\mathbb R$. Write

$$
\begin{aligned}
L_1f(x,y)&=f(x+1,y)-f(x,y),\\
L_2f(x,y)&=f(x+2,y)+f(x,y+1)-f(x+1,y)-f(x+1,y+1),\\
L_3f(x,y)&=f(x,y)+f(x+1,y+1)-f(x+1,y)-f(x,y+1),\\
L_4f(x,y)&=f(x,y+1)-f(x,y),\\
L_5f(x,y)&=f(x,y)+f(x,y+2)-2f(x,y+1),\\
L_6f(x,y)&=f(x+2,y)+f(x,y+2)-2f(x+1,y+1),\\
L_7f(x,y)&=f(x+2,y)+f(x,y)-2f(x+1,y).
\end{aligned}
$$

Only legal arguments are used: $L_1,L_7$ require $0\le y\le m$;
$L_2,L_3,L_4$ require $y<m$; $L_5,L_6$ require $y+2\le m$.
Let $\mathcal K_m$ be the cone where $L_1,\ldots,L_6$ are nonnegative.
For $y<m$, $L_7f(x,y)=L_2f(x,y)+L_3f(x,y)$.
For the last row,
$L_7f(x,m)=L_2f(x,m-1)+L_3f(x+1,m-1)$.
Consequently $L_7\ge0$ throughout $\mathcal K_m$.
The definitions generalize, with attribution, the six-inequality cone of
Wang et al. (arXiv:2607.22580), whose stated capacity is $m=2$.

## Proposition E1: all-capacity pure-death identities

Define the unnormalized slow-completion operator

$$
(D_m f)(x,y)=y f(x,(y-1)^+)+(m-y)f(x,y).
$$

At legal arguments one has

$$
\begin{aligned}
L_1D_m f(x,y)&=yL_1f(x,y-1)+(m-y)L_1f(x,y),\\
L_2D_m f(x,y)&=yL_2f(x,y-1)+(m-y-1)L_2f(x,y)+L_7f(x,y),\\
L_3D_m f(x,y)&=yL_3f(x,y-1)+(m-y-1)L_3f(x,y),\\
L_4D_m f(x,y)&=yL_4f(x,y-1)+(m-y-1)L_4f(x,y),\\
L_5D_m f(x,y)&=yL_5f(x,y-1)+(m-y-2)L_5f(x,y),\\
L_6D_m f(x,y)&=yL_6f(x,y-1)+(m-y-2)L_6f(x,y)+2L_2f(x,y).
\end{aligned}
$$

A term with coefficient $y=0$ is omitted; it is never an invocation of
$f$ at a negative row. A term with coefficient $m-y-j=0$ is also omitted
if its associated expression would otherwise exceed the strip. These
identities follow by expanding each term and collecting the coefficients
of each $f$ value. For example the final right hand side expands to

$$
\begin{split}
&y f(x+2,y-1)+(m-y)f(x+2,y)\\
&\quad-2(y+1)f(x+1,y)-2(m-y-1)f(x+1,y+1)\\
&\quad+(y+2)f(x,y+1)+(m-y-2)f(x,y+2),
\end{split}
$$
which is exactly $L_6D_mf$. The other five expansions are analogous and
are independently checked by the symbolic coefficient script. Every
coefficient displayed before an $L_i$ is nonnegative on its domain.
Thus $D_m\mathcal K_m\subseteq\mathcal K_m$ for every $m\ge1$.

## Proposition E2: arrival and fast completion

Let $(Af)(x,y)=f(x+1,y)$ and $(Bf)(x,y)=f((x-1)^+,y)$.
All differences of $Af$ are corresponding differences of $f$ at $x+1$.
For $x\ge1$, all differences of $Bf$ are those of $f$ at $x-1$.
At $x=0$ the six differences are, respectively,

$$
0,\quad L_1f(0,y),\quad0,\quad L_4f(0,y),\quad
L_5f(0,y),\quad L_1f(0,y)+L_5f(0,y).
$$

Hence $A$ and $B$ preserve $\mathcal K_m$. As the cone is closed under
nonnegative linear combinations, the queue event operator
$P=\lambda A+aB+bD_m$ preserves it whenever $\lambda,a,b\ge0$.
No ordering $a>b$ is needed for this algebraic preservation lemma.

## Exact limit of this result

It is invalid to infer that $P Q$ or $Q P$ preserves the cone: the
assignment operator $Q$ can leave it as soon as $m\ge3$. The polynomial
counterexample in `assignment_closure.md` demonstrates this. E1/E2
only settle the linear event part of a possible proof. They do not
establish the six inequalities for actual value iteration, optimal
thresholds, or a passage to average cost.


---

# Assignment minimization: preserved shape and exact obstructions

**Research status.** The results in this note concern proposed proof mechanisms. They do **not** resolve the all-finite-m slow-server threshold question. In particular, a function in a proposed invariant class need not be an actual queue value iterate. Only Proposition A4 below uses the actual Bellman orbit.

The two-slow-server six-inequality approach is due to Wang et al., arXiv:2607.22580. The historical proof-obstruction contributions are identified in the source and review record.

## A. Definitions

Fix an integer m >= 1. Functions f are defined on x >= 0 and 0 <= y <= m, with integer coordinates. The modified assignment operator is

$$
(\widetilde Q_m f)(x,y)
 =\min_{y\le k\le\min(m,x+y)} f(x+y-k,k).
$$

This modified operator permits the fast-server job to be moved; its eventual equivalence to the original nonpreemptive problem requires a separate proof. Define the total-population coordinates

$$
g(n,y)=f(n-y,y),\qquad 0\le y\le \min(m,n).
$$

Then the transformed assignment operator is the row tail minimum

$$
H(n,y)=\min_{y\le k\le u_n}g(n,k),\qquad u_n=\min(m,n).
$$

The six candidate inequalities, generalized from the existing m=2 paper, are

$$
\begin{aligned}
K_1 &: f(x+1,y)-f(x,y)\ge0,\\
K_2 &: f(x+2,y)+f(x,y+1)-f(x+1,y)-f(x+1,y+1)\ge0,\\
K_3 &: f(x,y)+f(x+1,y+1)-f(x+1,y)-f(x,y+1)\ge0,\\
K_4 &: f(x,y+1)-f(x,y)\ge0,\\
K_5 &: f(x,y)+f(x,y+2)-2f(x,y+1)\ge0,\\
K_6 &: f(x+2,y)+f(x,y+2)-2f(x+1,y+1)\ge0.
\end{aligned}
$$

Each is imposed only when all coordinates are in the stated domain. Their sum K2+K3 yields convexity in x, denoted K7:

$$
f(x+2,y)+f(x,y)-2f(x+1,y)\ge0.
$$

For y=m, use K2 at (x,m-1) plus K3 at (x+1,m-1). This endpoint case matters.

## A1. The exact tail-increment identity

**Proposition A1.** Suppose each row k -> g(n,k) is discretely convex, equivalently K6. For 0 <= y < u_n,

$$
H(n,y+1)-H(n,y)=\max\{g(n,y+1)-g(n,y),0\}. \tag{A1}
$$

**Proof.** Put d_y=g(n,y+1)-g(n,y). If d_y>=0, discrete convexity makes every later adjacent increment nonnegative, so the tail minimum at y is g(n,y), and the tail minimum at y+1 is g(n,y+1). If d_y<0, the y point is strictly worse than y+1, so removing y leaves the tail minimum unchanged. The equality case is included in the first branch. The tail is finite and nonempty, so no attainment assumption is missing. This proves (A1).

Consequences:

1. **K6 is preserved:** the d_y are nondecreasing in y, and positive-part clipping preserves that order.
2. **K2 is preserved:** K2 is precisely
   $$
   d(n+2,y)\le d(n+1,y).
   $$
   The corresponding clipped increments have the same order. All rows used are feasible because the original x is nonnegative.
3. **K1 is preserved if K1 and K4 hold for f.** Existing feasible k give g(n+1,k)>=g(n,k)>=H(n,y). The only possibly new candidate is k=n+1 when n<m; its value is f(0,n+1)>=f(0,n)>=H(n,y), by K4. Taking the minimum gives H(n+1,y)>=H(n,y).
4. **K4 is then preserved:** H(n+1,y+1)>=H(n+1,y)>=H(n,y). The first inequality follows directly from nested tails; the second is the preceding result.

These facts are uniform in m, but they leave K3 and K5 open. They must not be read as a proof that the entire six-inequality class is preserved.

## A2. Failure of the naive six-inequality class

**Proposition A2.** For every m>=3, the class K1--K6 is not preserved by the modified assignment operator.

**Proof.** Choose an integer C>=m+1 and let

$$
f_C(x,y)=x^2+xy+Cy.
$$

Direct differences give

$$
K_1=2x+y+1,\quad K_2=1,\quad K_3=1,\quad
K_4=x+C,\quad K_5=0,\quad K_6=0.
$$

Thus f_C belongs to the class on the entire infinite strip. In total coordinates,

$$
g_C(n,k)=n^2+(C-n)k.
$$

At n=C-1,C,C+1, all k=0,...,m are feasible. Consequently

$$
H(C-1,0)=(C-1)^2,\quad H(C,0)=C^2,\quad
H(C+1,0)=(C+1)^2-m.
$$

The second difference is 2-m<0. Since K2 is preserved by A1, K3 must fail; in fact the K3 expression at original coordinates (C-1,0) is exactly 2-m. This is a global counterexample to the proof invariant, not to optimal queue policies. QED.

The mechanism is an abrupt change in the minimizing slow occupancy. Separate convexity along rows does not prevent the partial minimum from losing convexity in population.

## A3. Even the optimized six-inequality class is not invariant

A natural repair is to work only with already optimized W satisfying

$$
\widetilde Q_mW=W.
$$

In total coordinates this says that every row is nondecreasing in slow occupancy. It excludes the input of A2. Nevertheless, the composite optimized Bellman map also fails to preserve the six-inequality class.

Let lambda=1, a=4, b=1, alpha=1. Thus

$$
\Gamma=m+5,\qquad D=\alpha+\Gamma=m+6.
$$

The event operator is

$$
(P_mW)(x,y)
 =W(x+1,y)+4W((x-1)_+,y)
   +yW(x,(y-1)_+)+(m-y)W(x,y).
$$

Define

$$
S_mW=\widetilde Q_m\left((x+y)+P_mW/D\right).
$$

**Proposition A3.** For every m>=3 there is a global W satisfying K1--K6 and Qtilde W=W such that S_m W violates K3 and x-convexity.

**Proof.** Put C=m+8 and set

$$
W(x,y)=(x+y)^2+y(C-x-y)_+.
$$

Write n=x+y and h(n)=(C-n)_+. Then

$$
g(n,y)=n^2+yh(n),
$$

so g is nondecreasing in y and Qtilde W=W. The sequence h has adjacent differences in [-1,0] and nonnegative second differences. For all valid x,y,

$$
\begin{aligned}
K_1(W)&=2n+1+y\bigl(h(n+1)-h(n)\bigr)\ge2n+1-y\ge0,\\
K_2(W)&=h(n+1)-h(n+2)\ge0,\\
K_3(W)&=2+y\Delta^2h(n)+h(n+2)-h(n+1)\ge1,\\
K_4(W)&=2n+1+h(n+1)+y\bigl(h(n+1)-h(n)\bigr)\ge0,\\
K_5(W)&=2+y\Delta^2h(n)+2\bigl(h(n+2)-h(n+1)\bigr)\ge0,\\
K_6(W)&=0.
\end{aligned}
$$

Hence membership holds on the entire infinite strip, not just a tested grid.

Let n0=m+6=C-2 and let F(n,y) be the total-coordinate version of n+P_mW/D. For n=n0-1,n0,n0+1, every event predecessor used has positive fast occupancy and population at most C, so the polynomial branch h(n)=C-n applies exactly. Calculation gives

$$
F(n,y+1)-F(n,y)
 =\frac{(m+4)C-(m+6)n+4+2y}{D}
 =\frac{D(n_0-n)+2y}{D}. \tag{A2}
$$

Also

$$
F(n,0)=n+\frac{(m+5)n^2-6n+5}{D},\qquad
\Delta_n^2F(n,0)=\frac{2(m+5)}D. \tag{A3}
$$

At n0-1 all row increments in (A2) are positive, and at n0 they are nonnegative. Their smallest minimizer is y=0. At n0+1 the smallest minimizing occupancy is

$$
r=\min\{m,\lceil(m+6)/2\rceil\},
$$

and its gain over y=0 is

$$
F(n_0+1,r)-F(n_0+1,0)
 =-\frac{r(m+7-r)}{m+6}.
$$

Therefore the x second difference of S_m W at (n0-1,0) is

$$
\frac{2(m+5)-r(m+7-r)}{m+6}. \tag{A4}
$$

This is strictly negative for every m>=3. Indeed, put D=m+6. Then 3<=r<=D-2 and

$$
r(D-r+1)-3(D-2)=(r-3)(D-r-2)\ge0.
$$

The numerator of (A4) is at most 2D-2-3(D-2)=4-D<0. At n0 the y=0 and y=1 values coincide, so the K3 expression at original coordinates (n0-1,0) equals the same negative quantity. This proves the claim. QED.

For the smallest case m=3 the three optimized values are 541/9, 680/9, 814/9; the second difference and the K3 defect equal -5/9.

This failure concerns an arbitrary valid optimized W. It does not establish that W is reachable from zero terminal cost, and hence does not establish any failure of the original threshold conjecture. It rules out the generic closure argument exactly as stated.

## A3b. Convex extension, bounded slopes and an affine tail do not repair closure

The preceding witnesses are not convex functions of the two real state
coordinates. The stronger repair of demanding such an extension also fails, even with bounded
coordinate slopes and an exactly affine tail.
For every integer m>=3, keep lambda=1, a=4, b=1, alpha=1, and put

$$
n_0=2m+10,\quad D=m+6,\quad
C=\frac{(m+6)n_0-(3m+34)/4}{m+4}.
$$

Define, in total-population coordinates,

$$
W(x,y)=2C(x+y)+(C-x-y/2)_+^2.
\tag{A3b.1}
$$

The squared positive part is a convex, nondecreasing function of its argument,
so (A3b.1) is convex on the real plane. In particular, this witness satisfies
every valid Jensen inequality with arbitrary rational barycentric weights,
not just midpoint tests along integer directions. Its coordinate slopes on
the nonnegative quadrant lie between 0 and 2C. For n=x+y>=C+m/2,
W(x,y)=2Cn, independently of the occupancy y.

For completeness, write t=C-x-y/2 and phi(t)=(t_+)^2. The affine summand
cancels from K2, K3, K5 and K6. The K2 margin is
phi(t-2)+phi(t-1/2)-phi(t-1)-phi(t-3/2)>=0 because increments of the
convex phi over equal half-unit intervals are increasing. The K3 margin is
phi(t)+phi(t-3/2)-phi(t-1)-phi(t-1/2)>=0 by the same fact. K5 and K6
are ordinary centered half-unit second differences of phi. K1 and K4 follow
from the nonnegative coordinate slopes. Finally,
W(n-y,y)=2Cn+phi(C-n+y/2) is nondecreasing in y, proving Qtilde W=W globally.

Let Gamma=lambda+a+mb=m+5. More generally, on the polynomial branch and away
from the fast-server boundary, the event image F=n+PW/D has the form

$$
F(n-y,y)=F(n,0)+\frac{Ay^2+B(n)y}{D},
\quad A=\frac{\Gamma+2b}{4},
$$

$$
B(n)=C(\Gamma-b)-(\Gamma+b)n+a-\lambda+b/4.
\tag{A3b.2}
$$

The selected C gives B(n0)=-3A. Moreover
C-n0=(13m+46)/(4(m+4))>2, so every predecessor used in the three populations
n0-1,n0,n0+1 lies on that polynomial branch; n0-2-m>0 also keeps their fast
servers busy. Since Gamma>2b, exact integer minimization of (A3b.2) gives

$$
\operatorname*{argmin}_{0\le y\le m}F(n_0-1-y,y)=\{0\},\quad
\operatorname*{argmin}_{0\le y\le m}F(n_0-y,y)=\{1,2\},\quad
\operatorname*{argmin}_{0\le y\le m}F(n_0+1-y,y)=\{3\}.
\tag{A3b.3}
$$

Indeed the continuous quadratic minimizers are respectively
1.5-2(Gamma+b)/(Gamma+2b), 1.5, and
1.5+2(Gamma+b)/(Gamma+2b); the first is negative, and the third lies strictly
between 3 and 3.5. The integer minima in (A3b.3) follow, including m=3.

The second n difference of F(n,0) is 2Gamma/D. The minimization reductions at
these three populations are 0, -2A/D, and -3(Gamma+b)/D. Consequently

$$
(SW)(n_0-1,0)+(SW)(n_0+1,0)-2(SW)(n_0,0)
=\frac{2\Gamma-3(\Gamma+b)+4A}{D}
=-\frac bD=-\frac1{m+6}<0.
\tag{A3b.4}
$$

The same value is the K3 slack at (x,y)=(n0-1,0): the center and upper
population minima in (A3b.3) remain feasible when the occupancy floor is one.

Thus adding a genuine continuous convex extension, bounded coordinate slopes,
and an exactly affine diagonal-flat tail to the six inequalities and the
optimized fixed-point property does not make S invariant. This is still
an obstruction for an arbitrary input W; it does not identify a reachable
Bellman iterate and does not disprove the queue threshold conjecture.

## A4. A standard stronger discrete-convexity condition fails on the actual orbit

An alternative repair is to add

$$
K_8(f):=f(x,y+2)+f(x+1,y)-f(x,y+1)-f(x+1,y+1)\ge0.
$$

Together with suitable other inequalities, this resembles the extra diagonal-dominance condition needed to use standard L-natural-convex projection results after a coordinate transformation. This repair is unavailable even for actual value iteration.

Let m>=2, lambda>0, a>b>0, alpha>0 and

$$
\Gamma=\lambda+a+mb,\qquad D=\alpha+\Gamma.
$$

Use the **original nonpreemptive** assignment operator Q, with upper limit min(m,(x-1)_++y), and define the rescaled finite-horizon orbit

$$
V_0=0,\qquad V_{t+1}(x,y)=x+y+(P_mQV_t)(x,y)/D.
$$

**Proposition A4.** At the exact third iterate,

$$
K_8(V_3)\big|_{(x,y)=(2,m-2)}=-\frac{b^2}{D^2}<0. \tag{A5}
$$

**Proof.** V1=n and

$$
V_2(x,y)=A n+\frac\lambda D-\frac aD\mathbf1_{\{x>0\}}-\frac{by}D,
\qquad A=1+\Gamma/D.
$$

For x>=1, the original assignment operator keeps the fast-server job and maximizes occupied slow servers. Thus

$$
(QV_2)(x,y)=R(n),\qquad
R(n)=An+\frac{\lambda-a}D-\frac bD\min(m,n-1).
$$

This is valid for every x>=1 and feasible y. In particular, when x>=2 all predecessor states in the event operator still have positive fast occupancy, giving

$$
V_3(x,y)
 =n+\frac{\lambda R(n+1)+(a+yb)R(n-1)+(m-y)bR(n)}D.
$$

The adjacent slow-occupancy increment at fixed n is b(R(n-1)-R(n))/D. The K8 expression at (2,m-2) is therefore

$$
\frac bD\bigl(2R(m+1)-R(m)-R(m+2)\bigr).
$$

The only slope change in R is at n=m+1, and its second difference there equals b/D. Equation (A5) follows. QED.

This calculation is exact and uses no finite-buffer approximation. It disproves a particular stronger invariant, not threshold optimality.

## A5. Remaining research obligation

The main all-m queue theorem is still open in this note. A successful continuation must do at least one of the following:

* identify a genuinely stronger condition satisfied by the **reachable** Bellman orbit that survives optimization and the state-dependent event operator, without imposing the false K8 condition;
* prove the necessary threshold inequalities by a direct composite recurrence rather than generic class preservation;
* establish an occupancy-aware stochastic comparison that remains valid when slow service completions change the occupancy layer;
* or construct a verified counterexample to the original infinite-buffer control statement, including exact Bellman optimality or a certified approximation error separating all relevant actions.

A failure of the six-cone method, of its optimized restriction, or of a finite-horizon auxiliary invariant alone cannot be promoted to the main theorem or its negation.

## Verification and sources

Run `python3 evidence/code/assignment_exact_certificate.py` at the repository root for exact Fraction arithmetic checks of A3 for m=3,...,12 and A4 for m=2,...,12. These finite checks are regression certificates; the universal proofs are given above. [assignment_probe.py](evidence/code/assignment_probe.py) is an explicitly exploratory floating-point script and carries no certification role.

1. Wang et al., *Optimality of a Threshold Policy for a Queueing System with One Fast Server and Two Identical Slow Servers*, arXiv:2607.22580. Existing model, six-inequality framework and m=2 closure: https://www.cs.cmu.edu/~weinaw/pdf/One_fast_two_slow_conjecture.pdf
2. Moriguchi and Murota, *On Fundamental Operations for Multimodular Functions*, JORSJ 62 (2019), 53--63, doi:10.15807/jorsj.62.53. Standard coordinate/projection tools and limits of general convolution: https://orsj.org/wp-content/or-archives50/pdf/e_mag/Vol.62_02_053.pdf
3. Kim, Ahn and Righter, *Managing Queues with Heterogeneous Servers*, JAP 48 (2011), 435--452, doi:10.1239/jap/1308662637. Existing all-slow-idle threshold and limits of older coupling: https://www.cambridge.org/core/services/aop-cambridge-core/content/view/676D07927BD5DB3EC17EB5E8C82DA802/S002190020000797Xa.pdf/managing_queues_with_heterogeneous_servers.pdf


---

# Route B: exact cost transforms and a certified finite tail

This chapter develops the fast-work-conserving discounted policy result in its own notation. Chapter D establishes the unrestricted physical tail using a different argument. The finite-region ordered-occupancy and stable average-cost questions remain open at arbitrary capacity.

**Role transition.** The author of this note previously performed an independent expected-value/workflow review. After that review was frozen and the topic was reserved, the parent assigned this agent to mathematical Route B. This note is coauthored research; its author is no longer an independent final reviewer of the resulting manuscript. The expected reviews are unchanged.

## B1. Model and notation

There is one exponential rate-a fast server and m identical exponential rate-b slow servers, where a>b>0 and m>=1. Arrivals have rate lambda>=0, independently of service. A physical policy can act initially and at genuine arrival or service-completion epochs. In the policy class considered here it must start a job at the fast server whenever that server is idle and a job is waiting, before optional dispatches to slow servers. After this mandatory operation, x is the number at the fast server plus its queue and y is the number already assigned to slow servers. Thus the total population is n=x+y, and the fast server is busy exactly when x>0. The original nonpreemptive assignment set in this class is

$$
0\le r\le \min\{m-y,(x-1)^+\},\qquad (x,y)\longmapsto(x-r,y+r).
$$

The job already at the fast server is excluded. A state with x=0 has no dispatchable jobs, even when y>0. No lemma below allows physical reassignment of an in-service job. Wang et al., Lemma 1 and Appendix A, establish the fast-server rule in the paper's one-fast/two-slow model. That theorem is not cited as an arbitrary-m result: all-m equivalence with the unrestricted physical model remains a separate obligation. The results below are unconditional within the prescribed fast-work-conserving class.

Let $J^\pi_\alpha$ be expected discounted total-population cost under a specified physical policy, with the initial decision convention stated whenever a value is used. Put

$$
\Gamma=\lambda+a+mb,\quad D=\alpha+\Gamma,\quad
\rho=\Gamma/D,\quad q=1-\rho=\alpha/D,\quad p=\lambda/\Gamma.
$$

Introduce independent potential-event clocks with total rate $\Gamma$: an arrival clock of rate lambda, a potential fast completion of rate a, and m potential slow completions of rate b each. A completion mark at an idle server is a dummy event. For the moment **enlarge** the action times by allowing dispatches after every potential event, including dummy events. This enlargement must be removed before claiming a physical-policy result.

Let $V(x,y)$ be D times the optimal discounted value in this enlarged model **after a committed initial dispatch**: no dispatch is permitted at time zero, but one is permitted after the first potential event. Let $U^{\rm real}(x,y)$ be the optimal physical value **before** an initial decision, still restricted to the fast-work-conserving class. These are distinct notions. In particular, $V/D$ is not declared equal to the physical value after an arbitrary committed dispatch.

The original assignment operator, with no relaxation of its feasible jobs, is

$$
(Qf)(x,y)=\min_{0\le r\le\min(m-y,(x-1)^+)}f(x-r,y+r),
$$

Define $V_0=0$, $V_{k+1}=TV_k$, where

$$
(Tf)(x,y)=x+y+\frac1D(PQf)(x,y),
$$
$$
(Ph)(x,y)=\lambda h(x+1,y)+a h((x-1)^+,y)
+b\{yh(x,(y-1)^+)+(m-y)h(x,y)\}.
$$

Terms with coefficient zero do not evaluate an invalid negative occupancy. Integration over an exponential rate-$\Gamma$ holding time gives the stage cost n/D and event weights equal to their rates divided by D. Consequently the rescaled post-decision Bellman equation is $V=TV$. Section B4 proves existence, uniqueness, and stationary verification rather than assuming them.

We will use
$$
U(x,y):=\frac{(QV)(x,y)}D
$$
for the enlarged-model value before an immediate decision. The next lemma proves $U=U^{\rm real}$, including the dummy-event issue.

### B1.1. A consistent optimal selector removes the dummy-event enlargement

In total coordinates $V(n,y)$ abbreviates $V(n-y,y)$; the coordinate convention is stated explicitly wherever needed. Write the set of feasible final slow occupancies as
$$
\mathcal A(n,y)=
\{y,\ldots,y+\min[m-y,(n-y-1)^+]\}.
$$
Every such action leaves n unchanged. If $z\in\mathcal A(n,y)$, then
$\mathcal A(n,z)\subseteq\mathcal A(n,y)$, and z itself belongs to both sets.
Define the deterministic selector
$$
\sigma(n,y)=\max\arg\min_{z\in\mathcal A(n,y)}V(n,z).
$$
The finite action set makes this well-defined. If $z=\sigma(n,y)$, the minimum over the smaller set $\mathcal A(n,z)$ is still $V(n,z)$, and there is no larger minimizing occupancy in that set. Therefore
$$
\sigma(n,\sigma(n,y))=\sigma(n,y). \tag{B0}
$$
This argument also covers singleton sets, including x=0. The maximum tie rule is part of the construction; an arbitrary inconsistent choice among ties is not substituted for it.

The stationary verification in B4 shows that applying sigma after each potential event, and initially when a decision is available, attains the enlarged-model optimum. Immediately after any decision the state is fixed by sigma. A subsequent dummy event leaves that state unchanged, so (B0) implies that sigma dispatches no additional job. Between genuine events the policy therefore makes no physical changes. Deleting the dummy marks yields an admissible policy with decisions only at genuine events and exactly the same sample-path population cost.

Conversely, every physical policy in the prescribed class is admissible in the enlarged model by ignoring dummy events. Thus enlarged-model optimality supplies one inequality, while the physically implementable optimal selector supplies the reverse inequality:
$$
U^{\rm real}(x,y)=U(x,y)=\frac{(QV)(x,y)}D. \tag{B0a}
$$
For a committed initial post-decision state s, only the one-sided inequality
$$
J^{\rm real,post}_\alpha(s)\ \ge\ V(s)/D \tag{B0b}
$$
is automatic. Equality holds whenever $\sigma(s)=s$, because then the same optimal selector is physically implementable from s with no initial action. In particular equality holds at every state with y=m.

**A concrete distinction.** Take $m=1,\lambda=0,a=2,b=1,\alpha=1$, and a committed post-decision state $(x,y)=(2,0)$. The next genuine event is the fast completion, so the physical post-decision value is
$$
\frac2{1+2}+\frac2{1+2}\frac1{1+2}=\frac89.
$$
At a pre-decision state with this population, immediate slow dispatch gives
$U=1/3+1/2=5/6$. The enlarged-model committed post-decision value is instead
$$
\frac VD=\frac24+\frac24\frac13+\frac14\frac56=\frac78.
$$
The idle slow server's dummy clock permits a delayed dispatch in the enlarged model. This example explains why a global identity $V=DJ^{\rm real,post}_\alpha$ would be false; it is a scope check, not a claimed new research result.

## B2. Slow-job cost is an exact reusable-token charge

Let $A^\pi_{\rm s}$ count slow assignments, with multiplicity when several jobs are assigned simultaneously. Let $Y_t$ be busy slow occupancy. Start from occupancy y immediately before any time-zero assignment, and include such assignments in the count. Every assigned job remains on its slow server until completion, whose hazard is b.

For every deterministic T, the compensated counting-process identity gives

$$
(\alpha+b)\,\mathbb E\int_0^T e^{-\alpha t}Y_t\,dt
 =y+\mathbb E\int_{[0,T]}e^{-\alpha t}\,dA^\pi_{\rm s}(t)
   -\mathbb E[e^{-\alpha T}Y_T]. \tag{B1}
$$

At T, the occupancy and counting convention must both be after the same possible jump; for deterministic positive T, event-time ambiguity has probability zero. Equation (B1) follows by applying discounted integration by parts to $Y$, whose slow-completion compensator is $bY_tdt$. It does not assume that the policy is independent of past completion observations.

Because $0\le Y_t\le m$, the final term tends to zero as T tends to infinity. Hence, with $c=(\alpha+b)^{-1}$,

$$
J^\pi_\alpha(x,y)=cy+
\mathbb E\int_0^\infty e^{-\alpha t}X_t\,dt
+c\,\mathbb E\int_{[0,\infty)}e^{-\alpha t}\,dA^\pi_{\rm s}(t). \tag{B2}
$$

Thus an assignment to a slow server is equivalently an immediate removal from the fast queue at discounted charge c, consuming one reusable token that returns after an exponential rate-b time. The initial y occupied tokens contribute cy. The identity holds for physical policies and also for policies in the enlarged potential-event model, since dispatch does not alter a busy job's completion hazard. It does not equate their arbitrary committed post-decision optima.

This is an exact objective transformation. It does not make tokens independent of the chosen admission history, nor prove a monotone optimal admission policy.

## B3. Population potential removes the assignment charge

Dispatches preserve total population $N=X+Y$. Its compensator drift is

$$
\lambda-a\mathbf1_{\{X>0\}}-bY.
$$

Discounted integration by parts gives, for every admissible fast-work-conserving policy,

$$
(\alpha+b)\,\mathbb E\int_0^T e^{-\alpha t}N_t\,dt
=n-\mathbb E[e^{-\alpha T}N_T]
+\mathbb E\int_0^T e^{-\alpha t}
 \{\lambda+bX_t-a\mathbf1_{\{X_t>0\}}\}\,dt. \tag{B3}
$$

Since $N_T\le n+A_T$, where $A_T$ is the number of external arrivals,
$\mathbb E[e^{-\alpha T}N_T]\le e^{-\alpha T}(n+\lambda T)\to0$.
The infinite-horizon transformed running cost is therefore

$$
g(x)=\lambda+bx-a\mathbf1_{\{x>0\}}. \tag{B4}
$$

It is independent of y and discretely convex in x: its first increment is b-a, and every subsequent increment is b. It is not nondecreasing at the origin.

Define the **enlarged-model post-decision** potential
$$
Z=(\alpha+b)V/D-n.
$$
Its Bellman equation is

$$
Z=\frac{g+PQZ}{D}. \tag{B5}
$$

For the physical pre-decision optimum, the corresponding potential is
$(\alpha+b)U^{\rm real}-n=QZ$ by (B0a), because all actions preserve n. No equality between Z and the potential of an arbitrary physical committed post-decision value is asserted.

The finite-horizon terminal convention is essential. Zero terminal cost after a fixed number of potential-event stages corresponds to $Z_0=-n$, not to zero. Precisely, if $Z_k=(\alpha+b)V_k/D-n$, then

$$
Z_0=-n,\qquad Z_{k+1}=(g+PQZ_k)/D. \tag{B6}
$$

This follows directly from $Qn=n$ and
$$
Pn=\Gamma n+\lambda-a\mathbf1_{\{x>0\}}-by.
$$
It is invalid to substitute zero terminal cost in (B6) and describe the resulting finite iterates as the transformed nonnegative-cost zero-terminal orbit. A fixed number of potential events is also not the same horizon as a fixed number of genuine events.

### Why this has not completed a coupling proof

The token model still has occupancy-dependent return intensity by. A slow completion changes the occupancy layer. A comparison that follows only a tagged queued job can therefore lose the ordering needed to compare the future opportunities of other jobs. Likewise, a broad convexity condition on arbitrary trial value functions is not enough: the assignment obstructions in the companion note remain obstructions after subtracting affine potentials.

The transformation identifies a genuine reduced control problem, but no theorem asserting its required all-state policy structure is invoked here.

## B4. A universal discounted remainder bound

**Proposition B1.** For every k>=0 and every state of total population n,

$$
0\le V(n,y)-V_k(n,y)
\le E(n,k):=
\rho^k\left\{\frac{n+pk}{q}+\frac{p\rho}{q^2}\right\}. \tag{B7}
$$

The notation $V(n,y)$ in this and subsequent sections means $V(n-y,y)$, with $0\le y\le\min(m,n)$.

**Proof.** The uniformized transition has an external-arrival increment with probability p and departures can only lower population. Independently of the admissible controls,
$$
\mathbb E[N_j]\le n+pj.
$$
The nonnegative cost and zero terminal condition give $V_k\le V$.

For an upper bound, follow a finite-horizon optimal policy for k stages and then any admissible continuation. From a state of population N, even the no-departure upper bound on its remaining rescaled cost is
$$
\sum_{j=0}^{\infty}\rho^j(N+pj)
 =\frac Nq+\frac{p\rho}{q^2}.
$$
Taking the expected discounted continuation cost after k stages, and using
$\mathbb E[N_k]\le n+pk$, proves (B7). Finite-horizon minimizers exist because every action set is finite. All sums are finite or nonnegative, so Tonelli applies. QED.

This bound uses no finite-buffer truncation or unproved threshold hypothesis.

### B4.1. Weighted contraction, stationary verification, and continuous time

Choose $c_0>\lambda/\alpha$, with $c_0>0$, and put $w(x,y)=x+y+c_0$. The functions with finite norm
$$
\|f\|_w=\sup_{x\ge0,\ 0\le y\le m}|f(x,y)|/w(x,y)
$$
form a Banach space. Actions preserve w, so the elementary minimum inequality gives
$$
|Qf(s)-Qg(s)|\le w(s)\|f-g\|_w.
$$
The event operator has nonnegative coefficients and
$$
Pw=\Gamma w+\lambda-a\mathbf1_{\{x>0\}}-by
\le\Gamma w+\lambda.
$$
Consequently T maps this space into itself and
$$
\|Tf-Tg\|_w
\le\beta\|f-g\|_w,\qquad
\beta=\frac{\Gamma+\lambda/c_0}{D}
     =\rho(1+p/c_0)<1. \tag{B7a}
$$
The choice $c_0>\lambda/\alpha$ is exactly what makes the last inequality strict. Banach's theorem gives a unique fixed point V in this linear-growth space and convergence of $T^k0$ to V. Since T is order-preserving and $T0=n\ge0$, the iterates and their limit are nonnegative.

For a fixed stationary selector sigma, define
$(R_\sigma f)(s)=f(\sigma(s))$, where sigma includes the state update and preserves total population. Its policy operator
$$
T_\sigma f=n+PR_\sigma f/D
$$
has the same contraction bound. Choose sigma to minimize V as in B1.1. Then $R_\sigma V=QV$, so V is its unique fixed point.

Here is verification against arbitrary history-dependent policies, including ones that observe holding times. Let $S_0=s$ be a committed post-decision state, let $T_k$ be the kth potential-event time, and let $S_k$ be the state after its decision. Given a state before a potential event, every feasible subsequent action has continuation value at least QV at the corresponding marked successor. Integrating the exponential holding time and using $V=TV$ therefore yields the one-event Bellman inequality for $\widehat J=V/D$:
$$
\widehat J(s)\le
\mathbb E^\pi_s\!\left[
 \int_0^{T_1}e^{-\alpha t}N_t\,dt
+e^{-\alpha T_1}\widehat J(S_1)
\right].
$$
It remains valid conditionally on the entire past; no independence of an action from the observed holding time is needed, because the actionwise minimum is a pointwise lower bound. Iterating gives the same inequality through $T_k$.

Let $A_k$ be the number of arrival marks among the first k potential events. The marked Poisson construction gives $N(S_k)\le n+A_k$, $\mathbb E A_k=pk$, and independence of $A_k$ and $T_k$, regardless of control. Also $\mathbb E e^{-\alpha T_k}=\rho^k$. Thus the terminal term tends to zero:
$$
\mathbb E^\pi_s\!\left[
 e^{-\alpha T_k}|\widehat J(S_k)|
\right]
\le \frac{\|V\|_w}{D}\rho^k(n+pk+c_0)\longrightarrow0. \tag{B7b}
$$
Monotone convergence for the nonnegative running cost now proves that $\widehat J$ is a lower bound on every admissible enlarged-model committed post-decision cost. For the minimizing stationary selector all Bellman inequalities are equalities, so it attains that bound. An initial minimization proves the pre-decision value $QV/D$. This also verifies the finite-horizon interpretation of $V_k$, by the same induction with zero terminal value.

The strategy bridge of B1.1 can therefore be applied without a stationarity or fixed-point existence gap. Its conclusion concerns physical **pre-decision** values and sigma-fixed committed post-decision states, not all committed post-decision states.

## B5. Exact affine formula in the finite-horizon interior

Put
$$
A_0=0,\qquad A_k=\sum_{j=0}^{k-1}\rho^j.
$$
Define $B_1=0$, and for k>=2,
$$
B_k=\rho\left(B_{k-1}-\frac{bm}{D}A_{k-2}\right)
       +\frac{\lambda-a}{D}A_{k-1}. \tag{B8}
$$

**Proposition B2.** For k>=1 and n>=m+k-1,
$$
V_k(n,y)=A_kn+B_k-\frac bD A_{k-1}y,
\qquad 0\le y\le m. \tag{B9}
$$
For k=1 this is simply $V_1=n$ and holds more generally. For k>=2 the gap between two occupancies at the same n is exactly
$$
V_k(n,y)-V_k(n,m)=\frac bD A_{k-1}(m-y). \tag{B10}
$$

**Proof.** The first iterate is n. Since Q preserves every function of n,
$$
V_2(n,y)=(1+\rho)n+\frac{\lambda-a}{D}-\frac bD y
$$
whenever n>=m+1, so x>=1. This proves the first nontrivial case.

Suppose k>=3 and the formula holds for k-1. From a state n>=m+k-1, every event predecessor has population at least m+k-2>=m+1 and positive fast occupancy. Thus assigning enough waiting jobs to make all m slow servers busy is feasible in every predecessor state. By the induction formula, it minimizes $V_{k-1}$, with optimized value
$$
A_{k-1}n'+B_{k-1}-\frac{bm}{D}A_{k-2}.
$$
The expected unnormalized predecessor population is
$$
\Gamma n+\lambda-a-by.
$$
Substitution into the Bellman equation gives (B8)–(B9). No assertion about decisions outside this finite-horizon interior has been used. QED.

The separate k=2 argument handles the case where a predecessor has total population exactly m and hence cannot have both the fast server and all m slow servers busy.

## B6. A certified finite threshold beyond which all slow servers are used

**Theorem B3 (discounted full-occupancy tail in the prescribed fast-work-conserving class).** Fix the model parameters and alpha>0. Define
$$
L=\frac{m-1}{q}+\frac{p\rho}{q^2},
\qquad M=\frac{1+p}{q}.
$$
Choose any integer
$$
K\ge\max\{2,\lceil\rho/q\rceil\}
$$
such that
$$
\rho^K(L+MK)\le\frac b{2D}, \tag{B11}
$$
and put $H=m+K-1$. Such K exists. For every total population n>=H and every y<m,
$$
V(n,y)-V(n,m)\ge\frac b{2D}>0. \tag{B12}
$$
Consequently, at every genuine pre-decision state in this policy class with n>=H, every optimal stationary selector fills every idle slow server. More precisely, fixing a first dispatch that ends below full slow occupancy and then optimizing over physical continuations has cost at least $b/(2D^2)$ greater than dispatching to full occupancy and then following the optimal physically implementable selector. This is a comparison of physical action costs derived below, not an identification of arbitrary physical post-decision values with V/D.

**Proof.** For $E_k=\rho^k(L+Mk)$, since L>=0 and M>0,
$$
\frac{E_{k+1}}{E_k}
 =\rho\left(1+\frac M{L+Mk}\right)
 \le\rho(1+1/k)\le1
$$
when k>=rho/q. Thus (B11) holds for every k>=K.

For n>=H take k=n-m+1. Then k>=K and Proposition B2 applies exactly at n. The error bound is
$$
E(n,k)=\rho^k(L+Mk)\le b/(2D).
$$
Use the lower finite-horizon bound on the y state and the upper bound on the full-occupancy state:
$$
\begin{aligned}
V(n,y)-V(n,m)
&\ge V_k(n,y)-V_k(n,m)-E(n,k)\\
&=\frac bD A_{k-1}(m-y)-E(n,k)\\
&\ge\frac bD-\frac b{2D}.
\end{aligned}
$$
Full slow occupancy is feasible from every state at this population because n>=H>=m+1. The preceding inequalities prove the strictly positive **enlarged-model post-decision** gap (B12).

To obtain the physical claim, let the first dispatch end in occupancy z<m. Its best possible physical continuation has cost at least $V(n,z)/D$ by (B0b). At the full-occupancy state the feasible dispatch set is a singleton, so sigma fixes that state; (B0a) and the post-decision equality for sigma-fixed states show that the physical continuation cost after full dispatch is exactly $V(n,m)/D$. Therefore
$$
\begin{aligned}
J^{\rm real,post}_\alpha(n,z)
  -J^{\rm real,post}_\alpha(n,m)
&\ge \{V(n,z)-V(n,m)\}/D\\
&\ge b/(2D^2).
\end{aligned}
$$
Dispatch itself consumes no time and has no cost, so this is also the gap between the corresponding first-action costs at a genuine pre-decision state. A subfull first dispatch cannot be optimal. QED.

Only one truncation error is required in this comparison because zero-terminal nonnegative-cost iterates are lower bounds.

### A closed-form conservative choice

Let $C=L+2M/q$. Because $\rho^k\le e^{-qk}$ and
$k e^{-qk/2}\le2/q$,
$$
\rho^k(L+Mk)\le C e^{-qk/2}.
$$
Hence one may replace the search (B11) by
$$
K_{\rm explicit}=
\max\left\{2,\left\lceil\frac2q\log\frac{2DC}{b}\right\rceil\right\},
\qquad H_{\rm explicit}=m+K_{\rm explicit}-1. \tag{B13}
$$
This version does not need the ratio-monotonicity restriction: its exponential bound holds for every k>=K_explicit. For rational parameters, the scan (B11) is usually smaller and can be certified entirely with rational arithmetic.

**Scope limitation.** The theorem proves an eventual all-busy region within the stated fast-work-conserving class. It does not show that the optimal preferred occupancy is nondecreasing below H, and it does not prove that restricting to this class is harmless in the unrestricted arbitrary-m physical model. It therefore does not solve the main ordered-threshold conjecture. H generally diverges as alpha decreases to zero, so the theorem alone does not supply the average-cost passage.

### B6.1. Four exact rational witnesses

The standard-library [tail-bound program](evidence/code/tail_bound_certificate.py) searches with exact fractions and independently checks each reported witness. The [rational output](evidence/results/tail_bound_certificate.json) includes the complete rational values of $\rho,q,p,L,M,E_K$, the nonnegative margin in (B11), and $qK-\rho$. Decimal previews are not used in any decision.

| m | lambda | a | b | alpha | K | H=m+K-1 | Required upper bound for $E_K$ |
|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | 0 | 2 | 1 | 1 | 23 | 23 | 1/8 |
| 3 | 1 | 4 | 1 | 1 | 82 | 84 | 1/18 |
| 8 | 10 | 10 | 1 | 2 | 179 | 186 | 1/60 |
| 2 | 9 | 10 | 1 | 21/100 | 1621 | 1622 | 50/2121 |

Each K is the first passing integer at or above $\max(2,\lceil\rho/q\rceil)$; this computational minimality refers only to the sufficient bound (B11), not to the actual optimal-policy transition. The certificates contain no finite-buffer approximation.

## B7. Exact finite Bellman reduction after the tail is certified

Let $d=a+mb$. In total coordinates, the full-occupancy state has physical coordinates $(x,y)=(n-m,m)$. Set
$$
j(n)=V(n,m)/D=U^{\rm real}(n,m).
$$
The equality is valid because full-occupancy states are fixed by sigma. These are physical values within the specified policy class. All servers are busy. For n>=H+1 every successor decision population is still at least H, so
$$
Dj(n)=n+\lambda j(n+1)+d j(n-1). \tag{B14}
$$
The affine particular solution is
$$
j_{\rm p}(n)=\frac n\alpha+\frac{\lambda-d}{\alpha^2}.
$$

If lambda>0, let r be the root in (0,1) of
$$
\lambda r^2-Dr+d=0.
$$
The other root exceeds 1, and its component is excluded by the linear-growth value bound. Thus
$$
j(n)=j_{\rm p}(n)+\{j(H)-j_{\rm p}(H)\}r^{\,n-H},
\qquad n\ge H. \tag{B15}
$$
When lambda=0, the same formula holds with $r=d/D$.

**Boundary warning.** Equation (B14) is asserted only for n>=H+1. At n=H, a fast completion goes to $(H-1,m)$ in total coordinates, while a slow completion goes to $(H-1,m-1)$. These finite-region optimized values need not agree. The boundary equation is
$$
Dj(H)=H+\lambda j(H+1)
+a\,U(H-1,m)+mb\,U(H-1,m-1), \tag{B16}
$$
where $U(n,y)$ uses total coordinates and is the physical pre-decision value $QV/D=U^{\rm real}$ in the specified class. Use (B15) to eliminate j(H+1), but do not collapse the two finite states in (B16).

Here is an explicit finite-system uniqueness argument. Retain all states n<=H and all their original feasible assignments, and put
$$
c_{\rm tail}=j_{\rm p}(H+1)-rj_{\rm p}(H).
$$
When the finite Bellman operator at a state of total H needs an arrival successor of total H+1, replace its optimized **rescaled** value by
$$
r f(H,m)+D c_{\rm tail}.
$$
Every other successor remains in the finite region and is evaluated using Qf. The constant term does not affect Lipschitz bounds, and the boundary coefficient r is in (0,1), so this finite Bellman map is a contraction in the ordinary supremum norm with factor at most $\Gamma/D<1$. It therefore has exactly one fixed point. The restriction of the true V solves this finite system by B3 and (B15), so the unique finite solution is that restriction. This proves the exact reduction without assuming that an arbitrary numerical solution automatically has a valid infinite tail.

Consequently, the fixed-parameter discounted problem within the stated class reduces exactly to the finitely many states n<=H and the scalar algebraic boundary relation (B15). Actions below H remain the original feasible assignments; none is removed by a threshold guess. For rational rates and discount, the only non-rational coefficient needed for this tail relation is the specified quadratic root.

This gives a route to a rigorous fixed-parameter counterexample search: solve or enclose the finite Bellman system, include every legal action, and use strict action gaps together with the independently proved tail. A finite numerical truncation without this or another valid tail argument is insufficient.

## B8. Remaining obligations and relation to literature

The parent problem remains unresolved in this note. The exact cost transform does not prove its structural monotonicity. The quantitative tail theorem and algebraic boundary reduction can support certified experiments, but their academic novelty requires comparison with earlier slow-server and controlled birth–death results; no independent originality grade is claimed here.

Next mathematical obligations are:

1. prove that restricting to fast-work-conserving policies is without loss in the unrestricted arbitrary-m physical problem, if that broader scope is claimed;
2. prove the occupancy-aware comparison that controls all states below H uniformly in parameters and m, or identify a genuine certified violation;
3. preserve the original nonpreemptive assignment set and all tie cases;
4. obtain an average-cost argument with a suitable uniform bound or a separate regeneration method;
5. formalize the stated scope and run the independent post-compilation audit.

Primary sources actually read:

- Wang et al., arXiv:2607.22580, author manuscript: https://www.cs.cmu.edu/~weinaw/pdf/One_fast_two_slow_conjecture.pdf . Source for the m=2 reduced model, its Lemma 1/Appendix A fast-server argument, event/assignment operators, m=2 structure, and known proof-cone approach. The fast-server result is not treated here as a citation for unrestricted arbitrary m.
- Kim, Ahn and Righter, JAP 48 (2011), doi:10.1239/jap/1308662637: https://www.cambridge.org/core/services/aop-cambridge-core/content/view/676D07927BD5DB3EC17EB5E8C82DA802/S002190020000797Xa.pdf/managing_queues_with_heterogeneous_servers.pdf . Source for the already known all-other-servers-idle threshold and the failure of naive extensions of tagged-job coupling.



---

# An exact infinite-state double-jump certificate

## Statement and limitation

Consider the original nonpreemptive queue with one fast exponential server of rate 10, two slow exponential servers of rate 1, Poisson arrival rate 9, and continuous-time discount rate

$$
\alpha=531/2350.
$$

The normalized discounted decision value W has a unique preferred slow occupancy h(4)=0 and h(5)=2. In fact an optimal deterministic stationary policy fills the fast server whenever a job is available and, after that, uses

$$
h(n)=\begin{cases}0,&n\le4,\\2,&n\ge5,\end{cases}
\qquad k^*(n,y)=\max\{y,h(n)\}.
$$

Here n is total population and y is the pre-assignment number of busy slow servers. At states with no queued or fast job, existing slow jobs remain in place. Every policy decision in the statement is certified in the original infinite-buffer model below.

This gives a counterexample to a **single queued-job threshold independent of slow occupancy**, and to the stronger condition h(n+1)-h(n)<=1. It does **not** contradict nondecreasing h, does not refute the main arbitrary-m threshold conjecture, and does not extend the known two-slow-server threshold theorem. The certificate supplies an exact instance, not a novelty claim about all stronger conjectures.

## Exact finite certificate

Put gamma=21 and D=gamma+alpha=49881/2350. All cost functions in the JSON are scaled by D. Construction uses an auxiliary uniformized postdecision function U, with one-stage cost n. Verification then uses the physical decision value W and the real-event first-wait value H, defined below. The finite reduced state order, every matrix coefficient, right-hand side, rational solution value, feasible assignment value, and action gap are contained in [rational_policy_certificate.json](evidence/results/rational_policy_certificate.json).

The interface is total population L=8. The policy evaluation system has 24 states. It is solved by Gauss-Jordan elimination over the rational numbers. Its residual is exactly zero in every equation. All feasible original nonpreemptive actions are then checked, including withholding the fast server, assigning one or both slow servers, and every slow-occupancy state in the first analytic layer.

For readability, the following exact lower bounds summarize the decisive action gaps, in the order of final slow occupancies k=0,1,2. The complete rational gaps and values are in the JSON:

| Total n | Unique preferred k | Certified gaps above the minimum |
|---:|---:|---|
| 4 | 0 | 0 ; > 1/20 ; > 2 |
| 5 | 2 | > 1 ; > 1/40 ; 0 |

No gap is inferred from a decimal approximation. In particular, both relevant minimizers are unique.

## Rational infinite continuation

The selected subunit birth-death root is r=47/50. It satisfies exactly

$$
9r^2-(21+\alpha)r+12=0.
$$

For the all-busy slice define

$$
F(n)=A n+B+C r^{n-L},\qquad n\ge L,
$$

where

$$
A=\frac D\alpha=16627/177,\quad
B=\frac{D(9-12)}{\alpha^2}=-39073450/31329,\quad
C=\frac{26277721535996636127319050344422776796162147282986725794225139}{27538718430654674799269366143378659031526838717844256250000}.
$$

The finite system includes the exact interface relation

$$
F(L+1)=rF(L)+\frac{D(1-r)}\alpha
\left(L+1+\frac{9(1-r)}\alpha\right).
$$

The characteristic-root identity and the linear particular solution imply the Bellman recurrence for every later integer n. The first continuation layer is checked separately using the finite optimal-assignment values at population L, for every occupied-slow-server count. Thus the proof does not assume that an all-busy formula already applies to every boundary alternative.

Moreover,

$$
F(n)-F(n-1)=A-C(1-r)r^{n-L-1}
\ge \frac{5612582191908694357040911368744101511046915982934005672758287}{152992880170303748884829811907659216841815770654690312500000}>0
\quad(n\ge L+1).
$$

The lower bound is the smaller of A and the exactly checked first increment. This is valid whether C is nonnegative or negative.

For every sufficiently large full original state, with z in {0,1} recording fast occupancy and y in {0,1,2} recording slow occupancy, direct substitution gives the physical first-wait value

$$
H(n,z,y)=F(n)+\frac{(2-y)+10(1-z)}{\alpha+9+10z+y}
\bigl(F(n)-F(n-1)\bigr).
$$

Every alternative to full dispatch therefore has a nonnegative exact gap. This covers infinitely many states through an algebraic formula, rather than through a finite-buffer approximation.

## Full action verification and optimality

At a decision state (n,z,y), feasible final occupancies satisfy z' in {z,1}, y' in {y,...,2}, and z'+y'<=n. These constraints enforce both nonpreemption and job availability. The certificate lists H(n,z',y')-W(n,y) for every such action through n=L+1. All gaps are nonnegative and each state has an exact zero action. Thus W is the minimum physical first-wait value over the original action set. The tail formula gives the same conclusion for every later population.

The actual event rate following a dispatch is R=9+10z+y. The next decision is offered only at an actual arrival or departure. The exact real-event identity used in verification is

$$
H(n,z,y)=\frac{D n+9W(n+1,y)+10zW(n-1,y)+yW(n-1,y-1)}{\alpha+9+10z+y},
$$

with zero-coefficient terms omitted. Every residual of this identity is exactly zero. U is only an auxiliary construction variable; arbitrary U values are not asserted to be lower bounds on instantaneous decision costs.

Both H and W grow at most linearly in population. After k actual events, population is at most n+k. Since every actual event rate is at most gamma=21, the conditional expected discount factor until the next event is at most rho=21/D<1. The expected discounted terminal candidate value is therefore bounded by a constant times rho^k(n+k+1), which tends to zero. Iterating W<=H for each selected original action and then the real-event identity proves that W is a lower bound on every admissible original **decision** cost. The certified greedy selector attains equality. This directly verifies discounted infinite-horizon optimality for the original event model, without needing decisions at dummy events.

## Why a common queued-job threshold cannot work

Compare two decision states, each with exactly three waiting jobs and a busy fast server:

- With zero busy slow servers, n=4 and the unique optimal action activates no slow server.
- With one busy slow server, n=5 and the unique optimal action activates the remaining slow server.

The identical queue length requires different activation decisions depending on slow occupancy. A single queue-length cutoff independent of that occupancy cannot implement the optimal choices. Also h(5)-h(4)=2, which rules out unit increments. The preferred occupancy remains nondecreasing, exactly as allowed by the main research target.

## Reproduction and claim boundary

From the repository root run `python3 evidence/code/rational_policy_certificate.py`. It uses the Python standard library only. No floating-point values, approximate roots, tolerances, numerical linear algebra, or truncated-queue boundary conditions enter the certificate.

The known two-slow-server ordered-threshold setting is described in Wang et al., [arXiv:2607.22580, primary manuscript](https://www.cs.cmu.edu/~weinaw/pdf/One_fast_two_slow_conjecture.pdf). This exact instance is consistent with that theorem: the two initially-idle queue thresholds coincide, allowing a jump of two. Chapter D adds a parameter-neighborhood statement for this specific exact witness.


---

# D. An exact finite reduction for the unrestricted discounted queue

## D1. Model and full-occupancy threshold

Consider $s\ge1$ independent exponential servers with arbitrary rates $\mu_i>0$, and independent Poisson arrivals of rate $\lambda\ge0$. Service is nonpreemptive. The controller may dispatch at the initial decision and after each actual arrival or completion. The holding rate is total population and the discount is $\alpha>0$. The initial state consists of the population $n$ and the set of occupied servers. Let
$$
\mu=\sum_i\mu_i,\quad u=\min_i\mu_i,\quad
B(n)=\frac n\alpha+\frac{\lambda-\mu}{\alpha^2},\quad
r=\frac{2\mu}{\alpha+\lambda+\mu+
\sqrt{(\alpha+\lambda+\mu)^2-4\lambda\mu}}.
$$

**Theorem D1.** Take any integer $H\ge s$ with
$$
\frac{\mu}{\alpha^2}r^{H-s+1}
  <\frac{u}{\alpha(\alpha+\lambda+\mu)}.
$$
For every decision state with $n\ge H$, every optimal dispatch makes all servers busy. The value is independent of the entering busy set; writing it as $V(n)$ gives
$$
V(n)=B(n)+r^{n-H}(V(H)-B(H)),\qquad n\ge H.
$$
Thus all original nonpreemptive actions below $H$ form a finite discounted Bellman system with an exact tail boundary.

## D2. Comparing any idle first action with a full-busy policy

Write $b_t$ for the sum of rates of busy servers. The arrival count has compensator $\lambda t$ and the completion count has compensator $\int_0^t b_z\,dz$. The population is nonnegative and is bounded by $n$ plus the arrival count. Integrating the two count identities against the discount, with Tonelli applied separately to both nonnegative counts, gives the cost of every policy as
$$
E\!\int_0^\infty e^{-\alpha t}N_t\,dt
=B(n)+\frac1\alpha E\!\int_0^\infty e^{-\alpha t}(\mu-b_t)\,dt .
$$
After an idle first dispatch, the current total rate $b$ stays fixed until the next real event. Since $\mu-b\ge u$ and its event rate is $\lambda+b\le\lambda+\mu$, the excess over $B(n)$ is at least $u/[\alpha(\alpha+\lambda+\mu)]$, even if later decisions are arbitrary. If the event rate is zero the waiting time is infinite and the same lower bound holds.

Start instead with the policy that fills every available server whenever it has enough jobs. Before the first hit of population $s-1$, the population is a birth–death chain at rates $\lambda$ and $\mu$. The discounted transform for dropping by one is the unique root $r\in(0,1)$ of $(\alpha+\lambda+\mu)r=\mu+\lambda r^2$. This follows by conditioning on the first event, using the strong Markov property to split an upward step followed by two one-level drops, and taking the transform as zero for an infinite hitting time. The rationalized formula above includes $\lambda=0$. An initial $n\ge s$ therefore has discounted first-hit transform $r^{n-s+1}$. The maximum discounted excess from that hit onward is $\mu/\alpha^2$ times the transform. For $n\ge H$ the full-busy policy strictly improves on every idle first action, including any positive weight on such an action in a randomized optimal dispatch.

## D3. Exact Bellman reduction on the real-event clock

To verify the physical Bellman equation, truncate at the $j$th real event. Population after $j$ events is at most $n+j$ and each conditional expected next-event discount is at most $\zeta=(\lambda+\mu)/(\alpha+\lambda+\mu)<1$. If no next event is possible, use the exact residual holding integral. The tail of the real-event series is bounded uniformly in policies by $\sum_{j\ge k}\zeta^j(n+j)/\alpha$, which tends to zero. This supplies both the Bellman minimum and the verification of a stationary minimizing selector.

Under optimal control, until hitting $H$ from any $n>H$ the process is full busy, and there is no accumulated excess over $B$ in the integral above. At $H$ the optimal dispatch also fills all servers, independently of the entering occupied set. Discounted first passage to $H$ now gives exactly the factor $r^{n-H}$. Retain all valid occupied sets below $H$ and one state at $H$. Its upward step is valued as $B(H+1)+r(V(H)-B(H))$. The resulting finite minimum operator has all continuation weights nonnegative and row sums no more than $\zeta$. Hence it has a unique fixed point, which the original values already satisfy. This folds the infinite tail into the exact finite boundary.

## D4. Local parameter stability and relation to prior work

The two strict action comparisons in Chapter C remain strict on an open four-dimensional neighborhood of $(\lambda,a,b,\alpha)=(9,10,1,531/2350)$. In a small compact parameter box, the discount stays bounded below by $\alpha_0>0$ and the total event rate above is bounded by a common $K$. With $\bar\zeta=K/(K+\alpha_0)$, the same finite-real-event argument gives the uniform tail bound $\sum_{j\ge k}\bar\zeta^j(n+j)/\alpha_0$. Each fixed finite-depth action value is continuous in parameters, since transition rates and the integrated holding cost are continuous and the finite action sets do not depend on these parameters. The infinite action values are uniform limits of these functions. Strictness at all the stated Chapter C actions therefore persists. The conclusion concerns those strict occupancy decisions, even when the exact tail root is irrational.

Koole's two-server theorem and Wang et al.'s one-fast/two-equal-slow theorem obtain stronger ordered occupancy conclusions in their settings. Kim, Ahn and Righter give discounted threshold results with an unlimited supply of secondary jobs in §2.2.2; the single-class result of §3.2 restricts the other server speeds. Kim, Ahn and Righter also prove high-population server use in their individually optimal LCFP setting in §3.1, Theorem 3(iii). Luh and Viniotis claim a general ordered threshold. De Véricourt and Zhou identify specific exchange and induction gaps in Rykov's argument and separately describe the Luh–Viniotis arguments as difficult to verify. Here Theorem D1 applies directly to physical real-event dispatch in arbitrary finite rate arrays, without requiring Chapter B's fast-server restriction. It gives the exact discounted tail and a finite boundary solver. The original low-population ordered-occupancy and stable average-cost targets remain open in their general form.

- [Koole, two servers](https://www.math.vu.nl/~koole/publications/1995scl2/art.pdf)
- [Wang et al., one fast and two identical slow servers](https://www.cs.cmu.edu/~weinaw/pdf/One_fast_two_slow_conjecture.pdf)
- [Kim–Ahn–Righter, §2.2.2 and §3.2](https://doi.org/10.1239/jap/1308662637)
- [Chen et al., published abstract](https://pubsonline.informs.org/doi/abs/10.1287/mnsc.2023.01228) describes exact structural results with two heterogeneous servers or multiple homogeneous servers and a threshold heuristic for the general multiclass configuration. That evidence distinguishes the present exact single-queue finite reduction from their general heuristic analysis.
- [Luh–Viniotis](https://doi.org/10.1007/s001860100168) · [de Véricourt–Zhou](https://doi.org/10.1007/s11134-006-5067-8)

Full Lean formalization of the integrated mathematical results will be delivered separately.
