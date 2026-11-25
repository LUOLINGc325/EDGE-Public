import NullValidity
import RandomizedMerging

/-!
# Separation for every positive parameter and arbitrary initial allocations

Manuscript Theorem 2.1, non-domination part. An arbitrary probability seed
chooses the order, both stakes, and a nonnegative initial allocation whose
mean is at most one. The proof derives the separator from these actual
payoffs. It includes all positive parameters, and does not assume a
three-point inequality about the comparator.
-/

open MeasureTheory

namespace IndependentMerging

theorem ordered_strategy_general_bound (reverse : Bool) (a : ℝ) (b : ℝ → ℝ)
    {t : ℝ} (ht : 1 ≤ t) (ha : 0 ≤ a) (hbt : b t ≤ 1) (hb1 : 0 ≤ b 1) :
    orderedStrategy reverse a b t t + t * (t - 1) * orderedStrategy reverse a b 0 1 +
      t * (t - 1) * orderedStrategy reverse a b 1 0 ≤ t * (2 * t - 1) := by
  have hfac : 0 ≤ 1 + a * (t - 1) :=
    add_nonneg (by norm_num) (mul_nonneg ha (sub_nonneg.mpr ht))
  have hdiag : (1 + a * (t - 1)) * (1 + b t * (t - 1)) ≤
      (1 + a * (t - 1)) * t := by
    apply mul_le_mul_of_nonneg_left _ hfac
    calc
      _ ≤ 1 + 1 * (t - 1) := add_le_add_left
        (mul_le_mul_of_nonneg_right hbt (sub_nonneg.mpr ht)) _
      _ = t := by ring
  have hlast : 0 ≤ t * (t - 1) * b 1 :=
    mul_nonneg (mul_nonneg (by linarith) (sub_nonneg.mpr ht)) hb1
  have hcalc : (1 + a * (t - 1)) * (1 + b t * (t - 1)) +
      t * (t - 1) * (1 - a) + t * (t - 1) * (1 - b 1) ≤ t * (2 * t - 1) := by
    calc
      _ ≤ (1 + a * (t - 1)) * t +
          t * (t - 1) * (1 - a) + t * (t - 1) * (1 - b 1) :=
        add_le_add_right (add_le_add_right hdiag _) _
      _ = t * (2 * t - 1) - t * (t - 1) * b 1 := by ring
      _ ≤ _ := sub_le_self _ hlast
  cases reverse <;> simp only [orderedStrategy, Bool.false_eq_true, ↓reduceIte]
  · convert hcalc using 1; ring
  · convert hcalc using 1; ring

theorem ordered_strategy_box_bound (reverse : Bool) (a : ℝ) (b : ℝ → ℝ)
    {t x y : ℝ} (ht : 1 ≤ t) (ha : 0 ≤ a ∧ a ≤ 1)
    (hbx : 0 ≤ b x ∧ b x ≤ 1) (hby : 0 ≤ b y ∧ b y ≤ 1)
    (hx : 0 ≤ x ∧ x ≤ t) (hy : 0 ≤ y ∧ y ≤ t) :
    0 ≤ orderedStrategy reverse a b x y ∧ orderedStrategy reverse a b x y ≤ t * t := by
  have factor {u s : ℝ} (hu : 0 ≤ u ∧ u ≤ 1) (hs : 0 ≤ s ∧ s ≤ t) :
      0 ≤ 1 + u * (s - 1) ∧ 1 + u * (s - 1) ≤ t := by
    constructor
    · have h := add_nonneg (sub_nonneg.mpr hu.2) (mul_nonneg hu.1 hs.1)
      convert h using 1; ring
    · calc
        _ ≤ 1 + u * (t - 1) := add_le_add_left
          (mul_le_mul_of_nonneg_left (sub_le_sub_right hs.2 1) hu.1) _
        _ ≤ 1 + 1 * (t - 1) := add_le_add_left
          (mul_le_mul_of_nonneg_right hu.2 (sub_nonneg.mpr ht)) _
        _ = t := by ring
  have product {u v : ℝ} (hu : 0 ≤ u ∧ u ≤ t) (hv : 0 ≤ v ∧ v ≤ t) :
      0 ≤ u * v ∧ u * v ≤ t * t :=
    ⟨mul_nonneg hu.1 hv.1, mul_le_mul hu.2 hv.2 hv.1 (by linarith)⟩
  cases reverse with
  | false => exact product (factor ha hx) (factor hbx hy)
  | true => exact product (factor ha hy) (factor hby hx)

