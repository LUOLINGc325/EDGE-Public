# Precise independent e-merging beyond reordered martingales

*Monotone counterexamples and sharp capital gaps*

AI-assisted research draft prepared for Wen Weixiang

24 November 2026

# Abstract

We give negative answers to Questions 3 and 4 in Section 7 of Vovk and Wang's *Merging sequential e-values via martingales* [1]. Already for two inputs, a continuous, symmetric, coordinatewise nondecreasing, precise independent-e-value merger need not be dominated by any generalized martingale merger, even when arbitrary randomized reading orders and betting rules are allowed. The elementary example is
$$
 F(x,y)=1+(x-1)_+(y-1)_+-(1-x)_+(1-y)_+.
$$
Every unit-capital generalized martingale merger satisfies a positive three-point inequality which this example violates by the rational gap $17-15$. For its mixture $F_\lambda=1-\lambda+\lambda F$, the largest universally achievable multiplicative factor is exactly $2/(2+\lambda)$. The corresponding minimum capital is $1+\lambda/2$. For products over disjoint pairs, these costs multiply, even when the competing strategy adaptively interleaves observations across all pairs. We also give real-analytic, strictly increasing precise counterexamples. The results concern the full read-once generalized class of [1], not all martingales built from richer data or a specified null law. They establish a structural separation, without asserting uniform testing-power improvement over the product merger.

**Status.** Research draft containing written proofs and descriptions of finite exact certificates. It has not undergone external peer review or end-to-end formal verification.

# 1. Problem, definitions, and contribution

An **e-variable** is a finite nonnegative random variable $X$ with $\mathbb E X\le1$. A Borel function $T:[0,\infty)^K\to[0,\infty)$ is an **independent-e-value merger**, or **ie-merger**, when
$$
 \mathbb E T(X_1,\ldots,X_K)\le1
$$
for every collection of independent e-variables. It is **precise** in the sense of [1, Section 7, Question 4] if the displayed expectation equals one whenever every input has mean one. This is exactness for every such product law, not merely attainment of a supremum over laws. Pointwise admissibility means that no other ie-merger is everywhere at least as large and strictly larger at some point.

We use exactly the generalized martingale class in [1, Section 6]. A strategy selects an unread coordinate using only the observations already revealed and its independent random seed. Before seeing the selected value $x$, it chooses a fraction $s\in[0,1]$, and multiplies its current wealth by
$$
 1+s(x-1).
$$
Each coordinate is read once. Zero stakes include skipping a bet or stopping while reading the remaining coordinates at zero stakes. A generalized merger is an arbitrary probability mixture of terminal wealth functions. The reading strategy and stakes may be dependent through their common seed. The original definition permits initial wealth at most one. All lower bounds below explicitly cover that convention.

For a nonnegative target $T$, define its generalized-martingale capital cost by
$$
 \mathcal C(T)=\inf\{C\ge0:\text{a generalized strategy of initial capital }C
                    \text{ has terminal mixture }G\ge T\}.
$$
Allowing random initial allocations with average $C$ gives the same class after weighting the mixture by those allocations. A cost above one means that no ordinary unit-capital generalized merger dominates the target. Equivalently, the largest achievable factor $c$ in $G\ge cT$, with unit capital, is $1/\mathcal C(T)$ for the targets considered here.

The paper [1] already gives a discontinuous, nonmonotone ie-merger outside this generalized class. It leaves open whether monotonicity restores domination (Question 3), or whether precision restores representation (Question 4). Both questions remain listed in the author's revision dated 4 April 2026 [1a]. Our counterexample satisfies both additional requirements simultaneously. The new quantitative conclusions are exact whole-domain costs, positive finite witnesses, and their multiplication under arbitrary adaptive interleaving.

# 2. A precise monotone counterexample

For $0<\lambda\le1$, let
$$
 F_\lambda(x,y)=1+\lambda\big[(x-1)_+(y-1)_+-(1-x)_+(1-y)_+\big],
 \qquad x,y\ge0.                                      \tag{2.1}
$$
Here $r_+=\max\{r,0\}$, and $F=F_1$.

