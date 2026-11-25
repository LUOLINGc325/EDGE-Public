# Reproducibility and verification boundaries

The executable finite checks are separated from the proofs of general claims.

- The rational certificate section of the primary program uses Python fractions to check 1,020 row pairs, 30 strict Hamming comparisons and 81 reciprocal-convexity identities. Those counts describe finite instances only.
- Floating diagnostics evaluate finite binomial or multinomial sums using logarithmic arithmetic. A grid with local refinement is explicitly labelled numerical optimization; it is not a certified global minimizer.
- An independent reviewer checked the likelihood-ratio reduction and the six asymptotic regimes, including all prior-boundary arguments, and recomputed selected examples with a separate program.
- The Lean supplement verifies the finite weighted reciprocal-convexity core. Its scope is identified by the exact declaration map and real compiler/axiom reports.

Full-paper Lean coverage remains unfinished. In particular, no Lean result is claimed for the cited support reduction, probability limit theorems, growing-order phase diagram, or asymptotic optimizer convergence. The scope is limited to the stated algebraic core. A successful algebraic-core build does not establish the paper's full formalization.

The two normal-window decimals were independently recomputed at high precision. The exact root and variational definitions, rather than rounded decimals, govern the mathematical statements.

# References

1. A. Vandenbroucque, A. R. Esposito and M. Gastpar. *Contraction of Rényi Divergences for Discrete Channels*. arXiv:2609.34570v1, 2026. Theorem 6(b), Theorem 7 and Corollary 3. <https://arxiv.org/html/2609.34570v1>.

2. Y. Polyanskiy and Y. Wu. *Strong data-processing inequalities for channels and Bayesian networks*. arXiv:1508.06025; author's published-version manuscript, particularly the product-BSC discussion and equations (39)-(41). <https://people.lids.mit.edu/yp/homepage/data/simple-IMA.pdf>.

3. L. Jin, A. R. Esposito and M. Gastpar. *Properties of the Strong Data Processing Constant for Rényi Divergence*. arXiv:2403.10656. <https://arxiv.org/abs/2403.10656>.

4. C. Hirche and O. Shaya. *Partial orders and contraction for BISO channels*. arXiv:2504.16726v2, 2026. <https://arxiv.org/html/2504.16726v2>.

5. R. H. Moore and A. R. Esposito. *Beyond Hypercontractivity: Stronger Communication Converses via Rényi Contraction*. arXiv:2610.13030, 2026. <https://arxiv.org/abs/2610.13030>.

6. C. Stone. *On local and ratio limit theorems*. Proceedings of the Fifth Berkeley Symposium on Mathematical Statistics and Probability, vol. II, part II, pp. 217-224. Corollary 1 on p. 218 supplies a location-uniform interval local limit theorem. Original indexed theorem text was retrieved; direct full-PDF retrieval was restricted. Related paper: *A local limit theorem for nonlattice multi-dimensional distribution functions*, Annals of Mathematical Statistics 36 (1965), 546-551, DOI:10.1214/aoms/1177700165. <https://digicoll.lib.berkeley.edu/nanna/record/113081/files/math_s5_v2_p2_article-15.pdf?registerDownload=1&version=1&withMetadata=0&withWatermark=0>.

7. R. R. Bahadur and R. Ranga Rao. *On deviations of the sample mean*. Annals of Mathematical Statistics 31 (1960), 1015-1027, DOI:10.1214/aoms/1177705674. Historical context for strong large-deviation asymptotics; the proof here explicitly uses the local-limit and finite-alphabet large-deviation arguments it states. <https://repository.ias.ac.in/27001/>.

8. W. Hoeffding. *Probability inequalities for sums of bounded random variables*. Journal of the American Statistical Association 58 (1963), 13-30, DOI:10.1080/01621459.1963.10500830. The bounded independent-sum inequality is used in the critical-window proof. <https://www.tandfonline.com/doi/abs/10.1080/01621459.1963.10500830>.

9. R. Lucchese, D. Varagnolo, J.-C. Delvenne and J. M. Hendrickx. *Network cardinality estimation using max consensus: the case of Bernoulli trials*. Proceedings of the 54th IEEE Conference on Decision and Control, 2015, pp. 895-901, DOI:10.1109/CDC.2015.7402342. Lemma 1 and equations (11)-(13) exhibit the same scalar optimizer \(0.2031878699\ldots\) in a Fisher-information design problem. The inspected author PDF has a sign misprint in equation (9); the stated value and the objective and derivative in (11)-(13) determine the intended equation. <https://perso.uclouvain.be/julien.hendrickx/availablepublications/CDC15_1700_FI.pdf>.

The source log records which full texts and theorem statements were actually inspected. Lack of a matching result in the inspected sources is a bounded novelty assessment, not proof of global priority. The work is an AI-assisted research draft and has not been externally peer-reviewed.

