---
title: "The sharp seventh-order quantum Rényi erasure bound"
subtitle: "Complex trace words and a positive Gram-matrix covariance"
lang: en
geometry: margin=1in
fontsize: 11pt
---

## Abstract

We prove the order-seven branch of the quantum Rényi erasure conjecture of Hirche, Guan and Tomamichel. The bound is sharp for two independent binary classical–quantum sources with arbitrary finite-dimensional side information, including noncommuting states and singular marginals. At order seven, two cyclic trace moments are complex conjugates. Their tensor products introduce an imaginary-part term whose sign depends on the orientation of the two inputs. A Hilbert–Schmidt Gram matrix controls the whole covariance in that group, and two operator inequalities order the group means. The result gives all equality cases, a quantitative gap, multiple-input bounds and the sharp order-\(1/7\) Petz variable-node inequality.

## 1. Model and statement

Let \(P_0,P_1\) be positive semidefinite operators on a common finite-dimensional complex space, with \(\operatorname{Tr}(P_0+P_1)=1\), and write \(r=P_0+P_1\). The sandwiched lower conditional Rényi entropy of order seven is
\[
H(P)=-\tfrac16\log K(P),\qquad
K(P)=\sum_{x=0}^1\operatorname{Tr}\big(r^{-3/7}P_xr^{-3/7}\big)^7.
\]
Inverse powers are taken on the support of \(r\). For two independent inputs, put
\[
P_z^\oplus=\sum_{x=0}^1P^{(1)}_{z\oplus x}\otimes P^{(2)}_x .
\]

**Theorem 1.** With \(\delta=1/64\) and \(K_i=K(P^{(i)})\),
\[
K(P^\oplus)\ge F(K_1,K_2)
=\delta+\frac{(K_1-\delta)(K_2-\delta)}{1-\delta}. \qquad\text{(1)}
\]
Thus \(H(P^\oplus)\le-\tfrac16\log F(K_1,K_2)\). The entropy bound is sharp throughout \([0,\log 2]^2\). Equality holds exactly when at least one input has the structure
\[
P_0=C+R_0,\qquad P_1=C+R_1, \qquad\text{(2)}
\]
where \(C,R_0,R_1\) are positive semidefinite with pairwise orthogonal supports.

The original conjecture uses uniform priors. We allow any priors and use the sharp normalization with \(\delta\) inside the logarithm, as fixed by the erasure channel and the established order-two formula. The same inequality implies the weaker outside-log reading when that reading is finite. Earlier archived cases treat orders four, five and six. Fixed source records · Order-six case

## 2. Cyclic moments and their tensor covariance

Compress to the support of \(r\) since \(0\preceq P_x\preceq r\). Set
\[
U=r^{-3/7}P_0r^{-3/7},\qquad V=r^{-3/7}P_1r^{-3/7},\qquad
S=U+V=r^{1/7},\qquad D=U-V .
\]
Then \(S>0\), \(D=D^*\), \(S\pm D\succeq0\), and \(\operatorname{Tr}S^7=1\). Conversely the trace argument below uses only these conditions. Define the trace moments as follows.

| Number of difference factors | Cyclic moments |
| --- | --- |
| Two | \(a=\operatorname{Tr}S^5D^2,\ b=\operatorname{Tr}S^4DSD,\ c=\operatorname{Tr}S^3DS^2D\) |
| Four | \(E=\operatorname{Tr}S^3D^4,\ F_0=\operatorname{Tr}S^2D^3SD,\ \overline{F_0},\ G=\operatorname{Tr}S^2D^2SD^2,\ J=\operatorname{Tr}SD^2SDSD\) |
| Six | \(h=\operatorname{Tr}SD^6\) |

Every listed word represents seven rotations, because seven is prime and the word is nonconstant. For two differences the successive \(S\)-run lengths are \(0,5\), \(1,4\), or \(2,3\) up to interchange. For four differences the \(D\)-run lengths between consecutive \(S\)'s, up to cyclic permutation, are \((4,0,0),(3,1,0),(3,0,1),(2,2,0),(2,1,1)\). The opposite orientations of the middle pair give complex conjugates. Expanding \(U=(S+D)/2,V=(S-D)/2\) cancels all odd-\(D\) words. With the group means
\[
m_2=(a+b+c)/3,\quad
m_4=(E+2\operatorname{Re}F_0+G+J)/5,\quad m_6=h,
\]
the input moment is \(K=\delta(1+21m_2+35m_4+7h)\).

