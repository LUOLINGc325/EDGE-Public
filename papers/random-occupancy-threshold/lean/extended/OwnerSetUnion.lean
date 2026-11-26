import OwnerOccupancyLaw
import Mathlib.Data.Finset.Powerset

open scoped BigOperators

namespace TwoColorNullity.Occupancy

/-- Union over sets of size below a cutoff using the binomial count at each size. -/
theorem bounded_owner_group_union {Sample : Type*} [Fintype Sample] (n cutoff : ℕ)
    (hn : 1 ≤ n) (ht : cutoff ≤ n) (c : ℝ) (hc : 0 ≤ c)
    (event : Finset (Fin n) → Sample → Prop)
    (hsingle : ∀ owners, owners.card < cutoff → finiteProbability (event owners) ≤ c) :
    finiteProbability (fun data => ∃ owners : Finset (Fin n), owners.card < cutoff ∧ event owners data) ≤
      (n : ℝ) ^ (cutoff + 1) * c := by
  classical
  let family (s : ℕ) : Finset (Finset (Fin n)) := (Finset.univ : Finset (Fin n)).powersetCard s
  let level (s : ℕ) (data : Sample) := ∃ owners ∈ family s, event owners data
  have inclusion (data : Sample)
      (h : ∃ owners : Finset (Fin n), owners.card < cutoff ∧ event owners data) :
      ∃ s ∈ Finset.range cutoff, level s data := by
    obtain ⟨owners, hcard, hevent⟩ := h
    exact ⟨owners.card, Finset.mem_range.mpr hcard, owners,
      Finset.mem_powersetCard.mpr ⟨Finset.subset_univ _, rfl⟩, hevent⟩
  have hnR : (1 : ℝ) ≤ n := by exact_mod_cast hn
  have hh (s : ℕ) (hs : s ∈ Finset.range cutoff) : finiteProbability (level s) ≤ (n : ℝ) ^ cutoff * c := by
    have hs' := Finset.mem_range.mp hs
    refine (finiteProbability_union_bound (witnesses := family s) event).trans ?_
    have hchoose : (n.choose s : ℝ) ≤ (n : ℝ) ^ s := by exact_mod_cast Nat.choose_le_pow n s
    have hpow := pow_le_pow_right₀ hnR (Nat.le_of_lt hs')
    calc
      _ ≤ ∑ _owners ∈ family s, c := by
        apply Finset.sum_le_sum
        intro owners ho
        have hcard : owners.card = s := (Finset.mem_powersetCard.mp ho).2
        exact hsingle owners (by omega)
      _ = (n.choose s : ℝ) * c := by simp [family, Finset.card_powersetCard, nsmul_eq_mul]
      _ ≤ _ := mul_le_mul_of_nonneg_right (hchoose.trans hpow) hc
  refine (finiteProbability_mono inclusion).trans ((finiteProbability_union_bound
    (witnesses := Finset.range cutoff) level).trans ?_)
  calc
    _ ≤ ∑ _s ∈ Finset.range cutoff, (n : ℝ) ^ cutoff * c := Finset.sum_le_sum hh
    _ = (cutoff : ℝ) * ((n : ℝ) ^ cutoff * c) := by simp [Finset.sum_const, nsmul_eq_mul]
    _ ≤ (n : ℝ) * ((n : ℝ) ^ cutoff * c) :=
      mul_le_mul_of_nonneg_right (by exact_mod_cast ht) (by positivity)
    _ = _ := by rw [pow_succ]; ring

end TwoColorNullity.Occupancy
