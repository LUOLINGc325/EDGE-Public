# Persistent memory is required to observe schedule-induced indivisibility

## Abstract

A finite-valued classical schedule selects quantum channels without supplying a separate record of its letters. Dependence in the schedule can yield a unit diamond-norm postprocessing defect when the device can retain a whole word. We show that detecting a constant fraction of this defect can require a number of persistent qubits linear in the history length. The lower bound allows time-dependent channel libraries and arbitrary reference systems in the diamond norm. An explicit schedule of binary inner-product checks has maximal unrestricted defects infinitely often, although every fixed memory dimension has uniformly vanishing defects. At any finite horizon a time-dependent classical two-state device detects some positive defect exactly when the next letter depends on its past. A quantitative suffix bound gives asymptotic equivalence for uniformly fading remote history, and every stationary non-iid process has a positive bound at all late times for suitable two-state tests. The memory bound is fixed and the detecting library may be chosen for each target time.

## 1. Model and results

Let \(X_1,X_2,\ldots\) be a finite-alphabet process, binary in Theorems 1–3, independent of the initial device state. At step \(j\), a value \(X_j=a\) selects a CPTP map \(C_{j,a}\) on a \(d\)-dimensional Hilbert space. The time index may change the library. A time-independent library uses \(C_{j,a}=C_a\). The device state is the persistent memory, including any internal classical registers. The observed object at time \(t\) is the averaged initial-to-time channel
\[
 \Phi_t=\mathbb E[C_{t,X_t}\circ\cdots\circ C_{1,X_1}],
 \qquad \Phi_0=\mathrm{id}.
\]
There is no external register containing the realized letters. Define the unit-step postprocessing defect
\[
 D_t(C)=\inf_{\Lambda\ {\rm CPTP}}
       \|\Phi_t-\Lambda\circ\Phi_{t-1}\|_\diamond .
\]
The diamond norm is unhalved and already includes arbitrary passive reference systems. Write \(\mathcal D_t(d)\) for the supremum over libraries on dimensions at most \(d\), including time-dependent ones, and \(\mathcal D_t(\infty)\) for the supremum over finite dimensions.

**Theorem 1.** Let the first \(n\) letters be independent fair bits, \(n\ge2\), and let the next letter be a deterministic balanced Boolean function of those bits. For every such function, \(\mathcal D_{n+1}(\infty)=1\), attained by a time-independent classical library on at most \(2^{n+1}+4\) states.

For each \(0<\epsilon<1\) and integer \(d\ge1\) satisfying
\[
 2^{n-1}\ \ge\
 128\epsilon^{-2}d^4(n+1)\log(1+16(n+1)/\epsilon),
 \tag{1}
\]
there is such a balanced Boolean function with \(\mathcal D_{n+1}(d)\le\epsilon\). Thus, at any fixed accuracy strictly between zero and one, the worst-case number of persistent qubits needed to achieve defect above that accuracy has order \(n\). If the devices must be time independent, the factor \(n+1\) outside the logarithm in (1) can be omitted.

**Theorem 2.** There is one fixed infinite binary schedule and times \(t_j\to\infty\) such that \(\mathcal D_{t_j}(\infty)=1\) for every \(j\), with the value attained by time-independent classical libraries. For every fixed \(d\), \(\lim_{t\to\infty}\mathcal D_t(d)=0\). In particular the separation is uniform over the set of all fixed finite-dimensional quantum devices, within each prescribed dimension.

## 2. The unrestricted defect

For a fixed balanced function \(f\), let \(U=(X_1,\ldots,X_n)\) and \(X_{n+1}=f(U)\). Take \(\overline C_{n+1}=(C_{n+1,0}+C_{n+1,1})/2\). Its postprocessing difference is
\[
 \Phi_{n+1}-\overline C_{n+1}\Phi_n
 =\frac12 \mathbb E_U\big[(2f(U)-1)
        (C_{n+1,1}-C_{n+1,0})\circ C_U\big],
 \tag{2}
\]
where \(C_U\) is the composition through the first \(n\) steps. The triangle inequality in diamond norm bounds (2) by one, since every \(C_U\) is a channel. This argument allows time dependence.

