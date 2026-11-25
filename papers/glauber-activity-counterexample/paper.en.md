# Cooling can increase Glauber activity beyond one half

## Abstract

Luo, Zhen, Liu, Ebler and Dahlsten conjectured that the probability of a state change in Glauber simulated annealing never exceeds one half when the process starts in thermal equilibrium and the temperature decreases. We disprove this statement on a connected eight-state, three-regular neighbourhood graph. The counterexample has distinct integer energies, three strictly positive finite temperatures, and exact rational transition probabilities. Its second-step activity exceeds $51/100$, and its two-step average exceeds $63/125$. Consequently, the conjectured bound on the average also fails. A family of examples explains the effect: for every degree $d\geq3$, two cooling steps can attain activity arbitrarily close to

$$
\frac12+\frac{d-2}{d^2(d+1)}.
$$

For $d=3$, the limiting second-step activity is $19/36$ and the limiting average is $37/72$. Conversely, in this regular-neighbourhood model at nonnegative inverse temperatures, the first activity of any run from a Gibbs state is at most one half. The examples therefore use the minimum possible number of attempted updates. The argument does not require an infinite-temperature initial state or a zero-temperature transition. These are research results with complete written proofs and exact computational certificates; they have not undergone external peer review.

## 1. The conjecture and its scope

Consider a finite simple undirected graph $G=(V,E)$, with $N=|V|$, in which every vertex has degree $d>0$. Vertex $i$ has a fixed energy $E_i\in\mathbb R$. The Gibbs distribution at inverse temperature $\beta>0$ is

$$
\pi_i(\beta)=\frac{e^{-\beta E_i}}{Z(\beta)},
\qquad Z(\beta)=\sum_{j\in V}e^{-\beta E_j}.
$$

The Glauber transition matrix is column stochastic. For adjacent distinct vertices,

$$
P_{ij}(\beta)=\frac1d\frac{1}{1+e^{\beta(E_i-E_j)}}
=\frac1d\frac{\pi_i(\beta)}{\pi_i(\beta)+\pi_j(\beta)}.
\tag{1}
$$

For nonadjacent distinct vertices it is zero, and

$$
P_{jj}(\beta)=1-\sum_{i\ne j}P_{ij}(\beta).
\tag{2}
$$

Every entry is nonnegative, each column sums to one, and

$$
P_{ij}(\beta)\pi_j(\beta)=P_{ji}(\beta)\pi_i(\beta).
\tag{3}
$$

Thus this is precisely a reversible Glauber chain with uniform proposal over the neighbourhood.

For an increasing inverse-temperature schedule $\beta_0<\beta_1<\cdots<\beta_K$, let

$$
p(0)=\pi(\beta_0),\qquad p(k+1)=P(\beta_{k+1})p(k).
\tag{4}
$$

The activity during update $k\to k+1$ is

$$
\mathcal A_k=\sum_jp_j(k)\sum_{i\ne j}P_{ij}(\beta_{k+1}),
\qquad
\overline{\mathcal A}_K=\frac1K\sum_{k=0}^{K-1}\mathcal A_k.
\tag{5}
$$

This is the indexing convention in Eqs. (30) and (33) of Luo et al. [1]. In particular, the distribution is evaluated **before** the update and the transition matrix uses the **next** temperature.

Their Eq. (39), in Section IV.B, conjectures $\mathcal A_k\leq1/2$. They consequently propose $\overline{\mathcal A}_K\leq1/2$. Their general algorithm in Eqs. (30)–(32) permits a neighbourhood graph; the discussion restricts to equal neighbourhood sizes before the conjecture. The seven-spin model is a numerical example, not an additional premise of the general statement. Our graph belongs to this regular-neighbourhood class. We do not claim that it is the graph of single-spin flips on a hypercube.

An earlier result of the Trureturing project [2] disproves preservation of a stronger, vertexwise neighbourhood-passivity condition, while explicitly leaving the activity conjecture itself unresolved. The distinction matters: a negative contribution at one vertex need not make the sum in (5) exceed one half. Our examples make the full aggregate, and its two-step average, exceed the proposed bound.

