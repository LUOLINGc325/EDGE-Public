import GridConcentration
import Mathlib.Analysis.Normed.Group.InfiniteSum

/-! Uniform dominated summation on a countable lattice. -/

open scoped BigOperators Topology
open Filter Set

namespace RenyiProductOrderPhase

theorem uniform_dominated_integer_sums {α : Type*}
    (f g : ℕ → α → ℤ → ℝ) (B : ℤ → ℝ) (hB₀ : ∀ j, 0 ≤ B j) (hB : Summable B)
    (hf : ∀ n a, Summable (f n a)) (hg : ∀ n a, Summable (g n a))
    (hDom : ∃ N : ℕ, ∀ n ≥ N, ∀ a j, |f n a j - g n a j| ≤ B j)
    (hNear : ∀ j : ℤ, ∀ ε > 0, ∃ N : ℕ, ∀ n ≥ N, ∀ a, |f n a j - g n a j| < ε)
    {ε : ℝ} (hε : 0 < ε) :
    ∃ N : ℕ, ∀ n ≥ N, ∀ a, |(∑' j, f n a j) - ∑' j, g n a j| < ε := by
  classical
  have hHalf : 0 < ε / 2 := div_pos hε (by norm_num)
  obtain ⟨J, hTail⟩ := summable_masked_tail_small B hB hHalf
  let C := 2 * ((J.card : ℝ) + 1)
  have hC : 0 < C := by unfold C; positivity
  let η := ε / C
  have hη : 0 < η := div_pos hε hC
  have hFinite (S : Finset ℤ) :
      ∃ N : ℕ, ∀ n ≥ N, ∀ j ∈ S, ∀ a, |f n a j - g n a j| ≤ η := by
    induction S using Finset.induction_on with
    | empty => exact ⟨0, fun _ _ _ hj => (Finset.not_mem_empty _ hj).elim⟩
    | @insert j S hj ih =>
      obtain ⟨N₁, h₁⟩ := hNear j η hη
      obtain ⟨N₂, h₂⟩ := ih
      refine ⟨max N₁ N₂, ?_⟩
      intro n hn k hk a
      rcases Finset.mem_insert.1 hk with h | h
      · subst k
        exact (h₁ n ((le_max_left _ _).trans hn) a).le
      · exact h₂ n ((le_max_right _ _).trans hn) k h a
  obtain ⟨N₁, h₁⟩ := hFinite J
  obtain ⟨N₂, h₂⟩ := hDom
  refine ⟨max N₁ N₂, ?_⟩
  intro n hn a
  let c (j : ℤ) := if j ∈ J then η else 0
  let t (j : ℤ) := if j ∈ J then 0 else B j
  have hc : Summable c := summable_of_ne_finset_zero (s := J) (fun j hj => if_neg hj)
  have ht₀ : ∀ j, 0 ≤ t j := by
    intro j
    by_cases hj : j ∈ J <;> simp [t, hj, hB₀ j]
  have ht₁ : ∀ j, t j ≤ B j := by
    intro j
    by_cases hj : j ∈ J <;> simp [t, hj, hB₀ j]
  have ht : Summable t := Summable.of_nonneg_of_le ht₀ ht₁ hB
  have hdBound (j : ℤ) : |f n a j - g n a j| ≤ c j + t j := by
    by_cases hj : j ∈ J
    · simpa only [c, t, if_pos hj, add_zero] using h₁ n ((le_max_left _ _).trans hn) j hj a
    · simpa only [c, t, if_neg hj, zero_add] using h₂ n ((le_max_right _ _).trans hn) a j
  have hd : Summable (fun j => |f n a j - g n a j|) :=
    Summable.of_nonneg_of_le (fun j => abs_nonneg _) hdBound (hc.add ht)
  have hcSum : (∑' j, c j) = (J.card : ℝ) * η := by
    rw [tsum_eq_sum (s := J) (fun j hj => if_neg hj)]
    calc
      _ = ∑ _ ∈ J, η := Finset.sum_congr rfl (fun j hj => if_pos hj)
      _ = _ := by rw [Finset.sum_const, nsmul_eq_mul]
  have hC' : (J.card : ℝ) * η < ε / 2 := by
    have hEq : C * η = ε := mul_div_cancel₀ _ hC.ne'
    unfold C at hEq
    nlinarith only [hEq, hη]
  rw [← (hf n a).tsum_sub (hg n a)]
  calc
    _ ≤ ∑' j, |f n a j - g n a j| := by
      simpa only [Real.norm_eq_abs] using norm_tsum_le_tsum_norm
        (show Summable (fun j => ‖f n a j - g n a j‖) from by
          simpa only [Real.norm_eq_abs] using hd)
    _ ≤ ∑' j, (c j + t j) := hd.tsum_le_tsum hdBound (hc.add ht)
    _ = (J.card : ℝ) * η + (∑' j, t j) := by rw [hc.tsum_add ht, hcSum]
    _ < ε := by
      have hT : (∑' j, t j) < ε / 2 := hTail
      linarith only [hC', hT]

end RenyiProductOrderPhase
