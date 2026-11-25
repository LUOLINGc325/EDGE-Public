# Exact offline contention resolution under limited independence

**Topic e95bfa6460687572b87d.** Lean verification is delivered separately.

## Abstract

A finite set of requests is activated according to a distribution with pairwise-independent indicators and total marginal load at most an integer capacity k. We determine the exact universal offline retention guarantee when the full joint law is known. If b is the unique nonnegative integer with b² < k ≤ (b+1)², the optimum is

$$
c_k=1-\frac{k+b(b+1)}{2k(2b+1)}.
$$

We strengthen this to simultaneous marginal guarantees c_k x_i+t_k x_i², where t_k=1/[2(2b+1)], and prove that this coefficient is also best possible at the optimal intercept. The guarantee extends to pairwise nonpositive covariances. Finite rational activation laws prove sharpness, and explicit three-wise-independent laws show that three-wise independence has exactly the same universal baseline.

We then change the information available to the rule. If the complete marginal vector is known but the joint law is unknown, and one kernel must work for every compatible pairwise-independent law, the exact universal value is

$$
\beta_k=1-\frac{k}{4k-2}.
$$

Uniform truncation attains the sharp refinement β_k x_i+x_i²/(4k−2). A family of pairwise-independent laws with identical marginals establishes the matching upper bound and an exact finite minimax theorem. For N independent full-set training samples, a quantitative obstruction of order N k/n persists. This yields a necessary sample count of order n epsilon/k to improve the known-marginal baseline by epsilon. All existence statements refer to actual probability laws on finite subsets and actual feasible randomized kernels.


For capacity one and each finite marginal vector of total load at most one, we determine the exact interval of possible union probabilities at every independence order. A truncated inclusion–exclusion law attains one endpoint on all subsets simultaneously. A second law attains the other endpoint on any prescribed subset by conditioning on an item with largest marginal. At even orders the entire distribution-oblivious region is attained by priority mixtures. At odd orders the exact law-aware region can strictly exceed the oblivious region, and there need not be a common law minimizing all subset coverages. We also prove an expected positive learning bound from correlated whole-set samples and compose the capacity guarantees over overlapping blocks.

## 1. Problem, models, and contribution boundaries

Let E be a finite labeled set and let D be a probability law on its subsets. Write x_i=Pr_D(i∈R), assume Σ_i x_i≤k, and require Pr_D(i,j∈R)=x_i x_j for every distinct i,j. Because the indicators are binary, this identity and the marginals give independence of all four binary cells. A feasible offline rule is a stochastic kernel K(I|R) with K≥0, Σ_I K(I|R)=1, and K(I|R)>0 only if I⊆R and |I|≤k. Its unconditional selection probability is Σ_R D(R)Σ_{I∋i}K(I|R). A balance guarantee c means this is at least c x_i for every coordinate. This unconditional definition includes x_i=0.

In the **known-law model**, the kernel may depend on D: for each admissible D there exists K_D. In the **known-marginal model**, the kernel may depend on x but must be the same for every D with that x: for every x there exists K_x such that every D∈PI(x) satisfies the guarantee. Both models permit observing the whole activated set before selection and permit arbitrary internal randomness. The order of these quantifiers is part of each theorem.

The original all-rank problem asks for the exact known-law optimum, including heterogeneous and zero marginals, finite sharpness witnesses and an implementing rule. The following parts address three-wise independence, the known-marginal information frontier, learning from independent whole-set samples, block capacities, and exact finite higher-order behavior at rank one.

### Relation to established results

Gupta, Hu, Kehne and Levin [G] give a known-law offline guarantee 1−O(k^(−1/3)) for uniform matroids and asymptotically approaching-one online guarantees. Our exact-optimum target refines that nonmatching bound; it is not described as a numbered conjecture of their paper. Their rank-one pairwise/three-wise results and constructions are established prior art.

Dughmi [D] supplies the general all-subset expected-rank characterization used by the operational bridge. Courtois and Denuit [CD] study sharp discrete stop-loss bounds from two and three moments. Ramachandra's thesis [R, Theorem 7 and Appendix A] gives the identical-marginal pairwise-independent extremal stop-loss law. The symmetric count construction and scalar moment method are therefore background tools. The candidate contribution is their sharp all-subset, heterogeneous-marginal contention-resolution consequence, its optimal affine refinement, and the information-constrained frontier.

Prior-independent impossibility and special-item constructions also occur in Dughmi [D, Theorem 3.18 and Lemma 3.20]. Our information result specifies a stricter adversarial class: genuine pairwise independence, the same known marginal vector for every adversarial law, and arbitrary rank. It does not claim that information dependence in contention resolution is a new concept. The product-law sampling model in [DLN] and the oblivious product-law model in [F] have different assumptions. Dughmi [D, Theorem 3.18 and Lemma 3.19] also proves finite-sample prior-independent impossibility for a more general class. The sample theorem here is a quantitative total-variation extension within a same-known-marginal PI family; it is not the first finite-sample impossibility result. The source search supports a bounded near-neighbor comparison, not a guarantee of global priority.

### Main theorem inventory

| ID | Mathematical conclusion | Essential bridge |
|---|---|---|
| T1 | Known-law guarantee c_k x_i+t_k x_i² | Every subset cut, then a genuine stochastic kernel |
| T2 | Exact c_k and optimal t_k | Finite actual pairwise-independent laws and capacity obstruction |
| T3 | Three-wise universal baseline is c_k | Valid five-label laws, full binary triple independence, finite error bound |
| T4 | Exact known-marginal β_k, sharp affine term and finite minimax | Same x and one fixed kernel across an entire adversarial family |
| T5 | Lower bound with independent training samples | Product total-variation transfer with independent testing |
| T6 | Learning feasible demands in expectation | Multiplicative weights and saved priority lists |
| T7 | Guarantees under several block capacities | Intersect block outputs and bound conditional rejection |
| T8 | Sharp finite coverage interval at rank one for every independence order | Truncated moment inversion and a largest-marginal conditional law |
| T9 | Exact even-order oblivious and odd-order law-aware regions, and strict odd-order separation | Priority mixtures, subset extrema and explicit incompatible laws |

The full-scope formalization must include all auxiliary probability, rounding, witness and limiting arguments used below. Arithmetic tests and a compiled scalar inequality alone do not verify these theorems.

# Part I. The known-law frontier and its construction

## 1. Parameters and statements

Fix an integer rank k >= 1. Let b be the unique nonnegative integer with

    b^2 < k <= (b+1)^2.

Thus b = ceil(sqrt(k))-1. Set

    t_k = 1 / [2(2b+1)],
    delta_k = [k+b(b+1)] / [2k(2b+1)],
    c_k = 1-delta_k.

The alternative b=floor(sqrt(k)) gives the same c_k at square k, but gives a smaller t_k there. The lower adjacent interval is needed for the best affine marginal correction. In particular k=1 has b=0, c_1=t_1=1/2.

Let E be a finite ground set and D a known probability distribution on its subsets. Write x_i=P(i in R), and suppose sum_i x_i <= k and the indicators are pairwise independent. Then an offline randomized rule can satisfy simultaneously

    pi_D(R) subset R, |pi_D(R)| <= k,
    P(i in pi_D(R)) >= c_k*x_i + t_k*x_i^2   for every i in E.       (1)

The statement also holds under the weaker assumption

    P(i,j in R) <= x_i*x_j for all distinct i,j,                  (2)

because that is the only dependence inequality used. This is pairwise nonpositive covariance, not an assumption of full negative association.

The intercept c_k is the largest universal balance constant. With this intercept fixed, t_k is the largest universal coefficient in a guarantee of the form (1). Both sharpness claims have finite pairwise-independent witness families below.

## 2. The scalar moment lemma

Let S be a finitely supported nonnegative integer-valued random variable. Write

    mu = E S,  q >= 0,  v = E (S-mu)^2.

Suppose 0 <= mu <= k and v <= mu-q. Then

    E (S-k)_+ <= delta_k*mu - t_k*q,                            (3)

or, equivalently,

    E min(S,k) >= c_k*mu + t_k*q.                              (4)

The finite-support assumption is sufficient for the application and avoids any integrability issue. Only the finite-support formulation is used or asserted here.

### 2.1 The lattice majorant (valid also when b=0)

For every integer z,

    z_+ <= (z+b)(z+b+1) / [2(2b+1)].                        (5)

If z<=0, the right side is nonnegative because the product of consecutive integers is nonnegative. If z>=0, the difference between the numerator and 2(2b+1)z is (z-b)(z-b-1), again a product of consecutive integers. Equality occurs at z in {-b-1,-b,b,b+1}, with repeated points merged when b=0.

### 2.2 A unified two-regime proof

The proof includes k=1 without a separate argument.

Write

    d = k-mu >= 0,
    V = mu-q >= v >= 0,
    h = 2b+1 > 0,
    A = b(b+1)/k,
    t = 1/(2h).

The desired upper bound is t*(V+A*mu). We have A<=b<h/2. Indeed it is trivial if b=0; otherwise the integer inequality b^2<k gives k>=b^2+1>=b+1.

**Near-capacity regime d<=h/2.** Taking the expectation in (5), with z=S-k, gives

    E(S-k)_+ <= t*[v+d^2-h*d+b(b+1)]
                <= t*[V+d^2-h*d+b(b+1)].

Since mu=k-d, the difference between the last bracket and V+A*mu is exactly

    d^2-h*d+b(b+1)-A*(k-d) = d*(d-h+A).

This is nonpositive: d>=0, d<=h/2 and A<=h/2. Thus the target bound holds.

**Below-capacity regime d>=h/2.** Here d>0. For every real s,

    4d(s-k)_+ <= (s-mu)^2.                                 (6)

For s<=k this is square nonnegativity. For s>=k, subtracting the left side gives (s-k-d)^2. Taking expectations and using d>=h/2 gives

    E(S-k)_+ <= v/(4d) <= V/(4d)
                <= V/(2h) = t*V <= t*(V+A*mu).

This completes (3). No division by mu, no nonzero-marginal hypothesis and no limiting argument enter the upper bound. In particular mu=0 and k=1 are included.

## 3. Heterogeneous Bernoulli counts

For A subset E put S_A=|R intersection A|, mu_A=sum_{i in A} x_i and q_A=sum_{i in A} x_i^2. Pairwise independence gives the exact identity

    Var(S_A) = mu_A - q_A.

Under (2) it gives the inequality Var(S_A)<=mu_A-q_A. Since mu_A<=k, the scalar lemma proves

    E min(|R intersection A|,k)
      >= sum_{i in A} [c_k*x_i+t_k*x_i^2]                    (11)

for EVERY A, including the empty set and subsets consisting entirely of zero-marginal elements. This is the required all-subsets statement, not just a bound for the whole ground set.

Notice that delta_k>=t_k, so c_k+t_k*x_i<=1 whenever 0<=x_i<=1. Thus the proposed elementwise demand never exceeds its availability.

## 4. Operational bridge by a finite flow network

This section gives a self-contained specialization of the established rank characterization (Dughmi, ICALP 2020, Theorem 3.6). It is not claimed as a new general duality theorem.

The parameters obey 0<t_k and 1/2≤c_k≤1: writing B=b(b+1), the bound B/k≤b gives delta_k≤(b+1)/(2(2b+1))≤1/2. Thus every demand is nonnegative.

