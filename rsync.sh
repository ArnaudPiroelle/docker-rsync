#!/bin/bash
echo -e "======================================" 
echo -e "=      Synchronisation started       =" 
echo -e "======================================"

# Add Remote key in known hosts
ssh-keyscan $SSH_ADDRESS >> ~/.ssh/known_hosts

rsync $RSYNC_OPTS /sync "$SSH_USER@$SSH_ADDRESS:$REMOTE_FOLDER"