import DeterministicReservations
import Mathlib.Data.Finset.Sort
import Mathlib.Logic.Equiv.Fin.Basic

namespace TwoColorNullity.Occupancy

abbrev ColorRequest {n : ℕ} (owners : Finset (Fin n)) := ↥owners × Bool × Fin 2

private def indexedRequest {n : ℕ} (owners : Finset (Fin n))
    (index : Fin (owners.card * (2 * 2))) : ColorRequest owners :=
  let p := (finProdFinEquiv : Fin owners.card × Fin (2 * 2) ≃ _).symm index
  let q := (finProdFinEquiv : Fin 2 × Fin 2 ≃ _).symm p.2
  (owners.orderIsoOfFin rfl p.1, decide (q.1 = 1), q.2)

private theorem indexedRequest_surjective {n : ℕ} (owners : Finset (Fin n)) :
    Function.Surjective (indexedRequest owners) := by
  rintro ⟨owner, color, copy⟩
  let c : Fin 2 := if color then 1 else 0
  let k := (finProdFinEquiv : Fin 2 × Fin 2 ≃ _ ) (c, copy)
  let i := (owners.orderIsoOfFin rfl).symm owner
  refine ⟨(finProdFinEquiv : Fin owners.card × Fin (2 * 2) ≃ _) (i, k), ?_⟩
  simp only [indexedRequest, Equiv.symm_apply_apply, k, i, OrderIso.apply_symm_apply]
  cases color <;> rfl

def reservationRequests {n : ℕ} (owners : Finset (Fin n)) : List (ColorRequest owners) :=
  (List.finRange (owners.card * (2 * 2))).map (indexedRequest owners)

theorem reservationRequests_length {n : ℕ} (owners : Finset (Fin n)) :
    (reservationRequests owners).length = 4 * owners.card := by
  simp [reservationRequests, Nat.mul_comm]

theorem reservationRequests_mem {n : ℕ} (owners : Finset (Fin n)) (r : ColorRequest owners) :
    r ∈ reservationRequests owners := by
  obtain ⟨i, rfl⟩ := indexedRequest_surjective owners r
  apply List.mem_map.mpr
  exact ⟨i, by simp, rfl⟩

private def freeChores {m : ℕ} (pairs : Finset (Finset (Fin m))) : Finset (Fin m) :=
  (usedItems pairs)ᶜ

private def eligibleColor (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n))
    (r : ColorRequest owners) (item : Fin m) : Bool :=
  tag r.1.val item == r.2.1

/-- Run the greedy reservation procedure on the unpaired chores. -/
def screenedReservationRows (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n))
    (pairs : Finset (Finset (Fin m))) : Option (List (ColorRequest owners × Fin m)) :=
  reserveGreedy (eligibleColor tag owners) (reservationRequests owners) (freeChores pairs)

theorem screenedReservationRows_correct (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n))
    (pairs : Finset (Finset (Fin m))) (packing : PairPacking (signature tag owners) Finset.univ pairs)
    (hcolors : ∀ r : ColorRequest owners, 4 * owners.card ≤ restrictedOddCount
      (Finset.univ.filter fun label : ↥owners → Bool => label r.1 = r.2.1) (signature tag owners)) :
    ∃ rows, screenedReservationRows tag owners pairs = some rows ∧
      (∀ r : ColorRequest owners, r ∈ rows.map Prod.fst) ∧
      (rows.map Prod.snd).Nodup ∧
      (∀ row ∈ rows, row.2 ∉ usedItems pairs ∧ tag row.1.1.val row.2 = row.1.2.1) := by
  have hroom (r : ColorRequest owners) (_ : r ∈ reservationRequests owners) :
      (reservationRequests owners).length ≤
        ((freeChores pairs).filter (fun item => eligibleColor tag owners r item)).card := by
    rw [reservationRequests_length]
    have he : (freeChores pairs).filter (fun item => eligibleColor tag owners r item) =
        Finset.univ.filter (fun item => item ∉ usedItems pairs ∧ tag r.1.val item = r.2.1) := by
      ext item
      simp [eligibleColor, freeChores]
    rw [he]
    exact (hcolors r).trans (enough_same_color_items tag owners pairs packing r.1 r.2.1)
  obtain ⟨rows, hrun, hrequests, hnodup, hitems⟩ :=
    reserveGreedy_correct (eligibleColor tag owners) (reservationRequests owners) (freeChores pairs) hroom
  refine ⟨rows, hrun, ?_, hnodup, ?_⟩
  · intro request
    rw [hrequests]
    exact reservationRequests_mem owners request
  · intro row hr
    have h := hitems row hr
    simpa [eligibleColor, freeChores] using h

end TwoColorNullity.Occupancy
