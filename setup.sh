#!/bin/bash
# Setup script for Resume LaTeX Template
# Supports Debian/Ubuntu (apt) and Fedora (dnf)

set -e

echo "=== Resume LaTeX Template Setup ==="
echo

# Install dependencies
if command -v apt-get >/dev/null; then
    echo "Installing TeX Live packages via apt (requires sudo)..."
    sudo apt-get update
    sudo apt-get install -y texlive-latex-base texlive-latex-extra texlive-fonts-extra texlive-xetex
elif command -v dnf >/dev/null; then
    echo "Installing TeX Live packages via dnf (requires sudo)..."
    sudo dnf install -y texlive-xetex texlive-collection-latexrecommended texlive-collection-fontsrecommended \
        texlive-fontawesome texlive-inconsolata texlive-marvosym texlive-upquote

    # Fedora doesn't expose TeX Live fonts to fontconfig, so XeLaTeX (fontspec) can't find FontAwesome
    echo "Registering FontAwesome with fontconfig..."
    mkdir -p ~/.local/share/fonts
    ln -sf /usr/share/texlive/texmf-dist/fonts/opentype/public/fontawesome/FontAwesome.otf ~/.local/share/fonts/
    fc-cache -f ~/.local/share/fonts >/dev/null
else
    echo "Unsupported package manager: install XeLaTeX and the packages listed in README.md manually." >&2
    exit 1
fi

echo
echo "Creating workbench and output directories..."
mkdir -p workbench output

if [ -e workbench/resume.tex ] || [ -e workbench/docstyle.sty ]; then
    echo "Workbench already has resume files, leaving them untouched."
else
    echo "Copying sample files to workbench..."
    cp sample/sample-resume.tex workbench/resume.tex
    cp sample/sample-docstyle.sty workbench/docstyle.sty

    echo "Fixing docstyle reference..."
    sed -i 's/sample-docstyle/docstyle/' workbench/resume.tex
fi

echo "Creating moderncv symlink..."
ln -sfn ../moderncv workbench/moderncv

echo
echo "=== Setup complete! ==="
echo
echo "Next steps:"
echo "  1. Edit workbench/docstyle.sty with your personal info"
echo "  2. Edit workbench/resume.tex with your experience"
echo "  3. Compile with: ./build.sh MyResume"
echo
echo "Your PDF will be at: output/MyResume.pdf"
