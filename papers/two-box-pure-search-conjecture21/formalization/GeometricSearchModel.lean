import SearchExpectation
import Mathlib.Probability.Distributions.Geometric
import Mathlib.MeasureTheory.Integral.Lebesgue.Countable

/-!
# A probability model for the search game

The random natural number `k` is the number of failed searches of the occupied
box before its first detection. Its law is Mathlib's geometric probability
measure with success probability `1 - 1/m`. A deterministic word spends one
unit at each stage whose visit count has not yet exceeded `k`; their sum is the
possibly infinite detection time. Tonelli's theorem derives the survival-tail
formula from this model. No finite-expectation assumption is needed.
-/

set_option autoImplicit false

open MeasureTheory Finset
open scoped ENNReal

namespace PureSearch

noncomputable def detectionMass (m : ℝ) (k : ℕ) : ℝ≥0∞ :=
  ENNReal.ofReal ((1 / m) ^ k * (1 - 1 / m))

noncomputable def detectionLaw (m : ℝ) (hm : 1 < m) : PMF ℕ :=
  ProbabilityTheory.geometricPMF
    (p := 1 - 1 / m)
    (by have : 1 / m < 1 := (div_lt_one (by linarith)).mpr hm; linarith)
    (by have : 0 < 1 / m := one_div_pos.mpr (by linarith); linarith)

lemma detection_law_apply (m : ℝ) (hm : 1 < m) (k : ℕ) :
    detectionLaw m hm k = detectionMass m k := by
  change ENNReal.ofReal ((1 - (1 - 1 / m)) ^ k * (1 - 1 / m)) = _
  simp [detectionMass]

/-- The law used in the model is a normalized probability mass function. -/
theorem detection_mass_normalized (m : ℝ) (hm : 1 < m) :
    ∑' k, detectionMass m k = 1 := by
  simpa only [detection_law_apply] using (detectionLaw m hm).tsum_coe

lemma detection_mass_shift (m : ℝ) (hm : 1 < m) (n k : ℕ) :
    detectionMass m (k + n) = ENNReal.ofReal ((1 / m) ^ n) * detectionMass m k := by
  have hr0 : 0 ≤ 1 / m := (one_div_pos.mpr (by linarith : 0 < m)).le
  unfold detectionMass
  rw [← ENNReal.ofReal_mul (pow_nonneg hr0 n)]
  congr 1
  rw [pow_add]
  ring

