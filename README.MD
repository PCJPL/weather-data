


## Usage

Update this line in `cron_job.sh` to reflect the project root:

```
DIR="/home/youruser/weather-station-data"
```

Run `crontab -e` and append this line to the end:
```
*/1 * * * * /home/youruser/weather-data/cron_job.sh
```

