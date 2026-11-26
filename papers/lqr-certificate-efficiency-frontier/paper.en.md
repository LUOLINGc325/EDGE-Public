# The Exact Statistical Price of a Robust-Regret Certificate in LQR

## 鲁棒 LQR 的最坏遗憾证书与统计效率前沿

Research manuscript, 25 November 2026. Formal verification has not been completed. This manuscript claims neither journal acceptance nor external peer review.

## Abstract

We study the statistical price of requiring a data-driven linear quadratic regulator to remain close to the optimum of a modelwise minimax-regret problem. Both scalar dynamics coefficients are unknown and are estimated from independent finite Gaussian trajectories. At an empirical-Fisher uncertainty radius of order $N^{-1/4}$, the exact robust controller generally has a nonzero bias at the statistical $N^{-1/2}$ scale. We characterize the entire set of controllers whose worst-model regret is within $\lambda\rho^3$ of the robust optimum. Two opposing active-model slopes force every such controller into a sharp interval of width $O(\rho^2)$. This geometric constraint yields an exact local asymptotic minimax risk over all measurable, possibly randomized procedures. A direct posterior argument proves the lower bound in the original trajectory experiment, and an exactly feasible continuation from the robust controller toward certainty equivalence attains it. An explicit known-reference safeguard and trajectory-level moment bounds justify expected infinite-horizon cost. We also give the scalar second-order coefficient, the three confidence-radius regimes, a fully identifiable Fisher-realizable nonzero-bias example, and a supporting quadratic displacement theorem for matrix LQR that requires no sensitivity spectral gap. The new result is the certificate-constrained statistical frontier; standard symmetry arguments and the fixed-confidence efficiency question are credited separately.

## 中文概要

本研究回答一个可定量检验的问题：如果要求数据驱动控制器继续保持接近最优的“最坏模型相对遗憾”保证，统计性能究竟必须付出多少代价？在状态和输入均为标量、两个动力学参数都未知的 LQR 中，我们证明了临界置信半径下的精确风险前沿。下界覆盖所有可测及随机化程序；达到方法对每份被接受的数据都满足原始证书预算。安全性依赖明确给定的局部先验和已知回退控制器，均值结论包含尾部与一致可积性证明。核心贡献不是把确定性等价控制重新命名，而是确定恢复其有效风险至少需要让出多少最坏遗憾最优性。

## Positioning, attribution, and the precise new contribution

Fujinami, Lee, Matni, and Pappas [R1] study independent-experiment LQR synthesis and pose a question about a potential efficiency loss of robust control. Their robust objective subtracts the optimal cost separately for every candidate model. We preserve that objective. Their proved finite-sample upper bound, a worst-model certificate, and the sampling risk of the synthesized controller are different quantities. The present question concerns a critical shrinking-radius regime and a constraint on the certificate itself. The authors of [R1] did not state our particular $\lambda\rho^3$-budget decision problem; that precise problem is formulated here from their broader efficiency question.

The fixed-confidence first-order comparison and the worst-total-cost analysis are distinct problems. This manuscript studies the certificate-constrained frontier and presents its proof in full. The matrix displacement result in Appendix A also supports the fixed-confidence comparison.

The closest general regret-sensitivity result is Fiechtner and Blanchet [R3, Section 3.2, Theorem 3]: it identifies second-order regret values, smaller-than-first-order optimizer movement, and opposing active directions for Wasserstein regret optimization. Nietert and Kuhn [R4, Theorem 2.2 and Appendix E] analyze local minimax-regret geometry for Wasserstein-robust regression, including paired perturbations. We credit these principles. Our necessary additional step is a quantitative, complete sublevel-set characterization at certificate error $\rho^3$, followed by a sharp statistical lower bound for every admissible procedure in the original control experiment.

Lam [R5] establishes asymptotic comparisons between empirical optimization and smooth data-driven alternatives, including bias effects. Duchi and Namkoong [R8] analyze the statistical effect of robust variance regularization. These results rule out treating smooth robustification bias itself as new. Yang and Yuan [R6] give exact local decision-risk results for linear stochastic optimization under Gaussian and KL-local experiments; their decision constraint is not the data-dependent robust-objective certificate studied here. The diffuse-prior Gaussian calculation used below is standard decision-theoretic reasoning. The original-experiment constraint and its sharp nonlinear-control reduction are essential to our claim.

Fiechtner and Blanchet [R7] also study finite-horizon LQR under ambiguity in a common disturbance law, with known dynamics and affine disturbance feedback. This differs from estimating both dynamics coefficients and then choosing one stationary gain. Dörfler, Tesi, and De Persis [R2] provide a published control-theory comparison: their direct/indirect certainty-equivalence formulations, regularization, and noisy-data stability results establish important background, while our scalar statistical frontier has different quantifiers. Our contribution does not subsume their matrix synthesis results. Gotoh, Kim, and Lim [R9, Proposition 4 and Theorem 3] already quantify an out-of-sample robust mean-variance frontier along a smooth divergence-penalized family. We credit that calibration viewpoint; it does not characterize every procedure obeying the present data-dependent modelwise-regret certificate, nor the critical LQR local minimax constant.

The main theorem gives an exact risk constant, not only a rate. The key difficulty is that a certificate permits arbitrary data-dependent corrections: analyzing one smooth corrected estimator cannot establish the required lower bound. Sections 3-4 characterize all feasible outputs, Section 6 supplies a program-uniform posterior lower bound, and Section 7 proves an exactly feasible attaining sequence with controlled expected cost. Appendix A records the supporting matrix result without claiming a matrix version of the scalar second-order coefficient or frontier.


## 1. Model, notation, and statement

The system is

```math
X_{t+1}=aX_t+bU_t+W_t,\qquad W_t\stackrel{\mathrm{iid}}{\sim}N(0,W),
```

with unknown **both** entries $\theta=(a,b)$, known $Q,R,W>0$, feedback $U_t=kX_t$, and infinite-horizon stationary cost

```math
C(k,\theta)=\frac{W(Q+Rk^2)}{1-(a+bk)^2}
```

when $|a+bk|<1$, extended by $+\infty$ otherwise. Write $k_*(\theta)$ for the unique optimal stabilizing feedback, $C_*(\theta)=C(k_*(\theta),\theta)$, and $\ell=C-C_*$.

The procedure is given a known stabilizable reference $\theta_{\mathrm{ref}}$, a known local prior region, and the common-stability safeguard specified in Section 2. The true parameter and its Fisher matrix are not supplied to the procedure. Fix any analysis point $\theta_0$ in the interior of that prior region, with $k_0=k_*(\theta_0)$, nonzero row derivative $D=\nabla_\theta k_*(\theta_0)$, and

```math
H=C_{kk}(k_0,\theta_0)>0.
```

Observe $N$ independent length-$T$ trajectories. Each has the same known deterministic, parameter-independent initial state and independent zero-mean Gaussian open-loop inputs of positive known variance. The noises and inputs are mutually independent. The fixed finite horizon and input design give a nonsingular per-trajectory Fisher matrix $I_0$ at the analysis point. Define

```math
V=I_0^{-1},\qquad v=DVD^T>0.
```

Let $\widehat\theta_N$ be least squares and $\widehat I_N$ its empirical Fisher matrix. Put

```math
G_N=\widehat\theta_N+\rho_N\widehat I_N^{-1/2}B_2,
\qquad \rho_N=sN^{-1/4},\quad s>0,
```

