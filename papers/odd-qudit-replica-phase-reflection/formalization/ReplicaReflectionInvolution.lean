import Mathlib.Algebra.Group.Basic
import Mathlib.Tactic.Abel

namespace OddQuditReplicaPhaseReflectionResearchProof1

/-- The replica-coordinate reflection `s ↦ -s + g`, applied twice, is the identity
on the whole coordinate function.  Only the additive group structure of the replica
group `G` is used, so no coprimality hypothesis on the replica order is required. -/
theorem replica_reflection_involution {G α : Type*} [AddCommGroup G] (g : G) (x : G → α) :
    (fun s => x (-(-s+g)+g)) = x := by
  funext s
  congr 1
  abel

end OddQuditReplicaPhaseReflectionResearchProof1
