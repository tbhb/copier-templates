#!/usr/bin/env bash
# Test all Copier templates
#
# Usage: ./scripts/test-all-templates.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

FAILED=0
PASSED=0

for template_dir in "$REPO_ROOT/templates/"*/; do
    template_name=$(basename "$template_dir")
    echo ""
    echo "========================================"
    echo "Testing template: $template_name"
    echo "========================================"

    if "$SCRIPT_DIR/test-template.sh" "$template_name"; then
        ((PASSED++))
    else
        ((FAILED++))
        echo "FAILED: $template_name"
    fi
done

echo ""
echo "========================================"
echo "Summary: $PASSED passed, $FAILED failed"
echo "========================================"

if [[ $FAILED -gt 0 ]]; then
    exit 1
fi
