# The sharp marginal-cap correlation gap for nonnegative submodular functions

## 1. Abstract

Let $f$ be a nonnegative submodular set function, let $F$ be its multilinear extension, and let $f^+$ be its concave closure, defined using distributions with exactly the prescribed marginals. We prove that, whenever $0\le x_i\le p<1$,

$$
F(x)\ge
\bigl(1-e^{-(1-p)}\bigr)f^+(x)
+(1-p)e^{-(1-p)}f(\varnothing).
$$

In particular, for normalized functions and every fixed $0<p<1$, the infimum of $F(x)/f^+(x)$ over all finite ground sets and marginal vectors with maximum coordinate at most $p$ is exactly $1-e^{-(1-p)}$. The same value holds when the maximum coordinate is required to equal $p$. Sharpness follows from the construction of Chekuri and Livanos [CL24], interpreted as a sequence of finite instances approaching the infimum. The universal inequality follows from an exponential interpolation, a differential inequality, and an independent completion that restores the prescribed marginals exactly. The proof is self-contained. It resolves the exact parameter question stated in [CL24], subject to the limitations of the literature comparison; it makes no claim of external peer review or an exhaustive priority determination.

## 2. Source problem and contribution

For a fixed marginal vector, independence may reduce the expected value of a submodular objective relative to an optimally correlated distribution. The ratio convention in this paper is the independent value divided by the optimal correlated value. Chekuri and Livanos [CL24, Theorem 1] establish the universal coefficient

$$
(1-p)(1-e^{-1}),\qquad p=\max_i x_i,
$$

for nonnegative submodular functions, while their Theorem 11 supplies an asymptotic obstruction with coefficient $1-e^{-(1-p)}$. Their discussion after Theorem 1 and their conclusion explicitly ask for the exact dependence on $p$.

The contribution here is the matching universal inequality at the prescribed vector $x$. We also retain a nonnegative term involving $f(\varnothing)$, so normalization is unnecessary for the main inequality. The sharpness example is from [CL24]; it is not a new construction of this work.

Several ingredients are established tools. Random-set addition bounds already appear in Buchbinder, Feldman, Naor, and Schwartz [BFNS14]. Differential inequalities for multilinear extensions appear in the correlation-gap and contention-resolution literature [CVZ14]. We give the two elementary facts used below with proofs. The specific step that closes the argument is an exact independent completion of the interpolation endpoint, with a loss factor that cancels the denominator in the differential-inequality estimate.

The distinction between the interpolation endpoint and the target vector is essential. For a nonmonotone function, increasing coordinates of the multilinear extension need not increase its value. Consequently, a lower bound at an auxiliary vector below $x$ cannot be transferred to $F(x)$ by monotonicity.

## 3. Definitions and multilinear calculus

Let $N$ be a finite nonempty set. A function $f:2^N\to[0,\infty)$ is submodular if

$$
f(A)+f(B)\ge f(A\cup B)+f(A\cap B)
\qquad\text{for all }A,B\subseteq N.
\tag{1}
$$

Equivalently, its marginal values satisfy diminishing returns:

$$
f(A\cup\{i\})-f(A)
\ge f(B\cup\{i\})-f(B)
\qquad
(A\subseteq B,\ i\notin B).
\tag{2}
$$

We do not assume monotonicity. A function is normalized if $f(\varnothing)=0$.

For $z\in[0,1]^N$, let $R(z)$ include each element $i$ independently with probability $z_i$. The multilinear extension is

$$
F(z)=\mathbb E[f(R(z))]
=\sum_{A\subseteq N}f(A)
  \prod_{i\in A}z_i
  \prod_{i\notin A}(1-z_i).
\tag{3}
$$

The concave closure is

$$
f^+(x)=
\max\left\{
\sum_{A\subseteq N}\lambda_A f(A):
\begin{array}{l}
\lambda_A\ge0,\quad \sum_{A\subseteq N}\lambda_A=1,\\[2pt]
\sum_{A\ni i}\lambda_A=x_i\quad(i\in N)
\end{array}
\right\}.
\tag{4}
$$

