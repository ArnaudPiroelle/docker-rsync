#!/bin/bash
echo -e "======================================" 
echo -e "=      Synchronisation started       =" 
echo -e "======================================"

rsync $RSYNC_OPTS /sync/ "$SSH_USER@$SSH_ADDRESS:$REMOTE_FOLDER" > /rsync/logs/progress.log