**Theorem 2.1.** Every $F_\lambda$ is continuous, symmetric, nonnegative, coordinatewise nondecreasing, precise, and pointwise admissible as an ie-merger. No unit-capital generalized martingale merger dominates $F_\lambda$.

The probability and regularity claims are proved in this section. Non-domination follows in Section 3, independently of admissibility.

## 2.1. Pointwise properties

The equivalent expressions on the closed quadrants are
$$
F_\lambda(x,y)=
\begin{cases}
 1-\lambda(1-x)(1-y),&0\le x,y\le1,\\
 1,&x\le1\le y\text{ or }y\le1\le x,\\
 1+\lambda(x-1)(y-1),&x,y\ge1.
\end{cases}                                             \tag{2.2}
$$
They agree at every boundary. The lower-square expression belongs to $[1-\lambda,1]$; the remaining expressions are at least one. For fixed $y\le1$, the function increases with slope $\lambda(1-y)$ up to $x=1$ and is constant afterwards. For fixed $y\ge1$, it is constant up to one and increases with slope $\lambda(y-1)$ afterwards. This proves all stated pointwise properties.

Moreover,
$$
 0\le F_\lambda(x,y)\le1+xy.                            \tag{2.3}
$$
Consequently it is integrable for all independent e-variables, including unbounded inputs: Tonelli gives $\mathbb E[XY]=\mathbb E X\,\mathbb E Y\le1$.

## 2.2. Validity and precision

Write
$$
 a_X=\mathbb E(1-X)_+,\qquad b_X=\mathbb E(X-1)_+,
$$
and define $a_Y,b_Y$ similarly. These quantities are finite and nonnegative. The identity
$$
 b_X-a_X=\mathbb E X-1
$$
implies $b_X\le a_X$ when $\mathbb E X\le1$. Independence therefore gives
$$
 \mathbb E F_\lambda(X,Y)
 =1+\lambda(b_Xb_Y-a_Xa_Y)\le1.                         \tag{2.4}
$$
If both means equal one, then $a_X=b_X$ and $a_Y=b_Y$, so (2.4) equals one. This establishes validity and precision on the full domain.

## 2.3. Admissibility: an attributed standard lemma

Precision implies ie-admissibility by Ramdas and Wang [2, Proposition 8.6]. We include the argument to make the quantifiers explicit; this implication is a known result, not a novelty claim of this paper.

Every finite $x\ge0$ can be given positive mass by a nonnegative mean-one variable. If $x=1$, use the constant one. If $x>1$, give $x$ probability $1/x$ and zero the remaining probability. If $x<1$, use $x$ and 2 with respective probabilities $1/(2-x)$ and $(1-x)/(2-x)$. Independently constructing such variables for any specified input vector gives that vector positive probability under an exact product null.

If an ie-merger $H$ dominates a precise ie-merger $T$, validity and precision yield
$$
 1=\mathbb E T\le\mathbb E H\le1.
$$
The nonnegative difference must vanish at every prescribed positive-mass point. Thus $H=T$ everywhere. Applying this to $F_\lambda$ proves admissibility.

# 3. A positive three-point separation certificate

**Lemma 3.1.** Let $G$ be the mixture terminal wealth of a two-input generalized strategy with average initial capital $m\ge0$. For every $t>1$,
$$
 G(t,t)+t(t-1)\{G(0,1)+G(1,0)\}\le mt(2t-1).          \tag{3.1}
$$

**Proof.** Let $A$ be the mean amount of initial capital wagered on $x$, assigning zero to seeds that first read $y$; let $B$ be the analogous quantity for $y$. Since neither input has yet been observed, these quantities are fixed across the three input points. They satisfy $A,B\ge0$ and $A+B\le m$.

At $(0,1)$, an $x$-first strategy loses its first wager and cannot gain on the remaining value one. A $y$-first strategy cannot increase its initial capital at either step. Hence
$$
 G(0,1)\le m-A,\qquad G(1,0)\le m-B.                   \tag{3.2}
