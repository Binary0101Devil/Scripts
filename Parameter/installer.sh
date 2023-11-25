#!/bin/bash

mkdir /home/kali/tool
cd /home/kali/tool

git clone https://github.com/s0md3v/Arjun.git 
cd Arjun 
python3 setup.py install
cd ..

go install github.com/ffuf/ffuf/v2@latest
cd 
cd go/bin
cp ffuf /usr/local/bin/ffuf
cp ffuf /usr/bin/ffuf
cd /home/kali/tool

git clone https://github.com/devanshbatham/paramspider
cd paramspider
python3 setup.py install
cd ..

GO111MODULE=on go install github.com/jaeles-project/gospider@latest
cd 
cd go/bin
cp gospider /usr/local/bin/gospider
cd /home/kali/tool/

git clone https://github.com/GerbenJavado/LinkFinder.git
cd LinkFinder
pip3 install -r requirements.txt
python setup.py install


Arjun -h 
ffuf -h
paramspider -h
gospider -h 
python linkfinder.py -h
