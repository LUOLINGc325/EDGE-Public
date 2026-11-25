---
title: "Dynamic regret with path drift and expected action-switch budgets"
lang: en
---

## Abstract

For full-information learning on a fixed finite-dimensional compact convex domain, we determine the minimax dynamic regret up to an explicit cubic logarithm and dimension-dependent constants. The comparator has Euclidean path budget \(P\), and the learner has a uniform expected budget \(B\) on the number of actual action changes. The governing rate at horizon \(T\) is

\[
 \min\{T,\max(\sqrt{T(1+P)}, T(1+P)/(B+1))\}.
\]

At zero switches the exact value is \(T\) times the domain's minimum enclosing radius. A randomly shifted spatial tree permits simultaneous local fixed-share updates at all levels. Comparator cell changes are charged in proportion to the loss ranges of their parents, while maximal coupling controls the learner's actual action changes. For a nonnegative charge \(\lambda\) per switch, the corresponding minimax rate is \(\min\{T,\sqrt{T(1+P)(1+\lambda)}\}\) up to the same logarithmic factor. We also characterize finite games by exact linear programs and analyze the geometry and limitations of static stable-rounding alternatives.

Part I establishes the universal lower bounds with affine losses. Part II proves the exact zero-budget law and the matching multiscale upper bounds. Parts III–VI give the single-scale comparator interface, exact finite games, limitations of two alternative marginal constructions, and stable-rounding results. The loss sequence is oblivious and the proof uses full loss revelation.

# Part I. Universal lower bounds

## 1. Model and quantifiers

Let \(X\) be a compact convex subset of a finite-dimensional Euclidean space of diameter exactly one. Let \(T\ge2\) and \(P,B\in[0,T-1]\). The loss class \(F_X(T)\) consists of deterministic oblivious sequences of twice continuously differentiable convex functions \(f_t:X\to[0,1]\), with gradient norm at most one and Hessian at most the identity. All losses used below extend smoothly to the ambient space.

A randomized causal learner chooses \(X_t\) from past revealed complete loss functions and its independent random seed before seeing \(f_t\). Write

\[
N_A=\sum_{t=2}^T\mathbf1\{X_t\ne X_{t-1}\},\qquad
R_A(f,u)=\sum_{t=1}^T(f_t(X_t)-f_t(u_t)).
\]

The learner class \(A_B\) satisfies the **uniform expected** constraint

\[
\sup_{f\in F_X(T)}E_A N_A(f)\le B.
\]

There is no hard cap on each sample path. The constrained minimax value is

\[
\mathcal R_X(T,P,B)=\inf_{A\in A_B}\sup_{f\in F_X(T)}
\sup_{u:\sum_{t=2}^T\|u_t-u_{t-1}\|\le P}E_A R_A(f,u).
\]

In each construction a finite distribution of loss sequences is sampled before interaction. For each realization \(f\) the comparator \(u(f)\) is deterministic and independent of the learner seed. Such an average lower-bounds the displayed suprema. Uniform feasibility implies \(\mathbb E_D\mathbb E_A N_A\le B\) under every such distribution \(D\); no minimax interchange is needed.

Independently define the penalized value, without a budget constraint,

\[
\mathcal V_X(T,P,\lambda)
=\inf_A\sup_{f,u}E_A[R_A(f,u)+\lambda N_A(f)],\qquad\lambda\ge0,
\]

with the same loss and comparator classes.

## 2. Main statements

For every domain and parameter choice above,

\[
\boxed{\mathcal R_X(T,P,B)\ge\frac1{144}
\min\left\{T,\max\left\{\sqrt{T(1+P)},\frac{T(1+P)}{B+1}\right\}\right\}.}\tag{LB}
\]

At \(B=0\) the stronger bound is

\[
\mathcal R_X(T,P,0)\ge T/2.\tag{LB0}
\]

For every fixed \(\lambda\ge0\),

\[
\boxed{\mathcal V_X(T,P,\lambda)\ge
\frac18\min\{T,\sqrt{T(1+P)(1+\lambda)}\}.}\tag{PLB}
\]

(PLB) is proved directly, without any constrained/penalized minimax duality claim.

## 3. A normalized one-dimensional embedding

Compactness supplies \(a,b\in X\) with \(\|b-a\|=1\). Put \(e=b-a\),

\[
z(x)=\langle e,x-a\rangle,\qquad y(x)=z(x)-1/2.
\]

For \(x\in X\), \(z(x)\le\|x-a\|\le1\). Also \(z(x)=1+\langle e,x-b\rangle\ge1-\|x-b\|\ge0\). Thus \(z(X)\) lies in \([0,1]\), with \(z(a)=0\) and \(z(b)=1\). Convexity ensures \(a+se\) belongs to \(X\) for every \(s\in[0,1]\).

For \(\epsilon\in\{-1,+1\}\), use

\[
f_\epsilon(x)=\frac12+\epsilon y(x).
\]

Its range is \([0,1]\), gradient is \(\epsilon e\) of norm one, and Hessian is zero. Constant losses \(1/2\) will fill unused rounds. These are admissible under every normalization in the frozen problem.

## 4. Exact block adversary

Let \(m,q,L\) be positive integers with \(mqL\le T\). Divide the first \(mqL\) rounds into \(m\) macrosegments, each containing \(q\) subblocks of length \(L\). Independently draw fair signs \(\epsilon_{j,k}\) before play and repeat \(f_{\epsilon_{j,k}}\) over each subblock. Use constant loss \(1/2\) on remaining rounds.

In macrosegment \(j\) let \(S_j=\sum_k\epsilon_{j,k}\). The comparator uses \(a\) for the whole macrosegment if \(S_j\ge0\), and \(b\) otherwise. It retains its final point on remaining rounds. Its path length is at most \(m-1\). Put

\[
a_q=E\left|\sum_{k=1}^q\epsilon_k\right|
=2^{-q}\sum_{r=0}^q {q\choose r}|2r-q|.
\]

For **every** randomized causal learner,

\[
\boxed{E R_A\ge\frac{mL}{2}a_q-(L-1)E N_A.}\tag{BL}
\]

Consequently \(A\in A_B\) satisfies

\[
E R_A\ge\frac{mL}{2}a_q-(L-1)B.\tag{BB}
\]

### Proof

At the first round \(s\) of a subblock, \(X_s\) is independent of its fresh sign \(\epsilon\), including after conditioning on past losses and the learner seed. Therefore \(\mathbb E[\epsilon y(X_s)]=0\). For \(t\) in that subblock,

\[
\epsilon y(X_t)\ge\epsilon y(X_s)
-\sum_{r=s+1}^t\mathbf1\{X_r\ne X_{r-1}\}.
\]

If no internal switch occurs the coordinates coincide; otherwise their difference is at most one and the indicator sum is at least one. Summing within the block gives

\[
\sum_{t=s}^{s+L-1}\epsilon y(X_t)
\ge L\epsilon y(X_s)-
\sum_{r=s+1}^{s+L-1}(s+L-r)\mathbf1\{X_r\ne X_{r-1}\}.
\]

The expected centered learner loss is thus at least \(-(L-1)\) times its expected number of internal switches. These internal switch sets are disjoint and their sum is no larger than \(N_A\). Boundary switches cannot predict a fresh sign. The comparator centered loss in macrosegment \(j\) is exactly \(-(L/2)|S_j|\), while unused rounds cancel. This proves (BL), and uniform expected feasibility proves (BB).

In particular, the proof never treats the event of not switching as independent of the sign. That event may depend on the revealed sign.

## 5. Elementary Rademacher bound

For all integer \(q\ge1\),

\[
a_q\ge\sqrt{q/2}.\tag{K}
\]

Here is a self-contained proof. The recurrence \(a_{n+1}-a_n=\Pr(S_n=0)\), \(a_0=0\), follows by conditioning on \(S_n\): the average of \(|s-1|\) and \(|s+1|\) equals \(|s|\) except at \(s=0\), where it is one. It gives

\[
a_{2k}=2k c_k,\quad a_{2k+1}=(2k+1)c_k,
\qquad c_k={2k\choose k}4^{-k}.
\]

For \(k\ge1\), \(c_k\ge1/(2\sqrt{k})\). The base \(k=1\) is equality. The induction follows from

\[
\frac{c_{k+1}}{c_k}=\frac{2k+1}{2k+2}\ge\sqrt{\frac{k}{k+1}},
\]

since \((2k+1)^2-4k(k+1)=1\). Substituting gives (K) for even \(q\) and odd \(q\ge3\); \(q=1\) is immediate. This standard Rademacher scale is not claimed as a new inequality.

## 6. All regimes of the expected budget

Set \(v=1+P\) and \(m=\lfloor P\rfloor+1\). Then \(1\le m\le T\), \(m-1\le P\) and \(m\le v<2m\).

### 6.1 Budget-independent baseline

Take \(L=1\) and \(q=\lfloor T/m\rfloor\ge T/(2m)\). The switch term in (BB) is zero, so

\[
\mathcal R_X\ge\frac m2\sqrt{q/2}
\ge\frac14\sqrt{mT}
\ge\frac1{4\sqrt2}\sqrt{Tv}.\tag{BASE}
\]

### 6.2 Switch-limited baseline

Define \(H=T\) if \(B=0\) and \(H=\min\{T,Tm/B\}\) otherwise. We prove

\[
\mathcal R_X\ge H/72.\tag{SW}
\]

Write \(b=B/m\) and choose \(q=\max\{1,\lceil32b^2\rceil\}\). Then \(q\ge32b^2\) and \(q\le1+32b^2\).

If \(mq\le T\), let \(L=\lfloor T/(mq)\rfloor\ge T/(2mq)\). Since \(B\le m\sqrt q/(4\sqrt2)\), (BB), with \(-(L-1)B\) relaxed to \(-LB\), gives

\[
\mathcal R_X\ge L\left(\frac{m\sqrt q}{2\sqrt2}-B\right)
\ge\frac{mL\sqrt q}{4\sqrt2}
\ge\frac{T}{8\sqrt2\sqrt q}
\ge\frac{H}{72}.
\]

