import Mathlib.Algebra.Star.Basic
import Mathlib.Tactic.NoncommRing

namespace ReversibleMarkovWeakResponse

/-- Adjoint cancellation of the mixed terms in the right side of equation (4). -/
theorem star_sq_sum_cancellation {A : Type*} [Ring A] [StarRing A]
    (H K : A) (hH : star H = H) (hK : star K = -K) :
    (H + K) * (H + K) + star ((H + K) * (H + K))
      = (2 : ℕ) • (H * H + K * K) := by
  simp only [star_mul, star_add, hH, hK, two_nsmul]
  noncomm_ring

end ReversibleMarkovWeakResponse
