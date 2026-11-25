import Core
import Mathlib.Tactic.Choose
import Mathlib.Tactic.Push

set_option autoImplicit false

namespace ProperHats

/-- A root color is surviving if it is proper and makes all leaves wrong. -/
def Candidate {r q : Nat} (A B : Fin r → Fin q → Fin q → Fin q)
    (x : Views r q) (c : Fin q) : Prop :=
  Proper c x ∧ ∀ i, A i c (x i).2 ≠ (x i).1 ∧ B i c (x i).1 ≠ (x i).2

theorem candidate_unique {r q : Nat}
    {A B : Fin r → Fin q → Fin q → Fin q}
    (hcover : PairCover A B) {x : Views r q} {c d : Fin q}
    (hc : Candidate A B x c) (hd : Candidate A B x d) : c = d := by
  by_contra hne
  obtain ⟨i, hi⟩ := hcover c d hne
  have he := hi (x i).1 (x i).2 (hc.1 i).1 (hc.1 i).2.1
    (hd.1 i).1 (hd.1 i).2.1 (hc.1 i).2.2
  rcases he with h | h | h | h
  · exact (hc.2 i).1 h
  · exact (hc.2 i).2 h
  · exact (hd.2 i).1 h
  · exact (hd.2 i).2 h

/-- This decoder depends only on the leaf colors, never on the actual root. -/
noncomputable def decoder {r q : Nat} (hq : 0 < q)
    (A B : Fin r → Fin q → Fin q → Fin q) (x : Views r q) : Fin q := by
  classical
  exact if h : ∃ c, Candidate A B x c then Classical.choose h else ⟨0, hq⟩

theorem solvable_of_pair_cover {r q : Nat} (hq : 0 < q)
    (A B : Fin r → Fin q → Fin q → Fin q) (hcover : PairCover A B) :
    Solvable r q := by
  classical
  refine ⟨⟨A, B, decoder hq A B⟩, ?_⟩
  intro c x hp
  by_cases hwin : ∃ i, A i c (x i).2 = (x i).1 ∨ B i c (x i).1 = (x i).2
  · exact Or.inr hwin
  · apply Or.inl
    have hc : Candidate A B x c := by
      refine ⟨hp, fun i => ⟨?_, ?_⟩⟩
      · intro h; exact hwin ⟨i, Or.inl h⟩
      · intro h; exact hwin ⟨i, Or.inr h⟩
    have hex : ∃ d, Candidate A B x d := ⟨c, hc⟩
    change decoder hq A B x = c
    rw [decoder, dif_pos hex]
    exact candidate_unique hcover (Classical.choose_spec hex) hc


/-- A winning center forces every all-leaf-failure view to have at most one root. -/
theorem candidate_unique_of_wins {r q : Nat} (s : Strategy r q) (hw : Wins s)
    {x : Views r q} {c d : Fin q}
    (hc : Candidate s.left s.right x c) (hd : Candidate s.left s.right x d) : c = d := by
  have root_eq (e : Fin q) (he : Candidate s.left s.right x e) : s.center x = e := by
    rcases hw e x he.1 with h | ⟨i, h | h⟩
    · exact h
    · exact ((he.2 i).1 h).elim
    · exact ((he.2 i).2 h).elim
  exact (root_eq c hc).symm.trans (root_eq d hd)

/-- Product independence across petals supplies the converse separation criterion. -/
theorem pair_cover_of_unique {r q : Nat}
    {A B : Fin r → Fin q → Fin q → Fin q}
    (hu : ∀ (x : Views r q) (c d : Fin q),
      Candidate A B x c → Candidate A B x d → c = d) : PairCover A B := by
  classical
  intro c d hne
  by_contra hn
  have hpairs : ∀ i : Fin r, ∃ p : Fin q × Fin q,
      (c ≠ p.1 ∧ c ≠ p.2 ∧ p.1 ≠ p.2) ∧
      (d ≠ p.1 ∧ d ≠ p.2 ∧ p.1 ≠ p.2) ∧
      (A i c p.2 ≠ p.1 ∧ B i c p.1 ≠ p.2) ∧
      (A i d p.2 ≠ p.1 ∧ B i d p.1 ≠ p.2) := by
    intro i
    have hi : ¬ (∀ a b : Fin q, c ≠ a → c ≠ b → d ≠ a → d ≠ b → a ≠ b →
      A i c b = a ∨ B i c a = b ∨ A i d b = a ∨ B i d a = b) := by
      intro hi
      exact hn ⟨i, hi⟩
    push_neg at hi
    obtain ⟨a, b, hca, hcb, hda, hdb, hab, hAc, hBc, hAd, hBd⟩ := hi
    exact ⟨(a, b), ⟨hca, hcb, hab⟩, ⟨hda, hdb, hab⟩, ⟨hAc, hBc⟩, ⟨hAd, hBd⟩⟩
  choose x hx using hpairs
  have hc : Candidate A B x c := ⟨fun i => (hx i).1, fun i => (hx i).2.2.1⟩
  have hd : Candidate A B x d := ⟨fun i => (hx i).2.1, fun i => (hx i).2.2.2⟩
  exact hne (hu x c d hc hd)

theorem pair_cover_iff_unique {r q : Nat} (A B : Fin r → Fin q → Fin q → Fin q) :
    PairCover A B ↔ ∀ (x : Views r q) (c d : Fin q),
      Candidate A B x c → Candidate A B x d → c = d := by
  constructor
  · intro h x c d hc hd
    exact candidate_unique h hc hd
  · exact pair_cover_of_unique

