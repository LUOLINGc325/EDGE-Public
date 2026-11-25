import TensorLower
import Mathlib.Data.Finset.Prod

open Finset
open scoped BigOperators

namespace IndependentMerging

variable {n : ℕ}

noncomputable def ReadTree.castDomain {R S : Finset (PairCoord n)} (h : R = S)
    (T : ReadTree n R) : ReadTree n S := h ▸ T

@[simp] theorem ReadTree.castDomain_payoff {R S : Finset (PairCoord n)} (h : R = S)
    (T : ReadTree n R) (x : PairInput n) : (T.castDomain h).unitPayoff x = T.unitPayoff x := by
  subst S
  rfl

theorem erase_union_left {R S : Finset (PairCoord n)} {c : PairCoord n} (hc : c ∉ S) :
    R.erase c ∪ S = (R ∪ S).erase c := by
  ext z
  simp only [Finset.mem_union, Finset.mem_erase]
  aesop

/-- Compose two strategies reading disjoint coordinate sets. -/
noncomputable def ReadTree.concatenate {R S : Finset (PairCoord n)} (T : ReadTree n R)
    (U : ReadTree n S) : Disjoint R S → ReadTree n (R ∪ S) :=
  T.rec (motive := fun A _ => Disjoint A S → ReadTree n (A ∪ S))
    (fun _ => U.castDomain (Finset.empty_union S).symm)
    (fun c hc stake _ ih h =>
      ReadTree.bet c (Finset.mem_union_left S hc) stake (fun x =>
        (ih x (h.mono_left (Finset.erase_subset _ _))).castDomain
          (erase_union_left (Finset.disjoint_left.mp h hc))))

theorem ReadTree.concatenate_payoff {R S : Finset (PairCoord n)} (T : ReadTree n R)
    (U : ReadTree n S) (h : Disjoint R S) (x : PairInput n) :
    (T.concatenate U h).unitPayoff x = T.unitPayoff x * U.unitPayoff x := by
  induction T with
  | done => simp [ReadTree.concatenate]
  | bet c hc stake next ih =>
    simp only [ReadTree.concatenate, ReadTree.unitPayoff_bet, ReadTree.castDomain_payoff, mul_assoc]
    exact congrArg (fun z => betFactor stake (x c) * z) (ih (x c) _)

noncomputable def pairDomain (i : Fin n) : Finset (PairCoord n) := {(i, false), (i, true)}

theorem mem_pairDomain (i : Fin n) (b : Bool) : (i, b) ∈ pairDomain i := by
  cases b <;> simp [pairDomain]

theorem mem_pairDomain_iff (i : Fin n) (c : PairCoord n) : c ∈ pairDomain i ↔ c.1 = i := by
  obtain ⟨j, b⟩ := c
  cases b <;> simp [pairDomain]

theorem erase_pair_first (i : Fin n) (b : Bool) :
    (pairDomain i).erase (i, b) = {(i, !b)} := by
  ext c
  obtain ⟨j, a⟩ := c
  cases b <;> cases a <;> simp [pairDomain, Finset.mem_erase]

theorem erase_pair_second (i : Fin n) (b : Bool) :
    ((pairDomain i).erase (i, b)).erase (i, !b) = ∅ := by
  rw [erase_pair_first]
  simp

noncomputable def orderedPairTree (i : Fin n) (b : Bool) (a : Set.Icc (0 : ℝ) 1)
    (second : ℝ → Set.Icc (0 : ℝ) 1) : ReadTree n (pairDomain i) :=
  ReadTree.bet (i, b) (mem_pairDomain i b) a (fun z =>
    ReadTree.bet (i, !b) (by rw [erase_pair_first]; simp) (second z)
      (fun _ => ReadTree.done.castDomain (erase_pair_second i b).symm))

theorem orderedPairTree_payoff (i : Fin n) (b : Bool) (a : Set.Icc (0 : ℝ) 1)
    (second : ℝ → Set.Icc (0 : ℝ) 1) (x : PairInput n) :
    (orderedPairTree i b a second).unitPayoff x =
      orderedStrategy b a.val (fun z => (second z).val) (x (i, false)) (x (i, true)) := by
  cases b <;> simp [orderedPairTree, orderedStrategy, betFactor]

noncomputable def pairsDomain (s : Finset (Fin n)) : Finset (PairCoord n) :=
  s.product Finset.univ

@[simp] theorem mem_pairsDomain (s : Finset (Fin n)) (c : PairCoord n) :
    c ∈ pairsDomain s ↔ c.1 ∈ s := by
  simp [pairsDomain, Finset.mem_product]

@[simp] theorem empty_pairsDomain : pairsDomain (∅ : Finset (Fin n)) = ∅ := by
  ext c
  simp

@[simp] theorem univ_pairsDomain : pairsDomain (Finset.univ : Finset (Fin n)) = Finset.univ := by
  ext c
  simp

theorem pairs_erase_disjoint (s : Finset (Fin n)) (i : Fin n) :
    Disjoint (pairDomain i) (pairsDomain (s.erase i)) := by
  apply Finset.disjoint_left.mpr
  intro c hc hd
  have hc' := (mem_pairDomain_iff i c).mp hc
  exact (Finset.mem_erase.mp ((mem_pairsDomain _ _).mp hd)).1 hc'

theorem pair_union_erase {s : Finset (Fin n)} {i : Fin n} (hi : i ∈ s) :
    pairDomain i ∪ pairsDomain (s.erase i) = pairsDomain s := by
  ext c
  simp only [Finset.mem_union, mem_pairDomain_iff, mem_pairsDomain, Finset.mem_erase]
  by_cases hc : c.1 = i <;> simp_all

noncomputable def pairSequence (s : Finset (Fin n)) (T : ∀ i : Fin n, ReadTree n (pairDomain i)) :
    ReadTree n (pairsDomain s) := by
  classical
  by_cases h : s.Nonempty
  · let i := h.choose
    exact ((T i).concatenate (pairSequence (s.erase i) T) (pairs_erase_disjoint s i)).castDomain
      (pair_union_erase h.choose_spec)
  · have he := Finset.not_nonempty_iff_eq_empty.mp h
    subst s
    exact ReadTree.done.castDomain empty_pairsDomain.symm
termination_by s.card
decreasing_by exact Finset.card_erase_lt_of_mem h.choose_spec

theorem pairSequence_payoff (s : Finset (Fin n)) (T : ∀ i : Fin n, ReadTree n (pairDomain i))
    (x : PairInput n) : (pairSequence s T).unitPayoff x = ∏ i ∈ s, (T i).unitPayoff x := by
  classical
  refine Finset.strongInductionOn s ?_
  intro R ih
  rw [pairSequence]
  split
  · rename_i h
    rw [ReadTree.castDomain_payoff, ReadTree.concatenate_payoff,
      ih (R.erase h.choose) (Finset.erase_ssubset h.choose_spec)]
    exact Finset.mul_prod_erase R (fun i => (T i).unitPayoff x) h.choose_spec
  · rename_i h
    have he := Finset.not_nonempty_iff_eq_empty.mp h
    subst R
    simp

end IndependentMerging
