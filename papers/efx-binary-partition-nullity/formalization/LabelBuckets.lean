import ProjectedAllocation
import Mathlib.Data.List.FinRange
import Mathlib.Algebra.BigOperators.Group.Finset.Defs

open scoped BigOperators

namespace TwoColorNullity

def packBits : List Bool → ℕ
  | [] => 0
  | bit :: rest => (if bit then 1 else 0) + 2 * packBits rest

theorem packBits_lt (bits : List Bool) : packBits bits < 2 ^ bits.length := by
  induction bits with
  | nil => decide
  | cons bit rest ih =>
    rw [List.length_cons, pow_succ]
    cases bit <;> simp [packBits] <;> omega

theorem packBits_injective_of_length {a b : List Bool}
    (hsize : a.length = b.length) (hvalue : packBits a = packBits b) : a = b := by
  induction a generalizing b with
  | nil => exact (List.length_eq_zero_iff.mp hsize.symm).symm
  | cons bit rest ih =>
    cases b with
    | nil => simp at hsize
    | cons bit' rest' =>
      have hs : rest.length = rest'.length := by
        simp only [List.length_cons] at hsize
        omega
      cases bit <;> cases bit' <;>
        simp [packBits] at hvalue
      · rw [ih hs (by omega)]
      · omega
      · omega
      · rw [ih hs (by omega)]

structure BucketArray (Item : Type*) (labels : ℕ) where
  data : Array (List Item)
  size_eq : data.size = labels

namespace BucketArray

def empty {Item : Type*} (labels : ℕ) : BucketArray Item labels :=
  ⟨Array.replicate labels [], by simp⟩

def get {Item : Type*} {labels : ℕ} (buckets : BucketArray Item labels) (label : Fin labels) : List Item :=
  buckets.data[label.val]'(by rw [buckets.size_eq]; exact label.isLt)

def push {Item : Type*} {labels : ℕ} (buckets : BucketArray Item labels) (label : Fin labels) (item : Item) :
    BucketArray Item labels :=
  ⟨buckets.data.set label.val (item :: buckets.get label) (by rw [buckets.size_eq]; exact label.isLt),
    by simp [buckets.size_eq]⟩

theorem get_push {Item : Type*} {labels : ℕ} (buckets : BucketArray Item labels)
    (label bucket : Fin labels) (item : Item) :
    (buckets.push label item).get bucket =
      if bucket = label then item :: buckets.get bucket else buckets.get bucket := by
  by_cases h : bucket = label
  · subst bucket
    simp only [get, push, Array.getElem_set_self, if_true]
  · have hne : label.val ≠ bucket.val := fun eq => h (Fin.ext eq.symm)
    rw [if_neg h]
    unfold get push
    rw [Array.getElem_set_ne _ _ hne]

def load {Item : Type*} {labels : ℕ} (label : Item → Fin labels) :
    List Item → BucketArray Item labels → BucketArray Item labels
  | [], buckets => buckets
  | item :: items, buckets => load label items (buckets.push (label item) item)

theorem get_load {Item : Type*} {labels : ℕ} (label : Item → Fin labels)
    (items : List Item) (buckets : BucketArray Item labels) (bucket : Fin labels) :
    (load label items buckets).get bucket =
      (items.filter (fun item => decide (label item = bucket))).reverse ++ buckets.get bucket := by
  induction items generalizing buckets with
  | nil => rfl
  | cons item items ih =>
    rw [load, ih, get_push]
    by_cases h : label item = bucket
    · simp [h, List.reverse_cons, List.append_assoc]
    · have h' : bucket ≠ label item := Ne.symm h
      simp [h, h']

theorem get_loaded {Item : Type*} {labels : ℕ} (label : Item → Fin labels)
    (items : List Item) (bucket : Fin labels) :
    (load label items (empty labels)).get bucket =
      (items.filter (fun item => decide (label item = bucket))).reverse := by
  rw [get_load]
  simp [empty, get]

end BucketArray

def pairAdjacent {Item : Type*} : List Item → List (Item × Item)
  | a :: b :: rest => (a, b) :: pairAdjacent rest
  | _ => []

theorem pairAdjacent_length {Item : Type*} : ∀ items : List Item,
    (pairAdjacent items).length = items.length / 2
  | [] => by simp [pairAdjacent]
  | [_] => by simp [pairAdjacent]
  | _ :: _ :: rest => by
    simp only [pairAdjacent, List.length_cons, pairAdjacent_length rest]
    omega

def bucketPairs {Item : Type*} {labels : ℕ} (label : Item → Fin labels) (items : List Item) :
    List (Item × Item) :=
  let buckets := BucketArray.load label items (BucketArray.empty labels)
  (List.finRange labels).flatMap fun bucket => pairAdjacent (buckets.get bucket)

theorem bucketPairs_length {Item : Type*} {labels : ℕ} (label : Item → Fin labels) (items : List Item) :
    (bucketPairs label items).length =
      ∑ bucket : Fin labels, (items.filter (fun item => decide (label item = bucket))).length / 2 := by
  unfold bucketPairs
  rw [List.length_flatMap, ← List.toFinset_finRange]
  unfold Finset.sum
  rw [List.toFinset_val, (List.nodup_finRange labels).dedup]
  simp only [Multiset.map_coe, Multiset.sum_coe, pairAdjacent_length, BucketArray.get_loaded, List.length_reverse]

end TwoColorNullity
