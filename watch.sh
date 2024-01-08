#!/bin/bash

execute_script() {
	echo "File changed, reloading..."

	make run

	# TODO: Figure out how to reload your browser tab
	# google-chrome-stable "http://localhost:80"

	echo "Reloaded"
}

watch_directories() {
	while true; do
		inotifywait -r -e modify,create,delete,move "$1" "$2" "$3"
		execute_script "$1" "$2" "$3"
	done
}

directory1="Sources"
directory2="Content"
directory3="Resources"

watch_directories "$directory1" "$directory2" "$directory3"
