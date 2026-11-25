# Independent notes: the all-mechanism converse


Status: an independently derived written proof. This file proves the converse only. It does not assert that a matching construction, the complete paper, formalization, or final novelty/value review has passed.

## 1. Setup and the statement proved

Let \(\mathcal X\) be a fixed finite alphabet. Let \(P=(p_x)\) and \(Q=(q_x)\) have full support on \(\mathcal X\), and fix \(\varepsilon>0\). All logarithms are natural. Set

\[
 d(R,Q)=\operatorname{TV}(R,Q)
 =\frac12\sum_{x\in\mathcal X}|r_x-q_x|,
 \qquad D(R\Vert P)=\sum_x r_x\log\frac{r_x}{p_x},
\]

where \(0\log0=0\). An intermediate distribution \(R\) need not have full support.

A Markov kernel \(K\) with input space \(\mathcal X^n\) and an arbitrary measurable output space is \((\varepsilon,\delta_n)\)-DP under replacement adjacency if

\[
 K(x,S)\le e^{\varepsilon}K(x',S)+\delta_n
\]

for every measurable output event \(S\) and every pair of input vectors that differ in one coordinate. The condition holds for either ordering of the neighboring pair. Privacy is required on **every** input dataset, not only on a set of high probability.

A randomized e-variable is such a private kernel with nonnegative real output \(E\), satisfying \(\mathbb E_{P^n}E\le1\). Its e-power is \(\mathbb E_{Q^n}\log E\); the value \(-\infty\) is allowed. Write

\[
 V_n=\sup_{E\text{ a private e-variable}}\mathbb E_{Q^n}\log E.
\]

Suppose \(0<\delta_n<1/2\) and

\[
 \rho_n=-\frac1n\log\delta_n\longrightarrow\rho\in[0,\infty].
\]

The result proved below is

\[
 \boxed{\quad
 \limsup_{n\to\infty}\frac{V_n}{n}
 \le F_\rho(P,Q):=
 \inf_{\substack{R\in\mathcal P(\mathcal X)\\
                  \varepsilon d(R,Q)\le\rho}}
       \{D(R\Vert P)+\varepsilon d(R,Q)\}.
 \quad} \tag{1}
\]

At \(\rho=\infty\), the constraint is absent. At \(\rho=0\), it forces \(R=Q\), so the right side is \(D(Q\Vert P)\).

The output-KL representation and the pure-DP group-privacy/coupling route are existing ingredients. They should be attributed, in particular, to [Jacobsen et al., arXiv:2605.28952v2](https://arxiv.org/html/2605.28952v2). The additional work in this note is a uniform finite-sample treatment of the approximate-DP exceptional mass and its use across the exponential \(\delta_n\) regimes.

## 2. E-power equals the supremum of output KL

For a fixed kernel \(K\), put

\[
 A=Q^nK,\qquad B=P^nK,
 \qquad L_+=\log\max_{x\in\mathcal X}\frac{q_x}{p_x}.
\]

Full support implies \(A\) and \(B\) are mutually absolutely continuous. In fact, for every event \(S\),

\[
 \left(\min_x\frac{q_x}{p_x}\right)^n B(S)
 \le A(S)\le
 \left(\max_x\frac{q_x}{p_x}\right)^n B(S).
\]

Therefore a version \(f=dA/dB\) satisfies the corresponding two positive, finite bounds \(B\)-almost surely. In particular,

\[
 0\le D(A\Vert B)<\infty,\qquad
 \log f\le nL_+,\qquad L_+\ge0. \tag{2}
\]

The nonnegativity of \(L_+\) follows from \(\sum_xp_x(q_x/p_x)=1\).

Let \(e\) be a nonnegative measurable function of the output with \(\int e\,dB\le1\). Its positive log-part is \(A\)-integrable, since \(\log^+ e\le e\) and \(A\le e^{nL_+}B\). The expected logarithm is consequently defined, possibly as \(-\infty\). Jensen's inequality, in its extended form, gives

\[
 \int \log\frac{e}{f}\,dA
 \le\log\int\frac{e}{f}\,dA
 =\log\int e\,dB\le0.
\]

Thus

\[
 \sup_{e\ge0:\,\int e\,dB\le1}\int\log e\,dA
 =D(A\Vert B), \tag{3}
\]

with equality at \(e=f\). The equality case has \(\int f\,dB=1\), and postprocessing a DP output by \(f\) preserves DP. Values of \(f\) on a \(B\)-null set may be assigned arbitrarily: because every \(P^n\) input atom is positive, a \(B\)-null event is null under \(K(x,\cdot)\) for **every** input dataset \(x\).

Conversely, any randomized private e-variable itself is a private kernel, and (3) bounds its expected log output by that kernel's output KL. Hence the exact identity is

\[
 \boxed{\quad V_n=\sup_{K\text{ is }(\varepsilon,\delta_n)\text{-DP}}
           D(Q^nK\Vert P^nK).\quad} \tag{4}
\]

No common output alphabet or existence of a maximizing kernel is needed. Applying data processing to each kernel also yields the useful universal bound

\[
 0\le V_n\le nD(Q\Vert P). \tag{5}
\]

For completeness, data processing here follows directly from conditional Jensen: under the joint law with input \(P^n\), output \(K\), and input likelihood ratio \(Z=q^n(X)/p^n(X)\), the output likelihood ratio is \(\mathbb E[Z\mid\text{output}]\). Convexity of \(z\log z\) gives \(D(Q^nK\Vert P^nK)\le\mathbb E[Z\log Z]=nD(Q\Vert P)\). One may equivalently prove this using the finite-input log-sum inequality, without assuming the existence of regular conditional distributions on the output space.

## 3. A bounded-likelihood-ratio conversion lemma

### Lemma 1 (eventwise approximate domination controls KL)

Let \(A,B\) be probability measures, \(A\ll B\), and assume

\[
 f=\frac{dA}{dB}\le e^L\quad B\text{-a.s.}
\]

for some \(L\ge0\). Suppose \(a\in\mathbb R\), \(\tau\ge0\), and

\[
 A(S)\le e^aB(S)+\tau \quad\text{for all measurable }S. \tag{6}
\]

Then

\[
 D(A\Vert B)
 \le \min\{L,\;a+[1+(L-a)_+]\tau\}. \tag{7}
\]

In particular, if \(a\ge0\),

\[
 D(A\Vert B)\le a+(1+L)\tau. \tag{8}
\]

**Proof.** Taking \(S=\{f>e^a\}\) in (6) gives the hockey-stick bound

\[
 \int(f-e^a)_+\,dB\le\tau. \tag{9}
\]

For \(0\le f\le e^a\), \(f\log(f/e^a)\le0\). For \(e^a<f\le e^L\), write \(c=e^a\). Then

\[
\begin{aligned}
 f\log(f/c)
 &= (f-c)\log(f/c)+c\log(f/c)\\
 &\le (f-c)(L-a)+(f-c)\\
 &= (f-c)[1+(L-a)_+].
\end{aligned}
\]

The second line uses \(\log u\le u-1\); the case \(f>c\) can occur only when \(L>a\). Therefore the following scalar inequality holds throughout \(0\le f\le e^L\):

\[
 f\log(f/e^a)\le(f-e^a)_+[1+(L-a)_+].
\]

Integrating and using \(\int f\,dB=1\) proves the second entry of (7). The first follows from \(\log f\le L\). The negative part of \(f\log f\) is integrable because \(u\log u\ge-1/e\), so these integrals are legitimate. This proves the lemma. \(\square\)

**Why a likelihood-ratio cap is essential to this proof.** Condition (6) alone does not bound KL: an exceptional mass \(\tau\) could have an arbitrarily large likelihood ratio. In this problem, (2) supplies the cap uniformly over every output mechanism. The resulting cost divided by \(n\) is at most \((L_++1/n)\tau\), which vanishes as soon as \(\tau\to0\). No exponentially fast decay of \(\tau\) is needed for this conversion.

## 4. The finite-sample approximate domination inequality

For \(k\in\{0,\ldots,n\}\), define

\[
 G_\varepsilon(k)=\sum_{j=0}^{k-1}e^{j\varepsilon}
 =\frac{e^{\varepsilon k}-1}{e^\varepsilon-1},
 \qquad G_\varepsilon(0)=0. \tag{10}
\]

Iterating the one-record privacy inequality along a path of length \(d_H(x,y)\) gives

\[
 K(x,S)\le e^{\varepsilon d_H(x,y)}K(y,S)
            +\delta_nG_\varepsilon(d_H(x,y)). \tag{11}
\]

Both the exponential factor and \(G_\varepsilon\) are nondecreasing in the distance.

Fix an arbitrary intermediate law \(R\), let \(t=d(R,Q)\), and use a maximal coupling of one observation with marginals \(Q,R\). Take its \(n\)-fold product, denoted \(\pi\), with paired datasets \((X,Y)\). Then

\[
 X\sim Q^n,\qquad Y\sim R^n,\qquad
 H=d_H(X,Y)\sim\operatorname{Bin}(n,t). \tag{12}
\]

Define, for \(Y\) in the support of \(R^n\),

\[
 \ell_R(Y)=\log\frac{r^n(Y)}{p^n(Y)}
 =\sum_{i=1}^n\log\frac{r_{Y_i}}{p_{Y_i}}.
\]

For \(\eta>0\), let

\[
 T_{n,R,\eta}=\{y:\ r^n(y)>0,\ 
                 \ell_R(y)\le n[D(R\Vert P)+\eta]\},
 \qquad
 \beta_{n,R}(\eta)=R^n(T_{n,R,\eta}^{\mathsf c}). \tag{13}
\]

On this set the density of \(R^n\) with respect to \(P^n\) is bounded by \(e^{n[D(R\Vert P)+\eta]}\).

### Lemma 2 (finite-sample eventwise bound)

For every private \(K\), every \(R\), every \(\eta>0\), every integer \(0\le k\le n\), and every output event \(S\),

\[
 Q^nK(S)\le e^{a_{n,R,k,\eta}}P^nK(S)
                    +\tau_{n,R,k,\eta}, \tag{14}
\]

where

\[
 a_{n,R,k,\eta}=n[D(R\Vert P)+\eta]+\varepsilon k, \tag{15}
\]

\[
 \tau_{n,R,k,\eta}
 =\min\left\{1,\ 
    \Pr\{\operatorname{Bin}(n,t)>k\}
    +\beta_{n,R}(\eta)
    +\delta_nG_\varepsilon(k)\right\}. \tag{16}
\]

Crucially, \(a\) and \(\tau\) do not depend on \(K\) or \(S\).

**Proof.** Put \(C=\{H\le k,\ Y\in T_{n,R,\eta}\}\). From (11),

\[
\begin{aligned}
 Q^nK(S)
 &=\mathbb E_\pi K(X,S)\\
 &\le\mathbb E_\pi[1_CK(X,S)]+\pi(C^{\mathsf c})\\
 &\le e^{\varepsilon k}\mathbb E_\pi[1_CK(Y,S)]
       +\delta_nG_\varepsilon(k)\pi(C)+\pi(C^{\mathsf c})\\
 &\le e^{\varepsilon k}\mathbb E_{R^n}[1_{T_{n,R,\eta}}K(Y,S)]
       +\delta_nG_\varepsilon(k)
       +\Pr\{H>k\}+\beta_{n,R}(\eta)\\
 &\le e^{\varepsilon k+n[D(R\Vert P)+\eta]}P^nK(S)
       +\delta_nG_\varepsilon(k)
       +\Pr\{\operatorname{Bin}(n,t)>k\}+\beta_{n,R}(\eta).
\end{aligned}
\]

The expectation under \(R^n\) in the fourth line follows from the correct \(Y\) marginal and dropping \(1_{\{H\le k\}}\). It does **not** require conditional independence of \(X,Y\) or independence between the two good events. The last line uses the likelihood bound on \(T\). Finally, replacing the additive term by its minimum with 1 preserves the bound because the left side is a probability. \(\square\)

Combining Lemmas 1 and 2 with (2) and (5) gives the promised bound, uniform over the entire mechanism class:

\[
 \boxed{\quad
 \frac{V_n}{n}\le
 \min\left\{
 D(Q\Vert P),\ 
 D(R\Vert P)+\eta+\varepsilon\frac{k}{n}
 +\left[\frac1n+\left(L_+-D(R\Vert P)-\eta-
                    \varepsilon\frac{k}{n}\right)_+\right]
      \tau_{n,R,k,\eta}
 \right\}.
 \quad} \tag{17}
\]

A simpler, slightly weaker display is

\[
 \frac{V_n}{n}\le D(R\Vert P)+\eta+\varepsilon\frac{k}{n}
                    +(L_++1/n)\tau_{n,R,k,\eta}. \tag{18}
\]

### Optional explicit bounds on the two sampling tails

Let

\[
 b_R=\max_{x:r_x>0}\log(r_x/p_x)
       -\min_{x:r_x>0}\log(r_x/p_x).
\]

This is finite for each fixed \(R\). If \(b_R>0\), the bounded-variable exponential inequality gives

\[
 \beta_{n,R}(\eta)\le\exp(-2n\eta^2/b_R^2). \tag{19}
\]

If \(b_R=0\), then \(\ell_R(Y)=nD(R\Vert P)\) almost surely and \(\beta_{n,R}(\eta)=0\). Similarly, for \(k/n>t\),

\[
 \Pr\{\operatorname{Bin}(n,t)>k\}
 \le\exp[-2n(k/n-t)^2], \tag{20}
\]

and the exact tail is zero at \(k=n\). These explicit concentration bounds are optional: the weak law of large numbers suffices for the asymptotic argument. No uniformity of \(b_R\) over varying \(R\) is claimed or needed.

## 5. Positive finite privacy-failure exponent

Assume \(0<\rho<\infty\). Fix \(R\) satisfying the **strict** inequality

\[
 \varepsilon t<\rho,\qquad t=d(R,Q).
\]

Because \(Q\) has full support, \(t<1\) for every \(R\): at least one coordinate has positive mass under both \(R\) and \(Q\). Choose any number

\[
 t<s<\min\{1,\rho/\varepsilon\}
\]

and put \(k_n=\lceil ns\rceil\). It is enough to use this definition for sufficiently large \(n\), when \(k_n\le n\). For each fixed \(\eta>0\), both sampling tails in (16) tend to zero. Moreover,

\[
\begin{aligned}
 \delta_nG_\varepsilon(k_n)
 &\le\frac{\exp[-n\rho_n+\varepsilon k_n]}{e^\varepsilon-1}\\
 &\le\frac{e^\varepsilon}{e^\varepsilon-1}
               \exp[-n(\rho_n-\varepsilon s)]\longrightarrow0,
\end{aligned} \tag{21}
\]

because \(\rho_n\to\rho>\varepsilon s\). Thus \(\tau_{n,R,k_n,\eta}\to0\), and (18) yields

\[
 \limsup_n V_n/n\le D(R\Vert P)+\eta+\varepsilon s.
\]

First take \(\eta\downarrow0\), then \(s\downarrow t\). We have proved

\[
 \limsup_n V_n/n
 \le\inf_{R:\,\varepsilon d(R,Q)<\rho}
          [D(R\Vert P)+\varepsilon d(R,Q)]. \tag{22}
\]

There is no interchange between a supremum over mechanisms and a nonuniform limiting argument: the bound (18) is already simultaneous for every mechanism at each \(n\), and the chosen \(R,s,\eta\) are fixed while \(n\to\infty\).

### Why the final infimum is over the closed ball

Set \(g(R)=D(R\Vert P)+\varepsilon d(R,Q)\). This is continuous on the entire finite-dimensional probability simplex, including zero coordinates, because \(P\) is strictly positive and \(u\log u\to0\) as \(u\downarrow0\).

For every \(R\) in the closed ball \(\varepsilon d(R,Q)\le\rho\), put

\[
 R_\lambda=(1-\lambda)R+\lambda Q,\qquad 0<\lambda<1.
\]

Homogeneity of the \(\ell_1\) norm gives

\[
 d(R_\lambda,Q)=(1-\lambda)d(R,Q).
\]

Since \(\rho>0\), \(R_\lambda\) belongs to the strict ball (also when \(R=Q\)), and \(g(R_\lambda)\to g(R)\) as \(\lambda\downarrow0\). Therefore

\[
 \inf_{\varepsilon d(R,Q)<\rho}g(R)
 =\min_{\varepsilon d(R,Q)\le\rho}g(R). \tag{23}
\]

The minimum exists by compactness. Equations (22)-(23) prove (1) for positive finite \(\rho\). We never apply (21) at the equality \(\varepsilon t=\rho\); that would generally be unjustified because \(\delta_ne^{\varepsilon nt}\) need not vanish there.

## 6. Endpoint \(\rho=0\)

The only feasible distribution on the right side of (1) is \(R=Q\). Bound (5) immediately gives

\[
 \limsup_n V_n/n\le D(Q\Vert P)=F_0(P,Q). \tag{24}
\]

This argument uses no assumption that \(\delta_n\to0\). In particular it covers constant, polynomially decaying, and otherwise subexponentially decaying \(\delta_n\), as long as the stated limit is zero. It proves only the upper bound; obtaining equality still requires a private attaining construction. The subexponential lossless endpoint itself has prior construction-based antecedents in [Csillag and Mesquita, PMLR 300](https://proceedings.mlr.press/v300/csillag26a.html), Proposition 3.3 and Appendix B.1, and must not be advertised as a standalone new result.

One can also derive (24) directly from Lemma 2 using \(R=Q\) and \(k=0\), because the maximal coupling has \(H=0\) almost surely and the group-privacy error vanishes identically. Data processing is simpler.

## 7. Endpoint \(\rho=\infty\)

Now fix any distribution \(R\), choose any \(s\in(d(R,Q),1)\), and again take \(k_n=\lceil ns\rceil\). Both sampling tails vanish for fixed \(\eta>0\), while

\[
 \delta_nG_\varepsilon(k_n)
 \le \frac{e^\varepsilon}{e^\varepsilon-1}
          \exp[-n(\rho_n-\varepsilon s)]\longrightarrow0
\]

because \(\rho_n\to\infty\). The same order of limits gives

\[
 \limsup_n V_n/n\le D(R\Vert P)+\varepsilon d(R,Q).
\]

Since \(R\) was arbitrary,

\[
 \limsup_n V_n/n\le\min_R[D(R\Vert P)+\varepsilon d(R,Q)]. \tag{25}
\]

This recovers the pure-DP variational upper bound for superexponentially small but positive \(\delta_n\). If one extends the setup to \(\delta_n=0\), the same finite-sample argument works with its last error term identically zero; no separate limit definition is required.

## 8. Degenerate cases and exact scope

- If \(P=Q\), then (5) gives \(V_n=0\) for every \(n\), and all the variational expressions equal zero by choosing \(R=P=Q\). The constant e-variable 1 attains the value.
- A one-symbol alphabet is included in the preceding case. No division by a zero concentration range is required: the convention following (19) makes the relevant tail exactly zero.
- The intermediate \(R\) may have zero coordinates. All likelihood sums are evaluated on its support, and the continuous extension of KL at zero handles the boundary of the simplex.
- Fixed \(\varepsilon>0\) is essential to the claimed scaling and to (21). This note does not claim a result at \(\varepsilon=0\) or for an \(n\)-dependent \(\varepsilon_n\).
- The rate \(\rho\) controls only the exponential scale. No convergence of a subexponential prefactor in \(\delta_n\) is required.
- The finite-alphabet likelihood-ratio bound is used to turn a vanishing exceptional probability into a negligible normalized KL cost. Extending the statement beyond this bounded likelihood-ratio setting needs a separate uniform-integrability argument or other control.
- This is a fixed-sample statement for e-variables. It does not establish validity of an e-process, joint privacy of an entire sequential transcript, or validity under arbitrary stopping.

## 9. Proof audit: possible failure points and their resolution

1. **Exceptional mass and KL:** invoking approximate max-divergence alone is insufficient. Lemma 1 explicitly uses the cap \(d(Q^nK)/d(P^nK)\le e^{nL_+}\), supplied by the input full-support condition.
2. **Wrong coupling marginal:** after discarding the distance indicator, the remaining integral is with respect to \(R^n\), because \(Y\) has that marginal. The two good events are not assumed independent.
3. **Group privacy at equality:** the argument only uses \(\varepsilon t<\rho\); equality is obtained by continuity in \(R\). Neither \(\rho_n\ge\rho\) nor a favorable prefactor for \(\delta_n\) is assumed.
4. **Mechanism-dependent convergence:** all error terms in (16) are independent of the mechanism, so the same bound applies to a changing near-optimal kernel \(K_n\) and to the supremum \(V_n\).
5. **Boundary distributions \(R\):** \(\log(r_x/p_x)\) is finite on the support of fixed \(R\). A law of large numbers is available there, even if \(R\) is not fully supported.
6. **Zero or unbounded e-values:** the e-power variational identity uses the extended expectation carefully; its positive part is integrable by the likelihood-ratio cap. The likelihood-ratio maximizer is positive and bounded.
7. **Output measurability:** all events used in Lemma 1 are measurable level sets of an RN derivative. The finite-input proof of data processing avoids any unneeded regular-conditional-probability assumption on the output space.
8. **Residual limitation:** this note contains no achievability proof. In particular, it does not verify a truncated-noise channel's eventwise privacy or its output likelihood asymptotics. A matching lower bound must be independently checked before stating an equality theorem.

Within the stated assumptions, no unresolved gap in the converse has been identified by its author. Independent review is still required; the capped-likelihood-ratio conversion, closed-ball passage, and interchange with the mechanism supremum are the recommended audit targets.
