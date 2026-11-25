import OptimalCapital
import Mathlib.Analysis.SpecialFunctions.Complex.Analytic
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Analysis.Calculus.Deriv.MeanValue

open Filter
open scoped Topology

namespace IndependentMerging

noncomputable def smoothRoot (eps x : ℝ) : ℝ := Real.sqrt ((x - 1) ^ 2 + eps ^ 2)

noncomputable def smoothMerger (eps lam x y : ℝ) : ℝ :=
  1 + lam / 2 * ((x - 1) * smoothRoot eps y + (y - 1) * smoothRoot eps x)

theorem smoothRoot_argument_pos {eps : ℝ} (he : 0 < eps) (x : ℝ) :
    0 < (x - 1) ^ 2 + eps ^ 2 := by positivity

theorem smoothRoot_nonnegative (eps x : ℝ) : 0 ≤ smoothRoot eps x := Real.sqrt_nonneg _

theorem smoothRoot_pos {eps : ℝ} (he : 0 < eps) (x : ℝ) : 0 < smoothRoot eps x :=
  Real.sqrt_pos.mpr (smoothRoot_argument_pos he x)

theorem smoothRoot_square (eps x : ℝ) : smoothRoot eps x ^ 2 = (x - 1) ^ 2 + eps ^ 2 :=
  Real.sq_sqrt (by positivity)

theorem smoothRoot_gt_abs {eps : ℝ} (he : 0 < eps) (x : ℝ) :
    |x - 1| < smoothRoot eps x := by
  by_contra! hc
  have hs := mul_nonneg (sub_nonneg.mpr hc)
    (add_nonneg (abs_nonneg (x - 1)) (smoothRoot_nonnegative eps x))
  nlinarith [smoothRoot_square eps x, sq_abs (x - 1), sq_pos_of_pos he]

theorem smoothRoot_le_abs {eps : ℝ} (he : 0 ≤ eps) (x : ℝ) :
    smoothRoot eps x ≤ |x - 1| + eps := by
  apply (Real.sqrt_le_iff).mpr
  refine ⟨add_nonneg (abs_nonneg _) he, ?_⟩
  nlinarith [sq_abs (x - 1), mul_nonneg (abs_nonneg (x - 1)) he]

theorem smoothRoot_growth_bound {eps : ℝ} (he : 0 ≤ eps) (x : ℝ) :
    smoothRoot eps x ≤ |x| + 1 + eps := by
  have hx : |x - 1| ≤ |x| + 1 := by simpa using abs_sub_le x 0 1
  exact (smoothRoot_le_abs he x).trans (add_le_add_right hx eps)

theorem smoothRoot_continuous (eps : ℝ) : Continuous (smoothRoot eps) := by
  unfold smoothRoot
  fun_prop

theorem smoothRoot_analytic {eps : ℝ} (he : 0 < eps) (x : ℝ) :
    AnalyticAt ℝ (smoothRoot eps) x := by
  have hp : AnalyticAt ℝ (fun y : ℝ => (y - 1) ^ 2 + eps ^ 2) x := by fun_prop
  have hl := hp.log (smoothRoot_argument_pos he x)
  have hx := analyticAt_rexp.comp (hl.mul (analyticAt_const (v := (1 / 2 : ℝ))))
  have hf : smoothRoot eps = fun y => Real.exp (Real.log ((y - 1) ^ 2 + eps ^ 2) * (1 / 2)) := by
    funext y
    rw [smoothRoot, Real.sqrt_eq_rpow, Real.rpow_def_of_pos (smoothRoot_argument_pos he y)]
  rw [hf]
  exact hx

theorem smoothMerger_analytic {eps lam : ℝ} (he : 0 < eps) :
    AnalyticOnNhd ℝ (fun z : ℝ × ℝ => smoothMerger eps lam z.1 z.2) Set.univ := by
  intro z _
  have h₁ : AnalyticAt ℝ (Prod.fst : ℝ × ℝ → ℝ) z := analyticAt_fst
  have h₂ : AnalyticAt ℝ (Prod.snd : ℝ × ℝ → ℝ) z := analyticAt_snd
  have hr₁ := (smoothRoot_analytic he z.1).comp h₁
  have hr₂ := (smoothRoot_analytic he z.2).comp h₂
  unfold smoothMerger
  exact (analyticAt_const (v := (1 : ℝ))).add
    ((analyticAt_const (v := lam / 2)).mul
      (((h₁.sub analyticAt_const).mul hr₂).add ((h₂.sub analyticAt_const).mul hr₁)))

theorem smoothMerger_continuous (eps lam : ℝ) :
    Continuous (fun z : ℝ × ℝ => smoothMerger eps lam z.1 z.2) := by
  unfold smoothMerger
  have h := smoothRoot_continuous eps
  fun_prop

theorem smoothMerger_symm (eps lam x y : ℝ) :
    smoothMerger eps lam x y = smoothMerger eps lam y x := by
  unfold smoothMerger
  ring

