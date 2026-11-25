---
title: "Exact Two-Sided Coverage of the Bivariate Gaffke Intervals"
lang: en-US
---

# Abstract

For two independent bounded observations with a common mean, we determine the exact worst-case noncoverage of the closed interval obtained by inverting the admissible bivariate Gaffke merger at equal tail levels. The curve has two jumps. At ordinary confidence levels, the true uniform noncoverage is the per-tail level itself. At larger levels, the worst case switches first to a two-orthant Bernoulli construction and then to two unequal two-point marginal laws. For the original interval we find the exact fixed-mean envelope and show that it has only the first jump. At high tail levels, identical marginal laws cannot approach the unrestricted improved-rule supremum. We also determine the sharp small-level expected length gain of the merger improvement, uniformly at each fixed true mean.

## 1. Model and results

Let $X_1,X_2$ be independent random variables in $[0,1]$ with common mean $\mu$; their distributions may differ. Fix the common per-tail level $0<\alpha<1/2$, and put $s=\sqrt{1-\alpha}$, $u=1-s$. For $0\le x\le y\le1$, let

$$
L_\alpha(x,y)=
\begin{cases}
\sqrt{\alpha xy},&x\ge\alpha y,\\
(uy+\sqrt{u^2y^2+4usxy})/2,&x<\alpha y.
\end{cases}
$$

The closed interval is $I_\alpha^{\mathrm{ad}}(x,y)=[L_\alpha(x,y),1-L_\alpha(1-y,1-x)]$, extended symmetrically to unsorted observations. The earlier inversion gives these endpoints and proves their validity at coverage at least $1-2\alpha$. Let $I_\alpha^{\mathrm{old}}$ be the analogous closed interval from the original Gaffke merger, with the same tail level and with lower endpoint $y-s\sqrt{y(y-x)}$ in the mixed branch and $\sqrt{\alpha xy}$ on the other branch. Define

$$
R_\alpha(\mu)=\sup_{\substack{X_1,X_2\ {\mathrm{independent}}\\
0\le X_i\le1,\ \mathbb E X_i=\mu}}
\mathbb P\{\mu\notin I_\alpha^{\mathrm{ad}}(X_1,X_2)\},
\qquad W(\alpha)=\sup_{\mu\in[0,1]}R_\alpha(\mu).
\tag{1}
$$

The interval endpoints are continuous in the data. Exclusion at an endpoint is strict, because the interval is closed. For any interior candidate $\theta$, write the sorted data as $x\le y$. The lower-side exclusion $L_\alpha(x,y)>\theta$ is impossible if $y\le\theta$, is equivalent to $\theta^2<\alpha xy$ if $x\ge\theta$, and is equivalent to $\theta^2<uy(\theta+s x)$ when $x<\theta<y$. These follow from the monotone p-value inversion, or directly from the endpoint formula. The upper side uses the complementary data and $1-\theta$. Each side has probability at most $\alpha$ under the true mean, by the validity of the admissible merger. The interval always contains the sample mean, so joint noncoverage is the sum of the probabilities of the two disjoint one-sided exclusions.

**Theorem 1 (exact joint calibration).** Let $s_0$ be the unique zero of $1+3s-s^2-7s^3$ in $(1/\sqrt2,3/4)$, and put $\alpha_c=1-s_0^2$, approximately $0.477157528632467$. When $\alpha>\alpha_c$, write

$$
\mu_+(\alpha)=
\frac{\alpha+2s+\sqrt{(1+s)(1+3s-s^2-7s^3)}}{2(1+2s)}.
\tag{2}
$$

Then

$$
W(\alpha)=
\begin{cases}
\alpha,&0<\alpha\le1/4,\\
\alpha+(1-\sqrt\alpha)^2,&1/4<\alpha\le\alpha_c,\\
\alpha+\mu_+(\alpha),&\alpha_c<\alpha<1/2.
\end{cases}
\tag{3}
$$

At each of the two thresholds the value equals its left limit and lies strictly below its right limit. In particular using $\alpha=\varepsilon$ in both endpoints gives coverage at least $1-\varepsilon$ for $0<\varepsilon\le1/4$, with equality as an infimum over laws. For instance the two endpoints can each use $0.05$ at 95% simultaneous coverage. This interval is contained in the earlier interval that used $0.025$ on each side. At $(1,1)$ its lower endpoint is $\sqrt{0.05}$, whereas the earlier lower endpoint was $\sqrt{0.025}$. Section 3 also gives the exact envelope at any fixed $\mu$, including the regions in which error is impossible.

