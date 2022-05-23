#!/bin/bash

url=$1

if [ ! -d "url" ];then
	mkdir $url
fi

if [ ! -d "$url/subfinder" ];then
	mkdir $url/subfinder
fi


if [ ! -f "$url/subfinder/alive.txt" ];then
    touch $url/subfinder/alive.txt
fi

 
echo "[+] Harvesting subdomain with subfinder"
subfinder -d $url >> $url/subfinder/asset.txt
cat $url/subfinder/alive.txt 

echo "[+] Probing for alive domains..."
cat $url/subfinder/Final.txt | sort -u | httpx | tee $url/subfinder/httpx.txt
sort -u $url/subfinder/httpx/a.txt > $url/subfinder/httpx/alive.txt
rm $url/subfinder/httpx/a.txt

echo "[+] Scanning for open ports..."
cat $url/subfinder/httpx/alive.txt | waybackurls | tee $url/subfinder/httpx/wayback.txt