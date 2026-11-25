# Sharp Erasure Bounds for Quantum Rényi Information Combining at Orders Four and Five

*Complete proofs, exact gaps, equality structure, and dual corollaries*

24 November 2026

## Abstract

Two independent binary sources each come with quantum side information. After the bits are combined by XOR, how much conditional uncertainty can remain when the two input conditional entropies are fixed? We prove the sharp binary erasure-channel upper bound for the fourth- and fifth-order sandwiched conditional Rényi entropies. The result covers arbitrary finite dimensions, noncommuting outputs, singular marginals, and arbitrary input priors. It establishes two complete order branches of Conjecture V.6 of Hirche, Guan, and Tomamichel [1], with the BEC normalization specified below. The proof associates an ordered triple of trace moments with each input. XOR multiplies these moments coordinatewise, and an explicit weighted covariance identity gives the nonnegative gap. At order four, the moment ordering follows from positive semidefinite congruence; at order five, a separate identity in two spectral bases is required.

We characterize all two-input equality cases: at least one input must decompose into two perfectly distinguishable sectors and a common sector on which its two subnormalized blocks coincide. Independent binary erasure channels attain the bound throughout the admissible entropy square. We also obtain a sharp bound for any finite number of independent XOR inputs, a quantitative gap bound, and sharp variable-node lower bounds for the Petz upper conditional entropies of orders $1/4$ and $1/5$. The general real-order conjecture, the opposite BSC–PSC bound, and the von Neumann entropy problem remain outside our conclusions. This is an AI-assisted research manuscript with analytic proofs; it has not received full formal verification or external peer review.

## 1. Problem, sources, and scope

Information-combining bounds describe check nodes and variable nodes in polar coding and belief propagation. Section V of [1] considers two independent, uniform binary classical–quantum inputs, and equation (IV.1) defines the sandwiched lower conditional entropy used here. That paper proves the order-two formula and proposes the general erasure bound in Conjecture V.6, equation (V.16). Corresponding results with classical side information were already established in [2]. Noncommuting quantum side information is not covered by those classical results. We resolve the cases $k\in\{4,5\}$, and our proof also allows nonuniform input priors.

**Logarithm grouping in the source.** Equation (V.16) on page 7 of [1] does not explicitly delimit the full argument of its logarithm. We fix the normalization by direct evaluation of a binary erasure channel and by the established order-two formula (V.13) in that paper: the constant $\delta_k$ is inside the logarithm in our equation (2). Appendix A also explains why our sharp bound implies the weaker literal reading that places this constant outside the logarithm. This notation issue is not used to change the hypotheses or weaken the target.

The public order-three work [5] involves a single moment. Orders four and five produce three distinct noncommutative moments, so their bounds do not follow by changing the order in the cubic identity. The additional step here is to prove the same ordering for the respective triples. Our proof does not depend on the proof or formalization library of [5].

All logarithms are natural. We write $\operatorname{Tr}$ for the finite-dimensional matrix trace and $\|T\|_2^2=\operatorname{Tr}(T^*T)$ for the squared Hilbert–Schmidt norm. Positive semidefinite order is denoted by $\succeq$. Negative powers are evaluated on the support and set to zero on the kernel.

## 2. Main theorems

Let $P_0,P_1\succeq0$ be subnormalized matrices on a common finite-dimensional complex Hilbert space, with

$$
\operatorname{Tr}(P_0+P_1)=1,\qquad
\rho_{XB}=\sum_{x=0}^1|x\rangle\langle x|\otimes P_x,
\qquad r=P_0+P_1.
$$

Thus $\operatorname{Tr}P_x$ is the input prior. The uniform-input convention of [1] is recovered by taking $P_x=\sigma_x/2$, where $\operatorname{Tr}\sigma_x=1$. Define

$$
\begin{aligned}
K_k(P)&=\sum_{x=0}^1\operatorname{Tr}
 \left(r^{(1-k)/(2k)}P_xr^{(1-k)/(2k)}\right)^k,\\
H_k(P)&=\widetilde H_k^\downarrow(X|B)_\rho
       =-\frac1{k-1}\log K_k(P).
