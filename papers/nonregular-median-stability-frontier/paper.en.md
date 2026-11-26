# Gradual stability transitions for nonregular median estimation

**Research manuscript, 26 November 2026.** Mathematical results and proofs are presented for independent research review. This manuscript has not undergone external peer review. Lean formalization is a separate, still outstanding deliverable.

## Abstract

Does average-case algorithmic stability necessarily produce an abrupt transition from uninformative estimation to the unconstrained statistical rate? We give a negative answer for an entire nonparametric class of median problems. Fix $r>1$ and $0 \lt c\le 2^{-r-1}$. Consider all continuous distributions on $[-1,1]$ whose unique median $q$ satisfies a two-sided polynomial CDF margin of order $r$ and constant $c$ throughout the support. For every sample size $n\ge1$ and stability budget $\beta\ge0$, the squared-error minimax risk is, up to constants depending only on $r,c$,

$$
\min\{1,\ n^{-1/r}+(n\beta)^{-2/(r-1)}\}.
$$

The same rate holds for pairwise leave-one-out average stability, every finite power version, and expected worst-case replacement stability. Constraints hold on arbitrary data sets and allow randomized, order-dependent procedures. The lower bound converts average deletion stability into a local Lipschitz bound on the expected response of a Bernoulli experiment. A fixed conditional sampling kernel transfers this obstruction to a least-favorable median submodel. The upper bound uses a measurable countable metric envelope that simultaneously preserves a prescribed Lipschitz budget and the functional's original Hölder modulus. We also prove a nonasymptotic modulus-and-approximation sandwich for every continuous functional on an interior Bernoulli interval. For nonregular medians, consistency requires and is achieved by $n\beta\to\infty$, while the ordinary rate requires a larger budget of order $n^{-(r+1)/(2r)}$. The resulting polynomially wide intermediate regime answers the existence question in Chakraborty, Luo and Barber [1, §8.3].

## Introduction and contribution

An estimator can be perfectly stable by ignoring its observations. The statistical question is therefore how much accuracy is compatible with a specified limit on data sensitivity. We use the fixed-data, shared-seed definitions of [1]: in the average constraint one averages changes across pairs of deletions from the same $n+1$ observations, then takes a supremum over the original data set. This is different from averaging stability over random data.

The primary result is Theorem 10.1. It concerns the whole class defined in (10.2), not just a parametric example or a selected family of algorithms. The class permits arbitrary continuous CDFs, including singular distributions where admissible. Its least-favorable members have a locally flat CDF at the median. Their inverse CDF responds to small probability changes with a fractional power. This creates two distinct budget scales: one permits consistency and the other permits the ordinary statistical rate. A deterministic symmetric estimator attains the upper rate simultaneously for every stability constraint considered here.

The reusable lower-bound result is Theorem 2.1. On an interior Bernoulli experiment, the mean response of every average-stable estimator must have Lipschitz constant at most a fixed multiple of $n\beta$. The distance of the target to such functions is therefore an unavoidable bias. We prove the reduction for arbitrary randomization and input ordering; these details are necessary because the original randomized stability classes are not literally nested at the worst-case endpoint. Lemma 9.1 supplies the matching upper-bound mechanism in Hölder metric models, with explicit measurability conditions and no algorithmic-efficiency claim.

The closest stability work [1] already provides the decision-theoretic framework, general lower bounds, and worst-case coupling tools. Its latest checked version, v2 dated 22 August 2026, retains the average-stability gradual-transition question. We resolve that existence question; we do not characterize the still-open intermediate regime of its nonparametric regression example. Classical modulus methods [2,4], scalar metric envelopes, and private-median extension methods [3] provide important context. These ingredients themselves are not claimed as new. The precise comparisons and the scope of the literature audit appear in Section 11 and the accompanying novelty report.

The reader can start with the class and result in Section 10, then consult Sections 3–6 for the average-stability obstruction, Section 8 for its transport to mixtures, and Section 9 for the constructive upper bound. All asymptotic comparisons keep the model constants fixed. The paper proves rates, rather than leading minimax constants.

## 1. Definitions and conventions

Let n be a positive integer, N=n+1, and let the sample space be a measurable subset of a Euclidean space. A randomized estimator is a measurable map

$$
T:\mathcal X^n\times[0,1]\longrightarrow\mathbb R,
$$

where the auxiliary variable $\xi$ is uniform and independent of the observations. Ordered vectors are used so that no permutation invariance is assumed at the outset. For a vector $u$ of length N, let $u^{\setminus i}$ retain the original order after deleting coordinate i.

For $1\le s<\infty$, define

$$
S_s(T)=
\sup_{u\in\mathcal X^N}
\left\{
\frac1{N^2}\sum_{i,j=1}^N
\mathbb E_\xi
|T(u^{\setminus i};\xi)-T(u^{\setminus j};\xi)|^s
\right\}^{1/s}.
\tag{1.1}
$$

The average-case constraint is $S_1(T)\le\beta$. Separately define the weak worst-case replacement constraint

$$
S_{\mathrm{wc}}(T)=
\sup_{\substack{x,y\in\mathcal X^n\\
                  x,y\text{ differ in at most one coordinate}}}
\mathbb E_\xi |T(x;\xi)-T(y;\xi)|
\le\beta .
\tag{1.2}
$$

For a distribution class $\mathcal P$ and target $\theta:\mathcal P\to\mathbb R$, put

$$
R_{n,\beta}^{s}(\theta;\mathcal P)
=\inf_{S_s(T)\le\beta}\ 
 \sup_{P\in\mathcal P}\mathbb E_{P^{\otimes n},\xi}
          |T(X;\xi)-\theta(P)|^2,
\tag{1.3}
$$

and define $R^{\mathrm{wc}}_{n,\beta}$ using (1.2).
Write $R^{\mathrm{av}}=R^1$.

All stability suprema are over the entire stated sample space, including data sets atypical under, or impossible under, a particular member of the statistical model. The two occurrences of $\xi$ in every difference are the same random variable.

For bounded targets, deterministic symmetric estimators suffice for every risk in (1.3) and for its worst-case counterpart. This will be proved in Section 3. Consequently,

$$
R^{\mathrm{av}}_{n,\beta}
\le R^s_{n,\beta}
\le R^{\mathrm{wc}}_{n,\beta},\qquad 1\le s<\infty.
\tag{1.4}
$$

Equation (1.4) is a statement about minimax values after a justified reduction. It is not an assertion that weak worst-case stability of an arbitrary randomized estimator controls its higher seed moments.

## 2. Interior Bernoulli theorem

Fix $0 \lt a<1/2$, let $I=[a,1-a]$, and let $f\in C(I;\mathbb R)$. The experiment is $X_i\sim {\mathrm{Ber}}(p)$, independently, with $p\in I$, and the target is $f(p)$. In this section every stability supremum is over all binary data sets.

