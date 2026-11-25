import AlgorithmOutput
import ImplementationBounds
import Mathlib.Logic.Equiv.Fin.Rotate
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.NormNum

noncomputable section

open Finset

namespace MarketFairDivision
namespace SixGoodExample

abbrev Good := Fin 6

noncomputable def p : Good ≃ Fin (2 * 3) := Equiv.refl _
noncomputable def q : Good ≃ Fin (2 * 3) := (finRotate 6).symm

noncomputable def weights (x : Good) : ℝ := if x.val % 2 = 0 then 1 else 0

noncomputable def C : Finset Good := {0, 2, 4}
noncomputable def D : Finset Good := {0, 1, 4}
noncomputable def E : Finset Good := {0, 1, 3}
noncomputable def F : Finset Good := {1, 3, 5}

theorem nonnegative (x : Good) : 0 ≤ weights x := by
  unfold weights
  split <;> norm_num

theorem even_seed_complement : other C = F := by decide +kernel

theorem ordinal_vertices :
    OrdinalFeasible p q C ∧ OrdinalFeasible p q D ∧
      OrdinalFeasible p q E ∧ OrdinalFeasible p q F := by
  have calcLower (A : Finset Good)
      (h1 : 1 ≤ (A ∩ rankPrefix p 2).card)
      (h2 : 2 ≤ (A ∩ rankPrefix p 4).card)
      (h3 : 3 ≤ (A ∩ rankPrefix p 6).card) : LowerQuotas p A := by
    intro t ht
    interval_cases t <;> first | omega | exact h1 | exact h2 | exact h3
  have calcUpper (A : Finset Good)
      (h1 : (A ∩ rankPrefix q 2).card ≤ 1)
      (h2 : (A ∩ rankPrefix q 4).card ≤ 2)
      (h3 : (A ∩ rankPrefix q 6).card ≤ 3) : UpperIndependent q A := by
    intro t ht
    interval_cases t <;> first | exact h1 | exact h2 | exact h3 | simp
  refine ⟨⟨calcLower C ?_ ?_ ?_, calcUpper C ?_ ?_ ?_⟩,
    ⟨calcLower D ?_ ?_ ?_, calcUpper D ?_ ?_ ?_⟩,
    ⟨calcLower E ?_ ?_ ?_, calcUpper E ?_ ?_ ?_⟩,
    ⟨calcLower F ?_ ?_ ?_, calcUpper F ?_ ?_ ?_⟩⟩ <;> decide +kernel

theorem displayed_path : OrdinalPath p q 3 C F := by
  obtain ⟨hC, hD, hE, hF⟩ := ordinal_vertices
  have hCD : SingleExchange C D :=
    ⟨2, by decide +kernel, 1, by decide +kernel, by decide +kernel⟩
  have hDE : SingleExchange D E :=
    ⟨4, by decide +kernel, 3, by decide +kernel, by decide +kernel⟩
  have hEF : SingleExchange E F :=
    ⟨0, by decide +kernel, 5, by decide +kernel, by decide +kernel⟩
  exact ExchangePath.step hC hCD
    (ExchangePath.step hD hDE (ExchangePath.step hE hEF (ExchangePath.nil F hF)))

private theorem six_total : (Finset.univ : Finset Good) = {0, 1, 2, 3, 4, 5} := by
  decide +kernel

private theorem value_eq_even_count (A : Finset Good) :
    value weights A = ((A.filter fun x => x.val % 2 = 0).card : ℝ) := by
  norm_num [value, weights]

theorem trace_values :
    value weights C = 3 ∧ value weights D = 2 ∧ value weights E = 1 ∧ value weights F = 0 ∧
    total weights = 3 := by
  unfold total
  rw [six_total]
  simp only [value_eq_even_count]
  refine ⟨?_, ?_, ?_, ?_, ?_⟩ <;> exact_mod_cast (by decide +kernel : (_ : ℕ) = _)

