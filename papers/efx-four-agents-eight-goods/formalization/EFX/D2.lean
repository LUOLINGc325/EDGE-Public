import EFX.FiniteInsertion
import Mathlib.Data.Fin.VecNotation
import Mathlib.Tactic.FinCases

/-! The four-agent D2 repair, starting from a nonempty three-agent EFX allocation. -/

namespace EFXResearch

universe u v
variable {Value : Type u} {G : Type v} [DecidableEq G]

abbrev FourValues (G : Type v) (Value : Type u) :=
  Fin 4 → Finset G → Value

def PairDominates (O : ValueOrder Value) (v : FourValues G Value)
    (U : Finset G) (g : G) : Prop :=
  ∀ i ⦃S⦄, S ⊆ U.erase g → S.card ≤ 2 → O.le (v i S) (v i {g})

def FourEFX (O : ValueOrder Value) (v : FourValues G Value) (U : Finset G) : Prop :=
  ∃ A : Fin 4 → Finset G,
    (∀ x, x ∈ U ↔ ∃ i, x ∈ A i) ∧
    (∀ i j, i ≠ j → Disjoint (A i) (A j)) ∧
    ∀ i j, EFXAgainst O (v i) (A i) (A j)

/-- Any proper subset of an envied bundle fits in one of its one-item deletions. -/
private theorem boundByOldBundle (O : ValueOrder Value) (v : Finset G → Value)
    (hv : FiniteMonotone O v) {P Q S : Finset G}
    (hefx : EFXAgainst O v P Q) (hsub : S ⊆ Q) (hcard : S.card < Q.card) :
    O.le (v S) (v P) := by
  have hnot : ¬ Q ⊆ S := fun h => (Nat.not_le_of_lt hcard) (Finset.card_le_card h)
  have hex : ∃ x ∈ Q, x ∉ S := by
    by_contra h
    apply hnot
    intro x hx
    by_contra hnx
    exact h ⟨x, hx, hnx⟩
  obtain ⟨x, hx, hnx⟩ := hex
  exact O.trans (hv (Finset.subset_erase.mpr ⟨hsub, hnx⟩)) (hefx hx)

private theorem efxSingleton (O : ValueOrder Value) (v : Finset G → Value)
    (hv : FiniteMonotone O v) (S : Finset G) (g : G) :
    EFXAgainst O v S {g} := by
  intro x hx
  obtain rfl := Finset.mem_singleton.mp hx
  simpa using hv (Finset.empty_subset S)

private theorem efxSmall (O : ValueOrder Value) (v : FourValues G Value)
    {U : Finset G} {g : G} (hd : PairDominates O v U g) (i : Fin 4)
    {P T : Finset G} (hfloor : O.le (v i {g}) (v i P))
    (hsub : T ⊆ U.erase g) (hcard : T.card ≤ 3) :
    EFXAgainst O (v i) P T := by
  intro x hx
  have hcount := Finset.card_erase_add_one hx
  exact O.trans (hd i (Finset.erase_subset _ _ |>.trans hsub) (by omega)) hfloor

private theorem partitionOfFour {U S T P Q : Finset G}
    (hcover : S ∪ T ∪ P ∪ Q = U)
    (hst : Disjoint S T) (hsp : Disjoint S P) (hsq : Disjoint S Q)
    (htp : Disjoint T P) (htq : Disjoint T Q) (hpq : Disjoint P Q) :
    (∀ x, x ∈ U ↔ ∃ i : Fin 4, x ∈ (![S, T, P, Q] : Fin 4 → Finset G) i) ∧
    (∀ i j : Fin 4, i ≠ j →
      Disjoint ((![S, T, P, Q] : Fin 4 → Finset G) i) (![S, T, P, Q] j)) := by
  constructor
  · intro x
    rw [← hcover]
    simp [Fin.exists_fin_succ]
  · intro i j hij
    fin_cases i <;> fin_cases j <;>
      first | contradiction | assumption | exact hst.symm | exact hsp.symm |
        exact hsq.symm | exact htp.symm | exact htq.symm | exact hpq.symm

