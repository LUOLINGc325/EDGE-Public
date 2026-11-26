# Universal finite removal of negative-order common-information excess

Research manuscript · 26 November 2026

## Abstract

Two separated terminals synthesize a finite joint source from a uniform shared seed, using arbitrary local block kernels and no communication. We prove that one fixed binary output background has a universal finite property: for every finite target, including targets with zero masses, a sufficiently large but finite number of independent DSBS(1/4) background copies makes the joint common-information rate equal to the sum of the Wyner rates, simultaneously at every negative Rényi order, including negative infinity. An explicit target-dependent bound determines a sufficient number of copies. A single code sequence controls all orders, even when the order varies with block length. We characterize all backgrounds with this property by a strictly positive linear deficit of an additive tilted-information profile. For DSBS backgrounds, the criterion gives a sharp boundary between finite exact removal and asymptotic removal. At the critical infinite-order background, the remaining excess has a sharp inverse-copy law with an explicit positive coefficient. An elementary formula for the full binary potential yields exact rational interval proofs: one background copy is the sharp order-uniform count for DSBS(1/100), while ten copies are necessary and sufficient for diag(3/4,1/4). The underlying operational converse, finite-block bounds, product identity, and binary phase theory are included and identified as inherited ingredients. Background copies are additional paid output tasks; their own cost remains in every rate identity.

## 1. Introduction and contribution boundary

Common information measures the shared randomness needed to generate a prescribed joint law at separated terminals. The approximation criterion matters: negative-order Rényi synthesis can require more randomness than Wyner's common information. Yu [1] established a finite-source achievable bound, evaluated the corresponding binary variational problem, and proposed a phase transition for doubly symmetric binary sources (DSBS). The operational converse and binary phase results reproduced in Sections 3–9 identify the exact rates and their phase boundary. They expose a further question: how much of a target's extra cost can be removed by jointly synthesizing independent additional targets?

Theorem 13.1 answers this question uniformly over all finite sources and all negative orders. Fix the same background \(\kappa=\operatorname{DSBS}(1/4)\). For every finite target \(\pi\), some finite integer \(m\), fixed before the coding limit, gives
\[
T_{-\beta}(\pi\otimes\kappa^{\otimes m})
=\widetilde T_{-\beta}(\pi\otimes\kappa^{\otimes m})
=C_W(\pi)+mC_W(\kappa)
\qquad\text{for all }\beta\in(0,\infty].
\]
The explicit sufficient bound is \(m\ge\lceil25L_\pi^2/2\rceil\), with \(L_\pi\) given in (N2). It is conservative. Since the background's own negative-order rate is its Wyner rate, the identity removes the entire target premium after paying for the background. Corollary 13.4 supplies the matching lower bound on the residual cost.

The finite assertion requires quantitative control at the zero endpoint of the dual profile. Lemma 13.2 proves a one-sided Lipschitz bound for Wyner common information within an arbitrary support face. Pinsker's inequality then bounds the target's profile excess linearly in the profile parameter. A negative curvature certificate for the fixed background provides a uniformly opposing linear deficit. Exact product additivity of the tilted potential makes a finite count sufficient, including for singular targets.

Theorem 14.1 characterizes all finite backgrounds with this universal property by a positive lower bound on profile deficit divided by the parameter. The characterization remains true with targets restricted to full support. For DSBS backgrounds with \(0\lt \epsilon\lt 1/2\), Theorem 14.3 gives the sharp criterion \(c>k(\epsilon)\), where \(c=1+1/\beta\). On the critical line, every target approaches the baseline as the background count increases, but some full-support targets cannot attain it finitely. At the infinite-order critical crossover, Theorem 16.2 gives the exact leading inverse-copy excess and the scale of its maximizing parameter.

Theorem 15.1 gives an elementary expression for the full infinite-order binary potential. Whole-interval derivative enclosures prove the background margin and two sharp counts: one for DSBS(1/100), and ten for diag(3/4,1/4). These are the smallest counts valid simultaneously for all negative orders; an individual fixed order can require fewer copies. Appendix B provides integer-arithmetic reproduction details.

### 1.1. Inherited results and established inputs

Sections 3–4 reproduce the operational matching argument and scalar boundary from [P]. Sections 5–12 reproduce the subsequent binary phase theorem, finite-block quantification, product-potential identity, and qualitative strict-subadditivity construction from [P2]. Their proofs make the stronger theorem independently readable; they are not new contributions of the present extension. The additional results are in Sections 13–16 and their supporting computations.

Yu's achievability theorem already covers arbitrary finite targets, including zeros [1, Theorem 1(3)]. Earlier drafts applied it only under full support. Appendix A corrects that unnecessarily narrow application and gives a direct max-divergence construction clarifying the support and common-code quantifiers. This is an exposition and combination of established achievability with the existing converse, not a new all-support achievability theorem. The universal type architecture and its asymptotic upper profile are also due to [1]; Section 10 retains the previously obtained explicit finite-block remainder under the exact integer seed budget.

The inner auxiliary-information functional is a weighted tension-region functional. Its independent-source additivity has established geometric predecessors [12]; the general relation between additive regions and tensorizing dual quantities was developed in [13]. Section 11 additionally controls correlated tilted laws under a KL penalty. The new finite-background theorem uses this inherited identity together with quantitative endpoint bounds. Diagonal Rényi-entropy formulas [9], universal Rényi redundancy [10], and exact-generation nonadditivity [11] remain separately attributed.

### 1.2. Neighboring synthesis and amortization problems

The approximation direction and resource accounting are material. Fixed-channel Rényi resolvability [5] prescribes a channel, whereas the present local whole-block kernels are arbitrary. Positive-order and exact-generation results [3,4,6] use different approximation or randomness conventions. George, Hsieh, and Chitambar [14] give near-tight one-shot smooth-entropy bounds and study quantum variants, including catalytic entangled simulation. Here the background is an independent classical output that must also be synthesized and paid for; it is not a pre-supplied catalyst returned for reuse. Braun, Jain, Lee, and Pokutta [15] relate Wyner common information to amortized nonnegative rank under tensoring and small \(\ell_1\) perturbations. Our result concerns a fixed finite heterogeneous background count, reverse Rényi divergence, and exact equality of asymptotic synthesis rates. These comparisons are scoped to the checked primary statements, not exhaustive global priority claims.

Sections 2–9 give the model and binary phase analysis; Sections 10–12 give the finite-block and composition tools; Sections 13–16 give finite removal, its converse criterion, certified examples, and the critical asymptotic. Appendix A treats support faces and the common code. Appendix B records the rational interval proof.

## 2. Model, units, and established inputs

All logarithms, entropies, divergences, and information rates in this manuscript use natural logarithms. Rates are measured in nats per source pair. Dividing any information quantity or rate by \(\log 2\) recovers the bit convention of [1,P]. Ratios such as \(K_\epsilon\), the function \(k\), and all crossover thresholds are unchanged by this conversion. We use \(0\log0=0\) and the usual extended-value conventions for divergence.

### Definition 2.1. Local block synthesis

For Sections 2–9, let \(\pi\) be a full-support law on a finite product alphabet \(\mathcal X\times\mathcal Y\). At block length \(n\), a code has a seed \(M\) uniformly distributed on \(\{1,\ldots,N_n\}\), with \(N_n\ge1\), and arbitrary local probability kernels \(A_m\) on \(\mathcal X^n\) and \(B_m\) on \(\mathcal Y^n\). Its output law and rate are

\[
P_n(x^n,y^n)=\frac1{N_n}\sum_{m=1}^{N_n}A_m(x^n)B_m(y^n),
\qquad R_n=\frac{\log N_n}{n}.
\tag{2}
\]

The kernels may have arbitrary dependence across time. Private randomness is unrestricted and absorbed into these kernels. The terminals do not communicate.

For a fixed \(\beta\in(0,\infty)\), set

\[
d_n=D_{1+\beta}(\pi^{\otimes n}\Vert P_n),\qquad
c_\beta=1+1/\beta.
\tag{3}
\]

At \(\beta=\infty\), use \(d_n=D_\infty(\pi^{\otimes n}\Vert P_n)\) and \(c_\infty=1\). Define \(\widetilde T_{-\beta}(\pi)\) as the infimum of \(\limsup_nR_n\) over code sequences satisfying \(d_n/n\to0\), and \(T_{-\beta}(\pi)\) using the stronger requirement \(d_n\to0\). These are precisely the normalized and unnormalized negative-order conventions because

\[
D_{-\beta}(P_n\Vert\pi^{\otimes n})
=-\frac{\beta}{1+\beta}D_{1+\beta}(\pi^{\otimes n}\Vert P_n),
\tag{4}
\]

with \(D_{-\infty}(P_n\Vert\pi^{\otimes n})=-D_\infty(\pi^{\otimes n}\Vert P_n)\). The definitions initially fix the order before \(n\to\infty\). Section 10 extends the normalized problem to all finite target laws, and Proposition A.1 supplies the unnormalized equality on the same domain. Theorem 13.1 also gives one code sequence controlling orders that vary with block length.

### Definition 2.2. Relaxed common information

For a finite joint law \(Q\) and \(t\ge0\), let

\[
C(Q,t)=\inf_{Q_{W|XY}:\ I(X;Y\mid W)\le t}I(XY;W).
\tag{5}
\]

Finite auxiliary variables suffice. Conditional laws at zero-probability events may be chosen arbitrarily. We write \(C(r,t)\) when \(Q=\operatorname{DSBS}(r)\).

### Established Input 2.3. Achievability

For every full-support finite target law and fixed \(\beta\in(0,\infty]\), Yu [1, Theorem 1(3), equations (14)–(15), Sections IV-B–IV-C] proves

\[
\widetilde T_{-\beta}(\pi)\le T_{-\beta}(\pi)
\le\Gamma_\beta(\pi),\qquad
\Gamma_\beta(\pi)=\sup_Q C(Q,c_\beta D(Q\Vert\pi)).
\tag{6}
\]

This is an unconditional, established achievability input in the same uniform-seed, arbitrary-local-block-kernel model. It includes the infinite-order endpoint directly. Integer rounding of fixed-rate code sizes changes the rate by \(o(1)\). We do not obtain the endpoint by exchanging an order limit with a block-length limit.

### Established Input 2.4. DSBS scalar formulas

Let \(0\lt \epsilon\lt 1/2\), and let \(\pi_\epsilon\) have diagonal probabilities \((1-\epsilon)/2\) and off-diagonal probabilities \(\epsilon/2\). Put

\[
h(x)=-x\log x-(1-x)\log(1-x),\quad
a_r=\frac{1-\sqrt{1-2r}}2,\quad
b(r)=\frac{a_r^2}{1-r}.
\tag{7}
\]

Yu [1, Propositions 1–2] supplies the following scalar supremum. We write it as a maximum: the scalar formula below makes the objective continuous on the compact interval, including its zero extension at saturation and the endpoint \(r=0\).

\[
\Gamma_\beta(\pi_\epsilon)
=\max_{0\le r\le\epsilon}C(r,c_\beta D(r\Vert\epsilon)),
\tag{8}
\]

where \(D(r\Vert\epsilon)\) is binary KL divergence. For \(0\le r\lt 1/2\), define

\[
F_r(q)=2h((1-r)q+r/2)-(1-r)h(q)-r\log2-h(r).
\tag{9}
\]

For \(0\le t\lt \log2-h(r)\), there is a unique scalar \(q\in[b(r),1/2)\) satisfying \(F_r(q)=t\), and

\[
C(r,t)=(1-r)(\log2-h(q)).
\tag{10}
\]

For \(t\ge\log2-h(r)\), \(C(r,t)=0\). In particular,

\[
C_W(r)=C(r,0)=\log2+h(r)-2h(a_r),\qquad
C(0,t)=\max\{\log2-t,0\}.
\tag{11}
\]

The uniqueness invoked in (10) concerns the scalar solution \(q\); no uniqueness of arbitrary auxiliary-variable representations is needed.

## 3. Operational matching for unrestricted local kernels

This section reproduces the operational bridge of [P]. Its inclusion makes the later phase theorem an unconditional statement about the model in Definition 2.1, rather than a statement conditional on an unproved operational conjecture.

### Lemma 3.1. Attainment and right continuity

If \(k=|\mathcal X||\mathcal Y|\), the infimum in (5) is attained with \(|\mathcal W|\le k+2\). For each fixed \(Q,t\),

\[
\lim_{u\downarrow0}C(Q,t+u)=C(Q,t).
\tag{12}
\]

**Proof.** For a law \(p\) on one pair, consider its \(k-1\) independent masses, \(H(p)\), and \(I_p(X;Y)\). These \(k+1\) quantities are continuous on the probability simplex. An auxiliary produces a convex combination of these vectors. Carathéodory's theorem reduces the combination to at most \(k+2\) terms while preserving the pair marginal, \(H(XY\mid W)\), and \(I(X;Y\mid W)\). With the marginal fixed, it also preserves \(I(XY;W)\).

On a fixed auxiliary alphabet of this size, permitting zero weights, the marginal constraint and the conditional-information bound define a closed subset of a compact simplex. It is nonempty because \(W=(X,Y)\) is feasible. Entropy continuity proves attainment. The value is nonincreasing in \(t\). Choose minimizers at tolerances \(t+u_j\), where \(u_j\downarrow0\). A convergent subsequence is feasible at \(t\), and continuity identifies its objective with the right limit. This gives both inequalities in (12). Monotonicity then extends the conclusion to every nonnegative sequence tending to zero. ∎

### Lemma 3.2. Divergence comparison

For positive finite laws \(U,V\), any law \(S\), and \(0\lt \beta\lt \infty\),

\[
D(S\Vert V)\le c_\beta D(S\Vert U)+D_{1+\beta}(U\Vert V).
\tag{13}
\]

For \(\beta=\infty\), the same inequality holds with \(c_\infty=1\) and \(D_\infty\).

**Proof.** Set \(Z=\sum_zU(z)^{1+\beta}V(z)^{-\beta}\) and \(L(z)=Z^{-1}U(z)^{1+\beta}V(z)^{-\beta}\). Nonnegativity of \(D(S\Vert L)\) gives

\[
0\le(1+\beta)D(S\Vert U)-\beta D(S\Vert V)+\log Z.
\tag{14}
\]

Division by \(\beta\) proves the finite-order assertion. At infinite order, average \(\log(U/V)\) under \(S\) and bound it by its maximum. If \(V\) vanishes on the support of a positive \(U\), the right-hand divergence is infinite and the finite bound is vacuous. ∎

### Lemma 3.3. Posterior transfer

For a code with finite \(d_n\), and any one-letter law \(Q\), there is a law \(\widehat Q\) with pair-block marginal \(Q^{\otimes n}\) such that

\[
I_{\widehat Q}(X^n;Y^n\mid M)
\le c_\beta nD(Q\Vert\pi)+d_n,
\qquad I_{\widehat Q}(X^nY^n;M)\le\log N_n.
\tag{15}
\]

**Proof.** Let \(P(x^n,y^n,m)=N_n^{-1}A_m(x^n)B_m(y^n)\). Since the target is positive and \(d_n\lt \infty\), \(P_n\) is positive. Define

\[
\widehat Q(x^n,y^n,m)=Q^{\otimes n}(x^n,y^n)P(m\mid x^n,y^n).
\tag{16}
\]

The ratio \(\widehat Q/P\) equals \(Q^{\otimes n}/P_n\) on its support. Expanding KL first over the seed and then over the conditional product law gives

\[
\begin{aligned}
D(Q^{\otimes n}\Vert P_n)
&=D(\widehat Q_M\Vert\operatorname{Unif}[N_n])
+I_{\widehat Q}(X^n;Y^n\mid M)\\
&\quad+\sum_m\widehat Q_M(m)
\bigl[D(\widehat Q_{X^n|m}\Vert A_m)
+D(\widehat Q_{Y^n|m}\Vert B_m)\bigr].
\end{aligned}
\tag{17}
\]

Absolute continuity follows from (16); zero seed weights contribute nothing. All displayed terms are nonnegative. Apply Lemma 3.2 with \(S=Q^{\otimes n}\), \(U=\pi^{\otimes n}\), and \(V=P_n\), and use product additivity of KL. Finally \(I(X^nY^n;M)\le H(M)\le\log N_n\). Neither uniformity of the seed under \(\widehat Q\) nor conditional independence under that law is asserted. ∎

### Lemma 3.4. Simultaneous single-letter bounds

Every code satisfies, for every one-letter \(Q\),

\[
C(Q,c_\beta D(Q\Vert\pi)+d_n/n)\le R_n
\tag{18}
\]

whenever \(d_n\lt \infty\).

**Proof.** Under \(\widehat Q\), put \(Z_i=(X_i,Y_i)\) and \(W_i=(M,Z^{i-1})\). The pair sequence has marginal \(Q^{\otimes n}\), so the entropy chain rule gives

\[
\sum_i I(Z_i;W_i)=I(Z^n;M).
\tag{19}
\]

For the conditional informations, deleting the other terminal's past from the two positive entropy terms can only increase them. Therefore

\[
\begin{aligned}
\sum_i I(X_i;Y_i\mid M,Z^{i-1})
&\le\sum_iH(X_i\mid M,X^{i-1})
+\sum_iH(Y_i\mid M,Y^{i-1})\\
&\quad-H(X^nY^n\mid M)
=I(X^n;Y^n\mid M).
\end{aligned}
\tag{20}
\]

Let \(J\) be an independent uniform coordinate and take \((X,Y)=(X_J,Y_J)\), \(W=(J,W_J)\). The pair has law \(Q\) and is independent of \(J\). Equations (15), (19), and (20) give \(I(XY;W)\le R_n\) and \(I(X;Y\mid W)\le c_\beta D(Q\Vert\pi)+d_n/n\). This auxiliary is feasible in (5). Its alphabet may depend on \(n\); Lemma 3.1 supplies a fixed sufficient bound when taking limits. ∎

### Theorem 3.5. Operational equality

For every full-support finite target and every fixed \(\beta\in(0,\infty]\),

\[
\widetilde T_{-\beta}(\pi)=T_{-\beta}(\pi)
=\sup_Q C(Q,c_\beta D(Q\Vert\pi)).
\tag{21}
\]

**Proof.** For any code sequence with \(d_n/n\to0\), fix \(Q\) and apply (18) and right continuity (12). This gives

\[
\liminf_nR_n\ge C(Q,c_\beta D(Q\Vert\pi)).
\tag{22}
\]

Take the supremum over \(Q\), and then the infimum over admissible code sequences. This lower-bounds the limsup-rate definition as well. Established Input 2.3 gives the opposite bound for the stronger unnormalized criterion and hence both equalities. At \(\beta=\infty\), the direct infinite-order version of Lemma 3.2 is used throughout. ∎

## 4. The scalar boundary and its endpoint

The following construction, including its removable endpoint, is from [P]. We give the necessary details to identify precisely the function whose global optimization will be removed.

### Lemma 4.1. Monotonicity of the scalar parametrization

