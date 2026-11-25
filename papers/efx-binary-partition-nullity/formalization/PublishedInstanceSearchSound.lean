import PublishedInstance
import PublishedInstanceSearch

open scoped BigOperators

namespace TwoColorNullity.PublishedInstance

private def wordSignature (owners : Finset (Fin 18)) (value : ℕ) (owner : ↥owners) : Bool :=
  value.testBit owner.val.val

private noncomputable def wordFiber (owners : Finset (Fin 18)) (bucket : List ℕ)
    (value : ↥owners → Bool) : ℕ :=
  (bucket.filter fun item => decide (wordSignature owners item = value)).length

private noncomputable def bucketCapacity (owners : Finset (Fin 18)) (bucket : List ℕ) : ℕ :=
  ∑ value, wordFiber owners bucket value / 2

/-- Capacity after the remaining coordinates split each current bucket. -/
noncomputable def refinedCapacity (owners : Finset (Fin 18)) (buckets : List (List ℕ)) : ℕ :=
  (buckets.map (bucketCapacity owners)).sum

private theorem wordFiber_sum (owners : Finset (Fin 18)) (bucket : List ℕ) :
    (∑ value, wordFiber owners bucket value) = bucket.length := by
  induction bucket with
  | nil => simp [wordFiber]
  | cons item bucket ih =>
      have step (value : ↥owners → Bool) : wordFiber owners (item :: bucket) value =
          wordFiber owners bucket value + if wordSignature owners item = value then 1 else 0 := by
        by_cases he : wordSignature owners item = value <;> simp [wordFiber, he, Nat.add_comm]
      simp_rw [step]
      rw [Finset.sum_add_distrib, ih]
      simp

private theorem bucketCapacity_le (owners : Finset (Fin 18)) (bucket : List ℕ) :
    bucketCapacity owners bucket ≤ bucket.length / 2 := by
  have h : (∑ value : ↥owners → Bool, 2 * (wordFiber owners bucket value / 2)) ≤
      ∑ value, wordFiber owners bucket value := Finset.sum_le_sum fun _ _ => by omega
  rw [← Finset.mul_sum, wordFiber_sum] at h
  unfold bucketCapacity
  omega

theorem refinedCapacity_le_score (owners : Finset (Fin 18)) (buckets : List (List ℕ)) :
    refinedCapacity owners buckets ≤ bucketScore buckets := by
  induction buckets with
  | nil => simp [refinedCapacity, bucketScore]
  | cons bucket rest ih =>
      exact Nat.add_le_add (bucketCapacity_le owners bucket) ih

private theorem refinedCapacity_append (owners : Finset (Fin 18)) (first second : List (List ℕ)) :
    refinedCapacity owners (first ++ second) = refinedCapacity owners first + refinedCapacity owners second := by
  simp [refinedCapacity]

private theorem refinedCapacity_keep (owners : Finset (Fin 18)) (bucket : List ℕ) :
    refinedCapacity owners (keepPaired bucket) = bucketCapacity owners bucket := by
  by_cases h : 2 ≤ bucket.length
  · simp [keepPaired, h, refinedCapacity]
  · have hzero : bucketCapacity owners bucket = 0 := by have hle := bucketCapacity_le owners bucket; omega
    simp [keepPaired, h, refinedCapacity, hzero]

private theorem wordFiber_child (owners : Finset (Fin 18)) (coordinate : Fin 18) (hcoordinate : coordinate ∈ owners)
    (bucket : List ℕ) (value : ↥owners → Bool) (side : Bool) :
    wordFiber owners (bucket.filter fun item => item.testBit coordinate.val == side) value =
      if value ⟨coordinate, hcoordinate⟩ = side then wordFiber owners bucket value else 0 := by
  let owner : ↥owners := ⟨coordinate, hcoordinate⟩
  have item_rel (item : ℕ) (he : wordSignature owners item = value) :
      item.testBit coordinate.val = value owner := congrFun he owner
  unfold wordFiber
  rw [List.filter_filter]
  by_cases hside : value owner = side
  · rw [if_pos hside]
    congr 1
    apply List.filter_congr
    intro item _
    by_cases he : wordSignature owners item = value
    · simp [he, item_rel item he, hside]
    · simp [he]
  · rw [if_neg hside]
    have empty : bucket.filter (fun a => decide (wordSignature owners a = value) &&
        (a.testBit coordinate.val == side)) = [] := by
      rw [← List.filter_false (l := bucket)]
      apply List.filter_congr
      intro item _
      by_cases he : wordSignature owners item = value
      · have hne : item.testBit coordinate.val ≠ side := (item_rel item he).trans_ne hside
        simp [he, hne]
      · simp [he]
    rw [empty]
    rfl

