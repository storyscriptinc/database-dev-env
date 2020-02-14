# database-dev-env
scripts to easily make changes to the storyscript/database


## Requirements

- [docker](https://docs.docker.com/install/)
- [docker-compose](https://docs.docker.com/compose/install/)
- [docker-sqitch](https://github.com/sqitchers/docker-sqitch)

## Steps

> run the init script to init a migration
```bash
./init.sh {migration-name}
```
It automaticly pull the repo if needed, create the migration, create your branch and run the 2 databases with a graphql server

The first database needs to stay intact. It acts as a safe-state. You can access it at `localhost:5432`
The second database **is the one you can make changes into**. You can access it at `localhost:5433`

Both databases use the same credentials:
```
PG_USER=postgres
PG_PASSWORD=postgres
PG_DB=storyscript
```

Make your changes

> run the auto-migration script using [migra](https://djrobstep.com/docs/migra)
```bash
./migrate.sh
```
This script generate 2 files:
- `database/deploy/{migration-name}.sql`: contains the migrations
- `database/revert/{migration-name}.sql`: contains the revertions

:warning: **here you may need to review the generated files to make sure they're valid**

> apply the changes to the database repo
```bash
./apply.sh "commit message"
```

> :tada: create your PR :cake:
