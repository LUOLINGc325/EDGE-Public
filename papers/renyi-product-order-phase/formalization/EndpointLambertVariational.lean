import PriorVariational

/-! The real nonnegative Lambert branch and the exact endpoint prior surrogate. -/

open Set

namespace RenyiProductOrderPhase

theorem exists_nonnegative_lambert_root (x : ℝ) (hx : 0 ≤ x) :
    ∃ w ≥ 0, w * Real.exp w = x := by
  let f (w : ℝ) := w * Real.exp w
  have hf : Continuous f := continuous_id.mul Real.continuous_exp
  have hOne : 1 ≤ Real.exp x := by simpa only [Real.exp_zero] using Real.exp_le_exp.mpr hx
  have hX : x ≤ f x := le_mul_of_one_le_right hx hOne
  have hz : f 0 = 0 := by simp [f]
  have hRange : x ∈ Icc (f 0) (f x) := ⟨by rwa [hz], hX⟩
  obtain ⟨w, hw, hfw⟩ := intermediate_value_Icc hx hf.continuousOn hRange
  exact ⟨w, hw.1, hfw⟩

noncomputable def lambertWNonnegative (x : ℝ) : ℝ :=
  if hx : 0 ≤ x then Classical.choose (exists_nonnegative_lambert_root x hx) else 0

theorem lambert_w_nonnegative_spec {x : ℝ} (hx : 0 ≤ x) :
    0 ≤ lambertWNonnegative x ∧ lambertWNonnegative x * Real.exp (lambertWNonnegative x) = x := by
  unfold lambertWNonnegative
  rw [dif_pos hx]
  exact Classical.choose_spec (exists_nonnegative_lambert_root x hx)

