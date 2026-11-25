# Prescribed Random Sources in Online Proportional Unbounded Knapsack

**Research draft — 25 November 2026 (Asia/Shanghai).**  
Research identifier: `d4e8e7447ceaea2934d7`.

## Abstract

We study online unbounded knapsack with unit capacity and item value equal to item size. The horizon is unknown, decisions are irrevocable, and copies of an item may be taken only when that item arrives. Inputs are arbitrary fixed finite sequences, independent of the algorithm's randomness. We give a direct strategy attaining competitive ratio \(C=1+\log 2\): use the established harmonic threshold law while only large items arrive, and fill the remaining capacity when the first positive item of size at most one half appears. A pathwise clipping inequality proves that this transition preserves the guarantee without removing any previously accepted item.

The same transition works for every finite threshold partition. Consequently, among algorithms that initially choose from at most \(K\) arbitrary deterministic online policies with arbitrary probabilities, the exact competitive ratio is
\[
R_K=1+K\bigl(2^{1/K}-1\bigr).
\]
The matching lower bound permits full history dependence within each policy. For finite or countably supported global random seeds, let \(H_{\min}(\varepsilon)\) be the infimum Shannon entropy permitting ratio at most \(C+\varepsilon\). We prove
\[
H_{\min}(\varepsilon)
=\frac{\log 2}{1+\log 2}\log(1/\varepsilon)+O(1).
\]
A finite acceptance-trace argument converts near-optimality into a bound on the squared masses of noninitial acceptance events; it applies to arbitrary policies, not only threshold policies. The same certificate rules out exact ratio \(C\) for every countably supported seed, including seeds of infinite Shannon entropy.

If the \(K\) modes have prescribed positive masses \(p_1,\dots,p_K\), the optimum is the unique root of \(\max_{\varnothing\ne I\subseteq[K]} R p(I)\prod_{j\notin I}(1+Rp_j)=2\). This gives an exact bound for every finite fair-bit budget, including adaptive bit acquisition. On a standard source with atomic and atomless components, the unrestricted ratio is attained exactly when total atomic mass is at most \(1/C\). Allowing bits to be drawn as items arrive retains the sharp leading expected-bit cost \(q\log_2(1/\varepsilon)\).

The constant \(C\), harmonic search law, and several underlying tools are established background. In particular, an explicit replication reduction from the multiple-knapsack theorem of Bienkowski, Pacut, and Piecuch already implies the optimal competitive infimum. The present contribution under study is the direct residual-capacity transition and the resulting precise randomization-resource statements. 

## 1. Model, random resources, and statements

An input is a finite sequence \(I=(x_1,\ldots,x_N)\), where \(x_i\in[0,1]\). Its length \(N\) is unknown to the algorithm. Item size and value both equal \(x_i\). On arrival \(i\), the algorithm chooses an integer \(k_i\ge0\), immediately and irrevocably, subject to
\[
\sum_{j\le i} k_jx_j\le1.
\]
It cannot remove accepted items, recover rejected items, or obtain additional copies of a past item after its arrival has been processed. Zero-size items also have zero value and are ignored throughout. In particular, they do not trigger the first-small-item transition.

The offline benchmark is
\[
\operatorname{OPT}(I)=
\max\left\{\sum_{i=1}^N k_ix_i:
 k_i\in\mathbb N_0,\quad \sum_{i=1}^N k_ix_i\le1\right\}.
\]
For a finite input, ignoring its zero entries makes this a finite search over feasible copy counts, so the maximum is well defined. An algorithm is \(R\)-competitive if
\[
\mathbb E[\operatorname{ALG}(I)]\ge\frac{\operatorname{OPT}(I)}R
\tag{1.1}
\]
for every fixed finite input \(I\). There is no additive term. The adversary is oblivious: it may depend on the algorithm and its distribution, but not on the realized random seed or realized random actions. The expectation in (1.1) is over the algorithm's randomness alone. Every lower bound below uses only legal fixed inputs with all sizes strictly greater than one half.

Write
\[
C=1+\log 2,\qquad p=C^{-1},\qquad q=1-p=\frac{\log 2}{1+\log 2}.
\tag{1.2}
\]
All logarithms are natural unless a base is explicitly stated.

A **\(K\)-mode algorithm** samples a seed from a set of at most \(K\) elements at time zero. Its probabilities are arbitrary. Conditional on a seed, the entire algorithm is a deterministic online policy; that policy may depend on the complete observed history. A **discrete-seed algorithm** uses the same definition with finite or countable support. Its Shannon entropy is
\[
H(Z)=-\sum_z \Pr(Z=z)\log\Pr(Z=z),
\]
with \(0\log0=0\), and is allowed to be infinite. For each fixed algorithm, one seed distribution, independent of the input, must serve all finite input lengths. This is the entropy of the entire global seed. It is not differential entropy, input-distribution entropy, arrival-order entropy, or a bound on a fixed number of fair random bits. Any further randomness must be included in \(Z\); conditional on \(Z\), no randomness remains.

The results proved below are as follows.

**Theorem 1 (direct exact algorithm).** In the model above, a single threshold and a first-positive-small-item transition give competitive ratio \(C\). Every randomized online algorithm has competitive ratio at least \(C\).

**Theorem 2 (finite modes).** For every integer \(K\ge1\), the infimum competitive ratio among all \(K\)-mode algorithms equals
\[
R_K=1+K\bigl(2^{1/K}-1\bigr),
\tag{1.3}
\]
and a \(K\)-mode threshold construction attains it.

**Theorem 3 (seed entropy).** Let \(H_{\min}(\varepsilon)\) be the infimum of \(H(Z)\) over all discrete-seed algorithms satisfying (1.1) with \(R=C+\varepsilon\). Then
\[
H_{\min}(\varepsilon)=q\log(1/\varepsilon)+O(1)
\quad\text{as }\varepsilon\downarrow0.
\tag{1.4}
\]
The two constants implicit in this two-sided statement are absolute and do not depend on the seed alphabet or the policy.

**Theorem 4 (countable-support nonattainment).** No algorithm whose entire random seed is countably supported attains competitive ratio \(C\), even if its Shannon entropy is infinite. The mixed atom-and-density threshold law in Theorem 1 does attain \(C\).

