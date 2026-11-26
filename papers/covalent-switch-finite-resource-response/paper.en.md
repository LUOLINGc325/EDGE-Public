# Finite-resource response of reversible covalent switches

## Abstract

We study the steady logarithmic response of the free modified/unmodified substrate ratio to a conserved enzyme total in a reversible covalent-modification cycle. The kinetic coefficients are positive, and the dimensionless chemical affinity is fixed. An exact response decomposition yields a sharp envelope conditional on the free concentrations and enzyme occupancies. It also determines the signs of both total-enzyme responses. For fixed positive substrate and enzyme totals $S,e,f$, and affinity $\log\chi>0$, the supremum of the forward-enzyme sensitivity over compatible kinetics is finite if and only if $S\ne e$. When $S>e$, its exact value is $(\sqrt\chi-1)S/[2(S-e)]$. When $S \lt e$, we give a finite bound without claiming optimality. At $S=e$, an explicit family of elementary, completely reversible mechanisms has unbounded sensitivity while all three totals and the affinity remain fixed. Every finite member has a locally asymptotically stable steady state. The family refutes a published conjecture extending a high-substrate thermodynamic bound to arbitrary substrate abundance. It does not contradict the established high- or low-substrate limits, which keep kinetics fixed. The results identify the concentration constraint needed to supplement affinity in finite-resource response bounds.

**Status.** This manuscript supplies written proofs. Numerical and symbolic diagnostics are auxiliary. External peer review and formal proof-assistant verification have not been completed.

# 1. Question, contribution, and scope

Owen, Talla, Biddle, and Gunawardena [1] study a reversible two-enzyme covalent switch. Their response observable is the logarithm of the ratio of the two *free* substrate concentrations. They prove a bound after taking a high-substrate limit and ask whether the same bound holds at every finite substrate abundance. Their discussion also asks for monotonicity with respect to conserved enzyme totals. We address those two questions in the positive reduced model used in that work.

The distinction between a free concentration and a conserved total is central. Perturbing a total redistributes substrate among free forms and enzyme-bound complexes. The resulting input conversion can become arbitrarily steep, even though the chemical affinity is fixed and every elementary reaction is reversible. Our main result identifies the exact resource surface where an unbounded kinetic supremum is possible.

The new claims are the finite-resource response sign theorem, the sharp occupancy-conditioned envelope, the classification of the singular resource surface, and the exact above-critical supremum with admissible constructions. The general existence and uniqueness of the steady state are known [1,3]; we give an elementary proof to make the analysis self-contained. Enzyme sequestration as a source of ultrasensitivity is also established [4,5,8]. We do not claim to introduce that mechanism.

The related thermodynamic response inequalities of Owen, Gingrich, and Horowitz [2] concern controlled changes of transition rates. Their covalent-switch application treats free enzyme concentrations as inputs or takes a low-substrate regime. Our total-concentration response has an additional conservation feedback. Qian [6] already treated a reversible elementary covalent cycle and its thermodynamic driving. The present result concerns the exact finite-total constraints, rather than introducing that kinetic model. Response-fluctuation inequalities for reaction-rate perturbations [7] likewise use a different perturbation class.

Two further distinctions are relevant. The support-size bound of Owen and Horowitz [9] concerns a fixed finite Markov scheme in which the input multiplies specified transition rates. The Hill sharpness barrier of Martinez-Corral et al. [10] assumes, among other conditions, an undepleted free-ligand reservoir and equilibrium. A conserved enzyme-total perturbation with self-consistent sequestration is not either parameterization. We do not claim to violate those theorems.

Throughout, kinetic optimization allows arbitrary positive rate constants constrained by the stated cycle affinity. It does not fix every step's equilibrium constant or the full standard chemical-potential landscape. In a derivative, however, all rate constants are held fixed. The upper bounds do not imply uniform bounds for a different output, such as the absolute concentration of all modified substrate, or under a finite-time observation rule. The unbounded family has vanishing free substrate and flux. No claim of unlimited speed, power, dynamic range, molecular precision, or experimental attainability is made.

# 2. Exact steady model and response variables

## 2.1 Positive reduced model

Let $x,y>0$ denote the free concentrations of unmodified and modified substrate. Let $e,f>0$ denote the conserved totals of the forward and reverse enzymes, and let $S>0$ be total substrate. All eight kinetic coefficients

$$
a,b,c,d,A,B,C,D
$$

are strictly positive. Put

$$
D_E=1+ax+by,\qquad D_F=1+cx+dy.
\tag{1}
$$

The steady equations are

$$
G(x,y)=e\frac{Ax-By}{D_E}-f\frac{Dy-Cx}{D_F}=0,
\tag{2}
$$