Enumerate the positive-probability outcomes as R_1,...,R_m with masses p_j. Put d_i=c_k*x_i+t_k*x_i^2. Construct a network with source s, an element node for each i, an outcome node for each j, and sink z:

- s -> i has capacity d_i;
- i -> j exists when i in R_j and has capacity p_j;
- j -> z has capacity k*p_j.

Fix the elements A placed on the source side of a cut. Each outcome node can independently be placed on whichever side is cheaper; its minimum contribution is p_j*min(k,|R_j intersection A|). Hence the minimum cut with this element set is

    sum_{i not in A} d_i + sum_j p_j min(k,|R_j intersection A|).

By (11), every cut is at least sum_i d_i. The source capacities total exactly this amount, so max-flow/min-cut supplies a flow saturating every source-to-element edge. Write its element-outcome flow as f_ij. Then

    0<=f_ij<=p_j,     sum_i f_ij<=k p_j,     sum_j f_ij=d_i.

Conditional on outcome R_j define y_ij=f_ij/p_j. This is a vector in [0,1]^{R_j} with sum_i y_ij<=k. The rounding lemma in the next section gives a genuine distribution on subsets of R_j of size at most k with coordinate marginals y_ij. Composing the outcome and conditional rounding yields (1), with equality in its unconditional marginals.

For arbitrary real masses this is a finite real-capacity existence argument. For explicit rational support, all capacities and the resulting flow can be chosen rational, so the construction below is exactly implementable.

## 5. Finite rounding with at most |R_j|+1 conditional outcomes

Here is an explicit uniform-matroid rounding construction; a scalar inequality alone would not furnish a CRS.

Order the available elements and let y_1,...,y_r be their desired conditional marginals. Form cumulative sums s_0=0, s_i=sum_{h<=i} y_h, so s_r<=k. Place the half-open intervals [s_{i-1},s_i) consecutively on the real line.

For u in [0,1), select element i exactly when [s_{i-1},s_i) contains u+z for some integer z. Each interval has length at most one, so contains at most one such point. The union is [0,s_r); it contains at most ceil(s_r)<=k of these points. Thus every selected set is feasible.

The set of u selecting i is the interval [s_{i-1},s_i) projected modulo one, whose total length is y_i. One may avoid continuous randomness entirely: partition [0,1] at the fractional parts of s_0,...,s_r, take one interior representative from each positive-length piece, and give its fixed selected set the weight equal to that piece's length. There are at most r+1 pieces. These finite weights sum to one and give every coordinate marginal exactly y_i. Endpoints have no assigned positive mass.

For rational y_i choose a common denominator Q and write cumulative integer endpoints c_i=Q*s_i. Use breakpoints {0,Q} union {c_i mod Q}. For each adjacent pair a<a', choose integer residue u=a and assign weight (a'-a)/Q. Select i iff some integer z satisfies c_{i-1}<=u+zQ<c_i. This representation does not enumerate Q residues; it has O(r) breakpoints even when Q is large.

### Computational model

The delivered implementation takes an explicitly listed finite support with rational masses, an integer capacity and labeled elements. It represents all numbers as exact integer fractions, uses a finite max-flow construction, and materializes the finite conditional kernels by the rational cyclic procedure above. This is an explicit-support, exact-arithmetic model; the support may be exponentially large in |E|. No sampling-oracle or polynomial-in-|E| implementation for a succinct unknown distribution is asserted. The mathematical construction gives a valid kernel for arbitrary real masses; the Python program is separately exercised by exact finite tests and is not claimed to be a verified compiler extraction.

## 6. Finite sharpness witnesses, including the optimal affine slope

Let ell>=2 be an integer, set n=ell*k^2 and p=k/n, and use the same b as above. Let

    v = k-1/ell,
    theta = (v-b^2)/(2b+1).

Because k-b^2 is a positive integer and ell>=2, 0<theta<1. (The upper inequality follows from v<k<=(b+1)^2.) Define a centered integer random variable D0 with symmetric masses

    P(D0=+b)=P(D0=-b)=(1-theta)/2,
    P(D0=+(b+1))=P(D0=-(b+1))=theta/2.

When b=0, the two masses at zero are added. Put S=k+D0. Its possible values are nonnegative and at most k+b+1<=n. Its mean is k and its variance is v. Conditional on S=s, choose R uniformly from the s-subsets of [n]. The inclusion probabilities satisfy

    P(i in R)=E S/n=k/n=p,
    P(i,j in R)=E[S(S-1)]/[n(n-1)]
              =[k^2-k+v]/[n(n-1)]
              =[k^2-1/ell]/[n(n-1)]=p^2.

Thus the actual finite indicators are pairwise independent. All four cardinality points are equality points of the lattice majorant, and

    E(S-k)_+ = [v+b(b+1)]/[2(2b+1)]
               = k*delta_k - t_k*k^2/n.

Consequently

    E min(S,k)/k = c_k+t_k*k/n.                             (12)

Every feasible rule has E|I|<=E min(S,k). If every element had conditional inclusion probability at least c, then E|I|>=c*np=c*k. Therefore its best balance is at most the right side of (12). Selecting a uniformly random min(S,k)-subset of R achieves that balance by exchangeability, so (12) is the exact optimum for this finite family.

As ell tends to infinity, k/n tends to zero. Thus no universal intercept larger than c_k is possible. Moreover if a universal guarantee c_k*x_i+t*x_i^2 held with t>t_k, its total required selected size on ANY of these finite witnesses would strictly exceed E min(S,k). Thus t_k is the largest possible slope at the optimal intercept c_k, with a finite exact obstruction for every larger slope.

The family proves sharpness by a sequence for the intercept; it does not claim that a finite instance attains c_k itself. Indeed (1) already implies every finite instance with a nonzero marginal has best balance strictly greater than c_k, since there are finitely many positive x_i.


# Part II. Three-wise independence

Let `k>=1` and let `b>=0` satisfy `b^2<k<=(b+1)^2`. Write

$$
a=b+1,\quad h=2b+1,\quad B=b(b+1),\quad
t_k=1/(2h),\quad c_k=1-(k+B)/(2kh).
$$

For every integer `n>=8k^2`, define rational numbers

$$
L=n-k,\quad v=k(1-k/n),\quad
\gamma=v(1-2k/n),
$$

$$
\eta=\frac{\gamma}{L(L^2-a^2)},\quad
u=\frac{v-b^2-\eta(L^2-b^2)}{h},\quad
\delta=\frac{\eta L}{2a}.
\tag{A1}
$$

Define a five-label count law for `T=S-k` by

| Offset | Weight |
|---|---:|
| `-b` | `(1-eta-u)/2` |
| `+b` | `(1-eta-u)/2` |
| `-a` | `u/2+delta` |
| `+a` | `u/2-delta` |
| `L` | `eta` |

When `b=0` the first two labels describe one atom. Conditional on `S`, choose
a uniformly random `S`-subset of `[n]`.

## A. Validity of every weight

We have `a<=k` and `L=n-k>=7k`. Hence `L>a`, all denominators are positive,
all count points are in `[0,n]`, and `0<gamma<=k`. Moreover

$$
L^2-a^2\ge L^2/2,\qquad
0<\eta\le 2k/L^3<1.
\tag{A2}
$$

The first inequality follows from `a<=k<=L/7`, which is stronger than needed.
Since `k-b^2>=1` and `k^2/n<=1/8`,

$$
v-b^2\ge 7/8,
\qquad \eta L^2\le 2k/L\le2/7.
$$

Therefore

$$
u h=v-b^2-\eta(L^2-b^2)\ge 7/8-2/7=33/56>1/2.
\tag{A3}
$$

The inner weight is nonnegative because

$$
h(1-\eta-u)=a^2-v+\eta(L^2-a^2)>0.
\tag{A4}
$$

To bound the outer positive-side weight, observe

$$
2h\eta L\le 4hk/L^2\le4h/(49k)
\le8a/(49k)\le a.
$$

Thus `eta L/a<=1/(2h)<=u`, so `u/2-delta>=0`. The other outer weight is
positive. The five weights sum to one. This verifies a finite probability
law without any appeal to asymptotic positivity.

## B. Exact first three moments and three-wise independence

Direct calculation gives

$$
\mathbb ET=-2a\delta+\eta L=0,
$$

$$
\mathbb ET^2=(1-\eta-u)b^2+ua^2+\eta L^2=v,
$$

$$
\mathbb ET^3=-2a^3\delta+\eta L^3
=\eta L(L^2-a^2)=\gamma.
\tag{A5}
$$

Consequently

$$
\mathbb ES=k,\quad
\mathbb E(S)_2=(n)_2(k/n)^2,\quad
\mathbb E(S)_3=(n)_3(k/n)^3,
\tag{A6}
$$

where `(s)_r=s(s-1)...(s-r+1)`. For the last equality, expand

$$
\mathbb E(S)_3
=k(k-1)(k-2)+(3k-3)v+\gamma
=k^3(1-3/n+2/n^2).
$$

Uniform-layer sampling is exchangeable, so the probability that any specified
`r` distinct coordinates all equal one is `E(S)_r/(n)_r` for `r=1,2,3`.
Equation (A6) therefore gives `(k/n)^r`. For a specified binary pattern on
at most three coordinates, inclusion-exclusion over its zero coordinates
gives the full product probability. Hence the actual indicator family is
three-wise independent, not merely pairwise independent.

## C. Exact optimal balance and finite approximation error

By exchangeability, uniform truncation is an optimal balanced offline rule,
as established in Part I, Section 6. Its overflow is

$$
\begin{aligned}
\mathbb E T_+
&=\frac{(1-\eta-u)b+ua}{2}-a\delta+\eta L\\
&=\frac{v+B-\eta(L-b)(L-a)}{2h}\\
&=\frac{v+B-\gamma(L-b)/(L(L+a))}{2h}.
\end{aligned}
\tag{A7}
$$

Thus the exact optimal balance is

$$
c^{(3)}_{k,n}
=c_k+t_k\frac{k}{n}
+\frac{t_k\gamma(L-b)}{kL(L+a)}.
\tag{A8}
$$

All terms in the correction are nonnegative. Since `gamma<=k`, `L-b<=L+a`,
and `L=n-k>=n/2`,

$$
0<c^{(3)}_{k,n}-c_k
\le t_k\frac{k}{n}+\frac{t_k}{L}
\le t_k\frac{k+2}{n}.
\tag{A9}
$$

For any positive proposed improvement over `c_k`, choosing an integer
`n>=8k^2` large enough in (A9) gives an explicit finite three-wise-independent
counterexample. Conversely the PI lower-bound theorem applies automatically
to every three-wise-independent law. Therefore, by Theorem T1, the universal three-wise constant
is exactly the same `c_k` for every rank.

The result does not assert that the best affine marginal correction for the
three-wise class equals `t_k`; the construction proves equality of the
worst-rank baseline only.

## D. Rank-one literature boundary

For `k=1`, `b=0`, `a=1`, simplification gives `eta=1/n^3` and

$$
\begin{aligned}
\Pr(S=0)&=(n^3-2n^2+3n-2)/(2n^3),\\
\Pr(S=1)&=(2n-2)/n^2,\\
\Pr(S=2)&=(n-1)^2/(2n^2),\\
\Pr(S=n)&=1/n^3.
\end{aligned}
$$