\end{aligned} \tag{1}
$$

For two independent inputs $P^{(1)},P^{(2)}$, the blocks of the XOR output $Z=X_1\oplus X_2$ are

$$
P^\oplus_z=\sum_{x=0}^1
 P^{(1)}_{z\oplus x}\otimes P^{(2)}_x.
$$

**Theorem 1 (Sharp erasure upper bound).** Let $k=4$ or $k=5$, and set
$\delta_k=2^{1-k}$, $K_i=K_k(P^{(i)})$, and $H_i=H_k(P^{(i)})$. Then

$$
\begin{aligned}
K_k(P^\oplus)&\ge F_k(K_1,K_2),\\
F_k(K_1,K_2)&=\delta_k+
 \frac{(K_1-\delta_k)(K_2-\delta_k)}{1-\delta_k},\\
H_k(P^\oplus)&\le-\frac1{k-1}\log F_k(K_1,K_2).
\end{aligned} \tag{2}
$$

The bound is sharp over all finite-dimensional binary classical–quantum inputs: for every prescribed $H_1,H_2\in[0,\log2]$, erasure channels with uniform priors attain equality. If a particular nonuniform prior is additionally fixed, we assert the inequality but do not claim pointwise optimality within that restricted prior class.

**Theorem 2 (All two-input equality cases).** Equality holds in Theorem 1 if and only if at least one input has an orthogonal decomposition of its side-information space into three sectors on which its original blocks have the form

$$
P_0=C+R_0,\qquad P_1=C+R_1, \tag{3}
$$

where $C,R_0,R_1\succeq0$ have pairwise orthogonal supports. Some of these operators may be zero. We call (3) an *erasure-type structure*. The two input blocks coincide on the $C$ sector; the $R_0$ and $R_1$ sectors each identify one input value perfectly.

## 3. Support reduction and three trace moments

Because $0\preceq P_x\preceq r$, we have $\ker r\subseteq\ker P_x$. Indeed, if $rv=0$, then $0\le\langle v,P_xv\rangle\le0$, and positive semidefiniteness implies $P_xv=0$. Compressing to $\operatorname{supp}r$ therefore leaves the state, traces, and conditional entropy unchanged. On this support, $r$ is positive definite. No full-rank assumption on the original marginal or exchange of limits is needed.

Set

$$
U=r^{(1-k)/(2k)}P_0r^{(1-k)/(2k)},\quad
V=r^{(1-k)/(2k)}P_1r^{(1-k)/(2k)},
$$

$$
S=U+V=r^{1/k},\qquad D=U-V. \tag{4}
$$

Then $D=D^*$, $S\pm D\succeq0$, and $\operatorname{Tr}S^k=1$. For the two orders, define

$$
\begin{array}{c|ccc|ccc}
k&a&b&c&w_a&w_b&w_c\\ \hline
4&\operatorname{Tr}S^2D^2&\operatorname{Tr}SDSD&\operatorname{Tr}D^4&4&2&1\\
5&\operatorname{Tr}S^3D^2&\operatorname{Tr}S^2DSD&\operatorname{Tr}SD^4&5&5&5
\end{array} \tag{5}
$$

Write $w=(w_a,w_b,w_c)$ and $W=w_a+w_b+w_c=2^{k-1}-1$.

**Lemma 3 (Exact trace expansion).** At both orders,

$$
K_k=\operatorname{Tr}(U^k+V^k)
 =\delta_k(1+w_aa+w_bb+w_cc). \tag{6}
$$

**Proof.** Substitute $U=(S+D)/2$ and $V=(S-D)/2$. Words containing an odd number of $D$ factors cancel. At order four, the six words containing two $D$ factors comprise four with cyclic trace $a$ and two with cyclic trace $b$. At order five, the ten words containing two $D$ factors split into five with cyclic trace $a$ and five with cyclic trace $b$; the five words containing four $D$ factors all have cyclic trace $c$. The all-$S$ term has trace one. This gives (6) using trace cyclicity alone, without commuting any matrix factors. $\square$