$$
At $(t,t)$, the first-round mean wealth is $m+(A+B)(t-1)$. The second wager increases any nonnegative wealth by a factor at most $t$. Thus
$$
 G(t,t)\le mt+(A+B)t(t-1).                             \tag{3.3}
$$
Multiply (3.2) by $t(t-1)$ and add (3.3). The $A+B$ terms cancel, giving (3.1). The reasoning applies to arbitrary mixtures and to initial capital below one; all payoffs at each fixed input are bounded by a finite multiple of the initial capital. $\square$

All coefficients in (3.1) are nonnegative. Therefore it tests pointwise domination directly, not merely equality or membership. For unit capital, $t=3$, and $\lambda=1$,

| Input | $F$ | Coefficient in (3.1) |
|:---|---:|---:|
| $(0,1)$ | 1 | 6 |
| $(1,0)$ | 1 | 6 |
| $(3,3)$ | 5 | 1 |

The candidate's weighted sum is 17; the largest permitted generalized-strategy sum is 15. For general $\lambda>0$, taking $t>1+1/\lambda$ gives
$$
 1+\lambda(t-1)^2+2t(t-1)>t(2t-1).
$$
This proves non-domination for every $F_\lambda$, and therefore answers both questions in Theorem 2.1 negatively. Only three rational points are needed for the explicit $\lambda=1$ certificate.

# 4. Exact whole-domain and finite-domain costs

**Theorem 4.1.** For $0<\lambda\le1$,
$$
 \mathcal C(F_\lambda)=1+\frac\lambda2,
 \qquad c_\lambda=\frac{2}{2+\lambda}.                 \tag{4.1}
$$
The optimal multiplicative factor is attained by a generalized merger.

**Lower bound on cost.** If a unit-capital $G$ satisfies $G\ge cF_\lambda$, then (3.2) gives $A,B\le m-c$. Dividing (3.3) by $t^2$ and taking $t\to\infty$ gives $c\lambda\le A+B$. Therefore
$$
 c\lambda\le2(m-c)\le2(1-c),
$$
which implies $c\le2/(2+\lambda)$.

**Attainment.** Set $a=\lambda/(2+\lambda)$, $u=x-1$, $v=y-1$, and
$$
 M_\lambda(x,y)=1+a(u+v)+a(u_+v+v_+u).                 \tag{4.2}
$$
Choose each reading order with probability one half. Wager the initial fraction $2a$, then, after seeing the first value $z$, wager
$$
 g_\lambda(z)=\frac{2\lambda(z-1)_+}{2-\lambda+2\lambda z}. \tag{4.3}
$$
The denominator is positive. If $z\le1$, the fraction is zero; if $z>1$, subtracting its numerator from its denominator gives $2+\lambda>0$. Thus it lies in $[0,1]$. Averaging the two orders gives (4.2) exactly.

Put $c=2/(2+\lambda)$. The identities $1-c=a$ and $c\lambda=2a$ give the following nonnegative gaps:

| Region | $M_\lambda-cF_\lambda$ |
|:---|:---|
| $u,v\ge0$ | $a(1+u+v)$ |
| $u\ge0,\ v=-b,\ 0\le b\le1$ | $a(1-b)(1+u)$ |
| $v\ge0,\ u=-b,\ 0\le b\le1$ | $a(1-b)(1+v)$ |
| $u=-b,\ v=-d,\ 0\le b,d\le1$ | $a[(1-b)(1-d)+bd]$ |

This proves $M_\lambda\ge cF_\lambda$ everywhere. Scaling the initial capital by $1/c$ proves attainment in (4.1). $\square$

**Proposition 4.2 (exact finite witness cost).** On only the three points $\mathcal T_t=\{(0,1),(1,0),(t,t)\}$, the minimum capital is
$$
 C_{t,\lambda}=\max\left\{1,
 \frac{1+\lambda(t-1)^2+2t(t-1)}{t(2t-1)}\right\}.      \tag{4.4}
$$

**Proof.** The axis targets equal one, and a strategy cannot gain capital on inputs zero and one, so capital must be at least one. Lemma 3.1 gives the second lower bound. If it is at most one, start with one, stake zero first, and stake one second precisely when the first observation equals $t$. This gives values $1,1,t$, which cover the targets.

