# A Sharp Reward Threshold for Faster, More Patient Jobs in a Two-Class Clearing System

Collaborative research draft · 26 November 2026

**Written mathematical results; formal verification is a separate, unfinished obligation. No external peer review or journal acceptance is claimed.**

## Abstract

We study a single-server clearing system with two classes of jobs, independent exponential service times and waiting lifetimes, and positive class-dependent rewards. Service is nonpreemptive, jobs cannot abandon after entering service, and policies may use the full observed history and independent randomization. We consider the strict parameter region in which class 1 is faster but more patient, and its service-rate advantage is insufficient to make equal rewards favor it even in a two-job system. In this region we prove that the two-job reward threshold is also sufficient for strict priority to class 1 to be optimal for every finite initial population. Writing the service rates relative to the class-1 abandonment rate as a and b, the abandonment-rate ratio as c, and the reward ratio as r, the region is c>1 and b< a< bc; the exact threshold is r=c(b+1)/(a+c). Necessity is the familiar two-job comparison. The new sufficient direction constructs a certificate for the marginal value of a low-priority job. Elementary bounds handle a mixed rate region; a rational comparison function and a five-term polynomial identity handle the two remaining regions. A convexity argument and a quadratic Bernstein representation certify the low-rate signs. The proof is self-contained and connects these algebraic certificates to the original nonpreemptive, history-dependent policy class. Finite exact computations provide diagnostic checks, not a substitute for the all-state proof.

## 1. Question, contribution, and scope

A short service time creates opportunities to serve other jobs. A short waiting lifetime creates urgency. These two considerations conflict when the faster class is more patient. A higher reward can favor that class, but a comparison of two isolated jobs does not generally establish a priority rule for larger populations.

Chen, Gayon, and Lemaire [1] give a classification for homogeneous service distributions and discuss further sufficient conditions in their heterogeneous exponential model. Immediately after Conjecture 1 in the inspected author version, they describe the numerical observation that the proposed necessary conditions appear sufficient when both the reward and the service rate favor the same class. We settle the strict conflicting-rate region specified below. In our normalized domain, r>=1 and a>b imply the reward-rate condition in their condition (C), while its other inequality is exactly r>=r_*. We do not claim a classification for arbitrary heterogeneous rewards and rates.

Several components and subregions predate this work. The two-job comparison is established in earlier scheduling research. Argon, Ziya, and Righter [2] study the equal-reward clearing model. Jacobson, Argon, and Ziya [3, Proposition 3], after interchanging class labels, already cover the subregion a<=1 considered here: both service rates are then no larger than their corresponding abandonment rates, and their priority condition reduces to the threshold below. We credit that conclusion as prior work, although our proof of that part is self-contained. The finite-state marginal and residual approach also appears in the earlier common-patience research note [5]. Our increment consists of the reward-threshold certificate for the present strict heterogeneous region, including the mixed region a>1, b<=c and the fast-service region b>c that are not covered by that known subregion. The boundary a=1 is not counted as a new conclusion. The polynomial identity and its sign certificates are stated explicitly so that this increment can be checked without accepting a priority theorem from another manuscript.

The unpublished companion study [6] concerns the successful equal-reward region a>=bc. Our region has a< bc, where equal rewards fail the two-job test. The two targets therefore have disjoint successful parameter regions. Neither the equal-reward conclusion nor a claimed solution of its conjecture is used as a premise here. The newer general selection-with-expiration work [4] is a near neighbor in model design and approximation, rather than a source of this exact priority threshold. Source versions and access limitations are specified in Section 9.

The main theorem is deliberately limited to two classes, a finite initial population, no arrivals, independent exponential primitives, no abandonment in service, and nonpreemptive non-idling control. It does not determine the best policy outside the specified rate region, cover multiple servers, or establish the analogous claim for general patience distributions. It also does not assert that class 1 must be the unique optimal first action at every state.

## 2. Model and exact classification

Initially there are n jobs of class 1 and m jobs of class 2, where n,m are nonnegative integers. A class-i service duration has distribution Exp(mu_i), and its waiting lifetime has distribution Exp(gamma_i). The four rates are strictly positive. All job primitives are mutually independent. A waiting job departs if its lifetime expires before service admission. After admission it cannot abandon, and its service must finish without preemption. Its reward is w_i>0.

