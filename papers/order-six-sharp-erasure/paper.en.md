---
title: "The sharp sixth-order quantum Rényi erasure bound"
subtitle: "Grouped trace covariances, equality, and the reciprocal-order variable node"
lang: en
geometry: margin=1in
fontsize: 11pt
---

## Abstract

For two independent binary sources with arbitrary finite-dimensional quantum side information, we prove the sharp erasure-channel upper bound on the sixth-order sandwiched lower conditional Rényi entropy of their XOR. This resolves the order-six branch of Conjecture V.6 of Hirche, Guan and Tomamichel. Seven cyclic trace moments appear at order six. Two of them can reverse order between the inputs, so the lower-order argument based on a single common ordering does not apply. Grouping the moments by the number of difference factors gives an exact covariance decomposition. A controlled covariance within each group and ordered group means yield the bound and all equality cases. We also give a quantitative moment gap, characterize equality at fixed priors and for multiple inputs, and prove the sharp reciprocal-order Petz variable-node bound.

## 1. Model and theorem

A binary classical–quantum input is represented by positive semidefinite blocks \(P_0,P_1\) with \(\operatorname{Tr}(P_0+P_1)=1\). The traces of the two blocks are the prior probabilities. Put \(r=P_0+P_1\) and define the sixth-order moment and entropy by
\[
K(P)=\sum_{x=0}^1\operatorname{Tr}\big(r^{-5/12}P_xr^{-5/12}\big)^6,
\qquad H(P)=-\tfrac15\log K(P).
\]
Negative powers act on the support of \(r\). For independent inputs \(P^{(1)},P^{(2)}\), their XOR output has blocks
\[
P_z^\oplus=\sum_{x=0}^1P_{z\oplus x}^{(1)}\otimes P_x^{(2)}.
\]

**Theorem 1.** Write \(\delta=1/32\) and \(K_i=K(P^{(i)})\). Then
\[
K(P^\oplus)\ge F(K_1,K_2)
=\delta+\frac{(K_1-\delta)(K_2-\delta)}{1-\delta}. \qquad\text{(1)}
\]
Equivalently the XOR conditional entropy is at most \(-\tfrac15\log F(K_1,K_2)\). Over all allowed states this bound is sharp at every pair of input entropies in \([0,\log2]^2\). Equality holds exactly when at least one input has erasure structure
\[
P_0=C+R_0,\qquad P_1=C+R_1, \qquad\text{(2)}
\]
where \(C,R_0,R_1\) are positive semidefinite with pairwise orthogonal supports. The common block is the erased sector, and the other two sectors distinguish the bit perfectly.

The original conjecture uses independent binary inputs with uniform priors. The proof below also permits nonuniform priors and singular side-information marginals. The constant \(\delta\) belongs inside the logarithm, as obtained by evaluating the erasure channel and the known order-two expression. The sharp bound also implies the weaker outside-log reading of the original unparenthesized display whenever that reading is finite. Fixed lower-order predecessor and source audit

## 2. Seven trace moments and their groups

Since \(0\preceq P_x\preceq r\), the kernel of \(r\) is contained in the kernel of each \(P_x\). Compress to its support. Set
\[
U=r^{-5/12}P_0r^{-5/12},\quad V=r^{-5/12}P_1r^{-5/12},
\quad S=U+V=r^{1/6},\quad D=U-V.
\]
Here \(S>0\), \(D=D^*\), \(S\pm D\succeq0\), and \(\operatorname{Tr}S^6=1\). The proof works for any \(U,V\succeq0\) with this normalization. Their moment is \(\operatorname{Tr}(U^6+V^6)\).

Expand \(U=(S+D)/2\) and \(V=(S-D)/2\). Odd numbers of \(D\) cancel. The nonconstant terms have the following cyclic traces and weights.

| Difference factors | Moment definitions | Weights |
| --- | --- | --- |
| Two | \(a=\operatorname{Tr}S^4D^2,\ b=\operatorname{Tr}S^3DSD,\ c=\operatorname{Tr}S^2DS^2D\) | \(6,6,3\) |
| Four | \(e=\operatorname{Tr}S^2D^4,\ f=\operatorname{Tr}SDSD^3,\ g=\operatorname{Tr}SD^2SD^2\) | \(6,6,3\) |
| Six | \(h=\operatorname{Tr}D^6\) | \(1\) |

