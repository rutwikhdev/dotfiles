#!/bin/bash

# Target date
TARGET_DATE="2026-01-24"

# Get today's date and target date in seconds
TODAY=$(date +%s)
TARGET=$(date -d "$TARGET_DATE" +%s)

# Calculate the difference in days
DIFF=$(( (TARGET - TODAY) / 86400 ))

# Output just "X days"
echo "$DIFF days"