private theorem singletonDisjoint {g : G} {S U : Finset G} (h : S ⊆ U.erase g) :
    Disjoint {g} S := by
  apply Finset.disjoint_singleton_left.mpr
  exact fun hg => (Finset.notMem_erase g U) (h hg)

private theorem weakenEFX (O : ValueOrder Value) (v : Finset G → Value)
    (hv : FiniteMonotone O v) {P T : Finset G} (h : O.le (v T) (v P)) :
    EFXAgainst O v P T :=
  fun _ _ => O.trans (hv (Finset.erase_subset _ _)) h

/-- Complete the four-way comparisons after the two local agents are repaired.
    The distinguished good may go to either of the two remaining agents. -/
private theorem assemble (O : ValueOrder Value) (v : FourValues G Value)
    (hm : ∀ i, FiniteMonotone O (v i)) {U H R I J : Finset G} {g : G}
    (hg : g ∈ U) (hd : PairDominates O v U g)
    (hrest : H ∪ R = U.erase g) (hdj : Disjoint H R)
    (out : Completion O (v 2) (v 3) R I J)
    (hsmall : R.card ≤ 4)
    (h2H : O.le (v 2 H) (v 2 I)) (h3H : O.le (v 3 H) (v 3 J))
    (place : (EFXAgainst O (v 0) {g} H ∧ O.le (v 1 {g}) (v 1 H)) ∨
      (EFXAgainst O (v 1) {g} H ∧ O.le (v 0 {g}) (v 0 H))) :
    FourEFX O v U := by
  have hHsub : H ⊆ U.erase g := hrest ▸ Finset.subset_union_left
  have hRsub : R ⊆ U.erase g := hrest ▸ Finset.subset_union_right
  have hL : out.left ⊆ R := by
    intro x hx
    rw [← out.cover]
    exact Finset.mem_union_left _ hx
  have hR : out.right ⊆ R := by
    intro x hx
    rw [← out.cover]
    exact Finset.mem_union_right _ hx
  have hcounts : out.left.card + out.right.card = R.card :=
    (Finset.card_union_of_disjoint out.disjoint).symm.trans (congrArg Finset.card out.cover)
  have hLpos := Finset.card_pos.mpr out.left_ne
  have hRpos := Finset.card_pos.mpr out.right_ne
  have hLsmall : out.left.card ≤ 3 := by omega
  have hRsmall : out.right.card ≤ 3 := by omega
  have h2 := weakenEFX O (v 2) (hm 2) (O.trans h2H out.left_floor)
  have h3 := weakenEFX O (v 3) (hm 3) (O.trans h3H out.right_floor)
  have hU : {g} ∪ (H ∪ R) = U := by
    rw [hrest, Finset.singleton_union, Finset.insert_erase hg]
  have hpq := out.disjoint
  have hHL := hdj.mono_right hL
  have hHR := hdj.mono_right hR
  have hgH := singletonDisjoint hHsub
  have hgL := singletonDisjoint (hL.trans hRsub)
  have hgR := singletonDisjoint (hR.trans hRsub)
  rcases place with ⟨h0H, h1g⟩ | ⟨h1H, h0g⟩
  · have hpart := partitionOfFour (show {g} ∪ H ∪ out.left ∪ out.right = U by
          rw [Finset.union_assoc ({g} ∪ H), out.cover, Finset.union_assoc, hU])
        hgH hgL hgR hHL hHR hpq
    have h02 := efxSmall O v hd 0 (O.refl _) (hL.trans hRsub) hLsmall
    have h03 := efxSmall O v hd 0 (O.refl _) (hR.trans hRsub) hRsmall
    have h12 := efxSmall O v hd 1 h1g (hL.trans hRsub) hLsmall
    have h13 := efxSmall O v hd 1 h1g (hR.trans hRsub) hRsmall
    refine ⟨![{g}, H, out.left, out.right], hpart.1, hpart.2, ?_⟩
    intro i j
    fin_cases i <;> fin_cases j <;>
      first | exact weakenEFX O _ (hm _) (O.refl _) |
        exact efxSingleton O _ (hm _) _ _ |
        apply h02 | apply h03 | apply h12 | apply h13 | apply h0H |
        apply h2 | apply h3 | exact out.left_efx | exact out.right_efx
  · have hpart := partitionOfFour (show H ∪ {g} ∪ out.left ∪ out.right = U by
          rw [Finset.union_comm H {g}, Finset.union_assoc ({g} ∪ H), out.cover,
            Finset.union_assoc, hU])
        hgH.symm hHL hHR hgL hgR hpq
    have h02 := efxSmall O v hd 0 h0g (hL.trans hRsub) hLsmall
    have h03 := efxSmall O v hd 0 h0g (hR.trans hRsub) hRsmall
    have h12 := efxSmall O v hd 1 (O.refl _) (hL.trans hRsub) hLsmall
    have h13 := efxSmall O v hd 1 (O.refl _) (hR.trans hRsub) hRsmall
    refine ⟨![H, {g}, out.left, out.right], hpart.1, hpart.2, ?_⟩
    intro i j
    fin_cases i <;> fin_cases j <;>
      first | exact weakenEFX O _ (hm _) (O.refl _) |
        exact efxSingleton O _ (hm _) _ _ |
        apply h02 | apply h03 | apply h12 | apply h13 | apply h1H |
        apply h2 | apply h3 | exact out.left_efx | exact out.right_efx


