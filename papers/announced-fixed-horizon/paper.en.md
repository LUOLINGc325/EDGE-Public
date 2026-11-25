---
title: "Exact CVaR One-Max Search at a Fixed Announced Horizon"
lang: en
---

# Abstract

An online seller can sell once at a revealed price or take the bottom price if no sale is made. When the number of offers is announced, the optimal ratio depends on that number. We give an exact criterion and a matching online rule for every horizon and risk parameter. For $N$ offers, the criterion evaluates in closed form on $0\le\delta\le1/N$ and $1/3\le\delta\le1/2$, where the objective averages the lowest $1-\delta$ fraction of revenues. Two offers admit a separate explicit formula. An additional change of the worst price sequence with the allowed price range determines the middle-risk value for four offers. Together the formulas determine the value for every risk level at horizons two, three, and four. They give the exact finite-horizon correction to the allowable price ceiling at a target ratio on the second interval. The fixed-horizon value stays bounded for risks below $1/N$ as the price range widens, with an exact growth exponent at and above the cutoff. The criterion covers arbitrary randomized strategies using the complete history and reduces them to a rule that sells just enough probability mass at successive records. At low risk, this rule strictly outperforms every policy based on one random reservation price.

## Model and results

Normalize prices to $[1,\theta]$, with $\theta\ge1$. An oblivious adversary selects exactly $N\ge1$ deterministic offers. The policy knows $N$ and observes each offer before deciding whether to accept it irrevocably. Its reward $Y$ is the accepted price or $1$ if none is accepted. For $q=1-\delta>0$, write $\mathcal C_q(Y)=q^{-1}\int_0^q Q_Y(s)\,ds$, where $Q_Y$ is the generalized quantile, and set $\mathcal C_0(Y)=\operatorname{ess\,inf}Y$. The ratio of a policy is the supremum of $\max_i x_i/\mathcal C_q(Y)$ over inputs of length $N$. Write $V_N(\theta,\delta)$ for the infimum of this ratio over all policies. Risk is taken over the policy's randomness on each fixed input.

The value is $1$ for $N=1$ or $\theta=1$. For $N\ge2$, set $z=\sqrt\theta$. The value at $1/2\le\delta\le1$ is $z$. At $N=2$ the all-risk value is

$$
V_2(\theta,\delta)=\left[1-(1-z^{-1})\min\{1,(2q)^{-1}\}\right]^{-1},
\tag{1}
$$

where the minimum is 1 for $q=0$.

For $N\ge2,\ \theta>1$ and $0\le\delta\le1/N$, write $c=\alpha/q$. The value is the unique $\alpha>1$ on $1+c\delta-c/N>0$ satisfying

$$
\theta=1+(\alpha-1)\frac{(1+c\delta)^{N-1}}{(1+c\delta-c/N)^N}.
\tag{2}
$$

For $N\ge3$ and $1/3\le\delta\le1/2$, the value is the unique $\alpha>1$ satisfying

$$
\theta=\alpha^2+(\alpha-1)c^2\frac{(N-1)(1-2\delta)^2}{2(N-2)}.
\tag{3}
$$

The formulas agree where they meet. For $N=3,\ \delta=1/3$, both give $\theta=\alpha^2+(\alpha-1)\alpha^2/4$. For $N=2,\ \delta=1/2$ and for all $N\ge3,\ \delta=1/2$, they give $\theta=\alpha^2$. For $1/3\le\delta<1/2$, the allowable price ceiling at ratio $\alpha$ has the additional term $(\alpha-1)c^2(1-2\delta)^2/[2(N-2)]$ relative to the uniform-over-horizons polynomial. A shorter announced horizon therefore allows a strictly better ratio throughout this interval for every $\theta>1$. Section 5 evaluates the remaining four-offer interval $1/4<\delta<1/3$. Theorem 1 also gives an exact finite optimization over cumulative sale-mass grids in the middle region $1/N<\delta<1/3$ for $N\ge5$.

