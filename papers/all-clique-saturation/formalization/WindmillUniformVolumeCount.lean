import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Group.Finset.Sigma
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Data.Fintype.BigOperators

namespace CliqueWindmillSaturation

open scoped BigOperators

/-- Section 7's uniform volume bound in finite cardinality form.
A color survives an observation exactly when each blade's observation belongs
to the specified failed-blade set for that color. -/
theorem uniform_product_volume_bound {n : ℕ} {H O : Type*}
    [Fintype H] [Fintype O] [DecidableEq O]
    (F : H → Fin n → Finset O) (m g : ℕ)
    (hlower : ∀ h i, m ≤ (F h i).card)
    (hupper : ∀ obs : Fin n → O,
      (∑ h, if obs ∈ Fintype.piFinset (F h) then (1:ℕ) else 0) ≤ g) :
    Fintype.card H * m^n ≤ g * (Fintype.card O)^n := by
  let inc (h : H) (obs : Fin n → O) : ℕ :=
    if obs ∈ Fintype.piFinset (F h) then 1 else 0
  have count (h : H) : (∑ obs, inc h obs) = (Fintype.piFinset (F h)).card := by
    dsimp only [inc]
    rw [Finset.sum_boole]
    have eqset : (Finset.univ.filter (fun obs => obs ∈ Fintype.piFinset (F h))) =
        Fintype.piFinset (F h) := by
      ext obs
      simp
    rw [eqset]
    exact Nat.cast_id _
  have hproduct (h : H) : m^n ≤ ∑ obs, inc h obs := calc
    m^n = ∏ _i : Fin n, m := by simp
    _ ≤ ∏ i, (F h i).card := Finset.prod_le_prod (fun _ _ => Nat.zero_le _) (fun i _ => hlower h i)
    _ = _ := by rw [count, Fintype.card_piFinset]
  calc
    Fintype.card H * m^n = ∑ _h : H, m^n := by simp [nsmul_eq_mul]
    _ ≤ ∑ h, ∑ obs, inc h obs := Finset.sum_le_sum fun h _ => hproduct h
    _ = ∑ obs, ∑ h, inc h obs := Finset.sum_comm
    _ ≤ ∑ _obs : Fin n → O, g := Finset.sum_le_sum fun obs _ => hupper obs
    _ = g * (Fintype.card O)^n := by simp [nsmul_eq_mul, Nat.mul_comm]

end CliqueWindmillSaturation
