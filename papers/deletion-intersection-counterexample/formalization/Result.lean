/-
Counterexamples to Conjecture 1 of Wang, Fang, Li and Fu,
"Some New Results on Sequence Reconstruction Problem for Deletion Channels",
arXiv:2601.06503v2.

Binary symbols 0 and 1 are represented by false and true, respectively.
The formal mathematical scope is two finite witnesses, the original minimum
and maximum definitions, and the negation of the quantified conjecture.
The file uses Lean 4.19.0's default Init library, with no external imports.
-/

set_option Elab.async false
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

namespace EDEGFormalization

abbrev Word := List Bool

/-- A complete enumeration of binary lists, without repeated outputs. -/
noncomputable def allWords : Nat → List Word
  | 0 => [[]]
  | n+1 => (allWords n).map (false :: ·) ++ (allWords n).map (true :: ·)

theorem mem_allWords (n : Nat) (z : Word) : z ∈ allWords n ↔ z.length = n := by
  induction n generalizing z with
  | zero => cases z <;> simp [allWords]
  | succ n ih =>
    cases z with
    | nil => simp [allWords]
    | cons b z => cases b <;> simp [allWords, ih]

theorem nodup_map_cons (b : Bool) (l : List Word) (h : l.Nodup) :
    (l.map (b :: ·)).Nodup := by
  apply List.pairwise_map.mpr
  exact h.imp (fun hne heq => hne (List.cons.inj heq).2)

theorem allWords_nodup (n : Nat) : (allWords n).Nodup := by
  induction n with
  | zero => simp [allWords]
  | succ n ih =>
    change ((allWords n).map (false :: ·) ++ (allWords n).map (true :: ·)).Nodup
    apply List.pairwise_append.mpr
    refine ⟨nodup_map_cons false _ ih, nodup_map_cons true _ ih, ?_⟩
    intro a ha b hb hab
    obtain ⟨u, _, rfl⟩ := List.mem_map.mp ha
    obtain ⟨v, _, rfl⟩ := List.mem_map.mp hb
    have impossible : false = true := (List.cons.inj hab).1
    cases impossible

/-- Exact deletion counts; invalid counts produce no output. -/
noncomputable def commonOutputs (n t : Nat) (x y : Word) : List Word :=
  if t ≤ n then
    (allWords (n-t)).filter (fun z => decide (z.Sublist x ∧ z.Sublist y))
  else []

noncomputable def commonCount (n t : Nat) (x y : Word) : Nat := (commonOutputs n t x y).length

theorem mem_commonOutputs (n t : Nat) (x y z : Word) :
    z ∈ commonOutputs n t x y ↔
      t ≤ n ∧ z.length = n-t ∧ z.Sublist x ∧ z.Sublist y := by
  by_cases h : t ≤ n
  · simp [commonOutputs, h, mem_allWords, and_assoc]
  · simp [commonOutputs, h]

theorem commonOutputs_nodup (n t : Nat) (x y : Word) :
    (commonOutputs n t x y).Nodup := by
  by_cases h : t ≤ n
  · simp only [commonOutputs, h, if_true]
    exact List.Pairwise.filter _ (allWords_nodup (n-t))
  · simp [commonOutputs, h]

noncomputable def x : Word := [false,true,false,true,false,true,false,true,false,false,true,true,false]
theorem x_length : x.length = 13 := by decide

noncomputable def y : Word := [true,false,false,true,true,false,true,false,true,false,true,false,true]
theorem y_length : y.length = 13 := by decide

noncomputable def x15 : Word := [false,true,false,true,false,true,false,true,false,true,false,false,true,true,false]
theorem x15_length : x15.length = 15 := by decide

noncomputable def y15 : Word := [true,false,false,true,true,false,true,false,true,false,true,false,true,false,true]
theorem y15_length : y15.length = 15 := by decide

/-- A finite cardinality witness for a set of binary strings. -/
noncomputable def HasCardinality (P : Word → Prop) (c : Nat) : Prop :=
  ∃ L : List Word, L.Nodup ∧ (∀ z, z ∈ L ↔ P z) ∧ L.length = c

/-- A duplicate-free list counts each member once. -/
theorem nodup_count {α : Type} [DecidableEq α] (L : List α) (h : L.Nodup) (a : α) :
    L.count a = if a ∈ L then 1 else 0 := by
  induction L with
  | nil => simp
  | cons b L ih =>
    obtain ⟨hb, hL⟩ := List.nodup_cons.mp h
    by_cases hba : b = a
    · subst b
      simp [List.count_eq_zero_of_not_mem hb]
    · simpa [List.count_cons_of_ne hba, hba, Ne.symm hba] using ih hL

