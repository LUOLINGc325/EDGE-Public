import GeometricSearchModel
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.MeasureTheory.Measure.Prod

/-!
# The mixed benchmark for equal-time two-box search

A randomized strategy is a probability law on infinite search words. The
payoff against either box integrates the same extended expected detection
time used in the pure theorem.
-/

set_option autoImplicit false

open MeasureTheory
open scoped ENNReal

namespace PureSearch

def alternating (n : ℕ) : Bool := n % 2 == 0

lemma visits_partition (s : ℕ → Bool) (n : ℕ) :
    visits s true n + visits s false n = n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [visits, visits]
    cases hs : s n <;> simp only [hs, Bool.false_eq_true, Bool.true_eq_false, ↓reduceIte] <;>
      omega

lemma alternating_visits (n : ℕ) :
    visits alternating true n = n / 2 + n % 2 ∧ visits alternating false n = n / 2 := by
  induction n with
  | zero => decide
  | succ n ih =>
    rw [visits, visits, ih.1, ih.2]
    rcases (show n % 2 = 0 ∨ n % 2 = 1 by omega) with h | h <;>
      simp [alternating, h] <;> omega

lemma powers_balanced {r : ℝ} (hr : 0 ≤ r) (hr1 : r ≤ 1)
    {a b c d : ℕ} (hac : a ≤ c) (had : a ≤ d) (h : a + b = c + d) :
    r ^ c + r ^ d ≤ r ^ a + r ^ b := by
  let k := c - a
  have hc : c = a + k := by dsimp [k]; omega
  have hb : b = d + k := by dsimp [k]; omega
  have hpow := pow_le_pow_of_le_one hr hr1 had
  have hk := pow_le_one₀ hr hr1 (n := k)
  rw [hc, hb, pow_add, pow_add]
  nlinarith [mul_nonneg (sub_nonneg.mpr hk) (sub_nonneg.mpr hpow)]

theorem alternating_balances_survival (m : ℝ) (hm : 1 < m) (s : ℕ → Bool) (n : ℕ) :
    survival m alternating true n + survival m alternating false n ≤
      survival m s true n + survival m s false n := by
  have hm0 : 0 < m := by linarith
  have hr := (one_div_pos.mpr hm0).le
  have hr1 := ((div_lt_one hm0).mpr hm).le
  have hs := visits_partition s n
  have ha := visits_partition alternating n
  have hv := alternating_visits n
  unfold survival
  by_cases ht : visits s true n ≤ n / 2
  · exact powers_balanced hr hr1 (by omega) (by omega) (hs.trans ha.symm)
  · rw [add_comm ((1 / m) ^ visits s true n)]
    exact powers_balanced hr hr1 (by omega) (by omega) (by omega)

lemma alternating_survival_pair (m : ℝ) (b : Bool) (k : ℕ) :
    survival m alternating b (k * 2) + survival m alternating b (k * 2 + 1) =
      (if b then 1 + 1 / m else 2) * (1 / m) ^ k := by
  have he := alternating_visits (k * 2)
  have ho := alternating_visits (k * 2 + 1)
  have heT : visits alternating true (k * 2) = k := by omega
  have heF : visits alternating false (k * 2) = k := by omega
  have hoT : visits alternating true (k * 2 + 1) = k + 1 := by omega
  have hoF : visits alternating false (k * 2 + 1) = k := by omega
  cases b <;> simp only [survival, heT, heF, hoT, hoF, Bool.false_eq_true, ↓reduceIte, pow_succ] <;> ring

