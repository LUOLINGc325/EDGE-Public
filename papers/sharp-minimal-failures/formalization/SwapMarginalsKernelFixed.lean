import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

namespace SwapRoundingMinimalFailures

/-- A one-step elementary exchange state: two fractional coordinates `x` (for the
selected left element `i`) and `y` (for the selected right element `j`), and a third
unselected coordinate `z`. In the swap-rounding model the exchange pair `(i,j)` is
chosen so that `i ∈ L \ R` and `j ∈ R \ L`. With probability `u/(u+v)` the right base
is updated (`R ↦ R - j + i`), and with probability `v/(u+v)` the left base is updated
(`L ↦ L - i + j`). -/
structure ExchangeState where
  x : ℝ
  y : ℝ
  z : ℝ

/-- The `i`-coordinate update: it is incremented by `v` in the "right update" branch
(probability `u/(u+v)`) and decremented by `u` in the "left update" branch
(probability `v/(u+v)`). -/
noncomputable def updateX (u v : ℝ) (s : ExchangeState) (rightBranch : Bool) : ℝ :=
  if rightBranch then s.x + v else s.x - u

/-- The `j`-coordinate update: it is decremented by `v` in the "right update" branch
and incremented by `u` in the "left update" branch. -/
noncomputable def updateY (u v : ℝ) (s : ExchangeState) (rightBranch : Bool) : ℝ :=
  if rightBranch then s.y - v else s.y + u

/-- The unselected coordinate is unchanged by the elementary exchange. -/
def updateZ (s : ExchangeState) (_ : Bool) : ℝ := s.z

/-- The weighted expectation of the updated `i`-coordinate. -/
noncomputable def expectedX (u v : ℝ) (s : ExchangeState) : ℝ :=
  (u / (u + v)) * updateX u v s true + (v / (u + v)) * updateX u v s false

/-- The weighted expectation of the updated `j`-coordinate. -/
noncomputable def expectedY (u v : ℝ) (s : ExchangeState) : ℝ :=
  (u / (u + v)) * updateY u v s true + (v / (u + v)) * updateY u v s false

/-- The weighted expectation of the product of the unselected coordinate `z` with the
updated `i`-coordinate. This is the "product involving one unselected coordinate". -/
noncomputable def expectedZX (u v : ℝ) (s : ExchangeState) : ℝ :=
  (u / (u + v)) * (updateZ s true * updateX u v s true) +
    (v / (u + v)) * (updateZ s false * updateX u v s false)

/-- **Unchanged marginal mean for the `i`-coordinate.**
With `u, v > 0` and probabilities `u/(u+v)` and `v/(u+v)`, the weighted mean of the
updated `i`-coordinate equals the original `i`-coordinate. -/
theorem expectedX_eq (u v : ℝ) (hu : 0 < u) (hv : 0 < v) (s : ExchangeState) :
    expectedX u v s = s.x := by
  unfold expectedX updateX
  have hne : u + v ≠ 0 := by positivity
  field_simp
  ring

/-- **Unchanged marginal mean for the `j`-coordinate.**
With `u, v > 0` and probabilities `u/(u+v)` and `v/(u+v)`, the weighted mean of the
updated `j`-coordinate equals the original `j`-coordinate. -/
theorem expectedY_eq (u v : ℝ) (hu : 0 < u) (hv : 0 < v) (s : ExchangeState) :
    expectedY u v s = s.y := by
  unfold expectedY updateY
  have hne : u + v ≠ 0 := by positivity
  field_simp
  ring

/-- **Unchanged product mean with one unselected coordinate.**
With `u, v > 0` and probabilities `u/(u+v)` and `v/(u+v)`, the weighted mean of the
product of the untouched coordinate `z` with the updated `i`-coordinate equals the
original product `z * x`. -/
theorem expectedZX_eq (u v : ℝ) (hu : 0 < u) (hv : 0 < v) (s : ExchangeState) :
    expectedZX u v s = s.z * s.x := by
  unfold expectedZX updateZ updateX
  have hne : u + v ≠ 0 := by positivity
  field_simp
  ring

end SwapRoundingMinimalFailures