## 1. Greedy allocation of sale probability

Fix $\alpha>1$ and $q>0$. For a strictly increasing prefix $x_1<\cdots<x_i$, let $F_j$ denote its unconditional sale probability through offer $j$, with $F_0=0$. Fix the prefix and append $N-i$ bottom prices. At mass coordinates $s\in(F_{j-1},F_j]$, price $x_j$ enters the increasing sale-price list $x(s)$. The bottom payoff includes any unsold probability and any sale at 1. The lowest $q$ mass, including fractions of atoms, gives the necessary inequality

$$
x_i\le\alpha\left[1+q^{-1}\int_0^{(F_i-\delta)_+}(x(s)-1)\,ds\right].
\tag{4}
$$

At each strict record the greedy rule chooses the smallest $F_i\in[F_{i-1},1]$ satisfying (4), or fails if this set is empty. A surviving realization accepts with conditional probability $(F_i-F_{i-1})/(1-F_{i-1})$ when $F_{i-1}<1$. The mass history is deterministic given the offers, and these conditional probabilities implement the unconditional masses. Prices at most $\alpha$ use no mass. The new price is constant on its candidate added interval, so one can invert the integral by scanning the sale masses. The upper integration limit is nondecreasing along a path. Maintain a pointer to its current position in the ordered sale list. Each step adds at most one block, and each completed block is passed at most once. This evaluates the policy in a total of $O(N)$ arithmetic operations and $O(N)$ storage when the target $\alpha$ is given. The rule skips nonrecords. In the absence of a failure the law on each input is the same as the law for a padded experiment at its last record, so the ratio is at most $\alpha$.

To prove necessity, fix an increasing prefix and compare any $\alpha$-competitive policy with the greedy rule. Suppose inductively that the competitor's cumulative masses $F_j^{\mathrm{p}}$ are at least the greedy masses $F_j^{\mathrm{g}}$ for $j<i$. As a candidate at row $i$, fill the greedy rule up to $F_i^{\mathrm{p}}$ with the current price. This is possible because $F_i^{\mathrm{p}}\ge F_{i-1}^{\mathrm{g}}$. At their common total mass the competitor's price list is pointwise at most the greedy candidate's list, since each earlier-price cumulative mass is larger. The competitor's necessary inequality (4) then makes the candidate feasible, so the greedy minimum satisfies $F_i^{\mathrm{g}}\le F_i^{\mathrm{p}}$. This includes cases in which the competitor sells at prices no larger than $\alpha$. The padded inputs have the same length and coincide on their common prefix. The adversary never uses the realized seed. Thus a failure on a strict record prefix excludes every allowed policy.

## 2. Exact finite criterion and attainment

For $k\le N$ take a mass grid $t=(t_0,\ldots,t_k)$ with $0=t_0,\ \delta<t_1\le\cdots\le t_k=1$. Put $A=\alpha-1$, $c=\alpha/q$, and define a step function $y(s)=y_j$ on $(t_{j-1},t_j]$ by

$$
y_i=A+c\int_0^{(t_i-\delta)_+}y(s)\,ds,\qquad 1\le i\le k.
\tag{5}
$$

The coefficient of $y_i$ on the right is $c(t_i-\delta-t_{i-1})_+$. If any such coefficient is at least 1, set $B(t)=+\infty$. Otherwise solve the rows in order and set $B(t)=1+y_k$. Every finite solution is positive and nondecreasing, by the nonnegative integrand in (5). It is strictly increasing where the knots above $\delta$ are strictly increasing. A one-row grid has infinite threshold because its self-coefficient equals $\alpha$.

**Theorem 1.** Assume $0\le\delta<1$ and $q=1-\delta$. A ratio $\alpha>1$ is achievable on all length-$N$ inputs if and only if $\theta\le B_N(\alpha,\delta):=\inf_{t}B(t)$, over the grids just defined. The greedy rule attains any achievable target ratio. For real-algebraic parameters the criterion is decidable by finite real-algebraic quantifier elimination.

