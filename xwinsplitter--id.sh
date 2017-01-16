#!/bin/bash
# Description: Return window ID of an application.
TITLE=$1

if [ -z "${TITLE}" ]; then
  echo "Error: Window title can't be empty. Aborted!"
  exit 1;
fi

TARGET_WIN_ID=$(wmctrl -l | grep "${TITLE}" | cut -d' ' -f1)
echo "${TARGET_WIN_ID}"