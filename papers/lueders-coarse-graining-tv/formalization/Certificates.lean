import Result

namespace Lueders

noncomputable def selectedSum (a b c d : ℝ) (s0 s1 s2 s3 : Bool) : ℝ :=
  (if s0 then a else 0)+(if s1 then b else 0)+(if s2 then c else 0)+(if s3 then d else 0)

noncomputable def fineTable (s0 s1 s2 s3 : Bool) : ℝ × ℝ × ℝ :=
  if s3 then
    if s2 then
      if s1 then
        if s0 then (0,0,0) else (-9/1300,-31/3900,1/9000)
      else
        if s0 then (9/1300,-33/1300,9/13000) else (0,-1/30,1/900)
    else
      if s1 then
        if s0 then (-9/500,41/1500,241/225000) else (-81/3250,63/3250,81/81250)
      else
        if s0 then (-18/1625,19/9750,37/292500) else (-9/500,-3/500,9/25000)
  else
    if s2 then
      if s1 then
        if s0 then (9/500,3/500,9/25000) else (18/1625,-19/9750,37/292500)
      else
        if s0 then (81/3250,-63/3250,81/81250) else (9/500,-41/1500,241/225000)
    else
      if s1 then
        if s0 then (0,1/30,1/900) else (-9/1300,33/1300,9/13000)
      else
        if s0 then (9/1300,31/3900,1/9000) else (0,0,0)

theorem fine_table_correct (s0 s1 s2 s3 : Bool) :
    selectedSum (9/1300) (-9/1300) (9/500) (-9/500) s0 s1 s2 s3 = (fineTable s0 s1 s2 s3).1 ∧
    selectedSum (31/3900) (33/1300) (-41/1500) (-3/500) s0 s1 s2 s3 = (fineTable s0 s1 s2 s3).2.1 ∧
    (selectedSum (9/1300) (-9/1300) (9/500) (-9/500) s0 s1 s2 s3)^2+(selectedSum (31/3900) (33/1300) (-41/1500) (-3/500) s0 s1 s2 s3)^2 = (fineTable s0 s1 s2 s3).2.2 := by
  cases s0 <;> cases s1 <;> cases s2 <;> cases s3 <;> norm_num [selectedSum,fineTable]

noncomputable def coarseTable (s0 s1 s2 s3 : Bool) : ℝ × ℝ × ℝ :=
  if s3 then
    if s2 then
      if s1 then
        if s0 then (0,0,0) else (-9/2500,11/7500,17/1125000)
      else
        if s0 then (9/2500,-87/2500,153/125000) else (0,-1/30,1/900)
    else
      if s1 then
        if s0 then (-9/500,41/1500,241/225000) else (-27/1250,18/625,81/62500)
      else
        if s0 then (-9/625,-14/1875,37/140625) else (-9/500,-3/500,9/25000)
  else
    if s2 then
      if s1 then
        if s0 then (9/500,3/500,9/25000) else (9/625,14/1875,37/140625)
      else
        if s0 then (27/1250,-18/625,81/62500) else (9/500,-41/1500,241/225000)
    else
      if s1 then
        if s0 then (0,1/30,1/900) else (-9/2500,87/2500,153/125000)
      else
        if s0 then (9/2500,-11/7500,17/1125000) else (0,0,0)

theorem coarse_table_correct (s0 s1 s2 s3 : Bool) :
    selectedSum (9/2500) (-9/2500) (9/500) (-9/500) s0 s1 s2 s3 = (coarseTable s0 s1 s2 s3).1 ∧
    selectedSum (-11/7500) (87/2500) (-41/1500) (-3/500) s0 s1 s2 s3 = (coarseTable s0 s1 s2 s3).2.1 ∧
    (selectedSum (9/2500) (-9/2500) (9/500) (-9/500) s0 s1 s2 s3)^2+(selectedSum (-11/7500) (87/2500) (-41/1500) (-3/500) s0 s1 s2 s3)^2 = (coarseTable s0 s1 s2 s3).2.2 := by
  cases s0 <;> cases s1 <;> cases s2 <;> cases s3 <;> norm_num [selectedSum,coarseTable]


