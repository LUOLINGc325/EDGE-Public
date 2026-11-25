import WorstFactor
import Mathlib.Data.Fin.VecNotation
import Mathlib.Tactic.FinCases

open scoped BigOperators

namespace TwoColorNullity

def matchingCount (items r : ℕ) : ℕ := items.descFactorial (2 * r) / (r.factorial * 2 ^ r)

theorem matchingCount_correct (items r : ℕ) :
    matchingCount items r = Fintype.card (UnorderedMatching (Fin items) r) := by
  unfold matchingCount
  rw [← unordered_matchings_count_mul, Nat.mul_div_cancel _ (by positivity)]

def commonExponent (n : ℕ) : ℕ := n * n / 4

theorem termExponent_le (n s : ℕ) (hs : s ≤ n) : (n - s) * s ≤ commonExponent n := by
  let r := n - s
  have hsum : r + s = n := Nat.sub_add_cancel hs
  have hsumR : (r : ℝ) + (s : ℝ) = n := by exact_mod_cast hsum
  have hr : 4 * (r : ℝ) * (s : ℝ) ≤ (n : ℝ) * n := by
    rw [← hsumR]
    nlinarith only [sq_nonneg ((r : ℝ) - s)]
  unfold commonExponent
  apply (Nat.le_div_iff_mul_le (by decide : 0 < 4)).mpr
  have hc : r * s * 4 ≤ n * n := by
    exact_mod_cast (show (r : ℝ) * (s : ℝ) * (4 : ℝ) ≤ (n : ℝ) * n by linarith)
  exact hc

def upperNumerator (n cutoff : ℕ) : ℕ :=
  ∑ s ∈ Finset.Icc cutoff (n - 1),
    Nat.fast_choose n s * matchingCount (3 * n - 1) (n - s) *
      2 ^ (commonExponent n - (n - s) * s)

theorem upperNumerator_certifies (n cutoff : ℕ) (hn : 2 ≤ n) :
    finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
        cutoff ≤ maximumFeasibleOwners (profileTag bits)) ≤
      (upperNumerator n cutoff : ℝ) / 2 ^ commonExponent n := by
  refine (finite_large_set_tail n cutoff hn).trans ?_
  apply le_of_eq
  unfold upperNumerator
  rw [Nat.cast_sum, Finset.sum_div]
  apply Finset.sum_congr rfl
  intro s hs
  have hsLe : s ≤ n := (Finset.mem_Icc.mp hs).2.trans (Nat.sub_le _ _)
  have h := termExponent_le n s hsLe
  have hexp : (2 : ℝ) ^ commonExponent n =
      (2 : ℝ) ^ (commonExponent n - (n - s) * s) * (2 : ℝ) ^ ((n - s) * s) := by
    rw [← pow_add, Nat.sub_add_cancel h]
  rw [← Nat.choose_eq_fast_choose, matchingCount_correct, Nat.cast_mul, Nat.cast_mul,
    Nat.cast_pow, Nat.cast_ofNat, div_pow, one_pow, hexp]
  field_simp

structure FiniteEstimate where
  agents : ℕ
  cutoff : ℕ
  upperMillionths : ℕ
  lowerFactor : ℕ
  upperFactor : ℕ

def manuscriptEstimates : Fin 5 → FiniteEstimate := ![
  ⟨32, 10, 121, 3, 7⟩,
  ⟨64, 10, 1, 6, 11⟩,
  ⟨128, 10, 2704, 14, 19⟩,
  ⟨256, 11, 1, 25, 32⟩,
  ⟨512, 12, 1, 46, 57⟩]

set_option maxRecDepth 16384 in
set_option maxHeartbeats 4000000 in
theorem manuscriptNumerators (i : Fin 5) :
    let row := manuscriptEstimates i
    upperNumerator row.agents row.cutoff * 1000000 ≤
      row.upperMillionths * 2 ^ commonExponent row.agents := by
  fin_cases i <;> decide +kernel

private theorem manuscriptFactors (i : Fin 5) :
    let row := manuscriptEstimates i
    2 ≤ row.agents ∧ 0 < row.cutoff - 1 ∧ row.upperMillionths < 1000000 ∧
      (row.agents - 1) ⌈/⌉ (row.cutoff - 1) - 1 = row.lowerFactor ∧
      (row.agents - 1) ⌈/⌉ row.agents.log2 = row.upperFactor := by
  fin_cases i <;> decide +kernel

theorem finite_estimate_table (i : Fin 5) :
    let row := manuscriptEstimates i
    finiteProbability (fun bits : BitProfile row.agents (3 * row.agents - 1) =>
        row.cutoff ≤ maximumFeasibleOwners (profileTag bits)) ≤ (row.upperMillionths : ℝ) / 1000000 ∧
      (row.lowerFactor : ℝ) ≤ fixedItemWorst row.agents ∧ fixedItemWorst row.agents ≤ row.upperFactor := by
  dsimp only
  let row := manuscriptEstimates i
  obtain ⟨hn, hcut, hmillion, hlo, hhi⟩ := manuscriptFactors i
  have hnum := manuscriptNumerators i
  have hnumR : (upperNumerator row.agents row.cutoff : ℝ) * 1000000 ≤
      (row.upperMillionths : ℝ) * 2 ^ commonExponent row.agents := by exact_mod_cast hnum
  have hp := (upperNumerator_certifies row.agents row.cutoff hn).trans
    ((div_le_div_iff₀ (by positivity) (by norm_num)).mpr hnumR)
  have hless : (row.upperMillionths : ℝ) / 1000000 < 1 := by
    apply (div_lt_iff₀ (by norm_num)).mpr
    simpa only [one_mul] using (show (row.upperMillionths : ℝ) < 1000000 by exact_mod_cast hmillion)
  obtain ⟨bits, hgood⟩ := exists_good_profile row.agents row.cutoff (hp.trans_lt hless)
  have hgood' : maximumFeasibleOwners (profileTag bits) ≤ row.cutoff - 1 := by omega
  have lower := good_profile_lower row.agents hn _ hcut bits hgood'
  have upper := fixedItemWorst_upper row.agents hn
  change finiteProbability (fun bits : BitProfile row.agents (3 * row.agents - 1) =>
       row.cutoff ≤ maximumFeasibleOwners (profileTag bits)) ≤ (row.upperMillionths : ℝ) / 1000000 ∧
    (row.lowerFactor : ℝ) ≤ fixedItemWorst row.agents ∧ fixedItemWorst row.agents ≤ row.upperFactor
  rw [hlo] at lower
  rw [hhi] at upper
  exact ⟨hp, lower.trans (optimalFactor_le_fixedItemWorst row.agents hn bits), upper⟩

end TwoColorNullity