```math
F_N(k)=\sup_{\theta\in G_N}\ell(k,\theta),\qquad
k_{R,N}=\arg\min_kF_N(k).
```

The inverse, ellipsoid and robust-optimizer expressions above are used on the accepted-data event defined in Section 2. On rejected data they need not be defined; the implemented rule uses its known safe fallback.

Define a coefficient at any nearby center $\eta$, positive-definite ellipsoidal covariance $\Omega$, and corresponding nominal gain by

```math
D_\eta=\nabla k_*(\eta),\quad H_\eta=C_{kk}(k_*(\eta),\eta),
\quad w=\Omega D_\eta^T,\quad q=D_\eta\Omega D_\eta^T.
```

All derivatives in the next formula are partial derivatives of the **unsubstituted cost** $C(k,\theta)$, evaluated at $(k_*(\eta),\eta)$:

```math
\boxed{
b_2(\eta,\Omega)=
-\frac{C_{k\theta\theta}[w,w]}{2H_\eta q}
-\frac{C_{kk\theta}[w]}{2H_\eta}
-\frac{C_{kkk}q}{6H_\eta}.
}
\tag{1}
```

Let $b_2=b_2(\theta_0,V)$. There is an observable regular safety event $E_N$, defined precisely below, whose failure probability is exponentially small uniformly on every compact set of local parameters $\theta_{N,h}=\theta_0+h/\sqrt N$. For $\lambda\ge0$, let $\mathcal C_N(\lambda)$ contain every measurable, possibly independently randomized feedback rule satisfying, **for every accepted dataset and every random seed (up to a null set)**,

```math
F_N(k_N)\le \min_kF_N(k)+\lambda\rho_N^3\quad\text{on }E_N.
\tag{2}
```

No restriction outside $E_N$ is needed for the lower bound. The attaining rule uses a fixed locally safe fallback there. Thus this is a finite-$N$ class, not a class defined only by eventual feasibility.

**Frontier theorem.** For this experiment and class,

```math
\mathcal R_\lambda(s;\theta_0)
:=\lim_{M\to\infty}\liminf_{N\to\infty}
\inf_{k_N\in\mathcal C_N(\lambda)}
\sup_{\|h\|\le M}
N E_{\theta_{N,h}}\ell(k_N,\theta_{N,h}).
```

Then

```math
\boxed{\mathcal R_\lambda(s;\theta_0)
=\frac H2\left[v+s^4\left(
|b_2|-\frac{\lambda}{H\sqrt v}\right)_+^2\right].}
\tag{3}
```

There is one explicitly defined, exactly certificate-feasible safeguarded sequence whose risk converges to the right side uniformly over every fixed $\|h\|\le M$; hence the analogous iterated limsup has the same value. If the original unguarded controller is used without a safeguard, only its distributional consequences are claimed; rare instability is not silently ignored in an expected-cost statement.

## 2. Scalar global convexity and the safety event

For every fixed stabilizable scalar model, the finite domain of $C(\cdot,\theta)$ is an open interval, and

```math
C_{kk}(k,a,b)=W\left[
\frac{b^2Q+R(a-1)^2}{(1-a-bk)^3}
+\frac{b^2Q+R(a+1)^2}{(1+a+bk)^3}
\right]>0
\tag{4}
```

throughout that interval. This formula also holds at $b=0$ when $|a|<1$. Extending by infinity therefore gives a convex scalar cost. The common-stability set for a compact collection of models is an interval; the supremum of their excess losses is convex there and extended-convex globally. Coercivity, lower semicontinuity and the uniform nominal-loss bound give existence. Local strict convexity gives uniqueness, while uniform compact localization and continuity give a Borel, locally continuous optimizer (Appendix A).

Start with the **known** stabilizable reference $\theta_{\mathrm{ref}}$ and feedback $k_{\mathrm{safe}}=k_*(\theta_{\mathrm{ref}})$. By continuity of its strict stability margin, choose known compact neighborhoods

```math
U_0\subset\operatorname{int}U_1\subset\operatorname{int}U_2
```

around that reference, and a known closed feedback interval $\mathcal K$ around $k_{\mathrm{safe}}$, so that every $k\in\mathcal K$ stabilizes every $\theta\in U_2$ with a common strict margin. The prior promise is that the unknown true system belongs to $U_0$; the analysis point satisfies $\theta_0\in\operatorname{int}U_0$. Shrink $U_1$ so that all $k_*(\eta)$, $\eta\in U_1$, lie a fixed positive distance inside $\mathcal K$. These choices use the reference and continuity bounds, not $\theta_0$.

The known experiment and compact prior yield known constants $m_\Gamma,M_\Gamma>0$ with
$2m_\Gamma I\prec I(\theta)\prec(M_\Gamma/2)I$ for all $\theta\in U_2$, after shrinking the prior if necessary. The observable Gram band is $m_\Gamma I\preceq\widehat I_N\preceq M_\Gamma I$, not a neighborhood centered at the unknown $I_0$.

Choose known $\rho_0,\eta_0>0$ such that every ellipsoid centered in $U_1$, with a shape from this Gram band and radius at most $\rho_0$, is contained in $U_2$, and every controller within objective error $\eta_0$ of its robust optimum belongs to $\mathcal K$. The latter property has a direct quantitative justification. The CE comparator gives $F_\rho(k_*(\eta))\le C\rho^2$ uniformly; inclusion of the center and the scalar performance-difference identity give

```math
\ell(k,\eta)\ge WR|k-k_*(\eta)|^2,
\qquad
|k-k_*(\eta)|^2\le\frac{C\rho^2+\eta_0}{WR}
```

for every globally $\eta_0$-optimal feedback. Choose the constants to fit the prescribed interior margin of $\mathcal K$.

Define $E_N$ by the deterministic checks $\rho_N\le\rho_0$ and $\lambda\rho_N^3\le\eta_0$, together with $\widehat\theta_N\in U_1$ and the known Gram band. Small sample sizes failing these checks are rejected. Every accepted dataset has $G_N\subset U_2$, a finite robust optimum, and all certificate-feasible outputs in $\mathcal K$. Thus no $\infty-\infty$ certificate is used.

This event uses only known reference information and observable statistics. Neither the event $\theta_{N,h}\in G_N$, the unknown true $\theta_0$, nor the unknown $I_0$ enters its implementation. The exponentially small safety-gate failure in (5) is distinct from confidence-region noncoverage. This is a local decision theorem under a known safe prior, not a claim of global stabilization for arbitrary unknown systems. For derivative-based expansions one may further restrict the **analysis** to a fixed neighborhood of the given $\theta_0$ where $D\ne0$; its complement has exponentially small probability and does not change the implemented gate.

For fixed $T$, the state-input variables in one trajectory are jointly Gaussian with moments depending continuously on $\theta$. The entries of the empirical Gram matrix and the trajectory score are finite sums of products of these Gaussian variables and hence have uniformly subexponential tails on a fixed compact parameter neighborhood. Independent-trajectory Bernstein bounds imply

```math
\sup_{\|h\|\le M}P_{\theta_{N,h}}(E_N^c)
\le C_Me^{-c_MN}
\tag{5}
```

for every fixed $M$ and all sufficiently large $N$. Indeed, on a well-conditioned Gram event, least-squares error equals inverse empirical information times the averaged score. Fixed-neighborhood deviations in either quantity have exponentially small probability. This argument does not require state-process stationarity, since trajectory length is fixed.