## 4. Ordering the noncommutative moments

**Lemma 4.** Both triples in (5) satisfy

$$
a\ge b\ge c\ge0. \tag{7}
$$

### 4.1 Order four

Since $S,D$ are Hermitian, direct expansion gives

$$
a-b=\frac12\operatorname{Tr}([S,D]^*[S,D])\ge0. \tag{8}
$$

The two cross terms containing three $D$ factors cancel under the trace. Hence

$$
\begin{aligned}
b-c&=\operatorname{Tr}\bigl(D(S-D)D(S+D)\bigr)\\
&=\left\|(S-D)^{1/2}D(S+D)^{1/2}\right\|_2^2\ge0.
\end{aligned} \tag{9}
$$

Equation (9) does not require $D$ to be positive semidefinite. It uses the positive semidefiniteness of $S-D$ and $S+D$. Finally, $c=\operatorname{Tr}D^4\ge0$.

### 4.2 Order five

Let $T=[S,D]$. Expanding the trace, or working in an eigenbasis of $S$, yields

$$
\begin{aligned}
a-b&=\operatorname{Tr}(ST^*T)\\
&=\frac12\sum_{i,j}(s_i+s_j)(s_i-s_j)^2|D_{ij}|^2\ge0.
\end{aligned} \tag{10}
$$

The second step at order five cannot be obtained directly from (9). Put $G=S+D\succeq0$ and $J=S-D\succeq0$. Expand the words and combine only cyclically equivalent traces to obtain

$$
b-c=\frac18\operatorname{Tr}
 (G^4J+GJ^4-G^3J^2-G^2J^3). \tag{11}
$$

Let $(g_i,e_i)$ and $(j_l,f_l)$ be spectral decompositions of $G$ and $J$, respectively. For positive integers $p,q$,
$\operatorname{Tr}(G^pJ^q)=\sum_{i,l}g_i^pj_l^q|\langle e_i,f_l\rangle|^2$.
Substitution in (11) gives the factorization

$$
b-c=\frac18\sum_{i,l}
 g_i j_l(g_i+j_l)(g_i-j_l)^2
 |\langle e_i,f_l\rangle|^2\ge0. \tag{12}
$$

The spectral bases of $G$ and $J$ may differ, so this argument covers noncommuting inputs. Also,
$c=\operatorname{Tr}(S^{1/2}D^4S^{1/2})\ge0$, completing the proof. $\square$

The trace identities in (8)–(12) are accompanied by exact rational certificates for free words and cyclic traces, implemented with the Python standard library. Positivity and the statements in arbitrary dimension are established by the analytic arguments above.

## 5. Tensor multiplication, exact gaps, and the proof of Theorem 1

Independence makes the output marginal $r_1\otimes r_2$. On the product support,
$(r_1\otimes r_2)^s=r_1^s\otimes r_2^s$ for every real $s$, as follows directly in a product eigenbasis. Consequently the sandwiched output blocks are

$$
U_\oplus=U_1\otimes U_2+V_1\otimes V_2,\qquad
V_\oplus=U_1\otimes V_2+V_1\otimes U_2.
$$

Adding and subtracting gives

$$
S_\oplus=S_1\otimes S_2,\qquad D_\oplus=D_1\otimes D_2. \tag{13}
$$

The tensor-product trace identity now gives

$$
(a_\oplus,b_\oplus,c_\oplus)=(a_1a_2,b_1b_2,c_1c_2). \tag{14}
$$

For arbitrary triples $x,y$ and positive weights $w$, direct expansion shows that

$$
W\sum_jw_jx_jy_j-
 \left(\sum_jw_jx_j\right)\left(\sum_jw_jy_j\right)
 =\sum_{j<l}w_jw_l(x_j-x_l)(y_j-y_l). \tag{15}
$$

Apply this with $x=(a_1,b_1,c_1)$ and $y=(a_2,b_2,c_2)$. Equations (6), (14), and $1-\delta_k=\delta_k W$ give the exact gap

