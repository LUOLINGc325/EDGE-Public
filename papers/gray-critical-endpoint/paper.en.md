---
title: "Dispersion at the Gray distortion endpoint for binary Markov sources"
subtitle: "Finite-block refinement from posterior hidden switches"
lang: en
---

# Dispersion at the Gray distortion endpoint for binary Markov sources

## Abstract

We determine the operational dispersion of a stationary symmetric binary Markov source at the critical Gray distortion. The strict-interior approach based on an additional binary-noise margin degenerates there. We use the exact reproduction law at the target distortion. Its hidden states become independent given the observed word, and hidden switches preserve independent posterior errors even at the endpoint. A distortion-shell estimate and concentration within individual source flip counts give an achievability remainder of at most half the logarithm of blocklength plus a constant. A Hamming-volume converse gives a constant lower remainder. Both bounds hold uniformly up to the critical distortion on compact parameter sets.

## 1. Setting and result

Take 0 < p < 1/2. The first source bit is fair and the subsequent n−1 flip bits are independent Bernoulli(p) variables. A code has M binary reproduction words and succeeds when the chosen reproduction is within Hamming distance ⌊nD⌋ of the source word. Let M*(n,D,ε) be the least size with error probability at most ε. We use natural logs, binary entropy h(u) = −u log u − (1−u) log(1−u), and the standard normal upper-tail function Q.

Let ρ = 1−2p, and define

~~~text
D_c(p) = [1 − 2√ρ/(1+ρ)]/2,
v_p = p(1−p)[log((1−p)/p)]²,
A_n = n[h(p)−h(D)] + √(n v_p) Q⁻¹(ε).
~~~

**Theorem 1.** For 0 < D ≤ D_c(p) and 0 < ε < 1,

~~~text
A_n − O(1) ≤ log M*(n,D,ε) ≤ A_n + (1/2) log n + O(1).          (1)
~~~

The constants and the starting blocklength can be taken uniformly over p in a compact subinterval of (0,1/2), over D bounded away from zero with D ≤ D_c(p), and over ε in a compact subinterval of (0,1).

In particular, the dispersion at D = D_c(p) is v_p in nats squared. The archived *Operational dispersion of binary Markov sources inside the Gray region* obtains two-sided O(log n) remainders for the strict interior and leaves the endpoint open. We use its finite-block marked matrices, including their nonnegative boundary value. The posterior and concentration arguments below replace its strict noise margin.

## 2. Reproduction law and posterior structure

Write s = √ρ, z = 1−2D, g = s/z. For y in {0,1}, let

~~~text
          1   ⎡ 1+ρ+2(−1)^y g      1−ρ        ⎤
C_y  =   ───  ⎣      1−ρ      1+ρ−2(−1)^y g  ⎦ .
          4
~~~

Since 2g ≤ 1+ρ, all entries are nonnegative even at D_c(p). The columns of C_0 + C_1 sum to one. Sample a hidden path H_0,…,H_n with H_0 fair and with joint probability C_y(j,i) of emitting y and moving to state j from state i. Denote the emitted-word law by Q_n. Independently generate E_i with law Bernoulli(D), and set X_i = Y_i ⊕ E_i, where ⊕ is binary addition modulo two.

Let u_0 = (1+s,1−s) and u_1 be the reversed vector, written as columns. The mixed marked matrix at X_i = x is

~~~text
C̃_x = (1−D) C_x + D C_(1−x) = u_x u_xᵀ / 4.                 (2)
~~~

The scalar products of identical and opposite u vectors are 4(1−p) and 4p respectively, and the sum of either vector's entries is two. Multiplying (2), starting from the uniform state vector, gives exactly the Markov source law P_n. Thus P_n is the independent binary-noise convolution of Q_n at distortion D.

For a fixed source word x, the hidden path posterior is a product of independent states. Its joint mass is proportional to

~~~text
(u_(x_1))_(H_0) × ∏_(j=1)^(n−1)[(u_(x_j))_(H_j)(u_(x_(j+1)))_(H_j)]
               × (u_(x_n))_(H_n).                            (3)
~~~

Each site gives each state a posterior probability bounded below by a positive constant depending only on p. Conditional on the hidden path and x the error bits are independent. The chance of E_i = 1 is

~~~text
e_i(x,H) = D C_(1−x_i)(H_i,H_(i−1)) / C̃_(x_i)(H_i,H_(i−1)).     (4)
~~~

When H_i differs from H_(i−1), both C matrices have equal off-diagonal entries, so (4) equals D. On hidden stays, the conditional error can be deterministic at the critical point. Let K count hidden switches and J count errors on hidden stays. Conditional on x, the hidden path, and the stay errors, the total error S satisfies

~~~text
S = J + Bin(K,D),    W = J + DK,    m(x) = E[S|X=x] = E[W|X=x].
~~~

## 3. Distortion-shell probability

There are constants c,C,α > 0, uniform on the parameter sets of Theorem 1, such that for all sufficiently large n and all x with |m(x)−nD| ≤ αn,

