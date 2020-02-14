#!/bin/bash

migration_name=$(ls ./database/deploy | grep sql | head -1 | cut -d . -f 1)

commit_message=$1

if [ -z "$commit_message" ]; then
  echo "need a commit message"
  exit 1
fi

cd database

git add sqitch.plan deploy/$migration_name.sql revert/$migration_name.sql verify/$migration_name.sql

git commit -m "$commit_message"

git push origin feat/$migration_name
