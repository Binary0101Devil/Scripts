#!/bin/bash

# Run ffuf for subdomain discovery
#	ffuf -u https://HFUZZ/WFUZZ -w subdomains.txt:HFUZZ -w /home/kali/test/bughunting/wordlists/directories.txt:WFUZZ -mc 200,201,204,301,302,307,401,403,405,500 -c -v -mode clusterbomb > ffuf_output.txt

# To automatically filter the output of ffuf
#	./ffuf.sh
#	sleep 5

#	echo -e "Subject: Fuff is Completed\nNow Paramspider is working.\n$(cat ffuf_output.txt)" | msmtp -a gmail binary0101devil@gmail.com

# Run Paramspider to find parameters in JavaScript files
paramspider -l subdomains.txt > paramspider_output.txt
sleep 5
cat "results"/* | sort | uniq > paramspider_output.txt
rm -rf results
echo -e "Subject: Paramspider is Completed\nNow Katana is working.\n$(cat paramspider_output.txt)" | msmtp -a gmail binary0101devil@gmail.com

# Run katana
katana -u subdomains.txt > katana_output.txt
echo -e "Subject: Katana is Completed\nNow sortting is working.\n$(cat katana_output.txt)" | msmtp -a gmail binary0101devil@gmail.com

#	sort -u final_ffuf_output.txt paramspider_output.txt katana_output.txt > mergedurls.txt
sort -u paramspider_output.txt katana_output.txt > mergedurls.txt

awk '/https?:\/\// { match($0, /https?:\/\/[^[:space:]]*/); print substr($0, RSTART, RLENGTH) }' "mergedurls.txt" > Urls.txt

# Run Arjun for hidden Parameters
arjun -i subdomains.txt -oT arjun1_output.txt
arjun -i mergedurls.txt -oT arjun2_output.txt
sort arjun1_output.txt arjun2_output.txt > arjun_output.txt
rm -rf arjun1_output.txt arjun2_output.txt
echo -e "Subject: Arjun is Completed\nNow Gospider is working.\n$(cat arjun_output.txt)" | msmtp -a gmail binary0101devil@gmail.com

sort -u arjun_output.txt Urls.txt > AllUrls.txt
Send emails with attachments
echo "Hello Chief, Here are the results of the various tasks." | mutt -s "Results of Ffuf Paramspider Katana Arjun" -a "final_ffuf_output.txt" -a "paramspider_output.txt" -a "katana_output.txt" -a "arjun_output.txt" -a "Urls.txt" -a "mergedurls.txt" -- binary0101devil@gmail.com

sleep 10

echo "Hello Chief, Urls enumeration works is done we are sending a attachment of AllUrls.txt" | mutt -a "AllUrls.txt" -s "Url enumeration completed Attachment of AllUrls" -- binary0101devil@gmail.com

sleep 10
# Remove duplicates
#	rm -rf final_ffuf_output.txt arjun_output.txt paramspider_output.txt katana_output.txt mergedurls.txt Urls.txt

rm -rf  arjun_output.txt paramspider_output.txt katana_output.txt mergedurls.txt Urls.txt

#	cd
#	cd /home/kali/tool/LinkFinder
#	python linkfinder.py -i https://example.com -d

#	cd
#	cd /home/kali/test/bughunting/vulnerability
#	./vulnerability.sh
