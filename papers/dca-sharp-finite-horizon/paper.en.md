# Sharp Finite-Horizon Descent for the Difference-of-Convex Algorithm

**25 November 2026 — Research draft.** AI-assisted research manuscript; not externally peer reviewed. 

## Abstract

The sharp finite-horizon step-residual bounds conjectured for the difference-of-convex algorithm require more than the known sharp analysis of gradient descent: an arbitrary convex remainder in the first component introduces additional subgradient terms. We give an explicit certificate transfer identity that accounts for those terms. The distance-two gradient-descent certificate transfers with nonnegative convex-support weights at every horizon. One terminal branch requires a four-edge change in the support flow and completion of a square in the actual composite residual. These constructions yield the proposed coefficients in both the convex and nonconvex regimes, including nonsmooth first components. In the convex case the bound holds for the final step itself. Sharpness is treated with explicit one-dimensional convex examples and a finite interpolation construction in the nonconvex case. Numerical performance-estimation and symbolic identities are reproducibility checks; the all-parameter proof is analytic. The globally concave branch of the source conjecture is outside the scope of this work.

## 1. Problem, scope, and prior work

Let $f_1$ be proper, closed, and $\mu_1$-strongly convex on a finite-dimensional Euclidean space, with $\mu_1>0$. Let $f_2$ be differentiable with curvature in $[\mu_2,L_2]$, where 

$$
-\mu_1<\mu_2<0,\qquad \max\{0,-\mu_2\}<L_2<\infty.
$$

 Here curvature means that $f_2-\mu_2\lVert x\rVert^2/2$ is convex and has $(L_2-\mu_2)$-Lipschitz gradient. Set $F=f_1-f_2$ and consider the genuine DCA updates 

$$
\nabla f_2(x_k)\in\partial f_1(x_{k+1}),\qquad k=0,\ldots,N.
 
\tag{1}
$$

 We take $F(x_0)<\infty$. If the initial value is infinite, the proposed descent bound has only the trivial extended-value interpretation. The sharpness class requires $F$ bounded below. The upper-bound proofs do not need this extra assumption. No upper curvature restriction on $f_1$ is used; in particular it may be nonsmooth or extended valued.

Put 

$$
e=\frac{L_2}{\mu_1},\quad r=\frac{\mu_2}{\mu_1},\quad
 E_j(t)=\sum_{\ell=1}^{2j}t^{-\ell},\quad E_0(t)=0,
 \quad T_j=E_j(e)-E_j(r).
 
\tag{2}
$$

 In particular $e>-r>0$ and $-1<r<0$. The sum definition covers $e=1$ without a limiting convention: $E_j(1)=2j$. Define, for $e>1$, 

$$
P_N(e,r)=\frac{(1+e)(1+r)}{e+r}
 \left[N+\frac{(1-e)(1-r)}{e-r}\sum_{j=0}^N[T_j]_+\right].
 
\tag{3}
$$

 The coefficient under investigation is 

$$
C_N(e,r)=1+r+
 \begin{cases}
 \min\{E_N(e),E_N(r)\},&0<e\leq1,\\
 \min\{P_N(e,r),E_N(r)\},&e>1.
 \end{cases}
 
\tag{4}
$$

