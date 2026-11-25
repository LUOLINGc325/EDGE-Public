import PairCapitalModel
import Mathlib.Algebra.BigOperators.Ring.Finset

open Finset MeasureTheory
open scoped BigOperators

namespace IndependentMerging

abbrev PairCoord (n : ℕ) := Fin n × Bool
abbrev PairInput (n : ℕ) := PairCoord n → ℝ

/-- A branch can use its complete preceding history. Its next continuation can
observe the chosen value, and the index prevents reading a coordinate twice. -/
inductive ReadTree (n : ℕ) : Finset (PairCoord n) → Type
  | done : ReadTree n ∅
  | bet {R : Finset (PairCoord n)} (c : PairCoord n) (hc : c ∈ R)
      (stake : Set.Icc (0 : ℝ) 1) (next : ℝ → ReadTree n (R.erase c)) : ReadTree n R

noncomputable def betFactor (stake : Set.Icc (0 : ℝ) 1) (x : ℝ) : ℝ :=
  1 + stake.val * (x - 1)

namespace ReadTree

variable {n : ℕ}

noncomputable def unitPayoff {R : Finset (PairCoord n)} (T : ReadTree n R)
    (x : PairInput n) : ℝ :=
  T.rec 1 (fun c _ s _ continuation => betFactor s (x c) * continuation (x c))

@[simp] theorem unitPayoff_done (x : PairInput n) : unitPayoff (done (n := n)) x = 1 := rfl

@[simp] theorem unitPayoff_bet {R : Finset (PairCoord n)} (c : PairCoord n) (hc : c ∈ R)
    (s : Set.Icc (0 : ℝ) 1) (next : ℝ → ReadTree n (R.erase c)) (x : PairInput n) :
    unitPayoff (bet c hc s next) x = betFactor s (x c) * unitPayoff (next (x c)) x := rfl

theorem factor_nonnegative (s : Set.Icc (0 : ℝ) 1) {x : ℝ} (hx : 0 ≤ x) :
    0 ≤ betFactor s x := by
  have h := add_nonneg (sub_nonneg.mpr s.property.2) (mul_nonneg s.property.1 hx)
  convert h using 1
  unfold betFactor
  ring

theorem factor_le_top (s : Set.Icc (0 : ℝ) 1) {x t : ℝ} (ht : 1 ≤ t) (hxt : x ≤ t) :
    betFactor s x ≤ t := by
  unfold betFactor
  calc
    _ ≤ 1 + s.val * (t - 1) :=
      add_le_add_left (mul_le_mul_of_nonneg_left (sub_le_sub_right hxt 1) s.property.1) _
    _ ≤ 1 + 1 * (t - 1) :=
      add_le_add_left (mul_le_mul_of_nonneg_right s.property.2 (sub_nonneg.mpr ht)) _
    _ = _ := by ring

theorem factor_le_max (s : Set.Icc (0 : ℝ) 1) (x : ℝ) : betFactor s x ≤ max 1 x :=
  factor_le_top s (le_max_left _ _) (le_max_right _ _)

theorem unitPayoff_box {R : Finset (PairCoord n)} (T : ReadTree n R) (x : PairInput n)
    {t : ℝ} (ht : 1 ≤ t) (hx : ∀ c, 0 ≤ x c ∧ x c ≤ t) :
    0 ≤ T.unitPayoff x ∧ T.unitPayoff x ≤ t ^ R.card := by
  induction T with
  | done => simp
  | @bet R c hc s next ih =>
    have hlow := factor_nonnegative s (hx c).1
    have htop := factor_le_top s ht (hx c).2
    have ht0 : 0 ≤ t := by linarith
    have hnext := ih (x c)
    rw [unitPayoff_bet]
    refine ⟨mul_nonneg hlow hnext.1, ?_⟩
    calc
      _ ≤ t * t ^ (R.erase c).card := mul_le_mul htop hnext.2 hnext.1 ht0
      _ = _ := by rw [← Finset.card_erase_add_one hc, pow_succ, mul_comm]

