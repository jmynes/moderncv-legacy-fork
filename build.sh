#!/bin/bash
# Build script for resume - uses local moderncv to avoid system package conflict
# The system's moderncv v2.4.1 uses fontawesome5 which conflicts with our fontawesome v4
#
# Usage: ./build.sh [output-name]
# Examples:
#   ./build.sh                    # Creates workbench/resume.pdf
#   ./build.sh MyResume           # Creates output/MyResume.pdf

set -e

cd "$(dirname "$0")/workbench"

if [ -n "$1" ]; then
    # Output to output/ directory with custom name
    TEXINPUTS=".:..:" xelatex -interaction=nonstopmode -jobname="$1" -output-directory=../output resume.tex
    echo ""
    echo "Build complete: output/$1.pdf"
else
    # Output to workbench/ with default name
    TEXINPUTS=".:..:" xelatex -interaction=nonstopmode resume.tex
    echo ""
    echo "Build complete: workbench/resume.pdf"
fi