Thus $f^+(x)$ is the maximum of $\mathbb E f(S)$ over all random sets $S$ whose marginals are exactly $x$. The feasible set in (4) is nonempty because it contains the product distribution. It is a closed subset of a finite-dimensional probability simplex, hence compact; the maximum is attained. In particular, no limiting argument is needed to select an optimizing correlated law.

For a set $S$, write $\mathbf 1_S$ for its incidence vector, and use $\vee$ for coordinatewise maximum. Because $F$ is multilinear,

$$
\partial_{ii}F(z)=0.
\tag{5}
$$

For distinct $i,j$, its mixed derivative is an expectation of discrete second differences:

$$
\partial_{ij}F(z)=
\mathbb E\left[
 f(T\cup\{i,j\})-f(T\cup\{i\})
 -f(T\cup\{j\})+f(T)
\right]\le0,
\tag{6}
$$

where $T$ is sampled independently on $N\setminus\{i,j\}$ with the corresponding coordinates of $z$. Equation (6) follows from submodularity. The first derivative $\partial_iF$ may be negative, but it cannot increase when any other coordinate increases. All derivatives are derivatives of a finite polynomial, so these assertions also hold at the boundary by continuity.

## 4. Main theorem

**Theorem 1 (universal marginal-cap bound).** Let $f:2^N\to[0,\infty)$ be submodular, let $0\le p<1$, and let $x\in[0,p]^N$. Then

$$
\boxed{
F(x)\ge
\bigl(1-e^{-(1-p)}\bigr)f^+(x)
+(1-p)e^{-(1-p)}f(\varnothing).
}
\tag{7}
$$

The inequality is valid without normalization and without positivity of $f^+(x)$. At $p=1$, its continuous extension is the elementary inequality $F(x)\ge0$.

For the sharpness statement, define for $0<p\le1$

$$
\Gamma_{\le}(p)=
\inf
\left\{
\frac{F(x)}{f^+(x)}:
\begin{array}{l}
N\text{ finite and nonempty},\\
f:2^N\to[0,\infty)\text{ submodular},\\
f(\varnothing)=0,\quad f^+(x)>0,\\
x\in[0,1]^N,\quad \max_i x_i\le p
\end{array}
\right\}.
\tag{8}
$$

Let $\Gamma_{=}(p)$ be the same infimum with $\max_i x_i=p$.

**Theorem 2 (sharp constant).** For every $0<p<1$,

$$
\Gamma_{\le}(p)=\Gamma_{=}(p)=1-e^{-(1-p)}.
\tag{9}
$$

Both infima allow the size of the finite ground set to grow. Equation (9) is not a claim that a particular finite dimension attains the limiting value.

Removing the normalization condition $f(\varnothing)=0$ leaves both infima unchanged. Indeed, Theorem 1 gives the same lower coefficient for every nonnegative submodular function, and the normalized subclass already supplies the matching examples. Thus the cap and exact-maximum versions each have the same sharp value in both the normalized and the unnormalized classes.

## 5. Two elementary lemmas

### 5.1. Independent random additions

The following lemma is the independent-input special case of the stronger random-set lemma of [BFNS14, Lemma 2.2], also restated in [CL24, Lemma 1].

**Lemma 3.** Suppose $g:2^N\to[0,\infty)$ is submodular and $z\in[0,a]^N$ for some $a\in[0,1]$. Then

$$
\mathbb E[g(R(z))]\ge(1-a)g(\varnothing).
\tag{10}
$$

**Proof.** When $a=0$, the sampled set is empty and the conclusion is equality. Suppose $a>0$, set $v=z/a$, and let $G$ denote the multilinear extension of $g$. Define

$$
\phi(t)=G(tv),\qquad 0\le t\le1.
$$

Since $v\in[0,1]^N$, the entire segment lies in the domain of $G$. Equations (5)–(6), applied to $G$, give

$$
\phi''(t)
=\sum_{i,j\in N}v_i v_j\,\partial_{ij}G(tv)
\le0.
$$

