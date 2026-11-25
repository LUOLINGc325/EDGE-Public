# Randomized post-hoc admissibility for arbitrary sets of stakes

*A complete criterion using conditional means and Neyman–Pearson gaps*

## 1. Framework and characterization

We study the randomized $\mathbf C$-admissibility question of Chugg, Lardy, Ramdas and Grünwald (2026), §5.3, for mutually absolutely continuous simple hypotheses $P,Q$. Write $R=dQ/dP$. The set $\mathcal L\subset(0,\infty)$ consists of the available false-rejection losses, called stakes. Let $S=\overline{\mathcal L\cup\{0\}}$ as a closed subset of $[0,\infty)$ and $B=\sup S>1$, possibly infinite.

We use the source's convention that a safe family of rejection probabilities has a measurable envelope $\sup_bL_b(0,1)\delta(X,b)$ of $P$ mean at most one. A canonical family from evidence $E$ rejects with probability $\min(1,E/t)$ at stake $t$. Each safe family is dominated pointwise by the canonical family of its own envelope, and that replacement is safe. Thus the classification is equivalent to comparing canonical evidence variables $E\ge0$, $\mathbb E_PE\le1$, with $E\le B$ when $B<\infty$. Truncation at $B$ leaves all rejection probabilities unchanged. Write
$$
M_E(t)=\mathbb E_Q\min(E,t).
$$
The absence of a competing safe variable raising these moments weakly at all $t\in\mathcal L$ and strictly at one of them is $\mathbf C$-admissibility. This uses strictly positive false-retention costs as in the source.

Let $H=\mathbb E_P[E\mid R]$. For a bounded complementary interval $(a,b)$ of $S$, define its normalized fill
$$
\psi_{a,b}(H)=\frac{\min(H,b)-\min(H,a)}{b-a}.
$$

**Theorem.** The canonical family of $E$ is $\mathbf C$-admissible if and only if the following conditions hold.

1. $\mathbb E_PE=1$.
2. $M_E(t)=M_H(t)$ for every $t\in\mathcal L$.
3. $H$ is almost surely a nondecreasing function of $R$.
4. For every bounded complementary interval $(a,b)$ of $S$, $\psi_{a,b}(H)$ is a Neyman–Pearson optimal test at its own $P$ expectation. Specifically it maximizes $\mathbb E_Q\psi$ over all $0\le\psi\le1$ with the same $P$ expectation.

The theorem applies to finite, dense, and accumulating sets, including unbounded $\mathcal L$. Condition 2 is exact equality in conditional Jensen for each allowed cap. Indeed, the conditional Jensen difference is nonnegative under $P$, and $R>0$ almost surely. Thus equality of the unconditional capped $Q$ moments is equivalent, at each $t$, to the conditional law of $E$ given $R$ being supported on one side of $t$, including the possibility of equality at $t$.

## 2. Necessity

If $\mathbb E_PE<1$, add a sufficiently small positive constant and truncate at $B$ when it is finite. Some allowed cap $t$ satisfies $P(E<t)>0$: otherwise a countable sequence of allowed stakes approaching $B$ would give $E\ge B>1$ almost surely. Hence the new evidence strictly raises some cap and never lowers any cap. This forces condition 1.

Conditional Jensen gives $M_H(t)\ge M_E(t)$ for every finite $t$, because $R$ is measurable with respect to itself. The $P$ budget is unchanged. Thus condition 2 is necessary and, once it holds, $E$ and $H$ have identical admissibility status.

To prove condition 3, let $\beta(s)=P(H>s)$. At every $s$, choose the Neyman–Pearson threshold test $v_s(r)$ of exact size $\beta(s)$, constant in $r$ on its cutoff atom. For $0<\beta(s)<1$, take the lower quantile at $1-\beta(s)$, fill above the cutoff, and use the exact residual allocation at the cutoff when it has positive mass. For sizes zero and one use the constant tests. Quantiles as functions of probability are monotone and hence Borel; the cutoff randomization coefficient is a Borel function of the size and of the cutoff through the distribution function and its left limit. Therefore $(s,r)\mapsto v_s(r)$ is measurable. Evidence
$$
\widetilde E=\int_0^B v_s(R)\,ds
$$
has $P$ mean $\mathbb E_PH$ by Tonelli. It is almost surely finite even when $B=\infty$. Pointwise $\min(\widetilde E,t)\ge\int_0^t v_s(R)\,ds$ for $t\le B$, since $v_s\in[0,1]$. Optimizing each entry in this integral gives
$$
M_{\widetilde E}(t)-M_H(t)
\ \ge\ \int_0^t\left(\mathbb E_Qv_s(R)-Q(H>s)\right)\,ds\ \ge0.
\tag{1}
$$
If $H$ is admissible, these nonnegative integrals vanish for every allowed $t$. A countable sequence of caps approaching $B$ shows that $\mathbf 1_{\{H>s\}}$ is individually optimal for almost every $s\in(0,B)$. Equality in the Neyman–Pearson comparison forces agreement with $v_s$ off the cutoff. On the cutoff $\mathbf 1_{\{H>s\}}$ is constant since $H$ is measurable in $R$. Equal test sizes then force equality there as well. Fubini gives $H=\widetilde E$ almost surely. The latter is a nondecreasing function of $R$, as each $v_s$ is nondecreasing.

