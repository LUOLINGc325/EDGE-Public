# A Bridge Mechanism for Excess Activity in Glauber Annealing

## A two-step counterexample on a ten-state regular graph and a structural family

**Research draft, 24 November 2026.** AI-assisted mathematical research. This document gives a mathematical proof and a finite rational certificate. It has not undergone external peer review. The computational programs and proof-assistant sources are not included in this version.

## Abstract

For simulated annealing with Glauber acceptance on a regular neighbourhood graph, Luo, Zhen, Liu, Ebler, and Dahlsten conjectured that the probability of a state change at each step is at most one half. We give a connected three-regular graph on ten states, a Gibbs initial distribution at a strictly positive finite inverse temperature, and two strictly cooling updates for which the second-step activity is approximately 0.5033297745. The average activity of the two updates is approximately 0.5016587922. A short analytic proof gives the strict bounds 0.5025 and 0.5009375, respectively, without relying on decimal computation. All Gibbs weights and transition probabilities in the displayed example are rational. The proof identifies a negative inner product between the exit-rate bias vectors at the two update temperatures. More generally, every connected regular graph of degree at least three that has a bridge admits such a two-step violation for a suitable energy landscape. The example persists under small perturbations, including perturbations making every energy distinct. A Gibbs start cannot violate the bound at the first update, so the second update is the earliest possible time of failure. The result refutes the universal activity claim for the regular-neighbourhood model; it does not settle the conjecture on single-spin-flip hypercubes or invalidate the source paper's bounds that retain the actual activity.

## 1. The precise claim

Luo et al. [1, Section IV.1–IV.2, Equations (30)–(33)] describe a finite-state simulated-annealing chain with Glauber acceptance. Their equal-neighbourhood discussion leads to the conjecture [1, Equation (39)]

$$
\mathcal A^{\mathrm D}(k)\le \frac12.
\tag{1}
$$

The activity uses the transition matrix at the **next** temperature and the distribution **before** that transition. We preserve this convention exactly. The associated iteration average in [1, Equation (33) and the following paragraph] is over the actual updates, indexed from zero to one less than the number of updates.

The fixed setting here is a finite, simple, connected, undirected regular graph; an arbitrary real energy assigned to each state; a Gibbs initial distribution; and a strictly increasing sequence of positive inverse temperatures. This is the regular-neighbourhood specialization of the transition rule in [1]. The numerical spin-glass examples in that source use a more specific neighbourhood graph. Our ten-state graph is not a spin hypercube, so we make no assertion that its single-spin-flip special case has been refuted.

The local neighbourhood-passivity condition proposed in [1, Equation (41)] as a sufficient mechanism for (1) was already refuted in a public research record [2]. That record explicitly leaves the aggregate activity claim open. The present construction makes the **aggregate** activity, and even its two-update average, exceed one half.

## 2. Model and a useful identity

Let $G=(V,\mathcal E)$ be a simple undirected $d$-regular graph on $N$ vertices. Its vertices are system states. Fix an energy vector $E=(E_i)_{i\in V}$. For an inverse temperature $\beta\ge0$, define

$$
\gamma_\beta(i)
=\frac{e^{-\beta E_i}}{\sum_j e^{-\beta E_j}}.
$$

We use column probability vectors. For distinct states, the transition matrix is

$$
P_\beta(i,j)=
\begin{cases}
\displaystyle\frac{1}{d\bigl(1+e^{\beta(E_i-E_j)}\bigr)},&\{i,j\}\in\mathcal E,\\[6pt]
0,&\{i,j\}\notin\mathcal E,
\end{cases}
\qquad
P_\beta(j,j)=1-\sum_{i\ne j}P_\beta(i,j).
\tag{2}
$$

The proposal graph has no loops; the Markov chain has the holding probabilities in (2). Each column sums to one. At finite temperature all edge transitions and all holding probabilities are positive. In particular, on a connected graph the chain is irreducible and aperiodic. Direct substitution gives detailed balance:

