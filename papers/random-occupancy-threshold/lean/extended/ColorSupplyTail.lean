import HalfColorOccupancy
import CriticalGapEstimates

namespace TwoColorNullity.Occupancy

noncomputable def colorSupplyCoefficient : ℝ := occupancyCurve (1 / 2) / 4

theorem colorSupplyCoefficient_pos : 0 < colorSupplyCoefficient := by
  unfold colorSupplyCoefficient
  exact div_pos (occupancyCurve_pos _ (by norm_num)) (by norm_num)

private theorem colorCount_mean_linear (n : ℕ) (owners : Finset (Fin n))
    (hn : 8 ≤ n) (hsize : n.log2 ≤ owners.card) (hlarge : 50 ≤ occupancyCurve (1 / 2) * (n : ℝ))
    (owner : ↥owners) (color : Bool) :
    colorSupplyCoefficient * (n : ℝ) ≤ finiteMean
      (fun draws : Fin (3 * n - 1) → (↥owners → Bool) => (restrictedOddCount (designatedColorBins owner color) draws : ℝ)) := by
  let s := owners.card
  let k := 2 ^ s
  have hnR : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hlow : (n : ℝ) / 2 ≤ (k : ℝ) := by
    have hp : n < 2 ^ (n.log2 + 1) := (Nat.log2_lt (by omega)).mp (by omega)
    have hcast : (n : ℝ) < (2 : ℝ) ^ (n.log2 + 1) := by exact_mod_cast hp
    rw [pow_succ] at hcast
    have hpow : (2 : ℝ) ^ n.log2 ≤ (2 : ℝ) ^ s := pow_le_pow_right₀ (by norm_num) hsize
    change (n : ℝ) / 2 ≤ ((2 ^ s : ℕ) : ℝ)
    push_cast
    linarith
  have hk : 4 ≤ k := by
    have hnr : (8 : ℝ) ≤ n := by exact_mod_cast hn
    exact_mod_cast (show (4 : ℝ) ≤ (k : ℝ) by linarith)
  have hkR : 0 < (k : ℝ) := by exact_mod_cast (show 0 < k by omega)
  have hratio : (1 : ℝ) / 2 ≤ (k : ℝ) / (n : ℝ) := by
    apply (le_div_iff₀ hnR).mpr
    linarith
  have hmono := occupancyCurve_strictMono.monotoneOn
    (by norm_num : (0 : ℝ) < 1 / 2) (div_pos hkR hnR) hratio
  have hscale := mul_le_mul_of_nonneg_left hmono hnR.le
  have hm : (((3 * n - 1 : ℕ) : ℝ)) ≤ 3 * (n : ℝ) := by exact_mod_cast Nat.sub_le (3 * n) 1
  have herr : 4 * ((3 * n - 1 : ℕ) : ℝ) / (k : ℝ) + 1 ≤ 25 := by
    have hq : 4 * ((3 * n - 1 : ℕ) : ℝ) / (k : ℝ) ≤ 24 :=
      (div_le_iff₀ hkR).mpr (by linarith only [hm, hlow])
    linarith
  have happrox := (abs_le.mp (expectedOddCount_approximation n k (by omega) hk)).1
  have hdouble := designatedColor_mean_double n (3 * n - 1) owners owner color
  change 2 * finiteMean _ = finiteMean (fun draws : Fin (3 * n - 1) → Fin k => (oddBinCount draws : ℝ)) at hdouble
  unfold colorSupplyCoefficient
  nlinarith only [hscale, hdouble, happrox, herr, hlarge]

theorem colorDeficit_fixed_group_tail (n : ℕ) (owners : Finset (Fin n))
    (hn : 8 ≤ n) (hsize : n.log2 ≤ owners.card) (hlarge : 50 ≤ occupancyCurve (1 / 2) * (n : ℝ))
    (owner : ↥owners) (color : Bool) :
    finiteProbability (fun bits : BitProfile n (3 * n - 1) =>
      (restrictedOddCount (designatedColorBins owner color) (signature (profileTag bits) owners) : ℝ) <
        colorSupplyCoefficient * (n : ℝ) / 2) ≤
      Real.exp (-(colorSupplyCoefficient ^ 2 * (n : ℝ) / 24)) := by
  let m := 3 * n - 1
  let labels := designatedColorBins owner color
  let f (data : Fin m → (↥owners → Bool)) := (restrictedOddCount labels data : ℝ)
  let gap := colorSupplyCoefficient * (n : ℝ) / 2
  have hpos : 0 ≤ gap := by unfold gap; have hpos := colorSupplyCoefficient_pos; positivity
  have hmean := colorCount_mean_linear n owners hn hsize hlarge owner color
  rw [projectedWords_uniform_probability owners m (fun data => f data < gap)]
  have hdom : finiteProbability (fun data => f data < gap) ≤
      finiteProbability (fun data => gap ≤ -(f data - finiteMean f)) := by
    apply finiteProbability_mono
    intro data h
    change colorSupplyCoefficient * (n : ℝ) ≤ finiteMean f at hmean
    unfold gap at h ⊢
    linarith only [hmean, h]
  have hbound := finiteMean_boundedDifferences_lowerTail m f (restrictedOddCount_bounded_difference labels) gap hpos
  refine hdom.trans (hbound.trans (Real.exp_le_exp.mpr ?_))
  have hm0 : 0 < (m : ℝ) := by exact_mod_cast (show 0 < m by dsimp [m]; omega)
  have hsmall : (m : ℝ) ≤ 3 * (n : ℝ) := by exact_mod_cast Nat.sub_le (3 * n) 1
  have hmul := mul_le_mul_of_nonneg_left hsmall
    (show 0 ≤ colorSupplyCoefficient ^ 2 * (n : ℝ) by positivity)
  rw [neg_div]
  apply neg_le_neg
  apply (le_div_iff₀ (mul_pos (by norm_num : (0 : ℝ) < 2) hm0)).mpr
  unfold gap
  nlinarith only [hmul]

end TwoColorNullity.Occupancy
