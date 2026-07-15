---
date_created: 2026-01-28 20:05
---

# Cron Job Line Specification
#source

**Source**:
**Author**:

# ┌───────── minute (0 - 59)

# │ ┌──────── hour (0 - 23)

# │ │ ┌─────── day of month (1 - 31)

# │ │ │ ┌────── month (1 - 12)

# │ │ │ │ ┌───── day of week (0 - 7) (Sunday=0 or 7)

# │ │ │ │ │

# │ │ │ │ │ user command

# │ │ │ │ │ ↓ ↓

0 6 \* \* 3,4 root /path/to/your/script.sh

Explanation:

- 0 6 → runs at 06:00 AM
- "\* \*" → every day of every month
- 3,4 → Wednesday (3) and Thursday (4)
- root → the user account that runs the command
- /path/to/your/script.sh → replace this with your actual script or command
