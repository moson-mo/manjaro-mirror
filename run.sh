#!/bin/bash

#
#   Startscript for running manjaro-mirror docker image
#   Amend default values to your needs
#   

# Name of the container
NAME="my-manjaro-mirror"

# The webservers port
PORT=80

# Local folder where the package data is stored
DATA_FOLDER="/data/packages"

# Mirror to sync from
SYNC_FROM_MIRROR="manjaro.moson.eu/repos"

# The cron pattern for when packages are synced (default: every 30 minutes)
SYNC_CRON_PATTERN="*/30 * * * *"

# User/group id of user with access to the data folder
# If blank it falls back to the root user.
LOCAL_USER_ID=1000
LOCAL_GROUP_ID=1000

# Runs in daemon mode by default, change to "it" for interactive mode
MODE="d"

if [ ! -d $DATA_FOLDER ]
then
    mkdir $DATA_FOLDER
fi

docker run \
    --rm \
    --name "$NAME" \
    -"$MODE" \
    -p "$PORT":80 \
    -v "$DATA_FOLDER":/web \
    -e USER_ID="$LOCAL_USER_ID" \
    -e GROUP_ID="$LOCAL_GROUP_ID" \
    -e SYNC_FROM="$SYNC_FROM_MIRROR" \
    -e CRON_PATTERN="$SYNC_CRON_PATTERN" \
    moson/manjaro-mirror