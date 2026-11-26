import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum

namespace ToroidalArithmetic

open scoped BigOperators

def rawPopulation (i j : Fin 4) : ℚ :=
  if i.val = 3 ∧ j.val = 3 then 2189 / 2100
  else if i.val = 3 ∨ j.val = 3 then 49 / 50
  else if i.val = j.val then 1
  else if j.val = (i.val + 1) % 3 then 21 / 20
  else 20 / 21

def composedRatio (i j : Fin 4) : ℚ :=
  (∑ k : Fin 4, rawPopulation i k * rawPopulation k j) /
    (rawPopulation i i * rawPopulation j j)

theorem populationRowTotal (i : Fin 4) :
    (∑ j : Fin 4, rawPopulation i j) = 8363 / 2100 := by
  fin_cases i <;> norm_num [rawPopulation, Fin.sum_univ_succ, Fin.val_succ]

theorem populationColumnTotal (j : Fin 4) :
    (∑ i : Fin 4, rawPopulation i j) = 8363 / 2100 := by
  fin_cases j <;> norm_num [rawPopulation, Fin.sum_univ_succ, Fin.val_succ]

theorem exactMinimum (i j : Fin 4) :
    (17497813 / 4791721 : ℚ) ≤ composedRatio i j := by
  fin_cases i <;> fin_cases j <;>
    norm_num [composedRatio, rawPopulation, Fin.sum_univ_succ, Fin.val_succ]

theorem attainedMinimum : composedRatio 3 3 = 17497813 / 4791721 := by
  norm_num [composedRatio, rawPopulation, Fin.sum_univ_succ, Fin.val_succ]

theorem strictSeparation :
    (7 / 2 : ℚ) < composedRatio 3 3 ∧ composedRatio 3 3 < 4 := by
  rw [attainedMinimum]
  constructor <;> norm_num

/-- Raw population matrix of the two-parameter family at u = 6/5. -/
def familyPopulation (i j : Fin 4) : ℚ :=
  if i.val = 0 ∧ j.val = 1 then 6/5
  else if i.val = 1 ∧ j.val = 0 then 5/6
  else 1

def familyColumn (j : Fin 4) : ℚ := ∑ i : Fin 4, familyPopulation i j

def familyScaled (i j : Fin 4) : ℚ :=
  familyColumn i * ∑ k : Fin 4,
    familyPopulation i k * familyPopulation k j / familyColumn k

theorem familyExactMinimum (i j : Fin 4) :
    (965/252 : ℚ) ≤ familyScaled i j := by
  fin_cases i <;> fin_cases j <;>
    norm_num [familyScaled, familyColumn, familyPopulation, Fin.sum_univ_succ, Fin.val_succ]

theorem familyAttainedMinimum : familyScaled 0 0 = 965/252 := by
  norm_num [familyScaled, familyColumn, familyPopulation, Fin.sum_univ_succ, Fin.val_succ]

end ToroidalArithmetic

#print axioms ToroidalArithmetic.populationRowTotal
#print axioms ToroidalArithmetic.populationColumnTotal
#print axioms ToroidalArithmetic.exactMinimum
#print axioms ToroidalArithmetic.attainedMinimum
#print axioms ToroidalArithmetic.strictSeparation
#print axioms ToroidalArithmetic.familyExactMinimum
#print axioms ToroidalArithmetic.familyAttainedMinimum
