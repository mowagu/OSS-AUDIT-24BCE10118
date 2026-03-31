#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: Arpit Raj Singh | Course: Open Source Software
# Purpose: Audit key system directories for permissions, ownership, and disk usage

# --- Define the list of standard directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/proc" "/sys" "/dev")

echo "============================================================"
echo "             DISK AND PERMISSION AUDIT REPORT"
echo "============================================================"
printf "%-22s %-22s %-8s\n" "DIRECTORY" "PERMS / OWNER / GROUP" "SIZE"
echo "------------------------------------------------------------"

# --- For loop: iterate over each directory in the array ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Use awk to extract permissions, owner, group from ls -ld output
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')
        # Get human-readable size; suppress errors for virtual filesystems
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        printf "%-22s %-22s %-8s\n" "$DIR" "$PERMS" "${SIZE:-N/A}"
    else
        # Directory does not exist on this system
        printf "%-22s %s\n" "$DIR" "DOES NOT EXIST"
    fi
done

echo ""
echo "=== Linux Kernel-Specific Directory Check ==="

# --- Check directories specific to the Linux Kernel installation ---
KERNEL_DIRS=(
    "/boot"
    "/lib/modules/$(uname -r)"
    "/proc/sys/kernel"
    "/etc/modprobe.d"
)

for KDIR in "${KERNEL_DIRS[@]}"; do
    if [ -d "$KDIR" ]; then
        PERMS=$(ls -ld "$KDIR" | awk '{print $1, $3, $4}')
        SIZE=$(du -sh "$KDIR" 2>/dev/null | cut -f1)
        echo "FOUND    : $KDIR"
        echo "           Permissions: $PERMS | Size: ${SIZE:-N/A}"
    else
        echo "NOT FOUND: $KDIR"
    fi
    echo ""
done

# --- Display currently running kernel version as a summary ---
echo "=== Currently Running Kernel ==="
echo "Version      : $(uname -r)"
echo "Architecture : $(uname -m)"
echo "Boot image   : /boot/vmlinuz-$(uname -r)"
