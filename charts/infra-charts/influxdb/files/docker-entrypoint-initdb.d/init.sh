    influx -username $INFLUXDB_ADMIN_USER -password $INFLUXDB_ADMIN_USER_PASSWORD -execute "show databases" | grep corrstate || influx -username $INFLUXDB_ADMIN_USER -password $INFLUXDB_ADMIN_USER_PASSWORD -execute "CREATE DATABASE corrstate"
    influx -username $INFLUXDB_ADMIN_USER -password $INFLUXDB_ADMIN_USER_PASSWORD -database corrstate -execute "show users" | grep corrolate_admin || influx -username $INFLUXDB_ADMIN_USER -password $INFLUXDB_ADMIN_USER_PASSWORD -database corrstate -execute "CREATE USER corrolate_admin WITH PASSWORD 'Center1ty12'"
    influx -username $INFLUXDB_ADMIN_USER -password $INFLUXDB_ADMIN_USER_PASSWORD -database corrstate -execute "GRANT ALL TO corrolate_admin"