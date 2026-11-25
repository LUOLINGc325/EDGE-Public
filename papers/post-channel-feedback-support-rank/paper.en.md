# Local support-rank classification of feedback gain in POST channels

**Research manuscript · 25 November 2026**

Written mathematical results and a reproducible certificate package. Full formalization is a separate pending deliverable. All logarithms are natural, and all rates are in nats per channel use.

## Abstract

Consider a strictly positive discrete memoryless channel with a unique capacity-achieving input distribution whose support contains at least two inputs. Suppose that its active columns are linearly independent and that every inactive input has a strict divergence gap in the capacity optimality conditions. We prove that the absence of feedback gain is locally robust under arbitrary previous-output-is-the-state (POST) perturbations if and only if the number of active inputs equals the output alphabet size. The sufficient direction is the theorem of Zhang, Chen, and Wang; our contribution is the necessary direction at every regular reference channel with smaller active support.

The proof constructs a state-separable channel perturbation, computes the first derivative of its Bellman-optimal policy, and identifies a nonzero two-output direction that no active non-feedback input pair can realize. A finite-horizon divergence identity retains the cost of inactive inputs, converting the two-step obstruction into a positive operational capacity gap against every correlated and nonstationary non-feedback encoder. Along the constructed path the gap is of order the square of the perturbation size. In the full local parameter space, the zero-gain set is contained in a smooth codimension-one hypersurface. A strictly positive, full-rank three-input three-output example demonstrates why the active support matters even when the entire channel matrix is nonsingular.

The result concerns a nondegenerate local class. It does not classify singular active subchannels, support-transition boundaries, or arbitrary finite-state channels. Novelty comparisons are limited to the sources actually inspected, including the arXiv version of the 2026 paper and the repository's earlier binary POST manuscript.

## 1. Problem, sources, and contribution

A POST channel has the preceding output as its current state. Its transition law is

$$
Q(y\mid x,s),\qquad s=Y_{t-1}.
$$

Feedback reveals that state to the encoder after the first observation. Without feedback, the encoder may choose an arbitrarily correlated input word but cannot adapt it to channel outputs. Whether this information increases capacity depends on the channel's geometry and on the capacity-achieving input law.

Permuter, Asnani, and Weissman [2] established important binary examples with no feedback gain and other POST examples with a gain. Zhang, Chen, and Wang [1] proved a local no-gain theorem around memoryless channels satisfying a surjectivity condition. In their condition, a capacity-achieving active subchannel has as many independent columns as there are outputs, with strictly inferior unused inputs. Section V of the inspected arXiv version identifies the broader condition as unresolved: “it remains unclear what the most general condition is”.

Our target is the following local converse in the regular class: if the optimum uses fewer independent inputs than the number of outputs, must arbitrarily small POST perturbations provide a feedback advantage? We answer this for every reference channel satisfying the assumptions below. The argument also gives a full-measure local statement and a quantitative gap certificate.

The repository's preceding binary POST manuscript [4] already develops binary global classification and a finite-block separation method. We credit that methodological precursor. The present contribution is the general finite-alphabet local necessity theorem, the stable-support sensitivity construction, its two-step residual, the treatment of inactive-input slack, and the generic and quadratic consequences. The known full-output-rank sufficient direction is attributed to [1] throughout.

The final journal record for [1] is available [3], but its final full text was not obtained. We therefore compare with arXiv:2603.08886v1 and do not claim to correct wording or theorems in an uninspected final version. The proof of our necessary direction is supplied below and does not rely on an alleged error in that source.

The source audit also examined sequential feedback optimality [5] and the finite-horizon implementation criterion in [6, Theorem II.2]. That finite-horizon equivalence and its sufficient asymptotic no-gain consequence are prior tools, not the local converse proved here. A recent adjacent grabbag-channel paper [7] was inspected only at the abstract level; its full text was unavailable. Its stated state variable and asymptotic regime differ from this POST problem, but the abstract alone cannot exclude every incidental result. These availability limits remain part of the novelty assessment.

## 2. Model, assumptions, and main result

### 2.1 Operational capacities

Let the output and state alphabet be $\mathcal Y=\{1,\ldots,m\}$, and let the input alphabet be $\mathcal X=\{1,\ldots,n\}$. A channel is strictly positive if every $Q(y\mid x,s)>0$. Write $Q_s$ for its $m\times n$ column-stochastic matrix at state $s$.

In a length-$N$ non-feedback code, a uniform message determines an input word, possibly using encoder randomness independent of the channel. In a feedback code, the input at time $t$ may additionally depend on $Y^{t-1}$. The decoder observes $Y^N$. Define $C(Q)$ and $C_f(Q)$ as the supremal rates achievable with vanishing average message error, uniformly over the finitely many initial states. Initial-state knowledge is not assumed. Section 10 proves the operational statements used below and handles initialization explicitly.

### 2.2 Regular memoryless reference channels

Let $\overline W$ be a strictly positive $m\times n$ memoryless channel. Let its unique capacity-achieving input have support $S$, and put $k=|S|$. Enumerate $S$ as $\{1,\ldots,k\}$ when working with active coordinates. Define

$$
W=\overline W_S,\qquad p\in\mathbb R^k_{>0},\quad
\mathbf1^Tp=1,\qquad r=Wp,\qquad C_0=I(p,W).
\tag{2.1}
$$

Here $W$ is the active submatrix; $\overline W$ always denotes the entire reference channel. Our assumptions are

$$
2\le k\le m,\qquad \operatorname{rank}W=k,
\tag{2.2}
$$

and, for every inactive input,

$$
D(\overline W_{:,x}\Vert r)<C_0,
\qquad x\notin S.
\tag{2.3}
$$

For active inputs, the ordinary channel-capacity optimality conditions give $D(W_{:,x}\Vert r)=C_0$. All divergence expressions are finite because the reference channel is strictly positive.

Call the absence of feedback gain **locally robust at $\overline W$** if there is a $\delta>0$ such that

$$
C(Q)=C_f(Q)
\quad\text{whenever}\quad
\max_s\|Q_s-\overline W\|_{\max}<\delta
\tag{2.4}
$$

and the state matrices are strictly positive channels. The norm is the maximum absolute entry. Neighborhoods and measure statements below are taken in the affine space in which every channel column sums to one.

### Theorem 2.1. Local support-rank classification

Under (2.1)–(2.3), the following statements hold.

1. The absence of feedback gain is locally robust if and only if $k=m$. The $k=m$ direction is the sufficient theorem of Zhang–Chen–Wang [1].
2. If $k<m$, there are a nonzero $f\in\ker W^T$ and a real matrix $A$, with zero column sums and zero inactive columns, such that the path

