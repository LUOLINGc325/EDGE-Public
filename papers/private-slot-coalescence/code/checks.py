"""Finite exact checks for private-chain suffix coalescence."""

from itertools import combinations, product
from random import Random
import json


def require(condition, context):
    if not condition:
        raise RuntimeError(str(context))


def marker_sets(length, bound):
    return [set(slots) for size in range(bound + 1)
            for slots in combinations(range(length), size)]


def verify_counting():
    checked = sharp = 0
    for cost in range(1, 5):
        length = 2*cost
        for from_empty in marker_sets(length, cost):
            for from_marked in marker_sets(length, cost-1):
                require(len(from_empty | from_marked) < length, (cost, length))
                checked += 1
        a, b = "", "1"
        paid_a, paid_b = 0, 1
        for _ in range(length-1):
            a, b = ("" if a else "1"), ("" if b else "1")
            require(a != b, "alternating sharp example")
            paid_a += len(a)
            paid_b += len(b)
        require(paid_a == paid_b == cost, (cost, paid_a, paid_b))
        sharp += 1
    return {"pairs_of_suffix_marker_sets": checked, "sharp_lengths": sharp}


def encode(message):
    return "".join("1"+bit for bit in message) + "0"


def verify_prefix_code():
    messages = ["".join(bits) for size in range(6)
                for bits in product("01", repeat=size)]
    codes = {message: encode(message) for message in messages}
    checks = 0
    for message, word in codes.items():
        require(len(word) == 2*len(message)+1, word)
        require(not any(other != message and word.startswith(other_word)
                        for other, other_word in codes.items()), word)
        checks += 1
    return checks


def step(stage, incoming, previous_index, strings, left, right, seed):
    if stage not in left and (stage not in right or incoming):
        return ""
    total = sum((j+1)*word.bit_count() for j, word in enumerate(strings))
    total += sum(previous_index) + stage + seed
    return str((total // 3) % 2) if total % 3 else ""


def decode(incoming, index):
    return tuple(((int(incoming)+j) if incoming else j) % 2 for j in index)


def run_suffix(inputs, indices, start, left, right, seed, cap=None):
    incoming = ""
    payload = 0
    messages = []
    for position in range(start, len(inputs)):
        previous_index = indices[position-1] if position else ()
        outgoing = step(position+1, incoming, previous_index, inputs[position],
                        left, right, seed)
        if cap is not None and payload + len(outgoing) > cap:
            outgoing = ""
        payload += len(outgoing)
        messages.append(outgoing)
        incoming = outgoing
    return decode(incoming, indices[-1]), payload, messages


def verify_protocols():
    rng = Random(20261125)
    long_cases = short_cases = checked_cuts = good_cuts = binary_cuts = 0
    for _ in range(1800):
        n, k, r = rng.randrange(2, 7), rng.randrange(2, 35), rng.randrange(1, 5)
        cost = rng.randrange(1, min(6, k//2) + 1)
        left = set(rng.sample(range(1, k, 2), cost))
        right = {index+1 for index in left}
        seed = rng.randrange(10**6)
        answer = tuple(rng.randrange(2) for _ in range(r))
        indices = [tuple(rng.randrange(n) for _ in answer) for _ in range(k)]
        inputs = [
            tuple((rng.randrange(1 << n) & ~(1 << index)) | (bit << index)
                  for index, bit in zip(stage_indices, answer))
            for stage_indices in indices
        ]
        original, spent, _ = run_suffix(inputs, indices, 0, left, right, seed)
        require(spent <= cost, "at most one marker per two-stage block")

        def canonical(bit_vector):
            strings = tuple(((1 << n)-1) if bit else 0 for bit in bit_vector)
            return run_suffix([strings]*k, [(0,)*r]*k, 0, left, right, seed)[2]

        if k <= 4*cost:
            require(2*spent+k <= 6*cost, "short-chain cost")
            short_cases += 1
            continue
        long_cases += 1
        cuts = list(range(k-4*cost, k-2*cost+1))
        witness = canonical(answer)
        when_original_correct = 0
        instantiated = 0
        for cut in cuts:
            output, used, messages = run_suffix(
                inputs, indices, cut, left, right, seed, cap=cost)
            require(used <= cost and sum(len(encode(m)) for m in messages) <= 6*cost,
                    "charged simulation budget")
            checked_cuts += 1
            when_original_correct += int(output == answer)
            if witness[cut-1] == "":
                require(output == original, (cost, cut, "coalescence"))
                instantiated += 1
                good_cuts += 1
        require(instantiated >= cost+1, "good cut fraction")
        if original == answer:
            require(when_original_correct >= cost+1, "multiplicative success")
        if r == 1:
            zero, one = canonical((0,)), canonical((1,))
            cut = next(c for c in cuts if not zero[c-1] and not one[c-1])
            output, _, _ = run_suffix(inputs, indices, cut, left, right, seed, cap=cost)
            require(output == original, "one answer common cut")
            binary_cuts += 1
    return {"protocol_inputs": 1800, "long_chain_inputs": long_cases,
            "short_chain_inputs": short_cases, "cuts_checked": checked_cuts,
            "canonical_good_cuts": good_cuts, "one_answer_common_cuts": binary_cuts}


print(json.dumps({"coalescence": verify_counting(),
                  "prefix_codewords": verify_prefix_code(),
                  "simulations": verify_protocols()}, indent=2))
