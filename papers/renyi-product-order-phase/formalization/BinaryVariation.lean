import BinaryExtremum
import Mathlib.Analysis.Calculus.LocalExtr.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Deriv

/-! The first-order identity at an interior normalized binary density. -/

open scoped BigOperators Topology
open Filter Set

namespace RenyiProductOrderPhase

namespace FiniteMass

variable {ι : Type*} [Fintype ι]

theorem expect_linear (p : FiniteMass ι) (f g : ι → ℝ) (s t : ℝ) :
    p.expect (fun i => s * f i + t * g i) = s * p.expect f + t * p.expect g := by
  unfold expect
  simp only [mul_add, Finset.sum_add_distrib, Finset.mul_sum]
  congr 1 <;> refine Finset.sum_congr rfl (fun i _ => ?_) <;> ring

theorem hasDerivAt_expect_affine_power (p : FiniteMass ι) (f v : ι → ℝ)
    {a : ℝ} (ha : 1 ≤ a) :
    HasDerivAt (fun e => p.expect (fun i => (f i + e * v i) ^ a))
      (a * p.expect (fun i => v i * f i ^ (a - 1))) 0 := by
  have hD (i : ι) : HasDerivAt (fun e : ℝ => f i + e * v i) (v i) 0 := by
    simpa using (((hasDerivAt_id (0 : ℝ)).mul_const (v i)).const_add (f i))
  have hp (i : ι) :
      HasDerivAt (fun e => p i * (f i + e * v i) ^ a)
        (p i * (v i * a * f i ^ (a - 1))) 0 := by
    simpa only [zero_mul, add_zero] using
      (((hD i).rpow_const (p := a) (Or.inr ha)).const_mul (p i))
  have h := HasDerivAt.sum (u := Finset.univ) (fun i _ => hp i)
  convert h using 1
  unfold expect
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  ring

theorem expect_direction_power (p : FiniteMass ι) (f u : ι → ℝ) (hf : ∀ i, 0 < f i)
    (C a : ℝ) :
    p.expect (fun i => (u i - C * f i) * f i ^ (a - 1)) =
      p.expect (fun i => u i * f i ^ (a - 1)) - C * inputPower p f a := by
  have he (i : ι) : f i * f i ^ (a - 1) = f i ^ a := by
    calc
      _ = f i ^ (1 : ℝ) * f i ^ (a - 1) := by rw [Real.rpow_one]
      _ = _ := by rw [← Real.rpow_add (hf i), show 1 + (a - 1) = a by ring]
  calc
    _ = p.expect (fun i => 1 * (u i * f i ^ (a - 1)) + (-C) * f i ^ a) := by
      congr 1
      funext i
      rw [← he i]
      ring
    _ = _ := by rw [expect_linear]; simp [inputPower, sub_eq_add_neg]

end FiniteMass

variable {κ : Type*} [Fintype κ]

