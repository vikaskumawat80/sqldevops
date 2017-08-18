#!/bin/bash

printf '\e[1;34m%-6s\e[m' "* starting tests:" && printf "\n"
starttime=$(gdate +"%Y-%m-%d %H:%M:%S %3N")

curl -s http://localhost:8888/api/getspecs | jq -r '.[] | .specFile'

start=$SECONDS

for spec in $(curl -s http://localhost:8888/api/getspecs | jq -r '.[] | .specFile'); do
    url='http://localhost:8888/api/runspec/'$spec
    curl -s $url & 
done

printf "\n" && printf '\e[1;34m%-6s\e[m' "* waiting for the results:" && printf "\n" 

wait

duration=$(( SECONDS - start )) && endtime=$(gdate +"%Y-%m-%d %H:%M:%S %3N")
printf '\e[1;35m%-6s\e[m' "--- Summary ---" && printf "\n" 
printf '\e[1;35m%-6s\e[m' "Start time:          " && printf "%s %s %s\n" $starttime
printf '\e[1;35m%-6s\e[m' "End time:            " && printf "%s %s %s\n" $endtime
printf '\e[1;35m%-6s\e[m' "Total elapse time:   "  && printf "%s seconds\n\n" $duration













# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37