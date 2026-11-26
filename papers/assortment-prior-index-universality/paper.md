---
title: "Indexability and local universality in assortment exploration"
subtitle: "A support criterion, exact priority-fitting complexity, and a finite-moment approximation"
date: "26 November 2026"
lang: en
---

# Abstract

We study the prior-dependent exploration question in the purchase-revelation assortment model of Baek, Dinev and Lykouris. Every market has two entrants, capacity two, known incumbent attractions 10 and 5, and common entrant mean and cold-start attraction 1. We identify an explicit alternating kernel for the difference between the optimal sequential exploration costs and uniformly exclude simultaneous exploration. For mean-one priors on a fixed support consisting of zero and finitely many values above 10, we prove an exact indexability criterion: a scalar priority index exists precisely when the elementary-prior comparison matrix has rank at most two. Otherwise strict optimal-decision cycles occur arbitrarily close to every full-support prior. Five common attraction values are necessary and sufficient for a cycle in this atomic class. We further realize every finite real alternating comparison matrix, up to a positive scale, with priors on a bounded common support and prescribed common moment orders. For rational input matrices and neighborhood parameters, the construction is rational and has polynomial bit complexity, yielding NP-completeness of fitting one total priority order across pair markets. A smooth version preserves any finite set of integrable features near any fixed positive reference density. Finally, a pair-dependent comparator using logarithmically many clipped moments achieves a prescribed additive regret accuracy. The results separate exact indexability and reusable-order complexity from tractable approximate pair decisions.

# 1. Question, contribution, and prior work

An exploration index assigns each new product a scalar priority computed from its own prior. Such a representation is attractive because the same product order can be reused when the competing entrant changes. In the purchase-revelation model of Baek, Dinev and Lykouris [BDL], a product has a fixed cold-start attraction before its first purchase; that purchase reveals its permanent attraction. Section 6.2 of their May 2026 version asks whether heterogeneous priors admit an optimal prior-dependent index. Their Theorem 6.3 and Appendix E already reduce the two-entrant problem to three canonical policies, and their Bernoulli examples already show that ordering only by the high outcome can fail. Those reduction and comparison results are our starting point.

We give a complete support-sensitive answer for a fixed, nontrivial subclass of the same model. The main structural statement is the following.

**Contribution statement.** For every fixed support of the form \(\{0,H_1,\ldots,H_k\}\), with distinct \(H_j>10\), the entire class of mean-one priors admits an exact scalar exploration-priority index if and only if its elementary-prior comparison matrix has rank at most two. In the complementary case, every full-support prior has arbitrarily close priors forming a strict cycle of globally optimal first exploration decisions. Five common attraction support points are necessary and sufficient for such a cycle in this class.

This criterion includes a formula for the index when one exists, an exact four-high-atom Pfaffian test, and automatic failure with at least five high atoms. Beyond classification, we show that the operational comparison matrices can realize arbitrary finite real alternating matrices under common moment constraints, even inside an arbitrarily small relative neighborhood of a common reference prior. For rational target matrices and neighborhood parameters, the finite construction is rational and has polynomial bit complexity in the explicit input model of Theorem 4.1. Consequently, fitting one priority order across many two-entrant markets is NP-complete in an exact rational-input model. A smooth construction preserves arbitrary finitely many integrable features of a fixed baseline. A separate approximation theorem shows why these exact statements do not imply difficulty at fixed additive accuracy.

The general mathematical ingredients have substantial precedents. Fishburn's skew-symmetric bilinear utility theory [F82, F84] explicitly permits comparisons between distributions that are not representable by one scalar utility. His transitive representation [F83] uses two linear functionals and their cross-product comparison; Chew's weighted-utility work [C83] is another classical antecedent. We do not claim that alternating preference forms or rank-two ratio representations are new. Nontransitive dice have a much older history; Sah and Sawhney [SS24], including their Proposition 8.3, provide a particularly relevant equal-mean tournament comparison. Arbitrary tournaments among random objects are therefore not our abstract contribution. The contribution is the precise connection to globally optimal assortment decisions, its support classification, constrained local realization, and the resulting operational complexity statement. Schur's Pfaffian identity [O, IOTZ] supplies the requisite kernel rank; we include the elementary remaining linear algebra. Tournament feedback-arc hardness is due to Charbit, Thomassé and Yeo [CTY].

For context, Caro and Gallien [CG07] develop index policies and suboptimality bounds for a finite-horizon Bayesian assortment model. Agrawal, Avadhanula, Goyal and Zeevi [AAGZ19] study learning unknown MNL demand parameters from choices. Their information structures and objectives differ from purchase revelation. Our results neither invalidate their policies nor improve their regret rates. They characterize exact representability in the specified purchase-revelation setting.

Throughout, the number \(n\) denotes the size of a library of entrant priors. Each market contains only two entrants drawn from that library. We make no claim about optimal control with \(n\) entrants simultaneously present.

# 2. Model and operational comparison

## 2.1. Market and objective

There are two known incumbent products with attractions 10 and 5, two independent entrants \(X\sim P\) and \(Y\sim Q\), capacity two, outside-option attraction 1, and unit reward for a purchase. For a displayed assortment whose current attractions sum to \(s\), purchase probability and expected reward are \(s/(1+s)\). Each entrant has current attraction 1 until its first purchase. That purchase reveals its realized attraction exactly; subsequent current attraction equals the revealed value. Nonpurchase and purchases of other products reveal nothing about an unrevealed value. Policies may depend on the entire observed history and may randomize.

