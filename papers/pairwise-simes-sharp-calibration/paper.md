# Exact Simes calibration under finite-order independence

## Abstract

For any fixed $r\ge2$, we determine the leading constant in the largest excess of the Simes rejection probability over its nominal level for $r$-wise independent null p-values. Uniformly along every joint path $m\to\infty$ and $\alpha\to0$, the excess is asymptotic to $((r-1)/r)^{r-1}\alpha^r\log\min(m,1/\alpha)$. With the same independence through degree $r-1$ and only the degree-$r$ factorial bound at common thresholds, the constant rises to $r$. Counts in narrow geometric intervals give the upper bound under full mixed-moment information. A mixture of multinomial configurations at all integer scales spends this budget asymptotically optimally. We also show that a sparse multinomial moment problem admits exact completion from its highest-degree inequalities. This gives a level-independent finite packing problem for the exact small-level Simes calibration, a constructive optimizer, and a general finite-grid calibration with tolerances on mixed moments.

## 1. Framework and results

Let $p_1,\ldots,p_m$ be $r$-wise independent uniform random variables on $[0,1]$. Write $p_{(1)}\le\cdots\le p_{(m)}$ for their order statistics and
$$
S_m=\min_{1\le j\le m}\frac{m p_{(j)}}j,\qquad
M_{m,r}(\alpha)=\sup\Pr(S_m\le\alpha),
$$
where the supremum is over all such Borel joint laws. Complete independence gives $M_{m,m}(\alpha)=\alpha$ by the Simes identity [1]. Throughout, $r$ is fixed. The regime of interest includes $m$ much smaller or much larger than $1/\alpha$.

**Theorem 1 (Sharp joint asymptotic).** Put $b_{m,\alpha}=\min(m,1/\alpha)$ and $\lambda_r=((r-1)/r)^{r-1}$. Along every sequence with $m\to\infty$ and $0 < \alpha\to0$,
$$
\frac{M_{m,r}(\alpha)-\alpha}{\alpha^r\log b_{m,\alpha}}
\longrightarrow \lambda_r.
\tag{1}
$$
Replacing uniform marginals by arbitrary superuniform ones preserves the supremum for every $m,r,\alpha$. For $m\le r$ it is exactly $\alpha$.

For a target size $u$, let $\alpha^\star_{m,r}(u)=\sup\{\alpha\in[0,1]:M_{m,r}(\alpha)\le u\}$. The theorem implies
$$
u-\alpha^\star_{m,r}(u)
=(\lambda_r+o(1))\,u^r\log\min(m,1/u)
\tag{2}
$$
along every $m\to\infty$, $u\downarrow0$. Section 4 gives exact finite calibration throughout a sparse regime by solving a single degree-$r$ packing problem independent of $\alpha$. It also gives an exact reduction for other finite-grid tests and for approximate factorial moments. The finite optimization can be large even when the number of moment constraints is polynomial for fixed $r$.

## 2. Low and very high ranks

Write $q=\alpha/m$, $N(y)=\#\{i:p_i\le y\}$, and $A_{ < r}=\{\exists j < r:N(jq)\ge j\}$. For $m>r$,
$$
\Pr(A_{ < r})=\alpha+O_r(\alpha^r)
\tag{3}
$$
uniformly over the allowed laws as $\alpha$ decreases to zero. For the comparison, let $B=\{i:p_i\le(r-1)q\}$ and evaluate the event $A_{ < r}$ on any subset of the coordinates, setting excluded coordinates to one. Its subset Möbius transform at $S$ has absolute value at most $2^{|S|}$. Sum the transform over subsets of $B$ of size at most $r-1$. For $|B| < r$ this is the true event indicator by inversion. Otherwise the difference is bounded by
$$
1+\sum_{\ell < r}2^\ell\binom{|B|}{\ell}\le C_r\binom{|B|}{r}.
$$
The truncated transform has the same expectation as under independence because each term only uses the coordinates in one subset of size less than $r$. The expected error is $O_r(\alpha^r)$ under either law by the $r$th factorial moment of $|B|$. Under independence, the total probability of a rejection at any $j\ge r$ is at most $\sum_{j\ge r}\binom mj(jq)^j\le\sum_{j\ge r}(e\alpha)^j$. The Simes identity gives (3). A rejection at each particular $j\ge r$ also has probability at most $(m)_r(jq)^r/(j)_r=O_r(\alpha^r)$, uniformly in $j$.

