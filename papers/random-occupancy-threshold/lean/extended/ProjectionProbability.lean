import OccupancyParity
import FiniteRandomBound

open scoped BigOperators

namespace TwoColorNullity.Occupancy

theorem finiteMean_comp_equiv {Sample Target : Type*} [Fintype Sample] [Fintype Target]
    (e : Sample ≃ Target) (f : Target → ℝ) :
    finiteMean (f ∘ e) = finiteMean f := by
  unfold finiteMean
  rw [Fintype.card_congr e, Fintype.sum_equiv e (f ∘ e) f (fun _ => rfl)]

theorem finiteMean_prod_fst {Sample Aux : Type*} [Fintype Sample] [Fintype Aux]
    [Nonempty Sample] [Nonempty Aux] (f : Sample → ℝ) :
    finiteMean (fun x : Sample × Aux => f x.1) = finiteMean f := by
  have hs : (Fintype.card Sample : ℝ) ≠ 0 := by exact_mod_cast Fintype.card_ne_zero
  have ha : (Fintype.card Aux : ℝ) ≠ 0 := by exact_mod_cast Fintype.card_ne_zero
  simp only [finiteMean, Fintype.sum_prod_type, Finset.sum_const, nsmul_eq_mul, Finset.card_univ,
    ← Finset.mul_sum, Fintype.card_prod, Nat.cast_mul]
  field_simp

theorem finiteProbability_eq_mean_indicator {Sample : Type*} [Fintype Sample]
    (event : Sample → Prop) [DecidablePred event] :
    finiteProbability event = finiteMean (fun sample => if event sample then 1 else 0) := by
  unfold finiteProbability finiteMean
  rw [Nat.card_eq_fintype_card, Fintype.card_subtype, Finset.sum_boole]

/-- Reading the columns in the selected set and its complement is a bijection. -/
def projectionEquiv (owners : Finset (Fin n)) (m : ℕ) :
    BitProfile n m ≃ (Fin m → ↥owners → Bool) × (Fin m → ↥(ownersᶜ) → Bool) where
  toFun bits := (fun item owner => bits (owner, item), fun item owner => bits (owner, item))
  invFun words index :=
    if h : index.1 ∈ owners then words.1 index.2 ⟨index.1, h⟩
    else words.2 index.2 ⟨index.1, Finset.mem_compl.mpr h⟩
  left_inv := by
    intro bits
    funext index
    by_cases h : index.1 ∈ owners <;> simp [h]
  right_inv := by
    intro words
    apply Prod.ext
    · funext item owner
      simp [owner.property]
    · funext item owner
      exact dif_neg (Finset.mem_compl.mp owner.property)

theorem projectedWords_uniform_mean (owners : Finset (Fin n)) (m : ℕ)
    (f : (Fin m → ↥owners → Bool) → ℝ) :
    finiteMean (fun bits : BitProfile n m => f (signature (profileTag bits) owners)) = finiteMean f := by
  let e := projectionEquiv owners m
  show finiteMean ((fun p => f p.1) ∘ e) = finiteMean f
  rw [finiteMean_comp_equiv, finiteMean_prod_fst]

theorem projectedWords_uniform_probability (owners : Finset (Fin n)) (m : ℕ)
    (event : (Fin m → ↥owners → Bool) → Prop) :
    finiteProbability (fun bits : BitProfile n m => event (signature (profileTag bits) owners)) =
      finiteProbability event := by
  classical
  rw [finiteProbability_eq_mean_indicator, finiteProbability_eq_mean_indicator]
  exact projectedWords_uniform_mean owners m (fun words => if event words then 1 else 0)

theorem projectedWords_odd_mean (owners : Finset (Fin n)) (m : ℕ) :
    finiteMean (fun bits : BitProfile n m => (oddBinCount (signature (profileTag bits) owners) : ℝ)) =
      ((2 : ℝ) ^ owners.card) / 2 * (1 - (1 - 2 / (2 : ℝ) ^ owners.card) ^ m) := by
  classical
  rw [projectedWords_uniform_mean owners m (fun profile => (oddBinCount profile : ℝ)), oddBinCount_mean]
  simp

end TwoColorNullity.Occupancy
