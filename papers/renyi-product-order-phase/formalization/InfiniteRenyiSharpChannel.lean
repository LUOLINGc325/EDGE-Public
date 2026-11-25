import InfiniteRenyi

/-! A sharp infinite-order coefficient from a minimum row ratio. -/

open Set

namespace RenyiProductOrderPhase

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

theorem infinite_renyi_dirac_mix (i j : ι) (hij : i ≠ j)
    {t : ℝ} (ht : t ∈ Icc (0 : ℝ) 1) (ht₀ : 0 < t) :
    infiniteRenyiDivergence (FiniteMass.dirac i)
      (FiniteMass.mix (FiniteMass.dirac i) (FiniteMass.dirac j) t ht) = -Real.log t := by
  classical
  let p := FiniteMass.dirac i
  let q := FiniteMass.mix p (FiniteMass.dirac j) t ht
  have hi : p i / q i = 1 / t := by simp [p, q, hij]
  have hM : IsGreatest (range (fun k => p k / q k)) (1 / t) := by
    refine ⟨⟨i, hi⟩, ?_⟩
    rintro y ⟨k, rfl⟩
    change p k / q k ≤ 1 / t
    by_cases hk : k = i
    · rw [hk, hi]
    · have hP : p k = 0 := by simp [p, hk]
      rw [hP, zero_div]
      exact (div_pos zero_lt_one ht₀).le
  change Real.log (sSup (range (fun k => p k / q k))) = _
  rw [hM.csSup_eq, Real.log_div one_ne_zero ht₀.ne', Real.log_one, zero_sub]

theorem infinite_renyi_sharp_channel (w : ι → FiniteMass κ)
    (hW : ∀ i y, 0 < w i y) {ε : ℝ} (hε : 0 < ε) (hε₁ : ε ≤ 1)
    (hRows : ∀ i j y, ε * w j y ≤ w i y)
    (i j : ι) (hij : i ≠ j) (z : κ) (hZ : w j z = ε * w i z) :
    infiniteRenyiContractionCoefficient w = 1 - ε := by
  let A := infiniteRenyiRatios w
  have hAll : ∀ r ∈ A, r ≤ 1 - ε := by
    rintro r ⟨p, q, hpq, rfl⟩
    exact infinite_renyi_channel_ratio_upper w hW hε.le hε₁ hRows p q hpq
  have hAbove : BddAbove A := ⟨1 - ε, hAll⟩
  have hNear (a : ℝ) (ha : 0 < a) :
      ∃ r ∈ A, 1 - ε * (1 + a) ≤ r := by
    let p := FiniteMass.dirac i
    let t := priorWeight a
    have ht := prior_weight_mem ha
    have ht₀ : 0 < t := (prior_weight_bounds ha).1
    let q := FiniteMass.mix p (FiniteMass.dirac j) t ht
    have hL : 0 < Real.log (1 + a) := Real.log_pos (lt_add_of_pos_right _ ha)
    have hInput : infiniteRenyiDivergence p q = Real.log (1 + a) := by
      rw [infinite_renyi_dirac_mix i j hij ht ht₀]
      unfold priorWeight
      rw [Real.log_inv, neg_neg]
    have hAdm : InfiniteRenyiAdmissible p q := by
      refine ⟨FiniteMass.absolutelyContinuous_dirac_mix i j ht ht₀, ?_⟩
      rwa [hInput]
    let r := infiniteRenyiDivergence (p.push w) (q.push w) / infiniteRenyiDivergence p q
    have hRatio : p.push w z / q.push w z = (1 + a) / (1 + ε * a) := by
      unfold q p
      rw [FiniteMass.push_mix, FiniteMass.push_dirac, FiniteMass.push_dirac,
        FiniteMass.mix_apply, hZ]
      have hW₀ := (hW i z).ne'
      have hD₀ : 0 < 1 + a := by linarith
      have hCa : 0 < 1 + ε * a := by positivity
      have hEq : t * w i z + (1 - t) * (ε * w i z) =
          w i z * (1 + ε * a) / (1 + a) := by
        unfold t priorWeight
        field_simp [hD₀.ne']
        ring
      rw [hEq, div_div_eq_mul_div]
      field_simp [hW₀, hD₀.ne', hCa.ne']
      ring
    have hOut : (1 + a) / (1 + ε * a) ≤ infiniteRenyiRatio (p.push w) (q.push w) := by
      rw [← hRatio]
      exact (infinite_renyi_ratio_is_greatest (p.push w) (q.push w)).2 ⟨z, rfl⟩
    have hLog := Real.log_le_log (div_pos (by positivity : 0 < 1 + a) (by positivity : 0 < 1 + ε * a)) hOut
    rw [Real.log_div (by positivity : 0 < 1 + a).ne' (by positivity : 0 < 1 + ε * a).ne'] at hLog
    have hTop := (log_one_add_bounds (mul_nonneg hε.le ha.le)).2
    have hBot := (log_one_add_bounds ha.le).1
    have hProd := mul_le_mul_of_nonneg_left hBot (by positivity : 0 ≤ ε * (1 + a))
    have hClean : ε * (1 + a) * (a / (1 + a)) = ε * a := by
      field_simp [(by positivity : 0 < 1 + a).ne']
      ring
    rw [hClean] at hProd
    refine ⟨r, ⟨p, q, hAdm, rfl⟩, ?_⟩
    unfold r
    rw [hInput]
    apply (le_div_iff₀ hL).2
    unfold infiniteRenyiDivergence
    nlinarith only [hLog, hTop, hProd]
  have hA : A.Nonempty := by
    obtain ⟨a, ha, _⟩ := hNear 1 zero_lt_one
    exact ⟨a, ha⟩
  change sSup A = 1 - ε
  refine le_antisymm (csSup_le hA hAll) ?_
  apply le_of_not_gt
  intro h
  let a := (1 - ε - sSup A) / (2 * ε)
  have ha : 0 < a := div_pos (sub_pos.mpr h) (mul_pos (by norm_num) hε)
  obtain ⟨r, hr, hR⟩ := hNear a ha
  have hLe := le_csSup hAbove hr
  have hEq : 2 * ε * a = 1 - ε - sSup A := by
    unfold a
    rw [mul_div_cancel₀ _ (mul_pos (by norm_num) hε).ne']
  nlinarith only [h, hLe, hR, hEq]

end RenyiProductOrderPhase