private def localLabels (a b c z : G) : Good → G
  | .a => a
  | .b => b
  | .c => c
  | .z => z

omit [DecidableEq G] in
private theorem labelsDistinct {a b c z : G}
    (ab : a ≠ b) (ac : a ≠ c) (az : a ≠ z)
    (bc : b ≠ c) (bz : b ≠ z) (cz : c ≠ z) :
    Function.Injective (localLabels a b c z) := by
  intro x y h
  cases x <;> cases y <;> simp_all [localLabels]

omit [DecidableEq G] in
private theorem distinctOfDisjoint {S T : Finset G} {x y : G}
    (hd : Disjoint S T) (hx : x ∈ S) (hy : y ∈ T) : x ≠ y :=
  fun h => Finset.disjoint_left.mp hd (h ▸ hx) hy

private theorem splitRest {Q P R H W : Finset G} (hcover : Q ∪ P ∪ R = W)
    (hqP : Disjoint Q P) (hqR : Disjoint Q R) (hHQ : H ⊆ Q) :
    H ∪ (P ∪ R ∪ (Q \ H)) = W ∧ Disjoint H (P ∪ R ∪ (Q \ H)) := by
  constructor
  · calc
      H ∪ (P ∪ R ∪ (Q \ H)) = (Q \ H ∪ H) ∪ P ∪ R := by ac_rfl
      _ = W := by rw [Finset.sdiff_union_of_subset hHQ, hcover]
  · rw [Finset.disjoint_union_right, Finset.disjoint_union_right]
    exact ⟨⟨hqP.mono_left hHQ, hqR.mono_left hHQ⟩, Finset.disjoint_sdiff⟩

private theorem sdiff_erase_single {Q : Finset G} {z : G} (hz : z ∈ Q) :
    Q \ Q.erase z = {z} := by
  ext x
  simp only [Finset.mem_sdiff, Finset.mem_erase, Finset.mem_singleton]
  grind

set_option maxHeartbeats 1500000 in
/-- D2 repair for three remaining agents in decreasing order of initial bundle size.
    This theorem checks every inter-agent comparison including deletions of zero-value goods. -/
