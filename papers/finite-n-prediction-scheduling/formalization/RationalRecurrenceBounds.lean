import RationalUnitBounds

/-! Exact rational sizes of the elementary operations in the unit recurrence. -/

open scoped BigOperators

namespace FiniteFrontier

noncomputable def integerGapNumerator (P Q : ℤ) (m j : ℕ) : ℤ :=
  Q * (m + 1) - (P + Q) * (j + 1)

theorem integer_gap_cast (P Q : ℤ) (m j : ℕ) (hQ : 0 < Q) :
    (integerGapNumerator P Q m j : ℝ) =
      (Q : ℝ) * unitGap (m : ℝ) ((P : ℝ) / (Q : ℝ)) ((j : ℝ) + 1) := by
  have hQr : 0 < (Q : ℝ) := by exact_mod_cast hQ
  unfold integerGapNumerator unitGap
  push_cast
  (field_simp [hQr.ne']; ring)

theorem integer_gap_twice_bound (P Q : ℤ) {m n j : ℕ} (hm : m ≤ n) (hj : j + 1 ≤ m)
    (B : ℝ) (hB : 1 ≤ B) (hP : |(P : ℝ)| ≤ B) (hQ : |(Q : ℝ)| ≤ B) :
    |((2 * integerGapNumerator P Q m j : ℤ) : ℝ)| ≤ encodingBase n B := by
  have hmr : (m : ℝ) ≤ n := by exact_mod_cast hm
  have hjr : (j : ℝ) + 1 ≤ (m : ℝ) := by exact_mod_cast hj
  have hPQ : |(P : ℝ) + Q| ≤ 2 * B := by
    exact (abs_add_le _ _).trans (by linarith only [hP, hQ])
  have hg : |(integerGapNumerator P Q m j : ℝ)| ≤ 3 * B * ((n : ℝ) + 1) := by
    unfold integerGapNumerator
    push_cast
    apply (abs_sub _ _).trans
    rw [abs_mul, abs_mul, abs_of_nonneg (by positivity : 0 ≤ (m : ℝ) + 1),
      abs_of_nonneg (by positivity : 0 ≤ (j : ℝ) + 1)]
    have hp := mul_le_mul hQ (add_le_add_right hmr 1) (by positivity) (by positivity)
    have hq := mul_le_mul hPQ (show (j : ℝ) + 1 ≤ (n : ℝ) + 1 by linarith only [hjr, hmr])
      (by positivity) (by positivity)
    linarith only [hp, hq]
  push_cast
  rw [abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 2)]
  apply (mul_le_mul_of_nonneg_left hg (by norm_num)).trans
  unfold encodingBase
  have hbn : 0 ≤ B * (n : ℝ) := by positivity
  nlinarith only [hB, hbn, show 0 ≤ (n : ℝ) by positivity]

theorem active_fraction_height {m n j a : ℕ} {R : ℝ} (b : UnitBranch m R a) (hm : m ≤ n)
    (hj : j + 1 ≤ a) (P Q : ℤ) (hQ : 0 < Q) (hR : R = (P : ℝ) / (Q : ℝ))
    (B : ℝ) (hB : 1 ≤ B) (hP : |(P : ℝ)| ≤ B) (hQb : |(Q : ℝ)| ≤ B) :
    FractionHeight (unitFraction m R ((j : ℝ) + 1)) (encodingBase n B ^ 2) := by
  let K := encodingBase n B
  let D := integerBranchDenominator P Q m j
  let G := integerGapNumerator P Q m j
  let M := (m : ℤ) - ((j : ℤ) + 1)
  have hjm : j + 1 < m := hj.trans_lt b.index
  have hM : 0 < M := sub_pos.mpr (by exact_mod_cast hjm)
  have hMr : 0 < (M : ℝ) := by exact_mod_cast hM
  have hQp : 0 < (Q : ℝ) := by exact_mod_cast hQ
  have hd := unit_denominator_positive (m : ℝ) R ((j : ℝ) + 1)
    b.num_jobs_real b.robust (by linarith only [show (0 : ℝ) ≤ j by positivity])
  have he := integer_branch_denominator_cast P Q m j hQ
  rw [← hR] at he
  have hDr : 0 < (D : ℝ) := by rw [he]; positivity
  have hD : 0 < D := by exact_mod_cast hDr
  have hMM : (M : ℝ) ≤ K := by
    have hmn : (m : ℝ) ≤ n := by exact_mod_cast hm
    have hj₀ : (0 : ℝ) ≤ j := by positivity
    have hm' : (M : ℝ) ≤ m := by unfold M; push_cast; linarith only [hj₀]
    exact hm'.trans (hmn.trans (encoding_base_ge_n n B hB))
  have hDd := (unit_integer_factors_bound P Q m j n hm (by omega) B hB hP hQb).1
  change |(D : ℝ)| ≤ K at hDd
  have hDK : (D : ℝ) ≤ K := by simpa only [abs_of_pos hDr] using hDd
  have hG := integer_gap_twice_bound P Q hm hjm.le B hB hP hQb
  have hK : 2 ≤ K := encoding_base_ge_two n B hB
  refine ⟨2 * G, M * D, mul_pos hM hD, hG.trans ?_, ?_, ?_⟩
  · simpa only [pow_two, one_mul] using mul_le_mul_of_nonneg_right (show (1 : ℝ) ≤ K by linarith) (by positivity : 0 ≤ K)
  · push_cast
    rw [pow_two]
    exact mul_le_mul hMM hDK hDr.le (by positivity)
  · have hg := integer_gap_cast P Q m j hQ
    rw [← hR] at hg
    have hMcast : (M : ℝ) = (m : ℝ) - ((j : ℝ) + 1) := by unfold M; push_cast; ring
    unfold unitFraction
    push_cast
    rw [hg, he, ← hMcast]
    (field_simp [hQp.ne', hMr.ne', hd.ne']; ring)

theorem raw_recurrence_step_height (K f q : ℝ) (hK : 2 ≤ K) (j : ℕ)
    (hf : FractionHeight f (K ^ 2)) (hq : FractionHeight q (K ^ j))
    (hq₀ : 0 ≤ q) (hq₁ : q ≤ 1) :
    FractionHeight (q + f * (1 - q)) (K ^ (2 * j + 3)) := by
  have hcorrection := hf.mul (hq.one_sub_of_unit hq₀ hq₁)
  have h := hq.add hcorrection
  apply h.mono
  have hsmall : 2 * K ^ j * (K ^ 2 * K ^ j) = 2 * K ^ (2 * j + 2) := by
    rw [show 2 * j + 2 = j + (2 + j) by omega, pow_add, pow_add]
    ring
  rw [hsmall, show 2 * j + 3 = (2 * j + 2) + 1 by omega, pow_succ]
  have hp : 0 ≤ K ^ (2 * j + 2) := by positivity
  simpa only [mul_comm (2 : ℝ), mul_comm K] using mul_le_mul_of_nonneg_right hK hp

end FiniteFrontier
