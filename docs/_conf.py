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

# Enable TODOs
todo_include_todos = True

# Myst-parser options
myst_enable_extensions = [
    "colon_fence",
    "deflist",
    "html_image",
    "substitution",
    "replacements",
]
myst_heading_anchors = 3

# Notebook rendering
nb_execution_mode = "off"

# Sphinx-copybutton
copybutton_prompt_text = r">>> |\.\.\. "
copybutton_prompt_is_regexp = True
