# Sharp multiplicative coefficients for cyclic Bell entanglement-swapping chains

**Research manuscript · 24 November 2026**  
**Subject:** quantum information and quantum communication  
**Audience:** doctoral readers  
**Status:** AI-assisted research manuscript; external peer review is not claimed. The computation files and Lean source are not included in this edition.

## Abstract

We determine the least coefficient in a product bound for the average endpoint entanglement produced by a fixed cyclic generalized Bell measurement at every internal node of a chain. For $m\ge2$ independent pure links of local dimension $d\ge2$, with arbitrary complex Schmidt-aligned amplitudes, the optimal coefficient multiplying the product of the unscaled input $l_1$ entanglements is $1$ when $d$ is even and $2^{1-m}$ when $d$ is odd. We derive an exact factorization through the cyclic amplitude autocorrelations, starting from the unnormalized physical branches and retaining zero-probability outcomes. We give necessary and sufficient equality conditions in terms of the nonzero support differences, an exact zero-output criterion, and normalized rational witnesses attaining the bound for every dimension and chain length. The result concerns this fixed measurement protocol and the coefficient relative to the product of the input resources. It does not optimize the measurement basis or give a universal absolute decay rate for endpoint entanglement.

## 1. Question and relation to previous work

Starke, Basso, Céleri and Maziero [1] express the two-link probability-weighted output by a finite sum in their Eq. (41), prove the product bound with coefficient $1$ in Eq. (43), and obtain exact coefficients $1$ and $1/2$ in dimensions two and three. Their Eq. (59) proposes $1/(d-1)$ for general dimension. A prior trureturing record [2] refutes that proposal in dimension four and explicitly leaves sharp replacements unresolved. We credit both that refutation and the existing two-link identity.

Our target is the least **uniform multiplicative coefficient**, for every dimension and every chain length, together with the exact equality and zero conditions. The proof isolates the information preserved by this protocol: a common nonzero displacement must occur in every input support. Inversion pairs these displacements; a nonzero self-inverse displacement exists precisely in even cyclic dimension.

The two-link specialization in dimension four falls within the stated scope of a concurrent fixed-resource project; no completed result from that project is assumed, and no separate priority is claimed for that specialization. The present manuscript addresses arbitrary $d,m$ and a uniform coefficient, rather than the full optimum at each prescribed pair of resource values. Bounded literature checking does not establish global priority. The pure-qubit chain product rule is also prior work [3]; that paper's higher-dimensional analysis uses I-concurrence, a different measure from the unscaled $l_1$ quantity fixed here.

A supplementary broader-context preprint on multipartite swapping [4] was checked at the level of its indexed primary abstract; its primary full text was not obtained. It is not an input to our proof, and we do not claim that every relevant prior result has been excluded. The comparison is restricted to accessible material.

## 2. Protocol and notation

Fix integers $d\ge2$ and $m\ge2$. All labels are in the additive cyclic group $G=\mathbb Z_d$. The $\ell$-th link joins systems $L_\ell,R_\ell$ and is prepared in

$$
|\psi_\ell\rangle
 =\sum_{x\in G}c_\ell(x)|x\rangle_{L_\ell}|x\rangle_{R_\ell},
\qquad
\sum_{x\in G}|c_\ell(x)|^2=1,
\qquad 1\le\ell\le m.
\tag{1}
$$

The inputs are independent, so their joint state is the tensor product of these $m$ states. The coefficients can be complex and can vanish. Write $a_\ell(x)=|c_\ell(x)|$.

For a normalized state in the form $\sum_x b(x)|\sigma(x)\rangle|x\rangle$, where $\sigma$ is a permutation, we use the unscaled ordered-pair quantity

$$
E(b)=\sum_{x\ne y}|b(x)b(y)|.
\tag{2}
$$

In particular $E_\ell=E(c_\ell)$. We include both orders of each distinct pair and do not divide by $d-1$.

At internal node $t$, the systems $R_t,L_{t+1}$ are measured in the fixed Bell basis

$$
|B_{p,q}\rangle
 =\frac1{\sqrt d}\sum_{k\in G}\omega^{qk}
 |p+k\rangle_{R_t}|k\rangle_{L_{t+1}},
