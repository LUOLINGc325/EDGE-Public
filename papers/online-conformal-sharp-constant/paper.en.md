# The sharp cost of online conformal coverage in subdiffusive corridors

Consider online prediction with target miscoverage `0 < α < 1`. To ensure that coverage stays near this target on every data sequence, an online method can occasionally replace its usual prediction set by the entire response space or the empty set. For the corridor of Gui, Barber and Ma, we determine the exact leading cost of enforcing this constraint, measured in disagreements with a conditionally exact oracle. In a symmetric corridor of radius `κ t^(1−β)` with `1/2 < β < 1`, the minimax expected cost is asymptotic to `α(1−α) T^β/(2κβ)`. The paper of Gui, Barber and Ma established its order of growth. We also obtain the leading constant for asymmetric corridors and uniform finite-horizon remainder bounds.

## Setting and theorem

Let `Z_t=(X_t,Y_t)` be observations on the spaces of the source paper, with its measurability assumptions. A predictor `A` uses `Z_1,…,Z_(t−1)` and `X_t` to output a subset of the response space before seeing `Y_t`. Let `e_t(A)` be its indicator of miscoverage and `E_t(A)=Σ_(s≤t)(e_s(A)−α)`, with `E_0=0`. We require, for every sequence and time,

$$
-L_t\le E_t(A)\le U_t,\qquad
L_t=c_-t^{1-\beta_-},\quad U_t=c_+t^{1-\beta_+}.
$$

Take `c_-,c_+>0`, `c_-+c_+≥1`, and `β=min(β_-,β_+)` with `1/2<β<1` and `β_-,β_+≤1`. All parameters are fixed in the limit. Write `D_t=L_t+U_t`, `σ²=α(1−α)` and `C=Σ_(j∈{−,+}: β_j=β)c_j`.

Fix a measurable score and let `Q` be the nonempty family of i.i.d. laws for which the score has a nonatomic distribution. For each `P∈Q`, let `O_α(P)` consist of all predictors `B` with `P(e_t(B)=1 | Z_1,…,Z_(t−1))=α` at every time. Let `A_adm` be the class of predictors that are independent of the law and satisfy the corridor on every data sequence. For coupled predictors evaluated on the same observations define

$$
\ell_T(A,B)=\sum_{t=1}^T |e_t(A)-e_t(B)|,\qquad
M_T=\inf_{A\in A_{\mathrm{adm}}}\sup_{P\in Q}\inf_{B\in O_\alpha(P)}\mathbb E_P\ell_T(A,B).
$$

**Theorem.** With `S_T=Σ_(t≤T)1/D_t`,

$$
M_T = \sigma^2 S_T + O_{\alpha,c_-,c_+,\beta_-,\beta_+}
            (\sqrt{T}+T^{2\beta-1}+T^{1-\beta}),
\qquad
\lim_{T\to\infty}\frac{M_T}{T^\beta}=\frac{\sigma^2}{\beta C}.
$$

The lower remainder `O(T^(2β−1)+T^(1−β))` applies separately to each corridor-feasible predictor and each exact oracle, including predictors that know the law. A single distribution-independent predictor attains the upper bound by clipping the online split-conformal baseline. The symmetric case takes `c_-=c_+=κ` and `β_-=β_+=β` under the source's hypothesis `κ≥1/2`.

## Proof

### One-step potential identity

For the remainder of the proof fix a law and an exact oracle. Put `a_t=e_t(A)`, `b_t=e_t(B)`, `δ_t=a_t−b_t`, and `d_t=E|δ_t|`. Write `m_t=(U_t−L_t)/2`, `w_t=D_t/2`, `m_0=w_0=0`, `ρ_t=m_t−m_(t−1)`, and `H_t=E_t(A)−m_t`. Then `|H_t|≤w_t`. Let `h_t=E[H_t²]`.

The identity `(a_t−α)^2−(b_t−α)^2=(1−2α)δ_t` gives

$$
h_t-h_{t-1}=\sigma^2+r_t+
     \mathbb E\big[(2(E_{t-1}(A)-m_t)+1-2\alpha)\delta_t\big],
\qquad
r_t=-2\rho_t\mathbb E H_{t-1}+\rho_t^2.
$$

Indeed `H_t=H_(t−1)−ρ_t+a_t−α`. Expand the square, compare with `(H_(t−1)−ρ_t+b_t−α)^2`, and use conditional exactness of `b_t` given the past. The predictor's own outcome may depend on the oracle outcome. No independence of these two outcomes is used.

Both corridor sides are nondecreasing, so `E_(t−1)(A)∈[-L_t,U_t]`. The coefficient multiplying `δ_t` therefore has absolute value at most `D_t+1`. Every feasible predictor satisfies

$$
(D_t+1)d_t\ge \sigma^2+r_t-(h_t-h_{t-1}).
$$

### A matching upper inequality for clipping

Clipping a baseline predictor means forcing `a_t=0` when `E_(t−1)(A)+1−α>U_t`, forcing `a_t=1` when `E_(t−1)(A)−α<−L_t`, and otherwise using the baseline prediction set. These two triggers are mutually exclusive because `D_t≥1`. Since the old corridor is contained in the new one, whenever one proposed error would be infeasible, the other is feasible. Thus the clipped predictor satisfies the corridor.

