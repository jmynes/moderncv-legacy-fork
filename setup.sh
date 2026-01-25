#!/bin/bash
# Setup script for Resume LaTeX Template

set -e

echo "=== Resume LaTeX Template Setup ==="
echo

# Install dependencies
echo "Installing TeX Live packages (requires sudo)..."
sudo apt-get update
sudo apt-get install -y texlive-latex-base texlive-latex-extra texlive-fonts-extra texlive-xetex

echo
echo "Creating workbench and output directories..."
mkdir -p workbench output

echo "Copying sample files to workbench..."
cp sample/sample-resume.tex workbench/resume.tex
cp sample/sample-docstyle.sty workbench/docstyle.sty

echo "Creating moderncv symlink..."
ln -sf ../moderncv workbench/moderncv

echo "Fixing docstyle reference..."
sed -i 's/sample-docstyle/docstyle/' workbench/resume.tex

echo
echo "=== Setup complete! ==="
echo
echo "Next steps:"
echo "  1. Edit workbench/docstyle.sty with your personal info"
echo "  2. Edit workbench/resume.tex with your experience"
echo "  3. Compile with: ./build.sh MyResume"
echo
echo "Your PDF will be at: output/MyResume.pdf"
