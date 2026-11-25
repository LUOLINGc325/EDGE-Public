import LabelBuckets
import Mathlib.Data.List.OfFn
import Mathlib.Data.List.Nodup

open Function
open scoped BigOperators

namespace TwoColorNullity

def selectedOwners (coordinates : Fin k ↪ Fin n) : Finset (Fin n) :=
  Finset.univ.map coordinates

@[simp] theorem selectedOwners_card (coordinates : Fin k ↪ Fin n) :
    (selectedOwners coordinates).card = k := by simp [selectedOwners]

def packedLabel (tag : Fin n → Fin m → Bool) (coordinates : Fin k ↪ Fin n)
    (item : Fin m) : Fin (2 ^ k) :=
  ⟨packBits (List.ofFn fun j => tag (coordinates j) item), by
    simpa only [List.length_ofFn] using packBits_lt (List.ofFn fun j => tag (coordinates j) item)⟩

theorem packedLabel_eq_iff (tag : Fin n → Fin m → Bool) (coordinates : Fin k ↪ Fin n) (a b : Fin m) :
    packedLabel tag coordinates a = packedLabel tag coordinates b ↔
      signature tag (selectedOwners coordinates) a = signature tag (selectedOwners coordinates) b := by
  constructor
  · intro he
    have hpack : packBits (List.ofFn fun j => tag (coordinates j) a) =
        packBits (List.ofFn fun j => tag (coordinates j) b) := congrArg Fin.val he
    have hlist := packBits_injective_of_length (by simp) hpack
    have hfun := List.ofFn_injective hlist
    funext owner
    obtain ⟨j, _, hej⟩ := Finset.mem_map.mp owner.property
    change tag owner.val a = tag owner.val b
    rw [← hej]
    exact congrFun hfun j
  · intro he
    apply Fin.ext
    apply congrArg packBits
    apply congrArg List.ofFn
    funext j
    let owner : ↥(selectedOwners coordinates) := ⟨coordinates j,
      Finset.mem_map.mpr ⟨j, Finset.mem_univ _, rfl⟩⟩
    exact congrFun he owner

def pairEndpoints {Item : Type*} (pairs : List (Item × Item)) : List Item :=
  pairs.flatMap fun pair => [pair.1, pair.2]

private theorem pairAdjacent_sublist {Item : Type*} : ∀ items : List Item,
    (pairEndpoints (pairAdjacent items)).Sublist items
  | [] => List.Sublist.slnil
  | [_] => List.nil_sublist _
  | _ :: _ :: rest => by
      simpa only [pairAdjacent, pairEndpoints, List.flatMap_cons, List.cons_append, List.nil_append] using
        (List.Sublist.cons₂ _ (List.Sublist.cons₂ _ (pairAdjacent_sublist rest)))

private theorem pairAdjacent_homogeneous {Item Label : Type*} (label : Item → Label) (bucket : Label) :
    ∀ items : List Item, (∀ item ∈ items, label item = bucket) →
      ∀ pair ∈ pairAdjacent items, label pair.1 = label pair.2
  | [], _, _, hp => by simp [pairAdjacent] at hp
  | [_], _, _, hp => by simp [pairAdjacent] at hp
  | a :: b :: rest, hlabel, pair, hp => by
      rcases List.mem_cons.mp hp with rfl | hp
      · exact (hlabel a (by simp)).trans (hlabel b (by simp)).symm
      · exact pairAdjacent_homogeneous label bucket rest (fun item hi => hlabel item (by simp [hi])) pair hp

private theorem bucketPairs_homogeneous {Item : Type*} {labels : ℕ} (label : Item → Fin labels)
    (items : List Item) (pair : Item × Item) (hp : pair ∈ bucketPairs label items) :
    label pair.1 = label pair.2 := by
  obtain ⟨bucket, _, hm⟩ := List.mem_flatMap.mp hp
  rw [BucketArray.get_loaded] at hm
  apply pairAdjacent_homogeneous label bucket _ _ pair hm
  intro item hi
  rw [List.mem_reverse, List.mem_filter] at hi
  exact of_decide_eq_true hi.2

