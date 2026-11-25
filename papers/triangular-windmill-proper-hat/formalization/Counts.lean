import Upper

set_option autoImplicit false

open Finset
open scoped BigOperators

namespace ProperHats
namespace Counts

/-- All proper exterior observations at the specified center color. -/
noncomputable def legalViews (r q : Nat) (c : Fin q) : Finset (Views r q) :=
  Fintype.piFinset fun _ : Fin r => (Upper.palette c).offDiag

/-- A proper full coloring records its center color and its exterior observation. -/
noncomputable def legalIncidences (r q : Nat) : Finset (Σ _ : Fin q, Views r q) :=
  Finset.univ.sigma fun c => legalViews r q c

/-- Exterior observations whose two leaf colors differ within every blade. -/
noncomputable def exteriorViews (r q : Nat) : Finset (Views r q) :=
  Fintype.piFinset fun _ : Fin r => (Finset.univ : Finset (Fin q)).offDiag

theorem mem_legalViews {r q : Nat} (c : Fin q) (x : Views r q) :
    x ∈ legalViews r q c ↔ Proper c x := by
  simp [legalViews, Upper.palette, Proper, ne_comm]

theorem mem_legalIncidences {r q : Nat} (c : Fin q) (x : Views r q) :
    Sigma.mk c x ∈ legalIncidences r q ↔ Proper c x := by
  simp [legalIncidences, mem_legalViews]

theorem mem_exteriorViews {r q : Nat} (x : Views r q) :
    x ∈ exteriorViews r q ↔ ∀ i, (x i).1 ≠ (x i).2 := by
  simp [exteriorViews]

theorem palette_offDiag_card {q : Nat} (c : Fin q) :
    (Upper.palette c).offDiag.card = (q - 1) * (q - 2) := by
  have hp : (Upper.palette c).card = q - 1 := by simp [Upper.palette]
  rw [Finset.offDiag_card, hp]
  calc
    (q - 1) * (q - 1) - (q - 1) = (q - 1) * ((q - 1) - 1) := by
      simp [Nat.mul_sub_left_distrib]
    _ = (q - 1) * (q - 2) := by simp [Nat.sub_sub]

theorem legalViews_card (r q : Nat) (c : Fin q) :
    (legalViews r q c).card = ((q - 1) * (q - 2)) ^ r := by
  rw [legalViews, Fintype.card_piFinset]
  simp only [palette_offDiag_card]
  simp

theorem legalIncidences_card (r q : Nat) :
    (legalIncidences r q).card = q * ((q - 1) * (q - 2)) ^ r := by
  simp [legalIncidences, Finset.card_sigma, legalViews_card]

theorem exteriorViews_card (r q : Nat) :
    (exteriorViews r q).card = (q * (q - 1)) ^ r := by
  have hbase : q * q - q = q * (q - 1) := by
    simp [Nat.mul_sub_left_distrib]
  simp [exteriorViews, Fintype.card_piFinset, Finset.offDiag_card, hbase]

/-- The proper full-coloring formula stated directly for the sigma of finite products. -/
theorem proper_incidence_card (r q : Nat) :
    (Finset.univ.sigma fun c : Fin q =>
      Fintype.piFinset (fun _ : Fin r => (Upper.palette c).offDiag)).card =
      q * ((q - 1) * (q - 2)) ^ r := by
  exact legalIncidences_card r q

/-- The exterior-observation formula stated directly for its finite product. -/
theorem exterior_piFinset_card (r q : Nat) :
    (Fintype.piFinset fun _ : Fin r =>
      (Finset.univ : Finset (Fin q)).offDiag).card = (q * (q - 1)) ^ r := by
  exact exteriorViews_card r q

end Counts
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
