import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum

namespace SharpConditionalRanksUnderTiltsResearchProof1

theorem tilt_moment_repair (μ a q ε Γ e : ℝ) (ha : a<μ) (hq : 0<q) (hε : 0≤ε) (hΓ : 1≤Γ) (hsmall : ε<q*(μ-a)) (herr : |e|≤ε*(Γ-1)/2) : let t := (1+Γ)/2 - e/(q*(a-μ)); 1≤t ∧ t≤Γ ∧ e+q*(a-μ)*(t-(1+Γ)/2)=0 := by
  dsimp only
  have hpos : 0 < q * (μ - a) := mul_pos hq (sub_pos.mpr ha)
  have hneg : q * (a - μ) < 0 := mul_neg_of_pos_of_neg hq (sub_neg.mpr ha)
  have hg : 0 ≤ (Γ - 1) / 2 := by linarith
  have hden : |q * (a - μ)| = q * (μ - a) := by rw [abs_of_neg hneg]; ring
  have hb : |e / (q * (a - μ))| ≤ (Γ - 1) / 2 := by
    rw [abs_div, hden, div_le_iff₀ hpos]
    calc
      |e| ≤ ε*(Γ-1)/2 := herr
      _ = |ε| * ((Γ-1)/2) := by rw [abs_of_nonneg hε]; ring
      _ ≤ ((Γ-1)/2) * (q * (μ-a)) := by
        rw [abs_of_nonneg hε, mul_comm ((Γ-1)/2)]
        exact mul_le_mul_of_nonneg_right hsmall.le hg
  obtain ⟨hlo, hhi⟩ := abs_le.mp hb
  refine ⟨by linarith, by linarith, ?_⟩
  field_simp [hneg.ne]
  ring

end SharpConditionalRanksUnderTiltsResearchProof1
