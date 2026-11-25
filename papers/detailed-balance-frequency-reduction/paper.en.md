# The detailed-balance boundary for annealed frequency reduction

*Cyclic resolvent products, exact slow coefficients, and Erlang clocks*

## 1. Results

Let $Q$ be a finite irreducible migration generator, and let a finite irreducible Markov environment select real diagonal potentials $D_j$. Write $A_j=Q+D_j$. For any positive start, the annealed exponent is the long-run logarithmic growth rate of $E[\mathbf1^\top x(t)]$ for $x'=A_{\sigma(\omega t)}x$.

**Classification.** The annealed exponent is nonincreasing in speed $\omega>0$ for every finite irreducible Markov diagonal environment if and only if $Q$ satisfies detailed balance. For every irreversible $Q$, there are arbitrarily small diagonal potentials and a directed cyclic Markov environment whose annealed exponent has an interior global maximum strictly above both endpoint limits.

The reversible direction uses the path-entropy transfer in *Annealed frequency reduction under irreversible environmental switching* (accompanying case). We prove the converse with a cyclic resolvent formula. For all frozen matrices normalized to Perron root zero, it gives an exact slow coefficient with the sign of the logarithmic periodic Perron overlap. The same formula also transfers a fixed-speed result for general finite periodic protocols to finite Markov environments through an Erlang clock, with order $N^{-1}$ error.

We use a column convention for the $A_j$. A row migration generator is equally admissible: transposing it is the usual forward migration convention and preserves detailed balance. The source's nonreversible periodic witness can be applied in the row convention or transferred to the column convention by transposition and reversal of the periodic protocol.

## 2. Cycle resolvents

Let $A_1,\ldots,A_K$ be irreducible Metzler matrices, $K\ge2$. The environment visits the states in order cyclically, with outgoing rates $r_j>0$ in physical time. Conditional first moments have a finite irreducible Metzler block generator $\mathcal B$, whose eigenvector equations are
$$
((\lambda+r_j)I-A_j)x_j=r_{j-1}x_{j-1},
\quad j\pmod K.
$$
Its spectral abscissa is the annealed exponent. For real $\lambda$ with $\lambda+r_j>s(A_j)$ for all $j$, set
$$
 R_j(\lambda)=r_j((\lambda+r_j)I-A_j)^{-1},
 \qquad \mathcal R(\lambda)=R_K(\lambda)\cdots R_1(\lambda).
\tag{1}
$$
All resolvents in (1) are strictly positive by the integral of the positive semigroup. The transformation $y_j=r_jx_j$ converts the block equations into $y_j=R_j(\lambda)y_{j-1}$. Thus if $\rho(\mathcal R(\lambda))=1$, starting with its positive Perron vector and propagating around the cycle yields a strictly positive eigenvector of $\mathcal B$. It follows that $\lambda=s(\mathcal B)$. Conversely a positive Perron vector of $\mathcal B$ in the stated domain gives $\rho(\mathcal R(\lambda))=1$. Each factor is entrywise strictly decreasing in $\lambda$, again by its positive integral representation, so the product's Perron radius is continuous and strictly decreasing there.

## 3. Exact slow coefficient and the converse

Fix fractions $\alpha_j>0$, $\sum_j\alpha_j=1$. First normalize $s(A_j)=0$ for each $j$. Let $A_j v_j=0$, $\ell_j^\top A_j=0$, $v_j,\ell_j>0$ and $\ell_j^\top v_j=1$. Define $P_j=v_j\ell_j^\top$ and
$$
\mathcal K=\rho(P_K\cdots P_1)
          =(\ell_1^\top v_K)\prod_{j=1}^{K-1}(\ell_{j+1}^\top v_j)>0 .
\tag{2}
$$
Take $r_j=\omega/\alpha_j$. For $z>-\min_j1/\alpha_j$ in a compact subinterval, isolate the simple zero eigenspace in the resolvent:
$$
 R_j(\omega z)=\frac{P_j}{1+\alpha_j z}+O(\omega).
\tag{3}
$$
On the complementary invariant subspace the inverse stays bounded as $\omega\downarrow0$, which gives the uniform error. Consequently
$$
\rho(\mathcal R(\omega z))
 =\frac{\mathcal K}{\prod_j(1+\alpha_j z)}+O(\omega)
\tag{4}
$$
locally uniformly in $z$. For example, use in the Collatz–Wielandt inequalities the positive right eigenvector of $P_K\cdots P_1$ independently of $z$ on the compact subinterval. The scalar function in (4) decreases from infinity to zero on its domain. Denote its unique crossing of one by $z_*$, given by
$$
\prod_j(1+\alpha_j z_*)=\mathcal K.
\tag{5}
$$
Bracket $z_*$ by two fixed nearby values in the domain. For sufficiently small $\omega$, continuity and (4) give a root in the bracket, which is the scaled annealed exponent by (1). The derivative of the limiting scalar function is strictly negative there, so (4) also gives $z(\omega)-z_*=O(\omega)$. We have therefore proved
$$
 \Lambda_{\rm ann}(\omega)=\omega z_*+O(\omega^2),\qquad
 \operatorname{sign} z_*=\operatorname{sign}\log\mathcal K.
\tag{6}
$$

