#! /bin/sh

OS=$(<.host)
[[ $OS = "Linux" ]] && { PORT_CHECK=$(lsof -i:40120); PID=$(lsof -ti:40120); }
[[ $OS = "Windows" ]] && { PORT_CHECK=$(netstat -a -n -o | grep "40120" | grep "ESTABLISHED" ); PID=$(netstat -ano | grep "40120" | grep "ESTABLISHED" | awk 'NR==1{ print $5 }'); }

echo "STATUS"
echo "OS: $OS"
[[ $PORT_CHECK ]] && { echo -e "PORT 40120:\n$PORT_CHECK"; echo "PID: $PID"; } || echo -e "PORT_CHECK: DNE\nPID: DNE"