Theorem 4 excludes purely countable atomic randomization. It does not classify arbitrary mixtures of atomic and nonatomic randomness, and it does not assert that every source having a nonatomic component is sufficient.

## 2. Prior work and the contribution boundary

Böckenhauer et al. [B25] formulate the proportional unbounded-knapsack model studied here. Their Theorem 3 gives the lower bound \(1+\log2\), Theorem 4 gives an upper bound below \(1.7353\), and Section 6 asks for the exact randomized ratio. Their discussion already contains the normalization of the law \(\delta_{1/2}+dt/t\) for the pure-large-item obstruction. Their Corollary 2 gives the two-fair-bit upper bound \(24/13\). With \(K=4\), the maximizing \(k=3\) in Theorem 5 gives the exact smaller ratio \((2\sqrt{33}-6)/3\). Their Corollary 3 gives an \(11/6\)-competitive algorithm using one nonuniform random decision. The restriction to one *uniform* random bit in their Theorem 2 is different.

The harmonic threshold strategy for zero-fallback online selection is also covered by Jiang et al. [JLTZ21, Theorems 3.2–3.3]; their optimum with value-range ratio \(\Delta\) is the gain fraction \(1/(1+\log\Delta)\). Setting \(\Delta=2\) gives the large-item search component used here. Sun et al. [SNTB24] study related static prices and finite-price or finite-inventory variants. A finite input-price set, a finite inventory, and a finite support for the algorithm's seed are distinct restrictions. Classical search and trading analysis already uses adjacent-price ratios, geometric partitions, and AM–GM [EFKT01]. Advice complexity is likewise a different resource [CHKK16]. None of these tools is claimed as a new general technique here.

Gehnen and Stocker [GS26] study the model with removal. Their table still lists the above interval for the model without removal. Their Simple algorithm already switches at the first item of size at most one half, but removes its old large item before filling. The transition analyzed in this manuscript retains the old item and fills only the residual capacity. Thus the surface idea of a first-small-item switch is not itself a priority claim.

### 2.1. A reduction showing that the infimum was already implicit

Bienkowski, Pacut, and Piecuch [BPP20] give a deterministic algorithm for \(n\) unit knapsacks in the proportional, irrevocable online model, with gain fraction \(p-O(1/n)\) relative to its offline optimum. Each item in that model may be used only once. The following reduction is an inference from their theorem, rather than a claim that their paper states the reduction explicitly.

For each positive item \(x\) in our model, feed a virtual copy of their algorithm a batch of \(n\lfloor1/x\rfloor\) items of size \(x\). Finish the batch before reading the next original item. Independently choose one virtual knapsack \(J\) uniformly at the start. The actual knapsack takes exactly those copies in the current batch that the deterministic simulator assigns to \(J\). The simulation itself is independent of \(J\), and every virtual knapsack is feasible, so this is a legal online algorithm with \(n\) equally likely modes.

The expanded instance has offline optimum exactly \(n\operatorname{OPT}(I)\). One inequality follows by copying an optimal original packing into all \(n\) knapsacks: each batch contains enough copies. For the other inequality, each virtual knapsack individually maps to a legal original packing, so its value is at most \(\operatorname{OPT}(I)\). Averaging the simulator's loads gives
\[
\mathbb E[\operatorname{ALG}(I)]
\ge\bigl(p-O(1/n)\bigr)\operatorname{OPT}(I).
\]
Consequently, for every \(\varepsilon>0\), a sufficiently large fixed \(n\) gives ratio at most \(C+\varepsilon\). Together with the known lower bound, this already determines the competitive infimum. We therefore do not claim to be the first to determine that infimum, nor make a priority claim about abstract exact attainment under unrestricted policy spaces. The direct strategy below provides an explicit rule with a threshold, a load, and a phase flag; this is a real-valued-state description, not a finite-bit-memory assertion.

### 2.2. Entropy background

Wu and Verdú [WV10, Theorem 1] recall Rényi's information-dimension result for discrete/absolutely continuous mixtures under its finiteness hypotheses. The information dimension equals the mass of the continuous component. That mass is \(q\) for the harmonic threshold law, so the coefficient \(q\) in fine quantization entropy has established information-theoretic context. This observation does not itself prove that arbitrary near-optimal online policies require the same seed entropy. The finite acceptance-trace certificate in Section 7 supplies that all-policy lower bound.

Low-entropy randomness in online decision problems has also been studied directly. Hajiaghayi et al. [HKKO24] analyze entropy of random orderings in a free-order secretary setting; that resource and input model differ from the global seed under a fixed adversarial order considered here. The barely-random framework of Komm and Královič [KK11] uses a constant number of fair random bits. Our arbitrary-probability finite modes and Shannon-entropy resource must not be identified with that framework.

The internal literature review found no direct duplicate of the exact finite-mode hierarchy, the all-policy entropy asymptotic, or the countable-support nonattainment statement in this model. This is a report of the search performed, not an exhaustive priority guarantee.

## 3. The residual-capacity transition and the direct optimal strategy

For a current load \(\ell\in[0,1]\) and a newly arriving positive size \(x\), define greedy filling by
\[
G_x(\ell)=\ell+x\left\lfloor\frac{1-\ell}{x}\right\rfloor.
\]
The residual capacity after this operation lies in \([0,x)\), and hence
\[
\ell\le G_x(\ell)\le1,
\qquad G_x(\ell)>1-x.
\tag{3.1}
\]
Only copies of the current item are used.

The algorithm samples \(T\) once, with
\[
\Pr(T=1/2)=p,
\qquad d\Pr(T=t)=p\frac{dt}{t}\quad(1/2<t<1).
\tag{3.2}
\]
The total mass is \(p(1+\log2)=1\). Before the first positive size at most one half arrives, the algorithm accepts one copy of the first large item \(x\ge T\), if any. After accepting a large item, no other large item fits. At the first positive size \(m\le1/2\), it applies \(G_m\) to its current load and then rejects all subsequent items. Continuing feasible greedy filling afterwards can only improve the guarantee, but is unnecessary for the proof.

