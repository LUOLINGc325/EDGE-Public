# Two-season frequency witnesses on directed cycles

*All positive edge rates and a quartic weak-amplitude effect on the four-cycle*

## 1. Problem and results

We consider the principal Floquet exponent of a positive linear system with fixed directed transport and two alternating diagonal potentials. Monmarché, Schreiber and Strickler (2025) established the slow overlap expansion and constructed cyclic witnesses with as many environments as sites. *Reversibility and frequency reduction in periodic and random positive systems* (Evidence Press, 2026), §6 and §10, gives a weak-amplitude two-state criterion and explicitly leaves its finite-amplitude classification unresolved, naming the unit directed four-cycle as a borderline case.

We prove that **every weighted one-way simple cycle on at least three sites has a two-season witness**, and that the **unit four-cycle has such witnesses at arbitrarily small nonzero amplitude**, with a positive fourth-order overlap. The two prescribed seasons work for every positive pair of residence fractions. With a two-state Markov environment, they also give a positive slow-switching correction.

## 2. Two-season construction for weighted cycles

Number sites by $i=0,\dots,n-1$ modulo $n$ and let $a_i>0$ be the transport rate from $i$ to $i+1$. In column-vector convention the fixed generator is given by
$$
L_{i,i-1}=a_{i-1},\qquad L_{i,i}=-a_i ,
$$
with other entries zero. For a positive vector $v$ define a diagonal perturbation by
$$
A(v)=L+\operatorname{diag}\!\left(a_i-a_{i-1}\frac{v_{i-1}}{v_i}\right)_{i=0}^{n-1}.
$$
It is irreducible Metzler and satisfies $A(v)v=0$. Its positive left vector, normalized to pair to one with $v$, is
$$
\ell_i(v)=\frac{w_i/v_{i-1}}{s(v)},\qquad
w_i=\frac1{a_{i-1}},\qquad
s(v)=\sum_i w_i v_i/v_{i-1}.
\tag{1}
$$
Indeed $\ell(v)^\top A(v)=0$, since its $i$th component is
$-a_{i-1}(v_{i-1}/v_i)\ell_i(v)+a_i\ell_{i+1}(v)$, and the two terms cancel. The normalization is immediate from (1). By Perron–Frobenius, zero is the simple spectral abscissa and every other eigenvalue has negative real part.

Use the two seasons $A(\mathbf 1)$ and $A(v)$, where $\mathbf1$ has each entry equal to one. Give $A(v)$ any fraction $\alpha\in(0,1)$ of a period $T>0$. The monodromy is
$$
M(T)=e^{\alpha T A(v)}e^{(1-\alpha)T A(\mathbf1)},\qquad
\Lambda(T)=T^{-1}\log\rho(M(T)).
$$
Each exponential converges to the rank-one Perron projector as its duration tends to infinity. The unique nonzero eigenvalue of the limiting product is
$$
K(v)=
\bigl(\ell(v)^\top\mathbf1\bigr)\bigl(\ell(\mathbf1)^\top v\bigr)
=\frac{(\sum_i w_i v_i)(\sum_i w_i/v_{i-1})}
 {(\sum_i w_i)(\sum_i w_i v_i/v_{i-1})}.
\tag{2}
$$
The spectral radius is continuous, so $\Lambda(T)=[\log K(v)+o(1)]/T$ as $T\to\infty$. Whenever $K(v)>1$, the Floquet exponent is strictly positive for all sufficiently large finite $T$ and tends to zero in the slow limit.

For $v_i=M^i$ with $M>1$ and $n\ge3$, put $W=\sum_i w_i$. We have $s(v)\le MW$, $\sum_i w_i v_i\ge w_{n-1}M^{n-1}$, and $\sum_iw_i/v_{i-1}\ge w_1$. Consequently
$$
K(v)\ge \frac{w_{n-1}w_1}{W^2}M^{n-2}.
\tag{3}
$$
Thus every prescribed set of positive edge rates admits a witness, with any
$$
M>\left(W^2/(w_{n-1}w_1)\right)^{1/(n-2)}.
$$
The overlap itself can be made arbitrarily large as the contrast grows. For unit rates, the smaller explicit examples $n=3,\ v=(1,4,16)$ and $n=4,\ v=(1,2,4,8)$ give $49/43$ and $225/196$, respectively.

To check the fast limit, let $\bar A=(1-\alpha)A(\mathbf1)+\alpha A(v)$. The elementary expansion $M(T)=I+T\bar A+O(T^2)$ gives $\lim_{T\downarrow0}\Lambda(T)=s(\bar A)$, its spectral abscissa. For detail, $(M(T)-I)/T$ is irreducible Metzler for positive $T$, has spectral abscissa $(\rho(M(T))-1)/T$, and converges to $\bar A$. If $x_i=v_i^\alpha$, then with $r_i=v_{i-1}/v_i$,
$$
\frac{(\bar A x)_i}{x_i}
 =a_{i-1}\bigl[r_i^\alpha-(1-\alpha)-\alpha r_i\bigr]\le0 .
