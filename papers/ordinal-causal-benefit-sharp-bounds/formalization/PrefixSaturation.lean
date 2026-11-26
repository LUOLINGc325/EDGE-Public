import Mathlib.Algebra.BigOperators.Group.List.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith

namespace PrefixSaturation

abbrev Box := ℝ × ℝ

def valid (boxes : List Box) : Prop :=
  ∀ box ∈ boxes, box.1 ≤ box.2

def within (boxes : List Box) (allocation : List ℝ) : Prop :=
  List.Forall₂ (fun box mass => box.1 ≤ mass ∧ mass ≤ box.2) boxes allocation

noncomputable def lower (boxes : List Box) : ℝ :=
  (boxes.map Prod.fst).sum

noncomputable def upper (boxes : List Box) : ℝ :=
  (boxes.map Prod.snd).sum

/-- Fill leftmost coordinates to their upper bounds before moving right.
The second argument is the total mass in excess of the lower bounds. -/
noncomputable def allocate : List Box → ℝ → List ℝ
  | [], _ => []
  | box :: boxes, e =>
    let fill := min e (box.2 - box.1)
    (box.1 + fill) :: allocate boxes (e - fill)

private theorem allocate_length (boxes : List Box) (e : ℝ) :
    (allocate boxes e).length = boxes.length := by
  induction boxes generalizing e with
  | nil => simp [allocate]
  | cons box boxes ih => simp [allocate, ih]

private theorem lower_le_upper (boxes : List Box) (hb : valid boxes) :
    lower boxes ≤ upper boxes := by
  induction boxes with
  | nil => simp [lower, upper]
  | cons box boxes ih =>
    have hhead := hb box List.mem_cons_self
    have htail := ih (fun p hp => hb p (List.mem_cons_of_mem box hp))
    simpa [lower, upper] using add_le_add hhead htail

private theorem split_min {e c r : ℝ} (hr : 0 ≤ r) :
    min e c + min (e - min e c) r = min e (c + r) := by
  by_cases h : e ≤ c
  · rw [min_eq_left h, sub_self, min_eq_left hr, add_zero,
      min_eq_left (by linarith : e ≤ c + r)]
  · have hce : c ≤ e := le_of_not_ge h
    rw [min_eq_right hce]
    by_cases ht : e - c ≤ r
    · rw [min_eq_left ht, min_eq_left (by linarith : e ≤ c + r)]
      linarith
    · rw [min_eq_right (le_of_not_ge ht), min_eq_right (by linarith : c + r ≤ e)]

theorem allocate_within (boxes : List Box) (e : ℝ) (hb : valid boxes) (he : 0 ≤ e) :
    within boxes (allocate boxes e) := by
  induction boxes generalizing e with
  | nil => exact List.Forall₂.nil
  | cons box boxes ih =>
    have hhead := hb box List.mem_cons_self
    have htail : valid boxes := fun p hp => hb p (List.mem_cons_of_mem box hp)
    have hfill : 0 ≤ min e (box.2 - box.1) := le_min he (sub_nonneg.mpr hhead)
    have hfill_le := min_le_right e (box.2 - box.1)
    have hremaining := sub_nonneg.mpr (min_le_left e (box.2 - box.1))
    exact List.Forall₂.cons ⟨by linarith, by linarith⟩ (ih _ htail hremaining)

/-- All prefixes simultaneously saturate the smaller of their own slack
and the total extra mass. -/
theorem allocate_prefix_extra (boxes : List Box) (e : ℝ) (hb : valid boxes)
    (he : 0 ≤ e) (k : ℕ) :
    ((allocate boxes e).take k).sum =
      lower (boxes.take k) + min e (upper (boxes.take k) - lower (boxes.take k)) := by
  induction boxes generalizing e k with
  | nil => simp [allocate, lower, upper, min_eq_right he]
  | cons box boxes ih =>
    cases k with
    | zero => simp [lower, upper, min_eq_right he]
    | succ k =>
      have hhead := hb box List.mem_cons_self
      have htail : valid boxes := fun p hp => hb p (List.mem_cons_of_mem box hp)
      have hvalid_take : valid (boxes.take k) := fun p hp => htail p (List.mem_of_mem_take hp)
      have hrest := sub_nonneg.mpr (lower_le_upper (boxes.take k) hvalid_take)
      have hremaining := sub_nonneg.mpr (min_le_left e (box.2 - box.1))
      have hi := ih (e - min e (box.2 - box.1)) htail hremaining k
      have hmin := split_min (e := e) (c := box.2 - box.1) hrest
      simp only [allocate, List.take_succ_cons, List.sum_cons]
      rw [hi]
      have hl : lower (box :: boxes.take k) = box.1 + lower (boxes.take k) := rfl
      have hu : upper (box :: boxes.take k) = box.2 + upper (boxes.take k) := rfl
      rw [hl, hu]
      have hcap : box.2 + upper (boxes.take k) - (box.1 + lower (boxes.take k)) =
          (box.2 - box.1) + (upper (boxes.take k) - lower (boxes.take k)) := by linarith
      rw [hcap]
      linarith