private theorem bucketPairs_endpoints_nodup {Item : Type*} {labels : ℕ} (label : Item → Fin labels)
    (items : List Item) (hi : items.Nodup) : (pairEndpoints (bucketPairs label items)).Nodup := by
  unfold pairEndpoints bucketPairs
  rw [List.flatMap_assoc, List.nodup_flatMap]
  let buckets := BucketArray.load label items (BucketArray.empty labels)
  have hlabel {bucket : Fin labels} {item : Item}
      (hm : item ∈ pairEndpoints (pairAdjacent (buckets.get bucket))) : label item = bucket := by
    have hr := (pairAdjacent_sublist (buckets.get bucket)).subset hm
    rw [show buckets.get bucket = (items.filter fun item => decide (label item = bucket)).reverse from
      BucketArray.get_loaded label items bucket, List.mem_reverse, List.mem_filter] at hr
    exact of_decide_eq_true hr.2
  refine ⟨?_, ?_⟩
  · intro bucket _
    change (pairEndpoints (pairAdjacent (buckets.get bucket))).Nodup
    apply List.Nodup.sublist (pairAdjacent_sublist _)
    rw [show buckets.get bucket = (items.filter fun item => decide (label item = bucket)).reverse from
      BucketArray.get_loaded label items bucket]
    exact List.nodup_reverse.mpr (hi.filter _)
  · exact (List.nodup_finRange labels).imp fun hne item ha hb => hne ((hlabel ha).symm.trans (hlabel hb))

def pairSets {Item : Type*} [DecidableEq Item] (records : List (Item × Item)) : Finset (Finset Item) :=
  (records.map fun pair => {pair.1, pair.2}).toFinset

private theorem mem_endpoints_of_mem_pair {Item : Type*} [DecidableEq Item]
    {records : List (Item × Item)} {pair : Finset Item} {item : Item}
    (hp : pair ∈ pairSets records) (hi : item ∈ pair) : item ∈ pairEndpoints records := by
  obtain ⟨record, hr, rfl⟩ := List.mem_map.mp (List.mem_toFinset.mp hp)
  apply List.mem_flatMap.mpr
  refine ⟨record, hr, ?_⟩
  simpa only [Finset.mem_insert, Finset.mem_singleton, List.mem_cons, List.not_mem_nil, or_false] using hi

