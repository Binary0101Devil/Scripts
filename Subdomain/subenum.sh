#!/bin/bash

# Check if the domain argument is provided
if [ -z "$1" ]
then
    echo "Please provide a domain name."
    exit 1
fi

# Run subdomain enumeration tools and save the output to corresponding files
subfinder -d "$1" > subdomain_subfinder.txt
sleep 10
{
    echo "Subject: Subfinder is Completed"
    echo -e "Now Assetfinder is working.\n$(cat subdomain_subfinder.txt)"
} | msmtp -a gmail binary0101devil@gmail.com

sleep 10
assetfinder --subs-only "$1" > subdomain_assetfinder.txt
sleep 10
{
    echo "Subject: Assetfinder is Completed"
    echo -e "Now Findomain is working.\n$(cat subdomain_assetfinder.txt)"
} | msmtp -a gmail binary0101devil@gmail.com

sleep 10
findomain -t "$1" -u subdomain_findomain.txt
sleep 10
{
    echo "Subject: Findomain is Completed"
    echo -e "Now Sublist3r is working.\n$(cat subdomain_findomain.txt)"
} | msmtp -a gmail binary0101devil@gmail.com

sleep 10
sublist3r -d "$1" -o subdomain_sublist3r.txt
sleep 10
{
    echo "Subject: Sublist3r is Completed"
    echo -e "Now Knockpy is working.\n$(cat subdomain_sublist3r.txt)"
} | msmtp -a gmail binary0101devil@gmail.com

sleep 10
knockpy "$1" > subdomain_knock.txt
sleep 10
{
    echo "Subject: Knockpy is Completed"
    echo -e "Now Sorting is working.\n$(cat subdomain_knock.txt)"
} | msmtp -a gmail binary0101devil@gmail.com

sleep 10
# Combine all subdomain files and sort them into a final file
cat subdomain_subfinder.txt subdomain_assetfinder.txt subdomain_findomain.txt subdomain_sublist3r.txt | sort -u > "final_subdomain.txt"
sleep 10
httpx -l final_subdomain.txt -o live_subdomains.txt -threads 200 -status-code -follow-redirects
sleep 10
{
    echo "Subject: httpx is Completed"
    echo -e "Now Removing of unused File is working.\n$(cat live_subdomains.txt)"
} | msmtp -a gmail binary0101devil@gmail.com

sleep 10
#cd
#cd /home/kali/test/bughunting/subenum

python3 httpxbeauty.py
sleep 10
{
    echo "Subject: Beauty is Completed"
    echo -e "Now sending of Attachments is in working.\n$(cat subdomains.txt)"
} | msmtp -a gmail binary0101devil@gmail.com


# Send emails with attachments
echo "Hello Chief, Here are the results of the various tasks of Subdomain enumeration." | mutt -s "Results of Subdomain enumeration" -a "subdomain_subfinder.txt" -a "subdomain_assetfinder.txt" -a "subdomain_findomain.txt" -a "subdomain_sublist3r.txt" -a "subdomain_knock.txt" -a "final_subdomain.txt" -- binary0101devil@gmail.com
echo "Hello Chief, Here are the results of Live Subdomain enumeration and Beautify of Subdomain enumeration ." | mutt -s "Results of Live Subdomain enumeration" -a "live_subdomains.txt" -a "subdomains.txt" -- binary0101devil@gmail.com

sleep 10
# Remove intermediate files
echo -e "Subject: All unused files Removed\nAll Task is Completed Successfully. Waiting for next task Chief" | msmtp -a gmail binary0101devil@gmail.com
rm -rf subdomain_subfinder.txt subdomain_assetfinder.txt subdomain_findomain.txt subdomain_sublist3r.txt subdomain_knock.txt final_subdomain.txt knockpy_report live_subdomains.txt

cp subdomains.txt /home/kali/test/bughunting/subdomain/
cp subdomains.txt /home/kali/test/bughunting/url/
cp subdomains.txt /home/kali/test/bughunting/parameter/
cp subdomains.txt /home/kali/test/bughunting/vulnerability/
cd /home/kali/test/bughunting/url/
./urlfinder.sh
# 	./parameterenum.sh