$$
Q_s^\varepsilon=\overline W+\varepsilon f_s A
\tag{2.5}
$$

is strictly positive for all sufficiently small $|\varepsilon|$, and

$$
C_f(Q^\varepsilon)>C(Q^\varepsilon)
\qquad(0<|\varepsilon|<\varepsilon_0).
\tag{2.6}
$$

Every such nonzero sufficiently small parameter has a two-output certificate yielding an explicit positive operational gap.
3. If $k<m$, in a neighborhood of $\overline W$ the zero-gain set is contained in a smooth real-analytic codimension-one hypersurface. Consequently, an open dense subset of full Lebesgue measure in that neighborhood has strict feedback gain.
4. Along the path in part 2 there are explicit constants $d_0>0$ and $U>0$ such that

$$
d_0^2\le
\liminf_{\varepsilon\to0}
\frac{C_f(Q^\varepsilon)-C(Q^\varepsilon)}{\varepsilon^2}
\le
\limsup_{\varepsilon\to0}
\frac{C_f(Q^\varepsilon)-C(Q^\varepsilon)}{\varepsilon^2}
\le U.
\tag{2.7}
$$

In particular, the gain is $\Theta(\varepsilon^2)$. No exact second-order coefficient is asserted.

The proof is organized around three points that require separate justification: the optimizer must retain its active support; its perturbation must produce a direction unavailable to non-feedback inputs; and a finite-horizon mismatch must imply a positive asymptotic operational loss. Sections 3–8 establish these points.

## 3. Analytic stability of the active Bellman optimum

For a probability vector $u$ on all inputs, write

$$
I_s(u;Q)=H(Q_su)-\sum_xu_xH(Q_{s,:,x}).
\tag{3.1}
$$

We use the Bellman equations

$$
\rho+h_s=
\max_{u\in\Delta_n}\{I_s(u;Q)+h^TQ_su\}.
\tag{3.2}
$$

The bias $h\in\mathbb R^m$ is normalized by $r^Th=0$, with the fixed reference vector $r$. At the memoryless reference, $(\rho,h)=(C_0,0)$, and every state has the same optimizer $p$, extended by zero outside $S$.

### Lemma 3.1. Stable support and analytic optimum

There is a neighborhood of $\overline W$ in the full POST parameter space on which (3.2) has an analytic solution $\rho(Q),h(Q)$, and the maximizing input distribution $p_s(Q)$ is unique, analytic, and has support exactly $S$ at every state. Its active coordinates are strictly positive. Every inactive Bellman KKT gap remains strictly positive.

**Proof.** First restrict each maximization to $\Delta_S$. Its Hessian in active input coordinates is

$$
-Q_{s,S}^T\operatorname{diag}\bigl((Q_{s,S}u)^{-1}\bigr)Q_{s,S}.
\tag{3.3}
$$

At the reference point set

$$
B=W^T\operatorname{diag}(r^{-1})W.
\tag{3.4}
$$

This matrix is positive definite: for $v\ne0$, injectivity of $W$ gives $(Wv)^T\operatorname{diag}(r^{-1})(Wv)>0$. Thus the restricted Hessian is strictly negative definite on $\{v:\mathbf1^Tv=0\}$. The active optimum is interior. The implicit-function theorem applied to the active stationarity equations gives an analytic optimizer $u_s(h,Q)$ near the reference point. It remains interior. The active matrix remains full column rank, so strict concavity makes this optimizer the unique global maximizer on the active simplex.

At the reference point, the inactive KKT gaps are exactly those in (2.3). Continuity preserves their strict positivity. The concavity supporting inequality then shows that any input distribution placing positive mass outside $S$ has a strictly smaller Bellman objective. Hence $u_s(h,Q)$, with zeros outside $S$, is also the unique global optimizer over all inputs.

Let $\Phi_s(h,Q)$ be the resulting analytic maximum. Its derivative in $h$ at the reference point is $r^T$. The derivative of the Bellman equations together with the normalization is the linear map

$$
(d\rho,dh)\longmapsto
\bigl(d\rho\,\mathbf1+dh-\mathbf1r^Tdh,\ r^Tdh\bigr).
\tag{3.5}
$$

This map is invertible. Indeed its final coordinate determines $r^Tdh$; the $r$-weighted average of the first coordinates determines $d\rho$; the remaining coordinates then determine $dh$. A second application of the implicit-function theorem gives the asserted analytic Bellman solution and policies. All functions involved are analytic because the relevant probabilities stay positive. $\square$

Write

$$
R_s=Q_{s,S}p_s
\tag{3.6}
$$

for the optimal feedback output row, viewed as a column probability vector. The transition matrix whose rows are $R_s^T$ is strictly positive and has a unique positive invariant distribution. Stationary averaging of (3.2) identifies $\rho$ as the information rate of the maximizing policy. The coding and converse argument in Section 10 proves that it equals $C_f(Q)$.

For later use define the constrained inverse

$$
J=B^{-1}-B^{-1}\mathbf1
\bigl(\mathbf1^TB^{-1}\mathbf1\bigr)^{-1}\mathbf1^TB^{-1}.
\tag{3.7}
$$

For every $d$, $a=Jd$ is the unique vector satisfying $\mathbf1^Ta=0$ and $Ba-d\in\operatorname{span}\{\mathbf1\}$. In particular, $Jd=0$ if and only if $d$ is constant across active inputs.

## 4. A nonzero optimizer response exists at every reference point

For an active perturbation matrix $A\in\mathbb R^{m\times k}$ with zero column sums, put $b=Ap$ and

$$
d_x(A)=\sum_yA_{yx}\log\frac{W_{yx}}{r_y}
-\sum_yW_{yx}\frac{b_y}{r_y}.
\tag{4.1}
$$

This is the derivative, at the fixed input $p$, of the active input gradient of mutual information, modulo its irrelevant constant component.

### Lemma 4.1. Nonzero response

There exists a zero-column-sum matrix $A$ such that

$$
a=Jd(A)\ne0.
\tag{4.2}
$$

**Proof.** Suppose instead that $d(A)$ is constant for every such matrix $A$.

For $k\ge3$, perturb just column $j$ by an arbitrary vector $v$ with $\mathbf1^Tv=0$. For two distinct active indices $i,\ell\ne j$, formula (4.1) gives

$$
d_i-d_\ell=-p_j\sum_y
\frac{W_{yi}-W_{y\ell}}{r_y}v_y.
\tag{4.3}
$$