private theorem pairedRecords_pack {Item Label : Type*} [Fintype Item] [DecidableEq Item]
    (label : Item → Label) (records : List (Item × Item))
    (hd : (pairEndpoints records).Nodup)
    (hl : ∀ pair ∈ records, label pair.1 = label pair.2) :
    PairPacking label Finset.univ (pairSets records) ∧ (pairSets records).card = records.length := by
  induction records with
  | nil =>
    simp [pairSets]
    constructor <;> simp
  | cons first rest ih =>
    obtain ⟨a, b⟩ := first
    change (a :: b :: pairEndpoints rest).Nodup at hd
    obtain ⟨ha, hbrest⟩ := List.nodup_cons.mp hd
    obtain ⟨hb, hrest⟩ := List.nodup_cons.mp hbrest
    have hab : a ≠ b := fun eq => ha (by simp [eq])
    have han : a ∉ pairEndpoints rest := fun h => ha (List.mem_cons_of_mem _ h)
    obtain ⟨packing, hcount⟩ := ih hrest (fun pair h => hl pair (List.mem_cons_of_mem _ h))
    let p : Finset Item := {a, b}
    have hnew : pairSets ((a, b) :: rest) = insert p (pairSets rest) := by
      simp [pairSets, p]
    have hnot : p ∉ pairSets rest := fun h => han (mem_endpoints_of_mem_pair h (by simp [p]))
    have cross (q : Finset Item) (hq : q ∈ pairSets rest) : Disjoint p q := by
      apply Finset.disjoint_left.mpr
      intro x hx hxq
      have he := mem_endpoints_of_mem_pair hq hxq
      rcases Finset.mem_insert.mp hx with rfl | hx
      · exact han he
      · have hx' := Finset.mem_singleton.mp hx
        exact hb (hx' ▸ he)
    rw [hnew, Finset.card_insert_of_notMem hnot, hcount, List.length_cons]
    refine ⟨?_, rfl⟩
    constructor
    · intro q hq
      rcases Finset.mem_insert.mp hq with rfl | hq
      · simp [p, hab]
      · exact packing.two q hq
    · intro q _
      exact Finset.subset_univ q
    · intro q hq x hx y hy
      rcases Finset.mem_insert.mp hq with rfl | hq
      · have h := hl (a, b) (List.mem_cons_self)
        have hx' : x = a ∨ x = b := by simpa [p] using hx
        have hy' : y = a ∨ y = b := by simpa [p] using hy
        rcases hx' with rfl | rfl <;> rcases hy' with rfl | rfl
        · rfl
        · exact h
        · exact h.symm
        · rfl
      · exact packing.homogeneous q hq x hx y hy
    · intro q hq t ht hne
      rcases Finset.mem_insert.mp hq with rfl | hq <;> rcases Finset.mem_insert.mp ht with rfl | ht
      · exact (hne rfl).elim
      · exact cross t ht
      · exact (cross q hq).symm
      · exact packing.disjoint q hq t ht hne

theorem packed_bucket_pairs (tag : Fin n → Fin m → Bool) (coordinates : Fin k ↪ Fin n) :
    let records := bucketPairs (packedLabel tag coordinates) (List.finRange m)
    PairPacking (signature tag (selectedOwners coordinates)) Finset.univ (pairSets records) ∧
      (pairSets records).card = records.length := by
  let label := packedLabel tag coordinates
  let items := List.finRange m
  let records := bucketPairs label items
  apply pairedRecords_pack
  · exact bucketPairs_endpoints_nodup label items (List.nodup_finRange m)
  · intro pair hp
    exact (packedLabel_eq_iff tag coordinates pair.1 pair.2).mp (bucketPairs_homogeneous label items pair hp)

private theorem bucket_length_eq_capacity {m labels : ℕ} (label : Fin m → Fin labels) :
    (bucketPairs label (List.finRange m)).length = projectedPairCount label Finset.univ := by
  rw [bucketPairs_length, projectedPairCount]
  apply Finset.sum_congr rfl
  intro bucket _
  congr 1

theorem packed_bucket_pairs_attain_capacity (tag : Fin n → Fin m → Bool) (coordinates : Fin k ↪ Fin n) :
    (bucketPairs (packedLabel tag coordinates) (List.finRange m)).length =
      pairCapacity tag (selectedOwners coordinates) := by
  let label := packedLabel tag coordinates
  let owners := selectedOwners coordinates
  obtain ⟨packing, hcard⟩ := packed_bucket_pairs tag coordinates
  apply le_antisymm
  · rw [← hcard]
    exact packing.card_le
  · classical
    obtain ⟨pairs, hpack, heq⟩ := projectedPairCount_attained (signature tag owners) Finset.univ
    have packed : PairPacking label Finset.univ pairs := ⟨hpack.two, hpack.inside,
      fun p hp a ha b hb => (packedLabel_eq_iff tag coordinates a b).mpr (hpack.homogeneous p hp a ha b hb),
      hpack.disjoint⟩
    rw [bucket_length_eq_capacity, pairCapacity, ← heq]
    exact packed.card_le

def wordRAMWork (items owners coordinates : ℕ) : ℕ :=
  3 * items * coordinates + 2 ^ coordinates + 8 * items + 4 * owners

def wordRAMSpace (items owners coordinates : ℕ) : ℕ :=
  3 * items + 2 ^ coordinates + owners

theorem wordRAMWork_bound (items owners coordinates : ℕ) (hc : 1 ≤ coordinates)
    (hlabels : 2 ^ coordinates ≤ owners) : wordRAMWork items owners coordinates ≤ 11 * (items * coordinates + owners) := by
  have hitems : items ≤ items * coordinates := by
    simpa only [Nat.mul_one] using Nat.mul_le_mul_left items hc
  unfold wordRAMWork
  simp only [Nat.mul_assoc]
  omega

theorem wordRAMSpace_bound (items owners coordinates : ℕ) (hlabels : 2 ^ coordinates ≤ owners) :
    wordRAMSpace items owners coordinates ≤ 3 * (items + owners) := by
  unfold wordRAMSpace
  omega

theorem fixed_item_bucket_run (tag : Fin n → Fin (3 * n - 1) → Bool) (hn : 2 ≤ n)
    (coordinates : Fin n.log2 ↪ Fin n) :
    let records := bucketPairs (packedLabel tag coordinates) (List.finRange (3 * n - 1))
    n ≤ records.length ∧
      PairPacking (signature tag (selectedOwners coordinates)) Finset.univ (pairSets records) ∧
      wordRAMWork (3 * n - 1) n n.log2 ≤ 11 * ((3 * n - 1) * n.log2 + n) ∧
      wordRAMSpace (3 * n - 1) n n.log2 ≤ 3 * (3 * n - 1 + n) := by
  have hlabels : 2 ^ n.log2 ≤ n := (Nat.le_log2 (by omega)).mp le_rfl
  have hk : 1 ≤ n.log2 := (Nat.le_log2 (by omega)).mpr (by omega)
  have hcapacity := pairCapacity_lower tag (selectedOwners coordinates)
  rw [selectedOwners_card, ← packed_bucket_pairs_attain_capacity tag coordinates] at hcapacity
  exact ⟨by omega, (packed_bucket_pairs tag coordinates).1, wordRAMWork_bound _ _ _ hk hlabels,
    wordRAMSpace_bound _ _ _ hlabels⟩

private theorem taken_endpoints_sublist {Item : Type*} : ∀ (count : ℕ) (records : List (Item × Item)),
    (pairEndpoints (records.take count)).Sublist (pairEndpoints records)
  | 0, _ => List.nil_sublist _
  | _ + 1, [] => List.Sublist.slnil
  | count + 1, pair :: rest => by
    simpa only [List.take_succ_cons, pairEndpoints, List.flatMap_cons, List.cons_append, List.nil_append] using
      List.Sublist.cons₂ pair.1 (List.Sublist.cons₂ pair.2 (taken_endpoints_sublist count rest))

theorem middle_bucket_allocation (tag : Fin n → Fin m → Bool) (d : ℕ) (hd : 1 ≤ d)
    (hdn : d < n) (hm : m = 2 * n + d) (coordinates : Fin (d + 1).log2 ↪ Fin n) :
    let k := (d + 1).log2
    let owners := selectedOwners coordinates
    let records := bucketPairs (packedLabel tag coordinates) (List.finRange m)
    let chosen := pairSets (records.take (n - k))
    n ≤ records.length ∧
      (∃ assign, ApproxEFX tag assign ((d ⌈/⌉ k : ℕ) : ℝ) ∧
        (∀ i ∉ owners, ∃ p ∈ chosen, bundle assign i = p)) ∧
      wordRAMWork m n k ≤ 11 * (m * k + n) ∧ wordRAMSpace m n k ≤ 3 * (m + n) := by
  let k := (d + 1).log2
  let owners := selectedOwners coordinates
  let label := packedLabel tag coordinates
  let items := List.finRange m
  let records := bucketPairs label items
  have howners : owners.card = k := selectedOwners_card _
  have hk : 1 ≤ k := (Nat.le_log2 (by omega)).mpr (by omega)
  have hkd : k ≤ d := by
    have h := (Nat.log2_lt (by omega : d + 1 ≠ 0)).mpr (show d + 1 < 2 ^ (d + 1) from Nat.lt_two_pow_self)
    change k < d + 1 at h
    omega
  have hlabels : 2 ^ k ≤ d + 1 := (Nat.le_log2 (by omega)).mp le_rfl
  have hcap := pairCapacity_lower tag owners
  rw [howners, show pairCapacity tag owners = records.length from
    (packed_bucket_pairs_attain_capacity tag coordinates).symm] at hcap
  have hlength : n ≤ records.length := by omega
  let chosen := records.take (n - k)
  have hnodup : (pairEndpoints chosen).Nodup :=
    List.Nodup.sublist (taken_endpoints_sublist _ records)
      (bucketPairs_endpoints_nodup label items (List.nodup_finRange m))
  obtain ⟨packing, hcount⟩ := pairedRecords_pack (signature tag owners) chosen hnodup (by
    intro pair hp
    have hr := (List.take_sublist (n - k) records).subset hp
    exact (packedLabel_eq_iff tag coordinates pair.1 pair.2).mp (bucketPairs_homogeneous label items pair hr))
  have hcount' : (pairSets chosen).card = n - owners.card := by
    rw [hcount, howners]
    simp only [chosen, List.length_take]
    exact min_eq_left (by omega)
  obtain ⟨assign, hfactor, hbundles⟩ := approxEFX_from_prescribed_pairs tag owners d hm
    (by omega) (by omega) (pairSets chosen) packing hcount'
  rw [howners] at hfactor
  have hlabelsN : 2 ^ k ≤ n := hlabels.trans (by omega)
  exact ⟨hlength, ⟨assign, hfactor, hbundles⟩, wordRAMWork_bound _ _ _ hk hlabelsN,
    wordRAMSpace_bound _ _ _ hlabelsN⟩

theorem middle_bucket_work_le_full_input_scale (m n d : ℕ) (hd : 1 ≤ d) (hdn : d < n) :
    wordRAMWork m n (d + 1).log2 ≤ 11 * (m * n + n) := by
  have hk : 1 ≤ (d + 1).log2 := (Nat.le_log2 (by omega)).mpr (by omega)
  have hlabels : 2 ^ (d + 1).log2 ≤ d + 1 := (Nat.le_log2 (by omega)).mp le_rfl
  have hcoordFloor : (d + 1).log2 < d + 1 := (Nat.log2_lt (by omega)).mpr Nat.lt_two_pow_self
  have hcoord : (d + 1).log2 ≤ n := by omega
  apply (wordRAMWork_bound m n _ hk (by omega)).trans
  exact Nat.mul_le_mul_left _ (Nat.add_le_add_right (Nat.mul_le_mul_left _ hcoord) n)

end TwoColorNullity