Define the modulus

$$
\omega_f(t)=
\sup_{\substack{x,y\in I\\|x-y|\le t}}|f(x)-f(y)|,
\qquad t\ge0,
\tag{2.1}
$$

and the uniform Lipschitz approximation error

$$
E_L(f)=\inf_{\operatorname{Lip}_I(g)\le L}
             \|f-g\|_{\infty,I},
\qquad L\ge0.
\tag{2.2}
$$

The infimum in (2.2) runs over all real-valued functions on I with Lipschitz constant at most L. Set

$$
C_a=\frac1{a(1-a)},\qquad
d_a=\sqrt{\frac{a(1-a)}2}.
\tag{2.3}
$$

### Theorem 2.1

For every $n\ge1$, $\beta\ge0$, and $1\le s<\infty$,

$$
\begin{split}
\max\left\{
 \frac1{16}\omega_f(d_a/\sqrt n)^2,\,
 E_{C_a n\beta}(f)^2
\right\}
&\le R^{\mathrm{av}}_{n,\beta}(f;I)\\
&\le R^s_{n,\beta}(f;I)\\
&\le R^{\mathrm{wc}}_{n,\beta}(f;I)\\
&\le
\min\left\{
\frac{\operatorname{osc}_I(f)^2}{4},\
\left[E_{n\beta}(f)
       +\frac32\omega_f(1/\sqrt n)\right]^2
\right\}.
\end{split}
\tag{2.4}
$$

In particular, the last term is bounded by

$$
2E_{n\beta}(f)^2+\frac92\omega_f(1/\sqrt n)^2.
\tag{2.5}
$$

The approximation error has the exact expression

$$
E_L(f)=
\frac12\sup_{x,y\in I}
   \bigl(|f(x)-f(y)|-L|x-y|\bigr)_+
=\frac12\sup_{0\le t\le |I|}
   \bigl(\omega_f(t)-Lt\bigr)_+.
\tag{2.6}
$$

The different budget arguments $C_a n\beta$ and $n\beta$ in (2.4) are intentional. For arbitrary continuous f this is a sandwich with a constant change in stability budget, not a same-budget constant-factor equivalence of the risks. For example, $E_L(f)$ can become zero at a finite Lipschitz threshold.

## 3. Removing randomization and ordering

Assume the target values lie in a compact interval $[m,M]$. Projecting T onto this interval cannot increase squared loss at any target in the interval. Since interval projection is 1-Lipschitz, it does not increase any $S_s$ or $S_{\mathrm{wc}}$. Thus we may assume T bounded and avoid integrability qualifications.

Define

$$
T_0(x)=\frac1{n!}\sum_{\sigma\in\mathfrak S_n}
                   \mathbb E_\xi T(x_\sigma;\xi).
\tag{3.1}
$$

This estimator is deterministic and symmetric. For each iid law P, Jensen's inequality and exchangeability give

$$
\mathbb E_P|T_0(X)-\theta(P)|^2
\le
\frac1{n!}\sum_\sigma
\mathbb E_{P,\xi}|T(X_\sigma;\xi)-\theta(P)|^2
=\mathbb E_{P,\xi}|T(X;\xi)-\theta(P)|^2.
\tag{3.2}
$$

For worst-case stability, apply the same permutation $\sigma$ and the same seed to two coordinate-replacement neighbors x and y. Their permuted versions remain neighbors. Jensen then gives $S_{\mathrm{wc}}(T_0)\le S_{\mathrm{wc}}(T)$.

For $S_s$, a common permutation of n positions does not in general commute with two different deletions. The following N-position coupling is the correct argument.

Fix $u=(u_1,\ldots,u_N)$. Draw a uniform permutation $\pi\in\mathfrak S_N$. For each original index i, delete that index from the permuted vector, and call the resulting n-vector $V_i^\pi$. For fixed i, $V_i^\pi$ is uniformly distributed over the permutations of $u^{\setminus i}$, counted by original indices even when observations repeat. Hence

$$
\mathbb E_{\pi,\xi}T(V_i^\pi;\xi)=T_0(u^{\setminus i}).
$$

For every pair i,j, Jensen gives

$$
|T_0(u^{\setminus i})-T_0(u^{\setminus j})|^s
\le
\mathbb E_{\pi,\xi}|T(V_i^\pi;\xi)-T(V_j^\pi;\xi)|^s.
$$

For each realized $\pi$, summing the right side over original indices i,j is exactly the sum over all deletion-position pairs for the data vector $u_\pi$. Thus

$$
\frac1{N^2}\sum_{i,j}
|T_0(u^{\setminus i})-T_0(u^{\setminus j})|^s
\le S_s(T)^s.
\tag{3.3}
$$

Taking the supremum proves $S_s(T_0)\le S_s(T)$.

For deterministic symmetric estimators, two deletion vectors differ, as multisets, by replacement of at most one observation. Symmetry therefore converts (1.2) into a bound on every deletion-pair difference, implying $S_s(T_0)\le S_{\mathrm{wc}}(T_0)$. Conversely $S_1(T)\le S_s(T)$ for every randomized T and finite s by the normalized $L^1$-$L^s$ inequality. Together with (3.2)–(3.3), these facts prove the minimax ordering (1.4).

The corresponding reduction to a deterministic estimator also shows that using an essential-supremum-in-seed version of (1.2) would give the same minimax value in the present bounded-target, squared-loss problems. No such identification of the original randomized estimator classes is needed.

## 4. The exact binary constraint and Bernstein derivative

A deterministic symmetric binary estimator is described by $a_0,\ldots,a_n$, with output $a_k$ when the data contain k ones. Consider an N-vector with k ones, $1\le k\le n$. Deleting a one produces $a_{k-1}$, and deleting a zero produces $a_k$. There are exactly $2k(N-k)$ ordered cross pairs and all other deletion-pair differences vanish. Consequently,

$$
S_1(T)\le\beta
\quad\Longleftrightarrow\quad
w_{n,k}|a_k-a_{k-1}|\le\beta
\quad(1\le k\le n),
\qquad
w_{n,k}=\frac{2k(n+1-k)}{(n+1)^2}.
\tag{4.1}
$$

More generally, $S_s(T)\le\beta$ is equivalent to
$w_{n,k}^{1/s}|a_k-a_{k-1}|\le\beta$.
Worst-case stability is equivalent to
$\max_k|a_k-a_{k-1}|\le\beta$.

Let

$$
m(p)=\mathbb E_p a_K
=\sum_{k=0}^n a_k\binom nk p^k(1-p)^{n-k},
\qquad K\sim{\mathrm{Bin}}(n,p).
$$

Differentiating this Bernstein polynomial and reindexing yields the exact identity

$$
m'(p)=
n\sum_{z=0}^{n-1}(a_{z+1}-a_z)
      \binom{n-1}z p^z(1-p)^{n-1-z}