The final inequality uses \(\sqrt q\le\sqrt{33}\max\{1,b\}\) and \(8\sqrt{66}<72\).

If \(mq>T\), put \(s=T/m\ge1\). When \(s<2\), (BASE) gives \(R\ge T/(4\sqrt s)>T/(4\sqrt2)\ge H/72\). When \(s\ge2\), \(s<q\le1+32b^2\), hence \(b^2>(s-1)/32\ge s/64\). Thus \(H\le T/b<8\sqrt{mT}\), and (BASE) yields \(R\ge H/32\). This includes noninteger budgets and \(q>T\).

### 6.3 Conversion to (LB)

Let \(D=\min\{T,Tv/(B+1)\}\). If \(B\le m\), \(H=T\ge D\). If \(B>m\), then \(H=Tm/B\ge Tv/[2(B+1)]\ge D/2\). Thus (SW) gives \(R\ge D/144\). Also \(\sqrt{Tv}\le T\), and (BASE) gives \(R\ge\sqrt{Tv}/144\). Therefore

\[
R\ge\frac1{144}\max\{\sqrt{Tv},\min\{T,Tv/(B+1)\}\}
=\frac1{144}\min\{T,\max\{\sqrt{Tv},Tv/(B+1)\}\},
\]

as claimed. Different lower-bound distributions may supply the two terms: each is separately dominated by the supremum over losses. For (LB0), choose \(m=q=1,L=T\) in (BB), giving \(T/2\) with a static comparator.

## 7. Direct penalty bound

Retain \(m=\lfloor P\rfloor+1\). Choose

\[
L=\min\{\lfloor T/m\rfloor,\lfloor\lambda\rfloor+1\},
\qquad q=\lfloor T/(mL)\rfloor.
\]

These integers are positive, \(mqL\le T\) and \(L-1\le\lambda\). For every causal learner, (BL) gives

\[
E[R_A+\lambda N_A]
\ge\frac{mL}{2}a_q+(\lambda-L+1)E N_A
\ge\frac{mL}{2}a_q.
\]

By \(q\ge T/(2mL)\), this is at least \(\sqrt{mTL}/4\). Moreover \(L\ge\min\{T/m,1+\lambda\}/2\). Consequently

\[
\mathcal V_X\ge\frac1{4\sqrt2}\min\{T,\sqrt{mT(1+\lambda)}\}
\ge\frac18\min\{T,\sqrt{vT(1+\lambda)}\},
\]

proving (PLB). The distribution may depend on the fixed known \(\lambda\). No claim concerning arbitrary time-varying penalties is made.

## 8. Independent curvature and small-step stress test

For \(0\le P\le1\), let \(h=P/(T-1)\), \(w_t=(t-1)h\), \(u_t=a+w_te\) and

\[
f_t(x)=\frac12(z(x)-w_t)^2.
\]

These deterministic losses have range in \([0,1/2]\), gradient norm at most one and Hessian \(ee^T\preceq I\). The comparator loss is zero and its path is exactly \(P\), with identical step sizes \(P/(T-1)\).

For a realized learner with \(n\) switches, its constant-action runs have lengths \(\ell_i\), \(i=1,\ldots,n+1\). Even a clairvoyant constant choice on a run has squared-error sum at least \(h^2\ell_i(\ell_i^2-1)/12\), the arithmetic-progression residual around its mean. Including the loss factor \(1/2\) and using Holder's inequality,

\[
R_A\ge\frac{h^2}{24}\left(\sum_i\ell_i^3-T\right)
\ge\frac{h^2}{24}\left(\frac{T^3}{(n+1)^2}-T\right).
\]

Jensen's inequality for the convex decreasing function \(x\mapsto1/(x+1)^2\), followed by \(\mathbb E N_A\le B\), yields

\[
\boxed{\mathcal R_X(T,P,B)\ge
\frac{P^2}{24(T-1)^2}\left[\frac{T^3}{(B+1)^2}-T\right],
\quad0\le P\le1.}\tag{Q}
\]

The bracket is nonnegative since \(B\le T-1\). This remains valid even with the full loss path known in advance. Its scale does not improve the general barrier (LB); it is a genuine curvature stress test, not evidence for a larger minimax exponent.

## 9. Attribution and reproducibility

Sherman and Koren, *Lazy OCO: Online Convex Optimization on a Switching Budget*, COLT 2021, PMLR 134, section 5 and Theorem 9 of the proceedings PDF, already give the static \(T/B\) obstruction using repeated random-sign blocks. The method and static rate are prior work. The present argument adds a self-contained symmetric-sign accounting proof, multiple comparator macrosegments, finite-horizon rounding, arbitrary diameter-one domain embedding and direct penalty consequences. It does not claim to discover the static lower bound. Primary source: https://proceedings.mlr.press/v134/sherman21a/sherman21a.pdf .

The ordinary dynamic-regret square-root boundary is likewise a known calibration, not claimed as the project's novel contribution. Part II supplies the matching general smooth-convex upper theorem up to its stated logarithmic factor.

Run `python3 code/verify_lower.py --output results/lower_certificate.json`. The reconstructed checker uses exact rational arithmetic for finite checks; these supplement the proof, not replace it. Historical pre-recovery output is retained separately and must not be represented as a rerun of reconstructed source.


# Part II. The exact zero-budget value and the multiscale upper bounds

## 1. The domain radius at zero switches

Let \(r_X=\min_{c\in X}\max_{u\in X}\|u-c\|\). This minimum is attained because \(X\) is compact and the farthest-point distance is continuous. A learner that always uses a minimizing \(c\) has regret at most \(T r_X\) against every comparator path by the unit Lipschitz bound.

For the converse, fix any budget-feasible learner and let \(c\) be its mean initial action. Compactness and convexity place \(c\) in \(X\). Pick a farthest \(u\in X\) from \(c\) and repeat the same affine loss in the direction \((c-u)/\|c-u\|\). This direction exists because \(X\) has diameter one. Translate the loss to fit \([0,1]\), which is possible by the diameter bound. The loss sequence and static comparator \(u\) are chosen before observing the learner's seed. The frozen first action would incur expected regret \(T\|c-u\|\). On the event of any actual switch, the learner can save at most \(T-1\) relative to freezing. That event has probability at most \(\min(1,B)\), since the switch count is a nonnegative integer and its expectation is at most \(B\) for this loss sequence. This proves

\[
 \mathcal R_X(T,P,0)=T r_X,qquad
 \mathcal R_X(T,P,B)\ge T r_X-(T-1)\min(1,B).
\tag{R}
\]

A diameter-one interval has \(r_X=1/2\). A unit-edge \(d\)-dimensional regular simplex has \(r_X=\sqrt{d/[2(d+1)]}\): the vertices are \((e_i-\overline e)/\sqrt2\), where \(\overline e=(d+1)^{-1}\sum_i e_i\). Their common distance to the barycenter gives the upper bound, and averaging squared distances to all the vertices gives its square plus the squared distance to the barycenter for every center. Thus (R) detects domain geometry even when comparator drift is unrestricted.

## 2. Main upper bounds

Write

\[
 A=T(1+P),\qquad
 F(T,P,B)=\min\{T,\max(\sqrt A,A/(B+1))\}.
\]

There is a constant \(C_d\) depending only on the ambient dimension such that for all parameters in Part I,

\[
 \frac1{144}F(T,P,B)\le \mathcal R_X(T,P,B)
 \le C_d\log^3(2T) F(T,P,B)
\tag{M1}
\]

and for all \(\lambda\ge0\),

\[
 \frac18\min\{T,\sqrt{A(1+\lambda)}\}
 \le \mathcal V_X(T,P,\lambda)
 \le C_d\log^3(2T)\min\{T,\sqrt{A(1+\lambda)}\}.
\tag{M2}
\]

Part I proves the lower bounds using admissible affine losses. We now give the learner for the upper bounds. It uses only full information, the loss range \([0,1]\), and the unit Lipschitz property. In particular curvature bounds are unnecessary for this construction.

## 3. A single spatial tree across all scales

Translate \(X\) coordinatewise to lie in \([0,1]^d\). Use \(L=\lceil\log_2 T\rceil\), \(D=L+1\) and \(h_l=2^{-l}\) for \(0\le l\le L\). Independently in each coordinate draw a uniform shift from \(\{0,h_L,\ldots,1-h_L\}\). Use the same shift \(s\) at all scales. At layer \(l\) keep each half-open cell \(s+h_l(k+[0,1)^d)\), \(k\in\mathbb Z^d\), that meets \(X\). The dyadic grids nest, and the full domain is an artificial root. Every node has at most \(2^d\) children, including the root because a length-one coordinate range meets at most two side-one intervals. At each leaf fix a representative point in the cell's intersection with \(X\). Such choices can be fixed before any observation, since the set of shifts and the tree under each shift are finite. Define the loss range on a parent's subtree at layer \(l\) by the deterministic upper bound

\[
 r_0=1,\qquad r_l=\min(1,\sqrt d\,h_{l-1})\quad (l\ge1).
\]

Indeed all actions below that node have Euclidean diameter at most \(r_l\), so the largest and smallest losses differ by at most \(r_l\). Also \(\sum_l r_l\le 1+2\sqrt d\) and \(r_l/h_l\le \max(1,2\sqrt d)\).

For a fixed comparator path, let \(J_l\) be the number of contiguous runs of a single level-\(l\) cell. In one coordinate, two consecutive points at distance \(\Delta\) are in different coarse intervals only if a coarse grid boundary separates them, including its endpoint allowed by the half-open convention. The shift modulo \(h_l\) has \(h_l/h_L\) equally spaced values. An interval of length \(\Delta<h_l\) contains at most \(\Delta/h_L+1\) possible grid offsets, also when interpreted modulo \(h_l\). If \(\Delta\ge h_l\), the bound obtained below is at least one. Thus the probability of a split in that coordinate is at most \((\Delta+h_L)/h_l\). A union bound over coordinates, followed by \(\|x\|_1\le\sqrt d\|x\|_2\), gives

