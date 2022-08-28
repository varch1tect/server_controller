#! /bin/sh

FILE=.server_pid
PID="$(<.server_pid)"
PORT_CHECK=$(lsof -i:40120)

if [[ -f "$FILE" ]]; then
    echo "$FILE found, verifying if server is running on port 40120"
    echo "$PORT_CHECK"
    if [[ $PORT_CHECK ]]; then
        echo "Port in use, killing PID $PID"
        kill -9 $(cat $FILE) && echo "$PID terminated" || echo "failed to terminate $PID"
        rm -f .server_pid && echo "removed $FILE" || "unable to remove $FILE"
    else
        echo "Nothing Found on Port 40120, $FILE will be removed"
        rm -f .server_pid && echo "removed $FILE" || "unable to remove $FILE"
    fi
else
    echo "Couldn't find $FILE, verifying port 40120:"
    if [[ $PORT_CHECK ]]; then
        echo "Found on Port 40120:"
        echo "$PORT_CHECK"
        PID=$(lsof -ti:40120)
        echo "Would you like to kill $PID? Y/Yes or N/No?"
            while (true); do 
                read input
                case $input in
                    Y|y|Yes|yes)
                        kill -9 $PID
                        break
                    ;;
                    N|n|No|no)
                        echo "Creating file .server_pid with $PID"
                        echo $PID >> .server_pid
                        break
                    ;;
                    *)
                        echo "Unexpected Input Try Again"
                    ;;
                esac
            done
    else
        echo "Nothing Found on Port 40120, $FILE will be removed"
        rm -f .server_pid && echo "removed $FILE" || "unable to remove $FILE"
    fi
fi