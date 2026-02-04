# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Copier templates repository containing project templates for bootstrapping new Python projects. Templates use Jinja2 for templating with `.jinja` file extensions.

## Templates

### python-tool

A template for Python CLI tools and libraries. Located at `templates/python-tool/`.

**Key template variables** (defined in `copier.yaml`):

- `project_name` - Human-readable name
- `project_slug` - Package name (hyphenated, derived from name)
- `project_module` - Python module name (underscores, derived from slug)
- `project_description` - One-line description
- `python_version` - 3.12 or 3.13
- `include_docs`, `include_github_actions`, `include_cloudflare` - Optional features

**Generated project tooling:**

- `uv` for Python package management
- `pnpm` for Node.js tooling (Biome, markdownlint)
- `just` for task automation
- `ruff` for linting/formatting, `basedpyright` for type checking
- `pytest` for testing with coverage and benchmarking

## Development Commands

Templates generate a Justfile with these key commands:

```bash
just install          # Install Python + Node dependencies
just lint             # Run all linters
just lint-python      # Python linting (imports, style, types, complexity)
just test             # Run tests (excludes benchmarks/slow)
just test-coverage    # Tests with coverage report
just format           # Format code (codespell, ruff, biome)
just fix              # Fix code issues
just build            # Build distribution packages
just dev-docs         # Serve docs locally on port 8000
```

## Template File Conventions

- `.jinja` extension indicates Jinja2 template files
- Template variables use `{{ variable }}` syntax
- Use `{% raw %}...{% endraw %}` to escape Jinja syntax in generated files (e.g., in Justfile)
- Copier configuration is in `copier.yaml` at each template root

## Architecture

```text
copier-templates/
├── templates/
│   └── python-tool/           # Main template
│       ├── copier.yaml        # Template config and questions
│       ├── src/{{project_module}}/  # Source with variable directory name
│       ├── tests/             # Test structure
│       ├── docs/              # MkDocs documentation
│       ├── .github/workflows/ # CI/CD workflows
│       ├── .devcontainer/     # DevContainer config
│       ├── Justfile.jinja     # Task definitions
│       └── pyproject.toml.jinja
└── README.md
```

## Testing Templates

To test a template locally:

```bash
copier copy templates/python-tool /tmp/test-project
cd /tmp/test-project
just install
just lint
just test
```