For equality, initialize a device in either of two basis states. Distinct layers carry the initial control bit and the observed prefix through length \(n-1\). Reading the \(n\)th letter erases these registers and produces a single flag, \(f(U)\) on the first input and \(1-f(U)\) on the second. The resulting flag is uniform under both inputs. Reading the next letter moves the flag to a pair containing it and the letter. The two final outputs have disjoint supports, since one records equal pairs and the other records unequal pairs. Every postprocessing of the common previous output must agree on the two inputs, so by the triangle inequality it must have trace-norm error at least one on one of them. The same two fixed maps act at all steps because the layer and flag registers are disjoint basis labels. There are \(2\sum_{j=0}^{n-1}2^j\) prefix labels, two flags and four final labels. Arbitrary actions on unreachable labels complete a deterministic classical map, which can be implemented by a measure-and-prepare channel.

## 3. A uniform bound on small quantum memories

Let \(N=2^{n-1}\) and choose independent signs \(\varepsilon_w\in\{-1,1\}\) indexed by \(w\in\{0,1\}^{n-1}\). Set \(2f(0w)-1=\varepsilon_w\) and \(2f(1w)-1=-\varepsilon_w\). Every resulting \(f\) is balanced. For a fixed time-dependent library, let \(T_C\) denote (2). Pairing the histories gives
\[
 T_C=N^{-1}\sum_w \varepsilon_w B_w,\qquad
 B_w=\tfrac14(C_{n+1,1}-C_{n+1,0})\circ(C_{0w}-C_{1w}),
 \qquad \|B_w\|_\diamond\le1.
 \tag{3}
\]

Use the unnormalized Choi matrix \(J(T)=(\mathrm{id}\otimes T)(|\Omega\rangle\langle\Omega|)\), \(|\Omega\rangle=\sum_{\ell=1}^d|\ell,\ell\rangle\). We use
\[
 \|T\|_\diamond\le\|J(T)\|_1,\qquad
 \|J(T)\|_1\le d\|T\|_\diamond,\qquad
 \|J(T)\|_1\le d\|J(T)\|_{\mathrm F}.
\]
For the first inequality apply the singular-value decomposition to any trace-class input, then write each unit vector in a rank-one term as \((A\otimes I)|\Omega\rangle\), with \(\|A\|_{\rm op}\le1\). Independently use such a contraction for the other vector in the rank-one term. Multiplication on either side cannot increase the trace norm of \(J(T)\). The second inequality tests the normalized maximally entangled input. The third is Cauchy–Schwarz for at most \(d^2\) singular values. Independence of the signs in (3) thus gives
\[
 \mathbb E\|T_C\|_\diamond
 \le d(\mathbb E\|J(T_C)\|_{\mathrm F}^2)^{1/2}
 \le d^2/\sqrt N .
\]
Changing one sign changes \(\|T_C\|_\diamond\) by at most \(2/N\). The bounded differences inequality yields
\(\Pr\{\|T_C\|_\diamond-\mathbb E\|T_C\|_\diamond\ge x\}
 \le\exp(-Nx^2/2)\).

