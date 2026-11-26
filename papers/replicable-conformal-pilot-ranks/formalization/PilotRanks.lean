import Mathlib.Algebra.Group.Fin.Basic
import Mathlib.Algebra.Group.Units.Equiv
import Mathlib.Order.Interval.Finset.Fin

namespace PilotRanks

/-- The block containing the pilot count for a given offset. -/
def block {b : ℕ} (k : ℕ) (s : Fin b) : ℕ := (k + s.val) / b

/-- The first grid endpoint strictly above the pilot count. -/
def nextRank {b : ℕ} (k : ℕ) (s : Fin b) : ℕ :=
  k + (b - (k + s.val) % b)

/-- The rank m+1 denotes the infinite threshold. -/
def outputRank {b : ℕ} (m k : ℕ) (s : Fin b) : ℕ :=
  min (m + 1) (nextRank k s)

theorem nextRank_bounds {b : ℕ} (k : ℕ) (s : Fin b) :
    k < nextRank k s ∧ nextRank k s ≤ k + b := by
  have hb : 0 < b := Nat.zero_lt_of_lt s.isLt
  have hmod := Nat.mod_lt (k + s.val) hb
  unfold nextRank
  omega

theorem endpoint_identity {b : ℕ} (k : ℕ) (s : Fin b) :
    nextRank k s + s.val = (block k s + 1) * b := by
  have hb : 0 < b := Nat.zero_lt_of_lt s.isLt
  have hmod := Nat.mod_lt (k + s.val) hb
  have hdiv := Nat.mod_add_div (k + s.val) b
  rw [Nat.mul_comm b] at hdiv
  unfold nextRank block
  rw [Nat.add_mul]
  simp only [Nat.one_mul]
  omega

private theorem nextRank_le_of_cross {b k l : ℕ} (s : Fin b)
    (h : block k s < block l s) : nextRank k s ≤ l := by
  have hmul := Nat.mul_le_mul_right b (show block k s + 1 ≤ block l s by omega)
  have hend := endpoint_identity k s
  have hdiv := Nat.mod_add_div (l + s.val) b
  rw [Nat.mul_comm b] at hdiv
  change (block k s + 1) * b ≤ ((l + s.val) / b) * b at hmul
  omega

/-- The overflow sentinel preserves block collisions on the valid range. -/
theorem outputRank_eq_iff {b m k l : ℕ} (s : Fin b) (hk : k ≤ m) (hl : l ≤ m) :
    outputRank m k s = outputRank m l s ↔ block k s = block l s := by
  constructor
  · intro heq
    rcases lt_trichotomy (block k s) (block l s) with h | h | h
    · have hkl := nextRank_le_of_cross s h
      have hnext := (nextRank_bounds l s).1
      have hclip : nextRank k s ≤ m + 1 := by omega
      unfold outputRank at heq
      rw [min_eq_right hclip] at heq
      have : nextRank k s < min (m + 1) (nextRank l s) :=
        lt_min (by omega) (by omega)
      omega
    · exact h
    · have hkl := nextRank_le_of_cross s h
      have hnext := (nextRank_bounds k s).1
      have hclip : nextRank l s ≤ m + 1 := by omega
      unfold outputRank at heq
      rw [min_eq_right hclip] at heq
      have : nextRank l s < min (m + 1) (nextRank k s) :=
        lt_min (by omega) (by omega)
      omega
  · intro h
    have ha := endpoint_identity k s
    have hc := endpoint_identity l s
    rw [h] at ha
    have : nextRank k s = nextRank l s := by omega
    simp [outputRank, this]

/-- Counts separated by d cross the next grid boundary exactly when the
remainder is within d positions of the end of the block. -/
theorem block_ne_iff {b : ℕ} (k d : ℕ) (s : Fin b) :
    block k s ≠ block (k + d) s ↔ b - (k + s.val) % b ≤ d := by
  have hb : 0 < b := Nat.zero_lt_of_lt s.isLt
  have hmon : block k s ≤ block (k + d) s := Nat.div_le_div_right (by omega)
  have hend := endpoint_identity k s
  have hcmp : block (k + d) s < block k s + 1 ↔
      k + d + s.val < (block k s + 1) * b :=
    Nat.div_lt_iff_lt_mul hb
  unfold nextRank at hend
  omega

private def translate {b : ℕ} [NeZero b] (k : ℕ) : Fin b ≃ Fin b :=
  Equiv.addLeft (Fin.ofNat b k)

