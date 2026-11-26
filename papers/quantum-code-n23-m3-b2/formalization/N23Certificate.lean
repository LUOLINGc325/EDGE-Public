import Std
import Lean.Elab.Tactic.Omega

/-!
# Finite arithmetic layer for the n=23 M3 enumerator obstruction

Scope: a particular 32 by 35 integer system has no nonnegative integer
solution whose coordinate 13 is at most 4. The interpretation of this
system as code enumerators, and the geometric upper bound, are explicit
premises of `infeasible`; they are NOT proved in this file.

The closed certificate equalities use `decide`, not `native_decide`.
The final linear inequality uses the proof-producing `omega` tactic.
No user-declared axiom or unproved placeholder is used.
-/

set_option autoImplicit false
set_option maxRecDepth 100000
set_option maxHeartbeats 20000000

namespace N23Certificate

/-- Sum a function over the natural numbers strictly below n. -/
def sumN : Nat → (Nat → Int) → Int
  | 0, _ => 0
  | n + 1, f => sumN n f + f n

theorem sumN_congr (n : Nat) (f g : Nat → Int) :
    (∀ i, i < n → f i = g i) → sumN n f = sumN n g := by
  induction n with
  | zero =>
    intro _
    rfl
  | succ n ih =>
    intro h
    change sumN n f + f n = sumN n g + g n
    rw [ih (by intro i hi; exact h i (by omega)), h n (by omega)]

theorem sumN_zero (n : Nat) : sumN n (fun _ => 0) = 0 := by
  induction n with
  | zero => rfl
  | succ n ih => simp only [sumN, ih, Int.add_zero]

theorem sumN_add (n : Nat) (f g : Nat → Int) :
    sumN n (fun i => f i + g i) = sumN n f + sumN n g := by
  induction n with
  | zero => rfl
  | succ n ih =>
    simp only [sumN, ih]
    omega

theorem sumN_sub (n : Nat) (f g : Nat → Int) :
    sumN n (fun i => f i - g i) = sumN n f - sumN n g := by
  induction n with
  | zero => rfl
  | succ n ih =>
    simp only [sumN, ih]
    omega

theorem sumN_mul_left (n : Nat) (a : Int) (f : Nat → Int) :
    sumN n (fun i => a * f i) = a * sumN n f := by
  induction n with
  | zero => simp only [sumN, Int.mul_zero]
  | succ n ih => simp only [sumN, ih, Int.mul_add]

theorem sumN_mul_right (n : Nat) (f : Nat → Int) (a : Int) :
    sumN n (fun i => f i * a) = sumN n f * a := by
  induction n with
  | zero => simp only [sumN, Int.zero_mul]
  | succ n ih => simp only [sumN, ih, Int.add_mul]

theorem sumN_swap (m n : Nat) (f : Nat → Nat → Int) :
    sumN m (fun i => sumN n (fun j => f i j)) =
      sumN n (fun j => sumN m (fun i => f i j)) := by
  induction m with
  | zero => simp only [sumN, sumN_zero]
  | succ m ih =>
    change sumN m (fun i => sumN n (fun j => f i j)) +
        sumN n (fun j => f m j) =
      sumN n (fun j => sumN m (fun i => f i j) + f m j)
    rw [sumN_add, ih]

theorem sumN_nonneg (n : Nat) (f : Nat → Int) :
    (∀ i, i < n → 0 ≤ f i) → 0 ≤ sumN n f := by
  induction n with
  | zero =>
    intro _
    exact Int.le_refl 0
  | succ n ih =>
    intro h
    exact Int.add_nonneg
      (ih (by intro i hi; exact h i (by omega)))
      (h n (by omega))

/-- Exchange finite sums and distribute multiplication. -/
theorem combine_rows (m n : Nat) (l : Nat → Int)
    (a : Nat → Nat → Int) (x : Nat → Int) :
    sumN m (fun i => l i * sumN n (fun j => a i j * x j)) =
      sumN n (fun j => sumN m (fun i => l i * a i j) * x j) := by
  calc
    _ = sumN m (fun i => sumN n (fun j => l i * (a i j * x j))) := by
      apply sumN_congr
      intro i _
      exact (sumN_mul_left n (l i) (fun j => a i j * x j)).symm
    _ = sumN n (fun j => sumN m (fun i => l i * (a i j * x j))) :=
      sumN_swap m n (fun i j => l i * (a i j * x j))
    _ = sumN n (fun j => sumN m (fun i => (l i * a i j) * x j)) := by
      apply sumN_congr
      intro j _
      apply sumN_congr
      intro i _
      exact (Int.mul_assoc (l i) (a i j) (x j)).symm
    _ = _ := by
      apply sumN_congr
      intro j _
      exact sumN_mul_right m (fun i => l i * a i j) (x j)

