# Full permutation hierarchies for one-query secretary selection

## Abstract

Soto and Valdevenito leave open the optimal success probability for secretary selection with a uniform training sample, an offline adversarial order, and one adaptively timed ordinal count query. We show that the value of the unrestricted game is the decreasing limit of finite-head games with a single continuous sampling parameter. An explicit two-sided comparison transfers each fixed-head game to every sufficiently large population. Exact certificates give the full four-, five-, and six-rank head values in $[0.3903568,0.3903573]$, $[0.3785752,0.3785758]$, and $[0.3744319,0.3744340]$, respectively. Thus every algorithm in the unrestricted model has a fixed adversarial order with success probability at most $0.3744340+15/n$ for $n\ge6$. The new asymptotic upper bound strengthens the previous six-order value $0.3920498578\ldots$. We retain the exact six-order subgame and quantify stability of its unique minimizing prior. The conjecture that the unrestricted value equals $1/e$ remains open.

## 1. Model

Rank 1 is best. An algorithm knows the population size $n$, privately chooses a sample size $s$, and receives a uniform subset of size $s$ as an ordinal ranking. All sampled items are rejected. A fixed permutation, chosen before the sample size and the subset are realized, gives the arrival order of the unsampled items. Arriving items are observed by their insertion ranks in the full ranking of previously seen items. The algorithm may irrevocably accept one arrival. It may query once between arrivals after rejection, including just after the sample. The reply counts unseen items better than every seen item, with reply $n$ if there is no seen item. Success means accepting global rank 1.

For $n\ge k\ge1$, let $\Gamma_{n,k}$ be the supremum over algorithms of the worst-order success probability over all preliminary orders of the form
\[
 (\sigma(1),\ldots,\sigma(k),k+1,k+2,\ldots,n),
 \qquad \sigma\in S_k.
\]
The algorithms in this restricted game may know $k$ and the family of orders. Write $\alpha_n=\Gamma_{n,n}$ for the unrestricted $n$-item value. Algorithms can depend on $n$ because $n$ is known before play.

In the reduced game, the algorithm chooses a parameter $p\in[0,1]$, which may be randomized, and all $k$ head ranks independently enter the sample with probability $p$. The algorithm receives neither the identities of sampled head ranks nor their number. It observes each unsampled head rank arriving in permutation order by its number of better seen head ranks. A query returns the minimum seen head rank minus 1, with common symbol $k$ if no head rank has been seen. Every winning play ends at rank 1 before the tail. We define $C_k$ as the maximum guaranteed success probability in this reduced game. The parameter $p$ and a deterministic policy for the reduced history may be drawn jointly.

## 2. Exact finite-head reduction and exhaustion

**Theorem 1.** For $n\ge k\ge1$,
\[
 C_k\le \Gamma_{n,k}\le C_k+\frac{\binom{k}{2}}{n}.
 \tag{1}
\]
The sequence $C_k$ is nonincreasing, and
\[
 \inf_{n\ge1}\alpha_n=\lim_{n\to\infty}\alpha_n=\inf_{k\ge1}C_k .
 \tag{2}
\]

**Proof.** First fix a sample size $s$ and an order prior $q$ on $S_k$. In any play that can still win, every arrival up to and including rank 1 is a head rank. Every previously seen rank better than such an arrival is also a head rank. The full ordinal history is therefore reconstructed from the canonical ranking of the $s$ sample positions and the sequence of reduced insertion observations. At a query, if some head rank has been seen, the reduced reply is exact. Otherwise the query is before the first online arrival on every still-winnable play, and the head sample is empty. Conditional on this event, the sampled tail is a uniform $s$-subset of a fixed set, independent of the permutation. The algorithm can simulate the exact tail reply from this law whenever it receives symbol $k$. If that branch has mass zero, its action is arbitrary. The simulation takes place only after the query, so it discloses no earlier information. The simulated random choice suffices because its law, conditional on this branch, is identical for all still-winnable worlds. Both worlds with rank 1 sampled and worlds after rank 1 has been rejected have zero success payoff. There is no renormalization when discarding them.

Conversely, a reduced policy extends to the full game by sorting the sample canonically, using the same insertion numbers, and replacing any oracle reply at least $k$ by $k$. The policy can be extended arbitrarily to histories unreachable before success or loss. This proves equality of best responses under the actual head-mask law at any fixed $s$. It also proves equality for each order of any chosen reduced policy's success probabilities before and after lifting.

For $p=s/n$, the law of a uniform $s$-subset restricted to the $k$ head positions is the law obtained by drawing $k$ slots without replacement from $n$ slots, of which $s$ are marked, and recording the marks. With replacement the marks are independent Bernoulli($p$). Couple the ordered draws by keeping the with-replacement draw if distinct and replacing it by a uniform distinct tuple otherwise. A collision has probability at most $\binom{k}{2}/n$. Any reduced policy has success payoff in $[0,1]$, so each payoff differs by at most this error.

