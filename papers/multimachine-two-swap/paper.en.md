# Improving two-swap paths with a persistent critical job

**Abstract.** We study makespan local search on identical parallel machines. The neighborhood allows one-job moves, simultaneous two-job moves in the same direction, and one-for-one exchanges. If a particular job belongs to the unique critical machine throughout an improving path, every such path has $O(n^4)$ steps for $n$ jobs, independently of the machine count and the real processing times. The proof links each departure of the distinguished job from a machine to its next return there. The signed processing time of the accompanying exchange strictly increases along these links. Counting first arrivals and controlling rank sums between migrations gives an explicit bound involving the number of distinct companion durations. Consecutive integer companion durations already permit quadratic paths.

## Introduction

Rohwedder, Safari and Vredeveld prove a quartic iteration bound for two machines in the full two-swap neighborhood. The open question in their conclusion concerns larger machine counts. A bound for every fixed machine count can depend on that count in its polynomial exponent. A different elementary estimate bounds the number of possible objective values when the number of duration types is fixed. Both restrictions allow important special cases, while the class treated here permits both counts to grow. We use a path property: a fixed job always belongs to the unique critical machine. A dominance inequality gives a sufficient instance condition for all paths. [Two-machine theorem and the question in §5](https://arxiv.org/html/2401.05956v2) · [Fixed-machine proof](#appendix-a-earlier-fixed-machine-bound) · [Fixed-duration-type result](#appendix-b-duration-types-and-superincreasing-processing-times)

## 1. Problem and theorem

Assign $n\ge1$ labeled jobs with positive real processing times to $m\ge1$ identical machines. A two-swap changes the assignments of at most two jobs between two machines. It includes a one-job move, two jobs moving in the same direction, and a one-for-one exchange. The objective is the lexicographic pair consisting of the maximum machine load and the number of machines that achieve it. A path is improving when this pair decreases strictly at every step. We study all such paths under the condition that one particular job $a$ belongs to the unique maximum-load machine in every state of the path, including its endpoints. The job is persistent, even though its machine can change.

**Theorem.** Let $u$ be the number of distinct processing times among the jobs other than $a$. Every improving path of length $\ell$ with the stated persistence property satisfies
$$
\ell+1\le
\big[1+(2u+1)\min\{m-1,n-1+u\}\big]\big[1+u(n-1)\big].
\tag{1}
$$
In particular, $\ell=O(n^4)$, uniformly in the number of machines and for arbitrary real durations with ties. For each fixed $m$, this gives $\ell=O_m(n^3)$ on the same path class. The sufficient instance condition
$$
p_a>\sum_{j\ne a}p_j
\tag{2}
$$
guarantees persistence from every initial state on every improving path.

The universal guarantee in (2) leaves all durations of the other jobs unrestricted. The path condition can hold in the absence of (2). For example, with job durations $4,6,3$, the 4-job shares a machine initially with the 6-job. Swapping the 6-job with the 3-job on a second machine lowers the makespan from 10 to 7 and preserves the 4-job on the unique critical machine.

## 2. A migration comparison on each revisited machine

Let $C_t$ be the total processing time of jobs other than $a$ on its machine in state $t$. Since the maximum load is $p_a+C_t$ and exactly one machine achieves it, $C_t$ decreases strictly. In each step the current critical machine must participate and lose load. Otherwise its old load is still present or increases, which contradicts strict makespan improvement. Thus the only net sender at a step is the machine holding $a$ just before that step. In particular, the load on any other machine can only stay the same or increase in that step.

An event is an improving step in which $a$ changes machines. For event $e$, denote the former and new machines by $A_e,B_e$ and the companion loads before and after by $C_e^-,C_e^+$. Its signed processing time $s_e$ is defined as follows.

| Event action | $s_e$ |
| --- | --- |
| $a$ moves alone | $0$ |
| $a$ exchanges with a job $y$ at $B_e$ | $+p_y$ |
| $a$ and a job $y$ on $A_e$ move together to $B_e$ | $-p_y$ |

Just after event $e$, the load on $A_e$ is $C_e^-+s_e$. Just after any event $f$, the companion load on $B_f$ is its load before $f$ minus $s_f$. These are equalities of actual loads, with no assumption on the sign of $s_e$.

Suppose the machine $A_e$ becomes critical next at event $f$, so $A_e=B_f$ and $a$ does not visit this machine in between. Its load is nondecreasing between the two events, by the net-sender observation. This gives
$$
C_f^+\ge C_e^-+s_e-s_f.
$$
The companion loads strictly decrease along the entire path, so $C_f^+<C_e^-$. Hence
$$
s_f>s_e.
\tag{3}
$$
This conclusion holds even if the inactive machine received jobs during the interval.

## 3. Counting migration events independently of empty machines

Make a directed graph on the events. Link $e$ to $f$ if $f$ is the next arrival of $a$ on $A_e$ after its departure in $e$. Each event has at most one successor and at most one predecessor. For a given arrival, the predecessor can only be the last departure of $a$ from that arrival machine. Edges go forward in time, so the event graph is a disjoint union of directed paths, including singleton paths. Along each path (3) forces strictly increasing values in the set $\{0\}\cup\{\pm p_j:j\ne a\}$. Consequently each directed path has at most $2u+1$ events.

The events with no predecessor are exactly the first arrivals at machines distinct from the initial machine of $a$. There is at most one such event per machine. To bound this count even with arbitrarily many empty machines, consider the last departure from each machine that ever held $a$, except the machine holding $a$ in the final state. Partition by its load just after the last departure.

- A machine with positive load retains positive load to the end, because it is inactive thereafter. There are at most $n-1$ such machines. Each contains at least one of the other jobs in the final state.
- If the load immediately after departure is zero, $C_e^->0$ still holds because $0\le C_e^+<C_e^-$. The event must carry a single companion $y$ along with $a$, and $y$ must be the only companion at departure. Thus $C_e^-=p_y$. These values $C_e^-$ are distinct across such departures, since the companion load decreases strictly across the path. There are at most $u$ such machines.

The number of ever-visited machines other than the final one is therefore at most $n-1+u$. It also equals the number of ever-visited machines other than the initial one. Thus there are at most $\min\{m-1,n-1+u\}$ directed paths in the event graph, and at most $(2u+1)\min\{m-1,n-1+u\}$ events.

## 4. Counting steps while the critical machine stays fixed

Between consecutive events, including the initial and final stretches, the critical machine stays fixed. Rank the distinct durations of the other jobs from $1$ to $u$ in increasing order. Equal durations share a rank. A non-event step strictly decreases the sum of ranks on the critical machine excluding $a$. It either sends one or two positive-rank jobs away or exchanges a strictly longer job for a shorter one. The strict duration order in the latter case is forced by the strict load decrease. A move involving only other machines cannot be improving. The rank sum is a nonnegative integer of size at most $u(n-1)$, so each stretch has at most $u(n-1)$ non-event steps.

With $E$ events there are $E+1$ stretches. Therefore $\ell\le E+(E+1)u(n-1)$, and the event bound gives (1). When $u=0$ the only job is $a$, and no improving step is possible, also as in (1). Condition (2) implies that the load of the machine holding $a$ in every assignment exceeds that of every other machine, proving its stated consequence.

## 5. Quadratic paths with consecutive companion durations

For $n=2h+1$, use two machines, ordinary jobs $1,\ldots,2h$ of durations $p_i=i$, and a job $a$ satisfying (2). Initially the companions of $a$ are $h+1,\ldots,2h$. If a companion $i$ has its predecessor $i-1$ outside, exchange the two jobs. This lowers the makespan by one because $a$ stays on the critical machine. Unless the companion set is $\{1,\ldots,h\}$, such a pair exists. If none existed, the companion set would be downward closed in $1,\ldots,2h$ and have cardinality $h$. The sum of the companion indices falls exactly one at every step. Its starting and ending values differ by $h^2$, so the path has exactly $h^2$ steps. This gives a quadratic lower bound already for consecutive integer companion durations. Matching the quartic upper exponent for arbitrarily many machines remains open.

## 6. General paths, the relationship to earlier proofs, and verification

The original objective allows ties. For example, with processing times $(2,8,1,6)$ and three machines, the assignments $(0,0,1,1),(1,0,1,1),(1,0,2,1),(2,0,2,1)$ have load vectors $(10,7,0),(8,9,0),(8,8,1),(8,6,3)$. Each step improves the objective, including the last step, which keeps the makespan at 8 and reduces the critical-machine count from two to one. The job of duration 2 moves both in the first and the last step. This illustrates how reuse of a transfer can occur in unrestricted paths. The persistence theorem assumes a unique critical machine and uses the stricter, machine-specific comparison (3). [Historical fixed-machine manuscript, §2.4](#appendix-a-earlier-fixed-machine-bound)

For any fixed machine count $m$, the earlier path theorem gives an explicit bound $m!(n^2+1)^{m-1}\binom{n^2+m-1}{m-1}$ on the number of states, with arbitrary durations and ties. It uses an abstract recurrence with a closed band measured from the current peak, a finite set of positive transfer values, and an integer rank mass. The fixed-duration-type theorem instead counts possible peak loads and critical-machine counts. In the intermediate superincreasing proof, the maximum-load machine contains the largest job and the maximum two companion indices divide the path into a polynomial number of phases. Bound (1) does not order all subset sums and allows arbitrary companions. [Fixed-machine proof](#appendix-a-earlier-fixed-machine-bound) · [Fixed-duration-type proof](#appendix-b-duration-types-and-superincreasing-processing-times) · [Superincreasing case](#appendix-b-duration-types-and-superincreasing-processing-times)

The fixed-critical-machine rank potential used in §4 comes from the two-machine proof of Rohwedder et al. Their Lemma 3.2 counts changes via the gap of two machine loads. Their three-swap exponential lower bound uses a dominant blocking job, so dominance does not by itself guarantee a polynomial bound for larger neighborhoods. A subsequent smoothed analysis controls deterministic iterations using the minimum exchange gap and obtains expected polynomial convergence under perturbations. The new combinatorial count concerns machine-specific returns and has no numerical separation requirement. [Two-machine bound and three-swap construction](https://arxiv.org/html/2401.05956v2) · [Smoothed analysis, §3](https://arxiv.org/html/2411.17245v1) · Literature comparison

The bound counts iterations for every choice of improving steps. It does not analyze the cost of finding each step. A joint polynomial bound for arbitrary paths without a persistent critical job, and the sharp exponent for the persistent-job class, remain open here. The finite verification includes 270 full labeled assignment graphs and checks paths obtained by exact longest-path computation. It is separate evidence for the implemented model and examples. [Reproduction](evidence/README.md)

## Appendix A. Earlier fixed-machine bound

For any improving path in the original two-swap problem, with no persistence hypothesis, the exact historical bound is
$$
\ell+1\le m!(n^2+1)^{m-1}\binom{n^2+m-1}{m-1}.
\tag{A1}
$$
Its abstract process bound is $m!(R+1)^{m-1}\binom{K+m-1}{m-1}$, where $R$ bounds total integer mass and $K$ bounds the number of distinct positive transfer values. The following Chinese proof is carried over from the original manuscript. Formula numbers beginning with A are local to this appendix.

### A.2 原始调度模型

#### A.2.1 状态与改善目标

作业集合为 $J=\{0,\ldots,n-1\}$，机器集合为 $M=\{0,\ldots,m-1\}$，作业 $j$ 的处理时间为 $p_j>0$。调度是映射 $\sigma:J\to M$。定义

$$
L_i(\sigma)=\sum_{j:\sigma(j)=i}p_j,\qquad
C(\sigma)=\max_{i\in M}L_i(\sigma),
$$

以及达到最高负载的机器集合和数量

$$
\operatorname{Crit}(\sigma)=\{i:L_i(\sigma)=C(\sigma)\},
\qquad c(\sigma)=|\operatorname{Crit}(\sigma)|.
$$

称 $\sigma\to\tau$ 为改善，如果

$$
C(\tau)<C(\sigma)
\quad\text{或}\quad
C(\tau)=C(\sigma)\text{ 且 }c(\tau)<c(\sigma).
\tag{A3}
$$

特别地，原状态可能有多个最高负载机器，合法改善不一定使最大负载严格下降。

#### A.2.2 二交换邻域

一次原始操作属于以下三类之一：

1. 把一个作业从其所在机器迁移到另一台机器；
2. 把同一台机器上的两个不同作业同时迁移到另一台机器；
3. 交换分属两台不同机器的两个作业。

每一步都必须满足式 (A3)。允许相同处理时间，允许机器负载相等，允许空机器，也允许任意选择符合条件的操作。形式模型从作业分配函数与上述三类操作出发，没有把下面将证明的临界源机器条件预先放进原始路径定义。

#### A.2.3 从全局改善得到局部严格条件

**引理 1（全局改善的局部必要条件）。** 设一步只改变不同机器 $a,b$，并且存在正数 $\delta$，使其负载变化为

$$
L_a'=L_a-\delta,\qquad L_b'=L_b+\delta,
\tag{A4}
$$

其他负载不变。若该步满足式 (A3)，则

$$
L_a=C,\qquad 0<\delta<L_a-L_b.
\tag{A5}
$$

**证明。** 由改善可知 $C'\leq C$。由于 $L_b'=L_b+\delta\leq C'$ 且 $\delta>0$，必有 $L_b<C$。若 $L_a<C$，两台被修改机器在操作前都不是临界机器，所有旧临界机器仍保留负载 $C$。于是 $C'=C$，临界机器数不能下降，与式 (A3) 矛盾。因此 $L_a=C$。

接着由 $L_b'=L_b+\delta\leq C$ 得 $\delta\leq L_a-L_b$。若取等号，原临界机器 $a$ 的新负载为 $L_b<C$，原非临界机器 $b$ 的新负载为 $C$，而其他临界机器不变。因此最大负载和临界机器数都不变，再次矛盾。故不等式必须严格。这个论证没有假设临界机器唯一。证毕。

单作业或两个作业同向迁移的正转移量分别是 $p_u$ 和 $p_u+p_v$。交换操作若两作业处理时间相同，则所有机器负载不变，不可能改善；否则，将较大作业所在机器选为源机器，正转移量为 $p_v-p_u$，其中 $p_v>p_u$。因此每个原始合法步均可按式 (A4)–(A5) 定向。

#### A.2.4 三机器中同一转移量可以再次出现

下面的有限例子解释为何不能直接沿用二机器证明中的某种一次性转移收费。它不是超多项式下界。

取四个有标签的作业，处理时间依次为 $(2,8,1,6)$，使用三台机器。分配向量的第 $j$ 项表示作业 $j$ 所在机器。

| 状态 | 分配向量 | 三台机器负载 | 目标二元组 |
|---|---|---|---|
| $\sigma^0$ | $(0,0,1,1)$ | $(10,7,0)$ | $(10,1)$ |
| $\sigma^1$ | $(1,0,1,1)$ | $(8,9,0)$ | $(9,1)$ |
| $\sigma^2$ | $(1,0,2,1)$ | $(8,8,1)$ | $(8,2)$ |
| $\sigma^3$ | $(2,0,2,1)$ | $(8,6,3)$ | $(8,1)$ |

第一步把作业 $0$ 从机器 $0$ 移至机器 $1$，转移量为 $2$，唯一临界机器随之改变。第二步把处理时间为 $1$ 的作业 $2$ 从机器 $1$ 移至机器 $2$。第三步再次移动**同一个作业 $0$**，从机器 $1$ 移至机器 $2$，转移量仍为 $2$。最后一步最大负载保持为 $8$，但临界机器数从 $2$ 降至 $1$，因而仍是原模型下的严格改善。

该例说明，临界机器改变以后，相同正转移量乃至相同有标签作业仍可能再次参与改善。本文的计数对象因此采用顶带中的整数质量与有限转移值递推，不要求每个数值只出现一次。

### A.3 有限转移值与整数质量的一般定理

#### A.3.1 抽象过程的全部假设

令 $A$ 为有限非空机器集合，$m=|A|$，$D\subset\mathbb R$ 为有限集合，$K=|D|$，$R\in\mathbb N$。一个有效状态由实负载 $L_i$、自然数质量 $\mu_i$ 和实数峰值 $C$ 组成，满足

$$
L_i\leq C\quad(i\in A),\qquad
\exists i\in A:L_i=C,\qquad
\sum_{i\in A}\mu_i\leq R.
\tag{A6}
$$

抽象负载不必非负。每一步选择不同的 $a,b\in A$、$\delta\in D$ 和正整数 $g$，满足

$$
L_a=C,\qquad 0<\delta<L_a-L_b,
\tag{A7}
$$

以及局部更新方程

$$
\begin{aligned}
L_a'&=L_a-\delta,& L_b'&=L_b+\delta,& L_i'&=L_i\;(i\notin\{a,b\}),\\
\mu_a&=\mu_a'+g,& \mu_b'&=\mu_b+g,& \mu_i'&=\mu_i\;(i\notin\{a,b\}).
\end{aligned}
\tag{A8}
$$

状态有效性同时适用于每一步的前后状态。这里对整数质量的条件是具体的局部守恒方程，而不是预先假设某个最终势函数下降。对路径长度没有任何先验上界假设。

**定理 2（一般有限转移值路径界）。** 对每条满足式 (A6)–(A8) 的有限路径，若步数为 $\ell$，则

$$
\ell+1\leq B(R,K,m),
\qquad
B(R,K,m)=m!\,(R+1)^{m-1}\binom{K+m-1}{m-1}.
\tag{A9}
$$

集合 $D$ 中允许存在未被使用的值；只有实际选取的 $\delta$ 必须严格为正。这一点使得递归删去一个候选值后仍可直接应用同一定理。

#### A.3.2 峰值与顶带

**引理 3（峰值不增）。** 每一步均有 $C'\leq C$。

**证明。** 更新后的源负载为 $C-\delta<C$，更新后的接收负载由严格间隙条件满足 $L_b+\delta<C$，其他负载不超过 $C$。新峰值由一个机器负载取得，故不超过 $C$。证毕。

固定 $d\geq0$，并假设正在分析的路径中所有转移量均满足 $\delta\leq d$。定义当前顶带

$$
S=\{i\in A:C-d\leq L_i\}.
\tag{A10}
$$

它是以当前最高负载为上端、宽度为 $d$ 的机器集合。

**引理 4（顶带非空且成员单调）。** 顶带包含所有当前最高负载机器，特别是每一步的源机器；每一步均有 $S\subseteq S'$。

**证明。** 峰值能够取得，所以顶带非空。对源机器，$L_a'=C-\delta\geq C-d\geq C'-d$，因此它更新后仍在顶带内。对其他旧带内机器，负载不降，而引理 3 保证新阈值 $C'-d\leq C-d$，故它们也仍在带内。证毕。

**引理 5（带内接收与最大值排除）。** 若接收机器 $b\in S$，则 $\delta<d$。若某一状态满足 $S=A$，则从该状态起所有后续步的转移量均严格小于 $d$。

**证明。** 由 $L_b\geq C-d$ 和源机器负载为 $C$，有 $L_a-L_b\leq d$。再用式 (A7) 得 $\delta<d$。若顶带已为全集，引理 4 保证以后仍为全集，因此每个后续接收机器都在旧顶带内。证毕。

#### A.3.3 顶带质量恒等式与整数势

记

$$
M(S)=\sum_{i\in S}\mu_i,
\qquad
U=S'\setminus S,
\qquad k=|U|.
$$

定义旧顶带在该步流出的质量

$$
e=\begin{cases}
0,&b\in S,\\
g,&b\notin S.
\end{cases}
\tag{A11}
$$

由源机器始终属于旧顶带，质量局部方程直接给出

$$
\sum_{i\in S}\mu_i'+e=\sum_{i\in S}\mu_i.
$$

再将新进入顶带的机器加上，得到

$$
\sum_{i\in S'}\mu_i'+e
=\sum_{i\in S}\mu_i+\sum_{i\in U}\mu_i'.
\tag{A12}
$$

每台机器的自然数质量不超过总质量上界 $R$，所以

$$
\sum_{i\in U}\mu_i'\leq kR.
\tag{A13}
$$

定义自然数势

$$
\Phi_d=(m-|S|)(R+1)+\sum_{i\in S}\mu_i.
\tag{A14}
$$

**引理 6（势的收费不等式）。** 每一步都有

$$
\Phi_d'+e+k\leq\Phi_d.
\tag{A15}
$$

因此势不增；势相等当且仅当顶带没有扩张且接收机器属于旧顶带。势严格下降当且仅当顶带扩张或接收机器在旧顶带之外。此外，所有有效状态都满足

$$
0\leq\Phi_d<m(R+1).
\tag{A16}
$$

**证明。** 由 $S\subseteq S'$，有 $|S'|=|S|+k$。代入式 (A12)–(A14)，得到

$$
\Phi_d-\Phi_d'
=k(R+1)+e-\sum_{i\in U}\mu_i'
\geq k+e,
$$

即式 (A15)。若 $k>0$，势至少下降 $1$；若接收机器在旧带外，则 $e=g\geq1$，势也至少下降 $1$。若二者均不发生，则 $U=\varnothing,e=0$，式 (A12) 保证带内质量守恒，势恰好相等。这也证明了所述等价关系。最后，顶带非空且带内质量至多 $R$，所以

$$
\Phi_d\leq(m-1)(R+1)+R=m(R+1)-1.
$$

非负性来自定义。证毕。

式 (A15) 同时支付两类变化的成本：质量从旧顶带流出，以及新机器进入顶带。带扩张时新带内质量可能增加，系数 $R+1$ 确保这种增加不会破坏整数势下降。

#### A.3.4 恒定势区间是合法的较少机器子路径

**引理 7（恒定势区间的限制）。** 若两个时刻 $a\leq b$ 满足 $\Phi_d(a)=\Phi_d(b)$，则整个区间的顶带等于固定集合 $S_a$，每个内部步的源和接收机器均属于 $S_a$。将该段路径限制到机器集合 $S_a$，得到满足式 (A6)–(A8)、具有相同整数质量上界 $R$ 和候选集合 $D$ 的合法抽象路径。

**证明。** 势不增，故端点相等迫使整个区间的势相等。引理 6 逐步给出顶带不变和接收机器在旧带内；引理 4 给出源机器也在带内。原状态的峰值在顶带内取得，限制后仍是有效峰值。自然数质量在子集上的总和不超过全体总和，且两台被修改机器都保留在子集内，因此所有局部更新方程原样成立。证毕。

这一限制必须应用于每一个实际连续区间。不同恒定势区间之间可能存在涉及带外机器的操作，不能将删除这些操作后得到的不连续片段擅自拼成一条小机器实例的合法路径。

### A.4 路径分解与闭式上界

#### A.4.1 一个离散区间计数事实

**引理 8（有限势值与恒定区间计数）。** 设自然数序列 $q_0,\ldots,q_L$ 单调不增，$q_0\leq Q$。若每个端点势相等的连续区间 $[a,b]$ 都满足 $b-a+1\leq H$，则

$$
L+1\leq(Q+1)H.
\tag{A17}
$$

**证明。** 对单调序列，每个实际出现的势值只占据一个连续区间。势值至多为 $0,\ldots,Q$，因此至多有 $Q+1$ 个此类区间，每个至多包含 $H$ 个状态。将互不相交的状态区间求和即可。证毕。

#### A.4.2 顶带尚未覆盖全集的前缀

设 $m\geq2$，令 $A_m=m(R+1)$。考虑长度为 $L$ 的路径前缀，并假设每个非末状态的顶带都是真子集。再假设一般定理已对少于 $m$ 台机器的情形成立。

**引理 9（真顶带前缀界）。** 在上述条件下，

$$
L+1\leq A_m B(R,K,m-1).
\tag{A18}
$$

**证明。** 对一个恒定势区间 $[a,b]$，若 $a<L$，其固定顶带是非空真子集，故机器数 $s\leq m-1$。引理 7 和较小机器数的归纳假设给出

$$
b-a+1\leq B(R,K,s)\leq B(R,K,m-1).
$$

后一个不等式使用 $B$ 关于正机器数的单调性，见下一节。若 $a=L$，该区间只有一个状态，所需结论由 $B(R,K,m-1)\geq1$ 得到。这一单状态情形允许前缀的最后一个状态恰好首次成为满顶带。

由式 (A16)，初始势至多为 $A_m-1$。将引理 8 应用于 $H=B(R,K,m-1)$、$Q=A_m-1$，即得式 (A18)。证毕。

也可以把式 (A18) 理解为：异常步至多 $A_m-1$ 次，恒定势区间至多 $A_m$ 个。按状态数而非仅按步数计数，能够同时覆盖空区间、零长度前缀和首次满带的边界。

#### A.4.3 闭式的代数性质

由定义直接有 $B(R,K,1)=1$，且只要 $m\geq1$，就有 $B(R,K,m)\geq1$。对固定 $R,m$，$B$ 随 $K$ 单调不减。对固定 $R,K$，它也随正机器数 $m$ 单调不减。

当 $K\geq1,m\geq2$ 时，Pascal 恒等式给出

$$
B(R,K,m)
=B(R,K-1,m)+m(R+1)B(R,K,m-1).
\tag{A19}
$$

具体而言，将

$$
\binom{K+m-1}{m-1}
=\binom{K+m-2}{m-1}+\binom{K+m-2}{m-2}
$$

乘以 $m!(R+1)^{m-1}$，第二项即为 $m(R+1)B(R,K,m-1)$。关于 $K$ 的单调性来自二项式系数关于上指标的单调性。关于 $m$ 的单调性在 $K=0$ 时由阶乘与幂因子得到；在 $K\geq1$ 时由式 (A19) 及 $m(R+1)\geq1$ 得到。对相邻机器数迭代即可得到一般单调性。

#### A.4.4 定理 2 的证明

对 $m+K$ 作强归纳。零长度路径由 $B(R,K,m)\geq1$ 立即满足结论。若 $m=1$，不存在两台不同机器，故路径只能有零步。若 $D=\varnothing$，也不存在合法转移。

现在设路径至少有一步。因此 $m\geq2,K\geq1$。取 $d=\max D$。由于路径有正转移量，$d>0$，所有步满足 $\delta\leq d$。对这一 $d$ 构造顶带与势。

若路径中从未出现满顶带，则全路径满足引理 9 的前缀条件，故

$$
\ell+1\leq m(R+1)B(R,K,m-1)\leq B(R,K,m).
$$

若存在满顶带，令 $b$ 为第一次满顶带的状态编号。前缀从状态 $0$ 到状态 $b$，其非末状态全为真顶带，所以

$$
b+1\leq m(R+1)B(R,K,m-1).
\tag{A20}
$$

从状态 $b$ 开始的后缀，根据引理 5 不再使用 $d$。由于 $d\in D$，新的候选集合 $D\setminus\{d\}$ 恰有 $K-1$ 个值，归纳假设给出

$$
\ell-b+1\leq B(R,K-1,m).
\tag{A21}
$$

前后缀只共享状态 $b$。把式 (A20) 与 (A21) 相加并减去这一重复状态，得到

$$
\ell+1
\leq m(R+1)B(R,K,m-1)+B(R,K-1,m)-1
\leq B(R,K,m),
$$

最后使用式 (A19)。两个归纳分支分别减少机器数或候选值数量，均严格减少 $m+K$。整个证明直接为任意给定路径建立数值界，不依赖于事先存在跨所有实数负载实例的最大路径长度。定理 2 得证。

### A.5 从实际作业到抽象整数质量

#### A.5.1 对相同处理时间安全的作业秩

定义

$$
r(j)=1+|\{k\in J:p_k<p_j\}|.
\tag{A22}
$$

这里不人为打破处理时间相等的并列。对每个作业有

$$
1\leq r(j)\leq n,
\qquad
\sum_{j\in J}r(j)\leq n^2.
\tag{A23}
$$

若 $p_u<p_v$，则 $\{k:p_k<p_u\}\subsetneq\{k:p_k<p_v\}$：前者包含于后者，而作业 $u$ 属于后者、不属于前者。因此

$$
p_u<p_v\Longrightarrow r(u)<r(v).
\tag{A24}
$$

把机器整数质量定义为

$$
\mu_i(\sigma)=\sum_{j:\sigma(j)=i}r(j).
\tag{A25}
$$

总质量与分配方式无关，并由式 (A23) 至多为 $R=n^2$。对于单作业迁移，质量转移量为 $r(u)\geq1$；两个作业同向迁移时为 $r(u)+r(v)\geq1$；交换较大与较小作业时为 $r(v)-r(u)\geq1$，正性由式 (A24) 保证。分别对两个受影响机器求和，即得到式 (A8) 的整数质量等式。该论证同时处理处理时间并列与多个临界机器。

#### A.5.2 不超过 $n^2$ 个候选正转移值

所有实际正转移量属于

$$
D_p=
\{p_u:u\in J\}
\cup\{p_u+p_v:u<v\}
\cup\{|p_u-p_v|:u<v,\ p_u\ne p_v\}.
\tag{A26}
$$

可以直接用恰有 $n^2$ 个有序槽位 $(u,v)\in J\times J$ 表示它：对角线槽位放单作业值 $p_u$，上三角槽位放 $p_u+p_v$，下三角槽位放相应绝对差；最后丢弃非正值并合并重复值。因此

$$
K=|D_p|\leq n^2.
\tag{A27}
$$

这个计数控制不同的数值，而非操作标签数。若多种操作产生相同转移量，集合计数只会减小。

#### A.5.3 调度路径主定理

**定理 10（任意正实处理时间的固定机器数界）。** 对任意 $n\geq1,m\geq1$、任意正实处理时间向量 $p$、任意满足原始二交换邻域与全局改善标准的有限路径，均有

$$
\ell+1
\leq m!\,(n^2+1)^{m-1}
\binom{|D_p|+m-1}{m-1}
\leq m!\,(n^2+1)^{m-1}
\binom{n^2+m-1}{m-1}.
\tag{A28}
$$

**证明。** 对每个实际调度构造其机器负载、最大负载以及式 (A25) 的整数质量。它满足式 (A6)，其中 $R=n^2$。引理 1 从原始全局改善推出式 (A7)。前述三类实际操作的负载和秩和计算给出式 (A8)，其正转移值属于 $D_p$。因此原始路径逐步映射成抽象路径，长度保持不变。应用定理 2 得第一个不等式，再由式 (A27) 及 $B$ 关于候选值数量的单调性得到第二个不等式。证毕。

式 (A28) 对任意正实处理时间成立，其参数没有出现数值幅度、最小正转移量或编码位数。对于固定 $m$，右端是关于 $n$ 的多项式表达式；其增长阶不超过 $n^{4(m-1)}$。该结论同时覆盖任意枢轴选择与所有等值情形。

指数 $4(m-1)$ 随机器数增长，阶乘和组合系数也携带机器数依赖。因此式 (A28) 不提供关于 $(n,m)$ 的统一多项式上界，亦不能排除机器数增长时存在超多项式长路径。


Since $n^2+1\le2n^2$ and $n^2+m-1\le mn^2$ for $n,m\ge1$, (A1) also implies $\ell+1\le m!(2m)^{m-1}n^{4(m-1)}$ by bounding each binomial coefficient by the corresponding power.

## Appendix B. Duration types and superincreasing processing times

If the vector of durations has $s$ distinct values with multiplicities $n_1,\ldots,n_s$, then every improving two-swap path satisfies
$$
\ell+1\le \min(m,n)\left[\prod_{j=1}^s(n_j+1)-1\right].
$$
The peak is the load on a nonempty machine. For each type a machine has a count between zero and $n_j$, so there are at most $\prod_j(n_j+1)-1$ peak values. The maximizing-machine count lies between 1 and $\min(m,n)$. Lexicographic strict improvement prevents reuse of an objective pair. Thus for a fixed number of types the bound is polynomial regardless of the machine count. In particular with two types it is $O(\min(m,n)n^2)$.

For the superincreasing result, order the jobs so that $p_j>\sum_{i<j}p_i$, and let job $n$ be the critical job. The companion sets are then ordered by the largest index in their symmetric difference. Since their load decreases, their two largest indices, padded by zeros, are nonincreasing in lexicographic order. There are $1+(n-1)+\binom{n-1}{2}$ possible pairs. Within a phase where this pair is unchanged, if both entries are nonzero the critical job cannot move. Both of the two named companions would have to follow it, requiring three moved jobs. If an entry is zero, the pair determines the companion load and no improving step can stay in that phase. Thus on each phase with an internal improving step the critical machine stays fixed. It loses one or two companions or trades a greater-index companion for a smaller one. The rank sum of companions drops by at least one and starts at most $n(n-1)/2$. Therefore
$$
\ell+1\le [1+(n-1)+\tbinom{n-1}{2}]\,[1+n(n-1)/2].
$$
The original $h^2$ witness for $n=2h+1$ uses durations $2^i$ and precisely the adjacent inversion swaps in Section 5. The present theorem gives a universal result for arbitrary companions under the weaker persistence hypothesis.

