import ProductMonotonicity

/-! The output involution and exact Hamming-distance reduction. -/

open scoped BigOperators

namespace RenyiProductOrderPhase

variable {κ : Type*} [Fintype κ]

structure BinarySymmetricChannel (κ : Type*) [Fintype κ] where
  channel : Bool → FiniteMass κ
  positive : ∀ i y, 0 < channel i y
  flip : κ ≃ κ
  involutive : Function.Involutive flip
  swaps : ∀ y, channel true y = channel false (flip y)
  informative : channel false ≠ channel true

namespace BinarySymmetricChannel

theorem swaps_reverse (w : BinarySymmetricChannel κ) (y : κ) :
    w.channel false y = w.channel true (w.flip y) := by
  rw [w.swaps, w.involutive]

theorem flip_ratio_expect (w : BinarySymmetricChannel κ) (g : ℝ → ℝ) :
    (w.channel true).expect (fun y => g (w.channel false y / w.channel true y)) =
      (w.channel false).expect (fun y => g (w.channel true y / w.channel false y)) := by
  unfold FiniteMass.expect
  calc
    _ = ∑ y, w.channel false (w.flip y) *
        g (w.channel true (w.flip y) / w.channel false (w.flip y)) := by
      refine Finset.sum_congr rfl fun y _ => ?_
      have h : w.channel false y = w.channel true (w.flip y) := w.swaps_reverse y
      change w.channel true y * g (w.channel false y / w.channel true y) =
        w.channel false (w.flip y) * g (w.channel true (w.flip y) / w.channel false (w.flip y))
      rw [w.swaps y, h]
    _ = _ := Equiv.sum_comp w.flip (fun y =>
      w.channel false y * g (w.channel true y / w.channel false y))

end BinarySymmetricChannel

noncomputable def mismatchCount {n : ℕ} (x y : Fin n → Bool) : ℕ :=
  ∑ i, if x i = y i then 0 else 1

theorem mismatch_count_succ {n : ℕ} (x y : Fin (n + 1) → Bool) :
    mismatchCount x y =
      mismatchCount (fun i : Fin n => x i.succ) (fun i : Fin n => y i.succ) +
        (if x 0 = y 0 then 0 else 1) := by
  unfold mismatchCount
  rw [Fin.sum_univ_succ, add_comm]

theorem mismatch_count_le {n : ℕ} (x y : Fin n → Bool) : mismatchCount x y ≤ n := by
  unfold mismatchCount
  calc
    _ ≤ ∑ _i : Fin n, (1 : ℕ) := Finset.sum_le_sum (fun i _ => by split <;> omega)
    _ = n := by simp

theorem mismatch_count_antipodal (n : ℕ) :
    mismatchCount (fun _ : Fin n => false) (fun _ : Fin n => true) = n := by
  simp [mismatchCount]

theorem product_scalar_moment_recurrence (p q : FiniteMass κ) (n : ℕ) (b a : ℝ) :
    productScalarMoment p q (n + 1) b a =
      p.expect (fun y => productScalarMoment p q n b (a * (q y / p y))) := by
  rw [productScalarMoment, FiniteMass.tensor_expect_succ]
  unfold productScalarMoment
  congr 1
  funext y
  congr 1
  funext z
  simp only [likelihood_product_succ, mul_assoc]

theorem tensor_channel_scalar_step (w : Bool → FiniteMass κ) {n : ℕ}
    (x y : Fin (n + 1) → Bool) (b a : ℝ) :
    scalarMoment (tensorChannel w (n + 1) x) (tensorChannel w (n + 1) y) b a =
      (w (x 0)).expect (fun j => scalarMoment
        (tensorChannel w n (fun i => x i.succ)) (tensorChannel w n (fun i => y i.succ))
        b (a * (w (y 0) j / w (x 0) j))) := by
  unfold scalarMoment
  simp only [tensorChannel]
  rw [FiniteMass.tensor_expect_succ_rows]
  congr 1
  funext j
  congr 1
  funext z
  simp only [FiniteMass.tensor_ratio, Fin.prod_univ_succ, Fin.cons_zero, Fin.cons_succ, mul_assoc]

theorem tensor_channel_scalar_distance (w : BinarySymmetricChannel κ) {n : ℕ}
    (x y : Fin n → Bool) (b a : ℝ) :
    scalarMoment (tensorChannel w.channel n x) (tensorChannel w.channel n y) b a =
      productScalarMoment (w.channel false) (w.channel true) (mismatchCount x y) b a := by
  induction n generalizing a with
  | zero =>
    have hT (u : Fin 0 → Bool) (i : Bool) :
        tensorChannel w.channel 0 u = FiniteMass.tensor (fun _ : Fin 0 => w.channel i) := by
      ext j
      simp [tensorChannel]
    have hc : mismatchCount x y = 0 := by simp [mismatchCount]
    rw [hT x false, hT y true, hc, scalar_moment_of_products]
  | succ n ih =>
    let x' : Fin n → Bool := fun i => x i.succ
    let y' : Fin n → Bool := fun i => y i.succ
    let m := mismatchCount x' y'
    have hStep :
        scalarMoment (tensorChannel w.channel (n + 1) x)
          (tensorChannel w.channel (n + 1) y) b a =
          (w.channel (x 0)).expect (fun j =>
            productScalarMoment (w.channel false) (w.channel true) m b
              (a * (w.channel (y 0) j / w.channel (x 0) j))) := by
      rw [tensor_channel_scalar_step]
      congr 1
      funext j
      exact ih x' y' (a * (w.channel (y 0) j / w.channel (x 0) j))
    rw [hStep, mismatch_count_succ]
    change _ = productScalarMoment (w.channel false) (w.channel true)
      (m + if x 0 = y 0 then 0 else 1) b a
    cases hx : x 0 <;> cases hy : y 0
    · have hh (j : κ) : w.channel false j / w.channel false j = 1 :=
        div_self (w.positive false j).ne'
      simp only [hx, hy, if_true, if_pos rfl, Nat.add_zero, hh, mul_one, FiniteMass.expect_const]
    · simp only [hx, hy, if_neg (by decide : false ≠ true)]
      exact (product_scalar_moment_recurrence (w.channel false) (w.channel true) m b a).symm
    · simp only [hx, hy, if_neg (by decide : true ≠ false)]
      rw [w.flip_ratio_expect (fun z =>
        productScalarMoment (w.channel false) (w.channel true) m b (a * z))]
      exact (product_scalar_moment_recurrence (w.channel false) (w.channel true) m b a).symm
    · have hh (j : κ) : w.channel true j / w.channel true j = 1 :=
        div_self (w.positive true j).ne'
      simp only [hx, hy, if_true, if_pos rfl, Nat.add_zero, hh, mul_one, FiniteMass.expect_const]

end RenyiProductOrderPhase