Thus $\phi$ is concave. Using $z=av$ and the nonnegativity of $G$,

$$
G(z)=\phi(a)
\ge(1-a)\phi(0)+a\phi(1)
\ge(1-a)g(\varnothing).
$$

This is (10). $\square$

The nonnegativity assumption is used in the final inequality. It must be retained when applying the lemma to translated functions such as $A\mapsto f(S\cup A)$. Such translations are nonnegative and submodular whenever $f$ is.

### 5.2. Increasing-coordinate tangent bound

**Lemma 4.** For every $z\in[0,1]^N$ and every $S\subseteq N$,

$$
F(z\vee\mathbf1_S)-F(z)
\le\sum_{i\in S}(1-z_i)\partial_iF(z).
\tag{11}
$$

**Proof.** List $S$ in any fixed order and raise its coordinates to one successively. At the step for coordinate $i$, multilinearity makes the increment exactly

$$
(1-z_i)\partial_iF(z^{\mathrm{prev}}),
$$

where $z^{\mathrm{prev}}$ is the vector after the preceding increases. Because $z^{\mathrm{prev}}\ge z$ and only coordinates different from $i$ have changed, (6) gives

$$
\partial_iF(z^{\mathrm{prev}})\le\partial_iF(z).
$$

Multiplication by the nonnegative number $1-z_i$ preserves the inequality. Summing the increments proves (11). The argument remains valid when first derivatives or increments are negative. $\square$

## 6. Proof of the universal inequality

Fix $p<1$ and $x\in[0,p]^N$. Let $S$ have an optimizing law in (4), and put

$$
C=f^+(x)=\mathbb E[f(S)].
$$

In particular, $\Pr(i\in S)=x_i$ for each $i$.

### 6.1. Exponential interpolation

Consider the path

$$
y_i(t)=1-e^{-t x_i},
\qquad
h(t)=F(y(t)),
\qquad 0\le t\le1.
\tag{12}
$$

The chain rule gives

$$
h'(t)=
\sum_{i\in N}x_i(1-y_i(t))\partial_iF(y(t)).
\tag{13}
$$

Apply Lemma 4 with $z=y(t)$ and then average over the correlated set $S$. Its exact marginals imply

$$
\begin{aligned}
\mathbb E_S\!\left[
F(y(t)\vee\mathbf1_S)-F(y(t))
\right]
&\le
\mathbb E_S\left[
\sum_{i\in S}(1-y_i(t))\partial_iF(y(t))
\right]\\
&=
\sum_{i\in N}x_i(1-y_i(t))\partial_iF(y(t))\\
&=h'(t).
\end{aligned}
\tag{14}
$$

No independence among the elements of $S$ is used here.

For any fixed realization of $S$, the function $g_S(A)=f(S\cup A)$ is nonnegative and submodular. Moreover,

$$
y_i(t)\le1-e^{-pt}.
$$

Lemma 3, with $a=1-e^{-pt}$, therefore yields

$$
F(y(t)\vee\mathbf1_S)
=\mathbb E[f(S\cup R(y(t)))]
\ge e^{-pt}f(S).
\tag{15}
$$

Averaging (15) and substituting into (14) gives

$$
h'(t)+h(t)\ge e^{-pt}C.
\tag{16}
$$

Multiply by $e^t$ and integrate over $[0,1]$. Since $h(0)=f(\varnothing)$,

$$
e\,h(1)-f(\varnothing)
\ge C\int_0^1 e^{(1-p)t}\,dt
=C\,\frac{e^{1-p}-1}{1-p}.
$$

Equivalently,

$$
h(1)\ge
e^{-1}f(\varnothing)
+\frac{e^{-p}-e^{-1}}{1-p}\,C.
\tag{17}
$$

This controls the intermediate vector $y(1)$, rather than $x$. Indeed, $1-e^{-x_i}\le x_i$, but monotonicity of $F$ is unavailable. The next step accounts explicitly for the change in marginals.

