import Core
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Data.Finset.Prod
import Mathlib.Algebra.BigOperators.Group.Finset.Sigma
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Tactic.Linarith

set_option autoImplicit false

open Finset
open scoped BigOperators

namespace ProperHats
namespace Upper

/-- Pairs on which the first leaf guesses correctly. -/
noncomputable def leftHit {α : Type*} [DecidableEq α] (U : Finset α) (f : α → α) :
    Finset (α × α) := U.offDiag.filter fun p => f p.2 = p.1

/-- Pairs on which the second leaf guesses correctly. -/
noncomputable def rightHit {α : Type*} [DecidableEq α] (U : Finset α) (g : α → α) :
    Finset (α × α) := U.offDiag.filter fun p => g p.1 = p.2

/-- Both leaves fail, and their colors are distinct elements of U. -/
noncomputable def failurePairs {α : Type*} [DecidableEq α] (U : Finset α) (f g : α → α) :
    Finset (α × α) := U.offDiag.filter fun p => f p.2 ≠ p.1 ∧ g p.1 ≠ p.2

theorem leftHit_card_le {α : Type*} [DecidableEq α]
    (U : Finset α) (f : α → α) : (leftHit U f).card ≤ U.card := by
  apply Finset.card_le_card_of_injOn Prod.snd
  · intro p hp
    exact (Finset.mem_offDiag.mp (Finset.mem_filter.mp hp).1).2.1
  · intro p hp q hq hpq
    apply Prod.ext
    · have hp' := (Finset.mem_filter.mp hp).2
      have hq' := (Finset.mem_filter.mp hq).2
      change f p.2 = p.1 at hp'
      change f q.2 = q.1 at hq'
      exact hp'.symm.trans ((congrArg f hpq).trans hq')
    · exact hpq

theorem rightHit_card_le {α : Type*} [DecidableEq α]
    (U : Finset α) (g : α → α) : (rightHit U g).card ≤ U.card := by
  apply Finset.card_le_card_of_injOn Prod.fst
  · intro p hp
    exact (Finset.mem_offDiag.mp (Finset.mem_filter.mp hp).1).1
  · intro p hp q hq hpq
    apply Prod.ext
    · exact hpq
    · have hp' := (Finset.mem_filter.mp hp).2
      have hq' := (Finset.mem_filter.mp hq).2
      change g p.1 = p.2 at hp'
      change g q.1 = q.2 at hq'
      exact hp'.symm.trans ((congrArg g hpq).trans hq')

/-- At most |U| proper pairs are solved by either individual leaf. -/
theorem failurePairs_count {α : Type*} [DecidableEq α]
    (U : Finset α) (f g : α → α) :
    U.offDiag.card ≤ (failurePairs U f g).card + 2 * U.card := by
  have hcover : U.offDiag ⊆ failurePairs U f g ∪ leftHit U f ∪ rightHit U g := by
    intro p hp
    by_cases hf : f p.2 = p.1
    · exact Finset.mem_union_left _ (Finset.mem_union_right _ (Finset.mem_filter.mpr ⟨hp, hf⟩))
    · by_cases hg : g p.1 = p.2
      · exact Finset.mem_union_right _ (Finset.mem_filter.mpr ⟨hp, hg⟩)
      · exact Finset.mem_union_left _ (Finset.mem_union_left _ (Finset.mem_filter.mpr ⟨hp, hf, hg⟩))
  have h0 := Finset.card_le_card hcover
  have h1 := Finset.card_union_le (failurePairs U f g ∪ leftHit U f) (rightHit U g)
  have h2 := Finset.card_union_le (failurePairs U f g) (leftHit U f)
  have h3 := leftHit_card_le U f
  have h4 := rightHit_card_le U g
  omega

noncomputable def palette {q : Nat} (c : Fin q) : Finset (Fin q) := Finset.univ.erase c

noncomputable def badPairs {r q : Nat} (s : Strategy r q) (i : Fin r) (c : Fin q) :
    Finset (Fin q × Fin q) := failurePairs (palette c) (s.left i c) (s.right i c)

noncomputable def badViews {r q : Nat} (s : Strategy r q) (c : Fin q) : Finset (Views r q) :=
  Fintype.piFinset fun i => badPairs s i c

