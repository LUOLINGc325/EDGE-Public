import Mathlib.Data.Finset.Card
import Mathlib.Data.Fintype.Fin
import Lean.Elab.Tactic.Omega

namespace OddCyclePauliProductLaw

/-- On an odd cycle, an edge selection and its complement have opposite
cardinality parity. The statement concerns any subset of the k edges. -/
theorem card_parity_add_compl_parity_eq_one {k : ℕ} (hk : k % 2 = 1)
    (s : Finset (Fin k)) :
    s.card % 2 + (Finset.univ \ s).card % 2 = 1 := by
  have hcard := Finset.card_sdiff_add_card_eq_card (Finset.subset_univ s)
  rw [Finset.card_univ, Fintype.card_fin] at hcard
  omega

end OddCyclePauliProductLaw
