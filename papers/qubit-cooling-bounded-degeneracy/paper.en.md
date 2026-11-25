# An elementary superlevel proof for bounded-degeneracy qubit cooling

Research manuscript, 24 November 2026. Intended audience: doctoral researchers in quantum thermodynamics and mathematical physics.

## Abstract

A finite thermal machine can offer several resonant population-transfer channels for a qubit. How much can this reduce the leading dissipation of a prescribed small change of the qubit state? We prove the dimension-dependent bound $Q\geq F/[2(m-1)]$ for arbitrary machine dimension and all positive reference probabilities whenever every distinct machine population has multiplicity at most three. Here $F$ is the squared Fisher norm of the first-order spectral change and $Q$ is the quadratic dissipation coefficient. More generally, if the largest multiplicity in a connected resonant component is $H$, the same bound holds whenever the smaller-to-larger qubit population ratio satisfies $t\geq1-1/H$. The proof uses an integer superlevel decomposition of the machine multiplicities; it neither enumerates dimensions nor replaces an infinite parameter range by numerical tests. We also prove the bound for completely unrestricted integer degeneracies whenever $t\leq5/8$, and give exact prefix reductions for further families. Relative to the research corpus at the start of this study, these were extensions of the shell-capacity reduction and its bounded cases. A concurrent manuscript [5], found during final integration, proves the general integer-chain inequality and therefore contains all three coverage statements. This manuscript is consequently a complementary elementary proof, with an explicit superlevel surplus, rather than a further extension of the known theorem range.

## 1. The question and the scope of the result

Mishra and Senthilkumar formulate a dimension-dependent bound on the quadratic dissipation of resonant cooling collisions in their Eq. (7) and Supplemental Eq. (S11.1) [1]. Their Theorem 2 covers a maximally mixed system and, separately, a two-level machine. The earlier manuscript [3] establishes a scalar capacity reduction for a two-level system and proves several further cases. Our contribution is an elementary superlevel proof for controlled integer degeneracies and an explicit grouped surplus. Concurrent work [5] already proves the general scalar inequality by a finite staircase case decomposition with exact certificates; its coverage includes every parameter range proved here.

Let the qubit reference state have strictly positive populations $p_0,p_1$, and let the machine reference state have $m\geq2$ strictly positive populations $q_y$. Let $P$ be a permutation of the product configurations that preserves each product weight $p_xq_y$. Write

