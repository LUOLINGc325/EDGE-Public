import Mathlib.Analysis.Convex.KreinMilman
import Mathlib.Analysis.Convex.Exposed
import Mathlib.LinearAlgebra.Dimension.Finite
import Mathlib.Topology.Order.Compact
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-! Finite active-constraint arguments shared by the covering and matching
problems. The optimizer is selected from an exposed face of the actual
feasible set, and injectivity is proved by feasible perturbations. -/

set_option autoImplicit false
open Finset Filter Set
open scoped Topology

namespace ReciprocalSearch.Active

noncomputable section

variable {E I : Type*} [Fintype E] [Fintype I]

noncomputable def row (a x : E → ℝ) : ℝ := ∑ e, a e * x e

lemma row_add (a x y : E → ℝ) : row a (x + y) = row a x + row a y := by
  simp [row, mul_add, sum_add_distrib]

lemma row_eq_zero_of_disjoint (a z : E → ℝ)
    (h : ∀ e, a e = 0 ∨ z e = 0) : row a z = 0 := by
  unfold row
  exact sum_eq_zero fun e _ => (h e).elim (fun ha => by simp [ha]) (fun hz => by simp [hz])

lemma row_smul (a x : E → ℝ) (r : ℝ) : row a (r • x) = r * row a x := by
  simp only [row, Pi.smul_apply, smul_eq_mul, mul_sum]
  apply sum_congr rfl
  intro e _
  ring

lemma row_continuous (a : E → ℝ) : Continuous (row a) :=
  continuous_finset_sum _ (fun e _ => continuous_const.mul (continuous_apply e))

def feasible (a : I → E → ℝ) (b : I → ℝ) : Set (E → ℝ) :=
  {x | (∀ e, 0 ≤ x e) ∧ ∀ i, row (a i) x ≤ b i}

omit [Fintype I] in
lemma feasible_closed (a : I → E → ℝ) (b : I → ℝ) : IsClosed (feasible a b) := by
  have he : IsClosed {x : E → ℝ | ∀ e, 0 ≤ x e} := by
    simpa only [setOf_forall] using isClosed_iInter (fun e : E =>
      isClosed_le continuous_const (continuous_apply e) (f := fun _ => (0 : ℝ)))
  have hi : IsClosed {x : E → ℝ | ∀ i, row (a i) x ≤ b i} := by
    simpa only [setOf_forall] using isClosed_iInter (fun i : I =>
      isClosed_le (row_continuous (a i)) (continuous_const (y := b i)))
  exact he.inter hi