**Theorem 2 (expected length gain).** Let $J_\alpha=|I_\alpha^{\mathrm{old}}|-|I_\alpha^{\mathrm{ad}}|$ denote the nonnegative length reduction at the same tail level, and let $E_\alpha(\mu)$ denote its supremum in expectation over the same marginals as in (1). Uniformly over $0\le\mu\le1$,

$$
E_\alpha(\mu)=\frac{\alpha}{4}\mu(1-\mu)+O(\alpha^2)
\quad(\alpha\downarrow0).
\tag{4}
$$

Thus the largest expected gain across means is $\alpha/16+O(\alpha^2)$. The extremizing constructions at this order may be i.i.d. The mixed-corner noncoverage branch is approached by unequal two-point marginals.

## 2. Reduction to four support points

For $\mu\in(0,1)$, a marginal $P$ of that mean is a mixture of its point mass at $\mu$ and two-point laws with atoms $a<\mu<b$. An explicit decomposition uses the restrictions $P_-$ below and $P_+$ above $\mu$. Write $D=\int(\mu-a)\,dP_-(a)=\int(b-\mu)\,dP_+(b)$. If $D=0$, $P=\delta_\mu$. Otherwise take the mixing measure $(b-a)P_-(da)P_+(db)/D$, keeping the original mass at $\mu$. A two-point law at $a,b$ has probabilities $(b-\mu)/(b-a)$ and $(\mu-a)/(b-a)$. Multiplying by the mixing measure and integrating gives $P_-$ and $P_+$ exactly. Taking the product of these mixtures is valid by independence. Hence to upper bound the noncoverage probability for all laws it suffices to bound two-point marginal pairs. A factor $\delta_\mu$ may be approximated for this supremum by the mean-$\mu$ equal mixture at $\mu-\eta,\mu+\eta$: for each previously rejecting point among finitely many corners the rejection is strict and both nearby corners still reject for small $\eta$. Both boundary means give zero noncoverage.

In a two-point pair write the first support as $a<\mu<c$ and the second as $b<\mu<d$. Denote high probabilities by $p_1,p_2$ and low probabilities by $\bar p_1=1-p_1,\bar p_2=1-p_2$. Lower-side rejection is increasing in both observations and never occurs at the low-low corner. Upper-side rejection has the reverse monotonicity.

The most extreme possibilities are at all 1 and all 0. Thus lower-side activity somewhere is equivalent to $\mu^2<\alpha$, upper-side activity to $(1-\mu)^2<\alpha$. When neither direction is active, $R_\alpha(\mu)=0$. When exactly one is active, $R_\alpha(\mu)=\alpha$. To see sharpness in the lower direction, take i.i.d. observations at $0,h$, where $h\downarrow\mu/\sqrt\alpha$ from above and $h\le1$. The high/high corner alone has rejection probability $(\mu/h)^2\uparrow\alpha$. Complementing proves sharpness in the upper direction. When $0<\alpha\le1/4$ at most one direction is active for any $\mu$. This proves the first part of (3).

Suppose now both directions are active. If only the high/high corner is lower-rejecting and only the low/low corner is upper-rejecting, put $P_H=p_1p_2$ and $P_L=\bar p_1\bar p_2$. Each is at most $\alpha$, and $\sqrt{P_H}+\sqrt{P_L}\le1$ by Cauchy–Schwarz. Since $\sqrt\alpha>1/2$, maximizing the sum of squares under these inequalities gives

$$
B_\alpha=\alpha+(1-\sqrt\alpha)^2 .
\tag{5}
$$

Indeed the right side is the maximum of $v^2+w^2$ on $0\le v,w\le\sqrt\alpha,\ v+w\le1$, obtained at a vertex with $v=\sqrt\alpha$ or $w=\sqrt\alpha$ and $v+w=1$. The preceding i.i.d. construction at $0,h$ approaches $B_\alpha$ for every doubly active $\mu$: the all-high corner rejects below and the all-zero corner above, since $(1-\mu)^2<\alpha$. If one direction has no rejecting corners, the bound $\alpha$ is sufficient.

## 3. A mixed corner and the full envelope at fixed mean