$$
P_\beta(i,j)\gamma_\beta(j)
=\frac{1}{dZ_\beta(e^{\beta E_i}+e^{\beta E_j})}
=P_\beta(j,i)\gamma_\beta(i)
\quad (\{i,j\}\in\mathcal E).
\tag{3}
$$

Given $0<\beta_0<\beta_1<\beta_2$, our two-update run is

$$
p_0=\gamma_{\beta_0},\qquad
p_1=P_{\beta_1}p_0,\qquad
p_2=P_{\beta_2}p_1.
\tag{4}
$$

Write

$$
a_\beta(j)=\sum_{i\ne j}P_\beta(i,j),
\qquad
f_\beta(j)=2a_\beta(j)-1.
\tag{5}
$$

Thus $a_\beta(j)$ is the probability of leaving state $j$ and $f_\beta(j)$ is its centred exit bias. The activities and their average are

$$
\mathcal A_0=a_{\beta_1}^{\mathsf T}p_0,
\qquad
\mathcal A_1=a_{\beta_2}^{\mathsf T}p_1,
\qquad
\overline{\mathcal A}=\frac{\mathcal A_0+\mathcal A_1}{2}.
\tag{6}
$$

### Lemma 1. Uniform-start identity

Let $u=N^{-1}\mathbf1$. For every $\beta\ge0$,

$$
\mathbf1^{\mathsf T}f_\beta=0,
\qquad
P_\beta u=\frac1N(\mathbf1-f_\beta),
\qquad
a_\beta^{\mathsf T}u=\frac12.
\tag{7}
$$

For any two update temperatures $\alpha,\beta\ge0$,

$$
a_\beta^{\mathsf T}P_\alpha u
=\frac12-\frac{f_\beta^{\mathsf T}f_\alpha}{2N}.
\tag{8}
$$

**Proof.** On each undirected edge, the two opposite transition probabilities sum to $1/d$. Consequently,

$$
\sum_j a_\beta(j)=\frac{|\mathcal E|}{d}=\frac N2,
$$

which proves the first and third identities. The off-diagonal entries in row $i$ sum to $1-a_\beta(i)$, because each opposite edge probability complements the outgoing probability to $1/d$. Adding the diagonal entry gives row sum $2(1-a_\beta(i))=1-f_\beta(i)$. This proves the middle identity. Finally, substitute that identity and $a_\beta=(\mathbf1+f_\beta)/2$, and use the zero sums of both bias vectors. $\square$

Equation (8) reduces the two-step obstruction to a sign question: exit biases at different temperatures can have a negative inner product. No long-time limit of the Markov chain is involved.

### Lemma 2. A Gibbs initial state obeys the first-update bound

For every $\beta_0\ge0$ and every $\beta_1\ge0$,

$$
a_{\beta_1}^{\mathsf T}\gamma_{\beta_0}\le\frac12.
\tag{9}
$$

**Proof.** From (2) and (5),

$$
f_\beta(i)=\frac1d\sum_{j:\{i,j\}\in\mathcal E}
\tanh\!\left(\frac{\beta(E_i-E_j)}2\right).
\tag{10}
$$

Combining the two directed contributions of each edge gives

$$
f_{\beta_1}^{\mathsf T}\gamma_{\beta_0}
=\frac1d\sum_{\{i,j\}\in\mathcal E}
\tanh\!\left(\frac{\beta_1(E_i-E_j)}2\right)
\bigl(\gamma_{\beta_0}(i)-\gamma_{\beta_0}(j)\bigr).
$$

Each summand is nonpositive: increasing energy decreases its Gibbs weight. Applying (5) proves (9). $\square$

This shows that two updates are necessary for any violation from a nonnegative-temperature Gibbs start. It is a statement about the first possible update, not a minimality claim about the number of states.

## 3. An explicit ten-state instance

Use vertices $0,1,\ldots,9$, degree $d=3$, and the fifteen edges

