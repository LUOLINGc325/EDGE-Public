# A qubit counterexample to coarse-graining monotonicity of the Lüders total-variation order score

AI-assisted research draft

24 November 2026

## Abstract and scope

The optimized total-variation distance between two Lüders measurement-order records can increase when outcomes of one measurement are merged. We give a three-outcome qubit POVM $A$, a binary qubit POVM $B$, and a binary coarse-graining $C$ of $A$ for which

$$
\mathcal T(A,B)=\frac1{30},\qquad
\mathcal T(C,B)=\frac9{250},\qquad
\mathcal T(C,B)-\mathcal T(A,B)=\frac1{375}>0.
$$

Both values are optimized over **all complex qubit density matrices**. Every matrix needed to certify the bounds is rational. The proof reduces the two global optimizations to two explicit tables of sixteen rational numbers and supplies a pure state attaining each bound.

The question is raised explicitly by Shengjun Wu, *Measurement-order dependence bounds uncertainty, contextuality, steering, and Bell nonlocality*, arXiv:2611.24604v1 (18 November 2026), §§II.2 and VIII. The result answers negatively the **total-variation** component of that coarse-graining question. It makes no assertion about the Jensen-Shannon or squared Hellinger order scores, or about the paper's other conjectures.

A previously inspected result in a different direction concerns strict angle monotonicity of the Jensen-Shannon score for binary sharp qubit measurements [2]. It does not merge POVM effects and explicitly leaves coarse-graining unresolved. A separate research draft reports the same general negative conclusion; no priority claim is made. 

## 1. Definitions and statement

A finite-outcome POVM on $\mathbb C^2$ is a family of positive semidefinite Hermitian matrices $(E_a)_a$ satisfying $\sum_aE_a=I$. Its Lüders instrument sends an unnormalized input $\rho$ to $\sqrt{E_a}\rho\sqrt{E_a}$ upon outcome $a$.

For POVMs $A=(E_a)_a$, $B=(F_b)_b$, a density matrix $\rho\succeq0$ with $\operatorname{Tr}\rho=1$, and the same outcome labels $(a,b)$ in both orders, put

$$
p^{\rho}_{AB}(a,b)=\operatorname{Tr}\bigl(\rho\sqrt{E_a}F_b\sqrt{E_a}\bigr),\qquad
p^{\rho}_{BA}(a,b)=\operatorname{Tr}\bigl(\rho\sqrt{F_b}E_a\sqrt{F_b}\bigr).
$$

These are probability distributions. Define

$$
\operatorname{TV}(A,B\mid\rho)=\frac12\sum_{a,b}\left|p^{\rho}_{AB}(a,b)-p^{\rho}_{BA}(a,b)\right|,
\qquad
\mathcal T(A,B)=\max_{\rho\succeq0,\operatorname{Tr}\rho=1}\operatorname{TV}(A,B\mid\rho).
$$

No existence theorem for that maximum is needed below: an upper bound valid for every density matrix and an attaining density matrix are both exhibited.

**Theorem.** Let

$$
E_0=\begin{pmatrix}2/3&0\\0&0\end{pmatrix},\quad
E_1=\begin{pmatrix}5/18&1/6\\1/6&1/2\end{pmatrix},\quad
E_2=\begin{pmatrix}1/18&-1/6\\-1/6&1/2\end{pmatrix},
$$

and

$$
F_0=\begin{pmatrix}16/25&0\\0&1\end{pmatrix},\qquad
F_1=\begin{pmatrix}9/25&0\\0&0\end{pmatrix}.
$$

Set $A=(E_0,E_1,E_2)$, $B=(F_0,F_1)$, and

$$
C=(G_0,G_1),\qquad
G_0=E_0+E_1=\begin{pmatrix}17/18&1/6\\1/6&1/2\end{pmatrix},\qquad
G_1=E_2.
$$

All three families are POVMs. The scores are exactly

$$
\mathcal T(A,B)=\frac1{30},\qquad \mathcal T(C,B)=\frac9{250}.
$$

Thus coarse-graining $A$ by merging its outcomes 0 and 1, followed by using the Lüders instrument of the merged effect, increases the score by $1/375$, or by the factor $27/25$.

## 2. Positive square roots and admissibility

For each effect the following table gives a real symmetric positive semidefinite numerator $N$ and a positive scalar $r$ such that

$$
\sqrt E=N/\sqrt r,\qquad N^2=rE.
$$

