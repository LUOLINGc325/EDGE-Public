# Sharp Entropy Bands for Finite-Resolution Observations of Three-State Markov Chains

*A complete compatibility-set theorem with known uniform stationarity*

AI-assisted research manuscript

24 November 2026

# Abstract

We study entropy-production inference from a complete transition matrix known only within a deterministic Frobenius tolerance. The underlying process is a time-homogeneous continuous-time Markov chain on exactly three observed states, with known uniform stationary law and reciprocal support. For sufficiently small tolerance near a symmetric transition matrix with a repeated positive eigenvalue in the nonunique-embedding regime, we prove that all compatible finite entropy rates form two separated intervals. The low interval opens quadratically in the observation error, with sharp coefficient $2/(u\lambda^2t^2)$. The high interval is unbounded above; its exact lower endpoint reduces to a one-dimensional minimization on a complex spectral disk and moves linearly with a sharp explicit coefficient. A negative repeated eigenvalue produces only the high interval. The proof covers all compatible nonnormal generators and all logarithm branches, and gives explicit sufficient conditions for a nonempty excluded interval. No activity constraint is imposed. The zero-error classification is treated as a consequence of prior work, including an earlier explicit realization family. The contribution assessed here is the full error-ball image and its sharp endpoint behavior. This is a research manuscript, not an externally peer-reviewed or formally certified proof.

# 1. Motivation and prior work

For a continuously evolving Markov process observed only at fixed time intervals, the generator need not be uniquely recoverable from the sampled transition matrix. Bauer, Seifert, and van der Meer [1] explain how candidate matrix logarithms can yield thermodynamic bounds, while their finite-candidate enumeration excludes repeated propagator eigenspaces. Baake and Sumner [2] give detailed three-state embedding classifications.

A symmetric three-state observation with repeated nontrivial eigenvalue has the form
$$
P_\lambda=\Pi+\lambda H,\qquad
\Pi=\frac{\mathbf1\mathbf1^T}{3},\quad H=I-\Pi.
\tag{1}
$$
At exact resonance, equilibrium and driven generators can produce the same observations [1]. The entropy formula for a homogeneous cycle is standard [3]; its spectral lower envelope follows from the established coherence-affinity bounds [4,5]. Related spectral-entropy constraints are developed in [6].

The zero-error entropy image also follows by combining those results with an explicit family in Anonymous [7, Section 3.1]. Its uniform-stationary subfamily preserves the full generator spectrum, connects the homogeneous minimizer to a one-way boundary, and has divergent entropy. At resonant sampling it preserves the complete observed matrix. We independently derived another parameterization, but a later full-text comparison established this prior implication. The exact-data image is therefore background, not the novelty claim of this manuscript.

The question addressed here is different and operationally sharper: **what is the entire entropy image when the observed matrix may vary within a small error ball?** Arbitrarily small observation perturbations can permit small positive entropy rates, so the isolated reversible value at zero error does not remain isolated. That observation alone does not determine whether the rest of the excluded interval survives, how large the low-entropy component becomes, or how far the high-entropy threshold moves.

Our answer is a complete two-interval theorem. Its method combines the analytic principal logarithm with a global spectral-disk constraint on every other real logarithm. Frobenius-constrained linear-response optimization is an established technique; recent work also studies entropy functionals under Markov-matrix perturbations [8]. Here the objective is the entropy of every compatible continuous-time generator, across all logarithm branches, rather than that of the perturbed discrete matrix itself. Finite-resolution and noisy-observation inference are studied in [9,10]; the present tolerance model is deterministic and does not by itself provide a statistical confidence guarantee.

# 2. Model and definitions

Fix a known sampling interval $t>0$. An admissible generator $Q$ is a real $3\times3$ matrix satisfying
$$
Q\mathbf1=0,\qquad \mathbf1^TQ=0,\qquad
q_{ij}\geq0\ (i\ne j),\qquad
q_{ij}>0\Longleftrightarrow q_{ji}>0.
\tag{2}
$$
Thus the stationary law is known to be uniform. The observations are complete over the three states; there are no hidden states or time-dependent rates. Nearby observed matrices need not be symmetric, but they are doubly stochastic. This restriction is part of the model, not a conclusion about arbitrary Markov chains.

