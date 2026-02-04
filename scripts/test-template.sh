#!/usr/bin/env bash
# Test a Copier template by generating a project and running all checks
#
# Usage: ./scripts/test-template.sh <template-name>
# Example: ./scripts/test-template.sh python-library

set -euo pipefail

TEMPLATE_NAME="${1:-}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

if [[ -z "$TEMPLATE_NAME" ]]; then
    echo "Usage: $0 <template-name>"
    echo "Available templates:"
    for dir in "$REPO_ROOT/templates/"*/; do
        echo "  - $(basename "$dir")"
    done
    exit 1
fi

TEMPLATE_DIR="$REPO_ROOT/templates/$TEMPLATE_NAME"

if [[ ! -d "$TEMPLATE_DIR" ]]; then
    echo "Error: Template '$TEMPLATE_NAME' not found at $TEMPLATE_DIR"
    exit 1
fi

# Create temporary directory for test project
TEST_DIR=$(mktemp -d)
trap 'rm -rf "$TEST_DIR"' EXIT

echo "=== Testing template: $TEMPLATE_NAME ==="
echo "Template: $TEMPLATE_DIR"
echo "Test directory: $TEST_DIR"
echo ""

# Generate project from template
echo ">>> Generating project from template..."
copier copy --defaults --trust \
    --data project_name="testproject" \
    --data project_slug="testproject" \
    --data project_module="testproject" \
    --data project_description="A test project for template validation" \
    --data keywords="test,template,validation" \
    "$TEMPLATE_DIR" "$TEST_DIR"

cd "$TEST_DIR"

echo ""
echo ">>> Running lints..."
just lint

echo ""
echo ">>> Running tests..."
just test

echo ""
echo ">>> Building docs..."
just build-docs

echo ""
echo "=== All checks passed for $TEMPLATE_NAME ==="