A separate estimate will remove all ranks beyond $K=\min(m,\lfloor1/\alpha\rfloor)$. We use $(v)_s=v(v-1)\cdots(v-s+1)$ for falling factorials.

**Lemma 1 (Tail beyond $1/\alpha$).** For $\alpha\le1/4$,
$$
\Pr\{\exists j>K:N(jq)\ge j\}\le C_r\alpha^r.
\tag{4}
$$

Proof. Only $K < m$ matters. Use dyadic rank blocks $s\le j < 2s$, starting at $s=K+1$ and doubling, with $s\le m$. Write $N_s=N(q\min(2s,m))$ and $\mu_s=E N_s$. Any crossing on the block gives $N_s\ge s$. Here $1\le\mu_s\le2\alpha s$ and $s-\mu_s\ge s/2$. For each integer $\ell\in[2,r]$, the central moment $E(N_s-\mu_s)^\ell$ is the same as for independent Bernoulli variables because the polynomial uses at most $\ell$ distinct coordinates. The independent expansion has no terms with a singleton centered factor. In any surviving term involving $v$ distinct variables, the expectation has absolute value at most $u^v$ with $u=q\min(2s,m)$, since a centered Bernoulli lies in $[-1,1]$ and its second moment is at most $u$. The number of terms is at most $C_\ell m^v$ at each $v\le\lfloor\ell/2\rfloor$. Consequently the absolute value of each central moment is bounded by $C_\ell\mu_s^{\lfloor\ell/2\rfloor}$ for $\mu_s\ge1$.

If $r=2h$, use the nonnegative statistic $(N_s-\mu_s)^r$. Markov's inequality gives a probability of crossing at most $C_r\alpha^r(\alpha s)^{-h}$. If $r=2h+1$, use the nonnegative statistic $N_s(N_s-\mu_s)^{r-1}$. Its expectation equals $\mu_s E(N_s-\mu_s)^{r-1}+E(N_s-\mu_s)^r\le C_r\mu_s^{h+1}$. On crossing it is at least $s(s/2)^{r-1}$. The probability bound is again $C_r\alpha^r(\alpha s)^{-h}$. Summing over the blocks proves (4). ∎

## 3. Geometric factorial costs

Take any $b>1$ and define $s_{-1}=0$, $s_i=\lceil b^i\rceil$ for $i\ge0$. The $i$th band of rank indices has nominal length $\ell_i=s_i-s_{i-1}$. Up to the first index $n_K$ with $s_{n_K}\ge K$, use the bins $((j-1)q,jq]$ in each band, cutting the last band at $K$. Write $C_i$ for the total count in the band. Set
$$
U=\sum_{\substack{i\le n_K\\\ell_i>0}}\frac{(C_i)_r}{\ell_i^r},\qquad \nu_r=(m)_r q^r.
$$
Each expectation in the sum is at most $\nu_r$ because the band length in p-value units is at most $q\ell_i$. Thus $E U\le(n_K+1)\nu_r$. This uses only a one-bin factorial moment for each band.

If there is a crossing at rank $j\le K$, let $n$ be the first index with $s_n\ge j$. Then $\sum_{i\le n}C_i\ge j$. For an integer $C_i\ge0$,
$C_i\le(r-1)+((C_i)_r)^{1/r}$, since the smallest positive factor of $(C_i)_r$ is $C_i-r+1$ when $C_i\ge r$. Hölder's inequality with exponent $p=r/(r-1)$ gives the deterministic bound
$$
U\ge
 \frac{[j-(r-1)(n+1)]_+^r}{(\sum_{i=0}^n\ell_i^p)^{r-1}}.