Our basic prior class consists of mean-one, compactly supported probability distributions on
\[
 [0,1/10]\ \cup\ (10,\infty).
\tag{2.1}
\]
Every such prior assigns positive probability to its high component. The compactness requirement is satisfied by every finite support used below and by the smooth priors in Section 5. It is not a claim about arbitrary heavy-tailed priors.

For realized attractions \(x,y\), put
\[
 S(x,y)=\operatorname{top2sum}(10,5,x,y),\qquad
 R(x,y)=\frac{S(x,y)}{1+S(x,y)},\qquad
 U=\max(10,x),\quad V=\max(10,y).
\tag{2.2}
\]
Expected cumulative regret is the expected sum, over all periods, of the clairvoyant revenue \(R(X,Y)\) minus the current assortment's expected revenue. After both entrants are revealed, displaying the best two products gives zero subsequent regret. We write \(\mathcal R_X(P,Q)\) for the policy that repeatedly displays \(X\) with incumbent 10 until its review, then displays \(Y\) with the best known product until its review, and finally exploits. Define \(\mathcal R_Y\) symmetrically. Write \(\mathcal R_B\) for displaying both entrants until the first review and then using the optimal one-entrant continuation.

## 2.2. Epoch reduction, including arbitrary adaptive policies

**Lemma 2.1 (epoch reduction).** The minimum regret over all history-dependent randomized policies equals
\[
 \min\{\mathcal R_X(P,Q),\mathcal R_Y(P,Q),\mathcal R_B(P,Q)\}.
\tag{2.3}
\]
With one unrevealed entrant, it is optimal to display that entrant with the most attractive known product until revelation.

**Proof.** We supply the reduction for (2.1), while attributing the general two-entrant result to [BDL, Theorem 6.3 and Appendix E]. Until a revelation, the posterior state does not change. At such a state and an assortment \(A\), let \(c_A\) be its conditional expected one-period regret, \(q_A\) its probability of revealing an entrant, and \(h_A\) its expected optimal continuation value multiplied by the revelation probability. The number of unrevealed products decreases at revelation, so continuation values can be defined inductively.

The two best known products always have attraction at least 5. Replacing either by an unrevealed product of current attraction 1 cannot increase current revenue. Let \(Q_s\) be conditional expected clairvoyant revenue and \(r_s\) the best revenue using only known products. Then \(c_A\geq\delta_s:=Q_s-r_s>0\) for every action before the next revelation. The strict inequality holds initially because a high entrant improves the incumbent pair; after one revelation, a remaining value above 10 still improves the known best pair on an event of positive probability. Each state has finite known attractions and compact remaining support, hence finite values. In particular, a policy with infinite conditional expected time to the next revelation has infinite conditional expected regret. This argument is statewise and does not require a finite set of possible revealed values.

For \(q_A>0\), define the repeated-action epoch value
\[
 L_A=\frac{c_A+h_A}{q_A},\qquad W=\min_{A:q_A>0}L_A.
\tag{2.4}
\]
For \(q_A=0\), we have \(h_A=0\) and \(c_A>0\). Thus every action satisfies \(c_A+h_A-q_AW\geq0\). Sum this conditional inequality while the state survives, up to a truncated revelation time. Conditional revelation probabilities telescope: their expected sum up to time \(T\) is the probability of revelation by \(T\). Continuation terms are the expected optimal value at revelation by \(T\). For any finite-regret policy the revelation time is integrable, so passage to the limit gives regret through the epoch plus its optimal continuation at least \(W\). The terms are nonnegative and continuation values are bounded on the compact state range. A fixed minimizing action attains equality by its geometric waiting time. This proves the stationary epoch reduction against arbitrary adaptive randomization.

With one unknown entrant and a known companion of attraction \(w\), the mean epoch duration is \(w+2\), and its expected total reward is \(w+1\). Its expected regret is
\[
 (w+2)Q_s-(w+1)=2Q_s-1+(Q_s-1)w.
\tag{2.5}
\]
Since \(Q_s<1\), this strictly decreases with \(w\). Displaying the entrant alone is the case \(w=0\). With two unknown entrants and one specified entrant displayed, the post-review continuation distribution is independent of which incumbent accompanies it. The same strict decrease selects incumbent 10. The remaining informative action displays both entrants. Induction on the number of unknown products proves (2.3). \(\square\)

## 2.3. Kernel and a strict exclusion of simultaneous exploration

**Proposition 2.2 (exact comparison kernel).** Conditional costs of the three epoch policies are
\[
\begin{aligned}
 C_X(x,y)&=2R+(R-1)(12+U),\\
 C_Y(x,y)&=2R+(R-1)(12+V),\\
 C_B(x,y)&=\tfrac32R+2(R-1)+\tfrac12(U+V)(R-1).
\end{aligned}
\tag{2.6}
\]
Their product-prior expectations give the corresponding regrets. Define
\[
 D(P,Q):=\mathcal R_Y(P,Q)-\mathcal R_X(P,Q).
\tag{2.7}
\]
Then
\[
 D(P,Q)=\iint K(x,y)\,dP(x)dQ(y),\qquad
 K(x,y)=\frac{\max(10,x)-\max(10,y)}{1+\max(10,x)+\max(10,y)}.
\tag{2.8}
\]
Moreover,
\[
 \mathcal R_B-\mathcal R_X\geq\frac{17}{640},\qquad
 \mathcal R_B-\mathcal R_Y\geq\frac{17}{640}.
\tag{2.9}
\]