For the prescribed potential family, the fast limit is $s(\bar A)$, with $\bar A=\sum_j\alpha_j A_j$. Here is a short proof valid for any finite irreducible environmental generator of fixed stationary law. The column sums of the full block generator are those of the frozen matrices, so the annealed exponent stays bounded by Collatz–Wielandt for the transpose with the all-ones vector. Normalize the positive right block eigenvector to total mass one. Along any subsequence of $\omega\to\infty$, choose a convergent subsubsequence for the eigenvectors and eigenvalues. Divide the eigenvalue equation by $\omega$. The limiting eigenvector belongs to the kernel of $G^\top\otimes I$, so its blocks are the stationary environmental masses times a common nonzero nonnegative vector. Sum the finite-speed equations over the blocks and pass to the limit. The eigenvalue is then $s(\bar A)$, since $\bar A$ is irreducible and the common vector is nonnegative and nonzero. For rates $1/\alpha_j$ the stationary masses are exactly $\alpha_j$.

Now apply Evidence Press, *Reversibility and frequency reduction in periodic and random positive systems*, §5 subsection “Finite periodic switching.” For each irreversible $Q$ it constructs a cyclic finite family $\widehat A_j=Q+\widehat D_j$ with $\mathcal K>1$ at all sufficiently small nonzero amplitudes. Subtract $s(\widehat A_j)I$ from each frozen matrix to obtain $A_j$. The Perron directions and $\mathcal K$ are unchanged. The shifted diagonals still tend uniformly to zero as the source's amplitude tends to zero.

For completeness, $\mathcal K>1$ implies the normalized $\bar A$ has $s(\bar A)<0$ without a perturbative calculation. Let $u_i=\prod_j v_{j,i}^{\alpha_j}$. For every off-diagonal entry $Q_{il}>0$, the geometric mean $u_l/u_i$ is at most $\sum_j\alpha_jv_{j,l}/v_{j,i}$. Therefore $(\bar A u)_i/u_i\le\sum_j\alpha_j(A_jv_j)_i/v_{j,i}=0$. Equality in every row would force the ratios $v_{j,l}/v_{j,i}$ to agree across matrices on every directed edge. Irreducibility would make all $v_j$ proportional, in which case $\mathcal K=1$. Thus some row is strict, and the positive left Perron vector proves $s(\bar A)<0$.

The annealed rate is continuous for $\omega>0$, as a finite-dimensional spectral abscissa. Equation (6) makes it positive at sufficiently small positive speeds, while its slow limit is zero and its fast limit is negative. Thus it has an interior global maximum strictly above both limits. This proves the irreversible direction and the classification.

## 4. Erlang approximation of general finite periodic protocols

Let $A_j$ now be arbitrary irreducible Metzler matrices, with no normalization of their eigenvalues. Consider the deterministic protocol with one environmental-time period and consecutive durations $\alpha_j$. Its Floquet exponent at speed $\omega$ is
$$
 \lambda_{\rm per}(\omega)=\omega\log\rho(M(\omega)),
 \qquad M(\omega)=e^{\alpha_K A_K/\omega}\cdots e^{\alpha_1 A_1/\omega}.
$$
Replace each season by $N$ consecutive exponential stages of equal rate $\omega N/\alpha_j$ in physical time. This is a finite directed Markov cycle whose total holding time in season $j$ is Erlang, with mean $\alpha_j/\omega$. Its lifted annealed Perron exponent will be denoted $\lambda_N(\omega)$. Applying (1) to the stages gives the equation
$$
 \rho\left(\prod_{j=K}^{1}
 \left[I+\frac{\alpha_j}{\omega N}(\lambda I-A_j)\right]^{-N}\right)=1.
\tag{7}
$$
As $N\to\infty$ the matrix inside the radius equals $e^{-\lambda/\omega}M(\omega)+O(N^{-1})$, uniformly for $\lambda$ bounded and $\omega$ in a compact subset of $(0,\infty)$. This follows by the norm-convergent logarithm expansion of each factor and multiplication of finitely many factors. The limiting product is strictly positive. Its positive right Perron vector can be chosen continuously in $\omega$ and with all components bounded away from zero on such a compact set. Applying the Collatz–Wielandt ratios with this vector gives the same uniform error for the Perron radius.

For each $\omega$ the limiting radius is $e^{(\lambda_{\rm per}(\omega)-\lambda)/\omega}$. Bracket $\lambda_{\rm per}(\omega)$ by the addition and subtraction of a fixed positive number, uniformly on the compact speed interval. At large $N$, the bracket applies to (7), and all resolvents are in their positive domain. The unique root is $\lambda_N(\omega)$ by (1). The limiting radius has a slope bounded away from zero in the bracket, proving
$$
 \sup_{\omega\in I}|\lambda_N(\omega)-\lambda_{\rm per}(\omega)|=O_I(N^{-1})
$$
for each compact $I\subset(0,\infty)$. Hence any finite periodic strict comparison between two fixed speeds transfers to a finite Markov clock.

## Sources

- Anonymous, *Reversibility and frequency reduction in periodic and random positive systems*, Evidence Press / Zenodo (2026), §5 finite periodic switching and §7 annealed proposition. [Deposit](https://zenodo.org/records/23911074). [Frozen §5](https://github.com/ipitchford/reversibility-frequency-reduction/blob/v0.1.0-candidate/sec5_witness.tex).
- *Annealed frequency reduction under irreversible environmental switching*. Accompanying [companion manuscript](../annealed-frequency-reduction/paper.en.md), reversible sufficiency.
- M. Ogura and C. F. Martin, *Stability analysis of linear systems subject to regenerative switchings*, Systems & Control Letters **75** (2015), 94–100. [Author preprint](https://arxiv.org/abs/1403.6764). Related renewal-cycle stability criterion.
- P. J. Hurtado and A. S. Kirosingh, *Generalizations of the ‘Linear Chain Trick’: incorporating more flexible dwell time distributions into mean field ODE models*, Journal of Mathematical Biology **79** (2019), 1831–1883. Standard phase-type clock construction.
