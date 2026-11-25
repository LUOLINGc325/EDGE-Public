import FiniteNonarithmeticLLT
import FiniteLatticeLLT
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics

/-! Uniform central estimates on every logarithmically displaced window. -/

open scoped Topology
open Set Filter

namespace RenyiProductOrderPhase

noncomputable def gaussianHeight (v : ℝ) : ℝ :=
  Real.sqrt (Real.pi / (2 * Real.pi ^ 2 * v))

theorem gaussian_height_pos {v : ℝ} (hv : 0 < v) : 0 < gaussianHeight v :=
  Real.sqrt_pos.2 (div_pos Real.pi_pos
    (mul_pos (mul_pos (by norm_num) (pow_pos Real.pi_pos 2)) hv))

theorem log_window_sqrt_ratio_tendsto (D E : ℝ) :
    Tendsto (fun n : ℕ => (D * Real.log ((n + 1 : ℕ) : ℝ) + E) /
      Real.sqrt ((n + 1 : ℕ) : ℝ)) atTop (𝓝 0) := by
  have hSucc : Tendsto (fun n : ℕ => n + 1) atTop atTop := tendsto_atTop.2 fun m =>
    (eventually_ge_atTop m).mono (fun n hn => hn.trans (Nat.le_succ n))
  have hNat : Tendsto (fun n : ℕ => ((n + 1 : ℕ) : ℝ)) atTop atTop :=
    tendsto_natCast_atTop_atTop.comp hSucc
  have hR : Tendsto (fun t : ℝ => Real.log t / Real.sqrt t) atTop (𝓝 0) := by
    simpa only [Real.sqrt_eq_rpow] using
      (isLittleO_log_rpow_atTop (show (0 : ℝ) < 1 / 2 by norm_num)).tendsto_div_nhds_zero
  have hA := hR.comp hNat
  have hB := (div_nat_sqrt_tendsto_zero E).comp hSucc
  have hD : Tendsto (fun _ : ℕ => D) atTop (𝓝 D) := tendsto_const_nhds
  simpa only [Function.comp_apply, add_div, mul_div_assoc, mul_zero, zero_add] using
    (hD.mul hA).add hB

theorem gaussian_profile_log_window (v D E : ℝ) {ε : ℝ} (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ x : ℝ, |x| ≤ D * Real.log ((n + 1 : ℕ) : ℝ) + E →
      |gaussianProfile v (n + 1) x - gaussianHeight v| < ε := by
  let f (u : ℝ) := gaussianHeight v *
    Real.exp (-(2 * Real.pi * u) ^ 2 / (4 * (2 * Real.pi ^ 2 * v)))
  have hf : Continuous f := by unfold f; fun_prop
  have hf₀ : f 0 = gaussianHeight v := by simp [f]
  obtain ⟨δ, hδ, hMod⟩ := (Metric.continuousAt_iff.1 (hf.continuousAt : ContinuousAt f 0)) ε hε
  obtain ⟨N, hN⟩ := eventually_atTop.1
    ((log_window_sqrt_ratio_tendsto D E).eventually (Iio_mem_nhds hδ))
  refine ⟨N, ?_⟩
  intro n hn x hx
  let R := Real.sqrt ((n + 1 : ℕ) : ℝ)
  have hR : 0 < R := Real.sqrt_pos.2 (by exact_mod_cast Nat.succ_pos n)
  have hdist : dist (x / R) 0 < δ := by
    rw [Real.dist_eq, sub_zero, abs_div, abs_of_pos hR]
    exact (div_le_div_of_nonneg_right hx hR.le).trans_lt (hN n hn)
  have h := hMod hdist
  have hEq : f (x / R) = gaussianProfile v (n + 1) x := by
    unfold f gaussianHeight gaussianProfile
    rw [show 2 * Real.pi * (x / R) = 2 * Real.pi * x / R by ring]
  rwa [Real.dist_eq, hEq, hf₀] at h

variable {κ : Type*} [Fintype κ]

theorem finite_nonarithmetic_central_window (p : FiniteMass κ) (hp : ∀ i, 0 < p i)
    (Y : κ → ℝ) (hNon : ¬ ArithmeticSupport Y) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) {w : ℝ} (hw : 0 < w) (D E : ℝ) :
    ∃ c > 0, ∃ N : ℕ, ∀ n ≥ N, ∀ x : ℝ, |x| ≤ D * Real.log ((n + 1 : ℕ) : ℝ) + E →
      c ≤ Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent p Y (n + 1) (Ico x (x + w)) := by
  let G := gaussianHeight (p.expect (fun i => Y i ^ 2))
  have hG : 0 < G := gaussian_height_pos hv
  obtain ⟨N₁, h₁⟩ := finite_nonarithmetic_interval_local_limit p hp Y hNon hm hv hw
    (div_pos (mul_pos hw hG) (by norm_num : (0 : ℝ) < 4))
  obtain ⟨N₂, h₂⟩ := gaussian_profile_log_window (p.expect (fun i => Y i ^ 2)) D E
    (div_pos hG (by norm_num : (0 : ℝ) < 4))
  refine ⟨w * G / 2, div_pos (mul_pos hw hG) (by norm_num), max N₁ N₂, ?_⟩
  intro n hn x hx
  have hA := (abs_lt.mp (h₁ n ((le_max_left _ _).trans hn) x)).1
  have hB := (abs_lt.mp (h₂ n ((le_max_right _ _).trans hn) x hx)).1
  change -(G / 4) < gaussianProfile (p.expect (fun i => Y i ^ 2)) (n + 1) x - G at hB
  have hC := mul_lt_mul_of_pos_left hB hw
  linarith only [hA, hC]

theorem finite_lattice_central_atom {Y : κ → ℝ} (L : MaximalLattice Y)
    (p : FiniteMass κ) (hp : ∀ i, 0 < p i) (hm : p.expect Y = 0)
    (hv : 0 < p.expect (fun i => Y i ^ 2)) (D E : ℝ) :
    ∃ c > 0, ∃ N : ℕ, ∀ n ≥ N, ∀ x : ℝ,
      (∃ z : ℤ, x = ((n + 1 : ℕ) : ℝ) * L.offset + L.span * (z : ℝ)) →
      |x| ≤ D * Real.log ((n + 1 : ℕ) : ℝ) + E →
      c ≤ Real.sqrt ((n + 1 : ℕ) : ℝ) * finiteSumEvent p Y (n + 1) {x} := by
  let G := gaussianHeight (p.expect (fun i => Y i ^ 2))
  have hG : 0 < G := gaussian_height_pos hv
  obtain ⟨N₁, h₁⟩ := finite_lattice_local_limit L p hp hm hv
    (div_pos (mul_pos L.span_pos hG) (by norm_num : (0 : ℝ) < 4))
  obtain ⟨N₂, h₂⟩ := gaussian_profile_log_window (p.expect (fun i => Y i ^ 2)) D E
    (div_pos hG (by norm_num : (0 : ℝ) < 4))
  refine ⟨L.span * G / 2, div_pos (mul_pos L.span_pos hG) (by norm_num), max N₁ N₂, ?_⟩
  intro n hn x hx hx'
  have hA := (abs_lt.mp (h₁ n ((le_max_left _ _).trans hn) x hx)).1
  have hB := (abs_lt.mp (h₂ n ((le_max_right _ _).trans hn) x hx')).1
  change -(G / 4) < gaussianProfile (p.expect (fun i => Y i ^ 2)) (n + 1) x - G at hB
  have hC := mul_lt_mul_of_pos_left hB L.span_pos
  linarith only [hA, hC]

end RenyiProductOrderPhase