\tag{5}
$$
Zero-length bands contribute no counts. For fixed $b$, as $n\to\infty$,
$$
\frac{\sum_{i=0}^n\ell_i^p}{b^{pn}}
\longrightarrow \frac{(1-b^{-1})^p}{1-b^{-p}}.
$$
Indeed $\ell_i/b^i\to1-b^{-1}$ and the sum in reverse index is a geometrically dominated convolution. Since $j>s_{n-1}\ge b^{n-1}$ for $n\ge1$, (5) implies that for any $\epsilon>0$ sufficiently small there is $j_0=j_0(r,b,\epsilon)$ such that a crossing at $j_0\le j\le K$ forces
$$
U\ge  (1-\epsilon)\frac{(1-b^{-p})^{r-1}}{(b-1)^r}.
\tag{6}
$$
This also supplies a direct finite bound by taking the minimum of the explicit expression in (5) over eligible ranks.

Apply Markov's inequality to (6). The ranks below $j_0$ give at most $\alpha+O_{r,j_0}(\alpha^r)$ by (3) and the individual factorial estimate, and the ranks past $K$ are covered by Lemma 1. Along the paths of Theorem 1, $\log K/\log b_{m,\alpha}\to1$, $\nu_r/\alpha^r\to1$, and $n_K=\log K/\log b+O_b(1)$. We obtain
$$
\limsup \frac{M_{m,r}(\alpha)-\alpha}{\alpha^r\log b_{m,\alpha}}
\le \frac{(b-1)^r}{(1-\epsilon)\log b\,(1-b^{-p})^{r-1}} .
$$
First send $\epsilon$ to zero at fixed $b$ and then $b$ to one from above. The last expression tends to $p^{1-r}=\lambda_r$.

## 4. Exact completion of sparse factorial moments

Consider $m$ coordinates and disjoint intervals with probabilities $q_i>0$ for $1\le i\le K$, and a remaining interval of probability $1-Q$, with $Q=\sum_i q_i$. Let $c=(c_i)$ denote counts in these $K$ intervals, so $|c|\le m$. For a multi-index $a$ write $|a|=\sum_i a_i$, $\binom ca=\prod_i\binom{c_i}{a_i}$, and $a!=\prod_i a_i!$. The independent target moments are
$$
h^0_a=\frac{(m)_{|a|}}{a!}\prod_i q_i^{a_i}
\quad(0\le|a|\le r).
$$
Throughout this section take $2\le r\le m$. Symmetrizing the joint law does not change any count statistic. Conversely, any count law with these moments is realized by $r$-wise independent uniform coordinates when the intervals partition $[0,1]$ with their lengths equal to their probabilities. Conditional on counts, allocate the coordinate labels uniformly, then sample independently and uniformly within the assigned intervals. For up to $r$ labels the joint assignment probabilities are determined by the mixed falling factorials. The count in the remaining interval is $m-|c|$, so products involving it are polynomials of degree at most $r$ in the other counts and are also matched. This proves the continuous realization. With imperfect moments and exact first moments, the same allocation gives exactly uniform marginals and the stipulated imperfect counts.

Let $\mathcal H=\{c:r < |c|\le m\}$. A proposed high-count measure $\zeta=(\zeta_c:c\in\mathcal H)$ is nonnegative and only specified on $\mathcal H$.

**Theorem 2 (Exact completion).** Let $0\le\eta < 1$, and let prescribed moments $h_a$ lie in $[(1-\eta)h^0_a,(1+\eta)h^0_a]$ for $1\le|a|\le r$, with $h_0=1$. If
$$
mQ\le\log\frac{2}{1+\eta},
\tag{7}
$$
then $\zeta$ extends to a probability law with precisely the moments $h_a$ if and only if
$$
\sum_{c\in\mathcal H}\zeta_c\binom ca\le h_a
\qquad (|a|=r).
\tag{8}
$$
The extension is obtained by filling the single states of sizes $r,r-1,\ldots,1$ in that order and using the zero state for the remaining probability.

