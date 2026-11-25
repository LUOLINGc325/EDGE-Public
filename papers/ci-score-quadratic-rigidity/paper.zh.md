# 条件独立信息评分的结构刚性、精确 Shannon 修复预算与二元最小修复

**Structural rigidity, exact Shannon repair budgets, and least binary repairs for informational substitutes**

研究草稿 · 2026-11-25 · 理论经济学 / 信息论 / 统计决策  
目标读者：信息设计、统计决策与凸分析研究者。本文尚未经过外部同行评议，全文形式化尚待完成。

## 中文摘要

当多个信息源在真实状态给定后相互独立时，增加一个信息源的期望收益是否随着已获信息增多而递减，取决于用于评价预测的评分函数。本文研究两个边界明确的修复问题。第一，对 Shannon 对数评分的任意对称二次扰动，完整刻画所有先验、所有有限条件独立信号下的次模性，并求出可行时的最小 Shannon 系数。三个及以上状态中，二次矩阵必须在仿射等价意义下化成唯一的对角形式，剩余带符号系数恰由有限个线性矩阵不等式约束。四个及以上状态存在不能被任何有限 Shannon 系数修复的交叉项，这种失败在扰动任意小时仍会出现。第二，对有限连续、内部二次连续可微且 Bayesian 曲率在两端连续归零的二元凸评分势函数，给出按所有实验的信息增益偏序定义的最小修复及其存在性充要条件；修复候选限定在 \(C^2((0,1))\cap C([0,1])\) 的有限凸势函数类内。采用 \(G_0(p)=p^2-p\) 的平方误差评分，其最小修复有显式公式，最坏额外信息增益精确等于 \(1/27\)。另构造内部光滑、闭区间一阶连续可微且原始支付有界的严格适当评分，其仍不存在上述 \(C^2((0,1))\cap C([0,1])\) 类内的有限端点修复。

基础的 prior-concavity / 曲率判据来自已有文献，本文不将其计为原创。新增主张限于已核验文献范围内的全二次分类、精确修复预算及端点修复结论。全文包含自洽证明、边界和严格正概率有限反例；附带精确算术实例证书。

## 1. Questions, results, and interpretation

A scoring potential \(G\) assigns expected reward \(G(p)\) to a truthful posterior \(p\). For a finite experiment \(A\), its information gain is
\[
 I_G(p,A)=\mathbb E[G(p_A)]-G(p).
\]
We call \(G\) a universal conditional-independent substitute potential when \(S\mapsto\mathbb E[G(p_{A_S})]\) is submodular for every prior and every finite family of channels independent conditional on the state. This is an expectation over observations. It does not assert that every individual observation reduces the value of the next one.

The first question fixes the entire symmetric quadratic perturbation class
\[
 G_{\lambda,C}(p)=\lambda\sum_{i=1}^{n}p_i\log p_i-\frac12p^\top Cp,\qquad C=C^\top,
\]
using natural logarithms and \(0\log0=0\). We classify all parameters, including signed coefficients, and find the least nonnegative \(\lambda\) for each fixed \(C\). The answer has a structural part and a numerical part. For \(n\ge3\), an admissible \(C\) has the unique representation
\[
 C=\operatorname{diag}(c)+\mathbf1a^\top+a\mathbf1^\top.
\]
The affine term does not change information gains. The remaining coefficients satisfy exactly
\[
 \operatorname{diag}(c)-(3c_k-\lambda)\mathbf1\mathbf1^\top\succeq0
 \quad (k=1,\ldots,n).
\]
For fixed \(\lambda\), these equalities and affine LMIs define a convex spectrahedron; the homogeneous feasible set in \((\lambda,C)\) is a cone. Every nontrivial admissible parameter produces a strictly convex potential. If the structural test fails, increasing \(\lambda\) never repairs it. If the structure holds, a finite repair exists exactly when a simple signed quadratic optimization has a finite value, and its optimum yields the exact budget.

The second question allows an entire binary potential to change, while requiring every experiment's information gain to weakly increase. The admissible repair class is explicitly
\[
 C^2((0,1))\cap C([0,1]),
\]
with finite convex potentials. For inputs whose Bayesian curvature extends continuously to zero at both endpoints, its least concave majorant determines the unique least repair modulo affine functions, provided a weighted endpoint integral is finite. We prove both necessity and sufficiency, exact worst-case inflation, a uniform second-derivative perturbation bound, the sharp Brier example, and a smooth bounded-payment obstruction. No extension to arbitrary nonsmooth convex repairs is claimed.

These two questions share the same operational ordering but expose different obstacles. Within the quadratic family, cross interactions can be structurally impossible to repair. Within the binary smooth function class, concavifying curvature can destroy finite endpoint values. The results specify what can be designed within those two scopes.

## 2. Prior work and the boundary of the contribution

Chen and Waggoner [CW17] established the informational-substitutes framework, the role of logarithmic scoring under conditional independence, and a program of designing suitable decision problems. Our classification is a bounded refinement of that design program.

The basic curvature route is prior art. Bloedel and Zhong [BZ21, Appendix A.1.3, Lemma 9 and Example 8] explicitly give the binary criterion that \(p^2(1-p)^2G''(p)\) be concave, and announce a general-state Hessian characterization. Their accessible 2021 PDF omits the announced Appendix K proof. We supply a self-contained baseline derivation without claiming priority for the criterion. Their current paper [BZ25, Corollary 1] studies a lower sequential-learning-proof envelope of information costs; the upward information-gain repair constrained by prior-concavity here is a different optimization problem.

The posterior-Jensen and Hessian mechanism also appears explicitly in Abin and Gohari [AG26, Appendix B, Lemma 4]. Abin et al. [AZ26, Theorem 2] provide a related product-divergence sufficient condition through concavity of \(x^2f''(x)\). These methods are acknowledged dependencies, not new techniques claimed here.

Tian [T24, Definitions 1–2 and Theorems 1–2] characterizes Shannon, up to a nonnegative multiple and an affine term, among continuous uncertainty measures on at least three states under suppression of distinctions within a subset of states. Without continuity, a support-dependent diversity term is also permitted. That axiom differs from adding conditionally independent sources; our nonzero admissible quadratic examples distinguish the properties. Anunrojwong [A18] studies scoring design for fixed information structures, including linear-programming methods and Gaussian settings.

A recent binary quadratic package [P26] instead fixes the quadratic score and classifies joint signal tables. Its finite-signal sequel [PF26] gives convex completion certificates for two finite sources and a scalar quadratic prediction target. For both packages, our comparison uses the inspected repository or release statements; the complete manuscripts and checker code were not independently replayed. Shah, Mandal, and Azhar [S26] analyze localization for finite-action, piecewise-linear value functions. None of these inspected statements supplies the full symmetric perturbation region proved below.

The novelty claim is bounded: the inspected sources do not contain the complete classification and repair results stated here. This is not an exhaustive priority certification. In particular, the original proposed binary-characterization contribution was withdrawn after [BZ21] was located. The research record preserves that correction. The least-concave-majorant operation, Green representation, and Jensen order are standard tools; the contribution is their exact operational repair problem, its endpoint obstruction, and the separate full quadratic classification.