/-- The finite cardinality witness has a unique numerical value. -/
theorem HasCardinality_unique {P : Word → Prop} {c d : Nat}
    (hc : HasCardinality P c) (hd : HasCardinality P d) : c = d := by
  obtain ⟨L, hL, hmL, hlL⟩ := hc
  obtain ⟨K, hK, hmK, hlK⟩ := hd
  have hp : L.Perm K := List.perm_iff_count.mpr (fun z => by
    by_cases hz : z ∈ L
    · have hk : z ∈ K := (hmK z).mpr ((hmL z).mp hz)
      simp only [nodup_count L hL z, nodup_count K hK z, if_pos hz, if_pos hk]
    · have hk : z ∉ K := fun h => hz ((hmL z).mpr ((hmK z).mp h))
      simp only [nodup_count L hL z, nodup_count K hK z, if_neg hz, if_neg hk])
  exact hlL.symm.trans (hp.length_eq.trans hlK)

/-- The computed length is the cardinality of exactly the source's common-output set. -/
theorem commonCount_cardinality (n t : Nat) (a b : Word) :
    HasCardinality (fun z => t ≤ n ∧ z.length = n-t ∧
      z.Sublist a ∧ z.Sublist b) (commonCount n t a b) := by
  exact ⟨commonOutputs n t a b, commonOutputs_nodup n t a b,
    fun z => mem_commonOutputs n t a b z, rfl⟩

/-- The least value of a finite list, with a declared default. -/
noncomputable def minList (fallback : Nat) : List Nat → Nat
  | [] => fallback
  | a :: L => min a (minList fallback L)

theorem minList_le_of_mem (fallback : Nat) {L : List Nat} {a : Nat}
    (ha : a ∈ L) : minList fallback L ≤ a := by
  induction L with
  | nil => cases ha
  | cons b L ih =>
    rcases List.mem_cons.mp ha with h | h
    · subst a
      exact Nat.min_le_left _ _
    · exact Nat.le_trans (Nat.min_le_right _ _) (ih h)

theorem minList_good (P : Nat → Prop) (fallback : Nat) (L : List Nat)
    (hf : P fallback) (hL : ∀ a ∈ L, P a) : P (minList fallback L) := by
  induction L with
  | nil => exact hf
  | cons a L ih =>
    have ht : P (minList fallback L) := ih (fun b hb => hL b (List.mem_cons_of_mem a hb))
    rcases Nat.le_total a (minList fallback L) with h | h
    · rw [minList, Nat.min_eq_left h]
      exact hL a (by simp)
    · rw [minList, Nat.min_eq_right h]
      exact ht

/-- An empty list is the unique output after deleting every symbol. -/
theorem all_deleted_count (n : Nat) (a b : Word) : commonCount n n a b = 1 := by
  simp [commonCount, commonOutputs, allWords]

theorem commonCount_pos_bound (n t : Nat) (a b : Word)
    (h : 0 < commonCount n t a b) : t ≤ n := by
  by_cases htn : t ≤ n
  · exact htn
  · simp [commonCount, commonOutputs, htn] at h

/-- All natural deletion counts with a nonempty common-output set. -/
noncomputable def meetingIndices (a b : Word) : List Nat :=
  (List.range (a.length+1)).filter (fun t => decide (0 < commonCount a.length t a b))

theorem mem_meetingIndices (a b : Word) (t : Nat) :
    t ∈ meetingIndices a b ↔ 0 < commonCount a.length t a b := by
  constructor
  · intro h
    exact of_decide_eq_true (List.mem_filter.mp h).2
  · intro h
    apply List.mem_filter.mpr
    exact ⟨List.mem_range.mpr (Nat.lt_succ_of_le (commonCount_pos_bound _ _ _ _ h)),
      by simp [h]⟩

/-- Levenshtein distance in the paper: least deletions per word to produce a common output. -/
noncomputable def deletionDistance (a b : Word) : Nat :=
  minList a.length (meetingIndices a b)

