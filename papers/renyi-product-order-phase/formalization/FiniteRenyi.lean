import FiniteDistributions
import Mathlib.Analysis.Convex.Jensen
import Mathlib.Analysis.Convex.SpecificFunctions.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

/-! Rényi divergence for a finite alphabet and the exact two-row scalar formula. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- The Hellinger moment at order b + 1, with b strictly positive in the
divergence applications below. This convention gives zero at p i = 0. -/
noncomputable def renyiMoment (b : ℝ) (p q : FiniteMass ι) : ℝ :=
  p.expect (fun i => (p i / q i) ^ b)

theorem density_ratio_eq (p q : FiniteMass ι) (h : p.AbsolutelyContinuous q) (i : ι) :
    p i = q i * (p i / q i) := by
  by_cases hq : q i = 0
  · rw [h i hq, hq, zero_mul]
  · rw [mul_div_cancel₀ _ hq]

theorem renyi_moment_reference (b : ℝ) (hb : 0 < b) (p q : FiniteMass ι)
    (hac : p.AbsolutelyContinuous q) :
    renyiMoment b p q = q.expect (fun i => (p i / q i) ^ (b + 1)) := by
  unfold renyiMoment FiniteMass.expect
  refine Finset.sum_congr rfl fun i _ => ?_
  change p i * (p i / q i) ^ b = q i * (p i / q i) ^ (b + 1)
  rw [Real.rpow_add_of_nonneg (div_nonneg (p.weight_nonneg i) (q.weight_nonneg i))
    hb.le zero_le_one, Real.rpow_one]
  have h : q i * (p i / q i) = p i := (density_ratio_eq p q hac i).symm
  calc
    p i * (p i / q i) ^ b = (q i * (p i / q i)) * (p i / q i) ^ b := by rw [h]
    _ = q i * ((p i / q i) ^ b * (p i / q i)) := by ring

theorem renyi_moment_self (b : ℝ) (p : FiniteMass ι) : renyiMoment b p p = 1 := by
  unfold renyiMoment FiniteMass.expect
  calc
    (∑ i, p i * (p i / p i) ^ b) = ∑ i, p i := by
      refine Finset.sum_congr rfl fun i _ => ?_
      by_cases h : p i = 0
      · simp [h]
      · simp [div_self h]
    _ = 1 := p.total

theorem renyi_moment_pos (p q : FiniteMass ι) (b : ℝ)
    (h : p.AbsolutelyContinuous q) : 0 < renyiMoment b p q := by
  obtain ⟨i, hi⟩ := p.exists_weight_pos
  exact p.expect_pos (fun j => Real.rpow_nonneg
    (div_nonneg (p.weight_nonneg j) (q.weight_nonneg j)) b) hi
    (Real.rpow_pos_of_pos (div_pos hi (h.reference_pos hi)) b)

theorem reference_expected_ratio (p q : FiniteMass ι) (h : p.AbsolutelyContinuous q) :
    q.expect (fun i => p i / q i) = 1 := by
  unfold FiniteMass.expect
  calc
    (∑ i, q i * (p i / q i)) = ∑ i, p i := by
      exact Finset.sum_congr rfl (fun i _ => (density_ratio_eq p q h i).symm)
    _ = 1 := p.total

theorem renyi_moment_ge_one (b : ℝ) (hb : 0 < b) (p q : FiniteMass ι)
    (h : p.AbsolutelyContinuous q) : 1 ≤ renyiMoment b p q := by
  classical
  rw [renyi_moment_reference b hb p q h]
  have hj := (convexOn_rpow (show 1 ≤ b + 1 by linarith)).map_sum_le
    (t := Finset.univ) (w := fun i => q i) (p := fun i => p i / q i)
    (fun i _ => q.weight_nonneg i) q.total
    (fun i _ => div_nonneg (p.weight_nonneg i) (q.weight_nonneg i))
  change (q.expect (fun i => p i / q i)) ^ (b + 1) ≤ _ at hj
  rwa [reference_expected_ratio p q h, Real.one_rpow] at hj

noncomputable def renyiDivergence (b : ℝ) (p q : FiniteMass ι) : ℝ :=
  Real.log (renyiMoment b p q) / b

theorem renyi_divergence_nonneg (b : ℝ) (hb : 0 < b) (p q : FiniteMass ι)
    (h : p.AbsolutelyContinuous q) : 0 ≤ renyiDivergence b p q :=
  div_nonneg (Real.log_nonneg (renyi_moment_ge_one b hb p q h)) hb.le

def RenyiAdmissible (b : ℝ) (p q : FiniteMass ι) : Prop :=
  p.AbsolutelyContinuous q ∧ 0 < renyiDivergence b p q