theorem d2Ordered (O : ValueOrder Value) (v : FourValues G Value)
    (hm : ∀ i, FiniteMonotone O (v i)) {U Q P R : Finset G} {g : G}
    (hg : g ∈ U) (hU : U.card = 8) (hd : PairDominates O v U g)
    (hcover : Q ∪ P ∪ R = U.erase g)
    (hqP : Disjoint Q P) (hqR : Disjoint Q R) (hpR : Disjoint P R)
    (hne : R.Nonempty) (hrp : R.card ≤ P.card) (hpq : P.card ≤ Q.card)
    (hfair : ∀ i j : Fin 4, i ≠ 0 → j ≠ 0 →
      EFXAgainst O (v i)
        ((![{g}, Q, P, R] : Fin 4 → Finset G) i) (![ {g}, Q, P, R] j)) :
    FourEFX O v U := by
  have hQsub : Q ⊆ U.erase g := hcover ▸ Finset.subset_union_left.trans Finset.subset_union_left
  have hPsub : P ⊆ U.erase g := hcover ▸ Finset.subset_union_right.trans Finset.subset_union_left
  have hRsub : R ⊆ U.erase g := hcover ▸ Finset.subset_union_right
  have hcount : Q.card + P.card + R.card = 7 := by
    have hc := Finset.card_erase_add_one hg
    rw [← hcover, Finset.card_union_of_disjoint (Finset.disjoint_union_left.mpr ⟨hqR, hpR⟩),
      Finset.card_union_of_disjoint hqP] at hc
    omega
  have hRpos := Finset.card_pos.mpr hne
  have hPsmall : P.card ≤ 3 := by omega
  have hRsmall : R.card ≤ 3 := by omega
  have h2Q : EFXAgainst O (v 2) P Q := hfair 2 1 (by decide) (by decide)
  have h3Q : EFXAgainst O (v 3) R Q := hfair 3 1 (by decide) (by decide)
  have h3P : EFXAgainst O (v 3) R P := hfair 3 2 (by decide) (by decide)
  by_cases h0Q : EFXAgainst O (v 0) {g} Q
  · have h0P := efxSmall O v hd 0 (O.refl _) hPsub hPsmall
    have h0R := efxSmall O v hd 0 (O.refl _) hRsub hRsmall
    have hpart := partitionOfFour (show {g} ∪ Q ∪ P ∪ R = U by
        rw [Finset.union_assoc, Finset.union_assoc, ← Finset.union_assoc Q, hcover,
          Finset.singleton_union, Finset.insert_erase hg])
      (singletonDisjoint hQsub) (singletonDisjoint hPsub) (singletonDisjoint hRsub) hqP hqR hpR
    refine ⟨![{g}, Q, P, R], hpart.1, hpart.2, ?_⟩
    intro i j
    fin_cases i <;> fin_cases j <;>
      first | exact weakenEFX O _ (hm _) (O.refl _) |
        exact efxSingleton O _ (hm _) _ _ |
        apply h0P | apply h0R | apply h0Q | apply hfair <;> decide
  · have hQlarge : 4 ≤ Q.card := by
      by_contra h
      exact h0Q (efxSmall O v hd 0 (O.refl _) hQsub (by omega))
    have hex : ∃ z ∈ Q, ¬ O.le (v 0 (Q.erase z)) (v 0 {g}) := by
      by_contra h
      push_neg at h
      exact h0Q h
    obtain ⟨z, hz, h0z⟩ := hex
    have h0gain : O.le (v 0 {g}) (v 0 (Q.erase z)) :=
      (O.total _ _).resolve_left h0z
    have herase := Finset.card_erase_add_one hz
    have hsplit := splitRest hcover hqP hqR (Finset.erase_subset z Q)
    have hlocal := sdiff_erase_single hz
    have h2z := boundByOldBundle O (v 2) (hm 2) h2Q
      (Finset.singleton_subset_iff.mpr hz) (by simpa using (show 1 < Q.card by omega))
    have h3z := boundByOldBundle O (v 3) (hm 3) h3Q
      (Finset.singleton_subset_iff.mpr hz) (by simpa using (show 1 < Q.card by omega))
    by_cases hQ4 : Q.card = 4
    · have hP2 : P.card = 2 := by omega
      have hR1 : R.card = 1 := by omega
      obtain ⟨b, c, hbc, rfl⟩ := Finset.card_eq_two.mp hP2
      obtain ⟨a, rfl⟩ := Finset.card_eq_one.mp hR1
      have ha : a ∈ ({a} : Finset G) := Finset.mem_singleton_self _
      have hb : b ∈ ({b, c} : Finset G) := by simp
      have hc : c ∈ ({b, c} : Finset G) := by simp
      have hab := distinctOfDisjoint hpR.symm ha hb
      have hac := distinctOfDisjoint hpR.symm ha hc
      have haz := distinctOfDisjoint hqR.symm ha hz
      have hbz := distinctOfDisjoint hqP.symm hb hz
      have hcz := distinctOfDisjoint hqP.symm hc hz
      obtain ⟨new⟩ := finiteInsertionB O (v 2) (v 3) (hm 2) (hm 3)
        (localLabels a b c z) (labelsDistinct hab hac haz hbc hbz hcz)
        (by simpa [localLabels, Finset.erase_insert_of_ne, hbc] using h3P hc)
        (by simpa [localLabels, hbc] using h3P hb)
        h3z h2z
      have hset : ({b, c} : Finset G) ∪ {a} ∪ (Q \ Q.erase z) = {a, b, c, z} := by
        rw [hlocal]
        ext x
        simp only [Finset.mem_union, Finset.mem_insert, Finset.mem_singleton]
        tauto
      have hmass : ({a, b, c, z} : Finset G).card ≤ 4 := Finset.card_le_four
      have h1H := efxSmall O v hd 1 (O.refl _)
        ((Finset.erase_subset z Q).trans hQsub) (by omega)
      exact assemble O v hm hg hd (hset ▸ hsplit.1) (hset ▸ hsplit.2) new hmass
        (h2Q hz) (h3Q hz) (Or.inr ⟨h1H, h0gain⟩)
    · have hQ5 : Q.card = 5 := by omega
      have hP1 : P.card = 1 := by omega
      have hR1 : R.card = 1 := by omega
      obtain ⟨a, rfl⟩ := Finset.card_eq_one.mp hP1
      obtain ⟨b, rfl⟩ := Finset.card_eq_one.mp hR1
      have ha : a ∈ ({a} : Finset G) := Finset.mem_singleton_self _
      have hb : b ∈ ({b} : Finset G) := Finset.mem_singleton_self _
      have hab := distinctOfDisjoint hpR ha hb
      by_cases htr : ∃ T : Finset G, T ⊆ Q ∧ T.card = 3 ∧
          (¬ O.le (v 0 T) (v 0 {g}) ∨ ¬ O.le (v 1 T) (v 1 {g}))
      · obtain ⟨T, hTQ, hT3, hval⟩ := htr
        have hsmall : (Q \ T).card = 2 := by rw [Finset.card_sdiff_of_subset hTQ, hQ5, hT3]
        obtain ⟨c, w, hcw, hcwSet⟩ := Finset.card_eq_two.mp hsmall
        have hc_mem : c ∈ Q \ T := by simp [hcwSet]
        have hw_mem : w ∈ Q \ T := by simp [hcwSet]
        have hc : c ∈ Q := (Finset.mem_sdiff.mp hc_mem).1
        have hw : w ∈ Q := (Finset.mem_sdiff.mp hw_mem).1
        have hac := distinctOfDisjoint hqP.symm ha hc
        have haw := distinctOfDisjoint hqP.symm ha hw
        have hbc := distinctOfDisjoint hqR.symm hb hc
        have hbw := distinctOfDisjoint hqR.symm hb hw
        have h2Small (x : G) (hx : x ∈ Q) : O.le (v 2 {x}) (v 2 {a}) :=
          boundByOldBundle O (v 2) (hm 2) h2Q
            (Finset.singleton_subset_iff.mpr hx) (by simp [hQ5])
        have h3Small (x : G) (hx : x ∈ Q) : O.le (v 3 {x}) (v 3 {b}) :=
          boundByOldBundle O (v 3) (hm 3) h3Q
            (Finset.singleton_subset_iff.mpr hx) (by simp [hQ5])
        obtain ⟨new⟩ := finiteInsertionC O (v 2) (v 3) (hm 2) (hm 3)
          (localLabels a b c w) (labelsDistinct hab hac haw hbc hbw hcw)
          (h2Small c hc) (h3Small c hc) (h2Small w hw) (h3Small w hw)
        have hset : ({a} : Finset G) ∪ {b} ∪ (Q \ T) = {a, b, c, w} := by
          rw [hcwSet]
          ext x
          simp only [Finset.mem_union, Finset.mem_insert, Finset.mem_singleton]
          tauto
        have hpartition := splitRest hcover hqP hqR hTQ
        have hsub := hTQ.trans hQsub
        have hmass : ({a, b, c, w} : Finset G).card ≤ 4 := Finset.card_le_four
        have h2T := boundByOldBundle O (v 2) (hm 2) h2Q hTQ (by omega)
        have h3T := boundByOldBundle O (v 3) (hm 3) h3Q hTQ (by omega)
        apply assemble O v hm hg hd (hset ▸ hpartition.1) (hset ▸ hpartition.2) new hmass h2T h3T
        rcases hval with h0 | h1
        · exact Or.inr ⟨efxSmall O v hd 1 (O.refl _) hsub (by omega),
            (O.total _ _).resolve_left h0⟩
        · exact Or.inl ⟨efxSmall O v hd 0 (O.refl _) hsub (by omega),
            (O.total _ _).resolve_left h1⟩
      · have haz := distinctOfDisjoint hqP.symm ha hz
        have hbz := distinctOfDisjoint hqR.symm hb hz
        have hag := distinctOfDisjoint (singletonDisjoint hPsub).symm ha (Finset.mem_singleton_self _)
        have hbg := distinctOfDisjoint (singletonDisjoint hRsub).symm hb (Finset.mem_singleton_self _)
        have hzg := distinctOfDisjoint (singletonDisjoint hQsub).symm hz (Finset.mem_singleton_self _)
        obtain ⟨new⟩ := finiteInsertionA O (v 2) (v 3) (hm 2) (hm 3)
          (localLabels a b z g) (labelsDistinct hab haz hag hbz hbg hzg) h2z h3z
        have hset : ({a} : Finset G) ∪ {b} ∪ (Q \ Q.erase z) = {a, b, z} := by
          rw [hlocal]
          ext x
          simp only [Finset.mem_union, Finset.mem_insert, Finset.mem_singleton]
          tauto
        have hmass : ({a, b, z} : Finset G).card ≤ 4 := Finset.card_le_three.trans (by decide)
        have h1H : EFXAgainst O (v 1) {g} (Q.erase z) := by
          intro x hx
          by_contra hn
          have hxcount := Finset.card_erase_add_one hx
          exact htr ⟨(Q.erase z).erase x,
            (Finset.erase_subset _ _).trans (Finset.erase_subset _ _),
            by omega, Or.inr hn⟩
        exact assemble O v hm hg hd (hset ▸ hsplit.1) (hset ▸ hsplit.2) new hmass
          (h2Q hz) (h3Q hz) (Or.inr ⟨h1H, h0gain⟩)


