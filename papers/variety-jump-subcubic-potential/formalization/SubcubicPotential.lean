import SubcubicHoles
import SubcubicTau
import SubcubicCounts
import MonoDelta
import EmptyDelta
import LocalAlgebra

set_option autoImplicit false
set_option linter.unusedSectionVars false

namespace Subcubic
universe u v
variable {V : Type u} {C : Type v}
variable [Fintype V] [DecidableEq V] [Fintype C] [DecidableEq C]

/-- A graph-level insertion comparison on a base state with three empty vertices.
No potential-change or counting identity is assumed: all are derived below. -/
theorem potential_drop_of_base (G : Graph V) (q : Coloring V C) (s d o : V) (c : C)
    (hmax : MaxDegreeThree G) (hsd : s ≠ d) (hso : s ≠ o) (hdo : d ≠ o)
    (hholes : holes q = {s, d, o})
    (hbetter : utility G q c s < utility G q c d) :
    potential G (put q d c) + 2 ≤ potential G (put q s c) := by
  have hs : q s = none := (mem_holes q s).mp (by simp [hholes])
  have hd : q d = none := (mem_holes q d).mp (by simp [hholes])
  have hold := holes_triple_put_first q s d o c hholes hsd hso
  have hnew := holes_triple_put_second q s d o c hholes hsd hdo
  let ms := sameCount G q c s
  let ns := alienCount G q c s
  let rs := utility G q c s
  let md := sameCount G q c d
  let nd := alienCount G q c d
  let rd := utility G q c d
  let sd : Nat := if Adj G s d then 1 else 0
  let so : Nat := if Adj G s o then 1 else 0
  let do_ : Nat := if Adj G d o then 1 else 0
  let ps : Nat := if 0 < ms + sd then 1 else 0
  let pd : Nat := if 0 < md + sd then 1 else 0
  let alpha : Int := if c ∈ neighborColors G q o then 1 else 0
  let e : Nat := if c ∈ neighborColors G q o then 0 else 1
  have hsd1 : sd ≤ 1 := by dsimp [sd]; split <;> omega
  have hso1 : so ≤ 1 := by dsimp [so]; split <;> omega
  have hdo1 : do_ ≤ 1 := by dsimp [do_]; split <;> omega
  have hgs : degree G s = ms + ns + sd + so :=
    degree_three_holes G q c s d o hholes hdo
  have hgd : degree G d = md + nd + sd + do_ := by
    have hholes' : holes q = {d, s, o} := by
      rw [hholes, Finset.insert_comm]
    simpa only [md, nd, sd, do_, Adj, G.symmetric d s] using
      degree_three_holes G q c d s o hholes' hso
  have hrns : rs ≤ ns := utility_le_alienCount G q c s
  have hrnd : rd ≤ nd := utility_le_alienCount G q c d
  have hzero : rs = 0 ↔ ns = 0 := utility_eq_zero_iff_alienCount_eq_zero G q c s
  have hsource : (ms : Int) + ns + sd + so ≤ 3 := by
    have hh := hmax s
    omega
  have hdest : (md : Int) + nd + sd + do_ ≤ 3 := by
    have hh := hmax d
    omega
  have hlin := VarietyJump.local_potential_decrease_expanded
    (ms : Int) ns rs md nd rd sd so do_ alpha
    (by omega) (by omega) (by omega) (by omega) (by omega)
    (by omega) (by omega) (by constructor <;> intro h <;> omega)
    (by omega) (by omega) (by omega) (by omega) (by omega) (by omega)
    (by dsimp [alpha]; split <;> omega) (by dsimp [alpha]; split <;> omega)
    hsource hdest (by omega)
  have hps : (if 0 < (ms : Int) + (sd : Int) then (1 : Int) else 0) = (ps : Int) := by
    dsimp [ps]
    split <;> split <;> simp_all
    all_goals omega
  have hpd : (if 0 < (md : Int) + (sd : Int) then (1 : Int) else 0) = (pd : Int) := by
    dsimp [pd]
    split <;> split <;> simp_all
    all_goals omega
  rw [hps, hpd] at hlin
  have hts : tau G (put q d c) s = rs + ps :=
    tau_put_eq_utility G q d c hd s
  have htd : tau G (put q s c) d = rd + pd := by
    simpa only [rd, pd, md, sd, Adj, G.symmetric d s] using
      tau_put_eq_utility G q s c hs d
  have htos : tau G (put q s c) o = tau G q o + e * so := by
    simpa only [e, so, Adj, G.symmetric o s] using tau_put_stationary G q s c hs o
  have htod : tau G (put q d c) o = tau G q o + e * do_ := by
    simpa only [e, do_, Adj, G.symmetric o d] using tau_put_stationary G q d c hd o
  have hteold : TE G (put q s c) = rd + pd + (tau G q o + e * so) := by
    rw [TE_two G _ d o hdo hold, htd, htos]
  have htenew : TE G (put q d c) = rs + ps + (tau G q o + e * do_) := by
    rw [TE_two G _ s o hso hnew, hts, htod]
  have hmold : monoArcs G (put q s c) = monoArcs G q + 2 * ms :=
    monoArcs_put_nat G q s c hs
  have hmnew : monoArcs G (put q d c) = monoArcs G q + 2 * md :=
    monoArcs_put_nat G q d c hd
  have heold : emptyArcs G (put q s c) = 2 * do_ :=
    emptyArcs_two_holes G _ d o hdo hold
  have henew : emptyArcs G (put q d c) = 2 * so :=
    emptyArcs_two_holes G _ s o hso hnew
  have hdold := D_two G (put q s c) d o hdo hold
  have hdnew := D_two G (put q d c) s o hso hnew
  unfold potential
  rw [htenew, hteold, hmnew, hmold, henew, heold, hdnew, hdold, hgs, hgd]
  by_cases hc : c ∈ neighborColors G q o
  · simp only [alpha, if_pos hc, sub_self, zero_mul, add_zero] at hlin
    simp only [e, if_pos hc, zero_mul, add_zero]
    omega
  · simp only [alpha, if_neg hc, sub_zero, mul_one, one_mul] at hlin
    simp only [e, if_neg hc, one_mul]
    omega