This is exactly Gupta–Hu–Kehne–Levin's existing rank-one three-wise hard
instance. Novelty, if verified, concerns the all-rank extension and its
connection to the exact rank-dependent constant, not the tail-atom technique.


Courtois–Denuit [CD, §3, Proposition 3.2] already studies third-moment discrete stop-loss extremizers with a distant endpoint atom. This proof uses that classical moment perspective; its all-rank contention-resolution conclusion is the claim under consideration.

# Part III. The exact value of marginal information

## 1. Model and quantifier order

Fix rank k>=1. For a finite labeled ground set E and vector x in [0,1]^E with sum x_i<=k, let PI(x) be all distributions on subsets of E whose inclusion indicators are pairwise independent and have exactly the marginal vector x.

A marginal-only offline rule is a stochastic kernel K_x(I|R), supported on I subset R with |I|<=k, which can use E, k, x and the observed R. It does not receive the joint law D or independent samples from D. Its random bits are independent of D and R except through its input. It is one fixed kernel for all laws in PI(x).

The universal constant beta_k is defined by the quantifier order

    for every finite E and x with sum x_i<=k,
    there exists ONE feasible kernel K_x,
    for EVERY D in PI(x),
    for EVERY i in E:
      P_{D,K_x}(i selected) >= beta_k*x_i.                  (M)

Zero marginals are interpreted through this unconditional inequality. For x_i>0 it is equivalent to the conditional survival guarantee. The order exists K_x before for all D is essential. In the known-law problem the kernel is allowed to depend on D; interchanging these quantifiers is a different problem.

## 2. Exact coefficient and a sharp marginal correction

Define

    v_k = 1/(4k-2),
    beta_k = 1-k/(4k-2) = 3/4 - 1/(8k-4).

Then beta_k is the largest possible coefficient in (M). Moreover a single rule, independent even of x, guarantees

    P(i selected) >= beta_k*x_i + v_k*x_i^2.                (13)

At the fixed optimal intercept beta_k, the coefficient v_k is best possible among universal affine conditional bounds beta_k+v*x_i. The upper guarantee continues to hold under pairwise nonpositive covariance; the matching impossibility family is exactly pairwise independent.

## 3. Achievability: uniform truncation

Given R, retain all of it if |R|<=k and otherwise choose a uniformly random k-subset. Thus for every i in R,

    P(i selected | R) = f_k(|R|),
    f_k(s) = min(1,k/s), s>=1.

For every positive integer s,

    f_k(s) >= 1-(s-1)/(4k-2).                               (14)

For s<=k this follows from s-1>=0. For s>=k, multiply by the positive number s(4k-2): the difference is

    s(s-1)-(4k-2)(s-k) = (s-2k)(s-2k+1) >= 0,

a product of consecutive integers. Besides s=1, equality is attained at s=2k-1 and s=2k whenever applicable.

For x_i>0, pairwise independence gives

    E[|R|-1 | i in R] = sum_{j!=i} x_j <= k-x_i.

Taking the conditional expectation of (14) yields

    P(i selected | i active) >= 1-(k-x_i)/(4k-2)
                               = beta_k+v_k*x_i.

Multiplying by x_i proves (13); x_i=0 is immediate. The proof only needs P(i,j active)<=x_i*x_j, which proves the stated extension.

Equivalently, the finite cyclic rounding construction in Part I applied to the vector y_i=f_k(|R|) gives a kernel with at most |R|+1 outcomes and exactly these same inclusion marginals. The latter is convenient for exact finite verification and is the implementation checked in the reference implementation.

## 4. A family of pairwise-independent laws with identical marginals

Let n>=2k(k+1) be an integer and take E=[n]. Define

    p=k/n,
    m=(n-1)p=k-p,
    r=2k-1,
    alpha=m/r,
    theta=k(n-2k)/(n-k)=k(1-2p)/(1-p).

For each label i in [n], define an indexed family member D_i as follows; the laws need not be distinct when k=1. First let the special indicator B_i be Bernoulli(p). Conditional on B_i, choose a common-element count T:

    B_i=1:  T=0 with probability 1-alpha,
            T=r with probability alpha.

    B_i=0:  T=0 with probability w_0,
            T=k with probability w_k,
            T=k+1 with probability w_{k+1},

where

    w_k     = m(k-theta)/k,
    w_{k+1} = m(theta-k+1)/(k+1),
    w_0     = 1-w_k-w_{k+1}.

Given T=t, choose a uniformly random t-subset of [n]\{i}. Include i exactly when B_i=1. This defines an actual finite distribution on subsets; the following moment computations refer to this distribution, not an assumed abstract count law.

### 4.1 All probabilities are valid

Because p<=1/[2(k+1)], we have p<1 and 0<=alpha<=1. The three probabilities in the B_i=0 branch can equivalently be written

    w_k     = m*p/(1-p),
    w_{k+1} = m*[1-(k+1)p]/[(k+1)(1-p)],
    w_0     = [1-kp]/[(k+1)(1-p)].                         (15)

Their numerators and denominators are nonnegative/positive, and their sum is one. The requested cardinalities 0,r,k,k+1 are all at most n-1. These observations cover k=1 as well.

### 4.2 First and second moments

Both conditional count laws have the same mean:

    E[T|B_i=1]=alpha*r=m,
    E[T|B_i=0]=k*w_k+(k+1)*w_{k+1}=m.                      (16)

Their factorial second moments are

    E[T(T-1)|B_i=1]=m(r-1)=m(2k-2),
    E[T(T-1)|B_i=0]=m*theta.                               (17)

For a fixed common element j, symmetry and (16) give

    P(j active | B_i=b)=m/(n-1)=p, b in {0,1}.

Thus j has marginal p and is independent of B_i. For two distinct common elements j,l, uniform sampling at a fixed cardinality and (17) give

    P(j,l active)
      = m[p(2k-2)+(1-p)theta]/[(n-1)(n-2)]
      = m(n-2)p/[(n-1)(n-2)] = p^2.                        (18)

The central equality follows from

    p(2k-2)+(1-p)theta = k-2p = (n-2)p.

Every D_i therefore belongs to the SAME class PI(x) with x=(p,...,p), and its total load is np=k. The special label can change the higher-order dependence structure while leaving every marginal and pairwise probability fixed; at k=1 all family members coincide.

## 5. The same-kernel impossibility argument

Fix an arbitrary feasible stochastic kernel K_x for the vector x=(p,...,p). Define

    y_i(R)=P_{K_x}(i selected | input R).

These numbers are fixed before an adversarial D_i is selected. They obey

    0<=y_i(R)<=1,  y_i(R)=0 if i not in R,
    sum_{i in R} y_i(R)<=k.                                (19)

Let g_i be the conditional survival probability of the special item i when R is drawn from D_i. Conditional on i being active, R is its singleton with probability 1-alpha, and is a uniformly random 2k-subset containing i with probability alpha. Hence, writing C=binom(n-1,2k-1),

    g_i=(1-alpha)y_i({i})
         + (alpha/C) sum_{R: |R|=2k, i in R} y_i(R).        (20)

Average (20) over special labels and use y_i({i})<=1:

    (1/n)sum_i g_i
      <= 1-alpha + alpha/(n*C)
           * sum_{R: |R|=2k} sum_{i in R} y_i(R)
      <= 1-alpha + alpha*k*binom(n,2k)/(n*C)
       = 1-alpha/2
       = beta_k + p/(4k-2).                                (21)

The binomial identity n*binom(n-1,2k-1)=2k*binom(n,2k) is the only counting identity used. Therefore for this one fixed K_x there exists at least one special label i such that

    P_{D_i,K_x}(i selected | i active)
       <= beta_k+v_k*p.                                   (22)

**This is not a mixture-of-laws argument.** We do not replace the D_i by their average and do not let the algorithm choose a different kernel for each law. We have proved exactly

    for every single K_x, there exists i such that (22) holds for D_i.

Since all D_i have the same x, the algorithm cannot evade the conclusion by using the supplied marginal vector to identify the special label.

## 6. Sharpness consequences

The uniform truncation rule attains g_i=1-alpha/2 on each law D_i for its special item: it retains the singleton with probability one and any member of a 2k-set with probability one-half. Its general guarantee (13) also bounds every nonspecial element. Thus the exact value of this finite family game is

    sup_K min_{i,j} P_{D_i,K}(j selected | j active)
        = beta_k+v_k*p.                                   (23)

The lower side in (23) is supplied by uniform truncation, and the upper side by choosing j=i in (22).

In fact the same exact finite value holds over the entire class of pairwise-independent laws with this common marginal vector. Define PI_n(p) to consist of every law on subsets of [n] with marginals p and pairwise independence. Since the lower bound (13) holds for every member of PI_n(p), while each D_i is a member, we obtain

    sup_K inf_{D in PI_n(p)} min_j
        P_{D,K}(j selected | j active)
      = beta_k+v_k*p,    p=k/n, n>=2k(k+1).                (24)

The kernel in (24) is one fixed feasible kernel for the supplied vector (p,...,p). Uniform truncation attains the supremum. Equation (24) is an exact finite information-constrained minimax theorem, in addition to the universal asymptotic obstruction.

Let n tend through integers satisfying n>=2k(k+1). Then p=k/n tends to zero. For every c>beta_k choose a finite such n with beta_k+v_k*k/n<c. Equation (22) rules out a c-guarantee, proving that beta_k is the universal optimum.

Likewise, at the fixed intercept beta_k, a proposed affine coefficient v>v_k would require survival at least beta_k+v*p for EVERY item under EVERY D_i. This is contradicted by (22) at any of these finite n. Therefore v_k is the best coefficient in (13).

## 7. Comparison with the known-joint-law optimum

The first theory block gives

    c_k=1-[k+b(b+1)]/[2k(2b+1)],  b=ceil(sqrt(k))-1,

when the rule knows D. This second block gives

    beta_k=1-k/(4k-2)

when it knows x but not D. For example:

| k | known law c_k | known marginals beta_k |
|---|---:|---:|
| 1 | 1/2 | 1/2 |
| 2 | 2/3 | 2/3 |
| 3 | 13/18 | 7/10 |
| 4 | 3/4 | 5/7 |
| 9 | 5/6 | 25/34 |
| 16 | 7/8 | 23/31 |

The constants agree at ranks one and two and separate for every k>=3. To see the latter without a delicate asymptotic argument, k=3 follows from the table. For k>=4 the exact formula gives c_k>=3/4, whereas beta_k<3/4. For b>=2, the inequality c_k>=3/4 follows from 2b(b+1)<=(2b-1)k and k>=b^2+1; the remaining k=4 case is equality. The known-law coefficient tends to one: for b>=1, b(b+1)/k<=(b+1)/b<=2, so 0<=1-c_k<=3/[2(2b+1)], and b tends to infinity with k. The explicit formula beta_k=3/4-1/(8k-4) tends to 3/4. These all-rank comparisons and limits are included in the formal scope.


# Part IV. A lower bound for learning the dependence structure

## 1. Learning model and the exact quantifier order

Fix integers `k>=1`, `n>=2k(k+1)`, and `N>=0`. Put

$$
p=k/n>0,\qquad \nu_k=1/(4k-2),\qquad
\beta_k=1-k/(4k-2).
$$

The learner knows the labeled set `[n]`, the rank `k`, the marginal vector
`x=(p,...,p)`, and the sample count `N`. It may also know the entire family
of candidate laws described below, but is not told which family member is
the actual law. The learner receives `N` independent complete active sets