To justify the order prior, let $\mathcal P_k$ be the finite set of deterministic reduced policies. For a fixed $\pi\in\mathcal P_k$ the vector of payoffs against all $k!$ heads varies polynomially with $p$, so the union of the payoff curves is compact. Its convex hull in $\mathbb R^{k!}$ is compact and every member is implementable as a finite mixture. Finite-dimensional minimax for this convex hull against the probability simplex gives
\[
 C_k=\min_{q\in\Delta(S_k)}\max_{p\in[0,1]}\max_{\pi\in\mathcal P_k}R_\pi(q,p).
 \tag{3}
\]
Use a minimizing $q$ in (3) for every $s$. The coupling and the fixed-size reduction upper-bound the best full response by $C_k+\binom{k}{2}/n$. The prior is independent of the realized $s$, hence the same upper bound holds after averaging any sample-size and strategy randomization. A finite prior average upper bound implies an individual fixed order in its support with the stated bound.

For the lower direction, draw $(p,\pi)$ from a maximizing mixture in the reduced game. Draw $s\sim\mathrm{Bin}(n,p)$ and request the uniform sample of size $s$. Marginally, conditional on $p$, the $n$ sampling indicators are independent Bernoulli($p$): each specified subset of size $s$ has probability $p^s(1-p)^{n-s}$. Lift $\pi$ to the full game and use $s$ only to interpret the ordinal observations. This implements exactly the reduced-game payoff for every member of the restricted order family. It proves the lower bound in (1) with zero transfer error.

For $n\ge k+1$, the size-$k$ head family embeds in the size-$(k+1)$ head family by appending rank $k+1$ to the head. The allowed rules available to the algorithm can be identified across the games, with $k$ a known constant. Thus $\Gamma_{n,k+1}\le\Gamma_{n,k}$. Sending $n$ to infinity in (1) yields $C_{k+1}\le C_k$. Finally, each $\alpha_n\ge C_n\ge\inf_k C_k$. For fixed $k$, all $n\ge k$ satisfy $\alpha_n\le\Gamma_{n,k}\le C_k+\binom{k}{2}/n$. Taking a limit superior in $n$ and then the infimum in $k$ proves (2), including the equality for a competitive guarantee uniform over sizes. \(\blacksquare\)

## 3. Reduced best responses and exact interval bounds

An active world $w=(\sigma,T)$ consists of a head permutation and a head sample $T\subseteq\{2,\ldots,k\}$, omitting rank 1 because those sample masks lose. Its mass in (3) is $q_\sigma f_h(p)$, where $h=|T|$ and $f_h(p)=p^h(1-p)^{k-h}$. The observed arrival sequence is formed by deleting $T$ from $\sigma$ and truncating after rank 1.

For an information state $(I,t,b)$, $I$ contains the possible worlds, $t$ counts rejected arrivals, and $b$ indicates whether a query remains. Remove worlds whose truncated sequence has ended. At an empty state the value is zero. Waiting first partitions $I$ by the ordinal insertion number. In each observed branch, accepting pays the mass of worlds whose current rank is 1, and rejecting calls the state at $t+1$ with the same budget. Add the maxima of those two options across observations. If a query exists, asking partitions $I$ by the reply, and adds the values of the branches at $t$ with budget zero. The state value is the maximum of waiting and asking, or just waiting when the query is spent. Recursing by remaining arrivals and query budget shows these are exactly the legal choices. The sums allow independent continuation on distinct observed branches. The maximum and sum expression can be shared as an acyclic graph. Its leaves are nonnegative linear functions of the masses assigned to active worlds.

On a dyadic interval $[a,b]$ put $p=a(1-x)+bx$, $x\in[0,1]$. With the degree-$k$ Bernstein basis $\binom{k}{i}x^i(1-x)^{k-i}$, the $i$th coefficient of $f_h(p)$ is
\[
 B_{h,i}(a,b)=\frac{1}{\binom{k}{i}}
 \sum_{j=\max(0,i-k+h)}^{\min(h,i)}
 \binom hj\binom{k-h}{i-j}
 a^{h-j}b^j(1-a)^{k-h-i+j}(1-b)^{i-j}.
 \tag{4}
\]
This follows by expanding the two factors in $p^h(1-p)^{k-h}$. The bases are nonnegative and add to one. For a fixed prior $q$, any deterministic policy's $i$th coefficient is the total of $q_\sigma B_{h,i}$ over its winning worlds. Evaluate the same best-response graph with the masses $q_\sigma B_{h,i}$ to bound this coefficient from above for every policy at once. If these $k+1$ values are at most $U$, then all policy payoffs are at most $U$ throughout the interval. Recursive bisection verifies a finite covering of $[0,1]$. The certification arithmetic uses integer numerators with the common denominator determined by the prior, dyadic scale raised to the $k$th power, and $\binom{k}{i}$.

