import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Combinatorics.SimpleGraph.Path
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Field
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

open scoped BigOperators

namespace GlauberAnnealing

noncomputable def neighbors {V : Type*} [Fintype V] (G : SimpleGraph V) (v : V) :
    Finset V := by
  classical
  exact Finset.univ.filter (G.Adj v)

@[simp] theorem mem_neighbors {V : Type*} [Fintype V] {G : SimpleGraph V}
    {u v : V} : u ∈ neighbors G v ↔ G.Adj v u := by
  classical
  simp [neighbors]

/-- The finite simple regular proposal graph of the Glauber model. -/
structure RegularGraph (V : Type*) [Fintype V] where
  graph : SimpleGraph V
  degree : ℕ
  degree_pos : 0 < degree
  card_neighbors : ∀ v, (neighbors graph v).card = degree

variable {V : Type*} [Fintype V]

noncomputable def acceptance (x : ℝ) : ℝ := 1 / (1 + Real.exp x)

theorem acceptance_pos (x : ℝ) : 0 < acceptance x := by
  unfold acceptance
  positivity

theorem acceptance_lt_one (x : ℝ) : acceptance x < 1 := by
  have hexp := Real.exp_pos x
  apply (div_lt_iff₀ (show 0 < 1 + Real.exp x by positivity)).2
  linarith

theorem acceptance_antitone : Antitone acceptance := by
  intro x y h
  exact one_div_le_one_div_of_le (by positivity) (add_le_add_left (Real.exp_le_exp.mpr h) 1)

theorem acceptance_add_neg (x : ℝ) : acceptance x + acceptance (-x) = 1 := by
  have hp := Real.exp_pos x
  unfold acceptance
  rw [Real.exp_neg]
  field_simp
  ring

namespace RegularGraph

variable (M : RegularGraph V)

theorem real_degree_pos : (0 : ℝ) < M.degree := by
  exact_mod_cast M.degree_pos

noncomputable def weight (E : V → ℝ) (β : ℝ) (i : V) : ℝ :=
  Real.exp (-β * E i)

noncomputable def gibbs (E : V → ℝ) (β : ℝ) (i : V) : ℝ :=
  weight E β i / ∑ j, weight E β j

noncomputable def edgeRate (E : V → ℝ) (β : ℝ) (i j : V) : ℝ := by
  classical
  exact if M.graph.Adj i j then acceptance (β * (E i - E j)) / M.degree else 0

noncomputable def exitRate (E : V → ℝ) (β : ℝ) (j : V) : ℝ :=
  ∑ i, M.edgeRate E β i j

noncomputable def bias (E : V → ℝ) (β : ℝ) (i : V) : ℝ :=
  2 * M.exitRate E β i - 1

noncomputable def transition (E : V → ℝ) (β : ℝ) (i j : V) : ℝ := by
  classical
  exact M.edgeRate E β i j + if i = j then 1 - M.exitRate E β j else 0

noncomputable def update (E : V → ℝ) (β : ℝ) (p : V → ℝ) (i : V) : ℝ :=
  ∑ j, M.transition E β i j * p j

noncomputable def activity (E : V → ℝ) (β : ℝ) (p : V → ℝ) : ℝ :=
  ∑ j, M.exitRate E β j * p j

noncomputable def firstActivity (E : V → ℝ) (β₀ β₁ : ℝ) : ℝ :=
  M.activity E β₁ (gibbs E β₀)

noncomputable def secondActivity (E : V → ℝ) (β₀ β₁ β₂ : ℝ) : ℝ :=
  M.activity E β₂ (M.update E β₁ (gibbs E β₀))

noncomputable def averageActivity (E : V → ℝ) (β₀ β₁ β₂ : ℝ) : ℝ :=
  (M.firstActivity E β₀ β₁ + M.secondActivity E β₀ β₁ β₂) / 2

omit [Fintype V] in
theorem weight_pos (E : V → ℝ) (β : ℝ) (i : V) : 0 < weight E β i :=
  Real.exp_pos _

theorem gibbs_normalizer_pos [Nonempty V] (E : V → ℝ) (β : ℝ) :
    0 < ∑ j, weight E β j :=
  Finset.sum_pos (fun j _ => weight_pos E β j) Finset.univ_nonempty

