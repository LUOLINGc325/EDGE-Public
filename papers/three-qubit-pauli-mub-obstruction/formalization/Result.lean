import Lean
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Matrix.Basic
import Mathlib.Data.Rat.Lemmas
import Mathlib.Data.Nat.Sqrt
import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp
import Mathlib.Data.Matrix.Notation
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Data.Complex.BigOperators
import Mathlib.Tactic.FinCases

-- Audited formalization plan SHA-256: 3e05a27a7e04db6596bba13e53c3da79d3948ea38948bb75401081b5e98f7680
set_option autoImplicit false

namespace EDEGFormalization

noncomputable def IrrationalReal (t : ℝ) :
    Prop :=
    ∀ q : ℚ, t ≠ (q : ℝ)

noncomputable def GaussianRat (z : ℂ) :
    Prop :=
    (∃ r : ℚ, (r : ℝ) = z.re) ∧ (∃ s : ℚ, (s : ℝ) = z.im)

noncomputable def pauli1 (p : Fin 4) :
    Matrix (Fin 2) (Fin 2) ℂ :=
    ![!![1, 0; 0, 1], !![0, 1; 1, 0], !![0, -Complex.I; Complex.I, 0], !![1, 0; 0, -1]] p

noncomputable def pauli (p : (Fin 4 × Fin 4 × Fin 4)) (i j : (Fin 2 × Fin 2 × Fin 2)) :
    ℂ :=
    pauli1 p.1 i.1 j.1 * pauli1 p.2.1 i.2.1 j.2.1 * pauli1 p.2.2 i.2.2 j.2.2

noncomputable def coeff (rho : Matrix (Fin 2 × Fin 2 × Fin 2) (Fin 2 × Fin 2 × Fin 2) ℂ) (p : (Fin 4 × Fin 4 × Fin 4)) :
    ℂ :=
    (Finset.sum Finset.univ (fun i => (Finset.sum Finset.univ (fun j => pauli p i j * rho j i))))

noncomputable def pureDensity (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) :
    Matrix (Fin 2 × Fin 2 × Fin 2) (Fin 2 × Fin 2 × Fin 2) ℂ :=
    fun i j => psi i * (starRingEnd ℂ) (psi j)

noncomputable def innerC {ι : Type*} [Fintype ι] (u v : ι → ℂ) :
    ℂ :=
    (Finset.sum Finset.univ (fun i => star (u i) * v i))

noncomputable def density {ι : Type*} (v : ι → ℂ) :
    Matrix ι ι ℂ :=
    fun i j => v i * star (v j)

noncomputable def matAct {ι : Type*} [Fintype ι] (A : Matrix ι ι ℂ) (v : ι → ℂ) :
    ι → ℂ :=
    fun i => (Finset.sum Finset.univ (fun j => A i j * v j))

noncomputable def MUBPartition (states : (Fin 4 × Fin 4 × Fin 4) → (Fin 2 × Fin 2 × Fin 2) → ℂ) :
    Prop :=
    ∃ e : (Fin 8 × Fin 8) ≃ (Fin 4 × Fin 4 × Fin 4),
        (∀ b j k, innerC (states (e (b,j))) (states (e (b,k))) =
          if j = k then 1 else 0) ∧
        (∀ b c, b ≠ c → ∀ j k,
          Complex.normSq (innerC (states (e (b,j))) (states (e (c,k)))) = (1/8 : ℝ))

noncomputable def PauliOrbitMUB (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) :
    Prop :=
    MUBPartition (fun p => matAct (pauli p) psi)

noncomputable def computationalZero (i : (Fin 2 × Fin 2 × Fin 2)) :
    ℂ :=
    if i = 0 then 1 else 0

noncomputable def phaseAdjustedOrbitMUB (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) :
    Prop :=
    ∃ c : (Fin 4 × Fin 4 × Fin 4) → ℂ, (∀ p, Complex.normSq (c p) = 1) ∧
        MUBPartition (fun p i => c p * matAct (pauli p) psi i)

theorem Example1 :
  ∃ psi : (Fin 2 × Fin 2 × Fin 2) → ℂ, innerC psi psi = 1 :=
  by
    exact ⟨computationalZero, by simp [innerC, computationalZero]⟩

theorem Example2 :
  ¬ innerC (fun _ : (Fin 2 × Fin 2 × Fin 2) => (0 : ℂ)) (fun _ => 0) = 1 :=
  by
    simp [innerC]

theorem Example3 :
  ∃ z : ℂ, GaussianRat z ∧ z ≠ 0 :=
  by
    refine ⟨1, ?_, by norm_num⟩
    exact ⟨⟨1, by simp⟩, ⟨0, by simp⟩⟩

theorem Claim1 :
  ∀ (q : ℚ),
    GaussianRat (q : ℂ) :=
  fun (q : ℚ) =>
    by
      exact ⟨⟨q, by simp⟩, ⟨0, by simp⟩⟩