For a lower bound one supplies a finite mixture of legal deterministic policies at rational parameters. A policy is encoded by its set of winning worlds. From the same decision graph, the legal winning sets of a leaf are exactly its stored set, a maximum permits the union of its children's families of attainable sets, and a sum permits taking the union of any one attainable set from each child. The children's potentially winnable worlds at a sum are disjoint, since the children correspond to distinct observed branches. Given a target winning set, intersect it with each child's potentially winnable worlds and recursively test membership there. At a maximum, test whether either alternative attains the target. This verifies implementability without explicitly enumerating all deterministic policies. For each order separately, count the mixture's successful subsets at every sampled size and sum their rational probabilities. A lower bound holds if every order column reaches it.

## 4. Certified head values

### 4.1. Full four- and five-rank heads

**Theorem 2.** The full permutation head values satisfy
\[
\begin{aligned}
 0.3903568&\le C_4\le0.3903573,\\
 0.3785752&\le C_5\le0.3785758 .
\end{aligned}
\tag{5}
\]
Consequently for every $n\ge5$ and every permitted algorithm there is a fixed adverse order on which it succeeds with probability at most $0.3785758+10/n$. The corresponding upper bound on the unrestricted uniform competitive ratio is $0.3785758$.

**Proof.** The following are the numerator weights for the upper certificates, with denominator equal to each column's sum.

| Four-rank head | Weight | Five-rank head | Weight |
| --- | ---: | --- | ---: |
| 1234 | 22309823 | 12345 | 11659134 |
| 2134 | 11815941 | 21345 | 8865803 |
| 3214 | 1322060 | 32145 | 3125222 |
| 4123 | 14080784 | 42135 | 889279 |
| 4213 | 6379362 | 43125 | 1904053 |
| 4312 | 18195303 | 43215 | 2971304 |
| 4321 | 25896726 | 51234 | 13962239 |
| | | 52134 | 7343327 |
| | | 53214 | 3671663 |
| | | 54123 | 9566162 |
| | | 54213 | 2947250 |
| | | 54312 | 13237826 |
| | | 54321 | 19856739 |

The lower mixtures and upper priors are provided together in [certificate.json](evidence/r01/certificate.json). The verifier indexes worlds by lexicographic permutation followed by increasing sample mask on ranks $2,\ldots,k$. The lower mixture records, in order, a positive integer weight, the numerator and denominator of $p$, and a hexadecimal winning-world mask. Weights are normalized by their sum. The exact computation in [verify.py](evidence/r01/verify.py) implements (4) and the legal-policy recurrence. Here is its certificate summary.

| $k$ | Orders | Active worlds | Graph nodes | Lower mixture terms | Dyadic intervals | Maximum bisection depth |
| ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| 4 | 24 | 192 | 141 | 12 | 18 | 10 |
| 5 | 120 | 1920 | 567 | 22 | 19 | 9 |

The minimum exact success probabilities over all orders for the two mixtures are respectively
\[
 \frac{487946162698161119}{1250000000000000000},
 \qquad \frac{37857533131941356962333}{100000001000000000000000}.
\]
They exceed the respective lower endpoints in (5). The upper bounds are verified on every dyadic interval in the cover. Run `python3 ../r01/verify.py` from this directory to reproduce all inequalities. The search that proposed the priors and policy mixtures used a floating-point linear program. The certificates use only the finite recurrence and exact arithmetic on the listed data. Applying (1) with $k=5$ yields the claimed bound. \(\blacksquare\)

The former fixed six-order value $C_*=A(p_*)\approx 0.39204985783479$ satisfies $C_*\ge A(1/3)=127/324$. This rational lower bound already strictly exceeds the two upper endpoints in (5). Conversely, the lower endpoint for $C_4$ is strictly above the upper endpoint for $C_5$, so no prior with a four-rank head and a common increasing tail yields an equally strong asymptotic bound. The present certificates enclose the complete head-family values with widths $5\cdot10^{-7}$ and $6\cdot10^{-7}$, respectively.



### 4.2. Full six-rank heads

**Theorem 3.** The full six-rank value satisfies
$$
0.3744319\le C_6\le0.3744340.
\tag{6}
$$
For every \(n\ge6\), every legal algorithm faces a fixed order with success probability at most \(0.3744340+15/n\). In particular the unrestricted uniform ratio is at most \(0.3744340\).

Choose the first six ranks by the following prior, then append \(7,8,\ldots,n\). Numerator weights are normalized by their sum.

