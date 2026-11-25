import FiniteRenyi
import Mathlib.Topology.Algebra.Order.Field

/-! The large-prior scalar limit from positive finite likelihood-ratio bounds. -/

open scoped BigOperators Topology
open Set Filter

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem positive_ratio_bounds (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y) :
    ∃ l u : ℝ, 0 < l ∧ 0 < u ∧ ∀ y, l ≤ q y / p y ∧ q y / p y ≤ u := by
  classical
  let F (y : κ) := q y / p y
  let S := Finset.univ.image F
  obtain ⟨y, _⟩ := p.exists_weight_pos
  have hS : S.Nonempty := ⟨F y, Finset.mem_image.mpr ⟨y, Finset.mem_univ y, rfl⟩⟩
  let l := S.min' hS
  let u := S.max' hS
  have hpos (z : ℝ) (hz : z ∈ S) : 0 < z := by
    obtain ⟨i, _, rfl⟩ := Finset.mem_image.mp hz
    exact div_pos (hq i) (hp i)
  refine ⟨l, u, hpos l (Finset.min'_mem _ _), hpos u (Finset.max'_mem _ _), ?_⟩
  intro z
  have hz : F z ∈ S := Finset.mem_image.mpr ⟨z, Finset.mem_univ z, rfl⟩
  exact ⟨Finset.min'_le _ _ hz, Finset.le_max' _ _ hz⟩

