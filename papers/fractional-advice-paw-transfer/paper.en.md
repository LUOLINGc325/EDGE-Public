# Lossless PAW Guarantees for Fractional Advice via Capacity Pairing

Research manuscript · 25 November 2026 · Version 1

## Abstract

We give a deterministic online algorithm for unweighted fractional bipartite matching with arbitrary feasible fractional advice revealed with each arrival. For every trust parameter \(\lambda\in[0,1]\), the algorithm attains the same robustness and consistency guarantees as the integral-advice Push-and-Waterfill (PAW) algorithm of Choo, Jin, and Shin. It needs neither future advice, a common denominator, nor the number of arrivals. The proof first extends PAW to unequal resource capacities and arrival supplies under an exact capacity-pairing condition. A causal splitting reduction then meets that condition for every positive advised mass. We prove that all virtual resources belonging to one original vertex occupy at most two normalized levels. Consequently the construction has two real state coordinates per offline vertex and polynomial arithmetic complexity. For rational advice and a rational trust parameter, the reference algorithm also has polynomial bit complexity. An exact counterexample shows why a direct unpaired capacity extension does not preserve the PAW guarantee. The numerical curve and its splitting functions are inherited from PAW; capacity virtualization and lazy proportional splitting have prior precedents. The contribution is their capacity-correct combination, the resulting fractional-advice guarantee, and the two-level implementation. No formal proof-assistant verification is claimed.

## 1. Problem, source boundary, and result

### Definition D1. Online model and benchmarks

Let \(U=\{1,\ldots,n\}\) be a known finite set of offline vertices, each of capacity one. The algorithm sees a finite sequence of online vertices \(v=1,\ldots,T\), but does not know \(T\) in advance. Arrival \(v\) reveals its neighborhood \(N_v\subseteq U\) and nonnegative advice \(a_{uv}\) supported on \(N_v\). Assume

\[
\sum_{u\in N_v}a_{uv}\le1\quad\text{for every }v,
\qquad \sum_{v:u\in N_v}a_{uv}\le1\quad\text{for every }u.
\tag{1}
\]

The advice is feasible, but need not be accurate or optimal. It may contain arbitrary real values. On each arrival, the algorithm must irrevocably return nonnegative edge allocations \(x_{uv}\), obeying the same row and column bounds. Its value is \(\mathrm{ALG}=\sum x_{uv}\). Write \(\mathrm{ADV}=\sum a_{uv}\), and let \(\mathrm{OPT}\) be the maximum value of a feasible fractional matching in the revealed graph. Empty neighborhoods, zero advice, saturated resources, and the empty sequence are allowed.

Set

\[
r_\lambda=1-\left(1-\lambda+\frac{\lambda^2}{2}\right)e^{\lambda-1},
\qquad c_\lambda=1-(1-\lambda)e^{\lambda-1}.
\tag{2}
\]

These are the published integral-advice PAW guarantees [CJS25, Theorem 3]. That paper's Section 7 identifies the missing comparable fractional-advice guarantee. A later allocation framework [LMP26, Section 1.1] explicitly separates its weighted guarantees from the stronger unweighted PAW curve. Its Appendix D already develops virtual capacities and lazy proportional splitting. We use and credit those ideas; we prove the additional PAW capacity theorem needed here. The relevant historical journal comparator is the advice/optimal-benchmark framework of [MNS12].

### Theorem ALG1. Full fractional-advice guarantee

For every \(n\ge0\) and every \(\lambda\in[0,1]\), the algorithm in Section 2 is deterministic, causal, and feasible. For every input in Definition D1,

\[
\mathrm{ALG}\ge \max\{r_\lambda\mathrm{OPT},\;c_\lambda\mathrm{ADV}\}.
\tag{3}
\]

It uses no future arrival information, future advice, advance horizon, rationality assumption, or fixed advice precision. The two bounds hold for the same execution, separately; they are not an additive guarantee. This result transfers an achievable curve. It does not establish that the curve is the optimal Pareto frontier, extend to heterogeneous per-unit rewards, or unify the LAB analysis.

The proof is constructive: Section 3 proves benchmark preservation and causality, Section 4 proves exact compression, and Appendix A supplies every capacity-weighted PAW certificate used in the argument.

## 2. An explicit algorithm with two levels per resource

### Definition D2. State and ordering

Fix any total order of \(U\) before processing arrivals. For each \(u\), store \(A_u\in[0,1]\), the total advice mass already processed for that resource, and \(z_u\in[0,1]\), its lower normalized level. Initially \(A_u=z_u=0\). Its physical load is represented by

\[
X_u=(1-A_u)z_u+A_u\max\{\lambda,z_u\}
    =z_u+A_u(\lambda-z_u)_+.
\tag{4}
\]

Here \(A_u\) is nominal capacity assigned to advice, not physically unused capacity. The distinction is necessary when earlier waterfilling has already used some of a future advised resource.

When \(v\) arrives, initialize its output row to zero. Process each \(u\in N_v\) with \(a_{uv}>0\), in the fixed order, as one subarrival of supply \(a=a_{uv}\):

1. Send \(p=a(\lambda-z_u)_+\) to \(u\), and increase \(A_u\) by \(a\). This leaves all other \(A\)'s and all lower levels unchanged.
2. Waterfill the remaining supply \(a-p\) over the original neighborhood \(N_v\), using the operation below. Add its physical increments to the same output row.