It vanishes for every zero-sum $v$. Therefore $(W_{:,i}-W_{:,\ell})/r$ is a constant vector. Since both columns sum to one, that constant is zero. For every pair $i,\ell$, a third column $j$ is available, so all active columns coincide. This contradicts full column rank.

For $k=2$, write $p=(p,q)$ with $p,q>0$ and $p+q=1$. To avoid overloading notation, denote the two channel columns by $w_1,w_2$. Put

$$
t_y=\frac{(w_1)_y}{r_y},\qquad
\frac{(w_2)_y}{r_y}=\frac{1-pt_y}{q},\qquad
0<t_y<\frac1p.
\tag{4.4}
$$

Perturbing only the first column by a zero-sum $v$ shows that

$$
F(t_y)=\log t_y-\frac pq(t_y-1)
\tag{4.5}
$$

is constant over $y$. Perturbing only the second column shows the same for

$$
G(t_y)=\log\frac{1-pt_y}{q}+(t_y-1).
\tag{4.6}
$$

The pair $(F,G)$ is injective on $(0,1/p)$. To prove this, compute

$$
F'(t)=\frac{q-pt}{qt},\qquad
G'(t)=\frac{q-pt}{1-pt},\qquad
\frac{G'(t)}{F'(t)}=\frac{qt}{1-pt}=:R(t).
\tag{4.7}
$$

The last expression extends through the common zero of the derivatives and is strictly increasing. If $t_1<t_2$ and $F(t_1)=F(t_2)$, strict concavity of $F$ forces
$t_1<t_*=q/p<t_2$. Since $\int_{t_1}^{t_2}F'=0$,

$$
G(t_2)-G(t_1)
=\int_{t_1}^{t_2}[R(t)-R(t_*)]F'(t)\,dt<0.
\tag{4.8}
$$

The integrand is strictly negative on each side of $t_*$, except at the single point itself. Thus $F$ and $G$ cannot both agree at distinct arguments. Equations (4.5)–(4.6) force all $t_y$ to be equal. Normalization then gives $w_1=r=w_2$, again contradicting full rank. The contradiction proves (4.2). $\square$

The proof is constructive in finite-dimensional linear algebra. The map $A\mapsto Jd(A)$ is linear. A finite basis of single-column zero-sum perturbations therefore contains a matrix with nonzero response. No genericity assumption on the reference channel is used.

## 5. Policy sensitivity and a two-output residual

Assume $k<m$. Choose $A$ from Lemma 4.1 and a nonzero

$$
f\in\ker W^T.
\tag{5.1}
$$

Such an $f$ exists because $W$ has rank $k<m$, and $r^Tf=p^TW^Tf=0$. Extend $A$ by zero on inactive columns and use the path (2.5). Zero column sums preserve normalization. Strict positivity of $\overline W$ preserves positivity for all sufficiently small positive and negative parameters.

### Lemma 5.1. First derivatives of the optimal policy

Define

$$
c=\sum_xp_x\sum_yA_{yx}\log\frac{W_{yx}}{r_y}
=p^Td(A).
\tag{5.2}
$$

Along (2.5), at $\varepsilon=0$,

$$
\rho'=0,\qquad h'=cf,\qquad
p_s'=f_s a,\qquad R_s'=f_s(Ap+Wa).
\tag{5.3}
$$

**Proof.** Differentiate the Bellman equation and use the envelope theorem and the normalization. Since $r^Th'=0$,

$$
\rho'+h'_s=cf_s.
$$

The $r$-weighted average gives $\rho'=c r^Tf=0$, and hence $h'=cf$. Differentiating the active stationarity equations gives, modulo a constant across inputs,

$$
-Bp_s'+f_s d(A)+W^Th'=0.
\tag{5.4}
$$

The last term is zero by (5.1). The constraint $\mathbf1^Tp_s'=0$ and (3.7) yield $p_s'=f_sa$. Finally differentiate $R_s=Q_{s,S}p_s$. $\square$

The orthogonality choice (5.1) is useful twice: it removes the average reward derivative and the common Bellman-bias contribution to the policy derivative.

### 5.1 Pair-output matrices

Fix an initial state $s$. Index a vector in $\mathbb R^{m^2}$ by two outputs $(y,z)$. Define the $m^2\times k^2$ active non-feedback pair-output matrix by

$$
K_s[(y,z),(i,j)]=Q_s(y\mid i)Q_y(z\mid j),
\qquad i,j\in S.
\tag{5.5}
$$

For every joint distribution on the two active inputs, including arbitrary correlation, its output law is the corresponding convex combination of these columns. At the memoryless point, identifying an input-pair vector with a matrix $U$,

$$
K_0\operatorname{vec}(U)=\operatorname{vec}(WUW^T).
\tag{5.6}
$$

Thus $K_0$ has rank $k^2$. Every $K_s$ remains full column rank in a sufficiently small neighborhood.

The optimal-feedback output-pair law is

$$
T_s(y,z)=R_s(y)R_y(z).
\tag{5.7}
$$

Define the orthogonal-complement projector and residual

$$
\Pi_s=I-K_s(K_s^TK_s)^{-1}K_s^T,
\qquad z_s=\Pi_sT_s.
\tag{5.8}
$$

The symbol $z_s$ denotes a pair-output vector, not a channel state. We freely reshape it into an $m\times m$ matrix; its Euclidean norm then equals the Frobenius norm.

### Lemma 5.2. Nonzero common residual derivative

Let $L=\operatorname{col}W$, let $P_{L^\perp}$ be orthogonal projection onto its complement, and put

$$
Z=\bigl[P_{L^\perp}\operatorname{diag}(r)f\bigr](Wa)^T.
\tag{5.9}
$$

Then $Z\ne0$, and for every initial state

$$
z_s^\varepsilon=\varepsilon Z+O(\varepsilon^2).
\tag{5.10}
$$

**Proof.** At zero, $T_s=rr^T=K_0\operatorname{vec}(pp^T)$, so $z_s=0$. Let $b=Ap$ and $v=Wa$. Differentiate the target law (5.7) and the pair-output law generated by the fixed active input pair $pp^T$. Using (5.3), their derivative difference is

$$
T_s'-K_s'\operatorname{vec}(pp^T)
=f_svr^T+\operatorname{diag}(r)fv^T.
\tag{5.11}
$$

The range of $K_0$ is the space of matrices whose column and row spaces lie in $L$. Its orthogonal projector acts as $M\mapsto P_LMP_L$. The first term in (5.11) belongs to this range. The second has its right factor in $L$; its projection onto the complement is precisely (5.9).