$$
T(x,y)=x+y+e\frac{ax+by}{D_E}
              +f\frac{cx+dy}{D_F}=S.
\tag{3}
$$

For comparison with [1], $a,b,c,d$ are the reciprocals of its four total generalized Michaelis-Menten constants, and $(A,B,C,D)$ correspond to $(c_0^E,c_1^E,c_0^F,c_1^F)$. Equations (2)-(3) are its steady reduction. Our mathematical theorems are stated for this explicit positive coefficient model. Their interpretation for more elaborate mechanisms uses the established reduction in [1,3]; we do not assert a new graph-theoretic reduction. Section 3 derives an elementary realization directly, so all extremal constructions are independent of that external reduction.

The dimensionless cycle affinity and the common steady flux are

$$
\mathcal A=\log\chi,\qquad \chi=\frac{AD}{BC},\qquad
J=e\frac{Ax-By}{D_E}=f\frac{Dy-Cx}{D_F}.
\tag{4}
$$

Physical chemical work per completed cycle is $k_BT\mathcal A$. Fuel and waste activities are chemostatted and absorbed into effective rates; the driven cycle is not a closed fuel-free equilibrium system.

The response of interest is

$$
H_e=\left.\frac{\partial\log(y/x)}{\partial\log e}\right|_{S,f,\,\mathrm{kinetics}},\qquad
H_f=\left.\frac{\partial\log(y/x)}{\partial\log f}\right|_{S,e,\,\mathrm{kinetics}}.
\tag{5}
$$

These are derivatives along the locally unique steady branch. The next result establishes that this branch is globally well defined.

## 2.2 Existence, uniqueness, and smoothness

**Proposition 1 (known uniqueness, self-contained proof).** For every positive choice of coefficients and totals, (2)-(3) has exactly one positive solution. This solution is a smooth function of the positive parameters.

**Proof.** Direct differentiation gives

$$
G_x=\frac{e[A+(Ab+aB)y]}{D_E^2}
    +\frac{f[C+(Cd+cD)y]}{D_F^2}>0,
\tag{6}
$$

$$
G_y=-\frac{e[B+(Ab+aB)x]}{D_E^2}
    -\frac{f[D+(Cd+cD)x]}{D_F^2}<0,
\tag{7}
$$

$$
T_x=1+\frac{ea}{D_E^2}+\frac{fc}{D_F^2}>0,\qquad
T_y=1+\frac{eb}{D_E^2}+\frac{fd}{D_F^2}>0.
\tag{8}
$$

The conservation curve in the closed first quadrant connects a unique positive point on each coordinate axis. Indeed, $T(x,0)$ and $T(0,y)$ increase continuously from zero to infinity. Between the intercepts, the implicit function theorem makes the curve a graph $y=y(x)$ with derivative $-T_x/T_y<0$. Along it, $G$ has derivative $G_x-G_yT_x/T_y>0$. At the $y$-axis intercept $G<0$; at the $x$-axis intercept $G>0$. The intermediate value theorem and strict increase give exactly one zero, and it lies in the positive quadrant. Finally,

$$
\Delta:=G_xT_y-G_yT_x>0
\tag{9}
$$

at every positive point. The implicit function theorem gives smooth parameter dependence near each solution, and uniqueness joins these local branches. $\square$

**Lemma 2 (flux sign and ratio interval).** The sign of $J$ is the sign of $AD-BC$. If $\chi>1$, then

$$
\frac CD \lt r:=\frac yx<\frac AB.
\tag{10}
$$

If $\chi<1$, the inequalities reverse. If $\chi=1$, then $r=A/B=C/D$ and $J=0$.

**Proof.** Equation (2) rearranges to

$$
r=\frac{(e/D_E)A+(f/D_F)C}{(e/D_E)B+(f/D_F)D}.
\tag{11}
$$

This is a strictly weighted average of $A/B$ and $C/D$, with weights $(e/D_E)B$ and $(f/D_F)D$. The sign assertion follows from $J=ex(A-Br)/D_E$. The coincident-ratio case follows directly. $\square$

# 3. Elementary reversible realization and affinity

**Proposition 3 (no hidden feasibility relaxation).** Every positive eight-tuple in Section 2 is realized by two elementary one-complex reversible enzyme mechanisms. Their effective cycle forward/reverse rate-product ratio is $AD/(BC)$.

**Proof.** For $E$, use

$$
E+X\ \rightleftharpoons\ Z_E\ \rightleftharpoons\ E+Y.
\tag{12}
$$

Write $p_{E0},p_{E1}$ for association rates from $X,Y$, and $q_{E0},q_{E1}$ for releases to $X,Y$. Choose