**Proof.** Exploring one entrant with a known companion \(w\) has geometric mean duration \(w+2\) and expected reward \(w+1\). Adding the two epochs yields the first two identities of (2.6). When both entrants are displayed, time to the first review has mean \(3/2\), expected total reward 1, and either entrant is reviewed first with probability \(1/2\). This gives the third identity. Subtraction yields
\[
 C_Y-C_X=\frac{U-V}{1+S}.
\tag{2.10}
\]
If at least one value is high, \(S=U+V\). If both are low, the numerator is zero, although \(S=15\) and \(U+V=20\). Thus (2.8) holds exactly, including the low-low case.

A second subtraction gives
\[
 C_B-C_X=\frac{20+U-V-S}{2(1+S)}.
\tag{2.11}
\]
It is \(5/32\) when both values are low, zero when only \(x\) is high, and \((10-y)/(1+S)>-1\) whenever \(y\) is high. Let \(q_P=P(X>10)\) and \(q_Q=Q(Y>10)\). Nonnegativity and mean one imply \(q_P,q_Q\leq1/10\). Independence therefore gives
\[
 \mathcal R_B-\mathcal R_X
 \geq \frac5{32}(1-q_P)(1-q_Q)-q_Q
 \geq \frac5{32}\frac{81}{100}-\frac1{10}
 =\frac{17}{640}.
\tag{2.12}
\]
Interchange \(P,Q\) for the other inequality. \(\square\)

These are epoch-policy gaps. To state a first-action consequence correctly, let \(W\) be the optimal initial value and \(Q_A\) the value of using \(A\) once and continuing optimally. Then
\[
 Q_A-W=q_A(L_A-W).
\tag{2.13}
\]
For the simultaneous action, \(q_A=2/3\), so its first-action gap is at least \(17/960\). For either singleton exploration with incumbent 10, \(q_A=1/12\); the wrong sequential first action has gap \(|D(P,Q)|/12\). Other informative companions are strictly worse by (2.5), and noninformative actions have positive gap. Consequently, whenever \(D(P,Q)>0\), the unique optimal first assortment is \(\{X,10\}\); when \(D(P,Q)<0\), it is \(\{Y,10\}\). No uniform positive loss is asserted for a policy that assigns arbitrarily small probability to a suboptimal action.

# 3. Exact indexability on fixed atomic support

Fix distinct \(H_1,\ldots,H_k>10\). Let \(\mathcal P_H\) be all mean-one priors supported on \(\{0,H_1,\ldots,H_k\}\). Support here means containment; boundary priors may assign zero mass to some atoms. A full-support prior assigns positive mass to every listed atom. An exact comparison index \(I\) satisfies
\[
 \operatorname{sign}D(P,Q)=\operatorname{sign}(I(P)-I(Q))
 \quad(P,Q\in\mathcal P_H).
\tag{3.1}
\]
Such an index gives optimal priorities with any fixed resolution of equal scores. A weaker priority rule that only has to select a better action, with market-independent tie-breaking, is also impossible when strict cycles exist. Allowing an arbitrary pair-dependent decision inside a tie would make a constant index vacuous and is excluded.

## 3.1. Elementary priors and their scalar order

Define
\[
 E_H=(1-H^{-1})\delta_0+H^{-1}\delta_H.
\tag{3.2}
\]
Every \(P\in\mathcal P_H\) has a unique representation \(P_w=\sum_jw_jE_{H_j}\), where \(w_j=H_jP(\{H_j\})\), \(w_j\geq0\), and \(\sum_jw_j=1\). Let
\[
 B_{ij}=D(E_{H_i},E_{H_j}).
\tag{3.3}
\]
Bilinearity gives \(D(P_w,P_v)=w^TBv\).

**Lemma 3.1 (elementary-prior order).** Put
\[
 F(u,v)=uv(u+v+20)-210(u+v+21).
\tag{3.4}
\]
For \(x,y>10\),
\[
 B(x,y)=-\frac{(x-y)F(x-10,y-10)}{xy(x+11)(y+11)(x+y+1)}.
\tag{3.5}
\]
Let \(g(u)\) be the unique positive root in \(v\) of \(F(u,v)=0\), explicitly
\[
 g(u)=\frac{210-u(u+20)+\sqrt{(u(u+20)-210)^2+840u(u+21)}}{2u}.
\tag{3.6}
\]
Then \(g\) is a continuous strictly decreasing involution of \((0,\infty)\), and
\[
 I_0(E_H)=\min\{H-10,g(H-10)\}
\tag{3.7}
\]
represents the signs of all elementary-prior comparisons, including ties.

