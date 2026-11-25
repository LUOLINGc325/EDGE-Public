import Nullity

open scoped BigOperators

namespace TwoColorNullity

variable {n m : ℕ}

theorem cost_empty (tag : Fin n → Fin m → Bool) (i : Fin n) : cost tag i ∅ = 0 := by
  simp [cost]

theorem cost_singleton (tag : Fin n → Fin m → Bool) (i : Fin n) (item : Fin m) :
    cost tag i {item} = 0 := by
  simp [cost]

/-- A fresh item costs one precisely when its color has already occurred. -/
theorem cost_insert (tag : Fin n → Fin m → Bool) (i : Fin n) (s : Finset (Fin m))
    (item : Fin m) (hfresh : item ∉ s) :
    cost tag i (insert item s) = cost tag i s + if tag i item ∈ s.image (tag i) then 1 else 0 := by
  unfold cost
  rw [Finset.card_insert_of_notMem hfresh, Finset.image_insert]
  have hle : (s.image (tag i)).card ≤ s.card := Finset.card_image_le
  by_cases hcolor : tag i item ∈ s.image (tag i)
  · rw [Finset.insert_eq_of_mem hcolor, if_pos hcolor]
    omega
  · rw [Finset.card_insert_of_notMem hcolor, if_neg hcolor]
    omega

theorem cost_monotone (tag : Fin n → Fin m → Bool) (i : Fin n) : Monotone (cost tag i) := by
  intro s t hst
  have hcolors : s.image (tag i) ⊆ t.image (tag i) := Finset.image_subset_image hst
  have hadd : (t.image (tag i) \ s.image (tag i)).card + (s.image (tag i)).card =
      (t.image (tag i)).card := Finset.card_sdiff_add_card_eq_card hcolors
  have hnew : t.image (tag i) \ s.image (tag i) ⊆ (t \ s).image (tag i) := by
    intro color hcolor
    obtain ⟨hcomes, hnot⟩ := Finset.mem_sdiff.mp hcolor
    obtain ⟨item, hitem, rfl⟩ := Finset.mem_image.mp hcomes
    exact Finset.mem_image_of_mem _ (Finset.mem_sdiff.mpr
      ⟨hitem, fun hin => hnot (Finset.mem_image_of_mem _ hin)⟩)
  have hnewCard := (Finset.card_le_card hnew).trans Finset.card_image_le
  have hts := Finset.card_sdiff_add_card_eq_card hst
  unfold cost
  omega

theorem cost_supermodular (tag : Fin n → Fin m → Bool) (i : Fin n)
    (s t : Finset (Fin m)) :
    cost tag i s + cost tag i t ≤ cost tag i (s ∪ t) + cost tag i (s ∩ t) := by
  have hcard := Finset.card_union_add_card_inter s t
  have hcolors := Finset.card_union_add_card_inter (s.image (tag i)) (t.image (tag i))
  rw [← Finset.image_union] at hcolors
  have hinter := Finset.card_le_card (Finset.image_inter_subset (tag i) s t)
  have hs : (s.image (tag i)).card ≤ s.card := Finset.card_image_le
  have ht : (t.image (tag i)).card ≤ t.card := Finset.card_image_le
  have hu : ((s ∪ t).image (tag i)).card ≤ (s ∪ t).card := Finset.card_image_le
  have hi : ((s ∩ t).image (tag i)).card ≤ (s ∩ t).card := Finset.card_image_le
  unfold cost
  omega

theorem cost_eq_sum_of_excess_counts (tag : Fin n → Fin m → Bool) (i : Fin n)
    (s : Finset (Fin m)) :
    cost tag i s = ((s.filter fun item => tag i item = false).card - 1) +
      ((s.filter fun item => tag i item = true).card - 1) := by
  have hsize := Finset.card_eq_sum_card_fiberwise (s := s) (t := (Finset.univ : Finset Bool))
    (f := tag i) (fun _ _ => Finset.mem_univ _)
  have huniv : (Finset.univ : Finset Bool) = {false, true} := by
    ext color
    cases color <;> simp
  rw [huniv, Finset.sum_insert (by simp), Finset.sum_singleton] at hsize
  have seen (color : Bool) : color ∈ s.image (tag i) ↔
      0 < (s.filter fun item => tag i item = color).card := by
    rw [Finset.card_pos]
    constructor
    · intro h
      obtain ⟨item, hitem, heq⟩ := Finset.mem_image.mp h
      exact ⟨item, Finset.mem_filter.mpr ⟨hitem, heq⟩⟩
    · rintro ⟨item, hitem⟩
      exact Finset.mem_image.mpr ⟨item, (Finset.mem_filter.mp hitem).1, (Finset.mem_filter.mp hitem).2⟩
  have hc : (s.image (tag i)).card = (if false ∈ s.image (tag i) then 1 else 0) +
      (if true ∈ s.image (tag i) then 1 else 0) := by
    let colors := s.image (tag i)
    let allColors := ({false, true} : Finset Bool)
    have e : colors = allColors.filter (· ∈ colors) := by
      ext color
      cases color <;> simp [allColors]
    calc
      colors.card = (allColors.filter (· ∈ colors)).card := congrArg Finset.card e
      _ = ∑ color ∈ allColors, if color ∈ colors then 1 else 0 :=
        (Finset.sum_boole (R := ℕ) (· ∈ colors) allColors).symm
      _ = _ := by dsimp [allColors]; rw [Finset.sum_insert (by simp), Finset.sum_singleton]
  by_cases hf : false ∈ s.image (tag i) <;> by_cases ht : true ∈ s.image (tag i)
  all_goals
    simp only [seen] at hf ht
    unfold cost
    rw [hc]
    simp only [seen, hf, ht, if_true, if_false]
    omega