## 3. Model and the attributed curvature baseline

The following self-contained derivation records a dependency already identified in [BZ21]; the related proof mechanism is explicit in [AG26].

### 3.1. Precise framework and intrinsic curvature

Fix an integer \(n\ge2\), the probability simplex \(\Delta_n\), and its relative interior \(\Delta_n^\circ\). Write

\[
 B(p)=\operatorname{diag}(p)-pp^\top.
\]

Let \(G:\Delta_n^\circ\to\mathbb R\) be twice continuously differentiable in relative coordinates. Convexity makes it a proper-scoring potential, but the equivalence below itself uses only the stated differentiability and continuity assumptions. Define a symmetric matrix \(M_G(p)\) intrinsically by

\[
 z^\top M_G(p)z=D^2G(p)[B(p)z,B(p)z],\qquad z\in\mathbb R^n.
\tag{B1}
\]

Thus \(M_G=B\nabla^2G B\) for any compatible ambient extension. This definition is independent of the extension: both arguments of the Hessian are tangent to the simplex. In particular, \(M_G(p)\mathbf1=0\).

A finite channel \(A\) consists of nonnegative likelihoods \(a_{yi}=\Pr(A=y\mid E=i)\) with \(\sum_y a_{yi}=1\). Initially require all likelihoods to be strictly positive. For a prior \(p\), put

\[
 m_y=a_y\cdot p,\qquad q_y=\frac{\operatorname{diag}(a_y)p}{m_y},\qquad
 T_A G(p)=\sum_y m_yG(q_y),\qquad F_A(p)=T_A G(p)-G(p).
\tag{B2}
\]

For signals conditionally independent given \(E\), define \(V(S)=\mathbb E G(p_{A_S})\). Universal conditional-independent submodularity means that this set function is submodular for every finite such family, every positive prior, and every choice of finite positive channels. The score \(G\) is fixed; the channels and prior vary. This differs from a fixed information structure being substitutable for every possible decision problem.

### 3.2. Complete multistate criterion

**Baseline proposition (attributed; not claimed new).** The following conditions are equivalent.

1. Universal conditional-independent submodularity holds for \(G\).
2. It holds for every pair of finite positive channels.
3. For every finite positive channel \(A\), the gain \(F_A\) is concave on \(\Delta_n^\circ\).
4. \(M_G\) is matrix concave on \(\Delta_n^\circ\):
   \[
   M_G\Big(\sum_j\lambda_jq_j\Big)\succeq\sum_j\lambda_jM_G(q_j)
   \tag{B3}
   \]
   for every finite interior posterior split, with nonnegative weights summing to one.
5. Submodularity holds for every pair of binary positive channels, at every positive prior.

If \(G\) extends continuously and finitely to \(\Delta_n\), these equivalent conditions also imply the same property for zero channel entries and for boundary priors.

#### Proof of the gain-concavity equivalence

Conditional independence gives

\[
 V(A,B)-V(A)=\mathbb E_A F_B(p_A).
\tag{B4}
\]

Every finite interior posterior split \(p=\sum_j\lambda_jq_j\), after deleting zero-weight terms, is attainable by the positive channel

\[
 \Pr(A=j\mid E=i)=\frac{\lambda_jq_{ji}}{p_i}.
\tag{B5}
\]

Consequently, the two-channel submodular inequality is precisely Jensen's concavity inequality for \(F_B\). Conversely, concavity of every \(F_B\), applied conditionally on an already observed signal set, gives diminishing marginal returns and hence set submodularity. This also shows that testing a binary first channel suffices to establish the concavity of \(F_B\).

#### Perspective Hessian calculation

Fix one outcome likelihood vector \(a\), and write \(m=a\cdot p\), \(q=\operatorname{diag}(a)p/m\). For a tangent vector \(v\), differentiation of the perspective gives

\[
 D^2\{mG(q)\}(p)[v,v]
 =\frac1m D^2G(q)[(\operatorname{diag}(a)-qa^\top)v,
                         (\operatorname{diag}(a)-qa^\top)v].
\tag{B6}
\]

The cancellation of the first-derivative terms is exact. Parameterize a tangent direction as \(v=B(p)z\), possible for every tangent \(v\) because \(p_i>0\). Then

\[
 (\operatorname{diag}(a)-qa^\top)B(p)z=mB(q)z.
\tag{B7}
\]

Combining (B1), (B6), and (B7) yields the exact identity

\[
 D^2F_A(p)[B(p)z,B(p)z]
 =z^\top\left(\sum_y m_yM_G(q_y)-M_G(p)\right)z.
\tag{B8}
\]

Every posterior split is realized by (B5), so concavity of all \(F_A\) is equivalent to (B3). This proof needs only \(C^2\) regularity of \(G\), not four derivatives.

#### Why two binary channels detect every failure

Suppose matrix concavity fails. Since matrix concavity is equivalent to concavity of each scalar function \(p\mapsto z^\top M_G(p)z\), it has a two-point Jensen failure. The corresponding two-point posterior split defines a binary channel \(B\) by (B5). Identity (B8) then gives a positive directional Hessian of \(F_B\) at the mixture prior. A sufficiently short symmetric posterior split in that direction defines a second binary channel \(A\). The channels are sampled independently conditional on \(E\). Their submodular inequality fails. All probabilities are strictly positive when the split points are interior. This proves the equivalence with condition 5.

If one begins with a differential failure of matrix concavity at \(p\), tangent \(v\), and vector \(z\), a constructive version is:

\[
 B(\pm\mid i)=\frac{p_i\pm tv_i}{2p_i},\qquad
 A(\pm\mid i)=\frac{p_i\pm s[B(p)z]_i}{2p_i}.
\tag{B9}
\]

First take sufficiently small \(t>0\) so the Jensen gap of \(M_G\) is positive in direction \(z\); then take sufficiently small \(s>0\) so the Jensen gap of \(F_B\) is positive. This order of choices matters. Formula (B9) is a real finite witness construction, not an assertion that the finite gap has the same sign at arbitrary \(s,t\).

#### Boundary extension

For channels with zero entries, mix each channel with an independent positive noise channel. For boundary priors, mix the prior with the uniform distribution. Apply the positive, interior result and let the mixing parameters tend to zero. Finite continuity of \(G\) on the compact simplex makes every term converge. Without this boundary-continuity hypothesis, the theorem is stated only for positive priors and positive channels; extended-real boundary manipulations require separate assumptions.

### 3.3. Precisely scoped randomized disclosure implication

Let \(X_1,\ldots,X_m\) be conditionally independent given \(E\). Let \(A,B\subseteq[m]\), \(C=A\cap B\), and let \(Y\) be a randomized garbling of \(X_A\), generated using additional randomness independent of \((E,X_1,\ldots,X_m)\), which retains \(X_C\). Equivalently, one may replace \(Y\) by \((Y,X_C)\) explicitly. If (B3) holds, then

