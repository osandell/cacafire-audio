#!/usr/bin/env bash

# Function to clean up and exit
cleanup() {
    echo "Stopping playback and Cacafire..."
    pkill -P $$ # Kill all child processes started by this script
    exit 0
}

# Trap SIGINT (Ctrl+C) to call cleanup
trap cleanup SIGINT

# Get the directory of the script, resolving symlinks
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}" || echo "${BASH_SOURCE[0]}")")" && pwd)"

# Start the MP3 playback in the background, suppressing output
ffplay -nodisp -loop 0 "$SCRIPT_DIR/fireplace.mp3" &>/dev/null &

# Run cacafire in the foreground
cacafire

# Cleanup when cacafire exits
cleanup
