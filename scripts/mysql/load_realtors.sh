#!/bin/bash

echo -n Password:
read -s password
mysql -uroot -p${password} ${1} --local-infile -e" \
 create table ree_txt like realtors; \
 alter table ree_txt drop id
"

mysql -uroot -p${password} ${1} --local-infile -e" \
LOAD DATA LOCAL INFILE '${2}' \
INTO TABLE ree_txt  \
FIELDS TERMINATED BY ','  
ENCLOSED BY '\"' \
IGNORE 1 ROWS
"

mysql -uroot -p${password} ${1} --local-infile -e" \
insert into realtors (email, sic_code, sic_code_description, naics_code, company_name, contact_name, first_name, last_name, title, designations, agency, MSA, license_type, license_number, license_issued, license_expires, address, address2, city, county, state, zip, phone, fax, company_website, revenue, employees, affiliation, created_at, updated_at) \
select * from ree_txt; \
drop table ree_txt"