\[
 V(Y,X_B)-V(Y)\ \ge\ V(X_A,X_B)-V(X_A).
\tag{B10}
\]

To prove this, fix \(X_C=c\) and regard \(X_{B\setminus A}\) as one product channel. Given \(E\), it remains independent of \(X_{A\setminus B}\) and of the garbling randomness. Its gain is therefore the same concave function of the current posterior on both sides. Moreover,

\[
 p_{Y,c}=\mathbb E[p_{X_A,c}\mid Y,c].
\]

Conditional Jensen followed by averaging proves (B10). This is a precisely scoped averaged partial-disclosure inequality. It does not assert submodularity for arbitrary pairs of separately garbled joint signals on the entire continuous lattice.

This averaged inequality is not pointwise adaptive submodularity. The guarantee is after expectation over the new information.

### 3.4. Binary specialization

Write a binary prior as \((p,1-p)\), and identify its potential with a scalar function \(g(p)\). For \(s=p(1-p)\), one has \(B(p)z=s(z_1-z_2)(1,-1)\). Consequently
\[
 M_g(p)=s(p)^2g''(p)
 \begin{pmatrix}1&-1\\-1&1\end{pmatrix}.
 \tag{B11}
\]
The fixed matrix is positive semidefinite and nonzero. The baseline proposition therefore says exactly that universal substitution is equivalent to concavity of \(h_g(p)=s(p)^2g''(p)\), which is the criterion expressly stated in [BZ21, Example 8]. This calculation proves the particular normalization used in the binary sections below.


## 4. All symmetric quadratic perturbations

### 4.1. Main theorem

Fix \(n\ge3\), a real symmetric \(n\times n\) matrix \(C\), and a real number \(\lambda\). On the simplex \(\Delta_n\), define

\[
 G_{\lambda,C}(p)=\lambda\sum_i p_i\log p_i-\tfrac12 p^\top Cp,
 \qquad 0\log0=0.
\tag{Q1}
\]

The universal property means that, for every prior and every finite family of signals conditionally independent given the state, the expected score of the posterior is a submodular function of the observed signal subset. Scores are identified up to affine functions on the simplex, which do not change information gains.

**Theorem Q.** The universal property holds if and only if both of the following conditions hold.

1. There are real vectors \(a,c\) such that
   \[
   C=\operatorname{diag}(c)+\mathbf1a^\top+a\mathbf1^\top.
   \tag{Q2}
   \]
2. Writing \(m=\max_i c_i\),
   \[
   \operatorname{diag}(c)-(3m-\lambda)\mathbf1\mathbf1^\top\succeq0.
   \tag{Q3}
   \]

For \(n\ge3\), the vectors \(a,c\) in (Q2), if they exist, are unique. The complete parameter region is equivalently given by the linear equalities in (Q2) and the \(n\) affine LMIs

\[
 \operatorname{diag}(c)-(3c_k-\lambda)\mathbf1\mathbf1^\top\succeq0,
 \qquad k=1,\ldots,n.
\tag{Q4}
\]

Every nontrivial admissible score has \(\lambda>0\) and is strictly convex on the simplex interior. If \(\lambda=0\), admissibility forces \(c=0\), so the score is affine and all information gains vanish. No \(\lambda<0\) is admissible.

If either structural condition or the LMI fails, two strictly positive binary channels at an interior prior already violate submodularity. No infinite channel alphabet, degenerate prior, or zero likelihood is required.

The theorem classifies all quadratic perturbations of the logarithmic score, not just separable or positive perturbations. For \(n=3\), (Q2) is automatic; for \(n\ge4\), it is a real rigidity constraint.

### 4.2. General matrix derivative identity

For the family (Q1), the intrinsic information curvature from Section 3 is
\[
 M_{\lambda,C}(p)=\lambda B(p)-B(p)CB(p).
 \tag{Q6}
\]
Indeed \(B(p)\operatorname{diag}(1/p_i)B(p)=B(p)\); affine changes vanish because \(B(p)\mathbf1=0\).

Fix \(p\in\Delta_n^\circ\), a tangent direction \(v\) with \(\mathbf1^\top v=0\), and any \(z\in\mathbb R^n\). Put

\[
 x=z-(p\cdot z)\mathbf1,\quad d=v\cdot x,\quad
 y=v\odot x,\quad w=p\odot x=B(p)z.
\]

Here \(\odot\) is coordinatewise multiplication. We have \(p\cdot x=0\) and \(\sum_i y_i=d\). Along \(p+tv\), with \(z\) and \(v\) fixed,

\[
 x'=-d\mathbf1,\qquad w'=y-dp,\qquad w''=-2dv.
\]

Differentiating \(z^\top Mz=\lambda\operatorname{Var}_p(z)-w^\top Cw\) therefore gives

\[
 \boxed{\ \tfrac12 z^\top D^2M(p)[v,v]z
 =-\lambda d^2-(y-dp)^\top C(y-dp)+2d\,w^\top Cv.\ }
\tag{Q7}
\]

This identity uses symmetry of \(C\) and no coefficient sign assumptions.

### 4.3. Four-state rigidity

Assume matrix concavity from the attributed baseline proposition in Section 3. At the uniform prior \(p=\mathbf1/n\), take any two tangent vectors \(u,v\) with disjoint supports. Define

\[
 x(\tau)=nu+\tau v,\qquad z=x(\tau).
\]

The centering condition holds because \(u,v\) are tangent. Since their supports are disjoint,

\[
 d=\tau\|v\|_2^2,\quad y=\tau(v\odot v),\quad
 w=u+\tfrac\tau n v.
\]

Substituting into (Q7) gives a polynomial in \(\tau\) whose linear coefficient is

\[
 2\|v\|_2^2 u^\top Cv.
\tag{Q8}
\]

All remaining terms have order \(\tau^2\). Concavity requires the polynomial to be nonpositive for both signs of every sufficiently small \(\tau\). Thus \(u^\top Cv=0\). With \(u=e_i-e_j\) and \(v=e_k-e_\ell\) for four distinct indices, we obtain

\[
 C_{ik}-C_{i\ell}-C_{jk}+C_{j\ell}=0.
\tag{Q9}
\]

This obstruction is independent of \(\lambda\). Consequently, no finite multiple of Shannon entropy can repair a matrix that violates (Q9).

#### Algebraic completeness of the rigidity condition

For \(n\ge4\), (Q9) is equivalent to off-diagonal additive separability \(C_{ij}=a_i+a_j\) for \(i\ne j\). Define

\[
 a_1=\tfrac12(C_{12}+C_{13}-C_{23}),\quad
 a_2=\tfrac12(C_{12}+C_{23}-C_{13}),\quad
 a_3=\tfrac12(C_{13}+C_{23}-C_{12}),
\tag{Q10}
\]