The original conjecture is Rotaru–Patrinos–Glineur [$$1, Conjecture 1, equations (9)–(10)$$](https://arxiv.org/abs/2506.01791); it remains stated as Conjecture 4.3.1 in Rotaru’s 2026 dissertation [$$3$$](https://research.dial.uclouvain.be/entities/publication/3e832c83-0778-4645-bf0b-fcbcd428989d). Its one-step regimes and substantial convex subdomains were already proved there. The sharp gradient-descent coefficients, phase sequence, distance-two multipliers, and nonconvex gradient-descent interpolation construction are prior results of Rotaru–Glineur–Patrinos [$$2$$](https://arxiv.org/abs/2406.17506). The DCA–proximal-gradient equivalence is also prior work [$$1$$](https://arxiv.org/abs/2506.01791), [$$4$$](https://proceedings.mlr.press/v258/rotaru25a.html). We do not claim any of these ingredients as new.

The remaining issue is the transfer to an arbitrary convex remainder in $f_1$, together with exact attainment for the final objective value $F(x_{N+1})$. Replacing this objective value by an unknown global minimum would change the problem. Our new algebra concerns this transfer, its nonnegative support weights, the terminal repair, and the terminal modification needed in the nonconvex attaining example. All novelty statements are limited to the cited sources and the recorded searches.

**Theorem 1.1** (Finite-horizon bound). For every $N\geq1$ and every trajectory (1), 

$$
F(x_0)-F(x_{N+1})\geq
 \frac{\mu_1}{2}C_N(e,r)
 \min_{0\leq j\leq N}\lVert x_j-x_{j+1}\rVert^2.
 
\tag{5}
$$

 If $e\leq1$, the minimum can be replaced by $\lVert x_N-x_{N+1}\rVert^2$. The coefficients are optimal over the stated bounded-below problem class; the construction establishing this last assertion is given in Section 7 and in the convex sharpness examples below.

## 2. An exact certificate transfer

Normalize $\mu_1=1$ by dividing both components by $\mu_1$. Write 

$$
f_1(x)=\tfrac12\lVert x\rVert^2+h(x),\qquad a=e-r,
 \qquad d_j=x_j-x_{j+1},\qquad
 s_j=\nabla f_2(x_j)-x_{j+1}\in\partial h(x_{j+1}).
$$

 The function $h$ is proper closed convex. Every point used below has finite $h$. Introduce the nonnegative interpolation and support slacks 

$$
\begin{aligned}
 Q_{ij}&=f_{2,i}-f_{2,j}-\langle x_{j+1}+s_j,x_i-x_j\rangle
   -\tfrac r2\lVert x_i-x_j\rVert^2\notag\\
 &\hspace{18mm}
   -\frac{\lVert x_{i+1}-x_{j+1}+s_i-s_j-r(x_i-x_j)\rVert^2}{2a},
   \\
 H_{ij}&=h_i-h_j-\langle s_{j-1},x_i-x_j\rangle,\qquad j\geq1.
   
\end{aligned}\tag{6–7}
$$

 The first is the smooth convex interpolation inequality applied to $f_2-r\lVert x\rVert^2/2$; the second is the subgradient inequality. The finite-data sufficiency of the same interpolation conditions is used only in the sharpness construction, not in the upper bound.

For the quadratic special case $h=0$, put $\phi=\lVert x\rVert^2/2-f_2$. Its gradient at $x_j$ equals $d_j$. Let $W_{ij}\geq0$ be GD-directed interpolation multipliers and suppose their algebraic identity is 

$$
\sum_i\gamma_i\phi_i-K(d)=\sum_{i,j}W_{ij}Q^\phi_{ij}.
$$

 The direction reverses under complementation: $\lambda_{ij}=W_{ji}$ is the appropriate multiplier of $Q_{ij}$. Set $M_{ti}=\lambda_{ti}+\lambda_{it}$ and define the formal point vector 

$$
B_t=\sum_i\lambda_{it}(x_i-x_t)
 +\frac1a\sum_iM_{ti}
    \big[x_{t+1}-x_{i+1}-r(x_t-x_i)\big].
 
\tag{8}
$$

 If $B_t=\sum_i b_{ti}x_i$, set $\alpha_{i,t+1}=-b_{ti}$ for $i\neq t+1$ and set the diagonal to zero.

**Lemma 2.1** (Transfer identity). For these coefficients one has the exact identity 

$$
\sum_i\gamma_i F_i-K(d)=
 \sum_{i,j}\lambda_{ij}Q_{ij}
 +\sum_{i,j}\alpha_{ij}H_{ij}
 +\frac1{2a}\sum_{i,j}\lambda_{ij}\lVert s_i-s_j\rVert^2.
 
\tag{9}
$$

 Thus a certificate transfers whenever every $\alpha_{ij}$ is nonnegative.

*Proof.* The coefficients in each $B_t$ sum to zero. Expanding the dependence on $s$ in the leftmost interpolation sum gives the mixed term $-\sum_t\langle s_t,B_t\rangle$ and the negative of the last term of (9). The mixed term of $\sum\alpha H$ is $+\sum_t\langle s_t,B_t\rangle$, so these cancel. Summing (8) over $t$ cancels its symmetric $M$ terms and gives $\sum_t B_t=-\sum_i\gamma_i x_i$. Consequently the outgoing-minus-incoming value flow of $\alpha$ equals $\gamma$, including the extra final point, whose flow is zero. The remaining identity is exactly the GD quadratic identity. ◻

This criterion is sufficient, not a claim that every GD certificate automatically transfers. In fact the first terminal attempt in the positive-curvature branch has a negative support weight. Repairing it will use a square that the GD proof would otherwise discard.

## 3. The distance-two certificate for arbitrary convex remainders

For $i=0,\ldots,k-1$, the published GD distance-two kernel [$$2, Lemma 4.9$$](https://arxiv.org/abs/2406.17506) uses 

$$
\begin{aligned}
 A_i&=1-rE_{i+1}(r)+\frac{(1-e)T_i-e(1+r)T_{i+1}}{2a},\notag\\
 B_i&=-rE_{i+1}(r)+\frac{(1+r)T_i+r(1-e)T_{i+1}}{2a},\notag\\
 C_i&=\frac{eT_{i+1}}{2a},\qquad D_i=-\frac{rT_{i+1}}{2a}
 
\end{aligned}\tag{10}
$$

 on the directed pairs $(i,i+1),(i+1,i),(i,i+2),(i+2,i)$. When $T_1,\ldots,T_k\geq0$, all four weights are nonnegative; their nonnegativity and their GD identity are the cited kernel result. We now prove the extra signs needed for DCA.

Write $T=T_i$, $U=T_{i+1}$. The six nonzero support contributions of one kernel under Lemma 2.1 are 

$$
\begin{array}{c|l}
\text{edge}&\text{weight}\\\hline
(i,i+1)&[2a+(1-e-r)T+erU]/(2a)=:a_i\\
(i+2,i+1)&[2a+(2-e-r)T-(e^2+e+r^2+r)U]/[2a(e+r)]=:b_i\\
(i+3,i+1)&U/(2a)\\
(i,i+2)&-(T+erU)/(2a)\\
(i+1,i+2)&B_i+(1+r)(A_i+B_i)/a\\
(i+1,i+3)&U/(2a).
\end{array}

\tag{11}
$$

 For each interior $(i,i+2)$ edge the negative $-T_i/(2a)$ cancels the previous kernel’s positive $T_i/(2a)$. What remains is $-erT_{i+1}/(2a)\geq0$, together with the final unpaired $T_k/(2a)\geq0$. Also 

$$
a_i=\frac12+\frac{e+r}{2a}
         \big(e^{-2i-1}-r^{-2i-1}\big)>0.
$$

 The only remaining nontrivial sign is $b_i>0$.

**Lemma 3.1** (Reverse-edge positivity). For every $i\geq0$ and every $0<-r<\min\{1,e\}$, the number $b_i$ in (11) is strictly positive. This does not require $T_i\geq0$.

*Proof.* Put $q=-r$, $A=E_i(e)$ and $B=E_i(-q)$. Substitution of the recurrence $E_{i+1}(t)=(E_i(t)+1+t)/t^2$ gives 

$$
b_i=b+c_AA+c_BB,
$$

 where 

$$
\begin{aligned}
 b&=\frac{e^2(1-q)+eq^2-eq+e+q^2-q}{2e^2q^2},\\
 c_A&=-\frac{e^2-e-q+1}{2e^2(e+q)},\qquad
 c_B=\frac{e+q^2+q+1}{2q^2(e+q)}>0.
\end{aligned}
$$

 The numerator of $b$, after setting $e=q+t$ with $t>0$, is $(1-q)t^2+(-q^2+q+1)t+q^2$, so $b>0$. Pairing reciprocal powers yields 

$$
B=(1-q)\sum_{j=1}^i q^{-2j}
 \geq\frac{1-q}{1+e}A.
$$

 Hence $b_i\geq b+RA$, where 

$$
R=\frac{n(e,q)}{2e^2q^2(e+1)},\qquad
 n(e,q)=-(q^2+q-1)e^2+(q^2-q+1)e+q^2-q.
$$

 If $q<e\leq1$, put $z=(e-q)/(1-q)$. The polynomial has the exact Bernstein representation 

$$
n(e,q)=n_0(1-z)^2+2n_1z(1-z)+n_2z^2,
$$

 with positive coefficients $n_0=q^2(1-q^2)$, $n_1=(1-q)(q^2+q+1)/2$, $n_2=(1-q)(2-q)$. Thus $R>0$. If $e>1$ and $R\geq0$ the conclusion is immediate. If $e>1$ and $R<0$, use $0\leq A\leq1/(e-1)$ to obtain 

$$
b_i\geq b+\frac{R}{e-1}
  =\frac{(e-q)(e+1-eq)}{2q^2(e^2-1)}>0.
$$

 ◻

Combining these signs with the transfer identity and the published telescoping GD identity proves the following.

**Lemma 3.2** (DCA distance-two identity bound). If $T_1,\ldots,T_k\geq0$, then 

$$
\begin{aligned}
 F_0-F_k+\frac{(e+r)T_k}{2a}(F_k-F_{k+1})
 &\geq\frac{E_k(e)+E_k(r)}4\lVert d_k\rVert^2\notag\\
 &\quad+\frac{T_k}{2a}
 \left[\frac{er}2\lVert d_k\rVert^2+\langle d_k,d_{k+1}\rangle
                  +\frac12\lVert d_{k+1}\rVert^2\right].
 
\end{aligned}\tag{12}
$$

 The certificate uses points $x_0,\ldots,x_{k+2}$, hence $k+2$ DCA updates. In a trajectory of $N+1$ updates we use it only with $k\leq N-1$. For $k=0$ the empty prefix is an identity.

## 4. Terminal certificates

The lifted distance-two identity must be completed by a terminal certificate. This step requires care: a nonnegative gradient-descent certificate can produce a negative convex-support multiplier after the transfer. We first treat the terminal branch that transfers directly, and then repair the branch for which this obstruction occurs.

Throughout this section, set 

$$
a=e-r,\qquad T_j=E_j(e)-E_j(r),\qquad
 G_{j+1}=d_{j+1}+s_j-s_{j+1}.
$$

 Thus $G_{j+1}$ is the actual composite residual at $x_{j+1}$; it is generally different from the step $d_{j+1}$. We retain the nonnegative interpolation slacks $Q_{ij},H_{ij}$ and the residual quadratic form supplied by the transfer identity.

### 4.1. Data at the end of a distance-two prefix

Let $k\geq1$, and assume $T_1,\ldots,T_k\geq0$. Write $\alpha^{\mathrm{pre}}$ for the support multipliers of the lifted distance-two prefix, and retain $A_i,B_i,C_i,D_i$ for the four published GD multipliers in that prefix. The transfer formula gives 

$$
\begin{aligned}
 \alpha^{\mathrm{pre}}_{k,k+2}&=\frac{T_k}{2a},
 &\alpha^{\mathrm{pre}}_{k+1,k+2}
  &=\alpha^{\mathrm{pre}}_{k+2,k+1}=0,\\
 \alpha^{\mathrm{pre}}_{k,k+1}
  &=B_{k-1}+\frac{1+r}{a}(A_{k-1}+B_{k-1}).
\end{aligned}\tag{13–14}
$$

If the final GD-directed pair $(k,k+1),(k+1,k)$ is assigned multipliers $u,v$, respectively, its contribution to the support multipliers is 

$$
\begin{array}{c|c}
\text{support edge}&\text{increment}\\ \hline
(k,k+1)&u+r(u+v)/a\\
(k+2,k+1)&(u+v)/a\\
(k,k+2)&-v-r(u+v)/a\\
(k+1,k+2)&v+(1+r)(u+v)/a.
\end{array}

\tag{15}
$$

 Its additional residual quadratic form is $(u+v)\lVert s_k-s_{k+1}\rVert^2/(2a)$. These are coefficient identities obtained by expanding the transfer formula; they use no smoothness of $h$. For $k=0$ the prefix is empty, $T_0=0$, and all of its support multipliers are zero. The same terminal-increment formula applies.

### 4.2. The negative-curvature terminal branch

**Lemma 4.1** (Transfer of the $r$ terminal certificate). Suppose $-1<r<0$, $e>-r$, $k\geq0$, and $T_1,\ldots,T_{k+1}\geq0$. Then every DCA trajectory satisfies 

$$
F_0-F_{k+1}\geq
 \frac{E_{k+1}(r)}2\lVert d_{k+1}\rVert^2
 +\frac{e^2T_{k+1}}{2a^2}
       \lVert d_{k+1}-r d_k\rVert^2.

\tag{16}
$$

 The statement includes $e>1$.

*Proof.* Put $U=E_{k+1}(r)$ and $C=e^2T_{k+1}/a^2$. Complete the distance-two prefix with the GD multipliers 

$$
u=1-rU+\frac{(1-e)T_k}{2a},\qquad
 v=-rU+\frac{(1+r)T_k}{2a}.

\tag{17}
$$

 These are the terminal multipliers of the known GD certificate. They are nonnegative. For $u$, a useful expression valid also when $e>1$ is 

$$
u=\frac{1+(-r)r^{-2(k+1)}}{2(1-r)}
   +e\frac{e e^{-2(k+1)}+(-r)r^{-2(k+1)}}{2(e-r)}>0.
$$

 The nonnegativity of $v$ follows directly from $T_k\geq0$.

After transfer, three terminal support multipliers are 

$$
\alpha_{k,k+2}=-rC,\qquad
 \alpha_{k+2,k+1}=\frac{u+v}{a},\qquad
 \alpha_{k+1,k+2}=v+\frac{1+r}{a}(u+v),
$$

 and are nonnegative. The remaining one is 

$$
\alpha_{k,k+1}
 =\alpha^{\mathrm{pre}}_{k,k+1}
  +1+\frac{(1-e-r)T_k}{2a}+rC.

\tag{18}
$$

 It is necessary to check this total coefficient: its increment can be negative for long horizons.

If $k=0$, the prefix is empty and this coefficient reduces directly to 

$$
\alpha_{0,1}=1+rC
 =\frac{e+t^2-t}{t(e+t)}>0,\qquad t=-r.
$$

 This proves the required sign without invoking any earlier-horizon statement. The remaining argument treats $k\geq1$.

For that check, write $t=-r\in(0,1)$, so $e>t$, and set $A=E_k(e)$, $B=E_k(-t)$. Substituting $T_{k-1}=e^2A-t^2B-(e+t)$ into (14) and (18) gives 

$$
\alpha_{k,k+1}=c_AA+c_BB+c_0,
$$

 where 

$$
\begin{aligned}
 c_A&=-\frac{e^2t-e^2+et^2-2et-t^2+2t}{2(e+t)^2},\\
 c_B&=\frac{e^2t^2+e^2t+2e^2+et^3+2et^2+t^3}
              {2t(e+t)^2}>0,\\
 c_0&=\frac{e+t^2-t}{t(e+t)}>0.
\end{aligned}
$$

 The paired geometric sums satisfy 

$$
B=(1-t)\sum_{j=1}^k t^{-2j}
 \geq\frac{1-t}{1+e}A.

\tag{19}
$$

 Consequently, 

$$
c_AA+c_BB\geq
 \frac{n(e,t)}{2t(e+1)(e+t)}A,
$$

 where 

$$
n(e,t)=e^2t(1-t)-et^3+2e-t^3+2t^2-2t.
$$

 For $e\geq t$, 

$$
\partial_e n(e,t)=2et(1-t)-t^3+2>0,
 \qquad n(t,t)=2t^2(1-t^2)>0.
$$

 Thus (18) is positive. All support multipliers are therefore nonnegative. The transfer identity retains the same GD square $C\lVert d_{k+1}-r d_k\rVert^2/2$ and adds a nonnegative residual quadratic form. Discarding the remaining interpolation slacks proves (16). ◻

### 4.3. Repair of the positive-curvature terminal square

**Lemma 4.2** (Transfer at the $e$ transition). Suppose $0<e\leq1$, $-e<r<0$, $k\geq0$, $T_1,\ldots,T_k\geq0$, and $T_{k+1}<0$. Then 

$$
F_0-F_{k+1}\geq
 \frac{E_{k+1}(e)}2\lVert d_{k+1}\rVert^2.

\tag{20}
$$

*Proof.* Set 

$$
U=E_{k+1}(e),\qquad
 C=-\frac{r^2T_{k+1}}{a^2}>0,\qquad
 K=U-\frac{T_k}{2a}.
$$

 The GD terminal pair can be written as 

$$
u=eU-\frac{(1+e)T_k}{2a},\qquad
 v=-1+eU-\frac{(1-r)T_k}{2a}.

\tag{21}
$$

 Both multipliers are positive. Indeed, if $A=E_k(e)$ and $B=E_k(r)$, then $U=(A+1+e)/e^2$ and 

$$
\begin{aligned}
 u&=\frac{1+e}{e}
    +\frac{e(1-e)-2r}{2ae}A+\frac{1+e}{2a}B,\\
 v&=\frac1e
    +\frac{e(1+r)-2r}{2ae}A+\frac{1-r}{2a}B.
\end{aligned}
$$

The GD certificate contains the square $C\lVert d_{k+1}-e d_k\rVert^2/2$. Complete cancellation of its additional cross terms, however, produces the support coefficient $\alpha_{k,k+2}=-eC<0$. We therefore modify the support flow: 

$$
\begin{aligned}
 \alpha_{k,k+2}&\leftarrow\alpha_{k,k+2}+eC,&
 \alpha_{k,k+1}&\leftarrow\alpha_{k,k+1}-eC,\\
 \alpha_{k+1,k+2}&\leftarrow\alpha_{k+1,k+2}-(1+e)C,&
 \alpha_{k+2,k+1}&\leftarrow\alpha_{k+2,k+1}-C.
\end{aligned}

\tag{22}
$$

The identities 

$$
\begin{aligned}
 H_{k,k+2}-H_{k,k+1}-H_{k+1,k+2}
   &=\langle s_k-s_{k+1},d_k\rangle,\\
 H_{k+1,k+2}+H_{k+2,k+1}
   &=\langle s_k-s_{k+1},d_{k+1}\rangle
\end{aligned}
$$

 show that the remaining cross term is $C\langle s_k-s_{k+1},d_{k+1}-e d_k\rangle$. It is absorbed by 

$$
\begin{aligned}
 &\frac C2\lVert d_{k+1}-e d_k\rVert^2
  +C\langle s_k-s_{k+1},d_{k+1}-e d_k\rangle\notag\\
 &\hspace{1cm}=
  \frac C2\lVert G_{k+1}-e d_k\rVert^2
  -\frac C2\lVert s_k-s_{k+1}\rVert^2.

\end{aligned}\tag{23}
$$

 The cost in the second term is paid by the residual quadratic form, since $(u+v)/a-C=K$.

After (22), the terminal changes relative to the prefix are exactly 

$$
\begin{aligned}
 \alpha_{k,k+2}&=0,\\
 \alpha_{k,k+1}&=\alpha^{\mathrm{pre}}_{k,k+1}
                   +1+\frac{(1-e-r)T_k}{2a},\\
 \alpha_{k+1,k+2}&=U,\qquad
 \alpha_{k+2,k+1}=K.
\end{aligned}
$$

 They are nonnegative. In particular, $1-e-r>0$, and 

$$
K=\frac{A+1+e}{e^2}-\frac{A-B}{2a}>0
$$

 because $2a-e^2>0$. All other prefix support coefficients are unchanged. When $k=0$, the prefix is empty and these coefficients are simply $\alpha_{0,1}=1$, $\alpha_{1,2}=U$, $\alpha_{2,1}=U$, with $K=U$; hence the same proof includes the first terminal transition. The retained residual is the nonnegative prefix quadratic form plus 

$$
\frac K2\lVert s_k-s_{k+1}\rVert^2
 +\frac C2\lVert G_{k+1}-e d_k\rVert^2.
$$

 Discarding these terms and the interpolation slacks gives (20). ◻

### 4.4. A local tail certificate

The following local inequality is already present in the proof of Theorem 2 of the source DCA paper. We give its complete interpolation identity so that the ensuing argument does not depend on a limiting interpretation of a finite smoothness constant for $f_1$.

**Lemma 4.3** (Local $e$ tail). Put $U=E_{i+1}(e)$ and $C_i=((e+r)U-1)/a$. If $C_i\geq0$, then 

$$
\begin{aligned}
 F_i-F_{i+1}\geq{}&
 -\frac{E_i(e)}2\lVert d_i\rVert^2
 +\frac U2\lVert d_{i+1}\rVert^2\notag\\
 &+\frac U2\lVert s_i-s_{i+1}\rVert^2
 +\frac{C_i}{2}\lVert G_{i+1}-e d_i\rVert^2.

\end{aligned}\tag{24}
$$

*Proof.* The recurrence $E_i(e)=e^2U-1-e$ gives the exact identity 

$$
\begin{aligned}
 &F_i-F_{i+1}+\frac{E_i(e)}2\lVert d_i\rVert^2
               -\frac U2\lVert d_{i+1}\rVert^2\notag\\
 &\quad=eU\,Q_{i+1,i}+(eU-1)Q_{i,i+1}+H_{i,i+1}
         +U H_{i+1,i+2}+U H_{i+2,i+1}\notag\\
 &\qquad\quad+\frac U2\lVert s_i-s_{i+1}\rVert^2
         +\frac{C_i}{2}\lVert G_{i+1}-e d_i\rVert^2.

\end{aligned}\tag{25}
$$

 It follows either by expansion or by the four-flow repair applied to the single GD pair with multipliers $eU,eU-1$. Since $eU-1\geq1/e>0$, every coefficient on the right is nonnegative. Dropping its interpolation slacks proves the claim. ◻

## 5. A sharp last-step bound for convex objectives

We now obtain one statement covering both the previously unresolved convex domain and its earlier established part. The conclusion is stronger than the conjectured bound on the smallest step: it controls the final step with the same sharp constant.

**Theorem 5.1** (Sharp convex last-step bound). Let $f_1(x)=\lVert x\rVert^2/2+h(x)$, with $h$ proper closed convex, and let $f_2\in\mathcal F_{r,e}$. Suppose 

$$
0<e\leq1,\qquad -e<r<0.
$$

 For $N\geq1$, every well-defined DCA trajectory of $N+1$ updates satisfies 

$$
\frac12\lVert x_N-x_{N+1}\rVert^2
 \leq\frac{F(x_0)-F(x_{N+1})}
 {1+r+\min\{E_N(e),E_N(r)\}}.

\tag{26}
$$

 The coefficient is sharp in dimension one, both for the last step and for the smallest step among indices $0,\ldots,N$.

*Proof of the upper bound.* The ratio 

$$
\frac{E_j(r)}{E_j(e)}
 =\frac{1+r}{1+e}
  \frac{\sum_{\ell=1}^j |r|^{-2\ell}}
       {\sum_{\ell=1}^j e^{-2\ell}}
$$

 is strictly increasing in $j$: the fraction is a weighted average of the increasing term ratios $(e/|r|)^{2\ell}$. Thus the sequence $T_j$ has at most one transition from nonnegative to negative values.

If $T_N\geq0$, Lemma 4.1 with $k=N-1$ gives 

$$
F_0-F_N\geq\frac{E_N(r)}2\lVert d_N\rVert^2.
$$

 If $T_N<0$, let $k\in\{0,\ldots,N-1\}$ be the last index with $T_k\geq0$. Lemma 4.2 gives 

$$
F_0-F_{k+1}\geq\frac{E_{k+1}(e)}2\lVert d_{k+1}\rVert^2.
$$

 The identity 

$$
T_i-r^2T_{i+1}
 =a\big[(e+r)E_{i+1}(e)-1\big]

\tag{27}
$$

 shows that $C_k>0$. Since $E_i(e)$ increases with $i$, $C_i>0$ for every $i\geq k$. Apply Lemma 4.3 for $i=k+1,\ldots,N-1$ and telescope. This yields 

$$
F_0-F_N\geq\frac{E_N(e)}2\lVert d_N\rVert^2.
$$

 In either case, 

$$
F_0-F_N\geq\frac{\min\{E_N(e),E_N(r)\}}2
                  \lVert d_N\rVert^2.
$$

 Finally, the one-step descent estimate $F_N-F_{N+1}\geq(1+r)\lVert d_N\rVert^2/2$ proves (26). ◻

This argument includes $N=1$ through the empty-prefix terminal certificates; it does not rely on a cited base case. The previously established complementary parameter domains complete the remaining cases of the original convex conjecture. Returning to unnormalized functions multiplies the left side of (26) by $\mu_1$ and substitutes $e=L_2/\mu_1$, $r=\mu_2/\mu_1$.

### 5.1. Globally admissible examples attaining equality

*Proof of sharpness.* For the $e$ branch, take $f_1(x)=x^2/2$ and 

$$
f_2(x)=
 \begin{cases}
  e x^2/2-x,&x\geq0,\\
  r x^2/2-x,&x\leq0.
 \end{cases}

\tag{28}
$$

 The derivative is continuous at zero and has slopes in $[r,e]$. Starting from $x_0=\sum_{j=1}^N e^{-j}$ gives $x_N=0$, $x_{N+1}=-1$, and 

$$
d_k=e^{k-N},\qquad
 \min_{0\leq k\leq N}|d_k|^2=|d_N|^2=1.
$$

 If $S=\sum_{j=1}^Ne^{-j}$, then $2S+(1-e)S^2=E_N(e)$, including $e=1$, where $S=N$. Consequently, 

$$
F_0-F_{N+1}=\frac{E_N(e)+1+r}{2}.
$$

 The objective is bounded below. It grows quadratically as $x\to-\infty$; as $x\to+\infty$, it grows quadratically if $e<1$ and equals $x$ if $e=1$.

For the $r$ branch, take 

$$
f_1(x)=\frac{x^2}{2},\qquad f_2(x)=\frac{r x^2}{2},\qquad
 x_0=\frac{r^{-N}}{1-r}.
$$

 Then $d_k=r^{k-N}$, again with minimum and final squared step equal to one, and 

$$
F_0-F_{N+1}
 =\frac{r^{-2N}-r^2}{2(1-r)}
 =\frac{E_N(r)+1+r}{2}.
$$

 Here $F$ is globally strongly convex.

Both examples have full domains, and $\nabla f_1$ is surjective, so the DCA domain/range assumptions hold. The quadratic $f_1$ belongs to $\mathcal F_{1,L_1}$ for every declared upper bound $L_1>1$; therefore strict notation for the declared curvature bounds does not exclude these examples. Choosing the example associated with the smaller branch proves the asserted sharpness. ◻

## 6. The nonconvex all-horizon coefficient

We first lift a second terminal certificate, namely the published multistep GD descent [$$2, Lemma 4.11$$](https://arxiv.org/abs/2406.17506). Put $D=e^2-r^2>0$.

**Lemma 6.1** (Multistep DCA descent). If $T_1,\ldots,T_k\geq0$, including the empty case $k=0$, then 

$$
F_0-F_{k+1}\geq
 \frac{\mathcal A_k}{2}\lVert d_k\rVert^2+
 \frac{\mathcal B_k}{2}\lVert d_{k+1}\rVert^2,
 \quad
 \mathcal A_k=-\frac{e^2r^2T_{k+1}}D,
 \quad\mathcal B_k=\frac{T_k+a}D.
 
\tag{29}
$$

*Proof.* Complete the distance-two prefix with the GD-directed weights 

$$
u=1-\frac r{e+r}
   +\frac{[(1-e)(e+r)-2r]T_k}{2D},\qquad
 v=-\frac r{e+r}
   +\frac{[(1+r)(e+r)-2r]T_k}{2D}.
$$

 They are nonnegative. This is immediate for $v$, and for $u$ if $(1-e)(e+r)-2r\geq0$. Otherwise $e>1$, and $T_k\leq E_k(e)\leq1/(e-1)$ gives the positive lower bound with numerator 

$$
(e-1)\big[2e(e-r)-(e+r)\big]-2r>0
$$

 over denominator $2D(e-1)$. The known GD identity has the principal expression in (29); it remains to verify the support flow. Its $(k,k+2)$ weight cancels exactly, since $ev+ru=T_k/2$. The other two new weights are 

$$
\alpha_{k+2,k+1}=(u+v)/a\geq0,\qquad
 \alpha_{k+1,k+2}=\mathcal B_k>0.
$$

 Writing $q=-r$, the full weight on $(k,k+1)$ is 

$$
1+\frac{e(1-q)+q}{2a}E_k(e)
  +\frac{e(1+q)+q}{2a}E_k(-q)>0.
$$

 This also equals $1$ when $k=0$. The remaining prefix weights and the subgradient quadratic remainder are nonnegative by Lemma 3.2. Lemma 2.1 completes the proof. ◻

For completeness, the phase sequence has at most one zero crossing. Indeed 

$$
T_j-T_{j-1}=(1+e)e^{-2j}-(1+r)r^{-2j},
$$

 and the ratio of the first positive term to the second is strictly decreasing in $j$. Thus the increments change sign at most once. Starting at $T_0=0$, the partial sums can cross zero at most once; eventually the $|r|^{-2j}$ term dominates. Consequently $T_N\geq0$ implies every preceding $T_j\geq0$. If $T_N<0$, let 

$$
k=\max\{j<N:T_j\geq0\}.
$$

Now suppose $e>1$. Write 

$$
c=1+\frac{er}{e+r},\qquad b=\frac1{e+r},\qquad
 p=c+b=\frac{(1+e)(1+r)}{e+r}>0.
$$

 The shifted $k=0$ case of Lemma 6.1 gives 

$$
F_i-F_{i+1}\geq\tfrac c2\lVert d_i\rVert^2
                         +\tfrac b2\lVert d_{i+1}\rVert^2.
 
\tag{30}
$$

 If $T_N<0$, append this inequality for $i=k+1,\ldots,N-1$ to (29). The first coefficient is $\mathcal A_k\geq0$. If the tail is nonempty, its first combined coefficient is $\mathcal B_k+c=T_k/D+p>0$, every later interior coefficient is $p$, and the final coefficient is $b$. If it is empty, $\mathcal B_k>0$. Writing $m=\min_{0\leq j\leq N}\lVert d_j\rVert^2$ therefore gives 

$$
F_0-F_N\geq\tfrac12
  [\mathcal A_k+\mathcal B_k+(N-k-1)p]m.
$$

 The recurrence for $E_j$ proves the scalar identity 

$$
\mathcal A_k+\mathcal B_k=(k+1)p
   +\frac{p(1-e)(1-r)}a\sum_{j=0}^kT_j.
$$

 It follows that the bracket equals $P_N(e,r)$. If $T_N\geq0$, Lemma 4.1 with $k=N-1$ gives $F_0-F_N\geq E_N(r)m/2$ instead. Either branch implies 

$$
F_0-F_N\geq\tfrac12\min\{P_N(e,r),E_N(r)\}m.
$$

 Finally the elementary DCA descent inequality is 

$$
F_N-F_{N+1}\geq\tfrac{1+r}2\lVert d_N\rVert^2.
 
\tag{31}
$$

 It follows by adding the strong convexity support inequality for $f_1$ at $x_{N+1}$ and the lower curvature inequality for $f_2$ at $x_N$; the linear terms cancel by (1). Adding it establishes (5) in the nonconvex case. Multiplication by $\mu_1$ restores the original scale.

## 7. Global sharpness in the nonconvex regime

We prove attainment of the coefficient for $e>1$. Throughout this section $\mu_1=1$, $a=e-r$, and $f_1(x)=\lVert x\rVert^2/2$. DCA is then unit-step gradient descent on $\phi=f_1-f_2$, whose curvature interval is $[1-e,1-r]$. The scalar $r$-quadratic example in the preceding sharpness proof applies unchanged whenever the minimum in (4) selects $E_N(r)$. It remains to attain $P_N(e,r)+1+r$ with the final value $F(x_{N+1})$ and a globally lower-bounded objective.

The prefix and continuation used below are the prior gradient-descent construction of [$$2, Proposition 5.14 and Appendix C.2$$](https://arxiv.org/abs/2406.17506). Its existing angle analysis supplies an acute-cone property of the interpolation data. We use that property to modify the final gradient and value while preserving all ordered interpolation inequalities. This terminal modification and the global realization are proved explicitly below.

### 7.1. The published prefix and constant-norm continuation

Define 

$$
m=\max\{j\in\mathbb Z_{\ge0}:T_j\ge0\},\qquad
 p=\frac{(1+e)(1+r)}{e+r},\qquad
 \chi=\frac{(1-e)(1-r)}a.
 
\tag{32}
$$

 The index $m$ is finite. The increments $(1+e)e^{-2j}-(1+r)r^{-2j}$ of $T_j$ strictly decrease, and $T_j$ tends to minus infinity. Thus $T_j\ge0$ for $0\le j\le m$ and $T_j<0$ for $j>m$. At a threshold, the last zero is included in $m$. We use precisely the convention of [$$2, Definition 4.5$$](https://arxiv.org/abs/2406.17506). The displayed threshold interval in the opening sentence of the proof of its Proposition 5.14 has endpoints shifted down by one relative to that definition; the gradient and value formulas (C.1)–(C.2) use the definition’s index. Here the unambiguous convention is $T_m\ge0>T_{m+1}$, and those data formulas require no alteration. The same proof’s introductory $1\le\overline N$ restriction omits the empty-prefix case: the proposition’s statement and preceding discussion include $m=0$, and the Appendix C.2 formulas and all-pairs argument permit that empty prefix.

Suppose $N>m$, and put 

$$
u=\sqrt{\frac{(1-r^2)(e^2-1)}{e^2-r^2}}>0,\qquad
 V=\frac{u}{\sqrt{e^2-1}}.
$$

 The two-coordinate prefix, embedded in $\mathbb R^3$, is 

$$
d_i=u\begin{bmatrix}
 r^{i-m}/\sqrt{1-r^2}\\
 e^{i-m}/\sqrt{e^2-1}\\0
 \end{bmatrix},\qquad 0\le i\le m.
 
\tag{33}
$$

 For integers $t\ge0$, set 

$$
S_t=\sum_{j=0}^{t-1}r^{2j},\qquad
 q_t=(-1)^t\sqrt{(e^2-1)S_t},\qquad
 \theta_t=\arctan q_t.
$$

 In particular $S_0=q_0=0$. Write $d_i=(z_i,v_i)$ with $v_i\in\mathbb R^2$, and, for $i=m+t$, continue by 

$$
d_{i+1}=r d_i+\varepsilon_i,\qquad
 \varepsilon_i=\begin{bmatrix}0\\
 a\cos\theta_t R(\theta_t)v_i
 \end{bmatrix},\qquad
 R(\theta)=\begin{bmatrix}\cos\theta&-\sin\theta\\
 \sin\theta&\cos\theta\end{bmatrix}.
 
\tag{34}
$$

 Generate the unmodified data through $d_{N+1}$. This last vector is an interpolation gradient, not an additional step counted in the performance criterion. For $i<m$, the prefix also gives 

$$
\varepsilon_i=d_{i+1}-r d_i
 =\begin{bmatrix}0\\aV e^{i-m}\\0\end{bmatrix}.
 
\tag{35}
$$

 Take $x_N=0$, $x_i=\sum_{k=i}^{N-1}d_k$ for $i<N$, and $x_{N+1}=-d_N$. Set $\phi_N=0$, and define the values by 

$$
\phi_i-\phi_{i+1}=
 \begin{cases}
 \big((1+r)(d_i)_1^2+(1+e)(d_i)_2^2\big)/2,&i<m,\\
 p/2,&m\le i\le N.
 \end{cases}
 
\tag{36}
$$

The all-pairs interpolability proved in [$$2, Proposition 5.14 and Appendix C.2$$](https://arxiv.org/abs/2406.17506), applied with $\gamma=1$, $\mu=1-e$, $L=1-r$, source horizon $H=N+1$, minimum gradient norm $U=1$, and phase index $\overline N=m$, states that these unmodified triples interpolate a function of curvature $[1-e,1-r]$. All consecutive interpolation inequalities hold with equality. We import that published result; the modifications below do not assume that a bound measured against the global minimum also controls the desired terminal value.

The prefix norms are 

$$
\lVert d_i\rVert^2=
 \frac{(e^2-1)r^{2(i-m)}+(1-r^2)e^{2(i-m)}}{e^2-r^2}\ge1,
 \qquad i\le m.
 
\tag{37}
$$

 For example, the inequality follows from Jensen’s inequality for $y\mapsto y^{-(m-i)}$, with weights $(e^2-1)/(e^2-r^2)$ and $(1-r^2)/(e^2-r^2)$: their weighted mean of $r^2$ and $e^2$ is one. The continuation has 

$$
\lVert d_i\rVert=1,\qquad
 \langle d_i,d_{i+1}\rangle=\frac{1+er}{e+r},\qquad i\ge m.
 
\tag{38}
$$

 Indeed, $S_{t+1}=1+r^2S_t$ and (34) imply $\lVert v_{m+t}\rVert^2=V^2(1+q_t^2)$ and $\cos\theta_t\lVert v_{m+t}\rVert=V$. Combining this with $(d_{m+t})_1=ur^t/\sqrt{1-r^2}$ proves the first identity. Also, 

$$
\lVert \varepsilon_i\rVert^2=a^2V^2
 =\frac{a(1-r^2)}{e+r},\qquad
 \langle d_i,\varepsilon_i\rangle=aV^2,\qquad i\ge m,
 
\tag{39}
$$

 which proves the inner-product identity.

Define 

$$
B_j^{\mathrm{sh}}=
 \frac{(e^2-1)E_j(r)+(1-r^2)E_j(e)}{e^2-r^2}.
$$

 Summing (36) through index $N-1$ gives 

$$
2(\phi_0-\phi_N)=B_m^{\mathrm{sh}}+p(N-m)=P_N(e,r).
 
\tag{40}
$$

 For the last equality, substitution of $E_j(t)=(t^{-2j}-1)/(1-t)$ yields $B_j^{\mathrm{sh}}-B_{j-1}^{\mathrm{sh}}=p(1+\chi T_j)$; sum this identity and use $T_j\ge0$ exactly up to $m$. This also verifies branch selection. If $N\le m$, then $P_N=B_N^{\mathrm{sh}}\ge E_N(r)$ because 

$$
B_N^{\mathrm{sh}}-E_N(r)=\frac{1-r^2}{e^2-r^2}T_N.
$$

 If $N>m$, removing the negative $T_j$ terms from the sum multiplied by $\chi<0$ gives $P_N<B_N^{\mathrm{sh}}<E_N(r)$.

### 7.2. The acute-cone consequence of the existing angle analysis

For $i=m+t$, write 

$$
w_t=R(\theta_t)\frac{v_{m+t}}{\lVert v_{m+t}\rVert},\qquad
 \varepsilon_{m+t}=aVw_t
$$

 in the plane of the last two coordinates. Let $\beta_t$ be its continuous angle, with $\beta_0=0$. The existing angle computation in [$$2, Appendix C.2, equation (C.14)$$](https://arxiv.org/abs/2406.17506) gives 

$$
\beta_{t+1}-\beta_t=(-1)^{t+1}\alpha_t,\qquad
 \alpha_t=\arcsin\frac{\sqrt{e^2-1}}
 {e\sqrt{S_{t+1}}-r\sqrt{S_t}}.
 
\tag{41}
$$

 Its decreasing-angle and alternating-sum structure is prior analysis, not a new formula claimed here. One may verify the branch of the angle directly: the cosine of its signed difference equals 

$$
\frac{\sqrt{S_{t+1}}-er\sqrt{S_t}}
      {e\sqrt{S_{t+1}}-r\sqrt{S_t}}>0.
$$

 The denominator in (41) increases with $t$, so $\alpha_t$ decreases, with $0<\alpha_t\le\alpha_0=\arccos(1/e)<\pi/2$. Therefore its alternating partial sums satisfy $-\alpha_0\le\beta_t\le0$. The prefix innovations in (35) lie on the angle-zero boundary. We obtain the consequence 

$$
\langle \varepsilon_i,\varepsilon_j\rangle\ge0\qquad(i,j\ge0).
 
\tag{42}
$$

 It is this acute-cone consequence that makes the following terminal replacement preserve all interpolation constraints.

### 7.3. Exact replacement of the final interpolation data

For the gradient-descent data, use the directed residual 

$$
Q^\phi_{ij}=\phi_i-\phi_j-\langle d_j,x_i-x_j\rangle
 -\frac{1-e}{2}\lVert x_i-x_j\rVert^2
 -\frac1{2a}\lVert d_i-d_j-(1-e)(x_i-x_j)\rVert^2.
 
\tag{43}
$$

 These are the $\phi$ residuals, whose directions reverse under complementation to $f_2$. The unmodified construction satisfies $Q^\phi_{ij}\ge0$ for all ordered pairs.

Keep the points and all data of indices at most $N$ unchanged. Replace the terminal gradient and value by 

$$
\widehat d_{N+1}=r d_N,\qquad
 \widehat\phi_{N+1}=\phi_N-\frac{1+r}{2}\lVert d_N\rVert^2.
 
\tag{44}
$$

 Since $\lVert d_N\rVert=1$, the old and new values obey 

$$
\widehat\phi_{N+1}-\phi_{N+1}
 =\frac{p-(1+r)}2
 =\frac{1-r^2}{2(e+r)}
 =\frac{\lVert \varepsilon_N\rVert^2}{2a}.
 
\tag{45}
$$

**Lemma 7.1** (Terminal interpolation replacement). Every ordered interpolation inequality remains valid after (44). More precisely, for $0\le i,j\le N$, 

$$
\begin{aligned}
 \widehat Q^\phi_{N+1,j}&=Q^\phi_{N,j},
 \\
 \widehat Q^\phi_{i,N+1}&=Q^\phi_{i,N+1}
  +\frac1a\langle \varepsilon_N,\sum_{k=i}^{N-1}\varepsilon_k\rangle.
 
\end{aligned}\tag{46–47}
$$

*Proof.* Substitute $x_{N+1}=x_N-d_N$ and (44) in (43). For the forward direction, the vector inside the last square changes from the one for $Q^\phi_{N,j}$ by $-a d_N$. Expansion cancels every additional term, giving (46).

For the reverse direction, the gradient changes by $-\varepsilon_N$ and the value changes by (45). Expansion gives exactly 

$$
\widehat Q^\phi_{i,N+1}-Q^\phi_{i,N+1}
 =\frac1a\langle \varepsilon_N,(1-r)(x_i-x_N)-d_i+d_N\rangle.
$$

 The trajectory equation rewrites the second vector as $\sum_{k=i}^{N-1}(d_{k+1}-r d_k)$, proving (47). Its extra term is nonnegative by (42); the forward term is an old nonnegative interpolation residual. Unaffected pairs are unchanged. ◻

Thus (40) and the replacement give 

$$
2(\phi_0-\widehat\phi_{N+1})=P_N(e,r)+1+r,
 \qquad \min_{0\le i\le N}\lVert d_i\rVert^2=1.
 
\tag{48}
$$

 Although $\lVert \widehat d_{N+1}\rVert=|r|<1$, this vector is outside the performance minimum, which ends at $d_N=x_N-x_{N+1}$.

### 7.4. A globally smooth realization with a finite minimum

We now realize the replaced data by global functions with $F$ bounded below. This closes a separate requirement that finite interpolation alone would not establish. In this subsection the terminal hats are suppressed. Define 

$$
\psi_i=\frac{1-r}{2}\lVert x_i\rVert^2-\phi_i,
 \qquad \zeta_i=(1-r)x_i-d_i.
$$

 The $\phi$ interpolation inequalities give, with reversed directions, 

$$
\psi_i-\psi_j-\langle \zeta_j,x_i-x_j\rangle
 \ge\frac{\lVert \zeta_i-\zeta_j\rVert^2}{2a}.
 
\tag{49}
$$

 Put $\psi_i^*=\langle x_i,\zeta_i\rangle-\psi_i$ and $K=\operatorname{conv}\{\zeta_i:0\le i\le N+1\}$. Define the extended-valued dual function 

$$
J(z)=\max_i\left\{\psi_i^*+\langle x_i,z-\zeta_i\rangle
              +\frac{\lVert z-\zeta_i\rVert^2}{2a}\right\}
              +\delta_K(z),
 
\tag{50}
$$

 where $\delta_K$ is zero on $K$ and positive infinity outside. For each $i$, (49) with reversed indices says that every displayed quadratic is at most $\psi_i^*$ at $\zeta_i$; the $i$-th one equals it. Hence $J(\zeta_i)=\psi_i^*$ and $x_i\in\partial J(\zeta_i)$.

The function $J$ is proper, closed, and $1/a$-strongly convex, with compact domain. Its conjugate $\psi=J^*$ is finite and differentiable on $\mathbb R^3$, with $a$-Lipschitz gradient. Fenchel equality yields $\psi(x_i)=\psi_i$ and $\nabla\psi(x_i)=\zeta_i$. Set 

$$
f_1(x)=\tfrac12\lVert x\rVert^2,\qquad
 f_2(x)=\tfrac r2\lVert x\rVert^2+\psi(x).
 
\tag{51}
$$

 These functions realize every prescribed value and gradient, $f_2\in\mathcal F_{r,e}$, and their unique DCA update is $x_{i+1}=\nabla f_2(x_i)=x_i-d_i$.

Let $R_K=\max_{z\in K}\lVert z\rVert$. The definition of the conjugate gives $\psi(x)\le R_K\lVert x\rVert-\min_KJ$. Consequently 

$$
F(x)=\frac{1-r}{2}\lVert x\rVert^2-\psi(x)
 \ge\frac{1-r}{2}\lVert x\rVert^2-R_K\lVert x\rVert+\min_KJ
 \longrightarrow+\infty.
 
\tag{52}
$$

 Thus $F$ is continuous, coercive, and has a finite attained minimum. The primal functions have full domains; compactness is used only for the dual extension. This construction preserves the three-dimensional trajectory and the exact coefficient in (48).

Multiplying both functions by $\mu_1$ restores arbitrary positive $\mu_1$ and gives the factor $\mu_1 C_N/2$. The examples retain $f_1(x)=\mu_1\lVert x\rVert^2/2$, so they belong to every declared curvature class $\mathcal F_{\mu_1,L_1}$ with $L_1\ge\mu_1$, including $L_1=+\infty$. Together with the scalar examples and the branch selection above, this proves the sharpness assertion of Theorem 1.1.

The exact-arithmetic script `sharpness_exact.py` checks eight finite examples, including genuine rank-three continuations at $N=4,5$. It verifies 198 ordered interpolation constraints with rational arithmetic, the exact coefficients, and, where the auxiliary data are rational, both terminal comparison identities. These finite checks are supplementary; the all-horizon argument is (41)–(52).

## 8. A proximal-gradient corollary

The following is a translation through the established DCA–PGD equivalence, not a new equivalence principle. Let $\Psi=\varphi+h$, where $h$ is proper closed convex and $\varphi$ has curvature in $[\mu,L]$, with $L>0$. Choose $\gamma$ so that 

$$
1/L<\gamma<2/L,\qquad 1-\gamma\mu>0,\qquad
 2-\gamma(L+\mu)>0.
$$

 For $\mu\leq0$, the last two conditions follow from the first interval. For $\mu>0$ they reduce to the additional upper bound $\gamma<2/(L+\mu)$. Write 

$$
x_{j+1}=\operatorname*{argmin}_y\left\{h(y)+\frac1{2\gamma}
           \lVert y-x_j+\gamma\nabla\varphi(x_j)\rVert^2\right\},
 \qquad \mathcal G_\gamma(x_j)=\frac{x_j-x_{j+1}}\gamma.
$$

 Set $f_1=\lVert x\rVert^2/(2\gamma)+h$ and $f_2=\lVert x\rVert^2/(2\gamma)-\varphi$. The optimality condition is exactly (1), with $\mu_1=1/\gamma$, $e=1-\gamma\mu$ and $r=1-\gamma L$. Thus Theorem 1.1 gives the sharp bound 

$$
\min_{0\leq j\leq N}\lVert \mathcal G_\gamma(x_j)\rVert^2
 \leq\frac{2[\Psi(x_0)-\Psi(x_{N+1})]}
              {\gamma C_N(1-\gamma\mu,1-\gamma L)}.
$$

 For $\mu\geq0$ the final mapping norm can replace the minimum. Sharpness follows from the quadratic-$f_1$ examples above, for which $h=0$. This corollary concerns precisely the displayed step-size interval; it asserts no new result outside it.

## 9. Reproducibility and limits of the evidence

The accompanying code formulates finite performance-estimation problems with every ordered interpolation pair, the exact DCA relations, and the objective $F_0-F_{N+1}$. It includes independent explicit-Gram and PEPit implementations, CLARABEL/SCS comparisons, original primal and dual data, and exact rational certificate assembly. These computations motivated and tested the proofs; none replaces an all-parameter sign argument. `check_lift_algebra.py` validates free-parameter rational identities with SymPy. The independent reviewer separately expands the same identities. These are symbolic algebra checks, not Lean kernel certificates.

The work resolves only the parameter class specified in Section 1. It makes no claim about the globally concave equation (11) of the source conjecture, adaptive step sizes, stochastic or inexact DCA, or improved stationarity measures. The negative-curvature regime refers to a curvature class that permits nonconvex objectives; an individual example in that class need not itself be nonconvex everywhere. The public status record separately reports independent review, internal value assessment, and the exact extent of formal verification. The manuscript does not equate a numerical optimum, a symbolic identity, or a partial Lean file with full formal verification of Theorem 1.1.

## References

1.  T. Rotaru, P. Patrinos, and F. Glineur. *Tight Convergence Rates in Gradient Mapping for the Difference-of-Convex Algorithm*. arXiv:2506.01791v2, 2025. [arxiv.org/abs/2506.01791](https://arxiv.org/abs/2506.01791). Proceedings DOI: [10.1007/978-3-032-08381-4_5](https://doi.org/10.1007/978-3-032-08381-4_5).

2.  T. Rotaru, F. Glineur, and P. Patrinos. *Exact worst-case convergence rates of gradient descent: a complete analysis for all constant stepsizes over nonconvex and convex functions*. arXiv:2406.17506v2, 22 January 2026. [arxiv.org/abs/2406.17506](https://arxiv.org/abs/2406.17506).

3.  T. Rotaru. *Exact Performance Analysis of Fundamental First-Order Optimization Methods*. PhD dissertation, UCLouvain, 2026. Conjecture 4.3.1, printed pp. 124–125; future work, printed p. 229. [UCLouvain repository record](https://research.dial.uclouvain.be/entities/publication/3e832c83-0778-4645-bf0b-fcbcd428989d).

4.  T. Rotaru, P. Patrinos, and F. Glineur. *Tight Analysis of DCA Improves Convergence Rates for PGD*. Proceedings of AISTATS, PMLR 258:4114–4122, 2025. [proceedings.mlr.press/v258/rotaru25a.html](https://proceedings.mlr.press/v258/rotaru25a.html).

5.  A. B. Taylor, J. M. Hendrickx, and F. Glineur. *Exact Worst-Case Convergence Rates of the Proximal Gradient Method for Composite Convex Minimization*. JOTA, 2018; [arXiv:1705.04398](https://arxiv.org/abs/1705.04398).
