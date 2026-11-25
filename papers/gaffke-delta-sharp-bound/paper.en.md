# A sharp leave-one-out bound for the Gaffke statistic

## Abstract

Haben Michael's Conjecture 2 asks for a lower bound on the common leave-one-out coefficient of Gaffke's statistic. We prove the conjecture and sharpen it by replacing the total number of observations minus one with the number strictly below one. Both bounds are sharp, with explicit equality cases. The proof compares a log-concave survival function to an exponential that has the same average against one law, and then compares their averages after adding an independent exponential.

## 1. Statistic and theorem

Let $x=(x_1,\ldots,x_n)\in[0,\infty)^n$ and let $E_0,E_1,\ldots,E_n$ be independent unit-rate exponentials. Write
$$
S=\sum_{i=1}^n(x_i-1)E_i,\qquad
K(x)=\Pr(S<E_0)=E[e^{-S_+}].
$$
We define $K$ on the empty vector to be one. Write $x_{-i}$ for deletion of coordinate $i$. For each $i$ with $x_i\ne1$, the quantity
$$
\Delta K(x)=\frac{K(x_{-i})-K(x)}{x_i-1}
$$
is the same. Below we establish this through a common probabilistic expression, which also specifies the value zero at the all-one vector when a convention there is desired. The deletion quotient itself has no value at that vector.

**Theorem.** If at least one $x_i>1$ and exactly $r\ge1$ coordinates are strictly below one, then
$$
\Delta K(x)\ge (1-K(x))^{r/(r+1)}-(1-K(x)). \tag{1}
$$
For fixed $r$, equality holds precisely when there is exactly one coordinate above one and every coordinate below one is zero. Any remaining coordinates may equal one. In particular, for all $n\ge2$ the bound in Michael's Conjecture 2 holds:
$$
\Delta K(x)\ge (1-K(x))^{1-1/n}
                    [1-(1-K(x))^{1/n}]. \tag{2}
$$
When $K(x)<1$, equality in (2) holds precisely for a permutation of $(0,\ldots,0,b)$ with $b>1$.

If every coordinate is at most one, $K(x)=1$ and the right side of (2) vanishes. If every coordinate is at least one and some coordinate is above one, then $\Delta K(x)=K(x)\in (0,1)$ and (2) is strict for $n\ge2$. For $n=1$ with $x_1>1$, $\Delta K=K=1/x_1$; the dimension-one formula of (2) at $K=1$ has a zero-to-the-zero convention issue, so the theorem states the conjecture for $n\ge2$ and gives the remaining one-coordinate case directly.

## 2. An averaged survival comparison

**Lemma.** Let $N$ have a log-concave density $f$ positive on $(0,\infty)$ and zero on $(-\infty,0)$. Let $H:[0,\infty)\to(0,1]$ be a continuous log-concave survival function, with $H(0)=1$ and $0<E H(N)<1$. Choose the unique $\lambda>0$ with $A:=E H(N)=E e^{-\lambda N}$. For an independent nonnegative variable $W$,
$$
E H(N+W)\le E e^{-\lambda(N+W)}
          =A\,E e^{-\lambda W}. \tag{3}
$$
If $W$ has a density positive on $(0,\infty)$, equality requires $H(t)=e^{-\lambda t}$ for every $t\ge0$.

**Proof.** The Laplace transform of the positive $N$ decreases continuously and strictly from one to zero, so the match exists. By concavity of $\log H(t)+\lambda t$ and its value zero at $t=0$, its ratio to $t$ is nonincreasing on $(0,\infty)$. It follows that the continuous difference $H(t)-e^{-\lambda t}$ can only change sign from positive to negative as $t$ increases. If the difference is nonzero somewhere, its expectation under $N$ being zero implies that it has nonempty positive and negative intervals separated by a finite point $t_0$.

The density $g$ of $N+W$ satisfies, almost everywhere on $(0,\infty)$,
$$
\frac{g(t)}{f(t)}
   =\int_{[0,t)}\frac{f(t-u)}{f(t)}\,dF_W(u).
$$
The endpoint $u=t$ for a possible atom of $W$ can be omitted almost everywhere. For each fixed $u\ge0$ the integrand, extended by zero for $t\le u$, is nondecreasing in $t>0$. Indeed, an increment of a concave function over an interval of fixed length decreases as that interval moves right, applied here to $\log f(t)-\log f(t-u)$. Hence $g/f$ is nondecreasing. If $W$ has a positive density, the ratio is strictly increasing because increasing $t$ adds an interval of positive integrand, in addition to weakly increasing the existing contributions.

The integral of $H-e^{-\lambda t}$ against $f$ is zero. Weighting by the ratio $g/f$ cannot increase the integral: subtract its value at $t_0$ and note that the product of the ratio difference and the survival difference is everywhere nonpositive. This proves (3), and strictness follows for nonzero survival difference if the ratio is strictly increasing. $\square$

## 3. Proof and equality