/-- Exact minimum property over all natural deletion counts, not merely a bounded proxy. -/
theorem deletionDistance_spec (a b : Word) :
    0 < commonCount a.length (deletionDistance a b) a b ∧
    ∀ t, 0 < commonCount a.length t a b → deletionDistance a b ≤ t := by
  constructor
  · apply minList_good (fun t => 0 < commonCount a.length t a b)
    · rw [all_deleted_count]
      decide
    · intro t ht
      exact (mem_meetingIndices a b t).mp ht
  · intro t ht
    exact minList_le_of_mem _ ((mem_meetingIndices a b t).mpr ht)

theorem commonCount_pos_iff (n t : Nat) (a b : Word) :
    0 < commonCount n t a b ↔
      ∃ z : Word, t ≤ n ∧ z.length = n-t ∧ z.Sublist a ∧ z.Sublist b := by
  unfold commonCount
  rw [List.length_pos_iff_exists_mem]
  constructor
  · rintro ⟨z, hz⟩
    exact ⟨z, (mem_commonOutputs n t a b z).mp hz⟩
  · rintro ⟨z, hz⟩
    exact ⟨z, (mem_commonOutputs n t a b z).mpr hz⟩

/-- The minimum property restated literally in the source's list/subsequence language. -/
theorem deletionDistance_list_minimum (a b : Word) :
    (∃ z : Word, deletionDistance a b ≤ a.length ∧
      z.length = a.length-deletionDistance a b ∧ z.Sublist a ∧ z.Sublist b) ∧
    ∀ t, (∃ z : Word, t ≤ a.length ∧ z.length = a.length-t ∧
      z.Sublist a ∧ z.Sublist b) → deletionDistance a b ≤ t := by
  obtain ⟨hp, hleast⟩ := deletionDistance_spec a b
  exact ⟨(commonCount_pos_iff _ _ _ _).mp hp,
    fun t ht => hleast t ((commonCount_pos_iff _ _ _ _).mpr ht)⟩

/-- Three zero counts and one positive count prove the source distance exactly. -/
theorem distance_three_of_counts (a b : Word)
    (h0 : commonCount a.length 0 a b = 0)
    (h1 : commonCount a.length 1 a b = 0)
    (h2 : commonCount a.length 2 a b = 0)
    (h3 : 0 < commonCount a.length 3 a b) : deletionDistance a b = 3 := by
  obtain ⟨hp, hleast⟩ := deletionDistance_spec a b
  have hu : deletionDistance a b ≤ 3 := hleast 3 h3
  have hl : 3 ≤ deletionDistance a b := by
    by_cases hn : 3 ≤ deletionDistance a b
    · exact hn
    · have hc : deletionDistance a b = 0 ∨ deletionDistance a b = 1 ∨
        deletionDistance a b = 2 := by omega
      rcases hc with h | h | h
      · rw [h, h0] at hp
        exact False.elim (Nat.not_lt_zero _ hp)
      · rw [h, h1] at hp
        exact False.elim (Nat.not_lt_zero _ hp)
      · rw [h, h2] at hp
        exact False.elim (Nat.not_lt_zero _ hp)
  exact Nat.le_antisymm hu hl

/-- Maximum of a finite list of naturals, extended by zero for the empty list. -/
noncomputable def maxList : List Nat → Nat
  | [] => 0
  | a :: L => max a (maxList L)

theorem maxList_le_iff (L : List Nat) (b : Nat) :
    maxList L ≤ b ↔ ∀ a ∈ L, a ≤ b := by
  induction L with
  | nil => simp [maxList]
  | cons a L ih => simp only [maxList, Nat.max_le, List.forall_mem_cons, ih]

theorem member_le_maxList {L : List Nat} {a : Nat} (ha : a ∈ L) : a ≤ maxList L :=
  (maxList_le_iff L (maxList L)).mp (Nat.le_refl _) a ha

/-- The maximum over every admissible pair of length-n binary strings. -/
noncomputable def N (n d t : Nat) : Nat :=
  maxList ((allWords n).map (fun a =>
    maxList ((allWords n).map (fun b =>
      if d ≤ deletionDistance a b then commonCount n t a b else 0))))