Finally process an unadvised subarrival of supply \(1-\sum_u a_{uv}\), using only waterfilling. A zero subarrival can be skipped. Return the summed output row before the next original vertex arrives.

### Definition D3. Weighted two-level waterfilling

For current state and supply \(D\ge0\), define

\[
H_v(h)=\sum_{u\in N_v}
 \bigl[(1-A_u)(h-z_u)_+
       +A_u(h-\max\{\lambda,z_u\})_+\bigr],
\qquad 0\le h\le1.
\tag{5}
\]

Take the largest \(h\in[0,1]\) satisfying \(H_v(h)\le D\). Update \(z_u\leftarrow\max\{z_u,h\}\) for \(u\in N_v\), and allocate the resulting increase in (4) to \(u\). Discard supply only after the neighborhood is saturated. Empty neighborhoods allocate nothing. For \(D=0\), an implementation may leave state unchanged: raising a fictitious lower level when \(A_u=1\) changes no physical allocation and has no effect on future positive advice.

The function in (5) is a finite weighted sum of positive parts. Sort the at most \(2|N_v|\) positive-capacity bin levels. Move the common level upward until the supply is exhausted or level one is reached. Between consecutive breakpoints the slope is the sum of active bin capacities, so the final level requires one division by a positive active capacity. This is an exact finite operation, not numerical integration or a limit over increasingly fine copies.

## 3. Pairing capacities and preserving the online model

### Theorem CAP1. Capacity-matched PAW

Consider resources of arbitrary capacities \(b_j>0\) and online supplies \(d_i>0\), with unweighted value per physical unit. Each arrival has at most one advised resource. Advised resources are distinct, and every advised pair satisfies \(d_i=b_{a(i)}\). Raise the advised resource's normalized load to \(\lambda\), then waterfill the remaining supply using normalized levels and physical capacities. The resulting algorithm satisfies

\[
\mathrm{ALG}_{\rm virt}\ge r_\lambda\mathrm{OPT}_{\rm virt},
\qquad
\mathrm{ALG}_{\rm virt}\ge c_\lambda\mathrm{ADV}_{\rm virt}.
\tag{6}
\]

The normalized certificates, rather than unweighted physical totals, must satisfy the edge inequalities. Appendix A proves this theorem from finite capacity inequalities and explicit scalar integrals. Arbitrary neighbor capacities and loads accumulated during earlier arrivals are allowed; all resources start empty. Matching the advised supply to its target's nominal capacity is the essential hypothesis.

### Lemma LIFT1. Full paired instance and exact benchmark preservation

Fix an arbitrary completed input for analysis. For each original resource \(u\), partition its unit nominal capacity into one block of capacity \(a_{uv}\) for every positive advised edge, and a residual block of capacity \(1-\sum_v a_{uv}\). Omit zero blocks. For each original arrival \(v\), create one subarrival of supply \(a_{uv}\) for every positive advised edge, and a residual subarrival of supply \(1-\sum_u a_{uv}\). Omit zero-supply subarrivals as well. A subarrival corresponding to \((u,v)\) advises precisely that edge's resource block. A residual subarrival has no advice. Order subarrivals as in Section 2.

Each subarrival has every block of each original neighbor as a neighbor. Then

\[
\mathrm{OPT}_{\rm virt}=\mathrm{OPT},
\qquad \mathrm{ADV}_{\rm virt}=\mathrm{ADV}.
\tag{7}
\]

**Proof.** Advice pairs are distinct and have equal positive capacity and supply. Any feasible virtual allocation projects to an original allocation by summing all flows between descendants of the same pair \((u,v)\). Original capacities and supplies are the sums of their descendant capacities and supplies; feasibility and value are preserved. Thus \(\mathrm{OPT}_{\rm virt}\le\mathrm{OPT}\).

Conversely, let \(y_{uv}\) be any feasible original allocation. If block \(j\) of \(u\) has capacity \(b_j\), and subarrival \(i\) of \(v\) has supply \(d_i\), set

\[
\widetilde y_{ji}=b_jd_i y_{uv}.
\tag{8}
\]

The capacities of all blocks of \(u\), and the supplies of all subarrivals of \(v\), each sum to one. Hence the column load in (8) is \(b_j\sum_v y_{uv}\le b_j\), the row load is \(d_i\sum_u y_{uv}\le d_i\), and the total value is \(\sum_{uv}y_{uv}\). All positive entries lie on virtual edges. This proves the reverse inequality in (7). The advised-pair supplies sum to \(\sum_{uv}a_{uv}\), proving advice preservation. ∎

The completed partition is only an analysis device. Knowing it in advance is not an input to the algorithm.

### Lemma LAZY1. Proportional splitting is causal and irrevocable after projection

Before an advised edge \((u,v)\) is processed, maintain one residual resource representing all not-yet-advised capacity of \(u\). Its capacity is \(R_u=1-A_u\). By (1), \(0<a_{uv}\le R_u\). Split it into a target block of capacity \(a_{uv}\) and a residual block of capacity \(R_u-a_{uv}\), giving both children the parent's normalized load. All earlier internal flows, if explicitly stored, are divided in the same capacity proportions. Then run the next paired subarrival.

