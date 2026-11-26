import Semantics

open scoped BigOperators
noncomputable section

namespace OrdinaryEF1

/-- The bundle of a recipient in the total-function representation. -/
noncomputable def bundle {n m : ℕ} (A : Fin m → Fin n) (r : Fin n) : Finset (Fin m) :=
  Finset.univ.filter (fun x => A x = r)

@[simp] theorem mem_bundle {n m : ℕ} (A : Fin m → Fin n)
    (r : Fin n) (x : Fin m) : x ∈ bundle A r ↔ A x = r := by
  simp [bundle]

theorem item_has_unique_owner {n m : ℕ} (A : Fin m → Fin n) (x : Fin m) :
    ∃! r : Fin n, x ∈ bundle A r := by
  refine ⟨A x, by simp, ?_⟩
  intro r hr
  exact (mem_bundle A r x).mp hr |>.symm

theorem bundles_disjoint {n m : ℕ} (A : Fin m → Fin n)
    (r s : Fin n) (hrs : r ≠ s) : Disjoint (bundle A r) (bundle A s) := by
  apply Finset.disjoint_left.mpr
  intro x hxr hxs
  exact hrs (((mem_bundle A r x).mp hxr).symm.trans ((mem_bundle A s x).mp hxs))

theorem bundles_cover {n m : ℕ} (A : Fin m → Fin n) :
    Finset.univ.biUnion (bundle A) = Finset.univ := by
  ext x
  simp

/-- Completeness imposes unique ownership, and imposes no nonemptiness
condition on any individual bundle. -/
noncomputable def CompletePartition {n m : ℕ} (B : Fin n → Finset (Fin m)) : Prop :=
  ∀ x : Fin m, ∃! r : Fin n, x ∈ B r

theorem total_allocation_is_complete_partition {n m : ℕ}
    (A : Fin m → Fin n) : CompletePartition (bundle A) :=
  item_has_unique_owner A

/-- Conversely every complete partition has an exact total-function encoding. -/
theorem complete_partition_has_allocation {n m : ℕ}
    (B : Fin n → Finset (Fin m)) (hB : CompletePartition B) :
    ∃ A : Fin m → Fin n, ∀ r : Fin n, bundle A r = B r := by
  classical
  let A : Fin m → Fin n := fun x => Classical.choose (hB x).exists
  have hA : ∀ x : Fin m, x ∈ B (A x) := fun x => Classical.choose_spec (hB x).exists
  refine ⟨A, ?_⟩
  intro r
  ext x
  constructor
  · intro hx
    have har := (mem_bundle A r x).mp hx
    simpa only [har] using hA x
  · intro hx
    apply (mem_bundle A r x).mpr
    exact (hB x).unique (hA x) hx

theorem allocation_determined_by_bundles {n m : ℕ}
    (A B : Fin m → Fin n) (h : ∀ r, bundle A r = bundle B r) : A = B := by
  funext x
  have hx : x ∈ bundle B (A x) := by rw [← h]; simp
  exact ((mem_bundle B (A x) x).mp hx).symm

/-- Empty bundles are included, for example when all items go to another agent. -/
theorem constant_allocation_empty_other_bundle {n m : ℕ}
    (p q : Fin n) (hpq : p ≠ q) : bundle (fun _ : Fin m => p) q = ∅ := by
  ext x
  simp [hpq]

theorem swapRecipient_involutive {n : ℕ} (i j r : Fin n) :
    swapRecipient i j (swapRecipient i j r) = r := by
  by_cases hij : i = j
  · subst j
    by_cases hi : r = i <;> simp [swapRecipient, hi]
  · by_cases hi : r = i
    · subst r
      simp [swapRecipient, hij, Ne.symm hij]
    · by_cases hj : r = j
      · subst r
        simp [swapRecipient, hij, Ne.symm hij]
      · simp [swapRecipient, hi, hj]

theorem swapRecipient_eq_iff {n : ℕ} (i j r s : Fin n) :
    swapRecipient i j r = s ↔ r = swapRecipient i j s := by
  constructor
  · intro h
    have := congrArg (swapRecipient i j) h
    simpa only [swapRecipient_involutive] using this
  · intro h
    rw [h, swapRecipient_involutive]

@[simp] theorem swapRecipient_left {n : ℕ} (i j : Fin n) :
    swapRecipient i j i = j := by simp [swapRecipient]

@[simp] theorem swapRecipient_right {n : ℕ} (i j : Fin n) :
    swapRecipient i j j = i := by
  by_cases hij : i = j
  · subst j; simp [swapRecipient]
  · simp [swapRecipient, Ne.symm hij]

theorem swapped_bundle_left {n m : ℕ} (A : Fin m → Fin n) (i j : Fin n) :
    bundle (swapped A i j) i = bundle A j := by
  ext x
  simp only [mem_bundle, swapped, swapRecipient_eq_iff, swapRecipient_left]

theorem swapped_bundle_right {n m : ℕ} (A : Fin m → Fin n) (i j : Fin n) :
    bundle (swapped A i j) j = bundle A i := by
  ext x
  simp only [mem_bundle, swapped, swapRecipient_eq_iff, swapRecipient_right]

theorem swapped_bundle_other {n m : ℕ} (A : Fin m → Fin n)
    (i j r : Fin n) (hri : r ≠ i) (hrj : r ≠ j) :
    bundle (swapped A i j) r = bundle A r := by
  ext x
  simp only [mem_bundle, swapped, swapRecipient_eq_iff]
  simp [swapRecipient, hri, hrj]

theorem swapped_twice {n m : ℕ} (A : Fin m → Fin n) (i j : Fin n) :
    swapped (swapped A i j) i j = A := by
  funext x
  exact swapRecipient_involutive i j (A x)

/-- Regrouping the original utility by recipient gives the manuscript's
double sum, including deletion of items from any recipient's bundle. -/
theorem utility_by_recipient {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n)
    (i : Fin n) (S : Finset (Fin m)) :
    utility u A i S =
      ∑ r : Fin n, ∑ x ∈ bundle A r, if x ∈ S then 0 else u i r x := by
  classical
  unfold utility bundle
  simp_rw [Finset.sum_filter]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro x _
  simp

theorem utility_by_deleted_bundles {n m : ℕ}
    (u : Fin n → Fin n → Fin m → ℝ) (A : Fin m → Fin n)
    (i : Fin n) (S : Finset (Fin m)) :
    utility u A i S = ∑ r : Fin n, ∑ x ∈ bundle A r \ S, u i r x := by
  classical
  rw [utility_by_recipient]
  apply Finset.sum_congr rfl
  intro r _
  have hfilter : bundle A r \ S = (bundle A r).filter (fun x => x ∉ S) := by
    ext x
    simp
  rw [hfilter, Finset.sum_filter]
  apply Finset.sum_congr rfl
  intro x _
  by_cases hx : x ∈ S <;> simp [hx]

#print axioms complete_partition_has_allocation
#print axioms utility_by_deleted_bundles
#print axioms swapped_bundle_left

end OrdinaryEF1