private theorem bucketCapacity_partition (owners : Finset (Fin 18)) (coordinate : Fin 18)
    (hcoordinate : coordinate ∈ owners) (bucket : List ℕ) :
    bucketCapacity owners (bucket.partition (fun item => item.testBit coordinate.val)).1 +
      bucketCapacity owners (bucket.partition (fun item => item.testBit coordinate.val)).2 =
        bucketCapacity owners bucket := by
  unfold bucketCapacity
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro value _
  let owner : ↥owners := ⟨coordinate, hcoordinate⟩
  have yes : wordFiber owners (bucket.partition (fun item => item.testBit coordinate.val)).1 value =
      if value owner = true then wordFiber owners bucket value else 0 := by
    rw [List.partition_eq_filter_filter]
    have key : (fun item : ℕ => item.testBit coordinate.val == true) =
        (fun item => item.testBit coordinate.val) := by
      funext item
      cases item.testBit coordinate.val <;> rfl
    simpa only [key] using wordFiber_child owners coordinate hcoordinate bucket value true
  have no : wordFiber owners (bucket.partition (fun item => item.testBit coordinate.val)).2 value =
      if value owner = false then wordFiber owners bucket value else 0 := by
    rw [List.partition_eq_filter_filter]
    have key : (fun item : ℕ => item.testBit coordinate.val == false) =
        (Bool.not ∘ fun item => item.testBit coordinate.val) := by
      funext item
      simp only [Function.comp_apply]
      cases item.testBit coordinate.val <;> rfl
    simpa only [key] using wordFiber_child owners coordinate hcoordinate bucket value false
  rw [yes, no]
  cases value owner <;> simp

theorem refinedCapacity_refine (owners : Finset (Fin 18)) (coordinate : Fin 18)
    (hcoordinate : coordinate ∈ owners) (buckets : List (List ℕ)) :
    refinedCapacity owners (refineBuckets coordinate buckets) = refinedCapacity owners buckets := by
  induction buckets with
  | nil => simp [refineBuckets, refinedCapacity]
  | cons bucket rest ih =>
      unfold refineBuckets at ih ⊢
      rw [List.flatMap_cons, refinedCapacity_append, refinedCapacity_append, ih,
        refinedCapacity_keep, refinedCapacity_keep, bucketCapacity_partition owners coordinate hcoordinate]
      rfl

private theorem sizeBound_antitone : Antitone sizeBound := by
  have finite : ∀ i j : Fin 19, i ≤ j → sizeBound j.val ≤ sizeBound i.val := by decide
  intro i j hij
  by_cases hj : j < 19
  · exact finite ⟨i, hij.trans_lt hj⟩ ⟨j, hj⟩ hij
  · have hzero : sizeBound j = 0 := by
      unfold sizeBound
      rw [Array.getElem?_eq_none (by simpa using hj)]
      rfl
    rw [hzero]
    exact Nat.zero_le _

