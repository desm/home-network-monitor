#!/usr/bin/env bash

# Start MariaDB
/usr/local/bin/docker-entrypoint.sh mariadbd &

# Start the monitoring process
/root/main.sh &

# Wait for all background processes to finish
wait