## 2. Main results

### Theorem 1. A finite two-step counterexample

Let $G$ consist of two copies of $K_4$ on the vertex sets $\{0,1,2,3\}$ and $\{4,5,6,7\}$. Remove the edges $\{2,3\}$ and $\{4,5\}$, and insert $\{2,4\}$ and $\{3,5\}$. Equivalently, its edge set is

$$
\begin{split}
E=\{&01,02,03,12,13,\;46,47,56,57,67,\;24,35\}.
\end{split}
\tag{6}
$$

Here $ij$ denotes the unordered edge $\{i,j\}$. Assign the energies

$$
(E_0,\ldots,E_7)=(0,1,2,3,50,51,52,53)
\tag{7}
$$

and inverse temperatures

$$
(\beta_0,\beta_1,\beta_2)
=\bigl(\log(1001/1000),\;\log(21/20),\;\log32\bigr).
\tag{8}
$$

Starting from $p(0)=\pi(\beta_0)$, the activities satisfy

$$
\mathcal A_0>\frac{249}{500},\qquad
\mathcal A_1>\frac{51}{100},\qquad
\overline{\mathcal A}_2>\frac{63}{125}>\frac12.
\tag{9}
$$

All energies are distinct, all three temperatures are finite and strictly positive, and the schedule is strictly cooling. The graph is connected and three regular. Thus the activity conjecture and its proposed averaged bound fail under their original assumptions.

The numerical values, included only for orientation, are

$$
\mathcal A_0\approx0.4983327394,\qquad
\mathcal A_1\approx0.5100617949,\qquad
\overline{\mathcal A}_2\approx0.5041972672.
\tag{10}
$$

The proof below establishes the inequalities with exact rational arithmetic; decimal rounding is not used as evidence.

### Theorem 2. A mechanism in every regular degree at least three

For every integer $d\geq3$, there is a connected $d$-regular graph on $2(d+1)$ vertices and a one-parameter family of distinct energies and strictly cooling, finite positive temperature schedules such that

$$
\lim_{\varepsilon\downarrow0}\mathcal A_0(\varepsilon)=\frac12,
\quad
\lim_{\varepsilon\downarrow0}\mathcal A_1(\varepsilon)
=\frac12+\frac{d-2}{d^2(d+1)},
\tag{11}
$$

and hence

$$
\lim_{\varepsilon\downarrow0}\overline{\mathcal A}_2(\varepsilon)
=\frac12+\frac{d-2}{2d^2(d+1)}>\frac12.
\tag{12}
$$

The second-step activity and the two-step average both exceed one half for every parameter in the explicit range

$$
0<\varepsilon\leq\frac{1}{256d^6}.
\tag{12a}
$$

The first-step activity obeys Proposition 3. At $d=3$, the second-step and averaged limits are $19/36$ and $37/72$, respectively.

### Proposition 3. Two attempted updates are necessary

For every regular undirected neighbourhood graph, every fixed energy function, every Gibbs initial state with inverse temperature $\beta_0\geq0$, and every nonnegative inverse temperature $\beta_1$ used in the first update, one has $\mathcal A_0\leq1/2$. In particular, a strictly cooling counterexample cannot occur before the second update. This follows directly from the edge identity of Eq. (40) in [1], as shown below. Combined with Theorem 1 it gives minimality in the number of updates, not in the number of vertices or the graph degree.

## 3. Exact identities and the first-step obstruction

Write

$$
a_i(\beta)=\sum_{j\ne i}P_{ji}(\beta)
\tag{13}
$$

for the probability of leaving vertex $i$. For any distribution $p$, pairing the two directions of every edge gives

$$
\mathcal A_\beta(p)
=\frac12-\frac{1}{2d}
\sum_{\{i,j\}\in E}
\frac{e^{-\beta E_i}-e^{-\beta E_j}}
     {e^{-\beta E_i}+e^{-\beta E_j}}(p_i-p_j).
\tag{14}
$$

Identity (14) is the unordered-edge form of Eq. (40) in [1]. The product does not depend on which endpoint is written first. To verify the convention, the contribution of one edge is