A policy selects a waiting job whenever the server becomes free and some job remains. The selection may depend on the entire observed history, including elapsed time, abandonments, completions and earlier actions, and on independent randomization. The policy does not see unexpired lifetimes or future service durations. The server is not allowed to idle while a job is available. Within a class, jobs are statistically identical. Write SP1 for the policy that selects class 1 whenever possible. A priority is uniformly optimal if it maximizes expected total reward for every finite pair (n,m), relative to all policies just described.

Normalize time by gamma_1 and reward by w_2. Define

$$
a=\frac{\mu_1}{\gamma_1},\qquad
b=\frac{\mu_2}{\gamma_1},\qquad
c=\frac{\gamma_2}{\gamma_1},\qquad
r=\frac{w_1}{w_2}. \tag{2.1}
$$

The normalized service rates are a,b, the waiting-lifetime rates are 1,c, and the rewards are r,1. Throughout the main theorem assume

$$
c>1,\qquad 0< b< a< bc,\qquad r\ge1. \tag{2.2}
$$

Thus class 1 is faster and has a longer mean waiting lifetime. Define

$$
r_*=\frac{c(b+1)}{a+c}.
\qquad
r_*-1=\frac{bc-a}{a+c}>0. \tag{2.3}
$$

### Theorem T1. Exact reward compensation threshold

Under (2.2), SP1 is uniformly optimal if and only if r>=r_*. In original units the condition is

$$
\frac{w_1}{w_2}\ge
\frac{\gamma_2(\mu_2+\gamma_1)}
{\gamma_1(\mu_1+\gamma_2)}. \tag{2.4}
$$

The successful conclusion includes equality r=r_*. If 1<=r< r_*, the finite state (1,1) gives a strict counterexample. The rate conditions in original units are gamma_2>gamma_1, mu_1>mu_2 and mu_1 gamma_1< mu_2 gamma_2.

**Necessary direction.** In state (1,1), starting class 1 produces expected reward r+a/(a+c): the second job survives the first service with probability a/(a+c). Starting class 2 produces 1+rb/(b+1). Their difference is

$$
\frac{r}{b+1}-\frac{c}{a+c}
=\frac{r-r_*}{b+1}. \tag{2.5}
$$

Uniform optimality requires this difference to be nonnegative. If it is negative, starting class 2 is a valid strict improvement. This standard calculation is included for completeness and is not counted as the new contribution. Sections 3--7 prove sufficiency.

## 3. Exact stochastic model and triangular recurrences

### Lemma L1. Decision states and reward accounting

At any service decision time, conditional on the observed history and surviving counts, unserved jobs have independent exponential residual waiting lifetimes with their class rates, and unstarted services have their original independent distributions. The optimal remaining reward depends only on those counts. Total reward can equivalently be paid at service completion.

**Proof.** The memoryless property applies to each surviving waiting lifetime; the independent exponential clocks jointly retain their class rates after an observed history. More formally, use independent service and abandonment clocks, reveal only events permitted by the policy, and condition successively on their event times and marks. The exponential race at each observed event has the same residual law for clocks that have not rung. Applying this construction at a service decision, with the policy's independent random seed conditioned on, gives the stated conditional future law. Unstarted service variables have not been used by the decision history.

Every admission removes one job from the future waiting pool. There can be at most n+m admissions, and each admitted service duration is finite almost surely. The finite sum of these durations is finite almost surely; when no job remains the system stops. Every admitted job therefore completes, and the sum of its class reward is identical whether the reward is paid on admission or completion. All total rewards are bounded by rn+m. This also gives the integrability needed for every conditional expectation below.

At a decision time an independently randomized action is a mixture of the two available first actions. It cannot improve on the larger of their conditional expected values. Induction on the number of remaining jobs, which strictly decreases at each service completion, thus supplies an optimal deterministic count-based policy and the same value against the full history-dependent randomized class. This proves the state claim without narrowing the competing policy class. $\square$

For an explicit alternative construction of this induction, let K_s^{u,v}(i,j) be the probability that i of u class-1 waiting jobs and j of v class-2 waiting jobs survive an independent Exp(s) service. Then

$$
K_s^{u,v}(i,j)=\binom ui\binom vj
\int_0^\infty s e^{-st}
e^{-it}(1-e^{-t})^{u-i}
e^{-cjt}(1-e^{-ct})^{v-j}\,dt. \tag{3.1}
$$

