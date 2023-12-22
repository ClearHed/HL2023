docker-compose up -d

docker-compose exec config_server_1 sh -c "mongosh < /scripts/init_configserver.js"

docker-compose exec shard1_1 sh -c "mongosh < /scripts/init_shard1.js"
docker-compose exec shard2_1 sh -c "mongosh < /scripts/init_shard2.js"
docker-compose exec shard3_1 sh -c "mongosh < /scripts/init_shard3.js"

sleep 10

docker-compose exec router sh -c "mongosh < /scripts/init_router.js"

docker-compose exec router mongosh --port 27017 --eval "sh.status()"
