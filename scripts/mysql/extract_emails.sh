#!/bin/bash

echo -n Password:
read -s password
mysql -uroot -p${password} ${1} --local-infile -e" \
SELECT email
FROM realtors
where state = '${2}'
INTO OUTFILE '/tmp/${2}_emails.csv'
FIELDS ENCLOSED BY '\"' TERMINATED BY ',';
"
sudo mv /tmp/${2}_emails.csv /home/mmaiza/Dev/realestatemails/emails/. 
sudo chown mmaiza.mmaiza /home/mmaiza/Dev/realestatemails/emails/${2}_emails.csv