theorem lambert_w_nonnegative_unique {x w : ℝ} (hx : 0 ≤ x) (hw : 0 ≤ w)
    (hEq : w * Real.exp w = x) : w = lambertWNonnegative x := by
  let W := lambertWNonnegative x
  have hW : 0 ≤ W := (lambert_w_nonnegative_spec hx).1
  have hW' : W * Real.exp W = x := (lambert_w_nonnegative_spec hx).2
  have hM : StrictMonoOn (fun t : ℝ => t * Real.exp t) (Ici 0) := by
    intro u hu v hv huv
    exact (mul_lt_mul_of_pos_right huv (Real.exp_pos _)).trans_le
      (mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr huv.le) (mem_Ici.mp hv))
  exact hM.injOn (mem_Ici.mpr hw) (mem_Ici.mpr hW) (hEq.trans hW'.symm)

theorem lambert_neg_interval_strict_mono :
    StrictMonoOn (fun w : ℝ => w * Real.exp w) (Icc (-1) 0) := by
  apply strictMonoOn_of_deriv_pos (convex_Icc (-1) 0)
  · exact (continuous_id.mul Real.continuous_exp).continuousOn
  · intro w hw
    rw [interior_Icc] at hw
    have h := ((hasDerivAt_id w).mul (Real.hasDerivAt_exp w)).deriv
    simp only [id_eq] at h
    rw [h]
    change 0 < 1 * Real.exp w + w * Real.exp w
    rw [← add_mul]
    exact mul_pos (by linarith only [hw.1]) (Real.exp_pos _)

theorem lambert_negative_exists {x : ℝ} (hx : -(1 / Real.exp 1) ≤ x) (hx₀ : x ≤ 0) :
    ∃ w ∈ Icc (-1 : ℝ) 0, w * Real.exp w = x := by
  let f (w : ℝ) := w * Real.exp w
  have hf : Continuous f := continuous_id.mul Real.continuous_exp
  have h₁ : f (-1) = -(1 / Real.exp 1) := by
    unfold f
    rw [Real.exp_neg, neg_one_mul, one_div]
  have h₀ : f 0 = 0 := zero_mul _
  apply intermediate_value_Icc (by norm_num : (-1 : ℝ) ≤ 0) hf.continuousOn
  exact ⟨h₁.symm ▸ hx, h₀.symm ▸ hx₀⟩

noncomputable def lambertWPrincipal (x : ℝ) : ℝ :=
  if h : 0 ≤ x then lambertWNonnegative x
  else if hDom : -(1 / Real.exp 1) ≤ x then
    Classical.choose (lambert_negative_exists hDom (le_of_not_ge h))
  else -1

theorem lambert_w_principal_nonnegative_arg {x : ℝ} (hx : 0 ≤ x) :
    lambertWPrincipal x = lambertWNonnegative x := by
  unfold lambertWPrincipal
  rw [dif_pos hx]

theorem lambert_w_principal_spec {x : ℝ} (hx : -(1 / Real.exp 1) ≤ x) :
    -1 ≤ lambertWPrincipal x ∧ lambertWPrincipal x * Real.exp (lambertWPrincipal x) = x := by
  by_cases h : 0 ≤ x
  · rw [lambert_w_principal_nonnegative_arg h]
    exact ⟨(by norm_num : (-1 : ℝ) ≤ 0).trans (lambert_w_nonnegative_spec h).1,
      (lambert_w_nonnegative_spec h).2⟩
  · unfold lambertWPrincipal
    rw [dif_neg h, dif_pos hx]
    have he := Classical.choose_spec (lambert_negative_exists hx (le_of_not_ge h))
    exact ⟨he.1.1, he.2⟩

theorem lambert_w_principal_unique {x w : ℝ} (hx : -(1 / Real.exp 1) ≤ x) (hw : -1 ≤ w)
    (hEq : w * Real.exp w = x) :
    w = lambertWPrincipal x := by
  by_cases h : 0 ≤ x
  · rw [lambert_w_principal_nonnegative_arg h]
    have hW : 0 ≤ w := by
      apply le_of_not_gt
      intro hn
      have hNeg := mul_neg_of_neg_of_pos hn (Real.exp_pos w)
      rw [hEq] at hNeg
      exact (not_lt_of_ge h) hNeg
    exact lambert_w_nonnegative_unique h hW hEq
  · have hx' : x < 0 := lt_of_not_ge h
    have hW : w ≤ 0 := by
      apply le_of_not_gt
      intro hn
      have hpos : 0 < x := hEq ▸ mul_pos hn (Real.exp_pos _)
      exact h (hpos.le)
    have hP : lambertWPrincipal x ∈ Icc (-1 : ℝ) 0 := by
      unfold lambertWPrincipal
      rw [dif_neg h, dif_pos hx]
      exact (Classical.choose_spec (lambert_negative_exists hx hx'.le)).1
    exact lambert_neg_interval_strict_mono.injOn ⟨hw, hW⟩ hP
      (hEq.trans (lambert_w_principal_spec hx).2.symm)

noncomputable def lambertEndpointTime (level : ℝ) : ℝ :=
  1 + lambertWPrincipal ((level - 1) / Real.exp 1)

theorem lambert_endpoint_time_principal_spec {level : ℝ} (hlevel : 0 < level) :
    0 < lambertEndpointTime level ∧
      Real.exp (lambertEndpointTime level) * (lambertEndpointTime level - 1) = level - 1 := by
  let x := (level - 1) / Real.exp 1
  let w := lambertWPrincipal x
  have hE : 0 < Real.exp 1 := Real.exp_pos _
  have hx : -(1 / Real.exp 1) < x := by
    unfold x
    rw [← neg_div]
    exact div_lt_div_of_pos_right (by linarith only [hlevel]) hE
  have h := lambert_w_principal_spec hx.le
  have hW : -1 < w := by
    apply lt_of_le_of_ne h.1
    intro he
    have he' : w = -1 := he.symm
    have hEq : w * Real.exp w = x := h.2
    rw [he', Real.exp_neg, neg_one_mul, ← one_div] at hEq
    exact (not_lt_of_ge hEq.ge) hx
  change 0 < 1 + w ∧ Real.exp (1 + w) * (1 + w - 1) = level - 1
  refine ⟨by linarith only [hW], ?_⟩
  rw [Real.exp_add, add_sub_cancel_left]
  calc
    _ = Real.exp 1 * (w * Real.exp w) := by ring
    _ = _ := by rw [show w * Real.exp w = x from h.2]; unfold x; exact mul_div_cancel₀ _ hE.ne'

theorem lambert_endpoint_time_below_one {level : ℝ} (h₀ : 0 < level) (h₁ : level < 1) :
    lambertEndpointTime level < 1 := by
  have hEq := (lambert_endpoint_time_principal_spec h₀).2
  apply lt_of_not_ge
  intro h
  have hp := mul_nonneg (Real.exp_nonneg (lambertEndpointTime level)) (sub_nonneg.mpr h)
  rw [hEq] at hp
  exact (not_lt_of_ge hp) (sub_neg.mpr h₁)

noncomputable def endpointSurrogate (level U : ℝ) : ℝ := (level + Real.exp U - 1) / U

theorem lambert_endpoint_time_spec {level : ℝ} (hlevel : 1 ≤ level) :
    0 < lambertEndpointTime level ∧
      Real.exp (lambertEndpointTime level) * (lambertEndpointTime level - 1) = level - 1 :=
  lambert_endpoint_time_principal_spec (zero_lt_one.trans_le hlevel)

theorem endpoint_surrogate_derivative (level : ℝ) {U : ℝ} (hU : 0 < U) :
    HasDerivAt (endpointSurrogate level)
      ((Real.exp U * (U - 1) - (level - 1)) / U ^ 2) U := by
  have hF : HasDerivAt (fun t : ℝ => level + Real.exp t - 1) (Real.exp U) U := by
    simpa only [zero_add, sub_zero] using
      (((hasDerivAt_const U level).add (Real.hasDerivAt_exp U)).sub_const 1)
  unfold endpointSurrogate
  convert hF.div (hasDerivAt_id U) hU.ne' using 1
  simp only [id_eq, mul_one]
  ring

theorem endpoint_surrogate_exact_minimum {level : ℝ} (hlevel : 1 ≤ level) :
    endpointSurrogate level (lambertEndpointTime level) = Real.exp (lambertEndpointTime level) ∧
    ∀ U, 0 < U → U ≠ lambertEndpointTime level →
      endpointSurrogate level (lambertEndpointTime level) < endpointSurrogate level U := by
  let T := lambertEndpointTime level
  have hT : 0 < T := (lambert_endpoint_time_spec hlevel).1
  have hEq : Real.exp T * (T - 1) = level - 1 := (lambert_endpoint_time_spec hlevel).2
  constructor
  · change endpointSurrogate level T = _
    unfold endpointSurrogate
    apply (div_eq_iff hT.ne').2
    nlinarith only [hEq]
  · let f (t : ℝ) := Real.exp t * (t - 1)
    have hd (t : ℝ) : HasDerivAt f (t * Real.exp t) t := by
      have h := (Real.hasDerivAt_exp t).mul ((hasDerivAt_id t).sub_const 1)
      unfold f
      convert h using 1
      simp only [id_eq, mul_one, sub_zero]
      ring
    have hf : StrictMonoOn f (Ioi 0) := by
      apply strictMonoOn_of_deriv_pos (convex_Ioi 0)
      · exact (continuous_iff_continuousAt.2 (fun t => (hd t).continuousAt)).continuousOn
      · intro t ht
        rw [interior_Ioi] at ht
        rw [(hd t).deriv]
        exact mul_pos (mem_Ioi.mp ht) (Real.exp_pos _)
    have hCont : ContinuousOn (endpointSurrogate level) (Ioi 0) :=
      fun t ht => (endpoint_surrogate_derivative _ (mem_Ioi.mp ht)).continuousAt.continuousWithinAt
    have hAnti : StrictAntiOn (endpointSurrogate level) (Ioc 0 T) := by
      apply strictAntiOn_of_deriv_neg (convex_Ioc 0 T) (hCont.mono (fun _ ht => ht.1))
      intro t ht
      have hS : Ioc (0 : ℝ) T ⊆ Icc 0 T := fun _ h => ⟨h.1.le, h.2⟩
      have ht' : t ∈ interior (Icc (0 : ℝ) T) := interior_mono hS ht
      rw [interior_Icc] at ht'
      rw [(endpoint_surrogate_derivative _ ht'.1).deriv]
      apply div_neg_of_neg_of_pos _ (pow_pos ht'.1 2)
      rw [← hEq]
      exact sub_neg.mpr (hf ht'.1 hT ht'.2)
    have hMono : StrictMonoOn (endpointSurrogate level) (Ici T) := by
      apply strictMonoOn_of_deriv_pos (convex_Ici T) (hCont.mono (fun _ ht => hT.trans_le ht))
      intro t ht
      rw [interior_Ici] at ht
      have ht' : 0 < t := hT.trans ht
      rw [(endpoint_surrogate_derivative _ ht').deriv]
      apply div_pos _ (by positivity)
      rw [← hEq]
      exact sub_pos.mpr (hf hT ht' ht)
    intro U hU hne
    rcases lt_or_gt_of_ne hne with h | h
    · exact hAnti ⟨hU, h.le⟩ ⟨hT, le_rfl⟩ h
    · exact hMono (mem_Ici.mpr (le_refl T)) (mem_Ici.mpr h.le) h

theorem endpoint_surrogate_separation {level : ℝ} (hlevel : 1 ≤ level) (d : ℝ)
    (hd : 0 < lambertEndpointTime level + d) :
    endpointSurrogate level (lambertEndpointTime level + d) -
      endpointSurrogate level (lambertEndpointTime level) =
    Real.exp (lambertEndpointTime level) * (Real.exp d - 1 - d) / (lambertEndpointTime level + d) := by
  let T := lambertEndpointTime level
  have hEq : Real.exp T * (T - 1) = level - 1 := (lambert_endpoint_time_spec hlevel).2
  have hM : endpointSurrogate level T = Real.exp T := (endpoint_surrogate_exact_minimum hlevel).1
  change endpointSurrogate level (T + d) - endpointSurrogate level T = _
  rw [hM]
  unfold endpointSurrogate
  rw [Real.exp_add]
  have hRewrite : level + Real.exp T * Real.exp d - 1 =
      Real.exp T * (T - 1) + Real.exp T * Real.exp d := by linarith only [hEq]
  rw [hRewrite]
  field_simp [hd.ne']
  ring

end RenyiProductOrderPhase