/-- Every actual legal strict improvement with exactly two empty vertices
strictly decreases the explicit graph potential by at least two units. -/
theorem potential_drop (G : Graph V) (hmax : MaxDegreeThree G)
    (q q' : Coloring V C) (hholes : (holes q).card = 2)
    (hstep : Improves G q q') : potential G q' + 2 ≤ potential G q := by
  obtain ⟨s, d, c, hs, hd, rfl, hbetter⟩ := hstep
  have hsd : s ≠ d := by
    intro h
    subst d
    simp [hs] at hd
  obtain ⟨o, hdo, hold⟩ := two_holes_with q d hholes hd
  have hso : s ≠ o := by
    intro h
    subst o
    have hmem : s ∈ holes q := by simp [hold]
    have hh := (mem_holes q s).mp hmem
    simp [hs] at hh
  let b := erase q s
  have hb : holes b = {s, d, o} := by
    rw [show b = erase q s from rfl, holes_erase, hold]
  have hrestore : put b s c = q := put_erase_restore q s c hs
  have hbs : b s = none := erase_self q s
  have hbd : b d = none := by
    simpa only [b, erase_ne q s d (Ne.symm hsd)] using hd
  have hbetter' : utility G b c s < utility G b c d := by
    have hus := utility_put_self G b s c hbs
    rw [hrestore] at hus
    change utility G q c s < utility G (put b d c) c d at hbetter
    rw [hus, utility_put_self G b d c hbd] at hbetter
    exact hbetter
  have hh := potential_drop_of_base G b s d o c hmax hsd hso hdo hb hbetter'
  simpa only [hrestore] using hh

/-- Strict improvements preserve the number of empty vertices. -/
theorem improves_preserves_two_holes (G : Graph V) (q q' : Coloring V C)
    (hholes : (holes q).card = 2) (hstep : Improves G q q') :
    (holes q').card = 2 := by
  obtain ⟨s, d, c, hs, hd, rfl, _⟩ := hstep
  have hsd : s ≠ d := by
    intro h
    subst d
    simp [hs] at hd
  obtain ⟨o, hdo, hold⟩ := two_holes_with q d hholes hd
  have hso : s ≠ o := by
    intro h
    subst o
    have hmem : s ∈ holes q := by simp [hold]
    have hh := (mem_holes q s).mp hmem
    simp [hs] at hh
  have hb : holes (erase q s) = {s, d, o} := by rw [holes_erase, hold]
  rw [holes_triple_put_second (erase q s) s d o c hb hsd hdo]
  simp [hso]

end Subcubic
