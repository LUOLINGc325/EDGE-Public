# Equal-Reward Strict Priority with Heterogeneous Exponential Patience

Research manuscript, 26 November 2026.

This manuscript contains a written mathematical proof. It has not undergone external peer review. The results have not been machine checked.

## Abstract

We consider a finite clearing system with two classes, no arrivals, one nonpreemptive server, independent exponential service times, and independent exponential waiting lifetimes. Each admission earns the same positive reward, and a job cannot abandon after service starts. We establish the equal-reward branch of the strict-priority conjecture of Chen, Gayon, and Lemaire, including the earlier sufficient-condition conjecture of Argon, Ziya, and Righter. Priority to class 1 maximizes the expected number served for every finite initial state if and only if its service rate and the product of its service and abandonment rates both dominate those of class 2. The new part is sufficiency when faster service conflicts with shorter waiting patience, without bounds on either population. A marginal recurrence for the fixed-priority value yields a residual certificate for the actual nonpreemptive first-action deviation. A positive-source argument covers one parameter region; a signed rational comparison function covers the other two. Its interior and boundary residuals have explicit signs on the whole feasible cone. Previously known aligned-order sufficiency and general necessity are credited. Competitors include all nonanticipating, history-dependent, independently randomized, work-conserving policies. Exact calculations support, but do not replace, the all-state proof.

## 1. Problem, prior results, and contribution

A faster job occupies the server for less time but may be less urgent than a slower job. With abandonment, the optimal choice can depend on both population counts. A criterion for fixed priority therefore requires more than a two-job comparison.

Argon, Ziya, and Righter [1, Conjecture 1] proposed a sufficient condition for two exponential classes with equal rewards. Chen, Gayon, and Lemaire [2, Conjecture 1] later included it in a broader conjecture with unequal rewards. Their theorem resolves identical service-time distributions. Their conjectured heterogeneous-service conditions become sufficient when a service rate, a patience rate, or a reward is common to the classes.

Our contribution is the all-state equal-reward sufficient direction with arbitrary positive, unequal patience rates. In particular it covers faster but less urgent jobs whose abandonment rate is below their service rate. This is outside the aligned stochastic-order theorem of [1], the high-abandonment region of [1, Proposition 5], and the corresponding larger region in [3, Corollary 3]. The thin-population results of [1, Proposition 7] are also prior work.

An earlier manuscript [4] proves common-patience sufficiency with unequal rewards and general heterogeneous-patience necessity. We use its marginal and first-action residual architecture and reproduce its necessity argument with attribution. Our new algebra handles heterogeneous patience: the marginal boundary becomes a product, and both boundary and interior rational comparison residuals need control. We do not claim new necessary conditions, aligned-order optimality, or the two-job calculation.

The net new parameter core is
$\mu_1>\mu_2$, $\gamma_1<\gamma_2$, $\mu_1>\gamma_1$, and
$\mu_1\gamma_1\ge\mu_2\gamma_2$, with both class populations unrestricted. The proof also recovers already known regions in a unified calculation. No sufficiency theorem for fully heterogeneous rewards, general service laws, arrivals, multiple servers, preemption, or abandonment during service is claimed.

A finite literature search found no earlier proof of this exact branch among the materials inspected. This is not a certification of global priority or an exhaustive unpublished-work search. Source versions and access limitations are recorded in the references.

## 2. Model and exact classification

Initially there are $n_i\in\mathbb N_0$ jobs of class $i\in\{1,2\}$. A class-$i$ job has service time $\operatorname{Exp}(\mu_i)$ and waiting lifetime $\operatorname{Exp}(\gamma_i)$, with

$$
\mu_1,\mu_2,\gamma_1,\gamma_2>0. \tag{2.1}
$$

All primitive variables are mutually independent. There are no arrivals. A job abandons if its lifetime expires before admission; after admission it cannot abandon. The single server is nonpreemptive and work-conserving. The common admission reward $w>0$ can be divided out, so we normalize it to one.

Policies observe past completions, abandonments, elapsed times, and their own actions, and may use independent randomization. They do not observe future service durations or unexpired lifetimes. A service choice occurs only at time zero or a service completion. A waiting abandonment while the server is busy does not permit switching the job in service. Write $\mathrm{SP}_i$ for strict priority to class $i$.

