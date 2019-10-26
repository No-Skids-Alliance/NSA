#!/bin/bash
source venv/bin/activate
cd docs
make html
make latexpdf
mv build/latex/noskidsallowed.pdf build/html/NoSkidsAllowed.pdf
cd ..
