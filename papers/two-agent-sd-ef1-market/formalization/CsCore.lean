import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.SplitIfs
import Lean.Elab.Tactic.Omega

/-!
# Certified scalar and prefix lemmas for two-agent market fairness

This file formalizes selected mathematical lemmas used in the paper, not the
entire allocation-existence theorem or the algorithm. In particular it does not
formalize the pairing-graph seed, the matroid greedy construction, or termination
of the exchange path. All statements below are unconditional Lean theorems under
their explicitly displayed hypotheses; no project-specific axioms are declared.

For a market crossing, `s` is the value of the heavy endpoint and `t` that of
the light endpoint. The heavy bundle contains a good of value `x`, which is
exchanged for a good of nonnegative value `y`; hence `s + y = t + x`.
The two possible EF1 inequalities cannot both fail.
-/

namespace FairDivisionCore

/-- The algebraic crossing lemma does not itself require either half-value
orientation hypothesis. Those are used only to identify the envying side. -/
theorem market_crossing_or
    (s t W x y : ℝ) (hy : 0 ≤ y) (hswap : s + y = t + x) :
    2 * s ≤ W + x ∨ W ≤ 2 * t + x := by
  by_cases hs : 2 * s ≤ W + x
  · exact Or.inl hs
  · right
    have hs' : W + x < 2 * s := lt_of_not_ge hs
    linarith

/-- Strict failure at both ends contradicts the nonnegative value of the
other exchanged good. -/
theorem no_two_strict_failures
    (s t W x y : ℝ) (hy : 0 ≤ y) (hswap : s + y = t + x) :
    ¬ (W + x < 2 * s ∧ 2 * t + x < W) := by
  rintro ⟨hs, ht⟩
  linarith

/-- The same impossibility applies to the actual maximum market values in
the two relevant envied bundles, since both maxima dominate the shared good. -/
theorem no_two_market_failures
    (s t W x y heavyMax lightComplementMax : ℝ)
    (hy : 0 ≤ y) (hswap : s + y = t + x)
    (hheavyMax : x ≤ heavyMax)
    (hlightComplementMax : x ≤ lightComplementMax) :
    ¬ (W + heavyMax < 2 * s ∧ 2 * t + lightComplementMax < W) := by
  rintro ⟨hs, ht⟩
  linarith

/-- Both directed scalar EF1 inequalities for a two-bundle allocation.
For actual bundles, `ownMax` and `otherMax` are their largest market item
values, with the maximum of the empty bundle defined as zero. -/
def ScalarMarketEF1 (bundle total ownMax otherMax : ℝ) : Prop :=
  2 * bundle ≤ total + ownMax ∧ total ≤ 2 * bundle + otherMax

/-- At a swap crossing half of the total market value, at least one endpoint
satisfies both directed market-EF1 inequalities. -/
theorem crossing_endpoints_market_ef1
    (s t W x y sOwnMax sOtherMax tOwnMax tOtherMax : ℝ)
    (hy : 0 ≤ y) (hswap : s + y = t + x)
    (hheavy : W ≤ 2 * s) (hlight : 2 * t ≤ W)
    (hsOwnMax : x ≤ sOwnMax) (htOtherMax : x ≤ tOtherMax)
    (hsOtherMax : 0 ≤ sOtherMax) (htOwnMax : 0 ≤ tOwnMax) :
    ScalarMarketEF1 s W sOwnMax sOtherMax ∨
      ScalarMarketEF1 t W tOwnMax tOtherMax := by
  rcases market_crossing_or s t W x y hy hswap with hs | ht
  · left
    constructor <;> linarith
  · right
    constructor <;> linarith

/-- In a prefix containing `a` owned goods and `b` other goods, a deficit of
at most one is equivalent to owning at least half rounded down. -/
theorem prefix_deficit_iff_floor_half (a b : ℕ) :
    b ≤ a + 1 ↔ (a + b) / 2 ≤ a := by
  omega

/-- An even prefix with at least half its goods owned has deficit at most one. -/
theorem even_prefix_deficit
    (a b k : ℕ) (hsize : a + b = 2 * k) (hlower : k ≤ a) :
    b ≤ a + 1 := by
  omega

/-- The even-prefix lower bound also controls the next odd prefix because
owned counts cannot decrease when a prefix is extended. -/
theorem odd_prefix_from_previous_even
    (previousOwned owned other k : ℕ)
    (hsize : owned + other = 2 * k + 1)
    (hlower : k ≤ previousOwned) (hmonotone : previousOwned ≤ owned) :
    other ≤ owned + 1 := by
  omega

/-- Replacing a lower-ranked good by an earlier good cannot reduce the count
in any ranking prefix. Ranks are zero-based or one-based consistently. -/
theorem earlier_exchange_prefix_monotone
    (count insertRank removeRank threshold : ℕ)
    (hearlier : insertRank < removeRank) :
    count ≤ count + (if insertRank ≤ threshold then 1 else 0) -
      (if removeRank ≤ threshold then 1 else 0) := by
  split_ifs <;> omega

/-- Consequently every lower prefix quota survives an earlier-good exchange. -/
theorem earlier_exchange_preserves_lower_quota
    (count quota insertRank removeRank threshold : ℕ)
    (hquota : quota ≤ count) (hearlier : insertRank < removeRank) :
    quota ≤ count + (if insertRank ≤ threshold then 1 else 0) -
      (if removeRank ≤ threshold then 1 else 0) := by
  have h := earlier_exchange_prefix_monotone count insertRank removeRank threshold hearlier
  omega

/-- A single insertion and deletion respect a prefix capacity whenever a
tight prefix receives at least as many deletions as insertions. The separate
combinatorial proof supplies this tight-prefix hypothesis from nesting. -/
theorem exchange_preserves_upper_capacity
    (count capacity inserted deleted : ℕ)
    (hcapacity : count ≤ capacity) (hinserted : inserted ≤ 1)
    (htight : count = capacity → inserted ≤ deleted) :
    count + inserted - deleted ≤ capacity := by
  by_cases ht : count = capacity
  · have hd := htight ht
    omega
  · omega

/-- If the rank-`k` greedy basis meets the two complementary seed bundles in
`a` and `b` goods, the two greedy paths have combined length exactly `k`.
The set-theoretic identification of these counts is proved in the paper. -/
theorem complementary_seed_path_length
    (k a b : ℕ) (hpartition : a + b = k) :
    (k - a) + (k - b) = k := by
  omega

#print axioms market_crossing_or
#print axioms no_two_strict_failures
#print axioms no_two_market_failures
#print axioms crossing_endpoints_market_ef1
#print axioms prefix_deficit_iff_floor_half
#print axioms even_prefix_deficit
#print axioms odd_prefix_from_previous_even
#print axioms earlier_exchange_prefix_monotone
#print axioms earlier_exchange_preserves_lower_quota
#print axioms exchange_preserves_upper_capacity
#print axioms complementary_seed_path_length

end FairDivisionCore
