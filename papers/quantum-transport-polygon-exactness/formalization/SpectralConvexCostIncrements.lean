import Mathlib.Data.Real.Basic
import Mathlib.Analysis.Convex.Slope
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

open scoped BigOperators

namespace QuantumTransportPolygonExactnessResearchProof1

theorem spectral_cost_increment (f : ℝ → ℝ) (hf : ConvexOn ℝ (Set.Ici 0) f) (a b h : ℝ) (ha : 0 ≤ a) (hab : a ≤ b) (hh : 0 ≤ h) : f (a+h)-f a ≤ f (b+h)-f b := by
  by_cases hz : b+h-a = 0
  · have he : b = a := by linarith
    simp [he]
  have hp : 0 < b+h-a := lt_of_le_of_ne (by linarith) (Ne.symm hz)
  let u := (b-a)/(b+h-a)
  let v := h/(b+h-a)
  have hu : 0 ≤ u := div_nonneg (sub_nonneg.mpr hab) hp.le
  have hv : 0 ≤ v := div_nonneg hh hp.le
  have huv : u+v=1 := by dsimp [u,v]; field_simp; ring
  have hca : u*a+v*(b+h)=a+h := by dsimp [u,v]; field_simp; ring
  have hcb : v*a+u*(b+h)=b := by dsimp [u,v]; field_simp; ring
  have hma : a ∈ Set.Ici (0:ℝ) := ha
  have hmb : b+h ∈ Set.Ici (0:ℝ) := by exact add_nonneg (ha.trans hab) hh
  have hfa := hf.2 hma hmb hu hv huv
  have hfb := hf.2 hma hmb hv hu (by linarith : v+u=1)
  simp only [smul_eq_mul, hca] at hfa
  simp only [smul_eq_mul, hcb] at hfb
  have hsum : u*f a+v*f (b+h)+ (v*f a+u*f (b+h)) = f a + f (b+h) := by
    calc
      _ = (u+v)*f a + (u+v)*f (b+h) := by ring
      _ = _ := by simp [huv]
  linarith only [hfa,hfb,hsum]

end QuantumTransportPolygonExactnessResearchProof1