Otherwise write $C=C_{t,\lambda}>1$. Start with $C$, choose each order with probability one half, and stake the first fraction $q=2(C-1)/C$. The bound $C\le1+\lambda/2\le3/2$ ensures $q\in[0,1]$. Set the second fraction to zero after observing one and to one after observing $t$; elsewhere it can be zero. Each axis payoff is $C-Cq/2=1$. The diagonal payoff is
$$
 Ct+2(C-1)t(t-1)=1+\lambda(t-1)^2.
$$
This attains all constraints. To check the stated capital bound directly, subtract the numerator in (4.4) from $(1+\lambda/2)t(2t-1)$. The result is $(1+3\lambda/2)t-(1+\lambda)>0$ for $t>1$. $\square$

In particular $C_{3,1}=17/15$, while $C_{t,\lambda}\to1+\lambda/2$. The finite-domain optimizer is not claimed to dominate the target outside $\mathcal T_t$.

# 5. Multiplication of the gap despite adaptive interleaving

Let $n\ge1$, $0<\lambda_j\le1$, and define
$$
 P_{\boldsymbol\lambda}(x_1,\ldots,x_{2n})
   =\prod_{j=1}^nF_{\lambda_j}(x_{2j-1},x_{2j}).         \tag{5.1}
$$
It is continuous, nonnegative, coordinatewise nondecreasing, and precise under independence of all $2n$ inputs. By the known lemma in Section 2.3 it is admissible. It is invariant under swapping coordinates within each pair; when all $\lambda_j$ agree, it is also invariant under permuting pairs. Full symmetry under arbitrary coordinate permutations is not asserted.

**Theorem 5.1.** Even among strategies that adaptively interleave all $2n$ coordinates,
$$
 \mathcal C(P_{\boldsymbol\lambda})
   =\prod_{j=1}^n\left(1+\frac{\lambda_j}{2}\right).      \tag{5.2}
$$

**Upper bound.** Process the pairs successively using the optimal unit-capital strategy from Theorem 4.1, with independent random seeds. The total terminal wealth is $\prod_jM_{\lambda_j}$, a permissible generalized strategy. Its pointwise value is at least $\prod_jc_{\lambda_j}\,P_{\boldsymbol\lambda}$. This proves the stated upper bound on cost.

**Lower bound.** Fix $t>1$, and put
$$
 d=t(t-1),\quad Z=2d+1,\quad B=2d+t=t(2t-1).
$$
Define a probability law $Q_t$ for a pair by giving $(0,1),(1,0),(t,t)$ respective probabilities $d/Z,d/Z,1/Z$. Use independent copies of this *pair law* across the $n$ pairs. The two coordinates inside a pair are dependent. This law is a separating device, not an independent-input null under which (5.1) is claimed to be an e-variable.

For each pair define a remaining-value factor $V$:

| Revealed state of the pair | $V$ |
|:---|---:|
| Neither coordinate read | $B/Z$ |
| One coordinate read, with value 0 or 1 | 1 |
| One coordinate read, with value $t$ | $t$ |
| Both coordinates read | 1 |

If an unread pair is entered with a stake $s\in[0,1]$, either choice of coordinate has
$$
 \mathbb E_{Q_t}[(1+s(X-1))V_{\rm new}]
  =\frac{d(1-s)+d+t(1+s(t-1))}{Z}
  =\frac BZ=V_{\rm old}.                              \tag{5.3}
$$
If a pair has one revealed coordinate, its remaining value is determined. The most the next bet can multiply wealth by is $\max\{1,Y\}=V_{\rm old}$, while $V_{\rm new}=1$. Thus the analogous inequality also holds for completing a pair.

These one-step bounds remain valid under arbitrary adaptive interleaving. Conditional on a fixed random seed and a feasible revealed history, the event specifying that history imposes only the observed coordinate constraints on the original independent pairs. The choices of coordinates and stakes are functions of that same history and do not impose extra constraints on unread values. Consequently the conditional pair laws retain their product form, with each law restricted to its own revealed coordinates. Equivalently, this follows by induction over the finite reveal tree.

