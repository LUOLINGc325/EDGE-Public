import QubitFoundation

namespace Lueders

noncomputable def realSign (v : ℝ) : ℝ := if 0 ≤ v then 1 else -1

theorem realSign_cases (v : ℝ) : realSign v = 1 ∨ realSign v = -1 := by
  unfold realSign
  split_ifs <;> simp

theorem realSign_mul (v : ℝ) : realSign v * v = |v| := by
  unfold realSign
  split_ifs with h
  · simp [abs_of_nonneg h]
  · simp [abs_of_neg (lt_of_not_ge h)]

theorem four_absolute_bound
    (a0 a1 a2 a3 b0 b1 b2 b3 u x z : ℝ)
    (hu : 0 ≤ u) (hball : x^2 + z^2 ≤ 1)
    (hc : ∀ s0 s1 s2 s3 : ℝ,
      (s0 = 1 ∨ s0 = -1) → (s1 = 1 ∨ s1 = -1) →
      (s2 = 1 ∨ s2 = -1) → (s3 = 1 ∨ s3 = -1) →
      (s0*a0+s1*a1+s2*a2+s3*a3)^2 +
        (s0*b0+s1*b1+s2*b2+s3*b3)^2 ≤ (2*u)^2) :
    (|a0*x+b0*z|+|a1*x+b1*z|+|a2*x+b2*z|+|a3*x+b3*z|)/2 ≤ u := by
  let s0 := realSign (a0*x+b0*z)
  let s1 := realSign (a1*x+b1*z)
  let s2 := realSign (a2*x+b2*z)
  let s3 := realSign (a3*x+b3*z)
  have hn := hc s0 s1 s2 s3 (realSign_cases _) (realSign_cases _)
    (realSign_cases _) (realSign_cases _)
  have hb := planar_dot_bound hball (show 0 ≤ 2*u by linarith) hn
  have he : |a0*x+b0*z|+|a1*x+b1*z|+|a2*x+b2*z|+|a3*x+b3*z| =
      (s0*a0+s1*a1+s2*a2+s3*a3)*x +
      (s0*b0+s1*b1+s2*b2+s3*b3)*z := by
    rw [← realSign_mul (a0*x+b0*z), ← realSign_mul (a1*x+b1*z),
      ← realSign_mul (a2*x+b2*z), ← realSign_mul (a3*x+b3*z)]
    dsimp [s0,s1,s2,s3]
    ring
  rw [he]
  have hle := (abs_le.mp hb).2
  linarith

noncomputable def fineTV (x z : ℝ) : ℝ :=
  (|(31/3900:ℝ)*x+(9/1300:ℝ)*z| +
   |(33/1300:ℝ)*x-(9/1300:ℝ)*z| +
   |(-41/1500:ℝ)*x+(9/500:ℝ)*z| +
   |(-3/500:ℝ)*x-(9/500:ℝ)*z|)/2

noncomputable def coarseTV (x z : ℝ) : ℝ :=
  (|(-11/7500:ℝ)*x+(9/2500:ℝ)*z| +
   |(87/2500:ℝ)*x-(9/2500:ℝ)*z| +
   |(-41/1500:ℝ)*x+(9/500:ℝ)*z| +
   |(-3/500:ℝ)*x-(9/500:ℝ)*z|)/2

theorem fine_sign_certificate (s0 s1 s2 s3 : ℝ)
    (h0 : s0 = 1 ∨ s0 = -1) (h1 : s1 = 1 ∨ s1 = -1)
    (h2 : s2 = 1 ∨ s2 = -1) (h3 : s3 = 1 ∨ s3 = -1) :
    (s0*(31/3900)+s1*(33/1300)+s2*(-41/1500)+s3*(-3/500))^2 +
      (s0*(9/1300)+s1*(-9/1300)+s2*(9/500)+s3*(-9/500))^2 ≤
      (2*(1/30:ℝ))^2 := by
  rcases h0 with rfl | rfl <;> rcases h1 with rfl | rfl <;>
    rcases h2 with rfl | rfl <;> rcases h3 with rfl | rfl <;> norm_num

theorem coarse_sign_certificate (s0 s1 s2 s3 : ℝ)
    (h0 : s0 = 1 ∨ s0 = -1) (h1 : s1 = 1 ∨ s1 = -1)
    (h2 : s2 = 1 ∨ s2 = -1) (h3 : s3 = 1 ∨ s3 = -1) :
    (s0*(-11/7500)+s1*(87/2500)+s2*(-41/1500)+s3*(-3/500))^2 +
      (s0*(9/2500)+s1*(-9/2500)+s2*(9/500)+s3*(-9/500))^2 ≤
      (2*(9/250:ℝ))^2 := by
  rcases h0 with rfl | rfl <;> rcases h1 with rfl | rfl <;>
    rcases h2 with rfl | rfl <;> rcases h3 with rfl | rfl <;> norm_num

theorem fineTV_upper (x z : ℝ) (hb : x^2+z^2 ≤ 1) : fineTV x z ≤ 1/30 := by
  have h := four_absolute_bound (31/3900) (33/1300) (-41/1500) (-3/500)
    (9/1300) (-9/1300) (9/500) (-9/500) (1/30) x z
    (by norm_num) hb fine_sign_certificate
  simpa only [fineTV, sub_eq_add_neg, neg_div, neg_mul] using h

theorem coarseTV_upper (x z : ℝ) (hb : x^2+z^2 ≤ 1) : coarseTV x z ≤ 9/250 := by
  have h := four_absolute_bound (-11/7500) (87/2500) (-41/1500) (-3/500)
    (9/2500) (-9/2500) (9/500) (-9/500) (9/250) x z
    (by norm_num) hb coarse_sign_certificate
  simpa only [coarseTV, sub_eq_add_neg, neg_div, neg_mul] using h

theorem fineTV_attained : fineTV 1 0 = 1/30 := by norm_num [fineTV, abs_div]
theorem coarseTV_attained : coarseTV (4/5) (-3/5) = 9/250 := by norm_num [coarseTV, abs_div]
theorem strict_gap : (9/250:ℝ)-(1/30:ℝ)=1/375 ∧ (1/30:ℝ)<9/250 := by norm_num
theorem relative_gain : (9/250:ℝ)=(27/25)*(1/30) := by norm_num

end Lueders