| Head | Weight | Head | Weight |
| --- | ---: | --- | ---: |
| 123456 | 7788858 | 621345 | 6761811 |
| 213456 | 5794789 | 632145 | 3949547 |
| 312456 | 1113830 | 641235 | 809750 |
| 321456 | 3362971 | 643215 | 1502098 |
| 431256 | 1612161 | 651234 | 5624528 |
| 432156 | 1867081 | 652134 | 4565501 |
| 532146 | 79546 | 653214 | 1059026 |
| 541236 | 758922 | 654123 | 5855605 |
| 543126 | 2612864 | 654213 | 1174565 |
| 543216 | 3384925 | 654312 | 11809529 |
| 612345 | 12021524 | 654321 | 16490569 |

The decision recurrence in Section 3 generates 720 permutations, 23,040 active worlds and 2,742 sum/max/leaf graph nodes. The prior's upper bound follows by evaluating the graph on each of the seven degree-six Bernstein coefficient masses per dyadic interval. The successful intervals form a cover of \([0,1]\) with 21 leaves and maximum depth 9. Their inequalities apply simultaneously to all deterministic continuations of the complete ordinal history, hence to randomized choices as well.

The lower witness is a normalized mixture of 77 deterministic policies at rational sampling parameters. Each mask is checked to be a legal winning-world set recursively in the observation and query branches. The minimum of their exact mixed payoff over all 720 orders is
$$
\frac{27296094024795714758329}{72899998542000000000000}>0.3744319.
$$
The witnesses and priors are stored in [the six-rank certificate](evidence/r02/certificate.json). From this directory, `python3 ../r01/verify.py ../r02/certificate.json` verifies both ends using only exact arithmetic. Floating-point linear programming proposed the candidates.

The finite-population transfer in Theorem 1 uses \(\binom{6}{2}/n=15/n\) and applies to any sample-size randomization. The same prior works for each realized size independently of the random sample, so an individual fixed order in its support attains the upper bound against each algorithm. The binomial sampling construction transfers the lower certificate exactly to the restricted six-rank family for all \(n\ge6\).


### 4.3. Comparison at finite size

The same argument applies at four ranks. Taking the best available bound at each \(n\ge6\), there is a fixed adversarial order with success probability at most
\[
 \min\left\{0.3903573+6/n,\quad0.3785758+10/n,\quad0.3744340+15/n\right\}.
\]
The six-rank term becomes strictly better than the five-rank term at \(n\ge1208\); the four-rank term is then also larger. The first two terms are available separately as soon as \(n\) is at least their head size.

## 5. Exact values and stability for the historical six orders

The following four-rank heads share tail \(5,6,\ldots,n\). The table displays the two successive priors; Section 4 optimizes over the wider families of all head permutations.

| Head | Initial prior, numerator over 11 | Optimized prior, numerator over 16 |
| --- | ---: | ---: |
| 1432 | 2 | 4 |
| 2143 | 1 | 2 |
| 4132 | 2 | 2 |
| 4213 | 1 | 1 |
| 4312 | 2 | 3 |
| 4321 | 3 | 4 |

For a fixed sample size \(s\), write \(w_h=\binom{n-4}{s-h}/\binom ns\) for the probability of each particular head subset of size \(h\). The binomial coefficient vanishes outside its natural range. The finite-head reduction in Section 2 applies also to a prior on a subset of orders.

### 5.1 The initial prior

Write \(a_j\) for the integer initial weight of order \(j\). Assign the mass

$$
m_{j,T}=\frac{a_j}{11}w_{|T|}
$$

for any five nonnegative parameters $w_0,\ldots,w_4$. The last parameter contributes no active world. Every deterministic policy has payoff

$$
\frac1{11}\sum_{h=0}^4 c_h w_h,
\tag{I2}
$$

where $c_h$ is the sum of the integer order weights over the winning worlds with $|T|=h$.

**Lemma 5.1 (two-vector frontier).** The complete coefficient recursion for the 48 worlds has 33 information states and 744 distinct achievable coefficient vectors. Every such vector is componentwise dominated by one of

$$
c^{(A)}=(3,21,28,11,0),\qquad
c^{(B)}=(4,18,18,0,0),
\tag{I3}
$$

and both vectors are achievable. Thus the exact optimal value for arbitrary nonnegative weights is

$$
\frac1{11}\max\{3w_0+21w_1+28w_2+11w_3,\;
4w_0+18w_1+18w_2\}.
\tag{I4}
$$

*Finite proof and certificate.* Replace each scalar payoff in Section 3 by its set of integer coefficient vectors. An accept action has one vector. An action choice is set union. Distinct observed branches are combined by the Minkowski sum of their vector sets. The empty continuation is the singleton zero vector. Apply these operations from terminal states toward the root. Enumerating the complete sets without dominance pruning gives 744 root vectors. Checking the five integer inequalities in (I3) for each vector proves domination, and membership of both vectors proves attainability. Nonnegativity of the $w_h$ converts domination into (I4).

