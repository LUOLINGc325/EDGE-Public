# Annealed frequency reduction under irreversible environmental switching

*A path-entropy transfer and the exact strictness criterion*

## 1. Problem and theorem

Let $A_1,\ldots,A_K$ be irreducible real Metzler matrices of the same finite size. Suppose one positive diagonal similarity makes all $A_k$ symmetric. Let $\sigma$ be an irreducible finite-state continuous-time Markov chain with generator $G$ in row convention. Its physical switching speed is $\omega>0$, and the system is
$$
x'(t)=A_{\sigma(\omega t)}x(t).
$$
With a stationary initial environment and a fixed positive initial $x$, let $\Lambda_{\rm ann}(\omega)$ be the long-run logarithmic growth exponent of $\mathbb E[\mathbf 1^\top x(t)]$. The environment $G$ may be irreversible.

*Reversibility and frequency reduction in periodic and random positive systems* (Evidence Press, 2026), §7 and §10 open problem 4, proves annealed monotonicity when both spatial transport and environment are reversible and asks whether an irreversible environment can instead raise the annealed exponent. We answer in the negative, in the wider simultaneously symmetrizable class.

**Theorem.** The function $\Lambda_{\rm ann}(\omega)$ is nonincreasing. It is strictly decreasing on $(0,\infty)$ unless all $A_k$ share a positive eigenvector with the same eigenvalue. In that case it is constant. In particular, for $A_k=Q+D_k$ with fixed irreducible reversible $Q$ and diagonal $D_k$, strictness fails exactly when all $D_k$ are equal.

We use the quenched monotonicity theorem in the source's §7, subsection “Varying interaction graphs.” Its hypothesis is exactly one positive diagonal symmetrizer for the family. It gives nonincrease for every stationary ergodic $\sigma$, which need not be Markov, and strict decrease for an irreducible finite-state Markov $\sigma$ unless the matrices share a positive eigenvector. The argument below transfers its conclusions to annealed growth.

## 2. Finite-path Gibbs comparison

Use environmental time $s=\omega t$ and physical-time matrix coefficient $A_{\sigma(s)}$ divided by $\omega$. For a path segment $e=(\sigma(s):0\le s\le T)$, let
$$
F_\omega(T,e)=\log\!\left(\mathbf 1^\top U_\omega(T,0;e)p\right),
\qquad
\omega\,\partial_s U_\omega(s,0;e)=A_{\sigma(s)}U_\omega(s,0;e)
$$
with a fixed positive probability vector $p$. Let $\mathsf P_T$ denote the base environmental path law on $[0,T]$, started at the stationary law $\pi$ of $G$. This law does not depend on $\omega$. The annealed exponent satisfies
$$
\lim_{T\to\infty}T^{-1}\log \mathbb E_{\mathsf P_T} e^{F_\omega(T,e)}
 =\beta_\omega:=\Lambda_{\rm ann}(\omega)/\omega .
\tag{1}
$$

We identify the tilted environmental law at each $\omega$. Write $A_k^\top=Q_k+\operatorname{diag}d_k$, where $Q_k$ is the row generator formed by taking the same off-diagonal entries and setting each row sum to zero. On the product space of environmental and spatial states $Y=(k,i)$, the reference chain has environmental generator $G$, autonomous, and spatial generator $Q_k/\omega$ when the environment is $k$. Start the joint chain with distribution $\pi\otimes p$. Let its generator be $L_\omega$, let $V_\omega(k,i)=d_{k,i}/\omega$, and set
$$
B_\omega=L_\omega+\operatorname{diag} V_\omega
 =G\otimes I+\omega^{-1}\operatorname{blockdiag}(A_1^\top,\ldots,A_K^\top).
$$
Conditional on the environmental path, the spatial Markov chain is the one with time-varying generator $Q_{\sigma(s)}/\omega$. Its Feynman–Kac expectation of $\exp(\int_0^T V_\omega(Y_s)\,ds)$ is $e^{F_\omega(T,e)}$: the transpose of its row Feynman–Kac forward equation is precisely the column system defining $U_\omega$. This also verifies (1) by the Perron–Frobenius theorem, since $B_\omega$ is irreducible Metzler and its spectral abscissa is $\beta_\omega$.

Let $r>0$ satisfy $B_\omega r=\beta_\omega r$. The matrix
$$
\widetilde L_\omega=\operatorname{diag}(r)^{-1}(B_\omega-\beta_\omega I)\operatorname{diag}(r)
$$
is an irreducible row generator. Take its stationary path law on all times, and denote its environmental marginal by $\nu_\omega$. This marginal is stationary and ergodic. On every $[0,T]$, the tilted joint path law is absolutely continuous with respect to the reference joint path law, with density
$$
\frac{\widetilde\pi(Y_0)}{(\pi\otimes p)(Y_0)}
\,\frac{r(Y_T)}{r(Y_0)}
\exp\!\left(\int_0^T V_\omega(Y_s)\,ds-\beta_\omega T\right),
\tag{2}
$$
where $\widetilde\pi$ is the joint stationary distribution of the tilted generator. Formula (2) follows by multiplying the jump-rate ratios $r(Y_{s+})/r(Y_{s-})$ and the waiting-time density ratios. The combined initial and terminal factor is bounded above and below by positive constants independently of $T$ and the path.

Integrating (2) over the spatial path conditional on the reference environmental path yields
$$
\log\frac{d\nu_{\omega,T}}{d\mathsf P_T}(e)
  =F_\omega(T,e)-\beta_\omega T+O_\omega(1).
