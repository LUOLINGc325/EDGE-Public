import SubcubicDefs
import Lean.Elab.Tactic.Omega
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset

set_option autoImplicit false
set_option linter.unusedSectionVars false

namespace Subcubic
universe u v
variable {V : Type u} {C : Type v}
variable [Fintype V] [DecidableEq V] [Fintype C] [DecidableEq C]

theorem tau_le_degree (G : Graph V) (q : Coloring V C) (x : V) :
    tau G q x ≤ degree G x := by
  classical
  let f : (neighborColors G q x) → V := fun c =>
    Classical.choose ((Finset.mem_filter.mp c.property).2)
  have hf (c : neighborColors G q x) : Adj G x (f c) ∧ q (f c) = some c.val :=
    Classical.choose_spec ((Finset.mem_filter.mp c.property).2)
  let g : (neighborColors G q x) → (neighbors G x) := fun c =>
    ⟨f c, Finset.mem_filter.mpr ⟨Finset.mem_univ _, (hf c).1⟩⟩
  have hg : Function.Injective g := by
    intro c d h
    have hfd : f c = f d := congrArg Subtype.val h
    have he : some c.val = some d.val := (hf c).2.symm.trans (hfd ▸ (hf d).2)
    exact Subtype.ext (Option.some.inj he)
  exact Finset.card_le_card_of_injective hg

theorem TE_le_D (G : Graph V) (q : Coloring V C) : TE G q ≤ D G q := by
  unfold TE D
  exact Finset.sum_le_sum (fun x _ => tau_le_degree G q x)

theorem D_le_six (G : Graph V) (q : Coloring V C)
    (hd : MaxDegreeThree G) (hh : (holes q).card = 2) : D G q ≤ 6 := by
  calc D G q ≤ ∑ x ∈ holes q, (3 : Nat) := Finset.sum_le_sum (fun x _ => hd x)
       _ = 6 := by simp [hh]

theorem degree_eq_sum (G : Graph V) (x : V) :
    degree G x = ∑ y : V, if Adj G x y then 1 else 0 := by
  simp [degree, neighbors, Finset.sum_filter]

theorem weighted_edges_le (G : Graph V) (q : Coloring V C) :
    4 * monoArcs G q + emptyArcs G q ≤ 4 * ∑ x : V, degree G x := by
  have hterm (x y : V) :
      4 * monoTerm G q x y + emptyTerm G q x y ≤
        4 * (if Adj G x y then 1 else 0) := by
    unfold monoTerm emptyTerm
    split_ifs <;> simp_all
  calc
    4 * monoArcs G q + emptyArcs G q =
        ∑ x : V, ∑ y : V, (4 * monoTerm G q x y + emptyTerm G q x y) := by
      simp [monoArcs, emptyArcs, Finset.mul_sum, Finset.sum_add_distrib]
    _ ≤ ∑ x : V, ∑ y : V, 4 * (if Adj G x y then 1 else 0) :=
      Finset.sum_le_sum (fun x _ => Finset.sum_le_sum (fun y _ => hterm x y))
    _ = 4 * ∑ x : V, degree G x := by
      simp only [degree_eq_sum, Finset.mul_sum]

theorem degree_sum_le (G : Graph V) (hd : MaxDegreeThree G) :
    ∑ x : V, degree G x ≤ 3 * Fintype.card V := by
  calc ∑ x : V, degree G x ≤ ∑ _x : V, (3 : Nat) :=
         Finset.sum_le_sum (fun x _ => hd x)
       _ = 3 * Fintype.card V := by simp [Nat.mul_comm]

/-- A deliberately conservative linear bound requiring no unproved sharp edge count. -/
theorem potential_linear_bound (G : Graph V) (q : Coloring V C)
    (hd : MaxDegreeThree G) (hh : (holes q).card = 2) :
    potential G q ≤ 12 * Fintype.card V + 72 := by
  have ht := TE_le_D G q
  have hD := D_le_six G q hd hh
  have he := weighted_edges_le G q
  have hn := degree_sum_le G hd
  unfold potential
  omega

theorem half_potential_linear_bound (G : Graph V) (q : Coloring V C)
    (hd : MaxDegreeThree G) (hh : (holes q).card = 2) :
    potential G q / 2 ≤ 6 * Fintype.card V + 36 := by
  have h := potential_linear_bound G q hd hh
  omega

end Subcubic