For the XOR, the marginal is \(r_1\otimes r_2\). Hence the sandwiched \(S,D\) matrices are \(S_1\otimes S_2,D_1\otimes D_2\), and every cyclic trace multiplies coordinatewise. The complex pair contributes \(2\operatorname{Re}(F_{0,1}F_{0,2})\). Its real value includes the term \(-2\operatorname{Im}F_{0,1}\operatorname{Im}F_{0,2}\).

Give each coordinate weight seven and the groups total weights \(W_2=21,W_4=35,W_6=7\), with \(W=63\). For coordinate lists \(u,v\), denote the weighted within-group covariance by
\[
B_j(u,v)=7\left[\sum_{i\in j}u_i v_i
-\frac{(\sum_{i\in j}u_i)(\sum_{i\in j}v_i)}{\#j}\right].
\]
Here \(\#j\) is the number of coordinates in the group. In the complex pair the products do not conjugate one input. They are the actual tensor trace products. Writing \(\Delta=K(P^\oplus)-F(K_1,K_2)\), expansion gives
\[
\frac{\Delta}{\delta}
=\sum_j B_j(u,v)
+\frac1{63}\sum_{j<l} W_jW_l
[m_j(u)-m_l(u)][m_j(v)-m_l(v)] .
\qquad\text{(3)}
\]
Indeed subtract the product of the two overall sums divided by \(63\) from the total weighted coordinate products, then insert the product of each group's sums divided by its weight. The remaining covariance of group means expands into the pairwise differences in (3). Every quantity is real by the paired conjugates.

## 3. The complex within-group term

In an eigenbasis of \(S\), the differences \(a-b\) and \(b-c\) have the respective nonnegative kernels
\[
\tfrac12(s_i-s_j)(s_i^4-s_j^4),
\qquad
\tfrac12s_i s_j(s_i-s_j)^2(s_i+s_j)
\]
multiplying \(|D_{ij}|^2\). Thus \(a\ge b\ge c\), which gives \(B_2\ge0\) by the pairwise covariance identity. Also \(B_6=0\).

Use the Hilbert–Schmidt matrices
\[
X=D^2S^{3/2},\qquad Z=SD^2S^{1/2},\qquad Y=DSDS^{1/2}.
\]
With inner product \(\langle U,V\rangle=\operatorname{Tr}(U^*V)\), their squared norms in order \(X,Z,Y\) are \(E,G,J\), and
\[
\langle X,Z\rangle=G,\qquad
\langle Z,Y\rangle=J,\qquad
\langle X,Y\rangle=F_0.
\]
These equalities follow by cyclic rotation. In particular the real quantities \(x=E-G\) and \(y=G-J\) are nonnegative, while \(f=F_0-J\) satisfies \(|f|^2\le xy\). Indeed \(x=\|X-Z\|_2^2,\ y=\|Y-Z\|_2^2,\ f=\langle X-Z,Y-Z\rangle\).

Subtracting the constant coordinate \(J\) from the four-difference group leaves \((x+y,f,\overline f,y,0)\) and preserves its covariance. Let the second input's corresponding values be \(X_0,Y_0,U_0+iV_0\), with \(X_0,Y_0\ge0\) and \(U_0^2+V_0^2\le X_0Y_0\). The numerator \(N\) of the unweighted covariance, before division by five, is
\[
N=5\sum_{i\in4}u_i v_i-(\textstyle\sum_{i\in4}u_i)(\textstyle\sum_{i\in4}v_i).
\]
Expanding using the shifted coordinates gives \(N=\operatorname{Tr}(Q M)\), where
\[
Q=\begin{pmatrix}x&f\\\overline f&y\end{pmatrix},\quad
M=\begin{pmatrix}
4X_0+3Y_0-2U_0 & -X_0-2Y_0+3U_0-5iV_0\\
-X_0-2Y_0+3U_0+5iV_0 & 3X_0+6Y_0-4U_0
\end{pmatrix}.
\]
For example, the off-diagonal contribution to \(\operatorname{Tr}(QM)\) is \(2\operatorname{Re}(f\,\overline{M_{12}})\), whose imaginary term is \(-10\operatorname{Im}(f)V_0\). The matrix \(Q\) is positive semidefinite by the Gram inequality. The diagonal entries of \(M\) are nonnegative by \(2|U_0|\le X_0+Y_0\). Its determinant has the exact decomposition
\[
\begin{aligned}
\det M={}&25(X_0Y_0-U_0^2-V_0^2)
+24(U_0-X_0/3-Y_0/4)^2\\
&+\tfrac{25}{3}X_0^2+\tfrac{25}{2}Y_0^2 .
\end{aligned}
\]
Thus \(M\succeq0\) and \(B_4=7N/5\ge0\).

There is also a gap from this group alone. The diagonal sum of \(M\) is at most \(12(X_0+Y_0)\), and its determinant is at least \(\tfrac{25}{6}(X_0+Y_0)^2\). If \(X_0+Y_0>0\), divide the determinant by the trace to bound the smallest eigenvalue below by \(\tfrac{25}{72}(X_0+Y_0)\). The zero case has the same bound. It follows that
\[
B_4\ge \tfrac{35}{72}(E_1-J_1)(E_2-J_2). \qquad\text{(4)}
\]

## 4. Ordering the three group means

We first show \(m_2\ge m_4\). In the same \(S\)-eigenbasis, the kernel of \(a+c-2b\) is \(\tfrac12(s_i-s_j)^2(s_i^3+s_j^3)\), multiplying \(|D_{ij}|^2\). Thus \(m_2\ge b\). Put \(K_0=S^{-1/2}DS^{-1/2}\), a Hermitian contraction because \(S\pm D\succeq0\), and \(T=K_0 S K_0\). Cyclic expansion gives
\[
E=\operatorname{Tr}S^4 T S T\le\operatorname{Tr}S^5 T^2
\le\operatorname{Tr}S^5 K_0 S^2 K_0=b .
\]
The first inequality compares symmetrized eigenbasis kernels, using \(s_i^4s_j+s_j^4s_i\le s_i^5+s_j^5\). The second follows from \(T^2=K_0 S K_0^2 S K_0\preceq K_0 S^2 K_0\). Section 3 gives \(E\ge G\ge J\ge0\), and \(|F_0|\le\sqrt{EJ}\le E\). Averaging proves \(m_4\le E\le b\le m_2\).

For the lower comparison, \(m_4-J=(x+2y+2\operatorname{Re}f)/5\) is at least
\[
[(\sqrt x-\sqrt y)^2+y]/5\ge0 .
\]
To see \(J\ge h\), note that \(S\succeq D S^{-1}D\) follows from \(K_0^2\preceq I\). Therefore \(DSD\succeq D^2 S^{-1}D^2\) and \(SD^2S\succeq0\), so
\[
J=\operatorname{Tr}(SD^2S)(DSD)\ge
\|S^{-1/2}D^2 S D\|_2^2 .
\]
Pair the factor on the right with \(S^{1/2}D^3\). Their Hilbert–Schmidt pairing is \(h\) by cyclic trace, and the second factor has squared norm \(h\). Cauchy–Schwarz gives \(\|S^{-1/2}D^2 S D\|_2^2\ge h\) for \(h>0\); for \(h=0\) the conclusion is immediate. We have proved \(m_2\ge m_4\ge h\). Equation (3) now yields (1), and together with (4) it gives
\[
\Delta\ge
\tfrac7{192}(m_{2,1}-h_1)(m_{2,2}-h_2)
+\tfrac{35}{4608}(E_1-J_1)(E_2-J_2).
\qquad\text{(5)}
\]

## 5. Equality, fixed priors, and an orientation witness

If \(m_2=h\), then \(m_4=J=h\), forcing \(x=y=0\) by the displayed bound on \(m_4-J\). In particular \(Z=Y\), so \((SD^2-DSD)S^{1/2}=0\) and \([S,D]D=0\). In a \(D\)-eigenbasis, every column of the commutator with nonzero eigenvalue vanishes. Its skew-adjointness gives the corresponding rows, and between two zero eigenvalues the commutator vanishes as well. Hence \(S,D\) commute. In their joint eigenbasis \(m_4-h=\sum_i s_i d_i^4(s_i^2-d_i^2)\), a sum of nonnegative terms. Equality forces \(d_i=0\) or \(d_i=\pm s_i\) for each \(i\). Using \(P_0=S^3(S+D)S^3/2\) and \(P_1=S^3(S-D)S^3/2\) gives (2). Conversely, (2) makes all nine moments equal. If neither input has that structure, both \(m_{2,i}-h_i\) are positive and (5) is strict.

The moment range is \(\delta\le K\le1\). For the lower end use the ordered nonnegative group means. For the upper end, if \(0\preceq X\preceq S\), then \(\operatorname{Tr}X^7\le\operatorname{Tr}XS^6\) by applying scalar Jensen to the spectral measure of \(S\) in each eigenvector of \(X\). Add this for \(X=U,V\). Uniform-prior erasure channels have \(K=1-(1-\delta)\epsilon\) for erasure probability \(\epsilon\), so equality realizes the entire entropy square. The same moment gap is an entropy-gap lower bound after division by six, by \(\log(1+t)\ge t/(1+t)\) and \(K(P^\oplus)\le1\).

For fixed prior \(p\), the attainable values of \(K\) over finite dimensions allowed to vary form \([p^7+(1-p)^7,1]\). Schatten Hölder applied to \(\operatorname{Tr}P_x=\operatorname{Tr}(r^{6/7}U_x)\) gives the lower end. The two endpoints are obtained by identical conditional states and by perfectly distinguishable ones. Orthogonally flagged mixtures preserve the prior and interpolate the moment. An erasure-type input has \(K=1-2(1-\delta)s\), where \(s=\operatorname{Tr}C\) can be any value in \([0,\min(p,1-p)]\). With feasible prescribed moments and priors, equality in (1) is therefore attainable precisely when at least one \(K_i\) is at least \(1-2(1-\delta)\min(p_i,1-p_i)\).

To exhibit genuine complex orientation, take the unnormalized pair
\[
S_0=\begin{pmatrix}8&1&-i\\1&8&1\\i&1&8\end{pmatrix},
\qquad D_0=\operatorname{diag}(1,2,3).
\]
Both signed sums are strictly positive by diagonal dominance. Direct multiplication gives \(\operatorname{Tr}(S_0^2D_0^3S_0D_0)=53632-12i\). Scale both matrices by \((\operatorname{Tr}S_0^7)^{-1/7}\). Combining this input with its complex conjugate rather than with itself increases the output moment by \(\tfrac7{16}(\operatorname{Im}F_0)^2\), with unchanged input moments \(K_i\). This follows because \(F_0^2+\overline{F_0}^2\) is replaced by \(2|F_0|^2\) in the same two weighted coordinates. In dimension at most two, diagonalize \(D\) and remove the phase of the sole off-diagonal entry of \(S\) by a diagonal unitary. Then all cyclic traces are real. Dimension three is therefore the smallest dimension for this complex term.

## 6. Multiple inputs and the reciprocal-order variable node

Let \(t_i=(K_i-\delta)/(1-\delta)\). Iteration gives \(t_\oplus\ge\prod_i t_i\). Equality holds if some input is completely erased or at most one input lacks erasure structure. Indeed \(t_i=0\) if and only if \(D_i=0\) by the ordered groups and \(h_i=\operatorname{Tr}S_iD_i^6\). This gives \(D_\oplus=0\) whenever such a factor appears. If all factors are positive and two lack erasure structure, combine those two first; the positive remaining factors preserve the strict gap. Otherwise combine the erasure inputs first, whose tensor combination is again erasure-type, and then combine the possible exceptional factor.

For binary positive blocks \(R_0,R_1\) of total trace one, put \(L(R)=\operatorname{Tr}(R_0^{1/7}+R_1^{1/7})^7\). Its order-\(1/7\) Petz upper conditional entropy is \(\tfrac16\log L(R)\). For two inputs, retain \(Z=X_1\oplus X_2\) at the variable node. If their moments are \(L_1,L_2\), then
\[
\overline H_{1/7}^{\uparrow}(X_2\mid ZB_1B_2)
\ge\tfrac16\log\!\left[1+\frac{(L_1-1)(L_2-1)}{63}\right].
\]
Apply (1) at the matrix level to \(U_i=R_{i,0}^{1/7}/L_i^{1/7}\) and \(V_i=R_{i,1}^{1/7}/L_i^{1/7}\), whose moments are \(1/L_i\). The two XOR root blocks, before rescaling, are \(R_{1,z}^{1/7}\otimes R_{2,0}^{1/7}+R_{1,z\oplus1}^{1/7}\otimes R_{2,1}^{1/7}\). Since \(Z\) is classical, their seventh traces add, giving the variable-node moment \(L_1L_2 K_\oplus\). Substitution gives the claimed expression. Roots preserve erasure structure in both directions, giving the same equality classification. Erasure inputs with \(L_i=1+63\epsilon_i\) show sharpness at every input entropy pair.

## 7. Source and verification

Hirche, Guan and Tomamichel, *Chain Rules for Rényi Information Combining*, ISIT 2023, arXiv:2305.02589v1, §V.B Conjecture V.6 and equation (V.16), supplies the exact question. The known low-order cases and archived order-six theorem use the same normalization. [Primary version recorded in the archive](https://arxiv.org/abs/2305.02589v1)

The new proof handles the conjugate cyclic pair by a positive matrix acting on its Gram data. This also yields its independent contribution to the gap in (5). The exact arithmetic checks compare the word expansion with tensor powers and verify the determinant identity and complex orientation witness. The general bound is proved analytically and independently reviewed. Source comparisons are bounded to the fixed repository records. Lean verification is tracked separately.