The entries are nonnegative and sum to one by the binomial theorem. For n,m>=1 the unrestricted optimal value V obeys

$$
V(n,m)=\max\left\{
r+\sum_{i=0}^{n-1}\sum_{j=0}^{m}K_a^{n-1,m}(i,j)V(i,j),\quad
1+\sum_{i=0}^{n}\sum_{j=0}^{m-1}K_b^{n,m-1}(i,j)V(i,j)
\right\}. \tag{3.2}
$$

On an axis only its available action remains, and V(0,0)=0. All successor counts in (3.2) have total at most n+m-1. Thus (3.2) is a finite triangular recursion for each finite initial population, not an infinite-horizon policy fixed point.

### Lemma L2. Priority values and the reward-independent marginal

Let F_r(n,m) be the expected reward under SP1. Put

$$
A=a+n-1,\qquad B=b+(m-1)c.
$$

For n>=1 and m>=0,

$$
(A+mc)F_r(n,m)
=A F_r(n-1,m)+mc F_r(n,m-1)+ar, \tag{3.3}
$$

omitting any term with zero coefficient. The axis values are

$$
F_r(n,0)=r\sum_{j=0}^{n-1}\frac a{a+j},\qquad
F_r(0,m)=\sum_{j=0}^{m-1}\frac b{b+jc}. \tag{3.4}
$$

For m>=1 define q(n,m)=F_r(n,m)-F_r(n,m-1). This function does not depend on r, and it satisfies

$$
(A+mc)q(n,m)=Aq(n-1,m)+(m-1)cq(n,m-1),\qquad
q(0,m)=\frac b{b+(m-1)c}. \tag{3.5}
$$

In particular, q is nonnegative, and

$$
M_n:=q(n,1)=\prod_{j=0}^{n-1}\frac{a+j}{a+c+j},\qquad M_0=1. \tag{3.6}
$$

**Proof.** Use completion rewards as justified in Lemma L1. With class 1 in service, its completion rate is a, class-1 waiting abandonment rate is n-1, and class-2 abandonment rate is mc. On completion the reward r is earned and the counts become (n-1,m). A waiting abandonment leaves the current service unchanged. Its remaining duration is again Exp(a), so the appropriate lower-count continuation still has the SP1 law. First-event conditioning gives (3.3), including the term ar. This is not a relaxation allowing a service switch at an abandonment.

On a single-class axis, a departure is a completion with probability a/(a+j) or b/(b+jc) when j other same-class jobs are waiting. Summing these completion rewards gives (3.4). Subtract (3.3) at m and m-1, collecting the extra cF_r(n,m-1) term on both sides, to obtain (3.5). Its axis values and coefficients contain no r. Triangular induction therefore proves independence of r and nonnegativity. For m=1 the lower-m coefficient vanishes; iteration gives (3.6). $\square$

### Lemma L3. Genuine first-action deviation

For m>=1 let G_r(n,m) be the value of starting a class-2 job once and subsequently using SP1. That initial class-2 service continues through any intervening abandonments. Then

$$
(b+n+(m-1)c)G_r(n,m)
=bF_r(n,m-1)+nG_r(n-1,m)
+(m-1)cG_r(n,m-1)+b. \tag{3.7}
$$

Set D_r=F_r-G_r. We have D_r(0,m)=0 and, for n,m>=1,

$$
(b+n+(m-1)c)D_r(n,m)
=nD_r(n-1,m)+(m-1)cD_r(n,m-1)+R_r(n,m), \tag{3.8}
$$

where

$$
H=(a-1)B+n(b-c),\qquad t_r=bA-nar,\qquad
R_r=\frac{Hq-t_r}{A}. \tag{3.9}
$$

**Proof.** During the prescribed initial class-2 service, completion occurs at rate b and earns reward 1; waiting class-1 and class-2 jobs abandon at rates n and (m-1)c. Conditioning on this race gives (3.7). At an abandonment the in-service class stays 2, which explains the G_r terms rather than reoptimization terms. At n=0 this policy is SP1, giving the boundary.

Write p=F_r(n,m)-F_r(n-1,m). Equation (3.3) gives Ap+mcq=ar. Subtracting (3.7) from the corresponding expression for F_r gives the source np+Bq-b. Substitution of p=(ar-mcq)/A and the identity AB-nmc=H gives precisely (3.8)--(3.9). $\square$