noncomputable def contractionCoefficient (b : ℝ) (w : ι → FiniteMass κ) : ℝ :=
  sSup {r : ℝ | ∃ p q : FiniteMass ι, RenyiAdmissible b p q ∧
    r = renyiDivergence b (p.push w) (q.push w) / renyiDivergence b p q}

theorem renyi_moment_dirac_mix (b : ℝ) {i j : ι} (hij : i ≠ j)
    {t : ℝ} (ht : t ∈ Set.Icc (0 : ℝ) 1) :
    renyiMoment b (FiniteMass.dirac i) (FiniteMass.mix (FiniteMass.dirac i) (FiniteMass.dirac j) t ht)
      = (1 / t) ^ b := by
  classical
  rw [renyiMoment, FiniteMass.dirac_expect]
  simp [hij]

theorem renyi_divergence_dirac_mix (b : ℝ) (hb : 0 < b) {i j : ι} (hij : i ≠ j)
    {t : ℝ} (ht : t ∈ Set.Icc (0 : ℝ) 1) (htp : 0 < t) :
    renyiDivergence b (FiniteMass.dirac i)
      (FiniteMass.mix (FiniteMass.dirac i) (FiniteMass.dirac j) t ht) = -Real.log t := by
  unfold renyiDivergence
  rw [renyi_moment_dirac_mix b hij ht, Real.log_rpow (div_pos zero_lt_one htp) b,
    Real.log_div one_ne_zero htp.ne', Real.log_one, zero_sub]
  exact (div_eq_iff hb.ne').2 (mul_comm b _)

theorem dirac_mix_admissible (b : ℝ) (hb : 0 < b) {i j : ι} (hij : i ≠ j)
    {t : ℝ} (ht : t ∈ Set.Icc (0 : ℝ) 1) (htp : 0 < t) (ht1 : t < 1) :
    RenyiAdmissible b (FiniteMass.dirac i)
      (FiniteMass.mix (FiniteMass.dirac i) (FiniteMass.dirac j) t ht) := by
  refine ⟨FiniteMass.absolutelyContinuous_dirac_mix i j ht htp, ?_⟩
  rw [renyi_divergence_dirac_mix b hb hij ht htp]
  exact neg_pos.mpr (Real.log_neg htp ht1)

noncomputable def priorWeight (a : ℝ) : ℝ := (1 + a)⁻¹

theorem prior_weight_bounds {a : ℝ} (ha : 0 < a) :
    0 < priorWeight a ∧ priorWeight a < 1 := by
  unfold priorWeight
  have h : (1 : ℝ) < 1 + a := by linarith
  exact ⟨inv_pos.mpr (zero_lt_one.trans h), inv_lt_one_of_one_lt₀ h⟩

theorem prior_weight_mem {a : ℝ} (ha : 0 < a) : priorWeight a ∈ Set.Icc (0 : ℝ) 1 :=
  ⟨(prior_weight_bounds ha).1.le, (prior_weight_bounds ha).2.le⟩

/-- The finite expectation in the scalar contraction deficit. -/
noncomputable def scalarMoment (p q : FiniteMass ι) (b a : ℝ) : ℝ :=
  p.expect (fun i => (1 + a * (q i / p i)) ^ (-b))

noncomputable def scalarDeficit (p q : FiniteMass ι) (b a : ℝ) : ℝ :=
  -Real.log (scalarMoment p q b a) / (b * Real.log (1 + a))

theorem scalar_moment_pos (p q : FiniteMass ι) (b : ℝ) {a : ℝ} (ha : 0 < a) :
    0 < scalarMoment p q b a := by
  have hbase (i : ι) : 0 < 1 + a * (q i / p i) := by
    have h := mul_nonneg ha.le (div_nonneg (q.weight_nonneg i) (p.weight_nonneg i))
    linarith
  obtain ⟨i, hp⟩ := p.exists_weight_pos
  exact p.expect_pos (fun j => (Real.rpow_pos_of_pos (hbase j) (-b)).le) hp
    (Real.rpow_pos_of_pos (hbase i) (-b))

theorem scalar_moment_lt_one (p q : FiniteMass ι) (b : ℝ) (hb : 0 < b)
    {a : ℝ} (ha : 0 < a) (hq : ∀ i, 0 < q i) : scalarMoment p q b a < 1 := by
  have hbase (j : ι) : 1 ≤ 1 + a * (q j / p j) :=
    le_add_of_nonneg_right (mul_nonneg ha.le
      (div_nonneg (q.weight_nonneg j) (p.weight_nonneg j)))
  obtain ⟨i, hp⟩ := p.exists_weight_pos
  have hstrict : 1 < 1 + a * (q i / p i) :=
    lt_add_of_pos_right _ (mul_pos ha (div_pos (hq i) hp))
  rw [← p.expect_const 1]
  exact p.expect_strict (fun j => by
    simpa only [Real.one_rpow] using
      Real.rpow_le_rpow_of_nonpos zero_lt_one (hbase j) (neg_nonpos.mpr hb.le))
    hp (Real.rpow_lt_one_of_one_lt_of_neg hstrict (neg_neg_of_pos hb))

theorem prior_mixture_ratio (p q : FiniteMass ι) {a : ℝ} (ha : 0 < a)
    (i : ι) (hp : 0 < p i) :
    p i / FiniteMass.mix p q (priorWeight a) (prior_weight_mem ha) i =
      (1 + a) / (1 + a * (q i / p i)) := by
  have hu : 0 < 1 + a := by linarith
  have hv : 0 < 1 + a * (q i / p i) := by
    have h := mul_nonneg ha.le (div_nonneg (q.weight_nonneg i) hp.le)
    linarith
  have hm : 0 < FiniteMass.mix p q (priorWeight a) (prior_weight_mem ha) i :=
    FiniteMass.mix_pos_left p q (prior_weight_mem ha) (prior_weight_bounds ha).1 hp
  apply (div_eq_div_iff hm.ne' hv.ne').2
  rw [FiniteMass.mix_apply]
  unfold priorWeight
  field_simp [hu.ne', hp.ne']

theorem renyi_moment_eq_scalar (p q : FiniteMass ι) (b : ℝ) {a : ℝ} (ha : 0 < a)
    (hp : ∀ i, 0 < p i) :
    renyiMoment b p (FiniteMass.mix p q (priorWeight a) (prior_weight_mem ha)) =
      (1 + a) ^ b * scalarMoment p q b a := by
  have hu : (0 : ℝ) < 1 + a := by linarith
  unfold renyiMoment scalarMoment FiniteMass.expect
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  have hv : 0 ≤ 1 + a * (q i / p i) := by
    have h := mul_nonneg ha.le (div_nonneg (q.weight_nonneg i) (hp i).le)
    linarith
  change p i * (p i / FiniteMass.mix p q (priorWeight a) (prior_weight_mem ha) i) ^ b =
    (1 + a) ^ b * (p i * (1 + a * (q i / p i)) ^ (-b))
  rw [prior_mixture_ratio p q ha i (hp i), Real.div_rpow hu.le hv,
    Real.rpow_neg hv, div_eq_mul_inv]
  ring

theorem renyi_output_divergence_eq_scalar (p q : FiniteMass ι) (b : ℝ) (hb : 0 < b)
    {a : ℝ} (ha : 0 < a) (hp : ∀ i, 0 < p i) :
    renyiDivergence b p (FiniteMass.mix p q (priorWeight a) (prior_weight_mem ha)) =
      Real.log (1 + a) + Real.log (scalarMoment p q b a) / b := by
  have hu : (0 : ℝ) < 1 + a := by linarith
  have hcancel (z : ℝ) : b * z / b = z := (div_eq_iff hb.ne').2 (mul_comm b z)
  rw [renyiDivergence, renyi_moment_eq_scalar p q b ha hp,
    Real.log_mul (Real.rpow_pos_of_pos hu b).ne' (scalar_moment_pos p q b ha).ne',
    Real.log_rpow hu, add_div, hcancel]

theorem dirac_channel_ratio_eq_scalar (b : ℝ) (hb : 0 < b)
    (w : ι → FiniteMass κ) {i j : ι} (hij : i ≠ j)
    (hw : ∀ y, 0 < w i y) {a : ℝ} (ha : 0 < a) :
    renyiDivergence b ((FiniteMass.dirac i).push w)
      ((FiniteMass.mix (FiniteMass.dirac i) (FiniteMass.dirac j) (priorWeight a)
        (prior_weight_mem ha)).push w) /
      renyiDivergence b (FiniteMass.dirac i)
        (FiniteMass.mix (FiniteMass.dirac i) (FiniteMass.dirac j) (priorWeight a)
          (prior_weight_mem ha)) =
      1 - scalarDeficit (w i) (w j) b a := by
  have hu : (0 : ℝ) < 1 + a := by linarith
  have hlog : 0 < Real.log (1 + a) := Real.log_pos (by linarith)
  rw [FiniteMass.push_mix, FiniteMass.push_dirac, FiniteMass.push_dirac,
    renyi_divergence_dirac_mix b hb hij _ (prior_weight_bounds ha).1,
    renyi_output_divergence_eq_scalar (w i) (w j) b hb ha hw]
  unfold priorWeight scalarDeficit
  rw [Real.log_inv, neg_neg]
  field_simp [hb.ne', hlog.ne']
  ring

end RenyiProductOrderPhase
