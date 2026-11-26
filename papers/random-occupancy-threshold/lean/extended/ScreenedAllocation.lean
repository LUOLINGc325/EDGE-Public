import ScreeningArithmetic
import ScreenedGroupSelection
import ScreenedReservations

namespace TwoColorNullity.Occupancy

private theorem pairSets_card_le_length {Item : Type*} [DecidableEq Item] (records : List (Item × Item)) :
    (pairSets records).card ≤ records.length := by
  unfold pairSets
  simpa only [List.length_map] using
    (List.toFinset_card_le (l := records.map fun pair => ({pair.1, pair.2} : Finset Item)))

theorem pairSets_prefix_correct {Item : Type*} [DecidableEq Item] (records : List (Item × Item))
    (hfull : (pairSets records).card = records.length) (r : ℕ) (hr : r ≤ records.length) :
    pairSets (records.take r) ⊆ pairSets records ∧ (pairSets (records.take r)).card = r := by
  classical
  let left := records.take r
  let right := records.drop r
  have heq : pairSets records = pairSets left ∪ pairSets right := by
    calc
      _ = pairSets (left ++ right) := congrArg pairSets (List.take_append_drop r records).symm
      _ = _ := by ext item; simp [pairSets]
  have hsum : left.length + right.length = records.length := by
    rw [← List.length_append, List.take_append_drop]
  have hcardLeft := pairSets_card_le_length left
  have hcardRight := pairSets_card_le_length right
  have hcard := Finset.card_union_le (pairSets left) (pairSets right)
  rw [← heq, hfull] at hcard
  refine ⟨by rw [heq]; exact Finset.subset_union_left, ?_⟩
  have hp : left.length = r := by unfold left; rw [List.length_take, min_eq_left hr]
  change (pairSets left).card = r
  omega

/-- The agreeing pairs taken by the screened coordinate group. -/
def screenedPairs (n s : ℕ) (bits : BitProfile n (3 * n - 1)) (group : Fin (n / s)) :
    Finset (Finset (Fin (3 * n - 1))) :=
  let coords := coordinateSlice (disjointCoordinateBlocks n s) group
  let records := bucketPairs (packedLabel (profileTag bits) coords) (List.finRange (3 * n - 1))
  pairSets (records.take (n - s))

theorem screenedPairs_pack (n s : ℕ) (bits : BitProfile n (3 * n - 1)) (group : Fin (n / s))
    (hs : 0 < s) (hsn : s < n) (hcheck : firstSuccessfulBlock n s bits = some group) :
    let owners := blockOwners (disjointCoordinateBlocks n s) group
    PairPacking (signature (profileTag bits) owners) Finset.univ (screenedPairs n s bits group) ∧
      (screenedPairs n s bits group).card = n - s := by
  let coords := coordinateSlice (disjointCoordinateBlocks n s) group
  let owners := blockOwners (disjointCoordinateBlocks n s) group
  let records := bucketPairs (packedLabel (profileTag bits) coords) (List.finRange (3 * n - 1))
  have hcard : owners.card = s := by simp [owners]
  have hodd := firstSuccessfulBlock_matches n s bits group hcheck
  rw [block_occupancy_exact] at hodd
  have hfeas := (fixed_items_feasible_iff_odd (profileTag bits) owners (by omega) (by omega)).mpr
    (by rwa [hcard])
  have hlength := packed_bucket_pairs_attain_capacity (profileTag bits) coords
  have hfit : n - s ≤ records.length := by
    rw [hlength]
    have hcap := hfeas.2.2
    rwa [hcard] at hcap
  obtain ⟨packing, hcardAll⟩ := packed_bucket_pairs (profileTag bits) coords
  obtain ⟨hsub, hcount⟩ := pairSets_prefix_correct records hcardAll (n - s) hfit
  exact ⟨packing.subpacking hsub, hcount⟩


/-- Run the pair selection, greedy reservations, and balanced allocation for a checked group. -/
def runScreenedAllocation (n s : ℕ) (hs : 0 < s) (hsn : s < n)
    (bits : BitProfile n (3 * n - 1)) (group : Fin (n / s))
    (hcheck : firstSuccessfulBlock n s bits = some group) : Option (Fin (3 * n - 1) → Fin n) :=
  let tag := profileTag bits
  let owners := blockOwners (disjointCoordinateBlocks n s) group
  let howners : 0 < owners.card := by simpa [owners] using hs
  let pairs := screenedPairs n s bits group
  let hpack : PairPacking (signature tag owners) Finset.univ pairs :=
    (screenedPairs_pack n s bits group hs hsn hcheck).1
  let hcount : pairs.card = n - owners.card := by
    simpa [owners] using (screenedPairs_pack n s bits group hs hsn hcheck).2
  match screenedReservationRows tag owners pairs with
  | none => none
  | some rows =>
    if hall : ∀ r : ColorRequest owners, r ∈ rows.map Prod.fst then
      some (protectedAssignment tag owners howners pairs hpack hcount (fun r => reservedItem rows r (hall r)))
    else none