With natural logarithms and $k_B=1$, define
$$
\sigma(Q)=\frac13\sum_{i<j}
(q_{ij}-q_{ji})\log\frac{q_{ij}}{q_{ji}}.
\tag{3}
$$
A pair of absent edges contributes zero. Reciprocal support ensures finite entropy for each finite generator in the classes considered below. We determine
$$
\mathcal S_\varepsilon(\lambda)
=\left\{\sigma(Q):Q\text{ satisfies (2)},\
\|e^{tQ}-P_\lambda\|_F\leq\varepsilon\right\}.
\tag{4}
$$
No constraint fixes the activity of a nearby generator.

Let
$$
\ell=|\lambda|,\quad u=-\frac{\log\ell}{t},\quad
\beta=\begin{cases}2\pi,&\lambda>0,\\ \pi,&\lambda<0,\end{cases}
\quad\omega_0=\frac{\beta}{t}.
\tag{5}
$$
We consider centers strictly inside the nonzero reciprocal-embedding regime:
$$
0<\ell<e^{-\sqrt3\beta}.
\tag{6}
$$
For $a>\sqrt3 b>0$, write
$$
G(a,b)=\frac{2b}{\sqrt3}
\log\frac{a+\sqrt3 b}{a-\sqrt3 b}.
\tag{7}
$$
The quantities $u,\omega_0,G,\sigma$ have units of inverse time; $\lambda$ and $\varepsilon$ are dimensionless.

For $\varepsilon>0$, impose the explicit base conditions
$$
\varepsilon<\ell/2,\qquad
\ell+\varepsilon/\sqrt2<e^{-\sqrt3\beta}.
\tag{8}
$$
In the positive case we also require
$$
D_\varepsilon=-\frac1t\log(1-\varepsilon/\lambda)<u/3.
\tag{9}
$$
All these conditions hold for sufficiently small positive $\varepsilon$.

# 3. Main results

## Theorem 1. Complete entropy images

Assume (6)-(8), and also (9) when $\lambda>0$. Set
$$
r=\varepsilon/\sqrt2,\qquad
z_\phi=\ell+r e^{i\phi},\qquad 0\leq\phi\leq\pi,
$$
$$
a_\phi=-\frac{\log|z_\phi|}{t},\qquad
b_\phi=\frac{\beta-\arg z_\phi}{t},\qquad
m_\varepsilon=\min_{0\leq\phi\leq\pi}G(a_\phi,b_\phi).
\tag{10}
$$
The argument in (10) is taken in the upper right half-plane, so it is unambiguous and nonnegative.

If $\lambda>0$, there exists an attained finite maximum $M_\varepsilon$ of the principal-logarithm sector such that
$$
\boxed{\mathcal S_\varepsilon(\lambda)
=[0,M_\varepsilon]\ \cup\ [m_\varepsilon,\infty).}
\tag{11}
$$
The high interval is exactly the image of all nonprincipal sectors. Every value in either interval is attained by a reciprocal finite-rate generator.

If $\lambda<0$, there is no low sector and
$$
\boxed{\mathcal S_\varepsilon(\lambda)=[m_\varepsilon,\infty).}
\tag{12}
$$

For finite positive error, (10) is an exact one-dimensional variational formula. We do not claim a closed form for $M_\varepsilon$ at every finite error; the next result provides explicit bounds and its sharp leading term.

## Theorem 2. Sharp endpoint behavior and a checkable gap

For a fixed center and sampling interval satisfying (6), as $\varepsilon\downarrow0$,
$$
M_\varepsilon=
\frac{2\varepsilon^2}{u\lambda^2t^2}+O(\varepsilon^3)
\qquad(\lambda>0),
\tag{13}
$$
and, for either sign,
$$
m_\varepsilon=
G(u,\omega_0)-
\frac{\|\nabla G(u,\omega_0)\|_2}{\sqrt2\,\ell t}\,
\varepsilon+O(\varepsilon^2).
\tag{14}
$$
The derivative is with respect to the two rate variables:
$$
G_a=-\frac{4b^2}{a^2-3b^2},\qquad
G_b=\frac2{\sqrt3}\log\frac{a+\sqrt3 b}{a-\sqrt3 b}
+\frac{4ab}{a^2-3b^2}.
\tag{15}
$$