\[
 \mathbb E_s J_l \le 1+\frac{\sqrt d\,P+d T h_L}{h_l},
 \qquad \sum_{l=0}^L r_l\mathbb E_s J_l\le C_d D(1+P),
\tag{M3}
\]

where \(Th_L\le1\). This balances the frequency of comparator changes at a level with the loss range at its parent.

## 4. Local updates and the coupling of actual actions

For \(B<1\) use a constant action. Its regret is at most \(T\le2F(T,P,B)\), since \(A\ge T\). Otherwise set

\[
 \alpha=(16T^2D)^{-1},\qquad
 \eta=\min\{\sqrt{(1+P)/T},B/(8TD)\}.
\tag{M4}
\]

Each internal node starts with uniform weights on its \(q\) children. At round \(t\), the product of conditional child weights defines a marginal distribution \(Q_t\) on leaves. After observing \(f_t\), compute each child's expected loss under the current weights in its subtree, by recursion upward. For a node at layer \(l\), subtract the smallest child loss and divide by \(r_l\). The scaled vector \(z_t\) lies in \([0,1]^q\). Set

\[
 v_i=\frac{w_i e^{-\eta z_{ti}}}{\sum_c w_c e^{-\eta z_{tc}}},\qquad
 w'_i=(1-\alpha)v_i+\alpha/q.
\tag{M5}
\]

A node with a single child keeps its unique weight. The update takes place at every node and the loss averages depend on past losses and the current revealed loss, without depending on the drawn leaves.

On any contiguous interval \([a,b]\) of \(n\) rounds and for any fixed child \(i\), use \(w_{t+1,i}\ge(1-\alpha)w_{t,i}e^{-\eta z_{ti}}/\sum_c w_{t,c}e^{-\eta z_{tc}}\). Hoeffding's lemma for the current child distribution bounds the logarithm of its denominator by \(-\eta\langle w_t,z_t\rangle+\eta^2/8\). Sum the logarithms over the interval and use \(w_{a,i}\ge\alpha/q\), including for the uniform initialization, and \(w_{b+1,i}\le1\). This gives

\[
 \sum_{t=a}^b(\langle w_t,z_t\rangle-z_{ti})
 \le \frac{\log(q/\alpha)}{\eta}+\frac{n\eta}{8}
       +\frac{n\log(1/(1-\alpha))}{\eta}.
\tag{M6}
\]

It applies also when the comparator leaves and later returns to a child whose subtree weights have continued to evolve.

At the first round sample from \(Q_1\). On later rounds use the conditional law of a maximal coupling between \(Q_{t-1}\) and \(Q_t\), conditional on the previous sampled leaf. On each fixed loss sequence and shift, all marginals are deterministic functions of the revealed loss history. Thus the coupling is causal and induction gives marginal \(Q_t\) in every round. On a zero-probability previous leaf any conditional law can be used.

For a node, \(e^{-\eta}\le v_i/w_i\le e^\eta\) and \(\eta\le1\), so \(\operatorname{TV}(w,v)\le2\eta\). The sharing term adds at most \(\alpha\). Applying maximal coupling of child weights at each common node until the paths diverge proves \(\operatorname{TV}(Q_{t-1},Q_t)\le D(\alpha+2\eta)\). This is a bound on the leaf marginals, independently of the specific maximal coupling used to sample the played leaf. Actual movements are bounded by leaf-index changes. For every fixed oblivious sequence and shift, the expected count is at most

\[
 TD(\alpha+2\eta)\le 1/(16T)+B/4\le B.
\tag{M7}
\]

This also holds after the shift is averaged, and controls the required supremum over inputs.

## 5. Combining the local regrets

At each round, the root's average loss minus the comparator leaf's loss telescopes along the comparator leaf's ancestry as a sum of differences between the parent average and its designated child's average. On any of the \(J_l\) constant-cell intervals at layer \(l\), the parent and that child are fixed, so apply (M6), multiplied by \(r_l\), over that interval. Their lengths sum to \(T\) for each layer. The comparator leaf's representative has additional regret at most \(\sqrt d Th_L\) over the entire path, by Lipschitz continuity. Combining and averaging over the shift with (M3), using \(q\le2^d\) and \(\log(1/(1-\alpha))\le2\alpha\), yields

\[
 \mathbb E R_A(f,u)\le \sqrt d Th_L+
 C_d\left[ T\eta + \frac{T\alpha}{\eta}
       +\frac{D(1+P)\log(2^d/\alpha)}{\eta}\right].
\tag{M8}
\]

Since \(1/\eta=\max\{\sqrt{T/(1+P)},8TD/B\}\) and \(T\eta\le\sqrt A\), the main term is at most \(C_d D\log(2^d/\alpha)\max(\sqrt A,\,8DA/B)\). For \(B\ge1\), \(1/B\le2/(B+1)\). The other terms are bounded by the same order, and \(D\) and \(\log(2^d/\alpha)\) are at most a dimension-dependent constant times \(\log(2T)\). Taking the better of this procedure and a fixed action proves (M1), including the saturated regimes.

For (M2), an algorithm obeying the budget has penalized regret at most its hitting regret plus \(\lambda B\) uniformly. Put \(b=\sqrt{A/(1+\lambda)}\). If \(b<1\), then \(\sqrt{A(1+\lambda)}>A\ge T\), and the fixed-action bound suffices. Otherwise use \(B=\min(T-1,b)\). Because \(b\le T\), we have \(B+1\ge b\), giving \(A/(B+1)\le\sqrt{A(1+\lambda)}\). Also \(\lambda B\le\lambda b\le\sqrt{A(1+\lambda)}\). Taking the better of this rule and a fixed action proves the upper bound with the stated cutoff. The penalty lower bound in Part I is a direct lower bound.

For a finite check of (M3), use \(d=1,T=8\), the comparator \(u_t=(t-1)/8\), and each of the eight shifts in the construction. Computing the integer cell numbers \(\lfloor 2^l(u_t-s)\rfloor\) gives mean run counts \(15/8,11/4,9/2,8\). The parent loss ranges are \(1,1,1/2,1/4\), as used in (M3). This check concerns the geometry of the shifting rule.

## 6. Mechanisms and scope

The Mhaisen–Iosifidis indicator-switching analysis uses dyadic time scales, a lazy FTRL base learner and maximal coupling of consecutive marginals. Its limitation statement distinguishes its sharp comparator-switch bound from the open Euclidean path-length rate. Yang et al.'s DRate already decomposes a static expert's regret into root-to-leaf local regrets and discusses Lipschitz experts. Here the running comparator generates a different number and pattern of intervals at every spatial scale. The interval fixed-share bound and (M3) pay jointly for these runs and their parent loss ranges. At the same time (M7) meets a learner action budget for each fixed input. Wang et al. convert bounds against a switching comparator to path-dependent bounds via unbiased random comparison sequences. Their Theorem 5 concerns the comparator and does not constrain the learner's own actual changes. The geometric interfaces in Part VI remain separate results about static kernels. [Mhaisen–Iosifidis, Limitation](https://arxiv.org/pdf/2609.30556v1#page=3) · [DRate, §§3 and 5.3](https://doi.org/10.1145/3530900) · [Wang et al., §3 and Theorem 5](https://arxiv.org/html/2609.20968v1)

The construction assumes known \(T,P,B\), full-information observation, and an oblivious loss sequence. It explicitly allows dimension-dependent constants and a finite spatial tree with potentially many states. Removing the displayed logarithms, adapting to unknown \(P\), high-probability switch control and computational complexity in growing dimension are separate questions.

# Part III. Finite experts and geometric interfaces

**Recovery note.** Part III uses the reconstruction of the reviewed first-round derivation after executor replacement. The constants, hypotheses and conclusions are those of the reconstructed version. Historical recovery record

**Attribution and scope.** Fixed-share regret against distribution paths measured by total variation is classical; see Cesa-Bianchi, Gaillard, Lugosi and Stoltz (2012), Section 3 and Theorem 2. Maximal coupling for low-switch learning is also classical; see Sherman and Koren (2021), Section 2.3. We give a self-contained combination with explicit expected-budget tuning and a domain-feasible geometry interface. The finite-expert regret and coupling tools are prior work. Part II uses them on a spatial tree to obtain a general compact-domain upper bound.

## 1. Model and deterministic marginals

Let \(T\ge2\), \(N\ge2\). The entire loss sequence \(\ell_t\in[0,1]^N\), \(t=1,\ldots,T\), is fixed independently of the learner's random choices. Full information reveals \(\ell_t\) after the learner selects \(I_t\). For probability vectors \(p,q\), write

\[
TV(p,q)=\tfrac12\sum_i|p_i-q_i|.
\]

Fix \(\eta>0\) and \(0<\alpha<1\). Starting at the uniform distribution \(q_1\), set

\[
r_{t+1,i}=\frac{q_{t,i}e^{-\eta\ell_{t,i}}}{\sum_jq_{t,j}e^{-\eta\ell_{t,j}}},
\qquad q_{t+1}=(1-\alpha)r_{t+1}+\alpha\mathbf 1/N.
\tag{1}
\]

For analysis one also defines \(q_{T+1}\); the learner never needs to play time \(T+1\). These marginals are deterministic functions of the fixed loss history and are independent of the sampled indices. In particular, \(q_{t,i}\ge\alpha/N\) for \(t\ge2\) and all coordinates are positive.

At time one sample \(I_1\) from \(q_1\). After observing \(\ell_t\), couple \(I_t\) to \(I_{t+1}\) by a maximal coupling of \(q_t,q_{t+1}\). This specifies a causal policy because both marginals are now known. It does not require knowing the comparator.

For completeness, for marginals \(p,q\) put \(a_i=\min(p_i,q_i)\), \(d=1-\sum_i a_i\), and residuals \(b_i=p_i-a_i\), \(c_i=q_i-a_i\). If \(d>0\), define