$$
q_{E0}=B/b,\quad q_{E1}=A/a,\quad
p_{E0}=a(q_{E0}+q_{E1}),\quad
p_{E1}=b(q_{E0}+q_{E1}).
\tag{13}
$$

At steady state,

$$
Z_E=(ax+by)E_{\mathrm{free}},\quad
E_{\mathrm{free}}=e/D_E,
\tag{14}
$$

and net production of $Y$ through this enzyme equals
$q_{E1}Z_E-p_{E1}E_{\mathrm{free}}y=e(Ax-By)/D_E$.
For $F+X\rightleftharpoons Z_F\rightleftharpoons F+Y$, choose

$$
q_{F0}=D/d,\quad q_{F1}=C/c,\quad
p_{F0}=c(q_{F0}+q_{F1}),\quad
p_{F1}=d(q_{F0}+q_{F1}).
\tag{15}
$$

Its net production of $X$ is $f(Dy-Cx)/D_F$, and $Z_F=f(cx+dy)/D_F$. Conservation of $X,Y,Z_E,Z_F$ gives (3). Every displayed rate is positive. Around the forward catalytic cycle,

$$
\frac{p_{E0}q_{E1}p_{F1}q_{F0}}
     {q_{E0}p_{E1}q_{F1}p_{F0}}
=\frac{AD}{BC}.
\tag{16}
$$

Thus the extremal constructions below are genuine elementary mechanisms. $\square$

For clarity, local detailed balance can be imposed explicitly. In fixed reference concentration units define

$$
K_1=p_{E0}/q_{E0},\quad K_2=q_{E1}/p_{E1},\quad
K_3=p_{F1}/q_{F1},\quad K_4=q_{F0}/p_{F0}.
$$

Measure standard chemical potentials in units of $k_BT$. Set those of $X,E,F$ to zero, and take

$$
\mu_{Z_F}=\log K_4,\quad
\mu_Y=\log(K_3K_4),\quad
\mu_{Z_E}=\log(K_2K_3K_4).
\tag{17}
$$

Couple the first oriented association step to a chemostatted fuel-to-waste conversion with chemical-potential difference $\log\chi$. For that step the reactant-minus-product potential is $\log\chi-\mu_{Z_E}=\log K_1$; the other three differences are $\log K_2,\log K_3,\log K_4$. This verifies local detailed balance on every edge. Standard potentials may vary between mechanisms; a fixed cycle affinity does not impose a fixed potential landscape. In particular $\mu_Y-\mu_X=\log(D/C)$. The general sharpness families below need not preserve this difference. The critical family in Section 7 does preserve it, as well as the fuel driving. No sharpness claim is made for the additional constraint of fixing every standard potential.

# 4. Monotonicity for every affinity

**Theorem 4 (total-enzyme response signs).** At every positive steady state,

$$
\operatorname{sign}H_e=\operatorname{sign}(\chi-1),\qquad
\operatorname{sign}H_f=-\operatorname{sign}(\chi-1).
\tag{18}
$$

Consequently the free substrate ratio is strictly increasing in $e$ and strictly decreasing in $f$ when $\chi>1$, throughout the positive parameter domain. At equilibrium $\chi=1$, both responses vanish identically. Opposite driving reverses the signs.

**Proof.** Define $U_E=ax+by$ and $U_F=cx+dy$. Differentiate the two original equations with respect to $e$, while keeping $S,f$ and kinetics fixed. Cramer's rule and (9) give

$$
H_e=\frac{J}{xy\Delta}
\left[x+y+\frac{fU_F}{D_F^2}+\frac{eU_E}{D_ED_F}\right].
\tag{19}
$$

Here is a direct algebraic verification. With $v_E=(Ax-By)/D_E$ and $u=U_E/D_E$, implicit differentiation yields

$$
x_e=\frac{-v_ET_y+G_yu}{\Delta},\qquad
y_e=\frac{v_ET_x-G_xu}{\Delta}.
$$

The identities

$$
xT_x+yT_y=x+y+\frac{eU_E}{D_E^2}+\frac{fU_F}{D_F^2},
$$

$$
xG_x+yG_y=J(D_E^{-1}-D_F^{-1})
$$

reduce $e(y_e/y-x_e/x)$ to (19). The corresponding calculation for $f$ gives

$$
H_f=-\frac{J}{xy\Delta}
\left[x+y+\frac{eU_E}{D_E^2}+\frac{fU_F}{D_ED_F}\right].
\tag{20}
$$

All factors except $J$ and the displayed minus sign are strictly positive. Lemma 2 proves (18). Global strict monotonicity follows because Proposition 1 provides a smooth branch for every positive total and its derivative has the specified strict sign. $\square$

# 5. Exact response decomposition and sharp occupancy envelope