theorem mem_badPairs {r q : Nat} (s : Strategy r q) (i : Fin r)
    (c : Fin q) (p : Fin q × Fin q) :
    p ∈ badPairs s i c ↔
      (c ≠ p.1 ∧ c ≠ p.2 ∧ p.1 ≠ p.2) ∧
      s.left i c p.2 ≠ p.1 ∧ s.right i c p.1 ≠ p.2 := by
  simp [badPairs, failurePairs, palette, ne_comm]

/-- If every leaf is wrong, a winning strategy must be correct at the root. -/
theorem center_eq_of_bad {r q : Nat} (s : Strategy r q) (hw : Wins s)
    (c : Fin q) (x : Views r q) (hx : x ∈ badViews s c) : s.center x = c := by
  have hb : ∀ i, (c ≠ (x i).1 ∧ c ≠ (x i).2 ∧ (x i).1 ≠ (x i).2) ∧
      s.left i c (x i).2 ≠ (x i).1 ∧ s.right i c (x i).1 ≠ (x i).2 := by
    intro i
    exact (mem_badPairs s i c (x i)).mp (Fintype.mem_piFinset.mp hx i)
  rcases hw c x (fun i => (hb i).1) with h | ⟨i, h | h⟩
  · exact h
  · exact ((hb i).2.1 h).elim
  · exact ((hb i).2.2 h).elim

/-- Count every root color and every all-leaf-failure view, without restricting strategies. -/
theorem strategy_count_bound {r q L : Nat} (s : Strategy r q) (hw : Wins s)
    (hlower : ∀ i c, L ≤ (badPairs s i c).card) :
    q * L ^ r ≤ (q * q - q) ^ r := by
  classical
  let D : Finset (Σ _ : Fin q, Views r q) :=
    Finset.univ.sigma fun c => badViews s c
  let T : Finset (Views r q) :=
    Fintype.piFinset fun _ : Fin r => (Finset.univ : Finset (Fin q)).offDiag
  have hmap : ∀ a ∈ D, a.2 ∈ T := by
    intro a ha
    have hb := (Finset.mem_sigma.mp ha).2
    apply Fintype.mem_piFinset.mpr
    intro i
    have hp := (mem_badPairs s i a.1 (a.2 i)).mp (Fintype.mem_piFinset.mp hb i)
    exact Finset.mem_offDiag.mpr ⟨Finset.mem_univ _, Finset.mem_univ _, hp.1.2.2⟩
  have hinj : (D : Set (Σ _ : Fin q, Views r q)).InjOn (fun a => a.2) := by
    intro a ha b hb hab
    rcases a with ⟨c, x⟩
    rcases b with ⟨d, y⟩
    change x = y at hab
    subst y
    have hc := center_eq_of_bad s hw c x (Finset.mem_sigma.mp ha).2
    have hd := center_eq_of_bad s hw d x (Finset.mem_sigma.mp hb).2
    have hcd : c = d := hc.symm.trans hd
    cases hcd
    rfl
  have hcount : D.card ≤ T.card := Finset.card_le_card_of_injOn (fun a => a.2) hmap hinj
  have hT : T.card = (q * q - q) ^ r := by
    simp [T, Fintype.card_piFinset, Finset.offDiag_card]
  have hD : q * L ^ r ≤ D.card := by
    dsimp only [D]
    rw [Finset.card_sigma]
    calc
      q * L ^ r = ∑ _c : Fin q, L ^ r := by simp
      _ ≤ ∑ c : Fin q, (badViews s c).card := by
        apply Finset.sum_le_sum
        intro c _hc
        rw [badViews, Fintype.card_piFinset]
        calc
          L ^ r = ∏ _i : Fin r, L := by simp
          _ ≤ ∏ i : Fin r, (badPairs s i c).card :=
            Finset.prod_le_prod' fun i _hi => hlower i c
  exact hD.trans (hcount.trans_eq hT)