theorem Claim2 :
  GaussianRat (0 : ℂ) :=
  by
    simpa using Claim1 0

theorem Claim3 :
  GaussianRat (1 : ℂ) :=
  by
    simpa using Claim1 1

theorem Claim4 :
  GaussianRat Complex.I :=
  by
    exact ⟨⟨0, by simp⟩, ⟨1, by simp⟩⟩

theorem Claim5 {z w : ℂ} (hz : GaussianRat z) (hw : GaussianRat w) :
    GaussianRat (z + w) :=
    by
      rcases hz with ⟨⟨a, ha⟩, ⟨b, hb⟩⟩
      rcases hw with ⟨⟨c, hc⟩, ⟨d, hd⟩⟩
      exact ⟨⟨a+c, by simp [ha, hc]⟩, ⟨b+d, by simp [hb, hd]⟩⟩

theorem Claim6 {z : ℂ} (hz : GaussianRat z) :
    GaussianRat (-z) :=
    by
      rcases hz with ⟨⟨a, ha⟩, ⟨b, hb⟩⟩
      exact ⟨⟨-a, by simp [ha]⟩, ⟨-b, by simp [hb]⟩⟩

theorem Claim7 {z w : ℂ} (hz : GaussianRat z) (hw : GaussianRat w) :
    GaussianRat (z - w) :=
    by
      simpa only [sub_eq_add_neg] using Claim5 hz (Claim6 hw)

theorem Claim8 {z w : ℂ} (hz : GaussianRat z) (hw : GaussianRat w) :
    GaussianRat (z * w) :=
    by
      rcases hz with ⟨⟨a, ha⟩, ⟨b, hb⟩⟩
      rcases hw with ⟨⟨c, hc⟩, ⟨d, hd⟩⟩
      exact ⟨⟨a*c-b*d, by simp [Complex.mul_re, ha, hb, hc, hd]⟩,
        ⟨a*d+b*c, by simp [Complex.mul_im, ha, hb, hc, hd]⟩⟩

theorem Claim9 {z : ℂ} (hz : GaussianRat z) :
    GaussianRat (star z) :=
    by
      rcases hz with ⟨⟨a, ha⟩, ⟨b, hb⟩⟩
      exact ⟨⟨a, by simpa using ha⟩, ⟨-b, by simp [hb]⟩⟩

theorem Claim10 {ι : Type*} (s : Finset ι) (f : ι → ℂ)
      (hf : ∀ i ∈ s, GaussianRat (f i)) :
    GaussianRat ((Finset.sum (s) (fun i => f i))) :=
    by
      classical
      induction s using Finset.induction_on with
      | empty => simpa using Claim2
      | @insert a s ha ih =>
        rw [Finset.sum_insert ha]
        exact Claim5 (hf a (Finset.mem_insert_self a s))
          (ih (fun i hi => hf i (Finset.mem_insert_of_mem hi)))

theorem Claim11 {ι : Type*} [Fintype ι] (f : ι → ℂ)
      (hf : ∀ i, GaussianRat (f i)) :
    GaussianRat ((Finset.sum Finset.univ (fun i => f i))) :=
    Claim10 Finset.univ f (fun i _ => hf i)

theorem Claim12 {ι κ η : Type*} [Fintype κ]
      (A : Matrix ι κ ℂ) (B : Matrix κ η ℂ)
      (hA : ∀ i j, GaussianRat (A i j)) (hB : ∀ i j, GaussianRat (B i j))
      (i : ι) (j : η) :
    GaussianRat ((A * B) i j) :=
    by
      exact Claim11 _ (fun k => Claim8 (hA i k) (hB k j))

theorem Claim13 {t : ℝ} (ht : IrrationalReal t) {q r : ℚ}
      (h : t * (q : ℝ) = (r : ℝ)) :
    q = 0 :=
    by
      by_contra hq
      apply ht (r/q)
      rw [Rat.cast_div]
      exact (eq_div_iff (Rat.cast_ne_zero.mpr hq)).2 h

theorem Claim14 {z : ℂ} {t : ℝ}
      (hz : GaussianRat z) (ht : IrrationalReal t)
      (htz : GaussianRat ((t : ℂ) * z)) :
    z = 0 :=
    by
      rcases hz with ⟨⟨a, ha⟩, ⟨b, hb⟩⟩
      rcases htz with ⟨⟨c, hc⟩, ⟨d, hd⟩⟩
      have hre : t * (a : ℝ) = (c : ℝ) := by
        simpa [Complex.mul_re, ha] using hc.symm
      have him : t * (b : ℝ) = (d : ℝ) := by
        simpa [Complex.mul_im, hb] using hd.symm
      have ha0 := Claim13 ht hre
      have hb0 := Claim13 ht him
      apply Complex.ext
      · rw [← ha, ha0]
        simp
      · rw [← hb, hb0]
        simp

