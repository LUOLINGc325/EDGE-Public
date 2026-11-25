import DiracReduction

/-! The unrestricted Rényi coefficient equals the supremum over Dirac mixtures. -/

open Set

namespace RenyiProductOrderPhase

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

noncomputable def diracRatio (w : ι → FiniteMass κ) (b : ℝ) (i j : ι)
    (t : ℝ) (ht : t ∈ Icc (0 : ℝ) 1) : ℝ :=
  let p := FiniteMass.dirac i
  let q := FiniteMass.mix p (FiniteMass.dirac j) t ht
  renyiDivergence b (p.push w) (q.push w) / renyiDivergence b p q

def diracRatios (w : ι → FiniteMass κ) (b : ℝ) : Set ℝ :=
  {x | ∃ i j : ι, i ≠ j ∧ ∃ (t : ℝ) (ht : t ∈ Icc (0 : ℝ) 1),
    0 < t ∧ t < 1 ∧ x = diracRatio w b i j t ht}

theorem dirac_ratio_mem_unit (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (b : ℝ) (hb : 0 < b) {x : ℝ} (hx : x ∈ diracRatios w b) :
    x ∈ Icc (0 : ℝ) 1 := by
  obtain ⟨i, j, hij, t, ht, h₀, h₁, rfl⟩ := hx
  exact divergence_ratio_mem_unit _ _ w hw b hb (dirac_mix_admissible b hb hij ht h₀ h₁)

theorem dirac_ratios_nonempty [Nontrivial ι] (w : ι → FiniteMass κ) (b : ℝ) :
    (diracRatios w b).Nonempty := by
  obtain ⟨i, j, hij⟩ := exists_pair_ne ι
  have ht : (1 / 2 : ℝ) ∈ Icc (0 : ℝ) 1 := by constructor <;> norm_num
  exact ⟨diracRatio w b i j (1 / 2) ht, i, j, hij, 1 / 2, ht, by norm_num, by norm_num, rfl⟩

theorem contraction_coefficient_dirac [Nontrivial ι] (w : ι → FiniteMass κ)
    (hw : ∀ i y, 0 < w i y) (b : ℝ) (hb : 1 ≤ b) :
    contractionCoefficient b w = sSup (diracRatios w b) := by
  let A := {x : ℝ | ∃ p q : FiniteMass ι, RenyiAdmissible b p q ∧
    x = renyiDivergence b (p.push w) (q.push w) / renyiDivergence b p q}
  let S := diracRatios w b
  have hb₀ : 0 < b := zero_lt_one.trans_le hb
  have hSN : S.Nonempty := dirac_ratios_nonempty w b
  have hSB : BddAbove S := ⟨1, fun x hx => (dirac_ratio_mem_unit w hw b hb₀ hx).2⟩
  have hIncl : S ⊆ A := by
    intro x hx
    obtain ⟨i, j, hij, t, ht, h₀, h₁, rfl⟩ := hx
    exact ⟨_, _, dirac_mix_admissible b hb₀ hij ht h₀ h₁, rfl⟩
  have hAN : A.Nonempty := hSN.mono hIncl
  have hAB : BddAbove A := by
    refine ⟨1, ?_⟩
    intro x hx
    obtain ⟨p, q, ha, rfl⟩ := hx
    exact (divergence_ratio_mem_unit p q w hw b hb₀ ha).2
  let c := sSup S
  have hc : c ∈ Icc (0 : ℝ) 1 := by
    constructor
    · obtain ⟨x, hx⟩ := hSN
      exact (dirac_ratio_mem_unit w hw b hb₀ hx).1.trans (le_csSup hSB hx)
    · exact csSup_le hSN (fun y hy => (dirac_ratio_mem_unit w hw b hb₀ hy).2)
  have hD : DiracMomentBound w b c := by
    intro i j hij t ht h₀ h₁
    apply (divergence_ratio_le_iff_moment _ _ w hw b hb₀
      (dirac_mix_admissible b hb₀ hij ht h₀ h₁) c).mp
    exact le_csSup hSB ⟨i, j, hij, t, ht, h₀, h₁, rfl⟩
  change sSup A = sSup S
  apply le_antisymm
  · apply csSup_le hAN
    intro x hx
    obtain ⟨p, q, hadm, rfl⟩ := hx
    exact (divergence_ratio_le_iff_moment p q w hw b hb₀ hadm c).mpr
      (moment_bound_from_dirac w hw b c hb hc hD p q hadm.1)
  · exact csSup_le hSN (fun x hx => le_csSup hAB (hIncl hx))

end RenyiProductOrderPhase