/-- A complete EFX partition for agents 1, 2 and 3. Slot 0 is unused. -/
structure ThreeEFXAllocation (O : ValueOrder Value) (v : FourValues G Value)
    (S : Finset G) (A : Fin 4 → Finset G) : Prop where
  cover : ∀ x, x ∈ S ↔ ∃ i, i ≠ 0 ∧ x ∈ A i
  disjoint : ∀ i j, i ≠ 0 → j ≠ 0 → i ≠ j → Disjoint (A i) (A j)
  fair : ∀ i j, i ≠ 0 → j ≠ 0 → EFXAgainst O (v i) (A i) (A j)

def ThreeEFXInput (O : ValueOrder Value) (v : FourValues G Value) (S : Finset G) : Prop :=
  ∃ A, ThreeEFXAllocation O v S A ∧ ∀ i, i ≠ 0 → (A i).Nonempty

private theorem orderThree (sz : Fin 4 → Nat) :
    ∃ e : Equiv.Perm (Fin 4), e 0 = 0 ∧ sz (e 3) ≤ sz (e 2) ∧ sz (e 2) ≤ sz (e 1) := by
  by_cases h12 : sz 2 ≤ sz 1
  · by_cases h23 : sz 3 ≤ sz 2
    · exact ⟨Equiv.refl _, rfl, h23, h12⟩
    · by_cases h13 : sz 3 ≤ sz 1
      · exact ⟨Equiv.swap 2 3, by decide, by change sz 2 ≤ sz 3; omega, h13⟩
      · exact ⟨(Equiv.swap 2 3).trans (Equiv.swap 1 3),
          by decide, h12, by change sz 1 ≤ sz 3; omega⟩
  · by_cases h13 : sz 3 ≤ sz 1
    · exact ⟨Equiv.swap 1 2, by decide, h13, by change sz 1 ≤ sz 2; omega⟩
    · by_cases h23 : sz 3 ≤ sz 2
      · exact ⟨(Equiv.swap 2 3).trans (Equiv.swap 1 2),
          by decide, by change sz 1 ≤ sz 3; omega, h23⟩
      · exact ⟨Equiv.swap 1 3, by decide, by change sz 1 ≤ sz 2; omega,
          by change sz 2 ≤ sz 3; omega⟩

