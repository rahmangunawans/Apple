#!/bin/bash
waktu=`date '+%d/%m/%Y %H:%M:%S'`
#waktu=$(date "+%Y-%m-%d %H:%M:%S")
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
ORANGE='\033[0;33m'
CYAN="\e[36m"
LIGHTGREEN="\e[92m"
MARGENTA="\e[35m"
BLUE="\e[34m"
BOLD="\e[1m"
NOCOLOR="\e[0m"

header(){
printf "\n"
echo -e "${YELLOW}         -----------------------------------  "
echo -e "${YELLOW}        =[      ${GREEN}Apple Valid Email ${YELLOW}         ]=-"
echo -e "${YELLOW}        =[    ${GREEN}Contact FB: Rahman Gunawan${YELLOW}   ]=-"
echo -e "${YELLOW}        =[    ${GREEN}Created by Rahman Gunawan${YELLOW}    ]=-"
echo -e "${YELLOW}        =[         ${GREEN}Version : 3.1${YELLOW}           ]=-"
echo -e "${YELLOW}         -----------------------------------  "${NOCOLOR}
printf "\n"
}
callback(){
    requests=`curl 'https://idmsac.apple.com/authenticate'  -H 'User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.108 Safari/537.36' -H 'Referer: https://idmsac.apple.com/IDMSWebAuth/login.html?appIdKey=3b356c1bac5ad9735ad62f24d43414eb59715cc4d21b178835626ce0d2daa77d&rv=1&view=5&path=%2F&fbclid=IwAR12P0xbM60Si-LiUD1pl6G-gKwYromapvg6t7ZeaXkGUH1tXSzgcyHBS20'  --data "openiForgotInNewWindow=true&fdcBrowserData=&appleId=$1&accountPassword=x&appIdKey=3b356c1bac5ad9735ad62f24d43414eb59715cc4d21b178835626ce0d2daa77d&accNameLocked=false&language=US-EN&path=%2F&rv=1&view=5&requestUri=%2Flogin.html&Env=PROD&referer=https%3A%2F%2Fl.facebook.com%2F&scnt=5d28b69fa8b7e1e14569ffb1d95db329" --compressed -s`
    live="$(echo "$requests" | grep -c 'Access denied. Your account does not have permission to access this application.')"
    if [[ $live == 1 ]]; then
        printf "${GREEN}LIVE  => ${NOCOLOR} $1\n";
        echo "[LIVE] => $1" >> live.txt
    else
        printf "${RED}DEAD  => ${NOCOLOR} $1\n";
    fi
}
#Daerah Logo
header
if [[ ! -d result ]]; then
	mkdir result
fi
echo ""
read -p "Select Your List: " listo;
multithread_limit=100
IFS=$'\r\n' GLOBIGNORE='*' command eval 'list=($(cat $listo))'
for (( i = 0; i < "${#list[@]}"; i++ )); 
do
	target="${list[$i]}"
	((cthread=cthread%multithread_limit)); ((cthread++==0)) && wait
	callback ${target} &
done
wait
