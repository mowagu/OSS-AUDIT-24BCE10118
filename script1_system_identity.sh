#!/bin/bash
# Script 1: System Identity Report
# Author: Arpit Raj Singh | Course: Open Source Software
# Purpose: Display a formatted system information screen for the Linux Kernel audit

# --- Student information (fill these in before submission) ---
STUDENT_NAME="Arpit Raj Singh"
SOFTWARE_CHOICE="Linux Kernel"

# --- Collect system information using command substitution ---
KERNEL=$(uname -r)                          # Running kernel version
ARCH=$(uname -m)                            # CPU architecture (e.g. x86_64)
USER_NAME=$(whoami)                         # Current logged-in user
HOME_DIR=$HOME                              # User's home directory
UPTIME=$(uptime -p)                         # Human-readable uptime
CURRENT_DATE=$(date '+%A, %d %B %Y %H:%M') # Formatted date and time

# --- Get distro name from /etc/os-release if it exists ---
if [ -f /etc/os-release ]; then
    source /etc/os-release
    DISTRO="$NAME $VERSION_ID"
else
    DISTRO="Unknown Linux Distribution"
fi

# --- Display formatted output using echo ---
echo "========================================================"
echo "         OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT"
echo "========================================================"
echo "  Student     : $STUDENT_NAME"
echo "  Software    : $SOFTWARE_CHOICE"
echo "========================================================"
echo "  Distribution: $DISTRO"
echo "  Kernel Ver  : $KERNEL"
echo "  Architecture: $ARCH"
echo "  User        : $USER_NAME"
echo "  Home Dir    : $HOME_DIR"
echo "  Uptime      : $UPTIME"
echo "  Date/Time   : $CURRENT_DATE"
echo "========================================================"
echo "  License     : GNU General Public License v2.0 (GPL-2.0)"
echo "  Kernel Src  : https://kernel.org"
echo "========================================================"
