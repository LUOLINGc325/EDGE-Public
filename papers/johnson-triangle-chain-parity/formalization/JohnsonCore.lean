import Mathlib.Data.Finset.Card
import Mathlib.Data.Finset.Powerset
import Mathlib.Data.Finset.Image
import Mathlib.Data.Fintype.Basic
import Lean.Elab.Tactic.Omega

/-! Elementary Johnson adjacency on arbitrary finite sets. No cardinal bound on the
    ground type, and no bound on the number of represented vertices, is imposed. -/
namespace Review15Johnson
open Finset
variable {α : Type*} [DecidableEq α]

def Adj (X Y : Finset α) : Prop := (X \ Y).card = 1 ∧ (Y \ X).card = 1

def Replace (X Y : Finset α) (a b : α) : Prop :=
  a ∈ X ∧ b ∉ X ∧ Y = insert b (X.erase a)

theorem adj_symm {X Y : Finset α} (h : Adj X Y) : Adj Y X := ⟨h.2,h.1⟩

theorem adj_ne {X Y : Finset α} (h : Adj X Y) : X ≠ Y := by
  intro he
  subst Y
  simp [Adj] at h

theorem adj_card {X Y : Finset α} (h : Adj X Y) : X.card = Y.card := by
  have h1 := card_sdiff_add_card_inter X Y
  have h2 := card_sdiff_add_card_inter Y X
  rw [inter_comm Y X] at h2
  rcases h with ⟨hxy,hyx⟩
  omega

theorem adj_exists_replace {X Y : Finset α} (h : Adj X Y) :
    ∃ a b, Replace X Y a b := by
  rcases card_eq_one.mp h.1 with ⟨a,ha⟩
  rcases card_eq_one.mp h.2 with ⟨b,hb⟩
  have ha' : a ∈ X ∧ a ∉ Y := by
    have hh : a ∈ X \ Y := by rw [ha]; simp
    simpa using hh
  have hb' : b ∈ Y ∧ b ∉ X := by
    have hh : b ∈ Y \ X := by rw [hb]; simp
    simpa using hh
  refine ⟨a,b,ha'.1,hb'.2,?_⟩
  ext x
  have hx : x ∈ X \ Y ↔ x = a := by rw [ha]; simp
  have hy : x ∈ Y \ X ↔ x = b := by rw [hb]; simp
  simp only [mem_sdiff] at hx hy
  simp only [mem_insert,mem_erase]
  by_cases hxX : x ∈ X <;> by_cases hxY : x ∈ Y <;> simp_all

theorem adj_of_replace {X Y : Finset α} {a b : α} (h : Replace X Y a b) : Adj X Y := by
  rcases h with ⟨ha,hb,rfl⟩
  have hba : b ≠ a := by intro h; subst b; exact hb ha
  have h1 : X \ insert b (X.erase a) = {a} := by
    ext x
    simp only [mem_sdiff,mem_insert,mem_erase,mem_singleton]
    aesop
  have h2 : insert b (X.erase a) \ X = {b} := by
    ext x
    simp only [mem_sdiff,mem_insert,mem_erase,mem_singleton]
    aesop
  simp [Adj,h1,h2]

theorem replace_sdiff {X Y : Finset α} {a b : α} (h : Replace X Y a b) :
    X \ Y = {a} ∧ Y \ X = {b} := by
  rcases h with ⟨ha,hb,rfl⟩
  constructor <;> ext x <;> simp only [mem_sdiff,mem_insert,mem_erase,mem_singleton] <;> aesop

theorem replace_mem_new {X Y : Finset α} {a b : α} (h : Replace X Y a b) : b ∈ Y := by
  rw [h.2.2]; simp

theorem replace_not_mem_old {X Y : Finset α} {a b : α} (h : Replace X Y a b) : a ∉ Y := by
  have hba : a ≠ b := by intro hh; exact h.2.1 (hh ▸ h.1)
  rw [h.2.2]
  simp [hba]

theorem replace_same_removed {X Y Z : Finset α} {a b d : α}
    (hy : Replace X Y a b) (hz : Replace X Z a d) : Y = Z ∨ Adj Y Z := by
  by_cases hbd : b = d
  · left; rw [hy.2.2,hz.2.2,hbd]
  · right
    apply adj_of_replace (a:=b) (b:=d)
    refine ⟨replace_mem_new hy,?_,?_⟩
    · rw [hy.2.2]; simp [Ne.symm hbd,hz.2.1]
    · rw [hy.2.2,hz.2.2]
      have hb : b ∉ X.erase a := by simp [hy.2.1]
      simp [hb]

theorem replace_same_added {X Y Z : Finset α} {a c b : α}
    (hy : Replace X Y a b) (hz : Replace X Z c b) : Y = Z ∨ Adj Y Z := by
  by_cases hac : a = c
  · left; rw [hy.2.2,hz.2.2,hac]
  · right
    apply adj_of_replace (a:=c) (b:=a)
    refine ⟨?_,replace_not_mem_old hy,?_⟩
    · rw [hy.2.2]; simp [Ne.symm hac,hz.1]
    · rw [hy.2.2,hz.2.2]
      ext x
      simp only [mem_insert,mem_erase]
      have hab : a ≠ b := by intro h; subst a; exact hy.2.1 hy.1
      have hcb : c ≠ b := by intro h; subst c; exact hz.2.1 hz.1
      have ha := hy.1
      have hc := hz.1
      by_cases hxa : x = a <;> by_cases hxb : x = b <;> by_cases hxc : x = c <;> simp_all

