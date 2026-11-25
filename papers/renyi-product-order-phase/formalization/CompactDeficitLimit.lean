import DeficitScaling

/-! Transferring compact-uniform tilted moment limits to the exact contraction objective. -/

open scoped Topology
open Filter Set

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

theorem compact_uniform_deficit_from_local_moment (p q : FiniteMass κ) (hq : ∀ i, 0 < q i)
    {I l u : ℝ} (hI : 0 < I) (hl : 0 < l)
    (B : ℕ → ℝ) (hb : ∀ n, 0 < B n) (G : ℕ → ℝ → ℝ) {C : ℝ} (hC : 0 ≤ C)
    (hGBound : ∀ᶠ n in atTop, ∀ a ∈ Icc l u, G n a ≤ C)
    (hMoment : ∀ ε > 0, ∀ᶠ n in atTop, ∀ a ∈ Icc l u,
      |blockScale I (n + 1) * productMissing p q (n + 1) (B n) a - G n a| < ε)
    {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop, ∀ a ∈ Icc l u,
      |B n * blockScale I (n + 1) * productScalarDeficit p q (n + 1) (B n) a -
        G n a / Real.log (1 + a)| < ε := by
  let S (n : ℕ) := blockScale I (n + 1)
  let U (n : ℕ) (a : Icc l u) := productMissing p q (n + 1) (B n) (a : ℝ)
  let V (n : ℕ) (a : Icc l u) := G n (a : ℝ)
  let d (a : Icc l u) := Real.log (1 + (a : ℝ))
  have hd₀ : 0 < Real.log (1 + l) := Real.log_pos (by linarith)
  have hd (a : Icc l u) : Real.log (1 + l) ≤ d a :=
    Real.log_le_log (by linarith) (add_le_add_left a.property.1 _)
  have hU : ∀ᶠ n in atTop, ∀ a, 0 ≤ U n a ∧ U n a < 1 := by
    refine Filter.Eventually.of_forall fun n a => ?_
    exact product_missing_probability_bounds p q hq (n + 1) (hb n) (hl.trans_le a.property.1)
  have hG : ∀ᶠ n in atTop, ∀ a, V n a ≤ C :=
    hGBound.mono (fun _ hn a => hn a a.property)
  have hUV (η : ℝ) (hη : 0 < η) : ∀ᶠ n in atTop, ∀ a, |S n * U n a - V n a| < η :=
    (hMoment η hη).mono (fun _ hn a => hn a a.property)
  have hLog (η : ℝ) (hη : 0 < η) := uniform_scaled_log_follows S U V
    (block_scale_tendsto_atTop hI) hC hU hG hUV hη
  have h := uniform_divide_by_positive_family
    (fun n a => S n * (-Real.log (1 - U n a))) V d hd₀ hd hLog hε
  filter_upwards [h] with n hn
  intro a ha
  have h0 := hn ⟨a, ha⟩
  have hA : 0 < Real.log (1 + a) := hd₀.trans_le (hd ⟨a, ha⟩)
  have hEq : B n * blockScale I (n + 1) * productScalarDeficit p q (n + 1) (B n) a =
      blockScale I (n + 1) * (-Real.log (productScalarMoment p q (n + 1) (B n) a)) /
        Real.log (1 + a) := by
    unfold productScalarDeficit
    field_simp [(hb n).ne', hA.ne']
    ring
  rw [hEq]
  simpa only [S, U, V, d, productMissing, sub_sub_cancel] using h0

end RenyiProductOrderPhase
