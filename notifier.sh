#!/bin/bash

# Global vars
local_working_copy=$1

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

# Execution
getHeadRevision __headRevision
getWorkingCopyRevision __wcRevision

if [ "$__wcRevision" -lt "$__headRevision" ]
    then
        terminal-notifier -message "Werksite Development" -title "Working Copy Outdated"
fi