theorem gibbs_pos [Nonempty V] (E : V → ℝ) (β : ℝ) (i : V) :
    0 < gibbs E β i :=
  div_pos (weight_pos E β i) (gibbs_normalizer_pos E β)

theorem gibbs_sum [Nonempty V] (E : V → ℝ) (β : ℝ) : ∑ i, gibbs E β i = 1 := by
  unfold gibbs
  rw [← Finset.sum_div, div_self (ne_of_gt (gibbs_normalizer_pos E β))]

theorem edgeRate_of_adj (E : V → ℝ) (β : ℝ) {i j : V} (h : M.graph.Adj i j) :
    M.edgeRate E β i j = acceptance (β * (E i - E j)) / M.degree := by
  classical
  simp [edgeRate, h]

theorem edgeRate_of_not_adj (E : V → ℝ) (β : ℝ) {i j : V} (h : ¬M.graph.Adj i j) :
    M.edgeRate E β i j = 0 := by
  classical
  simp [edgeRate, h]

theorem edgeRate_nonneg (E : V → ℝ) (β : ℝ) (i j : V) : 0 ≤ M.edgeRate E β i j := by
  classical
  by_cases h : M.graph.Adj i j
  · rw [M.edgeRate_of_adj E β h]
    exact div_nonneg (acceptance_pos _).le M.real_degree_pos.le
  · simp [M.edgeRate_of_not_adj E β h]

theorem edgeRate_pos (E : V → ℝ) (β : ℝ) {i j : V} (h : M.graph.Adj i j) :
    0 < M.edgeRate E β i j := by
  rw [M.edgeRate_of_adj E β h]
  exact div_pos (acceptance_pos _) M.real_degree_pos

theorem edgeRate_self (E : V → ℝ) (β : ℝ) (j : V) : M.edgeRate E β j j = 0 :=
  M.edgeRate_of_not_adj E β (M.graph.loopless j)

