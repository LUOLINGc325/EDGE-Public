# A degree-corrected potential for two-vacancy variety-seeking jump games on subcubic graphs

**Research manuscript · 24 November 2026**  
**Status:** analytic research manuscript. This manuscript has not undergone external peer review; reproduction and formal proof sources are not included in this version.

## Abstract

In a variety-seeking jump game, agents occupy vertices of a graph and value the number of distinct types other than their own in their occupied neighborhood. Narayanan, Opatrny, Tummala and Voudouris proved convergence of improving dynamics on cubic graphs with two vacant vertices and conjectured convergence with two vacancies on arbitrary graphs. We extend the cubic result to every finite simple graph of maximum degree at most three, allowing nonregular and disconnected graphs. Let $T_E$ sum the type counts at the vacancies, let $A$ and $B$ count ordered monochromatic occupied edges and ordered vacant–vacant edges, and let $D$ sum the graph degrees at the vacancies. The nonnegative integer potential $\Psi=8T_E+4A+B+4D$ decreases by at least two at every strictly improving jump. Consequently, every improvement path from $q_0$ has length at most $\lfloor\Psi(q_0)/2\rfloor\le 6|V|+36$, and every initial assignment can reach a pure Nash equilibrium. The proof reduces the exact graph change to two elementary local inequalities. Exhaustive checks on all labelled subcubic graphs with two to six vertices provide an independent regression test. The unrestricted-degree conjecture remains outside the result.

## 1. Problem and relation to existing work

Variety-seeking jump games use the number of distinct neighboring types as the agent's utility. This differs from counting individual neighbors of another type and from using their fraction among all occupied neighbors. The distinction matters when several adjacent agents share a type.

The original work established potential results for two agent types, for one vacancy, for graphs of maximum degree two, and for cubic graphs with two vacancies [1, 2]. It also exhibited an improving cycle on a cubic graph with three vacancies. Its 2026 journal version retains the conjecture that every graph with two vacancies is a potential game [1, §5]. A theorem giving a particular equilibrium, for example on trees, does not by itself imply convergence of every improving trajectory.

Our result removes the regularity assumption from the cubic two-vacancy theorem. A graph may mix vertices of degrees zero, one, two and three. We prove convergence from every assignment, for every choice of strictly improving moves. We do not resolve the conjecture for graphs with vertices of degree four or larger.

The closest related models do not directly imply this conclusion. Variety-seeking swap games exchange two occupied agents and require the specified bilateral improvements [3]. The jump model in [4] instead uses a fraction-based diversity utility. Both the utility and the allowed move relation must be preserved when comparing results.

## 2. Model and theorem

Let $G=(V,E)$ be a finite simple undirected graph. Write $x\sim y$ for adjacency and $\deg(x)$ for graph degree. Let $\mathcal T$ be a finite set of types. A configuration is a map

$
q:V\longrightarrow\mathcal T\cup\{\bot\},
$

where $\bot$ denotes a vacancy. Throughout the theorem there are exactly two vacancies. Agents have fixed types, every agent is strategic, and there is no population-balance assumption. Connectivity is not required.

For any vertex $x$, put

$
T_q(x)=\{c\in\mathcal T:\exists y\sim x,\ q(y)=c\},
\qquad \tau_q(x)=|T_q(x)|.
$

The utility of a type-$c$ agent at $x$ is

$
u_q(c,x)=|T_q(x)\setminus\{c\}|.
$

A jump moves an agent from an occupied vertex $s$ to any vacant vertex $d$, whether or not $s\sim d$. The resulting configuration $q'$ agrees with $q$ elsewhere, has $q'(s)=\bot$, and has $q'(d)=q(s)$. It is an improving jump when