**Proof.** Follow a first failed record of the greedy rule and omit earlier offers at most $\alpha$. On each preceding active record (4) is tight, and each added mass is positive. At failure try the entire remaining mass, setting $t_k=1$, possibly duplicating the previous knot if all mass was already spent. The strict failed inequality forces its self-coefficient below one. The preceding rows also have coefficients below one because they satisfy (5) with positive constant $A$. Consequently the failed price is strictly above $B(t)$ and $\theta>B_N$.

Conversely, if $\theta>B_N$, take a finite grid with $B(t)<\theta$. Separate any repeated knots by arbitrarily small shifts preserving $t_k=1$ and $t_1>\delta$. Finiteness and the strict gap persist by continuity of the triangular solution. Present the prices $1+y_i$ for $i<k$, followed by an offer strictly between $1+y_k$ and $\theta$, then pad with 1 up to length $N$. These are valid, strictly increasing active prices. At any active price above $\alpha$ the right side of (4) is strictly increasing in a candidate $F_i>\delta$, since the entire active price list exceeds 1. Thus the first $k-1$ prices force the saturated masses, and the last active price forces failure. Section 1 then excludes any $\alpha$-competitive policy. Finally, for each $k\le N$, finitely many orders of $t_i-\delta$ and the original knots make each coefficient in (5) affine in the knots. Existence of a finite threshold strictly below $\theta$ is a finite disjunction of polynomial constraint systems after clearing positive denominators. $\square$

If $\theta>1$ and $N\ge2$, the optimum is attained. The two-offer lower bound below, padded to length $N$, gives a strict gap above 1. The deterministic threshold $\sqrt\theta$ is feasible. Infeasibility at any $\alpha>1$ has a fixed grid witness with strict margins in its self-coefficients and in its terminal gap. It persists for nearby $\alpha$, so the infimum of feasible ratios above 1 is feasible.

## 3. Low risk

For a finite grid write $h_i=t_i-t_{i-1}$ and $Z_i=A+c\sum_{j\le i}h_j y_j$. The part of the integral up to $t_i$ omitted by the delay has length at most $\delta$ and height at most $y_i$. Hence

$$
(1+c\delta)y_i\ge Z_i=Z_{i-1}+ch_i y_i.
\tag{6}
$$

Set $L_0=1+c\delta$. Positivity forces $D_i=L_0-ch_i>0$, so $y_i\ge Z_{i-1}/D_i$ and $Z_i\ge Z_{i-1}L_0/D_i$. Iteration gives $y_k\ge A L_0^{k-1}/\prod_i D_i$. Adding $N-k$ zero widths multiplies numerator and denominator by the same factor. The $N$ factors in the denominator have arithmetic mean $L_0-c/N$, so AM–GM yields the right side of (2) as a lower bound on $B_N$. If that mean is nonpositive no grid is finite.

If $\delta<1/N$, the uniform grid $t_i=i/N$ is admissible. Every omitted length is exactly $\delta$ and is entirely at its current price, making all inequalities equalities. The price increments are $y_i=A L_0^{i-1}/(L_0-c/N)^i$. At $\delta=1/N$ approximate the same grid by moving the first knot from $\delta$ slightly upward. Finite coefficients and the terminal solution are continuous there. On its positive-denominator domain expression (2) increases strictly from 1 to infinity, either at the pole or, if $\delta=1/N$, as $\alpha$ diverges. This proves (2).

The AM–GM equality condition gives the unique minimizing widths, in the closure at $\delta=1/N$. For any finite grid, with zero-width padding to $N$ slots, let $\theta_* = B_N(\alpha,\delta)$. Strong convexity of $-\log(L_0-ch)$ on the admissible nonnegative widths gives