~~~text
Q_n{y : d_H(x,y) ≤ nD}
  ≥ c n^(−1/2) exp[−j_n(x) − C(m(x)−nD)²/n],
j_n(x) = −log P_n(x) − n h(D).                                (5)
~~~

Fix x. Use (3) to sample the independent hidden states and independent uniform variables to generate the stay errors with probabilities (4). Changing one hidden state affects at most two edge terms in each of K and W, and changing an auxiliary uniform affects at most one term of W. Each term has range length at most one. Successive hidden states each have both labels with probability bounded below and are independent, so E[K|x] ≥ κn for a uniform κ > 0. The bounded-differences inequality therefore shows that

~~~text
K ≥ κn/2 and |W−m(x)| ≤ C₀√n                                  (6)
~~~

hold jointly with posterior probability at least one half for a sufficiently large fixed C₀ and all large n. Indeed the first failure is exponentially small in n, and the second can be made smaller than a fixed constant by choosing C₀.

Put k = ⌊nD⌋. Under (6), the distance from k−J to the binomial mean KD is at most 1+C₀√n+|m(x)−nD|. Choose α sufficiently small that this is at most (κ/4) min(D,1−D)n for all sufficiently large n. Then k−J is a feasible count. For any integer 0 ≤ l ≤ K, Stirling's estimate and changing the binomial parameter from l/K to D give

~~~text
Pr{Bin(K,D)=l} ≥ (c₀/√K) exp[−(l−KD)²/(KD(1−D))].             (7)
~~~

At its own parameter the binomial mass at l is at least c₀/√K by Stirling, or is one at an endpoint. The change of parameter multiplies the mass by exp[−K kl(l/K || D)], and log u ≤ u−1 gives kl(r || D) ≤ (r−D)²/[D(1−D)].

Use the lower and upper bounds on K in (6) in (7) and integrate over the good posterior event. The resulting bound on Pr(S=k|x) is c n^(−1/2) exp[−C(m(x)−nD)²/n], after absorbing the rounding and C₀√n terms into constants. On the exact shell, Bayes' rule gives

~~~text
Q_n{y : d_H(x,y)=k} = P_n(x) Pr(S=k|x) / [D^k(1−D)^(n−k)].
~~~

The reciprocal likelihood equals exp[n h(D)+(k−nD) log((1−D)/D)] and is within a constant factor of exp[n h(D)]. The shell is contained in the distortion ball, proving (5).

## 4. Concentration on source flip-count classes

Write U_i = X_i ⊕ X_(i+1) for 1 ≤ i < n and F = ∑_i U_i. The marginal posterior probability of E_i = 1 is obtained by averaging (4) over the two independent states H_(i−1), H_i in (3). In the interior it depends only on (x_(i−1),x_i,x_(i+1)). Both the marked model and the source are invariant under simultaneous complementation of all observed and hidden labels. Consequently the probability depends only on (U_(i−1),U_i), with an endpoint term depending on one flip. Therefore m(X) is the sum of n functions taking values in [0,1], each depending on at most two neighboring flip bits. Each flip occurs in at most two summands. Also E[m(X)] = nD by the original independent error law.

Bounded differences for the independent flips shows that

~~~text
Pr{|m(X)−nD|>αn} ≤ 2 exp(−c_α n).                             (8)
~~~

We also need two bounds conditional on F = f, where 0 ≤ f ≤ n−1. Writing μ_f = E[m(X)|F=f], they are

~~~text
|μ_f−nD| ≤ C₁(|f−(n−1)p|+1),
Pr{|m(X)−μ_f|>u | F=f} ≤ 2 exp(−c₁ u²/n).                   (9)
~~~

To prove the first bound, conditioned on F = f the flip vector is uniform over all binary vectors of length n−1 and weight f. Its one-site mean is f/(n−1). At two distinct positions its joint distribution is sampling two labels without replacement from a population of size n−1 with f ones. Sampling with replacement changes this law in total variation by at most 1/(n−1), by coupling the two index draws unless they coincide. Two independent Bernoulli variables of parameter f/(n−1) differ in total variation from a pair of parameter p by at most 2|f/(n−1)−p|. Apply the bounds to each local expectation and sum, using E[m(X)]=nD.

For the second bound, reveal the fixed-weight flip vector one coordinate at a time. At a history where both current labels are possible, couple the branch with current zero to the one with current one by swapping the zero with one uniformly chosen future one. The resulting future vector is uniform in the other branch. To check this, each target completion has the same number of possible predecessor positions, the zeros of that completion, and each predecessor chooses uniformly among the same number of ones. A transposition affects at most four local summands and changes each by at most one. Hence the difference in conditional expectations across the two branches is at most four. The increments of the Doob martingale are bounded by four, and Azuma's inequality gives the second bound in (9). Histories with a forced current label have zero increment.

## 5. Achievability and the logarithmic remainder

The score j_n from (5) is affine in the binomial source flip count. With a_p = log((1−p)/p) > 0, it is

~~~text
j_n(X) = μ_n + a_p[F−(n−1)p],
μ_n = n[h(p)−h(D)] + log 2 − h(p),
s_n² = Var(j_n) = (n−1) v_p.                                 (10)
~~~

