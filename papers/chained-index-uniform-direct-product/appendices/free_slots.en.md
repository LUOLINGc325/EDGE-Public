# Free observable slots: a matching all-parameter law

Research date: 2026-11-25 (Asia/Shanghai).
This is a component proof, subject to independent review. The information-budget lemma is established separately; it is not assumed to prove itself.

## Model and theorem

There are k fixed, publicly observable slots. In slot i, a fresh player sees an arbitrary n-bit string x_i and the preceding public history, writes an arbitrary binary string M_i (possibly empty), and then the index j_i is publicly released. The input promise is x_i[j_i]=b for every i. The indices are input, not algorithmic random samples, for the upper bound. Cost is the worst-case sum of the lengths of the k strings; the slots and their boundaries are free. Public and private coins are permitted. Let S(n,k) be the minimum integer cost for worst-case error at most 1/3.

For all n>=2 and k>=1, put

    F(n,k) = max{1, n/log_2(2+k/n)}.

Then

    F(n,k)/2048 <= S(n,k) <= 18 F(n,k).

No claim about the free-silence private-neighbor chain is made. The upper bound uses the public release of the current index.

## Lower bound: count whole message tuples, condition each entropy increment

Let N=2 floor(n/2), so N>=2n/3. Embed the balanced-slice hard distribution on the first N coordinates, with all unused coordinates fixed. The independent random bit B is uniform; each X_i is a uniform N/2-subset independent of B and earlier stages; J_i is uniform in the B-colored coordinates of X_i. Fix public coins R. The information-budget theorem gives

    I(B;Gamma|R) <= (2/N) sum_i H(M_i|Gamma_{<i},R).

Since the preceding message tuple is contained in Gamma_{<i},

    sum_i H(M_i|Gamma_{<i},R)
      <= sum_i H(M_i|M_{<i},R)
      = H((M_1,...,M_k)|R).

This inequality is valid for arbitrary free-slot encodings and makes no prefix assumption. The number of possible k-tuples with total length at most C is exactly

    A(C,k) = sum_{ell=0}^C 2^ell binom(k+ell-1,ell).

For each total length ell, stars and bars chooses the k lengths and 2^ell chooses their bits. Consequently,

    A(C,k) <= 2^C binom(k+C,C)

by the hockey-stick identity. A randomized protocol of worst-case cost C therefore satisfies

    I(B;Gamma|R) <= (2/N) log_2 A(C,k).

Fano for a binary uniform answer with error <=1/3 gives I>=delta, where

    delta = 1-h_2(1/3) = 5/3-log_2 3 > 1/15,

the strict inequality following from 3^5<2^8. Hence

    log_2 A(C,k) >= N delta/2 > n/45.                 (L1)

In particular C>=1. For C>=1, binom(k+C,C)<=[e(k+C)/C]^C gives

    C [1+log_2 e+log_2(1+k/C)] > n/45.              (L2)

For completeness, the inversion is uniform in k/n, including very long chains. Set t=k/n, L=log_2(2+t)>=1, and a=1/2048. The function

    f_t(x)=x[1+log_2 e+log_2(1+t/x)]

is increasing for x>0. At x=a/L, use

    1+tL/a <= (2+t)L/a,
    log_2 e<2,
    log_2 L<=L,
    log_2(1/a)=11

to get f_t(a/L)<=a(14/L+2)<=16a=1/128<1/45. Thus (L2) forces C>n/(2048 L). Combined with C>=1, this proves the asserted lower bound.

## Upper bound: capped randomized pattern matching

The trivial protocol sends one entire x_i in a designated slot and then uses its released index, at cost n and error zero. If k/n<64, then log_2(2+k/n)<7 and n<=7F(n,k), so this suffices.

Now assume q=k/n>=64. Choose

    t=min{n, floor((log_2 q)/2)},
    C=ceil(4n/t).

In each slot, public randomness independently chooses a uniform t-subset S_i of [n] and a uniform binary pattern R_i on S_i. While no answer has been learned and fewer than C markers have been sent, player i sends the single bit 1 exactly when x_i restricted to S_i equals R_i; otherwise it sends the empty string. After a marker, if j_i is in S_i, every participant learns b=R_i[j_i]. All later messages are empty. If the cap C is reached without learning b, all later messages are also empty. The final decoder outputs the learned answer, or a fair public random bit if none was learned. This uses at most C payload bits on every input and every coin realization.

Fix any promised input, including all the indices. For every slot and every S_i, the probability of a pattern match is exactly 2^{-t}. Conditional on a match, S_i is still a uniform t-subset, because the match probability is the same for every S_i. Thus the match flag is Bernoulli(2^{-t}), and conditional on a match the hit flag j_i in S_i is Bernoulli(t/n). These pairs are independent across slots. These facts hold for arbitrary input strings, not just balanced strings or random input indices.

Consider all k latent match flags before stopping and let Z be their sum, so Z~Binomial(k,2^{-t}). Conditional on the flags, the hit indicators at their marked slots are independent Bernoulli(t/n). If Z>=C, failure to learn the bit has probability at most (1-t/n)^C<=exp(-Ct/n)<=exp(-4). The probability of fewer than C matches is bounded separately.

The mean mu=k 2^{-t} is at least n sqrt(q)>=8n. Since t>=2,

    C <= 5n/t <= (5/2)n <= mu/2.

The standard binomial lower-tail Chernoff inequality yields

    Pr[Z<C] <= exp(-mu/8) <= exp(-n) <= exp(-2).

Therefore failure to learn has probability at most exp(-2)+exp(-4)<1/3. The final fair guess can only improve this, so the required worst-case error bound holds. The Chernoff bound is a conventional background result; it is not a new theorem in this project.

It remains to compare the cost to F. If t=n, then C=4<=4F. Otherwise log_2 q>=6 implies

    t >= (log_2 q)/3,
    log_2(2+q) <= (7/6) log_2 q.

Consequently,

    C <= 5n/t <= 15n/log_2 q
      <= (35/2)n/log_2(2+q) <= 18F.

This completes the all-parameter proof.

## A transparent extreme example

Choose t=n and a cap of one marker. In each slot, choose an independent uniform public n-bit pattern and mark precisely when it equals the whole current string. A match reveals b after the current index release. The worst-case cost is one bit, and the success probability on every input is

    1 - (1/2)(1-2^{-n})^k.

For k>=2^n, this exceeds 1-(1/2)e^{-1}>2/3. Thus the eventual constant-cost regime has an explicit one-bit realization. It uses the free timing of the unique nonempty message, which the charged binary-tree model does not provide.

## Review checklist

- The lower-bound distribution may restrict inputs; the upper bound must and does work for every promised input.
- Private coins can be exposed as extra public independent coins for lower bounds; worst-case cost is required over coin realizations.
- H(message tuple)<=C is never used; only its support-size bound is used in the free-slot model.
- The cap bounds worst-case payload, not just expected payload.
- The public indices occur after messages, and the protocol never uses j_i to decide the current marker.
- All logarithms in communication and entropy are base two; exp uses natural base.