noncomputable def fineABTable : Fin 3 → Fin 2 → ℝ := ![![16/75,3/25], ![2809/5850,49/650], ![241/2250,1/250]]

theorem fine_table_bound (a b c d : Bool) : (fineTable a b c d).2.2 ≤ (1/30:ℝ)^2 := by
  cases a <;> cases b <;> cases c <;> cases d <;> norm_num [fineTable]

theorem coarse_table_bound (a b c d : Bool) : (coarseTable a b c d).2.2 ≤ (9/250:ℝ)^2 := by
  cases a <;> cases b <;> cases c <;> cases d <;> norm_num [coarseTable]

theorem table_maxima_attained : (fineTable true true false false).2.2=(1/30:ℝ)^2 ∧
    (coarseTable true false true false).2.2=(9/250:ℝ)^2 := by
  norm_num [fineTable,coarseTable]

theorem fine_AB_records (i : Fin 3) (j : Fin 2) :
    jointAB rootsA effectsB rhoFine i j=fineABTable i j := by
  fin_cases i <;> fin_cases j <;>
    simp [fineABTable,jointAB,effectsA,rootsA,effectsB,rootsB]
  all_goals simp only [K0,K1,K2,L0,L1,J0,A0,A1,A2,B0,B1,C0,rmat_sandwich,
    density_rmat_trace_general rhoFine rhoFine_density]
  all_goals norm_num [rhoFine,rmat,Herm2.matrix]
  all_goals ring_nf
  all_goals norm_num [Real.sq_sqrt]

noncomputable def fineBATable : Fin 3 → Fin 2 → ℝ := ![![16/75,3/25], ![17/36,1/20], ![121/900,1/100]]

theorem fine_BA_records (i : Fin 3) (j : Fin 2) :
    jointBA effectsA rootsB rhoFine i j=fineBATable i j := by
  fin_cases i <;> fin_cases j <;>
    simp [fineBATable,jointBA,effectsA,rootsA,effectsB,rootsB]
  all_goals simp only [K0,K1,K2,L0,L1,J0,A0,A1,A2,B0,B1,C0,rmat_sandwich,
    density_rmat_trace_general rhoFine rhoFine_density]
  all_goals norm_num [rhoFine,rmat,Herm2.matrix]

noncomputable def coarseABTable : Fin 2 → Fin 2 → ℝ := ![![2809/4500,49/500], ![241/900,1/100]]

theorem coarse_AB_records (i : Fin 2) (j : Fin 2) :
    jointAB rootsC effectsB rhoCoarse i j=coarseABTable i j := by
  fin_cases i <;> fin_cases j <;>
    simp [coarseABTable,jointAB,effectsC,rootsC,effectsB,rootsB]
  all_goals simp only [K0,K1,K2,L0,L1,J0,A0,A1,A2,B0,B1,C0,rmat_sandwich,
    density_rmat_trace_general rhoCoarse rhoCoarse_density]
  all_goals norm_num [rhoCoarse,rmat,Herm2.matrix]
  all_goals ring_nf
  all_goals norm_num [Real.sq_sqrt]

noncomputable def coarseBATable : Fin 2 → Fin 2 → ℝ := ![![706/1125,17/250], ![338/1125,1/250]]

theorem coarse_BA_records (i : Fin 2) (j : Fin 2) :
    jointBA effectsC rootsB rhoCoarse i j=coarseBATable i j := by
  fin_cases i <;> fin_cases j <;>
    simp [coarseBATable,jointBA,effectsC,rootsC,effectsB,rootsB]
  all_goals simp only [K0,K1,K2,L0,L1,J0,A0,A1,A2,B0,B1,C0,rmat_sandwich,
    density_rmat_trace_general rhoCoarse rhoCoarse_density]
  all_goals norm_num [rhoCoarse,rmat,Herm2.matrix]

end Lueders
