# Poisson transfer with a shared non-null threshold in weighted conformal BH

## Abstract

Two transfers in Lim's one-heavy-cell analysis were left open. At fixed scaled weight $\kappa=B/n$, we prove that finite-sample false discovery rates converge at rate $O(n^{-1/2})$ to a Poisson mixture. When the shared non-null p-value hits a BH threshold on the Poisson lattice, the correct mixture averages the two conventions for counting the atom, with equal weights. We give an exact counterexample to the lower-tail-inclusive convention at equality. In the other transfer, we prove the $O(B^{-1})$ convergence of the normalized fixed-distribution Gaussian coefficient to the coefficient of the small-$\kappa$ Poisson model, including Lim's Example 13.

## 1. One-heavy-cell model and notation

Fix $m\ge2$, $q\in(0,1)$, and BH thresholds $t_k=qk/m$. Let $0<g<v<1-\zeta<1$. A light unit has score $u$ uniform on $[0,1]$ and weight one. It is null with tested score $u$ if $u\le1-\zeta$, and otherwise non-null with a shared tested score $v$. A heavy unit has weight $B$ and null score $g$. Calibration and test samples are independent. The test law $Q$ is the calibration law $P$ tilted by the weight, and units are i.i.d. within each sample. The randomized p-value is

$$p=\frac{S_{<}(z)+U(S_{=}(z)+w)}{S+w},$$

where $z$ is the tested score, $S_{<}(z),S_{=}(z),S$ are the calibration weight sums below, equal to, or irrespective of $z$, and $U$ is independently uniform for each test.

For a conditional distribution write $A_k=\Pr(\mathrm{null},p\le t_k)$ and $G_k=\Pr(p\le t_k)$. Let $\Pi_k(G)$ be the probability of $k$ BH rejections on a forced zero and $m-1$ i.i.d. p-values with grid CDF $G$. It is a polynomial in the grid values, since the multinomial band probabilities are differences of adjacent values. As in Lim, Lemma 2, the conditional expected false discovery proportion is

$$H(A,G)=m\sum_{k=1}^{m}\frac{A_k}{k}\Pi_k(G). \tag{1}$$

For each designated test unit, forcing its value to zero gives a count independent of that unit. The actual unit is rejected iff its p-value is at most the threshold at this count, and the actual count then agrees with the forced-zero count. Summing these expected contributions gives (1). The polynomial $H$ is uniformly Lipschitz on the cube of grid masses, with a finite constant depending on $m$.

## 2. Fixed-$\kappa$ Poisson transfer and lattice ties

Fix $\kappa,\lambda>0$ and let $\omega=\kappa\lambda$. For sufficiently large $n$ take heavy calibration probability $\lambda/n$ and weight $B=\kappa n$. Draw $N\sim\operatorname{Pois}(\lambda)$ and condition on $N=r$, with $K=\kappa r$. In the limit the test light and heavy masses are respectively $1/(1+\omega)$ and $\omega/(1+\omega)$. The tested p-value of a light null is

$$f_K(u)=\frac{u+K\mathbf 1\{g<u\}}{1+K}.$$

The p-value of a heavy null is uniform on

$$\left[\frac{g}{1+K+\kappa},\,\frac{g+K+\kappa}{1+K+\kappa}\right]. \tag{2}$$

The $\kappa$ in (2) is the heavy test unit's own weight on the $n$-normalized scale. A light non-null has limiting atom $f_K(v)$. Let $A^{(r)}$ be the grid null mass in this conditional model. For the two conventions at the p-value atom define

$$G^{(r,-)}_k=A^{(r)}_k+\frac{\zeta}{1+\omega}\mathbf 1\{f_K(v)\le t_k\},\qquad
G^{(r,+)}_k=A^{(r)}_k+\frac{\zeta}{1+\omega}\mathbf 1\{f_K(v)<t_k\}.$$

**Theorem 1.** For all fixed parameters above, including lattice ties,

$$
\mathrm{FDR}_n
=\mathbb E\left[\frac{H(A^{(N)},G^{(N,-)})+H(A^{(N)},G^{(N,+)})}{2}\right]
+O(n^{-1/2}). \tag{3}
$$

The constant may depend on the fixed model and grid. Away from a lattice tie the two terms coincide.

**Proof.** Let $N_n$ be the heavy calibration count. Given $N_n=r$, the $L=n-r$ light scores are i.i.d. uniform. Write $\widehat F_L$ for their empirical CDF and $\Delta_L=\sup_u|\widehat F_L(u)-u|$. The binomial law of $N_n$ has total variation distance at most $\lambda^2/n$ from $\operatorname{Pois}(\lambda)$ by Le Cam's bound. We first estimate the conditional FDR under the finite-$n$ count; then the boundedness of FDR permits the Poisson replacement.

