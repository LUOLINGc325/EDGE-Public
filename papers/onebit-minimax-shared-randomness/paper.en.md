# Exact minimax one-bit quantization and the cost of shared randomness

## Abstract

An encoder observes an arbitrary deterministic scalar in $[0,1]$ and sends exactly one binary symbol. The terminals may use input-independent shared randomness and independent private coins; reconstruction need not be unbiased. We prove that the least achievable worst-case mean squared error is exactly $1/(8e)$. An explicit mixed quantizer and an explicit least-favorable source form a saddle point. Both the minimizing law of ordered decoder pairs after nearest-center reduction and the least-favorable source are unique. The optimal mixing law has a nonzero continuous component, so no finite shared seed attains the optimum. More quantitatively, the excess minimax risk with at most $M$ shared states is of order $M^{-2}$, and with exactly $R$ fair shared bits it is of order $4^{-R}$. We give explicit constants and a realizable finite construction, compute its exact risk, and identify its asymptotic coefficient. That coefficient is for the displayed construction, not a claimed sharp coefficient for the finite-resource minimax problem.

**Keywords:** randomized quantization; one-bit communication; minimax decision theory; least-favorable distribution; common randomness; finite mixtures.

# 1. Problem and contribution

Ben Basat, Mitzenmacher, and Vargaftik [1] study the same bounded scalar, one-bit, worst-case squared-error problem with shared randomness. For biased reconstruction, they give a lower bound above $0.0459$ and a numerical eight-shared-bit upper bound approximately $0.04599$; the exact value remains unresolved in that paper. Their threshold reduction, distributional lower-bound method, and posterior-mean reconstruction are prior ingredients, not new methods claimed here.

The present contribution is an analytic saddle point, equality structure on both sides, and a matching finite-randomness resource law. The numerical value $1/(8e)\approx0.04598493014643029$ closes a small numerical gap; the structural statements and the all-protocol resource converse are separate substantive parts of the result.

Randomized quantizers as mixtures, their existence under output constraints, and finite-randomization approximation were developed more generally by Saldi, Linder, and Yüksel [2]. Their Section IV, Theorems 5 and 6, concerns a known source and a relaxed output-distribution constraint. Our single-shot worst-input objective has no output-distribution constraint; its exact extremizers and cardinality-dependent minimax penalty are different conclusions. We do not claim to generalize their general existence theory.

Two recent neighbors require particular care. Adaptive Unbiased Quantization [3] optimizes input-dependent vector quantization under unbiasedness and transmits an input-dependent quantizer table; its model differs from the fixed one-bit channel here. The accessible abstract and author repository of [4] concern pointwise-unbiased compression on the whole real line, source-averaged second moments, and a Gaussian location problem. We could not obtain that paper's full text. Accordingly, novelty comparisons with [4] are limited to those accessible materials. None of our proofs uses an unavailable result. Literature checks describe the retrieved record, not an exhaustive proof of priority.

## 1.1. Model and notation

A protocol has a public random variable $U$, an encoder-private random variable $E$, and a decoder-private random variable $H$. Their joint law is chosen independently of the input. Conditional on $U$, $E$ and $H$ are independent. All randomness that can be used in a correlated way by both terminals is included in $U$. Measurable encoder and decoder kernels are allowed, or equivalently measurable maps on standard Borel seed spaces with auxiliary independent uniform coins. The encoder sends

$$B=\mathsf e(x,U,E)\in\{0,1\},$$

and the decoder returns $\widehat x=\mathsf d(B,U,H)\in\mathbb R$. There are no timing, silence, variable-length, or auxiliary-message channels. We impose no continuity, monotonicity, threshold, symmetry, or unbiasedness restriction on the original protocol. Infinite risk is allowed but cannot improve an infimum.

For a protocol $\Pi$, define

$$\mathcal R_\Pi(x)=\mathbb E(\widehat x-x)^2,
\qquad V_\infty=\inf_\Pi\sup_{x\in[0,1]}\mathcal R_\Pi(x).$$

Let $V_M$ denote the same infimum when $U$ has at most $M$ states, with arbitrary state probabilities, for an integer $M\ge1$. Let $V_R^{\mathrm{fair}}$ denote the infimum when $U$ is exactly $R$ independent fair bits, for an integer $R\ge0$. The encoder and decoder may ignore seed bits or map several seed strings to the same action. Private randomness remains unrestricted in both definitions. A correlated private seed not counted in $U$ would violate this model and invalidate any public-state budget.

Work in centered coordinates $z=2x-1\in[-1,1]$, with $\widehat z=2\widehat x-1$. Every squared risk is then four times its original-coordinate value. Write

$$C=e^{-1},\qquad r=\frac{1-C}{2},\qquad s=\frac{1+C}{2},
\qquad d(t)=\sqrt{C+t^2},\qquad D=\frac C2. \tag{1}$$

**Lemma 1 (constant identities).** We have $0 \lt C<1$, $r+s=1$, $s-r=C$, $d(\pm r)=s$, and