Proof. Necessity follows from nonnegativity. At degree $r$ fill the masses at $c=a$, $|a|=r$, to match the missing moments exactly. Each required mass is nonnegative by (8), since the state $a$ contributes with coefficient one to its own moment and zero to the other degree-$r$ moments. Let $\nu$ denote the high measure plus these degree-$r$ states. For $s=|a| < r$, the identity
$$
\sum_{\substack{d\ge a\\|d|=r}}\binom cd\binom da
=\binom ca\binom{|c|-s}{r-s}
$$
shows that the contribution of $\nu$ to the moment indexed by $a$ is at most $\sum_{d\ge a,|d|=r}\binom da h_d$. At any subsequently filled degree $k < r$ every added mass at $d$ is at most $h_d$, by nonnegative contributions and a unit diagonal coefficient. The contamination at a degree-$s$ moment from already filled states is therefore at most
$$
(1+\eta)\sum_{k=s+1}^r\sum_{\substack{d\ge a\\|d|=k}}\binom da h^0_d
=(1+\eta)h^0_a\sum_{k=s+1}^r
 \frac{(m-s)_{k-s} Q^{k-s}}{(k-s)!}
\le (1+\eta)h^0_a(e^{mQ}-1).
$$
By (7) this is at most $(1-\eta)h^0_a\le h_a$. The descending construction continues with nonnegative masses. Their total on nonzero states is at most their expected total count, $\sum_i h_{e_i}\le(1+\eta)mQ\le\log 2 < 1$, where $z\log(2/z)$ decreases on $[1,2)$. Filling zero completes the law. ∎

For any finite-grid objective $F(c)$, define the degree-$r$ truncated Newton polynomial
$$
\Phi_F(c)=\sum_{|a|\le r}d_a\binom ca,\qquad
d_a=\sum_{v\le a}(-1)^{|a|-|v|}\binom av F(v).
$$
This agrees with $F(c)$ whenever $|c|\le r$. Therefore under (7) the worst-case expected objective, with each mixed moment constrained to its chosen interval inside the stated relative tolerance, equals the finite linear program
$$
\max_{\zeta\ge0,\ h}
\left\{\sum_{|a|\le r}d_a h_a+
 \sum_{c\in\mathcal H}\zeta_c\{F(c)-\Phi_F(c)\}:
 h_a\text{ in its interval},\ h_0=1,\ \text{(8)}\right\}.
\tag{9}
$$
Necessity follows from the expectation identity and (8), and sufficiency follows by constructively completing the optimizing high measure. Every high atom consumes a positive amount of at least one degree-$r$ budget, so (9) has a compact feasible set. Exact first moments can be imposed as singleton intervals. With exact moments, an optimal basic feasible high measure may be chosen with at most $\binom{K+r-1}{r}$ positive high atoms by linear programming with that many inequality constraints. There is no claim about polynomial-time optimization over their exponentially many possible locations.

Apply (9) to the $m$ Simes intervals of equal length $q=\alpha/m$ and
$F(c)=\mathbf 1\{\exists j:\sum_{i\le j}c_i\ge j\}$. With exact moments and $m\alpha\le\log2$, write $\zeta=\nu_r z$, where $\nu_s=(m)_s q^s$. Then
$$
M_{m,r}(\alpha)=\sum_{|a|\le r}d_a\,\nu_{|a|}/a!+\nu_r L_{m,r},
\quad
L_{m,r}=\max_{z\ge0}\left\{\sum_{c\in\mathcal H}z_c(F-\Phi_F)(c):
\sum_{c\in\mathcal H}z_c\prod_i(c_i)_{a_i}\le1\ \ (|a|=r)\right\}.
\tag{10}
$$
For $m>r$ this is a polynomial in $\alpha$ on the stated interval. The optimizer $z$ can be reused for every level on that interval, with the lower-state probabilities determined by completion. For example, for $(m,r)=(3,2)$ the only positive scores are one at each of $(3,0,0),(0,0,3),(0,1,2)$. The first and third bin budgets give $L_{3,2}\le1/6+1/2$, attained by using the first and third listed configurations. The polynomial part in (10) is $\alpha$, giving $\alpha+4\alpha^2/9$. This illustrates the general reduction at a dimension where direct constructions also give the polynomial beyond the guaranteed completion interval.