\qquad
\omega=e^{2\pi i/d}.
\tag{3}
$$

Representatives of residues may be used in the exponent; the value is independent of that choice. Complex conjugation changes the sign of the phase on contraction. Reversing every $q$-label gives the opposite phase convention with the same averaged quantity.

A full outcome is $(p,q)\in G^{m-1}\times G^{m-1}$. Let $v_{p,q}$ be the unnormalized vector on the endpoint systems $L_1,R_m$ obtained by applying the corresponding Bell bras. Its probability is $P_{p,q}=\|v_{p,q}\|^2$. For $P_{p,q}>0$, evaluate (2) on the Schmidt-form coefficients of $v_{p,q}/\sqrt{P_{p,q}}$. Define the branch contribution to be zero when $P_{p,q}=0$. The operational average is

$$
A_{d,m}(c_1,\ldots,c_m)
 =\sum_{p,q}P_{p,q}\,
 E\!\left(\frac{v_{p,q}}{\sqrt{P_{p,q}}}\right),
\tag{4}
$$

with that explicit zero-branch convention. All outcomes are retained.

For $r\in G$, define

$$
C_\ell(r)=\sum_{x\in G}a_\ell(x)a_\ell(x+r),
\qquad
D_\ell=\{r\ne0:C_\ell(r)>0\}.
\tag{5}
$$

The set $D_\ell$ is exactly the set of nonzero differences of occupied input labels:

$$
D_\ell
 =\{r\ne0:\exists x,\ c_\ell(x)\ne0
                         \text{ and }c_\ell(x+r)\ne0\}.
\tag{6}
$$

Indeed, every summand in (5) is nonnegative, and a finite sum is positive precisely when at least one summand is positive.

We will use the elementary cyclic-group fact that a nonzero self-inverse residue exists exactly for even $d$, and is then $d/2$. To see this, choose its representative $u$ with $1\le u<d$. Self-inversion means $d\mid2u$; since $0<2u<2d$, it forces $2u=d$. The converse follows by substituting $u=d/2$ when $d$ is even.

## 3. Exact operational factorization

### Theorem 1. Chain factorization

For the protocol (1)–(4),

$$
\boxed{
A_{d,m}=\sum_{r\in G\setminus\{0\}}
             \prod_{\ell=1}^{m}C_\ell(r).}
\tag{7}
$$

Moreover,

$$
C_\ell(r)\ge0,
\qquad C_\ell(-r)=C_\ell(r),
\qquad E_\ell=\sum_{r\ne0}C_\ell(r).
\tag{8}
$$

These statements include inputs and branches with vanishing coefficients or probabilities.

### Proof

Set $s_m=0$ and

$$
s_\ell=\sum_{t=\ell}^{m-1}p_t
\quad(1\le\ell<m).
\tag{9}
$$

Expanding the input tensor product and each Bell bra shows that a basis tuple $(x_1,\ldots,x_m)$ survives exactly when $x_t=p_t+x_{t+1}$ for every internal node. With $k=x_m$, its unique surviving labels are $x_\ell=k+s_\ell$. Consequently

$$
v_{p,q}
 =d^{-(m-1)/2}\sum_{k\in G}b_{p,q}(k)
 |k+s_1\rangle|k\rangle,
\tag{10}
$$

where

$$
b_{p,q}(k)
 =\left(\prod_{\ell=1}^{m}c_\ell(k+s_\ell)\right)
   \omega^{-\sum_{t=1}^{m-1}q_t(k+s_{t+1})}.
\tag{11}
$$

The endpoint labels in (10) are paired orthonormal labels, so this is a Schmidt form up to coefficient phases. Define

$$
w_p(k)=\prod_{\ell=1}^{m}a_\ell(k+s_\ell),
\qquad
Z_p=\sum_k w_p(k)^2.
\tag{12}
$$

The phase in (11) has modulus one. Hence

$$
P_{p,q}=d^{-(m-1)}Z_p.
\tag{13}
$$

If $Z_p>0$, the normalized Schmidt moduli are $w_p(k)/\sqrt{Z_p}$. Thus the probability-weighted branch contribution is