theorem Claim15 :
  IrrationalReal (Real.sqrt 8) :=
  by
    intro q hq
    have hs : (q : ℝ) ^ 2 = (8 : ℝ) := by
      rw [← hq, Real.sq_sqrt (by norm_num)]
    have hrat : q ^ 2 = (8 : ℚ) := by
      apply Rat.cast_injective (α := ℝ)
      simpa only [Rat.cast_pow, Rat.cast_ofNat] using hs
    have hrat_square : IsSquare (8 : ℚ) := by
      exact ⟨q, by simpa only [pow_two] using hrat.symm⟩
    have hnat_square : IsSquare (8 : ℕ) :=
      (Rat.isSquare_natCast_iff (n := 8)).mp hrat_square
    obtain ⟨m, hm⟩ := hnat_square
    exact (Nat.not_exists_sq (m := 2) (n := 8) (by norm_num) (by norm_num))
      ⟨m, hm.symm⟩

theorem Claim16 :
  IrrationalReal (6 * Real.sqrt 8) :=
  by
    intro q hq
    apply Claim15 (q / 6)
    rw [Rat.cast_div, Rat.cast_ofNat]
    apply (eq_div_iff (by norm_num : (6 : ℝ) ≠ 0)).2
    simpa only [mul_comm] using hq

theorem Claim17 {ι : Type*} [Fintype ι]
      [DecidableEq ι] [Nonempty ι] (B : Matrix ι ι ℂ)
      (hB : ∀ i j, GaussianRat (B i j))
      (hpoly : B * B = ((6 * Real.sqrt 8 : ℝ) : ℂ) • B +
        (56 : ℂ) • (1 : Matrix ι ι ℂ)) :
    False :=
    by
      have hz : B = 0 := by
        ext i j
        apply Claim14 (hB i j) Claim16
        have hentry := congrArg (fun M : Matrix ι ι ℂ => M i j) hpoly
        have hprod := Claim12 B B hB hB i j
        have hid : GaussianRat ((56 : ℂ) * (1 : Matrix ι ι ℂ) i j) := by
          by_cases hij : i = j
          · simpa [Matrix.one_apply, hij] using Claim1 (56 : ℚ)
          · simpa [Matrix.one_apply, hij] using Claim2
        have hscaled : ((6 * Real.sqrt 8 : ℝ) : ℂ) * B i j =
            (B * B) i j - (56 : ℂ) * (1 : Matrix ι ι ℂ) i j := by
          apply eq_sub_iff_add_eq.mpr
          simpa only [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] using hentry.symm
        rw [hscaled]
        exact Claim7 hprod hid
      obtain ⟨i⟩ := ‹Nonempty ι›
      have hi := congrArg (fun M : Matrix ι ι ℂ => M i i) hpoly
      simp [hz] at hi

theorem Claim18 {ι : Type*} [Fintype ι]
      [DecidableEq ι] (R : Matrix ι ι ℂ) (hR : R * R = R) :
    let B := (Real.sqrt 8 : ℂ) • ((8 : ℂ) • R - 1); B * B = ((6 * Real.sqrt 8 : ℝ) : ℂ) • B + (56 : ℂ) • 1 :=
    by
      let C : Matrix ι ι ℂ := (8 : ℂ) • R - 1
      have hC : C * C = (6 : ℂ) • C + (7 : ℂ) • 1 := by
        dsimp [C]
        simp only [sub_mul, mul_sub, Matrix.smul_mul, Matrix.mul_smul,
          Matrix.mul_one, Matrix.one_mul, hR, smul_smul]
        ext i j
        simp only [Matrix.sub_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]
        ring
      have hs : (Real.sqrt 8 : ℂ) * (Real.sqrt 8 : ℂ) = 8 := by
        rw [← Complex.ofReal_mul, Real.mul_self_sqrt (by norm_num)]
        norm_num
      have h6s : ((6 * Real.sqrt 8 : ℝ) : ℂ) * (Real.sqrt 8 : ℂ) = 48 := by
        rw [Complex.ofReal_mul]
        calc
          (6 : ℂ) * (Real.sqrt 8 : ℂ) * (Real.sqrt 8 : ℂ) =
              6 * ((Real.sqrt 8 : ℂ) * (Real.sqrt 8 : ℂ)) := by ring
          _ = 48 := by rw [hs]; norm_num
      change ((Real.sqrt 8 : ℂ) • C) * ((Real.sqrt 8 : ℂ) • C) =
        ((6 * Real.sqrt 8 : ℝ) : ℂ) • ((Real.sqrt 8 : ℂ) • C) + (56 : ℂ) • 1
      rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul, hs, hC,
        smul_add, smul_smul, smul_smul, smul_smul, h6s]
      norm_num

