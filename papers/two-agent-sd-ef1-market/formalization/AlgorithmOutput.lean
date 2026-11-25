import WeakRankings

noncomputable section

open Finset

namespace MarketFairDivision

variable {Goods : Type*} [Fintype Goods] [DecidableEq Goods] {m : ℕ}

theorem highest_ranked_witness (r : Goods ≃ Fin m) {A B : Finset Goods}
    (h : RankEF1 r A B) {g : Goods} (hg : g ∈ B)
    (hmin : ∀ x ∈ B, (r g).val ≤ (r x).val) :
    ∀ l ≤ m, (B.erase g ∩ rankPrefix r l).card ≤ (A ∩ rankPrefix r l).card := by
  intro l hl
  rw [erase_inter_eq]
  by_cases he : (B ∩ rankPrefix r l).Nonempty
  · obtain ⟨x, hx⟩ := he
    have hxp := mem_inter.mp hx
    have hgp : g ∈ rankPrefix r l := (mem_prefix r l g).mpr
      ((hmin x hxp.1).trans_lt ((mem_prefix r l x).mp hxp.2))
    have hc := Finset.card_erase_add_one (mem_inter.mpr ⟨hg, hgp⟩)
    have hd := (prefix_witness_equivalence r A B).mp h l hl
    omega
  · simp [Finset.not_nonempty_iff_eq_empty.mp he]

omit [Fintype Goods] in
theorem maximum_weight_witness (w : Goods → ℝ) {A B : Finset Goods}
    (h : AdditiveEF1 w A B) {g : Goods} (hg : g ∈ B)
    (hmax : ∀ x ∈ B, w x ≤ w g) : value w (B.erase g) ≤ value w A := by
  rcases h with he | ⟨x, hx, hx'⟩
  · simp [he] at hg
  · linarith [value_erase_add w hx, value_erase_add w hg, hmax x hx]

inductive EnumeratedPath (eligible : Finset Goods → Prop) :
    ℕ → Finset Goods → Finset Goods → List (Finset Goods) → Prop
  | last (A : Finset Goods) : eligible A → EnumeratedPath eligible 0 A A [A]
  | prepend {n : ℕ} {A B C : Finset Goods} {rest : List (Finset Goods)} :
      eligible A → SingleExchange A B → EnumeratedPath eligible n B C (B :: rest) →
      EnumeratedPath eligible (n + 1) A C (A :: B :: rest)

omit [Fintype Goods] in
theorem ExchangePath.enumerates {eligible : Finset Goods → Prop}
    {n : ℕ} {A B : Finset Goods} (h : ExchangePath eligible n A B) :
    ∃ rest, EnumeratedPath eligible n A B (A :: rest) := by
  induction h with
  | nil A hA => exact ⟨[], EnumeratedPath.last A hA⟩
  | step hA hAB _ ih =>
    obtain ⟨rest, ht⟩ := ih
    exact ⟨_ :: rest, EnumeratedPath.prepend hA hAB ht⟩

namespace EnumeratedPath

variable {eligible : Finset Goods → Prop} {n : ℕ} {A B : Finset Goods} {xs : List (Finset Goods)}

omit [Fintype Goods] in
theorem length (h : EnumeratedPath eligible n A B xs) : xs.length = n + 1 := by
  induction h with
  | last _ _ => rfl
  | prepend _ _ _ ih => simp only [List.length_cons] at *; omega

omit [Fintype Goods] in
theorem member_feasible (h : EnumeratedPath eligible n A B xs) {C : Finset Goods}
    (hC : C ∈ xs) : eligible C := by
  induction h with
  | last A hA =>
    have he : C = A := List.mem_singleton.mp hC
    exact he.symm ▸ hA
  | prepend hA _ _ ih =>
    rcases List.mem_cons.mp hC with he | ht
    · exact he.symm ▸ hA
    · exact ih ht

omit [Fintype Goods] in
theorem start_member (h : EnumeratedPath eligible n A B xs) : A ∈ xs := by
  cases h <;> simp

omit [Fintype Goods] in
theorem finish_member (h : EnumeratedPath eligible n A B xs) : B ∈ xs := by
  induction h with
  | last _ _ => simp
  | prepend _ _ _ ih => exact List.mem_cons_of_mem _ ih

end EnumeratedPath

def StrictHalfCrossing (w : Goods → ℝ) (A B : Finset Goods) : Prop :=
  (2 * value w A < total w ∧ total w < 2 * value w B) ∨
    (2 * value w B < total w ∧ total w < 2 * value w A)

open Classical in
noncomputable def firstHalf (w : Goods → ℝ) : List (Finset Goods) → Option (Finset Goods)
  | [] => none
  | A :: rest => if 2 * value w A = total w then some A else firstHalf w rest

open Classical in
noncomputable def firstMarketCrossing (w : Goods → ℝ) :
    List (Finset Goods) → Option (Finset Goods)
  | [] => none
  | A :: tail =>
    match tail with
    | [] => none
    | B :: _ =>
      if StrictHalfCrossing w A B then
        if MarketEF1 w A then some A else some B
      else firstMarketCrossing w tail

noncomputable def selectMarket (w : Goods → ℝ) (xs : List (Finset Goods)) : Option (Finset Goods) :=
  match firstHalf w xs with
  | some A => some A
  | none => firstMarketCrossing w xs

omit [DecidableEq Goods] in
theorem firstHalf_empty_iff (w : Goods → ℝ) (xs : List (Finset Goods)) :
    firstHalf w xs = none ↔ ∀ A ∈ xs, 2 * value w A ≠ total w := by
  classical
  induction xs with
  | nil => simp [firstHalf]
  | cons A rest ih =>
    by_cases he : 2 * value w A = total w <;> simp [firstHalf, he, ih]