This construction produces exactly the projected execution on the full paired instance and changes no already-issued original allocation.

**Proof.** In the full instance, all resource blocks of \(u\) whose advised time has not arrived have identical normalized loads. Initially all loads are zero. Such blocks have the same neighborhoods; none has yet received an advised push. During every earlier waterfill, each is raised from its common height \(s\) to \(\max\{s,h\}\), so it receives physical mass equal to its capacity times the same height increment. They therefore remain indistinguishable except for capacity. Replacing them with their summed capacity preserves the waterfill cost function exactly.

When the next block is revealed, its capacity is the current \(a_{uv}\); the remainder is computed from already processed advice. Splitting the normalized load recreates precisely the full-instance state. Proportional subdivision of an old virtual flow changes only an internal accounting partition: both children project to the same original resource, so every previously emitted \(x_{uw}\) is unchanged. Applying this argument inductively at every subarrival proves the claim. No future partition or final horizon is used. ∎

### Proof of Theorem ALG1

The construction of Lemma LIFT1 satisfies all hypotheses of CAP1. Lemma LAZY1 provides a causal simulation of its projected allocation. The two-level implementation is exactly that simulation by Lemma TWO1 below. Virtual feasibility projects to original feasibility, and (6) together with (7) proves (3). All arguments apply to every finite prefix. ∎

## 4. Exact compression and endpoint behavior

### Lemma TWO1. At most two physical levels per original resource

At every subarrival boundary, all not-yet-advised blocks of an original resource \(u\) have a common normalized height \(z_u\), and all previously advised blocks have height \(\max\{\lambda,z_u\}\). Their total capacities are \(1-A_u\) and \(A_u\), respectively. Consequently (4) and (5) exactly describe the full virtual execution.

**Proof.** At time zero, only the lower class has positive mass and every level is zero. Suppose the claim holds before processing a positive advice mass \(a\) for \(u\). Its block is cut out of the lower class at height \(z_u\). The push raises it to \(\max\{\lambda,z_u\}\), so it joins all previously advised blocks at their common height. Moving its capacity from the lower class to the upper class increases physical load by exactly \(a(\lambda-z_u)_+\).

For a subsequent waterfill level \(h\), a lower block reaches \(\max\{z_u,h\}\) and an upper block reaches

\[
\max\{\lambda,z_u,h\}=\max\{\lambda,\max\{z_u,h\}\}.
\tag{9}
\]

Thus the property is preserved with the new lower level \(\max\{z_u,h\}\). Summing capacity times height increment yields precisely (5). Resources outside the current neighborhood do not change. This proves the induction for advised and residual subarrivals alike.

If the lower class has zero capacity, retain its fictitious lower coordinate. Until it exceeds \(\lambda\) it does not affect any positive-capacity bin; after that it equals the physical upper height. No further positive advice may be assigned to that resource because \(A_u=1\). Therefore the representation remains valid at the boundary. ∎

### Corollary END1. Original algorithm and trust endpoints

With integral advice, Section 2 returns exactly the original unit-capacity PAW allocation for each arrival. At \(\lambda=0\), it returns ordinary waterfilling and \(r_0=c_0=1-e^{-1}\). At \(\lambda=1\), it is one-half robust and fully consistent.

**Proof.** Under integral advice each \(A_u\) is either zero or one; exactly one of that resource's two bins has positive capacity. Each original arrival has just one positive-supply subarrival, either its advised unit or the residual unit. The push and waterfill therefore coincide with ordinary PAW.

When \(\lambda=0\), both levels of a resource are equal and there is no push. Successive waterfills over the same neighborhood compose to a single waterfill of the summed supply: below saturation, the accumulated cost of raising heights to a level telescopes; after saturation, both operations discard the same unused supply. The artificial subarrivals can thus be recombined. Substitution in (2) gives the first endpoint constants. At \(\lambda=1\), every virtual advised target is filled when its subarrival is processed, and (2) gives \((r_1,c_1)=(1/2,1)\). ∎

## 5. Implementation and numerical representation

### Theorem COMP1. Arithmetic count and state size

Let \(k_v=|N_v|\), \(p_v=|\{u:a_{uv}>0\}|\), and \(m=\sum_v k_v\). The algorithm uses two real state coordinates per offline vertex. It can be implemented with

\[
O\!\left(n+T+\sum_v(p_v+1)k_v\log(k_v+1)\right)
\tag{10}
\]

exact arithmetic operations and comparisons, and \(O(n)\) working coordinates excluding streamed input and output. The count is independent of numerical denominators. In particular it is polynomial in the revealed graph size. This describes a real-arithmetic model, not a finite automaton or constant-bit storage.

**Proof.** There are at most \(p_v+1\) subarrivals for \(v\). Each uses at most \(2k_v\) positive-capacity bins. Sorting, scanning their breakpoints, and updating the affected coordinates costs \(O(k_v\log(k_v+1))\). An empty neighborhood takes constant time. The output row and bin list use \(O(k_v)\le O(n)\) temporary coordinates. No block history, expanded graph, or past output is needed. Initialization costs \(O(n)\), proving (10). ∎

### Theorem BIT1. Exact rational execution has polynomial bit complexity

