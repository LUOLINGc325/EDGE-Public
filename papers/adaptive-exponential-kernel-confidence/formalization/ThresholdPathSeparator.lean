import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

namespace AdaptiveExponentialKernelConfidenceResearchProof1

theorem threshold_path_separator (n : ℕ) (pos : ℕ → Bool) (L U : ℕ → ℝ)
    (hL : L 0 = 0) (hU : U 0 = 1)
    (lo : ∀ i < n, L (i+1) = if pos i then (L i+U i)/2 else L i)
    (hi : ∀ i < n, U (i+1) = if pos i then U i else (L i+U i)/2) :
    ∀ i < n, ((L i+U i)/2 < (L n+U n)/2 ↔ pos i = true) := by
  have positive_width : ∀ j ≤ n, L j < U j := by
    intro j
    induction j with
    | zero => intro _; rw [hL, hU]; exact zero_lt_one
    | succ k ih =>
        intro hkn
        have hk : k < n := Nat.lt_of_succ_le hkn
        have hw := ih (Nat.le_of_lt hk)
        rw [lo k hk, hi k hk]
        split_ifs <;> linarith
  have nested : ∀ i j, i ≤ j → j ≤ n → L i ≤ L j ∧ U j ≤ U i := by
    intro i j
    induction j with
    | zero =>
        intro hij _
        rw [Nat.eq_zero_of_le_zero hij]
        exact ⟨le_rfl, le_rfl⟩
    | succ k ih =>
        intro hij hkn
        rcases Nat.eq_or_lt_of_le hij with heq | hlt
        · rw [heq]
          exact ⟨le_rfl, le_rfl⟩
        have hk : k < n := Nat.lt_of_succ_le hkn
        have hw := positive_width k (Nat.le_of_lt hk)
        obtain ⟨hleft, hright⟩ := ih (Nat.le_of_lt_succ hlt) (Nat.le_of_lt hk)
        rw [lo k hk, hi k hk]
        split_ifs <;> constructor <;> linarith
  intro i hn
  obtain ⟨hleft, hright⟩ := nested (i+1) n (Nat.succ_le_of_lt hn) le_rfl
  have hw := positive_width n le_rfl
  by_cases hp : pos i = true
  · rw [lo i hn, if_pos hp] at hleft
    simp only [hp, iff_true]
    linarith
  · rw [hi i hn, if_neg hp] at hright
    have hmid : ¬ (L i + U i) / 2 < (L n + U n) / 2 := by
      intro h
      linarith
    simp [hp, hmid]

end AdaptiveExponentialKernelConfidenceResearchProof1
