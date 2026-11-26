import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

universe u
namespace ExchangeableArithmeticMergingImprovementResearchProof1

theorem two_high_orbit_budget (x y z : ℝ)
         (hx0 : 0 ≤ x) (hx : x < 1) (hy : 1 ≤ y) (hz : 1 ≤ z) (ht : x+y+z < 3) :
         (4+(if (3-x)/2 ≤ y then 1 else 0)+(if (3-x)/2 ≤ z then 1 else 0))/6 ≤
           (x+y+z)/3 := by
  have low : 0 ≤ x ∧ x < 1 := ⟨hx0,hx⟩
  clear hx0 hx
  split_ifs with hy' hz'
  all_goals linarith [low.1, low.2]

end ExchangeableArithmeticMergingImprovementResearchProof1
