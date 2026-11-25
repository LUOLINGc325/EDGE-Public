import DimensionBranches
import Mathlib.Algebra.Order.Floor.Ring

/-! Glue the finite dimension branches and select the actual unit-job cutoff. -/

open scoped BigOperators

namespace FiniteFrontier

theorem baseline_le_iff_affine (m R : ℝ) (hm : 0 ≤ m) :
    baselineRobustness m ≤ R ↔ 0 ≤ (R - 2) * (m + 1) + 2 := by
  unfold baselineRobustness
  rw [div_le_iff₀ (by linarith : 0 < m + 1)]
  constructor <;> intro h <;> linarith only [h]

theorem baseline_mono {v w : ℝ} (hv : 0 ≤ v) (hvw : v ≤ w) :
    baselineRobustness v ≤ baselineRobustness w := by
  unfold baselineRobustness
  have hvp : 0 < v + 1 := by linarith
  have hwp : 0 < w + 1 := by linarith
  exact (div_le_div_iff₀ hvp hwp).mpr (by linarith only [hvw])

theorem baseline_at_least_one {m : ℝ} (hm : 1 ≤ m) : 1 ≤ baselineRobustness m := by
  unfold baselineRobustness
  apply (le_div_iff₀ (by linarith : 0 < m + 1)).mpr
  linarith

theorem affine_feasible_between (R H J K : ℝ) (h₁ : H ≤ J) (h₂ : J ≤ K)
    (hH : 0 ≤ (R - 2) * H + 2) (hK : 0 ≤ (R - 2) * K + 2) :
    0 ≤ (R - 2) * J + 2 := by
  rcases le_total 2 R with h | h
  · have hh := mul_le_mul_of_nonneg_left h₁ (sub_nonneg.mpr h)
    linarith only [hH, hh]
  · have hh := mul_le_mul_of_nonpos_left h₂ (sub_nonpos.mpr h)
    linarith only [hK, hh]

theorem branch_mono_same (R H K : ℝ) (a : ℕ) (hR : 1 ≤ R) (hHK : H ≤ K)
    (hlo : (R + 1) * (a : ℝ) ≤ H) (hhi : K ≤ (R + 1) * ((a : ℝ) + 1))
    (hH : 0 ≤ (R - 2) * H + 2) (hK : 0 ≤ (R - 2) * K + 2) :
    branchValue R H a ≤ branchValue R K a := by
  by_cases ha : a = 0
  · simp [ha, branch_value_empty]
  exact (branch_strict_mono R H K a (Nat.pos_of_ne_zero ha) hR hlo hhi hH hK).monotoneOn
    ⟨le_rfl, hHK⟩ ⟨hHK, le_rfl⟩ hHK

