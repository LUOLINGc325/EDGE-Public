# A complete finite-stake criterion for post-hoc admissibility

*Neyman–Pearson increments and equality at likelihood-ratio atoms*

## 1. Setting

Chugg, Lardy, Ramdas and Grünwald (2026), §5.3, ask for sufficient conditions for randomized $\mathbf C$-admissibility. They also state a likelihood-ratio monotonicity necessity. We give an exact finite-stake characterization for all equivalent simple hypotheses, including the admissible freedom within tied likelihood ratios.

Let $P,Q$ be equivalent probability measures, with $R=dQ/dP\in(0,\infty)$ almost surely. Let $0=t_0<t_1<\cdots<t_K$ be the stakes, with $t_K>1$. A safe randomized family has envelope $E_\delta=\max_{1\le j\le K}t_j\delta_j$ and $\mathbb E_P E_\delta\le1$. It is $\mathbf C$-admissible if no safe family raises its expected rejection probability under $Q$ at all fixed stakes, strictly for at least one stake. This is the fixed-scenario type-II risk comparison under the source's strictly positive false-retention losses.

The canonical family of $E$ has rejection probabilities $\delta_j=\min(1,E/t_j)$. Replacing a test by the canonical family of its envelope is safe and can only raise its rejection probabilities. If the original test and this replacement differ on a set of positive mass at any stake, the improvement is strict. Thus it suffices to consider canonical families with $0\le E\le t_K$, and to compare the capped moments $M_E(t)=\mathbb E_Q\min(E,t)$.

For $1\le j\le K$ let $\Delta_j=t_j-t_{j-1}$, and set
$$
\phi_j(E)=\frac{\min((E-t_{j-1})_+,\Delta_j)}{\Delta_j},
\qquad
\beta_j=\mathbb E_P\phi_j(E).
$$
These are the fractions of evidence in the successive stake intervals. One has
$$
\min(E,t_k)=\sum_{j\le k}\Delta_j\phi_j(E).
\tag{1}
$$

## 2. Exact criterion

**Theorem.** The canonical family of $0\le E\le t_K$ is $\mathbf C$-admissible if and only if all three conditions hold.

1. **Sharpness.** $\mathbb E_PE=1$.
2. **Optimal increments.** For every $j$, $\phi_j(E)$ maximizes $\mathbb E_Q\psi$ over all $0\le\psi\le1$ with $\mathbb E_P\psi=\beta_j$.
3. **No straddling on likelihood-ratio atoms.** For every $r$ with $P(R=r)>0$ and every allowed $t_j$, at least one of $P(E<t_j\mid R=r)$ and $P(E>t_j\mid R=r)$ is zero.

Condition 2 involves only standard Neyman–Pearson comparisons. For $0<\beta_j<1$, let $c_j$ be a threshold with
$$
P(R>c_j)\le\beta_j\le P(R\ge c_j).
$$
Condition 2 means $\phi_j=1$ on $\{R>c_j\}$ and $\phi_j=0$ on $\{R<c_j\}$, with any allocation on the tie level satisfying its size. One may take lower quantiles of $R$ at $1-\beta_j$ for these thresholds. The endpoint sizes zero and one make $\phi_j$ trivially optimal.

**Necessity.** If $\mathbb E_PE<1$, there is positive mass below $t_K$ because $t_K>1$. For sufficiently small $\eta>0$, $E+\eta(t_K-E)$ preserves the budget and improves the capped moment at $t_K$ while weakly increasing every other one. This forces sharpness.

