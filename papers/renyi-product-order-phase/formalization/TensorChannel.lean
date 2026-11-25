import FiniteRenyi
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Data.Fin.Tuple.Basic
import Mathlib.Data.Fintype.Pi

/-! Independent finite products and factorization of expectations. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

namespace FiniteMass

variable {ι κ : Type*} [Fintype ι] [Fintype κ] [DecidableEq ι]

noncomputable def tensor (p : ι → FiniteMass κ) : FiniteMass (ι → κ) where
  weight x := ∏ i, p i (x i)
  weight_nonneg x := Finset.prod_nonneg (fun i _ => (p i).weight_nonneg (x i))
  total := by
    classical
    calc
      (∑ x : ι → κ, ∏ i, p i (x i)) = ∏ i, ∑ y, p i y :=
        (Fintype.prod_sum (fun (i : ι) (y : κ) => p i y)).symm
      _ = 1 := by simp only [FiniteMass.total, Finset.prod_const_one]

@[simp] theorem tensor_apply (p : ι → FiniteMass κ) (x : ι → κ) :
    tensor p x = ∏ i, p i (x i) := rfl

theorem tensor_pos (p : ι → FiniteMass κ) (hp : ∀ i y, 0 < p i y) (x : ι → κ) :
    0 < tensor p x :=
  Finset.prod_pos (fun i _ => hp i (x i))

theorem tensor_expect_product (p : ι → FiniteMass κ) (g : ι → κ → ℝ) :
    (tensor p).expect (fun x => ∏ i, g i (x i)) = ∏ i, (p i).expect (g i) := by
  classical
  unfold expect
  calc
    _ = ∑ x : ι → κ, ∏ i, p i (x i) * g i (x i) := by
      refine Finset.sum_congr rfl fun x _ => ?_
      rw [tensor_apply, Finset.prod_mul_distrib]
    _ = _ := (Fintype.prod_sum (fun (i : ι) (y : κ) => p i y * g i y)).symm

theorem tensor_expect_succ_rows {n : ℕ} (p : Fin (n + 1) → FiniteMass κ)
    (F : (Fin (n + 1) → κ) → ℝ) :
    (tensor p).expect F =
      (p 0).expect (fun y => (tensor (fun i : Fin n => p i.succ)).expect
        (fun z => F (Fin.cons y z))) := by
  classical
  let e := Fin.consEquiv (fun _ : Fin (n + 1) => κ)
  unfold expect
  calc
    _ = ∑ x : κ × (Fin n → κ), tensor p (e x) * F (e x) :=
      (Equiv.sum_comp e (fun y => tensor p y * F y)).symm
    _ = _ := by
      rw [Fintype.sum_prod_type]
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [Finset.mul_sum]
      refine Finset.sum_congr rfl fun z _ => ?_
      change tensor p (Fin.cons j z) * F (Fin.cons j z) =
        p 0 j * (tensor (fun i : Fin n => p i.succ) z * F (Fin.cons j z))
      simp only [tensor_apply, Fin.prod_univ_succ, Fin.cons_zero, Fin.cons_succ, mul_assoc]

theorem tensor_expect_succ {n : ℕ} (p : FiniteMass κ) (F : (Fin (n + 1) → κ) → ℝ) :
    (tensor (fun _ : Fin (n + 1) => p)).expect F =
      p.expect (fun y => (tensor (fun _ : Fin n => p)).expect (fun z => F (Fin.cons y z))) :=
  tensor_expect_succ_rows (fun _ => p) F

theorem tensor_ratio (p q : ι → FiniteMass κ) (x : ι → κ) :
    tensor q x / tensor p x = ∏ i, q i (x i) / p i (x i) := by
  simp only [tensor_apply, Finset.prod_div_distrib]

end FiniteMass

variable {κ : Type*} [Fintype κ]

noncomputable def tensorChannel (w : Bool → FiniteMass κ) (n : ℕ) :
    (Fin n → Bool) → FiniteMass (Fin n → κ) :=
  fun x => FiniteMass.tensor (fun i => w (x i))

theorem tensor_channel_pos (w : Bool → FiniteMass κ) (hw : ∀ i y, 0 < w i y)
    {n : ℕ} (x : Fin n → Bool) (y : Fin n → κ) :
    0 < tensorChannel w n x y :=
  FiniteMass.tensor_pos _ (fun i z => hw (x i) z) y

noncomputable def likelihoodProduct {n : ℕ} (p q : FiniteMass κ) (x : Fin n → κ) : ℝ :=
  ∏ i, q (x i) / p (x i)

theorem likelihood_product_pos {n : ℕ} (p q : FiniteMass κ)
    (hp : ∀ y, 0 < p y) (hq : ∀ y, 0 < q y) (x : Fin n → κ) :
    0 < likelihoodProduct p q x :=
  Finset.prod_pos (fun i _ => div_pos (hq (x i)) (hp (x i)))

theorem likelihood_product_succ {n : ℕ} (p q : FiniteMass κ) (y : κ) (z : Fin n → κ) :
    likelihoodProduct p q (Fin.cons y z) = (q y / p y) * likelihoodProduct p q z := by
  simp only [likelihoodProduct, Fin.prod_univ_succ, Fin.cons_zero, Fin.cons_succ]

theorem likelihood_product_mean_one (p q : FiniteMass κ) (hp : ∀ y, 0 < p y) (n : ℕ) :
    (FiniteMass.tensor (fun _ : Fin n => p)).expect (likelihoodProduct p q) = 1 := by
  unfold likelihoodProduct
  rw [FiniteMass.tensor_expect_product (fun _ : Fin n => p) (fun _ y => q y / p y)]
  simp only [reference_expected_ratio q p (FiniteMass.absolutelyContinuous_of_pos q p hp),
    Finset.prod_const_one]

end RenyiProductOrderPhase
