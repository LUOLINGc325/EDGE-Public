import FiniteRewardGame
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Topology.Algebra.Order.Field
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

/-! Theorem 3. The center is `none`; `some i` labels a leaf. The none
action is the whole set of leaves, and each other action is one spoke. -/

set_option autoImplicit false
open Finset
open Filter
open scoped Topology

namespace ReciprocalSearch.StarFamily

open Classical

abbrev Index (m : ℕ) := Option (Fin m)

noncomputable def edge {m : ℕ} : Index m → Finset (Index m)
  | none => univ.erase none
  | some i => {none, some i}

lemma edge_card_none (m : ℕ) : (edge (none : Index m)).card = m := by
  simp [edge, card_erase_of_mem (mem_univ _)]

lemma edge_card_some {m : ℕ} (i : Fin m) : (edge (some i)).card = 2 := by simp [edge]

noncomputable def game (m : ℕ) (hm : 0 < m) : RewardGame (Index m) (Index m) where
  reward a := (edge a).card
  safe a h := h ∉ edge a
  reward_pos a := by
    cases a with
    | none => exact_mod_cast (edge_card_none m ▸ hm)
    | some i => simp [edge_card_some i]

lemma spoke_payoff {m : ℕ} (hm : 0 < m) (i j : Fin m) :
    (game m hm).payoff (some i) (some j) = if i = j then 0 else 2 := by
  classical
  by_cases he : i = j
  · subst j
    simp [RewardGame.payoff, game, edge]
  · have hne : j ≠ i := Ne.symm he
    simp [RewardGame.payoff, game, edge, he, hne]

lemma center_payoff {m : ℕ} (hm : 0 < m) :
    (game m hm).payoff none none = m := by
  simp [RewardGame.payoff, game, edge_card_none, edge]

lemma center_leaf_payoffs {m : ℕ} (hm : 0 < m) (i : Fin m) :
    (game m hm).payoff none (some i) = 0 ∧ (game m hm).payoff (some i) none = 0 := by
  simp [RewardGame.payoff, game, edge]

lemma payoff_symm {m : ℕ} (hm : 0 < m) (a h : Index m) :
    (game m hm).payoff a h = (game m hm).payoff h a := by
  cases a with
  | none =>
    cases h with
    | none => rfl
    | some j => rw [(center_leaf_payoffs hm j).1, (center_leaf_payoffs hm j).2]
  | some i =>
    cases h with
    | none => rw [(center_leaf_payoffs hm i).1, (center_leaf_payoffs hm i).2]
    | some j => simp only [spoke_payoff hm, eq_comm]

noncomputable def denom (m : ℕ) : ℝ := (m : ℝ) ^ 2 + 2 * m - 2

noncomputable def familyValue (m : ℕ) : ℝ := 2 * (m : ℝ) * (m - 1) / denom m

noncomputable def familyStar (m : ℕ) : Index m → ℝ
  | none => 2 * ((m : ℝ) - 1) / denom m
  | some _ => m / denom m

lemma denom_pos {m : ℕ} (hm : 2 ≤ m) : 0 < denom m := by
  have h : (2 : ℝ) ≤ m := by exact_mod_cast hm
  unfold denom
  nlinarith

theorem family_star_pos {m : ℕ} (hm : 2 ≤ m) (a : Index m) : 0 < familyStar m a := by
  have h : (2 : ℝ) ≤ m := by exact_mod_cast hm
  cases a with
  | none => exact div_pos (by linarith) (denom_pos hm)
  | some _ => exact div_pos (by linarith) (denom_pos hm)

theorem family_star_probability {m : ℕ} (hm : 2 ≤ m) : RewardGame.Probability (familyStar m) := by
  refine ⟨fun a => (family_star_pos hm a).le, ?_⟩
  classical
  rw [Fintype.sum_option]
  simp only [familyStar, sum_const, card_univ, Fintype.card_fin, nsmul_eq_mul]
  have h := (denom_pos hm).ne'
  field_simp
  unfold denom
  ring

lemma expected_at_center {m : ℕ} (hm : 0 < m) (p : Index m → ℝ) :
    (game m hm).expected p none = (m : ℝ) * p none := by
  rw [RewardGame.expected, Fintype.sum_option, center_payoff hm]
  simp [(center_leaf_payoffs hm _).2, mul_comm]