| Effect | Numerator $N$ | $r$ |
|---|---|---:|
| $E_0$ | $\begin{pmatrix}2&0\\0&0\end{pmatrix}$ | 6 |
| $E_1$ | $\begin{pmatrix}11&3\\3&15\end{pmatrix}$ | 468 |
| $E_2$ | $\begin{pmatrix}1&-3\\-3&9\end{pmatrix}$ | 180 |
| $G_0$ | $\begin{pmatrix}29&3\\3&21\end{pmatrix}$ | 900 |
| $G_1$ | same as $E_2$ | 180 |
| $F_0$ | $\begin{pmatrix}4&0\\0&5\end{pmatrix}$ | 25 |
| $F_1$ | $\begin{pmatrix}3&0\\0&0\end{pmatrix}$ | 25 |

In the first row the numerator is $\operatorname{diag}(2,0)$. Each displayed numerator has nonnegative diagonal entries and determinant. The nonzero determinants are $156$ for $E_1$, $600$ for $G_0$, and $20$ for $F_0$. Hence the numerators are positive semidefinite. Direct multiplication gives $N^2=rE$ in every row, so the displayed positive matrices are the positive square roots. In particular,

$$
\sqrt{G_0}=\begin{pmatrix}29/30&1/10\\1/10&7/10\end{pmatrix}.
$$

The effects sum as

$$
E_0+E_1+E_2=I,\qquad F_0+F_1=I,\qquad G_0+G_1=I.
$$

This proves admissibility. Alternatively, positivity of the effects follows immediately from their nonnegative diagonal entries and determinants: $\det E_0=\det E_2=0$, $\det E_1=1/9$, $\det G_0=4/9$, $\det F_0=16/25$, and $\det F_1=0$.

Although some individual square roots contain irrational scalars, **all sandwich products used in the proof are rational**, since

$$
\sqrt E\,X\sqrt E=\frac{NXN}{r}.
$$

This identity is the basis of the standard-library exact certificate.

## 3. A bound valid for every complex density matrix

Write a general complex qubit density matrix as

$$
\rho=\begin{pmatrix}a&z\\\overline z&1-a\end{pmatrix}.
$$

Positivity gives $0\le a\le1$ and $|z|^2\le a(1-a)$. These are the elementary two by two positivity conditions: if $a>0$, completing the square in the quadratic form gives the determinant inequality; if $a=0$, positivity forces $z=0$. Define

$$
s=2a-1,\qquad t=2\operatorname{Re}z.
$$

Then

$$
s^2+t^2\le (2a-1)^2+4|z|^2\le1.
$$

For

$$
M(d,x)=\begin{pmatrix}d&x\\x&-d\end{pmatrix},\qquad d,x\in\mathbb R,
$$

one has

$$
\operatorname{Tr}(\rho M(d,x))=sd+tx.
$$

The identity

$$
(s^2+t^2)(d^2+x^2)-(sd+tx)^2=(sx-td)^2\ge0
$$

therefore implies

$$
\left|\operatorname{Tr}(\rho M(d,x))\right|\le\sqrt{d^2+x^2}.
\tag{1}
$$

This argument includes all imaginary off-diagonal entries of $\rho$; no restriction to real states is imposed.

For an arbitrary finite list of real numbers $\delta_j$ summing to zero,

$$
\frac12\sum_j|\delta_j|=\max_{S}\sum_{j\in S}\delta_j.
\tag{2}
$$

Indeed, the sum over all positive terms equals both sides and dominates every other subset sum.

Suppose now that the order-difference matrices are $D_j=M(d_j,x_j)$, with $\sum_jD_j=0$. Equations (1) and (2) give, for **every** complex density matrix,

$$
\operatorname{TV}(A,B\mid\rho)
\le \max_{S}\sqrt{\left(\sum_{j\in S}d_j\right)^2+
                         \left(\sum_{j\in S}x_j\right)^2}.
\tag{3}
$$

Thus a finite rational upper bound for the squares on the right controls the full continuous optimization. The tables below certify those bounds. They are not a sampling of input states.

## 4. Exact order-difference matrices

For the fine measurement define

$$
D_{ab}=\sqrt{E_a}F_b\sqrt{E_a}-\sqrt{F_b}E_a\sqrt{F_b}.
$$

The first two matrices vanish: $D_{00}=D_{01}=0$, because $E_0$ and both effects of $B$ are diagonal. The other four are

$$
\begin{aligned}
D_{10}&=M(9/1300,31/3900),&
D_{11}&=M(-9/1300,33/1300),\\
D_{20}&=M(9/500,-41/1500),&
D_{21}&=M(-9/500,-3/500).
\end{aligned}
\tag{4}
$$

