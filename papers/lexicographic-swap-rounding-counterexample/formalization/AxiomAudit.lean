import Lean
import Lean.Util.CollectAxioms
import SwapDefinitions
import UniformMatroid
import Counterexample
import Parametric

/-!
Audit every declaration owned by the four mathematical modules, including
private names, instances, equation lemmas and compiler-generated helpers.
Ownership uses Lean's module index, not a handpicked theorem list or a textual
namespace prefix.  collectAxioms traverses both type and value dependencies in
the checked kernel environment.  Any non-whitelisted axiom makes compilation
fail before the final PASS record is emitted.
-/

open Lean Elab Command

run_cmd do
  let env ← getEnv
  let modules : Array Name := #[`SwapDefinitions, `UniformMatroid, `Counterexample, `Parametric]
  let allowed : Array Name := #[`Classical.choice, `Quot.sound, `propext]
  let mut names : Array Name := #[]
  for (name, _) in env.constants.toList do
    if let some idx := env.getModuleIdxFor? name then
      if modules.contains env.header.moduleNames[idx.toNat]! then
        names := names.push name
  names := names.qsort Name.lt
  if names.isEmpty then
    throwError "Axiom audit found no owned declarations"
  let mut covered : Array Name := #[]
  for name in names do
    let some idx := env.getModuleIdxFor? name
      | throwError "Missing module owner for {name}"
    let owner := env.header.moduleNames[idx.toNat]!
    if !covered.contains owner then covered := covered.push owner
    let some info := env.find? name | throwError "Missing checked declaration {name}"
    let kind := match info with
      | .axiomInfo _ => "axiom"
      | .defnInfo _ => "definition"
      | .thmInfo _ => "theorem"
      | .opaqueInfo _ => "opaque"
      | .quotInfo _ => "quotient"
      | .ctorInfo _ => "constructor"
      | .recInfo _ => "recursor"
      | .inductInfo _ => "inductive"
    let axioms := (← collectAxioms name).qsort Name.lt
    for axiomName in axioms do
      unless allowed.contains axiomName do
        throwError "Unapproved axiom {axiomName} in {name}"
    let record := Json.mkObj [
      ("declaration", Json.str name.toString),
      ("module", Json.str owner.toString),
      ("kind", Json.str kind),
      ("axioms", Json.arr (axioms.map (fun n => Json.str n.toString))) ]
    liftIO <| IO.println ("AXIOM_AUDIT_DECL " ++ record.compress)
  for owner in modules do
    unless covered.contains owner do
      throwError "No declarations audited for {owner}"
  let summary := Json.mkObj [
    ("status", Json.str "PASS"),
    ("declaration_count", toJson names.size),
    ("modules", Json.arr (modules.map (fun n => Json.str n.toString))),
    ("allowed_axioms", Json.arr (allowed.map (fun n => Json.str n.toString))) ]
  liftIO <| IO.println ("AXIOM_AUDIT_SUMMARY " ++ summary.compress)
