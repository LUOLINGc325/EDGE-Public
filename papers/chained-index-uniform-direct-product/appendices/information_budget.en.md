# Lossless information budgets for parallel Chained Index

Date: 2026-11-25. Independent derivation .
Status: complete finite-probability proof of the KL budget and constant-error direct sum. **This file does not prove a strong direct product.**

All logarithms, entropies and divergences use base 2. Relative entropy is denoted by D. A distribution is identified with its probability mass function.

## 1. Exact finite model

Let N≥2 be even, s=N/2, and let μ be the uniform distribution on the s-element subsets of [N]. A subset S represents the positions of the ones in a balanced binary string. There are r≥1 parallel answer bits B=(B_1,…,B_r). At a single stage the prior π on {0,1}^r is arbitrary: it may be biased, correlated, or supported on a proper subset.

The fresh input X=(S_1,…,S_r) has distribution μ^r and is independent of B. An encoder emits M using a stochastic kernel W(m|X), with no access to B. After M, the index vector J is generated, independently across coordinates conditional on (X,B), by

J_j uniform on S_j if B_j=1, and uniform on S_j^c if B_j=0.

This is the single-stage conditional law in the balanced-slice hard distribution, after fixing the previous transcript and public randomness. For arbitrary string length n≥2, use N=2 floor(n/2), pad the unused coordinate deterministically, and keep all indices in [N]. This gives legal instances of the n-coordinate problem. No restriction to balanced strings is made in the worst-case problem; balanced strings are only the lower-bound input distribution.

For b∈{0,1}^r, let K_b be the product channel X→J just defined. Let u be uniform on [N]. We have μ^r K_b=u^r for every b. The same reference u^r works for every answer vector; this is central to the arbitrary-prior argument.

## 2. The elementary symmetric mean inequality

For nonnegative a_1,…,a_N with average one,

E_{S∼μ} product_{j∈S} a_j ≤1.                                      (2.1)

This is the usual Maclaurin inequality. A short self-contained proof is included to isolate exactly what is used. On the compact simplex Σ_j a_j=N, maximize e_s(a), the sum of all s-fold distinct products. Among maximizers choose one minimizing Σ_j a_j². Replacing unequal coordinates a_i,a_j by their average preserves their sum and increases their product. The decomposition

e_s(a)=e_s(a_rest)+(a_i+a_j)e_{s−1}(a_rest)+a_i a_j e_{s−2}(a_rest)

shows that this replacement cannot decrease e_s. For s=1 the statement is an equality and needs no argument. For s≥2 all coefficients are nonnegative, so an unequal pair would yield another maximizer with strictly smaller sum of squares, a contradiction. The minimizing maximizer is therefore the all-ones vector, at which e_s=binom(N,s). Dividing proves (2.1). This proof includes zero coordinates.

## 3. Single-row KL contraction

Let ν be any distribution on the s-subsets. Sample S∼ν and then J uniformly from S. Write p for the distribution of J. Then

D(p || u) ≤ (1/s) D(ν || μ) = (2/N)D(ν || μ).                    (3.1)

Proof. For any real function f on the finite slice, the entropy variational inequality gives

D(ν||μ) ≥ E_ν f − log E_μ 2^f.

For ε>0 put a_j=N(p_j+ε)/(1+Nε). These numbers are strictly positive with average one. Set f(S)=Σ_{j∈S}log a_j. By (2.1), E_μ 2^f≤1. Also ν(j∈S)=s p_j. Therefore

D(ν||μ) ≥ s Σ_j p_j log[N(p_j+ε)/(1+Nε)].

Letting ε decrease to zero yields s D(p||u). Terms with p_j=0 vanish, so there is no unhandled logarithm of zero. This proves (3.1).

Selecting from the complement has the identical bound, since S↦S^c preserves μ. The coefficient 2/N is a valid universal bound; no optimality claim for this coefficient is made.

The variational inequality itself follows by applying D(ν||μ_f)≥0 to μ_f(S)=μ(S)2^{f(S)}/E_μ2^f. Nonnegativity of finite relative entropy follows from the log-sum inequality.

## 4. Product contraction, including correlated inputs

Suppose K_j maps μ_j to u_j and satisfies D(ν_j K_j||u_j)≤η D(ν_j||μ_j) for every ν_j. Then, for every joint distribution ν on the product input space,

D(ν(K_1⊗⋯⊗K_r) || u_1⊗⋯⊗u_r)
    ≤η D(ν || μ_1⊗⋯⊗μ_r).                                    (4.1)

The coordinates of ν need not be independent.

Proof. Generate X∼ν and independent channel outputs Y_j conditional on X. The KL chain rule, followed by the one-coordinate bound conditional on Y_{<j}, gives

D(P_Y||u^r)
 =Σ_j E_{Y_{<j}} D(P_{Y_j|Y_{<j}}||u_j)
 ≤η Σ_j E_{Y_{<j}} D(P_{X_j|Y_{<j}}||μ_j).