$$
\log\frac{B(t)-1}{\theta_*-1}\ge\frac{c^2}{2L_0^2}\sum_{i=1}^N(h_i-1/N)^2.
\tag{7}
$$

Indeed its second derivative is $c^2/(L_0-ch)^2\ge c^2/L_0^2$, and the first-order terms around $1/N$ sum to zero.

At $\delta=0$, (2) becomes $\alpha=N[1-((\alpha-1)/(\theta-1))^{1/N}]$. This is the known-duration risk-neutral formula of El-Yaniv et al., Eq. (26). Its optimality for randomized one-time search follows from their Theorem 1 and Corollary 2, which identify expected search reward with the proceeds of deterministic partwise trading, and from their Theorem 5 for known-duration trading. They already use bottom-price padding, minimal sale increments, and equal sale fractions for the hardest sequence. Inequality (6) handles the positive-risk tail. [El-Yaniv, Fiat, Karp and Turpin, §§2 and 4.1](https://www.math.tau.ac.il/~fiat/trading.pdf)

## 4. Near the deterministic transition

Suppose $N\ge3$ and $1/3\le\delta\le1/2$. Put $\ell=1-2\delta$ and let $T(s)$ denote the right grid endpoint of the interval containing $s$. Two substitutions in (5), with a nonnegative remainder, give

$$
y_k\ge A(1+cq+c^2 I_2),\qquad I_2=\int_0^q (T(s)-\delta)_+\,ds.
\tag{8}
$$

Clip intermediate knots to $[\delta,q]$, keeping the last knot 1, and pad with duplicates to use $N$ slots. Clipping can only lower the integrand for $s\in[0,q]$. Let $a_1,\ldots,a_N$ denote the induced interval lengths on $[\delta,q]$, with zeros allowed. They sum to $\ell$. The grid upper sum for $s-\delta$ on that interval is $(\ell^2+\sum_i a_i^2)/2$. The final interval uses $1$ instead of $q$, adding $\delta a_N$. On $[0,\delta]$ there is a contribution $\delta a_1$. Thus the clipped integral, denoted $I_2^{\mathrm{clip}}$, satisfies

$$
\begin{aligned}
I_2&\ge I_2^{\mathrm{clip}}=\tfrac12(\ell^2+\textstyle\sum_i a_i^2)+\delta(a_1+a_N),\\
I_2^{\mathrm{clip}}-I_*&=\tfrac12\textstyle\sum_i(a_i-a_i^*)^2+
      [\delta-\ell/(N-2)](a_1+a_N),
\end{aligned}
\tag{9}
$$

where $a^*=(0,\ell/(N-2),\ldots,\ell/(N-2),0)$ and $I_*=\frac12\ell^2(1+1/(N-2))$. The exact difference follows by expanding the square and using $\sum a_i=\ell$. Its two terms are nonnegative since $\delta\ge\ell/(N-2)$. This also bounds the excess threshold $B(t)-B_N$ below by $Ac^2(I_2^{\mathrm{clip}}-I_*)$ once equality of the analytic bound is proved.

For $\ell>0$ the limiting grid starts at its first positive knot $\delta$, then divides $[\delta,q]$ into $N-2$ equal parts, and ends at 1. It realizes $I_*$. When $s\le q$, its endpoint $T(s)\le q$; the next integration variable is at most $q-\delta=\ell\le\delta$. On that interval the endpoint is $\delta$, making the third integral zero. All self-coefficients vanish in this limiting grid because every width is at most $\delta$. A small increase of the first knot makes the grid admissible without changing the limiting threshold. The bound is therefore exact and gives (3), using $1+A(1+cq)=\alpha^2$. For $\ell>0$, equality of (9) fixes the clipped knots. An original last intermediate knot strictly above $q$ would make the first inequality in (9) strict over a positive interval. As a result the limiting minimizing grid is fixed by its original knots as well. If $\ell=0$ use the deterministic-transition argument below. The right side of (3) increases strictly from 1 to infinity.

## 5. Four offers at intermediate risk

For $N=4$ and $1/4<\delta<1/3$, set $\ell=1-2\delta$ and $s=1-3\delta$, so $\ell=\delta+s$ and $0<s<\delta$. Continue to use $A=\alpha-1$ and $c=\alpha/q$. The four-offer threshold is

$$
B_4(\alpha,\delta)=1+A[1+cq+c^2 J],\qquad
J=
\begin{cases}
\ell^2(3+cs)/4,&cs\le1,\\
\ell^2-\delta s+c\delta s^2,&cs\ge1.
\end{cases}
\tag{10}
$$

The value $V_4$ is the unique $\alpha>1$ with $\theta=B_4(\alpha,\delta)$. At $cs<1$ the limiting minimizing widths are $(\delta,\ell/2,\ell/2,\delta)$. At $cs>1$ they are $(\delta,s,\delta,\delta)$ and its reverse. At equality the endpoint widths are both $\delta$, and the middle widths may be any $b,d\in[s,\delta]$ with sum $\ell$. These patterns change with the permitted price range at fixed risk, since $cs=1$ corresponds to $\alpha=q/s$ and the threshold increases with $\alpha$.

**Proof.** For a finite four-slot grid, let $G(u)=(T(u)-\delta)_+$ on $0\le u\le q$, where $T$ is its right-endpoint map. All the successive substitution volumes in (5) are nonnegative. The first three are $q,\ I_2=\int_0^qG(u)\,du,\ I_3=\int_0^q\int_0^{G(u)}G(v)\,dv\,du$. In particular

$$
B(t)\ge1+A[1+cq+c^2(I_2+c I_3)].
\tag{11}
$$

Clip the three intermediate knots to $[\delta,q]$, padding with repeats to four slots if needed. This only decreases $G$ on $[0,q]$, hence cannot increase $I_2$ or $I_3$. Write the clipped core interval lengths as $a,b,d,e$, all nonnegative and summing to $\ell$. The full widths are $(\delta+a,b,d,\delta+e)$. Set $t=a+e,\ p=ae,\ r=bd$ in the rest of this calculation. The heights of $G$ on $[0,q]$ are $a,\ a+b,\ a+b+d,\ q$, with respective widths $\delta+a,b,d,e$. In particular, for $w\in[0,q]$ its integral up to $w$ is

$$
F(w)=aw+b(w-\delta-a)_++d(w-\delta-a-b)_+
          +(\delta+e)(w-q+e)_+ .
$$

Thus $I_2=F(q)$ and $I_3=(\delta+a)F(a)+bF(a+b)+dF(a+b+d)+eF(q)$. Substituting these four arguments gives

$$
\begin{aligned}
I_2&=\ell^2-p-r+t(t-s),\\
I_3&=tI_2-qp+r(s-t)_++b^2(b-\delta)_++d^2(d-\delta)_+.
\end{aligned}
\tag{12}
$$

The following three bounds hold uniformly:

$$
I_2\ge3\ell^2/4,\qquad I_2+I_3/s\ge\ell^2,\qquad I_3\ge\delta s^2 .
\tag{13}
$$

The first is (9) with four slots, since $\delta\ge\ell/2$. For the second, use $s+q=2\ell$ and $(s-t)_+\ge s-t$ in (12) to get

$$
s(I_2+I_3/s-\ell^2)
\ge t(\ell^2+t^2-s^2-2r)-p(2\ell+t)
\ge t(\ell^2/2-s^2+\ell t/2+t^2/4)\ge0.
$$

The second inequality uses $p\le t^2/4$ and $r\le(\ell-t)^2/4$. For the third bound, let $R=b^2(b-\delta)_++d^2(d-\delta)_+$. Equation (12) gives

$$
I_3\ge t\ell^2+t^2(t-s)-p(t+q)+(s-2t)r+R .
\tag{14}
$$

If $t\ge s/2$, substitute both product upper bounds and discard $R$. With $x=\delta/s$ and $z=t/s$, the resulting bound is
$4I_3/s^3\ge(x+1)^2+2zx(x+1)+2xz^2+z^3\ge4x$.
If $t\le s/2$, the last two terms in (14) are at least $(s-2t)\delta(s-t)$. To see this, $b+d=\delta+s-t$, so if both widths are at most $\delta$, their product is smallest at the pair $(\delta,s-t)$ or its reverse. Otherwise write the larger width as $\delta+w$. The difference from that endpoint bound is
$w[(s-2t)(s-t-\delta-w)+(\delta+w)^2]$. The bracket is at least $\delta(s-t)+\delta w+w^2\ge0$. Substituting this lower bound for the last two terms and $p\le t^2/4$ gives
$I_3-\delta s^2\ge t(\delta^2-\delta s+s^2)+t^2(6\delta-5s)/4+3t^3/4\ge0$.
This proves (13).

If $cs\le1$, use $(1-cs)I_2+cs(I_2+I_3/s)$ as a convex combination of the first two bounds. If $cs\ge1$, decompose into $I_2+I_3/s+(c-1/s)I_3$ and use the last two. These give (10) as a lower bound. When $a=e=0$ and $b,d\in[s,\delta]$, (12) simplifies to $I_2=\ell^2-bd,\ I_3=sbd$, and all full grid widths are at most $\delta$. Therefore the saturation equations have no self-couplings. Their four strictly ordered rows have no fourth-order substitution volume, making (11) exact. The product $bd$ is maximal at $b=d=\ell/2$ and minimal at $(s,\delta)$ or its reverse. These are the required minimizing grids on the two sides of $cs=1$, at which the product no longer matters. Moving the first knot slightly above $\delta$ gives admissible sequences with ceilings approaching the stated bound.

For completeness the stated limiting grids exhaust the minimizers. Equality in the first bound of (13) fixes the equal middle widths. Equality in the second forces $t=0$, since $\ell\ge2s>0$, and then forces $b,d\le\delta$ by (12). Equality in the third forces $t=0$ by the strict bounds in its proof for $t>0$, and then $bd=\delta s$. This leaves the clipped grids described in (10). For each, a last intermediate knot strictly above $q$ in the original grid would decrease $I_2$ strictly upon clipping, so equality extends only to the indicated original grids with first knot $\delta$ in the closure. Formula (10) is continuous at $cs=1$, and its threshold increases strictly from 1 to infinity since both pieces are evaluated on fixed grids with positive saturation polynomials. At $\delta=1/4$ the two possible middle-width patterns coalesce with (2). At fixed $\alpha$ as $\delta\uparrow1/3$, $cs<1$ eventually and (10) converges to (3) for $N=4$. $\square$

## 6. Two offers and the deterministic transition

With two offers and first price $x$, let $p$ be the first acceptance probability. When unsold, accepting the second price is weakly better than the bottom payoff. Among second offers below $x$, a bottom offer minimizes the normalized revenue. Among second offers at or above $x$, a top offer minimizes it since $x/x_2$ decreases. For $a=1-1/x$, $b=1-x/\theta$, the deficits from a unit normalized lower-tail reward on these two inputs are

$$
a\min\{1,(1-p)/q\},\qquad b\min\{1,p/q\}.
$$

For $q>0$, their minimum maximum over $p$ equals $\min\{a,b,ab/[q(a+b)]\}$. When neither piece saturates the balancing probability is $p=a/(a+b)$. If $q\ge1/2$ and the balance lies outside $[1-q,q]$, the third option is at least the smaller pure-action deficit. If $q\le1/2$, at least one deficit always saturates and the smaller pure-action value is optimal. Now $\min(a,b)\le1-z^{-1}$, and $ab/(a+b)\le(a+b)/4\le(1-z^{-1})/2$, both with equality at $x=z$. This establishes (1).

For a longer horizon use the two inputs with first offer $z$, all interior offers 1, and a final offer either 1 or $\theta$. Any policy has the same first decision on both, and the two-offer deficits are lower bounds. This proves the transition lower bound for $q\le1/2$ and the strict gap above 1 for $q>1/2$. For $q=0$, use monotonicity from $q=1/2$. The deterministic threshold $z$ attains the transition lower bound on every input.

## 7. A single reservation price is strictly suboptimal

A single-reservation policy samples a threshold $\tau$ at the start, accepts the first offer at least $\tau$, and may be given compulsory acceptance at the final offer if unsold. For $\theta>1,\ N\ge3$ and $0\le\delta<1/N$, the infimum ratio over these policies is strictly greater than $V_N$, even with that final acceptance.

Write $\alpha=V_N$, and take the saturated prices $x_i=1+y_i$ on the equal-width grid of Section 3. They are strictly increasing, with $x_1>\alpha$ and $x_N=\theta$. An $\alpha$-competitive policy must have cumulative sale probability at least $i/N$ on the critical sequence, by Section 1 applied to all its padded prefixes. At the final price the constraint is exactly saturated for the greedy law. If the policy has greater than $1/N$ mass at the first price, its terminal sale-price list is strictly smaller than the greedy list on
$(1/N,\min\{F_1,2/N,q\})$, a positive interval within the lowest $q$ mass, and it is never larger on the remaining mass. This would make the terminal ratio strictly worse. Thus $F_1=1/N$.

A single reservation price would therefore have distribution function $F(x_1)=1/N$. Choose $x'\in(\alpha,x_1)$. On the input with first price $x'$ followed by bottom offers, (4) requires $F(x')>\delta$. Now present $x',x_1$, followed by bottom offers. Both initial slots are before the last offer. The cumulative mass at $x_1$ is still $1/N$, but a positive part of its lowest contributing mass of length $1/N-\delta$ was sold at $x'<x_1$. The right side of (4) is strictly below its saturated value on a first offer of $x_1$. This excludes such a policy. All these inputs form a single finite family. The policy's payoffs on them depend continuously on its distribution function at finitely many fixed prices. The admissible monotone vectors of these values form a compact set, and lower-tail means are continuous in the outcome probabilities. Thus the minimum ratio on this finite family is attained and strictly above $\alpha$.

El-Yaniv et al. give a finite-duration greedy threat strategy at $\delta=0$, and analyze randomized reservation-price rules separately in §3. Their Theorem 5 and Remark 6 already give the saturated equal-mass witness on the risk-neutral boundary. The separation uses the second, intervening-price input to rule out all static reservation-price distributions and extends to the positive-risk range. It explains the role of the history-dependent law in the fixed-duration formulation. [El-Yaniv et al., §§3 and 4.1](https://www.math.tau.ac.il/~fiat/trading.pdf)

## 8. Large price ranges at every risk level

For fixed $N\ge2$, as $\theta$ grows without bound, (2) gives

$$
V_N(\theta,\delta)\longrightarrow \frac{N(1-\delta)}{1-N\delta}
       \quad (0\le\delta<1/N).
\tag{15}
$$

At $\delta=1/N$, (2) instead gives
$V_N(\theta,1/N)\sim (N-1)^{(N-1)/N}\theta^{1/N}$.
More generally, for $1/N\le\delta<1$ put $k=\lceil1/\delta\rceil\le N$. Then

$$
V_N(\theta,\delta)=\Theta_{N,\delta}(\theta^{1/k}).
\tag{16}
$$

At $\delta=1$ the exact ratio is $\sqrt\theta$. The bounded-ratio regime at positive risk and the critical risk $1/N$ refer to a fixed announced $N$. The uniform-over-horizons delay series and its large-range degrees are known.

To prove (16), use the nonnegative substitution integrals in (5). For every grid, $T(s)\ge s$, so replacing each upper limit $(T(s)-\delta)_+$ by $(s-\delta)_+$ decreases these integrals. After $j$ integrations the latter iterates give $(1-j\delta)_+^j/j!$, by direct integration of the translated powers. Since $1-(k-1)\delta>0$, they imply
$B_N-1\ge A c^{k-1}(1-(k-1)\delta)^{k-1}/(k-1)!$.
Conversely a limiting grid with $k$ widths at most $\delta$ is available by taking first width $\delta$ and distributing $q$ equally among the other $k-1$ widths. These are all positive. This grid has no self-couplings, so substitutions terminate with degree at most $k-1$ in $c$. All integration volumes are at most 1, which gives $B_N-1\le A\sum_{j=0}^{k-1}c^j$. The first knot $\delta$ is handled by the same continuity argument as above. For fixed $\delta$, the two estimates bound the price ceiling by constants times $\alpha^k$ for large $\alpha$, and inversion gives (16).

## Prior scope and finite evidence

Christianson et al., Lemma 11, already give the truncated payoff's quantile identity. Their Theorems 12–13 give the known uniform-horizon delay profile, deterministic transition and small-risk lower order. Appendix A.2 uses increasing grids to reduce arbitrary policies to threshold laws. The earlier positive-fallback work and its Proposition 4.1 prove the exact uniform guarantee over all announced horizons, using a finite common-length family to refute a lower uniform ratio. That construction only gives a lower bound for an individual fixed horizon. Its §7 also uses Nekouyan et al.'s exact static zero-fallback theorem to recover the uniform ratio by transforming prices and tail mass. The new results hold at the given fixed $N$, for which the online sale law depends on the successive records. The low- and high-risk exact values, sharp finite-horizon correction near the transition, change of the minimizing four-offer grid, and error bounds on the outer-interval grids concern this fixed-horizon formulation. [Christianson et al., arXiv v2 §§2.3, 5 and Appendix A.2](https://arxiv.org/pdf/2405.09859v2) · [Nekouyan et al., arXiv v2 Theorem 2 and Appendix C](https://arxiv.org/pdf/2512.02427v2) · Earlier positive-fallback result · Earlier uniform-over-horizons result

Angelopoulos, Dürr, and Melidi also study CVaR for one-max search. Their §4.2, Lemma 6 and Theorem 7 put the risk measure over input sequences consistent with a distributional prediction and optimize a single reservation price under a robustness constraint. Our risk measure averages the random policy reward on each fixed input, and the policy may adapt its acceptance probabilities to the observed record sequence. [Angelopoulos, Dürr, and Melidi, ICLR 2026, author manuscript §4.2](https://arxiv.org/pdf/2501.17701v2)

At $\alpha=2$ and $N=3$, the allowable ceiling $\theta$ is $275/32$ at $\delta=1/5$, $5$ at the join $\delta=1/3$, $40/9$ at $\delta=2/5$, and $4$ at the deterministic join. For $N=4,\delta=2/5$, the ceiling is $13/3$, compared with $38/9$ for the uniform guarantee. At $N=4,\delta=3/10$, the threshold separating the equal and unequal middle widths is $\theta=145$, because $cs=1$ at $\alpha=7$. The accompanying Python 3 program solves finite grids by direct triangular rational elimination, compares with the proposed endpoints, and evaluates the greedy rule on finite price families. Its two-offer test directly sorts outcomes when computing the lower-tail average. The four-offer checks include asymmetric and degenerate grids, both minimizing regimes, and their common boundary. The replay examines 42,705 parameter-and-grid pairs across the two outer risk intervals, 8,855 clipped four-offer grids in the intermediate risk interval, and 4,176 finite offer sequences. Run the verifier with Python 3. The finite tests supplement the unrestricted comparison and saturation proof. [Exact finite verifier](evidence/code/verify_exact.py) · [Recorded verifier output](evidence/results/verification.json)