$$
\begin{aligned}
\mathcal E=\{&
\{0,2\},\{0,3\},\{1,2\},\{1,3\},\{2,3\},
\{0,4\},\{1,4\},\\
&\{5,7\},\{5,8\},\{6,7\},\{6,8\},\{7,8\},
\{5,9\},\{6,9\},\{4,9\}\}.
\end{aligned}
\tag{11}
$$

One can build this graph from two copies of $K_4$ by subdividing one edge in each copy and joining the two new subdivision vertices. The joining edge $\{4,9\}$ is a bridge. Every vertex has exactly three neighbours, and the graph is connected.

The energy vector and exponential temperature parameters are

$$
E=(0,0,0,0,1,11,11,11,11,10),
\tag{12}
$$

$$
q_0=\frac{10001}{10000},\qquad
q_1=\frac54,\qquad
q_2=100,
\qquad \beta_k=\log q_k.
\tag{13}
$$

They give $0<\beta_0<\beta_1<\beta_2<\infty$. Equivalently, the three physical temperatures $T_k=1/\beta_k$, in units with Boltzmann's constant one, are positive, finite, and strictly decreasing.

Because all energies are integers, (2) and the initial Gibbs distribution can be evaluated using rational powers of the rational numbers $q_k$. Logarithms and floating-point exponentials are unnecessary for certification.

### Theorem 3. Both pointwise and averaged activity exceed one half

For (11)–(13), the run (4) satisfies

$$
\mathcal A_1>\frac12+\frac1{400},
\qquad
\overline{\mathcal A}>\frac12+\frac3{3200}.
\tag{14}
$$

**Proof.** We first use the uniform distribution only as an auxiliary calculation, then bound the change to the finite-temperature Gibbs start actually specified in (13).

For $q=e^\beta$, set

$$
\ell(q)=\frac{q-1}{q+1},\qquad
h(q)=\frac{q^9-1}{q^9+1}.
\tag{15}
$$

The energy differences on the edges of (11) have absolute values zero, one, or nine. Equation (10) therefore gives the full bias vector

$$
f_\beta
=\frac13\bigl(
-\ell,-\ell,0,0,2\ell-h,
\ell,\ell,0,0,h-2\ell
\bigr).
\tag{16}
$$

Use lowercase $\ell,h$ for (15) at $q_1$, and uppercase $L,H$ for (15) at $q_2$. Explicitly,

$$
\ell=\frac19,
\qquad
h=\frac{5^9-4^9}{5^9+4^9}>\frac34,
\qquad
L=\frac{99}{101},
\qquad
0<H<1.
\tag{17}
$$

The inequality for $h$ follows, for example, by checking $5^9>7\cdot4^9$. Taking the inner product of the two vectors (16) gives

$$
f_{\beta_2}^{\mathsf T}f_{\beta_1}
=\frac{2(2\ell-h)(2L-H)+4\ell L}{9}.
\tag{18}
$$

Here $2\ell-h<-19/36<0$, while $2L-H>97/101>0$. Hence

$$
\begin{aligned}
f_{\beta_2}^{\mathsf T}f_{\beta_1}
&<\frac19\left[
2\left(-\frac{19}{36}\right)\frac{97}{101}
 +4\cdot\frac19\cdot\frac{99}{101}\right]\\
&=-\frac{1051}{16362}.
\end{aligned}
\tag{19}
$$

By Lemma 1 with $N=10$, the second-update activity under the auxiliary uniform start, denoted $\mathcal A_1^{u}$, obeys

$$
\mathcal A_1^{u}-\frac12
>\frac{1051}{327240}>\frac1{320}.
\tag{20}
$$

We now compare $p_0=\gamma_{\beta_0}$ with $u$. Since all energies lie between zero and eleven,

$$
q_0^{-11}\le q_0^{-E_i}\le1.
$$

After normalization, the density ratio $p_0(i)/u(i)$ lies between $q_0^{-11}$ and $q_0^{11}$. Therefore

$$
\operatorname{TV}(p_0,u)
=\frac12\sum_i|p_0(i)-u(i)|
\le\frac{q_0^{11}-1}{2}.
\tag{21}
$$

