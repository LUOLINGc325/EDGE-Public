# Sharp coarse-graining bounds for Lüders order scores

## Abstract

Suppose the effects of the measurement being merged are scalar on each of the two eigenspaces of a fixed Hermitian involution. On every input state, merging outcomes and using the new Lüders instrument amplifies the total-variation order score by at most two, in all finite dimensions. The retained square-root deficit gives a stronger instance-dependent bound. The uniform factor two is sharp already for qubits with three effects on each side, even when only one pair is merged. If both measurements have this two-eigenspace form, all merges on either side are nonexpansive on every state. For a qubit partner with arbitrary effects, we characterize precisely when every diagonal measurement is pointwise nonexpansive under merging. The criterion groups the partner effects by a direction of their diagonal-axis disturbance and requires a cancellation of their off-diagonal components within each group.

## 1. The order score and a two-eigenspace measurement

Let $A=(A_i)_i$ and $B=(B_j)_j$ be finite POVMs on a finite-dimensional complex Hilbert space. On density matrix $\rho$, compare the same joint labels $(i,j)$ under the two Lüders schedules. Put
$$
\begin{aligned}
 D_{ij}&=\sqrt{A_i}B_j\sqrt{A_i}-\sqrt{B_j}A_i\sqrt{B_j},\\
 T_\rho(A,B)&=\tfrac12\sum_{i,j}|\operatorname{Tr}(\rho D_{ij})|,
 \qquad T(A,B)=\max_\rho T_\rho(A,B).
\end{aligned}
$$
A partition $\mathcal G$ of the $i$ labels represents a merge. Replace $A_i$ by $\bar A_G=\sum_{i\in G} A_i$ and use its positive square root for the new outcome operation. The distinct operation of forgetting labels in each existing classical record is already contractive. The two operations generally induce different sequential records.

Fix a Hermitian involution $S$ and write $A_i=m_iI+\gamma_i S$, with $m_i\ge|\gamma_i|$, $\sum_i m_i=1$, and $\sum_i\gamma_i=0$. If one eigenspace of $S$ is trivial, $A$ is scalar and all scores here are zero. We can therefore assume both eigenspaces are nonzero. Set
$$
 \eta_i=m_i-\sqrt{m_i^2-\gamma_i^2},\qquad
 \operatorname{off}_S(B)=\tfrac12(B-SBS).
$$
Use $(m_G,\gamma_G)$ for the sums over a block and compute $\eta_G'$ from that pair. Let $E=\sum_i\eta_i$ and $E'=\sum_G\eta_G'$. The diagonal blocks of $\sqrt{A_i}B\sqrt{A_i}$ are scaled by $m_i\pm\gamma_i$ and the off-diagonal blocks by $\sqrt{m_i^2-\gamma_i^2}$. Thus, for arbitrary $B$,
$$
 \sqrt{A_i}B\sqrt{A_i}=m_iB+\tfrac{\gamma_i}{2}(SB+BS)
                            -\eta_i\operatorname{off}_S(B).
 \tag{1}
$$
Write $V_j=\operatorname{off}_S(B_j)$ and $U_j=(SB_j+B_jS)/2-\sqrt{B_j}S\sqrt{B_j}$. Equation (1) gives
$$
                  D_{ij}=\gamma_iU_j-\eta_i V_j .
 \tag{2}
$$
For each block $G$, Cauchy–Schwarz applied to the nonnegative vectors with entries $\sqrt{m_i+\gamma_i}$ and $\sqrt{m_i-\gamma_i}$ gives
$$
 \sqrt{m_G^2-\gamma_G^2}\ge \sum_{i\in G}\sqrt{m_i^2-\gamma_i^2},
 \qquad 0\le\eta_G'\le\sum_{i\in G}\eta_i .
 \tag{3}
$$

## 2. Sharp universal bound