open Classical in
theorem edgeRate_add_reverse (E : V → ℝ) (β : ℝ) (i j : V) :
    M.edgeRate E β i j + M.edgeRate E β j i =
      if i ∈ neighbors M.graph j then (1 : ℝ) / M.degree else 0 := by
  classical
  by_cases h : M.graph.Adj j i
  · rw [M.edgeRate_of_adj E β h.symm, M.edgeRate_of_adj E β h]
    rw [if_pos (mem_neighbors.mpr h), ← add_div]
    have hx : β * (E j - E i) = -(β * (E i - E j)) := by ring
    rw [hx, acceptance_add_neg]
  · have h' : ¬M.graph.Adj i j := fun h' => h h'.symm
    simp [M.edgeRate_of_not_adj E β h, M.edgeRate_of_not_adj E β h', h]

theorem exit_add_incoming (E : V → ℝ) (β : ℝ) (j : V) :
    M.exitRate E β j + ∑ i, M.edgeRate E β j i = 1 := by
  classical
  unfold exitRate
  rw [← Finset.sum_add_distrib]
  simp_rw [M.edgeRate_add_reverse E β]
  simp only [Finset.sum_ite_mem, Finset.univ_inter, Finset.sum_const,
    M.card_neighbors, nsmul_eq_mul]
  exact mul_one_div_cancel (ne_of_gt M.real_degree_pos)

theorem exit_nonneg (E : V → ℝ) (β : ℝ) (j : V) : 0 ≤ M.exitRate E β j :=
  Finset.sum_nonneg fun i _ => M.edgeRate_nonneg E β i j

theorem exit_lt_one (E : V → ℝ) (β : ℝ) (j : V) : M.exitRate E β j < 1 := by
  have hx : (neighbors M.graph j).Nonempty :=
    Finset.card_pos.mp (M.card_neighbors j ▸ M.degree_pos)
  obtain ⟨i, hi⟩ := hx
  have hin : 0 < ∑ i, M.edgeRate E β j i :=
    Finset.sum_pos' (fun i _ => M.edgeRate_nonneg E β j i)
      ⟨i, Finset.mem_univ _, M.edgeRate_pos E β (mem_neighbors.mp hi)⟩
  linarith [M.exit_add_incoming E β j]

theorem transition_nonneg (E : V → ℝ) (β : ℝ) (i j : V) :
    0 ≤ M.transition E β i j := by
  classical
  unfold transition
  exact add_nonneg (M.edgeRate_nonneg E β i j)
    (by split_ifs <;> linarith [M.exit_lt_one E β j])

theorem transition_diagonal_pos (E : V → ℝ) (β : ℝ) (j : V) :
    0 < M.transition E β j j := by
  have h := M.exit_lt_one E β j
  simp [transition, M.edgeRate_self, sub_pos.mpr h]

theorem transition_of_ne (E : V → ℝ) (β : ℝ) {i j : V} (h : i ≠ j) :
    M.transition E β i j = M.edgeRate E β i j := by
  classical
  simp [transition, h]

theorem transition_col_sum (E : V → ℝ) (β : ℝ) (j : V) :
    ∑ i, M.transition E β i j = 1 := by
  classical
  unfold transition
  rw [Finset.sum_add_distrib]
  change M.exitRate E β j + (∑ i, if i = j then 1 - M.exitRate E β j else 0) = 1
  simp

theorem transition_row_sum (E : V → ℝ) (β : ℝ) (i : V) :
    ∑ j, M.transition E β i j = 1 - M.bias E β i := by
  classical
  unfold transition bias
  rw [Finset.sum_add_distrib]
  have hs : (∑ j, if i = j then 1 - M.exitRate E β j else 0) = 1 - M.exitRate E β i := by
    rw [Finset.sum_eq_single i]
    · simp
    · intro j _ hj
      simp [Ne.symm hj]
    · simp
  rw [hs]
  linarith [M.exit_add_incoming E β i]

theorem update_sum (E : V → ℝ) (β : ℝ) (p : V → ℝ) :
    ∑ i, M.update E β p i = ∑ j, p j := by
  unfold update
  rw [Finset.sum_comm]
  simp_rw [← Finset.sum_mul, M.transition_col_sum, one_mul]

theorem update_pos (E : V → ℝ) (β : ℝ) (p : V → ℝ) (hp : ∀ j, 0 < p j) (i : V) :
    0 < M.update E β p i :=
  Finset.sum_pos'
    (fun j _ => mul_nonneg (M.transition_nonneg E β i j) (hp j).le)
    ⟨i, Finset.mem_univ _, mul_pos (M.transition_diagonal_pos E β i) (hp i)⟩

theorem detailed_balance [Nonempty V] (E : V → ℝ) (β : ℝ) (i j : V) :
    M.transition E β i j * gibbs E β j = M.transition E β j i * gibbs E β i := by
  classical
  by_cases hij : i = j
  · simp [hij]
  rw [M.transition_of_ne E β hij, M.transition_of_ne E β (Ne.symm hij)]
  by_cases h : M.graph.Adj i j
  · rw [M.edgeRate_of_adj E β h, M.edgeRate_of_adj E β h.symm]
    unfold acceptance gibbs weight
    rw [show β * (E i - E j) = β * E i - β * E j by ring,
      show β * (E j - E i) = β * E j - β * E i by ring,
      Real.exp_sub, Real.exp_sub]
    simp_rw [neg_mul, Real.exp_neg]
    have hZ := gibbs_normalizer_pos E β
    have hd := M.real_degree_pos
    have hi := Real.exp_pos (β * E i)
    have hj := Real.exp_pos (β * E j)
    have h1 : 0 < 1 + Real.exp (β * E i) / Real.exp (β * E j) := by positivity
    have h2 : 0 < 1 + Real.exp (β * E j) / Real.exp (β * E i) := by positivity
    unfold weight at hZ
    simp_rw [neg_mul, Real.exp_neg] at hZ
    field_simp [ne_of_gt hZ, ne_of_gt hd, ne_of_gt hi, ne_of_gt hj,
      ne_of_gt h1, ne_of_gt h2]
    ring
  · have h' : ¬M.graph.Adj j i := fun h' => h h'.symm
    simp [M.edgeRate_of_not_adj E β h, M.edgeRate_of_not_adj E β h']

theorem update_gibbs [Nonempty V] (E : V → ℝ) (β : ℝ) :
    M.update E β (gibbs E β) = gibbs E β := by
  funext i
  unfold update
  simp_rw [M.detailed_balance E β i, ← Finset.sum_mul, M.transition_col_sum, one_mul]

end RegularGraph
end GlauberAnnealing