## 3. Uniform analytic two-branch reduction and coefficient (1)

Take a nearby center $\eta$, shape $\Omega=S^2\succ0$, and radius $\rho$. The scalar Riccati solution and all losses are analytic on a common-stability neighborhood. Global minimax existence follows from coercivity and lower semicontinuity; global minimizers localize to $k_*(\eta)$ as $\rho\to0$. Appendix A supplies a complete global-to-local bridge; in the scalar case it also follows directly from $C\ge WRk^2$ and uniqueness of the nominal optimum.

Set $k=k_*(\eta)+\rho x$. After division by $\rho^2$, the excess-loss family extends analytically to $\rho=0$, where it is

```math
\frac{H_\eta}{2}(x-D_\eta Su)^2,\qquad \|u\|\le1.
\tag{6}
```

The minimizer of its supremum is uniquely $x=0$. Uniform convergence on bounded sets and initial strong-convexity localization give $x\to0$ for global minimizers.

At $(x,\rho)=(0,0)$, the inner problem has exactly two maximizers

```math
u_\pm=\pm SD_\eta^T/\sqrt q.
```

They lie on the unit circle and have strictly negative, nonzero constrained angular curvature. The implicit function theorem supplies analytic branches $u_\pm(x,\rho,\eta,S)$. By compactness, all other angular regions remain separated in value; interior maxima are excluded by the positive curvature of the leading quadratic in a nonzero direction. Thus the exact inner maximum near the outer optimizer consists of these two branches.

At $\rho=0$, the difference of their normalized values is $-2H_\eta\sqrt q\,x$. A second implicit-function theorem makes their equal-value point an analytic function $x(\rho)$, with $x(0)=0$. The two feedback slopes have opposite signs, so their equal-value point minimizes their convex maximum; global localization identifies it with the global minimizer. The uncertainty set is unchanged by $\rho\mapsto-\rho$, and the minimizer is unique, so its analytic gain is even in $\rho$. Consequently,

```math
k_R(\eta,\rho,\Omega)
=k_*(\eta)+b_2(\eta,\Omega)\rho^2+O(\rho^4).
\tag{7}
```

All estimates and analytic constructions are uniform on a sufficiently small compact neighborhood of $(\theta_0,V)$. We do not assert uniformity as $D\to0$, nor a vector-feedback version of this second-order formula.

For the coefficient, let $v_0=w/\sqrt q$ be the positive parameter-space direction. At fixed nominal feedback,

```math
\ell(k_*,\eta+\rho v_0)
=\tfrac12H_\eta q\rho^2
+\tfrac16\ell_{\theta\theta\theta}[v_0,v_0,v_0]\rho^3+O(\rho^4).
```

Replacing $k_*$ by $k_*+c\rho^2$ adds $-H_\eta\sqrt q\,c\rho^3$ on this branch and the opposite term on the other branch. Branch movement changes the value only at fourth order. Balancing the cubic terms yields

```math
b_2=\frac{\ell_{\theta\theta\theta}[w,w,w]}{6H_\eta q^2}.
\tag{8}
```

To remove derivatives of the optimal-value function, differentiate $C_k(k_*(\theta),\theta)=0$. For a fixed direction $w$, write $d=D_\eta w=q$, $e=k_*''[w,w]$, and $J=C_{kkk}$. Then

```math
e=-\frac{C_{k\theta\theta}[w,w]+2C_{kk\theta}[w]q+Jq^2}{H_\eta},
\qquad H_\eta'[w]=C_{kk\theta}[w]+Jq.
```

Expanding $\ell$ around the varying optimum gives

```math
\ell_{\theta\theta\theta}[w,w,w]
=3H_\eta qe+3H_\eta'[w]q^2-Jq^3.
```

Substitution into (8) proves (1). The coefficient is computable from the nominal feedback and third partial derivatives of the original cost.

## 4. The entire certificate-feasible set, not merely a candidate correction

Let $F_\rho$ denote the deterministic robust excess objective at $(\eta,\Omega)$. Its two active model losses at $k_R$ have slopes

```math
s_+(\rho)=H_\eta\sqrt q\,\rho+O(\rho^2),\qquad
s_-(\rho)=-H_\eta\sqrt q\,\rho+O(\rho^2).
\tag{9}
```

Since each model loss is globally convex as an extended scalar function, its tangent supports the loss throughout its finite domain. Therefore for **every** feedback with finite robust objective,

```math
F_\rho(k)-F_\rho(k_R)
\ge\max\{s_+(k-k_R),s_-(k-k_R)\}
\ge c_0\rho|k-k_R|
\tag{10}
```

for a uniform $c_0>0$. This is the classical supporting-hyperplane principle underlying weak sharp minima [R10]. The instance-specific opposing slopes and their radius-dependent leading constant are computed here. Thus a $\lambda\rho^3$ budget forces every feasible feedback to satisfy $|k-k_R|=O(\rho^2)$. This step is necessary: strong convexity alone would only give $O(\rho^{3/2})$, which is insufficient for the frontier.

For bounded real $d$, the two-branch expansion, uniformly in $d$, gives

```math
F_\rho(k_R+d\rho^2)-F_\rho(k_R)
=H_\eta\sqrt q\,|d|\rho^3+O(\rho^4).
\tag{11}
```

For $\lambda>0$, convexity, (10), and (11) show that the **complete** feasible sublevel is an interval with endpoints

```math
k_R\ \pm\ \frac{\lambda}{H_\eta\sqrt q}\rho^2+O(\rho^3).
\tag{12}
```

For $\lambda=0$, it is exactly $\{k_R\}$. Equivalently, after centering at $k_*(\eta)$ and dividing by $\rho^2$, the complete set converges in Hausdorff distance to

```math
\left[b_2(\eta,\Omega)-\frac{\lambda}{H_\eta\sqrt q},
b_2(\eta,\Omega)+\frac{\lambda}{H_\eta\sqrt q}\right].
\tag{13}
```

The exact endpoints in (12) need not equal their leading approximations; feasibility of the attaining procedure will be enforced using the exact objective.

## 5. Critical statistical bias interval

Write $\widehat h_N=\sqrt N(\widehat\theta_N-\theta_0)$, and let $\widehat I_N\to I_0$. On data sets with $\widehat h_N$ in a fixed compact set and $\widehat I_N$ tending to $I_0$, expansions (7) and (12) are uniform. Every feasible feedback's scaled value $t_N=\sqrt N(k_N-k_0)$ lies in

```math
t_N\in D\widehat h_N+B+o(1),
```

where the deterministic limiting correction interval is

```math
B=s^2\left[
b_2-\frac{\lambda}{H\sqrt v},
b_2+\frac{\lambda}{H\sqrt v}\right].
\tag{14}
```

The inclusion holds for all feasible programs and all their random seeds. It is uniform on the stated compact data sets. For true $\theta_{N,h}=\theta_0+h/\sqrt N$, bounded $h,t$ satisfy the uniform local loss expansion

```math
N\ell(k_0+t/\sqrt N,\theta_{N,h})
=\tfrac H2(t-Dh)^2+O(N^{-1/2}),
\tag{15}
```

with a constant depending only on the chosen compact sets. No expectation or unbounded-loss convergence has yet been used.

## 6. Exact likelihood and an original-experiment lower bound

