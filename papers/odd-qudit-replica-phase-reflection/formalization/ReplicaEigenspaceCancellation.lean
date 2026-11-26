import Mathlib.Algebra.Field.Basic
import Mathlib.Tactic.Ring

namespace OddQuditReplicaPhaseReflectionResearchProof1

/-- Odd-characteristic cancellation on a reflection eigenspace.

If a phase `Q` reverses under an involution-like map `J` (`Q (J x) = -Q x`),
is unchanged by global negation (`Q (-x) = Q x`), and `x` is an eigenvector
of `J` with eigenvalue `+1` or `-1`, then `Q x = 0`.  In characteristic
different from `2`, both eigenspaces carry the zero phase; this is the
reflection step in the manuscript's Gauss-sum proof of
`Z_n = p ^ (-(rank B)/2)`. -/
theorem odd_characteristic_phase_cancellation {V K : Type*} [Neg V] [Field K]
    (h₂ : (2 : K) ≠ 0) (J : V → V) (Q : V → K)
    (hJ : ∀ x, Q (J x) = -Q x) (heven : ∀ x, Q (-x) = Q x)
    (x : V) (hx : J x = x ∨ J x = -x) : Q x = 0 := by
  have h : Q x = -Q x := by
    rcases hx with hx | hx
    · simpa only [hx] using hJ x
    · simpa only [hx, heven] using hJ x
  have hzero : (2 : K) * Q x = 0 := by
    calc
      (2 : K) * Q x = Q x + Q x := two_mul _
      _ = -Q x + Q x := congrArg (fun y => y + Q x) h
      _ = 0 := neg_add_cancel _
  exact (mul_eq_zero.mp hzero).resolve_left h₂

end OddQuditReplicaPhaseReflectionResearchProof1