/-- A concrete admissible pair bounds the full maximum from below. -/
theorem pair_count_le_N (n d t : Nat) (a b : Word)
    (ha : a.length = n) (hb : b.length = n) (hd : d ≤ deletionDistance a b) :
    commonCount n t a b ≤ N n d t := by
  have hi : (if d ≤ deletionDistance a b then commonCount n t a b else 0) ≤
      maxList ((allWords n).map (fun b =>
        if d ≤ deletionDistance a b then commonCount n t a b else 0)) :=
    member_le_maxList (List.mem_map.mpr ⟨b, (mem_allWords n b).mpr hb, rfl⟩)
  have ho : maxList ((allWords n).map (fun b =>
        if d ≤ deletionDistance a b then commonCount n t a b else 0)) ≤ N n d t :=
    member_le_maxList (List.mem_map.mpr ⟨a, (mem_allWords n a).mpr ha, rfl⟩)
  simpa only [hd, if_true] using Nat.le_trans hi ho

/-- Universal characterization of N as the true maximum, not just one selected pair. -/
theorem N_le_iff (n d t c : Nat) :
    N n d t ≤ c ↔ ∀ a b : Word, a.length = n → b.length = n →
      d ≤ deletionDistance a b → commonCount n t a b ≤ c := by
  constructor
  · intro h a b ha hb hd
    exact Nat.le_trans (pair_count_le_N n d t a b ha hb hd) h
  · intro h
    apply (maxList_le_iff _ c).mpr
    intro v hv
    obtain ⟨a, ha, rfl⟩ := List.mem_map.mp hv
    apply (maxList_le_iff _ c).mpr
    intro w hw
    obtain ⟨b, hb, rfl⟩ := List.mem_map.mp hw
    by_cases hd : d ≤ deletionDistance a b
    · simpa [hd] using h a b ((mem_allWords n a).mp ha) ((mem_allWords n b).mp hb) hd
    · simp [hd]

/-- Standard Pascal definition of the binomial coefficient. These are precisely
    the defining equations of mathlib's Nat.choose, without importing its dependencies. -/
noncomputable def binomial : Nat → Nat → Nat
  | _, 0 => 1
  | 0, _+1 => 0
  | n+1, k+1 => binomial n k + binomial n (k+1)

theorem binomial_zero (n : Nat) : binomial n 0 = 1 := by cases n <;> rfl
theorem binomial_zero_succ (k : Nat) : binomial 0 (k+1) = 0 := rfl
theorem binomial_succ_succ (n k : Nat) :
    binomial (n+1) (k+1) = binomial n k + binomial n (k+1) := rfl

/-- The defining equations uniquely specify this standard binomial function. -/
theorem binomial_unique (f : Nat → Nat → Nat)
    (h0 : ∀ n, f n 0 = 1) (hz : ∀ k, f 0 (k+1) = 0)
    (hs : ∀ n k, f (n+1) (k+1) = f n k + f n (k+1)) :
    ∀ n k, f n k = binomial n k := by
  intro n
  induction n with
  | zero => intro k; cases k with
    | zero => exact h0 0
    | succ k => exact hz k
  | succ n ih => intro k; cases k with
    | zero => exact h0 (n+1)
    | succ k => rw [hs, ih k, ih (k+1)]; rfl

/-- The source's deletion-ball function, with signed parameters and all invalid
    parameter conventions enforced before any conversion to natural numbers. -/
noncomputable def D (n t : Int) : Nat :=
  if n < 0 ∨ t < 0 ∨ n < t then 0
  else ((List.range (t.toNat+1)).map (fun i => binomial (n-t).toNat i)).sum

/-- The exact six-term source formula; subtraction occurs in the integers. -/
noncomputable def M (n t : Nat) : Nat :=
  6 * D ((n : Int)-6) ((t : Int)-3) +
  4 * D ((n : Int)-8) ((t : Int)-3) +
  6 * D ((n : Int)-9) ((t : Int)-3) +
  4 * D ((n : Int)-11) ((t : Int)-3) +
  2 * D ((n : Int)-13) ((t : Int)-5) +
      D ((n : Int)-13) ((t : Int)-6)

noncomputable def SourceConjecture : Prop :=
  ∀ n t : Nat, 5 ≤ t → t+8 ≤ n → N n 3 t = M n t

theorem formula13_terms :
    D 7 2 = 16 ∧ D 5 2 = 7 ∧ D 4 2 = 4 ∧ D 2 2 = 1 ∧
    D 0 0 = 1 ∧ D 0 (-1) = 0 ∧ M 13 5 = 154 := by decide

theorem formula15_terms :
    D 9 2 = 29 ∧ D 7 2 = 16 ∧ D 6 2 = 11 ∧ D 4 2 = 4 ∧
    D 2 0 = 1 ∧ D 2 (-1) = 0 ∧ M 15 5 = 322 := by decide