For $r\le n/2$, divide every weight sum by $n$. For a light unit with fixed tested score $z$, the finite-$n$ ratio is
$$\frac{(L/n)\widehat F_L(z)+K\mathbf 1\{g<z\}+U/n}{L/n+K+1/n}.$$
This is valid almost surely for a random light null or for $z=v$. For a heavy unit it is
$$\frac{(L/n)\widehat F_L(g)+U(K+\kappa)}{L/n+K+\kappa}.$$
Replacing $L/n$ by one, the empirical CDF by the identity, and the light unit's own $1/n$ by zero changes either score by at most
$\epsilon_r=2\Delta_L+4(r+1)/n$, uniformly in $U$ and in the light score outside the null set of ties. Indeed the finite denominator is at least $1/2$, the numerator differs by at most $\Delta_L+(r+1)/n$, and the denominator differs by at most $(r+1)/n$. The limiting ratio lies in $[0,1]$. The distribution of a light null at fixed $K$ has subprobability density at most $1+K$ in the grid variable, since the two affine pieces of $f_K$ have disjoint interiors. The heavy null has density at most $(1+\kappa)/\kappa$ by (2). The actual test mixture weights differ from their limiting values by $O(n^{-1})$. Consequently the grid null masses differ by at most $C(1+r)\epsilon_r+C/n$ for a fixed constant $C$.

By the Dvoretzky–Kiefer–Wolfowitz inequality, $\mathbb E[\Delta_L\mid N_n=r]=O(n^{-1/2})$ uniformly on $r\le n/2$. The first and second moments of $N_n$ are uniformly bounded, and $\Pr(N_n>n/2)=O(n^{-1})$ by Markov, so the mean grid null mass error is $O(n^{-1/2})$.

For the non-null units and all non-resonant pairs $(r,k)$ with $f_K(v)\ne t_k$, the gaps $|f_K(v)-t_k|$ have a strictly positive infimum. This follows from $f_{\kappa r}(v)\to1$ and $q<1$, leaving only finitely many smaller $r$ to check. A bin may differ from its limiting indicator only if $\epsilon_r$ is at least this infimum. Markov's inequality and the preceding mean error bound therefore give $O(n^{-1/2})$ total error at non-resonant pairs.

For a resonant pair $f_{\kappa r}(v)=t_k$, fix this $r,k$. There is at most one such $r$ per threshold and one threshold per $r$. Let $C_L(v)$ count the $L$ light calibration scores below $v$. The test p-value of a non-null unit is at most $t_k$ exactly when

$$C_L(v)-Lv\le r(v-t_k)+t_k-U.$$

The identity follows by cancellation of the coefficient of $n$ at resonance. Given $N_n=r$, $C_L(v)$ has distribution $\operatorname{Bin}(L,v)$. The right-hand side ranges over a fixed interval of length one. Berry–Esseen gives probability $1/2+O(n^{-1/2})$ for the binomial deviation to fall below the lower endpoint and probability $1/2+O(n^{-1/2})$ for it to lie above the upper endpoint. The intermediate event has probability $O(n^{-1/2})$. On the below event all non-null units count at $t_k$; on the above event none does. This decision is common to the units because they share the calibration count. The expected errors from approximating the null masses and the non-resonant coordinates remain $O(n^{-1/2})$ even after restricting to either event. Applying the Lipschitz bound on (1) gives the half-sum in (3) at this $r$, up to $O(n^{-1/2})$. There are finitely many such $r$. Taking the mean over $N_n$, then using the Poisson total variation bound, proves (3). $\square$

**Exact example.** Take $m=2$, $q=3/10$, $\kappa=1/5$, $\lambda=1/2$, $g=1/20$, $v=4/25$, $\zeta=2/5$. Since $f_0(v)>t_1$ and $f_{\kappa r}(v)$ is strictly increasing in $r$, the only resonance is $r=1,k=2$. At $r=1$, the lower-threshold light nulls have $u\le g$ and the higher-threshold light nulls have $u\le4/25$. Both thresholds lie inside (2). The two grid null masses are

$$A_1=\frac{9}{110},\qquad A_2=\frac{101}{440}.$$

For $m=2$ the polynomial is $H(A,G)=2A_1(1-G_2)+A_2G_2$. The lower-tail-inclusive value exceeds the exclusive one by
$(A_2-2A_1)\zeta/(1+\omega)=29/1210$. As $\Pr(N=1)=e^{-1/2}/2$, the limit in (3) minus the inclusive Poisson FDR is $-29e^{-1/2}/4840$.

