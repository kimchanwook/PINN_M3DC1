# Python implementation

The Python tree mirrors the MATLAB tree by module number, case contract, test
intent, and output naming. Python is expected to be the primary PINN training
environment. MATLAB remains an independent numerical cross-check rather than a
line-by-line translation.

From this directory:

```bash
python -m unittest discover -s tests -v
python cases/run_backbone_demo.py
```

The current modules are interface scaffolds. A successful smoke test does not
mean that the reduced-MHD solver or neural surrogates have been implemented.