A rule is uniformly optimal when it is optimal for every finite initial state, relative to all the policies just defined. Competing policies are not restricted to fixed lists.

### Theorem 2.1. Equal-reward classification

The rule $\mathrm{SP}_1$ is uniformly optimal if and only if

$$
\boxed{\quad\mu_1\ge\mu_2,\qquad
\mu_1\gamma_1\ge\mu_2\gamma_2.\quad} \tag{2.2}
$$

Both inequalities are weak; equality boundaries are included.

The product condition is exactly the two-job preference. The service-rate condition is forced by systems with many class-1 jobs and one class-2 job. Sufficiency requires a uniform argument beyond those comparisons.

### Corollary 2.2. Classification of the two fixed rules

The rule $\mathrm{SP}_2$ is uniformly optimal exactly when both inequalities in (2.2) are reversed. Both rules are uniformly optimal exactly when

$$
\mu_1=\mu_2,\qquad \gamma_1=\gamma_2. \tag{2.3}
$$

If the orderings of $\mu_i$ and $\mu_i\gamma_i$ strictly conflict, neither fixed rule is uniformly optimal. This does not assert that both actions must occur in an optimal policy for each individual state.

**Proof.** Exchange class labels in Theorem 2.1. Simultaneous validity gives equality of service rates and their products; positivity gives equal patience rates. Strict conflict violates one necessary condition for each rule. $\square$

## 3. Exact nonpreemptive recurrences

Normalize time by $\gamma_1$ and write

$$
a=\frac{\mu_1}{\gamma_1},\qquad
b=\frac{\mu_2}{\gamma_1},\qquad
d=\frac{\gamma_2}{\gamma_1}. \tag{3.1}
$$

The waiting rates are now $1,d$. Let $F(n,m)$ be the total expected reward of $\mathrm{SP}_1$ from a free-server state, including the next admission. Its value is between zero and $n+m$.

### Lemma 3.1. State sufficiency and fixed-priority value

Conditional on an observable history at a service decision, surviving lifetimes retain their independent exponential laws and unused service times retain their independent original laws. Thus the count pair determines the conditional control problem.

For $n\ge1$ set $p=a+n-1$. Then

$$
\begin{aligned}
F(n,0)&=\sum_{k=0}^{n-1}\frac{a}{a+k},&
F(0,m)&=\sum_{k=0}^{m-1}\frac{b}{b+kd},\\
(p+md)F(n,m)&=pF(n-1,m)+mdF(n,m-1)+a.
\end{aligned} \tag{3.2}
$$

Empty sums are zero; terms with zero coefficients are omitted.

**Proof.** Memorylessness applies to each surviving waiting lifetime. An observed history does not reveal any unused service duration. Independent exponential event clocks give an equivalent construction: after each event, surviving clocks restart with their original rates. The construction remains valid for decisions depending on the entire observed past and independent randomization.

Admit a class-1 job and earn one. The next event is completion at rate $a$, a class-1 waiting abandonment at rate $n-1$, or a class-2 abandonment at rate $md$. A completion leaves $F(n-1,m)$. A class-1 abandonment leaves remaining value $F(n-1,m)-1$: the same class of service is ongoing and its admission reward was already counted. A class-2 abandonment similarly leaves $F(n,m-1)-1$. First-event conditioning and rearrangement give (3.2), without permitting a new action at an abandonment. On either axis the recurrence telescopes to the displayed sums. $\square$

### Lemma 3.2. Marginal recurrence and bounds

For $n\ge0,m\ge1$, define

$$
q(n,m)=F(n,m)-F(n,m-1). \tag{3.3}
$$

Then

$$
\begin{aligned}
q(0,m)&=\frac{b}{b+(m-1)d},\\
q(n,1)&=\prod_{j=0}^{n-1}\frac{a+j}{a+j+d},\\
(p+md)q(n,m)&=p q(n-1,m)+(m-1)dq(n,m-1),
\end{aligned} \tag{3.4}
$$

and

