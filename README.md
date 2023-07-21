# McAfee/Trellix ePO MySQL Import Script

**About:** This bash/shell script reaches out to ePO's rest API, downloads the data from a pre-defined query in JSON, transforms/parses/reformats the data, then imports into a MySQL database to be used however you require - for example to link to an analytics engine.

**Instructions:**
1. Build your desired query in ePO, and note the query ID from the browser URL, as well as the ePO IP/hostname.
2. Create credentials for the API user in ePO and note them down.
3. Ensure network connectivity on port 8443 (or whatever port you're running ePO on) between the Linux machine running this script and ePO itself.
4. Install JQ (a JSON processor) on the Linux machine that will run this script.
5. Install MySQL on the Linux machine that will run this script, or run MySQL on an external database and amend the commands to connect to an external database rather than local.
6. Create your database and a table with a schema that matches the schema of the query you built in ePO.
7. Using your notes, replace <epo_username>, <epo_password>, <epo_ip>, <query_id>, <user> (the username of your user on the Linux machine), <mysql_username>, <mysql_password>, <database>, and <table> fields in the script.
8. Copy the script to the Linux machine, give it executable rights with "chmod +x script.sh", and run it to test with "./script.sh".
9. Enjoy! Feel free to run manually or on a scheudle with cron.