$
u_{q'}(q(s),d)>u_q(q(s),s).
$

An equilibrium admits no improving jump. The finite improvement property means that no infinite sequence of improving jumps exists.

Let $Z(q)=\{x:q(x)=\bot\}$. Define

$
\begin{aligned}
T_E(q)&=\sum_{x\in Z(q)}\tau_q(x),\\
D(q)&=\sum_{x\in Z(q)}\deg(x),\\
A(q)&=\sum_{(x,y)\in V^2}\mathbf1_{x\sim y,\ q(x)=q(y)\ne\bot},\\
B(q)&=\sum_{(x,y)\in V^2}\mathbf1_{x\sim y,\ q(x)=q(y)=\bot}.
\end{aligned}
$

Thus $A$ and $B$ count each qualifying undirected edge twice. This ordered-edge convention agrees with the formal model and avoids division in the potential.

**Theorem 1.** If $\deg(x)\le3$ for every $x\in V$, then

$
\boxed{\Psi(q)=8T_E(q)+4A(q)+B(q)+4D(q)}
\tag{1}
$

satisfies $\Psi(q')+2\le\Psi(q)$ for every improving jump $q\to q'$ with two vacancies. Every finite improvement path from $q_0$ has length at most

$
\left\lfloor\frac{\Psi(q_0)}2\right\rfloor\le 6|V|+36.
\tag{2}
$

There is no infinite improvement path, and a pure Nash equilibrium is reachable from every initial assignment.

We use “potential” in the precise sense that it strictly decreases on every strict improvement. No assertion about its behavior on utility-indifferent moves is needed.

## 3. Exact local change

Fix an improving jump of a type-$a$ agent from $s$ to $d$. Let $o$ be the other vacancy. The vertices $s,d,o$ are distinct. Set

$
\delta=\mathbf1_{s\sim d},\qquad
\beta=\mathbf1_{s\sim o},\qquad
\gamma=\mathbf1_{d\sim o}.
$

For $x=s,d$, count neighbors outside $\{s,d,o\}$ by three quantities: $m_x$, the number of type-$a$ agents; $n_x$, the number of agents of other types; and $r_x$, the number of distinct types among those $n_x$ agents. All vertices outside this set are occupied. Therefore

$
\begin{gathered}
\deg(s)=m_s+n_s+\delta+\beta\le3,
\qquad
\deg(d)=m_d+n_d+\delta+\gamma\le3,\\
0\le r_x\le n_x,
\qquad r_x=0\ \Longleftrightarrow\ n_x=0.
\end{gathered}
\tag{3}
$

The mover's utility before and after the jump is exactly $r_s$ and $r_d$, respectively. In particular,

$
r_d\ge r_s+1.
\tag{4}
$

Let $\alpha$ indicate whether $o$ has a type-$a$ neighbor outside $\{s,d,o\}$. Its other neighboring types are unchanged, so

$
\tau_{q'}(o)-\tau_q(o)=(1-\alpha)(\gamma-\beta).
\tag{5}
$

At the changing vacancy, the two type counts are

$
\tau_q(d)=r_d+\mathbf1_{m_d+\delta>0},
\qquad
\tau_{q'}(s)=r_s+\mathbf1_{m_s+\delta>0}.
\tag{6}
$

The term $\delta$ is essential: an edge between source and destination exposes the moving type to the vacancy both before and after the jump, at opposite endpoints.

Write $\Delta F=F(q')-F(q)$. Counting the remaining changes gives

$
\begin{aligned}
\Delta A&=2(m_d-m_s),\\
\Delta B&=2(\beta-\gamma),\\
\Delta D&=m_s+n_s-m_d-n_d+\beta-\gamma.
\end{aligned}
\tag{7}
$

The edge $sd$, if present, has a vacant endpoint both before and after the jump and contributes no monochromatic occupied edge. The sole possible vacant–vacant edge changes from $do$ to $so$.

Define

$
H(m,n,r,\delta)=4r+4\mathbf1_{m+\delta>0}-2m+2n,
\tag{8}
$

and abbreviate $H_x=H(m_x,n_x,r_x,\delta)$. Substitution of (5)–(7) into (1) yields the exact identity

$
\Delta\Psi=2(H_s-H_d+C),\qquad
C=4(1-\alpha)(\gamma-\beta)+3(\beta-\gamma).
\tag{9}
$

This identity uses the graph and the two-vacancy condition; regularity is not used.

## 4. Local inequalities and strict descent

The following bounds are statements about nonnegative integers, with binary adjacency indicators.

**Lemma 2, destination bound.** If $1\le r\le n$ and $m+n+\delta\le3$, then

$
H(m,n,r,\delta)\ge6r+2\delta.
\tag{10}
$

**Proof.** If $\delta=0,m=0$, the difference from $6r$ is $2(n-r)\ge0$. If $\delta=0,m>0$, then $m\le2$, and that difference is $4-2m+2(n-r)\ge0$. If $\delta=1$, then $m\le1$, so the same expression is at least two. These cases exhaust the possibilities. ∎

**Lemma 3, source bound.** If $0\le r\le n$, $r=0$ exactly when $n=0$, and $m+n+\delta+\beta\le3$, then

$
H(m,n,r,\delta)\le6r+4+2\delta-2\beta.
\tag{11}
$

**Proof.** First suppose $n=0$, so $r=0$. For $\delta=1$, we have $H=4-2m\le4\le6-2\beta$. For $\delta=0,m=0$, the bound is immediate. For $\delta=0,m>0$, we have $H=4-2m\le2\le4-2\beta$.

Now let $n>0$, so $r\ge1$. When $\delta=0,m=0$,

$
H-6r=2(n-r)\le2(n-1)\le4-2\beta.
$

When $\delta=0,m>0$, the degree constraint gives

$
H-6r\le4-2m+2(n-1)
\le8-4m-2\beta\le4-2\beta.
$

When $\delta=1$, it gives

$
H-6r\le4-2m+2(n-1)
\le6-4m-2\beta\le6-2\beta.
$

These are exactly the bounds required in (11). ∎

Apply Lemma 2 at $d$, dropping the nonnegative $\gamma$ from its degree constraint, and Lemma 3 at $s$. Equation (4) gives

$
H_d-H_s\ge6(r_d-r_s)-4+2\beta\ge2+2\beta.
\tag{12}
$

If $\alpha=0$, then $C=\gamma-\beta\le1+2\beta$. If $\alpha=1$, then $C=3(\beta-\gamma)\le3\beta\le1+2\beta$. Hence (9) and (12) imply

$
\Delta\Psi\le2\bigl(-(2+2\beta)+(1+2\beta)\bigr)=-2.
\tag{13}
$

This proves the strict-descent assertion of Theorem 1.

## 5. Path length, termination and agent identities

For a path $q_0\to q_1\to\cdots\to q_L$, summing (13) gives

$
2L+\Psi(q_L)\le\Psi(q_0).
\tag{14}
$

All potential terms are nonnegative. Therefore $L\le\lfloor\Psi(q_0)/2\rfloor$; an infinite path would have prefixes violating this bound.

For the stated uniform bound, each vacancy has at most as many neighboring types as neighbors, so $T_E\le D\le6$. For each ordered edge, its contribution to $4A+B$ is at most four. Thus

$
4A+B\le4\sum_{x\in V}\deg(x)\le12|V|,
\qquad
\Psi\le12D+12|V|\le12|V|+72.
\tag{15}
$

Equations (14) and (15) prove (2). Starting from any assignment, choose an improving jump whenever one exists. The finite bound forces this procedure to stop at an equilibrium. Equivalently, a reachable state of minimum natural-valued potential cannot admit an improving successor.

The type-configuration notation does not discard a strategic constraint. A labelled assignment maps each occupied vertex to an agent, with each agent occurring exactly once. Composing this map with the fixed agent-to-type map gives $q$. Moving the agent at $s$ to vacant $d$ preserves unique occupancy, preserves the set of agents and all type populations, and projects to the configuration jump used above. Apply the same descent argument directly to this labelled move relation, retaining unique occupancy as an invariant. This proves descent, termination and reachability of an equilibrium for the specified population of actual agents. No agent is made stubborn because it happens not to move on a particular trajectory.

## 6. Why the cubic expression alone does not suffice

The cubic proof in [1, 2] uses $2(T_E+M)+b$, where $M=A/2$ counts undirected monochromatic occupied edges and $b=B/2$ indicates adjacency of the vacancies. The following subcubic graph shows that this expression need not decrease strictly on a nonregular graph.

Take vertices $0,\ldots,6$ and edges

$
\{03,34,41,15,52,16\}.
$

Initially vertices 1 and 2 are vacant; vertices 0, 3, 4 and 5 contain red agents; vertex 6 contains a blue agent. The red agent jumps from 0 to 1, increasing its utility from zero to one.

| Quantity | Before | After |
|---|---:|---:|
| $T_E$ | 3 | 2 |
| $A$ | 4 | 6 |
| $B$ | 0 | 0 |
| $D$ | 4 | 2 |
| Cubic expression $2(T_E+A/2)+B/2$ | 10 | 10 |
| New potential $\Psi$ | 56 | 48 |

This example identifies the strictness gap in a direct reuse of the cubic expression. It is not a counterexample to convergence. The vacancy degree sum changes in this example and contributes to the new potential.

## 7. Verification and scope of the evidence

The finite-graph checker `code/verify_graphs.cpp` independently computes utilities and potential features from adjacency matrices. It enumerates all labelled simple graphs with maximum degree at most three, chooses every pair of vacancies, and enumerates every partition of the remaining vertices into types. Type names are identified up to renaming; graph labels are retained. Every improving source–vacancy jump is then checked. The implementation uses the equivalent undirected potential $\Psi/2$.

| Vertices | Graphs | Configurations | Improving jumps |
|---:|---:|---:|---:|
| 2 | 2 | 2 | 0 |
| 3 | 8 | 24 | 0 |
| 4 | 64 | 768 | 384 |
| 5 | 768 | 38,400 | 48,240 |
| 6 | 12,068 | 2,715,300 | 5,483,280 |
| **Total** | **12,910** | **2,754,494** | **5,531,904** |

The largest observed change of $\Psi/2$ was $-1$, equivalently $-2$ for $\Psi$. The seven-vertex example was also checked directly. The raw computational output is not included in this version. These checks test the implementation and the formula on a finite domain; they are not the proof for arbitrary graphs.

The formal proof separates actual graph identities from scalar inequalities. `SubcubicDefs.lean` defines the graph, configurations, utility, ordered edge counts and jumps. `SubcubicCounts.lean` proves the distinct-type/multiplicity inequalities from finite-set images. `LocalAlgebra.lean` proves Lemmas 2–3 and the correction estimate for arbitrary integer parameters satisfying their stated constraints. `GenericDescent.lean` proves the path budget, absence of infinite paths and existence of reachable terminal states. The `SubcubicPotential`, `SubcubicTheorems` and `SubcubicLabelled` modules combine the actual graph identities with these inequalities and termination principles; `LabelledProjection` preserves the identity invariant, `SubcubicBounds` supplies the uniform bound, and `NonVacuity` verifies the seven-vertex instance. The original source uses Lean 4.19.0. The source and build evidence are not included in this version; no new compilation or axiom verification is claimed.

Our literature check inspected the original full manuscript, the 2026 journal article, adjacent models and searches for subcubic, maximum-degree-three, nonregular and degree-corrected variants. No matching extension was located in that bounded search as of 24 November 2026. This supports presenting the theorem as a candidate new extension; it does not establish exhaustive coverage or global priority. The general two-vacancy conjecture is left open by this work.

## References

[1] L. Narayanan, J. Opatrny, S. Tummala and A. A. Voudouris. **Variety-Seeking Jump Games on Graphs.** *Journal of Artificial Intelligence Research* 86, Article 50, 2026. DOI: [10.1613/jair.1.21746](https://doi.org/10.1613/jair.1.21746). The full article was inspected through its [public authored copy](https://www.researchgate.net/publication/412299314_Variety-Seeking_Jump_Games_on_Graphs); publication metadata were checked against the [institutional record](https://portal.findresearcher.sdu.dk/en/publications/variety-seeking-jump-games-on-graphs/).

[2] L. Narayanan, J. Opatrny, S. Tummala and A. A. Voudouris. **Variety-Seeking Jump Games on Graphs.** *Proceedings of IJCAI 2025*, 4005–4013. DOI: [10.24963/ijcai.2025/446](https://doi.org/10.24963/ijcai.2025/446). [Full author manuscript, arXiv:2505.10005v1](https://arxiv.org/html/2505.10005v1).

[3] Y. Li, L. Narayanan, J. Opatrny and Y. T. Xu. **Diversity-seeking Swap Games in Networks.** *Proceedings of AAMAS 2025*, 2621–2623. [Official extended abstract](https://www.ifaamas.org/Proceedings/aamas2025/pdfs/p2621.pdf); [full author manuscript, arXiv:2502.13375v1](https://arxiv.org/html/2502.13375v1).

[4] L. Narayanan, Y. Sabbagh and A. A. Voudouris. **Diversity-seeking jump games in networks.** *Autonomous Agents and Multi-Agent Systems* 39, Article 32, 2025. DOI: [10.1007/s10458-025-09714-8](https://doi.org/10.1007/s10458-025-09714-8).
