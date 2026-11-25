import RegularGlauber
import Mathlib.Data.Complex.Trigonometric

open scoped BigOperators

namespace GlauberAnnealing
namespace RegularGraph

variable {V : Type*} [Fintype V] (M : RegularGraph V)

noncomputable def uniform (V : Type*) [Fintype V] : V → ℝ :=
  fun _ => 1 / Fintype.card V

lemma card_pos_real [Nonempty V] : (0 : ℝ) < Fintype.card V := by
  exact_mod_cast Fintype.card_pos (α := V)

theorem uniform_sum [Nonempty V] : ∑ i, uniform V i = 1 := by
  simp only [uniform, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  exact mul_one_div_cancel (ne_of_gt (card_pos_real (V := V)))

theorem gibbs_zero (E : V → ℝ) : gibbs E 0 = uniform V := by
  funext i
  simp [gibbs, weight, uniform]

theorem sum_exit (E : V → ℝ) (β : ℝ) :
    ∑ j, M.exitRate E β j = (Fintype.card V : ℝ) / 2 := by
  have hsum : (∑ j, (M.exitRate E β j + ∑ i, M.edgeRate E β j i)) = Fintype.card V := by
    simp [M.exit_add_incoming]
  have htranspose : (∑ j, ∑ i, M.edgeRate E β j i) = ∑ j, M.exitRate E β j := by
    unfold exitRate
    rw [Finset.sum_comm]
  rw [Finset.sum_add_distrib, htranspose] at hsum
  linarith

theorem sum_bias (E : V → ℝ) (β : ℝ) : ∑ j, M.bias E β j = 0 := by
  unfold bias
  rw [Finset.sum_sub_distrib, ← Finset.mul_sum, M.sum_exit]
  simp
  ring

theorem uniform_activity [Nonempty V] (E : V → ℝ) (β : ℝ) :
    M.activity E β (uniform V) = 1 / 2 := by
  unfold activity uniform
  rw [← Finset.sum_mul, M.sum_exit]
  field_simp [ne_of_gt (card_pos_real (V := V))]
  ring

theorem uniform_update (E : V → ℝ) (β : ℝ) (i : V) :
    M.update E β (uniform V) i = (1 - M.bias E β i) / Fintype.card V := by
  unfold update uniform
  rw [← Finset.sum_mul, M.transition_row_sum]
  exact (div_eq_mul_one_div _ _).symm

theorem uniform_second_activity [Nonempty V] (E : V → ℝ) (α β : ℝ) :
    M.activity E β (M.update E α (uniform V)) =
      1 / 2 - (∑ j, M.bias E β j * M.bias E α j) / (2 * Fintype.card V) := by
  have hA : M.activity E β (M.update E α (uniform V)) =
      (∑ j, M.exitRate E β j * (1 - M.bias E α j)) / Fintype.card V := by
    unfold activity
    simp_rw [M.uniform_update E α, mul_div_assoc']
    rw [Finset.sum_div]
  have hpoint (j : V) : M.exitRate E β j * (1 - M.bias E α j) =
      M.exitRate E β j - (M.bias E β j * M.bias E α j + M.bias E α j) / 2 := by
    unfold bias
    ring
  rw [hA]
  simp_rw [hpoint]
  rw [Finset.sum_sub_distrib, ← Finset.sum_div, Finset.sum_add_distrib, M.sum_bias,
    add_zero, M.sum_exit]
  have hN := ne_of_gt (card_pos_real (V := V))
  field_simp [hN]

theorem gibbs_energy_antitone [Nonempty V] (E : V → ℝ) (β : ℝ) (hβ : 0 ≤ β)
    {i j : V} (h : E i ≤ E j) : gibbs E β j ≤ gibbs E β i := by
  apply div_le_div_of_nonneg_right _ (gibbs_normalizer_pos E β).le
  exact Real.exp_le_exp.mpr (mul_le_mul_of_nonpos_left h (neg_nonpos.mpr hβ))

theorem edgeRate_energy_order (E : V → ℝ) (β : ℝ) (hβ : 0 ≤ β)
    {i j : V} (h : E i ≤ E j) : M.edgeRate E β j i ≤ M.edgeRate E β i j := by
  classical
  by_cases ha : M.graph.Adj i j
  · rw [M.edgeRate_of_adj E β ha, M.edgeRate_of_adj E β ha.symm]
    apply div_le_div_of_nonneg_right _ M.real_degree_pos.le
    apply acceptance_antitone (mul_le_mul_of_nonneg_left _ hβ)
    linarith
  · simp [M.edgeRate_of_not_adj E β ha,
      M.edgeRate_of_not_adj E β (fun h' => ha h'.symm : ¬M.graph.Adj j i)]

theorem directed_pair_nonpos [Nonempty V] (E : V → ℝ) (α β : ℝ) (hα : 0 ≤ α) (hβ : 0 ≤ β)
    (i j : V) :
    (M.edgeRate E β i j - M.edgeRate E β j i) * (gibbs E α j - gibbs E α i) ≤ 0 := by
  rcases le_total (E i) (E j) with h | h
  · exact mul_nonpos_of_nonneg_of_nonpos
      (sub_nonneg.mpr (M.edgeRate_energy_order E β hβ h))
      (sub_nonpos.mpr (gibbs_energy_antitone E α hα h))
  · exact mul_nonpos_of_nonpos_of_nonneg
      (sub_nonpos.mpr (M.edgeRate_energy_order E β hβ h))
      (sub_nonneg.mpr (gibbs_energy_antitone E α hα h))

theorem paired_bias_identity (E : V → ℝ) (β : ℝ) (p : V → ℝ) :
    (∑ i, ∑ j, (M.edgeRate E β i j - M.edgeRate E β j i) * (p j - p i)) =
      4 * M.activity E β p - 2 * ∑ j, p j := by
  let r := M.edgeRate E β
  let inRate : V → ℝ := fun j => ∑ i, r j i
  have hin (j : V) : inRate j = 1 - M.exitRate E β j := by
    dsimp [inRate, r]
    linarith [M.exit_add_incoming E β j]
  have h1 : (∑ i, ∑ j, r i j * p j) = M.activity E β p := by
    unfold activity exitRate
    rw [Finset.sum_comm]
    simp_rw [Finset.sum_mul]
    rfl
  have h2 : (∑ i, ∑ j, r j i * p i) = M.activity E β p := by
    rw [← h1, Finset.sum_comm]
  have h3 : (∑ i, ∑ j, r i j * p i) = ∑ j, inRate j * p j := by
    simp_rw [inRate, Finset.sum_mul]
  have h4 : (∑ i, ∑ j, r j i * p j) = ∑ j, inRate j * p j := by
    rw [← h3, Finset.sum_comm]
  change (∑ i, ∑ j, (r i j - r j i) * (p j - p i)) = _
  simp_rw [mul_sub, sub_mul, Finset.sum_sub_distrib]
  rw [h1, h2, h3, h4]
  have h5 : (∑ j, inRate j * p j) = (∑ j, p j) - M.activity E β p := by
    simp_rw [hin, sub_mul, one_mul, Finset.sum_sub_distrib, activity]
  rw [h5]
  ring

theorem gibbs_first_activity_bound [Nonempty V]
    (E : V → ℝ) (α β : ℝ) (hα : 0 ≤ α) (hβ : 0 ≤ β) :
    M.firstActivity E α β ≤ 1 / 2 := by
  have hn : (∑ i, ∑ j, (M.edgeRate E β i j - M.edgeRate E β j i) *
      (gibbs E α j - gibbs E α i)) ≤ 0 :=
    Finset.sum_nonpos fun i _ => Finset.sum_nonpos fun j _ => M.directed_pair_nonpos E α β hα hβ i j
  rw [M.paired_bias_identity E β, gibbs_sum] at hn
  unfold firstActivity
  linarith

theorem activity_total_variation (E : V → ℝ) (β : ℝ) (p q : V → ℝ)
    (hmass : ∑ i, p i = ∑ i, q i) :
    |M.activity E β p - M.activity E β q| ≤ (∑ i, |p i - q i|) / 2 := by
  have hcenter : M.activity E β p - M.activity E β q =
      ∑ j, (M.exitRate E β j - 1 / 2) * (p j - q j) := by
    unfold activity
    simp_rw [mul_sub, sub_mul, Finset.sum_sub_distrib]
    rw [← Finset.mul_sum, ← Finset.mul_sum, hmass]
    ring
  rw [hcenter]
  calc
    _ ≤ ∑ j, |(M.exitRate E β j - 1 / 2) * (p j - q j)| :=
      Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ j, 1 / 2 * |p j - q j| := by
      apply Finset.sum_le_sum
      intro j _
      rw [abs_mul]
      apply mul_le_mul_of_nonneg_right _ (abs_nonneg _)
      exact abs_le.mpr ⟨by linarith [M.exit_nonneg E β j], by linarith [M.exit_lt_one E β j]⟩
    _ = _ := by rw [← Finset.mul_sum]; ring

theorem update_total_variation (E : V → ℝ) (β : ℝ) (p q : V → ℝ) :
    (∑ i, |M.update E β p i - M.update E β q i|) ≤ ∑ i, |p i - q i| := by
  calc
    _ = ∑ i, |∑ j, M.transition E β i j * (p j - q j)| := by
      simp_rw [update, mul_sub, Finset.sum_sub_distrib]
    _ ≤ ∑ i, ∑ j, M.transition E β i j * |p j - q j| := by
      apply Finset.sum_le_sum
      intro i _
      simpa only [abs_mul, abs_of_nonneg (M.transition_nonneg E β i _)] using
        (Finset.abs_sum_le_sum_abs (fun j => M.transition E β i j * (p j - q j)) Finset.univ)
    _ = _ := by
      rw [Finset.sum_comm]
      simp_rw [← Finset.sum_mul, M.transition_col_sum, one_mul]

end RegularGraph
end GlauberAnnealing
