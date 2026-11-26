import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace PreciseMergersWithoutSymmetry

/-- One-coordinate part of Theorem 1: under the two-point expectation identity,
the function is affine in the single-coordinate interpolation form. -/
theorem affine_of_two_point
    (f : ℝ → ℝ) (hf1 : f 1 = 1)
    (h : ∀ l r : ℝ, 0 ≤ l → l < 1 → 1 < r →
      (r - 1) * f l + (1 - l) * f r = r - l) :
    ∀ t : ℝ, 0 ≤ t → f t = 1 + (t - 1) * (f 2 - f 1) := by
  -- First, the relation f 0 + f 2 = 2.
  have h02 : f 0 + f 2 = 2 := by
    have h1 := h 0 2 (by norm_num) (by norm_num) (by norm_num)
    norm_num at h1
    linarith
  -- Rewrite f 0 = 2 - f 2.
  have hf0 : f 0 = 2 - f 2 := by linarith
  intro t ht
  rcases lt_trichotomy t 1 with hlt | heq | hgt
  · -- Case t < 1: use l = t, r = 2.
    have h2 := h t 2 ht hlt (by norm_num)
    -- h2 : (2 - 1) * f t + (1 - t) * f 2 = 2 - t
    have he : f t = 1 + (t - 1) * (f 2 - 1) := by nlinarith
    rw [he, hf1]
  · -- Case t = 1.
    subst heq
    rw [hf1]; ring
  · -- Case t > 1: use l = 0, r = t.
    have h3 := h 0 t (by norm_num) (by norm_num) hgt
    -- h3 : (t - 1) * f 0 + (1 - 0) * f t = t - 0
    have he : f t = t - (t - 1) * f 0 := by nlinarith
    rw [he, hf0, hf1]
    ring

end PreciseMergersWithoutSymmetry
