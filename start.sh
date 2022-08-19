#! /bin/sh
FILE=server_pid.txt
if [[ -f "$FILE" ]]; then
	echo "$FILE exists, server running on port $(<server_pid.txt). Did you mean to stop the server?"
else
nohup ./FXServer/server/run.sh > server.log 2>&1 &
echo $! > server_pid.txt
echo "Server running on port $(<server_pid.txt)"
fi