#!/bin/bash

# CRONTAB SCHEDULE
# SHELL=/bin/bash
#
# */10 * * * * ${DIR}/script_status.sh > /tmp/script_status.log 2>&1

# VARIABLES
curl=$(curl -o /dev/null -s -w "%{http_code}\n" ${URL})
process=$(ps -aux | grep -io "[p]ython3")
status_uptime=$(tail -n1 ${DIR}/logs/router.log | grep -io "UPTIME")
status_downtime=$(tail -n1 ${DIR}/logs/router.log | grep -io "DOWNTIME")
# COLOR SECTION
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [[ ${process} == "python3" ]]; then
	echo -e $(date +"%T [%Y-%m-%d]") ${GREEN}ENABLE${NC} >> ${DIR}/logs/status.log
else
	echo -e $(date +"%T [%Y-%m-%d]") ${RED}DISABLE${NC} >> ${DIR}/logs/status.log
fi

if [[ ${curl} == "200" && ${status_downtime} == "DOWNTIME" ]]; then
        echo UPTIME "->" $(date +"%T [%Y-%m-%d]") >> ${DIR}/logs/router.log
        tail -n1 ${DIR}/logs/router.log > ~/current_status.log
elif [[ ${curl} != "200" && ${status_uptime} == "UPTIME" ]]; then
        echo DOWNTIME "->" $(date +"%T [%Y-%m-%d]") >> ${DIR}/logs/router.log
        tail -n1 ${DIR}/logs/router.log > ~/current_status.log
fi