The [initial verification program](evidence/code/verify_certificate.py) generates the worlds and all information partitions directly from the six permutations. Its outputs include the [complete finite graph](evidence/results/finite_kernel.json) and [all root vectors](evidence/results/all_policy_coefficients.json). It uses only exact integers and rational numbers, and the checks remain active under Python's optimization flag. The [independent full-population verifier](evidence/code/review_finite_game.py) retains losing worlds and exact tail replies and checks every sample size for populations 4 through 10.

The two frontier vectors also have short root-level decompositions. Coordinates in the following table use the same integer basis as (I2); the common division by 11 is omitted. Here \(\star\) denotes the reduced reply for an empty head sample.

| Attaining strategy and observed root branch | Winning coefficient vector |
| --- | --- |
| A: query immediately; reply $\star$ | $(3,0,0,0,0)$ |
| A: query immediately; reply 1 | $(0,11,22,11,0)$ |
| A: query immediately; reply 2 | $(0,6,6,0,0)$ |
| A: query immediately; reply 3 | $(0,4,0,0,0)$ |
| B: reject the first arrival, then query; first insertion position 0 | $(4,6,5,0,0)$ |
| B: reject the first arrival, then query; first insertion position 1 | $(0,12,5,0,0)$ |
| B: reject the first arrival, then query; first insertion position 2 | $(0,0,8,0,0)$ |

Each row uses the optimal continuation of its observed branch in Section 3. Summing the A rows gives $c^{(A)}$ and summing the B rows gives $c^{(B)}$. The full 744-vector domination check is still needed to exclude other adaptive histories. This simplification belongs to this particular adversary; it does not assert a general theorem restricting every one-query algorithm to these two query times.

#### The rational continuum bound

Set $w_h=p^h(1-p)^{4-h}$, where $0\le p\le1$. Equation (I4) becomes

$$
V(p)=\max\{A_0(p),B_0(p)\},
\tag{I5}
$$

with

$$
\begin{aligned}
A_0(p)&=\frac{3+9p-17p^2+6p^3-p^4}{11},\\
B_0(p)&=\frac{4+2p-12p^2+2p^3+4p^4}{11}.
\end{aligned}
\tag{I6}
$$

The comparison uses the independent head-mask law. Section 2 transfers the bound back to a fixed-size population experiment.

**Lemma 5.2 (two nonnegative identities).** Put $a=5/16$ and $U=14845259/37748736$. For every real $p$,

$$
\begin{aligned}
U-A_0(p)={}&\frac9{11}\left(p-a-\frac{11}{18432}\right)^2\\
&+\frac1{11}(p-a)^2
\left[(1-p)\left(\frac{35}{8}-p\right)+\frac{43}{256}\right],
\end{aligned}
\tag{I7}
$$

and

$$
\begin{aligned}
\frac38-B_0(p)={}&\frac{[(1-p)(1-7p)]^2}{88}
+\frac9{44}[p(1-p)]^2\\
&+\frac32p^3(1-p)+\frac38p^4.
\end{aligned}
\tag{I8}
$$

*Proof.* Expand both sides over the rationals. In (I7), the bracket is positive on $[0,1]$ because $1-p\ge0$, $35/8-p>0$ and $43/256>0$. Every term in (I8) is nonnegative on that interval. Thus $A_0(p)\le U$ and $B_0(p)\le3/8<U$. Finally,

$$
\frac{39327}{100000}-U=\frac{582521}{117964800000}>0.
$$

This proves $V(p)\le U$ throughout the continuum $[0,1]$, with no numerical grid or root approximation in the proof. \(\blacksquare\)

For orientation only, numerical maximization of $A_0$ gives a peak near $p=0.31294917$ and value $0.39326498981$. These decimals are not used by any certificate. We make no claim that $U$ is the best possible bound over all adversarial distributions.

Equation (I4) gives the exact finite best response under the initial prior. Applying the collision coupling with \(k=4\) and the continuum bound gives \(U+6/n\) against every permitted algorithm, including randomized sample sizes.

### 5.2 Unique optimal prior on those six heads

Let \(q\) range over the simplex on the six listed heads. For each deterministic policy \(\pi\), write \(c_{jh}(\pi)\) for the number of size-\(h\) active subsets it wins in order \(j\). The probability before optimizing \(p\) and the policy is \(\sum_{j,h}q_j c_{jh}(\pi)p^h(1-p)^{4-h}\). Denote the optimum against \(q\) by \(F(q)\) and the infimum of \(F(q)\) by \(C_{\rm six}\). All policies use the same history and observations as in Section 3.

The standard-library verifier [the exact six-order verifier](evidence/supplements/2026-11-25-p1-secondary/verify_exact.py) performs this recurrence using integer bit masks, without dominance pruning. It obtains **3,360** winning-world sets, each with a distinct 24-entry coefficient vector $(c_{10},\ldots,c_{63})$. The complete vector list is [all_policy_vectors.txt](evidence/supplements/2026-11-25-p1-secondary/all_policy_vectors.txt); each line has 24 single-digit entries in row-major order. Its content hash is in [certificate.json](evidence/supplements/2026-11-25-p1-secondary/certificate.json). The code also reconstructs six specific policies and replays them on all 48 worlds; their legal action trees and winning masks are in [dual_policies.json](evidence/supplements/2026-11-25-p1-secondary/dual_policies.json).

