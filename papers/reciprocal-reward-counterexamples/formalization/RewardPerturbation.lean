import FiniteRewardGame
import FourVertexGame

/-! Proposition 2 for actual, independently variable vertex rewards. -/

set_option autoImplicit false
open Finset
open scoped BigOperators

namespace ReciprocalSearch.FourVertex

noncomputable section

def unitGame : RewardGame Action Vertex where
  reward := reward
  safe a v := v ∉ edge a
  reward_pos := reward_pos

def weightedReward (w : Vertex → ℝ) (a : Action) : ℝ := ∑ v ∈ edge a, w v

lemma edge_nonempty (a : Action) : (edge a).Nonempty := by
  apply Finset.nonempty_iff_ne_empty.mpr
  intro h
  have hp := reward_pos a
  simp [reward, h] at hp

def weightedGame (w : Vertex → ℝ) (hw : ∀ v, 0 < w v) : RewardGame Action Vertex where
  reward := weightedReward w
  safe a v := v ∉ edge a
  reward_pos a := sum_pos (fun v _ => hw v) (edge_nonempty a)

lemma unit_payoff_eq (a : Action) (v : Vertex) : unitGame.payoff a v = payoff a v := by
  classical
  by_cases h : v ∈ edge a <;> simp [RewardGame.payoff, unitGame, payoff, h]

lemma unit_expected_eq (p : Action → ℝ) (v : Vertex) : unitGame.expected p v = expected p v := by
  simp only [RewardGame.expected, unit_payoff_eq, expected]

lemma unit_guarantee_eq (p : Action → ℝ) : unitGame.guarantee p = guarantee p := by
  apply le_antisymm
  · exact (le_guarantee_iff p _).mpr fun v => by
      rw [← unit_expected_eq]
      exact unitGame.guarantee_le_expected p v
  · apply (unitGame.le_guarantee_iff p _).mpr
    intro v
    rw [unit_expected_eq]
    exact (le_guarantee_iff p _).mp le_rfl v

lemma unit_normalizer_eq (s : Finset Action) : unitGame.normalizer s = normalizer s := by
  classical
  unfold RewardGame.normalizer normalizer inverseWeight
  rw [← sum_filter, filter_univ_mem]
  rfl

lemma unit_reciprocal_eq (s : Finset Action) : unitGame.reciprocal s = reciprocal s := by
  funext a
  by_cases ha : a ∈ s <;>
    simp only [RewardGame.reciprocal, reciprocal, inverseWeight, ha, if_true, if_false,
      unit_normalizer_eq, zero_div]
  rfl

theorem weighted_four_vertex_gap (w : Vertex → ℝ) (hw : ∀ v, 0 < w v)
    (ε : ℝ) (he : 0 ≤ ε) (hemax : ε < 3 / 29)
    (hlo : ∀ v, 1 - ε ≤ w v) (hhi : ∀ v, w v ≤ 1 + ε) :
    let g := weightedGame w hw
    (9 - 87 * ε) / 52 ≤ g.value - g.reciprocalValue ∧ g.reciprocalValue < g.value := by
  dsimp
  have hbounds := unitGame.perturbation_bounds (weightedGame w hw)
    (fun _ _ => Iff.rfl) (1 - ε) (1 + ε) (by linarith) (by linarith)
    (fun a => by
      change (1 - ε) * (∑ v ∈ edge a, (1 : ℝ)) ≤ ∑ v ∈ edge a, w v
      rw [mul_sum]
      exact sum_le_sum fun v _ => by simpa only [mul_one] using hlo v)
    (fun a => by
      change (∑ v ∈ edge a, w v) ≤ (1 + ε) * (∑ v ∈ edge a, (1 : ℝ))
      rw [mul_sum]
      exact sum_le_sum fun v _ => by simpa only [mul_one] using hhi v)
    searcherStar searcherStar_probability (3 / 4)
    (fun s _ => by
      rw [unit_reciprocal_eq, unit_guarantee_eq]
      exact all_reciprocal_supports_bound s)
  rw [unit_guarantee_eq, searcherStar_guarantee] at hbounds
  constructor
  · linarith [hbounds.1, hbounds.2]
  · linarith [hbounds.1, hbounds.2]

theorem positive_distinct_weight_counterexample :
    ∃ (w : Vertex → ℝ) (hw : ∀ v, 0 < w v), Function.Injective w ∧
      (weightedGame w hw).reciprocalValue < (weightedGame w hw).value := by
  let w (v : Vertex) : ℝ := 1 + (v.val : ℝ) / 100
  have hw (v : Vertex) : 0 < w v := by dsimp [w]; positivity
  refine ⟨w, hw, ?_, ?_⟩
  · intro i j h
    apply Fin.ext
    have hc : (i.val : ℝ) = j.val := by dsimp [w] at h; linarith
    exact_mod_cast hc
  · exact (weighted_four_vertex_gap w hw (3 / 100) (by norm_num) (by norm_num)
      (fun v => by
        dsimp [w]
        linarith [Nat.cast_nonneg (α := ℝ) v.val])
      (fun v => by
        dsimp [w]
        have h : (v.val : ℝ) ≤ 3 := by exact_mod_cast (show v.val ≤ 3 by omega)
        linarith)).2

end
end ReciprocalSearch.FourVertex

#print axioms ReciprocalSearch.FourVertex.weighted_four_vertex_gap
#print axioms ReciprocalSearch.FourVertex.positive_distinct_weight_counterexample
