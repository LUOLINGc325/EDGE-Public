---
title: "The pointwise extension frontier of the exchangeable arithmetic prefix rule"
fontsize: 11pt
geometry: margin=1.0in
abstract: |
  We characterize every three-coordinate observation that can be newly rejected by a deterministic monotone extension of the exchangeable arithmetic prefix rule under its orbit-wise mean certificate. The characterization uses labeled permutation counts and applies at repeated coordinates and equality boundaries. Individually feasible extensions can be incompatible, and no greatest certified monotone extension exists. Two explicit stronger augmentations remain valid at every length and along infinite exchangeable sequences. An exact super-uniform null shows that no valid merger can dominate both at three inputs. A separate orbit linear program certifies the worst null inflation of arbitrary monotone score rules with a uniform grid error.
---

## 1. Rules and main results

For a vector \(e=(e_1,\ldots,e_K)\) with nonnegative entries, the arithmetic prefix rule rejects if
\[
\sum_{i=1}^j e_i\ge j
\quad\text{for some }1\le j\le K .
\tag{1}
\]
A rejection set is coordinatewise monotone if it is upward closed. Its orbit certificate is the condition that, for every deterministic multiset of \(K\) inputs, the fraction of labeled permutations rejected is at most their mean. Repeated values are still distinct labels when counting permutations. This is the certificate used in the prior augmentation [1]. An extension contains all rejections of (1).

We first consider \(K=3\). Call a value high if it is at least one. A vector outside (1) has first coordinate below one and total less than three. The next theorem concerns whether each such point can be added individually by some monotone extension satisfying the certificate over all nonnegative vectors.

**Theorem 1 (individual extension frontier).** Let \(e\) be outside (1). Write \(x=e_1\). Then it can be added exactly under the condition in its row below.

| High coordinates and point form | Necessary and sufficient condition |
|---|---|
| No high coordinate | Impossible |
| Only the second is high, \((x,h,y)\), \(b=\max(x,y)\) | \(x+2h\ge3,\ h+2b\ge2\) |
| Only the third is high, \((x,y,h)\), \(b=\max(x,y)\) | \(x+2h\ge3,\ h+2b\ge3\) |
| Second and third are high, \((x,y,z)\) | \(x+y+z\ge5/2,\ x+2\max(y,z)\ge3\) |

When a point is individually feasible, its principal upper orthant together with the base rule is a certified monotone extension. The table describes individual feasibility. Simultaneous feasibility requires additional constraints.

**Theorem 2 (stronger augmentations and incompatibility).** Add the following condition to (1), tested on the first three coordinates:
\[
A:\quad e_2\ge1,\qquad e_1+2e_2\ge3,\qquad e_1+e_2+e_3\ge2.
\tag{2}
\]
One may also add either of the following alternatives:
\[
\begin{split}
B:\quad &e_3\ge1,\qquad e_1+e_3\ge2,\qquad 2e_2+e_3\ge3;\\
B':\quad &e_3\ge1,\qquad e_1+e_3\ge2,\qquad
2e_1+e_3\ge3,\qquad e_1+e_2+e_3\ge5/2 .
\end{split}
\tag{3}
\]
Each choice gives a certified monotone rule for every \(K\ge3\), and contains all rejections of the pinned augmentation [1]. There is no greatest certified monotone extension of the base at \(K=3\), even among those containing \(A\). The two rules yield valid exchangeable \(p\)-value mergers and an anytime rejection guarantee over an infinite exchangeable sequence.

## 2. Three-coordinate orbit accounting

The orbit certificate is automatic whenever the total is at least three. Below that total, count rejected permutations of three labels.

- With no highs, no permutation is rejected by (1).
- With two highs, the base rejects precisely the four permutations with a high first. In either remaining permutation the first two coordinates sum to less than two because the remaining value is at least one.
- With one high \(h\), the two permutations placing it first are rejected. A permutation placing \(h\) second is rejected precisely when \(h\) plus its first low value is at least two. No permutation placing \(h\) last is rejected. Thus the base count is \(2+J\), where \(J\) counts low labels with \(h+\text{low}\ge2\).

There is no three-high case below total three. The maximum allowed count is twice the total, since there are six labeled permutations and their mean is one third of that total. In particular the base rule has the certificate at length three. With one high and \(J=0\), the count two is paid by total at least one; when \(J=1\) or two the total is at least two. With two highs the total is at least two.

## 3. Proof of the individual frontier

If a monotone extension that rejects an additional point exists, it must contain the union of the base and that point's upper orthant. Conversely, if this union has the certificate, it is a witness. We therefore analyze only this smallest possible extension for a given point.

