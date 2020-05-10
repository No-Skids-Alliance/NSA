#!/bin/bash
source venv/bin/activate
rm -fr docs/build/html
cd docs
make html
make latexpdf
mv build/latex/noskidsallowedapentestersprimer.pdf build/html/NoSkidsAllowed.pdf
cd ..