Let $Z_t=(X_t,U_t)^T$, and use the trajectory product of Gaussian transition densities. Inputs and the known deterministic initial state have parameter-independent laws. On the nonsingular Gram event, completing the square gives the **exact** likelihood, even though the regressors are random; define the least-squares estimate arbitrarily outside that event, which the implemented gate rejects:

```math
L_N(\theta)\propto
\exp\left\{-\frac N2(\theta-\widehat\theta_N)^T
\widehat I_N(\theta-\widehat\theta_N)\right\}.
\tag{16}
```

Thus $(\widehat\theta_N,\widehat I_N)$ are sufficient for the posterior. For $h=\sqrt N(\theta-\theta_0)$, a local Gaussian prior $N(0,\tau^2V)$, truncated to $\|h\|\le R$, has posterior density proportional to

```math
\mathbf1_{\{\|h\|\le R\}}
\exp\left[-\tfrac12(h-\widehat h_N)^T\widehat I_N(h-\widehat h_N)
-\tfrac1{2\tau^2}h^TV^{-1}h\right].
\tag{17}
```

The truncation keeps all local parameters in a fixed compact set before $N\to\infty$. It also avoids placing a finite-$N$ prior outside the region where the analytic loss estimates apply.

### 6.1. Fixed compact prior and data window

Fix $\tau,R,L<\infty$. For the lower-bound argument only, restrict the integrated risk to the analysis event
$\|\widehat h_N\|\le L$, $\|\widehat I_N-I_0\|\le\epsilon_N$, where $\epsilon_N\downarrow0$ slowly enough that the information event has probability tending to one uniformly for $\|h\|\le R$. For example, a fixed fractional power $\epsilon_N=N^{-1/8}$ works by the concentration bound proved in Appendix B. This restricted event is contained in the known-reference gate $E_N$ for all large $N$, since $\theta_0\in\operatorname{int}U_0$ and $I_0$ lies strictly inside the prescribed Gram band. It is not an additional gate used by the procedure: it may depend on $\theta_0,I_0$ because it is only a proof device.

By (14), all certificate-feasible outputs on this event have uniformly bounded $t_N$. By (15), their original scaled loss is uniformly approximated by the quadratic target loss. Conditional on the full dataset, posterior (17) is independent of ancillary data. For a randomized output, averaging conditional squared loss is at least its minimum over the feasible interval. Consequently, **uniformly over every feasible program**, conditional risk is at least

```math
\frac H2\left\{
\operatorname{Var}(Dh\mid\text{data})
+\operatorname{dist}\left(E[Dh\mid\text{data}],D\widehat h_N+B\right)^2
\right\}-o(1).
\tag{18}
```

Replacing the finite-$N$ feasible interval by (14) changes this bound by $o(1)$ uniformly on the compact window. In particular, the infimum over programs may be taken before $N\to\infty$; the error bound does not depend on the program.

Because (17) has bounded support and $\widehat h_N$ is restricted to a compact set, posterior normalization and its first two moments converge uniformly as $\widehat I_N\to I_0$. The independent-trajectory score CLT and information law of large numbers give

```math
(\widehat h_N,\widehat I_N)\Rightarrow(h+Z,I_0),
\qquad Z\sim N(0,V),
\tag{19}
```

uniformly for $h$ in a fixed compact set. This follows from a finite-dimensional Lyapunov CLT for independent trajectory scores with continuous, uniformly bounded moments, and the score/least-squares identity; it is not inferred merely from a value CLT. Mixing over the fixed truncated prior preserves (19). The boundary of $\|h+Z\|\le L$ has probability zero.

Therefore the lower limit of integrated risk is bounded **below** by the corresponding Gaussian-observation Bayes risk restricted to $\|Y\|\le L$, with the same compact prior. For every $M\ge R$, worst-case local risk dominates this Bayes risk. Taking the outer $M\to\infty$ proves a lower bound for every fixed $\tau,R,L$.

### 6.2. Remove truncations in a valid order

First keep $\tau,L$ fixed and let $R\to\infty$. On the compact data window, the truncated-prior posterior integrals and their first two moments converge to those for the untruncated Gaussian prior by Gaussian domination; their normalizers are bounded away from zero. The prior predictive densities converge there as well. This passage concerns only the already-obtained Gaussian integral, not a finite-$N$ uncontrolled prior.

Next let $L\to\infty$. The conditional Bayes-loss integrand is nonnegative, so monotone convergence applies. Under the full Gaussian prior,

```math
h\mid Y\sim N(\kappa Y,\kappa V),\qquad
\kappa=\frac{\tau^2}{1+\tau^2},\qquad
Y\sim N(0,(1+\tau^2)V).
```

Hence the bound becomes

```math
\frac H2\left[
\kappa v+E\operatorname{dist}\big(-(1-\kappa)DY,B\big)^2
\right].
\tag{20}
```

Finally let $\tau\to\infty$. The random scalar $(1-\kappa)DY$ has variance $v/(1+\tau^2)$ and tends to zero in $L^2$. Distance to a fixed interval is 1-Lipschitz and has at most linear growth, so its squared expectation converges to $\operatorname{dist}(0,B)^2$. This yields

```math
\liminf\text{ local minimax risk}\ge
\frac H2[v+\operatorname{dist}(0,B)^2],
\tag{21}
```

which is (3). The proof uses the exact finite-$N$ trajectory posterior and uniform compact loss expansions. It does not transfer an unbounded quadratic loss solely by weak convergence, and it never assumes a Gaussian prior has compact finite-$N$ support before truncating it. The elementary Gaussian correction-interval lemma is classical decision-theoretic reasoning; the research claim is its exact bridge from the original robust-control certificate.

## 7. An exactly feasible attaining rule and expected-risk justification

On $E_N$, let $k_{C,N}=k_*(\widehat\theta_N)$. Define

```math
\gamma_N=\max\left\{\gamma\in[0,1]:
F_N\big(k_{R,N}+\gamma(k_{C,N}-k_{R,N})\big)
\le F_N(k_{R,N})+\lambda\rho_N^3\right\},
\tag{22}
```

and choose the feedback inside this display at $\gamma=\gamma_N$. If the two gains coincide, choose that gain. On $E_N^c$, use the **known** fixed feedback $k_{\mathrm{safe}}=k_*(\theta_{\mathrm{ref}})$. The whole segment is commonly stable for accepted data. Convexity makes its feasible portion a closed interval containing zero; continuity gives the maximum. The construction is measurable (equivalently, use the supremum over feasible rational fractions and continuity). It uses $\widehat\theta_N,\widehat I_N$, the known cost model and the known reference safeguard; it does not use $k_0,I_0,H,v$, or $b_2(\theta_0,V)$. It meets (2) exactly; no asymptotic approximation is substituted into the feasibility check. No claim of a fast generic inner-maximization algorithm is made.

Equivalently, this scalar rule is the Euclidean projection of the nominal gain onto the complete exact certificate sublevel interval. Under (13), the rescaled interval converges to the translated interval in (14), so continuity of scalar interval projection identifies the limiting correction with $\operatorname{proj}_B(0)$. This argument includes zero budget, zero second-order bias, and the threshold budget without division by $b_2$.

When $b_2\ne0$, (7) and (11) imply

```math
\gamma_N\to\min\left(1,\frac{\lambda}{H\sqrt v|b_2|}\right)
```

uniformly in probability for bounded local $h$. Thus