$$
\frac1d\frac{w_ip_j+w_jp_i}{w_i+w_j}
=\frac{p_i+p_j}{2d}
-\frac{(w_i-w_j)(p_i-p_j)}{2d(w_i+w_j)},
\tag{15}
$$

where $w_i=e^{-\beta E_i}$. Summing the first term gives $1/2$, because each vertex belongs to $d$ edges.

For $p=\pi(\beta_0)$ and $\beta_0,\beta\geq0$, the factors $w_i-w_j$ and $p_i-p_j$ always have the same sign: both are nonnegative when $E_i\leq E_j$, and both are nonpositive when $E_i\geq E_j$. Every summand subtracted in (14) is therefore nonnegative. This proves Proposition 3.

A second identity isolates why a later update can behave differently. Let $u_i=1/N$. On every edge,

$$
P_{ij}(\beta)+P_{ji}(\beta)=\frac1d.
\tag{16}
$$

It follows that $\sum_i a_i(\beta)=N/2$ and

$$
\bigl(P(\beta)u\bigr)_i=\frac{2(1-a_i(\beta))}{N}.
\tag{17}
$$

Consequently, two consecutive updates from $u$ obey

$$
\mathcal A_{\beta_2}\bigl(P(\beta_1)u\bigr)
=\frac12-2\operatorname{Cov}_{u}
\bigl(a(\beta_1),a(\beta_2)\bigr).
\tag{18}
$$

Equation (18) is an explanatory identity for a uniform initial distribution. Its derivation uses only (16) and the fact that both means are $1/2$. For that initial distribution, activity above one half is equivalent to a negative correlation between the exit probabilities at the two temperatures. The construction below creates this temperature-dependent reversal and preserves the violation with a finite positive-temperature Gibbs initial state.

## 4. Proof of the family theorem

Fix $d\geq3$. Let the two cliques have labelled vertices

$$
L_0,\ldots,L_d,\qquad H_0,\ldots,H_d.
$$

Delete the edge $L_{d-1}L_d$ from the first clique and $H_0H_1$ from the second. Insert the cross edges $L_{d-1}H_0$ and $L_dH_1$. Each affected vertex loses one edge and gains one. Hence the graph remains $d$ regular. Each clique with one edge removed is connected for $d\geq2$, and the cross edges join them, so the whole graph is connected.

For $0<\varepsilon<1/(d+1)$, set

$$
E(L_i)=i\varepsilon,
\qquad E(H_i)=1+i\varepsilon,
\tag{19}
$$

and choose

$$
\beta_0=\varepsilon,
\qquad \beta_1=\varepsilon^{-1/2},
\qquad \beta_2=\varepsilon^{-2}.
\tag{20}
$$

All energies are distinct. Because $0<\varepsilon<1$, the inverse temperatures are finite, positive, and strictly increasing. Thus the physical temperatures $T_k=1/\beta_k$ are finite, positive, and strictly decreasing.

We now take a limit solely to prove existence of finite examples. Since $\beta_0 E(v)\to0$ for every vertex, the Gibbs initial distribution converges to $u$.

During the first update, every energy difference inside a clique is $O(\varepsilon)$. Its product with $\beta_1$ is $O(\sqrt\varepsilon)$, so every intra-clique acceptance tends to $1/2$. The cross-edge energy gaps tend to one. Their products with $\beta_1$ tend to infinity. Accordingly, cross-edge moves from $H$ to $L$ have acceptance tending to one, and moves from $L$ to $H$ have acceptance tending to zero.

Let $N=2(d+1)$. From an exactly uniform input, an unaffected vertex has the same total incoming and outgoing probabilities in this limit. A low cross-edge endpoint gains mass $1/(dN)$, and a high endpoint loses that amount. Therefore

$$
p^{(1)}_*(v)=\begin{cases}
u_v+1/(dN),&v=L_{d-1},L_d,\\
u_v-1/(dN),&v=H_0,H_1,\\
u_v,&\text{otherwise}.
\end{cases}
\tag{21}
$$

This formula also follows directly from (17). Since all matrices and vectors are finite dimensional, entrywise convergence proves that the actual $p(1)$ converges to (21).