theorem log_scale_ratio_tendsto {r : ℝ} (hr : 0 < r) :
    Tendsto (fun a : ℝ => Real.log (1 + a * r) / Real.log (1 + a)) atTop (𝓝 1) := by
  have hinf : Tendsto (fun a : ℝ => 1 + a) atTop atTop := tendsto_atTop.2 fun b =>
    (eventually_ge_atTop (b - 1)).mono (fun a ha => by linarith only [ha])
  have hInv : Tendsto (fun a : ℝ => a⁻¹) atTop (𝓝 0) :=
    tendsto_inv_atTop_nhdsGT_zero.mono_right nhdsWithin_le_nhds
  have hinv := hInv.comp hinf
  have hconst : Tendsto (fun _ : ℝ => r) atTop (𝓝 r) := tendsto_const_nhds
  have hconst' : Tendsto (fun _ : ℝ => 1 - r) atTop (𝓝 (1 - r)) := tendsto_const_nhds
  have hscale := hconst.add (hconst'.mul hinv)
  simp only [mul_zero, add_zero] at hscale
  have hratio : Tendsto (fun a : ℝ => (1 + a * r) / (1 + a)) atTop (𝓝 r) := by
    refine hscale.congr' ?_
    filter_upwards [eventually_ge_atTop (0 : ℝ)] with a ha
    have h : (1 + a) ≠ 0 := (show 0 < 1 + a by linarith only [ha]).ne'
    simp only [Function.comp_apply]
    symm
    apply (div_eq_iff h).2
    rw [add_mul, mul_assoc, inv_mul_cancel₀ h, mul_one]
    ring
  have hlogScale := (Real.continuousAt_log hr.ne').tendsto.comp hratio
  have hlogInv := hInv.comp (Real.tendsto_log_atTop.comp hinf)
  have hconst1 : Tendsto (fun _ : ℝ => (1 : ℝ)) atTop (𝓝 1) := tendsto_const_nhds
  have ht := hconst1.add (hlogScale.mul hlogInv)
  simp only [mul_zero, add_zero] at ht
  refine ht.congr' ?_
  filter_upwards [eventually_gt_atTop (0 : ℝ)] with a ha
  have hx : 0 < 1 + a * r := by linarith only [mul_pos ha hr]
  have hy : 1 < 1 + a := by linarith only [ha]
  have hlog := (Real.log_pos hy).ne'
  change 1 + Real.log ((1 + a * r) / (1 + a)) * (Real.log (1 + a))⁻¹ =
    Real.log (1 + a * r) / Real.log (1 + a)
  rw [Real.log_div hx.ne' (zero_lt_one.trans hy).ne']
  apply (eq_div_iff hlog).2
  rw [add_mul, one_mul, mul_assoc, inv_mul_cancel₀ hlog, mul_one]
  ring

theorem scalar_deficit_between_log_scales (p q : FiniteMass κ)
    {l u : ℝ} (hl : 0 < l) (hu : 0 < u) (hf : ∀ y, l ≤ q y / p y ∧ q y / p y ≤ u)
    {b a : ℝ} (hb : 0 < b) (ha : 0 < a) :
    Real.log (1 + a * l) / Real.log (1 + a) ≤ scalarDeficit p q b a ∧
      scalarDeficit p q b a ≤ Real.log (1 + a * u) / Real.log (1 + a) := by
  have hL : 0 < 1 + a * l := by linarith only [mul_pos ha hl]
  have hU : 0 < 1 + a * u := by linarith only [mul_pos ha hu]
  have hmid (y : κ) : 0 < 1 + a * (q y / p y) :=
    hL.trans_le (add_le_add_left (mul_le_mul_of_nonneg_left (hf y).1 ha.le) 1)
  have hside₁ : (1 + a * u) ^ (-b) ≤ scalarMoment p q b a := by
    have h := p.expect_mono (f := fun _ => (1 + a * u) ^ (-b))
      (g := fun y => (1 + a * (q y / p y)) ^ (-b)) (fun y =>
        Real.rpow_le_rpow_of_nonpos (hmid y)
          (add_le_add_left (mul_le_mul_of_nonneg_left (hf y).2 ha.le) 1)
            (neg_nonpos.mpr hb.le))
    simpa only [FiniteMass.expect_const, scalarMoment] using h
  have hside₂ : scalarMoment p q b a ≤ (1 + a * l) ^ (-b) := by
    have h := p.expect_mono (f := fun y => (1 + a * (q y / p y)) ^ (-b))
      (g := fun _ => (1 + a * l) ^ (-b)) (fun y =>
        Real.rpow_le_rpow_of_nonpos hL
          (add_le_add_left (mul_le_mul_of_nonneg_left (hf y).1 ha.le) 1)
            (neg_nonpos.mpr hb.le))
    simpa only [FiniteMass.expect_const, scalarMoment] using h
  have hLog₁ := Real.log_le_log (Real.rpow_pos_of_pos hU (-b)) hside₁
  have hLog₂ := Real.log_le_log (scalar_moment_pos p q b ha) hside₂
  rw [Real.log_rpow hL] at hLog₂
  rw [Real.log_rpow hU] at hLog₁
  have hden : 0 < b * Real.log (1 + a) :=
    mul_pos hb (Real.log_pos (by linarith only [ha]))
  unfold scalarDeficit
  constructor
  · calc
      _ = (b * Real.log (1 + a * l)) / (b * Real.log (1 + a)) :=
        (mul_div_mul_left _ _ hb.ne').symm
      _ ≤ _ := div_le_div_of_nonneg_right (by linarith only [hLog₂]) hden.le
  · calc
      _ ≤ (b * Real.log (1 + a * u)) / (b * Real.log (1 + a)) :=
        div_le_div_of_nonneg_right (by linarith only [hLog₁]) hden.le
      _ = _ := mul_div_mul_left _ _ hb.ne'

theorem scalar_deficit_tendsto_infinity (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y) (b : ℝ) (hb : 0 < b) :
    Tendsto (scalarDeficit p q b) atTop (𝓝 1) := by
  obtain ⟨l, u, hl, hu, h⟩ := positive_ratio_bounds p q hp hq
  exact tendsto_of_tendsto_of_tendsto_of_le_of_le'
    (log_scale_ratio_tendsto hl) (log_scale_ratio_tendsto hu)
    ((eventually_gt_atTop (0 : ℝ)).mono (fun a ha =>
      (scalar_deficit_between_log_scales p q hl hu h hb ha).1))
    ((eventually_gt_atTop (0 : ℝ)).mono (fun a ha =>
      (scalar_deficit_between_log_scales p q hl hu h hb ha).2))

end RenyiProductOrderPhase