theorem screened_construction_attains_optimum (n s : ℕ) (hs : 0 < s) (hsn : s < n)
    (hroom : 2 * s ≤ n - 1) (bits : BitProfile n (3 * n - 1)) (group : Fin (n / s))
    (hcheck : firstSuccessfulBlock n s bits = some group)
    (hmaximum : maximumFeasibleOwners (profileTag bits) = s)
    (hfactor : optimalFactor (profileTag bits) = typicalOptimum n bits)
    (hqual : ¬ SomeColorDeficit n bits) (hlog : n.log2 ≤ s) (hcut : s < largeSetThreshold n)
    (hsupply : ((4 * s : ℕ) : ℝ) ≤ colorSupplyCoefficient * (n : ℝ) / 2) :
    let owners := blockOwners (disjointCoordinateBlocks n s) group
    ∃ assign, runScreenedAllocation n s hs hsn bits group hcheck = some assign ∧
      ApproxEFX (profileTag bits) assign (optimalFactor (profileTag bits)) ∧
      (∀ i ∉ owners, ∃ pair ∈ screenedPairs n s bits group, bundle assign i = pair) ∧
      (∀ i ∈ owners, HasTwoOfEachColor (profileTag bits) assign i) := by
  let owners := blockOwners (disjointCoordinateBlocks n s) group
  have hcard : owners.card = s := by simp [owners]
  obtain ⟨packing, hsize⟩ := screenedPairs_pack n s bits group hs hsn hcheck
  have hreach (owner : ↥owners) (color : Bool) :
      4 * owners.card ≤ restrictedOddCount (designatedColorBins owner color) (signature (profileTag bits) owners) := by
    have hgood : colorSupplyCoefficient * (n : ℝ) / 2 ≤
        (restrictedOddCount (designatedColorBins owner color) (signature (profileTag bits) owners) : ℝ) :=
      le_of_not_gt fun h => hqual ⟨owners, by omega, by omega, owner, color, h⟩
    rw [hcard]
    exact_mod_cast hsupply.trans hgood

  let tag := profileTag bits
  let pairs := screenedPairs n s bits group
  have hpacking : PairPacking (signature tag owners) Finset.univ pairs := packing
  have hpositive : 0 < owners.card := by omega
  have hroom' : 2 * owners.card ≤ n - 1 := by omega
  have hcount : pairs.card = n - owners.card := by rwa [hcard]
  obtain ⟨rows, hrun, hall, hnodup, hitems⟩ :=
    screenedReservationRows_correct tag owners pairs hpacking (fun r => hreach r.1 r.2.1)
  let chosen (r : ColorRequest owners) := reservedItem rows r (hall r)
  have hi : Function.Injective chosen := reservedItem_injective rows hall hnodup
  have hchosen (r : ColorRequest owners) :
      chosen r ∉ usedItems pairs ∧ tag r.1.val (chosen r) = r.2.1 :=
    hitems (r, chosen r) (reservedItem_mem rows r (hall r))
  let assign := protectedAssignment tag owners hpositive pairs hpacking hcount chosen
  obtain ⟨ha, hout, hin, _⟩ :=
    protected_assignment_approxEFX tag owners hpositive hroom' pairs hpacking hcount chosen hi hchosen
  have hreal : runScreenedAllocation n s hs hsn bits group hcheck = some assign := by
    unfold runScreenedAllocation
    change (match screenedReservationRows tag owners pairs with
      | none => none
      | some rows' =>
        if h : ∀ r : ColorRequest owners, r ∈ rows'.map Prod.fst then
          some (protectedAssignment tag owners hpositive pairs hpacking hcount
            (fun r => reservedItem rows' r (h r)))
        else none) = _
    rw [hrun]
    exact dif_pos hall
  rw [hfactor, typicalOptimum, hmaximum]
  change ApproxEFX tag assign ((((n - 1) ⌈/⌉ owners.card - 1 : ℕ)) : ℝ) at ha
  rw [hcard] at ha
  exact ⟨assign, hreal, ha, hout, hin⟩

end TwoColorNullity.Occupancy
