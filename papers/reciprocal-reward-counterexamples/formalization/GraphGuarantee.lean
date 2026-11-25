import FractionalMatchingStructure

/-! The sharp five-sixths bound from a maximal matching in the residual
degree-two support and the support of the extreme optimum itself. -/

set_option autoImplicit false
open Finset

namespace ReciprocalSearch.SimpleEdges

variable {E V : Type*} [Fintype E] [Fintype V] [Nonempty V]
noncomputable section
open Classical

def isMatching (g : SimpleEdges E V) (s : Finset E) : Prop :=
  ∀ v, g.degree s v ≤ 1

def touching (g : SimpleEdges E V) (s : Finset E) (e : E) : Finset E :=
  s.filter fun a => ¬ Disjoint (g.ends e) (g.ends a)

omit [Fintype E] [Fintype V] [Nonempty V] in
lemma touching_count_of_degree_two (g : SimpleEdges E V) (s : Finset E) (e : E) (he : e ∈ s)
    (hdeg : ∀ v ∈ g.ends e, g.degree s v ≤ 2) : (g.touching s e).card ≤ 3 := by
  obtain ⟨v, w, hvw, hw⟩ := card_eq_two.mp (g.card_ends e)
  let F := s.filter fun a => v ∈ g.ends a
  let G := s.filter fun a => w ∈ g.ends a
  have hF : F.card ≤ 2 := hdeg v (by simp [hw])
  have hG : G.card ≤ 2 := hdeg w (by simp [hw])
  have hi : 0 < (F ∩ G).card := by
    apply card_pos.mpr
    exact ⟨e, by simp [F, G, hw, he]⟩
  have hu : g.touching s e = F ∪ G := by
    ext a
    simp only [touching, F, G, mem_filter, mem_union, hw]
    constructor
    · rintro ⟨ha, hd⟩
      by_cases hv : v ∈ g.ends a
      · exact Or.inl ⟨ha, hv⟩
      · right
        refine ⟨ha, ?_⟩
        by_contra hn
        exact hd (Finset.disjoint_left.mpr (fun i hi => by
          rcases mem_insert.mp hi with rfl | hi
          · exact hv
          · rwa [mem_singleton.mp hi]))
    · intro ha
      rcases ha with ⟨ha, hv⟩ | ⟨ha, hw'⟩
      · exact ⟨ha, fun hd => (Finset.disjoint_left.mp hd) (by simp : v ∈ ({v, w} : Finset V)) hv⟩
      · exact ⟨ha, fun hd => (Finset.disjoint_left.mp hd) (by simp : w ∈ ({v, w} : Finset V)) hw'⟩
  rw [hu]
  have hc := card_union_add_card_inter F G
  omega

omit [Fintype E] [Fintype V] [Nonempty V] in
theorem maximal_matching_card (g : SimpleEdges E V) (s : Finset E)
    (hdeg : ∀ v, g.degree s v ≤ 2) :
    ∃ M : Finset E, M ⊆ s ∧ g.isMatching M ∧ s.card ≤ 3 * M.card := by
  let C := s.powerset.filter g.isMatching
  have hC : C.Nonempty := by
    refine ⟨∅, mem_filter.mpr ⟨mem_powerset.mpr (empty_subset _), ?_⟩⟩
    intro v
    simp [degree]
  obtain ⟨M, hmem, hmax⟩ := exists_max_image C Finset.card hC
  have hMs := mem_powerset.mp (mem_filter.mp hmem).1
  have hMatch := (mem_filter.mp hmem).2
  have htouch (e : E) (he : e ∈ s) : ∃ f ∈ M, e ∈ g.touching s f := by
    by_cases hm : e ∈ M
    · have hne : (g.ends e).Nonempty := by rw [← card_pos, g.card_ends]; decide
      obtain ⟨v, hv⟩ := hne
      exact ⟨e, hm, mem_filter.mpr ⟨he, fun hd => (Finset.disjoint_left.mp hd) hv hv⟩⟩
    · by_contra! he'
      have hdis (f : E) (hf : f ∈ M) : Disjoint (g.ends f) (g.ends e) := by
        by_contra hd
        exact he' f hf (mem_filter.mpr ⟨he, hd⟩)
      have hi : g.isMatching (insert e M) := by
        intro v
        unfold degree
        rw [filter_insert]
        split_ifs with hv
        · have hempty : (M.filter fun a => v ∈ g.ends a) = ∅ := by
            apply filter_eq_empty_iff.mpr
            intro a ha hav
            exact (Finset.disjoint_left.mp (hdis a ha)) hav hv
          simp [hempty]
        · exact hMatch v
      have hLe := hmax (insert e M) (mem_filter.mpr
        ⟨mem_powerset.mpr (insert_subset_iff.mpr ⟨he, hMs⟩), hi⟩)
      rw [card_insert_of_not_mem hm] at hLe
      omega
  refine ⟨M, hMs, hMatch, ?_⟩
  have hsub : s ⊆ M.biUnion (g.touching s) := by
    intro e he
    obtain ⟨f, hf, hmem⟩ := htouch e he
    exact mem_biUnion.mpr ⟨f, hf, hmem⟩
  calc
    s.card ≤ (M.biUnion (g.touching s)).card := card_le_card hsub
    _ ≤ ∑ f ∈ M, (g.touching s f).card := card_biUnion_le
    _ ≤ ∑ _f ∈ M, 3 := sum_le_sum (fun f hf => g.touching_count_of_degree_two s f (hMs hf) (fun v _ => hdeg v))
    _ = 3 * M.card := by simp [mul_comm]

