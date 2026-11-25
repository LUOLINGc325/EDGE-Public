---
title: "Computational complexity of optimal Pauli error cancellation on odd cycles"
subtitle: "Exact counting hardness and deterministic relative approximation"
lang: en
---

# Computational complexity of optimal Pauli error cancellation on odd cycles

## Abstract

We study the minimum quasiprobability cost for exact inversion of correlated Pauli dephasing. Given a single odd interaction cycle with rational edge attenuations, exact evaluation is #P-hard even though the dependence space is one-dimensional. The reduction recovers weighted signed-subset discrepancies from a controlled strong-noise expansion. The same problem admits a deterministic fully polynomial-time approximation scheme for relative error. The algorithm quantizes the log likelihood ratio of two complementary Bernoulli product laws, and a one-coordinate lower bound protects relative accuracy when the normalized cost is small. Exact factorization extends the scheme to weighted cactus graphs.

## 1. Model and results

For an edge e = {i,j} of a simple graph, let A_e be conjugation by the Pauli operator Z_i Z_j. An elementary rational dephasing channel is

~~~text
D_e = [(1+ξ_e)/2] I + [(1−ξ_e)/2] A_e,    0<ξ_e<1.
~~~

The edge channels commute, and the model channel is their product. The attenuations ξ_e are part of the input as binary-encoded rationals. Let Γ be the optimum sum of absolute coefficients in an exact real quasiprobability representation of the inverse by completely positive trace-preserving maps. Its conventional factorized cost is Γ_fac = ∏_e ξ_e⁻¹.

We use the archived Pauli-diagonal reduction: Γ equals the sum of absolute coefficients of the inverse in the basis of distinct Pauli conjugations. Here the inverse for edge e has identity coefficient α_e = (ξ_e⁻¹+1)/2 and conjugation coefficient −β_e = −(ξ_e⁻¹−1)/2. The resulting coefficient for an edge-boundary label combines all edge subsets with that binary boundary. The archived *Parity criteria and cost asymptotics for Pauli–Lindblad error cancellation* proves the reduction, the graph maximum-cut exponent, and the circuit formula. It leaves efficient exact evaluation of structured circuit costs outside its results.

**Theorem 1.** Exact computation of Γ on a single odd cycle with rational attenuations is #P-equivalent under polynomial-time Turing reductions. The hardness holds for the normalized cost Γ/Γ_fac as well. There is a deterministic algorithm producing a relative ε approximation to either cost, in time polynomial in the input size and 1/ε. The approximation extends to every weighted cactus graph, in which no edge belongs to more than one simple cycle.

The exact evaluation problem has a rational output of polynomial bit length on the stated input model. The reduction varies attenuation strengths and uses positive rational edge parameters. Both results address cost evaluation.

## 2. The odd-cycle product-law formula

An edge subset of a simple cycle has even degrees at all its vertices only if it is empty or the whole cycle. Therefore two subsets give the same Pauli label precisely when they are identical or complementary. On an odd cycle, complementary subsets have opposite inverse signs.

Let k be the length and write μ for the product law on τ in {−1,1}^k with independent probabilities Pr(τ_j=1)=(1+ξ_j)/2. Its complement law μ^c assigns mass μ(−τ) to τ. Dividing the inverse coefficient magnitudes by Γ_fac and grouping complementary pairs gives the archived normalized formula

~~~text
T(ξ) := Γ/Γ_fac = TV(μ,μ^c)
 = 2^(−k) ∑_τ |F(τ)|,
F(τ) = [∏_j (1+τ_j ξ_j) − ∏_j(1−τ_j ξ_j)]/2.              (1)
~~~

An even cycle has same-sign complementary terms, and its cost equals Γ_fac. A bridge has no binary dependence and also has its factorized cost.

## 3. Exact evaluation is #P-hard on one odd cycle

For a positive integer vector a of odd length k≥3, define

~~~text
L(a) = ∑_(τ in {−1,1}^k) |∑_j τ_j a_j|,    W=∑_j a_j.
~~~

Set Q=2^(k+3)(W+1)^2 and ξ_j=a_j/Q. This is a valid positive rational attenuation vector with polynomial bit length. The odd-degree expansion of F(τ) in (1) starts with ∑_j τ_j a_j/Q. The sum of absolute higher terms, after multiplying by Q, is at most

~~~text
Q ∑_(d≥3) (W/Q)^d ≤ 2W³/Q²,
~~~

because W/Q<1/2. Here the sum over degree-d products is at most W^d. The absolute value is 1-Lipschitz, so

~~~text
|2^k Q T(ξ) − L(a)| ≤ 2^(k+1) W³/Q² < 1/2.                (2)
~~~