$$
0 \lt q(n,m)\le1. \tag{3.5}
$$

At $m=1$, the zero-coefficient predecessor is omitted.

**Proof.** Subtract (3.2) at successive $m$, retaining the difference $d$ in the left coefficients. This yields the recurrence. Its $m=1$ version telescopes to the product; the $n=0$ boundary follows from the axis sum. The boundary values belong to $(0,1]$. The denominator is positive, the predecessor coefficients are nonnegative, and their sum is smaller than the denominator by $d$. Induction on $n+m$ proves (3.5). $\square$

For a function $h$ define, in the interior $n\ge1,m\ge2$,

$$
\mathcal Lh=(p+md)h(n,m)-ph(n-1,m)-(m-1)dh(n,m-1). \tag{3.6}
$$

If $\mathcal Lh\le0$ and $h\le q$ on $n=0$ and $m=1$, triangular induction gives $h\le q$ throughout. Reversing both inequalities reverses the conclusion. The boundary comparison uses

$$
(\mathcal L_1h)_n=(p+d)h_n-ph_{n-1}. \tag{3.7}
$$

All comparisons use finite recurrences; no asymptotic regularity is assumed.

## 4. The true first-action deviation

Let $G(n,m)$, for $m\ge1$, be the value of first admitting one class-2 job and thereafter using $\mathrm{SP}_1$ when that service completes. Set $D=F-G$, so $D(0,m)=0$.

### Lemma 4.1. Deviation source

For $n,m\ge1$,

$$
\begin{aligned}
(b+n+(m-1)d)G(n,m)
={}&bF(n,m-1)+nG(n-1,m)\\
&+(m-1)dG(n,m-1)+b.
\end{aligned} \tag{4.1}
$$

Define

$$
\begin{aligned}
A&=a-1,& B&=b-d,& e&=a-bd,\\
H(n,m)&=A\bigl(b+(m-1)d\bigr)+nB,\\
M(n)&=bA-n(a-b),&
R(n,m)&=H(n,m)q(n,m)-M(n).
\end{aligned} \tag{4.2}
$$

Then

$$
\begin{aligned}
(b+n+(m-1)d)D(n,m)
={}&nD(n-1,m)+(m-1)dD(n,m-1)\\
&+\frac{R(n,m)}p.
\end{aligned} \tag{4.3}
$$

**Proof.** During the initial class-2 service the event rates are $b,n,(m-1)d$. Completion leaves $F(n,m-1)$. Waiting abandonments leave $G(n-1,m)-1$ or $G(n,m-1)-1$ while the same class-2 job remains in service. Conditioning gives (4.1).

Put $x=F(n,m)-F(n-1,m)$. Equation (3.2) implies $px+mdq=a$. Subtracting (4.1), the remaining source is

$$
nx+\bigl(b+(m-1)d\bigr)q-b
=\frac{na-bp+Hq}{p}
=\frac{R}{p}, \tag{4.4}
$$

because $na-bp=-M$. $\square$

### Lemma 4.2. Certificate implies dynamic optimality

If $R(n,m)\ge0$ for all $n,m\ge1$, then $\mathrm{SP}_1$ is uniformly optimal.

**Proof.** All predecessor coefficients in (4.3) are nonnegative and its denominator and $p$ are positive. From $D(0,m)=0$, induction gives $D\ge0$. A second induction uses the total initial population. On an axis there is no class choice. After any initial service completes, at most one fewer job remains. By the induction hypothesis, $\mathrm{SP}_1$ is optimal at every resulting state. Conditional on any admissible history, Lemma 3.1 therefore makes $F,G$ the two optimal first-action values. The inequality $F\ge G$ selects class 1. Randomization gives a convex combination and cannot improve the maximum. $\square$

The local source certificate is sufficient, not necessary. We do not assume it outside the cone where it is proved.

## 5. Heterogeneous-patience sufficiency

The new case is

$$
d\ge1,\qquad a\ge bd. \tag{5.1}
$$

Thus $a\ge b$ and $e\ge0$. This cone is covered by

