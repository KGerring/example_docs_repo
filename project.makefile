#!/bin/bash

# Set repo name
REPO_NAME="example_docs_repo"
GIT_URL="https://github.com/KGerring/${REPO_NAME}.git"

# Create directory structure
mkdir -p ${REPO_NAME}/{myproject,myproject/docs/_static,myproject/docs/_templates,myproject/tests}
cd ${REPO_NAME}

# Create README
cat <<EOF > README.md
# MyProject

A Python project with Sphinx auto-documentation support.

## Features

- Markdown + Notebooks via myst-parser and myst-nb
- CLI docs using sphinx-click
- Autosummary + Copy Button
- Live-reloading with sphinx-autobuild
EOF

# Create pyproject.toml with uv + hatchling
cat <<EOF > pyproject.toml
[project]
name = "myproject"
version = "0.1.0"
description = "A Python project with Sphinx docs and CLI"
dependencies = ["click"]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"
EOF

# Create core.py
cat <<EOF > myproject/core.py
def greet(name: str) -> str:
    \"\"\"Return a greeting for the given name.\"\"\"
    return f"Hello, {name}!"
EOF

# Create cli.py
cat <<EOF > myproject/cli.py
import click
from .core import greet

@click.command()
@click.argument("name")
def main(name):
    \"\"\"Simple greeter CLI.\"\"\"
    click.echo(greet(name))
EOF

# Create __init__.py
touch myproject/__init__.py

# Create test file
cat <<EOF > tests/test_core.py
from myproject.core import greet

def test_greet():
    assert greet("World") == "Hello, World!"
EOF

# Create conf.py
cat <<EOF > myproject/docs/conf.py
import os
import sys
from datetime import datetime

sys.path.insert(0, os.path.abspath(".."))

project = "MyProject"
author = "Your Name"
copyright = f"{datetime.now().year}, {author}"
release = "0.1.0"

extensions = [
    "myst_parser",
    "myst_nb",
    "sphinx.ext.autodoc",
    "sphinx.ext.autosummary",
    "sphinx.ext.todo",
    "sphinx.ext.viewcode",
    "sphinx.ext.napoleon",
    "sphinx_click.ext",
    "sphinx_copybutton",
]

autosummary_generate = True
autodoc_default_options = {
    "members": True,
    "undoc-members": True,
    "show-inheritance": True,
}

templates_path = ["_templates"]
exclude_patterns = ["_build", "**.ipynb_checkpoints"]
html_theme = "furo"
html_static_path = ["_static"]
todo_include_todos = True

myst_enable_extensions = [
    "colon_fence",
    "deflist",
    "html_image",
    "substitution",
    "replacements",
]
myst_heading_anchors = 3

nb_execution_mode = "off"
copybutton_prompt_text = r">>> |\\.\\.\\. "
copybutton_prompt_is_regexp = True
EOF

# Create index.rst
cat <<EOF > myproject/docs/index.rst
Welcome to MyProject's documentation!
=====================================

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   api
   cli

.. todolist::
EOF

# Create api.rst
cat <<EOF > myproject/docs/api.rst
API Reference
=============

.. autosummary::
   :toctree: _autosummary
   :recursive:

   myproject.core
EOF

# Create cli.rst
cat <<EOF > myproject/docs/cli.rst
CLI Reference
=============

.. click:: myproject.cli:main
   :prog: myproject
   :nested: full
EOF

# Create Sphinx requirements file
cat <<EOF > myproject/docs/requirements.txt
sphinx
myst-parser
myst-nb
sphinx-autobuild
sphinx-copybutton
sphinx-click
furo
EOF

# Init git and push
git init
git remote add origin ${GIT_URL}
git add .
git commit -m "Initial commit: Sphinx doc scaffold with myst, click, todos"
git branch -M main
git push -u origin main

echo "✅ Repo initialized and pushed to: ${GIT_URL}"
