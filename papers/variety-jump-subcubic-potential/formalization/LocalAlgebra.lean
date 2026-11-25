import Lean.Elab.Tactic.Omega

/-!
# Local algebra for the subcubic two-vacancy potential

All parameters are integers. Graph cardinalities are intended to be cast from
natural numbers. No graph identities or probabilistic assumptions are used here.
The graph-to-count identities belong in the separate graph bridge.
-/

namespace VarietyJump

/-- The local score after combining vacancy diversity, monochromatic edges,
and the degree correction. -/
noncomputable def H (m n r sd : Int) : Int :=
  4 * r + 4 * (if 0 < m + sd then 1 else 0) - 2 * m + 2 * n

/-- A destination with a positive variety count has this lower score bound. -/
theorem H_destination_ge
    (m n r sd : Int)
    (_hm : 0 ≤ m) (_hn : 0 ≤ n)
    (hr : 1 ≤ r) (hrn : r ≤ n)
    (_hsd0 : 0 ≤ sd) (_hsd1 : sd ≤ 1)
    (hdegree : m + n + sd ≤ 3) :
    6 * r + 2 * sd ≤ H m n r sd := by
  unfold H
  split <;> omega

/-- A source adjacent to the other vacancy has one less external neighbor
available; the `so` correction records that improvement in the upper bound. -/
theorem H_source_le
    (m n r sd so : Int)
    (hm : 0 ≤ m) (_hn : 0 ≤ n)
    (hr : 0 ≤ r) (hrn : r ≤ n)
    (hzero : r = 0 ↔ n = 0)
    (hsd0 : 0 ≤ sd) (hsd1 : sd ≤ 1)
    (hso0 : 0 ≤ so) (hso1 : so ≤ 1)
    (hdegree : m + n + sd + so ≤ 3) :
    H m n r sd ≤ 6 * r + 4 + 2 * sd - 2 * so := by
  unfold H
  by_cases hnzero : n = 0
  · have hrzero : r = 0 := hzero.mpr hnzero
    split <;> omega
  · have hrpos : 1 ≤ r := by
      have : r ≠ 0 := by
        intro hz
        exact hnzero (hzero.mp hz)
      omega
    split <;> omega

/-- Change due to the stationary vacancy and vacancy adjacency. -/
noncomputable def correction (alpha so do_ : Int) : Int :=
  4 * (1 - alpha) * (do_ - so) + 3 * (so - do_)

theorem correction_le
    (alpha so do_ : Int)
    (ha0 : 0 ≤ alpha) (ha1 : alpha ≤ 1)
    (hso0 : 0 ≤ so) (hso1 : so ≤ 1)
    (hdo0 : 0 ≤ do_) (hdo1 : do_ ≤ 1) :
    correction alpha so do_ ≤ 1 + 2 * so := by
  have ha : alpha = 0 ∨ alpha = 1 := by omega
  rcases ha with rfl | rfl <;> simp [correction] <;> omega

/-- General local potential decrease; this quantifies over all integer counts,
not a finite lookup table. The graph bridge must establish the stated count
constraints and identify this expression with the global potential change. -/
theorem local_potential_decrease
    (ms ns rs md nd rd sd so do_ alpha : Int)
    (hms : 0 ≤ ms) (hns : 0 ≤ ns) (hrs : 0 ≤ rs)
    (hmd : 0 ≤ md) (hnd : 0 ≤ nd)
    (hrsns : rs ≤ ns) (hrdnd : rd ≤ nd)
    (hzs : rs = 0 ↔ ns = 0)
    (hsd0 : 0 ≤ sd) (hsd1 : sd ≤ 1)
    (hso0 : 0 ≤ so) (hso1 : so ≤ 1)
    (hdo0 : 0 ≤ do_) (hdo1 : do_ ≤ 1)
    (ha0 : 0 ≤ alpha) (ha1 : alpha ≤ 1)
    (hsource : ms + ns + sd + so ≤ 3)
    (hdest : md + nd + sd + do_ ≤ 3)
    (hbetter : rs < rd) :
    H ms ns rs sd - H md nd rd sd + correction alpha so do_ ≤ -1 := by
  have hrd : 1 ≤ rd := by omega
  have hdest' : md + nd + sd ≤ 3 := by omega
  have hS := H_source_le ms ns rs sd so hms hns hrs hrsns hzs
    hsd0 hsd1 hso0 hso1 hsource
  have hD := H_destination_ge md nd rd sd hmd hnd hrd hrdnd
    hsd0 hsd1 hdest'
  have hC := correction_le alpha so do_ ha0 ha1 hso0 hso1 hdo0 hdo1
  omega

/-- Expanded expression convenient for a graph bridge that has already proved
the exact feature-difference identity. -/
theorem local_potential_decrease_expanded
    (ms ns rs md nd rd sd so do_ alpha : Int)
    (hms : 0 ≤ ms) (hns : 0 ≤ ns) (hrs : 0 ≤ rs)
    (hmd : 0 ≤ md) (hnd : 0 ≤ nd)
    (hrsns : rs ≤ ns) (hrdnd : rd ≤ nd)
    (hzs : rs = 0 ↔ ns = 0)
    (hsd0 : 0 ≤ sd) (hsd1 : sd ≤ 1)
    (hso0 : 0 ≤ so) (hso1 : so ≤ 1)
    (hdo0 : 0 ≤ do_) (hdo1 : do_ ≤ 1)
    (ha0 : 0 ≤ alpha) (ha1 : alpha ≤ 1)
    (hsource : ms + ns + sd + so ≤ 3)
    (hdest : md + nd + sd + do_ ≤ 3)
    (hbetter : rs < rd) :
    (4 * rs + 4 * (if 0 < ms + sd then 1 else 0) - 2 * ms + 2 * ns) -
      (4 * rd + 4 * (if 0 < md + sd then 1 else 0) - 2 * md + 2 * nd) +
      4 * (1 - alpha) * (do_ - so) + 3 * (so - do_) ≤ -1 := by
  have h := local_potential_decrease ms ns rs md nd rd sd so do_ alpha
    hms hns hrs hmd hnd hrsns hrdnd hzs hsd0 hsd1 hso0 hso1 hdo0 hdo1
    ha0 ha1 hsource hdest hbetter
  unfold H correction at h
  omega

end VarietyJump

#print axioms VarietyJump.H_destination_ge
#print axioms VarietyJump.H_source_le
#print axioms VarietyJump.correction_le
#print axioms VarietyJump.local_potential_decrease
#print axioms VarietyJump.local_potential_decrease_expanded