/-- The chance that the first `n` searches of the occupied box all fail. -/
theorem detection_mass_tail (m : ℝ) (hm : 1 < m) (n : ℕ) :
    (∑' k, if n ≤ k then detectionMass m k else 0) = ENNReal.ofReal ((1 / m) ^ n) := by
  have hprefix : (∑ k ∈ range n, if n ≤ k then detectionMass m k else 0) = 0 := by
    apply sum_eq_zero
    intro k hk
    simp [Nat.not_le.mpr (mem_range.mp hk)]
  have hsplit :
      (∑ k ∈ range n, if n ≤ k then detectionMass m k else 0) +
        (∑' k, if n ≤ k + n then detectionMass m (k + n) else 0) =
      ∑' k, if n ≤ k then detectionMass m k else 0 :=
    ENNReal.summable.sum_add_tsum_nat_add'
  have htail : (∑' k, if n ≤ k then detectionMass m k else 0) =
      ∑' k, detectionMass m (k + n) := by
    simpa only [hprefix, zero_add, Nat.le_add_left, ↓reduceIte] using hsplit.symm
  rw [htail]
  simp_rw [detection_mass_shift m hm n]
  rw [ENNReal.tsum_mul_left, detection_mass_normalized m hm, mul_one]

/-- Exact lack-of-memory identity for occupied-box failures. -/
theorem detection_law_memoryless (m : ℝ) (hm : 1 < m) (n k : ℕ) :
    (∑' t, if n + k ≤ t then detectionMass m t else 0) =
      (∑' t, if n ≤ t then detectionMass m t else 0) *
        (∑' t, if k ≤ t then detectionMass m t else 0) := by
  rw [detection_mass_tail m hm (n + k), detection_mass_tail m hm n,
    detection_mass_tail m hm k]
  have hr0 : 0 ≤ 1 / m := (one_div_pos.mpr (by linarith : 0 < m)).le
  rw [← ENNReal.ofReal_mul (pow_nonneg hr0 n), pow_add]

/-- Survival after any scheduled prefix is derived from the probability law. -/
theorem scheduled_survival_probability (m : ℝ) (hm : 1 < m)
    (s : ℕ → Bool) (b : Bool) (n : ℕ) :
    (∑' k, if visits s b n ≤ k then detectionLaw m hm k else 0) =
      ENNReal.ofReal (survival m s b n) := by
  simp_rw [detection_law_apply]
  exact detection_mass_tail m hm (visits s b n)

/-- Number of units spent searching before the `(k+1)`st search of the occupied
box. The value is infinity if that search never occurs. -/
noncomputable def detectionTime (s : ℕ → Bool) (b : Bool) (k : ℕ) : ℝ≥0∞ :=
  ∑' n, if visits s b n ≤ k then (1 : ℝ≥0∞) else 0

lemma visits_monotone (s : ℕ → Bool) (b : Bool) : Monotone (visits s b) := by
  apply monotone_nat_of_le_succ
  intro n
  simp only [visits]
  omega

/-- This random variable is exactly the first successful search time whenever
the successful occupied-box visit occurs at a finite stage. -/
theorem detection_time_at_first_success (s : ℕ → Bool) (b : Bool) (k t : ℕ)
    (hbefore : visits s b t ≤ k) (hafter : k < visits s b (t + 1)) :
    detectionTime s b k = (t + 1 : ℕ) := by
  have halive (n : ℕ) : visits s b n ≤ k ↔ n < t + 1 := by
    constructor
    · intro hn
      by_contra h
      have hcount := visits_monotone s b (by omega : t + 1 ≤ n)
      omega
    · intro hn
      exact (visits_monotone s b (by omega : n ≤ t)).trans hbefore
  unfold detectionTime
  simp_rw [halive]
  rw [tsum_eq_sum (s := range (t + 1)) (fun n hn => by simp [show ¬n < t + 1 by simpa using hn])]
  calc
    (∑ n ∈ range (t + 1), if n < t + 1 then (1 : ℝ≥0∞) else 0) =
        ∑ _n ∈ range (t + 1), (1 : ℝ≥0∞) :=
      sum_congr rfl (fun n hn => if_pos (mem_range.mp hn))
    _ = (t + 1 : ℕ) := by simp

/-- A word that never reaches the successful occupied-box visit has infinite
conditional detection time, not a default real-series value. -/
theorem detection_time_infinite (s : ℕ → Bool) (b : Bool) (k : ℕ)
    (hnever : ∀ n, visits s b n ≤ k) : detectionTime s b k = ∞ := by
  simp only [detectionTime, hnever, ↓reduceIte]
  exact ENNReal.tsum_const_eq_top_of_ne_zero (by simp)

noncomputable def expectedDetectionTime (m : ℝ) (s : ℕ → Bool) (b : Bool) : ℝ≥0∞ :=
  ∑' k, detectionMass m k * detectionTime s b k

/-- The weighted sum is the actual nonnegative integral of the detection-time
random variable with respect to the geometric probability measure. -/
theorem expected_detection_time_integral (m : ℝ) (hm : 1 < m)
    (s : ℕ → Bool) (b : Bool) :
    expectedDetectionTime m s b =
      ∫⁻ k, detectionTime s b k ∂(detectionLaw m hm).toMeasure := by
  rw [lintegral_countable']
  unfold expectedDetectionTime
  apply tsum_congr
  intro k
  rw [(detectionLaw m hm).toMeasure_apply_singleton k (measurableSet_singleton k),
    detection_law_apply, mul_comm]

/-- Tonelli derives the nonnegative tail-sum formula for every infinite word,
including those with infinite expected detection time. -/
theorem expected_detection_time_eq_survival_cost (m : ℝ) (hm : 1 < m)
    (s : ℕ → Bool) (b : Bool) :
    expectedDetectionTime m s b = survivalCost m s b := by
  unfold expectedDetectionTime detectionTime
  simp_rw [← ENNReal.tsum_mul_left, mul_ite, mul_one, mul_zero]
  rw [ENNReal.tsum_comm]
  unfold survivalCost survival
  apply tsum_congr
  intro n
  exact detection_mass_tail m hm (visits s b n)

noncomputable def worstExpectedTime (m : ℝ) (s : ℕ → Bool) : ℝ≥0∞ :=
  max (expectedDetectionTime m s true) (expectedDetectionTime m s false)

lemma worst_expected_time_eq_survival_cost (m : ℝ) (hm : 1 < m) (s : ℕ → Bool) :
    worstExpectedTime m s = worstSurvivalCost m s := by
  simp only [worstExpectedTime, worstSurvivalCost, expected_detection_time_eq_survival_cost m hm]

/-- The candidate's two conditional expected detection times, in the actual
probability model, both equal the manuscript's explicit value. -/
theorem candidate_expected_detection_time (m : ℕ) (hm : 3 ≤ m) (b : Bool) :
    expectedDetectionTime m (candidate m) b = ENNReal.ofReal (candidateValue m) := by
  rw [expected_detection_time_eq_survival_cost m
    (by exact_mod_cast (show 1 < m by omega))]
  exact candidate_survival_cost_eq m hm b

/-- Theorem 1, global minimax bound: arbitrary infinite deterministic search
words, with infinite expected times included, cannot improve the candidate. -/
theorem pure_search_global_optimality (m : ℕ) (hm : 3 ≤ m) (s : ℕ → Bool) :
    ENNReal.ofReal (candidateValue m) ≤ worstExpectedTime m s := by
  rw [worst_expected_time_eq_survival_cost m
    (by exact_mod_cast (show 1 < m by omega))]
  exact pure_search_survival_optimality m hm s

/-- Theorem 1, uniqueness: the two words related by exchanging the box labels
are precisely the minimizers in the geometric-detection probability model. -/
theorem pure_search_global_minimizers (m : ℕ) (hm : 3 ≤ m) (s : ℕ → Bool) :
    worstExpectedTime m s = ENNReal.ofReal (candidateValue m) ↔
      s = candidate m ∨ s = complementSchedule (candidate m) := by
  rw [worst_expected_time_eq_survival_cost m
    (by exact_mod_cast (show 1 < m by omega))]
  exact pure_search_survival_minimizers m hm s

/-- Complete main theorem with the manuscript's explicit value. Its only
mathematical premise is the stated integer parameter range `3 ≤ m`. -/
theorem pure_search_main_theorem (m : ℕ) (hm : 3 ≤ m) :
    let V := ENNReal.ofReal (2 + 1 / ((m : ℝ) - 1) +
      ((m : ℝ) - 1) / ((m : ℝ) * ((m : ℝ) ^ (m - 1) - 1)))
    (∀ b, expectedDetectionTime m (candidate m) b = V) ∧
    (∀ s, V ≤ worstExpectedTime m s) ∧
    (∀ s, worstExpectedTime m s = V ↔
      s = candidate m ∨ s = complementSchedule (candidate m)) := by
  dsimp
  rw [← candidate_value_formula m hm]
  exact ⟨candidate_expected_detection_time m hm,
    pure_search_global_optimality m hm, pure_search_global_minimizers m hm⟩

end PureSearch

#print axioms PureSearch.detection_law_apply
#print axioms PureSearch.detection_mass_normalized
#print axioms PureSearch.detection_mass_shift
#print axioms PureSearch.detection_mass_tail
#print axioms PureSearch.detection_law_memoryless
#print axioms PureSearch.scheduled_survival_probability
#print axioms PureSearch.visits_monotone
#print axioms PureSearch.detection_time_at_first_success
#print axioms PureSearch.detection_time_infinite
#print axioms PureSearch.expected_detection_time_integral
#print axioms PureSearch.expected_detection_time_eq_survival_cost
#print axioms PureSearch.worst_expected_time_eq_survival_cost
#print axioms PureSearch.candidate_expected_detection_time
#print axioms PureSearch.pure_search_global_optimality
#print axioms PureSearch.pure_search_global_minimizers
#print axioms PureSearch.pure_search_main_theorem