theorem binary_stationarity (q : FiniteMass Bool) (hq : ∀ i, 0 < q i)
    (w : Bool → FiniteMass κ) (hw : ∀ i y, 0 < w i y) (c a : ℝ) (ha : 1 ≤ a)
    (f : Bool → ℝ) (hf : ∀ i, 0 < f i) (hm : q.expect f = 1)
    (hmax : ∀ g : Bool → ℝ, (∀ i, 0 ≤ g i) → q.expect g = 1 →
      logPowerGap q w hw c a g ≤ logPowerGap q w hw c a f)
    (u : Bool → ℝ) :
    (q.push w).expect (fun y => q.conditionalMean w hw u y *
        (q.conditionalMean w hw f y) ^ (a - 1)) / outputPower q w hw f a =
      (1 - c) * q.expect u + c * (q.expect (fun i => u i * f i ^ (a - 1)) /
        inputPower q f a) := by
  let C := q.expect u
  let v (i : Bool) := u i - C * f i
  let path (e : ℝ) (i : Bool) := f i + e * v i
  let T := q.conditionalMean w hw
  let ρ := q.push w
  have hp₀ : path 0 = f := by funext i; simp [path]
  have hv : q.expect v = 0 := by
    have h := q.expect_linear u f 1 (-C)
    simp only [one_mul, neg_mul, hm, add_neg_cancel, mul_one] at h
    simpa [v, C, sub_eq_add_neg] using h
  have hpMean (e : ℝ) : q.expect (path e) = 1 := by
    simpa [path, hm, hv] using q.expect_linear f v 1 e
  have hpNonneg : ∀ᶠ e in 𝓝 (0 : ℝ), ∀ i, 0 ≤ path e i := by
    have h (i : Bool) : ∀ᶠ e in 𝓝 (0 : ℝ), 0 < path e i := by
      have hc : ContinuousAt (fun e : ℝ => path e i) 0 := by
        unfold path
        fun_prop
      have hpos : 0 < path 0 i := by rw [hp₀]; exact hf i
      exact hc.tendsto.eventually (Ioi_mem_nhds hpos)
    filter_upwards [h false, h true] with e h₀ h₁ i
    cases i
    · exact h₀.le
    · exact h₁.le
  have hLocal : IsLocalMax (fun e => logPowerGap q w hw c a (path e)) 0 := by
    refine hpNonneg.mono fun e he => ?_
    change logPowerGap q w hw c a (path e) ≤ logPowerGap q w hw c a (path 0)
    rw [hp₀]
    exact hmax (path e) he (hpMean e)
  have hPath (e : ℝ) : T (path e) = fun y => T f y + e * T v y := by
    funext y
    change (q.posterior w hw y).expect (path e) =
      (q.posterior w hw y).expect f + e * (q.posterior w hw y).expect v
    simpa [path] using (q.posterior w hw y).expect_linear f v 1 e
  have hA : 0 < inputPower q f a :=
    zero_lt_one.trans_le (input_power_ge_one q f (fun i => (hf i).le) hm ha)
  have hB : 0 < outputPower q w hw f a :=
    zero_lt_one.trans_le (output_power_ge_one q w hw f (fun i => (hf i).le) hm ha)
  have hDIn : HasDerivAt (fun e => inputPower q (path e) a)
      (a * q.expect (fun i => v i * f i ^ (a - 1))) 0 :=
    q.hasDerivAt_expect_affine_power f v ha
  have hDOut : HasDerivAt (fun e => outputPower q w hw (path e) a)
      (a * ρ.expect (fun y => T v y * (T f y) ^ (a - 1))) 0 := by
    have h := ρ.hasDerivAt_expect_affine_power (T f) (T v) ha
    convert h using 1
    funext e
    change ρ.expect (fun y => (T (path e) y) ^ a) = _
    rw [hPath e]
  have hLogIn := hDIn.log (show inputPower q (path 0) a ≠ 0 by rw [hp₀]; exact hA.ne')
  have hLogOut := hDOut.log (show outputPower q w hw (path 0) a ≠ 0 by rw [hp₀]; exact hB.ne')
  have hz := hLocal.hasDerivAt_eq_zero (hLogOut.sub (hLogIn.const_mul c))
  rw [hp₀] at hz
  have hden : 0 < a := zero_lt_one.trans_le ha
  have hzero : a * (ρ.expect (fun y => T v y * (T f y) ^ (a - 1)) /
      outputPower q w hw f a -
      c * ((q.expect (fun i => v i * f i ^ (a - 1))) / inputPower q f a)) = 0 := by
    convert hz using 1
    ring
  have he := sub_eq_zero.mp ((mul_eq_zero.mp hzero).resolve_left hden.ne')
  have hTv (y : κ) : T v y = T u y - C * T f y := by
    change (q.posterior w hw y).expect v = _
    have h := (q.posterior w hw y).expect_linear u f 1 (-C)
    simpa [v, T, FiniteMass.conditionalMean, sub_eq_add_neg] using h
  simp only [hTv] at he
  rw [q.expect_direction_power f u hf C a] at he
  rw [ρ.expect_direction_power (T f) (T u)
    (conditional_mean_pos q hq w hw f (fun i => (hf i).le) hm) C a] at he
  change (ρ.expect (fun y => T u y * (T f y) ^ (a - 1)) - C * outputPower q w hw f a) /
      outputPower q w hw f a =
    c * ((q.expect (fun i => u i * f i ^ (a - 1)) - C * inputPower q f a) /
      inputPower q f a) at he
  have hsub (x d : ℝ) (hd : d ≠ 0) : (x - C * d) / d = x / d - C := by
    rw [sub_div]
    congr 1
    exact (div_eq_iff hd).2 rfl
  rw [hsub _ _ hB.ne', hsub _ _ hA.ne'] at he
  change ρ.expect (fun y => T u y * (T f y) ^ (a - 1)) / outputPower q w hw f a =
    (1 - c) * C + c * (q.expect (fun i => u i * f i ^ (a - 1)) / inputPower q f a)
  linarith only [he]

end RenyiProductOrderPhase
