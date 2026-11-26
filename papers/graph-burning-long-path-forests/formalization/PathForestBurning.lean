import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic.Push
import Mathlib.Algebra.Order.BigOperators.Group.Finset

open scoped BigOperators

namespace PathForestBurning

/-- Choosing or skipping the successive powers of two represents
every integer below the next power of two. -/
theorem dyadic_reachability (k t : ℕ) (ht : t < 2^k) :
    ∃ bits : Fin k → Bool, (∑ i, if bits i then 2^i.val else 0) = t := by
  induction k generalizing t with
  | zero =>
    have hz : t = 0 := by simpa using ht
    exact ⟨fun i => i.elim0, by simp [hz]⟩
  | succ k ih =>
    rw [pow_succ] at ht
    by_cases h : t < 2^k
    · obtain ⟨bits, hbits⟩ := ih t h
      refine ⟨Fin.lastCases false bits, ?_⟩
      rw [Fin.sum_univ_castSucc]
      simpa using hbits
    · obtain ⟨bits, hbits⟩ := ih (t - 2^k) (by omega)
      refine ⟨Fin.lastCases true bits, ?_⟩
      rw [Fin.sum_univ_castSucc]
      simp [hbits]
      omega

/-- Three dyadic selections attain every integer up to three times the
largest single dyadic selection. -/
theorem three_dyadic_reachability (k t : ℕ) (ht : t ≤ 3*(2^k - 1)) :
    ∃ bits : Fin 3 → Fin k → Bool,
      (∑ j, ∑ i, if bits j i then 2^i.val else 0) = t := by
  let D := 2^k - 1
  have hp : 0 < 2^k := Nat.pow_pos (by decide)
  let s₀ := min t D
  let s₁ := min (t - s₀) D
  let s₂ := t - s₀ - s₁
  have h₀ : s₀ < 2^k := by dsimp [s₀, D]; omega
  have h₁ : s₁ < 2^k := by dsimp [s₁, D]; omega
  have h₂ : s₂ < 2^k := by dsimp [s₂, s₁, s₀, D]; omega
  obtain ⟨b₀, hb₀⟩ := dyadic_reachability k s₀ h₀
  obtain ⟨b₁, hb₁⟩ := dyadic_reachability k s₁ h₁
  obtain ⟨b₂, hb₂⟩ := dyadic_reachability k s₂ h₂
  let bits : Fin 3 → Fin k → Bool :=
    fun j => if j = 0 then b₀ else if j = 1 then b₁ else b₂
  refine ⟨bits, ?_⟩
  have hs : s₀ + s₁ + s₂ = t := by dsimp [s₂, s₁, s₀]; omega
  simp [Fin.sum_univ_three, bits, hb₀, hb₁, hb₂, hs]

/-- If a bank's even range is at least h-1+debt, an odd toggle h turns
the even range into every offset in the interval starting at h-1. -/
theorem bank_offsets (D h debt target : ℕ) (hh : h % 2 = 1)
    (hrange : h - 1 + debt ≤ 2*D) (htarget : target ≤ debt) :
    ∃ u ≤ D, ∃ toggle : Bool,
      2*u + (if toggle then h else 0) = h - 1 + target := by
  let z := h - 1 + target
  by_cases hz : z % 2 = 0
  · exact ⟨z / 2, by omega, false, by simp [← show z = h - 1 + target from rfl]; omega⟩
  · have hhz : h ≤ z := by omega
    exact ⟨(z-h) / 2, by omega, true, by simp [← show z = h - 1 + target from rfl]; omega⟩

/-- Prefix corrections act locally: each interior boundary adds its
correction to the component on the left and subtracts it on the right. -/
theorem correct_adjacent_prefix (target₀ target₁ cut₀ cut₁ : ℤ)
    :
    (cut₁ - cut₀) + (target₁ - cut₁) - (target₀ - cut₀) = target₁ - target₀ := by
  omega