### 6.2. Exact completion of the marginals

Define

$$
r_i=1-(1-x_i)e^{x_i}.
\tag{18}
$$

The function $q(u)=(1-u)e^u$ satisfies $q(0)=1$ and

$$
q'(u)=-ue^u\le0
\qquad(0\le u\le1).
$$

Consequently, for $0\le x_i\le p<1$,

$$
0\le r_i\le1-(1-p)e^p<1.
\tag{19}
$$

Sample $A\sim R(y(1))$ and $B\sim R(r)$ independently, with independent coordinate choices in each set. For every $i$,

$$
\begin{aligned}
\Pr(i\notin A\cup B)
&=(1-y_i(1))(1-r_i)\\
&=e^{-x_i}(1-x_i)e^{x_i}\\
&=1-x_i.
\end{aligned}
\tag{20}
$$

The coordinate pairs $(\mathbf1_{\{i\in A\}},\mathbf1_{\{i\in B\}})$ are independent across $i$, so their unions are also independent across $i$. It follows that $A\cup B$ has exactly the law $R(x)$, not merely the same first moments.

Conditional on any fixed set $A$, apply Lemma 3 to the function $T\mapsto f(A\cup T)$ and to the independent set $B$. By (19),

$$
\mathbb E_B[f(A\cup B)\mid A]\ge(1-p)e^p f(A).
\tag{21}
$$

Taking expectation in (21) and using (20) gives

$$
F(x)\ge(1-p)e^p F(y(1))
=(1-p)e^p h(1).
\tag{22}
$$

### 6.3. Cancellation of the interpolation loss

The factor in (22) is positive. Multiplying (17) by it, we obtain

$$
\begin{aligned}
F(x)
&\ge
(1-p)e^{p-1}f(\varnothing)
+(1-p)e^p
\frac{e^{-p}-e^{-1}}{1-p}\,C\\
&=
(1-p)e^{p-1}f(\varnothing)
+(1-e^{p-1})C.
\end{aligned}
$$

Since $e^{p-1}=e^{-(1-p)}$ and $C=f^+(x)$, this is precisely (7). $\square$

The two applications of Lemma 3 have different roles. The first bounds the loss incurred when the interpolation is united with a correlated comparison set. The second bounds the loss incurred when the interpolation endpoint is completed to the target product law. Using the same parameter $p$ in both places produces the cancellation in the last display.

## 7. Sharpness over all finite ground sets

We reproduce the obstruction from [CL24, Appendix A.2], with explicit finite-size quantifiers.

Fix $p\in(0,1)$. For any positive integer

$$
m\ge\frac{1-p}{p},
$$

let

$$
N=\{b,u_1,\ldots,u_m\},\qquad
x_b=p,\qquad
x_{u_j}=\frac{1-p}{m}.
\tag{23}
$$

The maximum coordinate is exactly $p$. Define

$$
f(T)=
\begin{cases}
1,&b\notin T\text{ and }T\cap\{u_1,\ldots,u_m\}\ne\varnothing,\\
0,&\text{otherwise}.
\end{cases}
\tag{24}
$$

The function is nonnegative and normalized. To check submodularity, consider marginal values. Adding a positive element $u_j$ has marginal value one exactly when the current set contains neither $b$ nor any positive element; otherwise its marginal value is zero. This marginal cannot increase as the current set grows. Adding $b$ has marginal value zero when no positive element is present and minus one otherwise. That marginal also cannot increase. Thus (2) holds for every element.

For every law with marginals (23),

$$
f(T)\le\mathbf1_{\{b\notin T\}},
$$

and hence its expected value is at most $1-p$. This upper bound is attained by the law that chooses the singleton $\{b\}$ with probability $p$ and each singleton $\{u_j\}$ with probability $(1-p)/m$. Therefore,

$$
f^+(x)=1-p>0.
\tag{25}
$$

Under independent sampling, $b$ must be absent and at least one positive element must be present, giving

$$
F(x)=(1-p)
\left[
1-\left(1-\frac{1-p}{m}\right)^m
\right].
\tag{26}
$$

Combining (25) and (26),

$$
\frac{F(x)}{f^+(x)}
=
1-\left(1-\frac{1-p}{m}\right)^m
\longrightarrow 1-e^{-(1-p)}
\quad(m\to\infty).
\tag{27}
$$

For every finite admissible $m$, the ratio in (27) is strictly above its limit. Indeed, with $a=1-p>0$, the inequality $\log(1-a/m)<-a/m$ implies

$$
\left(1-\frac{a}{m}\right)^m<e^{-a}.
$$

Accordingly, the sharpness statement is: for every $\varepsilon>0$ there exists a finite normalized instance with $\max_i x_i=p$ and

$$
\frac{F(x)}{f^+(x)}
<
1-e^{-(1-p)}+\varepsilon.
\tag{28}
$$

Theorem 1 gives the reverse lower bound for every admissible instance. Since the exact-maximum class is a subclass of the cap class, (27)–(28) establish both equalities in Theorem 2. $\square$

There is also an explicit finite-size error bound. For $a=1-p$ and every admissible $m$,

$$
0<
\left[1-\left(1-\frac{a}{m}\right)^m\right]-(1-e^{-a})
\le \frac{e^{-a}a^2}{2m(1-a/m)}.
\tag{29}
$$

To see this, for $0<u<1$ the logarithmic series gives

$$
0<-\log(1-u)-u
=\sum_{j\ge2}\frac{u^j}{j}
\le\frac{u^2}{2(1-u)}.
$$

Set $u=a/m$ and $v=m[-\log(1-a/m)-a/m]$. Then

$$
0<v\le\frac{a^2}{2m(1-a/m)},
\qquad
\left(1-\frac{a}{m}\right)^m=e^{-a-v}.
$$

The difference in (29) is $e^{-a}(1-e^{-v})$; applying $1-e^{-v}\le v$ proves the bound. This quantifies how rapidly the finite construction approaches the sharp constant.

This proof establishes a sharp coefficient uniform in the ground-set size. It does not determine the optimal coefficient for a fixed number of elements.

## 8. Endpoint conventions

At $p=0$, the only possible marginal vector is $x=0$. Every admissible random set is empty almost surely, and

$$
F(0)=f^+(0)=f(\varnothing).
$$

Equation (7) is then equality, because its two coefficients sum to one. For the normalized class, however, $f^+(0)=0$. The ratio classes in (8) have no admissible instance at $p=0$. The expression $1-1/e$ is the right-hand limit of the sharp constants as $p\downarrow0$; it is not a positive-denominator normalized ratio attained at $p=0$.

At $p=1$, the universal coefficient is zero, and both cap and exact-maximum infima are zero. A direct normalized example makes the endpoint precise. Let $\varepsilon\in(0,1/2)$, use one positive element and one blocker as in (24), and set their marginals to $\varepsilon$ and $1-\varepsilon$. Then

$$
f^+(x)=\varepsilon,\qquad
F(x)=\varepsilon^2,\qquad
\frac{F(x)}{f^+(x)}=\varepsilon.
$$

This gives $\Gamma_{\le}(1)=0$ as $\varepsilon\downarrow0$. If a coordinate equal to one is required, adjoin an element $d$ that the function ignores and set $x_d=1$. Restricting any law on the enlarged ground set to the original two elements, or extending an original law by always including $d$, shows that both $F$ and $f^+$ are unchanged. Thus $\Gamma_{=}(1)=0$ as well.

## 9. Scope and a distributional corollary

**Corollary 5.** Let $D$ be any distribution on subsets of $N$ with marginals $x\in[0,p]^N$, where $p<1$. For every nonnegative submodular function $f$,

$$
\mathbb E[f(R(x))]
\ge
\bigl(1-e^{-(1-p)}\bigr)\mathbb E_{S\sim D}[f(S)]
+(1-p)e^{-(1-p)}f(\varnothing).
\tag{30}
$$

