import Bridge
import Lower
import Certificates
import Upper
import Counts

set_option autoImplicit false

namespace ProperHats

/-- Each selected palette has actual legal colorings; none of the lower bounds is vacuous. -/
theorem proper_nonempty (r q : Nat) (hq : 3 ≤ q) :
    ∃ (c : Fin q) (x : Views r q), Proper c x := by
  refine ⟨⟨0, by omega⟩, fun _ => (⟨1, by omega⟩, ⟨2, by omega⟩), ?_⟩
  intro i
  constructor
  · intro h
    have hv := congrArg (fun z : Fin q => z.val) h
    norm_num at hv
  constructor
  · intro h
    have hv := congrArg (fun z : Fin q => z.val) h
    norm_num at hv
  · intro h
    have hv := congrArg (fun z : Fin q => z.val) h
    norm_num at hv

theorem solvable_one_five : Solvable 1 5 :=
  solvable_of_pair_cover (by decide) leafFive leafFive pair_cover_five

theorem solvable_two_six : Solvable 2 6 :=
  solvable_of_pair_cover (by decide) leafSix leafSix pair_cover_six

theorem solvable_three_seven : Solvable 3 7 :=
  solvable_of_pair_cover (by decide) leafSeven leafSeven pair_cover_seven

theorem optimal_one : Optimal 1 5 := by
  refine ⟨solvable_one_five, ?_⟩
  intro k hk
  by_contra hn
  have h6 : 6 ≤ k := by omega
  exact not_solvable_six_one (solvable_mono_colors (by decide) h6 hk)

theorem optimal_two : Optimal 2 6 := by
  refine ⟨solvable_two_six, ?_⟩
  intro k hk
  by_contra hn
  have h7 : 7 ≤ k := by omega
  exact not_solvable_seven_two (solvable_mono_colors (by decide) h7 hk)

theorem optimal_many (r : Nat) (hr : 3 ≤ r) : Optimal r 7 := by
  refine ⟨solvable_mono_petals hr solvable_three_seven, ?_⟩
  intro k hk
  by_contra hn
  have h8 : 8 ≤ k := by omega
  exact not_solvable_eight r (solvable_mono_colors (by decide) h8 hk)

noncomputable def windmillValue (r : Nat) : Nat := if r = 1 then 5 else if r = 2 then 6 else 7

/-- Complete classification for every nonempty triangular windmill. -/
theorem triangular_windmill_classification (r : Nat) (hr : 1 ≤ r) :
    Optimal r (windmillValue r) := by
  by_cases h1 : r = 1
  · subst r
    simpa [windmillValue] using optimal_one
  · by_cases h2 : r = 2
    · subst r
      simpa [windmillValue] using optimal_two
    · have h3 : 3 ≤ r := by omega
      simpa [windmillValue, h1, h2] using optimal_many r h3

/-- Three is the first petal count that permits seven colors. -/
theorem seven_iff_three_petals (r : Nat) (hr : 1 ≤ r) :
    Solvable r 7 ↔ 3 ≤ r := by
  constructor
  · intro hs
    by_contra hn
    have hr12 : r = 1 ∨ r = 2 := by omega
    rcases hr12 with h | h
    · subst r
      have hbad := optimal_one.2 7 hs
      omega
    · subst r
      exact not_solvable_seven_two hs
  · intro h3
    exact (optimal_many r h3).1

#print axioms triangular_windmill_classification
#print axioms seven_iff_three_petals

end ProperHats

-- Audit every declaration created in this module, including compiler auxiliaries.
open Lean in
run_cmd do
  let env ← getEnv
  let mut entries : Array (String × Array String) := #[]
  for (name, _) in env.constants.map₂.toList do
    let axioms ← Lean.collectAxioms name
    entries := entries.push (name.toString, axioms.map Name.toString)
  logInfo m!"EDEG_KERNEL_AXIOMS: {(toJson entries).compress}"