It is now enough to prove Hq>=t_* where t_*=t_{r_*}. Indeed, q is independent of r and

$$
t_r=t_*-na(r-r_*),\qquad
R_r=R_{r_*}+\frac{na}{A}(r-r_*). \tag{3.10}
$$

Thus the threshold certificate implies R_r>=0 for every r>=r_*.

## 4. Comparison principle and two marginal bounds

### Lemma L4. Triangular comparison

For a function f on n>=0,m>=1 define

$$
\mathcal L f(n,m)=(A+mc)f(n,m)
-Af(n-1,m)-(m-1)cf(n,m-1). \tag{4.1}
$$

At m=1 the last term is omitted. If f(0,m)>=q(0,m) and Lf>=0 for n,m>=1, then f>=q. Reversing both inequalities gives f<=q. If equality or an already proved comparison is specified also at m=1, only the interior m>=2 residual is needed.

**Proof.** Apply strong induction on n+m to f-q. The coefficient A+mc is positive; the coefficients A and (m-1)c are nonnegative, and every required neighboring pair has smaller sum. Use the n=0 boundary and omit the zero m=1 term. The reversed case follows by negating f-q. $\square$

### Lemma L5. Universal bounds for c>1

For n>=0,m>=1,

$$
q(n,m)\le u(n,m):=\frac a{a+nc},\qquad
q(n,m)\ge \ell(n,m):=\frac bB M_n
\ge h_0(n,m):=\frac bB\left(1-\frac{nc}{a+c}\right). \tag{4.2}
$$

**Proof.** We have u(0,m)=1>=b/B, and direct subtraction gives

$$
\mathcal Lu=
\frac{ac(c-1)(n-1)}{(a+nc)(a+(n-1)c)}\ge0. \tag{4.3}
$$

Lemma L4 gives the upper bound. The function ell agrees with q on n=0 and m=1. For m>=2, using AM_{n-1}=(A+c)M_n gives

$$
\mathcal L\ell=-\frac{(m-1)c^2bM_n}{B(B-c)}\le0. \tag{4.4}
$$

Here B-c=b+(m-2)c>0. Lemma L4 gives q>=ell. Finally each factor in (3.6) equals 1-c/(a+c+j), with its subtracted quantity in (0,1). The elementary finite product inequality product_j(1-x_j)>=1-sum_j x_j, proved inductively for 0<=x_j<=1, yields M_n>=1-nc/(a+c). Multiplication by b/B>0 completes (4.2). The lower bound h_0 can be negative; its use does not require dividing by it. $\square$

## 5. A direct certificate in the mixed rate region

### Lemma L6. The region a>=1 and b<=c

Under (2.2), if a>=1 and b<=c, then Hq>=t_* for every n,m>=1.

**Proof.** Let E=bc-a>0 and Y=a-b>0. Direct expansion of the definitions and r_* gives

$$
Hu-t_*=\frac{
ac(m-1)(a-1)+\dfrac{nac(n-1)E}{a+c}
+cn(n-1)Y}{a+nc}\ge0. \tag{5.1}
$$

When H<=0, the upper bound q<=u reverses on multiplication by H, so Hq>=Hu>=t_*. When H>0 use the lower bound q>=h_0 and the identity

$$
Hh_0-t_*=\frac{nc(c-b)\,[a(m-1)+b(n-1)]}{(a+c)B}\ge0. \tag{5.2}
$$

Every displayed denominator is strictly positive. These two cases include H=0 and the boundaries a=1, b=c and n=m=1, without division by H. $\square$

## 6. A five-term rational certificate

The remaining rate regions are b>c and a<1. A single rational comparison function works in both; its direction reverses because its denominator changes sign.

Define

$$
\alpha=a-1,\quad \beta=b-c,\quad z=c-1,\quad Y=a-b,\quad
X=abz+cY=(a+c)(ar_*-b),\quad k=n-1,\quad l=m-1. \tag{6.1}
$$

In our domain z,Y,X are strictly positive. Set

$$
H_n=H-\beta,\qquad H_m=H-\alpha c,\qquad
h(n,m)=\frac{t_*}{H}. \tag{6.2}
$$

The notation H_n and H_m denotes the neighboring denominators H(n-1,m) and H(n,m-1); it is not a derivative. The comparison function is used only when a<1 or b>c, where all its required denominators are nonzero.