If a mixed corner $x<\mu<y$ rejects below, then $y/\mu>B_\alpha^{\mathrm{mix}}(x/\mu)>1/\alpha$, where $B_\alpha^{\mathrm{mix}}(v)=1/[u(1+s v)]$ is the admissible merger's mixed boundary. Thus $\mu<\alpha$, since $y\le1$. The other direction has $1-\mu>\alpha$ and cannot have a mixed rejection. Complementing the data interchanges the two sides, so assume that the lower direction has a mixed corner and that the upper direction rejects at low/low. Both mixed corners cannot reject below in this situation. Monotonicity would then make all three corners outside low/low reject below, and all four would be out of the interval, giving probability 1, greater than $2\alpha$. After permuting variables, the sole mixed lower rejection is at $(a,d)$ and the total noncoverage is

$$
p_2+\bar p_1\bar p_2
=1-\frac{\mu-a}{c-a}\frac{d-\mu}{d-b}.
\tag{6}
$$

The necessary strict inequalities for this pattern are

$$
d>D_\mu(a):=\frac{\mu^2}{u(\mu+s a)},\qquad
(1-a)(1-b)>\frac{(1-\mu)^2}{\alpha}.
\tag{7}
$$

Assume both directions are active and $\mu<\alpha$. Set

$$
A_\mu=1-\frac{(1-\mu)^2}{\alpha},\qquad
P_\alpha(\mu)=(1+2s)\mu^2-(\alpha+2s)\mu+s^3.
$$

Then $0<A_\mu<\mu$. In (6) increasing $c$ and $a$, or decreasing $b$ and $d$, increases the noncoverage. The endpoint choices $c=1,b=0$ also preserve both strict inequalities in (7). They make the upper permissible limit of $a$ be $A_\mu$, and $D_\mu(a)$ decreases when $a$ increases. Thus the largest mixed-corner error at this fixed mean is

$$
M_\alpha(\mu)=
1-\left(1-\frac{\alpha}{1-\mu}\right)s
   \left(1-u\,\frac{A_\mu}{\mu}\right),
\tag{8}
$$

provided that $D_\mu(A_\mu)<1$, which is equivalent to $P_\alpha(\mu)<0$ by substitution and $\alpha=u(1+s)$. For necessity, $a<A_\mu$ and $d>D_\mu(a)$ must hold with $d\le1$. For sharpness, take $a\uparrow A_\mu$ from below with $c=1,b=0$ and $d\downarrow D_\mu(A_\mu)$ from above, maintaining $d>D_\mu(a)$ and $d\le1$. The strict margin $D_\mu(A_\mu)<1$ makes this possible. Moreover $D_\mu(a)>\mu$ since $u(1+s a/\mu)<\alpha<1$. The prescribed corners strictly reject and all the remaining corners are accounted for by the preceding classification. When $D_\mu(A_\mu)=1$ the pattern is impossible because (7) is strict.

Consequently, if both tests are active, $R_\alpha(\mu)$ is the maximum of $B_\alpha$ and whichever values (8) are feasible at $m=\mu$ or $m=1-\mu$, with feasibility defined by $m<\alpha$ and $P_\alpha(m)<0$. Both reflected mixed terms cannot be feasible simultaneously since $\alpha<1/2$. Together with the zero and single-side formulas this is an exact fixed-mean envelope.

## 4. Optimizing over the true mean

The interval of interest for the mixed branch after reflection is $1-\sqrt\alpha<\mu<\alpha$. Its left endpoint is positive. The discriminant of $P_\alpha$ is

$$
\Delta=(1+s)(1+3s-s^2-7s^3).
$$

The cubic second factor decreases strictly on $[1/\sqrt2,1]$. It is positive at $1/\sqrt2$ and negative at $3/4$, proving the stated unique $s_0$. For $\alpha\le\alpha_c$ the discriminant is nonpositive, so the strict mixed case is impossible. For $\alpha>\alpha_c$, the vertex is $1/2-s^2/[2(1+2s)]\in(3/8,2/5)$. Both natural endpoints lie outside this vertex because $\alpha>7/16$ and $1-\sqrt\alpha<3/8$. The polynomial is positive at each endpoint: at the left $A_\mu=0$, giving $D_\mu(A_\mu)=\mu/u>1$, and at the right $A_\mu<\mu=\alpha$, so $D_\mu(A_\mu)>D_\mu(\mu)=\mu/\alpha=1$. Therefore both roots lie strictly within the natural interval and its feasible subinterval is exactly between the roots.

