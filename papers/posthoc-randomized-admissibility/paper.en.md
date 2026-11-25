# Admissibility of likelihood-ratio-monotone post-hoc tests

*A sufficiency theorem and the finite Neyman–Pearson mixture criterion*

## Setting and claims

Chugg, Lardy, Ramdas and Grünwald, *On admissibility in post-hoc hypothesis testing* (2026), §5.3, ask whether sharpness, a canonical representation, likelihood-ratio monotonicity and compatibility with the allowed losses suffice for $\mathbf C$-admissibility of randomized test families. They also conjecture admissibility of finite equal mixtures of Neyman–Pearson e-variables when the prefix stakes are available. We prove sufficiency and a weighted mixture theorem with an explicit order condition. An exact counterexample treats the arbitrary-order reading of the prefix condition.

Let $P$ and $Q$ be equivalent probability measures for a simple null and a simple alternative, and let $R=dQ/dP\in(0,\infty)$ almost surely. Let $\mathcal L\subset(0,\infty)$ be the set of numeric false-rejection losses, called stakes. A test family $\delta$ with rejection probabilities $\delta(x,b)$, indexed by scenarios $b$, is safe if the measurable envelope
$$
E_\delta(x)=\sup_b L_b(0,1)\delta(x,b)
$$
has $\mathbb E_P E_\delta\leq 1$. We use the source's envelope measurability convention. A candidate is $\mathbf C$-admissible if there is no safe family with at least as high expected rejection probability under $Q$ at every fixed scenario and higher probability at some fixed scenario. This is precisely the type-II risk ordering when the false-retention loss is positive at each scenario. Distinct scenarios of equal stake cause no difficulty because the canonical family depends on $b$ through its stake.

For a nonnegative variable $E$ with $\mathbb E_P E\leq 1$, the canonical family rejects at stake $t$ with probability $\min(1,E/t)$. It is safe. Any safe competitor is bounded at every stake by the canonical family of its envelope. Thus to prove admissibility it suffices to show that a nonnegative $E'$ with $\mathbb E_P E'\leq 1$ cannot weakly increase
$$
M_E(t)=\mathbb E_Q\min(E,t), \qquad t\in\mathcal L,
$$
with a strict increase somewhere. We call $E$ sharp when $\mathbb E_P E=1$.

## Theorem 1. Sufficiency of sharpness, monotonicity and compatibility

Suppose $E=h(R)$ almost surely for a nondecreasing Borel function $h$, with $\mathbb E_P E=1$ and $E\in\overline{\mathcal L\cup\{0\}}$ almost surely. Its canonical family is $\mathbf C$-admissible. The closure condition includes the source's compatibility condition $E\in\mathcal L\cup\{0\}$. The likelihood ratio may have atoms or lack positive lower and finite upper bounds.

