import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum

namespace SharpConditionalRanksUnderTiltsResearchProof2

theorem fraction_max_at_endpoint (a b c d l x h : ℝ) (hlx : l≤x) (hxh : x≤h) (hl : 0<c*l+d) (hh : 0<c*h+d) : (a*x+b)/(c*x+d) ≤ max ((a*l+b)/(c*l+d)) ((a*h+b)/(c*h+d)) := by
  have hdx : 0 < c*x+d := by
    rcases le_or_gt 0 c with hc | hc
    · linarith only [hl, mul_le_mul_of_nonneg_left hlx hc]
    · linarith only [hh, mul_le_mul_of_nonpos_left hxh hc.le]
  rcases le_or_gt 0 (a*d-b*c) with hs | hs
  · apply le_trans _ (le_max_right _ _)
    apply (div_le_div_iff₀ hdx hh).mpr
    have hprod := mul_nonneg hs (sub_nonneg.mpr hxh)
    nlinarith only [hprod]
  · apply le_trans _ (le_max_left _ _)
    apply (div_le_div_iff₀ hdx hl).mpr
    have hprod := mul_nonneg (neg_nonneg.mpr hs.le) (sub_nonneg.mpr hlx)
    nlinarith only [hprod]

end SharpConditionalRanksUnderTiltsResearchProof2
