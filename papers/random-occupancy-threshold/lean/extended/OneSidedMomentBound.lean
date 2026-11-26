import OccupancyFourthMoment

namespace TwoColorNullity.Occupancy

private noncomputable def negativePart (x : ℝ) : ℝ := max 0 (-x)

private theorem negativePart_nonnegative (x : ℝ) : 0 ≤ negativePart x := le_max_left _ _

private theorem absolute_eq_add_negative (x : ℝ) : |x| = x + 2 * negativePart x := by
  unfold negativePart
  by_cases hx : 0 ≤ x
  · rw [abs_of_nonneg hx, max_eq_left (neg_nonpos.mpr hx)]
    ring
  · have hn : x ≤ 0 := le_of_not_ge hx
    rw [abs_of_nonpos hn, max_eq_right (neg_nonneg.mpr hn)]
    ring

private theorem square_le_absolute_add_fourth (x cap : ℝ) (hc : 0 < cap) :
    x ^ 2 ≤ cap * |x| + x ^ 4 / cap ^ 2 := by
  have htail : 0 ≤ x ^ 4 / cap ^ 2 := by positivity
  by_cases hx : |x| ≤ cap
  · have h := mul_le_mul_of_nonneg_right hx (abs_nonneg x)
    rw [← pow_two, sq_abs] at h
    linarith
  · have hs : cap ^ 2 ≤ x ^ 2 := by
      have h := pow_le_pow_left₀ hc.le (le_of_lt (lt_of_not_ge hx)) 2
      rwa [sq_abs] at h
    have hlarge : x ^ 2 ≤ x ^ 4 / cap ^ 2 := by
      apply (le_div_iff₀ (by positivity : 0 < cap ^ 2)).mpr
      nlinarith only [mul_le_mul_of_nonneg_left hs (sq_nonneg x)]
    have hfirst : 0 ≤ cap * |x| := by positivity
    linarith

noncomputable def leftTailShift (a c : ℝ) : ℝ := a / (12 * (1 + 2 * c / a))

noncomputable def leftTailMass (a c : ℝ) : ℝ :=
  leftTailShift a c / (1 + (1 + c) / leftTailShift a c)

theorem leftTailShift_pos {a c : ℝ} (ha : 0 < a) (hc : 0 ≤ c) :
    0 < leftTailShift a c := by
  unfold leftTailShift
  positivity

theorem leftTailMass_pos {a c : ℝ} (ha : 0 < a) (hc : 0 ≤ c) :
    0 < leftTailMass a c := by
  have h := leftTailShift_pos ha hc
  unfold leftTailMass
  positivity