Suppose an increment at index $j$ is not optimal. Replace that increment $\Delta_j\phi_j(E)$ by a better one of the same $P$ expectation. Keep every other increment. Denote the new increments by $u_i\in[0,\Delta_i]$ and put $E'=\sum_i u_i$. Pointwise the partial sum $\sum_{i\le k}u_i$ is at most both $E'$ and $t_k$. Consequently, $\min(E',t_k)\ge\sum_{i\le k}u_i$. Taking expectations in (1) shows weak improvement for every cap and strict improvement at $t_j$. This is a contradiction.

Finally, on an atom of $R$, the conditional laws under $P$ and $Q$ coincide. Replacing $E$ on that atom by its conditional mean preserves the null budget. Capped moments cannot decrease by Jensen's inequality. For a cap $t$ with positive conditional mass both below and above $t$, Jensen is strict: the gap is the smaller of the conditional expected positive and negative parts of $E-t$. This would improve at least one cap, establishing condition 3.

**Sufficiency.** The functions $\phi_j(E)$ are pointwise nonincreasing in $j$, so their sizes are nonincreasing. The size-one increments form a prefix ending at stake $a$, taking $a=0$ for an empty prefix. The size-zero increments form a suffix. If there are no intermediate sizes, $E=a=1$ by sharpness, and dominance at stake $a$ forces any competitor to be at least $1$ almost surely. The budget then forces equality.

Otherwise take successive intermediate-size increments, whose quantile cutoffs $c_j$ are positive, finite and nondecreasing. In each group of equal cutoffs merge adjacent increments. Write $c_1^\star<\cdots<c_J^\star$ for these distinct cutoffs, and let $a+z_i$ be the allowed stake at the end of group $i$, with $z_0=0$. For each intermediate-size increment, the pointwise characterization of an optimal test follows by comparing to an exact threshold test: their difference has $P$ expectation zero and its product with $R-c_j$ has constant sign. Optimality forces equality, hence agreement off the tie set. It follows that $Y=E-a$ equals the appropriate group endpoint when $R$ lies strictly between successive thresholds, and takes values in $[z_{i-1},z_i]$ on $\{R=c_i^\star\}$.

Let $E'$ be a safe evidence variable that weakly improves every cap. If $a>0$, saturation at the allowed cap $a$ implies $E'\ge a$ almost surely. If $a=0$, this follows from nonnegativity. Let $Y'=E'-a$. Set $c_{J+1}^\star=\infty$ and
$$
V(y)=\sum_{i=1}^J
\left(\frac{1}{c_i^\star}-\frac{1}{c_{i+1}^\star}\right)\min(y,z_i).
$$
The slopes of $RV(y)-y$ on these intervals are $R/c_i^\star-1$ and the terminal slope is $-1$. Thus $Y$ maximizes this function pointwise. Dominance at all $a+z_i$ gives $\mathbb E_QV(Y')\ge\mathbb E_QV(Y)$, and the budget gives $\mathbb E_PY'\le\mathbb E_PY$. Integrating pointwise optimality forces equality in both inequalities and that $Y'$ is also pointwise maximizing. In particular $Y'=Y$ off the tie levels and $Y'\in[z_{i-1},z_i]$ on the $i$-th tie level. The coefficients of $V$ are strictly positive, so each group-end capped moment is unchanged.

At $z_i$ the change in capped moment equals the sum through $i$ of $\mathbb E_Q[(Y'-Y)\mathbf 1_{\{R=c_j^\star\}}]$. Subtract successive zero sums. On every positive-mass tie level, $Y'$ and $Y$ therefore have the same conditional mean. For any original allowed cap, condition 3 makes Jensen an equality for $E$ on that level, whereas Jensen gives the upper bound by the same conditional mean for $E'$. Hence no cap is strictly improved. $\square$

## 3. Consequences and exact tie examples

If the likelihood-ratio law has no atoms, the intermediate fractions are zero or one almost surely, and the theorem reduces to sharp evidence supported on $\{0,t_1,\ldots,t_K\}$ and nondecreasing in $R$. Conversely, every such evidence gives individually optimal increments and automatically meets the atom condition.

With tied likelihood ratios, an admissible evidence can be replaced by its conditional mean given $R$ without changing any of the allowed capped moments. Indeed the increment representation makes the evidence already determined by the ratio away from the finitely many cutoff levels. On a cutoff atom, condition 3 ensures that conditional Jensen is exact at every stake. This yields the same decision risks, while the original evidence may vary within a tie level.

For an exact example take three cells with
$$
P=(1/4,3/8,3/8),\qquad R=(1/2,7/6,7/6).
$$
For stakes $\{2,3\}$, take $E=(0,2,2/3)$. Its null budget equals one and its capped moments both equal $7/6$. For any competitor $\mathbb E_Q\min(E',t)\le(7/6)\mathbb E_PE'\le7/6$, so it is admissible. However, its last two entries differ at the same likelihood ratio. Thus the function-of-likelihood-ratio wording of Chugg et al., journal Lemma 5.1 (arXiv v3 Lemma 5.7), needs a tie qualification when applied to the original family. The example preserves monotonic order between distinct ratios.

The two nontrivial criteria constrain distinct phenomena. On the same cells, stakes $\{1,3\}$ and $E=(0,0,8/3)$ give sharp evidence whose two increments are individually optimal since they use only the maximal ratio. This evidence straddles $1$ at that ratio. Replacing both tied entries by $4/3$ raises the moment at $1$ by $7/16$ and leaves the moment at $3$ unchanged. Conversely, for stakes $\{2,3\}$ and $E=(2,2/3,2/3)$, sharpness and no straddling hold, yet the moment at both caps is $5/6$, strictly below the $7/6$ achieved by $E=(0,4/3,4/3)$.

## References

B. Chugg, T. Lardy, A. Ramdas and P. Grünwald, *On admissibility in post-hoc hypothesis testing*, International Journal of Approximate Reasoning **191** (2026), 109634. [Journal full text](https://ir.cwi.nl/pub/36228/36228.pdf), §2, §4, §5.3. [Preprint v3](https://arxiv.org/html/2508.00770v3), Table 2 and Lemma 5.7.
