import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

namespace AnnealedFrequencyReduction

theorem slow_crossing_log_orientation (P : ℝ → ℝ) (z K : ℝ) (hz : P z=K) (h1 : P 0=1) (hK : 0<K) (hmono : StrictMonoOn P (Set.Icc (min z 0) (max z 0))) : (0<z ↔ 0<Real.log K) ∧ (z<0 ↔ Real.log K<0) := by
  have hmem0 : 0 ∈ Set.Icc (min z 0) (max z 0) := ⟨min_le_right _ _,le_max_right _ _⟩
  have hmemz : z ∈ Set.Icc (min z 0) (max z 0) := ⟨min_le_left _ _,le_max_left _ _⟩
  have hp := hmono.lt_iff_lt hmem0 hmemz
  have hn := hmono.lt_iff_lt hmemz hmem0
  rw [hz,h1] at hp hn
  exact ⟨hp.symm.trans (Real.log_pos_iff hK.le).symm, hn.symm.trans (Real.log_neg_iff hK).symm⟩

end AnnealedFrequencyReduction