### Lemma L7. Exact polynomial identity

Define the coefficient polynomials

$$
\begin{aligned}
P_n(a,b,c)={}&Y^2[b^2z+2bc]
+Y[2b^3z+c(2b^2-b-c)]+zb(b^3-c),\\
P_m(a,b,c)={}&Y^2[b^2z+c(2b-c)]
+Y[2b^3z+c(b-c)(2b+c)]+zb(b^3-c^2).
\end{aligned} \tag{6.3}
$$

Put

$$
\begin{aligned}
P={}&c\beta^2Xk^2+c\alpha\beta(c+1)Xkl+c^2\alpha^2Xl^2\\
&+c\beta P_n k+c\alpha P_m l.
\end{aligned} \tag{6.4}
$$

Whenever the denominators in (6.2) are nonzero,

$$
\mathcal Lh=-\frac{A P}{(a+c)H H_n H_m}. \tag{6.5}
$$

At n=0, h(0,m)=b/B=q(0,m) if a!=1. At n=m=1, h(1,1)=a/(a+c)=q(1,1) if ab!=c.

**Proof.** Let J=ar_*-b=X/(a+c). Then t_*=b alpha-nJ and H=alpha B+n beta. Direct fractions give

$$
h(n-1,m)-h(n,m)=\frac{\alpha(JB+b\beta)}{H H_n},\qquad
h(n,m-1)-h(n,m)=\frac{\alpha c t_*}{H H_m}. \tag{6.6}
$$

For m=1 the second difference need not be used because its coefficient in (4.1) is zero. Substituting (6.6) into (4.1) gives

$$
\mathcal Lh=\frac{ct_*}{H}
-\frac{A\alpha(JB+b\beta)}{HH_n}
-\frac{(m-1)\alpha c^2t_*}{HH_m}. \tag{6.7}
$$

Clear denominators, substitute J=X/(a+c), n=k+1 and m=l+1, and collect by k,l. The quadratic coefficients are c beta^2 X, c alpha beta(c+1)X and c^2 alpha^2 X; the linear coefficients are c beta P_n and c alpha P_m; the constant is zero. These are exactly (6.3)--(6.5), an identity between finite polynomials, rather than an approximation. Equation (6.6) also provides a short independent way to check the expansion. When m=1, H_m=beta A, which is nonzero in both applications below; (6.5) remains a valid rational identity even though the second difference is unused. The two boundary equalities follow by inserting n=0 and n=m=1 into t_*/H. $\square$

### Lemma L8. The region b>c

If c>1 and b< a< bc with b>c, then Hq>=t_* for every n,m>=1.

**Proof.** Here a>b>c>1, so alpha,beta,Y,z,X are positive. Both coefficient polynomials in (6.3) are nonnegative. To see each term's sign, note

$$
2b^2-b-c\ge2b(b-1)>0,\qquad
2b-c>0,\qquad b^3>c^2>c.
$$

All other factors in (6.3) are nonnegative. Consequently P>=0 for k,l>=0. Also H,H_n,H_m are positive: H_n=alpha B+(n-1)beta>0; for m>=2, H_m=alpha[b+(m-2)c]+n beta>0; for m=1 it is beta A>0. Equation (6.5) gives Lh<=0. Together with h(0,m)=q(0,m), Lemma L4 implies q>=h. Multiplication by H>0 gives Hq>=t_*. This includes all population boundaries; in particular k=l=0 makes P=0 and yields the exact two-job equality. $\square$

### Lemma L9. The region a<1

If c>1 and b< a< bc with a<1, then Hq>=t_* for every n,m>=1.

**Proof.** Now 0< b< a<1< c. Thus alpha<0, beta<0, while Y,z,X>0. We first prove P_n<=0 and P_m<=0 for every a in [b,1], holding b,c fixed.

As a polynomial in a, P_n has strictly positive quadratic coefficient b^2(c-1)+2bc. Its endpoint values are

$$
P_n(b,b,c)=b(b^3-c)(c-1)\le0,\qquad
P_n(1,b,c)=-(b-c)^2\le0. \tag{6.8}
$$

A convex quadratic lies below the chord connecting its values at b and 1, so P_n(a,b,c)<=0 throughout that interval.

For P_m use its exact degree-two Bernstein representation. Put s=(a-b)/(1-b), so 0<=s<=1. Then

