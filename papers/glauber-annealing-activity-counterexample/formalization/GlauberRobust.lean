import GlauberStructural

open Filter Topology
open scoped BigOperators

namespace GlauberAnnealing

namespace RegularGraph

variable {V : Type*} [Fintype V] (M : RegularGraph V)

section Continuity

variable {X : Type*} [TopologicalSpace X] (E : X → V → ℝ) (hE : ∀ i, Continuous fun x => E x i)

include hE

theorem continuous_gibbs [Nonempty V] (β : X → ℝ) (hβ : Continuous β) (i : V) :
    Continuous fun x => gibbs (E x) (β x) i := by
  have hw (j : V) : Continuous fun x => weight (E x) (β x) j :=
    Real.continuous_exp.comp (hβ.neg.mul (hE j))
  exact (hw i).div (continuous_finset_sum _ fun j _ => hw j)
    (fun x => ne_of_gt (gibbs_normalizer_pos (E x) (β x)))

theorem continuous_edgeRate (β : X → ℝ) (hβ : Continuous β) (i j : V) :
    Continuous fun x => M.edgeRate (E x) (β x) i j := by
  by_cases ha : M.graph.Adj i j
  · simp_rw [M.edgeRate_of_adj _ _ ha]
    have hd : Continuous fun x => 1 + Real.exp (β x * (E x i - E x j)) :=
      continuous_const.add (Real.continuous_exp.comp (hβ.mul ((hE i).sub (hE j))))
    unfold acceptance
    exact (continuous_const.div hd (fun x => by positivity)).div_const (M.degree : ℝ)
  · simp_rw [M.edgeRate_of_not_adj _ _ ha]
    exact continuous_const

theorem continuous_exitRate (β : X → ℝ) (hβ : Continuous β) (i : V) :
    Continuous fun x => M.exitRate (E x) (β x) i :=
  continuous_finset_sum _ fun j _ => M.continuous_edgeRate E hE β hβ j i

theorem continuous_transition (β : X → ℝ) (hβ : Continuous β) (i j : V) :
    Continuous fun x => M.transition (E x) (β x) i j := by
  classical
  by_cases h : i = j
  · subst i
    have hf (x : X) : M.transition (E x) (β x) j j = 1 - M.exitRate (E x) (β x) j := by
      simp [transition, M.edgeRate_self]
    simp_rw [hf]
    exact continuous_const.sub (M.continuous_exitRate E hE β hβ j)
  · simp_rw [M.transition_of_ne _ _ h]
    exact M.continuous_edgeRate E hE β hβ i j

theorem continuous_update (β : X → ℝ) (hβ : Continuous β)
    (p : X → V → ℝ) (hp : ∀ j, Continuous fun x => p x j) (i : V) :
    Continuous fun x => M.update (E x) (β x) (p x) i :=
  continuous_finset_sum _ fun j _ => (M.continuous_transition E hE β hβ i j).mul (hp j)

theorem continuous_activity (β : X → ℝ) (hβ : Continuous β)
    (p : X → V → ℝ) (hp : ∀ j, Continuous fun x => p x j) :
    Continuous fun x => M.activity (E x) (β x) (p x) :=
  continuous_finset_sum _ fun j _ => (M.continuous_exitRate E hE β hβ j).mul (hp j)

variable [Nonempty V]

theorem continuous_firstActivity (β₀ β₁ : X → ℝ) (h₀ : Continuous β₀) (h₁ : Continuous β₁) :
    Continuous fun x => M.firstActivity (E x) (β₀ x) (β₁ x) :=
  M.continuous_activity E hE β₁ h₁ _ (continuous_gibbs E hE β₀ h₀)

theorem continuous_secondActivity (β₀ β₁ β₂ : X → ℝ)
    (h₀ : Continuous β₀) (h₁ : Continuous β₁) (h₂ : Continuous β₂) :
    Continuous fun x => M.secondActivity (E x) (β₀ x) (β₁ x) (β₂ x) :=
  M.continuous_activity E hE β₂ h₂ _ (M.continuous_update E hE β₁ h₁ _ (continuous_gibbs E hE β₀ h₀))

