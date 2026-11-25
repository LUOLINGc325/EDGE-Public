import EndpointAtomicSandwich
import PriorAttainment

/-! Infinite-order Rényi divergence and its unrestricted finite-channel upper bound. -/

open scoped BigOperators
open Set

namespace RenyiProductOrderPhase

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

noncomputable def infiniteRenyiRatio (p q : FiniteMass ι) : ℝ :=
  sSup (range (fun i => p i / q i))

noncomputable def infiniteRenyiDivergence (p q : FiniteMass ι) : ℝ :=
  Real.log (infiniteRenyiRatio p q)

def InfiniteRenyiAdmissible (p q : FiniteMass ι) : Prop :=
  p.AbsolutelyContinuous q ∧ 0 < infiniteRenyiDivergence p q

def infiniteRenyiRatios (w : ι → FiniteMass κ) : Set ℝ :=
  {r : ℝ | ∃ p q : FiniteMass ι, InfiniteRenyiAdmissible p q ∧
    r = infiniteRenyiDivergence (p.push w) (q.push w) / infiniteRenyiDivergence p q}

noncomputable def infiniteRenyiContractionCoefficient (w : ι → FiniteMass κ) : ℝ :=
  sSup (infiniteRenyiRatios w)

theorem infinite_renyi_ratio_is_greatest (p q : FiniteMass ι) :
    IsGreatest (range (fun i => p i / q i)) (infiniteRenyiRatio p q) := by
  classical
  obtain ⟨i, _⟩ := p.exists_weight_pos
  obtain ⟨j, _, hj⟩ := Finset.exists_max_image Finset.univ (fun i => p i / q i)
    ⟨i, Finset.mem_univ i⟩
  have h : IsGreatest (range (fun i => p i / q i)) (p j / q j) := by
    refine ⟨⟨j, rfl⟩, ?_⟩
    rintro z ⟨i, rfl⟩
    exact hj i (Finset.mem_univ i)
  unfold infiniteRenyiRatio
  rw [h.csSup_eq]
  exact h

theorem infinite_renyi_ratio_pos (p q : FiniteMass ι) (h : p.AbsolutelyContinuous q) :
    0 < infiniteRenyiRatio p q := by
  obtain ⟨i, hi⟩ := p.exists_weight_pos
  exact (div_pos hi (h.reference_pos hi)).trans_le ((infinite_renyi_ratio_is_greatest p q).2 ⟨i, rfl⟩)

theorem infinite_renyi_ratio_domination (p q : FiniteMass ι) (h : p.AbsolutelyContinuous q) (i : ι) :
    p i ≤ infiniteRenyiRatio p q * q i := by
  by_cases hi : q i = 0
  · rw [hi, h i hi, mul_zero]
  · exact (div_le_iff₀ (lt_of_le_of_ne (q.weight_nonneg i) (Ne.symm hi))).1
      ((infinite_renyi_ratio_is_greatest p q).2 ⟨i, rfl⟩)

theorem infinite_renyi_channel_ratio_upper (w : ι → FiniteMass κ)
    (hW : ∀ i y, 0 < w i y) {ε : ℝ} (hε : 0 ≤ ε) (hε₁ : ε ≤ 1)
    (hRows : ∀ i j y, ε * w j y ≤ w i y)
    (p q : FiniteMass ι) (hA : InfiniteRenyiAdmissible p q) :
    infiniteRenyiDivergence (p.push w) (q.push w) / infiniteRenyiDivergence p q ≤ 1 - ε := by
  let T := infiniteRenyiRatio p q
  have hT : 0 < T := infinite_renyi_ratio_pos p q hA.1
  have hL : 0 < Real.log T := hA.2
  have hT₁ : 1 < T := (Real.log_pos_iff hT.le).1 hL
  let f (i : ι) := q i - p i / T
  have hf (i : ι) : 0 ≤ f i := by
    unfold f
    apply sub_nonneg.mpr
    apply (div_le_iff₀ hT).2
    simpa only [mul_comm] using infinite_renyi_ratio_domination p q hA.1 i
  have hF : (∑ i, f i) = 1 - 1 / T := by
    unfold f
    rw [Finset.sum_sub_distrib, ← Finset.sum_div, p.total, q.total]
  have hRow' (i : ι) (y : κ) : ε * p.push w y ≤ w i y := by
    change ε * p.expect (fun j => w j y) ≤ w i y
    rw [← FiniteMass.expect_scale_function, ← p.expect_const (w i y)]
    exact p.expect_mono (fun j => hRows i j y)
  have hTail (y : κ) : (1 - 1 / T) * (ε * p.push w y) ≤
      q.push w y - p.push w y / T := by
    calc
      _ = ∑ i, f i * (ε * p.push w y) := by rw [← Finset.sum_mul, hF]
      _ ≤ ∑ i, f i * w i y :=
        Finset.sum_le_sum (fun i _ => mul_le_mul_of_nonneg_left (hRow' i y) (hf i))
      _ = _ := by
        unfold f
        simp only [FiniteMass.push_apply, sub_mul, Finset.sum_sub_distrib]
        rw [Finset.sum_div]
        congr 1
        exact Finset.sum_congr rfl (fun i _ => by ring)
  let C := 1 + ε * (T - 1)
  have hC : 0 < C := add_pos_of_pos_of_nonneg zero_lt_one (mul_nonneg hε (sub_nonneg.mpr hT₁.le))
  have hPoint (y : κ) : p.push w y / q.push w y ≤ T / C := by
    have hQ : 0 < q.push w y := q.push_pos w hW y
    have h := (le_sub_iff_add_le.mp (hTail y))
    have hEq : (1 - 1 / T) * (ε * p.push w y) + p.push w y / T =
        p.push w y * (C / T) := by
      unfold C
      field_simp [hT.ne']
      ring
    rw [hEq] at h
    apply (div_le_div_iff₀ hQ hC).2
    have h' := mul_le_mul_of_nonneg_right h hT.le
    rw [mul_assoc, div_mul_cancel₀ _ hT.ne'] at h'
    simpa only [mul_comm T] using h'
  have hOut : infiniteRenyiRatio (p.push w) (q.push w) ≤ T / C := by
    have h := (infinite_renyi_ratio_is_greatest (p.push w) (q.push w)).1
    obtain ⟨y, hy⟩ := h
    rw [← hy]
    exact hPoint y
  have hOutPos := infinite_renyi_ratio_pos (p.push w) (q.push w)
    (FiniteMass.absolutelyContinuous_of_pos _ _ (q.push_pos w hW))
  have hLog := Real.log_le_log hOutPos hOut
  rw [Real.log_div hT.ne' hC.ne'] at hLog
  have hConc := log_prior_concavity_lower hε hε₁ (sub_pos.mpr hT₁)
  rw [show 1 + (T - 1) = T by ring, mul_comm (T - 1) ε] at hConc
  change ε * Real.log T ≤ Real.log C at hConc
  change Real.log (infiniteRenyiRatio (p.push w) (q.push w)) / Real.log T ≤ 1 - ε
  exact (div_le_iff₀ hL).2 (by nlinarith only [hLog, hConc])

end RenyiProductOrderPhase