/-- Joining the consecutive closed branches yields the dimension inequality. -/
theorem branch_mono_across (R H : ℝ) (a : ℕ) (hR : 1 ≤ R)
    (hlo : (R + 1) * (a : ℝ) ≤ H) (hhi : H ≤ (R + 1) * ((a : ℝ) + 1))
    (hH : 0 ≤ (R - 2) * H + 2) :
    ∀ b, a ≤ b → ∀ K : ℝ, H ≤ K → (R + 1) * (b : ℝ) ≤ K →
      K ≤ (R + 1) * ((b : ℝ) + 1) → 0 ≤ (R - 2) * K + 2 →
      branchValue R H a ≤ branchValue R K b := by
  intro b hab
  induction b, hab using Nat.le_induction with
  | base =>
    intro K hHK _ hK hf
    exact branch_mono_same R H K a hR hHK hlo hK hH hf
  | succ b hab ih =>
    intro K _ hKlo hKhi hf
    let J := (R + 1) * ((b : ℝ) + 1)
    have hRJ : 0 ≤ R + 1 := by linarith
    have hRpos : 0 < R := by linarith
    have hab' : (a : ℝ) ≤ (b : ℝ) := by exact_mod_cast hab
    have hHJ : H ≤ J := hhi.trans (mul_le_mul_of_nonneg_left (add_le_add_right hab' 1) hRJ)
    have hJK : J ≤ K := by simpa only [Nat.cast_succ] using hKlo
    have hJlo : (R + 1) * (b : ℝ) ≤ J := mul_le_mul_of_nonneg_left (by linarith) hRJ
    have hJf := affine_feasible_between R H J K hHJ hJK hH hf
    have hfirst := ih J hHJ hJlo le_rfl hJf
    have hnextlo : (R + 1) * (↑(b + 1) : ℝ) ≤ J := by rw [Nat.cast_succ]
    have hsecond := branch_mono_same R J K (b + 1) hR hJK hnextlo hKhi hJf hf
    exact hfirst.trans ((branch_value_agrees_at_cutoff R b hRpos).ge.trans hsecond)

noncomputable def unitIndex (m : ℕ) (R : ℝ) : ℕ :=
  if (m : ℝ) ≤ R then 0 else ⌊((m : ℝ) + 1) / (R + 1)⌋₊

noncomputable def unitFrontier (m : ℕ) (R : ℝ) : ℝ := unitValue m R (unitIndex m R)

theorem unit_index_is_branch (m : ℕ) (R : ℝ) (hm : 0 < m)
    (hR : baselineRobustness (m : ℝ) ≤ R) : UnitBranch m R (unitIndex m R) := by
  have hm₁ : 1 ≤ (m : ℝ) := by exact_mod_cast hm
  have hR₁ := (baseline_at_least_one hm₁).trans hR
  have hp : 0 < R + 1 := by linarith
  unfold unitIndex
  split
  · rename_i hserial
    constructor
    · exact hm
    · exact hR
    · exact hm
    · unfold unitGap; simp; positivity
    · unfold unitGap; push_cast; linarith
  rename_i hserial
  let X := ((m : ℝ) + 1) / (R + 1)
  have hX : 0 ≤ X := by unfold X; positivity
  have hm₂ : 1 < (m : ℝ) := lt_of_not_ge fun hs => hserial (hs.trans hR₁)
  have hmR : 1 < (m : ℝ) * R := hm₂.trans_le (le_mul_of_one_le_right (by positivity) hR₁)
  have hXlt : X < (m : ℝ) := by
    apply (div_lt_iff₀ hp).mpr
    dsimp [X]
    nlinarith only [hmR]
  have hf := Nat.floor_le hX
  have hf' := (le_div_iff₀ hp).mp hf
  have hg := (div_lt_iff₀ hp).mp (Nat.lt_floor_add_one X)
  refine ⟨hm, hR, (Nat.floor_lt hX).mpr hXlt, ?_, ?_⟩
  · change 0 ≤ (m : ℝ) + 1 - (R + 1) * (⌊X⌋₊ : ℝ)
    dsimp [X] at hf'
    linarith only [hf']
  · change (m : ℝ) + 1 - (R + 1) * ((⌊X⌋₊ : ℝ) + 1) ≤ 0
    dsimp [X] at hg
    linarith only [hg]

theorem unit_index_mono {m n : ℕ} (h : m ≤ n) (R : ℝ) (hR : 1 ≤ R) :
    unitIndex m R ≤ unitIndex n R := by
  have h' : (m : ℝ) ≤ (n : ℝ) := by exact_mod_cast h
  by_cases hm : (m : ℝ) ≤ R
  · simp [unitIndex, hm]
  have hn : ¬ (n : ℝ) ≤ R := fun hr => hm (h'.trans hr)
  simp only [unitIndex, if_neg hm, if_neg hn]
  exact Nat.floor_mono (div_le_div_of_nonneg_right (add_le_add_right h' 1) (by linarith))

theorem dimension_monotonicity {m n : ℕ} (hm : 0 < m) (hmn : m ≤ n)
    (R : ℝ) (hR : baselineRobustness (n : ℝ) ≤ R) :
    unitFrontier m R ≤ unitFrontier n R := by
  have hn := hm.trans_le hmn
  have hm₁ : 1 ≤ (m : ℝ) := by exact_mod_cast hm
  have hmn' : (m : ℝ) ≤ (n : ℝ) := by exact_mod_cast hmn
  have hRm := (baseline_mono (by positivity) hmn').trans hR
  have hRp := (baseline_at_least_one hm₁).trans hRm
  let a := unitIndex m R
  let b := unitIndex n R
  let H := (m : ℝ) + 1
  let K := (n : ℝ) + 1
  let bm := unit_index_is_branch m R hm hRm
  let bn := unit_index_is_branch n R hn hR
  have ha₀ : (R + 1) * (a : ℝ) ≤ H := sub_nonneg.mp bm.active
  have ha₁ : H ≤ (R + 1) * ((a : ℝ) + 1) := sub_nonpos.mp bm.inactive
  have hb₀ : (R + 1) * (b : ℝ) ≤ K := sub_nonneg.mp bn.active
  have hb₁ : K ≤ (R + 1) * ((b : ℝ) + 1) := sub_nonpos.mp bn.inactive
  have hH := (baseline_le_iff_affine (m : ℝ) R (by positivity)).mp hRm
  have hK := (baseline_le_iff_affine (n : ℝ) R (by positivity)).mp hR
  have hcomp := branch_mono_across R H a hRp ha₀ ha₁ hH b (unit_index_mono hmn R hRp)
    K (add_le_add_right hmn' 1) hb₀ hb₁ hK
  change unitValue m R a ≤ unitValue n R b
  rw [unit_value_eq_branch_value (m : ℝ) R a bm.num_jobs_real hRm bm.index_real,
    unit_value_eq_branch_value (n : ℝ) R b bn.num_jobs_real hR bn.index_real]
  exact hcomp

end FiniteFrontier
