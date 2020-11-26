#!/usr/bin/env sh

echo "Starting rtlamr2mqtt:"
echo "MQTT host: $MQTT_HOST"
echo "MQTT port: $MQTT_PORT"
echo "MQTT username: $MQTT_USERNAME"
echo "MQTT password: $MQTT_PASSWORD"
echo "Message type: $MSG_TYPE"
echo "Meter IDs: $METER_IDS"
echo "Sleep: $SLEEP"

while true; do
    rtl_tcp >/dev/null 2>&1 &
    sleep 10s
    rtlamr -format=json -single=true -MSG_TYPE="$MSG_TYPE" -filterid="$METER_IDS" | while read -r line; do
        TYPE=$(echo "$line" | jq -r '.Type')
        if [ "$TYPE" = "SCM" ] || [ "$TYPE" = "R900" ] || [ "$TYPE" = "R900BCD" ]; then
            meter_id=$(echo "$line" | jq -r '.Message.ID')
        elif [ "$TYPE" = "SCM+" ]; then
            meter_id=$(echo "$line" | jq -r '.Message.EndpointID')
        elif [ "$TYPE" = "IDM" ] || [ "$TYPE" = "NetIDM" ]; then
            meter_id=$(echo "$line" | jq -r '.Message.ERTSerialNumber')
        else
            meter_id='unknown'
        fi
        mqtt_topic="meter/$meter_id/reading"
        echo "Publishing to mqtt topic $mqtt_topic: $line"
        mosquitto_pub -h "$MQTT_HOST" -p "$MQTT_PORT" -u "$MQTT_USERNAME" -P "$MQTT_PASSWORD" -t "$mqtt_topic" -m "$line" -i rtlamr2mqtt -r
    done
    echo "Stopping rtl_tcp..."
    pkill rtl_tcp
    echo "Sleeping for $SLEEP"
    sleep $SLEEP
done