On this feasible interval (8) is increasing in $\mu$. The two positive factors multiplied after the minus sign are decreasing, because $1-\alpha/(1-\mu)$ decreases and

$$
\frac{d}{d\mu}\left(\frac{A_\mu}{\mu}\right)=
\frac{s^2/\mu^2-1}{\alpha}>0 .
$$

Here $\mu<\alpha<1/2<s$. At the larger root (2) the support limit has $d=D_\mu(A_\mu)=1$. In that limit its lower rejection probability tends to $p_2=\mu_+$, and the upper rejection probability tends to $\bar p_1\bar p_2=\alpha$. Thus the mixed branch has global supremum $\alpha+\mu_+$. It is strictly larger than $B_\alpha$, since $\mu_+>3/8$ and $(1-\sqrt\alpha)^2<1/4$. This proves (3).

As $\alpha\downarrow1/4$ from above the Bernoulli branch tends to $1/2$, whereas the value at $1/4$ is $1/4$. At $\alpha_c$ the mixed interval first opens from the vertex, which exceeds $3/8$. Its right limit is therefore larger than the value of the previous branch. These limits use closed intervals throughout. For a concrete asymmetric instance take $\alpha=301/625$, $\mu=2/5$, and independent supports $(1/4,1)$ and $(0,99/100)$, with their probabilities determined by the mean. Its mixed-plus-orthant noncoverage equals $436/495$. With two Bernoulli observations the interval is the central Clopper–Pearson interval with the same side level, already identified in the source. Ordinary Bernoulli observations give only the first jump.

## 5. Comparison with the original rule and i.i.d. sampling

Let $R_\alpha^{\mathrm{old}}(\mu)$ be the supremum of the noncoverage probability of the original interval over two independent $[0,1]$ marginals with common mean $\mu$, for $0<\alpha<1/2$. Let $R_\alpha(\mu)$ be the companion admissible envelope, and write $R_\alpha^{\mathrm{iid}}(\mu)$ for the admissible envelope restricted to a common law. As before let $q=\sqrt\alpha$, $s=\sqrt{1-\alpha}$, $u=1-s$, $\nu=1-\mu$, and $B_\alpha=\alpha+(1-\sqrt\alpha)^2$.

### 5.1. Exact coverage of the original interval

For the same true mean in the same product class,

$$
R_\alpha^{\mathrm{old}}(\mu)=
\begin{cases}
0,&\mu^2\ge\alpha,\quad \nu^2\ge\alpha,\\
\alpha,&\text{exactly one of }\mu^2<\alpha,\ \nu^2<\alpha,\\
B_\alpha,&\mu^2<\alpha,\quad \nu^2<\alpha.
\end{cases}
\tag{9}
$$

The original and admissible endpoints coincide at the all-1 and all-0 samples and in the active product branches. Both rules are monotone in the data, so the same tail activity conditions apply. If at most one tail is active, the exact envelope follows from validity and the i.i.d. two-point construction in the companion proof.

For two active tails, use the same reduction to two-point marginals. If no mixed corner rejects and both tails have rejecting corners, the two orthant probabilities sum to at most $B_\alpha$ as before. This bound is approached by the i.i.d. two-point construction at $(0,h)$ from Section 2. It remains to exclude an additional mixed corner when the other side rejects. After reflection and permutation write the purported lower mixed corner as $(a,d)$, with $a<\mu<d$, and the upper excluding corner as $(a,b)$, where $b<\mu$. An original-rule mixed rejection would also reject under the admissible rule, so $\mu<\alpha$. The upper side can only reject at low/low. Its product condition gives
$a<A_\mu=1-\nu^2/\alpha<\mu<\alpha$.
By monotonicity the original lower endpoint at $(a,d)$ is at most its lower endpoint at $(A_\mu,1)$. Since $A_\mu<\alpha$, the original mixed formula gives

$$
L_{\alpha}^{\mathrm{old}}(A_\mu,1)
=1-s\sqrt{1-A_\mu}
=1-\frac{s\nu}{q}
<1-\nu=\mu ,
$$

because $s>q$. This rules out the mixed exclusion. Together the cases prove (9). Consequently the original joint supremum over $\mu$ has only the first jump and equals $\alpha$ up to $\alpha=1/4$ and $B_\alpha$ thereafter. The second jump in the admissible calibration comes from the enlarged mixed rejection region.