$$\frac r{\sqrt C}=\sinh(1/2),\qquad
\operatorname{arsinh}\frac r{\sqrt C}=\frac12. \tag{2}$$

**Proof.** Since $\sqrt C=e^{-1/2}$, the first equality in (2) follows from the exponential definition of $\sinh$. All remaining identities follow by substitution. In particular $s^2-r^2=C$. $\square$

## 1.2. Main results

**Theorem 2 (exact value and unique saddle marginals).** In the model of Section 1.1,

$$\boxed{V_\infty=\frac1{8e}.} \tag{3}$$

In centered coordinates, an optimal protocol is specified by

$$a(t)=t-d(t),\qquad b(t)=t+d(t), \tag{4}$$

and the public threshold law

$$Q_* =\frac14\delta_{-r}+
\frac{\mathbf1_{(-r,r)}(t)}{2d(t)}\,dt+
\frac14\delta_r. \tag{5}$$

Send $B=\mathbf1_{\{z\ge t\}}$ and reconstruct as $a(t)$ or $b(t)$. The unique least-favorable Borel source law on $[-1,1]$ is

$$P_* =\frac{C}{1+C}\delta_{-1}+
\frac{C\mathbf1_{(-r,r)}(z)}{2(C+z^2)^{3/2}}\,dz+
\frac{C}{1+C}\delta_1. \tag{6}$$

Among laws of ordered decoder pairs used with nearest-center encoding, the optimal law is uniquely the pushforward of $Q_*$ by $t\mapsto(a(t),b(t))$. This does not assert uniqueness of all unreduced encoding kernels.

**Theorem 3 (finite shared randomness).** Put

$$A=\frac{C(1-C)^3}{6(1+C)^3}>0,\qquad
K=\frac{(1+C)^2}{64}. \tag{7}$$

For every integer $M\ge1$,

$$V_M-\frac1{8e}\ge\frac{A}{(M+1)^2}. \tag{8}$$

For every integer $M\ge3$,

$$V_M-\frac1{8e}\le\frac{K}{(M-2)^2}. \tag{9}$$

For every integer $R\ge2$,

$$\frac{A}{(2^R+1)^2}
\le V_R^{\mathrm{fair}}-\frac1{8e}
\le\frac{(1+C)^2}{16\,4^R}. \tag{10}$$

Consequently $V_M-V_\infty=\Theta(M^{-2})$ and $V_R^{\mathrm{fair}}-V_\infty=\Theta(4^{-R})$. The exact finite-$M$ or finite-$R$ minimax value and its sharp leading constant are not determined here.

The proof of Theorem 2 occupies Sections 2--5. Sections 6--8 prove Theorem 3 and the stronger explicit-construction formula.

# 2. Reduction to mixed two-center quantizers

**Lemma 4 (pointwise reduction with preservation of the shared budget).** Every admissible protocol is pointwise dominated in squared risk by a public mixture of ordered pairs $-1\le a\le b\le1$ with nearest-center encoding. The reduction does not increase the number of public seed states and preserves an equiprobable seed space when one is prescribed.

**Proof.** First clip every decoder output to $[-1,1]$. Projection onto this interval decreases its distance to every possible $z$, and makes the outputs bounded. Conditional on a public seed $u$ and a message $b$, replace the clipped decoder output by its mean over the decoder-private coin. The conditional independence in Section 1.1 ensures that this output law depends on $u,b$, not on the input or on the encoder-private coin beyond $b$. Jensen's inequality therefore improves squared risk pointwise. Clipping first avoids integrability qualifications.

There are now two deterministic decoder values for each $u$. Order them, relabeling the bit when necessary. At every $z$ replace the possibly randomized encoder by a nearest-center choice. A convex combination of the two squared losses is at least their minimum. All steps are measurable; bounded kernel integration defines the decoder means, and the tie rule $B=1$ selects a measurable encoder. They change no public seed. $\square$

For an ordered pair define

$$\ell_{a,b}(z)=\min\{(z-a)^2,(z-b)^2\}.$$

If $a \lt b$, write $t=(a+b)/2$ and $d=(b-a)/2$. Then

$$\ell_{a,b}(z)=(z-t)^2+d^2-2d|z-t|
=(|z-t|-d)^2. \tag{11}$$

A nearest-center encoder has one threshold $t$. A constant pair $a=b$ has no switching threshold. Thus arbitrary nonmonotone encoders and independent private randomization cannot evade subsequent lower bounds. A law on the compact triangle of ordered pairs realizes a public mixture directly, so the reduction loses no possible optimal value.

**Lemma 5 (fixed-partition Bayes identity).** Let a source $P$ have mean zero and second moment $m_2$. For a threshold with left mass $F\in(0,1)$ and left first moment $M$, the minimum risk over the two reconstruction values for that fixed partition is

$$m_2-\frac{M^2}{F(1-F)}. \tag{12}$$

Equality requires the reconstruction values $M/F$ and $-M/(1-F)$. A one-cell partition has minimum risk $m_2$.