and \(a_k=C_{1k}-a_1\) for \(k\ge4\). Applying (Q9) on \(\{1,2,3,k\}\) gives \(C_{2k}=a_2+a_k\) and \(C_{3k}=a_3+a_k\). For distinct \(k,\ell\ge4\), applying (Q9) on \(\{1,2,k,\ell\}\) gives \(C_{k\ell}=a_k+a_\ell\). The original three pairs satisfy the formula by construction. Conversely, additive off-diagonal entries plainly satisfy every four-point equality.

For \(n=3\), equations (Q10) already represent all three off-diagonal entries, with no rigidity condition required. In every dimension \(n\ge3\), put \(c_i=C_{ii}-2a_i\). This proves (Q2). Uniqueness follows because if \(b_i+b_j=0\) for every distinct pair, then any triple gives every \(b_i=0\).

#### The affine gauge is exact

On the simplex,

\[
 \tfrac12p^\top(\mathbf1a^\top+a\mathbf1^\top)p=a^\top p.
\]

Hence (Q1) differs from its diagonal representative by the affine function \(-a^\top p\). Expected-posterior affine terms are fixed by the prior, so every information gain and every submodular difference is unchanged. Also \(B\mathbf1=0\), so the information curvature matrices agree exactly.

### 4.4. Exact signed diagonal region

It remains to consider \(C=D=\operatorname{diag}(c)\). With the notation of (Q7), algebra gives

\[
 \tfrac12z^\top D^2M(p)[v,v]z
 =-\lambda d^2+3d^2\sum_i c_ip_i^2
                 -\sum_i c_i(y_i-2dp_i)^2.
\tag{Q11}
\]

#### Sufficiency

Assume (Q3), with \(h=3m-\lambda\). Testing the LMI on \(e_i-e_j\) gives \(c_i+c_j\ge0\), so \(m\ge0\). Since \(q=y-2dp\) has coordinate sum \(-d\),

\[
 q^\top Dq\ge h d^2.
\]

Also \(\sum_i c_ip_i^2\le m\sum_i p_i^2\le m\). Formula (Q11) is therefore at most \((-\lambda+3m-h)d^2=0\). This proves matrix concavity, including directions with \(d=0\).

Testing the LMI on \(\mathbf1\) gives

\[
 n^2(3m-\lambda)\le\sum_i c_i\le nm,
 \qquad m\le\frac{n\lambda}{3n-1}.
\tag{Q12}
\]

Thus \(\lambda\ge0\). If \(\lambda=0\), then \(m=0\), and the pair inequalities force all \(c_i=0\). If \(\lambda>0\), then \(m<\lambda\), and

\[
 D^2G(p)[v,v]=\sum_i(\lambda/p_i-c_i)v_i^2
 \ge(\lambda-m)\|v\|_2^2>0
\]

for nonzero tangent \(v\).

#### Necessity: realization near a vertex

Fix a vertex \(e_1\) and a generic vector \(y\in\mathbb R^n\). Let \(d=\sum_i y_i\), assume \(y_2\ne0\) and \(S=\sum_{i\notin\{2,n\}}y_i\ne0\). These exclusions are proper hyperplanes, hence harmless by density. Put

\[
 p_b=(A,b,\ldots,b),\quad A=1-(n-1)b,
\]

and

\[
 x_1=1,\quad x_2=t,\quad x_3=\cdots=x_{n-1}=1,\quad
 x_n=-\frac{A+b(t+n-3)}{b}.
\tag{Q13}
\]

Then \(p_b\cdot x=0\). We choose \(t\ne0\) so that

\[
 \sum_i y_i/x_i
 =S+y_2/t-\frac{by_n}{A+b(t+n-3)}=0.
\tag{Q14}
\]

At \(b=0\), the right side has the nonzero simple root \(t_0=-y_2/S\). Choose a small interval around that root avoiding zero. The expression converges uniformly there as \(b\downarrow0\), and the endpoint signs persist; the intermediate value theorem gives a root \(t_b\) for all sufficiently small positive \(b\). The last denominator remains nonzero on the interval. Set \(v_i=y_i/x_i\), so \(\sum_i v_i=0\) and \(v\cdot x=d\). Taking \(z=x\) realizes the prescribed product vector exactly at a positive prior.

Matrix concavity and (Q11), followed by \(b\downarrow0\), now imply

\[
 (3c_1-\lambda)d^2-\sum_i c_i(y_i-2d(e_1)_i)^2\le0.
\tag{Q15}
\]

The expression is polynomial in \(y\), so density removes the genericity assumptions. The linear map \(q=y-2(\sum_i y_i)e_1\) is an invertible reflection and satisfies \(\sum_iq_i=-d\). Consequently (Q15) is equivalent to

\[
 D-(3c_1-\lambda)\mathbf1\mathbf1^\top\succeq0.
\]

Repeating at each vertex proves (Q4), and taking a maximum coefficient proves (Q3). The growth of \(x_n\) as \(b^{-1}\) causes no gap: every vector used at every positive prior is finite, and (Q11) gives the exact finite expression whose limit is taken.

### 4.5. Exact minimum Shannon coefficient

The rigidity condition must hold first. For its unique diagonal representative \(c\), define

\[
 \beta(c)=\inf_{\mathbf1^\top q=1}\sum_i c_iq_i^2.
\tag{Q16}
\]

If \(\beta=-\infty\), no finite Shannon coefficient can stabilize the quadratic perturbation. If \(\beta\) is finite, the exact minimum is

\[
 \boxed{\ \lambda_{\min}=3\max_i c_i-\beta(c).\ }
\tag{Q17}
\]

The coefficient is finite exactly in the following cases:

| Coefficient pattern | \(\beta(c)\) |
|---|---|
| All \(c_i>0\) | \((\sum_i1/c_i)^{-1}\) |
| All \(c_i\ge0\), at least one zero | \(0\) |
| Exactly one negative, all others positive, \(\sum_i1/c_i<0\) | \((\sum_i1/c_i)^{-1}<0\) |
| Every other pattern | \(-\infty\) |

**Proof of the table.** The positive case is weighted Cauchy–Schwarz. A zero coefficient in a nonnegative vector gives value zero by putting all mass there. If there are two negative coefficients, or a negative and a zero, varying mass between those two coordinates makes the objective tend to \(-\infty\). In the remaining case write \(c_1=-a<0\), and let \(H_+=(\sum_{i>1}1/c_i)^{-1}>0\). After fixing \(q_1=t\), minimization over the positive coordinates gives

\[
 -a t^2+H_+(1-t)^2
 =(H_+-a)t^2-2H_+t+H_+.
\]

This has a finite infimum if and only if \(H_+>a\), equivalently \(\sum_i1/c_i<0\). Its minimum is the stated reciprocal. If \(H_+=a\), the quadratic coefficient vanishes but the linear coefficient is nonzero, so the infimum is still \(-\infty\); treating this critical case as finite would be incorrect.

To connect (Q16) to the LMI, a finite \(\beta\) implies \(q^\top Dq\ge\beta(\mathbf1^\top q)^2\) for vectors with nonzero sum by scaling; vectors of sum zero satisfy the limiting inequality by continuity. Conversely the LMI bounds the infimum in (Q16). This proves (Q17).