A point with no highs cannot be added. Raising all coordinates to their largest value gives a diagonal point still below one. Monotonicity would reject all labels there, exceeding the mean.

For two highs, write the point as \((x,y,z)\) with \(x<1\). If added, its orbit has at least five rejects, so the total must be at least \(5/2\). Write \(b=\max(y,z)\). Lifting the two highs to \(b\) makes the two low-first permutations identical as vectors. Both labels must be rejected. This forces \(x+2b\ge3\). Conversely, in any orbit below total three affected by the upper orthant, there must be two highs. A single additional reject has adequate total since it is coordinatewise above the candidate. Two additional rejects would require both high values at least \(b\) and the low at least \(x\), forcing total at least three. This proves the last row.

Now consider either form with one high \(h\), other coordinates \(x,y<1\), and \(b=\max(x,y)\). Lifting to \((x,h,h)\) would reject both low-first labels along with the base, so \(x+2h\ge3\) is necessary. This also implies
\[
x+h\ge 3/2 .
\tag{4}
\]
For a second-position high, if \(h+2b<2\), the lifted orbit \((b,h,b)\) would have both high-second labels newly rejected, plus the two high-first labels, giving count four with total below two. Thus \(h+2b\ge2\). For a third-position high, suppose \(h+2b<3\) and put \(h'=\max(h,2-b)\). The lifted orbit \((b,b,h')\) has total \(\max(h+2b,2+b)<3\). It has four base rejects since \(b+h'\ge2\), and both high-last labels would be added. This violates the certificate. Therefore \(h+2b\ge3\) is necessary in this case.

To check sufficiency, first consider an affected two-high orbit below total three. Any new reject has low at least \(x\), one high at least \(h\), and the other high at least one. Its total is at least \(5/2\) by (4). Two new low-first labels would require both highs at least \(h\), forcing total at least \(x+2h\ge3\). Thus this kind of orbit always has enough budget.

In an affected one-high orbit, if the orthant requires a second-position high, any new rejects fill only high-second positions. A single addition with \(J=0\) needs total at least \(3/2\), supplied by (4). A single addition with \(J=1\) needs total at least two, which follows from the already successful high-second pair. For \(J=2\) there is nothing to add. Two additions would require each low value at least \(b\), so the total is at least \(h+2b\ge2\), enough for the four rejects.

If the orthant requires a third-position high, two additions would require each low at least \(b\) and hence total at least three. A single addition needs total at least \(3/2,2,5/2\) for \(J=0,1,2\), respectively. The first two follow as above. When \(J=2\) and \(b\ge1/2\), both high–low sums are at least two, so the total is at least two plus the larger low, hence at least \(5/2\). When \(J=2\) and \(b<1/2\), the high is at least \(h\ge3-2b\) and the low sum is at least \(b\), giving total greater than \(5/2\). No no-high orbit can be newly rejected by an orthant with a high constraint. This exhausts the cases and proves the table.

## 4. Jointly valid augmentations

At total below three, \(A\) adds only a low-first label having a high second. In a two-high orbit at most one new label is admitted. Otherwise both highs satisfy \(x+2h_i\ge3\) and their total with \(x\) is at least three. When one is admitted, the total is at least \(5/2\) by (4) and the other high. In a one-high orbit \(A\) can only add high-second labels, making the total reject count at most four, and it explicitly requires total at least two. It adds nothing when there are no highs.

Each of \(B,B'\) adds nothing new in two-high orbits below total three. For a new reject at low-first with \(e_3\) high and \(e_2\) also high, \(e_1+e_3\ge2\) forces total at least three. In a one-high orbit these conditions only add a high-last label. Each can add at most one below total three: both labels would imply that the high plus twice the smaller low is at least three. Any new reject from \(B\) has total at least \(5/2\). From \(e_1+e_3\ge2\) this follows if \(e_2\ge1/2\), and otherwise \(2e_2+e_3\ge3\) gives an even larger total. For \(B'\) it is explicit. Since the base together with \(A\) has at most four rejects in a one-high orbit, adding either \(B\) or \(B'\) respects the budget.

The pinned augmentation requires \(e_3\ge1\), \(e_1+2e_2\ge3\), and total at least \(5/2\). If \(e_1\ge1\) the base already rejects. Otherwise its second value exceeds one and it satisfies \(A\). The example \((2/5,7/5,2/5)\) satisfies \(A\) with strict margins while both pinned rules fail. This proves strict improvement on an open set.

For incompatibility use the one-high orbit with lows \(11/20,4/5\) and high \(3/2\). The base already rejects four labels. Condition \(B\) adds the high-last label with \(11/20\) first and \(4/5\) second; \(B'\) adds its reversal. The union rejects all six labels at total \(57/20<3\). A certified monotone rule containing both would violate the orbit certificate. Since each contains \(A\), no greatest rule exists even in the stated smaller family.

## 5. Arbitrary lengths and exchangeable p-values

At length \(K>3\), use all original prefix tests and apply the chosen augmentations on the first three inputs. At total at least \(K\), the mean bound is automatic. Otherwise the final prefix cannot reject, so the rule is the one on the first \(K-1\) positions. A uniform labeled permutation can be generated by choosing its last label uniformly and permuting the others. By induction, conditional on that label the rejection probability is at most the mean of the remaining values. Averaging gives the full mean. This proves the certificate at every length. At lengths one and two use the base (1). For one input the certificate is immediate. For two inputs with total below two, there is at most one high value and only its first-position label can reject. If such a label exists the total is at least one, which pays its probability \(1/2\).

For \(\alpha\in(0,1)\) and valid marginal \(p\)-values, use
\[
e_i(\alpha)=2(1-p_i/\alpha)_+ .
\]
For \(0<u<2\), marginal super-uniformity gives
\(\mathbb P(e_i>u)\le\alpha(1-u/2)\). Integrating over \(u\) yields \(\mathbb E e_i\le\alpha\). By exchangeability one may average the deterministic orbit certificate over the random inputs, giving rejection probability at most \(\alpha\). Taking the infimum of rejecting \(\alpha\), clipped at one, defines a valid merger. For positive \(p_i\), the rules are continuous inequality tests in \(\alpha>0\), monotone in \(\alpha\), and do not reject at arbitrarily small levels for finite \(K\). Thus the merger's event at any \(\alpha<1\) agrees with the rejection rule. If an input is zero, assign output zero; valid marginal \(p\)-values have no mass there. The strict example translates to positive \(p_i\) by choosing any fixed \(0<\alpha_0<1\), setting \(p_i=\alpha_0(1-e_i/2)\) for its first triple, and using later \(p_i>\alpha_0\). Its strict margins give an open set of improvement for each \(K\ge3\). For the exact example \(p=(2/5,3/20,2/5,1,\ldots,1)\), the pinned merger is \(11/20\), triggered by the first two inputs. Either new merger is \(19/40\), triggered by the total threshold in \(A\). Indeed at levels below \(2/5\) the first and third scores are zero, and \(A\) cannot pass the total threshold. From \(2/5\) upward the three-score sum is \(6-19/(10\alpha)\), equaling two first at \(19/40\). The other \(A\) thresholds already hold there, and neither high-last augmentation can trigger below \(4/5\).

On an infinite exchangeable sequence these rejection events are nested in \(K\), since the rule always retains earlier prefixes and its initial augmentation. By continuity from below their union has probability at most \(\alpha\). The impossibility of a greatest extension was proved for the deterministic coordinatewise monotone orbit-certificate class. It does not characterize every valid merger under the marginal \(p\)-value constraints.


## 6. Pairwise compatibility and more coordinates

In three coordinates, the individual frontier extends to a criterion for arbitrary families of generators. Let \(\mathcal P\) be any set of individually feasible additional points from Theorem 1. Join their principal upper orthants to the base rule. The union is certified if and only if the union for **every pair** of points in \(\mathcal P\) is certified. The necessity is monotonicity under taking subsets. To prove sufficiency, consider an over-budget orbit for the full union. If its new rejected labels number at most two, one or two generators already witness the failure. Thus it suffices to consider the possibility of three new labels.

Below total three, a two-high orbit has only two remaining labels. A one-high orbit with \(J=2\) also has only two. With \(J=0\), the high \(h\) and largest low \(b\) have \(h+b<2\), so \(h+2b<4-h\le3\). No high-last point is individually feasible by Theorem 1, leaving at most two high-second labels. The remaining case is \(J=1\). Three new labels must include the high-second label with the failing first low \(a\), satisfying \(a+h<2\), and both high-last labels. Let \(b\) be the other low. In particular two generators cover \((a,h,b)\) and \((a,b,h)\). Their orthants also cover \((a,h,1)\) and \((a,1,h)\), respectively. These belong to a two-high orbit of total \(a+h+1<3\) with four base rejects. The two additional rejects violate the budget, a pairwise contradiction. This argument also works for an infinite family of generators because each witness orbit has finitely many labels. Every monotone augmentation is the union of the principal orthants of its extra points.

The failure of a greatest certified extension is not confined to this pairwise characterization. For every fixed \(K\ge3\), write \(n=K-1\). For each \(j\in\{2,\ldots,K\}\), augment the base rule by the upward condition that all coordinates after the first are at least one and \(e_j\ge1+1/n\). In an affected orbit of total below \(K\), there is a unique low. The base rejects exactly the fraction \(n/K\) with a high first. Indeed, with a low first, the cumulative deficit cannot close because all subsequent contributions \(e_i-1\) are nonnegative and their full sum remains negative. If \(t\) of the highs meet \(1+1/n\), the condition adds fraction \(t/(Kn)\). The total is at least \(n+t/n\), which pays this additional fraction. Hence each augmentation is certified. On the orbit \((0,1+1/n,1,\ldots,1)\) a single augmentation exhausts the budget, and two different positions add disjoint sets of labels. Their union violates the certificate. This claim concerns each fixed count in the orbit-certificate class.

## 7. A finite-grid certificate for actual null size

We now use the full super-uniform marginal constraints. The following result applies to any fixed \(K\) and any Borel coordinatewise increasing score rule \(R:[0,2]^K\to\{0,1\}\) with \(R(0,\ldots,0)=0\). It need not obey the orbit certificate. Define its null inflation as
\[
L_R=\sup_{0<\alpha<1}\ \sup_{\text{exchangeable valid }p}
\frac{\mathbb P(R(e(\alpha))=1)}{\alpha}.
\tag{4}
\]
For \(K\ge2\), this is the same supremum over nulls at each fixed \(0<\alpha\le1/K\). For every positive integer \(m\) a finite rational linear program has value \(L_{R,m}\) satisfying
\[
0\le L_R-L_{R,m}\le K/m.
\tag{5}
\]
The program uses marginal threshold constraints and actual orbit rejection fractions.

### 7.1. The normalized orbit problem

An active coordinate is represented by \(u=p/\alpha\in[0,1)\) and has score \(2(1-u)\). An inactive coordinate is denoted by \(*\), with score zero. For an unordered tuple \(o\) of these symbols, write \(r_R(o)\) for the fraction of its labeled permutations rejected. Represent an exchangeable null by its multiset distribution and uniform permutations conditional on that multiset. Remove the all-inactive orbit, which contributes zero, and divide the remaining orbit measure by \(\alpha\). For any \(t<1\), the marginal active CDF of this normalized measure satisfies
\[
F(t)=\int \frac{\#\{i:u_i\text{ active},\ u_i\le t\}}{K}\,d\nu(o)
\le t.
\tag{6}
\]
Its objective \(\int r_R\,d\nu\) is the ratio in (4). The mass of a measure \(\nu\) satisfying (6), supported on tuples with at least one active coordinate, is at most \(K\), since each tuple contributes at least \(1/K\) to \(F(1-)\le1\).

Conversely, for any such nonnegative measure \(\nu\), choose an orbit with subprobability measure \(\alpha\nu\), permute it uniformly, set each active \(p_i=\alpha u_i\), and make inactive \(p_i=1\). Fill unused probability with the all-ones vector. For \(0<\alpha\le1/K\) the construction is normalized. Below \(\alpha\) each marginal obeys (6) after scaling. From \(\alpha\) to levels below one its CDF is at most \(\alpha\) since \(F(1-)\le1\). Thus these are valid marginal \(p\)-values. This proves the equivalence at small levels and the upper bound at every level. In particular the rule inverts to a valid merger exactly when \(L_R\le1\). For sufficiency, if the infimum of rejecting levels is at most \(\alpha<1\), monotonicity ensures rejection at every larger level \(\beta>\alpha\), even if the first rejecting level is open. Apply the bound at \(\beta\) and send \(\beta\downarrow\alpha\). For necessity, a rejection at a level always puts the infimum at or below that level.

### 7.2. Grid and rounding repair

Take grid \(u_j=j/m\), \(0\le j<m\), besides the inactive symbol. Let \(\mathcal O_m\) be the finite set of its unordered tuples with at least one active coordinate. The LP is
\[
\begin{split}
\text{maximize }&\sum_{o\in\mathcal O_m} r_R(o)w_o,\\
\text{subject to }&
\sum_{o\in\mathcal O_m}\frac{\#\{i:u_i\le u_j,\ u_i\text{ active}\}}{K}\, w_o
\le u_j\quad(0\le j<m),\qquad w_o\ge0 .
\end{split}
\tag{7}
\]
Its coefficients are rational, including each rejection fraction. The dual consists of nonnegative weights on threshold constraints whose orbit-weighted sum majorizes \(r_R(o)\) for every grid orbit. The LP has \(m\) threshold constraints and at most \(\binom{m+K}{K}\) variables. Its primal measures are feasible in (6) since their CDFs are constant between thresholds.

To approximate a general feasible measure, round each active \(u\) down to the nearest \(u_j\). This increases the scores, so the objective cannot decrease. Its rounded marginal CDF at \(u_j\) is at most \((j+1)/m\). The CDF bound at zero is repaired by the same procedure as the positive thresholds. Take the lowest \(1/m\) of the rounded active marginal mass, or all of it if smaller. This is a submeasure \(\mu_{\mathrm{low}}\), allowing a split at its last atom. Independently mark a coordinate at a rounded active value with probability equal to the fraction of that atom in \(\mu_{\mathrm{low}}\). Remove an entire tuple if any coordinate is marked. This preserves permutation symmetry. The retained marginal removes at least \(\mu_{\mathrm{low}}\), since a marked coordinate always disappears. Thus its CDF at \(u_j\) is at most the positive part of the original rounded CDF minus \(1/m\), hence at most \(u_j\). The mass of discarded tuples is at most \(K/m\) by the union bound for these marks under the normalized orbit measure. The objective loss is also at most \(K/m\), since \(0\le r_R\le1\). Taking suprema proves (5), without requiring any continuity of the score rule.

## 8. Incompatibility under the actual p-value null

Use the two valid mergers from Section 5 at \(K=3\). We show that **no valid exchangeable merger can pointwise dominate both**, even if its validity argument has no orbit certificate. At \(\alpha=1/4\), take the following score orbits. The row lists \(12e\) and a numerator for its mass in units \(1/352\).

| \(12e\) | Mass numerator | \(12e\) | Mass numerator |
|---|---:|---|---:|
| \((0,12,18)\) | 2 | \((5,10,19)\) | 4 |
| \((0,15,21)\) | 11 | \((5,11,19)\) | 2 |
| \((0,17,19)\) | 1 | \((5,13,18)\) | 2 |
| \((1,9,23)\) | 11 | \((5,14,17)\) | 3 |
| \((2,7,22)\) | 11 | \((6,9,18)\) | 7 |
| \((3,14,19)\) | 4 | \((6,14,16)\) | 4 |
| \((3,16,17)\) | 7 | \((11,12,13)\) | 9 |
| \((4,8,20)\) | 11 | | |

For each row, permute the three labels uniformly. Map a positive entry \(a\) of \(12e\) to \(p=(24-a)/96\) and an entry zero to \(p=1\). Assign all remaining mass to \((1,1,1)\). The row numerators sum to \(89\), so this is a probability law. For each integer \(0\le j\le23\), the marginal probability at threshold \(j/96\) is
\[
\frac{1}{3\cdot352}
\sum_{\text{rows }o} n_o\,\#\{a\in o:a>0,\ 24-a\le j\}.
\tag{8}
\]
The integer sum is \(11j\) except at \(j=14\), where it is \(147<154\). The initial value is zero. Since \(11/(3\cdot352)=1/96\), these CDF values are at most their thresholds. Between grid values there is no new support until one, which proves marginal super-uniformity.

Using (1)–(3), the union of the two augmented rules rejects all six labels on every listed orbit except \((0,12,18)\), where it rejects five. These counts can also be read by applying the integer threshold tests to the six permutations of each row. The resulting probability is
\[
\frac{89-2/6}{352}=\frac{133}{528}>\frac14 .
\]
A pointwise dominating merger would reject on this union, contradicting validity. In particular the class of valid mergers that dominate the pinned rule has no greatest improvement at three inputs. This conclusion uses the full \(p\)-value null, beyond the sufficient mean certificate.

## 9. Provenance

The pinned work [1] adds one three-coordinate condition to the exchangeable arithmetic prefix rule and characterizes the extendable two-high multisets. It credits the arithmetic prefix construction to Gasparin, Wang, and Ramdas. Here all individual three-coordinate configurations and their pairwise composition are resolved. The new rules have no common valid dominator even under the full marginal null. The normalized orbit program gives a uniform grid guarantee for arbitrary score rules in the stated class.

**Reference**

1. *Strict improvement of the exchangeable arithmetic merging rule*, earlier research manuscript, fixed commit c9a8cf037cd4. The source manifest gives its exact path and blob.