From now through Section 8, assume $\chi=k^2>1$, with $k>1$. Define the enzyme occupancies and the conditional binding contributions

$$
u=\frac{ax+by}{D_E},\quad v=\frac{cx+dy}{D_F},\qquad
\beta_E=\frac{by}{ax+by},\quad \beta_F=\frac{dy}{cx+dy}.
\tag{21}
$$

All four quantities lie strictly between zero and one. Occupancy is not a substrate modification fraction. Put $w=x+y$ and

$$
M=w+eu(1-u)+fv(1-v),\qquad
\Lambda=w+(1-v)(eu+fv),
\tag{22}
$$

$$
Z=e(1-u)+f(1-v),\quad
P_E=u(w+vZ),\quad P_F=v(w+uZ),
\tag{23}
$$

$$
R=vx+uy+uvZ.
\tag{24}
$$

The flux contribution to logarithmic inverse response is

$$
\kappa=\frac{Dr}{Dr-C}+\frac{Br}{A-Br},\qquad
\kappa_*:=\frac{k+1}{k-1}.
\tag{25}
$$

**Lemma 5 (affinity contribution).** One has $\kappa\ge\kappa_*>1$, with equality exactly when $r=\sqrt{AC/(BD)}$.

**Proof.** Let $\ell=C/D$ and $t=r/\ell$. Lemma 2 gives $1 \lt t \lt k^2$. Elementary algebra yields

$$
\kappa-\kappa_*=
\frac{k+1}{k-1}\,
\frac{(t-k)^2}{(t-1)(k^2-t)}\ge0.
\tag{26}
$$

Equality is equivalent to $t=k$. $\square$

**Lemma 6 (exact finite-resource response).** The response equals

$$
H_e=\frac{\Lambda}{N},\qquad
N=\kappa M+P_E\beta_E-P_F\beta_F-(u-v)y.
\tag{27}
$$

Equivalently,

$$
N=\kappa M-R+P_E\beta_E+P_F(1-\beta_F).
\tag{28}
$$

**Proof.** Use differentials $dt=d\log r$, $dz=d\log x$, and $dq=d\log e$. The logarithm of the flux relation is

$$
\log(e/f)=\log\frac{Dr-C}{A-Br}+\log D_E-\log D_F.
$$

Its differential is

$$
dq=(\kappa+u\beta_E-v\beta_F)dt+(u-v)dz.
\tag{29}
$$

The conservation differential at fixed $S,f$ is

$$
0=Mdz+Qdt+eu\,dq,
\qquad Q=y+eu(1-u)\beta_E+fv(1-v)\beta_F.
\tag{30}
$$

Eliminating $dz$ gives

$$
[M+(u-v)eu]dq=
[\kappa M+M(u\beta_E-v\beta_F)-(u-v)Q]dt.
$$

The first bracket is $\Lambda$. Expanding the second gives $N$ in (27). The identity $P_F+(u-v)y=R$ gives (28). $\square$

**Lemma 7 (positive denominator margin).** The quantities $M,\Lambda,P_E,P_F$ are positive, and

$$
M-R=(1-v)x+(1-u)y+(1-u)(1-v)(eu+fv)>0.
\tag{31}
$$

In particular $N>\kappa_*M-R>(\kappa_*-1)M>0$.

**Proof.** Positivity follows from (21)-(23). Expanding $M-R$ gives (31); (28) and Lemma 5 then prove the strict inequalities. $\square$

**Theorem 8 (sharp envelope at fixed occupancies).** Fix $x,y,e,f>0$, $u,v\in(0,1)$, and $k>1$, and set $S=x+y+eu+fv$. Over all positive kinetic coefficients for which these data form the steady state and $AD/(BC)=k^2$,

$$
\boxed{\displaystyle\sup H_e=
\frac{\Lambda}{\kappa_*M-R}.}
\tag{32}
$$

No finite positive coefficient choice attains this supremum. Elementary reversible one-complex mechanisms approach it while all the stated data remain fixed.

**Proof.** Lemma 7 gives the strict upper bound. For the matching construction choose arbitrary $\beta_E,\beta_F\in(0,1)$ and reconstruct

$$
a=\frac{u(1-\beta_E)}{(1-u)x},\quad
b=\frac{u\beta_E}{(1-u)y},\quad
c=\frac{v(1-\beta_F)}{(1-v)x},\quad
d=\frac{v\beta_F}{(1-v)y}.
\tag{33}
$$

Set $r=y/x$ and $h=(e/f)(1-u)/(1-v)$, and take

$$
A=kr,\qquad B=1,\qquad C=hr,\qquad D=kh.
\tag{34}
$$

