import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace FiniteHorizon

/-- The quadratic identity behind the update of the remaining distance. -/
theorem distance_square_gap {r q y q' : ℝ}
    (hstep : q' ^ 2 = (1 - 1 / r ^ 2) * q ^ 2 - 2 * (1 - 1 / r) * q * y)
    (hr : r ≠ 0) :
    (q - y) ^ 2 - q' ^ 2 = (y - q / r) ^ 2 := by
  rw [hstep]
  (field_simp; ring)

/-- On a surviving step, the updated distance is at most the old distance
after subtracting the observation. -/
theorem next_distance_le {r q y q' : ℝ}
    (hr : 2 ≤ r) (hq : 0 < q)
    (hy : y < (r + 1) * q / (2 * r))
    (hstep : q' ^ 2 = (1 - 1 / r ^ 2) * q ^ 2 - 2 * (1 - 1 / r) * q * y) :
    q' ≤ q - y := by
  have hr0 : 0 < r := by linarith
  have hy' := (lt_div_iff₀ (by linarith : 0 < 2 * r)).1 hy
  have hprod := mul_nonneg (show 0 ≤ r - 1 by linarith) hq.le
  have hdiff : 0 < q - y := by
    by_contra! h
    have hbad := mul_nonneg (show 0 ≤ y - q by linarith) hr0.le
    nlinarith only [hy', hprod, hbad]
  have hgap := distance_square_gap hstep hr0.ne'
  have hsquare : q' ^ 2 ≤ (q - y) ^ 2 := by
    nlinarith only [hgap, sq_nonneg (y - q / r)]
  exact le_of_pow_le_pow_left₀ (by decide : (2 : ℕ) ≠ 0) hdiff.le hsquare

/-- For a surviving step, the quadratic capital is debited by twice the
product of the old distance and the new observation. -/
theorem capital_update {r q y q' : ℝ}
    (hr : 2 ≤ r)
    (hstep : q' ^ 2 = (1 - 1 / r ^ 2) * q ^ 2 - 2 * (1 - 1 / r) * q * y) :
    r / (r - 1) * q' ^ 2 = (r + 1) / r * q ^ 2 - 2 * q * y := by
  have hr0 : r ≠ 0 := by linarith
  have hr1 : r - 1 ≠ 0 := by linarith
  rw [hstep]
  (field_simp; ring)

/-- At the last step the quadratic capital is exhausted exactly on crossing. -/
theorem last_step_reject_iff {q y : ℝ} (hq : 0 < q) :
    2 * q ^ 2 - 2 * q * y ≤ 0 ↔ q ≤ y := by
  have hfactor : 2 * q ^ 2 - 2 * q * y = 2 * q * (q - y) := by ring
  rw [hfactor]
  constructor
  · intro h
    exact sub_nonpos.mp (nonpos_of_mul_nonpos_right h (by linarith))
  · intro h
    exact mul_nonpos_of_nonneg_of_nonpos (by linarith) (sub_nonpos.mpr h)


/-- Re-express the raw log-gap update in squared-distance coordinates,
including the last round. -/
theorem log_gap_update {r d q y : ℝ} (hr : r ≠ 0)
    (hd : d = 2 * q ^ 2 / r) :
    r / 2 * (d - (4 * q / r) * y + (4 * q / r) ^ 2 / 8) =
      (r + 1) / r * q ^ 2 - 2 * q * y := by
  rw [hd]
  (field_simp; ring)

/-- Positive remaining capital is equivalent to lying strictly below the
survival threshold. -/
theorem capital_pos_iff {r q y : ℝ} (hr : 0 < r) (hq : 0 < q) :
    0 < (r + 1) / r * q ^ 2 - 2 * q * y ↔
      y < (r + 1) * q / (2 * r) := by
  have hfactor :
      (r + 1) / r * q ^ 2 - 2 * q * y =
        2 * q * ((r + 1) * q / (2 * r) - y) := by
    have hr0 := hr.ne'
    field_simp
  rw [hfactor]
  constructor
  · intro h
    exact sub_pos.mp (pos_of_mul_pos_right h (by linarith : 0 ≤ 2 * q))
  · intro h
    exact mul_pos (by linarith : 0 < 2 * q) (sub_pos.mpr h)

/-- A prefix of observations with positive capital after every update. The
remaining horizon can exceed the length of the prefix. -/
inductive SurvivingPrefix : ℕ → ℝ → List ℝ → Prop where
  | nil {n : ℕ} {q : ℝ} (hq : 0 < q) : SurvivingPrefix n q []
  | last {q y : ℝ} (hy : y < q) : SurvivingPrefix 1 q [y]
  | step {n : ℕ} {q q' y : ℝ} {ys : List ℝ}
      (hq : 0 < q)
      (hy : y < ((n : ℝ) + 2 + 1) * q / (2 * ((n : ℝ) + 2)))
      (hstep : q' ^ 2 =
        (1 - 1 / ((n : ℝ) + 2) ^ 2) * q ^ 2 -
          2 * (1 - 1 / ((n : ℝ) + 2)) * q * y)
      (htail : SurvivingPrefix (n + 1) q' ys) :
      SurvivingPrefix (n + 2) q (y :: ys)

/-- Surviving a prefix requires that its cumulative increment is strictly
smaller than its starting distance. -/
theorem sum_lt_distance {n : ℕ} {q : ℝ} {ys : List ℝ}
    (h : SurvivingPrefix n q ys) : ys.sum < q := by
  induction h with
  | nil hq => simpa using hq
  | last hy => simpa using hy
  | @step n q q' y ys hq hy hstep _ ih =>
    have hn : 0 ≤ (n : ℝ) := Nat.cast_nonneg n
    have hr : 2 ≤ (n : ℝ) + 2 := by linarith
    have hdist := next_distance_le hr hq hy hstep
    simp only [List.sum_cons]
    linarith

/-- Recover the distance used to choose the next bet from the capital. -/
noncomputable def distance (r : ℕ) (V : ℝ) : ℝ :=
  Real.sqrt ((r : ℝ) / ((r : ℝ) + 1) * V)

private theorem distance_sq (r : ℕ) {V : ℝ} (hV : 0 ≤ V) :
    distance r V ^ 2 = (r : ℝ) / ((r : ℝ) + 1) * V := by
  have hr : 0 ≤ (r : ℝ) := Nat.cast_nonneg r
  unfold distance
  exact Real.sq_sqrt (mul_nonneg (div_nonneg hr (by linarith)) hV)

private theorem capital_of_distance (r : ℕ) (hr : 0 < r) {V : ℝ} (hV : 0 ≤ V) :
    V = ((r : ℝ) + 1) / (r : ℝ) * distance r V ^ 2 := by
  have hr0 : 0 < (r : ℝ) := Nat.cast_pos.mpr hr
  have hr1 : (r : ℝ) + 1 ≠ 0 := by linarith
  rw [distance_sq r hV]
  field_simp

private theorem distance_pos (r : ℕ) (hr : 0 < r) {V : ℝ} (hV : 0 < V) :
    0 < distance r V := by
  have hr0 : 0 < (r : ℝ) := Nat.cast_pos.mpr hr
  unfold distance
  exact Real.sqrt_pos.mpr (mul_pos (div_pos hr0 (by linarith)) hV)

/-- Positive raw capital through each update means the rule has survived
the observed prefix. Checking a prefix longer than the horizon fails. -/
noncomputable def accepts (remaining : ℕ) (V : ℝ) : List ℝ → Prop
  | [] => 0 < V
  | y :: ys =>
    match remaining with
    | 0 => False
    | n + 1 =>
      0 < V ∧ accepts n (V - 2 * distance (n + 1) V * y) ys

theorem accepts_capital_pos {r : ℕ} {V : ℝ} {ys : List ℝ}
    (h : accepts r V ys) : 0 < V := by
  cases ys with
  | nil => simpa only [accepts] using h
  | cons y ys =>
    cases r with
    | zero => exact False.elim h
    | succ n => exact h.1

/-- Every positive-capital run of the actual recursion satisfies the
distance updates, through the terminal round when present. -/
theorem accepts_surviving_prefix {r : ℕ} {V : ℝ} {ys : List ℝ}
    (hr : 0 < r) (h : accepts r V ys) :
    SurvivingPrefix r (distance r V) ys := by
  induction ys generalizing r V with
  | nil => exact .nil (distance_pos r hr (accepts_capital_pos h))
  | cons y ys ih =>
    cases r with
    | zero => omega
    | succ n =>
      change 0 < V ∧ accepts n (V - 2 * distance (n + 1) V * y) ys at h
      have hVnext := accepts_capital_pos h.2
      have hq := distance_pos (n + 1) hr h.1
      have hV := capital_of_distance (n + 1) hr h.1.le
      have hcast : 0 < ((n + 1 : ℕ) : ℝ) := Nat.cast_pos.mpr hr
      have hthreshold := (capital_pos_iff hcast hq).mp (by
        nth_rw 1 [← hV]
        exact hVnext)
      cases n with
      | zero =>
        cases ys with
        | nil =>
          have hy : y < distance 1 V := by
            norm_num at hthreshold
            linarith
          exact .last hy
        | cons z zs =>
          exact False.elim h.2
      | succ n =>
        have hn : 0 < n + 1 := Nat.succ_pos n
        let q := distance (n + 2) V
        let V' := V - 2 * q * y
        let q' := distance (n + 1) V'
        have htail : SurvivingPrefix (n + 1) q' ys := ih hn h.2
        have hcast' : 0 < (n : ℝ) + 2 := by
          have := Nat.cast_nonneg (α := ℝ) n
          linarith
        have hfactor :
            (n : ℝ) + 1 + 1 = (n : ℝ) + 2 := by ring
        have hsq : q' ^ 2 =
            (1 - 1 / ((n : ℝ) + 2) ^ 2) * q ^ 2 -
              2 * (1 - 1 / ((n : ℝ) + 2)) * q * y := by
          change distance (n + 1) V' ^ 2 = _
          rw [distance_sq (n + 1) hVnext.le]
          change ((↑(n + 1) : ℝ) / (↑(n + 1) + 1)) * (V - 2 * q * y) = _
          rw [hV]
          change ((↑(n + 1) : ℝ) / (↑(n + 1) + 1)) *
            (((↑(n + 1 + 1) : ℝ) + 1) / (↑(n + 1 + 1) : ℝ) * q ^ 2 -
              2 * q * y) = _
          simp only [Nat.cast_add, Nat.cast_one, hfactor]
          have hneq := hcast'.ne'
          (field_simp; ring)
        have hbelow : y < ((n : ℝ) + 2 + 1) * q / (2 * ((n : ℝ) + 2)) := by
          simpa only [Nat.cast_add, Nat.cast_one, hfactor] using hthreshold
        exact .step hq hbelow hsq htail

/-- If an observed prefix reaches the starting distance, capital positivity
must have failed at or before the end of that prefix. -/
theorem rejects_of_sum_ge_distance {r : ℕ} {V : ℝ} {ys : List ℝ}
    (hr : 0 < r) (hcross : distance r V ≤ ys.sum) :
    ¬ accepts r V ys := by
  intro h
  exact (not_lt_of_ge hcross) (sum_lt_distance (accepts_surviving_prefix hr h))


end FiniteHorizon

#print axioms FiniteHorizon.distance_square_gap
#print axioms FiniteHorizon.next_distance_le
#print axioms FiniteHorizon.capital_update
#print axioms FiniteHorizon.log_gap_update
#print axioms FiniteHorizon.capital_pos_iff
#print axioms FiniteHorizon.sum_lt_distance

#print axioms FiniteHorizon.rejects_of_sum_ge_distance