$$
P_{p,q}E\!\left(v_{p,q}/\sqrt{P_{p,q}}\right)
 =d^{-(m-1)}\sum_{j\ne k}w_p(j)w_p(k).
\tag{14}
$$

If $Z_p=0$, nonnegativity forces $w_p(k)=0$ for every $k$. Both the right-hand side of (14) and the branch contribution defined in (4) are then zero. This establishes (14) in every branch, without dividing by a zero probability.

There are $d^{m-1}$ phase labels $q$, and (14) does not depend on them. Summing gives

$$
A_{d,m}
 =\sum_{p\in G^{m-1}}\sum_{j\ne k}
       \prod_{\ell=1}^{m}
       a_\ell(j+s_\ell)a_\ell(k+s_\ell).
\tag{15}
$$

The triangular transformation $p\mapsto(s_1,\ldots,s_{m-1})$ is a bijection: its inverse is $p_t=s_t-s_{t+1}$, with $s_m=0$. In (15), put $r=k-j\ne0$, $x_m=j$, and $x_\ell=j+s_\ell$ for $\ell<m$. For fixed $r$, these changes are bijections onto all independently chosen $x_1,\ldots,x_m\in G$. Therefore

$$
\begin{aligned}
A_{d,m}
 &=\sum_{r\ne0}\sum_{x_1,\ldots,x_m}
          \prod_{\ell=1}^{m}a_\ell(x_\ell)a_\ell(x_\ell+r)\\
 &=\sum_{r\ne0}\prod_{\ell=1}^{m}
          \left(\sum_{x_\ell}a_\ell(x_\ell)a_\ell(x_\ell+r)\right),
\end{aligned}
\tag{16}
$$

which is (7). Translation $x\mapsto x-r$ gives inversion symmetry, and the bijection $(x,y)\leftrightarrow(x,r=y-x)$ gives the final identity in (8). Nonnegativity is immediate.

For completeness, these same changes of variables verify that the operational probabilities are normalized:

$$
\sum_{p,q}P_{p,q}
 =\sum_{p,k}\prod_{\ell=1}^{m}a_\ell(k+s_\ell)^2
 =\prod_{\ell=1}^{m}\sum_x a_\ell(x)^2=1.
\tag{17}
$$

This also checks that the average in (4) uses the full measurement distribution. ∎

## 4. The sharp coefficient

### Theorem 2. Optimal product bound

The least real constant $K(d,m)$ satisfying

$$
A_{d,m}(c_1,\ldots,c_m)
 \le K(d,m)\prod_{\ell=1}^{m}E_\ell
\tag{18}
$$

for every normalized input family in (1) is

$$
\boxed{
K(d,m)=
\begin{cases}
1,&d\text{ even},\\
2^{1-m},&d\text{ odd}.
\end{cases}}
\tag{19}
$$

### Proof of the upper bound

If some $E_\ell=0$, (8) forces $C_\ell(r)=0$ for every nonzero $r$. Formula (7) gives $A_{d,m}=0$, proving (18) in this case.

Otherwise define, for $r\ne0$,

$$
q_\ell(r)=\frac{C_\ell(r)}{E_\ell}.
\tag{20}
$$

Each $q_\ell$ is a probability distribution on $G\setminus\{0\}$, invariant under $r\mapsto-r$, and

$$
\frac{A_{d,m}}{\prod_\ell E_\ell}
 =\sum_{r\ne0}\prod_{\ell=1}^{m}q_\ell(r).
\tag{21}
$$

For even $d$, the probability bound $q_\ell(r)\le1$ gives

$$
\sum_{r\ne0}\prod_{\ell=1}^{m}q_\ell(r)
 \le\sum_{r\ne0}q_m(r)=1.
\tag{22}
$$

For odd $d$, every nonzero $r$ differs from $-r$. Symmetry and normalization therefore give

$$
2q_\ell(r)=q_\ell(r)+q_\ell(-r)\le1.
\tag{23}
$$

Bound the first $m-1$ factors in (21) by $1/2$, then sum the last distribution:

$$
\sum_{r\ne0}\prod_{\ell=1}^{m}q_\ell(r)
 \le2^{-(m-1)}\sum_{r\ne0}q_m(r)
 =2^{1-m}.
