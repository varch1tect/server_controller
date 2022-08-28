#! /bin/sh

os=$(<.host)
echo $os
case $os in
	Linux)
		echo "This is Linux"
		
		FILE=.server_pid
		if [[ -f "$FILE" ]]; then
        		echo "$FILE exists, server running with PID $(<.server_pid). Did you mean to stop the server?"
		else
			nohup ./FXServer/server/run.sh > server.log 2>&1 &
			echo $! > .server_pid
			echo "Server running with PID $(<server_pid.txt)"
		fi
		 
	;;
	Windows)
		echo "This is Windows"

		#start "FXServer/server/alpine/FXServer.exe" &
		#start sh "FXServer/server/start_5562_default.bat" &
		start bash -c "./FXServer/server/start_5562_default.bat" &
		echo $! > .server_pid
		echo "Server running with PID $(<.server_pid)"

	;;
	*)
		echo "THIS IS SPARTA"
	;;
esac