$$
Z=(R_1,\ldots,R_N)\sim D^{\otimes N}.
$$

It then sees a fresh independent test set `R~D` and returns `I subset R` with
`|I|<=k`. Randomized training, random internal state, and randomized test-time
selection are all allowed. Averaging internal randomness gives one finite
kernel

$$
K(I\mid z,R),\qquad z\in(2^{[n]})^N,\ R,I\in2^{[n]},
\tag{S1}
$$

which is fixed before the true law is chosen and is supported on feasible
`I`. This finite-kernel model places no computational restriction on the
learner and allows arbitrary real transition probabilities.

For a law `D_i` and its special label `i`, define its training-averaged
conditional retention by

$$
g_i(K)=\Pr_{Z\sim D_i^N,\ R\sim D_i,\ K}
       (i\in I\mid i\in R).
\tag{S2}
$$

Here the training and test sets are independent. The theorem proves

$$
\boxed{\quad
\begin{gathered}
\text{For every ONE learner }K,\ \text{there exists }i\in[n]\text{ such that}\\
g_i(K)\le\beta_k+\nu_kp+2Np.
\end{gathered}
\quad}
\tag{S3}
$$

The adversarial law is the single fixed `D_i` selected in this statement;
it does not change between the training and test phases.

## 2. The genuine finite PI family

Write

$$
m=(n-1)p,\quad r=2k-1,\quad \alpha=m/r,
$$

$$
w_k=\frac{mp}{1-p},\qquad
w_{k+1}=\frac{m[1-(k+1)p]}{(k+1)(1-p)},\qquad
w_0=\frac{1-kp}{(k+1)(1-p)}.
\tag{S4}
$$

For each label `i`, let `Q_i` choose a count in `{0,k,k+1}` with probabilities
`w_0,w_k,w_{k+1}`, then choose that many elements uniformly from `[n]\{i}`.
Let `H_i` choose `{i}` with probability `1-alpha`, and otherwise a uniformly
random `2k`-subset containing `i`. Define

$$
D_i=(1-p)Q_i+pH_i.
\tag{S5}
$$

The support of `Q_i` excludes `i`, and that of `H_i` includes `i`. Hence
`H_i` is exactly the conditional test law `D_i( . | i in R)`.

For completeness, this is the same actual PI family as in Part III.
Since `p<=1/[2(k+1)]`, all weights are nonnegative, `0<=alpha<=1`, and the
three weights in (S4) sum to one. All requested counts are at most `n-1`.
Both branches have expected number of common elements equal to `m`. Thus
each common element has probability `m/(n-1)=p` in each branch and is
independent of the special indicator. If

$$
\theta=k(1-2p)/(1-p),
$$

the common-count factorial second moments in the `H_i` and `Q_i` branches
are respectively `m(2k-2)` and `m theta`. Their mixture is

$$
m[p(2k-2)+(1-p)\theta]=m(n-2)p.
$$

Dividing by `(n-1)(n-2)` gives `p^2` for every pair of distinct common
indicators. The special/common pairs also have joint probability `p^2`.
For binary indicators these `11` probabilities and the marginals determine
all four cells, so every `D_i` is pairwise independent with the same vector
`x=(p,...,p)` and total load `k`.

## 3. A common comparison law and its exact distances

Define `Q` on the **whole** set `[n]`: choose the same count weights
`w_0,w_k,w_{k+1}` as in (S4), and then a uniform subset of that size from
`[n]`. The comparison law `Q` need not be PI, need not have marginals `p`,
and is not asserted to be an admissible test law. It is used only to compare
training distributions.

For laws `P,Q` on a finite set, use

$$
\operatorname{TV}(P,Q)=\tfrac12\sum_\omega|P(\omega)-Q(\omega)|
=\sum_\omega(P(\omega)-Q(\omega))_+.
\tag{S6}
$$

### Lemma S1: excluding one label without changing the count weights

$$
\operatorname{TV}(Q_i,Q)=m/n.
\tag{S7}
$$

**Proof.** For a fixed count `s<n`, the uniform `s`-subset of `[n]` includes
`i` with probability `s/n`. The uniform `s`-subset avoiding `i` has zero
mass on that event, and its probability at every subset avoiding `i` is
at least the corresponding whole-ground-set layer probability. Its TV
distance from that layer is therefore exactly `s/n`. Distinct count layers
have disjoint supports, so weighted addition gives

$$
\operatorname{TV}(Q_i,Q)=\sum_s w_s\frac{s}{n}
=\frac{kw_k+(k+1)w_{k+1}}n=\frac mn.
$$

This argument preserves the weights `w_s` separately on every layer.
In particular, `Q_i` is generally **not** the ordinary conditional law
`Q( . | i absent)`, whose count weights would instead be proportional to
`w_s(1-s/n)`. QED.

The supports of `Q_i` and `H_i` are disjoint, so (S5) gives
`TV(D_i,Q_i)=p`. The triangle inequality and (S7) imply

$$
\operatorname{TV}(D_i,Q)\le p+m/n\le2p.
\tag{S8}
$$

The bound is independent of `i`. A more precise formula is also available.

### Lemma S2: exact distance to the common law

$$
\delta_{k,n}:=\operatorname{TV}(D_i,Q)=
\begin{cases}
p/2,& k=1,\\
p+w_{k+1}/n,& k\ge2.
\end{cases}
\tag{S9}
$$

**Proof for `k>=2`.** The `H_i` count layers `{1,2k}` are disjoint from
the `Q` layers `{0,k,k+1}`, so their total positive mass in `D_i-Q` is `p`.
On a `Q_i` set of size `s` avoiding `i`,

$$
Q(R)=(1-s/n)Q_i(R),\quad
D_i(R)-Q(R)=(s/n-p)Q_i(R).
$$

This is negative at `s=0`, zero at `s=k`, and positive at `s=k+1`, with
total positive mass `w_{k+1}/n`. On sets containing `i` in the `Q` layers,
the difference is nonpositive. Summing positive mass proves the second line.

For `k=1`, the weights are `w_0=1/2`, `w_1=p`, `w_2=1/2-p` with `p=1/n`.
Each `D_i` is in fact the same exchangeable law: empty-set mass `(1-p)/2`,
mass `p^2` at each singleton, and mass `p^2` at each pair. Relative to `Q`,
the singleton masses agree, the empty mass decreases by `p/2`, and the
combined pair mass increases by `p/2`. This gives the first line. QED.

For `k>=2`, (S9) in particular gives the improvement

$$
\delta_{k,n}\le (k+1)/n\le2k/n=2p.
\tag{S10}
$$

## 4. Products and bounded statistical decisions

Two elementary finite-probability facts will be used.

**Bounded-function inequality.** If `0<=f<=1`, then

$$
\left|\sum fP-\sum fQ\right|\le\operatorname{TV}(P,Q).
\tag{S11}
$$

To see this, split the signed difference into its positive and negative
parts, both of total mass TV. Multiplication by a number in `[0,1]` cannot
increase either one-sided sum.

**Product inequality.** For every integer `N>=0`,

$$
\operatorname{TV}(P^{\otimes N},Q^{\otimes N})
\le1-[1-\operatorname{TV}(P,Q)]^N
\le N\operatorname{TV}(P,Q).
\tag{S12}
$$

For a finite law, `1-TV(P,Q)=sum min(P,Q)`. At every tuple,
`min(product P,product Q)>=product min(P,Q)`. Summing this pointwise
inequality proves the first bound in (S12). The second is the elementary
Bernoulli inequality `(1-delta)^N>=1-N delta`, valid for `0<=delta<=1`.
When `N=0`, both product laws are the point mass on the empty tuple, and the
bound gives zero, as required.

Combining (S9) and (S12), put

$$
\Delta_N=1-(1-\delta_{k,n})^N.
$$

Then every training distribution satisfies

$$
\operatorname{TV}(D_i^N,Q^N)\le\Delta_N
\le N\delta_{k,n}\le2Np.
\tag{S13}
$$

## 5. Replacing only the training distribution

For the one fixed learner kernel (S1), let

$$
y_j(z,R)=\sum_{I:j\in I}K(I\mid z,R).
$$

For every `(z,R)`, `0<=y_j<=1`, `y_j=0` outside `R`, and
`sum_j y_j(z,R)<=k`. For each possible special label, define

$$
f_i(z)=\sum_R H_i(R)y_i(z,R)\in[0,1].
\tag{S14}
$$

Because training and test sets are independent, conditioning the test set
on `i active` leaves the training law unchanged. Therefore

$$
g_i(K)=\sum_z D_i^N(z)f_i(z).
\tag{S15}
$$

Let

$$
\widetilde g_i=\sum_z Q^N(z)f_i(z).
$$

Equations (S11) and (S13) yield

$$
g_i(K)\le\widetilde g_i+\Delta_N.
\tag{S16}
$$

There is **no division by `p`** in this replacement error. The test law
`H_i` was already conditioned before defining the bounded function `f_i`,
and it is independent of the training sample. Replacing the whole joint
train/test law and subsequently dividing an unconditional error by `p`
would give an unnecessarily weak bound and is not the argument here.

Under the common training law `Q^N`, the averaged coordinate kernel

$$
\overline y_j(R)=\sum_z Q^N(z)y_j(z,R)
\tag{S17}
$$

is one fixed feasible kernel's coordinate vector for every potential law
`D_i`: it obeys the same coordinate and capacity inequalities. The learner
still receives exactly the same supplied vector `x`, even though `Q` is an
auxiliary law with different marginals. No admissibility of `Q` is required.

## 6. Finite double count and the theorem

Conditional on the special item being active under `D_i`, the test set is
`{i}` with probability `1-alpha`, and a uniform `2k`-subset containing `i`
with probability `alpha`. Hence, with `C=binom(n-1,2k-1)`,

$$
\widetilde g_i=(1-\alpha)\overline y_i(\{i\})
+\frac\alpha C\sum_{R:|R|=2k,\ i\in R}\overline y_i(R).
$$

Averaging over `i` and applying the capacity bound gives

$$
\begin{aligned}
\frac1n\sum_i\widetilde g_i
&\le1-\alpha+\frac\alpha{nC}
  \sum_{R:|R|=2k}\sum_{i\in R}\overline y_i(R)\\
&\le1-\alpha+\frac{\alpha k\binom n{2k}}{n\binom{n-1}{2k-1}}\\
&=1-\alpha/2=\beta_k+\nu_kp.
\end{aligned}
\tag{S18}
$$

Using (S16), at least one label `i` therefore satisfies the stronger form

$$
\boxed{
g_i(K)\le\beta_k+\nu_kp+
\big[1-(1-\delta_{k,n})^N\big]
\le\beta_k+\nu_kp+N\delta_{k,n}
\le\beta_k+\nu_kp+2Np.}
\tag{S19}
$$

This proves (S3). If the displayed right-hand side exceeds one the bound
is simply noninformative; it remains valid. Taking its minimum with one
gives an equivalent bounded statement.

## 7. Necessary sample complexity

Let `epsilon>0`. Suppose a learner promises conditional retention at least `beta_k+epsilon`
for every element under every admissible law with the supplied marginal
vector. In particular the guarantee holds for the special label of every
`D_i`. Equation (S19) implies

$$
\epsilon\le\nu_kp+2Np.
$$

