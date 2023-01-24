#!/bin/bash

# CRONTAB SCHEDULE
# SHELL=/bin/bash
#
# */2 * * * * /home/PowerStatusBot/startup_script.sh > /tmp/startup_script.log 2>&1

# VARIABLES
DIR="/home/powerstatus_bot/"

killall python3
python3 ${DIR}/novopower_bot.py &
cp ~/current_status.log ${DIR}
