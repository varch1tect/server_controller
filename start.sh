#! /bin/sh

OS=$(<.host)
[[ $OS = "Linux" ]] && { PORT_CHECK=$(lsof -i:40120); PID=$(lsof -ti:40120); }
[[ $OS = "Windows" ]] && { PORT_CHECK=$(netstat -ano | grep "40120" | grep "ESTABLISHED" ); PID=$(netstat -ano | grep "40120" | grep "ESTABLISHED" | awk 'NR==1{ print $5 }'); }

if [[ $PID ]]; then
    echo "Port busy, server running with PID $PID. Did you mean to stop the server?"
    while (true); do 
        read input
        case $input in
            Y|y|Yes|yes)
                case $OS in
	                Linux)
                        ./stop.sh
                        break
                    ;;
                    Windows)
                        sh stop.sh
                        break
                    ;;
                esac
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
	echo "Starting Server."
    case $OS in
        Linux)
            nohup ./FXServer/server/run.sh > server.log 2>&1 &
            echo "Server running with PID $!"
        ;;
        Windows)
            start bash -c "./FXServer/server/start_5562_default.bat"
			echo -n "Obtaining PID"
			while [ -z $PID ]
			do
				sleep 1
				PID=$(netstat -a -n -o | grep "40120" | grep "ESTABLISHED" | awk 'NR==1{ print $5 }')
				echo -n "."
			done
			echo -e "\nServer running with PID $PID"
        ;;
		*)
		echo "Distro Not Supported"
	;;
    esac
fi