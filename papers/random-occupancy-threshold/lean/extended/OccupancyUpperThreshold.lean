import OccupancyUpperGap
import OwnerSetUnion

open Filter
open scoped BigOperators Topology

namespace TwoColorNullity.Occupancy

noncomputable def upperWindowEnvelope (n : ℕ) : ℝ :=
  (n : ℝ) ^ (largeSetThreshold n + 1) *
    Real.exp (-(deviationCoefficient ^ 2 / 6 * (Real.log (n : ℝ)) ^ 2))

theorem largeSetThreshold_eventually_le :
    ∀ᶠ n : ℕ in atTop, largeSetThreshold n ≤ n := by
  filter_upwards [eventually_ge_atTop (14 : ℕ),
    binaryLog_over_n_zero.eventually (gt_mem_nhds (show (0 : ℝ) < 1 / 2 by norm_num))] with n hn hl
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have h14 : (14 : ℝ) ≤ n := by exact_mod_cast hn
  have hlog := (div_lt_iff₀ hnR).mp hl
  exact_mod_cast (show (largeSetThreshold n : ℝ) ≤ (n : ℝ) by
    linarith only [h14, hlog, threshold_le_binaryLog_add n (by omega)])

private theorem occupancy_window_union_estimate (n : ℕ) (hn : 4 ≤ n) (hln : 1 ≤ Real.log (n : ℝ))
    (hcount : 2 * (binaryLog n + 6) + 13 ≤ concentrationScale n)
    (htn : largeSetThreshold n ≤ n) :
    finiteProbability (fun bits : BitProfile n (3 * n - 1) => windowUpper n < maximumFeasibleOwners (profileTag bits)) ≤
      upperWindowEnvelope n +
        finiteProbability (fun bits : BitProfile n (3 * n - 1) => largeSetThreshold n ≤ maximumFeasibleOwners (profileTag bits)) := by
  classical
  let t := largeSetThreshold n
  let c := Real.exp (-(deviationCoefficient ^ 2 / 6 * (Real.log (n : ℝ)) ^ 2))
  let ev (owners : Finset (Fin n)) (bits : BitProfile n (3 * n - 1)) : Prop :=
    windowUpper n < owners.card ∧ owners.card < n ∧ FeasibleOwners (profileTag bits) owners
  let first (bits : BitProfile n (3 * n - 1)) : Prop :=
    ∃ owners, owners.card < t ∧ ev owners bits
  let second (bits : BitProfile n (3 * n - 1)) : Prop := t ≤ maximumFeasibleOwners (profileTag bits)
  have hcover (bits : BitProfile n (3 * n - 1)) (hvalid : windowUpper n < maximumFeasibleOwners (profileTag bits)) :
      first bits ∨ second bits := by
    by_cases hlarge : second bits
    · exact Or.inr hlarge
    · apply Or.inl
      obtain ⟨owners, feasible, hcard⟩ := maximumFeasibleOwners_attained (profileTag bits) (by omega)
      have hl : owners.card < t := by dsimp [second] at hlarge; omega
      exact ⟨owners, hl, by omega, feasible.2.1, feasible⟩
  have hfirst : finiteProbability first ≤ upperWindowEnvelope n :=
    bounded_owner_group_union n t (by omega) htn c (Real.exp_pos _).le ev (by
      intro owners hnear
      by_cases hsz : windowUpper n < owners.card ∧ owners.card < n
      · refine (finiteProbability_mono (fun bits h => h.2.2)).trans ?_
        exact far_owner_feasibility_tail n owners hn hln hcount hsz.2 hnear hsz.1
      · have he : ev owners = fun _ => False := by
          funext bits
          apply propext
          constructor
          · exact fun h => hsz ⟨h.1, h.2.1⟩
          · exact False.elim
        rw [he]
        have hz : finiteProbability (fun _ : BitProfile n (3 * n - 1) => False) = 0 := by
          unfold finiteProbability
          simp
        rw [hz]
        exact (Real.exp_pos _).le)
  exact (finiteProbability_mono hcover).trans ((finiteProbability_union_two first second).trans
    (add_le_add_right hfirst _))

private theorem upperWindowEnvelope_zero : Tendsto upperWindowEnvelope atTop (𝓝 0) := by
  have hlimit : Tendsto (fun n : ℕ => (n : ℝ)⁻¹) atTop (𝓝 0) :=
    tendsto_inv_atTop_zero.comp tendsto_natCast_atTop_atTop
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold upperWindowEnvelope; positivity) ?_ hlimit
  filter_upwards [eventually_ge_atTop (1 : ℕ), count_correction_eventually_below_scale] with n hn hln
  let l := Real.log (n : ℝ)
  let t := largeSetThreshold n
  have hp : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hlog : 1 ≤ l := hln.1
  have hl0 : 0 ≤ l := by linarith
  have hlogs : l ≤ l ^ 2 := by
    simpa only [one_mul, ← pow_two] using mul_le_mul_of_nonneg_right hlog hl0
  have hsize : ((t + 1 : ℕ) : ℝ) ≤ binaryLog n + 8 := by
    push_cast
    linarith only [threshold_le_binaryLog_add n (by omega)]
  have hsize' := mul_le_mul_of_nonneg_right hsize hl0
  have hcoef : 1 / Real.log 2 + 9 ≤ deviationCoefficient ^ 2 / 6 := by
    unfold deviationCoefficient
    have hp₀ : 0 ≤ 1 / Real.log 2 := by positivity
    nlinarith only [hp₀, sq_nonneg (1 / Real.log 2)]
  have he : ((t + 1 : ℕ) : ℝ) * l - deviationCoefficient ^ 2 / 6 * l ^ 2 ≤ -l := by
    have hmul := mul_le_mul_of_nonneg_right hcoef (sq_nonneg l)
    change ((t + 1 : ℕ) : ℝ) * l ≤ (l / Real.log 2 + 8) * l at hsize'
    have heq : (l / Real.log 2 + 8) * l = (1 / Real.log 2) * l ^ 2 + 8 * l := by ring
    rw [heq] at hsize'
    nlinarith only [hsize', hlogs, hmul]
  have hrewrite : upperWindowEnvelope n =
      Real.exp (((t + 1 : ℕ) : ℝ) * l - deviationCoefficient ^ 2 / 6 * l ^ 2) := by
    unfold upperWindowEnvelope
    rw [Real.exp_sub, Real.exp_nat_mul, show Real.exp l = (n : ℝ) by exact Real.exp_log hp,
      Real.exp_neg]
    exact (div_eq_mul_inv ((n : ℝ) ^ (t + 1)) (Real.exp (deviationCoefficient ^ 2 / 6 * l ^ 2))).symm
  rw [hrewrite]
  calc
    _ ≤ Real.exp (-l) := Real.exp_le_exp.mpr he
    _ = _ := by unfold l; rw [Real.exp_neg, Real.exp_log hp]

theorem upper_window_fails_probability_zero :
    Tendsto (fun n : ℕ => finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      windowUpper n < maximumFeasibleOwners (profileTag bits))) atTop (𝓝 0) := by
  have h := upperWindowEnvelope_zero.add bad_owner_sets_probability_vanishes
  rw [zero_add] at h
  apply squeeze_zero' (Eventually.of_forall fun _ => by unfold finiteProbability; positivity) ?_ h
  filter_upwards [eventually_ge_atTop (4 : ℕ), count_correction_eventually_below_scale,
    largeSetThreshold_eventually_le] with n hn hln htn
  exact occupancy_window_union_estimate n hn hln.1 hln.2 htn

end TwoColorNullity.Occupancy
