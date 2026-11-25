// Exact arithmetic checks for the charged-feedback supplement.
// Run with Node.js using: node checks.mjs
function assert(condition, label) {
  if (!condition) throw new Error(label);
}

function gcd(a, b) {
  while (b !== 0n) [a, b] = [b, a % b];
  return a < 0n ? -a : a;
}

function fraction(n, d = 1n) {
  n = BigInt(n);
  d = BigInt(d);
  assert(d !== 0n, "nonzero denominator");
  if (d < 0n) [n, d] = [-n, -d];
  const g = gcd(n, d);
  return { n: n / g, d: d / g };
}

const one = fraction(1);
const add = (a, b) => fraction(a.n * b.d + b.n * a.d, a.d * b.d);
const sub = (a, b) => fraction(a.n * b.d - b.n * a.d, a.d * b.d);
const mul = (a, b) => fraction(a.n * b.n, a.d * b.d);
const div = (a, b) => fraction(a.n * b.d, a.d * b.n);
const pow = (a, p) => fraction(a.n ** p, a.d ** p);
const le = (a, b) => a.n * b.d <= b.n * a.d;
const eq = (a, b) => a.n === b.n && a.d === b.d;

function choose(n, k) {
  if (k < 0 || k > n) return 0n;
  let b = 1n;
  for (let i = 1; i <= k; i++) b = b * BigInt(n - i + 1) / BigInt(i);
  return b;
}

function width(count) {
  return count <= 1n ? 0 : (count - 1n).toString(2).length;
}

function bits(value, bitCount) {
  assert(value >= 0n && value < 2n ** BigInt(bitCount), "field range");
  return bitCount === 0 ? "" : value.toString(2).padStart(bitCount, "0");
}

const asInt = (value) => value === "" ? 0n : BigInt("0b" + value);

function rankSubset(q, subset) {
  let rank = 0n;
  for (let i = 0, start = 0; i < subset.length; i++) {
    const k = subset.length - i - 1;
    for (let j = start; j < subset[i]; j++) rank += choose(q - j - 1, k);
    start = subset[i] + 1;
  }
  return rank;
}

function unrankSubset(q, k, rank) {
  assert(rank >= 0n && rank < choose(q, k), "valid rank");
  const labels = [];
  for (let j = 0; labels.length < k; j++) {
    const block = choose(q - j - 1, k - labels.length - 1);
    if (rank < block) labels.push(j);
    else rank -= block;
  }
  return labels;
}

function* subsets(q, minSize, maxSize) {
  for (let mask = 1; mask < 2 ** q; mask++) {
    const labels = Array.from({ length: q }, (_, i) => i).filter((i) => mask & (1 << i));
    if (labels.length >= minSize && labels.length <= maxSize) yield labels;
  }
}

function packet(q, maxSize, labels, preamble = "") {
  return "1" + preamble + bits(BigInt(labels.length - 1), width(BigInt(maxSize))) +
    bits(rankSubset(q, labels), width(choose(q, labels.length)));
}

function decodePacket(q, maxSize, value, preambleLength = 0) {
  const countStart = 1 + preambleLength;
  const countEnd = countStart + width(BigInt(maxSize));
  const k = 1 + Number(asInt(value.slice(countStart, countEnd)));
  const rankBits = value.slice(countEnd);
  assert(rankBits.length === width(choose(q, k)), "exact packet length");
  return unrankSubset(q, k, asInt(rankBits));
}

function checkPrefixFree(packets) {
  const set = new Set(packets);
  assert(set.size === packets.length, "distinct packets");
  for (const code of set) {
    for (let p = 0; p < code.length; p++) assert(!set.has(code.slice(0, p)), "prefix-free");
  }
  return set.size;
}

