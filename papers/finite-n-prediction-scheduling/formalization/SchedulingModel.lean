import UnitRecurrence
import Mathlib.Data.Finset.Max

/-! Cumulative-service semantics for the deterministic preemptive single-machine model. -/

open scoped BigOperators

namespace FiniteFrontier

variable {ι : Type*} [Fintype ι]

/-- A finite run of one machine. The capacity inequality bounds every time increment.
Individual attained-service functions are monotone and automatically 1-Lipschitz
on nonnegative time, so this representation also allows arbitrary preemption and idle time. -/
structure Run (x : ι → ℝ) where
  service : ℝ → ι → ℝ
  completion : ι → ℝ
  service_zero : ∀ i, service 0 i = 0
  service_mono : ∀ i u t, 0 ≤ u → u ≤ t → service u i ≤ service t i
  capacity : ∀ u t, 0 ≤ u → u ≤ t →
    (∑ i, service t i) - (∑ i, service u i) ≤ t - u
  service_le_size : ∀ i t, 0 ≤ t → service t i ≤ x i
  completion_pos : ∀ i, 0 < completion i
  complete_iff : ∀ i t, 0 ≤ t → (service t i = x i ↔ completion i ≤ t)

abbrev PositiveSizes (ι : Type*) := {x : ι → ℝ // ∀ i, 0 < x i}

/-- A deterministic policy takes predictions and receives completion events. An alternative
instance gives the same observed history through time t if it keeps all sizes revealed
by then and lets every other job remain unfinished along the original service prefix. -/
structure Policy (ι : Type*) [Fintype ι] where
  run : (prediction actual : PositiveSizes ι) → Run actual.val
  prefix_agrees : ∀ y x z t, 0 ≤ t →
    (∀ i, if (run y x).completion i ≤ t then z.val i = x.val i
      else (run y x).service t i < z.val i) →
    ∀ u, 0 ≤ u → u ≤ t → (run y z).service u = (run y x).service u

namespace Run

variable {x : ι → ℝ} (r : Run x)

noncomputable def cost : ℝ := ∑ i, r.completion i

/-- Integral of the number of unfinished jobs up to a nonnegative time. Each job
contributes exactly the length of its unfinished interval intersected with the prefix. -/
noncomputable def paidCost (t : ℝ) : ℝ := ∑ i, min t (r.completion i)

theorem paid_le_cost (t : ℝ) : r.paidCost t ≤ r.cost :=
  Finset.sum_le_sum fun i _ => min_le_right t (r.completion i)

theorem service_nonneg (i : ι) (t : ℝ) (ht : 0 ≤ t) : 0 ≤ r.service t i := by
  rw [← r.service_zero i]
  exact r.service_mono i 0 t le_rfl ht

theorem service_sum_le (t : ℝ) (ht : 0 ≤ t) : (∑ i, r.service t i) ≤ t := by
  simpa [r.service_zero] using r.capacity 0 t le_rfl ht

theorem service_increment_le [DecidableEq ι] (i : ι) (u t : ℝ) (hu : 0 ≤ u) (hut : u ≤ t) :
    r.service t i - r.service u i ≤ t - u := by
  have hin : i ∈ (Finset.univ : Finset ι) := Finset.mem_univ i
  exact (Finset.single_le_sum
    (f := fun j => r.service t j - r.service u j)
    (fun j _ => sub_nonneg.mpr (r.service_mono j u t hu hut)) hin).trans
      (by rw [Finset.sum_sub_distrib]; exact r.capacity u t hu hut)

theorem paid_before_first (t : ℝ) (h : ∀ i, t ≤ r.completion i) :
    r.paidCost t = (Fintype.card ι : ℝ) * t := by
  simp [paidCost, min_eq_left (h _)]

theorem paid_of_same_prefix {z : ι → ℝ} (alt : Run z) (t : ℝ) (ht : 0 ≤ t)
    (hobs : ∀ i, if r.completion i ≤ t then z i = x i else r.service t i < z i)
    (hs : ∀ u, 0 ≤ u → u ≤ t → alt.service u = r.service u) :
    alt.paidCost t = r.paidCost t := by
  apply Finset.sum_congr rfl
  intro i _
  have h := hobs i
  by_cases hfin : r.completion i ≤ t
  · rw [if_pos hfin] at h
    have hc := (r.completion_pos i).le
    have hserve : alt.service (r.completion i) i = z i := by
      rw [hs (r.completion i) hc hfin, h]
      exact (r.complete_iff i _ hc).mpr le_rfl
    have halt : alt.completion i ≤ r.completion i := (alt.complete_iff i _ hc).mp hserve
    have hca := (alt.completion_pos i).le
    have hx : r.service (alt.completion i) i = x i := by
      rw [← hs (alt.completion i) hca (halt.trans hfin), ← h]
      exact (alt.complete_iff i _ hca).mpr le_rfl
    rw [le_antisymm halt ((r.complete_iff i _ hca).mp hx)]
  · rw [if_neg hfin] at h
    have hnot : ¬ alt.completion i ≤ t := by
      intro hfinished
      have hgot := (alt.complete_iff i t ht).mpr hfinished
      rw [hs t ht le_rfl] at hgot
      exact (ne_of_lt h) hgot
    rw [min_eq_left (le_of_not_ge hnot), min_eq_left (le_of_not_ge hfin)]

end Run

def Robust (A : Policy ι) (R : ℝ) : Prop :=
  ∀ x y, (A.run y x).cost ≤ R * frozenCost x.val

def Consistent (A : Policy ι) (C : ℝ) : Prop :=
  ∀ y, (A.run y y).cost ≤ C * frozenCost y.val

theorem frozen_mono (v w : ι → ℝ) (h : ∀ i, v i ≤ w i) :
    frozenCost v ≤ frozenCost w := by
  apply div_le_div_of_nonneg_right _ (by norm_num)
  exact add_le_add (Finset.sum_le_sum fun i _ => h i)
    (Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => min_le_min (h i) (h j))

theorem frozen_add_constant (v : ι → ℝ) (ε : ℝ) :
    frozenCost (fun i => v i + ε) =
      frozenCost v + triangularCost (Fintype.card ι : ℝ) * ε := by
  unfold frozenCost triangularCost
  simp_rw [min_add_add_right, Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ,
    nsmul_eq_mul]
  ring

theorem frozen_upper_by_capacity (v : ι → ℝ) :
    frozenCost v ≤ ((Fintype.card ι : ℝ) + 1) / 2 * ∑ i, v i := by
  have hp : (∑ i, ∑ j : ι, min (v i) (v j)) ≤ ∑ i, ∑ _j : ι, v i :=
    Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun _ _ => min_le_left _ _
  have hs : (∑ i, ∑ _j : ι, v i) = (Fintype.card ι : ℝ) * ∑ i, v i := by
    simp [Finset.mul_sum]
  unfold frozenCost
  rw [hs] at hp
  linarith only [hp]

theorem robustness_requires_frozen (A : Policy ι) (R : ℝ) (hR : 0 ≤ R) (hrob : Robust A R)
    (y x : PositiveSizes ι) (t : ℝ) (ht : 0 ≤ t) :
    (A.run y x).paidCost t ≤ R * frozenCost ((A.run y x).service t) := by
  let r := A.run y x
  let Q := triangularCost (Fintype.card ι : ℝ)
  have hQ : 0 ≤ Q := by unfold Q triangularCost; positivity
  have hcoef : 0 < R * Q + 1 := by positivity
  apply le_of_forall_pos_le_add
  intro δ hδ
  let ε := δ / (R * Q + 1)
  have hε : 0 < ε := div_pos hδ hcoef
  let zval := fun i => if r.completion i ≤ t then x.val i else r.service t i + ε
  let z : PositiveSizes ι := ⟨zval, fun i => by
    dsimp [zval]
    split
    · exact x.property i
    · exact add_pos_of_nonneg_of_pos (r.service_nonneg i t ht) hε⟩
  have hobs : ∀ i, if r.completion i ≤ t then z.val i = x.val i
      else r.service t i < z.val i := by
    intro i
    by_cases h : r.completion i ≤ t <;> simp [z, zval, h, hε]
  have hzle (i : ι) : z.val i ≤ r.service t i + ε := by
    by_cases h : r.completion i ≤ t
    · simpa [z, zval, h, (r.complete_iff i t ht).mpr h] using hε.le
    · simp [z, zval, h]
  have hp := r.paid_of_same_prefix (A.run y z) t ht hobs (A.prefix_agrees y x z t ht hobs)
  have hcost : r.paidCost t ≤ R * frozenCost z.val :=
    hp ▸ ((A.run y z).paid_le_cost t).trans (hrob z y)
  have hf : frozenCost z.val ≤ frozenCost (r.service t) + Q * ε :=
    (frozen_mono _ _ hzle).trans_eq (frozen_add_constant (r.service t) ε)
  have hcancel : ε * (R * Q + 1) = δ := div_mul_cancel₀ δ hcoef.ne'
  change r.paidCost t ≤ R * frozenCost (r.service t) + δ
  nlinarith only [hcost, mul_le_mul_of_nonneg_left hf hR, hcancel, hε]

/-- Capacity and causal freezing force the no-prediction threshold even for an
idling policy and regardless of how it chooses rates before the first completion. -/
theorem robustness_baseline [Nonempty ι] (A : Policy ι) (R : ℝ) (hR : 0 ≤ R)
    (hrob : Robust A R) : baselineRobustness (Fintype.card ι : ℝ) ≤ R := by
  let ones : PositiveSizes ι := ⟨fun _ => 1, fun _ => zero_lt_one⟩
  let r := A.run ones ones
  obtain ⟨i, _, hi⟩ :=
    Finset.exists_min_image Finset.univ r.completion Finset.univ_nonempty
  let t := r.completion i
  have ht : 0 < t := r.completion_pos i
  have hp := robustness_requires_frozen A R hR hrob ones ones t ht.le
  change r.paidCost t ≤ R * frozenCost (r.service t) at hp
  rw [r.paid_before_first t (fun j => hi j (Finset.mem_univ j))] at hp
  have hcard : 0 ≤ (Fintype.card ι : ℝ) := by positivity
  have hfactor : 0 ≤ ((Fintype.card ι : ℝ) + 1) / 2 := by positivity
  have hu := (frozen_upper_by_capacity (r.service t)).trans
    (mul_le_mul_of_nonneg_left (r.service_sum_le t ht.le) hfactor)
  have hb : (Fintype.card ι : ℝ) * t ≤
      (R * ((Fintype.card ι : ℝ) + 1) / 2) * t := by
    calc
      _ ≤ R * (((Fintype.card ι : ℝ) + 1) / 2 * t) :=
        hp.trans (mul_le_mul_of_nonneg_left hu hR)
      _ = _ := by ring
  have hb' := (mul_le_mul_right ht).mp hb
  unfold baselineRobustness
  exact (div_le_iff₀ (by positivity)).mpr (by linarith only [hb'])

end FiniteFrontier
