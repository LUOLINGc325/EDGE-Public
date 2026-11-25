import QubitFoundation

open scoped BigOperators

namespace Lueders

theorem positive_part_identity (t : ℝ) :
    |t| = 2 * (if 0 < t then t else 0) - t := by
  by_cases ht : 0 < t
  · rw [if_pos ht, abs_of_pos ht]
    ring
  · rw [if_neg ht, abs_of_nonpos (le_of_not_gt ht)]
    ring

theorem event_representation {ι : Type*} [Fintype ι] (delta : ι → ℝ)
    (hzero : ∑ i, delta i = 0) :
    ∃ S : Finset ι,
      (∑ i ∈ S, delta i) = (∑ i, |delta i|) / 2 ∧
      ∀ T : Finset ι, (∑ i ∈ T, delta i) ≤ (∑ i, |delta i|) / 2 := by
  classical
  let S := Finset.univ.filter (fun i => 0 < delta i)
  let pos : ι → ℝ := fun i => if 0 < delta i then delta i else 0
  have hp : ∀ i, 0 ≤ pos i := by
    intro i
    by_cases h : 0 < delta i
    · simpa only [pos, if_pos h] using h.le
    · simp only [pos, if_neg h, le_refl]
  have hpoint : ∀ i, delta i ≤ pos i := by
    intro i
    by_cases h : 0 < delta i
    · simp only [pos, if_pos h, le_refl]
    · simpa only [pos, if_neg h] using le_of_not_gt h
  have hS : (∑ i ∈ S, delta i) = ∑ i, pos i := by
    simp [S, pos, Finset.sum_filter]
  have habs : (∑ i, |delta i|) = 2 * (∑ i, pos i) := by
    calc
      _ = ∑ i, (2 * pos i - delta i) := by
        apply Finset.sum_congr rfl
        intro i hi
        exact positive_part_identity (delta i)
      _ = 2 * (∑ i, pos i) := by
        rw [Finset.sum_sub_distrib, ← Finset.mul_sum, hzero, sub_zero]
  have heq : (∑ i ∈ S, delta i) = (∑ i, |delta i|) / 2 := by
    rw [hS, habs]
    ring
  refine ⟨S, heq, ?_⟩
  intro T
  have hfirst : (∑ i ∈ T, delta i) ≤ ∑ i ∈ T, pos i :=
    Finset.sum_le_sum fun i _ => hpoint i
  have hsecond : (∑ i ∈ T, pos i) ≤ ∑ i, pos i := by
    apply Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ T)
    intro i hi hnot
    exact hp i
  rw [habs]
  nlinarith only [hfirst, hsecond]

theorem density_planar_expectation_bound (rho : M2) (h : IsDensity rho) (x z : ℝ) :
    |(Matrix.trace (rho * (Herm2.mk z x 0 (-z)).matrix)).re| ≤ Real.sqrt (z ^ 2 + x ^ 2) := by
  rw [density_traceless_trace rho h x z, Complex.ofReal_re]
  have hs := Real.sq_sqrt (add_nonneg (sq_nonneg z) (sq_nonneg x))
  have hb := planar_dot_bound (a := x) (b := z)
    (x := 2 * (rho 0 1).re) (z := (rho 0 0).re - (rho 1 1).re)
    (u := Real.sqrt (z ^ 2 + x ^ 2)) (density_real_projection_ball rho h)
    (Real.sqrt_nonneg _) (by nlinarith only [hs])
  simpa only [mul_comm] using hb

theorem planar_subset_bound {ι : Type*} [Fintype ι] (a b : ι → ℝ)
    (ha : ∑ i, a i = 0) (hb : ∑ i, b i = 0) (U : ℝ) (hU : 0 ≤ U)
    (hsub : ∀ S : Finset ι, (∑ i ∈ S, a i) ^ 2 + (∑ i ∈ S, b i) ^ 2 ≤ U ^ 2)
    (x z : ℝ) (hball : x ^ 2 + z ^ 2 ≤ 1) :
    (∑ i, |a i * x + b i * z|) / 2 ≤ U := by
  have hzero : ∑ i, (a i * x + b i * z) = 0 := by
    rw [Finset.sum_add_distrib, ← Finset.sum_mul, ← Finset.sum_mul, ha, hb]
    ring
  obtain ⟨S, heq, hmax⟩ := event_representation (fun i => a i * x + b i * z) hzero
  rw [← heq, Finset.sum_add_distrib, ← Finset.sum_mul, ← Finset.sum_mul]
  exact (le_abs_self _).trans (planar_dot_bound hball hU (hsub S))

end Lueders