\[
\gamma_{ij}=\mathbf 1_{i=j}a_i+b_i c_j/d.
\]

If \(d=0\), use the diagonal coupling. Nonnegativity and row/column sums are immediate from \(\sum_i b_i=\sum_i c_i=d\), while \(b_i c_i=0\). Thus mismatch probability is \(d=\operatorname{TV}(p,q)\). The conditional transition at a positive-mass row \(i\) is \(\gamma_{ij}/p_i\); zero rows, if used in another implementation, can be arbitrary. This construction realizes all consecutive maximal couplings in one causal Markov chain, rather than claiming unrelated pairwise couplings automatically form a process.

## 2. Exact switch accounting

For an exponential tilt \(u_i(s)=q_i\exp(-s\ell_i)/Z(s)\),

\[
u'_i(s)=u_i(s)(\mathbb E_{u(s)}\ell-\ell_i).
\]

A random variable \(X\in[0,1]\) has \(\mathbb E|X-\mathbb E X|\le1/2\): by convexity in \(X\), at mean \(\mu\) the bound is \(2\mu(1-\mu)\le1/2\). Consequently the TV speed of \(u(s)\) is at most \(1/4\). Integrating \(s\in[0,\eta]\) gives \(\operatorname{TV}(q,r)\le\eta/4\). Sharing changes a distribution by at most \(\alpha\), hence

\[
TV(q_t,q_{t+1})\le\alpha+\eta/4.
\]

For \(S=\sum_{t=1}^{T-1}\mathbf 1\{I_{t+1}\ne I_t\}\), the causal coupling has

\[
\boxed{\mathbb E S\le (T-1)(\alpha+\eta/4).}
\tag{2}
\]

This bound is uniform over every fixed allowed loss sequence. It controls an **expected** budget, not an almost-sure switch cap.

## 3. Comparator distribution paths

Let \(p_1,\ldots,p_T\) be any deterministic probability vectors, and let \(V=\sum_{t=2}^T\operatorname{TV}(p_t,p_{t-1})\). Adopt \(0\log0=0\). Hoeffding's lemma applied to (1), followed by the standard relative-entropy identity, gives for every \(p\)

\[
\langle q_t-p,\ell_t\rangle
\le\frac{D(p\Vert q_t)-D(p\Vert r_{t+1})}{\eta}+\frac\eta8.
\]

Because \(q_{t+1}\ge(1-\alpha)r_{t+1}\) coordinatewise,

\[
D(p\Vert r_{t+1})\ge D(p\Vert q_{t+1})-\log\frac1{1-\alpha}.
\]

Sum with \(p=p_t\). The relative-entropy sum is

\[
D(p_1\Vert q_1)-D(p_T\Vert q_{T+1})
+\sum_{t=2}^T[D(p_t\Vert q_t)-D(p_{t-1}\Vert q_t)].
\]

The entropy terms telescope exactly. Since \(q_1\) is uniform, the result equals

\[
\log N+\langle p_T,\log q_{T+1}\rangle
+\sum_{t=2}^T\langle p_{t-1}-p_t,\log q_t\rangle.
\]

The terminal inner product is nonpositive. For a vector \(z\) of zero sum, its inner product with a bounded function \(g\) is at most \((\sum_i|z_i|)/2\) times \((\max_i g_i-\min_i g_i)\); here this means

\[
\langle p_{t-1}-p_t,\log q_t\rangle
\le TV(p_t,p_{t-1})\log(N/\alpha).
\]

Indeed \(\log q_t\) lies between \(\log(\alpha/N)\) and \(0\). Therefore, defining

\[
A_\alpha(V)=\log N+V\log(N/\alpha)+T\log\frac1{1-\alpha},
\]

we obtain

\[
\boxed{\mathbb E\sum_{t=1}^T\ell_{t,I_t}-\sum_{t=1}^T\langle p_t,\ell_t\rangle
\le A_\alpha(V)/\eta+\eta T/8.}
\tag{3}
\]

No entropy-Lipschitz estimate near zero was used: the entropy contribution cancels before bounding the path term. The comparison allows arbitrary distributions, not just deterministic expert paths.

## 4. Tuning to every positive expected budget

Suppose \(0<B\le T-1\) and a bound \(V\le\bar V\) is available. Choose

\[
\alpha=\frac{B}{4T(T-1)},\qquad
\bar A=A_\alpha(\bar V),\qquad
\eta=\min\left\{\sqrt{8\bar A/T},\frac{2B}{T-1}\right\}.
\tag{4}
\]

Equation (2) gives

\[
\mathbb E S\le B/(4T)+B/2\le5B/8\le B.
\tag{5}
\]

Also \(\alpha\le1/(4T)\le1/8\), so \(T\log(1/(1-\alpha))\le2T\alpha\le1/2\). For positive \(a,b\), \(1/\min(a,b)\le1/a+1/b\); using this with (3) and \(\eta\le\sqrt{8\bar A/T}\) yields the following conservative bound (the coefficient of the final term can actually be halved):

\[
\boxed{\mathbb E\sum_t\ell_{t,I_t}-\sum_t\langle p_t,\ell_t\rangle
\le\min\left\{T,\sqrt{T\bar A/2}+\frac{(T-1)\bar A}{B}\right\}.}
\tag{6}
\]

The \(T\) truncation holds for the same algorithm because every per-time loss difference is at most one. At \(B=0\) choose one fixed action, giving zero switches and regret at most \(T\). At \(N=1\) choose the only expert; expert regret and switches are zero. These endpoint prescriptions avoid undefined tuning formulas.

## 5. Direct penalty consequence

For any \(\lambda\ge0\) and any \(\eta,\alpha\) in their stated ranges, the same policy satisfies

\[
\mathbb E[\mathrm{regret}+\lambda S]
\le\frac{A_\alpha(V)}\eta
+\eta\left[\frac T8+\frac{\lambda(T-1)}4\right]
+\lambda\alpha(T-1).
\tag{7}
\]

Alternatively, every budget-tuned upper bound \(U(B)\) gives an achievable penalty bound \(U(B)+\lambda B\), and one may choose a budget parameter to minimize this upper bound. Neither statement asserts constrained/penalized minimax duality or obtains a penalty lower bound from a Legendre transform.

## 6. Domain-feasible kernel interface

Let \(X\) be a compact convex domain and \(a_1,\ldots,a_N\in X\) fixed actions. Suppose a probability kernel \(p(x)\) on these actions satisfies

\[
TV(p(x),p(y))\le L\|x-y\|,
\quad
\sum_i p_i(x)f(a_i)\le f(x)+\varepsilon
\tag{8}
\]

for every allowed loss \(f\) and \(x,y\in X\). Define \(\ell_{t,i}=f_t(a_i)\), using the original full losses. This expert sequence is oblivious. For any comparator path \(u_t\) with \(\sum\|u_t-u_{t-1}\|\le P\), take \(p_t=p(u_t)\). Then \(V\le\min\{T-1,LP\}\), and (6) plus \(T\varepsilon\) is an upper bound for the original dynamic regret. Played actions stay in \(X\). Index switches bound action switches, with equality if all expert points are distinct.

This avoids the invalid substitution \(\ell_{t,i}=\langle\nabla f_t(X_t),a_i\rangle\) into a theorem requiring an oblivious loss sequence: such a linearization depends on the learner's sampled action. The interface does not require the comparator or its mapped distributions to be revealed online.

## 7. Matching restricted subclass: affine losses on a fixed polytope

Let \(X\) be a fixed non-singleton polytope, described in its affine hull using orthonormal coordinates. Choose a finite triangulation with vertex set \(a_1,\ldots,a_N\subset X\). On each simplex define \(p_i(x)\) to be its barycentric coordinates, with zero weight at unused vertices. Definitions agree on common faces, so \(x\mapsto p(x)\) is globally continuous and piecewise affine, and

\[
\sum_i p_i(x)a_i=x.
\]

If \(J_\sigma\) is the derivative of the full \(N\)-vector of coordinates on a simplex, define

\[
L_X=\tfrac12\max_\sigma\|J_\sigma\|_{2\to1}<\infty.
\]

Integrating the piecewise affine map along the segment \([x,y]\) shows \(\operatorname{TV}(p(x),p(y))\le L_X\|x-y\|\). This remains valid when a segment lies in a triangulation face, by restricting to its pieces. For every affine \(f\), the loss in (8) is reproduced exactly: \(\varepsilon=0\).

Hence (4)-(6), with \(\bar V=\min\{T-1,L_X P\}\), give a complete all-budget upper bound on this subclass. With \(X\) fixed, it has order

\[
\widetilde O_X\!\left(\min\left\{T,
\sqrt{T(1+P)}+\frac{T(1+P)}{B+1}\right\}\right),
\tag{9}
\]

where logarithms are explicitly those in \(\bar A\) and constants depend on \(N,L_X\). To justify \(B+1\), use (6) for \(B\ge1\) and the \(T\) bound for \(0\le B<1\). Together with the separately proved universal lower bound, (9) matches this affine fixed-polytope subclass up to logarithms and geometry constants. It does not extend affine reproduction to nonlinear convex losses; Jensen's inequality goes in the unfavorable direction there.

## 8. Quantitative partial routes for smooth losses

### 8.1 Hysteresis on a general finite net

For diameter-one \(X\), take a finite \(\delta/2\)-net in \(X\). Given a comparator path, maintain an anchor \(u_s\) and a net point within \(\delta/2\) of that anchor; reuse it until \(\|u_t-u_s\|>\delta/2\), then reset the anchor and its net point. Its pointwise distance to \(u_t\) is at most \(\delta\), and the number of resets is at most \(2P/\delta\) because the disjoint intervening path segments each consume more than \(\delta/2\). This construction is only a comparison sequence; the learner does not observe or implement it.

For 1-Lipschitz losses, (6) applies with \(\bar V=\min\{T-1,2P/\delta\}\), plus \(T\delta\). In fixed dimension, the logarithm of net size is controlled by the usual volumetric packing bound. Balancing the principal terms gives, with explicit parameters retained in (6), the nonmatching scale