theorem seed_fails_market : ¬MarketEF1 weights C ∧ ¬MarketEF1 weights F := by
  have hfail : ¬AdditiveEF1 weights F C := by
    rintro (hz | ⟨x, hx, hv⟩)
    · exact (by decide +kernel : C ≠ ∅) hz
    have hindex : x = 0 ∨ x = 2 ∨ x = 4 := by simpa [C] using hx
    rw [trace_values.2.2.2.1] at hv
    have hc (y : Good) (hy : ((C.erase y).filter fun i => i.val % 2 = 0).card = 2) :
        value weights (C.erase y) = 2 := by rw [value_eq_even_count, hy]; norm_num
    rcases hindex with rfl | rfl | rfl
    · rw [hc 0 (by decide +kernel)] at hv
      norm_num at hv
    · rw [hc 2 (by decide +kernel)] at hv
      norm_num at hv
    · rw [hc 4 (by decide +kernel)] at hv
      norm_num at hv
  exact ⟨fun h => hfail (by simpa only [even_seed_complement] using h.2),
    fun h => hfail (by simpa only [← even_seed_complement, other_other] using h.1)⟩

theorem selected_market_witness :
    MarketEF1 weights D ∧
      value weights (D.erase 0) ≤ value weights (other D) ∧
      value weights (D.erase 4) ≤ value weights (other D) := by
  have he : value weights (other D) = 1 := by
    rw [value_eq_even_count]
    exact_mod_cast (by decide +kernel : ((other D).filter fun x => x.val % 2 = 0).card = 1)
  have h0 : value weights (D.erase 0) ≤ value weights (other D) := by
    rw [he, value_eq_even_count]
    exact_mod_cast (by decide +kernel : ((D.erase 0).filter fun x => x.val % 2 = 0).card ≤ 1)
  have h4 : value weights (D.erase 4) ≤ value weights (other D) := by
    rw [he, value_eq_even_count]
    exact_mod_cast (by decide +kernel : ((D.erase 4).filter fun x => x.val % 2 = 0).card ≤ 1)
  exact ⟨⟨ef1_of_no_envy weights nonnegative (by rw [he, trace_values.2.1]; norm_num),
    Or.inr ⟨0, by decide +kernel, h0⟩⟩, h0, h4⟩

theorem selected_ordinal_witnesses :
    (2 : Good) ∈ other D ∧ (1 : Good) ∈ D ∧
    (∀ l ≤ 6, (((other D).erase 2) ∩ rankPrefix p l).card ≤ (D ∩ rankPrefix p l).card) ∧
    (∀ l ≤ 6, ((D.erase 1) ∩ rankPrefix q l).card ≤ (other D ∩ rankPrefix q l).card) := by
  refine ⟨by decide +kernel, by decide +kernel, ?_, ?_⟩
  · intro l hl
    interval_cases l <;> decide +kernel
  · intro l hl
    interval_cases l <;> decide +kernel

theorem displayed_order_is_selected :
    selectMarket weights [C, D, E, F] = some D := by
  classical
  obtain ⟨hC, hD, hE, hF, hW⟩ := trace_values
  norm_num [selectMarket, firstHalf, firstMarketCrossing, StrictHalfCrossing,
    hC, hD, hE, hF, hW, selected_market_witness.1]

end SixGoodExample

namespace RelatedWitness

abbrev Good := Fin 8
noncomputable def ranking : Good ≃ Fin 8 := Equiv.refl _
noncomputable def X : Finset Good := {2, 3, 4, 5}
noncomputable def Y : Finset Good := {1, 5, 6, 7}

theorem intersecting_failures :
    (X ∩ Y).card = 1 ∧ ¬ RankEF1 ranking X (other X) ∧
      ¬ RankEF1 ranking Y (other Y) := by
  refine ⟨by decide +kernel, ?_, ?_⟩
  · intro h
    have hd := (prefix_witness_equivalence ranking X (other X)).mp h 2 (by decide)
    exact (by decide +kernel : ¬ (other X ∩ rankPrefix ranking 2).card ≤
      (X ∩ rankPrefix ranking 2).card + 1) hd
  · intro h
    have hd := (prefix_witness_equivalence ranking Y (other Y)).mp h 4 (by decide)
    exact (by decide +kernel : ¬ (other Y ∩ rankPrefix ranking 4).card ≤
      (Y ∩ rankPrefix ranking 4).card + 1) hd

end RelatedWitness

end MarketFairDivision
