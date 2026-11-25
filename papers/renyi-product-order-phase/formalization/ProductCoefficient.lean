import HammingReduction
import DiracCoefficient

/-! The exact finite product contraction deficit. -/

open Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem product_scalar_moment_zero (p q : FiniteMass κ) (b a : ℝ) :
    productScalarMoment p q 0 b a = (1 + a) ^ (-b) := by
  simp [productScalarMoment, likelihoodProduct, FiniteMass.expect_const]

theorem product_scalar_deficit_pos (p q : FiniteMass κ) (hq : ∀ y, 0 < q y)
    (n : ℕ) (b a : ℝ) (hb : 0 < b) (ha : 0 < a) :
    0 < productScalarDeficit p q n b a := by
  unfold productScalarDeficit
  rw [← scalar_moment_of_products]
  exact div_pos
    (neg_pos.mpr (Real.log_neg (scalar_moment_pos _ _ b ha)
      (scalar_moment_lt_one _ _ b hb ha (FiniteMass.tensor_pos _ (fun _ y => hq y)))))
    (mul_pos hb (Real.log_pos (by linarith)))

theorem product_scalar_deficit_lt_one (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y) (hne : p ≠ q) {n : ℕ} (hn : 0 < n)
    (b a : ℝ) (hb : 0 < b) (ha : 0 < a) :
    productScalarDeficit p q n b a < 1 := by
  have hlt : productScalarMoment p q 0 b a < productScalarMoment p q n b a :=
    product_scalar_moment_mono p q hp hq hne b a hb ha hn
  rw [product_scalar_moment_zero] at hlt
  have hbase : 0 < 1 + a := by linarith
  have h := Real.log_lt_log (Real.rpow_pos_of_pos hbase (-b)) hlt
  rw [Real.log_rpow hbase] at h
  unfold productScalarDeficit
  apply (div_lt_iff₀ (mul_pos hb (Real.log_pos (by linarith)))).2
  linarith only [h]

theorem prior_parameterization {t : ℝ} (h₀ : 0 < t) (h₁ : t < 1) :
    ∃ a : ℝ, 0 < a ∧ priorWeight a = t := by
  refine ⟨t⁻¹ - 1, sub_pos.mpr ((one_lt_inv₀ h₀).mpr h₁), ?_⟩
  unfold priorWeight
  rw [show 1 + (t⁻¹ - 1) = t⁻¹ by ring, inv_inv]

theorem dirac_tensor_ratio (w : BinarySymmetricChannel κ) {n : ℕ}
    {x y : Fin n → Bool} (hxy : x ≠ y) (b : ℝ) (hb : 0 < b) {a : ℝ} (ha : 0 < a) :
    diracRatio (tensorChannel w.channel n) b x y (priorWeight a) (prior_weight_mem ha) =
      1 - productScalarDeficit (w.channel false) (w.channel true) (mismatchCount x y) b a := by
  unfold diracRatio
  rw [dirac_channel_ratio_eq_scalar b hb _ hxy (tensor_channel_pos w.channel w.positive x) ha]
  unfold scalarDeficit productScalarDeficit
  rw [tensor_channel_scalar_distance]

def productDeficitValues (p q : FiniteMass κ) (n : ℕ) (b : ℝ) : Set ℝ :=
  {u | ∃ a > 0, u = productScalarDeficit p q n b a}

