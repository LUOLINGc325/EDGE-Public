import LatticeCorrection
import Mathlib.Data.Finset.Max

open Filter
open scoped Topology

namespace TwoColorNullity.Occupancy

def meanScreenNumerator (n s : ℕ) : ℕ :=
  let k := 2 ^ s
  let m := 3 * n - 1
  k * (k ^ m - (k - 2) ^ m)

def meanScreenDenominator (n s : ℕ) : ℕ :=
  2 * (2 ^ s) ^ (3 * n - 1)

def meanPasses (n s : ℕ) : Bool :=
  decide (meanScreenNumerator n s ≤ (n + 2 * s - 1) * meanScreenDenominator n s)

/-- The occupancy mean is evaluated using rational integer arithmetic. -/
theorem oddMean_exact_rational (n s : ℕ) (hs : 1 ≤ s) :
    finiteMean (fun draws : Fin (3 * n - 1) → Fin (2 ^ s) => (oddBinCount draws : ℝ)) =
      (meanScreenNumerator n s : ℝ) / (meanScreenDenominator n s : ℝ) := by
  let k := 2 ^ s
  let m := 3 * n - 1
  letI : NeZero k := ⟨by unfold k; positivity⟩
  have hk : 0 < (k : ℝ) := by positivity
  have htwo : 2 ≤ k := by
    simpa only [pow_one] using pow_le_pow_right₀ (by decide : 1 ≤ (2 : ℕ)) hs
  have hpow : (k - 2) ^ m ≤ k ^ m := Nat.pow_le_pow_left (Nat.sub_le _ _) _
  rw [oddBinCount_mean, Fintype.card_fin, Fintype.card_fin]
  change (k : ℝ) / 2 * (1 - (1 - 2 / (k : ℝ)) ^ m) =
    ((k * (k ^ m - (k - 2) ^ m) : ℕ) : ℝ) / ((2 * k ^ m : ℕ) : ℝ)
  push_cast [Nat.cast_sub hpow, Nat.cast_sub htwo]
  have hrewrite : 1 - 2 / (k : ℝ) = ((k : ℝ) - 2) / (k : ℝ) := by field_simp [hk.ne']
  rw [hrewrite, div_pow]
  field_simp [hk.ne', pow_ne_zero _ hk.ne']

theorem meanPasses_spec (n s : ℕ) (hs : 1 ≤ s) :
    meanPasses n s = true ↔ finiteMean
      (fun draws : Fin (3 * n - 1) → Fin (2 ^ s) => (oddBinCount draws : ℝ)) ≤
        ((n + 2 * s - 1 : ℕ) : ℝ) := by
  have hpos : (0 : ℝ) < meanScreenDenominator n s := by unfold meanScreenDenominator; positivity
  rw [oddMean_exact_rational n s hs, div_le_iff₀ hpos]
  unfold meanPasses
  rw [decide_eq_true_eq]
  exact_mod_cast (Iff.rfl : meanScreenNumerator n s ≤ (n + 2 * s - 1) * meanScreenDenominator n s ↔ _)

def meanCandidateRange (n : ℕ) : Finset ℕ := Finset.Icc n.log2 (largeSetThreshold n - 1)

def passingMeanCandidates (n : ℕ) : Finset ℕ := (meanCandidateRange n).filter fun s => meanPasses n s

def selectMeanSize (n : ℕ) : Option ℕ :=
  if h : (passingMeanCandidates n).Nonempty then some ((passingMeanCandidates n).max' h) else none

theorem meanCandidateRange_card (n : ℕ) (hn : 1 ≤ n) : (meanCandidateRange n).card ≤ 7 := by
  have hlog := (binaryLog_floor_bounds n (by omega)).2
  have ht : (largeSetThreshold n : ℝ) < (n.log2 : ℝ) + 8 := by
    linarith only [threshold_le_binaryLog_add n (by omega), hlog]
  have hcast : largeSetThreshold n < n.log2 + 8 := by exact_mod_cast ht
  unfold meanCandidateRange
  rw [Nat.card_Icc]
  omega

theorem floor_mem_meanCandidateRange (n : ℕ) (hn : 1 ≤ n) :
    transitionFloor n ∈ meanCandidateRange n := by
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hp : (n : ℝ) ≤ (2 : ℝ) ^ Nat.clog 2 n := by exact_mod_cast Nat.le_pow_clog (by decide : 1 < 2) n
  have hlog := Real.log_le_log hnR hp
  rw [Real.log_pow] at hlog
  have hc : binaryLog n ≤ (Nat.clog 2 n : ℝ) := (div_le_iff₀ log_two_pos).mpr hlog
  have h := (transitionFloor_le_log_add_two n hn).trans (add_le_add_right hc 2)
  have hcast : transitionFloor n ≤ Nat.clog 2 n + 2 := by exact_mod_cast h
  exact Finset.mem_Icc.mpr ⟨transitionFloor_at_least_log2 n hn, by unfold largeSetThreshold; omega⟩

theorem selectMeanSize_of_max (n s : ℕ) (hs : s ∈ passingMeanCandidates n)
    (hmax : ∀ t ∈ passingMeanCandidates n, t ≤ s) : selectMeanSize n = some s := by
  have hne : (passingMeanCandidates n).Nonempty := ⟨s, hs⟩
  unfold selectMeanSize
  rw [dif_pos hne, Option.some.injEq]
  exact le_antisymm (Finset.max'_le (passingMeanCandidates n) hne s hmax) ((passingMeanCandidates n).le_max' _ hs)

end TwoColorNullity.Occupancy