Finally suppose a gap fill is suboptimal. Put $u=\min(H,b)-\min(H,a)$. Replace it by an alternative $u'\in[0,b-a]$ with the same $P$ expectation and larger $Q$ expectation. Keep the other increments and define
$$
E'=\min(H,a)+u'+(H-b)_+.
$$
The budget is unchanged. For $t\le a$, $\min(E',t)\ge\min(H,t)$. For $t\ge b$, the quantity $\min(H,a)+u'+\min((H-b)_+,t-b)$ is at most both $E'$ and $t$. Its $Q$ expectation strictly exceeds $M_H(t)$, since for $u$ in place of $u'$ it equals $\min(H,t)$ pointwise. There are no allowed caps inside the gap. The upper endpoint $b$ is in $S$ and some allowed $t>a$ exists. Equivalently, the continuous capped advantage is strictly positive at $b$ and hence at a nearby allowed cap. Therefore condition 4 is necessary.

## 3. Sufficiency

By condition 2, replace $E$ by $H=h(R)$ with $h$ nondecreasing. Let $E'$ weakly dominate at each stake, with $\mathbb E_PE'\le1$ and $E'\le B$ if $B<\infty$. Denote the upper cuts by $A_t=\{H>t\}$ and $D_t'=\{E'>t\}$, and set
$$
F(t)=Q(D_t')-Q(A_t),\quad
D(t)=P(D_t')-P(A_t),\quad
C(t)=M_{E'}(t)-M_H(t)=\int_0^tF(s)\,ds .
$$
The continuous function $C$ is nonnegative on $S$. Also $\int_0^\infty |D|\le2$ by the $P$ budget.

### Choosing the likelihood-ratio cutoffs

On $S$ give a proper nontrivial $A_t$ the threshold $c(t)=\operatorname{ess\,inf}_{A_t}R$, with respect to $P$. Use $c(t)=0$ for $A_t$ full and $c(t)=\infty$ for $A_t$ null. A proper nontrivial cut of the nondecreasing $h$ separates ratios by this value and it is positive and finite. If $B<\infty$, take $c(t)=\infty$ for $t>B$.

On a bounded complementary gap $(a,b)$, choose a single cutoff for its whole interior. A gap fill almost surely one gives $c=0$, and a gap fill almost surely zero gives $c=\infty$. Otherwise choose $c=\operatorname{ess\,inf}_{\{H>a\}}R$, which is positive and finite. To see this choice is valid, the optimal gap fill is an exact likelihood-ratio threshold allocation at some $c_*>0$, finite, with $\psi=1$ above and $\psi=0$ below. If the fill has positive mass with $\psi>0$ at $R=c_*$, the chosen $c$ equals $c_*$. Otherwise the fill is binary almost surely, all the interior $A_t$ have the same positive set, and its essential infimum again separates the cut. Thus in the finite positive case, $R\ge c$ on $A_t$ and $R\le c$ off $A_t$, even for a cut that happens to be full.

The resulting $c(t)$ is nondecreasing. For partial gaps this follows from nesting of $\{H>a\}$ at their left endpoints, and from sandwiching each gap cutoff between the ones for cuts before and after the gap. A full gap can only occur before any proper or empty cut, and an empty gap can only occur after full or proper cuts. The full and null conventions on $S$ obey the same order.

### Integrating the budget

Put $w(t)=1/c(t)$, with the reciprocal conventions at zero and infinity. For $0<c(t)<\infty$,
$$
D(t)-w(t)F(t)
=\int(\mathbf 1_{D_t'}-\mathbf 1_{A_t})(1-R/c(t))\,dP\ge0.
\tag{2}
$$
Equality occurs only if the cuts agree off the level $\{R=c(t)\}$. Where $c=\infty$, $A_t$ is null and $w=0$, so $D\ge0$. Where $c=0$, the cut is full. If such a $t$ is in $S$, then $C(t)=0$ since $C$ is nonnegative there and is nonincreasing from zero until $t$. If $t$ belongs to a full gap $(a,b)$, then $H\ge b$ almost surely, and the same argument gives $C(b)=0$. Thus $F=D=0$ almost everywhere on the initial interval where $c=0$. Define $wF=0$ there. We have $D\ge wF$ almost everywhere.

Use the right-continuous version of $w_M=\min(w,M)$ for every $M>0$. The positive Stieltjes measure $d(-w_M)$ is carried by $S$, since $w_M$ is constant in each complementary interval. Versions affect no Lebesgue integral. Choose $T$ on $S$ or, if $B<\infty$, any $T\ge B$. Then
$$
I_M(T):=\int_0^T w_M(t)F(t)\,dt
=w_M(T)C(T)+\int_{(0,T]}C(t)\,d(-w_M)(t)\ge0.
\tag{3}
$$
Both right-hand terms are nonnegative. The positive part of $w_MF$ is bounded by $D_+$ almost everywhere by (2) and the full and empty conventions. Along the chosen $T\to\infty$, (3) bounds the negative-part integral by the integral of $D_+$. As $M\to\infty$, each part converges monotonically, so $wF$ is integrable with nonnegative integral. But
$$
0\ \ge\ \mathbb E_PE'-1=\int_0^\infty D
\ \ge\ \int_0^\infty wF\ \ge\ 0.
$$
Consequently $D=wF$ almost everywhere and $L_M=\lim_{T\to\infty}I_M(T)$ tends to zero as $M\to\infty$.

### Excluding strictly better caps

If $C(t)>0$ anywhere, let $(a_0,b_0)$ be a component of this open set. On any subinterval $[u,v]$ inside it, (3) gives
$$
\min_{[u,v]}C\,[w_M(u)-w_M(v)]\le L_M .
$$
Thus $w$ is constant inside the component, up to endpoint versions. If the value is infinity, the full-cut property gives $F=0$ almost everywhere. If the value is zero, $D=wF=0$ and both cuts are null, again giving $F=0$. Either contradicts $C(a_0)=0<C$ inside, including at $a_0=0$.

For a finite positive constant $w$, the equality case of (2) confines the difference of the cuts to the same set $\{R=1/w\}$ almost everywhere in the component. On this set $H$ is constant. If the set is null then $F=0$. Otherwise, $F$ is nonpositive below the common value of $H$ and nonnegative at or above it. Therefore $C$ first cannot rise and then cannot fall. For finite $b_0$, $C(b_0)=0$, ruling out positivity. If $b_0=\infty$, apply the boundary term in (3) along an allowed sequence $T\to\infty$, or $T\ge B$ in the bounded case. It gives $\min(w,M)\limsup C(T)\le L_M$ and hence this limsup vanishes. The derivative sign again rules out positivity. There are no positive components, so no allowed cap can be strictly improved. $\square$

## 4. An accumulating unbounded stake set

Take
$$
\mathcal L=(0,1/2]\ \cup\ \{1/2+2^{-j}:j\ge1\}\ \cup\ [5/2,\infty).
$$
Let $P=(1/4,3/8,3/8)$ on three states and $R=(1/2,7/6,7/6)$. The evidence $E=(0,4/3,4/3)$ has budget one. Its only fractional gap fill is in $(1,5/2)$ and uses the maximal ratio, so it is admissible. Its positive evidence value is outside $S$.

In contrast, take the same $P$ and ratios $(1/2,1,4/3)$. The sharp monotone evidence $E=(0,7/6,3/2)$ fails the gap condition on $(1,5/2)$. To see this, shift by $1/12$ from the middle to the top, yielding $E'=(0,13/12,19/12)$. Both perturbed entries stay above $1$ and below $5/2$. The capped $Q$ moments agree at all $t\le1$ and improve by $1/96$ at all $t\ge5/2$. Thus monotonicity and sharpness do not by themselves suffice for evidence in a gap.

## Source

B. Chugg, T. Lardy, A. Ramdas and P. Grünwald, *On admissibility in post-hoc hypothesis testing*, International Journal of Approximate Reasoning **191** (2026), 109634. [Journal full text](https://ir.cwi.nl/pub/36228/36228.pdf), §2, §5.2, §5.3 and Table 2. [Preprint v3](https://arxiv.org/html/2508.00770v3).