\tag{24}
$$

### Proof of optimality by normalized rational inputs

For even $d$, let $h=d/2\in G$. In every link take

$$
c_\ell(0)=\frac35,\qquad
c_\ell(h)=\frac45,\qquad
c_\ell(x)=0\ \text{otherwise}.
\tag{25}
$$

The two occupied labels are distinct, and the input is normalized because $9/25+16/25=1$. The only nonzero displacement is $h=-h$, with

$$
C_\ell(h)=\frac{24}{25},\qquad E_\ell=\frac{24}{25}.
\tag{26}
$$

Thus $A_{d,m}=(24/25)^m=\prod_\ell E_\ell$.

For odd $d\ge3$, use (25) with $h$ replaced by $1$. Now $1\ne-1$, and

$$
C_\ell(1)=C_\ell(-1)=\frac{12}{25},
\qquad E_\ell=\frac{24}{25},
\tag{27}
$$

while every other nonzero correlation vanishes. Hence

$$
A_{d,m}=2\left(\frac{12}{25}\right)^m
       =2^{1-m}\left(\frac{24}{25}\right)^m.
\tag{28}
$$

All products of input entanglements in these witnesses are positive. Any smaller coefficient fails on the corresponding witness, proving that (19) is the least possible constant. ∎

The odd-dimensional coefficient is a statement about the ratio in (21). For higher-rank inputs, the unscaled $E_\ell$ can exceed one. Accordingly, (19) alone is not an absolute exponential decay law for endpoint entanglement. On the explicit two-level inputs (25), the exact values are those in (26)–(28).

## 5. Equality and zero output

### Theorem 3. Exact equality condition

If some $E_\ell=0$, equality in (18) holds, with both sides zero. Assume now that every $E_\ell>0$.

1. If $d$ is even, equality holds if and only if
   $$
   D_\ell=\{d/2\}\qquad\text{for every }\ell.
   \tag{29}
   $$
2. If $d$ is odd, equality holds if and only if there is a common $r\ne0$ such that
   $$
   D_\ell=\{r,-r\}\qquad\text{for every }\ell.
   \tag{30}
   $$

Here all sets refer to the actual occupied labels in the fixed measurement basis.

### Proof

Suppose first that equality holds in (22). Choose $r_0$ with $q_m(r_0)>0$, which exists because $q_m$ sums to one. Every summand of the difference between the two sides of (22) is nonnegative. Equality forces

$$
\prod_{\ell=1}^{m-1}q_\ell(r_0)=1.
\tag{31}
$$

Each factor belongs to $[0,1]$, so all the first $m-1$ distributions assign mass one to $r_0$. Their normalization forces them to vanish elsewhere. Since $m\ge2$, at least one such distribution exists. Equality in (22) then forces $q_m(r_0)=1$ as well. Inversion symmetry implies $r_0=-r_0$. The only nonzero self-inverse element of an even cyclic group is $d/2$, giving (29). Conversely, (29) makes every $q_\ell$ the point mass at $d/2$, and (21) equals one.

For odd $d$, equality in (24) similarly forces, for every $r$ with $q_m(r)>0$,

$$
\prod_{\ell=1}^{m-1}q_\ell(r)=2^{-(m-1)}.
\tag{32}
$$

Each factor is in $[0,1/2]$, so every one must equal $1/2$. Choose one such $r_0$. Symmetry and normalization imply that each of the first $m-1$ distributions is exactly the half-mass distribution on $\{r_0,-r_0\}$. Equality then restricts the support of $q_m$ to the same pair; its symmetry gives half the mass to each element. Since $q_\ell(r)>0$ exactly when $r\in D_\ell$, this proves (30). Conversely, (30) and symmetry force all these half-mass distributions, which make (21) equal to $2^{1-m}$. ∎

### Theorem 4. Exact zero-output condition

For all allowed inputs, including inputs with $E_\ell=0$,

$$
\boxed{
A_{d,m}=0
\quad\Longleftrightarrow\quad
\bigcap_{\ell=1}^{m}D_\ell=\varnothing.}
\tag{33}
$$

### Proof