This rule knows neither the horizon nor future items. For a fixed finite input, its outcome as a function of \(T\) has a finite partition into threshold-comparison regions, and is bounded between zero and one. In particular, all expectations below are well defined.

### 3.1. All-large inputs

If the input has no positive entries, both online and offline values are zero. Otherwise suppose all positive entries exceed \(1/2\), and let their maximum be \(M\). At most one item fits, so \(\operatorname{OPT}(I)=M\). On every threshold realization satisfying \(T\le M\), the algorithm accepts an item of size at least \(T\), regardless of the arrival order. Thus
\[
\mathbb E[\operatorname{ALG}(I)]
\ge\mathbb E[T\mathbf1_{\{T\le M\}}]
=\frac p2+p\int_{1/2}^{M}dt
=pM.
\tag{3.3}
\]

### 3.2. A pathwise clipping envelope

Let \(m\) be the first positive item of size at most one half. Just before it arrives, each threshold realization has load zero or a single accepted large item \(u>1/2\), with \(u\ge T\). Let \(L_m\) be the load after processing \(m\).

If \(0<m\le1/3\), (3.1) gives
\[
L_m>1-m\ge2/3>p,
\tag{3.4}
\]
where \(\log2>1/2\) gives the last inequality.

Now suppose \(1/3<m\le1/2\), and write
\[
a=1-m=1-b/2,\qquad b=2m.
\]
Then \(1/2\le a\le b\le1\). Define
\[
\phi_{a,b}(t)=\min\{b,\max\{a,t\}\}.
\]
On an empty realization, exactly two copies of \(m\) fit, yielding \(L_m=b\). On a previously loaded realization, (3.1) gives \(L_m>a\), and nondecreasing load gives \(L_m\ge u\ge T\). Therefore, on every realization,
\[
L_m\ge\phi_{a,b}(T).
\tag{3.5}
\]
This argument does not assert that \(G_m(\ell)\) is monotone in \(\ell\); that assertion is generally false. The endpoint \(m=1/3\) is handled by (3.4), because an empty knapsack then takes three copies.

### 3.3. Integrating the envelope

Including the atom in (3.2), direct integration yields
\[
\begin{aligned}
\frac{\mathbb E[\phi_{a,b}(T)]}{p}
&=a+\int_{1/2}^{a}\frac a t\,dt
  +\int_a^b1\,dt+\int_b^1\frac b t\,dt\\
&=b+a\log(2a)-b\log b.
\end{aligned}
\tag{3.6}
\]
The formula is valid when interval endpoints coincide, including \(m=1/2\), where \(a=1/2\) and \(b=1\). The inequalities \(\log z\ge1-1/z\) and \(\log z\le z-1\) for \(z>0\) imply
\[
\begin{aligned}
b+a\log(2a)-b\log b
&\ge b+a-1/2+b(1-b)\\
&=1+(1-b)(b-1/2)\ge1.
\end{aligned}
\tag{3.7}
\]
Together, (3.4)–(3.7) give \(\mathbb E[L_m]\ge p\). Since the offline optimum of every continuation is at most one, the algorithm remains \(C\)-competitive even after stopping. Combining this with (3.3) proves the upper bound in Theorem 1.

The proof also records a quantitative margin: when \(1/3<m\le1/2\),
\[
\mathbb E[\operatorname{ALG}(I)]
\ge\frac{1+(1-2m)(2m-1/2)}{C}.
\tag{3.8}
\]

## 4. A finite lower-bound certificate for arbitrary randomization

Fix \(n\ge1\), and consider the increasing large sizes
\[
s_i=\frac{n+i+1}{2n+1},\qquad 0\le i\le n.
\]
Thus \(s_0>1/2\) and \(s_n=1\). Let \(I_k=(s_0,\ldots,s_k)\). Assign these fixed finite inputs probabilities
\[
w_k=s_0\left(\frac1{s_k}-\frac1{s_{k+1}}\right)\quad(k<n),
\qquad w_n=s_0.
\tag{4.1}
\]
They are nonnegative and sum to one by telescoping.

Fix a deterministic online policy and inspect it on \(I_n\). If it first accepts at index \(i\), unknown-horizon prefix consistency implies that it earns zero on \(I_k\) for \(k<i\), and exactly \(s_i\) on every \(I_k\) with \(k\ge i\). It cannot accept a second item. Its expected gain under (4.1) is therefore
\[
s_i\sum_{k=i}^n w_k=s_0.
\]
A policy that never accepts earns zero. Averaging over any internal randomization preserves the upper bound \(s_0\). The input distribution was fixed without observing that randomness.

On the other hand,
\[
\sum_{k=0}^n w_k\operatorname{OPT}(I_k)
=s_0\left[1+\sum_{j=n+2}^{2n+1}\frac1j\right].
\]
Applying (1.1) to every input in this finite support shows that any competitive ratio must satisfy
\[
R\ge c_n:=1+H_{2n+1}-H_{n+1},
\tag{4.2}
\]
where \(H_j=\sum_{r=1}^j1/r\). Integral comparison for \(1/x\) gives
\[
\log\frac{2n+2}{n+2}
\le H_{2n+1}-H_{n+1}
\le\log\frac{2n+1}{n+1}<\log2.
\]
Consequently,
\[
0<C-c_n\le\log\frac{n+2}{n+1}\le\frac1{n+1}.
\tag{4.3}
\]
Letting \(n\to\infty\) proves the lower bound in Theorem 1. This rederives the known asymptotic lower bound; it is included to make the manuscript self-contained, not as a priority claim.

## 5. Transfer for arbitrary finite threshold partitions

Let \(K\ge1\) and choose any partition
\[
t_1=1/2<t_2<\cdots<t_K<t_{K+1}=1.
\]
Set \(\Delta_i=t_{i+1}-t_i\), and define unnormalized weights
\[
w_1=1+\frac{\Delta_1}{t_1},\qquad
w_i=\frac{\Delta_i}{t_i}\quad(2\le i\le K).
\]
Their total is
\[
R(t)=1+\sum_{i=1}^K\frac{\Delta_i}{t_i},
\qquad \pi_i=\frac{w_i}{R(t)}.
\tag{5.1}
\]
Sample \(T=t_i\) with probability \(\pi_i\), and use the same first-small-item algorithm as in Section 3.

