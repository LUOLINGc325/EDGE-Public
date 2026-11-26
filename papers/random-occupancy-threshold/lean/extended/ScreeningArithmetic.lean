import MeanScreening

open Filter

namespace TwoColorNullity.Occupancy

def screeningBitWidth (n s : ℕ) : ℕ := s * (3 * n) + 4

theorem screening_integers_fit (n s : ℕ) (hn : 1 ≤ n) (hsize : n.log2 ≤ s) (hsn : s ≤ n) :
    meanScreenNumerator n s < 2 ^ screeningBitWidth n s ∧
      (n + 2 * s - 1) * meanScreenDenominator n s < 2 ^ screeningBitWidth n s := by
  let k := 2 ^ s
  let m := 3 * n - 1
  have hk : 0 < k := by unfold k; positivity
  have hkpow : 0 < k ^ m := pow_pos hk _
  have hms : m + 1 = 3 * n := by unfold m; omega
  have hbound : 2 ^ screeningBitWidth n s = 16 * k * k ^ m := by
    unfold screeningBitWidth
    rw [← hms, pow_add, pow_mul, pow_succ]
    change (k ^ m * k) * 2 ^ 4 = _
    norm_num
    ring
  have hn2 : n < 2 * k := by
    have hlog : n < 2 ^ (n.log2 + 1) := (Nat.log2_lt (by omega)).mp (by omega)
    have hpow := pow_le_pow_right₀ (by decide : (1 : ℕ) ≤ 2) (Nat.add_le_add_right hsize 1)
    have h := hlog.trans_le hpow
    rw [pow_succ, Nat.mul_comm] at h
    exact h
  rw [hbound]
  constructor
  · change k * (k ^ m - (k - 2) ^ m) < 16 * k * k ^ m
    have hsmall := Nat.mul_le_mul_left k (Nat.sub_le (k ^ m) ((k - 2) ^ m))
    exact hsmall.trans_lt ((Nat.mul_lt_mul_right hkpow).mpr (by omega))
  · change (n + 2 * s - 1) * (2 * k ^ m) < 16 * k * k ^ m
    have hsmall : (n + 2 * s - 1) * 2 < 16 * k := by omega
    rw [← Nat.mul_assoc]
    exact (Nat.mul_lt_mul_right hkpow).mpr hsmall

theorem screening_bit_width_log_bound (n s : ℕ) (hn : 1 ≤ n) (hs : s ∈ meanCandidateRange n) :
    screeningBitWidth n s ≤ 22 * n * (n.log2 + 1) := by
  have hlt := (binaryLog_floor_bounds n (by omega)).2
  have hcut : (largeSetThreshold n : ℝ) < (n.log2 : ℝ) + 8 := by
    linarith only [threshold_le_binaryLog_add n (by omega), hlt]
  have hcutN : largeSetThreshold n < n.log2 + 8 := by exact_mod_cast hcut
  have hsMax : s ≤ largeSetThreshold n - 1 := (Finset.mem_Icc.mp hs).2
  have h6 : s ≤ 6 * (n.log2 + 1) := by omega
  have hm := Nat.mul_le_mul_right (3 * n) h6
  have hnprod : 1 ≤ n * (n.log2 + 1) := Nat.mul_pos (by omega) (by omega)
  unfold screeningBitWidth
  calc
    _ ≤ 6 * (n.log2 + 1) * (3 * n) + 4 * (n * (n.log2 + 1)) :=
      Nat.add_le_add hm (by simpa only [Nat.mul_one] using Nat.mul_le_mul_left 4 hnprod)
    _ = _ := by ring

def bitOperationsModel (n s : ℕ) : ℕ :=
  7 * ((4 * (3 * n) + 5) * screeningBitWidth n s ^ 2) +
    n * wordRAMWork (3 * n - 1) n s + 30 * n ^ 3