\[
\widetilde O\!\left(\min\{T,\sqrt T+T/(B+1)
+T^{2/3}P^{1/3}+T\sqrt{P/(B+1)}\}\right).
\]

### 8.2 Smooth tensor interpolation on a diameter-one cube

For \(X=[0,1/\sqrt d]^d\), split each coordinate into \(m\) intervals and independently round to its two neighboring grid points with the probabilities preserving the coordinate mean. Then \(N=(m+1)^d\) and

\[
\mathbb E Z=x,\quad TV(p(x),p(y))\le dm\|x-y\|,
\quad \mathbb E\|Z-x\|^2\le1/(4m^2).
\]

The TV estimate follows by summing coordinate TV distances and applying the Euclidean Cauchy-Schwarz inequality. Smoothness with Hessian at most \(I\) and exact mean give \(\mathbb E f(Z)-f(x)\le1/(8m^2)\). Thus (6) with \(\bar V=\min\{T-1,dmP\}\), plus \(T/(8m^2)\), is a complete quantitative partial upper bound. Balancing these terms yields the nonmatching scale

\[
\widetilde O_d\!\left(\min\{T,\sqrt T+T/(B+1)
+T^{3/5}P^{2/5}+T(P/(B+1))^{2/3}\}\right).
\]

The exact parameter expression, not a suppressed logarithmic formula, is the primary bound. \(B<1\) is handled by the trivial \(T\) bound; \(P=0\) permits increasingly fine grids with only logarithmic size costs. Part VI treats the ball and states its additional restrictions.

### 8.3 Why exact mean cannot solve every geometry

At an extreme point \(x\) of a compact convex domain, a domain-supported law with mean \(x\) must be \(\delta_x\). Distinct extreme points therefore have TV distance one. An exact-mean, finite-TV-Lipschitz kernel forces extreme points to be uniformly separated; compactness forces their number to be finite. Thus curved domains with infinitely many extreme points do not admit this exact-mean static interface. This is a limitation of the kernel mechanism, not an impossibility theorem for all online algorithms. The second round states and examines the full iff classification and approximate-mean alternatives.

## 9. Primary references and claim ownership

- N. Cesa-Bianchi, P. Gaillard, G. Lugosi and G. Stoltz (2012), *Mirror Descent Meets Fixed Share (and feels no regret)*, Section 3, Theorem 2. Its distribution-TV comparator bound already covers the central loss estimate and has a sharper sharing term. <https://proceedings.neurips.cc/paper_files/paper/2012/file/8e6b42f1644ecb1327dc03ab345e618b-Paper.pdf>
- U. Sherman and T. Koren (2021), *Lazy OCO: Online Convex Optimization on a Switching Budget*, Section 2.3. Maximal coupling is an established low-switch construction. <https://proceedings.mlr.press/v134/sherman21a/sherman21a.pdf>
- G. Pagès and B. Wilbertz, arXiv:1010.4642. Mean-preserving simplex splitting and second-order weak approximation are established dual-quantization constructions; their rediscovery is not a new contribution here. <https://arxiv.org/pdf/1010.4642>

This part gives a finite-expert transfer and its affine-polytope application. The spatial tree in Part II handles the general smooth-domain result.


# Part IV. Exact finite games

This part gives exact finite-horizon values for finite action and loss families. It uses standard occupancy measures, linear programming and maximal coupling. Part II gives the continuum-domain rate.

## Model and linear program

Let \(A=\{a_1,\ldots,a_n\}\) be a nonempty finite subset of a metric space, and
\(F=\{f^1,\ldots,f^k\}\) a nonempty family of distinct loss vectors on \(A\). Equal restrictions to \(A\) are identified, so observing a full vector determines its label. The adversary fixes a word
\(\ell\in\{1,\ldots,k\}^T\) before the learner's independent random seed.
After acting, the learner observes the entire loss vector.

For each word the deterministic hindsight benchmark is
\[
C_P(\ell)=\min_{\substack{u_t\in A\\\sum_{t=2}^T d(u_t,u_{t-1})\le P}}
\sum_{t=1}^T f^{\ell_t}(u_t).
\]
The learner must satisfy \(\mathbb E N\le B\) separately for every fixed word.

At each public loss prefix \(h\) of length \(t-1\), introduce marginal variables
\(p_h(i)\). For nonempty \(h\), introduce adjacent joint variables \(q_h(i,j)\),
and write \(h^-\) for the prefix with its last loss removed. Impose nonnegativity,
\(\sum_i p_\emptyset(i)=1\), and the flow equations
\[
\sum_jq_h(i,j)=p_{h^-}(i),\qquad
\sum_iq_h(i,j)=p_h(j).
\]
For every complete word impose
\[
\sum_{t=1}^T\sum_i p_{\ell_{<t}}(i)f^{\ell_t}(a_i)-v\le C_P(\ell),
\qquad
\sum_{t=2}^T\sum_{i\ne j}q_{\ell_{<t}}(i,j)\le B.
\]
Minimize the free real coordinate \(v\). The probability coordinates are
nonnegative. There are \(n\sum_{t=0}^{T-1}k^t\) marginal variables and
\(n^2\sum_{t=1}^{T-1}k^t\) joint variables, plus \(v\).

## Theorem and proof

**Theorem F.** The LP optimum equals the minimax expected dynamic regret over
all randomized causal learners satisfying the uniform expected switch budget,
including learners with arbitrary private memory. An optimal LP point yields
an implementable causal learner.

For the first direction, fix any such learner. For each public loss prefix,
average over the learner's independent seed to obtain its action marginal and
adjacent joint law. Causality makes these laws independent of the future
continuation. The newly revealed loss is fixed rather than selected in response
to the learner's private action, so the previous-action marginal at a child
prefix is exactly its parent marginal. The flow equations follow. Expected
loss and expected switches are the displayed leaf expressions. Taking \(v\)
as the maximum expected regret gives a feasible point.

Conversely, draw the first action according to \(p_\emptyset\). At prefix
\(h\), when the previous action is \(i\) and \(p_{h^-}(i)>0\), draw the new action
\(j\) with probability \(q_h(i,j)/p_{h^-}(i)\). On zero-denominator branches use
any fixed distribution; those branches are unreachable. Induction preserves
the prescribed marginal and adjacent joint law on every fixed loss word.
Thus this strategy has the LP's expected losses and switches. It needs only
the public prefix and the previous actual action; preserving an arbitrary
earlier strategy's entire private-memory distribution is unnecessary because
the objective and constraint depend only on the preserved laws.

All probability coordinates lie in a compact polytope, and the maximum of
finitely many expected regrets is continuous and finite there. A constant
action is budget-feasible, so the optimum is attained. The two directions
establish equality.

This proof depends on full information, oblivious losses and an expectation
constraint. It does not justify the same LP for an action-adaptive adversary,
a pathwise hard cap, or a tail-probability budget. No large-horizon efficiency
is claimed.

## Exact certificates and recovered implementation

For a minimization LP with nonnegative probability coordinates and free \(v\),
a certificate has primal \(x\), free equality multipliers \(y\), and nonpositive
inequality multipliers \(z\). Check
\[
A_{\rm eq}x=b_{\rm eq},\quad A_{\rm ub}x\le b_{\rm ub},\quad
A_{\rm eq}^{\mathsf T}y+A_{\rm ub}^{\mathsf T}z\le c
\]
on nonnegative coordinates, equality on the free coordinate, and equality
of primal and dual objectives. Weak duality proves exact optimality.

The solver discovers candidates; rational reconstruction is accepted only
after exact feasibility and equality checks. The independent standard-library
verifier imports no solver or model-building module. It reconstructs every
constraint from the raw action/loss model, exhaustively enumerates feasible
comparator paths, compares the stored matrix, and checks the rational witness.

| Family | T | P | B | Exact value |
|---|---:|---:|---:|---:|
| linear | 2 | 0 | 0 | 1/2 |
| linear | 3 | 0 | 1/2 | 3/8 |
| linear | 4 | 1/2 | 1/2 | 83/128 |
| linear | 4 | 1 | 1 | 13/16 |
| quadratic | 3 | 1/2 | 1/2 | 5/16 |
| quadratic | 4 | 0 | 1/2 | 47/144 |

These use actions \(-1/2,0,1/2\) and losses \(1/2\pm x/2\), or
\(1/2\pm x/2+x^2/2\). The 90 numerical diagnostics include these six; the
other 84 do not have exact certificates. The v2 reconstruction reproduces all
six pre-recovery values exactly. Finite values cannot establish the continuous
asymptotic frontier or certify novelty.

# Part V. Limits of sampled-gradient and additive-noise constructions

The following tests identify limitations of two particular attempts to control action switches. Part II uses full-loss marginal updates on a fixed tree. The stable-rounding framework in Part VI gives other geometry-specific bounds.

## U1. A sampled-gradient surrogate does not preserve obliviousness

Even when the original losses \(f_t\) are fixed before play, the online linearization
\[
g_t=\nabla f_t(X_t)
\]
depends on the sampled action \(X_t\). If \(g_t\) is passed as a supposedly fixed linear expert loss to a low-switch algorithm proved only for oblivious loss sequences, that algorithm's hypotheses have changed. Neither substituting the realized gradient sequence into a fixed-sequence theorem nor taking unconditional expectations before assuming that maximal coupling retains the same marginals resolves this issue.

There is a valid alternative interface. Suppose a virtual algorithm uses only the complete original loss history and its own randomness. For fixed original losses, its time-\(t\) marginal \(\mu_t\) is then a deterministic probability distribution determined by that history. One may maximally recouple these marginals, retaining expected hitting loss. The smallest attainable adjacent disagreement probability is exactly
\[
\operatorname{TV}(\mu_t,\mu_{t-1}).
\]
The new mathematical obligation is to control the sum of these marginal TV distances. It is not supplied by the marginal-preservation observation itself.

## U2. Additive-noise OGD can have excessive marginal variation