\tag{4}
$$
The weighted arithmetic–geometric mean inequality is strict in every row with $r_i\ne1$. If $v$ is nonconstant, at least one row is strict. Pairing (4) with the strictly positive left Perron vector of $\bar A$ gives $s(\bar A)<0$. Thus $\Lambda(T)$ exceeds both its limiting values somewhere. Continuity on $(0,\infty)$ and the two endpoint limits imply an interior global maximum.

For completeness, let the environment instead be a two-state irreducible continuous-time Markov chain run at speed $\omega$, with stationary law $(1-\alpha,\alpha)$ and stationary flux $j=(1-\alpha)\xi_{12}=\alpha\xi_{21}>0$ for the unscaled rates. The hypotheses of Monmarché–Schreiber–Strickler, Theorem 1(3–4), hold because both matrices and their convex combination are irreducible. The slow-switching coefficient is $j\log K(v)>0$ by their overlap sum, and the fast-switching limit is $s(\bar A)<0$ by (4). This establishes nonmonotonicity for the two-state Markov version as well.

## 3. The unit four-cycle: exact weak witnesses

Take all $a_i=1$, and $v=(u,1,u^{-1},1)$ with $u=e^\varepsilon>0$ and $\varepsilon\ne0$. Then $s(v)=2(u+u^{-1})$, and (2) simplifies to
$$
K(v)=\frac{(u+u^{-1}+2)^2}{8(u+u^{-1})}
 =1+\frac{(\cosh\varepsilon-1)^2}{4\cosh\varepsilon}.
\tag{5}
$$
It follows that $K(v)>1$ for every nonzero $\varepsilon$, and
$$
\log K(v)=\frac{\varepsilon^4}{16}+O(\varepsilon^6).
$$
In particular $u=2$ gives $81/80$ exactly. The seasonal diagonal difference is
$$
(1-u^{-1},\,1-u,\,1-u,\,1-u^{-1})
 =(1-\cosh\varepsilon)\mathbf1+\sinh\varepsilon\,(1,-1,-1,1).
\tag{6}
$$
The scalar term shifts the Floquet exponent by a period average and does not change the witness. After removing it the potential difference has amplitude $\lvert\sinh\varepsilon\rvert$, which tends to zero. The centered direction in (6) lies in the quadratic nullspace in the source's §10. To see this directly, let $P$ be projection onto constants and let $C=(-L+P)^{-1}-P$. The centered direction $d=(1,-1,-1,1)$, together with its cyclic shift, lies in the subspace where the square of the cyclic shift is $-I$. On that subspace $(I-S)^{-1}=(I+S)/2$, so $C^2=S/2$ is skew and $d^\top C^2d=0$. The positive quartic coefficient therefore resolves the weak-amplitude degeneracy for this cycle. Reversing the order of site labels converts the unit generator to the transposed convention.

## 4. Scope and sources

The problem concerns a fixed transport generator, with only two diagonal states. Equal residence fractions make the deterministic protocol invariant under time reversal up to a phase shift. The proof in fact gives any pair of positive residence fractions; a two-state Markov chain is reversible in its environment variable. The construction treats all weighted simple directed cycles, and the unit four-cycle's weak-amplitude borderline. A classification for arbitrary irreversible transport graphs is a further problem.

- Anonymous, *Reversibility and frequency reduction in periodic and random positive systems*, Evidence Press / Zenodo, version 0.1.0-candidate (3 November 2026), §6 Theorem 6.1 and §10 Open Problems, item 1. [Deposit](https://zenodo.org/records/23911074). [Frozen §6](https://github.com/ipitchford/reversibility-frequency-reduction/blob/v0.1.0-candidate/sec6_twostate.tex). [Frozen §10](https://github.com/ipitchford/reversibility-frequency-reduction/blob/v0.1.0-candidate/sec10_discussion.tex).
- P. Monmarché, S. J. Schreiber and É. Strickler, *Impacts of Tempo and Mode of Environmental Fluctuations on Population Growth: Slow- and Fast-Limit Approximations of Lyapunov Exponents for Periodic and Random Environments*, Bulletin of Mathematical Biology **87** (2025), 81, Theorem 1 and §4.2. [Author-hosted journal full text](https://schreiber.faculty.ucdavis.edu/wp-content/uploads/sites/568/2025/07/BMB-2025.pdf).
- M. Benaïm, C. Lobry, T. Sari and É. Strickler, *When can a population spreading across sink habitats persist?*, Journal of Mathematical Biology **88** (2024), 19, Conjecture 1. [Author preprint v2](https://arxiv.org/html/2311.04706v2).