$$
P_m(a,b,c)=(1-s)^2 B_0+2s(1-s)B_1+s^2 B_2, \tag{6.9}
$$

where

$$
\begin{aligned}
B_0&=b(b^3-c^2)(c-1),\\
B_1&=-\frac{(b-c)\,[2b^2-(b+1)c^2]}2,\\
B_2&=-(c+1)(b-c)^2.
\end{aligned} \tag{6.10}
$$

The endpoint identities give B_0 and B_2. The middle coefficient is P_m(b,b,c)+(1-b)partial_a P_m(b,b,c)/2, which simplifies to B_1 and verifies (6.9) by expansion. Both endpoints are nonpositive. For B_1, b-c<0, and

$$
2b^2-(b+1)c^2<2b^2-b-1=(2b+1)(b-1)<0.
$$

Hence B_1<0 as well. The three Bernstein weights in (6.9) are nonnegative, proving P_m<=0.

In (6.4), the coefficients of k^2,kl,l^2 are nonnegative because alpha beta>0; the remaining coefficients c beta P_n and c alpha P_m are also nonnegative. Thus P>=0. All three denominators H,H_n,H_m are negative. For m>=2 this follows from their displayed sums of negative terms, while for m=1, H_m=beta A<0. Their product is negative, so (6.5) now yields Lh>=0. Lemma L4 gives q<=h. Since H<0, multiplication reverses this last inequality and proves Hq>=t_*. $\square$

The rate regions of Lemmas L6, L8 and L9 exhaust (2.2): if a<1 use L9; otherwise a>=1 and either b<=c or b>c. No limit in a or b is needed at a=1 or b=c, because Lemma L6 includes both. The conclusion for a<=1, including the a=1 boundary handled by Lemma L6, is already covered by [3, Proposition 3] after relabeling. Lemma L9 supplies a self-contained proof of its a<1 portion so that the complete argument does not depend on that external theorem.

## 7. Completion of the all-policy proof

### Lemma L10. From the algebraic source to uniform optimality

If R_r(n,m)>=0 for all n,m>=1, then SP1 is optimal for every finite initial state among the full policy class of Section 2.

**Proof.** First apply induction on n+m to (3.8). Its coefficient b+n+(m-1)c is strictly positive, its two lower-state coefficients are nonnegative, D_r(0,m)=0, and at m=1 no m=0 deviation value is required. Therefore D_r(n,m)>=0 everywhere it is defined.

Now apply a second induction at service decision times. On an axis there is only one available class, so SP1 is optimal. At a state (n,m) with both classes present, any first service completion leaves strictly fewer jobs. By the induction hypothesis, SP1 is optimal for each possible subsequent state. Thus the best value after first choosing class 1 is F_r(n,m), and the best value after first choosing class 2 is G_r(n,m). Their difference is D_r>=0. The kernel formulation (3.1)--(3.2) or Lemma L1 makes this statement conditional on any observed past, not just a Markov restriction imposed on competitors. Randomization cannot exceed the maximum of these two values. This proves the claim. $\square$

**Sufficient direction of Theorem T1.** Lemmas L6, L8 and L9 give Hq>=t_* for all n,m>=1. Equations (3.9)--(3.10) yield R_r>=0 whenever r>=r_*. Lemma L10 proves uniform optimality. Together with (2.5), this completes the exact classification. $\square$

### Corollary C1. Sharpness and equality

For every fixed rate triple in (2.2), the smallest class-1 reward ratio that supports uniform optimality is exactly r_*. Equality is sufficient. At (1,1) the two first actions tie when r=r_*, and starting class 2 is strictly better when 1<=r< r_*.

**Proof.** The theorem gives sufficiency at the endpoint and necessity below it. The tie and strict inequality follow from (2.5). $\square$

## 8. Exact examples and reproducibility

Consider a=2,b=1,c=3. Then r_*=6/5. At r=6/5 both first actions in state (1,1) give 8/5, and Theorem T1 proves SP1 optimal for every finite initial population. At r=11/10, SP1 yields 3/2 in that state, whereas starting class 2 yields 31/20. The strict loss is 1/20. This shows why being faster and having a larger reward, by themselves, do not suffice.

A case in the double-fast region is a=4,b=3,c=2. Here r_*=4/3 and both first actions at (1,1) have value 2. Lemma L8 supplies the certificate for all larger populations. These examples illustrate the theorem; they are not evidence that finite tests imply its universal quantifiers.

