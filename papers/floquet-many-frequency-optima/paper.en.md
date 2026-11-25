# Arbitrarily many frequency optima for a fixed irreversible generator

*Separated harmonics and strict Floquet peaks above both limiting rates*

## 1. Model and claim

Let $Q$ be a fixed irreducible finite row Markov generator. For a real vector potential $r(\theta)$ of period $2\pi$, let $\lambda_\epsilon(\omega)$ denote the principal Floquet exponent of the column system
$$
x'=[Q+\epsilon\operatorname{diag}r(\omega t)]x,\qquad\omega>0.
$$
The row convention gives $Q\mathbf1=0$. A positive diagonal similarity or simultaneous relabeling leaves the exponent unchanged.

**Theorem.** If $Q$ is irreversible, then for every integer $N\ge1$ there is a trigonometric-polynomial potential, supported on two fixed coordinates and with zero temporal mean, for which $\lambda_\epsilon$ has at least $N$ distinct strict local maxima for every sufficiently small $\epsilon>0$. Each respective maximum is above the limits at both $\omega\downarrow0$ and $\omega\to\infty$. The locations are bracketed by disjoint, explicitly chosen scaled intervals.

For the unit directed three-cycle with first row $(-1,1,0)$, use $R=10^4$ and
$$
r(\theta)=\sum_{j=0}^{N-1}10^{-j}
 (\cos(R^j\theta),-\sin(R^j\theta),0).
\tag{1}
$$
There is a strict local maximum in every interval $(1/(4R^j),\,2/R^j)$.

This gives an unbounded number of optima even with fixed irreversible transport and arbitrarily weak potentials. It addresses the number and location question in Evidence Press (2026), §10, item 5, in a constructive family. It does not classify the maxima of an arbitrary prescribed potential.

## 2. A single useful harmonic

Let $\pi$ be the stationary law and use the inner product $\langle z,y\rangle_\pi=\sum_i\pi_i\overline z_i y_i$. On its mean-zero complex subspace put $A=-Q$ and $C=A^{-1}$, and extend $C$ by zero on constants. Irreducibility gives
$\operatorname{Re}\langle y,Ay\rangle_\pi>0$ for every nonzero mean-zero $y$, since the real part is the Dirichlet form $\tfrac12\sum_{i,j}\pi_iQ_{ij}|y_i-y_j|^2$. In particular the spectrum of $C$ lies in the open right half-plane on this subspace.

If $C^2$ were self-adjoint, its eigenvalues on the subspace would all be strictly positive: a square root with positive real part of a nonzero real eigenvalue can occur only for a positive eigenvalue. Its eigenspaces reduce $C$ because the operators commute. On an eigenspace with eigenvalue $a>0$, $C$ satisfies $C^2=aI$ and has no negative root, so $C=\sqrt a I$. Thus $C$ would be self-adjoint, and so would $Q$, equivalent to detailed balance. Therefore for irreversible $Q$ there are indices $i\ne l$ with
$$
d_{il}=\pi_i(C^2)_{il}-\pi_l(C^2)_{li}\ne0.
$$
Choose $z$ as the centered version of $e_i+i\,\operatorname{sign}(d_{il})e_l$. Then $\operatorname{Im}\langle z,C^2z\rangle_\pi>0$. Removing the centered scalar from a periodic potential only adds a scalar sinusoid with zero temporal mean, which leaves its Floquet exponent unchanged. Thus potentials can be described using the uncentered two-site vector.

Define the real response
$$
\beta(s)=\tfrac12\operatorname{Re}\langle z,(A+is)^{-1}z\rangle_\pi,\qquad s\ge0.
$$
This is positive, since if $y=(A+is)^{-1}z$, its real part before the factor $1/2$ equals $\operatorname{Re}\langle Ay,y\rangle_\pi>0$. Differentiation gives $\beta'(0)=\tfrac12\operatorname{Im}\langle z,C^2z\rangle_\pi>0$. For large $s$, expand the inverse in powers of $1/(is)$. Its first scalar term is purely imaginary after pairing with $z$, so $\beta(s)=O(s^{-2})$ and $\beta'(s)=O(s^{-3})$. The derivative estimate follows by differentiating the convergent inverse series at large $s$.

Choose $0<a<s_0<b$ with $\beta'(a)>0$, $\beta(s_0)>\beta(0)$, and $\beta'(b)<0$. This is possible by the initial positive slope and the limit zero. Also $\beta(s)\ge\beta(0)$ on a sufficiently short initial interval.

## 3. Independent frequency scales

Let $0<\xi<1$ be so small that
$$
\beta(0)\frac{\xi}{1-\xi}<\beta(s_0)-\beta(0).
\tag{2}
$$
For an integer $R>1$, set $n_j=R^j$, and choose the potential with centered representation
$$
 r(\theta)=\sum_{j=0}^{N-1}\xi^{j/2}\operatorname{Re}(z e^{in_j\theta}).
