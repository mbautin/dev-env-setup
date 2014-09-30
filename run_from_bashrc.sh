#!/bin/bash

# This should be invoked from ~/.bashrc.

# -------------------------------------------------------------------------------- 
# gitprompt configuration
# -------------------------------------------------------------------------------- 

# Set config variables first
GIT_PROMPT_ONLY_IN_REPO=0

# GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status

GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_ ${White}${HOSTNAME%%.*}:${Yellow}${PathShort}${ResetColor}"

# GIT_PROMPT_END=...      # uncomment for custom prompt end sequence

# as last entry source the gitprompt script
export _DEV_ENV_SETUP_DIR=$( dirname "${BASH_SOURCE}" )
source $_DEV_ENV_SETUP_DIR/bash-git-prompt/gitprompt.sh