/-- If a shorter target length admits no common output, no longer target does. -/
theorem commonCount_zero_of_le {n s t : Nat} {a b : Word}
    (htn : t ≤ n) (hst : s ≤ t) (hzero : commonCount n t a b = 0) :
    commonCount n s a b = 0 := by
  change (commonOutputs n s a b).length = 0
  apply List.length_eq_zero_iff.mpr
  apply List.eq_nil_iff_forall_not_mem.mpr
  intro z hz
  obtain ⟨_, hlen, hza, hzb⟩ := (mem_commonOutputs n s a b z).mp hz
  have htake : n-t ≤ z.length := by omega
  have hz' : z.take (n-t) ∈ commonOutputs n t a b := by
    apply (mem_commonOutputs n t a b (z.take (n-t))).mpr
    refine ⟨htn, ?_, (List.take_sublist _ _).trans hza, (List.take_sublist _ _).trans hzb⟩
    simp only [List.length_take, Nat.min_eq_left htake]
  have hempty : commonOutputs n t a b = [] := List.length_eq_zero_iff.mp hzero
  rw [hempty] at hz'
  exact List.not_mem_nil hz'

/-- Enumerate retained-position choices; repeats are permitted in this auxiliary list. -/
noncomputable def subwords : Nat → Word → List Word
  | 0, _ => [[]]
  | _+1, [] => []
  | k+1, b :: w =>
    if k ≤ w.length then (subwords k w).map (b :: ·) ++ subwords (k+1) w else []

/-- Every subsequence occurs among the retained-position choices. -/
theorem subwords_complete {z w : Word} (h : z.Sublist w) :
    z ∈ subwords z.length w := by
  induction h with
  | slnil => simp [subwords]
  | @cons l₁ l₂ a h ih =>
    cases l₁ with
    | nil => simp [subwords]
    | cons b z =>
      have hbound : z.length ≤ l₂.length := by
        have hlen := h.length_le
        simp only [List.length_cons] at hlen
        omega
      simp only [List.length_cons, subwords, hbound, if_true]
      exact List.mem_append_right _ ih
  | @cons₂ l₁ l₂ a h ih =>
    simp only [List.length_cons, subwords, h.length_le, if_true]
    exact List.mem_append_left _ (List.mem_map.mpr ⟨l₁, ih, rfl⟩)

/-- Exhausting position choices suffices to exclude all common outputs. -/
theorem commonCount_zero_of_exclusion {n t : Nat} {a b : Word}
    (hexclude : ∀ z ∈ subwords (n-t) a, ¬ z.Sublist b) :
    commonCount n t a b = 0 := by
  change (commonOutputs n t a b).length = 0
  apply List.length_eq_zero_iff.mpr
  apply List.eq_nil_iff_forall_not_mem.mpr
  intro z hz
  obtain ⟨_, hlen, hza, hzb⟩ := (mem_commonOutputs n t a b z).mp hz
  apply hexclude z _ hzb
  rw [← hlen]
  exact subwords_complete hza

/-- The standard Boolean sublist test has precisely the same filter as the proposition. -/
theorem commonOutputs_bool (n t : Nat) (a b : Word) :
    commonOutputs n t a b =
      if t ≤ n then (allWords (n-t)).filter (fun z => z.isSublist a && z.isSublist b)
      else [] := by
  by_cases h : t ≤ n
  · simp only [commonOutputs, h, if_true]
    apply List.filter_congr
    intro z _
    apply Bool.eq_iff_iff.mpr
    simp
  · simp [commonOutputs, h]

/-- Count an arbitrary Boolean predicate over all binary suffixes. -/
noncomputable def filteredCount (k : Nat) (p : Word → Bool) : Nat :=
  ((allWords k).filter p).length

/-- Partition exhaustive output counting by the first output bit. -/
theorem filteredCount_succ (k : Nat) (p : Word → Bool) :
    filteredCount (k+1) p =
      filteredCount k (fun w => p (false :: w)) +
      filteredCount k (fun w => p (true :: w)) := by
  unfold filteredCount
  rw [allWords, List.filter_append, List.length_append, List.filter_map,
    List.filter_map, List.length_map, List.length_map]
  rfl

theorem allWords8_length : (allWords 8).length = 256 := by decide +kernel

theorem allWords10_length : (allWords 10).length = 1024 := by decide +kernel

theorem exclude13_2 : ∀ z ∈ subwords 11 x, ¬ z.Sublist y := by decide +kernel

