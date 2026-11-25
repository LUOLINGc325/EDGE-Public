import SaddleRates
import Mathlib.Topology.Order.IntermediateValue

/-! The inverse Rényi root and its interior tangent parameter. -/

open scoped BigOperators
open Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem cumulant_lower_from_atom (p q : FiniteMass κ) (s : ℝ) {i : κ} (hi : 0 < p i) :
    Real.log (p i) + s * logLikelihood p q i ≤ logCumulant p q s := by
  have h : p i * Real.exp (s * logLikelihood p q i) ≤ tiltNormalizer p q s := by
    unfold tiltNormalizer FiniteMass.expect
    exact Finset.single_le_sum (f := fun y : κ => p y * Real.exp (s * logLikelihood p q y))
      (fun y _ => mul_nonneg (p.weight_nonneg y) (Real.exp_nonneg _))
      (Finset.mem_univ i)
  have hLog := Real.log_le_log (mul_pos hi (Real.exp_pos _)) h
  rwa [Real.log_mul hi.ne' (Real.exp_pos _).ne', Real.log_exp] at hLog

noncomputable def inverseOrderObjective (p q : FiniteMass κ) (r b : ℝ) : ℝ :=
  logCumulant p q (-b) - r * b

noncomputable def inverseOrderSlope (p q : FiniteMass κ) (r b : ℝ) : ℝ :=
  -tiltedMean p q (-b) - r

theorem inverse_order_derivative (p q : FiniteMass κ) (r b : ℝ) :
    HasDerivAt (inverseOrderObjective p q r) (inverseOrderSlope p q r b) b := by
  have h := (hasDerivAt_log_cumulant p q (-b)).comp b (hasDerivAt_id b).neg
  simpa only [inverseOrderObjective, inverseOrderSlope, Function.comp_apply, id_eq,
    mul_neg, mul_one, one_mul] using h.sub ((hasDerivAt_id b).const_mul r)

theorem inverse_order_slope_continuous (p q : FiniteMass κ) (r : ℝ) :
    Continuous (inverseOrderSlope p q r) := by
  have h : Continuous (tiltedMean p q) :=
    continuous_iff_continuousAt.2 (fun b => (hasDerivAt_tilted_mean p q b).continuousAt)
  exact (h.comp continuous_neg).neg.sub continuous_const

theorem inverse_order_slope_strict_mono (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) (r : ℝ) :
    StrictMono (inverseOrderSlope p q r) := by
  intro u v huv
  exact sub_lt_sub_right (neg_lt_neg (tilted_mean_strict_mono p q hp hq hne (neg_lt_neg huv))) r