Consequently the following finite necessary condition holds:

$$
N\ge\max\!\left\{0,\frac{n\epsilon}{2k}
-\frac1{2(4k-2)}\right\}.
\tag{S20}
$$

If desired, the right side can be rounded upward because `N` is an integer.
When `nu_k p<=epsilon/2`, this simplifies to

$$
N\ge\frac{n\epsilon}{4k}.
\tag{S21}
$$

Thus `Omega(n epsilon/k)` independent full-set training samples are necessary
in this range. The stronger distance in (S9) also gives

$$
N\ge (\epsilon-\nu_kp)/\delta_{k,n}
\quad\text{when }\epsilon>\nu_kp,
\tag{S22}
$$

but (S20)–(S21) are the stated simple all-rank consequences. These are only
necessary conditions; no matching algorithm is asserted, and an unattainable
target does not become attainable merely by meeting them.

For fixed `k` and fixed finite `N`, taking arbitrarily large finite `n` in
(S19) shows that no improvement over `beta_k` can be guaranteed uniformly
over all ground-set sizes using just those `N` samples. More generally, if
`k` is fixed and `N(n)=o(n/k)`, a fixed positive improvement over `beta_k`
is impossible along this family. Uniform truncation already guarantees
`beta_k`, so this is an exact statement about dimension-independent finite
sample budgets.

For `k=1` the family has an additional degeneracy: all `D_i` are identical.
One can therefore average training under that common actual law and apply
(S18) directly, obtaining `g_i<=beta_1+nu_1p` for some label with **no**
training penalty, for every `N`. The nontrivial known-law versus
known-marginal asymptotic separation starts at rank three; the sample lower
bound above remains a correct statement for every rank.


## Scope of the learning result

The complete training sets are independent of each other and of the test set, and all come from one fixed unknown law. The guarantee is averaged over training and internal randomness. It does not assert failure on most datasets, a matching sufficient sample count, or an adaptive-query lower bound. No comparison law used in the proof is asserted to belong to the adversarial PI class.

# Part V. Learning feasible demands from whole-set samples

## 1. Learning model and prior work

Whole-set iid samples and the known marginal vector suffice to learn an explicit mixture of priority rules approaching any specified feasible positive demand vector. For the sharp PI demand vector, the sample count is proportional to the inverse of the smallest positive marginal, up to a logarithm of the number of coordinates and the usual squared error dependence.

The method is a direct application of the classical multiplicative-weights potential argument [AHK]. Chekuri, Vondrak and Zenklusen [CVZ, Section 4.2, Theorem 4.3 and Appendix C] already construct near-optimal contention-resolution schemes from weighted independent-set optimization, sampling and LP duality. Their product-distribution setting permits the conditional-sampling factorization in Proposition C.1. Here the input consists of unconditional samples of the entire correlated active set. We state the corresponding explicit dependence on the smallest positive marginal and implement every output as a distribution over actual priority rules. This is an operational consequence of the manuscript and established learning methods, not a separate foundational novelty claim.

## 2. A general demand-learning theorem

Fix a finite ground set E, an integer capacity k>=1, and an unknown law D on subsets of E. Its marginals x_i=Pr(i in R) are known. Let E_+={i:x_i>0} and m=|E_+|. Zero-marginal coordinates can be omitted: they never occur under D and their required demand is zero. If m<=k, selecting every active positive-marginal coordinate already meets any demand below x and needs no training. Thus consider m>k, in particular m>=2.

Suppose the learner is given positive numbers d_i<=x_i for i in E_+, and that D admits a feasible randomized rule with selection probabilities at least d_i simultaneously. The learner is not given that rule or D. Define

$$
d_*=\min_{i\in E_+}d_i,\qquad
L=\max_{i\in E_+}\frac{x_i}{d_i^2}.
$$

Given N>=1 iid training sets R_1,...,R_N drawn from D, and a step size 0<eta<=d_*/2, the algorithm below constructs a feasible kernel K_Z, where Z is the training vector, such that for every i in E_+,

$$
\mathbb E_Z\Pr_{R,K_Z}(i\text{ is selected})
\ \ge\
d_i\left(1-\frac{\log m}{\eta N}-\eta L\right).
\tag{L1}
$$

The test set R is an independent fresh draw from the same D. This is an expectation over training, test and the output kernel's randomness. It is not a claim that every training outcome, or even one high-probability training event, simultaneously attains the displayed bound.

The algorithm depends only on the known d, k and the training sets. The proof uses feasibility of d; it does not supply that feasibility to the algorithm as an oracle. Consequently the same learner works for every D for which that demand is feasible.

## 3. Exact algorithm

Initialize u_1(i)=1 for each i in E_+. At each round t=1,...,N:

1. Before observing R_t, form a total order sigma_t of E_+ by decreasing u_t(i)/d_i, with ties broken by a fixed label order. Save this order.
2. Read R_t and select the first min(k,|R_t intersect E_+|) active elements in sigma_t. Call that selected set I_t, and put Y_t(i)=1{i in I_t}.
3. Update
$$
u_{t+1}(i)=u_t(i)\left(1-\eta\,\frac{Y_t(i)}{d_i}\right).
\tag{L2}
$$

The update factor belongs to [1/2,1], so all weights remain strictly positive.

To process a fresh test set R, draw J uniformly from {1,...,N}, independently of the training and test data, and output the first k active elements according to the saved order sigma_J. For every fixed training vector this is an actual finite stochastic kernel: each row is the equally weighted mixture of N deterministic feasible outputs. Coincident outputs simply receive their combined mass.

Only the orders computed **before** their own training observations are saved. Saving an order formed after observing R_t would invalidate the conditional-expectation step below.

## 4. Proof of the general theorem

Write W_t=sum_i u_t(i), alpha_t(i)=u_t(i)/W_t, and g_t(i)=Y_t(i)/d_i. Let F_(t-1) denote all preceding training sets. The weights and sigma_t are measurable with respect to F_(t-1), and R_t is independent of F_(t-1).

For fixed weights, the priority rule maximizes sum_i alpha_t(i)1{i in I}/d_i among all feasible subsets I of any realized R. If K_D is any feasible witness for the demand vector, pointwise maximality and then expectation give

$$
\mathbb E\!\left[\sum_i\alpha_t(i)g_t(i)\mid
\mathcal F_{t-1}\right]
\ge
\sum_i\frac{\alpha_t(i)}{d_i}
\Pr_{D,K_D}(i\text{ is selected})
\ge1.
\tag{L3}
$$

No knowledge of K_D is used in forming sigma_t. In addition, since I_t is contained in R_t, for each fixed comparison coordinate i,

$$
\mathbb E[g_t(i)^2\mid\mathcal F_{t-1}]
=
\frac{\Pr(i\in I_t\mid\mathcal F_{t-1})}{d_i^2}
\le\frac{x_i}{d_i^2}\le L.
\tag{L4}
$$

The second-order term here is a bound for the comparison coordinate, not an incorrectly substituted weighted second moment.

The update gives exactly
W_(t+1)/W_t=1-eta sum_i alpha_t(i)g_t(i).
Because 0<=eta g_t(i)<=1/2, this ratio is positive. The inequality log(1-z)<=-z yields

$$
\log(W_{N+1}/m)
\le-\eta\sum_{t=1}^N\sum_i\alpha_t(i)g_t(i).
\tag{L5}
$$

For 0<=z<=1/2 we also have log(1-z)>=-z-z^2. Indeed the derivative of log(1-z)+z+z^2 is z(1-2z)/(1-z)>=0 and its value at zero is zero. Since W_(N+1)>=u_(N+1)(i), we obtain

$$
\log(W_{N+1}/m)
\ge-\eta\sum_{t=1}^Ng_t(i)
-\eta^2\sum_{t=1}^Ng_t(i)^2-\log m.
\tag{L6}
$$

Combining (L5) and (L6), dividing by eta, and taking expectations proves

$$
N\le
\mathbb E\sum_{t=1}^Ng_t(i)
+\eta NL+\frac{\log m}{\eta}.
\tag{L7}
$$

Finally let pi_t denote the deterministic priority rule saved in round t. Since it is fixed before R_t and a fresh test set has the same law independently of all training,

$$
\mathbb E_Z\Pr_{R,K_Z}(i\text{ is selected})
=
\frac1N\sum_{t=1}^N
\mathbb E_Z\Pr_R(i\in\pi_t(R))
=
\frac1N\sum_{t=1}^N\mathbb E[Y_t(i)].
\tag{L8}
$$

Multiplying (L7), after rearrangement, by d_i/N proves (L1). This also checks that the learned object is the operational kernel claimed in the theorem, not an unrelated vector satisfying constraints.

For each fixed training vector, K_Z is monotone under deletion of active competitors: if i is retained under a saved priority order, deleting other active items cannot cause i to be rejected. Mixtures preserve this property. No further claim about submodular objectives under correlated activation is inferred here.

## 5. Consequence for the sharp PI guarantee

Assume D is pairwise independent, sum_i x_i<=k, and define c=c_k, t=t_k as in Part I. The same conclusion holds under pairwise nonpositive covariances. Take

$$
d_i=cx_i+t x_i^2,\qquad
p_*=\min_{x_i>0}x_i.
$$

The main theorem supplies feasibility of d for every admissible D. The explicit coefficient formula gives c>=1/2 and c+t<=1, so 0<d_i<=x_i and d_i>=c p_* on E_+. In particular,

$$
L\le \frac{1}{c^2p_*}.
$$

For any 0<epsilon<=1 choose eta=c^2 p_* epsilon/2. Then eta<=d_*/2. If

$$
N\ge\frac{4\log m}{c^2p_*\epsilon^2},
\tag{L9}
$$

(L1) implies the simultaneous unconditional bounds

$$
\mathbb E_Z\Pr_{R,K_Z}(i\text{ is selected})
\ge(1-\epsilon)\bigl(c_kx_i+t_kx_i^2\bigr)
\quad\text{for all }i.
\tag{L10}
$$

For x_i=0, (L10) holds with both sides zero. If m<=k, the earlier zero-training rule applies.

A fully rational choice of a sufficient sample budget replaces log m in (L9) by H=ceil(log_2 m), an integer computable from m. For m>=2, H>=log m. Rational x and epsilon then give rational d, eta and all update factors. No transcendental-number oracle is required.

For equal marginals p=k/n, the sufficient sample count is

$$
N\ge\frac{4n\log n}{c_k^2k\epsilon^2}.
\tag{L11}
$$

This compares with Part IV's necessary order n/k for a fixed improvement over the unknown-law baseline. The logarithm and the error dependence are not claimed optimal.

More explicitly, for any fixed k>=3 put gamma_k=c_k-beta_k>0. Choosing epsilon=gamma_k/2 suffices for a conditional retention guarantee at least beta_k+gamma_k/2, because c_k+t_k p<=1. The sufficient bound becomes

$$
N\ge\frac{16n\log n}{c_k^2k\gamma_k^2}.
\tag{L12}
$$

For n>=2k(k+1), the sample lower bound in Part IV gives the necessary condition

$$
N\ge\max\left\{0,\frac{n\gamma_k}{4k}
-\frac{1}{2(4k-2)}\right\}.
\tag{L13}
$$