/-- The greedy prefix cut leaves a deficit smaller than the largest
allowable item weight. The next item, if any, would overshoot. -/
theorem bounded_prefix_deficit (items : List ℕ) (target W : ℕ) (hW : 0 < W)
    (hitems : ∀ a ∈ items, a ≤ W) (htarget : target ≤ items.sum) :
    ∃ pre post : List ℕ, items = pre ++ post ∧ pre.sum ≤ target ∧
      target - pre.sum < W ∧ ∀ a, post.head? = some a → target < pre.sum + a := by
  induction items generalizing target with
  | nil =>
    have hz : target = 0 := by simpa using htarget
    subst target
    exact ⟨[], [], by simp [hW]⟩
  | cons a items ih =>
    by_cases h : target < a
    · refine ⟨[], a :: items, by simp, by simp, ?_, ?_⟩
      · have ha := hitems a (by simp)
        simpa using h.trans_le ha
      · intro b hb
        simp at hb
        simpa [← hb] using h
    · have ht : target - a ≤ items.sum := by simp at htarget; omega
      have hi : ∀ z ∈ items, z ≤ W := fun z hz => hitems z (by simp [hz])
      obtain ⟨pre, post, heq, hpre, hdef, hhead⟩ := ih (target-a) hi ht
      refine ⟨a :: pre, post, ?_, ?_, ?_, ?_⟩
      · simp [heq]
      · simp
        omega
      · simp
        omega
      · intro b hb
        have hz := hhead b hb
        simp
        omega

/-- Centers of ordered disjoint tiles are separated by more than the
ignition-time gap of their two radii. -/
theorem disjoint_tiles_separate_ignitions (left right r s : ℕ)
    (disjoint : left + (2*r+1) ≤ right) :
    r - s < (right+s)-(left+r) ∧ s-r < (right+s)-(left+r) := by
  constructor <;> omega

/-- At most twice the number of used positions are forbidden lower
endpoints. There is therefore a fresh pair with the prescribed gap. -/
theorem exists_unused_pair (used : Finset ℕ) (U m gap : ℕ)
    (hc : used.card ≤ U) (hm : 4*U + 2 ≤ m)
    (hgap : 0 < gap) (hd : gap ≤ m/2) :
    ∃ a, a ≤ 2*U ∧ a < a+gap ∧ a+gap < m ∧ a ∉ used ∧ a+gap ∉ used := by
  let domain := Finset.range (2*U+1)
  let blocked := domain.filter (fun a => a+gap ∈ used)
  have hblocked : blocked.card ≤ used.card := by
    have hsub : blocked.image (fun a => a+gap) ⊆ used := by
      intro a ha
      obtain ⟨b, hb, rfl⟩ := Finset.mem_image.mp ha
      exact (Finset.mem_filter.mp hb).2
    have hi : Function.Injective (fun a : ℕ => a+gap) :=
      fun _ _ h => Nat.add_right_cancel h
    rw [← Finset.card_image_of_injective blocked hi]
    exact Finset.card_le_card hsub
  have he : ∃ a ∈ domain, a ∉ used ∪ blocked := by
    by_contra h
    push_neg at h
    have hs := Finset.card_le_card (show domain ⊆ used ∪ blocked from h)
    have hu := Finset.card_union_le used blocked
    have hdom : domain.card = 2*U+1 := Finset.card_range _
    omega
  obtain ⟨a, ha, hfree⟩ := he
  have haU : a ≤ 2*U := by have h := Finset.mem_range.mp ha; omega
  refine ⟨a, haU, by omega, by omega, ?_, ?_⟩
  · exact fun h => hfree (Finset.mem_union_left _ h)
  · intro h
    exact hfree (Finset.mem_union_right _ (Finset.mem_filter.mpr ⟨ha, h⟩))

#print axioms dyadic_reachability
#print axioms three_dyadic_reachability
#print axioms bank_offsets
#print axioms correct_adjacent_prefix
#print axioms bounded_prefix_deficit
#print axioms disjoint_tiles_separate_ignitions
#print axioms exists_unused_pair

end PathForestBurning
