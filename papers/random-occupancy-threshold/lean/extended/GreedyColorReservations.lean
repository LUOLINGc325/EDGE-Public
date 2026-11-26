import OddRepresentatives
import Mathlib.Data.Fintype.Prod

namespace TwoColorNullity.Occupancy

/-- Greedy distinct representatives when every allowed set is at least as large as the request set. -/
theorem greedy_injective_choices {Request Item : Type*} [DecidableEq Request] [DecidableEq Item]
    (requests : Finset Request) (options : Request → Finset Item)
    (hsize : ∀ request ∈ requests, requests.card ≤ (options request).card) :
    ∃ chosen : ↥requests → Item, Function.Injective chosen ∧
      ∀ request : ↥requests, chosen request ∈ options request.val := by
  classical
  induction requests using Finset.induction_on with
  | empty =>
    have notEmpty (r : Request) : r ∉ (∅ : Finset Request) := by simp
    have impossible (r : ↥(∅ : Finset Request)) : False := notEmpty r.val r.property
    let chosen (r : ↥(∅ : Finset Request)) : Item := (impossible r).elim
    exact ⟨chosen, fun x _ _ => (impossible x).elim, fun x => (impossible x).elim⟩
  | @insert request rest hnot ih =>
    have hrest (r : Request) (hr : r ∈ rest) : rest.card ≤ (options r).card := by
      apply (Finset.card_le_card (Finset.subset_insert request rest)).trans
      exact hsize r (Finset.mem_insert_of_mem hr)
    obtain ⟨old, hi, ho⟩ := ih hrest
    let used : Finset Item := Finset.univ.image old
    have hcard : used.card = rest.card := by
      rw [show used = Finset.univ.image old from rfl, Finset.card_image_of_injective _ hi,
        Finset.card_univ, Fintype.card_coe]
    have hl : used.card < (options request).card := by
      have h := hsize request (Finset.mem_insert_self request rest)
      rw [Finset.card_insert_of_notMem hnot] at h
      omega
    obtain ⟨fresh, hallowed, hnew⟩ := Finset.exists_mem_notMem_of_card_lt_card hl
    let oldRequest (r : ↥(insert request rest)) (h : r.val ≠ request) : ↥rest :=
      ⟨r.val, (Finset.mem_insert.mp r.property).resolve_left h⟩
    let chosen (r : ↥(insert request rest)) := if h : r.val = request then fresh else old (oldRequest r h)
    have oldUsed (r : ↥rest) : old r ∈ used := Finset.mem_image.mpr ⟨r, Finset.mem_univ _, rfl⟩
    refine ⟨chosen, ?_, ?_⟩
    · intro a b he
      apply Subtype.ext
      by_cases ha : a.val = request
      · by_cases hb : b.val = request
        · exact ha.trans hb.symm
        · have h := oldUsed (oldRequest b hb)
          apply False.elim (hnew ?_)
          have heq : fresh = old (oldRequest b hb) := by simpa [chosen, ha, hb] using he
          rwa [heq]
      · by_cases hb : b.val = request
        · have h := oldUsed (oldRequest a ha)
          apply False.elim (hnew ?_)
          have heq : old (oldRequest a ha) = fresh := by simpa [chosen, ha, hb] using he
          rwa [← heq]
        · have heq : old (oldRequest a ha) = old (oldRequest b hb) := by
            simpa [chosen, ha, hb] using he
          exact congrArg (fun q : ↥rest => q.val) (hi heq)
    · intro a
      by_cases ha : a.val = request
      · simpa only [chosen, dif_pos ha, ha] using hallowed
      · simpa only [chosen, dif_neg ha] using ho (oldRequest a ha)

/-- Two protected chores of each color for every designated owner. -/
theorem reserve_two_each_color (tag : Fin n → Fin m → Bool) (owners : Finset (Fin n))
    (pairs : Finset (Finset (Fin m))) (packing : PairPacking (signature tag owners) Finset.univ pairs)
    (henough : ∀ owner : ↥owners, ∀ color : Bool,
      4 * owners.card ≤ restrictedOddCount
        (Finset.univ.filter fun label : ↥owners → Bool => label owner = color) (signature tag owners)) :
    ∃ chosen : (↥owners × Bool × Fin 2) → Fin m,
      Function.Injective chosen ∧ ∀ request : ↥owners × Bool × Fin 2,
        chosen request ∉ usedItems pairs ∧ tag request.1.val (chosen request) = request.2.1 := by
  classical
  let options (r : ↥owners × Bool × Fin 2) :=
    Finset.univ.filter fun item => item ∉ usedItems pairs ∧ tag r.1.val item = r.2.1
  have h (r : ↥owners × Bool × Fin 2) (_ : r ∈ (Finset.univ : Finset (↥owners × Bool × Fin 2))) :
      (Finset.univ : Finset (↥owners × Bool × Fin 2)).card ≤ (options r).card := by
    have hcard : (Finset.univ : Finset (↥owners × Bool × Fin 2)).card = 4 * owners.card := by
      simp [Fintype.card_prod, Nat.mul_comm]
    rw [hcard]
    exact (henough r.1 r.2.1).trans (enough_same_color_items tag owners pairs packing r.1 r.2.1)
  obtain ⟨selected, hinj, hopts⟩ := greedy_injective_choices Finset.univ options h
  let lift (r : ↥owners × Bool × Fin 2) : ↥(Finset.univ : Finset (↥owners × Bool × Fin 2)) :=
    ⟨r, Finset.mem_univ _⟩
  refine ⟨selected ∘ lift, ?_, ?_⟩
  · exact hinj.comp (fun _ _ he => congrArg Subtype.val he)
  · intro r
    exact (Finset.mem_filter.mp (hopts (lift r))).2

end TwoColorNullity.Occupancy
