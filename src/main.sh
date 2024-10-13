#!/usr/bin/env bash

function install_ping() {
  apt update
  apt install -y inetutils-ping
}

function create_my_cnf_file() {
  cat <<EOD > ~/.my.cnf
[client]
user = root
password = password
EOD
}

function create_database_if_not_exists() {
  mysql <<EOD
CREATE DATABASE IF NOT EXISTS home_network_monitor;
CREATE TABLE IF NOT EXISTS home_network_monitor.ping_stats (
  id int unsigned NOT NULL AUTO_INCREMENT,
  timestamp int unsigned NOT NULL,
  status char(1) NOT NULL,
  PRIMARY KEY (id)
);
EOD
}

function do_ping() {
  ping -c 1 8.8.8.8 > /dev/null 2>&1
}

function insert_up() {
  local __timestamp=$1

  mysql -b home_network_monitor <<EOD
INSERT INTO ping_stats (timestamp, status) values ($__timestamp, 'U');
EOD
}

function insert_down() {
  local __timestamp=$1

  mysql -b home_network_monitor <<EOD
INSERT INTO ping_stats (timestamp, status) values ($__timestamp, 'D');
EOD
}

function do_ping_every_minute() {
  while : ; do
    if do_ping; then
      insert_up "$(date +%s)"
    else
      insert_down "$(date +%s)"
    fi
    sleep 60s
  done
}

function main() {
  install_ping
  create_my_cnf_file
  create_database_if_not_exists
  do_ping_every_minute
}

main