**Proof.** Let $E'$ be a nonnegative competitor with $\mathbb E_P E'\leq1$ and $M_{E'}\geq M_E$ on $\mathcal L$. For $t\geq0$ set
$$
 A_t=\{E>t\},\quad B_t=\{E'>t\},\quad
 F(t)=Q(B_t)-Q(A_t),\quad D(t)=P(B_t)-P(A_t).
$$
The function $C(t)=M_{E'}(t)-M_E(t)=\int_0^tF(s)\,ds$ is continuous, and $D$ is absolutely integrable since $\int_0^\infty |D|\leq \mathbb E_P(E'+E)$. On the closed set $\overline{\mathcal L\cup\{0\}}$ we have $C\geq0$ by continuity. On each bounded complementary interval, $M_E$ is affine because $E$ has no mass in its interior. The concavity of $M_{E'}$ interpolates the endpoint inequalities. On an unbounded complementary interval $M_E$ is constant and $M_{E'}$ nondecreasing. Hence $C(t)\geq0$ for every $t\geq0$.

When $0<P(A_t)<1$, define $c(t)=\operatorname{ess\,inf}_{A_t}R$ with respect to $P$. Because $h$ is nondecreasing, the positive-mass proper upper set $A_t$ has $0<c(t)<\infty$, with $R\geq c(t)$ on $A_t$ and $R\leq c(t)$ on its complement almost surely. In detail, the upper subset $\{r:h(r)>t\}$ separates any $R$ in the complement from every $R$ in $A_t$, and the omitted set has positive-mass positive ratios. Put $c(t)=0$ when $P(A_t)=1$ and $c(t)=\infty$ when $P(A_t)=0$. The nested upper sets make $c$ nondecreasing. Let $w(t)=1/c(t)$, with the reciprocal conventions at $0$ and $\infty$. For proper cuts,
$$
 D(t)-w(t)F(t)
 =\int(\mathbf 1_{B_t}-\mathbf 1_{A_t})(1-R/c(t))\,dP\geq0. \tag{1}
$$
The integrand is nonnegative, and equality forces $A_t$ and $B_t$ to agree up to null events off $\{R=c(t)\}$.

Where $A_t$ has full probability, an initial interval up to endpoints, $F\leq0$ and $C\geq0$ imply $F=0$ almost everywhere on that interval. There $D=0$ almost everywhere by equivalence of $P,Q$ and we define $wF=0$. Where $A_t$ is null, $w=0$ and $D\geq0$. Thus (1) gives $D\geq wF$ almost everywhere on the half-line.

For $M>0$ define $w_M=\min(w,M)$ and use its right-continuous version for Stieltjes integration. Changing a monotone function at its discontinuities leaves all Lebesgue integrals here unchanged. For finite $T$ integration by parts, with $C(0)=0$, gives
$$
 I_M(T):=\int_0^T w_M(t)F(t)\,dt
 =w_M(T)C(T)+\int_{(0,T]}C(t)\,d(-w_M)(t)\geq0. \tag{2}
$$
The positive part $(w_MF)_+$ is bounded by $D_+\mathbf 1_{\{F>0\}}$ almost everywhere, by (1) and the full and empty cut conventions. Equation (2) bounds the negative-part integral by the positive-part integral, also on the whole half-line. As $M$ increases, both parts converge monotonically to those of $wF$ and their integrals stay finite. Consequently $L=\int_0^\infty wF\geq0$, and
$$
 0\geq \mathbb E_PE'-1=\int_0^\infty D\geq L\geq0.
$$
In particular $D=wF$ almost everywhere, and $L_M=\lim_{T\to\infty}I_M(T)\longrightarrow0$ as $M\to\infty$.

Suppose $(a,b)$ is a connected component of $\{t>0:C(t)>0\}$. For $a<u<v<b$, $C$ has a positive minimum on $[u,v]$. Applying (2) for $T\geq v$ and taking $T\to\infty$ gives
$$
 \left(\min_{[u,v]}C\right)\bigl(w_M(u)-w_M(v)\bigr)\leq L_M .
$$
Taking $M\to\infty$ shows that $w$ is constant in the interior, up to discontinuity versions. A constant value $\infty$ means $F=0$ a.e. there by the full cut argument. A constant value $0$ also implies $F=0$ a.e., since $D=wF=0$ means both cut sets are null. Either contradicts $C(a)=0<C(t)$.

For a finite positive constant $w$, put $c=1/w$. Equality in (1) says the two cuts can differ only on the same set $\{R=c\}$ for almost every $t\in(a,b)$. On that set $E=h(c)$ is constant, so $F(t)\leq0$ for $t<h(c)$ and $F(t)\geq0$ for $t\geq h(c)$ within the component. A function with this derivative sign pattern and zero endpoint values cannot be positive inside. At the left endpoint $C(a)=0$, including $a=0$. At a finite right endpoint $C(b)=0$. If $b=\infty$, (2) for $T\in(a,\infty)$ gives
$$
 \min(w,M)\limsup_{T\to\infty}C(T)\leq L_M
$$
and letting $M$ increase proves the same right-endpoint limit. This eliminates every possible positive component. Thus all capped moments agree, which proves admissibility. $\square$

## Theorem 2. Finite mixtures with ordered group endpoints

For $i=1,\ldots,K$, choose a stake $b_i\in\mathcal L$ with $b_i\geq1$ and an exact Neyman–Pearson rejection probability
$$
 \phi_i=\mathbf 1_{\{R>c_i\}}+\gamma_i\mathbf 1_{\{R=c_i\}},
 \qquad 0\leq\gamma_i\leq1,\quad
 \mathbb E_P\phi_i=1/b_i.
$$
Use cutoff zero for every $b_i=1$. For $b_i>1$ the cutoffs can be chosen positive, finite and nondecreasing in $b_i$ by taking quantiles of $R$. Let $p_i>0$ with $\sum_i p_i=1$, and $E=\sum_i p_i b_i\phi_i$. Group tests at the same positive cutoff and write their distinct cutoffs as $0<c_1^\star<\cdots<c_J^\star$. Let $a=\sum_{i:c_i=0}p_i b_i$. Write
$$
 z_0=0,\qquad z_j=\sum_{i:0<c_i\leq c_j^\star}p_i b_i
 \quad(1\leq j\leq J).
$$
If $a\in\mathcal L$ when $a>0$, and $a+z_j\in\mathcal L$ for each $j$, then the canonical family of $E$ is $\mathbf C$-admissible. In particular the condition holds for the source's equal weights if every prefix stake in nondecreasing cutoff order is available. Only the ends of equal-cutoff groups are needed, with the initial zero-cutoff group included.

**Proof.** Exact sizes give $\mathbb E_PE=1$. If $E'$ is a competitor, dominance at stake $a$ when $a>0$ forces $E'\geq a$ almost surely under both measures, since $M_E(a)=a$. The same inequality is automatic if $a=0$. If $J=0$, then $E=a=1$ and the budget forces $E'=1$ almost surely. Otherwise set $Y=E-a$, $Y'=E'-a$, and
$$
 w_j=\frac1{c_j^\star}-\frac1{c_{j+1}^\star},\quad
 c_{J+1}^\star=\infty,\qquad
 V(y)=\sum_{j=1}^Jw_j\min(y,z_j).
$$
The weights are positive. At each fixed data point, the concave function $y\mapsto RV(y)-y$ on $y\geq0$ has slope $R/c_j^\star-1$ on $(z_{j-1},z_j)$ and slope $-1$ on $(z_J,\infty)$. The thresholds defining $E$ therefore make $Y$ a pointwise maximizer. It is the unique maximizer if $R$ is not a cutoff. If $R=c_j^\star$ the entire maximizing set is $[z_{j-1},z_j]$, and $Y$ is constant on this likelihood-ratio level.

Since the group-end stakes are available, $\mathbb E_Q V(Y')\geq\mathbb E_Q V(Y)$. The null budget gives $\mathbb E_PY'\leq\mathbb E_PY$. Combining these inequalities with the integrated pointwise maximum implies equality in both and $Y'$ is a pointwise maximizer almost surely. Because all weights are positive and no group-end capped moment can fall, each must be equal for $Y,Y'$. Away from cutoff levels $Y'=Y$ almost surely. Define $d_i=\mathbb E_Q[(Y'-Y)\mathbf 1_{\{R=c_i^\star\}}]$. At cap $z_j$ the capped moment difference is $\sum_{i\leq j}d_i$: both values lie below the cap for $i\leq j$ and both lie above it for $i>j$, allowing equality at the edges. All these sums vanish, so each $d_i=0$. On any positive-mass cutoff level, $Y'$ and the constant $Y$ have the same conditional mean. Jensen's inequality for the concave cap implies that $Y'$ cannot raise any conditional capped mean there. At stakes at most $a$ both tests already reject with probability one. At larger stakes, summing conditional contributions proves that $E'$ cannot improve any capped moment. $\square$

## Two exact scope checks

**Cutoff randomization can break pointwise compatibility.** Under $P$, take two cells of probabilities $3/4$ and $1/4$, with likelihood ratios $2/3$ and $2$, respectively. The corresponding $Q$ probabilities are both $1/2$. Take equal weights on stakes $2$ and $8$. The first Neyman–Pearson test rejects at probabilities $(1/3,1)$ and the second at $(0,1/2)$. Then $E=(1/3,3)$ is sharp and both values are outside the allowed stakes $\{1,2,5,8\}$. The group-end stakes are $1,5$, so the mixture theorem applies even though Theorem 1's compatibility hypothesis fails.

**An arbitrary order of the prefixes is insufficient.** Take $P$ uniform on $[0,1]$ and $Q$ with density $1/2+x$. At equal weights, list the chosen stakes in order $8,2$ and take $\mathcal L=\{2,4,5,8\}$. The listed prefix stakes are $4,5$, both available. The mixture has evidence $0,1,5$ on the successive regions cut at $1/2$ and $7/8$. Subtract $1/2$ from the evidence on $[1/2,5/8)$ and add $1/2$ on $[3/4,7/8)$. The null mean is unchanged. At every allowed cap the alteration is uncapped on the perturbed regions, so
$$
 M_{E'}(t)-M_E(t)
 =\tfrac12\left[Q([3/4,7/8))-Q([1/2,5/8))\right]=\tfrac1{64}>0.
$$
Thus the ordering convention matters. Section 2 of the source orders scenario losses by stake, and the ordered interpretation of the prefix condition uses this order explicitly.

## Source

B. Chugg, T. Lardy, A. Ramdas and P. Grünwald, *On admissibility in post-hoc hypothesis testing*, International Journal of Approximate Reasoning **191** (2026), 109634, §2, §3 and §5.3, Eq. (20). [Journal full text](https://ir.cwi.nl/pub/36228/36228.pdf). [Author preprint v3](https://arxiv.org/html/2508.00770v3), §5.3, Eq. (5.2).
