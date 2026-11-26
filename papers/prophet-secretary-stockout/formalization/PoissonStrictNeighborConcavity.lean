import PoissonNeighborV2
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace StockoutPoissonBridge

/-- The positive Poisson masses have strict log-concavity between
successive triples. The adjacent recurrences give the exact gap. -/
theorem poisson_strict_logconcavity {r : ℝ} (hr : 0 < r) (k : ℕ) :
    poisson r k * poisson r (k+2) < (poisson r (k+1))^2 := by
  have h₁ : ((k : ℝ) + 1) * poisson r (k+1) = r * poisson r k :=
    poisson_succ_mul k
  have h₂ : ((k : ℝ) + 2) * poisson r (k+2) = r * poisson r (k+1) := by
    have h := poisson_succ_mul (r := r) (k+1)
    push_cast at h
    convert h using 1
    ring
  have hdiff :
      r * ((poisson r (k+1))^2 - poisson r k * poisson r (k+2)) =
        poisson r (k+1) * poisson r (k+2) := calc
    _ = (r*poisson r (k+1))*poisson r (k+1) -
        (r*poisson r k)*poisson r (k+2) := by ring
    _ = _ := by rw [← h₁, ← h₂]; ring
  by_contra! h
  have hn : r * ((poisson r (k+1))^2 - poisson r k * poisson r (k+2)) ≤ 0 :=
    mul_nonpos_of_nonneg_of_nonpos hr.le (sub_nonpos.mpr h)
  rw [hdiff] at hn
  exact (not_le_of_gt (mul_pos (poisson_pos hr _) (poisson_pos hr _))) hn

end StockoutPoissonBridge