/-- Common pair dominance implies a complete EFX allocation of eight goods
    once the other three agents have a nonempty EFX allocation of the seven
    remaining goods. The external existence result is an explicit input. -/
theorem d2_of_three (O : ValueOrder Value) (v : FourValues G Value)
    (hm : ∀ i, FiniteMonotone O (v i)) {U : Finset G} {g : G}
    (hg : g ∈ U) (hU : U.card = 8) (hd : PairDominates O v U g)
    (hthree : ThreeEFXInput O v (U.erase g)) :
    FourEFX O v U := by
  obtain ⟨A, ⟨hcover, hdisj, hfair⟩, hne⟩ := hthree
  obtain ⟨e, he0, h32, h21⟩ := orderThree (fun i => (A i).card)
  let Q := A (e 1)
  let P := A (e 2)
  let R := A (e 3)
  have e_ne {i : Fin 4} (hi : i ≠ 0) : e i ≠ 0 :=
    fun h => hi (e.injective (h.trans he0.symm))
  have hrest : Q ∪ P ∪ R = U.erase g := by
    ext x
    rw [hcover]
    simp only [Finset.mem_union]
    constructor
    · rintro ((hq | hp) | hr)
      · exact ⟨e 1, e_ne (by decide), hq⟩
      · exact ⟨e 2, e_ne (by decide), hp⟩
      · exact ⟨e 3, e_ne (by decide), hr⟩
    · rintro ⟨i, hi, hxi⟩
      obtain ⟨j, rfl⟩ := e.surjective i
      fin_cases j
      · exact (hi he0).elim
      · exact Or.inl (Or.inl hxi)
      · exact Or.inl (Or.inr hxi)
      · exact Or.inr hxi
  have parts (i : Fin 4) (hi : i ≠ 0) :
      ((![{g}, Q, P, R] : Fin 4 → Finset G) i) = A (e i) := by
    fin_cases i <;> first | contradiction | rfl
  have renamed := d2Ordered O (fun i => v (e i)) (fun i => hm (e i)) hg hU
    (fun i => hd (e i)) hrest
    (hdisj _ _ (e_ne (by decide : (1 : Fin 4) ≠ 0)) (e_ne (by decide : (2 : Fin 4) ≠ 0))
      (fun h => (by decide : (1 : Fin 4) ≠ 2) (e.injective h)))
    (hdisj _ _ (e_ne (by decide : (1 : Fin 4) ≠ 0)) (e_ne (by decide : (3 : Fin 4) ≠ 0))
      (fun h => (by decide : (1 : Fin 4) ≠ 3) (e.injective h)))
    (hdisj _ _ (e_ne (by decide : (2 : Fin 4) ≠ 0)) (e_ne (by decide : (3 : Fin 4) ≠ 0))
      (fun h => (by decide : (2 : Fin 4) ≠ 3) (e.injective h)))
    (hne _ (e_ne (by decide : (3 : Fin 4) ≠ 0))) h32 h21
    (fun i j hi hj => by
      rw [parts i hi, parts j hj]
      exact hfair _ _ (e_ne hi) (e_ne hj))
  obtain ⟨B, hbcover, hbdisj, hbefx⟩ := renamed
  refine ⟨fun i => B (e.symm i), ?_, ?_, ?_⟩
  · intro x
    rw [hbcover]
    constructor
    · rintro ⟨j, hj⟩
      exact ⟨e j, by simpa using hj⟩
    · rintro ⟨i, hi⟩
      exact ⟨e.symm i, hi⟩
  · intro i j hij
    exact hbdisj _ _ (fun h => hij (e.symm.injective h))
  · intro i j
    simpa only [Equiv.apply_symm_apply] using hbefx (e.symm i) (e.symm j)

end EFXResearch

#print axioms EFXResearch.d2_of_three