theorem bounds_decompose (boxes : List Box) (k : ℕ) :
    lower (boxes.take k) + lower (boxes.drop k) = lower boxes := by
  unfold lower
  rw [← List.sum_append, ← List.map_append, List.take_append_drop]

/-- The saturated prefix at fixed total is limited only by its own upper
bounds and the lower bounds on the remaining coordinates. -/
theorem allocate_prefix (boxes : List Box) {t : ℝ} (hb : valid boxes)
    (ht : lower boxes ≤ t) (k : ℕ) :
    ((allocate boxes (t - lower boxes)).take k).sum =
      min (upper (boxes.take k)) (t - lower (boxes.drop k)) := by
  rw [allocate_prefix_extra boxes _ hb (sub_nonneg.mpr ht)]
  have hdecomp := bounds_decompose boxes k
  by_cases h : t - lower boxes ≤ upper (boxes.take k) - lower (boxes.take k)
  · rw [min_eq_left h, min_eq_right (by linarith : t - lower (boxes.drop k) ≤ upper (boxes.take k))]
    linarith
  · rw [min_eq_right (le_of_not_ge h),
      min_eq_left (by linarith : upper (boxes.take k) ≤ t - lower (boxes.drop k))]
    linarith

theorem allocate_total (boxes : List Box) {t : ℝ} (hb : valid boxes)
    (htl : lower boxes ≤ t) (htu : t ≤ upper boxes) :
    (allocate boxes (t - lower boxes)).sum = t := by
  have h := allocate_prefix boxes hb htl boxes.length
  have htake : (allocate boxes (t - lower boxes)).take boxes.length =
      allocate boxes (t - lower boxes) :=
    List.take_of_length_le (allocate_length boxes _).le
  rw [htake, List.take_length, List.drop_length] at h
  simpa [lower, min_eq_right htu] using h

private theorem within_sums {boxes : List Box} {allocation : List ℝ}
    (h : within boxes allocation) : lower boxes ≤ allocation.sum ∧ allocation.sum ≤ upper boxes := by
  induction h with
  | nil => simp [lower, upper]
  | @cons box mass boxes allocation hhead _ ih =>
    exact ⟨add_le_add hhead.1 ih.1, add_le_add hhead.2 ih.2⟩

private theorem within_take_drop {boxes : List Box} {allocation : List ℝ}
    (h : within boxes allocation) (k : ℕ) :
    within (boxes.take k) (allocation.take k) ∧ within (boxes.drop k) (allocation.drop k) := by
  induction h generalizing k with
  | nil => simp [within]
  | @cons box mass boxes allocation hhead htail ih =>
    cases k with
    | zero => exact ⟨List.Forall₂.nil, List.Forall₂.cons hhead htail⟩
    | succ k =>
      exact ⟨List.Forall₂.cons hhead (ih k).1, (ih k).2⟩

theorem within_prefix_le {boxes : List Box} {allocation : List ℝ}
    (h : within boxes allocation) (k : ℕ) :
    (allocation.take k).sum ≤
      min (upper (boxes.take k)) (allocation.sum - lower (boxes.drop k)) := by
  have hupper := (within_sums (within_take_drop h k).1).2
  have hlower := (within_sums (within_take_drop h k).2).1
  have hdecomp : (allocation.take k).sum + (allocation.drop k).sum = allocation.sum := by
    rw [← List.sum_append, List.take_append_drop]
  exact le_min hupper (by linarith)

