#! /bin/sh

os=$(<.host)
echo $os
FILE=.server_pid
[[ -f "$FILE" ]] && PID="$(<.server_pid)"

case $os in
	Linux)
		echo "This is Linux"
		
		if [[ -f "$FILE" ]]; then
        		echo "$FILE exists, server running with PID $(<.server_pid). Did you mean to stop the server?"
				while (true); do 
                read input
                case $input in
                    Y|y|Yes|yes)
                        kill -9 $(cat $FILE) && echo "$PID terminated" || echo "failed to terminate $PID"
						rm -f .server_pid && echo "removed $FILE" || "unable to remove $FILE"
                        break
                    ;;
                    N|n|No|no)
                        break
                    ;;
                    *)
                        echo "Unexpected Input Try Again"
                    ;;
                esac
            done
		else
			nohup ./FXServer/server/run.sh > server.log 2>&1 &
			echo $! > .server_pid
			echo "Server running with PID $(<.server_pid)"
		fi
	;;
	Windows)
		echo "This is Windows"

		if [[ -f "$FILE" ]]; then
        		echo "$FILE exists, server running with PID $(<.server_pid). Did you mean to stop the server?"
		else
			start bash -c "./FXServer/server/start_5562_default.bat" &
			echo $! > .server_pid
			echo "Server running with PID $(<.server_pid)"
		fi
	;;
	*)
		echo "THIS IS SPARTA"
	;;
esac