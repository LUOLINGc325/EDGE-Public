import Mathlib.Analysis.Convex.Function
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace QuantumTransportPolygonExactnessResearchProof1

theorem spectral_cost_superadditive (f : ℝ → ℝ) (hf : ConvexOn ℝ (Set.Ici 0) f) (h0 : f 0 = 0) (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) : f a+f b ≤ f (a+b) := by
  by_cases hz : a+b=0
  · have ha0 : a=0 := by linarith
    have hb0 : b=0 := by linarith
    simp [ha0,hb0,h0]
  have hp : 0 < a+b := lt_of_le_of_ne (add_nonneg ha hb) (Ne.symm hz)
  let u := a/(a+b)
  let v := b/(a+b)
  have hu : 0 ≤ u := div_nonneg ha hp.le
  have hv : 0 ≤ v := div_nonneg hb hp.le
  have huv : u+v=1 := by dsimp [u,v]; field_simp
  have hzmem : (0:ℝ) ∈ Set.Ici 0 := Set.mem_Ici.mpr le_rfl
  have hsmem : a+b ∈ Set.Ici (0:ℝ) := Set.mem_Ici.mpr hp.le
  have hfa := hf.2 hzmem hsmem hv hu (by linarith : v+u=1)
  have hfb := hf.2 hzmem hsmem hu hv huv
  have hca : u*(a+b)=a := by dsimp [u,v]; field_simp
  have hcb : v*(a+b)=b := by dsimp [u,v]; field_simp
  simp only [smul_eq_mul, hca, h0, mul_zero, zero_add] at hfa
  simp only [smul_eq_mul, hcb, h0, mul_zero, zero_add] at hfb
  have hsum : u*f (a+b)+v*f (a+b) = f (a+b) := by rw [← add_mul, huv, one_mul]
  linarith only [hfa,hfb,hsum]

end QuantumTransportPolygonExactnessResearchProof1