**Proposition 5 (partition transfer).** Every such partition gives a full-model \(R(t)\)-competitive algorithm.

**Proof.** The identities
\[
\sum_{i=1}^K w_it_i=1,
\qquad \sum_{i=1}^j w_it_i=t_{j+1}\quad(1\le j\le K)
\tag{5.2}
\]
follow by telescoping. For an all-large input of maximum \(M\), let \(j\) be the largest index with \(t_j\le M\). On each mode \(i\le j\), the accepted size is at least \(t_i\). Thus its expected gain is at least \(t_{j+1}/R(t)\ge M/R(t)\).

If the first positive small item has size \(m\le1/3\), its realized post-fill load exceeds \(2/3\). Moreover,
\[
R(t)\ge1+\sum_i\Delta_i=3/2,
\]
because \(t_i\le1\). Hence this case also has gain at least \(1/R(t)\).

For \(1/3<m\le1/2\), use \(a=1-m=1-b/2\), \(b=2m\), and the pathwise envelope (3.5). With \(u_+=\max\{u,0\}\), the scalar identity
\[
\phi_{a,b}(t)=t+(a-t)_+-(t-b)_+
\]
and (5.2) give
\[
\sum_i w_i\phi_{a,b}(t_i)
=1+\sum_i w_i(a-t_i)_+-\sum_i w_i(t_i-b)_+.
\tag{5.3}
\]
The increase is at least \(w_1(a-1/2)\ge(1-b)/2\). The loss at the first threshold is zero, and the full loss is
\[
\sum_{t_i>b}\Delta_i\left(1-\frac b{t_i}\right).
\]
If this index set is nonempty, it is a suffix starting at some \(j\), so the corresponding gaps sum to \(1-t_j\le1-b\). Each factor \(1-b/t_i\) is at most \(1-b\). If the suffix is empty, the loss is zero. In either case the loss is at most \((1-b)^2\). Therefore (5.3) is at least
\[
1+\frac{1-b}{2}-(1-b)^2
=1+(1-b)(b-1/2)\ge1.
\tag{5.4}
\]
After normalization, the expected load is at least \(1/R(t)\), sufficient against every continuation because \(\operatorname{OPT}\le1\). This proves the proposition. \(\square\)

The proof uses only finite sums and residual-capacity bounds. It does not require that the original item arrivals follow the order of the thresholds. It also explains why discretization is stable here: in unnormalized form the discrete law is
\[
\delta_{1/2}+\sum_i\frac{\Delta_i}{t_i}\delta_{t_i},
\]
and the atom's benefit controls the upper-threshold clipping loss.

## 6. The exact finite-mode hierarchy

### 6.1. Construction

For \(K\ge1\), let \(r=2^{1/K}\) and set
\[
t_i=\frac12r^{i-1}\quad(1\le i\le K+1).
\]
All gap-to-threshold ratios equal \(r-1\). Proposition 5 gives
\[
R_K=1+K(r-1),
\qquad
\pi_1=\frac r{R_K},\qquad
\pi_i=\frac{r-1}{R_K}\quad(2\le i\le K).
\tag{6.1}
\]
The probabilities are positive and sum to one. For \(K=1\), the single mode is the deterministic threshold \(1/2\) with ratio 2.

Within the partition family, geometric spacing is optimal: the \(K\) ratios \(t_{i+1}/t_i\) have product 2, so AM–GM gives
\[
R(t)=1+\sum_{i=1}^K\left(\frac{t_{i+1}}{t_i}-1\right)
\ge1+K(2^{1/K}-1).
\]
The next argument strengthens this family-level statement to all \(K\)-mode policies.

### 6.2. Lower bound for arbitrary history-dependent modes

Suppose a \(K\)-mode algorithm has finite competitive ratio \(R\), and put \(c=1/R\). Fix \(\alpha\in(1/2,1)\) and an integer \(n\ge1\). Let
\[
\delta=\frac{1-\alpha}{n},\qquad x_j=\alpha+j\delta\quad(0\le j\le n).
\]
Consider all nonempty prefixes of this fixed increasing chain. Each deterministic mode accepts at most one item. Merge positive-probability modes that accept at the same position on the full chain. Let their distinct acceptance values be
\[
a_1<\cdots<a_k,\qquad 1\le k\le K,
\]
with merged probabilities \(v_1,\ldots,v_k\). Modes that never accept are permitted, so \(\sum_i v_i\le1\). The single-item prefix forces \(a_1=\alpha\): otherwise its expected gain would be zero.

Write \(S_i=\sum_{h=1}^i v_ha_h\). Immediately before the next accepted value \(a_{i+1}\), the chain has last value \(a_{i+1}-\delta\). Unknown-horizon consistency and (1.1) imply
\[
S_i\ge c(a_{i+1}-\delta)\quad(i<k),
\qquad S_k\ge c.
\tag{6.2}
\]
Finite summation by parts gives
\[
\sum_{i=1}^k v_i
=\frac{S_k}{a_k}
 +\sum_{i=1}^{k-1}S_i\left(\frac1{a_i}-\frac1{a_{i+1}}\right).
\]
All coefficients are nonnegative. With \(a_{k+1}=1\), substitution of (6.2) yields
\[
\begin{aligned}
R
&\ge1+\sum_{i=1}^k\left(\frac{a_{i+1}}{a_i}-1\right)
 -\delta\left(\frac1\alpha-\frac1{a_k}\right).
\end{aligned}
\tag{6.3}
\]
Pad the \(k\) positive ratios in (6.3) with \(K-k\) copies of 1. Their product is \(1/\alpha\). AM–GM and \(0\le1/\alpha-1/a_k\le1/\alpha\) give
\[
R\ge1+K\bigl(\alpha^{-1/K}-1\bigr)-\frac\delta\alpha.
\tag{6.4}
\]
This inequality holds for every \(n\) and every \(\alpha>1/2\). First let \(n\to\infty\), then let \(\alpha\downarrow1/2\), to obtain \(R\ge R_K\).