For completeness, differentiating $\Pi_sK_s=0$ and using $T_s(0)=K_0pp^T$ gives

$$
z_s'(0)=\Pi_0\bigl(T_s'(0)-K_s'(0)pp^T\bigr),
$$

which justifies differentiation of the moving projection. It remains to show that (5.9) is nonzero. The vector $Wa$ is nonzero because $a\ne0$ and $W$ is injective. Also,

$$
f^TP_{L^\perp}\operatorname{diag}(r)f
=\sum_yr_yf_y^2>0,
\tag{5.12}
$$

because $f\in L^\perp$. Thus both factors are nonzero. Analyticity supplies the expansion, uniformly over the finite state set. $\square$

It follows that all $z_s^\varepsilon\ne0$ for sufficiently small nonzero $\varepsilon$. This establishes an active-input two-step obstruction. The next section treats inactive inputs and derives an operational capacity consequence without inferring an asymptotic gap from a finite-horizon mismatch alone.

## 6. Inactive-input costs and an operational gap certificate

### 6.1 Bellman slack identity

For a nearby positive channel with its solution from Lemma 3.1, define

$$
\Delta_s(x)=\rho+h_s-
D(Q_{s,:,x}\Vert R_s)-h^TQ_{s,:,x}.
\tag{6.1}
$$

The stationarity and KKT conditions imply

$$
\Delta_s(x)=0\quad(x\in S),\qquad
\Delta_s(x)>0\quad(x\notin S).
\tag{6.2}
$$

If inactive inputs exist, put

$$
\eta=\min_{s,x\notin S}\Delta_s(x)>0.
\tag{6.3}
$$

This number is bounded away from zero in a sufficiently small reference neighborhood.

### Lemma 6.1. Exact divergence and slack decomposition

For every input distribution $u$,

$$
\rho+h_s-I_s(u)-h^TQ_su
=D(Q_su\Vert R_s)+\sum_xu_x\Delta_s(x).
\tag{6.4}
$$

**Proof.** The divergence chain decomposition gives

$$
\sum_xu_xD(Q_{s,:,x}\Vert R_s)
=I_s(u)+D(Q_su\Vert R_s).
$$

Multiply (6.1) by $u_x$, sum over $x$, and rearrange. $\square$

For an arbitrary non-feedback input law on $X^N$, condition on the preceding output history. Its conditional next-input law is allowed to depend on that history through inference, although the encoder itself has no feedback. The no-feedback joint factorization and fresh channel randomness imply

$$
I(X^N;Y^N\mid Y_0=s_0)
=\sum_{t=1}^NI(X_t;Y_t\mid Y^{t-1},Y_0=s_0).
\tag{6.5}
$$

Applying (6.4) at each history and telescoping the bias yields

$$
\begin{aligned}
N\rho-I(X^N;Y^N\mid s_0)
={}&\mathbb Eh(Y_N)-h(s_0)\\
&+\sum_{t=1}^N\mathbb E\left[
D\bigl(P_{Y_t\mid Y^{t-1},s_0}\Vert R_{Y_{t-1}}\bigr)
+\Delta_{Y_{t-1}}(X_t)\right].
\end{aligned}
\tag{6.6}
$$

The first term is at least $-\operatorname{span}(h)$, where the span is the maximum component minus the minimum.

### 6.2 Separating active pairs while allowing inactive inputs

For a state with $z_s\ne0$, orthogonality in (5.8) gives

$$
\mathbb E_{K_s(:,i,j)}z_s=0\quad(i,j\in S),
\qquad
\mathbb E_{T_s}z_s=\|z_s\|_2^2>0.
\tag{6.7}
$$

Let $\operatorname{osc}(z_s)=\max z_s-\min z_s$, and define

$$
\delta_s=\frac{\|z_s\|_2^2}{\operatorname{osc}(z_s)}.
\tag{6.8}
$$

The denominator is positive. A nonzero constant vector could not be orthogonal to probability columns. Moreover the zero expectations in (6.7) imply $\min z_s\le0\le\max z_s$, whence $0<\delta_s\le1$.

Consider any conditional no-feedback input-pair law. Let $P$ be its output-pair law and let $\beta$ be the probability that at least one of its two inputs is inactive. The active portion has expectation zero against $z_s$. The remaining portion has expectation at most $\beta\max z_s\le\beta\operatorname{osc}(z_s)$. Therefore

$$
\operatorname{TV}(P,T_s)\ge(\delta_s-\beta)_+,
\qquad
D(P\Vert T_s)\ge2(\delta_s-\beta)_+^2.
\tag{6.9}
$$

The first inequality follows from the oscillation bound for a bounded statistic; the second is Pinsker's inequality in nats. The expected number of inactive inputs in this pair is at least $\beta$. By the KL chain rule, the pair's conditional contribution in (6.6) is at least

$$
2(\delta_s-\beta)_+^2+\eta\beta.
\tag{6.10}
$$

Thus using an inactive input to help reproduce the target output law pays a simultaneous Bellman penalty. Minimizing (6.10) over $\beta\in[0,1]$ gives

$$
\Phi(\delta,\eta)
=2\delta^2-2(\delta-\eta/4)_+^2>0.
\tag{6.11}
$$

Indeed the unconstrained minimizer is $(\delta-\eta/4)_+$, which belongs to $[0,1]$ because $\delta\le1$. If there are no inactive inputs, set instead

$$
\Phi(\delta)=2\delta^2,
\tag{6.12}
$$

since then $\beta=0$ exactly.

### Theorem 6.2. Uniform finite-horizon pair certificate

Suppose every initial state has $z_s\ne0$, and let $\Phi_*$ be the minimum of (6.11), or (6.12) in the all-active case, over states. For every initial state, every horizon, and every correlated nonstationary non-feedback input law,

$$
I(X^N;Y^N\mid s_0)
\le N C_f(Q)-\lfloor N/2\rfloor\Phi_*
+\operatorname{span}(h).
\tag{6.13}
$$

Consequently,

$$
C_f(Q)-C(Q)\ge\frac12\Phi_*>0.
\tag{6.14}
$$

**Proof.** Partition the observations into consecutive disjoint pairs. Condition on the complete output history at the beginning of each pair. Its joint input law can be arbitrary, but its pair-output channel is exactly (5.5), with the current state fixed by that history. The pair KL chain rule identifies its two divergence terms in (6.6) with $D(P\Vert T_s)$. Equations (6.10)–(6.12) give the lower bound $\Phi_*$ for every pair. Any final unpaired observation contributes a nonnegative cost. This proves (6.13).

