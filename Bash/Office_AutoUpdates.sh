#!/bin/bash

#################### ENVIRONMENT VARIABLES #########################

# Get the currently logged in user
user=`ls -l /dev/console | cut -d " " -f4`

# Carry out the check
check=`sudo su "${user}" -c 'defaults read ~/Library/Preferences/com.microsoft.autoupdate2 HowToCheck'`

################## DO NOT MODIFY BELOW THIS LINE ####################

if [[ "$check" == "Automatic" ]]; then
echo "Microsoft Autoupdate is set to Automatic"
elif [[ "$check" == "Manual" ]]; then
echo "Microsoft Autoupdate is set to Manual, setting to Automatic"

#Loop through the users home directories
for USER_HOME in /Users/*
do
# Set Office Updates to Manual
defaults write "${USER_HOME}"/Library/Preferences/com.microsoft.autoupdate2 HowToCheck -string Automatic
chmod 777 "${USER_HOME}"/Library/Preferences/com.microsoft.autoupdate2.plist
done

# Kill cfprefsd
killall cfprefsd

# set the local it account to manual
if [ -d /private/var/it/Library/Preferences/ ]; then
defaults write /private/var/it/Library/Preferences/com.microsoft.autoupdate2 HowToCheck -string Automatic

# Correct permissions on the file
chown it /private/var/it/Library/Preferences/com.microsoft.autoupdate2.plist

# Kill cfprefsd
killall cfprefsd
fi


# set the local itbackup account to manual
if [ -d /private/var/itbackup/Library/Preferences/ ]; then
defaults write /private/var/itbackup/Library/Preferences/com.microsoft.autoupdate2 HowToCheck -string Automatic

# Correct permissions on the file
chown itbackup /private/var/itbackup/Library/Preferences/com.microsoft.autoupdate2.plist

# Kill cfprefsd
killall cfprefsd

fi

# set the local userbackup account to manual
if [ -d /private/var/userbackup/Library/Preferences/ ]; then
defaults write /private/var/userbackup/Library/Preferences/com.microsoft.autoupdate2 HowToCheck -string Automatic

# Correct permissions on the file
chown userbackup /private/var/userbackup/Library/Preferences/com.microsoft.autoupdate2.plist

# Kill cfprefsd
killall cfprefsd
fi

# Looping through the User Template to make the changes
for USER_TEMPLATE in "/System/Library/User Template"/*
do

# Set Office Updates to Manual
defaults write "${USER_TEMPLATE}"/Library/Preferences/com.microsoft.autoupdate2 HowToCheck -string Automatic

done

fi

exit 0
