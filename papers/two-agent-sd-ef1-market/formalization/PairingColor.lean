import Mathlib.GroupTheory.Perm.Cycle.Basic
import Mathlib.Data.Fintype.EquivFin

namespace MarketFairDivision

/-- Two fixed-point-free pairings on the same finite type admit a common
two-coloring with opposite colors within every pair. -/
theorem exists_pair_coloring {α : Type*} [Finite α] (p q : Equiv.Perm α)
    (hp : ∀ x, p (p x) = x) (hq : ∀ x, q (q x) = x)
    (fp : ∀ x, p x ≠ x) (fq : ∀ x, q x ≠ x) :
    ∃ c : α → Bool, (∀ x, c (p x) = !(c x)) ∧ (∀ x, c (q x) = !(c x)) := by
  classical
  let s : Equiv.Perm α := p * q
  have bend (x : α) : s (p (s x)) = p x := by
    change p (q (p (p (q x)))) = p x
    rw [hp (q x), hq x]
  have avoid : ∀ n : ℕ, ∀ x : α, (s ^ n) x ≠ p x := by
    intro n
    induction n using Nat.twoStepInduction with
    | zero =>
      intro x
      simpa only [pow_zero, Equiv.Perm.one_apply] using (fp x).symm
    | one =>
      intro x hx
      apply fq x
      apply p.injective
      simpa only [pow_one] using hx
    | more n ih _ =>
      intro x hx
      apply ih (s x)
      apply s.injective
      rw [bend x]
      simpa only [pow_succ' s (n + 1), pow_succ s n,
        Equiv.Perm.mul_apply] using hx
  let S := Equiv.Perm.SameCycle.setoid s
  let Q := Quotient S
  letI : Fintype Q := Fintype.ofFinite Q
  let rank (x : α) : Fin (Fintype.card Q) :=
    (Fintype.equivFin Q) (Quotient.mk S x)
  have stable (x : α) : rank (s x) = rank x := by
    have h : Quotient.mk S (s x) = Quotient.mk S x :=
      Quotient.sound (show s.SameCycle (s x) x from
        Equiv.Perm.sameCycle_apply_left.mpr (Equiv.Perm.SameCycle.refl s x))
    exact congrArg (fun z : Q => (Fintype.equivFin Q) z) h
  have separate (x : α) : rank x ≠ rank (p x) := by
    intro h
    have he : Quotient.mk S x = Quotient.mk S (p x) :=
      (Fintype.equivFin Q).injective h
    have hc : s.SameCycle x (p x) := Quotient.exact he
    obtain ⟨n, hn⟩ := hc.exists_nat_pow_eq
    exact avoid n x hn
  have reverse_cmp (x : α) :
      decide (rank (p x) < rank x) = !(decide (rank x < rank (p x))) := by
    rcases lt_or_gt_of_ne (separate x) with h | h <;>
      simp [h, not_lt_of_ge h.le]
  refine ⟨fun x => decide (rank x < rank (p x)), ?_, ?_⟩
  · intro x
    simpa only [hp x] using reverse_cmp x
  · intro x
    have h₁ : rank (q x) = rank (p x) := by
      have h := stable (q x)
      change rank (p (q (q x))) = rank (q x) at h
      rw [hq x] at h
      exact h.symm
    have h₂ : rank (p (q x)) = rank x := stable x
    simpa only [h₁, h₂] using reverse_cmp x

end MarketFairDivision
