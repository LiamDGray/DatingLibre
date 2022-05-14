function resetDatabase() {
      echo 'drop schema if exists datinglibre cascade; create schema datinglibre; ' | PGPASSWORD=secret psql -h localhost --user datinglibre datinglibre
      php bin/console doctrine:migrations:migrate --no-interaction
      php bin/console doctrine:fixtures:load --no-interaction --append
}

function npmInstall() {
      npm install
      npm run build
}

if [[ $1 == "r" ]]
then
  resetDatabase;
fi;

if [[ $1 == "n" ]]
then
  npmInstall;
fi;

if [[ $1 == "c" ]]
then
    PGPASSWORD=secret psql -h localhost --user datinglibre datinglibre
fi;

if [[ $1 == "ds" ]]
then 
    ./bin/console server:dump
fi;

if [[ $1 == "ch" ]]
then
    chromium --enable-automation --disable-background-networking --no-default-browser-check --no-first-run --disable-popup-blocking --disable-default-apps --disable-translate --disable-extensions --no-sandbox --enable-features=Metal  --remote-debugging-port=9222 --disable-gpu
fi;

if [[ $1 == "down" ]]
then
	docker-compose -f docker-compose.yml down
	docker-compose -f docker-compose.yml rm
fi;

if [[ $1 == "up" ]]
then
    docker-compose -f docker-compose.yml up -d
    echo "Waiting 5 seconds for database to start"
    sleep 5
    resetDatabase
    npmInstall
fi;
