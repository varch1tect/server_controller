#! /bin/sh

OS=$(<.host)
PORT_CHECK=$(lsof -i:40120)
FILE=.server_pid
PID=Null

echo "STATUS"
echo "OS: $OS"
#echo "$([ -f $FILE ] && echo "$FILE: yes" || echo "$FILE: no")"
echo "$([[ ! -f "$FILE" ]] && echo "$FILE: DNE" || { $([[ -z $(<$FILE) ]]) && echo "PID: NULL" || PID=$(<$FILE); echo "PID: $(<$FILE)"; })" #PID CANNOT BE ASSIGNED WITHIN LOCAL IF
#[ -f $FILE ] && { [ -z $(<$FILE) ] && { [ -z "$PORT_CHECK" ] && echo "PORT_CHECK Null" || { echo "PORT_CHECK Not Null"; PID=$(<$FILE); } || echo "$FILE Not Null, probably $(<$FILE)" } || echo "$FILE EMPTY" } || echo "$FILE Does Not Exist"
[ -z $PORT_CHECK ] && echo "No Ports" || echo "Port Check:"
#echo "$PORT_CHECK"
echo "$PID"