```math
\sqrt N(k_N-k_*(\theta_{N,h}))
\Rightarrow DZ+b_{\mathrm{opt}},
```

```math
b_{\mathrm{opt}}=s^2\operatorname{sgn}(b_2)
\left(|b_2|-\frac{\lambda}{H\sqrt v}\right)_+.
\tag{23}
```

If $b_2=0$, the same conclusion holds with $b_{\mathrm{opt}}=0$: for $\lambda=0$ use the exact controller, and for $\lambda>0$ the nominal gain eventually lies within budget, up to events whose probability tends to zero. At the endpoint budget equality the convergence remains valid.

To pass to expected original cost, not just its distribution, note that on $E_N$, all chosen gains lie in the known common-stability interval $\mathcal K$. In the analysis, restrict further to $\widehat\theta_N$ in a fixed sufficiently small neighborhood of the true analysis point $\theta_0$, and $\widehat I_N$ in a fixed sufficiently small neighborhood of $I_0$, where $D\ne0$ and (7) is uniform; the complement within acceptance has probability $Ce^{-cN}$. These are proof events, not additional implemented gates. On this analysis event,

```math
\sqrt N|k_N-k_*(\theta_{N,h})|
\le C\sqrt N\|\widehat\theta_N-\theta_{N,h}\|+C
\tag{24}
```

for critical $\rho_N$, because the rule lies on the exact-to-nominal segment and (7) is uniform. On the well-conditioned accepted Gram event, the first term is bounded by a constant times the norm of a normalized sum of independent, mean-zero trajectory scores. Its fourth moment is uniformly bounded: the score summands have uniform fourth moments, and expanding the fourth moment of their normalized sum gives a bound independent of $N$. All remaining accepted outputs and the fixed known fallback remain in $\mathcal K$, with uniformly bounded true cost on $U_0$. Their exponentially rare contribution to the first and second moments of the scaled loss is bounded by $CN e^{-cN}$ and $CN^2e^{-cN}$, respectively. No knowledge of the true optimal gain is used in the fallback.

Smoothness on the common-stability neighborhood bounds $N\ell$ by a constant times the square of (24). The fourth-moment bound supplies uniform integrability. Combining this with (15), (19), and (23) proves convergence of expected risk to

```math
\tfrac H2(v+b_{\mathrm{opt}}^2).
```

The same bounds and a compact-subsequence argument give uniform convergence over every fixed bounded local-parameter set. This establishes the attaining limsup in (3). It also identifies the smallest leading certificate relaxation that restores the efficient risk:

```math
\lambda_{\mathrm{efficient}}=H\sqrt v\,|b_2|.
\tag{25}
```

The nominal controller is the far endpoint of (22). The theorem does not present it as a new control algorithm; it quantifies exactly how much worst-case regret optimality must be surrendered to recover its statistical risk.

## 8. Subcritical, critical, and supercritical exact-controller phases

For general $\rho_N\to0$, retain the empirical-Fisher shape of Section 1 and the same local safeguard. Formula (7) gives

```math
k_{R,N}=k_*(\widehat\theta_N)+b_2(\widehat\theta_N,\widehat I_N^{-1})\rho_N^2+O_P(\rho_N^4).
```

- If $\sqrt N\rho_N^2\to0$, the exact controller has the efficient central Gaussian gain limit and quadratic-form cost limit.
- If $\sqrt N\rho_N^2\to t\in(0,\infty)$, its gain limit is $DZ+t b_2$, and its scaled loss is $\frac H2(DZ+t b_2)^2$, a scaled noncentral chi-square variable. Safeguarded limiting mean is $\frac H2(v+t^2b_2^2)$.
- If $\sqrt N\rho_N^2\to\infty$ and $b_2\ne0$, then $\rho_N^{-2}(k_{R,N}-k_*(\theta_{N,h}))\to b_2$, and $\rho_N^{-4}\ell\to Hb_2^2/2$ in probability; the same local moment bounds give the safeguarded mean limit. This is a fixed-system statement, not a growing-dimension theorem.

In the source normalization $\rho_N=4\sqrt{d_\theta+\log(2/\delta_N)}/\sqrt N$, the critical window is $\log(1/\delta_N)\asymp\sqrt N$. For $d_\theta=2$ and $\rho_N=sN^{-1/4}$, the identity holds with $\delta_N=2\exp(2-s^2\sqrt N/16)$, eventually in $(0,1)$. This is a radius reparameterization, not an unchecked substitution into every burn-in condition or coverage constant of the source theorem. Independently, trajectory-score Bernstein bounds and the fixed Gram gate give noncoverage probability at most $C\exp(-cN\rho_N^2)=C\exp(-c\sqrt N)$, with local constants; this is distinct from the $Ce^{-cN}$ safety-gate failure. Thus increasingly stringent confidence scales, rather than increased parameter dimension, create this phase. The source's proved upper bounds are not contradicted, and their constants do not by themselves specify this frontier.

A coefficient-corrected controller $k_R-b_2(\widehat\theta_N,\widehat I_N^{-1})\rho_N^2$ differs from CE by $O_P(\rho_N^4)$, hence has efficient first-order statistics when $\sqrt N\rho_N^4\to0$. For a fully defined safeguarded version, evaluate this expression on accepted data where $D_{\widehat\theta_N}\ne0$, project its output onto the known interval $\mathcal K$, and use the known safe fallback on all other data. At the regular analysis point the projection is inactive with probability $1-Ce^{-cN}$, and the same local expansion and moment argument apply. It remains commonly stable, but it pays a leading robust-objective premium $H\sqrt v|b_2|\rho_N^3$ when $b_2\ne0$. This is a corollary with an explicit certificate cost, not an assertion that bias correction uniquely dominates CE or exact robust optimization.

## 9. Fully identifiable nonzero-bias example

Use $a_0=b_0=1,Q=4/3,R=W=1$, and independent length-two experiments with $X_1=0$, standard-normal $U_1,U_2,W_1,W_2$. Then

```math
P_0=2,\quad k_0=-2/3,\quad H=27/4,\quad
D=(-5/6,1/3),\quad I_0=2I_2,\quad V=\tfrac12 I_2,
```

```math
v=29/72,\qquad b_2=-2501/5568\ne0.
\tag{26}
```

The Fisher calculation is direct: $X_1=0$, $X_2=U_1+W_1$, so $\sum_tE X_t^2=2$, $\sum_tE U_t^2=2$, and the cross terms vanish. No information shape is invented independently of a feasible experiment.

For an unnormalized Euclidean parameter ball, the coefficient is $-2501/2784$. The supporting exact derivatives are

```math
\|D\|^2=29/36,\quad
[t^3]\ell(k_0,\theta_0+tD)=-72529/18432,
```

```math
C_{k\theta\theta}[D,D]=285/16,\quad
C_{kk\theta}[D]=-225/16,\quad C_{kkk}=243/16.
```

Substituting into (1) gives the stated rational coefficient, and scaling $\Omega$ by $1/2$ scales $b_2$ by $1/2$. The efficient risk is $Hv/2=87/64$. At $s=1$, exact robust control adds the strictly positive amount $(27/8)(2501/5568)^2$. The minimum normalized certificate relaxation is $(9\sqrt{58}/16)(2501/5568)$.


## 10. Reproducibility and scope