theorem Claim19 {ι : Type*} [Fintype ι]
      [DecidableEq ι] [Nonempty ι] (R : Matrix ι ι ℂ)
      (hR : R * R = R)
      (hG : ∀ i j, GaussianRat
        (((Real.sqrt 8 : ℂ) • ((8 : ℂ) • R - 1)) i j)) :
    False :=
    by
      apply Claim17
        ((Real.sqrt 8 : ℂ) • ((8 : ℂ) • R - 1)) hG
      exact Claim18 R hR

theorem Claim20 :
  ∀ (i j : Fin 2),
    pauli1 0 i j = if i = j then 1 else 0 :=
  fun (i j : Fin 2) =>
    by
      fin_cases i <;> fin_cases j <;> norm_num [pauli1]

theorem Claim21 :
  ∀ (p : Fin 4) (i j : Fin 2),
    (starRingEnd ℂ) (pauli1 p i j) = pauli1 p j i :=
  fun (p : Fin 4) (i j : Fin 2) =>
    by
      fin_cases p <;> fin_cases i <;> fin_cases j <;> simp [pauli1]

theorem Claim22 :
  ∀ (i j k l : Fin 2),
    ((Finset.sum Finset.univ (fun (p : Fin 4) => pauli1 p k l * pauli1 p i j))) =
        if k = j ∧ l = i then 2 else 0 :=
  fun (i j k l : Fin 2) =>
    by
      fin_cases i <;> fin_cases j <;> fin_cases k <;> fin_cases l <;>
        norm_num [pauli1, Fin.sum_univ_succ, Complex.I_sq]

theorem Claim23 :
  ∀ (i j : (Fin 2 × Fin 2 × Fin 2)),
    pauli (0 : (Fin 4 × Fin 4 × Fin 4)) i j = if i = j then 1 else 0 :=
  fun (i j : (Fin 2 × Fin 2 × Fin 2)) =>
    by
      rcases i with ⟨i₁, i₂, i₃⟩
      rcases j with ⟨j₁, j₂, j₃⟩
      change pauli1 0 i₁ j₁ * pauli1 0 i₂ j₂ * pauli1 0 i₃ j₃ = _
      simp only [Claim20]
      split_ifs <;> simp_all [Prod.ext_iff]

theorem Claim24 :
  ∀ (rho : Matrix (Fin 2 × Fin 2 × Fin 2) (Fin 2 × Fin 2 × Fin 2) ℂ),
    coeff rho (0 : (Fin 4 × Fin 4 × Fin 4)) = Matrix.trace rho :=
  fun (rho : Matrix (Fin 2 × Fin 2 × Fin 2) (Fin 2 × Fin 2 × Fin 2) ℂ) =>
    by
      simp [coeff, Claim23, Matrix.trace]

theorem Claim25 :
  ∀ (p : (Fin 4 × Fin 4 × Fin 4)) (i j : (Fin 2 × Fin 2 × Fin 2)),
    (starRingEnd ℂ) (pauli p i j) = pauli p j i :=
  fun (p : (Fin 4 × Fin 4 × Fin 4)) (i j : (Fin 2 × Fin 2 × Fin 2)) =>
    by
      simp only [pauli, map_mul, Claim21]

theorem Claim26 :
  ∀ (A B C : Fin 4 → ℂ),
    ((Finset.sum Finset.univ (fun a => (Finset.sum Finset.univ (fun b => (Finset.sum Finset.univ (fun c => A a * (B b * C c)))))))) =
        ((Finset.sum Finset.univ (fun a => A a))) * ((Finset.sum Finset.univ (fun b => B b))) * ((Finset.sum Finset.univ (fun c => C c))) :=
  fun (A B C : Fin 4 → ℂ) =>
    by
      calc
        _ = (Finset.sum Finset.univ (fun a => A a * ((Finset.sum Finset.univ (fun b => B b * ((Finset.sum Finset.univ (fun c => C c)))))))) := by
          simp only [Finset.mul_sum]
        _ = (Finset.sum Finset.univ (fun a => A a * (((Finset.sum Finset.univ (fun b => B b))) * ((Finset.sum Finset.univ (fun c => C c)))))) := by
          simp only [Finset.sum_mul]
        _ = _ := by rw [← Finset.sum_mul, mul_assoc]