The following example satisfies the normalization in Part I. Let
\[
X=[-1/2,1/2],\qquad T\ge2,\qquad0<\eta\le1/4,
\]
and define
\[
a=1-\eta,\qquad g=c=1/4,\qquad\sigma=c\eta,
\qquad s_t=(-1)^{t-1}.
\]
Consider the fixed loss sequence
\[
f_t(x)=\frac{x^2}{2}+\frac{s_tx}{4}+\frac1{32}.
\tag{U1}
\]
These losses satisfy \(0\le f_t\le9/32\), \(|f_t'|\le3/4\), and \(f_t''=1\) on \(X\). They therefore satisfy every frozen range, gradient, and smoothness constraint. The comparator is \(u_t=0\) for all \(t\), so its path length is \(P=0\).

The virtual noisy OGD recursion is
\[
Y_{t+1}=\Pi_X\bigl(aY_t-\eta gs_t+\sigma\xi_t\bigr),
\qquad \xi_t\stackrel{\mathrm{iid}}{\sim}\operatorname{Unif}[-1,1].
\tag{U2}
\]
Let \(Z\) have the stationary AR(1) noise law
\[
Z=\sigma\sum_{j\ge0}a^j\xi_j.
\]
Initialize \(Y_1\) with this law, independently of the subsequent noise. This is a fixed algorithmic initialization: it does not read the first loss. The law of \(Z\) is supported on \([-1/4,1/4]\), symmetric and unimodal, with mean zero and variance
\[
v=\frac{\sigma^2}{3(1-a^2)}
=\frac{\eta}{48(2-\eta)}.
\tag{U3}
\]

Set \(b=\eta g/(2-\eta)\). The recursion gives
\[
Y_t\overset d=Z+m_t,\qquad
m_t=s_tb-a^{t-1}b.
\tag{U4}
\]
Indeed, the deterministic centers satisfy the unprojected affine recursion, and the centered AR(1) law remains stationary. Moreover,
\[
|m_t|\le2b\le1/14.
\]
Thus every resulting action lies in \([-9/28,9/28]\subset X\), so projection in (U2) is inactive. Constructing the unprojected process and checking this support bound also avoids any circular assumption about projection.

The distance between adjacent centers obeys
\[
\delta_t=|m_{t+1}-m_t|\ge(2-\eta)b=\eta/4.
\]
Write \(s=\sqrt v\). Symmetric unimodality and Chebyshev's inequality imply
\[
\Pr(|Z|\le h)\ge\frac{3h}{8s},\qquad0<h\le2s.
\]
To prove this, Chebyshev gives \(\Pr(|Z|\le2s)\ge3/4\). For a symmetric unimodal density, the average density on a centered interval cannot decrease when that interval is shortened. The law here is unimodal because convolution of centered uniform laws preserves symmetric unimodality, and so does the relevant weak limit; one may equivalently use symmetric log-concavity.

Use the half-line ending at the midpoint of the two translated centers as a TV test event. Since \(\delta_t/2\le2s\),
\[
\begin{aligned}
\operatorname{TV}\bigl(\mathcal L(Y_t),\mathcal L(Y_{t+1})\bigr)
&\ge\Pr(|Z|\le\delta_t/2)\\
&\ge\frac{3\delta_t}{16s}
\ge\frac{\sqrt\eta}{4}.
\end{aligned}
\tag{U5}
\]
For the parameter checks, the center recursion also gives
\[
\delta_t\le\frac{(2+\eta)\eta}{4(2-\eta)}.
\]
Substitution of \(0<\eta\le1/4\) yields \(\delta_t/2\le2s\). The last inequality in (U5) follows from
\[
\frac{3\sqrt{3(2-\eta)}}{16}\ge\frac14.
\]

Every actual action process with these marginals, regardless of its joint coupling, must therefore satisfy
\[
\mathbb ES\ge\frac{T-1}{4}\sqrt\eta.
\tag{U6}
\]
On the other hand,
\[
gs_tm_t=gb(1-s_ta^{t-1})\ge0.
\]
Consequently the expected one-step hitting regret against zero is nonnegative. Equations (U3)--(U4) show that its sum is \(O(\eta T)\): the variance is \(O(\eta)\), the squared center is \(O(\eta^2)\), and the linear term is \(O(\eta)\). Taking \(T\ge16\) and \(\eta=T^{-1/2}\), the virtual hitting regret is \(O(\sqrt T)\), whereas every realization of its marginals requires \(\Omega(T^{3/4})\) expected switches.

**Scope.** This rules out the displayed stationary small-noise OGD template as a general low-TV interface, and any universal TV lemma that purports to hold for every initialization of that template. The claim concerns the displayed marginals and includes every method of coupling them.

## Consequence for additive-noise marginals

One needs a causal distribution update defined from the original full loss history that simultaneously controls hitting regret against every comparator of path length at most \(P\), controls the sum of first-order marginal TV distances to meet budget \(B\), and avoids treating randomized sampled linearizations as oblivious inputs. An energy or squared-TV bound followed by Cauchy--Schwarz does not by itself supply the needed first-order bound. The displayed noise template fails this first-order TV requirement. The spatial-tree weights in Part II control TV by a different construction.

# Part VI. Stable-rounding geometry

The static kernels below yield exact geometry-dependent results and explicit transfer bounds for balls and boxes. Part II establishes the general matching rate through a separate learner.

We use
\[
\operatorname{TV}(\mu,\nu)=\sup_A|\mu(A)-\nu(A)|.
\]
A probability kernel \(K\) assigns to each \(x\in X\) a probability law \(K_x\) supported in \(X\). All vector integrals are finite-dimensional Bochner integrals.

## S1. A finite-expert transfer through stable rounding

Let \(V=\{v_1,\ldots,v_N\}\subset X\) be finite, and suppose \(K_x\) is supported in \(V\) and satisfies
\[
\operatorname{TV}(K_x,K_y)\le L\|x-y\|,
\]
and, for every loss \(f\) allowed by the frozen problem and every \(x\in X\),
\[
\mathbb E_{Z\sim K_x}f(Z)\le f(x)+\varepsilon.
\]

For a fixed original loss sequence, define expert losses
\[
\ell_{t,i}=f_t(v_i)\in[0,1].
\]
This is an oblivious expert-loss sequence; no gradient at a sampled action is used. Map any comparator \(u_t\) to the probability vector \(p_t=K_{u_t}\). Its distribution path satisfies
\[
V(p):=\sum_{t=2}^T\operatorname{TV}(p_t,p_{t-1})
\le\min\{T-1,LP\}=:\bar V.
\]

Apply the causal maximal-coupling algorithm of Part III. For \(N\ge2\) and \(0<B\le T-1\), set
\[
\alpha=\frac{B}{4T(T-1)},\qquad
A=\log N+\bar V\log(N/\alpha)+T\log\frac1{1-\alpha}.
\]
The resulting learner satisfies \(\mathbb ES\le5B/8\le B\), and
\[
R_X(T,P,B)\le\min\left\{T,
\sqrt{TA/2}+\frac{(T-1)A}{B}+T\varepsilon\right\}.
\tag{S1}
\]

**Proof.** The expert guarantee bounds \(\sum_t\langle q_t-p_t,\ell_t\rangle\). Add
\[
\sum_t\bigl(\langle p_t,\ell_t\rangle-f_t(u_t)\bigr)
\le T\varepsilon.
\]
The played action is the selected \(v_i\). Actual action changes are no more numerous than expert-index changes, and the two counts agree if repeated expert points are removed. No duality identity between constrained and penalized minimax values is assumed. For \(B=0\), a fixed action gives upper bound \(T\); \(N=1\) is handled as a deterministic constant expert.

## S2. Exact-mean stable kernels exist exactly on polytopes

**Theorem S2.** Let \(X\) be a nonempty compact convex set in a finite-dimensional Euclidean space. There exist a finite constant \(L\) and a probability kernel \(K\) satisfying
\[
\int z\,dK_x(z)=x,\qquad
\operatorname{TV}(K_x,K_y)\le L\|x-y\|
\quad\text{for every }x,y\in X
\tag{S2}
\]
if and only if \(X\) is the convex hull of finitely many points. A singleton permits \(L=0\).

**Necessity.** If \(x\) is an extreme point of \(X\), every law supported in \(X\) with barycenter \(x\) must equal \(\delta_x\). Here is a direct argument. If the law is nonconstant, some coordinate of its random vector is nonconstant. Select a threshold event \(A\) for that coordinate so that both \(A\) and its complement have positive probability and their conditional means differ. Compact convexity implies
\[
a=\mathbb E[Z\mid A]\in X,\qquad
b=\mathbb E[Z\mid A^c]\in X.
\]
Then \(x=\Pr(A)a+\Pr(A^c)b\) contradicts extremality. Thus the law is \(\delta_x\).

Any distinct extreme points \(x,y\) consequently obey
\[
1=\operatorname{TV}(\delta_x,\delta_y)\le L\|x-y\|.
\]
For \(L=0\), there can be only one extreme point. For \(L>0\), the extreme-point set is \(1/L\)-separated, and compactness makes it finite. The finite-dimensional extreme-point representation theorem now implies that \(X\) is a polytope.

**Sufficiency.** Take a finite triangulation of \(X\) in its affine hull, with all vertices in a finite set \(V\subset X\). On each simplex, use its barycentric coordinates as a probability vector on \(V\), with zero weight on all other vertices. The definitions agree on common faces. Thus the global weight vector is continuous, piecewise affine, and has exact mean \(x\). Each affine piece has a finite derivative norm. Taking their maximum and partitioning the segment from \(x\) to \(y\) into simplex pieces proves a finite global TV-Lipschitz constant.

**Scope.** This is an if-and-only-if classification for static kernels that remain inside the original domain and preserve the mean exactly. It does not exclude history-dependent online algorithms and is not a general online-learning impossibility theorem.

## S3. The exact variance cost on an interval

**Theorem S3.** Let \(m\ge1\) be an integer. Every kernel on \([0,1]\), supported in \([0,1]\), preserving the mean exactly, and having TV-Lipschitz constant at most \(m\), satisfies
\[
\sup_{x\in[0,1]}\operatorname{Var}_{K_x}(Z)
\ge\frac1{4m^2}.
\tag{S3}
\]
Random linear interpolation on the equally spaced grid attains this bound, so the extremal value is exact.

**Lower bound.** Mean preservation forces \(K_0=\delta_0\). Take \(x=1/(2m)\) and put
\[
q=\Pr_{K_x}(Z\ne0)
=\operatorname{TV}(K_x,\delta_0)\le mx=1/2.
\]
Here \(q>0\), because \(\mathbb EZ=x>0\). Cauchy--Schwarz gives \(x^2\le q\mathbb EZ^2\), hence
\[
\operatorname{Var}(Z)\ge\frac{x^2}{q}-x^2
\ge\frac{x}{m}-x^2=\frac1{4m^2}.
\]

**Attainment.** Write \(x=(j+\theta)/m\), where \(0\le\theta\le1\). Let \(K_x\) assign probabilities \(1-\theta,\theta\) to \(j/m,(j+1)/m\), with the consistent endpoint convention. This preserves the mean and has variance
\[
\frac{\theta(1-\theta)}{m^2}\le\frac1{4m^2}.
\]
Within one grid cell, TV equals \(m|x-y|\). Across cells, partition the interval at grid points and use the triangle inequality. Therefore the global TV-Lipschitz constant is at most \(m\).

For \(f(z)=z^2/2\), the exact optimal worst-case Jensen excess is consequently \(1/(8m^2)\). Even on an interval, exact mean preservation cannot eliminate the second-order cost for nonlinear convex losses.

There is also a weaker universal obstruction without mean preservation. Suppose a kernel on \([0,1]\) has TV-Lipschitz constant \(L\ge2/3\) and, for every allowed 1-smooth convex loss and every point \(x\),
\[
\mathbb E_{K_x}f(Z)-f(x)\le\varepsilon.
\]
Then
\[
\varepsilon\ge\frac1{54L^2}.
\tag{S3b}
\]

To see this, choose \(x=0\) and \(y=\delta=2/(3L)\le1\). The common part \(\nu\) of the two laws has mass at least \(1-L\delta=1/3\). Since
\[
(z-x)^2+(z-y)^2\ge\delta^2/2,
\]
the sum of the two laws' mean squared errors about their respective centers is at least \(\delta^2/6\). At least one error is therefore at least \(\delta^2/12\). Apply the loss assumption separately to
\[
f_x(z)=(z-x)^2/2,\qquad f_y(z)=(z-y)^2/2.
\]
Both satisfy the frozen loss constraints on the interval. Thus \(\varepsilon\ge\delta^2/24=1/(54L^2)\).

## S4. Boundary bias and TV stability on a ball

Work first on the unit-radius ball
\[
B_d=\{x\in\mathbb R^d:\|x\|\le1\},\qquad d\ge2.
\]
The construction will later be scaled to diameter one. Suppose \(K_x\) is supported in \(B_d\) and its boundary laws satisfy
\[
\sup_{\|x\|=1}\|\mathbb EK_x-x\|\le b,\qquad
\operatorname{TV}(K_x,K_y)\le L\|x-y\|.
\]

### S4.1 A lower bound

If \(0<b\le1/8\), then
\[
L\ge\frac1{\sqrt{128b}},\qquad
b\ge\frac1{128L^2}.
\tag{S4}
\]

For a sphere point \(x\),
\[
\mathbb E\|Z-x\|^2
=\mathbb E\|Z\|^2+1-2\langle x,\mathbb EZ\rangle
\le2b.
\]
Choose sphere points \(x,y\) at distance \(a=\sqrt{32b}\le2\), which is possible for \(d\ge2\). Set \(A=\{z:\|z-x\|<a/2\}\). Markov's inequality gives \(K_x(A)\ge3/4\). Since \(A\subseteq\{z:\|z-y\|\ge a/2\}\), it also gives \(K_y(A)\le1/4\). Therefore TV is at least \(1/2\). Combining this with the Lipschitz assumption proves (S4). When \(b=0\), the extreme-point argument directly excludes finite \(L\).

### S4.2 Spherical caps attain the same order

For \(0<h\le\pi/4\), let \(K_x\) be the uniform spherical-cap law of angular radius \(h\) centered at the sphere point \(x\). Rotational symmetry implies
\[
\mathbb EK_x=a_d(h)x,\qquad
0\le1-a_d(h)\le1-\cos h\le h^2/2.
\]
Define
\[
Q_d=(d-1)(\pi/2)^{d-2},\qquad C_d=(\pi/2)Q_d.
\]
Then
\[
\operatorname{TV}(K_x,K_y)\le\frac{C_d}{h}\|x-y\|.
\tag{S5}
\]

**Proof.** Let \(\delta\) be the angle between the cap centers. When \(\delta\le h\), the part of one cap outside the other lies in its angular boundary ring with radii between \(h-\delta\) and \(h\). Its area is at most
\[
\omega_{d-2}\delta h^{d-2},
\]
whereas the area of a cap is at least
\[
\frac{\omega_{d-2}}{d-1}(2/\pi)^{d-2}h^{d-1}.
\]
The first estimate uses \(\sin\theta\le\theta\); the second uses \(\sin\theta\ge(2/\pi)\theta\) on the relevant interval. Dividing yields TV at most \(Q_d\delta/h\). If \(\delta>h\), the same bound follows from TV at most one and \(Q_d\ge1\). Finally \(\delta\le(\pi/2)\|x-y\|\), proving (S5).

Together, the lower and upper bounds show that the optimal uniform mean-bias order for sphere-parameterized kernels is \(\Theta_d(L^{-2})\) as \(L\) grows. This is an order-optimal statement over kernels, not merely an upper bound for one construction.

In dimension two the uniform-arc kernel gives an explicit check. Its bias is \(1-\sin h/h\), and its exact chord-distance Lipschitz constant is \(1/(2\sin h)\). Consequently \(L^2b\to1/24\) as \(h\downarrow0\).

## S5. Extending the kernel to the whole ball and making it finite

All spherical-cap constructions in this section and the ball part of S6 assume \(d\ge2\). In dimension one, the diameter-one ball is an interval and the interval kernel from S3, or the box construction in S6, applies instead. The formulas for \(Q_d,C_d\) and cap area are not invoked at \(d=1\).

A boundary cap kernel alone is insufficient. Scaling a cap directly onto the sphere of radius \(\|x\|\) would put different radii on disjoint supports and make their TV distance one. The following radial interpolation avoids that problem.

Let \(h=1/m\le1/16\), where \(m\) is a positive integer, and set
\[
\kappa_d=\frac{\operatorname{vol}(B_{d-1})}{\operatorname{vol}(B_d)}.
\]

### The inner kernel

For \(\|x\|\le1/2\), let \(I_x\) be the uniform law on \(x+hB_d\). Its support lies in \(B_d\), and
\[
\mathbb EI_x=x,\qquad
\mathbb E\|Z-x\|^2\le h^2,\qquad
\operatorname{TV}(I_x,I_y)\le\frac{\kappa_d}{h}\|x-y\|.
\]
The TV estimate follows by integrating cross-sections in the direction of translation. On each parallel line, the lost length is no greater than the translation distance. The projection area is \(\operatorname{vol}(B_{d-1})h^{d-1}\); divide by the ball volume.

### The outer kernel

For \(r=\|x\|\ge1/4\), write \(v=x/r\). Randomly interpolate the radius between the two adjacent fixed radial grid points \(jh,(j+1)h\), obtaining a random variable \(R\) with
\[
\mathbb ER=r,\qquad\operatorname{Var}(R)\le h^2/4.
\]
Independently draw a direction \(U\) uniformly from the angular-\(h\) cap centered at \(v\). Define \(O_x=\mathcal L(RU)\). This law is supported in \(B_d\) and satisfies
\[
\mathbb EO_x=a_d(h)x,\qquad
\|\mathbb EO_x-x\|\le h^2/2,
\]
and
\[
\mathbb E\|RU-x\|^2
=\operatorname{Var}(R)+2r^2(1-a_d(h))
\le5h^2/4.
\]

The radial interpolation law has TV-Lipschitz constant \(1/h\). On \(\|x\|\ge1/4\), the direction map \(x\mapsto x/\|x\|\) has Lipschitz constant at most eight. Product-measure TV is bounded by the sum of the factors' TV distances, and deterministic pushforward cannot increase TV. Therefore
\[
\operatorname{TV}(O_x,O_y)
\le\frac{1+8C_d}{h}\|x-y\|.
\]

### Gluing the kernels

Let
\[
\phi(r)=\min\{1,\max\{0,4r-1\}\},\qquad
K_x=(1-\phi(\|x\|))I_x+\phi(\|x\|)O_x.
\]
A component is needed only when its coefficient is nonzero. Thus the inner law is used only for \(r<1/2\), and the outer law only for \(r>1/4\). First couple the mixture labels, then couple common components. With \(\phi_x=\phi(\|x\|)\), this gives
\[
\begin{aligned}
\operatorname{TV}(K_x,K_y)\le{}&|\phi_x-\phi_y|\\
&+\min(1-\phi_x,1-\phi_y)\operatorname{TV}(I_x,I_y)\\
&+\min(\phi_x,\phi_y)\operatorname{TV}(O_x,O_y).
\end{aligned}
\]
Terms with zero coefficients are omitted. Since \(\phi\) is four-Lipschitz and \(h\le1\),
\[
\operatorname{TV}(K_x,K_y)\le\frac{D_d}{h}\|x-y\|,
\qquad D_d=5+\kappa_d+8C_d.
\tag{S6}
\]
The mixture also retains
\[
\|\mathbb EK_x-x\|\le h^2/2,\qquad
\mathbb E\|Z-x\|^2\le5h^2/4.
\tag{S7}
\]

### Finite quantization

Choose a fixed \(h^2\)-net \(V\subset B_d\) of size
\[
N\le(1+2/h^2)^d.
\]
Map every point to a net point at distance at most \(h^2\), breaking ties by a fixed index, and call this map \(Q\). Set \(K'_x=Q_\#K_x\). TV cannot increase under this common pushforward, and the mean bias is at most \(3h^2/2\).

For a 1-Lipschitz, 1-smooth loss, the Taylor upper inequality and (S7) give
\[
\mathbb Ef(Z)-f(x)
\le\|\mathbb EZ-x\|+\tfrac12\mathbb E\|Z-x\|^2
\le\frac{9h^2}{8}.
\]
Finite quantization increases expected loss by at most another \(h^2\). Hence
\[
\mathbb E_{K'_x}f-f(x)\le\frac{17h^2}{8}.
\tag{S8}
\]

The kernel is now supported on a finite set, so S1 applies directly. Its probabilities are specified by integrals over the explicitly defined ball/cap distributions and fixed grid Voronoi cells. The construction is explicit and causal. No claim of efficient high-dimensional integration or sampling is made.

### Diameter-one normalization

Scale the entire geometric construction by \(1/2\) to a ball of radius \(1/2\). The expert-count bound is unchanged, and the TV-Lipschitz constant is at most \(2D_d/h\). Under the frozen gradient and Hessian bounds, the mean-bias contribution becomes \(h^2/4\), the second-moment contribution becomes \(5h^2/32\), and quantization costs at most \(h^2/2\). Their sum is
\[
\frac{29h^2}{32}\le h^2.
\]
This scaled domain has exactly the diameter required in Part I.

## S6. Nonmatching dynamic upper bounds on balls and boxes

### An explicit bound on a ball

Let \(d\ge2\), and take the Euclidean ball of radius \(1/2\). For every integer \(m\ge16\), with \(h=1/m\), the preceding construction gives a finite kernel with at most
\[
N=(1+2m^2)^d
\]
expert points. In the following formula, using this upper bound for the count in place of its actual value only enlarges the bound. Define
\[
\bar V=\min\{T-1,2D_dmP\},\qquad
\alpha=\frac{B}{4T(T-1)},
\]
and
\[
A_m=\log N+\bar V\log(N/\alpha)+T\log\frac1{1-\alpha}.
\]
For \(0<B\le T-1\), S1 gives
\[
R_{B_d/2}(T,P,B)
\le\min\left\{T,\sqrt{TA_m/2}
+\frac{(T-1)A_m}{B}+\frac{T}{m^2}\right\}.
\tag{S9}
\]
This formula retains all parameters, dimension constants, and logarithms, and the corresponding learner satisfies the actual uniform expected switch budget.

### A box

Take \(X=[0,1/\sqrt d]^d\), with \(d\ge1\). Independently interpolate each coordinate on its grid of \(m\) equal subdivisions. The resulting kernel has \(N=(m+1)^d\) points, exact mean, TV-Lipschitz constant \(dm\), and total coordinate variance at most \(1/(4m^2)\). Its one-step smooth-loss excess is at most \(1/(8m^2)\). Thus the analogue of (S9) replaces \(2D_dm\) by \(dm\) and \(T/m^2\) by \(T/(8m^2)\). This construction requires no spherical-cap integration and also covers the one-dimensional ball, up to translation.

### Simplified rates and endpoints

The logarithmic factors are explicit in (S9). Choose the mesh scale to balance the approximation and variation terms. When simultaneously imposing \(m\ge16\) and \(h=1/m\ge1/T\) for the ball, first assume \(T\ge16\). If \(2\le T<16\), use the fixed-action bound \(T\), which is at most \(4\sqrt T\) and is absorbed by the following rate. Formula (S9) itself remains valid for every \(T\ge2\); the additional restriction only simplifies the logarithms. Dimension one uses the interval construction.

For fixed dimension, both the ball and the box therefore satisfy
\[
R(T,P,B)\le\widetilde O_d\left(
\min\left\{T,\sqrt T+\frac{T}{B+1}
+T^{3/5}P^{2/5}
+T\left(\frac{P}{B+1}\right)^{2/3}\right\}\right).
\tag{S10}
\]

To verify the balances, the main \(h\)-dependent terms are
\[
\sqrt{TP/h},\qquad\frac{TP}{Bh},\qquad Th^2.
\]
Their pairwise balances with the approximation term suggest
\[
h_1=(P/T)^{1/5},\qquad h_2=(P/B)^{1/3}.
\]
Take \(h\) on the scale of \(\max\{h_1,h_2,1/T\}\), round to an admissible reciprocal integer, and clip to the allowed interval. When the large-parameter clipping is active, the trivial upper bound \(T\) suffices. Logarithms may be incorporated into the scale choice, or left explicit by retaining (S9) as the formal statement. If \(B<1\), the term \(T/(B+1)\ge T/2\) makes the fixed-action bound sufficient. For \(P=0\), a sufficiently fine mesh retains the static scale \(\sqrt T+T/(B+1)\), up to the displayed logarithms.

This does not match the candidate frontier
\[
\sqrt{T(1+P)}+\frac{T(1+P)}{B+1}.
\]
This is a bound on the stable-rounding construction. The spatial-tree construction in Part II closes the general rate up to its stated logarithmic factor.

### Valid consequences for indicator penalties

For each budget-feasible algorithm,
\[
\text{expected penalty regret}
\le\text{its expected hitting-regret bound}+\lambda B.
\]
Taking an infimum over algorithmic choices of \(B\) is legitimate for this upper-bound direction. It does not assert a minimax duality identity.

For the fixed penalty \(\lambda=1\), choose \(B\) on the scale of \(\sqrt T+T^{3/5}P^{2/5}\), clipped to \([0,T-1]\). Equation (S10) yields
\[
\mathbb E[\text{dynamic regret}+S]
\le\widetilde O_d\left(
\min\{T,\sqrt T+T^{3/5}P^{2/5}\}\right).
\tag{S11}
\]
On the specified ball/box domains and under the frozen smooth-loss assumptions, this improves the earlier \(2/3\) path-rate benchmark in the intermediate-drift regime. It applies to the indicated smooth-loss ball and box models with known path budget. The bound (M2) in Part II applies on the full domain class.

## S7. Scope limits retained in the final interpretation

1. Theorem S2 restricts static kernels with exact mean preservation. It does not restrict all online algorithms.
2. The second-order costs in S3--S8 are exact or order-optimal statements about the rounding interface. They are not lower bounds for the original minimax learning problem.
3. Equations (S9)--(S11) describe the performance of the stable-kernel strategy on balls and boxes. The spatial-tree learner attains the full rate (M1).
4. If a surrogate depends on a sampled action, its realized inputs cannot simply be treated as oblivious, as shown in Part V.


# Reproduction and proof coverage

The historical recovery restored checkpoint sources and reconstructed the early proofs with fresh source bindings. Those copies and the six exact rational finite-game certificates are available separately. Their verification uses finite action and loss families. The shift calculation in Part II checks eight discrete offsets and concerns only comparator cell runs. The analytic lower and upper bounds cover the stated continuum domain. Historical Lean coverage concerns finite coupling and does not cover the full paper. Recovery record · [Exact replay and scope](evidence/README.md) · Lean claim coverage

# References


- Naram Mhaisen; George Iosifidis. [Dynamic Regret in Online Convex Optimization with Indicator Switching Costs](https://arxiv.org/pdf/2609.30556).
- Uri Sherman; Tomer Koren. [Lazy OCO: Online Convex Optimization on a Switching Budget](https://proceedings.mlr.press/v134/sherman21a/sherman21a.pdf).
- Nicolò Cesa-Bianchi; Pierre Gaillard; Gábor Lugosi; Gilles Stoltz. [Mirror Descent Meets Fixed Share (and feels no regret)](https://proceedings.neurips.cc/paper_files/paper/2012/file/8e6b42f1644ecb1327dc03ab345e618b-Paper.pdf).
- Sascha Geulen; Berthold Vöcking; Melanie Winkler. [Regret Minimization for Online Buffering Problems Using the Weighted Majority Algorithm](https://www.learningtheory.org/colt2010/papers/105geulen.pdf).
- Naman Agarwal; Satyen Kale; Karan Singh; Abhradeep Guha Thakurta. [Improved Differentially Private and Lazy Online Convex Optimization: Lower Regret without Smoothness Requirements](https://proceedings.mlr.press/v235/agarwal24d.html).
- Yibo Wang, Wenhao Yang, Sifan Yang, Wei Jiang, Yuanyu Wan, Lijun Zhang. [From Switching to Dynamic Regret: A Simple Reduction via Unbiased Random Sequences](https://arxiv.org/pdf/2609.20968v2).
- Gilles Pagès; Benedikt Wilbertz. [Intrinsic stationarity for vector quantization: Foundation of dual quantization](https://arxiv.org/pdf/1010.4642).
- Dominique Bakry; Ivan Gentil; Michel Ledoux. [On Harnack inequalities and optimal transportation](https://arxiv.org/pdf/1210.4650).
- Piotr Puchała. [Continuous version of the Choquet Integral Representation Theorem](https://arxiv.org/pdf/math/0405217).
- Giuliano Basso. [Lipschitz extension theorems with explicit constants](https://www.degruyterbrill.com/document/doi/10.1515/agms-2024-0010/pdf?licenseType=open-access).
- Yuguang Wang; Feilong Cao. [The Direct and Converse Inequalities for Jackson-Type Operators on Spherical Cap](https://arxiv.org/pdf/1409.3807).
- Lin Yang, Yu-zhen Janice Chen, Mohammad H. Hajiesmaili, Mark Herbster, Don Towsley. [Hierarchical Learning Algorithms for Multi-scale Expert Problems](https://discovery.ucl.ac.uk/id/eprint/10165538/1/HetHedge_Sigmetrics2022__Camera_ready_.pdf). Proc. ACM Meas. Anal. Comput. Syst. 6(2), article 34 (2022), §§3 and 5.3.
