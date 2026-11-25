import Admissibility
import GeneralSeparation
import Mathlib.MeasureTheory.MeasurableSpace.Instances

open MeasureTheory

namespace IndependentMerging

/-- A probability seed may choose the initial allocation, reading order and
both stakes jointly. The second stake sees only the first observed value. -/
structure PairMixture {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) where
  capital : Ω → ℝ
  reversed : Ω → Bool
  first : Ω → ℝ
  second : Ω → ℝ → ℝ
  capital_integrable : Integrable capital μ
  capital_nonnegative : ∀ᵐ ω ∂μ, 0 ≤ capital ω
  first_bounds : ∀ᵐ ω ∂μ, 0 ≤ first ω ∧ first ω ≤ 1
  second_bounds : ∀ z, ∀ᵐ ω ∂μ, 0 ≤ second ω z ∧ second ω z ≤ 1
  payoff_measurable : ∀ x y, AEStronglyMeasurable
    (fun ω => orderedStrategy (reversed ω) (first ω) (second ω) x y) μ

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

noncomputable def PairMixture.mean (G : PairMixture μ) : ℝ := ∫ ω, G.capital ω ∂μ

noncomputable def PairMixture.payoff (G : PairMixture μ) : ℝ → ℝ → ℝ :=
  allocatedPayoff μ G.capital G.reversed G.first G.second

def DominatesOnQuadrant (G F : ℝ → ℝ → ℝ) : Prop :=
  ∀ x y : ℝ, 0 ≤ x → 0 ≤ y → F x y ≤ G x y

theorem PairMixture.mean_nonnegative (G : PairMixture μ) : 0 ≤ G.mean :=
  integral_nonneg_of_ae G.capital_nonnegative

theorem PairMixture.payoff_integrable (G : PairMixture μ) {t x y : ℝ} (ht : 1 ≤ t)
    (hx : 0 ≤ x ∧ x ≤ t) (hy : 0 ≤ y ∧ y ≤ t) :
    Integrable (fun ω => G.capital ω * orderedStrategy (G.reversed ω) (G.first ω)
      (G.second ω) x y) μ :=
  allocated_strategy_integrable μ G.capital G.reversed G.first G.second ht
    G.capital_integrable G.capital_nonnegative G.first_bounds (G.second_bounds x)
    (G.second_bounds y) (G.payoff_measurable x y) hx hy

theorem PairMixture.no_gain_on_unit_box (G : PairMixture μ) {x y : ℝ}
    (hx : 0 ≤ x ∧ x ≤ 1) (hy : 0 ≤ y ∧ y ≤ 1) :
    G.payoff x y ≤ G.mean := by
  apply integral_mono_ae (G.payoff_integrable le_rfl hx hy) G.capital_integrable
  filter_upwards [G.capital_nonnegative, G.first_bounds, G.second_bounds x,
    G.second_bounds y] with ω hc ha hbx hby
  have h := (ordered_strategy_box_bound (G.reversed ω) (G.first ω) (G.second ω)
    le_rfl ha hbx hby hx hy).2
  calc
    _ ≤ G.capital ω * (1 * 1) := mul_le_mul_of_nonneg_left h hc
    _ = _ := by ring

theorem PairMixture.three_point_bound [IsProbabilityMeasure μ] (G : PairMixture μ)
    {t : ℝ} (ht : 1 ≤ t) :
    G.payoff t t + t * (t - 1) * G.payoff 0 1 + t * (t - 1) * G.payoff 1 0 ≤
      t * (2 * t - 1) * G.mean :=
  allocated_three_point_bound μ G.capital G.reversed G.first G.second ht
    G.capital_integrable G.capital_nonnegative G.first_bounds G.second_bounds G.payoff_measurable

/-- The fair coin chooses the reading order in the attaining strategies. -/
noncomputable def fairOrderLaw : Measure Bool :=
  ENNReal.ofReal (1 / 2 : ℝ) • Measure.dirac false +
  ENNReal.ofReal (1 / 2 : ℝ) • Measure.dirac true

theorem fairOrderLaw_probability : IsProbabilityMeasure fairOrderLaw := by
  constructor
  simp only [fairOrderLaw, Measure.add_apply, Measure.smul_apply, Measure.dirac_apply_of_mem
    (Set.mem_univ _), smul_eq_mul, mul_one]
  rw [← ENNReal.ofReal_add (by norm_num : 0 ≤ (1 / 2 : ℝ)) (by norm_num : 0 ≤ (1 / 2 : ℝ))]
  norm_num

theorem fairOrderLaw_integrable (f : Bool → ℝ) : Integrable f fairOrderLaw :=
  (integrable_dirac.smul_measure ENNReal.ofReal_ne_top).add_measure
    (integrable_dirac.smul_measure ENNReal.ofReal_ne_top)

theorem fairOrderLaw_integral (f : Bool → ℝ) :
    (∫ b, f b ∂fairOrderLaw) = (f false + f true) / 2 := by
  unfold fairOrderLaw
  rw [integral_add_measure
    (integrable_dirac.smul_measure ENNReal.ofReal_ne_top)
    (integrable_dirac.smul_measure ENNReal.ofReal_ne_top)]
  simp only [integral_smul_measure, ENNReal.toReal_ofReal (by norm_num : 0 ≤ (1 / 2 : ℝ)),
    smul_eq_mul, integral_dirac]
  ring

noncomputable def fairTwoOrders (m a : ℝ) (b : ℝ → ℝ) (hm : 0 ≤ m)
    (ha : 0 ≤ a ∧ a ≤ 1) (hb : ∀ z, 0 ≤ b z ∧ b z ≤ 1) : PairMixture fairOrderLaw where
  capital := fun _ => m
  reversed := id
  first := fun _ => a
  second := fun _ => b
  capital_integrable := fairOrderLaw_integrable _
  capital_nonnegative := Filter.Eventually.of_forall fun _ => hm
  first_bounds := Filter.Eventually.of_forall fun _ => ha
  second_bounds z := Filter.Eventually.of_forall fun _ => hb z
  payoff_measurable _ _ := (fairOrderLaw_integrable _).aestronglyMeasurable

theorem fairTwoOrders_mean (m a : ℝ) (b : ℝ → ℝ) (hm : 0 ≤ m) (ha) (hb) :
    (fairTwoOrders m a b hm ha hb).mean = m := by
  unfold PairMixture.mean
  rw [fairOrderLaw_integral]
  change (m + m) / 2 = m
  ring

theorem fairTwoOrders_payoff (m a : ℝ) (b : ℝ → ℝ) (hm : 0 ≤ m) (ha) (hb)
    (x y : ℝ) :
    (fairTwoOrders m a b hm ha hb).payoff x y =
      m * ((orderedStrategy false a b x y + orderedStrategy true a b x y) / 2) := by
  unfold PairMixture.payoff allocatedPayoff
  rw [fairOrderLaw_integral]
  change (m * orderedStrategy false a b x y + m * orderedStrategy true a b x y) / 2 = _
  ring

end IndependentMerging