These coefficients satisfy (2), have affinity $k^2$, and have $\kappa=\kappa_*$. The occupancies and conservation equation are exactly the prescribed ones. Proposition 1 ensures that this constructed state is the actual unique steady state. Taking $\beta_E=\delta$, $\beta_F=1-\delta$ for $0<\delta<1$ gives the exact response

$$
H_e(\delta)=
\frac{\Lambda}{\kappa_*M-R+\delta(P_E+P_F)}.
\tag{35}
$$

Letting $\delta\downarrow0$ proves (32). Proposition 3 realizes every member by positive elementary rates. Strict nonattainment follows because $P_E\beta_E+P_F(1-\beta_F)>0$. $\square$

# 6. Fixed-total bounds and the critical resource surface

Define

$$
h_\infty=\frac{k-1}{2}=\frac1{\kappa_*-1}.
\tag{36}
$$

For fixed $S,e,f,k>0$ with $k>1$, let $\mathcal H(S,e,f;k)$ be the supremum of $H_e$ over all positive eight-tuples with affinity $k^2$, evaluated at their unique steady states with those totals. This set of mechanisms is nonempty: choose any $u,v\in(0,1)$ with $eu+fv \lt S$, split the positive remainder into $x,y$, and use (33)-(34).

**Lemma 9 (conservation amplification).** At every such steady state,

$$
0 \lt H_e \lt h_\infty\,\Gamma,\qquad
\Gamma:=\frac{\Lambda}{M}
=\frac{S-euv-fv^2}{S-eu^2-fv^2}.
\tag{37}
$$

If $S>e$ then $\Gamma \lt S/(S-e)$. If $S \lt e$ then $\Gamma \lt e/(e-S)$.

**Proof.** The first inequality is Lemma 7, and $S=w+eu+fv$ gives the rational expression. For $S>e$, the exact identity

$$
SM-(S-e)\Lambda
=e\{S(1-u)(1+u-v)+wv\}>0
\tag{38}
$$

proves the claim. For $S \lt e$, conservation implies $u \lt S/e<1$. If $u\le v$, then $\Gamma=1+eu(u-v)/M\le1 \lt e/(e-S)$. If $u>v$, then $M>eu(1-u)$ and

$$
\Gamma<1+\frac{u-v}{1-u}
=\frac{1-v}{1-u}<\frac1{1-u}<\frac e{e-S}.
\tag{39}
$$

This proves both cases. $\square$

**Theorem 10 (fixed-total response classification).** For every $e,f,S>0$ and $k>1$:

1. If $S>e$, then
   $$
   \mathcal H(S,e,f;k)=h_\infty\frac S{S-e}.
   \tag{40}
   $$
2. If $S \lt e$, then
   $$
   \mathcal H(S,e,f;k)\le h_\infty\frac e{e-S}<\infty.
   \tag{41}
   $$
   We do not claim that (41) is sharp.
3. If $S=e$, then $\mathcal H(S,e,f;k)=+\infty$.

Thus $\mathcal H(S,e,f;k)$ is finite if and only if $S\ne e$. The supremum in (40) is not attained by finite positive coefficients.

**Proof.** Lemma 9 gives finiteness, the upper bounds, and strictness for each finite mechanism. We prove the matching above-critical construction now; Section 7 proves the critical assertion.

Fix $S>e$. For sufficiently small $\delta>0$ set

$$
u=1-\delta,\quad v=\delta,\quad
w=S-e+\delta(e-f)>0,
\tag{42}
$$

$$
x=\frac{w\delta}{1+\delta},\quad y=\frac w{1+\delta},\quad
\beta_E=\delta,\quad\beta_F=1-\delta.
\tag{43}
$$

For example, $\delta<\min\{1/2,(S-e)/[2(e+f)]\}$ suffices for positivity. Construct the coefficients by (33)-(34). All three totals and the affinity remain fixed. As $\delta\downarrow0$,

$$
M\longrightarrow S-e,\quad
\Lambda\longrightarrow S,\quad
R\longrightarrow S-e.
\tag{44}
$$

The term $\delta(P_E+P_F)$ tends to zero: the occupancies, concentrations, and totals in (42)-(43) stay bounded. Equation (35), now applied to each varying geometry, therefore gives

$$
H_e\longrightarrow\frac S{(\kappa_*-1)(S-e)}.
$$

This is (40). Strictness in Lemma 9 rules out finite attainment. $\square$

**Corollary 11 (a measurable free-substrate safeguard).** If $(x+y)/S\ge\eta>0$, then

$$
H_e \lt h_\infty/\eta.
\tag{45}
$$

**Proof.** Since $\Lambda \lt S$ and $M>x+y$, equation (37) gives $H_e \lt h_\infty S/(x+y)\le h_\infty/\eta$. No optimality assertion is made for this simplified bound. $\square$