## 5. A matching construction at all integer scales

Take $K=\min(m,\lfloor1/(4\alpha)\rfloor)$, retain the first $K$ Simes intervals, and combine all later p-values into the remaining interval. The exact completion condition (7) holds. Choose an integer $j_0>r$ and put $p=1/(r-1)$ in this section. For each integer $j_0\le j\le K$, propose a count configuration of total size $j$, generated by $j$ independent allocations among bins $i=r+1,\ldots,j$, with probabilities
$$
P_{ij}=\frac{i^p}{\sum_{\ell=r+1}^j \ell^p}.
$$
Give this multinomial law mixture weight $w_j=\Lambda_{r,j_0}\nu_r/j$, where
$$
\Lambda_{r,j_0}=\frac{pr}{(p+1)^r}\,
\frac{(1-(r/j_0)^{p+1})^r}{1+pr/j_0}.
$$
Every cluster rejects at rank $j$, while every cluster avoids $A_{ < r}$. We check (8) simultaneously. A mixed falling factorial of degree $r$ vanishes on this proposal if it uses any bin of index at most $r$. Otherwise let $v$ be the largest bin index used and $L=\max(v,j_0)$. The multinomial formula gives its expectation at scale $j$ as $(j)_r\prod_i P_{ij}^{a_i}$. Since
$$
\sum_{\ell=r+1}^j\ell^p\ge\frac{j^{p+1}-r^{p+1}}{p+1},
\qquad
\sum_{j\ge L}j^{-1-pr}\le \frac{1+pr/j_0}{pr} L^{-pr},
$$
the combined moment from all these scales is bounded by
$$
\nu_r\Lambda_{r,j_0}
 \frac{(p+1)^r}{(1-(r/j_0)^{p+1})^r}
 v^{pr}\frac{1+pr/j_0}{pr}L^{-pr}\le\nu_r.
$$
Thus the lower-degree fill extends the proposal to an exact $r$-wise independent uniform copula. In the extended law the mass of the high-count component is $\sum_{j=j_0}^K w_j$, disjoint from the early event. By (3),
$$
M_{m,r}(\alpha)-\alpha
\ge \Lambda_{r,j_0}\nu_r\sum_{j=j_0}^K\frac1j-O_r(\alpha^r).
$$
At fixed $j_0$ the sum is asymptotic to $\log b_{m,\alpha}$ along the joint paths. Then $j_0\to\infty$ gives $\Lambda_{r,j_0}\to pr/(p+1)^r=\lambda_r$. Together with Section 3 this proves (1) for uniform margins.

## 6. Dependence information at common thresholds

For comparison, let $M^{\rm diag}_{m,r}(\alpha)$ be the worst Simes size if the variables are only $(r-1)$-wise independent uniforms, with the additional inequalities
$$
E(N(u))_r\le(m)_r u^r\qquad(0\le u\le1).
\tag{11}
$$
This allows non-product $r$-coordinate laws. For $r=2$, (11) is equivalent to a nonpositive common-threshold correlation constraint after exchangeable symmetrization. Indeed, a uniform permutation preserves all counts, and in an exchangeable law the left side divided by $(m)_2$ is the joint probability that a specified pair is at most $u$. It is also equivalent to a variance upper bound by the binomial variance, because $E N(u)=mu$.

**Theorem 3 (Common-threshold information).** Along every path in Theorem 1,
$$
\frac{M^{\rm diag}_{m,r}(\alpha)-\alpha}{\alpha^r\log b_{m,\alpha}}\longrightarrow r .
\tag{12}
$$

