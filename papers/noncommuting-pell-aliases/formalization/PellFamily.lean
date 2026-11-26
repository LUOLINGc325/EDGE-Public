import Mathlib.Data.Int.Basic
import Mathlib.Tactic.Ring
import Lean.Elab.Tactic.Omega

namespace NoncommutingPellAliases

/-- The negative Pell iterator on ℤ²: p0 = (1,1),
    p(n+1) = (3*l + 4*k, 2*l + 3*k) for p = (l,k). -/
def pellIter : ℕ → ℤ × ℤ
  | 0 => (1, 1)
  | n + 1 =>
    let p := pellIter n
    (3 * p.1 + 4 * p.2, 2 * p.1 + 3 * p.2)

/-- The defining Pell relation l² − 2*k² = −1 is preserved by the iterator. -/
theorem pellIter_invariant (n : ℕ) :
    (pellIter n).1 ^ 2 - 2 * (pellIter n).2 ^ 2 = -1 := by
  induction n with
  | zero => norm_num [pellIter]
  | succ n ih =>
    simp only [pellIter]
    generalize h : pellIter n = p at ih ⊢
    obtain ⟨l, k⟩ := p
    simp only [Prod.fst, Prod.snd] at ih ⊢
    -- (3l+4k)² - 2(2l+3k)² = l² - 2k²
    calc
      _ = l ^ 2 - 2 * k ^ 2 := by ring
      _ = -1 := ih

/-- Both coordinates remain at least 1. -/
theorem pellIter_coords_pos (n : ℕ) :
    1 ≤ (pellIter n).1 ∧ 1 ≤ (pellIter n).2 := by
  induction n with
  | zero => simp [pellIter]
  | succ n ih =>
    simp only [pellIter]
    generalize h : pellIter n = p at ih ⊢
    obtain ⟨l, k⟩ := p
    simp only [Prod.fst, Prod.snd] at ih ⊢
    omega

/-- The first coordinate is strictly increasing along the iterator. -/
theorem pellIter_first_strictMono :
    StrictMono fun n => (pellIter n).1 := by
  apply strictMono_nat_of_lt_succ
  intro n
  simp only [pellIter]
  generalize h : pellIter n = p
  obtain ⟨l, k⟩ := p
  simp only [Prod.fst, Prod.snd]
  have hpos := pellIter_coords_pos n
  rw [h] at hpos
  simp only [Prod.fst, Prod.snd] at hpos
  obtain ⟨hl, hk⟩ := hpos
  omega

/-- Strict increase of the first coordinate as an explicit inequality. -/
theorem pellIter_first_lt_succ (n : ℕ) :
    (pellIter n).1 < (pellIter (n + 1)).1 := by
  have := pellIter_first_strictMono (Nat.lt_succ_self n)
  exact this

/-- In particular the first coordinates are all distinct, hence the iterator
    yields arbitrarily many distinct solutions of the negative Pell equation. -/
theorem pellIter_injective :
    Function.Injective fun n => pellIter n := by
  intro m n h
  have h1 : (pellIter m).1 = (pellIter n).1 := congrArg Prod.fst h
  exact pellIter_first_strictMono.injective h1

/-- The published claim: for every n, pellIter n is an integer solution of
    ℓ² − 2k² = −1 with both coordinates ≥ 1, and these solutions are pairwise
    distinct (exactly: the family is injective). -/
theorem pell_family_spec (n : ℕ) :
    (pellIter n).1 ^ 2 - 2 * (pellIter n).2 ^ 2 = -1 ∧
      1 ≤ (pellIter n).1 ∧ 1 ≤ (pellIter n).2 :=
  ⟨pellIter_invariant n, pellIter_coords_pos n⟩

end NoncommutingPellAliases
