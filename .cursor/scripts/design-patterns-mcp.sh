#!/bin/sh
AGENTS_TOOLS_DIR="${AGENTS_TOOLS_DIR:-$HOME/.agents}"
exec env DATABASE_PATH="$AGENTS_TOOLS_DIR/design_patterns_mcp/data/design-patterns.db" \
	node "$AGENTS_TOOLS_DIR/design_patterns_mcp/dist/mcp-server.js"