**Proof.** Expanding the risk and completing the square separately in both cells gives

$$m_2-\frac{M^2}{F}-\frac{M^2}{1-F}
+F\left(a-\frac MF\right)^2
+(1-F)\left(b+\frac M{1-F}\right)^2.$$

Both positive-weight square terms vanish exactly at the claimed centroids. For one cell the usual variance decomposition applies. $\square$

# 3. A dual certificate and the exact upper bound

## 3.1. The least-favorable candidate

**Lemma 6 (source normalization, moments, and threshold gain).** Formula (6) defines a probability measure with mean zero and second moment $3C/2$. For $-r\le t\le r$, its left mass and first moment are

$$F_*(t)=\frac12+\frac{t}{2d(t)},\qquad
M_*(t)=-\frac{C}{2d(t)}. \tag{13}$$

For every nontrivial threshold $-1 \lt t<1$,

$$\frac{M_*(t)^2}{F_*(t)(1-F_*(t))}=C. \tag{14}$$

**Proof.** The continuous mass is $r/s=(1-C)/(1+C)$, using the antiderivative $z/(2\sqrt{C+z^2})$. Adding the two atoms gives one. The law is symmetric. Integrating the density and $z$ times the density gives (13). In particular

$$F_*(t)(1-F_*(t))=\frac C{4d(t)^2}.$$

For $-1 \lt t<-r$ the pair $(F_*,M_*)$ is $(C/(1+C),-C/(1+C))$; for $r \lt t<1$ it is $(1/(1+C),-C/(1+C))$. These formulas give (14) in both gaps as well. Finally,

$$\begin{aligned}
\mathbb E_{P_*}Z^2
&=\frac{2C}{1+C}
 +C\int_0^r\frac{z^2}{(C+z^2)^{3/2}}\,dz\\
&=\frac{2C}{1+C}
 +C\left(\operatorname{arsinh}\frac r{\sqrt C}-\frac rs\right)
=\frac{3C}{2}.
\end{aligned} \tag{15}$$

This calculation uses (2). $\square$

**Proposition 7 (global converse and Bayes equality).** Every one-bit protocol has centered Bayes risk at least $D$ under $P_*$. An ordered pair with nearest-center encoding has Bayes risk $D$ if and only if it is $(a(t),b(t))$ for some $t\in[-r,r]$.

**Proof.** Apply Lemma 4. For distinct clipped centers the midpoint lies in $(-1,1)$, both cells have positive $P_*$ mass, and Lemmas 5 and 6 give risk at least $3C/2-C=D$. Constant pairs have risk at least $3C/2>D$. Average over the public seed; boundedness or Tonelli justifies this step.

Equality in Lemma 5 fixes both centroids. On an inner partition, (13) gives precisely $a(t),b(t)$, whose midpoint is $t$. On a gap partition the centroids are $(-1,C)$ or $(-C,1)$, whose midpoints are $-r$ or $r$. Hence equality for an actual nearest-center pair puts its midpoint in $[-r,r]$. Conversely each displayed pair attains $D$ by (12)--(14). The source has no atom at these midpoints, so tie allocation is immaterial. We do not require (14) for randomized partial splits of an endpoint atom. $\square$

## 3.2. The primal certificate

**Lemma 8 (feasibility and logarithmic parameter).** The measure $Q_*$ in (5) has total mass one. For $t\in[-r,r]$, the centers in (4) lie in $[-1,1]$, are distinct, and have midpoint $t$. With

$$t=\sqrt C\sinh u,\qquad -\tfrac12\le u\le\tfrac12,$$

we have

$$d(t)=\sqrt C\cosh u,\qquad
a(t)=-\sqrt C e^{-u},\qquad b(t)=\sqrt C e^u. \tag{16}$$

The public law of $u$ has atoms $1/4$ at each endpoint and density $1/2$ on $(-1/2,1/2)$.

**Proof.** The continuous mass in (5) is $\operatorname{arsinh}(r/\sqrt C)=1/2$. Both centers are strictly increasing functions of $t$, with endpoint pairs $(-1,C)$ and $(-C,1)$. Formula (16) follows from the exponential definitions, and $dt=d(t)\,du$ gives the law of $u$. $\square$

**Lemma 9 (risk curvature of a threshold mixture).** For any probability law $Q$ on $[-r,r]$, let

$$R_Q(z)=\int (|z-t|-d(t))^2\,Q(dt).$$

This function is continuous, and its distributional second derivative on $(-1,1)$ is

$$R_Q''=2\,dz-4d(t)Q(dt). \tag{17}$$

Here a distributional identity means equality after pairing with every smooth compactly supported test function. In particular, a threshold atom of mass $w$ creates a derivative jump $-4d(t)w$.

**Proof.** Joint continuity and compactness give continuity of the integral. For a fixed $t$, twice integrating by parts on the two sides of $t$ in (11) gives the usual quadratic curvature $2\,dz$ and the derivative jump $-4d(t)\delta_t$. Integrating this test-function identity against $Q$ is justified by boundedness on the compact support of the test function, and yields (17). $\square$