variable {Ω : Type*} [MeasurableSpace Ω]

noncomputable def allocatedPayoff (μ : Measure Ω) (capital : Ω → ℝ)
    (reverse : Ω → Bool) (a : Ω → ℝ) (b : Ω → ℝ → ℝ) (x y : ℝ) : ℝ :=
  ∫ ω, capital ω * orderedStrategy (reverse ω) (a ω) (b ω) x y ∂μ

theorem allocated_strategy_integrable (μ : Measure Ω)
    (capital : Ω → ℝ) (reverse : Ω → Bool) (a : Ω → ℝ) (b : Ω → ℝ → ℝ)
    {t x y : ℝ} (ht : 1 ≤ t) (hc : Integrable capital μ)
    (hc0 : ∀ᵐ ω ∂μ, 0 ≤ capital ω)
    (ha : ∀ᵐ ω ∂μ, 0 ≤ a ω ∧ a ω ≤ 1)
    (hbx : ∀ᵐ ω ∂μ, 0 ≤ b ω x ∧ b ω x ≤ 1)
    (hby : ∀ᵐ ω ∂μ, 0 ≤ b ω y ∧ b ω y ≤ 1)
    (hs : AEStronglyMeasurable (fun ω => orderedStrategy (reverse ω) (a ω) (b ω) x y) μ)
    (hx : 0 ≤ x ∧ x ≤ t) (hy : 0 ≤ y ∧ y ≤ t) :
    Integrable (fun ω => capital ω * orderedStrategy (reverse ω) (a ω) (b ω) x y) μ := by
  apply (hc.const_mul (t * t)).mono' (hc.aestronglyMeasurable.mul hs)
  filter_upwards [hc0, ha, hbx, hby] with ω hcω haω hbxω hbyω
  obtain ⟨h0, htop⟩ := ordered_strategy_box_bound (reverse ω) (a ω) (b ω)
    ht haω hbxω hbyω hx hy
  change ‖capital ω * orderedStrategy (reverse ω) (a ω) (b ω) x y‖ ≤ t * t * capital ω
  rw [Real.norm_eq_abs, abs_of_nonneg (mul_nonneg hcω h0)]
  simpa only [mul_comm] using mul_le_mul_of_nonneg_left htop hcω

/-- The three-point bound scales with the actual mean initial capital. -/
theorem allocated_three_point_bound (μ : Measure Ω) [IsProbabilityMeasure μ]
    (capital : Ω → ℝ) (reverse : Ω → Bool) (a : Ω → ℝ) (b : Ω → ℝ → ℝ)
    {t : ℝ} (ht : 1 ≤ t) (hc : Integrable capital μ)
    (hc0 : ∀ᵐ ω ∂μ, 0 ≤ capital ω)
    (ha : ∀ᵐ ω ∂μ, 0 ≤ a ω ∧ a ω ≤ 1)
    (hb : ∀ z : ℝ, ∀ᵐ ω ∂μ, 0 ≤ b ω z ∧ b ω z ≤ 1)
    (hs : ∀ x y : ℝ, AEStronglyMeasurable
      (fun ω => orderedStrategy (reverse ω) (a ω) (b ω) x y) μ) :
    allocatedPayoff μ capital reverse a b t t +
      t * (t - 1) * allocatedPayoff μ capital reverse a b 0 1 +
      t * (t - 1) * allocatedPayoff μ capital reverse a b 1 0 ≤
        t * (2 * t - 1) * (∫ ω, capital ω ∂μ) := by
  have ht0 : 0 ≤ t := by linarith
  have hi (x y : ℝ) (hx : 0 ≤ x ∧ x ≤ t) (hy : 0 ≤ y ∧ y ≤ t) :=
    allocated_strategy_integrable μ capital reverse a b ht hc hc0 ha (hb x) (hb y)
      (hs x y) hx hy
  have htt := hi t t ⟨ht0, le_rfl⟩ ⟨ht0, le_rfl⟩
  have h01 := hi 0 1 ⟨le_rfl, ht0⟩ ⟨by norm_num, ht⟩
  have h10 := hi 1 0 ⟨by norm_num, ht⟩ ⟨le_rfl, ht0⟩
  have hpoint : ∀ᵐ ω ∂μ,
      capital ω * orderedStrategy (reverse ω) (a ω) (b ω) t t +
      t * (t - 1) * (capital ω * orderedStrategy (reverse ω) (a ω) (b ω) 0 1) +
      t * (t - 1) * (capital ω * orderedStrategy (reverse ω) (a ω) (b ω) 1 0) ≤
      t * (2 * t - 1) * capital ω := by
    filter_upwards [hc0, ha, hb t, hb 1] with ω hcω haω hbtω hb1ω
    have h := mul_le_mul_of_nonneg_left
      (ordered_strategy_general_bound (reverse ω) (a ω) (b ω) ht haω.1 hbtω.2 hb1ω.1) hcω
    convert h using 1 <;> ring
  have h := integral_mono_ae ((htt.add (h01.const_mul (t * (t - 1)))).add
    (h10.const_mul (t * (t - 1)))) (hc.const_mul (t * (2 * t - 1))) hpoint
  rw [integral_add' (htt.add (h01.const_mul (t * (t - 1)))) (h10.const_mul (t * (t - 1))),
    integral_add' htt (h01.const_mul (t * (t - 1))), integral_const_mul, integral_const_mul,
    integral_const_mul] at h
  exact h

