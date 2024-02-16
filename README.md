# postgres-playground
Little repo where to play with postgresql db 

## Prerequisites

- docker-compose
- makefile

## How to use

``` make start ``` : start containers postgres and pgadmin

``` make stop ``` : stop all containers 

### run queries

to run a custom query you can write it in the query-editor.sql file and after type ``` make query-editor ``` from the terminal

### run specific projects

go to a specific project folder inside _/projects_ folder

you can find seed.sql and query-editor.sql files specific for the project

first install the seed with ``` make seed ``` and after run ``` make query-editor ```


### use client

you can access browse and query the database from pgadmin at http://localhost:5050

### run specific commands inside projects

 
## postgres

default configurations can be changed via .env variables:

PG_PORT: default 5432

POSTGRES_USER: postgres

POSTGRES_PASSWORD: postgres


## pgadmin

pgadmin is a client to browse the database
 
you can use it opening locahost:5050

by default no passwords will be required to access to the test database

[here](https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html#environment-variables) you can find the entire list of environment variables. 

### Servers configuration

in configs/pgadmin folder you can finf servers.json file and pgpass file

> servers.json contains all server that will be preloaded in pgadmin

``` json 
{
    "Servers": {
      "1": {
        "Group": "Servers",
        "Name": "pg-test-db",
        "Host": "postgres",
        "Port": 5432,
        "MaintenanceDB": "postgres",
        "Username": "postgres",
        "PassFile": "/var/lib/pgadmin/pgpass",
        "SSLMode": "prefer"
      }
    }
}
```

- Name: user friendly name to give to the server
- Host: container where postgres db is hosted
- Port: port of postgres db
- Username: user that will access to the db
- MaintenanceDB: main database name


> pgpass: contains the password file for the db in this format

_hostname:port:database:username:password_

