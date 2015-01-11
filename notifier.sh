#!/bin/bash

# Crontab interval values
crontab_interval_minute="*"          # Every 15 minutes
crontab_interval_hour="*"               # Every hour
crontab_interval_day_of_month="*"       # Every day of the month
crontab_interval_month="*"              # Every month
crontab_interval_day_of_week="*"        # Every day

# Functions
function getHeadRevision () {
    #Get parameters
    local __resultvar=$1

    eval $__resultvar=$(svn info $local_working_copy -rHEAD | grep Revision | cut -d' ' -f2)
}

function getWorkingCopyRevision () {
    # Get parameters
    local __resultvar=$1

    eval $__resultvar=$(svn info $local_working_copy | grep Revision | cut -d' ' -f2)
}

function add () {
    # Get parameters
    local __wcLocation=$1
    local __wcMessage=$2

    # Create a new crontab
    crontab -l > svn_notifier_crontab

    # Echo new cron into cron file
    echo "$crontab_interval_minute  $crontab_interval_hour  $crontab_interval_day_of_month  $crontab_interval_month     $crontab_interval_day_of_week   svn-notifier-wc \"$local_working_copy\" \"$__wcMessage\"" >> svn_notifier_crontab

    # Install new cron file
    crontab svn_notifier_crontab

    # Remove temporary cron file
    rm svn_notifier_crontab

    exit
}

function notify () {
    getHeadRevision __headRevision
    getWorkingCopyRevision __wcRevision

    if [ "$__wcRevision" -lt "$__headRevision" ]
        then
            terminal-notifier -message "$wcMessage" -title "Working Copy Outdated"
    fi
}

if [ "$1" = "add" ]
    then
        local_working_copy=$2
        __wcMessage=$3
        add $local_working_copy $__wcMessage
    else
        local_working_copy=$1
        wcMessage=$2
        notify
fi
