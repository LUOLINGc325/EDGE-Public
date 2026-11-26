import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.LinearAlgebra.Pi

universe u
namespace TernaryPairwiseMomentResearchProof1

theorem affine_pairwise_triple_moment {Ω : Type u} (E : (Ω → ℝ) →ₗ[ℝ] ℝ)
         (x₁ x₂ x₃ : Ω → ℝ) (u d m : ℝ)
         (h1 : E 1 = 1)
         (hm1 : E x₁ = m) (hm2 : E x₂ = m) (hm3 : E x₃ = m)
         (h12 : E (x₁*x₂) = m^2) (h13 : E (x₁*x₃) = m^2) (h23 : E (x₂*x₃) = m^2) :
         E (fun w => (u+d*x₁ w)*(u+d*x₂ w)*(u+d*x₃ w))
         = u^3+3*u^2*d*m+3*u*d^2*m^2+d^3*E (x₁*x₂*x₃) := by
  have hexpand :
      (fun w => (u+d*x₁ w)*(u+d*x₂ w)*(u+d*x₃ w)) =
      u^3 • (1 : Ω → ℝ) + (u^2*d) • x₁ + (u^2*d) • x₂ + (u^2*d) • x₃ +
      (u*d^2) • (x₁*x₂) + (u*d^2) • (x₁*x₃) + (u*d^2) • (x₂*x₃) +
      d^3 • (x₁*x₂*x₃) := by
    funext w
    simp only [Pi.add_apply, Pi.smul_apply, Pi.one_apply, Pi.mul_apply, smul_eq_mul, mul_one]
    ring
  rw [hexpand]
  simp only [map_add, LinearMap.map_smul, smul_eq_mul, h1, hm1, hm2, hm3, h12, h13, h23]
  ring

end TernaryPairwiseMomentResearchProof1