The accompanying `code/verify_lqr.py` uses exact symbolic differentiation, rational arithmetic and explicitly labelled high-precision diagnostics. Its machine-readable output is `results/lqr_checks.json`; Appendix C states what each type of computation does and does not prove. The deterministic and statistical theorems are established in the text, not inferred from finite numerical experiments.

The main frontier is for scalar state and feedback with both dynamics parameters unknown, fixed trajectory horizon, regular Fisher information, and a known local safe prior. The frontier's infimum ranges over every measurable and independently randomized certificate-feasible rule; the upper rule uses only observed data and the known reference safeguard. No procedure is assumed to be a smooth function of the estimator. The lower bound imposes no restriction off the regular event, while the attaining rule has bounded safe cost there.

The matrix theorem supplies a quantitative supporting perturbation result. It does not supply a vector-feedback second-order coefficient, a vector version of the entire certificate geometry, a dimension-uniform statistical theorem, or a fast general robust-synthesis algorithm. We make no claim of global stabilization without a prior safe neighborhood. The certificate-budget question extends the source's broader efficiency motivation and is distinct from the fixed-confidence conjecture and raw-total-cost comparison.

Literature positioning is limited to the versions and sections stated below. Full texts were checked for [R1]–[R4] and [R6]–[R10]. For [R5], the publication metadata, abstract and author's arXiv manuscript were checked. None of these comparisons supports an unrestricted priority assertion. No claim of global priority, external peer review, or completed formal verification is made.

## Appendix A. A supporting matrix displacement theorem without a spectral gap

The first-order consequence of this matrix result provides a supporting baseline for the scalar certificate-constrained result.

### A.1. LQR facts and the global-to-local bridge

Fix finite state, input and parameter dimensions. Let $A(\theta),B(\theta)$ be $C^5$ near a stabilizable $\theta_0$, and let $Q,R,W$ be positive definite. Write $F=A+BK$, and extend cost by infinity outside the Schur region. For a stable feedback,

```math
\Sigma_K=W+F\Sigma_KF^\top,
\qquad C(K,\theta)=\operatorname{tr}[(Q+K^\top RK)\Sigma_K].
\tag{A1}
```

The stabilizing Riccati solution $P_*$ and unique optimal feedback $K_*$ can be obtained from the monotone finite-horizon Riccati recursion, starting at zero. A fixed stabilizing feedback bounds that recursion above by its Lyapunov cost, so its positive-semidefinite limit solves the Riccati equation. For $\Psi=R+B^\top P_*B$ and $K_*=-\Psi^{-1}B^\top P_*A$, the Riccati equation reads $P_*=Q+K_*^\top RK_*+F_*^\top P_*F_*$. Since $Q\succ0$, this identity makes $F_*$ Schur. Completing the square gives, for every stable $K$,

```math
Q+K^\top RK+F^\top P_*F-P_*
=(K-K_*)^\top\Psi(K-K_*).
```

Multiplication by $\Sigma_K$, taking traces, and (A1) yield the exact identity

```math
\ell(K,\theta)
=\operatorname{tr}[(K-K_*)^\top\Psi(K-K_*)\Sigma_K]
\ge \lambda_{\min}(R)\lambda_{\min}(W)\|K-K_*\|_F^2.
\tag{A2}
```

It proves optimality and uniqueness; applying it to two putative stabilizing solutions also proves uniqueness of the solution used here. The Riccati derivative with respect to $P$ is the invertible Lyapunov operator $X\mapsto X-F_*^\top XF_*$, with inverse $Y\mapsto\sum_{j\ge0}(F_*^\top)^jYF_*^j$. The implicit function theorem therefore supplies the claimed local $C^5$ regularity. Lyapunov inverses give the same regularity for cost on a common-stability neighborhood.

For centers $\eta$ near $\theta_0$, shapes $S$ in a fixed positive-definite compact set, and small $\rho$, let $F_\rho(K)=\sup_{\|u\|\le1}\ell(K,\eta+\rho Su)$. A common stabilizing candidate has finite cost. The extended cost is lower semicontinuous because it is a supremum of continuous finite Lyapunov-series partial sums, and $C(K,\eta)\ge\lambda_{\min}(R)\lambda_{\min}(W)\|K\|_F^2$. The compact parameter set has bounded optimal cost; thus robust sublevels are closed and bounded, and a minimizer exists. No optimizer is postulated to be local.

The nominal optimal feedback gives $F_\rho(K_*(\eta))\le C\rho^2$. Inclusion of the center and (A2) force every global minimizer to lie within $O(\rho)$ of it. All such minimizers consequently lie inside one convex common-stability ball. In column-major gain coordinates, the nominal Hessian is

```math
H_\eta=2[\Sigma_*(\eta)\otimes\Psi_\eta]\succ0.
```

All model-specific feedback Hessians remain uniformly positive there. Their supremum is strongly convex, so the global optimizer is unique and continuous in its local inputs. Compact minimization and uniqueness give this continuity directly. With $D_\eta=DK_*(\eta)$, Taylor expansion of (A2) gives

```math
\ell(K_*(\eta)+h,\eta+t)
=\tfrac12(h-D_\eta t)^\top H_\eta(h-D_\eta t)
+O((\|h\|+\|t\|)^3),
\tag{A3}
```

with the corresponding uniformly bounded scaled first and second derivative remainders.

### A.2. Active-value and inner-KKT elimination

**Theorem A.1.** At every fixed center where $D_\eta\ne0$,
$\|K_R(\eta,\rho,S)-K_*(\eta)\|=O(\rho^2)$.
Constants are uniform on a sufficiently small neighborhood of a fixed nonzero-sensitivity point and on the specified shape compact set. Neither injectivity of $D_\eta$, a simple largest singular value, nor a sensitivity spectral gap is assumed.

Put $T=H_\eta^{1/2}/\sqrt2$, $h=\rho T^{-1}y$, and $L=TD_\eta S$. The scaled problem is

```math
f_\rho(y)=\max_{\|u\|\le1}g_\rho(y,u),
\qquad g_\rho(y,u)=\|y-Lu\|^2+\rho R_\rho(y,u).
\tag{A4}
```

The global-to-local bound makes its minimizer $y$ bounded. The remainder and its first two derivatives are uniformly bounded on this bounded region. By the maximum-gradient formula and finite-dimensional convex-hull reduction, there are finitely many active $u_i$, weights $p_i\ge0$ summing to one, and $v_i=Lu_i$, such that

```math
\bar v:=\sum_i p_i v_i=y+O(\rho).
\tag{A5}
```

Every active point lies on the unit sphere: at an interior maximum the second directional derivative in a largest right singular direction would have to be nonpositive, whereas it is $2\|L\|^2+O(\rho)>0$. The sphere stationarity equations give multipliers $\alpha_i$ with

```math
\alpha_i v_i=LL^\top(v_i-y)+O(\rho).
```

Dotting the unmultiplied stationarity equation with $u_i$, and using the common active value $f=f_\rho(y)$, gives

```math
\alpha_i=\|v_i\|^2-y^\top v_i+O(\rho)
=f-\|y\|^2+y^\top v_i+O(\rho).
```

Averaging the preceding equations, substituting (A5), and collecting the bounded remainders yields

```math
\left[(f-\|y\|^2)I+\sum_i p_i v_iv_i^\top\right]y=O(\rho).
\tag{A6}
```