theorem Claim27 :
  ∀ (i j k l : (Fin 2 × Fin 2 × Fin 2)),
    ((Finset.sum Finset.univ (fun (p : (Fin 4 × Fin 4 × Fin 4)) => pauli p k l * pauli p i j))) =
        if k = j ∧ l = i then 8 else 0 :=
  fun (i j k l : (Fin 2 × Fin 2 × Fin 2)) =>
    by
      have h : ((Finset.sum Finset.univ (fun (p : (Fin 4 × Fin 4 × Fin 4)) => pauli p k l * pauli p i j))) =
          ((Finset.sum Finset.univ (fun (a : Fin 4) => pauli1 a k.1 l.1 * pauli1 a i.1 j.1))) *
          ((Finset.sum Finset.univ (fun (b : Fin 4) => pauli1 b k.2.1 l.2.1 * pauli1 b i.2.1 j.2.1))) *
          ((Finset.sum Finset.univ (fun (c : Fin 4) => pauli1 c k.2.2 l.2.2 * pauli1 c i.2.2 j.2.2))) := by
        calc
          _ = (Finset.sum Finset.univ (fun (a : Fin 4) => (Finset.sum Finset.univ (fun (b : Fin 4) => (Finset.sum Finset.univ (fun (c : Fin 4) => (pauli1 a k.1 l.1 * pauli1 a i.1 j.1) *
              ((pauli1 b k.2.1 l.2.1 * pauli1 b i.2.1 j.2.1) *
              (pauli1 c k.2.2 l.2.2 * pauli1 c i.2.2 j.2.2)))))))) := by
            simp only [pauli, Fintype.sum_prod_type]
            apply Finset.sum_congr rfl
            intro a _
            apply Finset.sum_congr rfl
            intro b _
            apply Finset.sum_congr rfl
            intro c _
            ring
          _ = _ := by
            exact Claim26 _ _ _

      rw [h]
      simp only [Claim22]
      split_ifs <;> simp_all [Prod.ext_iff]
      all_goals norm_num

theorem Claim28 :
  ∀ (rho : Matrix (Fin 2 × Fin 2 × Fin 2) (Fin 2 × Fin 2 × Fin 2) ℂ) (i j : (Fin 2 × Fin 2 × Fin 2)),
    ((Finset.sum Finset.univ (fun (p : (Fin 4 × Fin 4 × Fin 4)) => coeff rho p * pauli p i j))) = 8 * rho i j :=
  fun (rho : Matrix (Fin 2 × Fin 2 × Fin 2) (Fin 2 × Fin 2 × Fin 2) ℂ) (i j : (Fin 2 × Fin 2 × Fin 2)) =>
    by
      classical
      calc
        ((Finset.sum Finset.univ (fun (p : (Fin 4 × Fin 4 × Fin 4)) => coeff rho p * pauli p i j))) =
            (Finset.sum Finset.univ (fun (k : (Fin 2 × Fin 2 × Fin 2)) => (Finset.sum Finset.univ (fun (l : (Fin 2 × Fin 2 × Fin 2)) => ((Finset.sum Finset.univ (fun (p : (Fin 4 × Fin 4 × Fin 4)) => pauli p k l * pauli p i j))) * rho l k)))) := by
          simp only [coeff, Finset.sum_mul]
          rw [Finset.sum_comm]
          apply Finset.sum_congr rfl
          intro k _
          rw [Finset.sum_comm]
          apply Finset.sum_congr rfl
          intro l _
          apply Finset.sum_congr rfl
          intro p _
          ring
        _ = 8 * rho i j := by
          simp [Claim27, and_comm, ite_and]

theorem Claim29 (rho : Matrix (Fin 2 × Fin 2 × Fin 2) (Fin 2 × Fin 2 × Fin 2) ℂ)
      (h : ∀ i j, (starRingEnd ℂ) (rho i j) = rho j i) (p : (Fin 4 × Fin 4 × Fin 4)) :
    (starRingEnd ℂ) (coeff rho p) = coeff rho p :=
    by
      simp only [coeff, map_sum, map_mul, Claim25, h]
      rw [Finset.sum_comm]