$$
\Delta_k:=K_k(P^\oplus)-F_k(K_1,K_2)
 =\frac{\delta_k}{W}\sum_{j<l}w_jw_l(x_j-x_l)(y_j-y_l). \tag{16}
$$

Every term is nonnegative by Lemma 4. The logarithm is increasing and $-1/(k-1)<0$, proving (2). Explicitly,

$$
\begin{aligned}
\Delta_4={}&\frac17(a_1-b_1)(a_2-b_2)
 +\frac1{14}(a_1-c_1)(a_2-c_2)\\
&+\frac1{28}(b_1-c_1)(b_2-c_2),\\[3pt]
\Delta_5={}&\frac5{48}\bigl[(a_1-b_1)(a_2-b_2)
 +(a_1-c_1)(a_2-c_2)\\
&\hspace{41mm}+(b_1-c_1)(b_2-c_2)\bigr].
\end{aligned} \tag{17}
$$

For completeness, we also establish the entropy range needed below. Equation (6) implies $K_k\ge\delta_k$. Expanding the trace for $U,V\succeq0$ gives
$\operatorname{Tr}(U+V)^k\ge\operatorname{Tr}U^k+\operatorname{Tr}V^k$.
At order four, the mixed cyclic words are $U^3V,UV^3,U^2V^2,UVUV$; at order five they are $U^4V,UV^4,U^3V^2,U^2V^3,U^2VUV,UVUV^2$.
Every trace is nonnegative. The first types are traces of products of two positive semidefinite matrices;
$\operatorname{Tr}(UVUV)=\operatorname{Tr}(V^{1/2}UV^{1/2})^2$;
and the last two fifth-order types have traces
$\operatorname{Tr}((VUV)U^2)$ and $\operatorname{Tr}((UVU)V^2)$, respectively.
Thus $K_k\le\operatorname{Tr}S^k=1$, and

$$
\delta_k\le K_k\le1,\qquad 0\le H_k\le\log2. \tag{18}
$$

**Quantitative gap.** Let $\eta_i=a_i-c_i\ge0$ and
$H_k^{\rm BEC}=-(k-1)^{-1}\log F_k(K_1,K_2)$. Then

$$
H_k^{\rm BEC}-H_k(P^\oplus)
 =\frac1{k-1}\log\left(1+\frac{\Delta_k}{F_k(K_1,K_2)}\right), \tag{19}
$$

and

$$
H_4^{\rm BEC}-H_4(P^\oplus)\ge\frac{\eta_1\eta_2}{42},\qquad
H_5^{\rm BEC}-H_5(P^\oplus)\ge\frac{5\eta_1\eta_2}{192}. \tag{20}
$$

To prove this, retain the middle term in each line of (17), and use
$\log(1+t)\ge t/(1+t)$ together with
$F_k+\Delta_k=K_k(P^\oplus)\le1$.
This is a stability estimate in explicit moment defects, not a trace-distance estimate to the set of erasure channels.

## 6. Equality structure and sharpness over the full entropy square

The strictly positive coefficient of $(a_1-c_1)(a_2-c_2)$ in (16) shows that $\Delta_k=0$ if and only if at least one input satisfies $a=b=c$.

Fix such an input. On the support of $r$, the matrix $S$ is positive definite. Equation (8) at order four and (10) at order five show that $a=b$ implies $[S,D]=0$. Simultaneously diagonalize $S,D$, with eigenvalues $s_j>0$ and $|d_j|\le s_j$. At either order,

$$
b-c=\sum_j s_j^{k-4}d_j^2(s_j^2-d_j^2). \tag{21}
$$

Each summand is nonnegative, so $b=c$ is equivalent to
$d_j\in\{0,s_j,-s_j\}$ for every $j$. Reconstruct the original blocks from their sandwiched versions:

$$
P_0=\frac12 S^{(k-1)/2}(S+D)S^{(k-1)/2},\qquad
P_1=\frac12 S^{(k-1)/2}(S-D)S^{(k-1)/2}. \tag{22}
$$

