import OrdinalPaths
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

open Finset
open scoped BigOperators

namespace MarketFairDivision

variable {Goods : Type*} [DecidableEq Goods]

noncomputable def value (w : Goods → ℝ) (A : Finset Goods) : ℝ := ∑ x ∈ A, w x

def AdditiveEF1 (w : Goods → ℝ) (A B : Finset Goods) : Prop :=
  B = ∅ ∨ ∃ x ∈ B, value w (B.erase x) ≤ value w A

omit [DecidableEq Goods] in
theorem value_nonneg (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x) (A : Finset Goods) :
    0 ≤ value w A := Finset.sum_nonneg fun x _ => hw x

theorem value_erase_add (w : Goods → ℝ) {A : Finset Goods} {a : Goods} (ha : a ∈ A) :
    value w (A.erase a) + w a = value w A := by
  unfold value
  simpa [add_comm] using Finset.sum_erase_add A w ha

theorem value_after_exchange (w : Goods → ℝ) {A : Finset Goods} {a b : Goods}
    (ha : a ∈ A) (hb : b ∉ A) :
    value w (exchange A a b) + w a = value w A + w b := by
  have he : value w (exchange A a b) = w b + value w (A.erase a) := by
    unfold exchange value
    exact Finset.sum_insert (fun h => hb (mem_erase.mp h).2)
  rw [he, add_assoc, value_erase_add w ha, add_comm]

theorem ef1_of_no_envy (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x) {A B : Finset Goods}
    (h : value w B ≤ value w A) : AdditiveEF1 w A B := by
  by_cases hB : B = ∅
  · exact Or.inl hB
  · obtain ⟨x, hx⟩ := Finset.nonempty_iff_ne_empty.mpr hB
    exact Or.inr ⟨x, hx, by have := value_erase_add w hx; linarith [hw x]⟩

open Classical in
noncomputable def maxValue (w : Goods → ℝ) (A : Finset Goods) : ℝ :=
  if h : A.Nonempty then A.sup' h w else 0

omit [DecidableEq Goods] in
theorem weight_le_max (w : Goods → ℝ) {A : Finset Goods} {x : Goods} (hx : x ∈ A) :
    w x ≤ maxValue w A := by
  unfold maxValue
  rw [dif_pos ⟨x, hx⟩]
  exact Finset.le_sup' w hx

omit [DecidableEq Goods] in
theorem max_attained (w : Goods → ℝ) {A : Finset Goods} (hA : A.Nonempty) :
    ∃ x ∈ A, w x = maxValue w A := by
  obtain ⟨x, hx, h⟩ := Finset.exists_max_image A w hA
  refine ⟨x, hx, le_antisymm (weight_le_max w hx) ?_⟩
  unfold maxValue
  rw [dif_pos hA]
  exact Finset.sup'_le hA w h