The correction can have the opposite sign. Take $m=2$, $q=1/2$, $\kappa=1/16$, $\lambda=2$, $g=1/16$, $v=1/2$, $\zeta=1/4$. Only $r=0,k=2$ is resonant. The light p-value equals its score, and the heavy test window is $[1/17,2/17]$, below both thresholds. Hence the grid null masses are $1/3$ and $5/9$. The inclusive value minus the exclusive value equals $-2/81$, so the finite-$n$ limit exceeds the inclusive Poisson FDR by $e^{-2}/81$. This second witness was found independently during review.

**Corollary (small-$\kappa$ coefficient).** In Lim's Theorem 9 setting, with strict saturation and genericity at $K=\omega$, the correction changes the Poisson FDR by $O(\kappa)$ as $\kappa\downarrow0$ when the offset $z_0$ is bounded. At zero offset the change is $O(\kappa^{3/2})$.

Indeed, the shared threshold is tuned so that its crossing of $t_*$ occurs at $K_*=\omega+z_0\sqrt{\kappa\omega}$. All other threshold crossings, when they exist, stay a fixed positive distance from $\omega$. The function mapping $K$ to the shared p-value is strictly increasing near $\omega$, and its limiting value at $\omega$ equals $t_*$. Since $K=\kappa N$ with $N\sim\operatorname{Pois}(\omega/\kappa)$, a Poisson Chernoff bound makes the probability of the other resonances exponentially small in $1/\kappa$. At $K_*$ the two conditional FDRs differ by at most a constant times $\max_k|A_k-t_k|$. To see this, use (1) and subtract $t_k$ inside the sum, since $\sum_k\Pi_k(G^\pm)=1$ and $m t_k/k=q$. Strict saturation and the genericity margins give $A_k=t_k+O(|K_*-\omega|+\kappa)$ from the piecewise rational null-mass formulas, including the own-weight correction in (2). A single Poisson lattice value has mass $O(\sqrt{\kappa})$ by Stirling's formula applied at the mode. The product is $O(\kappa)$, or $O(\kappa^{3/2})$ if $z_0=0$. In particular the corrected finite-sample limit inherits the $\sqrt{\kappa}$ term under these sequential limits.

## 3. Large $B$ transfer of the Gaussian coefficient

Now use a different limit. For each fixed $B$, choose heavy calibration probability $\pi_H=\omega/B$ with fixed $\omega>0$. First take $n\to\infty$ as in Lim's Theorem 23. Use Lim's exact population tuning condition: for a fixed crossing index $k_0$, $t_*=t_{k_0}$, set

$$s=1-\omega/B,\quad W=s+\omega,\quad \gamma=s/W,\quad
v_B=(t_*W-\omega)/s.$$

Assume the limiting $v_\infty=t_*(1+\omega)-\omega$ satisfies $0<g<v_\infty<1-\zeta<1$. Assume also $f_\omega(1-\zeta)>q$ and that no grid point equals $g/(1+\omega)$ or $(g+\omega)/(1+\omega)$. These strict conditions ensure (F1)–(F4) of Lim for all sufficiently large $B$.

For the $\kappa\downarrow0$ Poisson expansion at zero switch offset, let $D_k=A_k'(\omega)$ denote the derivative of the deterministic conditional null mass with respect to the calibrated heavy weight total $K$. At $K=\omega$ the heavy interval in that derivative is the interval with no $\kappa$ term, as in Lim's first-order coefficient. Direct differentiation gives

$$
D_k=
\begin{cases}
t_k/(1+\omega),&t_k<g/(1+\omega),\\
(g-t_k)/[\omega(1+\omega)],&g/(1+\omega)<t_k<(g+\omega)/(1+\omega),\\
(t_k-1)/(1+\omega),&t_k>(g+\omega)/(1+\omega).
\end{cases} \tag{4}
$$

For example, inside the window the null mass is $g/(1+\omega)+[\omega/(1+\omega)] [t_k(1+K)-g]/K$, and above it the corresponding expression is $[t_k(1+K)-K+\omega]/(1+\omega)$. Strict saturation ensures cutoff light scores remain in the null part locally. The orientation of the switch is below/included versus above/excluded, because $f_K(v_\infty)$ increases with $K$.

**Theorem 2.** Let $c_0(B)$ be Lim's Theorem 23 coefficient and let
$h_\pm=m\sum_{k=1}^{m}D_k\Pi_k(G^\pm)/k$, where $G^-$ counts the decoy at $t_*$ and $G^+$ counts it only at later thresholds, at $K=\omega$ in the small-$\kappa$ coefficient model. Then