For

\[
 q_*=(4,2,2,1,3,4)/16, \tag{S5}
\]

the 3,360 unweighted vectors map to 700 distinct weighted four-vectors $d_h=\sum_j16q_{*j}c_{jh}$. Every such vector is coordinatewise dominated by at least one of

\[
 a=(4,31,41,16),\qquad b=(6,24,24,0), \tag{S6}
\]

and both vectors are attainable. These finite assertions are checked by direct integer comparisons against every vector. The policy payoff above and $w_h\ge0$ therefore prove the following for all nonnegative $w$:

\[
 \max_\pi R_\pi(q_*,w)
 =\frac1{16}\max\{4w_0+31w_1+41w_2+16w_3,
                         6w_0+24w_1+24w_2\}. \tag{S7}
\]

This is an exact finite computation with the exhaustiveness proof above; a numerical linear program is not an input to the certificate. Exploration used linear programming to suggest (S5), but no floating-point result is needed for (S5)–(S7).

#### Exact value and rational bound

Substituting $w_h=p^h(1-p)^{4-h}$ in (S7) gives

\[
 V(q_*,p)=\max\{A(p),B(p)\}, \tag{S8}
\]

where

\[
 A(p)=\frac{4+15p-28p^2+11p^3-2p^4}{16},
 \qquad B(p)=\frac38(1-p^2)^2. \tag{S9}
\]

Let $p_*$ be the unique root in $(0,1)$ of

\[
 8p^3-33p^2+56p-15=0,
 \qquad C_*=A(p_*). \tag{S10}
\]

The uniqueness follows directly from

\[
 A''(p)=-\frac{24p^2-66p+56}{16}<0.
\]

The quadratic in the numerator has positive leading coefficient and discriminant $-1020$, and $A'(0)>0>A'(1)$. Evaluating the cubic at $8/25$ and $1/3$ gives respectively $-3079/15625$ and $8/27$, so

\[
 \frac8{25}<p_*<\frac13.
\]

Since $B(p)\le3/8$ and $A(1/3)=127/324>3/8$, equations (S8)–(S10) imply

\[
 \max_{p\in[0,1]}V(q_*,p)=C_*.
\]

Numerically, $p_*\simeq0.32529667568575$ and $C_*\simeq0.39204985783479$. All theorem statements use the root characterization or rational bounds.

**Lemma 5.3 (rational upper).** For every $p\in[0,1]$,

\[
 A(p)\le U_1:=\frac{7841}{20000}=0.39205,
 \qquad U-U_1=\frac{28666907}{23592960000}>0. \tag{S11}
\]

**Proof.** Put $F(p)=U_1-A(p)$. On an interval $[a,b]$, write $p=a+(b-a)t$, expand $F(a+(b-a)t)=\sum_{k=0}^4d_kt^k$, and set

\[
 \beta_i=\sum_{k=0}^i d_k\frac{\binom ik}{\binom4k},
 \qquad
 d_k=\sum_{j=k}^4F_j\binom jk a^{j-k}(b-a)^k. \tag{S12}
\]

Then $F(a+(b-a)t)=\sum_{i=0}^4\beta_i\binom4i t^i(1-t)^{4-i}$. The Bernstein basis functions are nonnegative and sum to 1 on $[0,1]$. Exact substitution in (S12) gives these positive minimum coefficients:

| $a$ | $b$ | $\min_i\beta_i$ |
|---:|---:|---:|
| $0$ | $1/4$ | $8699/1280000$ |
| $1/4$ | $5/16$ | $62569/327680000$ |
| $5/16$ | $41/128$ | $38903249/1342177280000$ |
| $41/128$ | $83/256$ | $31972609/21474836480000$ |
| $83/256$ | $333/1024$ | $846998529/5497558138880000$ |
| $333/1024$ | $167/512$ | $265885827/2748779069440000$ |
| $167/512$ | $21/64$ | $353612369/343597383680000$ |
| $21/64$ | $11/32$ | $788289/83886080000$ |
| $11/32$ | $3/8$ | $2051729/5242880000$ |
| $3/8$ | $1/2$ | $57309/20480000$ |
| $1/2$ | $1$ | $1307/40000$ |

These intervals partition $[0,1]$, including both endpoints. Consequently $F\ge0$ throughout that interval. All five coefficients for each interval are in [certificate.json](evidence/supplements/2026-11-25-p1-secondary/certificate.json), and the verifier recomputes them as rational numbers. The final identity in (S11) is rational subtraction. \(\blacksquare\)

