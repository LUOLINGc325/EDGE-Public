import HalflineDesmoothing

/-! A uniform central limit theorem for every finite centered law of positive variance. -/

open scoped Topology
open Filter Set MeasureTheory

namespace RenyiProductOrderPhase

noncomputable def gaussianCDF (v x : ℝ) : ℝ := ∫ s in Iic x, gaussianProfile v 1 s

theorem gaussian_cdf_increment {v x y : ℝ} (hv : 0 < v) (hxy : x ≤ y) :
    0 ≤ gaussianCDF v y - gaussianCDF v x ∧
      gaussianCDF v y - gaussianCDF v x ≤ gaussianHeight v * (y - x) := by
  let f := gaussianProfile v 1
  let S := Iic x
  let U := Ioc x y
  have hI : Integrable f := gaussian_unit_profile_integrable hv
  have hSet : S ∪ U = Iic y := by
    ext s
    constructor
    · rintro (hs | hs)
      · exact (mem_Iic.mp hs).trans hxy
      · exact (mem_Ioc.mp hs).2
    · intro hs
      by_cases h : s ≤ x
      · exact Or.inl h
      · exact Or.inr ⟨lt_of_not_ge h, hs⟩
  have hDisj : Disjoint S U := Set.disjoint_left.2 (fun _ hs hu =>
    (not_lt_of_ge (mem_Iic.mp hs)) (mem_Ioc.mp hu).1)
  have hEq : gaussianCDF v y - gaussianCDF v x = ∫ s in U, f s := by
    unfold gaussianCDF
    change (∫ s in Iic y, f s) - (∫ s in S, f s) = _
    rw [← hSet, setIntegral_union hDisj measurableSet_Ioc hI.integrableOn hI.integrableOn,
      add_sub_cancel_left]
  have hVol : volume U = ENNReal.ofReal (y - x) := Real.volume_Ioc
  have hConst : IntegrableOn (fun _ : ℝ => gaussianHeight v) U := by
    apply integrableOn_const.2
    right
    rw [hVol]
    exact ENNReal.ofReal_lt_top
  have hUpper : (∫ s in U, f s) ≤ ∫ _ in U, gaussianHeight v :=
    setIntegral_mono_on hI.integrableOn hConst measurableSet_Ioc
      (fun s _ => gaussian_profile_le_constant v hv 1 s)
  rw [setIntegral_const] at hUpper
  change (∫ s in U, f s) ≤ (volume U).toReal * gaussianHeight v at hUpper
  rw [hVol, ENNReal.toReal_ofReal (sub_nonneg.mpr hxy), mul_comm (y - x)] at hUpper
  rw [hEq]
  exact ⟨setIntegral_nonneg measurableSet_Ioc (fun s _ => gaussian_profile_nonneg v 1 s), hUpper⟩

theorem cdf_error_le_l1 {f g : ℝ → ℝ} (hf : Integrable f) (hg : Integrable g) (x : ℝ) :
    |(∫ y in Iic x, f y) - ∫ y in Iic x, g y| ≤ ∫ y, |f y - g y| := by
  let μ := (volume : Measure ℝ).restrict (Iic x)
  change |(∫ y, f y ∂μ) - ∫ y, g y ∂μ| ≤ _
  rw [← integral_sub (show Integrable f μ from hf.integrableOn) (show Integrable g μ from hg.integrableOn)]
  have hX := norm_integral_le_integral_norm (μ := μ) (fun y => f y - g y)
  have h := setIntegral_le_integral (hf.sub hg).abs
    (Filter.Eventually.of_forall (fun y => abs_nonneg (f y - g y))) (s := Iic x)
  have hP : |∫ y, (f y - g y) ∂μ| ≤ ∫ y, |f y - g y| ∂μ := by
    simpa only [Real.norm_eq_abs] using hX
  exact hP.trans h

variable {κ : Type*} [Fintype κ]

