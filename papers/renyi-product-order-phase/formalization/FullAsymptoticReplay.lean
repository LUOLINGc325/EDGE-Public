import PublicTheoremInterfaces
import InteriorMovingScale

/-! Specializations of the public coefficient theorems in a separate importing module. -/

open Filter Set
open scoped Topology

namespace RenyiProductOrderPhase.FullAsymptoticReplay

private noncomputable def bscRow (x : Bool) : FiniteMass Bool where
  weight y := if y = x then 3 / 4 else 1 / 4
  weight_nonneg y := by split <;> norm_num
  total := by cases x <;> norm_num [Fintype.sum_bool]

private noncomputable def bitFlip : Bool ≃ Bool where
  toFun := Bool.not
  invFun := Bool.not
  left_inv x := by cases x <;> rfl
  right_inv x := by cases x <;> rfl

noncomputable def quarterNoiseChannel : BinarySymmetricChannel Bool where
  channel := bscRow
  positive x y := by change 0 < (if y = x then (3 / 4 : ℝ) else 1 / 4); split <;> norm_num
  flip := bitFlip
  involutive y := by cases y <;> rfl
  swaps y := by cases y <;> rfl
  informative := by
    intro he
    have h := congrArg (fun p : FiniteMass Bool => p false) he
    norm_num [bscRow] at h

theorem quarter_noise_channel_is_arithmetic :
    ArithmeticSupport (logLikelihood (quarterNoiseChannel.channel false) (quarterNoiseChannel.channel true)) := by
  have h : 0 < Real.log 3 := Real.log_pos (by norm_num)
  refine ⟨-Real.log 3, 2 * Real.log 3, mul_pos (by norm_num) h, ?_⟩
  intro x
  cases x
  · refine ⟨0, ?_⟩
    have hL : logLikelihood (quarterNoiseChannel.channel false) (quarterNoiseChannel.channel true) false =
        Real.log ((1 : ℝ) / 3) := by unfold logLikelihood; norm_num [quarterNoiseChannel, bscRow]
    rw [hL, Real.log_div (by norm_num) (by norm_num), Real.log_one]
    norm_num
  · refine ⟨1, ?_⟩
    have hL : logLikelihood (quarterNoiseChannel.channel false) (quarterNoiseChannel.channel true) true =
        Real.log (3 : ℝ) := by unfold logLikelihood; norm_num [quarterNoiseChannel, bscRow]
    rw [hL]
    norm_num
    ring

theorem quarter_noise_exact_attainment (n : ℕ) (hn : 0 < n) (b : ℝ) (hb : 1 ≤ b) :
    ∃ a > 0, channelProductDeficit quarterNoiseChannel n b =
      productScalarDeficit (quarterNoiseChannel.channel false) (quarterNoiseChannel.channel true) n b a := by
  obtain ⟨a, ha, hEq, _⟩ := product_contraction_attained quarterNoiseChannel hn b hb
  exact ⟨a, ha, hEq⟩

theorem quarter_noise_critical_limit (ζ : ℝ) :
    ∃ t > 0, Tendsto (fun n : ℕ =>
      criticalOrder (quarterNoiseChannel.channel false) (quarterNoiseChannel.channel true) ζ (n + 1) *
      criticalScale (quarterNoiseChannel.channel false) (quarterNoiseChannel.channel true) (n + 1) *
      channelProductDeficit quarterNoiseChannel (n + 1)
        (criticalOrder (quarterNoiseChannel.channel false) (quarterNoiseChannel.channel true) ζ (n + 1)))
      atTop (𝓝 (criticalGaussianCost ζ t)) := by
  obtain ⟨t, ht, _, h, _⟩ := biso_critical_window_limit quarterNoiseChannel ζ
  exact ⟨t, ht, h⟩

end RenyiProductOrderPhase.FullAsymptoticReplay