To identify the coefficient, fix $i$ and condition on all other exponentials, with subtotal $Y$. Write $c_i=x_i-1$ and $h(u)=e^{-(Y+c_i u)_+}$. This function is bounded and absolutely continuous, with derivative $-c_i e^{-(Y+c_i u)}\mathbf1\{Y+c_i u>0\}$ almost everywhere. Integration by parts against $e^{-u}$ gives
$$
h(0)-\int_0^\infty h(u)e^{-u}\,du
= c_i\int_0^\infty e^{-(Y+c_i u)}
                    \mathbf1\{Y+c_i u>0\}e^{-u}\,du.
$$
Averaging proves the deletion identity and the common expression
$$
\Delta K(x)=E[e^{-S}\mathbf1\{S>0\}].
$$

Assume both positive and negative coefficients occur. Write $P=\sum_{x_i>1}(x_i-1)E_i$ and $N=\sum_{x_i<1}d_iE_i$, where $d_i=1-x_i\in(0,1]$. These sums are independent and $S=P-N$. Let $A=\Pr(P>N)$ and $D=\Pr(P>N+E_0)$. The absence of equality for this continuous distribution gives
$$
D=1-K,\qquad \Delta K=A-D.
$$
Indeed, conditioning on $P,N$ gives $D=E[(1-e^{-S})\mathbf1\{S>0\}]$. The density of either sum is log-concave by convolution, and $H(t)=\Pr(P>t)$ is log-concave by marginalization of the log-concave density over the half-line. These are the standard preservation properties of log-concavity (Prékopa). Positive exponential summands give densities positive on $(0,\infty)$. In particular $0<A<1$.

Apply (3) with $W=E_0$. The independent product Laplace transform gives
$$
D\le \frac{A}{1+\lambda},\qquad
A=\prod_{x_i<1}(1+\lambda d_i)^{-1}\ge(1+\lambda)^{-r}.
$$
Thus $D\le A^{1+1/r}$, and rearranging yields (1). The product comparison is an equality only when every $d_i=1$. The survival comparison is an equality only when $P$ is exponential. This happens for one positive term. A sum of two or more independent positive exponential terms has probability $O(t^2)$ of being at most $t$ as $t\downarrow0$, because each of the first two terms must lie below $t$; an exponential has a nonzero derivative of its CDF at zero. Conversely one positive term and all $d_i=1$ give equality in both comparisons.

For (2), use $r\le n-1$, so $D^{r/(r+1)}\ge D^{1-1/n}$ and strictness holds when $r<n-1$ and $0<D<1$. The cases with no positive term or no negative term follow directly from the last displayed formula for $\Delta K$ and complete the theorem.

### Same-$K$ compression

Michael proposes replacing all coordinates above one by one such coordinate, keeping the original below-one coordinates fixed, while preserving $K$ and making $\Delta K$ no larger. The survival comparison proves this stronger intermediate claim too. For the original negative sum $N$, write $L(\lambda)=E e^{-\lambda N}$. Choose the unique $\lambda_*>0$ with $L(\lambda_*)/(1+\lambda_*)=D$. This is possible because that function decreases continuously and strictly from one to zero. The bound $D\le L(\lambda)/(1+\lambda)$ proves $\lambda_*\ge\lambda$. Replacing the positive sum by one exponential of mean $1/\lambda_*$ corresponds to the coordinate $1+1/\lambda_*$. It retains $D$, hence $K$, and its new $\Delta K$ is $L(\lambda_*)-D\le L(\lambda)-D=\Delta K$. If the original had more than one positive coordinate and $N$ is nontrivial, the survival comparison is strict, and $L(\lambda_*)<L(\lambda)$. If $N=0$, the same construction with $L\equiv1$ preserves $\Delta K$ exactly.

## 4. Interpretation and scope

In Michael's source, the one-coordinate-above-one case of (2) is Theorem 25. Inequality (1) handles every sign configuration and yields equality at the stated examples. The deletion identity then bounds how much $K$ changes upon deleting a coordinate above or below one. This is a deterministic pointwise property of the statistic. The independent-data validity of Gaffke's p-value is the result of Vlassis and Thomas, and its confidence-interval efficiency or numerical computation belongs to the cited later work.

## References

- Haben Michael. *Results relating to a conjecture on the validity of a certain hypothesis test*. Author preprint, Conjecture 2 and Theorem 25. <https://haben-michael.github.io/preprints/gaffke.pdf>.
- András Prékopa. *On logarithmic concave measures and functions*. Acta Scientiarum Mathematicarum 34, 335--343, 1973. <https://rutcor.rutgers.edu/~prekopa/LOGCON.pdf>.
- Nikos Vlassis and Philip S. Thomas. *An exact distribution-free test for means of nonnegative random variables*. arXiv:2607.08415, 2026. <https://arxiv.org/abs/2607.08415>.
- Jiahao Ming, Aaditya Ramdas, Yi Shen, Ruodu Wang and Ian Waudby-Smith. *Gaffke's confidence interval for the mean of bounded data is inadmissible but asymptotically efficient*. arXiv:2607.18661, 2026. <https://arxiv.org/abs/2607.18661>.
- Louis Abraham. *Exact, narrow and fast: Use the Gaffke confidence interval for the mean of a discrete bounded variable*. arXiv:2611.29512, 2026. <https://arxiv.org/html/2611.29512v1>.