theorem additiveEF1_iff_max (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x)
    (A B : Finset Goods) : AdditiveEF1 w A B ↔ value w B ≤ value w A + maxValue w B := by
  classical
  by_cases hB : B.Nonempty
  · have hne : B ≠ ∅ := hB.ne_empty
    constructor
    · rintro (he | ⟨x, hx, hx'⟩)
      · exact (hne he).elim
      · linarith [value_erase_add w hx, weight_le_max w hx]
    · intro h
      obtain ⟨x, hx, hmax⟩ := max_attained w hB
      exact Or.inr ⟨x, hx, by linarith [value_erase_add w hx]⟩
  · have he := Finset.not_nonempty_iff_eq_empty.mp hB
    rw [he]
    have hzero : value w ∅ = 0 := by simp [value]
    simp [AdditiveEF1, hzero, maxValue, value_nonneg w hw A]

variable [Fintype Goods]

noncomputable def total (w : Goods → ℝ) : ℝ := value w Finset.univ

def MarketEF1 (w : Goods → ℝ) (A : Finset Goods) : Prop :=
  AdditiveEF1 w A (other A) ∧ AdditiveEF1 w (other A) A

theorem value_partition (w : Goods → ℝ) (A : Finset Goods) :
    value w A + value w (other A) = total w := by
  unfold value other total
  rw [add_comm]
  exact Finset.sum_sdiff (Finset.subset_univ A)

theorem market_ef1_iff_scalar (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x) (A : Finset Goods) :
    MarketEF1 w A ↔
      FairDivisionCore.ScalarMarketEF1 (value w A) (total w)
        (maxValue w A) (maxValue w (other A)) := by
  rw [MarketEF1, additiveEF1_iff_max w hw, additiveEF1_iff_max w hw]
  unfold FairDivisionCore.ScalarMarketEF1
  have h := value_partition w A
  constructor <;> rintro ⟨h₁, h₂⟩ <;> exact ⟨by linarith, by linarith⟩

theorem market_no_envy_at_half (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x) {A : Finset Goods}
    (h : 2 * value w A = total w) : MarketEF1 w A := by
  have he := value_partition w A
  exact ⟨ef1_of_no_envy w hw (by linarith), ef1_of_no_envy w hw (by linarith)⟩

theorem market_crossing (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x)
    {A B : Finset Goods} (h : SingleExchange A B)
    (hlight : 2 * value w A ≤ total w) (hheavy : total w ≤ 2 * value w B) :
    MarketEF1 w A ∨ MarketEF1 w B := by
  obtain ⟨a, ha, b, hb, rfl⟩ := h
  let B := exchange A a b
  have hswap : value w B + w a = value w A + w b := value_after_exchange w ha hb
  have hbA : b ∈ other A := (mem_other b A).mpr hb
  have hbB : b ∈ B := by simp [B, exchange]
  have hA := value_partition w A
  have hB := value_partition w B
  rcases FairDivisionCore.market_crossing_or (value w B) (value w A) (total w)
      (w b) (w a) (hw a) hswap with hs | ht
  · right
    exact ⟨ef1_of_no_envy w hw (by linarith),
      Or.inr ⟨b, hbB, by linarith [value_erase_add w hbB]⟩⟩
  · left
    exact ⟨Or.inr ⟨b, hbA, by linarith [value_erase_add w hbA]⟩,
      ef1_of_no_envy w hw (by linarith)⟩

namespace ExchangePath

theorem has_market_vertex (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x)
    {eligible : Finset Goods → Prop} {n : ℕ} {A B : Finset Goods}
    (h : ExchangePath eligible n A B)
    (hA : 2 * value w A ≤ total w) (hB : total w ≤ 2 * value w B) :
    ∃ C, eligible C ∧ MarketEF1 w C := by
  induction h with
  | nil A hvalid =>
    exact ⟨A, hvalid, market_no_envy_at_half w hw (le_antisymm hA hB)⟩
  | @step n A B C hvalid hex tail ih =>
    by_cases hmid : total w ≤ 2 * value w B
    · rcases market_crossing w hw hex hA hmid with hs | hs
      · exact ⟨A, hvalid, hs⟩
      · exact ⟨B, tail.start, hs⟩
    · exact ih (le_of_lt (lt_of_not_ge hmid)) hB

end ExchangePath

theorem zero_total_envy_free (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x) (h : total w = 0)
    (A : Finset Goods) : value w A = value w (other A) := by
  linarith [value_partition w A, value_nonneg w hw A, value_nonneg w hw (other A)]

theorem simultaneous_even (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x)
    {k : ℕ} (p q : Goods ≃ Fin (2 * k)) :
    ∃ A, A.card = k ∧ (other A).card = k ∧
      RankEF1 p A (other A) ∧ RankEF1 q (other A) A ∧ MarketEF1 w A := by
  obtain ⟨S, hS, hS'⟩ := complementary_ordinal_seed p q
  have hpath := complementary_path_exact p q hS hS'
  have hsum := value_partition w S
  have hmarket : ∃ A, OrdinalFeasible p q A ∧ MarketEF1 w A := by
    by_cases h : 2 * value w S ≤ total w
    · exact hpath.has_market_vertex w hw h (by linarith)
    · exact hpath.reverse.has_market_vertex w hw (by linarith) (le_of_lt (lt_of_not_ge h))
  obtain ⟨A, hA, hM⟩ := hmarket
  obtain ⟨h₁, h₂⟩ := (ordinal_feasibility_iff p q A).mp hA
  have hc := feasible_card_eq p q hA
  have ht := card_allocation A
  rw [card_goods p] at ht
  exact ⟨A, hc, by omega, h₁, h₂, hM⟩

end MarketFairDivision
