function start_mempool {

docker ps >/dev/null 2>&1 || announce "Docker not running. Aborting." && return 1 

cd $hp/mempool/docker
docker-compose up &
}

function stop_mempool {

cd $hp/mempool/docker
docker-compose stop &
}

function restart_mempool {

docker ps >/dev/null 2>&1 || announce "Docker not running. Aborting." && return 1 

cd $hp/mempool/docker
docker-compose stop 2>/dev/null
docker-compose up &

}