Thus, for fixed k>=3 and this fixed intermediate target, the dimension dependence is bounded between order n/k and order (n/k) log n. This statement leaves a logarithmic gap; it is not an exact minimax sample-complexity theorem. The rank-one and rank-two equality c_k=beta_k does not support a positive-gap assertion.

## 6. Representation and computational cost

The learning procedure stores at most N orders of m positive-marginal labels. Sorting each order costs O(m log m) comparisons and the weight updates require O(m) arithmetic operations per round. Training therefore uses O(Nm log m) arithmetic/comparison operations, with O(Nm) labels stored. A test draw chooses one order and scans it, selecting at most k active labels.

For rational inputs, each weight is a product of at most N rational factors 1-eta/d_i. If all such factors and d_i have numerator and denominator bit lengths at most B, the unreduced products have O(NB) bit length. Comparisons can be performed by integer cross multiplication. Hence the procedure has exact rational implementation with bit complexity polynomial in N, m and B. This is not a claim of strongly polynomial bit complexity independent of the input probabilities. In particular, when p_* is exponentially small in its bit encoding, the stated sample budget can be exponentially large in that encoding.

The sample law need not have explicit finite-support input of polynomial size. The algorithm receives whole-set draws and known marginals. This differs from the explicit-support flow implementation in Part I for an explicitly supplied rational support.

## 7. Scope and remaining questions

This result gives an expected guarantee with iid training and a fresh independent test set, known exact marginals, and offline access to each whole active set. It does not supply a high-probability learned-kernel guarantee, an online-arrival theorem, a bound for estimated marginals, or a sample count independent of positive-marginal scale. Removing the logarithmic gap, obtaining sharp dependence on accuracy, and reducing marginal-knowledge requirements remain open.

# Part VI. Combining guarantees under several capacity constraints

Let $B_j\subseteq E$ have capacity $k_j\ge1$, with $\sum_{i\in B_j}x_i\le k_j$ and pairwise independence within each $B_j$. A feasible output uses at most $k_j$ active items in every $B_j$. Write $g_{j,i}=c_{k_j}+t_{k_j}x_i$ for the conditional guarantee of Part I. Knowledge of each block law suffices to guarantee jointly
$$
 \Pr(i\text{ selected})\ge x_i\max\left\{0,1-\sum_{j:\,i\in B_j}(1-g_{j,i})\right\}.
$$
Run the local rule of Part I on the active set in each block. Retain an active item if every block containing it selects it. An item in no block is always retained when it activates. The retained set is contained in each local output on its block and thus meets the capacities. For any positive $x_i$, condition on item $i$ being active. Each local failure has probability at most $1-g_{j,i}$. The union bound gives the stated inequality under arbitrary dependence across blocks. Zero-marginal items satisfy the inequality directly.

