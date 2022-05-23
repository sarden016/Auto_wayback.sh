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
subfinder -d $url >> $url/recon/asset.txt
cat $url/subfinder/alive.txt | grep $1 >> $url/recon/Final.txt

echo "[+] Probing for alive domains..."
cat $url/recon/Final.txt | sort -u | httpx | tee $url/recon/httpx.txt
sort -u $url/recon/httprobe/a.txt > $url/recon/httprobe/alive.txt
rm $url/recon/httprobe/a.txt

echo "[+] Scanning for open ports..."
cat $url/recon/httprobe/alive.txt | waybackurls | tee $url/recon/httprobe/wayback.txt