On the $d=0$ sector both blocks equal $S^k/2$. On the $d=s$ sector only $P_0=S^k$ is nonzero; on the $d=-s$ sector only $P_1=S^k$ is nonzero. This is exactly (3). Conversely, the three orthogonal sectors in (3) have $D=0,S,-S$, respectively, so their three moments coincide. This proves Theorem 2.

For erasure probability $e\in[0,1]$, take the conditional output states

$$
\sigma_0=(1-e)|0\rangle\langle0|+e|\mathrm e\rangle\langle\mathrm e|,
\quad
\sigma_1=(1-e)|1\rangle\langle1|+e|\mathrm e\rangle\langle\mathrm e|,
\tag{23}
$$

and set $P_x=\sigma_x/2$. Direct calculation yields

$$
a=b=c=1-e,\qquad K_k=1-(1-\delta_k)e. \tag{24}
$$

Consequently $H_k$ ranges continuously over $[0,\log2]$ as $e$ varies. Any prescribed pair of input entropies is realized by two such channels, with equality in (2). A uniform upper bound depending only on $H_1,H_2$ therefore cannot be pointwise smaller. In fact, only one input needs to have the structure (3); the other may have noncommuting outputs.

### 6.1 An exact noncommuting example

The strict gap can be demonstrated without floating-point arithmetic. Start with

$$
S_0=\begin{pmatrix}4&0\\0&2\end{pmatrix},\qquad
D_0=\begin{pmatrix}0&2\\2&0\end{pmatrix}.
$$

For each $k\in\{4,5\}$, let $N_k=\operatorname{Tr}S_0^k$ and set
$S=S_0/N_k^{1/k}$, $D=D_0/N_k^{1/k}$. Both $S_0+D_0$ and $S_0-D_0$ have eigenvalues $3\pm\sqrt5>0$. Equation (22) therefore constructs valid original cq blocks. Their traces are both $1/2$, because $S_0$ is diagonal and $D_0$ has zero diagonal. The original blocks do not commute.

Use two identical copies of this input. The exact values at order four are

$$
\begin{aligned}
(a,b,c)&=(5,4,2)/17, & K_4&=47/136,\\
K_4(P^\oplus)&=25/136, & \Delta_4&=13/4046>0.
\end{aligned} \tag{24a}
$$

At order five they are

$$
\begin{aligned}
(a,b,c)&=(3,2,1)/11, & K_5&=41/176,\\
K_5(P^\oplus)&=191/1936, & \Delta_5&=5/968>0.
\end{aligned} \tag{24b}
$$

The normalization depends on $k$, so these are two explicitly constructed cq examples rather than a claim that one fixed input has both displayed triples. The positive rational gaps illustrate why the fourth- and fifth-order bounds are inequalities, whereas the order-two and order-three statements are identities.

## 7. Any finite number of independent inputs

**Corollary 5.** For $m\ge2$ independent binary classical–quantum inputs, define

$$
\kappa_k(P)=\frac{K_k(P)-\delta_k}{1-\delta_k}.
$$

Then

$$
\kappa_k(P^{\oplus m})\ge\prod_{i=1}^m\kappa_k(P^{(i)}),
\qquad
H_k(P^{\oplus m})\le-\frac1{k-1}
 \log\left[\delta_k+(1-\delta_k)\prod_i\kappa_k(P^{(i)})\right]. \tag{25}
$$

Independent erasure channels attain the bound throughout the entropy cube. Equality holds if and only if at least one of the following conditions is satisfied:

1. Some input has identical original blocks: $P^{(i)}_0=P^{(i)}_1$.
2. At most one input fails to have the erasure-type structure (3).

**Proof.** Iterate (2). Every $\kappa_k$ is nonnegative, so the inequality direction is preserved at each step. Alternatively, (13) gives the output moments directly as $\prod_i a_i,\prod_i b_i,\prod_i c_i$.

If a triple is identically zero, then $D_i=0$. At order four this follows from $\operatorname{Tr}D_i^4=0$; at order five it follows from the positive definiteness of $S_i$ on its support and $\operatorname{Tr}S_iD_i^4=0$. Thus the zero-triple condition is equivalent to $P^{(i)}_0=P^{(i)}_1$. In that case both sides of the $\kappa_k$ inequality vanish.