/-- A polynomial budget for rational screening, bucket scans and allocation assembly. -/
theorem screening_polynomial_budget (n s : ℕ) (hn : 1 ≤ n) (hs : s ≤ n) (hk : 2 ^ s ≤ 64 * n) :
    bitOperationsModel n s ≤ 10000 * n ^ 5 := by
  have hn0 : 0 < n := by omega
  have hnsq : 1 ≤ n * n := Nat.mul_pos hn0 hn0
  have hb : screeningBitWidth n s ≤ 7 * n ^ 2 := by
    unfold screeningBitWidth
    have h := Nat.mul_le_mul_right (3 * n) hs
    have hs' : n * (3 * n) = 3 * (n * n) := by ring
    rw [hs'] at h
    rw [pow_two]
    omega
  have hOp : 4 * (3 * n) + 5 ≤ 17 * n := by omega
  have hRational : 7 * ((4 * (3 * n) + 5) * screeningBitWidth n s ^ 2) ≤ 5831 * n ^ 5 := by
    have hp := pow_le_pow_left₀ (Nat.zero_le _) hb 2
    calc
      _ ≤ 7 * ((17 * n) * (7 * n ^ 2) ^ 2) := Nat.mul_le_mul_left _ (Nat.mul_le_mul hOp hp)
      _ = _ := by ring
  have hm : 3 * n - 1 ≤ 3 * n := Nat.sub_le _ _
  have hcore : 3 * (3 * n - 1) * s ≤ 9 * n ^ 2 := by
    have h := Nat.mul_le_mul (Nat.mul_le_mul_left 3 hm) hs
    refine h.trans_eq ?_
    ring
  have hLin : 92 * n ≤ 92 * n ^ 2 := by
    have h := Nat.mul_le_mul_left n hn
    simpa only [Nat.mul_one, pow_two] using Nat.mul_le_mul_left 92 h
  have hBucket : wordRAMWork (3 * n - 1) n s ≤ 101 * n ^ 2 := by
    unfold wordRAMWork
    have hpass := Nat.mul_le_mul_left 8 hm
    omega
  have hBucketTotal : n * wordRAMWork (3 * n - 1) n s ≤ 101 * n ^ 3 :=
    (Nat.mul_le_mul_left n hBucket).trans_eq (by ring)
  have hsmall : n ^ 3 ≤ n ^ 5 := pow_le_pow_right₀ hn (by decide)
  unfold bitOperationsModel
  have hstep := Nat.add_le_add (Nat.add_le_add hRational hBucketTotal) (le_refl (30 * n ^ 3))
  have hprev := Nat.mul_le_mul_left 101 hsmall
  have hlast := Nat.mul_le_mul_left 30 hsmall
  omega


/-- All candidate sizes satisfy the bit-width and work budgets for sufficiently large populations. -/
theorem mean_candidate_budgets_eventually :
    ∀ᶠ n : ℕ in atTop, ∀ s ∈ meanCandidateRange n,
      screeningBitWidth n s ≤ 22 * n * (n.log2 + 1) ∧ bitOperationsModel n s ≤ 10000 * n ^ 5 := by
  filter_upwards [eventually_ge_atTop (1 : ℕ), largeSetThreshold_eventually_le] with n hn hlarge
  intro s hs
  have hrange := (Finset.mem_Icc.mp hs).2
  have hpos : 0 < largeSetThreshold n := by unfold largeSetThreshold; omega
  have hcut : s < largeSetThreshold n := by omega
  have hsn : s ≤ n := hcut.le.trans hlarge
  have hnR : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hreal := (div_le_iff₀ hnR).mp (bins_ratio_le_sixty_four_of_before_cutoff n s hn hcut)
  have hk : 2 ^ s ≤ 64 * n := by exact_mod_cast hreal
  exact ⟨screening_bit_width_log_bound n s hn hs, screening_polynomial_budget n s hn hsn hk⟩

end TwoColorNullity.Occupancy