The merged acceptance positions may change from one grid to another. No cross-grid consistency of those positions was assumed. Within a grid, each mode may use its entire history. The contradiction to a smaller ratio concerns at least one fixed prefix, chosen without observing the realized seed. This proves Theorem 2 in the oblivious model.

For orientation,
\[
\begin{gathered}
R_1=2,\quad R_2=2\sqrt2-1\approx1.828427,\\
R_3\approx1.779763,\quad R_4\approx1.756828,\quad R_K\downarrow C.
\end{gathered}
\]
The \(K=2\) result sharpens the \(11/6\) upper bound for a nonuniform binary decision in [B25, Corollary 3]. It is not a statement about one fair random bit, and larger \(K\) values are not automatically comparisons with a fixed number of fair bits.

## 7. A finite acceptance-trace certificate

The entropy and nonattainment results require a lower bound that is independent of the form and number of deterministic modes. Fix any randomized online policy with ratio at most \(C+\varepsilon\), where \(\varepsilon\ge0\), and write
\[
c=\frac1{C+\varepsilon}.
\]
For \(n\ge1\), put
\[
\delta=\frac1{2n+1},\qquad a=\frac{1+\delta}{2},
\qquad x_i=a+i\delta\quad(0\le i\le n).
\tag{7.1}
\]
Then \(x_n=1\), and all sizes exceed one half. On the full fixed chain, let \(u_i\) be the probability of accepting at index \(i\), and set
\[
P=\sum_{i=0}^n u_i\le1,
\qquad A_i=\sum_{j=0}^i x_ju_j.
\]
Prefix consistency and competitiveness give \(A_i\ge cx_i\) at every index.

### 7.1. Exact slack budget

Define \(A(x)=A_i\) for \(x_i\le x<x_{i+1}\), and \(A(1)=A_n\). Set
\[
g(x)=A(x)-c(x-\delta)\quad(a\le x\le1).
\tag{7.2}
\]
For \(x_i\le x<x_{i+1}\), we have \(x-\delta\le x_i\), so \(g(x)\ge0\). At each jump its left limit is also nonnegative:
\[
g(x_i-)=A_{i-1}-cx_{i-1}\ge0\quad(i\ge1).
\tag{7.3}
\]
The shift by \(\delta\) is essential; competitiveness on grid points does not directly imply \(A(x)\ge cx\) throughout the intervening intervals.

Each acceptance atom contributes exactly one unit of its probability to the following identity:
\[
P=A_n+\int_a^1\frac{A(x)}{x^2}\,dx,
\tag{7.4}
\]
because its coefficient is \(x_i+x_i\int_{x_i}^1x^{-2}\,dx=1\). This includes the endpoint atom at \(x_n=1\). With \(C_a=1+\log(1/a)\), substitution of (7.2) into (7.4) gives the exact budget
\[
D:=g(1)+\int_a^1\frac{g(x)}{x^2}\,dx
=P-c\left(C_a-\frac\delta a\right).
\tag{7.5}
\]
Since \(P\le1\), \(C-C_a=\log(1+\delta)\le\delta\), and \(\delta/a\le2\delta\),
\[
0\le D\le c(\varepsilon+3\delta).
\tag{7.6}
\]
Every integral here is a finite sum over affine pieces of a finite chain. No infinite input or limiting policy has been introduced.

### 7.2. Squared jump masses