The [exact diagnostic program](code/exact_diagnostics.py) evaluates the completion-time kernels independently of the event recurrences. Expanding the two binomials in (3.1) gives

$$
\begin{aligned}
K_s^{u,v}(i,j)
={}&\binom ui\binom vj\sum_{p=0}^{u-i}\sum_{q=0}^{v-j}
(-1)^{p+q}\binom{u-i}{p}\binom{v-j}{q}
\frac{s}{s+i+p+c(j+q)}.
\end{aligned} \tag{8.1}
$$

Equation (8.1) is a finite identity obtained by integrating exponentials with positive rates. For rational rates it can be computed with exact rational arithmetic, including the cancellation between its terms. The code compares the resulting optimal Bellman values with SP1, checks the event and marginal recurrences, checks the source and deviation signs in the tested rate regions, and evaluates below-threshold witnesses. A separate [symbolic check](code/symbolic_identities.py) expands the polynomial identities. The [reproduction guide](REPRODUCTION.md) gives the commands and links to the results. These diagnostics detect algebraic and implementation errors; the written induction and sign arguments remain the proof for all real parameters and all finite populations.

Theorem T1 is supported by the written proof above. The polynomial checks in this section cover identities used in the proof.

## 9. Sources, attribution, and limitations

[1] Gang Chen, Jean-Philippe Gayon, and Pierre Lemaire. *Technical Note—Stochastic Scheduling with Abandonment: Necessary and Sufficient Conditions for the Optimality of a Strict Priority Policy*. Operations Research 71(5):1789--1793, 2023; published online 1 April 2022. DOI: [10.1287/opre.2022.2285](https://doi.org/10.1287/opre.2022.2285). The inspected [11-page author version](https://perso.isima.fr/~jpgayon/Documents/PublicationsJP/WorkingPapers/stochastic-scheduling-2022.pdf), Section 3, is the source of the extension studied here. Publisher metadata and abstract were also checked; no byte-for-byte identity with the publisher's five-page layout is asserted.

[2] Nilay Tanik Argon, Serhan Ziya, and Rhonda Righter. *Scheduling Impatient Jobs in a Clearing System with Insights on Patient Triage in Mass Casualty Incidents*. Probability in the Engineering and Informational Sciences 22(3):301--332, 2008. DOI: [10.1017/S0269964808000272](https://doi.org/10.1017/S0269964808000272). [Author-hosted published PDF](https://ziya.web.unc.edu/wp-content/uploads/sites/15166/2018/02/Argon-Ziya-Righter-2008.pdf). The model, aligned-order result and restricted sufficient conditions are prior work. Its equal-reward conjecture is not our claim of a second independent project.

[3] Evin Uzun Jacobson, Nilay Tanik Argon, and Serhan Ziya. *Priority Assignment in Emergency Response*. Operations Research 60(4):813--832, 2012. DOI: [10.1287/opre.1120.1075](https://doi.org/10.1287/opre.1120.1075). Reward-dependent and high-abandonment sufficient conditions, as well as the elementary two-job comparison, are prior results.

[4] Yihua Xu, Rohan Ghuge, and Sebastian Perez-Salazar. *Sequential Selection with Expirations*. [arXiv:2406.15691v2](https://arxiv.org/abs/2406.15691v2), revised 3 February 2026. The inspected v2 is used for the current near-neighbor comparison; it should not be confused with the earlier v1 title. This is a preprint reference, not the formal journal benchmark for the present result.

[5] *Strict Priority in Nonpreemptive Clearing Systems with Common Exponential Patience*. Unpublished companion research note, 25 November 2026. Its general necessary conditions and marginal/rational-comparison framework are credited. The present proof does not require its theorem as an assumption.

[6] *Equal-reward priority classification*. Unpublished companion research on the parameter region described in Section 1; the present result concerns the disjoint successful region in (2.2). No reliance on the companion's unpublished mathematical conclusion is made.

The literature comparison also considered the short ROADEF 2021 announcement of three-job and preemptive results, the static-list model of Salch, Gayon and Lemaire, and the accessible abstract of Ross's 2015 work. The latter full text was not obtained. The novelty statement is limited to the sources actually inspected and does not certify worldwide priority. The manuscript has not undergone external peer review.