### 4.6. Low-dimensional and equal-weight consequences

For equal weights \(c_i=c\) and \(n\ge3\), the exact range is

\[
 0\le c\le\frac{n\lambda}{3n-1}.
\]

A common nonnegative coefficient works in every finite dimension exactly when \(c\le\lambda/3\). For \(\lambda=1\), the fixed-dimension endpoints are \(3/8,4/11,5/14,\ldots\), decreasing to \(1/3\).

For \(n=2\), every symmetric quadratic form is, modulo an affine function, determined by

\[
 s=C_{11}+C_{22}-2C_{12}.
\]

The binary curvature is \(h(r)=\lambda r(1-r)-s r^2(1-r)^2\). Its second derivative is

\[
 h''(r)=-2\lambda-2s+12s r(1-r).
\]

Thus the exact binary range is \(-\lambda\le s\le2\lambda\), which also forces \(\lambda\ge0\). The minimum nonnegative coefficient is \(\max\{s/2,-s\}\). In the equal-weight notation \(C=cI\), this becomes \(-\lambda/2\le c\le\lambda\). The full-matrix LMI in Theorem Q is deliberately not asserted for \(n=2\).

### 4.7. Explicit structural obstruction

In four states, let \(C_{13}=C_{31}=\varepsilon>0\) and every other entry be zero. For \(0<\varepsilon<1\), \(G_{1,C}\) is strictly convex on the whole interior because \(\nabla^2G=\operatorname{diag}(1/p_i)-C\succeq(1-\varepsilon)I\). Nevertheless it fails the universal property.

At the uniform prior, take

\[
 v=(0,0,1,-1),\qquad x=(4,-4,\varepsilon/2,-\varepsilon/2),\qquad z=x.
\]

Using (Q7) with \(\lambda=1\) gives exactly

\[
 \tfrac12 z^\top D^2M(p)[v,v]z
 =\varepsilon^2+\varepsilon^3/8>0.
\tag{Q18}
\]

For any other finite \(\lambda\), replacing \(\varepsilon/2\) in \(x\) by a sufficiently small same-sign parameter again leaves a positive linear term against quadratic corrections. This is the sharp qualitative failure of adding more Shannon weight to repair a nonseparable cross perturbation.


## 5. The least finite binary repair

### 5.1. Information-gain order

For a finite channel A with prior p, write I_G(p,A)=E[G(p_A)]−G(p). Define K to dominate G in information gain when I_K(p,A)≥I_G(p,A) for every prior and every finite channel. This holds if and only if K−G is convex. Sufficiency is Jensen. For necessity, any two-point posterior split p=θq+(1−θ)r is implemented by conditional probabilities θq/p and θ(1−q)/(1−p) for its first outcome when 0<p<1; the second outcome is the complement. Testing all such splits gives convexity. Boundary cases follow by continuity. In the C² class, the condition is K''≥G'' on the open interval.

Normalize every potential by subtracting the affine chord joining its endpoint values, so G(0)=G(1)=0. Each normalized convex potential is nonpositive. Its binary Bayesian curvature is

\[
s(p)=p(1-p),\qquad h_G(p)=s(p)^2G''(p).
\]

The known prior-concavity criterion says that universal conditional-independent submodularity is equivalent to concavity of h_G. It is reproduced with a proof in the manuscript's baseline section. Thus information domination is equivalent to pointwise domination of these curvature functions.

### 5.2. Green representation and the correct endpoint condition

Define the interval Green kernel

\[
K(p,t)=\min(p,t)-pt.
\]

For nonnegative continuous h on (0,1), let

\[
J(h)=\int_0^1\frac{h(t)}{t(1-t)}\,dt.
\]

If J(h)<∞, then

\[
G_h(p)=-\int_0^1K(p,t)\frac{h(t)}{t^2(1-t)^2}\,dt
\tag{R1}
\]

defines a finite continuous convex potential on [0,1], vanishing at both endpoints and satisfying G_h''(p)=h(p)/s(p)^2. Indeed, 0≤K(p,t)≤t(1-t), so the integrand is bounded by the integrable function h(t)/s(t). Dominated convergence gives endpoint continuity. On the interior, split the integral at p:

\[
G_h(p)=-(1-p)\int_0^p\frac{h(t)}{t(1-t)^2}\,dt
       -p\int_p^1\frac{h(t)}{t^2(1-t)}\,dt.
\tag{R2}
\]

Differentiation gives G_h'=A−B for the two integrals A and B in (R2), and then the stated second derivative. The potential is uniquely determined up to an affine function by its second derivative, and endpoint normalization fixes the affine ambiguity.

Conversely, for every normalized finite continuous convex C² potential G,

\[
\int_0^1s(t)G''(t)\,dt=-2\int_0^1G(t)\,dt<\infty.
\tag{R3}
\]

To justify endpoint integration by parts, convex secant bounds imply tG'(t)→0 as t↓0: both G(t)−G(0)≤tG'(t) and tG'(t)≤G(2t)−G(t) tend to zero. The reflected bounds apply at 1. Integrate by parts twice on [ε,1−ε], use these limits and continuity of G, and let ε↓0. The nonnegative integrand allows monotone convergence. Therefore h_G has J(h_G)<∞, and (R1) reconstructs G.

If h_G is also concave, its one-sided endpoint limits exist, are finite and nonnegative, and must both equal zero. Finiteness follows, for example, by writing a fixed interior point as a convex combination of a point approaching the endpoint and another fixed interior point; nonnegativity gives a uniform upper bound. A positive endpoint limit would make J(h_G) infinite. This proves that every finite continuous universally substitutable potential has a concave curvature extending continuously by zero at the endpoints.

### 5.3. The least finite repair, and when it exists

Assume the input \(G_0\) is finite, continuous and convex on \([0,1]\), belongs to \(C^2((0,1))\), and has curvature \(h_0=s^2G_0''\) extending continuously to \([0,1]\) with \(h_0(0)=h_0(1)=0\). Its \(J(h_0)\) is finite by (R3). Let \(H\) be the least concave majorant of \(h_0\) on \([0,1]\). Equivalently,

\[
H(p)=\max_{0\le a\le p\le b\le1}
\left\{\frac{b-p}{b-a}h_0(a)+\frac{p-a}{b-a}h_0(b)\right\},
\tag{R4}
\]

with the degenerate choice a=b=p interpreted as h0(p).

Existence and the formula follow by taking the upper boundary of the compact convex hull of the graph of h0 in the plane. At an interior horizontal coordinate, a supporting line to the upper hull reduces an attaining convex combination to at most two graph points. Mixing attaining distributions proves concavity directly. Every concave majorant dominates every such chord. Compactness also gives H(0)=H(1)=0 and continuity at the endpoints; continuity on the interior follows from concavity. In particular, H is finite and nonnegative, but its weighted integral need not be finite.