/-- For any q ≥ 4, every blade leaves at least (q - 1)(q - 4) proper pairs unsolved. -/
theorem general_badPairs_lower {r q : Nat} (hq : 4 ≤ q)
    (s : Strategy r q) (i : Fin r) (c : Fin q) :
    (q - 1) * (q - 4) ≤ (badPairs s i c).card := by
  have h := failurePairs_count (palette c) (s.left i c) (s.right i c)
  have hp : (palette c).card = q - 1 := by simp [palette]
  rw [Finset.offDiag_card, hp] at h
  change (q - 1) * (q - 1) - (q - 1) ≤
    (badPairs s i c).card + 2 * (q - 1) at h
  have hthree : 3 ≤ q - 1 := by omega
  have hmul : q - 1 ≤ (q - 1) * (q - 1) := by nlinarith
  have hcancel := Nat.sub_add_cancel hmul
  have hshift : q - 1 = (q - 4) + 3 := by omega
  rw [hshift] at h hcancel ⊢
  nlinarith

/-- A universal counting obstruction for every finite windmill and every strategy. -/
theorem general_count_bound {r q : Nat} (hq : 4 ≤ q)
    (s : Strategy r q) (hw : Wins s) :
    q * ((q - 1) * (q - 4)) ^ r ≤ (q * (q - 1)) ^ r := by
  have hbase : q * (q - 1) = q * q - q := by simp [Nat.mul_sub_left_distrib]
  rw [hbase]
  exact strategy_count_bound s hw (general_badPairs_lower hq s)

theorem badPairs_six_lower {r : Nat} (s : Strategy r 6) (i : Fin r) (c : Fin 6) :
    10 ≤ (badPairs s i c).card := by
  have h := failurePairs_count (palette c) (s.left i c) (s.right i c)
  have hp : (palette c).card = 5 := by simp [palette]
  rw [Finset.offDiag_card, hp] at h
  change 5 * 5 - 5 ≤ (badPairs s i c).card + 2 * 5 at h
  omega

theorem badPairs_seven_lower {r : Nat} (s : Strategy r 7) (i : Fin r) (c : Fin 7) :
    18 ≤ (badPairs s i c).card := by
  have h := failurePairs_count (palette c) (s.left i c) (s.right i c)
  have hp : (palette c).card = 6 := by simp [palette]
  rw [Finset.offDiag_card, hp] at h
  change 6 * 6 - 6 ≤ (badPairs s i c).card + 2 * 6 at h
  omega

theorem failurePairs_mono {α : Type*} [DecidableEq α]
    (U V : Finset α) (f g : α → α) (h : U ⊆ V) :
    failurePairs U f g ⊆ failurePairs V f g := by
  intro p hp
  rcases Finset.mem_filter.mp hp with ⟨hpair, hfail⟩
  exact Finset.mem_filter.mpr ⟨Finset.offDiag_mono h hpair, hfail⟩

/-- Simultaneous failure of both leaves for two root colors. -/
noncomputable def commonFailures {α : Type*} [DecidableEq α]
    (U : Finset α) (f₀ g₀ f₁ g₁ : α → α) : Finset (α × α) :=
  (failurePairs U f₀ g₀).filter fun p => f₁ p.2 ≠ p.1 ∧ g₁ p.1 ≠ p.2

theorem commonFailures_count {α : Type*} [DecidableEq α]
    (U : Finset α) (f₀ g₀ f₁ g₁ : α → α) :
    U.offDiag.card ≤ (commonFailures U f₀ g₀ f₁ g₁).card + 4 * U.card := by
  have hcover : failurePairs U f₀ g₀ ⊆
      commonFailures U f₀ g₀ f₁ g₁ ∪ leftHit U f₁ ∪ rightHit U g₁ := by
    intro p hp
    have hproper := (Finset.mem_filter.mp hp).1
    by_cases hf : f₁ p.2 = p.1
    · exact Finset.mem_union_left _
        (Finset.mem_union_right _ (Finset.mem_filter.mpr ⟨hproper, hf⟩))
    · by_cases hg : g₁ p.1 = p.2
      · exact Finset.mem_union_right _ (Finset.mem_filter.mpr ⟨hproper, hg⟩)
      · exact Finset.mem_union_left _
          (Finset.mem_union_left _ (Finset.mem_filter.mpr ⟨hp, hf, hg⟩))
  have h0 := failurePairs_count U f₀ g₀
  have h1 := Finset.card_le_card hcover
  have h2 := Finset.card_union_le
    (commonFailures U f₀ g₀ f₁ g₁ ∪ leftHit U f₁) (rightHit U g₁)
  have h3 := Finset.card_union_le (commonFailures U f₀ g₀ f₁ g₁) (leftHit U f₁)
  have h4 := leftHit_card_le U f₁
  have h5 := rightHit_card_le U g₁
  omega

