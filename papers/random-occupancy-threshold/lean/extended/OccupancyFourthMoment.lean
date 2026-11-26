import FiniteBoundedDifferences
import Mathlib.Analysis.SpecialFunctions.Pow.Real

namespace TwoColorNullity.Occupancy

private theorem fourth_power_le_exp_pair (v : ℝ) : v ^ 4 ≤ 24 * (Real.exp v + Real.exp (-v)) := by
  have positive (w : ℝ) (hw : 0 ≤ w) : w ^ 4 ≤ 24 * Real.exp w := by
    have h := Real.pow_div_factorial_le_exp w hw 4
    have hfac : (Nat.factorial 4 : ℝ) = 24 := by norm_num [Nat.factorial]
    rw [hfac] at h
    simpa only [mul_comm] using (div_le_iff₀ (by norm_num : (0 : ℝ) < 24)).mp h
  by_cases hv : 0 ≤ v
  · exact (positive v hv).trans (by linarith [Real.exp_pos (-v)])
  · have h := positive (-v) (by linarith)
    rw [show (-v) ^ 4 = v ^ 4 by ring] at h
    exact h.trans (by linarith [Real.exp_pos v])

theorem finiteMean_boundedDifferences_fourthMoment {Label : Type*} [Fintype Label] [Nonempty Label]
    (m : ℕ) (hm : 0 < m) (f : (Fin m → Label) → ℝ) (hf : CoordinateOscillation f) :
    finiteMean (fun x => (f x - finiteMean f) ^ 4) ≤ 48 * Real.exp (1 / 2) * (m : ℝ) ^ 2 := by
  let q := (1 : ℝ) / Real.sqrt (m : ℝ)
  let y (x : Fin m → Label) := f x - finiteMean f
  have hmR : (0 : ℝ) < m := by exact_mod_cast hm
  have hroot : (Real.sqrt (m : ℝ)) ^ 2 = (m : ℝ) := Real.sq_sqrt hmR.le
  have hq2 : (m : ℝ) * q ^ 2 = 1 := by
    simp only [q, div_pow, one_pow, hroot, mul_one_div, div_self hmR.ne']
  have hq4 : q ^ 4 * (m : ℝ) ^ 2 = 1 := by
    calc
      _ = ((m : ℝ) * q ^ 2) ^ 2 := by ring
      _ = 1 := by rw [hq2, one_pow]
  have hplus : finiteMean (fun x => Real.exp (q * y x)) ≤ Real.exp (1 / 2) := by
    simpa only [y, hq2] using finiteMean_boundedDifferences_mgf m f hf q
  have hminus : finiteMean (fun x => Real.exp (-(q * y x))) ≤ Real.exp (1 / 2) := by
    simpa only [y, neg_mul, neg_sq, hq2] using finiteMean_boundedDifferences_mgf m f hf (-q)
  have hpoint := finiteMean_mono (fun x : Fin m → Label => fourth_power_le_exp_pair (q * y x))
  simp only [mul_pow, finiteMean_const_mul, finiteMean_add] at hpoint
  have hs : q ^ 4 * finiteMean (fun x => y x ^ 4) ≤ 48 * Real.exp (1 / 2) := by
    linarith
  change finiteMean (fun x => y x ^ 4) ≤ _
  calc
    _ = (q ^ 4 * finiteMean (fun x => y x ^ 4)) * (m : ℝ) ^ 2 := by
      calc
        _ = finiteMean (fun x => y x ^ 4) * (q ^ 4 * (m : ℝ) ^ 2) := by rw [hq4, mul_one]
        _ = _ := by ring
    _ ≤ _ := mul_le_mul_of_nonneg_right hs (sq_nonneg _)

theorem restrictedOddCount_fourthMoment {Label : Type*} [Fintype Label] [DecidableEq Label]
    [Nonempty Label] (m : ℕ) (hm : 0 < m) (targets : Finset Label) :
    finiteMean (fun x : Fin m → Label =>
      ((restrictedOddCount targets x : ℝ) -
        finiteMean (fun draws : Fin m → Label => (restrictedOddCount targets draws : ℝ))) ^ 4) ≤
      48 * Real.exp (1 / 2) * (m : ℝ) ^ 2 :=
  finiteMean_boundedDifferences_fourthMoment m hm _ (restrictedOddCount_bounded_difference targets)

end TwoColorNullity.Occupancy