theorem inverse_order_root_and_tangent (p q : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (hne : p ≠ q) {r M : ℝ}
    (hD : -tiltedMean p q 0 < r) (hM : r < M)
    (hAtom : ∃ i, logLikelihood p q i = -M) :
    ∃ b > 0, renyiDivergence b p q = r ∧ 0 < inverseOrderSlope p q r b ∧
      ∀ b' > 0, renyiDivergence b' p q = r → b' = b := by
  let F := inverseOrderObjective p q r
  let H := inverseOrderSlope p q r
  have hF (t : ℝ) : HasDerivAt F (H t) t := inverse_order_derivative p q r t
  have hFC : Continuous F := continuous_iff_continuousAt.2 (fun t => (hF t).continuousAt)
  have hH : StrictMono H := inverse_order_slope_strict_mono p q hp hq hne r
  have hF₀ : F 0 = 0 := by simp [F, inverseOrderObjective, log_cumulant_zero]
  have hH₀ : H 0 < 0 := by
    unfold H inverseOrderSlope
    rw [neg_zero]
    exact sub_neg.mpr hD
  have hO : IsOpen {t : ℝ | H t < 0} :=
    isOpen_Iio.preimage (inverse_order_slope_continuous p q r)
  obtain ⟨δ, hδ, hSmall⟩ := Metric.isOpen_iff.mp hO 0 hH₀
  let a := δ / 2
  have ha : 0 < a := div_pos hδ (by norm_num)
  have hAnti : StrictAntiOn F (Icc 0 a) := by
    apply strictAntiOn_of_deriv_neg (convex_Icc 0 a) hFC.continuousOn
    intro t ht
    rw [interior_Icc] at ht
    rw [(hF t).deriv]
    apply hSmall
    rw [Metric.mem_ball, Real.dist_eq, sub_zero, abs_of_pos ht.1]
    exact ht.2.trans (show a < δ by unfold a; linarith)
  have hA : F a < 0 := by
    rw [← hF₀]
    exact hAnti ⟨le_rfl, ha.le⟩ ⟨ha.le, le_rfl⟩ ha
  obtain ⟨i, hi⟩ := hAtom
  let A := max a ((-Real.log (p i) + 1) / (M - r)) + 1
  have haA : a < A := (le_max_left _ _).trans_lt (lt_add_of_pos_right _ zero_lt_one)
  have hA' : 0 < F A := by
    have hh : (-Real.log (p i) + 1) / (M - r) < A :=
      (le_max_right _ _).trans_lt (lt_add_of_pos_right _ zero_lt_one)
    have hh' := (div_lt_iff₀ (sub_pos.mpr hM)).1 hh
    have h := cumulant_lower_from_atom p q (-A) (hp i)
    rw [hi] at h
    unfold F inverseOrderObjective
    nlinarith only [hh', h]
  obtain ⟨b, hb, hRoot⟩ := intermediate_value_Icc haA.le hFC.continuousOn
    (show (0 : ℝ) ∈ Icc (F a) (F A) from ⟨hA.le, hA'.le⟩)
  have hb₀ := ha.trans_le hb.1
  have hPositive (t : ℝ) (ht : 0 < t) (hz : F t = 0) : 0 < H t := by
    apply lt_of_not_ge
    intro hn
    have hNeg : StrictAntiOn F (Icc 0 t) := by
      apply strictAntiOn_of_deriv_neg (convex_Icc 0 t) hFC.continuousOn
      intro u hu
      rw [interior_Icc] at hu
      rw [(hF u).deriv]
      exact (hH hu.2).trans_le hn
    have h := hNeg (show (0 : ℝ) ∈ Icc 0 t from ⟨le_rfl, ht.le⟩)
      ⟨ht.le, le_rfl⟩ ht
    rw [hF₀, hz] at h
    exact (lt_irrefl (0 : ℝ)) h
  have hOrder (t u : ℝ) (ht : 0 < H t) (htu : t < u) : F t < F u := by
    have hM' : StrictMonoOn F (Icc t u) := by
      apply strictMonoOn_of_deriv_pos (convex_Icc t u) hFC.continuousOn
      intro x hx
      rw [interior_Icc] at hx
      rw [(hF x).deriv]
      exact ht.trans (hH hx.1)
    exact hM' ⟨le_rfl, htu.le⟩ ⟨htu.le, le_rfl⟩ htu
  have hRoot' : logCumulant p q (-b) = r * b := sub_eq_zero.mp hRoot
  refine ⟨b, hb₀, (inverse_renyi_cumulant_iff p q hp hq hb₀.ne' r).1 hRoot',
    hPositive b hb₀ hRoot, ?_⟩
  intro b' hb' hR
  have hRoot'' : F b' = 0 :=
    sub_eq_zero.mpr ((inverse_renyi_cumulant_iff p q hp hq hb'.ne' r).2 hR)
  rcases lt_trichotomy b' b with h | h | h
  · have he := hOrder b' b (hPositive b' hb' hRoot'') h
    rw [hRoot, hRoot''] at he
    exact ((lt_irrefl (0 : ℝ)) he).elim
  · exact h
  · have he := hOrder b b' (hPositive b hb₀ hRoot) h
    rw [hRoot, hRoot''] at he
    exact ((lt_irrefl (0 : ℝ)) he).elim

end RenyiProductOrderPhase