For the coarse measurement use

$$
H_{ab}=\sqrt{G_a}F_b\sqrt{G_a}-\sqrt{F_b}G_a\sqrt{F_b}.
$$

Then

$$
\begin{aligned}
H_{00}&=M(9/2500,-11/7500),&
H_{01}&=M(-9/2500,87/2500),\\
H_{10}&=D_{20},&H_{11}&=D_{21}.
\end{aligned}
\tag{5}
$$

Each four-matrix list sums to zero. All identities (4)-(5) follow by ordinary rational multiplication using $NXN/r$. They are independently replayed by `exact_certificate.py`.

## 5. All subset certificates

The bit convention is fixed throughout. For a mask $m\in\{0,\ldots,15\}$, index $j\in\{0,1,2,3\}$ belongs to its subset if and only if the coefficient of $2^j$ in $m$ is 1. If its selected matrices sum to $M(d_m,x_m)$, the table records $q_m=d_m^2+x_m^2$. Inequality (3) converts these numbers directly into the needed bound.

### 5.1 Fine measurement

The bit order is $(D_{10},D_{11},D_{20},D_{21})$. The omitted matrices $D_{00},D_{01}$ are zero and cannot affect any subset sum.

| Mask | $d_m$ | $x_m$ | $q_m=d_m^2+x_m^2$ |
|---:|---:|---:|---:|
| 0 | $0$ | $0$ | $0$ |
| 1 | $9/1300$ | $31/3900$ | $1/9000$ |
| 2 | $-9/1300$ | $33/1300$ | $9/13000$ |
| 3 | $0$ | $1/30$ | $1/900$ |
| 4 | $9/500$ | $-41/1500$ | $241/225000$ |
| 5 | $81/3250$ | $-63/3250$ | $81/81250$ |
| 6 | $18/1625$ | $-19/9750$ | $37/292500$ |
| 7 | $9/500$ | $3/500$ | $9/25000$ |
| 8 | $-9/500$ | $-3/500$ | $9/25000$ |
| 9 | $-18/1625$ | $19/9750$ | $37/292500$ |
| 10 | $-81/3250$ | $63/3250$ | $81/81250$ |
| 11 | $-9/500$ | $41/1500$ | $241/225000$ |
| 12 | $0$ | $-1/30$ | $1/900$ |
| 13 | $9/1300$ | $-33/1300$ | $9/13000$ |
| 14 | $-9/1300$ | $-31/3900$ | $1/9000$ |
| 15 | $0$ | $0$ | $0$ |

Every entry $q_m$ is at most $1/900$, with equality at masks $3$ and $12$. Equation (3) gives

$$
\operatorname{TV}(A,B\mid\rho)\le1/30
\quad\text{for every density matrix }\rho.
\tag{6}
$$

### 5.2 Coarse measurement

The bit order is $(H_{00},H_{01},H_{10},H_{11})$.

| Mask | $d_m$ | $x_m$ | $q_m=d_m^2+x_m^2$ |
|---:|---:|---:|---:|
| 0 | $0$ | $0$ | $0$ |
| 1 | $9/2500$ | $-11/7500$ | $17/1125000$ |
| 2 | $-9/2500$ | $87/2500$ | $153/125000$ |
| 3 | $0$ | $1/30$ | $1/900$ |
| 4 | $9/500$ | $-41/1500$ | $241/225000$ |
| 5 | $27/1250$ | $-18/625$ | $81/62500$ |
| 6 | $9/625$ | $14/1875$ | $37/140625$ |
| 7 | $9/500$ | $3/500$ | $9/25000$ |
| 8 | $-9/500$ | $-3/500$ | $9/25000$ |
| 9 | $-9/625$ | $-14/1875$ | $37/140625$ |
| 10 | $-27/1250$ | $18/625$ | $81/62500$ |
| 11 | $-9/500$ | $41/1500$ | $241/225000$ |
| 12 | $0$ | $-1/30$ | $1/900$ |
| 13 | $9/2500$ | $-87/2500$ | $153/125000$ |
| 14 | $-9/2500$ | $11/7500$ | $17/1125000$ |
| 15 | $0$ | $0$ | $0$ |

Every entry is at most $81/62500=(9/250)^2$, with equality at masks $5$ and $10$. Hence

$$
\operatorname{TV}(C,B\mid\rho)\le9/250
\quad\text{for every density matrix }\rho.
\tag{7}
$$

