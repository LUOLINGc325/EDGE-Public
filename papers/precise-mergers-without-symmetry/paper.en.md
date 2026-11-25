---
title: "Precise independent e-value mergers without symmetry"
lang: en
geometry: margin=0.85in
---

# Abstract

We give a coordinate-projection criterion for precision of independent e-value mergers in every finite dimension. It reduces the general mean-one expectation identity to independent two-point laws. For two inputs, we remove the symmetry condition from the sharp comparison with read-once martingale strategies. The least capital to dominate a monotone precise target is at most \(1+(1-T(0,0))/2\), with equality possible at every prescribed corner value. We also compute the exact capital of a family of precise mergers with an \(n\)-coordinate product correction. A target with an \(n\)-way product correction of strength \(\lambda\) has cost \(1+\lambda(n-1)/n\).

# 1. Setting and statements

A finite-valued nonnegative Borel function \(T\) on \([0,\infty)^n\) is **precise** if \(\mathbb E T(X_1,\ldots,X_n)=1\) for every collection of independent nonnegative variables of mean one. It is an independent e-value merger if the expectation is at most one whenever the independent variables have means at most one. A coordinatewise nondecreasing precise target is always an independent e-value merger: add \(1-\mathbb E X_i\) to each coordinate and apply precision followed by monotonicity.

A read-once martingale strategy chooses an unread coordinate and a stake fraction \(s\in[0,1]\) before seeing its value \(x\), then multiplies current wealth by \(1+s(x-1)\). Decisions use measurable rules of the revealed inputs. The expected terminal payoff at a fixed input can also average independent random seeds. Write \(\mathcal C(T)\) for the infimum initial capital of strategies whose expected payoff is at least \(T\) pointwise. A sum of two ordered accounts with total initial capital \(C\) is implemented by randomizing the order with probabilities proportional to their initial allocations and rescaling the chosen account to initial capital \(C\). An account with zero allocation contributes no payoff.

**Theorem 1.** Define the coordinate operators, acting on finite-valued Borel functions, by
\[
 (\Pi_i F)(x)=F(x)-(x_i-1)\bigl(F(x^{i\leftarrow2})-F(x^{i\leftarrow1})\bigr),
\]
where \(x^{i\leftarrow t}\) replaces coordinate \(i\) by \(t\). For a nonnegative \(T\), the following are equivalent.

1. \(T\) is precise.
2. Its expectation is one for independent mean-one laws of support size at most two in each coordinate.
3. \(\Pi_1\cdots\Pi_n T=1\) pointwise.

In this case \(T\le\prod_i\max(1,x_i)\), and explicit Borel functions \(f_i\) from these operators give
\[
 T(x)=1+\sum_{i=1}^n (x_i-1)f_i(x_{-i}).
 \tag{1}
\]

**Theorem 2.** For every coordinatewise nondecreasing precise two-input target, allowing arbitrary asymmetry,
\[
 \mathcal C(T)\le 1+\frac{1-T(0,0)}2 .
 \tag{2}
\]
For each fixed value \(T(0,0)\in[0,1]\), this is the sharp worst cost over its class.

**Theorem 3.** For \(n\ge2\) and \(0\le\lambda\le1\), the target
\[
 T_{n,\lambda}(x)
   =1+\lambda\left(\prod_{i=1}^n(x_i-1)_+
                    -\prod_{i=1}^n(1-x_i)_+\right)
 \tag{3}
\]
is a monotone precise independent e-value merger and has exact capital \(1+\lambda(n-1)/n\).

# 2. A finite-support characterization of precision

The coordinate operators commute. They remove all functions of the form \((x_i-1)\) times a function of the other coordinates, and their outputs agree at \(x_i=1\) and \(x_i=2\) on every fixed slice. The expectations of \(F\) and \(\Pi_i F\) agree under any independent product of finite-support mean-one laws. Thus if condition 2 holds, \(F^\flat=\Pi_1\cdots\Pi_n T\) has expectation one under those same two-point products and agrees at \(1,2\) on each coordinate slice.

On functions agreeing at \(1,2\), evaluation at any \(t\ge0\) is a signed linear combination of the expectations under mean-one laws of support size at most two, with coefficients summing to one. For \(0\le t<1\), use the law on \(\{t,2\}\) with probability \(1/(2-t)\) at \(t\) and replace evaluation at \(2\) by evaluation at \(1\). For \(t>1\), use the law on \(\{0,t\}\) with probability \(1/t\) at \(t\), and substitute the preceding combination for evaluation at \(0\). Evaluation at \(1\) itself already has the desired form. Applying these identities in every coordinate of \(F^\flat\) gives \(F^\flat(x)=1\): each product expectation is one, and the product of the sums of coefficients is one. This proves condition 3.