**Theorem R (finite repair criterion).** Under the input assumptions above, there exists a finite convex universally substitutable potential \(K\in C^2((0,1))\cap C([0,1])\) that dominates \(G_0\) in every information gain if and only if \(J(H)<\infty\). If it exists, the uniquely normalized least such repair is \(G^*=G_H\) from (R1), and every admissible repair \(K\) satisfies \(I_K(p,A)\ge I_{G^*}(p,A)\) for every prior and finite channel.

Proof. An admissible K has nonnegative concave curvature h_K≥h0. Consequently h_K≥H. Its finite endpoint values give J(h_K)<∞, so necessarily J(H)<∞. Conversely, finite J(H) makes G_H a legitimate finite potential by (R1), and its concave curvature makes it substitutable. The pointwise inequality H≥h0 implies G_H−G0 convex, hence information domination. For any other repair, h_K≥H implies K−G_H convex, proving the least property. Two least elements have equal information gains; their difference is both convex and concave, hence affine. The chosen normalization makes them identical.

The theorem is explicitly about the stated smooth-potential class. It does not claim an unproved characterization of arbitrary nonsmooth convex potentials. It covers all finite signals, including perfectly revealing signals, because the potentials are finite continuous at both endpoints.

### 5.4. Exact worst-case additive cost of repair

Suppose a finite repair exists and normalize G0 and G*. Put

\[
D=G^*-G_0,\qquad
R(p)=-D(p)=\int_0^1K(p,t)\frac{H(t)-h_0(t)}{t^2(1-t)^2}\,dt.
\tag{R5}
\]

The function D is convex, nonpositive, and zero at both endpoints. For every channel,

\[
0\le I_{G^*}(p,A)-I_{G_0}(p,A)
=E[D(p_A)]-D(p)\le R(p).
\tag{R6}
\]

Perfect revelation attains the upper bound at every p. Therefore

\[
\sup_{p,A}\{I_{G^*}(p,A)-I_{G_0}(p,A)\}
=\max_{p\in[0,1]}R(p).
\tag{R7}
\]

Since every admissible repair information-dominates G*, this is also the minimum possible worst-case additive inflation over all admissible repairs. The least repair has the stronger pointwise optimality, not merely this minimax property.

### 5.5. Regular input scores and finite-precision stability

If \(G_0''\) is nonnegative and continuous on \([0,1]\), put \(W=\lVert G_0''\rVert_\infty\). Then

\[
h_0(p)\le W s(p)^2\le\frac W4s(p).
\]

The right side is a concave majorant, so H≤(W/4)s and J(H)≤W/4<∞. Thus every bounded-curvature input in this class has a finite least repair, despite the failure of such existence for general finite continuous smooth-interior inputs.

There is a useful rigorous approximation guarantee. Suppose two second-derivative inputs \(w,\widetilde w\in C([0,1];[0,\infty))\) satisfy \(\lVert w-\widetilde w\rVert_\infty\le\varepsilon\). Let \(H\) and \(\widetilde H\) be the least concave majorants of \(s^2w\) and \(s^2\widetilde w\). The inequalities

\[
h\le\widetilde h+\frac\varepsilon4s,
\qquad
\widetilde h\le h+\frac\varepsilon4s
\]

and minimality of the two majorants imply

\[
|H-\widetilde H|\le\frac\varepsilon4s.
\tag{R8}
\]

Let \(L(p)=p\log p+(1-p)\log(1-p)\). The second-derivative bounds in (R8) say that \((\varepsilon/4)L\pm(G^*-\widetilde G^*)\) are convex. Hence for every finite experiment,

\[
|I_{G^*}(p,A)-I_{\widetilde G^*}(p,A)|
\le\frac\varepsilon4 I_L(p,A)
\le\frac{\varepsilon\log2}{4}.
\tag{R9}
\]

This is a uniform error guarantee in the operational information-gain metric. It follows from a certified uniform approximation to the input second derivative. It is not a claim that arbitrary numerical samples certify such a bound, or that the constant is sharp.

### 5.6. Exact minimal repair of squared-error scoring

For the canonical binary squared-error reward, take the normalized potential

\[
G_0(p)=p^2-p,\quad G_0''=2,\quad h_0(p)=2p^2(1-p)^2.
\]

Its least concave majorant is

\[
H(p)=
\begin{cases}
\frac8{27}p,&0\le p\le\frac13,\\
2p^2(1-p)^2,&\frac13\le p\le\frac23,\\
\frac8{27}(1-p),&\frac23\le p\le1.
\end{cases}
\tag{R10}
\]

Proof: h0(p)/p=2p(1−p)² has its global maximum 8/27 at p=1/3; the reflected ratio has its maximum at 2/3. Thus the outer lines majorize h0, and their derivatives match the middle branch at the contact points. The middle branch has h0''=4−24p+24p²≤0 on [1/3,2/3], so the displayed function is concave. Every concave majorant must dominate the chord joining (0,0) to (1/3,8/81), must dominate h0 in the middle, and must dominate the reflected endpoint chord. This proves leastness.

The normalized least repaired potential is

\[
G^*(p)=
\begin{cases}
\frac8{27}p\log\frac{2p}{1-p}-\frac79p,&0<p\le\frac13,\\
p^2-p-\frac1{27},&\frac13\le p\le\frac23,\\
G^*(1-p),&\frac23\le p<1,\\
0,&p\in\{0,1\}.
\end{cases}
\tag{R11}
\]

The reflected branch in (R11) always refers to the first branch. Direct differentiation gives G*''=H/s². Values and first derivatives match at 1/3 and 2/3; second derivatives also match because H is continuous. The formula has finite zero limits at the endpoints. Therefore it is exactly the Green reconstruction and not merely a candidate approximation.

On [1/3,2/3], D=G*−G0=−1/27. On the outer intervals D''≥0, D' joins zero at the inner endpoints, and D is zero at the outer endpoints. Consequently

\[
\max_pR(p)=\frac1{27}.
\tag{R12}
\]

Thus 1/27 is the exact minimum worst-case additive increase in information gain needed to repair binary squared-error scoring within the stated class. It is attained by every perfectly revealing experiment whose prior lies in [1/3,2/3]. At p=1/2, the repaired perfect-revelation gain is 31/108, versus the original 1/4. These are expected-score quantities; the repaired per-outcome score is unbounded below near a confidently wrong report.

### 5.7. No nontrivial bounded-payment rule in the universal class

For a finite convex binary potential \(G\in C^2((0,1))\cap C([0,1])\), the interior reward scores are

\[
S(p,1)=G(p)+(1-p)G'(p),\qquad S(p,0)=G(p)-pG'(p).
\]

If \(G\) is universally substitutable and nonaffine, its concave curvature \(h\) is positive at some \(p_0\). Section 5.2 gives \(h(0)=h(1)=0\). Concavity then implies \(h(p)\ge ap\) near zero and \(h(p)\ge b(1-p)\) near one, for positive constants \(a,b\). Thus \(G''(p)\ge a/p\) near zero and \(G''(p)\ge b/(1-p)\) near one. Integration gives \(G'(p)\to-\infty\) at zero and \(G'(p)\to+\infty\) at one. Since \(G\) has finite endpoints, \(S(p,1)\to-\infty\) as \(p\downarrow0\), while \(S(p,0)\to-\infty\) as \(p\uparrow1\). Each outcome-specific score therefore has an unbounded wrong-report penalty. The affine zero-information case is the only exception within this class.

