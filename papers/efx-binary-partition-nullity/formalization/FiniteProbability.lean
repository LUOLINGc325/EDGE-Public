import Mathlib.Algebra.BigOperators.Field
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.Prod
import Mathlib.Data.Real.Basic
import Mathlib.SetTheory.Cardinal.Finite
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.NormNum

open scoped BigOperators

namespace TwoColorNullity

/-- Uniform probability on an explicitly finite sample space. -/
noncomputable def finiteProbability {Sample : Type*} [Fintype Sample] (event : Sample → Prop) : ℝ :=
  (Nat.card {sample // event sample} : ℝ) / Fintype.card Sample

theorem finiteProbability_mono {Sample : Type*} [Fintype Sample] {event event' : Sample → Prop}
    (h : ∀ sample, event sample → event' sample) :
    finiteProbability event ≤ finiteProbability event' := by
  classical
  unfold finiteProbability
  apply div_le_div_of_nonneg_right _ (Nat.cast_nonneg _)
  exact_mod_cast Nat.card_le_card_of_injective
    (fun sample : {sample // event sample} => (⟨sample.val, h _ sample.property⟩ : {sample // event' sample}))
    (fun _ _ he => Subtype.ext (congrArg (fun x : {sample // event' sample} => x.val) he))

theorem finiteProbability_union_bound {Sample Witness : Type*} [Fintype Sample] {witnesses : Finset Witness}
    (event : Witness → Sample → Prop) :
    finiteProbability (fun sample => ∃ w ∈ witnesses, event w sample) ≤
      ∑ w ∈ witnesses, finiteProbability (event w) := by
  classical
  let events (w : Witness) := Finset.univ.filter (event w)
  let unionEvent (sample : Sample) := ∃ w ∈ witnesses, event w sample
  have count (p : Sample → Prop) [DecidablePred p] :
      Nat.card {sample // p sample} = (Finset.univ.filter p).card := by
    rw [Nat.card_eq_fintype_card, Fintype.card_subtype]
  have hunion : (Finset.univ.filter unionEvent) = witnesses.biUnion events := by
    ext sample
    simp [events, unionEvent]
  have hcount : Nat.card {sample // unionEvent sample} ≤
      ∑ w ∈ witnesses, Nat.card {sample // event w sample} := by
    calc
      _ = (Finset.univ.filter unionEvent).card := count unionEvent
      _ = (witnesses.biUnion events).card := congrArg Finset.card hunion
      _ ≤ ∑ w ∈ witnesses, (events w).card := Finset.card_biUnion_le
      _ = _ := Finset.sum_congr rfl fun w _ => (count (event w)).symm
  unfold finiteProbability
  rw [← Finset.sum_div, ← Nat.cast_sum]
  exact div_le_div_of_nonneg_right (by exact_mod_cast hcount) (Nat.cast_nonneg _)

/-- Each equality pins one distinct target bit to a source bit that stays free. -/
theorem finiteProbability_copy_bits {Cell Constraint : Type*} [Fintype Cell] [DecidableEq Cell] [Fintype Constraint]
    (target : Constraint ↪ Cell) (source : Constraint → Cell)
    (disjoint : ∀ i j, source i ≠ target j) :
    finiteProbability (fun bits : Cell → Bool => ∀ i, bits (target i) = bits (source i)) =
      ((1 : ℝ) / 2) ^ Fintype.card Constraint := by
  classical
  let free := {cell : Cell // cell ∉ Set.range target}
  let locate (cell : Cell) : free :=
    if h : cell ∈ Set.range target then
      ⟨source h.choose, fun ⟨j, hj⟩ => disjoint h.choose j hj.symm⟩
    else ⟨cell, h⟩
  have locate_free (cell : free) : locate cell.val = cell := by
    unfold locate
    rw [dif_neg cell.property]
  have htarget (i : Constraint) : target i ∈ Set.range target := ⟨i, rfl⟩
  have hsource (i : Constraint) : source i ∉ Set.range target := fun ⟨j, hj⟩ => disjoint i j hj.symm
  have locate_target (i : Constraint) : locate (target i) = locate (source i) := by
    have hi : (htarget i).choose = i := target.injective (htarget i).choose_spec
    unfold locate
    rw [dif_pos (htarget i), dif_neg (hsource i)]
    apply Subtype.ext
    exact congrArg source hi
  let equivalence : {bits : Cell → Bool // ∀ i, bits (target i) = bits (source i)} ≃ (free → Bool) := {
    toFun := fun bits cell => bits.val cell.val
    invFun := fun bits => ⟨fun cell => bits (locate cell), fun i => congrArg bits (locate_target i)⟩
    left_inv := by
      intro bits
      apply Subtype.ext
      funext cell
      change bits.val (locate cell).val = bits.val cell
      by_cases hc : cell ∈ Set.range target
      · rw [← hc.choose_spec]
        rw [locate_target]
        rw [locate_free ⟨source hc.choose, hsource hc.choose⟩]
        exact (bits.property hc.choose).symm
      · exact congrArg (fun freeCell : free => bits.val freeCell.val) (locate_free ⟨cell, hc⟩)
    right_inv := by
      intro bits
      funext cell
      exact congrArg bits (locate_free cell)
  }
  have hrange : Fintype.card (↥(Set.range target)) = Fintype.card Constraint :=
    (Fintype.card_congr (Equiv.ofInjective target target.injective)).symm
  have hfree : Fintype.card free = Fintype.card Cell - Fintype.card Constraint := by
    dsimp only [free]
    rw [Fintype.card_subtype_compl, hrange]
  have hcount : Nat.card {bits : Cell → Bool // ∀ i, bits (target i) = bits (source i)} =
      2 ^ (Fintype.card Cell - Fintype.card Constraint) := by
    rw [Nat.card_congr equivalence, Nat.card_eq_fintype_card, Fintype.card_fun, hfree]
    simp
  have hcells : Fintype.card Constraint ≤ Fintype.card Cell := Fintype.card_le_of_embedding target
  unfold finiteProbability
  rw [hcount, Fintype.card_fun]
  simp only [Fintype.card_bool, Nat.cast_pow, Nat.cast_ofNat, div_pow, one_pow]
  let available := Fintype.card Cell - Fintype.card Constraint
  have hsum : available + Fintype.card Constraint = Fintype.card Cell := Nat.sub_add_cancel hcells
  change (2 : ℝ) ^ available / 2 ^ Fintype.card Cell = 1 / 2 ^ Fintype.card Constraint
  nth_rw 1 [← hsum]
  rw [pow_add]
  field_simp

/-- There is one independent bit per labeled item and coordinate. -/
theorem disjoint_pairs_agreement_probability {Agent Item : Type*} [Fintype Agent] [DecidableEq Agent]
    [Fintype Item] [DecidableEq Item]
    (owners : Finset Agent) (r : ℕ) (pairs : (Fin r × Bool) ↪ Item) :
    finiteProbability (fun bits : (Agent × Item) → Bool =>
      ∀ i : ↥owners, ∀ k : Fin r, bits (i.val, pairs (k, true)) = bits (i.val, pairs (k, false))) =
      ((1 : ℝ) / 2) ^ (r * owners.card) := by
  classical
  let target : (↥owners × Fin r) ↪ (Agent × Item) := {
    toFun := fun pair => (pair.1.val, pairs (pair.2, true))
    inj' := by
      intro a b he
      apply Prod.ext
      · exact Subtype.ext (congrArg Prod.fst he)
      · exact congrArg Prod.fst (pairs.injective (congrArg Prod.snd he))
  }
  let source (pair : ↥owners × Fin r) : Agent × Item := (pair.1.val, pairs (pair.2, false))
  have noOverlap (a b) : source a ≠ target b := fun he =>
    Bool.false_ne_true (congrArg Prod.snd (pairs.injective (congrArg Prod.snd he)))
  have h := finiteProbability_copy_bits target source noOverlap
  rw [Fintype.card_prod, Fintype.card_coe, Fintype.card_fin, Nat.mul_comm] at h
  have hquant (bits : (Agent × Item) → Bool) :
      (∀ pair, bits (target pair) = bits (source pair)) ↔
        ∀ i : ↥owners, ∀ k : Fin r, bits (i.val, pairs (k, true)) = bits (i.val, pairs (k, false)) := by
    exact ⟨fun forallPair i k => forallPair (i, k), fun forallCoords p => forallCoords p.1 p.2⟩
  simpa only [funext (fun bits => propext (hquant bits))] using h

end TwoColorNullity
