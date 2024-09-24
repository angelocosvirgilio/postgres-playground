#!/bin/bash

HASURA_FOLDER=/usr/src/hasura/app
cd $HASURA_FOLDER || {
    echo "Hasura folder '$HASURA_FOLDER' not found"
    exit 1
}

# Workaround for:
# https://github.com/hasura/graphql-engine/issues/2824#issuecomment-801293056
socat TCP-LISTEN:8080,fork TCP:hasura-engine:8080 &
socat TCP-LISTEN:9695,fork,reuseaddr,bind=hasura-console TCP:127.0.0.1:9695 &
socat TCP-LISTEN:9693,fork,reuseaddr,bind=hasura-console TCP:127.0.0.1:9693 &
{
    # 
    # Exporting Scripts
    #

    if [[ -v HASURA_EXPORT_METADATA ]]
    then
        echo "Exporting metadata..."
        hasura metadata export --endpoint ${HASURA_GRAPHQL_ENDPOINT} --admin-secret ${HASURA_GRAPHQL_ADMIN_SECRET} --skip-update-check  || exit 1
    else
        echo "Skipping metadata export"
    fi
    
    if [[ -v HASURA_EXPORT_DATABASE ]]
    then
        echo "Exporting database..."
        hasura migrate create "full_schema" --from-server --endpoint ${HASURA_GRAPHQL_ENDPOINT} --admin-secret ${HASURA_GRAPHQL_ADMIN_SECRET} --database-name=default --skip-update-check  || exit 1
    else
        echo "Skipping database export"
    fi

    
    # 
    # Restoring Scripts
    #

    if [[ -v HASURA_APPLY_MIGRATIONS ]]
    then
        echo "Apply SQL migrations..."
        hasura migrate apply --endpoint ${HASURA_GRAPHQL_ENDPOINT} --admin-secret ${HASURA_GRAPHQL_ADMIN_SECRET} --database-name=default --skip-update-check  || exit 1
    else
        echo "Skipping migrations"
    fi

    if [[ -v HASURA_APPLY_METADATA ]]
    then
        echo "Apply Hasura metadata..."
        hasura metadata apply --endpoint ${HASURA_GRAPHQL_ENDPOINT} --admin-secret ${HASURA_GRAPHQL_ADMIN_SECRET} --skip-update-check
    else
        echo "Skipping metadata"
    fi

    if [[ -v HASURA_APPLY_SEEDS ]]
    then
        echo "Apply SQL seeds..."
        hasura seeds apply --endpoint ${HASURA_GRAPHQL_ENDPOINT} --admin-secret ${HASURA_GRAPHQL_ADMIN_SECRET} --database-name=default --file=default.sql --skip-update-check
    else
        echo "Skipping seeds"
    fi

    #
    # Run console if specified
    #

    if [[ -v HASURA_RUN_CONSOLE ]]
    then
        echo "Starting console..."
        hasura console --endpoint ${HASURA_GRAPHQL_ENDPOINT} --admin-secret ${HASURA_GRAPHQL_ADMIN_SECRET} --log-level DEBUG --address "127.0.0.1" --no-browser || exit 1
    else
        echo "Started without console"
        # tail -f /dev/null
    fi
}
