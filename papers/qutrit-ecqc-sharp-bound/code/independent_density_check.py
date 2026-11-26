#!/usr/bin/env python3
"""Independent 9x9 density-matrix/Born-projector checks (numerical only).

Does not import the exact ring checker. The maximally entangled negative
control detects accidental replacement of same bases by conjugate bases.
"""
from pathlib import Path
import argparse
import json
import numpy as np


def entropy(values):
    values = np.asarray(values, dtype=float)
    assert values.min(initial=0) >= -2e-12
    positive = values[values > 1e-14]
    return float(-np.dot(positive, np.log2(positive)))


def marginals(rho):
    tensor = rho.reshape(3, 3, 3, 3)
    return np.trace(tensor, axis1=1, axis2=3), np.trace(tensor, axis1=0, axis2=2)


def quantum_information(rho):
    ra, rb = marginals(rho)
    return (entropy(np.linalg.eigvalsh(ra)) + entropy(np.linalg.eigvalsh(rb))
            - entropy(np.linalg.eigvalsh(rho)))


def basis_list():
    omega = np.exp(2j*np.pi/3)
    return [np.eye(3, dtype=complex)] + [
        np.array([[omega**((b*x*x+k*x) % 3) for k in range(3)]
                  for x in range(3)])/np.sqrt(3) for b in (0, 2, 1)]


def born_table(rho, basis, conjugate_bob=False):
    bob = basis.conj() if conjugate_bob else basis
    p = np.zeros((3, 3))
    for i in range(3):
        a = np.outer(basis[:, i], basis[:, i].conj())
        for j in range(3):
            b = np.outer(bob[:, j], bob[:, j].conj())
            value = np.trace(rho @ np.kron(a, b))
            assert abs(value.imag) < 2e-12
            p[i, j] = value.real
    assert abs(p.sum()-1) < 2e-12
    assert p.min() > -2e-12
    return p


def score(rho, conjugate_bob=False):
    infos = []
    tables = []
    for basis in basis_list():
        p = born_table(rho, basis, conjugate_bob)
        infos.append(entropy(p.sum(axis=0)) + entropy(p.sum(axis=1)) - entropy(p.ravel()))
        tables.append(p.tolist())
    j = sum(sorted(infos)[:3])
    q = quantum_information(rho)
    return {'I_bits': infos, 'J_bits': j, 'Q_bits': q, 'gap_bits': j-q,
            'tables': tables}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    psi = np.array([0, .5, .5, -.5, 0, 0, -.5, 0, 0], dtype=complex)
    pure = np.outer(psi, psi.conj())
    witness = score(pure)
    assert np.allclose(witness['I_bits'], 1, atol=2e-12, rtol=0)
    assert abs(witness['Q_bits']-2) < 2e-12
    assert abs(witness['gap_bits']-1) < 2e-12

    product = np.zeros(9, dtype=complex); product[0] = 1
    product_result = score(np.outer(product, product.conj()))
    assert np.allclose(product_result['I_bits'], 0, atol=2e-12, rtol=0)
    phi = np.eye(3).reshape(9)/np.sqrt(3)
    phi_density = np.outer(phi, phi.conj())
    phi_result = score(phi_density)
    assert np.allclose(phi_result['I_bits'], [np.log2(3),np.log2(3),0,0], atol=2e-12, rtol=0)
    changed_convention = score(phi_density, conjugate_bob=True)
    assert np.allclose(changed_convention['I_bits'], np.log2(3), atol=2e-12, rtol=0)
    assert phi_result['gap_bits'] < 0 < changed_convention['gap_bits']

    noise = []
    for t in (0, .5, .6578, .6580, 2/3, .9, 1):
        rho = t*pure + (1-t)*np.eye(9)/9
        row = score(rho)
        row.pop('tables')
        row['visibility'] = t
        row['minimum_eigenvalue'] = float(np.linalg.eigvalsh(rho).min())
        noise.append(row)
    assert noise[2]['gap_bits'] < 0 < noise[3]['gap_bits']
    assert noise[4]['minimum_eigenvalue'] > 0

    result = {'status':'PASS', 'method':'direct density matrices and Born projectors',
              'numpy_version': np.__version__, 'tolerance':2e-12,
              'witness':witness, 'product_negative_control':product_result,
              'maximally_entangled_same_basis_control':phi_result,
              'changed_conjugate_basis_control':changed_convention,
              'noise_points':noise,
              'scope':'Numerical independent cross-check, not a proof over continuous state space.'}
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k in ('status','method','numpy_version','scope')},indent=2))


if __name__ == '__main__':
    main()