**Proof.** By definition, $f^+(x)\ge\mathbb E_{S\sim D}f(S)$. The multiplier of $f^+(x)$ in (7) is nonnegative, so substitution proves the claim. $\square$

For normalized functions, the coefficient in (30) cannot be improved uniformly over $D$, because the singleton law used in (25) attains $f^+(x)$.

The improvement over the earlier coefficient is strict for every $0<p<1$. Set $a=1-p$. Strict concavity of $1-e^{-a}$ on $[0,1]$ gives

$$
1-e^{-a}>a(1-e^{-1})
\qquad(0<a<1).
$$

For monotone functions, the classical $1-1/e$ correlation-gap guarantee remains stronger than the present nonmonotone coefficient when $p>0$ [CVZ14]. Theorem 1 concerns the larger function class in which monotonicity is unavailable.

The argument proves a relation between two extensions of the same set function. It does not claim a new polynomial-time method for evaluating $f^+$, a new prophet inequality, or an approximation ratio for a particular feasibility constraint. Such conclusions require their own reductions and algorithmic analysis. Similarly, replacing the denominator by an optimum over pairwise- or $t$-wise-independent laws changes the problem, as does replacing $F(x)$ by the best value at a smaller vector.

The literature comparison included [CL24], [CVZ14], [QS22], [BFNS14], and several 2024–2026 neighboring results. In particular, the nonmonotone Poisson-process algorithm of [KOSS26] was checked in its full official manuscript: it analyzes an adaptive feasible set against a matroid optimum, rather than the prescribed product law and concave closure in (7). Within the recorded search, no prior theorem covering (7) in the same model was identified. These literature checks support a bounded novelty assessment rather than a universal priority claim.

## 10. References

**[CL24]** Chandra Chekuri and Vasilis Livanos. *On submodular prophet inequalities and correlation gap*. Theoretical Computer Science 1019 (2024), 114814. [DOI: 10.1016/j.tcs.2024.114814](https://doi.org/10.1016/j.tcs.2024.114814). [Author-hosted published PDF](https://chekuri.cs.illinois.edu/papers/submod-prophet-inequality-tcs.pdf).

**[CVZ14]** Chandra Chekuri, Jan Vondrák, and Rico Zenklusen. *Submodular function maximization via the multilinear relaxation and contention resolution schemes*. SIAM Journal on Computing 43(6) (2014), 1831–1879. [DOI: 10.1137/110839655](https://doi.org/10.1137/110839655). [Author-hosted published PDF](https://chekuri.cs.illinois.edu/papers/83965.pdf).

**[BFNS14]** Niv Buchbinder, Moran Feldman, Joseph (Seffi) Naor, and Roy Schwartz. *Submodular Maximization with Cardinality Constraints*. Proceedings of the Twenty-Fifth Annual ACM–SIAM Symposium on Discrete Algorithms (SODA 2014), 1433–1452. [DOI: 10.1137/1.9781611973402.106](https://doi.org/10.1137/1.9781611973402.106). [Author-hosted manuscript](https://theory.epfl.ch/moranfe/Publications/SODA2014.pdf).

**[QS22]** Frederick Qiu and Sahil Singla. *Submodular Dominance and Applications*. APPROX/RANDOM 2022, LIPIcs 245, 44:1–44:21. [DOI: 10.4230/LIPIcs.APPROX/RANDOM.2022.44](https://doi.org/10.4230/LIPIcs.APPROX/RANDOM.2022.44). [Official proceedings PDF](https://drops.dagstuhl.de/storage/00lipics/lipics-vol245-approx-random2022/LIPIcs.APPROX-RANDOM.2022.44/LIPIcs.APPROX-RANDOM.2022.44.pdf).

**[KOSS26]** Ariel Kulik, Thiago Oliveira, Roy Schwartz, and Mohit Singh. *If it is Good Then Drop it -- a Spiteful Poisson Process for Submodular Maximization*. arXiv:2608.05062 (2026). [Official manuscript](https://arxiv.org/pdf/2608.05062).

The comparison is limited to the sources described here.

