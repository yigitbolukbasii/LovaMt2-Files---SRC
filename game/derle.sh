#!/bin/sh

echo -e "\033[31m

METIN2
NE BUILD ETMEK ISTIYORSUN \n 
1 - GAME\n\
2 - DB\n\033[0m"

read chs

case $chs in 
1*) 
echo -e "\033[31m
BUILD BASLIYOR....\033[0m"
cd /usr/src/metin2source/game/src
echo -e "\033[31m
GMAKE CLEANING...\033[0m"
gmake clean
sleep 2
echo -e "\033[31m
GMAKE DEPPING...\033[0m"
gmake dep
sleep 2
echo -e "\033[31m
GAME BUILDING...\033[0m"
gmake -j20

echo
echo -e "\033[31m
METIN2
GAME BUILD EDILDI...

BUILD EDILEN GAME
/usr/src/metin2source/game/
DIZININE OLUSTURULDU

game_r50050
\033[0m"
echo
;;
2*) 
echo -e "\033[31m
BUILD BASLIYOR....\033[0m"
cd /usr/src/metin2source/db/src
sleep 2
echo -e "\033[31m
GMAKE CLEANING...\033[0m"
gmake clean
sleep 2
echo -e "\033[31m
GMAKE DEPPING...\033[0m"
gmake dep
sleep 2
echo -e "\033[31m
GAME BUILDING...\033[0m"
gmake -j20
echo -e "\033[31m
METIN2
DB BUILD EDILDI...

BUILD EDILEN DB
/usr/src/metin2source/db/
DIZININE OLUSTURULDU

db_r50050
\033[0m"
echo
;;

esac