-- Source JSON SHA-256: 88fdedbe69d26edd37149636b616d86ba6d5902c145093fe74008f23556166f0
-- Variable order (zero-based):
-- 0: ['x', 0, 6]
-- 1: ['x', 0, 8]
-- 2: ['x', 0, 10]
-- 3: ['x', 0, 12]
-- 4: ['x', 0, 14]
-- 5: ['x', 0, 16]
-- 6: ['x', 1, 4]
-- 7: ['x', 1, 6]
-- 8: ['x', 1, 8]
-- 9: ['x', 1, 10]
-- 10: ['x', 1, 12]
-- 11: ['x', 1, 14]
-- 12: ['x', 1, 16]
-- 13: ['x', 2, 2]
-- 14: ['x', 2, 4]
-- 15: ['x', 2, 6]
-- 16: ['x', 2, 8]
-- 17: ['x', 2, 10]
-- 18: ['x', 2, 12]
-- 19: ['x', 2, 14]
-- 20: ['x', 2, 16]
-- 21: ['x', 3, 3]
-- 22: ['x', 3, 5]
-- 23: ['x', 3, 7]
-- 24: ['x', 3, 9]
-- 25: ['x', 3, 11]
-- 26: ['x', 3, 13]
-- 27: ['x', 3, 15]
-- 28: ['x', 3, 17]
-- 29: ['q', 7]
-- 30: ['q', 9]
-- 31: ['q', 11]
-- 32: ['q', 13]
-- 33: ['q', 15]
-- 34: ['q', 17]