Conditional on X_{<j}, the randomization producing Y_{<j} is independent of X_j. Hence P_{X_j|Y_{<j}} is a mixture of P_{X_j|X_{<j}}. Convexity of KL in its first argument implies

E_{Y_{<j}}D(P_{X_j|Y_{<j}}||μ_j)
 ≤E_{X_{<j}}D(P_{X_j|X_{<j}}||μ_j).

The sum of the right-hand terms is D(ν||⊗μ_j), by the input KL chain rule. This proves (4.1).

Apply this to each coordinate's subset or complement channel. For every fixed b and every correlated ν,

D(ν K_b || u^r) ≤(2/N)D(ν||μ^r).                              (4.2)

## 5. Arbitrary-prior and randomized-encoder information budget

In the model of §1,

I(B;M,J) ≤(2/N) I(X;M) ≤(2/N)H(M).                            (5.1)

No factor r appears in the coefficient, and no additive log N or chain-length term is needed.

Proof. Because X and encoder randomness are independent of B, M is independent of B. For a_m=P(M=m)>0 let ν_m=P(X∈·|M=m). Conditional on M=m the answer still has prior π, and J|B=b,M=m has distribution ν_mK_b. Its mixture distribution is ρ_m=Σ_b π_b ν_mK_b. The exact reference-measure identity is

Σ_b π_b D(ν_mK_b||u^r)
 = I(B;J|M=m)+D(ρ_m||u^r).

Dropping the final nonnegative term and applying (4.2) gives

I(B;J|M=m) ≤(2/N)D(ν_m||μ^r).

Average over m. The right-hand side is (2/N)I(X;M). Since I(B;M)=0, this proves the first inequality. The second follows from I(X;M)≤H(M). All zero-probability messages are omitted. Stochastic encoders are fully covered; deterministic message cells are not required.

For infinite message alphabets the same statement holds whenever the displayed quantities are finite, by countable sums/monotone truncation. A finite worst-case bit budget yields finite alphabets, so no limiting argument is needed for the main communication application.

## 6. Sequential conditioning is legitimate

Let public randomness R be independent of the input. At stage i, independently over stages conditional on B, generate X_i∼μ^r and J_i∼K_B(X_i,·). Although J_i depends on B, the law of X_i is the same μ^r for every B. Each stage encoder sees its own X_i, earlier public transcript H_{i−1}, and fresh independent private randomness. Write

H_0=R,     H_i=(R,M_1,J_1,…,M_i,J_i).

For every positive-probability history h,

P(X_i=x,B=b|H_{i−1}=h)=μ^r(x)P(B=b|H_{i−1}=h).                (6.1)

Indeed, given B, the fresh stage is independent of all earlier stages and coins, and X_i's conditional distribution does not depend on B. The posterior on B can now be arbitrarily correlated, which is exactly what §5 allows. Neither future indices nor unrevealed future strings may be included in h.

Applying (5.1) at every history and using the mutual-information chain rule yields

I(B;H_k | R)
 ≤(2/N) Σ_{i=1}^k I(X_i;M_i | H_{i−1})
 ≤(2/N) Σ_{i=1}^k H(M_i | H_{i−1}).                           (6.2)

The notation already includes R in H_{i−1}. The left side conditions on R to remove any initial public seed; R is independent of B in the hard distribution. If an external public prior signal is allowed, the same statement applies to the information gained after that signal.

The proof may fix a public seed first and average afterwards. It also covers private coins through the local stochastic kernel. Randomized final decoding cannot increase the available information.

For arbitrary original n, N=2 floor(n/2) gives 2/N≤4/n, so a convenient n-uniform version is

I(B;H_k|R) ≤(4/n)Σ_i H(M_i|H_{i−1}).                          (6.3)

The exact 2/N constant may be retained. In fact N≥2n/3 for n≥2 gives 2/N≤3/n, but the weaker 4/n version matches the common frozen interface.

## 7. Converting conditional message entropy to paid bits

At each public history h, assume the possible complete messages of that player form a prefix code, with actual paid lengths ℓ_h(m). More generally, a uniquely decodable per-history code satisfying Kraft is enough:

Σ_m 2^{−ℓ_h(m)}≤1.                                           (7.1)

For its actual conditional distribution a_m,

H(M_i|H_{i−1}=h)≤Σ_m a_mℓ_h(m).                              (7.2)

Proof. If K=Σ_m2^{−ℓ_h(m)}≤1 and q_m=2^{−ℓ_h(m)}/K, the inequality D(a||q)≥0 gives H(a)≤Σ a_mℓ_h(m)+log K≤Σ a_mℓ_h(m).

A singleton message alphabet may have a zero-length codeword. A nonconstant choice between silence and a nonempty string is not a valid such code without paying its boundary signal.

In a standard sequential binary protocol tree the ending nodes of a given player's turn, conditional on the public history, define a prefix code: a terminal path cannot be the proper prefix of another path at that same turn. Skipping a player is permitted when it is determined by the public history. Publicly released indices remain side information and are not charged as player bits.