For a code with $M$ equiprobable messages and error probability $P_e$, Fano's inequality and data processing give

$$
(1-P_e)\log M-h_2(P_e)
\le I(M;Y^N\mid s_0)
\le I(X^N;Y^N\mid s_0).
$$

Apply (6.13), divide by $N$, and let the error vanish. The bias span has no asymptotic effect. This proves the operational bound. $\square$

### Corollary 6.3. One obstructed state suffices

If $z_{s_*}\ne0$ for at least one state, define

$$
q_{\min}=\min_{s,x,y}Q(y\mid x,s)>0.
$$

Then

$$
C_f(Q)-C(Q)
\ge\frac{q_{\min}}2\Phi(\delta_{s_*},\eta)>0,
\tag{6.15}
$$

with the evident replacement from (6.12) when all inputs are active.

**Proof.** At every time after the first channel use, the unconditional probability of any prescribed state is at least $q_{\min}$, under every input strategy. Apply the preceding conditional-pair bound only to pairs starting in state $s_*$; every pair after the first has expected cost at least $q_{\min}\Phi(\delta_{s_*},\eta)$. There are $(\lfloor N/2\rfloor-1)_+$ such guaranteed pair opportunities. Divide the resulting version of (6.13) by $N$ and apply Fano's inequality. $\square$

Equations (6.13)–(6.15) distinguish a finite-pair obstruction from a strict operational capacity gap. They also explain why inactive columns cannot simply be omitted from a global capacity argument.

## 7. Generic strict gain and the local classification

### Proposition 7.1. Hypersurface containment

For $k<m$, the zero-gain channels in a sufficiently small neighborhood of $\overline W$ lie in a smooth real-analytic hypersurface of the full POST parameter space.

**Proof.** The set of strictly positive normalized state matrices is open in an affine space of dimension $mn(m-1)$. Lemma 3.1 makes the optimum analytic on a neighborhood. The pair matrices retain full column rank, so $K_s,T_s,\Pi_s,z_s$ are analytic there.

Fix one state $s$ and the nonzero matrix $Z$ from (5.9). Define the scalar analytic function

$$
F(Q)=\langle Z,z_s(Q)\rangle.
\tag{7.1}
$$

At the reference point $F=0$. Its derivative along the constructed path is

$$
\left.\frac{d}{d\varepsilon}F(Q^\varepsilon)\right|_0
=\|Z\|_2^2>0.
\tag{7.2}
$$

Shrink the neighborhood so the gradient remains nonzero. The regular-level-set theorem shows that $\{F=0\}$ is a smooth real-analytic hypersurface. Whenever $F(Q)\ne0$, the residual $z_s(Q)$ is nonzero and Corollary 6.3 proves $C_f(Q)>C(Q)$. Hence the zero-gain set is contained in $\{F=0\}$. A smooth hypersurface has measure zero and empty interior, and its complement is open and dense. $\square$

This is a containment theorem. Some points on the displayed hypersurface may still have strict feedback gain. We do not identify the hypersurface with the entire zero-gain locus.

**Proof of Theorem 2.1, parts 1–3.** For $k=m$, the independent active columns, positive active input probabilities, and strict unused-input gaps are precisely the relevant surjectivity conditions in [1, Theorem 1]; its theorem proves local equality. For $k<m$, Lemmas 4.1 and 5.2 construct arbitrarily small positive perturbations with nonzero residual at every state. Theorem 6.2 gives strict operational gain, ruling out a robust equality neighborhood. Proposition 7.1 gives the generic conclusion. $\square$

## 8. Quadratic lower and upper bounds along the path

Let $Z$ be the nonzero residual derivative in (5.9), and put

$$
d_0=\frac{\|Z\|_2^2}{\operatorname{osc}(Z)}>0.
\tag{8.1}
$$

The oscillation is nonzero because $Z$ is orthogonal to the positive baseline active pair columns and is not zero. Lemma 5.2 and the Lipschitz continuity of maximum and minimum on a finite-dimensional vector space give, for each state,

$$
\delta_s^\varepsilon=|\varepsilon|d_0+O(\varepsilon^2),
\tag{8.2}
$$

uniformly over the finite state set. If there are inactive inputs, their minimum slack stays bounded away from zero. Thus, for sufficiently small $|\varepsilon|$, $\eta\ge4\max_s\delta_s^\varepsilon$, and (6.11) equals $2(\delta_s^\varepsilon)^2$. Theorem 6.2 consequently yields

$$
C_f(Q^\varepsilon)-C(Q^\varepsilon)
\ge d_0^2\varepsilon^2-O(|\varepsilon|^3).
\tag{8.3}
$$

For the upper bound, use iid inputs drawn from the fixed baseline $p$, with zero mass outside $S$. Their output transition row is

$$
R_s^0=Q_{s,S}^\varepsilon p=r+\varepsilon f_sAp.
\tag{8.4}
$$

The invariant distribution of this positive output chain is exactly $r$, not just asymptotically so: $\sum_s r_sR_s^0=r$ because $r^Tf=0$. Its achievable non-feedback information rate is

$$
I_{\mathrm{iid}}=\sum_s r_s I_s(p;Q^\varepsilon).
\tag{8.5}
$$

Section 10 supplies an operational achievability proof. Average (6.4) under this stationary law. The active-input slack is zero, and the bias cancels. Therefore

$$
C_f(Q^\varepsilon)-I_{\mathrm{iid}}
=\sum_s r_sD(Q_{s,S}^\varepsilon p\Vert Q_{s,S}^\varepsilon p_s^\varepsilon).
\tag{8.6}
$$

By (5.3), the two distributions in each divergence differ to first order by $\varepsilon f_sWa$. Taylor expansion of KL at the positive vector $r$ gives

$$
C_f(Q^\varepsilon)-I_{\mathrm{iid}}
=U\varepsilon^2+O(|\varepsilon|^3),
\qquad
U=\frac12\left(\sum_s r_sf_s^2\right)a^TBa>0.
\tag{8.7}
$$

The remainder estimate holds for both signs of $\varepsilon$, because all channel, policy, and output probabilities remain in a compact positive neighborhood. Since $C(Q^\varepsilon)\ge I_{\mathrm{iid}}$, equations (8.3) and (8.7) prove (2.7) and part 4 of Theorem 2.1.

The argument supplies positive lower and upper coefficients. It does not interchange an infinite-block optimization with differentiation, and it does not assume that iid inputs achieve non-feedback capacity.

## 9. A full-rank three-input three-output example

