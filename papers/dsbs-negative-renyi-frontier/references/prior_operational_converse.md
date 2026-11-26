# An operational converse for arbitrary local block kernels

Unpublished research note, 25 November 2026.

## 1. Model, conventions and the attributed input

All alphabets in this section are nonempty and finite, and logarithms are to
base two. A probability law \(\pi\) on
\(\mathcal X\times\mathcal Y\) has full support. This assumption holds for
every DSBS parameter \(0\lt \epsilon\lt 1/2\). The finite-alphabet notation
avoids an unnecessary symmetry assumption in the converse; the application studied here is DSBS.

At block length \(n\), let \(M\geq1\) be an integer, and let \(A_m\) and
\(B_m\) be arbitrary probability distributions on \(\mathcal X^n\) and
\(\mathcal Y^n\). Neither distribution is required to factor over time.
Write

\[
 P(x^n,y^n,m)=\frac1M A_m(x^n)B_m(y^n),\qquad
 P_n(x^n,y^n)=\sum_mP(x^n,y^n,m),\qquad R_n=\frac{\log M}{n}.
\]

Private randomness is absorbed into the local kernels. No communication is
available. Put \(\alpha=1+\beta\), where \(0\lt \beta\lt \infty\), and
\(c_\beta=(1+\beta)/\beta\). At \(\beta=\infty\), set \(c_\infty=1\)
and use \(D_\infty\) directly. Define

\[
 d_n= D_{1+\beta}(\pi^{\otimes n}\Vert P_n)
 \quad(\beta\lt \infty),\qquad
 d_n=D_\infty(\pi^{\otimes n}\Vert P_n)
 \quad(\beta=\infty).
\]

For a joint law \(Q\) on one pair, define the established relaxed Wyner
quantity

\[
 C(Q,t)=\inf_{Q_{W|XY}:\ I(X;Y\mid W)\leq t}I(XY;W),\qquad t\geq0.
\tag{1}
\]

The infimum may be taken over finite auxiliaries. The cardinality and limiting
facts needed below are proved in Section 5. Conditional distributions on events
of probability zero can be assigned arbitrarily; entropy and KL terms use
\(0\log0=0\) and the usual extended-value convention.