theorem count13_2 : commonCount 13 2 x y = 0 :=
  commonCount_zero_of_exclusion exclude13_2

theorem count13_0 : commonCount 13 0 x y = 0 :=
  commonCount_zero_of_le (t := 2) (by decide) (by decide) count13_2

theorem count13_1 : commonCount 13 1 x y = 0 :=
  commonCount_zero_of_le (t := 2) (by decide) (by decide) count13_2

theorem count13_5 : commonCount 13 5 x y = 155 := by
  rw [commonCount, commonOutputs_bool]
  decide +kernel

theorem count13_3 : commonCount 13 3 x y = 20 := by
  rw [commonCount, commonOutputs_bool]
  decide +kernel

theorem exclude15_2 : ∀ z ∈ subwords 13 x15, ¬ z.Sublist y15 := by decide +kernel

theorem count15_2 : commonCount 15 2 x15 y15 = 0 :=
  commonCount_zero_of_exclusion exclude15_2

theorem count15_0 : commonCount 15 0 x15 y15 = 0 :=
  commonCount_zero_of_le (t := 2) (by decide) (by decide) count15_2

theorem count15_1 : commonCount 15 1 x15 y15 = 0 :=
  commonCount_zero_of_le (t := 2) (by decide) (by decide) count15_2

theorem count15_5 : commonCount 15 5 x15 y15 = 324 := by
  rw [commonCount, commonOutputs_bool]
  decide +kernel

theorem count15_3_00 :
    filteredCount 10 (fun w =>
      (false :: false :: w).isSublist x15 && (false :: false :: w).isSublist y15) = 6 := by decide +kernel

theorem count15_3_01 :
    filteredCount 10 (fun w =>
      (false :: true :: w).isSublist x15 && (false :: true :: w).isSublist y15) = 4 := by decide +kernel

theorem count15_3_10 :
    filteredCount 10 (fun w =>
      (true :: false :: w).isSublist x15 && (true :: false :: w).isSublist y15) = 10 := by decide +kernel

theorem count15_3_11 :
    filteredCount 10 (fun w =>
      (true :: true :: w).isSublist x15 && (true :: true :: w).isSublist y15) = 0 := by decide +kernel

theorem count15_3 : commonCount 15 3 x15 y15 = 20 := by
  rw [commonCount, commonOutputs_bool]
  change filteredCount 12 (fun w => w.isSublist x15 && w.isSublist y15) = 20
  rw [filteredCount_succ 11, filteredCount_succ 10, filteredCount_succ 10]
  rw [count15_3_00, count15_3_01, count15_3_10, count15_3_11]

/-- The first pair has exactly the source's deletion distance three. -/
theorem distance13 : deletionDistance x y = 3 := by
  apply distance_three_of_counts x y
  · simpa only [x_length] using count13_0
  · simpa only [x_length] using count13_1
  · simpa only [x_length] using count13_2
  · rw [x_length, count13_3]
    decide

/-- The second pair also has exactly the source's deletion distance three. -/
theorem distance15 : deletionDistance x15 y15 = 3 := by
  apply distance_three_of_counts x15 y15
  · simpa only [x15_length] using count15_0
  · simpa only [x15_length] using count15_1
  · simpa only [x15_length] using count15_2
  · rw [x15_length, count15_3]
    decide

/-- Claim 1: the displayed binary words both have length thirteen. -/
theorem Claim1 : x.length = 13 ∧ y.length = 13 := ⟨x_length, y_length⟩

/-- Claim 2: the exact counts establishing deletion distance three. -/
theorem Claim2 :
    commonCount 13 0 x y = 0 ∧ commonCount 13 1 x y = 0 ∧
    commonCount 13 2 x y = 0 ∧ commonCount 13 3 x y = 20 ∧
    deletionDistance x y = 3 :=
  ⟨count13_0, count13_1, count13_2, count13_3, distance13⟩

/-- Claim 3: exactly 155 distinct common outputs after five deletions. -/
theorem Claim3 : commonCount 13 5 x y = 155 := count13_5

/-- Claim 4: the six signed-parameter terms and their source-formula sum. -/
theorem Claim4 :
    D 7 2 = 16 ∧ D 5 2 = 7 ∧ D 4 2 = 4 ∧ D 2 2 = 1 ∧
    D 0 0 = 1 ∧ D 0 (-1) = 0 ∧ M 13 5 = 154 := formula13_terms