def matrixData : List (List Int) := [
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], -- A_2
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], -- A_4
  [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], -- A_6
  [0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], -- A_8
  [0, 0, 1, 0, 0, 0, 2, 1, 1, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], -- A_10
  [3, 0, 0, 1, 0, 0, 0, 2, 1, 1, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], -- A_12
  [0, 3, 0, 0, 1, 0, 0, 0, 2, 1, 1, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0], -- A_14
  [0, 0, 3, 0, 0, 1, 0, 0, 0, 2, 1, 1, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0], -- A_16
  [0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 2, 1, 1, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 3, 1, 0, 0, 0, 0, 0, 0, 0], -- A_18
  [0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 3, 1, 0, 0, 0, 0, 0, 0], -- A_20
  [0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0], -- A_22
  [1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], -- type_0_total
  [0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], -- type_1_total
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], -- type_2_total
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0], -- type_3_total
  [-27, -19, -11, -3, 5, 13, -35, -27, -19, -11, -3, 5, 13, -43, -35, -27, -19, -11, -3, 5, 13, -39, -31, -23, -15, -7, 1, 9, 17, 0, 0, 0, 0, 0, 0], -- R_dual_1
  [-312, -136, -24, 24, 8, -72, -552, -312, -136, -24, 24, 8, -72, -856, -552, -312, -136, -24, 24, 8, -72, -696, -424, -216, -72, 8, 24, -24, -136, 0, 0, 0, 0, 0, 0], -- R_dual_2
  [-1960, -376, 120, 40, -104, 200, -5144, -1960, -376, 120, 40, -104, 200, -10440, -5144, -1960, -376, 120, 40, -104, 200, -7496, -3320, -1000, -24, 120, -56, -40, 680, 0, 0, 0, 0, 0, 0], -- R_dual_3
  [-6780, 308, 420, -300, 196, -140, -31084, -6780, 308, 420, -300, 196, -140, -86940, -31084, -6780, 308, 420, -300, 196, -140, -54012, -15980, -1820, 756, -60, -172, 420, -2380, 0, 0, 0, 0, 0, 0], -- R_dual_4
  [-9300, 3836, -756, -36, 364, -1092, -124644, -9300, 3836, -756, -36, 364, -1092, -520884, -124644, -9300, 3836, -756, -36, 364, -1092, -271908, -45620, 2940, 1260, -996, 780, -1092, 6188, 0, 0, 0, 0, 0, 0], -- R_dual_5
  [1066296, 3752, -2856, 1992, -2184, 5096, -317304, 17720, 3752, -2856, 1992, -2184, 5096, -2299752, -317304, 17720, 3752, -2856, 1992, -2184, 5096, -963144, -55800, 18200, -3864, 888, -312, 728, -12376, 0, 0, 0, 0, 0, 0], -- R_dual_6
  [85800, -15976, 4296, -2376, 3432, -12584, -401544, 85800, -15976, 4296, -2376, 3432, -12584, -7505784, -401544, 85800, -15976, 4296, -2376, 3432, -12584, -2316600, 83160, 13480, -8136, 4488, -3432, 3432, 19448, 1048576, 0, 0, 0, 0, 0], -- R_dual_7
  [66330, 1023114, 10170, -4950, 858, 21450, 254826, 66330, -25462, 10170, -4950, 858, 21450, -17721990, 254826, 66330, -25462, 10170, -4950, 858, 21450, -3266406, 406890, -59910, 14922, -7590, 7722, -12870, -24310, 0, 0, 0, 0, 0, 0], -- R_dual_8
  [-204930, 44766, -19970, 15070, -13442, -27170, 1876446, -204930, 44766, -19970, 15070, -13442, -27170, -28146690, 1876446, -204930, 44766, -19970, 15070, -13442, -27170, -625482, 400950, -91530, 25462, -7370, -3146, 24310, 24310, 0, 1048576, 0, 0, 0, 0], -- R_dual_9
  [-363528, 73224, 1035096, -9240, 28600, 26312, 2501928, -363528, 73224, -13480, -9240, 28600, 26312, -22517352, 2501928, -363528, 73224, -13480, -9240, 28600, 26312, 7505784, -577368, 115992, -47928, 28600, -14872, -30888, -19448, 0, 0, 0, 0, 0, 0], -- R_dual_10
  [215784, -104328, 54600, -18600, -35672, -19656, -682344, 215784, -104328, 54600, -18600, -35672, -19656, 14329224, -682344, 215784, -104328, 54600, -18600, -35672, -19656, 14329224, -1452168, 231336, -33768, -17720, 35256, 28392, 12376, 0, 0, 1048576, 0, 0, 0], -- R_dual_11
  [726084, -102060, -26460, 1094196, 30212, 11284, -5117580, 726084, -102060, -26460, 45620, 30212, 11284, 64481508, -5117580, 726084, -102060, -26460, 45620, 30212, 11284, 7164612, -78732, -183708, 103572, -27900, -41548, -19292, -6188, 0, 0, 0, 0, 0, 0], -- R_dual_12
  [-131220, 183708, -49140, -47940, -18004, -4900, -3385476, -131220, 183708, -49140, -47940, -18004, -4900, 74401740, -3385476, -131220, 183708, -49140, -47940, -18004, -4900, -11573604, 1968300, -306180, -24948, 61020, 31084, 9660, 2380, 0, 0, 0, 1048576, 0, 0], -- R_dual_13
  [-787320, 17496, 81000, 29880, 1056072, 1560, 3306744, -787320, 17496, 81000, 29880, 7496, 1560, 21257640, 3306744, -787320, 17496, 81000, 29880, 7496, 1560, -18423288, 787320, 262440, -91368, -52920, -15432, -3480, -680, 0, 0, 0, 0, 0, 0], -- R_dual_14
  [157464, -157464, -52488, -11448, -2088, -344, 4251528, 157464, -157464, -52488, -11448, -2088, -344, -38263752, 4251528, 157464, -157464, -52488, -11448, -2088, -344, -4251528, -1417176, 157464, 99144, 25272, 4968, 856, 136, 0, 0, 0, 0, 1048576, 0], -- R_dual_15
  [413343, 98415, 16767, 2511, 351, 1048623, -531441, 413343, 98415, 16767, 2511, 351, 47, -43046721, -531441, 413343, 98415, 16767, 2511, 351, 47, 7971615, -531441, -216513, -41553, -6561, -945, -129, -17, 0, 0, 0, 0, 0, 0], -- R_dual_16
  [-177147, -19683, -2187, -243, -27, -3, -1594323, -177147, -19683, -2187, -243, -27, -3, -14348907, -1594323, -177147, -19683, -2187, -243, -27, -3, 4782969, 531441, 59049, 6561, 729, 81, 9, 1, 0, 0, 0, 0, 0, 1048576] -- R_dual_17
]

def rhsData : List Int := [0, 0, 29, 438, 116, 35760, 144960, 427623, 514476, 246024, 28674, 1365, 61440, 122880, 163840, 17, 408, 6120, 64260, 501228, 3007368, 14177592, 53165970, 159497910, 382794984, 730790424, 1096185636, 1264829580, 1084139640, 650483784, 243931419, 43046721]
def multiplierData : List Int := [0, 0, -431289105217, 245979135951, -342176944369, 4228502143, 2237573663, 1112061423, 851965423, 1457285663, 2928022143, -99690634384, -10504369200, -9638952960, 0, 0, 0, -18731648, -4474665, -238208, 400590, 0, -140874, -187648, 1331, 0, 81145, 0, 83404, 0, 0, 0]
def slackData : List Int := [0, 0, 435321569280, 2368733184, 0, 87455432704, 1266289737728, 0, 349261791232, 0, 0, 0, 0, 0, 0, 933696110592, 0, 0, 0, 0, 0, 0, 732392587264, 263274364928, 0, 0, 0, 0, 0, 0, 196763189248, 0, 0, 0, 0]
def denominator : Int := 13483471011840
def constant : Int := 64697371983872