The complementary mask $15-m$ negates the sum matrix and has the same square. All sixteen entries are nevertheless shown to make the arithmetic certificate explicit.

## 6. Attaining states and strict increase

For the fine measurement take

$$
\rho_+=\frac12\begin{pmatrix}1&1\\1&1\end{pmatrix}.
$$

This is a positive rank one matrix of trace one. In the full outcome order
$(00,01,10,11,20,21)$, its probability differences are

$$
\left(0,0,\frac{31}{3900},\frac{33}{1300},-\frac{41}{1500},-\frac3{500}\right).
$$

Consequently

$$
\operatorname{TV}(A,B\mid\rho_+)
=\frac{31}{3900}+\frac{33}{1300}=\frac1{30}.
$$

Together with (6), this proves the first exact score.

For the coarse measurement take

$$
\rho_* =\frac15\begin{pmatrix}1&2\\2&4\end{pmatrix}.
$$

It too is positive, rank one, and has trace one. In the outcome order
$(00,01,10,11)$, its probability differences are

$$
\left(-\frac1{300},\frac3{100},-\frac{49}{1500},\frac3{500}\right).
$$

Therefore

$$
\operatorname{TV}(C,B\mid\rho_*)=\frac3{100}+\frac3{500}=\frac9{250}.
$$

Together with (7), this proves the second exact score. Subtraction gives

$$
\frac9{250}-\frac1{30}=\frac1{375}>0,
$$

which completes the proof. In particular, the coarse score at the single explicit state $\rho_*$ already exceeds the fine score at **every** input state.

## 7. Interpretation and precise limitations

The result concerns **coarse-graining a measurement and using the Lüders instrument of its merged effects**. This differs from merely merging classical labels in already recorded data. If one first implements the original instrument and then forgets whether outcome $0$ or $1$ occurred, the merged state-update map is

$$
\rho\longmapsto\sqrt{E_0}\rho\sqrt{E_0}+\sqrt{E_1}\rho\sqrt{E_1}.
$$

The coarse Lüders instrument instead uses

$$
\rho\longmapsto\sqrt{E_0+E_1}\rho\sqrt{E_0+E_1}.
$$

For the matrices above this distinction is witnessed directly by

$$
\sqrt{G_0}F_0\sqrt{G_0}
-\bigl(\sqrt{E_0}F_0\sqrt{E_0}+\sqrt{E_1}F_0\sqrt{E_1}\bigr)
=\begin{pmatrix}
-27/8125&-153/16250\\
-153/16250&27/8125
\end{pmatrix}\ne0.
$$

The source [1] separately establishes that total variation remains contractive under a common classical postprocessing of the two order-record distributions. Our example changes the quantum state update, exactly as specified in its coarse-graining question.

The counterexample rules out treating this optimized total-variation order score as a quantity that is automatically nonincreasing under that measurement coarse-graining operation. It does not invalidate its faithfulness to noncommutativity, its operational order-discrimination interpretation, or the source's separate results on classical postprocessing. It does not resolve monotonicity for projective measurements alone, nor for the Jensen-Shannon or squared Hellinger scores.

## 8. Reproduction and proof coverage

The finite-arithmetic reproduction script (not included in this version) uses only `fractions.Fraction` and other Python standard-library modules. It verifies effect sums, positivity, positive-square-root square identities, all difference matrices, all sixteen subset squares for each measurement, the exact optimized upper-bound constants, both probability distributions at each attaining state, and the strict gap. It contains no floating-point search or tolerance-based acceptance.

The certificate is a finite arithmetic check. The universal quantifier over complex density matrices is discharged by the written argument in §3; it is not replaced by numerical sampling. This version does not provide independent evidence of formal verification. It is an AI-assisted research draft and does not claim external peer review or worldwide priority.

## References

[1] Shengjun Wu. *Measurement-order dependence bounds uncertainty, contextuality, steering, and Bell nonlocality*. arXiv:2611.24604v1, 18 November 2026. Definitions: §II.1; coarse-graining question: §§II.2 and VIII. [Fixed-version source](https://arxiv.org/html/2611.24604v1).

[2] The Omega Institute. *Monotonicity of Wu's qubit Jensen-Shannon order score*. Research dossier, snapshot `5e55dc4`, last changed 24 November 2026, inspected 24 November 2026. Used only to distinguish its stated angle-monotonicity problem from coarse-graining; its proof implementation is not an input to the present theorem. [Project's direct description](https://the-omega-institute.github.io/trureturing-mdbook/Problems/wu-2026-qubit-order-score-monotonicity.html).

