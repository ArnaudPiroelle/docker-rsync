#!/bin/bash

mkdir -p /rsync/{ssh_keys,logs}
mkdir -p ~/.ssh/

if [ ! -e /rsync/ssh_keys/id_rsa ]; then
	ssh-keygen -t rsa -N "" -f /rsync/ssh_keys/id_rsa
	# Add Remote key in known hosts
	ssh-keyscan $SSH_ADDRESS > /rsync/ssh_keys/known_hosts 2> /dev/null

	echo 'Copy/Paste this public key on the $HOME/.ssh/authorized_keys file of your user'
	echo "==================="
	cat /rsync/ssh_keys/id_rsa.pub
	echo "==================="
	exit
else
	rm -rf ~/.ssh/*
	cp /rsync/ssh_keys/* ~/.ssh/
fi

if [ -z "$SSH_USER" ]; then
	echo "No ssh user defined. Exiting."
    exit 1
fi

if [ -z "$SSH_ADDRESS" ]; then
	echo "No ssh address defined. Exiting."
	exit 1
fi

if [ -z "$REMOTE_FOLDER" ]; then
	echo "No remote folder defined. Exiting."
	exit 1
fi

RSYNC_OPTS="-ahtvrzPL --stats --size-only --partial --partial-dir=.rsync"

if [ ! -z "$BWLIMIT" ]; then
	RSYNC_OPTS="$RSYNC_OPTS --bwlimit=$BWLIMIT"
fi

if [ ! -z "$SSH_PORT" ]; then
	RSYNC_OPTS="$RSYNC_OPTS --rsh ssh -p $SSH_PORT"
else
	RSYNC_OPTS="$RSYNC_OPTS -e ssh"
fi

export RSYNC_OPTS

exec "$@"