=n\mathbb E(a_{Z+1}-a_Z),
\tag{4.2}
$$

where $Z\sim{\mathrm{Bin}}(n-1,p)$.
By (4.1),

$$
|m'(p)|
\le\frac{n\beta(n+1)^2}{2}
       \mathbb E\frac1{(Z+1)(n-Z)}.
\tag{4.3}
$$

The elementary identities

$$
\frac1{(z+1)(n-z)}
=\frac1{n+1}\left(\frac1{z+1}+\frac1{n-z}\right),
$$

$$
\mathbb E\frac1{Z+1}
=\frac{1-(1-p)^n}{np},\qquad
\mathbb E\frac1{n-Z}
=\frac{1-p^n}{n(1-p)}
$$

give the explicit derivative bound

$$
|m'(p)|
\le
\frac{\beta(n+1)}{2p(1-p)}
\left[1-p^{n+1}-(1-p)^{n+1}\right].
\tag{4.4}
$$

The binomial identities follow, for example, from
$\binom{n-1}z/(z+1)=\binom n{z+1}/n$
and the binomial theorem. They also hold for n=1.

On I, (4.4) implies

$$
\operatorname{Lip}_I(m)
\le\frac{\beta(n+1)}{2a(1-a)}
\le C_a n\beta.
\tag{4.5}
$$

If the worst risk of the estimator is R, Jensen gives

$$
|m(p)-f(p)|^2
\le\mathbb E_p|a_K-f(p)|^2\le R.
$$

Equations (4.5) and (2.2) yield
$R\ge E_{C_a n\beta}(f)^2$.
Section 3 makes this a lower bound for every randomized, potentially order-dependent average-stable estimator.

## 5. Uniform Lipschitz approximation preserving the original modulus

Let $\Pi_I$ be clamping onto I, and extend f to all of $\mathbb R$ by

$$
F(x)=f(\Pi_I x).
$$

Because clamping is 1-Lipschitz, F has exactly the modulus (2.1). Moreover,

$$
\sup_{x,y\in\mathbb R}
 \bigl(|F(x)-F(y)|-L|x-y|\bigr)_+
=
\sup_{x,y\in I}
 \bigl(|f(x)-f(y)|-L|x-y|\bigr)_+.
\tag{5.1}
$$

Indeed projection preserves the function values and can only decrease the distance; the reverse inequality follows by restricting x,y to I.

Put

$$
D_L=\frac12\sup_{x,y\in I}
          \bigl(|f(x)-f(y)|-L|x-y|\bigr)_+.
$$

Every L-Lipschitz g satisfies

$$
|f(x)-f(y)|
\le 2\|f-g\|_{\infty,I}+L|x-y|,
$$

so $E_L(f)\ge D_L$. For the reverse direction define the two envelopes

$$
U_L(x)=\sup_{y\in\mathbb R}\{F(y)-L|x-y|\},
\qquad
V_L(x)=\inf_{y\in\mathbb R}\{F(y)+L|x-y|\}.
\tag{5.2}
$$

They are finite since F is bounded, and both are L-Lipschitz. Also
$V_L\le F\le U_L$.
For any y,z, the triangle inequality and (5.1) give

$$
F(y)-F(z)-L(|x-y|+|x-z|)
\le |F(y)-F(z)|-L|y-z|
\le2D_L.
$$

Taking the supremum over y,z gives $U_L(x)-V_L(x)\le2D_L$. Therefore

$$
G_L(x)=\frac{U_L(x)+V_L(x)}2
\tag{5.3}
$$

is L-Lipschitz and obeys $\|G_L-F\|_{\infty,\mathbb R}\le D_L$. This proves the first equality of (2.6).

For the second equality, a pair at distance d contributes at most
$\omega_f(d)-Ld$. Conversely, for each t, compactness supplies a pair attaining $\omega_f(t)$, with distance d at most t, and that pair has excess at least $\omega_f(t)-Lt$.

The construction preserves the original modulus, not just a Lipschitz bound. Changing variables $y=z+h$ gives

$$
U_L(x+h)
=\sup_z\{F(z+h)-L|x-z|\}.
$$

Thus $|U_L(x+h)-U_L(x)|\le\omega_f(|h|)$. The same reasoning applies to $V_L$, and hence

$$
|G_L(x)-G_L(y)|\le\omega_f(|x-y|).
\tag{5.4}
$$

All statements include L=0, in which case the envelopes are the maximum and minimum of F and their midpoint is a constant.

## 6. Completing the Bernoulli theorem

### Statistical lower bound

Set $\delta=d_a/\sqrt n$. Choose p,q in I with $|p-q|\le\delta$ and
$|f(p)-f(q)|=\omega_f(\delta)$; existence follows from compactness and continuity. If this difference is zero, the asserted lower bound is immediate.

The elementary Bernoulli divergence bound

$$
{\mathrm{KL}}({\mathrm{Ber}}(p)\Vert{\mathrm{Ber}}(q))
\le\frac{(p-q)^2}{q(1-q)}
$$

follows from $\log t\le t-1$. Thus the divergence of the product distributions is at most $1/2$, and Pinsker's inequality bounds their total variation distance by $1/2$.

For any randomized estimator, form the test selecting the closer of the two target values. A test error entails squared estimation error at least
$|f(p)-f(q)|^2/4$. The sum of the two testing error probabilities is at least one minus total variation; including an independent common seed does not change this distance. It follows that the larger of the two squared risks is at least

$$
\frac{|f(p)-f(q)|^2}{8}(1-{\mathrm{TV}})
\ge\frac1{16}\omega_f(\delta)^2.
\tag{6.1}
$$

This also handles $\delta>|I|$, since the selected pair still has distance at most $\delta$.

### Stable upper bound

The modulus on an interval is subadditive. Indeed split a segment of length at most $t+u$ at a point leaving lengths at most t and u. In particular, for every $\delta>0$,

$$
\omega_f(t)\le(1+t/\delta)\omega_f(\delta).
\tag{6.2}
$$

Take $L=n\beta$, and define

$$
\widehat T(X)=G_L(\overline X).
\tag{6.3}
$$

A single binary replacement changes $\overline X$ by at most $1/n$, so (6.3) is deterministically worst-case $\beta$-stable on every binary data set.
For p in I, (5.3)–(5.4) imply

$$
|\widehat T-f(p)|
\le E_L(f)+\omega_f(|\overline X-p|).
$$

Using (6.2), Minkowski's inequality, and
$\mathbb E_p|\overline X-p|^2=p(1-p)/n\le1/(4n)$,

$$
\begin{split}
\left\{\mathbb E_p
 \omega_f(|\overline X-p|)^2\right\}^{1/2}
&\le
\left(1+\sqrt{n\mathbb E_p|\overline X-p|^2}\right)
\omega_f(1/\sqrt n)\\
&\le\frac32\omega_f(1/\sqrt n).
\end{split}
$$

