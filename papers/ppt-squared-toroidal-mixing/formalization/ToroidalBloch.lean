import Mathlib.Data.Real.Sqrt
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace ToroidalBloch

open scoped BigOperators

/-- The four signed combinations from the four-by-four Hadamard matrix have
total squared Euclidean length equal to the sum of the original lengths. -/
theorem hadamardEnergy {ι : Type*} [Fintype ι] (a b c d : ι → ℝ) :
    (∑ i, ((a i + b i + c i + d i) / 2) ^ 2) +
    (∑ i, ((a i + b i - c i - d i) / 2) ^ 2) +
    (∑ i, ((a i + c i - b i - d i) / 2) ^ 2) +
    (∑ i, ((a i + d i - b i - c i) / 2) ^ 2) =
    (∑ i, (a i)^2) + (∑ i, (b i)^2) + (∑ i, (c i)^2) + (∑ i, (d i)^2) := by
  simp only [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i _
  ring

/-- Among the three balanced pair partitions of four unit Bloch vectors,
some half-difference has squared length at most 4/3. -/
theorem shortPartition {ι : Type*} [Fintype ι] (a b c d : ι → ℝ)
    (ha : ∑ i, (a i)^2 = 1) (hb : ∑ i, (b i)^2 = 1)
    (hc : ∑ i, (c i)^2 = 1) (hd : ∑ i, (d i)^2 = 1) :
    (∑ i, ((a i + b i - c i - d i) / 2) ^ 2) ≤ 4/3 ∨
    (∑ i, ((a i + c i - b i - d i) / 2) ^ 2) ≤ 4/3 ∨
    (∑ i, ((a i + d i - b i - c i) / 2) ^ 2) ≤ 4/3 := by
  have h := hadamardEnergy a b c d
  rw [ha, hb, hc, hd] at h
  have hsum : 0 ≤ ∑ i, ((a i + b i + c i + d i) / 2) ^ 2 :=
    Finset.sum_nonneg (fun i _ => sq_nonneg _)
  by_contra! hfalse
  rcases hfalse with ⟨h1,h2,h3⟩
  linarith

/-- Once a unit axis is perpendicular to both within-pair differences,
the two pairs tie and their projected spread is bounded by the selected
half-difference's Euclidean length. -/
theorem pairedProjection {ι : Type*} [Fintype ι] (a b c d n : ι → ℝ)
    (hn : ∑ i, (n i)^2 = 1)
    (hab : ∑ i, a i * n i = ∑ i, b i * n i)
    (hcd : ∑ i, c i * n i = ∑ i, d i * n i)
    (hshort : (∑ i, ((a i+b i-c i-d i)/2)^2) ≤ 4/3) :
    |(∑ i, a i * n i) - ∑ i, c i * n i| ≤ 2 / Real.sqrt 3 := by
  have hlin :
      (∑ i, ((a i+b i-c i-d i)/2) * n i) =
        (∑ i, a i * n i) - ∑ i, c i * n i := by
    have hpoint (i : ι) :
        ((a i+b i-c i-d i)/2) * n i =
          (1/2) * (a i*n i + b i*n i - c i*n i - d i*n i) := by ring
    simp_rw [hpoint, ← Finset.mul_sum, Finset.sum_sub_distrib, Finset.sum_add_distrib,
      ← hab, ← hcd]
    ring
  have hcs := Finset.sum_mul_sq_le_sq_mul_sq Finset.univ
    (fun i : ι => (a i+b i-c i-d i)/2) n
  rw [hlin, hn, mul_one] at hcs
  have hs : 0 < Real.sqrt 3 := Real.sqrt_pos.2 (by norm_num)
  have hsq : (2 / Real.sqrt 3) ^ 2 = (4/3 : ℝ) := by
    rw [div_pow, Real.sq_sqrt (by norm_num)]
    norm_num
  have hup : ((∑ i, a i*n i) - ∑ i, c i*n i)^2 ≤ (2 / Real.sqrt 3)^2 := by
    rw [hsq]
    exact hcs.trans hshort
  exact (abs_le_of_sq_le_sq hup (by positivity))

end ToroidalBloch

#print axioms ToroidalBloch.hadamardEnergy
#print axioms ToroidalBloch.shortPartition
#print axioms ToroidalBloch.pairedProjection
