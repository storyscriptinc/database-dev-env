#!/bin/bash

migration_name=$(cat ./database/sqitch.plan | tail -n 1 | cut -d " " -f 1)

echo "getting migrations for $migration_name"

echo "-- Deploy storyscript:$migration_name to pg

SET search_path TO :search_path;

BEGIN;

" > database/deploy/$migration_name.sql

docker run --net=host djrobstep/migra:latest migra --unsafe \
postgresql://postgres:postgres@127.0.0.1:5432/storyscript \
postgresql://postgres:postgres@127.0.0.1:5433/storyscript >> database/deploy/$migration_name.sql

echo "COMMIT;" >> database/deploy/$migration_name.sql

echo "getting revertions for $migration_name"

echo "-- Revert storyscript:$migration_name from pg

SET search_path TO :search_path;

BEGIN;

" > database/revert/$migration_name.sql

docker run --net=host djrobstep/migra:latest migra --unsafe \
postgresql://postgres:postgres@127.0.0.1:5433/storyscript \
postgresql://postgres:postgres@127.0.0.1:5432/storyscript >> database/revert/$migration_name.sql

echo "COMMIT;" >> database/revert/$migration_name.sql
