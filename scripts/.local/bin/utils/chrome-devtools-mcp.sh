#!/usr/bin/env bash
# Wrapper that ensures Brave is running with remote debugging before starting chrome-devtools-mcp

BRAVE="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"
PORT=9222

# NOTE: Brave must already be running with --remote-debugging-port=9222
# To start it manually: "$BRAVE" --remote-debugging-port=$PORT

NODE_DIR="/Users/erijox/.nvm/versions/node/v22.17.0/bin"
export PATH="$NODE_DIR:$PATH"
exec "$NODE_DIR/npx" -y chrome-devtools-mcp@latest
