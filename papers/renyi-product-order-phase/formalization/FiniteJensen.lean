import FiniteRenyi
import Mathlib.Analysis.Convex.SpecificFunctions.Pow

/-! Conditional Jensen for a finite mixture and linearity when the input
densities are shared. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

variable {ι κ τ : Type*} [Fintype ι] [Fintype κ] [Fintype τ]

namespace FiniteMass

theorem push_expect (p : FiniteMass ι) (w : ι → FiniteMass κ) (g : κ → ℝ) :
    (p.push w).expect g = p.expect (fun i => (w i).expect g) := by
  unfold expect
  simp only [push_apply, Finset.sum_mul, Finset.mul_sum]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  ring

theorem push_assoc (p : FiniteMass ι) (w : ι → FiniteMass κ) (v : κ → FiniteMass τ) :
    (p.push w).push v = p.push (fun i => (w i).push v) := by
  ext j
  exact push_expect p w (fun k => v k j)

end FiniteMass

theorem renyi_moment_shared_density (b : ℝ) (hb : 0 < b) (p q : FiniteMass ι)
    (f : ι → ℝ) (hf : ∀ i, p i = q i * f i) :
    renyiMoment b p q = q.expect (fun i => f i ^ (b + 1)) := by
  have hac : p.AbsolutelyContinuous q := by
    intro i hi
    rw [hf i, hi, zero_mul]
  rw [renyi_moment_reference b hb p q hac]
  unfold FiniteMass.expect
  refine Finset.sum_congr rfl fun i _ => ?_
  by_cases hqi : q i = 0
  · simp [hqi]
  · have hratio : p i / q i = f i := by
      rw [hf i]
      exact (div_eq_iff hqi).2 (mul_comm _ _)
    change q i * (p i / q i) ^ (b + 1) = q i * f i ^ (b + 1)
    rw [hratio]

theorem mixed_shared_density_moment (b : ℝ) (hb : 0 < b)
    (θ : FiniteMass τ) (p q : τ → FiniteMass ι) (f : ι → ℝ)
    (hf : ∀ j i, p j i = q j i * f i) :
    renyiMoment b (θ.push p) (θ.push q) =
      θ.expect (fun j => renyiMoment b (p j) (q j)) := by
  have hmix (i : ι) : θ.push p i = θ.push q i * f i := by
    rw [FiniteMass.push_apply, FiniteMass.push_apply, Finset.sum_mul]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [hf j i]
    ring
  rw [renyi_moment_shared_density b hb _ _ f hmix, FiniteMass.push_expect]
  unfold FiniteMass.expect
  refine Finset.sum_congr rfl fun j _ => ?_
  change θ j * ((q j).expect (fun i => f i ^ (b + 1))) =
    θ j * renyiMoment b (p j) (q j)
  rw [renyi_moment_shared_density b hb _ _ f (hf j)]

theorem joint_mixture_moment_le (b : ℝ) (hb : 0 < b)
    (θ : FiniteMass τ) (p q : τ → FiniteMass ι) (hq : ∀ j i, 0 < q j i) :
    renyiMoment b (θ.push p) (θ.push q) ≤
      θ.expect (fun j => renyiMoment b (p j) (q j)) := by
  classical
  have hQ (i : ι) : 0 < θ.push q i := by
    obtain ⟨j, hj⟩ := θ.exists_weight_pos
    exact θ.expect_pos (fun k => (hq k i).le) hj (hq j i)
  have hpoint (i : ι) :
      θ.push q i * (θ.push p i / θ.push q i) ^ (b + 1) ≤
        ∑ j, θ j * (q j i * (p j i / q j i) ^ (b + 1)) := by
    let d := θ.push q i
    let w (j : τ) := θ j * q j i / d
    have hd : 0 < d := hQ i
    have hw (j : τ) : 0 ≤ w j :=
      div_nonneg (mul_nonneg (θ.weight_nonneg j) (hq j i).le) hd.le
    have hsum : (∑ j, w j) = 1 := by
      unfold w
      rw [← Finset.sum_div]
      exact div_self hd.ne'
    have hmean : (∑ j, w j * (p j i / q j i)) = θ.push p i / d := by
      rw [FiniteMass.push_apply, Finset.sum_div]
      refine Finset.sum_congr rfl fun j _ => ?_
      calc
        w j * (p j i / q j i) =
            (θ j * p j i / d) * (q j i / q j i) := by
              unfold w
              simp only [div_eq_mul_inv]
              ring
        _ = θ j * p j i / d := by rw [div_self (hq j i).ne', mul_one]
    have hj := (convexOn_rpow (show 1 ≤ b + 1 by linarith)).map_sum_le
      (t := Finset.univ) (w := w) (p := fun j => p j i / q j i)
      (fun j _ => hw j) hsum
      (fun j _ => div_nonneg ((p j).weight_nonneg i) (hq j i).le)
    change (∑ j, w j * (p j i / q j i)) ^ (b + 1) ≤
      ∑ j, w j * (p j i / q j i) ^ (b + 1) at hj
    rw [hmean] at hj
    calc
      d * (θ.push p i / d) ^ (b + 1) ≤
          d * ∑ j, w j * (p j i / q j i) ^ (b + 1) :=
        mul_le_mul_of_nonneg_left hj hd.le
      _ = _ := by
        rw [Finset.mul_sum]
        refine Finset.sum_congr rfl fun j _ => ?_
        unfold w
        rw [← mul_assoc, mul_div_cancel₀ _ hd.ne']
        ring
  rw [renyi_moment_reference b hb _ _
    (FiniteMass.absolutelyContinuous_of_pos _ _ hQ)]
  calc
    (θ.push q).expect (fun i => (θ.push p i / θ.push q i) ^ (b + 1)) ≤
        ∑ i, ∑ j, θ j * (q j i * (p j i / q j i) ^ (b + 1)) :=
      Finset.sum_le_sum (fun i _ => hpoint i)
    _ = θ.expect (fun j => renyiMoment b (p j) (q j)) := by
      rw [Finset.sum_comm]
      unfold FiniteMass.expect
      refine Finset.sum_congr rfl fun j _ => ?_
      change (∑ i, θ j * (q j i * (p j i / q j i) ^ (b + 1))) =
        θ j * renyiMoment b (p j) (q j)
      rw [renyi_moment_reference b hb _ _
        (FiniteMass.absolutelyContinuous_of_pos _ _ (hq j)), FiniteMass.expect,
        Finset.mul_sum]

theorem moment_power_jensen (θ : FiniteMass τ) {r : ℝ}
    (hr₀ : 0 ≤ r) (hr₁ : r ≤ 1) (f : τ → ℝ) (hf : ∀ j, 0 ≤ f j) :
    θ.expect (fun j => f j ^ r) ≤ (θ.expect f) ^ r :=
  (Real.concaveOn_rpow hr₀ hr₁).le_map_sum (t := Finset.univ) (w := fun j => θ j)
    (p := f) (fun j _ => θ.weight_nonneg j) θ.total (fun j _ => hf j)

end RenyiProductOrderPhase