The example labels inputs and outputs by $0,1,2$. Here $p$ and $p_s^\varepsilon$ include their zero inactive coordinate explicitly; $\overline W$ remains the full reference matrix.

### 9.1 The memoryless base point

Consider
$$
 \overline W=\begin{pmatrix}
  1/2&1/4&5/12\\
  1/4&1/2&5/12\\
  1/4&1/4&1/6
 \end{pmatrix},
 \qquad
 p=\begin{pmatrix}1/2\\1/2\\0\end{pmatrix},
 \qquad
 r=\overline Wp=\begin{pmatrix}3/8\\3/8\\1/4\end{pmatrix}.
 \tag{E1}
$$
All entries are positive and $\det \overline W=-1/48$, so the full channel is
invertible. Nevertheless the unique maximizing input has support
$S=\{0,1\}$, of size two. To verify this claim directly, the
divergence of either active column from $r$ is
$$
 C_0=\frac54\log2-\frac34\log3.
$$
For the third column $c=(5/12,5/12,1/6)^{\mathsf T}$, the KKT gap is
$$
 \gamma_0=C_0-D(c\Vert r)
   =\frac1{12}\log\frac{6^{13}}{10^{10}}>0,
 \tag{E2}
$$
since $6^{13}=13\,060\,694\,016>10^{10}$. The active columns have equal
divergence and the inactive column has strictly smaller divergence,
proving optimality by the information-radius identity. Strict
concavity on the segment between the two distinct active columns,
together with the strict inactive gap, proves uniqueness.

### 9.2 An affine POST perturbation

Let
$$
 f=(1,1,-3)^{\mathsf T},\qquad
 A=\begin{pmatrix}1&0&0\\-1&0&0\\0&0&0\end{pmatrix},
 \qquad
 Q_s^\varepsilon=\overline W+\varepsilon f_s A.
 \tag{E3}
$$
We have $\overline W_S^{\mathsf T}f=0$ and $\mathbf1^{\mathsf T}A=0$.
The kernels are positive for $|\varepsilon|<1/12$. Set
$a_0=3\log2-2$. Then the optimizing active input has sensitivity
$$
 p_s^\varepsilon=p+\varepsilon f_s(a_0,-a_0,0)^{\mathsf T}
                     +O(\varepsilon^2).
 \tag{E4}
$$
For completeness, reduce the two active columns to their first two
outputs, whose common total mass is $3/4$. Their normalized
output-zero probabilities are
$\alpha=2/3+(4/3)\varepsilon f_s$ and $\beta=1/3$.
Write $h_2(u)=-u\log u-(1-u)\log(1-u)$ for binary entropy. Define
$$
 \lambda(\alpha)=\frac{h_2(\alpha)-h_2(\beta)}{\alpha-\beta},\quad
 q(\alpha)=\frac1{1+e^{\lambda(\alpha)}},\quad
 t(\alpha)=\frac{q(\alpha)-\beta}{\alpha-\beta},
 \tag{E5}
$$
we have $\lambda(2/3)=0$, $\lambda'(2/3)=-3\log2$, and
$q'(2/3)=3\log2/4$. Thus
$t'(2/3)=9\log2/4-3/2$, which gives (E4) after multiplication
by $4f_s/3$. The atanh series
$\log2=2\sum_{j\ge0}((2j+1)3^{2j+1})^{-1}$ gives
$a_0>2/27>0$ from its first two summands.

The projection derivative in the general theorem becomes
$$
 Z=\operatorname{vec}\!\left[
     \frac3{11}f\,(a_0/4,-a_0/4,0)\right].
 \tag{E6}
$$
Indeed $\ker \overline W_S^{\mathsf T}$ is the line spanned by $f$,
$\|f\|^2=11$, and $f^{\mathsf T}\operatorname{diag}(r)f=3$.
Direct calculation gives
$$
 \|Z\|_2^2=\frac{9a_0^2}{88},\qquad
 \operatorname{osc}(Z)=\frac{9a_0}{22},\qquad
 \frac{\|Z\|_2^2}{\operatorname{osc}(Z)}=\frac{a_0}{4}.
$$
The all-state two-step lower bound and the fixed-iid upper bound
therefore imply
$$
 \frac{a_0^2}{16}
 \le\liminf_{\varepsilon\to0,\,\varepsilon\ne0}
       \frac{C_f(Q^\varepsilon)-C(Q^\varepsilon)}{\varepsilon^2}
 \le\limsup_{\varepsilon\to0,\,\varepsilon\ne0}
       \frac{C_f(Q^\varepsilon)-C(Q^\varepsilon)}{\varepsilon^2}
 \le\frac{a_0^2}{2}.
 \tag{E7}
$$
The bounds establish quadratic order; they do not identify an exact
second-order non-feedback capacity coefficient.

### 9.3 A certified finite perturbation: $\varepsilon=1/100$

At this value, the two distinct state matrices are
$$
 Q_0=Q_1=
 \begin{pmatrix}
 51/100&1/4&5/12\\
 6/25&1/2&5/12\\
 1/4&1/4&1/6
 \end{pmatrix},
 \qquad
 Q_2=
 \begin{pmatrix}
 47/100&1/4&5/12\\
 7/25&1/2&5/12\\
 1/4&1/4&1/6
 \end{pmatrix}.
 \tag{E8}
$$
Their determinants are $-13/600,-13/600,-11/600$, respectively,
and their smallest entry is $1/6$. Thus neither zero transition
probabilities nor a singular full state matrix account for the gain.

Use $\alpha_+=17/25$, $\alpha_-=47/75$, and $\beta=1/3$ in
(E5). Let $q_\pm,t_\pm$ denote the resulting values and set
$$
 R_\pm=(3q_\pm/4,\ 3(1-q_\pm)/4,\ 1/4),
 \qquad
 C_\pm=\frac34\{h_2(q_\pm)-t_\pm h_2(\alpha_\pm)
                         -(1-t_\pm)h_2(\beta)\}.
 \tag{E9}
$$
The interval certificate proves $0<t_\pm<1$. The optimal output
rows are $R_0=R_1=R_+$, $R_2=R_-$. A Bellman bias and value are
$$
 V(0)=V(1)=0,\qquad V(2)=v:=C_--C_+,\qquad
 C_f=\frac34C_++\frac14C_-.
 \tag{E10}
$$
This bias uses a different additive normalization from Section 3; shifting a bias by a constant changes neither its Bellman equation nor its slacks. Both active columns give output two with probability $1/4$, so
their bias contribution is constant $v/4$ and (E5) maximizes the
Bellman objective over the active segment. The inactive column gives
output two with probability $1/6$; its Bellman slack is exactly
$$
 \Delta_\pm=C_\pm-D(c\Vert R_\pm)+v/12.
 \tag{E11}