If $W$ denotes the current wealth, (5.3) implies that
$$
 W\prod_{j=1}^n V_j
$$
is a supermartingale over the $2n$ reveals. Initially it equals $C(B/Z)^n$; finally it equals the terminal wealth. Conditioning on the strategy seed and then averaging therefore gives
$$
 \mathbb E_{Q_t^{\otimes n}}G\le C(B/Z)^n.              \tag{5.4}
$$
Every variable here is bounded on the finite support by a fixed multiple of initial capital, so no limiting stopping-time or integrability issue is involved.

On the other hand, set
$$
 L_{t,\lambda}=2d+1+\lambda(t-1)^2.
$$
Independence of the pairs gives
$$
 \mathbb E_{Q_t^{\otimes n}}P_{\boldsymbol\lambda}
   =\prod_{j=1}^n\frac{L_{t,\lambda_j}}Z.
$$
If $G\ge P_{\boldsymbol\lambda}$, (5.4) implies
$$
 C\ge\prod_{j=1}^n\frac{L_{t,\lambda_j}}B.
$$
Letting $t\to\infty$, with $n$ fixed, yields (5.2). $\square$

For $\lambda_j=1$, the sharp efficiency is $(2/3)^n$ and the capital cost is $(3/2)^n$. This is an exact family of structural gaps, not a simulation-based rate or a claim about power at a fixed testing threshold.

# 6. Analytic, strictly increasing counterexamples

The separation does not require corners or flat regions. Fix
$$
 0<\varepsilon<1,\qquad
 0<\lambda\le\frac1{\sqrt{1+\varepsilon^2}},\qquad
 h_\varepsilon(x)=\sqrt{(x-1)^2+\varepsilon^2},
$$
and set
$$
 H_{\varepsilon,\lambda}(x,y)
  =1+\frac\lambda2\{(x-1)h_\varepsilon(y)
                         +(y-1)h_\varepsilon(x)\}.      \tag{6.1}
$$

**Theorem 6.1.** This function is real-analytic on a neighborhood of the nonnegative quadrant, symmetric, nonnegative, and strictly increasing in each coordinate. It is a precise admissible ie-merger, and no unit-capital generalized martingale merger dominates it.

**Proof.** With $u=x-1$, $v=y-1$, differentiation gives
$$
 \partial_x H=\frac\lambda2
 \left(\sqrt{v^2+\varepsilon^2}
       +v\frac{u}{\sqrt{u^2+\varepsilon^2}}\right)>0,
$$
since the first square root exceeds $|v|$ and the absolute value of the final fraction is less than one. The same holds for $\partial_y H$. The minimum on the quadrant is therefore
$$
 H(0,0)=1-\lambda\sqrt{1+\varepsilon^2}\ge0.
$$
Analyticity follows because the square-root arguments are strictly positive.

The bound $h_\varepsilon(x)\le x+1+\varepsilon$ makes the products in (6.1) absolutely integrable for independent e-variables. Independence yields
$$
 \mathbb EH(X,Y)=1+\frac\lambda2
 \{(\mathbb EX-1)\mathbb Eh_\varepsilon(Y)
  +(\mathbb EY-1)\mathbb Eh_\varepsilon(X)\}\le1,
$$
with equality when both means are one. Admissibility follows from the attributed lemma.

Finally, $H(0,1)=H(1,0)=1-\lambda\varepsilon/2$ and
$H(t,t)/t^2\to\lambda$. If a unit-capital generalized $G$ dominated $H$, (3.2) would give $A+B\le\lambda\varepsilon$, while (3.3) and the diagonal limit would give $A+B\ge\lambda$. This contradicts $\varepsilon<1$. $\square$

For example $\varepsilon=\lambda=1/2$ gives a strictly positive analytic target on the entire nonnegative quadrant. No exact capital formula for this smoothed family is claimed here.

# 7. Interpretation, related work, and limits

The basic construction exploits the balance of positive and negative deviations from one: an exact e-variable has equal expected surplus and shortfall. Independence allows those expectations to multiply even though no nonanticipating reading order can use the same balance pointwise. The three-point inequality isolates the obstruction in the very first wager; the finite pair-law argument shows that adaptive interleaving cannot remove it.