**Proposition 10 (exact pointwise primal risk).** The protocol (4)--(5) has risk

$$R_*(z)=
\begin{cases}
D,& |z|\le r,\\
D+(|z|-r)(|z|-1),& r\le|z|\le1.
\end{cases} \tag{18}$$

Its maximum is $D$, attained exactly on $S=[-r,r]\cup\{-1,1\}$.

**Proof.** Equation (17) and the density of $Q_*$ give $R_*''=0$ on $(-r,r)$. The function is even, hence constant there. At zero its atomic contribution is $C^2/2$, and its continuous contribution is

$$\int_0^r\frac{(d(t)-t)^2}{d(t)}\,dt
=C\int_0^{1/2}e^{-2u}\,du=\frac{C(1-C)}2.$$

Thus its constant value is $D$. At $r$, the atom creates a derivative jump $-s$ from the zero inner derivative. To the right, curvature is $2$. Consequently the risk is $D+(z-r)^2-s(z-r)$, equal to (18) since $r+s=1$. Reflection handles the left. The added term is negative exactly in the two outer open gaps. $\square$

Proposition 7 and Proposition 10 establish (3), with no interchange theorem needed: the explicit source and protocol certify opposite inequalities and attain equality. They also exhibit a saddle point for the bilinear expected-loss game between public mixtures and source distributions.

# 4. Rigidity of the reduced optimal strategy

**Theorem 11 (canonical uniqueness and continuous randomness necessity).** The minimizing law of ordered decoder pairs with nearest-center encoding is uniquely the law in Theorem 2. It has continuous threshold mass $1/2$. No purely countably supported public seed, in particular no finite public seed, can attain $V_\infty$ under the private-coin model.

**Proof.** Let a reduced mixture have worst centered risk $D$. Its Bayes risk under $P_*$ is both at least $D$ by Proposition 7 and at most $D$ pointwise. Thus its component Bayes risks, each at least $D$, equal $D$ almost surely. The equality part of Proposition 7 confines its pairs to the curve (4); let $Q$ be the induced threshold law.

The continuous risk $R_Q\le D$ integrates to $D$ under a measure with positive density everywhere in $(-r,r)$. Therefore $R_Q=D$ throughout $[-r,r]$. Equation (17), restricted to the interior, forces

$$Q(dt)=\frac{dt}{2d(t)}\quad\text{on }(-r,r). \tag{19}$$

The remaining endpoint masses $\alpha=Q\{-r\}$ and $\beta=Q\{r\}$ sum to $1/2$. The interior-density contribution is even and differentiable at zero. The endpoint risk derivative at zero is $2C(\beta-\alpha)$. Constancy forces $\alpha=\beta=1/4$.

A countably supported public seed remains countably supported after Lemma 4, whereas its optimal threshold pushforward would have to contain the nonzero absolutely continuous measure (19). This is impossible. $\square$

**Proposition 12 (unreduced encoders need not be unique).** The canonical uniqueness conclusion cannot be extended to uniqueness of every original encoder.

**Proof.** Keep $Q_*$ and its decoder values. For $z\in(r,1)$ define

$$S(z)=D-R_*(z)=(z-r)(1-z)>0,$$

$$H(z)=\int 4d(t)(z-t)\,Q_*(dt)>0,$$

and $\eta(z)=\min\{1/2,S(z)/(2H(z))\}$. On this open interval, all nearest-center messages choose the upper center. Independently flip that message with probability $\eta(z)$ using an encoder-private coin; do not flip elsewhere. The excess risk of a wrong choice at $(z,t)$ is exactly $4d(t)(z-t)$. Hence the modified risk is $R_*(z)+\eta(z)H(z)\le R_*(z)+S(z)/2 \lt D$ on the gap and unchanged elsewhere. The modified protocol remains minimax, yet its encoder differs on an open set. All displayed functions are continuous on the gap, so the modified rule is measurable. $\square$

# 5. Uniqueness of the least-favorable source

For a Borel law $P$ on $[-1,1]$ write

$$\mathfrak b(P)=\inf_{-1\le a\le b\le1}\int\ell_{a,b}(z)\,P(dz).$$

This equals the Bayes infimum over all protocols: Lemma 4 reduces to mixtures, and averaging deterministic risks cannot beat their infimum. A law is least favorable if $\mathfrak b(P)=D$.

**Lemma 13 (support and equalizer implications).** Every least-favorable law $P$ is supported on $S=[-r,r]\cup\{-1,1\}$. Every canonical pair $(a(t),b(t))$ with $t\in[-r,r]$ is Bayes optimal for $P$.

**Proof.** Every deterministic pair has $P$-risk at least $D$, so averaging canonical pairs under $Q_*$ gives $\int R_*\,dP\ge D$. Equation (18) gives the reverse inequality. Its strict slack outside $S$ forces $P(S)=1$. The function

$$L_P(t)=\int\ell_{a(t),b(t)}(z)\,P(dz)$$