Let L be total paid length. Averaging (7.2) and summing,

Σ_i H(M_i|H_{i−1})≤E L,

and therefore

I(B;H_k|R)≤(2/N)E L.                                        (7.3)

In particular this is at most 2C/N for a worst-case budget C.

**Do not replace this proof by H(M_1,…,M_k)≤C.** The positions and lengths of messages may depend on free earlier indices; their unconditional tuple can contain entropy already present in those free indices. The paid quantity in (7.3) is the sum of conditional entropies, with those indices in the conditioning.

## 8. Constant-error direct sum

Now let B be uniform on {0,1}^r, as in the product hard distribution, and suppose a decoder recovers all r coordinates with error probability at most δ<1/2. Every individual coordinate then has error at most δ. Conditional subadditivity and binary Fano give

H(B|H_k)≤Σ_j H(B_j|H_k)≤r h_2(δ).

Consequently

I(B;H_k|R)≥r[1−h_2(δ)],

and (7.3) implies

E L≥(N/2)r[1−h_2(δ)].                                      (8.1)

The standard vector Fano bound also yields E L≥(N/2)[r−h_2(δ)−δ log(2^r−1)]; one may take the maximum of these lower bounds. The coordinate bound (8.1) avoids the small-r negativity of the coarser r(1−δ)−h_2(δ) expression.

For δ=1/3, 1−h_2(1/3)=5/3−log_2 3≈0.08170416594551. Thus the coefficient in (8.1) is approximately 0.040852082972755 N r. For original n, the safe interface gives C≥n r[1−h_2(δ)]/4. Worst-case correctness implies the needed distributional correctness, so this is also a worst-case communication lower bound.

An O(nr) upper bound in the standard model sends all r strings only at the last stage, so the final player uses its r indices. Every earlier player is skipped by an input-independent schedule. For r=1 this proves Θ(n), uniformly in k. For arbitrary r it matches constant-error direct-sum scaling, with zero error on the upper bound.

## 9. Free slots: the correct tuple bound

In the different model with free observable stage boundaries, a message can be any binary string, including the empty string, and only payload bits count. No per-history Kraft inequality is imposed. The information theorem (6.2) still holds. By conditioning reducing entropy,

Σ_i H(M_i|R,M_{<i},J_{<i})≤Σ_i H(M_i|R,M_{<i})
 =H(M_1,…,M_k|R).                                           (9.1)

For worst-case total payload at most the integer C, the number of possible k-tuples is

N_{k,C}=Σ_{ℓ=0}^C 2^ℓ binom(ℓ+k−1,k−1).

Stars and bars accounts for the length vector; 2^ℓ accounts for its ordered payload. Hence

H(M_1,…,M_k|R)≤log N_{k,C}
 ≤C+log binom(C+k,C)
 ≤C log[2e(1+k/C)]                                          (9.2)

when C≥1. The middle bound follows from the hockey-stick identity, and the last uses binom(a,b)≤(ea/b)^b. When C=0 the tuple is deterministic and the information is zero, so a single uniform answer cannot be recovered with error below 1/2.

For one answer and δ<1/2 this proves

log N_{k,C}≥(N/2)[1−h_2(δ)].                               (9.3)

For r answers with constant block error, the right-hand side is multiplied by r using (8.1)'s information requirement. This extension is only a necessary direct-sum condition, not a claimed tight slotted multi-instance law.

Example demonstrating the mistake H(tuple)≤C: choose uniformly which of k≥3 slots carries the single bit 0, leaving all other slots empty. Payload is one but tuple entropy is log k>1. This is a legal free-slot signaling pattern. It need not satisfy the per-history prefix condition of §7.

## 10. Why this does not imply the strong direct product

A bound I(B;Γ)≤α r does not force all-r success to be exponentially small. As an abstract information channel, reveal all of B with probability α and otherwise reveal nothing. Then I(B;Γ)=α r but its all-r success is α+(1−α)2^{−r}. This example is a logical obstruction to an information-only inference, not a claim that the channel is achievable cheaply in Chained Index.

The frozen strong direct-product target therefore still requires a likelihood-moment, Rényi, min-entropy, or other success-sensitive argument. No strong-product status is asserted by this file.

## 11. Attribution and scope

The single-element subset KL principle is a special case of established entropic independence; the elementary-symmetric inequality is classical Maclaurin. These are background tools, not claimed new inventions. This file independently supplies the exact reference distribution argument, correlated-prior/product conditioning details, and correct message-cost conversion needed for the present model.

Primary context: Sundaresan, ITCS 2025, https://doi.org/10.4230/LIPIcs.ITCS.2025.89 ; Huang et al., CCC 2025, https://doi.org/10.4230/LIPIcs.CCC.2025.33 ; Anari et al., Entropic Independence I, https://arxiv.org/abs/2106.04105 .

The proof does not address Augmented Chain or a free-silence private-neighbor chain upper bound. It does not use computational checks as a substitute for any universal inequality above.