The binomial expansion and $\binom{11}{k}\le11^k$ give

$$
\left(1+\frac1{10000}\right)^{11}
<\frac1{1-11/10000},
$$

so that

$$
\operatorname{TV}(p_0,u)
<\frac{11}{19978}<\frac1{1600}.
\tag{22}
$$

For any probability vectors $p,r$ and any vector $a$ with entries in $[0,1]$,

$$
|a^{\mathsf T}(p-r)|\le\operatorname{TV}(p,r).
\tag{23}
$$

A stochastic matrix contracts total variation. In this finite setting that follows directly from

$$
\sum_i\left|\sum_jP(i,j)(p(j)-r(j))\right|
\le\sum_j|p(j)-r(j)|\sum_iP(i,j)
=\sum_j|p(j)-r(j)|.
$$

Applying these facts to both activities gives

$$
\left|\mathcal A_0-\frac12\right|<\frac1{1600},
\qquad
|\mathcal A_1-\mathcal A_1^{u}|<\frac1{1600}.
\tag{24}
$$

Combining (20) and (24),

$$
\mathcal A_1>\frac12+\frac1{320}-\frac1{1600}
=\frac12+\frac1{400}.
$$

The uniform-start first-update activity is exactly one half. Combining the two inequalities in (24) before taking the average therefore yields

$$
\overline{\mathcal A}
>\frac12+\frac1{640}-\frac1{1600}
=\frac12+\frac3{3200}.
$$

The initial state throughout this conclusion is the strictly positive finite-temperature Gibbs state in (13). $\square$

### Exact evaluation

Direct evaluation of the rational transition rule gives

$$
\mathcal A_1=
\frac{
5902774591859117272939967982483087445482386027746372473407417552821
}{
11727449656979417367643962007570080930504786847474663574588274496884
}.
\tag{25}
$$

For readability, the corresponding values rounded to the displayed digits are

| Quantity | Value |
|---|---:|
| First-update activity $\mathcal A_0$ | 0.4999878099219305 |
| Second-update activity $\mathcal A_1$ | 0.5033297745470319 |
| Two-update average $\overline{\mathcal A}$ | 0.5016587922344812 |

The analytic inequalities in Theorem 3 establish the violation independently of these decimals. The rational certificate and reproduction code can additionally verify normalization, positivity, detailed balance, the graph properties, and the exact activity values.

*Figure 1. Left: the connected three-regular graph with energies from (12); the bridge joins vertices 4 and 9. Right: the first-update, second-update, and two-update mean activities. The dashed line is one half. Values are computed from the exact certificate; the vertical axis is enlarged to display the strict margins.*

## 4. Why the construction works

The two halves of the graph have widely separated bulk energies. During the first update, the bridge transition strongly favours movement from the high-energy side to state 4 on the low-energy side. Its two local downward transitions have a much smaller energy difference. Thus the first update raises the probability of state 4 above the uniform value and lowers the probability of state 9 below it.

The second, colder update strongly resolves the local unit energy differences as well. State 4 has two downhill neighbours and one uphill neighbour, so its exit probability is close to two thirds. State 9 has one downhill neighbour and two uphill neighbours, so its exit probability is close to one third. The previously increased mass is therefore located at the state that now has the larger exit probability. Contributions from the four vertices adjacent to the bridge endpoints have the opposite sign, but (18)–(19) show exactly that they are smaller in aggregate.

At either fixed temperature the chain has the usual Gibbs equilibrium and satisfies detailed balance. The violation comes from the change in temperature before the second activity is measured. Equation (8) isolates this effect in the cross-temperature inner product; there is no conflict with the equilibrium activity bound.

## 5. A structural family on graphs with a bridge

The ten-state example is one representative of a general obstruction.

### Theorem 4. Every regular bridge graph of degree at least three admits a violation

