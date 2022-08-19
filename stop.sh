#! /bin/sh
kill -9 $(cat server_pid.txt)
rm -f server_pid.txt