import Mathlib.Data.Int.Basic
import Lean.Elab.Tactic.Omega

namespace TwoVisitsDuplicateMidpointResearchProof2

theorem strict_arc_event_window (p q t : ℤ) (h : q<p) : (if t≤p+q then (1:ℤ) else 0) - (if t≤2*q then 1 else 0) = if 2*q<t ∧ t≤p+q then 1 else 0 := by
  split_ifs <;> omega

end TwoVisitsDuplicateMidpointResearchProof2