If every advice value and \(\lambda\) is rational in binary encoding, Section 2 can be executed exactly in time polynomial in the finite input's total bit length and graph size. The algorithm does not need the future input length or a future common denominator. The exponentials in (2) are used in the proof, not in execution.

**Proof.** For analysis only, let \(D\) be the product of all denominators of the advice in the completed finite input, and let \(q\) be the denominator of \(\lambda\). If the total numeric encoding length is \(L\), then \(\log D+\log q=O(L)\). Every advice mass, cumulative \(A_u\), bin capacity, and residual subarrival supply has denominator dividing \(D\).

Maintain a common analysis denominator \(H\) for all current lower levels and \(\lambda\); initially take \(H=q\). A push changes an upper level only to \(\lambda\); its physical mass has denominator dividing \(DH\). During a waterfill scan, the levels at intermediate breakpoints are old levels or \(\lambda\). The unspent mass and all products of bin capacity with height differences have denominator dividing \(DH\). At the last active segment, its positive active capacity is \(M/D\), with an integer \(1\le M\le nD\). The computed level therefore has denominator dividing \(HM\). Replacing the common analysis denominator by \(HM\) preserves divisibility for every old level as well. Saturation at one needs no such enlargement.

After \(S\) waterfill operations,

\[
\log H\le\log q+S\log(nD)
=O\bigl((S+1)(L+\log(n+1))\bigr)
\tag{11}
\]

when \(n\ge1\); the case \(n=0\) has no arithmetic state to update. All levels lie in \([0,1]\), which bounds their numerators at the same bit scale. Flow amounts have denominators dividing the corresponding \(DH\); old denominators divide later ones, so summing a returned row preserves the bound. Scan accumulators and active integer sums add only polynomially many magnitude bits. Thus every operand has polynomial bit length. Together with (10) and ordinary polynomial-time integer arithmetic, this proves the assertion. \(D\) and \(H\) are proof devices and are never supplied to the online algorithm. ∎

The executable in `code/paw_fractional.py` is the exact rational reference implementation. It validates revealed advice feasibility and returns each row before the next call. It does not implement oracle access to arbitrary real numbers. Computational comparisons are documented separately and do not replace the theorems.

## 6. Scope boundary and a wider capacitated corollary

### Proposition NEG1. Unpaired normalized PAW can violate the curve

Simply applying normalized PAW to a partially advised resource of arbitrary capacity does not preserve (2). At \(\lambda=2/3\), use offline capacities \(b_u=1\), \(b_w=2/3\). The first arrival has supply \(2/3\), neighbors \(\{u,w\}\), and advises all its supply to \(u\); the second has supply one, only neighbor \(u\), and no advice. A naive push-to-\(\lambda\) rule obtains one unit, while the optimum obtains \(5/3\). Its ratio \(3/5\) is strictly smaller than \(r_{2/3}\), because

\[
e^{1/3}>1+1/3+1/18=25/18,
\qquad r_{2/3}=1-\tfrac59e^{-1/3}>3/5.
\tag{12}
\]

The first advised pair violates the equality of supply and target capacity. Appendix A gives the allocation calculation. This counterexample concerns that particular naive rule; it is not an impossibility result for arbitrary-advice algorithms. The paired lift deliberately avoids it.

### Corollary MASS1. Arbitrary resource capacities and arrival supplies

The same guarantees hold for unweighted throughput with arbitrary positive original capacities \(B_u\), positive arrival supplies \(D_v\), and any feasible fractional advice masses \(a_{uv}\). There is no restriction on ratios of the original capacities and supplies.

**Proof.** Repeat LIFT1, splitting each \(B_u\) into its advised masses and its remaining nominal capacity, and each \(D_v\) into advised masses and residual supply. Positive advised blocks and subarrivals again have equal mass. For a feasible original allocation \(y\), the lifted flow is now

\[
\widetilde y_{ji}=\frac{b_j}{B_u}\frac{d_i}{D_v}y_{uv}.
\tag{13}
\]

Summing over descendant blocks proves all capacity inequalities and preserves value, exactly as in (8). Causal splitting is unchanged. Store the absolute advised mass \(A_u\in[0,B_u]\), and replace (4) by

\[
X_u=(B_u-A_u)z_u+A_u\max\{\lambda,z_u\}.
\tag{14}
\]

In (5), replace \(1-A_u\) by \(B_u-A_u\); the pushed mass remains \(a_{uv}(\lambda-z_u)_+\). The proof of TWO1 and the arithmetic count are unchanged. CAP1 and benchmark preservation finish the proof. Zero original capacity or supply is omitted. Heterogeneous rewards remain outside this corollary. ∎

## 7. Verification, novelty, and delivery boundaries

The manuscript separates three types of evidence. Appendix A and Sections 3–6 are analytic proofs. Exact rational programs test feasibility and the equality between a fully expanded reference and the causal two-level implementation on finite instances. Floating-point evaluations of certificate inequalities serve only as diagnostics. The accompanying review records identify their actual coverage and bind the final manuscript hash.

The central claim is the arbitrary-fractional-advice PAW guarantee and its explicit implementation. The curve, the exponential/linear splitting functions, and the primal-dual proof framework come from [CJS25]. The full-partition/lazy-splitting method has a direct precedent in [LMP26]. The capacity pairing, capacity-weighted certificates, two-level representation, and resulting bound in the model of D1 are the candidate new contribution. An accessible published problem statement and a bounded search do not establish worldwide priority. The exact searches, materials read, and comparison limitations are recorded in `NOVELTY_AUDIT.md` and `SOURCES.json`.