The original nonmonotone counterexample in [1, Example 4] and its attribution to Zhenyuan Zhang are acknowledged. The rational merger in [1, Example 2] and [2, Example 8.8] lies outside the fixed-order sequential class but is explicitly within the generalized reordered class. Our comparison is against the larger class, not just fixed permutations or symmetric-polynomial mixtures. The admissibility implication is already [2, Proposition 8.6].

Wang [3] and Clerico [4] characterize merging under arbitrary dependence, whose null class differs from the independent product class here. Ming et al. [5] study maximal tail bounds for combining independent or co-valid e-values into p-values; those results do not provide the precise ie-merger representation asserted in Questions 3 and 4. The source-by-source comparison and search limitations are recorded separately. Failure to locate an equivalent result is not a proof of worldwide priority.

A structural non-domination theorem should not be read as uniform power superiority. For the basic $F=F_1$, if $F(x,y)>1$, then both inputs exceed one and
$$
 F(x,y)=xy-x-y+2\le xy.
$$
Thus its rejection set at every threshold above one is contained in that of the product. The precise methods constructed here answer the mathematical completeness questions; selecting a practically preferable method requires a specified alternative, objective, or downstream use.

The results also do not contradict complete-class statements for martingales constructed from richer observations, an explicitly specified null distribution, or broader trading protocols. The comparator throughout is the universal, fraction-constrained, read-once e-value-merging class defined in [1].

# 8. Verification and reproducibility

The written proofs cover all finite nonnegative inputs, all independent e-variable laws with the required means, arbitrary strategy mixtures, and every finite number of disjoint pairs. Exact rational scripts check the finite certificate, the explicit attaining strategy, the quadrant identities, finite-witness optimal costs, and a finite-state dynamic program for interleaved pairs. These finite checks supplement the universal proofs; they do not replace them.

The accompanying Lean file verifies selected deterministic algebraic lemmas and separation certificates under the hypotheses displayed in that file. It does not formalize general probability spaces, arbitrary strategy-mixture measures, the asymptotic passage, real-analytic regularity, or Theorem 5.1 for every $n$. The Lean source and build evidence are not included in this version; no new compilation is claimed. The computational programs and raw outputs are also not included.

# References

1. V. Vovk and R. Wang (2024). *Merging sequential e-values via martingales*. Electronic Journal of Statistics **18**, 1185–1205. DOI: [10.1214/24-EJS2228](https://doi.org/10.1214/24-EJS2228). [Published full text](https://pure.royalholloway.ac.uk/ws/portalfiles/portal/61949496/24-EJS2228.pdf). Section 6, equations (18)–(22), and Section 7, Questions 3–4.
2. A. Ramdas and R. Wang (2025). *Hypothesis Testing with E-values*. Author version dated 11 November 2025. [Full text](https://sas.uwaterloo.ca/~wang/files/e-book-final.pdf). Sections 8.2–8.3, especially Proposition 8.6 and Example 8.8.
3. R. Wang (2025). *The only admissible way of merging arbitrary e-values*. Biometrika **112**(2), asaf020. DOI: [10.1093/biomet/asaf020](https://doi.org/10.1093/biomet/asaf020).
4. E. Clerico (2026). *A simple geometric proof for the characterisation of e-merging functions*. Statistics & Probability Letters **236**, 110750. DOI: [10.1016/j.spl.2026.110750](https://doi.org/10.1016/j.spl.2026.110750). Arbitrary-dependence comparator.
5. J. Ming, A. Ramdas, Y. Shen, R. Wang, and I. Waudby-Smith (2026). *Combining e-values using demi-supermartingales*. [arXiv:2603.10329v4](https://arxiv.org/abs/2603.10329v4), dated 20 October 2026.

**[1a] Current author revision.** V. Vovk and R. Wang, Working Paper 5, last revised 4 April 2026. [Full text](https://alrw.net/e/05.pdf). The original Section 7 Questions 3 and 4 are retained. Accessed 24 November 2026.
