# example_docs_repo


```text

myproject/
├── docs/
│   ├── conf.py
│   ├── index.rst
│   ├── cli.rst
│   ├── api.rst
│   └── requirements.txt
├── myproject/
│   ├── __init__.py
│   ├── core.py
│   └── cli.py
├── tests/
│   └── test_core.py
├── README.md
└── pyproject.toml

```


> mkdir -p myproject/{myproject,tests,docs/_static,docs/_templates}
# Then copy each file below into its proper path


when dome run


```bash
sphinx-autobuild . _build/html

```