$$
P^{-1}(x,y)=(x',y'),\qquad
\Delta_x(y)=\psi_{y'}-\psi_y,
$$

where $\psi$ is any real vector. Subtracting a constant from $\psi$ changes none of these quantities, so the physical normalization $\sum_yq_y\psi_y=0$ can always be imposed. Define

$$
F=\sum_{x=0}^{1}p_x\left(\sum_yq_y\Delta_x(y)\right)^2,
\qquad
E=\sum_{x,y}p_xq_y\Delta_x(y)^2,
\qquad Q=\frac{E-F}{2}.
\tag{1}
$$

The desired local bound is

$$
F\leq\left(1-\frac1m\right)E,
\qquad\text{equivalently}\qquad
Q\geq\frac{F}{2(m-1)}.
\tag{2}
$$

The reference populations and machine energies are otherwise arbitrary. No assumption of a nondegenerate machine is imposed. The theorem concerns exact reference resonance and the leading quadratic cost of a small collision; it is not a finite-displacement inequality for arbitrary collisions.

For $p_0\ne p_1$, relabel the qubit so that

$$
p_0=\frac1{1+t},\qquad p_1=\frac{t}{1+t},\qquad 0<t<1.
\tag{3}
$$

In each connected machine component induced by $P$, the machine weights form consecutive geometric levels. List them in decreasing order and let $n_0,\ldots,n_L$ be their positive integer multiplicities. Multiplicities are local to a connected component. A global multiplicity bound on the machine is a sufficient way to meet the componentwise hypotheses below.

**Theorem 1 (unrestricted dimension under bounded degeneracy).** Inequality (2) holds if every connected resonant component has multiplicities in $\{1,2,3\}$. This conclusion is valid for every $m$ and every $0<t<1$.

More generally, a component with maximum multiplicity $H$ satisfies the requisite capacity bound whenever

$$
t\geq1-\frac1H.
\tag{4}
$$

A component consisting of a single machine weight makes no net qubit transfer. Components satisfying different sufficient conditions may be combined. The case $p_0=p_1$ satisfies (2) without any multiplicity restriction.

The following additional reductions are proved below:

1. A component whose largest machine weight has multiplicity at least two satisfies the capacity bound for every $0<t\leq1$; this is an existing conclusion, for which we supply a short self-contained proof.
2. Initial consecutive singleton levels may be removed inductively. After these removals, a first non-singleton multiplicity of at least three is sufficient for every $0<t\leq1$.
3. In the range $t\geq1/2$, the pattern $(1,2,1)$ may be changed to $(1,1,1)$ when the smaller-mass chain is already certified. The change gives an explicit nonnegative margin.
4. Every integer multiplicity chain satisfies the capacity bound for $0<t\leq5/8$. The earlier range was $0<t\leq1/2$ [3]. The endpoint $5/8$ follows from the same first-edge polynomial certificate as item 2.

The all-temperature proof in this manuscript is restricted to multiplicities at most three. The unrestricted qubit result belongs to the concurrent work [5], which is not used in the proofs below.

## 2. From resonant collisions to a scalar capacity

This section makes the earlier reduction [3] explicit so that the mathematical result and its physical scope can be checked together.

Connect two machine labels whenever a product configuration is carried between them by $P$. Each connected component is preserved by the induced product-configuration permutation. Resonance permits a ratio of machine weights only in $\{1,t,t^{-1}\}$ along an edge. Hence, in a connected component, the distinct weights have the form

$$
q_i=\frac{t^i}{S},\qquad
S=\sum_{i=0}^{L}n_it^i,
\qquad n_i\in\mathbb Z_{\geq1},
\qquad m_c=\sum_{i=0}^{L}n_i.
\tag{5}
$$

The exponents are consecutive because every edge changes the exponent by at most one and the component is connected. In this section $q$ is normalized within one component.

The mixed product-weight shell between levels $i$ and $i+1$ contains $n_i$ configurations with qubit label $1$ and $n_{i+1}$ with qubit label $0$. Their common weight is

$$
w_i=\frac{p_1t^i}{S}=\frac{p_0t^{i+1}}{S}.
$$

Let $a_i$ be the shell's weighted net change on the qubit-label-$1$ configurations. Because $P$ permutes within the shell, the corresponding net change on label $0$ is $-a_i$. Cauchy--Schwarz within the two groups gives a contribution to $E$ of at least

$$
\frac{a_i^2}{w_in_i}+\frac{a_i^2}{w_in_{i+1}}
=\frac{a_i^2}{w_ih_i},
\qquad h_i=\frac{n_in_{i+1}}{n_i+n_{i+1}}.
\tag{6}
$$

Single-label shells have zero net qubit transfer. Put $\delta=\sum_i a_i$ and $B=\sum_iw_ih_i$. If $\delta\ne0$, a second Cauchy--Schwarz inequality yields

$$
E\geq\frac{\delta^2}{B},\qquad
F=\frac{\delta^2}{p_0p_1}.
\tag{7}
$$

If $B=0$, then $\delta=0$ and the desired inequality is immediate. Therefore it suffices to establish

$$
\frac{B}{p_0p_1}
=\frac{1+t}{S}\sum_{i=0}^{L-1}t^ih_i
\leq1-\frac1{m_c}.
\tag{8}
$$

For the rest of the mathematical argument write $m=m_c$ and define

$$
D=S-(1+t)\sum_{i=0}^{L-1}t^i
\frac{n_in_{i+1}}{n_i+n_{i+1}}.
\tag{9}
$$

The scalar statement is exactly

$$
D\geq\frac Sm.
\tag{10}
$$

It is a sufficient condition obtained by enlarging the allowed shell flows. Failure to prove this scalar condition is not a counterexample to the underlying collision inequality.

To combine components, let their total probability masses be $\lambda_c$. The overall row means are convex combinations of the normalized component row means. Jensen's inequality gives $F\leq\sum_c\lambda_c F_c$, while $E=\sum_c\lambda_c E_c$. Since $m_c\leq m_{\rm total}$, component inequalities imply

$$
F\leq\sum_c\lambda_c(1-1/m_c)E_c
\leq(1-1/m_{\rm total})E.
$$

## 3. A one-boundary estimate and safe singleton removal

### 3.1. Completion of squares

Set $a_i=t^in_i$ and $a_{L+1}=0$. Direct expansion gives

$$
D=\frac{t}{1+t}\left[
 a_0+\sum_{i=0}^{L}
 \frac{(a_i-a_{i+1})^2}{ta_i+a_{i+1}}
\right].
\tag{11}
$$

The numerator differences sum to $a_0$, and the denominators sum to $(1+t)S-a_0$. Thus

$$
\frac DS\geq
\frac{ta_0}{(1+t)S-a_0}.
\tag{12}
$$

This proof also covers $L=0$. All denominators are positive because $t>0$ and the nonterminal $a_i$ are positive.

**Lemma 2 (repeated initial multiplicity).** If $n_0=a\geq2$, then (10) holds for all $0<t\leq1$.

Indeed, $S\leq a+(m-a)t$, so (12) gives

$$
\frac DS\geq
\frac{a}{a+(1+t)(m-a)}
\geq\frac{a}{2m-a}\geq\frac1m.
\tag{13}
$$

The last inequality is equivalent to $(a-2)m+a\geq0$.

### 3.2. Peeling initial singleton levels

**Lemma 3 (singleton-prefix reduction).** Suppose $n_0=n_1=1$. If the tail $(n_1,\ldots,n_L)$ satisfies (10) with its own mass, then so does the full chain.

Let the tail mass be $M=m-1$, and denote its quantities by $S',D'$. Then

$$
S=1+tS',\qquad D=\frac{1-t}{2}+tD'.
$$

Consequently,

$$
D-\frac{S}{M+1}
\geq\frac{1-t}{2}-\frac1{M+1}
       +\frac{tS'}{M(M+1)}.
\tag{14}
$$

A positive-integer composition of $M$ has

$$
\sum_j(j+1)n'_j\leq\frac{M(M+1)}2.
\tag{15}
$$

For example, order its $M$ individual copies by level. The level-plus-one of the $k$th copy is at most $k$, because every lower level contains at least one copy. Summing proves (15). Bernoulli's inequality $t^r\geq1-r(1-t)$ for positive integers $r$ now gives

$$
tS'\geq M-(1-t)\frac{M(M+1)}2.
\tag{16}
$$

Substituting into (14) proves the lemma. This is a valid reduction, not an assumption that the tail has already been proved. In applications it is used in induction on total mass or with one of the independently established terminal classes.

### 3.3. The all-singleton chain

If $n_i=1$ at all $N=L+1$ levels, then

$$
D_0=\frac{1+t^L}{2},\qquad S_0=\sum_{i=0}^{L}t^i,
\qquad S_0\leq N D_0.
\tag{17}
$$

For $L\geq1$, the final inequality follows by bounding the convex function $i\mapsto t^i$ by its secant between $0$ and $L$ and summing. The case $L=0$ is immediate.

## 4. A first-edge polynomial certificate

Suppose $n_0=1$, put $b=n_1\geq2$, and let $c=\sum_{i=2}^{L}n_i\geq0$. Thus $m=1+b+c$. For the tail beginning at $b$, write $S'=b+U$; then $U\leq tc$. Equation (12) gives

$$
D'\geq\frac{tbS'}{(1+t)S'-b}
=b-\frac{bU}{tb+(1+t)U}
\geq b-\frac{bc}{b+(1+t)c}.
$$

The exact first-edge identity is

$$
D=\frac{1-tb}{b+1}+tD'.
$$

Therefore

$$
D\geq A:=\frac1{b+1}
+tb\left[\frac b{b+1}-\frac c{b+(1+t)c}\right],
\qquad
\frac Sm\leq B:=\frac{1+bt+ct^2}{1+b+c}.
\tag{18}
$$

After multiplying by the positive denominator

$$
K=(b+1)(1+b+c)(b+(1+t)c),
$$

one obtains the exact identity

$$
K(A-B)=C_2c^2+C_1c+C_0,
\tag{19}
$$

where

$$
\begin{aligned}
C_2&=t^2b^2-t(t^2+t+1)b+1+t-t^2-t^3,\\
C_1&=b\big[(b-2)(b+1)t^2+(b^2-2b-2)t+1\big],\\
C_0&=b^2(b^2-1)t.
\end{aligned}
\tag{20}
$$

### 4.1. Every first non-singleton multiplicity at least three

For $b\geq3$, $C_1$ and $C_0$ are positive. If $1/2\leq t\leq1$, write $b=3+d$ with $d\geq0$. Then

$$
C_2=t^2d^2+t(-t^2+5t-1)d
 +(1-t)(4t^2-t+1)\geq0.
\tag{21}
$$

The middle factor is positive on this interval, and $4t^2-t+1>0$.

For $0<t\leq1/2$, completing the square gives

$$
C_2=\left(tb-\frac{t^2+t+1}{2}\right)^2
+1+t-t^2-t^3-\frac{(t^2+t+1)^2}{4}
\geq\frac{15}{64}>0.
\tag{22}
$$

Here $1+t-t^2-t^3\geq1$ and $t^2+t+1\leq7/4$. Thus (19) is positive for every $b\geq3$ and every $0<t\leq1$. Combined with Lemma 3, this proves the criterion concerning the first non-singleton level after an initial singleton prefix.

### 4.2. The unrestricted-degeneracy range $t\leq5/8$

For $b=2$, (20) specializes to

$$
C_2=1-t+t^2-3t^3,\qquad
C_1=2-4t,\qquad C_0=12t.
\tag{23}
$$

On $0<t\leq1/2$ all three are nonnegative; in particular $C_2\geq3/8$, because its derivative $-1+2t-9t^2$ is negative. For $b\geq3$, (22) and the positivity of $C_1,C_0$ apply.

The same polynomial extends the unrestricted range. On $1/2\leq t\leq5/8$, monotonicity gives $C_2\geq17/512$, while $C_1\geq-1/2$ and $C_0\geq6$. Therefore, for every real $c\geq0$,

$$
C_2c^2+C_1c+C_0
\geq\frac{17}{512}c^2-\frac c2+6
\geq\frac{70}{17}>0.
\tag{24}
$$

The last step is a completion of the square. For $b\geq3$, Section 4.1 already covers the entire interval $0<t\leq1$.

Induction on total mass now proves (10) for every integer chain when $0<t\leq5/8$: a first multiplicity at least two is covered by Lemma 2; a first pair $(1,1)$ is peeled using Lemma 3; and a first pair $(1,b)$ with $b\geq2$ is covered by the first-edge certificate. The one-level chain is the base case.

The range $t\leq1/2$ belongs to the earlier ratio-two supplement [3]; this argument both simplifies its proof and extends the completely unrestricted-degeneracy range to $t\leq5/8$, equivalently to a larger-to-smaller qubit population ratio of at least $8/5$.

## 5. Integer superlevel blocks

We now prove the unrestricted-dimension bounded-degeneracy theorem. The case $n_0\geq2$ is already covered, so assume $n_0=1$. Let $H=\max_i n_i$. Starting with the all-one chain on the same $N=L+1$ levels, build the final chain by successive superlevel increments. At stage $h\in\{2,\ldots,H\}$, increase by one every index with $n_i\geq h$.

Each connected component of this superlevel set is an interval $[a,b]$ of length $k=b-a+1$. It starts at $a\geq1$. Before this increment its entries all equal $h-1$, and an adjacent entry outside the interval is at most $h-1$.

### 5.1. The exact boundary increment

Write $c=h-1$. If an adjacent outside multiplicity is $u\leq c$, increasing the inside endpoint from $c$ to $c+1$ changes its harmonic mean with $u$ by

$$
\frac{u(c+1)}{u+c+1}-\frac{uc}{u+c}
=\frac{u^2}{(u+c)(u+c+1)}
\leq\frac{c}{2(2c+1)}.
\tag{25}
$$

The left side increases with $u>0$. Every interior edge of the interval changes its harmonic mean by exactly $1/2$. Consequently the increment $\Delta D$ due to this block obeys

$$
\Delta D\geq
\frac{t^a+t^b}{2}
-\frac{(1+t)(h-1)}{2(2h-1)}
 \big(t^{a-1}+t^b\big).
\tag{26}
$$

If $b=L$, there is no right boundary edge, and omitting its subtraction only increases the actual increment. Thus (26) also covers terminal blocks.

Put $x=t^{a-1}$ and $y=t^k$. The bound becomes

$$
\Delta D\geq
\frac{x\big[(ht-h+1)+(h-(h-1)t)y\big]}{2(2h-1)}.
\tag{27}
$$

If $t\geq1-1/h$, both coefficients in the numerator are nonnegative. Hence $\Delta D\geq0$.

### 5.2. Paying for the additional weighted mass

The block adds mass $k$ and weighted mass

$$
T=\sum_{i=a}^{b}t^i\leq\frac{k(t^a+t^b)}2.
\tag{28}
$$

The final chain has total mass $m\geq hk$. Also, $D_0\geq1/2$. We claim that every such block satisfies

$$
\Delta D\geq\frac{T-kD_0}{m}.
\tag{29}
$$

If the right side is nonpositive, this follows from $\Delta D\geq0$. Otherwise $t^a+t^b-1>0$, and

$$
\frac{T-kD_0}{m}
\leq\frac{t^a+t^b-1}{2h}.
\tag{30}
$$

Subtract this last bound from (27) and multiply by $2h(2h-1)$. The resulting expression is

$$
(2h-1)+(h-1)x
 \big[(h-1)t-h+((h-1)-ht)y\big].
\tag{31}
$$

Under $t\geq1-1/h$, both coefficients inside the square brackets are nonpositive. For $0\leq x,y\leq1$, the minimum is therefore attained at $x=y=1$. Its value is

$$
h-(h-1)t\geq1.
$$

This proves (29).

### 5.3. Summing all integer layers

The sum of the block lengths over all stages is $m-N$. Their weighted-mass increments sum to $S-S_0$. All actual increments in $D$ telescope from $D_0$ to $D$. Summing (29) yields

$$
D-D_0\geq\frac{S-S_0-(m-N)D_0}{m}.
$$

Therefore

$$
D-\frac Sm\geq\frac{ND_0-S_0}{m}\geq0
\tag{32}
$$

by (17).

If $t\geq1-1/H$, the required condition $t\geq1-1/h$ holds at every stage $2\leq h\leq H$. This proves the general bounded-height criterion. When $H\leq2$, it proves the whole range $1/2\leq t\leq1$. Section 4.2 proves the complementary lower range. Thus the all-temperature theorem already holds for multiplicities in $\{1,2\}$. The next subsection closes the additional interval needed for multiplicity three.

The use of integer superlevels is essential to this proof. We do not assert the same theorem for arbitrary real-valued multiplicities.

### 5.4. The remaining interval for multiplicity three

Suppose $n_i\leq3$ and $5/8\leq t\leq2/3$. For a superlevel block define its surplus

$$
M_B=\Delta D_B-\frac{T_B-k_BD_0}{m}.
\tag{33}
$$

Every level-three block lies in a unique level-two block. We show that the surplus of each level-two block pays for all possible negative surpluses of its level-three children.

Let a level-two block start at $a$, and put $x=t^{a-1}$. If its comparison term $R=(T-kD_0)/m$ is nonpositive, (27) with $h=2$ gives

$$
M_B\geq\Delta D_B\geq\frac{x(2t-1)}6\geq\frac{x}{24}.
$$

If $R>0$, the calculation (30)--(31) for $h=2$ gives $M_B\geq(2-t)/12\geq1/9\geq x/24$. Thus in both cases

$$
M_B\geq\frac{x}{24}.
\tag{34}
$$

Now consider a level-three child starting at $a_j$, and write $x_j=t^{a_j-1}$ and $y_j=t^{k_j}$. Its increment satisfies

$$
\Delta D_j\geq\frac{x_j[(3t-2)+(3-2t)y_j]}{10}.
$$

If its comparison term is nonpositive, then $M_j\geq\Delta D_j\geq-x_j/80$, because $3t-2\geq-1/8$. If its comparison term is positive, subtracting its upper bound $(t^{a_j}+t^{b_j}-1)/6$ and multiplying by $30$ gives

$$
5+2x_j[2t-3+(2-3t)y_j]\geq4t-1>0.
$$

Here $2-3t\geq0$, and the minimum over $0\leq x_j,y_j\leq1$ is attained at $x_j=1,y_j=0$. Therefore a negative child surplus can arise only in the first case, and in every case

$$
M_j\geq-\frac{x_j}{80}.
\tag{35}
$$

Distinct level-three child blocks are separated by at least one index of height two. Their starting indices differ by at least two, and their first start is no earlier than $a$. Consequently

$$
\sum_j x_j\leq\frac{x}{1-t^2}\leq\frac{9x}{5}.
$$

Combining this with (34)--(35) yields the strictly positive grouped surplus

$$
M_B+\sum_{j\text{ child of }B}M_j
\geq\frac{x}{24}-\frac{9x}{400}
=\frac{23x}{1200}>0.
\tag{36}
$$

Blocks touching the last level have a positive boundary correction, so the same estimates remain valid. All superlevel blocks occur in exactly one such group. Summing their surpluses, and using the baseline term $(ND_0-S_0)/m\geq0$, proves (10) throughout the middle interval.

For multiplicity at most three, Section 4.2 covers $0<t\leq5/8$, this subsection covers $5/8\leq t\leq2/3$, and the bounded-height theorem covers $2/3\leq t\leq1$. These intervals cover the whole parameter range and complete Theorem 1.

### 5.5. An explicit grouped surplus

The proof yields more than a nonnegative final sign. Suppose $n_0=1$, $H\leq3$, and $5/8\leq t\leq2/3$. Let $\mathcal I_2$ be the maximal intervals of indices on which $n_i\geq2$. With $N=L+1$, $D_0=(1+t^L)/2$ and $S_0=\sum_{i=0}^Lt^i$, define

$$
C(\mathbf n,t)=\frac{ND_0-S_0}{m}
 +\frac{23}{1200}\sum_{[a,b]\in\mathcal I_2}t^{a-1}.
$$

**Corollary (structural surplus).** Under these assumptions,

$$
D-\frac Sm\geq C(\mathbf n,t)\geq0.
$$

Indeed, the exact sum of the block surpluses leaves the baseline term $(ND_0-S_0)/m$, and every height-two parent with all its height-three children contributes at least $23t^{a-1}/1200$. No finite chain enumeration enters this argument. If $\mathcal I_2$ is nonempty, then $C>0$.

For one normalized connected component as in Section 2, with $\mathcal I_2$ nonempty, put

$$
\rho=\frac1m+\frac{C(\mathbf n,t)}S.
\qquad
F\leq(1-\rho)E,
\qquad
Q\geq\frac{\rho}{2(1-\rho)}F.
$$

Here $1/m<\rho\leq D/S<1$: the last strict inequality follows from the presence of a positive mixed-shell capacity. The displayed inequalities are valid also when $E=F=0$. This gives an explicit strictly stronger coefficient than $1/[2(m-1)]$ for that component. For several components, a common bound must use a uniform lower bound on their respective $\rho$ values. A permutation-specific surplus does not automatically supply a uniform constant for a coherent convex decomposition.

This is an accessible lower bound for the surplus, not an optimal constant. Direct evaluation of $D/S$ gives the exact scalar capacity coefficient, and the present estimate need not improve the one-boundary estimate (12). The contribution is the explicit geometric accounting and its positive grouped margin; no claim of a new optimal cooling protocol is made.

## 6. A local $(1,2,1)$ reduction

The following reduction is useful when the chain contains larger multiplicities later on and the global bounded-height condition does not apply.

**Lemma 4.** Suppose $t\geq1/2$ and a chain starts with $(1,2,1)$. Replace its second entry by $1$, leaving all other levels fixed. If the new chain satisfies (10) with its own total mass, then the original chain satisfies (10).

Let $S_*,D_*$ denote the smaller chain. Its mass is $m-1$, while

$$
S-S_*=t,\qquad
D-D_*=\frac{4t-1-t^2}{6}\geq\frac t4.
\tag{37}
$$

The final inequality follows from

$$
\frac{4t-1-t^2}{6}-\frac t4
=\frac{(2t-1)(2-t)}{12}\geq0.
$$

Since the original prefix already has mass four, $m\geq4$. Thus

$$
D-\frac Sm\geq
\frac{S_*}{m(m-1)}+\frac t4-\frac tm\geq0.
$$

The first two multiplicity reductions are constructive certificates. They may be iterated until an already proved terminal class is reached; an unsuccessful reduction is not a proof that the original chain violates the bound.

## 7. Equal qubit populations and coherent collisions

When $p_0=p_1$, resonance requires each map $\sigma_x:y\mapsto y'$ to preserve the machine population classes. On every nonempty finite class, the functional graph of $\sigma_x$ has a directed cycle. The sum of $\Delta_x$ along such a cycle vanishes. Since all its machine weights agree, this cycle contributes zero to the corresponding weighted row mean.

Choose one such cycle in every population class. Their total probability mass is at least $\sum_{\mathcal K}q_{\mathcal K}\geq1/m$, because

$$
1=\sum_{\mathcal K}|\mathcal K|q_{\mathcal K}
\leq m\sum_{\mathcal K}q_{\mathcal K}.
$$

Cauchy--Schwarz on the remaining labels gives

$$
\left(\sum_yq_y\Delta_x(y)\right)^2
\leq(1-1/m)\sum_yq_y\Delta_x(y)^2.
$$

Summing over the qubit labels proves (2). This is the existing maximally mixed argument of [1], included to cover the endpoint explicitly.

For general coherent collisions close to a dissipationless reference collision, the original paper's Theorem 1, in its fixed-reference-input case $R=0$, supplies a convex decomposition into resonant permutations with the same machine perturbation. If $\delta_k,Q_k$ denote their first-order spectral changes and quadratic costs, its conclusion is

$$
\bar\delta=\sum_k\lambda_k\delta_k,
\qquad Q\geq\sum_k\lambda_kQ_k,
\qquad \lambda_k\geq0,\quad\sum_k\lambda_k=1.
$$

Whenever the machine satisfies a sufficient condition uniformly for these permutations, convexity of the squared Fisher norm gives

$$
Q\geq\frac1{2(m-1)}\sum_k\lambda_k\|\delta_k\|_F^2
\geq\frac{\|\bar\delta\|_F^2}{2(m-1)}.
\tag{38}
$$

In particular, a global bound of three on the multiplicity of each machine population is inherited by every induced component of every resonant permutation. It therefore yields the coherent local conclusion without a permutation-specific qualification. The same observation applies to a global height bound $H$ together with (4). Prefix criteria must instead be checked for every permutation/component used in a proposed extension.

This transfer uses the stated theorem of [1]; it does not replace its fixed-input and perturbative hypotheses by a claim about arbitrary finite-time coherent protocols.

## 8. Sharpness of the dimension-dependent constant

The coefficient in (2) cannot be improved uniformly in the reference populations, even within the nondegenerate-machine subclass. This sharpness statement uses the geometric-weight version of the adjacent-channel exchange underlying the original attainment construction [1]; it is not a new cooling protocol.

Fix $m\geq2$, take $n_i=1$ for $i=0,\ldots,m-1$, and set

$$
q_i=\frac{t^i}{S},\qquad S=\sum_{i=0}^{m-1}t^i.
$$

For $0<t<1$, every machine population is distinct. Swap $(0,i+1)$ with $(1,i)$ for each $i=0,\ldots,m-2$, and leave the two endpoint configurations fixed. These swaps are disjoint and exactly resonant. Choose

$$
\psi_i=i-\sum_jq_jj.
$$

Replacing $\psi$ by its negative gives the opposite first-order direction, including cooling. Each active pair has a perturbation difference of magnitude one. If

$$
W=\frac{t}{(1+t)S}\sum_{i=0}^{m-2}t^i,
$$

then $E=2W$ and $F=W^2/(p_0p_1)$. Thus

$$
\frac FE=
\frac{(1+t)\sum_{i=0}^{m-2}t^i}{2S}
=1-\frac{1+t^{m-1}}{2S}
\longrightarrow\frac{m-1}{m}
\quad\text{as }t\uparrow1.
\tag{39}
$$

Equivalently,

$$
\frac{2Q}{F}\longrightarrow\frac1{m-1}.
\tag{40}
$$

Hence no larger uniform constant multiplying $F$ in the lower bound for $Q$ is possible for a fixed $m$. The limiting state has coincident populations, but every member with $t<1$ is nondegenerate and belongs to the proved class. This is uniform sharpness over temperature; it does not claim that the displayed construction is optimal at each fixed nonzero temperature.

## 9. Relationship to concurrent work and verification

The shell reduction, the coverage of machine dimensions up to eighteen, the repeated-largest-weight condition, and the range $t\leq1/2$ are earlier results [3]. The all-singleton case is likewise already included there. The sharpness protocol is an existing construction.  this manuscript developed the unrestricted-dimension all-temperature proof for multiplicities in $\{1,2,3\}$, the range $t\leq5/8$, the integer-height criterion, and supporting prefix arguments.

The related manuscript is *The quadratic dissipation bound for qubits with arbitrary finite machines* [5]. Its main scalar theorem states $D\geq S/m$ for all positive integer chains and every $0<t\leq1$, and therefore logically subsumes all three coverage statements here. It uses a minimal-mass induction, a finite staircase of prefixes, repeated-layer and one-step-descent branches, and exact polynomial and interval certificates. The shell reduction, the one-boundary estimate, singleton deletion, and some first-prefix arguments overlap. The superlevel decomposition, the height-two/height-three grouped credit in Section 5, and its explicit surplus in Section 5.5 are not presented in that manuscript.

Accordingly, this case is archived as a complementary analytic proof and quantitative method note. It is not counted as a new expansion of the known theorem range or a second solution of the same open problem. The general theorem from [5] is cited for scope and attribution, not invoked as a premise of any proof in this manuscript.

Taranto et al. [2] supply the thermodynamic-geometric background and concrete finite-resource cooling constructions. Mishra and Senthilkumar's later paper [4] studies an endpoint-closure infimum over unbounded collision counts; its fixed-control local expansion does not assert the universal quadratic inequality studied here. The comparison is limited to the sources examined and does not establish global priority.

The proofs above are analytic and cover continuous $t$ in their stated intervals. Finite exact checks verify algebraic identities, boundary cases, and implementations. They do not replace a universal proof. No external peer review or Lean certification is claimed.

The present superlevel method alone leaves chains that may begin with $(1,2)$, contain a later multiplicity at least four, and satisfy $5/8<t<1-1/H$. This is a limitation of this method, not a claim that the general integer-chain problem remains open in this setting: [5] provides its general proof. A direct all-height superlevel argument and an analysis of sharper structural surplus bounds remain possible methodological follow-ups. Neither the unproved Bernstein candidate nor an unproved real-multiplicity relaxation is used here.

## References

1. Ansh Mishra and Aryan Senthilkumar, *Finite-resource cooling of qudits beyond thermodynamic length*, arXiv:2610.40709v1, 28 October 2026. In particular Theorems 1--2, Eq. (7), and Supplemental Sec. S11. https://arxiv.org/abs/2610.40709v1
2. P. Taranto et al., *Efficiently Cooling Quantum Systems with Finite Resources: Insights from Thermodynamic Geometry*, Physical Review Letters **134**, 070401 (2025). https://doi.org/10.1103/PhysRevLett.134.070401
3. *Shell-capacity bound for a two-level system*, and a supplementary manuscript on multiplicity ratio two, 24 November 2026.

4. Ansh Mishra and Aryan Senthilkumar, *The Cost of Quantum State Conversion*, arXiv:2611.19725v1, 15 November 2026. In particular Theorem 1 and Appendix B.1. https://arxiv.org/abs/2611.19725v1

5. *The quadratic dissipation bound for qubits with arbitrary finite machines*, 24 November 2026. [Chinese manuscript](../qubit-cooling-arbitrary-machine/paper.zh.md).
