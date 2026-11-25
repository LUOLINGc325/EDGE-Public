import ProductCoefficient
import EndpointSmall
import EndpointLarge
import Mathlib.Topology.Order.Compact

/-! Finite-block attainment at an interior prior for each positive finite order. -/

open scoped BigOperators Topology
open Set Filter

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem scalar_deficit_continuous (p q : FiniteMass κ) (b : ℝ) (hb : 0 < b) :
    ContinuousOn (scalarDeficit p q b) (Ioi (0 : ℝ)) := by
  have hm : ContinuousOn (scalarMoment p q b) (Ioi (0 : ℝ)) := by
    unfold scalarMoment FiniteMass.expect
    refine continuousOn_finset_sum _ fun i _ => continuousOn_const.mul ?_
    have h : Continuous (fun a : ℝ => 1 + a * (q i / p i)) := by fun_prop
    refine h.continuousOn.rpow_const fun a ha => Or.inl ?_
    exact (add_pos_of_pos_of_nonneg zero_lt_one (mul_nonneg ha.le
      (div_nonneg (q.weight_nonneg i) (p.weight_nonneg i)))).ne'
  have hd : ContinuousOn (fun a : ℝ => b * Real.log (1 + a)) (Ioi (0 : ℝ)) := by
    refine continuousOn_const.mul ?_
    exact ((continuous_const.add continuous_id).continuousOn.log
      (fun a ha => (show 0 < 1 + a by linarith only [show 0 < a from ha]).ne'))
  exact (hm.log (fun a ha => (scalar_moment_pos p q b ha).ne')).neg.div hd
    (fun a ha => (mul_pos hb (Real.log_pos (by linarith only [show 0 < a from ha]))).ne')

theorem scalar_deficit_below_one (p q : FiniteMass κ) (hp : ∀ y, 0 < p y) (hne : p ≠ q)
    {b a : ℝ} (hb : 0 < b) (ha : 0 < a) :
    scalarDeficit p q b a < 1 := by
  have hbase : 0 < 1 + a := by linarith
  have hm : (1 + a) ^ (-b) < scalarMoment p q b a :=
    strict_ratio_power_expect p q hp hne a b ha hb
  have h := Real.log_lt_log (Real.rpow_pos_of_pos hbase (-b)) hm
  rw [Real.log_rpow hbase] at h
  unfold scalarDeficit
  apply (div_lt_iff₀ (mul_pos hb (Real.log_pos (by linarith)))).2
  linarith only [h]

theorem interior_minimum_from_limits (f : ℝ → ℝ)
    (hf : ContinuousOn f (Ioi (0 : ℝ)))
    (h₀ : Tendsto f (𝓝[>] (0 : ℝ)) (𝓝 1)) (hInfinity : Tendsto f atTop (𝓝 1))
    (h1 : f 1 < 1) : ∃ a > 0, ∀ z > 0, f a ≤ f z := by
  let c := (1 + f 1) / 2
  have hc : f 1 < c := by dsimp [c]; linarith only [h1]
  have hc' : c < 1 := by dsimp [c]; linarith only [h1]
  have hSmall : {a : ℝ | c < f a} ∈ 𝓝[>] (0 : ℝ) :=
    h₀.eventually (Ioi_mem_nhds hc')
  obtain ⟨ε, hε, hεmem⟩ := Metric.mem_nhdsWithin_iff.mp hSmall
  let δ := min 1 ε
  have hδ : 0 < δ := lt_min zero_lt_one hε
  have hδ₁ : δ ≤ 1 := min_le_left _ _
  obtain ⟨M, hM⟩ := eventually_atTop.1 (hInfinity.eventually (Ioi_mem_nhds hc'))
  let U := max 1 M
  have h₁U : 1 ≤ U := le_max_left _ _
  have hOne : (1 : ℝ) ∈ Icc δ U := ⟨hδ₁, h₁U⟩
  obtain ⟨a, ha, hA⟩ := isCompact_Icc.exists_isMinOn ⟨1, hOne⟩
    (hf.mono (fun z hz => hδ.trans_le hz.1))
  refine ⟨a, hδ.trans_le ha.1, ?_⟩
  intro z hz
  have hBest : f a < c := (hA hOne).trans_lt hc
  rcases lt_or_ge z δ with h | h
  · have hz' : z ∈ Metric.ball (0 : ℝ) ε ∩ Ioi 0 := by
      refine ⟨?_, hz⟩
      rw [Metric.mem_ball, Real.dist_eq, sub_zero, abs_of_pos hz]
      exact h.trans_le (min_le_right _ _)
    exact hBest.le.trans (hεmem hz').le
  · rcases le_or_gt z U with h' | h'
    · exact hA ⟨h, h'⟩
    · exact hBest.le.trans (hM z ((le_max_right _ _).trans h'.le)).le

theorem scalar_deficit_attained (p q : FiniteMass κ) (hp : ∀ y, 0 < p y)
    (hq : ∀ y, 0 < q y) (hne : p ≠ q) (b : ℝ) (hb : 0 < b) :
    ∃ a > 0, ∀ z > 0, scalarDeficit p q b a ≤ scalarDeficit p q b z :=
  interior_minimum_from_limits _ (scalar_deficit_continuous p q b hb)
    (scalar_deficit_tendsto_zero p q hp b hb) (scalar_deficit_tendsto_infinity p q hp hq b hb)
    (scalar_deficit_below_one p q hp hne hb zero_lt_one)

theorem product_scalar_deficit_as_finite (p q : FiniteMass κ) (n : ℕ) (b : ℝ) :
    productScalarDeficit p q n b = scalarDeficit (FiniteMass.tensor (fun _ : Fin n => p))
      (FiniteMass.tensor (fun _ : Fin n => q)) b := by
  funext a
  unfold productScalarDeficit scalarDeficit
  rw [scalar_moment_of_products]

theorem product_deficit_attained (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y) (hne : p ≠ q)
    {n : ℕ} (hn : 0 < n) (b : ℝ) (hb : 0 < b) :
    ∃ a > 0, IsLeast (productDeficitValues p q n b) (productScalarDeficit p q n b a) := by
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  let Q := FiniteMass.tensor (fun _ : Fin n => q)
  have hP (x : Fin n → κ) : 0 < P x := FiniteMass.tensor_pos _ (fun _ y => hp y) x
  have hQ (x : Fin n → κ) : 0 < Q x := FiniteMass.tensor_pos _ (fun _ y => hq y) x
  have hEq : productScalarDeficit p q n b = scalarDeficit P Q b :=
    product_scalar_deficit_as_finite p q n b
  obtain ⟨a, ha, hA⟩ := interior_minimum_from_limits (productScalarDeficit p q n b)
    (by rw [hEq]; exact scalar_deficit_continuous P Q b hb)
    (by rw [hEq]; exact scalar_deficit_tendsto_zero P Q hP b hb)
    (by rw [hEq]; exact scalar_deficit_tendsto_infinity P Q hP hQ b hb)
    (product_scalar_deficit_lt_one p q hp hq hne hn b 1 hb zero_lt_one)
  refine ⟨a, ha, ⟨a, ha, rfl⟩, ?_⟩
  rintro x ⟨z, hz, rfl⟩
  exact hA z hz

theorem product_contraction_attained (w : BinarySymmetricChannel κ)
    {n : ℕ} (hn : 0 < n) (b : ℝ) (hb : 1 ≤ b) :
    ∃ a > 0,
      1 - contractionCoefficient b (tensorChannel w.channel n) =
        productScalarDeficit (w.channel false) (w.channel true) n b a ∧
      IsLeast (productDeficitValues (w.channel false) (w.channel true) n b)
        (productScalarDeficit (w.channel false) (w.channel true) n b a) := by
  obtain ⟨a, ha, hA⟩ := product_deficit_attained _ _ (w.positive false) (w.positive true)
    w.informative hn b (zero_lt_one.trans_le hb)
  exact ⟨a, ha, (product_contraction_deficit w hn b hb).trans hA.csInf_eq, hA⟩

end RenyiProductOrderPhase