Proof of the upper bound. In Section 2, every lower-degree polynomial still has its independent expectation, while the early truncation error is bounded by (11). Thus (3) continues to hold. Lemma 1 also applies, because each nonnegative test polynomial used there has degree $r$ and leading coefficient one. Its expectation is bounded above by its independent expectation using (11) and exact moments up to degree $r-1$. For the ranks $r$ through $K=\min(m,\lfloor1/\alpha\rfloor)$, the nonnegative certificate
$$
W=\sum_{s=r}^{K-1}\left(\frac1{(s)_r}-\frac1{(s+1)_r}\right)(N(sq))_r
+\frac{(N(Kq))_r}{(K)_r}
$$
is at least one on any crossing in this range. This follows by keeping $s\ge j$ after a crossing at $j$, bounding the monomials below by $(j)_r$ and summing the telescoping weights. For $s\ge r$,
$$
s^r\left(\frac1{(s)_r}-\frac1{(s+1)_r}\right)
=\frac{r\,s^r}{(s+1)(s)_r}=\frac r s+O_r(s^{-2}).
$$
The expectation in (11) then gives $E W\le\nu_r(r\log K+O_r(1))$. Combining the three rank ranges proves the upper bound in (12).

Proof of the lower bound. Let $K=\min(m,\lfloor1/(4\alpha)\rfloor)$ as above. Fix $0 < \beta < 1$ and put $h=1-\beta$. Choose $j_0\ge2r$ with $hj_0>r+1$. At each $j_0\le j\le K$ use configurations of total size $j$, allocating each of the $j$ points independently and uniformly to the bins $\lceil hj\rceil,\ldots,j$. Give the configuration law mass
$$
w_j=\nu_r(h-1/j_0)^r\frac{j^r-(j-1)^r}{(j)_r}.
\tag{13}
$$
It rejects at $j$ and avoids all early crossings. Consider a threshold $u=xq$ with $0\le x\le K$, allowing real $x$. A cluster can contribute only if $hj < x+1$ because of its smallest bin. If there is any such cluster, $x+1\ge hj_0$. Its conditional factorial count at that threshold is bounded above by $(j)_r$, so the aggregate contribution is at most
$$
\nu_r(h-1/j_0)^r\left(\frac{x+1}{h}\right)^r\le \nu_r x^r
$$
by telescoping and the inequality $x+1\ge hj_0$. If no cluster can contribute, the same bound holds.

Each cluster uses at least $\beta j$ bins and $w_j\le C_r\nu_r/j$. Thus its aggregate contribution to any mixed falling factorial of positive degree $s < r$ is at most $C_{r,\beta}\nu_r\log(K+1)=o(\nu_s)$, uniformly in the chosen bins and in $m\ge K$ as $\alpha\downarrow0$. To fill the degree-$s$ residuals, use states of total size at most $r-1$, in descending degree order, as in the proof of Theorem 2. The additional contamination from larger filler states is at most $e^{K\alpha}-1 < 1/2$ times the target, by the same multinomial identity there without the degree-$r$ term. No filler state contributes to a degree-$r$ prefix factorial moment at thresholds within the first $K$ bins. The total mass of nonzero states is at most $K\alpha$, so zero fills the remainder. Allocate labels and generate within-bin uniforms. This gives $(r-1)$-wise independence.

For completeness, verify (11) at thresholds $u>Kq$. Put $C=N(Kq)$ and $v=(u-Kq)/(1-Kq)$. Given the labelled set counted by $C$, each other label independently lands below $u$ with probability $v$. Expanding the product over $r$ ordered distinct labels gives
$$
E(N(u))_r
=\sum_{s=0}^r\binom rs (1-v)^s v^{r-s}(m-s)_{r-s} E(C)_s .
$$
Use equality to the independent moments at degrees $s < r$ and the upper bound at degree $r$. The resulting expression is at most $(m)_r u^r$, as required. The same comparison covers $u=1$.

Finally, $(j^r-(j-1)^r)/(j)_r=r/j+O_r(j^{-2})$. The sum of the weights in (13) is therefore asymptotic to $\nu_r r(h-1/j_0)^r\log b_{m,\alpha}$ for fixed $h,j_0$. The early event has size $\alpha+O_r(\alpha^r)$ and is disjoint from the cluster component. Send $j_0$ to infinity and then $h$ to one. This proves (12). ∎

Full pairwise independence therefore gives the constant $1/2$, while the binomial variance bound over every common threshold alone gives the constant $2$. The distinct constants quantify the value of the mixed-bin information absent from a common-threshold bound.