theorem extreme_direction_zero {a : I → E → ℝ} {b : I → ℝ} {x : E → ℝ}
    (hx : x ∈ (feasible a b).extremePoints ℝ) (z : E → ℝ)
    (hzero : ∀ e, x e = 0 → z e = 0)
    (htight : ∀ i, row (a i) x = b i → row (a i) z = 0) :
    z = 0 := by
  have hxe := (mem_extremePoints_iff_left.mp hx)
  have hs : Continuous (fun t : ℝ => x + t • z) :=
    continuous_const.add (continuous_id.smul continuous_const)
  have hcoordinate (e : E) : ∀ᶠ t : ℝ in 𝓝 0, 0 ≤ (x + t • z) e := by
    by_cases he : x e = 0
    · exact Eventually.of_forall fun t => by simp [he, hzero e he]
    · have hp : 0 < x e := lt_of_le_of_ne (hxe.1.1 e) (Ne.symm he)
      have ho : IsOpen {t : ℝ | 0 < (x + t • z) e} :=
        isOpen_lt continuous_const ((continuous_apply e).comp hs)
      have h : ∀ᶠ t : ℝ in 𝓝 0, 0 < (x + t • z) e :=
        ho.mem_nhds (by simpa using hp)
      exact h.mono fun _ ht => le_of_lt ht
  have hconstraint (i : I) : ∀ᶠ t : ℝ in 𝓝 0, row (a i) (x + t • z) ≤ b i := by
    by_cases hi : row (a i) x = b i
    · exact Eventually.of_forall fun t => by simp [row_add, row_smul, hi, htight i hi]
    · have hp : row (a i) x < b i := lt_of_le_of_ne (hxe.1.2 i) hi
      have ho : IsOpen {t : ℝ | row (a i) (x + t • z) < b i} :=
        isOpen_lt ((row_continuous (a i)).comp hs) continuous_const
      have h : ∀ᶠ t : ℝ in 𝓝 0, row (a i) (x + t • z) < b i :=
        ho.mem_nhds (by simpa using hp)
      exact h.mono fun _ ht => le_of_lt ht
  have hboth : ∀ᶠ t : ℝ in 𝓝 0, x + t • z ∈ feasible a b :=
    ((eventually_all.mpr hcoordinate).and (eventually_all.mpr hconstraint))
  obtain ⟨δ, hδ, hb⟩ := Metric.mem_nhds_iff.mp hboth
  have hplus : x + (δ / 2) • z ∈ feasible a b := by
    apply hb
    rw [Metric.mem_ball, Real.dist_eq, sub_zero, abs_of_pos (half_pos hδ)]
    exact half_lt_self hδ
  have hminus : x + (-(δ / 2)) • z ∈ feasible a b := by
    apply hb
    rw [Metric.mem_ball, Real.dist_eq, sub_zero, abs_neg, abs_of_pos (half_pos hδ)]
    exact half_lt_self hδ
  have hmid : x ∈ openSegment ℝ (x + (δ / 2) • z) (x + (-(δ / 2)) • z) := by
    refine ⟨1 / 2, 1 / 2, by norm_num, by norm_num, by norm_num, ?_⟩
    ext e
    simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul]
    ring
  have he := hxe.2 _ hplus _ hminus hmid
  ext e
  have he' := congrFun he e
  simp only [Pi.add_apply, Pi.smul_apply, smul_eq_mul] at he'
  exact (mul_eq_zero.mp (add_left_cancel (he'.trans (add_zero _).symm))).resolve_left (half_pos hδ).ne'

noncomputable def rowFunctional (a : E → ℝ) : (E → ℝ) →L[ℝ] ℝ :=
  ∑ e, a e • ContinuousLinearMap.proj e

lemma rowFunctional_apply (a x : E → ℝ) : rowFunctional a x = row a x := by
  simp [rowFunctional, row, ContinuousLinearMap.sum_apply]

theorem extreme_maximizer_of_compact_superlevel {P : Set (E → ℝ)}
    (l : (E → ℝ) →L[ℝ] ℝ) {z : E → ℝ} (hz : z ∈ P)
    (hc : IsCompact {x ∈ P | l z ≤ l x}) :
    ∃ x ∈ P.extremePoints ℝ, ∀ y ∈ P, l y ≤ l x := by
  obtain ⟨w, hw, hmax⟩ := hc.exists_isMaxOn ⟨z, hz, le_rfl⟩ l.continuous.continuousOn
  have hall (y) (hy : y ∈ P) : l y ≤ l w := by
    by_cases hy' : l z ≤ l y
    · exact hmax ⟨hy, hy'⟩
    · exact (lt_of_not_ge hy').le.trans hw.2
  let F := l.toExposed P
  have hwF : w ∈ F := ⟨hw.1, hall⟩
  have hF : F = {x ∈ P | l z ≤ l x} ∩ {x | l x = l w} := by
    ext x
    constructor
    · intro hx
      exact ⟨⟨hx.1, hx.2 z hz⟩, le_antisymm (hall x hx.1) (hx.2 w hw.1)⟩
    · rintro ⟨hx, he⟩
      exact ⟨hx.1, fun y hy => (hall y hy).trans_eq he.symm⟩
  have hFc : IsCompact F := by
    rw [hF]
    exact hc.inter_right (isClosed_eq l.continuous continuous_const)
  obtain ⟨x, hx⟩ := hFc.extremePoints_nonempty (show F.Nonempty from ⟨w, hwF⟩)
  have hExposed : IsExposed ℝ P F := ContinuousLinearMap.toExposed.isExposed
  refine ⟨x, hExposed.isExtreme.extremePoints_subset_extremePoints hx, ?_⟩
  exact hx.1.2

open Classical

def extend (S : Finset E) (z : S → ℝ) (e : E) : ℝ :=
  if he : e ∈ S then z ⟨e, he⟩ else 0

omit [Fintype E] in
lemma extend_of_mem (S : Finset E) (z : S → ℝ) {e : E} (he : e ∈ S) :
    extend S z e = z ⟨e, he⟩ := by simp [extend, he]

omit [Fintype E] in
lemma extend_of_not_mem (S : Finset E) (z : S → ℝ) {e : E} (he : e ∉ S) :
    extend S z e = 0 := by simp [extend, he]

def activeMap (a : I → E → ℝ) (S : Finset E) (T : Finset I) : (S → ℝ) →ₗ[ℝ] (T → ℝ) where
  toFun z i := row (a i) (extend S z)
  map_add' z w := by
    have he : extend S (z + w) = extend S z + extend S w := by
      funext e
      by_cases h : e ∈ S <;> simp [extend, h]
    funext i
    simp [he, row_add]
  map_smul' r z := by
    have he : extend S (r • z) = r • extend S z := by
      funext e
      by_cases h : e ∈ S <;> simp [extend, h]
    funext i
    simp [he, row_smul, smul_eq_mul]

theorem active_map_injective {a : I → E → ℝ} {b : I → ℝ} {x : E → ℝ}
    (hx : x ∈ (feasible a b).extremePoints ℝ) (S : Finset E) (T : Finset I)
    (hS : ∀ e ∈ S, x e ≠ 0)
    (hT : ∀ i, row (a i) x = b i → i ∉ T → ∀ e ∈ S, a i e = 0) :
    Function.Injective (activeMap a S T) := by
  intro z w heq
  have hz : activeMap a S T (z - w) = 0 := by rw [map_sub, heq, sub_self]
  have hex := extreme_direction_zero hx (extend S (z - w))
    (fun e he => extend_of_not_mem S _ (fun h => hS e h he))
    (fun i hi => by
      by_cases hit : i ∈ T
      · exact congrFun hz ⟨i, hit⟩
      · apply row_eq_zero_of_disjoint
        intro e
        by_cases he : e ∈ S
        · exact Or.inl (hT i hi hit e he)
        · exact Or.inr (extend_of_not_mem S _ he))
  apply sub_eq_zero.mp
  funext e
  simpa only [extend_of_mem S _ e.property] using congrFun hex e

theorem active_card_le {a : I → E → ℝ} {b : I → ℝ} {x : E → ℝ}
    (hx : x ∈ (feasible a b).extremePoints ℝ) (S : Finset E) (T : Finset I)
    (hS : ∀ e ∈ S, x e ≠ 0)
    (hT : ∀ i, row (a i) x = b i → i ∉ T → ∀ e ∈ S, a i e = 0) :
    S.card ≤ T.card := by
  have h := LinearMap.finrank_le_finrank_of_injective (active_map_injective hx S T hS hT)
  simpa only [Module.finrank_fintype_fun_eq_card, Fintype.card_coe] using h

end
end ReciprocalSearch.Active
