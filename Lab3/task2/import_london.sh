FILENAME="london_postcodes-ons-postcodes-directory-feb22.csv"

cd ../task1

docker-compose exec router mongosh --port 27017 --eval "sh.enableSharding('london'); sh.shardCollection('london.postcodes', {_id: 'hashed'})"
docker-compose exec router mongoimport --port 27017 -d london -c postcodes --type csv --file "../data/$FILENAME" --headerline