For disjoint blocks each item receives the original sharp local guarantee. For any fixed list of capacities and unrestricted finite block sizes, the exact uniform worst-case intercept is $\min_j c_{k_j}$. The lower guarantee follows blockwise. For the upper bound, put an extremizing family from Part I in a block with smallest $c_{k_j}$ and give the other blocks zero marginals. Joint selection cannot improve on optimal selection in that block. When only marginals are known, the same construction works with $g_{j,i}=\beta_{k_j}+x_i/(4k_j-2)$ via the truncation rule of Part III. Gupta, Hu, Kehne and Levin already use a local-kernel intersection and conditional union bound for laminar online constraints. The contribution here applies the sharp offline constants and quadratic corrections under only blockwise independence, and identifies the disjoint-block optimum. Sharpness for overlapping blocks remains open. [Gupta et al., §4](https://doi.org/10.1007/s10107-025-02253-w)

# Part VII. Finite rank-one regions at all independence orders

## 1. Result and model

Let $E$ be finite, $x\in[0,1]^E$ with $\sum_i x_i\le 1$, and $t\ge2$ an integer. A law on $R\subseteq E$ is admissible if $\Pr(S\subseteq R)=x_S:=\prod_{i\in S}x_i$ for all $|S|\le t$. These moment equalities are equivalent to $t$-wise independence by inclusion–exclusion, with $x_\varnothing=1$. An offline selection kernel observes $R$ and can return at most one item of $R$ or return nothing. For $y\ge0$, write $y(B)=\sum_{i\in B}y_i$. A law-aware guarantee lets the kernel depend on the admissible law. An oblivious guarantee uses one kernel for all admissible laws with the given $x$.

For $B\subseteq E$ write $e_k(B)=\sum_{S\subseteq B,\ |S|=k}x_S$, $e_0=1$, and $b_k(B)=\sum_{r=1}^{k}(-1)^{r-1}e_r(B)$. For nonempty $B$ take $j\in B$ of maximal marginal $h=x_j$ and define
$$
 F_t(B)=h+(1-h)b_{t-1}(B\setminus\{j\}),\qquad F_t(\varnothing)=0.
$$
The choice among tied largest marginals has no effect.

**Theorem 1.** For each fixed $B$ the set of possible values of $\Pr(R\cap B\ne\varnothing)$ is exactly
$$
 \begin{cases}
     [F_t(B),b_t(B)]&t\text{ odd},\\
     [b_t(B),F_t(B)]&t\text{ even}.
 \end{cases}
$$
For nonempty $B$ its length is $e_t(B\setminus\{j\})$. One law attains the $b_t$ endpoint simultaneously over all $B$. For every fixed largest-marginal item of $E$, a second law simultaneously attains $F_t(B)$ for all $B$ containing that item.

**Theorem 2.** For odd $t\ge3$, the law-aware guarantee region is precisely $\{y\ge0:y(B)\le F_t(B)\ \forall B\}$. For every such $t$ there are admissible marginals with no law attaining all the subset minima simultaneously. For every such $t$ there are also admissible marginals for which the law-aware region strictly contains the oblivious region. The separation has an explicit service shortfall $[8(t+1)]^{-t}$ on its final coordinate when the preceding coordinates are guaranteed. For even $t$, the two guarantee regions both equal $\{y\ge0:y(B)\le b_t(B)\ \forall B\}$, as shown below.

## 2. The two endpoints

For a finite ground set $D$ and integer $a\ge0$, denote by $\mu_a^D$ the law with atomic masses
$$
 \mu_a^D(T)=x_T\sum_{r=0}^{a-|T|}(-1)^r e_r(D\setminus T)\quad (|T|\le a),
$$
and zero elsewhere. Indeed $(r+1)e_{r+1}(C)\le(\sum_{i\in C}x_i)e_r(C)\le e_r(C)$, so every alternating sum here is nonnegative by pairing adjacent terms. The formula is the Möbius inverse of $x_S$ on the lower ideal $\{|S|\le a\}$ of the Boolean lattice. The same inversion works for arbitrary specified moments $m(S)$ on this ideal. The coefficient of any $m(U)$ in the sum of inverted masses over $T\supseteq S$ is $\sum_{S\subseteq T\subseteq U}(-1)^{|U\setminus T|}=\mathbf 1_{\{S=U\}}$, and the empty moment gives total mass one for $\mu_a^D$.

The ordinary inclusion–exclusion bound of order $t$ puts $b_t(B)$ above the union for odd $t$ and below it for even $t$. The law $\mu_t^E$ attains it for all $B$ because it never activates more than $t$ items. The other inequality follows by partitioning on $j$. Whenever $h<1$, conditioning on $j\notin R$ preserves the moments through order $L:=t-1$ on $D=B\setminus\{j\}$, since
$$
 \Pr(S\subseteq R,j\notin R)=(1-h)x_S\qquad(S\subseteq D,\ |S|\le L).
$$
Apply the order-$L$ inclusion–exclusion inequality conditionally and add $h$. At $h=0$ all items of $B$ are absent almost surely. At $h=1$ the pivot is present and all other marginals are zero by the load bound.

For $0<h<1$ construct a law on $B$ as follows. Draw the pivot with probability $h$. On the zero branch, use $\mu_L^D$. On the one branch, use two subprobability laws. The first has mass $h^L$ and consists of independent Bernoulli variables with success probabilities $x_i/h$ for $i\in D$. All these probabilities are at most one. The second is supported on $|T|\le L-1$, with masses obtained by inverting the target moments $m(S)=x_S(1-h^{L-|S|})$ for $|S|\le L-1$. Its mass at $T$ of size $k$ is
$$
 x_T\sum_{r=0}^{L-1-k}(-1)^r e_r(D\setminus T)(1-h^{L-k-r}).
$$
Both factors of each coefficient $e_r(D\setminus T)(1-h^{L-k-r})$ are nonnegative and nonincreasing in $r$. Pairing adjacent terms proves nonnegativity of the mass. Inversion gives total mass $1-h^L$.

The one branch has moment $x_S$ for $|S|\le L-1$ since the first component contributes $h^{L-|S|}x_S$ and the second supplies the rest. At $|S|=L$ the first component alone gives $x_S$. Thus moments up to $L$ hold on either branch and moments including the pivot hold through order $t$. At $|S|=t$ with $S\subseteq D$, the zero branch and the second component of the one branch contribute zero. The one branch has moment $x_S/h$ from the first component, so the unconditional moment is $x_S$. Thus the law is admissible. The conditional zero law attains the order-$L$ bound, so the constructed union is $F_t(B)$. One may append the items of $E\setminus B$ independently of each other and of this law. If the construction is applied to all of $E$, the zero branch is supported on sets of size at most $L$ and has the right moments through $L$ for every subset. Hence every $B$ containing the chosen pivot attains $F_t(B)$ under that global law.

The endpoint difference follows from
$$
 b_t(B)=F_t(B)+(-1)^{t-1}e_t(B\setminus\{j\}),
$$
by separating elementary symmetric sums according to membership of $j$. Convex combinations of the endpoint laws preserve every prescribed moment, giving the full interval.

## 3. The law-aware region

For any fixed activation law with coverage $\rho(B)=\Pr(R\cap B\ne\varnothing)$, all selection marginals satisfy $y(B)\le\rho(B)$. These inequalities also suffice. Take an arbitrary linear objective, discard its nonpositive weights, and sort the remaining weights $c_1\ge\dots\ge c_m>0$ with successive prefixes $B_k$. Any nonnegative vector obeying the inequalities has objective at most $\sum_{k=1}^m(c_k-c_{k+1})\rho(B_k)$, with $c_{m+1}=0$. The rule returning the first active listed item attains this objective, since it has prefix retention probability $\rho(B_k)$ for every $k$. All selection marginals form a compact convex set since the kernel ranges over a finite product of simplexes. Equality of linear supporting maxima gives the characterization. If a guarantee is defined as a lower bound on service, thinning each retained item realizes any exact smaller target for the fixed law.

By Theorem 1, for odd $t$, the infimum of $\rho(B)$ over all admissible laws equals $F_t(B)$. Taking the intersection of the fixed-law regions proves the law-aware formula. The infimum may use a different law for each subset.

## 4. A single priority mixture attains the even-order region

Set $L=t$ for even $t$. The law $\mu_L^E$ has rank-one coverage $b_L$ and attains this lower bound on all subsets. The supporting-maxima argument in §3 shows that every $y$ satisfying $y(B)\le b_L(B)$ is a mixture of the selection marginals of fixed priority lists under this law. The lists may omit items and include the empty list.

The same mixture guarantees $y$ under every admissible law. For a list in the mixture, let $A$ be the items preceding $i$. If $x_i>0$, conditioning on $i$ active gives the product moments on $A$ up through order $L-1$. Since $L-1$ is odd, the corresponding inclusion–exclusion bound on the probability of no preceding activation is a lower bound. Thus $i$ wins with probability at least
$$
 x_i\sum_{j=0}^{L-1}(-1)^j e_j(A)=b_L(A\cup\{i\})-b_L(A).
$$
This is exactly its selection probability under $\mu_L^E$. When $x_i=0$ both are zero. Averaging this coordinatewise domination over the priority lists proves the even-order region. The law $\mu_L^E$ makes the subset bounds necessary for either information model.

## 5. No common extremal law at odd order

Suppose an admissible law realizes $F_t(B)$ as its union for every $B$. Let $q(S)=\Pr(S\subseteq R)$. Inclusion–exclusion gives $q(S)=\sum_{A\subseteq S}(-1)^{|A|+1}F_t(A)$ for nonempty $S$. Take $|S|>t$, with $j$ maximizing $x_j$ on $S$ and $D=S\setminus\{j\}$. The terms involving $j$ in this sum vanish. Indeed $F_t(A+j)=h+(1-h)b_{t-1}(A)$ for $A\subseteq D$ is a linear combination of the inclusion functions $\mathbf1_{\{U\subseteq A\}}$ for $U\subseteq D$ of size at most $t-1$. Each such function has zero alternating sum over subsets of $D$ since $|D|\ge t$. Thus $q(S)=q(D)$. Iterating and using admissibility at order $t$ forces $q(S)$ to be the product of the $t$ smallest marginals in $S$ for all $|S|\ge t$.

Take $t-2$ items of marginal $\delta=1/(8t)$, three of marginal $w=1/12$, and two of marginal $z=1/8$. The total load is below one and $\delta<w<z<2w$. The event that all the $\delta$ items and both $z$ items activate, while all three $w$ items are absent, would have probability
$$
 \delta^{t-2}(z^2-3wz+3w^2-w^2)=\delta^{t-2}(z-w)(z-2w)<0.
$$
This follows by inclusion–exclusion on the three items of marginal $w$ and the forced formula for $q$. A common minimizing law is impossible.

## 6. Strict separation from oblivious selection for every odd order

Let $t\ge3$ be odd, $L=t-1$, and $B=\{1,\ldots,t+1\}$ have equal marginal $s=1/[8(t+1)]$. Add a pivot $v$ of marginal $H=1/2$, forming $E=B+v$ of load $5/8$. Let $B_k=\{1,\ldots,k\}$ and prescribe
$$
 y_k=F_t(B_k)-F_t(B_{k-1})\quad(1\le k\le t+1),
 \qquad y_v=F_t(E)-F_t(B).
$$

The $y_k$ are nonincreasing and positive. For $k\le t$ they equal the independent increments $s(1-s)^{k-1}$. By Theorem 1, $F_t(B)=b_t(B)-s^t$ while the independent union on $t+1$ items is $b_t(B)-s^{t+1}$. Thus $y_{t+1}=s(1-s)[(1-s)^{t-1}-s^{t-1}]$ is positive and at most the independent increment. For each $k\ge1$, the difference for adding $v$ to $k$ small items is
$$
 G_k=F_t(B_k+v)-F_t(B_k)
     =H(1-b_L(B_k))-s e_L(B_{k-1}),
 \qquad G_0=H .
$$
Here $F_t(B_k)=b_L(B_k)+s e_L(B_{k-1})$. The sequence $G_k$ is nonincreasing since $b_L$ is coverage under $\mu_L^B$ and $e_L$ is monotone under inclusion. In particular $y_v=G_{t+1}\ge H(1-(t+1)s)-ts^t>0$. A subset of $k$ small items receives at most $y(B_k)=F_t(B_k)$, and if it also contains $v$, its service is at most $F_t(B_k)+G_{t+1}\le F_t(B_k+v)$. Hence $y$ belongs to the law-aware region.

Assume an oblivious kernel guarantees all the small-item targets. Under the fully independent law, each $B_k$ for $k\le t$ has union probability exactly $y(B_k)$. Equality forces the kernel to return an item from $B_k$ on every input intersecting $B_k$, since each input has positive probability. Taking $k$ to be the first active small index at most $t$ forces the kernel to return that item deterministically.

Next use the minimizing law for $B$ given by Theorem 1, appended with independent $v$. Its union on $B$ equals $y(B)$, so every positive-mass input intersecting $B$ must return a small item. When only item $t+1$ of $B$ is active, both statuses of $v$ occur with positive probability. With the earlier prefix forced, the positive target $y_{t+1}$ requires these inputs to have positive total probability, and $v$ is independent with $0<H<1$. Thus the kernel is forced to retain item $t+1$ on both inputs. Consequently it returns $v$ only when all of $B$ is absent.

Finally, give $B$ the law $\mu_t^B$ and couple $v$ to $B$ by setting
$$
\begin{aligned}
 \Pr(R\cap B=T,\ v\notin R)&=(1-H)\mu_L^B(T),\\
 \Pr(R\cap B=T,\ v\in R)&=\mu_t^B(T)-(1-H)\mu_L^B(T).
\end{aligned}
$$
The latter mass is nonnegative when $|T|\ge t$, since $\mu_L^B(T)=0$. For $k=|T|\le L$, it equals
$$
 H\mu_L^B(T)+(-1)^{t-k}s^k\binom{t+1-k}{t-k}s^{t-k}.
$$
The alternating sum gives $\mu_L^B(T)\ge s^k(1-(t+1)s)$. The correction has absolute value at most $s^k(t+1)s$ since $t-k\ge1$ and $\binom{t+1-k}{t-k}=t+1-k$. Nonnegativity follows from $H(1-(t+1)s)=7/16$ and $(t+1)s=1/8$. This law has the product moments on $B$ through order $t$. Since both truncations agree on moments through $L$, it has $\Pr(S\subseteq R,\ v\in R)=H s^{|S|}$ for $S\subseteq B$, $|S|\le L$. It is admissible and its union probabilities are $b_t(B)$ on $B$ and $F_t(E)$ on $E$. Thus a kernel returning $v$ only when $B$ is absent gives $v$ service at most
$$
 F_t(E)-b_t(B)=y_v-s^t.
$$
This proves the separation for arbitrary randomized kernels using the full observed set and knowing the marginals.

## 7. The universal parity constant as a consequence

The sharp universal scalar balance at rank one is the established value
$$
 c(t)=\sum_{j=1}^{L}(-1)^{j-1}/j!,\qquad L=2\lfloor t/2\rfloor .
$$
The complete parity staircase, including the odd-law asymptotics, is due to Gupta, Hu, Kehne and Levin, Appendix A, Lemma A.3, Theorem A.4, Lemma A.5, Claims A.7–A.8 and Lemma A.10. We give a deduction from the finite formulas to show how the worst-case scalar and heterogeneous regions relate. [Gupta et al., Appendix A](https://link.springer.com/article/10.1007/s10107-025-02253-w)

For the lower bound, the even-order theorem is available under $t$-wise independence. Write $x(B)=\sum_{i\in B}x_i$. To show $b_L(B)\ge c(t)x(B)$, split any mass into two nonnegative pieces $a,b$. Its change to $b_L$ is $-ab\sum_{r=0}^{L-2}(-1)^r e_r$ on the remaining masses, which is nonpositive by alternating pairing. Repeated equal splitting gives fixed total $\mu=x(B)$ and largest piece tending to zero. Now $e_r$ converges to $\mu^r/r!$: the total weight of ordered repeated-index $r$-tuples is bounded by $\binom r2\mu^{r-1}$ times the largest mass, and the distinct ordered tuples have total weight $r!e_r$. For $\mu>0$, the limit of $b_L/\mu$ is
$$
 \int_0^1\sum_{r=0}^{L-1}(-s\mu)^r/r!\,ds.
$$
It is nonincreasing in $\mu\in[0,1]$, since its derivative is the negative integral of $s$ times the even Taylor polynomial for $e^{-s\mu}$ through degree $L-2$, which is nonnegative on this range. For example one may pair adjacent terms, leaving the final nonnegative even term. Evaluating at $\mu=1$ proves the bound. The empty-mass case has both sides zero.

For the matching upper bound, take $n$ equal marginals $1/n$. If $t=L$, the truncated law from §2 has union $b_L(E)\to c(t)$. If $t=L+1$, the pivot law has union $1/n+(1-1/n)b_L(E\setminus\{j\})\to c(t)$. Total service cannot exceed that union. Thus the scalar guarantee agrees in both information models in the universal worst case, even when the finite pointwise regions differ.

## 8. Reproduction and literature boundary

From the directory containing this manuscript, run [the rank-one verifier](evidence/r02/verify_exact.py) with `python3 evidence/r02/verify_exact.py`. The pure Python verifier uses rational arithmetic to check the endpoint atoms and pointwise inclusion–exclusion certificates in both parities. It gives the exact interval $[113/160,57/80]$ for five heterogeneous marginals $(1,2,3,4,10)/20$ at $t=3$ and reproduces both odd-order obstructions for $t=3,5,7,9$. The finite replay supports the examples. The proofs cover all finite ground sets and orders.

The pairwise upper endpoint already occurs in Ramachandra and Natarajan, Theorem 2.3. Its scope allows arbitrary marginals and their sorted star certificate builds on Hunter and Worsley. Lemma 2.1 and Corollary 2.2 also contain the proportional-product mixture at the pairwise level. Corollary 4.2 reduces the equal-marginal higher-order question to fewer aggregated moments. The construction here treats orders $t\ge3$ with heterogeneous marginals, subject to load at most one. [Ramachandra and Natarajan, Tight Probability Bounds with Pairwise Independence](https://arxiv.org/abs/2006.00516)

Natarajan, Ramachandra and Tan parametrize the feasible law in Theorem 9 and derive sharp tail bounds in Section 3 when independence holds through one below the total number of events. This includes $t=|B|-1$ of Theorem 1. Complete independence covers $t\ge |B|$. The five-item, three-wise replay illustrates a heterogeneous regime strictly between these and the pairwise case. [Natarajan, Ramachandra and Tan, Probability Bounds for n Random Events under (n−1)-Wise Independence](https://arxiv.org/abs/2211.01596)

Dawson–Sankoff use two aggregate binomial moments. Kwerel treats the first few aggregate intersection sums. Boros–Prékopa give sharp count-moment bounds, covering exchangeable specializations when count moments enforce all the individual independence constraints. Berend, Ernst, Kontorovich and Kumar's Theorem 2.3 addresses sharp all-success probabilities for equal marginals in a high-success regime. The latter overlaps sparse equal-marginal coverage after complementation. These comparisons concern aggregate or equal-marginal information. The construction here preserves each individual intersection moment. [Dawson–Sankoff](https://doi.org/10.1090/S0002-9939-1967-0211424-0) · [Kwerel](https://www.cambridge.org/core/journals/advances-in-applied-probability/article/abs/bounds-on-the-probability-of-the-union-and-intersection-of-m-events/9D7D1A574FA41363128F22C6F32737E7) · [Boros–Prékopa](https://doi.org/10.1287/moor.14.2.317) · [Berend et al.](https://doi.org/10.1007/s10959-026-01487-4)

Prékopa–Gao formulate LP bounds using aggregated and disaggregated information. With $(h,m)=(t-2,1)$ in Bukszár's §3, Theorem 12, the hypermultistar centered at $j$ has the $t$-sets containing $j$ as its $t$-edges. Equations (3) and (4) therefore give exactly the pivot bound $b_{t-1}(B)+(-1)^{t-1}\sum_{S\subseteq B,\,|S|=t,\,j\in S}\Pr(S\subseteq R)$ for arbitrary events. Bukszár attributes the $m=1$ case to Tomescu. Under the prescribed product moments this is $F_t(B)$. The additional step here is to attain this bound while preserving every individual moment across all heterogeneous product inputs of load at most one. [Prékopa–Gao](https://rutcor.rutgers.edu/Prekopa/pdf/04.pdf) · [Bukszár, §3, Theorem 12](https://files.ele-math.com/articles/mia-06-66.pdf)

The preceding §7 attributes the tight rank-one universal balance at every order to Gupta, Hu, Kehne and Levin. Universal balance optimizes over marginals and gives one scalar guarantee. Dughmi's rank-based description applies to a given activation law. The claims here give the exact coverage interval for general finite heterogeneous inputs at all orders, the resulting common law-aware region at odd orders, and its strict separation from the oblivious region at each such order. A full characterization of the odd-order oblivious region remains open. [Gupta et al.](https://doi.org/10.1007/s10107-025-02253-w) · [Dughmi](https://doi.org/10.4230/LIPIcs.ICALP.2020.42)

# Appendix A. A direct finite-policy proof of the selection bridge

This appendix proves the same selection-existence implication used in Part I. It is an alternative proof route for formalization; it does not alter the demand, probability model, or conclusion, and it does not replace the separate cyclic-rounding statement in Part I, Section 5.

Let D be any probability law on subsets of a finite E, let k be a nonnegative integer, and let d_i≥0. Suppose that for every A⊆E,

$$
\sum_{i\in A}d_i\le\mathbb E_D\min\{k,|R\cap A|\}. \tag{B1}
$$

A deterministic feasible policy g assigns to each R a particular g(R)⊆R of cardinality at most k. There are finitely many such policies, and the always-empty policy is one of them. Its selected vector is

$$
v_g(i)=\sum_R D(R)\mathbf1\{i\in g(R)\}.
$$

Let C be the convex hull of all v_g. It is a nonempty compact convex subset of the finite-dimensional real coordinate space. We first prove d∈C and then extract an actual kernel.

## A.1 One policy simultaneously saturates all prefixes

Fix any distinct-element list (e_1,…,e_m), and let A_j={e_1,…,e_j}. On input R, scan this list and keep its first k activated elements. Call this policy g. For every j,

$$
|g(R)\cap A_j|=\min\{k,|R\cap A_j|\}. \tag{B2}
$$

Indeed, if the prefix contains at least k active elements, all k chosen elements occur in that prefix. If it contains fewer than k, every active element of the prefix is chosen before the scan continues outside it. The reasoning also covers j=0 and k=0. Averaging (B2), and applying (B1), gives

$$
\sum_{i\in A_j}(v_g(i)-d_i)\ge0 \qquad(0\le j\le m). \tag{B3}
$$

## A.2 Every signed linear functional is dominated

For arbitrary real weights w_i, list precisely the elements with w_i>0 in nonincreasing weight order; ties may be broken arbitrarily. If this list is empty, use the empty policy. Then Σ_i w_i d_i≤0=Σ_i w_i v_g(i), since d_i≥0.

Otherwise write a_j=w_(e_j)>0 and D_j=Σ_(h≤j)(v_g(e_h)−d_(e_h)). Equation (B3) gives D_j≥0. Finite summation by parts gives the identity

$$
\sum_{j=1}^m a_j(v_g(e_j)-d_{e_j})
=a_mD_m+\sum_{j=1}^{m-1}(a_j-a_{j+1})D_j\ge0. \tag{B4}
$$

Every term on the right is nonnegative. Outside the list, the policy never selects an element, while w_i d_i≤0. Consequently

$$
\sum_i w_i d_i\le\sum_i w_i v_g(i). \tag{B5}
$$

If d were outside C, strict separation of a point from a closed convex set in finite dimension would give real coefficients w_i with Σ_i w_i d_i>Σ_i w_i z_i for every z∈C. This contradicts (B5), since its v_g belongs to C. Thus d∈C. This is an application of the standard proved separation theorem; no additional target-existence assumption is being introduced.

## A.3 The convex weights define a genuine kernel

Membership in the finite convex hull supplies policies g_1,…,g_M and nonnegative weights λ_1,…,λ_M summing to one, such that d=Σ_h λ_h v_(g_h). Define

$$
K(I\mid R)=\sum_{h=1}^M\lambda_h\mathbf1\{g_h(R)=I\}. \tag{B6}
$$

Each mass is nonnegative. For each R, summing over I gives Σ_h λ_h=1, because every policy has exactly one output. If I is not a feasible subset of R, every indicator in (B6) is zero. Finally finite sum exchange gives

$$
\begin{aligned}
\Pr_{D,K}(i\in I)
&=\sum_R D(R)\sum_I K(I\mid R)\mathbf1\{i\in I\}\\
&=\sum_h\lambda_h\sum_R D(R)\mathbf1\{i\in g_h(R)\}\\
&=\sum_h\lambda_hv_{g_h}(i)=d_i.
\end{aligned} \tag{B7}
$$

Operationally one samples a policy according to λ, independently of R, and applies it. The construction never divides by D(R), so it is defined also on zero-probability input sets. This proves actual finite randomized selection with the exact demands in (B1).

# Appendix B. Exchangeable finite populations and equality

Here $1\le k<n$, with $n$ exchangeable pairwise-independent activation bits of marginal $p=k/n$. The count $S$ has mean $k$ and variance $v=k(1-k/n)$. For integer $a=\lfloor\sqrt v\rfloor$, the exact worst optimum is
$$
 1-\frac{v+a(a+1)}{2k(2a+1)} .
$$
Indeed the best uniform balance for an exchangeable law equals $\mathbb E\min(k,S)/k$. An upper bound follows by summing services, and uniform selection of precisely $\min(k,S)$ items attains equal marginals. For integer $z$ the inequality
$$
 z_+\le \frac{z^2+(2a+1)z+a(a+1)}{2(2a+1)}
$$
follows by factoring the defect as $(z-a)(z-a-1)/(2(2a+1))$ for $z\ge0$, and $(z+a)(z+a+1)/(2(2a+1))$ for $z\le0$. Both products are nonnegative on integers. Apply it to $z=S-k$ and use the two moments to obtain the stated balance bound.

It is attained by a count law using the two symmetric pairs at distances $a,a+1$ from $k$, with outer total weight $(v-a^2)/(2a+1)$ and equal split within each pair. The radius-zero pair counts as one atom. All these labels are feasible since $v<\min(k,n-k)$ and therefore $a+1\le\min(k,n-k)$. Choosing a uniform subset at the sampled count gives marginals $p$ by the count mean and pairwise intersections $p^2$ by the second factorial moment. The four contact points are $-a-1,-a,a,a+1$ for $z$, with repetitions removed. Equality occurs precisely for count laws supported on these points with the prescribed two moments. For $n=k$ activation is deterministic and the balance is one. The finite identical-marginal stop-loss component is already in Ramachandra's thesis, Theorem 7 and Appendix A. [Ramachandra, Theorem 7 and Appendix A](https://www.arjunramachandra.com/_files/ugd/fca0b4_83f077f73bcb4773a187b76459bc4cac.pdf)

# Verification and reproducibility

The supplementary exact-arithmetic programs check specified finite witnesses. The original programs replay genuine subset laws, independence cells, capacity and marginal constraints, and the sample obstruction; their inputs and recovery provenance are recorded with the original case. The rank-one replay is independent of external packages. The written proofs establish the assertions quantified over arbitrary admissible laws, marginals, and kernels. Parts IV and V distinguish lower and upper learning bounds and state the scope of expectation over training and testing. The exact odd-order oblivious region and the finite higher-order region at general rank remain open. Lean verification is delivered separately.

# References


[G] Anupam Gupta, Jinqiao Hu, Gregory Kehne and Roie Levin. *Pairwise-independent contention resolution*. Mathematical Programming 216, 295–338 (2026), published online 10 July 2025. Definition 2.3, Theorem 3.1, and Appendix A. [Publisher full text](https://link.springer.com/article/10.1007/s10107-025-02253-w). [arXiv:2406.15876](https://arxiv.org/abs/2406.15876).

[D] Shaddin Dughmi. *The Outer Limits of Contention Resolution on Matroids and Connections to the Secretary Problem*. ICALP 2020, LIPIcs 168, Article 42. Theorem 3.6 and §3.5, especially Theorem 3.18 and Lemma 3.20. [Official full text](https://drops.dagstuhl.de/storage/00lipics/lipics-vol168-icalp2020/LIPIcs.ICALP.2020.42/LIPIcs.ICALP.2020.42.pdf).

[CD] Cindy Courtois and Michel Denuit. *Moment Bounds on Discrete Expected Stop-Loss Transforms, with Applications*. Methodology and Computing in Applied Probability (2009). DOI: [10.1007/s11009-007-9048-0](https://doi.org/10.1007/s11009-007-9048-0). The propositions cited here can be inspected in the authors' official 2006 working paper, Propositions 2.2 and 3.2: [UCLouvain full text](https://sites.uclouvain.be/IAP-Stat-Phase-V-VI/ISBApub/Actu/2006-11-WP-Courtois_Denuit.pdf).

[R] Arjun Kodagehalli Ramachandra. *Towards Tightness with Pairwise Independence, Extremal Dependence and Robust Satisficing Using Linear and Conic Duality*. PhD thesis, Singapore University of Technology and Design / National University of Singapore, 2021. Theorem 7 and Appendix A. [Author-hosted complete thesis](https://www.arjunramachandra.com/_files/ugd/fca0b4_83f077f73bcb4773a187b76459bc4cac.pdf).

[F] Hu Fu, Pinyan Lu, Zhihao Gavin Tang, Abner Turkieltaub, Hongxun Wu, Jinzhao Wu and Qianfan Zhang. *Oblivious Online Contention Resolution Schemes*. SOSA 2022. [arXiv:2111.10607](https://arxiv.org/abs/2111.10607).

[DLN] Shaddin Dughmi, Vasilis Livanos and Pranav Nuti. *Optimal Contention Resolution from Samples*. arXiv:2611.08673v1, 5 November 2026. The activation and sampling model uses product distributions; it is distinct from the PI same-marginal information model considered here. [Primary source](https://arxiv.org/abs/2611.08673).

[AHK] Sanjeev Arora, Elad Hazan and Satyen Kale. *The Multiplicative Weights Update Method: a Meta-Algorithm and Applications*. Theory of Computing 8 (2012), 121–164. DOI 10.4086/toc.2012.v008a006. Section 2. [Official full text](https://www.theoryofcomputing.org/articles/v008a006/v008a006.pdf).

[CVZ] Chandra Chekuri, Jan Vondrak and Rico Zenklusen. *Submodular Function Maximization via the Multilinear Relaxation and Contention Resolution Schemes*. SIAM Journal on Computing 43 (2014). DOI 10.1137/110839655. Section 4.2, Theorem 4.3, Appendix C, especially the product factorization in Proposition C.1. [Authors' arXiv full text](https://arxiv.org/pdf/1105.4593).