Let $G$ be a finite connected simple $d$-regular graph with $N$ vertices, where $d\ge3$. Suppose it contains a bridge. There exist an energy vector, a positive finite-temperature Gibbs initial distribution, and two strictly cooling updates for which both $\mathcal A_1>1/2$ and $\overline{\mathcal A}>1/2$. Such parameters can be chosen with all energy values distinct.

**Proof.** Removing the bridge separates the graph into components $V_-$ and $V_+$. Denote its endpoints by $s\in V_-$ and $t\in V_+$. For $0<\varepsilon<1/2$, set

$$
E_s=\varepsilon,\qquad E_t=1-\varepsilon,
\qquad E_i=0\ (i\in V_-\setminus\{s\}),
\qquad E_i=1\ (i\in V_+\setminus\{t\}).
\tag{26}
$$

Choose

$$
\beta_0=\varepsilon,
\qquad\beta_1=\varepsilon^{-1/2},
\qquad\beta_2=\varepsilon^{-2}.
\tag{27}
$$

For sufficiently small positive $\varepsilon$, these inverse temperatures are finite, positive, and strictly increasing. The initial Gibbs vector tends to $u$, since the energies stay bounded while $\beta_0\to0$.

At the first update, the bias contribution of every internal edge tends to zero because $\beta_1\varepsilon\to0$; the contribution of the bridge tends to its downhill sign because $\beta_1(1-2\varepsilon)\to\infty$. Consequently,

$$
f_{\beta_1}(s)\longrightarrow-\frac1d,
\qquad
f_{\beta_1}(t)\longrightarrow\frac1d,
\qquad
f_{\beta_1}(i)\longrightarrow0\quad(i\ne s,t).
\tag{28}
$$

At the second update both energy scales are resolved. Each endpoint has $d-1$ neighbours in its own component and one across the bridge, so

$$
f_{\beta_2}(s)\longrightarrow\frac{d-2}{d},
\qquad
f_{\beta_2}(t)\longrightarrow-\frac{d-2}{d}.
\tag{29}
$$

The other components of $f_{\beta_2}$ remain bounded, which is enough in view of (28). Therefore

$$
f_{\beta_2}^{\mathsf T}f_{\beta_1}
\longrightarrow-\frac{2(d-2)}{d^2}.
$$

For a uniform start, Lemma 1 gives

$$
\mathcal A_1^u\longrightarrow\frac12+\frac{d-2}{Nd^2},
\qquad
\mathcal A_0^u=\frac12.
\tag{30}
$$

The total-variation comparison (23) and stochastic contraction show that replacing $u$ by $\gamma_{\beta_0}$ changes each activity by a quantity tending to zero. Thus, for the single-parameter family (26)–(27), the actual Gibbs-start activities satisfy

$$
\mathcal A_0\longrightarrow\frac12,\qquad
\mathcal A_1\longrightarrow\frac12+\frac{d-2}{Nd^2},\qquad
\overline{\mathcal A}\longrightarrow\frac12+\frac{d-2}{2Nd^2}.
\tag{31}
$$

The last two limits are strictly above one half. Taking any sufficiently small but positive $\varepsilon$ gives the finite parameters claimed. No exchange of limits or temperature chosen after an infinite-time relaxation is used.

For such fixed finite parameters, all probabilities and activities are continuous functions of the energy vector and the inverse temperatures. Both inequalities are strict, so they hold on an open neighbourhood of that vector. Energy vectors with all entries distinct are dense; one can therefore make all energies distinct while preserving the two inequalities. $\square$

For degree three and ten states, (30) gives the limiting second-update activity $1/2+1/90$. The explicit finite instance of Theorem 3 uses simpler moderate parameters and does not claim to optimize this value.

The bridge hypothesis itself forces $d$ to be odd. Indeed, if deleting a bridge leaves a component with $v$ vertices and $e$ internal edges, then $dv=2e+1$. Thus even-degree regular graphs do not satisfy this hypothesis; a connected degree-two regular graph is a cycle and has no bridge. The theorem is a sufficient structural condition and makes no assertion about graphs without bridges.

