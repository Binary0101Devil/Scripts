#!/bin/bash

# Waybackurls
cat subdomains.txt | waybackurls > waybackurls.txt
echo -e "Subject: waybackurls is Completed\nNow Gau of urls is working.\n$(cat waybackurls.txt)" | msmtp -a gmail binary0101devil@gmail.com

# Gau
cat subdomains.txt | gau  > gau_urls.txt
echo -e "Subject: Gau is Completed\nNow sort of urls is working.\n$(cat gau_urls.txt)" | msmtp -a gmail binary0101devil@gmail.com


sort -u waybackurls.txt gau_urls.txt > urls.txt
echo -e "Subject: Sort is Completed\nNow sort of urls is working.\n$(cat urls.txt)" | msmtp -a gmail binary0101devil@gmail.com

sleep 10
echo "Hello Chief, Here are the results of the various tasks." | mutt -s "Results of Waybackurls and Gau" -a "waybackurls.txt" -a "gau_urls.txt" -a "urls.txt" -- binary0101devil@gmail.com

sleep 15
rm -rf waybackurls.txt gau_urls.txt urls.txt

cd /home/kali/test/bughunting/parameter
./parameterenum.sh