theorem checkBounds_sound (owners : Finset (Fin 18)) (rest : List (Fin 18))
    (selected : ℕ) (buckets : List (List ℕ)) (h : checkBounds rest selected buckets = true) :
    refinedCapacity owners buckets ≤ sizeBound (selected + (rest.filter fun i => decide (i ∈ owners)).length) := by
  induction rest generalizing selected buckets with
  | nil =>
      have hb : bucketScore buckets ≤ sizeBound selected := of_decide_eq_true h
      simpa using (refinedCapacity_le_score owners buckets).trans hb
  | cons coordinate rest ih =>
      unfold checkBounds at h
      split at h
      · rename_i enough
        apply (refinedCapacity_le_score owners buckets).trans (enough.trans (sizeBound_antitone ?_))
        have hle := List.length_filter_le (fun i => decide (i ∈ owners)) (coordinate :: rest)
        simp only [List.length_cons] at hle
        omega
      · have branches := Bool.and_eq_true_iff.mp h
        by_cases hc : coordinate ∈ owners
        · have chosen := ih (selected + 1) (refineBuckets coordinate buckets) branches.2
          rw [refinedCapacity_refine owners coordinate hc] at chosen
          simpa [hc, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using chosen
        · simpa [hc] using ih selected buckets branches.1

private theorem finRange_filter_count {n : ℕ} (property : Fin n → Prop) [DecidablePred property] :
    ((List.finRange n).filter fun index => decide (property index)).length =
      (Finset.univ.filter property).card := by
  rw [← List.toFinset_card_of_nodup ((List.nodup_finRange n).filter _)]
  rw [List.toFinset_filter, List.toFinset_finRange]
  congr 1
  ext index
  simp

theorem refinedCapacity_searchedWords (owners : Finset (Fin 18)) :
    refinedCapacity owners [searchedWords] = pairCapacity tags owners := by
  have exactWords : searchedWords = (List.finRange 53).map word := by decide +kernel
  simp only [refinedCapacity, List.map_cons, List.map_nil, List.sum_cons, List.sum_nil, Nat.add_zero]
  unfold bucketCapacity pairCapacity projectedPairCount
  apply Finset.sum_congr rfl
  intro value _
  unfold wordFiber
  rw [exactWords, List.filter_map, List.length_map]
  congr 1

theorem search_bound_for_every_owner_set (owners : Finset (Fin 18))
    (h : checkBounds (List.finRange 18) 0 [searchedWords] = true) :
    pairCapacity tags owners ≤ sizeBound owners.card := by
  have checked := checkBounds_sound owners (List.finRange 18) 0 [searchedWords] h
  rw [refinedCapacity_searchedWords, Nat.zero_add, finRange_filter_count (· ∈ owners)] at checked
  have retain : Finset.univ.filter (· ∈ owners) = owners := by ext i; simp
  simpa only [retain] using checked

private theorem child_properties (coordinate : Fin 18) {buckets : List (List ℕ)} {child : List ℕ}
    (hchild : child ∈ refineBuckets coordinate buckets) :
    (∃ parent ∈ buckets, ∀ word ∈ child, word ∈ parent) ∧
      ∀ a ∈ child, ∀ b ∈ child, a.testBit coordinate.val = b.testBit coordinate.val := by
  unfold refineBuckets at hchild
  obtain ⟨parent, hparent, hc⟩ := List.mem_flatMap.mp hchild
  rw [List.partition_eq_filter_filter] at hc
  have retained {candidate : List ℕ} (h : child ∈ keepPaired candidate) : child = candidate := by
    unfold keepPaired at h
    split at h
    · simpa using h
    · simp at h
  rcases List.mem_append.mp hc with hleft | hright
  · have he := retained hleft
    subst child
    refine ⟨⟨parent, hparent, fun item hi => (List.mem_filter.mp hi).1⟩, ?_⟩
    intro a ha b hb
    exact (List.mem_filter.mp ha).2.trans (List.mem_filter.mp hb).2.symm
  · have he := retained hright
    subst child
    refine ⟨⟨parent, hparent, fun item hi => (List.mem_filter.mp hi).1⟩, ?_⟩
    intro a ha b hb
    have ha' : a.testBit coordinate.val = false := by simpa using (List.mem_filter.mp ha).2
    have hb' : b.testBit coordinate.val = false := by simpa using (List.mem_filter.mp hb).2
    exact ha'.trans hb'.symm

private theorem refineAlong_subset (coords : List (Fin 18)) (buckets : List (List ℕ)) {last : List ℕ}
    (h : last ∈ refineAlong coords buckets) : ∃ first ∈ buckets, ∀ item ∈ last, item ∈ first := by
  induction coords generalizing buckets with
  | nil => exact ⟨last, h, fun _ hi => hi⟩
  | cons coord next ih =>
      obtain ⟨child, hchild, hsub⟩ := ih (refineBuckets coord buckets) h
      obtain ⟨parent, hparent, hback⟩ := (child_properties coord hchild).1
      exact ⟨parent, hparent, fun item hi => hback item (hsub item hi)⟩

private theorem refineAlong_agrees (coords : List (Fin 18)) (buckets : List (List ℕ)) {last : List ℕ}
    (h : last ∈ refineAlong coords buckets) {coord : Fin 18} (hcoord : coord ∈ coords) :
    ∀ a ∈ last, ∀ b ∈ last, a.testBit coord.val = b.testBit coord.val := by
  induction coords generalizing buckets with
  | nil => simp at hcoord
  | cons next rest ih =>
      rcases List.mem_cons.mp hcoord with he | hr
      · subst next
        obtain ⟨child, hchild, hsub⟩ := refineAlong_subset rest (refineBuckets coord buckets) h
        exact fun a ha b hb => (child_properties coord hchild).2 a (hsub a ha) b (hsub b hb)
      · exact ih (refineBuckets next buckets) h hr

private theorem bucketCapacity_of_agreement (owners : Finset (Fin 18)) (bucket : List ℕ)
    (same : ∀ a ∈ bucket, ∀ b ∈ bucket, wordSignature owners a = wordSignature owners b) :
    bucketCapacity owners bucket = bucket.length / 2 := by
  cases bucket with
  | nil => simp [bucketCapacity, wordFiber]
  | cons first rest =>
      have count (value : ↥owners → Bool) : wordFiber owners (first :: rest) value / 2 =
          if value = wordSignature owners first then (first :: rest).length / 2 else 0 := by
        have equal (item : ℕ) (hi : item ∈ first :: rest) : wordSignature owners item = wordSignature owners first :=
          same item hi first (by simp)
        unfold wordFiber
        by_cases he : value = wordSignature owners first
        · have all : (first :: rest).filter (fun item => decide (wordSignature owners item = value)) = first :: rest := by
            apply List.filter_eq_self.mpr
            intro item hi
            exact decide_eq_true ((equal item hi).trans he.symm)
          rw [all, if_pos he]
        · have none : (first :: rest).filter (fun item => decide (wordSignature owners item = value)) = [] := by
            rw [← List.filter_false (l := first :: rest)]
            apply List.filter_congr
            intro item hi
            simp [equal item hi, Ne.symm he]
          simp [he, none]
      unfold bucketCapacity
      simp_rw [count]
      simp

private theorem refinedCapacity_of_agreement (owners : Finset (Fin 18)) (buckets : List (List ℕ))
    (same : ∀ bucket ∈ buckets, ∀ a ∈ bucket, ∀ b ∈ bucket, wordSignature owners a = wordSignature owners b) :
    refinedCapacity owners buckets = bucketScore buckets := by
  induction buckets with
  | nil => rfl
  | cons bucket rest ih =>
      change bucketCapacity owners bucket + refinedCapacity owners rest = bucket.length / 2 + bucketScore rest
      rw [bucketCapacity_of_agreement owners bucket (same bucket (by simp)), ih]
      exact fun b hb => same b (by simp [hb])

private theorem refinedCapacity_along (owners : Finset (Fin 18)) (coords : List (Fin 18))
    (chosen : ∀ coord ∈ coords, coord ∈ owners) (buckets : List (List ℕ)) :
    refinedCapacity owners (refineAlong coords buckets) = refinedCapacity owners buckets := by
  induction coords generalizing buckets with
  | nil => rfl
  | cons coord next ih =>
      change refinedCapacity owners (refineAlong next (refineBuckets coord buckets)) = refinedCapacity owners buckets
      rw [ih (fun i hi => chosen i (by simp [hi]))]
      exact refinedCapacity_refine owners coord (chosen _ (by simp)) _

def selectedCoordinates (owners : Finset (Fin 18)) : List (Fin 18) :=
  (List.finRange 18).filter fun i => decide (i ∈ owners)

theorem pairCapacity_from_refinement (owners : Finset (Fin 18)) :
    pairCapacity tags owners = bucketScore (refineAlong (selectedCoordinates owners) [searchedWords]) := by
  rw [← refinedCapacity_searchedWords owners]
  have subset (coord : Fin 18) (h : coord ∈ selectedCoordinates owners) : coord ∈ owners := by
    exact of_decide_eq_true (List.mem_filter.mp h).2
  rw [← refinedCapacity_along owners (selectedCoordinates owners) subset [searchedWords]]
  apply refinedCapacity_of_agreement
  intro bucket hb a ha b hg
  funext coord
  have hin : coord.val ∈ selectedCoordinates owners := by
    simp [selectedCoordinates, coord.property]
  exact refineAlong_agrees (selectedCoordinates owners) [searchedWords] hb hin a ha b hg

end TwoColorNullity.PublishedInstance
