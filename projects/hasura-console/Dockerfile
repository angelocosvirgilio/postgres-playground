FROM hasura/graphql-engine:v2.35.1.cli-migrations-v3

# Install dependencies and link stuff:
RUN apt-get update -y && apt-get install -y curl socat
RUN ln -s /bin/hasura-cli /usr/bin/hasura

# Add the start script:
WORKDIR /usr/src/hasura
ADD start.sh start.sh
RUN chmod +x start.sh

CMD "./start.sh"

EXPOSE 8080
  