FILENAME="rides.csv"

cd ../task1

docker-compose exec router mongosh --port 27017 --eval "sh.shardCollection('london.rides', {_id: 'hashed'})"
docker-compose exec router mongoimport --port 27017 -d london -c rides --type csv --file "../data/$FILENAME" --headerline