### 5.2. A strict gap for i.i.d. data

If both tails are active, the admissible fixed-mean envelope under the i.i.d. restriction satisfies

$$
R_\alpha^{\mathrm{iid}}(\mu)
\le\frac{B_\alpha+R_\alpha(\mu)}2 .
\tag{10}
$$

This implies a strict global gap for $\alpha>\alpha_c$: the i.i.d. worst-case noncoverage is at most $(B_\alpha+\alpha+\mu_+)/2<\alpha+\mu_+$. For $\alpha\le\alpha_c$ the ordinary i.i.d. Bernoulli construction already approaches the unrestricted joint supremum.

For (10), if neither mixed direction is possible then $R_\alpha(\mu)=B_\alpha$ and the bound is immediate. Otherwise one can reflect to assume $\mu<\alpha$ and $\nu>\alpha$. In particular upper-side rejection is possible only at the low/low corner. Let

$$
\ell_*=1-\nu/q,\qquad a_{\min}(\mu)=\frac{\mu(\mu-u)}{us}.
$$

When a lower-side mixed corner $(a,d)$ rejects, its inequality is $\mu^2<ud(\mu+s a)\le u(\mu+s a)$, so $a>a_{\min}(\mu)$. For all $\mu>1-q$ in the considered range, $a_{\min}(\mu)>\ell_*$. At $\mu=1-q$ this follows from $s>q$, since $\ell_*=0$ there and $\mu>u$. On the rest of the interval, the derivative of $a_{\min}$ is at least
$1/s+2(s-q)/(us)\ge1/q$, the derivative of $\ell_*$; the inequality uses $2q\ge u$.

Decompose the common marginal law into two-point mean-preserving components as in Section 2. Split them into the two classes according to whether the lower support point is below $\ell_*$ or at least $\ell_*$. If two components both belong to the first class, neither lower mixed corner can reject. If they both belong to the second, upper low/low rejection is impossible because $(1-a)(1-b)\le(\nu/q)^2$. Thus a pair drawn within one class has error at most $B_\alpha$, by the pure-orthant or single-tail bound. This also addresses the reflected mixed direction, which cannot occur when $\nu>\alpha$. For a pair from two different classes use the unrestricted fixed-mean bound $R_\alpha(\mu)\ge B_\alpha$. In an i.i.d. draw the class weights are the same for the two independent latent components. If the first class has weight $w$, the probability of different classes is $2w(1-w)\le1/2$. Averaging gives (10).

An atom of the original law at $\mu$ can first be split into a symmetric mean-preserving mass at $\mu\pm\eta$ in each of the i.i.d. copies. The resulting product laws converge weakly to the original product law. The noncoverage set is open at a fixed interior mean by continuity of the closed-interval endpoints, so its original probability is at most the lower limit of the perturbed probabilities. This proves the same bound with a possible atom at the mean.

The upper bound (10) need not be sharp within the i.i.d. class. Its purpose is to separate that class from the unrestricted exact frontier in the high-level mixed regime. For $0<\alpha\le1/4$, both rules calibrate to $1-\alpha$. For $\alpha>\alpha_c$ the admissible rule gains more sample-wise shrinkage at the same tail input, and its worst-case simultaneous noncoverage is correspondingly larger. These statements compare the two specified intervals at equal per-tail levels. They do not assert optimality among all confidence sets.

## 6. Sharp expected gain of the narrower interval

The earlier inversion gives the exact lower endpoint gain as $yG_\alpha(x/y)$ for sorted $x\le y$ with $y>0$, and zero for $y=0$, where

$$
G_\alpha(r)=\frac{u+\sqrt{u^2+4us r}}2-1+s\sqrt{1-r}
\quad(0\le r\le\alpha),
$$

extended by zero beyond $\alpha$. The upper endpoint gain uses the complementary data. Write $g_\alpha=\max G_\alpha$. The earlier isolated-endpoint extremum is $g_\alpha=(\sqrt{1+3s}-(1+s))/2=\alpha/16+O(\alpha^2)$. The maximum total sample gain, $J_{\max,\alpha}=\alpha/8+O(\alpha^2)$, occurs at a symmetric pair $(\ell_\alpha,1-\ell_\alpha)$, where $\ell_\alpha=O(\alpha)$. These are the previous sample-wise results.

