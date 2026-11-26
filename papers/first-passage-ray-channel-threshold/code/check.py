"""Small-dimensional blind reconstruction checks in a real Pauli basis."""
from pathlib import Path
import json
import numpy as np

I = np.eye(2, dtype=complex)
X = np.array([[0,1],[1,0]], dtype=complex)
Y = np.array([[0,-1j],[1j,0]])
Z = np.diag([1,-1]).astype(complex)
P = np.array([I, X, Y, Z])
freqs = np.array([0.2, 0.9, 2.0, 5.7])


def pos(matrix):
    return np.array([np.trace(x @ matrix).real / 2 for x in P])


def A_matrix(G, H):
    return np.column_stack([pos((G@x + x@G)/2 - 1j*(H@x - x@H)) for x in P])


def recover_rank_one():
    change = np.eye(2) + np.full((2,2), 0.1)
    Q = change @ np.diag([2+1j,4+2j]) @ np.linalg.inv(change)
    G = Q + Q.conj().T
    H = (Q-Q.conj().T)/2j - np.trace((Q-Q.conj().T)/2j)*I/2
    expected = A_matrix(G, H)
    assert np.linalg.eigvalsh(G)[0] > 0
    q = [0.53, 7.1, 0.9, 2.9]
    B = np.column_stack([np.linalg.solve(expected+u*np.eye(4), pos(G))*s for u,s in zip(freqs,q)])
    assert np.linalg.matrix_rank(B) == 4
    U = (B * freqs) @ np.linalg.inv(B)
    direction = U[:,0]
    direction /= np.linalg.norm(direction)
    proj = np.eye(4) - np.outer(direction,direction)
    physical_params = [A_matrix(x, 0*I) for x in P] + [A_matrix(0*I,x) for x in P[1:]]
    lhs = np.column_stack([(proj @ v @ B).ravel() for v in physical_params])
    rhs = -(proj @ (B*freqs)).ravel()
    theta, _, rank, _ = np.linalg.lstsq(lhs,rhs,rcond=None)
    reconstructed = sum(v*c for v,c in zip(physical_params,theta))
    err = np.max(np.abs(reconstructed-expected))
    assert rank == 7
    assert err < 1e-10
    return {"effect_span_rank": int(np.linalg.matrix_rank(B)), "drift_max_error": float(err)}


def scalar_singular():
    gam = 1.41
    A = A_matrix(gam*I, 0.62*Z)
    pin = np.diag([1,1,0,0])  # adjoint dephasing in the X eigenbasis
    rs = [(u+gam)*np.linalg.solve(A+u*np.eye(4),pin) for u in freqs]
    s,t = freqs[:2]
    i,j = [r[:,1] for r in rs[:2]]
    recover = ((s+t)*(i@j)-t*(i@i)-s*(j@j))/np.linalg.norm(i-j)**2
    assert abs(recover-gam) < 1e-10
    F = [r * gam/(u+gam) for r,u in zip(rs,freqs)]
    observed = np.concatenate([r-F[0] for r in F[1:]],axis=1)
    assert np.linalg.matrix_rank(observed)==3
    return {"jump_map_linear_rank": 2, "observable_subspace_rank": 3,
            "true_rate": gam, "recovered_rate": float(recover)}


if __name__ == "__main__":
    output = {"nonscalar_rank_one": recover_rank_one(), "scalar_singular": scalar_singular()}
    Path(__file__).with_name("checks.json").write_text(json.dumps(output, indent=2)+"\n")