theorem continuous_averageActivity (β₀ β₁ β₂ : X → ℝ)
    (h₀ : Continuous β₀) (h₁ : Continuous β₁) (h₂ : Continuous β₂) :
    Continuous fun x => M.averageActivity (E x) (β₀ x) (β₁ x) (β₂ x) := by
  exact ((M.continuous_firstActivity E hE β₀ β₁ h₀ h₁).add
    (M.continuous_secondActivity E hE β₀ β₁ β₂ h₀ h₁ h₂)).div_const 2

end Continuity

noncomputable def violationRegion : Set ((V → ℝ) × ℝ × ℝ × ℝ) :=
  {p | (0 < p.2.1 ∧ p.2.1 < p.2.2.1 ∧ p.2.2.1 < p.2.2.2) ∧
    1 / 2 < M.secondActivity p.1 p.2.1 p.2.2.1 p.2.2.2 ∧
    1 / 2 < M.averageActivity p.1 p.2.1 p.2.2.1 p.2.2.2}

theorem isOpen_violationRegion [Nonempty V] : IsOpen M.violationRegion := by
  let E : ((V → ℝ) × ℝ × ℝ × ℝ) → V → ℝ := Prod.fst
  let b₀ : ((V → ℝ) × ℝ × ℝ × ℝ) → ℝ := fun p => p.2.1
  let b₁ : ((V → ℝ) × ℝ × ℝ × ℝ) → ℝ := fun p => p.2.2.1
  let b₂ : ((V → ℝ) × ℝ × ℝ × ℝ) → ℝ := fun p => p.2.2.2
  have hE (i : V) : Continuous fun p => E p i := (continuous_apply i).comp continuous_fst
  have h₀ : Continuous b₀ := continuous_fst.comp continuous_snd
  have h₁ : Continuous b₁ := continuous_fst.comp (continuous_snd.comp continuous_snd)
  have h₂ : Continuous b₂ := continuous_snd.comp (continuous_snd.comp continuous_snd)
  exact ((isOpen_lt continuous_const h₀).inter ((isOpen_lt h₀ h₁).inter (isOpen_lt h₁ h₂))).inter
    ((isOpen_lt continuous_const (M.continuous_secondActivity E hE b₀ b₁ b₂ h₀ h₁ h₂)).inter
      (isOpen_lt continuous_const (M.continuous_averageActivity E hE b₀ b₁ b₂ h₀ h₁ h₂)))

theorem isOpen_energy_violation [Nonempty V] (β₀ β₁ β₂ : ℝ) :
    IsOpen {E : V → ℝ | 1 / 2 < M.secondActivity E β₀ β₁ β₂ ∧
      1 / 2 < M.averageActivity E β₀ β₁ β₂} := by
  have hE (i : V) : Continuous fun E : V → ℝ => E i := continuous_apply i
  exact (isOpen_lt continuous_const (M.continuous_secondActivity id hE _ _ _
    continuous_const continuous_const continuous_const)).inter
    (isOpen_lt continuous_const (M.continuous_averageActivity id hE _ _ _
    continuous_const continuous_const continuous_const))

theorem exists_injective_energy_in_open {S : Set (V → ℝ)} (hS : IsOpen S)
    {E : V → ℝ} (hE : E ∈ S) : ∃ E' ∈ S, Function.Injective E' := by
  classical
  let e := Fintype.equivFin V
  let rank : V → ℝ := fun i => ((e i : ℕ) : ℝ)
  have hrank : Function.Injective rank := by
    intro i j hij
    apply e.injective
    apply Fin.ext
    change (((e i : ℕ) : ℝ)) = ((e j : ℕ) : ℝ) at hij
    exact_mod_cast hij
  let p : ℝ → V → ℝ := fun x i => E i + x * rank i
  have hp (i : V) : Continuous fun x => p x i :=
    continuous_const.add (continuous_id.mul continuous_const)
  have hp0 : p 0 = E := by
    funext i
    simp [p]
  have hpre : ∀ᶠ x : ℝ in 𝓝[>] 0, p x ∈ S := by
    have ht := (continuous_pi hp).continuousAt (x := 0)
    rw [ContinuousAt, hp0] at ht
    exact (ht.eventually (hS.mem_nhds hE)).filter_mono nhdsWithin_le_nhds
  have hinj : ∀ᶠ x : ℝ in 𝓝[>] 0, Function.Injective (p x) := by
    have hpair : ∀ᶠ x : ℝ in 𝓝[>] 0, ∀ i j, i ≠ j → p x i ≠ p x j := by
      refine Filter.eventually_all.mpr fun i => Filter.eventually_all.mpr fun j => ?_
      by_cases hij : i = j
      · exact Eventually.of_forall fun _ hi => (hi hij).elim
      by_cases hEq : E i = E j
      · filter_upwards [eventually_mem_nhdsWithin (a := (0 : ℝ)) (s := Set.Ioi 0)] with x hx _
        intro hpEq
        have hx0 : x ≠ 0 := ne_of_gt hx
        change E i + x * rank i = E j + x * rank j at hpEq
        have hm : x * (rank i - rank j) = 0 := by linarith
        rcases mul_eq_zero.mp hm with hzero | hsep
        · exact hx0 hzero
        · exact hij (hrank (sub_eq_zero.mp hsep))
      · have hc := ((hp i).sub (hp j)).continuousAt (x := 0)
        have hzero : p 0 i - p 0 j ≠ 0 := by simpa [hp0] using sub_ne_zero.mpr hEq
        have hn := (hc.eventually_ne hzero).filter_mono
          (nhdsWithin_le_nhds : 𝓝[>] (0 : ℝ) ≤ 𝓝 0)
        exact hn.mono fun _ hx _ he => hx (sub_eq_zero.mpr he)
    exact hpair.mono fun _ hx i j he => by_contra fun hn => hx i j hn he
  obtain ⟨t, ht, hi⟩ := (hpre.and hinj).exists
  exact ⟨p t, ht, hi⟩

theorem exists_distinct_energy_violation [Nonempty V] {E : V → ℝ} (β₀ β₁ β₂ : ℝ)
    (h₂ : 1 / 2 < M.secondActivity E β₀ β₁ β₂)
    (ha : 1 / 2 < M.averageActivity E β₀ β₁ β₂) :
    ∃ E' : V → ℝ, Function.Injective E' ∧
      1 / 2 < M.secondActivity E' β₀ β₁ β₂ ∧ 1 / 2 < M.averageActivity E' β₀ β₁ β₂ := by
  obtain ⟨E', hE', hinj⟩ := exists_injective_energy_in_open
    (M.isOpen_energy_violation β₀ β₁ β₂) (show E ∈ _ from ⟨h₂, ha⟩)
  exact ⟨E', hinj, hE'⟩

/-- The structural counterexample on the actual finite regular graph model. -/
theorem regular_bridge_violation {s t : V} (hbridge : M.graph.IsBridge s(s, t))
    (hdegree : 3 ≤ M.degree) :
    ∃ (E : V → ℝ) (β₀ β₁ β₂ : ℝ),
      Function.Injective E ∧ 0 < β₀ ∧ β₀ < β₁ ∧ β₁ < β₂ ∧
      β₂⁻¹ < β₁⁻¹ ∧ β₁⁻¹ < β₀⁻¹ ∧
      1 / 2 < M.secondActivity E β₀ β₁ β₂ ∧ 1 / 2 < M.averageActivity E β₀ β₁ β₂ := by
  letI : Nonempty V := ⟨s⟩
  obtain ⟨E, β₀, β₁, β₂, h₀, h₀₁, h₁₂, h₂, ha⟩ :=
    (BridgeCut.ofIsBridge hbridge).exists_violating_run hdegree
  obtain ⟨E', hinj, h₂', ha'⟩ := M.exists_distinct_energy_violation β₀ β₁ β₂ h₂ ha
  have h₁ := h₀.trans h₀₁
  have hb₂ := h₁.trans h₁₂
  exact ⟨E', β₀, β₁, β₂, hinj, h₀, h₀₁, h₁₂,
    (inv_lt_inv₀ hb₂ h₁).2 h₁₂, (inv_lt_inv₀ h₁ h₀).2 h₀₁, h₂', ha'⟩

end RegularGraph
end GlauberAnnealing