This conclusion concerns per-outcome score payments. It does not say that G or the information cost is unbounded; both can be bounded, as for the logarithmic score and the repair in (R11).


## 6. A smooth bounded-payment input with no finite smooth repair

**Theorem O.** There exists a strictly convex potential \(G_0\in C^\infty((0,1))\cap C^1([0,1])\), with \(G_0''\ge1\) and bounded continuous proper-score payments, whose curvature extends continuously by zero at both endpoints, but which admits no universally substitutable information-dominating repair in \(C^2((0,1))\cap C([0,1])\).

Choose the standard smooth bump

\[
\psi(x)=
\begin{cases}
\exp\left(1-\dfrac1{1-x^2}\right),&|x|<1,\\
0,&|x|\ge1.
\end{cases}
\]

Then \(\psi\in C^\infty(\mathbb R)\), \(0\le\psi\le1\), \(\psi(0)=1\), and every derivative vanishes at \(x=\pm1\).

For integers \(n\ge2\), put

\[
p_n=e^{-n^2},\qquad
a_n=n^{-2},\qquad
\delta_n=\frac14p_ne^{-n^4},
\qquad
b_n(p)=a_n\psi\left(\frac{p-p_n}{\delta_n}\right).
\]

Define, for \(0<p<1\),

\[
h(p)=s(p)^2+\sum_{n=2}^{\infty}b_n(p),\qquad h(0)=h(1)=0. \tag{O1}
\]

The positive baseline \(s^2\) ensures strict convexity of the eventual original potential. It is not needed for the divergence obstruction.

### 6.1. The bump supports are disjoint and approach only zero

Since \(\delta_n\le p_n/4\), each support lies in

\[
I_n=[p_n-\delta_n,p_n+\delta_n]
\subseteq[3p_n/4,5p_n/4].
\]

Also

\[
\frac{p_{n+1}}{p_n}=e^{-(2n+1)}\le e^{-5}<\frac35.
\]

Consequently \((5/4)p_{n+1}<(3/4)p_n\), so \(I_{n+1}\) lies strictly to the left of \(I_n\). In particular, the supports are disjoint. Since \(p_n\to0\), the only accumulation point of the supports in \([0,1]\) is zero. All supports lie below \((5/4)e^{-4}<1/2\).

### 6.2. Interior smoothness and endpoint continuity

On each compact subinterval of \((0,1)\), only finitely many \(I_n\) occur. Thus the sum in (O1) is locally finite, and \(h\in C^\infty((0,1))\). Disjointness also means that at most one bump is nonzero at any given point.

As \(p\downarrow0\), the indices of any active bumps tend to infinity and their heights satisfy \(a_n\to0\). The baseline \(s^2\) also tends to zero. Hence \(h(p)\to0\). Near one there are no bumps, so \(h=s^2\to0\). Therefore \(h\in C([0,1])\), with the declared zero endpoint values. Moreover, \(h(p)>0\) for every \(p\in(0,1)\).

### 6.3. The original weighted curvature integral is finite

The baseline contributes

\[
\int_0^1\frac{s(p)^2}{s(p)}\,dp=\int_0^1s(p)\,dp=\frac16.
\]

For \(p\in I_n\), we have \(p\ge3p_n/4\) and \(1-p\ge1/2\), hence

\[
\frac1{s(p)}\le\frac{8}{3p_n}.
\]

Using \(0\le b_n\le a_n\) and the support length \(2\delta_n\),

\[
\int_0^1\frac{b_n(p)}{s(p)}\,dp
\le \frac{16a_n\delta_n}{3p_n}
=\frac43\frac{e^{-n^4}}{n^2}.
\]

Tonelli's theorem therefore gives

\[
\int_0^1\frac{h(p)}{s(p)}\,dp
\le\frac16+\frac43\sum_{n=2}^{\infty}\frac{e^{-n^4}}{n^2}<\infty. \tag{O2}
\]

Define \(G=G_h\) by (R1); this is the input \(G_0\) in Theorem O. The Green construction in Section 5.2 gives

\[
G\in C^\infty((0,1))\cap C([0,1]),\quad
G(0)=G(1)=0,\quad
G''(p)=1+\frac{\sum_n b_n(p)}{s(p)^2}\ge1.
\]

Thus \(G\) is finite and strictly convex, with a smooth interior, and its binary kernel is exactly (O1). In particular the example does not rely on a nonstrictly proper score or flat pieces of the potential.

We next verify the claimed boundedness of the input's realized score payments. On \(I_n\),

\[
\frac1{s(p)^2}\le\frac{64}{9p_n^2},
\]

so

\[
\int_0^1\frac{b_n(p)}{s(p)^2}\,dp
\le\frac{128a_n\delta_n}{9p_n^2}
=\frac{32}{9}\frac{e^{-n^4+n^2}}{n^2}.
\]

Consequently \(\int_0^1G''(p)\,dp<\infty\). The derivative formula obtained from (R1),

\[
G'(p)=\int_0^p tG''(t)\,dt-\int_p^1(1-t)G''(t)\,dt,
\]

therefore extends continuously to both endpoints. Thus \(G\in C^1([0,1])\), and the proper reward scores

\[
S_0(p)=G(p)-pG'(p),\qquad S_1(p)=G(p)+(1-p)G'(p)
\]

extend continuously to \([0,1]\) and are bounded there. The obstruction below therefore occurs even for an original strictly proper score with bounded continuous payments. What necessarily becomes infinite in any dominating substitute repair is its endpoint entropy, a stronger failure than merely losing bounded realized payments.

### 6.4. Every concave majorant has divergent weighted curvature

Let \(L:(0,1)\to\mathbb R\) be any finite concave function with \(L\ge h\). At each peak center,

\[
L(p_n)\ge h(p_n)\ge a_n.
\]

Concavity on \([p_{n+1},p_n]\), together with \(a_n\ge a_{n+1}\), gives

\[
L(p)\ge a_{n+1}\qquad (p_{n+1}\le p\le p_n).
\]

Since \(1/s(p)\ge1/p\),

\[
\begin{aligned}
\int_0^1\frac{L(p)}{s(p)}\,dp
&\ge\sum_{n=2}^{\infty}\int_{p_{n+1}}^{p_n}\frac{a_{n+1}}p\,dp\\
&=\sum_{n=2}^{\infty}\frac1{(n+1)^2}\log\frac{p_n}{p_{n+1}}\\
&=\sum_{n=2}^{\infty}\frac{2n+1}{(n+1)^2}
=\infty.
\end{aligned} \tag{O3}
\]

The last series diverges because its terms are at least \(1/(n+1)\). The intervals are disjoint up to endpoints, so the sum of integrals is valid.

