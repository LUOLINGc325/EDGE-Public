import Mathlib.Algebra.Star.Basic
import Mathlib.Tactic.NoncommRing

namespace ReversibleMarkovWeakResponse

/-- The congruence identity in equation (4), before dividing the symmetric
sums by two. The hypotheses record U as a left inverse of T. -/
theorem equation_four_congruence {R : Type*} [Ring R] [StarRing R]
    (T U : R) (hUT : U * T = 1) :
    star (T * T) * (U * U + star (U * U)) * (T * T) =
      T * T + star (T * T) := by
  have inverse_square : (U * U) * (T * T) = 1 := calc
    (U * U) * (T * T) = U * (U * T) * T := by noncomm_ring
    _ = 1 := by rw [hUT, mul_one, hUT]
  have adjoint_inverse : star (T * T) * star (U * U) = 1 := by
    simpa only [star_mul, star_one] using congrArg star inverse_square
  calc
    star (T * T) * (U * U + star (U * U)) * (T * T) =
      star (T * T) * ((U * U) * (T * T)) +
        (star (T * T) * star (U * U)) * (T * T) := by noncomm_ring
    _ = T * T + star (T * T) := by
      rw [inverse_square, adjoint_inverse, mul_one, one_mul, add_comm]

end ReversibleMarkovWeakResponse