/-- A uniform positive lower-tail mass from second and fourth moment bounds. -/
theorem finiteProbability_leftTail_normalized {Sample : Type*} [Fintype Sample] [Nonempty Sample]
    (f : Sample → ℝ) (hzero : finiteMean f = 0) (a c : ℝ) (ha : 0 < a) (hc : 0 ≤ c)
    (hsecond : a ≤ finiteMean (fun x => f x ^ 2))
    (hfourth : finiteMean (fun x => f x ^ 4) ≤ c) :
    leftTailMass a c ≤ finiteProbability (fun x => f x ≤ -leftTailShift a c) := by
  classical
  let cap := 1 + 2 * c / a
  let shift := leftTailShift a c
  let barrier := 1 + (1 + c) / shift
  let neg (x : Sample) := negativePart (f x)
  have hcapOne : 1 ≤ cap := by
    unfold cap
    have hnonneg : 0 ≤ 2 * c / a := by positivity
    linarith
  have hcap : 0 < cap := by linarith
  have hshift : 0 < shift := leftTailShift_pos ha hc
  have hbarrier : 0 < barrier := by dsimp [barrier]; positivity
  have hscale : 2 * c ≤ cap * a := by
    apply (div_le_iff₀ ha).mp
    dsimp [cap]
    linarith
  have hcapsq : cap ≤ cap ^ 2 := by
    simpa only [mul_one, pow_two] using mul_le_mul_of_nonneg_left hcapOne hcap.le
  have herr : c / cap ^ 2 ≤ a / 2 := by
    apply (div_le_iff₀ (by positivity : 0 < cap ^ 2)).mpr
    nlinarith only [hscale, mul_le_mul_of_nonneg_left hcapsq ha.le]
  have hos := finiteMean_mono fun x => square_le_absolute_add_fourth (f x) cap hcap
  simp only [finiteMean_add, finiteMean_const_mul, finiteMean_div] at hos
  have hferr := (div_le_div_of_nonneg_right hfourth (sq_nonneg cap)).trans herr
  have hAbs : a / (2 * cap) ≤ finiteMean (fun x => |f x|) := by
    apply (div_le_iff₀ (by positivity : 0 < 2 * cap)).mpr
    linarith only [hsecond, hos, hferr]
  have habsEquality : finiteMean (fun x => |f x|) = 2 * finiteMean neg := by
    simp only [absolute_eq_add_negative, finiteMean_add, finiteMean_const_mul, hzero, zero_add, neg]
  have hshiftEquality : 6 * shift = a / (2 * cap) := by
    change 6 * (a / (12 * cap)) = a / (2 * cap)
    field_simp [hcap.ne']
    ring
  have hmeanNeg : 3 * shift ≤ finiteMean neg := by linarith only [hAbs, habsEquality, hshiftEquality]
  have hNegSq : finiteMean (fun x => neg x ^ 2) ≤ 1 + c := by
    have hpt (x : Sample) : neg x ^ 2 ≤ 1 + f x ^ 4 := by
      have hsq : f x ^ 2 ≤ 1 + f x ^ 4 := by nlinarith only [sq_nonneg (f x ^ 2 - 1), sq_nonneg (f x)]
      unfold neg negativePart
      by_cases hx : 0 ≤ f x
      · rw [max_eq_left (neg_nonpos.mpr hx), zero_pow (by decide : (2 : ℕ) ≠ 0)]
        positivity
      · rw [max_eq_right (neg_nonneg.mpr (le_of_not_ge hx)), neg_sq]
        exact hsq
    have h := finiteMean_mono hpt
    rw [finiteMean_add, finiteMean_const] at h
    exact h.trans (add_le_add_left hfourth 1)
  have hbarrierScale : 1 + c ≤ shift * barrier := by
    have heq : shift * barrier = shift + (1 + c) := by
      unfold barrier
      field_simp [hshift.ne']
    rw [heq]
    linarith
  have hNegError : finiteMean (fun x => neg x ^ 2) / barrier ≤ shift := by
    apply (div_le_iff₀ hbarrier).mpr
    exact hNegSq.trans hbarrierScale
  have hpoint (x : Sample) :
      neg x ≤ shift + barrier * (if shift ≤ neg x then 1 else 0) + neg x ^ 2 / barrier := by
    have hn := negativePart_nonnegative (f x)
    have htail : 0 ≤ neg x ^ 2 / barrier := by positivity
    by_cases hx : shift ≤ neg x
    · rw [if_pos hx, mul_one]
      by_cases hl : neg x ≤ barrier
      · linarith
      · have hh : neg x ≤ neg x ^ 2 / barrier := by
          apply (le_div_iff₀ hbarrier).mpr
          simpa only [pow_two, mul_comm] using
            mul_le_mul_of_nonneg_left (le_of_lt (lt_of_not_ge hl)) hn
        linarith
    · rw [if_neg hx, mul_zero, add_zero]
      linarith [lt_of_not_ge hx]
  have hprefix := finiteMean_mono hpoint
  simp only [finiteMean_add, finiteMean_const, finiteMean_const_mul, finiteMean_div,
    ← finiteProbability_eq_mean_indicator] at hprefix
  have hMass : shift / barrier ≤ finiteProbability (fun x => shift ≤ neg x) := by
    apply (div_le_iff₀ hbarrier).mpr
    linarith only [hprefix, hmeanNeg, hNegError]
  have hevent : (fun x => shift ≤ neg x) = (fun x => f x ≤ -shift) := by
    funext x
    apply propext
    change shift ≤ max 0 (-f x) ↔ f x ≤ -shift
    rw [le_max_iff]
    constructor
    · rintro (h | h)
      · linarith
      · linarith
    · intro h
      exact Or.inr (by linarith)
  rw [hevent] at hMass
  exact hMass

theorem finiteProbability_leftTail_scaled {Sample : Type*} [Fintype Sample] [Nonempty Sample]
    (f : Sample → ℝ) (hzero : finiteMean f = 0) (a c scale : ℝ)
    (ha : 0 < a) (hc : 0 ≤ c) (hs : 0 < scale)
    (hsecond : a * scale ≤ finiteMean (fun x => f x ^ 2))
    (hfourth : finiteMean (fun x => f x ^ 4) ≤ c * scale ^ 2) :
    leftTailMass a c ≤ finiteProbability (fun x => f x ≤ -leftTailShift a c * Real.sqrt scale) := by
  let root := Real.sqrt scale
  let g (x : Sample) := f x / root
  have hroot : 0 < root := Real.sqrt_pos.mpr hs
  have hsquare : root ^ 2 = scale := Real.sq_sqrt hs.le
  have hquad : root ^ 4 = scale ^ 2 := by rw [show root ^ 4 = (root ^ 2) ^ 2 by ring, hsquare]
  have hgzero : finiteMean g = 0 := by simp only [g, finiteMean_div, hzero, zero_div]
  have hgtwo : a ≤ finiteMean (fun x => g x ^ 2) := by
    simp only [g, div_pow, hsquare, finiteMean_div]
    exact (le_div_iff₀ hs).mpr hsecond
  have hgfour : finiteMean (fun x => g x ^ 4) ≤ c := by
    simp only [g, div_pow, hquad, finiteMean_div]
    exact (div_le_iff₀ (sq_pos_of_pos hs)).mpr hfourth
  have hprob := finiteProbability_leftTail_normalized g hgzero a c ha hc hgtwo hgfour
  have hevt : (fun x => g x ≤ -leftTailShift a c) =
      (fun x => f x ≤ -leftTailShift a c * root) := by
    funext x
    exact propext (div_le_iff₀ hroot)
  rwa [hevt] at hprob

end TwoColorNullity.Occupancy