theorem Claim30 :
  ∀ (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (i j : (Fin 2 × Fin 2 × Fin 2)),
    (starRingEnd ℂ) (pureDensity psi i j) = pureDensity psi j i :=
  fun (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (i j : (Fin 2 × Fin 2 × Fin 2)) =>
    by
      simp [pureDensity, map_mul, mul_comm]

theorem Claim31 :
  ∀ (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (p : (Fin 4 × Fin 4 × Fin 4)),
    (starRingEnd ℂ) (coeff (pureDensity psi) p) = coeff (pureDensity psi) p :=
  fun (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (p : (Fin 4 × Fin 4 × Fin 4)) =>
    Claim29 _ (Claim30 psi) p

theorem Claim32 :
  ∀ (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (p : (Fin 4 × Fin 4 × Fin 4)),
    (coeff (pureDensity psi) p).im = 0 :=
  fun (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (p : (Fin 4 × Fin 4 × Fin 4)) =>
    Complex.conj_eq_iff_im.mp (Claim31 psi p)

theorem Claim33 :
  ∀ (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (p : (Fin 4 × Fin 4 × Fin 4)),
    ((coeff (pureDensity psi) p).re : ℂ) = coeff (pureDensity psi) p :=
  fun (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (p : (Fin 4 × Fin 4 × Fin 4)) =>
    Complex.conj_eq_iff_re.mp (Claim31 psi p)

theorem Claim34 :
  ∀ (p : Fin 4) (i j : Fin 2),
    ∃ a b : ℤ, pauli1 p i j = (a : ℂ) + (b : ℂ) * Complex.I :=
  fun (p : Fin 4) (i j : Fin 2) =>
    by
      fin_cases p <;> fin_cases i <;> fin_cases j <;> norm_num [pauli1]
      all_goals first
        | (refine ⟨0, 0, ?_⟩; norm_num; done)
        | (refine ⟨1, 0, ?_⟩; norm_num; done)
        | (refine ⟨-1, 0, ?_⟩; norm_num; done)
        | (refine ⟨0, 1, ?_⟩; norm_num; done)
        | (refine ⟨0, -1, ?_⟩; norm_num)

theorem Claim35 {z w : ℂ}
      (hz : ∃ a b : ℤ, z = (a : ℂ) + (b : ℂ) * Complex.I)
      (hw : ∃ a b : ℤ, w = (a : ℂ) + (b : ℂ) * Complex.I) :
    ∃ a b : ℤ, z * w = (a : ℂ) + (b : ℂ) * Complex.I :=
    by
      obtain ⟨a, b, rfl⟩ := hz
      obtain ⟨c, d, rfl⟩ := hw
      refine ⟨a * c - b * d, a * d + b * c, ?_⟩
      simp only [Int.cast_add, Int.cast_sub, Int.cast_mul]
      ring_nf
      rw [Complex.I_sq]
      ring

theorem Claim36 :
  ∀ (p : (Fin 4 × Fin 4 × Fin 4)) (i j : (Fin 2 × Fin 2 × Fin 2)),
    ∃ a b : ℤ, pauli p i j = (a : ℂ) + (b : ℂ) * Complex.I :=
  fun (p : (Fin 4 × Fin 4 × Fin 4)) (i j : (Fin 2 × Fin 2 × Fin 2)) =>
    Claim35
        (Claim35 (Claim34 p.1 i.1 j.1)
          (Claim34 p.2.1 i.2.1 j.2.1))
        (Claim34 p.2.2 i.2.2 j.2.2)

theorem Claim37 :
  ∀ (p : (Fin 4 × Fin 4 × Fin 4)) (i j : (Fin 2 × Fin 2 × Fin 2)),
    ∃ a b : ℤ, (pauli p i j).re = (a : ℝ) ∧ (pauli p i j).im = (b : ℝ) :=
  fun (p : (Fin 4 × Fin 4 × Fin 4)) (i j : (Fin 2 × Fin 2 × Fin 2)) =>
    by
      obtain ⟨a, b, h⟩ := Claim36 p i j
      exact ⟨a, b, by simp [h]⟩

theorem Claim38 :
  ∀ {ι : Type*} [Fintype ι] (v : ι → ℂ),
    Matrix.trace (density v) = innerC v v :=
  fun {ι} [Fintype ι] (v : ι → ℂ) =>
    by
      unfold Matrix.trace Matrix.diag density innerC
      apply Finset.sum_congr rfl
      intro i hi
      ring

theorem Claim39 {ι : Type*} [Fintype ι] (v : ι → ℂ)
      (hn : innerC v v = 1) :
    density v * density v = density v :=
    by
      ext i j
      simp only [Matrix.mul_apply, density]
      calc
        ((Finset.sum Finset.univ (fun k => v i * star (v k) * (v k * star (v j))))) =
          v i * ((Finset.sum Finset.univ (fun k => star (v k) * v k))) * star (v j) := by
            simp only [Finset.mul_sum, Finset.sum_mul]
            apply Finset.sum_congr rfl
            intro k hk
            ring
        _ = v i * star (v j) := by
          change v i * innerC v v * star (v j) = _
          rw [hn, mul_one]

theorem Claim40 :
  ∀ {ι : Type*} [Fintype ι] (v : ι → ℂ) (A : Matrix ι ι ℂ),
    ((Finset.sum Finset.univ (fun i => (Finset.sum Finset.univ (fun j => A i j * density v j i))))) = innerC v (matAct A v) :=
  fun {ι} [Fintype ι] (v : ι → ℂ) (A : Matrix ι ι ℂ) =>
    by
      unfold innerC matAct density
      simp only [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro i hi
      apply Finset.sum_congr rfl
      intro j hj
      ring

theorem Claim41 (states : (Fin 4 × Fin 4 × Fin 4) → (Fin 2 × Fin 2 × Fin 2) → ℂ) (h : MUBPartition states)
      {p q : (Fin 4 × Fin 4 × Fin 4)} (hpq : p ≠ q) :
    Complex.normSq (innerC (states p) (states q)) = 0 ∨
      Complex.normSq (innerC (states p) (states q)) = (1/8 : ℝ) :=
    by
      obtain ⟨e, ho, hu⟩ := h
      obtain ⟨⟨b,j⟩, hp⟩ := e.surjective p
      obtain ⟨⟨c,k⟩, hq⟩ := e.surjective q
      by_cases hbc : b = c
      · subst c
        have hjk : j ≠ k := by
          intro hjk
          subst k
          exact hpq (hp.symm.trans hq)
        left
        rw [← hp, ← hq, ho, if_neg hjk]
        simp
      · right
        rw [← hp, ← hq]
        exact hu b c hbc j k

theorem Claim42 :
  ∀ (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ),
    matAct (pauli (0:(Fin 4 × Fin 4 × Fin 4))) psi = psi :=
  fun (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) =>
    by
      funext i
      simp [matAct, Claim23]

theorem Claim43 (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) :
    density psi = pureDensity psi :=
    rfl

theorem Claim44 :
  ∀ (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (p : (Fin 4 × Fin 4 × Fin 4)),
    coeff (density psi) p = innerC psi (matAct (pauli p) psi) :=
  fun (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (p : (Fin 4 × Fin 4 × Fin 4)) =>
    by
      exact Claim40 psi (pauli p)

theorem Claim45 (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (h : PauliOrbitMUB psi)
      (p : (Fin 4 × Fin 4 × Fin 4)) (hp : p ≠ 0) :
    Complex.normSq (coeff (density psi) p) = 0 ∨
      Complex.normSq (coeff (density psi) p) = (1/8 : ℝ) :=
    by
      have hh := Claim41 (fun q => matAct (pauli q) psi) h (Ne.symm hp)
      dsimp only at hh
      rw [Claim42, ← Claim44] at hh
      exact hh

theorem Claim46 :
  innerC computationalZero computationalZero = 1 :=
  by
    simp [innerC, computationalZero]

theorem Claim47 :
  ∃ psi : (Fin 2 × Fin 2 × Fin 2) → ℂ, innerC psi psi = 1 :=
  ⟨computationalZero, Claim46⟩

theorem Claim48 :
  Fintype.card (Fin 2 × Fin 2 × Fin 2) = 8 :=
  by norm_num

theorem Claim49 :
  Fintype.card (Fin 4 × Fin 4 × Fin 4) = 64 :=
  by norm_num

theorem Claim50 :
  ∀ (p : (Fin 4 × Fin 4 × Fin 4)) (i j : (Fin 2 × Fin 2 × Fin 2)),
    GaussianRat (pauli p i j) :=
  fun (p : (Fin 4 × Fin 4 × Fin 4)) (i j : (Fin 2 × Fin 2 × Fin 2)) =>
    by
      obtain ⟨a,b,ha,hb⟩ := Claim37 p i j
      exact ⟨⟨(a:ℚ), by simpa using ha.symm⟩, ⟨(b:ℚ), by simpa using hb.symm⟩⟩

theorem Claim51 (z : ℂ) (hi : z.im = 0)
      (hz : Complex.normSq z = 0 ∨ Complex.normSq z = (1/8:ℝ)) :
    GaussianRat ((Real.sqrt 8 : ℂ) * z) :=
    by
      rcases hz with hz | hz
      · have hzero : z = 0 := Complex.normSq_eq_zero.mp hz
        simpa [hzero] using Claim2
      · have hre : z.re ^ 2 = (1/8:ℝ) := by
          simpa [Complex.normSq_apply, hi, pow_two] using hz
        have hs : (Real.sqrt 8 * z.re) ^ 2 = (1:ℝ) ^ 2 := by
          rw [mul_pow, Real.sq_sqrt (by norm_num), hre]
          norm_num
        rcases (sq_eq_sq_iff_eq_or_eq_neg.mp hs) with hp | hn
        · refine ⟨⟨1, ?_⟩, ⟨0, ?_⟩⟩
          · simpa [Complex.mul_re] using hp.symm
          · simp [Complex.mul_im, hi]
        · refine ⟨⟨-1, ?_⟩, ⟨0, ?_⟩⟩
          · simpa [Complex.mul_re] using hn.symm
          · simp [Complex.mul_im, hi]

-- Retain the original trace premise in the public theorem interface.
set_option linter.unusedVariables false in
theorem Claim52 (rho : Matrix (Fin 2 × Fin 2 × Fin 2) (Fin 2 × Fin 2 × Fin 2) ℂ)
      (htr : Matrix.trace rho = 1) (i j : (Fin 2 × Fin 2 × Fin 2)) :
    ((Finset.sum Finset.univ (fun (p : (Fin 4 × Fin 4 × Fin 4)) => ((Real.sqrt 8 : ℂ) *
        (coeff rho p - if p = 0 then 1 else 0)) * pauli p i j))) =
        ((Real.sqrt 8 : ℂ) • ((8:ℂ) • rho - 1)) i j :=
    by
      classical
      simp only [Matrix.smul_apply, Matrix.sub_apply, smul_eq_mul]
      calc
        ((Finset.sum Finset.univ (fun (p : (Fin 4 × Fin 4 × Fin 4)) => ((Real.sqrt 8 : ℂ) *
          (coeff rho p - if p = 0 then 1 else 0)) * pauli p i j))) =
          (Real.sqrt 8 : ℂ) * (((Finset.sum Finset.univ (fun (p : (Fin 4 × Fin 4 × Fin 4)) => coeff rho p * pauli p i j))) - pauli 0 i j) := by
            simp only [mul_sub, sub_mul, Finset.sum_sub_distrib, ← Finset.mul_sum, mul_assoc]
            simp
        _ = _ := by rw [Claim28, Claim23]; rfl

theorem Claim53 (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (hn : innerC psi psi = 1)
      (hf : ∀ p : (Fin 4 × Fin 4 × Fin 4), p ≠ 0 →
        Complex.normSq (coeff (density psi) p) = 0 ∨
        Complex.normSq (coeff (density psi) p) = (1/8:ℝ)) :
    ∀ i j, GaussianRat (((Real.sqrt 8 : ℂ) • ((8:ℂ) • density psi - 1)) i j) :=
    by
      intro i j
      rw [← Claim52 (density psi) (by rw [Claim38, hn]) i j]
      apply Claim11
      intro p
      apply Claim8
      · by_cases hp : p = 0
        · subst p
          rw [Claim24, Claim38, hn]
          simpa using Claim2
        · rw [if_neg hp, sub_zero]
          apply Claim51
          · simpa [Claim43] using Claim32 psi p
          · exact hf p hp
      · exact Claim50 p i j

theorem Claim54 (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (hn : innerC psi psi = 1) :
    ¬ (∀ p : (Fin 4 × Fin 4 × Fin 4), p ≠ 0 →
        Complex.normSq (coeff (density psi) p) = 0 ∨
        Complex.normSq (coeff (density psi) p) = (1/8:ℝ)) :=
    by
      intro hf
      exact Claim19 (density psi) (Claim39 psi hn)
        (Claim53 psi hn hf)

theorem Claim55 (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ) (hn : innerC psi psi = 1) :
    ¬ PauliOrbitMUB psi :=
    by
      intro h
      exact Claim54 psi hn (Claim45 psi h)

theorem Claim56 :
  ∀ {ι : Type*} [Fintype ι]
      (u v : ι → ℂ) (a b : ℂ),
    innerC (fun i => a * u i) (fun i => b * v i) =
        (star a * b) * innerC u v :=
  fun {ι} [Fintype ι]
      (u v : ι → ℂ) (a b : ℂ) =>
    by
      unfold innerC
      calc
        ((Finset.sum Finset.univ (fun i => star (a * u i) * (b * v i)))) =
            (Finset.sum Finset.univ (fun i => (star a * b) * (star (u i) * v i))) := by
          apply Finset.sum_congr rfl
          intro i _
          simp only [star_mul]
          ring
        _ = _ := by rw [← Finset.mul_sum]

theorem Claim57 {ι : Type*} [Fintype ι]
      (u v : ι → ℂ) (a b : ℂ)
      (ha : Complex.normSq a = 1) (hb : Complex.normSq b = 1) :
    Complex.normSq (innerC (fun i => a * u i) (fun i => b * v i)) =
        Complex.normSq (innerC u v) :=
    by
      simp [Claim56, Complex.normSq_mul, Complex.star_def,
        Complex.normSq_conj, ha, hb]

theorem Claim58 (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ)
      (h : phaseAdjustedOrbitMUB psi) (p : (Fin 4 × Fin 4 × Fin 4)) (hp : p ≠ 0) :
    Complex.normSq (coeff (density psi) p) = 0 ∨
      Complex.normSq (coeff (density psi) p) = (1/8 : ℝ) :=
    by
      obtain ⟨c, hc, hm⟩ := h
      have hh := Claim41
        (fun q i => c q * matAct (pauli q) psi i) hm (Ne.symm hp)
      rw [Claim57 _ _ _ _ (hc 0) (hc p)] at hh
      rw [Claim42, ← Claim44] at hh
      exact hh

theorem Claim59 (psi : (Fin 2 × Fin 2 × Fin 2) → ℂ)
      (hn : innerC psi psi = 1) :
    ¬ phaseAdjustedOrbitMUB psi :=
    by
      intro h
      exact Claim54 psi hn (Claim58 psi h)

end EDEGFormalization

-- Collect dependencies of all declarations created in this module, including compiler auxiliaries.
open Lean in
run_cmd do
  let env ← getEnv
  let mut entries : Array (String × Array String) := #[]
  for (name, _) in env.constants.map₂.toList do
    let axioms ← Lean.collectAxioms name
    entries := entries.push (name.toString, axioms.map Name.toString)
  logInfo m!"EDEG_KERNEL_AXIOMS: {(toJson entries).compress}"
