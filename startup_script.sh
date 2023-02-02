#!/bin/bash

# CRONTAB SCHEDULE
# SHELL=/bin/bash
#
# */2 * * * * ${DIR}/startup_script.sh > /tmp/startup_script.log 2>&1

killall python3
python3 ${DIR}/novopower_bot.py "$URL" "$TOKEN" &
cp ~/current_status.log ${DIR}
