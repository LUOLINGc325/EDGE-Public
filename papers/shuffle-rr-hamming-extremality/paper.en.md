---
title: "Worst-case privacy in product randomized response: blanket order and actual shuffled laws"
subtitle: "Difference sets, heterogeneous backgrounds, and exact privacy profiles"
date: "24 November 2026"
lang: en-US
---

# Abstract

We study the worst input pair for the privacy-blanket functional of a product of randomized-response channels. For arbitrary finite alphabets, heterogeneous nonnegative local privacy parameters, any positive number of users, and every privacy parameter $\varepsilon\ge0$ (so $\lambda=e^\varepsilon\ge1$), we prove that enlarging the set of differing attributes cannot decrease the functional. The result follows from a stronger convex-order comparison of the generalized privacy-amplification random variables. Consequently, a pair differing in every attribute always attains the maximum. This answers the joint-randomized-response question in Section 8 of Su, Cheng, and Wang [1], and removes the remaining search over Hamming distances in that setting. The proof uses a two-point convexity argument, independent products, and the original blanket mass, including its zero atom. For actual shuffled laws we prove a homogeneous-coordinate postprocessing order and a first-order sign formula showing fixed-background Blackwell incomparability. Exact three-user examples show that homogeneous backgrounds and full Hamming changes can be globally suboptimal, and that the maximizing pair can depend on the threshold. For any sample size and finite categorical product randomized response with odds strictly above one, we determine the exact global profile on a final interval. Convex order and its preservation under independent summation are classical tools; the contribution is their application to the exact fixed-product comparison stated here.

# 1. Problem and scope

In a multi-attribute report, a single person's record can change in one attribute or in every attribute. An accountant for the whole input domain must cover all these possibilities. Section 8 of [1] leaves open whether the fully differing pair gives the largest blanket bound for joint randomized response. A variance comparison alone would not settle the finite-user bound, because that bound depends on the positive part of a sum.

We retain the mechanism and the blanket functional of [1]. We prove a comparison for every finite user count, rather than an asymptotic statement. For identical coordinates, the bound is nondecreasing in Hamming distance. For heterogeneous coordinates, the correct order is inclusion of the difference sets. Its maximum is still attained when every coordinate differs.

In Sections 1–8, the word *bound* refers to the privacy-blanket/GPARV functional. Its role as an upper bound for shuffled privacy is an existing result of [1, Theorem 13], building on [2]. Sections 9–11 work directly with the actual shuffled-output law.

# 2. Exact finite definitions

Let $m\ge1$. Coordinate $j$ has an alphabet $\mathcal A_j$ of size $k_j\ge2$ and a finite parameter $t_j\ge1$. Writing $t_j=e^{\varepsilon_j}$ recovers a local privacy parameter $\varepsilon_j\ge0$. Its randomized-response channel is

$$
 R_j(a,y)=\frac{t_j^{\mathbf1\{a=y\}}}{t_j+k_j-1}.
 \tag{1}
$$

Each entire report is generated using the independent product channel

$$
 R_x(y)=c\prod_{j=1}^m t_j^{\mathbf1\{x_j=y_j\}},
 \qquad c=\prod_{j=1}^m\frac1{t_j+k_j-1},
 \qquad K=\prod_{j=1}^m k_j.
 \tag{2}
$$

The blanket is taken over the **full product input domain**. For every output $y$, its minimum row probability is $c$: each factor is at least one, and $k_j\ge2$ permits an input distinct from $y_j$ in every coordinate. Hence its mass and normalized distribution are

$$
 \gamma=Kc=\prod_{j=1}^m\frac{k_j}{t_j+k_j-1},
 \qquad \omega(y)=K^{-1}.
 \tag{3}
$$

In particular $0<\gamma\le1$, and it does not change when the compared pair changes. Recomputing a blanket using only the two compared inputs would be a different problem.

Fix $\lambda=e^\varepsilon\ge1$. Let $U_j$ be independent uniform symbols in $\mathcal A_j$, and let $I$ be an independent Bernoulli random variable with parameter $\gamma$. Define

