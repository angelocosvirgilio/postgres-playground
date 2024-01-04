# postgres-playground
Little repo where to play with postgresql db 

## postgres

default configurations can be changed via .env variables:

PG_PORT: default 5432

POSTGRES_USER: postgres

POSTGRES_PASSWORD: postgres


## pgadmin

pgadmin is a client to browse the database
 
you can use it opening locahost:5050

by default no passwords will be required to access to the test database

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

_ hostname:port:database:username:password_