/-- Explicit zero-stake completion when a policy stops before all reads. -/
noncomputable def zeroTree (R : Finset (PairCoord n)) : ReadTree n R := by
  classical
  by_cases h : R.Nonempty
  · exact bet h.choose h.choose_spec ⟨0, by norm_num⟩ (fun _ => zeroTree (R.erase h.choose))
  · have he := Finset.not_nonempty_iff_eq_empty.mp h
    subst R
    exact done
termination_by R.card
decreasing_by exact Finset.card_erase_lt_of_mem h.choose_spec

theorem zeroTree_value (R : Finset (PairCoord n)) (x : PairInput n) :
    (zeroTree R).unitPayoff x = 1 := by
  classical
  refine Finset.strongInductionOn R ?_
  intro S ih
  rw [zeroTree]
  split
  · rename_i h
    simp [betFactor, ih (S.erase h.choose) (Finset.erase_ssubset h.choose_spec)]
  · rename_i h
    have he := Finset.not_nonempty_iff_eq_empty.mp h
    subst S
    rfl

end ReadTree

abbrev RevealHistory (n : ℕ) := List (PairCoord n × ℝ)

/-- A policy describes choices at every history. Histories and remaining
coordinates are passed together to its action rule. -/
structure ReadPolicy (n : ℕ) where
  choice : (R : Finset (PairCoord n)) → R.Nonempty →
    RevealHistory n → {c : PairCoord n // c ∈ R}
  stake : RevealHistory n → PairCoord n → Set.Icc (0 : ℝ) 1

noncomputable def ReadPolicy.tree {n : ℕ} (P : ReadPolicy n) (R : Finset (PairCoord n))
    (history : RevealHistory n) : ReadTree n R := by
  classical
  by_cases h : R.Nonempty
  · let c := P.choice R h history
    exact ReadTree.bet c.val c.property (P.stake history c.val)
      (fun x => P.tree (R.erase c.val) (history ++ [(c.val, x)]))
  · have he := Finset.not_nonempty_iff_eq_empty.mp h
    subst R
    exact ReadTree.done
termination_by R.card
decreasing_by exact Finset.card_erase_lt_of_mem c.property

/-- The same probability seed chooses the full adaptive strategy and its
initial capital. At each fixed input the seed payoff is measurable. -/
structure TreeMixture {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) (n : ℕ) where
  capital : Ω → ℝ
  tree : Ω → ReadTree n Finset.univ
  capital_integrable : Integrable capital μ
  capital_nonnegative : ∀ᵐ ω ∂μ, 0 ≤ capital ω
  payoff_measurable : ∀ x, AEStronglyMeasurable (fun ω => (tree ω).unitPayoff x) μ

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} {n : ℕ}

noncomputable def TreeMixture.mean (G : TreeMixture μ n) : ℝ := ∫ ω, G.capital ω ∂μ

noncomputable def TreeMixture.payoff (G : TreeMixture μ n) (x : PairInput n) : ℝ :=
  ∫ ω, G.capital ω * (G.tree ω).unitPayoff x ∂μ

theorem TreeMixture.payoff_integrable (G : TreeMixture μ n) (x : PairInput n)
    {t : ℝ} (ht : 1 ≤ t) (hx : ∀ c, 0 ≤ x c ∧ x c ≤ t) :
    Integrable (fun ω => G.capital ω * (G.tree ω).unitPayoff x) μ := by
  let M := t ^ (Finset.univ : Finset (PairCoord n)).card
  apply (G.capital_integrable.const_mul M).mono'
    (G.capital_integrable.aestronglyMeasurable.mul (G.payoff_measurable x))
  filter_upwards [G.capital_nonnegative] with ω hc
  obtain ⟨h₁, h₂⟩ := (G.tree ω).unitPayoff_box x ht hx
  change ‖G.capital ω * (G.tree ω).unitPayoff x‖ ≤ M * G.capital ω
  rw [Real.norm_eq_abs, abs_of_nonneg (mul_nonneg hc h₁), mul_comm M]
  exact mul_le_mul_of_nonneg_left h₂ hc

end IndependentMerging
