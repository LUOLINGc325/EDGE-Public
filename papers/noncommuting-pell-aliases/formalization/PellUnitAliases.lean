import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Lean.Elab.Tactic.Omega

namespace NoncommutingPellAliases

/-!
Scope note: the full manuscript (noncommuting-pell-aliases) builds a family of positive
symmetric generators on a 16-state cubic graph whose extra stationary parameters are the
solutions of the negative Pell equation ℓ² - 2k² = -1.  A necessary algebraic sublemma is
that the negative Pell equation has infinitely many solutions indexed by the Pell numbers,
and that consecutive solutions (ℓ, k) are related by (1 + √2)ⁿ.  We formalize the exact
algebraic heart: the standard Pell-unit identity underlying the candidate parameter family.

Lemma `pell_unit_identity` (corresponds to the generation step of candidates in the
negative Pell family; cf. Pell/uniqueness arguments in the manuscript's supplementary
section):  if ℓ² - 2k² = -1, then the transformed pair
(ℓ', k') := (3ℓ + 4k, 2ℓ + 3k) also satisfies ℓ'² - 2k'² = -1.  This is the explicit
"unitary" map (1+√2)² = 3 + 2√2 acting on the solutions, and it is the algebraic form of
the procedure generating new Markov aliases from a known one.  We do not claim here the
classification/infinite-count statements or any Markov-generator facts; only this exact
algebraic preservation lemma.
-/

/-- Generator step for the negative Pell equation: if `(l, k)` solves `l^2 - 2 k^2 = -1`,
then so does `(3 l + 4 k, 2 l + 3 k)`.  This is multiplication by the unit
`(1 + √2)^2 = 3 + 2√2` written without irrationals. -/
theorem pell_unit_identity (l k : ℤ) (h : l ^ 2 - 2 * k ^ 2 = -1) :
    (3 * l + 4 * k) ^ 2 - 2 * (2 * l + 3 * k) ^ 2 = -1 := by
  have key : (3 * l + 4 * k) ^ 2 - 2 * (2 * l + 3 * k) ^ 2
      = l ^ 2 - 2 * k ^ 2 := by ring
  rw [key, h]

/-- The starting solution `(1, 1)` of the negative Pell equation, corresponding to the
trivial generator step in the candidate family. -/
theorem pell_seed : (1 : ℤ) ^ 2 - 2 * (1 : ℤ) ^ 2 = -1 := by norm_num

/-- Two steps from the seed: `(1,1) ↦ (7,5) ↦ (41,29)`, giving explicit new members of
the family `ℓ² - 2k² = -1`.  These are the first nontrivial aliases beyond the seed. -/
theorem pell_iterate_two :
    (41 : ℤ) ^ 2 - 2 * (29 : ℤ) ^ 2 = -1 := by norm_num

end NoncommutingPellAliases
