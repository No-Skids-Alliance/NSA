![No Skids Allowed!](https://i.imgur.com/PkdLSXS.png)

## Promoting InfoSec education through documentation.

This is the source repository for the **No Skids Allowed!** website. Any corrections, suggestions, or additional content will be submitted here.

All content is provided under the [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/). For more information, see `LICENSE`.

***

## Preparing a build environment

The documentation for NSA! is generated using [Sphinx](https://www.sphinx-doc.org/). If you wish to contribute to the development of NSA! you can create your build environment with the following steps:

_Note: These instructions were written for *nix systems. Minor changes may be required for Windows users._

0. Fork this repository, then clone your fork locally.
1. Install Python 3, `virtualenv`, `texlive-formats-extra` and `latexmk`.
2. Clone the repository.
3. In the cloned repo, use `virtualenv --python=python3 venv` to create a new virtual environment.
4. When this completes, use `source venv/bin/activate` to activate the virtual environment.
5. When it's active and you see `(venv)` in the command prompt, type `pip install -r requirements.txt`.
6. To build, run the `build.sh` script. The output will be in the `build/html` directory.

### Keeping the Fork in Sync With Upstream

First, add the main repository as the `upstream` repository:

    git remote add upstream https://github.com/No-Skids-Alliance/NSA.git

With this complete, use the following steps to keep the `master` branch in sync with `upstream`:

1. Fetch upstream: `git fetch upstream`
2. Checkout `master`: `git checkout master`
3. Merge upstream: `git merge upstream/master`
4. Push the changes: `git push`