For \(0\lt r\lt 1/2\), \(C_W'(r)\lt 0\). The map \(q\mapsto F_r(q)\) is continuous and strictly increasing from zero to \(\log2-h(r)\) on \([b(r),1/2]\).

**Proof.** Write \(s_r=\sqrt{1-2r}\) and \(L_x=h'(x)=\log((1-x)/x)\). Differentiation of (11) gives

\[
C_W'(r)=L_r-L_{a_r}/s_r\lt 0.
\tag{23}
\]

Indeed \(L_r=2\operatorname{atanh}(s_r^2)\), \(L_{a_r}=2\operatorname{atanh}(s_r)\), and \(s_r\operatorname{atanh}(s_r^2)\lt \operatorname{atanh}(s_r)\).

Also

\[
F_r'(q)=(1-r)\{2h'((1-r)q+r/2)-h'(q)\}.
\tag{24}
\]

Set \(u=1-2q\) and \(v=1-r\). For \(u>0\), the derivative is positive exactly when \(2\operatorname{atanh}(vu)>\operatorname{atanh}u\). The double-angle formula for \(\tanh\) reduces this to \(v^2u^2\lt 2v-1\), which is exactly \(q>b(r)\). At \(b(r)\) the derivative vanishes, and substitution gives \(F_r(b(r))=0\). At \(q=1/2\), (9) gives \(\log2-h(r)\). At \(r=0\), \(F_0(q)=h(q)\), yielding the same continuous monotonicity directly. ∎

Fix \(0\lt \epsilon\lt 1/2\), put \(w=C_W(\epsilon)\), and let \(h_-^{-1}\) be the increasing inverse of \(h\) on \([0,1/2]\). Define

\[
q_\epsilon(r)=h_-^{-1}\!\left(\log2-\frac{w}{1-r}\right),
\quad m_\epsilon(r)=(1-r)q_\epsilon(r)+r/2,
\tag{25}
\]

\[
\tau_\epsilon(r)=F_r(q_\epsilon(r))
=w-\log2+2h(m_\epsilon(r))-h(r).
\tag{26}
\]

The grouping identity \(2h(a_r)=h(r)+r\log2+(1-r)h(b(r))\) yields \(C_W(r)=(1-r)(\log2-h(b(r)))\). Thus \(0\lt w\lt (1-\epsilon)\log2\), (25) is well-defined, \(q_\epsilon(\epsilon)=b(\epsilon)\), and \(q_\epsilon(r)>b(r)\) for \(r\lt \epsilon\).

### Proposition 4.2. Continuous boundary function

For \(0\le r\lt \epsilon\), set \(K_\epsilon(r)=\tau_\epsilon(r)/D(r\Vert\epsilon)\). It extends continuously and positively to \([0,\epsilon]\), with

\[
K_\epsilon(0)=\frac{\log2-w}{\log(1/(1-\epsilon))},
\tag{27}
\]

\[
k(\epsilon):=K_\epsilon(\epsilon)
=\frac{1-\epsilon}{\epsilon}
\left(1-\sqrt{1-2\epsilon}\,
\frac{\log((1-\epsilon)/\epsilon)}{\log((1-a_\epsilon)/a_\epsilon)}\right)^2.
\tag{28}
\]

Moreover, for every \(c\ge0\),

\[
\max_{0\le r\le\epsilon}C(r,cD(r\Vert\epsilon))>w
\iff c\lt \max_{0\le r\le\epsilon}K_\epsilon(r).
\tag{29}
\]

**Proof.** For \(r\lt \epsilon\), Lemma 4.1 and (10) give \(0\lt \tau_\epsilon(r)\lt \log2-h(r)\) and

\[
C(r,t)>w\iff t\lt \tau_\epsilon(r).
\tag{30}
\]

The denominator in \(K_\epsilon(r)\) is positive. Formula (27) follows from \(F_0(q)=h(q)\). Only the endpoint \(r=\epsilon\) needs a removable-singularity calculation.

At \(q=b(r)\), \(F_r=0\), \(F_{r,q}=0\), and

\[
F_{r,qq}(b(r))=\frac{4(1-r)^2(1-2r)}{r^2}.
\tag{31}
\]

For (31), substitute \(a_r(1-a_r)=r/2\) and \(b(r)(1-b(r))=r^2/[4(1-r)^2]\) into the second derivative of (9). Implicit differentiation of (25) gives

\[
q_\epsilon'(r)=-\frac{w}{(1-r)^2h'(q_\epsilon(r))},\qquad
q_\epsilon'(\epsilon)-b'(\epsilon)
=\frac{C_W'(\epsilon)}{(1-\epsilon)h'(b(\epsilon))}.
\tag{32}
\]

Taylor expansion about \(q=b(r)\), using (31)–(32), shows that the leading coefficient of \(\tau_\epsilon(r)\) in \((r-\epsilon)^2\) is one half of (31) at \(\epsilon\) times the square of the final expression in (32). Meanwhile

\[
D(r\Vert\epsilon)=\frac{(r-\epsilon)^2}{2\epsilon(1-\epsilon)}+o((r-\epsilon)^2).
\tag{33}
\]

Since \(h'(b(\epsilon))=2h'(a_\epsilon)\), their ratio is (28). It is positive by (23), proving continuous extension and attainment of the maximum.

For \(r\lt \epsilon\), (30) makes strict improvement equivalent to \(c\lt K_\epsilon(r)\). At \(r=\epsilon\), the value is exactly \(w\). If the extended maximum occurs only at that endpoint and exceeds \(c\), continuity supplies genuine points \(r\lt \epsilon\) with \(K_\epsilon(r)>c\). This proves (29), including equality at the boundary. ∎

## 5. An entropy monotonicity lemma

Define, for \(0\lt u\lt 1\),

\[
f(u)=\frac{(1+u)\log(1+u)+(1-u)\log(1-u)}2,
\quad \ell(u)=\operatorname{atanh}u,
\quad H_0(u)=-\tfrac12\log(1-u^2).
\tag{34}
\]

Then \(f'=\ell\), \(f''=(1-u^2)^{-1}\), \(H_0=u\ell-f\), and \(H_0'=u/(1-u^2)\). Set

\[
J(u)=\frac{(1-u^2)\ell(u)}u,
\qquad B(u)=J(u)\left(\frac{H_0(u)}{f(u)}\right)^2.
\tag{35}
\]

### Lemma 5.1. Strict decrease of J

\(J\) is positive and strictly decreasing on \((0,1)\).

**Proof.** Positivity is immediate. The power series of \(\operatorname{atanh}\) gives

\[
J(u)=1-\sum_{n\ge1}\frac{2u^{2n}}{(2n-1)(2n+1)}.
\tag{36}
\]

The series and its derivative converge locally uniformly on \((0,1)\); every derivative term is strictly negative. ∎

### Lemma 5.2. Log-concavity in the entropy coordinate

For \(\xi>0\), define

\[
\mathcal F(\xi)=f\!\left(\sqrt{1-e^{-2\xi}}\right),
\qquad \mathcal g(\xi)=\mathcal F'(\xi)
=J\!\left(\sqrt{1-e^{-2\xi}}\right).
\tag{37}
\]

Then \(\mathcal g\) is positive, strictly decreasing, and strictly log-concave. It extends continuously to zero with \(\mathcal g(0)=1\) and \((\log\mathcal g)'(0)=-4/3\).

**Proof.** The coordinate change is \(\xi=H_0(u)\). Differentiation gives

\[
\mathcal k(\xi):=(\log\mathcal g)'(\xi)
=-1-u^{-2}+\frac1{u\operatorname{atanh}u}.
\tag{38}
\]

Its derivative with respect to \(u\) is negative exactly when

\[
2\operatorname{atanh}^2u
\lt u\operatorname{atanh}u+\frac{u^2}{1-u^2}.
\tag{39}
\]

With \(z=\operatorname{atanh}u\), this is the known hyperbolic Wilker inequality \(2z^2\lt z\tanh z+\sinh^2z\) [7, Theorem 1]. For completeness, multiply its difference by \(\cosh z\). The resulting expression is

\[
\frac{\cosh(3z)-\cosh z}{4}+z\sinh z-2z^2\cosh z
=\sum_{n\ge0}a_n\frac{z^{2n}}{(2n)!},
\tag{40}
\]

where \(a_n=(9^n-1)/4+6n-8n^2\). The first three coefficients \(a_0,a_1,a_2\) vanish, \(a_3=128\), and

\[
a_{n+1}-9a_n=64n(n-1)>0\quad(n\ge2).
\tag{41}
\]

Thus the absolutely convergent series is positive for \(z>0\). This power-series proof is also an established proof of Wilker's inequality [7, Section 4], reproduced without a novelty claim. Since \(u\) increases with \(\xi\), (38)–(39) prove strict log-concavity. Strict decrease follows from Lemma 5.1. Finally \(J(u)=1-2u^2/3+O(u^4)\) and \(H_0(u)=u^2/2+O(u^4)\) give the stated endpoint derivative. ∎

### Lemma 5.3. Strict decrease of B

\(B\) is strictly decreasing on \((0,1)\).

**Proof.** In the entropy coordinate,

\[
B(u)=\frac{\xi^2\mathcal g(\xi)}{\mathcal F(\xi)^2}.
\tag{42}
\]

Let \(\mathcal k=(\log\mathcal g)'\lt 0\). Concavity of \(\log\mathcal g\) gives, for \(0\le s\le\xi\),

\[
\mathcal g(s)\le\mathcal g(\xi)e^{\mathcal k(\xi)(s-\xi)}.
\tag{43}
\]

Integrating and using \(\mathcal F(0)=0\) yields

\[
\frac{\mathcal g(\xi)}{\mathcal F(\xi)}
\ge\frac{-\mathcal k(\xi)}{e^{-\xi\mathcal k(\xi)}-1}
>\frac1\xi+\frac{\mathcal k(\xi)}2.
\tag{44}
\]

For the strict inequality, \(x/(e^x-1)>1-x/2\) for \(x>0\), equivalently \((x/2)\coth(x/2)>1\). The latter follows because \(y\cosh y-\sinh y\) vanishes at zero and has derivative \(y\sinh y>0\). Consequently

\[
\frac d{d\xi}\log B
=\frac2\xi+\mathcal k(\xi)
-2\frac{\mathcal g(\xi)}{\mathcal F(\xi)}\lt 0.
\tag{45}
\]

The coordinate \(\xi\) strictly increases with \(u\), proving the assertion. ∎

## 6. Global endpoint reduction

Fix \(\epsilon\), write \(v_0=1-\epsilon\) and \(w=C_W(\epsilon)\), and for \(v\in[v_0,1]\) define

\[
f(u(v))=w/v,\qquad z(v)=vu(v),\qquad
A(v)=2f(z(v))-w,\qquad \phi(v)=f(2v-1).
\tag{46}
\]

Here \(f\) maps \([0,1]\) increasingly onto \([0,\log2]\). Thus \(u,z,A\) are smooth on the closed interval. The functions \(\phi\), \(D_v:=D(1-v\Vert\epsilon)\), and \(\tau_v:=\tau_\epsilon(1-v)\) are smooth on \([v_0,1)\) and continuous at one; their derivatives need not extend to one.

### Lemma 6.1. Geometry of the level curve

The functions in (46) satisfy

\[
\tau_v=\phi(v)-A(v),\qquad
D_v=\phi(v)-\phi(v_0)-\phi'(v_0)(v-v_0),
\tag{47}
\]

and \(\tau_{v_0}=\tau'_{v_0}=D_{v_0}=D'_{v_0}=0\). Further,

\[
u'=-\frac{f(u)}{v\ell(u)}\lt 0,\qquad
z'=\frac{H_0(u)}{\ell(u)}\in(0,u),\qquad
z''=-\frac{f(u)^2}{v(1-u^2)\ell(u)^3},
\tag{48}
\]

and \(z(v_0)^2=2v_0-1\), while \(z(v)^2\lt 2v-1\) for \(v>v_0\).

**Proof.** Since \(f(u)=\log2-h((1-u)/2)\), equation (25) identifies \(u=1-2q_\epsilon(1-v)\) and \(z=1-2m_\epsilon(1-v)\). Substitution into (26) proves the first identity in (47). The second is the binary-entropy Bregman formula for KL. The double-zero identities follow from the endpoint Taylor expansion in Proposition 4.2.

Implicit differentiation of \(vf(u)=w\) gives (48), using \(u\ell-f=H_0>0\). At \(v_0\), \(q_\epsilon(\epsilon)=b(\epsilon)\) yields \(z(v_0)=\sqrt{1-2\epsilon}\). Finally \(z=vu\lt v\), \(z'\lt u\lt 1\), so

\[
\frac d{dv}(2v-1-z^2)=2-2zz'>2-2v>0
\quad(v_0\le v\lt 1).
\tag{49}
\]

Starting from equality at \(v_0\), this proves the strict assertion, and continuity includes \(v=1\). ∎

### Lemma 6.2. Curvature factorization

For \(v_0\le v\lt 1\),

\[
\frac{A''(v)}{D_v''}=C_0(v)S(v),\qquad
C_0(v)=\frac{2v(1-v)H_0(u)^2}{\ell(u)^2(1-z^2)}>0,
\quad S(v)=1-\frac{J(z)}{B(u)}.
\tag{50}
\]

The factor \(C_0\) strictly decreases and \(S\) strictly increases.

**Proof.** Here \(D_v''=\phi''(v)=1/[v(1-v)]\). Substituting (48) into the derivative of \(A\) gives

\[
A''=\frac{2H_0(u)^2}{\ell(u)^2(1-z^2)}
-\frac{2\ell(z)f(u)^2}{v(1-u^2)\ell(u)^3}.
\tag{51}
\]

The ratio of the second term to the first is \(J(z)/B(u)\), proving (50). As \(v\) increases, \(u\) decreases and \(z\) increases. Lemmas 5.1 and 5.3 therefore show that \(J(z)\) decreases and \(B(u)\) increases, so \(S\) increases strictly.

For \(C_0\), differentiation gives

\[
\left(\frac{H_0(u)}{\ell(u)}\right)'
=\frac{f(u)}{(1-u^2)\ell(u)^2}>0.
\tag{52}
\]

Thus this factor decreases along \(u(v)\). For \(T(v)=v(1-v)/(1-z^2)\), (48) and Lemma 6.1 give

\[
\frac{T'}T
=\frac{1-2v}{v(1-v)}+\frac{2zz'}{1-z^2}
\lt \frac{1-2v+z^2}{v(1-v)(1-z^2)}\le0.
\tag{53}
\]

The strict middle inequality uses \(z'\lt z/v\). Therefore \(C_0=2T(H_0/\ell)^2\) strictly decreases. ∎

### Theorem 6.3. Truncated global maximum

For every \(0\lt \epsilon\lt 1/2\),

\[
\boxed{\max\{1,\max_{0\le r\le\epsilon}K_\epsilon(r)\}
=\max\{1,k(\epsilon)\}.}
\tag{54}
\]

If \(k(\epsilon)>1\), \(K_\epsilon(r)\lt k(\epsilon)\) for every \(r\lt \epsilon\). If \(k(\epsilon)\le1\), the whole curve is at most one.

**Proof.** Write \(R(v)=A''(v)/D_v''=C_0(v)S(v)\). On the portion where \(S\lt 0\), the product strictly increases: its positive factor decreases and its negative factor increases. On the portion where \(S\ge0\), the product is nonnegative. Hence

\[
R(v)\ge\min\{R(v_0),0\}.
\tag{55}
\]

By (47) and the endpoint ratio, \(k(\epsilon)=1-R(v_0)\). Thus

\[
\tau_v''\le\max\{1,k(\epsilon)\}D_v''.
\tag{56}
\]

For \(v\lt 1\), integrate twice from \(v_0\), using all four zero initial values from Lemma 6.1. This gives \(K_\epsilon(1-v)\le\max\{1,k(\epsilon)\}\). Continuity gives the same weak bound at \(r=0\).

If \(k(\epsilon)>1\), then \(R(v_0)\lt 0\), and the factor argument gives \(R(v)>R(v_0)\) for all \(v>v_0\). Set \(G(v)=k(\epsilon)D_v-\tau_v\). Then \(G(v_0)=G'(v_0)=0\) and \(G''(v)=D_v''(R(v)-R(v_0))>0\). Thus \(G\) is positive and increasing on \((v_0,1)\). For any fixed \(v_1\in(v_0,1)\), continuity implies \(G(1)\ge G(v_1)>0\). This proves strictness also at \(r=0\). Finally the extended endpoint itself equals \(k(\epsilon)\); taking maxima proves (54). ∎

## 7. Exact joint phase diagram and uniqueness

### Theorem 7.1. Explicit operational criterion

For every \(0\lt \epsilon\lt 1/2\) and fixed \(\beta\in(0,\infty]\),

\[
\boxed{T_{-\beta}(\pi_\epsilon)>C_W(\epsilon)
\iff 1+1/\beta\lt k(\epsilon),}
\tag{57}
\]

and

\[
\boxed{T_{-\beta}(\pi_\epsilon)=C_W(\epsilon)
\iff 1+1/\beta\ge k(\epsilon).}
\tag{58}
\]

The same statements hold for \(\widetilde T_{-\beta}\). In particular the critical boundary belongs to equality.

**Proof.** Apply Theorem 3.5, (8), Proposition 4.2, and Theorem 6.3. Since \(c_\beta\ge1\), the truncation in (54) loses no information about whether \(c_\beta\) is strictly below the maximum. The value at \(r=\epsilon\) is always \(C_W(\epsilon)\), so absence of strict improvement means equality. ∎

We next prove uniqueness without assuming global monotonicity of \(k\). Introduce the source coordinate

\[
t=\log\frac{1-\epsilon}{\epsilon}>0,\quad
\epsilon(t)=\frac1{1+e^t},\quad V(t)=1-\epsilon(t),
\tag{59}
\]

\[
U(t)=\sqrt{1-e^{-2t}},\quad X(t)=\operatorname{atanh}U(t)
=\operatorname{arcosh}(e^t),\quad
F(t)=f(U(t))=X(t)U(t)-t.
\tag{60}
\]

The \(F\) in (60) is the universal function \(\mathcal F\) of Lemma 5.2 evaluated at the source coordinate \(t\). It differs from the subscripted scalar map \(F_r(q)\) in (9). Set

\[
Q_0(t)=\frac{e^{t/2}F(t)}t,\qquad
P_0(t)=V(t)\left(\frac t{X(t)}\right)^2.
\tag{61}
\]

### Lemma 7.2. Source-coordinate endpoint identity

For every \(t>0\),

\[
\mathsf K(t):=k(\epsilon(t))
=1+P_0(t)(Q_0(t)^2-1).
\tag{62}
\]

**Proof.** Let \(s=\sqrt{1-2\epsilon}\) at \(\epsilon=\epsilon(t)\). At the initial point of the level curve, \(z=s\) and \(u=s/V=U(t)\). The double-angle identity gives \(X=2\operatorname{atanh}s\); also \(H_0(U)=t\). Direct substitution in \(J\) yields \(J(U)=e^{-t}J(s)\). Consequently \(J(s)/B(U)=e^t(F/t)^2=Q_0^2\), while the initial \(C_0\) in (50) is \(V(t/X)^2=P_0\). Since \(k=1-R(v_0)\), formula (62) follows. ∎

### Lemma 7.3. A unique nonzero crossing

There is exactly one \(t_*>0\) such that

\[
F(t_*)=t_*e^{-t_*/2}.
\tag{63}
\]

It satisfies \(t_*>2\). The left side is smaller for \(0\lt t\lt t_*\) and larger for \(t>t_*\).

**Proof.** From Lemma 5.2, \(g(t):=F'(t)\) is strictly log-concave, \(g(0)=1\), and \((\log g)'(0)=-4/3\). Its tangent at zero gives \(g(t)\lt e^{-4t/3}\), hence

\[
F(t)\lt \frac34(1-e^{-4t/3})\quad(t>0).
\tag{64}
\]

For \(0\lt t\le2\), this upper bound is smaller than \(te^{-t/2}\). Indeed the logarithm of their ratio is

\[
L(t)=\log\frac{\sinh(2t/3)}{2t/3}-t/6,
\quad L''(t)=\frac1{t^2}-\frac4{9\sinh^2(2t/3)}>0.
\tag{65}
\]

We have \(L(0)=0\), and

\[
e^{L(2)}=\frac{3e}{8}(1-e^{-8/3})
\lt \frac{33}{32}\frac{26}{27}=\frac{143}{144}\lt 1.
\tag{66}
\]

Here \(e=\exp(1)\), not the crossover probability. To justify the elementary numerical bounds, the exponential series through degree four, with the remaining tail bounded by \(1/100\), gives \(e\le65/24+1/100\lt 11/4\lt 3\); hence \(e^{8/3}\lt 27\). Convexity places \(L\) below its chord from zero to two, so it is strictly negative there.

For \(t\ge2\), \(F(t)\) strictly increases toward \(\log2\), whereas \(te^{-t/2}\) strictly decreases after two and tends to zero. At two the former is smaller. Continuity therefore gives one crossing, and opposite strict monotonicities give uniqueness. ∎

### Theorem 7.4. Unique crossover for every negative order

Let \(\epsilon_*=(1+e^{t_*})^{-1}\). At order \(-\infty\), strict separation occurs exactly for \(0\lt \epsilon\lt \epsilon_*\). For every finite \(\beta>0\), there is a unique \(t_\beta>t_*\) satisfying

\[
\mathsf K(t_\beta)=1+1/\beta,
\qquad \epsilon_\beta=(1+e^{t_\beta})^{-1}.
\tag{67}
\]

For that order strict separation occurs exactly for \(0\lt \epsilon\lt \epsilon_\beta\), and equality for \(\epsilon_\beta\le\epsilon\lt 1/2\). The map \(\beta\mapsto\epsilon_\beta\) is continuous and strictly increasing from zero to \(\epsilon_*\).

**Proof.** By (62) and Lemma 7.3, \(\mathsf K(t)>1\) exactly when \(t>t_*\). On this interval \(Q_0(t)=F(t)/(te^{-t/2})\) strictly increases and exceeds one. The factor \(P_0\) strictly increases too: \(V\) increases and

\[
\left(\frac tX\right)'=\frac{X-t/U}{X^2}
=\frac{F(t)}{U(t)X(t)^2}>0.
\tag{68}
\]

Thus \(\mathsf K\) is strictly increasing on \([t_*,\infty)\). Moreover \(F\to\log2\), \(X=t+\log2+o(1)\), and \(V\to1\), so \(\mathsf K(t)\to\infty\). Each level \(1+1/\beta>1\) is reached once. Theorem 7.1 and the strict decrease of \(\epsilon(t)\) give the asserted regions. Continuity and strict order follow from inversion of the increasing function \(\mathsf K\) on this interval. The endpoint limits follow as its target level decreases to one or increases without bound. ∎

Equivalently, at a fixed crossover the exact order boundary is

\[
\beta_c(\epsilon)=
\begin{cases}
[k(\epsilon)-1]^{-1},&0\lt \epsilon\lt \epsilon_*,\\
\infty,&\epsilon_*\le\epsilon\lt 1/2.
\end{cases}
\tag{69}
\]

Strict separation means \(\beta>\beta_c(\epsilon)\), with the convention that no order exceeds infinity. Equality includes each finite critical order and includes the \(-\infty\) endpoint at \(\epsilon_*\).

## 8. Sharp limiting behavior of the critical curve

### Theorem 8.1. Small-order asymptotic

As \(\beta\downarrow0\),

\[
\boxed{\epsilon_\beta\sim
\frac{\beta(\log2)^2}{[\log(1/\beta)]^2}.}
\tag{70}
\]

**Proof.** The limits used in Theorem 7.4 and (62) give

\[
\mathsf K(t)\sim(\log2)^2e^t/t^2\quad(t\to\infty).
\tag{71}
\]

Since \(t_\beta\to\infty\) and \(\mathsf K(t_\beta)=1+1/\beta\sim1/\beta\), taking logarithms yields

\[
\log(1/\beta)=t_\beta-2\log t_\beta+2\log(\log2)+o(1).
\tag{72}
\]

Divide by \(t_\beta\), using \(\log t/t\to0\), to obtain \(t_\beta/\log(1/\beta)\to1\). Substitution into (71), together with \(\epsilon(t)\sim e^{-t}\), proves (70). ∎

### Theorem 8.2. Large-order expansion

The derivative \(\mathsf K'(t_*)\) is positive and equals

\[
\mathsf K'(t_*)
=2P_0(t_*)\left(\frac12-\frac1{t_*}+\frac{F'(t_*)}{F(t_*)}\right).
\tag{73}
\]

As \(\beta\to\infty\),

\[
\boxed{\epsilon_\beta
=\epsilon_*-
\frac{\epsilon_*(1-\epsilon_*)}{\beta\mathsf K'(t_*)}
+o(1/\beta).}
\tag{74}
\]

**Proof.** Differentiate (62) at \(Q_0(t_*)=1\). Since \(Q_0'/Q_0=1/2-1/t+F'/F\), this gives (73), which is positive because \(t_*>2\) and \(F'>0\). All functions are smooth near \(t_*\). The inverse-function theorem applied to (67) gives \(t_\beta=t_*+1/[\beta\mathsf K'(t_*)]+o(1/\beta)\). Finally \(\epsilon'(t)=-\epsilon(t)(1-\epsilon(t))\), proving (74). ∎

## 9. Rational threshold certificates

The analytic results establish existence, uniqueness, and the direction of every phase transition. Numerical values can then be certified by enclosing the explicit endpoint (28). The accompanying file [threshold_certificates.md](results/threshold_certificates.md) and its JSON counterpart contain eight intervals of width \(10^{-14}\):

| \(\beta\) | Lower endpoint for \(\epsilon_\beta\) | Upper endpoint |
|---|---:|---:|
| \(1/10\) | 0.00069939015406 | 0.00069939015407 |
| \(1/4\) | 0.00212424706497 | 0.00212424706498 |
| \(1/2\) | 0.00466707414818 | 0.00466707414819 |
| \(1\) | 0.00939936561882 | 0.00939936561883 |
| \(2\) | 0.01675806845543 | 0.01675806845544 |
| \(5\) | 0.02908311023475 | 0.02908311023476 |
| \(10\) | 0.03799480990859 | 0.03799480990860 |
| \(\infty\) | 0.05510465170297 | 0.05510465170298 |

Each lower endpoint has \(k(\epsilon)-c_\beta>0\), and each upper endpoint has \(k(\epsilon)-c_\beta\lt 0\), certified with rational intervals. Thus the bounds enclose the unique roots rather than merely approximate some crossing. Ordinary high-precision arithmetic is used only to propose intervals and is not trusted in the sign verification.

### Proposition 9.1. Elementary enclosure rules

The certificate generator's square-root and logarithm rules enclose their exact values.

**Proof.** For rational \(q\ge0\), choose integer \(s=2^b\) and \(z=\lfloor\sqrt{q s^2}\rfloor\) by integer square root applied to the integer floor of \(q s^2\). Then

\[
(z/s)^2\le q\le((z+1)/s)^2,
\tag{75}
\]

so \([z/s,(z+1)/s]\) encloses \(\sqrt q\). For \(1\le q\le2\), put \(y=(q-1)/(q+1)\in[0,1/3]\). The identity \(\log q=2\operatorname{atanh}y\) and the positive series give

\[
2\sum_{j=0}^{N-1}\frac{y^{2j+1}}{2j+1}
\le\log q\le
2\sum_{j=0}^{N-1}\frac{y^{2j+1}}{2j+1}
+\frac{2y^{2N+1}}{(2N+1)(1-y^2)}.
\tag{76}
\]

The tail bound replaces every remaining denominator by \(2N+1\) and sums a geometric series. Every positive rational argument can be scaled by an integer power of two into \([1,2]\); adding the corresponding interval multiple of \(\log2\) preserves enclosure. Monotonicity handles interval arguments. Standard rational interval arithmetic preserves containment through (28); denominators are separated from zero. ∎

The supplied implementation uses \(b=168\) and \(N=72\). Outward rational compression keeps the resulting sign certificates compact. The sixteen endpoint signs are supplemental finite computations. They do not replace the global comparison, the uniqueness proof, or the operational converse.

For example, at order \(-1\), the crossover lies in the fourth row of the table. Every fixed crossover strictly below that interval belongs to the strict-separation region, while every crossover strictly above it belongs to equality. The exact boundary within the interval is also assigned to equality by Theorem 7.1. At order \(-2\), the larger threshold in the next row shows the expansion of the strict region as the magnitude of the negative order increases. This comparison follows generally from Theorem 7.4 rather than from comparing two rounded decimals.

The certificate files record the rational endpoints and rational enclosures of both residual signs. Decimal strings are display forms of exact rationals. Replacing a displayed threshold by its midpoint is suitable for plotting, but is not a theorem about a parameter lying inside the certified interval. A decision for such a parameter requires a narrower enclosure or a direct certified comparison with (28). Exact equality is handled by the analytic phase theorem, not by an assumption that a numerical root finder can decide equality of arbitrary real inputs.

## 10. Universal finite-block bounds

Yu [1, Section IV-B, equations (25)–(34)] already uses constant-composition codebooks for every auxiliary type and uniform mixtures over local conditional types. That construction is independent of the target distribution and the Rényi order, and equation (34) gives the corresponding asymptotic variational expression. This section quantifies that method under an exact integer seed budget. It gives an explicit logarithmic remainder, including zero rate, targets with zeros, and the infinite-order endpoint.

### 10.1. Statement and notation

Let \(a=|\mathcal X|\), \(b=|\mathcal Y|\), \(k=ab\), and \(Z=(X,Y)\). For \(n\ge1\), \(R\ge0\), and \(\beta\in(0,\infty]\), define

\[
d_n^*(\pi,\beta,R)=
\min_{1\le N\le\lfloor e^{nR}\rfloor}
\min_{\{A_j,B_j\}_{j=1}^N}
D_{1+\beta}\!\left(\pi^{\otimes n}\middle\Vert
\frac1N\sum_{j=1}^N A_jB_j\right),
\tag{77}
\]

using \(D_\infty\) when \(\beta=\infty\). The kernels act on entire blocks. The minimum exists by compactness and lower semicontinuity; a positive product kernel supplies a finite candidate. For every one-letter law \(Q\), set

\[
\lambda_Q(r)=\min_{W:\,I(Z;W)\le r}I(X;Y\mid W),
\qquad
E_\beta(\pi,R)=\max_{Q\ll\pi}
\{\lambda_Q(R)-c_\beta D(Q\Vert\pi)\}.
\tag{78}
\]

Here \(c_\beta=1+1/\beta\), with \(1/\infty=0\). Put

\[
\begin{gathered}
m=k+2,\qquad d=mk,\qquad
j_0=\left\lceil\log_2\bigl(16(k+d+1)\bigr)\right\rceil,\\
A_0=m+d+1+j_0,\qquad
B_0=1+m(1+a+b)+9d,\\
C_{a,b}=A_0+B_0+4d
=2+m(a+b+2)+14d+j_0.
\end{gathered}
\tag{79}
\]

**Theorem 10.1.** For every finite joint law \(\pi\), including laws with zeros,

\[
\boxed{
nE_\beta(\pi,R)\le d_n^*(\pi,\beta,R)
\le nE_\beta(\pi,R)
+\left(C_{a,b}+\frac{k}{\beta}\right)\log(n+1).}
\tag{80}
\]

One code, depending only on the alphabets, \(n\), and \(\lfloor e^{nR}\rfloor\), satisfies the upper bound simultaneously for every \(\pi\) and \(\beta\). More precisely, its output satisfies, for every sequence \(z^n\) of joint type \(Q\),

\[
P_n(z^n)\ge(n+1)^{-C_{a,b}}
\exp\{-n[H(Q)+\lambda_Q(R)]\}.
\tag{81}
\]

For binary alphabets, the displayed constants give \(C_{2,2}=383\). The constants are sufficient bounds, without an optimality claim.

### 10.2. Auxiliary and continuity bounds

The cardinality argument of Lemma 3.1 also applies to \(\lambda_Q\): preserving the marginal, \(H(Z\mid W)\), and \(I(X;Y\mid W)\) preserves both quantities in (78). Thus \(|\mathcal W|\le m\) suffices and the minimum is attained.

Explicitly, a conditional pair law contributes its first \(k-1\) masses, its joint entropy, and its mutual information. These are \(k+1\) continuous coordinates. Carathéodory reduction preserves their averages using at most \(k+2\) components. For a fixed marginal, preserving the average joint entropy also preserves the information cost. On this fixed auxiliary alphabet, allowing zero weights makes the feasible set closed and compact. The constant auxiliary proves nonemptiness for every nonnegative rate, including distributions supported on a proper subset of the product alphabet.

An information identity gives

\[
I(X;Y\mid W)
=I_Q(X;Y)+I(Z;W)-I(X;W)-I(Y;W)
\ge I_Q(X;Y)-I(Z;W).
\]

Consequently \(\lambda_Q(0)=I_Q(X;Y)\) and
\(\lambda_Q(r)\ge I_Q(X;Y)-r\). For \(0\le r_1\lt r_2\), time-share an optimizer at \(r_2\) with a constant auxiliary, retaining it with probability \(r_1/r_2\). This produces information cost at most \(r_1\) and gives

\[
\begin{aligned}
0\le\lambda_Q(r_1)-\lambda_Q(r_2)
&\le\left(1-\frac{r_1}{r_2}\right)
[I_Q(X;Y)-\lambda_Q(r_2)]\\
&\le r_2-r_1.
\end{aligned}
\tag{82}
\]

The bound is uniform in \(Q\), including at rate zero.

The time-sharing selector is independent of the pair and is included in the new auxiliary. Hence both its information cost and its conditional mutual information are the indicated weighted averages. Any temporary increase in auxiliary cardinality can be removed by the same support argument. In particular, this step does not require a bound on a derivative of the optimal tradeoff or an interior feasible point at zero rate.

For completeness, \(Q\mapsto\lambda_Q(r)\) is continuous. Compactness of optimal auxiliaries gives lower semicontinuity. For \(r>0\), apply an optimal conditional auxiliary for \(Q\) to a nearby \(Q'\), extending its values arbitrarily at zero-mass symbols. If its information cost exceeds \(r\), time-share with a constant auxiliary to reduce that cost. The necessary retention probability tends to one, proving upper semicontinuity. At \(r=0\), use the mutual-information formula above. Hence the maximum in (78) exists on the compact support face \(\{Q:Q\ll\pi\}\), where the divergence is continuous.

The compactness argument uses ordinary joint distributions on a fixed finite alphabet, so conditional probabilities at events of probability zero do not cause a limiting difficulty. For upper semicontinuity, if the limiting information cost is strictly below the constraint, no adjustment is eventually necessary. If it equals a positive constraint, the time-sharing factor tends to one by continuity. Taking \(Q=\pi\) also shows that \(E_\beta(\pi,R)\) is nonnegative. No maximization over laws outside the source support is implicit in this definition.

### 10.3. Rounding without changing the joint type

Write \(\ell_n=\log(n+1)\). Let \(Q\) be a joint \(n\)-type and let \(P_{WZ}\) have marginal \(Q\), with \(m\) auxiliary symbols. In each column \(z\), round the real counts \(nP(w,z)\) down and distribute the remaining integer units to the largest fractional parts. This preserves the integer column sum \(nQ(z)\), producing a joint type \(T\) with

\[
T_Z=Q,\qquad |T(w,z)-P(w,z)|\lt 1/n,
\qquad \|T-P\|_{\rm TV}\le d/n.
\tag{83}
\]

Zero columns remain zero. Every marginal used below has alphabet size at most \(d\).

The number of units added in a column is the sum of its fractional parts, which is an integer smaller than \(m\). When it is positive, enough entries have positive fractional parts to receive those units, so the error in every cell is strictly smaller than one count. The marginal on \(Z\) is preserved exactly, whereas the marginal on \(W\) may change. Including all auxiliary types in the codebook is what permits this change. For distributions on such an alphabet with total variation at most \(d/n\),

\[
|H(P)-H(T)|\le 2d\ell_n/n.
\tag{84}
\]

Indeed, if \(n\ge d\), the coupling entropy bound, with actual distance \(\delta\le d/n\), yields
\(h(\delta)+\delta\log d\le\delta\log(ed/\delta)
\le(d/n)(1+\log n)\).
If \(n\lt d\), use \(\log d\le(d/n)(1+\log n)\).
Finally \(1+\log n\le2\log(n+1)\). A one-symbol alphabet is immediate.

The coupling bound can be obtained by coupling the two laws with mismatch probability \(\delta\). Conditional on the mismatch indicator, either symbol has at most \(d\) possibilities given the other. Thus both conditional entropies are at most \(h(\delta)+\delta\log d\), which bounds the difference of the marginal entropies. Marginalization cannot increase total variation, so this argument applies to every joint or marginal entropy in (85), using the same constant.

Since the \(Z\)-marginal is unchanged, expanding the information quantities into entropies gives

\[
|I_T(W;Z)-I_P(W;Z)|\le4d\ell_n/n,
\qquad
|I_T(X;Y\mid W)-I_P(X;Y\mid W)|\le8d\ell_n/n.
\tag{85}
\]

No lower bound on a positive probability is required.

### 10.4. An integer-budget simultaneous covering construction

Set

\[
\Delta_n=(A_0+4d)\ell_n/n,
\qquad N_0=\lfloor e^{nR}\rfloor.
\tag{86}
\]

First suppose \(R\ge\Delta_n\). Let \(L\) be the number of \(n\)-types on \([m]\), so \(L\le(n+1)^m\). Assign each type exactly

\[
M=\left\lfloor\frac{N_0}{L}\right\rfloor
=\left\lfloor\frac{e^{nR}}L\right\rfloor
\quad\text{labels},\qquad
N=LM\le N_0.
\tag{87}
\]

The rate assumption ensures \(e^{nR}/L\ge2\), hence
\(M\ge e^{nR}/(2L)\).

The floor identity in (87) holds because \(L\) is an integer. Thus there is no need to round each type allocation upward or introduce nonuniform type weights. Also \(N\ge e^{nR}/2\) in this branch. The polynomial loss is the allocation to a particular auxiliary type, rather than an additional number of seed labels outside the prescribed budget. For each auxiliary type, sample its \(M\) codewords independently and uniformly from its type class, with replacement. Labels are retained when codewords coincide, so the seed remains uniform on exactly \(N\) labels.

For a joint type \(T_{WZ}\) and \(z^n\in\mathcal T_{T_Z}\), the number of compatible labels is binomial, with mean \(\mu(T)=Mp(T)\), where

\[
p(T)=
\frac{|\mathcal T_{T_{W|Z}}(z^n)|}{|\mathcal T_{T_W}|}
\ge(n+1)^{-d}e^{-nI_T(W;Z)}.
\tag{88}
\]

The inequality follows from the multinomial type bounds
\((n+1)^{-v}e^{nH(V)}\le|\mathcal T_V|\le e^{nH(V)}\): apply the lower bound to each conditional column and the upper bound to the denominator. The probability \(p(T)\) is independent of the coordinate arrangement of \(z^n\).

For the type-class lower bound, the multinomial distribution with parameter equal to a type assigns its largest count probability to that type. This follows by comparing factorial ratios: increasing a count beyond its integer mean contributes factors at most one, as does decreasing a count below that mean. Since at most \((n+1)^v\) count vectors are possible, this maximal probability is at least their reciprocal. Its value is \(|\mathcal T_V|e^{-nH(V)}\), proving the stated bound, including zero-count coordinates.

Require at least \(\mu(T)/2\) compatible labels whenever
\(\mu(T)\ge8[(k+d)n+1]\). A Chernoff bound makes the failure probability for one requirement at most \(e^{-\mu(T)/8}\).

For clarity, if \(B\) is the binomial count, then for \(u>0\), its exponential moment is at most \(\exp\{\mu(e^{-u}-1)\}\). Markov's inequality bounds \(\Pr\{B\lt \mu/2\}\) by \(\exp\{\mu(u/2+e^{-u}-1)\}\). Taking \(u=\log2\) gives the displayed weaker bound. Counts belonging to different requirements need not be independent; the subsequent union bound uses only these individual estimates. There are at most \(k^n(n+1)^d\) requirements, including all individual sequences. The auxiliary marginal is already determined by the joint type, so there is no further factor for choosing it. A joint count table has at most \((n+1)^d\) possibilities, and each table concerns at most \(k^n\) sequences. Restricting to requirements with sufficiently large mean can only reduce this number. Therefore the total failure probability is at most

\[
\exp\{n\log k+d\log(n+1)-[(k+d)n+1]\}
\le e^{-1}\lt 1.
\tag{89}
\]

Fix an array satisfying every requirement. Its definition uses no target or divergence order. For example, one can select the first such array in a fixed lexicographic order. The requirements are finite rational count comparisons, since \(p(T)\) is a ratio of multinomial coefficients. This establishes a deterministic construction without asserting computational efficiency.

Every joint type with

\[
I_T(W;Z)\le R-A_0\ell_n/n
\tag{90}
\]

is covered. Indeed, (87)–(88) and the definition of \(j_0\) give

\[
\mu(T)\ge\tfrac12(n+1)^{A_0-m-d}
=\tfrac12(n+1)^{1+j_0}
\ge8(k+d+1)(n+1)
\ge8[(k+d)n+1].
\tag{91}
\]

The extra polynomial factor pays for simultaneous coverage of exponentially many sequences, not merely polynomially many types.

### 10.5. Local kernels and the pointwise bound

For a selected codeword \(w^n\), use

\[
\begin{aligned}
A_{w^n}&=\frac1{|\mathcal P_n(\mathcal X|w^n)|}
\sum_{V_{X|W}}\operatorname{Unif}(\mathcal T_{V_{X|W}}(w^n)),\\
B_{w^n}&=\frac1{|\mathcal P_n(\mathcal Y|w^n)|}
\sum_{V_{Y|W}}\operatorname{Unif}(\mathcal T_{V_{Y|W}}(w^n)).
\end{aligned}
\tag{92}
\]

Conditional types are integer count tables with the prescribed row sums; zero rows have one fixed zero table. Their numbers are at most \((n+1)^{ma}\) and \((n+1)^{mb}\). Therefore a compatible triple of joint type \(T\) satisfies

\[
A_{w^n}(x^n)B_{w^n}(y^n)
\ge(n+1)^{-m(a+b)}
 e^{-n[H_T(X|W)+H_T(Y|W)]}.
\tag{93}
\]

The terminals choose their local conditional types independently. Each kernel is positive on every local sequence.

For fixed \(w^n\), the conditional type classes partition all local sequences. Consequently each displayed mixture is a probability law, and every sequence belongs to one nonempty class in that mixture. The local procedure is simply to sample a conditional count table and then a uniform member of its class. The shared label specifies only the codeword; it contains no target type or separately coordinated choice of the two local count tables.

For a covered \(T\), retain its compatible labels in the output mixture. The fraction of those labels is at least \(Mp(T)/(2LM)=p(T)/(2L)\). Hence, using (88),

\[
P_n(z^n)\ge\tfrac12(n+1)^{-[m+d+m(a+b)]}
 e^{-n[H(Q)+I_T(X;Y|W)]},
\tag{94}
\]

because
\(I_T(W;Z)+H_T(X|W)+H_T(Y|W)
=H(Q)+I_T(X;Y|W)\).

Fix any joint type \(Q\). Choose an optimizer for
\(\lambda_Q(R-\Delta_n)\), and round it using Section 10.3. Its information cost is at most
\(R-\Delta_n+4d\ell_n/n=R-A_0\ell_n/n\), so it is covered. Its conditional mutual information is at most
\(\lambda_Q(R-\Delta_n)+8d\ell_n/n\). Consequently

\[
P_n(z^n)\ge(n+1)^{-B_0}
 e^{-n[H(Q)+\lambda_Q(R-\Delta_n)]}.
\tag{95}
\]

Here \(1/2\ge(n+1)^{-1}\) absorbs the remaining constant. By (82), replacing \(\lambda_Q(R-\Delta_n)\) by \(\lambda_Q(R)+\Delta_n\) proves (81). The optimizing auxiliary is only a witness for this inequality; it is not an input to the codebook or kernels.

The same fixed array therefore works for every joint type at once, even though the analytical witness can differ between types. The rounded witness has the exact empirical pair marginal required by the given sequence, so its conditional type class is nonempty. At \(R=\Delta_n\), the witness may be the constant auxiliary at zero information cost; all preceding estimates remain valid. This covers the boundary between the two rate regimes without a limiting argument.

It remains to cover \(0\le R\lt \Delta_n\). Use one seed and the product of the uniform mixtures over all unconditional \(X\)- and \(Y\)-type classes. For every joint type \(Q\), this gives

\[
\begin{aligned}
P_n(z^n)&\ge(n+1)^{-(a+b)}
 e^{-n[H(Q_X)+H(Q_Y)]}\\
&\ge(n+1)^{-[a+b+A_0+4d]}
 e^{-n[H(Q)+\lambda_Q(R)]},
\end{aligned}
\tag{96}
\]

using \(I_Q(X;Y)\le\lambda_Q(R)+R\) and \(nR\lt (A_0+4d)\ell_n\). This exponent is at most \(C_{a,b}\). It includes \(R=0\) and every small block length. Since \(A_0+4d\) is an integer, the two branches can be chosen solely from whether \(N_0\ge(n+1)^{A_0+4d}\).

### 10.6. Divergence bounds and support conventions

For \(Q\ll\pi\) and \(z^n\in\mathcal T_Q\),
\(\pi^{\otimes n}(z^n)=e^{-n[H(Q)+D(Q\Vert\pi)]}\).
For finite \(\beta\), group the Rényi sum by joint types and apply (81) and \(|\mathcal T_Q|\le e^{nH(Q)}\):

\[
\begin{aligned}
\sum_{z^n}\pi^{\otimes n}(z^n)^{1+\beta}P_n(z^n)^{-\beta}
&\le(n+1)^{C_{a,b}\beta}
\sum_{Q\in\mathcal P_n(\mathcal Z):Q\ll\pi}
 e^{n\beta[\lambda_Q(R)-c_\beta D(Q\Vert\pi)]}\\
&\le(n+1)^{C_{a,b}\beta+k}e^{n\beta E_\beta(\pi,R)}.
\end{aligned}
\tag{97}
\]

Taking logarithms and dividing by \(\beta\) proves the upper bound. Types outside the support contribute zero. The maximum over types is bounded directly by the maximum in (78); no approximation of a maximizing law or target-dependent continuity constant is needed.

This direction of comparison is useful for targets with very small positive masses. Rounding the target or an outer maximizing law would generally require controlling the resulting divergence error. Here only the auxiliary is rounded, while each empirical pair law and its divergence from the actual target are kept exact. The final type sum introduces the sole order-dependent overhead \(k/\beta\).

At infinite order, apply (81) directly to each positive target mass:

\[
\log\frac{\pi^{\otimes n}(z^n)}{P_n(z^n)}
\le C_{a,b}\ell_n+n[\lambda_Q(R)-D(Q\Vert\pi)]
\le C_{a,b}\ell_n+nE_\infty(\pi,R).
\tag{98}
\]

Taking the maximum proves the endpoint without interchanging limits.

For the lower bound, consider any admissible code. Infinite divergence is immediate. Otherwise its output is positive on the source support. For \(Q\ll\pi\), the proof of Lemma 3.2 still applies: normalize the tilt
\(\pi^{\otimes n}(z^n)^{1+\beta}P_n(z^n)^{-\beta}\)
on that support and expand the divergence from \(Q^{\otimes n}\). It gives

\[
D(Q^{\otimes n}\Vert P_n)
\le c_\beta nD(Q\Vert\pi)+d_n.
\tag{99}
\]

No renormalization of the code output is made.

The tilt is a probability law on the source support even when the code puts some mass outside it. The test law is absolutely continuous with respect to that tilt because \(Q\ll\pi\). In the posterior transfer, only source-supported sequences receive positive test mass, and every such sequence has a well-defined code posterior. Thus the absolute-continuity steps used in Section 3 remain valid without requiring the target to have full product support. At infinite order, the same inequality follows by bounding the log likelihood ratio by its maximum. The posterior transfer and full-history single-letterization of Lemmas 3.3–3.4 then produce an auxiliary with
\(I(Z;W)\le\log N/n\le R\) and
\(I(X;Y|W)\le D(Q^{\otimes n}\Vert P_n)/n\).
Thus \(n\lambda_Q(R)\le D(Q^{\otimes n}\Vert P_n)\). Combine this with (99), maximize over \(Q\ll\pi\), and minimize over codes to obtain the other half of (80).

When \(E_\beta(\pi,R)=0\), this universal construction guarantees a logarithmic divergence bound. The estimate concerns the normalized criterion and does not assert that the same target-independent code has vanishing unnormalized divergence.

## 11. Dual profiles, product sources, and a common-parameter criterion

Throughout this section the alphabets are finite, the target law may have zeros, and the finite real number \(c\ge1\) is fixed. Write \(Z=(X,Y)\). For \(0\le s\le1\), define

\[
\Phi_Q(s)=\min_{Q_{W|Z}}
\bigl\{I_Q(X;Y|W)+sI_Q(Z;W)\bigr\},
\qquad
A_{\pi,c}(s)=\max_{Q\ll\pi}
\bigl\{\Phi_Q(s)-cD(Q\Vert\pi)\bigr\}.
\tag{100}
\]

By the information-preserving compression in Lemma 3.1, the auxiliary alphabet may be restricted uniformly to
\(|\mathcal X||\mathcal Y|+2\). The minimum is attained, and \(\Phi_Q(s)\) is jointly continuous in \(Q,s\): parameterize the joint law as \(Q(z)K(w|z)\) on a fixed auxiliary alphabet and minimize a continuous function over the compact set of kernels \(K\). The maximum defining \(A_{\pi,c}\) is also attained. Indeed, \(Q\ll\pi\) is a compact face of the probability simplex, and KL divergence is continuous on that face. We use the notation \(E_c(\pi,R)=\max_{Q\ll\pi}\{\lambda_Q(R)-cD(Q\Vert\pi)\}\); it agrees with \(E_\beta\) of Section 10 when \(c=c_\beta\).

Let

\[
\Gamma_c(\pi)=\sup_{Q\ll\pi}C(Q,cD(Q\Vert\pi)).
\tag{101}
\]

For \(c=1+1/\beta\), this is the variational critical rate associated with order \(-\beta\); \(c=1\) corresponds to order \(-\infty\). For a general finite source, \(C_W(Q)\) denotes \(C(Q,0)\).

### Lemma 11.1. Dual formulas and concavity in the test law

For every joint law \(Q\) and every \(R\ge0\),

\[
\lambda_Q(R)=\max_{0\le s\le1}\{\Phi_Q(s)-sR\},
\qquad
E_c(\pi,R)=\max_{0\le s\le1}\{A_{\pi,c}(s)-sR\}.
\tag{102}
\]

For each fixed \(s\in[0,1]\), the map
\[
Q\longmapsto\Phi_Q(s)-cD(Q\Vert\pi)
\tag{103}
\]
is concave on \(Q\ll\pi\). It is strictly concave when \(c>1\).

**Proof.** The rate function \(\lambda_Q\) is convex, nonincreasing, and globally 1-Lipschitz. For convexity, take optimizers at two rates and use an independent mixture flag included in the auxiliary; the resulting two information quantities are the corresponding weighted averages. Monotonicity follows by enlarging the feasible set, and the Lipschitz bound was proved in Section 10.2 from
\(I(X;Y|W)\ge I(X;Y)-I(Z;W)\). Moreover,
\[
\Phi_Q(s)=\min_{u\ge0}\{\lambda_Q(u)+su\}.
\]
Every supporting slope of \(\lambda_Q\) can be chosen in \([-1,0]\). Supporting-line duality therefore gives the first formula in (102), including \(R=0\) and the zero part of the rate function. Interchanging the two maxima over \(Q\) and \(s\) gives the second formula; no minimax interchange is involved.

For concavity, write \(Q=\sum_ta_tQ_t\), choose a kernel attaining \(\Phi_Q(s)\), and construct
\[
P(t,z,w)=a_tQ_t(z)K(w|z).
\]
Thus \(T-Z-W\) is a Markov chain. The information chain rules give
\[
\begin{aligned}
I(X;Y|W)-I(X;Y|W,T)
&=I(X;T|W)+I(Y;T|W)-I(Z;T|W)\\
&\ge-I(Z;T|W),\\
I(Z;W)-I(Z;W|T)&=I(T;W).
\end{aligned}
\tag{104}
\]
Since \(I(Z;T|W)=I(Z;T)-I(W;T)\), evaluating the same kernel under each \(Q_t\) yields
\[
\Phi_Q(s)\ge
\sum_ta_t\Phi_{Q_t}(s)-I(Z;T)+(1+s)I(T;W).
\]
The KL mixture identity is
\[
\sum_ta_tD(Q_t\Vert\pi)-D(Q\Vert\pi)=I(Z;T).
\]
Consequently,
\[
\begin{aligned}
\Phi_Q(s)-cD(Q\Vert\pi)
&\ge\sum_ta_t\bigl[\Phi_{Q_t}(s)-cD(Q_t\Vert\pi)\bigr]\\
&\quad +(c-1)I(Z;T)+(1+s)I(T;W).
\end{aligned}
\tag{105}
\]
The last two terms are nonnegative. If \(c>1\) and two positively weighted test laws differ, \(I(Z;T)>0\), proving strict concavity. ∎

### Lemma 11.2. Product identity at a common parameter

For arbitrary finite targets \(\pi_1,\pi_2\), including targets with zeros,

\[
\boxed{
A_{\pi_1\otimes\pi_2,c}(s)
=A_{\pi_1,c}(s)+A_{\pi_2,c}(s)
}\qquad(0\le s\le1).
\tag{106}
\]

**Proof.** First consider a product test law \(Q_1\otimes Q_2\). For any joint auxiliary \(W\), use \(W_1=W\) and \(W_2=(W,Z_1)\). Independence of \(Z_1,Z_2\) and the entropy chain rule give
\[
\sum_{i=1}^2I(Z_i;W_i)=I(Z_1Z_2;W),\qquad
\sum_{i=1}^2I(X_i;Y_i|W_i)
\le I(X_1X_2;Y_1Y_2|W).
\]
Independent optimal auxiliaries give the reverse inequality. Hence
\[
\Phi_{Q_1\otimes Q_2}(s)=\Phi_{Q_1}(s)+\Phi_{Q_2}(s).
\tag{107}
\]
This inner additivity has a known tension-region interpretation [12]: the minimized objective equals
\[
sI_Q(X;Y)+(1-s)I_Q(X;Y|W)
+sI_Q(X;W|Y)+sI_Q(Y;W|X).
\]
All three coefficients of the tension coordinates are nonnegative. The independent-source tension identity therefore supplies (107); the direct entropy proof above is included for completeness. Together with additive KL divergence, (107) proves the lower bound in (106). Any product auxiliary exceeding the fixed sufficient alphabet is compressed by Lemma 3.1 while preserving its information quantities.

For the upper bound, let \(Q_{Z_1Z_2}\ll\pi_1\otimes\pi_2\) be arbitrary. Apply an optimal kernel for \(\Phi_{Q_i}(s)\) separately to each \(Z_i\), with the two kernels conditionally independent. Put
\[
T=I_Q(Z_1;Z_2),\qquad \Delta=I(W_1;W_2)\ge0.
\]
The product-kernel structure implies
\[
I(Z_1Z_2;W_1W_2)=\sum_i I(Z_i;W_i)-\Delta.
\]
Also,
\[
\sum_iH(Z_i|W_i)-H(Z_1Z_2|W_1W_2)=T-\Delta.
\]
Bounding the two positive conditional entropies separately therefore gives
\[
I(X_1X_2;Y_1Y_2|W_1W_2)
\le\sum_iI(X_i;Y_i|W_i)+T-\Delta.
\]
It follows that
\[
\Phi_Q(s)\le\sum_i\Phi_{Q_i}(s)+T-(1+s)\Delta.
\tag{108}
\]
On the other hand,
\[
D(Q\Vert\pi_1\otimes\pi_2)
=\sum_iD(Q_i\Vert\pi_i)+T.
\]
Subtracting \(cD\) from (108), the remaining correlation terms are
\((1-c)T-(1+s)\Delta\le0\). Maximization proves the upper bound. ∎

### Lemma 11.3. Continuous extension at zero

Define

\[
a_{\pi,c}(s)=\frac{A_{\pi,c}(s)}s\quad(s>0),\qquad
a_{\pi,c}(0)=C_W(\pi).
\tag{109}
\]

For fixed alphabets this defines a jointly continuous function of \(\pi,s\) on the whole probability simplex times \([0,1]\). Its convergence at \(s=0\) is uniform in \(\pi\) and in \(c\ge1\).

**Proof.** We first establish continuity of \(C_W\), including changes of support. Lower semicontinuity follows by taking a convergent subsequence of optimal auxiliaries on a fixed sufficient alphabet.

For upper semicontinuity, fix \(\pi\) and let \(Q\to\pi\). Set
\[
\delta=\max_{z:\pi(z)>0}\left(1-\frac{Q(z)}{\pi(z)}\right)_+.
\]
Then \(\delta\to0\). If \(\delta=0\), coordinatewise domination and equal total masses imply \(Q=\pi\). Otherwise, for all sufficiently close \(Q\),
\[
Q=(1-\delta)\pi+\delta S
\]
for a probability law \(S\). Combine an optimal conditional-product representation of \(\pi\) with the point-mass representation of \(S\), including the mixture flag in the auxiliary. Conditional independence is preserved, and
\[
C_W(Q)\le h(\delta)+(1-\delta)C_W(\pi)
+\delta\log(|\mathcal X||\mathcal Y|).
\tag{110}
\]
This proves upper semicontinuity.

For each \(Q\),
\[
\frac{\Phi_Q(s)}s
=\min_W\left\{I_Q(Z;W)+\frac{I_Q(X;Y|W)}s\right\}
\uparrow C_W(Q)\quad(s\downarrow0).
\tag{111}
\]
To verify the limit, use an optimal auxiliary for each \(s\). Its conditional mutual information is at most \(sC_W(Q)\), and its mutual information with \(Z\) is at most \(C_W(Q)\). Compactness produces a conditionally independent limit, whose mutual information cannot be smaller than \(C_W(Q)\).

Each positive-\(s\) function in (111) is continuous in \(Q\), and \(C_W\) is continuous on the compact simplex. Dini's theorem along a sequence \(s_j\downarrow0\), followed by monotone interpolation between successive \(s_j\), proves uniform convergence for all \(s\downarrow0\).

Write \(L=\log\min\{|\mathcal X|,|\mathcal Y|\}\), and choose a maximizing test law \(Q_s\) for \(A_{\pi,c}(s)\). Since \(A_{\pi,c}(s)\ge\Phi_\pi(s)\ge0\),
\[
cD(Q_s\Vert\pi)\le\Phi_{Q_s}(s)\le sL.
\tag{112}
\]
Pinsker's inequality gives
\(\|Q_s-\pi\|_{\rm TV}\le\sqrt{sL/(2c)}\). Furthermore,
\[
\frac{\Phi_\pi(s)}s
\le a_{\pi,c}(s)\le C_W(Q_s).
\tag{113}
\]
Uniform convergence in (111) and uniform continuity of \(C_W\) now prove the asserted uniform extension.

For positive \(s\), continuity in \(\pi\) follows without a full-support assumption. A convergent subsequence of maximizing test laws and lower semicontinuity of KL prove the upper bound for the limit. For the lower bound, fix an optimizer \(Q\ll\pi\). Every coordinate positive under \(Q\) remains positive under all sufficiently close targets \(\pi_j\), and \(D(Q\Vert\pi_j)\to D(Q\Vert\pi)\). Continuity in positive \(s\) is immediate from the compact optimizations. Combining these facts with the uniform extension proves joint continuity. ∎

### Theorem 11.4. Critical rates and the additivity criterion

For every finite target,

\[
\boxed{
\Gamma_c(\pi)=\max_{0\le s\le1}a_{\pi,c}(s).
}
\tag{114}
\]

In particular, \(\Gamma_c\) is continuous in the target law, including at targets with zeros. Let
\[
\mathcal S_{\pi,c}
=\arg\max_{s\in[0,1]}a_{\pi,c}(s).
\]
For any two finite targets,
\[
\Gamma_c(\pi_1\otimes\pi_2)
=\max_{s\in[0,1]}
\{a_{\pi_1,c}(s)+a_{\pi_2,c}(s)\},
\tag{115}
\]
and
\[
\boxed{
\Gamma_c(\pi_1\otimes\pi_2)=\Gamma_c(\pi_1)+\Gamma_c(\pi_2)
\iff
\mathcal S_{\pi_1,c}\cap\mathcal S_{\pi_2,c}\ne\varnothing.
}
\tag{116}
\]
For every positive integer \(m\),
\[
\Gamma_c(\pi^{\otimes m})=m\Gamma_c(\pi),\qquad
E_c(\pi^{\otimes m},mR)=mE_c(\pi,R).
\tag{117}
\]

**Proof.** Attainment of the auxiliary optima gives
\[
\lambda_Q(R)\le t\iff C(Q,t)\le R.
\]
Since \(E_c(\pi,R)\ge0\), it vanishes exactly when the left inequality holds with \(t=cD(Q\Vert\pi)\) for every admissible \(Q\). Thus \(\Gamma_c(\pi)\) is precisely the lower endpoint of the zero set of \(E_c(\pi,\cdot)\).

By (102), this zero set is equivalently the set of \(R\) satisfying \(A_{\pi,c}(s)\le sR\) for every \(s>0\). Lemma 11.3 turns the resulting supremum of \(A(s)/s\) into the compact maximum in (114). Continuity of that maximum follows from joint continuity.

For \(s>0\), Lemma 11.2 makes the profile of a product equal to the sum of the two profiles. Taking the continuous limit at zero gives the same identity there, including \(C_W(\pi_1\otimes\pi_2)=C_W(\pi_1)+C_W(\pi_2)\). This proves (115).

The sum of two continuous functions attains the sum of their separate maxima exactly when they have a common maximizing point. This proves (116). Repeating the same profile \(m\) times proves the first identity in (117); applying (102) to \(mA_{\pi,c}(s)\) proves the second. ∎

### Corollary 11.5. Normalized operational rate for every finite target

For \(c=c_\beta\) and every finite target, including zero-support laws,
\[
\widetilde T_{-\beta}(\pi)=\Gamma_c(\pi).
\tag{118}
\]
Moreover, for each fixed \(R\ge0\),
\(d_n^*(\pi,\beta,R)/n\to E_c(\pi,R)\).

**Proof.** The last assertion follows directly from Theorem 10.1. Each \(\lambda_Q\) is nonincreasing and 1-Lipschitz, so its supremum after subtracting \(cD\), namely \(E_c\), has these properties as well. Theorem 11.4 identifies its zero set as \([\Gamma_c(\pi),\infty)\). At \(R=\Gamma_c(\pi)\), the universal codes in Theorem 10.1 have normalized divergence tending to zero and rate at most \(R\).

Conversely, if a code sequence has \(\limsup R_n\le R\) and normalized divergence tending to zero, then, for every \(\eta>0\), its eventual rates are at most \(R+\eta\). The finite-block lower bound gives \(E_c(\pi,R+\eta)=0\). Rate continuity and then \(\eta\downarrow0\) give \(E_c(\pi,R)=0\), hence \(R\ge\Gamma_c(\pi)\). This proves (118). This normalized-profile argument alone does not conclude unnormalized convergence; Proposition A.1 supplies it using the separately attributed achievability input. ∎

## 12. Strict subadditivity for full-support independent sources

### Theorem 12.1. A full-support strict-subadditivity example at every fixed negative order

Fix \(\beta\in(0,\infty]\), put \(c=1+1/\beta\), and let
\(\pi_1=\operatorname{DSBS}(1/4)\). Choose a nonuniform binary law
\(p=(p_0,p_1)\) with \(p_0,p_1>0\), and define
\[
\rho_\delta=(1-\delta)\operatorname{diag}(p)
+\delta\,\operatorname{Unif}(\{0,1\}^2).
\tag{119}
\]
There exists \(\delta_0>0\), possibly depending on \(\beta,p\), such that for every \(0\lt \delta\lt \delta_0\),
\[
\boxed{
\Gamma_c(\pi_1\otimes\rho_\delta)
\lt \Gamma_c(\pi_1)+\Gamma_c(\rho_\delta).
}
\tag{120}
\]
All three targets in (120) have full support. Consequently, the operational matching theorem for full-support targets gives
\[
T_{-\beta}(\pi_1\otimes\rho_\delta)
\lt T_{-\beta}(\pi_1)+T_{-\beta}(\rho_\delta),
\tag{121}
\]
and the same strict inequality holds for \(\widetilde T_{-\beta}\).

We prove the theorem by locating the maximizing profile parameters of two limiting sources.

### Lemma 12.2. The DSBS profile has only the zero maximizing parameter

For every \(c\ge1\), with \(\pi_1=\operatorname{DSBS}(1/4)\),
\[
a_{\pi_1,c}(0)=C_W(\pi_1),\qquad
a_{\pi_1,c}(s)\lt C_W(\pi_1)\quad(0\lt s\le1).
\tag{122}
\]
Thus \(\mathcal S_{\pi_1,c}=\{0\}\).

**Proof.** Set \(\epsilon=1/4\) and \(w=C_W(\epsilon)\). The source coordinate is \(t=\log3\lt 2\lt t_*\). The results of Sections 6–7 therefore give \(k(\epsilon)\lt 1\) and \(\Gamma_c(\pi_1)=w\).

We need a strict scalar comparison away from \(r=\epsilon\). In the curvature factorization of Section 6, \(k(\epsilon)\lt 1\) implies \(A''(v_0)/D''(v_0)>0\), hence \(S(v_0)>0\). Since \(S\) strictly increases and the positive factor remains positive for \(v\lt 1\), \(A''/D''>0\) throughout that interval. Thus \(G=D-\tau\) has zero initial value and derivative and strictly positive second derivative. It is positive and increasing thereafter; its continuous endpoint at \(v=1\) is also strictly positive. Consequently
\[
K_\epsilon(r)\lt 1\quad(0\le r\lt \epsilon).
\]
The scalar boundary equivalence of Section 4 gives
\[
C(r,cD(r\Vert\epsilon))\lt w\quad(0\le r\lt \epsilon).
\tag{123}
\]
For \(\epsilon\lt r\le1/2\), the same conclusion follows from
\(C(r,t)\le C_W(r)\lt C_W(\epsilon)\).

Fix \(s>0\). The test-law objective in (103) is concave and invariant under joint bit complementation. Averaging a law with its joint complement therefore restricts its maximization to DSBS laws. Complementing one terminal preserves \(\Phi\), and replaces \(r>1/2\) by \(1-r\) with no larger divergence from \(\operatorname{DSBS}(\epsilon)\). Hence
\[
A_{\pi_1,c}(s)
=\max_{0\le r\le1/2}
\{\Phi_{\operatorname{DSBS}(r)}(s)-cD(r\Vert\epsilon)\}.
\tag{124}
\]
For \(r\ne\epsilon\), choose an auxiliary attaining \(C(r,cD(r\Vert\epsilon))\). Equation (123) gives
\[
\Phi_{\operatorname{DSBS}(r)}(s)-cD(r\Vert\epsilon)
\le sC(r,cD(r\Vert\epsilon))\lt sw.
\]

At \(r=\epsilon\), use the relaxed-Wyner parametrization from Section 2. Put \(q=b(\epsilon)+u\), with \(u>0\) small. Its tolerance and objective satisfy
\[
\begin{aligned}
t(u)&=\tfrac12F_{\epsilon,qq}(b(\epsilon))u^2+O(u^3),\\
C(\epsilon,t(u))
&=w-(1-\epsilon)h'(b(\epsilon))u+O(u^2).
\end{aligned}
\tag{125}
\]
Both displayed leading coefficients are strictly positive, by (31) and \(0\lt b(\epsilon)\lt 1/2\). For each fixed \(s>0\), choosing sufficiently small \(u>0\) therefore gives
\[
\Phi_{\pi_1}(s)\le t(u)+sC(\epsilon,t(u))\lt sw.
\]
Every point in the compact maximum (124) is now strictly below \(sw\). Continuity ensures that its attained maximum is also strictly below \(sw\). Lemma 11.3 supplies the endpoint value at zero. ∎

### Lemma 12.3. A nonuniform diagonal source selects the other endpoint

Let \(\rho=\operatorname{diag}(p)\). Then
\[
\lambda_{\operatorname{diag}(q)}(R)=[H(q)-R]_+,
\qquad
\Phi_{\operatorname{diag}(q)}(s)=sH(q),
\tag{126}
\]
and
\[
\begin{aligned}
A_{\rho,c}(s)&=(c+s)\log\sum_i p_i^{c/(c+s)},\\
a_{\rho,c}(s)&=H_{c/(c+s)}(p)\quad(s>0),\\
E_c(\rho,R)&=[H_{c/(c+1)}(p)-R]_+.
\end{aligned}
\tag{127}
\]
If \(p\) is nonuniform on its support and has at least two positive masses, \(a_{\rho,c}\) is strictly increasing on \([0,1]\). In particular, \(\mathcal S_{\rho,c}=\{1\}\).

**Proof.** On the diagonal, \(X=Y\), so
\(I(X;Y|W)=H(q)-I(X;W)\). An erasure auxiliary realizes every mutual information between zero and \(H(q)\), proving (126).

For \(s>0\), set \(\alpha=c/(c+s)\) and
\(q_s(i)=p_i^\alpha/\sum_jp_j^\alpha\). Direct expansion gives
\[
sH(q)-cD(q\Vert p)
=(c+s)\log\sum_i p_i^\alpha-(c+s)D(q\Vert q_s).
\]
This proves the first two formulas in (127). Similarly,
\[
\begin{aligned}
E_c(\rho,R)
&=\max_q\max\{H(q)-R-cD(q\Vert p),-cD(q\Vert p)\}\\
&=\max\{H_{c/(c+1)}(p)-R,0\}.
\end{aligned}
\]
Rényi entropy is strictly decreasing in its order for a nonuniform law on its support, while \(c/(c+s)\) strictly decreases in \(s\). The continuous limit at zero is \(H(p)\), proving the final assertion. ∎

At \(R=0\), the entropy order in (127) is the diagonal specialization of the Lapidoth–Pfister dependence measure [9]: their Lemma 11 gives \(J_\alpha(X;X)=H_{\alpha/(2\alpha-1)}(X)\) for \(\alpha>1/2\), with the continuous infinite-order limit. Taking \(\alpha=1+\beta\) yields \(c/(c+1)=(\beta+1)/(2\beta+1)\).

**Proof of Theorem 12.1.** Lemmas 12.2 and 12.3 give disjoint maximizing sets, \(\{0\}\) and \(\{1\}\). Theorem 11.4 therefore gives a strictly positive variational gap
\[
\Gamma_c(\pi_1)+\Gamma_c(\rho)-\Gamma_c(\pi_1\otimes\rho)>0.
\tag{128}
\]
Because \(\Gamma_c\) is continuous on the entire simplex and
\(\rho_\delta\to\rho\), this gap remains positive for all sufficiently small \(\delta>0\). This proves (120).

For such \(\delta\), \(\pi_1,\rho_\delta\), and their product all have full support. The operational equality for full-support targets, Theorem 3.5, can therefore be applied to each of them, proving (121) and its normalized counterpart. The singular diagonal source is used only for the variational comparison and the continuity argument. This proof does not require the unnormalized zero-support identity subsequently supplied in Proposition A.1. The continuity argument selects \(\delta_0\) for each fixed order and makes no claim that one positive perturbation works uniformly over all negative orders. ∎

### Remark 12.4. Nonconcavity and the failure of a heterogeneous allocation formula

The concavity in Lemma 11.1 concerns the test law \(Q\) at a fixed \(s\). It does not imply concavity of \(A_{\pi,c}(s)\). Indeed, for a nonuniform diagonal source,
\[
A_{\rho,c}''(s)
=\frac{c^2}{(c+s)^3}
\operatorname{Var}_{q_s}(\log p)>0.
\tag{129}
\]

The common parameter in the product identity cannot generally be replaced by independently optimized parameters. One always has
\[
E_c(\pi_1\otimes\pi_2,R)
\le\inf_{\substack{R_1,R_2\ge0\\R_1+R_2=R}}
\{E_c(\pi_1,R_1)+E_c(\pi_2,R_2)\},
\tag{130}
\]
because each term on the right dominates its own dual expression at every common \(s\). Equality need not hold. In the strict-subadditivity example, choose \(R\) strictly between the product critical rate and the sum of the separate critical rates. The left side of (130) is zero. Every allocation on the right leaves at least one rate below its own critical rate, so its sum is positive; continuity and compactness make the infimum strictly positive.

Identical copies satisfy the exact identities (117). The obstruction for heterogeneous factors is the absence of a common maximizing parameter, as characterized by (116).

## 13. Universal finite removal of the negative-order excess

The product identity in Section 11 permits a strict saving for selected heterogeneous sources. We now prove a universal finite statement. One fixed full-support binary source removes the entire excess over Wyner's common information of every finite target, after a finite number of copies that can be chosen independently of the negative order.

Throughout Sections 13–16 the targets have finite alphabets and may have zeros. The operational endpoint result in Proposition A.1 identifies the variational quantities with the corresponding operational rates on this full domain. We retain \(c=1+1/\beta\), with \(c=1\) for \(\beta=\infty\), and put
\[
\kappa=\operatorname{DSBS}(1/4),\qquad w=C_W(\kappa).
\tag{N1}
\]
For a target \(\pi\) on \(\mathcal X\times\mathcal Y\), define
\[
\mu_\pi=\min_{z:\pi(z)>0}\pi(z),\quad
\ell_\pi=\log\min\{|\mathcal X|,|\mathcal Y|\},\quad
L_\pi=\frac{\ell_\pi+\log(1/\mu_\pi)}{\mu_\pi}.
\tag{N2}
\]
An empty tensor power denotes the one-point source.

### Theorem 13.1. Finite removal by a fixed binary background

For every finite target \(\pi\), every integer
\[
m\ge\left\lceil\frac{25}{2}L_\pi^2\right\rceil
\tag{N3}
\]
satisfies
\[
\boxed{\Gamma_c(\pi\otimes\kappa^{\otimes m})
=C_W(\pi)+mC_W(\kappa)}
\qquad(c\ge1).
\tag{N4}
\]
Consequently, simultaneously for every \(\beta\in(0,\infty]\),
\[
T_{-\beta}(\pi\otimes\kappa^{\otimes m})
=\widetilde T_{-\beta}(\pi\otimes\kappa^{\otimes m})
=C_W(\pi)+mC_W(\kappa).
\tag{N5}
\]
The sufficient integer in (N3) is independent of \(\beta\); it is not asserted to be minimal.

At every rate strictly above the right side of (N5), one sequence of synthesis codes can be chosen whose reverse divergence tends to zero uniformly over all orders in \([1,\infty]\). Thus the same codes work even if the negative order varies with block length.

The background is jointly generated as part of the target output, and its own cost is included. The theorem does not assume a pre-supplied correlated resource that is returned for subsequent reuse.

### Lemma 13.2. A global one-sided bound on a support face

For every \(Q\ll\pi\),
\[
C_W(Q)-C_W(\pi)\le L_\pi\|Q-\pi\|_{\rm TV}.
\tag{N6}
\]

**Proof.** Write \(v=\|Q-\pi\|_{\rm TV}\) and
\[
\delta=\max_{z:\pi(z)>0}\left(1-\frac{Q(z)}{\pi(z)}\right)_+.
\]
If \(\delta=0\), equal total masses imply \(Q=\pi\). Otherwise
\[
Q=(1-\delta)\pi+\delta S,\qquad
0\lt \delta\le1,\qquad \delta\le v/\mu_\pi,
\tag{N7}
\]
for a law \(S\ll\pi\).

Let \(B\) be the mixture flag. Conditional on \(B=0\), use an optimal conditionally independent representation of \(\pi\). Conditional on \(B=1\), use a representation of \(S\) with shared information at most \(\ell_\pi\), by taking the smaller of the auxiliaries \(X\) and \(Y\). Include \(B\) in the combined auxiliary. Conditional independence is preserved, so
\[
C_W(Q)\le I(Z;B)+(1-\delta)C_W(\pi)+\delta\ell_\pi.
\tag{N8}
\]
The KL mixture identity with reference law \(\pi\) gives
\[
I(Z;B)=\delta D(S\Vert\pi)-D(Q\Vert\pi)
\le\delta\log(1/\mu_\pi).
\tag{N9}
\]
Indeed, \(D(S\Vert\pi)=-H(S)-\sum_zS(z)\log\pi(z)\le\log(1/\mu_\pi)\).
Subtract \(C_W(\pi)\) from (N8), discard the nonpositive term
\(-\delta C_W(\pi)\), and use (N7). This includes \(\delta=1\), and requires no positive probability outside \(\operatorname{supp}\pi\). ∎

### Lemma 13.3. A linear bound on the excess profile

For every \(c\ge1\) and \(0\le s\le1\),
\[
a_{\pi,c}(s)\le C_W(\pi)+\frac{L_\pi^2}{8c}s.
\tag{N10}
\]

**Proof.** For positive \(s\), a conditionally independent auxiliary gives
\(\Phi_Q(s)\le sC_W(Q)\). Lemma 13.2 and Pinsker's inequality in nats imply
\[
\begin{aligned}
a_{\pi,c}(s)
&\le\max_{Q\ll\pi}\left\{C_W(Q)-\frac csD(Q\Vert\pi)\right\}\\
&\le C_W(\pi)+\sup_{v\ge0}\left\{L_\pi v-\frac{2c}s v^2\right\}\\
&=C_W(\pi)+\frac{L_\pi^2}{8c}s.
\end{aligned}
\]
At zero use the continuous extension of Lemma 11.3. ∎

**Proof of Theorem 13.1.** The exact whole-interval certificate in Proposition 15.2 proves
\[
a_{\kappa,1}(s)\le w-\frac{s}{100},\qquad 0\le s\le1.
\tag{N11}
\]
Increasing \(c\) strengthens the nonnegative KL penalty, so
\(a_{\kappa,c}(s)\le a_{\kappa,1}(s)\) for \(s>0\); their endpoint values at zero coincide. Product additivity and Lemma 13.3 yield
\[
\begin{aligned}
a_{\pi\otimes\kappa^{\otimes m},c}(s)
&=a_{\pi,c}(s)+ma_{\kappa,c}(s)\\
&\le C_W(\pi)+mw+
\left(\frac{L_\pi^2}{8c}-\frac m{100}\right)s.
\end{aligned}
\tag{N12}
\]
Under (N3) the final coefficient is nonpositive for every \(c\ge1\). The maximum is therefore at most \(C_W(\pi)+mw\), and its value at zero is exactly that number by Wyner additivity. This proves (N4).

Proposition A.1 gives (N5). Put \(\Pi=\pi\otimes\kappa^{\otimes m}\).
At a rate above the right side of (N5), choose an order-\(-\infty\) code sequence for \(\Pi\). For all \(\alpha\in[1,\infty]\),
\[
D_\alpha(\Pi^{\otimes n}\Vert P_n)
\le D_\infty(\Pi^{\otimes n}\Vert P_n).
\]
The right side tends to zero independently of \(\alpha\), proving the code-uniform assertion. The rate equalities are asymptotic operational statements, not finite-block exact generation. ∎

### Corollary 13.4. The maximum possible saving

Fix \(c\ge1\). Among finite backgrounds \(\sigma\) satisfying
\(\Gamma_c(\sigma)=C_W(\sigma)\),
\[
\begin{aligned}
C_W(\pi)
&=\inf_\sigma\{\Gamma_c(\pi\otimes\sigma)-\Gamma_c(\sigma)\}\\
&=\min_{m\in\mathbb Z_{\ge0}}
\{\Gamma_c(\pi\otimes\kappa^{\otimes m})-m\Gamma_c(\kappa)\}.
\end{aligned}
\tag{N13}
\]
The second minimum is attained at a finite \(m\). Thus the entire separate-synthesis excess
\(\Gamma_c(\pi)-C_W(\pi)\) can be saved, and no background satisfying the stated condition can save more.

**Proof.** Wyner additivity and \(\Gamma_c\ge C_W\) give
\[
\Gamma_c(\pi\otimes\sigma)-\Gamma_c(\sigma)
\ge C_W(\pi)+C_W(\sigma)-\Gamma_c(\sigma)=C_W(\pi).
\]
Lemma 12.2 makes every tensor power of \(\kappa\) an admissible background. Theorem 13.1 attains the lower bound at a finite power. ∎

## 14. Background characterization and the sharp DSBS phase boundary

For a finite background \(\sigma\) and fixed \(c\ge1\), define
\[
w_\sigma=C_W(\sigma),\qquad
g_{\sigma,c}(s)=w_\sigma-a_{\sigma,c}(s).
\tag{N14}
\]
Say that \(\sigma\) has the finite-removal property at \(c\) if, for every finite target \(\pi\), some finite integer \(m\ge0\) satisfies
\[
\Gamma_c(\pi\otimes\sigma^{\otimes m})
=C_W(\pi)+mC_W(\sigma).
\tag{N15}
\]
This definition subtracts the background's Wyner cost. Subtracting
\(m\Gamma_c(\sigma)\) asks a different question when the background itself has a positive excess.

### Theorem 14.1. A necessary and sufficient profile condition

A finite background \(\sigma\) has the finite-removal property at \(c\) if and only if
\[
\boxed{\inf_{0\lt s\le1}\frac{g_{\sigma,c}(s)}s>0.}
\tag{N16}
\]
The equivalence is unchanged if the quantified targets are restricted to full-support finite laws.

For the same background to allow, for each target, a finite number of copies working simultaneously for every \(c\ge1\), it is necessary and sufficient that (N16) hold at \(c=1\).

**Proof.** If the positive infimum is \(d\), Lemma 13.3 gives
\[
a_{\pi,c}(s)+ma_{\sigma,c}(s)
\le C_W(\pi)+mw_\sigma+
\left(\frac{L_\pi^2}{8c}-md\right)s.
\]
Choose \(m\ge L_\pi^2/(8cd)\), and maximize, using equality of the baseline at zero. This proves sufficiency.

Conversely, taking \(\pi=\sigma\) and using identical-copy additivity shows
\(\Gamma_c(\sigma)=C_W(\sigma)\), hence \(g_{\sigma,c}\ge0\).
Take a nonuniform diagonal law \(\rho=\operatorname{diag}(p)\), with at least two positive masses. Lemma 12.3 gives
\(a_{\rho,c}(s)=H_{c/(c+s)}(p)\). The ratio
\[
b_p(s)=\frac{a_{\rho,c}(s)-H(p)}s
\]
extends continuously to zero, with
\[
b_p(0)=\frac{\operatorname{Var}_p(\log p)}{2c}>0.
\tag{N17}
\]
To verify this, expand \(\log\sum_i p_i^\alpha\) at \(\alpha=1\). Its first two derivatives are
\(\sum_i p_i\log p_i\) and \(\operatorname{Var}_p(\log p)\); substitute
\(\alpha=c/(c+s)=1-s/c+O(s^2)\).
Strict monotonicity of Rényi entropy gives \(b_p(s)>0\) for positive \(s\), so its compact minimum is a positive number \(b\).
If (N15) holds for \(\rho\), the product profile requires
\[
mg_{\sigma,c}(s)\ge a_{\rho,c}(s)-H(p)\ge bs.
\]
Thus \(m>0\) and the infimum in (N16) is at least \(b/m\).

For full-support targets only, first suppose
\(\Gamma_c(\sigma)>w_\sigma\), and choose \(s_*>0\) with
\(a_{\sigma,c}(s_*)>w_\sigma\).
A sufficiently small full-support perturbation \(\pi\) of a nonuniform diagonal law satisfies
\(a_{\pi,c}(s_*)>C_W(\pi)\), by Lemma 11.3. Its joint profile at \(s_*\) exceeds the proposed baseline for every \(m\ge0\). Therefore the full-support property still forces \(g_{\sigma,c}\ge0\).

If (N16) fails, choose \(s_j>0\) with
\(g_{\sigma,c}(s_j)/s_j\to0\) and take a convergent subsequence.
If its limit is positive, \(g_{\sigma,c}(s_*)=0\), and the preceding full-support perturbation of a diagonal law again defeats every finite \(m\).
If its limit is zero, choose a full-support source
\(\pi=\operatorname{DSBS}(r)\) with \(k(r)>c\). Such an \(r\) exists because
\(k(r)\to\infty\) as \(r\downarrow0\), by Theorem 7.4.
Lemma 14.2 below gives
\[
a_{\pi,c}(s)-C_W(\pi)
=J_r\left(\frac{k(r)}c-1\right)s+O(s^2),
\]
with positive linear coefficient. Along \(s_j\), this exceeds
\(mg_{\sigma,c}(s_j)\) for every fixed finite \(m\), once \(j\) is large. This proves necessity on full-support targets.

For the order-uniform assertion, necessity follows by setting \(c=1\).
Increasing \(c\) decreases each positive-slope profile and leaves the endpoint at zero unchanged. Hence the sufficiency argument at \(c=1\) works with the same \(m\) for every \(c\ge1\). ∎

### Lemma 14.2. The exact initial slope of a binary profile

For \(0\lt \epsilon\lt 1/2\), put
\[
J_\epsilon=
\frac{\epsilon^2[h'(a_\epsilon)]^2}{2(1-2\epsilon)}>0.
\tag{N18}
\]
For each fixed \(c\ge1\),
\[
a_{\pi_\epsilon,c}(s)
=C_W(\epsilon)
-J_\epsilon\left(1-\frac{k(\epsilon)}c\right)s+O(s^2),
\qquad s\downarrow0.
\tag{N19}
\]

**Proof.** The relaxed-Wyner parametrization implies
\[
\Phi_{\pi_r}(s)=
\min_{b(r)\le q\le1/2}
\{F_r(q)+s(1-r)(\log2-h(q))\}.
\tag{N20}
\]
Indeed, minimizing \(t+sC(r,t)\) is equivalent to minimizing the defining auxiliary objective for \(\Phi\); formula (10) gives (N20), with the saturation value represented by \(q=1/2\).

At \(s=0\), the unique minimum is \(q=b(r)\), where
\[
F_{r,q}(b(r))=0,\qquad
F_{r,qq}(b(r))=\frac{4(1-r)^2(1-2r)}{r^2}>0.
\]
Write \(B(r)=(1-r)h'(b(r))\).
In a closed neighborhood of \(\epsilon\), the implicit function theorem gives
\[
q(r,s)=b(r)+\frac{B(r)}{F_{r,qq}(b(r))}s+O(s^2).
\tag{N21}
\]
This is the global minimizing branch for sufficiently small positive \(s\), uniformly in the neighborhood: compact sets separated from \(b(r)\) retain a positive objective gap, and the second derivative is positive near \(b(r)\).
Taylor expansion gives
\[
\Phi_{\pi_r}(s)=sC_W(r)-J_r s^2+O(s^3),
\qquad
J_r=\frac{B(r)^2}{2F_{r,qq}(b(r))}
=\frac{r^2[h'(a_r)]^2}{2(1-2r)}.
\tag{N22}
\]
The needed remainders and \(r\)-derivatives are uniform locally.

Concavity in the test law and the binary symmetries used in Lemma 12.2 give
\[
A_{\pi_\epsilon,c}(s)=
\max_{0\le r\le1/2}\{\Phi_{\pi_r}(s)-cD(r\Vert\epsilon)\}.
\tag{N23}
\]
Every maximizer tends to \(\epsilon\) as \(s\downarrow0\), because
\(\Phi_{\pi_r}(s)\le s\log2\) and KL has its unique zero there.
Locally the second \(r\)-derivative of the objective is
\(-c/[r(1-r)]+O(s)\lt 0\). Its stationary branch is therefore the unique global maximizer for small \(s\), and
\[
r(s)=\epsilon+
\frac{\epsilon(1-\epsilon)C_W'(\epsilon)}c\,s+O(s^2).
\]
Substitution gives
\[
A_{\pi_\epsilon,c}(s)=sC_W(\epsilon)+
\left\{\frac{\epsilon(1-\epsilon)[C_W'(\epsilon)]^2}{2c}
-J_\epsilon\right\}s^2+O(s^3).
\]
Proposition 4.2 gives
\(k(\epsilon)=\epsilon(1-\epsilon)[C_W'(\epsilon)]^2/(2J_\epsilon)\).
Divide by \(s\). ∎

### Theorem 14.3. The sharp DSBS background classification

Fix \(0\lt \epsilon\lt 1/2\) and \(c\ge1\).
The background \(\sigma=\operatorname{DSBS}(\epsilon)\) has the finite-removal property exactly when
\[
\boxed{c>k(\epsilon).}
\tag{N24}
\]
At the critical line \(c=k(\epsilon)\ge1\), for every finite target,
\[
\Gamma_c(\pi\otimes\sigma^{\otimes m})-mC_W(\sigma)
\longrightarrow C_W(\pi),
\tag{N25}
\]
but some full-support binary targets fail to attain equality for every finite \(m\).

A DSBS background permits finite removal uniformly over all negative orders exactly when
\[
\epsilon>\epsilon_*,
\tag{N26}
\]
where \(\epsilon_*\) is defined in Theorem 7.4.
At \(\epsilon=\epsilon_*\), each fixed finite \(\beta>0\) permits finite removal, while order \(-\infty\) does not.

**Proof.** If \(c>k(\epsilon)\), Lemma 14.2 gives
\[
\lim_{s\downarrow0}
\frac{C_W(\epsilon)-a_{\pi_\epsilon,c}(s)}s
=J_\epsilon\left(1-\frac{k(\epsilon)}c\right)>0.
\tag{N27}
\]
We prove positivity of the numerator at every positive \(s\).

If \(c>1\) and \(k(\epsilon)\lt 1\), Theorem 6.3 gives
\(\max_rK_\epsilon(r)\le1\lt c\).
If \(k(\epsilon)\ge1\) and \(c>k(\epsilon)\), it gives
\(\max_rK_\epsilon(r)=k(\epsilon)\lt c\).
In the remaining case \(c=1>k(\epsilon)\), the curvature factorization (50) has \(S(v_0)>0\) and \(S(v)>S(v_0)\) for \(v>v_0\).
Thus \(D_v-\tau_v\) has zero value and derivative at \(v_0\), and strictly positive second derivative afterward. Double integration and the endpoint limit give
\(K_\epsilon(r)\lt 1\) for every \(0\le r\lt \epsilon\).
In all cases,
\[
C(r,cD(r\Vert\epsilon))\lt C_W(\epsilon),\qquad r\lt \epsilon.
\tag{N28}
\]
For \(r>\epsilon\), use \(C(r,t)\le C_W(r)\lt C_W(\epsilon)\).

For \(r\ne\epsilon\), an optimal auxiliary for this constrained common information gives
\[
\Phi_{\pi_r}(s)-cD(r\Vert\epsilon)
\le sC(r,cD(r\Vert\epsilon))\lt sC_W(\epsilon).
\]
At \(r=\epsilon\), the perturbation in (125) gives
\(\Phi_{\pi_\epsilon}(s)\lt sC_W(\epsilon)\) for each fixed \(s>0\).
The compact scalar maximum in (N23) is therefore strictly below
\(sC_W(\epsilon)\). Combine this with (N27) and compactness to obtain (N16).

If \(c\lt k(\epsilon)\), Theorem 7.1 gives
\(\Gamma_c(\sigma)>C_W(\sigma)\); choosing \(\pi=\sigma\) and using identical-copy additivity rules out (N15).
If \(c=k(\epsilon)\ge1\), Lemma 14.2 makes the ratio in (N16) tend to zero. A full-support DSBS target with \(k(r)>c\) has positive linear excess and therefore defeats every finite background count.

For (N25), the critical background has zero as its unique maximizing slope.
When \(k(\epsilon)>1\), Theorem 6.3 gives
\(K_\epsilon(r)\lt k(\epsilon)\) for \(r\lt \epsilon\).
When \(k(\epsilon)=1\), (50) has \(S(v_0)=0\) and
\(S(v)>0\) for \(v>v_0\); the same double integration still gives
\(K_\epsilon(r)\lt 1\) for \(r\lt \epsilon\), including \(r=0\).
The preceding fixed-slope compactness argument then proves
\(g_{\sigma,c}(s)>0\) for every \(s>0\).

Write \(f(s)=a_{\pi,c}(s)-C_W(\pi)\).
The excess over the right baseline in (N25) is
\[
\max_{0\le s\le1}\{f(s)-mg_{\sigma,c}(s)\}\ge0.
\tag{N29}
\]
Maximizing slopes tend to zero, since \(f\) is bounded and \(g_{\sigma,c}\) has a positive minimum on each compact interval separated from zero.
Continuity of \(f\) at zero makes (N29) tend to zero.

Finally, Theorem 7.4 gives \(k(\epsilon)\lt 1\), \(=1\), or \(>1\) according as
\(\epsilon>\epsilon_*\), \(=\epsilon_*\), or \(\lt \epsilon_*\).
Combine this with (N24). The independent endpoint \(\epsilon=1/2\) is outside the theorem's domain; its zero background profile does not satisfy (N16). ∎

## 15. An elementary potential and exact finite certificates

At \(c=1\), the entire DSBS tilted potential admits an elementary formula, eliminating its nested scalar optimizations.

### Theorem 15.1. Closed form of the order-\(-\infty\) binary potential

For \(0\lt \epsilon\lt 1/2\), let \(t=\log((1-\epsilon)/\epsilon)\).
For every \(0\le s\le1\),
\[
\boxed{
A_{\pi_\epsilon,1}(s)=\log(2\epsilon)+
2\log\cosh\!\left[
\frac{1+s}{2}\operatorname{arcosh}(e^{t/(1+s)})
\right].
}
\tag{N30}
\]
In particular,
\[
A_{\pi_\epsilon,1}(0)=0,\qquad
A_{\pi_\epsilon,1}(1)=\log(2(1-\epsilon)).
\tag{N31}
\]

**Proof.** For \(0\lt s\lt 1\), set
\[
\alpha=(1+s)/2,\quad x=\operatorname{arcosh}(e^{t/(1+s)}),
\quad u=\tanh x,\quad v=\frac{\tanh(\alpha x)}{\tanh x}.
\tag{N32}
\]
Strict concavity of \(\tanh\) gives \(v>\alpha>1/2\), and monotonicity gives \(v\lt 1\).
Put \(r=1-v\) and \(q=(1-u)/2\). Then \(0\lt r\lt 1/2\) and \(b(r)\lt q\lt 1/2\), because
\[
v>\frac{\tanh(x/2)}{\tanh x}
=\frac1{1+\sqrt{1-u^2}},
\]
which is equivalent to \(q>b(r)\).

The inner derivative in (N20) vanishes exactly when
\[
2\operatorname{atanh}(vu)=(1+s)\operatorname{atanh}u.
\tag{N33}
\]
Our parameters satisfy this identity, and give the unique global minimum.
For fixed \(0\lt v\lt 1\), the ratio
\(\operatorname{atanh}(vu)/\operatorname{atanh}u\)
strictly decreases in \(u\in(0,1)\).
To check this, expand both functions and cancel the common factor \(u\).
The coefficient ratios \(v^{2j+1}\) strictly decrease with \(j\); pairing the two indices in the derivative of the ratio leaves strictly negative terms. Absolute convergence on compact subintervals justifies the differentiation.
At \(q=b(r)\), twice the ratio is one; as \(q\uparrow1/2\), it tends to \(2v>1+s\).
Thus the objective derivative changes from negative to positive exactly at (N33).

After subtracting the binary KL term, the inner expression is
\[
\begin{aligned}
F(r,q)={}&2h((1-r)q+r/2)-(1+s)(1-r)h(q)\\
&+[s(1-r)-r]\log2
+(1-r)\log(1-\epsilon)+r\log\epsilon.
\end{aligned}
\tag{N34}
\]
At the unique inner minimizer, envelope differentiation in \(v=1-r\) gives
\[
F_v=-2u\operatorname{atanh}(vu)
+(1+s)\{\log2-h(q)\}+t.
\]
Use (N33) and
\(\log2-h((1-u)/2)=u\operatorname{atanh}u+\tfrac12\log(1-u^2)\)
to obtain
\(F_v=(1+s)\log(1-u^2)/2+t=0\).
By Lemma 11.1, the outer objective in \(r\) is concave. Its interior stationary point is therefore a global maximum.

Substitution of the two stationary identities into (N34) cancels the remaining \(v\)-terms and leaves
\[
F(r,q)=\log(2\epsilon)-\log(1-v^2u^2)
=\log(2\epsilon)+2\log\cosh(\alpha x).
\]
This proves (N30). At zero, the half-angle identity makes the expression zero.
At one it equals \(\log(2(1-\epsilon))\); alternatively maximize the decreasing affine function
\(I_{\pi_r}(X;Y)-D(r\Vert\epsilon)\) at \(r=0\).
Continuity includes both endpoints. ∎

### Proposition 15.2. A certified margin for the fixed background

For \(\kappa=\operatorname{DSBS}(1/4)\),
\[
A_{\kappa,1}''(s)\le-\frac1{50},\qquad 0\le s\le1.
\tag{N35}
\]
Consequently,
\[
A_{\kappa,1}(s)\le sw-\frac{s^2}{100},\qquad
a_{\kappa,1}(s)\le w-\frac{s}{100}.
\tag{N36}
\]

**Proof.** Formula (N30) is analytic on a neighborhood of \([0,1]\).
The accompanying exact rational interval certificate partitions \([0,1]\) into 2,048 closed cells, encloses the second derivative on each entire cell, and verifies an upper endpoint at most \(-1/50\) in every case.
The cells cover the full interval including its endpoints. This is a whole-domain derivative enclosure, not a sampled plot.

Lemma 14.2 gives \(A_{\kappa,1}(0)=0\) and \(A_{\kappa,1}'(0)=w\).
Twice integrating (N35) gives (N36), with the zero endpoint supplied by continuity. ∎

The bound in Theorem 13.1 is conservative. Exact finite background counts can be certified without this general estimate.

### Proposition 15.3. Curvature certificates for finite counts

Suppose \(A_{\pi,1}\) and \(A_{\sigma,1}\) are twice continuously differentiable on \([0,1]\), and set
\(S_m=A_{\pi,1}+mA_{\sigma,1}\).
If
\[
S_m''(s)\le0\qquad(0\le s\le1),
\tag{N37}
\]
then
\[
\Gamma_c(\pi\otimes\sigma^{\otimes m})
=C_W(\pi)+mC_W(\sigma)\qquad(c\ge1).
\tag{N38}
\]
If \(S_m''(0)>0\), equality fails at \(c=1\).

**Proof.** We have \(S_m(0)=0\) and
\(S_m'(0)=C_W(\pi)+mC_W(\sigma)\).
Under (N37), concavity places \(S_m\) below its tangent at zero.
Divide by \(s\), use product additivity, and maximize to prove (N38) at \(c=1\).
Increasing \(c\) decreases the profile without changing the zero endpoint, proving it for all \(c\ge1\).
If \(S_m''(0)>0\), then
\(S_m(s)/s=S_m'(0)+S_m''(0)s/2+o(s)\)
exceeds the baseline at all sufficiently small positive slopes. ∎

For a diagonal target \(\rho=\operatorname{diag}(p)\), Lemma 12.3 gives
\[
A_{\rho,1}''(s)=
\frac{\operatorname{Var}_{q_s}(\log p)}{(1+s)^3},
\qquad
q_s(i)=\frac{p_i^{1/(1+s)}}{\sum_jp_j^{1/(1+s)}}.
\tag{N39}
\]
Thus Proposition 15.3 applies directly to a diagonal target and a full-support background, using the all-support operational result without perturbing the target.

### Theorem 15.4. Two sharp order-uniform background counts

Let
\[
\pi_{\rm b}=\operatorname{DSBS}(1/100),\qquad
\rho=\operatorname{diag}(3/4,1/4),\qquad
\kappa=\operatorname{DSBS}(1/4).
\tag{N39a}
\]
For every \(c\ge1\),
\[
\Gamma_c(\pi_{\rm b}\otimes\kappa)
=C_W(\pi_{\rm b})+C_W(\kappa),
\tag{N39b}
\]
and
\[
\Gamma_c(\rho\otimes\kappa^{\otimes10})
=H(3/4,1/4)+10C_W(\kappa).
\tag{N39c}
\]
The least number of copies of this fixed background that works simultaneously for every \(c\ge1\) is exactly one for \(\pi_{\rm b}\), and exactly ten for \(\rho\). These are sharp uniform counts; they are not asserted to be the minimum count separately at every finite negative order.

The first example is entirely full support. Its standalone order-\(-\infty\) excess satisfies
\[
\Gamma_1(\pi_{\rm b})-C_W(\pi_{\rm b})>\frac1{10000}
\quad\text{nats}.
\tag{N39d}
\]
Thus one independent background copy removes a strictly positive, quantitatively certified excess.

**Proof.** The [exact interval certificate](results/finite_examples_and_critical.json), reproduced by the [rational verifier](code/certify_background_curvature.py), proves the following bounds:

| Quantity | Certified bound | Domain |
|---|---|---|
| \(A_{\pi_{\rm b},1}''+A_{\kappa,1}''\) | \(\le-1/50\) | Every \(s\in[0,1]\) |
| \(A_{\rho,1}''+10A_{\kappa,1}''\) | \(\le-9/1000\) | Every \(s\in[0,1]\) |
| \(A_{\rho,1}''(0)+9A_{\kappa,1}''(0)\) | \(>1/100\) | \(s=0\) |
| \(a_{\pi_{\rm b},1}(1/10)-C_W(\pi_{\rm b})\) | \(>1/10000\) | \(s=1/10\) |

The first two bounds use 8,192 closed cells covering \([0,1]\). The verifier substitutes (N30) and (N39) into the derivative expressions and encloses each entire cell. All endpoints are outward-rounded integer multiples of \(2^{-160}\). Exponentials are bounded by their series through degree 100 with a geometric tail bound; logarithms use 256 odd terms of the inverse-hyperbolic-tangent series with its tail bound, after range reduction; square roots use integer square roots. The last two bounds are exact interval evaluations at the displayed points. The rational endpoints in the certificate imply the simpler rational inequalities in the table by integer comparisons. No floating-point comparison enters acceptance.

Proposition 15.3 applied to the first two rows proves (N39b) and (N39c), first at \(c=1\), and then at all \(c\ge1\) by monotonicity of the tilted profile. For the binary target, the fourth row and
\(\Gamma_1(\pi_{\rm b})\ge a_{\pi_{\rm b},1}(1/10)\)
prove (N39d). Hence zero copies fail at \(c=1\), whereas one copy works for every order. This proves the sharp uniform count one.

For the diagonal target, the third row gives positive initial curvature at nine copies. Moreover, Proposition 15.2 gives \(A_{\kappa,1}''(0)\lt 0\). Therefore, for every integer \(0\le m\le9\),
\[
A_{\rho,1}''(0)+mA_{\kappa,1}''(0)
\ge A_{\rho,1}''(0)+9A_{\kappa,1}''(0)>\frac1{100}.
\tag{N39e}
\]
Proposition 15.3 makes every such count fail at \(c=1\). Ten copies work for all \(c\), proving that ten is the least uniform count. Since (N39c) uses the diagonal law itself, the operational consequence uses the all-support statement of Proposition A.1 rather than a full-support perturbation. ∎


## 16. Critical finite-background asymptotics

At the order-\(-\infty\) critical binary background, finite removal fails for some targets, but the approach to the Wyner baseline has an exact inverse-copy asymptotic.

Let
\[
\sigma_*=\operatorname{DSBS}(\epsilon_*),\quad
w_*=C_W(\sigma_*),\quad A_*(s)=A_{\sigma_*,1}(s),\quad
B_*=-A_*'''(0)/6.
\tag{N40}
\]

### Lemma 16.1. A positive quadratic deficit at criticality

The constant \(B_*\) is strictly positive, and
\[
w_*-a_{\sigma_*,1}(s)=B_*s^2+O(s^3),\qquad s\downarrow0.
\tag{N41}
\]

**Proof.** Formula (N30) is analytic near zero. By Lemma 14.2 and
\(k(\epsilon_*)=1\),
\[
A_*(0)=0,\quad A_*'(0)=w_*,\quad A_*''(0)=0.
\]
It remains to show \(A_*'''(0)\lt 0\).

Put \(t=t_*=\log((1-\epsilon_*)/\epsilon_*)\),
\(x=\operatorname{arcosh}(e^t)\), \(z=\tanh x\), and \(y=x/2\).
For
\[
Y(s)=\frac{1+s}{2}\operatorname{arcosh}(e^{t/(1+s)}),
\]
its first three derivatives at zero are
\[
\begin{aligned}
y_1&=(x-t/z)/2,\\
y_2&=-t^2(1-z^2)/(2z^3),\\
y_3&=\frac{t^2(1-z^2)}{2z^3}
\left(3+t-\frac{3t}{z^2}\right).
\end{aligned}
\tag{N42}
\]
These identities follow by implicit differentiation of
\(\log\cosh(\operatorname{arcosh}(e^{t/(1+s)}))=t/(1+s)\).
The function \(x\tanh x-\log\cosh x\) has value zero at zero and derivative
\(x\operatorname{sech}^2x>0\); hence \(y_1>0\).
Clearly \(y_2\lt 0\).
Lemma 7.3 gives \(t_*>2\), and \(z\lt 1\), so
\[
3+t-3t/z^2\lt 3-2t\lt -1.
\]
Thus \(y_3\lt 0\).

Three differentiations of \(A_*=\log(2\epsilon_*)+2\log\cosh Y\) give
\[
\frac12A_*'''(0)
=-2\operatorname{sech}^2y\,\tanh y\,y_1^3
+3\operatorname{sech}^2y\,y_1y_2+\tanh y\,y_3.
\tag{N43}
\]
All three terms are strictly negative. Taylor expansion and division by \(s\) prove (N41). ∎

### Theorem 16.2. The sharp inverse-copy law

Suppose a finite target satisfies
\[
a_{\pi,1}(s)=C_W(\pi)+\eta s+O(s^2),\qquad \eta>0.
\tag{N44}
\]
Then
\[
\boxed{
\Gamma_1(\pi\otimes\sigma_*^{\otimes m})
-C_W(\pi)-mC_W(\sigma_*)
=\frac{\eta^2}{4B_*m}+o(m^{-1}).
}
\tag{N45}
\]
Every choice \(s_m\) of maximizing slope obeys
\[
ms_m\longrightarrow\frac{\eta}{2B_*}.
\tag{N46}
\]
The excess is strictly positive for every finite \(m\).

For a full-support target \(\operatorname{DSBS}(r)\) with
\(0\lt r\lt \epsilon_*\), condition (N44) holds with
\[
\eta=J_r(k(r)-1)>0.
\tag{N47}
\]
For a nonuniform diagonal target it holds with
\[
\eta=\tfrac12\operatorname{Var}_p(\log p).
\tag{N48}
\]

**Proof.** Write
\(f(s)=a_{\pi,1}(s)-C_W(\pi)\) and
\(g(s)=w_*-a_{\sigma_*,1}(s)\).
Theorem 14.3 gives \(g(s)>0\) at every positive \(s\), while \(g(0)=0\).
The excess is
\[
\Delta_m=\max_{0\le s\le1}\{f(s)-mg(s)\}.
\tag{N49}
\]
As in (N29), maximizing slopes tend to zero.
Locally \(f(s)\le2\eta s\) and \(g(s)\ge B_*s^2/2\).
Because the value at zero is zero, every maximizer has nonnegative objective, and thus, for sufficiently large \(m\),
\[
0\le s_m\le\frac{4\eta}{B_*m}.
\tag{N50}
\]
For every fixed finite \(m\), the expansions
\(f(s)=\eta s+O(s^2)\) and \(g(s)=B_*s^2+O(s^3)\)
make the objective strictly positive at sufficiently small positive \(s\).

Put \(u=ms\). Uniformly on the bounded interval furnished by (N50),
\[
m\{f(u/m)-mg(u/m)\}
=\eta u-B_*u^2+o(1).
\tag{N51}
\]
The limiting quadratic has unique maximum \(\eta^2/(4B_*)\) at
\(u=\eta/(2B_*)\).
Uniform convergence and compactness prove (N45) and (N46).
Equations (N47) and (N48) follow from Lemma 14.2 and (N17), respectively.
Proposition A.1 supplies the operational interpretation. ∎

The finite plateau in Theorem 13.1 and the inverse-copy law above describe different sides of the same sharp boundary. The gain comes from heterogeneous joint synthesis. The background's own cost remains additive, consistently with the identical-source identity in Section 11.

## 17. Scope, dependencies, and limitations

All results concern finite alphabets, a uniform shared seed, no communication, and arbitrary local block kernels. The DSBS phase and background classifications use \(0\lt \epsilon\lt 1/2\); the independent endpoint \(\epsilon=1/2\) has no useful deficit and is excluded. The general finite-removal theorem includes targets with zero masses. Its sufficient count depends on the target support and smallest positive mass, and is not claimed optimal or uniform over all finite targets.

Background multiplicity is finite and fixed before the coding block length tends to infinity. Rate equalities do not assert exact generation at finite block length. The background is part of the paid joint output; the target's standalone rate is unchanged. One max-divergence code controls all negative orders. Exponential decay holds at fixed positive rate slack; diagonalization at the exact asymptotic rate does not preserve a uniform positive exponent.

Theorem 16.2 concerns the infinite-order critical binary background and targets with a positive linear excess expansion. The general critical-line result in Theorem 14.3 asserts convergence without prescribing its rate. When a background itself has positive excess, subtracting its Wyner rate differs from subtracting its actual standalone rate; no conclusion conflating these residuals is made.

The finite-block construction is an existence argument, not an efficient codebook search algorithm. Its finite-order remainder contains a term proportional to \(1/\beta\); the order-uniform guarantee instead uses max-divergence achievability. The tilted potential need not be concave in its parameter, and separate maximizing parameters cannot replace the common parameter in the product identity.

The operational matching, phase theory, finite-block theorem, and qualitative composition results remain attributed to [P,P2] and the identified public inputs. The hyperbolic Wilker inequality is established [7]. The neighboring entropy profile of Ky and Tran [8, Lemma 4.1] is a different function in a different coordinate and is not a proof input. No completed proof-assistant formalization or external peer review is claimed. Computationally used inequalities have integer rational certificates; other numerical displays are illustrative.

## Appendix A. Support faces and one code for all negative orders

### Proposition A.1. Operational equality on every finite support

For every finite target law \(q\), including laws with zero masses, and every fixed \(\beta\in(0,\infty]\),
\[
\widetilde T_{-\beta}(q)=T_{-\beta}(q)=\Gamma_{c_\beta}(q).
\tag{A1}
\]
The converse is Corollary 11.5. Yu [1, Theorem 1(3)] states its achievable upper bound for any finite target law, not only for full product support. Applying that input gives the opposite inequality for the unnormalized criterion. Thus the support extension in (A1) combines the existing support-face converse and an already established upper bound; it is not a new contribution of the present manuscript. Sections 2--9 deliberately stated their inherited operational theorem under the narrower full-support hypothesis.

For clarity about the infinite-order endpoint and the single-code assertion of Theorem 13.1, we give a direct expansion of the established achievability construction. No expression below evaluates a logarithm at a zero target mass.

### A.1. Direct max-divergence construction

Let \(q\) be any probability law on finite \(X \times Y\), with arbitrary zeros. Put \(Z=(X,Y)\), \(k=|X||Y|\), and

\[
\lambda_Q(r)=\min_{W:I_Q(Z;W)\le r}I_Q(X;Y\mid W),\qquad
\Gamma=\sup_{Q\ll q} C(Q,D(Q\Vert q)).
\]

All logarithms below are natural. Use the pointwise construction proved in Section 10, with constant \(C=C_{|X|,|Y|}\). Then for every \(R>\Gamma\) there exist uniform-seed synthesis codes, with arbitrary local whole-block kernels and no communication, satisfying

\[
N_n\le\lfloor e^{nR}\rfloor,
\qquad
D_\infty(q^{\otimes n}\Vert P_n)\le8e^{-n\gamma}
\]

for all sufficiently large \(n\), for an explicit strictly positive \(\gamma\) specified below. The **same** codes satisfy this bound with \(D_{1+\beta}\) in place of \(D_\infty\) for every \(\beta\in(0,\infty]\), by monotonicity of positive-order Rényi divergence. The two-layer achievability method and the all-finite-source upper bound are due to Yu [1, Theorem 1 and Section IV-C]. The direct max-divergence proof below spells out support conventions and the common-code quantifier; it is not counted as a new achievability theorem.

### A.2. Constants and the trivial case

If \(q\) is a product law, its independent local block kernels reproduce it exactly using one seed label. Suppose henceforth that it is not a product law. Then \(k\ge2\) and an optimal finite Wyner auxiliary exists:

\[
p(w,z)=p_W(w)p_{X|W}(x|w)p_{Y|W}(y|w),\quad
p_Z=q,\quad I_p(W;Z)=C_W(q)=I>0.
\]

For every pair with \(p(w,z)>0\), define

\[
\ell(w,z)=\log\frac{p_{Z|W}(z|w)}{q(z)}
          =\log\frac{p_{W|Z}(w|z)}{p_W(w)},
\qquad B=\max_{p(w,z)>0}|\ell(w,z)|.
\]

This is a finite positive number. If it were zero, \(W\) and \(Z\) would be independent and the conditional-product representation would imply that \(q\) itself is a product law. No log at a zero-probability pair is evaluated.

Write \(h=R-\Gamma>0\), \(L=\log k\), and set

\[
\tau=\min\{1,h/(16B)\},\qquad
\theta=\min\{1/2,h/(2L)\},
\]

\[
\eta=\min\{h/4,\theta\tau^2/2\},\qquad
b_0=h^2/(128B^2),\quad b_1=h/8,\quad
\gamma=\min\{\eta,b_0,b_1\}>0.
\]

The numerical constants are convenient sufficient constants and are not claimed sharp. All depend only on the fixed target, chosen finite Wyner representation, and rate slack.

### A.3. The rate-slack bound on every supported test law

By the definition of \(\Gamma\) and compact attainment, for each \(Q\ll q\) there is an auxiliary \(U\) with

\[
I_Q(Z;U)\le\Gamma,\qquad I_Q(X;Y\mid U)\le D(Q\Vert q).
\]

Mix this auxiliary with \(Z\) using an independent Bernoulli flag of probability \(\theta\), including the flag in the new auxiliary. The information cost is at most

\[
(1-\theta)\Gamma+\theta H(Q)\le\Gamma+\theta L
\le\Gamma+h/2\le R-\eta.
\]

Its conditional mutual information is at most \((1-\theta)D(Q\Vert q)\). Hence

\[
\lambda_Q(R-\eta)-D(Q\Vert q)\le-\theta D(Q\Vert q).
\tag{A2}
\]

For \(\operatorname{TV}(Q,q)>\tau\), Pinsker gives

\[
\lambda_Q(R-\eta)-D(Q\Vert q)\le-2\theta\tau^2.
\tag{A3}
\]

This is the support-face version of the existing time-sharing argument in Yu's Section IV-C, Claim 1. If \(\tau=1\), the atypical set is empty; the same following bounds remain harmless.

### A.4. Near-source pointwise lower approximation

For a positive-target sequence \(z^n\) with empirical law \(Q\) satisfying \(\operatorname{TV}(Q,q)\le\tau\), independently draw the typical-code labels \(W^n(m)\sim p_W^{\otimes n}\) and consider the truncated likelihood ratio

\[
V_m(z^n)=\frac{p_{Z|W}^{\otimes n}(z^n\mid W^n(m))}
                    {q^{\otimes n}(z^n)}
\mathbf 1\!\left\{\sum_{i=1}^n\ell(W_i(m),z_i)
                   \le n(I+h/4)\right\}.
\]

The indicator is a device in the analysis; the implemented local kernels remain the untruncated product channels. Terms with zero conditional likelihood contribute zero. The expectation of \(V_m\) equals the posterior probability of the displayed truncation event under the product posterior \(p_{W^n|Z^n=z^n}\).

Let \(a_z=\mathbb E[\ell(W,z)\mid Z=z]=D(p_{W|z}\Vert p_W)\), so \(0\le a_z\le B\) and \(\sum_z q(z)a_z=I\). Under the posterior, the summands are independent and lie in \([-B,B]\). Their average conditional mean is bounded by

\[
\sum_zQ(z)a_z\le I+2B\tau\le I+h/8.
\]

Hoeffding's inequality therefore gives

\[
\mu(z^n):=\mathbb E[V_m(z^n)]\ge1-e^{-nb_0}.
\tag{A4}
\]

Moreover \(0\le V_m\le K_n:=\exp(n(I+h/4))\). Put \(\epsilon_n=e^{-nb_1}\). For a typical-code size \(N_{t,n}\ge(1/2)e^{nR}\) and sufficiently large \(n\), the bounded-variable multiplicative Chernoff inequality gives

\[
\Pr\!\left\{\frac1{N_{t,n}}\sum_mV_m
                   \lt (1-\epsilon_n)\mu\right\}
\le\exp\!\left(-\frac{\epsilon_n^2\mu N_{t,n}}{2K_n}\right)
\le\exp\!\left(-\frac18 e^{nh/2}\right).
\tag{A5}
\]

The last step uses \(I=C_W(q)\le\Gamma\). There are at most \(k^n\) supported sequences, so a union bound is below one for all sufficiently large \(n\). Fix a code satisfying every near-source requirement. Its actual untruncated local-kernel output \(P_{t,n}\) then obeys

\[
P_{t,n}(z^n)\ge(1-e^{-nb_0})(1-e^{-nb_1})q^{\otimes n}(z^n)
\ge(1-2e^{-nb})q^{\otimes n}(z^n),\quad
b=\min\{b_0,b_1\},
\tag{A6}
\]

on all those supported sequences. The construction only needs the posterior at \(q(z)>0\); full product support is never used.

### A.5. Backup labels and the exact budget

Use the Section 10 universal code at rate \(R_b=R-\eta\). For sufficiently large \(n\) its actual label count satisfies

\[
\frac12e^{nR_b}\le N_{b,n}\le\lfloor e^{nR_b}\rfloor
\]

and its output satisfies

\[
P_{b,n}(z^n)\ge(n+1)^{-C}
\exp\{-n[H(Q)+\lambda_Q(R_b)]\}
\tag{A7}
\]

for every sequence of type \(Q\). The lower bound on the count follows directly from the large-rate branch of that construction (\(N=LM\), \(M=\lfloor e^{nR_b}/L\rfloor\)); since \(R_b>\Gamma\ge0\), this branch eventually applies.

Choose

\[
N_{t,n}=\lfloor e^{nR}\rfloor-\lfloor e^{nR_b}\rfloor.
\]

It is at least \((1/2)e^{nR}\) for all sufficiently large \(n\). Concatenate the two label sets and select uniformly from their union. This implements

\[
P_n=(1-\nu_n)P_{t,n}+\nu_nP_{b,n},
\quad
\nu_n=\frac{N_{b,n}}{N_{t,n}+N_{b,n}},
\]

with at most \(\lfloor e^{nR}\rfloor\) labels and, eventually,

\[
\tfrac12 e^{-n\eta}\le\nu_n\le2e^{-n\eta}.
\tag{A8}
\]

No nonuniform seed or separately shared mixture coin has been introduced: the mixture is exactly the proportion of two integer label sets.

### A.6. Direct max-divergence estimate

On a supported atypical sequence of joint type \(Q\), (A3), (A7), and (A8) imply

\[
\frac{q^{\otimes n}(z^n)}{P_n(z^n)}
\le2(n+1)^C\exp\{n[\eta+\lambda_Q(R_b)-D(Q\Vert q)]\}
\le2(n+1)^C e^{-n(2\theta\tau^2-\eta)}\le1
\tag{A9}
\]

for sufficiently large \(n\), because \(\eta\le\theta\tau^2/2\). On a supported near-source sequence, (A6) and the upper bound in (A8) give

\[
\frac{q^{\otimes n}(z^n)}{P_n(z^n)}
\le\frac1{(1-2e^{-n\eta})(1-2e^{-nb})}.
\]

Taking the maximum only over positive target masses and using \(-\log(1-u)\le2u\) for \(0\le u\le1/2\) yields

\[
D_\infty(q^{\otimes n}\Vert P_n)
\le4e^{-n\eta}+4e^{-nb}\le8e^{-n\gamma}.
\tag{A10}
\]

This proves the endpoint directly; it does not exchange Rényi order with block length. Sequences outside the source support are irrelevant to the numerator of reverse divergence, but the code output remains a normalized law on the full product space.

### A.7. Consequence at the exact asymptotic critical rate

When Theorem 13.1 establishes \(\Gamma_1(q)=C_W(q)\), the preceding result gives one code sequence for every fixed rate \(R>C_W(q)\), with exponentially vanishing \(D_\infty\). To obtain a single code sequence whose limsup rate is exactly \(C_W(q)\), choose \(R_j=C_W(q)+1/j\). For each \(j\), choose a large threshold \(n_j\) such that its endpoint code has \(D_\infty\le1/j\) for all \(n\ge n_j\), and make the thresholds strictly increasing. For \(n_j\le n\lt n_{j+1}\), use the \(R_j\) code. Then

\[
\limsup_n\frac{\log N_n}{n}\le C_W(q),\qquad
D_\infty(q^{\otimes n}\Vert P_n)\longrightarrow0.
\]

The common-information converse gives the matching lower bound on the achievable rate. Every finite negative order is simultaneously controlled because

\[
0\le D_{1+\beta}(q^{\otimes n}\Vert P_n)
\le D_\infty(q^{\otimes n}\Vert P_n).
\]

This even controls any block-length-dependent sequence of positive orders \(1+\beta_n\), since the inequality is pointwise in the order. The diagonalized critical-rate code need not retain a fixed positive exponential decay exponent; the exponential assertion is for any fixed positive rate slack.


## Appendix B. Rational interval proof and reproduction

The program [certify_background_curvature.py](code/certify_background_curvature.py) implements the Section 15 derivative bounds using only the Python standard library. It verifies whole-domain interval enclosures. Floating-point arithmetic does not enter an acceptance test.

### B.1. Derivative to be enclosed

For \(u=1+s\), \(t=\log((1-\epsilon)/\epsilon)\), \(v=t/u\), \(z=\operatorname{arcosh}(e^v)\), and \(y=uz/2\), differentiating (N30) gives
\[
A_{\pi_\epsilon,1}''(s)
=\frac{1-\tanh^2y}{2}(z-v\coth z)^2
-\frac{v^2}{u}\tanh y\,\coth z\,\operatorname{csch}^2z.
\tag{B1}
\]
Every denominator is positive on the evaluated parameter intervals. The diagonal derivative is (N39). Point and critical-boundary evaluations use (N30), (N42), and (N43). These identities isolate the symbolic step from the finite arithmetic check.

### B.2. Outward arithmetic and tails

Interval endpoints are integer multiples of \(2^{-160}\). Addition and negation are exact; multiplication, division, and square root round outward using integer division and integer square roots. Reciprocal intervals containing zero and negative square-root arguments cause failure. Every arithmetic operation therefore encloses the exact operation over its entire input interval.

For nonnegative arguments, the exponential is expanded through degree 100. If \(T_{101}=x^{101}/101!\) and \(q=x/102\lt 1\), the omitted nonnegative tail is at most \(T_{101}/(1-q)\). The code checks the upper endpoint of \(q\) before applying this bound. Negative exponentials use reciprocals. For \(x\ge1\), set \(r=(x-1)/(x+1)\). The logarithm uses
\[
\log x=2\sum_{j=0}^{255}\frac{r^{2j+1}}{2j+1}+\mathcal R,
\qquad 0\le\mathcal R\le\frac{2r^{513}}{513(1-r^2)}.
\tag{B2}
\]
Large arguments are reduced by powers of two; \(\log2\) is bounded by the same series. Arguments below one use a reciprocal; intervals crossing one use monotonicity and endpoint enclosures. Hyperbolic functions and inverse hyperbolic cosine are expressed with these operations. Positivity of the series terms and outward arithmetic preserve every tail bound over each full interval.

### B.3. Covered domains and reproduction

For (N35), the 2,048 closed intervals \([j/2048,(j+1)/2048]\) cover \([0,1]\). For the finite-count examples, 8,192 corresponding intervals cover the same domain. The program substitutes complete intervals into (B1) and (N39), retaining dependency overestimation. Acceptance compares the largest upper endpoint with the rational threshold. Separate endpoint calculations prove the strict lower witnesses. The [background certificate](results/background_curvature.json) and [finite-count certificate](results/finite_examples_and_critical.json) retain exact rational endpoints and decisions.

Run from the directory containing the \(manuscript\), \(code\), and \(results\) subdirectories:

```sh
python code/certify_background_curvature.py \
  --cells 2048 --output results/background_curvature.json
python code/certify_background_curvature.py \
  --cells 8192 --extensions \
  --output results/finite_examples_and_critical.json
```

The second command also encloses
\[
0.0551046517029798\lt \epsilon_*\lt 0.0551046517029799
\]
and the coefficient \(B_*\), whose positivity has the independent analytic proof in Lemma 16.1. The inherited Section 9 calculations are supplied as [certify_thresholds.py](code/certify_thresholds.py) and [threshold_certificates.json](results/threshold_certificates.json). These certificates supplement the written proof; they are not proof-assistant kernel verification.

## References

[1] Lei Yu. *Rényi Common Information for Doubly Symmetric Binary Sources*. arXiv:2407.06132v1, 8 July 2024. [Versioned full text](https://arxiv.org/html/2407.06132v1). Theorem 1(3), Sections IV-B–IV-C, and Propositions 1–2 are the explicit public inputs.

[2] Erixhen Sula and Michael Gastpar. *Common Information Components Analysis*. Entropy **23**(2), 151 (2021). DOI: [10.3390/e23020151](https://doi.org/10.3390/e23020151). Lemma 1 records continuity, cardinality, and tensorization properties of relaxed common information.

[3] Lei Yu and Vincent Y. F. Tan. *Corrections to “Wyner's Common Information Under Rényi Divergence Measures”*. IEEE Transactions on Information Theory **66**(4), 2599–2608 (2020). DOI: [10.1109/TIT.2020.2970404](https://doi.org/10.1109/TIT.2020.2970404).

[4] Lei Yu and Vincent Y. F. Tan. *On Exact and \(\infty\)-Rényi Common Informations*. IEEE Transactions on Information Theory **66**(6), 3366–3406 (2020). DOI: [10.1109/TIT.2020.2970396](https://doi.org/10.1109/TIT.2020.2970396).

[5] Lei Yu. *Rényi Resolvability, Noise Stability, and Anti-contractivity*. IEEE Transactions on Information Theory **71**(8), 5836–5867 (2025). DOI: [10.1109/TIT.2025.3578324](https://doi.org/10.1109/TIT.2025.3578324). Version examined: [arXiv:2402.07660v5](https://arxiv.org/html/2402.07660v5), revised 7 June 2025. The fixed-channel reverse-resolvability theorem is a methodological neighbor; it is not substituted for the unrestricted block-kernel converse.

[6] Lei Yu. *Exact Common Information and Exact Channel Synthesis for Correlated Discrete Sources*. [arXiv:2609.24120v1](https://arxiv.org/html/2609.24120v1), 21 September 2026. Its exact-generation and positive-infinite-order setting differs from the negative-order phase problem here.

[7] Ling Zhu. *On Wilker-type inequalities*. Mathematical Inequalities & Applications **10**(4), 727–731 (2007). DOI: [10.7153/mia-10-67](https://doi.org/10.7153/mia-10-67). [Publisher full text](https://files.ele-math.com/articles/mia-10-67.pdf). Theorem 1 and Section 4 supply the known hyperbolic inequality and power-series proof reproduced in Lemma 5.2.

[8] Vu Khac Ky and Tuan Tran. *Dictators are most informative*. [arXiv:2609.24184v1](https://arxiv.org/html/2609.24184v1), 21 September 2026. Lemma 4.1 concerns a neighboring entropy profile and is not a proof input here.

[9] Amos Lapidoth and Christoph Pfister. *Two Measures of Dependence*. Entropy **21**(8), 778 (2019). DOI: [10.3390/e21080778](https://doi.org/10.3390/e21080778). [Publisher full text](https://www.mdpi.com/1099-4300/21/8/778). Lemma 11 and equation (165) give the diagonal Rényi-entropy transform.

[10] Semih Yagli, Yücel Altuğ, and Sergio Verdú. *Minimax Rényi Redundancy*. IEEE Transactions on Information Theory **64**(5), 3715–3733 (2018). DOI: [10.1109/TIT.2018.2803070](https://doi.org/10.1109/TIT.2018.2803070). [Author manuscript, arXiv:1701.01103v4](https://arxiv.org/pdf/1701.01103). This is a predecessor on universal logarithmic redundancy, without the local synthesis-kernel and finite-seed constraint considered here.

[11] Gowtham Ramani Kumar, Cheuk Ting Li, and Abbas El Gamal. *Exact Common Information*. [arXiv:1402.0062v1](https://arxiv.org/pdf/1402.0062), 1 February 2014. Its strict single-letter common-entropy nonadditivity concerns an exact-generation and variable-length randomness model.

[12] Vinod M. Prabhakaran and Manoj M. Prabhakaran. *Assisted Common Information with an Application to Secure Two-Party Sampling*. IEEE Transactions on Information Theory **60**(6), 3413–3434 (2014). DOI: [10.1109/TIT.2014.2316011](https://doi.org/10.1109/TIT.2014.2316011). [Author manuscript, arXiv:1206.1282v3](https://arxiv.org/pdf/1206.1282). Theorem 5.7 includes independent-source additivity of the tension region.

[13] Salman Beigi and Amin Gohari. *On the Duality of Additivity and Tensorization*. Proceedings of the IEEE International Symposium on Information Theory, 2381–2385 (2015). DOI: [10.1109/ISIT.2015.7282882](https://doi.org/10.1109/ISIT.2015.7282882). [Expanded author manuscript, arXiv:1502.00827v2](https://arxiv.org/pdf/1502.00827), revised 4 November 2016. Its general dual framework is a methodological predecessor.

[14] Ian George, Min-Hsiu Hsieh, and Eric Chitambar. *One-Shot Distributed Source Simulation: As Quantum as It Can Get*. IEEE Transactions on Information Theory **71**(12), 9251–9284 (2025). DOI: [10.1109/TIT.2025.3624812](https://doi.org/10.1109/TIT.2025.3624812). [Author text, arXiv:2301.04301v3](https://arxiv.org/html/2301.04301v3).

[15] Gábor Braun, Rahul Jain, Troy Lee, and Sebastian Pokutta. *Information-theoretic approximations of the nonnegative rank*. Computational Complexity **26**(1), 147–197 (2017). DOI: [10.1007/s00037-016-0125-z](https://doi.org/10.1007/s00037-016-0125-z). [Primary author report, ECCC TR13-158](https://eccc.weizmann.ac.il/report/2013/158/).

[P] *DSBS negative-order Rényi common information: operational frontier and phase transition*. Unpublished research manuscript, 25 November 2026. Its [operational converse](references/prior_operational_converse.md) and [globally evaluable phase boundary](references/prior_phase_boundary.md) are supplied as scholarly background. Their reused results are identified and the required proofs are reproduced in Sections 1 and 3–4.

[P2] *Negative-order common information: exact binary phase boundaries and strict subadditivity*. Unpublished research manuscript, 26 November 2026, preceding version. Its global phase, finite-block, and product-potential results are reproduced with proofs in Sections 5–12.