Whenever the lower endpoint gain is positive, the smaller observation is less than $\alpha$. For unsorted coordinates $X_1,X_2$, bound this gain by

$$
g_\alpha[X_2\mathbf1_{\{X_1<\alpha\}}+X_1\mathbf1_{\{X_2<\alpha\}}].
$$

Independence separates each product in expectation. The bound $P(X_i<\alpha)\le(1-\mu)/(1-\alpha)$ follows from $0\le X_i\le1$ and its mean. For the upper gain use $1-X_i$ and the same estimate. It follows that

$$
\mathbb E[J_\alpha]\le \frac{4g_\alpha}{1-\alpha}\mu(1-\mu).
\tag{11}
$$

For a lower bound at every $\mu\in[\ell_\alpha,1-\ell_\alpha]$, take an i.i.d. law at these two points with probability
$p=(\mu-\ell_\alpha)/(1-2\ell_\alpha)$ at the high point. The equal-outcome samples have zero gain, and the mixed outcome contributes $J_{\max,\alpha}$ with probability $2p(1-p)$. Uniformly on this mean interval, $\lvert p-\mu\rvert=O(\alpha)$. This gives the right side of (4) with a uniform $O(\alpha^2)$ error. In the remaining strips of means $\mu(1-\mu)=O(\alpha)$, so the target $\alpha\mu(1-\mu)/4$ is already $O(\alpha^2)$ and nonnegativity gives the corresponding lower estimate. This proves (4).

## 7. Sources and finite evidence

The admissible p-value, its mixed boundary, its exact one-sided validity, and the pointwise strict improvement regions are due to Ming et al. v1 Definition 3.3, Lemmas 3.4–3.5, and Theorem 3.6. Their §4.4 leaves the concrete bivariate interval unstudied, while §5.5 already records its qualitative dominance and §5.3 identifies the original Bernoulli intervals with Clopper–Pearson. The earlier earlier research manuscript dual-observation paper solves the algebraic inversion and the sharp sample-wise length reduction. The present proofs optimize the two-direction rejection probability over product laws with fixed mean, producing the additional mixed-corner branch and a second jump. The expected-gain result optimizes over observations generated with that mean. [Ming et al. v1](https://arxiv.org/pdf/2607.18661v1) · Earlier exact inversion

The original Gaffke validity theorem of Vlassis and Thomas, the fast discrete-support computation of Abraham, and the conditional rank improvement for ordered i.i.d. samples address different statistical rules or sampling information. Discontinuous coverage as a Bernoulli parameter crosses a discrete interval endpoint is classical. Newcombe (1998), p. 862, discusses the Clopper–Pearson case and distinguishes guaranteed coverage from coverage equal to its nominal value at every parameter. The step at $\alpha_c$ here concerns the admissible improvement over independent bounded marginals and comes from asymmetric, non-Bernoulli support. [Vlassis and Thomas](https://arxiv.org/pdf/2607.08415) · [Abraham](https://arxiv.org/pdf/2611.29512v1) · [Newcombe (1998), pp. 857–872](https://stats.org.uk/statistical-inference/Newcombe1998.pdf) · Earlier ordered-i.i.d. rule

Thulin (2014), Sections 3–4, studies expected-length differences and one-sided bounds for binomial Clopper–Pearson intervals as the sample size grows. The expected-length theorem here keeps the number of observations at two, takes the tail level to zero, and optimizes over arbitrary bounded independent marginals with fixed common mean. [Thulin, Electronic Journal of Statistics 8, 817–840](https://arxiv.org/pdf/1303.1288)

The Python standard-library verification tests strict exclusions by squaring positive rational expressions. The primary script checks 974,512 pairs of two-point marginals, including 192 mixed-plus-orthant pairs, and 92 rational enclosures for the expected-gain constructions. The comparison script checks 195,840 pairs for the original rule and 40,976 same-type pairs for the admissible rule. It reproduces the probabilities $92/165$ and $436/495$ at the same asymmetric example, along with $323437/490050$ under the equal mixture of those two laws used in both coordinates. The primary script brackets the transition level and checks strict probability witnesses near both changes of regime. Run the primary and comparison scripts from the accompanying evidence directory. [Coverage and gain verifier](evidence/code/verify_exact.py) · [Coverage and gain results](evidence/results/main.json) · [Comparison verifier](evidence/code/verify_comparisons.py) · [Comparison results](evidence/results/comparisons.json)