Conversely the telescoping formula for \(I-\Pi_1\cdots\Pi_n\) gives (1), with
\[
 f_i=(\Pi_1\cdots\Pi_{i-1})
          \bigl(T|_{x_i=2}-T|_{x_i=1}\bigr).
\]
In particular condition 3 implies precision on finite independent mean-one supports, since every nonconstant term of (1) has zero expectation by independence.

To control general inputs, put positive mass at each prescribed \(x_i\) using a mean-one two-point law. If \(x_i>1\), mass \(1/x_i\) is possible by putting the remaining mass at zero. If \(x_i<1\), let the second support point tend to infinity, making the mass at \(x_i\) tend to one. At \(x_i=1\) use the point mass. The expectation under the product law is one, and \(T\ge0\), so the probability of the given vector times its value is at most one. This yields \(T(x)\le\prod_i\max(1,x_i)\). Evaluating at \(1,2\) and applying each of the coordinate operators now shows that \(|f_i|\) is bounded by a constant depending only on \(n\) times \(\prod_{j\ne i}(1+x_j)\). Each evaluation at an anchor changes that product bound by a fixed factor. Multiplying by \(|x_j-1|\) while replacing that coordinate's factor also preserves this bound up to a constant. For independent mean-one inputs all terms of (1) are therefore absolutely integrable and factorize. This proves full precision. The implication from condition 1 to condition 2 is immediate.

# 3. The sharp two-input upper bound

Shift to \(u=x_1-1,v=x_2-1\) and write \(U(u,v)=T(1+u,1+v)\). From (1) there are finite Borel functions \(f,g\) with
\[
 U(u,v)=1+v f(u)+u g(v).
 \tag{4}
\]
Write \(r=f(-1)\), \(s=g(-1)\), and \(q=r+s=1-T(0,0)\). Monotonicity, precision at \(x_1=x_2=1\) and nonnegativity imply \(0\le q\le1\). At this point \(r\) and \(s\) individually may have either sign. Comparing \(U(u,-1)\) with \(U(-1,-1)\), and applying the same argument to the other coordinate, gives the upper bounds below:
\[
 -ru\le f(u)\le r+s(u+1),\qquad
 -sv\le g(v)\le s+r(v+1).                                                \tag{5}
\]
For the lower bound on \(f\), compare \(U(u,t)\ge U(-1,t)\) for \(t>0\). It gives \(f(u)\ge r-(u+1)g(t)/t\). Applying the upper bound on \(g(t)\) and sending \(t\) to infinity proves \(f(u)\ge-ru\). The lower bound on \(g\) follows the same way.

Define \(\alpha=\inf_{u>0} f(u)/u\) and \(\beta=\inf_{v>0}g(v)/v\). They are finite by (5) and evaluation at any fixed positive argument. Since \(U(u,v)\ge1\) in this positive quadrant, \(\alpha+\beta\ge0\). Taking the positive arguments to infinity in (5) also yields \(\alpha\le s\) and \(\beta\le r\). The change
\[
 f(u)\longmapsto f(u)+\tau u,\qquad
 g(v)\longmapsto g(v)-\tau v
\]
preserves (4). Both new functions are nonnegative on positive arguments exactly when \(-\alpha\le\tau\le\beta\). Their new corner values are both nonnegative exactly when \(-s\le\tau\le r\). The first interval is nonempty and lies inside the second by the preceding bounds. Choose \(\tau\) to be the nearest point in \([-\alpha,\beta]\) to \((r-s)/2\), the shift that would balance the corners. Its corner values are therefore nonnegative.

Continue using \(f,g,r,s\) for the resulting functions and corners. If the balance shift was feasible then \(r=s=q/2\). If it was above the feasible interval then \(r>q/2\) and \(\inf_{v>0}g(v)/v=0\). In this case \(f\) is nondecreasing, because monotonicity of (4) in \(u\) gives
\[
 f(u_2)-f(u_1)\ge -(u_2-u_1)g(v)/v
 \qquad(u_2>u_1,\ v>0),
\]
and the ratios on the right can tend to zero. If the balance shift was below the feasible interval, the corresponding conclusion is \(s>q/2\) and \(g\) nondecreasing. Thus any corner greater than \(q/2\) belongs to a nondecreasing function and has no deficit below its corner. Put
\[
 \eta_f(u)=(r-f(u))_+,\qquad \eta_g(v)=(s-g(v))_+.
\]
For a corner at most \(q/2\), (5) and nonnegativity on positive arguments bound its deficit by \(q/2\) times \(\min(1,1+u)\) for \(f\), or \(\min(1,1+v)\) for \(g\). At zero the bound follows from \(f(0),g(0)\ge0\) by monotonicity of \(U(0,v),U(u,0)\). For a larger corner its deficit is zero. Both bounds therefore hold simultaneously.

