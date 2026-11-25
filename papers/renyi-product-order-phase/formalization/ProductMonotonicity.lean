import TensorChannel
import Mathlib.Analysis.Convex.Deriv
import Mathlib.Analysis.SpecialFunctions.Pow.Deriv

/-! Strict improvement from one additional informative independent coordinate. -/

open scoped BigOperators Topology
open Set Filter

namespace RenyiProductOrderPhase

theorem strict_convex_inverse_power (a b : ℝ) (ha : 0 < a) (hb : 0 < b) :
    StrictConvexOn ℝ (Ici (0 : ℝ)) (fun x : ℝ => (1 + a * x) ^ (-b)) := by
  let F (x : ℝ) := (1 + a * x) ^ (-b)
  let G (x : ℝ) := (-b * a) * (1 + a * x) ^ (-b - 1)
  have hBase (x : ℝ) (hx : 0 ≤ x) : 0 < 1 + a * x :=
    add_pos_of_pos_of_nonneg zero_lt_one (mul_nonneg ha.le hx)
  have hlin (x : ℝ) : HasDerivAt (fun t : ℝ => 1 + a * t) a x := by
    simpa using (((hasDerivAt_id x).const_mul a).const_add (1 : ℝ))
  have hFirst (x : ℝ) (hx : 0 < 1 + a * x) : HasDerivAt F (G x) x := by
    convert (hlin x).rpow_const (p := -b) (Or.inl hx.ne') using 1
    unfold G
    ring
  apply strictConvexOn_of_deriv2_pos' (convex_Ici _)
  · exact (continuous_const.add (continuous_const.mul continuous_id)).continuousOn.rpow_const
      (fun x hx => Or.inl (hBase x hx).ne')
  intro x hx
  have hFx : 0 < 1 + a * x := hBase x hx
  have hC : ContinuousAt (fun t : ℝ => 1 + a * t) x :=
    (continuous_const.add (continuous_const.mul continuous_id)).continuousAt
  have hneighborhood : ∀ᶠ y in 𝓝 x, 0 < 1 + a * y :=
    hC.tendsto.eventually (Ioi_mem_nhds hFx)
  have hD : deriv F =ᶠ[𝓝 x] G :=
    hneighborhood.mono (fun y hy => (hFirst y hy).deriv)
  have hSecond := ((hlin x).rpow_const (p := -b - 1) (Or.inl hFx.ne')).const_mul (-b * a)
  change 0 < deriv (deriv F) x
  rw [hD.deriv_eq, hSecond.deriv, ← mul_assoc]
  exact mul_pos
    (mul_pos_of_neg_of_neg (mul_neg_of_neg_of_pos (neg_neg_of_pos hb) ha)
      (mul_neg_of_pos_of_neg ha (by linarith)))
    (Real.rpow_pos_of_pos hFx _)

namespace FiniteMass

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

theorem expect_swap (p : FiniteMass ι) (q : FiniteMass κ) (f : ι → κ → ℝ) :
    p.expect (fun i => q.expect (f i)) = q.expect (fun j => p.expect (fun i => f i j)) := by
  unfold expect
  simp only [Finset.mul_sum]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun i _ => ?_
  ring

end FiniteMass

variable {κ : Type*} [Fintype κ]

theorem ratio_nonconstant (p q : FiniteMass κ) (hp : ∀ y, 0 < p y) (hne : p ≠ q) :
    ∃ x y, q x / p x ≠ q y / p y := by
  by_contra! h
  obtain ⟨z, _⟩ := p.exists_weight_pos
  have hm := reference_expected_ratio q p (FiniteMass.absolutelyContinuous_of_pos q p hp)
  have hc : p.expect (fun i => q i / p i) = q z / p z := by
    have he : (fun i => q i / p i) = fun _ => q z / p z := funext (fun i => h i z)
    rw [he, FiniteMass.expect_const]
  have hz : q z / p z = 1 := hc.symm.trans hm
  apply hne
  ext i
  symm
  have hi := (h i z).trans hz
  exact ((div_eq_iff (hp i).ne').1 hi).trans (one_mul _)

theorem strict_ratio_power_expect (p q : FiniteMass κ) (hp : ∀ y, 0 < p y) (hne : p ≠ q)
    (a b : ℝ) (ha : 0 < a) (hb : 0 < b) :
    (1 + a) ^ (-b) < p.expect (fun y => (1 + a * (q y / p y)) ^ (-b)) := by
  classical
  obtain ⟨x, y, hxy⟩ := ratio_nonconstant p q hp hne
  have h := (strict_convex_inverse_power a b ha hb).map_sum_lt (t := Finset.univ)
    (w := fun i => p i) (p := fun i => q i / p i) (fun i _ => hp i) p.total
    (fun i _ => div_nonneg (q.weight_nonneg i) (hp i).le)
    ⟨x, Finset.mem_univ x, y, Finset.mem_univ y, hxy⟩
  change (1 + a * (p.expect (fun i => q i / p i))) ^ (-b) <
    p.expect (fun i => (1 + a * (q i / p i)) ^ (-b)) at h
  rwa [reference_expected_ratio q p (FiniteMass.absolutelyContinuous_of_pos q p hp), mul_one] at h

noncomputable def productScalarMoment (p q : FiniteMass κ) (n : ℕ) (b a : ℝ) : ℝ :=
  (FiniteMass.tensor (fun _ : Fin n => p)).expect
    (fun x => (1 + a * likelihoodProduct p q x) ^ (-b))

theorem scalar_moment_of_products (p q : FiniteMass κ) (n : ℕ) (b a : ℝ) :
    scalarMoment (FiniteMass.tensor (fun _ : Fin n => p))
        (FiniteMass.tensor (fun _ : Fin n => q)) b a =
      productScalarMoment p q n b a := by
  unfold scalarMoment productScalarMoment
  congr 1
  funext x
  simp only [FiniteMass.tensor_apply, likelihoodProduct, Finset.prod_div_distrib]

theorem product_scalar_moment_strict_step (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y) (hne : p ≠ q)
    (n : ℕ) (b a : ℝ) (hb : 0 < b) (ha : 0 < a) :
    productScalarMoment p q n b a < productScalarMoment p q (n + 1) b a := by
  unfold productScalarMoment
  rw [FiniteMass.tensor_expect_succ, FiniteMass.expect_swap]
  let P := FiniteMass.tensor (fun _ : Fin n => p)
  have hlt (z : Fin n → κ) : (1 + a * likelihoodProduct p q z) ^ (-b) <
      p.expect (fun y => (1 + a * likelihoodProduct p q (Fin.cons y z)) ^ (-b)) := by
    have hpos : 0 < a * likelihoodProduct p q z :=
      mul_pos ha (likelihood_product_pos p q hp hq z)
    have hh := strict_ratio_power_expect p q hp hne _ b hpos hb
    have h (y : κ) :
        a * likelihoodProduct p q (Fin.cons y z) =
          (a * likelihoodProduct p q z) * (q y / p y) := by
      rw [likelihood_product_succ]
      ring
    simpa only [h] using hh
  obtain ⟨z, hz⟩ := P.exists_weight_pos
  exact P.expect_strict (fun v => (hlt v).le) hz (hlt z)

theorem product_scalar_moment_mono (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y) (hne : p ≠ q)
    (b a : ℝ) (hb : 0 < b) (ha : 0 < a) :
    StrictMono (fun n => productScalarMoment p q n b a) :=
  strictMono_nat_of_lt_succ (fun n => product_scalar_moment_strict_step p q hp hq hne n b a hb ha)

noncomputable def productScalarDeficit (p q : FiniteMass κ) (n : ℕ) (b a : ℝ) : ℝ :=
  -Real.log (productScalarMoment p q n b a) / (b * Real.log (1 + a))

theorem product_scalar_deficit_strict_antitone (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y) (hne : p ≠ q)
    (b a : ℝ) (hb : 0 < b) (ha : 0 < a) :
    StrictAnti (fun n => productScalarDeficit p q n b a) := by
  intro m n hmn
  have hM (k : ℕ) : 0 < productScalarMoment p q k b a := by
    rw [← scalar_moment_of_products]
    exact scalar_moment_pos _ _ b ha
  have hL := Real.log_lt_log (hM m) (product_scalar_moment_mono p q hp hq hne b a hb ha hmn)
  exact div_lt_div_of_pos_right (neg_lt_neg hL)
    (mul_pos hb (Real.log_pos (show 1 < 1 + a by linarith)))

end RenyiProductOrderPhase