This proves the nonconstant upper bound in (2.4). The midpoint of the target range is stable with budget zero and has risk at most
$\operatorname{osc}(f)^2/4$. Combining these facts with Sections 3–4 and (6.1) proves Theorem 2.1.

The same sandwich also holds if the model is enlarged to every distribution supported on $[0,1]$ whose mean lies in I, with target f of that mean and stability on all $[0,1]$-valued data sets. The lower bound restricts to Bernoulli laws, while the upper bound only uses the mean and the variance bound $1/4$.

## 7. Consequences for continuous non-Lipschitz targets

### Exact approximation calculation for a power cusp

Let $0<\alpha<1$, $b=1/2-a$, and
$f_\alpha(p)=|p-1/2|^\alpha$.
Then

$$
\omega_{f_\alpha}(t)=\min(t,b)^\alpha,
\qquad
2E_L(f_\alpha)=\max_{0\le h\le b}(h^\alpha-Lh).
\tag{7.1}
$$

The modulus follows from concavity and
$|x^\alpha-y^\alpha|\le|x-y|^\alpha$ for nonnegative x,y. For the approximation formula, any pair of radial distances can be replaced by two points on the same side of the cusp without increasing the distance; at fixed distance h, the largest increment of $t^\alpha$ occurs between 0 and h.

Elementary optimization gives

$$
E_L(f_\alpha)=
\begin{cases}
\frac12(b^\alpha-Lb),
 &0\le L\le\alpha b^{\alpha-1},\\[2mm]
\frac{1-\alpha}{2}
  \left(\frac{\alpha}{L}\right)^{\alpha/(1-\alpha)},
 &L\ge\alpha b^{\alpha-1}.
\end{cases}
\tag{7.2}
$$

The two formulas agree at the boundary. Hence, with constants depending only on a and $\alpha$, uniformly in n, $\beta$, and finite s,

$$
R^{\mathrm{av}}_{n,\beta}(f_\alpha;I)
\asymp R^s_{n,\beta}(f_\alpha;I)
\asymp R^{\mathrm{wc}}_{n,\beta}(f_\alpha;I)
\asymp
\min\left\{1,\,
n^{-\alpha}+(n\beta)^{-2\alpha/(1-\alpha)}
\right\}.
\tag{7.3}
$$

At $\beta=0$, the inverse power is interpreted as $+\infty$. The constant 1 can equivalently be replaced by a fixed positive scale depending on the target range.

There is a polynomially wide intermediate region:

$$
\begin{array}{c|c}
\text{budget scale}&\text{risk scale}\\ \hline
n\beta\lesssim1&1\\
1\ll n\beta\ll n^{(1-\alpha)/2}
 &(n\beta)^{-2\alpha/(1-\alpha)}\\
n\beta\gtrsim n^{(1-\alpha)/2}&n^{-\alpha}.
\end{array}
\tag{7.4}
$$

In particular the ordinary statistical rate is reached at
$\beta\asymp n^{-(1+\alpha)/2}$, whereas consistency begins when
$n\beta\to\infty$.

### A consistency criterion

For any fixed continuous f on I that is not Lipschitz with any finite constant, and any sequence $\beta_n\ge0$,

$$
R^{\mathrm{av}}_{n,\beta_n}(f;I)\longrightarrow0
\quad\Longleftrightarrow\quad n\beta_n\longrightarrow\infty.
\tag{7.5}
$$

The same equivalence holds for every finite s and for worst-case stability.

For sufficiency, continuous functions on a compact interval are uniformly approximated by piecewise linear functions, so $E_L(f)\to0$ as $L\to\infty$, while $\omega_f(1/\sqrt n)\to0$.
For necessity, if $n\beta_n$ fails to diverge then along a subsequence it is at most B. Formula (2.6) implies $E_{C_aB}(f)>0$, because $E_L(f)=0$ is equivalent to f being L-Lipschitz. The lower bound in (2.4) then stays positive on that subsequence.

The non-Lipschitz assumption is essential. A fixed L-Lipschitz f can be consistently estimated by $f(\Pi_I\overline X)$ with budget $L/n$, and constant f requires no positive budget.

## 8. Product-kernel reduction preserves deletion stability

This lemma will lift the Bernoulli lower bound to a nonparametric model.

Let $Q_0,Q_1$ be two fixed probability laws on a sample space $\mathcal X$, and define

$$
P_p=(1-p)Q_0+pQ_1.
$$

Let T be an estimator on $\mathcal X^n$, clipped to a bounded target interval if necessary. Define a deterministic estimator on binary vectors by

$$
A(b)=
\int_{\mathcal X^n}\mathbb E_\xi T(x;\xi)
\prod_{i=1}^n Q_{b_i}(dx_i).
\tag{8.1}
$$

If $B_i\sim{\mathrm{Ber}}(p)$, independently, and, conditionally on B, $X_i\sim Q_{B_i}$, independently, then the marginal observations are iid $P_p$. Conditional Jensen gives, for any target $\vartheta(p)$,

$$
\mathbb E_p|A(B)-\vartheta(p)|^2
\le
\mathbb E_{P_p,\xi}|T(X;\xi)-\vartheta(p)|^2.
\tag{8.2}
$$

For finite-s stability, fix a binary vector b of length N and draw N independent variables $X_i\sim Q_{b_i}$. Use this same N-vector and the same seed for every pair of deletions. For each i,

$$
\mathbb E_{X,\xi}T(X^{\setminus i};\xi)=A(b^{\setminus i}),
$$

because the remaining coordinates have the required product law. Therefore

$$
\begin{split}
\frac1{N^2}\sum_{i,j}
 |A(b^{\setminus i})-A(b^{\setminus j})|^s
&\le
\mathbb E_X\left[
\frac1{N^2}\sum_{i,j}
\mathbb E_\xi
|T(X^{\setminus i};\xi)-T(X^{\setminus j};\xi)|^s
\right]\\
&\le S_s(T)^s.
\end{split}
\tag{8.3}
$$

This proof preserves the exact normalization and needs no independence between the two deleted data sets.

For worst-case stability, couple the coordinates drawn under two neighboring binary vectors identically at all unchanged coordinates; use any joint draw at the single changed coordinate. The resulting $\mathcal X^n$-vectors are replacement neighbors for every draw. Applying Jensen with a shared seed shows $S_{\mathrm{wc}}(A)\le S_{\mathrm{wc}}(T)$.

Thus the transformation (8.1) preserves every relevant stability budget and weakly decreases risk. It works without assuming T symmetric. If a symmetric binary representative is desired, apply Section 3 afterward.

## 9. Metric Hölder smoothing with two simultaneous moduli

