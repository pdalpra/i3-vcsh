#!/usr/bin/env bash

declare -r CONF_FILE_SUFFIX="i3conf"
declare -r CONFIG_PATH=$HOME/.config/i3
declare -r TARGET_FILE=$CONFIG_PATH/config

config_files=$(find $CONFIG_PATH -name "*.$CONF_FILE_SUFFIX" | sort)

if [ -z "${config_files}" ]; then
	echo "No config files found, aborting."
else
	rm -f $TARGET_FILE
	echo "Found config files:"
	for config_file in $config_files; do
		echo "  - $config_file"
		cat $config_file | grep -v '# vim' >> $TARGET_FILE
	done
	# Restart i3 if running to reload the configuration
	if [ -n $(pidof i3) ]; then 
		echo "Reloading configuration file..."
		i3-msg 'reload' 1>/dev/null
	fi
fi
