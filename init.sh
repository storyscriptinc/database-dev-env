#!/bin/sh

migration_name=$1

if [ -z "$migration_name" ]; then
  echo "need a name for the migration"
  exit 1
fi

if [ ! -f `pwd`/database/sqitch.conf ]; then
  git clone git@github.com:storyscript/database.git ./database
fi

cd database

git checkout master # make sure we are on master
git checkout -b feat/$migration_name

sqitch add -c $migration_name

cd ..

docker-compose up -d