theorem finite_uniform_central_limit (p : FiniteMass κ) (Y : κ → ℝ)
    (hm : p.expect Y = 0) (hv : 0 < p.expect (fun i => Y i ^ 2))
    {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n : ℕ in atTop, ∀ x : ℝ,
      |finiteSumEvent p (fun i => Y i / Real.sqrt ((n + 1 : ℕ) : ℝ)) (n + 1) (Iic x) -
        gaussianCDF (p.expect (fun i => Y i ^ 2)) x| < ε := by
  let v := p.expect (fun i => Y i ^ 2)
  let G := gaussianHeight v
  have hG : 0 ≤ G := (gaussian_height_pos hv).le
  let d := ε / (4 * (G + 1))
  have hD : 0 < 4 * (G + 1) := by positivity
  have hd : 0 < d := div_pos hε hD
  have hGd : G * d < ε / 4 := by
    have h := mul_div_cancel₀ ε hD.ne'
    have hEq : 4 * (G + 1) * d = ε := h
    nlinarith only [hEq, hd]
  have hε₄ : 0 < ε / 4 := div_pos hε (by norm_num)
  obtain ⟨δ, hδ, hL1⟩ := normalized_smoothed_density_l1_limit p Y hm hv
  let T (n : ℕ) := δ * Real.sqrt ((n + 1 : ℕ) : ℝ)
  have hT (n : ℕ) : 0 < T n := mul_pos hδ (Real.sqrt_pos.2 (by exact_mod_cast Nat.succ_pos n))
  have hSucc : Tendsto (fun n : ℕ => n + 1) atTop atTop := tendsto_atTop.2 fun m =>
    (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n))
  have hTV : Tendsto T atTop atTop := (nat_sqrt_tendsto_atTop.comp hSucc).const_mul_atTop hδ
  let Q := Real.pi ^ 2 * d
  have hQ : 0 < Q := mul_pos (pow_pos Real.pi_pos _) hd
  have hEta : ∀ᶠ n in atTop, smoothingTail (T n) d < ε / 4 := by
    have hP := hTV.eventually (eventually_gt_atTop (2 / (Q * (ε / 4))))
    filter_upwards [hP] with n hn
    apply (smoothing_tail_bound (hT n) hd).2.trans_lt
    apply (div_lt_iff₀ (by positivity : 0 < Real.pi ^ 2 * T n * d)).2
    have hLU := (div_lt_iff₀ (mul_pos hQ hε₄)).1 hn
    unfold Q at hLU
    nlinarith only [hLU]
  filter_upwards [hL1.eventually (Iio_mem_nhds hε₄), hEta] with n hn hTn
  intro x
  let Y' (i : κ) := Y i / Real.sqrt ((n + 1 : ℕ) : ℝ)
  let g := normalizedSmoothedDensity p Y δ (n + 1)
  let F := finiteSumEvent p Y' (n + 1) (Iic x)
  let J (y : ℝ) := ∫ t in Iic y, g t
  let η := smoothingTail (T n) d
  have hDes : J (x - d) - η ≤ F ∧ F ≤ J (x + d) + η :=
    sum_cdf_desmoothing p Y' (n + 1) (hT n) hd x
  have hCF (y : ℝ) : |J y - gaussianCDF v y| < ε / 4 :=
    (cdf_error_le_l1 (smoothed_sum_density_integrable p Y' (n + 1) (hT n))
      (gaussian_unit_profile_integrable hv) y).trans_lt hn
  have hLeft := (abs_lt.mp (hCF (x - d))).1
  have hRight := (abs_lt.mp (hCF (x + d))).2
  have hLShift := (gaussian_cdf_increment hv (show x - d ≤ x by linarith)).2
  have hRShift := (gaussian_cdf_increment hv (show x ≤ x + d by linarith)).2
  rw [sub_sub_cancel] at hLShift
  rw [add_sub_cancel_left] at hRShift
  have hη : η < ε / 4 := hTn
  change |F - gaussianCDF v x| < ε
  rw [abs_lt]
  exact ⟨by linarith only [hDes.1, hLeft, hLShift, hGd, hη, hε],
    by linarith only [hDes.2, hRight, hRShift, hGd, hη, hε]⟩

end RenyiProductOrderPhase