/-- Fixed leaf rules admit a winning center exactly when all survivor sets are singletons or empty. -/
theorem completion_iff_unique {r q : Nat} (hq : 0 < q)
    (A B : Fin r → Fin q → Fin q → Fin q) :
    (∃ h : Views r q → Fin q, Wins ⟨A, B, h⟩) ↔
      ∀ (x : Views r q) (c d : Fin q), Candidate A B x c → Candidate A B x d → c = d := by
  classical
  constructor
  · rintro ⟨h, hh⟩ x c d hc hd
    exact candidate_unique_of_wins ⟨A, B, h⟩ hh hc hd
  · intro hu
    refine ⟨decoder hq A B, ?_⟩
    intro c x hp
    by_cases hl : ∃ i, A i c (x i).2 = (x i).1 ∨ B i c (x i).1 = (x i).2
    · exact Or.inr hl
    · apply Or.inl
      have hc : Candidate A B x c := by
        refine ⟨hp, fun i => ⟨?_, ?_⟩⟩
        · intro h; exact hl ⟨i, Or.inl h⟩
        · intro h; exact hl ⟨i, Or.inr h⟩
      have hex : ∃ d, Candidate A B x d := ⟨c, hc⟩
      change decoder hq A B x = c
      rw [decoder, dif_pos hex]
      exact hu x _ c (Classical.choose_spec hex) hc

theorem completion_iff_pair_cover {r q : Nat} (hq : 0 < q)
    (A B : Fin r → Fin q → Fin q → Fin q) :
    (∃ h : Views r q → Fin q, Wins ⟨A, B, h⟩) ↔ PairCover A B := by
  rw [completion_iff_unique hq, pair_cover_iff_unique]

/-- Extra triangles can be ignored by a winning strategy. -/
theorem solvable_mono_petals {r s q : Nat} (hrs : r ≤ s) :
    Solvable r q → Solvable s q := by
  rintro ⟨S, hS⟩
  let e : Fin r → Fin s := Fin.castLE hrs
  let T : Strategy s q := {
    left := fun i c b => if h : i.val < r then S.left ⟨i.val, h⟩ c b else c
    right := fun i c a => if h : i.val < r then S.right ⟨i.val, h⟩ c a else c
    center := fun x => S.center (fun i => x (e i)) }
  refine ⟨T, ?_⟩
  intro c x hp
  have hp' : Proper c (fun i : Fin r => x (e i)) := fun i => hp (e i)
  rcases hS c (fun i => x (e i)) hp' with hc | ⟨i, hi⟩
  · exact Or.inl hc
  · apply Or.inr
    refine ⟨e i, ?_⟩
    simpa [T, e, i.isLt] using hi

/-- Restricting the palette cannot destroy a winning strategy.
Outputs outside the smaller palette are replaced by its color zero. -/
theorem solvable_mono_colors {r q k : Nat} (hk : 0 < k) (hkq : k ≤ q) :
    Solvable r q → Solvable r k := by
  rintro ⟨S, hS⟩
  let e : Fin k → Fin q := Fin.castLE hkq
  let down : Fin q → Fin k := fun z => if h : z.val < k then ⟨z.val, h⟩ else ⟨0, hk⟩
  have down_e (c : Fin k) : down (e c) = c := by
    simp [down, e, c.isLt]
  have einj : Function.Injective e := by
    intro a b hab
    apply Fin.ext
    exact congrArg (fun z : Fin q => z.val) hab
  let lift : Views r k → Views r q := fun x i => (e (x i).1, e (x i).2)
  let T : Strategy r k := {
    left := fun i c b => down (S.left i (e c) (e b))
    right := fun i c a => down (S.right i (e c) (e a))
    center := fun x => down (S.center (lift x)) }
  refine ⟨T, ?_⟩
  intro c x hp
  have hp' : Proper (e c) (lift x) := by
    intro i
    exact ⟨fun h => (hp i).1 (einj h), fun h => (hp i).2.1 (einj h),
      fun h => (hp i).2.2 (einj h)⟩
  rcases hS (e c) (lift x) hp' with hc | ⟨i, hi⟩
  · apply Or.inl
    change down (S.center (lift x)) = c
    rw [hc, down_e]
  · apply Or.inr
    refine ⟨i, ?_⟩
    rcases hi with h | h
    · apply Or.inl
      change down (S.left i (e c) (e (x i).2)) = (x i).1
      change S.left i (e c) (e (x i).2) = e (x i).1 at h
      rw [h, down_e]
    · apply Or.inr
      change down (S.right i (e c) (e (x i).1)) = (x i).2
      change S.right i (e c) (e (x i).1) = e (x i).2 at h
      rw [h, down_e]

def Optimal (r q : Nat) : Prop := Solvable r q ∧ ∀ k, Solvable r k → k ≤ q

end ProperHats

-- Audit every declaration created in this module, including compiler auxiliaries.
open Lean in
run_cmd do
  let env ← getEnv
  let mut entries : Array (String × Array String) := #[]
  for (name, _) in env.constants.map₂.toList do
    let axioms ← Lean.collectAxioms name
    entries := entries.push (name.toString, axioms.map Name.toString)
  logInfo m!"EDEG_KERNEL_AXIOMS: {(toJson entries).compress}"
