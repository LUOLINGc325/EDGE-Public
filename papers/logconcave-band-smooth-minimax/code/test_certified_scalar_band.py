#!/usr/bin/env python3
"""Independent arithmetic/geometry regressions for the rational certificate.

Decimal checks are cross-checks only. The enclosure proof rests on the exact
series tail bounds in the implementation and the manuscript theorem.
"""

import json
import sys
import time
import unittest
from decimal import Decimal, localcontext
from fractions import Fraction as Q
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from certified_scalar_band import (
    Block, FiveBlocks, beta_cdf_integer, beta_quantile_bracket, calibrate,
    demo, exp_interval, integral_exp, jsonable, log_interval, node_band,
    profile, rational, scalar_band, stencil,
)


def decimal(q):
    return Decimal(q.numerator) / Decimal(q.denominator)


class CertifiedScalarBandTests(unittest.TestCase):
    def test_rejects_float_inputs(self):
        for bad in (0.1, True):
            with self.assertRaises(TypeError):
                rational(bad)

    def test_exp_against_high_precision_independent_decimal(self):
        with localcontext() as ctx:
            ctx.prec = 130
            for x in (Q(-20), Q(-1), Q(-1, 1000000), Q(0), Q(1, 3), Q(5), Q(20)):
                iv = exp_interval(x, 112)
                actual = decimal(x).exp()
                self.assertLessEqual(decimal(iv.lo), actual)
                self.assertLessEqual(actual, decimal(iv.hi))
                self.assertLessEqual((iv.hi - iv.lo) / iv.lo, Q(1, 2**108))

    def test_log_against_high_precision_independent_decimal(self):
        with localcontext() as ctx:
            ctx.prec = 130
            for x in (Q(1, 10**20), Q(1, 2), Q(1), Q(1000001, 1000000), Q(2), Q(10**20)):
                iv = log_interval(x, 112)
                actual = decimal(x).ln()
                self.assertLessEqual(decimal(iv.lo), actual)
                self.assertLessEqual(actual, decimal(iv.hi))
                self.assertLessEqual(iv.hi - iv.lo, Q(1, 2**111))

    def test_integral_near_zero_and_negative_slope(self):
        with localcontext() as ctx:
            ctx.prec = 130
            for slope in (Q(0), Q(1, 10**15), Q(-3, 7), Q(4)):
                iv = integral_exp(Q(-3), Q(2), slope, 112)
                actual = (Decimal(5) if not slope else
                          ((decimal(2 * slope).exp() - decimal(-3 * slope).exp())
                           / decimal(slope)))
                self.assertLessEqual(decimal(iv.lo), actual)
                self.assertLessEqual(actual, decimal(iv.hi))
                self.assertGreater(iv.lo, 0)

    def test_exact_symmetric_global_optimum(self):
        cert = demo()["certificate"]
        self.assertEqual(cert["root_bracket"].lo, 0)
        self.assertEqual(cert["root_bracket"].hi, 0)
        self.assertEqual(cert["lower"], Q(1, 10))
        self.assertEqual(cert["upper"], Q(18, 125))
        self.assertEqual(cert["log_endpoint_error_bound"], 0)

    @staticmethod
    def asymmetric_problem():
        return FiveBlocks((Block(-8, -7, Q(2, 25)), Block(-4, -3, Q(3, 25))),
                          (Block(3, 4, Q(1, 10)), Block(7, 8, Q(3, 20))),
                          Block(Q(-2, 5), Q(3, 5), Q(4, 25)), Q(1), Q(8))

    def test_asymmetric_bracket_and_global_profile(self):
        blocks = self.asymmetric_problem()
        cert = scalar_band(blocks, Q(1, 10**7))
        self.assertTrue(cert["converged"])
        self.assertLessEqual(cert["log_endpoint_error_bound"], Q(1, 10**7))
        root = cert["root_bracket"]
        left = profile(blocks, root.lo, 160)
        right = profile(blocks, root.hi, 160)
        self.assertLess(left["left"].hi, left["right"].lo)
        self.assertGreater(right["left"].lo, right["right"].hi)
        # The certified optimum dominates any coarsely sampled finite slope,
        # allowing its announced endpoint error; these samples do not prove
        # global optimality and are only independent regression checks.
        with localcontext() as ctx:
            ctx.prec = 100
            lower = decimal(cert["lower"]).ln()
            upper = decimal(cert["upper"]).ln()
            eps = decimal(cert["log_endpoint_error_bound"])
            for k in range(-10, 11):
                values = profile(blocks, Q(k, 10), 112)
                self.assertGreaterEqual(lower + eps, decimal(values["lower"].lo).ln())
                self.assertLessEqual(upper - eps, decimal(values["upper"].hi).ln())

    def test_stopped_run_is_explicitly_not_converged(self):
        cert = scalar_band(self.asymmetric_problem(), Q(1, 10**20), max_iterations=1)
        self.assertFalse(cert["converged"])
        self.assertGreater(cert["lower"], 0)
        self.assertGreater(cert["upper"], cert["lower"])

    def test_bad_geometry_is_rejected(self):
        with self.assertRaises(ValueError):
            FiveBlocks((Block(-2, -1, Q(1, 10)), Block(-4, -3, Q(1, 10))),
                       (Block(3, 4, Q(1, 10)), Block(7, 8, Q(1, 10))),
                       Block(-1, 1, Q(1, 5)), Q(1))

    def test_beta_polynomial_known_cdfs(self):
        for z in (Q(0), Q(1, 9), Q(1, 2), Q(8, 9), Q(1)):
            self.assertEqual(beta_cdf_integer(1, 1, z), z)
            self.assertEqual(beta_cdf_integer(2, 1, z), z**2)
            self.assertEqual(beta_cdf_integer(2, 2, z), 3 * z**2 - 2 * z**3)
            self.assertEqual(beta_cdf_integer(3, 7, z),
                             1 - beta_cdf_integer(7, 3, 1 - z))

    def test_beta_quantile_outward_inequalities(self):
        for p in (Q(1, 1000), Q(1, 2), Q(999, 1000)):
            iv = beta_quantile_bracket(4, 19, p, 30)
            self.assertLessEqual(beta_cdf_integer(4, 19, iv.lo), p)
            self.assertGreaterEqual(beta_cdf_integer(4, 19, iv.hi), p)
            self.assertLessEqual(iv.hi - iv.lo, Q(1, 2**30))

    def test_observable_stencil_and_boundary_fallback(self):
        grid = [Q(i) for i in range(81)]
        self.assertIsNotNone(stencil(grid, 40, 1, Q(1, 100), Q(1, 50)))
        self.assertIsNone(stencil(grid, 0, 1, Q(1, 100), Q(1, 50)))
        self.assertIsNone(stencil(grid, 40, 4, Q(1, 100), Q(1, 50)))
        # A long central cell with short neighboring cells fails the required
        # geometry instead of silently violating the theorem.
        stretched = [Q(i if i < 41 else i + 20) for i in range(81)]
        self.assertIsNone(stencil(stretched, 40, 1, Q(1, 100), Q(1, 50)))

    def test_exact_calibration_and_nodal_pipeline(self):
        calibration = calibrate(320, Q(1, 20), quantile_steps=30)
        self.assertEqual(calibration["q"], 8)
        total = sum((2 * s["count"] * s["delta"] for s in calibration["scales"]), Q(0))
        self.assertEqual(total, Q(1, 20))
        for s in calibration["scales"]:
            self.assertLessEqual(beta_cdf_integer(s["r"], 321 - s["r"], s["c"]), s["delta"])
            self.assertGreaterEqual(beta_cdf_integer(s["r"], 321 - s["r"], s["d"]), 1 - s["delta"])
        sample = [Q(i, 320) for i in range(320)]
        band = node_band(sample, 20, calibration, Q(1, 10**5))
        self.assertGreater(band["scales_used"], 0)
        self.assertLessEqual(band["lower"], 1)
        self.assertGreaterEqual(band["upper"], 1)
        fallback = node_band(sample, 0, calibration)
        self.assertEqual(fallback["lower"], 0)
        self.assertIsNone(fallback["upper"])


if __name__ == "__main__":
    start = time.perf_counter()
    suite = unittest.defaultTestLoader.loadTestsFromTestCase(CertifiedScalarBandTests)
    result = unittest.TextTestRunner(verbosity=2).run(suite)
    report = {"tests_run": result.testsRun, "failures": len(result.failures),
              "errors": len(result.errors), "successful": result.wasSuccessful(),
              "elapsed_seconds": round(time.perf_counter() - start, 6),
              "scope": "arithmetic, outward integer-Beta calibration, scalar brackets, geometry, nodal API",
              "not_established_by_tests": ["statistical coverage proof", "continuous extension implementation", "uniform bit complexity"]}
    if len(sys.argv) > 1:
        Path(sys.argv[1]).write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))
    raise SystemExit(0 if result.wasSuccessful() else 1)
