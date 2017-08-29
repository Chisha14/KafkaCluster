#!/bin/bash

# volume for saving Kafka server logs
export KAFKA_VOLUME="/tmp/kafka/"
# base name for Kafka server data dir and application logs
export KAFKA_LOG_BASE_NAME="kafka-log"
export KAFKA_APP_LOGS_BASE_NAME="logs"

#Generate a random number between 1 and 1000 and assign it to broker.id
#printf -v KAFKA_BROKER_ID '%d' $((1 + RANDOM % 1000)) 2>/dev/null
export IP_MACHINE=$(hostname -I | cut -d' ' -f1)
printf -v KAFKA_BROKER_ID '%d' $(echo $IP_MACHINE | sed 's/\.//g')

export MAX_BROKER_IDS=1000000000
# create data dir
export KAFKA_LOG_DIRS=$KAFKA_VOLUME$KAFKA_LOG_BASE_NAME$KAFKA_BROKER_ID
echo "KAFKA_LOG_DIRS=$KAFKA_LOG_DIRS"
echo $KAFKA_BROKER_ID
echo "MAX BROKERS " $MAX_BROKER_IDS
# starting Kafka server with final configuration
exec $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties \
--override broker.id=$KAFKA_BROKER_ID \
--override reserved.broker.max.id=$MAX_BROKER_IDS \
--override advertised.host.name=$(hostname -I) \
--override log.dirs=$KAFKA_LOG_DIRS \