$$
The certificate gives $\min(\Delta_+,\Delta_-)>0.0107702150567$.
Thus these are also the global Bellman optimizers over all three
inputs, by concavity and the strict inactive KKT inequalities.

For each initial state $s$, form the rational $9\times4$ block
matrix
$$
 K_s((y,z),(x,x'))=Q_s(y\mid x)Q_y(z\mid x'),
 \qquad x,x'\in\{0,1\}.
$$
The program computes $(K_s^{\mathsf T}K_s)^{-1}$ with exact rational
Gaussian elimination and verifies a positive Gram determinant. It
also checks the orthogonal-projection identities exactly. With the
optimal target $T_s(y,z)=R_s(y)R_y(z)$, it encloses
$$
 z_s=\bigl[I-K_s(K_s^{\mathsf T}K_s)^{-1}K_s^{\mathsf T}\bigr]T_s,
 \qquad
 \delta_s=\frac{\|z_s\|_2^2}{\operatorname{osc}(z_s)}.
 \tag{E12}
$$
For every initial state the program proves
$$
 0.000159406571430390463293143461
  \le\delta_s\le
 0.000159406571430390463293143462,
 \qquad
 \min_s\Delta_s>4\max_s\delta_s.
 \tag{E13}
$$
The active-support/inactive-slack bridge now yields
$C_f-C\ge\min_s\delta_s^2$. The fixed iid input in (E1) has
the exact stationary output-state law $r$, and the exact upper
bound is
$C_f-C\le\sum_s r_sD(Q_sp\Vert R_s)$. Rational interval
evaluation proves the concise bounds
$$
 \boxed{
 \frac{2541}{10^{11}}
  < C_f(Q^{1/100})-C(Q^{1/100})
  < \frac{231544}{10^{12}}
 \quad\text{nats per channel use}.}
 \tag{E14}
$$
For orientation, the certified lower expression is approximately
$2.5410455015\times10^{-8}$, the iid upper expression is
approximately $2.3154350048\times10^{-7}$, and
$C_f$ is approximately $0.0427195462160$ nats per use.
The strict rational inequalities in (E14), not rounded floating-point
estimates, are the asserted numerical result.

### 9.4 Arithmetic and reproduction scope

The case package contains the scripts and JSON results at the relative paths below. In the three-file public release, the same text files are embedded in `verification.json` under `reproduction.files`, with a SHA-256 manifest; they can be extracted to those relative paths before running the commands. The arithmetic certificate is thus available without access to the private working repository.

Run from the case directory:

```sh
python code/verify_certificate.py
python code/check_finite_identity.py
```

The first command writes `results/certificate.json`. All acceptance
decisions use exact `Fraction` endpoints, rounded outward to 160-bit
dyadic intervals. For $\log u$, range reduction gives
$1\le u\le2$ and the atanh series has remainder bounded by
$$
 \frac{2z^{2N+1}}{(2N+1)(1-z^2)},\qquad z=(u-1)/(u+1)\in[0,1/3].
$$
For $e^x$, range reduction gives $0\le x\le1$, and the
Taylor remainder after degree $N$ is at most its first omitted
term divided by $1-x/(N+2)$. Reciprocals and squaring cover the
other arguments. Both use $N=80$. Every arithmetic operation
rounds its lower endpoint down and its upper endpoint up. Finite
matrix inversion and projection identities use rational arithmetic
without rounding. No floating-point result is used to certify (E14).

The second command is a separate floating-point finite-identity
check. It enumerates 19,683 joint paths at horizon four for a different
positive POST channel and an explicitly correlated, nonstationary,
initial-state-dependent input law. It checks the exact theorem's
mutual-information/KL/slack identity and posterior block
factorization to numerical precision. Its JSON explicitly disclaims
a capacity-gain claim. It supplies an independent implementation
check and is not part of the rigorous interval certificate.

Neither program is Lean code or claims kernel-checked formalization.
The operational implication of the arithmetic bounds is supplied by
the proved finite-horizon bridge, not inferred from a single-block
simulation.

## 10. Operational interpretation and self-contained achievability

This section proves the coding assertions used above. It also makes explicit that the encoder need not know the channel's initial state.

### 10.1 Converse for the Bellman value

For a feedback code and any fixed initial state, condition on the preceding output history. Given the current input and preceding output, the next output is independent of the message and earlier variables. Data processing therefore bounds the one-step message information by $I_s(u)$, where $u$ is the conditional input law at that history. The Bellman inequality gives

$$
I_s(u)\le\rho+h_s-h^TQ_su.
$$

Sum over time, telescope the bias, and use the chain rule:

$$
I(M;Y^N\mid s_0)\le N\rho+\operatorname{span}(h).
\tag{10.1}
$$

Fano's inequality implies $C_f(Q)\le\rho$. The same conclusion holds with stochastic encoders by the conditional data-processing inequality.

### 10.2 Random code trees attain a stationary feedback policy

Fix a stationary policy $p_s$ on the active inputs, and let $R_s=Q_{s,S}p_s$. For now fix a common initial state. Independently for every message, draw a random code tree: at each node whose preceding output is $s$, draw the next input according to $p_s$, independently of all other tree nodes. Once drawn, these trees are deterministic codebooks available to both parties.

For a candidate message and a received output word, follow the candidate's unique tree path and calculate

$$
\imath_N=\sum_{t=1}^N
\log\frac{Q(Y_t\mid X_t,Y_{t-1})}{R_{Y_{t-1}}(Y_t)}.
\tag{10.2}
$$

For the true message, the generated process is a finite positive Markov state chain with actions drawn from $p_s$. Its information-density increments are bounded. The finite-state ergodic theorem, equivalently a Markov-reward law of large numbers, gives

$$
\frac{\imath_N}{N}\longrightarrow
J_{\mathrm{pol}}:=\sum_s\pi_s I_s(p_s)
\quad\text{in probability},
\tag{10.3}
$$

where $\pi$ is the invariant state law. An elementary justification is to subtract the conditional mean of each bounded increment, apply the martingale law of large numbers to the difference, and average the conditional means under the positive finite state chain.

For every fixed received word, an incorrect independently generated tree satisfies

$$
\mathbb E_{\mathrm{tree}}e^{\imath_N}
=\prod_{t=1}^N\sum_xp_{Y_{t-1}}(x)
\frac{Q(Y_t\mid x,Y_{t-1})}{R_{Y_{t-1}}(Y_t)}=1.
\tag{10.4}
$$

Symbols along the fixed candidate path are independent because they occupy different tree nodes. Decode a unique candidate exceeding a threshold $a_N$, with an arbitrary failure rule when uniqueness fails. Markov's inequality and the union bound give average expected error at most

$$
\Pr\{\imath_N^{\mathrm{true}}\le a_N\}
+(M-1)e^{-a_N}.
\tag{10.5}
$$

Choose $a_N=N(J_{\mathrm{pol}}-\gamma)$ and any rate below $J_{\mathrm{pol}}-2\gamma$. Both terms vanish. Some deterministic tree codebook realizes the average bound. For a Bellman-optimal policy, stationary averaging of (3.2) gives $J_{\mathrm{pol}}=\rho$. Together with (10.1), this proves $C_f(Q)=\rho$.

To remove common initial-state knowledge, first send one fixed dummy input independent of the message. Its output is observed by the receiver and revealed to the encoder through feedback. It is then a legitimate shared state for the remaining code. Construct continuation tree codebooks for each possible observed state. Since there are only finitely many such states, averaging the sum of their conditional errors yields a deterministic family with uniformly vanishing error. The single dummy use has a vanishing rate cost. This construction obeys the usual feedback-encoder definition, in which only past outputs are available.

### 10.3 Iid inputs give an achievable non-feedback rate

Fix an input distribution $p$, independent of the state and used iid. The output is a positive Markov chain with rows $R_s^0=Q_sp$. Draw a conventional iid random codebook from $p^{\otimes N}$. The same information density as (10.2), with $R^0$ in the denominator, obeys a Markov-reward law of large numbers with limit

$$
\sum_s\pi_s^0I_s(p).
\tag{10.6}
$$

For every fixed output word and every independent incorrect codeword, its exponential moment equals one by the same product calculation as (10.4). The threshold-decoding bound (10.5) therefore proves non-feedback achievability of every rate below (10.6).

The codebook need not depend on the initial state. In the first likelihood numerator and denominator factors, use any fixed reference state. Strict positivity bounds the difference from the correct first factors by a constant independent of $N$. Subsequent factors use the actually observed preceding output and are exact. This bounded change does not alter (10.6). There are finitely many possible true initial states, so a deterministic codebook may be chosen whose largest conditional error tends to zero. This establishes the iid lower bound used in Section 8 under the stated worst-initial-state operational convention.

## 11. Scope, verification, and remaining questions

The classification is local and covers every reference channel obeying (2.1)–(2.3). Its necessity direction is not merely a generic statement: Lemma 4.1 supplies a useful perturbation at every such support-deficient reference point. The generic statement concerns the full nearby POST parameter space after that construction is established.

Strict positivity guarantees smooth entropy expressions, stable finite-state initialization, and a uniform state-visitation bound. Full column rank of the active subchannel gives strict concavity and injectivity of the pair-output map at the reference point. Strict inactive KKT gaps prevent arbitrarily cheap use of excluded inputs. The proof does not cover violations of these assumptions. In particular, support-transition strata and singular active subchannels require separate analysis.

A finite numerical certificate for a specified channel must include the channel entries, the Bellman optimum and bias with justified error control, the active support and inactive gap, the matrices $K_s$, the residuals $z_s$, their oscillations, and the resulting bound (6.11)–(6.14). Floating-point small residuals alone are not proof. The accompanying example and reproduction materials distinguish exact symbolic checks from exploratory computation.

The exact second-order coefficient of the operational gain remains undetermined by this argument. Equation (2.7) proves its positive quadratic scale without assuming an optimal finite-memory non-feedback source. The codimension-one set in Proposition 7.1 is an explicit containing hypersurface, not a full classification of the local zero-gain variety.

The full-output-rank implication is inherited from [1]. The necessary direction and its quantitative and generic consequences are proved in this manuscript. The repository precursor [4] is credited for the finite-block separation approach; it is an internally reviewed research manuscript, not external peer-review certification. The final full text associated with [3] was unavailable, so the novelty comparison retains that precise access limitation. No statement of worldwide priority or external academic certification is made.

The paper supplies written proofs of the sensitivity lemma, analytic optimizer construction, pair residual calculation, inactive-input divergence identity, finite-horizon and operational arguments, genericity, asymptotic estimates, and the exact example.

## References

1. Xiaojing Zhang, Jun Chen, Guanghui Wang. *Feedback Does Not Increase the Capacity of Approximately Memoryless Surjective POST Channels*. arXiv:2603.08886v1, 9 March 2026. [Full inspected arXiv text](https://arxiv.org/html/2603.08886v1). Theorem 1 supplies the sufficient direction; Section V identifies further structural questions.
2. Haim H. Permuter, Himanshu Asnani, Tsachy Weissman. *Capacity of a POST Channel with and without Feedback*. arXiv:1309.5440v1, 2013; IEEE Transactions on Information Theory 60(10), 6041–6057, 2014, DOI 10.1109/TIT.2014.2343232. [arXiv record](https://arxiv.org/abs/1309.5440).
3. McMaster Experts, official publication metadata for Zhang–Chen–Wang, DOI 10.1109/TIT.2026.3729399. [Official record](https://experts.mcmaster.ca/scholarly-works/3983483). Metadata and abstract inspected on 25 November 2026; final article full text not obtained.
4. *Binary POST feedback: finite certificates*. Repository research manuscript, especially Appendix A.5–A.6. Fixed public primary package. Its binary classification and finite-block methods are prior repository work; full formalization and external peer review are separate matters.
5. Photios A. Stavrou, Charalambos D. Charalambous, Christos K. Kourtellaris. *Sequential Necessary and Sufficient Conditions for Capacity Achieving Distributions of Channels with Memory and Feedback*. [arXiv:1604.02742v2](https://arxiv.org/html/1604.02742v2), 2016. The source audit inspected the methods, main conclusions, and stated application scope.
6. Christos K. Kourtellaris, Charalambos D. Charalambous, Ioannis Tzortzis. *Single Letter Expression of Capacity for a Class of Channels with Memory*. [arXiv:1701.01007v1](https://arxiv.org/pdf/1701.01007v1), 2017. The source audit inspected Theorem II.2, its subsequent explanation, and the application scope.
7. Jun Chen, Yuta Sakai. *The Asymptotic Capacity of the Grabbag Channel With and Without Feedback*. [arXiv:2611.24700v1](https://arxiv.org/abs/2611.24700v1), 18 November 2026. Official abstract and version record only; full text not obtained and no theorem from this source is used in the proof.
