!/bin/bash

# Delete file from previous run.
rm /home/<user>/epo_export/epo

# Fetch new export from ePO via REST API.
curl -k -u "<username>:<password>" "https://<epo_ip>:8443/remote/core.executeQuery?queryId=<id>&:output=json">> /home/<user>/epo_export/epo.json

# Format into CSV.
tail -n +2 /home/<user>/epo_export/epo.json > /home/<user>/epo_export/epo.tmp && mv /home/<user>/epo_export/epo.tmp /home/<user>/epo_export/epo.json
cat /home/<user>/epo_export/epo.json| jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' >> /home/<user>/epo_export/epo.tmp
sed 's/\\/\\\\\\/g' /home/<user>/epo_export/epo.tmp > /home/<user>/epo_export/epo.tmp2
sed 's/\\"/"/g' /home/<user>/epo_export/epo.tmp2 > /home/<user>/epo_export/epo

# Clean-up temp files.
rm /home/<user>/epo_export/epo.json
rm /home/<user>/epo_export/epo.tmp
rm /home/<user>/epo_export/epo.tmp2

# Truncate the existing data in the table.
mysql --user=<username> --password=<password> <database> -e "TRUNCATE TABLE <table_name>;"

# Import the final CSV file into the MySQL table.
mysql --user=<username> --password=<password> <database> -e "LOAD DATA LOCAL INFILE '/home/<user>/epo_export/epo' INTO TABLE tab_epo FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;"
