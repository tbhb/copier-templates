# Copier Templates

Personal project templates for [Copier](https://copier.readthedocs.io/).

## Templates

### python-tool

A template for Python CLI tools and libraries with:

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

## Usage

```bash
# Install copier
pipx install copier

# Create a new project
copier copy gh:tbhb/copier-templates/templates/python-tool my-project

# Or from a local clone
copier copy ~/Code/github.com/tbhb/copier-templates/templates/python-tool my-project
```

## Questions

The python-tool template asks for:

| Variable | Description | Default |
|----------|-------------|---------|
| `project_name` | Human-readable name | Required |
| `project_slug` | Package name (hyphenated) | Derived from name |
| `project_module` | Python module name | Derived from slug |
| `project_description` | One-line description | Required |
| `copyright_year` | Copyright year | 2026 |
| `python_version` | Minimum Python version | 3.13 |
| `include_docs` | Include MkDocs | true |
| `include_github_actions` | Include CI/CD | true |
| `include_cloudflare` | Include Wrangler | true |

## Author

Tony Burns ([@tbhb](https://github.com/tbhb))

## License

MIT
