import OwnerSetUnion
import BinPowerApproximation

open scoped BigOperators

namespace TwoColorNullity.Occupancy

theorem restrictedOddCount_mean {Item Label : Type*} [Fintype Item] [DecidableEq Item]
    [Fintype Label] [DecidableEq Label] [Nonempty Label] (targets : Finset Label) :
    finiteMean (fun bins : Item → Label => (restrictedOddCount targets bins : ℝ)) =
      (targets.card : ℝ) / 2 * (1 - (1 - 2 / (Fintype.card Label : ℝ)) ^ Fintype.card Item) := by
  simp only [restrictedOddCount, Nat.cast_sum, cast_mod_two_eq_sign, finiteMean_finset_sum,
    finiteMean_div, finiteMean_sub, finiteMean_const, bin_parity_mean]
  simp only [Finset.sum_const, nsmul_eq_mul]
  ring

noncomputable def designatedColorBins {Owner : Type*} [Fintype Owner] [DecidableEq Owner]
    (owner : Owner) (color : Bool) : Finset (Owner → Bool) :=
  Finset.univ.filter fun label => label owner = color

theorem designatedColorBins_half {Owner : Type*} [Fintype Owner] [DecidableEq Owner]
    (owner : Owner) (color : Bool) :
    2 * (designatedColorBins owner color).card = Fintype.card (Owner → Bool) := by
  classical
  let swap : (Owner → Bool) ≃ (Owner → Bool) :=
    ⟨fun label i => Bool.not (label i), fun label i => Bool.not (label i),
      fun label => funext (fun i => by simp), fun label => funext (fun i => by simp)⟩
  let h : {label : Owner → Bool // label owner = color} ≃ {label : Owner → Bool // label owner = !color} :=
    swap.subtypeEquiv (fun label => by
      change label owner = color ↔ Bool.not (label owner) = Bool.not color
      cases label owner <;> cases color <;> simp)
  have hsize := Fintype.card_congr h
  rw [Fintype.card_subtype, Fintype.card_subtype] at hsize
  change (designatedColorBins owner color).card = (designatedColorBins owner (!color)).card at hsize
  have hdisjoint : Disjoint (designatedColorBins owner color) (designatedColorBins owner (!color)) := by
    apply Finset.disjoint_left.mpr
    intro label ha hb
    have h₀ := (Finset.mem_filter.mp ha).2
    have h₁ := (Finset.mem_filter.mp hb).2
    cases color <;> simp_all
  have hcover : designatedColorBins owner color ∪ designatedColorBins owner (!color) = Finset.univ := by
    ext label
    cases color <;> cases label owner <;> simp [designatedColorBins]
  have hc := Finset.card_union_of_disjoint hdisjoint
  rw [hcover, Finset.card_univ, ← hsize] at hc
  omega

theorem designatedColor_mean_double (n m : ℕ) (owners : Finset (Fin n)) (owner : ↥owners) (color : Bool) :
    2 * finiteMean (fun draws : Fin m → (↥owners → Bool) =>
      (restrictedOddCount (designatedColorBins owner color) draws : ℝ)) =
      finiteMean (fun draws : Fin m → Fin (2 ^ owners.card) => (oddBinCount draws : ℝ)) := by
  classical
  letI : NeZero (2 ^ owners.card) := ⟨by positivity⟩
  have hcard : Fintype.card (↥owners → Bool) = 2 ^ owners.card := by simp
  have hcast : (Fintype.card (↥owners → Bool) : ℝ) = (2 : ℝ) ^ owners.card := by exact_mod_cast hcard
  have hsize : 2 * ((designatedColorBins owner color).card : ℝ) = (2 : ℝ) ^ owners.card := by
    exact_mod_cast (designatedColorBins_half owner color).trans hcard
  have hhalf : ((designatedColorBins owner color).card : ℝ) = (2 : ℝ) ^ owners.card / 2 := by linarith
  rw [restrictedOddCount_mean, oddBinCount_mean]
  simp only [Fintype.card_fin, Nat.cast_pow, Nat.cast_ofNat, hcast, hhalf]
  ring

end TwoColorNullity.Occupancy