is continuous by bounded convergence, is everywhere at least $D$, and has $Q_*$ average $D$. Since $Q_*$ has positive density throughout the interior and positive endpoint atoms, $L_P(t)=D$ for every $t\in[-r,r]$. $\square$

**Lemma 14 (centroid identities without a symmetry assumption).** Let $P$ be least favorable, let $m=\int z\,P(dz)$, and let $F(t)=P(({-\infty},t])$, $M(t)=\int_{z\le t}z\,P(dz)$. Then $P$ has no atoms in $(-r,r)$, and throughout that interval

$$F(t)=\frac{t+d(t)-m}{2d(t)},\qquad M(t)=a(t)F(t). \tag{20}$$

**Proof.** First both cells have positive mass for every interior threshold. If $F(t_0)=0$ at an interior $t_0$, every smaller interior threshold $t$ puts all source mass in the right cell. Bayes optimality of its pair forces $b(t)=m$, by the strict one-cell square completion. This contradicts strict monotonicity of $b$ on an interval. If $F(t_0)=1$, larger interior thresholds similarly force the strictly increasing $a(t)$ to equal $m$ on an interval. Thus $0 \lt F(t)<1$.

At every nonatom threshold, hold its two cells fixed while varying their reconstruction values. Lemma 13 and strict square completion force the two centroids to be $a(t)$ and $b(t)$; changing to the centroids is an admissible protocol, even before nearest-center reduction. Hence

$$M(t)=a(t)F(t),\qquad m-M(t)=b(t)(1-F(t)).$$

Solving gives (20) at nonatom points. A probability measure has at most countably many atoms, so nonatom points are dense. Right-continuity of $F,M$ extends these identities to every interior $t$. The right-hand sides are continuous, so taking nonatom sequences from the left as well shows that $F$ has no jumps there. This proves the no-atom assertion and (20). $\square$

**Proposition 15 (the mean and the entire source law are forced).** Every least-favorable law is $P_*$.

**Proof.** Formula (20) is smooth, so its CDF determines an absolutely continuous interior restriction with

$$F'(t)=\frac{C+mt}{2d(t)^3}. \tag{21}$$

The measure identity $dM=t\,dF$ becomes $M'=tF'$ on the interior. On the other hand, $M=aF$, $a'=1-t/d$, and (20)--(21) give

$$M'(t)-tF'(t)=-\frac{m}{2d(t)}.$$

Therefore $m=0$. Formula (20) reduces to (13), and the interior density is $C/(2d^3)$.

Taking $t\downarrow-r$ from within the interior yields

$$P([-1,-r])=\frac{C}{1+C},\qquad
\int_{[-1,-r]}z\,P(dz)=-\frac{C}{1+C}.$$

By Lemma 13 this part is supported on $\{-1,-r\}$. Its first moment equals the negative of its total mass, and $-r>-1$, so all of it is at $-1$. In particular $P\{-r\}=0$. Taking $t\uparrow r$ from within the interior and subtracting from total mass one and mean zero gives the analogous total mass and first moment on $[r,1]$; all that mass must be at $1$, with no atom at $r$. This is exactly (6). $\square$

This completes all uniqueness assertions in Theorem 2. No symmetry or initial density assumption on a competing least-favorable source was used.

**Corollary 16 (worst two-center source distortion on an interval).** For every closed interval $I$ of length $L>0$,

$$\sup_{P:\,P(I)=1}\ \inf_{a,b\in\mathbb R}
\mathbb E_P\min\{(X-a)^2,(X-b)^2\}
=\frac{L^2}{8e}. \tag{22}$$

The maximizing source is uniquely the affine image of (6) from $[-1,1]$ to $I$. For $L=0$ the value is zero and the only source is the point mass.

**Proof.** For any $P$ on $[-1,1]$, averaging the canonical deterministic quantizers gives Bayes risk at most $D$ by (18), so at least their infimum is at most $D$. Proposition 7 gives equality for $P_*$ and Proposition 15 gives uniqueness. Projection permits centers to be restricted to the interval. An affine map with slope $L/2$ multiplies all losses by $L^2/4$. The degenerate interval statement is immediate. This is an equivalent extremal-source formulation, not an additional independent minimax problem solved by a new method. $\square$

# 6. A converse for every finite public seed

**Lemma 17 (quadratic deficit between thresholds).** For any finite public mixture of reduced quantizers, let $R$ be its centered risk and $V=\sup_{[-1,1]}R$. On a closed interval $[l,u]$ with no threshold in its interior,

$$V-R(z)\ge(z-l)(u-z),\qquad l\le z\le u. \tag{23}$$

**Proof.** Each selected squared loss is a quadratic with second derivative $2$ on the open interval, so the mixture also has that curvature because its weights sum to one. Continuity extends the quadratic to both endpoints. The function $V-R(z)-(z-l)(u-z)$ is affine and has nonnegative endpoint values, so it is nonnegative throughout. $\square$

**Proposition 18 (all-protocol cardinality bound).** Inequality (8) holds for every integer $M\ge1$.

