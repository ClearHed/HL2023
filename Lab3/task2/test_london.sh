cd ../task1
docker-compose exec router mongosh --port 27017 --eval "use london;" --eval "printjson(db.postcodes.getShardDistribution());"