The Berry–Esseen inequality for sums of independent Bernoulli variables gives a uniform O(n^(−1/2)) difference from the Gaussian distribution function for the centered and standardized score. The same is true for a weak or strict tail, by taking left limits. The largest atom of F is at most C₂/√n by Stirling's estimate. These constants are uniform when p remains in a compact subinterval of (0,1/2).

Fix a threshold a = μ_n + s_n Q⁻¹(ε) + A, where A is a fixed positive constant to be chosen below. Take M = ⌈e^a √n⌉ independent reproduction words from Q_n. Use a reproduction covering the input whenever any exists. Given x, the mean miss probability over the random codebook is at most exp[−M Q_n(B_D(x))], where B_D(x) is the distortion ball.

The following estimate applies to any a with |a−μ_n| ≤ C₃√n, for a fixed C₃, independent of how a was selected:

~~~text
E[1{j_n(X)≤a} exp(−M Q_n(B_D(X)))] ≤ C₄/√n.                  (11)
~~~

To prove it, discard the shell-exception set in (8), of exponentially small probability. For d = a−j_n(x) ≥ 0, (5) gives

~~~text
M Q_n(B_D(x)) ≥ c exp[d−C(m(x)−nD)²/n].                      (12)
~~~

For each flip count with d in a range d₀ ≤ d ≤ b n, (9) and (10) imply |μ_f−nD| ≤ C₅(√n+d). Choose d₀ sufficiently large and then b>0 sufficiently small so that this is at most half of √(dn/(2C)) on that range. This follows by dividing by √(dn): the two terms are at most C₅/√d₀ and C₅√b. The conditional concentration in (9) now gives

~~~text
Pr{C(m(X)−nD)²/n > d/2 | F=f} ≤ 2e^(−c₂ d).
~~~

On its complement, the miss bound from (12) is exp[−c exp(d/2)]. For 0≤d<d₀ use the bound one. The score lattice has spacing a_p, and each atom has probability at most C₂/√n. Thus summing these conditional bounds over d≤bn is O(n^(−1/2)), since the bound after d₀ is summable over the lattice, uniformly over its phase. For d>bn, the assumption |a−μ_n|≤C₃√n and a binomial Hoeffding bound give exponentially small probability. This proves (11). For the chosen a, a single C₃ may be fixed before choosing A, since any fixed A is at most √n for all sufficiently large n.

The overall mean error is consequently at most Pr{j_n(X)>a}+C₄/√n. By Berry–Esseen and the positive Gaussian density at Q⁻¹(ε), a sufficiently large fixed A makes this quantity at most ε for all sufficiently large n. In detail, shifting the threshold by A improves the Gaussian tail by a constant times A/√n for large n, which dominates the Berry–Esseen error and (11). On compact ε ranges that density is uniformly bounded below near the target quantiles. A deterministic codebook with error at most ε therefore exists. Since a = A_n+O(1), and e^a grows exponentially for fixed parameters, rounding M changes its log by at most a constant. This proves the upper bound in (1).

## 6. Converse

For k = ⌊nD⌋ the size of each distortion ball is V(n,k)=∑_(l=0)^k binom(n,l). We have

~~~text
V(n,k) ≤ C₆ exp[n h(D)]/√n.                                  (13)
~~~

Indeed, downward ratios of consecutive binomial coefficients are bounded above by k/(n−k+1), uniformly below one on the allowed compact parameter sets. The sum is therefore at most a fixed multiple of its largest term. Stirling at k/n, bounded away from zero and one for large n, bounds that term by C exp[n h(k/n)]/√n, and h(k/n)≤h(D).

The success set of any deterministic code of size M has cardinality at most M V(n,k). A word with j_n(x)≥log M has probability at most exp[−log M−nh(D)]. The success probability contributed on this tail is therefore at most C₆/√n by (13). It follows that

~~~text
Pr{j_n(X)≥log M} ≤ ε+C₆/√n.
~~~

The Berry–Esseen bound and local positivity of the Gaussian density give log M≥μ_n+s_n Q⁻¹(ε)−O(1)=A_n−O(1). This also applies to randomized codes whose common randomness can be fixed at an error no larger than its average. The constants throughout the upper and lower proofs are uniform on the stated compact sets. In particular p, D, 1−D, v_p, and the score spacing are bounded away from zero there, as are the hidden posterior probabilities. The positive rate h(p)−h(D) is uniformly bounded away from zero on such a compact p range because D≤D_c(p)<p. This completes Theorem 1.

## 7. Attribution and scope

The archived Gray-region paper contains the exact marked matrices and the open-interval normal approximation. It states that its extra-noise proof does not cover D=D_c(p). The proof above uses exact posterior factorization and the remaining random errors on hidden switches, which continue to hold when some marked diagonal entries vanish. The fixed-weight concentration and the distortion-ball volume bound give the logarithmic brackets in (1). The paper concerns symmetric binary sources, known parameters, fixed blocklength, and D in the positive Gray interval including its endpoint. It does not determine the exact third-order coefficient. The source comparison is limited to the pinned repository record.