During the second update, even the smallest nonzero intra-clique energy gap is $\varepsilon$, and $\beta_2\varepsilon=\varepsilon^{-1}\to\infty$. Thus every downhill move has limiting acceptance one and every uphill move has limiting acceptance zero. The limiting exit probabilities of the four modified vertices are

$$
a_*(L_{d-1})=a_*(L_d)=\frac{d-1}{d},
\qquad
a_*(H_0)=a_*(H_1)=\frac1d.
\tag{22}
$$

For example, $L_{d-1}$ and $L_d$ each have $d-1$ lower-energy neighbours in the low clique and one higher-energy cross neighbour. Each of $H_0,H_1$ has one lower-energy cross neighbour and $d-1$ higher-energy neighbours in the high clique.

The exit probability averaged against $u$ is $1/2$ at every temperature, by (16), and hence also in the zero-temperature limit. Substituting the four deviations in (21) into this uniform baseline gives

$$
\begin{aligned}
\lim_{\varepsilon\downarrow0}\mathcal A_1
&=\frac12+
2\frac1{dN}\frac{d-1}{d}
-2\frac1{dN}\frac1d\\
&=\frac12+\frac{2(d-2)}{d^2N}\\
&=\frac12+\frac{d-2}{d^2(d+1)}.
\end{aligned}
\tag{23}
$$

For the first update, $p(0)\to u$, the exit probabilities stay in $[0,1]$, and their uniform average is exactly $1/2$. Thus $\mathcal A_0\to1/2$. Averaging establishes (12).

For fixed $d\geq3$, the second-step and averaged limits in (11)–(12) exceed $1/2$ by strictly positive quantities. The next estimate gives the explicit finite-parameter range in (12a). No infinite or zero temperature is used in any member of this family.

### A uniform finite-parameter estimate

Assume $0<\varepsilon\leq1/(256d^6)$, and put

$$
\Delta_d=\frac{d-2}{d^2(d+1)}\geq\frac1{4d^2}.
\tag{23a}
$$

We compare the actual initial distribution and transition matrices to their limits. The energy range is $1+d\varepsilon$. Set $x=\varepsilon(1+d\varepsilon)$. Since the ratio of each Gibbs probability to $1/N$ lies between $e^{-x}$ and $e^x$,

$$
\delta_0:=\|p(0)-u\|_1\leq e^x-1\leq3\varepsilon.
\tag{23b}
$$

For the last inequality, $d\varepsilon\leq1/2$ implies $x\leq3\varepsilon/2\leq1/2$, and the elementary series bound $e^x\leq1/(1-x)$ gives $e^x-1\leq2x\leq3\varepsilon$.

The logistic acceptance function has derivative bounded in absolute value by $1/4$. On an intra-clique edge its deviation from $1/2$ is therefore at most $d\sqrt\varepsilon/4$. On a cross edge its deviation from the limiting zero or one is at most

$$
\eta=\exp\left(-\frac{1-d\varepsilon}{\sqrt\varepsilon}\right).
$$

Let $P_*$ denote the limiting first-update transition matrix described above. After division by $d$, the absolute off-diagonal errors in a column sum to at most $d\sqrt\varepsilon/4+\eta$. The diagonal error is at most that same sum, because the column sums remain one. Thus, with the induced column-sum matrix norm,

$$
\begin{aligned}
\delta_1&:=\|P(\beta_1)-P_*\|_{1\to1}\\
&\leq\frac{d\sqrt\varepsilon}{2}+2\eta
\leq\frac{d\sqrt\varepsilon}{2}+16\varepsilon.
\end{aligned}
\tag{23c}
$$

Indeed, $1-d\varepsilon\geq1/2$, and $e^{-y}\leq2/y^2$ for $y>0$ follows from $e^y\geq y^2/2$. Consequently $\eta\leq8\varepsilon$.

Every adjacent energy gap is at least $\varepsilon$ in this parameter range. At the second temperature, each acceptance therefore differs from its downhill limit by at most $e^{-1/\varepsilon}$. Averaging the $d$ outgoing acceptances yields