theorem smoothRoot_derivative {eps : ℝ} (he : 0 < eps) (x : ℝ) :
    HasDerivAt (smoothRoot eps) ((x - 1) / smoothRoot eps x) x := by
  have hp : HasDerivAt (fun y : ℝ => (y - 1) ^ 2 + eps ^ 2) (2 * (x - 1)) x := by
    convert (((hasDerivAt_id x).sub_const 1).pow 2).add_const (eps ^ 2) using 1
    simp only [id_eq]
    all_goals ring
  have h := (Real.hasDerivAt_sqrt (smoothRoot_argument_pos he x).ne').comp x hp
  convert h using 1
  change (x - 1) / smoothRoot eps x = 1 / (2 * smoothRoot eps x) * (2 * (x - 1))
  field_simp [(smoothRoot_pos he x).ne']
  ring

theorem smoothMerger_left_derivative {eps : ℝ} (he : 0 < eps) (lam x y : ℝ) :
    HasDerivAt (fun z => smoothMerger eps lam z y)
      (lam / 2 * (smoothRoot eps y + (y - 1) * ((x - 1) / smoothRoot eps x))) x := by
  have h := (((hasDerivAt_id x).sub_const 1).mul_const (smoothRoot eps y)).add
    ((smoothRoot_derivative he x).const_mul (y - 1))
  simpa only [smoothMerger, id_eq, one_mul] using (h.const_mul (lam / 2)).const_add 1

theorem smoothMerger_strict_left {eps lam : ℝ} (he : 0 < eps) (hl : 0 < lam) (y : ℝ) :
    StrictMono (fun x => smoothMerger eps lam x y) := by
  apply strictMono_of_deriv_pos
  intro x
  rw [(smoothMerger_left_derivative he lam x y).deriv]
  refine mul_pos (by positivity) ?_
  have hx0 := smoothRoot_pos he x
  have hr : |(x - 1) / smoothRoot eps x| < 1 := by
    rw [abs_div, abs_of_pos hx0, div_lt_iff₀ hx0, one_mul]
    exact smoothRoot_gt_abs he x
  have hb : |(y - 1) * ((x - 1) / smoothRoot eps x)| ≤ |y - 1| := by
    rw [abs_mul]
    simpa only [mul_one] using mul_le_mul_of_nonneg_left hr.le (abs_nonneg (y - 1))
  have hh := neg_abs_le ((y - 1) * ((x - 1) / smoothRoot eps x))
  linarith [smoothRoot_gt_abs he y]

theorem smoothMerger_strict_right {eps lam : ℝ} (he : 0 < eps) (hl : 0 < lam) (x : ℝ) :
    StrictMono (smoothMerger eps lam x) := by
  intro a b hab
  rw [smoothMerger_symm eps lam x a, smoothMerger_symm eps lam x b]
  exact smoothMerger_strict_left he hl x hab

theorem smoothMerger_at_origin (eps lam : ℝ) :
    smoothMerger eps lam 0 0 = 1 - lam * Real.sqrt (1 + eps ^ 2) := by
  unfold smoothMerger smoothRoot
  rw [show ((0 : ℝ) - 1) ^ 2 = 1 by norm_num]
  ring

theorem smoothMerger_nonnegative {eps lam : ℝ} (he : 0 < eps) (hl : 0 < lam)
    (hu : lam ≤ 1 / Real.sqrt (1 + eps ^ 2)) {x y : ℝ} (hx : 0 ≤ x) (hy : 0 ≤ y) :
    0 ≤ smoothMerger eps lam x y := by
  have hroot : 0 < Real.sqrt (1 + eps ^ 2) := Real.sqrt_pos.mpr (by positivity)
  have hb := (le_div_iff₀ hroot).mp hu
  calc
    _ ≤ smoothMerger eps lam 0 0 := by rw [smoothMerger_at_origin]; linarith
    _ ≤ smoothMerger eps lam x 0 := (smoothMerger_strict_left he hl 0).monotone hx
    _ ≤ _ := (smoothMerger_strict_right he hl x).monotone hy

theorem smoothMerger_positive_example {x y : ℝ} (hx : 0 ≤ x) (hy : 0 ≤ y) :
    0 < smoothMerger (1 / 2) (1 / 2) x y := by
  have hsmall : Real.sqrt (1 + (1 / 2 : ℝ) ^ 2) < 2 := by
    apply (Real.sqrt_lt' (by norm_num)).mpr
    norm_num
  calc
    _ < smoothMerger (1 / 2) (1 / 2) 0 0 := by rw [smoothMerger_at_origin]; linarith
    _ ≤ smoothMerger (1 / 2) (1 / 2) x 0 :=
      (smoothMerger_strict_left (by norm_num) (by norm_num) 0).monotone hx
    _ ≤ _ := (smoothMerger_strict_right (by norm_num) (by norm_num) x).monotone hy

end IndependentMerging