One exact rational oracle call, followed by multiplication and nearest-integer rounding, recovers L(a). Every rational number used in this step has polynomial bit length. For example, after substituting these attenuations the unnormalized inverse coefficients have a common denominator dividing ∏_j(2a_j). Their absolute sum is at most Γ_fac=∏_j Q/a_j, so the numerator also has polynomial bit length. For general rational ξ_j=u_j/v_j in (0,1), the same argument uses denominators ∏_j(2u_j) and the bound ∏_j v_j/u_j.

Next let b be any even-length list of at least two positive integers. For t≥1, the elementary identity |x+t|+|x−t|=2 max(|x|,t) gives

~~~text
L(b,t+1) − L(b,t) = 2 · #{τ: |∑_j τ_j b_j| ≤ t}.          (3)
~~~

The identity holds because the signed sum is an integer. Both lists supplied to L in (3) have odd length at least three.

For a counting PARTITION instance a, scale all weights by four. If its length is even, use that scaled list as b. If its length is odd, append one weight of value one to make b even. In the first case the number of sign vectors with absolute signed sum at most one equals the number of original zero-sum signs. In the second case an extended sum is 4s±1, and its absolute value is at most one exactly when the original sum s is zero. The extension count is therefore twice the desired answer. Apply (3) with t=1 and divide by the known factor. Degenerate inputs of length zero can be counted directly. This gives a polynomial-time Turing reduction using at most two calls on odd cycles.

For completeness, the counting version of PARTITION used here is #P-hard. Counting subsets of given sum is #P-hard by the standard digit reduction from counting satisfying assignments of a 3-CNF formula. Give the target digit one in each variable column and four in each clause column. For each variable create a true and false item, with one in its variable column and a clause digit counting the literal occurrences made true by that assignment. For each clause add two slack items, of digit one and two in that clause alone. Items are indexed, so two equal integers still represent two possible choices. In base ten all column sums are below ten, even when both items for a variable are chosen, since each literal occurrence contributes one at most once. Matching the variable columns chooses exactly one value for each variable. A clause with one, two, or three true literals has a unique slack subset giving digit four; a clause with no true literal cannot reach four. Thus the reduction is parsimonious. For subset-sum input of total W and target T, encode a chosen subset by positive signs. Its signed target is d=2T−W. If d=0, use the same list for zero-sum signs. Otherwise append one weight |d|. The extended zero-sum count is twice the number of subsets of sum T, since sign inversion bijects signed targets d and −d. This completes the hardness proof.

### 3.1. A counting upper bound

For ξ_j=u_j/v_j with integers 0<u_j<v_j, use the common denominator D₀=∏_j(2u_j). The integer numerator D₀Γ is the sum, over one representative τ with τ₁=1 from each complementary pair, of

~~~text
|∏_j(v_j+τ_j u_j) − ∏_j(v_j−τ_j u_j)|.
~~~

Every summand is an efficiently computable nonnegative integer of polynomial bit length. A nondeterministic machine guesses one representative and a binary integer below a fixed polynomial-bit upper bound, accepting exactly when that integer is strictly smaller than the summand. Its number of accepting branches is D₀Γ. Thus this numerator is a #P function. Exact evaluation of the rational cost is consequently #P-equivalent under polynomial-time Turing reductions.

## 4. A deterministic relative approximation scheme

The preceding magnitude estimate for weak attenuations extracts exact combinatorial information from the cost. For approximation we work directly with (1). Under μ define the log likelihood ratio

~~~text
L = ∑_j τ_j ℓ_j,   ℓ_j = log[(1+ξ_j)/(1−ξ_j)].
~~~

Because ξ_j∈(0,1), both product laws give every vector positive mass. The total variation has the expectation form

~~~text
T(ξ) = E_μ[φ(L)],   φ(x) = max(0,1−exp(−x)).
~~~

The function φ is 1-Lipschitz on the real line. Projection to any coordinate can only decrease total variation, and the distance between its two Bernoulli laws is ξ_j. Consequently T(ξ) ≥ ξ_* = max_j ξ_j > 0. This estimate is used in the error analysis, including when ξ_* is exponentially small in the bit length.

Fix rational 0<ε≤1, and take the rational rounding step h=εξ_* /(8k). Compute each positive ℓ_j to accuracy h/2 and round to the nearest nonnegative integer multiple j_j h. This guarantees |ℓ_j−j_j h|≤2h. Let J=∑_j τ_j j_j. By the Lipschitz property, replacing L by hJ changes the expectation by at most 2kh=εξ_*/4.

