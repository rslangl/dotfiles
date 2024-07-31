#!/bin/sh

while true; do
	datetime=$(date "+%d-%m-%Y %H:%M:%S")

	volume=$(amixer get Master | awk -F '[][]' 'END{ print $2 }')

	status="$volume < $datetime"

	xsetroot -name $status
	sleep 1
done