$$
\frac{c_0(B)}{q\sqrt{B}}
=\frac{\sqrt{\omega}(h_+-h_-)}{q\sqrt{2\pi}}+O(B^{-1}). \tag{5}
$$

This is the normalized Poisson coefficient at zero offset in Lim's Theorem 9.

**Proof.** Let $e,b,\xi_k,\eta_D$ be the Gaussian variables in Lim, Appendix A.3, with $\operatorname{Var}(e)=\pi_H(1-\pi_H)$ and $b$ an independent Brownian bridge divided by $\sqrt{s}$. Put $E_B=\sqrt B\,e$, so $\operatorname{Var}(E_B)=\omega s$. For the below-window and above-window regions put $I_k=0,1$ respectively and $u_k=(t_kW-I_k\omega)/s$. Use $y_k=u_k$ in those regions and $y_k=g$ in the heavy-window region. Direct substitution into Lim's Gaussian formulas gives

$$
\frac{\eta_D}{\sqrt B}=a_D E_B+\frac{\gamma}{\sqrt B}b(v_B),\qquad
\frac{\xi_k}{\sqrt B}=a_k E_B-\frac{\gamma}{\sqrt B}b(y_k),
$$

with
$$
a_D=\frac{1-t_*}{sW},\qquad
a_k=\begin{cases}
(t_k-I_k)/(sW),&\text{light regions},\\
(g-t_k)/(\omega W),&\text{heavy region}.
\end{cases} \tag{6}
$$

For a light region, the numerator before simplification is
$t_k(1-1/B)+u_k/B-I_k=(t_k-I_k)/s$.
The heavy numerator is $t_k(1-1/B)+g/B-N_k/\omega$, where $N_k=t_kW-sg$, and equals $(g-t_k)/\omega$. The same light identity at $k_0$, with a reversed sign, simplifies the coefficient of $\eta_D$. Thus $a_k=D_k+O(B^{-1})$ and $a_D\to d_D=(1-t_*)/(1+\omega)>0$, also at rate $O(B^{-1})$.

The bridge covariance is bounded uniformly in large $B$, since $s\to1$ and all arguments lie in $[0,1]$. By independence,
$$
\begin{aligned}
\operatorname{Cov}(\xi_k/\sqrt B,\eta_D/\sqrt B)&=a_k a_D\omega s+O(B^{-1}),\\
\operatorname{Var}(\eta_D/\sqrt B)&=a_D^2\omega s+O(B^{-1}).
\end{aligned}
$$
The limiting variance is $\omega d_D^2>0$. Therefore the ratio of this covariance to the standard deviation of $\eta_D/\sqrt B$ is $D_k\sqrt\omega+O(B^{-1})$.

The two population grid CDFs in Lim's Theorem 23 have null mass $t_k$ and add the decoy mass $\gamma\zeta$ at and beyond the crossing, or strictly beyond it. Their differences from $G^\pm$ are $O(B^{-1})$ because $\gamma=1/(1+\omega)+O(B^{-1})$. The corresponding jump $\Delta r_k(B)$ thus equals $\Pi_k(G^-)-\Pi_k(G^+)+O(B^{-1})$. Substituting into Lim's formula
$$c_0(B)=-\frac m{\sqrt{2\pi}}\sum_{k=1}^{m}\frac{\Delta r_k(B)}{k}
\frac{\operatorname{Cov}(\xi_k,\eta_D)}{\operatorname{sd}(\eta_D)}$$
gives exactly (5). $\square$

For Lim's Example 13, $q=0.1$, $m=k_0=8$, $g=0.018418$, $\omega=0.086271$, $\zeta=0.91847$. The strict hypotheses above can be verified by rational arithmetic. Formula (5) identifies the limit with the exact coefficient formula, whose numerical value is about $0.6707$. The two results concern different limits. Formula (3) keeps $\kappa$ fixed when transferring from finite samples. Formula (5) takes $n\to\infty$ at fixed $B$ and then compares coefficients as $B\to\infty$.

## References

- Ryan Lim. *Almost Controlled: The FDR of Benjamini–Hochberg on Weighted Conformal p-Values*. arXiv:2611.21509v1, 2026. <https://arxiv.org/html/2611.21509v1>.
- Lucien Le Cam. *An approximation theorem for the Poisson binomial distribution*. Pacific Journal of Mathematics 10(4), 1181–1197, 1960. <https://doi.org/10.2140/pjm.1960.10.1181>.
- Pascal Massart. *The tight constant in the Dvoretzky–Kiefer–Wolfowitz inequality*. Annals of Probability 18(3), 1269–1283, 1990. <https://doi.org/10.1214/aop/1176990746>.