/-- Exact elimination of the allocation variables for simultaneous lower
bounds on prefixes at a prescribed total mass. A bound on a suffix can
be expressed as a lower bound on its complementary prefix. -/
theorem exists_iff_prefix_cuts (boxes : List Box) (required : ℕ → ℝ) (t : ℝ)
    (hb : valid boxes) :
    (∃ allocation, within boxes allocation ∧ allocation.sum = t ∧
      ∀ k, required k ≤ (allocation.take k).sum) ↔
    (lower boxes ≤ t ∧ t ≤ upper boxes ∧
      ∀ k, required k ≤ upper (boxes.take k) ∧
        required k ≤ t - lower (boxes.drop k)) := by
  constructor
  · rintro ⟨allocation, hwithin, rfl, hcuts⟩
    refine ⟨(within_sums hwithin).1, (within_sums hwithin).2, ?_⟩
    intro k
    exact le_min_iff.mp ((hcuts k).trans (within_prefix_le hwithin k))
  · rintro ⟨htl, htu, hcuts⟩
    refine ⟨allocate boxes (t - lower boxes), allocate_within boxes _ hb (sub_nonneg.mpr htl),
      allocate_total boxes hb htl htu, ?_⟩
    intro k
    rw [allocate_prefix boxes hb htl]
    exact le_min (hcuts k).1 (hcuts k).2

/-- Exact feasibility under both types of cuts. The last two conditions
are affine lower and upper bounds on the same prescribed total. -/
theorem exists_iff_prefix_and_suffix_cuts
    (boxes : List Box) (prefixNeed suffixCap : ℕ → ℝ) (t : ℝ) (hb : valid boxes) :
    (∃ allocation, within boxes allocation ∧ allocation.sum = t ∧
      (∀ k, prefixNeed k ≤ (allocation.take k).sum) ∧
      (∀ k, (allocation.drop k).sum ≤ suffixCap k)) ↔
    (lower boxes ≤ t ∧ t ≤ upper boxes ∧
      (∀ k, prefixNeed k ≤ upper (boxes.take k) ∧
        prefixNeed k + lower (boxes.drop k) ≤ t) ∧
      (∀ k, lower (boxes.drop k) ≤ suffixCap k ∧
        t ≤ suffixCap k + upper (boxes.take k))) := by
  have hprefix := exists_iff_prefix_cuts boxes (fun k => max (prefixNeed k) (t - suffixCap k)) t hb
  have hsum (allocation : List ℝ) (k : ℕ) :
      (allocation.take k).sum + (allocation.drop k).sum = allocation.sum := by
    rw [← List.sum_append, List.take_append_drop]
  constructor
  · rintro ⟨allocation, hwithin, htotal, hpre, hsuf⟩
    obtain ⟨htl, htu, hcuts⟩ := hprefix.mp
      ⟨allocation, hwithin, htotal, fun k =>
        max_le (hpre k) (by linarith [hsum allocation k, hsuf k])⟩
    refine ⟨htl, htu, ?_, ?_⟩
    · intro k
      have h := hcuts k
      exact ⟨(le_max_left _ _).trans h.1, by
        linarith [(le_max_left (prefixNeed k) (t - suffixCap k)).trans h.2]⟩
    · intro k
      have h := hcuts k
      exact ⟨by linarith [(le_max_right (prefixNeed k) (t - suffixCap k)).trans h.2],
        by linarith [(le_max_right (prefixNeed k) (t - suffixCap k)).trans h.1]⟩
  · rintro ⟨htl, htu, hpre, hsuf⟩
    obtain ⟨allocation, hwithin, htotal, hcuts⟩ := hprefix.mpr
      ⟨htl, htu, fun k => ⟨max_le (hpre k).1 (by linarith [(hsuf k).2]),
        max_le (by linarith [(hpre k).2]) (by linarith [(hsuf k).1])⟩⟩
    refine ⟨allocation, hwithin, htotal, fun k => (le_max_left _ _).trans (hcuts k), ?_⟩
    intro k
    linarith [hsum allocation k, (le_max_right (prefixNeed k) (t - suffixCap k)).trans (hcuts k)]


end PrefixSaturation

#print axioms PrefixSaturation.allocate_prefix
#print axioms PrefixSaturation.within_prefix_le
#print axioms PrefixSaturation.exists_iff_prefix_cuts

#print axioms PrefixSaturation.exists_iff_prefix_and_suffix_cuts
