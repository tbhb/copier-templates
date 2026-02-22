set shell := ['uv', 'run', '--frozen', 'bash', '-euxo', 'pipefail', '-c']
set unstable
set positional-arguments

project := "copier-templates"
pnpm := "pnpm exec"

# List available recipes
default:
  @just --list

# Clean build artifacts
clean:
  #!/usr/bin/env bash
  find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
  find . -type d -name .pytest_cache -exec rm -rf {} + 2>/dev/null || true
  find . -type d -name .ruff_cache -exec rm -rf {} + 2>/dev/null || true
  find . -type d -name node_modules -not -path "./node_modules" -exec rm -rf {} + 2>/dev/null || true

# Format code
format:
  codespell -w
  ruff format .
  {{pnpm}} biome format --write .

# Fix code issues
fix:
  ruff format .
  ruff check --fix .
  {{pnpm}} biome format --write .
  {{pnpm}} biome check --write .

# Fix code issues including unsafe fixes
fix-unsafe:
  ruff format .
  ruff check --fix --unsafe-fixes .
  {{pnpm}} biome check --write --unsafe

# Run all linters
lint: lint-style lint-docs lint-config lint-shell lint-spelling

# Lint configuration files
lint-config: lint-json lint-yaml

# Lint shell scripts
lint-shell:
  #!/usr/bin/env bash
  if compgen -G "templates/**/.devcontainer/*.sh" > /dev/null; then
    shellcheck templates/**/.devcontainer/*.sh
  fi

# Lint documentation
lint-docs *args:
  just lint-markdown {{ args }}
  just lint-prose {{ args }}

# Lint JSON files
lint-json:
  {{pnpm}} biome check --files-ignore-unknown=true .

# Lint Markdown files
lint-markdown *args:
  {{pnpm}} markdownlint-cli2 {{ if args == "" { '"**/*.md" "#templates/**/docs/**"' } else { args } }}

# Lint code style (ruff)
lint-style:
  ruff check .
  ruff format --check .

# Lint prose in Markdown files
lint-prose *args:
  vale {{ if args == "" { "README.md" } else { args } }}

# Check spelling
lint-spelling:
  codespell

# Lint YAML files
lint-yaml:
  yamllint --strict .

# Install all dependencies (Python + Node.js)
install: install-node install-python

# Install only Node.js dependencies
install-node:
  #!/usr/bin/env bash
  pnpm install --frozen-lockfile

# Install only Python dependencies
install-python:
  #!/usr/bin/env bash
  uv sync --frozen

# Run pre-commit hooks on changed files
prek:
  prek

# Run pre-commit hooks on all files
prek-all:
  prek run --all-files

# Install pre-commit hooks
prek-install:
  prek install

# Sync Vale styles and dictionaries
vale-sync:
  vale sync

# ------------------------------------------------------------------------------
# Template Testing
# ------------------------------------------------------------------------------

# Test all templates
test-templates: (test-template "python-tool") (test-template "python-library") (test-template "python-monorepo") (test-template "base")

# Test a specific template
[script]
test-template template:
  set -euo pipefail
  echo "Testing template: {{template}}"
  TEMP_DIR=$(mktemp -d)
  trap 'rm -rf "$TEMP_DIR"' EXIT

  uv run copier copy --defaults --trust \
    --data project_name="testproject" \
    --data project_slug="testproject" \
    --data project_module="testproject" \
    --data project_description="A test project for template validation" \
    --data keywords="test,template,validation" \
    "templates/{{template}}" "$TEMP_DIR/test-project"

  cd "$TEMP_DIR/test-project"
  just install
  just lint
  just --summary | grep -qw test && just test || echo "Skipping test (no recipe)"
  just --summary | grep -qw build-docs && CI=false just build-docs || echo "Skipping build-docs (no recipe)"
  echo "Template {{template}} passed all tests!"