#### The dual certificate

This section proves that optimizing the prior on the same six heads cannot improve $C_*$. It does not assert that no other adversarial family can improve it.

The following are six attainable deterministic policies. Each table entry is the quadruple $(c_{j0},c_{j1},c_{j2},c_{j3})$ for the indicated order $j$; the legal action trees are supplied in [dual_policies.json](evidence/supplements/2026-11-25-p1-secondary/dual_policies.json) and checked by replay.

| policy $i$ | 1432 | 2143 | 4132 | 4213 | 4312 | 4321 |
|---:|---|---|---|---|---|---|
| 1 | $0,2,3,1$ | $0,2,2,1$ | $0,1,3,1$ | $1,3,2,1$ | $1,2,3,1$ | $0,2,2,1$ |
| 2 | $0,2,3,1$ | $1,2,2,1$ | $1,1,3,1$ | $0,3,2,1$ | $0,2,3,1$ | $0,2,2,1$ |
| 3 | $0,2,3,1$ | $0,2,2,1$ | $0,1,3,1$ | $0,3,2,1$ | $0,2,3,1$ | $1,2,2,1$ |
| 4 | $0,2,3,1$ | $0,2,2,1$ | $0,2,3,1$ | $0,2,2,1$ | $0,3,3,1$ | $1,1,2,1$ |
| 5 | $1,2,3,1$ | $0,2,2,1$ | $0,1,3,1$ | $0,3,2,1$ | $0,2,3,1$ | $0,2,2,1$ |
| 6 | $0,3,3,1$ | $0,1,2,1$ | $0,2,3,1$ | $0,2,2,1$ | $0,1,3,1$ | $1,2,2,1$ |

Let $M_{ij}(p)=\sum_hc_{jh}(\pi_i)p^h(1-p)^{4-h}$. For $p\in[8/25,1/3]$, set $D(p)=16(1-p)^2$ and define

\[
 \begin{aligned}
 N_1(p)&=4-13p+6p^2,&N_2(p)&=4-5p+6p^2,\\
 N_3(p)&=-8+35p-26p^2,&N_4(p)&=8-24p+16p^2,\\
 N_5(p)&=4-13p+6p^2,&N_6(p)&=4-12p+8p^2,
 \end{aligned} \tag{S13}
\]

and $\lambda_i(p)=N_i(p)/D(p)$. These six numbers are strictly positive and sum to 1 on that interval. Indeed, $N_1=N_5$ decreases there and its value at $1/3$ is $1/3$; $N_2$ is positive by its negative discriminant; $N_3$ increases there and its value at $8/25$ is $336/625$; and $N_4=8(1-2p)(1-p)$, $N_6=4(1-2p)(1-p)$. Their sum is $D$.

Direct polynomial multiplication using the displayed coefficient table gives, for each $j=1,\ldots,6$,

\[
 \sum_{i=1}^6 N_i(p)M_{ij}(p)=D(p)A(p). \tag{S14}
\]

The verifier checks (S14) as six polynomial identities over the rationals, not by evaluation at finitely many $p$'s. Thus the randomized policy choosing $i$ with probability $\lambda_i(p_*)$ has success probability exactly $C_*$ against **each** of the six heads, in the independent-indicator experiment at $p_*$.

**Theorem 5.4 (unique optimal prior on the fixed support).**

\[
 C_{\rm six}=C_*,
 \qquad q_*=(4,2,2,1,3,4)/16
\]

is the unique minimizing prior.

**Proof.** For any $q\in\Delta_6$, the mixed policy from (S14), evaluated at $p_*$, has payoff $\sum_jq_jC_*=C_*$. The best response is at least that payoff, so $\max_pV(q,p)\ge C_*$. Equation (S8) and strict concavity already show that $q_*$ attains $C_*$.

Suppose another $q$ attains $C_*$. Every one of the six policy payoffs $(M(p_*)q)_i$ is at most $C_*$, while their convex combination with the strictly positive weights $\lambda_i(p_*)$ equals $C_*$. Hence all six are $C_*$. The same statement holds for $q_*$, so $M(p_*)(q-q_*)=0$.

Expansion of the determinant from the displayed table yields

\[
 \det M(p)=p^2(p-1)^{19}(2p^3-9p^2+19p+4). \tag{S15}
\]

This identity is independently checked in the certificate code by the full 720-term permutation expansion. For $0<p<1$, the final factor is at least $2p^3+10p+4>0$, using $p^2\le p$; the other factors are nonzero. Thus $M(p_*)$ is invertible and $q=q_*$. \(\blacksquare\)

### 5.3 Finite transfer and quantitative stability

