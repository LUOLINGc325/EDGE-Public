import FiniteJensen

/-! Finite posterior probabilities and the data-processing inequality. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

namespace FiniteMass

theorem expect_rpow_le (p : FiniteMass ι) {f : ι → ℝ} (hf : ∀ i, 0 ≤ f i)
    {a : ℝ} (ha : 1 ≤ a) :
    (p.expect f) ^ a ≤ p.expect (fun i => f i ^ a) :=
  (convexOn_rpow ha).map_sum_le (t := Finset.univ) (w := fun i => p i) (p := f)
    (fun i _ => p.weight_nonneg i) p.total (fun i _ => hf i)

noncomputable def posterior (q : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (y : κ) : FiniteMass ι where
  weight i := q i * w i y / (q.push w y)
  weight_nonneg i := div_nonneg (mul_nonneg (q.weight_nonneg i) (hw i y).le)
    (q.push_pos w hw y).le
  total := by
    rw [← Finset.sum_div]
    exact div_self (q.push_pos w hw y).ne'

@[simp] theorem posterior_apply (q : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (y : κ) (i : ι) :
    q.posterior w hw y i = q i * w i y / (q.push w y) := rfl

noncomputable def conditionalMean (q : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (f : ι → ℝ) (y : κ) : ℝ :=
  (q.posterior w hw y).expect f

theorem expect_conditional_mean (q : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (f : ι → ℝ) :
    (q.push w).expect (q.conditionalMean w hw f) = q.expect f := by
  unfold conditionalMean expect
  simp only [posterior_apply, Finset.mul_sum]
  calc
    _ = ∑ y, ∑ i, q i * w i y * f i := by
      refine Finset.sum_congr rfl fun y _ => Finset.sum_congr rfl fun i _ => ?_
      rw [← mul_assoc, mul_div_cancel₀ _ (q.push_pos w hw y).ne']
    _ = ∑ i, q i * f i := by
      rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun i _ => ?_
      calc
        _ = ∑ y, (q i * f i) * w i y := by
          refine Finset.sum_congr rfl fun y _ => ?_
          ring
        _ = _ := by rw [← Finset.mul_sum, (w i).total, mul_one]

theorem conditional_mean_shared_density (p q : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (f : ι → ℝ) (h : ∀ i, p i = q i * f i)
    (y : κ) : q.conditionalMean w hw f y = p.push w y / q.push w y := by
  unfold conditionalMean expect
  rw [push_apply, Finset.sum_div]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [posterior_apply, h i]
  ring

theorem conditional_mean_rpow (q : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (f : ι → ℝ) (hf : ∀ i, 0 ≤ f i)
    {a : ℝ} (ha : 1 ≤ a) :
    (q.push w).expect (fun y => (q.conditionalMean w hw f y) ^ a) ≤
      q.expect (fun i => f i ^ a) := by
  rw [← expect_conditional_mean q w hw (fun i => f i ^ a)]
  apply expect_mono
  intro y
  exact (q.posterior w hw y).expect_rpow_le hf ha

end FiniteMass

theorem renyi_moment_data_processing (p q : FiniteMass ι) (h : p.AbsolutelyContinuous q)
    (w : ι → FiniteMass κ) (hw : ∀ i y, 0 < w i y) (b : ℝ) (hb : 0 < b) :
    renyiMoment b (p.push w) (q.push w) ≤ renyiMoment b p q := by
  rw [renyi_moment_reference b hb p q h,
    renyi_moment_reference b hb _ _
      (FiniteMass.absolutelyContinuous_of_pos _ _ (q.push_pos w hw))]
  let f (i : ι) := p i / q i
  have hf (i : ι) : 0 ≤ f i := div_nonneg (p.weight_nonneg i) (q.weight_nonneg i)
  have hpost (y : κ) :
      q.conditionalMean w hw f y = p.push w y / q.push w y :=
    FiniteMass.conditional_mean_shared_density p q w hw f (density_ratio_eq p q h) y
  simpa only [hpost] using q.conditional_mean_rpow w hw f hf
    (show 1 ≤ b + 1 by linarith)

theorem divergence_ratio_le_iff_moment (p q : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (b : ℝ) (hb : 0 < b) (h : RenyiAdmissible b p q) (r : ℝ) :
    renyiDivergence b (p.push w) (q.push w) / renyiDivergence b p q ≤ r ↔
      renyiMoment b (p.push w) (q.push w) ≤ renyiMoment b p q ^ r := by
  have hi := renyi_moment_pos p q b h.1
  have ho := renyi_moment_pos (p.push w) (q.push w) b
    (FiniteMass.absolutelyContinuous_of_pos _ _ (q.push_pos w hw))
  rw [div_le_iff₀ h.2]
  unfold renyiDivergence
  rw [← mul_div_assoc, div_le_div_iff_of_pos_right hb, ← Real.log_rpow hi r]
  exact Real.log_le_log_iff ho (Real.rpow_pos_of_pos hi r)

theorem divergence_ratio_mem_unit (p q : FiniteMass ι) (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (b : ℝ) (hb : 0 < b) (h : RenyiAdmissible b p q) :
    renyiDivergence b (p.push w) (q.push w) / renyiDivergence b p q ∈ Set.Icc (0 : ℝ) 1 := by
  constructor
  · exact div_nonneg (renyi_divergence_nonneg b hb _ _
      (FiniteMass.absolutelyContinuous_of_pos _ _ (q.push_pos w hw))) h.2.le
  · rw [divergence_ratio_le_iff_moment p q w hw b hb h 1, Real.rpow_one]
    exact renyi_moment_data_processing p q h.1 w hw b hb

end RenyiProductOrderPhase
