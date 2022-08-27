#! /bin/sh

OS=$(<.host)
PORT_CHECK=$(lsof -i:40120)
FILE=server_pid.txt

echo "STATUS"
echo "OS: $OS"
#echo "$([ -f $FILE ] && echo "$FILE: yes" || echo "$FILE: no")"
echo "$([[ ! -f "$FILE" ]] && echo "$FILE: DNE" || { $([[ -z $(<$FILE) ]]) && echo "PID: NULL" || echo "PID: $(<$FILE)"; })"
#[ -f $FILE ] && { [ -z $(<$FILE) ] && { [ -z "$PORT_CHECK" ] && echo "PORT_CHECK Null" || { echo "PORT_CHECK Not Null"; PID=$(<$FILE); } || echo "$FILE Not Null, probably $(<$FILE)" } || echo "$FILE EMPTY" } || echo "$FILE Does Not Exist"
[ -z $PORT_CHECK ] && echo "No Ports" || echo "Port Check:"
#echo "$PORT_CHECK"