import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace WinnerBias

/-- The probability that all independent Bernoulli trials fail. -/
noncomputable def allDown : List ℝ → ℝ
  | [] => 1
  | x :: xs => (1 - x) * allDown xs

/-- The probabilities of the mutually exclusive first-up events. -/
noncomputable def firstUp : List ℝ → List ℝ
  | [] => []
  | x :: xs => x :: (firstUp xs).map (fun p => (1 - x) * p)

/-- Sum of squares of the event probabilities. -/
noncomputable def sqSum : List ℝ → ℝ
  | [] => 0
  | p :: ps => p ^ 2 + sqSum ps

/-- Squared norm of the linear winner objective with a deterministic floor. -/
noncomputable def firstHitEnergy : List ℝ → ℝ
  | [] => 0
  | x :: xs => x * (1 - x) + (1 - x) ^ 2 * firstHitEnergy xs

theorem sqSum_map_mul (a : ℝ) (ps : List ℝ) :
    sqSum (ps.map (fun p => a * p)) = a ^ 2 * sqSum ps := by
  induction ps with
  | nil => simp [sqSum]
  | cons p ps ih =>
    simp only [List.map_cons, sqSum, ih]
    ring

theorem sum_firstUp (xs : List ℝ) : (firstUp xs).sum + allDown xs = 1 := by
  have hmul (a : ℝ) (ps : List ℝ) : (ps.map (fun p => a * p)).sum = a * ps.sum := by
    induction ps with
    | nil => simp
    | cons p ps ih => simp [ih, mul_add]
  induction xs with
  | nil => simp [firstUp, allDown]
  | cons x xs ih =>
    simp only [firstUp, allDown, List.sum_cons, hmul]
    calc
      _ = x + (1 - x) * ((firstUp xs).sum + allDown xs) := by ring
      _ = 1 := by rw [ih]; ring

/-- Energy is half the probability of two independent draws having
different first-up or all-down labels. -/
theorem firstHit_energy_identity (xs : List ℝ) :
    2 * firstHitEnergy xs + allDown xs ^ 2 + sqSum (firstUp xs) = 1 := by
  induction xs with
  | nil => norm_num [firstHitEnergy, allDown, firstUp, sqSum]
  | cons x xs ih =>
    simp only [firstHitEnergy, allDown, firstUp, sqSum, sqSum_map_mul]
    calc
      _ = 2 * x * (1 - x) + x ^ 2 + (1 - x) ^ 2 *
          (2 * firstHitEnergy xs + allDown xs ^ 2 + sqSum (firstUp xs)) := by ring
      _ = 1 := by rw [ih]; ring

private theorem sqSum_sub_const (c : ℝ) (ps : List ℝ) :
    sqSum (ps.map (fun p => p - c)) = sqSum ps - 2 * c * ps.sum + ps.length * c ^ 2 := by
  induction ps with
  | nil => simp [sqSum]
  | cons p ps ih =>
    simp only [List.map_cons, sqSum, ih, List.sum_cons, List.length_cons,
      Nat.cast_add, Nat.cast_one]
    ring

private theorem sqSum_nonneg (ps : List ℝ) : 0 ≤ sqSum ps := by
  induction ps with
  | nil => simp [sqSum]
  | cons p ps ih => exact add_nonneg (sq_nonneg p) ih

private theorem sqSum_eq_zero (ps : List ℝ) :
    sqSum ps = 0 ↔ ∀ p ∈ ps, p = 0 := by
  induction ps with
  | nil => simp [sqSum]
  | cons p ps ih =>
    have hsq := sq_nonneg p
    have htail := sqSum_nonneg ps
    constructor
    · intro h x hx
      simp only [sqSum] at h
      rcases List.mem_cons.mp hx with rfl | hx
      · exact pow_eq_zero (by linarith : x ^ 2 = 0)
      · exact ih.mp (by linarith) x hx
    · intro h
      have hp := h p (List.mem_cons_self)
      have hs := ih.mpr (fun x hx => h x (List.mem_cons_of_mem p hx))
      simp [sqSum, hp, hs]