$$
 Z_{x,x'}(U)=\prod_j t_j^{\mathbf1\{U_j=x_j\}}
       -\lambda\prod_j t_j^{\mathbf1\{U_j=x'_j\}},
 \qquad G_{x,x'}=I Z_{x,x'}(U).
 \tag{4}
$$

This is exactly Definition 9 of [1]: the active value is $(R_x(U)-\lambda R_{x'}(U))/(\gamma\omega(U))$, since $\gamma\omega(U)=c$; the inactive value is zero. For $n\ge1$, put

$$
 B_n(x,x';\lambda)=\frac1n\mathbb E\left[
          \left(\sum_{i=1}^{n}G_{x,x'}^{(i)}\right)_+\right],
 \qquad z_+=\max\{z,0\},
 \tag{5}
$$

where the copies are independent. There are $n$ summands, not $n-1$.

All expectations in this paper are finite weighted sums. Equivalently, use the alphabet $\Omega=\{\bot\}\cup\prod_j\mathcal A_j$ with probabilities $w(\bot)=1-\gamma$ and $w(y)=c$. Set $G(\bot)=0$ and use (4) on other symbols. Formula (5) is then a fully explicit finite sum over $\Omega^n$. This equivalent description is the basis of the machine-checkable statement.

Coordinatewise relabeling of the outputs shows that the law in (4) depends on the pair only through

$$D=\{j:x_j\ne x'_j\}.$$

Indeed, if the inputs coincide, a bijection can send both to a designated symbol $0$; if they differ, it can send them to designated distinct symbols $0,1$. The uniform output law is invariant under these bijections. We write $Z_D$, $G_D$, and $B_n(D;\lambda)$ for these laws and functionals, with the channel parameters kept fixed.

# 3. Main result

For finite-support real random variables, $X\preceq_{\mathrm{cx}}Y$ means
$\mathbb E\phi(X)\le\mathbb E\phi(Y)$ for every real-valued convex function $\phi$ on $\mathbb R$. No regularity or integrability issue arises for finite support.

**Theorem 1 (difference-set extremality).** Fix $m$, $(k_j,t_j)$, and $\lambda$ as above. If $D\subseteq E\subseteq\{1,\ldots,m\}$, then

$$Z_D\preceq_{\mathrm{cx}}Z_E,\qquad G_D\preceq_{\mathrm{cx}}G_E.\tag{6}$$

For every $n\ge1$ and independent copies on each side,

$$
 \sum_{i=1}^nG_D^{(i)}\preceq_{\mathrm{cx}}\sum_{i=1}^nG_E^{(i)},
 \qquad B_n(D;\lambda)\le B_n(E;\lambda).
 \tag{7}
$$

In particular, the maximum over every ordered input pair is attained at $D=\{1,\ldots,m\}$. When all $k_j=k$ and $t_j=t$, the bound depends only on $h=|D|$, and

$$B_n(0;\lambda)\le B_n(1;\lambda)\le\cdots\le B_n(m;\lambda).\tag{8}$$

The theorem includes $n=1$, binary alphabets, zero local privacy parameters, and all finite privacy thresholds. It does not require the same alphabet size or local privacy budget in different coordinates.

# 4. Proof

## 4.1. A two-point convex comparison

**Lemma 2.** For $A,B\ge0$, $t\ge1$, and every convex $\phi:\mathbb R\to\mathbb R$,

$$
 \phi(tA-tB)+\phi(A-B)
 \le\phi(tA-B)+\phi(A-tB).
 \tag{9}
$$

**Proof.** If $A+B=0$, then $A=B=0$, and both sides equal $2\phi(0)$. Otherwise define

$$
 p=\frac{A}{A+B},\qquad q=\frac{B}{A+B},\qquad
 u=tA-B,\qquad v=A-tB.
$$

Then $p,q\ge0$, $p+q=1$, and direct expansion gives

$$tA-tB=pu+qv,\qquad A-B=qu+pv.$$

Apply convexity to each equality and add. The coefficients of both $\phi(u)$ and $\phi(v)$ become one. This proves (9). The same argument allows any common shift inside $\phi$. $\square$

This is the familiar two-point mean-preserving spread. We use it as an elementary lemma and do not claim it as a new convexity principle.

## 4.2. Replacing one equal coordinate

**Lemma 3.** If $j\notin D$, then $Z_D\preceq_{\mathrm{cx}}Z_{D\cup\{j\}}$.

**Proof.** Use the canonical input labels described after (5). Condition on all $U_\ell$ with $\ell\ne j$, and put

$$
 A=\prod_{\ell\ne j}t_\ell^{\mathbf1\{U_\ell=0\}},
 \qquad
 B=\lambda\prod_{\ell\ne j}
       t_\ell^{\mathbf1\{U_\ell=b_\ell(D)\}},
 \quad
 b_\ell(D)=\mathbf1\{\ell\in D\}.
 \tag{10}
$$

Both coefficients are nonnegative. With $t=t_j$ and $k=k_j$, the conditional convex expectations before and after changing coordinate $j$ are respectively

$$
 \frac{\phi(tA-tB)+(k-1)\phi(A-B)}{k},
 \tag{11}
$$

and

$$
 \frac{\phi(tA-B)+\phi(A-tB)+(k-2)\phi(A-B)}{k}.
 \tag{12}
$$

Their difference is nonnegative by Lemma 2. Averaging the conditional comparison over the unchanged coordinates proves the assertion. The case $k=2$ has no remaining $k-2$ terms and needs no exception. $\square$

Adding the finitely many elements of $E\setminus D$ one at a time proves the first comparison in (6).

## 4.3. The zero atom and independent users

**Lemma 4 (two elementary closure facts).** Suppose $X\preceq_{\mathrm{cx}}Y$ have finite support.

(a) For a common $a\in[0,1]$, the mixtures that equal $X$ and $Y$, respectively, with probability $a$, and equal zero otherwise, remain ordered in convex order.

(b) If $T$ is independent of the compared variable, then $X+T\preceq_{\mathrm{cx}}Y+T$.

**Proof.** For (a), the two convex expectations are
$(1-a)\phi(0)+a\mathbb E\phi(X)$ and
$(1-a)\phi(0)+a\mathbb E\phi(Y)$. For (b), condition on each value $s$ of $T$. The function $z\mapsto\phi(z+s)$ is convex, so the conditional inequality follows from the definition; average over $s$. $\square$

Apply Lemma 4(a) with the common value $a=\gamma$ to obtain $G_D\preceq_{\mathrm{cx}}G_E$. Next replace the first summand, then the second, and so on in an independent $n$-tuple. Lemma 4(b) applies at every replacement and gives the first part of (7). Choosing $\phi(z)=z_+$ and dividing by the positive integer $n$ gives the second part.

Every difference set is contained in the full set, proving its extremality. For identical coordinate parameters, permuting coordinates preserves the law, so the functional depends only on $|D|$. Applying (7) to nested sets of sizes $0,1,\ldots,m$ proves (8). This completes the proof of Theorem 1. $\square$

# 5. Boundaries and implementation consequences

The comparison is non-strict. For example, take two binary coordinates, $t_1=t_2=2$, one user, and $\lambda=1$. The bounds for Hamming distances one and two both equal $1/3$. This exact arithmetic check is supplied in the reproducibility package; strict monotonicity is not part of Theorem 1.

The inactive atom must be retained in any implementation. It has the same mass for every compared pair, which is why Lemma 4(a) applies. Also, if $\lambda\ge\prod_jt_j$, every active value in (4) is nonpositive, and so is the inactive value. Thus (5) is zero. If all $t_j=1$, every active value is $1-\lambda$ and $\gamma=1$, with the same conclusion. These observations prevent invalid extrapolation of a negative upper support bound to the zero atom.

For heterogeneous coordinates, inclusion of difference sets is essential to the formulation. The theorem does not rank two incomparable sets by cardinality. Nevertheless all such sets lie below the full set, so one fully differing pair suffices for the worst-case blanket calculation. For identical coordinates, it removes the need to maximize over the $m$ nonzero Hamming distances. It does not remove the remaining numerical work needed to evaluate the resulting one-pair functional.

# 6. Reproducibility and evidence boundary

The accompanying exact-rational programs compare original channel enumeration with a separate coordinate-factor recurrence, check the complete probability laws of independent sums, and test all stop-loss breakpoints of each finite pair of distributions. The [reproduction instructions](evidence/README.md) use the fixed [enumeration configuration](evidence/code/cases.json). No floating-point tolerance is used, and failed checks raise exceptions even under Python's optimization flag.

These finite computations are diagnostic evidence, not the proof for unbounded $m$ or $n$. The general proof is Sections 2--4. Historical Lean checks have their original limited coverage. Lean verification of the integrated manuscript is a separate deliverable.

This is an AI-assisted research manuscript with internal independent review. It has not been externally peer reviewed. Novelty is limited to the sources and versions actually checked.

# 7. Related work and attribution

Su, Cheng, and Wang [1] supply the general-clone framework, the GPARV expression, and the specific open question solved here. The privacy-blanket framework originates in Balle et al. [2]. Neither the blanket definition nor its reduction theorem is a contribution of this note.

Shvets [3, Section 4] uses convex order for universal envelopes in a one-coordinate contamination experiment, optimizing over mechanisms under a common local privacy cap. The reference law there is an actual channel row. Here the mechanism is fixed, the reference is its full-domain blanket, and the comparison is between difference sets in a product of randomized-response coordinates. The two-point convexity argument and independent-sum closure are attributed classical tools; the fixed-product replacement comparison is the additional step.

The same arXiv identifier has a substantially rewritten version 2, with a new title [5]. Its Appendix D expressly restricts the binary envelope to homogeneous contamination and gives a counterexample to extending it to arbitrary neighbouring datasets. We checked that current version as well. Neither its Theorem D.3 nor its counterexample compares the fixed product-blanket difference sets considered here. No result from the superseded version is used as a proof dependency.

Takagi and Liew [4] analyze blanket divergence asymptotically and develop finite-user numerical accounting. Their asymptotic shuffle index and fixed-pair accounting do not provide the all-finite-$n$, all-threshold difference-set comparison proved here. Source checks include the authors' available full version of [1], Section 8, in addition to its arXiv v6.

# 8. Extending the blanket comparison to equal-density channels

## 8.1. A same-marginal comparison

**Lemma E1.** Let X,Y be finite-support real random variables with the same marginal distribution, with arbitrary dependence. For all A,B >= 0,

$$
(A-B)X\preceq_{cx}AX-BY.
\tag{E1}
$$

Here convex order compares expectations of every real convex function; finite support makes every expectation finite.

**Proof.** If A=B, the left side is zero and the right side has mean zero, so Jensen's inequality proves the assertion. If A>B, set d=A-B and theta=d/A in (0,1]. The identity

$$
dX=\theta(AX-BY)+(1-\theta)dY
$$

and convexity imply

$$
\mathbb E\phi(dX)\le\theta\mathbb E\phi(AX-BY)
+(1-\theta)\mathbb E\phi(dY).
$$

The last expectation equals E phi(dX), because X,Y are identically distributed. Subtraction and division by theta prove (E1). If B>A, apply the case just proved to Y,X with coefficients B,A and to the convex function z -> phi(-z). The resulting left law is (A-B)Y, which equals the law of (A-B)X. The zero-coefficient cases are included and give equality in distribution. QED.

This is a same-marginal rearrangement inequality with a direct Jensen proof. The general subject of fixed-marginal inequalities is classical (Tchen, 1980); that work is cited for antecedent context, not as a necessary proof dependency or as a claim that its exact theorem text was fully read here.

**Quadratic identity.** Under the same hypotheses,

$$
\mathbb E(AX-BY)^2-\mathbb E((A-B)X)^2
=AB\,\mathbb E(X-Y)^2.
\tag{E2}
$$

**Proof.** Expand both squares and use E X^2=E Y^2. QED. Thus when A,B>0 the two laws differ unless X=Y almost surely. This does not imply that any particular positive-part threshold is strictly improved.

## 8.2. The channel class and its exact blanket

For each coordinate j=1,...,m let the input alphabet A_j and output alphabet Y_j be finite, with |A_j|>=2. Let R_j(a,y)>0 be a channel: sum_y R_j(a,y)=1 for every input a. Define

$$
c_j(y)=\min_{a\in A_j}R_j(a,y),\qquad
\gamma_j=\sum_y c_j(y),\qquad
\omega_j(y)=c_j(y)/\gamma_j,
$$

and f_{j,a}(y)=R_j(a,y)/c_j(y). Positivity gives gamma_j>0 and f_{j,a}>=1. The standing additional hypothesis is

$$
f_{j,a}(U_j)\overset{d}=f_{j,b}(U_j)
\quad\text{for every }a,b\in A_j,
\qquad U_j\sim\omega_j.
\tag{E3}
$$

Equal means alone would not suffice for (E3). In fact all these density variables have mean 1/gamma_j automatically, but their distributions may be different.

Use the full product input domain and the independent product channel R_x(y)=product_j R_j(x_j,y_j). Minimizing separately in each coordinate gives

$$
c(y)=\min_x R_x(y)=\prod_j c_j(y_j),\quad
\gamma=\prod_j\gamma_j,\quad
\omega=\bigotimes_j\omega_j.
\tag{E4}
$$

For lambda>=1 and an ordered pair x,x', take independent U_j~omega_j and I~Bernoulli(gamma), and set

$$
Z_{x,x'}=\prod_j f_{j,x_j}(U_j)
-\lambda\prod_j f_{j,x'_j}(U_j),\qquad G_{x,x'}=I Z_{x,x'}.
\tag{E5}
$$

This is exactly the source GPARV: gamma omega(y)=c(y), and (R_x-lambda R_x')/c is the displayed active value. The inactive atom has mass 1-gamma. For n>=1 define

$$
B_n(x,x';\lambda)=\frac1n\mathbb E\left(\sum_{i=1}^nG_{x,x'}^{(i)}\right)_+.
\tag{E6}
$$

There are n independent summands. The blanket is computed over the full product domain once, not recomputed for a two-input subchannel.

## 8.3. Expanding the coordinates that differ

Say that x'' expands the differences of x,x' when x''_j=x'_j at every originally unequal coordinate, and at originally equal coordinates it either remains x_j or changes to another input symbol.

**Theorem E2.** Under (E3), every such expansion satisfies

$$
Z_{x,x'}\preceq_{cx}Z_{x,x''},\qquad
G_{x,x'}\preceq_{cx}G_{x,x''},
\tag{E7}
$$

and for every n>=1 the independent sums remain ordered. Consequently

$$
B_n(x,x';\lambda)\le B_n(x,x'';\lambda).
\tag{E8}
$$

The maximum over all input pairs has a maximizer differing in every coordinate. This last assertion does not yet say that every fully different pair has the same value.

**Proof.** It suffices to change one originally equal coordinate j from a=x_j=x'_j to b!=a in the second input. Condition on all output coordinates other than j. Let A=product_{ell!=j} f_{ell,x_ell}(U_ell) and B=lambda product_{ell!=j} f_{ell,x'_ell}(U_ell). These are positive constants under the conditioning. Before replacement the active value is (A-B)X, where X=f_{j,a}(U_j); afterwards it is AX-BY, where Y=f_{j,b}(U_j). Hypothesis (E3) supplies the identical marginals required by Lemma E1, independently of the actual dependence of X,Y through U_j. Averaging the conditional inequality proves the active-law comparison.

For every convex phi, mixing both variables with a common zero atom changes their expectations to (1-gamma)phi(0)+gamma E phi(Z). Hence the order is preserved for G. Adding an independent variable preserves convex order by conditioning on that variable and translating phi. Replacing the n independent summands one at a time proves the sum comparison. Choosing phi(z)=z_+ gives (E8). Repeating the single-coordinate argument proves arbitrary difference expansion.

Every pair can be expanded to a fully different pair because each input alphabet has at least two symbols. The finite set of input pairs has a maximum, and expansion of any maximizer cannot decrease its value. This gives a fully different maximizer. QED.

The argument also works at lambda=0 and in 0<lambda<1, but the retained privacy-accounting statement is lambda>=1. It gives no ordering between incomparable difference patterns unless a symmetry identifies them.

## 8.4. Symmetry conditions and non-RR examples

**Proposition 3.** Suppose a finite group acts transitively on A_j and by permutations on Y_j, with channel equivariance

$$
R_j(g a,g y)=R_j(a,y).
\tag{E9}
$$

Then (E3) holds. If the action on A_j is transitive on ordered pairs of distinct inputs, the joint law of (f_{j,a}(U_j),f_{j,b}(U_j)) is independent of the particular ordered distinct pair (a,b).

**Proof.** Since g permutes the input alphabet, minimizing (E9) over inputs shows c_j(g y)=c_j(y). Therefore omega_j is invariant and f_{j,g a}(g y)=f_{j,a}(y). Transitivity gives (E3); applying the same identity to two rows gives the ordered-pair statement. QED.

If every coordinate has the stronger pair symmetry, its pair law depends only on whether the inputs agree. By independence, the full product law depends only on the difference set. Theorem E2 then gives difference-set inclusion and a single canonical fully different maximizing pair. If all coordinate channels are identical, coordinate permutations give the usual nondecreasing Hamming-distance statement. Different coordinate channels still give inclusion, not cardinality ordering.

For a concrete non-RR channel, let A=[k], Y={0,1}^k and choose p,q in (0,1). Given input a, emit independent bits with success probability p in position a and q in every other position. Thus

$$
R(a,y)=p^{y_a}(1-p)^{1-y_a}
\prod_{i\ne a}q^{y_i}(1-q)^{1-y_i}.
\tag{E10}
$$

The symmetric group on k coordinates acts equivariantly and is transitive on ordered distinct inputs. All probabilities are positive. This channel therefore satisfies the stronger conclusion. The source's one-shot RAPPOR uses p=t/(t+1), q=1/(t+1), t>=1; its OUE uses p=1/2, q=1/(t+1), t>=1. These are the finite single-message mechanisms in Su--Cheng--Wang Appendix A.2--A.3. The statement is not about the separate longitudinal memoization protocol sometimes called RAPPOR.

Products may mix finite unary encoders and randomized-response coordinates with different parameters and alphabet sizes. Every coordinate retains its own exact full-domain blanket, including finite-alphabet exceptional outputs. No asymptotic blanket formula is substituted.

## 8.5. Strict spread and a necessary limitation

For one replacement, let X,Y and A,B be as in the proof. Formula (E2) gives the exact second-moment change

$$
\mathbb E Z_{\mathrm{after}}^2-\mathbb E Z_{\mathrm{before}}^2
=\mathbb E_{U_{-j}}[AB]\,\mathbb E_{U_j}(X-Y)^2.
\tag{E11}
$$

Both expectations are over independent coordinate groups. This is positive if the changed channel rows differ, since omega_j is strictly positive and A,B>0. The means of both active laws are (1-lambda)/gamma. After the common zero atom, the second-moment gap is gamma times (E11). For n independent summands the gap is n gamma times (E11), since all cross means agree. Thus an actual row change gives a strict change in the spread of the sum distribution. It still need not strictly increase the particular threshold-zero positive part in (E6). The original two-bit RR example at n=1, t=2, lambda=1 has equal bounds at Hamming distances one and two.

Equal blanket-density means cannot replace identical laws. Consider the three-row binary-output channel

$$
R=\begin{pmatrix}1/3&2/3\\1/6&5/6\\5/6&1/6\end{pmatrix}.
$$

Its full-domain c=(1/6,1/6), gamma=1/3 and omega=(1/2,1/2). Its first two density rows are X=(2,4), Y=(1,5), both of mean 3. With A=2,B=1, the before variable is X but 2X-Y is constantly 3. For phi(z)=(z-3)_+, the expectations are 1/2 and 0. Thus the conditional convex-order step fails without (E3). This is a counterexample to the weakened lemma, not a claim that it is a full-product counterexample to every conceivable weaker theorem.

## 8.6. Relation to related convex-order results

The blanket framework, its validity as an upper bound, product factorization and the GPARV accounting expression are prior work of Balle et al. and Su--Cheng--Wang. Same-marginal convex comparisons, Jensen's inequality and independent-sum closure are classical tools. The additional claim is a precise sufficient channel condition for finite-parameter coordinate-difference expansion, with explicit finite unary-encoding applications.

The source Section 8 was reread and still states the joint-RR question as open. Shvets v2 Appendix D was compared: its homogeneous-contamination binary envelope is a different cross-mechanism statement, and Proposition D.5 excludes a universal arbitrary-background interpretation. Takagi--Liew v4 concerns asymptotic shuffle indices and controlled finite-user numerical accounting. These statements do not by themselves supply Theorem E2. No worldwide-priority conclusion follows from this bounded search.

The accompanying standard-library verifier builds exact channels, computes full blanket laws from row minima, and tests every stop-loss breakpoint of selected one- and two-user examples. It also verifies the displayed second-moment identity and the equal-mean counterexample. Finite diagnostics do not prove the general theorem.

# 9. Actual shuffling and homogeneous discarded coordinates

The following sections use actual uniformly shuffled whole-row reports. Write the directed hockey-stick divergence as $\delta_\lambda(P,Q)=\sum_h(P(h)-\lambda Q(h))_+$, $\lambda\ge1$. For two neighboring pairs compared on nested differing-coordinate sets $D\subseteq E$, suppose each coordinate $j\in E\setminus D$ has one common label $x_j$ across all background users and the baseline user's input. The two pairs agree on the retained inputs. On the actual $E$ experiment, replace in every reported row each discarded coordinate by a fresh independent sample from $R_j(x_j,\cdot)$. This kernel has no dependence on the identity of the changed row and commutes with row permutations. On either side of the pair, its output has the $D$ law, since retained and refreshed attributes remain independent before shuffling. Thus the $D$ experiment is a postprocessing of the $E$ experiment. Both directed divergences are no larger, by data processing. The next section shows that a fixed-background comparison can fail if the discarded coordinate is heterogeneous.

# 10. Fixed-background comparison and Blackwell incomparability

Take binary attributes, both with the same randomized-response odds $t>1$. Shuffle whole reports from $n$ users and compare input $00$ for a designated user to either $10$ (experiment $D$) or $11$ (experiment $E$), with exactly the same known background multiset for both comparisons. Writing labels $00,01,10,11$ as $0,1,2,3$, let $b_i$ count background users of each type. For the actual shuffled-output laws denote total variation by $V_D,V_E$. The following sign law holds for each fixed background as $t\to\infty$:
$$
 V_D-V_E=\frac{2\min(b_0,b_3)+b_1-b_0}{t}+O_n(t^{-2}).
$$
Thus whenever the numerator is positive, enlarging the difference set **lowers** the exact zero-threshold privacy loss. This happens for every $n\ge2$, including genuinely heterogeneous backgrounds for every $n\ge3$: use one $01$ and $n-2$ copies of $10$. For other backgrounds, e.g. all $00$, the numerator is negative. The sign depends on the background even for homogeneous local budgets. Furthermore the violating experiments are Blackwell incomparable; increasing the difference set can strictly raise or strictly lower the hockey-stick divergence on different privacy thresholds for the same fixed database.

## 10.1. Proof of the all-size formula

A shuffled histogram is sufficient: given the counts, all possible ordered shuffled reports have the same conditional law under either hypothesis. Let $a=b+e_0$, $d=b+e_2$, $e=b+e_3$ be the noiseless histograms. Each bit flips independently with probability $p=(t+1)^{-1}$. The total probability of two or more flips is $O_n(p^2)$. For each hypothesis with noiseless histogram $h$, a one-flip histogram $h-e_i+e_j$, $i,j$ adjacent in the binary square, has probability $h_i p+O_n(p^2)$. Distinct oriented moves have distinct count increments. At $h$ the mass is $1-O_n(p)$; counts outside this list have total $O_n(p^2)$. Dropping such contributions when summing the minima of the two laws incurs $O_n(p^2)$.

The histograms $a,d$ have opposite parity of total bit weight. Hence their one-flip neighborhoods do not intersect. The first-order overlap $1-V_D$ comes from $a,d$ themselves and is $(b_0+b_2+2)p+O_n(p^2)$. For $a,e$, neither noiseless histogram is reachable by a single flip from the other. A common one-flip histogram is, for $j=1,2$, either
$$
 a-e_0+e_j=e-e_3+e_j,\qquad a-e_j+e_3=e-e_j+e_0.
$$
The latter occurs only if $b_j>0$. Exhaustion follows by equating the positive and negative unit count vectors for an $a$-move and an $e$-move: they must form a length-two path $0,j,3$ with its moves performed in either temporal order. These histograms are distinct. Their overlap coefficients are respectively $\min(b_0+1,b_3+1)$ and $b_j$. Subtract the two overlaps and use $p=t^{-1}+O(t^{-2})$.

For any $n$ and any background, the one-coordinate input likelihood ratio before shuffling is at most $t$, hence $D$ has hockey-stick divergence zero at $\lambda=t$ by data processing. In $E$ the event that every report is $00$ has positive probability on both sides and likelihood ratio $t^2$, since all background factors cancel. Thus $E$ has strictly positive divergence there. Combine this with $V_D>V_E$ at $\lambda=1$ to rule out postprocessing in either direction. Continuity gives strict differences in intervals of thresholds as well.

## 10.2. Exact finite threshold for two users

With the other user fixed at $01$,
$$
 V_D=\frac{t^2(t-1)(t+3)}{(t+1)^4},\qquad
 V_E=\frac{(t-1)(t+1)(t^2+t+1)}{(t+1)^4}.
$$
Indeed, putting $r_i(y)=t^{2-\operatorname{Ham}(i,y)}$, an unordered histogram $\{u,v\}$ under designated input $i$ has numerator $[r_i(u)r_1(v)+r_i(v)r_1(u)]/(1+\mathbf1_{u=v})$ over $(t+1)^4$. For $D$, the positive part of the signed numerator is supported on $00,01,03,11$ (pairs of the labels 0–3); its four masses are $t^2(t-1),t(t-1)(t^2+1),t(t-1)^2,t^2(t-1)$. For $E$, the positive pairs are $00,01,02$, with masses $t(t^2-1),t^2(t^2-1),t^2-1$. Summing gives the formulas. The sign reverses precisely at $t=1+\sqrt2$. For smaller $t>1$ this TV test favors $E$; no claim of Blackwell comparability there is needed.

# 11. Global exact counterexamples and the final interval

Su–Cheng–Wang §7 explicitly ask about maximization over *all* neighboring databases and allude to homogeneous background records distinct from the changed records. Their §8 question concerns a different blanket bound. The fixed-background nonmonotonicity of §10 does not decide either separate global maximum. Here are exact global results for the actual shuffled laws, in the directed hockey-stick convention $\delta_\lambda(P,Q)=\sum_h(P(h)-\lambda Q(h))_+$, $\lambda=e^\epsilon$.

## 11.1. Exhaustive three-user cases

Each user reports two binary attributes via independent randomized response, and the three entire rows are uniformly shuffled. Index records by integers $0,1,2,3$, with coordinate numbered zero having odds $t_0$. Relabel each attribute so that the designated user's baseline is 0. Write $D$ for its alternative and $b$ for the unordered common background pair. The following maximizations exhaust every ordered neighboring database, including alternative-to-baseline orders by the same relabeling.

| $(t_0,t_1),\lambda$ | all global maximizers $(D,b)$ in normalized labels | global divergence | comparison |
|---|---|---:|---:|
| $(3,3),33/10$ | $(3,(0,1)), (3,(0,2))$ | $2403/20480$ | best homogeneous background $4617/40960$ |
| $(2,5),11/10$ | $(2,(1,1))$ | $223/486$ | best full Hamming change $41/90$ |
| $(2,5),99/10$ | $(3,(0,0))$ | $5/2916$ | runner-up $5/5832$ |

Thus equal local odds already force a strictly heterogeneous worst background at some privacy threshold. With unequal odds, differing in every attribute can be strictly suboptimal even *after separately optimizing each difference pattern over all backgrounds*. For this same fixed local channel and fixed $n=3$, no neighboring database can attain the entire worst-case privacy profile. Strict separations persist in open neighborhoods of the displayed channel parameters and thresholds by continuity and finiteness.

## 11.2. Exact enumeration

On output $y$, the local row with input $x$ has numerator $r_x(y)=\prod_{j=0,1}t_j^{\mathbf1_{x_j=y_j}}$, denominator $Z=(1+t_0)(1+t_1)$. For a histogram $h$ of three reports, let $\operatorname{Ord}(h)$ be its distinct orderings. Its numerator under database $(x,b_1,b_2)$ is
$$
 N_{x,b}(h)=\sum_{(u,v,w)\in\operatorname{Ord}(h)}
       r_x(u)r_{b_1}(v)r_{b_2}(w).
$$
There are twenty histograms; conditional on each, the final shuffled ordering is uniform under every database. There are ten background types and three nonzero alternatives after bit relabeling. For $\lambda=L/M$, sum the twenty integers $(M N_{0,b}(h)-L N_{D,b}(h))_+$ and divide by $MZ^3$. Evaluating the stated thirty possibilities gives the table; the second strictly smaller values in its first two rows are $2391/20480$ and $41/90$. The accompanying standalone verifier generates all terms, checks the twenty underlying probabilities sum to one for every database and computes the indicated restricted as well as unrestricted extrema. [Exact Python verifier, SHA-256 27c12ee7867b74c653f315227f09f7b736564b16a8a73ae1f505244a4f7e0e49](evidence/r02/global_profile.py)

## 11.3. All sample sizes near the upper privacy endpoint

Let there be any finite product of categorical RR mechanisms, each alphabet size $k_j\ge2$ and finite odds $t_j>1$. Write $T=\prod_j t_j,\ c=\prod_j(t_j+k_j-1)^{-1}$. For every finite $n$ there exists $\lambda_0<T$ such that on $(\lambda_0,T)$ the exact global hockey-stick profile is
$$
 \sup_{x,x',b}\delta_\lambda=c^n T^{\,n-1}(T-\lambda).
$$
Its only maximizing types have all coordinates changed and every common background input equal to the designated baseline $x$. To prove this, the likelihood ratio at a shuffled histogram is a convex combination of the local likelihood ratios $R_x(y)/R_{x'}(y)$ over every output row present: group the denominator probability by which report came from the designated user. All weights are strictly positive. The ratio attains $T$ exactly for a full-coordinate replacement with all reported records equal to $x$. All other ratios in the finite model admit a common upper bound strictly below $T$. In this final interval only the said histogram contributes. Its probability on the alternative side is $c\prod_{i=1}^{n-1}R_{b_i}(x)$, uniquely maximized by every $b_i=x$. This proves the formula. It does not locate the other profile breakpoints for general $n$.

# 12. Comparison with actual-privacy results

Su–Cheng–Wang §7 describes a common homogeneous background on a third label as a possible worst-case class for many mechanisms and asks whether a single neighboring pair realizes the privacy profile. Section 8 concerns the blanket bound instead. Shvets v2 Theorem D.3 bounds homogeneous contamination, and Proposition D.5 gives a three-user one-coordinate ternary randomized-response example where an uneven background exceeds a binary comparison envelope. For the same ternary channel in that proposition its value $5/32$ ties a homogeneous background at the third label, as a direct enumeration of the six unordered background types confirms. The two-coordinate comparisons above instead optimize all alternatives and backgrounds for a single fixed product mechanism. The first row of the table exceeds every homogeneous background, and the other two rows force distinct optimizers at two thresholds. The final interval gives the global maximizing type for each finite sample size. A full description of earlier breakpoints for general parameters remains open. [Su–Cheng–Wang, §§7–8](https://arxiv.org/html/2504.07414v6) · [Shvets v2, Appendix D](https://arxiv.org/html/2603.21197v2)

The original reproduction guide separates the rational blanket comparisons, the archived kernel scope of the original blanket theorem, and the published source versions. The new actual-shuffle results use explicit three-user enumeration and the exact probability arguments above. Lean verification of this complete manuscript is delivered separately. [Original reproduction guide](evidence/README.md)

# References

1. Pengcheng Su, Haibo Cheng, and Ping Wang. *Decomposition-Based Optimal Bounds for Privacy Amplification via Shuffling*. arXiv:2504.07414v6 (2025); IEEE Symposium on Security and Privacy 2026. [Fixed version](https://arxiv.org/abs/2504.07414v6). Relevant locations: Definition 9, Theorem 13, and Section 8.
2. Borja Balle, James Bell, Adrià Gascón, and Kobbi Nissim. *The Privacy Blanket of the Shuffle Model*. CRYPTO 2019. [arXiv:1903.02837](https://arxiv.org/abs/1903.02837).
3. Alex Shvets. *Anchored Likelihood-Ratio Geometry of Anonymous Shuffle Experiments: Exact Privacy Envelopes and Universal Low-Budget Design*. [arXiv:2603.21197v1](https://arxiv.org/abs/2603.21197v1), 2026. Preprint; Section 4, especially Lemmas 4.6 and 4.8 and Theorem 4.9.
4. Shun Takagi and Seng Pei Liew. *Analysis of Shuffling Beyond Pure Local Differential Privacy*. [arXiv:2601.19154v4](https://arxiv.org/abs/2601.19154v4), 2026. Preprint; finite-user versus asymptotic scope is discussed in the introduction.
5. Alex Shvets. *The Critical Rényi Order for Sharp Minimax Channel Design*. [arXiv:2603.21197v2](https://arxiv.org/abs/2603.21197v2), 24 October 2026. Preprint; Appendix D, Theorem D.3 and Proposition D.5. This is the retitled and rewritten version of [3].

## Sources for the equal-density extension

1. P. Su, H. Cheng and P. Wang, *Decomposition-Based Optimal Bounds for Privacy Amplification via Shuffling*, [arXiv:2504.07414v6](https://arxiv.org/html/2504.07414v6), Definition 9, Theorem 13, Section 8, Appendix A.2--A.3; current version record reopened 25 November 2026.
2. B. Balle, J. Bell, A. Gascon and K. Nissim, *The Privacy Blanket of the Shuffle Model*, [arXiv:1903.02837](https://arxiv.org/pdf/1903.02837), CRYPTO 2019.
3. A. Shvets, *The Critical Renyi Order for Sharp Minimax Channel Design*, [arXiv:2603.21197v2](https://arxiv.org/html/2603.21197v2), Appendix D, Theorem D.3 and Proposition D.5.
4. S. Takagi and S. P. Liew, *Analysis of Shuffling Beyond Pure Local Differential Privacy*, [arXiv:2601.19154v4](https://arxiv.org/html/2601.19154v4), Sections 3--4 and Appendix C.2.
5. A. H. Tchen, *Inequalities for Distributions with Given Marginals*, Annals of Probability 8(4) (1980), 814--827, DOI [10.1214/aop/1176994668](https://doi.org/10.1214/aop/1176994668). Historical attribution only: [author technical-report record](https://statistics.stanford.edu/technical-reports/inequalities-distributions-given-marginals) was accessible, its linked full text returned 403, and the publisher full-text endpoint returned an iframe without extractable theorem text. Lemma E1 has an independent elementary proof.