In the positive case define
$$
c_\varepsilon=\frac2{\sqrt3 t}
\arcsin\frac{\varepsilon}{2\sqrt2\lambda},\quad
L_\varepsilon=
2c_\varepsilon\log\frac{u+3c_\varepsilon}{u-3c_\varepsilon},
\quad
B_\varepsilon=\frac{2D_\varepsilon^2}{u-3D_\varepsilon}.
\tag{16}
$$
Then $L_\varepsilon\leq M_\varepsilon\leq B_\varepsilon$. A sufficient, directly checkable condition for the intervals in (11) to be separated is
$$
B_\varepsilon<
G\left(
-\frac{\log(\lambda-r)}{t},\
\frac{2\pi-\arcsin(r/\lambda)}{t}
\right).
\tag{17}
$$
It holds for all sufficiently small positive $\varepsilon$. Consequently the excluded interval $(M_\varepsilon,m_\varepsilon)$ persists, even though the isolated zero of the exact-data problem broadens into a nontrivial low-entropy interval.

# 4. Background facts and their attribution

We give the needed three-state facts explicitly to make the proof auditable. The thresholds, lower-envelope value, and exact-center upper interval are consequences of prior work [2,4,5,7].

Every matrix satisfying the zero-sum conditions in (2) is uniquely parameterized as
$$
Q(x,y,z,c)=
\begin{pmatrix}
-(x+z)&x+c&z-c\\
x-c&-(x+y)&y+c\\
z+c&y-c&-(y+z)
\end{pmatrix}.
\tag{18}
$$
Let $a=x+y+z$ and
$\Delta=x^2+y^2+z^2-xy-yz-zx\geq0$. Direct expansion gives
$$
\det(vI-Q)=v[(v+a)^2-\Delta+3c^2].
\tag{19}
$$
If the nonzero eigenvalues are $-a\pm ib$, $b>0$, then $3c^2-\Delta=b^2$. Writing $C=|c|$, reciprocal support implies $x,y,z>C$, and hence
$$
a>3C\geq\sqrt3 b,\qquad
\sigma(Q)=\frac{2C}{3}\sum_{s=x,y,z}
\log\frac{s+C}{s-C}\geq G(a,b).
\tag{20}
$$
For completeness, $s\mapsto\log((s+C)/(s-C))$ has second derivative $4Cs/(s^2-C^2)^2>0$. Jensen's inequality gives $\sigma\geq2C\log((a+3C)/(a-3C))$, and this expression increases strictly with $C$. Equality in (20) occurs only at $x=y=z=a/3$, $c=\pm b/\sqrt3$.

The same lower bound follows from [5, equation (10)], with [4] as its earlier source: the three-cycle inequality is $b/a\leq\tanh(\mathcal A/6)/\sqrt3$, and $\sigma=(2C/3)\mathcal A$. We do not claim (20) as a new spectral-entropy inequality.

Let
$$
C_0=\begin{pmatrix}0&1&-1\\-1&0&1\\1&-1&0\end{pmatrix},
\qquad Q_{\rm hom}(a,b)=-aH+\frac b{\sqrt3}C_0.
\tag{21}
$$
Since $C_0^2=-3H$, this homogeneous generator has spectrum $0,-a\pm ib$, entropy $G(a,b)$, and
$$
e^{tQ_{\rm hom}(a,b)}
=\Pi+e^{-at}\left[
\cos(bt)H+\frac{\sin(bt)}{\sqrt3}C_0
\right].
\tag{22}
$$

At a resonant center, every value in $[G(u,\omega_0),\infty)$ is attainable. One self-contained realization uses
$$
x_\delta=u/3-2\delta,\quad y_\delta=z_\delta=u/3+\delta,
\quad c_\delta=\sqrt{\omega_0^2/3+3\delta^2},
$$
$$
0\leq\delta<\delta_*=
\frac{2u}{3}-\frac{\sqrt{u^2+\omega_0^2}}{\sqrt3}.
\tag{23}
$$
Here $\Delta=9\delta^2$, all rates are positive, and the nonzero spectrum stays $-u\pm i\omega_0$. On the zero-sum plane the two eigenvalues exponentiate to the same scalar $\lambda$; thus the entire exponential remains $P_\lambda$, including for nonnormal generators. At $\delta=0$, entropy is $G(u,\omega_0)$; as $\delta\uparrow\delta_*$, $x_\delta-c_\delta\downarrow0$ while its reverse flux remains positive, so entropy diverges. Continuity fills the entire interval. The different explicit family in [7] already implies this existence result; (23) is a convenient reconstruction of the background fact.

# 5. Proof of the low-entropy interval

Assume $\lambda>0$. Let $\mathcal B_\varepsilon$ be the closed ball of all real matrices $E$ satisfying
$$
E\mathbf1=0,\qquad \mathbf1^TE=0,\qquad \|E\|_F\leq\varepsilon.
$$
For each such $E$, $P_\lambda+E$ is stochastic and strictly positive: (6) gives $\lambda<1/4$, and (8) gives $\varepsilon<\lambda/2<(1-\lambda)/3$.