/-- Among lists of a fixed positive length and total mass one, the
squared masses have their unique minimum at the uniform law. -/
theorem uniform_sqSum_bound_and_equality {ps : List ℝ}
    (hlen : 0 < ps.length) (hsum : ps.sum = 1) :
    1 / (ps.length : ℝ) ≤ sqSum ps ∧
      (sqSum ps = 1 / (ps.length : ℝ) ↔
        ∀ p ∈ ps, p = 1 / (ps.length : ℝ)) := by
  let c : ℝ := 1 / (ps.length : ℝ)
  have hlen' : 0 < (ps.length : ℝ) := Nat.cast_pos.mpr hlen
  have hmul : (ps.length : ℝ) * c = 1 := by
    dsimp [c]
    field_simp
  have hshift :
      sqSum (ps.map (fun p => p - c)) = sqSum ps - c := by
    rw [sqSum_sub_const, hsum]
    have hsq : (ps.length : ℝ) * c ^ 2 = c := by
      calc
        _ = ((ps.length : ℝ) * c) * c := by ring
        _ = c := by rw [hmul, one_mul]
    rw [hsq]
    ring
  constructor
  · have h := sqSum_nonneg (ps.map (fun p => p - c))
    rw [hshift] at h
    exact sub_nonneg.mp h
  · constructor
    · intro h p hp
      have hzero : sqSum (ps.map (fun p => p - c)) = 0 := by
        rw [hshift, h]
        exact sub_self c
      exact sub_eq_zero.mp ((sqSum_eq_zero _).mp hzero _ (List.mem_map_of_mem hp))
    · intro h
      have hzero : sqSum (ps.map (fun p => p - c)) = 0 := by
        apply (sqSum_eq_zero _).mpr
        intro p hp
        obtain ⟨p', hp', rfl⟩ := List.mem_map.mp hp
        exact sub_eq_zero.mpr (h p' hp')
      rw [hshift] at hzero
      exact sub_eq_zero.mp hzero


/-- When the all-down label is merged into the selected first-up label,
the true squared norm is the merged probability energy, minus the
explicit deficit for a nonempty tail. -/
theorem coalescing_deficit {F Q p S otherSquares : ℝ}
    (hS : S ≠ 0) (henergy : 2 * F + Q ^ 2 + (p ^ 2 + otherSquares) = 1) :
    F - p * S + p * S * (1 - Q / S) ^ 2 =
      (1 - ((p + Q) ^ 2 + otherSquares)) / 2 - p * Q * (1 - Q / S) := by
  have hf : F = (1 - Q ^ 2 - (p ^ 2 + otherSquares)) / 2 := by linarith
  rw [hf]
  (field_simp; ring)

theorem coalescing_deficit_pos {Q p S : ℝ}
    (hQ : 0 < Q) (hp : 0 < p) (hQS : Q < S) :
    0 < p * Q * (1 - Q / S) := by
  have hS := hQ.trans hQS
  have hratio := (div_lt_iff₀ hS).mpr (by simpa using hQS : Q < 1 * S)
  exact mul_pos (mul_pos hp hQ) (sub_pos.mpr hratio)