$$
\delta_2:=\|a(\beta_2)-a_*\|_\infty
\leq e^{-1/\varepsilon}\leq\varepsilon.
\tag{23d}
$$

A stochastic matrix contracts the vector $1$-norm. Therefore

$$
\|p(1)-p_*^{(1)}\|_1\leq\delta_0+\delta_1.
$$

All exit probabilities lie in $[0,1]$, so (23b)–(23d) give

$$
\left|\mathcal A_1-\left(\frac12+\Delta_d\right)\right|
\leq\frac{d\sqrt\varepsilon}{2}+20\varepsilon,
\tag{23e}
$$

while $|\mathcal A_0-1/2|\leq\delta_0\leq3\varepsilon$. In turn,

$$
\left|\overline{\mathcal A}_2-\left(\frac12+\frac{\Delta_d}{2}\right)\right|
\leq\frac{d\sqrt\varepsilon}{4}+\frac{23\varepsilon}{2}.
\tag{23f}
$$

Using $\sqrt\varepsilon\leq1/(16d^3)$ and $d^{-4}\leq1$, the right-hand side of (23e) is at most $7/(64d^2)$, and the right-hand side of (23f) is at most $31/(512d^2)$. These bounds are strictly less than $\Delta_d$ and $\Delta_d/2$, respectively, by (23a). Hence $\mathcal A_1>1/2$ and $\overline{\mathcal A}_2>1/2$ throughout (12a). This completes the proof of Theorem 2.

### The eight-state limits

For $d=3$, the limiting first-updated distribution and second-update exit probabilities are particularly transparent:

| Vertex | $p^{(1)}_*(i)$ | $a_*(i)$ |
| --- | ---: | ---: |
| 0 | $1/8$ | $0$ |
| 1 | $1/8$ | $1/3$ |
| 2 | $1/6$ | $2/3$ |
| 3 | $1/6$ | $2/3$ |
| 4 | $1/12$ | $1/3$ |
| 5 | $1/12$ | $1/3$ |
| 6 | $1/8$ | $2/3$ |
| 7 | $1/8$ | $1$ |

Their scalar product is $19/36$. Since the first activity tends to $1/2$, the two-step average tends to $37/72$.

## 5. Exact verification of the finite example

For Theorem 1 define the rational numbers

$$
q_0=\frac{1001}{1000},\qquad
q_1=\frac{21}{20},\qquad q_2=32.
\tag{24}
$$

Because every energy is a nonnegative integer and $\beta_s=\log q_s$, the unnormalised Gibbs weights are exactly

$$
w_i^{(s)}=q_s^{-E_i}\in\mathbb Q_{>0}.
\tag{25}
$$

The complete witness can therefore be checked without approximating an exponential or logarithm. Set

$$
p_i^{(0)}=\frac{w_i^{(0)}}{\sum_j w_j^{(0)}},
\qquad
t_{ij}^{(s)}=\frac{w_i^{(s)}}{3(w_i^{(s)}+w_j^{(s)})}
\quad(ij\in E),
\tag{26}
$$

and set off-edge entries to zero, with diagonal entries chosen to give column sum one. Then compute

$$
p_i^{(1)}=\sum_j t_{ij}^{(1)}p_j^{(0)},
\quad
A_0=\sum_{i\ne j}t_{ij}^{(1)}p_j^{(0)},
\quad
A_1=\sum_{i\ne j}t_{ij}^{(2)}p_j^{(1)}.
\tag{27}
$$

These are finite sums and products of explicitly specified rational numbers. The accompanying certificate evaluates them with arbitrary-precision integer numerators and denominators. In particular, it proves the following strict rational enclosures. Each printed decimal is a rational number with denominator $10^{12}$, not a floating-point estimate.

| Quantity | Strict lower bound | Strict upper bound |
| --- | ---: | ---: |
| $A_0$ | 0.498332739386 | 0.498332739387 |
| $A_1$ | 0.510061794935 | 0.510061794936 |
| $(A_0+A_1)/2$ | 0.504197267160 | 0.504197267161 |