/-- Neighbors of a fixed set that change the same coordinate in the same
    direction form a clique (allowing equality). -/
theorem common_changed_coordinate {X Y Z : Finset α} {b : α}
    (hxy : Adj X Y) (hxz : Adj X Z)
    (hchange : (b ∉ X ∧ b ∈ Y ∧ b ∈ Z) ∨ (b ∈ X ∧ b ∉ Y ∧ b ∉ Z)) :
    Y = Z ∨ Adj Y Z := by
  obtain ⟨a,c,hy⟩ := adj_exists_replace hxy
  obtain ⟨d,e,hz⟩ := adj_exists_replace hxz
  have hyDiff := replace_sdiff hy
  have hzDiff := replace_sdiff hz
  rcases hchange with ⟨hbX,hbY,hbZ⟩ | ⟨hbX,hbY,hbZ⟩
  · have hbc : b = c := by
      have hh : b ∈ Y \ X := by simp [hbY,hbX]
      rw [hyDiff.2] at hh; simpa using hh
    have hbe : b = e := by
      have hh : b ∈ Z \ X := by simp [hbZ,hbX]
      rw [hzDiff.2] at hh; simpa using hh
    subst c; subst e
    exact replace_same_added hy hz
  · have hba : b = a := by
      have hh : b ∈ X \ Y := by simp [hbX,hbY]
      rw [hyDiff.1] at hh; simpa using hh
    have hbd : b = d := by
      have hh : b ∈ X \ Z := by simp [hbX,hbZ]
      rw [hzDiff.1] at hh; simpa using hh
    subst a; subst d
    exact replace_same_removed hy hz

/-- Two adjacent neighbors of X either remove the same coordinate or add the
    same coordinate. This is proved from singleton differences, not assumed. -/
theorem triangle_replacements {X Y Z : Finset α} {a b c d : α}
    (hy : Replace X Y a b) (hz : Replace X Z c d) (hyz : Adj Y Z) : a = c ∨ b = d := by
  by_contra hn
  have hac : a ≠ c := by intro h; exact hn (Or.inl h)
  have hbd : b ≠ d := by intro h; exact hn (Or.inr h)
  have hc : c ∈ Y \ Z := by
    simp only [mem_sdiff]
    refine ⟨?_,replace_not_mem_old hz⟩
    rw [hy.2.2]; simp [Ne.symm hac,hz.1]
  have hb : b ∈ Y \ Z := by
    refine mem_sdiff.mpr ⟨replace_mem_new hy,?_⟩
    rw [hz.2.2]; simp [hbd,hy.2.1]
  have hbc : b = c := card_le_one.mp (Nat.le_of_eq hyz.1) b hb c hc
  exact hy.2.1 (hbc ▸ hz.1)

/-- Every represented triangle has a coordinate whose membership alternates
    on its three ordered vertices. -/
theorem triangle_alternating_element {X Y Z : Finset α}
    (hxy : Adj X Y) (hxz : Adj X Z) (hyz : Adj Y Z) :
    ∃ b, (b ∉ X ∧ b ∈ Y ∧ b ∉ Z) ∨ (b ∈ X ∧ b ∉ Y ∧ b ∈ Z) := by
  obtain ⟨a,b,hy⟩ := adj_exists_replace hxy
  obtain ⟨c,d,hz⟩ := adj_exists_replace hxz
  rcases triangle_replacements hy hz hyz with hac | hbd
  · subst c
    have hbd : b ≠ d := by
      intro h
      apply adj_ne hyz
      rw [hy.2.2,hz.2.2,h]
    refine ⟨b,Or.inl ⟨hy.2.1,replace_mem_new hy,?_⟩⟩
    rw [hz.2.2]; simp [hbd,hy.2.1]
  · subst d
    have hac : a ≠ c := by
      intro h
      apply adj_ne hyz
      rw [hy.2.2,hz.2.2,h]
    refine ⟨a,Or.inr ⟨hy.1,replace_not_mem_old hy,?_⟩⟩
    rw [hz.2.2]; simp [hac,hy.1]

/-- In an induced diamond, a changed coordinate must propagate across the
    nonedge. This supplies the all-length triangle-chain induction. -/
theorem diamond_coordinate {A B D : Finset α} {b : α}
    (hab : Adj A B) (hbd : Adj B D) (hne : A ≠ D) (hnadj : ¬ Adj A D)
    (hchange : ¬ (b ∈ A ↔ b ∈ B)) : (b ∈ D ↔ b ∈ B) := by
  by_contra hn
  have hc : (b ∉ B ∧ b ∈ A ∧ b ∈ D) ∨ (b ∈ B ∧ b ∉ A ∧ b ∉ D) := by
    by_cases hA : b ∈ A <;> by_cases hB : b ∈ B <;> by_cases hD : b ∈ D <;> aesop
  rcases common_changed_coordinate (adj_symm hab) hbd hc with he | he
  · exact hne he
  · exact hnadj he

end Review15Johnson
