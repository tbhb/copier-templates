# Copier Templates

Personal project templates for [Copier](https://copier.readthedocs.io/).

## Templates

### python-tool

A template for Python CLI tools with:

- [uv](https://github.com/astral-sh/uv) for Python package management
- [pnpm](https://pnpm.io/) for Node.js tooling (Biome, markdownlint)
- [Just](https://just.systems/) for task automation
- [Ruff](https://github.com/astral-sh/ruff) for linting and formatting
- [basedpyright](https://github.com/DetachHead/basedpyright) for type checking
- [pytest](https://pytest.org/) for testing with coverage
- [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) for documentation (optional)
- [GitHub Actions](https://github.com/features/actions) for CI/CD (optional)
- [Cloudflare Workers](https://workers.cloudflare.com/) for documentation hosting (optional)
- [Vale](https://vale.sh/) for prose linting

**Usage:**

```bash
copier copy gh:tbhb/copier-templates/templates/python-tool my-project
```

**Variables:**

| Variable | Description | Default |
|----------|-------------|---------|
| `project_name` | Human-readable name | Required |
| `project_slug` | Package name (hyphenated) | Derived from name |
| `project_module` | Python module name | Derived from slug |
| `project_description` | One-line description | Required |
| `copyright_year` | Copyright year | 2026 |
| `python_version` | Minimum Python version | 3.13 (choices: 3.12, 3.13) |
| `include_docs` | Include MkDocs | true |
| `include_github_actions` | Include CI/CD | true |
| `include_cloudflare` | Include Wrangler | true |

### python-library

A template for Python libraries with multi-version CI testing. Same tooling as python-tool, plus:

- **Multi-version CI matrix**: Tests on Python 3.10, 3.11, 3.12, 3.13, 3.14, and 3.14t (free-threading)
- **Multi-platform CI**: Tests on Ubuntu, Windows, and macOS
- **Full PyPI metadata**: MIT license, classifiers, keywords
- **PEP 561 typed**: Includes `py.typed` marker
- **No CLI**: Pure library (no `[project.scripts]` entry point)

**Usage:**

```bash
copier copy gh:tbhb/copier-templates/templates/python-library my-library
```

**Variables:**

| Variable | Description | Default |
|----------|-------------|---------|
| `project_name` | Human-readable name | Required |
| `project_slug` | Package name (hyphenated) | Derived from name |
| `project_module` | Python module name | Derived from slug |
| `project_description` | One-line description | Required |
| `copyright_year` | Copyright year | 2026 |
| `keywords` | Comma-separated PyPI keywords | Empty |
| `include_docs` | Include MkDocs | true |
| `include_github_actions` | Include CI/CD | true |
| `include_cloudflare` | Include Wrangler | true |

## Installation

```bash
# Install copier
uv tool install copier

# Create a new project (from GitHub)
copier copy gh:tbhb/copier-templates/templates/python-tool my-project

# Or from a local clone
copier copy ~/Code/github.com/tbhb/copier-templates/templates/python-library my-library
```

## Author

Tony Burns ([@tbhb](https://github.com/tbhb))

## License

MIT