To justify the elimination explicitly, the averaged right side is $LL^\top(\bar v-y)+O(\rho)=O(\rho)$. The averaged left side is $(f-\|y\|^2)\bar v+\sum_i p_iv_iv_i^\top y+O(\rho)$; replacing bounded $\bar v$ by $y+O(\rho)$ gives (A6).

For a unit vector $u_*$ attaining $\|Lu_*\|=\|L\|$, the average of the values at $u_*,-u_*$ shows
$f-\|y\|^2\ge\|L\|^2-C\rho$.
The bracket in (A6) is at least $\|L\|^2I/2$ for small $\rho$. Thus $y=O(\rho)$, proving $h=O(\rho^2)$. Its coercivity uses the largest singular value's magnitude, not separation from the others.

If $D_\eta=0$ at the center itself, nominal model-feedback gradients throughout the uncertainty set are $O(\rho^2)$, and strong convexity proves the same displacement bound directly. Near a fixed point with $D_{\theta_0}=0$, the safe uniform statement is

```math
\|K_R-K_*(\eta)\|
\le C\{\rho\|\eta-\theta_0\|+\rho^2\}.
\tag{A7}
```

Indeed $\|D_\eta\|\le C\|\eta-\theta_0\|$, and every active model's nominal feedback gradient has the displayed order. Strong monotonicity of the maximum's subgradient then bounds optimizer distance by that order. We do not claim constants uniform in (A6) as $D\to0$.

### A.3. Consequences and numerical objective error

For every globally $\varepsilon$-optimal feedback, the nominal comparator, inclusion of the center, and (A2) first give $\|K_\varepsilon-K_*(\eta)\|\le C\sqrt{\rho^2+\varepsilon}$. Thus sufficiently small $\rho,\varepsilon$ place all such feedbacks in the same common-stability ball. Strong convexity then gives distance at most $C\sqrt\varepsilon$ from the exact solution. Consequently the general matrix bound is $O(\rho^2+\sqrt\varepsilon)$, or (A7) plus this error at a zero-derivative base point. A local stationary point without a global objective certificate is not covered. For root-$N$ regular centers, consistent nonsingular shapes, $\rho_N=o(N^{-1/4})$, and $\varepsilon_N=o(N^{-1})$, the exact or certified approximate feedback has the same first-order distribution as CE, including at $D_{\theta_0}=0$ by (A7). The delta method and (A3) give the quadratic true-loss limit. Under this generic bound, $\varepsilon=O(\rho^4)$ is a sufficient condition for retaining the deterministic $O(\rho^2)$ distance.

This generic strong-convexity tolerance is distinct from the sharp scalar certificate interval in Section 4. There the two opposing slopes permit a larger, explicitly priced $\rho^3$ objective budget. The scalar construction proves that the general ellipsoidal $\rho^2$ displacement order cannot be improved to little-o at every regular instance. No scalar formula for $b_2$ is asserted for matrix-valued feedback.

## Appendix B. Trajectory moments, information, and expected cost

Here the model is the scalar two-parameter experiment of Section 1. Put $z_{nt}=(X_{nt},U_{nt})^\top$. For truth $\theta$, define the trajectory score and Gram matrix

```math
\xi_n=\sum_{t=1}^T z_{nt}W^{-1}W_{nt},\qquad
\Gamma_n=\sum_{t=1}^T z_{nt}W^{-1}z_{nt}^\top.
\tag{B1}
```

Then $\widehat I_N=N^{-1}\sum_n\Gamma_n$ is information per trajectory. On its nonsingular event,

```math
\widehat\theta_N-\theta=\widehat I_N^{-1}\bar\xi_N,
\quad E_\theta\xi_n=0,
\quad\operatorname{Cov}_\theta(\xi_n)=E_\theta\Gamma_n=I(\theta).
\tag{B2}
```

For unequal times, the score covariance vanishes by conditioning just before the later innovation; for equal times the conditional covariance is $z_{nt}W^{-1}z_{nt}^\top$. Conditioning on the full regressor array would be invalid for claiming independent Gaussian residuals, because later states contain earlier innovations. Equation (16) instead follows from the product of transition densities, whose state-transformation Jacobian is triangular with unit diagonal.

The fixed deterministic initial state, fixed finite $T$, and independent Gaussian inputs and innovations make every trajectory a finite Gaussian affine image. Centered score coordinates and Gram entries are quadratic polynomials of a finite standard Gaussian vector, with coefficients bounded uniformly on compact parameter sets. For such a centered polynomial $Y$, $|Y|\le C(1+\|g\|^2)$ implies a uniform small exponential moment; its centered log moment-generating function is bounded by $Cs^2$ near zero. Chernoff's argument for independent trajectories and a finite-coordinate union bound give

```math
P_\theta(\|\bar\xi_N\|>t)+
P_\theta(\|\widehat I_N-I(\theta)\|>t)
\le C\exp[-cN\min(t^2,t)].
\tag{B3}
```

Integrating this bound gives $E\|\bar\xi_N\|^j+E\|\widehat I_N-I(\theta)\|^j\le C_jN^{-j/2}$ for every fixed positive integer $j$. On the accepted Gram band the inverse is bounded, so the same order holds for estimation-error moments restricted to acceptance. In particular fourth and eighth moments are available. The iid trajectory CLT and (B2), with Slutsky's theorem, give covariance $I(\theta)^{-1}$. A triangular array with $\theta=\theta_0+h_N/\sqrt N$ and bounded $h_N$ has the same conclusion: the covariance converges and the uniformly bounded third moments imply the Lyapunov condition. Taking subsequences of bounded $h_N$ proves uniform convergence on each compact local-parameter set, as used in Section 6.

The known common-stability interval has some known margin $r<1$ and finite $K_{\max}$. Thus all implemented outputs satisfy the deterministic bound

```math
C(k,\theta)\le
\frac{W(Q+RK_{\max}^2)}{1-r^2}\quad
(k\in\mathcal K,\ \theta\in U_0).
\tag{B4}
```

Equations (B2)-(B4) justify the fourth-moment and exponentially rare-event arguments in Section 7. They do not assert moments of an untruncated inverse Gram matrix. At subcritical radii, the same reasoning yields the CE mean constant; at critical radii it yields the noncentral constant; at supercritical radii, $\rho_N^{-4}=o(N)$, so both score moments and exponential remainders remain negligible after the stated normalization. If a numerical implementation can fail separately, its failure probability must be included: preserving an $N$-scaled mean requires a bounded fallback contribution of order $o(N^{-1})$. The exact theoretical attaining rule has no additional solver-failure event.

## Appendix C. What the finite computations certify

The shared one-unknown-parameter diagnostic fixes $b=1$, $Q=4/3$, and $R=W=1$. Its Riccati root is

```math
P(a)=\frac{a^2+1/3+\sqrt{(a^2+1/3)^2+16/3}}2,
\qquad k_*(a)=-\frac{aP(a)}{1+P(a)}.
```

At $a=1$, direct differentiation gives $k_*=-2/3$, $k_*'=-5/6$, $k_*''=-19/48$, $C_{kk}=27/4$, and the fixed-gain cubic regret coefficient $1035/256$. For sufficiently small $\rho$, the exact minimax gain on $[1-\rho,1+\rho]$ is the equal-endpoint-loss solution and satisfies
$k_R=-2/3-(23/32)\rho^2+O(\rho^4)$.
To justify the interval reduction, on the entire rectangle
$a\in[9/10,11/10]$, $k\in[-4/5,-11/20]$,
the closed loop lies in $[1/10,11/20]$ and
$\ell_{aa}\ge11141/25000>0$.
For example, the Riccati square root is greater than $5/2$, yielding $P''\le26494/9375$, while $C_{aa}\ge1963/600$. Thus the worst model on each small interval is an endpoint. Opposite endpoint feedback gradients at their equal-loss intersection certify a global minimizer of the endpoint maximum; that maximum is a global lower bound on the full interval objective. Equality at the intersection establishes global optimality for the full interval. Analytic implicit-function and symmetry arguments yield the expansion.