theorem M13 : M 13 5 = 154 := formula13_terms.2.2.2.2.2.2
theorem M15 : M 15 5 = 322 := formula15_terms.2.2.2.2.2.2

/-- Claim 5: a strict lower bound for the original maximum, not an asserted
    exact value of that maximum. -/
theorem Claim5 :
    155 ≤ N 13 3 5 ∧ M 13 5 = 154 ∧
    M 13 5 < N 13 3 5 ∧ N 13 3 5 ≠ M 13 5 := by
  have hd : 3 ≤ deletionDistance x y := by rw [distance13]; decide
  have hn := pair_count_le_N 13 3 5 x y x_length y_length hd
  rw [Claim3] at hn
  have hstrict : M 13 5 < N 13 3 5 := by
    rw [M13]
    exact Nat.lt_of_lt_of_le (by decide : 154 < 155) hn
  exact ⟨hn, M13, hstrict, Ne.symm (Nat.ne_of_lt hstrict)⟩

/-- Claim 6: the universally quantified source Conjecture 1 is false. -/
theorem Claim6 : ¬ SourceConjecture := by
  intro h
  exact Claim5.2.2.2 (h 13 5 (by decide) (by decide))

/-- Claim 7: a second counterexample with the strict length inequality
    n > t+8.  The parameter t remains equal to five. -/
theorem Claim7 :
    x15.length = 15 ∧ y15.length = 15 ∧ 5+8 < (15 : Nat) ∧
    commonCount 15 0 x15 y15 = 0 ∧ commonCount 15 1 x15 y15 = 0 ∧
    commonCount 15 2 x15 y15 = 0 ∧ commonCount 15 3 x15 y15 = 20 ∧
    deletionDistance x15 y15 = 3 ∧ commonCount 15 5 x15 y15 = 324 ∧
    M 15 5 = 322 ∧ 324 ≤ N 15 3 5 ∧
    M 15 5 < N 15 3 5 ∧ N 15 3 5 ≠ M 15 5 := by
  have hd : 3 ≤ deletionDistance x15 y15 := by rw [distance15]; decide
  have hn := pair_count_le_N 15 3 5 x15 y15 x15_length y15_length hd
  rw [count15_5] at hn
  have hstrict : M 15 5 < N 15 3 5 := by
    rw [M15]
    exact Nat.lt_of_lt_of_le (by decide : 322 < 324) hn
  exact ⟨x15_length, y15_length, by decide, count15_0, count15_1,
    count15_2, count15_3, distance15, count15_5, M15, hn, hstrict,
    Ne.symm (Nat.ne_of_lt hstrict)⟩

/-- The strict-length example independently contradicts the same universal claim. -/
theorem strict_length_negates_source : ¬ SourceConjecture := by
  intro h
  have hd : 3 ≤ deletionDistance x15 y15 := by rw [distance15]; decide
  have hn := pair_count_le_N 15 3 5 x15 y15 x15_length y15_length hd
  rw [count15_5] at hn
  have hm := h 15 5 (by decide) (by decide)
  rw [hm, M15] at hn
  exact (by decide : ¬ 324 ≤ 322) hn

/-- Example 1: concrete nonempty, admissible data at the first parameter pair. -/
theorem Example1 :
    5 ≤ (5 : Nat) ∧ 5+8 ≤ (13 : Nat) ∧
    ∃ a b : Word, a.length = 13 ∧ b.length = 13 ∧
      deletionDistance a b = 3 ∧ 0 < commonCount 13 5 a b ∧
      M 13 5 < commonCount 13 5 a b := by
  refine ⟨by decide, by decide, x, y, x_length, y_length, distance13, ?_, ?_⟩
  · rw [count13_5]
    decide
  · rw [M13, count13_5]
    decide

/-- Example 2: concrete nonempty data satisfying the strict length inequality. -/
theorem Example2 :
    5 ≤ (5 : Nat) ∧ 5+8 < (15 : Nat) ∧
    ∃ a b : Word, a.length = 15 ∧ b.length = 15 ∧
      deletionDistance a b = 3 ∧ 0 < commonCount 15 5 a b ∧
      M 15 5 < commonCount 15 5 a b := by
  refine ⟨by decide, by decide, x15, y15, x15_length, y15_length, distance15, ?_, ?_⟩
  · rw [count15_5]
    decide
  · rw [M15, count15_5]
    decide

end EDEGFormalization