$$
\begin{array}{ll}
\text{mixed:}&a\ge1,\quad b\le d,\\
\text{high:}&b>d,\\
\text{low:}&a<1.
\end{array} \tag{5.2}
$$

The high region has $a>1$; the low region has $b<1\le d$. Both $a=1$ and $b=d$ belong to the mixed region.

### Lemma 5.1. Mixed-region positive source

Under (5.1), $a\ge1$, $b\le d$ imply $R(n,m)\ge0$ for all positive integer states.

**Proof.** The increments of $H$ are $B$ in $n$ and $Ad$ in $m$. Substitution into (3.4) gives

$$
\begin{aligned}
(p+md)R(n,m)
={}&pR(n-1,m)+(m-1)dR(n,m-1)+S(n,m),\\
S(n,m)
={}&pBq(n-1,m)+(m-1)Ad^2q(n,m-1)\\
&+p(a-b)-dM(n).
\end{aligned} \tag{5.3}
$$

Since $B\le0$ and $q\le1$,

$$
\begin{aligned}
S(n,m)
&\ge pB+(m-1)Ad^2q(n,m-1)+p(a-b)-dM(n)\\
&=ep+dA(n-1)+(m-1)Ad^2q(n,m-1)\ge0.
\end{aligned} \tag{5.4}
$$

The identity follows by expansion, and $A,e\ge0$. On $n=0$, $R(0,m)=0$. Induction in (5.3) proves the result; at $m=1$, all terms multiplied by $m-1$ are omitted. $\square$

### Lemma 5.2. Rational comparison identities

In the high or low region, define

$$
h(n,m)=\frac{M(n)}{H(n,m)}. \tag{5.5}
$$

Let $k=n-1$, $j=m-1$, and set

$$
\begin{aligned}
T={}&e(2ab-b-1)+a(d-1)(ab+bd-d-1),\\
U={}&e(2ab-ad-1)+a(d-1)(b^2+b-d-1),\\
P={}&d(a-b)B^2k^2+dAB(a-b)(d+1)kj+BTk\\
&+d^2A^2(a-b)j^2+dAUj+abAeB.
\end{aligned} \tag{5.6}
$$

For $n\ge1,m\ge2$,

$$
\mathcal Lh=-\frac{pP}{H(H-B)(H-Ad)}. \tag{5.7}
$$

On $m=1$, write $H_n=bA+nB$, $h_n=h(n,1)$. Then

$$
P_1=d(a-b)Bk^2+Tk+abAe,\qquad
\mathcal L_1h=-\frac{P_1}{H_n(H_n-B)}. \tag{5.8}
$$

**Proof.** Substitute $M/H$ into (3.6), use the increments $B,Ad$ of $H$ and $M(n)-M(n-1)=-(a-b)$, and combine the fractions. Collection by powers of $k,j$ yields $P$. For explicit coefficient checking, expansion of $T,U$ gives

$$
\begin{aligned}
T={}&a^2bd+a^2b-2ab^2d+abd^2-abd-ab\\
&-ad^2+b^2d+bd,\\
U={}&2a^2b-a^2d-ab^2d-ab^2+abd^2+abd\\
&-ab-ad^2+bd.
\end{aligned} \tag{5.9}
$$

The coefficients of $k,j$ in the numerator are $BT,dAU$, respectively. Combining the two fractions in (3.7) similarly gives (5.8). Every denominator used has a nonzero sign established below. $\square$

### Lemma 5.3. High-region comparison

Under (5.1) and $b>d$, one has $R(n,m)\ge0$.

**Proof.** Here $A,B>0$. Therefore $H$, $H-B=H(n-1,m)$, and $H-Ad=H(n,m-1)$ are positive wherever used. Also $T,U\ge0$, since

$$
\begin{aligned}
2ab-b-1&=b(2a-1)-1>0,\\
ab+bd-d-1&=(ab-1)+d(b-1)>0,\\
2ab-ad-1&=a(2b-d)-1>0,\\
b^2+b-d-1&=(b^2-1)+(b-d)>0.
\end{aligned} \tag{5.10}
$$

Every term of $P,P_1$ is nonnegative. Hence $\mathcal Lh\le0$ and $\mathcal L_1h\le0$.

