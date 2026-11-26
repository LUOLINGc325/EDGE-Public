"""Compare the two branch formulas with exact finite-field mode enumeration."""

from itertools import product


def color_count(length, colors):
    return ((colors - 1)**length + (-1)**length * (colors - 1)) // colors


def prediction(k, n, branch):
    a = n - 1
    h = n - 2
    baseline = 2 * k * sum(
        ((length + 1) // 2) * a**length * n**(2 * k - length - 3)
        for length in range(1, 2 * k - 2)
    )
    baseline += 2 * k * (k - 1) * color_count(2 * k - 2, n)
    baseline += 2 * k * k * color_count(2 * k - 1, n)
    baseline += k * color_count(2 * k, n)
    if branch == "minus":
        numerator = a**(2 * k) + 3 * a + a * h * (n + 1)**k
        denominator = n * n
    else:
        numerator = n * a**k * (h - 1) + a**(2 * k) + a
        denominator = n * h
    singular, remainder = divmod(numerator, denominator)
    assert not remainder
    return baseline, singular, baseline - singular


def field(degree, polynomial, order):
    size = 1 << degree

    def multiply(left, right):
        product_value = 0
        while right:
            if right & 1:
                product_value ^= left
            right >>= 1
            left <<= 1
            if left & size:
                left ^= polynomial
        return product_value

    table = [[multiply(left, right) for right in range(size)] for left in range(size)]
    powers = [1]
    for _ in range(size - 2):
        powers.append(table[powers[-1]][2])
    assert len(set(powers)) == size - 1 and table[powers[-1]][2] == 1
    exponent_step, remainder = divmod(size - 1, order)
    assert not remainder
    palette = powers[::exponent_step]
    inverses = [0] * size
    for power, value in enumerate(powers):
        inverses[value] = powers[-power % (size - 1)]
    return table, palette, inverses


def support_rank(mask, size):
    full = (1 << size) - 1
    if mask == full:
        return size // 2
    inactive = ((full ^ mask) & -(full ^ mask)).bit_length() - 1
    rank = 0
    active_run = 0
    for offset in range(1, size + 1):
        if mask & (1 << ((inactive + offset) % size)):
            active_run += 1
        else:
            rank += (active_run + 1) // 2
            active_run = 0
    return rank


def direct_rank(matrix, multiplication, inverses):
    rank = 0
    for col in range(len(matrix)):
        for pivot in range(rank, len(matrix)):
            if matrix[pivot][col]:
                break
        else:
            continue
        matrix[rank], matrix[pivot] = matrix[pivot], matrix[rank]
        reciprocal = inverses[matrix[rank][col]]
        for row in range(rank + 1, len(matrix)):
            ratio = multiplication[matrix[row][col]][reciprocal]
            if ratio:
                for col_index in range(col, len(matrix)):
                    matrix[row][col_index] ^= multiplication[ratio][matrix[rank][col_index]]
        rank += 1
    return rank


def enumerate_modes(k, n, degree, modulus, cross_check=False):
    multiplication, palette, inverses = field(degree, modulus, n)
    support_ranks = [support_rank(mask, 2 * k) for mask in range(1 << (2 * k))]
    full = (1 << (2 * k)) - 1
    baseline = singular = 0
    for colors in product(palette, repeat=2 * k - 1):
        a = colors[:k]
        b = (*colors[k:], 1)
        diagonal = [a[index] ^ b[index] for index in range(k)]
        cyclic = [a[index] ^ b[(index + 1) % k] for index in range(k)]
        mask = sum((int(bool(left)) << (2 * index)) | (int(bool(right)) << (2 * index + 1))
                   for index, (left, right) in enumerate(zip(diagonal, cyclic)))
        rank = support_ranks[mask]
        baseline += rank
        if mask == full:
            first_product = second_product = 1
            for left, right in zip(diagonal, cyclic):
                first_product = multiplication[first_product][left]
                second_product = multiplication[second_product][right]
            if first_product == second_product:
                singular += 1
                rank -= 1
        if cross_check:
            matrix = [[0] * k for _ in range(k)]
            for index in range(k):
                matrix[index][index] = diagonal[index]
                matrix[index][(index + 1) % k] = cyclic[index]
            assert rank == direct_rank(matrix, multiplication, inverses)
    return baseline, singular, baseline - singular


def main():
    branch_fields = [(3, 2, 0b111, "minus"), (5, 4, 0b10011, "plus"),
                     (7, 3, 0b1011, "minus")]
    for n, degree, modulus, branch in branch_fields:
        sizes = (2, 3, 4, 5, 6) if n == 3 else (2, 3, 4)
        for k in sizes:
            value = enumerate_modes(k, n, degree, modulus, cross_check=(n == 3 and k <= 4))
            assert value == prediction(k, n, branch)
            if n == 3:
                assert value == prediction(k, n, "plus")
            baseline, singular, rank = value
            print(f"C{2*k}, n={n}: support baseline={baseline}, singular={singular}, rank={rank}")
    for n in range(4, 24):
        assert prediction(2, n, "minus") == prediction(2, n, "plus")
        for k in range(3, 13):
            assert prediction(k, n, "minus")[-1] > prediction(k, n, "plus")[-1]
    print("All exact mode sums and sampled formal branch inequalities passed.")


if __name__ == "__main__":
    main()
