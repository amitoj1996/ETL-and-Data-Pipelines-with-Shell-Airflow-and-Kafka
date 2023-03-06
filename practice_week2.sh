#extracting the data

wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"

gunzip -f web-server-access-log.txt.gz

echo "Extracting Date"

cut -d"#" -f1-4 web-server-access-log.txt > extracted-data.txt

# transforming data

echo "Transforming data"

tr "#" "," < extracted-data.txt > transformed-data.csv


echo "Loading Data"

echo "\c template1;\COPY access_log FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost

#reading final data file

echo '\c template1; \\SELECT * from access_log;' | psql --username=postgres --host=localhost