For a shorter certificate of the decisive inequality, the following table lists strict lower bounds for $p_i^{(1)}$ and $a_i(\beta_2)$, again with denominator $10^{12}$. The corresponding strict upper bounds are obtained by adding $10^{-12}$ to each entry.

| Vertex | Lower bound for $p_i^{(1)}$ | Lower bound for $a_i(\beta_2)$ |
| --- | ---: | ---: |
| 0 | 0.134432627629 | 0.010436385568 |
| 1 | 0.130224087055 | 0.333658536585 |
| 2 | 0.158372066445 | 0.656240453313 |
| 3 | 0.156177168554 | 0.666331291199 |
| 4 | 0.093533858895 | 0.333668708800 |
| 5 | 0.091506889985 | 0.343759546686 |
| 6 | 0.119874343626 | 0.666341463414 |
| 7 | 0.115878957808 | 0.989563614431 |

The scalar product of the two columns is the exact rational number

$$
\frac{5100617949331072823461}{10^{22}}>\frac{51}{100}.
\tag{27a}
$$

Since every probability and exit rate is positive, this lower-bounds $A_1$. The exact certificate also verifies

$$
500A_0-249>0,
\qquad 100A_1-51>0.
\tag{28}
$$

The signs in (28) reduce to signs of integers after multiplication by positive denominators. It also verifies graph degree and connectedness, positivity and normalisation of the Gibbs distribution, nonnegativity and column sums of both transition matrices, and detailed balance. Thus all hypotheses and both numerical inequalities are checked exactly. Finally,

$$
\frac{A_0+A_1}{2}
>\frac12\left(\frac{249}{500}+\frac{51}{100}\right)
=\frac{63}{125}.
\tag{29}
$$

This proves Theorem 1. The certificate is an exact finite computation, while Theorem 2 and Proposition 3 have general analytic proofs. No Lean certification is asserted.

## 6. Interpretation and limits

The first cooling step distinguishes two energy bands while leaving the fine structure within each band almost unresolved. Probability flows across the two connecting edges. It accumulates at vertices near the top of the lower band and is depleted at vertices near the bottom of the upper band. A stronger cooling step resolves the fine structure: the accumulated vertices then have many downhill exits, and the depleted vertices have few. The resulting aggregate jumping probability is above the uniform value of one half. Cooling alone does not force an ordering of the exit profiles at two temperatures.

This effect is stable. For the fixed graph, the activity and its two-step average are continuous functions of all energies and all positive inverse temperatures. The finite margins in (9), the strict order of the energies, and the strict order of the temperatures therefore persist in a sufficiently small open neighbourhood of the explicit witness. The counterexample is not confined to a singular limit or an exactly tuned point.

The result refutes the proposed replacement of the evolving activity by the universal constant $1/2$. It does not by itself refute the general stochastic-thermodynamic performance bound in [1] when the actual activity is retained. Nor does it establish failure on a single-spin-flip hypercube, classify degree-two neighbourhoods, give the largest attainable activity, or prove eight-state minimality. The proved minimality concerns the number of attempted updates only.

## References

[1] Yutong Luo, Yi-Zheng Zhen, Xiangjing Liu, Daniel Ebler and Oscar Dahlsten. **Bound on annealing performance from stochastic thermodynamics, with application to simulated annealing.** *Physical Review E* **108**, 054119 (2023). DOI: [10.1103/PhysRevE.108.054119](https://doi.org/10.1103/PhysRevE.108.054119). Fixed preprint: [arXiv:2311.10424v1](https://arxiv.org/abs/2311.10424v1). Equations (30)–(33) specify the dynamics and activity; Eqs. (38)–(41) state the equilibrium bound, activity conjecture and neighbourhood-passivity route.

[2] The Trureturing project. **Glauber annealing from a thermal state need not preserve neighbourhood passivity.** Online research exposition and formal-result dossier, accessed 24 November 2026. [Research page](https://www.trureturing.org/research/luo-zhen-liu-ebler-dahlsten-2023-neighbourhood-passivity-refutation/). The recorded result concerns vertexwise passivity and explicitly does not settle Eq. (39) of [1]. This is an online research result, not an external peer-review certificate for the present work.