noncomputable def eightPalette : Finset (Fin 8) := (Finset.univ.erase 0).erase 1

theorem eightPalette_card : eightPalette.card = 6 := by
  norm_num [eightPalette]

theorem eightPalette_subset_zero : eightPalette ⊆ palette (0 : Fin 8) := by
  intro a ha
  exact (Finset.mem_erase.mp ha).2

theorem eightPalette_subset_one : eightPalette ⊆ palette (1 : Fin 8) := by
  intro a ha
  exact Finset.mem_erase.mpr ⟨(Finset.mem_erase.mp ha).1, Finset.mem_univ _⟩

/-- Six common-failure pairs survive any four leaf rules on the six-color palette. -/
theorem commonFailures_eight_lower (f₀ g₀ f₁ g₁ : Fin 8 → Fin 8) :
    6 ≤ (commonFailures eightPalette f₀ g₀ f₁ g₁).card := by
  have h := commonFailures_count eightPalette f₀ g₀ f₁ g₁
  rw [Finset.offDiag_card, eightPalette_card] at h
  omega

end Upper

theorem not_solvable_six_one : ¬ Solvable 1 6 := by
  rintro ⟨s, hw⟩
  have h := Upper.strategy_count_bound s hw (Upper.badPairs_six_lower s)
  norm_num at h

theorem not_solvable_seven_two : ¬ Solvable 2 7 := by
  rintro ⟨s, hw⟩
  have h := Upper.strategy_count_bound s hw (Upper.badPairs_seven_lower s)
  norm_num at h

/-- With eight colors, no finite number of triangular petals admits a winning strategy. -/
theorem not_solvable_eight (r : Nat) : ¬ Solvable r 8 := by
  classical
  rintro ⟨s, hw⟩
  have hn (i : Fin r) :
      (Upper.commonFailures Upper.eightPalette
        (s.left i 0) (s.right i 0) (s.left i 1) (s.right i 1)).Nonempty := by
    apply Finset.card_pos.mp
    have h := Upper.commonFailures_eight_lower
      (s.left i 0) (s.right i 0) (s.left i 1) (s.right i 1)
    omega
  let x : Views r 8 := fun i => Classical.choose (hn i)
  have hx (i : Fin r) : x i ∈ Upper.commonFailures Upper.eightPalette
      (s.left i 0) (s.right i 0) (s.left i 1) (s.right i 1) :=
    Classical.choose_spec (hn i)
  have hx₀ : x ∈ Upper.badViews s (0 : Fin 8) := by
    apply Fintype.mem_piFinset.mpr
    intro i
    exact Upper.failurePairs_mono Upper.eightPalette (Upper.palette (0 : Fin 8))
      (s.left i 0) (s.right i 0) Upper.eightPalette_subset_zero
      (Finset.mem_filter.mp (hx i)).1
  have hx₁ : x ∈ Upper.badViews s (1 : Fin 8) := by
    apply Fintype.mem_piFinset.mpr
    intro i
    have hi := Finset.mem_filter.mp (hx i)
    have hp : x i ∈ Upper.failurePairs Upper.eightPalette (s.left i 1) (s.right i 1) :=
      Finset.mem_filter.mpr ⟨(Finset.mem_filter.mp hi.1).1, hi.2⟩
    exact Upper.failurePairs_mono Upper.eightPalette (Upper.palette (1 : Fin 8))
      (s.left i 1) (s.right i 1) Upper.eightPalette_subset_one hp
  have h₀ := Upper.center_eq_of_bad s hw (0 : Fin 8) x hx₀
  have h₁ := Upper.center_eq_of_bad s hw (1 : Fin 8) x hx₁
  have h01 : (0 : Fin 8) = 1 := h₀.symm.trans h₁
  norm_num at h01

end ProperHats

-- Audit every declaration created in this module, including compiler auxiliaries.
open Lean in
run_cmd do
  let env ← getEnv
  let mut entries : Array (String × Array String) := #[]
  for (name, _) in env.constants.map₂.toList do
    let axioms ← Lean.collectAxioms name
    entries := entries.push (name.toString, axioms.map Name.toString)
  logInfo m!"EDEG_KERNEL_AXIOMS: {(toJson entries).compress}"
