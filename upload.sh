#!/bin/bash
# Configuration
OWNER="ziauddin-sayyed"
REPO="attRead_2af3e4fda3ee6d9917c11eda549d07c1"
BRANCH="main"  # or your branch name
FILE_PATH="attendance.csv"
COMMIT_MESSAGE="Add new file"
PAT="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"

# File content (base64 encoded)
CONTENT=$(base64 -i "attendance.csv")
LOCAL_FILE=attendance.csv


TEMP_FILE=$(mktemp)

# Create the JSON payload with base64 content
cat > "$TEMP_FILE" << EOF
{
  "message": "$COMMIT_MESSAGE",
  "content": "$(base64 -w 0 "$LOCAL_FILE")",
  "branch": "$BRANCH"
}
EOF

# API request using the temporary file
curl -L \
  -X PUT \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $PAT" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -H "Content-Type: application/json" \
  "https://api.github.com/repos/$OWNER/$REPO/contents/$FILE_PATH" \
  -d @"$TEMP_FILE"

# Clean up
rm -f "$TEMP_FILE"