/-- The rank in the two-class capacity-one partition is the number of represented classes. -/
theorem color_rank_attained (tag : Fin n → Fin m → Bool) (i : Fin n)
    (s : Finset (Fin m)) :
    (∃ t ⊆ s, Set.InjOn (tag i) (t : Set (Fin m)) ∧ t.card = (s.image (tag i)).card) ∧
      ∀ t ⊆ s, Set.InjOn (tag i) (t : Set (Fin m)) → t.card ≤ (s.image (tag i)).card := by
  classical
  refine ⟨?_, ?_⟩
  · let representative (color : ↥(s.image (tag i))) : Fin m :=
      (Finset.mem_image.mp color.property).choose
    have contained (color) : representative color ∈ s :=
      (Finset.mem_image.mp color.property).choose_spec.1
    have hasColor (color) : tag i (representative color) = color.val :=
      (Finset.mem_image.mp color.property).choose_spec.2
    have injective : Function.Injective representative := by
      intro a b h
      exact Subtype.ext ((hasColor a).symm.trans ((congrArg (tag i) h).trans (hasColor b)))
    refine ⟨Finset.univ.image representative, ?_, ?_, ?_⟩
    · intro item hitem
      obtain ⟨color, _, rfl⟩ := Finset.mem_image.mp hitem
      exact contained color
    · intro a ha b hb heq
      change a ∈ Finset.univ.image representative at ha
      change b ∈ Finset.univ.image representative at hb
      obtain ⟨ca, _, rfl⟩ := Finset.mem_image.mp ha
      obtain ⟨cb, _, rfl⟩ := Finset.mem_image.mp hb
      exact congrArg representative (Subtype.ext ((hasColor ca).symm.trans (heq.trans (hasColor cb))))
    · rw [Finset.card_image_of_injective _ injective, Finset.card_univ, Fintype.card_coe]
  · intro t hts hi
    rw [← Finset.card_image_of_injOn hi]
    exact Finset.card_le_card (Finset.image_subset_image hts)

theorem color_independent_exchange (tag : Fin n → Fin m → Bool) (i : Fin n)
    (s t : Finset (Fin m)) (hs : Set.InjOn (tag i) (s : Set (Fin m)))
    (ht : Set.InjOn (tag i) (t : Set (Fin m))) (hcard : s.card < t.card) :
    ∃ item ∈ t, item ∉ s ∧ Set.InjOn (tag i) ((insert item s : Finset (Fin m)) : Set (Fin m)) := by
  have sizes : (s.image (tag i)).card < (t.image (tag i)).card := by
    rw [Finset.card_image_of_injOn hs, Finset.card_image_of_injOn ht]
    exact hcard
  have diff : ∃ color ∈ t.image (tag i), color ∉ s.image (tag i) := by
    by_contra no
    push_neg at no
    exact (not_le_of_gt sizes) (Finset.card_le_card no)
  obtain ⟨color, hcolor, missing⟩ := diff
  obtain ⟨item, hit, rfl⟩ := Finset.mem_image.mp hcolor
  refine ⟨item, hit, fun hin => missing (Finset.mem_image_of_mem _ hin), ?_⟩
  intro a ha b hb he
  change a ∈ insert item s at ha
  change b ∈ insert item s at hb
  rcases Finset.mem_insert.mp ha with haEq | haOld
  · subst a
    rcases Finset.mem_insert.mp hb with hbEq | hbOld
    · exact hbEq.symm
    · exact (missing (he.symm ▸ Finset.mem_image_of_mem _ hbOld)).elim
  · rcases Finset.mem_insert.mp hb with hbEq | hbOld
    · subst b
      exact (missing (he ▸ Finset.mem_image_of_mem _ haOld)).elim
    · exact hs haOld hbOld he

end TwoColorNullity
