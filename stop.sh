#! /bin/sh

OS=$(<.host)
[[ $OS = "Linux" ]] && PID=$(lsof -ti:40120)
[[ $OS = "Windows" ]] && PID=$(netstat -ano | grep "40120" | grep "ESTABLISHED" | awk 'NR==1{ print $5 }')

if [[ $PID ]]; then
    echo "Killing $PID"
     case $OS in
        Linux)
            kill -9 $PID && echo "$PID terminated" || echo "failed to terminate $PID"
        ;;
        Windows)
            taskkill //F //PID $PID
        ;;
		*)
		echo "Distro Not Supported"
    ;;
    esac
else
    echo "Nothing Found on Port 40120"
fi