If no triple is zero, then every $a_i>0$. The product triple is constant if and only if every factor triple is constant: when some $a_i>c_i$, the product of the largest coordinates is strictly larger than the product of the smallest coordinates. When two nonconstant triples are combined, the middle term in (16) is strictly positive. At each subsequent combination, the accumulated gap is multiplied by a positive $\kappa_k$ and receives another nonnegative contribution, so strictness is preserved. This proves the equality classification. For erasure channels $\kappa_k=1-e$, which proves sharpness throughout the entropy cube. $\square$

For nonuniform priors, condition 1 must not be replaced by equality of the normalized conditional states: equality of the subnormalized blocks is required.

## 8. Variable-node lower bounds at the dual orders

For binary classical–quantum blocks $R_0,R_1\succeq0$ with $\operatorname{Tr}(R_0+R_1)=1$, define the Petz upper conditional entropy by

$$
\begin{aligned}
J_{1/k}(R)&=\overline H_{1/k}^{\uparrow}(X|B)_R
 =\frac1{k-1}\log L_k(R),\\
L_k(R)&=\operatorname{Tr}(R_0^{1/k}+R_1^{1/k})^k.
\end{aligned} \tag{26}
$$

This is the explicit expression in [1, equation (IV.2)] at the orders considered here. We give a direct proof of the following consequence, without leaving the chain rule as an unexpanded intermediate lemma.

**Corollary 6 (Orders $1/4$ and $1/5$).** For two independent binary inputs, let $J_i=J_{1/k}(R^{(i)})$ and $L_i=e^{(k-1)J_i}$. After the CNOT operation, retain $Z=X_1\oplus X_2$ as side information and consider $X_2$. Then

$$
\overline H_{1/k}^{\uparrow}(X_2|ZB_1B_2)
 \ge\frac1{k-1}\log\left[1+
 \frac{(L_1-1)(L_2-1)}{2^{k-1}-1}\right]. \tag{27}
$$

This lower bound is sharp throughout the entropy square. Equality holds if and only if at least one original input has the structure (3).

**Proof.** Set
$U_i=R_{i,0}^{1/k}/L_i^{1/k}$ and
$V_i=R_{i,1}^{1/k}/L_i^{1/k}$.
Then $\operatorname{Tr}(U_i+V_i)^k=1$ and
$\operatorname{Tr}(U_i^k+V_i^k)=1/L_i$.
The matrix argument in Sections 3–5 only requires $U_i,V_i\succeq0$ and $\operatorname{Tr}(U_i+V_i)^k=1$, so it applies directly to these normalized root blocks. Define

$$
T=\sum_{z=0}^1\operatorname{Tr}
 \left(R_{1,z}^{1/k}\otimes R_{2,0}^{1/k}
 +R_{1,z\oplus1}^{1/k}\otimes R_{2,1}^{1/k}\right)^k.
\tag{28}
$$

Since $Z$ is a classical register, (26) adds the traces from the two $Z$ blocks. Therefore
$\overline H_{1/k}^{\uparrow}(X_2|ZB_1B_2)=(k-1)^{-1}\log T$.
Probabilities are already included in the blocks; no additional conditioning factor is needed. Equation (28) also gives $T=L_1L_2K_\oplus$. Apply (2) and simplify:

$$
T\ge L_1L_2\left[\delta_k+
 \frac{(L_1^{-1}-\delta_k)(L_2^{-1}-\delta_k)}{1-\delta_k}\right]
 =1+\frac{(L_1-1)(L_2-1)}{2^{k-1}-1}.
\tag{29}
$$

Taking positive roots and positive integer powers both preserve the three sectors on which the blocks are identical or have disjoint supports. The equality classification therefore transfers in both directions from Theorem 2 to the original $R$ blocks. For a uniform erasure channel,
$L_k=1+(2^{k-1}-1)e$, and the variable-node erasure probability is $e_1e_2$. Thus equality realizes every $J_i\in[0,\log2]$. Moreover, applying (18) to the normalized root blocks gives $1\le L_k\le2^{k-1}$, so this entropy range is not an additional assumption. $\square$