lemma expected_at_leaf {m : ℕ} (hm : 0 < m) (p : Index m → ℝ) (j : Fin m) :
    (game m hm).expected p (some j) =
      2 * ((∑ i : Fin m, p (some i)) - p (some j)) := by
  classical
  rw [RewardGame.expected, Fintype.sum_option, (center_leaf_payoffs hm j).1, mul_zero, zero_add]
  have hsplit := sum_erase_add (univ : Finset (Fin m))
    (fun i => p (some i) * (game m hm).payoff (some i) (some j)) (mem_univ j)
  rw [← hsplit]
  dsimp only
  rw [spoke_payoff hm j j, if_pos (rfl : j = j), mul_zero, add_zero]
  have hs : (∑ i ∈ univ.erase j, p (some i) * (game m hm).payoff (some i) (some j)) =
      ∑ i ∈ univ.erase j, p (some i) * 2 := by
    apply sum_congr rfl
    intro i hi
    rw [spoke_payoff hm i j, if_neg (ne_of_mem_erase hi)]
  rw [hs, ← sum_mul]
  linarith [sum_erase_add univ (fun i : Fin m => p (some i)) (mem_univ j)]

theorem family_star_columns {m : ℕ} (hm : 2 ≤ m) (h : Index m) :
    (game m (by omega)).expected (familyStar m) h = familyValue m := by
  have hm0 : 0 < m := by omega
  have hD := (denom_pos hm).ne'
  cases h with
  | none => rw [expected_at_center hm0]; unfold familyStar familyValue; ring
  | some j =>
    rw [expected_at_leaf hm0]
    simp only [familyStar, sum_const, card_univ, Fintype.card_fin, nsmul_eq_mul, familyValue]
    ring

theorem family_star_rows {m : ℕ} (hm : 2 ≤ m) (a : Index m) :
    (game m (by omega)).rowExpected (familyStar m) a = familyValue m := by
  have he := family_star_columns hm a
  unfold RewardGame.expected at he
  simpa only [RewardGame.rowExpected, payoff_symm (show 0 < m by omega) a] using he

theorem family_value_exact {m : ℕ} (hm : 2 ≤ m) :
    (game m (by omega)).value = familyValue m :=
  (game m (by omega)).value_of_equalizing _ _
    (family_star_probability hm) (family_star_probability hm) _
    (family_star_columns hm) (family_star_rows hm)

