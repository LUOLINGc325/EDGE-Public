import Mathlib.Data.Finset.Card
import Mathlib.Data.Int.Basic

namespace TwoVisitsDuplicateMidpointResearchProof1

/-- Nonnegative suffix-count width: for index-matched discrete positions `a` and
deadlines `d` (occasions indexed by `s`, so multiplicities are retained by
indexing occurrences), if `a i ≤ d i` for all `i ∈ s`, then for every threshold
`t` the number of positions with `t ≤ 2 * a i` is at most the number of
deadlines with `t ≤ 2 * d i`. This is the inequality stating that the
suffix-count difference in Section 4 is nonnegative. -/
theorem duplicate_suffix_width {ι : Type*} (s : Finset ι) (a d : ι → ℤ) (t : ℤ)
    (hle : ∀ i ∈ s, a i ≤ d i) :
    (s.filter (fun i => t ≤ 2 * a i)).card ≤ (s.filter (fun i => t ≤ 2 * d i)).card := by
  apply Finset.card_le_card_of_injOn (fun i => i)
  · intro i hi
    simp only [Finset.mem_coe, Finset.mem_filter] at hi ⊢
    obtain ⟨his, hti⟩ := hi
    exact ⟨his, by have := hle i his; omega⟩
  · intro x _ y _ hxy
    exact hxy

end TwoVisitsDuplicateMidpointResearchProof1