The principal logarithm is
$$
Q_{\rm pr}(E)=-uH+\frac1t\log(I+E/\lambda),
\tag{24}
$$
where the logarithm is its convergent power series. Because $E\Pi=\Pi E=0$, exponentiating $t$ times (24) gives exactly $P_\lambda+E$. The same relations give zero row and column sums. Furthermore,
$$
\|Q_{\rm pr}(E)+uH\|_F
\leq\frac1t\sum_{k\geq1}\frac{(\varepsilon/\lambda)^k}{k}
=D_\varepsilon.
\tag{25}
$$
Every off-diagonal entry is therefore at least $u/3-D_\varepsilon>0$. The whole ball, not just a selected curve, has admissible principal generators.

Conversely, every compatible generator in the principal logarithm sector equals (24). The ball is compact and connected, and entropy is continuous on its strictly positive generator image. Entropy is nonnegative and vanishes at $E=0$, so its image is exactly $[0,M_\varepsilon]$, with the maximum attained.

To bound that maximum, put $A=Q_{\rm pr}(E)+uH$ and $s_0=u/3$. The mean value theorem gives
$$
\sigma(Q_{\rm pr})
\leq\frac{1}{3(s_0-D_\varepsilon)}
\sum_{i<j}(A_{ij}-A_{ji})^2
=\frac{2\|\operatorname{skew}A\|_F^2}{3(s_0-D_\varepsilon)}
\leq B_\varepsilon.
\tag{26}
$$
Here $\operatorname{skew}A=(A-A^T)/2$. This establishes a bound for every nonnormal principal generator in the ball.

For the matching witness, take $Q=-uH+c_\varepsilon C_0$. Formula (22) gives the exact distance
$$
\|e^{tQ}-P_\lambda\|_F
=2\sqrt2\lambda
\left|\sin\frac{\sqrt3 c_\varepsilon t}{2}\right|
=\varepsilon.
\tag{27}
$$
The branch is principal, and its rates are positive under the stated smallness assumptions. Its entropy is $L_\varepsilon$, proving the two-sided bounds in (16). Expansion yields
$$
D_\varepsilon=\frac{\varepsilon}{\lambda t}+O(\varepsilon^2),
\quad
c_\varepsilon=\frac{\varepsilon}{\sqrt6\lambda t}+O(\varepsilon^3).
$$
Both bounds have leading term $2\varepsilon^2/(u\lambda^2t^2)$; the upper remainder is $O(\varepsilon^3)$. This proves (13). It does not assert that the witness maximizes entropy at every finite tolerance.

# 6. Proof of the high-entropy interval

## 6.1 All real logarithm branches are covered

An orthonormal basis beginning with $\mathbf1/\sqrt3$ reduces every admissible $Q$ to $0\oplus B$, where $B$ is a real $2\times2$ matrix. If $B$ has real eigenvalues and the observed spectrum lies near a positive center, $Q$ is in the principal sector. The real Jordan case is also captured by the principal logarithm series. Every nonprincipal positive-center embedding must have nonreal spectrum $-a\pm ib$, and its winding frequency satisfies
$$
b\geq\frac{2\pi-|\arg z|}{t},
\tag{28}
$$
where $z=e^{(-a+ib)t}$ is one of the two observed nontrivial eigenvalues.

For a negative center, write the observed eigenvalue as $z=-w$. Condition (8) puts $w$ in a disk about positive $\ell$. Real eigenvalues of $B$ cannot exponentiate to this left-half-plane observed spectrum. Every compatible $Q$ therefore has a nonreal pair and
$$
b\geq\frac{\pi-|\arg w|}{t}.
\tag{29}
$$
This change of variable is essential; (29) does not apply the positive-center argument formula directly at a negative real number.

## 6.2 The Frobenius constraint gives a global spectral disk

Unitary Schur triangularization of the observed zero-sum block gives
$$
\|e^{tQ}-P_\lambda\|_F^2
\geq |z-\lambda|^2+|\overline z-\lambda|^2
=2|z-\lambda|^2.
\tag{30}
$$
This inequality includes all nonnormal generators. Thus, after the negative-center sign change when needed, $|w-\ell|\leq r$.