**Theorem 1.** For every state and every partner $B$, if $E>0$ then
$$
 T_\rho(\bar A,B)\le (2-E'/E)\,T_\rho(A,B)\le 2T_\rho(A,B).
 \tag{4}
$$
The same inequalities hold for the scores optimized over states. If $E=0$ both scores vanish. A ratio of two is approached by the qubit family in §3. At nonzero fine score the ratio is always strictly less than two.

**Proof.** Write $u_j=\operatorname{Tr}\rho U_j$ and $v_j=\operatorname{Tr}\rho V_j$. The fine scalar records in column $j$ sum to $-Ev_j$. The triangle inequality in each column gives $T_\rho(A,B)\ge (E/2)\sum_j |v_j|$. First aggregate the old signed records within a block. The actual new signed record differs from that aggregate by $(\sum_{i\in G}\eta_i-\eta_G')v_j$. Another triangle inequality, followed by (3), gives
$$
 T_\rho(\bar A,B)\le T_\rho(A,B)+\tfrac{E-E'}{2}\sum_j|v_j|.
$$
This gives (4) and its optimized version. If $E=0$, all $\gamma_i=0$. If $E'=0$, the coarsened measurement is scalar. For positive fine score, $E'>0$ forces a factor strictly below two. When $E'=0$ the ratio is zero. These arguments require no invertibility of the effects. $\square$

## 3. A sharp family and a rational witness

On a qubit take $S=Z$, $\epsilon\in(0,1/2)$ and $c=1/2$. Let $A_0=(1-c-\epsilon)I$, $A_1=\epsilon |0\rangle\langle0|$ and $A_2=cI+\epsilon|1\rangle\langle1|$. Merge $A_0,A_1$. On the partner side choose $0<t<1$, $e=\sqrt{1-t^2}$ and $\lambda=(1+t)^{-1}$. Put
$$
 B_\pm=\tfrac{\lambda}{2}(I\pm eX-tZ),\qquad
 B_0=\tfrac{2t}{1+t}|0\rangle\langle0|.
$$
They are positive and sum to $I$. The effects $B_\pm$ are rank one with nonzero eigenvalue $\lambda$. The $B_0$ column in (2) vanishes. The two other columns have
$$
 U_\pm=\tfrac{\lambda e}{2}(eZ\pm tX),\qquad
 V_\pm=\pm\tfrac{\lambda e}{2}X .
$$
For example $B_\pm Z B_\pm/\lambda=-t B_\pm$, which directly gives the expression for $U_\pm$.

Set $g=\epsilon/2$. The two nonzero fine rows have pairs $(\gamma/g,\eta/g)=(1,1),(-1,r)$ and the coarse rows have $(1,r'),(-1,r)$, with
$$
 r=\frac{g}{c+g+\sqrt{c(c+\epsilon)}},\qquad
 r'=\frac{g}{1-c-g+\sqrt{(1-c)(1-c-\epsilon)}} .
$$
The common record factor is $g\lambda e/2$. For any state put $x=\operatorname{Tr}\rho X$ and $z=\operatorname{Tr}\rho Z$. The set of $(x,z)$ is the full unit disk. A row with normalized pair $(a,b)$ contributes $\max\{e|az|,\ |at-b||x|\}$ to the score divided by the common factor, by the elementary identity $|p+q|+|p-q|=2\max(|p|,|q|)$. The two normalized state functions are
$$
\begin{aligned}
 F(x,z)&=\max(e|z|,(1-t)|x|)+\max(e|z|,(t+r)|x|),\\
 C(x,z)&=\max(e|z|,|t-r'||x|)+\max(e|z|,(t+r)|x|).
\end{aligned}
$$
As $(\epsilon,t)\to(0,1)$ with $\epsilon>0,t<1$, these functions converge uniformly on the disk to $|x|$ and $2|x|$. The common factor is positive before the limit. The maxima therefore have ratio tending to two, proving sharpness. One can also read both limits on the fixed state $(x,z)=(1,0)$, so the pointwise uniform factor is sharp.

For explicit rational effects take $t=24/25$, $e=7/25$ and $\epsilon=1/20$. Then $0<r<1/40$ and $0<r'<1/36$. The four linear choices in $F$ have maxima $2e$, $1+r$, $\sqrt{e^2+(1-t)^2}$ and $\sqrt{e^2+(t+r)^2}$. The third is at most $2e$ and the fourth is at most $1+r$. Hence $\max F=1+r$. In $C$ the analogous maxima are $2e$, $2t+r-r'$, $\sqrt{e^2+(t-r')^2}$ and $\sqrt{e^2+(t+r)^2}$. The last two are at most $1$ and $1+r$ respectively, and $2t-r'>1$. Thus $\max C=2t+r-r'$. In both cases the pure state with $x=1,z=0$ attains the maximum. In particular
$$
               \frac{T(\bar A,B)}{T(A,B)}
               =\frac{2t+r-r'}{1+r}
               >\frac{48/25-1/36}{41/40}>\frac95 .
 \tag{5}
$$
Every effect of both measurements is rational at this instance. In any higher dimension include the qubit as a direct summand and take $S$ to restrict to its $Z$. Define $A$ on the whole space by the same $m_i,\gamma_i$. On the complementary summand choose $B_0=I$ and $B_\pm=0$. Only the qubit summand contributes to the records in (2). The optimized scores and the sharp ratio are unchanged. This establishes optimality in every finite dimension at least two.

## 4. Monotonicity for two noisy binary measurements

**Theorem 2.** Suppose $B_j=n_jI+\delta_j T$ for another Hermitian involution $T$, with $n_j\ge|\delta_j|$, $\sum_j n_j=1$ and $\sum_j\delta_j=0$. For every density matrix, arbitrary merging on either side or both sides cannot increase the score. This includes any two qubit POVMs whose effects commute within each measurement, regardless of their outcome counts or whether the two measurements commute with one another.

**Proof.** Let $\beta_j=n_j-\sqrt{n_j^2-\delta_j^2}$. Applying (1) with the roles reversed and subtracting gives
$$
  D_{ij}=\gamma_i\beta_j\operatorname{off}_T(S)
         -\eta_i\delta_j\operatorname{off}_S(T).
 \tag{6}
$$
For fixed $\rho$ write $u=\operatorname{Tr}\rho\operatorname{off}_T(S)$ and $v=\operatorname{Tr}\rho\operatorname{off}_S(T)$. For any fixed real $\gamma$, the row function $f(y)=\sum_j|\gamma\beta_j u-y\delta_j v|$ is convex and has a global minimum at $y=0$. Indeed $f(y)\ge|\gamma u\sum_j\beta_j-yv\sum_j\delta_j|=f(0)$ since $\beta_j\ge0$. Thus $f$ is nondecreasing for $y\ge0$. On a block, increase $\eta_G'$ to $\sum_{i\in G}\eta_i$ using (3) and monotonicity. Subadditivity of the absolute value then puts the block cost at most the sum of the original row costs. Interchanging the measurements proves the other merge. After the first merge the algebraic form persists, so the assertion also holds when both sides are merged. A commuting qubit POVM is diagonal in one basis and hence has the required form. Any binary qubit partner is commuting because its effects sum to $I$. $\square$

## 5. A pointwise converse and the qubit ray test

**Theorem 3.** Fix $S$ and a state $\rho$. Set $u_j,v_j$ as in the proof of Theorem 1. All measurements of the form $m_iI+\gamma_i S$ are nonexpansive on this particular state under every merge if and only if
$$
 \left|\sum_{j:u_j\ne0}\operatorname{sgn}(u_j)v_j\right|
                       \le\sum_{j:u_j=0}|v_j|.
 \tag{7}
$$
If the criterion fails, a three-outcome measurement and a merge of two outcomes suffice to show strict increase on $\rho$.

**Proof.** For $\sigma=\pm1$, $\phi_\sigma(t)=\sum_j|\sigma u_j-t v_j|$ is convex. Its right derivative at zero is
$$
 \phi_\sigma'(0+)=-\sigma\sum_{u_j\ne0}\operatorname{sgn}(u_j)v_j
                            +\sum_{u_j=0}|v_j|.
$$
Condition (7) is equivalent to both derivatives being nonnegative. It implies each $\phi_\sigma$ is nondecreasing on $[0,\infty)$. For $\gamma\ne0$, the cost in (2) is $|\gamma|\phi_{\operatorname{sgn}\gamma}(\eta/|\gamma|)$. If $\gamma=0$ the expression $\sum_j|\gamma u_j-\eta v_j|$ is nondecreasing in $\eta\ge0$ directly. The same block argument as in Theorem 2 proves sufficiency.

If (7) fails, choose $\sigma$ with negative right derivative. The function is piecewise linear, hence strictly decreasing on some interval to the right of zero. For $0<g<1/4$, let $A_1=I/4+\sigma gS$, $A_0=I/4$ and $A_2=I-A_0-A_1=I/2-\sigma gS$. Merge $A_0$ and $A_1$. The first contributing row retains its signed $\gamma$ but its $m$ increases from $1/4$ to $1/2$. At fixed $g$, the value
$$
                \eta/g=\frac{g}{m+\sqrt{m^2-g^2}}
$$
strictly decreases with $m$, and both values tend to zero with $g$. Choosing $g$ small puts them in the decreasing interval. The scalar row contributes zero and the other row is unchanged. This gives a strict increase on the chosen state. $\square$

On a qubit fix $S=Z$, using a common change of coordinates when needed. Write $B_j=f_jI+b_j\mathbf n_j\cdot\boldsymbol\sigma$ with $b_j\ge0$, $f_j\ge b_j$ and $|\mathbf n_j|=1$ if $b_j>0$. Let $\mathbf U_j,\mathbf V_j$ be the real vectors of the two traceless operators in (2). Equation (1) for the positive square root of $B_j$ gives
$$
 \mathbf U_j=(f_j-\sqrt{f_j^2-b_j^2})(\mathbf z-n_{j,z}\mathbf n_j),
 \qquad
 \mathbf V_j=b_j(\mathbf n_j-n_{j,z}\mathbf z).
 \tag{8}
$$
If $\mathbf U_j=0$ then $\mathbf V_j=0$. Every other $\mathbf U_j$ has positive $\mathbf z$ component.

**Corollary 4.** For a qubit partner, (7) holds on all states if and only if, for each positive ray represented among the nonzero $\mathbf U_j$,
$$
          \sum_{j:\,\mathbf U_j\text{ lies on that ray}}\mathbf V_j=0 .
 \tag{9}
$$
The criterion characterizes pointwise nonexpansiveness. Its failure proves an increase for some input state, and the optimized upper bound and sharpness are supplied separately by Theorem 1.

**Proof.** The Bloch vector $\mathbf r$ ranges over the unit ball. In every open chamber cut out by the hyperplanes $\mathbf U_j\cdot\mathbf r=0$ for nonzero $\mathbf U_j$, the right side of (7) is zero. The left side is the absolute value of a linear functional with coefficient $\sum_j \operatorname{sgn}(\mathbf U_j\cdot\mathbf r)\mathbf V_j$. Vanishing on the open chamber makes this coefficient zero. For one ray, choose a nonzero point on its orthogonal plane inside the ball and off every other plane. Such a point exists because distinct planes meet that plane in finitely many lines. Crossing there changes only the sign of the group on this ray. Subtracting the two coefficient equalities gives (9). Conversely, if each ray sum vanishes, on any state the terms with nonzero $u_j$ can be grouped by their common sign within each ray. Each group contributes zero to the left side, including when other rays are perpendicular to the state. This proves (7) on boundaries as well. $\square$

## 6. Prior results and exact replay

Wu introduced the optimizable TV, Jensen–Shannon and squared Hellinger order scores, including the event-operator identity in Equation (3). Proposition 1(ii) establishes contraction under classical processing of completed outcome records. The paragraph following it asks about merging effects and rebuilding the Lüders instrument. Section VIII lists it as open. Wu already derived the sharp binary projective qubit formula and a specified unsharp two-outcome formula in Equation (28). Those formulas and classical data processing retain their original attribution. The old rational example in this project proves nonmonotonicity for a binary partner when the measurement being merged need not have commuting effects. The separately archived commuting example proves strict increase on part of one explicit one-parameter three-effect family. Neither gives the sharp factor for all two-eigenspace measurements and arbitrary partners, the positive result for both measurements of this form, or the pointwise and geometric converses proved here. The results address TV. The two other divergences define separate variational questions. [Wu v1, Definition 1, Eq. (3), Proposition 1 and §VIII](https://arxiv.org/pdf/2611.24604v1) · Original binary-partner witness · Earlier commuting family

For the binary projective reduction and its common two-dimensional blocks, see Wu §II.C. The proof here uses the two-eigenspace block identity for arbitrary partners and arbitrary degeneracies, and does not require decomposing the partner. Gudder and Nagy study the operator sequential product and order agreement. The identity for square roots in (1) and all convexity arguments are written out, since the contribution is the resulting sharp comparison and pointwise classification. [Gudder–Nagy, Sequential quantum measurements](https://doi.org/10.1063/1.1407837)

Gudder §3 gives the two sequential products with a stochastic post-processing map. Equations (3.1) and (3.2) show the linearity in the effect applied second and the square root of the sum when the first effect is rebuilt. Equations (3.3) and (3.4) explicitly give the resulting cross terms for sharp effects. These formulas already distinguish the two operations. Theorems 1–3 and the ray test quantify the total-variation consequence. Gao et al. prove coarse-graining monotonicity in Supplemental Proposition 1 for their generalized measurement-induced disturbance when the input commutes with the projective observable being coarse-grained. Their functional is the MED of dephasing channels under that restriction, whereas the present TV score compares two joint records for arbitrary states and the POVM class specified in each theorem. [Gudder, §3](https://arxiv.org/pdf/2109.07019) · [Gao et al., Supplemental Proposition 1](https://arxiv.org/pdf/2208.06210v4)

The accompanying Python standard-library check reconstructs the rational effects, verifies the rank-one products and the row formulas, compares the rational estimates for (5), and checks examples of the pointwise and ray tests. Its output is reproducible without a proof assistant. It certifies finite examples and algebraic substitutions, and the analytic arguments above establish the universal statements. [Exact check](evidence/code/verify.py) · [Fixed output](evidence/results/verification.json)