**Proof.** By Lemma 4 it suffices to consider a reduced mixture with at most $M$ thresholds. Partition $[-r,r]$ at its distinct interior thresholds into $k\le M+1$ intervals of positive lengths $\lambda_1,\ldots,\lambda_k$; thresholds at the endpoints create no additional interval. Write $g=V-R\ge0$. Proposition 7 gives

$$V-D\ge V-\mathbb E_{P_*}R=\mathbb E_{P_*}g.$$

On the inner interval the density of $P_*$ is at least

$$f_{\min}=\frac{C}{2s^3}=\frac{4C}{(1+C)^3}.$$

Dropping all other nonnegative contributions and using (23),

$$\begin{aligned}
V-D
&\ge\frac{f_{\min}}6\sum_{i=1}^k\lambda_i^3\\
&\ge\frac{f_{\min}(2r)^3}{6k^2}
\ge\frac{2C(1-C)^3}{3(1+C)^3(M+1)^2}.
\end{aligned} \tag{24}$$

The middle inequality is convexity of $u^3$ on nonnegative numbers and $\sum_i\lambda_i=2r$. Dividing by four and taking the infimum proves (8). The reduction can only decrease worst risk, so the same inequality holds for the original protocols with any independent private coins. $\square$

# 7. Explicit finite seeds and their exact risk

For an integer $n\ge1$, put $\delta=1/n$ and take log-parameter midpoints

$$u_j=-\frac12+(j-\tfrac12)\delta,\qquad
t_j=\sqrt C\sinh u_j,\qquad j=1,\ldots,n. \tag{25}$$

Keep endpoint states $u=\pm1/2$ with weight $1/4$ each, and give each midpoint weight $1/(2n)$. Decode using (16), with nearest-center encoding. Let $R_n$ be its centered risk and $W_n=\sup R_n$.

**Lemma 19 (finite-seed feasibility and fair-bit realization).** This construction has $n+2$ distinct public states. For $M\ge3$, choosing $n=M-2$ respects the arbitrary-probability state budget. For $R\ge2$, choosing $n=2^{R-1}$ is realizable by exactly $R$ fair bits: assign $2^{R-2}$ seed strings to each endpoint and one string to each of the $n$ midpoints.

**Proof.** The midpoints are distinct and strictly inside the endpoint interval, the probabilities are nonnegative and sum to one, and (16) supplies feasible centers. The fair-bit assignment uses $2\cdot2^{R-2}+2^{R-1}=2^R$ equiprobable strings, with precisely the stated probabilities. $\square$

**Lemma 20 (risk at each inner threshold).** For all $n\ge1$ and $1\le j\le n$,

$$R_n(t_j)=A_\delta t_j^2+B_\delta, \tag{26}$$

where

$$A_\delta=1-\frac{\delta}{\sinh\delta},\qquad
B_\delta=\frac{C^2}{2}+\frac\delta2
\left(C\coth\delta-C^2\operatorname{csch}\delta\right). \tag{27}$$

**Proof.** Write $y_i=e^{(i-1/2)\delta}$ and $d_j=d(t_j)$. The upper center is $Cy_i$, and the lower is $-y_i^{-1}$. At $z=t_j$, choose the upper center for $i\le j$ and the lower for $i>j$; the tie choice does not change squared loss. Finite geometric sums give

$$\begin{aligned}
S_1&=-C\sum_{i\le j}y_i+\sum_{i>j}y_i^{-1}
=-t_j\coth(\delta/2)-d_j,\\
S_2&=C^2\sum_{i\le j}y_i^2+\sum_{i>j}y_i^{-2}\\
&=(C+2t_j^2)\coth\delta+2t_jd_j
-C^2\operatorname{csch}\delta.
\end{aligned} \tag{28}$$

For example the first partial sum is $e^{\delta/2}(e^{j\delta}-1)/(e^\delta-1)$; substituting $e^{j\delta}=e^{1/2+\delta/2+u_j}$ gives the first equality after combining with its reciprocal tail. Applying the same identity with $2\delta$ gives the second. The endpoint states contribute $(t_j^2+C^2)/2$. Expanding the midpoint losses therefore gives

$$R_n(t_j)=t_j^2+C^2/2+\delta t_j S_1+(\delta/2)S_2.$$

The mixed terms cancel. Using $\coth(\delta/2)-\coth\delta=\operatorname{csch}\delta$ gives (26). All denominators are positive since $\delta>0$; empty tail sums when $j=n$ are zero. $\square$

**Lemma 21 (no exterior maximum above the ideal risk).** For $r\le|z|\le1$, we have $R_n(z)\le R_*(z)\le D$.

**Proof.** For $r\le z\le1$, every threshold uses its upper center, so the continuous-part loss as a function of $u$ is $g_z(u)=(z-\sqrt C e^u)^2$. Its even part is

$$\bar g_z(u)=z^2-2z\sqrt C\cosh u+C\cosh(2u).$$

It has second derivative

$$\bar g_z''(u)=-2z\sqrt C\cosh u+4C\cosh(2u)\ge0.$$

