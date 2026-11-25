import Core
import Lean

/- Independent audit of the compiled Core module by its imported-module index. -/
open Lean in
run_cmd do
  let env ← getEnv
  let some coreIdx := env.getModuleIdx? `Core
    | throwError "The freshly compiled Core module is not imported"
  let mut rows : Array Json := #[]
  for (name, info) in env.constants do
    if env.getModuleIdxFor? name == some coreIdx then
      let axioms ← Lean.collectAxioms name
      let kind := match info with
        | .axiomInfo _ => "axiom"
        | .defnInfo _ => "definition"
        | .thmInfo _ => "theorem"
        | .opaqueInfo _ => "opaque"
        | .quotInfo _ => "quotient"
        | .inductInfo _ => "inductive"
        | .ctorInfo _ => "constructor"
        | .recInfo _ => "recursor"
      rows := rows.push <| Json.mkObj [
        ("declaration", toJson name.toString),
        ("kind", toJson kind),
        ("unsafe", toJson info.isUnsafe),
        ("partial", toJson info.isPartial),
        ("axioms", toJson (axioms.map Name.toString))]
  logInfo m!"INDEPENDENT_IMPORTED_CORE: {(toJson rows).compress}"

set_option pp.proofs false
set_option format.width 120
#print RenyiProductOrderPhase.reciprocalJensenGap
#print RenyiProductOrderPhase.reciprocalJensenGap.eq_1
#print RenyiProductOrderPhase.reciprocalJensenGap_identity
#print RenyiProductOrderPhase.reciprocalJensenGap_nonneg
#print RenyiProductOrderPhase.reciprocalJensenGap_pos
#print RenyiProductOrderPhase.reciprocalJensenGap_zero_iff
#print RenyiProductOrderPhase.strict_reciprocalJensen
#print RenyiProductOrderPhase.finiteWeightedMean_pos
#print RenyiProductOrderPhase.finiteReciprocalGap_identity
#print RenyiProductOrderPhase.finiteReciprocalGap_nonneg
#print RenyiProductOrderPhase.finiteReciprocalGap_pos
#print RenyiProductOrderPhase.finiteReciprocalGap_zero_iff
#print RenyiProductOrderPhase.finiteReciprocalGap_pos_of_distinct
#print RenyiProductOrderPhase.concrete_nonzero_gap
