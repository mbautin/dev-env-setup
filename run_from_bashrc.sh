#!/bin/bash

# This should be invoked from ~/.bashrc.

# -------------------------------------------------------------------------------- 
# gitprompt configuration
# -------------------------------------------------------------------------------- 

# Set config variables first
GIT_PROMPT_ONLY_IN_REPO=1

# GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status

# GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
# GIT_PROMPT_END=...      # uncomment for custom prompt end sequence

# as last entry source the gitprompt script
source ~/.bash-git-prompt/gitprompt.sh


