import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

universe u
namespace WeightedConformalPoissonTransferResearchProof1

theorem light_score_jump_gap (K g x y : ℝ) (hK : 0 ≤ K) (hx : x ≤ g) (hy : g < y) :
         K/(1+K) <
           (y+(if g < y then K else 0))/(1+K)-(x+(if g < x then K else 0))/(1+K) := by
  have hpos : 0 < 1+K := by linarith only [hK]
  simp only [if_pos hy, if_neg (not_lt_of_ge hx), add_zero]
  rw [← sub_div]
  apply (div_lt_div_iff_of_pos_right hpos).2
  linarith only [hx,hy]

end WeightedConformalPoissonTransferResearchProof1
