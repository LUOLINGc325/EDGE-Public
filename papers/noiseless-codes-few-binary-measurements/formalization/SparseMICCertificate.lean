import Mathlib.Data.Real.Basic
import Mathlib.Data.Nat.ModEq
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.LinearAlgebra.LinearIndependent.Basic
import Mathlib.LinearAlgebra.Span.Basic
import Mathlib.Tactic.Linarith

namespace SparseMICCertificate

section Supports

variable {K M ι : Type*} [Field K] [AddCommGroup M] [Module K M]

/-- Full-spark intersection rule, stated with exactly the local
independence needed on the union of the two groups. -/
theorem spanIntersection {r c : Set ι} {v : ι → M}
    (hind : LinearIndepOn K v (r ∪ c)) :
    Submodule.span K (v '' r) ⊓ Submodule.span K (v '' c) =
      Submodule.span K (v '' (r ∩ c)) := by
  apply le_antisymm
  · intro x hx
    rcases (Finsupp.mem_span_image_iff_linearCombination K).1 hx.1 with ⟨f, hf, hfx⟩
    rcases (Finsupp.mem_span_image_iff_linearCombination K).1 hx.2 with ⟨g, hg, hgx⟩
    have hf' : f ∈ Finsupp.supported K K (r ∪ c) :=
      (Finsupp.mem_supported K f).2 <|
        ((Finsupp.mem_supported K f).1 hf).trans Set.subset_union_left
    have hg' : g ∈ Finsupp.supported K K (r ∪ c) :=
      (Finsupp.mem_supported K g).2 <|
        ((Finsupp.mem_supported K g).1 hg).trans Set.subset_union_right
    have hfg := (linearIndepOn_iffₛ.1 hind) f hf' g hg' (hfx.trans hgx.symm)
    subst g
    exact (Finsupp.mem_span_image_iff_linearCombination K).2
      ⟨f, by rw [Finsupp.supported_inter]; exact ⟨hf, hg⟩, hfx⟩
  · exact le_inf (Submodule.span_mono (Set.image_mono Set.inter_subset_left))
      (Submodule.span_mono (Set.image_mono Set.inter_subset_right))

/-- An empty cell forces the operator to vanish, once its range belongs to
both marginal spans. The operator is represented here by a linear map. -/
theorem emptyCell {r c : Set ι} {v : ι → M}
    (hind : LinearIndepOn K v (r ∪ c)) (hempty : r ∩ c = ∅)
    (J : M →ₗ[K] M)
    (hr : LinearMap.range J ≤ Submodule.span K (v '' r))
    (hc : LinearMap.range J ≤ Submodule.span K (v '' c)) : J = 0 := by
  have h := le_inf hr hc
  rw [spanIntersection hind, hempty, Set.image_empty, Submodule.span_empty] at h
  exact LinearMap.range_eq_bot.mp (le_bot_iff.mp h)

/-- An occupied simple cell forces its operator's range onto the line of
the cell's atom. -/
theorem occupiedCell {r c : Set ι} {v : ι → M} {i : ι}
    (hind : LinearIndepOn K v (r ∪ c)) (hcell : r ∩ c = {i})
    (J : M →ₗ[K] M)
    (hr : LinearMap.range J ≤ Submodule.span K (v '' r))
    (hc : LinearMap.range J ≤ Submodule.span K (v '' c)) :
    LinearMap.range J ≤ Submodule.span K {v i} := by
  have h := le_inf hr hc
  rwa [spanIntersection hind, hcell, Set.image_singleton] at h

end Supports

/-- If every occupied cell is a scalar multiple of its MIC atom, the
parent normalization determines every scalar exactly. -/
theorem normalizedParent {M ι : Type*} [AddCommGroup M] [Module ℝ M] [Fintype ι]
    {G : ι → M} (hind : LinearIndependent ℝ G) (a : ι → ℝ)
    (hnorm : ∑ i, a i • G i = ∑ i, G i) : ∀ i, a i = 1 := by
  have h := (Fintype.linearIndependent_iffₛ.1 hind) a (fun _ => 1)
    (by simpa only [one_smul] using hnorm)
  exact h