In particular, (O3) applies to the least concave majorant \(H=\operatorname{cav}h\). By Theorem R, the smooth finite strictly convex \(G\) just constructed admits **no finite-endpoint universally substitute repair** that dominates all of its experiment gains, within the stated \(C^2\) class.

The obstruction is at the left endpoint: any antiderivative with curvature \(L/s^2\) has limit \(+\infty\) as \(p\downarrow0\), by the endpoint-integrability argument and (O3). No affine normalization can remove that divergence.


## 7. Exact finite certificates and interpretation

The accompanying Python standard-library scripts enumerate posterior probabilities with rational arithmetic. They use the sign convention
\[
 \Delta=V(A,B)-V(A)-V(B)+V(\varnothing);
\]
a positive value violates submodularity. The first script checks ten equal-coefficient failures. The second checks seven admissible LMI examples by every principal minor, four finite failures for general matrices, and invariance under the affine gauge.

For two binary outputs with uniform marginals and correlation \(r\), the Shannon interaction under conditional independence is \(-I(A;B)\), with
\[
 I(A;B)=\sum_{k\ge1}\frac{r^{2k}}{(2k)(2k-1)}.
\]
The tail beyond \(K\) terms is nonnegative and at most
\[
 \frac{r^{2K+2}}{(2K+2)(2K+1)(1-r^2)}.
\]
Thus every reported sign has a rational enclosure. Decimal output is for readability and does not decide acceptance.

The examples include a three-state equal-weight failure at \(c=2/5\), a nonseparable four-state cross perturbation at Shannon weights \(1\) and \(100\), an inadmissible unequal positive diagonal, and a critical signed diagonal with \(\sum_i1/c_i=0\), again at weight \(100\). Their numerical magnitudes can be very small, which is why ordinary floating-point cancellation is inadequate. These certificates verify the listed finite cases; the universal theorem rests on the analytic proof.

Admissibility reduces to the displayed finite linear equalities and PSD tests, without optimization over signal alphabets or priors. This mathematical reduction does not assert a uniform polynomial-time algorithm for producing all positive-channel witnesses or for arbitrary real-number encodings. The repair result compares expected information gains, not pointwise score payments. A finite potential may have unbounded wrong-outcome penalties.

## 8. Scope, assurance, and remaining formalization

The manuscript covers finite state spaces and finite signals, with boundary priors and zero likelihoods admitted by finite continuity. The quadratic theorem classifies every symmetric \(C\) in each dimension, and the binary repair theorem is restricted to the stated smooth finite-potential class. The one-state case is trivial: the simplex is a point and every information gain vanishes for all \(\lambda,C\). The two-state exception is treated separately from the \(n\ge3\) matrix theorem.

The results do not solve general nonlinear multistate scoring design, arbitrary correlated-source substitution, pointwise adaptive submodularity, or repair by arbitrary nonsmooth convex potentials. The literature comparison records actual inspected versions and the unavailability of the older Appendix K proof. Internal mathematical review and research-value assessment do not constitute external peer review.

Full formalization remains required by repository policy. The task board must cover the finite probabilistic model, posterior implementation, the attributed curvature baseline, boundary approximation, the full matrix proof including signed and low-dimensional cases, all repair and endpoint arguments, the Brier formula and sharp constant, the smooth obstruction, and the finite certificate claims. The final integration task must check theorem scope, all owned declarations' axiom dependencies, an independent review, and reproduction from the same public source commit. No Lean file, kernel acceptance, or completed-card receipt is part of the present delivery.

## References

- **[CW17]** Yiling Chen and Bo Waggoner. *Informational Substitutes*. FOCS 2016; arXiv version 2017. [arXiv:1703.08636](https://arxiv.org/abs/1703.08636). Relevant: definitions, §5.3, §5.4, §6.4.
- **[BZ21]** Alexander W. Bloedel and Weijie Zhong. *The Cost of Optimally Acquired Information*, June 24, 2021 version. [Institutional PDF](https://www.economics.harvard.edu/sites/g/files/omnuum5991/files/econ/files/zhong_fall_2021.pdf). Relevant: Appendix A.1.3, Lemma 9, Example 8, printed pp. 66–68. The announced Appendix K proof is absent from this accessible file.
- **[BZ25]** Alexander W. Bloedel and Weijie Zhong. *The Cost of Optimally Acquired Information*, inspected PDF dated November 10, 2025. [arXiv:2511.05466](https://arxiv.org/abs/2511.05466). Relevant: Corollary 1 and the sequential learning map.
- **[AG26]** Hamidreza Abin and Amin Gohari. *On the Subadditivity of Mutual f-Information*, 2026. [arXiv:2610.21231v1](https://arxiv.org/html/2610.21231v1). Relevant: Theorem 1, Appendix B, Lemma 4, equations (21)–(24).
- **[AZ26]** Hamidreza Abin et al. *A Class of Subadditive Information Measures and their Applications*, 2026. [arXiv:2601.15639v1](https://arxiv.org/html/2601.15639v1). Relevant: §3.1.1, Theorem 2 and Corollary 2.
- **[T24]** Jianrong Tian. *Informational Separability and Entropy*. Journal of Economic Theory 216 (2024), 105796. [DOI:10.1016/j.jet.2024.105796](https://doi.org/10.1016/j.jet.2024.105796). Relevant author manuscript dated January 19, 2024: [full text](https://www.researchgate.net/publication/377656675_Informational_Separability_and_Entropy).
- **[A18]** Jerry Anunrojwong. *Structure and Design of Informational Substitutes*. Harvard University, 2018. [Official record](https://dash.harvard.edu/entities/publication/1bf75cbb-60fb-456f-9ac0-2ad745440cc8); [official full text](https://dash.harvard.edu/server/api/core/bitstreams/7fe62f5f-715a-4282-8191-985cb8bc5cc9/content). Relevant: design chapters and Gaussian extensions.
- **[P26]** ipitchford/binary-quadratic-informational-substitutes, version 1.1.0, 2026. [Author repository](https://github.com/ipitchford/binary-quadratic-informational-substitutes). Read scope: README, citation audit and release summary; its complete manuscript and code were not independently replayed.
- **[PF26]** Anonymous. *Finite convex certificates for quadratic informational substitutes*, version 0.1.0-candidate, October 15, 2026. [Release summary](https://evidencepress.org/releases/finite-signal-quadratic-substitutes/), DOI:10.5281/zenodo.23401650. Unrefereed research candidate. Read scope: release summary and its stated finite convex criterion; the full manuscript and checker code were not independently reviewed.
- **[S26]** Nidhish Shah, Shaurjya Mandal, and Asfandyar Azhar. *All Substitution Is Local*, 2026. [arXiv:2604.01443v1](https://arxiv.org/html/2604.01443v1). Relevant: finite-action model and localization theorems; its external Lean code was not replayed.

Literature access and the broader search trail are recorded in the companion novelty audit and source manifest, dated 2026-11-25.