let packetChecks = 0;
for (let q = 3; q <= 12; q++) {
  const packets = ["0"];
  for (const labels of subsets(q, 1, q - 1)) {
    const code = packet(q, q, labels);
    assert(decodePacket(q, q, code).join() === labels.join(), "small-state subset round trip");
    packets.push(code);
  }
  packetChecks += checkPrefixFree(packets);
}

const K = 3;
const seedCount = 5n;
const seedWidth = width(seedCount);
const largePackets = ["0"];
for (let seed = 0n; seed < seedCount; seed++) {
  for (const labels of subsets(K * K, 1, K)) {
    const code = packet(K * K, K, labels, bits(seed, seedWidth));
    assert(asInt(code.slice(1, 1 + seedWidth)) === seed, "seed round trip");
    assert(decodePacket(K * K, K, code, seedWidth).join() === labels.join(), "image subset round trip");
    largePackets.push(code);
  }
}
packetChecks += checkPrefixFree(largePackets);

let reductionChains = 0;
for (let q = 2; q <= 12; q++) {
  let factorial = 1n;
  for (let i = 2; i <= q; i++) factorial *= BigInt(i);
  function visit(current, product) {
    assert(product <= factorial, "telescoping subset-rank bound");
    reductionChains++;
    for (let next = 1; next < current; next++) visit(next, product * choose(current, next));
  }
  visit(q, 1n);
}

function frontier(m, rounds) {
  const h = m / 2;
  const c = fraction(h - 2, 2 * (2 * h - 1));
  const a = div(fraction(1, 3), c);
  const start = div(mul(fraction(3), c), add(one, mul(fraction(2), c)));
  const values = [];
  let correction = start;
  for (let s = 0; s <= rounds; s++) {
    const aOverS = s > 0 ? div(a, fraction(s)) : null;
    if (s > 0) {
      correction = le(one, aOverS)
        ? mul(start, sub(one, mul(fraction(3 * s), c)))
        : mul(sub(one, aOverS), correction);
    }
    values.push(div(add(one, mul(fraction(3), c)), add(fraction(3 * (s + 1)), correction)));
  }
  return { c, a, values };
}

let recurrenceChecks = 0;
let thresholdCases = 0;
let prefixSteps = 0;
for (let n = 3; n <= 7; n++) {
  const { c, a, values } = frontier(2 ** n, 40);
  for (let s = 6; s <= 40; s++) {
    const ref = div(one, values[s]);
    const refBefore = div(one, values[s - 1]);
    const multiplier = sub(one, div(a, fraction(s)));
    assert(eq(ref, add(mul(multiplier, refBefore), div(one, c))), "late frontier identity");
    recurrenceChecks++;
  }
  for (let r = 6; r <= 40; r++) {
    for (const denominator of [64, 128, 1024, 2 ** 16, 2 ** 24, 2 ** 32]) {
      const eps = fraction(1, denominator);
      const threshold = pow(mul(fraction(64), eps), a.d);
      let cutoff = 6;
      while (!le(threshold, pow(fraction(cutoff, r), a.n + a.d))) cutoff++;

      // Normalize W to one. Equality in each comparison gives the least
      // forward length allowed by that recurrence from the starting point.
      let remaining = div(one, mul(add(one, eps), values[r]));
      for (let s = r; s >= cutoff; s--) {
        const reference = div(one, values[s]);
        assert(le(sub(reference, remaining), fraction(s, 2)), "deficit is at most s/2");
        assert(le(fraction(s), remaining), "residual length is at least sW");
        prefixSteps++;
        if (s > cutoff) {
          remaining = div(sub(remaining, div(one, c)), sub(one, div(a, fraction(s))));
        }
      }
      thresholdCases++;
    }
  }
}

console.log(JSON.stringify({
  status: "pass",
  arithmetic: "exact integer and rational",
  packet_checks: packetChecks,
  reduction_chains: reductionChains,
  late_frontier_identities: recurrenceChecks,
  lower_cutoff_cases: thresholdCases,
  lower_prefix_states: prefixSteps
}, null, 2));