We next make the estimate uniform over devices. The real vector space of Hermiticity-preserving maps has dimension \(d^4\). The set of CPTP maps lies in the unit diamond-norm ball and has a net of radius \(\xi\) with centers in that set and cardinality at most \((1+2/\xi)^{d^4}\). This follows by packing disjoint balls of radius \(\xi/2\) about a maximal separated subset. Taking products over the two maps at each of the \(n+1\) times bounds the number of library net points by \((1+2/\xi)^{2(n+1)d^4}\). For time-independent libraries there are only two factors. If two corresponding libraries differ at each map by at most \(\xi\), telescoping channel compositions shows
\[
 \|T_C-T_{C'}\|_\diamond\le 2(n+1)\xi.
\]
Indeed each averaged channel in (2)'s left side, including the simulated channel \(\overline C_{n+1}\Phi_n\), changes by at most \((n+1)\xi\).

Take \(\xi=\epsilon/[8(n+1)]\). Under (1) the fixed-library mean is at most \(\epsilon/4\). The probability that some net point has \(\|T_C\|_\diamond\ge\epsilon/2\) is at most
\[
 \exp\!\left(2(n+1)d^4\log(1+16(n+1)/\epsilon)-N\epsilon^2/32\right)<1.
\]
Hence one sign assignment makes every library satisfy \(\|T_C\|_\diamond<\epsilon\), by approximation from the net. The simulator from (2) proves the asserted defect bound. The same proof omits the factor \(n+1\) outside the logarithm for time-independent libraries.

A library of smaller dimension embeds in dimension \(d\) by preserving a copy of its input space and sending the orthogonal complement to a fixed padding state. The averaged maps and their difference under the specific simulator \(\overline C_{n+1}\) restrict to the smaller library. This verifies that the single sign assignment works simultaneously in every dimension at most \(d\). At fixed \(\epsilon\), (1) permits \(d\) of order \((2^n/[n\log n])^{1/4}\), so more than \(n/4-O(\log n)\) qubits may be needed to exceed \(\epsilon\). Section 2 bounds the requirement above by \(n+O(1)\) qubits.

## 4. One schedule over the whole horizon

Select any increasing integer dimensions \(d_j\to\infty\) and decreasing \(0<\epsilon_j<1\) with \(\epsilon_j\to0\). Choose lengths \(n_j\) satisfying (1) for those parameters, and choose a balanced function \(f_j\) from Section 3 at each length. Concatenate independent blocks. Block \(j\) consists of \(n_j\) fresh fair bits followed by their checksum \(f_j\). The entire schedule is fixed before any device is chosen. At steps producing a fresh bit, the mean of that step's two channels gives an exact postprocessing factor regardless of earlier dependence.

Let \(s_j\) be the number of steps before block \(j\), and \(t_j=s_j+n_j+1\). By independence of blocks, the averaged channels through \(t_j-1\) and \(t_j\) are respectively the block averages through its first \(n_j\) and all \(n_j+1\) steps, composed on the right with \(\Phi_{s_j}\). Using the simulator at the end of that block therefore gives a difference \(T_C\circ\Phi_{s_j}\). Diamond contractivity under composition by a channel implies \(\mathcal D_{t_j}(d)\le\epsilon_j\) for \(d\le d_j\). Thus all defects in each fixed dimension tend to zero.

For the matching unrestricted value at any \(t_j\), a device can count the \(s_j\) preceding steps in separate layers without recording their values, retaining only the initial control bit. The same fixed maps then execute the flag test of Section 2 on block \(j\). This produces defect one at \(t_j\), and (2) applied to that block bounds it above by one even for time-dependent libraries. Together these statements prove Theorem 2.

## 5. Explicit checks from sign matrices

**Theorem 3.** Let the prefix consist of a uniform binary string indexing a set of size \(A=2^p\), followed independently by a uniform binary string indexing a set of size \(B=2^q\), then an independent fair bit \(z\). For any \(A\)-by-\(B\) sign matrix \(S\), set the final letter \(f\) by \((-1)^f=(-1)^z S_{xy}\). At this final step the unrestricted defect is one and
\[
 \mathcal D_{p+q+2}(d)\le \min\{1,d\|S\|_{\mathrm{op}}/\sqrt{AB}\}.
 \tag{8}
\]
For \(p=q=m\) and \(S_{xy}=(-1)^{x\cdot y}\), with binary inner product modulo two, the second upper bound is \(d2^{-m/2}\). In this explicit block a time-dependent classical device with at most \(4\cdot 2^m+4\) states attains one. A time-independent classical device with \(O((m+1)2^m)\) states does so. Thus a defect bounded away from zero requires linearly many persistent qubits in this explicit length-\(2m+2\) schedule, even with a passive reference.

To prove (8), let \(A_x\) and \(B_y\) be the products of the time-dependent channels within the two strings. Denote the channels at the mask bit by \(E_z\), those at the check by \(F_b\). Taking the average of the two final channels as simulator factors the difference up to a sign as the composition of \((F_0-F_1)/2\), \((E_0-E_1)/2\), and
\[
 T=\frac1{AB}\sum_{x,y} S_{xy}\,B_y A_x.
\]
Both exterior factors have diamond norm at most one; the factors multiply in this order because the mask is independent and its channel comes after both words. The map \(T\) preserves Hermiticity. For such a map the diamond norm is the maximum trace norm of its output on a pure input state with an input-sized reference. This is Theorem 3.51 of Watrous. For such a density matrix \(\rho\), write \(\rho_x=(A_x\otimes\mathrm{id})(\rho)\), so \(\|\rho_x\|_{\rm F}^2\le1\). Put \(Q_y=A^{-1}\sum_x S_{xy}\rho_x\). The Hilbert-space-valued operator norm bound, obtained by applying the scalar matrix bound in an orthonormal Hilbert–Schmidt basis, gives
\[
 \sum_y\|Q_y\|_{\rm F}^2\le A^{-2}\|S\|_{\rm op}^2\sum_x\|\rho_x\|_{\rm F}^2\le \|S\|_{\rm op}^2/A.
\]
On each Hermitian \(Q_y\), \(B_y\otimes\mathrm{id}\) contracts trace norm. Its input space has dimension at most \(d^2\), hence \(\|Q_y\|_1\le d\|Q_y\|_{\rm F}\). Triangle inequality and Cauchy–Schwarz for the average over \(y\) now give (8). The independent mask balances \(f\), so Section 2 supplies the matching unrestricted value. The Walsh matrix obeys \(S^\top S=2^m I\) by orthogonality. For the finite classical upper construction retain the initial control bit, the first word, and a running mod-two dot product as the second word arrives. On the mask bit collapse to the single flag consisting of the control bit XOR the dot product XOR the mask. The next step records the flag and final letter. This gives the Section 2 witness. A time-independent implementation includes a layer counter up to \(2m+2\).

In particular take independent consecutive blocks of this Walsh construction for lengths \(m=1,2,3,\ldots\). Fresh bits have zero defect and at the end of block \(m\) any memory dimension \(d\) has defect at most \(d2^{-m/2}\). Independence gives the composition estimate of Section 4 for arbitrary time-dependent libraries. The clock-padded classical detector gives an unrestricted defect of one at each endpoint. This is an explicitly specified process; no search over signs or choice of devices enters its definition. The statement concerns unbounded versus each fixed dimension, not one finite device attaining one at every endpoint.

## 6. The stationary case

**Theorem 4.** For a stationary process on any finite alphabet, the following three statements are equivalent.

1. The letters are independent and identically distributed.
2. Every finite-dimensional library has zero unit-step defect at every time.
3. For each fixed finite \(d\), the supremum \(\mathcal D_t(d)\) over all libraries of dimension at most \(d\), including time-dependent libraries, tends to zero as \(t\) tends to infinity.

More quantitatively, fix a window length \(k+1\), write \(U=X_{1:k}\) and \(A=X_{k+1}\), and choose any real function \(g\) of the first word with \(|g|\le1\) and \(\mathbb E g(U)=0\). For a fixed finite \(d\) depending only on the alphabet size and \(k\),
\[
 \inf_{t\ge k+1}\mathcal D_t(d)\ \ge\ \sum_a |\mathbb E[g(U)\mathbf 1_{A=a}]|.
 \tag{9}
\]
In particular, for a letter of positive conditional probability variation, the right side is at least twice the variance of its conditional probability if \(g(U)=\Pr(A=a_0\mid U)-\Pr(A=a_0)\).

For independent letters the mean channel at the next step factors exactly, hence (1) implies (2), and (2) implies (3). To prove (9), choose a target time. In all earlier steps before the specified window let every letter act by identity. During the first \(k\) steps of the window a classical device retains a control label \(c=+1\) or \(-1\) and the observed prefix. When reading the last letter of that prefix, erase both registers and output a single flag which is one with probability \((1+cg(U))/2\). This stochastic transformation is CPTP on a classical register by measuring in its basis and preparing a new diagonal state. The two control inputs now give the same fair marginal flag. At the last step output the pair consisting of the flag and the current letter. For the two inputs, the difference in probabilities on \((1,a)\) is \(\mathbb E[g(U)\mathbf 1_{A=a}]\), and on \((0,a)\) is its negative. Any simulator on the common previous output must give the same state on both inputs; one of its two trace-norm errors is at least half the distance between these explicitly different final states. This proves (9). For an alphabet of size \(s\), \(2\sum_{i=0}^{k-1}s^i+2+2s\) basis states suffice, independent of the target time. The choice with \(a_0\) has its \(a_0\) term equal to the variance, and the sum of all signed terms is zero. Stationarity supplies the same window distribution for every target in (9). If every finite last letter is independent of its entire finite prefix, stationarity and successive conditioning give the product of the common marginal for every finite word. Thus any stationary non-iid process has a dependent finite window and a positive variance for some last letter, violating (3). This proves the equivalence.

The supremum in (9) allows the starting clock for the detector to depend on the target time. The fixed quantity is its memory dimension. No assertion about a single time-homogeneous device at all late times is needed for the equivalence.

## 7. One classical bit detects every positive finite-horizon defect

Let the alphabet have finite size \(s\). Write \(\mathcal B_t\) for the supremum of \(D_t(C)\) restricted to time- and letter-dependent bistochastic classical two-state transitions, implemented by basis measurement and diagonal state preparation. The simulator in the infimum may still be any CPTP map. For \(t\ge2\), put \(Y=X_t\), let \(W_j=X_{t-j:t-1}\) be its suffix of length \(j\), and let \(q_j(\cdot\mid w)\) be the conditional law of \(Y\) given \(W_j=w\). The empty suffix gives the unconditional law \(q_0\). Zero-probability suffixes can be omitted. Let \(v\) be the suffix of \(w=uv\) of length \(j-1\), so \(u\) is a single letter. Put
\[
 L_j=\max_{w=uv}\Pr(W_j=w)\,\|q_j(\cdot\mid w)-q_{j-1}(\cdot\mid v)\|_1,
 \qquad R_K=\mathbb E\|q_{t-1}(\cdot\mid W_{t-1})-q_K(\cdot\mid W_K)\|_1.
\]

**Theorem 5.** For every finite-alphabet schedule, every horizon \(t\ge2\) and every \(0\le K\le t-1\),
\[
 \max_{1\le j\le t-1}L_j\le\mathcal B_t\le\mathcal D_t(\infty)
 \le R_K+\sum_{j=1}^K s^j L_j
 \le R_K+\left(\sum_{j=1}^K s^j\right)\mathcal B_t .
 \tag{10}
\]
Thus at any finite time, the following are equivalent: a zero worst-case defect for the classical bit, independence of the next letter from its full past, and a zero unrestricted defect. Two is the smallest universal state-space dimension for detecting positivity. The same test need not capture a constant fraction of a nonzero discrepancy.

Represent a classical bit by the mean of its \(\{-1,+1\}\)-valued label. For any \(h\in[-1,1]\) a bistochastic flip kernel has output mean \(h\) times its input mean, by keeping the input sign with probability \((1+h)/2\). Fix a positive-probability suffix \(w=uv\). Before the selected window choose gain one. At its first step use the gain \(\mathbf 1_{X_{t-j}=u}-\Pr(X_{t-j}=u\mid W_{j-1}=v)\). At the following \(j-1\) steps use the indicator that the letter matches the prescribed coordinate of \(v\). These gains are each a function of only that step's letter; the conditional probability and target word are parameters chosen in advance. The product \(g\) vanishes off the event \(W_{j-1}=v\) and has zero mean, including when \(j=1\). Hence the two opposite input signs produce identical fair diagonal states before the final step. For any final letter \(a\), direct conditioning gives
\[
 b_a=\mathbb E[g\,\mathbf 1_{Y=a}]=\Pr(W_j=uv)\big[q_j(a\mid uv)-q_{j-1}(a\mid v)\big].
\]
Choose the last gain \(\operatorname{sgn}(b_a)\) at letter \(a\), with zero allowed. The two final output means are \(\pm\sum_a|b_a|\), so their trace-norm distance is \(2\sum_a|b_a|\). Every quantum simulator sends the common previous state to one state. The triangle inequality gives a defect at least \(\sum_a|b_a|\), proving the first inequality in (10) for every suffix. The embedding of these transitions as CPTP maps gives the second inequality.

For the upper bound use the simulator \(\sum_a q_0(a) C_{t,a}\). After conditioning on the full history, the difference is an average of sums of channels with signed coefficients \(q_{t-1}(a\mid W_{t-1})-q_0(a)\). Each channel composition has diamond norm one, so the error is at most \(\mathbb E\|q_{t-1}-q_0\|_1\). Insert \(q_K\) and telescope the conditional probability vectors along suffixes of lengths \(0,1,\ldots,K\). Each increment's expected norm is a sum of at most \(s^j\) terms bounded by \(L_j\). This proves (10), including its endpoints. For \(K=t-1\) the remainder is zero. If the full conditional law differs from the marginal on a positive-probability word, some suffix increment of positive probability is nonzero by telescoping; the bit detects it. Conversely, independence gives the exact mean-channel simulator. A one-state register has only one possible channel, while a repeated fair bit with a deterministic final copy has positive defect by Section 2. This gives the dimension claim.

If the next letter depends on just the last \(K\) letters, take \(R_K=0\) in (10). More generally call the remote history uniformly negligible in mean if \(\lim_{K\to\infty}\limsup_{t\to\infty}R_K(t)=0\), with \(K\le t-1\). On any such process, \(\mathcal B_t\to0\) holds exactly when \(\mathcal D_t(\infty)\to0\). Indeed first take the time limsup at fixed \(K\) in (10), then let \(K\) increase. The reverse follows from inclusion of the restricted devices. A stationary finite-alphabet process has this remote-history property without mixing assumptions. In a two-sided stationary extension the conditional laws of the present letter given successively longer pasts are a bounded vector martingale. Their \(L^1\) convergence, coordinate by coordinate on the finite alphabet, bounds \(\sup_{t>K} R_K(t)\) by twice the \(L^1\) error of the length-\(K\) martingale limit approximation, by conditional Jensen. Alternatively, if a stationary process is not iid, some finite window has a nonzero suffix increment, and its probability and conditional laws are the same at every translated target time. The lower bound of (10) then gives \(\inf_{t\ge t_0}\mathcal B_t>0\). This sharpens Theorem 4 to a single classical bit of persistent memory, with a library allowed to depend on the target horizon. For the explicit Walsh schedule \(\mathcal B_{t_j}>0\) at checksum steps even though its value there tends to zero. This distinguishes exact detection from a dimension-independent fraction of the unrestricted defect.

## 8. Relation to earlier results

Postprocessing deficiency is an established way of comparing quantum channels. Generic process-tensor characterizations of Markovianity allow interventions, and recent resetting analyses exhibit divisibility failures for particular devices. The present results concern a resource constraint on the averaged channel experiment. A causal strategy with an unlimited external record can store the whole word, whereas a bounded memory has only the state space modeled here. The existence proof uses a random Boolean function and gives a worst-case bound, with the leading qubit constant between the stated lower and upper values. The single infinite schedule uses independent blocks of growing sizes. The explicit inner-product construction also gives a linear memory requirement, using a classical communication problem already known to need linear quantum communication. The new comparison is the bound on the diamond defect of the entire averaged instrument for every allowed device, its repeated operational separation, the single-bit positivity criterion, and its quantitative relationship to conditional dependence at finite memory depths. The sharp leading qubit constant and optimal constants under a time-independent restriction remain undetermined.

- A. Jenčová, *Comparison of quantum channels and statistical experiments*. [IEEE ISIT](https://doi.org/10.1109/ISIT.2016.7541699)
- F. A. Pollock et al., *Operational Markov Condition for Quantum Processes*. [Physical Review Letters](https://doi.org/10.1103/PhysRevLett.120.040405)
- S. Milz, M. S. Kim, F. A. Pollock and K. Modi, *Completely Positive Divisibility Does Not Mean Markovianity*. [Physical Review Letters](https://doi.org/10.1103/PhysRevLett.123.040401)
- F. Carollo and S. Wald, *Stochastic resetting induces quantum non-Markovianity*. [Public author text](https://arxiv.org/html/2601.13367v1)
- A. Ambainis, A. Nayak, A. Ta-Shma and U. Vazirani, *Dense quantum coding and quantum finite automata*. [Journal of the ACM](https://doi.org/10.1145/581771.581773)

- R. Cleve, W. van Dam, M. Nielsen and A. Tapp, *Quantum entanglement and the communication complexity of the inner product function*. [Public author text](https://arxiv.org/abs/quant-ph/9708019)
- J. Watrous, *The Theory of Quantum Information*, Theorem 3.51. [Author text](https://johnwatrous.com/wp-content/uploads/TQI.pdf)