Apply clipping first to the exact oracle as a comparison predictor. On a disagreement at the upper boundary, `δ_t=−1` and `E_(t−1)(A)>U_t−(1−α)`, so the coefficient of `δ_t` in the identity is greater than `D_t−1`. At the lower boundary `δ_t=1` with `E_(t−1)(A)<−L_t+α`, so that coefficient is less than `−D_t+1`. Hence for this comparison predictor

$$
(D_t-1)d_t\le\sigma^2+r_t-(h_t-h_{t-1}).
$$

### Weighted summation

Start at a fixed time `t_0` with `D_t≥2` for `t≥t_0`, which exists because `β<1`. The first `t_0−1` terms contribute only a constant. For either sign let `v_t=1/(D_t±1)`. This sequence is positive and nonincreasing. By summation by parts,

$$
\sum_{t=t_0}^{T}v_t(h_t-h_{t-1})
=v_T h_T-v_{t_0}h_{t_0-1}
 +\sum_{t=t_0}^{T-1}(v_t-v_{t+1})h_t.
$$

Since `0≤h_t≤D_t²/4`, the quantity on the right is bounded below by a fixed negative constant and above by `O(D_T)`. For the latter assertion the terminal term is `O(D_T)`, and each term of the sum is `O(D_(t+1)−D_t)` because `D_t±1≥D_t/2` for `t≥t_0`.

For `t≥2`, `|ρ_t|=O(t^(−β))` by the mean value theorem. Also `D_t\asymp t^(1−β)`. It follows that `Σ v_t |r_t|=O(T^(1−β))`: the first term is bounded by a constant times `Σ|ρ_t|`, and the second is summable since `2β>1`. Replacing each `v_t` with `1/D_t` in the sum against `σ²` costs `O(Σ D_t^(−2))=O(T^(2β−1))`.

Divide the lower inequality by `D_t+1` and use the upper bound on the potential sum. This gives `Σ d_t ≥ σ² S_T−O(T^(2β−1)+T^(1−β))`, uniformly in the predictor, oracle, and law. Divide the upper inequality for the clipped oracle by `D_t−1` and use the lower bound on the potential sum. This gives `Σ d_t ≤ σ² S_T+O(T^(2β−1)+T^(1−β))` for the clipped oracle. Its errors before clipping are i.i.d. Bernoulli because each has a fixed conditional success probability given the past. The potential argument only required the conditional moments.

### Learning the oracle

For words of zero-one errors let `D_H` denote Hamming distance through time `T` and `Γ` denote clipping. Two baseline words that differ at one position have clipped accumulated error counts whose gap is either 0 or 1 there, then stays constant or returns to zero once. To see this, write the clipped count as

$$
K_t=\min\{z_t,\max\{a_t',K_{t-1}+b_t'\}\},\qquad
a_t'=\lceil\alpha t-L_t\rceil,\quad z_t=\lfloor\alpha t+U_t\rfloor,
$$

where `b_t'` is the baseline digit. The map on counts is nondecreasing and 1-Lipschitz. Thus a single input change can change at most two output digits. Replacing differing input digits successively proves `D_H(Γ(e),Γ(f))≤2D_H(e,f)`. This is equation (41) of the source, proved in §C.2.

In the online split-conformal baseline, use at time `t` the `k_t=ceil((1−α)t)`th smallest of the previous `t−1` scores, with value +∞ for `k_t=t`. For a fixed nonatomic score distribution F, take the population `(1−α)` quantile threshold as the exact oracle. Conditional on the past, the two nested sets disagree with probability `|F(q_t)−(1−α)|`, where `q_t` denotes the sample threshold. If `1≤k_t≤t−1`, the probability integral transform gives `F(q_t) ~ Beta(k_t,t−k_t)`, with mean `k_t/t` and variance at most `1/[4(t+1)]`. When `k_t=t`, take `F(q_t)=1` and variance zero. In either case the mean differs from `1−α` by at most `1/t`. The expected baseline disagreement is therefore at most `1/t+1/(2√(t+1))` per round, uniformly in `P∈Q`, and hence `O(√T)` in total.

The deterministic Hamming inequality and the triangle inequality bound the cost of clipped split conformal relative to the population oracle by the cost of clipping that oracle plus twice the baseline disagreement. Together with the universal lower bound, this proves the finite-horizon assertion. Finally `D_t/t^(1−β)→C` and `Σ_(t≤T) t^(β−1) ~ T^β/β` by integral comparison. Since all three error exponents are less than `β`, the claimed limit follows.

## Interpretation and scope

The leading multiplier is determined by the Bernoulli conditional variance, the asymptotic width of the corridor, and the exponent of the shrinking allowance for empirical miscoverage. For corridors whose two sides grow at different powers, the wider side supplies the leading width. The sample cost of learning the oracle is lower order throughout this regime. The critical boundary `β=1/2`, bounded corridor `β=1`, and atom-containing score models require separate arguments.

## Reference

Yu Gui, Rina Foygel Barber and Cong Ma. [The cost of enforcing long-run coverage: a phase transition in online conformal prediction](https://arxiv.org/pdf/2611.21542v1), arXiv:2611.21542v1, 2026. See §1.4, §2, and Appendices A and C. Their clipping algorithm, Beta baseline estimate, and coupling lemma are adopted here, with the quadratic-potential method sharpened for an exact disagreement constant and a universal lower bound.
