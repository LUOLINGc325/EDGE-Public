// Exact finite checks for the two private scalar mechanisms.
// Run with Node.js using: node checks.mjs
function assert(condition, message) {
  if (!condition) throw new Error(message);
}
function gcd(a, b) {
  while (b !== 0n) [a, b] = [b, a % b];
  return a < 0n ? -a : a;
}
function f(n, d = 1n) {
  n = BigInt(n);
  d = BigInt(d);
  assert(d > 0n, "positive denominator");
  const g = gcd(n, d);
  return { n: n / g, d: d / g };
}
const zero = f(0), one = f(1), half = f(1, 2);
const add = (a, b) => f(a.n * b.d + b.n * a.d, a.d * b.d);
const sub = (a, b) => f(a.n * b.d - b.n * a.d, a.d * b.d);
const mul = (a, b) => f(a.n * b.n, a.d * b.d);
const div = (a, b) => f(a.n * b.d, a.d * b.n);
const pow = (a, k) => f(a.n ** BigInt(k), a.d ** BigInt(k));
const le = (a, b) => a.n * b.d <= b.n * a.d;
const eq = (a, b) => a.n === b.n && a.d === b.d;
const min = (a, b) => le(a, b) ? a : b;
const pos = (a) => le(a, zero) ? zero : a;

function shiftEndpointLoss(base, radius) {
  const decay = div(one, base);
  const weights = [one];
  for (let j = 1; j <= radius; j++) weights.push(mul(weights[j - 1], decay));
  const total = add(one, mul(f(2), weights.slice(1).reduce(add, zero)));
  const mass = (j) => Math.abs(j) > radius ? zero : div(weights[Math.abs(j)], total);
  const theoretical = mass(radius);
  for (const shift of [-1, 1]) {
    let deficiency = zero;
    for (let j = -radius - 1; j <= radius + 1; j++) {
      deficiency = add(deficiency, pos(sub(mass(j), mul(base, mass(j - shift)))));
    }
    assert(eq(deficiency, theoretical), "exact endpoint privacy loss");
  }
  return theoretical;
}
function bernoulli(base, delta, distance) {
  return min(half, mul(delta, div(sub(pow(base, distance), one), sub(base, one))));
}
function binomial(n, p, values) {
  let coefficient = 1n, total = zero;
  for (let j = 0; j <= n; j++) {
    const probability = mul(f(coefficient), mul(pow(p, j), pow(sub(one, p), n - j)));
    total = add(total, mul(probability, values[j]));
    coefficient = coefficient * BigInt(n - j) / BigInt(j + 1);
  }
  return total;
}
function describe(r) {
  return Number(r.n) / Number(r.d);
}

const bases = [f(5, 4), f(9, 8), f(17, 16), f(33, 32), f(65, 64)];
const budgets = [f(1, 16), f(1, 256), f(1, 4096), f(1, 65536), f(1, 1048576)];
let endpointCases = 0, bernoulliChecks = 0, budgetCases = 0;
const distances = [0, 1, 2, 3, 7, 11, 16, 31, 64, 127, 256, 512, 777, 1024];
const examples = [];
for (const base of bases) {
  for (const radius of [0, 1, 2, 4, 8, 16, 32, 64, 96]) {
    shiftEndpointLoss(base, radius);
    endpointCases++;
  }
  for (const delta of budgets) {
    for (const d of distances) {
      const pred = bernoulli(base, delta, d);
      const next = bernoulli(base, delta, d + 1);
      assert(le(pred, next) && le(next, half), "capped probabilities");
      for (const [x, y] of [[pred, next], [next, pred], [sub(one, pred), sub(one, next)],
        [sub(one, next), sub(one, pred)]]) {
        assert(le(x, add(mul(base, y), delta)), "neighboring Bernoulli DP inequality");
        bernoulliChecks++;
      }
    }
    for (const n of [8, 16, 32, 64]) {
      const threshold = Math.floor(5 * n / 16);
      const values = Array.from({ length: n + 1 }, (_, j) => bernoulli(base, delta, Math.max(0, j - threshold)));
      const A = binomial(n, f(3, 4), values);
      const B = binomial(n, f(1, 4), values);
      const evidenceTrue = div(A, B), evidenceFalse = div(sub(one, A), sub(one, B));
      assert(eq(add(mul(B, evidenceTrue), mul(sub(one, B), evidenceFalse)), one),
        "null mean of exact output likelihood ratio");
      assert(le(B, A), "monotone alternative event");
      budgetCases++;
      if (n === 64 && eq(base, f(9, 8))) {
        examples.push({ n, multiplier: "9/8", delta: delta.n + "/" + delta.d,
          null_event: describe(B), alternative_event: describe(A), success_evidence: describe(evidenceTrue) });
      }
    }
  }
}
const pureVsRare = {
  // Here log n is used symbolically through a_n=log n. These are factors
  // in the proof's critical lower and upper estimates, for display only.
  log_n: [4096, 16384, 65536],
  plus_scale_factor: [4096, 16384, 65536].map((a) => Math.exp(Math.sqrt(a) - 2 * Math.log(a))),
  minus_slack_over_epsilon: [4096, 16384, 65536].map((a) => Math.exp(1 - Math.sqrt(a)))
};
console.log(JSON.stringify({
  status: "pass",
  arithmetic: "exact rational except displayed illustrations",
  geometric_endpoint_cases: endpointCases,
  bernoulli_ordered_inequalities: bernoulliChecks,
  binary_evalue_budget_cases: budgetCases,
  examples,
  critical_estimate_factors: pureVsRare
}, null, 2));