For two \(D\)'s, the two runs of \(S\)'s have lengths \(0,4\), \(1,3\) or \(2,2\) up to rotation. Their orbit sizes are six, six and three. The four-\(D\) group has the same counts after exchanging \(S,D\). These moments are real, since each listed trace equals its reversed trace by cyclicity. Let \(w_i\) be the weights, let \(x_i\) be the listed moments of one input, and write
\[
m_2=(2a+2b+c)/5,\qquad m_4=(2e+2f+g)/5,\qquad m_6=h .
\]
Then, with \(W=\sum_i w_i=31\),
\[
K=\delta(1+\textstyle\sum_i w_i x_i)=\delta(1+15m_2+15m_4+h). \qquad\text{(3)}
\]

For the output, its marginal is \(r_1\otimes r_2\). Powers factor on the product support. The resulting sandwiched sums and differences are \(S_1\otimes S_2\) and \(D_1\otimes D_2\). Each retained cyclic trace thus multiplies coordinatewise. If \(x_i,y_i\) are the two input vectors, the exact moment gap in (1) is
\[
\Delta=\delta\left[\sum_i w_i x_i y_i
-\frac{(\sum_i w_i x_i)(\sum_i w_i y_i)}{W}\right]. \qquad\text{(4)}
\]

Within a group \(j\in\{2,4,6\}\), write \(W_j\) for its total weight, and set
\[
Q_j(x,y)=\sum_{i<l\text{ in group }j}w_iw_l(x_i-x_l)(y_i-y_l).
\]
The group means of \(x,y\) are \(m_j(x),m_j(y)\). Expanding the centered products within each group, then applying the same two-factor identity to the three group means, gives
\[
\frac{\Delta}{\delta}
=\sum_j\frac{Q_j(x,y)}{W_j}
+\frac1W\sum_{j<l}W_jW_l
[m_j(x)-m_l(x)][m_j(y)-m_l(y)]. \qquad\text{(5)}
\]
This identity requires no ordering hypothesis. Below we prove that each summand in (5) is nonnegative.

## 3. Covariance within the two nontrivial groups

In an eigenbasis of \(S\), the kernels of \(a-b\) and \(b-c\) multiplying \(|D_{ij}|^2\) after symmetrization are
\[
\tfrac12(s_i-s_j)^2(s_i^2+s_is_j+s_j^2),
\qquad
\tfrac12s_is_j(s_i-s_j)^2.
\]
They are nonnegative. Thus \(a\ge b\ge c\) and \(Q_2(x,y)\ge0\).

For the four-\(D\) group use an eigenbasis of \(D\), with real eigenvalues \(d_i\). The kernels of \(e-f\), \(f-g\) and \(e-g\), respectively, multiplying \(|S_{ij}|^2\) are
\[
\tfrac12(d_i-d_j)^2(d_i^2+d_id_j+d_j^2),\qquad
\tfrac12d_id_j(d_i-d_j)^2,\qquad
\tfrac12(d_i^2-d_j^2)^2 .
\]
The first kernel dominates the absolute value of the second because \(d_i^2+d_id_j+d_j^2\ge|d_id_j|\). Thus \(e-g\ge0\) and \(e-f\ge|f-g|\). Products of the two inputs' \(f-g\) differences can have either sign, but
\[
\begin{aligned}
Q_4(x,y)\ \ge{}&
18(e_1-f_1)(e_2-f_2)\\
&+18(e_1-g_1)(e_2-g_2)\ \ge0 . 
\end{aligned}
\]
Indeed the \(e,f\) pair has weight \(36\), and at most half of that is required to absorb a negative \(f,g\) pair of weight \(18\). The singleton group has \(Q_6=0\).

## 4. Ordering the group means

First \(g\ge h\) by a positive semidefinite congruence:
\[
g-h=\operatorname{Tr}\big(D^2(S-D)D^2(S+D)\big)\ge0 .
\]
The two cross terms cancel cyclically. The displayed trace is the squared Hilbert–Schmidt norm of \((S-D)^{1/2}D^2(S+D)^{1/2}\). In a \(D\)-eigenbasis, the kernel of \(e+f\) after symmetrization equals
\[
\tfrac12(d_i+d_j)^2(d_i^2-d_id_j+d_j^2)\ge0 .
\]
Its diagonal terms give \(e+f\ge2\sum_i d_i^4 S_{ii}^2\ge2h\), because \(S\pm D\succeq0\) implies \(S_{ii}\ge|d_i|\). It follows that \(m_4\ge h\).

For \(m_2\ge m_4\), use the positive semidefinite matrices \(A=S+D\) and \(B=S-D\). Let \(C_j\) be the average cyclic trace over all words of length six with \(j\) occurrences of \(B\) and \(6-j\) of \(A\), counting the words before cyclic identification. In the polynomial \(\operatorname{Tr}(S+tD)^6\),
\[
\operatorname{Tr}(S+tD)^6
=2^{-6}\sum_{j=0}^6\binom6j C_j(1+t)^{6-j}(1-t)^j.
\]
The coefficients of \(t^2,t^4\), each divided by 15, are \(m_2,m_4\). Subtracting gives
\[
m_2-m_4=\tfrac1{16}(C_1+C_5-2C_3). \qquad\text{(6)}
\]
For clarity, the difference between the two polynomial coefficients, multiplied by \(\binom6j/15\), is \(0,4,0,-8,0,4,0\) for \(j=0,\ldots,6\).

