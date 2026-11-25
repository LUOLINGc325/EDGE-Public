import LargePriorExclusion
import KernelEnvelope

/-! Compact prior confinement for the exact sub-KL product contraction objectives. -/

open scoped BigOperators Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

noncomputable def scaledBlockObjective (p q : FiniteMass κ) (I : ℝ)
    (B : ℕ → ℝ) (n : ℕ) (a : ℝ) : ℝ :=
  B n * blockScale I (n + 1) * productScalarDeficit p q (n + 1) (B n) a

theorem exists_log_likelihood_lower_bound (p q : FiniteMass κ) :
    ∃ M ≥ 0, ∀ i, -M ≤ logLikelihood p q i := by
  let M := ∑ i, |logLikelihood p q i|
  have hM : 0 ≤ M := Finset.sum_nonneg (fun i _ => abs_nonneg (logLikelihood p q i))
  refine ⟨M, hM, ?_⟩
  intro i
  have h := Finset.single_le_sum (f := fun j : κ => |logLikelihood p q j|)
    (fun j _ => abs_nonneg (logLikelihood p q j)) (Finset.mem_univ i)
  exact (neg_le_neg h).trans (neg_abs_le _)

theorem scaled_product_priors_confined (p q R : FiniteMass κ)
    (hp : ∀ i, 0 < p i) (hq : ∀ i, 0 < q i) (Y : κ → ℝ)
    {I θ w C : ℝ} (hI : 0 < I) (hθ : 0 < θ) (hθ' : θ < 1) (hw : 0 < w) (hC : 0 ≤ C)
    (B : ℕ → ℝ) (hb : ∀ n, 1 ≤ B n) (g : ℕ → ℝ → ℝ)
    (hg : ∀ n z, 0 ≤ z → min z 1 / 2 ≤ g n z)
    (hMoment : ∀ n a, blockScale I (n + 1) * productMissing p q (n + 1) (B n) a =
      Real.sqrt ((n + 1 : ℕ) : ℝ) * (FiniteMass.tensor (fun _ : Fin (n + 1) => R)).expect
        (fun x => Real.exp (-(θ * iidSum Y x)) * g n (a * Real.exp (iidSum Y x))))
    (hWindow : ∀ D E : ℝ, ∃ P > 0, ∀ᶠ n : ℕ in atTop, ∀ x : ℝ,
      |x| ≤ D * Real.log ((n + 1 : ℕ) : ℝ) + E →
      P ≤ Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent R Y (n + 1) (Ico x (x + w))) :
    ∃ l > 0, ∃ u > 0, ∀ᶠ n : ℕ in atTop, ∀ a, 0 < a →
      scaledBlockObjective p q I B n a ≤ C → a ∈ Icc l u := by
  let V := scaledBlockObjective p q I B
  have hLower (n : ℕ) (a : ℝ) (ha : 0 < a) :
      Real.sqrt ((n + 1 : ℕ) : ℝ) * (FiniteMass.tensor (fun _ : Fin (n + 1) => R)).expect
        (fun x => Real.exp (-(θ * iidSum Y x)) * g n (a * Real.exp (iidSum Y x)) / Real.log (1 + a)) ≤ V n a := by
    let P := FiniteMass.tensor (fun _ : Fin (n + 1) => R)
    let f (x : Fin (n + 1) → κ) := Real.exp (-(θ * iidSum Y x)) * g n (a * Real.exp (iidSum Y x))
    let S := blockScale I (n + 1)
    let L := Real.log (1 + a)
    have hL : 0 < L := Real.log_pos (by linarith)
    have hB : 0 < B n := zero_lt_one.trans_le (hb n)
    have hS : 0 ≤ S := mul_nonneg (Real.sqrt_nonneg _) (Real.exp_nonneg _)
    have hE : P.expect (fun x => f x / L) = P.expect f / L := by
      simp only [div_eq_mul_inv, mul_comm _ L⁻¹]
      exact P.expect_scale_function f L⁻¹
    change Real.sqrt ((n + 1 : ℕ) : ℝ) * P.expect (fun x => f x / L) ≤ _
    rw [hE, ← mul_div_assoc]
    have hM : S * productMissing p q (n + 1) (B n) a =
        Real.sqrt ((n + 1 : ℕ) : ℝ) * P.expect f := hMoment n a
    rw [← hM]
    unfold V scaledBlockObjective
    have hMul : S * productMissing p q (n + 1) (B n) a / L =
        (B n * S) * (productMissing p q (n + 1) (B n) a / (B n * L)) := by
      field_simp [hB.ne', hL.ne']
      ring
    rw [hMul]
    exact mul_le_mul_of_nonneg_left (product_deficit_by_missing p q (n + 1) hB ha).1
      (mul_nonneg hB.le hS)
  obtain ⟨M, hM, hY⟩ := exists_log_likelihood_lower_bound p q
  have hExtreme : ∀ᶠ n : ℕ in atTop, ∀ a, 0 < a →
      2 * ((n + 1 : ℕ) : ℝ) * M + 1 ≤ Real.log a → C < V n a := by
    have hS := (block_scale_tendsto_atTop hI).eventually (eventually_ge_atTop (4 * (C + 1)))
    filter_upwards [hS] with n hn
    intro a ha ht
    have hQ := product_deficit_large_prior_uniform p q hp hq (n + 1) hM hY
      (zero_lt_one.trans_le (hb n)) ha ht
    let S := blockScale I (n + 1)
    have hS₀ : 0 ≤ S := mul_nonneg (Real.sqrt_nonneg _) (Real.exp_nonneg _)
    have hSB : S ≤ B n * S := le_mul_of_one_le_left hS₀ (hb n)
    have hLarge : C + 1 ≤ S * (1 / 4) := by
      have hh : 4 * (C + 1) ≤ S := hn
      linarith only [hh]
    have hF₀ : 0 ≤ productScalarDeficit p q (n + 1) (B n) a :=
      (by norm_num : (0 : ℝ) ≤ 1 / 4).trans hQ
    calc
      _ < C + 1 := lt_add_of_pos_right _ zero_lt_one
      _ ≤ S * (1 / 4) := hLarge
      _ ≤ S * productScalarDeficit p q (n + 1) (B n) a := mul_le_mul_of_nonneg_left hQ hS₀
      _ ≤ V n a := mul_le_mul_of_nonneg_right hSB hF₀
  have hSmall : ∃ P > 0, ∀ᶠ n : ℕ in atTop, ∀ x : ℝ,
      |x| ≤ Real.log ((n + 1 : ℕ) : ℝ) + w →
      P ≤ Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent R Y (n + 1) (Ico x (x + w)) := by
    simpa only [one_mul] using hWindow 1 w
  have hLarge : ∃ P > 0, ∀ᶠ n : ℕ in atTop, ∀ x : ℝ,
      |x| ≤ (2 / θ) * Real.log ((n + 1 : ℕ) : ℝ) →
      P ≤ Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent R Y (n + 1) (Ico x (x + w)) := by
    simpa only [add_zero] using hWindow (2 / θ) 0
  obtain ⟨l, hl, hL⟩ := eventually_exclude_small_priors R Y V g hθ' hw hC hg hLower hSmall
  obtain ⟨u, hu, hU⟩ := eventually_exclude_large_priors R Y V g hθ hM hg hLower hLarge hExtreme
  refine ⟨l, hl, u, hu, ?_⟩
  filter_upwards [hL, hU] with n hn hn'
  intro a ha hVa
  exact ⟨le_of_not_ge (fun h => (not_lt_of_ge hVa) (hn a ha h)),
    le_of_not_ge (fun h => (not_lt_of_ge hVa) (hn' a h))⟩

end RenyiProductOrderPhase