Let $(\mathcal Z,d)$ be a metric space and $\mathcal M\subseteq\mathcal Z$ a nonempty separable subset. Let
$\theta:\mathcal M\to\mathbb R$ satisfy

$$
|\theta(P)-\theta(Q)|\le H\,d(P,Q)^\alpha,
\qquad 0<\alpha<1,\quad H>0.
\tag{9.1}
$$

Choose a countable dense subset $(P_j)_{j\ge1}$ of $\mathcal M$. For L>0, put

$$
\psi_L(t)=\min\{Lt,Ht^\alpha\},\qquad t\ge0,
\tag{9.2}
$$

$$
\delta_L=
\sup_{t\ge0}(Ht^\alpha-Lt)_+
=(1-\alpha)\alpha^{\alpha/(1-\alpha)}
 H^{1/(1-\alpha)}L^{-\alpha/(1-\alpha)}.
\tag{9.3}
$$

Define

$$
S_L(z)=\inf_{j\ge1}
\{\theta(P_j)+\psi_L(d(z,P_j))\}.
\tag{9.4}
$$

### Lemma 9.1

The value in (9.4) is finite for every z, and

$$
|S_L(z)-S_L(z')|
\le \psi_L(d(z,z'))
\le \min\{L d(z,z'),H d(z,z')^\alpha\}.
\tag{9.5}
$$

For every $P\in\mathcal M$,

$$
\theta(P)-\delta_L\le S_L(P)\le\theta(P).
\tag{9.6}
$$

If $z\mapsto d(z,P_j)$ is measurable for each j, S_L is measurable.

#### Proof

The function $\psi_L$ is nondecreasing, concave, vanishes at zero, and is bounded above by Lt. One can check concavity explicitly: it is linear until
$t_0=(H/L)^{1/(1-\alpha)}$, then equals $Ht^\alpha$; the derivative drops from L to $\alpha L$ at the join and decreases thereafter.

Every nonnegative concave function vanishing at zero is subadditive. For x,y>0, apply concavity to x and y as fractions of x+y and add the resulting inequalities. Hence

$$
|\psi_L(u)-\psi_L(v)|\le\psi_L(|u-v|),
$$

which also shows that $\psi_L$ is L-Lipschitz.

For finiteness choose $P_0\in\mathcal M$. Hölder continuity, the triangle inequality, and subadditivity of $t^\alpha$ imply, for every j,

$$
\begin{split}
\theta(P_j)+\psi_L(d(z,P_j))
&\ge\theta(P_0)-H d(P_j,P_0)^\alpha
                         +\psi_L(d(z,P_j))\\
&\ge\theta(P_0)-H d(z,P_0)^\alpha-\delta_L.
\end{split}
$$

An upper finite value is supplied by any one index j.

By the triangle inequality and subadditivity of $\psi_L$, every term in (9.4) changes by at most $\psi_L(d(z,z'))$; taking infima in both directions proves (9.5).

For $P\in\mathcal M$, each term is at least

$$
\theta(P)-H d(P,P_j)^\alpha+\psi_L(d(P,P_j))
\ge\theta(P)-\delta_L.
$$

A sequence from the dense set approaching P has both
$\theta(P_j)\to\theta(P)$ and
$\psi_L(d(P,P_j))\to0$, proving the upper inequality in (9.6).
Measurability follows from a countable infimum. Finally, optimizing
$Ht^\alpha-Lt$ gives (9.3). This proves the lemma.

### Statistical consequence

Suppose a statistic $Z_n:\mathcal X^n\to\mathcal Z$ has deterministic replacement sensitivity at most $\rho_n$, and a model point P is represented in $\mathcal M$. If

$$
\sup_{P\in\mathcal M}
\mathbb E_P d(Z_n,P)^{2\alpha}\le v_n,
$$

then $S_L(Z_n)$ has worst-case stability at most $L\rho_n$ and worst squared risk at most

$$
(\delta_L+H\sqrt{v_n})^2.
\tag{9.7}
$$

If all targets lie in a closed interval, clipping the estimator to that interval preserves the stability and risk conclusions. The construction is an existence result; no claim of finite computational complexity for the countable infimum is made.

The ingredients are classical scalar metric-envelope constructions. The intended research contribution should be assessed in their statistical use together with a matching average-stability lower bound, not in claiming the envelope principle itself to be new.

## 10. Nonparametric median theorem

Fix $r>1$, put $\alpha=1/r$, and fix

$$
0 \lt c\le 2^{-r-1}.
\tag{10.1}
$$

Let $\mathcal F_{r,c}$ consist of all probability distributions P supported on $[-1,1]$ with continuous CDF $F_P$, a unique solution $q(P)$ to $F_P(q(P))=1/2$, called its median, and the inequalities

$$
\begin{cases}
F_P(x)\le \frac12-c(q(P)-x)^r,
   &-1\le x \lt q(P),\\
F_P(x)\ge \frac12+c(x-q(P))^r,
   &q(P) \lt x\le1.
\end{cases}
\tag{10.2}
$$

The domain restriction $x\in[-1,1]$ in (10.2) is essential: imposing these polynomial inequalities for all real x would make the class empty. Continuity and uniqueness imply $F_P(q(P))=1/2$ and $q(P)\in(-1,1)$.

The statistical target is q(P). Every stability constraint is imposed on all data vectors in $[-1,1]^n$.

### Theorem 10.1

There are constants $0 \lt c_1\le c_2<\infty$, depending only on r and c, such that, for every $n\ge1$, $\beta\ge0$, every $1\le s<\infty$, and also for weak worst-case stability,

$$
c_1\min\left\{1,\,
n^{-1/r}+(n\beta)^{-2/(r-1)}\right\}
\le
R^{s}_{n,\beta}(q;\mathcal F_{r,c})
\le
c_2\min\left\{1,\,
n^{-1/r}+(n\beta)^{-2/(r-1)}\right\}.
\tag{10.3}
$$

The same constants can be used for every s and for the worst-case endpoint. At $\beta=0$, interpret the inverse power as $+\infty$.

### 10.1 Median continuity in Kolmogorov distance

For $P,Q\in\mathcal F_{r,c}$, assume $q(P) \lt q(Q)$. By (10.2),

$$
F_P(q(Q))\ge\frac12+c(q(Q)-q(P))^r,
\qquad F_Q(q(Q))=\frac12.
$$

Thus, with $d_K(P,Q)=\|F_P-F_Q\|_\infty$,

$$
|q(P)-q(Q)|\le c^{-1/r} d_K(P,Q)^{1/r}.
\tag{10.4}
$$

The other order is identical. Hence the target is Hölder with
$H=c^{-\alpha}$.

### 10.2 Construction and measurability of a stable estimator

The continuous CDFs restricted to $[-1,1]$ form a subset of the separable metric space $C([-1,1])$ under the sup norm. Every subset of a separable metric space is separable, so fix a countable dense collection $(P_j)$ in $\mathcal F_{r,c}$. No density of the individual distributions with respect to Lebesgue measure is assumed.

Let $F_n$ be the empirical CDF. Regard it as an element of the ambient metric space of bounded functions on $[-1,1]$, equipped with the sup norm, even though it is not continuous. For $\beta>0$, choose $L=n\beta$ and define

$$
\widehat q_{L}(X)=
\Pi_{[-1,1]}
\inf_{j\ge1}
\left\{q(P_j)+
\min\left(
L\|F_n-F_{P_j}\|_\infty,\,
H\|F_n-F_{P_j}\|_\infty^\alpha
\right)\right\}.
\tag{10.5}
$$

For each fixed j,

$$
\|F_n-F_{P_j}\|_\infty
=\sup_{t\in\mathbb Q\cap[-1,1]}
 |F_n(t)-F_{P_j}(t)|.
\tag{10.6}
$$

To verify (10.6), use right-continuity to approach every $t<1$ from rational points to its right; the endpoint 1 is itself rational. Each quantity inside the countable supremum is measurable in the observations. Thus (10.5) is measurable by countable suprema, countable infimum, and continuous clipping.

A replacement changes the empirical CDF in sup norm by at most $1/n$, regardless of the data. Lemma 9.1 gives deterministic worst-case sensitivity at most $L/n=\beta$. Since the estimator is symmetric, it satisfies every finite-s stability definition at the same budget.

By (9.7),

$$
\sup_{P\in\mathcal F_{r,c}}
\left\{\mathbb E_P|\widehat q_L-q(P)|^2\right\}^{1/2}
\le
\delta_L+
H\sup_P
\left\{\mathbb E_P\|F_n-F_P\|_\infty^{2\alpha}\right\}^{1/2}.
\tag{10.7}
$$

We use the following elementary empirical-CDF moment bound. It is weaker in constants than the classical exponential inequality, but its short proof supplies everything needed here.

**Lemma 10.2 (empirical-CDF moment).** For any real-valued iid sample, with CDF $F$ and empirical CDF $F_n$,

$$
\mathbb E\|F_n-F\|_\infty^2\le\frac{16}{n},
\qquad
\mathbb E\|F_n-F\|_\infty^{2\alpha}
\le (16/n)^\alpha,\quad 0<\alpha<1.
\tag{10.8}
$$

**Proof.** All suprema can be taken over rational thresholds by right-continuity, so they are measurable. Let $F'_n$ be an independent empirical CDF. Conditional expectation and Jensen give

$$
\mathbb E\|F_n-F\|_\infty^2
\le \mathbb E\|F_n-F'_n\|_\infty^2.
$$

Introduce independent signs $\epsilon_i\in\{-1,1\}$ with equal probabilities. Exchanging the two observations in each pair shows that the difference process has the same law after multiplying each pair by its sign. The triangle inequality and $(a+b)^2\le2a^2+2b^2$ yield

$$
\mathbb E\|F_n-F'_n\|_\infty^2
\le \frac4{n^2}\mathbb E\sup_x
\left|\sum_{i=1}^n\epsilon_i\mathbf1_{\{X_i\le x\}}\right|^2.
$$

Condition on the observations and sort them, breaking ties by their indices. Every threshold sum is a prefix sum of the signs in this order; with ties only some prefixes occur. Its supremum is at most $M=\max_{0\le k\le n}|S_k|$, where $S_k$ is a simple symmetric random walk. For completeness, the $L^2$ maximal bound follows by partitioning $\{M\ge\lambda\}$ according to the first crossing time and using $\mathbb E(|S_n|\mid S_0,\ldots,S_k)\ge|S_k|$. This gives

$$
\lambda\Pr(M\ge\lambda)
\le\mathbb E\bigl[|S_n|\mathbf1_{\{M\ge\lambda\}}\bigr].
$$

Integrating with respect to $2\,d\lambda$, then applying Cauchy–Schwarz, gives
$\mathbb E M^2\le2\mathbb E(|S_n|M)
\le2\sqrt{\mathbb E S_n^2\,\mathbb E M^2}$.
Since $M\le n$ and $\mathbb E S_n^2=n$, it follows that $\mathbb E M^2\le4n$. Combining the inequalities proves the first assertion. Jensen applied to the concave function $u^\alpha$ proves the second. This argument is a classical symmetrization and maximal-inequality argument, not an additional novelty claim.

Equations (9.3), (10.7), and (10.8) imply

$$
\sup_P\mathbb E_P|\widehat q_L-q(P)|^2
\le C_{r,c}
\{n^{-\alpha}+(n\beta)^{-2\alpha/(1-\alpha)}\}.
\tag{10.9}
$$

The zero estimator has risk at most 1 and budget zero. Taking the better of this estimator and (10.5) proves the upper bound in (10.3), including $\beta=0$.

### 10.3 A two-piece mixture submodel

For $p\in[1/4,3/4]$, let $P_p$ have density

$$
f_p(x)=
\begin{cases}
rp\,|x|^{r-1},&-1\le x<0,\\
r(1-p)\,x^{r-1},&0 \lt x\le1.
\end{cases}
\tag{10.10}
$$

The value assigned to the density at zero is immaterial. The negative and positive half-intervals have masses p and $1-p$. The CDF is continuous and strictly increasing, and its unique median is

$$
q(p)=
-\operatorname{sgn}(p-1/2)
\left(\frac{2|p-1/2|}{1+2|p-1/2|}\right)^\alpha,
\qquad q(1/2)=0.
\tag{10.11}
$$

For example, when $p>1/2$, solving
$p(1-|q|^r)=1/2$ proves (10.11).

We next verify the whole margin class condition, rather than only a local expansion at zero. Since $p,1-p\ge1/4$,

$$
f_p(x)\ge(r/4)|x|^{r-1}.
$$

For an interval J of length h inside $[-1,1]$, the integral of
$|x|^{r-1}$ is minimized by the centered interval
$[-h/2,h/2]$. One direct proof differentiates the integral over
$[a,a+h]$ with respect to a, obtaining
$|a+h|^{r-1}-|a|^{r-1}$, which changes sign from negative to positive at $a=-h/2$. Thus

$$
P_p(J)\ge
\frac r4\frac{2(h/2)^r}{r}
=2^{-r-1}h^r.
\tag{10.12}
$$

Applying (10.12) to the interval between x and $q(p)$ proves (10.2) for every $c\le2^{-r-1}$. Therefore the entire mixture submodel lies in $\mathcal F_{r,c}$.

Conditionally on the sign, the magnitude has density $r u^{r-1}$ on $[0,1]$, independent of p. Consequently (10.10) is the fixed product-kernel image of a Bernoulli experiment, with a one denoting a negative observation. Section 8 shows that every stable estimator of the median induces, at no larger risk and exactly the same stability budget, a Bernoulli estimator of the scalar target (10.11).

### 10.4 Quantitative lower bound on the submodel

Apply Theorem 2.1 on $I=[1/4,3/4]$, so $C_a=16/3$. For $0\le h\le1/4$,

$$
|q(1/2+h)-q(1/2)|
=\left(\frac{2h}{1+2h}\right)^\alpha
\ge k_\alpha h^\alpha,
\qquad k_\alpha=(4/3)^\alpha.
\tag{10.13}
$$

Taking $h=1/(4\sqrt n)$, which is at most
$d_{1/4}/\sqrt n=\sqrt{3/32}/\sqrt n$, gives

$$
\frac1{16}\omega_q(d_{1/4}/\sqrt n)^2
\ge\frac{3^{-2\alpha}}{16}n^{-\alpha}.
\tag{10.14}
$$

For any L>0, (2.6) and (10.13) give

$$
2E_L(q)
\ge\sup_{0\le h\le1/4}
          (k_\alpha h^\alpha-Lh)_+.
$$

Choose

$$
h_L=
\min\left\{\frac14,
\left(\frac{k_\alpha}{2L}\right)^{1/(1-\alpha)}
\right\}.
$$

Then $Lh_L\le(k_\alpha/2)h_L^\alpha$, and hence

$$
E_L(q)\ge(k_\alpha/4)h_L^\alpha
\ge c_\alpha\min\{1,L^{-\alpha/(1-\alpha)}\}.
\tag{10.15}
$$

At L=0 the same conclusion, with the usual inverse-power convention, follows by taking $h=1/4$.

Combining (10.14)–(10.15), Theorem 2.1, and the product-kernel reduction yields

$$
R^{\mathrm{av}}_{n,\beta}(q;\mathcal F_{r,c})
\ge c'_\alpha
\max\left\{
n^{-\alpha},
\min\{1,(n\beta)^{-2\alpha/(1-\alpha)}\}
\right\}.
\tag{10.16}
$$

For $0\le A\le1$ and $B\ge0$,
$\max\{A,\min(1,B)\}\ge\frac12\min(1,A+B)$.
Taking $A=n^{-\alpha}$ gives the asserted lower bound for average stability. Section 3 supplies the bound for every finite s and for weak worst-case stability. Together with (10.9), this proves Theorem 10.1.

### 10.5 Interpretation and exact range of claims

The theorem determines rates up to constants depending on r and c; it does not determine a leading asymptotic minimax constant.

For each fixed $r>1$, the risk is bounded away from zero when $n\beta$ stays bounded, decreases as $(n\beta)^{-2/(r-1)}$ in the intermediate regime, and reaches the ordinary rate $n^{-1/r}$ once

$$
\beta\gtrsim n^{-(r+1)/(2r)}.
$$

For $1\ll n\beta\ll n^{(r-1)/(2r)}$, the intermediate risk tends to zero but is asymptotically larger than the unconstrained rate. This is a polynomially wide, gradual phase transition even under average-case stability, and its rate is shared by all the finite-s constraints and the weak worst-case endpoint. Consistency is equivalent to $n\beta_n\to\infty$.

More explicitly, put $\beta_n=n^{-\gamma}$ and $\gamma_0=(r+1)/(2r)$. The theorem gives the risk exponent

$$
R_{n,\beta_n}\asymp n^{-e_r(\gamma)},\qquad
e_r(\gamma)=\begin{cases}
1/r,&\gamma\le\gamma_0,\\
2(1-\gamma)/(r-1),&\gamma_0<\gamma<1,\\
0,&\gamma\ge1.
\end{cases}
\tag{10.17}
$$

This also verifies the gradual-transition interpretation under the two-regime definition of [1]. Choose two distinct fixed exponents strictly between $\gamma_0$ and 1. Both associated risks tend to zero and are larger than $n^{-1/r}$ by a polynomial factor. Neither budget can eventually lie well below or well above a proposed sharp threshold, even allowing any fixed powers of $\log n$. Yet their ratio is a nonzero power of $n$, so they cannot both stay within such a logarithmic window. If a proposed threshold oscillates, the same argument applies on a subsequence. Thus no single sharp threshold up to polylogarithmic factors describes this family.

The class includes distributions with ordinary positive density at their median as well as the least-favorable flat-median mixtures. Its worst-case behavior is governed by the latter. No assertion is made about adaptation to an unknown r or c, confidence intervals, exact constants, or the computational implementation of the countable-envelope estimator.

## 11. Prior work, verified sources, and novelty boundaries

The literature check is bounded by the sources and search record accompanying this manuscript, as of 26 November 2026. It is not a worldwide priority certificate.

**Direct stability comparison.** Chakraborty, Luo and Barber [1] formulate stability-constrained minimax estimation. Their Theorem 1 already implies a worst-case Bernoulli approximation obstruction; we do not claim that specialization as new. Their refined mixture-path average-stability bound in Theorem 2 assumes a linear target. Equation (4.4) here instead controls the local mean-response derivative for every continuous nonlinear target, without imposing linearity. Theorem 10.1 combines this lower bound with a measurable upper construction on a whole nonparametric median class. The source's v2 explicitly limits its sharp-transition summaries to a two-regime statement; our conclusion concerns its separately stated existence question.

**Statistical moduli and constrained minimax geometry.** Donoho and Liu [4] provide classical statistical-modulus background. Rohde and Steinberger [2], especially Corollaries 4.3 and 4.5 in their author manuscript, characterize locally private estimation through a total-variation modulus and construct attainable procedures under their stated model and functional conditions. Their constraint is local differential privacy, which compares distributions of privatized outputs. The present constraint controls changes using a common random seed. Neither theorem is asserted to imply or dominate the other. Their scope across functional models is broader; the contribution here is a distinct stability obstruction and a complete nonregular-median risk curve.

**Median extension precedent.** Tzamos, Vlatakis-Gkaragkounis and Zadik [3] obtain nearly tight private median rates and an efficient procedure under a positive-density assumption near the median. They already use an extension argument from typical samples. Our class instead includes medians with vanishing density, and our budget is the same-seed stability parameter rather than a differential-privacy parameter. We do not claim that using an extension to estimate a median is new, and we make no efficiency claim for (10.5).

**Later ensembling work.** Barber and Samworth [5] give general stability guarantees through a covariance operator associated with an averaging scheme. Their framework is broader as a stability construction, but it does not determine the nonregular-median minimax risk or remove the accuracy cost quantified here. We do not claim averaging or conditioning as a new principle.

**Approximation precedent.** The uniform approximation formula and the power-law error of Lipschitz approximation are classical approximation-theory ingredients; see [6] for a direct study of moduli and Lipschitz approximation, and [7] for the foundational scalar extension method. Section 5 supplies the needed short proof rather than treating the formula as an original contribution.

**Claim boundaries.** The candidate new contribution is the complete risk law (10.3), supported by the general average-stability approximation obstruction and its precise treatment of randomization, ordering, and conditional sampling. The envelope formula, Bernstein differentiation, testing inequalities, and empirical-process moment proof are supplied as proof ingredients. No assertion is made about unknown-margin adaptation, unbounded support, all possible quantiles, multivariate medians, confidence intervals, exact leading constants, or the behavior of the classes as $r\downarrow1$ or $c\downarrow0$.

## References

1. Abhinav Chakraborty, Yuetian Luo, and Rina Foygel Barber (2026). *Stability and Accuracy Trade-offs in Statistical Estimation*. arXiv:2601.11701v2, revised 22 August 2026. [Versioned full text](https://arxiv.org/html/2601.11701v2). Sections 2–3 and 8.3 were checked in the current version.
2. Angelika Rohde and Lukas Steinberger (2020). *Geometrizing rates of convergence under local differential privacy constraints*. **The Annals of Statistics** 48(5), 2646–2670. [DOI:10.1214/19-AOS1901](https://doi.org/10.1214/19-AOS1901). [Complete author manuscript, v2](https://arxiv.org/html/1805.01422v2); [institutional publication record](https://ucrisportal.univie.ac.at/en/publications/geometrizing-rates-of-convergence-under-local-differential-privac/). Technical comparisons use the author manuscript; journal metadata are independently verified.
3. Christos Tzamos, Emmanouil-Vasileios Vlatakis-Gkaragkounis, and Ilias Zadik (2020). *Optimal Private Median Estimation under Minimal Distributional Assumptions*. **Advances in Neural Information Processing Systems 33**. [Official proceedings](https://papers.nips.cc/paper/2020/hash/21d144c75af2c3a1cb90441bbb7d8b40-Abstract.html); [author manuscript](https://arxiv.org/html/2011.06202v1). Assumption 1.2, Theorem 3.1, and the extension construction are the relevant comparisons.
4. David L. Donoho and Richard C. Liu (1991). *Geometrizing Rates of Convergence, II*. **The Annals of Statistics** 19(2), 633–667. [DOI:10.1214/aos/1176348114](https://doi.org/10.1214/aos/1176348114). Classical background; no originality claim relies on attributing an unverified theorem beyond the statistical-modulus framework to this source.

5. Rina Foygel Barber and Richard J. Samworth (2026). *Algorithmic stability via ensembling*. arXiv:2609.10428v1, 9 September 2026. [Versioned full text](https://arxiv.org/html/2609.10428v1). The stability construction and the discussion of accuracy were checked.
6. Luofei Liu and Yan Jiang (2018). *Modulus of continuity and Lipschitz approximation*. **Journal of Mathematical Analysis and Applications** 460(1), 239–251. [DOI:10.1016/j.jmaa.2017.11.029](https://doi.org/10.1016/j.jmaa.2017.11.029). The available publisher abstract establishes the approximation-theory scope; no uninspected theorem numbering is used.
7. E. J. McShane (1934). *Extension of range of functions*. **Bulletin of the American Mathematical Society** 40, 837–842. [DOI:10.1090/S0002-9904-1934-05978-0](https://doi.org/10.1090/S0002-9904-1934-05978-0). Classical extension background.

## Appendix A. Finite verification and the meaning of the endpoint

The proof is analytic. Supplementary exact arithmetic checks verify 5,050 binomial coefficient identities used in (4.4), and 1,524 exhaustive binary deletion-power identities for $n\le7$ and powers 1, 2, 3. The separate grid experiment solves 30 finite-constraint convex programs; these are numerical diagnostics, not continuum minimax proofs.

The distinction between ordering and replacement is substantive. On binary data with $n=4$, the estimator
$T(x)=\beta(x_1-x_2+x_3-x_4)$ has replacement sensitivity $\beta$. Deleting one entry of $(0,1,0,1,0)$ yields outputs $(2\beta,\beta,0,-\beta,-2\beta)$, whose average pairwise absolute difference is $8\beta/5$. Thus replacement stability of an order-dependent estimator need not imply its deletion-average stability. Section 3 proves the needed comparison of minimax values by an explicit symmetrization, rather than by an invalid inclusion of estimator classes.

The finite-power definition (1.1) includes a power inside the seed expectation. In contrast, (1.2) uses the expectation of the absolute difference. These are kept as separate definitions; an expected worst-case constraint is not described as the literal limit of the finite-power constraints for an arbitrary randomized procedure. In the bounded-target squared-loss problems here, eliminating randomization and ordering makes the minimax endpoint comparison valid.

## Appendix B. An exact two-observation certificate

As an independent check of the stability normalization, take $I=[1/4,3/4]$, $f(p)=|p-1/2|^{1/2}$, $n=2$, and average budget $\beta=1/45$. The exact minimax estimator has count values

$$
(a_0,a_1,a_2)=\left(\frac{859}{3160},\frac{701}{3160},\frac{859}{3160}\right),
\qquad R=\frac{614641}{9985600}.
\tag{B.1}
$$

To verify this, first apply Section 3 and average with the transformation $k\mapsto2-k$. Both the target and the parameter interval are invariant under reflection, so this further averaging cannot increase the worst risk or stability. Write the resulting array as $(a,b,a)$, put $s=(a+b)/2$ and $d=a-b$. The stability constraint is $|d|\le1/20$. At $p=1/2$ and $p=1/4$, respectively, the two risks are

$$
R_0=s^2+d^2/4,\qquad
R_1=(s-1/2)^2+d(s-1/2)/4+d^2/4.
$$

At $s=39/158,d=1/20$ they equal the value in (B.1). The epigraph minimization of their maximum over $|d|\le1/20$ is a convex problem. Its exact dual weights on the two risks are $3121/6241$ and $3120/6241$, and the multiplier on $d\le1/20$ is $130961/19721560$. They are nonnegative, sum correctly, and satisfy

$$
2s-\frac{3120}{6241}(1-d/4)=0,\qquad
d/2+\frac{3120}{6241}(s-1/2)/4
+\frac{130961}{19721560}=0.
$$

These equalities give a global lower certificate for the endpoint problem. To see that the candidate also controls the continuum, set $u=|p-1/2|$. The risk is

$$
\mathcal R(u)=(1/2+2u^2)(a-\sqrt u)^2
             +(1/2-2u^2)(b-\sqrt u)^2.
$$

For $0 \lt u\le1/4$, its second derivative is
$4d(a+b)+(a+b)/(4u^{3/2})-15d\sqrt u$.
This is at least $4s-(15/2)d>0$ for the stated positive $s,d$. The continuous extension to $u=0$ is convex, so its maximum on $[0,1/4]$ is at an endpoint. The two endpoint values agree. This proves (B.1), independently of the numerical grids. The accompanying script checks the rational equalities exactly; the displayed convexity argument supplies the continuum part.
