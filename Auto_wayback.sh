#!/bin/bash

url=$1

if [ ! -d "url" ];then
	mkdir $url
fi

if [ ! -d "$url/subdomain" ];then
	mkdir $url/subdomain
fi

if [ ! -d "$url/subdomain/httpx" ];then
    mkdir $url/subdomain/httpx
fi


if [ ! -f "$url/subdomain/alive.txt" ];then
    touch $url/subdomain/alive.txt
fi

 
echo "[+] Harvesting subdomain with subdomain"
subdomain -d $url >> $url/subdomain/asset.txt
cat $url/subdomain/alive.txt 

echo "[+] Probing for alive domains..."
cat $url/subdomain/Final.txt | sort -u | httpx | tee $url/subdomain/httpx.txt
sort -u $url/subdomain/httpx/a.txt > $url/subdomain/httpx/alive.txt
rm $url/subdomain/httpx/a.txt

echo "[+] Scanning for open ports..."
cat $url/subdomain/httpx/alive.txt | waybackurls | tee $url/subdomain/httpx/wayback.txt