The lower envelope (20), the frequency bounds (28)-(29), and $G_b>0$ imply
$$
\sigma(Q)\geq
\min_{|w-\ell|\leq r}
G\left(-\frac{\log|w|}{t},\frac{\beta-|\arg w|}{t}\right).
\tag{31}
$$
The disk lies entirely in the right half-plane. By conjugation, restrict to its upper half. Away from the real axis, the map from $w$ to its logarithmic radius and angle is smooth with nonsingular Jacobian, while $G_a<0$ and $G_b>0$. Therefore the objective has no interior minimum. On the interior of the real diameter, a small upward displacement decreases $b$ to first order and changes $a$ only to second order, so it decreases the objective. The minimum is consequently on the circular semicircle, giving exactly (10).

## 6.3 Attainment and filling the whole interval

For every boundary point in (10), conditions (8) imply
$$
a_\phi\geq-\frac{\log(\ell+r)}{t}
>\sqrt3\omega_0\geq\sqrt3 b_\phi.
$$
The homogeneous generator $Q_{\rm hom}(a_\phi,b_\phi)$ is therefore admissible. It attains the entropy bound and also equality in (30), so a minimizing point realizes $m_\varepsilon$ exactly.

Join this point to the disk center by a straight line. Use (21) at every point, with the same branch choice. The entire line stays inside the observation disk and satisfies the rate inequalities above. Its continuous entropy values connect $m_\varepsilon$ to $G(u,\omega_0)$. The exact-center family (23) then realizes every larger finite value. No monotonicity of the joining path is needed. The global lower bound excludes all smaller high-sector values.

Every compatible generator belongs either to the positive-center principal sector or to the sectors just considered. This proves (11) and (12).

Finally, throughout the positive spectral disk,
$$
a\leq-\log(\lambda-r)/t,\qquad
b\geq(2\pi-\arcsin(r/\lambda))/t.
$$
Since $G$ decreases in $a$ and increases in $b$, the right side of (17) is a lower bound on $m_\varepsilon$. Together with (26), this proves the separation criterion.

# 7. Sharp motion of the high endpoint

Write $w=\ell+x+iy$, $y\geq0$, $x^2+y^2\leq r^2$. Uniformly on this shrinking half-disk,
$$
a=u-\frac{x}{\ell t}+O(r^2),\qquad
b=\omega_0-\frac{y}{\ell t}+O(r^2).
$$
Hence the objective in (31) is
$$
G(u,\omega_0)
-\frac{G_a(u,\omega_0)x+G_b(u,\omega_0)y}{\ell t}
+O(r^2).
\tag{32}
$$
The remainder is uniform because the center lies strictly inside the smooth domain of $G$. The largest linear numerator on the half-disk is $r\|\nabla G\|_2$, attained in direction
$$
(x,y)=r\,\frac{(G_a,G_b)}{\|\nabla G\|_2}.
$$
Since $G_b>0$, this direction satisfies the half-disk constraint. Substituting $r=\varepsilon/\sqrt2$ proves (14). Equality to first order is realized by the homogeneous construction, so the coefficient is sharp. The first-order optimization principle is standard; the substantive result is that this local minimum is also the threshold for the full collection of logarithm branches.

# 8. Interpretation, limitations, and verification

The surviving gap is not a claim that the isolated exact-data zero is stable. The reversible point becomes an interval of width proportional to $\varepsilon^2$, while the high threshold moves by order $\varepsilon$. Their different orders leave a nonempty excluded interval for sufficiently small error.

The natural resolution scale is relative to $|\lambda|$. In the positive case, $\lambda<e^{-2\pi\sqrt3}$, so the relevant repeated eigenvalue is small. The factors $\lambda^{-2}$ and $|\lambda|^{-1}$ in (13)-(14) expose this conditioning directly. The theorem should not be interpreted as a broad practical guarantee at an unspecified absolute noise level.

No fixed activity is required. Nevertheless, all compatible generators at fixed error have bounded rates. The nontrivial observed eigenvalues have modulus at least $\ell-\varepsilon$, so
$$
\sum_{i\ne j}q_{ij}=-\operatorname{tr}Q
=-\frac1t\log\det(e^{tQ})
\leq-\frac2t\log(\ell-\varepsilon).
\tag{33}
$$
Thus the unbounded high-entropy interval cannot be explained by an unbounded overall clock rate. Reverse rates can approach zero.

The model assumes known uniform stationarity, exactly three visible states, time-homogeneous rates, and a deterministic Frobenius tolerance. It does not cover an unrestricted ball of arbitrary continuous-time Markov chains, unknown hidden architecture, or finite-sample coverage without a separately justified observation-error guarantee. The upper endpoint of the low interval, $M_\varepsilon$, is characterized as an attained compact optimization and by sharp asymptotics; an exact closed formula at every finite tolerance is not supplied.