## 6. Robustness and boundaries of the conclusion

The same continuity argument applies directly to Theorem 3. The counterexample is a strict inequality at finite temperatures, so it belongs to an open set of valid counterexamples. Small perturbations preserve the temperature ordering and the positivity of all edge transitions. Degenerate energies in (12) simplify the exact certificate; they are not essential to the failure.

The following boundaries are part of the result.

1. **The regular-neighbourhood model.** The construction obeys the general transition rule (2) on a connected three-regular graph. It does not provide a single-spin-flip Ising or SK instance, and it does not resolve a restriction of the conjecture to those graphs or Hamiltonians.
2. **The original time convention.** The violated quantity is $a_{\beta_2}^{\mathsf T}p_1$. Using the temperature that generated $p_1$ would define a different quantity.
3. **A finite Gibbs initial temperature.** Uniformity is used only in an auxiliary identity. The actual initial parameter is $q_0=10001/10000>1$.
4. **Two update steps.** This is sufficient to refute both a universal pointwise upper bound and a universal finite-horizon average upper bound. The initial update itself satisfies the pointwise bound by Lemma 2.
5. **No minimal-state claim.** The proof does not establish that ten states, degree three, or the listed energy range is minimal.
6. **Scope of the thermodynamic consequence.** The universal substitution of one half for the activity is unavailable under these assumptions. Bounds that retain the measured activity, and claims under additional structural conditions, require their own analysis and are not refuted here.

The local-passivity failure in [2] and the aggregate failure proved here are different statements. The former invalidates a sufficient proof mechanism; the latter invalidates the conjectured bound itself in the stated regular-neighbourhood setting. Any priority statement must be limited to the documented literature search accompanying this case.

## 7. Reproducibility and research status

The proof of Theorem 3 requires only finite graph arithmetic, the logistic transition formula, rational inequalities, and total-variation contraction. It supplies a human-readable route that does not depend on an exhaustive numerical search. The accompanying exact-arithmetic programs reconstruct the graph and distributions directly from (11)–(13). The author implementation and independent implementation do not import one another; both recompute the transition matrices and activities.

The computational certificate is a reproducibility aid. It is not a proof that this counterexample is minimal or optimal, and successful tests on other landscapes would not prove the original universal bound. The structural result in Theorem 4 is proved analytically. This document does not claim external peer review or proof-assistant coverage that has not actually been completed.

## References

1. Yutong Luo, Yi-Zheng Zhen, Xiangjing Liu, Daniel Ebler, and Oscar Dahlsten. *Bound on annealing performance from stochastic thermodynamics, with application to simulated annealing*. Physical Review E **108**, 054119 (2023). DOI: [10.1103/PhysRevE.108.054119](https://doi.org/10.1103/PhysRevE.108.054119). [arXiv:2311.10424v1](https://arxiv.org/abs/2311.10424), [full text](https://arxiv.org/html/2311.10424v1). Relevant locations: Section IV.1, Equations (30)–(32); Section IV.2, Equations (33), (38)–(41). The version page checked on 24 November 2026 listed v1, submitted on 17 November 2023.
2. trureturing / The Omega Institute. *Glauber annealing from a thermal state need not preserve neighbourhood passivity*. Undated public research record, accessed 24 November 2026. [Research record](https://www.trureturing.org/research/luo-zhen-liu-ebler-dahlsten-2023-neighbourhood-passivity-refutation/), [linked proof blueprint at commit 51dca4f1542baa532983864568d6a8ca3470e745](https://github.com/the-omega-institute/trureturing/blob/51dca4f1542baa532983864568d6a8ca3470e745/Blueprint/D5/S3/StatisticalMechanics/GlauberNeighbourhoodPassivityRefutation.md). Relevant locations: the finite Petersen-graph witness and the final scope discussion, which separates Equation (41) from Equation (39). No DOI, arXiv identifier, or individual authorship is supplied by the record. This is cited as public prior research, without representing it as a peer-reviewed publication or as verification of the present certificate.