omit [Fintype E] [Fintype V] [Nonempty V] in
lemma degree_le_one_of_incident_unique (g : SimpleEdges E V) (s : Finset E) (v : V)
    (h : ∀ a ∈ s, v ∈ g.ends a → ∀ b ∈ s, v ∈ g.ends b → a = b) :
    g.degree s v ≤ 1 :=
  card_le_one_iff.mpr fun ha hb =>
    h _ (mem_filter.mp ha).1 (mem_filter.mp ha).2 _ (mem_filter.mp hb).1 (mem_filter.mp hb).2

omit [Fintype V] [Nonempty V] in
lemma units_and_residual_matching (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ g.matchingFeasible) (M : Finset E) (hM : M ⊆ residualEdges x)
    (hm : g.isMatching M) : g.isMatching (unitEdges x ∪ M) := by
  intro v
  by_cases hu : ∃ a ∈ unitEdges x, v ∈ g.ends a
  · obtain ⟨a, ha, hav⟩ := hu
    have ha' := (mem_filter.mp ha).2
    have hpos (b : E) (hb : b ∈ unitEdges x ∪ M) : 0 < x b := by
      rcases mem_union.mp hb with h | h
      · rw [(mem_filter.mp h).2]; norm_num
      · exact (mem_filter.mp (hM h)).2.1
    have he (b : E) (hb : b ∈ unitEdges x ∪ M) (hbv : v ∈ g.ends b) : b = a := by
      by_contra hne
      exact (Finset.disjoint_left.mp (g.unit_excludes_other x hx (Ne.symm hne) ha' (hpos b hb))) hav hbv
    exact g.degree_le_one_of_incident_unique _ _ fun b hb hbv c hc hcv =>
      (he b hb hbv).trans (he c hc hcv).symm
  · have hsub : ((unitEdges x ∪ M).filter (fun a => v ∈ g.ends a)) ⊆
        M.filter (fun a => v ∈ g.ends a) := by
      intro a ha
      rcases mem_filter.mp ha with ⟨hm', hve⟩
      rcases mem_union.mp hm' with hu' | hm'
      · exact (hu ⟨a, hu', hve⟩).elim
      · exact mem_filter.mpr ⟨hm', hve⟩
    exact (card_le_card hsub).trans (hm v)

omit [Fintype V] [Nonempty V] in
lemma supported_decomposition (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ g.matchingFeasible) :
    supportedEdges x = unitEdges x ∪ residualEdges x ∧
      Disjoint (unitEdges x) (residualEdges x) := by
  constructor
  · ext a
    simp only [supportedEdges, unitEdges, residualEdges, mem_filter, mem_univ, true_and, mem_union]
    have h := g.matching_weight_le_one x hx a
    constructor
    · intro ha
      exact (lt_or_eq_of_le h).elim (fun hlt => Or.inr ⟨ha, hlt⟩) Or.inl
    · rintro (he | ⟨hp, _⟩)
      · rw [he]; norm_num
      · exact hp
  · apply Finset.disjoint_left.mpr
    intro a ha hr
    exact (mem_filter.mp hr).2.2.ne ((mem_filter.mp ha).2)

omit [Nonempty V] in
lemma supported_maxDegree_le_two (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ g.matchingFeasible.extremePoints ℝ) :
    g.maxDegree (supportedEdges x) ≤ 2 := by
  apply Finset.sup_le
  intro v _
  rw [(g.supported_decomposition x hx.1).1]
  by_cases h : g.degree (residualEdges x) v = 0
  · have hm : g.isMatching (∅ : Finset E) := by intro v; simp [degree]
    have hdeg := g.units_and_residual_matching x hx.1 ∅ (empty_subset _) hm v
    have hsub : ((unitEdges x ∪ residualEdges x).filter (fun a => v ∈ g.ends a)) ⊆
        ((unitEdges x ∪ ∅).filter (fun a => v ∈ g.ends a)) := by
      intro a ha
      obtain ⟨hu, hv⟩ := mem_filter.mp ha
      rcases mem_union.mp hu with hU | hR
      · exact mem_filter.mpr ⟨mem_union.mpr (Or.inl hU), hv⟩
      · have hp : 0 < g.degree (residualEdges x) v := card_pos.mpr ⟨a, mem_filter.mpr ⟨hR, hv⟩⟩
        omega
    exact (card_le_card hsub).trans (hdeg.trans (by decide))
  · have hv : 0 < g.degree (residualEdges x) v := Nat.pos_of_ne_zero h
    have hsub : ((unitEdges x ∪ residualEdges x).filter (fun a => v ∈ g.ends a)) ⊆
        ((residualEdges x).filter (fun a => v ∈ g.ends a)) := by
      intro a ha
      obtain ⟨hu, hve⟩ := mem_filter.mp ha
      rcases mem_union.mp hu with hu | hr
      · exact (g.residual_vertex_no_unit x hx.1 hv (mem_filter.mp hu).2 hve).elim
      · exact mem_filter.mpr ⟨hr, hve⟩
    have he := (g.extreme_residual_degrees x hx v).resolve_left h
    exact (card_le_card hsub).trans he.1.le

omit [Nonempty V] in
lemma total_of_extreme_matching (g : SimpleEdges E V) (x : E → ℝ)
    (hx : x ∈ g.matchingFeasible.extremePoints ℝ) :
    total x = (unitEdges x).card + (residualEdges x).card / 2 := by
  unfold total
  have hs : ∑ e, x e = ∑ e ∈ supportedEdges x, x e := by
    symm
    apply sum_subset (subset_univ _)
    intro a _ ha
    exact le_antisymm (le_of_not_gt (fun ha' => ha (mem_filter.mpr ⟨mem_univ _, ha'⟩))) (hx.1.1 a)
  rw [hs, (g.supported_decomposition x hx.1).1,
    sum_union (g.supported_decomposition x hx.1).2]
  have hunit : (∑ e ∈ unitEdges x, x e) = (unitEdges x).card := by
    calc
      _ = ∑ _e ∈ unitEdges x, (1 : ℝ) :=
        sum_congr rfl fun e he => (mem_filter.mp he).2
      _ = _ := by simp
  have hres : (∑ e ∈ residualEdges x, x e) = (residualEdges x).card / 2 := by
    calc
      _ = ∑ _e ∈ residualEdges x, (1 / 2 : ℝ) :=
        sum_congr rfl fun _ he => g.extreme_residual_weight_half x hx he
      _ = _ := by simp [div_eq_mul_inv]
  rw [hunit, hres]

lemma five_sixths_from_density {q β d : ℝ} (hd : 1 ≤ d)
    (hq : 5 * d / 2 ≤ q) (hβ : q - d / 2 ≤ β) :
    (5 / 6 : ℝ) * (1 - 1 / q) ≤ 1 - 1 / β := by
  let r := q - d / 2
  have hr : 0 < r := by dsimp [r]; linarith
  have hqp : 0 < q := by linarith
  have hrd : 2 * d ≤ r := by dsimp [r]; linarith
  have hq1 : (3 / 2 : ℝ) ≤ q - 1 := by linarith
  have hmul : 3 * d ≤ r * (q - 1) := by
    calc
      _ = (2 * d) * (3 / 2) := by ring
      _ ≤ _ := mul_le_mul hrd hq1 (by norm_num) hr.le
  have he : (1 - 1 / r) - (5 / 6 : ℝ) * (1 - 1 / q) =
      (r * (q - 1) - 3 * d) / (6 * r * q) := by
    field_simp [hr.ne', hqp.ne']
    dsimp [r]
    ring
  have hbase : (5 / 6 : ℝ) * (1 - 1 / q) ≤ 1 - 1 / r := by
    apply sub_nonneg.mp
    rw [he]
    exact div_nonneg (sub_nonneg.mpr hmul) (by positivity)
  exact hbase.trans (sub_le_sub_left (one_div_le_one_div_of_le hr hβ) _)

omit [Fintype E] [Fintype V] [Nonempty V] in
lemma degree_two_support_card_ge_three (g : SimpleEdges E V) (s : Finset E) (hs : s.Nonempty)
    (hd : ∀ v, g.degree s v = 0 ∨ g.degree s v = 2) : 3 ≤ s.card := by
  obtain ⟨e, he⟩ := hs
  obtain ⟨v, w, hvw, hev⟩ := card_eq_two.mp (g.card_ends e)
  have hfilter (v : V) (hv : v ∈ g.ends e) : g.degree s v = 2 := by
    have hp : 0 < g.degree s v := card_pos.mpr ⟨e, mem_filter.mpr ⟨he, hv⟩⟩
    exact (hd v).resolve_left hp.ne'
  have hv : g.degree s v = 2 := hfilter v (by simp [hev])
  have hw : g.degree s w = 2 := hfilter w (by simp [hev])
  have hle : 2 ≤ s.card := by
    rw [← hv]
    exact card_filter_le _ _
  by_contra! hcard
  have heq : s.card = 2 := by omega
  have hall (z : V) (hz : g.degree s z = 2) : s.filter (fun a => z ∈ g.ends a) = s :=
    eq_of_subset_of_card_le (filter_subset _ _) (by change s.card ≤ g.degree s z; omega)
  obtain ⟨f, hf, hne⟩ := exists_ne_of_one_lt_card (by omega : 1 < s.card) e
  have hvf : v ∈ g.ends f := (mem_filter.mp (show f ∈ s.filter (fun a => v ∈ g.ends a) by rw [hall v hv]; exact hf)).2
  have hwf : w ∈ g.ends f := (mem_filter.mp (show f ∈ s.filter (fun a => w ∈ g.ends a) by rw [hall w hw]; exact hf)).2
  have hsub : g.ends e ⊆ g.ends f := by
    rw [hev]
    intro z hz
    rcases mem_insert.mp hz with rfl | hz
    · exact hvf
    · rwa [mem_singleton.mp hz]
  exact hne (g.ends_injective (eq_of_subset_of_card_le hsub (by rw [g.card_ends, g.card_ends])).symm)

theorem graph_five_sixths [Nonempty E] (g : SimpleEdges E V) :
    (5 / 6 : ℝ) * g.searchGame.value ≤ g.searchGame.reciprocalValue := by
  obtain ⟨x, hx, hmax⟩ := g.exists_extreme_maximum_matching
  let U := unitEdges x
  let R := residualEdges x
  let S := supportedEdges x
  let q := total x
  let β := g.densityNumber
  have hq := g.matching_number_of_maximal hx.1 hmax
  have h1 : 1 ≤ q := by
    obtain ⟨e⟩ := ‹Nonempty E›
    simpa [q, total] using hmax _ (g.matching_single e)
  have hqpos : 0 < q := by linarith
  have ht : q = (U.card : ℝ) + (R.card : ℝ) / 2 := g.total_of_extreme_matching x hx
  obtain ⟨best, _, hβ, hbest⟩ := g.exists_maximum_density
  have hβmax (f : Finset E) (hf : f.Nonempty) : g.density f ≤ β := by
    rw [show β = g.density best from hβ]
    exact hbest f hf
  have hdec : S = U ∪ R ∧ Disjoint U R := g.supported_decomposition x hx.1
  have hS : S.Nonempty := by
    by_contra hs
    have hun : U = ∅ := eq_empty_of_forall_not_mem fun a ha => by
      have hmem : a ∈ S := by rw [hdec.1]; exact mem_union_left R ha
      exact hs ⟨a, hmem⟩
    have hr : R = ∅ := eq_empty_of_forall_not_mem fun a ha => by
      have hmem : a ∈ S := by rw [hdec.1]; exact mem_union_right U ha
      exact hs ⟨a, hmem⟩
    rw [hun, hr] at ht
    norm_num at ht
    linarith
  have hdeg : ∀ v, g.degree R v = 0 ∨ g.degree R v = 2 := fun v =>
    (g.extreme_residual_degrees x hx v).imp id And.left
  have hβS : ((U.card : ℝ) + (R.card : ℝ)) / 2 ≤ β := by
    apply le_trans _ (hβmax S hS)
    have hmax : (g.maxDegree S : ℝ) ≤ 2 := by exact_mod_cast g.supported_maxDegree_le_two x hx
    have hpos : (0 : ℝ) < g.maxDegree S := by exact_mod_cast g.maxDegree_pos S hS
    have hsc : (S.card : ℝ) = U.card + R.card := by
      exact_mod_cast (show S.card = U.card + R.card by rw [hdec.1, card_union_of_disjoint hdec.2])
    unfold density
    rw [← hsc]
    exact div_le_div_of_nonneg_left (Nat.cast_nonneg _) hpos hmax
  have hwithU {M : Finset E} (hM : M ⊆ R) (hmatch : g.isMatching M)
      (hn : (U ∪ M).Nonempty) :
      (U.card : ℝ) + M.card ≤ β := by
    let T := U ∪ M
    have hm := g.units_and_residual_matching x hx.1 M hM hmatch
    have hd : g.maxDegree T = 1 := by
      have hpos := g.maxDegree_pos T hn
      have hle : g.maxDegree T ≤ 1 := Finset.sup_le (fun v _ => hm v)
      omega
    have hdis : Disjoint U M := Finset.disjoint_left.mpr (fun a ha hb =>
      (Finset.disjoint_left.mp hdec.2) ha (hM hb))
    have hcard : (T.card : ℝ) = U.card + M.card := by
      exact_mod_cast (show T.card = U.card + M.card from card_union_of_disjoint hdis)
    have hb := hβmax T hn
    simpa [density, hd, hcard] using hb
  rw [g.graph_value_formula, g.reciprocal_value_formula, hq]
  change (5 / 6 : ℝ) * (2 * (1 - 1 / q)) ≤ 2 * (1 - 1 / β)
  have heasy (hβq : q ≤ β) : (5 / 6 : ℝ) * (2 * (1 - 1 / q)) ≤ 2 * (1 - 1 / β) := by
    have hInv := one_div_le_one_div_of_le hqpos hβq
    have hq1 : 1 / q ≤ 1 := (div_le_iff₀ hqpos).2 (by simpa using h1)
    linarith
  by_cases hU : U.Nonempty
  · by_cases hR : R.Nonempty
    · obtain ⟨M, hM, hmatch, hsize⟩ := g.maximal_matching_card R (fun v => by
        rcases hdeg v with hv | hv <;> omega)
      have hcardR : (3 : ℝ) ≤ R.card := by
        exact_mod_cast g.degree_two_support_card_ge_three R hR hdeg
      let d := min (U.card : ℝ) ((R.card : ℝ) / 3)
      have hUd : d ≤ U.card := min_le_left _ _
      have hRd : d ≤ (R.card : ℝ) / 3 := min_le_right _ _
      have hUd1 : (1 : ℝ) ≤ U.card := by exact_mod_cast card_pos.mpr hU
      have hd : 1 ≤ d := le_min hUd1 (by linarith)
      have hB₁ := hwithU hM hmatch (hU.mono (subset_union_left))
      have hMR : (R.card : ℝ) ≤ 3 * M.card := by exact_mod_cast hsize
      have hB₂ : q - d / 2 ≤ β := by
        rcases le_total (U.card : ℝ) ((R.card : ℝ) / 3) with h | h
        · dsimp [d]; rw [min_eq_left h]; linarith
        · dsimp [d]; rw [min_eq_right h]; linarith
      have h := five_sixths_from_density hd (show 5 * d / 2 ≤ q by linarith) hB₂
      linarith
    · have hz : R = ∅ := not_nonempty_iff_eq_empty.mp hR
      have hm : g.isMatching (∅ : Finset E) := by intro v; simp [degree]
      have h := hwithU (empty_subset R) hm (hU.mono (subset_union_left))
      rw [hz] at ht
      simp at ht h
      exact heasy (ht.le.trans h)
  · have hz : U = ∅ := not_nonempty_iff_eq_empty.mp hU
    rw [hz] at ht hβS
    simp at ht hβS
    exact heasy (ht.le.trans hβS)

#print axioms ReciprocalSearch.SimpleEdges.graph_five_sixths

end
end ReciprocalSearch.SimpleEdges
