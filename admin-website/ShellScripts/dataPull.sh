# Script to pull data into db
echo Hello World
date

# iterate through sightings and print


find /etc/crab/*/*/sightings/ -name \*.json -print0 | while read -d $'\0' file; do
    filename="${file##*/}"
    printf "%s\n" "added $filename";
    curl -X PUT -d @"$file" http://127.0.0.1:5984/rawcrab/"$filename"
done

# run python script in venv to update clean db
source /etc/crab/env/bin/activate
/etc/crab/REMAR-Server/PythonScripts/main.py