**Proof.** Expanding the four terms of \(D(E_x,E_y)\) gives (3.5). As a polynomial in \(v\), \(F(u,v)\) has leading coefficient \(u>0\) and constant term \(-210(u+21)<0\); it has exactly one positive root, with negative sign below it and positive sign above it. On its zero set,
\[
 uv=210\left(1+\frac1{u+v+20}\right)>210.
\tag{3.8}
\]
Hence \(F_u=v(2u+v+20)-210>0\) and \(F_v=u(u+2v+20)-210>0\). Implicit differentiation proves \(g'<0\). Symmetry and uniqueness give \(g(g(u))=u\). The equation also shows \(g(u)\to\infty\) as \(u\downarrow0\), and \(g(u)\to0\) as \(u\to\infty\). Thus \(g\) has a unique fixed point \(h>0\).

If \(u,v<h\), then \(F(u,v)<0\) and (3.5) follows increasing \(u\). If \(u,v>h\), then \(F(u,v)>0\), and it follows decreasing \(u\), equivalently increasing \(g(u)\). If \(u>h>v\), the sign of \(F(u,v)\) is that of \(v-g(u)\); (3.5) therefore compares \(g(u)\) and \(v\). Equalities, including \(u=h\) or \(v=h\), follow by continuity or direct substitution. These cases prove the sign identity for (3.7). \(\square\)

## 3.2. Rank criterion and local cycles

**Theorem 3.2 (complete fixed-support criterion).** The class \(\mathcal P_H\) has an exact comparison index if and only if \(\operatorname{rank}B\leq2\). In the rank-two case, choose elementary indices \(t,b\) that are maximal and minimal under (3.7), with \(B_{tb}>0\), and put
\[
 a_i=B_{ib},\qquad d_i=B_{ti}+B_{ib}.
\tag{3.9}
\]
Then \(d_i>0\) for every \(i\), and an index on the entire closed simplex is
\[
 I(P_w)=\frac{a^Tw}{d^Tw}.
\tag{3.10}
\]
If \(\operatorname{rank}B\geq4\), every full-support prior has, in every neighborhood, three full-support priors whose globally optimal first decisions form a strict directed cycle.

**Proof.** If \(B=0\), the constant index suffices. Otherwise, when the rank is at most two, the elementary comparisons form a total preorder by Lemma 3.1. Choose its top and bottom elements \(t,b\). Both terms in \(d_i\) are nonnegative. If both were zero, transitivity of indifference would imply \(B_{tb}=0\), a contradiction. The rank-two Plücker identity gives
\[
 B_{ij}B_{tb}=B_{ib}B_{tj}-B_{ti}B_{jb}
             =a_id_j-d_ia_j.
\tag{3.11}
\]
For completeness, choose the independent rows indexed by \(t,b\); all other rows lie in their span, and evaluating at columns \(t,b\) determines their coefficients and yields (3.11). Consequently
\[
 w^TBv=\frac{(d^Tw)(d^Tv)}{B_{tb}}
       \left(\frac{a^Tw}{d^Tw}-\frac{a^Tv}{d^Tv}\right),
\tag{3.12}
\]
which proves sufficiency on the closed simplex.

For necessity we prove a general alternating-form fact. Let \(p_0\) be any strictly positive simplex point and define
\[
 W_0=\{z:\mathbf1^Tz=0\},\qquad
 \ell(z)=z^TBp_0,\qquad Z=W_0\cap\ker\ell.
\tag{3.13}
\]
If \(\ell\) vanishes on \(W_0\), then \(Bp_0\) is a multiple of \(\mathbf1\). Its scalar product with \(p_0\) is zero, so that multiple is zero. Since \(\mathbb R^k=\operatorname{span}(p_0)\oplus W_0\), the restriction of \(B\) to \(Z=W_0\) has the full rank of \(B\).

Otherwise choose \(e\in W_0\) with \(p_0^TBe=1\). The vectors \(p_0,e\) together with a basis of \(Z\) form a basis of \(\mathbb R^k\). Each \(z\in Z\) is orthogonal to \(p_0\) for the alternating form. Replacing it by \(z+(e^TBz)p_0\) kills its pairing with \(e\) and leaves all pairings between two such vectors unchanged. The form therefore splits into one nondegenerate two-dimensional block and its restriction to \(Z\). In this case the latter has rank \(\operatorname{rank}B-2\).

In either case, rank at least four implies that there are \(u,v\in Z\) with \(u^TBv=1\). The three perturbations \(u,v,-u-v\) have cyclic pairings all equal to 1. For sufficiently small \(\epsilon>0\),
\[
 p_1=p_0+\epsilon u,\quad p_2=p_0+\epsilon v,\quad
 p_3=p_0-\epsilon(u+v)
\tag{3.14}
\]
are strictly positive simplex points in any prescribed neighborhood. The linear terms vanish by (3.13), and
\[
 p_1^TBp_2=p_2^TBp_3=p_3^TBp_1=\epsilon^2>0.
\tag{3.15}
\]
The affine map from simplex weights to priors is continuous and preserves full support, so this gives the asserted local cycles in \(\mathcal P_H\). Proposition 2.2 makes them strict globally optimal first-action cycles. No scalar priority with a fixed market-independent tie-breaking rule can follow all three directions. \(\square\)

## 3.3. Sharp common-support threshold

**Corollary 3.3 (support classification).** For the preceding fixed-support class:

1. If \(k\leq3\), the class is indexable.
2. If \(k=4\), the class is indexable exactly when
   \[
   B_{12}B_{34}-B_{13}B_{24}+B_{14}B_{23}=0.
   \tag{3.16}
   \]
3. If \(k\geq5\), it is not indexable, and Theorem 3.2 gives cycles near every full-support prior.

Five common attraction support points, counting the zero atom, are necessary and sufficient for a strict cycle within this atomic class.

**Proof.** Let \(x_0=0\), \(x_j=H_j\), and let \(K_H\) be the \((k+1)\)-square kernel matrix from (2.8). Put \(t_0=10+1/2\), \(t_j=H_j+1/2\); then
\[
 (K_H)_{ij}=\frac{t_i-t_j}{t_i+t_j}.
\tag{3.17}
\]
For an even number \(m\) of positive distinct \(t_i\), Schur's Pfaffian identity implies
\[
 \det\left(\frac{t_i-t_j}{t_i+t_j}\right)_{i,j=1}^m
 =\prod_{i<j}\left(\frac{t_i-t_j}{t_i+t_j}\right)^2>0.
\tag{3.18}
\]
For odd \(m\), the rank is \(m-1\): an even principal submatrix is nonsingular, whereas every odd alternating matrix is singular.

The elementary-prior vectors are linearly independent and span the codimension-one subspace
\[
 \left\{z\in\mathbb R^{k+1}:\sum_{i=0}^k(x_i-1)z_i=0\right\}.
\tag{3.19}
\]
Indeed, each vector satisfies this equation and its unique high coordinate proves independence. The matrix \(B\) represents the restriction of \(K_H\) to that subspace. Restricting a form to codimension one loses at most two rank units. If \(k\geq5\), (3.18) consequently gives rank at least four. For \(k\leq3\), the size and even rank of \(B\) give rank at most two. A four-square alternating matrix has rank at most two exactly when its Pfaffian (3.16) vanishes.

To attain the five-point threshold, take
\[
 (H_1,H_2,H_3,H_4)=(11,34/3,35/3,12).
\tag{3.20}
\]
Direct substitution into (3.5) gives
\[
 \operatorname{Pf}(B)=\frac{576277}{11666681437487408640}>0.
\tag{3.21}
\]
Thus this five-point common support is nonindexable. The count concerns the union of allowed attraction values across the priors in the class, not the individual support size of one prior. It also does not describe classes with several distinct low atoms. \(\square\)

# 4. Finite rational universality under moment constraints

**Theorem 4.1 (finite realization).** Let \(A\) be a real alternating \(n\)-square matrix of rank \(q\), let \(r\geq1\) be an integer, and let \(0<\eta<1\). There exist a common support of
\[
 m=q+2r+4
\tag{4.1}
\]
points in \(\{0\}\cup[11,12]\), a strictly positive mean-one baseline \(p_0\), and strictly positive priors \(p_1,\ldots,p_n\) such that their moments through order \(r\) equal those of \(p_0\),
\[
 \left|\frac{p_i(x)}{p_0(x)}-1\right|<\eta
 \quad\text{at every support point},\qquad
 D(p_i,p_j)=\lambda A_{ij}
\tag{4.2}
\]
for some \(\lambda>0\). The common higher moments are produced by the construction; they are not arbitrarily prescribed numerical moment values. If \(A\) and \(\eta\) are rational, the support, priors, and scale can all be rational, with a construction polynomial in \(n,r,L\) bit operations, where \(L\) bounds the input numerator and denominator bit lengths. This is a polynomial-time statement for fixed \(r\), or for \(r\) supplied in unary, not in \(\log r\).

**Proof of realization.** The rank \(q\) is even, so \(m\) is even. Choose
\[
 x_0=0,\quad x_j=11+\frac{j-1}{m-2}\ (1\leq j<m),\quad
 p_{0,j}=\frac1{(m-1)x_j}\ (j>0),\quad
 p_{0,0}=1-\sum_{j>0}p_{0,j}.
\tag{4.3}
\]
All masses are positive and the mean is one. The kernel matrix \(K\) is nondegenerate by (3.18). Impose the homogeneous constraints
\[
 \mathcal H=\left\{v:\sum_jx_j^\ell v_j=0\ (0\leq\ell\leq r),\quad
                  v^TKp_0=0\right\}.
\tag{4.4}
\]
Their codimension is at most \(r+2\). A nondegenerate alternating form on an \(m\)-dimensional space has restriction rank at least \(m-2c\) on a codimension-\(c\) subspace: the restricted radical is contained in the ambient orthogonal complement, of dimension \(c\). Thus \(K|_{\mathcal H}\) has rank at least \(q\). Alternating Gaussian elimination supplies \(v_1,\ldots,v_n\in\mathcal H\) with
\[
 v_i^TKv_j=A_{ij}.
\tag{4.5}
\]
Explicitly, reduce both forms to copies of \(J=\left(\begin{smallmatrix}0&1\\-1&0\end{smallmatrix}\right)\) and a radical, and embed the \(q\) nondegenerate coordinates of \(A\) in those of \(K|_{\mathcal H}\). This requires no square roots and works over the rational field.

Let \(M_0=\max_{i,j}|v_i(j)|/p_{0,j}\), choose \(\epsilon=\eta/[2(1+M_0)]\), and put \(p_i=p_0+\epsilon v_i\). The constraints preserve mass and all specified moments, and the chosen scale gives strict positivity and (4.2). Alternation and the last constraint in (4.4) cancel the constant and linear terms:
\[
 p_i^TKp_j=\epsilon^2v_i^TKv_j=\epsilon^2A_{ij}.
\tag{4.6}
\]
Set \(\lambda=\epsilon^2\). If \(A=0\), take every \(v_i=0\); the same construction remains valid. The relative bound also implies \(\operatorname{TV}(p_i,p_0)<\eta/2\). \(\square\)

## 4.1. Bit complexity

We detail the arithmetic claim rather than relying only on real-arithmetic operation counts. The grid and kernel entries in (4.3) have \(O(\log m)\)-bit numerators and denominators. Summing to obtain \(p_{0,0}\) gives a conservative \(O(m\log m)\) bound. Powers through degree \(r\) have \(O(r\log m)\) bits. Consequently the constraint matrix \(C\), with rows \((x_j^\ell)_j\) and \((Kp_0)^T\), has polynomial bit size.

For a \(d\)-square rational matrix with entry bit lengths at most \(B\), multiplication by the product of its denominators yields an integer matrix with entry bit lengths at most \((d^2+1)B\). Hadamard's determinant bound then gives \(O(d^3B+d\log d)\) bits for relevant minor ratios. Solving nonsingular subsystems gives a rational nullspace basis \(N\), and the restricted form \(G=N^TKN\) has polynomial bit size.

An alternating reduction can also be implemented with polynomially bounded exact fractions. If \(I\) is an already selected even pivot set with nonsingular principal submatrix \(M_{II}\), replace each remaining coordinate vector \(e_j\) by
\[
 u_j=e_j-E_I M_{II}^{-1}M_{I,j},
\tag{4.7}
\]
where \(E_I\) inserts pivot coordinates. These are orthogonal to the pivot space and their entries are minor ratios of the original matrix. A nonzero residual pairing selects two further pivot coordinates; normalize one vector by that pairing to obtain a \(J\)-block. Recompute later residual vectors by (4.7) with the enlarged original pivot set. The pairing is a Schur-complement entry, again a minor ratio. At most \(d/2\) stages are required; their vectors and normalizations all have polynomial bit size. A basis of the final radical is obtained from the remaining projected coordinates.

Let the resulting transformations satisfy
\[
 T_A^TAT_A=J_{q/2}\oplus0,\qquad
 T_G^TGT_G=J_{\operatorname{rank}(G)/2}\oplus0.
\tag{4.8}
\]
Then the matrix with columns \(v_i\) can be taken to be
\[
 V=N(T_G)_{[:,1:q]}(T_A^{-1})_{[1:q,:]}.
\tag{4.9}
\]
All dimensions are polynomial in \(n,r\); matrix multiplication, subsystem solution, fraction reduction, and comparison use polynomial bit operations. The rational \(M_0,\epsilon,p_i,\lambda\) therefore also have polynomial bit length. This proves the claim in Theorem 4.1. It implies only a bound of the form \(\lambda\geq2^{-\operatorname{poly}(n,r,L)}\) for this construction, not an inverse-polynomial or constant comparison margin.

## 4.2. A support lower bound

**Proposition 4.2.** Suppose priors on \(m>r\) distinct common support points have equal moments through order \(r\). If their exact comparison matrix equals \(\lambda A\), with \(\lambda\ne0\), then
\[
 m\geq\operatorname{rank}(A)+r.
\tag{4.10}
\]
If \(m\leq r+1\), equality of the moments forces all the priors to coincide, so only the zero comparison matrix is possible.

**Proof.** The Vandermonde rows for orders \(0,\ldots,r\) have rank \(r+1\) when \(m>r\). The common moment fiber has affine dimension at most \(m-r-1\); its linear span has dimension at most \(m-r\). Writing the prior columns as a matrix \(P\), the comparison matrix \(P^TKP\) has rank at most \(m-r\). If the Vandermonde system has at least \(m\) rows it determines the probabilities uniquely. \(\square\)

Thus the coefficient of \(\operatorname{rank}(A)\) in (4.1) cannot be reduced in an exact-matrix realization; the additive difference in the stated bounds is \(r+4\). We do not claim an optimal support count for matching signs alone.

# 5. Smooth local universality with fixed features

Let \(L=[0,1/10]\) and \(H=[11,12]\). Fix any mean-one probability measure \(P_0\) with a \(C^\infty(\mathbb R)\) density that is positive on the interiors of \(L,H\) and zero outside \(L\cup H\). Such a measure exists: mix two normalized smooth positive bump densities on the intervals with the unique weight giving mean one. Smoothness allows zero density at the endpoints.

**Theorem 5.1 (fixed-baseline smooth realization).** For every finite collection of real \(P_0\)-integrable functions \(\phi_1,\ldots,\phi_r\), every finite real alternating matrix \(A\), and every \(0<\eta<1\), there are smooth priors \(P_1,\ldots,P_n\) of exactly the same support and a \(\lambda>0\) such that
\[
\begin{gathered}
 \mathbb E_{P_i}X=1,\qquad
 \mathbb E_{P_i}\phi_j=\mathbb E_{P_0}\phi_j,\\
 1-\eta<\frac{dP_i}{dP_0}<1+\eta\quad P_0\text{-a.e.},\qquad
 D(P_i,P_j)=\lambda A_{ij}.
\end{gathered}
\tag{5.1}
\]
All nonzero matrix entries specify unique globally optimal first assortments. The simultaneous epoch and first-action gaps of Proposition 2.2 continue to apply.

**Proof.** On \(\mathcal V=C_c^\infty((11,12))\), define
\[
 \omega(f,g)=\iint K(x,y)f(x)g(y)\,dP_0(x)dP_0(y).
\tag{5.2}
\]
This form has arbitrarily high finite rank. To prove this, choose any even number \(m\) of distinct points \(z_1,\ldots,z_m\in(11,12)\). Their kernel matrix is nondegenerate by (3.18). Choose nonnegative smooth bumps with disjoint supports shrinking around these points, each normalized to integral one against \(P_0\). Continuity of \(K\) makes their pairing matrix converge to \((K(z_i,z_j))\). Its determinant is nonzero for sufficiently small supports. The disjoint bumps are linearly independent and span a nondegenerate \(m\)-dimensional subspace.

Impose on \(f\) the constraints of zero integral against \(1,x,\phi_1,\ldots,\phi_r\) and against
\[
 k_0(x)=\int K(x,y)\,dP_0(y).
\tag{5.3}
\]
All are finite linear functionals, since each smooth compactly supported \(f\) is bounded and the features are integrable. The total codimension is at most \(r+3\), with redundancies harmless. Choose an even nondegenerate subspace of dimension at least \(\operatorname{rank}(A)+2(r+3)\). The rank argument from Section 4 gives functions \(f_1,\ldots,f_n\) in its constrained subspace with \(\omega(f_i,f_j)=A_{ij}\).

These functions are bounded and smooth. Choose \(\epsilon>0\) with \(\epsilon\max_i\|f_i\|_\infty<\eta\), and set \(dP_i=(1+\epsilon f_i)dP_0\). Positivity, support, smoothness, normalization, mean, and feature equalities follow. The last constraint makes \(\int f_i k_0\,dP_0=0\), so expansion of the two density factors gives
\[
 D(P_i,P_j)=\epsilon^2\omega(f_i,f_j)=\epsilon^2A_{ij}.
\tag{5.4}
\]
Set \(\lambda=\epsilon^2\). Proposition 2.2 and the compact-support policy reduction give the operational claims. \(\square\)

The baseline is fixed before the features, target matrix, and neighborhood are selected. The theorem therefore rules out exact recovery of all optimal pair priorities from any specified finite list of feature expectations in this neighborhood. It does not rule out arbitrary encodings of a full distribution into a real number; the scalar-index impossibility concerns the order induced by that number. The construction gives no uniform nonvanishing lower bound on \(\lambda\).

For additional stability context, because \(|K|\leq1\),
\[
 |D(P,Q)-D(P',Q')|
 \leq2\operatorname{TV}(P,P')+2\operatorname{TV}(Q,Q').
\tag{5.5}
\]
This follows by adding and subtracting the product integral for \(P'\otimes Q\) and using the total-variation dual bound in each coordinate. Small local cycles are therefore compatible with small absolute comparison gaps.

# 6. Exact complexity of fitting a reusable priority order

Consider a finite library of rational finite-support priors satisfying the model assumptions. Every unordered pair is a possible market, with equal weight. A reusable total order repeatedly explores its higher-ranked entrant first, then uses the optimal one-entrant continuation. Define the decision problem: does some total order have the sum of its regrets over all pair markets at most a given rational threshold \(b\)? The input explicitly lists rational support values and probabilities. This is a finite exact-arithmetic problem.

**Theorem 6.1 (priority fitting).** This decision problem is NP-complete, even for mean-one priors on a common support in \(\{0\}\cup[11,12]\) and inside any fixed prescribed positive relative neighborhood of a common full-support baseline. For any fixed integer \(r\geq1\), the reduction can additionally require equal moments through order \(r\).

**Proof.** A total order is a polynomial-size certificate. For each pair, (2.6) computes its regret by a finite sum of rational terms; their sizes and the number of operations are polynomial in the input length. Summing the pair regrets and comparing with \(b\) verifies membership in NP.

For hardness, take a tournament \(T\) on \(n\) vertices and an integer \(k\). Set \(A_{ij}=1\) if its edge directs \(i\) before \(j\), and \(A_{ij}=-1\) otherwise, with zero diagonal. Theorem 4.1, for fixed \(r,\eta\), constructs rational priors in polynomial time with comparison matrix \(\lambda A\). Every wrong ordering of a pair increases its sequential-policy regret by exactly \(\lambda\). Let
\[
 C_* = \sum_{i<j}\min\{\mathcal R_X(P_i,P_j),\mathcal R_Y(P_i,P_j)\}.
\tag{6.1}
\]
For every order \(\sigma\), its regret sum is
\[
 C_*+\lambda\,\operatorname{back}_T(\sigma),
\tag{6.2}
\]
where \(\operatorname{back}_T(\sigma)\) counts edges directed backward in the order. Compute the polynomial-bit rational threshold \(b=C_*+\lambda k\). The answer is yes exactly when the tournament has a feedback arc set of size at most \(k\), the NP-complete problem established by [CTY] together with immediate membership in NP. This proves the reduction. \(\square\)

Equivalently, the minimum average excess regret of a reusable order on these equal-gap instances is
\[
 \frac{\lambda\,\operatorname{fas}(T)}{\binom n2}.
\tag{6.3}
\]
Randomization over total orders cannot lower this optimum because the average objective is affine in the mixing distribution. This statement concerns a shared order reused across different pair markets. Optimizing one pair remains explicit through (2.8). The theorem is neither a complexity result for the many-entrant adaptive problem nor a hardness result at any fixed additive accuracy.

# 7. A finite-moment approximation for pair decisions

For priors supported on \([0,1/10]\cup[11,12]\), put \(Z=\max(10,X)-11\). Then \(Z\in[-1,1]\) and
\[
 K(x,y)=\frac{z-w}{23+z+w}.
\tag{7.1}
\]
For an integer \(R\geq1\), define the antisymmetric polynomial
\[
 K_R(z,w)=\frac{z-w}{23}\sum_{k=0}^{R-1}
              \left(-\frac{z+w}{23}\right)^k.
\tag{7.2}
\]

**Theorem 7.1 (approximate pair decisions).** The first \(R\) moments of \(Z\) for each prior determine a pair comparator \(D_R\) with
\[
 |D(P,Q)-D_R(P,Q)|\leq e_R,
 \qquad e_R=\frac2{21}\left(\frac2{23}\right)^R.
\tag{7.3}
\]
Repeatedly explore \(P\) first if \(D_R\geq0\), and \(Q\) first otherwise, then use the canonical optimal continuation. The resulting total regret is at most \(e_R\) above the unrestricted optimum. Given the moments, the comparator uses \(O(R^2)\) arithmetic operations. In particular, \(O(\log(1/\delta))\) clipped moments suffice for additive \(\delta\)-optimal pair decisions as \(\delta\downarrow0\).

**Proof.** The geometric remainder and \(|z-w|,|z+w|\leq2\) give
\[
 \sup_{z,w\in[-1,1]}\left|\frac{z-w}{23+z+w}-K_R(z,w)\right|
 \leq\frac{2}{23}\frac{(2/23)^R}{1-2/23}=e_R.
\tag{7.4}
\]
The polynomial has total degree at most \(R\). Expanding its \(k\)-th binomial gives \(O(k+1)\) products of one marginal moment from each prior. Summing over \(k<R\) establishes the stated arithmetic bound. Taking product expectations in (7.4) proves (7.3). If the chosen sign is wrong, the magnitude of the true regret difference is at most \(e_R\), since \(D_R\) lies on the other side of zero. Otherwise the selected sequential policy is optimal. Simultaneous exploration is dominated by Proposition 2.2. \(\square\)

If two priors have equal clipped moments through order \(R\), antisymmetry gives \(D_R(P,Q)=0\), and hence \(|D(P,Q)|\leq e_R\). These clipped moments may be included among the features of Theorem 5.1, so its exact local realization scale must then respect this bound. Exact infinite-dimensional nonrepresentation is therefore consistent with accurate comparison from a short moment vector. The comparator is pair-dependent; it is not a scalar priority order. No matching lower bound on moment count, or fixed-accuracy hardness, is claimed.

# 8. Scope and reproducibility

The main classification concerns a fixed zero-plus-high atomic support and mean one. The smooth universality and approximation theorems use the stated fixed two-band support. All strict decisions concern the globally optimal first action in a two-entrant market; the construction of a library of \(n\) priors does not change that market size. Independence, unit purchase reward, cold-start attraction one, and exact purchase revelation are essential assumptions of the derivations. No result is asserted for finite horizons, correlated entrant values, general noisy feedback, or arbitrary incumbent configurations.

Exact rational diagnostics accompany the finite constructions: a three-cycle realization, a rank-four weighted target with two matched moments, a three-moment example, the zero matrix, and the five-point classification certificate. The diagnostics verify finite identities and positivity using rational arithmetic. They supplement the written proofs and do not replace the arguments quantified over all priors or all target matrices. The mathematical claims above have not undergone external journal peer review, and the literature comparison does not establish worldwide priority.

# References

**[BDL]** Jackie Baek, Atanas Dinev, and Thodoris Lykouris. *Optimal Exploration of New Products under Assortment Decisions*. arXiv:2604.18800v2, 23 May 2026. [Versioned full text](https://arxiv.org/html/2604.18800v2). In particular, Section 6.2, Theorem 6.3, and Appendix E. This source is cited as a preprint.

**[CG07]** Felipe Caro and Jérémie Gallien. *Dynamic Assortment with Demand Learning for Seasonal Consumer Goods*. Management Science 53(2), 276–292, 2007. [doi:10.1287/mnsc.1060.0613](https://doi.org/10.1287/mnsc.1060.0613). [Author-hosted published text](https://web.mit.edu/people/jgallien/CaroGallienDynAssortMgtSci2007.pdf).

**[AAGZ19]** Shipra Agrawal, Vashist Avadhanula, Vineet Goyal, and Assaf Zeevi. *MNL-Bandit: A Dynamic Learning Approach to Assortment Selection*. Operations Research 67(5), 1453–1485, 2019. [doi:10.1287/opre.2018.1832](https://doi.org/10.1287/opre.2018.1832). [Author version](https://arxiv.org/abs/1706.03880).

**[F82]** Peter C. Fishburn. *Nontransitive measurable utility*. Journal of Mathematical Psychology 26(1), 31–67, 1982. [doi:10.1016/0022-2496(82)90034-7](https://doi.org/10.1016/0022-2496(82)90034-7). The positioning discussion relies on the publisher abstract; no claim is made to have compared every theorem of the inaccessible full text.

**[F84]** Peter C. Fishburn. *SSB utility theory and decision-making under uncertainty*. Mathematical Social Sciences 8(3), 253–285, 1984. [doi:10.1016/0165-4896(84)90100-8](https://doi.org/10.1016/0165-4896(84)90100-8). Publisher abstract used for historical positioning.

**[F83]** Peter C. Fishburn. *Transitive measurable utility*. Journal of Economic Theory 31(2), 293–317, 1983. [doi:10.1016/0022-0531(83)90079-0](https://doi.org/10.1016/0022-0531(83)90079-0). The publisher abstract explicitly describes the two-linear-functional comparison; the full text was not accessible for theorem-by-theorem comparison.

**[C83]** Chew Soo Hong. *A Generalization of the Quasilinear Mean with Applications to the Measurement of Income Inequality and Decision Theory Resolving the Allais Paradox*. Econometrica 51(4), 1065–1092, 1983. [doi:10.2307/1912052](https://doi.org/10.2307/1912052). Cited as historical context from verified bibliographic metadata, not as an inspected proof of the model-specific criterion.

**[SS24]** Ashwin Sah and Mehtaab Sawhney. *The intransitive dice kernel*. Probability Theory and Related Fields 189, 1073–1128, 2024. [doi:10.1007/s00440-024-01270-8](https://doi.org/10.1007/s00440-024-01270-8). The article's full title includes its displayed kernel; see especially Proposition 8.3 and the historical discussion.

**[O]** Soichi Okada. *Generalizations of Cauchy's Determinant Identity and Schur's Pfaffian Identity*. [Author-hosted survey](https://www.math.kobe-u.ac.jp/publications/rlm18/9.pdf), equation (1.3). The survey is by Okada; the separate four-author journal article is [IOTZ].

**[IOTZ]** Masao Ishikawa, Soichi Okada, Hiroyuki Tagawa, and Jiang Zeng. *Generalizations of Cauchy's determinant and Schur's Pfaffian*. Advances in Applied Mathematics 36(3), 251–287, 2006. [doi:10.1016/j.aam.2005.07.001](https://doi.org/10.1016/j.aam.2005.07.001).

**[CTY]** Pierre Charbit, Stéphan Thomassé, and Anders Yeo. *The minimum feedback arc set problem is NP-hard for tournaments*. Combinatorics, Probability and Computing 16(1), 1–4, 2007. [doi:10.1017/S0963548306007887](https://doi.org/10.1017/S0963548306007887). [Author manuscript](https://perso.ens-lyon.fr/stephan.thomasse/liste/feedback.pdf).
