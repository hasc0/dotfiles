#!/bin/bash

while true; do
	player_status=$(playerctl status 2> /dev/null)

	player=$(playerctl metadata --format '{{playerName}}')
	title=$(playerctl metadata --format '{{title}}')
	artist=$(playerctl metadata --format '{{artist}}')
	position=$(playerctl metadata --format '{{duration(position)}}')
	length=$(playerctl metadata --format '{{duration(mpris:length)}}')

	if [ "$player_status" = "Playing" ]; then
		echo '{"text": "'"$artist - $title    $position / $length"'", "class": "custom-media", "alt": "'"$player"'"}'
	elif [ "$player_status" = "Paused" ]; then
		echo '{"text": "'"$artist - $title    $position / $length"'", "class": "custom-media", "alt": "'"$player"'"}'
	else
		echo '{"text": "Nothing playing...", "class": "custom-media", "alt": "'"$player"'"}'
	fi

	sleep 0.5
done