## 7. Calibration and scope

For a superuniform p-value $P_i$ with distribution function $G_i$, the randomized distributional transform $G_i(P_i-)+U_i[G_i(P_i)-G_i(P_i-)]$ is uniform and at most $P_i$. Here the $U_i$ are independent uniforms independent of the p-values. The transform preserves $r$-wise independence. The Simes rejection event is coordinatewise decreasing, which proves that the supremum for $r$-wise independent superuniforms equals the uniform one. No corresponding generalization of (11) is needed for (12).

For each fixed $m$, $M_{m,r}$ is nondecreasing and Lipschitz in $\alpha$: a new rejection between two levels requires a coordinate to enter one of the intervals between the two rank thresholds, whose total union bound is $m(m+1)/2$ times the level difference. The independent law also gives $M_{m,r}(u)\ge u$. To obtain (2), take any fixed $\epsilon>0$, and bracket the safe level by $u-(\lambda_r\pm\epsilon)u^r\log\min(m,1/u)$. Both trial levels are $u(1+o(1))$ along the joint paths. Equation (1) determines which bracket endpoints are safe for sufficiently small $u$. Sending $\epsilon$ to zero proves (2). In the sparse regime $mu\le\log2$, (10) gives a direct finite procedure: compute the polynomial once, then take its largest level at which the polynomial is at most $u$. The more general moment intervals in (9) give exact finite-grid calibration whenever the specified constraints apply, without a requirement to verify independence of the full p-values. The moment constraints are population information. Their statistical estimation is a separate problem.

The global-null results can be applied to intersection tests in closed testing if the assumed moment information holds for the true null p-values of each intersection. They do not establish an FDR guarantee for BH with nonnulls present.

## 8. Related results

The exact independent identity is due to Simes [1]. The factorial-moment representation for finite order-statistic problems is established, and the convex-hull bounds in Okolewski and Błażejczyk-Okolewska [2, §2, Theorem 1 and Remark 1(iii)] give the fixed-grid Simes extremum through a full moment problem. The projection in Theorem 2 removes all the lower-degree constraints on high-count atoms over an explicit level region. Its consequence (10) is a level-independent packing objective with a constructive extension. The asymptotic constants (1) and (12) use the geometric cost and the all-scale constructions, respectively. The same-degree moment representation on its own supplies neither constant.

Chen, Wang, Zhang and Wu [3, §2.3, Theorem 5 and Corollary 7] study first-order small-level robustness under asymptotic tail conditions for fixed dimension. The present joint limit concerns a classwise higher-order correction, with the optimizing law allowed to vary with both dimension and level. The negative-dependence assumptions studied by Chi, Ramdas and Wang [4] and the PRDS and general-dependence FDR results of Benjamini and Yekutieli [5, Theorems 1.2–1.3] address different constraints. The common-threshold comparison here assumes full matching through degree $r-1$ and distinguishes count bounds from genuinely mixed-bin information at degree $r$.

1. R. J. Simes. *An improved Bonferroni procedure for multiple tests of significance*. Biometrika 73(3), 751–754 (1986). [DOI](https://doi.org/10.1093/biomet/73.3.751)
2. A. Okolewski and B. Błażejczyk-Okolewska. *Tight bounds for joint distribution functions of order statistics under k-independence*. Entropy 27(12), 1250 (2025). [DOI](https://doi.org/10.3390/e27121250)
3. X. Chen, F. Wang, H. Zhang and Z. Wu. *On correlation robustness of supremum-based p-value combination tests*. Statistica Sinica, accepted manuscript. [DOI](https://doi.org/10.5705/ss.202025.0263)
4. Z. Chi, A. Ramdas and R. Wang. *Multiple testing under negative dependence*. Bernoulli 31(2), 1230–1255 (2025). [DOI](https://doi.org/10.3150/24-BEJ1768)
5. Y. Benjamini and D. Yekutieli. *The control of the false discovery rate in multiple testing under dependency*. Annals of Statistics 29(4), 1165–1188 (2001). [DOI](https://doi.org/10.1214/aos/1013699998)