/-- For a nonterminal selected index the energy is strictly below the
uniform-mass upper bound. -/
theorem nonterminal_energy_strict {F Q p S : ℝ} {others : List ℝ}
    (hQ : 0 < Q) (hp : 0 < p) (hQS : Q < S)
    (hsum : ((p + Q) :: others).sum = 1)
    (henergy : 2 * F + Q ^ 2 + (p ^ 2 + sqSum others) = 1) :
    F - p * S + p * S * (1 - Q / S) ^ 2 <
      (1 - 1 / ((others.length : ℝ) + 1)) / 2 := by
  have hS := hQ.trans hQS
  rw [coalescing_deficit hS.ne' henergy]
  have hmass := (uniform_sqSum_bound_and_equality
    (ps := (p + Q) :: others) (by simp) hsum).1
  simp only [List.length_cons, Nat.cast_add, Nat.cast_one, sqSum] at hmass
  have hgap := coalescing_deficit_pos hQ hp hQS
  linarith

private theorem firstUp_length (xs : List ℝ) : (firstUp xs).length = xs.length := by
  induction xs with
  | nil => simp [firstUp]
  | cons x xs ih => simp [firstUp, ih]

/-- The floor energy is maximized exactly by uniform first-hit labels. -/
theorem floor_energy_bound_and_equality (xs : List ℝ) :
    firstHitEnergy xs ≤ (1 - 1 / ((xs.length : ℝ) + 1)) / 2 ∧
      (firstHitEnergy xs = (1 - 1 / ((xs.length : ℝ) + 1)) / 2 ↔
        allDown xs = 1 / ((xs.length : ℝ) + 1) ∧
          ∀ p ∈ firstUp xs, p = 1 / ((xs.length : ℝ) + 1)) := by
  have hsum : (allDown xs :: firstUp xs).sum = 1 := by
    simp only [List.sum_cons]
    linarith [sum_firstUp xs]
  obtain ⟨hle, heq⟩ := uniform_sqSum_bound_and_equality
    (ps := allDown xs :: firstUp xs) (by simp) hsum
  simp only [List.length_cons, firstUp_length, Nat.cast_add, Nat.cast_one, sqSum] at hle heq
  have henergy := firstHit_energy_identity xs
  refine ⟨by linarith, ?_⟩
  constructor
  · intro h
    have hall := heq.mp (by linarith)
    exact ⟨hall _ List.mem_cons_self, fun p hp => hall p (List.mem_cons_of_mem _ hp)⟩
  · rintro ⟨hdown, hup⟩
    have hall := heq.mpr (by
      intro p hp
      rcases List.mem_cons.mp hp with h | h
      · rw [h, hdown]
      · exact hup p h)
    linarith


/-- The up probabilities of the cascade for given target winning masses.
The final mass belongs to the deterministic floor. -/
noncomputable def cascade : List ℝ → List ℝ
  | [] => []
  | p :: ps => if ps.isEmpty then [] else p / (p :: ps).sum :: cascade ps

private theorem sum_pos_of_elements_pos {ps : List ℝ} (hn : ps ≠ [])
    (hp : ∀ p ∈ ps, 0 < p) : 0 < ps.sum := by
  induction ps with
  | nil => exact False.elim (hn rfl)
  | cons p ps ih =>
    have hp0 := hp p List.mem_cons_self
    have htail : 0 ≤ ps.sum := by
      by_cases he : ps = []
      · simp [he]
      · exact (ih he (fun q hq => hp q (List.mem_cons_of_mem p hq))).le
    simpa only [List.sum_cons] using add_pos_of_pos_of_nonneg hp0 htail

/-- The cascade realizes exactly the prescribed winning masses after
normalization, with the last label representing the all-down event. -/
theorem cascade_winning_masses {ps : List ℝ} (hn : ps ≠ [])
    (hp : ∀ p ∈ ps, 0 < p) :
    firstUp (cascade ps) ++ [allDown (cascade ps)] =
      ps.map (fun p => p / ps.sum) := by
  induction ps with
  | nil => exact False.elim (hn rfl)
  | cons p ps ih =>
    have hp0 := hp p List.mem_cons_self
    cases ps with
    | nil => simp [cascade, firstUp, allDown, hp0.ne']
    | cons q qs =>
      let tail := q :: qs
      have hne : tail ≠ [] := by simp [tail]
      have htail : ∀ z ∈ tail, 0 < z :=
        fun z hz => hp z (List.mem_cons_of_mem p hz)
      have htail0 := sum_pos_of_elements_pos hne htail
      have hfull : 0 < (p :: tail).sum := by
        simp only [List.sum_cons]
        linarith
      have hratio : 1 - p / (p :: tail).sum = tail.sum / (p :: tail).sum := by
        field_simp [hfull.ne']
        simp [List.sum_cons]
      change firstUp (cascade (p :: tail)) ++ [allDown (cascade (p :: tail))] =
        (p :: tail).map (fun z => z / (p :: tail).sum)
      have hcascade :
          cascade (p :: tail) = p / (p :: tail).sum :: cascade tail := by
        simp [cascade, tail]
      rw [hcascade]
      simp only [firstUp, allDown, List.cons_append, List.map_cons]
      congr 1
      rw [← List.map_singleton, ← List.map_append, ih hne htail, List.map_map]
      apply List.map_congr_left
      intro z hz
      change (1 - p / (p :: tail).sum) * (z / tail.sum) = z / (p :: tail).sum
      rw [hratio]
      field_simp [htail0.ne', hfull.ne']

/-- Each centered two-point cascade arm has variance equal to its
winning mass times the remaining mass, times the squared scale. -/
theorem cascade_arm_moments {p s c : ℝ}
    (hp : 0 < p) (hs : 0 < s) :
    p / (p + s) * (c * s) + s / (p + s) * (-c * p) = 0 ∧
      p / (p + s) * (c * s) ^ 2 + s / (p + s) * (-c * p) ^ 2 =
        c ^ 2 * p * s := by
  have hden : p + s ≠ 0 := (add_pos hp hs).ne'
  constructor
  · (field_simp; ring)
  · (field_simp; ring)


/-- Omitting a strictly positive variance term gives a strict bound for
the all-down index that is last in the ordering. -/
theorem omitted_variance_strict {expected total omitted bound : ℝ}
    (homitted : 0 < omitted) (hbound : 0 < bound)
    (hcs : expected ^ 2 ≤ (total - omitted) * bound) :
    expected ^ 2 < total * bound := by
  have hpos := mul_pos homitted hbound
  nlinarith only [hcs, hpos]

end WinnerBias

#print axioms WinnerBias.sum_firstUp
#print axioms WinnerBias.firstHit_energy_identity
#print axioms WinnerBias.uniform_sqSum_bound_and_equality
#print axioms WinnerBias.coalescing_deficit
#print axioms WinnerBias.coalescing_deficit_pos
#print axioms WinnerBias.nonterminal_energy_strict
#print axioms WinnerBias.floor_energy_bound_and_equality
#print axioms WinnerBias.cascade_winning_masses
#print axioms WinnerBias.cascade_arm_moments
#print axioms WinnerBias.omitted_variance_strict
