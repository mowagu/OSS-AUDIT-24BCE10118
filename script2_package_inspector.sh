#!/bin/bash
# Script 2: FOSS Package Inspector
# Author: Arpit Raj Singh | Course: Open Source Software
# Purpose: Inspect the Linux Kernel installation and print its details and a philosophy note
 
echo "=== FOSS Package Inspector ==="
echo "Software: Linux Kernel"
echo ""
 
# --- Collect basic kernel info directly from the running system ---
KERNEL_VERSION=$(uname -r)
ARCH=$(uname -m)
 
# --- Detect environment: WSL2, native Linux (apt), or RPM-based ---
# if-then-else chain to handle all three cases
 
if uname -r | grep -qi "microsoft\|wsl"; then
    # WSL2: Microsoft's custom kernel — not a dpkg package, detected via uname
    echo "STATUS: Linux Kernel is ACTIVE on this system"
    echo ""
    echo "Environment  : WSL2 (Windows Subsystem for Linux)"
    echo "Kernel Type  : Microsoft WSL2 Linux Kernel (based on upstream Linux)"
    echo "Version      : $KERNEL_VERSION"
    echo "Architecture : $ARCH"
    echo "License      : GNU General Public License v2.0 (GPL-2.0)"
    echo "Source Code  : https://github.com/microsoft/WSL2-Linux-Kernel"
    echo ""
    echo "Note: WSL2 uses a Microsoft-built kernel based on the upstream"
    echo "      Linux Kernel. It runs as a lightweight VM inside Windows."
    echo "      GPL v2 requires Microsoft to publish the full source code."
 
elif command -v dpkg-query &>/dev/null; then
    # Native Debian/Ubuntu — look up kernel package via dpkg
    EXACT="linux-image-$KERNEL_VERSION"
 
    # Try exact package name first; fallback to any linux-image package
    if dpkg-query -W "$EXACT" &>/dev/null 2>&1; then
        PACKAGE="$EXACT"
    else
        PACKAGE=$(dpkg-query -W -f='${Package}\n' 'linux-image-*' 2>/dev/null | head -1)
    fi
 
    if [ -n "$PACKAGE" ]; then
        echo "STATUS: $PACKAGE is installed (Debian/Ubuntu)"
        echo ""
        dpkg-query -W -f='Package:   ${Package}\nVersion:   ${Version}\nStatus:    ${Status}\n' "$PACKAGE"
    else
        echo "STATUS: Kernel is running. Version: $KERNEL_VERSION"
    fi
 
elif command -v rpm &>/dev/null; then
    # RPM-based system (Fedora, RHEL, CentOS)
    if rpm -q kernel &>/dev/null 2>&1; then
        echo "STATUS: kernel is installed (RPM-based system)"
        echo ""
        rpm -qi kernel | grep -E 'Version|License|Summary|Architecture'
    else
        echo "STATUS: Kernel running. Version: $KERNEL_VERSION"
    fi
 
else
    echo "STATUS: Linux Kernel is running. Version: $KERNEL_VERSION"
fi
 
echo ""
echo "=== Open Source Philosophy Note ==="
 
# --- Case statement: philosophy note based on kernel version string ---
case "$KERNEL_VERSION" in
    *microsoft*|*Microsoft*|*WSL*|*wsl*)
        echo "Linux Kernel (WSL2): Even Microsoft ships the Linux Kernel inside Windows."
        echo "The GPL v2 required them to publish the full source — freedom enforced by law."
        echo "Source: https://github.com/microsoft/WSL2-Linux-Kernel"
        ;;
    *generic*|*lowlatency*)
        echo "Linux Kernel: The foundation on which all modern open computing rests."
        echo "Built by thousands worldwide, licensed under GPL v2 — freedom in law."
        ;;
    *)
        echo "Linux Kernel: The foundation on which all modern open computing rests."
        echo "Built by thousands worldwide, licensed under GPL v2 — freedom in law."
        echo "Every line of source code is readable at: https://kernel.org"
        ;;
esac