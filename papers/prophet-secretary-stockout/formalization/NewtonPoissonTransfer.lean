import PoissonNeighborV2
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Tactic.Linarith

namespace StockoutPoissonBridge

/-- Transfer a normalized Newton inequality to the exact relative
log-concavity bound in Equation (5), with center index `k + 1`. -/
theorem newton_poisson_transfer {r : ℝ} (hr : 0 < r) (n k : ℕ) (hk : k + 1 < n)
    (p₀ p₁ p₂ : ℝ) (hp₀ : 0 ≤ p₀) (hp₂ : 0 ≤ p₂)
    (hNewton : (p₀ / (n.choose k : ℝ)) * (p₂ / (n.choose (k + 2) : ℝ)) ≤
      (p₁ / (n.choose (k + 1) : ℝ)) ^ 2) :
    (p₀ / poisson r k) * (p₂ / poisson r (k + 2)) ≤
      (((n : ℝ) - k) / ((n : ℝ) - (k + 1))) *
        (p₀ / poisson r k) * (p₂ / poisson r (k + 2)) ∧
    (((n : ℝ) - k) / ((n : ℝ) - (k + 1))) *
        (p₀ / poisson r k) * (p₂ / poisson r (k + 2)) ≤
      (p₁ / poisson r (k + 1)) ^ 2 := by
  let m : ℝ := n - (k + 1 : ℝ)
  have hm : 0 < m := sub_pos.mpr (by exact_mod_cast hk)
  have hnk : (n : ℝ) - k = m + 1 := by unfold m; ring
  rw [hnk]
  have h₀ : (0 : ℝ) < n.choose k := by exact_mod_cast Nat.choose_pos (by omega : k ≤ n)
  have h₁ : (0 : ℝ) < n.choose (k + 1) := by exact_mod_cast Nat.choose_pos hk.le
  have h₂ : (0 : ℝ) < n.choose (k + 2) := by exact_mod_cast Nat.choose_pos (by omega : k + 2 ≤ n)
  have hk₁ : (k : ℝ) + 1 ≠ 0 := by positivity
  have hk₂ : (k : ℝ) + 2 ≠ 0 := by positivity
  have hc₁ : (n.choose (k + 1) : ℝ) * ((k : ℝ) + 1) =
      (n.choose k : ℝ) * (m + 1) := by
    rw [← hnk, ← Nat.cast_sub (by omega : k ≤ n)]
    exact_mod_cast Nat.choose_succ_right_eq n k
  have hc₂ : (n.choose (k + 2) : ℝ) * ((k : ℝ) + 2) =
      (n.choose (k + 1) : ℝ) * m := by
    rw [show (k : ℝ) + 2 = (((k + 1) + 1 : ℕ) : ℝ) by push_cast; ring]
    rw [show m = ((n - (k + 1) : ℕ) : ℝ) by unfold m; simpa only [Nat.cast_add, Nat.cast_one] using (Nat.cast_sub (R := ℝ) hk.le).symm]
    exact_mod_cast Nat.choose_succ_right_eq n (k + 1)
  have hq₁ := poisson_succ_mul (r := r) k
  have hq₂ : ((k : ℝ) + 2) * poisson r (k + 2) = r * poisson r (k + 1) := by
    have h := poisson_succ_mul (r := r) (k + 1)
    push_cast at h
    convert h using 1
    ring
  have qp₀ := poisson_pos hr k
  have qp₁ := poisson_pos hr (k + 1)
  have qp₂ := poisson_pos hr (k + 2)
  have hChoose :
      (n.choose (k + 1) : ℝ) ^ 2 /
        ((n.choose k : ℝ) * n.choose (k + 2)) =
      ((k : ℝ) + 2) * (m + 1) / (((k : ℝ) + 1) * m) := by
    have heq : ((n.choose (k + 1) : ℝ) ^ 2) * (((k : ℝ) + 1) * m) =
        (((k : ℝ) + 2) * (m + 1)) * ((n.choose k : ℝ) * n.choose (k + 2)) := calc
      _ = ((n.choose (k + 1) : ℝ) * ((k : ℝ) + 1)) *
          ((n.choose (k + 1) : ℝ) * m) := by ring
      _ = _ := by rw [hc₁, ← hc₂]; ring
    exact (div_eq_div_iff (mul_ne_zero h₀.ne' h₂.ne') (mul_ne_zero hk₁ hm.ne')).2 heq
  have hPoisson : poisson r k * poisson r (k + 2) / (poisson r (k + 1)) ^ 2 =
      ((k : ℝ) + 1) / ((k : ℝ) + 2) := by
    have heq : r * ((poisson r k * poisson r (k + 2)) * ((k : ℝ) + 2)) =
        r * (((k : ℝ) + 1) * ((poisson r (k + 1)) ^ 2)) := calc
      _ = (r * poisson r k) * (((k : ℝ) + 2) * poisson r (k + 2)) := by ring
      _ = _ := by rw [← hq₁, hq₂]; ring
    exact (div_eq_div_iff (pow_ne_zero _ qp₁.ne') hk₂).2 (mul_left_cancel₀ hr.ne' heq)
  have hScale := mul_le_mul_of_nonneg_right hNewton
    (sq_nonneg ((n.choose (k + 1) : ℝ) / poisson r (k + 1)))
  have hleft :
      (p₀ / (n.choose k : ℝ) * (p₂ / (n.choose (k + 2) : ℝ))) *
          ((n.choose (k + 1) : ℝ) / poisson r (k + 1)) ^ 2 =
      (((n.choose (k + 1) : ℝ) ^ 2 / ((n.choose k : ℝ) * n.choose (k + 2))) *
        (poisson r k * poisson r (k + 2) / (poisson r (k + 1)) ^ 2)) *
        (p₀ / poisson r k) * (p₂ / poisson r (k + 2)) := by
    field_simp [h₀.ne', h₂.ne', qp₀.ne', qp₁.ne', qp₂.ne']
    ring
  have hright :
      (p₁ / (n.choose (k + 1) : ℝ)) ^ 2 *
        ((n.choose (k + 1) : ℝ) / poisson r (k + 1)) ^ 2 =
      (p₁ / poisson r (k + 1)) ^ 2 := by
    field_simp [h₁.ne', qp₁.ne']
  have hFactor : (((k : ℝ) + 2) * (m + 1) / (((k : ℝ) + 1) * m)) *
      (((k : ℝ) + 1) / ((k : ℝ) + 2)) = (m + 1) / m := by
    field_simp [hm.ne', hk₁, hk₂]
    ring
  have hge : 1 ≤ (m + 1) / m := (le_div_iff₀ hm).2 (by linarith)
  rw [hleft, hright, hChoose, hPoisson, hFactor] at hScale
  exact ⟨by
    have h := mul_le_mul_of_nonneg_right hge
      (div_nonneg hp₀ qp₀.le)
    simpa using mul_le_mul_of_nonneg_right h (div_nonneg hp₂ qp₂.le), hScale⟩

end StockoutPoissonBridge