The endpoint estimates bracket the principal-sector maximum; neither bound is asserted to equal it.

For example, at $t=1$, $u=12$, and $\varepsilon=0.1e^{-12}$, the explicit bounds give approximately $0.00166742\leq M_\varepsilon\leq0.00190019$. The scalar endpoint is numerically $m_\varepsilon\approx20.78908$, while the simpler rigorous expression on the right side of (17) evaluates to approximately $20.48623$. The very different scales of the endpoints are therefore a property of the theorem, not a fitted separation. Numerical endpoint optimization is recorded as numerical evidence, not an interval-arithmetic certificate.

The primary checker verifies the derivative and distance identities, directly exponentiates endpoint and joining-path matrices at high precision, and checks both asymptotic coefficients. A separately written checker samples the full balanced principal ball and nonnormal nonprincipal embeddings. The earlier exact-center checkers remain supporting evidence for the background facts. Finite calculations do not prove the universal exclusions or interval-filling statements; Sections 4-7 provide those proofs.

This manuscript does not claim external peer review or Lean certification. The computational and figure-generation materials are not included in this edition.

# References

1. M. T. Bauer, U. Seifert, and J. van der Meer. *Stroboscopic measurements in Markov networks: Exact generator reconstruction vs. thermodynamic inference*. Journal of Physics A **58**, 125001 (2025). [arXiv:2412.15642v2](https://arxiv.org/html/2412.15642v2).
2. M. Baake and J. Sumner. *Embedding of Markov matrices for $d\leq4$*. Journal of Mathematical Biology **89**, 23 (2024). [doi:10.1007/s00285-024-02112-w](https://doi.org/10.1007/s00285-024-02112-w).
3. L. Cocconi, R. Garcia-Millan, Z. Zhen, B. Buturca, and G. Pruessner. *Entropy Production in Exactly Solvable Systems*. Entropy **22**, 1252 (2020). [Open full text](https://pmc.ncbi.nlm.nih.gov/articles/PMC7711514/).
4. A. C. Barato and U. Seifert. *Coherence of biochemical oscillations is bounded by driving force and network topology*. Physical Review E **95**, 062409 (2017). [doi:10.1103/PhysRevE.95.062409](https://doi.org/10.1103/PhysRevE.95.062409).
5. N. Ohga, S. Ito, and A. Kolchinsky. *Thermodynamic Bound on the Asymmetry of Cross-Correlations*. Physical Review Letters **131**, 077101 (2023). [doi:10.1103/PhysRevLett.131.077101](https://doi.org/10.1103/PhysRevLett.131.077101).
6. A. Kolchinsky, N. Ohga, and S. Ito. *Thermodynamic bound on spectral perturbations, with applications to oscillations and relaxation dynamics*. Physical Review Research **6**, 013082 (2024). [doi:10.1103/PhysRevResearch.6.013082](https://doi.org/10.1103/PhysRevResearch.6.013082).
7. Anonymous. *Hidden architecture and the thermodynamic cost of an exact stochastic signal*. Version 1.0.0-candidate (28 October 2026). [doi:10.5281/zenodo.23721621](https://doi.org/10.5281/zenodo.23721621). [Public versioned source](https://github.com/ipitchford/hidden-architecture-exact-signal/tree/v1.0.0-candidate).
8. M. Santos Gutiérrez, N. Zagli, and G. Carigi. *Markov matrix perturbations to optimize dynamical and entropy functionals*. [arXiv:2507.14040v2](https://arxiv.org/abs/2507.14040v2) (2026 revision).
9. J. H. Fritz, B. Ertel, and U. Seifert. *Entropy estimation for partially accessible Markov networks based on imperfect observations: Role of finite resolution and finite statistics*. Physical Review E **111**, 044106 (2025). [arXiv:2412.04102](https://arxiv.org/abs/2412.04102).
10. T. R. Gingrich, O. A. Igoshin, A. B. Kolomeisky, and D. E. Makarov. *Thermodynamic inference from noisy single-molecule time series*. Journal of Chemical Physics **165**, 124124 (2026). [doi:10.1063/5.0354355](https://doi.org/10.1063/5.0354355). [Author accepted manuscript](https://gingrich.chem.northwestern.edu/papers/JCP26-AR-03331.pdf).