theorem alternating_expected_time (m : ℝ) (hm : 1 < m) (b : Bool) :
    expectedDetectionTime m alternating b = ENNReal.ofReal
      ((if b then 1 + 1 / m else 2) * searchMean m) := by
  have hm0 : 0 < m := by linarith
  have hr := one_div_pos.mpr hm0
  have hr1 := (div_lt_one hm0).mpr hm
  have hmean : (1 - 1 / m)⁻¹ = searchMean m := by
    have hn : m - 1 ≠ 0 := by linarith
    unfold searchMean
    field_simp
  have hs := (hasSum_geometric_of_lt_one hr.le hr1).mul_left (if b then 1 + 1 / m else 2)
  rw [hmean] at hs
  have hn k : 0 ≤ (if b then 1 + 1 / m else 2) * (1 / m) ^ k := by
    cases b <;> simp <;> positivity
  rw [expected_detection_time_eq_survival_cost m hm, survivalCost]
  calc
    _ = ∑' p : ℕ × Fin 2, ENNReal.ofReal (survival m alternating b (p.1 * 2 + p.2)) :=
      ((Nat.divModEquiv 2).symm.tsum_eq _).symm
    _ = ∑' k, ENNReal.ofReal ((if b then 1 + 1 / m else 2) * (1 / m) ^ k) := by
      rw [ENNReal.tsum_prod']
      apply tsum_congr
      intro k
      rw [tsum_fintype, Fin.sum_univ_two]
      change ENNReal.ofReal (survival m alternating b (k * 2 + 0)) +
        ENNReal.ofReal (survival m alternating b (k * 2 + 1)) = _
      rw [Nat.add_zero, ← ENNReal.ofReal_add (survival_pos m hm0 _ _ _).le
        (survival_pos m hm0 _ _ _).le, alternating_survival_pair]
    _ = _ := by rw [← ENNReal.ofReal_tsum_of_nonneg hn hs.summable, hs.tsum_eq]

noncomputable def mixedValue (m : ℝ) : ℝ := 2 * searchMean m - 1 / 2

theorem mixed_value_formula (m : ℝ) (hm : 1 < m) :
    mixedValue m = 3 / 2 + 2 / (m - 1) := by
  have hn : m - 1 ≠ 0 := by linarith
  unfold mixedValue searchMean
  field_simp
  ring

lemma mixed_value_pos (m : ℝ) (hm : 1 < m) : 0 < mixedValue m := by
  rw [mixed_value_formula m hm]
  have hden : 0 < m - 1 := by linarith
  positivity

lemma alternating_payoffs (m : ℝ) (hm : 1 < m) :
    expectedDetectionTime m alternating true = ENNReal.ofReal (2 * searchMean m - 1) ∧
      expectedDetectionTime m alternating false = ENNReal.ofReal (2 * searchMean m) := by
  rw [alternating_expected_time m hm true, alternating_expected_time m hm false]
  simp only [Bool.false_eq_true, ↓reduceIte, and_true]
  congr 1
  have hm0 : m ≠ 0 := by linarith
  have hn : m - 1 ≠ 0 := by linarith
  unfold searchMean
  field_simp
  ring

lemma alternating_payoff_sum (m : ℝ) (hm : 1 < m) :
    expectedDetectionTime m alternating true + expectedDetectionTime m alternating false =
      ENNReal.ofReal (2 * mixedValue m) := by
  have h := alternating_payoffs m hm
  have hQ := search_mean_pos m hm
  rw [h.1, h.2, ← ENNReal.ofReal_add ?_ (by positivity)]
  · congr 1
    unfold mixedValue
    ring
  · have hn : 0 < m - 1 := by linarith
    unfold searchMean
    have hratio : 1 ≤ m / (m - 1) := (le_div_iff₀ hn).2 (by linarith)
    linarith

/-- The uniform hider payoff bounds every pure word, including infinite costs. -/
theorem uniform_hider_lower_bound (m : ℝ) (hm : 1 < m) (s : ℕ → Bool) :
    ENNReal.ofReal (2 * mixedValue m) ≤
      expectedDetectionTime m s true + expectedDetectionTime m s false := by
  rw [← alternating_payoff_sum m hm]
  simp only [expected_detection_time_eq_survival_cost m hm, survivalCost, ← ENNReal.tsum_add]
  apply ENNReal.tsum_le_tsum
  intro n
  have hm0 : 0 < m := by linarith
  rw [← ENNReal.ofReal_add (survival_pos m hm0 _ _ _).le (survival_pos m hm0 _ _ _).le,
    ← ENNReal.ofReal_add (survival_pos m hm0 _ _ _).le (survival_pos m hm0 _ _ _).le]
  exact ENNReal.ofReal_le_ofReal (alternating_balances_survival m hm s n)

lemma measurable_visits (b : Bool) (n : ℕ) :
    Measurable fun s : ℕ → Bool => visits s b n := by
  induction n with
  | zero => exact measurable_const
  | succ n ih =>
    apply ih.add
    exact (Measurable.of_discrete (f := fun a : Bool => if a = b then 1 else 0)).comp
      (measurable_pi_apply n)

lemma measurable_expected_detection_time (m : ℝ) (hm : 1 < m) (b : Bool) :
    Measurable fun s : ℕ → Bool => expectedDetectionTime m s b := by
  simp only [expected_detection_time_eq_survival_cost m hm, survivalCost, survival]
  exact Measurable.ennreal_tsum fun n => ((Measurable.of_discrete
    (f := fun k : ℕ => ENNReal.ofReal ((1 / m) ^ k))).comp (measurable_visits b n))

noncomputable def mixedPayoff (m : ℝ) (μ : Measure (ℕ → Bool)) (b : Bool) : ℝ≥0∞ :=
  ∫⁻ s, expectedDetectionTime m s b ∂μ

noncomputable def alternatingMixture : Measure (ℕ → Bool) :=
  (1 / 2 : ℝ≥0∞) • Measure.dirac alternating +
    (1 / 2 : ℝ≥0∞) • Measure.dirac (complementSchedule alternating)

instance : IsProbabilityMeasure alternatingMixture where
  measure_univ := by
    simpa [alternatingMixture, Measure.add_apply] using ENNReal.add_halves 1

theorem mixed_search_lower_bound (m : ℝ) (hm : 1 < m)
    (μ : Measure (ℕ → Bool)) [IsProbabilityMeasure μ] :
    ENNReal.ofReal (mixedValue m) ≤ max (mixedPayoff m μ true) (mixedPayoff m μ false) := by
  have hi := lintegral_mono (μ := μ) (uniform_hider_lower_bound m hm)
  rw [lintegral_const, measure_univ, mul_one,
    lintegral_add_left (measurable_expected_detection_time m hm true)] at hi
  change _ ≤ mixedPayoff m μ true + mixedPayoff m μ false at hi
  rw [two_mul, ENNReal.ofReal_add (mixed_value_pos m hm).le (mixed_value_pos m hm).le] at hi
  by_contra! h
  exact (not_lt_of_ge hi)
    (ENNReal.add_lt_add ((le_max_left _ _).trans_lt h) ((le_max_right _ _).trans_lt h))

theorem alternating_mixture_attains (m : ℝ) (hm : 1 < m) (b : Bool) :
    mixedPayoff m alternatingMixture b = ENNReal.ofReal (mixedValue m) := by
  have hswap : expectedDetectionTime m (complementSchedule alternating) b =
      expectedDetectionTime m alternating (!b) := by
    simp only [expected_detection_time_eq_survival_cost m hm, survival_cost_complement]
  unfold mixedPayoff alternatingMixture
  rw [lintegral_add_measure, lintegral_smul_measure, lintegral_smul_measure,
    lintegral_dirac' _ (measurable_expected_detection_time m hm b),
    lintegral_dirac' _ (measurable_expected_detection_time m hm b), hswap]
  simp only [smul_eq_mul, ← mul_add]
  have hsum : expectedDetectionTime m alternating b + expectedDetectionTime m alternating (!b) =
      ENNReal.ofReal (2 * mixedValue m) := by
    cases b <;> simpa only [Bool.not_true, Bool.not_false, add_comm] using alternating_payoff_sum m hm
  rw [hsum]
  have hhalf : (1 / 2 : ℝ≥0∞) = ENNReal.ofReal (1 / 2) := by
    rw [ENNReal.ofReal_div_of_pos (by norm_num : (0 : ℝ) < 2)]
    norm_num
  rw [hhalf, ← ENNReal.ofReal_mul (by norm_num : (0 : ℝ) ≤ 1 / 2)]
  congr 1
  ring

/-- Equation (21) with both an optimality certificate and a strategy that attains it. -/
theorem mixed_search_minimax (m : ℝ) (hm : 1 < m) :
    (∀ (μ : Measure (ℕ → Bool)) [IsProbabilityMeasure μ],
      ENNReal.ofReal (3 / 2 + 2 / (m - 1)) ≤ max (mixedPayoff m μ true) (mixedPayoff m μ false)) ∧
    (∀ b, mixedPayoff m alternatingMixture b = ENNReal.ofReal (3 / 2 + 2 / (m - 1))) := by
  rw [← mixed_value_formula m hm]
  exact ⟨fun μ _ => mixed_search_lower_bound m hm μ, alternating_mixture_attains m hm⟩

section FailureHistoryPolicy

variable {Ω : Type*}

/-- Prior to detection every outcome is a failure, so the observed history is
the list of unsuccessful actions. For a fixed seed, `act` may use that entire list. -/
def failureHistory (act : Ω → List Bool → Bool) (x : Ω) : ℕ → List Bool
  | 0 => []
  | n + 1 => failureHistory act x n ++ [act x (failureHistory act x n)]

def failureWord (act : Ω → List Bool → Bool) (x : Ω) (n : ℕ) : Bool :=
  act x (failureHistory act x n)

lemma failure_history_length (act : Ω → List Bool → Bool) (x : Ω) (n : ℕ) :
    (failureHistory act x n).length = n := by
  induction n with
  | zero => rfl
  | succ n ih => simp [failureHistory, ih]

lemma failure_history_count (act : Ω → List Bool → Bool) (x : Ω) (b : Bool) (n : ℕ) :
    (failureHistory act x n).count b = visits (failureWord act x) b n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [failureHistory, List.count_append, visits, ih]
    cases ha : act x (failureHistory act x n) <;> cases b <;> simp [failureWord, ha]

noncomputable def policyDetectionTime (act : Ω → List Bool → Bool) (x : Ω)
    (b : Bool) (k : ℕ) : ℝ≥0∞ :=
  ∑' n, if (failureHistory act x n).count b ≤ k then (1 : ℝ≥0∞) else 0

theorem policy_detection_time_pathwise (act : Ω → List Bool → Bool) (x : Ω) (b : Bool) (k : ℕ) :
    policyDetectionTime act x b k = detectionTime (failureWord act x) b k := by
  simp only [policyDetectionTime, detectionTime, failure_history_count]

variable [MeasurableSpace Ω]

local instance : MeasurableSpace (List Bool) := ⊤
local instance : DiscreteMeasurableSpace (List Bool) := ⟨fun _ => trivial⟩

lemma measurable_failure_word (act : Ω → List Bool → Bool)
    (ha : ∀ h, Measurable (fun x => act x h)) : Measurable (failureWord act) := by
  have hact : Measurable (fun p : Ω × List Bool => act p.1 p.2) :=
    measurable_from_prod_countable ha
  have hh : ∀ n, Measurable (fun x => failureHistory act x n) := by
    intro n
    induction n with
    | zero => exact measurable_const
    | succ n ih =>
      have hx := hact.comp (measurable_id.prodMk ih)
      exact (Measurable.of_discrete (f := fun p : List Bool × Bool => p.1 ++ [p.2])).comp
        (ih.prodMk hx)
  exact measurable_pi_lambda _ (fun n => hact.comp (measurable_id.prodMk (hh n)))

/-- The private seed and the geometric detection variable have a product law.
Tonelli and pushforward identify the actual policy payoff with its word law. -/
theorem policy_cost_eq_mixed_payoff (m : ℝ) (hm : 1 < m) (ν : Measure Ω)
    (act : Ω → List Bool → Bool) (ha : ∀ h, Measurable (fun x => act x h)) (b : Bool) :
    (∫⁻ z : Ω × ℕ, policyDetectionTime act z.1 b z.2 ∂ν.prod (detectionLaw m hm).toMeasure) =
      mixedPayoff m (Measure.map (failureWord act) ν) b := by
  have hw := measurable_failure_word act ha
  have hd : Measurable (fun z : Ω × ℕ => policyDetectionTime act z.1 b z.2) := by
    simp only [policy_detection_time_pathwise, detectionTime]
    apply Measurable.ennreal_tsum
    intro n
    have hv : Measurable (fun z : Ω × ℕ => visits (failureWord act z.1) b n) :=
      (measurable_visits b n).comp (hw.comp measurable_fst)
    exact measurable_const.ite (measurableSet_le hv measurable_snd) measurable_const
  rw [lintegral_prod _ hd.aemeasurable]
  simp only [policy_detection_time_pathwise, ← expected_detection_time_integral m hm]
  exact (lintegral_map (measurable_expected_detection_time m hm b) hw).symm

theorem adaptive_policy_lower_bound (m : ℝ) (hm : 1 < m) (ν : Measure Ω)
    [IsProbabilityMeasure ν] (act : Ω → List Bool → Bool)
    (ha : ∀ h, Measurable (fun x => act x h)) :
    let payoff (b : Bool) :=
      ∫⁻ z : Ω × ℕ, policyDetectionTime act z.1 b z.2 ∂ν.prod (detectionLaw m hm).toMeasure
    ENNReal.ofReal (mixedValue m) ≤ max (payoff true) (payoff false) := by
  dsimp only
  rw [policy_cost_eq_mixed_payoff m hm ν act ha true, policy_cost_eq_mixed_payoff m hm ν act ha false]
  letI := isProbabilityMeasure_map (measurable_failure_word act ha).aemeasurable (μ := ν)
  exact mixed_search_lower_bound m hm _

/-- Sampling a word and following it implements any prescribed word law. -/
theorem sampled_word_policy (m : ℝ) (hm : 1 < m) (μ : Measure (ℕ → Bool)) (b : Bool) :
    (∫⁻ z : (ℕ → Bool) × ℕ, policyDetectionTime (fun s h => s h.length) z.1 b z.2
      ∂μ.prod (detectionLaw m hm).toMeasure) = mixedPayoff m μ b := by
  rw [policy_cost_eq_mixed_payoff m hm μ (fun s h => s h.length)
    (fun h => measurable_pi_apply h.length)]
  have heq : failureWord (fun (s : ℕ → Bool) h => s h.length) = id := by
    funext s n
    simp only [failureWord, failure_history_length, id]
  rw [heq, Measure.map_id]

theorem alternating_policy_attains (m : ℝ) (hm : 1 < m) (b : Bool) :
    (∫⁻ z : (ℕ → Bool) × ℕ, policyDetectionTime (fun s h => s h.length) z.1 b z.2
      ∂alternatingMixture.prod (detectionLaw m hm).toMeasure) = ENNReal.ofReal (mixedValue m) := by
  rw [sampled_word_policy m hm, alternating_mixture_attains m hm]

end FailureHistoryPolicy

end PureSearch

#print axioms PureSearch.visits_partition
#print axioms PureSearch.alternating_visits
#print axioms PureSearch.powers_balanced
#print axioms PureSearch.alternating_balances_survival
#print axioms PureSearch.alternating_survival_pair
#print axioms PureSearch.alternating_expected_time
#print axioms PureSearch.mixed_value_formula
#print axioms PureSearch.mixed_value_pos
#print axioms PureSearch.alternating_payoffs
#print axioms PureSearch.alternating_payoff_sum
#print axioms PureSearch.uniform_hider_lower_bound
#print axioms PureSearch.measurable_visits
#print axioms PureSearch.measurable_expected_detection_time
#print axioms PureSearch.mixed_search_lower_bound
#print axioms PureSearch.alternating_mixture_attains
#print axioms PureSearch.mixed_search_minimax
#print axioms PureSearch.failure_history_length
#print axioms PureSearch.failure_history_count
#print axioms PureSearch.policy_detection_time_pathwise
#print axioms PureSearch.measurable_failure_word
#print axioms PureSearch.policy_cost_eq_mixed_payoff
#print axioms PureSearch.adaptive_policy_lower_bound
#print axioms PureSearch.sampled_word_policy
#print axioms PureSearch.alternating_policy_attains
