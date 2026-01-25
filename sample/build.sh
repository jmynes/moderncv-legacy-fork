#!/bin/bash
# Build script for resume - uses local moderncv to avoid system package conflict
# The system's moderncv v2.4.1 uses fontawesome5 which conflicts with our fontawesome v4

TEXINPUTS=".:..:" xelatex -interaction=nonstopmode resume.tex

echo ""
echo "Build complete: resume.pdf"