Use total capital \(C=1+q/2\) in two accounts, one for each order. Starting allocations at least \(s,r\) are possible since \(s+r=q\le C\). In the account reading \(x_1\) first, wager \(s\) dollars on it and then \((f(u)-r)_+\) on \(x_2\). The second wager fits its current funds by (5), as it is at most \(s(1+u)\). In the reverse order wager \(r\) first and then \((g(v)-s)_+\) on \(x_1\). The combined payoff minus \(U(u,v)\) is
\[
 \frac q2 + v\eta_f(u)+u\eta_g(v).
\]
For mixed signs only one term after \(q/2\) is negative, with magnitude at most \(q/2\). Both terms are nonnegative when \(u,v\ge0\). For \(u=-b,v=-d\) with \(b,d\in[0,1]\), their total loss is at most
\[
 \tfrac q2\{d(1-b)+b(1-d)\}\le\tfrac q2 ,
\]
since the bracket is bilinear and has maximum one on the corners of the square. This proves (2) with an attaining upper-bound construction. Taking \(n=2\) and \(\lambda=q\) in (3) below gives equality at the prescribed corner.

# 4. An exact \(n\)-input capital gap

The target (3) is nonnegative because the product of the negative parts is at most one. It is coordinatewise nondecreasing. For independent mean-one inputs, the expectations of the positive and negative parts agree coordinate by coordinate, so the two product expectations agree. This proves precision and hence independent e-validity.

For the capital lower bound, let a dominating strategy have capital \(C\), and let \(W\) be its mean first dollar wager over the seed. On the vector \((t,\ldots,t)\) for \(t\ge1\), its expected payoff is at most
\[
 [C+(t-1)W]t^{n-1}.
\]
Each later multiplier is at most \(t\). The leading coefficient of the target as \(t\) tends to infinity is \(\lambda\), so \(W\ge\lambda\). Now average over the \(n\) vectors with one coordinate equal to one and every other coordinate zero. The target is one on each. The first wager loses its amount if it chooses a zero, which has probability \((n-1)/n\) under this averaging for every fixed seed. Later multipliers are at most one. Consequently
\[
 1\le C-\frac{n-1}{n}W,\qquad C\ge1+\lambda\frac{n-1}{n}.
\]

For attainment, begin at \(C=1+\lambda(n-1)/n\) and choose the first coordinate uniformly. Wager \(\lambda\) dollars on it. After seeing \(x_i\), hold \(\lambda\min(1,x_i)\) of the return as cash and keep \(\lambda(x_i-1)_+\) in an active account. The original \(C-\lambda\) is also kept in cash. For each further reveal, wager the current active account fully and split its return in the same proportions: from a stake \(A\) and outcome \(x_j\), reserve \(A\min(1,x_j)\) as cash and retain \(A(x_j-1)_+\) as the new active account. This is a legal nonnegative-wealth strategy. Its terminal payoff is at least
\[
 C-\lambda+\lambda\min(1,x_i)+\lambda\prod_j(x_j-1)_+ .
\]
On averaging over the first coordinate, domination of (3) follows from
\[
 \frac1n\sum_j a_j-\prod_j a_j\le\frac{n-1}{n},
 \qquad a_j=(1-x_j)_+\in[0,1].
\]
The left side is affine in each coordinate separately, so it has a maximum at a corner of the cube. At the all-one corner it is zero, and at all other corners it is the proportion of ones, at most \((n-1)/n\). This proves the exact formula.

As an application, products on disjoint blocks have exact multiplicative cost by the full-domain tensorization theorem of the pinned source, which allows adaptive interleaving. Taking strengths one, pairs give cost \((3/2)^k\) on \(2k\) coordinates. Taking one triple and \(k-1\) pairs gives cost \((5/3)(3/2)^{k-1}\) on \(2k+1\) coordinates for \(k\ge1\). This supplies exact examples for both parities.

# 5. Pinned comparison

The pinned full-domain capital manuscript proves tensorization for monotone targets and the same sharp corner bound for symmetric precise pairs. The argument here removes symmetry by balancing the two corner values subject to nonnegative positive-axis profiles, and treats a nonbalanced endpoint by monotonicity of the larger profile. The coordinate projection identifies precision in every finite dimension, and the product-part construction gives an exact \(n\)-way example with a direct first-wager certificate. The comparison is to the pinned repository source.