Each summand of (7) is nonnegative. Its product at a given $r\ne0$ is positive exactly when $C_\ell(r)>0$ for every link, equivalently when $r\in\bigcap_\ell D_\ell$. A finite sum of nonnegative terms vanishes exactly when none is positive. ∎

For a concrete nontrivial zero-output example, take $d=5,m=2$, with the first input having amplitudes $3/5,4/5$ on labels $0,1$ and the second on labels $0,2$. Both are normalized and have $E_\ell=24/25>0$. Their nonzero difference sets are $\{1,4\}$ and $\{2,3\}$, respectively. Thus (33) gives $A_{5,2}=0$ for the prescribed Bell measurement. This example concerns that fixed measurement and alignment.

## 6. Interpretation, scope and reproducibility

The exact quantity controlling the product ratio is the overlap of the displacement distributions $q_\ell$. In odd cyclic dimension every occupied nonzero displacement must share its mass with its distinct inverse. An even cyclic group permits a single self-inverse displacement, and the rational witnesses concentrate all displacement mass there. This proves the parity dependence without asymptotic arguments or estimates of individual measurement outcomes.

The assumptions are independent pure inputs, common local dimension, Schmidt alignment in the specified computational bases, standard cyclic Bell measurements at all internal nodes, and averaging over every outcome. The theorem is not a statement about arbitrary mixed inputs, optimized Bell bases, arbitrary local pre-processing, or an optimized LOCC repeater protocol. Equation (2) fixes the normalization of the entanglement quantity throughout.

The original manuscript reports two distinct computational routes. `code/exact_certificate.py` evaluates rational autocorrelations and exhaustively checks the equality and zero criteria over its explicitly listed finite support families. `code/verify_bell_contraction.py` constructs the physical conditional endpoint vectors from the input tensor coefficients and the Bell bras, using exact cyclotomic arithmetic, before comparing the resulting probabilities and weighted entanglement with (7). The output files record the actual tested cases, not a claim that finite computations prove a universal theorem. The universal argument is given by the written proofs. This edition does not include the formalization and computation files and makes no claim of a new compilation.

## References

[1] Diego S. Starke, Marcos L. W. Basso, Lucas C. Céleri and Jonas Maziero, *Entanglement swapping for partially entangled qudits and the role of quantum complementarity*, arXiv:2508.00813v2 (22 October 2025), Advanced Quantum Technologies, DOI: [10.1002/qute.202500674](https://doi.org/10.1002/qute.202500674). [Versioned full text](https://arxiv.org/html/2508.00813v2). Relevant formulas: Eqs. (24), (30)–(31), (41), (43), (48), (57), (59).

[2] The Omega Institute / trureturing, *The improved entanglement-swapping product bound fails in dimension four*, research record and formal result `QuditSwappingProductBoundRefutation.result`. [Problem record pinned to commit 51dca4f1542baa532983864568d6a8ca3470e745](https://github.com/the-omega-institute/trureturing/blob/51dca4f1542baa532983864568d6a8ca3470e745/Problems/starke-2025-qudit-swapping-product-bound-refutation.md); [formal-result blueprint at the same commit](https://github.com/the-omega-institute/trureturing/blob/51dca4f1542baa532983864568d6a8ca3470e745/Blueprint/D5/S3/Quantum/Entanglement/QuditSwappingProductBoundRefutation.md). Accessed 24 November 2026. The prior refutation is not claimed as a contribution of this manuscript.

[3] János A. Bergou, Dov Fields, Mark Hillery, Siddhartha Santra and Vladimir S. Malinovsky, *Average concurrence and entanglement swapping*, Physical Review A 104, 022425 (2021), DOI: [10.1103/PhysRevA.104.022425](https://doi.org/10.1103/PhysRevA.104.022425). [Versioned full text](https://arxiv.org/html/2106.00848v1). The qubit multiple-swap product rule is credited; the qudit section uses I-concurrence.

[4] Shashank Shekhar, David Elkouss and Siddhartha Santra, *Optimising multipartite entanglement manipulation in quantum networks*, [arXiv:2610.21420v1](https://arxiv.org/abs/2610.21420). The primary abstract was available through indexed arXiv metadata; the primary full text was not obtained in this review.
