import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

namespace CompositeSequentialTestInductionResearchProof1

/-- A deterministic stop at time one pays the time-one score on that
branch. Continuing pays the mass of its terminal accepting leaf. -/
noncomputable def stoppedMean (gA gB massA massB acceptA acceptB : ℝ) (stopA stopB : Bool) : ℝ :=
  (if stopA then gA * massA else acceptA) + (if stopB then gB * massB else acceptB)

/-- The exact two-null, two-branch stopping model of Section 3. -/
def ValidExtension (gA gB : ℝ) : Prop :=
  0 ≤ gA ∧ gA ≤ 1 ∧ 0 ≤ gB ∧ gB ≤ 1 ∧
  ∀ a b : Bool,
    stoppedMean gA gB (1/4) (3/4) (3/16) (1/16) a b ≤ 1/4 ∧
    stoppedMean gA gB (1/2) (1/2) (1/20) (1/100) a b ≤ 1/4

theorem sharp_witness_valid : ValidExtension (5/12) (1/12) := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num, ?_⟩
  intro a b
  cases a <;> cases b <;> norm_num [stoppedMean]

theorem cap_A_attained : ValidExtension (12/25) (1/50) := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num, ?_⟩
  intro a b
  cases a <;> cases b <;> norm_num [stoppedMean]

theorem cap_B_attained : ValidExtension (1/10) (1/12) := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num, ?_⟩
  intro a b
  cases a <;> cases b <;> norm_num [stoppedMean]

theorem extension_caps {gA gB : ℝ} (h : ValidExtension gA gB) :
    gA ≤ 12/25 ∧ gB ≤ 1/12 ∧ gA + gB ≤ 1/2 := by
  have stops := h.2.2.2.2
  have first := (stops true false).2
  have second := (stops false true).1
  have both := (stops true true).2
  norm_num [stoppedMean] at first second both
  exact ⟨by linarith, by linarith, by linarith⟩

/-- Individually attained node caps cannot both be attained by a valid extension. -/
theorem no_greatest_extension :
    ¬ ∃ a b, ValidExtension a b ∧
      ∀ x y, ValidExtension x y → x ≤ a ∧ y ≤ b := by
  rintro ⟨a,b,valid,greatest⟩
  have first := (greatest _ _ cap_A_attained).1
  have second := (greatest _ _ cap_B_attained).2
  have total := (extension_caps valid).2.2
  linarith

theorem sharp_time_one_Q {gA gB : ℝ} (h : ValidExtension gA gB) :
    (5/12 : ℝ) * gA + (7/12 : ℝ) * gB ≤ 2/9 := by
  rcases extension_caps h with ⟨_, capB, total⟩
  linarith

theorem sharp_time_one_Q_attained :
    ∃ a b, ValidExtension a b ∧ (5/12 : ℝ) * a + (7/12 : ℝ) * b = 2/9 :=
  ⟨5/12, 1/12, sharp_witness_valid, by norm_num⟩

end CompositeSequentialTestInductionResearchProof1
