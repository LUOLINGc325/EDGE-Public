import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Logic.Function.Iterate
import Mathlib.Data.List.Range

universe u
namespace CollapsingBanditGlobalIndexabilityResearchProof1

theorem bellman_finite_unroll (beta : ℝ) (H g step : ℝ → ℝ) (hbeta : 0 ≤ beta)
         (recurrence : ∀ b, H b = max (g b) (beta*H ((step) b))) :
         ∀ (n : ℕ) (b : ℝ), H b =
           (List.range n).foldr (fun k best => max (beta^k*g ((step^[k]) b)) best)
             (beta^n*H ((step^[n]) b)) := by
  have scale (xs : List ℕ) (v : ℕ → ℝ) (z : ℝ) :
      xs.foldr (fun k best => max (beta*v k) best) (beta*z) =
      beta*xs.foldr (fun k best => max (v k) best) z := by
    induction xs with
    | nil => rfl
    | cons j js ih =>
        simp only [List.foldr_cons, ih, mul_max_of_nonneg _ _ hbeta]
  intro n
  induction n with
  | zero => intro b; simp
  | succ n ih =>
    intro b
    have hshift (k : ℕ) :
        beta^(k+1)*g ((step^[k+1]) b) = beta*(beta^k*g ((step^[k]) (step b))) := by
      rw [Function.iterate_succ_apply, pow_succ]
      ring
    have htail :
        beta^(n+1)*H ((step^[n+1]) b) = beta*(beta^n*H ((step^[n]) (step b))) := by
      rw [Function.iterate_succ_apply, pow_succ]
      ring
    rw [List.range_succ_eq_map, List.foldr_cons, List.foldr_map]
    simp only [pow_zero, Function.iterate_zero, id_eq, one_mul, Function.comp_def]
    simp_rw [hshift]
    rw [htail, scale, ← ih (step b), ← recurrence]

end CollapsingBanditGlobalIndexabilityResearchProof1