theorem family_searcher_unique {m : ℕ} (hm : 2 ≤ m) (p : Index m → ℝ)
    (hp : RewardGame.Probability p) (hopt : familyValue m ≤ (game m (by omega)).guarantee p) :
    p = familyStar m := by
  have hm0 : 0 < m := by omega
  have hmp : (0 : ℝ) < m := by exact_mod_cast hm0
  have hq := family_star_probability hm
  have hcols := (game m hm0).optimal_columns_eq_of_full_support p (familyStar m) hp hq
    (family_star_pos hm) (familyValue m) hopt (family_star_rows hm)
  have h0 := (hcols none).trans (family_star_columns hm none).symm
  rw [expected_at_center hm0, expected_at_center hm0] at h0
  have h0' : p none = familyStar m none := (mul_left_cancel₀ hmp.ne') h0
  have hmass := hp.2.trans hq.2.symm
  rw [Fintype.sum_option, Fintype.sum_option, h0'] at hmass
  have hmass' := add_left_cancel hmass
  funext i
  cases i with
  | none => exact h0'
  | some j =>
    have h := (hcols (some j)).trans (family_star_columns hm (some j)).symm
    rw [expected_at_leaf hm0, expected_at_leaf hm0, hmass'] at h
    linarith

theorem family_hider_unique {m : ℕ} (hm : 2 ≤ m) (q : Index m → ℝ)
    (hq : RewardGame.Probability q) (hopt : ∀ a, (game m (by omega)).rowExpected q a ≤ familyValue m) :
    q = familyStar m := by
  have hm0 : 0 < m := by omega
  have hp := family_star_probability hm
  have hcol (h : Index m) : (game m hm0).expected q h ≤ familyValue m := by
    simpa only [RewardGame.expected, RewardGame.rowExpected, payoff_symm hm0 h] using hopt h
  have hsum : ∑ h, familyStar m h * (familyValue m - (game m hm0).expected q h) = 0 := by
    simp only [mul_sub, sum_sub_distrib, RewardGame.mixed_expected_swap, family_star_rows hm]
    simp_rw [← sum_mul, hp.2, hq.2, one_mul, sub_self]
  apply family_searcher_unique hm q hq
  apply ((game m hm0).le_guarantee_iff q _).mpr
  intro h
  have hn (j : Index m) : 0 ≤ familyStar m j * (familyValue m - (game m hm0).expected q j) :=
    mul_nonneg (hp.1 j) (sub_nonneg.mpr (hcol j))
  have hle := single_le_sum (fun j _ => hn j) (mem_univ h)
  rw [hsum] at hle
  exact sub_nonpos.mp (nonpos_of_mul_nonpos_right hle (family_star_pos hm h))

noncomputable def spokeSupport {m : ℕ} (s : Finset (Index m)) : Finset (Fin m) :=
  univ.filter fun i => some i ∈ s

lemma some_mem_spokeSupport {m : ℕ} {s : Finset (Index m)} {i : Fin m} :
    i ∈ spokeSupport s ↔ some i ∈ s := by simp [spokeSupport]

lemma support_normalizer {m : ℕ} (hm : 0 < m) (s : Finset (Index m)) :
    (game m hm).normalizer s =
      (if none ∈ s then 1 / (m : ℝ) else 0) + (spokeSupport s).card / 2 := by
  classical
  unfold RewardGame.normalizer
  rw [← filter_univ_mem s, sum_filter, Fintype.sum_option]
  have hspoke : (∑ i : Fin m, if some i ∈ s then 1 / (game m hm).reward (some i) else 0) =
      (spokeSupport s).card / 2 := by
    rw [← sum_filter]
    simp only [spokeSupport, game, edge_card_some, Nat.cast_ofNat]
    simp [div_eq_mul_inv]
  rw [filter_univ_mem, hspoke]
  simp only [game, edge_card_none]

lemma center_safe_support {m : ℕ} (hm : 0 < m) (s : Finset (Index m)) :
    (s.filter fun a => (game m hm).safe a none) = s.filter fun a => a = none := by
  classical
  ext a
  cases a <;> simp [game, edge]

theorem support_guarantee_zero_of_missing_center {m : ℕ} (hm : 0 < m)
    (s : Finset (Index m)) (hn : none ∉ s) :
    (game m hm).guarantee ((game m hm).reciprocal s) = 0 := by
  classical
  apply le_antisymm
  · apply ((game m hm).guarantee_le_expected _ none).trans
    have hz : (s.filter fun a => a = none) = ∅ := by
      apply filter_eq_empty_iff.mpr
      intro a ha he
      exact hn (he ▸ ha)
    rw [RewardGame.reciprocal_expected, center_safe_support, hz]
    simp
  · apply ((game m hm).le_guarantee_iff _ _).mpr
    intro h
    rw [RewardGame.reciprocal_expected]
    by_cases hs : s.Nonempty
    · exact div_nonneg (Nat.cast_nonneg _) ((game m hm).normalizer_pos hs).le
    · rw [Finset.not_nonempty_iff_eq_empty.mp hs]
      simp

theorem support_guarantee_zero_of_at_most_one_spoke {m : ℕ} (hm : 0 < m)
    (s : Finset (Index m)) (hs : s.Nonempty) (hcount : (spokeSupport s).card ≤ 1) :
    (game m hm).guarantee ((game m hm).reciprocal s) = 0 := by
  classical
  letI : Nonempty (Fin m) := ⟨⟨0, hm⟩⟩
  obtain ⟨j, hj⟩ := card_le_one_iff_subset_singleton.mp hcount
  apply le_antisymm
  · apply ((game m hm).guarantee_le_expected _ (some j)).trans
    rw [RewardGame.reciprocal_expected]
    have hempty : s.filter (fun a => (game m hm).safe a (some j)) = ∅ := by
      apply Finset.filter_eq_empty_iff.mpr
      intro a ha
      cases a with
      | none => simp [game, edge]
      | some i =>
        have heq : i = j := Finset.mem_singleton.mp (hj (some_mem_spokeSupport.mpr ha))
        subst i
        simp [game, edge]
    simp [hempty]
  · apply ((game m hm).le_guarantee_iff _ _).mpr
    intro h
    rw [RewardGame.reciprocal_expected]
    exact div_nonneg (Nat.cast_nonneg _) ((game m hm).normalizer_pos hs).le

theorem support_guarantee_of_center_two_spokes {m : ℕ} (hm : 0 < m)
    (s : Finset (Index m)) (hn : none ∈ s) (hcount : 1 < (spokeSupport s).card) :
    (game m hm).guarantee ((game m hm).reciprocal s) = 1 / (game m hm).normalizer s := by
  classical
  have hnorm := (game m hm).normalizer_pos (show s.Nonempty from ⟨none, hn⟩)
  have hcenter : (s.filter (fun a => (game m hm).safe a none)).card = 1 := by
    rw [center_safe_support]
    have hf : s.filter (fun a => a = none) = {none} := by
      ext a
      cases a <;> simp [hn]
    rw [hf, card_singleton]
  apply le_antisymm
  · rw [← Nat.cast_one, ← hcenter, ← RewardGame.reciprocal_expected]
    exact (game m hm).guarantee_le_expected _ none
  · apply ((game m hm).le_guarantee_iff _ _).mpr
    intro h
    rw [RewardGame.reciprocal_expected]
    apply div_le_div_of_nonneg_right _ hnorm.le
    rw [← Nat.cast_one, Nat.cast_le]
    cases h with
    | none => omega
    | some j =>
      obtain ⟨i, hi, hne⟩ := exists_ne_of_one_lt_card hcount j
      have hmem : some i ∈ s.filter (fun a => (game m hm).safe a (some j)) := by
        apply mem_filter.mpr
        exact ⟨some_mem_spokeSupport.mp hi, by simp [game, edge, Ne.symm hne]⟩
      exact card_pos.mpr ⟨some i, hmem⟩

theorem family_reciprocal_value_exact {m : ℕ} (hm : 2 ≤ m) :
    (game m (by omega)).reciprocalValue = (m : ℝ) / (m + 1) := by
  classical
  have hm0 : 0 < m := by omega
  have hmr : (0 : ℝ) < m := by exact_mod_cast hm0
  let i : Fin m := ⟨0, hm0⟩
  let j : Fin m := ⟨1, by omega⟩
  have hij : i ≠ j := fun h => Nat.zero_ne_one (congrArg Fin.val h)
  let s : Finset (Index m) := {none, some i, some j}
  have hcount : (spokeSupport s).card = 2 := by
    have hs : spokeSupport s = {i, j} := by ext k; simp [spokeSupport, s]
    rw [hs, card_pair hij]
  have hformula : 1 / (1 / (m : ℝ) + 1) = (m : ℝ) / (m + 1) := by
    have hp : (0 : ℝ) < (m : ℝ) + 1 := by positivity
    field_simp [hmr.ne', hp.ne']
    simp [add_comm]
  apply IsGreatest.csSup_eq
  constructor
  · refine ⟨s, ⟨none, by simp [s]⟩, ?_⟩
    rw [support_guarantee_of_center_two_spokes hm0 s (by simp [s]) (by omega),
      support_normalizer hm0 s, if_pos (show none ∈ s by simp [s]), hcount]
    simpa [one_div] using hformula
  · rintro t ⟨f, hne, rfl⟩
    by_cases hc : none ∈ f
    · by_cases hn : 1 < (spokeSupport f).card
      · rw [support_guarantee_of_center_two_spokes hm0 f hc hn, support_normalizer hm0 f,
          if_pos hc, ← hformula]
        have hcast : (2 : ℝ) ≤ (spokeSupport f).card := by exact_mod_cast hn
        apply one_div_le_one_div_of_le (by positivity)
        linarith
      · rw [support_guarantee_zero_of_at_most_one_spoke hm0 f hne (by omega)]
        positivity
    · rw [support_guarantee_zero_of_missing_center hm0 f hc]
      positivity

theorem family_gap_and_ratio {m : ℕ} (hm : 2 ≤ m) :
    let W := (m : ℝ) / (m + 1)
    familyValue m - W = (m : ℝ)^2 * (m - 2) / (denom m * (m + 1)) ∧
      W / familyValue m = denom m / (2 * ((m : ℝ)^2 - 1)) := by
  dsimp
  have hm2 : (2 : ℝ) ≤ m := by exact_mod_cast hm
  have hD := (denom_pos hm).ne'
  have hm0 : (m : ℝ) ≠ 0 := by linarith
  have hm1 : (m : ℝ) - 1 ≠ 0 := by linarith
  have hp : (m : ℝ) + 1 ≠ 0 := by linarith
  have hsq : (m : ℝ)^2 - 1 ≠ 0 := by nlinarith
  unfold familyValue
  constructor <;> field_simp <;> unfold denom <;> ring

theorem family_ratio_tends_half :
    Tendsto (fun m : ℕ => ((m : ℝ) / (m + 1)) / familyValue m) atTop (𝓝 (1 / 2)) := by
  have hnat : Tendsto (fun m : ℕ => (m : ℝ)) atTop atTop := tendsto_natCast_atTop_atTop
  have hsmall : Tendsto (fun m : ℕ => (m : ℝ)⁻¹) atTop (𝓝 0) :=
    tendsto_inv_atTop_zero.comp hnat
  have hsq := hsmall.pow 2
  have htop := ((hsmall.const_mul (2 : ℝ)).const_add 1).sub (hsq.const_mul 2)
  have hconst : Tendsto (fun _ : ℕ => (1 : ℝ)) atTop (𝓝 1) := tendsto_const_nhds
  have hbot := (hconst.sub hsq).const_mul (2 : ℝ)
  have h : Tendsto (fun m : ℕ => (1 + 2 * (m : ℝ)⁻¹ - 2 * ((m : ℝ)⁻¹)^2) /
      (2 * (1 - ((m : ℝ)⁻¹)^2))) atTop (𝓝 (1 / 2)) := by
    simpa using htop.div hbot (by norm_num)
  apply h.congr'
  filter_upwards [eventually_ge_atTop (2 : ℕ)] with m hm
  simp only [(family_gap_and_ratio hm).2]
  have hm2 : (2 : ℝ) ≤ m := by exact_mod_cast hm
  have hm0 : (m : ℝ) ≠ 0 := by linarith
  have hsq : (m : ℝ)^2 - 1 ≠ 0 := by nlinarith
  have hd : 1 - ((m : ℝ)⁻¹)^2 ≠ 0 := by
    intro he
    field_simp at he
    nlinarith
  unfold denom
  field_simp
  ring

theorem family_strict_loss {m : ℕ} (hm : 3 ≤ m) :
    (game m (by omega)).reciprocalValue < (game m (by omega)).value := by
  have hm2 : 2 ≤ m := by omega
  rw [family_reciprocal_value_exact hm2, family_value_exact hm2, ← sub_pos, (family_gap_and_ratio hm2).1]
  have h : (3 : ℝ) ≤ m := by exact_mod_cast hm
  have hD := denom_pos hm2
  have hn : 0 < (m : ℝ) - 2 := by linarith
  positivity

theorem family_boundary_two :
    (game 2 (by decide)).reciprocalValue = (game 2 (by decide)).value := by
  rw [family_reciprocal_value_exact (by decide : 2 ≤ 2), family_value_exact (by decide : 2 ≤ 2)]
  norm_num [familyValue, denom]

end ReciprocalSearch.StarFamily

#print axioms ReciprocalSearch.StarFamily.family_value_exact
#print axioms ReciprocalSearch.StarFamily.family_searcher_unique
#print axioms ReciprocalSearch.StarFamily.family_hider_unique
#print axioms ReciprocalSearch.StarFamily.family_reciprocal_value_exact
#print axioms ReciprocalSearch.StarFamily.family_gap_and_ratio
#print axioms ReciprocalSearch.StarFamily.family_ratio_tends_half
#print axioms ReciprocalSearch.StarFamily.family_strict_loss
#print axioms ReciprocalSearch.StarFamily.family_boundary_two