Theorem 10 classifies a supremum over kinetic models. A single fixed positive model always has a finite, smooth response, including when its totals satisfy $S=e$. The singularity occurs only along sequences of models. At equilibrium $k=1$, Theorem 4 gives zero response everywhere; the assumption $k>1$ is essential to the critical classification.

# 7. A stable, reversible family with fixed totals and affinity

## 7.1 Explicit critical family

**Theorem 12 (critical construction).** Fix design constants $E_0,F_0>0$ and $k>1$. For

$$
0<\varepsilon<\min(E_0/3,F_0),
\tag{46}
$$

set the baseline totals $S=e=E_0$, $f=F_0$, and choose

$$
a=b=\frac{E_0-3\varepsilon}{6\varepsilon^2},\qquad
c=d=\frac1{2(F_0-\varepsilon)},
\tag{47}
$$

$$
h=\frac{3\varepsilon}{F_0-\varepsilon},\qquad
A=k,\quad B=1,\quad C=h,\quad D=kh.
\tag{48}
$$

The unique steady state is $x=y=\varepsilon$, and the affinity is $\log\chi=2\log k$. Its sensitivity is

$$
H_e=\frac{E_0-(E_0/F_0)\varepsilon+(2/F_0)\varepsilon^2}
{\kappa_*[6\varepsilon-(9/E_0+1/F_0)\varepsilon^2]}
\sim\frac{E_0}{6\kappa_*\varepsilon}\longrightarrow\infty.
\tag{49}
$$

In computing this derivative, $E_0,F_0,\varepsilon,k$ in the rate design (47)-(48) are frozen. Only the enzyme total $e$ is perturbed around $E_0$; $S=E_0$ remains fixed. The perturbation does not move along a path with $S=e$.

**Proof.** At the claimed state,

$$
u=1-3\varepsilon/E_0,\quad v=\varepsilon/F_0,
\quad Z_E=E_0-3\varepsilon,\quad Z_F=\varepsilon.
\tag{50}
$$

Equation (3) follows by adding $2\varepsilon+Z_E+Z_F=E_0$. Both sides of (2) equal

$$
J=3(k-1)\varepsilon^2.
\tag{51}
$$

The affinity follows from (48), and Proposition 1 gives uniqueness. At this state $r=1$, $\beta_E=\beta_F=1/2$, $\kappa=\kappa_*$, and

$$
M=6\varepsilon-(9/E_0+1/F_0)\varepsilon^2,\qquad
\Lambda=E_0-(E_0/F_0)\varepsilon+(2/F_0)\varepsilon^2.
\tag{52}
$$

In (30), $Q=M/2$. Equation (27) therefore reduces to $H_e=\Lambda/(\kappa_*M)$, proving (49). The positivity of $M$ also follows directly from (22); no sign assumption on a formal denominator is needed. Taking the elementary limit proves unboundedness, completing Theorem 10. $\square$

**Example 13 (all totals equal to one).** For $E_0=F_0=1$,

$$
H_e=\frac{k-1}{k+1}\,
\frac{1-\varepsilon+2\varepsilon^2}{6\varepsilon-10\varepsilon^2}.
\tag{53}
$$

With $k=2$ and $\varepsilon=1/10$, this is $46/75>1/2$, whereas the conjectured affinity-only ceiling is $h_\infty=1/2$. Decreasing $\varepsilon$ gives arbitrarily larger violations with the same three totals and the same affinity.

## 7.2 Elementary rates and local stability

For the family in Theorem 12, the rates from Proposition 3 can be written particularly simply:

| Rate | Value |
| --- | --- |
| $p_{E0}=p_{E1}$ | $k+1$ |
| $q_{E0}$ | $6\varepsilon^2/(E_0-3\varepsilon)$ |
| $q_{E1}$ | $6k\varepsilon^2/(E_0-3\varepsilon)$ |
| $p_{F0}=p_{F1}$ | $3\varepsilon(k+1)/(F_0-\varepsilon)$ |
| $q_{F0}$ | $6k\varepsilon$ |
| $q_{F1}$ | $6\varepsilon$ |

Every rate is positive for every finite member. On any interval $0<\varepsilon\le\varepsilon_0<\min(E_0/3,F_0)$, all rates are uniformly bounded above; some approach zero. In the chemical-potential assignment (17), $K_3K_4=k$, so both the substrate potential difference $\mu_Y-\mu_X=\log k$ and the fuel driving $2\log k$ can be fixed along the family. Binding energies of the intermediate states vary.

**Proposition 14 (local asymptotic stability).** Every finite member of the critical family has a locally asymptotically stable steady state in the stoichiometric compatibility class of the full elementary mass-action system.