/-- In the two-test triple compression, testing the all-no effect against a
positive linear functional that annihilates the distinguished atom rules
out a strictly positive marginal defect. -/
theorem eliminateTripleDefect {M : Type*} [AddCommGroup M] [Module ℝ M]
    {G₀ G : M} {a : ℝ} (L : M →ₗ[ℝ] ℝ)
    (h₀ : L G₀ = 0) (hG : 0 < L G)
    (ha : a ≤ 1) (hpositive : 0 ≤ L (G₀ + (a-1) • G)) : a = 1 := by
  rw [map_add, map_smul, h₀, zero_add, smul_eq_mul] at hpositive
  apply le_antisymm ha
  by_contra! hlt
  exact (not_lt_of_ge hpositive) (mul_neg_of_neg_of_pos (sub_neg.mpr hlt) hG)

/-- The modular column allocation is injective within each row. -/
theorem gridCellInjective {p q : ℕ} (hp : 0 < p) (hpq : p ≤ q) :
    Function.Injective (fun j : ℕ => (j / p, j % q)) := by
  intro a b hab
  have hrow : a / p = b / p := congrArg Prod.fst hab
  have hcol : a % q = b % q := congrArg Prod.snd hab
  have hsmall (a b : ℕ) (hrow : a / p = b / p) : b-a < q := by
    have ha := Nat.mod_add_div a p
    have hb := Nat.mod_add_div b p
    have hra := Nat.mod_lt a hp
    have hrb := Nat.mod_lt b hp
    rw [hrow] at ha
    omega
  rcases le_total a b with h | h
  · have hd : q ∣ b-a := (Nat.modEq_iff_dvd' h).1 hcol
    have hz := Nat.eq_zero_of_dvd_of_lt hd (hsmall a b hrow)
    omega
  · have hd : q ∣ a-b := (Nat.modEq_iff_dvd' h).1 hcol.symm
    have hz := Nat.eq_zero_of_dvd_of_lt hd (hsmall b a hrow.symm)
    omega

/-- The all-no residual also eliminates every defect when multiple
disjoint triples are compressed together. -/
theorem eliminateTripleDefects {M ι : Type*} [AddCommGroup M] [Module ℝ M] [Fintype ι]
    {G₀ : M} {G : ι → M} {a : ι → ℝ} (L : ι → M →ₗ[ℝ] ℝ)
    (h₀ : ∀ i, L i G₀ = 0) (hdiag : ∀ i, 0 < L i (G i))
    (hall : ∀ i j, 0 ≤ L i (G j)) (ha : ∀ i, a i ≤ 1)
    (hpositive : ∀ i, 0 ≤ L i (G₀ - ∑ j, (1-a j) • G j)) :
    ∀ i, a i = 1 := by
  intro i
  have h := hpositive i
  rw [map_sub, h₀, zero_sub, neg_nonneg] at h
  simp only [map_sum, map_smul, smul_eq_mul] at h
  have hnonneg : ∀ j ∈ Finset.univ, 0 ≤ (1-a j) * L i (G j) :=
    fun j _ => mul_nonneg (sub_nonneg.mpr (ha j)) (hall i j)
  have hzero := le_antisymm h (Finset.sum_nonneg hnonneg)
  have hi := (Finset.sum_eq_zero_iff_of_nonneg hnonneg).1 hzero i (Finset.mem_univ i)
  have hz := (mul_eq_zero.mp hi).resolve_right (ne_of_gt (hdiag i))
  linarith

end SparseMICCertificate

#print axioms SparseMICCertificate.spanIntersection
#print axioms SparseMICCertificate.emptyCell
#print axioms SparseMICCertificate.occupiedCell
#print axioms SparseMICCertificate.normalizedParent
#print axioms SparseMICCertificate.eliminateTripleDefect
#print axioms SparseMICCertificate.gridCellInjective
#print axioms SparseMICCertificate.eliminateTripleDefects