The journal comparison uses the author-hosted 28 December 2009 manuscript of [MNS12], with the 2012 publication metadata separately verified. The final ACM typeset text was not accessible. Its advice/optimal-benchmark algorithmic guarantee is the technical comparison; the present narrower result does not claim to exceed that paper's coverage of multiple online problems.

This delivery contains no Lean source, no compiler result, and no completed formalization receipt. Full formalization remains required. Task cards must cover the main theorem, capacity certificates, splitting and compression, complexity, endpoints, the negative example, and MASS1; they may be released as approved-paper cards only after the final written and actual-value reviews pass.

## References

- **[CJS25]** Davin Choo, Billy Jin, Yongho Shin. *Learning-Augmented Online Bipartite Fractional Matching*. NeurIPS 2025. DOI: [10.52202/085713-0262](https://doi.org/10.52202/085713-0262). Full version: [arXiv:2505.19252v2](https://arxiv.org/html/2505.19252v2), 29 October 2025. Relevant parts: Definition 4, Theorem 3, Sections 4.2–4.3 and 7. PAW pseudocode is Algorithm 4 in the full arXiv version, and Algorithm 2 in Appendix A of the 16-page conference PDF; these version-specific numbers are not interchangeable.
- **[LMP26]** Alexander Lindermayr, Nicole Megow, Lauren Paul. *Consistency–Robustness Tradeoffs for Online Bipartite Allocation with Multiple Stages*. [arXiv:2609.15837v1](https://arxiv.org/html/2609.15837v1), 14 September 2026. Relevant parts: Section 1.1, Theorems 2–3, Appendix D.1 and D.6. Preprint; not represented as a journal publication.
- **[MNS12]** Mohammad Mahdian, Hamid Nazerzadeh, Amin Saberi. *Online Optimization with Uncertain Information*. ACM Transactions on Algorithms 8(1), Article 2, 2012. DOI: [10.1145/2071379.2071381](https://doi.org/10.1145/2071379.2071381). Technical material checked: [author-hosted manuscript](https://faculty.marshall.usc.edu/Hamid-Nazerzadeh/pdf/talg_uncertain_info.pdf), dated 28 December 2009, especially Section 4. Publication metadata: [Google Research](https://research.google/pubs/online-optimization-with-uncertain-information/).

# Appendix A. Complete capacity-weighted PAW proof

The following appendix is part of the same manuscript and must be included in the formalization coverage. Its Lemmas A1–A8 establish CAP1; its last example supplies NEG1. The PAW potentials are credited to [CJS25]. The capacity extension and all normalizations are proved here.

## A.1. Scope, notation, and attribution

The objective throughout is **unweighted throughput**, meaning one unit of value per unit of allocated mass. The theorem does not assert a result for heterogeneous per-unit rewards or general AdWords bids.

Fix a finite set \(J\) of offline resources, with capacities \(b_j>0\). A finite sequence of arrivals \(i=1,\ldots,T\) is revealed online. Arrival \(i\) reveals its supply \(d_i>0\), its neighbor set \(N_i\subseteq J\), and an advice label \(a(i)\in N_i\cup\{\bot\}\). The algorithm need not know \(T\). An allocation \(x\) is feasible if

\[
x_{ji}\ge0,\qquad x_{ji}=0\quad(j\notin N_i),\qquad
\sum_jx_{ji}\le d_i,\qquad \sum_ix_{ji}\le b_j.
\]

Its value is \(\sum_{j,i}x_{ji}\). Define \(\mathrm{OPT}\) to be the maximum feasible value. Advice satisfies the following two restrictions:

1. Each offline resource is advised at most once: if \(a(i)=a(i')\ne\bot\), then \(i=i'\).
2. An advised pair has equal capacities: \(a(i)=j\ne\bot\) implies \(d_i=b_j\).

Thus following advice would allocate the entire supply of each advised arrival to its target; it is feasible, and

\[
\mathrm{ADV}=\sum_{i:a(i)\ne\bot}d_i.
\]

The equal-capacity requirement is a precise structural hypothesis. It cannot be dropped from the argument below merely by rescaling the notation.

**Baseline attribution.** The unit-capacity PAW algorithm, its two functions \(g_r,g_c\), and its numerical guarantee originate in Choo, Jin, and Shin, *Learning-Augmented Online Bipartite Fractional Matching*, NeurIPS 2025, DOI [10.52202/085713-0262](https://doi.org/10.52202/085713-0262). The full primary text is [arXiv:2505.19252v2](https://arxiv.org/html/2505.19252v2), Sections 4.2–4.3. The present argument verifies the capacity-matched extension with the correctly weighted certificates. It does not rebrand the PAW potentials as new.

## A.2. Algorithm

Fix \(\lambda\in[0,1]\). Let \(s_j\in[0,1]\) be the normalized load on resource \(j\): its physical load is \(b_js_j\). Initially every \(s_j=0\).

At arrival \(i\), perform the following operations.

**Push.** If \(a(i)=j\), allocate

\[
\tau_i=b_j(\lambda-s_j)_+=d_i(\lambda-s_j)_+
\]

to \(j\). If \(a(i)=\bot\), set \(\tau_i=0\). Write \(s_j^+\) for the loads after this operation. There is no push to any other resource.

**Waterfill.** Write \(D_i=d_i-\tau_i\ge0\), and define

\[
Q_i(h)=\sum_{j\in N_i}b_j(h-s_j^+)_+,\qquad 0\le h\le1.
\]

Choose

\[
\ell_i=\max\{h\in[0,1]:Q_i(h)\le D_i\}.
\]

The maximum exists because the feasible set is nonempty, closed, and contained in a compact interval. Allocate an additional \(b_j(\ell_i-s_j^+)_+\) to each \(j\in N_i\). Its new normalized load is \(\max\{s_j^+,\ell_i\}\). Any supply left when all neighbors are saturated is discarded.

This definition also handles \(D_i=0\), saturated neighborhoods, and empty neighborhoods without an arbitrary tie choice. If \(N_i=\varnothing\), then \(Q_i\equiv0\), \(\ell_i=1\), and no allocation is made.

### Lemma A1. Feasibility and final minimum level

Every allocation made by the algorithm is feasible. For nonempty \(N_i\), the minimum normalized load over its neighbors after arrival \(i\) is exactly \(\ell_i\). If \(\ell_i<1\), then the arrival's entire supply \(d_i\) is allocated.

**Proof.** The push is nonnegative, at most \(d_i\), and at most the target's remaining capacity, because

\[
0\le(\lambda-s_j)_+\le1-s_j\le1.
\]

Waterfill respects \(\ell_i\le1\) and uses at most \(D_i\). It allocates only on present edges. Consequently all row and column capacities are preserved.

If \(N_i\ne\varnothing\), the largest feasible level cannot be strictly below \(\min_{j\in N_i}s_j^+\), since \(Q_i=0\) up to that minimum. Thus the new minimum is \(\ell_i\). If \(\ell_i<1\) but \(Q_i(\ell_i)<D_i\), continuity would permit a slightly larger feasible level, contradicting maximality. Therefore \(Q_i(\ell_i)=D_i\) whenever \(\ell_i<1\). Adding the push gives total allocation \(d_i\). ∎

## A.3. Main theorem

Define

\[
r(\lambda)=1-\left(1-\lambda+\frac{\lambda^2}{2}\right)e^{\lambda-1},
\qquad
c(\lambda)=1-(1-\lambda)e^{\lambda-1}.
\]

**Theorem.** Under the capacity-matched advice hypotheses in Section A.1, the algorithm in Section A.2 is causal, deterministic, and feasible, and for every finite arrival sequence it satisfies

\[
\mathrm{ALG}\ge r(\lambda)\,\mathrm{OPT},\qquad
\mathrm{ALG}\ge c(\lambda)\,\mathrm{ADV}.
\]

Equivalently, \(\mathrm{ALG}\ge\max\{r(\lambda)\mathrm{OPT},c(\lambda)\mathrm{ADV}\}\). The theorem does **not** assert the sum of the two right-hand sides, or optimality of this tradeoff among all algorithms.

## A.4. Correctly weighted certificates

Call \(g:[0,1]\to[0,1]\) a splitting function if it is continuous and nondecreasing and satisfies \(g(1)=1\). For a fixed complete execution, define the **physical** certificate contributions

\[
A_j^g=b_j\int_0^{s_j^{\rm final}}g(z)\,dz,
\]

\[
B_i^g=\sum_{j\in N_i}b_j
\int_{s_j^{\rm before\ i}}^{s_j^{\rm after\ i}}(1-g(z))\,dz.
\]

Define the per-unit dual quantities

\[
p_j^g=\frac{A_j^g}{b_j},\qquad q_i^g=\frac{B_i^g}{d_i}.
\]

The quantities \(A_j^g,B_i^g\) are not unweighted LP variables: the edge inequality must be imposed on \(p_j^g+q_i^g\), and the objective is weighted by \(b_j,d_i\).

### Lemma A2. Conservation

Every certificate component is nonnegative, and

\[
\sum_jb_jp_j^g+\sum_id_iq_i^g
=\sum_jA_j^g+\sum_iB_i^g
=\mathrm{ALG}.
\]

**Proof.** A physical increment \(b_j\,dz\) is partitioned into \(b_jg(z)\,dz\) and \(b_j(1-g(z))\,dz\). Resource loads never decrease. Telescoping over arrivals gives \(A_j^g\) for the first part, while the second parts are exactly the \(B_i^g\). Nonnegativity follows from \(0\le g\le1\). ∎

### Lemma A3. Weighted comparison

If \(p_j,q_i\ge0\) satisfy \(p_j+q_i\ge\rho\) on every present edge and
\(\sum_jb_jp_j+\sum_id_iq_i=\mathrm{ALG}\), then
\(\mathrm{ALG}\ge\rho\mathrm{OPT}\).

**Proof.** For any feasible comparator \(y\),

\[
\rho\sum_{j,i}y_{ji}
\le\sum_{j,i}y_{ji}(p_j+q_i)
\le\sum_jb_jp_j+\sum_id_iq_i
=\mathrm{ALG}.
\]

The second inequality uses both capacity constraints and the nonnegativity of \(p,q\). Apply it to an optimal comparator. ∎

## A.5. A generic lower bound for an arrival

Define

\[
L_g(\ell)=
\begin{cases}
\displaystyle\int_\ell^\lambda(1-g(z))\,dz
+(1-\lambda+\ell)(1-g(\ell)),&0\le\ell<\lambda,\\
1-g(\ell),&\lambda\le\ell\le1.
\end{cases}
\]

### Lemma A4. Arrival certificate bound

For every arrival \(i\),
\[
q_i^g\ge L_g(\ell_i).
\]

**Proof.** If \(\ell_i=1\), the second branch is zero and the statement follows from nonnegativity. This also handles an empty neighborhood.

Suppose \(\ell_i<1\). By Lemma A1, all \(d_i\) units are allocated. If there is an advised target with initial normalized load \(h\), put \(m=\min\{h,\lambda\}\). Its capacity equals \(d_i\). The push contributes

\[
d_i\int_m^\lambda(1-g(z))\,dz
\]

to \(B_i^g\), and consumes \(d_i(\lambda-m)\) supply. Every positive waterfill increment is delivered at normalized height at most \(\ell_i\), so the waterfill part contributes at least

\[
d_i(1-\lambda+m)(1-g(\ell_i)).
\]

When advice is absent, the same lower bound applies with \(m=\lambda\): the integral vanishes and all supply is waterfilled. Dividing by \(d_i>0\) yields

\[
q_i^g\ge\int_m^\lambda(1-g(z))\,dz
+(1-\lambda+m)(1-g(\ell_i)). \tag{A.1}
\]

If \(\ell_i<\lambda\), subtract \(L_g(\ell_i)\) from the right-hand side of (A.1). The difference is

\[
\int_m^{\ell_i}\bigl(g(\ell_i)-g(z)\bigr)\,dz\ge0.
\]

The last inequality holds also when \(m>\ell_i\): both the orientation of the integral and the sign of the integrand reverse. If \(\ell_i\ge\lambda\), subtract \(1-g(\ell_i)\); the difference is

\[
\int_m^\lambda\bigl(g(\ell_i)-g(z)\bigr)\,dz\ge0.
\]

Both inequalities follow from monotonicity. ∎

### Lemma A5. Resource bound on an incident edge

For every edge \((j,i)\),
\[
p_j^g\ge\int_0^{\ell_i}g(z)\,dz.
\]

**Proof.** After arrival \(i\), every neighbor has normalized load at least \(\ell_i\). Later loads only increase, and \(g\ge0\). ∎

## A.6. Robustness

Put \(E=e^{\lambda-1}\), and use the source PAW splitting function

\[
g_r(z)=
\begin{cases}
E(z+1-\lambda),&0\le z\le\lambda,\\
e^{z-1},&\lambda\le z\le1.
\end{cases}
\]

The definitions agree at \(z=\lambda\). This is a splitting function for every \(\lambda\in[0,1]\).

### Lemma A6. Scalar robustness identity

For every \(\ell\in[0,1]\),

\[
\int_0^\ell g_r(z)\,dz+L_{g_r}(\ell)
=1-E\left(1-\lambda+\frac{\lambda^2}{2}\right)=r(\lambda).
\]

**Proof.** For \(\ell\ge\lambda\), the left-hand side is

\[
E\left(\lambda-\frac{\lambda^2}{2}\right)
+e^{\ell-1}-E+1-e^{\ell-1}
=r(\lambda).
\]

For \(\ell<\lambda\), use

\[
\int_0^\ell g_r(z)\,dz
=E\left((1-\lambda)\ell+\frac{\ell^2}{2}\right)
\]

and

\[
\int_\ell^\lambda(1-g_r(z))\,dz
=\lambda-\ell
-E\left((1-\lambda)(\lambda-\ell)+\frac{\lambda^2-\ell^2}{2}\right).
\]

Adding \((1-\lambda+\ell)[1-E(1-\lambda+\ell)]\) and collecting terms gives the same expression \(r(\lambda)\). All formulas remain valid for the degenerate intervals at \(\lambda=0\) and \(\lambda=1\). ∎

By Lemmas A4–A6, \(p_j^{g_r}+q_i^{g_r}\ge r(\lambda)\) on every edge. Conservation and the weighted comparison lemma prove

\[
\mathrm{ALG}\ge r(\lambda)\mathrm{OPT}.
\]

## A.7. Consistency

Use the other source PAW function

\[
g_c(z)=
\begin{cases}
E,&0\le z\le\lambda,\\
e^{z-1},&\lambda\le z\le1.
\end{cases}
\]

It is a splitting function and is constant on \([0,\lambda]\).

### Lemma A7. Stronger arrival bound for \(g_c\)

For every arrival,

\[
q_i^{g_c}\ge1-g_c(\ell_i).
\]

**Proof.** If \(\ell_i=1\), the right-hand side is zero. If \(\ell_i<1\), the arrival is fully allocated. Every positive push increment occurs at height at most \(\lambda\), and every waterfill increment occurs at height at most \(\ell_i\). Hence every allocated unit contributes at least

\[
1-g_c(\max\{\lambda,\ell_i\})=1-g_c(\ell_i)
\]

to the arrival certificate. The equality uses the constancy of \(g_c\) below \(\lambda\). Divide by \(d_i\). ∎

This lemma must not be claimed for an arbitrary splitting function. A push can go above the final minimum level, which invalidates that stronger bound for general \(g\).

### Lemma A8. Advised target bound and scalar identity

If \(a(i)=j\), then

\[
p_j^{g_c}\ge\int_0^{\max\{\lambda,\ell_i\}}g_c(z)\,dz
\]

and

\[
p_j^{g_c}+q_i^{g_c}\ge c(\lambda).
\]

**Proof.** The push leaves the target at normalized load at least \(\lambda\). The subsequent waterfill leaves all neighbors at least \(\ell_i\), and later loads only increase. This proves the first assertion. For any \(\ell\le\lambda\),

\[
\int_0^{\max\{\lambda,\ell\}}g_c(z)\,dz+1-g_c(\ell)
=\lambda E+1-E=c(\lambda).
\]

For \(\ell\ge\lambda\), the same expression is

\[
\lambda E+(e^{\ell-1}-E)+1-e^{\ell-1}=c(\lambda).
\]

Combine this identity with Lemma A7. ∎

Now sum Lemma A8 over advised arrivals, with weight \(d_i\). Each target appears at most once, and its capacity equals that weight. Therefore

\[
\begin{aligned}
c(\lambda)\mathrm{ADV}
&\le\sum_{i:a(i)\ne\bot}d_i\bigl(p_{a(i)}^{g_c}+q_i^{g_c}\bigr)\\
&\le\sum_jb_jp_j^{g_c}+\sum_id_iq_i^{g_c}
=\mathrm{ALG}.
\end{aligned}
\]

This completes the main theorem. The robustness and consistency certificates use different functions; the algorithm itself is the same and does not depend on the certificate choice.

## A.8. Boundary cases and implementation interface

- **Zero capacity:** omit an offline resource with \(b_j=0\). A feasible original fractional advice has no positive allocation to it. The normalized quantities above are never formed at zero capacity.
- **Zero supply:** omit arrivals with \(d_i=0\). They carry no feasible positive advice or allocation. There is no division by zero.
- **Empty neighborhood:** allocate nothing, set \(\ell_i=1\), and use \(q_i=0\). No edge inequality or advised-pair inequality is required there.
- **Saturated neighborhood:** waterfill has \(\ell_i=1\); residual supply may be discarded. The certificate proof uses only \(q_i\ge0=1-g(1)\) in this case.
- **Already loaded advised target:** if its initial load exceeds \(\lambda\), the push is zero. The target bound still holds; equality of capacities is not a requirement that the target be physically empty.
- **No advice:** every arrival has \(\tau_i=0\). The same robustness proof applies; the consistency benchmark is zero.
- **\(\lambda=0\):** both certificate functions equal \(e^{z-1}\); the algorithm is capacity-weighted waterfilling and \(r(0)=c(0)=1-e^{-1}\).
- **\(\lambda=1\):** \(g_r(z)=z\), \(g_c(z)=1\), and \(r(1)=1/2\), \(c(1)=1\). Every advised target is saturated when advised.
- **Unknown horizon:** each operation uses the current state, supply, neighborhood, and advice. Every finite prefix separately satisfies the theorem because the advice restrictions are inherited by prefixes.
- **Arbitrary positive real capacities:** the proof uses only finite sums, positive divisions, ordinary integrals of explicit continuous functions, and the real waterfill level. Rational encoding and bit complexity belong to the Section 5 of the main text.

For the intended lazy lifting, the essential interface is: a subarrival with supply equal to the capacity of its unique advised virtual block; all such target blocks are distinct. Other neighbor capacities can be arbitrary. The theorem does not require those other capacities to equal the supply, and it does not require any future arrival information.

## A.9. Why the capacity-matched hypothesis matters

The following exact example was independently proposed during review and recomputed. It refutes a **naive unpaired extension of this algorithm**, not the existence of some other algorithm for arbitrary fractional advice.

Take \(\lambda=2/3\), resource capacities \(b_u=1\) and \(b_w=2/3\), and two arrivals:

| Arrival | Supply | Neighbors | Advice |
|---|---:|---|---|
| 1 | \(2/3\) | \(\{u,w\}\) | Allocate its entire supply to \(u\) |
| 2 | \(1\) | \(\{u\}\) | None |

This advice allocation is feasible, but the first advised pair has \(d_1=2/3\ne b_u=1\). A naive rule that pushes the advised resource up to normalized level \(\lambda\), capped by available supply, sends all \(2/3\) units of the first arrival to \(u\). The second arrival can then send only \(1/3\) to \(u\). Thus \(\mathrm{ALG}=1\).

The optimum instead sends the first arrival to \(w\) and the second to \(u\), obtaining \(\mathrm{OPT}=5/3\). Therefore the ratio is \(3/5\), whereas

\[
r(2/3)=1-\frac59e^{-1/3}>\frac35.
\]

For an exact verification, \(e^{1/3}>1+1/3+(1/3)^2/2=25/18\), so \(e^{-1/3}<18/25\) and the displayed strict inequality follows. A fractional-advice lifting must manufacture distinct virtual pairs with equal capacities; applying normalized PAW directly to a partially advised original resource loses the stated guarantee.

