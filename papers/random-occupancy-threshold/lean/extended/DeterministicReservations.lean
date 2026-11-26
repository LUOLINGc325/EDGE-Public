import GreedyColorReservations
import Mathlib.Data.List.Nodup
import Mathlib.Data.Finset.Max

namespace TwoColorNullity.Occupancy

/-- Reserve the smallest eligible unused item for each request, in the given order. -/
def reserveGreedy {Request Item : Type*} [LinearOrder Item] (eligible : Request → Item → Bool) :
    List Request → Finset Item → Option (List (Request × Item))
  | [], _ => some []
  | request :: rest, pool =>
    let options := pool.filter fun item => eligible request item
    if h : options.Nonempty then
      let item := options.min' h
      (reserveGreedy eligible rest (pool.erase item)).map (fun assigned => (request, item) :: assigned)
    else none

theorem reserveGreedy_correct {Request Item : Type*} [LinearOrder Item]
    (eligible : Request → Item → Bool) (requests : List Request) (pool : Finset Item)
    (hroom : ∀ request ∈ requests, requests.length ≤ (pool.filter (fun item => eligible request item)).card) :
    ∃ rows, reserveGreedy eligible requests pool = some rows ∧ rows.map Prod.fst = requests ∧
      (rows.map Prod.snd).Nodup ∧ ∀ row ∈ rows, row.2 ∈ pool ∧ eligible row.1 row.2 = true := by
  induction requests generalizing pool with
  | nil => exact ⟨[], rfl, rfl, List.nodup_nil, by simp⟩
  | cons request rest ih =>
    let options := pool.filter fun item => eligible request item
    have hcount := hroom request (List.mem_cons_self)
    have hne : options.Nonempty := Finset.card_pos.mp (by
      change rest.length + 1 ≤ options.card at hcount
      omega)
    let selected := options.min' hne
    have hselected : selected ∈ options := options.min'_mem hne
    have hvalid : selected ∈ pool ∧ eligible request selected = true := Finset.mem_filter.mp hselected
    have hrest (r : Request) (hr : r ∈ rest) :
        rest.length ≤ ((pool.erase selected).filter (fun item => eligible r item)).card := by
      have h := hroom r (List.mem_cons_of_mem _ hr)
      have hcommute :
          (pool.erase selected).filter (fun item => eligible r item) =
            (pool.filter (fun item => eligible r item)).erase selected := by
        ext g
        simp only [Finset.mem_filter, Finset.mem_erase]
        constructor
        · rintro ⟨⟨hne, hm⟩, he⟩
          exact ⟨hne, hm, he⟩
        · rintro ⟨hne, hm, he⟩
          exact ⟨⟨hne, hm⟩, he⟩
      rw [hcommute]
      by_cases ht : selected ∈ pool.filter (fun item => eligible r item)
      · rw [Finset.card_erase_of_mem ht]
        simp only [List.length_cons] at h
        omega
      · rw [Finset.erase_eq_of_notMem ht]
        exact (Nat.le_succ _).trans h
    obtain ⟨rows, hrun, hrequests, hnodup, hitems⟩ := ih (pool.erase selected) hrest
    refine ⟨(request, selected) :: rows, ?_, ?_, ?_, ?_⟩
    · unfold reserveGreedy
      rw [dif_pos hne]
      change (reserveGreedy eligible rest (pool.erase selected)).map
        (fun assigned => (request, selected) :: assigned) = _
      rw [hrun]
      rfl
    · rw [List.map_cons, hrequests]
    · rw [List.map_cons, List.nodup_cons]
      refine ⟨?_, hnodup⟩
      intro h
      obtain ⟨row, hr, he⟩ := List.mem_map.mp h
      exact (Finset.mem_erase.mp (hitems row hr).1).1 he
    · intro row hr
      rcases List.mem_cons.mp hr with rfl | hrow
      · exact hvalid
      · have h := hitems row hrow
        exact ⟨Finset.mem_of_mem_erase h.1, h.2⟩

private theorem reserveRow_unique_of_item {Request Item : Type*} {rows : List (Request × Item)}
    (hnodup : (rows.map Prod.snd).Nodup) {a b : Request × Item} (ha : a ∈ rows) (hb : b ∈ rows)
    (hitem : a.2 = b.2) : a = b := by
  induction rows with
  | nil => simp at ha
  | cons row rest ih =>
    rw [List.map_cons, List.nodup_cons] at hnodup
    rcases List.mem_cons.mp ha with rfl | harest
    · rcases List.mem_cons.mp hb with rfl | hbrest
      · rfl
      · exact (hnodup.1 (List.mem_map.mpr ⟨b, hbrest, hitem.symm⟩)).elim
    · rcases List.mem_cons.mp hb with rfl | hbrest
      · exact (hnodup.1 (List.mem_map.mpr ⟨a, harest, hitem⟩)).elim
      · exact ih hnodup.2 harest hbrest

private def requestOptions {Request Item : Type*} [DecidableEq Request] [DecidableEq Item]
    (rows : List (Request × Item)) (request : Request) : Finset Item :=
  ((rows.toFinset).filter fun row => row.1 = request).image Prod.snd

private theorem requestOptions_nonempty {Request Item : Type*} [DecidableEq Request] [DecidableEq Item]
    (rows : List (Request × Item)) {request : Request} (h : request ∈ rows.map Prod.fst) :
    (requestOptions rows request).Nonempty := by
  obtain ⟨row, hrow, hr⟩ := List.mem_map.mp h
  exact ⟨row.2, Finset.mem_image.mpr ⟨row, Finset.mem_filter.mpr ⟨List.mem_toFinset.mpr hrow, hr⟩, rfl⟩⟩

/-- Read the item in a reservation table at an existing request. -/
def reservedItem {Request Item : Type*} [DecidableEq Request] [LinearOrder Item]
    (rows : List (Request × Item)) (request : Request) (h : request ∈ rows.map Prod.fst) : Item :=
  (requestOptions rows request).min' (requestOptions_nonempty rows h)

theorem reservedItem_mem {Request Item : Type*} [DecidableEq Request] [LinearOrder Item]
    (rows : List (Request × Item)) (request : Request) (h : request ∈ rows.map Prod.fst) :
    (request, reservedItem rows request h) ∈ rows := by
  obtain ⟨row, hr, he⟩ := Finset.mem_image.mp
    ((requestOptions rows request).min'_mem (requestOptions_nonempty rows h))
  have heq : row = (request, reservedItem rows request h) :=
    Prod.ext (Finset.mem_filter.mp hr).2 he
  rw [← heq]
  exact List.mem_toFinset.mp (Finset.mem_filter.mp hr).1

/-- Distinct reserved items ensure the table assigns a different item to each request. -/
theorem reservedItem_injective {Request Item : Type*} [DecidableEq Request] [LinearOrder Item]
    (rows : List (Request × Item)) (hall : ∀ r : Request, r ∈ rows.map Prod.fst)
    (hnodup : (rows.map Prod.snd).Nodup) :
    Function.Injective (fun r => reservedItem rows r (hall r)) := by
  intro a b he
  exact congrArg Prod.fst (reserveRow_unique_of_item hnodup
    (reservedItem_mem rows a (hall a)) (reservedItem_mem rows b (hall b)) he)

end TwoColorNullity.Occupancy