Let \(P=\operatorname{Tr}A^3B^3\). Then \(C_1+C_5=\operatorname{Tr}(A^5B+AB^5)\ge2P\). In the spectral bases of \(A,B\), the difference is the sum of the nonnegative terms \(a_i b_j(a_i^2-b_j^2)^2|\langle u_i,v_j\rangle|^2\).

The three-versus-three cyclic words have trace types \(P\), \(Q=\operatorname{Tr}A^2B^2AB\), \(\overline Q\), and \(R=\operatorname{Tr}(AB)^3\), with weights \(6,6,6,2\). One has \(0\le R\le P\). The lower bound follows from \(R=\operatorname{Tr}(B^{1/2}AB^{1/2})^3\). For the upper bound, write \(X=A^{1/2}B^{1/2}\), so \(R=\|X\|_6^6\). Schatten interpolation on the strip \(0\le\operatorname{Re}z\le1\) applied to \(A^{3z/2}B^{3z/2}\) gives
\[
\|A^{1/2}B^{1/2}\|_6
\le\|A^{3/2}B^{3/2}\|_2^{1/3}.
\]
To verify the interpolation here, first take \(A,B>0\). At the left boundary the operator norm is one, and at the right boundary the Hilbert–Schmidt norm equals its value at \(z=1\) by the unitary imaginary powers. For the scalar three-lines argument, let \(X=U_0\operatorname{diag}(\sigma_i)V_0^*\) and \(t_i=\sigma_i^5/\|X\|_6^5\). Pair the analytic matrix with \(V_0\operatorname{diag}(t_i^{(6/5)(1-z/2)})U_0^*\) under the trace. This test has trace norm one on the left, Hilbert–Schmidt norm one on the right, and pairs to \(\|X\|_6\) at \(z=1/3\). Three-lines gives the inequality. Singular \(A,B\) follow by adding positive multiples of the identity and taking a limit in the trace inequality. The right-hand side raised to the sixth power is \(P\).

Finally
\[
Q=\operatorname{Tr}\big[(A^{3/2}B^{3/2})(B^{1/2}AB A^{1/2})\big].
\]
The squared Hilbert–Schmidt norms of these two factors are \(P,R\). Thus \(\operatorname{Re}Q\le\sqrt{PR}\le P\). This yields \(C_3\le P\). Equation (6) proves \(m_2\ge m_4\), completing the order \(m_2\ge m_4\ge h\).

## 5. Equality, sharpness and fixed priors

The covariance identity (5) now gives \(\Delta\ge0\). In fact its two-versus-six term alone gives
\[
\Delta\ge\frac{15}{32\cdot31}(m_2(x)-h(x))(m_2(y)-h(y)).
\qquad\text{(7)}
\]
If \(m_2=h\) for one input, then \(m_4=h\), so \(e+f=2h\) by Section 4. The diagonal lower bound in that section forces \(S_{ii}=|d_i|\) whenever \(d_i\ne0\). The \(i\)-th diagonal entry of either \(S-D\) or \(S+D\) is then zero. In a positive semidefinite matrix a zero diagonal forces the entire row and column to vanish, by its two-by-two principal minors. Hence each such row of \(S\) is diagonal. The remaining block has \(D=0\). This is precisely a commuting decomposition with \(D=S\), \(D=-S\), or \(D=0\) on orthogonal sectors. Reconstructing \(P_x=S^{5/2}U_x S^{5/2}\), where \(U_0=(S+D)/2\) and \(U_1=(S-D)/2\), gives (2). Conversely (2) makes all seven moments equal. Thus if one input has erasure structure, (4) is zero, and otherwise (7) is strictly positive.

For the moment range, (3) and the ordering give \(K\ge\delta\). For \(0\preceq X\preceq S\), diagonalize \(X\) and apply scalar Jensen to the spectral measure of \(S\) at each eigenvector of \(X\). This gives \(\operatorname{Tr}X^6\le\operatorname{Tr}XS^5\), since \(\langle e,S^5e\rangle\ge\langle e,Se\rangle^5\ge x^5\). Sum for \(X=U,V\) to get \(K\le\operatorname{Tr}S^6=1\). The order-six conditional entropy is therefore in \([0,\log2]\). A uniform-prior erasure input of erasure probability \(\epsilon\) has \(K=1-(1-\delta)\epsilon\). Two such inputs attain equality and realize the entire pairwise entropy range. Equation (7) also bounds the entropy gap below by \(15(m_2(x)-h(x))(m_2(y)-h(y))/(5\cdot32\cdot31)\), using \(\log(1+t)\ge t/(1+t)\) and \(K(P^\oplus)\le1\).

