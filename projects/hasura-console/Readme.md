# Hasura Console

The [Hasura Console](https://hasura.io/docs/latest/graphql/core/hasura-cli/hasura_console.html) is an admin dashboard to manage the connected database and to try out GraphQL APIs.

Served by:
1. Hasura GraphQL Engine:
   The console is served by GraphQL Engine at `/console` endpoint (when `--enable-console` flag is used). Typically runs in **No Migration Mode** which means that actions on the console are not spitting out migration “yaml” files automatically. Most users will be using the Hasura console in this mode.

2. Hasura CLI:
   Served by the Hasura CLI using `hasura console` command, typically runs with migration mode **enabled**. All the changes to schema/hasura metadata will be tracked and spit out on the filesystem as migration yaml files and a metadata yaml file. This allows for easy version controlling of the schema/hasura metadata.


### Dockerized version of Hasura Console

If you're running the console in a docker container, you can work around it by installing `socat` and running:

```
socat TCP-LISTEN:8080,fork TCP:host.docker.internal:8080 & hasura console --console-port 8081
```

Assuming you published port `8080` from `graphql-engine`, this will let the console communicate with the engine on `localhost:8080`. You'll be able to access the console from the browser on `http://localhost:8081`.

### Update hasura-console version

You can publish a new version of hasura-console using gitlab pipeline. It updates the `package.json` version. (You have to do it manually)

After publishing a new version of hasura-console you need to update the hasura-console section in the `docker-compose.yml` file of your project.

``` yml
hasura-console:
    image: <Put your new image here>
    ports:
      - "9693:9693"
      - "9695:9695"
    volumes:
      - ./hasura-migrations:/usr/src/hasura/app
    environment:
      HASURA_GRAPHQL_DATABASE_URL: postgres://postgres:${POSTGRES_PASSWORD:-postgres}@hasura-db:5432/postgres
      HASURA_GRAPHQL_ADMIN_SECRET: "${HASURA_ADMIN_SECRET:-hasura}"
      HASURA_GRAPHQL_ENDPOINT: http://127.0.0.1:8080
      HASURA_APPLY_MIGRATIONS: "true"
      HASURA_APPLY_METADATA: "true"
      HASURA_APPLY_SEEDS: "true"
      HASURA_RUN_CONSOLE: "true"
    restart: unless-stopped
    depends_on:
      hasura-engine:
        condition: service_healthy

  hasura-apply:
    image: <Put your new image here>
    volumes:
      - ./hasura-migrations:/usr/src/hasura/app
    environment:
      HASURA_GRAPHQL_DATABASE_URL: postgres://postgres:${POSTGRES_PASSWORD:-postgres}@hasura-db:5432/postgres
      HASURA_GRAPHQL_ADMIN_SECRET: "${HASURA_ADMIN_SECRET:-hasura}"
      HASURA_GRAPHQL_ENDPOINT: http://127.0.0.1:8080
      HASURA_APPLY_MIGRATIONS: "true"
      HASURA_APPLY_METADATA: "true"
      HASURA_APPLY_SEEDS: "true"
    depends_on:
      hasura-engine:
        condition: service_healthy

  hasura-export:
    image: <Put your new image here>
    volumes:
      - ./hasura-migrations:/usr/src/hasura/app
    environment:
      HASURA_GRAPHQL_DATABASE_URL: postgres://postgres:${POSTGRES_PASSWORD:-postgres}@hasura-db:5432/postgres
      HASURA_GRAPHQL_ADMIN_SECRET: "${HASURA_ADMIN_SECRET:-hasura}"
      HASURA_GRAPHQL_ENDPOINT: http://127.0.0.1:8080
      HASURA_EXPORT_METADATA: "true"
      HASURA_EXPORT_DATABASE: "false"
    depends_on:
      hasura-engine:
        condition: service_healthy

```