theorem product_contraction_deficit (w : BinarySymmetricChannel κ)
    {n : ℕ} (hn : 0 < n) (b : ℝ) (hb : 1 ≤ b) :
    1 - contractionCoefficient b (tensorChannel w.channel n) =
      sInf (productDeficitValues (w.channel false) (w.channel true) n b) := by
  let x : Fin n → Bool := fun _ => false
  let y : Fin n → Bool := fun _ => true
  have hxy : x ≠ y := fun he => Bool.false_ne_true (congrFun he ⟨0, hn⟩)
  letI : Nontrivial (Fin n → Bool) := ⟨⟨x, y, hxy⟩⟩
  let W := tensorChannel w.channel n
  let S := diracRatios W b
  let B := productDeficitValues (w.channel false) (w.channel true) n b
  let Φ := productScalarDeficit (w.channel false) (w.channel true)
  have hb₀ : 0 < b := zero_lt_one.trans_le hb
  have hS : S.Nonempty := dirac_ratios_nonempty W b
  have hSu : BddAbove S := ⟨1, fun z hz =>
    (dirac_ratio_mem_unit W (tensor_channel_pos w.channel w.positive) b hb₀ hz).2⟩
  have hB : B.Nonempty := ⟨Φ n b 1, 1, zero_lt_one, rfl⟩
  have hBl : BddBelow B := by
    refine ⟨0, ?_⟩
    rintro z ⟨a, ha, rfl⟩
    exact (product_scalar_deficit_pos _ _ (w.positive true) n b a hb₀ ha).le
  rw [contraction_coefficient_dirac W (tensor_channel_pos w.channel w.positive) b hb]
  change 1 - sSup S = sInf B
  apply le_antisymm
  · apply le_csInf hB
    rintro z ⟨a, ha, rfl⟩
    have hmem : diracRatio W b x y (priorWeight a) (prior_weight_mem ha) ∈ S :=
      ⟨x, y, hxy, priorWeight a, prior_weight_mem ha, (prior_weight_bounds ha).1,
        (prior_weight_bounds ha).2, rfl⟩
    have hle := le_csSup hSu hmem
    have he : mismatchCount x y = n := mismatch_count_antipodal n
    rw [show diracRatio W b x y (priorWeight a) (prior_weight_mem ha) =
      1 - Φ n b a by rw [dirac_tensor_ratio w hxy b hb₀ ha, he]] at hle
    linarith only [hle]
  · have hle : sSup S ≤ 1 - sInf B := by
      apply csSup_le hS
      rintro z ⟨i, j, hij, t, ht, ht₀, ht₁, rfl⟩
      obtain ⟨a, ha, he⟩ := prior_parameterization ht₀ ht₁
      subst t
      rw [dirac_tensor_ratio w hij b hb₀ ha]
      have hanti : Φ n b a ≤ Φ (mismatchCount i j) b a :=
        (product_scalar_deficit_strict_antitone (w.channel false) (w.channel true)
          (w.positive false) (w.positive true) w.informative b a hb₀ ha).antitone
            (mismatch_count_le i j)
      have hinf : sInf B ≤ Φ n b a := csInf_le hBl ⟨a, ha, rfl⟩
      linarith only [hanti, hinf]
    linarith only [hle]


theorem maximizing_dirac_pair_antipodal (w : BinarySymmetricChannel κ)
    {n : ℕ} (hn : 0 < n) (b : ℝ) (hb : 1 ≤ b) {x y : Fin n → Bool} (hxy : x ≠ y)
    {a : ℝ} (ha : 0 < a)
    (hOpt : diracRatio (tensorChannel w.channel n) b x y (priorWeight a) (prior_weight_mem ha) =
      contractionCoefficient b (tensorChannel w.channel n)) :
    mismatchCount x y = n := by
  by_contra hne
  have hlt : mismatchCount x y < n := lt_of_le_of_ne (mismatch_count_le x y) hne
  let u : Fin n → Bool := fun _ => false
  let v : Fin n → Bool := fun _ => true
  have huv : u ≠ v := fun he => Bool.false_ne_true (congrFun he ⟨0, hn⟩)
  letI : Nontrivial (Fin n → Bool) := ⟨⟨u, v, huv⟩⟩
  let W := tensorChannel w.channel n
  have hW : ∀ i j, 0 < W i j := tensor_channel_pos w.channel w.positive
  have hb₀ : 0 < b := zero_lt_one.trans_le hb
  have hVal : diracRatio W b u v (priorWeight a) (prior_weight_mem ha) ∈ diracRatios W b :=
    ⟨u, v, huv, priorWeight a, prior_weight_mem ha, (prior_weight_bounds ha).1,
      (prior_weight_bounds ha).2, rfl⟩
  have hBound : BddAbove (diracRatios W b) :=
    ⟨1, fun t ht => (dirac_ratio_mem_unit W hW b hb₀ ht).2⟩
  have hle := le_csSup hBound hVal
  rw [← contraction_coefficient_dirac W hW b hb, ← hOpt] at hle
  rw [dirac_tensor_ratio w huv b hb₀ ha, dirac_tensor_ratio w hxy b hb₀ ha,
    show mismatchCount u v = n from mismatch_count_antipodal n] at hle
  have hstrict := product_scalar_deficit_strict_antitone (w.channel false) (w.channel true)
    (w.positive false) (w.positive true) w.informative b a hb₀ ha hlt
  change productScalarDeficit (w.channel false) (w.channel true) n b a <
    productScalarDeficit (w.channel false) (w.channel true) (mismatchCount x y) b a at hstrict
  linarith only [hle, hstrict]

end RenyiProductOrderPhase