\tag{3}
$$
The error is pathwise uniform in $T$ because of the bounds on the endpoint factor. For any stationary ergodic environmental law $\nu$, let $\Lambda^\nu_{\rm que}(\omega)$ denote its quenched physical-time exponent. The positivity of $p$ makes $\mathbf1^\top U_\omega p$ comparable to a matrix norm with fixed multiplicative constants. Hence
$$
T^{-1}\mathbb E_\nu F_\omega(T,e)\longrightarrow
\Lambda^\nu_{\rm que}(\omega)/\omega.
\tag{4}
$$
The limit of the sample logarithm is the quenched limit, and bounded convergence applies since the conditional Feynman–Kac expression gives $|F_\omega|\le T\max_{k,i}|d_{k,i}|/\omega$.

Fix $0<\omega_1<\omega_2$ and use $\nu=\nu_{\omega_2}$ for both comparisons. From (3)–(4) the marginal relative entropy rate exists and is
$$
h=\lim_{T\to\infty}T^{-1}D(\nu_T\|\mathsf P_T)
 =[\Lambda^\nu_{\rm que}(\omega_2)-\Lambda_{\rm ann}(\omega_2)]/\omega_2\ge0.
\tag{5}
$$
The finite-time Gibbs inequality at speed $\omega_1$ gives
$$
\log \mathbb E_{\mathsf P_T}e^{F_{\omega_1}}
 \ge \mathbb E_\nu F_{\omega_1}-D(\nu_T\|\mathsf P_T).
$$
Take limits with (1) and (4). The quenched monotonicity input for the same fixed stationary ergodic law $\nu$ then gives
$$
\begin{aligned}
\Lambda_{\rm ann}(\omega_1)
&\ge \Lambda^\nu_{\rm que}(\omega_1)-\omega_1 h\\
&\ge \Lambda^\nu_{\rm que}(\omega_2)-\omega_1 h
 =\Lambda_{\rm ann}(\omega_2)+(\omega_2-\omega_1)h .
\end{aligned}
\tag{6}
$$
This proves the weak inequality, and gives a quantitative strict gap whenever $h>0$.

## 3. The zero-entropy case

If $h=0$, then the process $\nu$ equals the original stationary Markov environment. To see this, fix $\Delta>0$. Let $d_\Delta$ be the relative entropy of $\nu$'s segment on $[0,\Delta]$ against the base Markov segment initialized with $\nu$'s own time-zero law. For a path of length $T=N\Delta$, the chain rule for relative entropy decomposes the entropy into an initial term and $N$ conditional segment terms. In the reference law the conditional segment distribution given the past depends only on its starting state. By convexity of relative entropy, averaging the conditional law under $\nu$ over earlier history given the starting state lowers its conditional entropy. By stationarity of $\nu$ the resulting lower bound on each term is $d_\Delta$. Thus
$$
D(\nu_{N\Delta}\|\mathsf P_{N\Delta})\ge N d_\Delta.
$$
If $h=0$, this forces $d_\Delta=0$ for every $\Delta$. Therefore under $\nu$, every segment follows the original Markov transition law given its initial state. Its initial law is stationary for $G$ and hence equals the unique $\pi$. These equalities on finite segments identify $\nu$ with the reference process.

If the $A_k$ have no common positive eigenvector, the strict Markov quenched theorem in the source's §7 applies to this $\nu$, and makes the second line of (6) strict. Otherwise let $A_k v=c_kv$ for one $v>0$. The annealed exponent is then exactly the spectral abscissa of $\omega G+\operatorname{diag}c$. Indeed, starting the spatial system at $v$ reduces it to a scalar Feynman–Kac problem, and positive starts have the same exponent by componentwise comparison. The quenched exponent under the base environment equals $\sum_k\pi_k c_k$.

If the $c_k$ are all equal, both exponents equal their common value. If they differ, let $z>0$ be a right Perron vector of $\omega G+\operatorname{diag}c$. The annealed exponent satisfies
$$
\Lambda_{\rm ann}(\omega)-\sum_k\pi_k c_k
=\omega\sum_{k\ne l}\pi_kG_{kl}
 \bigl(e^{\log z_l-\log z_k}-1\bigr)>0 .
$$
Indeed $e^u-1\ge u$ and the sum of the linear terms is $\pi^\top G(\log z)=0$. At least one edge is strict, since a constant $z$ would force $c$ constant and $G$ is irreducible. Under $h=0$, (5) with $\nu$ equal to the base law would instead make the difference zero. Therefore the common-eigenvector case with unequal $c_k$ has $h>0$, which makes (6) strict as well.

Finally, for $A_k=Q+D_k$, sharing a positive $v$ at one common eigenvalue forces $(D_k-D_1)v=0$, hence all $D_k=D_1$. This proves the exact criterion. $\square$

## 4. Scope

The argument includes environmental chains whose transition graph is a directed cycle. It also permits the frozen off-diagonal parts to vary if all share one symmetrizer and remain irreducible. Convexity in the switching speed, available by a symmetric Rayleigh quotient when the environmental generator is reversible, is not needed for the monotonicity conclusion.

## Source

Anonymous, *Reversibility and frequency reduction in periodic and random positive systems*, Evidence Press / Zenodo, version 0.1.0-candidate (3 November 2026), §7 quenched results including “Varying interaction graphs,” the annealed proposition, and §10 open problem 4. [Deposit](https://zenodo.org/records/23911074). [Frozen §7](https://github.com/ipitchford/reversibility-frequency-reduction/blob/v0.1.0-candidate/sec7_random.tex). [Frozen §10](https://github.com/ipitchford/reversibility-frequency-reduction/blob/v0.1.0-candidate/sec10_discussion.tex).
