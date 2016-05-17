#!/bin/bash

#the auth key is obtained with:
# perl -MMIME::Base64 -e 'print encode_base64("\000mymail\@myprovider.com\000mypassword")'

mailFile="/tmp/mail.txt"

echo "ehlo localhost" > $mailFile
echo "auth plain AG15bWFpbEBteXByb3ZpZGVyLmNvbQBteXBhc3N3b3Jk" >> $mailFile
echo "mail from: <mymail@myprovider.com>" >> $mailFile
echo "rcpt to: <first@otherprovider.com>" >> $mailFile
echo "rcpt to: <second@otherprovider.com>" >> $mailFile
echo "data" >> $mailFile
echo "From: <mymail@myprovider.com>" >> $mailFile
echo "To: <first@otherprovider.com,second@otherprovider.com>" >> $mailFile
echo "Subject: $1" >> $mailFile
echo -n "Date: " >> $mailFile
date -R >> $mailFile
echo "" >>$mailFile
echo "$2" >> $mailFile
echo "." >> $mailFile
echo "quit" >> $mailFile
echo "" >> $mailFile

cat $mailFile | openssl s_client -connect smtp.myprovider.com:465 -crlf -ign_eof &> /dev/null