private theorem translate_val {b : ℕ} [NeZero b] (k : ℕ) (s : Fin b) :
    (translate k s).val = (k + s.val) % b := by
  change (Fin.ofNat b k + s).val = _
  rw [Fin.val_add, Fin.val_ofNat, Nat.mod_add_mod]

/-- Each waiting distance from one to the block width occurs exactly once
as the offset runs through its possible values. -/
theorem unique_offset_for_wait {b : ℕ} [NeZero b] (k d : ℕ)
    (hd : 0 < d) (hdb : d ≤ b) :
    ∃! s : Fin b, nextRank k s = k + d := by
  let r : Fin b := ⟨b - d, by omega⟩
  let e : Fin b ≃ Fin b := translate k
  refine ⟨e.symm r, ?_, ?_⟩
  · have he : (k + (e.symm r).val) % b = b - d := by
      rw [← translate_val]
      exact congrArg Fin.val (e.apply_symm_apply r)
    unfold nextRank
    omega
  · intro s hs
    apply e.injective
    rw [e.apply_symm_apply]
    apply Fin.ext
    change (translate k s).val = b - d
    rw [translate_val]
    have hm := Nat.mod_lt (k + s.val) (Nat.zero_lt_of_lt s.isLt)
    unfold nextRank at hs
    omega


/-- Exact number of offsets separating two counts at distance d. -/
theorem disagree_count {b : ℕ} [NeZero b] (k d : ℕ) :
    (Finset.univ.filter (fun s : Fin b => block k s ≠ block (k + d) s)).card =
      min b d := by
  classical
  by_cases hbig : b ≤ d
  · rw [min_eq_left hbig]
    have hAll : (Finset.univ.filter (fun s : Fin b => block k s ≠ block (k + d) s)) =
        Finset.univ := by
      ext s
      simp only [Finset.mem_filter, Finset.mem_univ, true_and, iff_true]
      exact (block_ne_iff k d s).mpr (Nat.sub_le _ _ |>.trans hbig)
    simp [hAll]
  · by_cases hz : d = 0
    · subst d
      simp
    · have hlt : d < b := Nat.lt_of_not_ge hbig
      let a : Fin b := ⟨b - d, by omega⟩
      let e : Fin b ≃ Fin b := translate k
      let offsets : Finset (Fin b) :=
        Finset.univ.filter (fun s : Fin b => block k s ≠ block (k + d) s)
      have himage : offsets.map e.toEmbedding = Finset.Ici a := by
        ext r
        rw [Finset.mem_map, Finset.mem_Ici]
        constructor
        · rintro ⟨s, hs, rfl⟩
          have hs' := (Finset.mem_filter.mp hs).2
          have hp := (block_ne_iff k d s).1 hs'
          change b - d ≤ (translate k s).val
          rw [translate_val]
          omega
        · intro hr
          refine ⟨e.symm r, Finset.mem_filter.mpr ⟨Finset.mem_univ _, ?_⟩, e.apply_symm_apply r⟩
          apply (block_ne_iff k d _).2
          have hr' : b - d ≤ r.val := hr
          have he : (k + (e.symm r).val) % b = r.val := by
            rw [← translate_val]
            exact congrArg Fin.val (e.apply_symm_apply r)
          omega
      calc
        _ = (offsets.map e.toEmbedding).card := (Finset.card_map _).symm
        _ = (Finset.Ici a).card := by rw [himage]
        _ = min b d := by rw [Fin.card_Ici, min_eq_right hlt.le]; dsimp [a]; omega

/-- The disagreement count holds unchanged after replacing every overflow
endpoint by the infinite threshold. -/
theorem output_disagree_count {b : ℕ} [NeZero b] (m k d : ℕ) (h : k + d ≤ m) :
    (Finset.univ.filter (fun s : Fin b => outputRank m k s ≠ outputRank m (k + d) s)).card =
      min b d := by
  convert disagree_count (b := b) k d using 2
  ext s
  simp only [Finset.mem_filter, Finset.mem_univ, true_and]
  exact not_congr (outputRank_eq_iff s (show k ≤ m by omega) h)

end PilotRanks

#print axioms PilotRanks.endpoint_identity
#print axioms PilotRanks.outputRank_eq_iff
#print axioms PilotRanks.unique_offset_for_wait
#print axioms PilotRanks.disagree_count
#print axioms PilotRanks.output_disagree_count