Indeed $z\le1<2\sqrt C$ and $\cosh(2u)\ge\cosh u$. The elementary inequality $e<4$ proves $2\sqrt C>1$. Symmetry makes both the midpoint sum and the integral of $g_z$ equal those of its even part. On each cell a convex function has midpoint value at most its cell average. The endpoint atoms are unchanged, so $R_n(z)\le R_*(z)$. Reflect for negative $z$. $\square$

**Theorem 22 (exact risk of the displayed finite construction).** For every integer $n\ge1$,

$$\boxed{\begin{aligned}
W_n={}&\left(1-\frac\delta{\sinh\delta}\right)
C\sinh^2\frac{1-\delta}{2}
+\frac{C^2}{2}\\
&+\frac\delta2\left(C\coth\delta
-C^2\operatorname{csch}\delta\right),\qquad\delta=1/n.
\end{aligned}} \tag{29}$$

The original-coordinate worst risk is $W_n/4$.

**Proof.** The risk is convex quadratic between consecutive thresholds, so its maximum on each such interval occurs at an endpoint. It suffices to inspect all thresholds and $\pm1$. Lemma 21 puts all exterior candidates, including $\pm r$, at most $D$. Proposition 18 applied to this finite mixture gives $W_n>D$, so some inner threshold is a maximizer. Since $\sinh\delta>\delta$, $A_\delta>0$ in (27), and (26) is largest at the outermost inner nodes $j=1,n$. Their squares equal $C\sinh^2((1-\delta)/2)$, including $n=1$, when the sole node is zero. This gives (29). $\square$

# 8. Uniform rates and the construction coefficient

**Lemma 23 (midpoint error for a single downward derivative jump).** For a cell $[a,b]$ of length $\delta$ and midpoint $m$, the error functional

$$\int_a^b g(u)\,du-\delta g(m)$$

has the Peano kernel

$$K_{a,b}(v)=
\begin{cases}(v-a)^2/2,&a\le v\le m,\\
(b-v)^2/2,&m\le v\le b.
\end{cases} \tag{30}$$

For an absolutely continuous function whose almost-everywhere first derivative has a bounded-variation representative, the error is $\int K_{a,b}\,d g'$. In particular $0\le K_{a,b}\le\delta^2/8$. If $g$ has nonnegative smooth curvature and one downward derivative jump $-J$, the midpoint sum on a partition into such cells exceeds the integral by at most $J\delta^2/8$.

**Proof.** The functional vanishes on affine functions. Applying it to the hinge $(u-v)_+$ gives (30), by integrating separately for $v\le m$ and $v\ge m$. Representing a function with derivative of bounded variation as an affine function plus the integral of these hinges against $dg'$ proves the identity by Fubini. Smooth nonnegative curvature contributes nonnegative error. A negative atom of size $J$ contributes no less than $-J\delta^2/8$. If the jump is at a cell boundary, that kernel is zero from both sides, so there is no omitted boundary case. $\square$

**Proposition 24 (uniform construction bound).** For every $n\ge1$,

$$0<\frac{W_n}{4}-\frac1{8e}
\le\frac{(1+C)^2}{64n^2}. \tag{31}$$

**Proof.** Positivity follows from Proposition 18. In the interior $|z|\le r$, view the loss as

$$g_z(u)=\min\{(z+\sqrt C e^{-u})^2,(z-\sqrt C e^u)^2\}.$$

Its switch is $u_0=\operatorname{arsinh}(z/\sqrt C)$. On a lower-center branch, setting $A_u=\sqrt C e^{-u}$ gives $g_z''=2A_u(z+2A_u)\ge0$, since $A_u\ge C$ and $z\ge-r$, so $z+2A_u\ge2C-r=(5C-1)/2>0$. Here $e<4<5$ suffices. The upper-center branch is symmetric. At the switch the derivative jumps downward by $4(C+z^2)$; differentiating the two branches and using $z=(a+b)/2$ and (16) gives this value directly.

Lemma 23 and the continuous-component weight $1/2$ imply

$$R_n(z)-R_*(z)
\le\frac12\frac{\delta^2}{8}\,4(C+z^2)
\le\frac{(1+C)^2}{16n^2}.$$

Use $C+r^2=s^2$ for the last step. Lemma 21 already handles the exterior. Dividing by four proves (31). $\square$

Taking $n=M-2$ proves (9). For fair bits use $n=2^{R-1}$ in (31); the lower bound follows from (8) because an $R$-bit public seed has $2^R$ states. This proves (10) and Theorem 3. To interpret the rate, define $R_{\min}(\varepsilon)$ as the least integer fair-bit budget for which some protocol has worst risk at most $V_\infty+\varepsilon$. The explicit construction and the all-protocol lower bound imply

$$R_{\min}(\varepsilon)=\frac12\log_2(1/\varepsilon)+O(1)
\quad\text{as }\varepsilon\downarrow0. \tag{32}$$

Rounding the upper budget to an integer changes only the bounded term. This concerns public randomness, while the communicated message remains one bit.