The reproduction program locates each intersection at high precision, encloses the square root by rational bounds derived from integer square roots, and checks endpoint signs and gradient inequalities with exact rational arithmetic. Eight tested radii are certified over continuous intervals, not only on a grid. These are finite certificates for this structured submodel and are not substitutes for the full two-unknown-parameter theorem.

For the full $(a,b)$ example of Section 9, exact symbolic derivatives certify the displayed rational coefficients and realizable Fisher matrix. Four high-precision circle calculations illustrate the coefficient and certificate-premium limits. Those calculations are explicitly labelled diagnostics: they are not interval proofs of a global two-dimensional maximum. The two-branch proof supplies the general assertion. The original proof and the reproduced arithmetic play different roles.


## Appendix D. Research objective

Consider the scalar discrete-time infinite-horizon noisy LQR with both dynamics parameters theta=(a,b) unknown, fixed Q,R,W>0, feedback u=kx, and extended cost C(k,theta)=+infinity outside the Schur-stable region. Fix a stabilizable interior theta0 with nonzero gain derivative D=gradient k*(theta0). Observe N independent fixed-length Gaussian open-loop trajectories with known parameter-independent initial state and Gaussian inputs, nonsingular per-trajectory Fisher information I0, and use the efficient least-squares estimate and empirical-information ellipsoid G_N=thetahat_N+rho_N Ihat_N^(-1/2) B_2. Let rho_N=s N^(-1/4), s>0, and F_N(k)=sup_{theta in G_N}[C(k,theta)-C(k*(theta),theta)]. For each fixed lambda>=0, determine the exact local asymptotic minimax N-scaled true-system excess-cost risk, over all measurable possibly randomized procedures constrained on an observable regular safety event to satisfy F_N(k_N)<=inf_k F_N(k)+lambda rho_N^3 for every accepted dataset. The local parameters are theta0+h/sqrt(N); the minimax quantifiers are an infimum over all certificate-feasible procedures, a supremum over ||h||<=M, N tending to infinity, then M tending to infinity. The safety event must have exponentially small failure probability uniformly over each compact local parameter set; expected-risk attainability must use a known local common-stability safeguard and a fixed safe fallback. Derive a general scalar second-order minimax-regret gain coefficient for a positive definite ellipsoidal shape, prove that the full certificate-feasible gain set has a sharp rho^2 interval expansion, establish a lower bound in the original trajectory experiment rather than only its Gaussian limit, and construct an exactly certificate-feasible attaining procedure. Determine the subcritical, critical and supercritical statistical behavior of the exact controller and exhibit a fully identifiable two-unknown-parameter LQR with an actually realizable Fisher shape and a nonzero critical bias. A no-sensitivity-gap quadratic-displacement theorem for fixed finite-dimensional matrix LQR may be used as an explicitly attributed supporting contribution. The primary target is the certificate-constrained minimax frontier and its attainability. The fixed-confidence first-order conjecture and the raw-total-cost comparison are separate problems. No growing-dimension theorem, global finite-data stabilization theorem, universally optimal experimental design, or efficient algorithm for general exact robust synthesis is claimed.

## References

- **[R1]** T. Fujinami, B. D. Lee, N. Matni, and G. J. Pappas. *Domain Randomization is Sample Efficient for Linear Quadratic Control*. Proceedings of Learning for Dynamics and Control, PMLR 283:907-919, 2025. [Official proceedings](https://proceedings.mlr.press/v283/fujinami25a.html); [arXiv:2502.12310v1](https://arxiv.org/html/2502.12310v1). Sections 2.1, 3.2, 5 and the perturbation/least-squares appendices are relevant.
- **[R2]** F. Dörfler, P. Tesi, and C. De Persis. *On the Certainty-Equivalence Approach to Direct Data-Driven LQR Design*. IEEE Transactions on Automatic Control 68(12):7989-7996, 2023. [DOI:10.1109/TAC.2023.3253787](https://doi.org/10.1109/TAC.2023.3253787). Published version, especially Section III, Theorem 4.2, and Section V.
- **[R3]** L.-B. Fiechtner and J. Blanchet. *Wasserstein Distributionally Robust Regret Optimization*. [arXiv:2504.10796v5](https://arxiv.org/html/2504.10796v5), revised 9 August 2026. Section 3.2, Theorem 3 and its proof.
- **[R4]** S. Nietert and D. Kuhn. *Regret-Optimal Wasserstein-Robust Linear Regression*. [arXiv:2610.42109](https://arxiv.org/abs/2610.42109), 2026; [author full manuscript](https://optimization-online.org/wp-content/uploads/2026/10/neurips.pdf). Theorem 2.2 and Appendix E. Listed as forthcoming at NeurIPS 2026 at the search date; not used as an already-published DOI benchmark.
- **[R5]** H. Lam. *On the Impossibility of Statistically Improving Empirical Optimization: A Second-Order Stochastic Dominance Perspective*. Management Science 72(9):8215-8245, 2026. [DOI:10.1287/mnsc.2024.04482](https://doi.org/10.1287/mnsc.2024.04482); [author manuscript](https://arxiv.org/abs/2105.13419). Theorem 1 and Sections 3.3 and 4.3 of the inspected author manuscript.
- **[R6]** H. Yang and M. Yuan. *Geometry, Local Minimax Risk, and the Limits of Sample Average Approximation in Linear Stochastic Optimization*. [arXiv:2611.25007v1](https://arxiv.org/html/2611.25007v1), 18 November 2026. Local decision-risk statements and the distinction between population KL neighborhoods and particular robust formulations.
- **[R7]** L.-B. Fiechtner and J. Blanchet. *Distributionally Robust Regret Optimal LQR with Common Stage-Law Ambiguity*. [arXiv:2604.06158v3](https://arxiv.org/html/2604.06158v3), revised 23 September 2026. Sections 2-3; finite-horizon dynamics with common disturbance-law ambiguity.
- **[R8]** J. C. Duchi and H. Namkoong. *Variance-based Regularization with Convex Objectives*. Journal of Machine Learning Research 20(68):1-55, 2019. [Official full text](https://jmlr.org/papers/v20/17-750.html), particularly Theorem 10.
- **[R9]** J. Gotoh, M. J. Kim, and A. E. B. Lim. *Calibration of Distributionally Robust Empirical Optimization Models*. Operations Research 69(5):1630-1650, 2021. [DOI:10.1287/opre.2020.2041](https://doi.org/10.1287/opre.2020.2041). Published full text, Proposition 4, Theorem 3 and the calibration section.

- **[R10]** J. V. Burke and M. C. Ferris. *Weak Sharp Minima in Mathematical Programming*. SIAM Journal on Control and Optimization 31(5):1340-1359, 1993. [DOI:10.1137/0331063](https://doi.org/10.1137/0331063). Classical error-bound and convex supporting-hyperplane background.