\tag{3}
$$
Its two-site representative uses the uncentered vector, with identical exponents. For fixed $\omega>0$, the first-order periodic mode at harmonic $n_j$ solves the linear equation with resolvent $(A+in_j\omega)^{-1}$. The linear correction to the eigenvalue vanishes by zero temporal mean. Integrating the second-order equation in $\pi$ and phase shows that all cross-frequency terms vanish and
$$
\lambda_\epsilon(\omega)=\epsilon^2 B_N(\omega)+O_{\omega,N}(\epsilon^3),
\qquad B_N(\omega)=\sum_{j=0}^{N-1}\xi^j\beta(n_j\omega).
\tag{4}
$$
For clarity, this expansion follows by analytic perturbation of the positive monodromy matrix at $\epsilon=0$. Normalize the constant mode to $\mathbf1$ and write the first-order right mode as the sum of the resolved harmonics. The coefficient in (4) is the phase average of the $\pi$ pairing of that first-order mode with $r$. The same perturbation with zero frequency gives the frozen Perron coefficient $\langle r(\theta),Cr(\theta)\rangle_\pi$. Its phase average equals $B_N(0)$ by the same orthogonality. The quoted slow and fast endpoint formulas in Evidence Press, §5, therefore give
$$
\lambda_{\rm slow}(\epsilon)=\epsilon^2 B_N(0)+O_N(\epsilon^3),\qquad
\lambda_{\rm fast}(\epsilon)=0.
\tag{5}
$$
These formulas apply to the smooth zero-mean potential (3).

Choose $R$ with $\xi R>1$, $R>b/a$, and $s_0/R$ in the initial interval where $\beta(s)\ge\beta(0)$. At either $\omega=a/n_j$ or $b/n_j$, normalize $B_N'(\omega)$ by $\xi^j n_j$. The own-harmonic term is respectively $\beta'(a)$ or $\beta'(b)$. Let $C_0$ bound $|\beta'|$ on $[0,\infty)$ and let $C_\infty$ satisfy $|\beta'(s)|\le C_\infty s^{-3}$ for $s\ge1$. By also choosing $aR\ge1$, the other terms have total absolute value at most
$$
\frac{C_0}{\xi R-1}+\frac{C_\infty \xi}{a^3(R^2-\xi)}.
\tag{6}
$$
The first term sums the lower harmonics and the second sums the higher. Choose $R$ large enough to make (6) smaller than both own slopes in absolute value. Then $B_N'$ is positive at each left endpoint and negative at each right endpoint of the disjoint intervals $(a/n_j,b/n_j)$.

The value at $s_0/n_j$ lies above the slow coefficient. Indeed, after subtracting $B_N(0)$ and dividing by $\xi^j$, lower harmonics make nonnegative contributions, the own contribution is $\beta(s_0)-\beta(0)$, and the total loss from higher harmonics is at most $\beta(0)\xi/(1-\xi)$ by positivity of $\beta$. Inequality (2) makes this strict. It also puts the value above zero.

For each of the finitely many intervals select an interior point sufficiently near its left end with larger $B_N$ than at that endpoint, and one near the right end with larger $B_N$ than at the right. The pointwise expansion (4) at this finite set, including the endpoints and $s_0/n_j$, transfers these strict comparisons to $\lambda_\epsilon$ at sufficiently small positive $\epsilon$. The endpoint limits follow (5). The maximum on each closed interval is attained inside, and exceeds both limiting rates. The map $\omega\mapsto\lambda_\epsilon(\omega)$ is real analytic for positive speeds because the monodromy depends analytically on $1/\omega$ and has a simple positive Perron root. It is nonconstant by the retained endpoint comparisons. Hence any such interior maximum is strict locally. The potential norm is at most a constant times $\epsilon/(1-\sqrt{\xi})$ for the fixed generator. This proves the theorem. $\square$

## 4. Exact three-cycle constants

For the unit directed three-cycle and uncentered $z=e_1+ie_2$, the rational single-mode response, also computed in Evidence Press §9, is
$$
\beta(s)=\frac{1+s/2+s^2/3}{s^4+3s^2+9}.
$$
We have $\beta'(1/4)=852736/16609827>1/20$, $\beta'(2)=-473/8214<-1/20$, and $\beta(3/4)-\beta(0)=29/939$. From the derivative numerator
$$
 -\tfrac16(4s^5+9s^4+24s^3+9s^2-27)
$$
over $(s^4+3s^2+9)^2$, both $C_0=13$ globally and $C_\infty=13$ for $s\ge1$ work. The lower-harmonic arguments in (6) are below one and there $|\beta'|\le1$, so one may use $1$ for the first numerator of (6). We also have $\beta(s)-\beta(0)=[(9/2)s-s^4]/[9(s^4+3s^2+9)]\ge0$ for $s\in[0,3/4]$. Take $a=1/4$, $s_0=3/4$, $b=2$, $\xi=1/100$ and $R=10^4$. The interference in (6) is below $1/90$, and the lost higher-harmonic baseline in (2) is at most $1/891<29/939$. This yields (1) and its explicit locations.

## Source

Anonymous, *Reversibility and frequency reduction in periodic and random positive systems*, Evidence Press / Zenodo, version 0.1.0-candidate (3 November 2026), §§5 and 9, and §10 item 5. [Deposit](https://zenodo.org/records/23911074). [Frozen §10](https://github.com/ipitchford/reversibility-frequency-reduction/blob/v0.1.0-candidate/sec10_discussion.tex).