Between jumps, \(g'=-c\). Its jump at \(x_i\), for \(i\ge1\), is \(h_i=x_iu_i\). Integrating the derivative of \(g^2\) on every affine interval and adding every jump, including the jump at 1, yields
\[
g(1)^2-g(a)^2
=-2c\int_a^1g(x)\,dx
 +\sum_{i=1}^n\bigl(2g(x_i-)h_i+h_i^2\bigr).
\tag{7.7}
\]
The initial atom appears through \(g(a)^2\), rather than in the jump sum. By (7.3), the cross terms are nonnegative. Since \(x\le1\),
\[
\int_a^1g(x)\,dx\le\int_a^1\frac{g(x)}{x^2}\,dx\le D,
\qquad 0\le g(1)\le D.
\]
It follows that
\[
\boxed{g(a)^2+\sum_{i=1}^n(x_iu_i)^2\le2cD+D^2.}
\tag{7.8}
\]
This is the resource certificate used below: a small competitive slack forces the noninitial acceptance mass to be dispersed. The elementary square-jump identity itself is not claimed as a new analytic principle.

### 7.3. Explicit near-optimal bounds

For \(0<\varepsilon\le1/16\), choose \(n\) so that \(\delta\le\varepsilon\). Then \(c<1\), \(D\le4\varepsilon\), and
\[
2cD+D^2\le8\varepsilon+16\varepsilon^2\le9\varepsilon.
\]
Because \(x_i\ge a\ge1/2\), (7.8) gives
\[
S:=\sum_{i=1}^n u_i^2\le36\varepsilon.
\tag{7.9}
\]
Moreover, \(g(a)=a(u_0-c)+c\delta\), so
\[
u_0\le c+6\sqrt\varepsilon.
\tag{7.10}
\]
From (7.5) and \(D\ge0\),
\[
P\ge c(C_a-\delta/a)
\ge1-c(\varepsilon+3\delta)
\ge1-4\varepsilon.
\tag{7.11}
\]
In particular, the noninitial acceptance mass \(Q=\sum_{i=1}^n u_i=P-u_0\) satisfies
\[
Q\ge q-6\sqrt\varepsilon-4\varepsilon,
\tag{7.12}
\]
using \(c\le p\). Bounds (7.9)–(7.12) hold for every legal policy and every finite grid chosen as above. There is no assumption that its acceptance events have a common interpretation across different grids.

## 8. The sharp Shannon-entropy rate

### 8.1. Lower bound for all discrete-seed policies

Suppose the entire policy is deterministic conditional on a finite or countably supported seed \(Z\). On the full chain in Section 7, let \(J\) be its first acceptance index, with an extra symbol for never accepting. Then \(J\) is a finite-valued deterministic function of \(Z\), and hence
\[
H(Z)\ge H(J).
\]
This also holds when \(H(Z)=\infty\). Dropping the nonnegative entropy summands for initial acceptance and nonacceptance gives
\[
H(Z)\ge-\sum_{i=1}^n u_i\log u_i.
\]
For sufficiently small \(\varepsilon\), (7.12) gives \(Q>0\), which also implies \(S>0\). Apply the Shannon-versus-collision-entropy inequality to the normalized probabilities \(u_i/Q\):
\[
\begin{aligned}
H(Z)
&\ge Q\log\frac QS\\
&\ge Q\log(1/\varepsilon)+Q\log(Q/36).
\end{aligned}
\tag{8.1}
\]
For completeness, the first inequality follows from Jensen's inequality for \(\log\):
\(\sum_i r_i\log r_i\le\log\sum_i r_i^2\), where \(r_i=u_i/Q\), followed by expansion of \(-\sum_i u_i\log u_i\).

The function \(x\log x\) is bounded below by \(-1/e\) on \([0,1]\). Also \(\sqrt\varepsilon\log(1/\varepsilon)\) and \(\varepsilon\log(1/\varepsilon)\) are bounded as \(\varepsilon\downarrow0\). Substituting (7.12) into (8.1) therefore gives
\[
H(Z)\ge q\log(1/\varepsilon)-O(1),
\tag{8.2}
\]
with a universal constant. Taking the infimum over algorithms preserves this inequality. This is an all-policy conclusion: \(J\) is an output of the algorithm on a fixed input, not a presumed threshold seed or a replacement for the actual global seed.

### 8.2. A matching full-model construction

Use the geometric \(K\)-mode algorithm (6.1). Put \(L=\log2\), \(r=e^{L/K}\), and \(u=L/K\). Taylor's integral remainder, together with \(0\le u\le\log2\), gives
\[
0\le e^u-1-u\le e^u u^2/2\le u^2.
\]
Thus
\[
0\le R_K-C\le\frac{L^2}{K}\le\frac1K.
\tag{8.3}
\]
The first seed probability is \(r/R_K\), and the remaining \(K-1\) probabilities are equal. Furthermore,
\[
\frac{R_K}{r}
=1+(K-1)(1-e^{-L/K})\le1+L=C,
\]
so the first probability is at least \(p\), and the total remaining mass \(Q_K\) is at most \(q\). For \(K\ge2\), with binary entropy \(h(v)=-v\log v-(1-v)\log(1-v)\),
\[
H(Z)=h(Q_K)+Q_K\log(K-1)
\le\log2+q\log K.
\tag{8.4}
\]
Choose \(K=\lceil1/\varepsilon\rceil\) for \(0<\varepsilon<1\). Then \(K\ge2\), \(R_K\le C+\varepsilon\), and \(K\le2/\varepsilon\). Proposition 5 ensures that the competitive guarantee holds for the original full knapsack model, not only for large-item search. Equation (8.4) gives
\[
H(Z)\le q\log(1/\varepsilon)+(1+q)\log2.
\tag{8.5}
\]
Combining (8.2) and (8.5) proves Theorem 3. In bits, divide entropy by \(\log2\); equivalently, the leading coefficient remains \(q\) if the logarithm in (1.4) is also taken to base 2. Section 11.3 translates this entropy result to adaptive expected bit use.

## 9. Countably supported seeds cannot attain the optimum

Set \(\varepsilon=0\) in Section 7, so \(c=p\), and let \(n\to\infty\), equivalently \(\delta\to0\). Equations (7.6) and (7.8) imply
\[
D\le3p\delta,\qquad
S=\sum_{i=1}^n u_i^2=O(\delta),
\qquad u_0\le p+O(\sqrt\delta).
\tag{9.1}
\]
The exact mass budget also gives
\[
P\ge1-3p\delta.
\tag{9.2}
\]
All constants are independent of the algorithm and the grid.

Suppose, for contradiction, that an exact \(C\)-competitive algorithm has a countably supported global seed. By countable additivity, there is a finite set of positive-probability seed atoms whose total mass is \(W>p\). Let \(w>0\) be the smallest probability of an atom in this finite set. Fix this set before choosing the grid.

For sufficiently small \(\delta\), (9.1)–(9.2) ensure simultaneously
\[
1-P<w,\qquad u_0<W,\qquad S<w^2.
\tag{9.3}
\]
Conditional on any one selected seed atom, the policy's behavior on the full finite chain is deterministic. None of the selected atoms can belong to the never-accept event, since that event has probability smaller than \(w\). They cannot all belong to the initial-acceptance event, whose probability is smaller than their total mass \(W\). Thus at least one selected atom accepts at some index \(i\ge1\), forcing \(u_i\ge w\) and hence \(S\ge w^2\). This contradicts (9.3), proving Theorem 4.

The acceptance index of a fixed seed may change on different grids; the proof allows this. What is held fixed is only the finite set of seed atoms and its positive minimum mass. No finite-entropy assumption was used. Nor does the argument concern the algorithm's working memory, the bit complexity of real inputs, or a seed selected after seeing the input.

## 10. Verification status and scope of the conclusions

The direct algorithm, finite partition transfer, all-\(K\)-mode lower bound, entropy certificate, entropy asymptotic, and countable-support nonattainment have undergone internal independent written mathematical review. The review explicitly checked the unknown-horizon quantifiers, oblivious-input requirement, zero-size handling, endpoint cases, and distinction between arbitrary seed probabilities and fair-bit budgets. These checks are documented separately; they are not a substitute for external review or a formal proof artifact.

An independent numerical diagnostic used exact integer capacities and copy counts, with threshold regions integrated separately and logarithms evaluated numerically. It found no counterexample among 74,904 tested inputs. Such tests inspect implementations and boundary cases; they do not establish the universal real-valued claims proved above. The Lean modules contain partial formalization work for the algorithm, threshold expectation, finite-partition certificate, and lower-bound algebra. Full successful compilation, complete theorem coverage, and the required axiom audit have not been established, so the manuscript makes no full-formalization claim.

The research does not extend these theorems to unequal size/value pairs, removals, recovery of rejected items, a known horizon, or an adversary that observes realized random actions. The entropy theorem determines a sharp leading coefficient with an \(O(1)\) remainder; it does not determine the exact minimum entropy for every fixed \(\varepsilon\). The finite-mode theorem is exact for its stated support-size resource, while the nonattainment theorem concerns purely countably supported global seeds. Theorems 5–7 address prescribed finite and mixed sources, and the expected cost of adaptive bit reads.

The full Lean proof is a separate deliverable. The original exact finite checks and threshold diagnostics are available with the [reproduction notes](evidence/README.md).

## 11. Prescribed sources and fair bits

### 11.1. Finite atom masses

**Theorem 5 (prescribed finite source).** For \(R>0\) put
\[
H(R)=\max_{\emptyset\ne I\subseteq[K]}R\,p(I)\prod_{j\notin I}(1+Rp_j).
\]
The exact attained worst-case competitive ratio on the full proportional unbounded knapsack problem is the unique root \(H(R)=2\). In particular for \(K=2^b\) equal atoms (at most \(b\) fair bits, even read adaptively), the equation is
\[
\max_{1\le k\le K}(Rk/K)(1+R/K)^{K-k}=2 .
\]
One maximizing \(k\) is \(\min(K,\lceil K/R\rceil)\). These equal-atom restrictions differ from the arbitrary-probability \(K\)-mode optimum. For one fair bit \(K=2\) the root is \(2\), versus \(2\sqrt2-1\) with freely chosen biases.

**Necessity.** Run every mode on the same finite increasing grid from \(\alpha>1/2\) to one with step \(\delta=(1-\alpha)/n\). Let \(I\) be the nonempty group first accepting at \(\alpha\). Let \(S\) denote current expected collected value, initially \(\alpha p(I)\). Every subsequent acceptance group of mass \(v\) at grid price \(x\) has \(x\le RS+\delta\) by the immediately preceding prefix. Updating \(RS\) multiplies its old value by at most \(1+Rv\) and adds at most \(Rv\delta\). Consequently \(RS+\delta\) increases by factor at most \(1+Rv\), itself at most the product of \(1+Rp_j\) over the group. Never-accepting atoms can be added to the product. Final feasibility \(RS\ge1\) now implies
\[
1+\delta\le(R\alpha p(I)+\delta)\prod_{j\notin I}(1+Rp_j).
\]
The product multiplying the mesh error is at most \(e^R\), independent of the changing groups. Let \(n\to\infty,\ \alpha\downarrow1/2\). Thus \(2\le H(R)\).

**Sufficiency.** \(H\) is continuous, strictly increasing from zero to infinity. At its root choose a maximizing \(I\); write \(v=p(I)\). If \(Rv<1\) and \(j\notin I\), moving \(j\) into \(I\) strictly improves the expression since \(v+p_j>v(1+Rp_j)\). When \(I\) is all atoms its root is two, so in any case \(Rv\ge1\). If equality holds, a further atom can be included with no loss, until \(Rv>1\). At threshold \(1/2\) place total mass \(v\). Set the next threshold to \(Rv/2\). At each subsequent threshold \(t\) place one remaining atom \(p_j\), and set the next threshold to \(t(1+Rp_j)\), in any order. The last right endpoint is exactly one by the root equation. In the case \(I=[K]\) this is just the single interval. On the resulting partition the first unnormalized weight is \(1+(t_2-t_1)/t_1=Rv\); each later one is \((t_{i+1}-t_i)/t_i=Rp_j\). The full-model partition transfer (original manuscript Proposition 5, including mixed small/large items and all continuations) now proves the asserted guarantee. For equal atoms the ratio of adjacent candidate expressions in \(k\) is \((1+1/k)/(1+R/K)\), giving the formula. A bounded adaptive bit reader is a function of its first \(b\) fair bits on every input and thus admits this same global representation, with the same converse construction.

### 11.2. Mixed sources

**Theorem 6 (exact attainment).** On a standard probability space with countably many atoms of total mass \(a\) and an atomless remaining component, the unrestricted optimum \(C=1+\log 2\) is attained if and only if \(a\le 1/C\). Indeed for any finite subset of atoms with minimum mass \(v>0\), run the original mesh certificate (7.5)–(7.8) at \(\varepsilon=0\) and mesh tending to zero. Total never-accept probability tends to zero and the largest noninitial acceptance atom tends to zero. Once both are less than \(v\), every atom in the selected subset must accept at the very first grid point. Its probability tends to \(1/C\) by the initial term in (7.8). Taking the supremum over finite subsets proves necessity. Conversely, put all atoms into the initial threshold mass, split the atomless part to complete that mass to \(1/C\), and map the remainder to the continuous harmonic threshold law of the original exact algorithm. This proves necessity and sufficiency at the optimum beyond purely countable nonattainment.

### 11.3. Expected bits and adaptive acquisition

For comparison, suppose fair bits are all read before the input is revealed and used to sample a global discrete mode. Positive-probability stopped leaves have probabilities \(2^{-\ell}\), so their entropy in bits equals expected length. Taking the mode as their function gives an entropy lower bound. Conversely, partition the unit interval into half-open intervals of the prescribed lengths and sample one uniform point by fair bits. Stop as soon as its dyadic cell is contained in one mode interval. Conditional on an interval of length \(p_i\), after \(j\) reads the undecided portion is within \(2^{-j}\) of the two endpoints. Thus the conditional additional tail probability is at most \(\min(1,2^{1-j}/p_i)\), giving expected length at most \(\log_2(1/p_i)+4\) for this mode. Averaging proves the sharp leading bound for presampling. The finite computable probabilities in Section 8.2 suffice for the upper bound. The interval simulation and its additive-constant cost are classical, as in [HH97]. The online lower bound below uses a fixed input and the stopped bit-string on that input.

**Theorem 7 (adaptive expected bits).** Even if arbitrarily many fair bits may be requested as data arrive and only the supremum, over deterministic inputs, of their expected number is charged, the sharp cost for ratio \(C+\varepsilon\) is \(q\log_2(1/\varepsilon)+O(1)\), \(q=1-1/C\). On the one finite full mesh used by original (7.9)–(8.2), acceptance index is a function of the stopped bit-string on that input. Its positive-probability terminal strings form a prefix code, so expected reads dominate acceptance entropy. Infinite expected reads already satisfy the lower bound. The earlier finite presampling construction gives the same upper bound. At exact optimum the supremum of expected reads is therefore infinite. The optimal harmonic threshold can still be sampled lazily with finite expected reads on each fixed finite input. Represent the mixed law by a uniform point on \([0,1]\), with the initial atom determined by one interval. Each comparison with an item threshold is decided as soon as the point's dyadic cell avoids that comparison's fixed boundary. Each boundary has an undecided set of length at most \(2^{1-j}\) after \(j\) reads, and any fixed input generates at most a finite number of comparison boundaries. Summing the union bound over \(j\) gives finite expectation on that input.

### 11.4. Comparison and scope

 Böckenhauer et al. [B25, Theorem 2] already give the one-fair-bit ratio 2. Their Corollary 2 gives the two-fair-bit upper bound \(24/13\). With \(K=4\), the maximizing \(k=3\) in Theorem 5 gives the exact smaller ratio \((2\sqrt{33}-6)/3\). Their Corollary 3 gives an \(11/6\) achievable ratio for one biased binary choice. The prescribed-mass formula covers both resources and makes their different optima explicit. Bienkowski–Pacut–Piecuch give an asymptotic uniform-mode construction by reducing through multiple knapsacks, without this prescribed-source optimum. The threshold partition transfer and mesh rigidity estimates are inherited and not new. This proof applies to every fixed source with finitely many atoms, all fair bit budgets and the exact mixed-source attainment boundary. Computation of the subset maximum for general rational masses could still require exponential work; no complexity classification is claimed.

## References

**[B25]** H.-J. Böckenhauer, M. Gehnen, J. Hromkovič, R. Klasing, D. Komm, H. Lotze, D. Mock, P. Rossmanith, and M. Stocker. *Online Unbounded Knapsack*. Theory of Computing Systems 69, article 14, 2025. [DOI](https://doi.org/10.1007/s00224-025-10215-0); [publisher full text](https://link.springer.com/article/10.1007/s00224-025-10215-0); [arXiv version](https://arxiv.org/abs/2407.02045).

**[BPP20]** Marcin Bienkowski, Maciej Pacut, and Krzysztof Piecuch. *An Optimal Algorithm for Online Multiple Knapsack*. ICALP 2020, LIPIcs 168, article 13. [DOI](https://doi.org/10.4230/LIPIcs.ICALP.2020.13); [full text](https://drops.dagstuhl.de/storage/00lipics/lipics-vol168-icalp2020/LIPIcs.ICALP.2020.13/LIPIcs.ICALP.2020.13.pdf).

**[GS26]** Matthias Gehnen and Moritz Stocker. *Stealing from the Dragon's Hoard: Online Unbounded Knapsack With Removal*. STACS 2026, LIPIcs 364, article 43. [DOI](https://doi.org/10.4230/LIPIcs.STACS.2026.43); [full text](https://drops.dagstuhl.de/storage/00lipics/lipics-vol364-stacs2026/html/LIPIcs.STACS.2026.43/LIPIcs.STACS.2026.43.html).

**[JLTZ21]** Zhihao Jiang, Pinyan Lu, Zhihao Gavin Tang, and Yuhao Zhang. *Online Selection Problems against Constrained Adversary*. ICML 2021, Proceedings of Machine Learning Research 139:5002–5012. [Full text](https://proceedings.mlr.press/v139/jiang21h/jiang21h.pdf).

**[SNTB24]** Bo Sun, Hossein Nekouyan Jazi, Xiaoqi Tan, and Raouf Boutaba. *Static Pricing for Online Selection Problem and its Variants*. WINE 2024; arXiv:2410.07378. [arXiv entry](https://arxiv.org/abs/2410.07378); [author full text](https://rboutaba.cs.uwaterloo.ca/Papers/Conferences/2023/sun-wine24.pdf).

**[EFKT01]** Ran El-Yaniv, Amos Fiat, Richard M. Karp, and Gordon Turpin. *Optimal Search and One-Way Trading Online Algorithms*. Algorithmica 30:101–139, 2001. [DOI](https://doi.org/10.1007/s00453-001-0003-0); [public full text](https://www.cs.toronto.edu/~bor/2421f19/papers/one-way-trading.pdf).

**[CHKK16]** Jhoirene Clemente, Juraj Hromkovič, Dennis Komm, and Christian Kudahl. *Advice Complexity of the Online Search Problem*. IWOCA 2016, LNCS 9843:203–212. [DOI](https://doi.org/10.1007/978-3-319-44543-4_16); [full preprint](https://arxiv.org/pdf/1612.09299). The reviewed preprint is arXiv:1612.09299v2, revised in 2017; the proceedings publication is from 2016.

**[WV10]** Yihong Wu and Sergio Verdú. *Rényi Information Dimension: Fundamental Limits of Almost Lossless Analog Compression*. IEEE Transactions on Information Theory 56(8):3721–3748, 2010. [DOI](https://doi.org/10.1109/TIT.2010.2050803); [full text](https://web.mit.edu/~6.454/www/papers/renyidim.pdf).

**[HKKO24]** Mohammad Taghi Hajiaghayi, Dariusz R. Kowalski, Piotr Krysta, and Jan Olkowski. *Online Sampling and Decision Making with Low Entropy*. IJCAI 2024:4080–4088. [DOI](https://doi.org/10.24963/ijcai.2024/451); [proceedings entry](https://www.ijcai.org/proceedings/2024/451); [full research version](https://arxiv.org/pdf/2111.13203).

**[KK11]** Dennis Komm and Richard Královič. *Advice Complexity and Barely Random Algorithms*. RAIRO – Theoretical Informatics and Applications 45(2):249–267, 2011. [DOI](https://doi.org/10.1051/ita/2011105); [full text](https://www.numdam.org/item/ITA_2011__45_2_249_0.pdf).

**[HH97]** Te Sun Han and Mamoru Hoshi. *Interval Algorithm for Random Number Generation*. IEEE Transactions on Information Theory 43(2):599–611, 1997. [DOI 10.1109/18.556116](https://doi.org/10.1109/18.556116).
