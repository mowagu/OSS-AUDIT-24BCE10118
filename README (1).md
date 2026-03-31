# OSS Audit — Linux Kernel
**Course:** Open Source Software | OSS NGMC  
**Student Name:** Shresth bhargava
**Registration Number:** 24BSA10161  
**Chosen Software:** Linux Kernel (GPL v2)

---

## Scripts

### Script 1 — System Identity Report (`script1_system_identity.sh`)
Displays a formatted welcome screen showing kernel version, distro, user, uptime, and license info.  
**Run:** `bash script1_system_identity.sh`  
**Concepts:** variables, command substitution `$()`, echo formatting

### Script 2 — FOSS Package Inspector (`script2_package_inspector.sh`)
Checks if the Linux kernel package is installed, shows version/status, and prints a philosophy note.  
**Run:** `bash script2_package_inspector.sh`  
**Concepts:** if-then-else, case statement, dpkg-query/rpm, grep

### Script 3 — Disk and Permission Auditor (`script3_disk_auditor.sh`)
Loops through key system directories and reports permissions, owner, and disk usage.  
**Run:** `bash script3_disk_auditor.sh`  
**Concepts:** for loop, ls -ld, du, awk, arrays

### Script 4 — Log File Analyzer (`script4_log_analyzer.sh`)
Reads a log file line by line, counts keyword matches, and prints the last 5 matching lines.  
**Run:** `bash script4_log_analyzer.sh /var/log/kern.log error`  
**Concepts:** while-read loop, if-then, counter variables, command-line arguments

### Script 5 — Open Source Manifesto Generator (`script5_manifesto_generator.sh`)
Asks 4 interactive questions and generates a personalised open source philosophy statement saved to a `.txt` file.  
**Run:** `bash script5_manifesto_generator.sh`  
**Concepts:** read, heredoc, string concatenation, date command, file writing

---

## Dependencies
- Bash (pre-installed on all Linux systems)
- `dpkg-query` (Debian/Ubuntu) or `rpm` (Fedora/RHEL) for Script 2
- No external packages required

## How to Run
```bash
git clone https://github.com/shresthbhargava/oss-audit-24BSA10161
cd oss-audit-24BSA10161
chmod +x *.sh        # make all scripts executable
bash script1_system_identity.sh
```