At finite size and fixed sample size, equation (S7) gives the exact best response under \(q_*\) with the hypergeometric subset masses \(w_h\). If \(C_{{\rm six},n}\) denotes the value on these six full orders at size \(n\), the coupling gives the upper bound \(C_*+6/n\). For a lower bound one may choose the sample size nearest to \(np_*\), use the dual mixture (S13), and couple the two Bernoulli parameters with four shared uniforms. This incurs at most \(4/(2n)+6/n=8/n\) error. Since arbitrary randomized sizes are legal, the binomial transfer from Section 2 gives the sharper exact lower bound \(C_*\le C_{{\rm six},n}\). All these bounds concern the six specified orders. They do not give a uniform algorithm against arbitrary full orders.

The strict positivity of the dual also quantifies stability of the prior. Let \(M=M(p_*)\), \(\lambda_i=\lambda_i(p_*)\), and \(\lambda_{\min}=\min_i\lambda_i\). For any \(q\) with \(F(q)\le C_*+\delta\),
\[
 \|q-q_*\|_\infty\le
 \|M^{-1}\|_{\infty\to\infty}
 \max\left(1,\frac{1-\lambda_{\min}}{\lambda_{\min}}\right)\delta.
\]
Indeed \(e=M(q-q_*)\) has \(e_i\le\delta\) and \(\lambda^{\mathsf T}e=0\) by the dual identity. Thus \(e_i\ge-(1-\lambda_i)\delta/\lambda_i\), and invertibility gives the displayed bound. In the other direction, each policy's payoff depends on a function of the order in \([0,1]\), so \(F(q)-C_*\le\|q-q_*\|_{\mathrm{TV}}\) after taking the maximum. For the finite game, a best response of at most \(C_*+\delta\) forces the same bound with \(\delta+8/n\), by the fixed-size coupling on each of the six dual strategies at the nearest integer sample size. If desired, the fixed binomial sampler at \(p_*\) realizes those six Bernoulli payoffs exactly and gives the coefficient \(\delta\) with randomized sizes.

## 6. Relation to earlier results

Soto and Valdevenito define the ordinal assumptions, offline sampling model, and query timing in §2 and §§2.1–2.2. Their §2.5.2 gives the $1/e$ lower bound, states the conjecture for unrestricted SBOffAO1, proves its analogue with below-threshold arrivals hidden (Theorem 2.6), and gives the smaller-class upper bound $0.3787$ for immediately querying after the sample (Theorem 2.8). The full one-query class inherits $(20\sqrt{10}-29)/81$ from the unlimited-query value in Theorem 2.10. Their immediate-query proof already uses a head permutation with a common increasing-rank tail. We use that family, preserve all arrivals and adaptive query times, and optimize the prior over all head permutations. The two-sided comparison in Theorem 1 characterizes the unrestricted game as the limit of these bounded-head problems. [Official arXiv v1, §§2.1–2.2](https://arxiv.org/html/2609.19016v1#S2.SS1) · [One-query results, §2.5.2](https://arxiv.org/html/2609.19016v1#S2.SS5.SSS2) · [Unlimited-query result, §2.5.3](https://arxiv.org/html/2609.19016v1#S2.SS5.SSS3)

The prior six-order analysis gave a universal $14845259/37748736+6/n$ and, after optimization on its fixed six heads, the exact minimax $C_*$ on that subset. Equations (2), (5), and (6) extend the analysis to all $24$, $120$, and $720$ head permutations and to a hierarchy with a proved unrestricted limit. The new prior works for a stronger strategy class than the one in the original $0.3787$ result. Section 5 proves the earlier construction and its fixed-support characterization in the same model. Original manuscript · Fixed-support supplement

Other nearby models include independent sample secretary selection, whose benchmark is the best item outside the sample and which has no ordinal count query, and Mallows-order secretary selection, where the expert judges the current candidate and a positive reply permits its selection. Neither model has the combination of offline ordering, global maximum target, and delayed future-count access used here. Standard ingredients include the Yao prior method, finite-dimensional minimax, Bellman recursion, and Bernstein coefficient bounds. [Correa et al., §2](https://doi.org/10.1287/mnsc.2021.01580) · [Liu, Milenkovic and Moustakides, model and stopping rules](https://doi.org/10.1016/j.tcs.2023.114206)

Final source search on 2026-11-25 used the public terms `Secretary Problems with Interactive Ordinal Queries Soto Valdevenito`, `SBOffAO one query secretary upper bound Valdevenito`, and `Felipe Valdevenito oracular secretary thesis`. The official arXiv HTML was available and §2.5 was compared directly. The related 2023 thesis remains unavailable through the inspected sources, including the supervisor's homepage, which returned HTTP 403. The earlier university seminar gives background about the same research program. No equivalent result surfaced in the inspected public sources. [arXiv record](https://arxiv.org/abs/2609.19016) · [Universidad de Chile seminar](https://archivo.cmm.uchile.cl/?p=45975)

This is an AI-assisted research manuscript. Full Lean verification remains a separate deliverable.
