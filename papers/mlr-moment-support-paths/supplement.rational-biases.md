# Rational exceptional biases in the eight-moment binomial problem

For a binomial count on $0,\ldots,n$, maximize the mass at $n$ over laws with the same moments through order $k$. An exceptional bias is an interior boundary of two open phases at which their optimal bases exchange at least two nodes. Berend, Ernst, Kontorovich and Kumar formulate the rationality question in Conjecture 5.9. The proof below settles order eight for every admissible $n$. Its analytic bounds reduce the problem to a finite exact arithmetic check. [Published conjecture](https://doi.org/10.1007/s10959-026-01487-4)

## Reading guide

Within each open phase, the optimal law has a fixed set of nodes and changing weights. A boundary at which several nodes leave is special because several weights become zero together. Section 1 turns that shared zero into a multiplicity condition on a rational polynomial. In the eight-moment problem, the only possible irrational bias would force a cubic square. Sections 2 and 3 show that the six remaining nodes must lie close enough to the binomial mass to have bounded integer coordinates. Sections 4 and 5 restrict the possible grid sizes and rule out every remaining square by exact computation. The result is a computer-assisted proof at fixed order eight.

## 1. Reduction to a square

Use the paired-basis description and uniqueness of the optimum in [Berend–Ernst–Kontorovich–Kumar, §3.2 and §5.3](https://arxiv.org/html/2407.18688). Each open interval of biases uses a basis consisting of n and four disjoint adjacent pairs in 0,…,n−1. Let p be an exceptional point, let N=n−1, and let z denote the number of zero paired-basis weights at p in the basis on the left. At least two nodes depart, so z≥2. Indeed, neighboring optimal laws agree at p by continuity of the basis formulas and uniqueness there, so each departing weight is zero.

If W is the optimum law for the number of ones, the tilted law proportional to (n−W) matches Bin(N,p) in moments through degree 7. Its total normalizing factor is n(1−p)>0. This follows by applying degree≤8 moment matching to (n−W) times a polynomial of degree≤7, and the corresponding binomial identity. The tilt preserves positivity of weights for nodes other than n.

Only left endpoints of the four adjacent pairs can have zero weight as the left interval ends. Indeed, the Lagrange cardinal polynomial for a paired node has as numerator (x−its partner) times the three other paired factors. The latter product is nonnegative on the integer grid. The binomial mean of x under this extra nonnegative weight is strictly increasing in the odds p/(1−p), by differentiation (variance), when its support has at least two points. The cardinal denominator is negative for a left endpoint and positive for a right endpoint. Thus at an interior root, left-node weight passes from positive to negative while right-node weight passes the other way. If the extra weight has only one support point, the sign is fixed or the weight is identically zero, so it cannot be positive on the left and vanish only at the boundary. The left basis here has positive interior weights.

Write Q(x) for the monic polynomial with the k−z surviving nodes. It is a product of intact adjacent-pair factors and z singleton factors. Let F(q)=E[Q(X)] for X∼Bin(N,q). At q=p the zero of F has multiplicity at least z: Q times every polynomial of degree less than z has degree≤7 and vanishes on the tilted law's support. Differentiating the binomial expectation in odds gives the asserted multiplicity. The odds polynomial (1+t)^N F(t/(1+t)) has coefficients binom(N,i)Q(i); intact pairs are nonnegative on the grid, so these coefficients have at most z sign changes. Descartes' rule shows p is the only root in (0,1), with multiplicity z.

At q < 0, write Q=Σc_j(x)_j in the falling-factorial basis. Its coefficients alternate weakly, by adding the sorted nonnegative integer roots r and using (x−r)(x)_j=(x)_(j+1)+(j−r)(x)_j. Therefore F(q)=Σc_j(N)_j q^j has no negative root. Reflection gives no root above 1. The minimal polynomial of p over Q has exactly one real root: any conjugate outside (0,1) cannot be a root of F, with q=0,1 rational. Its degree d is odd, and zd≤8−z. For an irrational p this forces d=3 and z=2. Equality leaves no room for endpoint zeros of F, so endpoints 0 and N are not surviving nodes. The only candidates thus have six distinct interior nodes, consisting of two intact adjacent pairs and two singletons, a positive law matching moments through degree 7 on them, and F a scalar times a monic rational cubic square. Reflection x↦N−x allows us to take p≤1/2. No use is made of the stronger assertion that every switch is a simultaneous unit shift.

For n≤8 there is no exceptional transition of the relevant kind. For n=9 any two paired bases of size 9 on 10 grid points change at most one node.

## 2. Universal standard-deviation bound

Set μ=Np, σ²=Np(1−p), and let Y=(X−μ)/σ at the genuine bias p. Let a,b be the two standardized pair midpoints and r,s the singleton sites. Put τ=1/(2σ), T=(y−a)(y−b)(y−r)(y−s), and

    B(y)=[(y−a)^2−τ²][(y−b)^2−τ²](y−r)^2(y−s)^2.

B is nonnegative on the grid and zero on the six-node law. Write K_j for monic standardized Krawtchouk polynomials, H_j for probabilists' Hermite polynomials, and use binomial L² norms. Exactness to degree seven gives E B≤||K4||²≤24, by subtracting K4² from the monic degree-eight B. Expanding B then gives

    ||T||² ≤ ||K4||² + τ² (||T/(y−a)||²+||T/(y−b)||²).

The monic recurrence is K_{j+1}=(y−jc)K_j−j(1−(j−1)/N)K_{j−1}, where c=(1−2p)/σ. For completeness, these coefficients follow by orthogonalizing the sums over j distinct centered Bernoulli factors: their squared monic norms before standardization are j!(N)_j[p(1−p)]^j, and the diagonal coefficient after standardization is jc. The latter comes from the centered Bernoulli relation (B_i−p)^2=(1−2p)(B_i−p)+p(1−p), counting the j selected sites.

For deg P≤3 the Gaussian multiplication map satisfies ||(y−u)P||≥(2/3)||P|| for every real u. A direct certificate applies Sylvester's criterion to the Gram matrix of multiplication by (y−u)^2−4/9 in the monic Hermite basis through degree 3. Its four leading minors in w=u² are:

    w+5/9
    w²−8w/9+115/81
    2w³−26w²/3+374w/27+1978/729
    12w⁴−352w³/3+3368w²/9−64960w/243+149812/2187.

The Sturm sign lists at zero and +∞ are, respectively, (++/++), (+−−/++−), (++−−/++−−), and (+−+++/+++−+); all minors are positive at zero and have no positive root. Comparing the two rectangular orthonormal multiplication matrices changes the norm by at most 3/σ+12/N (diagonal and two shifted diagonals). For σ≥50 this leaves a lower norm bound .6. Consequently ||T−K4|| < 6/σ, by the preceding B inequality and orthogonality.

We now suppose σ≥50. Rouché gives one root of T within .15 of each root of H4. Here is a numerical certificate with slack. Put t=1/N. The exact difference K4−H4 is

    c(−6y³+14y)+(11c²+8t)y²−(6c³+12ct)y−6c²−6t.

The bounds ||K2−H2||₁≤1/σ and ||K3−H3||₁≤6/σ follow from the recurrence. For normalized K0,…,K3 at inner circles, use |y|≤.892, |H2(root)|≤.45, |H3(root)|≤1.819, and the derivative bounds on each .15 disk. Cauchy–Schwarz with ||T−K4|| gives |T−K4| < 11/σ. The linear c part above is < 12.2/σ and the rest < 18/σ². On the two outer circles |y|≤2.485 and the corresponding Hermite values are < 4.45,5.72; this gives |T−K4| < 36.3/σ, linear error < 63/σ and remainder < 89/σ². The lower H4 moduli on the inner and outer circles are respectively >.775 and >2.44, from root derivatives >7.26 and >22.86 and mutual distances >1.4. The error bounds are < .472 and < 2.03, respectively.

Write q₂=(y−a)(y−b)=y²−Sy+P, where S=a+b and P=ab in this subsection only. We have |S| < 3.38, |P+5|≤7.22. In a mixed pair (one inner, one outer root) |P| < 2.22; if the signs agree then |S|>2.776, while if they differ then 1.292 < |S| < 1.893 and −2.22 < P < −1.29. For opposite matching roots of equal magnitude, |S|≤.3 and |P−P_ref| < 1.23 is valid but we use the sharper .723 for outer and .246 for inner, with P_ref=−3±√6.

Use the expectation operator ℬ on standardized y at bias q=p+σx/N. Let L_i=∏_{j=1}^i(1−jt), λ=L5. The exact coefficients [x^i]ℬ(K_j q₂) for j=0,…,4 are the rows below:

    i=2: L1, (−S+3c)L1, (P+5−2Sc+4c²−8t)L1, 3(−S+5c)L2, 12L3
    i=3: 0, L2, (−S+5c)L2, (P+7−3Sc+9c²−18t)L2, 4(−S+7c)L3
    i=4: 0, 0, L3, (−S+7c)L3, (P+9−4Sc+16c²−32t)L3
    i=5: 0, 0, 0, L4, (−S+9c)L4.

These are polynomial identities: take cumulants κ1=x, κ2=1+cx−tx², κ_{j+1}=κ2·dκ_j/dx for j≥2; raw moments obey m_j=Σ_i binom(j−1,i−1)κ_i m_{j−i}, m0=1. Transfer K_j q₂ by replacing y^i by m_i.

The true standardized six-node polynomial Qstd differs from Tq₂ by

    −τ²[((y−a)^2+(y−b)^2)(y−r)(y−s)] + τ⁴(y−r)(y−s).

Its raw corrections at degrees 2,3,4,5 are bounded by (16,3.5,.5,0)/σ². To verify: its ordinary coefficients in degrees 4,3,2 are bounded by 2τ²,13.52τ²,47.6τ²+τ⁴; transfer of y²,y³,y⁴ on output degrees 2,3,4 has rows (L1,0,0), (3cL1,L2,0), ((6+7c²−8t)L1,6cL2,L3).

Write T−K4=Σ_{j=0}^3 a_j K_j, with Σ||K_j||² a_j² < 36/σ². Norm squares are at least 1,1,1.9998,5.9982 for j=0,…,3. Let f_i be raw coefficients of ℬ(Qstd); its leading coefficient is λ≥.9985. Since F has a double root at p, the monic polynomial obtained by replacing q by p+σx/N is divisible by x². If it is a square, the quotient is (x²+u x+v)². Row 2, weighted Cauchy–Schwarz, and the half-step correction give |f2/λ−12| < .96: row error < .915, half-step < .0064, baseline drift < .0072 and normalization cost in numerator ≤.018. Thus 3.32 < |v| < 3.60.

In the mixed pair case use exact equality f3−v f5=0. The leading combination is [(v−4)S+(28−9v)c]L3, plus v(S−9c)(L4−L3). The remaining a1,a2,a3 coefficients are L2, (−S+5c)L2, and (P+7−3Sc+9c²−18t)L2−v L4. For positive v and opposite signs of the two mixed roots, these absolute coefficients are at most 1,1.993,2.52, weighted perturbation < .243, skew bound .088, base discrepancy < .0031, half-step < .0014. The total < .34 is smaller than |(v−4)S L3|>.516. For positive v and same-sign mixed roots, the bounds are 1,3.48,6.12, weighted perturbation < .44, skew .088, remaining < .008; total < .54 is smaller than the required >1.1. For negative v in either mixed case the coefficient bound 13.1 for a3, skew ≤1.208, and the same estimates give total < 1.95 vs required >9.4. In the equal-magnitude opposite-root case, rows 4 and 5 give |f4/λ−(9+P)| < .15 and |f5/λ+S| < .231, hence |u| < .266 and v within (.15+.071+|P−P_ref|)/2 of 3±√6/2. The outer interval is below 2.25 and the inner interval above 3.99, both positive. Contradiction in every case. We have proved σ < 50.

## 3. Bounds on the integer nodes and their sum

For σ≥8 we use a companion midpoint bound. In the orthonormal Krawtchouk basis let D lower e_j to a_j e_{j−1}, where a_j²=j(1−(j−1)/N). Then [D,Y]e_j=(1−2j/N)e_j+cDe_j. For deg≤3, the quadratic form of this commutator is at least (1−6/N−√3/σ)||P||² and bounded in absolute value by (2+√3)||(Y−u)P||||P||, by moving the adjoint and using the norms of D and D*. Thus ||(Y−u)P||≥||P||/5. The B inequality gives ||T−K4|| < 20/σ. Conversion to coefficient one-norm (the first four normalized polynomial norms are each < 5) and the recurrence give ||T−H4||₁ < 250/σ. Cauchy's bound puts all four standardized centers in |y| < 43, or in |y| < 20 when σ≥20. The sum of the four unstandardized centers is ≤4μ+14.4: the x³ coefficient of T−K4 has magnitude < 8.4/σ, while the sum for monic K4 is 6c in standardized units. Adding the two pair centers again gives a bound on the sum S_* of all six integer nodes:
    
    S_* < 6μ+2015   (8≤σ < 50).

For σ < 8, work with unstandardized centers and unstandardized B. Then EB≤24σ⁸. If N < 256 the bounds below are immediate. Otherwise 1≤μ < 128, and take a binomial mode m=floor((N+1)p). Its mass is ≥1/50 by Chebyshev within 2σ. Use a seven-point arithmetic progression of step h and minimum mass β:

* For μ≥4 and σ < 5, take m−3,…,m+3, h=1, β≥1/200. For 4≤μ < 8, mode mass is ≥1/16, forward steps each retain ≥1/2 and backward three-step factor is ≥(1+4/128)^−3 (3·2·1)/4³>.085. For μ≥8 use mode mass 1/50, forward steps ≥2/3 and backward factor ≥(1+4/128)^−3 (7·6·5)/8³>.37.
* For 5≤σ < 8, μ≥25, take m−6,m−4,…,m+6 with h=2 and β≥1/200. Right mass ratio is ≥(1−5.5/128)^6∏_{j=1}^6 25/(25+j+.5)>.31; left ratio is ≥(1+7/128)^−6∏_{j=1}^6 (25−j)/25>.28.
* If μ < 4, take m,…,m+6. With h=1 the mass minimum is ≥(1/50)(1−9/256)^6 μ⁶/∏_{j=1}^6(μ+j+.5). These estimates follow by multiplying the exact adjacent binomial probability ratios; masses are monotone away from a mode.

Remove one quadratic block from B to form a monic nonnegative degree-six polynomial C. On the seven sites, the sixth finite difference is 720h⁶, so ΣC≥48h⁶ (the largest positive weight is 15). The distance d of the removed center from the window thus obeys d²−1/4≤σ⁸/(2βh⁶). The three cases above give d < 6251, 5121 or 2700 respectively; even including the window's location and shifts of .5, all six nodes are < 6400. Remove two quadratic blocks instead: the remaining monic nonnegative degree-four polynomial has sum ≥4h⁴ by its fourth finite difference on five sites. This gives (d²−.25)²≤6σ⁸/(βh⁴) if both removed centers have distance at least d. The same three cases prove that at most one center is farther than 190 from the window. Consequently at least three centers have actual nodes < 325, so S_* < 2·6400+4·325=14100 even if the distant block is a pair.

The node bound < 6400 holds globally: for σ≥8, use μ≤2σ² and the center bound < 43 for σ < 20 and < 20 for σ≥20; for σ < 8 we just proved it. The first sieve may use the weaker cap 7200. Since μ≤5000, and μ≤2500N/(N−5000) for N>5000, a convenient integer upper bound for S_* is B_N=32020 for N < 10000 and otherwise

    B_N=min(32020,max(14110,ceil(15000N/(N−5000))+2015)).

## 4. Finite restriction and arithmetic sieve

Let u=N−5=n−6, L=(N)_6 and F=C G² with C a positive integer and G a primitive integer cubic, leading coefficient g3. This representation follows by clearing the denominators of the monic rational square and applying Gauss's lemma. Its next coefficient g2 satisfies 2u g2=g3 c5, where c5=15−S_*. Hence (u+1)…(u+5)c5²=4 C u g2², and u divides 60c5². To verify the constant 60: a prime ≥7 of u divides none of the next five factors. For ℓ∈{2,3,5}, if vℓ(u)>max_{1≤i≤5}vℓ(i), the valuation of the next-five product is vℓ(120); otherwise use vℓ(u)≤2,1,1 respectively. Subtract vℓ(4) in the first case. This establishes the stated divisibility. Six distinct positive integers have S_*≥21, so c5≠0. Generate all divisors u≥4 of 60d² for 6≤d≤32020. This exhausts every possible size and does not extrapolate from bounded sample behavior.

For ℓ≥7 dividing N−r to exponent e, put vℓ(C)=w and vℓ(g3)=h, so e=w+2h. Every coefficient f_j=(N)_j c_j with j>r is divisible by ℓ^e. The square coefficient at j=5 forces vℓ(g2)≥h when r≤4; the coefficient at j=4 then forces vℓ(g1)≥h if r≤3; j=3 forces vℓ(g0)≥h if r≤2. Primitivity gives h=0 in the latter case. Therefore all ℓ≥7 factors of N,N−1,N−2 divide Q(0) to their full valuation, and each such prime must be at most the node cap. Write M_r for the part of N−r supported on primes ≥7, R_r for its product of primes ≥7 of odd valuation, and A_r for the product of ℓ^ceil(vℓ(N−r)/2) over ℓ≥7. Odd e forces w≥1, so D=M0 M1 M2 R3 R4 R5 divides Q(0). Also A3 A4 R5 divides c3, and A4 R5 divides c4, from the square coefficients at j=3,4 and their unit falling factors on the corresponding offsets. The prime supports of these six offsets are disjoint above 5. Falling coefficients strictly alternate since the nodes are positive integers; ordinary coefficient comparison gives c4=e2−85+10c5 and c3=−e3+225−35c5+6c4 for elementary symmetric sums e_j of the nodes. Thus 0 < c4 < e2≤15(S_*/6)² and 0 < −c3 < e3≤20(S_*/6)³. Also 0 < Q(0)≤(S_*/6)^6. These integer inequalities are the filters in sieve.cpp. Factoring is exact; the Miller–Rabin bases used suffice in the full enumerated range [Jaeschke, 1993](https://cr.yp.to/bib/1993/jaeschke.pdf).

## 5. Exact verification, independently widened

The first program produces 1,020,345 distinct divisors and 16,668 candidate sizes (largest 465130). The verification deliberately uses all 16,668: it does not rely on specialized prime-offset or small-cofactor lemmas used in an earlier narrower 4,019-size run.

For each size choose two distinct primes from 79,83,89,97,101,103,107,109 not dividing L. Any rational monic square reduces to a monic square at each such prime: its cubic coefficients are recursively determined by the coefficients of degrees 5,4,3, requiring only division by units. Enumerate the starts of two pairs and the two singletons modulo each prime, allowing repeated residues. Their lower three coefficient identities filter the local lists. Specifically, given c5,c4,c3 and N mod prime, precompute the unique c2 from the square identity, then test c1 and c0. This is an indexing optimization, not an additional assumption. Chinese remaindering of each pair of local lists covers all four integer coordinates; their possible interchange is explicitly checked. The product of the two primes exceeds 6400, so every admissible coordinate has at most one lift per correspondence. Test distinctness and necessary sum bounds, then use two further good primes and exact GMP integer arithmetic on those remaining.

For the final integer test denote raw coefficients by f_j, L=f6, U=4L f4−f5², V=8L² f3−f5 U. The three residuals are

    64L³ f2 − U² − 4f5 V,
    64L⁴ f1 − U V,
    256L⁵ f0 − V².

They must all vanish for a scalar square. The actual replay reached 2,921,413 CRT tuples after basic restrictions, 60,285 after a third prime, and 780 after a fourth; none passed the integer test. Thus no irrational exceptional point exists for k=8.

### Relation to prior work

Prékopa's dual-feasible-basis method supplies the underlying discrete moment optimization framework. Section 3.2 of Berend, Ernst, Kontorovich and Kumar applies that method to the binomial support geometry used here. For binomial moment problems, Hermann's Theorem 1 also uses the binomial reweighting, and his Corollary 3 describes reflection. Peled, Yadin and Yehudayoff compare adjacent integer roots with double roots in Section 3 and Theorem 4.1 of their asymptotic analysis. Here the double-root comparison is used for a different purpose. It excludes the algebraic obstruction to the rationality of simultaneous support changes at fixed order eight. [Prékopa](https://doi.org/10.1287/opre.38.2.227) · [Berend et al.](https://doi.org/10.1007/s10959-026-01487-4) · [Hermann](https://arxiv.org/abs/2609.25595v1) · [Peled et al.](https://doi.org/10.1002/rsa.20329)

### Replay

On Linux with a C++17 compiler, GMP development headers and OpenMP, run `./reproduce.sh`. The largest prime table may require roughly 1 GB of RAM. The script checks the hash of the candidate list and the per-size verification log; neither is used as an unverified oracle. Exact duplicates in tuple counts, when residue labels tie, do not affect exhaustiveness. The file `verification.txt` contains one line per size with the two CRT primes, the two local-list sizes and the three post-CRT counts.

Optional: run `python3 check_identities.py` with SymPy to verify the Gram/Sturm and binomial coefficient-transfer identities by exact symbolic algebra.