omit [DecidableEq Goods] in
theorem firstHalf_correct (w : Goods → ℝ) {xs : List (Finset Goods)} {A : Finset Goods}
    (h : firstHalf w xs = some A) : A ∈ xs ∧ 2 * value w A = total w := by
  classical
  induction xs with
  | nil => simp [firstHalf] at h
  | cons B rest ih =>
    by_cases he : 2 * value w B = total w
    · have hBA : B = A := by simpa [firstHalf, he] using h
      subst B
      exact ⟨List.mem_cons_self, he⟩
    · obtain ⟨hm, ha⟩ := ih (by simpa [firstHalf, he] using h)
      exact ⟨List.mem_cons_of_mem B hm, ha⟩

theorem firstCrossing_correct (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x)
    {eligible : Finset Goods → Prop} {n : ℕ} {A B : Finset Goods} {xs : List (Finset Goods)}
    (h : EnumeratedPath eligible n A B xs)
    (hends : StrictHalfCrossing w A B) (hne : ∀ C ∈ xs, 2 * value w C ≠ total w) :
    ∃ C ∈ xs, firstMarketCrossing w xs = some C ∧ MarketEF1 w C := by
  classical
  induction h with
  | last A _ =>
    rcases hends with h₁ | h₁ <;> linarith [h₁.1, h₁.2]
  | @prepend n A B C xs hA hAB hrest ih =>
    by_cases hex : StrictHalfCrossing w A B
    · have hm : MarketEF1 w A ∨ MarketEF1 w B := by
        rcases hex with ⟨h₁, h₂⟩ | ⟨h₁, h₂⟩
        · exact market_crossing w hw hAB h₁.le h₂.le
        · exact (market_crossing w hw hAB.reverse h₁.le h₂.le).symm
      by_cases hmA : MarketEF1 w A
      · exact ⟨A, List.mem_cons_self, by simp [firstMarketCrossing, hex, hmA], hmA⟩
      · have hmB := hm.resolve_left hmA
        exact ⟨B, List.mem_cons_of_mem A List.mem_cons_self,
          by simp [firstMarketCrossing, hex, hmA], hmB⟩
    · have hB := hne B (List.mem_cons_of_mem A List.mem_cons_self)
      have hend : StrictHalfCrossing w B C := by
        unfold StrictHalfCrossing at *
        rcases hends with ⟨h₁, h₂⟩ | ⟨h₁, h₂⟩
        · have hb : 2 * value w B < total w := by
            by_contra! hh
            exact hex (Or.inl ⟨h₁, lt_of_le_of_ne hh (Ne.symm hB)⟩)
          exact Or.inl ⟨hb, h₂⟩
        · have hb : total w < 2 * value w B := by
            by_contra! hh
            exact hex (Or.inr ⟨lt_of_le_of_ne hh hB, h₂⟩)
          exact Or.inr ⟨h₁, hb⟩
      obtain ⟨D, hd, he, hm⟩ := ih hend (fun x hx => hne x (List.mem_cons_of_mem A hx))
      refine ⟨D, List.mem_cons_of_mem A hd, ?_, hm⟩
      change (if StrictHalfCrossing w A B then
        if MarketEF1 w A then some A else some B
        else firstMarketCrossing w (B :: xs)) = some D
      exact (if_neg hex).trans he

theorem complementary_market_selection (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x)
    {eligible : Finset Goods → Prop} {n : ℕ} {A : Finset Goods} {xs : List (Finset Goods)}
    (h : EnumeratedPath eligible n A (other A) xs) :
    ∃ C ∈ xs, selectMarket w xs = some C ∧ eligible C ∧ MarketEF1 w C := by
  classical
  cases he : firstHalf w xs with
  | some C =>
    obtain ⟨hc, hv⟩ := firstHalf_correct w he
    exact ⟨C, hc, by simp [selectMarket, he], h.member_feasible hc, market_no_envy_at_half w hw hv⟩
  | none =>
    have hne := (firstHalf_empty_iff w xs).mp he
    have hA := hne A h.start_member
    have hother := value_partition w A
    have hstraddle : StrictHalfCrossing w A (other A) := by
      rcases lt_or_gt_of_ne hA with hl | hh
      · exact Or.inl ⟨hl, by linarith⟩
      · exact Or.inr ⟨by linarith, hh⟩
    obtain ⟨C, hc, hchoice, hm⟩ := firstCrossing_correct w hw h hstraddle hne
    exact ⟨C, hc, by simp [selectMarket, he, hchoice], h.member_feasible hc, hm⟩

theorem even_algorithm_returns_valid_allocation (w : Goods → ℝ) (hw : ∀ x, 0 ≤ w x)
    {k : ℕ} (p q : Goods ≃ Fin (2 * k)) :
    ∃ S xs A, EnumeratedPath (OrdinalFeasible p q) k S (other S) xs ∧
      xs.length = k + 1 ∧ A ∈ xs ∧ selectMarket w xs = some A ∧
      RankEF1 p A (other A) ∧ RankEF1 q (other A) A ∧ MarketEF1 w A := by
  obtain ⟨S, hS, hS'⟩ := complementary_ordinal_seed p q
  obtain ⟨rest, htrace⟩ := (complementary_path_exact p q hS hS').enumerates
  obtain ⟨A, hm, hchoice, hfeas, hmarket⟩ := complementary_market_selection w hw htrace
  obtain ⟨h1, h2⟩ := (ordinal_feasibility_iff p q A).mp hfeas
  exact ⟨S, S :: rest, A, htrace, htrace.length, hm, hchoice, h1, h2, hmarket⟩

end MarketFairDivision
