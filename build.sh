#!/bin/bash
source venv/bin/activate
cd docs
make html
make latexpdf
mv build/latex/noskidsallowedapentestersprimer.pdf build/html/NoSkidsAllowed.pdf
cd ..