At the corner $h_0=q(0,1)=1$. One-dimensional comparison gives $h(n,1)\le q(n,1)$. On the other boundary,

$$
h(0,m)=\frac{b}{b+(m-1)d}=q(0,m). \tag{5.11}
$$

The interior comparison now yields $h\le q$. Multiplication by positive $H$ gives $R=H(q-h)\ge0$. $\square$

### Lemma 5.4. Low-region comparison

Under (5.1) and $a<1$, one has $R(n,m)\ge0$.

**Proof.** From $bd\le a<1$ and $d\ge1$ we get $b<1$ and $A,B<0$. The three factors $H,H-B,H-Ad$ are negative wherever used, whereas $H_n(H_n-B)>0$.

Here $T,U\le0$, because

$$
\begin{aligned}
2ab-b-1&\le b-1<0,\\
ab+bd-d-1&\le a-1<0,\\
2ab-ad-1&\le a-1<0,\\
b^2+b-d-1&\le1-d\le0.
\end{aligned} \tag{5.12}
$$

The second line uses $b(a+d)-(d+1)\le a-1$; the third uses $2b-d\le1$. The multiplying factors $e,a(d-1)$ are nonnegative. All six terms of $P$ are therefore nonnegative, including $BT,AU$, and $AB$. The denominator in (5.7) is negative, so $\mathcal Lh\ge0$. All three terms of $P_1$ are nonpositive, so $\mathcal L_1h\ge0$.

The boundary identities used in Lemma 5.3 now give $q(n,1)\le h(n,1)$ and then $q\le h$ on the quadrant. Multiplication by negative $H$ reverses the inequality, again yielding $R=H(q-h)\ge0$. $\square$

### Proposition 5.5. Reversed-patience sufficiency

For every $d\ge1$, $a\ge bd$, the rule $\mathrm{SP}_1$ is uniformly optimal.

**Proof.** The three regions cover the cone, with equality boundaries in the mixed region. Lemmas 5.1, 5.3, and 5.4 give $R\ge0$. Apply Lemma 4.2. $\square$

## 6. The published aligned-order branch

### Proposition 6.1. Aligned exponential order, from [1]

If $\mu_1\ge\mu_2$ and $\gamma_1\ge\gamma_2$, then $\mathrm{SP}_1$ is uniformly optimal.

**Application of the published theorem.** Argon, Ziya, and Righter [1, Theorem 1, pp. 307–309] establish priority optimality for independent finite clearing jobs whose waiting lifetimes are ordered by hazard rate and whose service durations have the same ordering by likelihood ratio. Their model is nonpreemptive and protects admitted jobs from abandonment.

For exponential waiting laws the conditional survival is $\exp(-\gamma_i t)$, giving the required order when $\gamma_1\ge\gamma_2$. The density ratio

$$
\frac{f_1(t)}{f_2(t)}
=\frac{\mu_1}{\mu_2}\exp\bigl(-(\mu_1-\mu_2)t\bigr) \tag{6.1}
$$

is nonincreasing when $\mu_1\ge\mu_2$. Order all class-1 jobs before class-2 jobs and break identical-class ties arbitrarily. The theorem applies to cumulative admissions. Passage to total admissions follows from the finite population bound. Lemma 3.1 and population induction also reduce history and randomized policies to count-state deterministic decisions. This invokes a published theorem; it does not assume priority optimality as a new premise. $\square$

**Completion of sufficiency in Theorem 2.1.** Under (2.2), if $\gamma_2\ge\gamma_1$, normalization gives (5.1) and Proposition 5.5 applies. If $\gamma_2\le\gamma_1$, Proposition 6.1 applies. This covers all positive rates.

We do not extend the local source certificate $R\ge0$ to the aligned branch. The diagnostics include an exact aligned example with $R<0$ but optimal $\mathrm{SP}_1$, showing why that extension would be incorrect.

## 7. Necessity and finite witnesses

Necessity follows from [4, Theorem T2]. Its argument is included to keep the model and finite witnesses explicit. The two-job calculation was already given in [3, Proposition 5].

### Lemma 7.1. Two-job necessity

At state $(1,1)$ the first-action values are