**Proof.** Write $z=Z_E$, $q=Z_F$, and $s=x+y=S-z-q$. Let $\alpha=p_{E0}=p_{E1}$, $\gamma=p_{F0}=p_{F1}$, $\lambda=q_{E0}+q_{E1}$, and $\mu=q_{F0}+q_{F1}$. The complex concentrations obey the closed system

$$
\dot z=\alpha(e-z)(S-z-q)-\lambda z,\qquad
\dot q=\gamma(f-q)(S-z-q)-\mu q.
\tag{54}
$$

At its positive steady state set

$$
p=\alpha(e-z)>0,\quad t=\gamma(f-q)>0,\quad
L_E=\alpha s+\lambda>0,\quad L_F=\gamma s+\mu>0.
$$

The Jacobian of (54) is

$$
\begin{pmatrix}-(p+L_E)&-p\\-t&-(t+L_F)\end{pmatrix}.
\tag{55}
$$

Its trace is negative and its determinant is $pL_F+tL_E+L_EL_F>0$, so both eigenvalues have negative real parts. The remaining independent coordinate may be taken as $y$, whose equation is

$$
\dot y=q_{E1}z+q_{F1}q-
[\alpha(e-z)+\gamma(f-q)]y.
\tag{56}
$$

Thus the full three-dimensional Jacobian is block triangular with the two eigenvalues above and the additional eigenvalue $-(p+t)<0$. The vector field is smooth and the steady state is interior to its compatibility class. The local linearization stability theorem therefore gives local asymptotic stability. This statement does not assert global convergence or a uniform relaxation rate. $\square$

## 7.3 A second exact rational witness

**Example 15.** Take

$$
x=y=1,\quad e=5,\quad f=1,\quad S=7,
\qquad a=b=9/2,\ c=d=1/2,
$$

$$
(A,B,C,D)=(2,1,1,2).
\tag{57}
$$

The affinity is $\log4$, occupancies are $u=9/10$, $v=1/2$, and (2)-(3) hold exactly. Here $M=27/10$, $\Lambda=9/2$, $\kappa=3$, and $\beta_E=\beta_F=1/2$, giving $H_e=5/9>1/2$. As a check directly from the original equations,

$$
(x_e,y_e)=(-7/18,-5/18),\qquad
H_e=e(y_e/y-x_e/x)=5[(-5/18)-(-7/18)]=5/9.
$$

# 8. Interpretation, limitations, and reproducibility

The affinity-only high-substrate constant $h_\infty$ does not extend to arbitrary finite totals. More strongly, no finite ceiling depending only on the fixed affinity and the three fixed totals can hold at $S=e$. Above that surface the exact repair is the factor $S/(S-e)$. Below it we prove finiteness; determining the sharp subcritical supremum is outside the present result.

These statements do not invalidate the established fixed-kinetics asymptotic theorems in [1]. Theorem 12 changes kinetics along a family and keeps substrate total fixed. The established low-substrate limit instead sends $S$ to zero with kinetics fixed. Theorem 10 also gives $\mathcal H(S,e,f;k)\to h_\infty$ as $S\to\infty$ with $e,f,k$ fixed, consistently recovering the high-substrate constant at the level of optimized suprema.

The free-ratio observable matters: the construction has $x=y\to0$, while almost all substrate is bound to the forward enzyme. Its flux is exactly (51), which tends to zero. High stationary logarithmic sensitivity alone says nothing about a fixed-throughput, fixed-power, fixed-noise, or fixed-time sensing task. The elementary rates can be bounded above along the critical family, but cannot all remain bounded away from zero. These restrictions are part of the theorem's scope, not hidden resources.

![Analytic response families at affinity $\log4$. Left: the stable critical family with $S=e=f=1$ grows as $1/(18\varepsilon)$, crossing the high-substrate ceiling $1/2$. Right: for $e=f=1$ and $S>1$, the exact ceiling $S/[2(S-1)]$ is approached by the positive-rate construction (42)-(43) with $\delta=10^{-4}$. Curves are model calculations, not experimental data.](figures/response_frontier.png)

The mathematical results apply directly to the positive reduced model (1)-(3), with an explicit unconditional bridge to the elementary mass-action mechanisms. The previously published reduction from larger enzyme graphs is attributed to [1,3]. We do not include networks with multiple substrate molecules in one complex, additional feedback species, enzyme synthesis/degradation, or externally imposed total-substrate changes in the derivative.

The associated reproducibility script evaluates identities from the original steady equations, checks exact rational witnesses, and compares the analytic response with perturbed-total steady solutions at high precision while holding the designed kinetics fixed. It also examines approach to the sharp envelopes. These finite checks can expose implementation and algebra mistakes; the proofs above establish the universal quantifiers and limiting claims.