def matrix (i j : Nat) : Int := (matrixData.getD i []).getD j 0
def rhs (i : Nat) : Int := rhsData.getD i 0
def multiplier (i : Nat) : Int := multiplierData.getD i 0
def slack (j : Nat) : Int := slackData.getD j 0
def objective (j : Nat) : Int := if j = 13 then denominator else 0

/-- Each of the 35 coefficients is checked by kernel reduction. -/
theorem coefficient_identity :
    ∀ j : Fin 35,
      sumN 32 (fun i => multiplier i * matrix i j.val) =
        objective j.val - slack j.val := by
  decide

/-- The constant term is checked independently by kernel reduction. -/
theorem constant_identity :
    sumN 32 (fun i => multiplier i * rhs i) = constant := by
  decide

theorem slack_nonnegative : ∀ j : Fin 35, 0 ≤ slack j.val := by
  decide

theorem gap_positive : 4 * denominator < constant := by
  decide

/-- The exact row equations are a premise, not an encoded coding-theory theorem. -/
def RowEquations (x : Nat → Int) : Prop :=
  ∀ i, i < 32 → sumN 35 (fun j => matrix i j * x j) = rhs i

def Nonnegative (x : Nat → Int) : Prop :=
  ∀ j, j < 35 → 0 ≤ x j

/-- Derive the Farkas identity from the 32 supplied row equations. -/
theorem certificate_identity (x : Nat → Int) (hrows : RowEquations x) :
    denominator * x 13 = constant + sumN 35 (fun j => slack j * x j) := by
  have hcomb :
      constant = sumN 35 (fun j => (objective j - slack j) * x j) := by
    calc
      constant = sumN 32 (fun i => multiplier i * rhs i) :=
        constant_identity.symm
      _ = sumN 32 (fun i => multiplier i *
          sumN 35 (fun j => matrix i j * x j)) := by
        apply sumN_congr
        intro i hi
        rw [hrows i hi]
      _ = sumN 35 (fun j =>
          sumN 32 (fun i => multiplier i * matrix i j) * x j) :=
        combine_rows 32 35 multiplier matrix x
      _ = _ := by
        apply sumN_congr
        intro j hj
        rw [coefficient_identity ⟨j, hj⟩]
  have hsplit :
      sumN 35 (fun j => (objective j - slack j) * x j) =
        sumN 35 (fun j => objective j * x j) -
          sumN 35 (fun j => slack j * x j) := by
    calc
      _ = sumN 35 (fun j => objective j * x j - slack j * x j) := by
        apply sumN_congr
        intro j _
        exact Int.sub_mul (objective j) (slack j) (x j)
      _ = _ := sumN_sub 35 (fun j => objective j * x j)
        (fun j => slack j * x j)
  have hobj : sumN 35 (fun j => objective j * x j) = denominator * x 13 := by
    simp [sumN, objective]
  rw [hsplit, hobj] at hcomb
  omega

/--
Finite infeasibility theorem.

Explicit external premises:
* `hrows`: a code would supply the 32 prescribed linear equations;
* `hnonnegative`: its 35 counts would be nonnegative integers;
* `hupper`: its weight-two projective-class count would be at most four.

No statement here claims that these premises follow from a GF(4) code.
-/
theorem infeasible (x : Nat → Int)
    (hrows : RowEquations x)
    (hnonnegative : Nonnegative x)
    (hupper : x 13 ≤ 4) : False := by
  have hid := certificate_identity x hrows
  have hslack : 0 ≤ sumN 35 (fun j => slack j * x j) := by
    apply sumN_nonneg
    intro j hj
    exact Int.mul_nonneg (slack_nonnegative ⟨j, hj⟩) (hnonnegative j hj)
  unfold denominator constant at hid
  omega

end N23Certificate

-- The compiler prints the actual axiom dependencies; preserve its output.
#print axioms N23Certificate.coefficient_identity
#print axioms N23Certificate.constant_identity
#print axioms N23Certificate.certificate_identity
#print axioms N23Certificate.infeasible