theorem mergerLambda_general_witness {lam t : ℝ} (ht : 1 ≤ t) :
    mergerLambda lam t t + t * (t - 1) * mergerLambda lam 0 1 +
      t * (t - 1) * mergerLambda lam 1 0 - t * (2 * t - 1) =
        (t - 1) * (lam * (t - 1) - 1) := by
  simp only [mergerLambda_eq_convex, merger_high_high ht ht,
    merger_low_low (by norm_num : (0 : ℝ) ≤ 1) (le_refl (1 : ℝ)),
    merger_low_low (le_refl (1 : ℝ)) (by norm_num : (0 : ℝ) ≤ 1)]
  ring

/-- No mean-at-most-one randomized initial allocation can dominate any
positive-parameter merger on the nonnegative quadrant. -/
theorem all_parameters_no_domination (μ : Measure Ω) [IsProbabilityMeasure μ]
    (capital : Ω → ℝ) (reverse : Ω → Bool) (a : Ω → ℝ) (b : Ω → ℝ → ℝ)
    {lam : ℝ} (hlam : 0 < lam) (hc : Integrable capital μ)
    (hc0 : ∀ᵐ ω ∂μ, 0 ≤ capital ω) (hc1 : (∫ ω, capital ω ∂μ) ≤ 1)
    (ha : ∀ᵐ ω ∂μ, 0 ≤ a ω ∧ a ω ≤ 1)
    (hb : ∀ z : ℝ, ∀ᵐ ω ∂μ, 0 ≤ b ω z ∧ b ω z ≤ 1)
    (hs : ∀ x y : ℝ, AEStronglyMeasurable
      (fun ω => orderedStrategy (reverse ω) (a ω) (b ω) x y) μ) :
    ¬ (∀ x y : ℝ, 0 ≤ x → 0 ≤ y →
      mergerLambda lam x y ≤ allocatedPayoff μ capital reverse a b x y) := by
  intro hdom
  let t : ℝ := 2 + 1 / lam
  have ht : 1 < t := by
    have hi : 0 < 1 / lam := one_div_pos.mpr hlam
    dsimp [t]
    linarith
  have hlt : 1 < lam * (t - 1) := by
    dsimp [t]
    have hmul : lam * (1 / lam) = 1 := by field_simp [ne_of_gt hlam]
    nlinarith
  have hbound := allocated_three_point_bound μ capital reverse a b ht.le hc hc0 ha hb hs
  have hc' : t * (2 * t - 1) * (∫ ω, capital ω ∂μ) ≤ t * (2 * t - 1) := by
    have h := mul_le_mul_of_nonneg_left hc1
      (mul_nonneg (by linarith : 0 ≤ t) (by linarith : 0 ≤ 2 * t - 1))
    simpa using h
  have hweight : 0 ≤ t * (t - 1) := mul_nonneg (by linarith) (by linarith)
  have hdiag := hdom t t (by linarith) (by linarith)
  have h01 := mul_le_mul_of_nonneg_left (hdom 0 1 (by norm_num) (by norm_num)) hweight
  have h10 := mul_le_mul_of_nonneg_left (hdom 1 0 (by norm_num) (by norm_num)) hweight
  have hgap := mergerLambda_general_witness (lam := lam) ht.le
  have hpos := mul_pos (sub_pos.mpr ht) (sub_pos.mpr hlt)
  linarith

end IndependentMerging

#print axioms IndependentMerging.allocated_three_point_bound
#print axioms IndependentMerging.all_parameters_no_domination
