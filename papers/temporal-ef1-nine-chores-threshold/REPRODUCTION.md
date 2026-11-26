# Checking the finite certificate

Run the command from this project directory using Python 3. The verifier checks the exact arithmetic proof for the archived constraint problem. See the [paper](paper.en.md) for the mathematical formulation and scope.

```sh
python3 code/verify_exact_certificate.py --source results/exact-certificate-problem.txt --certificate results/exact-proof-certificate.json --report results/local-report.json --arithmetic-transcript results/local-transcript.json
```