There is an exact attainment criterion when the priors are fixed. For one input with prior \(p=\operatorname{Tr}P_0\), Schatten Hölder gives \(\operatorname{Tr}P_x=\operatorname{Tr}(r^{5/6}U_x)\le(\operatorname{Tr}U_x^6)^{1/6}\). Over finite dimensions allowed to vary, the feasible interval of \(K\) is \([p^6+(1-p)^6,1]\): its endpoints are realized by identical conditional side information and perfect distinguishability, and an orthogonally flagged mixture realizes every intermediate value with the same prior. In (2) the common block has trace \(s\in[0,\min(p,1-p)]\) and \(K=1-2(1-\delta)s\). Conversely every such \(s\) can be realized on three sectors with the appropriate prior. It follows that for feasible prescribed priors and moments, equality in (1) is attainable exactly when at least one input satisfies \(K_i\ge1-2(1-\delta)\min(p_i,1-p_i)\). The criterion is about equality at given feasible moments.

## 6. Multiple inputs and the reciprocal-order variable node

For finitely many independent inputs, set \(t_i=(K_i-\delta)/(1-\delta)\). Repeated application of (1) gives \(t_\oplus\ge\prod_i t_i\). Equality holds when some input is completely erased, or when at most one input lacks erasure structure. To see this, \(t_i=0\) holds exactly when \(D_i=0\), by (3) and \(h_i=\operatorname{Tr}D_i^6\). Such a factor erases the tensor difference completely. If all \(t_i>0\) and at least two inputs lack erasure structure, combine those two first. Their strict inequality propagates through multiplication by all subsequent positive factors. If at most one input lacks erasure structure, combine the erasure inputs first. Their XOR is again erasure-type, since the relative eigenvalues \(d/s\) in each tensor factor lie in \(\{0,\pm1\}\). The final comparison is then an equality.

For the Petz upper conditional entropy of order \(1/6\), let \(R_0,R_1\) be the original positive blocks and define \(L(R)=\operatorname{Tr}(R_0^{1/6}+R_1^{1/6})^6\). Its conditional entropy is \(\tfrac15\log L(R)\). At a two-input variable node retain \(Z=X_1\oplus X_2\) as side information and consider \(X_2\). If the input moments are \(L_1,L_2\), then
\[
\overline H_{1/6}^{\uparrow}(X_2\mid Z B_1B_2)
\ge\frac15\log\!\left[1+\frac{(L_1-1)(L_2-1)}{31}\right]. \qquad\text{(8)}
\]
Apply the already proved matrix inequality to \(U_i=R_{i,0}^{1/6}/L_i^{1/6}\) and \(V_i=R_{i,1}^{1/6}/L_i^{1/6}\). Their normalized sums have sixth trace one and their moments are \(1/L_i\). The output of this matrix calculation consists of the CNOT root blocks
\[
R_{1,z}^{1/6}\otimes R_{2,0}^{1/6}
+R_{1,z\oplus1}^{1/6}\otimes R_{2,1}^{1/6},
\]
rescaled by \((L_1L_2)^{-1/6}\). Summing the sixth traces of the displayed unscaled blocks over the classical register \(z\) gives the variable-node moment \(L_1L_2K_\oplus\). Substitution in (1) gives (8). Taking roots preserves the equality sectors in both directions, so equality holds exactly when one original input has erasure structure. Erasure inputs give \(L_i=1+31\epsilon_i\) and attain the bound throughout the entropy square.

## 7. Verification and source scope

Hirche, Guan and Tomamichel, *Chain Rules for Rényi Information Combining*, ISIT 2023, arXiv:2305.02589v1, Conjecture V.6 and equation (V.16), proposes the general quantum erasure bound. Its established order-two case and the fixed lower-order repository case are prior results. [Primary version recorded in the archive](https://arxiv.org/abs/2305.02589v1)

The cyclic expansion and tensor multiplication extend the predecessor's setup. The new argument is the grouped covariance estimate at order six, particularly its handling of potentially opposing \(f-g\) differences and the cross-group mean comparison. The accompanying exact checks include a pair of inputs with opposite signs of \(f-g\). This manuscript addresses order six and its reciprocal-order consequence. The independently reviewed analytic proof covers arbitrary finite matrix dimensions. Lean verification is tracked separately, and the source comparison is bounded to the fixed repository records.