The following is an **attributed input**, not a contribution of this project:
Yu, *Rényi Common Information for Doubly Symmetric Binary Sources*,
[arXiv:2407.06132v1](https://arxiv.org/abs/2407.06132v1), Theorem 1(3),
equations (14)–(15), proves

\[
 \widetilde T_{-\beta}(\pi)\leq T_{-\beta}(\pi)
 \leq\Gamma_{-\beta}^{\rm UB}(\pi),\qquad
 \Gamma_{-\beta}^{\rm UB}(\pi)=
 \sup_Q C\bigl(Q,c_\beta D(Q\Vert\pi)\bigr).
\tag{2}
\]

This input includes \(\beta=\infty\). We do not infer that endpoint by
interchanging a block-length limit with an order limit. Its operational model
is the same uniform-seed, arbitrary-local-block-kernel model. Allowing arbitrary
integers \(M_n\) and measuring their limsup rate includes the paper's
fixed-rate constructions (integer rounding costs \(o(1)\) rate).

## 2. A variational inequality with the correct direction

**Lemma 1.** Let \(U,V\) be positive probability laws on a finite set, and
let \(S\) be any probability law on that set, including one with zeros.
For \(0\lt \beta\lt \infty\),

\[
 D(S\Vert V)\leq c_\beta D(S\Vert U)+D_{1+\beta}(U\Vert V).
\tag{3}
\]

At \(\beta=\infty\), the same assertion holds with \(c_\infty=1\)
and \(D_\infty\) in place of \(D_{1+\beta}\).

*Proof.* Let

\[
 Z=\sum_z U(z)^{1+\beta}V(z)^{-\beta},\qquad
 L(z)=Z^{-1}U(z)^{1+\beta}V(z)^{-\beta}.
\]

Nonnegativity of KL gives

\[
 0\leq D(S\Vert L)
  =(1+\beta)D(S\Vert U)-\beta D(S\Vert V)+\log Z.
\]

Divide by \(\beta\). For the infinite-order case,

\[
 D(S\Vert V)-D(S\Vert U)
  =\sum_z S(z)\log\frac{U(z)}{V(z)}
  \leq\max_z\log\frac{U(z)}{V(z)}.
\]

This proves the assertion. If \(V\) vanishes where \(U>0\), the relevant
Rényi divergence is infinite and its finite bound is vacuous. \(\square\)

Apply the lemma with \(U=\pi^{\otimes n}\), \(V=P_n\), and
\(S=Q^{\otimes n}\). When \(d_n\lt \infty\), full support of \(\pi\)
forces \(P_n>0\), and product additivity gives

\[
 D(Q^{\otimes n}\Vert P_n)
 \leq c_\beta nD(Q\Vert\pi)+d_n.
\tag{4}
\]

The test law \(Q\) is chosen independently of the code and may be
asymmetric or have zeros. In particular, no distributional symmetry of the
code is being imposed.

## 3. The code posterior, without a false Markov assumption

For \(d_n\lt \infty\), define a new joint law by retaining the actual code's
posterior of the seed:

\[
 \widehat Q(x^n,y^n,m)
 =Q^{\otimes n}(x^n,y^n)P(m\mid x^n,y^n).
\tag{5}
\]

Its pair-block marginal is exactly \(Q^{\otimes n}\). The law of the seed
under \(\widehat Q\) is generally **not uniform**, and
\(X^n,Y^n\) are generally **not independent conditional on the seed**.
The proof needs neither property.

**Lemma 2 (posterior decomposition).** With entropies and informations in the
following expression evaluated under \(\widehat Q\),

\[
\begin{aligned}
 D(Q^{\otimes n}\Vert P_n)
 &=D(\widehat Q\Vert P)\\
 &=D(\widehat Q_M\Vert\operatorname{Unif}[M])
   +I(X^n;Y^n\mid M)\\
 &\quad+\sum_m\widehat Q_M(m)
  \left[D(\widehat Q_{X^n|m}\Vert A_m)
       +D(\widehat Q_{Y^n|m}\Vert B_m)\right].
\end{aligned}
\tag{6}
\]

Consequently,

\[
 I(X^n;Y^n\mid M)\leq D(Q^{\otimes n}\Vert P_n),
 \qquad I(X^nY^n;M)\leq H(M)\leq\log M.
\tag{7}
\]

*Proof.* Wherever \(\widehat Q(x^n,y^n,m)>0\), both the code joint law
and its pair marginal are positive, and

\[
 \frac{\widehat Q(x^n,y^n,m)}{P(x^n,y^n,m)}
 =\frac{Q^{\otimes n}(x^n,y^n)}{P_n(x^n,y^n)}.
\]

Summing its logarithm proves the first identity. The chain rule for KL splits
the joint divergence into the seed divergence and the conditional divergence
to \(A_mB_m\). For any joint law \(J\) absolutely continuous with respect
to a product \(AB\), direct expansion of the logarithm gives

\[
 D(J\Vert AB)=I_J(X;Y)+D(J_X\Vert A)+D(J_Y\Vert B).
\]

The required absolute continuity follows from (5); terms with zero seed
weight are omitted. All terms in (6) are finite in this case. Their
nonnegativity proves the first inequality in (7). The entropy bound for a
random variable on at most \(M\) points proves the second. \(\square\)

## 4. Two histories in the auxiliary variable

Set \(Z_i=(X_i,Y_i)\), and write
\(Z^{i-1}=(X^{i-1},Y^{i-1})\). Under \(\widehat Q\), the sequence
\(Z_1,\ldots,Z_n\) is independent with common law \(Q\), even though
the seed posterior creates dependence conditional on \(M\).
Define

\[
 W_i=(M,X^{i-1},Y^{i-1}).
\]

**Lemma 3 (simultaneous single-letter bounds).**

\[
 \sum_{i=1}^n I(Z_i;W_i)=I(Z^n;M),
 \qquad
 \sum_{i=1}^n I(X_i;Y_i\mid W_i)
 \leq I(X^n;Y^n\mid M).
\tag{8}
\]

*Proof.* Productness of the pair marginal and the entropy chain rule give

\[
\begin{aligned}
 \sum_i I(Z_i;M,Z^{i-1})
 &=\sum_i H(Z_i)-\sum_i H(Z_i\mid M,Z^{i-1})\\
 &=H(Z^n)-H(Z^n\mid M).
\end{aligned}
\]

For the second bound, expand each conditional mutual information as an
entropy difference. Conditioning reduces entropy, so

\[
\begin{aligned}
 &\sum_i\{H(X_i\mid M,X^{i-1},Y^{i-1})
          +H(Y_i\mid M,X^{i-1},Y^{i-1})
          -H(X_iY_i\mid M,X^{i-1},Y^{i-1})\}\\
 &\leq\sum_i H(X_i\mid M,X^{i-1})
       +\sum_i H(Y_i\mid M,Y^{i-1})
       -H(X^nY^n\mid M)\\
 &=I(X^n;Y^n\mid M).
\end{aligned}
\]

The direction is essential: removing the other terminal's past increases
the first two conditional entropy terms. No memorylessness of \(A_m\) or
\(B_m\) has been used. \(\square\)

Let \(J\) be uniform on \(\{1,\ldots,n\}\), independent of the entire
tilted law, and define

\[
 (X,Y)=(X_J,Y_J),\qquad W=(J,W_J).
\]

Every coordinate pair has the same law \(Q\), so \((X,Y)\) is independent
of \(J\). Combining (4), (7) and (8) yields

\[
 I(XY;W)\leq R_n,\qquad
 I(X;Y\mid W)\leq c_\beta D(Q\Vert\pi)+d_n/n.
\tag{9}
\]

This proves the finite-block converse

\[
 \boxed{\quad C\bigl(Q,c_\beta D(Q\Vert\pi)+d_n/n\bigr)\leq R_n
       \quad\text{for every }Q.\quad}
\tag{10}
\]

The auxiliary alphabet in this construction may depend on the code and grow
with \(n\). That causes no gap: the next section gives a uniform finite
cardinality reduction preserving both informations.

## 5. Cardinality, attainment and the vanishing-tolerance limit

Let \(k=|\mathcal X||\mathcal Y|\). For a joint law \(p\) on one pair,
consider its \(k-1\) independent masses together with

\[
 H(p),\qquad I_p(X;Y)=H(p_X)+H(p_Y)-H(p).
\]

These \(k+1\) coordinates are continuous on the closed probability simplex.
A finite auxiliary induces a convex combination of these vectors. The
Carathéodory theorem replaces that combination by at most \(k+2\) vectors,
preserving the pair marginal, \(H(XY\mid W)\), and \(I(X;Y\mid W)\).
Since the pair marginal is fixed, this also preserves \(I(XY;W)\).
Thus \(|\mathcal W|\leq k+2\) is a sufficient (not asserted sharp) bound.

Equivalently, parameterize the joint law on a fixed alphabet of size
\(k(k+2)\), allowing zero weights. The conditions that its pair marginal
equal \(Q\) and its conditional mutual information be at most \(t\) are
closed. The feasible set is nonempty, since \(W=(X,Y)\) makes the latter
information zero. Entropies and both informations are continuous on this
compact set. Consequently, the infimum in (1) is attained.

**Lemma 4 (right continuity).** For each fixed \(Q\) and \(t\geq0\),

\[
 \lim_{u\downarrow0}C(Q,t+u)=C(Q,t).
\tag{11}
\]

*Proof.* The function is nonincreasing in its second argument, so its
right limit is at most \(C(Q,t)\). Choose a sequence of exact minimizers
at \(t+u_j\), with \(u_j\downarrow0\), using the fixed cardinality bound.
A convergent subsequence has pair marginal \(Q\) and conditional mutual
information at most \(t\). Its objective equals the right limit by
continuity. That objective is at least the minimum at \(t\). This proves
equality, including at \(t=0\). For an arbitrary nonnegative sequence
\(u_n\to0\), monotonicity and the established right limit give the same
conclusion. \(\square\)

## 6. Matching the operational rate

**Theorem 1 (operational matching).** For every source
\(\pi_\epsilon=\operatorname{DSBS}(\epsilon)\), \(0\lt \epsilon\lt 1/2\),
and every \(\beta\in(0,\infty]\),

\[
 \boxed{\quad
 \widetilde T_{-\beta}(\pi_\epsilon)
 =T_{-\beta}(\pi_\epsilon)
 =\sup_Q C\bigl(Q,c_\beta D(Q\Vert\pi_\epsilon)\bigr)
 =\Gamma_{-\beta}^{\rm UB}(\pi_\epsilon).
 \quad}
\tag{12}
\]

*Proof.* Take any sequence of arbitrary block codes with \(d_n/n\to0\).
The divergences are finite for all sufficiently large \(n\). Fix any
one-letter test law \(Q\). Equations (10)–(11) imply

\[
 \liminf_{n\to\infty}R_n
 \geq C\bigl(Q,c_\beta D(Q\Vert\pi_\epsilon)\bigr).
\]

The same bound holds for every \(Q\), and therefore its supremum bounds
the liminf rate. In particular it bounds the limsup rate used in the stated
definition. Taking the infimum over admissible code sequences gives
\(\widetilde T_{-\beta}\geq\Gamma_{-\beta}^{\rm UB}\).
The attributed upper bounds (2) give both equalities. The proof for
\(\beta=\infty\) uses the direct infinite-order part of Lemma 1 throughout.
There is no interchange of the \(n\), \(\beta\), auxiliary-alphabet or
code infimum limits. \(\square\)

The same converse argument is valid for any full-support finite-alphabet
target. Together with the same general upper bound in the cited theorem,
it yields the corresponding general equality as a corollary. No separate
arbitrary-source phase classification is claimed or required here.

For finite \(\beta\), the conversion back to the negative-order convention
is

\[
 D_{-\beta}(P_n\Vert\pi^{\otimes n})
 =-\frac{\beta}{1+\beta}
 D_{1+\beta}(\pi^{\otimes n}\Vert P_n).
\]

Thus the normalized and unnormalized vanishing criteria are exactly the
ones specified in the synthesis model. At the negative infinite endpoint,
the corresponding identity is \(D_{-\infty}(P_n\Vert\pi^{\otimes n})
=-D_\infty(\pi^{\otimes n}\Vert P_n)\).

## 7. A finite-block obstruction below the frontier

This is a consequence of the same argument, rather than an independently
claimed complete error-exponent theory. Define the compact auxiliary problem

\[
 \psi_Q(R)=\min_{W:\ I(XY;W)\leq R}I(X;Y\mid W),\qquad R\geq0.
\]

It is attained by the same cardinality argument, and is feasible because
constant \(W\) has zero mutual information with \(XY\). Equation (9)
gives, for every code of rate \(R_n\),

\[
 \frac{d_n}{n}\geq
 \sup_Q\left[\psi_Q(R_n)-c_\beta D(Q\Vert\pi)\right].
\tag{13}
\]

The right side is nonnegative: choose \(Q=\pi\). If \(R\) is strictly
below \(\Gamma_{-\beta}^{\rm UB}\), there exists a \(Q\) with
\(C(Q,c_\beta D(Q\Vert\pi))>R\). Compactness implies
\(\psi_Q(R)>c_\beta D(Q\Vert\pi)\); otherwise its minimizer would be
feasible for \(C\) at objective at most \(R\). Hence all codes with
\(R_n\leq R\) have \(d_n\geq n\delta\) for some \(\delta>0\)
depending on the chosen \(Q,R,\pi,\beta\). This quantitative obstruction
holds for arbitrary local block distributions.

## 8. Attribution and verification boundary

The Rényi variational identity, KL chain rules, entropy conditioning,
time sharing and Carathéodory reduction are established information-theoretic
and convex-geometric tools. The proposed new result is their combination in
an all-block-kernel converse matching the particular negative-order upper
bound in (2), and its connection to the phase theorem proved separately.

In particular, tensorization, continuity and a sharper auxiliary bound for
relaxed Wyner information already appear in Sula and Gastpar,
[*Common Information Components Analysis*](https://doi.org/10.3390/e23020151),
Entropy 23(2), 151 (2021), Lemma 1, items 3, 4 and 6. Sections 4–5 give
self-contained sufficient versions for this converse and do not claim those
components as new. Their sharper cardinality bound is not needed here.

The fixed-channel reverse-resolvability theorem in Yu,
[arXiv:2402.07660v5](https://arxiv.org/abs/2402.07660v5), Theorem 3,
is a close methodological neighbor. It has a fixed memoryless channel and
does not supply an arbitrary-block-kernel converse by substitution. Its
variational methods are not claimed as new here. Yu's DSBS scalar reduction
and relaxed-Wyner formula are also prior inputs; neither is reproved or
counted as original in this note.

This note establishes the operational interface. It does not by itself establish the sharp crossover classification, and it supplies no proof-assistant certification.