$$
1+\frac{\mu_1}{\mu_1+\gamma_2},
\qquad
1+\frac{\mu_2}{\mu_2+\gamma_1}. \tag{7.1}
$$

The first is at least the second exactly when $\mu_1\gamma_1\ge\mu_2\gamma_2$.

**Proof.** The other job is admitted if its exponential lifetime exceeds the first exponential service. Independence gives the displayed rate ratios. Cross multiplication by positive denominators proves the equivalence. $\square$

### Lemma 7.2. Loss from an initial exponential delay

Fix $a,b>0$ and unit patience. Write
$S_a(n)=\sum_{j=0}^{n-1}a/(a+j)$.
Let $J_n$ be the expected number served at rate $a$ if service starts only after an independent $\operatorname{Exp}(b)$ delay, during which every job can abandon. Set $L_n=S_a(n)-J_n$. Then

$$
(b+n)L_n=nL_{n-1}+\frac{an}{a+n-1},\quad L_0=0,
\qquad \lim_{n\to\infty}L_n=\frac ab. \tag{7.2}
$$

**Proof.** First-event conditioning gives
$(b+n)J_n=bS_a(n)+nJ_{n-1}$, so subtraction gives the recurrence. For $1\le k\le n$, let

$$
W_{n,k}=\frac b{b+k}\prod_{j=k+1}^n\frac j{b+j}. \tag{7.3}
$$

Unrolling and telescoping yield

$$
L_n=\frac ab\sum_{k=1}^nW_{n,k}\frac{k}{a+k-1},
\qquad
\sum_{k=1}^nW_{n,k}=1-\prod_{j=1}^n\frac j{b+j}. \tag{7.4}
$$

Since $\prod(1+t_j)\ge1+\sum t_j$ for nonnegative $t_j$,

$$
\prod_{j=1}^n\frac j{b+j}
\le\frac1{1+b\sum_{j=1}^n1/j}\longrightarrow0. \tag{7.5}
$$

Each fixed $W_{n,k}$ also tends to zero by the corresponding tail-product bound. The bounded factor $k/(a+k-1)$ tends to one. Split the weighted sum at $K$: finitely many early terms vanish, and the remaining factors are uniformly close to one for large $K$, while their total mass tends to one. This proves the limit. $\square$

### Lemma 7.3. Survival behind many priority jobs

Let $\tau_n$ be the time to clear $n$ class-1 jobs, including the last service completion. For $s>0$,

$$
\mathbb E e^{-s\tau_n}
=\prod_{j=0}^{n-1}
\frac{\mu_1+j\gamma_1}{\mu_1+j\gamma_1+s}
\longrightarrow0. \tag{7.6}
$$

**Proof.** With $k$ remaining jobs, one is in service and $k-1$ wait. Their next departure rate is $\mu_1+(k-1)\gamma_1$. A completion or waiting abandonment reduces the count by one; memorylessness restores the same description. Conditioning the Laplace transform gives the product. Normalize by $\gamma_1$ and apply the product bound to the divergent sum $\sum_{j=0}^{n-1}1/(\mu_1/\gamma_1+j)$. $\square$

### Completion of necessity

For state $(n,1)$, set $a=\mu_1/\gamma_1$, $b=\mu_2/\gamma_1$. Under $\mathrm{SP}_1$, the value is $S_a(n)+\rho_n$, where
$\rho_n=\mathbb E e^{-\gamma_2\tau_n}\to0$.
The alternative first serves the lone class-2 job, then the surviving class-1 jobs, and has value $1+J_n$. Hence

$$
V_{\mathrm{SP}_1}(n,1)-V_{\mathrm{deviation}}(n,1)
=L_n+\rho_n-1
\longrightarrow\frac{\mu_1}{\mu_2}-1. \tag{7.7}
$$

If $\mu_1<\mu_2$, every sufficiently large finite $n$ defeats $\mathrm{SP}_1$. Uniform optimality requires the service-rate condition. With Lemma 7.1, this completes Theorem 2.1.

No infinite-population model or fluid approximation is substituted. Two exact finite examples illustrate the independent necessity of the conditions:

| Failure | $(\mu_1,\mu_2,\gamma_1,\gamma_2)$ | State | SP1 value | Start 2, then SP1 | Improvement |
|---|---|---|---|---|---|
| Service-rate order only | $(1,2,3,1)$ | $(3,1)$ | $61/35$ | $10807/6160$ | $71/6160$ |
| Product order only | $(2,1,1,3)$ | $(1,1)$ | $7/5$ | $3/2$ | $1/10$ |

The other necessary condition holds in each row. These witnesses illustrate existing necessary conditions rather than constituting the new contribution.

## 8. Reproduction and limitations

The proof uses finite induction, the rational identities of Section 5, and the cited aligned-order theorem. The accompanying exact computation implements three routes: a Bellman recursion retaining the current service class, a fixed-priority/first-deviation recurrence, and a separate service-completion survivor-kernel integration.

For initial service class $i$, let
$u=n_1-\mathbf1_{\{i=1\}}$ and
$v=n_2-\mathbf1_{\{i=2\}}$. The last route uses

$$
\begin{aligned}
&\Pr(N_1'=r,N_2'=s\mid i)\\
&=\binom ur\binom vs
\int_0^\infty \mu_i e^{-\mu_i t}
e^{-(r\gamma_1+s\gamma_2)t}
(1-e^{-\gamma_1t})^{u-r}
(1-e^{-\gamma_2t})^{v-s}\,dt.
\end{aligned} \tag{8.1}
$$

Conditional on service duration, survivals are independent. Expanding the powers makes this a finite sum of rational rate ratios for rational parameters. It permits no service change during abandonment events.

The supplied run covers 133 rational parameter tuples. Independent completion-kernel calculations agree with 2,128 optimal values, 2,128 fixed-priority values, and 1,596 first-deviation values; seven symbolic identities are exactly verified. The parameter enumeration, commands, full counts, table digests, and limitations are in the reproduction records. These finite checks establish neither all-state optimality nor global novelty.

Strict positivity and equal positive rewards are retained. Zero rates, arrivals, other service laws, and abandoning in-service jobs require separate arguments. The competitor class is work-conserving; no additional theorem about strategic idling is asserted.


## References

1. N. T. Argon, S. Ziya, and R. Righter. Scheduling Impatient Jobs in a Clearing System with Insights on Patient Triage in Mass Casualty Incidents. *Probability in the Engineering and Informational Sciences* **22**(3), 301–332, 2008. DOI: [10.1017/S0269964808000272](https://doi.org/10.1017/S0269964808000272). [Author-hosted published PDF](https://ziya.web.unc.edu/wp-content/uploads/sites/15166/2018/02/Argon-Ziya-Righter-2008.pdf). Theorem 1 and Conjecture 1 were inspected.

2. G. Chen, J.-P. Gayon, and P. Lemaire. Technical Note—Stochastic Scheduling with Abandonment: Necessary and Sufficient Conditions for the Optimality of a Strict Priority Policy. *Operations Research* **71**(5), 1789–1793, 2023; online 1 April 2022. DOI: [10.1287/opre.2022.2285](https://doi.org/10.1287/opre.2022.2285). [Author manuscript](https://perso.isima.fr/~jpgayon/Documents/PublicationsJP/WorkingPapers/stochastic-scheduling-2022.pdf), Section 3. Publisher metadata and the author manuscript were inspected; the final typeset PDF was not inspected.

3. E. U. Jacobson, N. T. Argon, and S. Ziya. Priority Assignment in Emergency Response. *Operations Research* **60**(4), 813–832, 2012. DOI: [10.1287/opre.1120.1075](https://doi.org/10.1287/opre.1120.1075). [Author-hosted published PDF](https://ziya.web.unc.edu/wp-content/uploads/sites/15166/2018/02/Uzun-Jacobson-Argon-Ziya-2012.pdf). The model, Corollary 3, and Proposition 5 were inspected.

4. [*Strict Priority in Nonpreemptive Clearing Systems with Common Exponential Patience*](../equal-patience-priority-classification/paper.en.md), Theorems T1–T2 and Sections 3–6. Research manuscript.