Qian and Reluga [11] study nonlinear feedback and hysteresis in a reversible phosphorylation cycle. The fixed-total response studied here is for a model without that feedback. The comparison with Roy and Gangopadhyay [12] uses the publisher preview and publicly accessible appendices. The article's main full text was unavailable. The comparison with Qian [6] uses the complete accepted author manuscript. The novelty comparison is limited to the cited sources and the material available for comparison.

# References

1. J. A. Owen, P. Talla, J. W. Biddle, and J. Gunawardena. Thermodynamic bounds on ultrasensitivity in covalent switching. *Biophysical Journal* **122**(10), 1833-1845 (2023). [doi:10.1016/j.bpj.2023.04.015](https://doi.org/10.1016/j.bpj.2023.04.015).

2. J. A. Owen, T. R. Gingrich, and J. M. Horowitz. Universal Thermodynamic Bounds on Nonequilibrium Response with Biochemical Applications. *Physical Review X* **10**, 011066 (2020). [doi:10.1103/PhysRevX.10.011066](https://doi.org/10.1103/PhysRevX.10.011066).

3. T. Dasgupta, D. H. Croll, J. A. Owen, M. G. Vander Heiden, J. W. Locasale, U. Alon, L. C. Cantley, and J. Gunawardena. A fundamental trade-off in covalent switching and its circumvention by enzyme bifunctionality in glucose homeostasis. *Journal of Biological Chemistry* **289**, 13010-13025 (2014). [doi:10.1074/jbc.M113.546515](https://doi.org/10.1074/jbc.M113.546515).

4. B. M. C. Martins and P. S. Swain. Ultrasensitivity in Phosphorylation-Dephosphorylation Cycles with Little Substrate. *PLOS Computational Biology* **9**(8), e1003175 (2013). [doi:10.1371/journal.pcbi.1003175](https://doi.org/10.1371/journal.pcbi.1003175).

5. S. Feng, J. F. Ollivier, and O. S. Soyer. Enzyme Sequestration as a Tuning Point in Controlling Response Dynamics of Signalling Networks. *PLOS Computational Biology* **12**(5), e1004918 (2016). [doi:10.1371/journal.pcbi.1004918](https://doi.org/10.1371/journal.pcbi.1004918).

6. H. Qian. Thermodynamic and kinetic analysis of sensitivity amplification in biological signal transduction. *Biophysical Chemistry* **105**, 585-593 (2003). [doi:10.1016/S0301-4622(03)00068-1](https://doi.org/10.1016/S0301-4622(03)00068-1).

7. H.-M. Chun and J. M. Horowitz. Trade-offs between number fluctuations and response in nonequilibrium chemical reaction networks. *Journal of Chemical Physics* **158**, 174115 (2023). [doi:10.1063/5.0148662](https://doi.org/10.1063/5.0148662).

8. S. Legewie, N. Blüthgen, R. Schäfer, and H. Herzel. Ultrasensitization: Switch-Like Regulation of Cellular Signaling by Transcriptional Induction. *PLOS Computational Biology* **1**(5), e54 (2005). [doi:10.1371/journal.pcbi.0010054](https://doi.org/10.1371/journal.pcbi.0010054).

9. J. A. Owen and J. M. Horowitz. Size limits the sensitivity of kinetic schemes. *Nature Communications* **14**, 1280 (2023). [doi:10.1038/s41467-023-36705-8](https://doi.org/10.1038/s41467-023-36705-8).

10. R. Martinez-Corral, K.-M. Nam, A. H. DePace, and J. Gunawardena. The Hill function is the universal Hopfield barrier for sharpness of input–output responses. *Proceedings of the National Academy of Sciences USA* **121**(22), e2318329121 (2024). [doi:10.1073/pnas.2318329121](https://doi.org/10.1073/pnas.2318329121).

11. H. Qian and T. C. Reluga. Nonequilibrium Thermodynamics and Nonlinear Kinetics in a Cellular Signaling Switch. *Physical Review Letters* **94**, 028101 (2005). [doi:10.1103/PhysRevLett.94.028101](https://doi.org/10.1103/PhysRevLett.94.028101). [Author-hosted full text](https://reluga.org/Qian05.pdf).

12. P. Roy and G. Gangopadhyay. Non-equilibrium thermodynamics of Phosphorylation–dephosphorylation ultrasensitive transition and critical behavior of MAPK cascade circuits. *Journal of Chemical Sciences* **138**, 95 (2026). [doi:10.1007/s12039-026-02528-5](https://doi.org/10.1007/s12039-026-02528-5). Publisher preview and appendices consulted.