Equations (28)–(29) are two-input identities. We do not assert their unchanged validity as identities for a variable node with arbitrarily many inputs.

## 9. Novelty, verification, and significance

The literature comparison covers the quantum definitions, original conjecture, and order-two case in [1]; the classical conditional-entropy setting of [2]; the von Neumann entropy problem of [3]; the classical BISO partial orders of [4]; and the published scope of the order-three record [5]. A literature search on 24 November 2026 did not locate the same fourth- or fifth-order quantum erasure bound. This is a conclusion within the scope of the literature checked, not a guarantee of global priority.

Equation (16) gives a computable exact gap in every finite dimension, without measurement optimization, a bound on the side-information dimension, or an identical-distribution assumption. Equation (25) directly controls check nodes with multiple inputs, while (27) controls variable nodes at the dual orders. These are rigorous inequalities for information-combining analysis. We do not additionally establish new coding capacities, finite-blocklength scaling laws, or practical communication gains.

The reproducibility materials include exact rational checks of cyclic-word identities, exact tensor checks using positive semidefinite matrices constructed from complex Gaussian integers, and independent floating-point checks computed directly from the original cq blocks. The computational programs and raw outputs are not included in this version. Finite computational checks do not replace the general proofs in Sections 3–8. 

## Appendix A. The logarithm's argument in the source

Set $x=(K_1-\delta_k)(K_2-\delta_k)/(1-\delta_k)\ge0$. Equation (2) proves
$H_\oplus\le-(k-1)^{-1}\log(x+\delta_k)$.
If the unparenthesized expression in [1, equation (V.16)] is instead read as
$-(k-1)^{-1}\log x+\delta_k$, then for $x>0$,

$$
-\frac1{k-1}\log(x+\delta_k)
\le-\frac1{k-1}\log x
\le-\frac1{k-1}\log x+\delta_k.
$$

Our result therefore implies that weaker reading as well. At $x=0$, $\log x$ is not a finite real number; only under an extended-real limiting interpretation from $x>0$ does the outside-log reading give the trivial upper bound $+\infty$. Our formula remains finite and attains equality at the erasure endpoints. The source record preserves the actual PDF page and this distinction; it does not misquote the original display as already containing explicit logarithm parentheses.

## References

1. C. Hirche, X. Guan, and M. Tomamichel, *Chain Rules for Rényi Information Combining*, ISIT 2023, pp. 204–209. The fixed full-text version used here is [arXiv:2305.02589v1](https://arxiv.org/abs/2305.02589v1), especially equations (IV.1), (IV.2), (V.3), (V.13), and Conjecture V.6. DOI: [10.1109/ISIT54713.2023.10206941](https://doi.org/10.1109/ISIT54713.2023.10206941).
2. C. Hirche, *Rényi Bounds on Information Combining*, ISIT 2020. [arXiv:2004.14408v1](https://arxiv.org/abs/2004.14408v1), Section IV, especially Theorem IV.9 and Lemma IV.10.
3. C. Hirche and D. Reeb, *Bounds on Information Combining With Quantum Side Information*, IEEE Transactions on Information Theory 64 (2018), 4739–4757. [arXiv:1706.09752v2](https://arxiv.org/abs/1706.09752v2), Conjectures VII.1–VII.2.
4. C. Hirche, *Rényi partial orders for BISO channels*, 2025. [arXiv:2508.19951v1](https://arxiv.org/abs/2508.19951v1), Section 4.
5. trureturing, *Order-three Rényi information-combining equality*, [public research record](https://www.trureturing.org/research/hirche-guan-tomamichel-2023-renyi-order-three-equality/) and [source and scope notes](https://the-omega-institute.github.io/trureturing-mdbook/Library/QuantumChannels/hircheguantomamichel2023renyicombining.html), accessed 24 November 2026. We use only the publicly stated scope for novelty comparison and do not rely on the validity of its proof.