The distribution of J is computed by a dynamic program. Start at integer state zero with mass one. For each j add j_j with probability (1+ξ_j)/2 and subtract j_j with probability (1−ξ_j)/2. When both updates reach the same state, add their masses. Use exact rational probabilities. A common denominator for the masses after layer j is the product of the first j per-edge denominators 2v_i, so all integers needed for these updates have polynomial bit length.

The update range is from −∑_j j_j to ∑_j j_j. If ξ_*≤1/2, integrating the derivative 2/(1−x²) on [0,ξ_j] gives ℓ_j≤4ξ_*. Hence the range size is O(k²/ε). Otherwise ξ_*>1/2, and every ℓ_j is O(B) where B is the maximum bit length of an input attenuation. Indeed (1+ξ)/(1−ξ)=(v+u)/(v−u)≤2v, so its logarithm is O(B). The range size in this case is O(k²B/ε). Thus the exact distribution requires only a polynomial number of arithmetic operations.

At each final state evaluate φ(hJ) with absolute error at most εξ_*/4. The moment of the evaluated function under the exact integer-state law then differs from T by at most εξ_*/2, which is at most εT. Multiplication by the exact rational Γ_fac gives the asserted relative approximation to Γ.

### 4.1. Certified real-function approximations

All needed logarithms and exponentials can be approximated by rational arithmetic at polynomial bit cost. For a logarithm of positive rational q≥1, write q=2^e r with integer e≥0 and 1≤r<2 by rational comparisons. Use

~~~text
log r = 2 ∑_(m≥0) [(r−1)/(r+1)]^(2m+1)/(2m+1),
~~~

whose ratio parameter is at most 1/3. The same series with r=2 computes log 2. Their geometrically bounded tails give absolute precision h/2 with polynomially many terms and polynomial-size rational numerators and denominators; the required number of terms is logarithmic in (e+1)/h.

To evaluate φ(x) for rational x, return zero at x≤0. For x>0 it suffices to approximate exp(−x) to a chosen tolerance δ=εξ_*/4. If x≥b for an integer b with 2^(−b)≤δ, approximate that exponential by zero. Otherwise take m=max(1,⌈x⌉) and use the alternating Taylor series of exp(−x/m) with error at most δ/m. Raising the clipped value in [0,1] to the m-th power changes the exact result by at most δ, since the m-th power is m-Lipschitz on that interval. The tail bound for argument at most one gives a polynomial bit procedure, and m≤b is polynomial in the bit length of δ. This justifies the approximation scheme in the ordinary binary input model, including very small ξ_*.

## 5. Exact factorization and approximation on cactus graphs

A cactus graph has edge-disjoint simple cycles, with bridges as the remaining edges. The kernel of its binary edge-incidence map is the space of even-degree edge subsets. Any such subset decomposes into simple cycles by following closed trails and splitting at repeated vertices. Because the graph's distinct simple cycles are edge-disjoint, the kernel is the direct sum of the one-dimensional cycle kernels. Thus the quotient of the full binary edge space by the kernel is the direct sum of the bridge and cycle quotient spaces. These quotients label distinct Pauli conjugations, since two edge subsets induce the same vertex boundary precisely when their difference lies in the kernel.

The inverse coefficient on a given tuple of quotient labels is the product of the corresponding per-block coefficients, by multiplying edge factors and then summing independently over each preimage. Taking the sum of absolute values therefore gives the exact relation

~~~text
Γ(G) = ∏_(bridge e) Γ(e) · ∏_(simple cycle C) Γ(C).             (4)
~~~

This remains true when cycles share articulation vertices, since only edge subsets enter the quotients. The decomposition into blocks can be found in polynomial time, for example by depth-first search for biconnected components. Bridges and even cycles are evaluated exactly. For each of m odd cycles use accuracy ε/(4m) when m>0, and multiply the resulting values. The product of m relative factors between 1−ε/(4m) and 1+ε/(4m) lies between 1−ε and 1+ε for 0<ε≤1, by the elementary product bounds (1−a)^m≥1−ma and (1+a)^m≤exp(ma). If m=0 the cost is exact. The run time remains polynomial in the graph's encoding size and 1/ε.

## 6. Source relation and scope

The archived case proves the channel-cost reduction and the total-variation formula for one circuit. It also proves approximate-cost hardness for general graphs at strong rational noise via maximum cut. The single-odd-cycle exact hardness here comes from signed-subset counting, even with only one relation. The deterministic relative approximation and exact cactus factorization describe what remains efficiently computable in the same restricted graph class. The results concern rational attenuation inputs and exact inverse-channel costs. They do not classify exact evaluation at a single common fixed attenuation or give an efficient optimal sampling procedure. The source comparison is limited to the pinned repository record.
