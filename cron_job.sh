#!/usr/bin/env bash

SYSLOG_CMD="logger -i -t weather-station"
DIR="/home/joshua/Dropbox/Projects/weather-station-datasette"
LOG_NAME="log.json"
LOG_DIR="$DIR/data"

DATE=$(date '+%Y-%m-%d-%H:%M:%S')

SERVICE="rtl_433"
RUN_CMD="rtl_433 -F json:$LOG_NAME"

$($SYSLOG_CMD 'Cron job start')

if pgrep -x "$SERVICE" >/dev/null
then
    $($LOG_CMD '$SERVICE is already running. Killing')
    pkill -f -e -c $SERVICE
    $($LOG_CMD '$SERVICE killed.')
    cd $DIR
    python3 json_to_csv.py $LOG_NAME log.csv
    mv log.csv $LOG_DIR/weather-data-$DATE.csv
    rm log.json
    git add data/*.csv
    git commit -m "Automated upload on $DATE"
    git push origin main
    rm data/*.csv
fi

$($SYSLOG_CMD "$SERVICE is not running, starting")
$($RUN_CMD&)