**Proposition 25 (asymptotic coefficient of the explicit construction).** As $n\to\infty$,

$$W_n=D+\frac{1+2C+3C^2}{24n^2}+O(n^{-3}). \tag{33}$$

Consequently, for the fair-bit construction,

$$\lim_{R\to\infty}4^R
\left(\frac{W_{2^{R-1}}}{4}-\frac1{8e}\right)
=\frac{1+2C+3C^2}{24}. \tag{34}$$

**Proof.** The needed Taylor expansions, with bounded remainders near zero, are

$$\begin{aligned}
1-\delta/\sinh\delta&=\delta^2/6+O(\delta^4),\\
\delta\coth\delta&=1+\delta^2/3+O(\delta^4),\\
\delta\operatorname{csch}\delta&=1-\delta^2/6+O(\delta^4),\\
C\sinh^2((1-\delta)/2)&=r^2+O(\delta).
\end{aligned}$$

Substitute into (29). The constant term is $C/2$. The coefficient of $\delta^2$ is

$$\frac{r^2}{6}+\frac C6+\frac{C^2}{12}
=\frac{1+2C+3C^2}{24}.$$

This gives (33). Substituting $n=2^{R-1}$ and accounting for the factor four in the coordinate change proves (34). $\square$

# 9. Reproduction and scope

The mathematical proofs above use exact identities, convexity, and measure arguments. Numerical diagnostics are supplied separately in `code/reproduce.py` and `results/diagnostics.json`. They independently evaluate source and threshold normalization, moments, the primal integral, all candidates for the finite-mixture maximum, and the asymptotic coefficient at high precision. These checks can reveal transcription or algebra errors; they are not substitutes for the proofs or a proof-assistant certificate.

The distinctions below are essential to interpretation.

* The input is one deterministic bounded scalar, not a sample mean, unknown distribution parameter, or vector.
* Exactly one binary symbol is transmitted. Public randomness is independent of the input, and all jointly usable correlated randomness is charged to its budget.
* Reconstruction is allowed to be biased. Clipping and nearest-center reduction need not preserve unbiasedness and therefore do not prove an unbiased analogue.
* Canonical uniqueness concerns the induced ordered decoder-pair law; bit relabelings, redundant public-seed refinements, and the encoder modifications in Proposition 12 are not excluded.
* Finite-resource bounds match in order. The formula (29) and coefficient (34) describe one construction only, and need not improve existing small-budget constructions.
* The extreme-source corollary is a reformulation of the same saddle point, not a separate novelty claim.
* This is a research manuscript. It has not received external peer review, and no Lean formalization is claimed. The inaccessible full text of [4] limits the literature comparison.

# References

[1] R. Ben Basat, M. Mitzenmacher, and S. Vargaftik. *How to Send a Real Number Using a Single Bit (And Some Shared Randomness).* 48th International Colloquium on Automata, Languages, and Programming (ICALP 2021), LIPIcs 198, article 25, pp. 25:1--25:20. DOI: [10.4230/LIPIcs.ICALP.2021.25](https://doi.org/10.4230/LIPIcs.ICALP.2021.25). Full author version: [arXiv:2010.02331v4](https://arxiv.org/html/2010.02331v4). Relevant locations: Sections 4.1.2, 6.2.3--6.2.4, and 8.

[2] N. Saldi, T. Linder, and S. Yüksel. *Randomized Quantization and Source Coding With Constrained Output Distribution.* IEEE Transactions on Information Theory 61(1), 91--106, January 2015. DOI: [10.1109/TIT.2014.2373382](https://doi.org/10.1109/TIT.2014.2373382). Full author version: [arXiv:1309.2915v2](https://arxiv.org/html/1309.2915v2). Relevant locations: Sections II and IV, Theorems 5 and 6. Publication metadata cross-checked against the author's publication list.

[3] R. Ben Basat, Y. Ben-Itzhak, M. Mitzenmacher, and S. Vargaftik. *Better than Optimal: Improving Adaptive Stochastic Quantization Using Shared Randomness.* Proceedings of the ACM on Measurement and Analysis of Computing Systems 9(3), article 49, 1--44, December 2025. DOI: [10.1145/3771564](https://doi.org/10.1145/3771564). [Author manuscript](https://www.bbasat.com/wp-content/uploads/2025/08/Simba.pdf). Relevant locations: Sections 2--3. The journal issue date and the later SIGMETRICS presentation year describe different events.

[4] T. Jiang, M. Gao, and S. Cai. *Exact Minimax One-Bit Unbiased Compression: Heavy-Tail Necessity and Finite-Randomness Approximation.* [arXiv:2609.27860](https://arxiv.org/abs/2609.27860), 2026. Evidence available at the audit date: indexed arXiv abstract and [author code repository](https://github.com/jiangxioabai/onebit_unbiased_compression), README blob `4448edb854a92d64807275ba5ab0bbb9d68aaf4f`. Full text was not obtained; no unverified theorem from this source is used.
